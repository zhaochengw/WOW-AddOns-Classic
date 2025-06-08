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
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print
local RealmId = GetRealmID()
local player = BG.playerName

BG.tradeQuality = 0
BG.trade = {}
BG.trade.player = BG.playerName
BG.trade.many = {}
BG.trade.playerinfo = {}
BG.trade.targetinfo = {}
BG.trade.targetitems = {}
BG.trade.playeritems = {}

BG.TradeMyMoneyChange = {}

local goldTex = "|A:auctionhouse-icon-coin-gold:0:0|a"
BG.Init(function()
    -- 交易自动记录买家和金额
    do
        function BG.ResetTradeInfo()
            BG.trade.many = {}
            BG.trade.playerinfo = {}
            BG.trade.targetinfo = {}
            BG.trade.targetmoney = 0
            BG.trade.playermoney = 0
            BG.trade.target = BG.GN("NPC")
            wipe(BG.trade.targetitems)
            wipe(BG.trade.playeritems)
        end

        function BG.GetTradeInfo()
            BG.ResetTradeInfo()
            BG.trade.target = BG.GN("NPC")
            BG.trade.targetmoney = floor(GetTargetTradeMoney() / 10000)
            BG.trade.playermoney = floor(GetPlayerTradeMoney() / 10000)
            for k, v in pairs(BG.playerClass) do
                BG.trade.playerinfo[k] = select(v.select, v.func("player"))
                BG.trade.targetinfo[k] = select(v.select, v.func("NPC"))
            end

            BG.tradeQianKuanListFrame.hasItem = nil
            for i = 1, 6 do
                local targetitem = GetTradeTargetItemLink(i)
                local name, texture, quantity, quality, isUsable, enchant = GetTradeTargetItemInfo(i)
                if targetitem and quality >= BG.tradeQuality then
                    table.insert(BG.trade.targetitems, { link = targetitem, count = quantity })
                    BG.tradeQianKuanListFrame.hasItem = true
                end

                local playeritem = GetTradePlayerItemLink(i)
                local name, texture, quantity, quality, isUsable, enchant = GetTradePlayerItemInfo(i)
                if playeritem and quality >= BG.tradeQuality then
                    table.insert(BG.trade.playeritems, { link = playeritem, count = quantity })
                    BG.tradeQianKuanListFrame.hasItem = true
                end
            end

            BG.TradeIsAutoAuction()
        end

        local function CancelGuanZhuAndHope(itemID)
            local name, link = GetItemInfo(itemID)
            local haveguanzhu, havehope
            for _, FB in pairs(BG.FBtable) do
                for b = 1, Maxb[FB] do
                    for i = 1, BG.GetMaxi(FB, b) do
                        local bt = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                        if bt then
                            local _itemID = GetItemID(bt:GetText())
                            if _itemID == itemID then
                                if BiaoGe[FB]["boss" .. b]["guanzhu" .. i] then
                                    BiaoGe[FB]["boss" .. b]["guanzhu" .. i] = nil
                                    BG.Frame[FB]["boss" .. b]["guanzhu" .. i]:Hide()
                                    haveguanzhu = true
                                end
                            end
                        end
                    end
                end
                for n = 1, HopeMaxn[FB] do
                    for b = 1, HopeMaxb[FB] do
                        for i = 1, HopeMaxi do
                            local bt = BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                            if bt then
                                local _itemID = GetItemID(bt:GetText())
                                if _itemID == itemID then
                                    bt:SetText("")
                                    BiaoGe.Hope[RealmId][player][FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] = nil
                                    havehope = true
                                end
                            end
                        end
                    end
                end
            end
            BG.UpdateItemLib_LeftHope(itemID, 0)
            BG.UpdateItemLib_RightHope(itemID, 0)

            if haveguanzhu and havehope then
                BG.SendSystemMessage(format(L["已自动取消%s的关注和心愿。"], name))
            elseif haveguanzhu then
                BG.SendSystemMessage(format(L["已自动取消%s的关注。"], name))
            elseif havehope then
                BG.SendSystemMessage(format(L["已自动取消%s的心愿。"], name))
            end
        end

        function BG.GetTradeSeeText(saved)
            local FB = BG.FB1
            local target = BG.trade.target
            local player = BG.trade.player
            local targetmoney = BG.trade.targetmoney
            local playermoney = BG.trade.playermoney
            local targetitems = BG.trade.targetitems
            local playeritems = BG.trade.playeritems
            local returntext = ""
            BG.tradeSeeFrame.frame:SetNormalColor()
            if not BG.tradeSeeFrame.CheckButton:GetChecked() then
                return returntext
            end
            -- 双方都给出装备
            if targetitems[1] and playeritems[1] and targetmoney == 0 and playermoney == 0 then --双方都有装备，但没金额，这种是交易失败
                returntext = ("|cffDC143C" .. L["< 交易记账失败 >"] .. RN .. L["双方都给了装备，但没金额"] .. NN .. L["我不知道谁才是买家"] .. NN .. NN .. L["如果有金额我就能识别了"])
                BG.tradeSeeFrame.frame:SetFalseColor()
                return returntext
            end

            -- 使用自动拍卖的记账
            if next(BG.trade.autoAuction) then
                local returnText = ""
                for _, v in ipairs(BG.trade.autoAuction) do
                    local b = v.b
                    local i = v.i
                    local link = v.link
                    local itemID = GetItemID(link)
                    local player = v.player
                    local money = v.money
                    local qiankuan = v.qiankuan
                    local icon = select(5, GetItemInfoInstant(itemID))
                    local qiankuanText = ""
                    if qiankuan > 0 then
                        qiankuanText = format(L["|cffFF0000（欠款%d）|r"], qiankuan)
                    end
                    returnText = returnText .. AddTexture(icon) .. " |cffFFD700" .. money .. "|rg" .. qiankuanText .. "\n"
                    if saved then
                        -- 保存买家信息
                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetText(player)
                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetCursorPosition(0)
                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetTextColor(GetClassRGB(player))
                        BiaoGe[FB]["boss" .. b]["maijia" .. i] = player
                        for k in pairs(BG.playerClass) do
                            if player == BG.GN() then
                                BiaoGe[FB]["boss" .. b][k .. i] = BG.trade.playerinfo[k]
                            else
                                BiaoGe[FB]["boss" .. b][k .. i] = BG.trade.targetinfo[k]
                            end
                        end
                        -- 金额和欠款
                        BG.Frame[FB]["boss" .. b]["jine" .. i]:SetText(money)
                        BiaoGe[FB]["boss" .. b]["jine" .. i] = (money)
                        if qiankuan ~= 0 then
                            BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = qiankuan
                            BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Show()
                        end
                        -- 取消关注
                        if player == BG.GN() then
                            CancelGuanZhuAndHope(itemID)
                        end
                        -- 打包交易
                        local a = {
                            FB = FB,
                            itemID = itemID,
                            link = link,
                            b = b,
                            i = i
                        }
                        tinsert(BG.trade.many, a)
                    end
                end
                BG.tradeSeeFrame.frame:SetGreenColor()
                return returnText
            end

            -- 非自动拍卖的记账
            local qiankuan = 0
            if BG.tradeQianKuanEdit and tonumber(BG.tradeQianKuanEdit:GetText()) then
                qiankuan = qiankuan + tonumber(BG.tradeQianKuanEdit:GetText())
            end
            local qiankuantext = ""
            if qiankuan ~= 0 then
                qiankuantext = format("|cffFF0000" .. L["（欠款%d）"] .. RR, qiankuan)
            end

            local Items, Money, Items2, Money2, Player
            for ii = 1, 2 do
                if ii == 1 then -- 玩家给出金额，得到装备（玩家买装备情景）:1、双方都有装备，但玩家出了金
                    Items = targetitems
                    Items2 = playeritems
                    Money = playermoney
                    Money2 = targetmoney
                    Player = player
                elseif ii == 2 then -- 玩家给出装备，得到金钱（团长情景）
                    Items = playeritems
                    Items2 = targetitems
                    Money = targetmoney
                    Money2 = playermoney
                    Player = target
                end

                if (targetitems[1] and playeritems[1] and Money ~= 0) or (Items[1] and not Items2[1]) then
                    local isFirstItem = true
                    for items = 1, #Items do
                        local done
                        for b = 1, Maxb[FB] do
                            for i = 1, BG.GetMaxi(FB, b) do
                                local bt = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                                if bt and GetItemID(bt:GetText()) == GetItemID(Items[items].link) and
                                    BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetText() == "" and
                                    BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText() == "" and
                                    not BiaoGe[FB]["boss" .. b]["qiankuan" .. i]
                                then
                                    if saved then
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetText(Player)
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetCursorPosition(0)
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetTextColor(GetClassRGB(Player))
                                        BiaoGe[FB]["boss" .. b]["maijia" .. i] = Player
                                        for k in pairs(BG.playerClass) do
                                            if Player == BG.GN() then
                                                BiaoGe[FB]["boss" .. b][k .. i] = BG.trade.playerinfo[k]
                                            else
                                                BiaoGe[FB]["boss" .. b][k .. i] = BG.trade.targetinfo[k]
                                            end
                                        end
                                        if isFirstItem then
                                            BG.Frame[FB]["boss" .. b]["jine" .. i]:SetText(Money + qiankuan)
                                            BiaoGe[FB]["boss" .. b]["jine" .. i] = (Money + qiankuan)
                                            if qiankuan ~= 0 then
                                                BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = qiankuan
                                                BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Show()
                                            end
                                        else
                                            BG.Frame[FB]["boss" .. b]["jine" .. i]:SetText(L["打包交易"])
                                            BiaoGe[FB]["boss" .. b]["jine" .. i] = (L["打包交易"])
                                        end
                                        -- 取消关注
                                        if Player == BG.GN() then
                                            local itemID = GetItemID(bt:GetText())
                                            CancelGuanZhuAndHope(itemID)
                                        end
                                        if #Items > 1 then
                                            local a = {
                                                FB = FB,
                                                itemID = GetItemID(Items[items].link),
                                                link = Items[items].link,
                                                b = b,
                                                i = i
                                            }
                                            tinsert(BG.trade.many, a)
                                        end
                                    end
                                    if isFirstItem then
                                        local Texture = select(10, GetItemInfo(Items[items].link))
                                        returntext = (format("|cff00BFFF" ..
                                            L["< 交易记账成功 >|r\n装备：%s\n买家：%s\n金额：%s%d|rg%s\nBoss：%s%s|r"],
                                            (AddTexture(Texture) .. Items[items].link),
                                            SetClassCFF(Player), "|cffFFD700",
                                            Money + qiankuan,
                                            qiankuantext,
                                            "|cff" .. BG.Boss[FB]["boss" .. b]["color"],
                                            BG.Boss[FB]["boss" .. b]["name2"]))
                                    elseif not strfind(returntext, L["（剩余装备记录为打包交易）"]) then
                                        returntext = returntext .. NN .. BG.STC_dis(L["（剩余装备记录为打包交易）"])
                                    end
                                    isFirstItem = nil
                                    done = true
                                    break
                                end
                            end
                            if done then break end
                        end
                    end
                    if returntext ~= "" then
                        return returntext
                    end

                    returntext = ("|cffDC143C" .. L["< 交易记账失败 >"] .. RN .. L["表格里没找到此次交易的装备，或者该装备已记过账"])
                    BG.tradeSeeFrame.frame:SetFalseColor()
                    return returntext
                end
            end
            return returntext
        end
    end

    -- 欠款输入框/金币超上限/重复交易/团长交易状态/交易框对应的物品高亮
    do
        -- 交易欠款输入框
        do
            local f = CreateFrame("Frame", nil, TradeFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1.5
            })
            f:SetBackdropColor(0.5, 0, 0, 0.5)
            f:SetBackdropBorderColor(1, 0, 0, .5)
            f:SetSize(150, 25)
            f:SetPoint("BOTTOM", TradeRecipientMoneyBg, "TOP", 0, 3)
            f:SetToplevel(true)
            f:EnableMouse(true)
            f:SetFrameLevel(TradeRecipientMoneyBg:GetFrameLevel() + 10)

            local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            edit:SetSize(90, 20)
            edit:SetPoint("RIGHT", -5, 0)
            edit:SetText("")
            edit:SetTextColor(RGB("FF0000"))
            edit:SetNumeric(true)
            edit:SetAutoFocus(false)
            edit.frame = f
            edit:SetScript("OnTextChanged", function(self)
                BG.UpdateTwo0(self)
                BG.GetTradeInfo()
                BG.tradeSeeFrame.frame:Update()
            end)
            edit:SetScript("OnEnterPressed", function(self)
                self:ClearFocus()
            end)
            edit:SetScript("OnMouseDown", function(self, enter)
                if enter == "RightButton" then
                    self:SetEnabled(false)
                    self:SetText("")
                end
            end)
            edit:SetScript("OnMouseUp", function(self, enter)
                if enter == "RightButton" then
                    self:SetEnabled(true)
                end
            end)
            edit:HookScript("OnEditFocusGained", function(self)
                local f = BG.CreateNumFrame(TradeRecipientItem1ItemButton)
                if f then
                    f:ClearAllPoints()
                    f:SetPoint("TOP", self.frame, "BOTTOM", 0, 0)
                end
            end)
            edit:HookScript("OnEditFocusLost", function(self, button)
                if BG.FrameNumFrame then
                    BG.FrameNumFrame:Hide()
                end
            end)
            BG.tradeQianKuanEdit = edit

            local text = edit:CreateFontString()
            text:SetPoint("RIGHT", edit, "LEFT", -8, 0)
            text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
            text:SetTextColor(RGB("FF0000"))
            text:SetText(L["欠款："])

            function BG.tradeQianKuanEdit:Update()
                self.frame:SetShown(BiaoGe.options["autoTrade"] == 1 and IsInRaid(1))
                self:SetText("")
            end

            _G.TradeFrame:HookScript("OnMouseDown", function(self, enter)
                edit:ClearFocus()
            end)
        end

        -- 金币超上限
        do
            local f = CreateFrame("Frame", nil, TradeFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            f:SetBackdropColor(0, 0, 0, .9)
            f:SetBackdropBorderColor(1, 0, 0, 1)
            f:SetPoint("BOTTOMRIGHT", TradeRecipientMoneyBg, "TOPRIGHT", 0, 0)
            f:SetFrameStrata("HIGH")
            BG.tradeGoldTop = f
            local t = f:CreateFontString()
            t:SetPoint("CENTER")
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetTextColor(RGB(BG.r1))
            t:SetText(L["金币已超上限！"])
            f:SetSize(t:GetStringWidth() + 10, t:GetHeight() + 5)
            if BG.IsVanilla then
                BG.tradeGoldTop.topNum = 214745
            else
                BG.tradeGoldTop.topNum = 999999
            end

            function BG.tradeGoldTop:Update()
                self:Hide()
                if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradeMoneyTop"] == 1 and IsInRaid(1) then
                    local mymoney = floor(GetMoney() / 10000) or 0
                    local targetmoney = BG.trade.targetmoney or 0
                    if mymoney + targetmoney >= self.topNum then
                        self:Show()
                    end
                end
            end
        end

        -- 重复交易
        do
            local f = CreateFrame("Frame", nil, TradeFrame)
            f:SetFrameStrata("HIGH")
            local t = f:CreateFontString()
            t:SetPoint("RIGHT", BG.tradeQianKuanEdit.frame, "LEFT", -20, 0)
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetTextColor(RGB(BG.r1))
            t:SetText(L["重复交易！"])
            f:Hide()
            BG.tradeSameMoney = f
            BG.tradeSameMoney.trade = {}
            -- 提示
            local bt = CreateFrame("Button", nil, f)
            bt:SetSize(16, 16)
            bt:SetPoint("BOTTOMLEFT", t, "BOTTOMRIGHT", 0, 0)
            local tex = bt:CreateTexture()
            tex:SetPoint("CENTER")
            tex:SetSize(bt:GetWidth() + 10, bt:GetHeight() + 10)
            tex:SetTexture(616343)
            local tex = bt:CreateTexture()
            tex:SetPoint("CENTER")
            tex:SetSize(bt:GetWidth() + 10, bt:GetHeight() + 10)
            tex:SetTexture(616343)
            bt:SetHighlightTexture(tex)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["重复交易"], 1, 1, 1, true)
                GameTooltip:AddLine(format(L["你%s秒前曾交给他相同的金币！"], BG.tradeSameMoney.beforeTime), 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)

            function BG.tradeSameMoney:SaveTradeMoney()
                if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradeSameMoney"] == 1 and IsInRaid(1) then
                    if next(BG.trade.targetitems) or next(BG.trade.playeritems)
                        or (BG.trade.playermoney and BG.trade.playermoney == 0)
                        or not BG.trade.target
                    then
                        return
                    end
                    self.trade[BG.trade.target] = self.trade[BG.trade.target] or {}
                    tinsert(self.trade[BG.trade.target], {
                        time = time(),
                        money = BG.trade.playermoney,
                    })
                end
            end

            function BG.tradeSameMoney:Update()
                self:Hide()
                if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradeSameMoney"] == 1 and IsInRaid(1) then
                    local money = BG.trade.playermoney
                    local targetName = BG.trade.target
                    if not money or money == 0 or not targetName or not self.trade[targetName] then return end
                    local isSame
                    for _, v in ipairs(self.trade[targetName]) do
                        if v.money == money then
                            isSame = true
                            self.beforeTime = time() - v.time
                            break
                        end
                    end
                    if not isSame then return end
                    -- 交易框没有摆放任何物品
                    if next(BG.trade.targetitems) or next(BG.trade.playeritems) then
                        return
                    end
                    self:Show()
                    UIErrorsFrame:AddMessage(L["重复交易！"], 1, 0, 0)
                end
            end

            C_Timer.NewTicker(30, function()
                local time = time()
                for name in pairs(BG.tradeSameMoney.trade) do
                    for i = #BG.tradeSameMoney.trade[name], 1, -1 do
                        local v = BG.tradeSameMoney.trade[name][i]
                        if time - v.time >= 60 * 2 then
                            tremove(BG.tradeSameMoney.trade[name], i)
                        end
                    end
                end
            end)
        end

        -- 团长交易状态
        do
            local cd
            local function HideTradingButton()
                if BG.isTradingTips then
                    BG.isTradingTips:Hide()
                end
            end
            local function ShowTradingButton(bt)
                if not BG.isTradingTips then
                    local f = CreateFrame("Frame", nil, bt)
                    f:SetAllPoints()
                    local t = f:CreateFontString()
                    t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                    t:SetAllPoints()
                    t:SetTextColor(1, 0, 0)
                    t:SetText(L["交易中"])
                    BG.isTradingTips = f
                end
                BG.isTradingTips:ClearAllPoints()
                BG.isTradingTips:SetParent(bt)
                BG.isTradingTips:SetAllPoints()
                BG.isTradingTips:SetFrameLevel(1000)
                BG.isTradingTips:Show()
            end
            local function SetTradeIng(leaderName)
                if cd then return end
                cd = true
                BG.After(.2, function() cd = nil end)
                if not (BiaoGe.options.autoTrade == 1 and BiaoGe.options.isTrading == 1 and BG.IsMLByName(leaderName)) then return end
                local isCell
                if IsAddOnLoaded("Cell") then
                    for g = 1, 8 do
                        for i = 1, 5 do
                            local bt = _G["CellRaidFrameHeader" .. g .. "UnitButton" .. i]
                            if bt and bt:IsVisible() and bt.unit and BG.GN(bt.unit) == leaderName then
                                ShowTradingButton(bt)
                                return
                            end
                        end
                    end
                    isCell = true
                elseif IsAddOnLoaded("NDui") then
                    for g = 1, 8 do
                        for i = 1, 5 do
                            local bt = _G["oUF_Raid" .. g .. "UnitButton" .. i]
                            if bt and bt:IsVisible() and bt.unit and BG.GN(bt.unit) == leaderName then
                                ShowTradingButton(bt)
                                return
                            end
                        end
                    end
                elseif IsAddOnLoaded("ElvUI") then
                    for r = 1, 3 do
                        for g = 1, 8 do
                            for i = 1, 5 do
                                local bt = _G["ElvUF_Raid" .. r .. "Group" .. g .. "UnitButton" .. i]
                                if bt and bt:IsVisible() and bt.unit and BG.GN(bt.unit) == leaderName then
                                    ShowTradingButton(bt)
                                    return
                                end
                            end
                        end
                    end
                end
                if not isCell then
                    for g = 1, 8 do
                        for i = 1, 5 do
                            local bt = _G["CompactRaidGroup" .. g .. "Member" .. i]
                            if bt and bt:IsVisible() and bt.unit and BG.GN(bt.unit) == leaderName then
                                ShowTradingButton(bt)
                                return
                            end
                        end
                    end
                    for i = 1, 40 do
                        local bt = _G["CompactRaidFrame" .. i]
                        if bt and bt:IsVisible() and bt.unit and BG.GN(bt.unit) == leaderName then
                            ShowTradingButton(bt)
                            return
                        end
                    end
                end
            end
            BG.RegisterEvent("CHAT_MSG_ADDON", function(self, event, prefix, msg, channel, sender)
                sender = BG.GSN(sender)
                if not (prefix == "BiaoGe" and channel == "RAID" and BG.IsMLByName(sender)) then return end
                if msg == "tradeEnd" then
                    HideTradingButton()
                else
                    if not InCombatLockdown() and sender ~= BG.GN() then
                        local arg1, name = strsplit("-", msg, 2)
                        if arg1 == "tradeTo" then
                            SetTradeIng(sender)
                        end
                    end
                end
            end)
            BG.RegisterEvent("PLAYER_REGEN_DISABLED", function(self, ...)
                HideTradingButton()
            end)
            BG.RegisterEvent("GROUP_ROSTER_UPDATE", function(self, ...)
                HideTradingButton()
            end)
            BG.RegisterEvent("TRADE_SHOW", function(self, ...)
                if BG.ImML() then
                    local target = BG.GN("NPC")
                    if target then
                        C_ChatInfo.SendAddonMessage("BiaoGe", "tradeTo-" .. target, "RAID")
                    end
                end
            end)
            BG.RegisterEvent("TRADE_CLOSED", function(self, ...)
                if BG.ImML() then
                    C_ChatInfo.SendAddonMessage("BiaoGe", "tradeEnd", "RAID")
                end
            end)
        end

        -- 交易框对应的物品高亮
        do
            local function PlayerOnEnter(self)
                local ID = self:GetParent():GetID()
                local link = GetTradePlayerItemLink(ID)
                if link then
                    BG.Show_AllHighlight(link)
                end
            end
            local function TargetOnEnter(self)
                local ID = self:GetParent():GetID()
                local link = GetTradeTargetItemLink(ID)
                if link then
                    BG.Show_AllHighlight(link)
                end
            end
            for i = 1, 7 do
                _G["TradePlayerItem" .. i .. "ItemButton"]:HookScript("OnEnter", PlayerOnEnter)
                _G["TradePlayerItem" .. i .. "ItemButton"]:HookScript("OnLeave", BG.Hide_AllHighlight)

                _G["TradeRecipientItem" .. i .. "ItemButton"]:HookScript("OnEnter", TargetOnEnter)
                _G["TradeRecipientItem" .. i .. "ItemButton"]:HookScript("OnLeave", BG.Hide_AllHighlight)
            end
        end
    end

    -- 欠款记录
    do
        BG.tradeQianKuanListFrame = {}
        local f = CreateFrame("Frame", nil, TradeFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        f:SetBackdropColor(0, 0, 0, 0.7)
        f:SetBackdropBorderColor(0, 0, 0, 1)
        f:SetSize(TradeFrame:GetWidth() + 2, 175)
        f:SetPoint("TOP", TradeFrame, "BOTTOM", 0, -1)
        f:EnableMouse(true)
        f:Hide()
        BG.tradeQianKuanListFrame.frame = f

        local text = f:CreateFontString()
        text:SetPoint("TOP", f, "TOP", 0, -5)
        text:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
        text:SetText(L["对方欠款记录"])

        local bt = BG.CreateButton(f)
        bt:SetSize(80, 20)
        bt:SetPoint("TOPLEFT", 8, -2)
        bt:SetText(L["刷新"])
        bt:SetScript("OnClick", function(self)
            BG.PlaySound(1)
            BG.tradeQianKuanListFrame:Update()
        end)

        -- 总欠款
        do
            local f = CreateFrame("Frame", nil, BG.tradeQianKuanListFrame.frame)
            f:SetSize(0, 20)
            f:SetPoint("BOTTOMLEFT", 33, 5)
            f.text = f:CreateFontString()
            f.text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            f.text:SetPoint("LEFT")
            f.text:SetText(L["合计欠款："])
            f.text:SetJustifyH("LEFT")
            f:SetWidth(f.text:GetStringWidth())
            BG.tradeQianKuanListFrame.Text1 = f

            local f = CreateFrame("Frame", nil, BG.tradeQianKuanListFrame.Text1)
            f:SetSize(100, 20)
            f:SetPoint("LEFT", BG.tradeQianKuanListFrame.Text1, "RIGHT", 5, 0)
            f.text = f:CreateFontString()
            f.text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            f.text:SetAllPoints()
            f.text:SetTextColor(1, 0, 0)
            f.text:SetJustifyH("LEFT")
            BG.tradeQianKuanListFrame.Text2 = f
        end

        -- 清除全部欠款
        do
            local bt = BG.CreateButton(BG.tradeQianKuanListFrame.Text1)
            bt:SetSize(100, 20)
            bt:SetPoint("BOTTOMRIGHT", BG.tradeQianKuanListFrame.frame, "BOTTOMRIGHT", -7, 5)
            bt:SetText(L["清除全部欠款"])
            BG.tradeQianKuanListFrame.ButtonClearAll = bt
            bt:SetScript("OnClick", function(self)
                if BG.tradeQianKuanListFrame.hasItem and not IsAltKeyDown() then
                    return
                end
                local unit = "NPC"
                if BG.DeBug then unit = "player" end
                local target = BG.GN(unit)
                local class = select(2, UnitClass(unit))
                local color = select(4, GetClassColor(class))
                StaticPopup_Show("BiaoGeClearAllQianKuan", "|c" .. color .. target .. RR, BG.tradeQianKuanListFrame.Text2.text:GetText())
            end)
            bt:SetScript("OnEnter", function(self)
                if BG.tradeQianKuanListFrame.hasItem then
                    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:AddLine(L["错误"], 1, 0, 0, true)
                    GameTooltip:AddLine(L["欠款需要单独收取，不要和装备混在一起交易！否则账单错误！"], 1, 0.82, 0, true)
                    GameTooltip:AddLine(" ")
                    GameTooltip:AddLine(L["如需强制清除欠款，需按下ALT后才能清除！"], 1, 0.82, 0, true)
                    GameTooltip:Show()
                end
            end)
            bt:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
        end

        local frame, child = BG.CreateScrollFrame(BG.tradeQianKuanListFrame.frame, BG.tradeQianKuanListFrame.frame:GetWidth() - 15, BG.tradeQianKuanListFrame.frame:GetHeight() - 55)
        frame:SetPoint("TOPLEFT", 7.5, -25)
        frame:SetBackdrop({
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        frame:SetBackdropBorderColor(.5, .5, .5, .5)

        local buttons = {}
        function BG.tradeQianKuanListFrame:Update()
            BG.tradeQianKuanListFrame.frame:Hide()
            if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["qiankuanTrade"] == 1 and IsInRaid(1) then
                local unit = "NPC"
                if BG.DeBug then unit = "player" end
                local target = BG.GN(unit)
                for i, v in ipairs(buttons) do
                    v.frame:Hide()
                end
                wipe(buttons)
                local sum = 0
                local yes
                local FB = BG.FB1
                for b = 1, Maxb[FB] do
                    for i = 1, BG.GetMaxi(FB, b) do
                        local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                        local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                        if maijia then
                            if maijia:GetText() == target and BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
                                yes = true
                                local bts = {}
                                sum = sum + tonumber(BiaoGe[FB]["boss" .. b]["qiankuan" .. i])

                                -- 底色
                                do
                                    local f = CreateFrame("Frame", nil, child)
                                    if #buttons == 0 then
                                        f:SetPoint("TOPLEFT", 0, 0)
                                    else
                                        f:SetPoint("TOPLEFT", buttons[#buttons].frame, "BOTTOMLEFT", 0, -2)
                                    end
                                    f:SetSize(0, 20)
                                    bts.frame = f
                                    f:SetScript("OnEnter", function(self)
                                        bts.ds:Show()
                                    end)
                                    f:SetScript("OnLeave", function(self)
                                        bts.ds:Hide()
                                    end)
                                    local tex = bts.frame:CreateTexture()
                                    tex:SetPoint("LEFT")
                                    tex:SetSize(0, 20)
                                    tex:SetColorTexture(.5, .5, .5, .3)
                                    bts.ds = tex
                                    tex:Hide()
                                end
                                -- 序号
                                do
                                    local f = CreateFrame("Frame", nil, bts.frame)
                                    f:SetSize(20, 20)
                                    f:SetPoint("LEFT", 0, 0)
                                    f.text = f:CreateFontString()
                                    f.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                                    f.text:SetAllPoints()
                                    f.text:SetTextColor(1, 0.82, 0)
                                    f.text:SetText((#buttons + 1))
                                    bts.num = f
                                    f:SetScript("OnEnter", function(self)
                                        bts.ds:Show()
                                    end)
                                    f:SetScript("OnLeave", function(self)
                                        bts.ds:Hide()
                                    end)
                                end

                                -- 图标
                                do
                                    local icon = select(5, GetItemInfoInstant(zhuangbei:GetText()))
                                    local f = CreateFrame("Frame", nil, bts.frame)
                                    f:SetPoint("LEFT", bts.num, "RIGHT", 2, 0)
                                    f:SetSize(16, 16)
                                    local tex = f:CreateTexture()
                                    tex:SetAllPoints()
                                    tex:SetTexture(icon)
                                    bts.icon = f
                                    bts.hasicon = tex:GetTexture()
                                    f:SetScript("OnEnter", function(self)
                                        bts.ds:Show()
                                    end)
                                    f:SetScript("OnLeave", function(self)
                                        bts.ds:Hide()
                                    end)
                                end
                                -- 装备
                                do
                                    local f = CreateFrame("Frame", nil, bts.frame)
                                    f:SetSize(0, 20)
                                    f:SetPoint("LEFT", bts.icon, "RIGHT", bts.hasicon and 0 or -16, 0)
                                    f.text = f:CreateFontString()
                                    f.text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                                    f.text:SetAllPoints()
                                    f.text:SetText(zhuangbei:GetText())
                                    f.text:SetJustifyH("LEFT")
                                    bts.item = f
                                    f:SetScript("OnEnter", function(self)
                                        local link = zhuangbei:GetText()
                                        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                                        GameTooltip:ClearLines()
                                        local itemID = GetItemInfoInstant(link)
                                        if itemID then
                                            GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))
                                            BG.Show_AllHighlight(link)
                                        end
                                        bts.ds:Show()
                                    end)
                                    f:SetScript("OnLeave", function(self)
                                        GameTooltip:Hide()
                                        BG.Hide_AllHighlight()
                                        bts.ds:Hide()
                                    end)
                                    f:SetScript("OnMouseDown", function(self)
                                        local link = zhuangbei:GetText()
                                        local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
                                        if link then
                                            if IsShiftKeyDown() then
                                                BG.InsertLink(link)
                                                -- else
                                                --     ShowUIPanel(ItemRefTooltip)
                                                --     if (not ItemRefTooltip:IsShown()) then
                                                --         ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
                                                --     end
                                                --     ItemRefTooltip:SetHyperlink(link)
                                            end
                                        end
                                    end)
                                end
                                -- 欠款
                                do
                                    local f = CreateFrame("Frame", nil, bts.frame)
                                    f:SetSize(80, 20)
                                    f:SetPoint("LEFT", bts.item, "RIGHT", 2, 0)
                                    f.text = f:CreateFontString()
                                    f.text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                                    f.text:SetAllPoints()
                                    f.text:SetText(BiaoGe[FB]["boss" .. b]["qiankuan" .. i])
                                    f.text:SetTextColor(1, 0, 0)
                                    f.text:SetJustifyH("LEFT")
                                    if f.text:GetStringWidth() > f.text:GetWidth() then
                                        f.iswordwrap = true
                                    end
                                    bts.qiankuan = f
                                    f:SetScript("OnEnter", function(self)
                                        if self.iswordwrap then
                                            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                                            GameTooltip:ClearLines()
                                            GameTooltip:AddLine(BiaoGe[FB]["boss" .. b]["qiankuan" .. i], 1, 0, 0, true)
                                            GameTooltip:Show()
                                        end
                                        bts.ds:Show()
                                    end)
                                    f:SetScript("OnLeave", function(self)
                                        GameTooltip:Hide()
                                        bts.ds:Hide()
                                    end)
                                end
                                -- 按钮
                                do
                                    local bt = BG.CreateButton(bts.frame)
                                    bt:SetSize(50, 18)
                                    bt:SetPoint("LEFT", bts.qiankuan, "RIGHT", 5, 0)
                                    bt:SetText(L["清除"])
                                    bts.button = bt
                                    bt:SetScript("OnClick", function()
                                        if BG.tradeQianKuanListFrame.hasItem and not IsAltKeyDown() then
                                            return
                                        end
                                        BG.PlaySound(1)
                                        local class = select(2, UnitClass(unit))
                                        local color = select(4, GetClassColor(class))
                                        BG.SendSystemMessage(format(L["已清除%s的%s欠款|cffFF0000%s|r。"],
                                            "|c" .. color .. target .. RR,
                                            zhuangbei:GetText():gsub("|cff......|Hitem:.-%[(.-)%]|h|r", "%1"),
                                            BiaoGe[FB]["boss" .. b]["qiankuan" .. i]))

                                        BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = nil
                                        BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Hide()

                                        BG.tradeQianKuanListFrame:Update()
                                    end)
                                    bt:SetScript("OnEnter", function(self)
                                        bts.ds:Show()
                                        if BG.tradeQianKuanListFrame.hasItem then
                                            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                                            GameTooltip:ClearLines()
                                            GameTooltip:AddLine(L["错误"], 1, 0, 0, true)
                                            GameTooltip:AddLine(L["欠款需要单独收取，不要和装备混在一起交易！否则账单错误！"], 1, 0.82, 0, true)
                                            GameTooltip:AddLine(" ")
                                            GameTooltip:AddLine(L["如需强制清除欠款，需按下ALT后才能清除！"], 1, 0.82, 0, true)
                                            GameTooltip:Show()
                                        end
                                    end)
                                    bt:SetScript("OnLeave", function(self)
                                        bts.ds:Hide()
                                        GameTooltip:Hide()
                                    end)

                                    local l = bts.frame:CreateLine()
                                    l:SetColorTexture(RGB("808080", 1))
                                    l:SetStartPoint("BOTTOMLEFT", 0, 0)
                                    l:SetThickness(1)
                                    bts.line = l
                                end
                                tinsert(buttons, bts)
                            end
                        end
                    end
                end

                BG.tradeQianKuanListFrame.Text2.text:SetText(sum)

                if #buttons > 5 then
                    frame.scroll.ScrollBar:Show()
                    frame.scroll:SetWidth(BG.tradeQianKuanListFrame.frame:GetWidth() - 15 - 31)
                    for i, v in ipairs(buttons) do
                        v.item:SetWidth(v.hasicon and 125 or (125 + v.icon:GetWidth()))
                        v.line:SetEndPoint("BOTTOMLEFT", frame.scroll:GetWidth(), 0)
                        v.frame:SetWidth(BG.tradeQianKuanListFrame.frame:GetWidth() - 15 - 31)
                        v.ds:SetWidth(BG.tradeQianKuanListFrame.frame:GetWidth() - 15 - 31)
                    end
                else
                    frame.scroll.ScrollBar:Hide()
                    frame.scroll:SetWidth(BG.tradeQianKuanListFrame.frame:GetWidth() + 5)
                    for i, v in ipairs(buttons) do
                        v.item:SetWidth(v.hasicon and 145 or (145 + v.icon:GetWidth()))
                        v.line:SetEndPoint("BOTTOMLEFT", frame.scroll:GetWidth() - 30, 0)
                        v.frame:SetWidth(BG.tradeQianKuanListFrame.frame:GetWidth() - 25)
                        v.ds:SetWidth(BG.tradeQianKuanListFrame.frame:GetWidth() - 25)
                    end
                end
                if yes then
                    BG.tradeQianKuanListFrame.frame:Show()
                end
            end
        end

        function BG.tradeQianKuanListFrame:Reset()
            self.frame:Hide()
            self.hasItem = nil
        end

        StaticPopupDialogs["BiaoGeClearAllQianKuan"] = {
            text = L["确认清除%s的全部欠款吗？\n欠款合计：|cffFF0000%s|r"],
            button1 = L["是"],
            button2 = L["否"],
            OnAccept = function(...)
                local unit = "NPC"
                if BG.DeBug then unit = "player" end
                local target = BG.GN(unit)
                if not target then return end
                local class = select(2, UnitClass(unit))
                local color = select(4, GetClassColor(class))
                local FB = BG.FB1
                for b = 1, Maxb[FB] do
                    for i = 1, BG.GetMaxi(FB, b) do
                        local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                        if maijia then
                            if maijia:GetText() == target and BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
                                BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = nil
                                BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Hide()
                            end
                        end
                    end
                end
                BG.SendSystemMessage(format(L["已清除%s的全部欠款|cffFF0000%s|r。"],
                    "|c" .. color .. target .. RR,
                    BG.tradeQianKuanListFrame.Text2.text:GetText()))
                BG.tradeQianKuanListFrame:Update()
            end,
            OnCancel = function()
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            showAlert = true,
        }
    end

    -- 记账效果预览
    do
        -- 预览框架
        do
            BG.tradeSeeFrame = {}
            local f = CreateFrame("Frame", nil, TradeFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            f:SetSize(200, 150)
            f:SetPoint("BOTTOMLEFT", TradeFrame, "BOTTOMRIGHT", 1, -1)
            f:EnableMouse(true)
            f:SetToplevel(true)
            f:SetFrameLevel(TradeRecipientMoneyBg:GetFrameLevel() + 1)
            f:SetFrameStrata("HIGH")
            BG.tradeSeeFrame.frame = f

            local text = f:CreateFontString()
            text:SetPoint("TOP", f, "TOP", 0, -7)
            text:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
            text:SetText(L["记账效果预览"])

            local text = f:CreateFontString()
            text:SetPoint("TOPLEFT", f, "TOPLEFT", 8, -30)
            text:SetWidth(f:GetWidth() - 10)
            text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            text:SetJustifyH("LEFT")
            BG.tradeSeeFrame.text = text

            function BG.tradeSeeFrame.frame:SetNormalColor()
                self:SetBackdropColor(0, 0, 0, 0.7)
                self:SetBackdropBorderColor(0, 0, 0, 1)
            end

            function BG.tradeSeeFrame.frame:SetFalseColor()
                self:SetBackdropColor(1, 0, 0, 0.2)
                self:SetBackdropBorderColor(1, 0, 0, 1)
            end

            function BG.tradeSeeFrame.frame:SetGreenColor()
                self:SetBackdropColor(0, 0, 0, 0.7)
                self:SetBackdropBorderColor(0, 1, 0, 1)
            end

            function BG.tradeSeeFrame.frame:Reset()
                self:Hide()
                if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradePreview"] == 1 and IsInRaid(1) then
                    self:Show()
                    BG.tradeSeeFrame.CheckButton:SetChecked(true)
                    BG.tradeSeeFrame.text:SetText("")
                end
            end

            function BG.tradeSeeFrame.frame:Update()
                self:Hide()
                if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradePreview"] == 1 and IsInRaid(1) then
                    self:Show()
                    BG.tradeSeeFrame.text:SetText(BG.GetTradeSeeText())
                end
            end

            function BG.tradeSeeFrame.frame:SaveMoney()
                if BiaoGe.options["autoTrade"] == 1 and IsInRaid(1) then
                    local text = BG.GetTradeSeeText("saved")
                    -- 保存打包交易
                    if #BG.trade.many > 1 then
                        local FBs = {}
                        for i, v in ipairs(BG.trade.many) do
                            FBs[v.FB] = true
                        end
                        for FB in pairs(FBs) do
                            tinsert(BiaoGe[FB].tradeTbl, BG.trade.many)
                        end
                    end
                    if BiaoGe.options["tradeNotice"] == 1 then
                        BG.FrameTradeMsg:AddMessage(text)
                    end
                end
            end

            BG.tradeSeeFrame.frame:SetNormalColor()
        end

        -- 本次交易自动记账
        do
            local bt = CreateFrame("CheckButton", nil, BG.tradeSeeFrame.frame, "ChatConfigCheckButtonTemplate")
            bt:SetSize(25, 25)
            bt.Text:SetText(L["本次交易自动记账"])
            bt:SetPoint("BOTTOMLEFT", BG.tradeSeeFrame.frame, "BOTTOMLEFT",
                (BG.tradeSeeFrame.frame:GetWidth() - bt:GetWidth() - bt.Text:GetWidth()) * 0.5 - 5, 0)
            bt:SetHitRectInsets(0, -bt.Text:GetWidth(), 0, 0)
            bt:SetChecked(true)
            BG.tradeSeeFrame.CheckButton = bt
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                BG.tradeSeeFrame.frame:Update()
            end)
        end
    end

    -- 最近拍卖
    do
        BG.tradelastAuctionFrame = {}
        local maxButtons = 10
        local buttons = {}
        local buttonGroup
        -- 主UI
        do
            local f = CreateFrame("Frame", nil, TradeFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            f:SetBackdropColor(0, 0, 0, 0.7)
            f:SetBackdropBorderColor(0, 0, 0, 1)
            f:SetSize(BG.tradeSeeFrame.frame:GetWidth(), 110)
            f:SetPoint("BOTTOM", BG.tradeSeeFrame.frame, "TOP", 0, 1)
            f:EnableMouse(true)
            f:SetToplevel(true)
            f:SetFrameLevel(TradeRecipientMoneyBg:GetFrameLevel() + 1)
            f:SetFrameStrata("HIGH")
            f:Hide()
            BG.tradelastAuctionFrame.frame = f
            f:SetScript("OnShow", function(self)
                BG.After(0, function()
                    BG.tradelastAuctionFrame.buttonGroup:Show()
                    BG.tradelastAuctionFrame.UpdateChooseType()
                    BG.tradelastAuctionFrame.UpdateAllButtons()
                    self:RegisterEvent("BAG_UPDATE_DELAYED")
                    self:RegisterEvent("ITEM_LOCK_CHANGED")
                end)
            end)
            f:SetScript("OnHide", function(self)
                self:UnregisterAllEvents()
                BG.tradelastAuctionFrame.buttonGroup:Hide()
                for _, bt in ipairs(buttons) do
                    bt:Hide()
                end
            end)
            f:SetScript("OnEvent", function(self)
                BG.After(0.1, function()
                    BG.tradelastAuctionFrame.UpdateAllButtons()
                end)
            end)

            function BG.tradelastAuctionFrame.frame:UpdateShow()
                self:Hide()
                if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradePreview"] == 1 and IsInRaid(1) then
                    if BG.ImML() then
                        self:Show()
                    end
                end
            end
        end

        for i = 1, maxButtons do
            local bt = CreateFrame("Button", nil, BG.tradelastAuctionFrame.frame, "BackdropTemplate")
            bt:SetBackdrop({
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1.5,
            })
            bt:SetSize(35, 35)
            bt:RegisterForClicks("AnyUp")
            if i == 1 then
                bt:SetPoint("TOPLEFT", BG.tradelastAuctionFrame.frame, "TOPLEFT", 5, -30)
            elseif (i - 1) % 5 == 0 then
                bt:SetPoint("TOPLEFT", buttons[i - 5], "BOTTOMLEFT", 0, -4)
            else
                bt:SetPoint("TOPLEFT", buttons[i - 1], "TOPRIGHT", 4, -0)
            end
            bt.icon = bt:CreateTexture(nil, "BACKGROUND", nil, 1)
            bt.icon:SetAllPoints()
            bt:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])
            bt:Hide()
            tinsert(buttons, bt)

            bt.count = bt:CreateFontString()
            bt.count:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
            bt.count:SetPoint("BOTTOMRIGHT", -2, 1)
            bt.count:SetTextColor(1, 1, 1)

            bt.level = bt:CreateFontString()
            bt.level:SetFont(STANDARD_TEXT_FONT, 12.5, "OUTLINE")
            bt.level:SetPoint("BOTTOM", 0, 1)

            bt:SetScript("OnEnter", function(self)
                if BG.tradelastAuctionFrame.showType == "autoButton" then
                    BG.tradelastAuctionFrame.tooltip = {
                        red = not self.b,
                        money = self.money,
                    }
                end
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                GameTooltip:ClearLines()
                if self.b and self.i then
                    GameTooltip:SetBagItem(self.b, self.i)
                else
                    GameTooltip:SetHyperlink(BG.SetSpecIDToLink(self.link))
                end
                BG.Show_AllHighlight(self.link)
            end)
            bt:SetScript("OnLeave", function()
                BG.tradelastAuctionFrame.tooltip = nil
                GameTooltip:Hide()
                BG.Hide_AllHighlight()
            end)
            bt:SetScript("OnClick", function(self)
                if self.b and self.i and not self.isLocked then
                    ClearCursor()
                    for i = 1, 6 do
                        if not GetTradePlayerItemLink(i) then
                            C_Container.PickupContainerItem(self.b, self.i)
                            _G["TradePlayerItem" .. i .. "ItemButton"]:Click()
                            ClearCursor()
                            return
                        end
                    end
                end
            end)
        end

        -- 显示类型
        do
            local buttons = {}
            local numOptions = {
                { name = L["最近拍卖"], name2 = "lastButton" },
                { name = L["对方已拍"], name2 = "autoButton" },
            }
            local buttonGroup = CreateFrame("Frame", nil, BG.tradelastAuctionFrame.frame)
            buttonGroup:SetPoint("TOP", 0, -5)
            buttonGroup:SetSize(180, 20)
            BG.tradelastAuctionFrame.buttonGroup = buttonGroup
            for i = 1, #numOptions do
                local bt = CreateFrame("CheckButton", nil, buttonGroup, "UIRadioButtonTemplate")
                bt:SetPoint("LEFT", (i - 1) * buttonGroup:GetWidth() / 2 + 5, 0)
                bt:SetSize(15, 15)
                tinsert(buttons, bt)
                bt.Text = bt:CreateFontString()
                bt.Text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                bt.Text:SetPoint("LEFT", bt, "RIGHT", 0, 0)
                bt.Text:SetText(numOptions[i].name)
                bt.Text:SetTextColor(1, .82, 0)
                bt:SetHitRectInsets(0, -bt.Text:GetWidth(), -5, -5)
                BG.tradelastAuctionFrame[numOptions[i].name2] = bt
                function bt:OnClick()
                    for _, radioButton in ipairs(buttons) do
                        if radioButton ~= self then
                            radioButton:SetChecked(false)
                            if radioButton:IsEnabled() then
                                radioButton.Text:SetTextColor(1, .82, 0)
                            else
                                radioButton.Text:SetTextColor(.5, .5, .5)
                            end
                        end
                    end
                    self:SetChecked(true)
                    self.Text:SetTextColor(0, 1, 0)
                    BG.tradelastAuctionFrame.showType = numOptions[i].name2
                end

                bt:SetScript("OnClick", function(self)
                    BG.PlaySound(1)
                    self:OnClick()
                    BG.tradelastAuctionFrame.UpdateAllButtons()
                end)
            end
        end

        local lastItems = {}
        local lastItemsInfo = {}
        -- 刷新最新拍卖物品
        function BG.tradelastAuctionFrame.UpdateLastButtons()
            for i, bt in ipairs(buttons) do
                bt:Hide()
            end
            wipe(lastItemsInfo)
            for ii, vv in ipairs(lastItems) do
                for b = 0, NUM_BAG_SLOTS do
                    for i = 1, C_Container.GetContainerNumSlots(b) do
                        local info = C_Container.GetContainerItemInfo(b, i)
                        if info then
                            if BG.IsSameItem(vv.link, info.hyperlink) then
                                local notBound
                                if not info.isBound then
                                    notBound = true
                                else
                                    BiaoGeTooltip3:SetOwner(UIParent, "ANCHOR_NONE", 0, 0)
                                    BiaoGeTooltip3:ClearLines()
                                    BiaoGeTooltip3:SetBagItem(b, i)
                                    local ii = 1
                                    while _G["BiaoGeTooltip3TextLeft" .. ii] do
                                        local tx = _G["BiaoGeTooltip3TextLeft" .. ii]:GetText()
                                        if tx then
                                            local time = tx:match(BIND_TRADE_TIME_REMAINING:gsub("%%s", "(.+)"))
                                            if time then
                                                notBound = true
                                                break
                                            end
                                        end
                                        ii = ii + 1
                                    end
                                end
                                if notBound then
                                    local _, _, _, level, _, _, _, _, _, _, _, typeID = GetItemInfo(vv.itemID)
                                    tinsert(lastItemsInfo, {
                                        link = info.hyperlink,
                                        itemID = vv.itemID,
                                        count = info.stackCount,
                                        icon = info.iconFileID,
                                        quality = info.quality,
                                        isLocked = info.isLocked,
                                        b = b,
                                        i = i,
                                        level = (typeID == 2 or typeID == 4) and level,
                                    })
                                end
                            end
                        end
                    end
                end
            end
            for i, v in ipairs(lastItemsInfo) do
                if i > maxButtons then break end
                local bt = buttons[i]
                bt.link = v.link
                bt.b = v.b
                bt.i = v.i
                bt.itemID = v.itemID
                bt.isLocked = v.isLocked
                local r, g, b = GetItemQualityColor(v.quality)
                bt:SetBackdropBorderColor(r, g, b, 1)
                bt:GetHighlightTexture():SetVertexColor(r, g, b)
                bt.icon:SetTexture(v.icon)
                bt.icon:SetTexCoord(unpack(BG.iconTexCoord))
                bt.icon:SetDesaturated(v.isLocked)
                bt.icon:SetVertexColor(1, 1, 1)
                bt.count:SetText(v.count == 1 and "" or v.count)
                bt.level:SetText(v.level or "")
                bt.level:SetTextColor(r, g, b)
                bt:Show()
            end
        end

        -- 刷新对方已拍物品
        function BG.tradelastAuctionFrame.UpdateAutoButtons()
            for _, bt in ipairs(buttons) do
                bt:Hide()
            end
            wipe(lastItemsInfo)
            local tbl = {}
            local tradeName = BG.GN("NPC")
            if not (tradeName and BG.auctionTrade[tradeName] and next(BG.auctionTrade[tradeName])) then return end
            for ii = 1, #BG.auctionTrade[tradeName] do
                local vv = BG.auctionTrade[tradeName][ii]
                local link = vv.zhuangbei
                local itemID = GetItemID(link)
                local icon, typeID = select(5, GetItemInfoInstant(itemID))
                tinsert(lastItemsInfo, {
                    link = link,
                    itemID = itemID,
                    icon = icon,
                    quality = vv.quality,
                    level = (typeID == 2 or typeID == 4) and vv.itemlevel or nil,
                    money = tonumber(vv.jine) or 0,
                })

                for b = 0, NUM_BAG_SLOTS do
                    for i = 1, C_Container.GetContainerNumSlots(b) do
                        if not tbl[b .. "-" .. i] then
                            local info = C_Container.GetContainerItemInfo(b, i)
                            if info then
                                if BG.IsSameItem(link, info.hyperlink) then
                                    local notBound
                                    if not info.isBound then
                                        notBound = true
                                    else
                                        BiaoGeTooltip3:SetOwner(UIParent, "ANCHOR_NONE", 0, 0)
                                        BiaoGeTooltip3:ClearLines()
                                        BiaoGeTooltip3:SetBagItem(b, i)
                                        local ii = 1
                                        while _G["BiaoGeTooltip3TextLeft" .. ii] do
                                            local tx = _G["BiaoGeTooltip3TextLeft" .. ii]:GetText()
                                            if tx then
                                                local time = tx:match(BIND_TRADE_TIME_REMAINING:gsub("%%s", "(.+)"))
                                                if time then
                                                    notBound = true
                                                    break
                                                end
                                            end
                                            ii = ii + 1
                                        end
                                    end
                                    if notBound then
                                        local last = lastItemsInfo[#lastItemsInfo]
                                        last.count = info.stackCount
                                        last.isLocked = info.isLocked
                                        last.b = b
                                        last.i = i
                                        tbl[b .. "-" .. i] = true
                                        break
                                    end
                                end
                            end
                        end
                    end
                    if lastItemsInfo[#lastItemsInfo].b then break end
                end
            end
            for i, v in ipairs(lastItemsInfo) do
                if i > maxButtons then break end
                local bt = buttons[i]
                bt.link = v.link
                bt.b = v.b
                bt.i = v.i
                bt.itemID = v.itemID
                bt.isLocked = v.isLocked
                local r, g, b = GetItemQualityColor(v.quality)
                bt:SetBackdropBorderColor(r, g, b, 1)
                bt:GetHighlightTexture():SetVertexColor(r, g, b)
                bt.icon:SetTexture(v.icon)
                bt.icon:SetTexCoord(unpack(BG.iconTexCoord))
                bt.icon:SetDesaturated(v.isLocked)
                bt.icon:SetVertexColor(1, 1, 1)
                bt.count:SetText(v.count == 1 and "" or v.count)
                bt.level:SetText(v.level or "")
                bt.level:SetTextColor(r, g, b)
                if not v.b then
                    bt.icon:SetVertexColor(1, 0, 0)
                end
                bt.money = v.money
                bt:Show()
            end
        end

        -- 刷新全部物品
        function BG.tradelastAuctionFrame.UpdateAllButtons()
            if BG.tradelastAuctionFrame.showType == "autoButton" then
                BG.tradelastAuctionFrame.UpdateAutoButtons()
            else
                BG.tradelastAuctionFrame.UpdateLastButtons()
            end
        end

        -- 刷新显示类型
        function BG.tradelastAuctionFrame.UpdateChooseType()
            BG.tradelastAuctionFrame.autoButton:Enable()
            BG.tradelastAuctionFrame.autoButton.Text:SetTextColor(1, .82, 0)
            local tradeName = BG.GN("NPC")
            if tradeName and BG.auctionTrade[tradeName] and next(BG.auctionTrade[tradeName]) then
                BG.tradelastAuctionFrame.autoButton:Click()
            else
                BG.tradelastAuctionFrame.lastButton:Click()
                BG.tradelastAuctionFrame.autoButton:Disable()
                BG.tradelastAuctionFrame.autoButton.Text:SetTextColor(.5, .5, .5)
            end
        end

        -- 鼠标提示显示对方已拍价格
        local function AddLine()
            if BG.tradelastAuctionFrame.tooltip then
                if _G.GameTooltipTextLeft2 then
                    local text = _G.GameTooltipTextLeft2:GetText()
                    local red = ""
                    if BG.tradelastAuctionFrame.tooltip.red then
                        red = BG.STC_r1(L["\n背包里没有该件物品"])
                    end
                    local t = format(BG.STC_w1(L["自动拍卖价格：%s"]),
                        BG.tradelastAuctionFrame.tooltip.money) .. red
                    if text and text:gsub(" ", "") ~= "" then
                        _G.GameTooltipTextLeft2:SetText(t .. "\n" .. text)
                    else
                        GameTooltip:AddLine(t)
                        GameTooltip:Show()
                    end
                end
            end
        end
        if BG.IsRetail then
            local function addItemID(self, data)
                if self:IsForbidden() then return end
                if data.id then
                    AddLine()
                end
            end
            TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, addItemID)
        else
            GameTooltip:HookScript("OnTooltipSetItem", function(self)
                local name, link = self:GetItem()
                if not link then return end
                AddLine()
            end)
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_RAID_WARNING")
        f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:RegisterEvent("CHAT_MSG_RAID")
        f:SetScript("OnEvent", function(self, event, ...)
            local msg, playerName = ...
            local ML
            playerName = BG.GSN(playerName)
            if event == "CHAT_MSG_RAID_WARNING" or event == "CHAT_MSG_RAID_LEADER" then
                ML = true
            elseif event == "CHAT_MSG_RAID" and playerName == BG.masterLooter then
                ML = true
            end
            if not ML then return end
            for link in msg:gmatch("|H(item:%d+:[%d-:]+)") do
                local itemID = GetItemID(link)
                for i = #lastItems, 1, -1 do
                    if lastItems[i].itemID == itemID then
                        tremove(lastItems, i)
                    end
                end
                tinsert(lastItems, 1, {
                    time = GetServerTime(),
                    itemID = itemID,
                    link = link,
                })
                for i = #lastItems, 1, -1 do
                    if #lastItems <= maxButtons then
                        break
                    end
                    tremove(lastItems, i)
                end
            end
            if BG.tradelastAuctionFrame.frame:IsVisible() and BG.tradelastAuctionFrame.showType == "lastButton" then
                BG.tradelastAuctionFrame.UpdateLastButtons()
            end
        end)

        C_Timer.NewTicker(60, function()
            local _time = GetServerTime()
            for i = #lastItems, 1, -1 do
                if _time - lastItems[i].time > 60 * 5 then
                    tremove(lastItems, i)
                end
            end
            if BG.tradelastAuctionFrame.frame:IsVisible() and BG.tradelastAuctionFrame.showType == "lastButton" then
                BG.tradelastAuctionFrame.UpdateLastButtons()
            end
        end)
    end

    -- 一键交易工资
    do
        BG.tradeFastGiveMoneyFrame = {}
        local mainFrame, frame, child, width, gzTbl, lastClick
        local givedTbl = {}
        local buttons = {}
        function BG.CreateTradeFastGiveMoneyFrame()
            if BG.tradeFastGiveMoneyFrame.frame then return end
            local f = CreateFrame("Frame", nil, TradeFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            f:SetBackdropColor(0, 0, 0, 0.7)
            f:SetBackdropBorderColor(0, 0, 0, 1)
            f:SetPoint("TOPLEFT", TradeFrame, "TOPRIGHT", 1, -20)
            f:SetSize(200, 1)
            f:EnableMouse(true)
            f:SetToplevel(true)
            f:SetFrameLevel(TradeRecipientMoneyBg:GetFrameLevel() + 1)
            f:SetFrameStrata("HIGH")
            f.events = {}
            BG.tradeFastGiveMoneyFrame.frame = f
            mainFrame = f

            local text = f:CreateFontString()
            text:SetPoint("TOP", 0, -5)
            text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            text:SetText(L["一键发工资"])

            local bt = BG.CreateButton(f)
            bt:SetSize(50, 17)
            bt:SetPoint("TOPLEFT", 2, -3)
            bt:SetText(L["刷新"])
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                BG.UpdateTradeFastGiveMoneyFrame()
            end)

            frame = CreateFrame("Frame", nil, mainFrame, "BackdropTemplate")
            frame:SetPoint("TOPLEFT", 2.5, -22)
            frame:SetSize(195, 10)
            frame:SetBackdrop({
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            frame:SetBackdropBorderColor(.5, .5, .5, .5)
            frame.scroll = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
            frame.scroll:SetPoint("TOPLEFT", 5, -2)
            frame.scroll:SetPoint("BOTTOMRIGHT", -5, 5)
            frame.scroll.ScrollBar.scrollStep = nil
            BG.HookScrollBarShowOrHide(frame.scroll, true)
            width = frame.scroll:GetWidth()
            child = CreateFrame("Frame", nil, frame.scroll)
            child:SetPoint("TOPLEFT")
            child:SetWidth(frame.scroll:GetWidth())
            child:SetHeight(frame.scroll:GetHeight())
            frame.scroll:SetScrollChild(child)
        end

        local function GetQianKuan()
            return tonumber(BG.tradeQianKuanListFrame.Text2.text:GetText()) or 0
        end
        local function SetMoney(money, name, isExpenses, isMan)
            BG.SetMyTradeMoney(money)
            lastClick = nil
            if isExpenses and not isMan then
                lastClick = {
                    money = money,
                    name = name,
                }
            end
            BG.After(0, function()
                BG.tradeUpdateFrame.elapsed = 0
                BG.tradeUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
                    if not TradeFrame:IsVisible() or BG.tradeSameMoney:IsVisible() then
                        self:SetScript("OnUpdate", nil)
                        return
                    end
                    self.elapsed = self.elapsed + elapsed
                    if self.elapsed >= .2 then
                        self:SetScript("OnUpdate", nil)
                        UIErrorsFrame:AddMessage(format(L["确认交易%s%s%s？"], SetClassCFF(BG.GN("NPC")), money, goldTex), 1, 1, 0)
                        AcceptTrade()
                    end
                end)
            end)
        end
        local function CreateButton(name, money, isExpenses, hasMan)
            local ds
            local f = CreateFrame("Frame", nil, child)
            do
                f:SetSize(width, 20)
                if next(buttons) then
                    f:SetPoint("TOPLEFT", buttons[#buttons], "BOTTOMLEFT", 0, -2)
                else
                    f:SetPoint("TOPLEFT", 0, 0)
                end
                tinsert(buttons, f)
                f.ds = f:CreateTexture()
                f.ds:SetAllPoints()
                f.ds:SetColorTexture(.5, .5, .5, .3)
                f.ds:Hide()
                ds = f.ds
                f:SetScript("OnEnter", function(self)
                    ds:Show()
                end)
                f:SetScript("OnLeave", function(self)
                    if f.tradeing then return end
                    ds:Hide()
                end)
            end

            local nameFrame = CreateFrame("Frame", nil, f)
            do
                nameFrame:SetSize(width * .40, f:GetHeight())
                nameFrame:SetPoint("LEFT", 0, 0)
                local t = nameFrame:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
                t:SetAllPoints()
                t:SetText(name)
                if givedTbl[name] then
                    t:SetTextColor(.5, .5, .5)
                else
                    t:SetTextColor(1, .82, 0)
                end
                t:SetJustifyH("LEFT")
                t:SetWordWrap(false)
                nameFrame:SetScript("OnEnter", function(self)
                    if t:IsTruncated() then
                        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                        GameTooltip:ClearLines()
                        GameTooltip:AddLine(name, 1, .82, 0, true)
                        GameTooltip:Show()
                    end
                    ds:Show()
                end)
                nameFrame:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                    if f.tradeing then return end
                    ds:Hide()
                end)
            end

            local moneyFrame = CreateFrame("Frame", nil, f)
            do
                moneyFrame:SetSize(width * .35, nameFrame:GetHeight())
                moneyFrame:SetPoint("LEFT", nameFrame, "RIGHT", 2, 0)
                local t = moneyFrame:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
                t:SetAllPoints()
                t:SetText(money)
                if givedTbl[name] then
                    t:SetTextColor(.5, .5, .5)
                else
                    t:SetTextColor(1, .82, 0)
                end
                t:SetJustifyH("LEFT")
                t:SetWordWrap(false)
                moneyFrame:SetScript("OnEnter", function(self)
                    if t:IsTruncated() then
                        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                        GameTooltip:ClearLines()
                        GameTooltip:AddLine(name, 1, .82, 0, true)
                        GameTooltip:Show()
                    end
                    ds:Show()
                end)
                moneyFrame:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                    if f.tradeing then return end
                    ds:Hide()
                end)
            end

            local bt = BG.CreateButton(f)
            do
                bt:SetSize(width * .25 - 5, nameFrame:GetHeight() - 2)
                bt:SetPoint("LEFT", moneyFrame, "RIGHT", 2, 0)
                bt:SetText(L["交易"])
                bt:RegisterForClicks("AnyUp")
                bt:SetScript("OnClick", function(self, button)
                    BG.PlaySound(1)
                    BG.tradeMyMoneyFrame.canShow = true
                    local money = money
                    local isMan
                    if button == "RightButton" and hasMan then
                        money = hasMan.avg
                        isMan = true
                    end
                    local myMoney = floor(GetMoney() / 1e4)
                    if money < 0 then
                        UIErrorsFrame:AddMessage(L["交易金额不能为负数！"], 1, 0, 0)
                    elseif myMoney >= money then
                        for _, f in pairs(buttons) do
                            f.ds:SetColorTexture(.5, .5, .5, .3)
                            f.ds:Hide()
                            f.tradeing = nil
                        end
                        ds:SetColorTexture(0, 1, 0, .5)
                        ds:Show()
                        f.tradeing = true
                        local qiankuan = GetQianKuan()
                        if qiankuan > 0 then
                            if money >= qiankuan then
                                if not StaticPopupDialogs["BIAOGE_FASTTRADE_QIANKUAN"] then
                                    StaticPopupDialogs["BIAOGE_FASTTRADE_QIANKUAN"] = {
                                        text = L["交易金额需要减去对方的总欠款吗？\n%s"],
                                        button1 = L["减去并清除欠款"],
                                        button2 = L["不减"],
                                        button3 = CANCEL,
                                        OnButton3 = function()
                                            StaticPopup_Hide("BIAOGE_FASTTRADE_QIANKUAN")
                                        end,
                                        selectCallbackByIndex = true,
                                        timeout = 0,
                                        whileDead = true,
                                        hideOnEscape = true,
                                        showAlert = true,
                                    }
                                end
                                StaticPopupDialogs["BIAOGE_FASTTRADE_QIANKUAN"].OnButton1 = function()
                                    StaticPopupDialogs["BiaoGeClearAllQianKuan"].OnAccept()
                                    SetMoney(money - qiankuan, name, isExpenses, isMan)
                                end
                                StaticPopupDialogs["BIAOGE_FASTTRADE_QIANKUAN"].OnButton2 = function()
                                    SetMoney(money, name, isExpenses, isMan)
                                end
                                StaticPopup_Hide("BIAOGE_FASTTRADE_QIANKUAN2")
                                StaticPopup_Show("BIAOGE_FASTTRADE_QIANKUAN",
                                    format("|cff00ff00%s|r - |cffff0000%s|r = |cffffff00%s|r", money, qiankuan, money - qiankuan))
                            else
                                if not StaticPopupDialogs["BIAOGE_FASTTRADE_QIANKUAN2"] then
                                    StaticPopupDialogs["BIAOGE_FASTTRADE_QIANKUAN2"] = {
                                        text = L["对方还有|cffff0000%s|r欠款，还继续交易对方|cffffff00%s|r？"],
                                        button1 = L["是"],
                                        button2 = L["否"],
                                        OnCancel = function()
                                        end,
                                        timeout = 0,
                                        whileDead = true,
                                        hideOnEscape = true,
                                        showAlert = true,
                                    }
                                end
                                StaticPopupDialogs["BIAOGE_FASTTRADE_QIANKUAN2"].OnAccept = function()
                                    SetMoney(money, name, isExpenses, isMan)
                                end
                                StaticPopup_Hide("BIAOGE_FASTTRADE_QIANKUAN")
                                StaticPopup_Show("BIAOGE_FASTTRADE_QIANKUAN2", qiankuan, money)
                            end
                        else
                            SetMoney(money, name, isExpenses, isMan)
                        end
                    else
                        UIErrorsFrame:AddMessage(L["你的钱不够！"], 1, 0, 0)
                    end
                end)
                bt:SetScript("OnEnter", function(self)
                    ds:Show()
                    if hasMan then
                        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                        GameTooltip:ClearLines()
                        GameTooltip:AddLine(TRADE, 1, 1, 1, true)
                        GameTooltip:AddLine(AddTexture("LEFT") .. TRADE .. money, 1, .82, 0, true)
                        GameTooltip:AddLine(AddTexture("RIGHT") .. TRADE .. hasMan.avg, 1, .82, 0, true)
                        GameTooltip:Show()
                    end
                end)
                bt:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                    if f.tradeing then return end
                    ds:Hide()
                end)
            end

            local l = nameFrame:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("BOTTOMLEFT", 0, 0)
            l:SetEndPoint("BOTTOMLEFT", width, 0)
            l:SetThickness(1)
        end

        local function GetTargetTeamMember()
            local targetName = BG.GN("NPC")
            local targetTeam
            local team = {}
            for _, v in pairs(BG.raidRosterInfo) do
                if v.name ~= player then
                    team[v.subgroup] = team[v.subgroup] or 0
                    team[v.subgroup] = team[v.subgroup] + 1
                end
                if v.name == targetName then
                    targetTeam = v.subgroup
                end
            end
            return team[targetTeam] or 0
        end
        local function GetLeaderIcon(player)
            local icon = ""
            for i, v in ipairs(BG.raidRosterInfo) do
                if v.name == player then
                    if v.rank == 2 then
                        icon = icon .. AddTexture("interface/groupframe/ui-group-leadericon")
                    elseif v.isML then
                        icon = icon .. AddTexture("interface/groupframe/ui-group-masterlooter")
                    end
                    break
                end
            end
            return icon
        end
        function BG.UpdateTradeFastGiveMoneyFrame()
            if BG.tradeFastGiveMoneyFrame.frame then
                BG.tradeFastGiveMoneyFrame.frame:Hide()
            end
            if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradePreview"] == 1 and IsInRaid(1) then
                BG.CreateTradeFastGiveMoneyFrame()
                mainFrame:Show()
                if BG.ImML() then
                    mainFrame:ClearAllPoints()
                    mainFrame:SetPoint("TOPLEFT", TradeFrame, "TOPRIGHT", 1, -20)
                    local w1 = TradeFrame:GetTop()
                    local w2 = BG.tradelastAuctionFrame.frame:GetTop()
                    mainFrame:SetHeight(w1 - w2 - 20 - 2)
                    frame:SetHeight(mainFrame:GetHeight() - 25)
                else
                    if gzTbl and BG.IsMLByName(gzTbl.player) then
                        mainFrame:ClearAllPoints()
                        mainFrame:SetPoint("BOTTOMLEFT", BG.tradeSeeFrame.frame, "TOPLEFT", 0, 1)
                        mainFrame:SetHeight(100)
                        frame:SetHeight(mainFrame:GetHeight() - 25)
                    else
                        mainFrame:Hide()
                    end
                end

                StaticPopup_Hide("BIAOGE_FASTTRADE_QIANKUAN")
                StaticPopup_Hide("BIAOGE_FASTTRADE_QIANKUAN2")
                lastClick = nil
                for _, bt in pairs(buttons) do
                    bt:Hide()
                end
                wipe(buttons)
                local FB = BG.FB1

                if BG.ImML() then
                    local money = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. 5]:GetText()) or 0
                    local targetTeamMember = GetTargetTeamMember()
                    CreateButton(L["单人工资"], money)
                    CreateButton(format(L["%s人工资"], targetTeamMember), money * targetTeamMember)
                    local i = 1
                    while BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i] do
                        local item = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i]:GetText()
                        local hasMan = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i].hasMan
                        local money = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]:GetText())
                        if item ~= "" and money and money ~= 0 then
                            CreateButton(item, money, true, hasMan)
                        end
                        i = i + 1
                    end
                else
                    if gzTbl and BG.IsMLByName(gzTbl.player) then
                        CreateButton(L["单人工资"], gzTbl.money)
                        local parent = buttons[1]
                        local t = parent:CreateFontString()
                        t:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                        t:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, -5)
                        t:SetTextColor(.5, .5, .5)
                        t:SetWidth(parent:GetWidth() - 2)
                        t:SetJustifyH("LEFT")
                        local time = GetServerTime() - gzTbl.time
                        t:SetText(format(L["数据来源：\n|cffffffff%s秒|r前%s通报的账单"], time, GetLeaderIcon(gzTbl.player) .. gzTbl.colorplayer))
                    end
                end
            end
        end

        -- 记录团长通报的工资
        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:RegisterEvent("CHAT_MSG_RAID")
        f:SetScript("OnEvent", function(self, event, msg, sender, ...)
            sender = BG.GSN(sender)
            if not BG.IsMLByName(sender) then return end
            local gz = msg:match("^人均工资：(%d+)")
            if not gz then
                gz = msg:match("^人均薪水：(%d+)")
            end
            if gz then
                gzTbl = {
                    player = sender,
                    colorplayer = SetClassCFF(sender),
                    money = tonumber(gz),
                    time = GetServerTime(),
                }
                -- x分钟后删除记录
                self.t = 0
                self:SetScript("OnUpdate", function(_, t)
                    self.t = self.t + t
                    if self.t >= 60 * 10 then
                        gzTbl = nil
                        self:SetScript("OnUpdate", nil)
                    end
                end)
            end
        end)

        BG.RegisterEvent("TRADE_CLOSED", function(self, ...)
            StaticPopup_Hide("BIAOGE_FASTTRADE_QIANKUAN")
            StaticPopup_Hide("BIAOGE_FASTTRADE_QIANKUAN2")
        end)

        -- 记录已经交易成功的补贴
        BG.RegisterEvent("UI_INFO_MESSAGE", function(self, event, _, text)
            if text == ERR_TRADE_COMPLETE and BiaoGe.options["autoTrade"] == 1 and IsInRaid(1) and lastClick then
                if lastClick.money == BG.trade.playermoney then
                    local name = lastClick.name
                    givedTbl[name] = { time = time() }
                    -- x分钟后删除记录
                    BG.After(60 * 5, function()
                        if givedTbl[name] then
                            if time() - givedTbl[name].time >= 60 * 5 then
                                givedTbl[name] = nil
                            end
                        end
                    end)
                end
            end
        end)
    end

    -- 摆放交易金币
    do
        function BG.ResetTradeMoney()
            local playerTradeMoney = GetPlayerTradeMoney()
            if playerTradeMoney > 0 then
                ClearCursor()
                PickupTradeMoney(playerTradeMoney)
                ClearCursor()
            end
        end

        local function PickUpMyMoney(money)
            ClearCursor()
            PickupPlayerMoney(money)
            _G["TradePlayerItem1ItemButton"]:Click()
        end
        function BG.SetMyTradeMoney(giveMoney)
            BG.tradeMyMoneyFrame.canShow = true
            BG.ResetTradeMoney()
            giveMoney = giveMoney * 10000
            local money = GetMoney()
            if money >= giveMoney then
                PickUpMyMoney(giveMoney)
            else
                UIErrorsFrame:AddMessage(L["你的钱不够！"], 1, 0, 0)
            end
            BG.TradeUpdate()
        end
    end

    -- 我的实际交易金币
    do
        local f = CreateFrame("Frame", nil, TradeFrame, "BackdropTemplate")
        f:SetSize(170, 20)
        f:SetPoint("BOTTOM", TradePlayerInputMoneyInsetBg, "TOP", 0, -0)
        f:SetFrameLevel(TradeRecipientMoneyBg:GetFrameLevel() + 15)
        BG.tradeMyMoneyFrame = f
        local t = f:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
        t:SetPoint("BOTTOM")
        t:SetWidth(f:GetWidth() - 10)
        t:SetTextColor(1, 1, 1)
        t:SetJustifyH("LEFT")
        f.Text = t

        -- 重置金币
        local bt = CreateFrame("Button", nil, f)
        do
            bt:SetSize(16, 16)
            bt:SetPoint("BOTTOMLEFT", t, "BOTTOMRIGHT", 0, 0)
            local tex = bt:CreateTexture()
            tex:SetPoint("CENTER")
            tex:SetSize(bt:GetWidth() + 10, bt:GetHeight() + 10)
            tex:SetTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Up]])
            bt:SetNormalTexture(tex)
            local tex = bt:CreateTexture()
            tex:SetPoint("CENTER")
            tex:SetSize(bt:GetWidth() + 10, bt:GetHeight() + 10)
            tex:SetTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Down]])
            bt:SetPushedTexture(tex)
            local tex = bt:CreateTexture()
            tex:SetPoint("CENTER")
            tex:SetSize(bt:GetWidth() + 10, bt:GetHeight() + 10)
            tex:SetTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]])
            bt:SetHighlightTexture(tex)
            bt:SetScript("OnClick", function(self)
                f.alwaysShow = true
                BG.ResetTradeMoney()
                BG.TradeUpdate()
            end)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["重置交易金额"], 1, 1, 1, true)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)
        end
        function BG.tradeMyMoneyFrame:Reset()
            self:Hide()
            self.alwaysShow = nil
            self.canShow = nil
        end

        function BG.tradeMyMoneyFrame:Update()
            if not BG.tradeMyMoneyFrame.canShow then
                self:Hide()
                return
            end
            local money = tonumber(floor(GetPlayerTradeMoney() / 10000)) or 0
            if money == 0 and not self.alwaysShow then
                self:Hide()
            else
                self:Show()
                t:SetText(format(L["实际交易：%s"], money) .. goldTex)
                bt:ClearAllPoints()
                bt:SetPoint("BOTTOMLEFT", t:GetWrappedWidth() + 10, 0)
            end
        end

        BG.tradeMyMoneyFrame:Update()
    end

    -- 交易通知框架
    do
        local name = "tradeTime"
        BG.options[name .. "reset"] = 3
        local f = CreateFrame("ScrollingMessageFrame", "BG.FrameTradeMsg", UIParent, "BackdropTemplate")
        f:SetSpacing(1)                                                       -- 行间隔
        f:SetFadeDuration(1)                                                  -- 淡出动画的时间
        f:SetTimeVisible(BiaoGe.options[name] or BG.options[name .. "reset"]) -- 可见时间
        f:SetJustifyH("LEFT")                                                 -- 对齐格式
        f:SetSize(350, 150)                                                   -- 大小
        f:SetFont(STANDARD_TEXT_FONT, BiaoGe.options["tradeFontSize"] or 20, "OUTLINE")
        f:SetFrameLevel(131)
        f:SetFrameStrata("FULLSCREEN_DIALOG")
        f:SetClampedToScreen(true)
        f:SetHyperlinksEnabled(true)
        f.homepoin = { "BOTTOM", nil, "CENTER", 50, 100 }
        if BiaoGe.point[f:GetName()] then
            BiaoGe.point[f:GetName()][2] = nil
            f:SetPoint(unpack(BiaoGe.point[f:GetName()]))
        else
            f:SetPoint(unpack(f.homepoin)) --设置显示位置
        end
        tinsert(BG.Movetable, f)
        BG.FrameTradeMsg = f

        f.name = f:CreateFontString()
        f.name:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        f.name:SetTextColor(1, 1, 1, 1)
        f.name:SetText(L["交易通知"])
        f.name:SetPoint("TOP", 0, -5)
        f.name:Hide()

        f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
            local arg1, arg2, arg3, arg4 = strsplit(":", link)
            if arg2 == "BiaoGeYY" and arg3 == L["详细"] and arg4 then
                local yy = arg4
                BG.OnEnterYYXiangXi(yy, self, "ANCHOR_CURSOR")
            else
                local itemID = GetItemInfoInstant(link)
                if itemID then
                    GameTooltip:SetOwner(self, "ANCHOR_CURSOR", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))
                end
            end
        end)
        f:SetScript("OnHyperlinkLeave", function(self, link, text, button)
            GameTooltip:Hide()
        end)
        f:SetScript("OnHyperlinkClick", function(self, link, text, button)
            local arg1, arg2, arg3, arg4 = strsplit(":", link)
            if arg2 == "BiaoGeYY" and arg3 == L["详细"] and arg4 then
                local yy = arg4
                BG.OnClickYYXiangXi(yy)
                return
            end
            if IsShiftKeyDown() then
                BG.InsertLink(text)
            end
        end)
    end

    -- 自动摆放装备
    do
        BG.tradeAutoPickItem = {}

        BG.tradeUpdateFrame = CreateFrame("Frame")

        -- 创建应收/应付对象
        do
            local f = CreateFrame("Frame", nil, TradeFrame)
            f:SetFrameStrata("HIGH")
            local text = f:CreateFontString()
            text:SetPoint("TOPRIGHT", TradeRecipientMoneyBg, "BOTTOMRIGHT", -5, 3)
            text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
            BG.trade.GiveMeMoneyText = text

            local f = CreateFrame("Frame", nil, TradeFrame)
            f:SetFrameStrata("HIGH")
            local text = f:CreateFontString()
            text:SetPoint("TOPLEFT", TradePlayerInputMoneyInsetBg, "BOTTOMLEFT", 0, 3)
            text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
            BG.trade.GiveYouMoneyText = text

            for i = 1, 6 do
                local text = _G["TradePlayerItem" .. i .. "ItemButton"]:CreateFontString()
                text:SetPoint("BOTTOMLEFT", _G["TradePlayerItem" .. i .. "ItemButton"], "BOTTOMRIGHT", 8, -2)
                text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
                text:Hide()
                _G["TradePlayerItem" .. i .. "ItemButton"].moneyText = text

                local text = _G["TradeRecipientItem" .. i .. "ItemButton"]:CreateFontString()
                text:SetPoint("BOTTOMLEFT", _G["TradeRecipientItem" .. i .. "ItemButton"], "BOTTOMRIGHT", 8, -2)
                text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
                text:Hide()
                _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText = text
            end
        end

        local sumTargetMoney = 0
        local sumPlayerMoney = 0

        -- 自动拍卖的每个装备单独记账而不是打包记账
        BG.trade.autoAuction = {}
        function BG.TradeIsAutoAuction()
            local FB = BG.FB1
            wipe(BG.trade.autoAuction)
            local player
            if BG.ImML() then
                player = BG.GN("NPC")
                local targetMoney = math.modf(GetTargetTradeMoney() / 10000)
                local sumqiankuan = tonumber(BG.tradeQianKuanEdit:GetText()) or 0
                if sumTargetMoney ~= 0 and sumTargetMoney == targetMoney + sumqiankuan then
                    for i = 1, 6 do
                        local link = GetTradePlayerItemLink(i)
                        if link then
                            local bt = _G["TradePlayerItem" .. i .. "ItemButton"].moneyText
                            if not bt:IsVisible() then
                                wipe(BG.trade.autoAuction)
                                return
                            end
                            local money = bt.money
                            local qiankuan = 0
                            if sumqiankuan ~= 0 then
                                if sumqiankuan > money then
                                    qiankuan = money
                                    sumqiankuan = sumqiankuan - qiankuan
                                else
                                    qiankuan = sumqiankuan
                                    sumqiankuan = 0
                                end
                            end
                            tinsert(BG.trade.autoAuction, {
                                link = link,
                                player = player,
                                money = money,
                                qiankuan = qiankuan,
                            })
                        end
                    end
                    -- 如果还有剩余欠款
                    if sumqiankuan > 0 then
                        local last = BG.trade.autoAuction[#BG.trade.autoAuction]
                        if last then
                            last.qiankuan = last.qiankuan + sumqiankuan
                        end
                    end
                end
            else
                player = BG.GN()
                local playerMoney = math.modf(GetPlayerTradeMoney() / 10000)
                local sumqiankuan = tonumber(BG.tradeQianKuanEdit:GetText()) or 0
                if sumPlayerMoney ~= 0 and sumPlayerMoney == playerMoney + sumqiankuan then
                    for i = 1, 6 do
                        local link = GetTradeTargetItemLink(i)
                        if link then
                            local bt = _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText
                            if not bt:IsVisible() then
                                wipe(BG.trade.autoAuction)
                                return
                            end
                            local money = bt.money
                            local qiankuan = 0
                            if sumqiankuan ~= 0 then
                                if sumqiankuan > money then
                                    qiankuan = money
                                    sumqiankuan = sumqiankuan - qiankuan
                                else
                                    qiankuan = sumqiankuan
                                    sumqiankuan = 0
                                end
                            end
                            tinsert(BG.trade.autoAuction, {
                                link = link,
                                player = player,
                                money = money,
                                qiankuan = qiankuan,
                            })
                        end
                    end
                    -- 如果还有剩余欠款
                    if sumqiankuan > 0 then
                        local last = BG.trade.autoAuction[#BG.trade.autoAuction]
                        if last then
                            last.qiankuan = last.qiankuan + sumqiankuan
                        end
                    end
                end
            end
            -- 确认表格里是否能全部匹配到合适的格子
            local same = {}
            for _, v in ipairs(BG.trade.autoAuction) do
                local done
                for b = 1, Maxb[FB] do
                    for i = 1, BG.GetMaxi(FB, b) do
                        if not same[b .. "-" .. i] then
                            local bt = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                            if bt and BG.IsSameItem(bt:GetText(), v.link) and
                                BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetText() == "" and
                                BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText() == "" and
                                not BiaoGe[FB]["boss" .. b]["qiankuan" .. i]
                            then
                                v.b = b
                                v.i = i
                                done = true
                                same[b .. "-" .. i] = true
                                break
                            end
                        end
                    end
                    if done then break end
                end
                if not done then
                    wipe(BG.trade.autoAuction)
                    return
                end
            end
        end

        local function UpdateTargetQianKuan()
            if not (BiaoGe.options["autoAuctionMoney"] == 1 and BiaoGe.options["autoAuctionQianKuan"] == 1) then return end
            local targetMoney = GetTargetTradeMoney()
            if targetMoney then
                targetMoney = math.modf(targetMoney / 10000)
                local m = sumTargetMoney - targetMoney
                if m <= 0 then
                    m = ""
                end
                BG.tradeQianKuanEdit:ClearFocus()
                BG.tradeQianKuanEdit:SetText(m)
            end
        end
        local function UpdateMyQianKuan()
            if not (BiaoGe.options["autoAuctionMoney"] == 1 and BiaoGe.options["autoAuctionQianKuan"] == 1) then return end
            local playerMoney = GetPlayerTradeMoney()
            if playerMoney then
                playerMoney = math.modf(playerMoney / 10000)
                local m = sumPlayerMoney - playerMoney
                if m <= 0 then
                    m = ""
                end
                BG.tradeQianKuanEdit:ClearFocus()
                BG.tradeQianKuanEdit:SetText(m)
            end
        end
        local function MLAcceptTrade()
            if not (BiaoGe.options["autoAuctionMoney"] == 1 and BiaoGe.options["autoAuctionSureClick"] == 1) then return end
            local targetMoney = floor(GetTargetTradeMoney() / 1e4)
            if targetMoney > 0 and targetMoney == sumTargetMoney then
                BG.tradeUpdateFrame.elapsed = 0
                BG.tradeUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
                    if not TradeFrame:IsVisible() then
                        self:SetScript("OnUpdate", nil)
                        return
                    end
                    self.elapsed = self.elapsed + elapsed
                    if self.elapsed >= .5 then
                        self:SetScript("OnUpdate", nil)
                        local targetMoney = floor(GetTargetTradeMoney() / 1e4)
                        if targetMoney > 0 and targetMoney == sumTargetMoney then
                            UIErrorsFrame:AddMessage(L["BiaoGe正在申请确认交易"], 1, 1, 0)
                            AcceptTrade()
                        end
                    end
                end)
            end
        end
        local function PlayerAcceptTrade()
            if not (BiaoGe.options["autoAuctionMoney"] == 1 and BiaoGe.options["autoAuctionSureClick"] == 1) then return end
            local playerMoney = floor(GetPlayerTradeMoney() / 1e4)
            if playerMoney > 0 and playerMoney == sumPlayerMoney then
                BG.tradeUpdateFrame.elapsed = 0
                BG.tradeUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
                    if not TradeFrame:IsVisible() then
                        self:SetScript("OnUpdate", nil)
                        return
                    end
                    self.elapsed = self.elapsed + elapsed
                    if self.elapsed >= .5 then
                        self:SetScript("OnUpdate", nil)
                        local playerMoney = floor(GetPlayerTradeMoney() / 1e4)
                        if playerMoney > 0 and playerMoney == sumPlayerMoney then
                            UIErrorsFrame:AddMessage(L["BiaoGe正在申请确认交易"], 1, 1, 0)
                            AcceptTrade()
                        end
                    end
                end)
            else
                BG.tradeUpdateFrame:SetScript("OnUpdate", nil)
            end
        end
        local function SetMyMoney()
            if not (BiaoGe.options["autoAuctionMoney"] == 1 and BiaoGe.options["autoAuctionSetMoney"] == 1) then return end
            if sumPlayerMoney > 0 then
                BG.SetMyTradeMoney(sumPlayerMoney)
            end
        end

        local function UpdateGiveMeMoneyTextColor()
            local targetMoney = GetTargetTradeMoney()
            if targetMoney then
                targetMoney = math.modf(targetMoney / 10000)
                if targetMoney == sumTargetMoney then
                    BG.trade.GiveMeMoneyText:SetTextColor(0, 1, 0)
                    for i = 1, 6 do
                        _G["TradePlayerItem" .. i .. "ItemButton"].moneyText:SetTextColor(0, 1, 0)
                    end
                elseif targetMoney > sumTargetMoney then
                    BG.trade.GiveMeMoneyText:SetTextColor(1, 0, 0)
                    for i = 1, 6 do
                        _G["TradePlayerItem" .. i .. "ItemButton"].moneyText:SetTextColor(1, 0, 0)
                    end
                else
                    BG.trade.GiveMeMoneyText:SetTextColor(1, 0, 0)
                    for i = 1, 6 do
                        _G["TradePlayerItem" .. i .. "ItemButton"].moneyText:SetTextColor(1, 0, 0)
                    end
                end
            end
        end
        local function UpdateGiveYouMoneyTextColor()
            local playerMoney = GetPlayerTradeMoney()
            if playerMoney then
                playerMoney = math.modf(playerMoney / 10000)
                if playerMoney == sumPlayerMoney then
                    BG.trade.GiveYouMoneyText:SetTextColor(0, 1, 0)
                    for i = 1, 6 do
                        _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText:SetTextColor(0, 1, 0)
                    end
                elseif playerMoney > sumPlayerMoney then
                    BG.trade.GiveYouMoneyText:SetTextColor(1, 0, 0)
                    for i = 1, 6 do
                        _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText:SetTextColor(1, 0, 0)
                    end
                else
                    BG.trade.GiveYouMoneyText:SetTextColor(RGB(BG.b1))
                    for i = 1, 6 do
                        _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText:SetTextColor(RGB(BG.b1))
                    end
                end
            end
        end
        local function ResetMoneyText()
            BG.trade.GiveMeMoneyText:Hide()
            BG.trade.GiveYouMoneyText:Hide()
            for i = 1, 6 do
                _G["TradePlayerItem" .. i .. "ItemButton"].moneyText:Hide()
                _G["TradePlayerItem" .. i .. "ItemButton"].moneyText.money = 0
                _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText:Hide()
                _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText.money = 0
            end
        end

        -- 团长自动摆放装备
        function BG.tradeAutoPickItem:Start()
            BG.auctionLogFrame.GetTargetTradeTbl(BG.ImML() and BG.GN("NPC") or player)
            sumTargetMoney = 0
            sumPlayerMoney = 0
            for i = 1, 6 do
                _G["TradePlayerItem" .. i .. "ItemButton"].moneyText:Hide()
                _G["TradePlayerItem" .. i .. "ItemButton"].moneyText.money = 0
                _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText:Hide()
                _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText.money = 0
            end
            BG.trade.GiveMeMoneyText:Hide()
            BG.trade.GiveYouMoneyText:Hide()
            if BiaoGe.options["autoAuctionPut"] ~= 1 then return end
            if not BG.ImML() then return end
            local tradeName = BG.GN("NPC")
            if not (BG.auctionTrade[tradeName] and next(BG.auctionTrade[tradeName])) then return end
            ClearCursor()
            local bagTbl = {}
            local tradeTbl = {}
            local function GiveItem(index)
                if not TradeFrame:IsVisible() then return end
                local v = BG.auctionTrade[tradeName][index]
                if not v then return end
                for b = 0, NUM_BAG_SLOTS do
                    for i = 1, C_Container.GetContainerNumSlots(b) do
                        if not bagTbl[b .. "-" .. i] then
                            local info = C_Container.GetContainerItemInfo(b, i)
                            if info then
                                if BG.IsSameItem(v.zhuangbei, info.hyperlink) and not info.isLocked then
                                    local notBound
                                    if not info.isBound then
                                        notBound = true
                                    else
                                        BiaoGeTooltip3:SetOwner(UIParent, "ANCHOR_NONE", 0, 0)
                                        BiaoGeTooltip3:ClearLines()
                                        BiaoGeTooltip3:SetBagItem(b, i)
                                        local ii = 1
                                        while _G["BiaoGeTooltip3TextLeft" .. ii] do
                                            local tx = _G["BiaoGeTooltip3TextLeft" .. ii]:GetText()
                                            if tx then
                                                local time = tx:match(BIND_TRADE_TIME_REMAINING:gsub("%%s", "(.+)"))
                                                if time then
                                                    notBound = true
                                                    break
                                                end
                                            end
                                            ii = ii + 1
                                        end
                                    end
                                    if notBound then
                                        for ii = 1, 6 do
                                            if not tradeTbl[ii] then
                                                if not GetTradePlayerItemLink(ii) then
                                                    C_Container.PickupContainerItem(b, i)
                                                    _G["TradePlayerItem" .. ii .. "ItemButton"]:Click()
                                                    ClearCursor()
                                                    bagTbl[b .. "-" .. i] = true
                                                    tradeTbl[ii] = true
                                                    BG.After(0.02, function()
                                                        GiveItem(index + 1)
                                                    end)
                                                    return
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                GiveItem(index + 1)
            end
            GiveItem(1)
        end

        -- 团长
        BG.RegisterEvent("TRADE_PLAYER_ITEM_CHANGED", function(self, ...)
            sumTargetMoney = 0
            ResetMoneyText()
            if not BG.ImML() then return end
            local tradeName = BG.GN("NPC")
            if not (BG.auctionTrade[tradeName] and next(BG.auctionTrade[tradeName])) then return end
            local haveItem = {}
            for _, v in ipairs(BG.auctionTrade[tradeName]) do
                local money = tonumber(v.jine) or 0
                for i = 1, 6 do
                    if not haveItem[i] then
                        local link = GetTradePlayerItemLink(i)
                        if link then
                            if GetItemID(v.zhuangbei) == GetItemID(link) then
                                haveItem[i] = true
                                sumTargetMoney = sumTargetMoney + money
                                if BiaoGe.options["autoAuctionMoney"] == 1 then
                                    _G["TradePlayerItem" .. i .. "ItemButton"].moneyText:Show()
                                    _G["TradePlayerItem" .. i .. "ItemButton"].moneyText:SetText(L["应收："] .. GetMoneyString(tonumber(money .. "0000")))
                                    _G["TradePlayerItem" .. i .. "ItemButton"].moneyText.money = money
                                end
                                break
                            end
                        end
                    end
                end
            end
            if BiaoGe.options["autoAuctionMoney"] == 1 then
                if sumTargetMoney ~= 0 then
                    BG.trade.GiveMeMoneyText:Show()
                    BG.trade.GiveMeMoneyText:SetText(L["合计应收："] .. GetMoneyString(tonumber(sumTargetMoney .. "0000")))
                    UpdateGiveMeMoneyTextColor()
                end
            end
            UpdateTargetQianKuan()
        end)

        -- 团员
        BG.RegisterEvent("TRADE_TARGET_ITEM_CHANGED", function(self, ...)
            sumPlayerMoney = 0
            ResetMoneyText()
            if BG.ImML() then return end
            local tradeName = player
            if not (BG.auctionTrade[tradeName] and next(BG.auctionTrade[tradeName])) then return end
            local haveItem = {}
            for _, v in ipairs(BG.auctionTrade[tradeName]) do
                local money = tonumber(v.jine) or 0
                for i = 1, 6 do
                    if not haveItem[i] then
                        local link = GetTradeTargetItemLink(i)
                        if link then
                            if GetItemID(v.zhuangbei) == GetItemID(link) then
                                haveItem[i] = true
                                sumPlayerMoney = sumPlayerMoney + money
                                if BiaoGe.options["autoAuctionMoney"] == 1 then
                                    _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText:Show()
                                    _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText:SetText(L["应付："] .. GetMoneyString(tonumber(money .. "0000")))
                                    _G["TradeRecipientItem" .. i .. "ItemButton"].moneyText.money = money
                                end
                                break
                            end
                        end
                    end
                end
            end
            if BiaoGe.options["autoAuctionMoney"] == 1 then
                if sumPlayerMoney ~= 0 then
                    BG.trade.GiveYouMoneyText:Show()
                    BG.trade.GiveYouMoneyText:SetText(L["合计应付："] .. GetMoneyString(tonumber(sumPlayerMoney .. "0000")))
                    UpdateGiveYouMoneyTextColor()
                end
            end
            UpdateMyQianKuan()
            SetMyMoney()
        end)

        BG.RegisterEvent("TRADE_MONEY_CHANGED", function(self, ...)
            if not BG.ImML() then return end
            if BG.trade.GiveMeMoneyText:IsVisible() then
                UpdateGiveMeMoneyTextColor()
            end
            UpdateTargetQianKuan()
            MLAcceptTrade()
        end)

        function BG.tradeAutoPickItem.TradeMyMoneyChange()
            if not TradeFrame:IsVisible() then return end
            if BG.ImML() then return end
            if BG.trade.GiveYouMoneyText:IsVisible() then
                UpdateGiveYouMoneyTextColor()
            end
            UpdateMyQianKuan()
            PlayerAcceptTrade()
        end

        -- 交易成功后，把拍卖记录设为已交易
        BG.RegisterEvent("UI_INFO_MESSAGE", function(self, event, _, text)
            if text ~= ERR_TRADE_COMPLETE then return end
            local FB = BG.FB1
            if not BiaoGe[FB].auctionLog then return end
            local tradeName, tradeTbl
            if BG.ImML() then
                tradeName = BG.trade.target
                tradeTbl = BG.trade.playeritems
            else
                tradeName = BG.trade.player
                tradeTbl = BG.trade.targetitems
            end
            for _, vv in ipairs(tradeTbl) do
                for _, v in ipairs(BiaoGe[FB].auctionLog) do
                    if v.type == 1 and not v.trade and v.maijia == tradeName and
                        GetItemID(v.zhuangbei) == GetItemID(vv.link) then
                        v.trade = true
                        break
                    end
                end
            end
            BG.UpdateAuctionLogFrame(true, true)
        end)
    end

    -- 交易状态变化时
    do
        function BG.TradeUpdate()
            if not TradeFrame:IsVisible() then return end
            BG.GetTradeInfo()
            BG.tradeSeeFrame.frame:Update()
            BG.tradeSameMoney:Update()
            BG.tradeGoldTop:Update()
            BG.tradeMyMoneyFrame:Update()
            BG.tradeAutoPickItem.TradeMyMoneyChange()
        end

        hooksecurefunc(C_TradeInfo, "SetTradeMoney", function(money)
            BG.After(0, function()
                BG.TradeUpdate()
            end)
        end)

        local f = CreateFrame("Frame")
        f:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED")
        f:RegisterEvent("TRADE_TARGET_ITEM_CHANGED")
        f:RegisterEvent("TRADE_MONEY_CHANGED")
        f:SetScript("OnEvent", function(...)
            BG.TradeUpdate()
        end)
    end

    -- 交易开始
    BG.RegisterEvent("TRADE_SHOW", function(self, ...)
        BG.ResetTradeInfo()
        BG.tradeQianKuanEdit:Update()
        BG.tradeGoldTop:Update()
        BG.tradeSameMoney:Update()
        BG.tradeMyMoneyFrame:Reset()

        BG.tradeQianKuanListFrame:Reset()
        BG.tradeQianKuanListFrame:Update()

        BG.tradeSeeFrame.frame:Reset()
        BG.tradelastAuctionFrame.frame:UpdateShow()
        BG.UpdateTradeFastGiveMoneyFrame()

        BG.tradeAutoPickItem:Start()
    end)
    BG.RegisterEvent("UI_INFO_MESSAGE", function(self, event, _, text)
        if text == ERR_TRADE_COMPLETE then
            BG.tradeSameMoney:SaveTradeMoney()
            BG.tradeSeeFrame.frame:SaveMoney()
        end
    end)
end)
