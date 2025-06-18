local AddonName, ns = ...

local L = ns.L
local RGB = ns.RGB

local pt = print

local LibBG = LibStub:GetLibrary("LibUIDropDownMenu-4.0") -- 调用库菜单UI
ns.LibBG = LibBG

C_ChatInfo.RegisterAddonMessagePrefix("BiaoGe") -- 注册插件通信频道
C_ChatInfo.RegisterAddonMessagePrefix("BiaoGeYY")
C_ChatInfo.RegisterAddonMessagePrefix("BiaoGeVIP")

BiaoGeTooltip = CreateFrame("GameTooltip", "BiaoGeTooltip", UIParent, "GameTooltipTemplate")   -- 用于装备过滤功能
BiaoGeTooltip2 = CreateFrame("GameTooltip", "BiaoGeTooltip2", UIParent, "GameTooltipTemplate") -- 用于装备库
BiaoGeTooltip2:SetClampedToScreen(false)
BiaoGeTooltip3 = CreateFrame("GameTooltip", "BiaoGeTooltip3", UIParent, "GameTooltipTemplate") -- 用于装备过期提醒

-- 游戏按键设置
BINDING_HEADER_BIAOGE = "BiaoGe"
BINDING_NAME_BIAOGE = L["打开/关闭表格"]
BINDING_NAME_RoleOverview = L["打开/关闭角色总览"]


local realmID = GetRealmID()
local player = BG.playerName
local realmName = GetRealmName()
local GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded

-- 全局变量
do
    BG.FBtable = {}
    BG.FBtable2 = {}
    BG.FBIDtable = {}
    BG.lootQuality = {}
    BG.difficultyTable = {}
    BG.diffIDTbl = {}
    BG.phaseFBtable = {}
    BG.bossPositionStartEnd = {}
    BG.FBfromBossPosition = {}
    BG.instanceIDfromBossPosition = {}
    BG.Movetable = {}
    BG.options = {}
    BG.itemCaches = {}
    BG.dropDown = LibBG:Create_UIDropDownMenu(nil, UIParent)
    BG.onEnterAlpha = 0.1
    BG.highLightAlpha = 0.2
    BG.otherEditAlpha = 0.3
    BG.scrollStep = 80
    BG.borderAlpha = .5
    BG.ver = "v" .. GetAddOnMetadata(AddonName, "Version")
    BG.BG = "|cff00BFFF<BiaoGe>|r "
    BG.rareIcon = "|A:nameplates-icon-elite-silver:0:0|a"
    BG.iconTexCoord = { .06, .94, .06, .94 }
    BG.zaxiang = {} -- 杂项如果太多，则需要换列
    if BG.IsRetail then
        BG.CloseButtonOffset = 0
    else
        BG.CloseButtonOffset = 2
    end

    BG.blackListPlayer = {}
    if BG.IsWLK then
        BG.blackListPlayer = {
            ["匕首岭"] = {
                ["曰日曰日曰"] = true,
                ["锁血"] = true,
                ["艾弗森灬"] = true,
                ["亏贼"] = true,
                ["西施"] = true,
                ["大頭爆栗子"] = true,
                ["你先动筷子"] = true,
                ["抽象怪"] = true,
                ["九折"] = true,
                ["Bluebiu"] = true,
                ["搞子"] = true,
                -- [""] = true,
                -- [""] = true,
                -- [""] = true,
                -- [""] = true,
                -- [""] = true,
                -- ["苍刃"] = true,
            },
        }
    end

    if BG.blackListPlayer[realmName] and BG.blackListPlayer[realmName][BG.GN()] then
        BG.IsBlackListPlayer = true
    end
end
-- 初始化
do
    BG.Maxi                                    = 40
    BG.FBWidth                                 = {}
    BG.FBHeight                                = {}
    BG.BossNumtbl                              = {}
    local mainFrameWidth                       = 1295
    local Maxt, Maxb, Maxi, HopeMaxb, HopeMaxn = {}, {}, {}, {}, {}
    do
        local function AddDB(FB, width, height, maxt, maxb, bossNumTbl, diffTbl, diffIDTbl, maxiTbl, zaxiangI)
            BG.FBWidth[FB] = width
            BG.FBHeight[FB] = height
            Maxt[FB] = maxt
            Maxb[FB] = maxb
            BG.BossNumtbl[FB] = bossNumTbl
            HopeMaxb[FB] = maxb - 1
            BG.difficultyTable[FB] = diffTbl or { "N" }
            HopeMaxn[FB] = #BG.difficultyTable[FB]
            BG.diffIDTbl[FB] = diffIDTbl or {
                [3] = "N",
                [175] = "N",
                [4] = "N",
                [176] = "N",
                [5] = "H",
                [193] = "H",
                [6] = "H",
                [194] = "H",
                [14] = "N",
                [15] = "H",
                [16] = "M",
            }
            Maxi[FB] = maxiTbl
            -- 设置支出格子为x个
            if FB == "ULD" or FB == "ICC" then
                tinsert(Maxi[FB], 5)
            elseif FB == "MC" then
                tinsert(Maxi[FB], 6)
            else
                tinsert(Maxi[FB], 8)
            end
            -- 设置总览工资格子为x个
            tinsert(Maxi[FB], 5)
            if zaxiangI then
                BG.zaxiang[FB] = { i = zaxiangI }
            end
        end

        if BG.IsVanilla_Sod then
            AddDB("BD", mainFrameWidth, 810, 3, 9, { 0, 5, 9 }, nil, nil,
                { 5, 5, 5, 5, 5, 5, 5, 5, 10, })
            AddDB("Gno", mainFrameWidth, 810, 3, 8, { 0, 5, 8 }, nil, nil,
                { 5, 5, 5, 5, 5, 10, 8, 8, })
            AddDB("Temple", mainFrameWidth, 885, 3, 10, { 0, 6, 9, }, nil, nil,
                { 5, 5, 5, 4, 4, 4, 4, 6, 25, 9, }, 20)
            AddDB("MCsod", mainFrameWidth, 940, 3, 13, { 0, 6, 11 }, nil, nil,
                { 5, 5, 5, 5, 5, 5, 5, 5, 6, 8, 6, 11, 6, })
            AddDB("ZUGsod", mainFrameWidth, 810, 3, 12, { 0, 6, 11 }, nil, nil,
                { 4, 4, 4, 4, 4, 4, 4, 4, 4, 9, 10, 6, }, 5)
            AddDB("BWLsod", mainFrameWidth, 810, 3, 9, { 0, 5, 7 }, nil, nil,
                { 4, 4, 4, 4, 8, 5, 21, 7, 5, })
            AddDB("Worldsod", mainFrameWidth, 810, 3, 10, { 0, 4, 9 }, nil, nil,
                { 10, 5, 5, 5, 5, 5, 5, 5, 4, 5 })
        elseif BG.IsVanilla_60 then
            AddDB("MC", mainFrameWidth, 810, 3, 13, { 0, 7, 12 }, nil, nil,
                { 3, 3, 3, 4, 3, 3, 4, 3, 4, 5, 8, 15, 4, }, 6)
            AddDB("BWL", mainFrameWidth, 810, 3, 10, { 0, 5, 9 }, nil, nil,
                { 5, 5, 5, 5, 5, 5, 5, 6, 9, 12, })
            AddDB("ZUG", mainFrameWidth, 810, 3, 12, { 0, 6, 11 }, nil, nil,
                { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 9, 10, })
            AddDB("AQL", mainFrameWidth, 810, 3, 8, { 0, 5, 7 }, nil, nil,
                { 5, 5, 5, 5, 5, 5, 28, 5, }, 23)
            AddDB("TAQ", mainFrameWidth, 810, 3, 11, { 0, 6, 10 }, nil, nil,
                { 4, 4, 4, 4, 4, 4, 4, 4, 5, 20, 5, }, 14)
            AddDB("NAXX", 1715, 810, 4, 17, { 0, 6, 12, 16 }, nil, nil,
                { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 12, 12, })
        elseif BG.IsWLK then
            local difTbl1 = {
                [3] = "N10",
                [175] = "N10",
                [4] = "N25",
                [176] = "N25",
                [5] = "N10",
                [193] = "N10",
                [6] = "N25",
                [194] = "N25",
            }
            local difTbl2 = {
                [3] = "N10",
                [175] = "N10",
                [4] = "N25",
                [176] = "N25",
                [5] = "H10",
                [193] = "H10",
                [6] = "H25",
                [194] = "H25",
            }
            local difTbl3 = {
                [3] = "N",
                [175] = "N",
                [4] = "N",
                [176] = "N",
                [5] = "N",
                [193] = "N",
                [6] = "N",
                [194] = "N",
            }
            AddDB("ICC", mainFrameWidth, 875, 3, 15, { 0, 7, 13 }, { "N10", "N25", "H10", "H25", }, difTbl2,
                { 3, 3, 3, 5, 3, 3, 5, 3, 5, 3, 5, 8, 3, 12, 6, })
            AddDB("TOC", mainFrameWidth, 835, 3, 9, { 0, 5, 8 }, { "N10", "N25", "H10", "H25", }, difTbl2,
                { 5, 5, 5, 5, 5, 3, 8, 22, 5, }, 16)
            AddDB("ULD", mainFrameWidth, 875, 3, 16, { 0, 7, 13 }, { "N10", "N25" }, difTbl1,
                { 4, 3, 3, 4, 5, 3, 3, 4, 4, 4, 4, 4, 6, 4, 8, 5, })
            AddDB("NAXX", 1715, 945, 4, 19, { 0, 6, 12, 16 }, { "N10", "N25" }, difTbl1,
                { 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 14, 6, 6, 5, })
            -- TBC
            AddDB("SW", mainFrameWidth, 835, 3, 8, { 0, 5, 8 }, nil, difTbl3,
                { 5, 5, 5, 6, 5, 6, 10, 11, })
            AddDB("BT", mainFrameWidth, 835, 3, 11, { 0, 5, 9 }, nil, difTbl3,
                { 5, 5, 5, 5, 5, 5, 5, 5, 10, 8, 5, })
            AddDB("HS", mainFrameWidth, 835, 2, 7, { 0, 5, }, nil, difTbl3,
                { 5, 5, 5, 5, 5, 7, 5 })
            AddDB("SSC", mainFrameWidth, 835, 3, 12, { 0, 6, 10 }, nil, difTbl3,
                { 4, 4, 4, 4, 4, 5, 5, 5, 5, 10, 8, 5, })
            AddDB("BWL", mainFrameWidth, 810, 3, 10, { 0, 5, 9 }, nil, difTbl3,
                { 5, 5, 5, 5, 5, 5, 5, 6, 9, 12, })
            AddDB("TAQ", mainFrameWidth, 810, 3, 11, { 0, 6, 10 }, nil, difTbl3,
                { 4, 4, 4, 4, 4, 4, 4, 4, 5, 20, 5, }, 14)
        elseif BG.IsCTM then
            AddDB("BOT", 1715, 930, 4, 15, { 0, 5, 10, 14 }, { "N", "H" }, nil,
                { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 8, 24, 4, }, 12)
            AddDB("FL", mainFrameWidth, 770, 3, 9, { 0, 4, 8 }, { "N", "H" }, nil,
                { 6, 6, 6, 6, 6, 6, 6, 6, 10, })
            AddDB("DS", mainFrameWidth, 770, 3, 10, { 0, 4, 8 }, { "N", "H" }, nil,
                { 6, 6, 6, 6, 6, 6, 6, 6, 6, 4, })
        elseif BG.IsRetail then
            local n = 8
            AddDB("NP", mainFrameWidth, 950, 3, 10, { 0, 4, 8 }, { "R", "N", "H", "M" }, nil,
                { n, n, n, n, n, n, n, n, 5, 5, }, 12)
        end
    end

    do
        local function AddDB(FB, instanceID, phase, maxplayers, lootQuality,
                             phaseTable, bossPositionTbl, shortName)
            tinsert(BG.FBtable, FB)
            tinsert(BG.FBtable2,
                {
                    FB = FB,
                    ID = instanceID,
                    localName = GetRealZoneText(instanceID),
                    phase = phase,
                    maxplayers = maxplayers,
                    shortName = shortName,
                })
            BG.FBIDtable[instanceID] = FB
            BG.lootQuality[FB] = lootQuality or 4
            BG.phaseFBtable[FB] = phaseTable or { FB }
            BG.bossPositionStartEnd[instanceID] = bossPositionTbl or { 1, Maxb[FB] - 2 }
            BG.FBfromBossPosition[FB] = {}
            for i = 1, Maxb[FB] do
                BG.FBfromBossPosition[FB][i] = { name = FB, localName = GetRealZoneText(instanceID) }
            end
            BG.instanceIDfromBossPosition[FB] = {}
            for i = 1, Maxb[FB] - 2 do
                BG.instanceIDfromBossPosition[FB][i] = instanceID
            end
        end
        local function AddOneBoss(FB, instanceID, bossNum, name)
            BG.FBIDtable[instanceID] = FB
            BG.bossPositionStartEnd[instanceID] = { bossNum, bossNum }
            BG.FBfromBossPosition[FB][bossNum] = { name = name, localName = GetRealZoneText(instanceID) }
            BG.instanceIDfromBossPosition[FB][bossNum] = instanceID
        end

        if BG.IsVanilla_Sod then
            BG.FB1 = "MCsod"
            BG.fullLevel = 25
            BG.theEndBossID = { 672, 617, } -- MC BWL
            AddDB("BD", 48, "P1", 10, 3)
            AddDB("Gno", 90, "P2", 10, 3)
            AddDB("Temple", 109, "P3", 20, 3)
            AddDB("MCsod", 409, "P4", 20)
            AddDB("ZUGsod", 309, "P5", 10, 3)
            AddDB("BWLsod", 469, "P5", 20)
            AddDB("Worldsod", 249, "", 20, nil, nil, nil, { 1, 1 })
            BG.FBtable2[#BG.FBtable2].localName = L["世界Boss"]

            -- 风暴悬崖
            AddOneBoss("Worldsod", 2791, 2, "SC")
            -- 腐烂之痕
            AddOneBoss("Worldsod", 2789, 3, "TTS")
            -- 水晶谷
            AddOneBoss("Worldsod", 2804, 4, "TCV")
        elseif BG.IsVanilla_60 then
            BG.FB1 = "MC"
            BG.fullLevel = 60
            BG.theEndBossID = { 672, 617, 793, 723, 717, 1114 } --MC BWL ZUG AQL TAQ NAXX
            AddDB("MC", 409, "P1-P2", 40, nil, nil, { 1, 10 })
            AddDB("BWL", 469, "P3", 40)
            AddDB("ZUG", 309, "P4", 20, 3)
            AddDB("AQL", 509, "P5", 20, 3)
            AddDB("TAQ", 531, "P5", 40)
            AddDB("NAXX", 533, "P6", 40)

            BG.FBIDtable[249] = "MC" -- 奥妮克希亚的巢穴
            BG.bossPositionStartEnd[249] = { 11, 11 }
            BG.FBfromBossPosition["MC"][11] = { name = "OL", localName = GetRealZoneText(249) }
            BG.instanceIDfromBossPosition["MC"][11] = 249
        elseif BG.IsWLK then
            BG.FB1 = "NAXX"
            BG.fullLevel = 80
            BG.theEndBossID = { 1114, 756, 645, 856, }

            AddDB("NAXX", 533, "P1", nil, nil, nil, { 1, 15 })
            AddDB("ULD", 603, "P2")
            AddDB("TOC", 649, "P3", nil, nil, nil, { 1, 6 })
            AddDB("ICC", 631, "P4", nil, nil, nil, { 1, 12 })

            BG.FBIDtable[615] = "NAXX" -- 黑曜石圣殿
            BG.bossPositionStartEnd[615] = { 16, 16 }
            BG.FBfromBossPosition["NAXX"][16] = { name = "OS", localName = GetRealZoneText(615) }
            BG.instanceIDfromBossPosition["NAXX"][16] = 615

            BG.FBIDtable[616] = "NAXX" -- 永恒之眼
            BG.bossPositionStartEnd[616] = { 17, 17 }
            BG.FBfromBossPosition["NAXX"][17] = { name = "EOE", localName = GetRealZoneText(616) }
            BG.instanceIDfromBossPosition["NAXX"][17] = 616

            BG.FBIDtable[249] = "TOC" -- 奥妮克希亚的巢穴
            BG.bossPositionStartEnd[249] = { 7, 7 }
            BG.FBfromBossPosition["TOC"][7] = { name = "OL", localName = GetRealZoneText(249) }
            BG.instanceIDfromBossPosition["TOC"][7] = 249

            BG.FBIDtable[724] = "ICC" -- 红玉圣殿
            BG.bossPositionStartEnd[724] = { 13, 13 }
            BG.FBfromBossPosition["ICC"][13] = { name = "RS", localName = GetRealZoneText(724) }
            BG.instanceIDfromBossPosition["ICC"][13] = 724

            -- TBC
            do
                AddDB("TAQ", 531, "", nil, nil, nil, nil, L["安其拉"])
                AddDB("BWL", 469, "", nil, nil, nil, nil, L["黑翼"])
                AddDB("SSC", 548, "", nil, nil, nil, nil, L["毒蛇风暴"])
                AddDB("HS", 534, "", nil, nil, nil, nil, L["海加尔山"])
                AddDB("BT", 564, "", nil, nil, nil, nil, L["黑暗神殿"])
                AddDB("SW", 580, "", nil, nil, nil, nil, L["太阳井"])

                BG.FBIDtable[550] = "SSC" -- 风暴要塞
                BG.bossPositionStartEnd[550] = { 7, 10 }
                for i = 7, 10 do
                    BG.FBfromBossPosition["SSC"][i] = { name = "TK", localName = GetRealZoneText(550) }
                    BG.instanceIDfromBossPosition["SSC"][i] = 550
                end
            end
        elseif BG.IsCTM then
            BG.FB1 = "BOT"
            BG.fullLevel = 85
            BG.theEndBossID = { 1082, 1026, 1034, 1203, 1299, } -- BOT BWD TOF FL DS
            AddDB("BOT", 671, "P1", nil, nil, nil, { 1, 5 })    -- 暮光堡垒
            BG.FBIDtable[669] = "BOT"                           -- 黑翼血环
            BG.bossPositionStartEnd[669] = { 6, 11 }
            for i = 6, 11 do
                BG.FBfromBossPosition["BOT"][i] = { name = "BWD", localName = GetRealZoneText(669) }
                BG.instanceIDfromBossPosition["BOT"][i] = 669
            end
            BG.FBIDtable[754] = "BOT" -- 风神王座
            BG.bossPositionStartEnd[754] = { 12, 13 }
            for i = 12, 13 do
                BG.FBfromBossPosition["BOT"][i] = { name = "TOF", localName = GetRealZoneText(754) }
                BG.instanceIDfromBossPosition["BOT"][i] = 754
            end

            AddDB("FL", 720, "P2") -- 火焰之地
            AddDB("DS", 967, "P3") -- 巨龙之魂
        elseif BG.IsRetail then
            BG.FB1 = "NP"
            BG.fullLevel = 80
            BG.theEndBossID = { 2922, }
            AddDB("NP", 2657, "P1", 20)
        end
    end

    local HopeMaxi
    if BG.IsVanilla then
        HopeMaxi = 5
    else
        HopeMaxi = 3
    end
    do
        ns.Maxt     = Maxt
        ns.Maxb     = Maxb
        ns.Maxi     = Maxi
        ns.HopeMaxi = HopeMaxi
        ns.HopeMaxb = HopeMaxb
        ns.HopeMaxn = HopeMaxn
        BG.Maxb     = Maxb

        function BG.GetMaxi(FB, b, isScrollFrame)
            if not b then return BG.Maxi end
            FB = FB or BG.FB1
            if not isScrollFrame then
                if b == Maxb[FB] then
                    return BG.Maxi
                elseif b == Maxb[FB] + 1 then
                    return 20
                elseif b == Maxb[FB] + 2 then
                    return 5
                end
            end
            return Maxi[FB][b] or 0
        end
    end

    local function UnitRealm(unit)
        local realm = select(2, UnitName(unit))
        if not realm or realm == "" then
            realm = realmName
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
        for _, FB in ipairs(BG.FBtable) do
            BG.HopeFrame[FB] = {}
            for n = 1, HopeMaxn[FB] do
                BG.HopeFrame[FB]["nandu" .. n] = {}
                for b = 1, 22 do
                    BG.HopeFrame[FB]["nandu" .. n]["boss" .. b] = {}
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
        for _, FB in pairs(BG.FBtable) do
            BG.Loot[FB] = {
                N = { Quest = {}, },
                H = { Quest = {}, },
                M = { Quest = {}, },

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
                EVOKER = {},
                DEMONHUNTER = {},
                MONK = {},

                Team = {},         -- 5人本
                World = {},        -- 世界掉落
                WorldBoss = {},    -- 世界boss
                Currency = {},     -- 货币贷款（WLK）
                Faction = {},      -- 声望
                PVP = {},          -- PVP
                PVP_currency = {}, -- PVP货币
                Profession = {},   -- 专业制造
                Quest = {},        -- 任务

                Sod_PVP = {},      -- 赛季服PVP活动
                Sod_Currency = {},

                ExchangeItems = {},
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
            elseif color == "Green2" then
                cff = "40c040"
            elseif color == "Red" then
                cff = "FF0000"
            elseif color == "Fen" then
                cff = "FF69B4"
            elseif color == "Gold" then
                cff = "FFD100"
            elseif color == "Yellow" then
                cff = "FFFF00"
            elseif color == "White" then
                cff = "FFFFFF"
            elseif color == "Dis" then
                cff = "808080"
            end
            BG["Font" .. color .. size] = CreateFont("BG.Font" .. color .. size)
            BG["Font" .. color .. size]:SetTextColor(RGB(cff))
            BG["Font" .. color .. size]:SetFont(STANDARD_TEXT_FONT, size, "OUTLINE")
        end

        CreateMyFont("Blue", 13)
        CreateMyFont("Blue", 15)

        CreateMyFont("Green", 13)
        CreateMyFont("Green", 15)
        CreateMyFont("Green", 25)

        CreateMyFont("Green2", 15)

        CreateMyFont("Gold", 13)
        CreateMyFont("Gold", 15)

        CreateMyFont("Yellow", 13)
        CreateMyFont("Yellow", 15)

        CreateMyFont("Red", 13)
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
        BG.sound3 = SOUNDKIT.IG_MAINMENU_CLOSE  -- 菜单打开音效

        local Interface = "Interface\\AddOns\\BiaoGe\\Media\\sound\\"
        BG.soundAuthor = {
            { ID = "AI", addonName = AddonName, isBiaoGe = true },
        }
        BG.soundTbl = BG.soundAuthor
        BG.soundTbl2 = {
            { ID = "paimai", name = "拍卖啦" },
            { ID = "hope", name = "心愿达成" },
            { ID = "qingkong", name = "已清空表格" },
            { ID = "cehuiqingkong", name = "已撤回清空" },
            { ID = "alchemyReady", name = "炼金转化已就绪" },
            { ID = "tailorReady", name = "裁缝洗布已就绪" },
            { ID = "leatherworkingReady", name = "制皮筛盐已就绪" },
            { ID = "pingjia", name = "给个评价吧" },
            { ID = "biaogefull", name = "表格满了" },
            { ID = "guoqi", name = "装备快过期了" },
            { ID = "uploading", name = "账单正在上传" },
            { ID = "uploaded", name = "账单上传成功" },
            { ID = "countDownStop", name = "倒数暂停" },
            { ID = "HusbandComeOn", name = "老公加油" },
            { ID = "qiankuan", name = "你有未收欠款" },
            { ID = "autoAuctionAutoEndTips", name = "自动出价结束" },
            { ID = "tradeSuccess", name = "交易成功" },
            { ID = "tradeFalse", name = "交易失败" },
        }

        local function DefaultSound()
            for i = 1, C_AddOns.GetNumAddOns() do
                local addonName = C_AddOns.GetAddOnInfo(i)
                local enabled = C_AddOns.GetAddOnEnableState(i, player)
                if C_AddOns.GetAddOnMetadata(i, "X-BiaoGe-Voice") and enabled ~= 0 then
                    local author = C_AddOns.GetAddOnMetadata(i, "Author")
                    tinsert(BG.soundAuthor, { ID = author,  addonName = addonName })
                end
            end
            for _, value in ipairs(BG.soundAuthor) do
                local author = value.ID
                local addonName = value.addonName
                local isBiaoGe = value.isBiaoGe
                for _, v in ipairs(BG.soundTbl2) do
                    local soundID = v.ID
                    local soundName = v.name
                    if isBiaoGe then
                        BG["sound_" .. soundID .. author] = Interface .. author .. "\\" .. soundName
                    else
                        BG["sound_" .. soundID .. author] = format("Interface\\AddOns\\%s\\sound\\%s", addonName, soundName)
                    end
                end
            end

            local yes
            for i, v in ipairs(BG.soundAuthor) do
                if BiaoGe.options.Sound == v.ID then
                    yes = true
                end
            end
            if not yes then
                BiaoGe.options.Sound = "AI"
            end
        end

        BG.Init2(function()
            DefaultSound()
        end)
    end

    hooksecurefunc(LibBG, "ToggleDropDownMenu", function(_, _, _, dropDown)
        for i = 1, L_UIDROPDOWNMENU_MAXBUTTONS do
            local button = _G["L_DropDownList1Button" .. i]
            if button.line then button.line:Hide() end
            if button.value == "   " then
                if not button.line then
                    local line = button:CreateTexture(nil, 'BACKGROUND')
                    line:SetTexture([[Interface\Common\UI-TooltipDivider-Transparent]])
                    line:SetHeight(8)
                    line:SetPoint('LEFT')
                    line:SetPoint('RIGHT', -5, 0)
                    line:Hide()
                    button.line = line
                end
                button.line:Show()
            end
        end
    end)
end


-- 本地配置数据库
BG.Init(function()
    if BiaoGe then
        if type(BiaoGe) ~= "table" then
            BiaoGe = {}
        end
    else
        BiaoGe = {}
    end

    -- 副本选择初始化
    -- FB1 是UI当前选择的副本
    -- FB2 是玩家当前所处的副本
    if BiaoGe.FB then
        local yes
        for k, FB in pairs(BG.FBtable) do
            if BiaoGe.FB == FB then
                BG.FB1 = BiaoGe.FB
                yes = true
                break
            end
        end
        if not yes then
            BiaoGe.FB = BG.FB1
        end
    else
        BiaoGe.FB = BG.FB1
    end

    if not BiaoGe.point then
        BiaoGe.point = {}
    end
    if not BiaoGe.duizhang then
        BiaoGe.duizhang = {}
    end

    for _, FB in ipairs(BG.FBtable) do
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
    for _, FB in ipairs(BG.FBtable) do
        if not BiaoGe.HistoryList[FB] then
            BiaoGe.HistoryList[FB] = {}
        end
    end

    if not BiaoGe.History then
        BiaoGe.History = {}
    end
    for _, FB in ipairs(BG.FBtable) do
        if not BiaoGe.History[FB] then
            BiaoGe.History[FB] = {}
        end
    end

    if not BG.IsVanilla then
        if not BiaoGe.BossFrame then
            BiaoGe.BossFrame = {}
        end
        for _, FB in ipairs(BG.FBtable) do
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
    BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]

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
        BiaoGe.realmName[realmID] = realmName
    end
    -- 记录每个角色的职业、等级、天赋
    do
        BiaoGe.playerInfo = BiaoGe.playerInfo or {}
        BiaoGe.playerInfo[realmID] = BiaoGe.playerInfo[realmID] or {}
        BiaoGe.playerInfo[realmID][player] = BiaoGe.playerInfo[realmID][player] or {}
        BiaoGe.playerInfo[realmID][player].class = select(2, UnitClass("player"))
        BiaoGe.playerInfo[realmID][player].raceID = select(3, UnitRace("player"))
        BiaoGe.playerInfo[realmID][player].level = UnitLevel("player")
        BiaoGe.playerInfo[realmID][player].iLevel = select(2, GetAverageItemLevel()) or 0

        BG.RegisterEvent("PLAYER_LEVEL_UP", function(self, event, level)
            BiaoGe.playerInfo[realmID][player].level = level
        end)

        -- 天赋
        if not BG.IsRetail then
            local function GetTalent()
                local maxNum = 0
                local ii
                for i = 1, 3 do
                    local num = select(5, GetTalentTabInfo(i, nil, nil, GetActiveTalentGroup()))
                    if num and num >= maxNum then
                        maxNum = num
                        ii = i
                    end
                end
                if maxNum == 0 then ii = nil end
                BiaoGe.playerInfo[realmID][player].talent = ii
            end
            BG.RegisterEvent("PLAYER_TALENT_UPDATE", GetTalent)
            BG.Init2(GetTalent)

            function BG.GetTalentIcon(class, talent, w)
                w = w or 0
                if talent then
                    local a, b, c, d = unpack(BG.iconTexCoord)
                    local coord = format("100:100:%s:%s:%s:%s", a * 100, b * 100, c * 100, d * 100)
                    return format("|T%s:%s:%s:0:0:%s|t", BG.talentIcon[class][talent], w, w, coord)
                end
                return format("|A:classicon-%s:%s:%s|a", class, w, w)
            end

            BG.talentIcon = {
                DEATHKNIGHT = {
                    "Interface\\Icons\\Spell_Deathknight_BloodPresence", -- T
                    "Interface\\Icons\\Spell_Deathknight_FrostPresence",
                    "Interface\\Icons\\Spell_Deathknight_UnholyPresence",
                },
                PALADIN = {
                    "Interface\\Icons\\Spell_Holy_HolyBolt",     -- N
                    "Interface\\Icons\\Spell_Holy_DevotionAura", -- T
                    "Interface\\Icons\\Spell_Holy_AuraOfLight",
                },
                WARRIOR = {
                    "Interface\\Icons\\ability_rogue_eviscerate",
                    "Interface\\Icons\\ability_warrior_innerrage",
                    "Interface\\Icons\\ability_warrior_defensivestance", -- T
                },
                SHAMAN = {
                    "Interface\\Icons\\spell_nature_lightning",
                    "Interface\\Icons\\spell_nature_lightningshield",
                    "Interface\\Icons\\Spell_Nature_HealingWaveGreater", -- N
                },
                HUNTER = {
                    "Interface\\Icons\\Ability_Hunter_BeastTaming",
                    "Interface\\Icons\\Ability_Marksmanship",
                    "Interface\\Icons\\Ability_Hunter_SwiftStrike",
                },
                DRUID = {
                    "Interface\\Icons\\spell_nature_starfall",
                    "Interface\\Icons\\ability_racial_bearform",
                    "Interface\\Icons\\Spell_Nature_HealingTouch", -- N
                },
                ROGUE = {
                    "Interface\\Icons\\ability_rogue_eviscerate",
                    "Interface\\Icons\\ability_backstab",
                    "Interface\\Icons\\Ability_Ambush",
                },
                MAGE = {
                    "Interface\\Icons\\inv_misc_rune_03",
                    "Interface\\Icons\\spell_fire_firebolt02",
                    "Interface\\Icons\\spell_frost_frostbolt02",
                },
                WARLOCK = {
                    "Interface\\Icons\\spell_shadow_deathcoil",
                    "Interface\\Icons\\spell_shadow_metamorphosis",
                    "Interface\\Icons\\spell_shadow_rainoffire",
                },
                PRIEST = {
                    "Interface\\Icons\\spell_holy_wordfortitude", -- N
                    "Interface\\Icons\\spell_holy_holybolt",      -- N
                    "Interface\\Icons\\spell_shadow_shadowwordpain",
                },
            }
        end

        if BiaoGe.PlayerItemsLevel then
            for realmID in pairs(BiaoGe.PlayerItemsLevel) do
                if type(realmID) == "number" and BiaoGe.playerInfo[realmID] then
                    for player, iLevel in pairs(BiaoGe.PlayerItemsLevel[realmID]) do
                        if type(iLevel) == "number" and BiaoGe.playerInfo[realmID][player] then
                            BiaoGe.playerInfo[realmID][player].iLevel = iLevel
                        end
                    end
                end
            end
            BiaoGe.PlayerItemsLevel = nil
        end
    end

    -- 修正数据
    do
        if BG.IsVanilla_Sod then
            local FB = "MCsod"
            if BiaoGe[FB].boss18.zhuangbei1 then
                BiaoGe[FB].boss12 = BG.Copy(BiaoGe[FB].boss15)
                BiaoGe[FB].boss13 = BG.Copy(BiaoGe[FB].boss16)
                BiaoGe[FB].boss14 = BG.Copy(BiaoGe[FB].boss17)
                BiaoGe[FB].boss15 = BG.Copy(BiaoGe[FB].boss18)
                BiaoGe[FB].boss16 = {}
                BiaoGe[FB].boss17 = {}
                BiaoGe[FB].boss18 = {}

                for DT, v in pairs(BiaoGe.History[FB]) do
                    if BiaoGe.History[FB][DT].boss18.zhuangbei1 then
                        BiaoGe.History[FB][DT].boss12 = BG.Copy(BiaoGe.History[FB][DT].boss15)
                        BiaoGe.History[FB][DT].boss13 = BG.Copy(BiaoGe.History[FB][DT].boss16)
                        BiaoGe.History[FB][DT].boss14 = BG.Copy(BiaoGe.History[FB][DT].boss17)
                        BiaoGe.History[FB][DT].boss15 = BG.Copy(BiaoGe.History[FB][DT].boss18)
                        BiaoGe.History[FB][DT].boss16 = {}
                        BiaoGe.History[FB][DT].boss17 = {}
                        BiaoGe.History[FB][DT].boss18 = {}
                    end
                end
            end

            local FB = "BWLsod"
            if BiaoGe[FB].boss12.zhuangbei1 then
                BiaoGe[FB].boss8 = BG.Copy(BiaoGe[FB].boss9)
                BiaoGe[FB].boss9 = BG.Copy(BiaoGe[FB].boss10)
                BiaoGe[FB].boss10 = BG.Copy(BiaoGe[FB].boss11)
                BiaoGe[FB].boss11 = BG.Copy(BiaoGe[FB].boss12)
                BiaoGe[FB].boss12 = {}

                for DT, v in pairs(BiaoGe.History[FB]) do
                    if BiaoGe.History[FB][DT].boss12.zhuangbei1 then
                        BiaoGe.History[FB][DT].boss8 = BG.Copy(BiaoGe.History[FB][DT].boss9)
                        BiaoGe.History[FB][DT].boss9 = BG.Copy(BiaoGe.History[FB][DT].boss10)
                        BiaoGe.History[FB][DT].boss10 = BG.Copy(BiaoGe.History[FB][DT].boss11)
                        BiaoGe.History[FB][DT].boss11 = BG.Copy(BiaoGe.History[FB][DT].boss12)
                        BiaoGe.History[FB][DT].boss12 = {}
                    end
                end
            end
        end
    end
end)

BG.Init2(function()
    if IsAddOnLoaded("BiaoGeVIP") then
        BG.BiaoGeVIPVerNum = BGV.GetVerNum(GetAddOnMetadata("BiaoGeVIP", "Version"))
    end
    if BG.IsWLK then
        if BG.BiaoGeVIPVerNum and BG.BiaoGeVIPVerNum >= 10120 then
            ns.canShowTBC = true
        end
        if BG.IsTBCFB(BG.FB1) and not ns.canShowTBC then
            BG.ClickFBbutton("ICC")
        end
        if not ns.canShowTBC then
            BG.TabButtonsFB_TBC:Hide()
            BG.TabButtonsFB_TBC:SetParent(nil)
            BG.TabButtonsFB_TBC = nil
        end
    end
end)
