local _, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi
local Width = ADDONSELF.Width
local Height = ADDONSELF.Height

local pt = print
local RealmId = GetRealmID()
local player = UnitName("player")
BG.After = C_Timer.After

------------------函数：第几个BOSS------------------
local function BossNum(FB, b, t)
    local tbl
    if FB == "ICC" then
        tbl = { 0, 8, 14 }
    elseif FB == "TOC" then
        tbl = { 0, 5, 8 }
    elseif FB == "ULD" then
        tbl = { 0, 7, 13 }
    elseif FB == "NAXX" and not BG.IsVanilla() then
        tbl = { 0, 6, 12, 16 }
    elseif FB == "BD" then
        tbl = { 0, 5, 9 }
    elseif FB == "Gno" then
        tbl = { 0, 5, 8 }
    elseif FB == "MC" then
        tbl = { 0, 8, 12 }
    elseif FB == "BWL" then
        tbl = { 0, 5, 9 }
    elseif FB == "ZUG" then
        tbl = { 0, 6, 11 }
    elseif FB == "AQL" then
        tbl = { 0, 5, 8 }
    elseif FB == "TAQ" then
        tbl = { 0, 6, 10 }
    elseif FB == "NAXX" and BG.IsVanilla() then
        tbl = { 0, 6, 12, 16 }
    end

    local bb
    if tbl[t + 1] then
        bb = tbl[t + 1] - tbl[t]
    else
        bb = Maxb[FB] + 2 - tbl[t]
    end
    return b + tbl[t], bb
end
ADDONSELF.BossNum = BossNum

------------------函数：四舍五入------------------ 数字，小数点数
local function Round(number, decimal_places)
    local mult = 10 ^ (decimal_places or 0)
    return math.floor(number * mult + 0.5) / mult
end
ADDONSELF.Round = Round

------------------函数：设置颜色（0-1代码变为16进制颜色）------------------
local function RGB_16(name, r, g, b)
    if not r then
        r, g, b = name:GetTextColor()
        name = name:GetText()
    end

    local r = string.format("%X", tonumber(r) * 255)
    if r and strlen(r) == 1 then
        r = "0" .. r
    end
    local g = string.format("%X", tonumber(g) * 255)
    if g and strlen(g) == 1 then
        g = "0" .. g
    end
    local b = string.format("%X", tonumber(b) * 255)
    if b and strlen(b) == 1 then
        b = "0" .. b
    end
    local c = r .. g .. b

    if name then
        local cffname = "|cff" .. c .. name .. "|r"
        return cffname
    else
        return c
    end
end
ADDONSELF.RGB_16 = RGB_16

------------------在文本里插入材质图标------------------
local function AddTexture(Texture, y, coord)
    if not Texture then
        return ""
    end
    local x = 0
    if not y then
        y = "-0"
    end
    local tex = ""
    local coord = coord or ""
    if Texture == "MAINTANK" then       -- 主坦克
        tex = "132064"
    elseif Texture == "MAINASSIST" then -- 主助理
        tex = "132063"
    elseif Texture == "HEALER" then     -- 治疗职责
        tex = "interface/lfgframe/ui-lfg-icon-roles"
        -- TexCoord_re = ":100:100:33:45:6:19"
        coord = ":100:100:24:50:0:25"
        x = "-2"
        y = "0"
    elseif Texture == 137000 or Texture == 136998 then -- 战场荣誉
        coord = ":100:100:10:60:0:55"
        local t = "|T" .. Texture .. ":0:0:0:0" .. coord .. "|t"
        return t
    else
        tex = Texture
    end
    local t = "|T" .. tex .. ":0:0:" .. x .. ":" .. y .. coord .. "|t"
    return t
end
ADDONSELF.AddTexture = AddTexture

function BG.CreateRoundTexture(tex, parent, w, h)
    local icon = CreateFrame("Frame", nil, parent or UIParent)
    icon:SetPoint("CENTER")
    icon:SetSize(w or 20, h or 20)

    icon.tex = icon:CreateTexture(nil, "ARTWORK")
    icon.tex:SetAllPoints()
    icon.tex:SetTexture(tex)
    icon.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    icon.masktex = icon:CreateMaskTexture()
    icon.masktex:SetAllPoints()
    icon.masktex:SetTexture("Interface/CharacterFrame/TempPortraitAlphaMaskSmall")

    icon.tex:AddMaskTexture(icon.masktex)
    return icon
end

------------------获取文字（删掉材质）------------------
local function GetText_T(bt)
    local text
    if type(bt) == "table" then
        text = bt:GetText()
    else
        text = bt
    end
    local t = string.gsub(text, "|T.-|t", "")
    return t
end
ADDONSELF.GetText_T = GetText_T

------------------函数：获取名字的职业颜色RGB------------------
local function GetClassRGB(name, player, Alpha)
    local _, class
    if player then
        _, class = UnitClass(player)
    else
        _, class = UnitClass(name)
    end
    local c1, c2, c3 = 1, 1, 1
    if class then
        c1, c2, c3 = GetClassColor(class)
    end
    return c1, c2, c3, Alpha
end
ADDONSELF.GetClassRGB = GetClassRGB

------------------函数：设置名字为职业颜色CFF代码（|cffFFFFFF名字|r）------------------
local function SetClassCFF(name, player, type)
    if type then return name end
    local _, class
    if player then
        _, class = UnitClass(player)
    else
        _, class = UnitClass(name)
    end
    local colorname = ""
    if class then
        local color = select(4, GetClassColor(class))
        colorname = "|c" .. color .. name .. "|r"
        return colorname, color
    else
        return name, ""
    end
end
ADDONSELF.SetClassCFF = SetClassCFF

--[[ ------------------函数：删除颜色代码------------------
function BG.RemoveColorCodes(str)
    str = string.gsub(str, "|[cC]%x%x%x%x%x%x%x%x", "")
    str = string.gsub(str, "|[rR]", "")
    str = string.gsub(str, "\n", "")
    return str
end
 ]]

------------------函数：仅提取链接文本------------------
local function GetItemID(text)
    if not text then return end
    local h_item = "item:(%d-):"
    -- local h_item = "|Hitem:(%d-):"
    local item = tonumber(strmatch(text, h_item))
    return item
end
ADDONSELF.GetItemID = GetItemID

------------------清除输入框的焦点------------------
function BG.ClearFocus()
    if BG.lastfocus then
        BG.lastfocus:ClearFocus()
    end
end

------------------事件监控------------------
function BG.RegisterEvent(Even, OnEvent)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent(Even)
    frame:SetScript("OnEvent", OnEvent)
end

------------------函数：隐藏窗口------------------   -- 0：隐藏焦点+全部框架，1：隐藏全部框架，2：隐藏除历史表格外的框架
local function FrameHide(num)
    if num == 0 then
        if BG.lastfocus then
            BG.lastfocus:ClearFocus()
        end
    end
    if BG.FrameZhuangbeiList then
        BG.FrameZhuangbeiList:Hide()
    end
    if BG.FrameMaijiaList then
        BG.FrameMaijiaList:Hide()
    end
    if BG.FrameJineList then
        BG.FrameJineList:Hide()
    end
    if num ~= 2 then -- num是0就取消焦点，其他数字就不取消焦点
        if BG.History then
            if BG.History.List then
                BG.History.List:Hide()
            end
        end
    end
    if BG.ButtonAucitonWA and BG.ButtonAucitonWA.frame then
        BG.ButtonAucitonWA.frame:Hide()
    end
    if BG.frameExportHope then
        BG.frameExportHope:Hide()
    end
    if BG.frameImportHope then
        BG.frameImportHope:Hide()
    end
end
ADDONSELF.FrameHide = FrameHide

------------------获取FBtable2数据内容------------------
--[[
do
    -- 获取副本本地化名称
    function BG.GetFBinfo(FB,"localName")
        for i, v in pairs(BG.FBtable2) do
            if FB == v.FB then
                return v.localName
            end
        end
    end

    -- 获取副本最大玩家数量
    function BG.GetFBinfo(FB,"maxplayers")
        for i, v in ipairs(BG.FBtable2) do
            if FB == v.FB then
                return v.maxplayers
            end
        end
    end

    -- 获取副本所属阶段
    function BG.GetFBinfo(FB,"phase")
        for i, v in ipairs(BG.FBtable2) do
            if FB == v.FB then
                return v.phase
            end
        end
    end
end ]]

------------------当前表格是否空白------------------  -- true 是空白，false 不是空白
function BG.BiaoGeIsEmpty(FB, _type)
    local maxb = Maxb[FB] + 1
    if _type == "onlyboss" then
        maxb = Maxb[FB] - 2
    end
    for b = 1, maxb do
        for i = 1, Maxi[FB] do
            if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                if b ~= Maxb[FB] + 1 then
                    if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText() ~= "" then
                        return false
                    end
                end
                if BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetText() ~= "" then
                    return false
                end
                if BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText() ~= "" then
                    return false
                end
                if BiaoGe[FB]["boss" .. b]["guanzhu" .. i] then
                    return false
                end
                if BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
                    return false
                end
            end
        end
    end
    return true
end

------------------隐藏提示工具------------------
local function GameTooltip_Hide()
    GameTooltip:Hide()
end
function BG.GameTooltip_Hide(frame)
    frame:SetScript("OnLeave", GameTooltip_Hide)
end

------------------查找或匹配table里的字符------------------
do
    function BG.FindTableString(text, table)
        local num
        for key, value in pairs(table) do
            num = strfind(text, value)
            if num then
                return num
            end
        end
    end

    function BG.MatchTableString(text, table)
        local str
        for key, value in pairs(table) do
            str = strmatch(text, value)
            if str then
                return str
            end
        end
    end
end
------------------返回字符串里每个字符的位置------------------
function BG.getCharacterPositions(str)
    local positions = {}
    local position = 1

    while position <= #str do
        local byte = string.byte(str, position)

        if byte >= 0xC0 and byte <= 0xDF then
            -- 处理两个字节的UTF-8字符
            positions[string.sub(str, position, position + 1)] = position
            position = position + 2
        elseif byte >= 0xE0 and byte <= 0xEF then
            -- 处理三个字节的UTF-8字符
            positions[string.sub(str, position, position + 2)] = position
            position = position + 3
        elseif byte >= 0xF0 and byte <= 0xF7 then
            -- 处理四个字节的UTF-8字符
            positions[string.sub(str, position, position + 3)] = position
            position = position + 4
        else
            -- 处理单字节字符和非法字节
            positions[string.sub(str, position, position)] = position
            position = position + 1
        end
    end

    return positions
end

------------------隐藏全部Tab按钮------------------
function BG.HideTab(Buttons, Show)
    for i, v in ipairs(Buttons) do
        v:Hide()
        v:GetParent():SetEnabled(true)
    end
    Show:Show()
    Show:GetParent():SetEnabled(false)
end

------------------计时器------------------
function BG.OnUpdateTime(func)
    local updateFrame = CreateFrame("Frame")
    updateFrame.timeElapsed = 0
    updateFrame:SetScript("OnUpdate", func)
end

--[[
BG.OnUpdateTime(function(self,elapsed)
    self.timeElapsed=self.timeElapsed+elapsed
end)
 ]]
------------------设置按钮文本的宽度------------------
function BG.SetButtonStringWidth(bt)
    local t = bt:GetFontString()
    t:SetWidth(bt:GetWidth())
    t:SetWordWrap(false)
end

------------------菜单：点文本也能打开菜单------------------
function BG.dropDownToggle(dropDown)
    dropDown:SetScript("OnMouseUp", function(self)
        LibBG:ToggleDropDownMenu(nil, nil, self)
    end)
end

------------------是国服或亚服吗------------------
function BG.IsCN()
    if GetCurrentRegionName() == "CN" or GetCurrentRegionName() == "KR" then
        return true
    end
end

------------------按键声音------------------
function BG.PlaySound(id)
    if id and BG["sound" .. id] then
        if id == 2 then
            PlaySoundFile(BG["sound" .. id], "Master")
        else
            PlaySound(BG["sound" .. id], "Master")
        end
    end
end

------------------按钮的文本截断------------------
function BG.ButtonTextSetWordWrap(bt)
    local t = bt:GetFontString()
    t:SetWidth(bt:GetWidth())
    t:SetWordWrap(false)
end

------------------按钮的文本颜色------------------
function BG.ButtonTextColor(bt, color)
    local t = bt:GetFontString()
    t:SetTextColor(RGB(color))
end

------------------团队标记材质------------------
local tex = [[Interface\TargetingFrame\UI-RaidTargetingIcons]]
local y = -3
local RaidTargetingIcons = {
    ["xingxing"] = { num = 1, tex = "|T" .. tex .. ":0:0:0:" .. y .. ":100:100:0:25:0:25" .. "|t" },
    ["dabing"] = { num = 2, tex = "|T" .. tex .. ":0:0:0:" .. y .. ":100:100:25:50:0:25" .. "|t" },
    ["ziling"] = { num = 3, tex = "|T" .. tex .. ":0:0:2:" .. y .. ":100:100:55:75:0:25" .. "|t" },
    ["sanjiao"] = { num = 4, tex = "|T" .. tex .. ":0:0:0:" .. y .. ":100:100:75:100:0:25" .. "|t" },
    ["yueliang"] = { num = 5, tex = "|T" .. tex .. ":0:0:0:" .. y .. ":100:100:0:25:25:50" .. "|t" },
    ["fangkuai"] = { num = 6, tex = "|T" .. tex .. ":0:0:0:" .. y .. ":100:100:25:50:25:50" .. "|t" },
    ["chacha"] = { num = 7, tex = "|T" .. tex .. ":0:0:0:" .. y .. ":100:100:50:75:25:50" .. "|t" },
    ["kulou"] = { num = 8, tex = "|T" .. tex .. ":0:0:0:" .. y .. ":100:100:75:100:25:50" .. "|t" },
}
function BG.SetRaidTargetingIcons(type, name)
    if type then
        return "{rt" .. RaidTargetingIcons[name].num .. "}"
    else
        return RaidTargetingIcons[name].tex
    end
end

----------滚动到最末----------
function BG.SetScrollBottom(scroll, child)
    local offset = child:GetHeight() - scroll:GetHeight()
    if offset > 0 then
        scroll:SetVerticalScroll(offset)
    end
end

----------右键菜单切换开/关----------
function BG.DropDownListIsVisible(self)
    local _, parent = _G.L_DropDownList1:GetPoint()
    if parent == self and _G.L_DropDownList1:IsVisible() then
        return true
    end
end

function BG.BG()
    return BG.STC_b1("<BiaoGe>")
end

----------右键菜单切换开/关----------
function BG.SetTextHighlightTexture(bt)
    local tex = bt:CreateTexture()
    tex:SetPoint("CENTER")
    tex:SetSize(bt:GetWidth() + 12, bt:GetHeight() - 10)
    tex:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
    bt:SetHighlightTexture(tex)
end
