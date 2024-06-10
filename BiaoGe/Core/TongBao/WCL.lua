local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local FrameHide = ADDONSELF.FrameHide
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local pt = print

------------------函数：WCL------------------
local function Expand(v)
    local switch = {
        ["V"] = function()
            return "VOA"
        end,
        ["X"] = function()
            return "NAX"
        end,
        ["D"] = function()
            return "ULD"
        end,
        ["O"] = function()
            return "Onyxia"
        end,
        ["T"] = function()
            return "TOC"
        end,
        ["I"] = function()
            return "ICC"
        end,
        ["A"] = function()
            return "|cFFE5CC80"
        end,
        ["L"] = function()
            return "|cFFFF8000"
        end,
        ["S"] = function()
            return "|cFFE26880"
        end,
        ["N"] = function()
            return "|cFFBE8200"
        end,
        ["E"] = function()
            return "|cFFA335EE"
        end,
        ["R"] = function()
            return "|cFF0070FF"
        end,
        ["U"] = function()
            return "|cFF1EFF00"
        end,
        ["C"] = function()
            return "|cFF666666"
        end,
        ["%"] = function()
            return "% "
        end
    }
    local fenshu = ""
    local max = strlen(v)
    for j = 1, max do
        local ts = strsub(v, j, j)
        local f = switch[ts]
        if f then
            fenshu = fenshu .. f()
        else
            fenshu = fenshu .. ts
        end
    end
    return fenshu
end

local function WCLpm()
    if type(WP_Database) ~= "table" then
        return
    end
    local updatetime = WP_Database.LASTUPDATE
    local wclname1 = {}   -- 单纯的名字
    local wclname2 = {}   -- 带颜色字符的名字
    local wclfenshu1 = {} -- 单纯的数字分数
    local wclfenshu2 = {} -- 短字符串分数
    local wclfenshu3 = {} -- 带颜色字符的分数
    local num = GetNumGroupMembers()
    if not IsInRaid(1) then
        num = 1
    end
    for i = 1, num do
        local fenshu1 -- 单纯的数字分数
        local fenshu2 -- 短字符串分数
        local fenshu3 -- 带颜色字符的分数
        local name = UnitName("raid" .. i)
        if not IsInRaid(1) then
            name = UnitName("player")
        end
        local _, class = UnitClass("raid" .. i)
        if not IsInRaid(1) then
            _, class = UnitClass("player")
        end
        local _, _, _, color = GetClassColor(class)
        for k, v in pairs(WP_Database) do -- WP_Database = {["Rainforce"]="ED:(平衡)12892/79.6%RX:(平衡)16641/63.1%LV:(守护)45/98.4%|1"}
            if k == name then             -- 如果在WCL数据里找到该名团员名字
                local a = string.find(v, "/")
                fenshu1 = tonumber(strsub(v, a + 1, a + 4))
                local b = string.find(v, ":")
                fenshu2 = strsub(v, b + 1, a + 5)
                local max = strlen(v)
                local vv = strsub(v, 1, max - 2) .. "|r" .. "|r" .. "|r"
                fenshu3 = Expand(vv) -- 获取并转换带颜色的WCL分数
            end
        end

        table.insert(wclname1, name) -- 保存单纯的名字到表

        name = "|c" .. color .. name .. "|r"
        table.insert(wclname2, name) -- 保存带颜色字符串的名字到表

        if not fenshu1 then
            fenshu1 = 0
        end
        table.insert(wclfenshu1, fenshu1) -- 保存单纯的数字分数到表

        if not fenshu2 then
            fenshu2 = L["没有WCL记录"]
        end
        table.insert(wclfenshu2, fenshu2) -- 保存短字符串分数到表

        if not fenshu3 then
            fenshu3 = L["没有WCL记录"]
        end
        table.insert(wclfenshu3, fenshu3) -- 保存带颜色字符串分数到表
    end
    -- 开始排序
    local wclname4 = {}       -- 单纯的名字
    local wclname5 = {}       -- 带颜色字符的名字
    local wclfenshu4 = {}     -- 单纯的分数
    local wclfenshu5 = {}     -- 短字符串分数
    local wclfenshu6 = {}     -- 带颜色字符的分数
    for t = 1, #wclfenshu1 do -- 找到最大数值
        local max = nil
        for k, v in ipairs(wclfenshu1) do
            if tonumber(v) then
                if max == nil then
                    max = v
                end
                if max < v then
                    max = v
                end
            end
        end
        if not max then
            break
        end
        for i = 1, #wclfenshu1 do
            if wclfenshu1[i] == max then
                table.insert(wclname4, wclname1[i])     -- 保存单纯的名字到表
                table.insert(wclname5, wclname2[i])     -- 保存带颜色字符串的名字到表
                table.insert(wclfenshu4, wclfenshu1[i]) -- 保存单纯的分数到表
                table.insert(wclfenshu5, wclfenshu2[i]) -- 保存短字符串分数到表
                table.insert(wclfenshu6, wclfenshu3[i]) -- 保存带颜色字符串分数到表

                table.remove(wclname1, i)
                table.remove(wclname2, i)
                table.remove(wclfenshu1, i)
                table.remove(wclfenshu2, i)
                table.remove(wclfenshu3, i)
            end
        end
    end
    return wclname4, wclname5, wclfenshu4, wclfenshu5, wclfenshu6, updatetime -- 单纯的名字，带颜色字符串的名字，单纯的分数，短字符串分数，带颜色字符串分数，更新日期
end

-- 按WCL分数上标记
local function WCLcolor(fenshu)
    local f = tonumber(fenshu)
    local b                 -- 标记
    if f then
        if f >= 99 then     -- 星星：粉
            b = "{rt1}"
        elseif f >= 95 then -- 大饼：橙
            b = "{rt2}"
        elseif f >= 75 then -- 紫菱：紫
            b = "{rt3}"
        elseif f >= 5 then  -- 方块：蓝
            b = "{rt6}"
        elseif f >= 25 then -- 三角：绿
            b = "{rt4}"
        elseif f > 0 then   -- 骷髅：灰
            b = "{rt8}"
        elseif f == 0 then
            b = "{rt7}" -- 叉叉：无
        end
    else
        b = "{rt7}" -- 叉叉：无
    end
    return b
end


function BG.WCLUI(lastbt)
    local bt = CreateFrame("Button", nil, BG.FBMainFrame, "UIPanelButtonTemplate")
    bt:SetSize(90, BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", 10, 0)
    bt:SetText(L["通报WCL"])
    BG.ButtonWCL = bt
    if BG.IsVanilla() then bt:Hide() end

    local groupchange = true
    local f = CreateFrame("Frame")
    f:RegisterEvent("GROUP_ROSTER_UPDATE")
    f:SetScript("OnEvent", function(self, even, ...)
        groupchange = true
    end)

    -- 鼠标悬停提示
    local text
    local wclname4, wclname5, wclfenshu4, wclfenshu5, wclfenshu6, updatetime -- 单纯的名字，带颜色字符串的名字，单纯的分数，短字符串分数，带颜色字符串分数，更新日期
    bt:SetScript("OnEnter", function(self)
        if BG.Backing then return end
        if groupchange then
            wclname4, wclname5, wclfenshu4, wclfenshu5, wclfenshu6, updatetime = WCLpm()
            if not updatetime then
                text = L["读取不到数据，你可能没安装或者没打开WCL插件"]
            else
                updatetime = "|cffFFFFFF" .. L["更新时间："] .. updatetime .. "|r"
                text = "|cffffffff" .. L["< WCL分数 >"] .. RN
                local num = GetNumGroupMembers()
                if not IsInRaid(1) then
                    num = 1
                end
                for i = 1, num do
                    if wclname5[i] and wclfenshu6[i] then
                        text = text .. i .. "、" .. wclname5[i] .. "：" .. wclfenshu6[i] .. "\n"
                    end
                end
                text = text .. updatetime
            end
            groupchange = false
        end
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:SetText(text)
    end)
    bt:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    -- 点击通报WCL分数
    bt:SetScript("OnClick", function(self)
        FrameHide(0)
        if not IsInRaid(1) then
            SendSystemMessage(L["不在团队，无法通报"])
            PlaySound(BG.sound1, "Master")
        else
            self:SetEnabled(false) -- 点击后按钮变灰2秒
            C_Timer.After(2, function()
                bt:SetEnabled(true)
            end)
            wclname4, wclname5, wclfenshu4, wclfenshu5, wclfenshu6, updatetime = WCLpm()
            if not updatetime then
                return
            end
            updatetime = L["更新时间："] .. updatetime
            local text = ""
            local num = GetNumGroupMembers()
            SendChatMessage(L["———通报WCL分数———"], "RAID")
            for i = 1, num do
                if wclname4[i] and wclfenshu4[i] and wclfenshu5[i] then
                    text = WCLcolor(wclfenshu4[i]) .. i .. "、" .. wclname4[i] .. "：" .. wclfenshu5[i] .. "\n"
                    SendChatMessage(text, "RAID")
                end
            end
            text = updatetime
            SendChatMessage(text, "RAID")
            PlaySoundFile(BG.sound2, "Master")
        end
    end)

    return bt
end

--AD：粉
--LD：橙
--ED：紫
--RD：蓝
--UD：绿
--CD：灰
