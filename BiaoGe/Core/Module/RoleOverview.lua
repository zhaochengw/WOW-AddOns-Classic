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
local FrameDongHua = ns.FrameDongHua
local FrameHide = ns.FrameHide
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID
local Round = ns.Round

local pt = print

local player = UnitName("player")
local realmID = GetRealmID()

function BG.RoleOverviewUI()
    -- 初始化
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
                -- ["huiguweek"] = 1,
                ["alchemy"] = 1,
                ["leatherworking"] = 1,
                ["tailor"] = 1,
            }
        elseif BG.IsWLK then
            BiaoGe.FBCDchoice = {
                ["25ULD"] = 1,
                ["10ULD"] = 1,
                ["25NAXX"] = 1,
                ["10NAXX"] = 1,
                ["25EOE"] = 1,
                ["10EOE"] = 1,
                ["25OS"] = 1,
                ["10OS"] = 1,
                ["25VOA"] = 1,
                ["10VOA"] = 1,
                ["gamma"] = 1,
                ["heroe"] = 1,
                ["week1"] = 1,
            }
        elseif BG.IsCTM then
            BiaoGe.FBCDchoice = {
                ["BOT"] = 1,
                ["BWD"] = 1,
                ["TOF"] = 1,
                ["BH"] = 1,
            }
        end
    end
    if not BiaoGe.MONEYchoice then
        if BG.IsVanilla then
            BiaoGe.MONEYchoice = {
                [221262] = 1,
                [221365] = 1,
                ["money"] = 1,
            }
        elseif BG.IsWLK then
            BiaoGe.MONEYchoice = {
                -- [396] = 1,
                -- [395] = 1,
                -- [341] = 1,
                -- [301] = 1,
                [221] = 1,
                [102] = 1,
                [101] = 1,
                -- [2711] = 1,
                -- [2589] = 1,
                [161] = 1,
                [1901] = 1,
                ["money"] = 1,
            }
        elseif BG.IsCTM then
            BiaoGe.MONEYchoice = {
                [396] = 1,
                [395] = 1,
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
        elseif BG.IsWLK then
        elseif BG.IsCTM then
        end
    end

    if BG.IsVanilla_Sod then
        BG.FBCDall_table = {
            { name = "BWLsod", color = "00BFFF", fbId = 469, type = "fb" },
            { name = "ZUGsod", color = "00BFFF", fbId = 309, type = "fb" },
            { name = "TCV", color = "00BFFF", fbId = 2804, type = "fb" },
            { name = "MCsod", color = "00BFFF", fbId = 409, type = "fb" },
            { name = "OLsod", color = "00BFFF", fbId = 249, type = "fb" },
            { name = "SC", color = "00BFFF", fbId = 2791, type = "fb" },
            { name = "TTS", color = "00BFFF", fbId = 2789, type = "fb" },
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
            { name = L["荒野祭品"], color = "98FB98", id = 221262, tex = 132119, width = 70 }, -- 荒野祭品
            -- { name = L["白银戮币"], color = "FF6347", id = 221365, id_gold = 221366, id_copper = 213168, tex = 237282, width = 70 }, -- test
            { name = L["白银戮币"], color = "FF6347", id = 221365, id_gold = 221366, id_copper = 221364, tex = 237282, width = 70 }, -- 白银戮币
            { name = L["金币"], color = "FFD700", id = "money", tex = 237618, width = 90 }, -- 金币
        }
    elseif BG.IsVanilla_60 then
        BG.FBCDall_table = {
            { name = "NAXX", color = "00BFFF", fbId = 533, num = 40, type = "fb" },
            { name = "TAQ", color = "00BFFF", fbId = 531, num = 40, type = "fb" },
            { name = "BWL", color = "00BFFF", fbId = 469, num = 40, type = "fb" },
            { name = "OL", color = "00BFFF", fbId = 249, num = 40, type = "fb" },
            { name = "MC", color = "00BFFF", fbId = 409, num = 40, type = "fb" },
            { name = "AQL", color = "BA55D3", fbId = 509, num = 20, type = "fb" },
            { name = "ZUG", color = "BA55D3", fbId = 309, num = 20, type = "fb" },
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
            { name = "25RS", color = "FF4500", fbId = 724, num = 25, type = "fb" },
            { name = "10RS", color = "FF4500", fbId = 724, num = 10, type = "fb" },
            { name = "25ICC", color = "9370DB", fbId = 631, num = 25, type = "fb" },
            { name = "10ICC", color = "9370DB", fbId = 631, num = 10, type = "fb" },
            { name = "25TOC", color = "FF69B4", fbId = 649, num = 25, type = "fb" },
            { name = "10TOC", color = "FF69B4", fbId = 649, num = 10, type = "fb" },
            { name = "25OL", color = "FFA500", fbId = 249, num = 25, type = "fb" },
            { name = "10OL", color = "FFA500", fbId = 249, num = 10, type = "fb" },
            { name = "25ULD", color = "00BFFF", fbId = 603, num = 25, type = "fb" },
            { name = "10ULD", color = "00BFFF", fbId = 603, num = 10, type = "fb" },
            { name = "25NAXX", color = "32CD32", fbId = 533, num = 25, type = "fb" },
            { name = "10NAXX", color = "32CD32", fbId = 533, num = 10, type = "fb" },
            { name = "25EOE", color = "1E90FF", fbId = 616, num = 25, type = "fb" },
            { name = "10EOE", color = "1E90FF", fbId = 616, num = 10, type = "fb" },
            { name = "25OS", color = "8B4513", fbId = 615, num = 25, type = "fb" },
            { name = "10OS", color = "8B4513", fbId = 615, num = 10, type = "fb" },
            { name = "25VOA", color = "FFFF00", fbId = 624, num = 25, type = "fb" },
            { name = "10VOA", color = "FFFF00", fbId = 624, num = 10, type = "fb" },
            --TBC
            { name = "SW", color = "D3D3D3", fbId = 580, num = 25, type = "fb" },
            { name = "BT", color = "D3D3D3", fbId = 564, num = 25, type = "fb" },
            { name = "HS", color = "D3D3D3", fbId = 534, num = 25, type = "fb" },
            { name = "TK", color = "D3D3D3", fbId = 550, num = 25, type = "fb" },
            { name = "SSC", color = "D3D3D3", fbId = 548, num = 25, type = "fb" },
            { name = "GL", color = "D3D3D3", fbId = 565, num = 25, type = "fb" },
            { name = "ML", color = "D3D3D3", fbId = 544, num = 25, type = "fb" },
            { name = "ZA", color = "D3D3D3", fbId = 568, num = 10, type = "fb" },
            { name = "KZ", color = "D3D3D3", fbId = 532, num = 10, type = "fb" },
            --CLASSIC
            { name = "TAQ", color = "D3D3D3", fbId = 531, num = 40, type = "fb" },
            { name = "AQL", color = "D3D3D3", fbId = 509, num = 20, type = "fb" },
            { name = "BWL", color = "D3D3D3", fbId = 469, num = 40, type = "fb" },
            { name = "MC", color = "D3D3D3", fbId = 409, num = 40, type = "fb" },
            { name = "ZUG", color = "D3D3D3", fbId = 309, num = 20, type = "fb" },
            -- 日常
            { name = "week1", name2 = L["周常"], color = "FF8C00", type = "quest" },
            { name = "gamma", name2 = L["泰坦"], color = "FF8C00", type = "quest" },
            { name = "heroe", name2 = L["英雄"], color = "FF8C00", type = "quest" },
            { name = "zhubao", name2 = L["珠宝"], color = "FF8C00", type = "quest" },
            { name = "cooking", name2 = L["烹饪"], color = "FF8C00", type = "quest" },
            { name = "fish", name2 = L["钓鱼"], color = "FF8C00", type = "quest" },
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
            { name = "BOT", color = "FFFF00", fbId = 671, type = "fb" },
            { name = "BWD", color = "FF1493", fbId = 669, type = "fb" },
            { name = "TOF", color = "87CEFA", fbId = 754, type = "fb" },
            { name = "BH", color = "FF4500", fbId = 757, type = "fb" },
            --WLK
            { name = "25RS", color = "FF4500", fbId = 724, num = 25, type = "fb" },
            { name = "10RS", color = "FF4500", fbId = 724, num = 10, type = "fb" },
            { name = "25ICC", color = "9370DB", fbId = 631, num = 25, type = "fb" },
            { name = "10ICC", color = "9370DB", fbId = 631, num = 10, type = "fb" },
            { name = "25TOC", color = "FF69B4", fbId = 649, num = 25, type = "fb" },
            { name = "10TOC", color = "FF69B4", fbId = 649, num = 10, type = "fb" },
            { name = "25OL", color = "FFA500", fbId = 249, num = 25, type = "fb" },
            { name = "10OL", color = "FFA500", fbId = 249, num = 10, type = "fb" },
            { name = "25ULD", color = "00BFFF", fbId = 603, num = 25, type = "fb" },
            { name = "10ULD", color = "00BFFF", fbId = 603, num = 10, type = "fb" },
            { name = "25NAXX", color = "32CD32", fbId = 533, num = 25, type = "fb" },
            { name = "10NAXX", color = "32CD32", fbId = 533, num = 10, type = "fb" },
            { name = "25EOE", color = "1E90FF", fbId = 616, num = 25, type = "fb" },
            { name = "10EOE", color = "1E90FF", fbId = 616, num = 10, type = "fb" },
            { name = "25OS", color = "8B4513", fbId = 615, num = 25, type = "fb" },
            { name = "10OS", color = "8B4513", fbId = 615, num = 10, type = "fb" },
            { name = "25VOA", color = "FFFF00", fbId = 624, num = 25, type = "fb" },
            { name = "10VOA", color = "FFFF00", fbId = 624, num = 10, type = "fb" },
            --TBC
            { name = "SW", color = "D3D3D3", fbId = 580, num = 25, type = "fb" },
            { name = "BT", color = "D3D3D3", fbId = 564, num = 25, type = "fb" },
            { name = "HS", color = "D3D3D3", fbId = 534, num = 25, type = "fb" },
            { name = "TK", color = "D3D3D3", fbId = 550, num = 25, type = "fb" },
            { name = "SSC", color = "D3D3D3", fbId = 548, num = 25, type = "fb" },
            { name = "GL", color = "D3D3D3", fbId = 565, num = 25, type = "fb" },
            { name = "ML", color = "D3D3D3", fbId = 544, num = 25, type = "fb" },
            { name = "ZA", color = "D3D3D3", fbId = 568, num = 10, type = "fb" },
            { name = "KZ", color = "D3D3D3", fbId = 532, num = 10, type = "fb" },
            --CLASSIC
            { name = "TAQ", color = "D3D3D3", fbId = 531, num = 40, type = "fb" },
            { name = "AQL", color = "D3D3D3", fbId = 509, num = 20, type = "fb" },
            { name = "BWL", color = "D3D3D3", fbId = 469, num = 40, type = "fb" },
            { name = "MC", color = "D3D3D3", fbId = 409, num = 40, type = "fb" },
            { name = "ZUG", color = "D3D3D3", fbId = 309, num = 20, type = "fb" },
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
    end

    local FBCDchoice_table = {}
    local MONEYchoice_table = {}
    BG.PlayerItemsLevel = {}

    ------------------角色总览UI------------------
    local fontsize = 13
    local fontsize2 = 14
    local fontsize3 = 15

    local height = 20
    local width_jiange = 5
    local line_height = 4
    function BG.SetFBCD(position)
        BG.UpdateFBCD()

        FBCDchoice_table = {}
        MONEYchoice_table = {}
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
        tinsert(MONEYchoice_table, 1, { name = L["角色"] .. " " .. BG.STC_dis("(" .. LEVEL .. ")"), color = "FFFFFF", width = 105 })
        -- 计算货币表格的总宽度
        local Moneywidth = 30
        for key, value in pairs(MONEYchoice_table) do
            Moneywidth = Moneywidth + value.width
        end

        local n = 1
        local totalwidth

        -- 创建框体UI
        local f = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.9)
        f:SetBackdropBorderColor(GetClassRGB(nil, "player"))
        f:SetFrameStrata("FULLSCREEN_DIALOG")
        f:SetFrameLevel(100)
        f:SetSize(300, 100)
        f:SetClampedToScreen(true)
        f:EnableMouse(true)
        f:Hide()
        if BiaoGe.options.scale then
            f:SetScale(BiaoGe.options.scale)
        end
        BG.FBCDFrame = f

        --------- 角色团本完成总览 ---------
        local t = f:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, fontsize2, "OUTLINE")
        t:SetPoint("TOPLEFT", 15, -10 - (n - 1) * height)
        t:SetText(BG.STC_g1(L["< 角色团本完成总览 >"]))
        t:SetJustifyH("LEFT")
        t:SetWordWrap(false) -- 截断
        local FBCDbiaoti = t
        local FBCDResetbiaoti
        n = n + 1
        -- 设置重置时间
        local text3 = ""
        local text7 = ""
        for p, v in pairs(BiaoGe.FBCD[realmID]) do
            for i, cd in pairs(BiaoGe.FBCD[realmID][p]) do
                if cd.resettime then
                    if cd.fbId == 309 or cd.fbId == 568 or cd.fbId == 509 -- ZUG ZA AQL
                        or cd.fbId == 48 or cd.fbId == 90 then            -- BD Gno
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
            if BG.IsVanilla then
                local t_end = f:CreateFontString()
                t_end:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                t_end:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 0, -3)
                t_end:SetText(BG.STC_dis(resettext:gsub("（", ""):gsub("）", ""):gsub("%(", ""):gsub("%)", "")))
                t_end:SetJustifyH("LEFT")
                t_end:SetWordWrap(false) -- 截断
                FBCDResetbiaoti = t_end
            else
                t:SetText(t:GetText() .. resettext)
            end
        end

        -- FBCD标题
        local text_table = {}
        do
            local right
            local lastwidth
            local FBCDwidth = 0
            for i, v in ipairs(FBCDchoice_table) do
                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                if i == 1 then
                    t:SetPoint("TOPLEFT", f, "TOPLEFT", 15, -10 - height * n)
                elseif i == 2 then
                    t:SetPoint("TOPLEFT", f, "TOPLEFT", 140, -10 - height * n)
                else
                    t:SetPoint("TOPLEFT", right, "TOPRIGHT", width_jiange, 0)
                end
                if v.type and v.type ~= "fb" then
                    t:SetText("|cff" .. v.color .. v.name2:gsub("sod", "") .. RR)
                else
                    t:SetText("|cff" .. v.color .. v.name:gsub("sod", "") .. RR)
                end
                if i == 1 then
                    FBCDchoice_table[i].width = 15
                    lastwidth = FBCDchoice_table[i].width
                elseif i == 2 then
                    FBCDchoice_table[i].width = 140
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

            local l = f:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("TOPLEFT", BG.FBCDFrame, 5, -10 - height * n + line_height)
            l:SetEndPoint("TOPLEFT", BG.FBCDFrame, totalwidth - 5, -10 - height * n + line_height)
            l:SetThickness(1)
        end
        -- 角色CD
        do
            local num = 1
            for i, _ in ipairs(BG.PlayerItemsLevel) do
                for player, v in pairs(BiaoGe.FBCD[realmID]) do
                    if BG.PlayerItemsLevel[i].player == player then
                        if type(v) == "table" and Size(v) ~= 0 then
                            -- 玩家名字
                            local t = BG.FBCDFrame:CreateFontString()
                            t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                            t:SetPoint("TOPLEFT", BG.FBCDFrame, "TOPLEFT",
                                FBCDchoice_table[1].width, -10 - height * n)
                            for i, cd in pairs(BiaoGe.FBCD[realmID][player]) do
                                if type(cd) == "table" then
                                    local level = ""
                                    if BiaoGe.PlayerItemsLevel[realmID][cd.player] and BiaoGe.PlayerItemsLevel[realmID][cd.player] ~= 0 then
                                        level = " |cff808080(" .. Round(BiaoGe.PlayerItemsLevel[realmID][cd.player], 0) .. ")|r"
                                    end
                                    t:SetText(cd.colorplayer .. level)
                                    break
                                end
                            end
                            -- 副本CD
                            for i, cd in pairs(BiaoGe.FBCD[realmID][player]) do
                                for ii, vv in pairs(FBCDchoice_table) do -- 创建cd勾勾
                                    if (cd.fbId and (cd.fbId == vv.fbId)) and ((cd.num and (cd.num == vv.num)) or (not vv.num)) then
                                        local tx = BG.FBCDFrame:CreateTexture(nil, "OVERLAY")
                                        tx:SetSize(16, 16)
                                        tx:SetPoint("TOP", BG.FBCDFrame, "TOPLEFT",
                                            (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                            (-8 - height * n))
                                        tx:SetTexture("interface/raidframe/readycheck-ready")
                                    end
                                end
                            end

                            -- 日常
                            if BiaoGe.QuestCD[realmID][player] then
                                for name in pairs(BiaoGe.QuestCD[realmID][player]) do
                                    for ii, vv in ipairs(FBCDchoice_table) do -- 创建cd勾勾
                                        if name == vv.name then
                                            local tx = BG.FBCDFrame:CreateTexture(nil, "OVERLAY")
                                            tx:SetSize(16, 16)
                                            tx:SetPoint("TOP", BG.FBCDFrame, "TOPLEFT",
                                                (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                                (-8 - height * n))
                                            tx:SetTexture("interface/raidframe/readycheck-ready")
                                        end
                                    end
                                end
                            end

                            -- 专业
                            if BiaoGe.tradeSkillCooldown and BiaoGe.tradeSkillCooldown[realmID] and BiaoGe.tradeSkillCooldown[realmID][player] then
                                for profession, v in pairs(BiaoGe.tradeSkillCooldown[realmID][player]) do
                                    for ii, vv in ipairs(FBCDchoice_table) do -- 创建cd勾勾
                                        if profession == vv.name then
                                            local t = f:CreateFontString()
                                            t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                                            t:SetPoint("TOP", BG.FBCDFrame, "TOPLEFT",
                                                (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                                (-8 - height * n))
                                            if v.ready then
                                                t:SetTextColor(RGB("00FF00"))
                                                t:SetText(READY)
                                            else
                                                t:SetTextColor(RGB("FFD100"))
                                                t:SetText(BG.SecondsToTime(v.resettime))
                                            end
                                        end
                                    end
                                end
                            end
                            n = n + 1

                            if player == UnitName("player") then
                                local l = f:CreateLine(nil, "BACKGROUND")
                                l:SetStartPoint("TOPLEFT", BG.FBCDFrame, 5, -10 - height * (n - 0.5) + line_height)
                                l:SetEndPoint("TOPRIGHT", BG.FBCDFrame, -5, -10 - height * (n - 0.5) + line_height)
                                l:SetThickness(height - 4)
                                l:SetColorTexture(GetClassRGB(nil, "player", 0.3))
                            end

                            local l = f:CreateLine()
                            l:SetStartPoint("TOPLEFT", BG.FBCDFrame, 5, -10 - height * n + line_height)
                            l:SetEndPoint("TOPLEFT", BG.FBCDFrame, totalwidth - 5, -10 - height * n + line_height)
                            l:SetThickness(1)
                            l:SetColorTexture(RGB("808080", 1))
                            num = num + 1
                        end
                    end
                end
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
        n = n + 1
        local minimapText = L["|cff808080（右键打开设置）|r"]
        if position == "minimap" then
            minimapText = L["|cff808080（左键打开表格，右键打开设置）|r"]
        end
        local t = f:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, fontsize2, "OUTLINE")
        t:SetPoint("TOPLEFT", 15, -10 - height * n)
        t:SetText(BG.STC_g1(L["< 角色货币总览 >"]))
        t:SetJustifyH("LEFT")
        t:SetWordWrap(false) -- 截断
        t:SetWidth(totalwidth - 20)

        if BG.IsVanilla_Sod then
            local t_end = f:CreateFontString()
            t_end:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
            t_end:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 0, -3)
            t_end:SetText(BG.STC_dis((minimapText:gsub("（", ""):gsub("）", ""):gsub("%(", ""):gsub("%)", ""))))
            t_end:SetJustifyH("LEFT")
            t_end:SetWordWrap(false) -- 截断
            t_end:SetWidth(totalwidth - 20)
            FBCDResetbiaoti = t_end
        else
            t:SetText(t:GetText() .. minimapText)
        end

        FBCDbiaoti:SetWidth(totalwidth - 20) -- 标题设置宽度
        if FBCDResetbiaoti then
            FBCDResetbiaoti:SetWidth(totalwidth - 20)
        end

        n = n + 2

        BG.m_new = {} -- 用于复制数据
        local sum = {}
        do
            -- 给sum添加基础数据
            for i, v in pairs(MONEYchoice_table) do
                if v.id then      -- 排除掉角色名字
                    sum[v.id] = 0 -- 包含货币和金币
                end
            end

            -- 复制数据
            for player, value in pairs(BiaoGe.Money[realmID]) do
                BG.m_new[player] = BG.Copy(value)
                for i, v in pairs(MONEYchoice_table) do                   -- 给空key添加值0，主要是为了填补一些旧角色缺少某些新数据
                    if tonumber(v.id) and not BG.m_new[player][v.id] then -- 排除掉角色名字和金币
                        local tex
                        if BG.IsVanilla then
                            tex = v.tex
                        else
                            tex = C_CurrencyInfo.GetCurrencyInfo(v.id).iconFileID
                        end
                        BG.m_new[player][v.id] = { count = 0, tex = tex }
                    elseif v.id == "money" and not BG.m_new[player][v.id] then -- 如果是金币
                        BG.m_new[player][v.id] = 0
                    end
                end
                if not BG.m_new[player].player then
                    BG.m_new[player].player = player
                end
                if not BG.m_new[player].colorplayer then
                    BG.m_new[player].colorplayer = BG.STC_dis(player)
                end
            end

            -- 计算合计
            for k, v in pairs(BG.m_new) do
                for ii, vv in pairs(MONEYchoice_table) do
                    if vv.id then -- 排除掉角色名字
                        sum[vv.id] = sum[vv.id] + ((type(v[vv.id]) == "table" and v[vv.id].count) or v[vv.id])
                    end
                end
            end
        end

        -- Money标题
        do
            local right
            for i, v in ipairs(MONEYchoice_table) do
                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                if i == 1 then
                    t:SetPoint("TOPLEFT", f, "TOPLEFT", 15, -10 - height * n)
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
                t:SetWordWrap(false) -- 截断

                right = t
            end
            n = n + 1
            local l = f:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("TOPLEFT", BG.FBCDFrame, 5, -10 - height * n + line_height)
            l:SetEndPoint("TOPLEFT", BG.FBCDFrame, totalwidth - 5, -10 - height * n + line_height)
            l:SetThickness(1)
        end

        -- 角色货币
        do
            for i, _ in ipairs(BG.PlayerItemsLevel) do
                for p, v in pairs(BG.m_new) do
                    if BG.PlayerItemsLevel[i].player == p then
                        local levelText = ""
                        if BiaoGe.playerInfo[realmID] and BiaoGe.playerInfo[realmID][p] and BiaoGe.playerInfo[realmID][p].level then
                            levelText = BG.STC_dis(" (" .. BiaoGe.playerInfo[realmID][p].level .. ")")
                        end
                        local right
                        local name = v.colorplayer -- 名字
                        local t_name = f:CreateFontString()
                        t_name:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                        t_name:SetPoint("TOPLEFT", BG.FBCDFrame, "TOPLEFT", 15, -10 - height * n)
                        t_name:SetText(name .. levelText)
                        right = t_name

                        for ii, vv in ipairs(MONEYchoice_table) do
                            if vv.id then
                                local a = tostring(type(v[vv.id]) == "table" and v[vv.id].count or v[vv.id]):gsub("-", "")
                                    .. " " .. AddTexture(vv.tex) -- 牌子
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
                                t_paizi:SetText(a)
                                if a:match("^%d+") == "0" then
                                    t_paizi:SetTextColor(0.5, 0.5, 0.5)
                                end
                                right = t_paizi
                            end
                        end
                        n = n + 1

                        if player == v.player then
                            local l = f:CreateLine()
                            l:SetStartPoint("TOPLEFT", BG.FBCDFrame, 5, -10 - height * (n - 0.5) + line_height)
                            l:SetEndPoint("TOPRIGHT", BG.FBCDFrame, -5, -10 - height * (n - 0.5) + line_height)
                            l:SetThickness(height - 4)
                            l:SetColorTexture(GetClassRGB(nil, "player", 0.3))
                        end

                        local l = f:CreateLine()
                        l:SetStartPoint("TOPLEFT", BG.FBCDFrame, 5, -10 - height * n + line_height)
                        l:SetEndPoint("TOPLEFT", BG.FBCDFrame, totalwidth - 5, -10 - height * n + line_height)
                        l:SetThickness(1)
                        l:SetColorTexture(RGB("808080", 1))
                    end
                end
            end
            do -- 合计
                if Size(BG.m_new) ~= 0 then
                    local right
                    local t_name = f:CreateFontString()
                    t_name:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
                    t_name:SetPoint("TOPLEFT", 15, -10 - height * n)
                    t_name:SetText(L["合计"])
                    right = t_name

                    for ii, vv in ipairs(MONEYchoice_table) do
                        if vv.id then
                            local a = (type(sum[vv.id]) == "table" and sum[vv.id].count or sum[vv.id]) .. " " .. AddTexture(vv.tex) -- 牌子
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
                            t_paizi:SetText(a)
                            if a:match("^%d+") == "0" then
                                t_paizi:SetTextColor(0.5, 0.5, 0.5)
                            end
                            right = t_paizi
                        end
                    end
                    n = n + 1
                end
            end
        end
        f:SetSize(totalwidth, 10 + height * n + 5)
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

    ------------------获取副本CD------------------
    do
        if not BiaoGe.FBCD then
            BiaoGe.FBCD = {}
        end
        if not BiaoGe.FBCD[realmID] then
            BiaoGe.FBCD[realmID] = {}
        end
        local player = UnitName("player")
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

            for p, v in pairs(BiaoGe.FBCD[realmID]) do -- 检查其他角色cd是否到期
                if p ~= player then
                    local yes
                    local player0, colorplayer0

                    for i = #BiaoGe.FBCD[realmID][p], 1, -1 do
                        local cd = BiaoGe.FBCD[realmID][p][i]
                        if cd and not player0 and not colorplayer0 then
                            player0 = cd.player
                            colorplayer0 = cd.colorplayer
                        end
                        if cd and cd.endtime then
                            if time >= cd.endtime then
                                tremove(BiaoGe.FBCD[realmID][p], i)
                            elseif time < cd.endtime then
                                cd.resettime = cd.endtime - time
                                yes = true
                            end
                        end
                    end
                    if not yes then
                        BiaoGe.FBCD[realmID][p] = {
                            {
                                player = player0,
                                colorplayer = colorplayer0,
                            }
                        }
                    end
                end
            end
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:RegisterEvent("ENCOUNTER_END")
        f:SetScript("OnEvent", function(self, even, bossId, _, _, _, success)
            if even ~= "ENCOUNTER_END" or (even == "ENCOUNTER_END" and success == 1) then
                BG.After(0.5, function()
                    RequestRaidInfo()
                end)
            end
        end)

        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:RegisterEvent("ENCOUNTER_END")
        f:RegisterEvent("UPDATE_INSTANCE_INFO")
        f:SetScript("OnEvent", function(self, even, bossId, _, _, _, success)
            if even ~= "ENCOUNTER_END" or (even == "ENCOUNTER_END" and success == 1) then
                BG.After(1, function()
                    BG.UpdateFBCD()
                    BG.UpdateFBCD_5M()
                    BG.GetLockoutID()
                end)
            end
        end)
    end

    ------------------5人本CD------------------
    do
        local height = 22
        local width_fb = 100
        local width_player = 65

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

        function BG.UpdateFBCD_5M()
            if BG.IsVanilla then return end

            if BG.FBCD_5M_Frame then
                BG.FBCD_5M_Frame:Hide()
            end

            -- 创建框体UI
            local parent = LFGParentFrame or PVEFrame
            local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 16,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.9)
            f:SetBackdropBorderColor(GetClassRGB(nil, "player"))
            f:SetSize(width_fb + 30, (#BG.FBCDall_5M_table + 3) * height + 8)
            if LFGParentFrame then
                f:SetPoint("TOPLEFT", LFGParentFrame, "TOPRIGHT", -25, -12)
            elseif PVEFrame then
                f:SetPoint("TOPLEFT", PVEFrame, "TOPRIGHT", 10, 0)
            end
            f:EnableMouse(true)
            if BiaoGe.options["FB5M"] == 0 then
                f:Hide()
            else
                f:Show()
            end
            BG.FBCD_5M_Frame = f

            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
            t:SetPoint("TOPLEFT", 15, -10)
            t:SetText(BG.STC_g1(L["< 角色5人本完成总览 >"]))
            t:SetJustifyH("LEFT")
            t:SetWordWrap(false) -- 截断
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
                t:SetWordWrap(false) -- 截断

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
            local last
            local n = 0
            for i, _ in ipairs(BG.PlayerItemsLevel) do
                for p, v in pairs(BiaoGe.FBCD[realmID]) do
                    if BG.PlayerItemsLevel[i].player == p then
                        if type(v) == "table" and Size(v) ~= 0 then
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
                            t:SetWordWrap(true) -- 截断
                            for i, cd in pairs(BiaoGe.FBCD[realmID][p]) do
                                if type(cd) == "table" then
                                    t:SetText(cd.colorplayer)
                                    break
                                end
                            end
                            f:SetWidth(t:GetWidth())

                            f:SetScript("OnEnter", function(self)
                                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                                GameTooltip:ClearLines()
                                GameTooltip:SetText(t:GetText())
                            end)
                            BG.GameTooltip_Hide(f)

                            -- 副本CD
                            for i, cd in pairs(BiaoGe.FBCD[realmID][p]) do
                                for ii, vv in ipairs(BG.FBCDall_5M_table) do -- 创建cd勾勾
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

                            if player == p then
                                local l = f:CreateLine(nil, "BACKGROUND")
                                l:SetStartPoint("TOP", f, 0, 0)
                                l:SetEndPoint("TOP", f, 0, -BG.FBCD_5M_Frame:GetHeight() + height * 2 + 5)
                                l:SetThickness(f:GetWidth() + 2)
                                l:SetColorTexture(GetClassRGB(nil, "player", 0.3))
                            end
                        end
                    end
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
    ------------------一键排灵魂烘炉------------------
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
            local bt = CreateFrame("Button", nil, PVEFrame, "UIPanelButtonTemplate")
            bt:SetSize(150, 23)
            bt:SetPoint("BOTTOMLEFT", 35, 5)
            if i == 1 then
                bt.type = "jieri"
                bt.tbl = { 286, 285, 287 } -- 火焰节、万圣节、美酒节
                -- bt.tbl = { 259 }           -- 燃烧的远征test
            elseif i == 2 then
                bt.type = "zhiding"
                bt.tbl = { 2463 } -- 伽马灵魂烘炉
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
                        LFDQueueFrameSpecificList_Update()
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
        hooksecurefunc("LFDQueueFrame_SetType", function(value)
            if PVEFrame:IsVisible() then
                BiaoGe.lastChooseLFD[realmID][player].type = value
            end
        end)
        hooksecurefunc("LFGDungeonList_SetDungeonEnabled", function(dungeonID, isChecked)
            BG.After(0, function()
                -- pt("2")
                if isOnClick then
                    BiaoGe.lastChooseLFD[realmID][player].dungeons[dungeonID] = isChecked
                end
            end)
        end)
        hooksecurefunc("LFGDungeonListCheckButton_OnClick", function(button, category, dungeonList, hiddenByCollapseList)
            -- pt("1")
            isOnClick = true
            BG.After(0.01, function()
                -- pt("3")
                isOnClick = false
            end)
            -- local parent = button:GetParent();
            -- local dungeonID = parent.id;
            -- local isChecked = button:GetChecked();
        end)
    end
    ------------------日常任务------------------
    do
        if not BiaoGe.QuestCD then
            BiaoGe.QuestCD = {}
        end
        if not BiaoGe.QuestCD[realmID] then
            BiaoGe.QuestCD[realmID] = {}
        end
        if not BiaoGe.QuestCD[realmID][player] then
            BiaoGe.QuestCD[realmID][player] = {}
        end

        -- 日常
        if BG.IsVanilla_Sod then
            BG.dayQuests = {
                huiguweek = { 79090, 79098 }, -- 灰谷
            }
        elseif BG.IsWLK then
            BG.dayQuests = {
                gamma = { 83713, 78752 },
                heroe = { 83714, 84552, 78753 },
                zhubao = { 12959, 12962, 12961, 12958, 12963, 12960 },
                cooking = { 13114, 13116, 13113, 13115, 13112,
                    13102, 13100, 13107, 13101, 13103 },
                fish = { 13836, 13833, 13834, 13832, 13830 },
            }
        end

        local function UpdateDayQuest(questID)
            if not BG.dayQuests then return end
            for name in pairs(BG.dayQuests) do
                for _, _questID in pairs(BG.dayQuests[name]) do
                    if _questID == questID then
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
                        BiaoGe.QuestCD[realmID][player][name] = {
                            name = name,
                            player = player,
                            colorplayer = colorplayer,
                            questID = questID,
                            resettime = secondsUntilNext7am,
                            endtime = timestamp
                        }
                        return
                    end
                end
            end
        end

        -- 周常
        if BG.IsVanilla_Sod then
        elseif not BG.IsVanilla_60 then
            BG.weekQuests = {
                week1 = { 24579, 24580, 24581, 24582, 24583, 24584, 24585, 24586, 24587, 24588, 24589, 24590, },
            }
        end

        local function UpdateWeekQuest(questID)
            if not BG.weekQuests then return end
            for name in pairs(BG.weekQuests) do
                for _, _questID in pairs(BG.weekQuests[name]) do
                    if _questID == questID then
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
                        BiaoGe.QuestCD[realmID][player][name] = {
                            name = name,
                            player = player,
                            colorplayer = colorplayer,
                            questID = name,
                            resettime = secondsToNextThursday,
                            endtime = timestamp
                        }
                        -- BG.SendSystemMessage(format(L["周常任务已记录，距离重置还剩%s。"], date("%d天%H小时", secondsToNextThursday)))
                        return
                    end
                end
            end
        end

        -- 交任务时触发
        BG.RegisterEvent("QUEST_TURNED_IN", function(self, even, questID)
            UpdateDayQuest(questID)
            UpdateWeekQuest(questID)
        end)

        -- 检查全部角色的任务重置cd是否到期（第二天凌晨7点）
        BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
            if isLogin or isReload then
                if BG.IsVanilla_Sod then
                    local p, r = UnitFullName("player")
                    BG.Once("QuestCD", "240403" .. p .. "-" .. r, function()
                        BiaoGe.QuestCD[realmID][player]["huiguweek"] = nil
                        for questID in pairs(GetQuestsCompleted()) do
                            UpdateDayQuest(questID)
                        end
                    end)
                end
            end

            local time = GetServerTime()
            for player in pairs(BiaoGe.QuestCD[realmID]) do
                for name, v in pairs(BiaoGe.QuestCD[realmID][player]) do
                    if time < v.endtime then
                        v.resettime = v.endtime - time
                    else
                        BiaoGe.QuestCD[realmID][player][name] = nil
                    end
                end
            end
        end)
    end
    ------------------获取货币信息------------------
    do
        if not BiaoGe.Money then
            BiaoGe.Money = {}
        end
        if not BiaoGe.Money[realmID] then
            BiaoGe.Money[realmID] = {}
        end
        local player = UnitName("player")
        if not BiaoGe.Money[realmID][player] then
            BiaoGe.Money[realmID][player] = {}
        end

        function BG.MONEYupdate()
            local g = {}

            local player = UnitName("player")
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
    end

    ------------------当前角色货币面板------------------
    do
        function BG.MoneyBannerUpdate()
            if not BG.MainFrame:IsVisible() then return end
            -- 根据你选择的货币，生成table
            MONEYchoice_table = {}
            for i, v in ipairs(BG.MONEYall_table) do
                for id, yes in pairs(BiaoGe.MONEYchoice) do
                    if v.id == id then
                        tinsert(MONEYchoice_table, v)
                    end
                end
            end

            BG.MONEYupdate()
            local g = BiaoGe.Money[realmID][player]
            local t = {}
            local a = g.colorplayer .. "  "
            tinsert(t, a) -- 玩家

            for i, v in ipairs(MONEYchoice_table) do
                if v.id ~= "money" then
                    local a = g[v.id].count .. " " .. AddTexture(v.tex)
                    tinsert(t, a) -- 牌子
                else
                    local a = g.money .. " " .. AddTexture(v.tex)
                    tinsert(t, a) -- 金币
                end
            end
            local text = table.concat(t, "   ")
            BG.ButtonMoney:SetText(text)
            BG.ButtonMoney.text = BG.ButtonMoney:GetFontString()
            BG.ButtonMoney.text:SetPoint("RIGHT", -20, 0)
            BG.ButtonMoney:SetWidth(BG.ButtonMoney.text:GetWidth() + 30)
            BG.ButtonMoney.tex:SetWidth(BG.ButtonMoney.text:GetWidth() + 100)
        end

        do -- 创建UI
            local f = CreateFrame("Button", nil, BG.MainFrame)
            f:SetSize(0, 24)
            f:SetPoint("BOTTOMRIGHT", -1, 1)
            f:SetNormalFontObject(BG.FontWhite13)
            BG.ButtonMoney = f

            f.tex = f:CreateTexture()
            f.tex:SetSize(0, 24)
            f.tex:SetPoint("BOTTOMRIGHT")
            f.tex:SetTexture("Interface\\Buttons\\WHITE8x8")
            local c1, c2, c3 = GetClassRGB(nil, "player")
            f.tex:SetGradient("HORIZONTAL", CreateColor(c1, c2, c3, 0), CreateColor(c1, c2, c3, 0.25))

            f:SetScript("OnEnter", function(self)
                BG.SetFBCD()
                BG.FBCDFrame:ClearAllPoints()
                BG.FBCDFrame:SetPoint("BOTTOMRIGHT", BG.ButtonMoney, "TOPRIGHT", 0, 0)
                BG.FBCDFrame:Show()
            end)
            f:SetScript("OnLeave", function(self)
                BG.FBCDFrame:Hide()
            end)
            f:SetScript("OnMouseUp", function(self)
                ns.InterfaceOptionsFrame_OpenToCategory("|cff00BFFFBiaoGe|r")
                BG.MainFrame:Hide()
                BG.PlaySound(1)
            end)
        end

        do -- 事件
            local f = CreateFrame("Frame")
            f:RegisterEvent("PLAYER_ENTERING_WORLD")
            f:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
            f:RegisterEvent("PLAYER_MONEY")
            f:RegisterEvent("BAG_UPDATE_DELAYED")
            f:SetScript("OnEvent", function(self, even, ...)
                C_Timer.After(0.5, function()
                    BG.MONEYupdate()
                end)
            end)
        end
    end

    ------------------角色装等------------------
    do
        if not BiaoGe.PlayerItemsLevel then
            BiaoGe.PlayerItemsLevel = {}
        end
        if not BiaoGe.PlayerItemsLevel[realmID] then
            BiaoGe.PlayerItemsLevel[realmID] = {}
        end
        if not BiaoGe.PlayerItemsLevel[realmID][player] then
            BiaoGe.PlayerItemsLevel[realmID][player] = 0
        end

        local function GetPlayerItemsLevel()
            local _, avgLevel = GetAverageItemLevel()
            local avgLevel0 = Round(avgLevel, 0)
            BiaoGe.PlayerItemsLevel[realmID][player] = avgLevel

            -- 更新集结号密语装等
            if BG.MeetingHorn and BG.MeetingHorn.iLevelCheckButton then
                BG.MeetingHorn.iLevelCheckButton.Text:SetText(avgLevel0)
            end

            BG.PlayerItemsLevel = {}
            for player, ilevel in pairs(BiaoGe.PlayerItemsLevel[realmID]) do
                local a = { player = player, ilevel = tonumber(ilevel) }
                tinsert(BG.PlayerItemsLevel, a)
            end
            sort(BG.PlayerItemsLevel, function(a, b)
                return a.ilevel > b.ilevel
            end)
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:SetScript("OnEvent", function(self, even, ...)
            C_Timer.After(1, function()
                GetPlayerItemsLevel()
            end)
        end)

        local f = CreateFrame("Frame")
        f:RegisterEvent("UNIT_INVENTORY_CHANGED")
        f:SetScript("OnEvent", function(self, even, ...)
            C_Timer.After(0.5, function()
                GetPlayerItemsLevel()
            end)
        end)
    end

    ------------------专业技能CD------------------
    do
        if not BiaoGe.tradeSkillCooldown then
            BiaoGe.tradeSkillCooldown = {}
        end
        if not BiaoGe.tradeSkillCooldown[realmID] then
            BiaoGe.tradeSkillCooldown[realmID] = {}
        end
        if not BiaoGe.tradeSkillCooldown[realmID][player] then
            BiaoGe.tradeSkillCooldown[realmID][player] = {}
        end

        if BG.IsVanilla_Sod then
            local tbl = {
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

            local function GetCooldown()
                local time = GetServerTime()
                for profession, v in pairs(tbl) do
                    local startTime, duration = GetSpellCooldown(v.spell)
                    startTime = startTime > GetTime() and (startTime - 2 ^ 32 / 1000) or startTime
                    local cooldown = startTime + duration - GetTime()
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
            local function UpdateProfessionCD()
                local time = GetServerTime()
                for p, _ in pairs(BiaoGe.tradeSkillCooldown[realmID]) do -- 检查其他角色cd是否到期
                    local i = 3
                    for profession, v in pairs(BiaoGe.tradeSkillCooldown[realmID][p]) do
                        if v.endtime then
                            if time >= v.endtime then
                                v.resettime = nil
                                v.endtime = nil
                                v.ready = true
                                local color
                                if v.class then
                                    color = select(4, GetClassColor(v.class))
                                end
                                local name = color and "|c" .. color .. p .. "|r: " or p .. ": "
                                if p == UnitName("player") then
                                    name = color and "|c" .. color .. L["我"] .. "|r: " or L["我"] .. ": "
                                end
                                BG.After(i, function()
                                    SendSystemMessage(BG.BG .. BG.STC_g1(format(L["%s%s已就绪！"],
                                        name, tbl[profession].name)))
                                    SendSystemMessage(BG.BG .. BG.STC_g1(format(L["%s%s已就绪！"],
                                        name, tbl[profession].name)))
                                    SendSystemMessage(BG.BG .. BG.STC_g1(format(L["%s%s已就绪！"],
                                        name, tbl[profession].name)))
                                    PlaySoundFile(BG["sound_" .. profession .. "Ready" .. BiaoGe.options.Sound], "Master")
                                end)
                                i = i + 3
                            elseif time < v.endtime then
                                v.resettime = v.endtime - time
                            end
                        end
                    end
                end
            end

            local _msg = TRADESKILL_LOG_FIRSTPERSON:gsub("%%s", "(.+)")
            BG.RegisterEvent("CHAT_MSG_TRADESKILLS", function(self, even, msg)
                if not strfind(msg, _msg) then return end
                GetCooldown()
            end)

            BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
                if not (isLogin or isReload) then return end
                GetCooldown()
                UpdateProfessionCD()
            end)
            C_Timer.NewTicker(60, function()
                UpdateProfessionCD()
            end)

            BG.RegisterEvent("SKILL_LINES_CHANGED", function(self, even)
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
end
