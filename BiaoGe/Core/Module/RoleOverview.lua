local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local RGB_16 = ADDONSELF.RGB_16
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local GetText_T = ADDONSELF.GetText_T
local FrameDongHua = ADDONSELF.FrameDongHua
local FrameHide = ADDONSELF.FrameHide
local AddTexture = ADDONSELF.AddTexture
local GetItemID = ADDONSELF.GetItemID
local Round = ADDONSELF.Round

local pt = print

function BG.RoleOverviewUI()
    local player = UnitName("player")
    local RealmId = GetRealmID()

    if not BiaoGe.FBCDchoice then
        if BG.IsVanilla() then
            BiaoGe.FBCDchoice = {
                ["NAXX"] = 1,
                ["TAQ"] = 1,
                ["BWL"] = 1,
                ["MC"] = 1,
                ["AQL"] = 1,
                ["ZUG"] = 1,
                ["Gno"] = 1,
                ["BD"] = 1,
                ["huiguweek"] = 1,
            }
        else
            BiaoGe.FBCDchoice = {
                ["25ICC"] = 1,
                ["10ICC"] = 1,
                ["25RS"] = 1,
                ["10RS"] = 1,
                ["25VOA"] = 1,
                ["10VOA"] = 1,
                ["gamma"] = 1,
                ["heroe"] = 1,
                ["week1"] = 1,
            }
        end
    end
    do
        if BG.IsVanilla() then
            BG.Once("FBCDchoice", 240106, function()
                -- 因为永久60，需要复原一下
                BiaoGe.FBCDchoice = {
                    ["NAXX"] = 1,
                    ["TAQ"] = 1,
                    ["BWL"] = 1,
                    ["MC"] = 1,
                    ["AQL"] = 1,
                    ["ZUG"] = 1,
                    ["BD"] = 1,
                }
            end)
            BG.Once("FBCDchoice", 240113, function()
                BiaoGe.FBCDchoice["huiguweek"] = 1
            end)
            BG.Once("FBCDchoice", 240208, function()
                BiaoGe.FBCDchoice["Gno"] = 1
            end)
        else
            BG.Once("FBCDchoice", 240111, function()
                BiaoGe.FBCDchoice["25RS"] = 1
                BiaoGe.FBCDchoice["10RS"] = 1
            end)
        end
    end

    if not BiaoGe.MONEYchoice then
        if BG.IsVanilla() then
            BiaoGe.MONEYchoice = {
                ["money"] = 1,
            }
        else
            BiaoGe.MONEYchoice = {
                [341] = 1,
                [301] = 1,
                [221] = 1,
                [102] = 1,
                [101] = 1,
                [2711] = 1,
                [2589] = 1,
                ["money"] = 1,
            }
        end
    end

    if BG.IsVanilla() then
        BG.MONEYall_table = {
            { name = L["金币"], color = "FFD700", id = "money", tex = 237618, width = 90 }, -- 金币
        }
        if BG.IsVanilla_Sod() then
            BG.FBCDall_table = {
                { name = "Gno", color = "00BFFF", fbId = 90, num = 10 },
                { name = "BD", color = "00BFFF", fbId = 48, num = 10 },
                -- 周常
                { name = "huiguweek", name2 = L["灰谷周常"], color = "FF8C00", questID = "huiguweek" },
            }
        elseif BG.IsVanilla_60() then
            BG.FBCDall_table = {
                { name = "NAXX", color = "00BFFF", fbId = 533, num = 40 },
                { name = "TAQ", color = "00BFFF", fbId = 531, num = 40 },
                { name = "BWL", color = "00BFFF", fbId = 469, num = 40 },
                { name = "MC", color = "00BFFF", fbId = 409, num = 40 },
                { name = "AQL", color = "BA55D3", fbId = 509, num = 20 },
                { name = "ZUG", color = "BA55D3", fbId = 309, num = 20 },

            }
        end
    else
        BG.FBCDall_table = {
            --WLK
            { name = "25ICC", color = "9370DB", fbId = 631, num = 25 },
            { name = "10ICC", color = "9370DB", fbId = 631, num = 10 },
            { name = "25RS", color = "FF4500", fbId = 724, num = 25 },
            { name = "10RS", color = "FF4500", fbId = 724, num = 10 },
            { name = "25TOC", color = "FF69B4", fbId = 649, num = 25 },
            { name = "10TOC", color = "FF69B4", fbId = 649, num = 10 },
            { name = "25OL", color = "FFA500", fbId = 249, num = 25 },
            { name = "10OL", color = "FFA500", fbId = 249, num = 10 },
            { name = "25ULD", color = "00BFFF", fbId = 603, num = 25 },
            { name = "10ULD", color = "00BFFF", fbId = 603, num = 10 },
            { name = "25NAXX", color = "32CD32", fbId = 533, num = 25 },
            { name = "10NAXX", color = "32CD32", fbId = 533, num = 10 },
            { name = "25EOE", color = "1E90FF", fbId = 616, num = 25 },
            { name = "10EOE", color = "1E90FF", fbId = 616, num = 10 },
            { name = "25OS", color = "8B4513", fbId = 615, num = 25 },
            { name = "10OS", color = "8B4513", fbId = 615, num = 10 },
            { name = "25VOA", color = "FFFF00", fbId = 624, num = 25 },
            { name = "10VOA", color = "FFFF00", fbId = 624, num = 10 },
            --TBC
            { name = "SW", color = "D3D3D3", fbId = 580, num = 25 },
            { name = "BT", color = "D3D3D3", fbId = 564, num = 25 },
            { name = "HS", color = "D3D3D3", fbId = 534, num = 25 },
            { name = "TK", color = "D3D3D3", fbId = 550, num = 25 },
            { name = "SSC", color = "D3D3D3", fbId = 548, num = 25 },
            { name = "GL", color = "D3D3D3", fbId = 565, num = 25 },
            { name = "ML", color = "D3D3D3", fbId = 544, num = 25 },
            { name = "ZA", color = "D3D3D3", fbId = 568, num = 10 },
            { name = "KZ", color = "D3D3D3", fbId = 532, num = 10 },
            --CLASSIC
            { name = "TAQ", color = "D3D3D3", fbId = 531, num = 40 },
            { name = "AQL", color = "D3D3D3", fbId = 509, num = 20 },
            { name = "BWL", color = "D3D3D3", fbId = 469, num = 40 },
            { name = "MC", color = "D3D3D3", fbId = 409, num = 40 },
            { name = "ZUG", color = "D3D3D3", fbId = 309, num = 20 },
            -- 日常
            { name = "week1", name2 = L["周常"], color = "FF8C00", questID = "week1" },
            { name = "gamma", name2 = L["伽马"], color = "FF8C00", questID = 78752, },
            { name = "heroe", name2 = L["英雄"], color = "FF8C00", questID = 78753, },
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
        tinsert(FBCDchoice_table, 1, { name = L["角色"], color = "FFFFFF" })
        -- 根据你选择的货币，生成table
        for i, v in ipairs(BG.MONEYall_table) do
            for id, yes in pairs(BiaoGe.MONEYchoice) do
                if v.id == id then
                    tinsert(MONEYchoice_table, v)
                end
            end
        end
        tinsert(MONEYchoice_table, 1, { name = L["角色"], color = "FFFFFF", width = 80 })
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
        t:SetFont(BIAOGE_TEXT_FONT, fontsize2, "OUTLINE")
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
        for p, v in pairs(BiaoGe.FBCD[RealmId]) do
            for i, cd in pairs(BiaoGe.FBCD[RealmId][p]) do
                if cd.resettime then
                    if cd.fbId == 309 or cd.fbId == 568 or cd.fbId == 509 then -- ZUG ZA AQL
                        text3 = format(L["小团本 %s"], SecondsToTime(cd.resettime, true, nil, 2))
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
            if BG.IsVanilla() then
                local t_end = f:CreateFontString()
                t_end:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
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
                t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                if i == 1 then
                    t:SetPoint("TOPLEFT", f, "TOPLEFT", 15, -10 - height * n)
                elseif i == 2 then
                    t:SetPoint("TOPLEFT", f, "TOPLEFT", 140, -10 - height * n)
                else
                    t:SetPoint("TOPLEFT", right, "TOPRIGHT", width_jiange, 0)
                end
                if v.questID then
                    t:SetText("|cff" .. v.color .. v.name2 .. RR)
                else
                    t:SetText("|cff" .. v.color .. v.name .. RR)
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
                for p, v in pairs(BiaoGe.FBCD[RealmId]) do
                    if BG.PlayerItemsLevel[i].player == p then
                        if type(v) == "table" and Size(v) ~= 0 then
                            -- 玩家名字
                            local t = BG.FBCDFrame:CreateFontString()
                            t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                            t:SetPoint("TOPLEFT", BG.FBCDFrame, "TOPLEFT", FBCDchoice_table[1].width, -10 - height * n)
                            for i, cd in pairs(BiaoGe.FBCD[RealmId][p]) do
                                if type(cd) == "table" then
                                    local level = ""
                                    if BiaoGe.PlayerItemsLevel[RealmId][cd.player] and BiaoGe.PlayerItemsLevel[RealmId][cd.player] ~= 0 then
                                        level = " |cff808080(" .. Round(BiaoGe.PlayerItemsLevel[RealmId][cd.player], 0) .. ")|r"
                                    end
                                    t:SetText(cd.colorplayer .. level)
                                    break
                                end
                            end
                            -- 副本CD
                            for i, cd in pairs(BiaoGe.FBCD[RealmId][p]) do
                                for ii, vv in pairs(FBCDchoice_table) do -- 创建cd勾勾
                                    if (cd.fbId and (cd.fbId == vv.fbId)) and ((cd.num and (cd.num == vv.num)) or (not vv.num)) then
                                        local tx = BG.FBCDFrame:CreateTexture(nil, "OVERLAY")
                                        tx:SetSize(16, 16)
                                        tx:SetPoint("TOP", BG.FBCDFrame, "TOPLEFT",
                                            (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2), (-8 - height * n))
                                        tx:SetTexture("interface/raidframe/readycheck-ready")
                                    end
                                end
                            end

                            -- 日常
                            if BiaoGe.QuestCD[RealmId][p] then
                                for questID, v in pairs(BiaoGe.QuestCD[RealmId][p]) do
                                    for ii, vv in ipairs(FBCDchoice_table) do -- 创建cd勾勾
                                        if v.questID == vv.questID then
                                            local tx = BG.FBCDFrame:CreateTexture(nil, "OVERLAY")
                                            tx:SetSize(16, 16)
                                            tx:SetPoint("TOP", BG.FBCDFrame, "TOPLEFT",
                                                (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2), (-8 - height * n))
                                            tx:SetTexture("interface/raidframe/readycheck-ready")
                                        end
                                    end
                                end
                            end
                            n = n + 1

                            if player == p then
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
                t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
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
        t:SetFont(BIAOGE_TEXT_FONT, fontsize2, "OUTLINE")
        t:SetPoint("TOPLEFT", 15, -10 - height * n)
        t:SetText(BG.STC_g1(L["< 角色货币总览 >"]))
        t:SetJustifyH("LEFT")
        t:SetWordWrap(false) -- 截断
        t:SetWidth(totalwidth - 20)

        if BG.IsVanilla_Sod() then
            local t_end = f:CreateFontString()
            t_end:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
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
            for player, value in pairs(BiaoGe.Money[RealmId]) do
                BG.m_new[player] = value
                for i, v in pairs(MONEYchoice_table) do                   -- 给空key添加值0，主要是为了填补一些旧角色缺少某些新数据
                    if tonumber(v.id) and not BG.m_new[player][v.id] then -- 排除掉角色名字和金币
                        local tex = C_CurrencyInfo.GetCurrencyInfo(v.id).iconFileID
                        BG.m_new[player][v.id] = { count = 0, tex = tex }
                    elseif v.id == "money" and not BG.m_new[player][v.id] then -- 如果是金币
                        BG.m_new[player][v.id] = 0
                    end
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
                t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
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
                        local right
                        local name = v.colorplayer -- 名字
                        local t_name = f:CreateFontString()
                        t_name:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                        t_name:SetPoint("TOPLEFT", BG.FBCDFrame, "TOPLEFT", 15, -10 - height * n)
                        t_name:SetText(name)
                        right = t_name

                        for ii, vv in ipairs(MONEYchoice_table) do
                            if vv.id then
                                local a = tostring(type(v[vv.id]) == "table" and v[vv.id].count or v[vv.id]):gsub("-", "")
                                    .. " " .. AddTexture(vv.tex) -- 牌子
                                local t_paizi = f:CreateFontString()
                                t_paizi:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                                local width
                                if ii == 2 then
                                    width = MONEYchoice_table[ii - 1].width + MONEYchoice_table[ii].width
                                    t_paizi:SetPoint("TOPRIGHT", right, "TOPLEFT", width, 0)
                                else
                                    width = MONEYchoice_table[ii].width
                                    t_paizi:SetPoint("TOPRIGHT", right, "TOPRIGHT", width, 0)
                                end
                                t_paizi:SetText(a)
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
                    t_name:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                    t_name:SetPoint("TOPLEFT", 15, -10 - height * n)
                    t_name:SetText(L["合计"])
                    right = t_name

                    for ii, vv in ipairs(MONEYchoice_table) do
                        if vv.id then
                            local a = (type(sum[vv.id]) == "table" and sum[vv.id].count or sum[vv.id]) .. " " .. AddTexture(vv.tex) -- 牌子
                            local t_paizi = f:CreateFontString()
                            t_paizi:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                            local width
                            if ii == 2 then
                                width = MONEYchoice_table[ii - 1].width + MONEYchoice_table[ii].width
                                t_paizi:SetPoint("TOPRIGHT", right, "TOPLEFT", width, 0)
                            else
                                width = MONEYchoice_table[ii].width
                                t_paizi:SetPoint("TOPRIGHT", right, "TOPRIGHT", width, 0)
                            end
                            t_paizi:SetText(a)
                            right = t_paizi
                        end
                    end
                    n = n + 1
                end
            end
        end
        f:SetSize(totalwidth, 10 + height * n + 5)
    end

    ------------------获取副本CD------------------
    do
        if not BiaoGe.FBCD then
            BiaoGe.FBCD = {}
        end
        if not BiaoGe.FBCD[RealmId] then
            BiaoGe.FBCD[RealmId] = {}
        end
        local player = UnitName("player")
        local colorplayer = SetClassCFF(player, "player")

        function BG.UpdateFBCD()
            local time = time()
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
                    BiaoGe.FBCD[RealmId][player] = cd
                else
                    BiaoGe.FBCD[RealmId][player] = {
                        {
                            player = player,
                            colorplayer = colorplayer,
                        }
                    }
                end
            elseif UnitLevel("player") < BG.fullLevel then
                BiaoGe.FBCD[RealmId][player] = nil
            end

            for p, v in pairs(BiaoGe.FBCD[RealmId]) do -- 检查其他角色cd是否到期
                if p ~= player then
                    local yes
                    local player0, colorplayer0

                    for i = #BiaoGe.FBCD[RealmId][p], 1, -1 do
                        local cd = BiaoGe.FBCD[RealmId][p][i]
                        if cd and not player0 and not colorplayer0 then
                            player0 = cd.player
                            colorplayer0 = cd.colorplayer
                        end
                        if cd and cd.endtime then
                            if time >= cd.endtime then
                                tremove(BiaoGe.FBCD[RealmId][p], i)
                            elseif time < cd.endtime then
                                cd.resettime = cd.endtime - time
                                yes = true
                            end
                        end
                    end
                    if not yes then
                        BiaoGe.FBCD[RealmId][p] = {
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
                RequestRaidInfo()
            end
        end)

        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:RegisterEvent("ENCOUNTER_END")
        f:RegisterEvent("UPDATE_INSTANCE_INFO")
        f:SetScript("OnEvent", function(self, even, bossId, _, _, _, success)
            if even ~= "ENCOUNTER_END" or (even == "ENCOUNTER_END" and success == 1) then
                C_Timer.After(0.5, function()
                    BG.UpdateFBCD()
                    if not BG.IsVanilla() then
                        BG.UpdateFBCD_5M()
                    end
                end)
            end
        end)
    end

    if not BG.IsVanilla() then
        ------------------5人本CD------------------
        do
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

            local height = 22
            local width_fb = 100
            local width_player = 65
            for i, v in ipairs(BG.FBCDall_5M_table) do
                BG.FBCDall_5M_table[i].height = i * height
            end

            function BG.UpdateFBCD_5M()
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
                local name = "FB5M"
                if BiaoGe.options[name] == 0 then
                    f:Hide()
                else
                    f:Show()
                end
                BG.FBCD_5M_Frame = f

                local t = f:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
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
                    t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
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
                    for p, v in pairs(BiaoGe.FBCD[RealmId]) do
                        if BG.PlayerItemsLevel[i].player == p then
                            if type(v) == "table" and Size(v) ~= 0 then
                                -- 玩家名字
                                if not last then
                                    local t = BG.FBCD_5M_Frame:CreateFontString()
                                    t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
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
                                t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                                t:SetPoint("CENTER")
                                t:SetJustifyH("LEFT")
                                t:SetWordWrap(true) -- 截断
                                for i, cd in pairs(BiaoGe.FBCD[RealmId][p]) do
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
                                for i, cd in pairs(BiaoGe.FBCD[RealmId][p]) do
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
                    t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
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

        ------------------一键排灵魂熔炉------------------
        do
            local dungeonID = 2463 -- 伽马灵魂烘炉
            -- local dungeonID = 252 -- 英雄灵魂烘炉
            local fbID = 632

            local function OnClick(self)
                for i, id in ipairs(LFDDungeonList) do
                    if id < 0 then
                        LFGDungeonList_SetHeaderEnabled(1, id, false, LFDDungeonList, LFDHiddenByCollapseList)
                    end
                end
                LFGDungeonList_SetDungeonEnabled(dungeonID, true)
                LFDQueueFrameSpecificList_Update()
                LFDQueueFrame_UpdateRoleButtons()
                LFG_JoinDungeon(LE_LFG_CATEGORY_LFD, "specific", LFDDungeonList, LFDHiddenByCollapseList)
                BG.PlaySound(1)
            end

            local function OnEnter(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                GameTooltip:ClearLines()
                if self.dis then
                    GameTooltip:AddLine(L["副本已锁定"], 1, 0, 0, true)
                else
                    GameTooltip:AddLine(format(L["一键指定副本伽马%s"], GetRealZoneText(fbID)), 1, 1, 1, true)
                    GameTooltip:AddLine(BG.STC_dis(L["你可在插件设置-BiaoGe-其他功能里关闭这个功能"]), 1, 1, 1, true)
                end
                GameTooltip:Show()
            end

            local bt = CreateFrame("Button", nil, PVEFrame, "UIPanelButtonTemplate")
            bt:SetSize(150, 20)
            bt:SetPoint("BOTTOMLEFT", 30, 5)
            bt:SetText(format(L["指定%s"], GetRealZoneText(fbID)))
            bt:SetScript("OnClick", OnClick)
            bt:SetScript("OnEnter", OnEnter)
            BG.GameTooltip_Hide(bt)

            local f = CreateFrame("Frame", nil, bt)
            f:SetAllPoints()
            f.dis = true
            f:SetScript("OnEnter", OnEnter)
            BG.GameTooltip_Hide(f)
            local disframe = f

            local f = CreateFrame("Frame")
            f:RegisterEvent("PLAYER_ENTERING_WORLD")
            f:RegisterEvent("ENCOUNTER_END")
            f:RegisterEvent("UPDATE_INSTANCE_INFO")
            f:SetScript("OnEvent", function(self, even, bossId, _, _, _, success)
                if even ~= "ENCOUNTER_END" or (even == "ENCOUNTER_END" and success == 1) then
                    local playerName, lockedReason, subReason1, subReason2, secondReasonID, secondReasonString = GetLFDLockInfo(dungeonID, 1)
                    if lockedReason ~= 0 then
                        bt:Disable()
                        disframe:Show()
                    else
                        bt:Enable()
                        disframe:Hide()
                    end
                end
            end)

            hooksecurefunc("PVEFrame_OnShow", function(self)
                if UnitLevel("player") < 80 then
                    bt:Hide()
                    return
                end

                if BiaoGe.options["zhidingFB"] ~= 1 then
                    bt:Hide()
                else
                    bt:Show()
                end
            end)

            --DEBUG
            -- 打印每个按钮的副本ID
            -- hooksecurefunc("LFGDungeonListCheckButton_OnClick", function(button, category, dungeonList, hiddenByCollapseList)
            --     local parent = button:GetParent();
            --     local dungeonID = parent.id;
            --     pt(dungeonID)
            -- end)
        end
    end
    ------------------日常任务------------------
    do
        if not BiaoGe.QuestCD then
            BiaoGe.QuestCD = {}
        end
        if not BiaoGe.QuestCD[RealmId] then
            BiaoGe.QuestCD[RealmId] = {}
        end
        if not BiaoGe.QuestCD[RealmId][player] then
            BiaoGe.QuestCD[RealmId][player] = {}
        end

        -- 日常
        if not BG.IsVanilla() then
            BG.dayQuests = {
                { questID = 78752, name = L["伽马"], color = "FF8C00", },
                { questID = 78753, name = L["英雄"], color = "FF8C00", },
            }
        end

        local function UpdateDayQuest(questID)
            if not BG.dayQuests then return end
            for i, v in pairs(BG.dayQuests) do
                if v.questID == questID then
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
                    local a = {
                        player = player,
                        colorplayer = colorplayer,
                        questID = questID,
                        resettime = secondsUntilNext7am,
                        endtime = timestamp
                    }
                    BiaoGe.QuestCD[RealmId][player][questID] = a
                    return
                end
            end
        end

        -- 周常
        if BG.IsVanilla_Sod() then
            BG.weekQuests = {
                huiguweek = { 79098, 79090, },
            }
        elseif not BG.IsVanilla_60() then
            BG.weekQuests = {
                week1 = { 24579, 24580, 24581, 24582, 24583, 24584, 24585, 24586, 24587, 24588, 24589, 24590, },
            }
        end

        local function UpdateWeekQuest(questID, Region)
            if not BG.weekQuests then return end
            for k, v in pairs(BG.weekQuests) do
                for i, _questID in pairs(BG.weekQuests[k]) do
                    if _questID == questID then
                        local resetDay = 2
                        if Region == "CN" then
                            resetDay = 4
                        end

                        local currentTimestamp = GetServerTime()
                        local nextThursdayTimestamp
                        local currentWeekday = date("%w", currentTimestamp)
                        local daysToThursday = resetDay - currentWeekday

                        local today = date("*t", currentTimestamp)
                        -- 如果时间小于当天凌晨7点
                        if daysToThursday == 0 and today.hour < 7 then
                            today.hour = 7
                            today.min = 0
                            today.sec = 0
                            nextThursdayTimestamp = time(today)
                        else
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
                        local secondsToNextThursday = nextThursdayTimestamp - currentTimestamp
                        local timestamp = currentTimestamp + secondsToNextThursday

                        local colorplayer = SetClassCFF(player, "player")
                        local a = {
                            player = player,
                            colorplayer = colorplayer,
                            questID = k,
                            resettime = secondsToNextThursday,
                            endtime = timestamp
                        }
                        BiaoGe.QuestCD[RealmId][player][k] = a
                        return
                    end
                end
            end
        end

        -- 交任务时触发
        BG.RegisterEvent("QUEST_TURNED_IN", function(self, even, questID)
            UpdateDayQuest(questID)

            if BG.IsCN() then
                UpdateWeekQuest(questID, "CN")
            else
                UpdateWeekQuest(questID, "US")
            end
        end)

        -- 检查全部角色的任务重置cd是否到期（第二天凌晨7点）
        BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even)
            if BG.IsVanilla_Sod() then
                BG.Once("QuestCD", 240113, function()
                    for questID in pairs(GetQuestsCompleted()) do
                        for k, v in pairs(BG.weekQuests) do
                            for i, _questID in pairs(BG.weekQuests[k]) do
                                if _questID == questID then
                                    if BG.IsCN() then
                                        UpdateWeekQuest(questID, "CN")
                                    else
                                        UpdateWeekQuest(questID, "US")
                                    end
                                end
                            end
                        end
                    end
                end)
            end

            local time = GetServerTime()
            for p, _ in pairs(BiaoGe.QuestCD[RealmId]) do
                for questID, v in pairs(BiaoGe.QuestCD[RealmId][p]) do
                    local yes
                    if time >= v.endtime then
                        BiaoGe.QuestCD[RealmId][p][questID] = nil
                    elseif time < v.endtime then
                        v.resettime = v.endtime - time
                        yes = true
                    end
                    if not yes then
                        BiaoGe.QuestCD[RealmId][p][questID] = nil
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
        if not BiaoGe.Money[RealmId] then
            BiaoGe.Money[RealmId] = {}
        end
        local player = UnitName("player")
        if not BiaoGe.Money[RealmId][player] then
            BiaoGe.Money[RealmId][player] = {}
        end

        function BG.MONEYupdate()
            local g = {}

            local player = UnitName("player")
            g.player = player
            g.colorplayer = SetClassCFF(player, "player")

            local money = floor(GetMoney() / 1e4)
            g.money = money
            for i, v in ipairs(BG.MONEYall_table) do
                if v.id ~= "money" then
                    local count = C_CurrencyInfo.GetCurrencyInfo(v.id).quantity
                    local tex = C_CurrencyInfo.GetCurrencyInfo(v.id).iconFileID
                    g[v.id] = { count = count, tex = tex }
                end
            end
            return g
        end
    end

    ------------------当前角色货币面板------------------
    do
        function BG.MoneyBannerupdate()
            -- 根据你选择的货币，生成table
            MONEYchoice_table = {}
            for i, v in ipairs(BG.MONEYall_table) do
                for id, yes in pairs(BiaoGe.MONEYchoice) do
                    if v.id == id then
                        tinsert(MONEYchoice_table, v)
                    end
                end
            end

            local g = BG.MONEYupdate()
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
            BG.ButtonMoney.text:SetPoint("BOTTOMRIGHT", BG.ButtonMoney, "BOTTOMRIGHT", -30, 3)
            BG.ButtonMoney:SetWidth(BG.ButtonMoney.text:GetWidth() + 30)
            BG.ButtonMoney.tex:SetWidth(BG.ButtonMoney.text:GetWidth() + 100)
        end

        do -- 创建UI
            local f = CreateFrame("Button", nil, BG.MainFrame)
            f:SetSize(0, 22)
            f:SetPoint("BOTTOMRIGHT", -3, 3)
            f:SetNormalFontObject(BG.FontWhite13)
            BG.ButtonMoney = f

            f.tex = f:CreateTexture()
            f.tex:SetSize(0, 19)
            f.tex:SetPoint("BOTTOMRIGHT")
            f.tex:SetTexture("Interface\\Buttons\\WHITE8x8")
            local c1, c2, c3 = GetClassRGB(nil, "player")
            f.tex:SetGradient("HORIZONTAL", CreateColor(c1, c2, c3, 0), CreateColor(c1, c2, c3, 0.15))

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
                InterfaceOptionsFrame_OpenToCategory("|cff00BFFFBiaoGe|r")
                BG.MainFrame:Hide()
                PlaySound(BG.sound1, "Master")
            end)
        end

        do -- 事件
            local f = CreateFrame("Frame")
            f:RegisterEvent("PLAYER_ENTERING_WORLD")
            f:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
            f:RegisterEvent("PLAYER_MONEY")
            f:SetScript("OnEvent", function(self, even, ...)
                C_Timer.After(0.5, function()
                    BG.MoneyBannerupdate()
                    BiaoGe.Money[RealmId][player] = BG.MONEYupdate()
                end)
            end)
        end
    end

    ------------------角色装等------------------
    do
        if not BiaoGe.PlayerItemsLevel then
            BiaoGe.PlayerItemsLevel = {}
        end
        if not BiaoGe.PlayerItemsLevel[RealmId] then
            BiaoGe.PlayerItemsLevel[RealmId] = {}
        end
        if not BiaoGe.PlayerItemsLevel[RealmId][player] then
            BiaoGe.PlayerItemsLevel[RealmId][player] = 0
        end

        local _, class = UnitClass("player")
        local shuangshou = GetInventoryItemID("player", 16) -- 提前缓存
        if shuangshou then
            GetItemInfo(shuangshou)
        end

        function BG.IsShuangShou()
            local table = { 1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 }

            local shuangshou = GetInventoryItemID("player", 16)
            if shuangshou then
                local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID = GetItemInfo(shuangshou)
                if EquipLoc ~= "INVTYPE_2HWEAPON" then
                    tinsert(table, 17)
                end
            end
            if class ~= "DRUID" and class ~= "PALADIN" and class ~= "SHAMAN" and class ~= "DEATHKNIGHT" then
                tinsert(table, 18)
            end

            return table, #table
        end

        function BG.GetPlayerItemsLevel()
            local table, count = BG.IsShuangShou()
            local sum = 0
            for _, invSlotId in pairs(table) do
                local itemId = GetInventoryItemID("player", invSlotId)
                if itemId then
                    local name, link, quality, level, _, _, _, _, _, Texture, _, typeID, subclassID = GetItemInfo(itemId)
                    if level then
                        sum = sum + level
                    end
                end
            end
            local avgLevel = sum / count
            local avgLevel0 = Round(sum / count, 0)
            BiaoGe.PlayerItemsLevel[RealmId][player] = avgLevel

            -- 更新集结号密语装等
            if BG.MeetingHorn and BG.MeetingHorn.iLevelCheckButton then
                BG.MeetingHorn.iLevelCheckButton.Text:SetText(avgLevel0)
            end

            BG.PlayerItemsLevel = {}
            for player, ilevel in pairs(BiaoGe.PlayerItemsLevel[RealmId]) do
                local a = { player = player, ilevel = tonumber(ilevel) }
                tinsert(BG.PlayerItemsLevel, a)
            end
            sort(BG.PlayerItemsLevel, function(a, b)
                if a.ilevel > b.ilevel then
                    return true
                end
            end)
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:SetScript("OnEvent", function(self, even, ...)
            local table, count = BG.IsShuangShou()
            for _, invSlotId in pairs(table) do
                local itemId = GetInventoryItemID("player", invSlotId)
                if itemId then
                    GetItemInfo(itemId)
                end
            end
            C_Timer.After(1, function()
                BG.GetPlayerItemsLevel()
            end)
        end)

        local f = CreateFrame("Frame")
        f:RegisterEvent("UNIT_INVENTORY_CHANGED")
        f:SetScript("OnEvent", function(self, even, ...)
            C_Timer.After(0.2, function()
                BG.GetPlayerItemsLevel()
            end)
        end)
    end
end

--[[

/run local real=GetRealmID() for p,_ in pairs(BiaoGe.QuestCD[real]) do for k,v in pairs(BiaoGe.QuestCD[real][p]) do local t = v.endtime print("角色："..v.player.."，".."任务ID："..v.questID.."，"..date("任务重置：%m月%d日%H时",t)) end end



				{
					["colorplayer"] = "|cffff7d0a玛丨西|r",
					["player"] = "玛丨西",
					["questID"] = 78752,
					["resettime"] = 224808,
					["endtime"] = 1698275102,
				}, -- [1]

 ]]
