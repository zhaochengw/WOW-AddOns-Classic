local _, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local Maxb = ns.Maxb
local Maxi = ns.Maxi
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi
local FrameHide = ns.FrameHide
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local pt = print

local linshi_duizhang
local h_item = "|c.-|Hitem.-|h|r"
local bigfootyes
local bigfoot

local locales = {
    --金团账本
    ["RaidLedger:.... 收入 ...."] = { "RaidLedger:.... 收入 ....", "RaidLedger:.... Credit ...." },
    ["(%d+)金"] = { "(%d+)金", "(%d+)gold" },
    ["平均每人收入:"] = { "平均每人收入:", "Per Member credit:" },
    --金团表格
    ["通报金团账单"] = { "—通报账单—", "—通报金团账单—", "—通報賬單—", "—通報金團帳單—", "—Announce Raid Ledger—" },
    ["感谢使用金团表格"] = { "感谢使用BiaoGe插件", "感谢使用金团表格", "感謝使用BiaoGe插件", "感謝使用金團表格", "Thank you for using the Raid Table" },
    ["打包交易"] = { "打包交易", "打包交易", },
    ["表格：(.+)"] = { "表格：(.+)", },
    --大脚金团助手
    ["事件：.-|c.-|Hitem.-|h|r"] = { "事件：.-|c.-|Hitem.-|h|r", },
    ["^收入为："] = { "^收入为：", "^收入為：", },
    ["^收入为：%d+。"] = { "^收入为：%d+。", "^收入為：%d+。", },
    ["-感谢使用大脚金团辅助工具-"] = { "-感谢使用大脚金团辅助工具-", "-感謝使用大脚金團輔助工具-", },
}
local function Default(player, time)
    local _, class = UnitClass(player)
    return {
        player = player,
        class = class,
        FB = nil,
        zhangdan = {},
        msgTbl = {},
        yes = nil,
        sumjine = 0,
        time = date("%H:%M:%S",GetServerTime()),
        t = time,
    }
end

local function CheckTimeOut(time)
    BG.After(20, function()
        if linshi_duizhang and linshi_duizhang.t then
            if time == linshi_duizhang.t then
                linshi_duizhang = nil
                BG.SendSystemMessage(L["账单识别错误或超时！"])
            end
        end
    end)
end

local function Send(num, sumMoney, FB)
    local FBtext = ""
    if FB then
        for i, v in ipairs(BG.FBtable2) do
            if FB == v.FB then
                FBtext = L["，"] .. BG.STC_b1(v.localName)
                break
            end
        end
    end
    local link = "|cffFFFF00|Hgarrmission:" .. "BiaoGeDuiZhang:" .. num ..
        "|h[" .. L["点击：对账"] .. "] " .. L["（"] .. "|cff00ff00" .. L["装备总收入"] .. sumMoney .. RR .. FBtext .. L["）"] .. "|h|r"
    SendSystemMessage(link)
end

-- 自动记录别人账单
local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_RAID_WARNING")
f:RegisterEvent("CHAT_MSG_RAID_LEADER")
f:RegisterEvent("CHAT_MSG_RAID")
f:SetScript("OnEvent", function(self, even, msg, playerName, ...)
    local player = strsplit("-", playerName)
    local IsRaidLedger = BG.FindTableString(msg, locales["RaidLedger:.... 收入 ...."])
    local IsBiaoGe = BG.FindTableString(msg, locales["通报金团账单"])
    local IsBigFoot = BG.FindTableString(msg, locales["事件：.-|c.-|Hitem.-|h|r"])
    local _time = GetServerTime()
    -- 判断是否一个账单
    if IsRaidLedger then -- 金团账本
        linshi_duizhang = Default(player, _time)
        linshi_duizhang.yes = 1
        linshi_duizhang.addons = "raidledger"
        tinsert(linshi_duizhang.msgTbl, msg)
        CheckTimeOut(_time)
        return
    elseif IsBiaoGe then -- 金团表格
        linshi_duizhang = Default(player, _time)
        linshi_duizhang.yes = 2
        linshi_duizhang.addons = "biaoge"
        tinsert(linshi_duizhang.msgTbl, msg)
        CheckTimeOut(_time)
        return
    elseif not bigfootyes and IsBigFoot then -- 大脚
        linshi_duizhang = Default(player, _time)
        linshi_duizhang.addons = "bigfoot"
        bigfoot = {}
        bigfootyes = true
        tinsert(bigfoot, msg)
        tinsert(linshi_duizhang.msgTbl, msg)
        CheckTimeOut(_time)
        return
    end

    if not linshi_duizhang then return end

    -- 保存聊天记录
    if (linshi_duizhang.yes or bigfootyes) and player == linshi_duizhang.player then
        tinsert(linshi_duizhang.msgTbl, msg)
    end

    -- 识别表格
    local FB = BG.MatchTableString(msg, locales["表格：(.+)"])
    if linshi_duizhang.yes and player == linshi_duizhang.player and FB then
        linshi_duizhang.FB = FB
    end

    -- 如果已经是账单了，则开始保存每个装备的价格
    if linshi_duizhang.yes and player == linshi_duizhang.player and strfind(msg, h_item) then
        local item = strmatch(msg, h_item)
        local jine

        if linshi_duizhang.yes == 1 then -- 金团账本
            jine = BG.MatchTableString(msg, locales["(%d+)金"])
            if jine and tonumber(jine) ~= 0 then
                local aaa = {
                    zhuangbei = item,
                    jine = jine,
                }
                tinsert(linshi_duizhang.zhangdan, aaa)
            end
        elseif linshi_duizhang.yes == 2 then -- 金团表格
            local playerClass = {}
            local maijia = strmatch(msg, " (%S-) %S+$")
            if maijia == "" then
                maijia = nil
            end
            if maijia then
                for k, v in pairs(BG.playerClass) do
                    local value = select(v.select, v.func(maijia))
                    if value == 0 then value = nil end
                    playerClass[k] = value
                end
                if not playerClass.guild then
                    playerClass.realm = nil
                end
            end
            jine = strmatch(msg, " (%d+)$") or strmatch(msg, "：(%d+)$")
            local j
            if jine and tonumber(jine) then
                j = jine
            elseif BG.FindTableString(msg, locales["打包交易"]) then
                j = L["打包交易"]
            else
                j = 0
            end
            local a = {
                zhuangbei = item,
                maijia = maijia,
                jine = j,
            }
            for k, v in pairs(playerClass) do
                a[k] = v
            end
            tinsert(linshi_duizhang.zhangdan, a)
        end
        return
    elseif bigfootyes and player == linshi_duizhang.player and (BG.FindTableString(msg, locales["事件：.-|c.-|Hitem.-|h|r"]) or BG.FindTableString(msg, locales["^收入为："])) then -- 大脚
        tinsert(bigfoot, msg)
        return
    end

    -- 保存完整账单至数据库
    local yes
    if linshi_duizhang.yes and player == linshi_duizhang.player and (BG.FindTableString(msg, locales["平均每人收入:"]) or BG.FindTableString(msg, locales["感谢使用金团表格"])) then
        yes = true
    elseif bigfootyes and player == linshi_duizhang.player and BG.FindTableString(msg, locales["-感谢使用大脚金团辅助工具-"]) then -- 大脚
        for i, value in ipairs(bigfoot) do
            if strfind(bigfoot[i], h_item) then
                if bigfoot[i + 1] and BG.FindTableString(bigfoot[i + 1], locales["^收入为：%d+。"]) then
                    local item = strmatch(bigfoot[i], h_item)
                    local jine = tonumber(strmatch(bigfoot[i + 1], "%d+"))

                    if jine ~= "" and tonumber(jine) ~= 0 then
                        local aaa = {
                            zhuangbei = item,
                            jine = jine,
                        }
                        tinsert(linshi_duizhang.zhangdan, aaa)
                    end
                end
            end
        end
        yes = true
        bigfootyes = nil
        bigfoot = nil
    end
    if yes then
        linshi_duizhang.yes = nil
        local sumMoney = 0
        for key, value in pairs(linshi_duizhang.zhangdan) do
            local jine = tonumber(value.jine) or 0
            sumMoney = sumMoney + jine
        end
        linshi_duizhang.sumjine = sumMoney
        local FB = linshi_duizhang.FB
        tinsert(BiaoGe.duizhang, linshi_duizhang)
        linshi_duizhang = nil
        BG.DuiZhangList()
        BG.After(0.1, function()
            Send(#BiaoGe.duizhang, sumMoney, FB)
        end)
        return
    end
end)

BG.RegisterEvent("CHAT_MSG_ADDON", function(self, even, ...)
    local prefix, msg, distType, sender = ...
    if not linshi_duizhang then return end
    if prefix == "BiaoGe" and distType == "RAID" and msg:match("^DuiZhang-") then
        linshi_duizhang.tradeTbl = linshi_duizhang.tradeTbl or {}
        local a = {}
        local _, maijia, text = strsplit("-", msg)
        -- 24478 10000, 27854 t, 27503 t,
        for _, t in ipairs({ strsplit(",", text) }) do
            -- 24478 10000
            local itemID, jine = strsplit(" ", t)
            if itemID and tonumber(itemID) then
                tinsert(a, {
                    maijia = maijia,
                    jine = jine,
                    itemID = tonumber(itemID),
                })
            end
        end
        tinsert(linshi_duizhang.tradeTbl, a)
    end
end)

------------------创建UI------------------
function BG.DuiZhangUI()
    BG.DuiZhangDropDown = {}
    local dropDown = LibBG:Create_UIDropDownMenu(nil, BG.DuiZhangMainFrame)
    dropDown:SetPoint("BOTTOM", BG.MainFrame, "BOTTOM", 0, 30)
    LibBG:UIDropDownMenu_SetWidth(dropDown, 450)
    LibBG:UIDropDownMenu_SetText(dropDown, L["无"])
    LibBG:UIDropDownMenu_SetAnchor(dropDown, -15, 0, "BOTTOMRIGHT", dropDown, "TOPRIGHT")
    BG.dropDownToggle(dropDown)
    BG.DuiZhangDropDown.DropDown = dropDown

    local text = dropDown:CreateFontString()
    text:SetPoint("RIGHT", dropDown, "LEFT", 10, 3)
    text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
    text:SetTextColor(RGB(BG.y2))
    text:SetText(BG.STC_g1(L["对比的账单："]))
    BG.DuiZhangDropDown.BiaoTi = text

    -- 删除账单
    hooksecurefunc(LibBG, "ToggleDropDownMenu", function(_, _, _, dropDown)
        if dropDown == BG.DuiZhangDropDown.DropDown then
            for i = 1, _G['L_DropDownList1'].numButtons do
                local button = _G["L_DropDownList1Button" .. i]
                if not button.deleteZhangDan then
                    local bt = CreateFrame("Button", nil, button)
                    bt:SetSize(20, 20)
                    bt:SetPoint("RIGHT", -2, 0)
                    bt:SetNormalTexture("interface/raidframe/readycheck-notready")
                    bt:SetHighlightTexture("interface/raidframe/readycheck-notready")
                    bt:RegisterForClicks("AnyUp")
                    bt.num = i
                    bt:Hide()
                    button.deleteZhangDan = bt
                    bt:SetScript("OnClick", function(self)
                        BG.PlaySound(1)
                        tremove(BiaoGe.duizhang, self.num)
                        BG.lastduizhangNum = nil
                        BG.DuiZhang0()
                        LibBG:UIDropDownMenu_SetText(BG.DuiZhangDropDown.DropDown, L["无"])
                        BG.DuiZhangMainFrame.ButtonCopy:Disable()
                        LibBG:CloseDropDownMenus()
                        LibBG:ToggleDropDownMenu(nil, nil, BG.DuiZhangDropDown.DropDown)
                    end)
                    bt:SetScript("OnEnter", function(self)
                        LibBG:UIDropDownMenu_StopCounting(self:GetParent():GetParent())
                        button.Highlight:Show()
                        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                        GameTooltip:ClearLines()
                        GameTooltip:AddLine(L["删除该账单"], 1, 1, 1, true)
                        GameTooltip:Show()
                    end)
                    bt:SetScript("OnLeave", function(self)
                        LibBG:UIDropDownMenu_StartCounting(self:GetParent():GetParent())
                        button.Highlight:Hide()
                        GameTooltip:Hide()
                    end)
                end
                button.deleteZhangDan.num = i
                button.deleteZhangDan:SetShown(not (i == _G['L_DropDownList1'].numButtons))
            end
        else
            for i = 1, L_UIDROPDOWNMENU_MAXBUTTONS do
                local button = _G["L_DropDownList1Button" .. i]
                if button.deleteZhangDan then
                    button.deleteZhangDan:Hide()
                end
            end
        end
    end)

    -- 一天后自动删掉相应账单
    local name = "duiZhangTime"
    BG.options[name .. "reset"] = 24 -- 对账单保存24小时
    if not BiaoGe.options[name] then
        BiaoGe.options[name] = BG.options[name .. "reset"]
    end
    local nowtime = GetServerTime()
    for i = #BiaoGe.duizhang, 1, -1 do
        if type(BiaoGe.duizhang[i]) == "table" and BiaoGe.duizhang[i].t then
            local zhangdantime = BiaoGe.duizhang[i].t
            if tonumber(nowtime) - tonumber(zhangdantime) >= (BiaoGe.options[name] * 60 * 60) then
                tremove(BiaoGe.duizhang, i)
            end
        end
    end

    -- 复制对方金额
    local bt = CreateFrame("Button", nil, BG.DuiZhangMainFrame, "UIPanelButtonTemplate")
    bt:SetSize(120, 30)
    bt:SetPoint("LEFT", dropDown, "RIGHT", 20, 3)
    bt:SetText(L["复制对方账单"])
    bt:Disable()
    BG.DuiZhangMainFrame.ButtonCopy = bt
    bt:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(L["复制对方账单"], 1, 1, 1, true)
        GameTooltip:AddLine(L["把对方账单的金额覆盖我当前表格的金额。如果对方是BiaoGe插件的账单，则也会复制其买家。"], 1, 0.82, 0, true)
        GameTooltip:AddLine(" ", 1, 0.82, 0, true)
        GameTooltip:AddLine(L["不会对漏记的装备和金额生效。"], 1, 0.82, 0, true)
        GameTooltip:Show()
    end)
    BG.GameTooltip_Hide(bt)
    bt:SetScript("OnClick", function(self)
        local addons = BiaoGe.duizhang[BG.lastduizhangNum].addons
        local FB = BG.FB1
        local tradeInfo = {}
        BiaoGe[FB].tradeTbl = {}
        for b = 1, Maxb[FB] - 1 do
            for i = 1, Maxi[FB] do
                local otherjine = BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i]
                local myjine = BG.DuiZhangFrame[FB]["boss" .. b]["myjine" .. i]
                local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                if zhuangbei then
                    myjine:SetText(otherjine:GetText())
                    jine:SetText(otherjine:GetText())
                    if otherjine:GetText() == "" then
                        BiaoGe[FB]["boss" .. b]["jine" .. i] = nil
                    else
                        BiaoGe[FB]["boss" .. b]["jine" .. i] = otherjine:GetText()
                    end

                    if addons == "biaoge" then
                        local duizhangmaijia = BG.DuiZhangFrame[FB]["boss" .. b]["maijia" .. i]
                        local duizhangcolor = BG.DuiZhangFrame[FB]["boss" .. b]["color" .. i]
                        maijia:SetText(duizhangmaijia or "")
                        BiaoGe[FB]["boss" .. b]["maijia" .. i] = duizhangmaijia
                        if duizhangcolor then
                            maijia:SetTextColor(unpack(duizhangcolor))
                        else
                            maijia:SetTextColor(1, 1, 1)
                        end
                        for k in pairs(BG.playerClass) do
                            BiaoGe[FB]["boss" .. b][k .. i] = BG.DuiZhangFrame[FB]["boss" .. b][k .. i]
                        end

                        -- 打包交易
                        if otherjine.tradeTbl then
                            local notYes
                            for ii, vv in ipairs(tradeInfo) do
                                for i, v in ipairs(otherjine.tradeTbl) do
                                    if vv.b == v.b and vv.i == v.i then
                                        notYes = true
                                        break
                                    end
                                end
                                if notYes then break end
                            end
                            if not notYes then
                                local tradeTbl = BG.Copy(otherjine.tradeTbl)
                                for i, v in ipairs(tradeTbl) do
                                    local zb = BG.Frame[FB]["boss" .. v.b]["zhuangbei" .. v.i]
                                    tradeTbl[i].FB = FB
                                    tradeTbl[i].itemID = GetItemID(zb:GetText())
                                    tradeTbl[i].link = zb:GetText()
                                    tinsert(tradeInfo, { b = v.b, i = v.i })
                                end
                                tinsert(BiaoGe[FB].tradeTbl, tradeTbl)
                            end
                        end
                    end
                end
            end
        end
        BG.DuiZhangSet(BG.lastduizhangNum)
        BG.PlaySound(2)
    end)

    -- 聊天记录
    do
        local f = CreateFrame("Frame", nil, BG.DuiZhangMainFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.6)
        f:SetPoint("BOTTOMRIGHT", BG.MainFrame, -40, 90)
        f:SetSize(335, 200)
        f:EnableMouse(true)

        local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate") -- 滚动
        scroll:SetWidth(f:GetWidth() - 31)
        scroll:SetHeight(f:GetHeight() - 9)
        scroll:SetPoint("TOPLEFT", f, "TOPLEFT", 5, -5)
        scroll.ScrollBar.scrollStep = BG.scrollStep
        BG.CreateSrollBarBackdrop(scroll.ScrollBar)
        BG.HookScrollBarShowOrHide(scroll)

        local child = CreateFrame("EditBox", nil, f) -- 子框架
        child:SetFontObject(GameFontNormalSmall2)
        child:SetWidth(scroll:GetWidth())
        child:SetAutoFocus(false)
        child:EnableMouse(false)
        child:SetTextInsets(0, 0, 0, 0)
        child:SetMultiLine(true)
        child:SetHyperlinksEnabled(true)
        child:SetTextColor(RGB("FF7F50"))
        child.scroll = scroll
        scroll:SetScrollChild(child)
        BG.DuiZhangMainFrame.msgFrame = child

        child:SetScript("OnHyperlinkEnter", function(self, link, text, button)
            GameTooltip:SetOwner(f, "ANCHOR_TOPRIGHT", 0, 0)
            GameTooltip:ClearLines()
            local itemID = GetItemInfoInstant(link)
            if itemID then
                GameTooltip:SetItemByID(itemID)
                GameTooltip:Show()
                BG.Show_AllHighlight(link)
            end
        end)
        child:SetScript("OnHyperlinkLeave", function(self, link, text, button)
            GameTooltip:Hide()
            BG.Hide_AllHighlight()
        end)
        child:SetScript("OnHyperlinkClick", function(self, link, text, button)
            if (strsub(link, 1, 6) == "player") then
                local _, name, lineID, chatType = strsplit(":", link)
                ChatFrame_SendTell(name, ChatFrame1)
            elseif (strsub(link, 1, 4) == "item") then
                local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
                if IsShiftKeyDown() then
                    BG.InsertLink(text)
                elseif IsAltKeyDown() then
                    if BG.IsML then -- 开始拍卖
                        BG.StartAuction(link)
                    else
                        BG.AddGuanZhu(link)
                    end
                else
                    ShowUIPanel(ItemRefTooltip)
                    if (not ItemRefTooltip:IsShown()) then
                        ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
                    end
                    ItemRefTooltip:SetHyperlink(link)
                end
            end
        end)

        local t = f:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("BOTTOM", f, "TOP", 0, 0)
        t:SetText(L["账单聊天记录"])
    end
end

------------------生成下拉列表可选账单------------------
local function CreateZhangDanTitle(num)
    local zhangdan = BiaoGe.duizhang[num]
    local FBtext = ""
    if zhangdan.FB then
        for i, v in ipairs(BG.FBtable2) do
            if zhangdan.FB == v.FB then
                FBtext = L["，"] .. BG.STC_b1(v.localName)
                break
            end
        end
    end
    local classtext = "ffFFFFFF"
    if zhangdan.class then
        classtext = select(4, GetClassColor(zhangdan.class))
    end
    local title = zhangdan.time .. L["，"] .. "|c" .. classtext .. zhangdan.player .. RR
        .. L["，"] .. L["装备总收入"] .. BG.STC_g1(zhangdan.sumjine) .. FBtext
    return title
end
local function CreateZhangDanMsg(num)
    BG.DuiZhangMainFrame.msgFrame.scroll.ScrollBar:Hide()
    local zhangdan = BiaoGe.duizhang[num]
    if zhangdan.msgTbl then
        local classtext = "ffFFFFFF"
        if zhangdan.class then
            classtext = select(4, GetClassColor(zhangdan.class))
        end
        local nameLink = "|Hplayer:" .. zhangdan.player .. "|h[" .. "|c" .. classtext .. zhangdan.player .. RR .. "]|h"
        local timeText = "|cff" .. "808080" .. zhangdan.time .. "|r"

        BG.DuiZhangMainFrame.msgFrame:SetText("")
        for i, msg in ipairs(zhangdan.msgTbl) do
            msg = BG.GsubRaidTargetingIcons(msg)
            local text = timeText .. " " .. nameLink .. L["："] .. msg .. NN
            BG.DuiZhangMainFrame.msgFrame:Insert(text)
        end
    end
end

function BG.DuiZhangList()
    for i, v in ipairs(BiaoGe.duizhang) do
        v.sumjine = v.sunjine or v.sumjine or 0
        v.sunjine = nil
    end

    LibBG:UIDropDownMenu_Initialize(BG.DuiZhangDropDown.DropDown, function(self, level)
        FrameHide(0)
        if BG["DuiZhangFrame" .. BG.FB1] and BG["DuiZhangFrame" .. BG.FB1]:IsVisible() then
            BG.PlaySound(1)
        end
        for i, v in ipairs(BiaoGe.duizhang) do
            local title = CreateZhangDanTitle(i)
            local info = LibBG:UIDropDownMenu_CreateInfo()
            info.text = title
            info.func = function()
                FrameHide(0)
                BG.lastduizhangNum = i
                BG.DuiZhangSet(i)
                LibBG:UIDropDownMenu_SetText(BG.DuiZhangDropDown.DropDown, title)
                BG.PlaySound(1)
            end
            if BG.lastduizhangNum == i then
                info.checked = true
            end
            LibBG:UIDropDownMenu_AddButton(info)
        end
        local info = LibBG:UIDropDownMenu_CreateInfo()
        info.text = L["无"]
        info.func = function()
            FrameHide(0)
            BG.lastduizhangNum = nil
            BG.DuiZhang0()
            LibBG:UIDropDownMenu_SetText(BG.DuiZhangDropDown.DropDown, L["无"])
            BG.DuiZhangMainFrame.ButtonCopy:Disable()
            BG.PlaySound(1)
        end
        if not BG.lastduizhangNum then
            info.checked = true
        end
        LibBG:UIDropDownMenu_AddButton(info)
    end)
end

------------------账单生成函数------------------
function BG.DuiZhangSet(num)
    local dz = BiaoGe.duizhang[num].zhangdan
    local FB = BG.FB1
    BG.lastduizhangNum = num
    BG.DuiZhangMainFrame.ButtonCopy:Enable()

    BG.DuiZhang0()
    CreateZhangDanMsg(num)
    --[[
        ["tradeTbl"] = {
            {
                {
                    ["maijia"] = "苍刃",
                    ["itemID"] = 24291,
                    ["jine"] = "200",
                }, -- [1]
                {
                    ["maijia"] = "苍刃",
                    ["itemID"] = 27676,
                    ["jine"] = "t",
                }, -- [2]
            }, -- [1]
        },

        ["tradeTbl"] = {
            {
                {
                    ["i"] = 1,
                    ["itemID"] = 45087,
                    ["link"] = "|cff0070dd|Hitem:45087::::::::80:::::::::|h[符文宝珠]|h|r",
                    ["FB"] = "ULD",
                    ["b"] = 15,
                }, -- [1]
                {
                    ["i"] = 3,
                    ["itemID"] = 45291,
                    ["link"] = "|cffa335ee|Hitem:45291::::::::80:::::::::|h[内燃护腕]|h|r",
                    ["FB"] = "ULD",
                    ["b"] = 1,
                }, -- [2]
            }, -- [1]
    ]]
    for _, v in ipairs(dz) do
        if v.zhuangbei then
            local item = v.zhuangbei
            local jine = v.jine
            local yes
            for b = 1, Maxb[FB] - 1 do
                for i = 1, Maxi[FB] do
                    local zhuangbei = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]
                    local myjine = BG.DuiZhangFrame[FB]["boss" .. b]["myjine" .. i]
                    local otherjine = BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i]
                    local tx = BG.DuiZhangFrame[FB]["boss" .. b]["yes" .. i]
                    if zhuangbei then
                        if GetItemID(zhuangbei:GetText()) == GetItemID(item) and otherjine:GetText() == "" then
                            otherjine:SetText(jine)
                            BG.DuiZhangFrame[FB]["boss" .. b]["maijia" .. i] = v.maijia
                            for k in pairs(BG.playerClass) do
                                BG.DuiZhangFrame[FB]["boss" .. b][k .. i] = v[k]
                            end
                            yes = true
                            break
                        end
                    end
                end
                if yes then break end
            end
            -- 漏记
            if not yes then
                local b = Maxb[FB]
                for i = 1, Maxi[FB] do
                    local zhuangbei = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]
                    local otherjine = BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i]
                    if zhuangbei then
                        if not GetItemID(zhuangbei:GetText()) then
                            zhuangbei:SetText(item)
                            otherjine:SetText(jine)
                            break
                        end
                    end
                end
            end
        end
    end

    if BiaoGe.duizhang[num].tradeTbl then
        for ii in ipairs(BiaoGe.duizhang[num].tradeTbl) do
            local tbl = {}
            for _, v in ipairs(BiaoGe.duizhang[num].tradeTbl[ii]) do
                local yes
                for b = 1, Maxb[FB] do
                    for i = 1, Maxi[FB] do
                        local otherjine = BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i]
                        if otherjine and not (otherjine.hasTradeTbl or otherjine.tradeTbl) then
                            local maijia = BG.DuiZhangFrame[FB]["boss" .. b]["maijia" .. i]
                            local itemID = GetItemID(BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]:GetText())
                            local jine = BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i]:GetText()
                            if jine == L["打包交易"] then jine = "t" end
                            if maijia == v.maijia and itemID == v.itemID and jine == v.jine then
                                otherjine.hasTradeTbl = true
                                tinsert(tbl, { b = b, i = i })
                                yes = true
                                break
                            end
                        end
                    end
                    if yes then break end
                end
            end
            for i, v in ipairs(tbl) do
                BG.DuiZhangFrame[FB]["boss" .. v.b]["otherjine" .. v.i].hasTradeTbl = nil
                BG.DuiZhangFrame[FB]["boss" .. v.b]["otherjine" .. v.i].tradeTbl = tbl
            end
        end
    end

    -- 设置打钩/叉叉材质
    C_Timer.After(0, function()
        for b = 1, Maxb[FB] + 1 do
            for i = 1, Maxi[FB] do
                local zhuangbei = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]
                local myjine = BG.DuiZhangFrame[FB]["boss" .. b]["myjine" .. i]
                local otherjine = BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i]
                local tx = BG.DuiZhangFrame[FB]["boss" .. b]["yes" .. i]
                if zhuangbei and zhuangbei ~= BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei2"] then
                    local mj = myjine:GetText()
                    local oj = otherjine:GetText()
                    if not tonumber(mj) or tonumber(mj) == 0 then
                        mj = ""
                    end
                    if not tonumber(oj) or tonumber(oj) == 0 then
                        oj = ""
                    end
                    if (tonumber(mj) or tonumber(oj)) and tonumber(mj) == tonumber(oj) then
                        tx:SetTexture("interface/raidframe/readycheck-ready")
                        BG.DuiZhangFrameDs[FB .. 3]["boss" .. b]["ds" .. i]:Hide()
                    elseif (tonumber(mj) or tonumber(oj)) and tonumber(mj) ~= tonumber(oj) then
                        tx:SetTexture("interface/raidframe/readycheck-notready")
                        BG.DuiZhangFrameDs[FB .. 3]["boss" .. b]["ds" .. i]:Show()
                    else
                        tx:SetTexture(nil)
                        BG.DuiZhangFrameDs[FB .. 3]["boss" .. b]["ds" .. i]:Hide()
                    end
                end
            end
        end
    end)
end

------------------对账格子清空------------------
function BG.DuiZhang0()
    local FB = BG.FB1
    for b = 1, Maxb[FB] + 1 do
        for i = 1, Maxi[FB] do
            local zhuangbei = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]
            local otherjine = BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i]
            local tx = BG.DuiZhangFrame[FB]["boss" .. b]["yes" .. i]
            local ds = BG.DuiZhangFrameDs[FB .. 3]["boss" .. b]["ds" .. i]
            if zhuangbei then
                otherjine:SetText("")
                otherjine.tradeTbl = nil
                BG.DuiZhangFrame[FB]["boss" .. b]["maijia" .. i] = nil
                for k, v in pairs(BG.playerClass) do
                    BG.DuiZhangFrame[FB]["boss" .. b][k .. i] = nil
                end
                tx:SetTexture(nil)
                ds:Hide()
            end
        end
    end

    -- 漏记装备
    local b = Maxb[FB]
    for i = 1, Maxi[FB] do
        local zhuangbei = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]
        local myjine = BG.DuiZhangFrame[FB]["boss" .. b]["myjine" .. i]
        if zhuangbei then
            zhuangbei:SetText("")
            myjine:SetText("")
        end
    end
    BG.DuiZhangMainFrame.msgFrame:SetText("")
end

-- 点击[详细]后打开UI
hooksecurefunc("SetItemRef", function(link)
    local _, BiaoGeDuiZhang, num = strsplit(":", link, 3)
    if not (BiaoGeDuiZhang == "BiaoGeDuiZhang" and num) then return end
    num = tonumber(num)

    BG.MainFrame:Show()
    BG.ClickTabButton(BG.DuiZhangMainFrameTabNum)
    BG.DuiZhangSet(num)
    CreateZhangDanMsg(num)
    LibBG:UIDropDownMenu_SetText(BG.DuiZhangDropDown.DropDown, CreateZhangDanTitle(num))
    BG.PlaySound(1)
end)
