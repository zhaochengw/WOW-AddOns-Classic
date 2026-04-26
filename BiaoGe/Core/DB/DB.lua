local AddonName, ns = ...

local L = ns.L
local RGB = ns.RGB

local pt = print

local LibBG = LibStub:GetLibrary("LibUIDropDownMenu-4.0") -- 调用库菜单UI
ns.LibBG = LibBG

C_ChatInfo.RegisterAddonMessagePrefix("BiaoGe") -- 注册插件通信频道
C_ChatInfo.RegisterAddonMessagePrefix("BiaoGeVIP")
C_ChatInfo.RegisterAddonMessagePrefix("BiaoGeWorldBoss")

BiaoGeTooltip = CreateFrame("GameTooltip", "BiaoGeTooltip", UIParent, "GameTooltipTemplate")              -- 用于装备过滤功能
BiaoGeTooltip2 = CreateFrame("GameTooltip", "BiaoGeTooltip2", UIParent, "GameTooltipTemplate")            -- 用于装备库
BiaoGeTooltip2:SetClampedToScreen(false)
BiaoGeTooltip3            = CreateFrame("GameTooltip", "BiaoGeTooltip3", UIParent, "GameTooltipTemplate") -- 用于装备过期提醒
BiaoGeTooltip4            = CreateFrame("GameTooltip", "BiaoGeTooltip4", UIParent, "GameTooltipTemplate") -- 用于装等获取

-- 游戏按键设置
BINDING_HEADER_BIAOGE     = "BiaoGe"
BINDING_NAME_BIAOGE       = L["打开/关闭表格"]
BINDING_NAME_RoleOverview = L["打开/关闭角色总览"]
--[[ 
/dump GetBindingKey("BINDING_NAME_BIAOGE")
 GetBinding("MOVEFORWARD")
]]

local realmID             = GetRealmID()
local player              = BG.playerName
local realmName           = BG.realmName
local GetAddOnMetadata    = GetAddOnMetadata or C_AddOns.GetAddOnMetadata
local IsAddOnLoaded       = IsAddOnLoaded or C_AddOns.IsAddOnLoaded
local LoadAddOn           = LoadAddOn or C_AddOns.LoadAddOn

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
    BG.iconTexCoord = { .07, .93, .07, .93 }
    BG.zaxiang = {} -- 杂项如果太多，则需要换列
    BG.zhuangbeiWidth = 140
    BG.zhuangbeiWidth2 = 235
    BG.maijiaWidth = 90
    BG.jineWidth = 90
    BG.spFB = {}
    BG.fakuanIsFirst = {}
    if BG.IsRetail then
        BG.CloseButtonOffset = 0
    else
        BG.CloseButtonOffset = 2
    end

    BG.blackListPlayer = {}
    if not BG.verLess2 then
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
            },
        }
    end

    if BG.blackListPlayer[realmName] and BG.blackListPlayer[realmName][BG.playerName] then
        BG.IsBlackListPlayer = true
    end
end

-- 初始化
do
    BG.Maxi                                    = 40
    BG.FBWidth                                 = {}
    BG.FBHeight                                = {}
    BG.BossNumtbl                              = {}
    local mainFrameWidth                       = 1275
    local mainFrameWidth2                      = 1685
    local Maxt, Maxb, Maxi, HopeMaxb, HopeMaxn = {}, {}, {}, {}, {}
    -- 表格大小、排列方式、BOSS格子数
    do
        local function AddDB(FB, width, height, maxt, maxb,
                             bossNumTbl, diffTbl, diffIDTbl, maxiTbl, zaxiangI)
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
            if FB == "ULD" or FB == "ICC" or FB == "Worldtitan" then
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
            elseif maxb - bossNumTbl[#bossNumTbl] == 1 then
                BG.fakuanIsFirst[FB] = true
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
        end
        if BG.IsVanilla_60 then
            AddDB("MC", mainFrameWidth, 810, 3, 13, { 0, 7, 12 }, nil, nil,
                { 3, 3, 3, 4, 3, 3, 4, 3, 4, 5, 8, 15, 4, }, 6)
            AddDB("BWL", mainFrameWidth, 810, 3, 10, { 0, 5, 9 }, nil, nil,
                { 5, 5, 5, 5, 5, 5, 5, 6, 9, 12, })
            AddDB("ZUG", mainFrameWidth, 810, 3, 12, { 0, 6, 11 }, nil, nil,
                { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 9, 10, })
            AddDB("AQL", mainFrameWidth, 810, 3, 8, { 0, 5, 7 }, nil, nil,
                { 5, 5, 5, 5, 5, 5, 28, 5, }, 23)
            AddDB("TAQ", mainFrameWidth, 810, 3, 11, { 0, 6, 10 }, nil, nil,
                { 4, 4, 4, 4, 4, 4, 4, 4, 6, 19, 5, }, 13)
            AddDB("NAXX", mainFrameWidth, 900, 3, 17, { 0, 8, 15 }, nil, nil,
                { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 8, 12, 9, })
        end
        if BG.IsTBC then
            AddDB("KZ", mainFrameWidth, 810, 3, 13, { 0, 6, 12 }, nil, nil,
                { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 10, 5, }, 5)
            AddDB("GL", mainFrameWidth, 810, 2, 5, { 0, 4, }, nil, nil,
                { 6, 6, 8, 6, 13 })
        end
        if BG.IsWLK_80 then
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
            AddDB("NAXX", mainFrameWidth2, 945, 4, 19, { 0, 6, 12, 16 }, { "N10", "N25" }, difTbl1,
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
            AddDB("TAQ", mainFrameWidth, 810, 3, 11, { 0, 6, 10 }, nil, difTbl3,
                { 4, 4, 4, 4, 4, 4, 4, 4, 6, 19, 5, }, 13)
            AddDB("BWL", mainFrameWidth, 810, 3, 10, { 0, 5, 9 }, nil, difTbl3,
                { 5, 5, 5, 5, 5, 5, 5, 6, 9, 12, })
        end
        if BG.IsTitan then
            AddDB("Worldtitan", mainFrameWidth, 930, 3, 10, { 0, 4, 8 }, nil, nil,
                { 9, 9, 9, 9, 9, 9, 9, 9, 3, 4 })
            AddDB("MCtitan", mainFrameWidth, 870, 3, 12, { 0, 6, 11 }, nil, nil,
                { 5, 5, 5, 5, 5, 6, 5, 5, 5, 6, 11, 20, })
            AddDB("SSCtitan", mainFrameWidth, 870, 3, 12, { 0, 6, 11 }, nil, nil,
                { 5, 5, 5, 5, 5, 6, 5, 5, 5, 7, 18, 11, }, 11)
            AddDB("NAXXtitan", mainFrameWidth2, 870, 4, 19, { 0, 6, 12, 16 }, nil, nil,
                { 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 8, 12, 6, 7, 5, })
            AddDB("TOCtitan", mainFrameWidth, 900, 3, 17, { 0, 8, 14 }, nil, nil,
                { 4, 4, 4, 4, 4, 4, 4, 4, 5, 8, 5, 5, 5, 5, 6, 9, 5, })
        end
        if BG.IsCTM then
            AddDB("BOT", mainFrameWidth2, 830, 4, 15, { 0, 5, 10, 14 }, { "N", "H" }, nil,
                { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 8, 24, 4, }, 12)
            AddDB("FL", mainFrameWidth, 830, 3, 9, { 0, 5, 8 }, { "N", "H" }, nil,
                { 6, 6, 6, 6, 6, 8, 8, 15, 18, })
            AddDB("DS", mainFrameWidth, 830, 3, 10, { 0, 5, 9 }, { "N", "H" }, nil,
                { 6, 6, 6, 6, 6, 6, 6, 6, 13, 18, })
        end
        if BG.IsMOP then
            AddDB("MSV", mainFrameWidth2, 960, 4, 18, { 0, 6, 12, 17 }, { "N", "H" }, nil,
                { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 27, 10, }, 14)
            AddDB("TOT", mainFrameWidth, 960, 3, 15, { 0, 6, 12, }, { "N", "H" }, nil,
                { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 11, 6 })
        end
        if BG.IsRetail then
            local n = 8
            AddDB("NP", mainFrameWidth, 950, 3, 10, { 0, 4, 8 }, { "R", "N", "H", "M" }, nil,
                { n, n, n, n, n, n, n, n, 5, 5, }, 12)
        end
    end

    -- 表格基础信息
    do
        local function AddDB(FB, instanceID, phase, maxplayers, lootQuality,
                             phaseTable, bossPositionTbl, shortName)
            local localName = GetRealZoneText(instanceID)
            if localName == "" then
                localName = shortName or UNKNOWN
            end
            if instanceID == 548 then
                localName = L["毒蛇神殿"]
            end
            tinsert(BG.FBtable, FB)
            tinsert(BG.FBtable2,
                {
                    FB = FB,
                    ID = instanceID,
                    localName = localName,
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
                BG.FBfromBossPosition[FB][i] = { name = FB, localName = localName }
            end
        end
        local function AddOneBoss(FB, instanceID, bossNum, name)
            BG.FBIDtable[instanceID] = FB
            BG.bossPositionStartEnd[instanceID] = { bossNum, bossNum }
            BG.FBfromBossPosition[FB][bossNum] = { name = name, localName = GetRealZoneText(instanceID) }
        end

        if BG.IsVanilla_Sod then
            BG.FB1 = "MCsod"
            BG.fullLevel = 60
            BG.fullLevel_RoleOverview = 25
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
        end
        if BG.IsVanilla_60 then
            BG.FB1 = "MC"
            BG.fullLevel = 60
            BG.fullLevel_RoleOverview = 35
            AddDB("MC", 409, "P1-P2", 40, nil, nil, { 1, 10 })
            AddDB("BWL", 469, "P3", 40)
            AddDB("ZUG", 309, "P4", 20, 3)
            AddDB("AQL", 509, "P5", 20, 3)
            AddDB("TAQ", 531, "P5", 40)
            AddDB("NAXX", 533, "P6", 40)

            BG.FBIDtable[249] = "MC" -- 奥妮克希亚的巢穴
            BG.bossPositionStartEnd[249] = { 11, 11 }
            BG.FBfromBossPosition["MC"][11] = { name = "OL", localName = GetRealZoneText(249) }

            BG.spFB.NAXX = { 22726 }
        end
        if BG.IsTBC then
            BG.FB1 = "KZ"
            BG.fullLevel = 70
            BG.fullLevel_RoleOverview = 35
            AddDB("KZ", 532, "P1", 10, nil, { "KZ", "GL" })
            local P2FB = "SSCtitan"
            local TKmapID = 550
            AddDB("GL", 565, "P1", 25, nil, { "KZ", "GL" })
            BG.FBIDtable[544] = "GL" -- 玛瑟里顿
            BG.bossPositionStartEnd[544] = { 3, 3 }
            BG.FBfromBossPosition["GL"][3] = { name = "ML", localName = GetRealZoneText(544) }
        end
        if BG.IsWLK_80 then
            BG.FB1 = "NAXX"
            BG.fullLevel = 80
            BG.fullLevel_RoleOverview = 60

            AddDB("NAXX", 533, "P1", nil, nil, nil, { 1, 15 })
            AddDB("ULD", 603, "P2")
            AddDB("TOC", 649, "P3", nil, nil, nil, { 1, 6 })
            AddDB("ICC", 631, "P4", nil, nil, nil, { 1, 12 })

            BG.FBIDtable[615] = "NAXX" -- 黑曜石圣殿
            BG.bossPositionStartEnd[615] = { 16, 16 }
            BG.FBfromBossPosition["NAXX"][16] = { name = "OS", localName = GetRealZoneText(615) }

            BG.FBIDtable[616] = "NAXX" -- 永恒之眼
            BG.bossPositionStartEnd[616] = { 17, 17 }
            BG.FBfromBossPosition["NAXX"][17] = { name = "EOE", localName = GetRealZoneText(616) }

            BG.FBIDtable[249] = "TOC" -- 奥妮克希亚的巢穴
            BG.bossPositionStartEnd[249] = { 7, 7 }
            BG.FBfromBossPosition["TOC"][7] = { name = "OL", localName = GetRealZoneText(249) }

            BG.FBIDtable[724] = "ICC" -- 红玉圣殿
            BG.bossPositionStartEnd[724] = { 13, 13 }
            BG.FBfromBossPosition["ICC"][13] = { name = "RS", localName = GetRealZoneText(724) }

            BG.spFB.ICC = { 50274 }
            BG.spFB.ULD = { 45038 }

            -- TBC
            do
                AddDB("BWL", 469, "", nil, nil, nil, nil, L["黑翼"])
                AddDB("TAQ", 531, "", nil, nil, nil, nil, L["安其拉"])
                AddDB("SSC", 548, "", nil, nil, nil, nil, L["毒蛇风暴"])
                AddDB("HS", 534, "", nil, nil, nil, nil, L["海加尔山"])
                AddDB("BT", 564, "", nil, nil, nil, nil, L["黑暗神殿"])
                AddDB("SW", 580, "", nil, nil, nil, nil, L["太阳井"])

                BG.FBIDtable[550] = "SSC" -- 风暴要塞
                BG.bossPositionStartEnd[550] = { 7, 10 }
                for i = 7, 10 do
                    BG.FBfromBossPosition["SSC"][i] = { name = "TK", localName = GetRealZoneText(550) }
                end
            end
        end
        if BG.IsTitan then
            BG.FB1 = "MCtitan"
            BG.fullLevel = 80
            BG.fullLevel_RoleOverview = 60

            AddDB("Worldtitan", -100, "", 40, nil, nil, nil, L["世界Boss"])
            BG.worldBossNpcID = {
                6109,  -- 蓝龙
                12397, -- 卡扎克
                17711, -- 末日行者
                18728, -- 末日领主卡扎克
            }

            AddDB("MCtitan", 409, "P1", 25)
            local FB = "SSCtitan"
            local TKmapID = 550
            AddDB(FB, 548, "P2", 25, nil, nil, { 1, 6 }, L["毒蛇风暴"])
            BG.FBIDtable[TKmapID] = FB -- 风暴要塞
            BG.bossPositionStartEnd[TKmapID] = { 7, 10 }
            for i = 7, 10 do
                BG.FBfromBossPosition[FB][i] = { name = "TK", localName = GetRealZoneText(TKmapID) }
            end

            local FB = "NAXXtitan"
            local OSmapID = 615
            local EOEmapID = 616
            AddDB(FB, 533, "P3", nil, nil, nil, { 1, 15 })
            BG.FBIDtable[OSmapID] = FB -- 黑曜石圣殿
            BG.bossPositionStartEnd[OSmapID] = { 16, 16 }
            BG.FBfromBossPosition[FB][16] = { name = "OS", localName = GetRealZoneText(OSmapID) }
            BG.FBIDtable[EOEmapID] = FB -- 永恒之眼
            BG.bossPositionStartEnd[EOEmapID] = { 17, 17 }
            BG.FBfromBossPosition[FB][17] = { name = "EOE", localName = GetRealZoneText(EOEmapID) }

            BG.spFB.NAXXtitan = { 22726 }

            local FB = "TOCtitan"
            local TOCmapID = 649
            AddDB(FB, 309, "P4", 25, nil, nil, { 1, 10 }, L["P4双本"])
            BG.FBIDtable[TOCmapID] = FB -- 十字军
            BG.bossPositionStartEnd[TOCmapID] = { 11, 15 }
            for i = 11, 15 do
                BG.FBfromBossPosition[FB][i] = { name = "TOC", localName = GetRealZoneText(TOCmapID) }
            end
        end
        if BG.IsCTM then
            BG.FB1 = "DS"
            BG.fullLevel = 85
            BG.fullLevel_RoleOverview = 70
            AddDB("BOT", 671, "P1", nil, nil, nil, { 1, 5 }) -- 暮光堡垒
            BG.FBIDtable[669] = "BOT"                        -- 黑翼血环
            BG.bossPositionStartEnd[669] = { 6, 11 }
            for i = 6, 11 do
                BG.FBfromBossPosition["BOT"][i] = { name = "BWD", localName = GetRealZoneText(669) }
            end
            BG.FBIDtable[754] = "BOT" -- 风神王座
            BG.bossPositionStartEnd[754] = { 12, 13 }
            for i = 12, 13 do
                BG.FBfromBossPosition["BOT"][i] = { name = "TOF", localName = GetRealZoneText(754) }
            end

            AddDB("FL", 720, "P3") -- 火焰之地
            AddDB("DS", 967, "P4") -- 巨龙之魂

            BG.spFB.DS = {
                -- 10939 -- 测试
                77952
            }
        end
        if BG.IsMOP then
            BG.FB1 = "MSV"
            BG.fullLevel = 90
            BG.fullLevel_RoleOverview = 80
            BG.worldBossID = { 32098, 32099, 32518, 32519, 37464 } -- 炮舰 怒之煞 暴风领主纳拉克 乌达斯塔 鲁赫马尔
            AddDB("MSV", 1008, "P1", nil, nil, nil, { 1, 6 }, L["P1三本"]) -- 魔古山
            -- 恐惧之心
            BG.FBIDtable[1009] = "MSV"
            BG.bossPositionStartEnd[1009] = { 7, 12 }
            for i = 7, 12 do
                BG.FBfromBossPosition["MSV"][i] = { name = "HOF", localName = GetRealZoneText(1009) }
            end
            -- 永春台
            BG.FBIDtable[996] = "MSV"
            BG.bossPositionStartEnd[996] = { 13, 16 }
            for i = 13, 16 do
                BG.FBfromBossPosition["MSV"][i] = { name = "TES", localName = GetRealZoneText(996) }
            end
            AddDB("TOT", 1098, "P3") -- 雷电王座
        end
        if BG.IsRetail then
            BG.FB1 = "NP"
            BG.fullLevel = 80
            BG.fullLevel_RoleOverview = 80
            AddDB("NP", 2657, "P1", 20)
        end
    end

    -- 装备库获取来源过滤
    do
        if BG.IsVanilla_Sod then
            BG.itemLibGetFiter = {
                { name = L["团本"], name2 = "raid", },
                { name = L["牌子/货币"], name2 = "currency", },
                { name = L["5人本"], name2 = "fb5", },
                { name = L["声望"], name2 = "faction", },
                { name = L["专业"], name2 = "profession", },
                { name = L["世界掉落"], name2 = "world", },
                { name = L["PVP"], name2 = "pvp", },
            }
        elseif BG.IsVanilla_60 then
            BG.itemLibGetFiter = {
                { name = L["团本"], name2 = "raid", },
                { name = L["声望"], name2 = "faction", },
                { name = L["专业"], name2 = "profession", },
                { name = L["世界掉落"], name2 = "world", },
                { name = L["世界BOSS"], name2 = "worldboss", },
                { name = L["PVP"], name2 = "pvp", },
            }
        elseif BG.IsTBC then
            BG.itemLibGetFiter = {
                { name = L["团本"], name2 = "raid", },
                -- { name = L["声望"], name2 = "faction", },
                -- { name = L["专业"], name2 = "profession", },
                -- { name = L["世界掉落"], name2 = "world", },
                -- { name = L["世界BOSS"], name2 = "worldboss", },
            }
        elseif BG.IsWLK_80 then
            BG.itemLibGetFiter = {
                { name = L["团本：25人"], name2 = "raid25", },
                { name = L["团本：10人"], name2 = "raid10", },
                { name = L["团本：英雄难度"], name2 = "raidhero", },
                { name = L["团本：普通难度"], name2 = "raidnormal", },
                { name = L["5人本"], name2 = "fb5", },
                { name = L["牌子/货币"], name2 = "currency", },
                { name = L["声望"], name2 = "faction", },
                { name = L["专业"], name2 = "profession", },
                { name = L["PVP"], name2 = "pvp", },
            }
        elseif BG.IsTitan then
            BG.itemLibGetFiter = {
                { name = L["团本"], name2 = "raid", },
                { name = L["世界BOSS"], name2 = "worldboss", },
                { name = L["5人本"], name2 = "fb5", },
                { name = L["牌子/货币"], name2 = "currency", },
                { name = L["声望"], name2 = "faction", },
                { name = L["专业"], name2 = "profession", },
                -- { name = L["PVP"], name2 = "pvp", },
                { name = L["世界掉落"], name2 = "world", },
            }
        elseif BG.IsCTM then
            BG.itemLibGetFiter = {
                { name = L["团本：英雄难度"], name2 = "raidhero", },
                { name = L["团本：普通难度"], name2 = "raidnormal", },
                { name = L["5人本"], name2 = "fb5", },
                { name = L["牌子/货币"], name2 = "currency", },
                { name = L["声望"], name2 = "faction", },
                { name = L["专业"], name2 = "profession", },
                { name = L["世界掉落"], name2 = "world", },
                -- { name = L["世界BOSS"], name2 = "worldboss", },
                { name = L["PVP"], name2 = "pvp", },
            }
        elseif BG.IsMOP then
            BG.itemLibGetFiter = {
                { name = L["团本：英雄难度"], name2 = "raidhero", },
                { name = L["团本：普通难度"], name2 = "raidnormal", },
                -- { name = L["5人本"], name2 = "fb5", },
                { name = L["牌子/货币"], name2 = "currency", },
                -- { name = L["声望"], name2 = "faction", },
                { name = L["专业"], name2 = "profession", },
                { name = L["世界掉落"], name2 = "world", },
                { name = L["世界BOSS"], name2 = "worldboss", },
                -- { name = L["PVP"], name2 = "pvp", },
            }
        elseif BG.IsRetail then
            BG.itemLibGetFiter = {
                { name = L["团本：史诗难度"], name2 = "raidmyth", },
                { name = L["团本：英雄难度"], name2 = "raidhero", },
                { name = L["团本：普通难度"], name2 = "raidnormal", },
                { name = L["5人本"], name2 = "fb5", },
                { name = L["牌子/货币"], name2 = "currency", },
                { name = L["声望"], name2 = "faction", },
                { name = L["专业"], name2 = "profession", },
                { name = L["世界掉落"], name2 = "world", },
            }
        end
    end

    local HopeMaxi
    if BG.IsWLK_80 then
        HopeMaxi = 3
    else
        HopeMaxi = 5
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
                Shop = {},         -- 商店直接售卖

                Holiday = {},      -- 节日

                Sod_PVP = {},      -- 赛季服PVP活动
                Sod_Currency = {},

                ExchangeItems = {},
            }
        end
    end

    -- 颜色
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
            { ID = "fakuanFull", name = "罚款格子满了" },
            { ID = "auctionError", name = "拍卖出错了" },
            { ID = "currencyfull", name = "牌子满了" },
            { ID = "auctionTopPrice", name = "小心偷家" },
        }
        --[[
/run BG.PlaySound("paimai")
/run BG.PlaySound("hope")
]]
        local function DefaultSound()
            for i = 1, C_AddOns.GetNumAddOns() do
                local addonName = C_AddOns.GetAddOnInfo(i)
                local enabled = C_AddOns.GetAddOnEnableState(i, player)
                if C_AddOns.GetAddOnMetadata(i, "X-BiaoGe-Voice") and enabled ~= 0 then
                    local author = C_AddOns.GetAddOnMetadata(i, "Author")
                    tinsert(BG.soundAuthor, { ID = author, addonName = addonName })
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
                        BG["sound_" .. soundID .. author] = Interface .. author .. "\\" .. soundID
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

    BG.classColorNames = {}
    for i = 1, GetNumClasses() do
        local className, classFilename = GetClassInfo(i)
        if className then
            local color = select(4, GetClassColor(classFilename))
            BG.classColorNames[className] = format("|c%s%s|r", color, className)
        end
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

    if not BG.verLess2 then
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
        BiaoGe.playerInfo[realmID][player].iLevel = select(2, GetAverageItemLevel()) or 0

        local function UpdateLevel(level)
            BiaoGe.playerInfo[realmID][player].level = level
            BG.isFullLevel = level >= BG.fullLevel
        end
        UpdateLevel(UnitLevel("player"))
        BG.RegisterEvent("PLAYER_LEVEL_UP", function(self, event, level)
            UpdateLevel(level)
            if BG.UpdateMeetingHornLevelButton then
                BG.UpdateMeetingHornLevelButton()
            end
        end)

        -- 天赋
        if not BG.IsRetail then
            local function GetTalent(_, event)
                local specIndex
                if BG.IsMOP then
                    specIndex = C_SpecializationInfo.GetSpecialization()
                    if specIndex == 0 or specIndex == 5 then
                        specIndex = nil
                    end
                else
                    local maxNum = 0
                    for i = 1, 3 do
                        local num = select(5, GetTalentTabInfo(i, nil, nil, GetActiveTalentGroup()))
                        if num and num >= maxNum then
                            maxNum = num
                            specIndex = i
                        end
                    end
                    if maxNum == 0 then specIndex = nil end
                end
                BiaoGe.playerInfo[realmID][player].talent = specIndex
            end

            local f = CreateFrame("Frame")
            f:RegisterEvent("PLAYER_TALENT_UPDATE")
            f:RegisterEvent("PLAYER_ENTERING_WORLD")
            if BG.IsMOP then
                f:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
            end
            f:SetScript("OnEvent", function(self, event, ...)
                if event == "PLAYER_ENTERING_WORLD" then
                    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
                end
                self.t = 0
                self:SetScript("OnUpdate", function(_, t)
                    self.t = self.t + t
                    if self.t > 1 then
                        self:SetScript("OnUpdate", nil)
                        GetTalent()
                    end
                end)
            end)

            function BG.GetTalentIcon(class, talent, w)
                w = w or 0
                if talent then
                    local a, b, c, d = unpack(BG.iconTexCoord)
                    local coord = format("100:100:%s:%s:%s:%s", a * 100, b * 100, c * 100, d * 100)
                    local tex = BG.talentIcon[class][talent]
                    if tex then
                        return format("|T%s:%s:%s:0:0:%s|t", BG.talentIcon[class][talent], w, w, coord)
                    end
                end
                return format("|A:GarrMission_ClassIcon-%s:%s:%s|a", class, w, w)
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
                MONK = {
                    "Interface/Icons/spell_monk_brewmaster_spec", -- 酒仙
                    "Interface/Icons/spell_monk_mistweaver_spec", -- 织雾
                    "Interface/Icons/spell_monk_windwalker_spec", -- 踏风
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
                    "Interface\\Icons\\spell_holy_wordfortitude",  -- N
                    "Interface\\Icons\\spell_holy_guardianspirit", -- N
                    "Interface\\Icons\\spell_shadow_shadowwordpain",
                },
            }
            if BG.IsMOP or BG.IsCTM then
                BG.talentIcon.DRUID = {
                    "Interface\\Icons\\spell_nature_starfall",     -- 鸟
                    "Interface\\Icons\\ability_druid_catform",     -- 猫
                    "Interface\\Icons\\ability_racial_bearform",   -- 熊
                    "Interface\\Icons\\Spell_Nature_HealingTouch", -- N
                }
            else
                BG.talentIcon.DRUID = {
                    "Interface\\Icons\\spell_nature_starfall",
                    "Interface\\Icons\\ability_racial_bearform",
                    "Interface\\Icons\\Spell_Nature_HealingTouch", -- N
                }
            end
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

    -- 删除旧表格数据
    do
        if BG.IsMOP or BG.IsTitan then
            for i, FB in ipairs({
                "NAXX", "ULD", "TOC", "ICC",
                "BOT", "FL", "DS",
            }) do
                BiaoGe[FB] = nil
                BiaoGe.History[FB] = nil
                BiaoGe.HistoryList[FB] = nil
            end
        end
    end

    -- 默认字体
    do
        local l = GetLocale()
        local default, list
        if (l == "koKR") then
            default = "2002.TTF"
        elseif (l == "zhCN") then
            default = "ARKai_T.ttf"
            list = {
                "ARKai_T.ttf",
                "ARKai_C.ttf",
                "ARHei.ttf",
                -- "ARIALN.ttf",
                -- "FRIZQT__.ttf",
            }
        elseif (l == "zhTW") then
            default = "blei00d.TTF"
            list = {
                "bLEI00D.ttf",
                "bHEI00M.ttf",
                "bHEI01B.ttf",
                "bKAI00M.ttf",
            }
        elseif (l == "ruRU") then
            default = "FRIZQT___CYR.TTF"
        else
            default = "FRIZQT__.TTF"
            list = {
                "FRIZQT__.TTF",
                "2002.TTF",
                "2002B.TTF",
                "ARHei.TTF",
                "ARKai_C.TTF",
                "ARKai_T.TTF",
                "ARIALN.TTF",
                "K_Pagetext.TTF",
                "MORPHEUS_CYR.TTF",
                "NIM_____.ttf",
                "SKURRI_CYR.TTF",
            }
        end
        BiaoGe.font = BiaoGe.font or default

        local t = UIParent:CreateFontString()
        t:SetFont(format("Fonts\\%s", BiaoGe.font), 15, "OUTLINE")
        t:Hide()
        if not t:GetFont() then
            BiaoGe.font = default
        end
        BIAOGE_TEXT_FONT = format("Fonts\\%s", BiaoGe.font)

        if list then
            for i = #list, 1, -1 do
                local t = UIParent:CreateFontString()
                t:SetFont(format("Fonts\\%s", list[i]), 15, "OUTLINE")
                t:Hide()
                if not t:GetFont() then
                    tremove(list, i)
                end
            end
        end
        BG.fontList = list

        local name = "editFontSize"
        BiaoGe.options[name] = BiaoGe.options[name] or 14
        function BiaoGe_InputBoxTemplate_OnLoad(self)
            self:SetFont(BIAOGE_TEXT_FONT, BiaoGe.options[name], "OUTLINE")
        end
    end

    -- 自定义字体
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
            BG["Font" .. color .. size]:SetFont(BIAOGE_TEXT_FONT, size, "OUTLINE")
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
        CreateMyFont("White", 14)
        CreateMyFont("White", 15)
        CreateMyFont("White", 18)
        CreateMyFont("White", 25)

        CreateMyFont("Dis", 13)
        CreateMyFont("Dis", 15)
    end
end)

BG.Init2(function()
    if BG.hasHolidayLoot then
        BG.After(1, function()
            ToggleCalendar()
            Calendar_Hide()
        end)
    end

    if IsAddOnLoaded("BiaoGeVIP") and BGV and BGV.raidVersion
        and BG.GetVerNum(GetAddOnMetadata("BiaoGeVIP", "Version")) >= 10300 then
        ns.isVIP = true
    end
    if BG.IsWLK_80 then
        if ns.isVIP then
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
    if type(BGV) == "table" and
        not BGV["qGCbmiUZxPvgziowMAxPvslL(62DLnGHSA2D6DN2jA2zgMzwzjh4kJInidbSr8LX412ChrhqGCbmiUZxaSHuaacUsQ6Q7xDP6"]
    then
        wipe(BGV)
        ns.isVIP = nil
    end
    if type(BGAI) == "table" and
        not BGAI["PvUZxaSHuaacUsQ6QbS2r822LX4ChrhqGCbmiUZxaSHuUsQ6Q7xDP619dhVRTR7huLUR96UNz210z2DwjJjPQtvzPzM1V3RF"]
    then
        wipe(BGAI)
        ns.isVIP = nil
    end
end)
