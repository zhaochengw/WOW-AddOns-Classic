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
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded

BG.Init(function()
    -- 时光徽章价格
    do
        BiaoGe.marketPrice = BiaoGe.marketPrice or {}
        local saveCD = 60 * 60 * 3
        local saveMaxCount = 20

        local function CreateHistoryFrame(self)
            if not self.currentPrice then return end
            local titleWidth = 130
            local barWidth = 200
            local priceWidth = 100
            local frameWidth = titleWidth + barWidth + priceWidth + 20
            local barHeight = 18
            local _max, _min = 0, 0
            for i, v in ipairs(BiaoGe.marketPrice) do
                _max = max(v.price, _max)
                _min = min(v.price, _min)
            end
            local f = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:SetBackdropBorderColor(1, 1, 1, .5)
            f:SetSize(500, 300)
            f:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 0)
            f:SetFrameStrata("HIGH")
            f:SetClampedToScreen(true)
            f.buttons = {}
            self.frame = f
            local toptitle = f:CreateFontString()
            toptitle:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            toptitle:SetPoint("TOP", f, "TOP", 0, -5)
            toptitle:SetTextColor(0, .75, 1)
            toptitle:SetText(AddTexture(1120721) .. L["时光徽章历史价格"])

            local function CreateBar(i, v, isNow)
                local title = f:CreateFontString()
                title:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
                title:SetSize(titleWidth, barHeight)
                if next(f.buttons) then
                    title:SetPoint("TOPLEFT", f.buttons[i - 1], "BOTTOMLEFT", 0, 0)
                else
                    title:SetPoint("TOPLEFT", f, "TOPLEFT", 5, -30)
                end
                title:SetTextColor(1, 1, 1)
                title:SetText(isNow and L["现在"] or date("%m-%d %H:%M", v.time))
                title:SetJustifyH("RIGHT")
                title:SetWordWrap(false)
                tinsert(f.buttons, title)

                local bar = CreateFrame("Frame", nil, f, "BackdropTemplate")
                bar:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                })
                bar:SetBackdropColor(1, 1, 0,.8)
                bar:SetPoint("LEFT", title, "RIGHT", 5, 0)
                local widthPercent = v.price / _max
                if widthPercent ~= 1 then
                    widthPercent = widthPercent * widthPercent
                end
                local width
                if widthPercent == 0 then
                    width = 5
                else
                    width = barWidth * widthPercent
                end
                bar:SetSize(width, 14)

                local price = f:CreateFontString()
                price:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
                price:SetSize(priceWidth, 20)
                price:SetPoint("LEFT", bar, "RIGHT", 5, 0)
                price:SetTextColor(1, 0.82, 0)
                price:SetText(GetMoneyString(v.price, true))
                price:SetJustifyH("LEFT")
                price:SetWordWrap(false)
            end
            for i, v in ipairs(BiaoGe.marketPrice) do
                CreateBar(i, v)
            end
            CreateBar(#BiaoGe.marketPrice + 1, { price = self.currentPrice or 0 }, true)

            local text
            local moneyTitle, money
            if not BG.IsTW then
                moneyTitle = "¥"
                money = 90
            else
                moneyTitle = "HK$"
                money = 150
            end
            local m1 = self.currentPrice / money / 10000
            m1 = floor(m1) * 10000
            text = moneyTitle .. "1 = " .. GetMoneyString(m1, true)
            local m2 = money / (self.currentPrice / 10000)
            if BG.IsRetail then
                m2 = format("%.6f", m2)
            else
                m2 = format("%.4f", m2)
            end
            text = text .. "   " .. GetMoneyString(10000, true) .. " = " .. m2 .. moneyTitle
            local bottomText = f:CreateFontString()
            bottomText:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
            bottomText:SetPoint("BOTTOM", f, "BOTTOM", 0, 8)
            bottomText:SetTextColor(1, .85, 0)
            bottomText:SetText(text)

            f:SetSize(frameWidth, (#f.buttons + 1) * barHeight + 40)
        end

        local bt = CreateFrame("Frame", nil, BG.MainFrame)
        bt:SetSize(1, 20)
        bt:SetPoint("BOTTOMLEFT", 10, 2)
        bt.text = bt:CreateFontString()
        bt.text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
        bt.text:SetPoint("LEFT")
        bt.text:SetTextColor(1, 1, 1)
        BG.OnEnterDelay(bt, CreateHistoryFrame,0)
        BG.OnLeaveDelay(bt, function(self)
            if self.frame then
                self.frame:Hide()
            end
        end)
        BG.ButtonToken = bt

        local function SavePrice(currentPrice)
            if not next(BiaoGe.marketPrice) or
                GetServerTime() - BiaoGe.marketPrice[#BiaoGe.marketPrice].time > saveCD then
                tinsert(BiaoGe.marketPrice, {
                    time = GetServerTime(),
                    price = currentPrice,
                })
                if #BiaoGe.marketPrice > saveMaxCount then
                    for i = #BiaoGe.marketPrice - saveMaxCount, 1, -1 do
                        tremove(BiaoGe.marketPrice, i)
                    end
                end
            end
        end
        local function OnTokenMarketPriceUpdated(event, result)
            local currentPrice = C_WowTokenPublic.GetCurrentMarketPrice()
            if currentPrice then
                SavePrice(currentPrice)
                bt.currentPrice = currentPrice
                bt.text:SetText(AddTexture(1120721) .. GetMoneyString(currentPrice, true))
                bt:SetWidth(bt.text:GetWidth() + 10)
            else
                bt.text:SetText("")
                bt:SetWidth(1)
            end
        end
        BG.RegisterEvent("TOKEN_MARKET_PRICE_UPDATED", OnTokenMarketPriceUpdated)

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

    -- 在线玩家数
    if BG.IsTW then
        BG.Init2(function()
            if not IsAddOnLoaded("Blizzard_Communities") then
                UIParentLoadAddOn("Blizzard_Communities")
            end
        end)

        local World = LOOK_FOR_GROUP

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

        local bt = CreateFrame("Button", nil, BG.MainFrame)
        bt:SetSize(1, 20)
        bt:SetPoint("LEFT", BG.ButtonToken, "RIGHT", 0, 0)
        bt:SetNormalFontObject(BG.FontWhite13)
        bt:SetText(AddTexture(135994) .. L["待刷新"])
        bt:GetFontString():SetPoint("LEFT")
        bt:SetWidth(bt:GetFontString():GetWidth() + 10)
        bt.channel = World
        BG.OnEnterDelay(bt, OnEnter,0)
        BG.OnLeaveDelay(bt, OnLeave)
        bt:SetScript("OnClick", function(self)
            BG.GetChannelMemberCount(self.channel)
            BG.PlaySound(1)
        end)
        BG.ButtonOnLineCount = bt

        function BG.GetChannelMemberCount(channelName)
            local channels = { GetChannelList() }
            for i = 1, #channels, 3 do
                if channels[i + 1] == channelName then
                    if ChannelFrame:IsShown() then
                        HideUIPanel(ChannelFrame)
                    end
                    ChannelFrame.targetChannel = channelName
                    ShowUIPanel(ChannelFrame)
                    return
                end
            end
        end

        hooksecurefunc(ChannelFrame.ChannelList, 'AddChannelButtonInternal', function(_, channelbt, _, name, _, channelID)
            if name == ChannelFrame.targetChannel then
                BG.After(0.3, function()
                    ChannelFrame.ChannelList:SetSelectedChannel(channelbt)
                    BG.After(1, function()
                        local _, _, _, _, count = GetChannelDisplayInfo(channelbt.channelID)
                        if count then
                            bt.count = count
                            local m, s = GetGameTime()
                            s = format("%02d", s)
                            bt.time = m .. ":" .. s
                            bt:SetText(AddTexture(135994) .. count .. L["人"])
                            bt:GetFontString():SetPoint("LEFT")
                            bt:SetWidth(bt:GetFontString():GetWidth() + 10)
                            if bt.isOnEnter then
                                OnEnter(bt)
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
