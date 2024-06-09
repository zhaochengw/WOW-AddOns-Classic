local AddonName, ADDONSELF = ...

local L = ADDONSELF.L

local pt = print

local LibBG = LibStub:GetLibrary("LibUIDropDownMenu-4.0") -- 调用库菜单UI
ADDONSELF.LibBG = LibBG

C_ChatInfo.RegisterAddonMessagePrefix("BiaoGe")                                                            -- 注册插件通信频道
C_ChatInfo.RegisterAddonMessagePrefix("BiaoGeYY")                                                          -- 注册插件通信频道（用于YY评价）

BiaoGeFilterTooltip = CreateFrame("GameTooltip", "BiaoGeFilterTooltip", UIParent, "GameTooltipTemplate")   -- 用于收集提示工具文字
BiaoGeFilterTooltip2 = CreateFrame("GameTooltip", "BiaoGeFilterTooltip2", UIParent, "GameTooltipTemplate") -- 用于收集提示工具文字

local l = GetLocale()
if (l == "koKR") then
    BIAOGE_TEXT_FONT = "Fonts\\2002.TTF";
elseif (l == "zhCN") then
    BIAOGE_TEXT_FONT = "Fonts\\ARKai_T.TTF";
elseif (l == "zhTW") then
    -- BIAOGE_TEXT_FONT = "Fonts\\ARKai_T.TTF";
    BIAOGE_TEXT_FONT = "Fonts\\blei00d.TTF";
elseif (l == "ruRU") then
    BIAOGE_TEXT_FONT = "Fonts\\FRIZQT___CYR.TTF";
else
    BIAOGE_TEXT_FONT = "Fonts\\FRIZQT__.TTF";
end

local function RGB(hex)
    local red = string.sub(hex, 1, 2)
    local green = string.sub(hex, 3, 4)
    local blue = string.sub(hex, 5, 6)

    red = tonumber(red, 16) / 255
    green = tonumber(green, 16) / 255
    blue = tonumber(blue, 16) / 255
    return red, green, blue
end

-- 全局变量
BG.IsVanilla = ADDONSELF.IsVanilla
BG.IsVanilla_Sod = ADDONSELF.IsVanilla_Sod
BG.IsVanilla_60 = ADDONSELF.IsVanilla_60
BG.IsAlliance = ADDONSELF.IsAlliance
BG.IsHorde = ADDONSELF.IsHorde

local RealmId = GetRealmID()
local player = UnitName("player")

local vanillaAllFB = { "BD", "Gno", "NAXX", "TAQ", "AQL", "ZUG", "BWL", "MC", }
BG.FBtable = {}
BG.FBtable2 = {}
BG.FBIDtable = {}
do
    function AddDB(FB, FBid, phase, maxplayers)
        tinsert(BG.FBtable, FB)
        tinsert(BG.FBtable2,
            {
                FB = FB,
                ID = FBid,
                localName = GetRealZoneText(FBid),
                phase = phase,
                maxplayers = maxplayers,
            })
        BG.FBIDtable[FBid] = FB
    end

    if BG.IsVanilla_Sod() then
        BG.FB1 = "Gno"
        BG.fullLevel = 25
        BG.theEndBossID = { 2891, 2940 }
        AddDB("BD", 48, "P1", 10)
        AddDB("Gno", 90, "P2", 10)
    elseif BG.IsVanilla_60() then
        BG.FB1 = "MC"
        BG.fullLevel = 60
        BG.theEndBossID = { 617, 1084, 617, 793, 723, 717, 1114 } --MC OL BWL ZUG AQL TAQ NAXX
        AddDB("MC", 409, L["全阶段"], 40)
        AddDB("BWL", 469, L["全阶段"], 40)
        AddDB("ZUG", 309, L["全阶段"], 20)
        AddDB("AQL", 509, L["全阶段"], 20)
        AddDB("TAQ", 531, L["全阶段"], 40)
        AddDB("NAXX", 533, L["全阶段"], 40)

        BG.FBIDtable[249] = "MC" -- 奥妮克希亚的巢穴
    else
        BG.FB1 = "ICC"
        BG.fullLevel = 80
        BG.theEndBossID = { 856 }
        AddDB("NAXX", 533, "P1")
        AddDB("ULD", 603, "P2")
        AddDB("TOC", 649, "P3")
        AddDB("ICC", 631, "P4")

        BG.FBIDtable = {
            [533] = "NAXX", -- 纳克萨玛斯
            [615] = "NAXX", -- 黑曜石圣殿
            [616] = "NAXX", -- 永恒之眼
            [603] = "ULD",  -- 奥杜尔
            [649] = "TOC",  -- 十字军的试炼
            [249] = "TOC",  -- 奥妮克希亚的巢穴
            [631] = "ICC",  -- 冰冠堡垒
            [724] = "ICC",  -- 红玉圣殿
        }
    end

    BG.Movetable = {}
    BG.options = {}
    BG.itemCaches = {}
    BG.dropDown = LibBG:Create_UIDropDownMenu(nil, UIParent)

    BG.onEnterAlpha = 0.1
    BG.highLightAlpha = 0.2
    BG.scrollStep = 80

    BG.ver = ADDONSELF.ver
    BG.instructionsText = ADDONSELF.instructionsText
    BG.updateText = ADDONSELF.updateText

    ---------- 获取副本tbl某个value ----------
    function BG.GetFBinfo(FB, info)
        for i, v in ipairs(BG.FBtable2) do
            if FB == v.FB then
                return v[info]
            end
        end
    end

    -- 表格
    do
        -- 表格UI
        BG.Frame = {}
        for index, value in ipairs(BG.FBtable) do
            BG.Frame[value] = {}
            for b = 1, 22 do
                BG.Frame[value]["boss" .. b] = {}
            end
        end

        -- 底色
        BG.FrameDs = {}
        for index, value in ipairs(BG.FBtable) do
            for i = 1, 3, 1 do
                BG.FrameDs[value .. i] = {}
                for b = 1, 22 do
                    BG.FrameDs[value .. i]["boss" .. b] = {}
                end
            end
        end

        -- 心愿UI
        BG.HopeFrame = {}
        for index, value in ipairs(BG.FBtable) do
            BG.HopeFrame[value] = {}
            for n = 1, 4 do
                BG.HopeFrame[value]["nandu" .. n] = {}
                for b = 1, 22 do
                    BG.HopeFrame[value]["nandu" .. n]["boss" .. b] = {}
                end
            end
        end

        -- 心愿底色
        BG.HopeFrameDs = {}
        for index, value in ipairs(BG.FBtable) do
            for t = 1, 3, 1 do
                BG.HopeFrameDs[value .. t] = {}
                for n = 1, 4 do
                    BG.HopeFrameDs[value .. t]["nandu" .. n] = {}
                    for b = 1, 22 do
                        BG.HopeFrameDs[value .. t]["nandu" .. n]["boss" .. b] = {}
                    end
                end
            end
        end

        -- 历史UI
        BG.HistoryFrame = {}
        for index, value in ipairs(BG.FBtable) do
            BG.HistoryFrame[value] = {}
            for b = 1, 22 do
                BG.HistoryFrame[value]["boss" .. b] = {}
            end
        end

        -- 历史底色
        BG.HistoryFrameDs = {}
        for index, value in ipairs(BG.FBtable) do
            for i = 1, 3, 1 do
                BG.HistoryFrameDs[value .. i] = {}
                for b = 1, 22 do
                    BG.HistoryFrameDs[value .. i]["boss" .. b] = {}
                end
            end
        end

        -- 接收UI
        BG.ReceiveFrame = {}
        for index, value in ipairs(BG.FBtable) do
            BG.ReceiveFrame[value] = {}
            for b = 1, 22 do
                BG.ReceiveFrame[value]["boss" .. b] = {}
            end
        end

        -- 接收底色
        BG.ReceiveFrameDs = {}
        for index, value in ipairs(BG.FBtable) do
            for i = 1, 3, 1 do
                BG.ReceiveFrameDs[value .. i] = {}
                for b = 1, 22 do
                    BG.ReceiveFrameDs[value .. i]["boss" .. b] = {}
                end
            end
        end

        -- 对账UI
        BG.DuiZhangFrame = {}
        for index, value in ipairs(BG.FBtable) do
            BG.DuiZhangFrame[value] = {}
            for b = 1, 22 do
                BG.DuiZhangFrame[value]["boss" .. b] = {}
            end
        end

        -- 对账底色
        BG.DuiZhangFrameDs = {}
        for index, value in ipairs(BG.FBtable) do
            for i = 1, 3, 1 do
                BG.DuiZhangFrameDs[value .. i] = {}
                for b = 1, 22 do
                    BG.DuiZhangFrameDs[value .. i]["boss" .. b] = {}
                end
            end
        end
    end

    -- 掉落
    do
        BG.Loot = {}
        for key, FB in pairs(BG.FBtable) do
            BG.Loot[FB] = {
                N = {},
                N10 = {},
                N25 = {},
                H10 = {},
                H25 = {},

                DEATHKNIGHT = {},
                PALADIN = {},
                WARRIOR = {},
                SHAMAN = {},
                HUNTER = {},
                DRUID = {},
                ROGUE = {},
                MAGE = {},
                WARLOCK = {},
                PRIEST = {},

                Team = {},       -- 5人本
                World = {},      -- 世界掉落
                WorldBoss = {},  -- 世界boss
                T = {},          -- 职业套装
                Currency = {},   -- 货币贷款（WLK）
                Faction = {},    -- 声望
                Pvp = {},        -- PVP
                Profession = {}, -- 专业制造
                Quest = {},      -- 任务

                Sod_Pvp = {}
            }
        end
    end

    -- 字体
    do
        local function CreateMyFont(color, size, H)
            local cff
            if color == "Blue" then
                cff = "00BFFF"
            elseif color == "Green" then
                cff = "00FF00"
            elseif color == "Red" then
                cff = "FF0000"
            elseif color == "Fen" then
                cff = "FF69B4"
            elseif color == "Gold" then
                cff = "FFD100"
            elseif color == "White" then
                cff = "FFFFFF"
            elseif color == "Dis" then
                cff = "808080"
            end
            BG["Font" .. color .. size] = CreateFont("BG.Font" .. color .. size)
            BG["Font" .. color .. size]:SetTextColor(RGB(cff))
            BG["Font" .. color .. size]:SetFont(BIAOGE_TEXT_FONT, size, "OUTLINE")
        end

        CreateMyFont("Blue", 13)
        CreateMyFont("Blue", 15)

        CreateMyFont("Green", 13)
        CreateMyFont("Green", 15)
        CreateMyFont("Green", 25)

        CreateMyFont("Gold", 15)

        CreateMyFont("Red", 15)

        CreateMyFont("Fen", 15)

        CreateMyFont("White", 13)
        CreateMyFont("White", 15)
        CreateMyFont("White", 18)
        CreateMyFont("White", 25)

        CreateMyFont("Dis", 13)
        CreateMyFont("Dis", 15)
    end

    -- 函数：给文本上颜色
    do
        BG.b1 = "00BFFF"
        function BG.STC_b1(text)
            if text then
                local t
                t = "|cff" .. "00BFFF" .. text .. "|r"
                return t
            end
        end

        BG.r1 = "FF0000"
        function BG.STC_r1(text)
            if text then
                local t
                t = "|cff" .. "FF0000" .. text .. "|r"
                return t
            end
        end

        BG.r2 = "FF1493"
        function BG.STC_r2(text)
            if text then
                local t
                t = "|cff" .. "FF1493" .. text .. "|r"
                return t
            end
        end

        BG.r3 = "FF69B4"
        function BG.STC_r3(text)
            if text then
                local t
                t = "|cff" .. "FF69B4" .. text .. "|r"
                return t
            end
        end

        BG.g1 = "00FF00"
        function BG.STC_g1(text)
            if text then
                local t
                t = "|cff" .. "00FF00" .. text .. "|r"
                return t
            end
        end

        BG.g2 = "90EE90"
        function BG.STC_g2(text)
            if text then
                local t
                t = "|cff" .. "90EE90" .. text .. "|r"
                return t
            end
        end

        BG.y1 = "FFFF00"
        function BG.STC_y1(text) -- yellow
            if text then
                local t
                t = "|cff" .. "FFFF00" .. text .. "|r"
                return t
            end
        end

        BG.y2 = "FFD100"
        function BG.STC_y2(text) -- gold
            if text then
                local t
                t = "|cff" .. "FFD100" .. text .. "|r"
                return t
            end
        end

        BG.w1 = "FFFFFF"
        function BG.STC_w1(text) -- 白色
            if text then
                local t
                t = "|cff" .. "FFFFFF" .. text .. "|r"
                return t
            end
        end

        BG.dis = "808080"
        function BG.STC_dis(text) -- 灰色
            if text then
                local t
                t = "|cff" .. "808080" .. text .. "|r"
                return t
            end
        end
    end

    -- 声音
    do
        BG.sound1 = SOUNDKIT.GS_TITLE_OPTION_OK -- 按键音效
        BG.sound2 = 569593                      -- 升级音效
        BG.sound3 = SOUNDKIT.UI_TRANSMOG_APPLY  -- 确认框弹出音效
        BG.sound_paimai = "Interface\\AddOns\\BiaoGe\\Media\\sound\\paimai.mp3"
        BG.sound_hope = "Interface\\AddOns\\BiaoGe\\Media\\sound\\hope.mp3"
        BG.sound_qingkong = "Interface\\AddOns\\BiaoGe\\Media\\sound\\qingkong.mp3"
        BG.sound_cehuiqingkong = "Interface\\AddOns\\BiaoGe\\Media\\sound\\cehuiqingkong.mp3"
    end
end


-- 数据库（保存至本地）
local function DataBase()
    -- 数据库冲突检测
    do
        if BiaoGe and type(BiaoGe) == "table" and BiaoGe.FB then
            local checktbl
            if BG.IsVanilla() then
                checktbl = vanillaAllFB
            else
                checktbl = BG.FBtable
            end

            local yes
            for k, FB in pairs(checktbl) do
                if BiaoGe.FB == FB then
                    yes = true
                    break
                end
            end
            if not yes then
                BiaoGe = nil
                SendSystemMessage(BG.BG .. " " .. L["检测到配置文件错误，现已重置！"])
            end
        end
    end

    -- 开始
    do
        if BiaoGe then
            if type(BiaoGe) ~= "table" then
                BiaoGe = {}
            end
        else
            BiaoGe = {}
        end
        if not BiaoGe.point then
            BiaoGe.point = {}
        end
        if not BiaoGe.duizhang then
            BiaoGe.duizhang = {}
        end

        for index, value in ipairs(BG.FBtable) do
            if not BiaoGe[value] then
                BiaoGe[value] = {}
            end
            for b = 1, 22 do
                if not BiaoGe[value]["boss" .. b] then
                    BiaoGe[value]["boss" .. b] = {}
                end
            end
        end

        if not BiaoGe.HistoryList then
            BiaoGe.HistoryList = {}
        end
        for index, value in ipairs(BG.FBtable) do
            if not BiaoGe.HistoryList[value] then
                BiaoGe.HistoryList[value] = {}
            end
        end

        if not BiaoGe.History then
            BiaoGe.History = {}
        end
        for index, value in ipairs(BG.FBtable) do
            if not BiaoGe.History[value] then
                BiaoGe.History[value] = {}
            end
        end

        if not BG.IsVanilla() then
            if not BiaoGe.BossFrame then
                BiaoGe.BossFrame = {}
            end
            for index, value in ipairs(BG.FBtable) do
                if not BiaoGe.BossFrame[value] then
                    BiaoGe.BossFrame[value] = {}
                end
            end
        end

        if not BiaoGe.options then
            BiaoGe.options = {}
        end
        if not BiaoGe.options.SearchHistory then
            BiaoGe.options.SearchHistory = {}
        end
        local name = "moLing"
        BG.options[name .. "reset"] = 1
        if not BiaoGe.options[name] then
            BiaoGe.options[name] = BG.options[name .. "reset"]
        end

        -- 高亮天赋装备
        if not BiaoGe.filterClassNum then
            BiaoGe.filterClassNum = {}
        end
        if not BiaoGe.filterClassNum[RealmId] then
            BiaoGe.filterClassNum[RealmId] = {}
        end
        if not BiaoGe.filterClassNum[RealmId][player] then
            BiaoGe.filterClassNum[RealmId][player] = 0
        end
        if BiaoGeA and BiaoGeA.filterClassNum then
            BiaoGe.filterClassNum[RealmId][player] = BiaoGeA.filterClassNum
            BiaoGeA.filterClassNum = nil
        end

        -- 心愿清单
        if not BiaoGe.Hope then
            BiaoGe.Hope = {}
        end

        if not BiaoGe.Hope[RealmId] then
            BiaoGe.Hope[RealmId] = {}
        end
        if not BiaoGe.Hope[RealmId][player] then
            BiaoGe.Hope[RealmId][player] = {}
        end
        for index, FB in ipairs(BG.FBtable) do
            if not BiaoGe.Hope[RealmId][player][FB] then
                BiaoGe.Hope[RealmId][player][FB] = {}
            end
            for n = 1, 4 do
                if not BiaoGe.Hope[RealmId][player][FB]["nandu" .. n] then
                    BiaoGe.Hope[RealmId][player][FB]["nandu" .. n] = {}
                    for b = 1, 22 do
                        if not BiaoGe.Hope[RealmId][player][FB]["nandu" .. n]["boss" .. b] then
                            BiaoGe.Hope[RealmId][player][FB]["nandu" .. n]["boss" .. b] = {}
                        end
                    end
                end
            end
        end
        if BiaoGeA and BiaoGeA.Hope then
            for k, v in pairs(BiaoGeA.Hope) do
                BiaoGe.Hope[RealmId][player][k] = v
            end
            BiaoGeA.Hope = nil
        end
    end
end

-- 其他
do
    local Width = {}
    local Height = {}
    local Maxt = {}
    local Maxb = {}
    local Maxi = {}

    local function AddDB(FB, width, height, maxt, maxb, maxi)
        Width[FB] = width
        Height[FB] = height
        Maxt[FB] = maxt
        Maxb[FB] = maxb
        Maxi[FB] = maxi
    end
    BG.Maxi = 30
    if BG.IsVanilla_Sod() then
        AddDB("BD", 1290, 835, 3, 9, 11)
        AddDB("Gno", 1290, 835, 3, 8, 11)
    elseif BG.IsVanilla_60() then
        AddDB("MC", 1290, 875, 3, 13, 15)
        AddDB("BWL", 1290, 810, 3, 10, 15)
        AddDB("ZUG", 1290, 810, 3, 12, 15)
        AddDB("AQL", 1290, 810, 3, 8, 15)
        AddDB("TAQ", 1290, 810, 3, 11, 15)
        AddDB("NAXX", 1710, 810, 4, 17, 15)
    else
        AddDB("ICC", 1290, 875, 3, 15, 16)
        AddDB("TOC", 1290, 835, 3, 9, 14)
        AddDB("ULD", 1290, 875, 3, 16, 8)
        AddDB("NAXX", 1710, 945, 4, 19, 11)
    end
    ADDONSELF.Width = Width
    ADDONSELF.Height = Height
    ADDONSELF.Maxt = Maxt
    ADDONSELF.Maxb = Maxb
    ADDONSELF.Maxi = Maxi


    local HopeMaxi
    local HopeMaxb = {}
    local HopeMaxn = {}

    if BG.IsVanilla() then
        HopeMaxi = 5
    else
        HopeMaxi = 3
    end
    ADDONSELF.HopeMaxi = HopeMaxi

    for _, FB in pairs(BG.FBtable) do
        HopeMaxb[FB] = Maxb[FB] - 1
    end
    ADDONSELF.HopeMaxb = HopeMaxb

    if BG.IsVanilla() then
        for _, FB in pairs(BG.FBtable) do
            HopeMaxn[FB] = 1
        end
    else
        HopeMaxn["ICC"] = 4
        HopeMaxn["TOC"] = 4
        HopeMaxn["ULD"] = 2
        HopeMaxn["NAXX"] = 2
    end
    ADDONSELF.HopeMaxn = HopeMaxn
end



local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == AddonName then
        DataBase()
    end
end)
