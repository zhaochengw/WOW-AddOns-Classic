if BG.IsBlackListPlayer then return end

local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local RGB_16 = ns.RGB_16
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local GetText_T = ns.GetText_T
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local Maxb = ns.Maxb

local pt = print
local realmID = GetRealmID()
local player = BG.playerName
local realmName = GetRealmName()
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded

BG.Init(function()
    -- 时光徽章价格
    do
        local function OnEnter(self)
            if self.currentPrice then
                local currentPrice = self.currentPrice
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["当前时光徽章"], 1, 1, 1, true)
                GameTooltip:AddLine(GetMoneyString(currentPrice, false), 1, 0.82, 0, true)
                if BG.IsWLK or BG.IsRetail then
                    GameTooltip:AddLine(" ", 1, 1, 1, true)
                    local m1 = currentPrice / 90 / 10000
                    m1 = floor(m1) * 10000
                    GameTooltip:AddLine("￥1 = " .. GetMoneyString(m1, false), 1, 0.82, 0, true)
                    local m2 = 90 / (currentPrice / 10000)
                    if BG.IsRetail then
                        m2 = format("%.6f", m2)
                    else
                        m2 = format("%.4f", m2)
                    end
                    GameTooltip:AddLine(GetMoneyString(10000, false) .. " = " .. m2 .. "￥", 1, 0.82, 0, true)
                end
                GameTooltip:Show()
            end
        end

        local f = CreateFrame("Frame", nil, BG.MainFrame)
        f:SetSize(1, 20)
        f:SetPoint("BOTTOMLEFT", 10, 2)
        f.text = f:CreateFontString()
        f.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
        f.text:SetPoint("LEFT")
        f.text:SetTextColor(1, 1, 1)
        f:SetScript("OnEnter", OnEnter)
        f:SetScript("OnLeave", GameTooltip_Hide)
        BG.ButtonToken = f

        if not BG.IsVanilla then
            local function OnTokenMarketPriceUpdated(event, result)
                if C_WowTokenPublic.GetCurrentMarketPrice() then
                    local currentPrice = C_WowTokenPublic.GetCurrentMarketPrice()
                    f.currentPrice = currentPrice
                    f.text:SetText(AddTexture(1120721) .. GetMoneyString(currentPrice, false))
                    f:SetWidth(f.text:GetWidth() + 10)
                else
                    f.text:SetText("")
                    f:SetWidth(1)
                end
            end
            local frame = CreateFrame("Frame")
            frame:RegisterEvent("TOKEN_MARKET_PRICE_UPDATED")
            frame:SetScript("OnEvent", OnTokenMarketPriceUpdated)

            BG.Init2(function()
                C_Timer.After(2, function()
                    C_WowTokenPublic.UpdateMarketPrice()
                    OnTokenMarketPriceUpdated()
                end)
            end)
            C_Timer.NewTicker(60, function()
                C_WowTokenPublic.UpdateMarketPrice()
            end)
        end
    end

    -- 在线玩家数
    if BG.IsVanilla_Sod or BG.IsCTM then
        BG.Init2(function()
            if not IsAddOnLoaded("Blizzard_Communities") then
                UIParentLoadAddOn("Blizzard_Communities")
            end
        end)

        -- local World = "BiaoGeYY"
        local World = LOOK_FOR_GROUP
        -- local World = "大脚世界频道"

        local function GetFactionName()
            if UnitFactionGroup("player") == "Alliance" then
                return FACTION_ALLIANCE
            else
                return FACTION_HORDE
            end
        end
        local function OnEnter(self)
            self.isOnEnter = true
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(format(L["%s在线人数"], GetFactionName()), 1, 1, 1, true)
            if self.count then
                GameTooltip:AddLine(self.count .. L["人"] .. format(L["（获取时间：%s）"], self.time), 1, 0.82, 0, true)
            else
                local yes
                local channels = { GetChannelList() }
                for i = 1, #channels, 3 do
                    if channels[i + 1] == World then
                        yes = true
                        break
                    end
                end
                if yes then
                    GameTooltip:AddLine(L["未刷新"], 0.5, 0.5, 0.5, true)
                else
                    GameTooltip:AddLine(format(L["你未加入%s，无法获取在线人数。"], World), 0.5, 0.5, 0.5, true)
                end
            end
            GameTooltip:AddLine(L["<点击刷新>"], 0, 1, 0, true)

            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(format(L["数据来源："]), 1, 1, 1, true)
            GameTooltip:AddLine(format(L["%s在线人数"], World), 1, 0.82, 0, true)
            GameTooltip:Show()
        end
        local function OnLeave(self)
            self.isOnEnter = false
            GameTooltip:Hide()
        end

        local f = CreateFrame("Button", nil, BG.MainFrame)
        f:SetSize(1, 20)
        f:SetPoint("LEFT", BG.ButtonToken, "RIGHT", 0, 0)
        f:SetNormalFontObject(BG.FontWhite13)
        f:SetText(AddTexture(135994) .. L["待刷新"])
        f:GetFontString():SetPoint("LEFT")
        f:SetWidth(f:GetFontString():GetWidth() + 10)
        f.channel = World
        f:SetScript("OnEnter", OnEnter)
        f:SetScript("OnLeave", OnLeave)
        f:SetScript("OnClick", function(self)
            BG.GetChannelMemberCount(self.channel)
            BG.PlaySound(1)
        end)
        BG.ButtonOnLineCount = f

        function BG.GetChannelMemberCount(channelName)
            local yes
            local channels = { GetChannelList() }
            for i = 1, #channels, 3 do
                if channels[i + 1] == channelName then
                    yes = true
                    break
                end
            end
            if yes then
                if ChannelFrame:IsShown() then
                    HideUIPanel(ChannelFrame)
                end
                ChannelFrame.targetChannel = channelName
                ShowUIPanel(ChannelFrame)
            end
        end

        hooksecurefunc(ChannelFrame.ChannelList, 'AddChannelButtonInternal', function(_, bt, _, name, _, channelID)
            if name == ChannelFrame.targetChannel then
                BG.After(0.3, function()
                    ChannelFrame.ChannelList:SetSelectedChannel(bt)
                    BG.After(1, function()
                        local _, _, _, _, count = GetChannelDisplayInfo(bt.channelID)
                        if count then
                            f.count = count
                            local m, s = GetGameTime()
                            s = format("%02d", s)
                            f.time = m .. ":" .. s
                            f:SetText(AddTexture(135994) .. count .. L["人"])
                            f:GetFontString():SetPoint("LEFT")
                            f:SetWidth(f:GetFontString():GetWidth() + 10)
                            if f.isOnEnter then
                                OnEnter(f)
                            end
                        end
                        for k, bt in ipairs(ChannelFrame.ChannelList.buttons) do
                            if bt.name == CHANNEL_CATEGORY_WORLD then
                                ChannelFrame.ChannelList:SetSelectedChannel(bt)
                                return
                            end
                        end
                    end)
                end)
                ChannelFrame.targetChannel = nil
                HideUIPanel(ChannelFrame)
            end
        end)
    end
end)
