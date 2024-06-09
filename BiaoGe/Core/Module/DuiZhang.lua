local _, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi
local FrameHide = ADDONSELF.FrameHide
local AddTexture = ADDONSELF.AddTexture
local GetItemID = ADDONSELF.GetItemID

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
    ["通报金团账单"] = { "通报金团账单", "通報金團帳單", "Announce Raid Ledger" },
    ["感谢使用金团表格"] = { "感谢使用金团表格", "感謝使用金團表格", "Thank you for using the Raid Table" },
    ["打包交易"] = { "打包交易", "打包交易", },
    --大脚金团助手
    ["事件：.-|c.-|Hitem.-|h|r"] = { "事件：.-|c.-|Hitem.-|h|r", },
    ["^收入为："] = { "^收入为：", "^收入為：", },
    ["^收入为：%d+。"] = { "^收入为：%d+。", "^收入為：%d+。", },
    ["-感谢使用大脚金团辅助工具-"] = { "-感谢使用大脚金团辅助工具-", "-感謝使用大脚金團輔助工具-", },
}
local function Default(player)
    return {
        player = player,
        zhangdan = {},
        yes = nil,
        sunjine = 0,
        time = date("%H:%M:%S"),
        biaoti = "",
        t = time(),
    }
end

local function Send(num)
    local link = "|cffFFFF00|Hgarrmission:" .. "BiaoGeDuiZhang:" .. num ..
        "|h[" .. L["对账"] .. "]|h|r"
    SendSystemMessage(link)
end

-- 自动记录别人账单
local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_RAID_WARNING")
f:RegisterEvent("CHAT_MSG_RAID_LEADER")
f:RegisterEvent("CHAT_MSG_RAID")
f:SetScript("OnEvent", function(self, even, text, playerName, ...)
    local player = strsplit("-", playerName)
    local IsRaidLedger = BG.FindTableString(text, locales["RaidLedger:.... 收入 ...."])
    local IsBiaoGe = BG.FindTableString(text, locales["通报金团账单"])
    local IsBigFoot = BG.FindTableString(text, locales["事件：.-|c.-|Hitem.-|h|r"])
    -- 判断是否一个账单
    if IsRaidLedger then -- 金团账本
        linshi_duizhang = Default(player)
        linshi_duizhang.yes = 1
        return
    elseif IsBiaoGe then -- 金团表格
        linshi_duizhang = Default(player)
        linshi_duizhang.yes = 2
        return
    elseif not bigfootyes and IsBigFoot then -- 大脚
        linshi_duizhang = Default(player)
        bigfoot = {}
        bigfootyes = true
        tinsert(bigfoot, text)
        return
    end

    if not linshi_duizhang then return end

    -- 如果已经是账单了，则开始保存每个装备的价格
    if linshi_duizhang.yes and player == linshi_duizhang.player and strfind(text, h_item) then
        local item = strmatch(text, h_item)
        local jine

        if linshi_duizhang.yes == 1 then -- 金团账本
            jine = BG.MatchTableString(text, locales["(%d+)金"])
            if jine and tonumber(jine) ~= 0 then
                local aaa = {
                    zhuangbei = item,
                    jine = jine,
                }
                tinsert(linshi_duizhang.zhangdan, aaa)
            end
        elseif linshi_duizhang.yes == 2 then -- 金团表格
            jine = strmatch(text, " (%d+)") or strmatch(text, "：(%d+)")
            local j
            if jine and tonumber(jine) then
                j = jine
            elseif BG.FindTableString(text, locales["打包交易"]) then
                j = L["打包交易"]
            else
                j = 0
            end
            local aaa = {
                zhuangbei = item,
                jine = j,
            }
            tinsert(linshi_duizhang.zhangdan, aaa)
        end
        return
    elseif bigfootyes and player == linshi_duizhang.player and (BG.FindTableString(text, locales["事件：.-|c.-|Hitem.-|h|r"]) or BG.FindTableString(text, locales["^收入为："])) then -- 大脚
        tinsert(bigfoot, text)
        return
    end

    -- 保存完整账单至数据库
    local yes
    if linshi_duizhang.yes and player == linshi_duizhang.player and (BG.FindTableString(text, locales["平均每人收入:"]) or BG.FindTableString(text, locales["感谢使用金团表格"])) then
        yes = true
    elseif bigfootyes and player == linshi_duizhang.player and BG.FindTableString(text, locales["-感谢使用大脚金团辅助工具-"]) then -- 大脚
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
        local sunjin = 0
        for key, value in pairs(linshi_duizhang.zhangdan) do
            local jine = tonumber(value.jine) or 0
            sunjin = sunjin + jine
        end
        linshi_duizhang.sunjine = sunjin
        linshi_duizhang.biaoti = linshi_duizhang.time .. "，" .. SetClassCFF(linshi_duizhang.player) .. L["，装备总收入"] .. BG.STC_g1(linshi_duizhang.sunjine)

        tinsert(BiaoGe.duizhang, linshi_duizhang)
        linshi_duizhang = nil
        BG.DuiZhangList()
        BG.After(0.1, function()
            Send(#BiaoGe.duizhang)
        end)
        return
    end
end)

------------------创建下拉列表UI------------------
function BG.DuiZhangUI()
    BG.DuiZhangDropDown = {}
    local dropDown = LibBG:Create_UIDropDownMenu(nil, BG.DuiZhangMainFrame)
    dropDown:SetPoint("BOTTOM", BG.MainFrame, "BOTTOM", 0, 30)
    LibBG:UIDropDownMenu_SetWidth(dropDown, 400)
    LibBG:UIDropDownMenu_SetText(dropDown, L["无"])
    LibBG:UIDropDownMenu_SetAnchor(dropDown, -15, 0, "BOTTOMRIGHT", dropDown, "TOPRIGHT")
    BG.dropDownToggle(dropDown)
    BG.DuiZhangDropDown.DropDown = dropDown

    local text = dropDown:CreateFontString()
    text:SetPoint("RIGHT", dropDown, "LEFT", 10, 3)
    text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
    text:SetTextColor(RGB(BG.y2))
    text:SetText(BG.STC_g1(L["对比的账单："]))
    BG.DuiZhangDropDown.BiaoTi = text

    -- 一天后自动删掉相应账单
    local name = "duiZhangTime"
    BG.options[name .. "reset"] = 24 -- 对账单保存24小时
    if not BiaoGe.options[name] then
        BiaoGe.options[name] = BG.options[name .. "reset"]
    end
    local nowtime = time()
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
        GameTooltip:AddLine(L["把对方账单的金额覆盖我当前表格的金额"], 1, 0.82, 0, true)
        GameTooltip:AddLine(L["不会对漏记的装备和金额生效"], 1, 0.82, 0, true)
        GameTooltip:Show()
    end)
    BG.GameTooltip_Hide(bt)
    bt:SetScript("OnClick", function(self)
        local FB = BG.FB1
        for b = 1, Maxb[FB] - 1 do
            for i = 1, Maxi[FB] do
                local otherjine = BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i]
                local myjine = BG.DuiZhangFrame[FB]["boss" .. b]["myjine" .. i]
                local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                if otherjine then
                    myjine:SetText(otherjine:GetText())
                    jine:SetText(otherjine:GetText())
                    if otherjine:GetText() == "" then
                        BiaoGe[FB]["boss" .. b]["jine" .. i] = nil
                    else
                        BiaoGe[FB]["boss" .. b]["jine" .. i] = otherjine:GetText()
                    end
                end
            end
        end
        BG.DuiZhangSet(BG.lastduizhangNum)
        BG.PlaySound(2)
    end)
end

------------------生成下拉列表可选账单------------------
function BG.DuiZhangList()
    LibBG:UIDropDownMenu_Initialize(BG.DuiZhangDropDown.DropDown, function(self, level)
        FrameHide(0)
        if BG["DuiZhangFrame" .. BG.FB1] and BG["DuiZhangFrame" .. BG.FB1]:IsVisible() then
            PlaySound(BG.sound1, "Master")
        end
        for index, value in ipairs(BiaoGe.duizhang) do
            local info = LibBG:UIDropDownMenu_CreateInfo()
            info.text = value.biaoti
            info.func = function()
                FrameHide(0)
                BG.lastduizhangNum = index
                BG.DuiZhangSet(index)
                LibBG:UIDropDownMenu_SetText(BG.DuiZhangDropDown.DropDown, value.biaoti)
                PlaySound(BG.sound1, "Master")
            end
            if BG.lastduizhangNum == index then
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
            PlaySound(BG.sound1, "Master")
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

    for key, value in pairs(dz) do
        if value.zhuangbei then
            local item = value.zhuangbei
            local jine = value.jine
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
                            yes = true
                            break
                        end
                    end
                end
                if yes then
                    break
                end
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

    -- 设置打钩/叉叉材质
    C_Timer.After(0.05, function()
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
                tx:SetTexture(nil)
                ds:Hide()
            end
        end
    end

    -- 漏记装备
    local b = Maxb[FB]
    for i = 1, Maxi[FB] do
        local zhuangbei = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]
        if zhuangbei then
            zhuangbei:SetText("")
        end
    end
end

-- 点击[详细]后打开UI
hooksecurefunc("SetItemRef", function(link)
    local _, BiaoGeDuiZhang, num = strsplit(":", link, 3)
    if not (BiaoGeDuiZhang == "BiaoGeDuiZhang" and num) then return end
    num = tonumber(num)

    BG.MainFrame:Show()
    BG.ClickTabButton(BG.tabButtons, BG.DuiZhangMainFrameTabNum)
    BG.DuiZhangSet(num)
    LibBG:UIDropDownMenu_SetText(BG.DuiZhangDropDown.DropDown, BiaoGe.duizhang[num].biaoti)
    BG.PlaySound(1)
end)
