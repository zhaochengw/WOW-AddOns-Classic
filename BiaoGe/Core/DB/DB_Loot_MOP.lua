if not BG.IsMOP then return end

local _, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local pt = print

-- 副本掉落
do
    -- P1
    do
        -- 团本
        local FB = "MSV"
        do
            -- H
            BG.Loot[FB].H.boss1  = { 87012, 87020, 87016, 87018, 89929, 87014, 89931, 87060, 89930, 87019, 87017, 87013, 87021, 87015, }
            BG.Loot[FB].H.boss2  = { 89425, 87029, 87024, 87028, 87044, 87026, 87027, 87025, 87022, 87030, 87031, 87023, 89932, 89933, }
            BG.Loot[FB].H.boss3  = { 87032, 87039, 87036, 87041, 87038, 87033, 87043, 89934, 87034, 87042, 87037, 87035, 87040, }
            BG.Loot[FB].H.boss4  = { 87046, 87050, 87051, 87053, 87045, 87049, 89936, 87048, 87054, 89935, 87052, 87056, 87047, 87055, }
            BG.Loot[FB].H.boss5  = { 87061, 87062, 87066, 89939, 87068, 87058, 87059, 89938, 87064, 87067, 89937, 87065, 87057, 87063, }
            BG.Loot[FB].H.boss6  = { 87074, 87069, 87070, 89940, 87073, 87076, 87078, 89941, 89942, 87825, 87071, 87077, 87075, 87072, }
            -- 恐惧之心
            BG.Loot[FB].H.boss7  = { 89917, 86945, 87822, 86951, 86952, 86948, 86950, 86947, 89919, 86944, 89918, 86943, 86946, 86949, }
            BG.Loot[FB].H.boss8  = { 86960, 89922, 86953, 89921, 86961, 86958, 86954, 86962, 90740, 86956, 86955, 89920, 86959, 86957, }
            BG.Loot[FB].H.boss9  = { 86966, 86970, 86967, 89924, 86971, 86963, 89923, 86972, 89925, 86965, 86964, 86973, 86969, 86968, }
            BG.Loot[FB].H.boss10 = { 89257, 89256, 89255, 86976, 86978, 86980, 86975, 86977, 86979, 86974, }
            BG.Loot[FB].H.boss11 = { 89254, 89253, 89252, 86987, 86983, 86986, 86981, 86985, 86984, 86982, }
            BG.Loot[FB].H.boss12 = { 89251, 89250, 89249, 86990, 86988, 86991, 89927, 89926, 86989, 89928, }
            -- 永春台
            BG.Loot[FB].H.boss13 = { 87152, 90513, 87155, 90516, 87147, 90508, 87148, 90509, 90505, 89944, 87150, 90512, 87145, 90506, 87149, 90510, 90504, 89943, 87146, 90507, 87154, 90515, 90514, 87153, 87151, 90511, 87144, 90503, }
            BG.Loot[FB].H.boss14 = { 87156, 87164, 89947, 87159, 87157, 89945, 89946, 87184, 87177, 87185, 87186, 87161, 87179, 87183, 87178, 87182, 87181, 87180, 89948, 87165, 87162, 87158, 87160, 87163, }
            BG.Loot[FB].H.boss15 = { 89263, 89262, 89261, 87170, 87166, 87168, 87171, 87169, 87184, 87177, 87185, 87186, 87179, 87183, 87178, 87182, 87181, 87180, 87167, 87172, }
            BG.Loot[FB].H.boss16 = { 89260, 89259, 89258, 87176, 87173, 89949, 89950, 89951, 87174, 87175, }
            -- 小怪
            BG.Loot[FB].H.boss17 = { 86043, 86042, 86045, 86044, 86046, 86192, 86186, 86183, 86187, 86185, 86189, 86184, 86188, 86191, 86190, 74248, }

            -- PT
            BG.Loot[FB].N.boss1  = { 85924, 85976, 85922, 85979, 89766, 85923, 89768, 86134, 89767, 85977, 85978, 85926, 85975, 85925, }
            BG.Loot[FB].N.boss2  = { 89424, 85989, 85984, 85986, 86082, 85985, 85990, 85983, 85982, 85987, 85988, 85980, 89802, 89803, }
            BG.Loot[FB].N.boss3  = { 85994, 85996, 85991, 86039, 86041, 85995, 86027, 89817, 85993, 86040, 85997, 85992, 86038, }
            BG.Loot[FB].N.boss4  = { 86071, 86075, 86129, 86083, 86047, 86080, 89819, 86076, 86127, 89818, 86128, 86086, 86081, 86084, }
            BG.Loot[FB].N.boss5  = { 86140, 86130, 86137, 89821, 86141, 86136, 86135, 89822, 86139, 86138, 89824, 86133, 86132, 86131, }
            BG.Loot[FB].N.boss6  = { 86148, 86142, 86146, 89820, 86151, 86152, 86149, 89823, 89825, 87827, 86145, 86150, 86147, 86144, }
            -- 恐惧之心
            BG.Loot[FB].N.boss7  = { 89827, 86154, 87824, 86160, 86158, 86157, 86159, 86161, 89826, 86203, 89829, 86153, 86155, 86156, }
            BG.Loot[FB].N.boss8  = { 86171, 89831, 86166, 89828, 86169, 86170, 86163, 86168, 90738, 86165, 86164, 89830, 86167, 86162, }
            BG.Loot[FB].N.boss9  = { 86174, 86181, 86177, 89833, 86182, 86173, 89832, 86180, 89834, 86175, 86176, 86179, 86178, 86172, }
            BG.Loot[FB].N.boss10 = { 89241, 89240, 89242, 86205, 86204, 86202, 86513, 86514, 86201, 86200, }
            BG.Loot[FB].N.boss11 = { 89244, 89243, 89245, 86219, 86217, 86213, 86210, 86214, 86212, 86211, }
            BG.Loot[FB].N.boss12 = { 89238, 89237, 89239, 86227, 86226, 86228, 89835, 89836, 86229, 89837, }
            -- 永春台
            BG.Loot[FB].N.boss13 = { 86390, 90527, 86318, 90530, 86233, 90522, 86234, 90523, 90519, 89885, 86316, 90526, 86230, 90520, 86317, 90524, 90518, 89841, 86232, 90521, 86319, 90529, 90528, 86320, 86315, 90525, 86231, 90517, }
            BG.Loot[FB].N.boss14 = { 86321, 86328, 89883, 86325, 86324, 89842, 89843, 86383, 86338, 86384, 86385, 86326, 86339, 86342, 86337, 86343, 86340, 86341, 89884, 86329, 86330, 86322, 86323, 86327, }
            BG.Loot[FB].N.boss15 = { 89247, 89246, 89248, 86335, 86391, 86331, 86333, 86334, 86383, 86338, 86384, 86385, 86339, 86342, 86337, 86343, 86340, 86341, 86332, 86336, }
            BG.Loot[FB].N.boss16 = { 89236, 89235, 89234, 86386, 86387, 89887, 89886, 89839, 86389, 86388, }
            BG.Loot[FB].N.boss17 = BG.Loot[FB].H.boss17
            -- 兑换物
            local tbl            = {
                -- 头
                ["16"] = {
                    ["H"] = {
                        [89259] = { 87111, 87106, 87120, 87115, 87188, 87101, },
                        [89260] = { 87199, 87086, 87090, 87141, 87131, 87004, 87192, 87136, 87096, },
                        [89258] = { 86920, 86940, 86934, 86929, 87008, 86915, 87126, 86925, },
                    },
                    ["N"] = {
                        [89234] = { 85316, 85381, 85307, 85311, 85336, 85301, 85357, 85377, },
                        [89236] = { 85286, 85326, 85396, 85291, 85386, 85296, 85333, 85390, 85351, },
                        [89235] = { 85341, 85321, 85365, 85346, 85362, 85370, },
                    },
                },
                -- 肩
                ["15"] = {
                    ["H"] = {
                        [89261] = { 86922, 86942, 86937, 86932, 87011, 86917, 87128, 86927, },
                        [89263] = { 87201, 87088, 87093, 87143, 87133, 87006, 87196, 87138, 87098, },
                        [89262] = { 87113, 87108, 87123, 87118, 87191, 87103, },
                    },
                    ["N"] = {
                        [89248] = { 85314, 85383, 85304, 85309, 85334, 85299, 85354, 85374, },
                        [89247] = { 85284, 85324, 85398, 85293, 85384, 85294, 85329, 85393, 85349, },
                        [89246] = { 85339, 85319, 85368, 85344, 85359, 85373, },
                    },
                },
                -- 胸
                ["12"] = {
                    ["H"] = {
                        [89249] = { 86918, 86938, 86936, 86931, 87010, 86913, 87124, 86923, },
                        [89251] = { 87197, 87084, 87092, 87139, 87129, 87002, 87193, 87134, 87094, },
                        [89250] = { 87109, 87104, 87122, 87117, 87190, 87099, },
                    },
                    ["N"] = {
                        [89239] = { 85318, 85379, 85305, 85355, 85375, 85338, 85303, 85313, },
                        [89238] = { 85328, 85394, 85392, 85289, 85353, 85298, 85332, 85288, 85388, },
                        [89237] = { 85343, 85323, 85367, 85360, 85372, 85348, },
                    },
                },
                -- 手
                ["10"] = {
                    ["H"] = {
                        [89255] = { 86919, 86939, 86933, 86928, 87007, 86914, 87125, 86924, },
                        [89257] = { 87198, 87085, 87089, 87140, 87130, 87003, 87194, 87135, 87095, },
                        [89256] = { 87110, 87105, 87119, 87114, 87187, 87100, },
                    },
                    ["N"] = {
                        [89242] = { 85317, 85380, 85308, 85358, 85378, 85337, 85302, 85312, },
                        [89241] = { 85327, 85395, 85389, 85290, 85352, 85297, 85331, 85287, 85387, },
                        [89240] = { 85342, 85322, 85364, 85363, 85369, 85347, },
                    },
                },
                -- 腿
                ["11"] = {
                    ["H"] = {
                        [89252] = { 86921, 86941, 86935, 86930, 87009, 86916, 87127, 86926, },
                        [89254] = { 87200, 87087, 87091, 87142, 87132, 87005, 87195, 87137, 87097, },
                        [89253] = { 87112, 87107, 87121, 87116, 87189, 87102, },
                    },
                    ["N"] = {
                        [89245] = { 85315, 85382, 85306, 85356, 85376, 85335, 85300, 85310, },
                        [89244] = { 85325, 85397, 85391, 85292, 85350, 85295, 85330, 85285, 85385, },
                        [89243] = { 85340, 85320, 85366, 85361, 85371, 85345, },
                    },
                },
            }
            for boss, v in pairs(tbl) do
                for hard, vv in pairs(v) do
                    for exItemID, vvv in pairs(vv) do
                        BG.Loot[FB].ExchangeItems[exItemID] = vvv
                        for _, itemID in pairs(vvv) do
                            BG.Loot[FB][hard]["boss" .. boss .. "other"] =
                                BG.Loot[FB][hard]["boss" .. boss .. "other"] or {}
                            tinsert(BG.Loot[FB][hard]["boss" .. boss .. "other"], itemID)
                        end
                    end
                end
            end
            -- 天神套装
            BG.Loot[FB].ExchangeItems[89273] = { 86676, 86641, 86656, 86697, 86717, 86721, 86647, 86651, }
            BG.Loot[FB].ExchangeItems[89275] = { 86673, 86631, 86636, 86626, 86666, 86730, 86726, 86691, 86736, }
            BG.Loot[FB].ExchangeItems[89274] = { 86686, 86661, 86681, 86702, 86710, 86705, }

            BG.Loot[FB].ExchangeItems[89276] = { 86639, 86674, 86654, 86694, 86649, 86714, 86723, 86644, }
            BG.Loot[FB].ExchangeItems[89278] = { 86669, 86633, 86634, 86624, 86664, 86733, 86724, 86689, 86738, }
            BG.Loot[FB].ExchangeItems[89277] = { 86684, 86659, 86679, 86699, 86713, 86708, }

            BG.Loot[FB].ExchangeItems[89265] = { 86688, 86707, 86683, 86700, 86663, 86712, }
            BG.Loot[FB].ExchangeItems[89266] = { 86728, 86734, 86693, 86638, 86732, 86629, 86628, 86672, 86668, }
            BG.Loot[FB].ExchangeItems[89264] = { 86678, 86658, 86695, 86645, 86653, 86719, 86715, 86643, }
            BG.Loot[FB].ExchangeItems[89270] = { 86677, 86642, 86657, 86698, 86718, 86720, 86648, 86652, }
            BG.Loot[FB].ExchangeItems[89272] = { 86630, 86637, 86667, 86671, 86729, 86692, 86735, 86627, 86727, }
            BG.Loot[FB].ExchangeItems[89271] = { 86687, 86662, 86682, 86703, 86709, 86704, }

            BG.Loot[FB].ExchangeItems[89267] = { 86716, 86675, 86640, 86722, 86655, 86650, 86696, 86646, }
            BG.Loot[FB].ExchangeItems[89269] = { 86690, 86635, 86625, 86670, 86725, 86731, 86632, 86737, 86665, }
            BG.Loot[FB].ExchangeItems[89268] = { 86685, 86660, 86680, 86701, 86711, 86706, }
        end

        -- 5人本
        do
        end

        --[[         do
            local tbl = { 65191, 65187, 65231, 65267, 65217, 65182, 65207, 65211, 65236, 65247, 65252, 65261, 65196, 65257, 65201, 65242, 65222, 65272, 65227 }
            local classtbl = {
                [1] = { "战士", "猎人", "萨满" },
                [2] = { "圣骑士", "术士", "牧师" },
                [3] = { "潜行者", "法师", "德鲁伊", "死亡骑士" },
            }
            local classtbl2 = {
                [1] = "ZLS",
                [2] = "QSM",
                [3] = "ZFD",
            }
            for _, itemID in ipairs(tbl) do -- 提前缓存
                GetItemInfo(itemID)
            end

            local f = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 16,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:SetSize(300, 500)
            f:SetPoint("CENTER")
            f:EnableMouse(true)

            local s = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate") -- 滚动
            s:SetWidth(f:GetWidth() - 31)
            s:SetHeight(f:GetHeight() - 9)
            s:SetPoint("TOPLEFT", f, "TOPLEFT", 5, -5)
            s.ScrollBar.scrollStep = BG.scrollStep

            local edit = CreateFrame("EditBox", nil, f) -- 子框架
            edit:SetWidth(s:GetWidth())
            edit:SetHeight(s:GetHeight())
            edit:SetFontObject(BG.FontGold13)
            edit:SetMultiLine(true)
            edit:SetAutoFocus(false)
            s:SetScrollChild(edit)

            edit:SetScript("OnEscapePressed", function(self)
                self:ClearFocus()
            end)

            local function abc(type, tbl)
                edit:Insert(BG.STC_w1(classtbl2[type] .. "\n"))
                for _, itemID in ipairs(tbl) do
                    BG.Tooltip_SetItemByID(itemID)
                    local tab = {}
                    local ii = 1
                    while _G["BiaoGeTooltipTextLeft" .. ii] do
                        local tx = _G["BiaoGeTooltipTextLeft" .. ii]:GetText()
                        if tx and tx ~= "" and (not tx:find(WARDROBE_SETS)) and
                            (not tx:find(ITEM_MOD_FERAL_ATTACK_POWER:gsub("%%s", "(.+)"))) then -- 小德的武器词缀：在猎豹、熊等等攻击强度提高%s点
                            tinsert(tab, tx)
                        end
                        ii = ii + 1
                    end
                    local TooltipText = table.concat(tab)
                    if strfind(TooltipText, CLASS) then
                        for i, class in ipairs(classtbl[type]) do
                            if strfind(TooltipText, class) then
                                edit:Insert(itemID .. ",")
                            end
                        end
                    end
                end
                edit:Insert("\n\n")
            end
            C_Timer.After(5, function()
                abc(1, tbl)
                abc(2, tbl)
                abc(3, tbl)
            end)
        end ]]
    end
end

-- 牌子装备
do
    local function AddCurrency(FB, currencyID, itemID, count, otherItemID1, otherItemID1Count)
        if BG.Loot[FB].ExchangeItems[itemID] then
            for _, _itemID in pairs(BG.Loot[FB].ExchangeItems[itemID]) do
                BG.Loot[FB].Currency[_itemID] = {
                    count = count,
                    currencyID = currencyID,
                    otherItemID1 = otherItemID1,
                    otherItemID1Count = otherItemID1Count,
                }
            end
        else
            BG.Loot[FB].Currency[itemID] = {
                count = count,
                currencyID = currencyID,
                otherItemID1 = otherItemID1,
                otherItemID1Count = otherItemID1Count,
            }
        end
    end

    -- P1
    do
        local FB = "MSV"
        -- 勇气
        do
            AddCurrency(FB, 396, 89074, 1250)
            AddCurrency(FB, 396, 89280, 2500)
            AddCurrency(FB, 396, 89345, 1750)
            AddCurrency(FB, 396, 89069, 1250)
            AddCurrency(FB, 396, 89070, 1250)
            AddCurrency(FB, 396, 89072, 1250)
            AddCurrency(FB, 396, 89341, 1750)
            AddCurrency(FB, 396, 89073, 1250)
            AddCurrency(FB, 396, 89078, 1250)
            AddCurrency(FB, 396, 89081, 1750)
            AddCurrency(FB, 396, 89076, 1250)
            AddCurrency(FB, 396, 89344, 1750)
            AddCurrency(FB, 396, 89055, 1750)
            AddCurrency(FB, 396, 88893, 1250)
            AddCurrency(FB, 396, 89062, 1750)
            AddCurrency(FB, 396, 88892, 1250)
            AddCurrency(FB, 396, 89088, 2500)
            AddCurrency(FB, 396, 89067, 1250)
            AddCurrency(FB, 396, 88879, 1250)
            AddCurrency(FB, 396, 89077, 1250)
            AddCurrency(FB, 396, 89082, 1750)
            AddCurrency(FB, 396, 89083, 1750)
            AddCurrency(FB, 396, 89065, 1250)
            AddCurrency(FB, 396, 89064, 1250)
            AddCurrency(FB, 396, 89061, 1750)
            AddCurrency(FB, 396, 89080, 1750)
            AddCurrency(FB, 396, 89340, 1750)
            AddCurrency(FB, 396, 89060, 1750)
            AddCurrency(FB, 396, 89058, 1750)
            AddCurrency(FB, 396, 88883, 1250)
            AddCurrency(FB, 396, 89216, 2500)
            AddCurrency(FB, 396, 89071, 1250)
            AddCurrency(FB, 396, 89068, 1250)
            AddCurrency(FB, 396, 88884, 1250)
            AddCurrency(FB, 396, 89420, 2500)
            AddCurrency(FB, 396, 89342, 1750)
            AddCurrency(FB, 396, 89059, 1750)
            AddCurrency(FB, 396, 89300, 2500)
            AddCurrency(FB, 396, 89346, 1750)
            AddCurrency(FB, 396, 88885, 1250)
            AddCurrency(FB, 396, 88744, 1750)
            AddCurrency(FB, 396, 89056, 1750)
            AddCurrency(FB, 396, 88878, 1750)
            AddCurrency(FB, 396, 89337, 2500)
            AddCurrency(FB, 396, 88862, 1750)
            AddCurrency(FB, 396, 89339, 1750)
            AddCurrency(FB, 396, 88868, 1750)
            AddCurrency(FB, 396, 89075, 1250)
            AddCurrency(FB, 396, 89432, 2500)
            AddCurrency(FB, 396, 89079, 1750)
            AddCurrency(FB, 396, 89093, 2500)
            AddCurrency(FB, 396, 89433, 2500)
            AddCurrency(FB, 396, 89089, 2500)
            AddCurrency(FB, 396, 89291, 2500)
            AddCurrency(FB, 396, 89095, 2500)
            AddCurrency(FB, 396, 89347, 1750)
            AddCurrency(FB, 396, 88880, 1250)
            AddCurrency(FB, 396, 89429, 2500)
            AddCurrency(FB, 396, 89338, 2500)
            AddCurrency(FB, 396, 89308, 2500)
            AddCurrency(FB, 396, 89434, 2500)
            AddCurrency(FB, 396, 89431, 2500)
            AddCurrency(FB, 396, 89343, 1750)
            AddCurrency(FB, 396, 89296, 2500)
            AddCurrency(FB, 396, 89087, 2500)
            AddCurrency(FB, 396, 88746, 1750)
            AddCurrency(FB, 396, 89063, 1750)
            AddCurrency(FB, 396, 89090, 2500)
            AddCurrency(FB, 396, 89066, 1250)
            AddCurrency(FB, 396, 88742, 1750)
            AddCurrency(FB, 396, 89094, 2500)
            AddCurrency(FB, 396, 89423, 2500)
            AddCurrency(FB, 396, 88882, 1250)
            AddCurrency(FB, 396, 88866, 1750)
            AddCurrency(FB, 396, 88747, 1750)
            AddCurrency(FB, 396, 88743, 1750)
            AddCurrency(FB, 396, 89430, 2500)
            AddCurrency(FB, 396, 89057, 1750)
            AddCurrency(FB, 396, 88741, 1750)
            AddCurrency(FB, 396, 89421, 2500)
            AddCurrency(FB, 396, 88877, 1750)
            AddCurrency(FB, 396, 88864, 1750)
            AddCurrency(FB, 396, 88749, 1750)
            AddCurrency(FB, 396, 88745, 1750)
            AddCurrency(FB, 396, 89092, 2500)
            AddCurrency(FB, 396, 88865, 1750)
            AddCurrency(FB, 396, 88748, 1750)
            AddCurrency(FB, 396, 89096, 2500)
            AddCurrency(FB, 396, 89091, 2500)
            AddCurrency(FB, 396, 88881, 1250)
            AddCurrency(FB, 396, 88867, 1750)
            AddCurrency(FB, 396, 88876, 1750)
        end
        -- 正义
        do
            AddCurrency(FB, 395, 89659, 2250)
            AddCurrency(FB, 395, 89667, 2250)
            AddCurrency(FB, 395, 89665, 2250)
            AddCurrency(FB, 395, 89673, 2250)
            AddCurrency(FB, 395, 89658, 2250)
            AddCurrency(FB, 395, 89672, 2250)
            AddCurrency(FB, 395, 89661, 2250)
            AddCurrency(FB, 395, 89671, 2250)
            AddCurrency(FB, 395, 89668, 2250)
            AddCurrency(FB, 395, 89666, 2250)
            AddCurrency(FB, 395, 89669, 2250)
            AddCurrency(FB, 395, 89660, 2250)
            AddCurrency(FB, 395, 89662, 2250)
            AddCurrency(FB, 395, 89663, 2250)
            AddCurrency(FB, 395, 89670, 2250)
            AddCurrency(FB, 395, 89664, 2250)
            AddCurrency(FB, 395, 88995, 1750)
            AddCurrency(FB, 395, 89232, 1750)
            AddCurrency(FB, 395, 89653, 1750)
            AddCurrency(FB, 395, 89657, 1750)
            AddCurrency(FB, 395, 89654, 1750)
            AddCurrency(FB, 395, 89656, 1750)
            AddCurrency(FB, 395, 89650, 1750)
            AddCurrency(FB, 395, 89655, 1750)
            AddCurrency(FB, 395, 89652, 1750)
            AddCurrency(FB, 395, 89651, 1750)
            AddCurrency(FB, 395, 89524, 1250)
            AddCurrency(FB, 395, 89526, 1250)
            AddCurrency(FB, 395, 89522, 1250)
            AddCurrency(FB, 395, 89530, 1250)
            AddCurrency(FB, 395, 89642, 1250)
            AddCurrency(FB, 395, 89649, 1250)
            AddCurrency(FB, 395, 89528, 1250)
            AddCurrency(FB, 395, 89644, 1250)
            AddCurrency(FB, 395, 89532, 1250)
            AddCurrency(FB, 395, 89643, 1250)
            AddCurrency(FB, 395, 89648, 1250)
            AddCurrency(FB, 395, 89533, 1250)
            AddCurrency(FB, 395, 89534, 1250)
            AddCurrency(FB, 395, 89523, 1250)
            AddCurrency(FB, 395, 89645, 1250)
            AddCurrency(FB, 395, 89647, 1250)
            AddCurrency(FB, 395, 89527, 1250)
            AddCurrency(FB, 395, 89525, 1250)
            AddCurrency(FB, 395, 89537, 1250)
            AddCurrency(FB, 395, 89646, 1250)
            AddCurrency(FB, 395, 89535, 1250)
            AddCurrency(FB, 395, 89529, 1250)
            AddCurrency(FB, 395, 89531, 1250)
        end
        -- 天神
        do
            AddCurrency(FB, 3350, 89275, 60)
            AddCurrency(FB, 3350, 89274, 60)
            AddCurrency(FB, 3350, 89273, 60)
            AddCurrency(FB, 3350, 89269, 55)
            AddCurrency(FB, 3350, 89264, 55)
            AddCurrency(FB, 3350, 89266, 55)
            AddCurrency(FB, 3350, 89265, 55)
            AddCurrency(FB, 3350, 89267, 55)
            AddCurrency(FB, 3350, 89268, 55)
            AddCurrency(FB, 3350, 86905, 50)
            AddCurrency(FB, 3350, 89272, 50)
            AddCurrency(FB, 3350, 86889, 50)
            AddCurrency(FB, 3350, 86890, 50)
            AddCurrency(FB, 3350, 86907, 50)
            AddCurrency(FB, 3350, 89270, 50)
            AddCurrency(FB, 3350, 86893, 50)
            AddCurrency(FB, 3350, 86879, 50)
            AddCurrency(FB, 3350, 89271, 50)
            AddCurrency(FB, 3350, 89278, 50)
            AddCurrency(FB, 3350, 86894, 50)
            AddCurrency(FB, 3350, 89276, 50)
            AddCurrency(FB, 3350, 86885, 50)
            AddCurrency(FB, 3350, 89277, 50)
            AddCurrency(FB, 3350, 86870, 50)
            AddCurrency(FB, 3350, 86881, 50)
            AddCurrency(FB, 3350, 86892, 50)
            AddCurrency(FB, 3350, 86878, 50)
            AddCurrency(FB, 3350, 86900, 50)
            AddCurrency(FB, 3350, 89985, 50)
            AddCurrency(FB, 3350, 89978, 50)
            AddCurrency(FB, 3350, 86904, 50)
            AddCurrency(FB, 3350, 86877, 50)
            AddCurrency(FB, 3350, 86899, 50)
            AddCurrency(FB, 3350, 89986, 50)
            AddCurrency(FB, 3350, 86901, 50)
            AddCurrency(FB, 3350, 86882, 50)
            AddCurrency(FB, 3350, 86895, 50)
            AddCurrency(FB, 3350, 86876, 50)
            AddCurrency(FB, 3350, 86902, 50)
            AddCurrency(FB, 3350, 86903, 50)
            AddCurrency(FB, 3350, 86891, 50)
            AddCurrency(FB, 3350, 89984, 50)
            AddCurrency(FB, 3350, 86887, 50)
            AddCurrency(FB, 3350, 86884, 50)
            AddCurrency(FB, 3350, 86908, 50)
            AddCurrency(FB, 3350, 86888, 50)
            AddCurrency(FB, 3350, 86898, 50)
            AddCurrency(FB, 3350, 86897, 50)
            AddCurrency(FB, 3350, 86896, 50)
            AddCurrency(FB, 3350, 89983, 50)
            AddCurrency(FB, 3350, 86839, 45)
            AddCurrency(FB, 3350, 86818, 45)
            AddCurrency(FB, 3350, 86852, 45)
            AddCurrency(FB, 3350, 89958, 45)
            AddCurrency(FB, 3350, 89957, 45)
            AddCurrency(FB, 3350, 89954, 45)
            AddCurrency(FB, 3350, 86866, 45)
            AddCurrency(FB, 3350, 86822, 45)
            AddCurrency(FB, 3350, 86861, 45)
            AddCurrency(FB, 3350, 86854, 45)
            AddCurrency(FB, 3350, 86859, 45)
            AddCurrency(FB, 3350, 86832, 45)
            AddCurrency(FB, 3350, 89953, 45)
            AddCurrency(FB, 3350, 86836, 45)
            AddCurrency(FB, 3350, 86811, 45)
            AddCurrency(FB, 3350, 89955, 45)
            AddCurrency(FB, 3350, 89963, 45)
            AddCurrency(FB, 3350, 86867, 45)
            AddCurrency(FB, 3350, 86825, 45)
            AddCurrency(FB, 3350, 86838, 45)
            AddCurrency(FB, 3350, 89960, 45)
            AddCurrency(FB, 3350, 86857, 45)
            AddCurrency(FB, 3350, 87823, 45)
            AddCurrency(FB, 3350, 86911, 45)
            AddCurrency(FB, 3350, 89962, 45)
            AddCurrency(FB, 3350, 86816, 45)
            AddCurrency(FB, 3350, 86864, 30)
            AddCurrency(FB, 3350, 86862, 30)
            AddCurrency(FB, 3350, 86865, 30)
            AddCurrency(FB, 3350, 86863, 30)
            AddCurrency(FB, 3350, 86886, 30)
            AddCurrency(FB, 3350, 86909, 30)
            AddCurrency(FB, 3350, 86910, 30)
            AddCurrency(FB, 3350, 86826, 30)
            AddCurrency(FB, 3350, 86880, 30)
            AddCurrency(FB, 3350, 86851, 30)
            AddCurrency(FB, 3350, 86856, 30)
            AddCurrency(FB, 3350, 86860, 30)
            AddCurrency(FB, 3350, 86906, 30)
            AddCurrency(FB, 3350, 86828, 30)
            AddCurrency(FB, 3350, 86814, 30)
            AddCurrency(FB, 3350, 86875, 30)
            AddCurrency(FB, 3350, 86820, 30)
            AddCurrency(FB, 3350, 86873, 30)
            AddCurrency(FB, 3350, 86869, 30)
            AddCurrency(FB, 3350, 86812, 30)
            AddCurrency(FB, 3350, 86871, 30)
            AddCurrency(FB, 3350, 86821, 30)
            AddCurrency(FB, 3350, 86855, 30)
            AddCurrency(FB, 3350, 86874, 30)
            AddCurrency(FB, 3350, 86835, 30)
            AddCurrency(FB, 3350, 89956, 30)
            AddCurrency(FB, 3350, 86844, 30)
            AddCurrency(FB, 3350, 86815, 30)
            AddCurrency(FB, 3350, 86858, 30)
            AddCurrency(FB, 3350, 86868, 30)
            AddCurrency(FB, 3350, 86843, 30)
            AddCurrency(FB, 3350, 86831, 30)
            AddCurrency(FB, 3350, 86824, 30)
            AddCurrency(FB, 3350, 89961, 30)
            AddCurrency(FB, 3350, 86848, 30)
            AddCurrency(FB, 3350, 86847, 30)
            AddCurrency(FB, 3350, 86834, 30)
            AddCurrency(FB, 3350, 89982, 30)
            AddCurrency(FB, 3350, 86841, 30)
            AddCurrency(FB, 3350, 86849, 30)
            AddCurrency(FB, 3350, 86872, 30)
            AddCurrency(FB, 3350, 86813, 30)
            AddCurrency(FB, 3350, 89980, 30)
            AddCurrency(FB, 3350, 86830, 30)
            AddCurrency(FB, 3350, 86912, 30)
            AddCurrency(FB, 3350, 86827, 30)
            AddCurrency(FB, 3350, 86840, 30)
            AddCurrency(FB, 3350, 89979, 30)
            AddCurrency(FB, 3350, 86842, 30)
            AddCurrency(FB, 3350, 89959, 30)
            AddCurrency(FB, 3350, 86817, 30)
            AddCurrency(FB, 3350, 86846, 30)
            AddCurrency(FB, 3350, 89952, 30)
            AddCurrency(FB, 3350, 86819, 30)
            AddCurrency(FB, 3350, 86883, 30)
            AddCurrency(FB, 3350, 90739, 30)
            AddCurrency(FB, 3350, 86850, 30)
            AddCurrency(FB, 3350, 86853, 30)
            AddCurrency(FB, 3350, 86823, 30)
            AddCurrency(FB, 3350, 86837, 30)
            AddCurrency(FB, 3350, 86833, 30)
            AddCurrency(FB, 3350, 89981, 30)
            AddCurrency(FB, 3350, 86845, 30)
            AddCurrency(FB, 3350, 86829, 15)
            AddCurrency(FB, 3350, 86799, 40)
            AddCurrency(FB, 3350, 86792, 40)
            AddCurrency(FB, 3350, 86791, 40)
            AddCurrency(FB, 3350, 86805, 40)
            AddCurrency(FB, 3350, 86801, 40)
            AddCurrency(FB, 3350, 86802, 40)
            AddCurrency(FB, 3350, 86796, 40)
            AddCurrency(FB, 3350, 86777, 40)
            AddCurrency(FB, 3350, 86803, 40)
            AddCurrency(FB, 3350, 86747, 40)
            AddCurrency(FB, 3350, 86804, 40)
            AddCurrency(FB, 3350, 86743, 40)
            AddCurrency(FB, 3350, 86809, 40)
            AddCurrency(FB, 3350, 86746, 40)
            AddCurrency(FB, 3350, 86798, 40)
            AddCurrency(FB, 3350, 86758, 40)
            AddCurrency(FB, 3350, 86750, 40)
            AddCurrency(FB, 3350, 86790, 40)
            AddCurrency(FB, 3350, 86795, 40)
            AddCurrency(FB, 3350, 86773, 40)
            AddCurrency(FB, 3350, 86769, 40)
            AddCurrency(FB, 3350, 86755, 40)
            AddCurrency(FB, 3350, 89976, 40)
            AddCurrency(FB, 3350, 86742, 40)
            AddCurrency(FB, 3350, 86808, 40)
            AddCurrency(FB, 3350, 86784, 40)
            AddCurrency(FB, 3350, 89973, 40)
            AddCurrency(FB, 3350, 86752, 40)
            AddCurrency(FB, 3350, 89965, 40)
            AddCurrency(FB, 3350, 86761, 40)
            AddCurrency(FB, 3350, 86749, 40)
            AddCurrency(FB, 3350, 86772, 40)
            AddCurrency(FB, 3350, 86788, 40)
            AddCurrency(FB, 3350, 86745, 40)
            AddCurrency(FB, 3350, 86779, 40)
            AddCurrency(FB, 3350, 86771, 40)
            AddCurrency(FB, 3350, 86793, 40)
            AddCurrency(FB, 3350, 86797, 40)
            AddCurrency(FB, 3350, 89975, 40)
            AddCurrency(FB, 3350, 89964, 40)
            AddCurrency(FB, 3350, 86760, 40)
            AddCurrency(FB, 3350, 86757, 40)
            AddCurrency(FB, 3350, 86756, 40)
            AddCurrency(FB, 3350, 86774, 40)
            AddCurrency(FB, 3350, 86765, 40)
            AddCurrency(FB, 3350, 86744, 40)
            AddCurrency(FB, 3350, 86781, 40)
            AddCurrency(FB, 3350, 86775, 40)
            AddCurrency(FB, 3350, 89974, 40)
            AddCurrency(FB, 3350, 86785, 40)
            AddCurrency(FB, 3350, 86806, 25)
            AddCurrency(FB, 3350, 86789, 25)
            AddCurrency(FB, 3350, 86767, 25)
            AddCurrency(FB, 3350, 86753, 25)
            AddCurrency(FB, 3350, 86800, 25)
            AddCurrency(FB, 3350, 89967, 25)
            AddCurrency(FB, 3350, 86783, 25)
            AddCurrency(FB, 3350, 89968, 25)
            AddCurrency(FB, 3350, 86762, 25)
            AddCurrency(FB, 3350, 86770, 25)
            AddCurrency(FB, 3350, 86741, 25)
            AddCurrency(FB, 3350, 89971, 25)
            AddCurrency(FB, 3350, 86782, 25)
            AddCurrency(FB, 3350, 89969, 25)
            AddCurrency(FB, 3350, 86810, 25)
            AddCurrency(FB, 3350, 86794, 25)
            AddCurrency(FB, 3350, 86759, 25)
            AddCurrency(FB, 3350, 86740, 25)
            AddCurrency(FB, 3350, 89972, 25)
            AddCurrency(FB, 3350, 86776, 25)
            AddCurrency(FB, 3350, 86786, 25)
            AddCurrency(FB, 3350, 89970, 25)
            AddCurrency(FB, 3350, 86748, 25)
            AddCurrency(FB, 3350, 89977, 25)
            AddCurrency(FB, 3350, 86751, 25)
            AddCurrency(FB, 3350, 86768, 25)
            AddCurrency(FB, 3350, 86763, 25)
            AddCurrency(FB, 3350, 86780, 25)
            AddCurrency(FB, 3350, 86754, 25)
            AddCurrency(FB, 3350, 86739, 25)
            AddCurrency(FB, 3350, 86807, 25)
            AddCurrency(FB, 3350, 86766, 25)
            AddCurrency(FB, 3350, 89966, 25)
            AddCurrency(FB, 3350, 87826, 25)
            AddCurrency(FB, 3350, 86787, 25)
            AddCurrency(FB, 3350, 86778, 15)
            AddCurrency(FB, 3350, 86764, 15)
            AddCurrency(FB, 3350, 89426, 15)
        end
    end
end

-- 声望装备
do
    -- P1
    do
    end
end

-- 专业制造
do
    -- P1
    local FB = "MSV"
    BG.Loot[FB].Profession = {
        ["锻造"] = { 87403, 87402, 87405, 82979, 82975, 82977, 87407, 87406, 87404, 82980, 82976, 82978, 82974, 82973, 82970, 82972, 82971, 82968, 82969, 82935, 82919, 82936, 82920, 82937, 82921, 82940, 82924, 82938, 82922, 82942, 82926, 82923, 82939, 82941, 82925, },
        ["制皮"] = { 85852, 85853, 85788, 85829, 85823, 85850, 85830, 85840, 85787, 85826, 85827, 85828, 85824, 85849, 85821, 85831, 85822, 85825, },
        ["裁缝"] = { 86311, 86312, 82439, 82437, 86313, 86314, 82440, 82438, },
        ["工程"] = { 77530, 77528, },
        ["珠宝加工"] = { 83803, 83802, 83805, 83806, 83804, 83801, 83796, 83800, 83799, 83798, },
        ["铭文"] = { 79334, 79335, 79340, 79341, 79343, },
        ["考古"] = { 95391, 95392, 89611, 89684, 89685, },
        ["炼金"] = { 75274, },
    }
end

-- 任务
do
end

-- 世界掉落
do
    -- P1
    local FB = "MSV"
    BG.Loot[FB].World = {
        90583, 90590, 90591, 90589, 90571, 90575, 90573, 90588, 90574, 90585, 90572, 90579, 90577,
    }
end

-- 世界BOSS
do
    local FB = "MSV"
    BG.Loot[FB].WorldBoss[L["怒之煞"]] = { 85308, 85306, 85312, 85310, 85358, 85356, 85380, 85382, 85297, 85295, 85378, 85376, 85302, 85300, 85369, 85371, 85389, 85391, 85395, 85397, 85387, 85385, 85347, 85345, 85342, 85340, 85322, 85320, 85363, 85361, 85364, 85366, 85290, 85292, 85287, 85285, 85352, 85350, 85337, 85335, 85317, 85315, 85331, 85330, 85327, 85325, }
    BG.Loot[FB].WorldBoss[L["炮舰"]] = { 90840, 89783, 90416, 90411, 90412, 90413, 90415, 90410, 90409, 90414, 90408, 90432, 90429, 90433, 90431, 90430, 90423, 90422, 90424, 90420, 90425, 90421, 90418, 90419, 90417, 90455, 90453, 90452, 90451, 90448, 90449, 90456, 90454, 90450, 90447, 90440, 90442, 90443, 90444, 90439, 90446, 90441, 90445, 90437, 90438, 90435, 90434, 90436, }
end

-- 马戏团
do
    local function AddDB(FB, get, itemID, deck, coin, color, type)
        if type then
            GetItemInfo(deck)
        end

        get = get or ""
        deck = deck or ""
        coin = coin or ""
        type = type or ""

        tinsert(BG.Loot[FB].Sod_Currency, {
            [itemID] = get .. "-" .. deck .. "-" .. coin .. "-" .. color .. "-" .. type
        })
    end

    -- P1
    local FB = "MSV"
    local get = L["暗月马戏团"]
    local color = "7B68EE"
    AddDB(FB, get, 79330, 79325, nil, color, 1) -- 2个物品ID，第一个是卡牌饰品，第二个某某套牌
    AddDB(FB, get, 79329, 79324, nil, color, 1)
    AddDB(FB, get, 79331, 79326, nil, color, 1)
    AddDB(FB, get, 79327, 79323, nil, color, 1)
    AddDB(FB, get, 79328, 79323, nil, color, 1)
end


--[[
local FB = "FL"
do
    local hard = "H"
    BG.Loot[FB][hard].boss1 = {}
    BG.Loot[FB][hard].boss2 = {}
    BG.Loot[FB][hard].boss3 = {}
    BG.Loot[FB][hard].boss4 = {}
    BG.Loot[FB][hard].boss5 = {}
    BG.Loot[FB][hard].boss6 = {}
    BG.Loot[FB][hard].boss7 = {}
    BG.Loot[FB][hard].boss8 = {}
end
 ]]
