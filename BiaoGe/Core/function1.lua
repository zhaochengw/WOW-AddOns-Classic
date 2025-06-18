local _, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Maxb = ns.Maxb
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi
local RGB = ns.RGB

local pt = print
local RealmID = GetRealmID()
local player = BG.playerName
BG.After = C_Timer.After

------------------函数：四舍五入------------------ 数字，小数点数
local function Round(number, decimal_places)
    local mult = 10 ^ (decimal_places or 0)
    return math.floor(number * mult + 0.5) / mult
end
ns.Round = Round

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
        return "|cff" .. c .. name .. "|r"
    else
        return c
    end
end
ns.RGB_16 = RGB_16

local function SetColorName(name, r, g, b)
    if not (r and g and b) then
        return name
    end
    local r = format("%X", tonumber(r) * 255)
    if r and strlen(r) == 1 then
        r = "0" .. r
    end
    local g = format("%X", tonumber(g) * 255)
    if g and strlen(g) == 1 then
        g = "0" .. g
    end
    local b = format("%X", tonumber(b) * 255)
    if b and strlen(b) == 1 then
        b = "0" .. b
    end
    return "|cff" .. r .. g .. b .. name .. "|r"
end
ns.SetColorName = SetColorName

-- 第几个BOSS
local function BossNum(FB, b, t)
    local tbl = BG.BossNumtbl[FB]
    local bb
    if tbl[t + 1] then
        bb = tbl[t + 1] - tbl[t]
    else
        bb = Maxb[FB] + 2 - tbl[t]
    end
    return b + tbl[t], bb, t, b
end
ns.BossNum = BossNum

function BG.GetBossNumInfo(FB, bossNum)
    local tbl = BG.BossNumtbl[FB]
    for i = 1, #tbl do
        if (not tbl[i + 1]) or (tbl[i] < bossNum and tbl[i + 1] >= bossNum) then
            -- 第几列，第几个
            return i, bossNum - tbl[i]
        end
    end
end

------------------在文本里插入材质图标------------------
local function AddTexture(Texture, y, coord, width)
    if not Texture then
        return ""
    end
    local x = 0
    if not y then
        y = "-0"
    end
    local tex = ""
    local coord = coord or ""
    if Texture == "MAINTANK" then                      -- 主坦克
        tex = "132064"
    elseif Texture == "MAINASSIST" then                -- 主助理
        tex = "132063"
    elseif Texture == "TANK" then                      -- 坦克职责
        return "|A:ui-lfg-roleicon-tank:0:0|a"
    elseif Texture == "HEALER" then                    -- 治疗职责
        return "|A:ui-lfg-roleicon-healer:0:0|a"
    elseif Texture == "DAMAGER" then                   -- 输出职责
        return "|A:ui-lfg-roleicon-dps:0:0|a"
    elseif Texture == 137000 or Texture == 136998 then -- 战场荣誉
        coord = ":100:100:10:60:0:55"
        local t = "|T" .. Texture .. ":0:0:0:0" .. coord .. "|t"
        return t
    elseif Texture == "QUEST" then -- 黄色感叹号
        tex = "Interface\\GossipFrame\\AvailableQuestIcon"
    elseif Texture == "VIP" then
        return "|TInterface\\AddOns\\BiaoGe\\Media\\icon\\VIP:0:0:0:0:100:100:10:90:10:90|t"
    elseif Texture == "VIP2" then
        return "|TInterface\\AddOns\\BiaoGe\\Media\\icon\\VIP2:0:0:0:0:100:100:10:90:10:90|t"
    elseif Texture == "BOX" then
        tex = "Interface\\AddOns\\BiaoGe\\Media\\icon\\BOX"
    elseif Texture == "DD" then
        tex = "Interface\\AddOns\\BiaoGe\\Media\\icon\\DD"
    elseif Texture == "LEFT" then
        return "|A:NPE_LeftClick:0:0|a"
    elseif Texture == "RIGHT" then
        return "|A:NPE_RightClick:0:0|a"
    else
        tex = Texture
    end
    width = width or 0
    return "|T" .. tex .. ":" .. width .. ":" .. width .. ":" .. x .. ":" .. y .. coord .. "|t"
end
ns.AddTexture = AddTexture

function BG.SetButtonAtlas(bt, atlas)
    local tex = bt:CreateTexture()
    tex:SetAllPoints()
    tex:SetAtlas(atlas)
    local tex2 = bt:CreateTexture()
    tex2:SetAllPoints()
    tex2:SetAtlas(atlas)
    bt:SetNormalTexture(tex)
    bt:SetHighlightTexture(tex2)
end

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
    local t = text:gsub("|T.-|t", ""):gsub("|A.-|a", "")
    return t
end
ns.GetText_T = GetText_T

------------------函数：获取名字的职业颜色RGB------------------
local function GetClassRGB(name, player, Alpha)
    local _, class
    if player then
        _, class = UnitClass(player)
    else
        _, class = UnitClass(BG.GSN(name))
    end
    local c1, c2, c3 = 1, 1, 1
    if class then
        c1, c2, c3 = GetClassColor(class)
    end
    return c1, c2, c3, Alpha
end
ns.GetClassRGB = GetClassRGB

------------------函数：设置名字为职业颜色CFF代码（|cffFFFFFF名字|r）------------------
local function SetClassCFF(name, player, type)
    if type then return name end
    local _, class
    if player then
        _, class = UnitClass(player)
    else
        _, class = UnitClass(BG.GSN(name))
    end
    if class then
        local color = select(4, GetClassColor(class))
        return "|c" .. color .. name .. "|r", color
    else
        return name, ""
    end
end
ns.SetClassCFF = SetClassCFF

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
    return tonumber(text:match("item:(%d+):"))
end
ns.GetItemID = GetItemID

------------------清除输入框的焦点------------------
function BG.ClearFocus()
    if BG.lastfocus then
        BG.lastfocus:ClearFocus()
    end
end

------------------事件监控------------------
local events = {}
local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(_, event, ...)
    for _, func in ipairs(events[event]) do
        if event == "COMBAT_LOG_EVENT_UNFILTERED" then
            func(f, event, CombatLogGetCurrentEventInfo())
        else
            func(f, event, ...)
        end
    end
end)
function BG.RegisterEvent(event, func)
    if not events[event] then
        events[event] = {}
        f:RegisterEvent(event)
    end
    tinsert(events[event], func)
end

------------------函数：隐藏窗口------------------   -- 0：隐藏焦点+全部框架，1：隐藏全部框架，2：隐藏除历史表格外的框架
function BG.FrameHide(num)
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
    if BG.auctionLogFrame and BG.auctionLogFrame.changeFrame then
        BG.auctionLogFrame.changeFrame:Hide()
    end
end

------------------当前表格已经有东西了------------------
function BG.BiaoGeHavedItem(FB, _type, instanceID)
    local startB = 1
    local endB = Maxb[FB] + 1
    if _type == "onlyboss" then
        endB = Maxb[FB] - 2
    elseif _type == "autoQingKong" then
        startB = BG.bossPositionStartEnd[instanceID][1]
        endB = BG.bossPositionStartEnd[instanceID][2]
    end
    for b = startB, endB do
        for i = 1, BG.GetMaxi(FB, b) do
            if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                if b ~= Maxb[FB] + 1 and BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText() ~= "" then
                    return true
                end
                if BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetText() ~= "" then
                    return true
                end
                if BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText() ~= "" then
                    return true
                end
                if BiaoGe[FB]["boss" .. b]["guanzhu" .. i] then
                    return true
                end
                if BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
                    return true
                end
            end
        end
    end
    return false
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
    return updateFrame
end

--[[
BG.OnUpdateTime(function(self,elapsed)
    self.elapsed=self.elapsed+elapsed
    if self.elapsed then
        self:SetScript("OnUpdate",nil)
        self:Hide()
    end
end)
 ]]

------------------设置按钮文本的宽度------------------
function BG.SetButtonStringWidth(bt)
    local t = bt:GetFontString()
    t:SetWidth(bt:GetWidth())
    t:SetWordWrap(false)
end

------------------按钮适应文本的宽度------------------
function BG.SetButtonWidthForString(bt)
    local t = bt:GetFontString()
    bt:SetWidth(t:GetWidth())
end

------------------菜单：点文本也能打开菜单------------------
function BG.dropDownToggle(dropDown)
    dropDown:SetScript("OnMouseDown", function(self)
        if dropDown.isDisabled then return end
        LibBG:ToggleDropDownMenu(nil, nil, self)
        BG.PlaySound(1)
    end)
    BG.SkinDropDown(dropDown)
end

------------------是国服或亚服吗------------------
function BG.IsCN()
    if GetCurrentRegionName() == "CN" or GetCurrentRegionName() == "TW" or GetCurrentRegionName() == "KR" then
        return true
    end
end

------------------按键声音------------------
function BG.PlaySound(id)
    if BiaoGe.options['buttonSound'] == 1 and type(id) == "number" then
        if BG["sound" .. id] then
            if id == 2 then
                PlaySoundFile(BG["sound" .. id])
            else
                PlaySound(BG["sound" .. id])
            end
        end
    elseif BiaoGe.options['tipsSound'] == 1 and type(id) == "string" then
        PlaySoundFile(BG["sound_" .. id .. BiaoGe.options.Sound]..".mp3", "Master")
        PlaySoundFile(BG["sound_" .. id .. BiaoGe.options.Sound]..".ogg", "Master")
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

function BG.GsubRaidTargetingIcons(text)
    for k, v in pairs(RaidTargetingIcons) do
        text = text:gsub("{rt" .. v.num .. "}", v.tex)
    end
    return text
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

----------高亮按钮----------
function BG.SetTextHighlightTexture(bt)
    local tex = bt:CreateTexture()
    -- tex:SetPoint("CENTER")
    -- tex:SetSize(bt:GetWidth() + 15, bt:GetHeight() - 10)
    tex:SetPoint("TOPLEFT", bt, "TOPLEFT", -8, 0)
    tex:SetPoint("BOTTOMRIGHT", bt, "BOTTOMRIGHT", 8, 0)
    tex:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
    bt:SetHighlightTexture(tex)
end

----------鼠标/按钮是否在右边----------
do
    function BG.CursorIsInRight()
        local uiScale = UIParent:GetEffectiveScale()
        if GetCursorPosition() / uiScale > UIParent:GetWidth() * 0.5 then
            return true
        end
    end

    function BG.ButtonIsInRight(self)
        if self:GetCenter() > UIParent:GetWidth() * 0.5 then
            return true
        end
    end
end

----------把time转换为时或分----------
function BG.SecondsToTime(second)
    local h = floor(second / 3600)
    if h >= 1 then
        return h .. L["小时"]
    end

    local m = floor(second / 60)
    if m >= 1 then
        return m .. L["分钟"]
    end

    local s = floor(second)
    if s then
        return m .. L["秒"]
    end
end

----------是否已经拥有某物品----------
function BG.GetItemCount(itemIDorLink)
    local itemID = itemIDorLink
    if not tonumber(itemIDorLink) then
        itemID = tonumber(itemIDorLink:match("item:(%d+)"))
    end
    for _, FB in pairs(BG.FBtable) do
        for itemID2 in pairs(BG.Loot[FB].ExchangeItems) do
            if itemID == itemID2 then
                for _, itemID3 in pairs(BG.Loot[FB].ExchangeItems[itemID2]) do
                    local count = GetItemCount(itemID3, true)
                    if count ~= 0 then
                        return count
                    end
                end
            end
        end
    end
    return GetItemCount(itemID, true)
end

function BG.SendSystemMessage(msg)
    SendSystemMessage(BG.STC_b1("<BiaoGe>") .. " " .. msg)
end

function BG.SetBorderAlpha(self)
    self.Left:SetAlpha(BG.otherEditAlpha)
    self.Right:SetAlpha(BG.otherEditAlpha)
    self.Middle:SetAlpha(BG.otherEditAlpha)
end

function BG.FormatNumber(num)
    local len = strlen(num)
    if len <= 3 then
        return num
    else
        local k = num:sub(-4, -4)
        local w = num:sub(1, -5)
        if w == "" then
            w = 0
        end
        return w .. "." .. k .. L["万"]
    end
    -- local formatted = tostring(num)
    -- formatted = formatted:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,","")
    -- return formatted
end

function BG.Copy(table)
    if type(table) == "table" then
        local t = {}
        for k, v in pairs(table) do
            if type(v) == "table" then
                t[k] = BG.Copy(v) -- 递归拷贝子表
            else
                t[k] = v
            end
        end
        return t
    else
        return table
    end
end

function BG.DeletePlayerData(realmID, player)
    if BiaoGe.Hope and BiaoGe.Hope[realmID] then
        BiaoGe.Hope[realmID][player] = nil
    end
    if BiaoGe.FilterClassItemDB and BiaoGe.FilterClassItemDB[realmID] then
        BiaoGe.FilterClassItemDB[realmID][player] = nil
    end
    if BiaoGe.filterClassNum and BiaoGe.filterClassNum[realmID] then
        BiaoGe.filterClassNum[realmID][player] = nil
    end
    if BiaoGe.MeetingHorn and BiaoGe.MeetingHorn[realmID] then
        BiaoGe.MeetingHorn[realmID][player] = nil
    end
    if BiaoGe.MeetingHornWhisper and BiaoGe.MeetingHornWhisper[realmID] then
        BiaoGe.MeetingHornWhisper[realmID][player] = nil
    end
    if BiaoGe.FBCD and BiaoGe.FBCD[realmID] then
        BiaoGe.FBCD[realmID][player] = nil
    end
    if BiaoGe.QuestCD and BiaoGe.QuestCD[realmID] then
        BiaoGe.QuestCD[realmID][player] = nil
    end
    if BiaoGe.Money and BiaoGe.Money[realmID] then
        BiaoGe.Money[realmID][player] = nil
    end
    if BiaoGe.tradeSkillCooldown and BiaoGe.tradeSkillCooldown[realmID] then
        BiaoGe.tradeSkillCooldown[realmID][player] = nil
    end
    if BiaoGe.PlayerItemsLevel and BiaoGe.PlayerItemsLevel[realmID] then
        BiaoGe.PlayerItemsLevel[realmID][player] = nil
    end
    if BiaoGe.playerInfo and BiaoGe.playerInfo[realmID] then
        BiaoGe.playerInfo[realmID][player] = nil
    end
    if BiaoGe.equip and BiaoGe.equip[realmID] then
        BiaoGe.equip[realmID][player] = nil
    end
    if BiaoGe.bag and BiaoGe.bag[realmID] then
        BiaoGe.bag[realmID][player] = nil
    end
    if BiaoGeVIP and BiaoGeVIP.RoleOverviewSort and BiaoGeVIP.RoleOverviewSort[realmID] then
        for i, v in ipairs(BiaoGeVIP.RoleOverviewSort[realmID]) do
            if v.player == player then
                tremove(BiaoGeVIP.RoleOverviewSort[realmID], i)
                break
            end
        end
    end
end

--获取副本tbl某个value
function BG.GetFBinfo(FB, info)
    for i, v in ipairs(BG.FBtable2) do
        if FB == v.FB then
            return v[info]
        end
    end
end

function BG.GetSpecID()
    return GetSpecializationInfo(GetSpecialization())
end

function BG.SetSpecIDToLink(link)
    if BG.IsRetail then
        local k = link:match("item:%d+:[%d-:]+")
        local _, s = k:find("item:%d+:%d-:%d-:%d-:%d-:%d-:%d-:%d-:")
        local _, e = k:find("item:%d+:%d-:%d-:%d-:%d-:%d-:%d-:%d-:%d-:%d-:")
        k = k:sub(1, s) .. "80:" .. BG.GetSpecID() .. k:sub(e, #k)
        return link:gsub("item:%d+:[%d-:]+", k)
    else
        return link
    end
end

-- function BG.GsubLink(link1,link2)
--     return link1:gsub("(item:)%d+:[%d-:]+","%1"..link2)
-- end

local function Get(link)
    local tbl = { strsplit(":", link) }
    tremove(tbl, 1)
    local itemID = tbl[1]
    local bonus = {}
    for i = 13, #tbl do
        tinsert(bonus, tbl[i])
    end
    return itemID, bonus
end
function BG.IsSameItem(link1, link2)
    if BG.IsRetail then
        local itemID1, bonus1 = Get(link1)
        local itemID2, bonus2 = Get(link2)
        if not (itemID1 == itemID2 and #bonus1 == #bonus2) then
            return
        end
        for i = 1, #bonus1 do
            if bonus1[i] ~= bonus2[i] then
                return
            end
        end
        return true
    else
        return GetItemID(link1) == GetItemID(link2)
    end
end

-- function BG.()

-- end

function BG.ClearColorCode(text)
    return text:gsub("|c........", ""):gsub("|r", "")
end

function BG.ClearCode(text)
    return text:gsub("|T.-|t", ""):gsub("|A.-|a", ""):gsub("|cff......", ""):gsub("|r", "")
end
