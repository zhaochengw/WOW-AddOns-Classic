local AddonName, ns = ...

local L = ns.L

local pt = print

local LibBG = LibStub:GetLibrary("LibUIDropDownMenu-4.0") -- 调用库菜单UI
ns.LibBG = LibBG

C_ChatInfo.RegisterAddonMessagePrefix("BiaoGe")                                                -- 注册插件通信频道
C_ChatInfo.RegisterAddonMessagePrefix("BiaoGeYY")                                              -- 注册插件通信频道（用于YY评价）

BiaoGeTooltip = CreateFrame("GameTooltip", "BiaoGeTooltip", UIParent, "GameTooltipTemplate")   -- 用于装备过滤功能
BiaoGeTooltip2 = CreateFrame("GameTooltip", "BiaoGeTooltip2", UIParent, "GameTooltipTemplate") -- 用于装备库
BiaoGeTooltip2:SetClampedToScreen(false)
BiaoGeTooltip3 = CreateFrame("GameTooltip", "BiaoGeTooltip3", UIParent, "GameTooltipTemplate") -- 用于装备过期提醒
BiaoGeTooltip4 = CreateFrame("GameTooltip", "BiaoGeTooltip4", UIParent, "GameTooltipTemplate") -- 用于通报多本账单

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

local realmID = GetRealmID()
local player = UnitName("player")

-- 全局变量
BG.FBtable = {}
BG.FBtable2 = {}
BG.FBIDtable = {}
BG.lootQuality = {}
BG.difficultyTable = {}
BG.phaseFBtable = {}
BG.bossPositionTbl = {}
BG.FBfromBossPosition = {}
BG.instanceIDfromBossPosition = {}
do
    BG.Maxi                                                               = 30
    local mainFrameWidth                                                  = 1295
    local Width, Height, Maxt, Maxb, Maxi, BossNumtbl, HopeMaxb, HopeMaxn = {}, {}, {}, {}, {}, {}, {}, {}
    do
        local function AddDB(FB, width, height, maxt, maxb, bossNumtbl, hopemaxn)
            Width[FB] = width
            Height[FB] = height
            Maxt[FB] = maxt
            Maxb[FB] = maxb
            Maxi[FB] = BG.Maxi
            BossNumtbl[FB] = bossNumtbl
            HopeMaxb[FB] = maxb - 1
            HopeMaxn[FB] = hopemaxn or 1
        end
        if BG.IsVanilla_Sod then
            AddDB("BD", mainFrameWidth, 835, 3, 9, { 0, 5, 9 })
            AddDB("Gno", mainFrameWidth, 835, 3, 8, { 0, 5, 8 })
            AddDB("Temple", mainFrameWidth, 885, 3, 10, { 0, 6, 9, })
            AddDB("UBRS", mainFrameWidth, 835, 3, 10, { 0, 5, 9 })
            AddDB("MCsod", 1715, 900, 4, 16, { 0, 7, 12, 15 })
        elseif BG.IsVanilla_60 then
            AddDB("MC", mainFrameWidth, 873, 3, 13, { 0, 8, 12 })
            AddDB("BWL", mainFrameWidth, 810, 3, 10, { 0, 5, 9 })
            AddDB("ZUG", mainFrameWidth, 810, 3, 12, { 0, 6, 11 })
            AddDB("AQL", mainFrameWidth, 810, 3, 8, { 0, 5, 8 })
            AddDB("TAQ", mainFrameWidth, 810, 3, 11, { 0, 6, 10 })
            AddDB("NAXX", 1715, 810, 4, 17, { 0, 6, 12, 16 })
        elseif BG.IsWLK then
            AddDB("ICC", mainFrameWidth, 875, 3, 15, { 0, 7, 13 }, 4)
            AddDB("TOC", mainFrameWidth, 835, 3, 9, { 0, 5, 8 }, 4)
            AddDB("ULD", mainFrameWidth, 875, 3, 16, { 0, 7, 13 }, 2)
            AddDB("NAXX", 1715, 945, 4, 19, { 0, 6, 12, 16 }, 2)
        elseif BG.IsCTM then
            AddDB("BOT", 1715, 930, 4, 15, { 0, 5, 10, 14 }, 2)
        end
    end

    do
        local function AddDB(FB, instanceID, phase, maxplayers, lootQuality, difficultyTable, phaseTable, bossPositionTbl)
            tinsert(BG.FBtable, FB)
            tinsert(BG.FBtable2,
                {
                    FB = FB,
                    ID = instanceID,
                    localName = GetRealZoneText(instanceID),
                    phase = phase,
                    maxplayers = maxplayers,
                })
            BG.FBIDtable[instanceID] = FB
            BG.lootQuality[FB] = lootQuality or 4
            BG.difficultyTable[FB] = difficultyTable or { "N", "H" }
            BG.phaseFBtable[FB] = phaseTable or { FB }
            BG.bossPositionTbl[instanceID] = bossPositionTbl or { 1, Maxb[FB] - 2 }

            BG.FBfromBossPosition[FB] = {}
            for i = 1, Maxb[FB] do
                BG.FBfromBossPosition[FB][i] = { name = FB, localName = GetRealZoneText(instanceID) }
            end
            BG.instanceIDfromBossPosition[FB] = {}
            for i = 1, Maxb[FB] - 2 do
                BG.instanceIDfromBossPosition[FB][i] = instanceID
            end
        end
        if BG.IsVanilla_Sod then
            BG.FB1 = "Temple"
            BG.fullLevel = 25
            BG.theEndBossID = { 2891, 2940, 2956, 672 }
            AddDB("BD", 48, "P1", 10, 3)
            AddDB("Gno", 90, "P2", 10, 3)
            AddDB("Temple", 109, "P3", 20, 3)
            AddDB("UBRS", 229, "P4", 10, 3, nil, { "UBRS", "MCsod" })
            AddDB("MCsod", 409, "P4", 20, nil, nil, { "UBRS", "MCsod" }, { 1, 11 })

            BG.FBIDtable[249] = "MCsod" -- 奥妮克希亚的巢穴
            BG.bossPositionTbl[249] = { 12, 12 }
            BG.FBfromBossPosition["MCsod"][12] = { name = "OLsod", localName = GetRealZoneText(249) }

            BG.FBIDtable[2791] = "MCsod" -- 风暴悬崖
            BG.bossPositionTbl[2791] = { 13, 13 }
            BG.FBfromBossPosition["MCsod"][13] = { name = "SC", localName = GetRealZoneText(2791) }

            BG.FBIDtable[2789] = "MCsod" -- 腐烂之痕
            BG.bossPositionTbl[2789] = { 14, 14 }
            BG.FBfromBossPosition["MCsod"][14] = { name = "TTS", localName = GetRealZoneText(2789) }
        elseif BG.IsVanilla_60 then
            BG.FB1 = "MC"
            BG.fullLevel = 60
            BG.theEndBossID = { 672, 1084, 617, 793, 723, 717, 1114 } --MC_SodOL BWL ZUG AQL TAQ NAXX
            AddDB("MC", 409, L["全阶段"], 40, nil, nil, { "MC", "BWL", "ZUG", "AQL", "TAQ", "NAXX" }, { 1, 10 })
            AddDB("BWL", 469, L["全阶段"], 40, nil, nil, { "MC", "BWL", "ZUG", "AQL", "TAQ", "NAXX" })
            AddDB("ZUG", 309, L["全阶段"], 20, 3, nil, { "MC", "BWL", "ZUG", "AQL", "TAQ", "NAXX" })
            AddDB("AQL", 509, L["全阶段"], 20, 3, nil, { "MC", "BWL", "ZUG", "AQL", "TAQ", "NAXX" })
            AddDB("TAQ", 531, L["全阶段"], 40, nil, nil, { "MC", "BWL", "ZUG", "AQL", "TAQ", "NAXX" })
            AddDB("NAXX", 533, L["全阶段"], 40, nil, nil, { "MC", "BWL", "ZUG", "AQL", "TAQ", "NAXX" })

            BG.FBIDtable[249] = "MC" -- 奥妮克希亚的巢穴
            BG.bossPositionTbl[249] = { 11, 11 }
            BG.FBfromBossPosition["MC"][11] = { name = "OL", localName = GetRealZoneText(249) }
        elseif BG.IsWLK then
            BG.FB1 = "NAXX"
            BG.fullLevel = 80
            BG.theEndBossID = { 1114, 757, 645, 856, }
            AddDB("NAXX", 533, "P1", nil, nil, { "H25", "H10", "N25", "N10" })
            AddDB("ULD", 603, "P2", nil, nil, { "H25", "H10", "N25", "N10" })
            AddDB("TOC", 649, "P3", nil, nil, { "H25", "H10", "N25", "N10" })
            AddDB("ICC", 631, "P4", nil, nil, { "H25", "H10", "N25", "N10" })

            BG.FBIDtable[615] = "NAXX" -- 黑曜石圣殿
            BG.bossPositionTbl[615] = { 16, 16 }
            BG.FBfromBossPosition["NAXX"][16] = { name = "OS", localName = GetRealZoneText(615) }
            BG.instanceIDfromBossPosition["NAXX"][16] = 615

            BG.FBIDtable[616] = "NAXX" -- 永恒之眼
            BG.bossPositionTbl[616] = { 17, 17 }
            BG.FBfromBossPosition["NAXX"][17] = { name = "EOE", localName = GetRealZoneText(616) }
            BG.instanceIDfromBossPosition["NAXX"][17] = 616

            BG.FBIDtable[249] = "TOC" -- 奥妮克希亚的巢穴
            BG.bossPositionTbl[249] = { 7, 7 }
            BG.FBfromBossPosition["TOC"][7] = { name = "OL", localName = GetRealZoneText(249) }
            BG.instanceIDfromBossPosition["TOC"][7] = 249

            BG.FBIDtable[724] = "ICC" -- 红玉圣殿
            BG.bossPositionTbl[724] = { 13, 13 }
            BG.FBfromBossPosition["ICC"][13] = { name = "RS", localName = GetRealZoneText(724) }
            BG.instanceIDfromBossPosition["ICC"][13] = 724
        elseif BG.IsCTM then
            BG.FB1 = "BOT"
            BG.fullLevel = 85
            BG.theEndBossID = { 1082, 1026, 1034, 1203, 1299, }
            AddDB("BOT", 671, "P1")   -- 暮光堡垒

            BG.FBIDtable[669] = "BOT" -- 黑翼血环
            BG.bossPositionTbl[669] = { 6, 11 }
            for i = 6, 11 do
                BG.FBfromBossPosition["BOT"][i] = { name = "BWD", localName = GetRealZoneText(669) }
            end

            BG.FBIDtable[754] = "BOT" -- 风神王座
            BG.bossPositionTbl[754] = { 12, 13 }
            BG.FBfromBossPosition["BOT"][12] = { name = "TOF", localName = GetRealZoneText(754) }
            BG.FBfromBossPosition["BOT"][13] = { name = "TOF", localName = GetRealZoneText(754) }

            -- AddDB("FL", 720, "P2") -- 火焰之地
            -- AddDB("DS", 967, "P3") -- 巨龙之魂
        end
    end

    local HopeMaxi
    if BG.IsVanilla then
        HopeMaxi = 5
    else
        HopeMaxi = 3
    end
    do
        ns.Width      = Width
        ns.Height     = Height
        ns.Maxt       = Maxt
        ns.Maxb       = Maxb
        ns.Maxi       = Maxi
        ns.HopeMaxi   = HopeMaxi
        ns.HopeMaxb   = HopeMaxb
        ns.HopeMaxn   = HopeMaxn
        ns.BossNumtbl = BossNumtbl
    end


    BG.Movetable = {}
    BG.options = {}
    BG.itemCaches = {}
    BG.dropDown = LibBG:Create_UIDropDownMenu(nil, UIParent)

    BG.onEnterAlpha = 0.1
    BG.highLightAlpha = 0.2
    BG.scrollStep = 80

    BG.ver = ns.ver
    BG.instructionsText = ns.instructionsText
    BG.updateText = ns.updateText
    BG.BG = "|cff00BFFF<BiaoGe>|r "
    BG.rareIcon = "|A:nameplates-icon-elite-silver:0:0|a"

    local function UnitRealm(unit)
        local realm = select(2, UnitName(unit))
        if not realm then
            realm = GetRealmName()
        end
        return realm
    end
    local function UnitColor(unit)
        local _, class = UnitClass(unit)
        local r, g, b = 1, 1, 1
        if class then
            r, g, b = GetClassColor(class)
        end
        return { r, g, b }
    end
    BG.playerClass = {
        class = { func = UnitClass, select = 2 },               -- 职业
        guild = { func = GetGuildInfo, select = 1 },            -- 公会
        level = { func = UnitLevel, select = 1 },               -- 等级
        raceID = { func = UnitRace, select = 3 },               -- 种族ID
        guid = { func = UnitGUID, select = 1 },                 -- GUID
        factionGroup = { func = UnitFactionGroup, select = 1 }, -- 阵营
        realm = { func = UnitRealm, select = 1 },               -- 服务器
        color = { func = UnitColor, select = 1 },               -- 颜色
    }

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
                N = { Quest = {}, },
                H = { Quest = {}, },
                N10 = { Quest = {}, },
                N25 = { Quest = {}, },
                H10 = { Quest = {}, },
                H25 = { Quest = {}, },

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
                Currency = {},   -- 货币贷款（WLK）
                Faction = {},    -- 声望
                Pvp = {},        -- PVP
                Profession = {}, -- 专业制造
                Quest = {},      -- 任务

                Sod_Pvp = {},    -- 赛季服PVP活动
                Sod_Currency = {},

                ExchangeItems = {},
            }
        end
        BG.SpecialLoot = {}
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

        CreateMyFont("Gold", 13)
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

        BG.g2 = "40c040"
        function BG.STC_g2(text)
            if text then
                local t
                t = "|cff" .. "40c040" .. text .. "|r"
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

        local Interface = "Interface\\AddOns\\BiaoGe\\Media\\sound\\"
        local tbl = {
            "AI",
            "YingXue",
        }
        for i, name in ipairs(tbl) do
            BG["sound_paimai" .. name] = Interface .. name .. "\\拍卖啦.mp3"
            BG["sound_hope" .. name] = Interface .. name .. "\\心愿达成.mp3"
            BG["sound_qingkong" .. name] = Interface .. name .. "\\已清空表格.mp3"
            BG["sound_cehuiqingkong" .. name] = Interface .. name .. "\\已撤回清空.mp3"
            BG["sound_alchemyReady" .. name] = Interface .. name .. "\\炼金转化已就绪.mp3"
            BG["sound_tailorReady" .. name] = Interface .. name .. "\\裁缝洗布已就绪.mp3"
            BG["sound_leatherworkingReady" .. name] = Interface .. name .. "\\制皮筛盐已就绪.mp3"
            BG["sound_error" .. name] = Interface .. name .. "\\检测到配置文件错误，现已重置.mp3"
            BG["sound_pingjia" .. name] = Interface .. name .. "\\给个评价吧.mp3"
            BG["sound_biaogefull" .. name] = Interface .. name .. "\\表格满了.mp3"
            BG["sound_guoqi" .. name] = Interface .. name .. "\\装备快过期了.mp3"
        end
    end
end


-- 数据库（保存至本地）
local function DataBase()
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

        for index, FB in ipairs(BG.FBtable) do
            if not BiaoGe[FB] then
                BiaoGe[FB] = {}
            end
            BiaoGe[FB].tradeTbl = BiaoGe[FB].tradeTbl or {}
            for b = 1, 22 do
                if not BiaoGe[FB]["boss" .. b] then
                    BiaoGe[FB]["boss" .. b] = {}
                end
            end
        end

        if not BiaoGe.HistoryList then
            BiaoGe.HistoryList = {}
        end
        for index, FB in ipairs(BG.FBtable) do
            if not BiaoGe.HistoryList[FB] then
                BiaoGe.HistoryList[FB] = {}
            end
        end

        if not BiaoGe.History then
            BiaoGe.History = {}
        end
        for index, FB in ipairs(BG.FBtable) do
            if not BiaoGe.History[FB] then
                BiaoGe.History[FB] = {}
            end
        end

        if not BG.IsVanilla then
            if not BiaoGe.BossFrame then
                BiaoGe.BossFrame = {}
            end
            for index, FB in ipairs(BG.FBtable) do
                if not BiaoGe.BossFrame[FB] then
                    BiaoGe.BossFrame[FB] = {}
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
        -- 声音方案
        BiaoGe.options.Sound = BiaoGe.options.Sound or "YingXue"

        -- 高亮天赋装备
        if not BiaoGe.filterClassNum then
            BiaoGe.filterClassNum = {}
        end
        if not BiaoGe.filterClassNum[realmID] then
            BiaoGe.filterClassNum[realmID] = {}
        end
        if not BiaoGe.filterClassNum[realmID][player] then
            BiaoGe.filterClassNum[realmID][player] = 0
        end
        if BiaoGeA and BiaoGeA.filterClassNum then
            BiaoGe.filterClassNum[realmID][player] = BiaoGeA.filterClassNum
            BiaoGeA.filterClassNum = nil
        end

        -- 心愿清单
        if not BiaoGe.Hope then
            BiaoGe.Hope = {}
        end

        if not BiaoGe.Hope[realmID] then
            BiaoGe.Hope[realmID] = {}
        end
        if not BiaoGe.Hope[realmID][player] then
            BiaoGe.Hope[realmID][player] = {}
        end
        for index, FB in ipairs(BG.FBtable) do
            if not BiaoGe.Hope[realmID][player][FB] then
                BiaoGe.Hope[realmID][player][FB] = {}
            end
            for n = 1, 4 do
                if not BiaoGe.Hope[realmID][player][FB]["nandu" .. n] then
                    BiaoGe.Hope[realmID][player][FB]["nandu" .. n] = {}
                    for b = 1, 22 do
                        if not BiaoGe.Hope[realmID][player][FB]["nandu" .. n]["boss" .. b] then
                            BiaoGe.Hope[realmID][player][FB]["nandu" .. n]["boss" .. b] = {}
                        end
                    end
                end
            end
        end
        if BiaoGeA and BiaoGeA.Hope then
            for k, v in pairs(BiaoGeA.Hope) do
                BiaoGe.Hope[realmID][player][k] = v
            end
            BiaoGeA.Hope = nil
        end

        -- 记录服务器名称
        do
            BiaoGe.realmName = BiaoGe.realmName or {}
            BiaoGe.realmName[realmID] = GetRealmName()
        end
        -- 记录每个角色的职业和等级
        do
            BiaoGe.playerInfo = BiaoGe.playerInfo or {}
            BiaoGe.playerInfo[realmID] = BiaoGe.playerInfo[realmID] or {}
            BiaoGe.playerInfo[realmID][player] = BiaoGe.playerInfo[realmID][player] or {}
            BiaoGe.playerInfo[realmID][player].class = select(2, UnitClass("player"))
            BiaoGe.playerInfo[realmID][player].level = UnitLevel("player")

            BG.RegisterEvent("PLAYER_LEVEL_UP", function(self, even, level)
                BiaoGe.playerInfo[realmID][player].level = level
            end)
        end
    end
end


local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == AddonName then
        DataBase()
    end
end)
