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

function BG.RoleOverviewUI()
    local fontsize = 13
    local fontsize2 = 14
    local fontsize3 = 15
    local fontsize0 = 12
    local r, g, b = GetClassRGB(nil, "player")

    -- 选择初始化
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
        elseif BG.IsWLK then
            BiaoGe.FBCDchoice = {
                ["25TOC"] = 1,
                ["10TOC"] = 1,
                ["25OL"] = 1,
                ["10OL"] = 1,
                ["25ULD"] = 1,
                ["10ULD"] = 1,
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
                [226404] = 1,
                [221262] = 1,
                [221365] = 1,
                ["money"] = 1,
            }
        elseif BG.IsWLK then
            BiaoGe.MONEYchoice = {
                -- [396] = 1,
                -- [395] = 1,
                -- [341] = 1,
                [301] = 1,
                [221] = 1,
                [102] = 1,
                [101] = 1,
                -- [2711] = 1, -- 天灾石
                [2589] = 1, -- 赛德精华
                ["money"] = 1,
            }
        elseif BG.IsCTM then
            BiaoGe.MONEYchoice = {
                [396] = 1,
                [395] = 1,
                ["money"] = 1,
            }
        elseif BG.IsRetail then
            BiaoGe.MONEYchoice = {
                ["money"] = 1,
            }
        end
    end
    -- 更新
    do
        if BG.IsVanilla then
            BG.Once("FBCDchoice", 240923, function()
                BiaoGe.FBCDchoice["BWLsod"] = 1
                BiaoGe.FBCDchoice["ZUGsod"] = 1
                BiaoGe.FBCDchoice["TCV"] = 1
                BiaoGe.FBCDchoice["Temple"] = nil
            end)
            BG.Once("MONEYchoice", 241101, function()
                BiaoGe.MONEYchoice[226404] = 1
            end)
        elseif BG.IsWLK then
            BG.Once("FBCDchoice", 250116, function()
                BiaoGe.FBCDchoice["25TOC"] = 1
                BiaoGe.FBCDchoice["10TOC"] = 1
                BiaoGe.FBCDchoice["25OL"] = 1
                BiaoGe.FBCDchoice["10OL"] = 1
                BiaoGe.FBCDchoice["25NAXX"] = nil
                BiaoGe.FBCDchoice["10NAXX"] = nil
                BiaoGe.FBCDchoice["25EOE"] = nil
                BiaoGe.FBCDchoice["10EOE"] = nil
                BiaoGe.FBCDchoice["25OS"] = nil
                BiaoGe.FBCDchoice["10OS"] = nil
            end)
            BG.Once("MONEYchoice", 250116, function()
                BiaoGe.MONEYchoice[301] = 1
                BiaoGe.MONEYchoice[2589] = 1
            end)
        elseif BG.IsCTM then
            BG.Once("FBCDchoice", 250405, function()
                BiaoGe.FBCDchoice["DS"] = 1
                BiaoGe.FBCDchoice["FL"] = 1
            end)
            BG.Once("FBCDchoice", 250407, function()
                BiaoGe.FBCDchoice["25BH"] = 1
                BiaoGe.FBCDchoice["10BH"] = 1
                BiaoGe.FBCDchoice["BH"] = nil
            end)
        end
    end
    -- 基础数据初始化
    do
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
                { name = "huiguweek", name2 = L["灰谷日常"], color = "FF8C00", type = "quest" },
                -- 专业
                { name = "alchemy", name2 = L["炼金转化"], color = "ADFF2F", type = "profession" },
                { name = "leatherworking", name2 = L["制皮筛盐"], color = "ADFF2F", type = "profession" },
                { name = "tailor", name2 = L["裁缝洗布"], color = "ADFF2F", type = "profession" },
            }

            BG.MONEYall_table = {
                { name = L["褪色的安德麦雷亚尔"], color = "FF6600", id = 226404, tex = 133799, width = 70 }, -- 荒野祭品
                { name = L["荒野祭品"], color = "98FB98", id = 221262, tex = 132119, width = 70 }, -- 荒野祭品
                { name = L["白银戮币"], color = "E6E8FA", id = 221365, id_gold = 221366, id_copper = 221364, tex = 237282, width = 70 }, -- 白银戮币
                { name = L["金币"], color = "FFD700", id = "money", tex = 237618, width = 90 }, -- 金币
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

            BG.MONEYall_table = {
                { name = L["金币"], color = "FFD700", id = "money", tex = 237618, width = 90 }, -- 金币
            }
        elseif BG.IsWLK then
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

            BG.MONEYall_table = {
                { name = C_CurrencyInfo.GetCurrencyInfo(341).name, color = "00BFFF", id = 341, tex = C_CurrencyInfo.GetCurrencyInfo(341).iconFileID, width = 70 }, -- 寒冰
                { name = C_CurrencyInfo.GetCurrencyInfo(301).name, color = "7B68EE", id = 301, tex = C_CurrencyInfo.GetCurrencyInfo(301).iconFileID, width = 70 }, -- 凯旋
                { name = C_CurrencyInfo.GetCurrencyInfo(221).name, color = "FFFF00", id = 221, tex = C_CurrencyInfo.GetCurrencyInfo(221).iconFileID, width = 70 }, -- 征服
                { name = C_CurrencyInfo.GetCurrencyInfo(102).name, color = "BA55D3", id = 102, tex = C_CurrencyInfo.GetCurrencyInfo(102).iconFileID, width = 70 }, -- 勇气
                { name = C_CurrencyInfo.GetCurrencyInfo(101).name, color = "E6E6FA", id = 101, tex = C_CurrencyInfo.GetCurrencyInfo(101).iconFileID, width = 70 }, -- 英雄
                { name = C_CurrencyInfo.GetCurrencyInfo(2711).name, color = "00FF00", id = 2711, tex = C_CurrencyInfo.GetCurrencyInfo(2711).iconFileID, width = 70 }, -- 天灾石
                { name = C_CurrencyInfo.GetCurrencyInfo(2589).name, color = "00FFFF", id = 2589, tex = C_CurrencyInfo.GetCurrencyInfo(2589).iconFileID, width = 70 }, -- 赛德精华
                { name = C_CurrencyInfo.GetCurrencyInfo(241).name, color = "FFFFFF", id = 241, tex = C_CurrencyInfo.GetCurrencyInfo(241).iconFileID, width = 70 }, -- 冠军印章
                { name = C_CurrencyInfo.GetCurrencyInfo(61).name, color = "FFFFFF", id = 61, tex = C_CurrencyInfo.GetCurrencyInfo(61).iconFileID, width = 70 }, -- 珠宝日常
                { name = C_CurrencyInfo.GetCurrencyInfo(81).name, color = "FFFFFF", id = 81, tex = C_CurrencyInfo.GetCurrencyInfo(81).iconFileID, width = 70 }, -- 烹饪日常
                { name = C_CurrencyInfo.GetCurrencyInfo(161).name, color = "FFFFFF", id = 161, tex = C_CurrencyInfo.GetCurrencyInfo(161).iconFileID, width = 70 }, -- 岩石守卫
                { name = C_CurrencyInfo.GetCurrencyInfo(1900).name, color = "FFFFFF", id = 1900, tex = C_CurrencyInfo.GetCurrencyInfo(1900).iconFileID, width = 85 }, -- JJC
                { name = C_CurrencyInfo.GetCurrencyInfo(1901).name, color = "FFFFFF", id = 1901, tex = C_CurrencyInfo.GetCurrencyInfo(1901).iconFileID, width = 85 }, -- 荣誉
                { name = C_CurrencyInfo.GetCurrencyInfo(42).name, color = "D3D3D3", id = 42, tex = C_CurrencyInfo.GetCurrencyInfo(42).iconFileID, width = 70 }, -- TBC公正牌子
                { name = L["金币"], color = "FFD700", id = "money", tex = 237618, width = 90 }, -- 金币
            }
        elseif BG.IsCTM then
            BG.FBCDall_table = {
                -- CTM
                { name = "DS", name2 = GetRealZoneText(967), color = "9370DB", fbId = 967, type = "fb" },
                { name = "FL", name2 = GetRealZoneText(720), color = "FF4500", fbId = 720, type = "fb" },
                { name = "BOT", name2 = GetRealZoneText(671), color = "FFFF00", fbId = 671, type = "fb" },
                { name = "BWD", name2 = GetRealZoneText(669), color = "FF1493", fbId = 669, type = "fb" },
                { name = "TOF", name2 = GetRealZoneText(754), color = "87CEFA", fbId = 754, type = "fb" },
                { name = "25BH", name2 = GetRealZoneText(757), color = "FFA500", fbId = 757, num = 25, type = "fb" },
                { name = "10BH", name2 = GetRealZoneText(757), color = "FFA500", fbId = 757, num = 10, type = "fb" },
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
            }

            BG.MONEYall_table = {
                { name = C_CurrencyInfo.GetCurrencyInfo(396).name, color = "BA55D3", id = 396, tex = C_CurrencyInfo.GetCurrencyInfo(396).iconFileID, width = 70 }, -- 勇气点数
                { name = C_CurrencyInfo.GetCurrencyInfo(395).name, color = "00BFFF", id = 395, tex = C_CurrencyInfo.GetCurrencyInfo(395).iconFileID, width = 70 }, -- 正义点数
                { name = C_CurrencyInfo.GetCurrencyInfo(390).name, color = "FF3333", id = 390, tex = C_CurrencyInfo.GetCurrencyInfo(390).iconFileID, width = 70 }, -- 征服
                { name = C_CurrencyInfo.GetCurrencyInfo(1901).name, color = "CC0033", id = 1901, tex = C_CurrencyInfo.GetCurrencyInfo(1901).iconFileID, width = 70 }, -- 荣誉
                { name = C_CurrencyInfo.GetCurrencyInfo(2711).name, color = "00FF00", id = 2711, tex = C_CurrencyInfo.GetCurrencyInfo(2711).iconFileID, width = 70 }, -- 天灾石
                { name = C_CurrencyInfo.GetCurrencyInfo(2589).name, color = "00FFFF", id = 2589, tex = C_CurrencyInfo.GetCurrencyInfo(2589).iconFileID, width = 70 }, -- 赛德精华
                { name = C_CurrencyInfo.GetCurrencyInfo(241).name, color = "FFFFFF", id = 241, tex = C_CurrencyInfo.GetCurrencyInfo(241).iconFileID, width = 70 }, -- 冠军印章
                { name = C_CurrencyInfo.GetCurrencyInfo(61).name, color = "FFFFFF", id = 61, tex = C_CurrencyInfo.GetCurrencyInfo(61).iconFileID, width = 70 }, -- 珠宝日常
                { name = C_CurrencyInfo.GetCurrencyInfo(81).name, color = "FFFFFF", id = 81, tex = C_CurrencyInfo.GetCurrencyInfo(81).iconFileID, width = 70 }, -- 烹饪日常
                { name = C_CurrencyInfo.GetCurrencyInfo(161).name, color = "FFFFFF", id = 161, tex = C_CurrencyInfo.GetCurrencyInfo(161).iconFileID, width = 70 }, -- 岩石守卫
                { name = C_CurrencyInfo.GetCurrencyInfo(1900).name, color = "FFFFFF", id = 1900, tex = C_CurrencyInfo.GetCurrencyInfo(1900).iconFileID, width = 85 }, -- JJC
                { name = L["金币"], color = "FFD700", id = "money", tex = 237618, width = 90 }, -- 金币
            }
        elseif BG.IsRetail then
            BG.FBCDall_table = {
                { name = "NP", name2 = L["王宫"], color = "00BFFF", fbId = 2657, num = 20, type = "fb" },
            }

            BG.MONEYall_table = {
                { name = L["金币"], color = "FFD700", id = "money", tex = 237618, width = 90 }, -- 金币
            }
        end
    end
    -- 角色总览UI
    local savePoint
    local function ShowAllServer()
        local isShiftKeyDown = IsShiftKeyDown()
        if BiaoGe.options.roleOverviewDefaultShow == "one" and isShiftKeyDown then
            return true
        end
        if BiaoGe.options.roleOverviewDefaultShow == "all" and not isShiftKeyDown then
            return true
        end
    end
    function BG.SetFBCD(self, position, click, refresh)
        if click then
            if BG.FBCDFrame then
                if BG.FBCDFrame.click and BG.FBCDFrame:IsVisible() and not refresh then
                    BG.FBCDFrame:Hide()
                    return
                end
                BG.FBCDFrame:Hide()
            end
        else
            if BG.FBCDFrame and BG.FBCDFrame.click and BG.FBCDFrame:IsVisible() then
                return
            end
        end
        BG.UpdateFBCD()

        local height = 20
        local width_jiange = 5
        local line_height = 4
        local FBCDchoice_table = {}
        local MONEYchoice_table = {}
        -- 根据你选择的副本，生成table
        for i, v in ipairs(BG.FBCDall_table) do
            for choicefbname, yes in pairs(BiaoGe.FBCDchoice) do
                if v.name == choicefbname then
                    tinsert(FBCDchoice_table, v)
                end
            end
        end
        tinsert(FBCDchoice_table, 1, { name = L["角色"] .. " " .. BG.STC_dis(L["(装等)"]), color = "FFFFFF" })
        -- 根据你选择的货币，生成table
        for i, v in ipairs(BG.MONEYall_table) do
            for id, yes in pairs(BiaoGe.MONEYchoice) do
                if v.id == id then
                    tinsert(MONEYchoice_table, v)
                end
            end
        end
        local nameWidth
        if ShowAllServer() then
            nameWidth = 165
        else
            nameWidth = 105
        end

        tinsert(MONEYchoice_table, 1, { name = L["角色"] .. " " .. BG.STC_dis("(" .. LEVEL .. ")"), color = "FFFFFF", width = nameWidth })
        -- 计算货币表格的总宽度
        local Moneywidth = 30
        for _, v in pairs(MONEYchoice_table) do
            Moneywidth = Moneywidth + v.width
        end

        local n = 1
        local totalwidth
        local FBCDwidth = 0
        -- 创建框体UI
        local f = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
        do
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 16,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.9)
            f:SetBackdropBorderColor(r, g, b)
            f:SetFrameLevel(100)
            f:SetSize(300, 100)
            f.lastPosition = position
            f.lastSelf = self
            if BiaoGe.options.scale then
                f:SetScale(BiaoGe.options.scale)
            end
            BG.FBCDFrame = f
            if click then
                f.click = true
                f:SetFrameStrata("HIGH")
                f:SetToplevel(true)
                f:SetClampedToScreen(false)
                f:EnableMouse(true)
                f:SetMovable(true)
                if savePoint then
                    f:SetPoint(unpack(savePoint))
                else
                    f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
                end
                f:SetScript("OnMouseUp", function(self)
                    self:StopMovingOrSizing()
                    savePoint = { self:GetPoint(1) }
                end)
                f:SetScript("OnMouseDown", function(self)
                    self:StartMoving()
                end)

                f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
                f.CloseButton:SetPoint("TOPRIGHT", f, "TOPRIGHT", BG.CloseButtonOffset, BG.CloseButtonOffset)

                local bt = CreateFrame("Button", nil, f)
                bt:SetSize(18, 18)
                bt:SetNormalTexture(851904)
                bt:SetHighlightTexture(851904)
                bt:SetPoint("TOPRIGHT", -35, -5)
                bt:RegisterForClicks("AnyUp")
                bt:SetScript("OnClick", function(self)
                    BG.PlaySound(1)
                    BG.SetFBCD(nil, nil, true, true)
                end)
            else
                f.click = nil
                f:SetFrameStrata("FULLSCREEN_DIALOG")
                f:SetClampedToScreen(true)
                f:EnableMouse(false)
                f:SetMovable(false)
                if position and position == "minimap" then
                    if BG.ButtonIsInRight(self) then
                        f:SetPoint("TOPRIGHT", self, "BOTTOMLEFT", 0, 0)
                    else
                        f:SetPoint("TOPLEFT", self, "BOTTOMRIGHT", 0, 0)
                    end
                else
                    f:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, 0)
                end
            end
        end

        local function SetEquipFrameFuc(bt, isAccounts, realmID, player, colorplayer, level, class, iLevel)
            if BGV and BGV.ShowEquipFrame then
                local r, g, b = GetClassColor(class)
                local tex = bt:CreateTexture()
                tex:SetPoint("CENTER")
                tex:SetSize(bt.width + 20, bt:GetHeight() - 5)
                tex:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
                tex:SetVertexColor(r, g, b)
                bt:SetHighlightTexture(tex)
                bt:SetScript("OnEnter", function(self)
                    BGV.ShowEquipFrame(nil, bt, isAccounts, realmID, player, colorplayer, level, class, iLevel)
                end)
                bt:SetScript("OnLeave", function(self)
                    if BGV.equipFrame and not BGV.equipFrame.click then
                        BGV.equipFrame:Hide()
                    end
                    GameTooltip:Hide()
                end)
                bt:SetScript("OnClick", function(self)
                    BGV.ShowEquipFrame(true, bt, isAccounts, realmID, player, colorplayer, level, class, iLevel)
                end)
            end
        end

        --------- 角色团本完成总览 ---------
        -- 大标题
        local FBCDTitle
        do
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, fontsize2, "OUTLINE")
            t:SetPoint("TOPLEFT", 15, -10 - (n - 1) * height)
            t:SetText(BG.STC_g1(L["< 角色团本完成总览 >"]))
            t:SetJustifyH("LEFT")
            t:SetWordWrap(false)
            FBCDTitle = t
            n = n + 1
            -- 设置重置时间
            local text3 = ""
            local text7 = ""
            local function IsSmallRaid(FBID)
                -- ZUG ZA AQL 黑暗深渊 诺莫瑞根 风暴悬崖 腐烂之痕 水晶谷
                local tbl = { 309, 568, 509, 48, 90, 2791, 2789, 2804 }
                if BG.IsVanilla_Sod then
                    tinsert(tbl, 249) -- 奥妮克希亚
                end
                for i, _FBID in ipairs(tbl) do
                    if FBID == _FBID then
                        return true
                    end
                end
            end
            for p, v in pairs(BiaoGe.FBCD[realmID]) do
                for i, cd in pairs(BiaoGe.FBCD[realmID][p]) do
                    if cd.resettime then
                        if IsSmallRaid(cd.fbId) then
                            text3 = format(L["小团本%s"], SecondsToTime(cd.resettime, true, nil, 2))
                        elseif cd.num ~= 5 then
                            text7 = SecondsToTime(cd.resettime, true, nil, 2)
                        end
                    end
                end
            end
            if text3 ~= "" or text7 ~= "" then
                local douhao = ""
                if text3 ~= "" and text7 ~= "" then
                    douhao = ", "
                end
                local resettext = format("|cff808080" .. L["（团本重置时间：%s）"] .. RR, text7 .. douhao .. text3)
                t:SetText(t:GetText() .. resettext)
            end
        end
        -- FB标题
        local text_table = {}
        local FBCDLineWidth
        do
            local right
            local lastwidth
            local nameWidth
            if ShowAllServer() then
                nameWidth = 200
            else
                nameWidth = 140
            end
            for i, v in ipairs(FBCDchoice_table) do
                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                if i == 1 then
                    t:SetPoint("TOPLEFT", f, "TOPLEFT", 15, -10 - height * n)
                elseif i == 2 then
                    t:SetPoint("TOPLEFT", f, "TOPLEFT", nameWidth, -10 - height * n)
                else
                    t:SetPoint("TOPLEFT", right, "TOPRIGHT", width_jiange, 0)
                end
                t:SetText("|cff" .. v.color .. (v.name2 or v.name):gsub("sod", "") .. RR)

                if i == 1 then
                    FBCDchoice_table[i].width = 15
                    lastwidth = FBCDchoice_table[i].width
                elseif i == 2 then
                    FBCDchoice_table[i].width = nameWidth
                    lastwidth = FBCDchoice_table[i].width
                else
                    FBCDchoice_table[i].width = lastwidth + right:GetWidth() + width_jiange
                    lastwidth = FBCDchoice_table[i].width
                end
                FBCDwidth = lastwidth + t:GetWidth() + 15
                right = t
                tinsert(text_table, t)
            end
            n = n + 1
            -- 比较团本CD和货币的总宽度哪个高，取出最大值
            if tonumber(FBCDwidth) > tonumber(Moneywidth) then
                totalwidth = FBCDwidth
            else
                totalwidth = Moneywidth
            end
            FBCDLineWidth = totalwidth - 5
            if BiaoGe.options.roleOverviewLayout == "left_right" then
                FBCDLineWidth = FBCDwidth - 10
                FBCDTitle:SetWidth(FBCDwidth - 20)  -- 标题设置宽度
            else
                FBCDTitle:SetWidth(totalwidth - 20) -- 标题设置宽度
            end

            local l = f:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("TOPLEFT", BG.FBCDFrame, 5, -10 - height * n + line_height)
            l:SetEndPoint("TOPLEFT", BG.FBCDFrame, FBCDLineWidth, -10 - height * n + line_height)
            l:SetThickness(1)
        end
        -- 角色CD
        do
            local newTbl = {}
            local function AddDB(db, isAccounts)
                if db and db.FBCD then
                    local function _AddDB(realmID)
                        if db.FBCD[realmID] then
                            for player, v in pairs(db.FBCD[realmID]) do
                                if not isAccounts or not (BiaoGe.FBCD[realmID] and BiaoGe.FBCD[realmID][player]) then
                                    local level = db.playerInfo[realmID] and db.playerInfo[realmID][player] and db.playerInfo[realmID][player].level
                                    if level and level >= BiaoGe.options["roleOverviewNotShowLevel"] then
                                        local class = db.playerInfo[realmID][player].class
                                        local iLevel = db.playerInfo[realmID][player].iLevel or (db.PlayerItemsLevel and db.PlayerItemsLevel[realmID] and db.PlayerItemsLevel[realmID][player])
                                        if class and iLevel and iLevel >= BiaoGe.options["roleOverviewNotShowiLevel"] then
                                            local colorplayer = "|c" .. select(4, GetClassColor(class)) .. player .. (isAccounts and "*" or "")
                                            tinsert(newTbl, {
                                                player = player,
                                                colorplayer = colorplayer,
                                                class = class,
                                                iLevel = iLevel,
                                                level = level,
                                                realmID = realmID,
                                                realmName = (db.realmName and db.realmName[realmID]) or BiaoGe.realmName[realmID] or realmID,
                                                isAccounts = isAccounts,
                                                tbl = BG.Copy(v)
                                            })
                                        end
                                    end
                                end
                            end
                        end
                    end

                    if ShowAllServer() then
                        for realmID, v in pairs(db.FBCD) do
                            if type(realmID) == "number" and type(v) == "table" then
                                _AddDB(realmID)
                            end
                        end
                    else
                        _AddDB(realmID)
                    end
                end
            end
            AddDB(BiaoGe)
            if not IsAltKeyDown() then
                AddDB(BiaoGeAccounts, true)
            end
            newTbl = BG.SortRoleOverview(newTbl)

            local num = 1
            for _, v in ipairs(newTbl) do
                local colorplayer = v.colorplayer
                local player = v.player
                local iLevel = v.iLevel
                local realmID = v.realmID
                local r, g, b, color = GetClassColor(v.class)
                -- 玩家名字
                local realmName
                if ShowAllServer() then
                    realmName = "|c" .. color .. v.realmName .. "-|r"
                else
                    realmName = ""
                end
                local bt = CreateFrame("Button", nil, BG.FBCDFrame)
                bt:SetPoint("TOPLEFT", BG.FBCDFrame, "TOPLEFT", FBCDchoice_table[1].width, -7 - height * n)
                local t = bt:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                t:SetPoint("LEFT")
                t:SetText(realmName .. colorplayer .. " |cff808080(" .. Round(iLevel, 0) .. ")|r")
                bt.width = t:GetWidth()
                bt.isFBCD = true
                bt:SetFontString(t)
                bt:SetSize(bt.width, 20)
                SetEquipFrameFuc(bt, v.isAccounts, realmID, player, colorplayer, v.level, v.class, v.iLevel)

                -- 副本CD
                for _, cd in pairs(v.tbl) do
                    for ii, vv in pairs(FBCDchoice_table) do
                        if (cd.fbId and (cd.fbId == vv.fbId)) and ((cd.num and (cd.num == vv.num)) or (not vv.num)) then
                            local tx = BG.FBCDFrame:CreateTexture(nil, "OVERLAY")
                            tx:SetSize(16, 16)
                            tx:SetPoint("CENTER", BG.FBCDFrame, "TOPLEFT",
                                (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                (-16 - height * n))
                            tx:SetTexture("interface/raidframe/readycheck-ready")
                        end
                    end
                end

                -- 日常
                if BiaoGe.QuestCD[realmID] and BiaoGe.QuestCD[realmID][player] then
                    for name in pairs(BiaoGe.QuestCD[realmID][player]) do
                        for ii, vv in ipairs(FBCDchoice_table) do
                            if name == vv.name then
                                local tx = BG.FBCDFrame:CreateTexture(nil, "OVERLAY")
                                tx:SetSize(16, 16)
                                tx:SetPoint("CENTER", BG.FBCDFrame, "TOPLEFT",
                                    (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                    (-16 - height * n))
                                tx:SetTexture("interface/raidframe/readycheck-ready")
                            end
                        end
                    end
                elseif BiaoGeAccounts and BiaoGeAccounts.QuestCD and BiaoGeAccounts.QuestCD[realmID] and BiaoGeAccounts.QuestCD[realmID][player] then
                    for name in pairs(BiaoGeAccounts.QuestCD[realmID][player]) do
                        for ii, vv in ipairs(FBCDchoice_table) do
                            if name == vv.name then
                                local tx = BG.FBCDFrame:CreateTexture(nil, "OVERLAY")
                                tx:SetSize(16, 16)
                                tx:SetPoint("CENTER", BG.FBCDFrame, "TOPLEFT",
                                    (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                    (-16 - height * n))
                                tx:SetTexture("interface/raidframe/readycheck-ready")
                            end
                        end
                    end
                    -- end
                end

                -- 专业
                if BiaoGe.tradeSkillCooldown[realmID] and BiaoGe.tradeSkillCooldown[realmID][player] then
                    for profession, v in pairs(BiaoGe.tradeSkillCooldown[realmID][player]) do
                        for ii, vv in ipairs(FBCDchoice_table) do
                            if profession == vv.name then
                                local t = f:CreateFontString()
                                t:SetPoint("CENTER", BG.FBCDFrame, "TOPLEFT",
                                    (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                    (-16 - height * n))
                                if v.ready then
                                    t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                                    t:SetTextColor(0, 1, 0)
                                    t:SetText(READY)
                                else
                                    t:SetFont(STANDARD_TEXT_FONT, fontsize0, "OUTLINE")
                                    t:SetTextColor(1, .82, 0)
                                    t:SetText(BG.SecondsToTime(v.resettime))
                                end
                            end
                        end
                    end
                elseif BiaoGeAccounts and BiaoGeAccounts.tradeSkillCooldown and BiaoGeAccounts.tradeSkillCooldown[realmID] and BiaoGeAccounts.tradeSkillCooldown[realmID][player] then
                    for profession, v in pairs(BiaoGeAccounts.tradeSkillCooldown[realmID][player]) do
                        for ii, vv in ipairs(FBCDchoice_table) do
                            if profession == vv.name then
                                local t = f:CreateFontString()
                                t:SetPoint("CENTER", BG.FBCDFrame, "TOPLEFT",
                                    (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                    (-16 - height * n))
                                if v.ready then
                                    t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                                    t:SetTextColor(0, 1, 0)
                                    t:SetText(READY)
                                else
                                    t:SetFont(STANDARD_TEXT_FONT, fontsize0, "OUTLINE")
                                    t:SetTextColor(1, .82, 0)
                                    t:SetText(BG.SecondsToTime(v.resettime))
                                end
                            end
                        end
                    end
                end
                n = n + 1

                if player == BG.GN() and realmID == GetRealmID() then
                    local l = f:CreateLine()
                    l:SetStartPoint("TOPLEFT", 5, -10 - height * (n - 0.5) + line_height)
                    l:SetEndPoint("TOPLEFT", FBCDLineWidth, -10 - height * (n - 0.5) + line_height)
                    l:SetThickness(height - 4)
                    l:SetColorTexture(r, g, b, .3)
                end

                local l = f:CreateLine()
                l:SetStartPoint("TOPLEFT", 5, -10 - height * n + line_height)
                l:SetEndPoint("TOPLEFT", FBCDLineWidth, -10 - height * n + line_height)
                l:SetThickness(1)
                l:SetColorTexture(RGB("808080", 1))
                num = num + 1
            end

            if num == 1 then
                local t = BG.FBCDFrame:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                t:SetPoint("TOPLEFT", BG.FBCDFrame, "TOPLEFT", FBCDchoice_table[1].width, -10 - height * n)
                t:SetText(BG.STC_dis(L["当前没有满级角色"]))
                n = n + 1
            end
        end

        --------- 角色货币总览 ---------
        -- 大标题
        local left = 15
        local moneyLineWidth = totalwidth - 5
        local allWidth = totalwidth
        do
            if BiaoGe.options.roleOverviewLayout == "left_right" then
                n = -1
                left = FBCDwidth
                moneyLineWidth = left - 5 + Moneywidth - 15
                allWidth = FBCDwidth + Moneywidth - 15
            end
            n = n + 1

            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, fontsize2, "OUTLINE")
            t:SetPoint("TOPLEFT", left, -10 - height * n)
            t:SetText(BG.STC_g1(L["< 角色货币总览 >"]))
            t:SetJustifyH("LEFT")
            t:SetWordWrap(false)
            if BiaoGe.options.roleOverviewLayout == "left_right" then
                t:SetWidth(Moneywidth - 20) -- 标题设置宽度
            else
                t:SetWidth(totalwidth - 20) -- 标题设置宽度
            end

            if not click then
                local accountsText = ""
                if BiaoGeAccounts then
                    accountsText = L["，长按ALT仅显示本账号角色"]
                end
                local tipsText
                if BiaoGe.options.roleOverviewDefaultShow == "one" then
                    tipsText = L["|cff808080（CTRL+左键固定显示，长按SHIFT显示全服务器角色%s）|r"]
                else
                    tipsText = L["|cff808080（CTRL+左键固定显示，长按SHIFT显示当前服务器角色%s）|r"]
                end
                t:SetText(t:GetText() .. format(tipsText, accountsText))
            end

            n = n + 2
        end

        local function GetCount(pz, id)
            local count
            if type(pz[id]) == "table" then -- 牌子
                if pz[id].isNotKnow then
                    count = L["未知"]
                else
                    count = tonumber(pz[id].count) or 0
                end
            else
                count = tonumber(pz[id]) or 0 -- 金币
            end
            return count
        end
        local copyTbl1 = {} -- 用于复制数据
        local copyTbl2 = {}
        local sum = {}
        do
            -- 初始化数据
            local function DefaultDB(db, copyTbl)
                if db and db.Money then
                    local function _AddDB(realmID)
                        if db.Money[realmID] then
                            copyTbl[realmID] = copyTbl[realmID] or {}
                            for player, vv in pairs(db.Money[realmID]) do
                                copyTbl[realmID][player] = BG.Copy(vv)
                                for i, v in ipairs(MONEYchoice_table) do
                                    if tonumber(v.id) and not copyTbl[realmID][player][v.id] then -- 牌子，给空值设为0，主要是为了填补一些旧角色缺少某些新数据
                                        copyTbl[realmID][player][v.id] = {
                                            count = 0,
                                            tex = BG.IsVanilla and v.tex or C_CurrencyInfo.GetCurrencyInfo(v.id).iconFileID,
                                            isNotKnow = true
                                        }
                                    elseif v.id == "money" and not copyTbl[realmID][player][v.id] then -- 如果是金币
                                        copyTbl[realmID][player][v.id] = 0
                                    end
                                end
                                if not copyTbl[realmID][player].player then
                                    copyTbl[realmID][player].player = player
                                end
                                if not copyTbl[realmID][player].colorplayer then
                                    copyTbl[realmID][player].colorplayer = BG.STC_dis(player)
                                end
                            end
                        end
                    end

                    if ShowAllServer() then
                        for realmID, v in pairs(db.Money) do
                            if type(realmID) == "number" and type(v) == "table" then
                                _AddDB(realmID)
                            end
                        end
                    else
                        _AddDB(realmID)
                    end
                end
            end
            DefaultDB(BiaoGe, copyTbl1)
            if not IsAltKeyDown() then
                DefaultDB(BiaoGeAccounts, copyTbl2)
            end
        end
        -- 货币标题
        do
            local right
            for i, v in ipairs(MONEYchoice_table) do
                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                if i == 1 then
                    t:SetPoint("TOPLEFT", left, -10 - height * n)
                    t:SetJustifyH("LEFT")
                else
                    local width
                    if i == 2 then
                        width = MONEYchoice_table[i - 1].width + MONEYchoice_table[i].width
                        t:SetPoint("TOPRIGHT", right, "TOPLEFT", width, 0)
                    else
                        width = MONEYchoice_table[i].width
                        t:SetPoint("TOPRIGHT", right, "TOPRIGHT", width, 0)
                    end
                    t:SetJustifyH("RIGHT")
                end
                t:SetText(v.name)
                t:SetTextColor(RGB(v.color))
                t:SetWidth(MONEYchoice_table[i].width - 10)
                t:SetWordWrap(false)

                right = t
            end
            n = n + 1
            local l = f:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("TOPLEFT", BG.FBCDFrame, left - 10, -10 - height * n + line_height)
            l:SetEndPoint("TOPLEFT", BG.FBCDFrame, moneyLineWidth, -10 - height * n + line_height)
            l:SetThickness(1)
        end
        -- 角色货币
        do
            local newTbl = {}

            local function AddDB(db, copyTbl, isAccounts)
                for realmID in pairs(copyTbl) do
                    for player, v in pairs(copyTbl[realmID]) do
                        if not isAccounts or not (BiaoGe.Money[realmID] and BiaoGe.Money[realmID][player]) then
                            local level = db.playerInfo[realmID] and db.playerInfo[realmID][player] and db.playerInfo[realmID][player].level
                            if (level and level >= BiaoGe.options["roleOverviewNotShowLevel"]) then
                                local class = db.playerInfo[realmID][player].class
                                local iLevel = db.playerInfo[realmID][player].iLevel or (db.PlayerItemsLevel and db.PlayerItemsLevel[realmID] and db.PlayerItemsLevel[realmID][player])
                                if class and iLevel and iLevel >= BiaoGe.options["roleOverviewNotShowiLevel"] then
                                    local colorplayer = "|c" .. select(4, GetClassColor(class)) .. player .. (isAccounts and "*" or "")
                                    tinsert(newTbl, {
                                        player = player,
                                        colorplayer = colorplayer,
                                        class = class,
                                        iLevel = iLevel,
                                        level = level,
                                        realmID = realmID,
                                        realmName = (db.realmName and db.realmName[realmID]) or BiaoGe.realmName[realmID] or realmID,
                                        isAccounts = isAccounts,
                                        tbl = v
                                    })
                                end
                            end
                        end
                    end
                end
            end
            AddDB(BiaoGe, copyTbl1)
            AddDB(BiaoGeAccounts, copyTbl2, true)
            newTbl = BG.SortRoleOverview(newTbl)

            -- 计算合计
            for ii in ipairs(newTbl) do
                local pz = newTbl[ii].tbl
                for i = 2, #MONEYchoice_table do
                    local id = MONEYchoice_table[i].id
                    sum[id] = sum[id] or 0
                    sum[id] = sum[id] + (tonumber(GetCount(pz, id)) or 0)
                end
            end

            for _, v in ipairs(newTbl) do
                local colorplayer = v.colorplayer
                local player = v.player
                local level = v.level
                local realmID = v.realmID
                local r, g, b, color = GetClassColor(v.class)
                local right
                -- 名字
                local realmName
                if ShowAllServer() then
                    realmName = "|c" .. color .. v.realmName .. "-|r"
                else
                    realmName = ""
                end

                local levelText = ""
                if level then levelText = BG.STC_dis(" (" .. level .. ")") end

                local bt = CreateFrame("Button", nil, BG.FBCDFrame)
                bt:SetPoint("TOPLEFT", BG.FBCDFrame, "TOPLEFT", left, -7 - height * n)
                local t = bt:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                t:SetPoint("LEFT")
                t:SetText(realmName .. colorplayer .. levelText)
                bt.width = t:GetWidth()
                bt.isMoney = true
                bt:SetFontString(t)
                bt:SetSize(bt.width, 20)
                right = bt
                SetEquipFrameFuc(bt, v.isAccounts, realmID, player, colorplayer, v.level, v.class, v.iLevel)

                -- 牌子
                local pz = v.tbl
                for ii = 2, #MONEYchoice_table do
                    local vv = MONEYchoice_table[ii]
                    local id = vv.id
                    local count = GetCount(pz, id)
                    count = tostring(count):gsub("-", "") .. " " .. AddTexture(vv.tex)
                    local t_paizi = f:CreateFontString()
                    t_paizi:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                    local width
                    if ii == 2 then
                        width = MONEYchoice_table[ii - 1].width + MONEYchoice_table[ii].width
                        t_paizi:SetPoint("RIGHT", right, "LEFT", width, 0)
                    else
                        width = MONEYchoice_table[ii].width
                        t_paizi:SetPoint("TOPRIGHT", right, "TOPRIGHT", width, 0)
                    end
                    t_paizi:SetText(count)
                    if count:match("^%d+") == "0" or count:find(L["未知"]) then
                        t_paizi:SetTextColor(0.5, 0.5, 0.5)
                    end
                    right = t_paizi
                end
                n = n + 1

                if player == BG.GN() and realmID == GetRealmID() then
                    local l = f:CreateLine()
                    l:SetStartPoint("TOPLEFT", BG.FBCDFrame, left - 10, -10 - height * (n - 0.5) + line_height)
                    l:SetEndPoint("TOPRIGHT", BG.FBCDFrame, -5, -10 - height * (n - 0.5) + line_height)
                    l:SetThickness(height - 4)
                    l:SetColorTexture(r, g, b, .3)
                end

                local l = f:CreateLine()
                l:SetStartPoint("TOPLEFT", BG.FBCDFrame, left - 10, -10 - height * n + line_height)
                l:SetEndPoint("TOPLEFT", BG.FBCDFrame, moneyLineWidth, -10 - height * n + line_height)
                l:SetThickness(1)
                l:SetColorTexture(RGB("808080", 1))
            end

            do -- 合计
                if Size(copyTbl1) ~= 0 then
                    local right
                    local t_name = f:CreateFontString()
                    t_name:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                    t_name:SetPoint("TOPLEFT", left, -10 - height * n)
                    t_name:SetText(L["合计"])
                    right = t_name

                    for ii = 2, #MONEYchoice_table do
                        local vv = MONEYchoice_table[ii]
                        local id = vv.id
                        local count = GetCount(sum, id) .. " " .. AddTexture(vv.tex) -- 牌子
                        local t_paizi = f:CreateFontString()
                        t_paizi:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                        local width
                        if ii == 2 then
                            width = MONEYchoice_table[ii - 1].width + MONEYchoice_table[ii].width
                            t_paizi:SetPoint("TOPRIGHT", right, "TOPLEFT", width, 0)
                        else
                            width = MONEYchoice_table[ii].width
                            t_paizi:SetPoint("TOPRIGHT", right, "TOPRIGHT", width, 0)
                        end
                        t_paizi:SetText(count)
                        if count:match("^%d+") == "0" then
                            t_paizi:SetTextColor(0.5, 0.5, 0.5)
                        end
                        right = t_paizi
                    end
                    n = n + 1
                end
            end
        end
        f:SetSize(allWidth, 10 + height * n + 5)
    end

    function BG.SortRoleOverview(newTbl)
        local isVIP
        if BiaoGe.options["roleOverviewSort1"] == "vip" then
            isVIP = true
        end
        sort(newTbl, function(a, b)
            if ShowAllServer() then
                local a_val = a.realmID
                local b_val = b.realmID
                if a_val ~= b_val then
                    if a_val == realmID then
                        return true
                    elseif b_val == realmID then
                        return false
                    end
                    return a_val > b_val
                end
            end

            if not isVIP then
                local s = BiaoGe.options["roleOverviewSort1"]
                local tbl = { strsplit("-", s) }
                for _, key in ipairs(tbl) do
                    if a[key] and b[key] then
                        if a[key] ~= b[key] then
                            return a[key] > b[key]
                        end
                    end
                end
            end
            return false
        end)
        if isVIP and BG.BiaoGeVIPVerNum and BG.BiaoGeVIPVerNum >= 10140 then
            local tbl = {}
            for _, vv in ipairs(BiaoGeVIP.RoleOverviewSort[realmID]) do
                for i, v in ipairs(newTbl) do
                    if v.realmID == realmID and v.player == vv.player then
                        tinsert(tbl, v)
                        tremove(newTbl, i)
                        break
                    end
                end
            end
            if ShowAllServer() then
                for i, v in ipairs(newTbl) do
                    tinsert(tbl, v)
                end
            end
            return tbl
        else
            return newTbl
        end
    end

    BG.RegisterEvent("MODIFIER_STATE_CHANGED", function(self, event, enter)
        if BG.FBCDFrame and not BG.FBCDFrame.click and BG.FBCDFrame:IsVisible() then
            BG.FBCDFrame:Hide()
            BG.SetFBCD(BG.FBCDFrame.lastSelf, BG.FBCDFrame.lastPosition)
        end
    end)

    -- 获取副本CD
    do
        BiaoGe.FBCD = BiaoGe.FBCD or {}
        BiaoGe.FBCD[realmID] = BiaoGe.FBCD[realmID] or {}
        local colorplayer = SetClassCFF(player, "player")

        function BG.UpdateFBCD()
            local time = GetServerTime()
            local cd = {}

            if UnitLevel("player") >= BG.fullLevel then
                for i = 1, GetNumSavedInstances() do
                    local name, lockoutId, resettime, difficultyId, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress, extendDisabled, instanceId =
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
                if #cd ~= 0 then
                    BiaoGe.FBCD[realmID][player] = cd
                else
                    BiaoGe.FBCD[realmID][player] = {
                        {
                            player = player,
                            colorplayer = colorplayer,
                        }
                    }
                end
            elseif UnitLevel("player") < BG.fullLevel then
                BiaoGe.FBCD[realmID][player] = nil
            end

            -- 检查其他角色cd是否到期
            local function Update(db)
                if not (db and db.FBCD) then return end
                local function _Update(realmID)
                    if not (type(realmID) == "number" and type(db.FBCD[realmID]) == "table") then return end
                    for _player in pairs(db.FBCD[realmID]) do
                        if _player ~= player then
                            local yes
                            local player0, colorplayer0
                            for i = #db.FBCD[realmID][_player], 1, -1 do
                                local cd = db.FBCD[realmID][_player][i]
                                if cd and not player0 and not colorplayer0 then
                                    player0 = cd.player
                                    colorplayer0 = cd.colorplayer
                                end
                                if cd and cd.endtime then
                                    if time >= cd.endtime then
                                        tremove(db.FBCD[realmID][_player], i)
                                    elseif time < cd.endtime then
                                        cd.resettime = cd.endtime - time
                                        yes = true
                                    end
                                end
                            end
                            if not yes then
                                db.FBCD[realmID][_player] = {
                                    {
                                        player = player0,
                                        colorplayer = colorplayer0,
                                    }
                                }
                            end
                        end
                    end
                end
                if ShowAllServer() then
                    for realmID, v in pairs(db.FBCD) do
                        _Update(realmID)
                    end
                else
                    _Update(realmID)
                end
            end
            Update(BiaoGe)
            Update(BiaoGeAccounts)
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:RegisterEvent("ENCOUNTER_END")
        f:SetScript("OnEvent", function(self, event, bossId, _, _, _, success)
            if event ~= "ENCOUNTER_END" or (event == "ENCOUNTER_END" and success == 1) then
                BG.After(0.5, function()
                    RequestRaidInfo()
                end)
            end
        end)

        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:RegisterEvent("ENCOUNTER_END")
        f:RegisterEvent("UPDATE_INSTANCE_INFO")
        f:SetScript("OnEvent", function(self, event, bossId, _, _, _, success)
            if event ~= "ENCOUNTER_END" or (event == "ENCOUNTER_END" and success == 1) then
                BG.After(1, function()
                    BG.UpdateFBCD()
                    BG.GetLockoutID()
                    if not BG.IsVanilla and BG.FBCD_5M_Frame and BG.FBCD_5M_Frame:IsVisible() then
                        BG.UpdateFBCD_5M()
                    end
                end)
            end
        end)
    end

    -- 5人本CD
    if not BG.IsVanilla then
        local height = 22
        local width_fb = 100

        if BG.IsWLK then
            BG.FBCDall_5M_table = {
                { color = "1E90FF", fbId = 574 }, -- 乌下
                { color = "1E90FF", fbId = 575 },

                { color = "00FFFF", fbId = 576 }, -- 魔枢
                { color = "00FFFF", fbId = 578 },

                { color = "FF4500", fbId = 601 }, -- 艾卓
                { color = "FF4500", fbId = 619 },

                { color = "32CD32", fbId = 600 }, -- 要塞
                { color = "32CD32", fbId = 604 },

                { color = "8B4513", fbId = 599 }, -- 岩石
                { color = "8B4513", fbId = 602 },

                { color = "FF69B4", fbId = 608 }, -- 紫罗兰
                { color = "FF69B4", fbId = 595 }, -- 斯坦索姆

                { color = "FFFF00", fbId = 650 }, -- 冠军

                { color = "9370DB", fbId = 632 }, -- 灵魂
                { color = "9370DB", fbId = 658 }, -- 萨隆
                { color = "9370DB", fbId = 668 }, -- 映像
            }
        elseif BG.IsCTM then
            BG.FBCDall_5M_table = {
                { color = "87CEFA", fbId = 755 }, -- 托维尔失落之城
                { color = "87CEFA", fbId = 657 }, -- 旋云之巅
                { color = "87CEFA", fbId = 644 }, -- 起源大厅

                { color = "FFFF00", fbId = 36 },  -- 死亡矿井
                { color = "FFFF00", fbId = 33 },  -- 影牙城堡

                { color = "8B4513", fbId = 725 }, -- 巨石之核
                { color = "9370DB", fbId = 645 }, -- 黑石岩窟
                { color = "FF4500", fbId = 670 }, -- 格瑞姆巴托
                { color = "1E90FF", fbId = 643 }, -- 潮汐王座
            }
        end
        if BG.FBCDall_5M_table then
            for i, v in ipairs(BG.FBCDall_5M_table) do
                BG.FBCDall_5M_table[i].height = i * height
            end
        end
        local parent = LFGParentFrame or PVEFrame
        parent:HookScript("OnShow", function()
            BG.UpdateFBCD_5M()
        end)

        function BG.UpdateFBCD_5M()
            if BG.FBCD_5M_Frame then
                BG.FBCD_5M_Frame:Hide()
            end
            if BiaoGe.options["FB5M"] ~= 1 then
                return
            end
            -- 创建框体UI
            local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 16,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.9)
            f:SetBackdropBorderColor(r, g, b)
            f:SetSize(width_fb + 30, (#BG.FBCDall_5M_table + 3) * height + 8)
            if LFGParentFrame then
                f:SetPoint("TOPLEFT", LFGParentFrame, "TOPRIGHT", -25, -12)
            elseif PVEFrame then
                f:SetPoint("TOPLEFT", PVEFrame, "TOPRIGHT", 10, 0)
            end
            f:EnableMouse(true)
            BG.FBCD_5M_Frame = f

            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
            t:SetPoint("TOPLEFT", 15, -10)
            t:SetText(BG.STC_g1(L["< 角色5人本完成总览 >"]))
            t:SetJustifyH("LEFT")
            t:SetWordWrap(false)
            local FBCDbiaoti = t

            local bt = CreateFrame("Button", nil, BG.FBCD_5M_Frame)
            bt:SetSize(35, 35)
            bt:SetPoint("TOPRIGHT", 0, 0)
            local tex = bt:CreateTexture()
            tex:SetAllPoints()
            tex:SetTexture(616343)
            bt:SetHighlightTexture(616343)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:SetText(L["如果你想关闭该功能，可在插件设置-BiaoGe-角色总览里关闭"], 1, 0.82, 0, 1, true)
            end)
            BG.GameTooltip_Hide(bt)

            -- 副本标题
            local lastframe
            local lastHeightNum = 0
            for i, v in ipairs(BG.FBCDall_5M_table) do
                local f = CreateFrame("Frame", nil, BG.FBCD_5M_Frame)
                f:SetSize(width_fb, height)
                if i == 1 then
                    f:SetPoint("TOPLEFT", 15, -height * 3)
                else
                    f:SetPoint("TOPLEFT", lastframe, "BOTTOMLEFT", 0, 0)
                end
                lastframe = f

                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                t:SetAllPoints()
                t:SetJustifyH("LEFT")
                t:SetText("|cff" .. v.color .. GetRealZoneText(v.fbId) .. RR)
                t:SetWordWrap(false)

                f:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:SetText("|cff" .. v.color .. GetRealZoneText(v.fbId) .. RR)
                end)
                BG.GameTooltip_Hide(f)

                lastHeightNum = lastHeightNum + 1
                local l = BG.FBCD_5M_Frame:CreateLine()
                l:SetColorTexture(RGB("808080", 1))
                l:SetStartPoint("TOPLEFT", BG.FBCD_5M_Frame, 5, -height * (2 + i))
                l:SetEndPoint("TOPRIGHT", BG.FBCD_5M_Frame, -5, -height * (2 + i))
                l:SetThickness(1)
            end

            -- 角色CD
            local newTbl = {}
            for player, v in pairs(BiaoGe.FBCD[realmID]) do
                local level = BiaoGe.playerInfo[realmID] and BiaoGe.playerInfo[realmID][player] and BiaoGe.playerInfo[realmID][player].level
                if (level and level >= BiaoGe.options["roleOverviewNotShowLevel"]) then
                    local class = BiaoGe.playerInfo[realmID][player].class
                    local iLevel = BiaoGe.playerInfo[realmID][player].iLevel
                    if class and iLevel then
                        local colorplayer = "|c" .. select(4, GetClassColor(class)) .. player .. (isAccounts and "*" or "")
                        tinsert(newTbl, {
                            player = player,
                            colorplayer = colorplayer,
                            class = class,
                            iLevel = iLevel,
                            tbl = BG.Copy(v)
                        })
                    end
                end
            end
            newTbl = BG.SortRoleOverview(newTbl)

            local last
            local n = 0
            for _, v in ipairs(newTbl) do
                local colorplayer = v.colorplayer
                local player = v.player
                local iLevel = v.iLevel
                -- 玩家名字
                if not last then
                    local t = BG.FBCD_5M_Frame:CreateFontString()
                    t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                    t:SetSize(width_fb, height)
                    t:SetPoint("TOPLEFT", 15, -height * 2)
                    t:SetJustifyH("LEFT")
                    t:SetText(L["副本"])
                end

                local f = CreateFrame("Frame", nil, BG.FBCD_5M_Frame)
                f:SetSize(1, height)
                if not last then
                    f:SetPoint("TOPLEFT", width_fb + 15, -height * 2)
                else
                    f:SetPoint("TOPLEFT", last, "TOPRIGHT", 5, 0)
                end
                last = f
                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                t:SetPoint("CENTER")
                t:SetJustifyH("LEFT")
                t:SetText(colorplayer)
                f:SetWidth(t:GetWidth())

                -- 副本CD
                for i, cd in pairs(v.tbl) do
                    for ii, vv in ipairs(BG.FBCDall_5M_table) do
                        if cd.fbId and (cd.fbId == vv.fbId) then
                            local tx = f:CreateTexture(nil, "OVERLAY")
                            tx:SetSize(16, 16)
                            local width = f:GetLeft() - BG.FBCD_5M_Frame:GetLeft() + f:GetWidth() / 2
                            local height = -height * (2 + ii) - 2
                            tx:SetPoint("TOP", BG.FBCD_5M_Frame, "TOPLEFT", width, height)
                            tx:SetTexture("interface/raidframe/readycheck-ready")
                        end
                    end
                end
                n = n + 1

                if player == BG.GN() then
                    local l = f:CreateLine()
                    l:SetStartPoint("TOP", f, 0, 0)
                    l:SetEndPoint("TOP", f, 0, -BG.FBCD_5M_Frame:GetHeight() + height * 2 + 5)
                    l:SetThickness(f:GetWidth() + 2)
                    l:SetColorTexture(r, g, b, .3)
                end
            end
            if n == 0 then
                local t = BG.FBCD_5M_Frame:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                t:SetPoint("TOPLEFT", width_fb + 15, -height * 2)
                t:SetJustifyH("LEFT")
                t:SetText(BG.STC_dis(L["当前没有满级角色"]))
                local width = width_fb + 30 + t:GetWidth()
                BG.FBCD_5M_Frame:SetWidth(width)
            else
                local width = last and last:GetRight() - BG.FBCD_5M_Frame:GetLeft() + 15 or width_fb + 30
                BG.FBCD_5M_Frame:SetWidth(width)
            end
        end
    end

    -- 日常任务
    do
        BiaoGe.QuestCD = BiaoGe.QuestCD or {}
        BiaoGe.QuestCD[realmID] = BiaoGe.QuestCD[realmID] or {}
        BiaoGe.QuestCD[realmID][player] = BiaoGe.QuestCD[realmID][player] or {}

        -- 日常
        if BG.IsVanilla_Sod then
            BG.dayQuests = {
                huiguweek = { 79090, 79098 }, -- 灰谷
            }
        elseif BG.IsWLK then
            BG.dayQuests = {
                gamma = { 83717, 83713, 78752 },
                heroe = { 87379, 83714, 84552, 78753 },
                zhubao = { 12959, 12962, 12961, 12958, 12963, 12960 },
                cooking = { 13114, 13116, 13113, 13115, 13112,
                    13102, 13100, 13107, 13101, 13103 },
                fish = { 13836, 13833, 13834, 13832, 13830 },
            }
        end
        local function SaveDayQuest(questName, questID)
            local currentTimestamp = GetServerTime()
            local tomorrow7amTimestamp
            local today = date("*t", currentTimestamp)
            -- 如果时间小于当天凌晨7点
            if today.hour < 7 then
                today.hour = 7
                today.min = 0
                today.sec = 0
                tomorrow7amTimestamp = time(today)
            else
                -- 获取明天凌晨7点的时间戳
                local tomorrow = date("*t", currentTimestamp + 86400) -- 加上一天的秒数
                tomorrow.hour = 7
                tomorrow.min = 0
                tomorrow.sec = 0
                tomorrow7amTimestamp = time(tomorrow)
            end
            -- 计算时间差
            local secondsUntilNext7am = tomorrow7amTimestamp - currentTimestamp
            local timestamp = currentTimestamp + secondsUntilNext7am

            local colorplayer = SetClassCFF(player, "player")
            BiaoGe.QuestCD[realmID][player][questName] = {
                name = questName,
                player = player,
                colorplayer = colorplayer,
                questID = questID,
                resettime = secondsUntilNext7am,
                endtime = timestamp
            }
        end
        local function UpdateDayQuest(questID)
            if not BG.dayQuests then return end
            for questName in pairs(BG.dayQuests) do
                for _, _questID in pairs(BG.dayQuests[questName]) do
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
                week1 = { 24579, 24580, 24581, 24582, 24583, 24584, 24585, 24586, 24587, 24588, 24589, 24590, },
            }
        end
        local function SaveWeekQuest(questName, questID)
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
                for _, _questID in pairs(BG.weekQuests[questName]) do
                    if _questID == questID then
                        SaveWeekQuest(questName, questID)
                        return
                    end
                end
            end
        end

        -- 交任务时触发
        BG.RegisterEvent("QUEST_TURNED_IN", function(self, event, questID)
            UpdateDayQuest(questID)
            UpdateWeekQuest(questID)
        end)

        -- 检查全部角色的任务重置cd是否到期（日常是第二天凌晨7点）
        local function UpdateQuestEndTime()
            local time = GetServerTime()
            local function Update(db)
                if not (db and db.QuestCD) then return end
                local function _Update(realmID)
                    if not (type(realmID) == "number" and type(db.QuestCD[realmID]) == "table") then return end
                    for player in pairs(db.QuestCD[realmID]) do
                        for questName, v in pairs(db.QuestCD[realmID][player]) do
                            if time < v.endtime then
                                v.resettime = v.endtime - time
                            else
                                db.QuestCD[realmID][player][questName] = nil
                            end
                        end
                    end
                end
                for realmID, v in pairs(db.QuestCD) do
                    _Update(realmID)
                end
            end
            Update(BiaoGe)
            Update(BiaoGeAccounts)
        end
        -- 追溯已完成的任务
        local function CheckQuestsCompleted()
            local tbl = GetQuestsCompleted and GetQuestsCompleted()
            if BG.dayQuests then
                for questName in pairs(BG.dayQuests) do
                    if not BiaoGe.QuestCD[realmID][player][questName] then
                        for _, _questID in pairs(BG.dayQuests[questName]) do
                            if tbl and tbl[_questID] or C_QuestLog.IsQuestFlaggedCompleted(_questID) then
                                SaveDayQuest(questName, questID)
                                break
                            end
                        end
                    end
                end
            end
            if BG.weekQuests then
                for questName in pairs(BG.weekQuests) do
                    if not BiaoGe.QuestCD[realmID][player][questName] then
                        for _, _questID in pairs(BG.weekQuests[questName]) do
                            if tbl and tbl[_questID] or C_QuestLog.IsQuestFlaggedCompleted(_questID) then
                                SaveWeekQuest(questName, questID)
                                break
                            end
                        end
                    end
                end
            end
        end

        BG.Init2(function()
            CheckQuestsCompleted()
            UpdateQuestEndTime()
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

        local tbl
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
        elseif BG.IsWLK or BG.IsCTM then
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
        else
            tbl = {}
        end

        local function GetCooldown()
            local time = GetServerTime()
            local _time = GetTime()
            for profession, v in pairs(tbl) do
                local startTime, duration
                if BG.IsRetail then
                    local info = C_Spell.GetSpellCooldown(v.spell)
                    startTime = info.startTime
                    duration = info.duration
                else
                    startTime, duration = GetSpellCooldown(v.spell)
                end

                startTime = startTime > _time and (startTime - 2 ^ 32 / 1000) or startTime
                local cooldown = startTime + duration - _time
                if cooldown > 0 then
                    BiaoGe.tradeSkillCooldown[realmID][player][profession] = {
                        class = select(2, UnitClass("player")),
                        resettime = cooldown,
                        endtime = cooldown + time,
                        ready = nil,
                    }
                end
            end
        end
        -- 检查其他角色cd是否到期
        local function UpdateProfessionCD()
            local time = GetServerTime()
            local i = 3
            local function Update(db)
                if not (db and db.tradeSkillCooldown) then return end
                local function _Update(realmID)
                    if not (type(realmID) == "number" and type(db.tradeSkillCooldown[realmID]) == "table") then return end
                    for player in pairs(db.tradeSkillCooldown[realmID]) do
                        for profession, v in pairs(db.tradeSkillCooldown[realmID][player]) do
                            if v.endtime then
                                if time >= v.endtime then
                                    v.resettime = nil
                                    v.endtime = nil
                                    v.ready = true
                                    if db == BiaoGe and BiaoGe.FBCDchoice[profession] and BiaoGe.FBCDchoice[profession] == 1 then
                                        local color
                                        if v.class then
                                            color = select(4, GetClassColor(v.class))
                                        end
                                        local name = color and "|c" .. color .. player .. "|r: " or player .. ": "
                                        if player == BG.GN() then
                                            name = color and "|c" .. color .. L["我"] .. "|r: " or L["我"] .. ": "
                                        end
                                        local msg = BG.BG .. BG.STC_g1(format(L["%s%s已就绪！"], name, tbl[profession].name))
                                        BG.After(i, function()
                                            SendSystemMessage(msg)
                                            if BG["sound_" .. profession .. "Ready" .. BiaoGe.options.Sound] then
                                                PlaySoundFile(BG["sound_" .. profession .. "Ready" .. BiaoGe.options.Sound], "Master")
                                            else
                                                PlaySoundFile("Interface\\AddOns\\BiaoGe\\Media\\sound\\other\\done.mp3", "Master")
                                            end
                                        end)
                                        i = i + 3
                                    end
                                elseif time < v.endtime then
                                    v.resettime = v.endtime - time
                                end
                            end
                        end
                    end
                end
                for realmID, v in pairs(db.tradeSkillCooldown) do
                    _Update(realmID)
                end
            end
            Update(BiaoGe)
            Update(BiaoGeAccounts)
        end
        local _msg = TRADESKILL_LOG_FIRSTPERSON:gsub("%%s", "(.+)")
        BG.RegisterEvent("CHAT_MSG_TRADESKILLS", function(self, event, msg)
            if not strfind(msg, _msg) then return end
            GetCooldown()
        end)

        BG.Init2(function()
            GetCooldown()
            UpdateProfessionCD()
        end)
        C_Timer.NewTicker(60, function()
            UpdateProfessionCD()
        end)

        if not BG.IsRetail then
            BG.RegisterEvent("SKILL_LINES_CHANGED", function(self, event)
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
            end)
        end
    end

    -- 获取货币信息
    do
        BiaoGe.Money = BiaoGe.Money or {}
        BiaoGe.Money[realmID] = BiaoGe.Money[realmID] or {}
        BiaoGe.Money[realmID][player] = BiaoGe.Money[realmID][player] or {}

        function BG.MONEYupdate()
            local g = {}

            local player = BG.playerName
            g.player = player
            g.colorplayer = SetClassCFF(player, "player")
            g.money = floor(GetMoney() / 1e4)
            for i, v in ipairs(BG.MONEYall_table) do
                if v.id ~= "money" then
                    if BG.IsVanilla_Sod then
                        local count
                        if v.id_gold and v.id_copper then
                            count = GetItemCount(v.id_gold, true) * 100 + GetItemCount(v.id, true) + floor(GetItemCount(v.id_copper, true) / 100)
                        else
                            count = GetItemCount(v.id, true)
                        end
                        local tex = v.tex

                        g[v.id] = { count = count, tex = tex }
                    elseif not BG.IsVanilla then
                        local count = C_CurrencyInfo.GetCurrencyInfo(v.id).quantity
                        local tex = C_CurrencyInfo.GetCurrencyInfo(v.id).iconFileID
                        g[v.id] = { count = count, tex = tex }
                    end
                end
            end
            BiaoGe.Money[realmID][player] = g
        end

        -- 事件
        do
            local f = CreateFrame("Frame")
            f:RegisterEvent("PLAYER_ENTERING_WORLD")
            f:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
            f:RegisterEvent("PLAYER_MONEY")
            f:RegisterEvent("BAG_UPDATE_DELAYED")
            f:SetScript("OnEvent", function(self, event, ...)
                C_Timer.After(0.5, function()
                    BG.MONEYupdate()
                end)
            end)
        end
    end

    -- 角色装备和装等
    do
        BiaoGe.equip = BiaoGe.equip or {}
        BiaoGe.equip[realmID] = BiaoGe.equip[realmID] or {}
        BiaoGe.equip[realmID][player] = BiaoGe.equip[realmID][player] or {}

        function BG.GetPlayerEquip()
            local tbl = BiaoGe.equip[realmID][player]
            wipe(tbl)
            for slot = 1, 19 do
                local link = GetInventoryItemLink("player", slot)
                if link then
                    local itemID = GetInventoryItemID("player", slot)
                    local quality = GetInventoryItemQuality("player", slot)
                    local level = select(4, GetItemInfo(itemID))
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

        local function GetPlayerItemsLevel()
            local _, avgLevel = GetAverageItemLevel()
            BiaoGe.playerInfo[realmID][player].iLevel = avgLevel or 0
            local avgLevel0 = Round(avgLevel, 0)
            -- 更新集结号密语装等
            if BG.MeetingHorn and BG.MeetingHorn.iLevelCheckButton then
                BG.MeetingHorn.iLevelCheckButton.Text:SetText(avgLevel0)
            end
        end

        BG.Init2(function()
            BG.After(1, function()
                BG.GetPlayerEquip()
                GetPlayerItemsLevel()
            end)
        end)

        BG.RegisterEvent("UNIT_INVENTORY_CHANGED", function(self, event, ...)
            BG.After(0.5, function()
                BG.GetPlayerEquip()
                GetPlayerItemsLevel()
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
                bt.tbl = { 286, 285, 287, 288 } -- 火焰节、万圣节、美酒节、情人节
                -- bt.tbl = { 259 }           -- 燃烧的远征test
            elseif i == 2 then
                bt.type = "zhiding"
                bt.tbl = { 2463, 2481 } --伽马灵魂烘炉、贝塔要塞
                -- bt.tbl = { 136 }  -- 地狱火test
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
        t:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
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
                if BiaoGe.Money[realmID] then
                    for player in pairs(BiaoGe.playerInfo[realmID]) do
                        if not BiaoGe.Money[realmID][player] then
                            BG.DeletePlayerData(realmID, player)
                        end
                    end
                else
                    BiaoGe.playerInfo[realmID] = nil
                    BiaoGe.equip[realmID] = nil
                end
            end
        end
-- /run BiaoGe.equip=nil
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
        DeleteOldData("FBCD")
        DeleteOldData("Money")
    end

    -- 删除重复角色装备数据
    for realmID, v in pairs(BiaoGe.equip) do
        if type(realmID) == "number" and type(v) == "table" then
            if BiaoGe.playerInfo[realmID] then
                for player in pairs(BiaoGe.equip[realmID]) do
                    if not BiaoGe.playerInfo[realmID][player] then
                        BiaoGe.equip[realmID][player]=nil
                    end
                end
            else
                BiaoGe.equip[realmID] = nil
            end
        end
    end
end
