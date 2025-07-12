if BG.IsBlackListPlayer then return end
local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local Maxb = ns.Maxb
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local pt = print
local RealmID = GetRealmID()
local player = BG.playerName
local _, class = UnitClass("player")

local MAXBUTTONS = 20
local BUTTONHEIGHT = 22
local WIDTH

local mainFrame
local db = {}
local db_old = {}
local isInsert = {}
local allItem = {}
local dbOK
local info = {}
local titleTbl
local maxhope
local CreateAllItemInfoCache, CheckItemInfo, CheckSameItem, Sort

-- 给获取途径排序
local typeIDtbl = {
    "raid",
    "sod_currency",
    "currency",
    "fb5",
    "quest",
    "faction",
    "profession",
    "world",
    "worldboss",
    "pvp",
    "pvp_currency",
}
local function GetTypeID(type)
    for i, v in ipairs(typeIDtbl) do
        if type == v then
            return i
        end
    end
end

local function CreateLine(parent, y, width, height, color, alpha)
    local l = parent:CreateLine()
    l:SetColorTexture(RGB(color or "808080", alpha or 1))
    l:SetStartPoint("BOTTOMLEFT", 0, y)
    l:SetEndPoint("BOTTOMLEFT", width, y)
    l:SetThickness(height or 1.5)
    return l
end
local function GetHardNum(hard)
    for i, diffName in ipairs(BG.difficultyTable[BG.FB1]) do
        if hard == diffName then
            return i
        end
    end
end
local function CheckHaved(itemID) -- 是否已经拥有该装备
    if BG.GetItemCount(itemID) ~= 0 then return true end
end
local function AddPrice(itemID) -- 添加装备拍卖行价格
    local m
    if BG.IsVanilla then
        m = BG.GetAuctionPrice(itemID, "notcopper")
    else
        m = BG.GetAuctionPrice(itemID, "notsilver")
    end
    if m ~= "" then
        return " |cffFFFFFF" .. m .. RR
    else
        return ""
    end
end
local function GetkExchangeItemInfo(itemID) -- 获取兑换物对应物品的ID和Link
    for _, FB in pairs(BG.phaseFBtable[BG.FB1]) do
        for exItemID, v in pairs(BG.Loot[FB].ExchangeItems) do
            for _, _itemID in pairs(BG.Loot[FB].ExchangeItems[exItemID]) do
                if itemID == _itemID then
                    return exItemID, info[FB][exItemID] and info[FB][exItemID].link
                end
            end
        end
    end
end
local function CreateLoadingText()
    local f = CreateFrame("Frame", nil, mainFrame.bg, "BackdropTemplate")
    f:SetSize(1, 1)
    f:SetPoint("TOP", 0, -38)
    f:SetFrameLevel(110)
    local t = f:CreateFontString()
    t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
    t:SetPoint("TOP")
    t:SetText(L["读取中..."])
    return f
end

-- 历遍所有来源的装备和兑换物，缓存装备的数据、鼠标提示工具文本
do
    local function InsertToAllItem(itemID)
        local _itemID = itemID
        if type(itemID) == "string" then
            _itemID = GetItemID(itemID)
        end
        if isInsert[itemID] then return end
        isInsert[itemID] = true
        tinsert(allItem, itemID)
        BG.Tooltip_SetItemByID(_itemID)
    end
    local function SaveItemInfo()
        local FB = BG.FB1
        local startI = 1
        local oneTime = 20
        local allCount = #allItem
        local cacheCount = 0
        local isDoing = true
        BG.OnUpdateTime(function(self, elapsed)
            self.timeElapsed = self.timeElapsed + elapsed
            if cacheCount >= allCount or self.timeElapsed >= 2 then
                self:SetScript("OnUpdate", nil)
                self:Hide()
                dbOK = true
                return
            elseif isDoing then
                for ii = startI, startI + oneTime - 1 do
                    local itemID = allItem[ii]
                    if itemID then
                        local _itemID = itemID
                        if type(itemID) == "string" then
                            _itemID = GetItemID(itemID)
                        end
                        local item = Item:CreateFromItemID(_itemID)
                        item:ContinueOnItemLoad(function()
                            local name, link, quality, level, _, _, _, _, EquipLoc, Texture,
                            _, typeID, subclassID, bindType = GetItemInfo(itemID)
                            local tooltipText = BG.GetTooltipTextLeftAll(_itemID)
                            info[FB][itemID] = {
                                name = name,
                                link = link,
                                quality = quality,
                                level = level,
                                EquipLoc = EquipLoc,
                                Texture = Texture,
                                typeID = typeID,
                                subclassID = subclassID,
                                bindType = bindType,
                                tooltipText = tooltipText,
                            }
                            cacheCount = cacheCount + 1
                        end)
                    else
                        isDoing = false
                        break
                    end
                end
                startI = startI + oneTime
            end
        end)
    end
    function CreateAllItemInfoCache()
        local FB = BG.FB1
        info[FB] = {}
        allItem = {}
        isInsert = {}
        local FBs = {}
        local delay = 0
        local add = 0.02
        -- 历遍同阶段的多个团本
        for _, FB in pairs(BG.phaseFBtable[FB]) do
            FBs[FB] = true
            -- 团本
            for _, hard in ipairs(BG.difficultyTable[FB]) do -- 历遍全部难度
                if BG.Loot[FB][hard] and next(BG.Loot[FB][hard]) then
                    BG.After(delay, function()
                        -- BOSS掉落
                        local ii = 1
                        while BG.Loot[FB][hard]["boss" .. ii] do
                            if not (FB == "TOC" and ii == 7 and hard:find("H")) then
                                for i, itemID in ipairs(BG.Loot[FB][hard]["boss" .. ii]) do
                                    InsertToAllItem(itemID)
                                end
                            end
                            ii = ii + 1
                        end
                    end)
                    delay = delay + add
                    BG.After(delay, function()
                        -- BOSS掉落后兑换的装备
                        local ii = 1
                        while BG.Loot[FB][hard]["boss" .. ii] do
                            if not (FB == "TOC" and ii == 7 and hard:find("H")) then
                                if BG.Loot[FB][hard]["boss" .. ii .. "other"] then
                                    for i, itemID in ipairs(BG.Loot[FB][hard]["boss" .. ii .. "other"]) do
                                        InsertToAllItem(itemID)
                                    end
                                end
                            end
                            ii = ii + 1
                        end
                        -- 团本任务奖励
                        if BG.Loot[FB][hard].Quest then
                            for name, _ in pairs(BG.Loot[FB][hard].Quest) do
                                for _, itemID in pairs(BG.Loot[FB][hard].Quest[name]) do
                                    InsertToAllItem(itemID)
                                end
                            end
                        end
                    end)
                    delay = delay + add
                end
            end
            -- 其他
            delay = delay + add
            BG.After(delay, function()
                -- 5人本
                for FB_5 in pairs(BG.Loot[FB].Team) do
                    for BossName, _ in pairs(BG.Loot[FB].Team[FB_5]) do
                        for _, itemID in pairs(BG.Loot[FB].Team[FB_5][BossName]) do
                            InsertToAllItem(itemID)
                        end
                    end
                end
                -- 任务
                for k, v in pairs(BG.Loot[FB].Quest) do
                    for i, itemID in ipairs(BG.Loot[FB].Quest[k].itemID) do
                        InsertToAllItem(itemID)
                    end
                end
                -- 牌子装备
                for itemID, v in pairs(BG.Loot[FB].Currency) do
                    InsertToAllItem(itemID)
                end
                -- 赛季服货币/牌子
                for i, v in pairs(BG.Loot[FB].Sod_Currency) do
                    for itemID, currency in pairs(BG.Loot[FB].Sod_Currency[i]) do
                        InsertToAllItem(itemID)
                    end
                end
                -- 声望装备
                for k, v in pairs(BG.Loot[FB].Faction) do
                    for i, itemID in ipairs(BG.Loot[FB].Faction[k]) do
                        InsertToAllItem(itemID)
                    end
                end
                -- 专业制造
                for k, v in pairs(BG.Loot[FB].Profession) do
                    for i, itemID in ipairs(BG.Loot[FB].Profession[k]) do
                        InsertToAllItem(itemID)
                    end
                end
                -- 世界掉落
                for i, itemID in ipairs(BG.Loot[FB].World) do
                    InsertToAllItem(itemID)
                end
                -- 世界BOSS
                for k, v in pairs(BG.Loot[FB].WorldBoss) do
                    for i, itemID in ipairs(BG.Loot[FB].WorldBoss[k]) do
                        InsertToAllItem(itemID)
                    end
                end
                -- PVP
                for k, v in pairs(BG.Loot[FB].PVP) do
                    for i, itemID in ipairs(BG.Loot[FB].PVP[k]) do
                        InsertToAllItem(itemID)
                    end
                end
                -- PVP货币
                for itemID, v in pairs(BG.Loot[FB].PVP_currency) do
                    InsertToAllItem(itemID)
                end
                -- 兑换物
                for itemID, v in pairs(BG.Loot[FB].ExchangeItems) do
                    InsertToAllItem(itemID)
                end
            end)
            delay = delay + add
        end
        BG.After(delay, function()
            for _FB in pairs(FBs) do
                if _FB ~= FB then
                    info[_FB] = info[FB]
                end
            end
            SaveItemInfo()
        end)
    end
end

-- 找出符合条件的装备
do
    local function IsYesItem(itemID)
        local FB = BG.FB1
        if not (info[FB] and info[FB][itemID]) then return end
        local typeID = info[FB][itemID].typeID
        if not (typeID == 2 or typeID == 4) then return false end

        local EquipLoc = info[FB][itemID].EquipLoc
        local isSameEquipLoc
        for _, _EquipLoc in pairs(BiaoGe.ItemLib.ItemLibInvType) do
            if EquipLoc == _EquipLoc then
                isSameEquipLoc = true
                break
            end
        end
        if not isSameEquipLoc then return false end

        if BiaoGe.ItemLib.iLevel[FB] then
            if info[FB][itemID].level < BiaoGe.ItemLib.iLevel[FB] then
                return false
            end
        end

        local subclassID = info[FB][itemID].subclassID
        local tooltipText = info[FB][itemID].tooltipText
        return not BG.FilterAll(itemID, typeID, EquipLoc, subclassID, tooltipText)
    end
    local function InsertItemInfo(itemID, type, hard, ii, other)
        if not IsYesItem(itemID) then return end
        local FB = BG.FB1
        local link = info[FB][itemID].link
        local quality = info[FB][itemID].quality
        local level = info[FB][itemID].level
        local Texture = info[FB][itemID].Texture
        local bindType = info[FB][itemID].bindType

        if type == "raid" then -- 团本掉落
            local color = "|cff" .. "00BFFF"
            if strfind(hard, "10") then
                color = "|cff" .. "99CCFF"
            end
            if BG.IsCTM or BG.IsMOP then
                if hard == "N" then
                    color = "|cff" .. "99CCFF"
                end
            end

            local get
            local bossname

            if other and other ~= "other" then
                bossname = other
            else
                bossname = BG.Boss[FB]["boss" .. ii].name2
                if bossname == L["杂项"] then
                    bossname = L["小怪"]
                end
            end
            if ii == Maxb[FB] then
                bossname = ""
            end

            -- 兑换物
            local exText = ""
            local exItemID, exItemLink = GetkExchangeItemInfo(itemID)
            if exItemLink then
                local tex = select(5, GetItemInfoInstant(exItemID))
                exText = " " .. AddTexture(tex) .. exItemLink
            end

            if BG.IsVanilla then
                get = color .. BG.FBfromBossPosition[FB][ii].localName .. " " .. bossname .. exText .. AddPrice(itemID)
            else
                get = color .. BG.FBfromBossPosition[FB][ii].localName .. " " .. hard .. " " .. bossname .. exText .. AddPrice(itemID)
            end

            -- 团本正常掉落/兑换物（比如套装）
            local isRaid = true
            if other and exItemLink == "" then
                isRaid = false
            end

            local players
            if BG.IsVanilla then
                players = BG.GetFBinfo(FB, "maxplayers") or 10
            else
                players = tonumber(strmatch(hard, "%d+")) -- 副本规模10人/25人
            end

            local hope
            for n = 1, HopeMaxn[FB] do
                for b = 1, HopeMaxb[FB] do
                    for i = 1, HopeMaxi do
                        if BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] then
                            local itemID = exItemID or itemID
                            if itemID == GetItemID(BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]:GetText()) then
                                hope = true
                                break
                            end
                        end
                    end
                    if hope then break end
                end
                if hope then break end
            end

            tinsert(db_old, {
                FB = FB,
                isRaid = isRaid,
                itemID = itemID,
                link = link,
                level = level,
                quality = quality,
                texture = Texture,
                get = get,
                bindType = bindType,
                i = ii,
                hard = hard,
                hardnum = GetHardNum(hard),
                players = players,
                type = GetTypeID(type),
                type2 = FB,
                hope = hope,
                haved = CheckHaved(itemID)
            })
        elseif type == "quest" then -- 野外任务
            local FBname = other.FBname
            local color = other.color
            local players = other.players
            local classID = other.classID
            local faction = other.faction
            local get

            if FBname ~= "" then
                FBname = FBname .. " "
            end

            -- 阵营
            if faction == 1 then
                faction = FACTION_ALLIANCE
            elseif faction == 2 then
                faction = FACTION_HORDE
            else
                faction = ""
            end

            -- 兑换物
            local exText = ""
            local exItemID, exItemLink = GetkExchangeItemInfo(itemID)
            if exItemLink then
                local tex = select(5, GetItemInfoInstant(exItemID))
                exText = " " .. AddTexture(tex) .. exItemLink
            end

            -- 是否职业任务
            if classID then
                local className, classFile = GetClassInfo(classID)
                local _, _, _, colorStr = GetClassColor(classFile)
                get = "|cff" .. color .. FBname .. "|c" .. colorStr .. className .. BG.STC_y1(QUESTS_LABEL) .. RR .. exText .. AddPrice(itemID) .. RR
            else
                get = "|cff" .. color .. FBname .. BG.STC_y1(faction .. QUESTS_LABEL) .. RR .. exText .. AddPrice(itemID) .. RR
            end

            tinsert(db_old, {
                itemID = itemID,
                link = link,
                level = level,
                quality = quality,
                texture = Texture,
                get = get,
                bindType = bindType,
                i = 0,
                players = players,
                type = GetTypeID(type),
                haved = CheckHaved(itemID)
            })
        elseif type == "currency" then -- 牌子
            local v = other
            local count = v.count
            local currencyID = v.currencyID
            local phase = v.phase
            local phaseText = ""
            if phase then
                phaseText = " |cff808080<" .. phase .. ">|r"
            end
            local otherItemID1 = v.otherItemID1
            local otherItemID1Count = v.otherItemID1Count
            local otherText = ""
            if otherItemID1 then
                local otherItemID1CountText = ""
                if otherItemID1Count and otherItemID1Count ~= 1 then
                    otherItemID1CountText = "x" .. otherItemID1Count
                end
                local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID, bindType = GetItemInfo(otherItemID1)
                otherText = " + " .. AddTexture(Texture) .. link .. otherItemID1CountText
            end

            local name = C_CurrencyInfo.GetCurrencyInfo(currencyID).name
            local tex = C_CurrencyInfo.GetCurrencyInfo(currencyID).iconFileID
            local quantity = C_CurrencyInfo.GetCurrencyInfo(currencyID).quantity
            local color = "00FF00"
            if count then
                if quantity < count then
                    color = "FF0000"
                end
            else
                count = ""
            end
            local get = BG.STC_y1(AddTexture(tex) .. name .. " " .. "|cff" .. color .. count .. RR) .. AddPrice(itemID) .. otherText .. phaseText

            tinsert(db_old, {
                itemID = itemID,
                link = link,
                level = level,
                quality = quality,
                texture = Texture,
                get = get,
                bindType = bindType,
                type = GetTypeID(type),
                type2 = get,
                haved = CheckHaved(itemID)
            })
        elseif type == "faction" then -- 声望
            local tbl = {
                FACTION_STANDING_LABEL4,
                FACTION_STANDING_LABEL5,
                FACTION_STANDING_LABEL6,
                FACTION_STANDING_LABEL7,
                FACTION_STANDING_LABEL8,
            }
            local faction, standingID = strsplit(":", other)
            local standing = ""
            if standingID then
                standing = "-" .. tbl[tonumber(standingID)]
            end
            local factionName = GetFactionInfoByID(faction) or ""

            local name = REPUTATION .. ": " .. factionName .. standing
            local get = BG.STC_g2(name) .. AddPrice(itemID)

            tinsert(db_old, {
                itemID = itemID,
                link = link,
                level = level,
                quality = quality,
                texture = Texture,
                get = get,
                bindType = bindType,
                type = GetTypeID(type),
                type2 = faction,
                haved = CheckHaved(itemID)
            })
        elseif type == "profession" then -- 专业制造
            local icon = ""
            if other == "锻造" then
                icon = AddTexture(136241, nil, ":100:100:8:92:8:92")
            elseif other == "制皮" then
                icon = AddTexture(133611, nil, ":100:100:8:92:8:92")
            elseif other == "裁缝" then
                icon = AddTexture(136249, nil, ":100:100:8:92:8:92")
            elseif other == "工程" then
                icon = AddTexture(136243, nil, ":100:100:8:92:8:92")
            elseif other == "附魔" then
                icon = AddTexture(136244, nil, ":100:100:8:92:8:92")
            elseif other == "珠宝加工" then
                icon = AddTexture(134071, nil, ":100:100:8:92:8:92")
            elseif other == "铭文" then
                icon = AddTexture(237171, nil, ":100:100:8:92:8:92")
            elseif other == "考古" then
                icon = AddTexture(441139, nil, ":100:100:8:92:8:92")
            end
            local name = TRADE_SKILLS .. ": " .. L[other] .. icon
            local get = BG.STC_y2(name) .. AddPrice(itemID)

            tinsert(db_old, {
                itemID = itemID,
                link = link,
                level = level,
                quality = quality,
                texture = Texture,
                get = get,
                bindType = bindType,
                type = GetTypeID(type),
                type2 = other,
                haved = CheckHaved(itemID)
            })
        elseif type == "fb5" then -- 5人本
            local FB_5, BossName = strsplit("#", other)

            -- 兑换物
            local exText = ""
            local exItemID, exItemLink = GetkExchangeItemInfo(itemID)
            if exItemLink then
                local tex = select(5, GetItemInfoInstant(exItemID))
                exText = " " .. AddTexture(tex) .. exItemLink
            end

            local get = "|cff" .. "9999FF" .. FB_5 .. " " .. BossName .. exText .. RR .. AddPrice(exItemID or itemID)

            tinsert(db_old, {
                itemID = itemID,
                link = link,
                level = level,
                quality = quality,
                texture = Texture,
                get = get,
                bindType = bindType,
                type = GetTypeID(type),
                type2 = FB_5,
                haved = CheckHaved(itemID)
            })
        elseif type == "world" then -- 世界掉落
            -- 兑换物
            local exText = ""
            local exItemID, exItemLink = GetkExchangeItemInfo(itemID)
            if exItemLink then
                local tex = select(5, GetItemInfoInstant(exItemID))
                exText = " " .. AddTexture(tex) .. exItemLink
            end

            local get = "|cff" .. "DEB887" .. L["世界掉落"] .. RR .. exText .. AddPrice(exItemID or itemID)

            tinsert(db_old, {
                itemID = itemID,
                link = link,
                level = level,
                quality = quality,
                texture = Texture,
                get = get,
                bindType = bindType,
                type = GetTypeID(type),
                haved = CheckHaved(itemID)
            })
        elseif type == "worldboss" then -- 世界BOSS
            local name = L["世界BOSS"] .. " " .. L[other]
            local get = "|cff" .. "FF6347" .. name .. AddPrice(itemID)

            tinsert(db_old, {
                itemID = itemID,
                link = link,
                level = level,
                quality = quality,
                texture = Texture,
                get = get,
                bindType = bindType,
                type = GetTypeID(type),
                haved = CheckHaved(itemID)
            })
        elseif type == "pvp" then -- PVP
            local faction, levelID = strsplit(":", other)
            local tx
            if faction == "Alliance" then
                tx = "1"
            elseif faction == "Horde" then
                tx = "0"
            end
            local tbl = {
                _G["PVP_RANK_5_" .. tx],
                _G["PVP_RANK_6_" .. tx],
                _G["PVP_RANK_7_" .. tx],
                _G["PVP_RANK_8_" .. tx],
                _G["PVP_RANK_9_" .. tx],
                _G["PVP_RANK_10_" .. tx],
                _G["PVP_RANK_11_" .. tx],
                _G["PVP_RANK_12_" .. tx],
                _G["PVP_RANK_13_" .. tx],
                _G["PVP_RANK_14_" .. tx],
                _G["PVP_RANK_15_" .. tx],
                _G["PVP_RANK_16_" .. tx],
                _G["PVP_RANK_17_" .. tx],
                _G["PVP_RANK_18_" .. tx],
            }

            local standing = tbl[tonumber(levelID)]
            local newID
            if tonumber(levelID) < 10 then
                newID = "0" .. levelID
            else
                newID = levelID
            end
            local icon = AddTexture("interface/pvprankbadges/pvprank" .. newID) or ""

            local name = "PVP: " .. standing .. icon
            local get = "|cff" .. "EE82EE" .. name .. RR .. AddPrice(itemID)

            tinsert(db_old, {
                itemID = itemID,
                link = link,
                level = level,
                quality = quality,
                texture = Texture,
                get = get,
                bindType = bindType,
                type = GetTypeID(type),
                haved = CheckHaved(itemID)
            })
        elseif type == "sod_currency" then -- 赛季服货币/牌子
            local get, count, icon, color, _type = strsplit("-", other)
            if not count then
                count = ""
            elseif _type and _type ~= "" then
                count = select(2, GetItemInfo(count)) or ""
            end
            if not color then color = "FFFFFF" end
            local get = "|cff" .. color .. get .. RR .. " " .. count .. AddTexture(icon) .. RR .. AddPrice(itemID)
            tinsert(db_old, {
                itemID = itemID,
                link = link,
                level = level,
                quality = quality,
                texture = Texture,
                get = get,
                bindType = bindType,
                type = GetTypeID(type),
                type2 = get,
                haved = CheckHaved(itemID)
            })
        elseif type == "pvp_currency" then -- 牌子
            local v = other
            local count = v.count
            local currencyID = v.currencyID
            local phase = v.phase
            local phaseText = ""
            if phase then
                phaseText = " |cff808080<" .. phase .. ">|r"
            end
            local otherItemID1 = v.otherItemID1
            local otherItemID1Count = v.otherItemID1Count
            local otherText = ""
            if otherItemID1 then
                local otherItemID1CountText = ""
                if otherItemID1Count and otherItemID1Count ~= 1 then
                    otherItemID1CountText = "x" .. otherItemID1Count
                end
                local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID, bindType = GetItemInfo(otherItemID1)
                otherText = " + " .. AddTexture(Texture) .. link .. otherItemID1CountText
            end

            local name = C_CurrencyInfo.GetCurrencyInfo(currencyID).name
            local tex = C_CurrencyInfo.GetCurrencyInfo(currencyID).iconFileID
            local quantity = C_CurrencyInfo.GetCurrencyInfo(currencyID).quantity
            local color = "00FF00"
            if count then
                if quantity < count then
                    color = "FF0000"
                end
            else
                count = ""
            end
            local get = BG.STC_y1(AddTexture(tex) .. name .. " " .. "|cff" .. color .. count .. RR) .. AddPrice(itemID) .. otherText .. phaseText

            tinsert(db_old, {
                itemID = itemID,
                link = link,
                level = level,
                quality = quality,
                texture = Texture,
                get = get,
                bindType = bindType,
                type = GetTypeID(type),
                haved = CheckHaved(itemID)
            })
        end
    end
    function CheckItemInfo()
        db = {}
        db_old = {}
        local FB = BG.FB1
        local hard, ii, k, otherID
        for _, FB in pairs(BG.phaseFBtable[FB]) do
            -- 团本
            for _, hard in ipairs(BG.difficultyTable[FB]) do
                local trueRaidDifficulty = true
                if BG.IsVanilla then
                    if BiaoGe.ItemLib.fitlerGet.raid then
                        trueRaidDifficulty = false
                    end
                else
                    if BiaoGe.ItemLib.fitlerGet.raidmyth and strfind(hard, "M") then
                        trueRaidDifficulty = false
                    elseif BiaoGe.ItemLib.fitlerGet.raidhero and strfind(hard, "H") then
                        trueRaidDifficulty = false
                    elseif BiaoGe.ItemLib.fitlerGet.raidnormal and strfind(hard, "N") then
                        trueRaidDifficulty = false
                    elseif BiaoGe.ItemLib.fitlerGet.raid25 and strfind(hard, "25") then
                        trueRaidDifficulty = false
                    elseif BiaoGe.ItemLib.fitlerGet.raid10 and strfind(hard, "10") then
                        trueRaidDifficulty = false
                    end
                end

                if trueRaidDifficulty then
                    if BG.Loot[FB][hard] then
                        local ii = 1
                        while BG.Loot[FB][hard]["boss" .. ii] do
                            if not (FB == "TOC" and ii == 7 and hard:find("H")) then
                                for i, itemID in ipairs(BG.Loot[FB][hard]["boss" .. ii]) do
                                    InsertItemInfo(itemID, "raid", hard, ii, k)
                                end
                                -- BOSS掉落后兑换的装备
                                if BG.Loot[FB][hard]["boss" .. ii .. "other"] then
                                    for i, itemID in ipairs(BG.Loot[FB][hard]["boss" .. ii .. "other"]) do
                                        InsertItemInfo(itemID, "raid", hard, ii, "other")
                                    end
                                end
                            end
                            ii = ii + 1
                        end
                        -- 团本任务奖励
                        local ii = 1
                        if BG.Loot[FB][hard].Quest then
                            for name, _ in pairs(BG.Loot[FB][hard].Quest) do
                                for _, itemID in pairs(BG.Loot[FB][hard].Quest[name]) do
                                    InsertItemInfo(itemID, "raid", hard, ii, name)
                                end
                            end
                        end
                    end
                end
            end
            -- 5人本
            if not BiaoGe.ItemLib.fitlerGet.fb5 then
                for FB_5 in pairs(BG.Loot[FB].Team) do
                    for BossName, _ in pairs(BG.Loot[FB].Team[FB_5]) do
                        for _, itemID in pairs(BG.Loot[FB].Team[FB_5][BossName]) do
                            InsertItemInfo(itemID, "fb5", hard, ii, FB_5 .. "#" .. BossName)
                        end
                    end
                end
            end
            -- 野外任务
            for k, v in pairs(BG.Loot[FB].Quest) do
                for i, itemID in ipairs(BG.Loot[FB].Quest[k].itemID) do
                    InsertItemInfo(itemID, "quest", hard, ii, v)
                end
            end
            -- 牌子装备
            if not BiaoGe.ItemLib.fitlerGet.currency then
                for itemID, v in pairs(BG.Loot[FB].Currency) do
                    InsertItemInfo(itemID, "currency", hard, ii, v)
                end
            end
            -- 赛季服货币/牌子
            if not BiaoGe.ItemLib.fitlerGet.currency then
                for i, v in pairs(BG.Loot[FB].Sod_Currency) do
                    for itemID, currency in pairs(BG.Loot[FB].Sod_Currency[i]) do
                        InsertItemInfo(itemID, "sod_currency", hard, ii, currency)
                    end
                end
            end
            -- 声望装备
            if not BiaoGe.ItemLib.fitlerGet.faction then
                for k, v in pairs(BG.Loot[FB].Faction) do
                    for i, itemID in ipairs(BG.Loot[FB].Faction[k]) do
                        InsertItemInfo(itemID, "faction", hard, ii, k)
                    end
                end
            end
            -- 专业制造
            if not BiaoGe.ItemLib.fitlerGet.profession then
                for k, v in pairs(BG.Loot[FB].Profession) do
                    for i, itemID in ipairs(BG.Loot[FB].Profession[k]) do
                        InsertItemInfo(itemID, "profession", hard, ii, k)
                    end
                end
            end
            -- 世界掉落
            if not BiaoGe.ItemLib.fitlerGet.world then
                for i, itemID in ipairs(BG.Loot[FB].World) do
                    InsertItemInfo(itemID, "world", hard, ii, k)
                end
            end
            -- 世界BOSS
            if not BiaoGe.ItemLib.fitlerGet.worldboss then
                for k, v in pairs(BG.Loot[FB].WorldBoss) do
                    for i, itemID in ipairs(BG.Loot[FB].WorldBoss[k]) do
                        InsertItemInfo(itemID, "worldboss", hard, ii, k)
                    end
                end
            end
            -- PVP
            if not BiaoGe.ItemLib.fitlerGet.pvp then
                for k, v in pairs(BG.Loot[FB].PVP) do
                    for i, itemID in ipairs(BG.Loot[FB].PVP[k]) do
                        InsertItemInfo(itemID, "pvp", hard, ii, k)
                    end
                end
            end
            -- PVP货币
            if not BiaoGe.ItemLib.fitlerGet.pvp then
                for itemID, v in pairs(BG.Loot[FB].PVP_currency) do
                    InsertItemInfo(itemID, "pvp_currency", hard, ii, v)
                end
            end
        end
    end

    -- 删除重复装备，合并获取途径
    function CheckSameItem()
        local tbl = {}
        for _, v in ipairs(db_old) do
            local itemID = v.itemID
            if not tbl[itemID] then
                tbl[itemID] = v
                tbl[itemID].getTbl = {}
                tinsert(tbl[itemID].getTbl, tbl[itemID].get)
            else
                tinsert(tbl[itemID].getTbl, v.get)
            end
        end
        for k, v in pairs(tbl) do
            tinsert(db, v)
        end
    end

    -- 排序
    function Sort()
        sort(db, function(a, b)
            local tbl
            if BiaoGe.ItemLib.itemLibOrderButtonID == 2 then -- 按装等排序
                tbl = {
                    { key = "level", order = 1 },
                    { key = "quality", order = 1 },
                    { key = "type", order = 4 },
                    { key = "type2", order = 1 },
                    { key = "players", order = 3 },
                }
            elseif BiaoGe.ItemLib.itemLibOrderButtonID == 3 then -- 按装备品质排序
                tbl = {
                    { key = "quality", order = 1 },
                    { key = "level", order = 1 },
                    { key = "type", order = 4 },
                    { key = "type2", order = 1 },
                    { key = "players", order = 3 },
                }
            elseif BiaoGe.ItemLib.itemLibOrderButtonID == 4 then -- 按获取途径排序
                tbl = {
                    { key = "type", order = 2 },
                    { key = "type2", order = 2 },
                    { key = "players", order = 3 },
                    { key = "hardnum", order = 3 },
                    { key = "level", order = 3 },
                    { key = "quality", order = 3 },
                }
            end
            tinsert(tbl, { key = "i", order = 3 })
            tinsert(tbl, { key = "hardnum", order = 3 })

            for _, v in ipairs(tbl) do
                local key = v.key
                if a[key] and b[key] then
                    -- pt(key,a[key])
                    if a[key] ~= b[key] then
                        local order = v.order
                        if order == 1 then
                            if BiaoGe.ItemLib.itemLibOrder == 1 then
                                return a[key] > b[key]
                            else
                                return b[key] > a[key]
                            end
                        elseif order == 2 then
                            if BiaoGe.ItemLib.itemLibOrder == 1 then
                                return b[key] > a[key]
                            else
                                return a[key] > b[key]
                            end
                        elseif order == 3 then
                            return a[key] > b[key]
                        elseif order == 4 then
                            return a[key] < b[key]
                        end
                    end
                end
            end
            return false
        end)

        local sorter = BG.ItemLibMainFrame.sorter
        local bt = BG.ItemLibMainFrame["title" .. BiaoGe.ItemLib.itemLibOrderButtonID]
        sorter:SetParent(bt)
        sorter:ClearAllPoints()
        if bt.textJustifyH == "CENTER" then
            sorter:SetPoint("LEFT", bt, "CENTER", bt.textwidth / 2, 0)
        else
            sorter:SetPoint("LEFT", bt, "LEFT", bt.textwidth, 0)
        end
        if not mainFrame.isnewsorter then
            if BiaoGe.ItemLib.itemLibOrder == 1 then
                sorter:SetTexCoord(0, 0.5, 0, 1)
            else
                sorter:SetTexCoord(0, 0.5, 1, 0)
            end
        end
    end
end

local function SetItemLib()
    -- 先隐藏之前的列表内容
    mainFrame.scroll.ScrollBar:Hide()
    for k, bt in pairs(mainFrame.buttons) do
        bt:Hide()
        mainFrame.buttons[k] = nil
    end

    for ii, vv in ipairs(db) do
        local lastButton
        local i_table = { ii, vv.level, (AddTexture(vv.texture) .. vv.link), vv.getTbl[1] }
        for i, v in ipairs(titleTbl) do
            local f = CreateFrame("Frame", nil, mainFrame.child)
            if i == #titleTbl then
                f:SetSize(titleTbl[i].width - 2, BUTTONHEIGHT)
            else
                f:SetSize(titleTbl[i].width, BUTTONHEIGHT)
            end
            if ii == 1 and i == 1 then
                f:SetPoint("TOPLEFT", mainFrame.child, 10, 0)
                mainFrame.buttons[ii] = f
            elseif i == 1 then
                f:SetPoint("TOPLEFT", mainFrame.buttons[ii - 1], "BOTTOMLEFT", 0, 0)
                mainFrame.buttons[ii] = f
            else
                f:SetPoint("LEFT", lastButton, "RIGHT", 0, 0)
                f:SetParent(mainFrame.buttons[ii])
            end
            lastButton = f
            mainFrame.buttoncount = ii
            f.num = ii
            f.itemID = GetItemInfoInstant(vv.link)
            f.itemLink = vv.link
            f.Text = f:CreateFontString()
            f.Text:SetFont(STANDARD_TEXT_FONT, i == 1 and 13 or 15, "OUTLINE")
            f.Text:SetPoint("CENTER")
            f.Text:SetTextColor(RGB(titleTbl[i].color))
            f.Text:SetJustifyH(titleTbl[i].JustifyH)
            f.Text:SetWidth(f:GetWidth())
            f.Text:SetWordWrap(false)
            if i == 4 and #vv.getTbl > 1 then
                f.Text:SetText(i_table[i] .. "\n\n")
            else
                f.Text:SetText(i_table[i])
            end
            if i == 1 then
                f.Text:SetTextColor(RGB(BG.dis))
            end
            if f.Text:GetStringWidth() > f.Text:GetWidth() or strfind(i_table[i], "\n") then
                f.onenter = i_table[i]
            end
            if i == 3 then
                mainFrame.buttons[ii].item = f
                mainFrame.buttons[ii].itemID = GetItemID(f.Text:GetText())
            end
            if i == 4 then
                mainFrame.buttons[ii].get = f
            end

            f:SetScript("OnMouseDown", function(self)
                if IsShiftKeyDown() then
                    BG.InsertLink(vv.link)
                elseif IsAltKeyDown() then
                    if mainFrame.buttons[ii].item.hope:IsVisible() then return end
                    local itemID = GetItemInfoInstant(vv.link)
                    local nandu, boss, FB, isRaid = vv.hardnum, vv.i, vv.FB, vv.isRaid
                    if not (isRaid and nandu and boss and FB) then
                        UIErrorsFrame:AddMessage(L["只能设置团本BOSS正常掉落的装备为心愿"], RED_FONT_COLOR:GetRGB())
                        return
                    end

                    local exItemID, exItemLink = GetkExchangeItemInfo(itemID)
                    if exItemID and exItemLink then
                        for k1, v1 in pairs(BG.Loot[FB]) do
                            if type(v1) == "table" then
                                for k2, v2 in pairs(BG.Loot[FB][k1]) do -- BG.Loot.Gno.N
                                    if type(v2) == "table" and type(k2) == "string" then
                                        local boss = tonumber(k2:match("^boss(%d+)"))
                                        if boss then
                                            for k3, v3 in pairs(BG.Loot[FB][k1][k2]) do -- BG.Loot.Gno.N.boss1
                                                if v3 == exItemID then
                                                    for i = 1, HopeMaxi do
                                                        if BG.HopeFrame[FB]["nandu" .. nandu]["boss" .. boss]["zhuangbei" .. i]:GetText() == "" then
                                                            BG.HopeFrame[FB]["nandu" .. nandu]["boss" .. boss]["zhuangbei" .. i]:SetText(exItemLink)
                                                            BiaoGe.Hope[RealmID][player][FB]["nandu" .. nandu]["boss" .. boss]["zhuangbei" .. i] = exItemLink
                                                            mainFrame.buttons[ii].item.hope:Show()
                                                            BG.UpdateItemLib_LeftHope_All()
                                                            return
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if boss == Maxb[FB] then
                            for n = 1, HopeMaxn[FB] do
                                for b = 1, HopeMaxb[FB] do
                                    for i = 1, HopeMaxi do
                                        local hope = BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                                        if hope and hope:GetText() == "" then
                                            hope:SetText(vv.link)
                                            BiaoGe.Hope[RealmID][player][FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] = vv.link
                                            mainFrame.buttons[ii].item.hope:Show()
                                            BG.UpdateItemLib_RightHope_All()
                                            return
                                        end
                                    end
                                end
                            end
                        else
                            for i = 1, HopeMaxi do
                                if BG.HopeFrame[FB]["nandu" .. nandu]["boss" .. boss]["zhuangbei" .. i] and
                                    BG.HopeFrame[FB]["nandu" .. nandu]["boss" .. boss]["zhuangbei" .. i]:GetText() == "" then
                                    BG.HopeFrame[FB]["nandu" .. nandu]["boss" .. boss]["zhuangbei" .. i]:SetText(vv.link)
                                    BiaoGe.Hope[RealmID][player][FB]["nandu" .. nandu]["boss" .. boss]["zhuangbei" .. i] = vv.link
                                    mainFrame.buttons[ii].item.hope:Show()
                                    BG.UpdateItemLib_RightHope_All()
                                    return
                                end
                            end
                        end
                    end
                    UIErrorsFrame:AddMessage(L["不能设置为心愿，因为该BOSS的心愿格子已满"], RED_FONT_COLOR:GetRGB())
                elseif IsControlKeyDown() then
                    DressUpItemLink(vv.link)
                end
            end)

            f:SetScript("OnEnter", function(self)
                if i == 4 and #vv.getTbl > 1 then
                    BiaoGeTooltip2:SetOwner(self, "ANCHOR_TOPRIGHT", 0, 0)
                    BiaoGeTooltip2:ClearLines()
                    local text = BG.STC_w1(L["多个获取途径"]) .. NN .. NN
                    for i, v in ipairs(vv.getTbl) do
                        text = text .. v .. NN
                    end
                    BiaoGeTooltip2:SetText(text)
                elseif self.onenter and i ~= 3 then
                    BiaoGeTooltip2:SetOwner(self, "ANCHOR_TOPRIGHT", 0, 0)
                    BiaoGeTooltip2:ClearLines()
                    BiaoGeTooltip2:AddLine(self.onenter, 1, 1, 1, false)
                    BiaoGeTooltip2:Show()
                end
                if BG.ButtonIsInRight(mainFrame.bg) then
                    GameTooltip:SetOwner(mainFrame.bg.tooltip2, "ANCHOR_BOTTOMLEFT", 0, 0)
                else
                    GameTooltip:SetOwner(mainFrame.bg.tooltip, "ANCHOR_BOTTOMRIGHT", 0, 0)
                end
                GameTooltip:ClearLines()
                GameTooltip:SetHyperlink(BG.SetSpecIDToLink(vv.link))
                mainFrame.buttons[ii].ds:Show()

                BG.DressUpLastButton = f
                if IsControlKeyDown() then
                    SetCursor("Interface/Cursor/Inspect")
                    BG.DressUp()
                elseif IsAltKeyDown() then
                    SetCursor("interface/cursor/quest")
                end
                BG.canShowInspectCursor = true
                BG.canShowHopeCursor = true
            end)
            f:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                BiaoGeTooltip2:Hide()
                mainFrame.buttons[ii].ds:Hide()
                SetCursor(nil)
                BG.canShowInspectCursor = false
                BG.canShowHopeCursor = false
                if BG.DressUpFrame then
                    BG.DressUpFrame:Hide()
                end
                BG.DressUpLastButton = nil
            end)

            if i == 3 and vv.bindType == 2 then -- 装绑
                BG.BindOnEquip(f, vv.bindType, f:GetHeight())
                f.bindingTex:SetScript("OnEnter", function(self)
                    BiaoGeTooltip2:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                    BiaoGeTooltip2:ClearLines()
                    BiaoGeTooltip2:AddLine(L["装绑"], 1, 1, 1, true)
                    BiaoGeTooltip2:Show()
                    f:GetScript("OnEnter")(f)
                end)
                f.bindingTex:SetScript("OnLeave", function(self)
                    f:GetScript("OnLeave")(f)
                end)
            end
            if i == 3 then -- 心愿
                local frame = CreateFrame("Frame", nil, f)
                frame:SetSize(50, 20)
                frame:SetPoint("RIGHT", -5, 0)
                frame:SetFrameLevel(110)
                if not vv.hope then
                    frame:Hide()
                end
                f.hope = frame
                local t = frame:CreateFontString()
                t:SetPoint("RIGHT")
                t:SetSize(50, 20)
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                t:SetTextColor(RGB(BG.y2))
                t:SetText(BG.STC_g1(L["心愿"]))
                t:SetJustifyH("RIGHT")
                frame:SetWidth(t:GetWrappedWidth())

                frame:SetScript("OnEnter", function(self)
                    BiaoGeTooltip2:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                    BiaoGeTooltip2:ClearLines()
                    BiaoGeTooltip2:AddLine(BG.STC_g1(L["心愿装备"]), 1, 1, 1, true)
                    local itemID = f.itemID
                    local exItemID, exItemLink = GetkExchangeItemInfo(itemID)
                    if exItemLink then
                        local tex = select(5, GetItemInfoInstant(exItemID))
                        BiaoGeTooltip2:AddLine(AddTexture(tex) .. exItemLink .. L["掉落后会提醒"], 1, 1, 1, true)
                    else
                        BiaoGeTooltip2:AddLine(L["掉落后会提醒"], 1, 1, 1, true)
                    end
                    BiaoGeTooltip2:AddLine(AddTexture("RIGHT") .. L["取消心愿装备"], 1, 0.82, 0, true)
                    BiaoGeTooltip2:Show()
                    f:GetScript("OnEnter")(f)
                end)
                frame:SetScript("OnLeave", function(self)
                    f:GetScript("OnLeave")(f)
                end)
                frame:SetScript("OnMouseDown", function(self, enter)
                    if enter == "RightButton" then
                        self:Hide()
                        local itemID = GetItemInfoInstant(vv.link)
                        BG.UpdateItemLib_RightHope(itemID, 0)
                        BG.UpdateHopeFrame_Hope(itemID, 0)
                        BG.UpdateItemLib_LeftHope_All()
                    end
                end)
            end
            if i == 3 then -- 已拥有
                local tex = f:CreateTexture(nil, "OVERLAY")
                tex:SetSize(28, 28)
                tex:SetPoint("LEFT", f, "LEFT", -5, 0)
                tex:SetTexture("interface/raidframe/readycheck-ready")
                f.haved = tex
                if not vv.haved then
                    tex:Hide()
                end
            end
            if i == 4 then -- 已掉落
                BG.LootedText(f)
                BG.Update_IsLooted(f, vv.itemID)
            end
        end
        -- 底色材质
        local f = mainFrame.buttons[ii]
        f.ds = f:CreateTexture()
        f.ds:SetSize(WIDTH, f:GetHeight())
        f.ds:SetPoint("LEFT")
        f.ds:SetColorTexture(1, 1, 1, 0.1)
        f.ds:Hide()

        CreateLine(f, 0, WIDTH, 1, nil, 0.2)
    end
end
local function UpdateTiptext()
    local FB = BG.FB1
    if BiaoGe.FilterClassItemDB[RealmID][player].chooseID then
        mainFrame.noItem:SetText(L["该部位没有合适当前过滤方案的装备"])
    else
        mainFrame.noItem:SetText(L["请在下方选择一个过滤方案"])
    end
    mainFrame.noItem:SetShown(not next(db))

    local P = BG.GetFBinfo(FB, "phase")
    local B = ""
    for i, v in ipairs(BG.invtypetable) do
        if v.key[1] == BiaoGe.ItemLib.ItemLibInvType[1] then
            B = (v.name)
        end
    end

    local F = BG.STC_dis(L["没有过滤方案"])
    local n = BiaoGe.FilterClassItemDB[RealmID][player].chooseID
    if n then
        F = BiaoGe.FilterClassItemDB[RealmID][player][n].Name
    end

    local C
    local count = #db
    if count == 0 then
        C = BG.STC_dis(count .. L["件"])
    else
        C = BG.STC_g1(count .. L["件"])
    end
    mainFrame.toptitle:SetText(BG.STC_b1(P .. "   " .. B .. "   " .. F .. "   " .. C))
end

local function StartUpdate()
    CheckItemInfo() -- 找出符合条件的装备
    BG.After(0, function()
        CheckSameItem()
        Sort()
        BG.After(0, function()
            SetItemLib() -- 生成列表
            UpdateTiptext()
        end)
    end)
end
function BG.UpdateItemLib()
    if not mainFrame:IsVisible() then return end
    BG.itemLibNeedUpdate = false
    local FB = BG.FB1
    if not info[FB] then -- 如果还没缓存该副本，则先缓存
        dbOK = false
        local t = CreateLoadingText()
        CreateAllItemInfoCache()
        BG.OnUpdateTime(function(self, elapsed)
            if dbOK then
                self:SetScript("OnUpdate", nil)
                self:Hide()
                t:Hide()
                StartUpdate()
            end
        end)
    else -- 否则直接开始生成
        StartUpdate()
    end
end

function BG.UpdateAllItemLib()
    BG.UpdateItemLib()
    BG.UpdateItemLib_RightHope_All()
    BG.UpdateItemLib_RightHope_IsHaved_All()
    BG.UpdateItemLib_RightHope_IsLooted_All()
    BG.ItemLibMainFrame.iLevelEdit:SetText(BiaoGe.ItemLib.iLevel[BG.FB1] or "")
end

-- 更新心愿装备
do
    function BG.GetEquipLocName(EquipLoc) -- 返回该装备部位对应的invtypetable名称
        for i, v in ipairs(BG.invtypetable) do
            for ii, _EquipLoc in ipairs(BG.invtypetable[i].key) do
                if EquipLoc == _EquipLoc then
                    return v.name2
                end
            end
        end
    end

    local function CheckIsSave_ItemLib_RightHope(itemID)
        for i, v in ipairs(BG.invtypetable) do
            local EquipLoc = v.name2
            for i = 1, maxhope do
                local hope = mainFrame.Hope[EquipLoc .. i]
                local _itemID = GetItemID(hope:GetText())
                if _itemID == itemID then
                    return true
                end
            end
        end
    end
    function BG.UpdateItemLib_RightHope(itemID, ShoworHide) -- 更新心愿汇总，ShoworHide：1为添加装备，0为删除装备
        local FB = BG.FB1
        local name, link, quality, level, _, _, _, _, EquipLoc, Texture
        if type(itemID) == "number" then
            name, link, quality, level, _, _, _, _, EquipLoc, Texture = GetItemInfo(itemID)
        else
            name, link, quality, level, _, _, _, _, EquipLoc, Texture = GetItemInfo(itemID)
        end
        local EquipLoc = BG.GetEquipLocName(EquipLoc)
        if not EquipLoc then return end
        -- 只需历遍对应部位的心愿格子
        for i = 1, maxhope do
            local hope = mainFrame.Hope[EquipLoc .. i]
            if ShoworHide == 1 then
                if not CheckIsSave_ItemLib_RightHope(itemID) then
                    if hope:GetText() == "" then
                        hope:SetText(AddTexture(Texture) .. link)
                        hope:SetCursorPosition(0)
                        return
                    end
                end
            else
                if GetItemID(hope:GetText()) == itemID then
                    hope:SetText("")
                end
            end
        end
    end

    function BG.UpdateItemLib_LeftHope(itemID, ShoworHide)
        local count = mainFrame.buttoncount
        if count then
            for i = 1, count do
                if mainFrame.buttons[i] then
                    local _itemID = mainFrame.buttons[i].itemID

                    local isExItem

                    local exItemID, exItemLink = GetkExchangeItemInfo(_itemID)
                    if itemID == exItemID then
                        isExItem = true
                    end

                    if itemID == _itemID or isExItem then
                        if ShoworHide == 1 then
                            mainFrame.buttons[i].item.hope:Show()
                        else
                            mainFrame.buttons[i].item.hope:Hide()
                        end
                    end
                end
            end
        end
    end

    function BG.UpdateItemLib_LeftHope_HideAll()
        local count = mainFrame.buttoncount
        if count then
            for i = 1, count do
                if mainFrame.buttons[i] then
                    mainFrame.buttons[i].item.hope:Hide()
                end
            end
        end
    end

    function BG.UpdateItemLib_RightHope_HideAll()
        for i, v in ipairs(BG.invtypetable) do
            local EquipLoc = v.name2
            for i = 1, maxhope do
                local hope = mainFrame.Hope[EquipLoc .. i]
                hope:SetText("")
            end
        end
    end

    function BG.UpdateHopeFrame_Hope(itemID, ShoworHide) -- 更新心愿清单，ShoworHide：1为添加装备，0为删除装备（该函数用于删除心愿清单）
        local exItemID, exItemLink = GetkExchangeItemInfo(itemID)
        if exItemID then
            itemID = exItemID
        end

        for _, FB in pairs(BG.phaseFBtable[BG.FB1]) do
            if ShoworHide == 0 then
                for n = 1, HopeMaxn[FB] do
                    for b = 1, HopeMaxb[FB] do
                        for i = 1, HopeMaxi do
                            if BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] then
                                if itemID == GetItemID(BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]:GetText()) then
                                    BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]:SetText("")
                                    BiaoGe.Hope[RealmID][player][FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] = nil
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    function BG.UpdateItemLib_LeftHope_All()
        BG.UpdateItemLib_LeftHope_HideAll()

        for _, FB in pairs(BG.phaseFBtable[BG.FB1]) do
            for n = HopeMaxn[FB], 1, -1 do
                for b = HopeMaxb[FB], 1, -1 do
                    for i = 1, HopeMaxi do
                        local bt = BiaoGe.Hope[RealmID][player][FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                        if bt then
                            local itemID = GetItemID(bt)
                            if itemID then
                                BG.UpdateItemLib_LeftHope(itemID, 1)
                            end
                        end
                    end
                end
            end
        end
    end

    function BG.UpdateItemLib_RightHope_All()
        BG.UpdateItemLib_RightHope_HideAll()
        local FBtable = BG.phaseFBtable[BG.FB1]
        if BG.IsVanilla_60 then
            FBtable = { BG.FB1 }
        end
        for _, FB in pairs(FBtable) do
            for n = HopeMaxn[FB], 1, -1 do
                for b = HopeMaxb[FB], 1, -1 do
                    for i = 1, HopeMaxi do
                        local link = BiaoGe.Hope[RealmID][player][FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                        if link and GetItemID(link) then
                            BG.UpdateItemLib_RightHope(link, 1)
                        end
                    end
                end
            end
        end
    end

    function BG.Update_IsHaved(bt)
        local itemID = GetItemID(bt:GetText())
        if itemID then
            if BG.GetItemCount(itemID) ~= 0 then
                bt.haved:Show()
            else
                bt.haved:Hide()
            end
        else
            bt.haved:Hide()
        end
    end

    function BG.UpdateItemLib_LeftLib_IsHaved_All()
        local count = mainFrame.buttoncount
        if count then
            for i = 1, count do
                if mainFrame.buttons[i] then
                    local item = mainFrame.buttons[i].item
                    local itemID = mainFrame.buttons[i].itemID
                    if BG.GetItemCount(itemID) ~= 0 then
                        item.haved:Show()
                    else
                        item.haved:Hide()
                    end
                end
            end
        end
    end

    function BG.UpdateItemLib_RightHope_IsHaved_All()
        if mainFrame:IsVisible() then
            for k, bt in pairs(mainFrame.Hope) do
                if type(bt) == "table" and bt.EquipLoc then
                    BG.Update_IsHaved(bt)
                end
            end
        end
    end

    function BG.Update_IsLooted(bt, itemID)
        local FB = BG.FB1
        local itemID = itemID or GetItemID(bt:GetText())
        if itemID then
            for b = 1, Maxb[FB] do
                for i = 1, BG.GetMaxi(FB, b) do
                    local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                    if zb then
                        local _itemID = GetItemID(zb:GetText())
                        if itemID == _itemID then
                            bt.looted:Show()
                            return
                        end
                    end
                end
            end
        end
        bt.looted:Hide()
    end

    function BG.UpdateItemLib_LeftLib_IsLooted_All()
        local count = mainFrame.buttoncount
        if count then
            for i = 1, count do
                if mainFrame.buttons[i] then
                    local get = mainFrame.buttons[i].get
                    local itemID = mainFrame.buttons[i].itemID
                    BG.Update_IsLooted(get, itemID)
                end
            end
        end
    end

    function BG.UpdateItemLib_RightHope_IsLooted_All()
        if mainFrame:IsVisible() then
            for k, bt in pairs(mainFrame.Hope) do
                if type(bt) == "table" and bt.EquipLoc then
                    BG.Update_IsLooted(bt)
                end
            end
        end
    end

    function BG.UpdateHopeFrame_IsLooted_All()
        local FB = BG.FB1
        if BG["HopeFrame" .. FB]:IsVisible() then
            for n = 1, HopeMaxn[FB] do
                for b = 1, HopeMaxb[FB] do
                    for i = 1, HopeMaxi do
                        local hope = BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                        if hope then
                            BG.Update_IsLooted(hope)
                        end
                    end
                end
            end
            for k, bt in pairs(mainFrame.Hope) do
                if type(bt) == "table" and bt.EquipLoc then
                    BG.Update_IsLooted(bt)
                end
            end
        end
    end
end

-- 幻化
do
    function BG.DressUp()
        local itemID
        local last = BG.DressUpLastButton
        if not last then return end
        local frame
        if IsControlKeyDown() then
            if BG.ItemLibMainFrame:IsVisible() then
                itemID = last.itemID
                if itemID then
                    frame = 1
                else
                    itemID = GetItemID(last:GetText())
                    frame = 2
                end
            elseif BG.FBMainFrame:IsVisible() or BG.HopeMainFrame:IsVisible() then
                itemID = GetItemID(last:GetText())
                frame = 3
            end
            GameTooltip:Hide()
        else
            last:GetScript("OnEnter")(last)
            if BG.DressUpFrame then
                BG.DressUpFrame:Hide()
            end
        end
        if not itemID then return end
        local equipLoc, _, type = select(4, GetItemInfoInstant(itemID))
        local creatureID = BG.Mount[itemID] and BG.Mount[itemID][2]
        if not (type == 2 or type == 4 or creatureID) then
            return
        end
        if type == 4 and
            (equipLoc == "INVTYPE_NECK"
                or equipLoc == "INVTYPE_FINGER"
                or equipLoc == "INVTYPE_TRINKET")
        then
            return
        end
        if not BG.DressUpFrame then
            local bg = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
            bg:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            bg:SetBackdropColor(0, 0, 0, .8)
            bg:SetBackdropBorderColor(1, 1, 1, .8)
            bg:SetSize(430, 480)
            bg:SetFrameStrata("TOOLTIP")
            bg:SetClampedToScreen(true)
            local f = CreateFrame("DressUpModel", nil, bg)
            f:SetPoint("TOPLEFT", bg, "TOPLEFT", 5, -5)
            f:SetPoint("BOTTOMRIGHT", bg, "BOTTOMRIGHT", -5, 5)
            f.defaultRotation = MODELFRAME_DEFAULT_ROTATION
            f:SetRotation(MODELFRAME_DEFAULT_ROTATION)
            f.minZoom = 0
            f.maxZoom = 1.0
            f.curRotation = MODELFRAME_DEFAULT_ROTATION
            f.zoomLevel = f.minZoom
            f.zoomLevelNew = f.zoomLevel
            f:SetPortraitZoom(f.zoomLevel)
            -- f.Reset = _G.Model_Reset
            bg.modFrame = f
            BG.DressUpFrame = bg
        end
        local bg = BG.DressUpFrame
        bg:Show()
        bg:ClearAllPoints()
        local f = BG.DressUpFrame.modFrame
        f:ClearModel()
        if creatureID then
            f:SetCreature(creatureID)
            f:SetCamDistanceScale(BG.IsVanilla and 2 or 1)
            f:SetPortraitZoom(f.zoomLevel)
        else
            f:SetCamDistanceScale(1)
            if not BG.IsVanilla then
                f:SetUseTransmogSkin(true)
                f:SetUseTransmogChoices(true)
                f:SetObeyHideInTransmogFlag(true)
            end
            f:SetUnit("player")
            f:Undress()
            f:SetDoBlend(false)
            local info = { GetItemInfo(itemID) }
            if equipLoc == "INVTYPE_CLOAK" then
                f:SetRotation(f.curRotation + math.pi)
            elseif equipLoc == "INVTYPE_SHIELD" or equipLoc == "INVTYPE_HOLDABLE" or equipLoc == "INVTYPE_WEAPONOFFHAND" then
                f:SetRotation(f.curRotation + (math.pi * 1.5))
            else
                f:SetRotation(f.curRotation)
            end
            f:SetPortraitZoom(f.zoomLevelNew)
            f:TryOn(info[2])
        end
        if frame == 1 then
            bg:SetSize(430, 480)
            if BG.ButtonIsInRight(mainFrame.bg) then
                bg:SetPoint("TOPRIGHT", mainFrame.bg.tooltip2, "BOTTOMLEFT", 0, -1)
            else
                bg:SetPoint("TOPLEFT", mainFrame.bg.tooltip, "BOTTOMRIGHT", 0, -1)
            end
        elseif frame == 2 or frame == 3 then
            bg:SetSize(280, 330)
            if BG.ButtonIsInRight(last) then
                bg:SetPoint("BOTTOMRIGHT", last, "TOPLEFT", 0, 1)
            else
                bg:SetPoint("BOTTOMLEFT", last, "TOPRIGHT", 0, 1)
            end
        end
    end

    BG.RegisterEvent("MODIFIER_STATE_CHANGED", function(self, event, mod, type)
        if mod == "LCTRL" or mod == "RCTRL" then
            BG.DressUp()
        end
    end)
end

------------------------------------------------------------------------
------------------------------------------------------------------------

function BG.ItemLibUI()
    BiaoGe.ItemLibInvType = nil
    BiaoGe.ItemLib = BiaoGe.ItemLib or {}
    BiaoGe.ItemLib.ItemLibInvType = BiaoGe.ItemLib.ItemLibInvType or { "INVTYPE_HEAD" }
    BiaoGe.ItemLib.itemLibOrderButtonID = BiaoGe.ItemLib.itemLibOrderButtonID or 3
    BiaoGe.ItemLib.itemLibOrder = BiaoGe.ItemLib.itemLibOrder or 1
    BiaoGe.ItemLib.fitlerGet = BiaoGe.ItemLib.fitlerGet or {}
    BiaoGe.ItemLib.iLevel = BiaoGe.ItemLib.iLevel or {}

    mainFrame = BG.ItemLibMainFrame
    mainFrame.buttons = {}

    BG.itemLib_Hope_Buttons = {}
    BG.itemLib_Inv_Buttons = {}

    titleTbl = {
        { name = L["序号"], width = 35, color = "FFFFFF", JustifyH = "CENTER" },
        { name = L["等级"], width = 60, color = "FFFFFF", JustifyH = "CENTER" },
        { name = L["装备"], width = 180, color = "FFFFFF", JustifyH = "LEFT", type = "item" },
        { name = L["获取途径"], width = 250, color = "FFFFFF", JustifyH = "LEFT" },
    }
    WIDTH = 20
    for i, v in ipairs(titleTbl) do
        WIDTH = WIDTH + v.width
    end

    function BG.InvOnClick(self)
        BiaoGe.ItemLib.ItemLibInvType = self.key
        BG.UpdateItemLib()

        for i, bt in ipairs(BG.itemLib_Inv_Buttons) do
            if bt.inv == self.inv then
                bt:Disable()
            else
                bt:Enable()
            end
        end
        for i, bt in ipairs(BG.itemLib_Hope_Buttons) do
            if bt.inv == self.inv then
                bt:Disable()
            else
                bt:Enable()
            end
        end

        BG.PlaySound(1)
    end

    local function Next_OnClick(nextbutton)
        for i, v in ipairs(BG.invtypetable) do
            if BiaoGe.ItemLib.ItemLibInvType[1] == v.key[1] then
                if nextbutton._type == "next" then
                    if BG.invtypetable[i + 1] then
                        nextbutton.key = BG.invtypetable[i + 1].key
                        nextbutton.inv = BG.invtypetable[i + 1].name2
                    else
                        nextbutton.key = BG.invtypetable[1].key
                        nextbutton.inv = BG.invtypetable[1].name2
                    end
                elseif nextbutton._type == "prev" then
                    if BG.invtypetable[i - 1] then
                        nextbutton.key = BG.invtypetable[i - 1].key
                        nextbutton.inv = BG.invtypetable[i - 1].name2
                    else
                        nextbutton.key = BG.invtypetable[#BG.invtypetable].key
                        nextbutton.inv = BG.invtypetable[#BG.invtypetable].name2
                    end
                end
                break
            end
        end

        if not nextbutton.key then
            nextbutton.key = BG.invtypetable[1].key
            nextbutton.inv = BG.invtypetable[1].name2
        end

        BG.InvOnClick(nextbutton)
    end
    local function OnMouseWheel(self, delta)
        local nextbutton = {}
        if delta == 1 then
            nextbutton._type = "prev"
        else
            nextbutton._type = "next"
        end
        Next_OnClick(nextbutton)
    end

    -- UI
    do
        -- Frame
        do
            local f = CreateFrame("Frame", nil, mainFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 10,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.4)
            f:SetSize(WIDTH + 20, BUTTONHEIGHT * (MAXBUTTONS + 1) + 20)
            f:SetPoint("TOPLEFT", BG.MainFrame, 30, -80)
            mainFrame.bg = f
            local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
            scroll:SetPoint("TOPLEFT", 0, -35)
            scroll:SetPoint("BOTTOMRIGHT", -30, 5)
            scroll.ScrollBar.scrollStep = BUTTONHEIGHT * 4
            BG.CreateSrollBarBackdrop(scroll.ScrollBar)
            BG.HookScrollBarShowOrHide(scroll)
            mainFrame.scroll = scroll
            local child = CreateFrame("Frame", nil, scroll)
            child:SetSize(1, 1)
            mainFrame.child = child
            scroll:SetScrollChild(child)
            -- 鼠标提示定位
            local _f = CreateFrame("Frame", nil, f)
            _f:SetSize(1, 1)
            _f:SetPoint("TOPRIGHT", 0, 1)
            f.tooltip = _f
            local _f = CreateFrame("Frame", nil, f)
            _f:SetSize(1, 1)
            _f:SetPoint("TOPLEFT", 0, 1)
            f.tooltip2 = _f
            -- 排序按钮
            local sorter = f:CreateTexture(nil, "OVERLAY")
            sorter:SetSize(8, 8)
            sorter:SetTexture("Interface/Buttons/ui-sortarrow")
            mainFrame.sorter = sorter
            -- 头顶大标题
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("BOTTOM", mainFrame.bg, "TOP", 0, 0)
            mainFrame.toptitle = t
            -- 没有合适的装备
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOP", 0, -38)
            t:SetTextColor(.5, .5, .5)
            mainFrame.noItem = t
        end

        -- 标题
        local buttons = {}
        for i, v in ipairs(titleTbl) do
            local bt = CreateFrame("Button", nil, mainFrame.bg, "BackdropTemplate")
            bt:SetSize(titleTbl[i].width, BUTTONHEIGHT)
            if i == 1 then
                bt:SetPoint("TOPLEFT", 10, -10)
            else
                bt:SetPoint("LEFT", buttons[i - 1], "RIGHT", 0, 0)
            end
            bt:SetNormalFontObject(BG.FontWhite15)
            bt:SetText(titleTbl[i].name)
            bt.textwidth = bt:GetFontString():GetStringWidth()
            bt.textJustifyH = titleTbl[i].JustifyH
            bt.sortOrder = 1
            bt.id = i
            bt:SetHighlightTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
            bt:Disable()
            if i ~= 1 then
                bt:Enable()
            end
            mainFrame["title" .. i] = bt
            tinsert(buttons, bt)

            bt.text = bt:GetFontString()
            bt.text:SetTextColor(RGB(titleTbl[i].color))
            bt.text:SetJustifyH(titleTbl[i].JustifyH)
            bt.text:SetWidth(bt:GetWidth())
            bt.text:SetWordWrap(false)
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                mainFrame.isnewsorter = nil
                if BiaoGe.ItemLib.itemLibOrderButtonID ~= self.id then
                    mainFrame.isnewsorter = true
                end
                if not mainFrame.isnewsorter then
                    BiaoGe.ItemLib.itemLibOrder = BiaoGe.ItemLib.itemLibOrder == 1 and 0 or 1
                end
                BiaoGe.ItemLib.itemLibOrderButtonID = self.id
                StartUpdate()
            end)
        end
        CreateLine(mainFrame["title1"], 0, WIDTH - 20)

        -- 获取途径过滤
        do
            local parent = mainFrame["title4"]
            local bt = CreateFrame("Button", nil, parent) -- 下滚
            bt:SetSize(35, 25)
            bt:SetPoint("RIGHT", parent, "RIGHT", 5, 0)
            bt.normalTex = bt:CreateTexture()
            bt.normalTex:SetPoint("CENTER")
            bt.normalTex:SetSize(20, 20)
            bt.normalTex:SetTexture("interface/garrison/garrisonbuildingui")
            bt.normalTex:SetTexCoord(0.28, 0.33, 0.9, 1)
            bt:SetNormalTexture(bt.normalTex)
            bt.highlightTex = bt:CreateTexture()
            bt.highlightTex:SetPoint("CENTER")
            bt.highlightTex:SetSize(20, 20)
            bt.highlightTex:SetTexture("interface/garrison/garrisonbuildingui")
            bt.highlightTex:SetTexCoord(0.28, 0.33, 0.9, 1)
            bt:SetHighlightTexture(bt.highlightTex)
            mainFrame.fitlerGetButton = bt
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["获取途径显示"], 1, 1, 1, true)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)

            local tbl
            if BG.IsVanilla_Sod then
                tbl = {
                    { name = L["团本"], name2 = "raid", },
                    { name = L["牌子/货币"], name2 = "currency", },
                    { name = L["5人本"], name2 = "fb5", },
                    { name = L["声望"], name2 = "faction", },
                    { name = L["专业"], name2 = "profession", },
                    { name = L["世界掉落"], name2 = "world", },
                    { name = L["PVP"], name2 = "pvp", },
                }
            elseif BG.IsVanilla_60 then
                tbl = {
                    { name = L["团本"], name2 = "raid", },
                    { name = L["声望"], name2 = "faction", },
                    { name = L["专业"], name2 = "profession", },
                    { name = L["世界掉落"], name2 = "world", },
                    { name = L["世界BOSS"], name2 = "worldboss", },
                    { name = L["PVP"], name2 = "pvp", },
                }
            elseif BG.IsWLK then
                tbl = {
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
            elseif BG.IsCTM or BG.IsMOP then
                tbl = {
                    { name = L["团本：英雄难度"], name2 = "raidhero", },
                    { name = L["团本：普通难度"], name2 = "raidnormal", },
                    { name = L["5人本"], name2 = "fb5", },
                    { name = L["牌子/货币"], name2 = "currency", },
                    { name = L["声望"], name2 = "faction", },
                    { name = L["专业"], name2 = "profession", },
                    { name = L["世界掉落"], name2 = "world", },
                }
            elseif BG.IsRetail then
                tbl = {
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

            local function UpdateTex()
                local hasFitlerGet
                for kk, vv in pairs(tbl) do
                    for k, v in pairs(BiaoGe.ItemLib.fitlerGet) do
                        if vv.name2 == k then
                            hasFitlerGet = true
                            break
                        end
                    end
                    if hasFitlerGet then break end
                end
                if hasFitlerGet then
                    bt.normalTex:SetVertexColor(0, 1, 0)
                    bt.highlightTex:SetVertexColor(0, 1, 0)
                else
                    bt.normalTex:SetVertexColor(1, 1, 1)
                    bt.highlightTex:SetVertexColor(1, 1, 1)
                end
            end
            UpdateTex()

            local f = CreateFrame("Frame", nil, bt, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 10,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:SetSize(180, #tbl * 25 + 40)
            f:SetPoint("TOPLEFT", mainFrame.bg, "TOPRIGHT", 0, 1)
            f:EnableMouse(true)
            f:SetFrameLevel(110)
            f:Hide()

            mainFrame.fitlerGetButton:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                if f:IsVisible() then
                    f:Hide()
                else
                    f:Show()
                end
            end)

            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOP", f, "TOP", 0, -10)
            t:SetTextColor(RGB("FFD100"))
            t:SetText(L["获取途径显示"])
            t:SetJustifyH("CENTER")

            f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
            f.CloseButton:SetPoint("TOPRIGHT", f, "TOPRIGHT", BG.CloseButtonOffset, BG.CloseButtonOffset)

            local buttons = {}
            for i, v in ipairs(tbl) do
                local bt = CreateFrame("CheckButton", nil, f, "ChatConfigCheckButtonTemplate")
                bt:SetSize(25, 25)
                if i == 1 then
                    bt:SetPoint("TOPLEFT", f, 10, -30)
                else
                    bt:SetPoint("TOPLEFT", buttons[i - 1], "BOTTOMLEFT", 0, -0)
                end
                bt.name = v.name
                bt.name2 = v.name2
                bt.Text:SetText(v.name)
                bt:SetHitRectInsets(0, -bt.Text:GetWidth(), 0, 0)
                bt.Text:SetWidth(150)
                bt.Text:SetWordWrap(false)

                tinsert(buttons, bt)
                if BiaoGe.ItemLib.fitlerGet[bt.name2] then
                    bt:SetChecked(false)
                else
                    bt:SetChecked(true)
                end
                bt:SetScript("OnClick", function(self)
                    BG.PlaySound(1)
                    if self:GetChecked() then
                        BiaoGe.ItemLib.fitlerGet[self.name2] = nil
                    else
                        BiaoGe.ItemLib.fitlerGet[self.name2] = true
                    end
                    UpdateTex()
                    BG.UpdateItemLib()
                end)
            end
        end
    end

    -- 装备部位
    do
        BG.invtypetable = {
            { name = INVTYPE_HEAD, name2 = "INVTYPE_HEAD", key = { "INVTYPE_HEAD" } },                                                                 -- 头
            { name = INVTYPE_NECK, name2 = "INVTYPE_NECK", key = { "INVTYPE_NECK" } },                                                                 -- 项链
            { name = INVTYPE_SHOULDER, name2 = "INVTYPE_SHOULDER", key = { "INVTYPE_SHOULDER" } },                                                     -- 肩膀
            { name = INVTYPE_CLOAK, name2 = "INVTYPE_CLOAK", key = { "INVTYPE_CLOAK" } },                                                              -- 背
            { name = INVTYPE_CHEST, name2 = "INVTYPE_CHEST", key = { "INVTYPE_CHEST", "INVTYPE_ROBE" } },                                              -- 胸
            { name = INVTYPE_WRIST, name2 = "INVTYPE_WRIST", key = { "INVTYPE_WRIST" } },                                                              -- 手腕
            { name = INVTYPE_HAND, name2 = "INVTYPE_HAND", key = { "INVTYPE_HAND" } },                                                                 -- 手
            { name = INVTYPE_WAIST, name2 = "INVTYPE_WAIST", key = { "INVTYPE_WAIST" } },                                                              -- 腰带
            { name = INVTYPE_LEGS, name2 = "INVTYPE_LEGS", key = { "INVTYPE_LEGS" } },                                                                 -- 腿
            { name = INVTYPE_FEET, name2 = "INVTYPE_FEET", key = { "INVTYPE_FEET" } },                                                                 -- 脚
            { name = INVTYPE_FINGER, name2 = "INVTYPE_FINGER", key = { "INVTYPE_FINGER" } },                                                           -- 戒指
            { name = INVTYPE_TRINKET, name2 = "INVTYPE_TRINKET", key = { "INVTYPE_TRINKET" } },                                                        -- 饰品
            { name = TWO_HANDED, name2 = "TWO_HANDED", key = { "INVTYPE_2HWEAPON" } },                                                                 -- 双手
            { name = INVTYPE_WEAPON, name2 = "INVTYPE_WEAPON", key = { "INVTYPE_WEAPON", "INVTYPE_WEAPONMAINHAND" } },                                 -- 单手
            { name = INVTYPE_SHIELD, name2 = "INVTYPE_SHIELD", key = { "INVTYPE_SHIELD", "INVTYPE_HOLDABLE", "INVTYPE_WEAPONOFFHAND" } },              -- 副手
            { name = INVTYPE_RANGED, name2 = "INVTYPE_RANGED", key = { "INVTYPE_RANGED", "INVTYPE_RANGEDRIGHT", "INVTYPE_THROWN", "INVTYPE_RELIC" } }, -- 远程
            -- { name = INVTYPE_RANGED, name2 = "INVTYPE_RANGED", key = { "INVTYPE_RANGED", "INVTYPE_RANGEDRIGHT", "INVTYPE_THROWN" } },     -- 远程
            -- { name = INVTYPE_RELIC, name2 = "INVTYPE_RELIC", key = { "INVTYPE_RELIC" } },                                                 -- 圣物
        }

        local f = CreateFrame("Frame", nil, mainFrame.bg, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 10,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetSize(WIDTH + 20, 0)
        f:SetPoint("TOPLEFT", f:GetParent(), "BOTTOMLEFT", 0, -10)
        mainFrame.invtypeFrame = f
        f:SetScript("OnMouseWheel", OnMouseWheel)

        local l = 6
        for i, v in ipairs(BG.invtypetable) do
            local bt = CreateFrame("Button", nil, f)
            bt:SetSize(80, BUTTONHEIGHT)
            bt:SetNormalFontObject(BG.FontGreen15)
            bt:SetDisabledFontObject(BG.FontWhite18)
            bt:SetHighlightFontObject(BG.FontWhite15)
            if i == 1 then
                bt:SetPoint("TOPLEFT", 10, -10)
                f:SetHeight(BUTTONHEIGHT + 20)
            elseif (i - 1) % l == 0 then
                bt:SetPoint("TOPLEFT", BG.itemLib_Inv_Buttons[i - l], "BOTTOMLEFT", 0, 0)
                f:SetHeight(BUTTONHEIGHT * ((i - 1) / l + 1) + 20)
            else
                bt:SetPoint("LEFT", BG.itemLib_Inv_Buttons[i - 1], "RIGHT", 0, 0)
            end
            bt:SetText(v.name)
            BG.ButtonTextSetWordWrap(bt)
            bt.inv = v.name2
            bt.key = v.key
            tinsert(BG.itemLib_Inv_Buttons, bt)
            if v.key[1] == BiaoGe.ItemLib.ItemLibInvType[1] then
                bt:Disable()
            end

            local tex = bt:CreateTexture(nil, "ARTWORK") -- 高亮材质
            tex:ClearAllPoints()
            tex:SetSize(bt:GetFontString():GetWrappedWidth() + 20, 20)
            tex:SetPoint("CENTER")
            tex:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight")
            bt:SetHighlightTexture(tex)

            bt:SetScript("OnClick", BG.InvOnClick)
        end

        local bt = CreateFrame("Button", nil, f)
        bt:SetSize(BUTTONHEIGHT + 5, BUTTONHEIGHT)
        bt:SetNormalTexture("interface/buttons/ui-spellbookicon-nextpage-up")
        bt:SetPushedTexture("interface/buttons/ui-spellbookicon-nextpage-down")
        bt:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
        bt:SetPoint("BOTTOMRIGHT", -20, 5)
        bt._type = "next"
        local nextbt = bt
        bt:SetScript("OnClick", Next_OnClick)

        local bt = CreateFrame("Button", nil, f)
        bt:SetSize(nextbt:GetWidth(), BUTTONHEIGHT)
        bt:SetNormalTexture("interface/buttons/ui-spellbookicon-prevpage-up")
        bt:SetPushedTexture("interface/buttons/ui-spellbookicon-prevpage-down")
        bt:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
        bt:SetPoint("RIGHT", nextbt, "LEFT", 0, 0)
        bt._type = "prev"
        bt:SetScript("OnClick", Next_OnClick)
    end

    -- 装等过滤
    do
        local t = mainFrame:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("TOPLEFT", BG.ItemLibMainFrame.invtypeFrame, "BOTTOMLEFT", 10, -10)
        t:SetTextColor(1, 0.82, 0)
        t:SetText(L["仅显示高于该装等的装备："])
        t:SetJustifyH("LEFT")
        BG.ItemLibMainFrame.iLevelText = t

        local edit = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
        edit:SetSize(100, 20)
        edit:SetPoint("LEFT", t, "RIGHT", 10, 0)
        edit:SetAutoFocus(false)
        edit:SetNumeric(true)
        edit:SetText(BiaoGe.ItemLib.iLevel[BG.FB1] or "")
        BG.ItemLibMainFrame.iLevelEdit = edit
        BG.SetEditBaseClass(edit)
        edit:HookScript("OnTextChanged", function(self)
            if self:HasFocus() then
                local FB = BG.FB1
                BiaoGe.ItemLib.iLevel[FB] = tonumber(self:GetText())
                BG.UpdateItemLib()
            end
        end)
        edit:SetScript("OnMouseDown", function(self, button)
            if button == "RightButton" then
                self:SetEnabled(false)
                self:SetText("")
                local FB = BG.FB1
                BiaoGe.ItemLib.iLevel[FB] = nil
                BG.UpdateItemLib()
            end
        end)
    end

    -- 过滤方案
    do
        local t = mainFrame:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("TOPLEFT", BG.ItemLibMainFrame.iLevelText, "BOTTOMLEFT", 0, -25)
        t:SetText(L["过滤方案："])
        t:SetTextColor(1, 0.82, 0)
        BG.ItemLibMainFrame.filtleText = t
    end

    -- 心愿汇总
    do
        local w = 120
        local w_jiange = 5
        local h_jiange = 1
        local width = 80 + (w + w_jiange) * 4 + 25

        local f = CreateFrame("Frame", nil, mainFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 10,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetSize(width, mainFrame.bg:GetHeight())
        f:SetPoint("TOPLEFT", mainFrame.bg, "TOPRIGHT", 30, 0)
        mainFrame.Hope = f

        -- 头顶大标题
        local t = f:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("BOTTOM", mainFrame.Hope, "TOP", 0, 0)
        t:SetText(L["心愿汇总"])
        t:SetTextColor(RGB(BG.b1))
        -- 底下提示文字
        local t = f:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
        t:SetPoint("TOP", mainFrame.Hope, "BOTTOM", 0, 0)
        t:SetText(AddTexture("RIGHT") .. L["（删除心愿装备）"])

        local title_table = {
            { name = "", width = 80, color = "FFFFFF", JustifyH = "CENTER" },
            { name = L["心愿"] .. 1, width = w, color = "FFFFFF", JustifyH = "LEFT" },
            { name = L["心愿"] .. 2, width = w, color = "FFFFFF", JustifyH = "LEFT" },
            { name = L["心愿"] .. 3, width = w, color = "FFFFFF", JustifyH = "LEFT" },
            { name = L["心愿"] .. 4, width = w, color = "FFFFFF", JustifyH = "LEFT" },
        }
        maxhope = #title_table - 1
        -- 标题
        local right
        for i, v in ipairs(title_table) do
            local f = CreateFrame("Frame", nil, f)
            f:SetSize(title_table[i].width, BUTTONHEIGHT)
            if i == 1 then
                f:SetPoint("TOPLEFT", 10, -10)
            elseif i == 2 then
                f:SetPoint("LEFT", right, "RIGHT", w_jiange, 0)
            else
                f:SetPoint("LEFT", right, "RIGHT", w_jiange, 0)
            end
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("CENTER")
            t:SetText(title_table[i].name)
            t:SetTextColor(RGB(title_table[i].color))
            t:SetJustifyH(title_table[i].JustifyH)
            t:SetWidth(f:GetWidth())
            t:SetWordWrap(false)
            right = f
            mainFrame["Hopetitle" .. i] = f
        end
        -- CreateLine(mainFrame["Hopetitle1"], 0, width - 25)

        local right
        for i, v in ipairs(BG.invtypetable) do
            for ii, vv in ipairs(title_table) do
                if ii == 1 then
                    local bt = CreateFrame("Button", nil, f)
                    bt:SetSize(title_table[ii].width, BUTTONHEIGHT + 4)
                    -- bt:SetSize(title_table[ii].width, buttonheight)
                    bt:SetNormalFontObject(BG.FontGold15)
                    bt:SetDisabledFontObject(BG.FontWhite15)
                    bt:SetHighlightFontObject(BG.FontWhite15)
                    if i == 1 then
                        bt:SetPoint("TOPLEFT", 10, -32)
                    else
                        bt:SetPoint("TOP", BG.itemLib_Hope_Buttons[i - 1], "BOTTOM", 0, -h_jiange)
                    end
                    bt:SetText(v.name)
                    bt.text = bt:GetFontString()
                    bt.text:SetWidth(bt:GetWidth())
                    bt.text:SetJustifyH(title_table[ii].JustifyH)
                    bt.text:SetWordWrap(false)
                    bt.inv = v.name2
                    bt.key = v.key
                    BG.itemLib_Hope_Buttons[i] = bt
                    right = bt
                    if v.key[1] == BiaoGe.ItemLib.ItemLibInvType then
                        bt:Disable()
                    end

                    local tex = bt:CreateTexture(nil, "ARTWORK") -- 高亮材质
                    tex:ClearAllPoints()
                    tex:SetSize(bt:GetFontString():GetWrappedWidth() + 20, 20)
                    tex:SetPoint("CENTER")
                    tex:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight")
                    bt:SetHighlightTexture(tex)

                    local _time
                    bt:SetScript("OnClick", BG.InvOnClick)
                    bt:SetScript("OnMouseWheel", OnMouseWheel)
                else
                    local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
                    edit:SetSize(title_table[ii].width, BUTTONHEIGHT)
                    edit:SetPoint("LEFT", right, "RIGHT", w_jiange, 0)
                    edit:SetAutoFocus(false)
                    edit:Disable()
                    edit.EquipLoc = v.name2
                    right = edit
                    mainFrame.Hope[v.name2 .. (ii - 1)] = edit
                    -- 已掉落文字
                    BG.LootedText(edit)

                    -- 是否已拥有
                    edit.haved = edit:CreateTexture(nil, "OVERLAY")
                    edit.haved:SetSize(25, 25)
                    edit.haved:SetPoint("LEFT", edit, "LEFT", -5, 0)
                    edit.haved:SetTexture("interface/raidframe/readycheck-ready")
                    edit.haved:Hide()

                    -- 悬停底色
                    edit.ds = edit:CreateTexture()
                    edit.ds:SetPoint("TOPLEFT", -4, -2)
                    edit.ds:SetPoint("BOTTOMRIGHT", -1, 0)
                    edit.ds:SetColorTexture(1, 1, 1, BG.onEnterAlpha)
                    edit.ds:Hide()

                    edit:SetScript("OnTextChanged", function(self)
                        local text = self:GetText()
                        local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID, bindType = GetItemInfo(text)

                        local num = BiaoGe.FilterClassItemDB[RealmID][player].chooseID -- 隐藏
                        if num ~= 0 then
                            BG.UpdateFilter(self)
                        end

                        -- 已拥有
                        BG.Update_IsHaved(self)
                        -- 装绑图标
                        BG.BindOnEquip(self, bindType)
                        -- 在按钮右边增加装等显示
                        BG.LevelText(self, level, typeID)
                        -- 更新已掉落
                        BG.Update_IsLooted(self)
                    end)
                    edit:SetScript("OnMouseDown", function(self, enter)
                        if enter == "RightButton" then
                            local itemID = GetItemInfoInstant(self:GetText())
                            if itemID then
                                BG.UpdateHopeFrame_Hope(itemID, 0)
                                BG.UpdateItemLib_LeftHope(itemID, 0)
                            end
                            self:SetText("")
                        elseif IsShiftKeyDown() then
                            local itemID = GetItemInfoInstant(self:GetText())
                            if itemID then
                                local _, link = GetItemInfo(itemID)
                                BG.InsertLink(link)
                            end
                        elseif IsControlKeyDown() then
                            local itemID = GetItemInfoInstant(self:GetText())
                            if itemID then
                                local _, link = GetItemInfo(itemID)
                                DressUpItemLink(link)
                            end
                        end
                    end)
                    edit:SetScript("OnEnter", function(self)
                        local link = self:GetText()
                        local itemID = GetItemInfoInstant(link)
                        if itemID then
                            if BG.ButtonIsInRight(self) then
                                GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
                            else
                                GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                            end
                            GameTooltip:ClearLines()
                            GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))

                            BG.DressUpLastButton = self
                            if IsControlKeyDown() then
                                SetCursor("Interface/Cursor/Inspect")
                                BG.DressUp()
                            end
                            BG.canShowTrunToItemLibCursor = true
                        end
                        self.ds:Show()
                    end)
                    edit:SetScript("OnLeave", function(self)
                        GameTooltip:Hide()
                        self.ds:Hide()
                        SetCursor(nil)
                        BG.canShowTrunToItemLibCursor = false
                        if BG.DressUpFrame then
                            BG.DressUpFrame:Hide()
                        end
                        BG.DressUpLastButton = nil
                    end)
                end
            end
        end
    end
end

BG.Init2(function()
    mainFrame.first = true
    mainFrame:HookScript("OnShow", function(self)
        if BG.lastItemLibFB ~= BG.FB1 or BG.itemLibNeedUpdate then
            BG.After(mainFrame.first and 0.2 or 0, function()
                BG.UpdateItemLib()
            end)
        end
        BG.UpdateItemLib_LeftHope_All()
        BG.UpdateItemLib_LeftLib_IsHaved_All()
        BG.UpdateItemLib_LeftLib_IsLooted_All()
        BG.UpdateItemLib_RightHope_All()
        BG.lastItemLibFB = BG.FB1
        mainFrame.first = nil
    end)
end)
