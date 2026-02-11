if BG.IsBlackListPlayer then return end
local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local RGB_16 = ns.RGB_16
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local GetText_T = ns.GetText_T
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID
local Round = ns.Round

local pt = print

local player = BG.playerName
local realmID = GetRealmID()

local FBCD = "RaidCD"
local MONEY = "MONEY"

function BG.RoleOverviewUI()
    if BiaoGe.FBCD then
        BiaoGe[FBCD] = BG.Copy(BiaoGe.FBCD)
        BiaoGe.FBCD = nil
    end
    if BiaoGe.Money then
        BiaoGe[MONEY] = BG.Copy(BiaoGe.Money)
        BiaoGe.Money = nil
    end

    BiaoGe[FBCD] = BiaoGe[FBCD] or {}
    BiaoGe[FBCD][realmID] = BiaoGe[FBCD][realmID] or {}

    BiaoGe[MONEY] = BiaoGe[MONEY] or {}
    BiaoGe[MONEY][realmID] = BiaoGe[MONEY][realmID] or {}
    BiaoGe[MONEY][realmID][player] = BiaoGe[MONEY][realmID][player] or {}

    -- 选择初始化
    if BG.IsTitan then
        BG.Once("FBCDchoice", 251104, function()
            BiaoGe.FBCDchoice = nil
            BiaoGe.MONEYchoice = nil
        end)
    end
    if BG.IsMOP_CN then
        BG.Once("FBCDchoice", 251216, function()
            BiaoGe.FBCDchoice = nil
            BiaoGe.MONEYchoice = nil
        end)
    end

    if not BiaoGe.FBCDchoice then
        if BG.IsVanilla then
            BiaoGe.FBCDchoice = {
                ["NAXX"] = 1,
                ["TAQ"] = 1,
                ["BWL"] = 1,
                ["OL"] = 1,
                ["MC"] = 1,
                ["AQL"] = 1,
                ["ZUG"] = 1,

                ["BWLsod"] = 1,
                ["ZUGsod"] = 1,
                ["TCV"] = 1,
                ["MCsod"] = 1,
                ["OLsod"] = 1,
                ["SC"] = 1,
                ["TTS"] = 1,
                ["alchemy"] = 1,
                ["leatherworking"] = 1,
                ["tailor"] = 1,
            }
        elseif BG.IsWLK_80 then
            BiaoGe.FBCDchoice = {
                ["25RS"] = 1,
                ["10RS"] = 1,
                ["25ICC"] = 1,
                ["10ICC"] = 1,
                -- ["25TOC"] = 1,
                -- ["10TOC"] = 1,
                -- ["25OL"] = 1,
                -- ["10OL"] = 1,
                -- ["25ULD"] = 1,
                -- ["10ULD"] = 1,
                -- ["25NAXX"] = 1,
                -- ["10NAXX"] = 1,
                -- ["25EOE"] = 1,
                -- ["10EOE"] = 1,
                -- ["25OS"] = 1,
                -- ["10OS"] = 1,
                ["25VOA"] = 1,
                ["10VOA"] = 1,
                ["gamma"] = 1,
                ["heroe"] = 1,
                ["week1"] = 1,
                ["faction1156"] = 1,
            }
        elseif BG.IsTitan then
            BiaoGe.FBCDchoice = {
                SSCtitan = 1,
                TKtitan = 1,
                Doomwalker = 1,
                DoomLordKazzak = 1,
                ["MCtitan"] = 1,
                ["VOAtitan"] = 1,
                ["Lanlongtitan"] = 1,
                ["Kazaketitan"] = 1,
                ["gamma"] = 1,
                ["heroe"] = 1,
                ["week1"] = 1,
                ["holiday"] = 1,
                ["faction" .. "749"] = 1,
                ["faction" .. "1119"] = 1,
                ["faction" .. "1098"] = 1,
                ["faction" .. "1106"] = 1,
                ["faction" .. "1090"] = 1,
                ["faction" .. "1091"] = 1,
            }
        elseif BG.IsCTM then
            BiaoGe.FBCDchoice = {
                ["DS"] = 1,
                ["FL"] = 1,
                ["BOT"] = 1,
                ["BWD"] = 1,
                ["TOF"] = 1,
                ["25BH"] = 1,
                ["10BH"] = 1,
                ["faction1204"] = 1,
                ["faction1171"] = 1,
            }
        elseif BG.IsMOP_TW then
            BiaoGe.FBCDchoice = {
                ["TOT"] = 1,
                ["worldBoss4"] = 1,
                ["worldBoss3"] = 1,
                ["worldBoss2"] = 0,
                ["worldBoss1"] = 0,

                ["holiday"] = 1,

                ["faction" .. "1359"] = 1,
                ["faction" .. "1435"] = 1,

                ["faction" .. "1387"] = 1,
                ["faction" .. "1388"] = 1,
            }
        elseif BG.IsMOP_CN then
            BiaoGe.FBCDchoice = {
                ["TES"] = 1,
                ["HOF"] = 1,
                ["MSV"] = 1,
                ["worldBoss2"] = 1,
                ["worldBoss1"] = 1,

                ["holiday"] = 1,

                ["faction" .. "1359"] = 1,
                ["faction" .. "1341"] = 1,
                ["faction" .. "1269"] = 1,
                ["faction" .. "1270"] = 1,
                ["faction" .. "1337"] = 1,
            }
        elseif BG.IsRetail then
            BiaoGe.FBCDchoice = {
                ["NP"] = 1,
            }
        end
    end
    if not BiaoGe.MONEYchoice then
        if BG.IsVanilla then
            BiaoGe.MONEYchoice = {
                [22726] = 1,
                [226404] = 1,
                [221262] = 1,
                [221365] = 1,
                ["money"] = 1,
            }
        elseif BG.IsWLK_80 then
            BiaoGe.MONEYchoice = {
                -- [396] = 1,
                -- [395] = 1,
                [50274] = 1, -- 橙片
                [341] = 1,
                [301] = 1,
                [221] = 1,
                [102] = 1,
                [101] = 1,
                [2711] = 1, -- 天灾石
                [2589] = 1, -- 赛德精华
                ["money"] = 1,
            }
        elseif BG.IsTitan then
            BiaoGe.MONEYchoice = {
                [3403] = 1,
                [3406] = 1,
                [161] = 1,
                [1901] = 1,
                ["money"] = 1,
            }
        elseif BG.IsCTM then
            BiaoGe.MONEYchoice = {
                [77952] = 1, -- 橙片
                [396] = 1,
                [395] = 1,
                [3281] = 1,
                [3148] = 1,
                [1901] = 1,
                ["money"] = 1,
            }
        elseif BG.IsMOP_TW then
            BiaoGe.MONEYchoice = {
                [396] = 1,
                [395] = 1,
                [3414] = 1,
                [752] = 1,
                [738] = 1,
                [390] = 1,
                [1901] = 1,
                ["money"] = 1,
            }
        elseif BG.IsMOP_CN then
            BiaoGe.MONEYchoice = {
                [396] = 1,
                [395] = 1,
                [3350] = 1,
                [697] = 1,
                [738] = 1,
                [390] = 1,
                [1901] = 1,
                ["money"] = 1,
            }
        elseif BG.IsRetail then
            BiaoGe.MONEYchoice = {
                ["money"] = 1,
            }
        end
    end
    if not BiaoGe.SKILLchoice then
        BiaoGe.SKILLchoice = {}
        BiaoGe.SKILLchoice[0] = true
    end
    -- 更新
    do
        if BG.IsVanilla then
            BG.Once("ro", 250602, function()
                BiaoGe.MONEYchoice[22726] = 1
            end)
        elseif BG.IsWLK_80 then
            BG.Once("FBCDchoice", 250717, function()
                BiaoGe.FBCDchoice["25RS"] = 1
                BiaoGe.FBCDchoice["10RS"] = 1
                BiaoGe.FBCDchoice["25TOC"] = nil
                BiaoGe.FBCDchoice["10TOC"] = nil
            end)
            BG.Once("FBCDchoice", 250626, function()
                if BiaoGe.MONEYchoice[45039] == 1 then
                    BiaoGe.MONEYchoice[45038] = 1
                end
            end)
            BG.Once("FBCDchoice", 250610, function()
                BiaoGe.FBCDchoice["faction1156"] = 1
            end)
            BG.Once("FBCDchoice", 250512, function()
                BiaoGe.FBCDchoice["25ICC"] = 1
                BiaoGe.FBCDchoice["10ICC"] = 1
                BiaoGe.FBCDchoice["25OL"] = nil
                BiaoGe.FBCDchoice["10OL"] = nil
                BiaoGe.FBCDchoice["25ULD"] = nil
                BiaoGe.FBCDchoice["10ULD"] = nil
                BiaoGe.FBCDchoice["25NAXX"] = nil
                BiaoGe.FBCDchoice["10NAXX"] = nil
                BiaoGe.FBCDchoice["25EOE"] = nil
                BiaoGe.FBCDchoice["10EOE"] = nil
                BiaoGe.FBCDchoice["25OS"] = nil
                BiaoGe.FBCDchoice["10OS"] = nil

                BiaoGe.MONEYchoice[341] = 1
                BiaoGe.MONEYchoice[301] = 1
                BiaoGe.MONEYchoice[2711] = 1
                BiaoGe.MONEYchoice[2589] = 1
            end)
            BG.Once("ro", 250602, function()
                BiaoGe.MONEYchoice[50274] = 1
            end)
        elseif BG.IsTitan then
            BG.Once("FBCDchoice", 260209, function()
                BiaoGe.FBCDchoice["holiday"] = 1
            end)
            BG.Once("FBCDchoice", 260129, function()
                BiaoGe.FBCDchoice["SSCtitan"] = 1
                BiaoGe.FBCDchoice["TKtitan"] = 1
                BiaoGe.FBCDchoice["Doomwalker"] = 1
                BiaoGe.FBCDchoice["DoomLordKazzak"] = 1
            end)
            BG.Once("FBCDchoice", 251204, function()
                BiaoGe.FBCDchoice["VOAtitan"] = 1
                BiaoGe.FBCDchoice["Lanlongtitan"] = 1
                BiaoGe.FBCDchoice["Kazaketitan"] = 1
                BiaoGe.FBCDchoice["faction" .. "749"] = 1
            end)
        elseif BG.IsCTM then
        elseif BG.IsMOP_TW then
            BG.Once("FBCDchoice", 251217, function()
                BiaoGe.FBCDchoice["TOT"] = 1
                BiaoGe.FBCDchoice["worldBoss4"] = 1
                BiaoGe.FBCDchoice["worldBoss3"] = 1
                BiaoGe.FBCDchoice["faction" .. "1435"] = 1
                BiaoGe.FBCDchoice["faction" .. "1387"] = 1
                BiaoGe.FBCDchoice["faction" .. "1388"] = 1

                BiaoGe.FBCDchoice["faction" .. "1341"] = 0
                BiaoGe.FBCDchoice["faction" .. "1269"] = 0
                BiaoGe.FBCDchoice["faction" .. "1270"] = 0
                BiaoGe.FBCDchoice["faction" .. "1337"] = 0

                BiaoGe.MONEYchoice[752] = 1
                BiaoGe.MONEYchoice[697] = 0
            end)
            BG.Once("FBCDchoice", 251224, function()
                BiaoGe.MONEYchoice[3414] = 1
            end)
        end
        if BG.IsMOP then
            BG.Once("FBCDchoice", 260209, function()
                BiaoGe.FBCDchoice["holiday"] = 1
            end)
        end
    end

    -- 基础数据初始化
    do
        BG.factionTbl = {}
        if BG.IsVanilla_Sod then
            BG.FBCDall_table = {
                { name = "BWLsod", color = "00BFFF", fbId = 469, type = "fb" },
                { name = "MCsod", color = "00BFFF", fbId = 409, type = "fb" },
                { name = "ZUGsod", color = "00BFFF", fbId = 309, type = "fb" },
                { name = "TCV", name2 = L["风王子"], color = "00BFFF", fbId = 2804, type = "fb" },
                { name = "OLsod", name2 = L["黑龙"], color = "00BFFF", fbId = 249, type = "fb" },
                { name = "SC", name2 = L["蓝龙"], color = "00BFFF", fbId = 2791, type = "fb" },
                { name = "TTS", name2 = L["卡扎克"], color = "00BFFF", fbId = 2789, type = "fb" },
                { name = "Temple", color = "00BFFF", fbId = 109, type = "fb" },
                { name = "Gno", color = "00BFFF", fbId = 90, type = "fb" },
                { name = "BD", color = "00BFFF", fbId = 48, type = "fb" },
                -- 任务
                -- { name = "huiguweek", name2 = L["灰谷日常"], color = "FF8C00", type = "quest" },
                -- 专业
                { name = "alchemy", name2 = L["炼金转化"], color = "ADFF2F", type = "profession" },
                { name = "leatherworking", name2 = L["制皮筛盐"], color = "ADFF2F", type = "profession" },
                { name = "tailor", name2 = L["裁缝洗布"], color = "ADFF2F", type = "profession" },
            }

            BG.MONEYall_table = {
                { name = L["双倍经验"], color = "99ff99", type = "xp", id = "xp", tex = 1080931, width = 70 }, -- 双倍经验
                { name = L["褪色的安德麦雷亚尔"], color = "FF6600", type = "item", id = 226404, tex = 133799, width = 70 }, -- 荒野祭品
                { name = L["荒野祭品"], color = "98FB98", id = 221262, type = "item", tex = 132119, width = 70 }, -- 荒野祭品
                { name = L["白银戮币"], color = "E6E8FA", id = 221365, type = "item", id_gold = 221366, id_copper = 221364, tex = 237282, width = 70 }, -- 白银戮币
                { name = L["金币"], color = "FFD700", type = "money", id = "money", tex = 237618, width = 80 }, -- 金币
            }
        elseif BG.IsVanilla_60 then
            BG.FBCDall_table = {
                { name = "NAXX", name2 = L["纳克萨玛斯"], color = "00BFFF", fbId = 533, num = 40, type = "fb" },
                { name = "TAQ", name2 = L["安其拉"], color = "00BFFF", fbId = 531, num = 40, type = "fb" },
                { name = "AQL", name2 = L["废墟"], color = "00BFFF", fbId = 509, num = 20, type = "fb" },
                { name = "ZUG", name2 = L["祖格"], color = "00BFFF", fbId = 309, num = 20, type = "fb" },
                { name = "BWL", name2 = L["黑翼"], color = "00BFFF", fbId = 469, num = 40, type = "fb" },
                { name = "OL", name2 = L["黑龙"], color = "00BFFF", fbId = 249, num = 40, type = "fb" },
                { name = "MC", name2 = L["熔火之心"], color = "00BFFF", fbId = 409, num = 40, type = "fb" },
                -- 专业
                { name = "alchemy", name2 = L["炼金转化"], color = "ADFF2F", type = "profession" },
                { name = "leatherworking", name2 = L["制皮筛盐"], color = "ADFF2F", type = "profession" },
                { name = "tailor", name2 = L["裁缝洗布"], color = "ADFF2F", type = "profession" },
            }
            -- 声望
            BG.factionTbl = { 910, 609, 270, 749, 529, 59, 576, }
            for _, id in ipairs(BG.factionTbl) do
                tinsert(BG.FBCDall_table, { name = "faction" .. id, name2 = GetFactionInfoByID(id), id = id, color = "FFFF00", type = "faction" })
            end

            BG.MONEYall_table = {
                { name = L["双倍经验"], color = "99ff99", type = "xp", id = "xp", tex = 1080931, width = 70 }, -- 双倍经验
                { name = L["埃提耶什的碎片"], color = "ff8000", type = "item", id = 22726, quest = 9250, tex = 134888, width = 70 }, -- 橙片
                { name = L["金币"], color = "FFD700", type = "money", id = "money", tex = 237618, width = 80 }, -- 金币
            }
        elseif BG.IsWLK_80 then
            BG.FBCDall_table = {
                --WLK
                { name = "25RS", name2 = L["25红玉"], color = "FF4500", fbId = 724, num = 25, type = "fb" },
                { name = "10RS", name2 = L["10红玉"], color = "FF4500", fbId = 724, num = 10, type = "fb" },
                { name = "25ICC", name2 = L["25冰冠"], color = "9370DB", fbId = 631, num = 25, type = "fb" },
                { name = "10ICC", name2 = L["10冰冠"], color = "9370DB", fbId = 631, num = 10, type = "fb" },
                { name = "25TOC", name2 = L["25十字军"], color = "FF69B4", fbId = 649, num = 25, type = "fb" },
                { name = "10TOC", name2 = L["10十字军"], color = "FF69B4", fbId = 649, num = 10, type = "fb" },
                { name = "25OL", name2 = L["25黑龙"], color = "FFA500", fbId = 249, num = 25, type = "fb" },
                { name = "10OL", name2 = L["10黑龙"], color = "FFA500", fbId = 249, num = 10, type = "fb" },
                { name = "25ULD", name2 = L["25奥杜尔"], color = "00BFFF", fbId = 603, num = 25, type = "fb" },
                { name = "10ULD", name2 = L["10奥杜尔"], color = "00BFFF", fbId = 603, num = 10, type = "fb" },
                { name = "25NAXX", name2 = L["25纳克"], color = "32CD32", fbId = 533, num = 25, type = "fb" },
                { name = "10NAXX", name2 = L["10纳克"], color = "32CD32", fbId = 533, num = 10, type = "fb" },
                { name = "25EOE", name2 = L["25蓝龙"], color = "1E90FF", fbId = 616, num = 25, type = "fb" },
                { name = "10EOE", name2 = L["10蓝龙"], color = "1E90FF", fbId = 616, num = 10, type = "fb" },
                { name = "25OS", name2 = L["25黑曜石"], color = "8B4513", fbId = 615, num = 25, type = "fb" },
                { name = "10OS", name2 = L["10黑曜石"], color = "8B4513", fbId = 615, num = 10, type = "fb" },
                { name = "25VOA", name2 = L["25宝库"], color = "FFFF00", fbId = 624, num = 25, type = "fb" },
                { name = "10VOA", name2 = L["10宝库"], color = "FFFF00", fbId = 624, num = 10, type = "fb" },
                --TBC
                { name = "SW", name2 = L["太阳井"], color = "D3D3D3", fbId = 580, num = 25, type = "fb" },
                { name = "BT", name2 = L["黑庙"], color = "D3D3D3", fbId = 564, num = 25, type = "fb" },
                { name = "HS", name2 = L["海山"], color = "D3D3D3", fbId = 534, num = 25, type = "fb" },
                { name = "TK", name2 = L["风暴"], color = "D3D3D3", fbId = 550, num = 25, type = "fb" },
                { name = "SSC", name2 = L["毒蛇"], color = "D3D3D3", fbId = 548, num = 25, type = "fb" },
                { name = "GL", name2 = L["格鲁尔"], color = "D3D3D3", fbId = 565, num = 25, type = "fb" },
                { name = "ML", name2 = L["玛胖"], color = "D3D3D3", fbId = 544, num = 25, type = "fb" },
                { name = "ZA", name2 = L["祖阿曼"], color = "D3D3D3", fbId = 568, num = 10, type = "fb" },
                { name = "KZ", name2 = L["卡拉赞"], color = "D3D3D3", fbId = 532, num = 10, type = "fb" },
                { name = "PT", name2 = L["平台"], color = "D3D3D3", fbId = 585, num = 5, type = "fb" },
                { name = "STK", name2 = L["塞泰克"], color = "D3D3D3", fbId = 556, num = 5, type = "fb" },
                --CLASSIC
                { name = "TAQ", name2 = L["安其拉"], color = "D3D3D3", fbId = 531, num = 40, type = "fb" },
                { name = "AQL", name2 = L["废墟"], color = "D3D3D3", fbId = 509, num = 20, type = "fb" },
                { name = "ZUG", name2 = L["祖格"], color = "D3D3D3", fbId = 309, num = 20, type = "fb" },
                { name = "BWL", name2 = L["黑翼"], color = "D3D3D3", fbId = 469, num = 40, type = "fb" },
                { name = "MC", name2 = L["熔火之心"], color = "D3D3D3", fbId = 409, num = 40, type = "fb" },
                -- 日常
                { name = "week1", name2 = L["周常"], color = "FF8C00", type = "quest" },
                { name = "gamma", name2 = L["泰坦"], color = "FF8C00", type = "quest" },
                { name = "heroe", name2 = L["英雄"], color = "FF8C00", type = "quest" },
                { name = "zhubao", name2 = L["珠宝"], color = "FF8C00", type = "quest" },
                { name = "cooking", name2 = L["烹饪"], color = "FF8C00", type = "quest" },
                { name = "fish", name2 = L["钓鱼"], color = "FF8C00", type = "quest" },
                -- 专业
                { name = "alchemy_yanjiu", name2 = L["炼金研究"], color = "ADFF2F", type = "profession" },
                { name = "alchemy_zhuanhua", name2 = L["炼金转化"], color = "ADFF2F", type = "profession" },
                { name = "inscription_dadiaowen", name2 = L["大雕文"], color = "ADFF2F", type = "profession" },
                { name = "inscription_xiaodiaowen", name2 = L["小雕文"], color = "ADFF2F", type = "profession" },
                { name = "jewelcrafting_bingdonglingzhu", name2 = L["冰冻棱柱"], color = "ADFF2F", type = "profession" },
                { name = "forge_taitanjinggang", name2 = L["泰坦精钢"], color = "ADFF2F", type = "profession" },
                { name = "tailor_fawenbu", name2 = L["法纹布"], color = "ADFF2F", type = "profession" },
                { name = "tailor_wuwenbu", name2 = L["乌纹布"], color = "ADFF2F", type = "profession" },
                { name = "tailor_yueyingbu", name2 = L["月影布"], color = "ADFF2F", type = "profession" },
                { name = "tailor_bingchuanbeibao", name2 = L["冰川背包"], color = "ADFF2F", type = "profession" },
            }
            -- 声望
            BG.factionTbl = { 1156 }
            for _, id in ipairs(BG.factionTbl) do
                tinsert(BG.FBCDall_table, { name = "faction" .. id, name2 = GetFactionInfoByID(id), id = id, color = "FFFF00", type = "faction" })
            end

            BG.MONEYall_table = {
                { name = L["双倍经验"], color = "99ff99", type = "xp", id = "xp", tex = 1080931, width = 70 }, -- 双倍经验
                { name = L["影霜碎片"], color = "ff8000", type = "item", id = 50274, quest = 24548, tex = 340336, width = 70 }, -- 橙片
                { name = L["瓦兰奈尔碎片"], color = "ff8000", type = "item", id = 45038, quest = 13622, tex = "Interface/Icons/inv_ingot_titansteel_red", width = 70 }, -- 橙片
                { color = "00BFFF", id = 341, width = 70 }, -- 寒冰
                { color = "7B68EE", id = 301, width = 70 }, -- 凯旋
                { color = "FFFF00", id = 221, width = 70 }, -- 征服
                { color = "BA55D3", id = 102, width = 70 }, -- 勇气
                { color = "E6E6FA", id = 101, width = 70 }, -- 英雄
                { color = "00FF00", id = 2711, width = 70 }, -- 天灾石
                { color = "00FFFF", id = 2589, width = 70 }, -- 赛德精华
                { color = "FFFFFF", id = 241, width = 70 }, -- 冠军印章
                { color = "FFFFFF", id = 61, width = 70 }, -- 珠宝日常
                { color = "FFFFFF", id = 81, width = 70 }, -- 烹饪日常
                { color = "FFFFFF", id = 161, width = 70 }, -- 岩石守卫
                { color = "FFFFFF", id = 1900, width = 70 }, -- JJC
                { color = "FFFFFF", id = 1901, width = 70 }, -- 荣誉
                { color = "D3D3D3", id = 42, width = 70 }, -- TBC公正牌子
                { name = L["金币"], color = "FFD700", type = "money", id = "money", tex = 237618, width = 80 }, -- 金币
            }
        elseif BG.IsTitan then
            BG.FBCDall_table = {
                { name = "SSCtitan", name2 = L["毒蛇"], color = "00BFFF", fbId = 548, type = "fb" },
                { name = "TKtitan", name2 = L["风暴"], color = "00BFFF", fbId = 550, type = "fb" },
                { name = "MCtitan", name2 = L["熔火"], color = "00BFFF", fbId = 409, type = "fb" },
                { name = "VOAtitan", name2 = L["宝库"], color = "00BFFF", fbId = 624, type = "fb" },
                { name = "Doomwalker", name2 = L["末日行者"], color = "00BFFF", fbId = 119, type = "fb" },
                { name = "DoomLordKazzak", name2 = L["末日领主"], color = "00BFFF", fbId = 118, type = "fb" },
                { name = "Lanlongtitan", name2 = L["蓝龙"], color = "00BFFF", fbId = 116, type = "fb" },
                { name = "Kazaketitan", name2 = L["卡扎克"], color = "00BFFF", fbId = 117, type = "fb" },
                -- 日常
                { name = "week1", name2 = L["周常"], color = "FF8C00", type = "quest" },
                { name = "zhubao", name2 = L["珠宝"], color = "FF8C00", type = "quest" },
                { name = "cooking", name2 = L["烹饪"], color = "FF8C00", type = "quest" },
                { name = "fish", name2 = L["钓鱼"], color = "FF8C00", type = "quest" },
                { name = "holiday", name2 = L["节日本"], color = "FF8C00", type = "quest" },
                -- 专业
                { name = "alchemy_yanjiu", name2 = L["炼金研究"], color = "ADFF2F", type = "profession" },
                { name = "alchemy_zhuanhua", name2 = L["炼金转化"], color = "ADFF2F", type = "profession" },
                { name = "inscription_dadiaowen", name2 = L["大雕文"], color = "ADFF2F", type = "profession" },
                { name = "inscription_xiaodiaowen", name2 = L["小雕文"], color = "ADFF2F", type = "profession" },
                { name = "jewelcrafting_bingdonglingzhu", name2 = L["冰冻棱柱"], color = "ADFF2F", type = "profession" },
                { name = "forge_taitanjinggang", name2 = L["泰坦精钢"], color = "ADFF2F", type = "profession" },
                { name = "tailor_bingchuanbeibao", name2 = L["冰川背包"], color = "ADFF2F", type = "profession" },
            }
            -- 声望
            BG.factionTbl = {
                749,  -- 海达希亚水元素
                1119, -- 霍迪尔
                1098, -- 黑锋骑士团
                1106, -- 银色北伐军
                1090, -- 肯瑞托
                1091, -- 龙眠联军
                1104, -- 狂心氏族
                1105, -- 神谕者
                1073, -- 卡鲁亚克
            }
            for _, id in ipairs(BG.factionTbl) do
                local name3
                if id == 749 then
                    name3 = L["海达希亚"]
                end
                tinsert(BG.FBCDall_table, {
                    name = "faction" .. id,
                    name2 = GetFactionInfoByID(id),
                    name3 = name3,
                    id = id,
                    color = "FFFF00",
                    type = "faction"
                })
            end

            BG.MONEYall_table = {
                { name = L["双倍经验"], color = "99ff99", type = "xp", id = "xp", tex = 1080931, width = 70 }, -- 双倍经验
                { color = "ff8000", id = 3403, width = 100 }, -- 泰坦余烬
                { color = "7B68EE", id = 3406, width = 70 }, -- 泰坦碎片
                { color = "FFFFFF", id = 61, width = 70 }, -- 珠宝日常
                { color = "FFFFFF", id = 81, width = 70 }, -- 烹饪日常
                { color = "FFFFFF", id = 161, width = 70 }, -- 岩石守卫
                { color = "FFFFFF", id = 1900, width = 70 }, -- JJC
                { color = "FFFFFF", id = 1901, width = 70 }, -- 荣誉
                { name = L["金币"], color = "FFD700", type = "money", id = "money", tex = 237618, width = 80 }, -- 金币
            }
        elseif BG.IsCTM then
            BG.FBCDall_table = {
                -- CTM
                { name = "DS", name2 = GetRealZoneText(967), color = "9370DB", fbId = 967, type = "fb" },
                { name = "FL", name2 = GetRealZoneText(720), color = "FF4500", fbId = 720, type = "fb" },
                { name = "BOT", name2 = GetRealZoneText(671), color = "FFFF00", fbId = 671, type = "fb" },
                { name = "BWD", name2 = GetRealZoneText(669), color = "FF1493", fbId = 669, type = "fb" },
                { name = "TOF", name2 = GetRealZoneText(754), color = "87CEFA", fbId = 754, type = "fb" },
                { name = "25BH", name2 = "25" .. GetRealZoneText(757), color = "8B4513", fbId = 757, num = 25, type = "fb" },
                { name = "10BH", name2 = "10" .. GetRealZoneText(757), color = "8B4513", fbId = 757, num = 10, type = "fb" },
                --WLK
                { name = "25RS", name2 = L["25红玉"], color = "FF4500", fbId = 724, num = 25, type = "fb" },
                { name = "10RS", name2 = L["10红玉"], color = "FF4500", fbId = 724, num = 10, type = "fb" },
                { name = "25ICC", name2 = L["25冰冠"], color = "9370DB", fbId = 631, num = 25, type = "fb" },
                { name = "10ICC", name2 = L["10冰冠"], color = "9370DB", fbId = 631, num = 10, type = "fb" },
                { name = "25TOC", name2 = L["25十字军"], color = "FF69B4", fbId = 649, num = 25, type = "fb" },
                { name = "10TOC", name2 = L["10十字军"], color = "FF69B4", fbId = 649, num = 10, type = "fb" },
                { name = "25OL", name2 = L["25黑龙"], color = "FFA500", fbId = 249, num = 25, type = "fb" },
                { name = "10OL", name2 = L["10黑龙"], color = "FFA500", fbId = 249, num = 10, type = "fb" },
                { name = "25ULD", name2 = L["25奥杜尔"], color = "00BFFF", fbId = 603, num = 25, type = "fb" },
                { name = "10ULD", name2 = L["10奥杜尔"], color = "00BFFF", fbId = 603, num = 10, type = "fb" },
                { name = "25NAXX", name2 = L["25纳克"], color = "32CD32", fbId = 533, num = 25, type = "fb" },
                { name = "10NAXX", name2 = L["10纳克"], color = "32CD32", fbId = 533, num = 10, type = "fb" },
                { name = "25EOE", name2 = L["25蓝龙"], color = "1E90FF", fbId = 616, num = 25, type = "fb" },
                { name = "10EOE", name2 = L["10蓝龙"], color = "1E90FF", fbId = 616, num = 10, type = "fb" },
                { name = "25OS", name2 = L["25黑曜石"], color = "8B4513", fbId = 615, num = 25, type = "fb" },
                { name = "10OS", name2 = L["10黑曜石"], color = "8B4513", fbId = 615, num = 10, type = "fb" },
                { name = "25VOA", name2 = L["25宝库"], color = "FFFF00", fbId = 624, num = 25, type = "fb" },
                { name = "10VOA", name2 = L["10宝库"], color = "FFFF00", fbId = 624, num = 10, type = "fb" },
                --TBC
                { name = "SW", name2 = L["太阳井"], color = "D3D3D3", fbId = 580, num = 25, type = "fb" },
                { name = "BT", name2 = L["黑庙"], color = "D3D3D3", fbId = 564, num = 25, type = "fb" },
                { name = "HS", name2 = L["海山"], color = "D3D3D3", fbId = 534, num = 25, type = "fb" },
                { name = "TK", name2 = L["风暴"], color = "D3D3D3", fbId = 550, num = 25, type = "fb" },
                { name = "SSC", name2 = L["毒蛇"], color = "D3D3D3", fbId = 548, num = 25, type = "fb" },
                { name = "GL", name2 = L["格鲁尔"], color = "D3D3D3", fbId = 565, num = 25, type = "fb" },
                { name = "ML", name2 = L["玛胖"], color = "D3D3D3", fbId = 544, num = 25, type = "fb" },
                { name = "ZA", name2 = L["祖阿曼"], color = "D3D3D3", fbId = 568, num = 10, type = "fb" },
                { name = "KZ", name2 = L["卡拉赞"], color = "D3D3D3", fbId = 532, num = 10, type = "fb" },
                { name = "PT", name2 = L["平台"], color = "D3D3D3", fbId = 585, num = 5, type = "fb" },
                { name = "STK", name2 = L["塞泰克"], color = "D3D3D3", fbId = 556, num = 5, type = "fb" },
                --CLASSIC
                { name = "TAQ", name2 = L["安其拉"], color = "D3D3D3", fbId = 531, num = 40, type = "fb" },
                { name = "AQL", name2 = L["废墟"], color = "D3D3D3", fbId = 509, num = 20, type = "fb" },
                { name = "ZUG", name2 = L["祖格"], color = "D3D3D3", fbId = 309, num = 20, type = "fb" },
                { name = "BWL", name2 = L["黑翼"], color = "D3D3D3", fbId = 469, num = 40, type = "fb" },
                { name = "MC", name2 = L["熔火之心"], color = "D3D3D3", fbId = 409, num = 40, type = "fb" },
                -- 日常
                { name = "zhubao", name2 = L["珠宝"], color = "FF8C00", type = "quest" },
                { name = "cooking", name2 = L["烹饪"], color = "FF8C00", type = "quest" },
                { name = "fish", name2 = L["钓鱼"], color = "FF8C00", type = "quest" },
            }
            -- 声望
            BG.factionTbl = {
                1204, -- 海加尔复仇者
                1171, -- 塞拉赞恩
                1158, -- 海山
                1135, -- 大地之环
                1173, -- 拉穆卡恒
            }
            if BG.IsAlliance then
                tinsert(BG.factionTbl, 1177) -- 巴拉丁典狱官
                tinsert(BG.factionTbl, 1174) -- 蛮锤部族
            elseif BG.IsHorde then
                tinsert(BG.factionTbl, 1172) -- 龙吼氏族
                tinsert(BG.factionTbl, 1178) -- 地狱咆哮近卫军
            end
            for _, id in ipairs(BG.factionTbl) do
                tinsert(BG.FBCDall_table, { name = "faction" .. id, name2 = GetFactionInfoByID(id), id = id, color = "FFFF00", type = "faction" })
            end

            BG.MONEYall_table = {
                { name = L["双倍经验"], color = "99ff99", type = "xp", id = "xp", tex = 1080931, width = 70 }, -- 双倍经验
                { name = L["橙匕碎片"], color = "ff8000", type = "item", id2 = 77951, id = 77952, quest2 = 30107, quest = 30116, tex2 = 134101, tex = 458969, width = 70 }, -- 橙片
                { color = "BA55D3", id = 396, width = 70 }, -- 勇气点数
                { color = "00BFFF", id = 395, width = 70 }, -- 正义点数
                { color = "CC9966", id = 3281, width = 70 }, -- 裂隙石碎片P3
                { color = "CC6633", id = 3148, width = 70 }, -- 裂隙石碎片P2
                { color = "FFFFFF", id = 615, width = 70 }, -- 死亡之翼的堕落精华
                { color = "FFFFFF", id = 614, width = 70 }, -- 黑暗之尘
                { color = "FFFFFF", id = 361, width = 70 }, -- 珠宝日常
                { color = "FFFFFF", id = 81, width = 70 }, -- 烹饪日常
                { color = "FFFFFF", id = 515, width = 70 }, -- 暗月
                { color = "FFFFFF", id = 390, width = 70 }, -- 征服点数
                { color = "FFFFFF", id = 1901, width = 70 }, -- 荣誉点数
                { name = L["金币"], color = "FFD700", type = "money", id = "money", tex = 237618, width = 80 }, -- 金币
            }
        elseif BG.IsMOP then
            BG.FBCDall_table = {
                -- MOP
                { name = "TOT", name2 = GetRealZoneText(1098), color = "00ff00", fbId = 1098, type = "fb" },
                { name = "TES", name2 = GetRealZoneText(996), color = "00ff00", fbId = 996, type = "fb" },
                { name = "HOF", name2 = GetRealZoneText(1009), color = "00ff00", fbId = 1009, type = "fb" },
                { name = "MSV", name2 = GetRealZoneText(1008), color = "00ff00", fbId = 1008, type = "fb" },
                { name = "worldBoss4", name2 = L["乌达斯塔"], color = "99ff99", type = "worldBoss" },
                { name = "worldBoss3", name2 = L["暴风领主"], color = "99ff99", type = "worldBoss" },
                { name = "worldBoss2", name2 = L["怒之煞"], color = "99ff99", type = "worldBoss" },
                { name = "worldBoss1", name2 = L["炮舰"], color = "99ff99", type = "worldBoss" },
                -- CTM
                { name = "DS", name2 = GetRealZoneText(967), color = "9370DB", fbId = 967, type = "fb" },
                { name = "FL", name2 = GetRealZoneText(720), color = "FF4500", fbId = 720, type = "fb" },
                { name = "BOT", name2 = GetRealZoneText(671), color = "FFFF00", fbId = 671, type = "fb" },
                { name = "BWD", name2 = GetRealZoneText(669), color = "FF1493", fbId = 669, type = "fb" },
                { name = "TOF", name2 = GetRealZoneText(754), color = "87CEFA", fbId = 754, type = "fb" },
                { name = "25BH", name2 = "25" .. GetRealZoneText(757), color = "FFA500", fbId = 757, num = 25, type = "fb" },
                { name = "10BH", name2 = "10" .. GetRealZoneText(757), color = "FFA500", fbId = 757, num = 10, type = "fb" },
                --WLK
                { name = "25RS", name2 = L["25红玉"], color = "FF4500", fbId = 724, num = 25, type = "fb" },
                { name = "10RS", name2 = L["10红玉"], color = "FF4500", fbId = 724, num = 10, type = "fb" },
                { name = "25ICC", name2 = L["25冰冠"], color = "9370DB", fbId = 631, num = 25, type = "fb" },
                { name = "10ICC", name2 = L["10冰冠"], color = "9370DB", fbId = 631, num = 10, type = "fb" },
                { name = "25TOC", name2 = L["25十字军"], color = "FF69B4", fbId = 649, num = 25, type = "fb" },
                { name = "10TOC", name2 = L["10十字军"], color = "FF69B4", fbId = 649, num = 10, type = "fb" },
                { name = "25OL", name2 = L["25黑龙"], color = "FFA500", fbId = 249, num = 25, type = "fb" },
                { name = "10OL", name2 = L["10黑龙"], color = "FFA500", fbId = 249, num = 10, type = "fb" },
                { name = "25ULD", name2 = L["25奥杜尔"], color = "00BFFF", fbId = 603, num = 25, type = "fb" },
                { name = "10ULD", name2 = L["10奥杜尔"], color = "00BFFF", fbId = 603, num = 10, type = "fb" },
                { name = "25NAXX", name2 = L["25纳克"], color = "32CD32", fbId = 533, num = 25, type = "fb" },
                { name = "10NAXX", name2 = L["10纳克"], color = "32CD32", fbId = 533, num = 10, type = "fb" },
                { name = "25EOE", name2 = L["25蓝龙"], color = "1E90FF", fbId = 616, num = 25, type = "fb" },
                { name = "10EOE", name2 = L["10蓝龙"], color = "1E90FF", fbId = 616, num = 10, type = "fb" },
                { name = "25OS", name2 = L["25黑曜石"], color = "8B4513", fbId = 615, num = 25, type = "fb" },
                { name = "10OS", name2 = L["10黑曜石"], color = "8B4513", fbId = 615, num = 10, type = "fb" },
                { name = "25VOA", name2 = L["25宝库"], color = "FFFF00", fbId = 624, num = 25, type = "fb" },
                { name = "10VOA", name2 = L["10宝库"], color = "FFFF00", fbId = 624, num = 10, type = "fb" },
                --TBC
                { name = "SW", name2 = L["太阳井"], color = "D3D3D3", fbId = 580, num = 25, type = "fb" },
                { name = "BT", name2 = L["黑庙"], color = "D3D3D3", fbId = 564, num = 25, type = "fb" },
                { name = "HS", name2 = L["海山"], color = "D3D3D3", fbId = 534, num = 25, type = "fb" },
                { name = "TK", name2 = L["风暴"], color = "D3D3D3", fbId = 550, num = 25, type = "fb" },
                { name = "SSC", name2 = L["毒蛇"], color = "D3D3D3", fbId = 548, num = 25, type = "fb" },
                { name = "GL", name2 = L["格鲁尔"], color = "D3D3D3", fbId = 565, num = 25, type = "fb" },
                { name = "ML", name2 = L["玛胖"], color = "D3D3D3", fbId = 544, num = 25, type = "fb" },
                { name = "ZA", name2 = L["祖阿曼"], color = "D3D3D3", fbId = 568, num = 10, type = "fb" },
                { name = "KZ", name2 = L["卡拉赞"], color = "D3D3D3", fbId = 532, num = 10, type = "fb" },
                { name = "PT", name2 = L["平台"], color = "D3D3D3", fbId = 585, num = 5, type = "fb" },
                { name = "STK", name2 = L["塞泰克"], color = "D3D3D3", fbId = 556, num = 5, type = "fb" },
                --CLASSIC
                { name = "TAQ", name2 = L["安其拉"], color = "D3D3D3", fbId = 531, num = 40, type = "fb" },
                { name = "AQL", name2 = L["废墟"], color = "D3D3D3", fbId = 509, num = 20, type = "fb" },
                { name = "ZUG", name2 = L["祖格"], color = "D3D3D3", fbId = 309, num = 20, type = "fb" },
                { name = "BWL", name2 = L["黑翼"], color = "D3D3D3", fbId = 469, num = 40, type = "fb" },
                { name = "MC", name2 = L["熔火之心"], color = "D3D3D3", fbId = 409, num = 40, type = "fb" },
                -- 日常
                { name = "shoucai", name2 = L["收菜"], color = "FF8C00", type = "quest" },
                { name = "holiday", name2 = L["节日本"], color = "FF8C00", type = "quest" },
                -- 专业
                { name = "alchemy_huohuagang", name2 = L["炼金转化"], color = "ADFF2F", type = "profession" },
                { name = "enchanting_xieshashuijing", name2 = L["邪煞水晶"], color = "ADFF2F", type = "profession" },
                { name = "inscription_zhihuijuanzhou", name2 = L["智慧卷轴"], color = "ADFF2F", type = "profession" },
                { name = "jewelcrafting_yanjiu", name2 = L["珠宝研究"], color = "ADFF2F", type = "profession" },
                { name = "jewelcrafting_shenlongzhixin", name2 = L["神龙之心"], color = "ADFF2F", type = "profession" },
                { name = "forge_piligangding", name2 = L["霹雳钢锭"], color = "ADFF2F", type = "profession" },
                { name = "leatherworking_hualizhipi", name2 = L["华丽制皮"], color = "ADFF2F", type = "profession" },
                { name = "tailoring_diwangsichou", name2 = L["帝王丝绸"], color = "ADFF2F", type = "profession" },
            }
            -- 声望
            do
                BG.factionTbl = {
                    1359, -- 黑王子
                    1435, -- 影踪突袭营
                    1341, -- 至尊天神
                    1269, -- 金莲教
                    1270, -- 影踪派
                    1337, -- 卡拉克西
                    1271, -- 云端翔龙骑士团
                    1272, -- 阡陌客
                    1302, -- 垂钓翁
                    1345, -- 游学者
                }
                if BG.IsAlliance then
                    tinsert(BG.factionTbl, 3, 1376) -- 神盾守备军
                    tinsert(BG.factionTbl, 3, 1387) -- 肯瑞托远征军
                elseif BG.IsHorde then
                    tinsert(BG.factionTbl, 3, 1375) -- 统御先锋军
                    tinsert(BG.factionTbl, 3, 1388) -- 夺日者先锋军
                end
                for _, id in ipairs(BG.factionTbl) do
                    tinsert(BG.FBCDall_table, { name = "faction" .. id, name2 = GetFactionInfoByID(id), id = id, color = "FFFF00", type = "faction" })
                end
            end
            --[[
/dump C_CurrencyInfo.GetCurrencyInfo(697)
/dump C_CurrencyInfo.GetCurrencyInfo(396)
GameTooltip:SetCurrencyByID(697)
]]
            local name = "showCurrencyTop"
            BiaoGe.options[name] = BiaoGe.options[name] or 1
            BG.showCurrencyTop = BiaoGe.options[name] == 1

            BG.MONEYall_table = {
                { name = L["双倍经验"], color = "99ff99", type = "xp", id = "xp", tex = 1080931, width = 70 }, -- 双倍经验
                { color = "BA55D3", id = 396, width = BG.showCurrencyTop and 135 or 70 }, -- 勇气点数
                { color = "00BFFF", id = 395, width = 70 }, -- 正义点数
                { color = "00FFFF", id = 3414, width = 70 }, -- 至尊石碎块
                { color = "00FFFF", id = 3350, width = 70 }, -- 至尊石碎片
                { color = "FFD700", id = 752, width = BG.showCurrencyTop and 90 or 70 }, -- 魔古命运符文
                { color = "FFD700", id = 697, width = BG.showCurrencyTop and 90 or 70 }, -- 长者的好运符
                { color = "C0C0C0", id = 738, width = 70 }, -- 次级好运护符
                { color = "FFFFFF", id = 402, width = 70 }, -- 铁掌徽记
                { color = "FFFFFF", id = 515, width = 70 }, -- 暗月
                { color = "FFFFFF", id = 3407, width = 70 }, -- 白金硬币
                { color = "CC9933", id = 390, width = BG.showCurrencyTop and 135 or 70 }, -- 征服点数
                { color = "FFFFFF", id = 1901, width = 70 }, -- 荣誉点数
                { name = L["金币"], color = "FFD700", type = "money", id = "money", tex = 237618, width = 80 }, -- 金币
            }
        elseif BG.IsRetail then
            BG.FBCDall_table = {
                { name = "NP", name2 = L["王宫"], color = "00BFFF", fbId = 2657, num = 20, type = "fb" },
            }

            BG.MONEYall_table = {
                { name = L["金币"], color = "FFD700", id = "money", tex = 237618, width = 80 }, -- 金币
            }
        end
        for i, v in ipairs(BG.MONEYall_table) do
            if not v.type and type(v.id) == "number" then
                local info = C_CurrencyInfo.GetCurrencyInfo(v.id)
                if info then
                    BG.MONEYall_table[i].name = info.name
                    BG.MONEYall_table[i].tex = info.iconFileID
                    BG.MONEYall_table[i].type = "currency"
                end
            end
        end

        local fuc = C_TradeSkillUI.GetTradeSkillDisplayName
        local color = "ADFF2F"
        local color = "FF99FF"
        BG.SKILLall_table = {
            { name = "main", id = 0, name2 = L["主专业"], color = color, type = "skill", tex = "", width = 110 }, -- 主专业
            { name = "fish", id = 356, name2 = fuc(356), color = color, type = "skill", tex = 136245, width = 60 }, -- 钓鱼
            { name = "cook", id = 185, name2 = fuc(185), color = color, type = "skill", tex = 133971, width = 60 }, -- 烹饪
            { name = "heal", id = 129, name2 = fuc(129), color = color, type = "skill", tex = 135966, width = 60 }, -- 急救
        }
        if BG.verOver4 then
            tinsert(BG.SKILLall_table, 2,
                { name = "archaeology", id = 794, name2 = fuc(794), color = color, type = "skill", tex = 441139, width = 60 }) -- 考古
        end
    end

    -- 获取副本CD
    do
        local colorplayer = SetClassCFF(player, "player")
        local lastWorldBossText

        function BG.UpdateFBCD()
            local time = GetServerTime()
            local cd = {}
            local worldBossText = ""

            if UnitLevel("player") >= BG.fullLevel_RoleOverview then
                for i = 1, GetNumSavedInstances() do
                    local name, lockoutId, resettime, difficultyId, locked,
                    extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName,
                    numEncounters, encounterProgress, extendDisabled, instanceId =
                        GetSavedInstanceInfo(i)
                    if locked then
                        local a = {
                            player = player,
                            colorplayer = colorplayer,
                            fbId = instanceId,
                            num = maxPlayers,
                            resettime = resettime,
                            endtime = resettime + time
                        }
                        tinsert(cd, a)
                    end
                end
                if BG.IsTitan then
                    for i = 1, GetNumSavedWorldBosses() do
                        local name, bossID, resettime = GetSavedWorldBossInfo(i)
                        if bossID then
                            local a = {
                                player = player,
                                colorplayer = colorplayer,
                                fbId = bossID,
                                num = 0,
                                resettime = resettime,
                                endtime = resettime + time,
                                isWorldBoss = true,
                            }
                            tinsert(cd, a)
                            worldBossText = worldBossText .. bossID
                        end
                    end
                end
                if next(cd) then
                    BiaoGe[FBCD][realmID][player] = cd
                else
                    BiaoGe[FBCD][realmID][player] = {
                        {
                            player = player,
                            colorplayer = colorplayer,
                        }
                    }
                end
            elseif UnitLevel("player") < BG.fullLevel_RoleOverview then
                BiaoGe[FBCD][realmID][player] = nil
            end

            if BG.IsTitan then
                -- 1，没CD，刚打完BOSS变成有CD
                -- 2，原本就有CD
                if worldBossText ~= lastWorldBossText and IsInRaid(1) then
                    ns.SendMyWorldBossCD()
                end
                lastWorldBossText = worldBossText
            end

            -- 检查其他角色cd是否到期
            for _, db in pairs({ "BiaoGe", "BiaoGeAccounts" }) do
                if _G[db] and _G[db][FBCD] then
                    for realmID in pairs(_G[db][FBCD]) do
                        if type(realmID) == "number" and type(_G[db][FBCD][realmID]) == "table" then
                            local playerList = {}
                            for _player in pairs(_G[db][FBCD][realmID]) do
                                tinsert(playerList, _player)
                            end
                            for _, _player in ipairs(playerList) do
                                if _player ~= player then
                                    local yes
                                    local player0, colorplayer0
                                    for i = #_G[db][FBCD][realmID][_player], 1, -1 do
                                        local cd = _G[db][FBCD][realmID][_player][i]
                                        if cd and not player0 and not colorplayer0 then
                                            player0 = cd.player
                                            colorplayer0 = cd.colorplayer
                                        end
                                        if cd and cd.endtime then
                                            if time >= cd.endtime then
                                                tremove(_G[db][FBCD][realmID][_player], i)
                                            elseif time < cd.endtime then
                                                cd.resettime = cd.endtime - time
                                                yes = true
                                            end
                                        end
                                    end
                                    if not yes then
                                        _G[db][FBCD][realmID][_player] = {
                                            {
                                                player = player0,
                                                colorplayer = colorplayer0,
                                            }
                                        }
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        local f = CreateFrame("Frame")
        f.cd = nil
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:RegisterEvent("ENCOUNTER_END")
        f:RegisterEvent("CHAT_MSG_SYSTEM")
        f:SetScript("OnEvent", function(self, event, msg, _, _, _, success)
            if event == "PLAYER_ENTERING_WORLD" then
                self:UnregisterEvent("PLAYER_ENTERING_WORLD")
            end
            if event == "PLAYER_ENTERING_WORLD"
                or (event == "ENCOUNTER_END" and success == 1)
                or (event == "CHAT_MSG_SYSTEM" and msg == INSTANCE_SAVED) then
                if not self.cd then
                    self.cd = true
                    BG.After(0.5, function()
                        self.cd = nil
                        RequestRaidInfo()
                    end)
                end
            end
        end)

        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:RegisterEvent("ENCOUNTER_END")
        f:RegisterEvent("UPDATE_INSTANCE_INFO")
        f:SetScript("OnEvent", function(self, event, bossId, _, _, _, success)
            if event == "PLAYER_ENTERING_WORLD" then
                self:UnregisterEvent("PLAYER_ENTERING_WORLD")
            end
            if event ~= "ENCOUNTER_END" or (event == "ENCOUNTER_END" and success == 1) then
                BG.After(1, function()
                    BG.UpdateFBCD()
                    BG.GetLockoutID()
                end)
            end
        end)
    end

    -- 世界BOSS（MOP）
    BiaoGe.worldBossCD = BiaoGe.worldBossCD or {}
    BiaoGe.worldBossCD[realmID] = BiaoGe.worldBossCD[realmID] or {}
    BiaoGe.worldBossCD[realmID][player] = BiaoGe.worldBossCD[realmID][player] or {}
    if BG.IsMOP then
        local function SaveWorldBoss(bossIndex)
            local resetDay = 2
            if BG.IsCN() then
                resetDay = 4
            end

            local currentTimestamp = GetServerTime()
            local currentWeekday = date("%w", currentTimestamp)
            local daysToThursday = resetDay - currentWeekday
            local nextThursdayTimestamp

            local today = date("*t", currentTimestamp)
            -- 如果时间小于当天凌晨7点
            if daysToThursday == 0 and today.hour < 7 then
                today.hour = 7
                today.min = 0
                today.sec = 0
                nextThursdayTimestamp = time(today)
            else
                -- 如果已经是周四了，则日期+7
                if daysToThursday <= 0 then
                    daysToThursday = daysToThursday + 7
                end
                nextThursdayTimestamp = currentTimestamp + daysToThursday * 86400

                local nextThursdayDateTable = date("*t", nextThursdayTimestamp)
                nextThursdayDateTable.hour = 7
                nextThursdayDateTable.min = 0
                nextThursdayDateTable.sec = 0
                nextThursdayTimestamp = time(nextThursdayDateTable)
            end
            -- 计算时间差
            local secondsToNextThursday = nextThursdayTimestamp - currentTimestamp -- 距离下周四还有多少秒
            local timestamp = currentTimestamp + secondsToNextThursday             -- 到下周四的实际时间戳

            local colorplayer = SetClassCFF(player, "player")
            BiaoGe.worldBossCD[realmID][player]["worldBoss" .. bossIndex] = {
                name = "worldBoss" .. bossIndex,
                player = player,
                colorplayer = colorplayer,
                resettime = secondsToNextThursday,
                endtime = timestamp
            }
        end

        local function GetBossIsKill()
            if InCombatLockdown() then return end
            for bossIndex, questID in ipairs(BG.worldBossID) do
                if C_QuestLog.IsQuestFlaggedCompleted(questID) then
                    if not BiaoGe.worldBossCD[realmID][player]["worldBoss" .. bossIndex] then
                        SaveWorldBoss(bossIndex)
                    end
                else
                    BiaoGe.worldBossCD[realmID][player]["worldBoss" .. bossIndex] = nil
                end
            end
        end

        local function UpdateWorldBossEndTime()
            local time = GetServerTime()
            for _, db in pairs({ "BiaoGe", "BiaoGeAccounts" }) do
                if _G[db] and _G[db].worldBossCD then
                    for realmID in pairs(_G[db].worldBossCD) do
                        if type(realmID) == "number" and type(_G[db].worldBossCD[realmID]) == "table" then
                            for player in pairs(_G[db].worldBossCD[realmID]) do
                                local questList = {}
                                for questName in pairs(_G[db].worldBossCD[realmID][player]) do
                                    tinsert(questList, questName)
                                end
                                for _, questName in ipairs(questList) do
                                    local v = _G[db].worldBossCD[realmID][player][questName]
                                    if time < v.endtime then
                                        v.resettime = v.endtime - time
                                    else
                                        _G[db].worldBossCD[realmID][player][questName] = nil
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        BG.Init2(function()
            UpdateWorldBossEndTime()
        end)
        C_Timer.NewTicker(60, function()
            UpdateWorldBossEndTime()
        end)
        C_Timer.NewTicker(5, function()
            GetBossIsKill()
        end)
    elseif BG.IsTitan then
        local function GetBossIsKill()
            if InCombatLockdown() then return end
            local level = UnitLevel("player")
            local instanceID = select(8, GetInstanceInfo())
            if level >= BG.fullLevel and instanceID == 0 or instanceID == 1 or instanceID == 530 then
                RequestRaidInfo()
            end
        end
        C_Timer.NewTicker(5, function()
            GetBossIsKill()
        end)
    end

    -- 日常任务
    local holidayDungeonIDs = { 286, 285, 287, 288 } -- 火焰节、万圣节、美酒节、情人节
    do
        BiaoGe.QuestCD = BiaoGe.QuestCD or {}
        BiaoGe.QuestCD[realmID] = BiaoGe.QuestCD[realmID] or {}
        BiaoGe.QuestCD[realmID][player] = BiaoGe.QuestCD[realmID][player] or {}

        local function IsLearnSkill(skillID)
            return BiaoGe[MONEY][realmID][player].skill[skillID]
        end

        local function GetQuestSkillID(questName)
            return BG.dayQuests and BG.dayQuests[questName] and BG.dayQuests[questName].skillID
        end

        -- 日常
        if BG.IsVanilla_Sod then
            BG.dayQuests = {
                huiguweek = { questIDs = { 79090, 79098 }, }, -- 灰谷
            }
        elseif BG.IsWLK then
            BG.dayQuests = {
                zhubao = {
                    questIDs = { 12959, 12962, 12961, 12958, 12963, 12960 },
                    skillID = 755,
                },
                cooking = {
                    questIDs = { 13114, 13116, 13113, 13115, 13112, 13102, 13100, 13107, 13101, 13103 },
                    skillID = 185,
                },
                fish = {
                    questIDs = { 13836, 13833, 13834, 13832, 13830 },
                    skillID = 356,
                },
            }
            if BG.IsWLK_80 then
                BG.dayQuests.gamma = { questIDs = { 83717, 83713, 78752 } }
                BG.dayQuests.heroe = { questIDs = { 87379, 83714, 84552, 78753 } }
            end
        elseif BG.IsCTM then
            BG.dayQuests = {
                zhubao = {
                    questIDs = { 25156, 25161, 25159, 25158, 25162, 25160, 25154, 25155, 25105, 25157 },
                    skillID = 755,
                },
                cooking = {
                    questIDs = { 29316, 29352, 29314, 29356, 29351, 26190, 26153, 29313, 26183, 29362, 26192, 29358, 26235, 26233, 29333, 29334, 26177, 29318, 29364, 29365, 26234, 26220, 29357, 29363, 26226, 26227, 29332, 29315, 29353, 29355, 29360 },
                    skillID = 185,
                },
                fish = {
                    questIDs = { 26557, 29322, 29354, 29361, 26588, 29317, 26572, 29320, 29345, 29348, 29346, 26543, 29319, 26556, 29349, 26420, 29342, 26536, 29321, 29324, 29344, 29343, 29350, 29347, 29359, 26488, 29323, 29325, 26414, 26442 },
                    skillID = 356,
                },
            }
        end
        local function SaveDayQuest(questName, questID)
            local currentTimestamp = GetServerTime()
            local secondsUntilNext7am = BG.GetNextDayTime()
            local timestamp = currentTimestamp + secondsUntilNext7am

            local colorplayer = SetClassCFF(player, "player")
            BiaoGe.QuestCD[realmID][player][questName] = {
                name = questName,
                player = player,
                colorplayer = colorplayer,
                questID = questID,
                resettime = secondsUntilNext7am,
                endtime = timestamp,
            }
        end
        local function UpdateDayQuest(questID)
            if not BG.dayQuests then return end
            for questName in pairs(BG.dayQuests) do
                for _, _questID in pairs(BG.dayQuests[questName].questIDs) do
                    if _questID == questID then
                        SaveDayQuest(questName, questID)
                        return
                    end
                end
            end
        end

        -- 周常
        if BG.IsWLK then
            BG.weekQuests = {
                week1 = {
                    questIDs = { 24579, 24580, 24581, 24582, 24583, 24584, 24585, 24586, 24587, 24588, 24589, 24590,
                        93975, 94577, -- 时光服
                    }
                },
            }
        end
        local function SaveWeekQuest(questName, questID)
            local currentTimestamp = GetServerTime()
            local secondsToNextThursday = BG.GetNextWeekTime()         -- 距离下周四还有多少秒
            local timestamp = currentTimestamp + secondsToNextThursday -- 到下周四的实际时间戳

            local colorplayer = SetClassCFF(player, "player")
            BiaoGe.QuestCD[realmID][player][questName] = {
                name = questName,
                player = player,
                colorplayer = colorplayer,
                questID = questID,
                resettime = secondsToNextThursday,
                endtime = timestamp
            }
        end
        local function UpdateWeekQuest(questID)
            if not BG.weekQuests then return end
            for questName in pairs(BG.weekQuests) do
                for _, _questID in pairs(BG.weekQuests[questName].questIDs) do
                    if _questID == questID then
                        SaveWeekQuest(questName, questID)
                        return
                    end
                end
            end
        end

        -- MOP收菜
        if BG.IsMOP then
            -- 开垦：开始计时，收菜显示打勾
            -- 倒计时生效时，无视开垦
            -- 倒计时结束，回到第一步，收菜清除打勾
            BG.RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", function(self, event, ...)
                local unit, _, spellID = ...
                -- pt(...)
                if unit == "player" and (spellID == 111003 or spellID == 116357 or spellID == 139892) then -- 开垦和万能犁
                    SaveDayQuest("shoucai", 111003)
                end
            end)
        end

        -- 节日本
        local init
        function BG.InitHoliday()
            if init then return end
            init = true
            BG.RegisterEvent("LFG_COMPLETION_REWARD", function()
                local dungeonID = select(10, GetInstanceInfo())
                if dungeonID and BG.ValueInTable(holidayDungeonIDs, dungeonID) then
                    SaveDayQuest("holiday")
                end
            end)
        end

        -- 交任务时触发
        BG.RegisterEvent("QUEST_TURNED_IN", function(self, event, questID)
            UpdateDayQuest(questID)
            UpdateWeekQuest(questID)
        end)

        -- 检查全部角色的任务重置cd是否到期（日常是第二天凌晨7点）
        local function UpdateQuestEndTime()
            local time = GetServerTime()
            for _, db in pairs({ "BiaoGe", "BiaoGeAccounts" }) do
                if _G[db] and _G[db].QuestCD then
                    for realmID in pairs(_G[db].QuestCD) do
                        if type(realmID) == "number" and type(_G[db].QuestCD[realmID]) == "table" then
                            for player in pairs(_G[db].QuestCD[realmID]) do
                                local questList = {}
                                for questName in pairs(_G[db].QuestCD[realmID][player]) do
                                    tinsert(questList, questName)
                                end
                                for _, questName in ipairs(questList) do
                                    local v = _G[db].QuestCD[realmID][player][questName]
                                    if v.endtime and time < v.endtime then
                                        v.resettime = v.endtime - time
                                    else
                                        local skillID = GetQuestSkillID(questName)
                                        if skillID then
                                            -- 专业任务，加上notFinish标记，用于显示X
                                            _G[db].QuestCD[realmID][player][questName].endtime = nil
                                            _G[db].QuestCD[realmID][player][questName].resettime = nil
                                            _G[db].QuestCD[realmID][player][questName].notFinish = true
                                            -- 但如果自己没学这个专业了，则清空
                                            if BG.IsMe(realmID, player) and not IsLearnSkill(skillID) then
                                                _G[db].QuestCD[realmID][player][questName] = nil
                                            end
                                        else
                                            _G[db].QuestCD[realmID][player][questName] = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        -- 追溯已完成的任务
        local function CheckQuestsCompleted()
            if BG.dayQuests then
                for questName, v in pairs(BG.dayQuests) do
                    if not BiaoGe.QuestCD[realmID][player][questName] then
                        local skillID = v.skillID
                        if skillID and IsLearnSkill(skillID) then
                            BiaoGe.QuestCD[realmID][player][questName] = {
                                notFinish = true,
                            }
                        end
                    end
                    for _, _questID in pairs(BG.dayQuests[questName].questIDs) do
                        if C_QuestLog.IsQuestFlaggedCompleted(_questID) then
                            SaveDayQuest(questName, _questID)
                            break
                        end
                    end
                end
            end
            if BG.weekQuests then
                for questName in pairs(BG.weekQuests) do
                    if not BiaoGe.QuestCD[realmID][player][questName] then
                        for _, _questID in pairs(BG.weekQuests[questName].questIDs) do
                            if C_QuestLog.IsQuestFlaggedCompleted(_questID) then
                                SaveWeekQuest(questName, _questID)
                                break
                            end
                        end
                    end
                end
            end
        end

        BG.Init2(function()
            BG.After(3, function()
                CheckQuestsCompleted()
                UpdateQuestEndTime()
            end)
        end)
        C_Timer.NewTicker(60, function()
            UpdateQuestEndTime()
        end)
    end

    -- 专业技能CD
    do
        BiaoGe.tradeSkillCooldown = BiaoGe.tradeSkillCooldown or {}
        BiaoGe.tradeSkillCooldown[realmID] = BiaoGe.tradeSkillCooldown[realmID] or {}
        BiaoGe.tradeSkillCooldown[realmID][player] = BiaoGe.tradeSkillCooldown[realmID][player] or {}

        local tbl = {}
        if BG.IsVanilla then
            tbl = {
                alchemy = {
                    name = L["炼金转化"],
                    name2 = L["炼金术"],
                    spell = 17187 -- 转化奥金
                },
                leatherworking = {
                    name = L["制皮筛盐"],
                    name2 = L["制皮"],
                    spell = 19566 --筛盐
                },
                tailor = {
                    name = L["裁缝洗布"],
                    name2 = L["裁缝"],
                    spell = 18560 --月布
                    -- spell = 20600  -- test
                },
            }
        elseif BG.IsWLK then
            tbl = {
                alchemy_yanjiu = {
                    name = L["炼金研究"],
                    name2 = L["炼金术"],
                    spell = 60893
                },
                alchemy_zhuanhua = {
                    name = L["炼金转化"],
                    name2 = L["炼金术"],
                    spell = 66660
                },
                inscription_dadiaowen = {
                    name = L["大雕文"],
                    name2 = L["铭文"],
                    spell = 61177
                },
                inscription_xiaodiaowen = {
                    name = L["小雕文"],
                    name2 = L["铭文"],
                    spell = 61288
                },
                jewelcrafting_bingdonglingzhu = {
                    name = L["冰冻棱柱"],
                    name2 = L["珠宝加工"],
                    spell = 62242
                },
                forge_taitanjinggang = {
                    name = L["泰坦精钢"],
                    name2 = L["采矿"],
                    spell = 55208
                },
                tailor_fawenbu = {
                    name = L["法纹布"],
                    name2 = L["裁缝"],
                    spell = 56003
                },
                tailor_wuwenbu = {
                    name = L["乌纹布"],
                    name2 = L["裁缝"],
                    spell = 56002
                },
                tailor_yueyingbu = {
                    name = L["月影布"],
                    name2 = L["裁缝"],
                    spell = 56001
                },
                tailor_bingchuanbeibao = {
                    name = L["冰川背包"],
                    name2 = L["裁缝"],
                    spell = 56005
                },
            }
        elseif BG.IsMOP then
            tbl = {
                alchemy_huohuagang = {
                    name = L["炼金转化"],
                    name2 = L["炼金术"],
                    spell = 114780,
                },
                forge_piligangding = {
                    name = L["霹雳钢锭"],
                    name2 = L["锻造"],
                    spell = 138646
                },
                enchanting_xieshashuijing = {
                    name = L["邪煞水晶"],
                    name2 = L["附魔"],
                    spell = 116499
                },
                inscription_zhihuijuanzhou = {
                    name = L["智慧卷轴"],
                    name2 = L["铭文"],
                    spell = 112996
                },
                jewelcrafting_yanjiu = {
                    name = L["珠宝研究"],
                    name2 = L["珠宝加工"],
                    spell = 131686
                },
                jewelcrafting_shenlongzhixin = {
                    name = L["神龙之心"],
                    name2 = L["珠宝加工"],
                    spell = 62242
                },
                leatherworking_hualizhipi = {
                    name = L["华丽制皮"],
                    name2 = L["制皮"],
                    spell = 140040
                },
                tailoring_diwangsichou = {
                    name = L["帝王丝绸"],
                    name2 = L["裁缝"],
                    spell = 125557
                },
            }
        end

        local function GetCooldown()
            local time = GetServerTime()
            local getTime = GetTime()
            for profession, v in pairs(tbl) do
                local startTime, duration, cooldown
                if BG.IsRetail then
                    local info = C_Spell.GetSpellCooldown(v.spell)
                    startTime = info.startTime
                    duration = info.duration
                else
                    startTime, duration = GetSpellCooldown(v.spell)
                end
                startTime = startTime > getTime and (startTime - 2 ^ 32 / 1000) or startTime
                cooldown = startTime + duration - getTime
                if cooldown > 0 then
                    if BG.IsMOP then
                        cooldown = BG.GetNextDayTime()
                    end
                    BiaoGe.tradeSkillCooldown[realmID][player][profession] = {
                        class = select(2, UnitClass("player")),
                        resettime = cooldown,
                        endtime = cooldown + time,
                        ready = nil,
                    }
                end
            end
        end
        -- local _msg = TRADESKILL_LOG_FIRSTPERSON:gsub("%%s", "(.+)")
        -- BG.RegisterEvent("CHAT_MSG_TRADESKILLS", function(self, event, msg)
        --     if not strfind(msg, _msg) then return end
        --     GetCooldown()
        -- end)
        BG.RegisterEvent("SPELL_UPDATE_COOLDOWN", function(self, event)
            if not InCombatLockdown() then
                GetCooldown()
            end
        end)

        -- 检查其他角色cd是否到期
        local delay = 3
        local function UpdateProfessionCD()
            local time = GetServerTime()
            for _, db in pairs({ "BiaoGe", "BiaoGeAccounts" }) do
                if _G[db] and _G[db].tradeSkillCooldown then
                    for realmID in pairs(_G[db].tradeSkillCooldown) do
                        if type(realmID) == "number" and type(_G[db].tradeSkillCooldown[realmID]) == "table" then
                            for player in pairs(_G[db].tradeSkillCooldown[realmID]) do
                                for profession, v in pairs(_G[db].tradeSkillCooldown[realmID][player]) do
                                    if v.endtime then
                                        if time >= v.endtime then
                                            v.resettime = nil
                                            v.endtime = nil
                                            v.ready = true
                                            -- 限定只提醒当前账号是因为没办法删掉其他子账号的endtime，其他子账号会重复提醒
                                            if db == "BiaoGe" and BiaoGe.FBCDchoice[profession] and BiaoGe.FBCDchoice[profession] == 1 then
                                                local color
                                                if v.class then
                                                    color = select(4, GetClassColor(v.class))
                                                end
                                                local name = BG.IsMe(realmID, player) and L["我"] or player
                                                local colorName = color and "|c" .. color .. name .. "|r" or name
                                                local msg = BG.STC_g1(format(L["%s：%s已就绪！"], colorName, tbl[profession].name))
                                                BG.After(delay, function()
                                                    BG.SendSystemMessage(msg)
                                                    if BG["sound_" .. profession .. "Ready" .. BiaoGe.options.Sound] then
                                                        BG.PlaySound(profession .. "Ready")
                                                    else
                                                        PlaySoundFile("Interface\\AddOns\\BiaoGe\\Media\\sound\\other\\done.mp3", "Master")
                                                    end
                                                end)
                                                delay = delay + 3
                                            end
                                        elseif time < v.endtime then
                                            v.resettime = v.endtime - time
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        -- 检查专业技能是否忘记了，如果忘记了，则删掉对应的专业CD记录
        do
            local function CheckSkillIsForget()
                for profession, v in pairs(tbl) do
                    local isLearned
                    for i = 1, GetNumSkillLines() do
                        if GetSkillLineInfo(i) == v.name2 then
                            isLearned = true
                            break
                        end
                    end
                    if not isLearned then
                        BiaoGe.tradeSkillCooldown[realmID][player][profession] = nil
                    end
                end
            end
            BG.RegisterEvent("SKILL_LINES_CHANGED", function()
                BG.After(2, function()
                    CheckSkillIsForget()
                end)
            end)
        end

        BG.Init2(function()
            BG.After(2, function()
                GetCooldown()
                UpdateProfessionCD()
            end)
        end)
        C_Timer.NewTicker(19, function()
            UpdateProfessionCD()
        end)
    end

    -- 专业技能点数
    do
        local skillInfo = {
            [L["锻造"]] = { id = 164, icon = 136241, isMain = true },
            [L["工程学"]] = { id = 202, icon = 136243, isMain = true },
            [L["炼金术"]] = { id = 171, icon = 136240, isMain = true },
            [L["制皮"]] = { id = 165, icon = 133611, isMain = true },
            [L["裁缝"]] = { id = 197, icon = 136249, isMain = true },
            [L["附魔"]] = { id = 333, icon = 136244, isMain = true },
            [L["采矿"]] = { id = 186, icon = 136248, isMain = true },
            [L["草药学"]] = { id = 182, icon = 136065, isMain = true },
            [L["剥皮"]] = { id = 393, icon = 134366, isMain = true },
            [L["铭文"]] = { id = 773, icon = 237171, isMain = true },
            [L["珠宝加工"]] = { id = 755, icon = 134071, isMain = true },
            [L["考古学"]] = { id = 794, icon = 441139, isMain = nil },
            [L["钓鱼"]] = { id = 356, icon = 136245, isMain = nil },
            [L["烹饪"]] = { id = 185, icon = 133971, isMain = nil },
            [L["急救"]] = { id = 129, icon = 135966, isMain = nil },
        }
        local function UpdatetradeSkill()
            if SkillFrame and SkillFrame:IsVisible() then return end
            if WardrobeFrame and WardrobeFrame:IsVisible() then return end
            ExpandSkillHeader(0)
            local tbl = {}
            for i = 1, GetNumSkillLines() do
                local skillName, header, isExpanded, skillRank, numTempPoints, skillModifier,
                skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType,
                skillDescription = GetSkillLineInfo(i)
                if not header and skillInfo[skillName] then
                    local id = skillInfo[skillName].id
                    tbl[id] = {
                        level = skillRank,
                        icon = skillInfo[skillName].icon,
                        isMain = skillInfo[skillName].isMain,
                    }
                end
            end
            BiaoGe[MONEY][realmID][player].skill = tbl
        end

        BG.Init2(function()
            UpdatetradeSkill()
        end)
        C_Timer.NewTicker(5, function()
            UpdatetradeSkill()
        end)
    end

    -- 获取货币信息
    do
        function BG.MONEYupdate()
            local tbl = {}

            local player = BG.playerName
            tbl.player = player
            tbl.colorplayer = SetClassCFF(player, "player")
            tbl.skill = BiaoGe[MONEY][realmID][player].skill
            for i, v in ipairs(BG.MONEYall_table) do
                if v.type == "money" then
                    tbl.money = floor(GetMoney() / 1e4)
                elseif v.type == "item" then
                    local id = v.id
                    local tex = v.tex
                    if v.quest2 and not C_QuestLog.IsQuestFlaggedCompleted(v.quest2) then
                        id = v.id2
                        tex = v.tex2
                    end
                    local count = GetItemCount(id, true)
                    local questsCompleted
                    if v.quest and C_QuestLog.IsQuestFlaggedCompleted(v.quest) then
                        questsCompleted = true
                    end
                    tbl[v.id] = { count = count, tex = tex, isItem = true, quest = questsCompleted, }
                elseif v.type == "xp" then
                    tbl.xp = BiaoGe[MONEY][realmID][player].xp
                else
                    if BG.IsVanilla_Sod then
                        local count
                        if v.id_gold and v.id_copper then
                            count = GetItemCount(v.id_gold, true) * 100 + GetItemCount(v.id, true) + floor(GetItemCount(v.id_copper, true) / 100)
                        else
                            count = GetItemCount(v.id, true)
                        end
                        local tex = v.tex
                        tbl[v.id] = { count = count, tex = tex }
                    elseif not BG.IsVanilla then
                        local info = C_CurrencyInfo.GetCurrencyInfo(v.id)
                        if info then
                            local count = info.quantity
                            local tex = info.iconFileID
                            tbl[v.id] = {
                                count = count,
                                tex = tex,
                            }
                            local weekMax = info.maxWeeklyQuantity
                            if weekMax and weekMax > 0 then
                                local weekCount = info.quantityEarnedThisWeek
                                tbl[v.id].weekCount = weekCount
                                tbl[v.id].weekMax = weekMax
                                if weekCount >= weekMax then
                                    tbl[v.id].weekTimestamp = select(2, BG.GetNextWeekTime())
                                end
                            end
                            local totalMax = info.maxQuantity
                            if totalMax and totalMax > 0 then
                                if info.useTotalEarnedForMaxQty then
                                    local totalCount = info.totalEarned
                                    tbl[v.id].totalCount = totalCount
                                    tbl[v.id].totalMax = totalMax
                                    if totalCount >= totalMax then
                                        tbl[v.id].weekTimestamp = select(2, BG.GetNextWeekTime())
                                    end
                                else
                                    if count >= totalMax then
                                        tbl[v.id].isFull = true
                                    end
                                end
                            end
                        end
                    end
                end
            end
            BiaoGe[MONEY][realmID][player] = tbl
        end

        local function UpdateCD()
            local time = GetServerTime()
            for _, db in ipairs({ "BiaoGe", "BiaoGeAccounts" }) do
                if _G[db] and _G[db][MONEY] then
                    for realmID in pairs(_G[db][MONEY]) do
                        if type(realmID) == "number" and type(_G[db][MONEY][realmID]) == "table" then
                            for player in pairs(_G[db][MONEY][realmID]) do
                                for id, v in pairs(_G[db][MONEY][realmID][player]) do
                                    if type(v) == "table" and v.weekTimestamp and time >= v.weekTimestamp then
                                        _G[db][MONEY][realmID][player][id].weekTimestamp = nil
                                        if v.weekCount then
                                            _G[db][MONEY][realmID][player][id].weekCount = 0
                                        end
                                        if v.totalMax then
                                            _G[db][MONEY][realmID][player][id].totalMax = 0
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        -- 事件
        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
        f:RegisterEvent("PLAYER_MONEY")
        f:RegisterEvent("BAG_UPDATE_DELAYED")
        f:SetScript("OnEvent", function(self, event, ...)
            if event == "PLAYER_ENTERING_WORLD" then
                self:UnregisterEvent("PLAYER_ENTERING_WORLD")
                UpdateCD()
            end
            C_Timer.After(0.5, function()
                BG.MONEYupdate()
            end)
        end)
    end

    -- 获取双倍经验
    do
        -- 创建插件框架
        local race = select(2, UnitRace("player"))
        local isPanda = race == "Pandaren"
        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:RegisterEvent("PLAYER_XP_UPDATE")
        f:RegisterEvent("UPDATE_EXHAUSTION")
        f:RegisterEvent("PLAYER_LEVEL_UP")
        f:RegisterEvent("PLAYER_UPDATE_RESTING")
        f:SetScript("OnEvent", function(self, event)
            if event == "PLAYER_ENTERING_WORLD" then
                self:UnregisterEvent("PLAYER_ENTERING_WORLD")
            end
            local exhaustion = GetXPExhaustion() -- 获取剩余双倍经验值
            local per = 0
            if exhaustion then
                local maxXP = UnitXPMax("player")
                per = exhaustion / maxXP * 100
            end
            BiaoGe[MONEY][realmID][player].xp = {
                per = format("%.1f", per),
                perNow = format("%d", per),
                time = GetServerTime(),
                resting = IsResting(),
                isPanda = isPanda,
            }
        end)

        function BG.UpdateXP()
            local time = GetServerTime()
            local function Update(db)
                if not (db and db[MONEY]) then return end
                for realmID, v in pairs(db[MONEY]) do
                    if (type(realmID) == "number" and type(db[MONEY][realmID]) == "table") then
                        for player, v in pairs(db[MONEY][realmID]) do
                            if type(v.xp) == "table" then
                                local num = 4
                                if v.xp.resting then
                                    num = 1
                                end
                                local panda = 1
                                if v.xp.isPanda then
                                    panda = 0.5
                                end
                                v.xp.perNow = min(150, format("%d", tonumber(v.xp.per) + (time - v.xp.time) / (60 * 60 * 8 * num * panda) * 5))
                            end
                        end
                    end
                end
            end
            Update(BiaoGe)
            Update(BiaoGeAccounts)
        end
    end

    -- 牌子拾取增强
    do
        if BG.IsMOP then
            -- MOP在正义奖章和一袋岩石碎片里显示正义点数数量
            local itemIDs = {
                [395] = { 247796, 256883 },
                [3350] = { 248329 },
            }

            local function AddInfo(self)
                if BiaoGe.options["showCurrencyCount"] ~= 1 then return end
                local name, link = self:GetItem()
                if not link then return end
                local itemID = GetItemID(link)
                for currency, v in pairs(itemIDs) do
                    for _, _itemID in ipairs(v) do
                        if itemID == _itemID then
                            local info = C_CurrencyInfo.GetCurrencyInfo(currency)
                            local name = info.name
                            local count = info.quantity
                            local maxCount = info.maxQuantity
                            local tex = info.iconFileID
                            local quality = info.quality
                            local r, g, b = GetItemQualityColor(quality)
                            self:AddLine(" ")
                            self:AddLine("< BiaoGe >", 0, .75, 1)
                            if not info.useTotalEarnedForMaxQty then
                                self:AddDoubleLine(AddTexture(tex) .. name, BG.FormatNumber(count) .. "/" .. BG.FormatNumber(maxCount), r, g, b, 1, 1, 1)
                            else
                                local totalEarned = info.totalEarned
                                self:AddDoubleLine(AddTexture(tex) .. name,
                                    format(L["%s(总上限:%s/%s)"], count, BG.FormatNumber(totalEarned), BG.FormatNumber(maxCount)), r, g, b, 1, 1, 1)
                            end
                            self:Show()
                            return
                        end
                    end
                end
            end
            GameTooltip:HookScript("OnTooltipSetItem", AddInfo)
        end

        if not BG.IsVanilla then
            local text1 = LOOT_ITEM_PUSHED_SELF_MULTIPLE:gsub("%%s", "(.+)"):gsub("%%d", "(%%d+)")
            local text2 = LOOT_ITEM_PUSHED_SELF:gsub("%%s", "(.+)")
            local function func(self, event, msg, player, l, cs, t, flag, channelId, ...)
                if BiaoGe.options["showCurrencyCount"] ~= 1 then return end
                local link = strmatch(msg, text1)
                if not link then
                    link = strmatch(msg, text2)
                end
                if link then
                    local currencyID = link:match("currency:(%d+)")
                    if currencyID then
                        local info = C_CurrencyInfo.GetCurrencyInfo(tonumber(currencyID))
                        local maxCount = info.maxQuantity
                        local count = info.quantity
                        local color = "00BFFF"
                        local isFull
                        local newMsg
                        if not info.useTotalEarnedForMaxQty and maxCount > 0 then -- （2500/4000）例如正义点数
                            if count >= maxCount then
                                isFull = true
                                color = "FF0000"
                            end
                            newMsg = format(L["|cff%s（|cffffffff%s|r/%s）|r"], color,
                                BG.FormatNumber(count), BG.FormatNumber(maxCount))
                        else
                            local weekText = ""
                            if info.useTotalEarnedForMaxQty then -- MOP勇气点数
                                local totalEarned = info.totalEarned
                                if totalEarned >= maxCount then
                                    isFull = true
                                    color = "FF0000"
                                end
                                weekText = format(L["（总上限%s/%s）"],
                                    BG.FormatNumber(totalEarned), BG.FormatNumber(maxCount))
                            end
                            local weekMax = info.maxWeeklyQuantity -- 时光服泰坦余烬
                            if weekMax and weekMax > 0 then
                                local weekCount = info.quantityEarnedThisWeek
                                weekText = format(L["（本周%s/%s）"],
                                    BG.FormatNumber(weekCount), BG.FormatNumber(weekMax))
                                if weekCount >= weekMax then
                                    isFull = true
                                    color = "FF0000"
                                end
                            end
                            newMsg = format(L["|cff%s（|cffffffff%s|r）%s|r"], color, count, weekText)
                        end
                        if isFull then
                            BG.PlaySound("currencyfull")
                        end
                        return false, msg .. newMsg, player, l, cs, t, flag, channelId, ...
                    end
                end
            end
            ChatFrame_AddMessageEventFilter("CHAT_MSG_CURRENCY", func)
        end
    end

    -- 角色装备和装等
    do
        BiaoGe.equip = BiaoGe.equip or {}
        BiaoGe.equip[realmID] = BiaoGe.equip[realmID] or {}
        BiaoGe.equip[realmID][player] = BiaoGe.equip[realmID][player] or {}

        local ItemLevelPattern = gsub(ITEM_LEVEL, "%%d", "(%%d+)")
        local function GetItemLevelByTooltip(slot, link)
            BiaoGeTooltip4:SetOwner(UIParent, "ANCHOR_NONE")
            BiaoGeTooltip4:SetInventoryItem("player", slot)
            local text, level
            for i = 2, 5 do
                if _G[BiaoGeTooltip4:GetName() .. "TextLeft" .. i] then
                    text = _G[BiaoGeTooltip4:GetName() .. "TextLeft" .. i]:GetText() or ""
                    level = string.match(text, ItemLevelPattern)
                    if level then
                        return tonumber(level)
                    end
                end
            end
            level = select(4, GetItemInfo(link)) or 0
            return level
        end

        function BG.GetPlayerEquip()
            local tbl = BiaoGe.equip[realmID][player]
            wipe(tbl)
            for slot = 1, 19 do
                local link = GetInventoryItemLink("player", slot)
                if link then
                    local itemID = GetInventoryItemID("player", slot)
                    local quality = GetInventoryItemQuality("player", slot)
                    local level
                    if BG.IsMOP then
                        level = GetItemLevelByTooltip(slot, link)
                    else
                        level = select(4, GetItemInfo(link))
                    end
                    slot = tostring(slot)
                    tbl[slot] = {
                        link = link,
                        itemID = itemID,
                        quality = quality,
                        level = level,
                    }
                end
            end
        end

        local function GetPlayerAverageItemLevel()
            local _, avgLevel = GetAverageItemLevel()
            BiaoGe.playerInfo[realmID][player].iLevel = avgLevel or 0
            local avgLevel0 = Round(avgLevel, 0)
            -- 更新集结号密语装等
            if BG.isFullLevel and BG.MeetingHorn and BG.MeetingHorn.iLevelCheckButton then
                BG.MeetingHorn.iLevelCheckButton.Text:SetText(avgLevel0)
            end
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("UNIT_INVENTORY_CHANGED")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:SetScript("OnEvent", function(self, event, ...)
            if event == "PLAYER_ENTERING_WORLD" then
                self:UnregisterEvent("PLAYER_ENTERING_WORLD")
            end
            self.t = 0
            self:SetScript("OnUpdate", function(_, t)
                self.t = self.t + t
                if self.t > 1 then
                    self:SetScript("OnUpdate", nil)
                    BG.GetPlayerEquip()
                    GetPlayerAverageItemLevel()
                end
            end)
        end)
    end

    -- 一键排灵魂烘炉
    if not BG.IsVanilla then
        BiaoGe.lastChooseLFD = BiaoGe.lastChooseLFD or {}
        BiaoGe.lastChooseLFD[realmID] = BiaoGe.lastChooseLFD[realmID] or {}
        if BiaoGe.lastChooseLFD[realmID][player] and type(BiaoGe.lastChooseLFD[realmID][player]) ~= "table" then
            local type = BiaoGe.lastChooseLFD[realmID][player]
            BiaoGe.lastChooseLFD[realmID][player] = {
                type = type,
            }
        end
        BiaoGe.lastChooseLFD[realmID][player] = BiaoGe.lastChooseLFD[realmID][player] or {}
        BiaoGe.lastChooseLFD[realmID][player].dungeons = BiaoGe.lastChooseLFD[realmID][player].dungeons or {}

        local isOnClick

        local function OnClick(self)
            if self.type == "zhiding" then
                for i, id in ipairs(LFDDungeonList) do
                    if id < 0 then
                        LFGDungeonList_SetHeaderEnabled(1, id, false, LFDDungeonList, LFDHiddenByCollapseList)
                    end
                end
                LFGDungeonList_SetDungeonEnabled(self.dungeonID, true)
                LFDQueueFrame_SetType("specific")
                LFG_JoinDungeon(LE_LFG_CATEGORY_LFD, "specific", LFDDungeonList, LFDHiddenByCollapseList)
            elseif self.type == "jieri" then
                LFDQueueFrame_SetType(self.dungeonID)
                LFG_JoinDungeon(LE_LFG_CATEGORY_LFD, self.dungeonID, LFDDungeonList, LFDHiddenByCollapseList)
            end
            BG.PlaySound(1)
        end

        local function OnEnter(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
            GameTooltip:ClearLines()
            if self.dis then
                GameTooltip:AddLine(L["副本已锁定"], 1, 0, 0, true)
            else
                GameTooltip:AddLine(self.onEnterText, 1, 1, 1, true)
                GameTooltip:AddLine(BG.STC_dis(L["你可在插件设置-BiaoGe-其他功能里关闭这个功能"]), 1, 1, 1, true)
            end
            GameTooltip:Show()
        end

        local buttons = {}
        for i = 1, 2 do
            local bt = BG.CreateButton(PVEFrame)
            bt:SetSize(150, 23)
            bt:SetPoint("BOTTOMLEFT", 35, 5)
            if i == 1 then
                bt.type = "jieri"
                bt.tbl = holidayDungeonIDs
                -- bt.tbl = { 259 }           -- 燃烧的远征test
            elseif i == 2 then
                bt.type = "zhiding"
                if BG.IsWLK then
                    bt.tbl = { 2463, } --伽马灵魂烘炉。贝塔要塞2481（已删）
                    -- bt.tbl = { 136 }  -- 地狱火test
                else
                    bt.tbl = {}
                end
            end
            bt:Hide()
            bt:SetScript("OnClick", OnClick)
            bt:SetScript("OnEnter", OnEnter)
            bt:SetScript("OnLeave", GameTooltip_Hide)
            tinsert(buttons, bt)

            bt.disframe = CreateFrame("Frame", nil, bt)
            bt.disframe:SetAllPoints()
            bt.disframe.dis = true
            bt.disframe:SetScript("OnEnter", OnEnter)
            bt.disframe:SetScript("OnLeave", GameTooltip_Hide)
        end

        local function UpdateButtons()
            local isShowButton = {}
            for i = 1, 2 do
                buttons[i].name = nil
                for _, dungeonID in ipairs(buttons[i].tbl) do
                    local isAvailableForAll, isAvailableForPlayer, hideIfNotJoinable = IsLFGDungeonJoinable(dungeonID)
                    if isAvailableForPlayer then
                        local name = GetLFGDungeonInfo(dungeonID)
                        if dungeonID == 2481 then
                            name = L["贝塔"] .. name
                        end
                        buttons[i]:SetText(name)
                        buttons[i].onEnterText = format(L["一键指定%s"], name)
                        buttons[i].dungeonID = dungeonID
                        buttons[i].name = name
                        buttons[i]:Show()
                        tinsert(isShowButton, buttons[i])

                        local playerName, lockedReason, subReason1, subReason2, secondReasonID, secondReasonString = GetLFDLockInfo(dungeonID, 1)
                        if lockedReason ~= 0 then
                            buttons[i]:Disable()
                            buttons[i].disframe:Show()
                        else
                            buttons[i]:Enable()
                            buttons[i].disframe:Hide()
                        end
                        break
                    end
                end
                if not buttons[i].name then
                    buttons[i]:Hide()
                end
            end
            if #isShowButton == 1 then
                isShowButton[1]:SetSize(150, 23)
                isShowButton[1]:ClearAllPoints()
                isShowButton[1]:SetPoint("BOTTOMLEFT", 35, 5)
                BG.ButtonTextSetWordWrap(buttons[1])
            elseif #isShowButton == 2 then
                for i = 1, 2 do
                    buttons[i]:SetSize(90, 23)
                    buttons[i]:ClearAllPoints()
                    if i == 1 then
                        buttons[i]:SetPoint("BOTTOMLEFT", 15, 5)
                    else
                        buttons[i]:SetPoint("BOTTOMLEFT", 110, 5)
                    end
                    BG.ButtonTextSetWordWrap(buttons[i])
                end
            end
        end
        LFDQueueFrame:HookScript("OnShow", function(self)
            if BiaoGe.options["zhidingFB"] ~= 1 then
                for i, bt in ipairs(buttons) do
                    bt:Hide()
                end
                return
            end
            UpdateButtons()
            if BiaoGe.lastChooseLFD[realmID][player] then
                if BiaoGe.lastChooseLFD[realmID][player].type == "specific" then
                    LFDQueueFrame_SetType(BiaoGe.lastChooseLFD[realmID][player].type)
                    BG.After(0, function()
                        for i, id in ipairs(LFDDungeonList) do
                            if id < 0 then
                                LFGDungeonList_SetHeaderEnabled(1, id, false, LFDDungeonList, LFDHiddenByCollapseList)
                            end
                        end
                        for dungeonID, isChecked in pairs(BiaoGe.lastChooseLFD[realmID][player].dungeons) do
                            LFGDungeonList_SetDungeonEnabled(dungeonID, isChecked)
                        end
                        if LFDQueueFrameSpecificList_Update then
                            LFDQueueFrameSpecificList_Update()
                        end
                        LFDQueueFrame_UpdateRoleButtons()
                    end)
                else
                    for i = 1, GetNumRandomDungeons() do
                        local id, name = GetLFGRandomDungeonInfo(i)
                        local isAvailableForAll, isAvailableForPlayer, hideIfNotJoinable = IsLFGDungeonJoinable(id)
                        if isAvailableForPlayer then
                            if id == BiaoGe.lastChooseLFD[realmID][player].type then
                                LFDQueueFrame_SetType(BiaoGe.lastChooseLFD[realmID][player].type)
                                return
                            end
                        end
                    end
                end
            end
        end)
        hooksecurefunc("LFDQueueFrame_SetTypeInternal", function(value)
            -- pt(value)
            if PVEFrame:IsVisible() then
                BiaoGe.lastChooseLFD[realmID][player].type = value
            end
        end)

        hooksecurefunc("LFGDungeonList_SetDungeonEnabled", function(dungeonID, isChecked)
            -- pt(dungeonID)
            BG.After(0, function()
                if isOnClick then
                    BiaoGe.lastChooseLFD[realmID][player].dungeons[dungeonID] = isChecked
                end
            end)
        end)
        hooksecurefunc("LFGDungeonListCheckButton_OnClick", function(button, category, dungeonList, hiddenByCollapseList)
            isOnClick = true
            BG.After(0.01, function()
                isOnClick = false
            end)
            -- local parent = button:GetParent();
            -- local dungeonID = parent.id;
            -- local isChecked = button:GetChecked();
        end)
    end

    -- 团本锁定ID
    do
        local t = BG.FBMainFrame:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
        t:SetPoint("TOPLEFT", BG.MainFrame, 5, -30)
        t:SetTextColor(1, 1, 0)
        t:Hide()
        BG.TextLockoutID = t

        function BG.UpdateLockoutIDText(DT)
        end

        function BG.GetLockoutID()
            for i = 1, GetNumSavedInstances() do
                local name, lockoutID, resettime, difficultyId, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress, extendDisabled, instanceID =
                    GetSavedInstanceInfo(i)
                if locked and lockoutID then
                    local FB
                    for _FB, v in pairs(BG.instanceIDfromBossPosition) do
                        for _, _instanceID in pairs(BG.instanceIDfromBossPosition[_FB]) do
                            if instanceID == _instanceID then
                                FB = _FB
                                break
                            end
                        end
                        if FB then break end
                    end
                    if FB then
                        BiaoGe[FB].lockoutIDtbl = BiaoGe[FB].lockoutIDtbl or {}
                        BiaoGe[FB].lockoutIDtbl[instanceID] = {
                            instanceID = instanceID,
                            lockoutID = lockoutID,
                            realmID = realmID,
                        }
                    end
                end
            end
        end
    end

    -- 清理错误角色
    do
        for realmID, v in pairs(BiaoGe.playerInfo) do
            if type(realmID) == "number" and type(v) == "table" then
                if BiaoGe[MONEY][realmID] then
                    for player in pairs(BiaoGe.playerInfo[realmID]) do
                        if not BiaoGe[MONEY][realmID][player] then
                            BG.DeletePlayerData(realmID, player)
                        end
                    end
                else
                    BiaoGe.playerInfo[realmID] = nil
                    BiaoGe.equip[realmID] = nil
                end
            end
        end
        -- 删除角色总览旧角色
        local function DeleteOldData(db)
            for realmID, v in pairs(BiaoGe[db]) do
                if type(realmID) == "number" and type(v) == "table" then
                    if BiaoGe.playerInfo[realmID] then
                        for player in pairs(BiaoGe[db][realmID]) do
                            if not BiaoGe.playerInfo[realmID][player] then
                                BiaoGe[db][realmID][player] = nil
                            end
                        end
                    else
                        BiaoGe[db][realmID] = nil
                    end
                end
            end
        end
        DeleteOldData(FBCD)
        DeleteOldData(MONEY)
    end

    -- 删除重复角色装备数据
    for realmID, v in pairs(BiaoGe.equip) do
        if type(realmID) == "number" and type(v) == "table" then
            if BiaoGe.playerInfo[realmID] then
                for player in pairs(BiaoGe.equip[realmID]) do
                    if not BiaoGe.playerInfo[realmID][player] then
                        BiaoGe.equip[realmID][player] = nil
                    end
                end
            else
                BiaoGe.equip[realmID] = nil
            end
        end
    end
end

--[[
function()
    if not aura_env.last or aura_env.last < GetTime() - 2 then
        aura_env.last = GetTime()
        local bossIds = { Galleon = 32098, Sha = 32099, Nalak = 32518, Oondasta = 32519, Rukhmar = 37464}
        local label = "World Bosses: \n-------------\n"
        for name, id in pairs(bossIds) do
            label = label .. format("%s: %s", name, C_QuestLog.IsQuestFlaggedCompleted(id) and "\124cff00ff00Yes\124r" or "\124cffff0000No\124r") .. "\n"
        end
        aura_env.label = label
    end

    return aura_env.label
end
 ]]
