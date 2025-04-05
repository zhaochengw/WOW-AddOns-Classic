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

BG.Init(function()
    -- 函数：交易自动记录买家和金额
    do
        BG.tradeQuality = 0
        BG.trade = {}
        BG.trade.many = {}
        BG.trade.playerinfo = {}
        BG.trade.targetinfo = {}
        BG.trade.targetitems = {}
        BG.trade.playeritems = {}
        function BG.GetTradeInfo()
            BG.trade.many = {}
            BG.trade.playerinfo = {}
            BG.trade.targetinfo = {}
            wipe(BG.trade.targetitems)
            wipe(BG.trade.playeritems)
            BG.trade.target = BG.GN("NPC")
            BG.trade.player = BG.GN()
            BG.trade.targetmoney = GetTargetTradeMoney()
            BG.trade.playermoney = GetPlayerTradeMoney()
            for k, v in pairs(BG.playerClass) do
                BG.trade.playerinfo[k] = select(v.select, v.func("player"))
                BG.trade.targetinfo[k] = select(v.select, v.func("NPC"))
            end

            --只留金币，去除银桐
            if BG.trade.playermoney then
                BG.trade.playermoney = math.modf(BG.trade.playermoney / 10000)
            end
            --只留金币，去除银桐
            if BG.trade.targetmoney then
                BG.trade.targetmoney = math.modf(BG.trade.targetmoney / 10000)
            end

            for i = 1, 6 do
                local targetitem = GetTradeTargetItemLink(i)
                local name, texture, quantity, quality, isUsable, enchant = GetTradeTargetItemInfo(i)
                if quality >= BG.tradeQuality and targetitem then
                    table.insert(BG.trade.targetitems, { link = targetitem, count = quantity })
                end

                local playeritem = GetTradePlayerItemLink(i)
                local name, texture, quantity, quality, isUsable, enchant = GetTradePlayerItemInfo(i)
                if quality >= BG.tradeQuality and playeritem then
                    table.insert(BG.trade.playeritems, { link = playeritem, count = quantity })
                end
            end
        end

        local function CancelGuanZhuAndHope(itemID)
            local name, link = GetItemInfo(itemID)
            local haveguanzhu, havehope
            for _, FB in pairs(BG.FBtable) do
                for b = 1, Maxb[FB] do
                    for i = 1, BG.Maxi do
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

        function BG.TradeText(saved)
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
                BG.tradeDropDown.DropDown:Hide()
                return returntext
            end
            -- 双方都给出装备
            if targetitems[1] and playeritems[1] and targetmoney == 0 and playermoney == 0 then --双方都有装备，但没金额，这种是交易失败
                returntext = ("|cffDC143C" .. L["< 交易记账失败 >"] .. RN .. L["双方都给了装备，但没金额"] .. NN .. L["我不知道谁才是买家"] .. NN .. NN .. L["如果有金额我就能识别了"])
                BG.tradeDropDown.DropDown:Hide()
                BG.tradeSeeFrame.frame:SetFalseColor()
                return returntext
            end
            local qiankuan = 0
            if BG.QianKuan.edit then
                if tonumber(BG.QianKuan.edit:GetText()) then
                    qiankuan = qiankuan + tonumber(BG.QianKuan.edit:GetText())
                end
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
                            for i = 1, BG.Maxi do
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
                                        BiaoGe[FB]["boss" .. b]["maijia" .. i] = (Player)
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
                                        BG.tradeDropDown.DropDown:Hide()
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

                    if not BG.tradeDropDown.Boss then
                        returntext = ("|cffDC143C" .. L["< 交易记账失败 >"] .. RN .. L["表格里没找到此次交易的装备，或者该装备已记过账"])
                        BG.tradeDropDown.DropDown:Show()
                        BG.tradeSeeFrame.frame:SetFalseColor()
                        return returntext
                    else
                        local b = BG.tradeDropDown.Boss
                        for i = 1, BG.Maxi, 1 do
                            if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                                if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText() == "" then
                                    if saved then
                                        BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:SetText(Items[1].link)
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetText(Player)
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetCursorPosition(0)
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetTextColor(GetClassRGB(Player))
                                        BG.Frame[FB]["boss" .. b]["jine" .. i]:SetText(Money + qiankuan)
                                        BiaoGe[FB]["boss" .. b]["zhuangbei" .. i] = (Items[1].link)
                                        BiaoGe[FB]["boss" .. b]["maijia" .. i] = (Player)
                                        BiaoGe[FB]["boss" .. b]["jine" .. i] = (Money + qiankuan)
                                        for k in pairs(BG.playerClass) do
                                            if Player == BG.GN() then
                                                BiaoGe[FB]["boss" .. b][k .. i] = BG.trade.playerinfo[k]
                                            else
                                                BiaoGe[FB]["boss" .. b][k .. i] = BG.trade.targetinfo[k]
                                            end
                                        end
                                        if qiankuan ~= 0 then
                                            BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = qiankuan
                                            BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Show()
                                        end
                                    end

                                    local Texture = select(10, GetItemInfo(Items[1].link))
                                    returntext = (format("|cff00BFFF" .. L["< 交易记账成功 >|r\n装备：%s\n买家：%s\n金额：%s%d|rg%s\nBoss：%s%s|r"],
                                        (AddTexture(Texture) .. Items[1].link),
                                        SetClassCFF(Player), "|cffFFD700",
                                        (Money + qiankuan),
                                        qiankuantext,
                                        "|cff" .. BG.Boss[FB]["boss" .. b]["color"], BG.Boss[FB]["boss" .. b]["name2"]))
                                    BG.tradeDropDown.DropDown:Show()
                                    return returntext
                                end
                            end
                        end
                        returntext = ("|cffDC143C" .. L["< 交易记账失败 >"] .. RN .. L["该BOSS格子已满"])
                        BG.tradeDropDown.DropDown:Show()
                        BG.tradeSeeFrame.frame:SetFalseColor()
                        return returntext
                    end
                end
            end
            BG.tradeDropDown.DropDown:Hide()
            return returntext
        end
    end

    -- 交易欠款输入框
    do
        BG.QianKuan = {}
        local frame = CreateFrame("Frame", nil, TradeFrame, "BackdropTemplate")
        frame:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1.5
        })
        frame:SetBackdropColor(0.5, 0, 0.1, 0.5)
        frame:SetBackdropBorderColor(0.5, 0, 0.1, 1)
        frame:SetSize(130, 25)
        frame:SetPoint("BOTTOM", TradeRecipientMoneyBg, "TOPLEFT", -10, 3)
        frame:SetToplevel(true)
        frame:EnableMouse(true)
        frame:SetFrameLevel(TradeRecipientMoneyBg:GetFrameLevel() + 1)
        BG.QianKuan.frame = frame

        local edit = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
        edit:SetSize(70, 20)
        edit:SetPoint("RIGHT", BG.QianKuan.frame, -5, 0)
        edit:SetText("")
        edit:SetTextColor(RGB("FF0000"))
        edit:SetNumeric(true)
        edit:SetAutoFocus(false)
        BG.QianKuan.edit = edit
        edit:SetScript("OnTextChanged", function(self)
            BG.UpdateTwo0(self)
            BG.GetTradeInfo()
            BG.tradeSeeFrame.text:SetText(BG.TradeText())
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
                f:SetPoint("TOP", BG.QianKuan.frame, "BOTTOM", 0, 0)
            end
        end)
        edit:HookScript("OnEditFocusLost", function(self, button)
            if BG.FrameNumFrame then
                BG.FrameNumFrame:Hide()
            end
        end)

        local text = edit:CreateFontString()
        text:SetPoint("RIGHT", BG.QianKuan.edit, "LEFT", -8, 0)
        text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
        text:SetTextColor(RGB("FF0000"))
        text:SetText(L["欠款："])
        BG.QianKuan.text = text

        _G.TradeFrame:HookScript("OnMouseDown", function(self, enter)
            edit:ClearFocus()
        end)
    end

    -- 金币超上限
    do
        local f = CreateFrame("Frame", nil, TradeFrame)
        f:SetFrameStrata("HIGH")
        local t = f:CreateFontString()
        t:SetPoint("BOTTOMRIGHT", TradeRecipientMoneyBg, "TOPRIGHT", 0, 0)
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetTextColor(RGB(BG.r1))
        t:SetText(L["金币已超上限！"])
        t:Hide()
        BG.tradeGoldTop = t
        if BG.IsVanilla then
            BG.tradeGoldTop.num = 214745
        else
            BG.tradeGoldTop.num = 999999
        end
    end

    -- 重复交易
    do
        local f = CreateFrame("Frame", nil, TradeFrame)
        f:SetFrameStrata("HIGH")
        local t = f:CreateFontString()
        t:SetPoint("BOTTOMLEFT", TradePlayerInputMoneyFrame, "TOPLEFT", 0, 0)
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetTextColor(RGB(BG.r1))
        t:SetText(L["重复交易！"])
        f:Hide()
        BG.tradeSaveMoney = f
        BG.tradeSaveMoney.trade = {}
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
            GameTooltip:AddLine(format(L["你%s秒前曾交给他相同的金币！"], BG.tradeSaveMoney.beforeTime), 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", GameTooltip_Hide)

        function BG.tradeSaveMoney:SaveTradeMoney()
            if not (BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradeSameMoney"] == 1) then return end
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

        function BG.tradeSaveMoney:UpdateFrame()
            self:Hide()
            if not (BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradeSameMoney"] == 1) then return end
            local money = BG.trade.playermoney
            if not money or money == 0 or not BG.trade.target or not self.trade[BG.trade.target] then return end
            local isSame
            for _, v in ipairs(self.trade[BG.trade.target]) do
                if v.money == money then
                    isSame = true
                    self.beforeTime = time() - v.time
                    break
                end
            end
            if not isSame then return end
            if next(BG.trade.targetitems) or next(BG.trade.playeritems) or not BG.trade.target then
                return
            end
            self:Show()
            UIErrorsFrame:AddMessage(L["重复交易！"], 1, 0, 0)
        end

        C_Timer.NewTicker(30, function()
            local time = time()
            for name in pairs(BG.tradeSaveMoney.trade) do
                for i = #BG.tradeSaveMoney.trade[name], 1, -1 do
                    local v = BG.tradeSaveMoney.trade[name][i]
                    if time - v.time >= 60 * 2 then
                        tremove(BG.tradeSaveMoney.trade[name], i)
                    end
                end
            end
        end)
    end

    -- 欠款记录
    do
        -- local old = TradeFrame
        -- local TradeFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
        -- TradeFrame:SetBackdrop({
        --     bgFile = "Interface/ChatFrame/ChatFrameBackground",
        --     edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        --     edgeSize = 16,
        --     insets = { left = 3, right = 3, top = 3, bottom = 3 }
        -- })
        -- TradeFrame:SetBackdropColor(0, 0, 0, 0.8)
        -- TradeFrame:SetSize(old:GetSize())
        -- TradeFrame:SetPoint("TOPLEFT", 16, -116)
        -- TradeFrame:SetToplevel(true)
        -- TradeFrame:EnableMouse(true)

        BG.qiankuanTradeFrame = {}
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
        BG.qiankuanTradeFrame.frame = f

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
            BG.qiankuanTradeFrame.Update()
        end)

        -- 总欠款
        local f = CreateFrame("Frame", nil, BG.qiankuanTradeFrame.frame)
        f:SetSize(0, 20)
        f:SetPoint("BOTTOMLEFT", 33, 5)
        f.text = f:CreateFontString()
        f.text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        f.text:SetPoint("LEFT")
        f.text:SetText(L["合计欠款："])
        f.text:SetJustifyH("LEFT")
        f:SetWidth(f.text:GetStringWidth())
        BG.qiankuanTradeFrame.Text1 = f

        local f = CreateFrame("Frame", nil, BG.qiankuanTradeFrame.Text1)
        f:SetSize(100, 20)
        f:SetPoint("LEFT", BG.qiankuanTradeFrame.Text1, "RIGHT", 5, 0)
        f.text = f:CreateFontString()
        f.text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        f.text:SetAllPoints()
        f.text:SetTextColor(1, 0, 0)
        f.text:SetJustifyH("LEFT")
        BG.qiankuanTradeFrame.Text2 = f

        local bt = BG.CreateButton(BG.qiankuanTradeFrame.Text1)
        bt:SetSize(100, 20)
        bt:SetPoint("BOTTOMRIGHT", BG.qiankuanTradeFrame.frame, "BOTTOMRIGHT", -7, 5)
        bt:SetText(L["清除全部欠款"])
        BG.qiankuanTradeFrame.ButtonClearAll = bt
        bt:SetScript("OnClick", function(self)
            local unit = "NPC"
            if BG.DeBug then unit = "player" end
            local target = BG.GN(unit)
            local class = select(2, UnitClass(unit))
            local color = select(4, GetClassColor(class))
            StaticPopup_Show("BIAOGE_CLEAR_ALL_QIANKUAN", "|c" .. color .. target .. RR, BG.qiankuanTradeFrame.Text2.text:GetText())
        end)


        local frame, child = BG.CreateScrollFrame(BG.qiankuanTradeFrame.frame, BG.qiankuanTradeFrame.frame:GetWidth() - 15, BG.qiankuanTradeFrame.frame:GetHeight() - 55)
        frame:SetPoint("TOPLEFT", 7.5, -25)
        frame:SetBackdrop({
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        frame:SetBackdropBorderColor(.5, .5, .5, .5)

        local buttons = {}

        function BG.qiankuanTradeFrame.Update()
            BG.qiankuanTradeFrame.frame:Hide()
            if not (BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["qiankuanTrade"] == 1) then return end
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
                for i = 1, BG.Maxi do
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
                                bt:SetScript("OnClick", function(self)
                                    BG.PlaySound(1)
                                    local class = select(2, UnitClass(unit))
                                    local color = select(4, GetClassColor(class))
                                    BG.SendSystemMessage(format(L["已清除%s的%s欠款|cff00FF00%s|r。"],
                                        "|c" .. color .. target .. RR,
                                        zhuangbei:GetText():gsub("|cff......|Hitem:.-%[(.-)%]|h|r", "%1"),
                                        BiaoGe[FB]["boss" .. b]["qiankuan" .. i]))

                                    BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = nil
                                    BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Hide()

                                    BG.qiankuanTradeFrame.Update()
                                end)
                                bt:SetScript("OnEnter", function(self)
                                    bts.ds:Show()
                                end)
                                bt:SetScript("OnLeave", function(self)
                                    bts.ds:Hide()
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

            BG.qiankuanTradeFrame.Text2.text:SetText(sum)

            if #buttons > 5 then
                frame.scroll.ScrollBar:Show()
                frame.scroll:SetWidth(BG.qiankuanTradeFrame.frame:GetWidth() - 15 - 31)
                for i, v in ipairs(buttons) do
                    v.item:SetWidth(v.hasicon and 125 or (125 + v.icon:GetWidth()))
                    v.line:SetEndPoint("BOTTOMLEFT", frame.scroll:GetWidth(), 0)
                    v.frame:SetWidth(BG.qiankuanTradeFrame.frame:GetWidth() - 15 - 31)
                    v.ds:SetWidth(BG.qiankuanTradeFrame.frame:GetWidth() - 15 - 31)
                end
            else
                frame.scroll.ScrollBar:Hide()
                frame.scroll:SetWidth(BG.qiankuanTradeFrame.frame:GetWidth() + 5)
                for i, v in ipairs(buttons) do
                    v.item:SetWidth(v.hasicon and 145 or (145 + v.icon:GetWidth()))
                    v.line:SetEndPoint("BOTTOMLEFT", frame.scroll:GetWidth() - 30, 0)
                    v.frame:SetWidth(BG.qiankuanTradeFrame.frame:GetWidth() - 25)
                    v.ds:SetWidth(BG.qiankuanTradeFrame.frame:GetWidth() - 25)
                end
            end
            if yes then
                BG.qiankuanTradeFrame.frame:Show()
            end
        end

        StaticPopupDialogs["BIAOGE_CLEAR_ALL_QIANKUAN"] = {
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
                    for i = 1, BG.Maxi do
                        local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                        if maijia then
                            if maijia:GetText() == target and BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
                                BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = nil
                                BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Hide()
                            end
                        end
                    end
                end
                BG.SendSystemMessage(format(L["已清除%s的全部欠款|cff00FF00%s|r。"],
                    "|c" .. color .. target .. RR,
                    BG.qiankuanTradeFrame.Text2.text:GetText()))
                BG.qiankuanTradeFrame.Update()
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

        function BG.tradeSeeFrame.frame:SetNormalColor()
            self:SetBackdropColor(0, 0, 0, 0.7)
            self:SetBackdropBorderColor(0, 0, 0, 1)
        end

        function BG.tradeSeeFrame.frame:SetFalseColor()
            self:SetBackdropColor(1, 0, 0, 0.2)
            self:SetBackdropBorderColor(1, 0, 0, 1)
        end

        BG.tradeSeeFrame.frame:SetNormalColor()

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
            -- DEBUG
            --[[         local f = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 2,
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:SetBackdropBorderColor(0, 0, 0, 1)
            f:SetSize(BG.tradeSeeFrame.frame:GetWidth(), 125)
            f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
            f:SetMovable(true)
            f:EnableMouse(true)
            f:SetScript("OnDragStart", f.StartMoving)
            f:SetScript("OnDragStop", f.StopMovingOrSizing)
            BG.tradelastAuctionFrame.frame = f
            BG.After(2, function()
                local itemID = 37790
                local item = Item:CreateFromItemID(itemID)
                item:ContinueOnItemLoad(function()
                    SendChatMessage(select(2, GetItemInfo(itemID)), "RAID")
                end)
                local itemID = 24729
                local item = Item:CreateFromItemID(itemID)
                item:ContinueOnItemLoad(function()
                    SendChatMessage(select(2, GetItemInfo(itemID)), "RAID")
                end)
                local itemID = 4367
                local item = Item:CreateFromItemID(itemID)
                item:ContinueOnItemLoad(function()
                    SendChatMessage(select(2, GetItemInfo(itemID)), "RAID")
                end)
            end) ]]
            --

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
            local tardeName = BG.GN("NPC")
            if not (tardeName and BG.auctionTrade[tardeName] and next(BG.auctionTrade[tardeName])) then return end
            for ii = 1, #BG.auctionTrade[tardeName] do
                local vv = BG.auctionTrade[tardeName][ii]
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
            local tardeName = BG.GN("NPC")
            if tardeName and BG.auctionTrade[tardeName] and next(BG.auctionTrade[tardeName]) then
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
        local mainFrame, frame, child, width
        local buttons = {}
        function BG.CreateTradeFastGiveMoneyFrame()
            local f = CreateFrame("Frame", nil, TradeFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            f:SetBackdropColor(0, 0, 0, 0.7)
            f:SetBackdropBorderColor(0, 0, 0, 1)
            f:SetPoint("TOPLEFT", TradeFrame, "TOPRIGHT", 1, -20)
            if BG.tradelastAuctionFrame.frame:IsVisible() then
                f:SetPoint("BOTTOMRIGHT", BG.tradelastAuctionFrame.frame, "TOPRIGHT", 0, 1)
            else
                f:SetPoint("BOTTOMRIGHT", TradeFrame, "TOPRIGHT", 201, -180)
            end
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

            frame, child = BG.CreateScrollFrame(mainFrame, mainFrame:GetWidth() - 5, mainFrame:GetHeight() - 25, nil, true)
            frame:SetPoint("TOPLEFT", 2.5, -22)
            frame:SetBackdrop(nil)
            frame:SetBackdrop({
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            frame:SetBackdropBorderColor(.5, .5, .5, .5)
            frame.scroll:SetPoint("TOPLEFT", 5, -2)
            frame.scroll:SetWidth(frame:GetWidth() - 10)
            frame.scroll.ScrollBar.scrollStep = nil
            width = frame.scroll:GetWidth()
        end

        local function CreateButton(name, money)
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
                t:SetTextColor(1, .82, 0)
                t:SetText(name)
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
                t:SetTextColor(1, .82, 0)
                t:SetText(money)
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
                bt:SetScript("OnClick", function(self)
                    BG.PlaySound(1)
                    local moneyFrame = TradePlayerInputMoneyFrame
                    local myMoney = floor(GetMoney() / 1e4)
                    if myMoney >= money then
                        MoneyInputFrame_ResetMoney(moneyFrame)
                        _G[moneyFrame:GetName() .. "Gold"]:SetNumber(money)

                        for _, f in pairs(buttons) do
                            f.ds:SetColorTexture(.5, .5, .5, .3)
                            f.tradeing = nil
                        end
                        ds:Show()
                        ds:SetColorTexture(0, 1, 0, .5)
                        f.tradeing = true

                        BG.After(0, function()
                            if not TradeFrame.BiaoGeUpdateFrame then
                                TradeFrame.BiaoGeUpdateFrame = CreateFrame("Frame")
                            end
                            TradeFrame.BiaoGeUpdateFrame.elapsed = 0
                            TradeFrame.BiaoGeUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
                                if not TradeFrame:IsVisible() or BG.tradeSaveMoney:IsVisible() then
                                    self:SetScript("OnUpdate", nil)
                                    return
                                end
                                self.elapsed = self.elapsed + elapsed
                                if self.elapsed >= .2 then
                                    self:SetScript("OnUpdate", nil)
                                    UIErrorsFrame:AddMessage(format(L["确认交易%s%sg？"], SetClassCFF(BG.GN("NPC")), money), 1, 1, 0)
                                    AcceptTrade()
                                end
                            end)
                        end)
                    else
                        UIErrorsFrame:AddMessage(L["你的钱不够！"], 1, 0, 0)
                    end
                end)
                bt:SetScript("OnEnter", function(self)
                    ds:Show()
                end)
                bt:SetScript("OnLeave", function(self)
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
                if v.name ~= player and v.online then
                    team[v.subgroup] = team[v.subgroup] or 0
                    team[v.subgroup] = team[v.subgroup] + 1
                end
                if v.name == targetName then
                    targetTeam = v.subgroup
                end
            end
            return team[targetTeam] or 0
        end
        function BG.UpdateTradeFastGiveMoneyFrame()
            for _, bt in pairs(buttons) do
                bt:Hide()
            end
            wipe(buttons)
            local FB = BG.FB1
            local money = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. 5]:GetText()) or 0
            local targetTeamMember = GetTargetTeamMember()
            CreateButton(L["单人工资"], money)
            CreateButton(format(L["%s人工资"], targetTeamMember), money * targetTeamMember)

            local i = 1
            while BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i] do
                local item = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i]:GetText()
                local money = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]:GetText())
                if item ~= "" and money and money ~= 0 then
                    CreateButton(item, money)
                end
                i = i + 1
            end
        end
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
            BG.tradeSeeFrame.text:SetText(BG.TradeText())
        end)
    end

    -- 强制记账选择框
    do
        BG.tradeDropDown = {}
        BG.tradeDropDown.Yes = false
        BG.tradeDropDown.Boss = nil

        local dropDown = LibBG:Create_UIDropDownMenu("BG.tradeDropDown.DropDown", BG.tradeSeeFrame.frame)
        dropDown:SetPoint("BOTTOM", BG.tradeSeeFrame.frame, "BOTTOM", 25, 20)
        LibBG:UIDropDownMenu_SetWidth(dropDown, 100)
        LibBG:UIDropDownMenu_SetText(dropDown, L["无"])
        BG.dropDownToggle(dropDown)
        BG.tradeDropDown.DropDown = dropDown

        local text = dropDown:CreateFontString()
        text:SetPoint("RIGHT", dropDown, "LEFT", 10, 3)
        text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        text:SetTextColor(RGB(BG.y2))
        text:SetText("记账到:")
        BG.tradeDropDown.BiaoTi = text
        LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
            local FB = BG.FB1
            for b = 0, Maxb[FB] do
                local info = LibBG:UIDropDownMenu_CreateInfo()
                local bossnametext = ""
                if b ~= 0 then
                    local bossname2 = BG.Boss[FB]["boss" .. b].name2
                    local bosscolor = BG.Boss[FB]["boss" .. b].color
                    bossnametext = "|cff" .. bosscolor .. bossname2 .. RR
                else
                    bossnametext = L["无"]
                end
                if LibBG:UIDropDownMenu_GetText(dropDown) == bossnametext then
                    info.checked = true
                end
                info.text = bossnametext
                info.func = function()
                    if b == 0 then
                        BG.tradeDropDown.Yes = false
                        BG.tradeDropDown.Boss = nil
                    else
                        BG.tradeDropDown.Yes = true
                        BG.tradeDropDown.Boss = b
                    end
                    LibBG:UIDropDownMenu_SetText(dropDown, bossnametext)
                    BG.GetTradeInfo()
                    BG.tradeSeeFrame.text:SetText(BG.TradeText())
                    BG.FrameHide(0)
                end
                LibBG:UIDropDownMenu_AddButton(info)
            end
        end)
    end

    -- 交易打开时
    do
        BG.RegisterEvent("TRADE_SHOW", function(self, ...)
            BG.QianKuan.edit:SetText("")
            if BiaoGe.options["autoTrade"] == 1 and IsInRaid(1) then
                BG.QianKuan.frame:Show()
            else
                BG.QianKuan.frame:Hide()
            end

            BG.tradeGoldTop:Hide()
            BG.tradeSaveMoney:Hide()
            BG.qiankuanTradeFrame.Update()

            if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradePreview"] == 1 and IsInRaid(1) then
                BG.tradeSeeFrame.frame:Show()
                BG.tradeSeeFrame.frame:SetNormalColor()
                BG.tradeDropDown.DropDown:Hide()
                BG.tradeDropDown.Yes = false
                BG.tradeDropDown.Boss = nil
                LibBG:UIDropDownMenu_SetText(BG.tradeDropDown.DropDown, L["无"])
                BG.tradeSeeFrame.text:SetText("")
                BG.tradeSeeFrame.CheckButton:SetChecked(true)
            else
                BG.tradeSeeFrame.frame:Hide()
            end

            BG.auctionLogFrame.GetTargetTradeTbl(BG.ImML() and BG.GN("NPC") or player)

            if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["lastTrade"] == 1 and BG.ImML() then
                BG.tradelastAuctionFrame.frame:Show()
            else
                BG.tradelastAuctionFrame.frame:Hide()
            end

            if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradeFastGiveMoney"] == 1 and BG.ImML() then
                if not BG.tradeFastGiveMoneyFrame.frame then
                    BG.CreateTradeFastGiveMoneyFrame()
                end
                BG.tradeFastGiveMoneyFrame.frame:Show()
                BG.UpdateTradeFastGiveMoneyFrame()
            else
                if BG.tradeFastGiveMoneyFrame.frame then
                    BG.tradeFastGiveMoneyFrame.frame:Hide()
                end
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

    -- 交易记录核心
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

        -- 我输入金币时
        TradePlayerInputMoneyFrameGold:HookScript("OnTextChanged", function()
            BG.GetTradeInfo()
            BG.tradeSaveMoney:UpdateFrame()
            BG.tradeSeeFrame.text:SetText(BG.TradeText())
        end)

        --每次点交易确定时记录双方交易的金币和物品
        local f = CreateFrame("Frame")
        f:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED")
        f:RegisterEvent("TRADE_TARGET_ITEM_CHANGED")
        f:RegisterEvent("TRADE_MONEY_CHANGED")
        f:RegisterEvent("TRADE_ACCEPT_UPDATE")
        f:SetScript("OnEvent", function(...)
            BG.GetTradeInfo()
            BG.tradeSeeFrame.text:SetText(BG.TradeText())

            if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradeMoneyTop"] == 1 then
                local mymoney = floor(GetMoney() / 1e4) or 0
                local targetmoney = BG.trade.targetmoney or 0
                if mymoney + targetmoney >= BG.tradeGoldTop.num then
                    BG.tradeGoldTop:Show()
                else
                    BG.tradeGoldTop:Hide()
                end
            end
            BG.tradeSaveMoney:UpdateFrame()
        end)

        local f = CreateFrame("Frame")
        f:RegisterEvent("UI_INFO_MESSAGE")
        f:SetScript("OnEvent", function(self, event, _, text)
            if text == ERR_TRADE_COMPLETE then
                if BiaoGe.options["autoTrade"] ~= 1 or not IsInRaid(1) then return end
                BG.tradeSaveMoney:SaveTradeMoney()
                local text = BG.TradeText("saved")
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
        end)
    end
end)
