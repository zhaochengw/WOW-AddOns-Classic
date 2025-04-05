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

local pt = print
local RealmID = GetRealmID()
local player = BG.playerName

BG.Init(function()
    BiaoGe.options.showGuoQiFrame = BiaoGe.options.showGuoQiFrame or 0
    BiaoGe.lastGuoQiTime = BiaoGe.lastGuoQiTime or 0

    local function GetMaxButton()
        return floor((BG.FBHeight[BG.FB1] - 35) / 20 - 1)
    end
    local maxButton = GetMaxButton()
    local notItem

    local bt = CreateFrame("Button", nil, BG.MainFrame)
    do
        bt:SetPoint("LEFT", BG.ButtonAuctionLog, "RIGHT", BG.TopLeftButtonJianGe, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(L["装备过期"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        BG.ButtonGuoQi = bt
        bt:SetScript("OnClick", function(self)
            if BG.itemGuoQiFrame:IsVisible() then
                BiaoGe.options.showGuoQiFrame = 0
                BG.itemGuoQiFrame:Hide()
            else
                BiaoGe.options.showGuoQiFrame = 1
                BG.itemGuoQiFrame:Show()
            end
            BG.PlaySound(1)
        end)
        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["显示背包里的团本装备还有多久不能交易（过期）。"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", GameTooltip_Hide)
    end

    local f = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
    do
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        f:SetBackdropColor(0, 0, 0, 0.8)
        f:SetBackdropBorderColor(GetClassRGB(nil, "player", BG.borderAlpha))
        f:SetSize(200, BG.FBHeight[BG.FB1])
        f:SetPoint("TOPLEFT", BG.MainFrame, "TOPRIGHT", -1, 0)
        f:EnableMouse(true)
        BG.itemGuoQiFrame = f
        BG.itemGuoQiFrame.maxButton=maxButton
        if BiaoGe.options.showGuoQiFrame ~= 1 then
            f:Hide()
        else
            f:Show()
        end
        f:SetScript("OnMouseUp", function(self)
            BG.MainFrame:GetScript("OnMouseUp")(BG.MainFrame)
        end)
        f:SetScript("OnMouseDown", function(self)
            BG.MainFrame:GetScript("OnMouseDown")(BG.MainFrame)
        end)
        f:SetScript("OnShow", function(self)
            BG.UpdateItemGuoQiFrame()
            self:RegisterEvent("BAG_UPDATE_DELAYED")
        end)
        f:SetScript("OnHide", function(self)
            self:UnregisterEvent("BAG_UPDATE_DELAYED")
        end)
        f:SetScript("OnEvent", function(self)
            BG.After(0.2, function()
                BG.UpdateItemGuoQiFrame()
            end)
        end)

        f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
        f.CloseButton:SetPoint("TOPRIGHT", f, "TOPRIGHT",  BG.IsRetail and 0 or 4,  BG.IsRetail and 0 or 4)
        f.CloseButton:HookScript("OnClick", function(self)
            BiaoGe.options.showGuoQiFrame = 0
        end)

        local t = f:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("TOP", f, "TOP", 0, -5)
        t:SetText(L["装备过期剩余时间"])
    end

    BG.itemGuoQiFrame.tbl = {}
    BG.itemGuoQiFrame.buttons = {}

    local function UpdateFrameSize()
        BG.itemGuoQiFrame:SetHeight(BG.FBHeight[BG.FB1])
        maxButton = GetMaxButton()
    end

    function BG.UpdateItemGuoQiFrame()
        if not BG.itemGuoQiFrame:IsVisible() then return end
        UpdateFrameSize()
        wipe(BG.itemGuoQiFrame.tbl)
        for i, v in ipairs(BG.itemGuoQiFrame.buttons) do
            v:Hide()
        end
        wipe(BG.itemGuoQiFrame.buttons)
        if notItem then
            notItem:Hide()
        end

        for b = 0, NUM_BAG_SLOTS do
            for i = 1, C_Container.GetContainerNumSlots(b) do
                local link = C_Container.GetContainerItemLink(b, i)
                if link then
                    local itemID = GetItemInfoInstant(link)
                    BiaoGeTooltip3:SetOwner(UIParent, "ANCHOR_NONE", 0, 0)
                    BiaoGeTooltip3:ClearLines()
                    BiaoGeTooltip3:SetBagItem(b, i)

                    local ii = 1
                    while _G["BiaoGeTooltip3TextLeft" .. ii] do
                        local tx = _G["BiaoGeTooltip3TextLeft" .. ii]:GetText()
                        if tx then
                            local time = tx:match(BIND_TRADE_TIME_REMAINING:gsub("%%s", "(.+)"))
                            if time then
                                local h = tonumber(time:match("(%d+)" .. L["小时"]))
                                local m = tonumber(time:match("(%d+)" .. L["分钟"]))
                                local time = 0
                                if h then
                                    time = time + h * 60
                                end
                                if m then
                                    time = time + m
                                end

                                tinsert(BG.itemGuoQiFrame.tbl, { time = time, link = link, itemID = itemID, b = b, i = i })
                                break
                            end
                        end
                        ii = ii + 1
                    end
                end
            end
        end
        -- test
--[[        BG.itemGuoQiFrame.tbl = {
            { time = 120, link = "|cffa335ee|Hitem:45485::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45485, b = 0, i = 1 },
            { time = 90, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            -- { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            -- { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            -- { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            -- { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            -- { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            -- { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            -- { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
            -- { time = 28, link = "|cffa335ee|Hitem:45289::::::::80:::::::::|h[生命火花面甲]|h|r", itemID = 45289, b = 0, i = 1 },
        } ]]
        sort(BG.itemGuoQiFrame.tbl, function(a, b)
            return a.time < b.time
        end)

        for ii, vv in ipairs(BG.itemGuoQiFrame.tbl) do
            if ii > maxButton then
                local lastbt = BG.itemGuoQiFrame.buttons[ii - 1]
                local t = lastbt:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                t:SetPoint("TOPLEFT", lastbt, "BOTTOMLEFT", 0, 0)
                t:SetJustifyH("LEFT")
                t:SetTextColor(1, 0.82, 0)
                t:SetText("......")
                return
            end
            local link, itemID, time, b, i = vv.link, vv.itemID, vv.time, vv.b, vv.i

            local f = CreateFrame("Frame", nil, BG.itemGuoQiFrame, "BackdropTemplate")
            f:SetSize(BG.itemGuoQiFrame:GetWidth()-4, 20)
            if ii == 1 then
                f:SetPoint("TOPRIGHT", BG.itemGuoQiFrame, "TOPRIGHT", -2, -30)
            else
                f:SetPoint("TOPRIGHT", BG.itemGuoQiFrame.buttons[ii - 1], "BOTTOMRIGHT", 0, 0)
            end
            f:EnableMouse(true)
            f:Show()
            f.link = link
            f.itemID = itemID
            f.time = time
            f.b = b
            f.i = i
            tinsert(BG.itemGuoQiFrame.buttons, f)
            BG.UpdateFilter(f, link)

            local tex = f:CreateTexture(nil, "BACKGROUND")
            tex:SetAllPoints()
            if ii % 2 == 0 then
                tex:SetColorTexture(.5, .5, .5, .15)
            else
                tex:SetColorTexture(0, 0, 0, .25)
            end

            local ds = f:CreateTexture()
            ds:SetAllPoints()
            ds:SetColorTexture(.5, .5, .5, .5)
            ds:Hide()

            f:SetScript("OnMouseDown", function(self, button)
                if IsShiftKeyDown() then
                    BG.PlaySound(1)
                    BG.InsertLink(link)
                end
            end)
            f:SetScript("OnEnter", function(self)
                ds:Show()
                GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:SetBagItem(b, i)
                BG.Show_AllHighlight(link, "outtime")
                BG.SetHistoryMoney(itemID)
            end)
            f:SetScript("OnLeave", function()
                ds:Hide()
                GameTooltip:Hide()
                BG.Hide_AllHighlight()
                BG.HideHistoryMoney()
            end)

            local icon = f:CreateTexture(nil, 'ARTWORK')
            icon:SetPoint('LEFT', 1, 0)
            icon:SetSize(16, 16)
            icon:SetTexture(select(5, GetItemInfoInstant(link)))

            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("LEFT", 18, 0)
            t:SetJustifyH("LEFT")
            t:SetText(link:gsub("%[",""):gsub("%]",""))
            t:SetWidth(90)
            t:SetWordWrap(false)

            local sb = CreateFrame("StatusBar", nil, f)
            sb:SetPoint("LEFT",t,"RIGHT", 2, 0)
            sb:SetSize(55, 15)
            sb:SetMinMaxValues(0, 120)
            sb:SetValue(time)
            sb:SetStatusBarTexture("Interface\\Buttons\\WHITE8x8")
            if time >= 30 then
                sb:SetStatusBarColor(0, 1, 0)
            else
                sb:SetStatusBarColor(1, 0, 0)
            end

            local t = sb:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            t:SetPoint("LEFT", sb:GetWidth() * time / 120, 0)
            t:SetText(time .. "m")
            if time >= 30 then
                t:SetTextColor(0, 1, 0)
            else
                t:SetTextColor(1, 0, 0)
            end
        end
        if #BG.itemGuoQiFrame.tbl == 0 then
            local t = BG.itemGuoQiFrame:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOP", f, "TOP", 0, -30)
            t:SetWidth(BG.itemGuoQiFrame:GetWidth() - 20)
            t:SetText(L["背包里没有可交易的装备。"])
            t:SetTextColor(1, 0, 0)
            notItem = t
        end
    end

    C_Timer.NewTicker(30, function()
        if BG.itemGuoQiFrame:IsVisible() or (BiaoGe.options.guoqiRemind == 1 and BG.IsML) then
            BG.UpdateItemGuoQiFrame()
        end

        if BiaoGe.options.guoqiRemind == 1 and BG.IsML then
            for i, v in ipairs(BG.itemGuoQiFrame.tbl) do
                if v.time < BiaoGe.options.guoqiRemindMinTime then
                    if GetServerTime() - BiaoGe.lastGuoQiTime >= 300 then
                        BiaoGe.lastGuoQiTime = GetServerTime()
                        local link = "|cffFFFF00|Hgarrmission:" .. "BiaoGeGuoQi:" .. L["详细"] ..
                            "|h[" .. L["详细"] .. "]|h|r"
                        local link2 = "|cffFFFF00|Hgarrmission:" .. "BiaoGeGuoQi:" .. L["设置为1小时内不再提醒"] ..
                            "|h[" .. L["设置为1小时内不再提醒"] .. "]|h|r"
                        local msg = BG.STC_r1(format(L["你有装备快过期了。%s %s"], link, link2))
                        BG.FrameLootMsg:AddMessage(msg)
                        PlaySoundFile(BG["sound_guoqi" .. BiaoGe.options.Sound], "Master")
                        return
                    end
                end
            end
        end
    end)
end)
