local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local RGB_16 = ADDONSELF.RGB_16
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local GetText_T = ADDONSELF.GetText_T
local FrameDongHua = ADDONSELF.FrameDongHua
local FrameHide = ADDONSELF.FrameHide
local AddTexture = ADDONSELF.AddTexture
local GetItemID = ADDONSELF.GetItemID

local Width = ADDONSELF.Width
local Height = ADDONSELF.Height
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local pt = print
local RealmId = GetRealmID()
local player = UnitName("player")

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName ~= AddonName then return end
    BG.trade = {}

    -- 函数：交易自动记录买家和金额
    do
        BG.tradeQuality = 0
        BG.trade = {}
        BG.trade.targetitems = {}
        BG.trade.playeritems = {}
        function BG.GetTradeInfo()
            wipe(BG.trade.targetitems)
            wipe(BG.trade.playeritems)
            BG.trade.target = GetUnitName("NPC", true)
            BG.trade.player = UnitName("player")
            BG.trade.targetmoney = GetTargetTradeMoney()
            BG.trade.playermoney = GetPlayerTradeMoney()

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
                    table.insert(BG.trade.targetitems, targetitem)
                end

                local playeritem = GetTradePlayerItemLink(i)
                local name, texture, quantity, quality, isUsable, enchant = GetTradePlayerItemInfo(i)
                if quality >= BG.tradeQuality and playeritem then
                    table.insert(BG.trade.playeritems, playeritem)
                end
            end
        end

        local function CancelGuanZhuAndHope(itemID)
            local _, link = GetItemInfo(itemID)
            local haveguanzhu, havehope
            local FB = BG.FB1
            for b = 1, Maxb[FB] do
                for i = 1, Maxi[FB] do
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
            BG.UpdateItemLib_LeftHope(itemID, 0)
            BG.UpdateItemLib_RightHope(itemID, 0)

            if haveguanzhu and havehope then
                SendSystemMessage(format(L["|cff00BFFF<BiaoGe>|r 已自动取消%s的|cff00BFFF关注|r和|cff00FF00心愿|r。"], link))
            elseif haveguanzhu then
                SendSystemMessage(format(L["|cff00BFFF<BiaoGe>|r 已自动取消%s的|cff00BFFF关注|r。"], link))
            elseif havehope then
                SendSystemMessage(format(L["|cff00BFFF<BiaoGe>|r 已自动取消%s的|cff00FF00心愿|r。"], link))
            end
        end

        function BG.TradeText(save)
            local FB = BG.FB1
            local target = BG.trade.target
            local player = BG.trade.player
            local targetmoney = BG.trade.targetmoney
            local playermoney = BG.trade.playermoney
            local targetitems = BG.trade.targetitems
            local playeritems = BG.trade.playeritems
            local returntext = ""
            if not BG.tradeFrame.CheckButton:GetChecked() then
                BG.tradeDropDown.DropDown:Hide()
                return returntext
            end
            -- 双方都给出装备
            if targetitems[1] and playeritems[1] and targetmoney == 0 and playermoney == 0 then --双方都有装备，但没金额，这种是交易失败
                returntext = ("|cffDC143C" .. L["< 交易记账失败 >"] .. RN .. L["双方都给了装备，但没金额"] .. NN .. L["我不知道谁才是买家"] .. NN .. NN .. L["如果有金额我就能识别了"])
                BG.tradeDropDown.DropDown:Hide()
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

            local Items, Money, Items2, Money2
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
                    local first = true
                    for items = 1, #Items do
                        local done
                        for b = 1, Maxb[FB], 1 do
                            for i = 1, Maxi[FB], 1 do
                                local bt = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                                if bt and GetItemID(bt:GetText()) == GetItemID(Items[items]) and
                                    BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetText() == "" and
                                    BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText() == "" and
                                    not BiaoGe[FB]["boss" .. b]["qiankuan" .. i]
                                then
                                    if save == 1 then
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetText(Player)
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetCursorPosition(0)
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetTextColor(GetClassRGB(Player))
                                        BiaoGe[FB]["boss" .. b]["maijia" .. i] = (Player)
                                        BiaoGe[FB]["boss" .. b]["color" .. i] = { GetClassRGB(Player) }
                                        if first then
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
                                        if Player == UnitName("player") then
                                            local itemID = GetItemID(bt:GetText())
                                            CancelGuanZhuAndHope(itemID)
                                        end
                                    end
                                    if first then
                                        local Texture = select(10, GetItemInfo(Items[items]))
                                        returntext = (format("|cff00BFFF" ..
                                            L["< 交易记账成功 >|r\n装备：%s\n买家：%s\n金额：%s%d|rg%s\nBOSS：%s%s|r"],
                                            (AddTexture(Texture) .. Items[items]), SetClassCFF(Player), "|cffFFD700",
                                            (Money + qiankuan), qiankuantext, "|cff" .. BG.Boss[FB]["boss" .. b]["color"],
                                            BG.Boss[FB]["boss" .. b]["name2"]))
                                        BG.tradeDropDown.DropDown:Hide()
                                    end
                                    first = nil
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
                        return returntext
                    else
                        local b = BG.tradeDropDown.Boss
                        for i = 1, Maxi[FB], 1 do
                            if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                                if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText() == "" then
                                    if save == 1 then
                                        BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:SetText(Items[1])
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetText(Player)
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetCursorPosition(0)
                                        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetTextColor(GetClassRGB(Player))
                                        BG.Frame[FB]["boss" .. b]["jine" .. i]:SetText(Money + qiankuan)
                                        BiaoGe[FB]["boss" .. b]["zhuangbei" .. i] = (Items[1])
                                        BiaoGe[FB]["boss" .. b]["maijia" .. i] = (Player)
                                        BiaoGe[FB]["boss" .. b]["color" .. i] = { GetClassRGB(Player) }
                                        BiaoGe[FB]["boss" .. b]["jine" .. i] = (Money + qiankuan)
                                        if qiankuan ~= 0 then
                                            BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = qiankuan
                                            BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Show()
                                        end
                                    end

                                    local Texture = select(10, GetItemInfo(Items[1]))
                                    returntext = (format("|cff00BFFF" .. L["< 交易记账成功 >|r\n装备：%s\n买家：%s\n金额：%s%d|rg%s\nBOSS：%s%s|r"],
                                        (AddTexture(Texture) .. Items[1]), SetClassCFF(Player), "|cffFFD700", (Money + qiankuan),
                                        qiankuantext, "|cff" .. BG.Boss[FB]["boss" .. b]["color"], BG.Boss[FB]["boss" .. b]["name2"]))
                                    BG.tradeDropDown.DropDown:Show()
                                    return returntext
                                end
                            end
                        end
                        returntext = ("|cffDC143C" .. L["< 交易记账失败 >"] .. RN .. L["该BOSS格子已满"])
                        BG.tradeDropDown.DropDown:Show()
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
            local name = "autoAdd0"
            if BiaoGe.options[name] == 1 then
                local len = strlen(self:GetText())
                local lingling
                if len then
                    lingling = strsub(self:GetText(), len - 1, len)
                end
                if lingling ~= "00" and lingling ~= "0" and tonumber(self:GetText()) and self:HasFocus() then
                    self:Insert("00")
                    self:SetCursorPosition(1)
                end
            end
            BG.GetTradeInfo()
            BG.tradeFrame.text:SetText(BG.TradeText(0))
        end)
        edit:SetScript("OnEnterPressed", function(self)
            self:ClearFocus()
        end)
        -- 点击时
        edit:SetScript("OnMouseDown", function(self, enter)
            if enter == "RightButton" then -- 右键清空格子
                self:SetEnabled(false)
                self:SetText("")
            end
        end)
        edit:SetScript("OnMouseUp", function(self, enter)
            if enter == "RightButton" then -- 右键清空格子
                self:SetEnabled(true)
            end
        end)

        local text = edit:CreateFontString()
        text:SetPoint("RIGHT", BG.QianKuan.edit, "LEFT", -8, 0)
        text:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
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
        local text = f:CreateFontString()
        text:SetPoint("TOPRIGHT", TradeRecipientMoneyBg, "BOTTOMRIGHT", 0, 0)
        text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        text:SetTextColor(RGB(BG.r1))
        text:SetText(L["金币已超上限！"])
        text:Hide()
        BG.tradeGoldTop = text
        -- BG.tradeGoldTop.num=214745
        BG.tradeGoldTop.num = 999999
    end

    -- 自动记账效果预览框
    do
        BG.tradeFrame = {}
        local frame = CreateFrame("Frame", nil, TradeFrame, "BackdropTemplate")
        frame:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        frame:SetBackdropColor(0, 0, 0, 0.7)
        frame:SetBackdropBorderColor(0, 0, 0, 1)
        frame:SetSize(200, 200)
        frame:SetPoint("BOTTOMLEFT", TradeFrame, "BOTTOMRIGHT", 0, 0)
        frame:EnableMouse(true)
        frame:SetToplevel(true)
        frame:SetFrameLevel(TradeRecipientMoneyBg:GetFrameLevel() + 1)
        frame:SetFrameStrata("HIGH")
        BG.tradeFrame.frame = frame

        local text = frame:CreateFontString()
        text:SetPoint("TOP", frame, "TOP", 0, -10)
        text:SetFont(BIAOGE_TEXT_FONT, 16, "OUTLINE")
        text:SetText(L["记账效果预览"])
        BG.tradeFrame.title = text

        local text = frame:CreateFontString()
        text:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -45)
        text:SetWidth(frame:GetWidth() - 10)
        text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        text:SetJustifyH("LEFT") -- 对齐格式
        BG.tradeFrame.text = text
    end
    -- 本次交易自动记账
    do
        local bt = CreateFrame("CheckButton", nil, BG.tradeFrame.frame, "ChatConfigCheckButtonTemplate")
        bt:SetSize(25, 25)
        bt.Text:SetText(L["本次交易自动记账"])
        bt:SetPoint("BOTTOMRIGHT", BG.tradeFrame.frame, "BOTTOMLEFT",
            (BG.tradeFrame.frame:GetWidth() - bt.Text:GetWidth()) * 0.5, 0)
        bt:SetHitRectInsets(0, -bt.Text:GetWidth(), 0, 0)
        bt:SetChecked(true)
        BG.tradeFrame.CheckButton = bt
        bt:SetScript("OnClick", function(self)
            BG.tradeFrame.text:SetText(BG.TradeText(0))
        end)
    end
    -- 强制记账选择框
    do
        BG.tradeDropDown = {}
        BG.tradeDropDown.Yes = false
        BG.tradeDropDown.Boss = nil

        local dropDown = LibBG:Create_UIDropDownMenu("BG.tradeDropDown.DropDown", BG.tradeFrame.frame)
        dropDown:SetPoint("BOTTOM", BG.tradeFrame.frame, "BOTTOM", 25, 20)
        LibBG:UIDropDownMenu_SetWidth(dropDown, 100)
        LibBG:UIDropDownMenu_SetText(dropDown, L["无"])
        BG.dropDownToggle(dropDown)
        BG.tradeDropDown.DropDown = dropDown

        local text = dropDown:CreateFontString()
        text:SetPoint("RIGHT", dropDown, "LEFT", 10, 3)
        text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        text:SetTextColor(RGB(BG.y2))
        text:SetText("记账到:")
        BG.tradeDropDown.BiaoTi = text
        LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
            local FB = BG.FB1
            PlaySound(BG.sound1, "Master")
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

                info.text, info.func = bossnametext, function()
                    if b == 0 then
                        BG.tradeDropDown.Yes = false
                        BG.tradeDropDown.Boss = nil
                    else
                        BG.tradeDropDown.Yes = true
                        BG.tradeDropDown.Boss = b
                    end
                    LibBG:UIDropDownMenu_SetText(dropDown, bossnametext)
                    BG.GetTradeInfo()
                    BG.tradeFrame.text:SetText(BG.TradeText(0))
                    FrameHide(0)
                    PlaySound(BG.sound1, "Master")
                end
                LibBG:UIDropDownMenu_AddButton(info)
            end
        end)
    end

    -- 交易打开时
    do
        local f = CreateFrame("Frame")
        f:RegisterEvent("TRADE_SHOW")
        f:SetScript("OnEvent", function(self, ...)
            BG.QianKuan.edit:SetText("")
            if BiaoGe.options["autoTrade"] == 1 and IsInRaid(1) then
                BG.QianKuan.frame:Show()
            else
                BG.QianKuan.frame:Hide()
            end

            if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradePreview"] == 1 and IsInRaid(1) then
                BG.tradeFrame.frame:Show()
                BG.tradeDropDown.DropDown:Hide()
                BG.tradeDropDown.Yes = false
                BG.tradeDropDown.Boss = nil
                LibBG:UIDropDownMenu_SetText(BG.tradeDropDown.DropDown, L["无"])
                BG.tradeFrame.text:SetText("")
                BG.tradeFrame.CheckButton:SetChecked(true)
            else
                BG.tradeFrame.frame:Hide()
            end

            BG.tradeGoldTop:Hide()
        end)
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
        f:SetFont(BIAOGE_TEXT_FONT, BiaoGe.options["tradeFontSize"] or 20, "OUTLINE")
        f:SetFrameLevel(131)
        f:SetFrameStrata("FULLSCREEN_DIALOG")
        f:SetClampedToScreen(true)
        f:SetHyperlinksEnabled(true)
        f.homepoin = { "BOTTOM", nil, "CENTER", 50, 100 }
        if BiaoGe.point[f:GetName()] then
            f:SetPoint(unpack(BiaoGe.point[f:GetName()]))
        else
            f:SetPoint(unpack(f.homepoin)) --设置显示位置
        end
        tinsert(BG.Movetable, f)
        BG.FrameTradeMsg = f

        f.name = f:CreateFontString()
        f.name:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
                    GameTooltip:SetItemByID(itemID)
                    GameTooltip:Show()
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
                ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                ChatEdit_InsertLink(text)
            end
        end)

        -- 我输入金币时
        TradePlayerInputMoneyFrameGold:HookScript("OnTextChanged", function()
            BG.GetTradeInfo()
            BG.tradeFrame.text:SetText(BG.TradeText(0))
        end)

        --每次点交易确定时记录双方交易的金币和物品
        local f = CreateFrame("Frame")
        f:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED")
        f:RegisterEvent("TRADE_TARGET_ITEM_CHANGED")
        f:RegisterEvent("TRADE_MONEY_CHANGED")
        f:SetScript("OnEvent", function(...)
            BG.GetTradeInfo()
            BG.tradeFrame.text:SetText(BG.TradeText(0))

            if BiaoGe.options["autoTrade"] == 1 and BiaoGe.options["tradeMoneyTop"] == 1 then
                local mymoney = floor(GetMoney() / 1e4) or 0
                local targetmoney = BG.trade.targetmoney or 0
                if mymoney + targetmoney >= BG.tradeGoldTop.num then
                    BG.tradeGoldTop:Show()
                else
                    BG.tradeGoldTop:Hide()
                end
            end
        end)

        local f = CreateFrame("Frame")
        f:RegisterEvent("UI_INFO_MESSAGE")
        f:SetScript("OnEvent", function(self, event, _, text)
            if text == ERR_TRADE_COMPLETE then
                if BiaoGe.options["autoTrade"] ~= 1 or not IsInRaid(1) then return end

                local text = BG.TradeText(1)
                if BiaoGe.options["tradeNotice"] == 1 then
                    BG.FrameTradeMsg:AddMessage(text)
                end
            end
        end)
    end
end)
