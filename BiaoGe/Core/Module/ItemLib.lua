local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi
local FrameHide = ADDONSELF.FrameHide
local AddTexture = ADDONSELF.AddTexture
local GetItemID = ADDONSELF.GetItemID

local pt = print
local RealmId = GetRealmID()
local player = UnitName("player")
local _, class = UnitClass("player")
local FB = BG.FB1

local MAXBUTTONS = 20
local BUTTONHEIGHT = 22

local isCache = {}

local title_table = {
    { name = L["序号"], width = 35, color = "FFFFFF", JustifyH = "CENTER" },
    { name = L["等级"], width = 60, color = "FFFFFF", JustifyH = "CENTER" },
    { name = L["装备"], width = 180, color = "FFFFFF", JustifyH = "LEFT", type = "item" },
    { name = L["获取途径"], width = 200, color = "FFFFFF", JustifyH = "LEFT" },
}
local width = 20
for i, v in ipairs(title_table) do
    width = width + v.width
end
BG.ItemLibFramewidth = width
local maxhope

-- 给获取途径排序
local typeIDtbl = {
    "raid",
    "fb5",
    "quest",
    "currency",
    "faction",
    "profession",
    "sod_currency",
    "world",
    "worldboss",
    "pvp",
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
    local tbl = {
        N10 = 1,
        N25 = 2,
        H10 = 3,
        H25 = 4,
        N = 1,
        H = 2,
    }
    return tbl[hard]
end
local function CheckHaved(itemID) -- 是否已经拥有该装备
    if BG.GetItemCount(itemID) ~= 0 then return true end
end
local function AddPrice(itemID) -- 添加装备拍卖行价格
    local m
    if BG.IsVanilla() then
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
                    local _, exItemLink = GetItemInfo(exItemID)
                    return exItemID, exItemLink
                end
            end
        end
    end
end
local function CreateLoadingText()
    local t = BG.ItemLibMainFrame.bg1:CreateFontString()
    t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
    t:SetPoint("TOP", BG.ItemLibMainFrame.bg1, 0, -40)
    t:SetText(L["读取中..."])
    return t
end
local updateCDing
local function FilterItem(FB, itemID, EquipLocs, type, hard, ii, otherID) -- 重点
    local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID, bindType = GetItemInfo(itemID)
    if not link then
        -- pt(GetTime(), itemID, link)
        if BG.itemLibItemOldTbl then
            wipe(BG.itemLibItemOldTbl)
        end
        if not updateCDing then
            updateCDing = true
            local t = CreateLoadingText()
            BG.After(0.5, function()
                t:Hide()
                updateCDing = false
                BG.UpdateAllItemLib()
            end)
        end
        return
    elseif updateCDing then
        if BG.itemLibItemOldTbl then
            wipe(BG.itemLibItemOldTbl)
        end
    end
    local yes
    for k, v in pairs(EquipLocs) do
        if EquipLoc == v then
            yes = true
            break
        end
    end
    if not (yes and (typeID == 2 or typeID == 4)) then return end
    if BG.FilterAll(itemID, typeID, EquipLoc, subclassID) then return end
    if type == "raid" then -- 团本掉落
        local color = "|cff" .. "00BFFF"
        if strfind(hard, "10") then
            color = "|cff" .. "99CCFF"
        end
        if BG.IsCTM() then
            if hard == "N" then
                color = "|cff" .. "99CCFF"
            end
        end

        local get
        local bossname

        if otherID and otherID ~= "other" then
            bossname = otherID
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

        if BG.IsVanilla() then
            get = color .. BG.GetFBinfo(FB, "localName") .. " " .. bossname .. exText .. AddPrice(itemID)
        else
            get = color .. FB .. " " .. hard .. " " .. bossname .. exText .. AddPrice(itemID)
        end

        -- 团本正常掉落/兑换物（比如套装）
        local isRaid = true
        if otherID and exItemLink == "" then
            isRaid = false
        end

        local players
        if BG.IsVanilla() then
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

        local a = {
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
        }
        return a
    elseif type == "quest" then -- 任务
        local FBname = otherID.FBname
        local color = otherID.color
        local players = otherID.players
        local classID = otherID.classID
        local faction = otherID.faction
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
            get = "|cff" .. color .. FBname .. "|c" .. colorStr .. className .. BG.STC_y1(QUESTS_LABEL) .. RR .. exText .. AddPrice(itemID)
        else
            get = "|cff" .. color .. FBname .. BG.STC_y1(faction .. QUESTS_LABEL) .. RR .. exText .. AddPrice(itemID)
        end

        local a = {
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
        }
        return a
    elseif type == "currency" then -- 牌子
        local v = otherID
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
        local color = "FFFFFF"
        if count and quantity < count then
            color = "FF0000"
        else
            count = ""
        end
        local get = BG.STC_y1(AddTexture(tex) .. name .. " " .. "|cff" .. color .. count .. RR) .. AddPrice(itemID) .. otherText .. phaseText

        local a = {
            itemID = itemID,
            link = link,
            level = level,
            quality = quality,
            texture = Texture,
            get = get,
            bindType = bindType,
            type = GetTypeID(type),
            haved = CheckHaved(itemID)
        }
        return a
    elseif type == "faction" then -- 声望
        local tbl = {
            FACTION_STANDING_LABEL4,
            FACTION_STANDING_LABEL5,
            FACTION_STANDING_LABEL6,
            FACTION_STANDING_LABEL7,
            FACTION_STANDING_LABEL8,
        }
        local faction, standingID = strsplit(":", otherID)
        local standing = ""
        if standingID then
            standing = "-" .. tbl[tonumber(standingID)]
        end
        local factionName = GetFactionInfoByID(faction) or ""

        local name = REPUTATION .. ": " .. factionName .. standing
        local get = BG.STC_g2(name) .. AddPrice(itemID)

        local a = {
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
        }
        return a
    elseif type == "profession" then -- 专业制造
        local icon = ""
        if otherID == "锻造" then
            icon = AddTexture(136241, nil, ":100:100:8:92:8:92")
        elseif otherID == "制皮" then
            icon = AddTexture(133611, nil, ":100:100:8:92:8:92")
        elseif otherID == "裁缝" then
            icon = AddTexture(136249, nil, ":100:100:8:92:8:92")
        elseif otherID == "工程" then
            icon = AddTexture(136243, nil, ":100:100:8:92:8:92")
        elseif otherID == "附魔" then
            icon = AddTexture(136244, nil, ":100:100:8:92:8:92")
        elseif otherID == "珠宝加工" then
            icon = AddTexture(134071, nil, ":100:100:8:92:8:92")
        elseif otherID == "铭文" then
            icon = AddTexture(237171, nil, ":100:100:8:92:8:92")
        elseif otherID == "考古" then
            icon = AddTexture(441139, nil, ":100:100:8:92:8:92")
        end
        local name = TRADE_SKILLS .. ": " .. L[otherID] .. icon
        local get = BG.STC_y2(name) .. AddPrice(itemID)

        local a = {
            itemID = itemID,
            link = link,
            level = level,
            quality = quality,
            texture = Texture,
            get = get,
            bindType = bindType,
            type = GetTypeID(type),
            type2 = otherID,
            haved = CheckHaved(itemID)
        }
        return a
    elseif type == "fb5" then -- 5人本
        local FB_5, BossName = strsplit(":", otherID)
        local get = "|cff" .. "9999FF" .. FB_5 .. " " .. BossName .. RR .. AddPrice(itemID)

        local a = {
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
        }
        return a
    elseif type == "world" then -- 世界掉落
        local get = "|cff" .. "DEB887" .. L["世界掉落"] .. RR .. AddPrice(itemID)

        local a = {
            itemID = itemID,
            link = link,
            level = level,
            quality = quality,
            texture = Texture,
            get = get,
            bindType = bindType,
            type = GetTypeID(type),
            haved = CheckHaved(itemID)
        }
        return a
    elseif type == "worldboss" then -- 世界BOSS
        local name = L["世界BOSS"] .. ": " .. L[otherID]
        local get = "|cff" .. "FF6347" .. name .. RR .. AddPrice(itemID)

        local a = {
            itemID = itemID,
            link = link,
            level = level,
            quality = quality,
            texture = Texture,
            get = get,
            bindType = bindType,
            type = GetTypeID(type),
            haved = CheckHaved(itemID)
        }
        return a
    elseif type == "pvp" then -- PVP
        local faction, levelID = strsplit(":", otherID)
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

        local a = {
            itemID = itemID,
            link = link,
            level = level,
            quality = quality,
            texture = Texture,
            get = get,
            bindType = bindType,
            type = GetTypeID(type),
            haved = CheckHaved(itemID)
        }
        return a
    elseif type == "sod_currency" then -- 赛季服货币/牌子
        local get, count, icon, color, _type = strsplit("-", otherID)
        if not count then
            count = ""
        elseif _type and _type ~= "" then
            count = select(2, GetItemInfo(count)) or ""
        end
        if not color then color = "FFFFFF" end
        local get = "|cff" .. color .. get .. RR .. " " .. count .. AddTexture(icon) .. RR .. AddPrice(itemID)
        local a = {
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
        }
        return a
    end
    -- 团本 任务 套装 牌子 声望 专业 5人 世界掉落 世界boss PVP 赛季服货币/牌子
end
local function Mode(FB, count1, tbl, EquipLocs, itemID, type, hard, ii, k)
    if EquipLocs then
        local a = FilterItem(FB, itemID, EquipLocs, type, hard, ii, k)
        if a then
            tinsert(tbl, a)
        end
    else
        count1 = count1 + 1
        if not isCache[itemID] then
            isCache[itemID] = true
            local item = Item:CreateFromItemID(itemID)
            item:ContinueOnItemLoad(function()
                local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID, bindType = GetItemInfo(itemID)
                -- pt(FB, count1, itemID, level)
                GetItemInfo(itemID)
                BG.Tooltip_SetItemByID(itemID) -- 提前设置一次物品鼠标提示信息，避免绿字属性获取不了
            end)
        end
    end
    return count1, tbl
end
local function CheckItemCache(EquipLocs, checkFB) -- 不传入参数时是检查所有物品是否缓存了，传入参数时是返回符合要求的物品table
    local onlyCheckCache
    if not EquipLocs then
        onlyCheckCache = true
    end
    local tbl = {}
    local count1 = 0
    local hard, ii, k
    local checkFB = checkFB or BG.FB1
    BG.itemLibItemOldTbl = tbl
    for _, FB in pairs(BG.phaseFBtable[checkFB]) do
        -- 团本
        for _, hard in ipairs(BG.difficultyTable[checkFB]) do
            local trueRaidDifficulty = true
            if not onlyCheckCache then
                if BG.IsVanilla() then
                    if BiaoGe.ItemLib.fitlerGet.raid then
                        trueRaidDifficulty = false
                    end
                elseif BG.IsWLK() or BG.IsCTM() then
                    if BiaoGe.ItemLib.fitlerGet.raidhero and strfind(hard, "H") then
                        trueRaidDifficulty = false
                    end
                    if BiaoGe.ItemLib.fitlerGet.raidnormal and strfind(hard, "N") then
                        trueRaidDifficulty = false
                    end
                    if BiaoGe.ItemLib.fitlerGet.raid25 and strfind(hard, "25") then
                        trueRaidDifficulty = false
                    end
                    if BiaoGe.ItemLib.fitlerGet.raid10 and strfind(hard, "10") then
                        trueRaidDifficulty = false
                    end
                end
            end

            if onlyCheckCache or trueRaidDifficulty then
                -- pt(hard)
                if BG.Loot[FB][hard] then
                    local ii = 1
                    while BG.Loot[FB][hard]["boss" .. ii] do
                        for i, itemID in ipairs(BG.Loot[FB][hard]["boss" .. ii]) do
                            count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "raid", hard, ii, k)
                        end
                        -- BOSS掉落后兑换的装备
                        if BG.Loot[FB][hard]["boss" .. ii .. "other"] then
                            for i, itemID in ipairs(BG.Loot[FB][hard]["boss" .. ii .. "other"]) do
                                count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "raid", hard, ii, "other")
                            end
                        end
                        ii = ii + 1
                    end
                    -- 团本任务奖励
                    local ii = 1
                    if BG.Loot[FB][hard].Quest then
                        for name, _ in pairs(BG.Loot[FB][hard].Quest) do
                            for _, itemID in pairs(BG.Loot[FB][hard].Quest[name]) do
                                count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "raid", hard, ii, name)
                            end
                        end
                    end
                end
            end
        end
        -- 5人本
        if onlyCheckCache or not BiaoGe.ItemLib.fitlerGet.fb5 then
            for FB_5 in pairs(BG.Loot[FB].Team) do
                for BossName, _ in pairs(BG.Loot[FB].Team[FB_5]) do
                    for _, itemID in pairs(BG.Loot[FB].Team[FB_5][BossName]) do
                        count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "fb5", hard, ii, FB_5 .. ":" .. BossName)
                    end
                end
            end
        end
        -- 任务
        for k, v in pairs(BG.Loot[FB].Quest) do
            for i, itemID in ipairs(BG.Loot[FB].Quest[k].itemID) do
                count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "quest", hard, ii, v)
            end
        end
        -- 牌子装备
        if onlyCheckCache or not BiaoGe.ItemLib.fitlerGet.currency then
            for itemID, v in pairs(BG.Loot[FB].Currency) do
                count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "currency", hard, ii, v)
            end
        end
        -- 赛季服货币/牌子
        if onlyCheckCache or not BiaoGe.ItemLib.fitlerGet.currency then
            for i, v in pairs(BG.Loot[FB].Sod_Currency) do
                for itemID, currency in pairs(BG.Loot[FB].Sod_Currency[i]) do
                    count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "sod_currency", hard, ii, currency)
                end
            end
        end
        -- 声望装备
        if onlyCheckCache or not BiaoGe.ItemLib.fitlerGet.faction then
            for k, v in pairs(BG.Loot[FB].Faction) do
                for i, itemID in ipairs(BG.Loot[FB].Faction[k]) do
                    count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "faction", hard, ii, k)
                end
            end
        end
        -- 专业制造
        if onlyCheckCache or not BiaoGe.ItemLib.fitlerGet.profession then
            for k, v in pairs(BG.Loot[FB].Profession) do
                for i, itemID in ipairs(BG.Loot[FB].Profession[k]) do
                    count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "profession", hard, ii, k)
                end
            end
        end
        -- 世界掉落
        if onlyCheckCache or not BiaoGe.ItemLib.fitlerGet.world then
            for i, itemID in ipairs(BG.Loot[FB].World) do
                count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "world", hard, ii, k)
            end
        end
        -- 世界BOSS
        if onlyCheckCache or not BiaoGe.ItemLib.fitlerGet.worldboss then
            for k, v in pairs(BG.Loot[FB].WorldBoss) do
                for i, itemID in ipairs(BG.Loot[FB].WorldBoss[k]) do
                    count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "worldboss", hard, ii, k)
                end
            end
        end
        -- PVP
        if onlyCheckCache or not BiaoGe.ItemLib.fitlerGet.pvp then
            for k, v in pairs(BG.Loot[FB].Pvp) do
                for i, itemID in ipairs(BG.Loot[FB].Pvp[k]) do
                    count1, tbl = Mode(FB, count1, tbl, EquipLocs, itemID, "pvp", hard, ii, k)
                end
            end
        end
    end

    return tbl
end
local function SortItemLibTable(tbl, isnewsorter)        -- 排序
    sort(tbl, function(a, b)
        if BiaoGe.ItemLib.itemLibOrderButtonId == 2 then -- 按装等排序
            -- 装备等级
            local key = "level"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    if BiaoGe.ItemLib.itemLibOrder == 1 then
                        return a[key] > b[key]
                    else
                        return b[key] > a[key]
                    end
                end
            end
            -- 装备品质
            local key = "quality"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    if BiaoGe.ItemLib.itemLibOrder == 1 then
                        return a[key] > b[key]
                    else
                        return b[key] > a[key]
                    end
                end
            end
            -- 来源类型
            local key = "type"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    return a[key] < b[key]
                end
            end
            -- 来源类型2
            local key = "type2"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    if BiaoGe.ItemLib.itemLibOrder == 1 then
                        return a[key] < b[key]
                    else
                        return b[key] < a[key]
                    end
                end
            end
            -- 副本玩家最大数量
            local key = "players"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    return a[key] > b[key]
                end
            end
        elseif BiaoGe.ItemLib.itemLibOrderButtonId == 3 then -- 按装备品质排序
            -- 装备品质
            local key = "quality"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    if BiaoGe.ItemLib.itemLibOrder == 1 then
                        return a[key] > b[key]
                    else
                        return b[key] > a[key]
                    end
                end
            end
            -- 装备等级
            local key = "level"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    if BiaoGe.ItemLib.itemLibOrder == 1 then
                        return a[key] > b[key]
                    else
                        return b[key] > a[key]
                    end
                end
            end
            -- 来源类型
            local key = "type"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    return a[key] < b[key]
                end
            end
            -- 来源类型2
            local key = "type2"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    if BiaoGe.ItemLib.itemLibOrder == 1 then
                        return a[key] < b[key]
                    else
                        return b[key] < a[key]
                    end
                end
            end
            -- 副本玩家最大数量
            local key = "players"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    return a[key] > b[key]
                end
            end
        elseif BiaoGe.ItemLib.itemLibOrderButtonId == 4 then -- 按获取途径排序
            -- 来源类型
            local key = "type"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    if BiaoGe.ItemLib.itemLibOrder == 1 then
                        return a[key] < b[key]
                    else
                        return b[key] < a[key]
                    end
                end
            end
            -- 来源类型2
            local key = "type2"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    if BiaoGe.ItemLib.itemLibOrder == 1 then
                        return a[key] < b[key]
                    else
                        return b[key] < a[key]
                    end
                end
            end
            -- 副本玩家最大数量
            local key = "players"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    return a[key] > b[key]
                end
            end
            -- 难度
            local key = "hardnum"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    return a[key] > b[key]
                end
            end
            -- 装备等级
            local key = "level"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    return a[key] > b[key]
                end
            end
            -- 装备品质
            local key = "quality"
            if a[key] and b[key] then
                if a[key] ~= b[key] then
                    return a[key] > b[key]
                end
            end
        end
        -- BOSS序号
        local key = "i"
        if a[key] and b[key] then
            if a[key] ~= b[key] then
                return a[key] > b[key]
            end
        end
        -- 难度
        local key = "hardnum"
        if a[key] and b[key] then
            if a[key] ~= b[key] then
                return a[key] > b[key]
            end
        end
        return false
    end)

    local sorter = BG.ItemLibMainFrame[1].sorter
    local bt = BG.ItemLibMainFrame[1]["title" .. BiaoGe.ItemLib.itemLibOrderButtonId]
    sorter:SetParent(bt)
    sorter:ClearAllPoints()
    if bt.textJustifyH == "CENTER" then
        sorter:SetPoint("LEFT", bt, "CENTER", bt.textwidth / 2, 0)
    else
        sorter:SetPoint("LEFT", bt, "LEFT", bt.textwidth, 0)
    end
    if not isnewsorter then
        if BiaoGe.ItemLib.itemLibOrder == 1 then
            sorter:SetTexCoord(0, 0.5, 0, 1)
        else
            sorter:SetTexCoord(0, 0.5, 1, 0)
        end
    end

    return tbl
end
local function GetItemLibTable(num, EquipLocs)
    local tbl = CheckItemCache(EquipLocs)
    BG.itemLibItemOldTbl = tbl
    -- pt(#tbl)

    -- 删除重复装备，合并获取途径
    local newtbl = {}
    local seen = {}
    for _, v in ipairs(tbl) do
        if not seen[v.itemID] then
            table.insert(newtbl, v)
            seen[v.itemID] = true
        else
            for i, vv in ipairs(newtbl) do
                if v.itemID == vv.itemID then
                    vv.get = vv.get .. "\n" .. v.get
                end
            end
        end
    end

    -- 排序
    newtbl = SortItemLibTable(newtbl)

    BG.ItemLibMainFrame[num].count = #newtbl
    BG.itemLibItemTbl = newtbl
    return newtbl
end
local function ShowHideScrollBar(num)
    if num == 1 then
        _G["BG.ItemLibMainFrameScrollBarScrollDownButton"]:Show()
        _G["BG.ItemLibMainFrameScrollBarScrollUpButton"]:Show()
        _G["BG.ItemLibMainFrameScrollBar"]:Show()
    else
        _G["BG.ItemLibMainFrameScrollBarScrollDownButton"]:Hide()
        _G["BG.ItemLibMainFrameScrollBarScrollUpButton"]:Hide()
        _G["BG.ItemLibMainFrameScrollBar"]:Hide()
    end
end
local function SetItemLib(num, itemtbale)
    -- 先隐藏之前的列表内容
    ShowHideScrollBar(0)
    local count = BG.ItemLibMainFrame[num].buttoncount
    if count then
        for i = 1, count do
            BG.ItemLibMainFrame[num]["button" .. i]:Hide()
        end
    end

    if #itemtbale > MAXBUTTONS then
        ShowHideScrollBar(1)
    end

    for ii, vv in ipairs(itemtbale) do
        local right
        local i_table = { ii, vv.level, (AddTexture(vv.texture) .. vv.link), vv.get }
        for i, v in ipairs(title_table) do
            local f = CreateFrame("Frame", nil, right or BG.ItemLibMainFrame[num])
            if i == #title_table then
                f:SetSize(title_table[i].width - 2, BUTTONHEIGHT)
            else
                f:SetSize(title_table[i].width, BUTTONHEIGHT)
            end
            if ii == 1 and i == 1 then
                f:SetPoint("TOPLEFT", BG.ItemLibMainFrame[num], 10, 0)
                BG.ItemLibMainFrame[num]["button" .. ii] = f
            elseif i == 1 then
                f:SetPoint("TOPLEFT", BG.ItemLibMainFrame[num]["button" .. ii - 1], "BOTTOMLEFT", 0, 0)
                BG.ItemLibMainFrame[num]["button" .. ii] = f
            else
                f:SetPoint("LEFT", right, "RIGHT", 0, 0)
            end
            right = f
            f.num = ii
            f.itemID = GetItemInfoInstant(vv.link)
            f.itemLink = vv.link
            BG.ItemLibMainFrame[num].buttoncount = ii
            f.Text = f:CreateFontString()
            f.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            f.Text:SetPoint("CENTER")
            f.Text:SetTextColor(RGB(title_table[i].color))
            f.Text:SetJustifyH(title_table[i].JustifyH)
            f.Text:SetWidth(f:GetWidth())
            f.Text:SetWordWrap(false)
            f.Text:SetText(i_table[i])
            if i == 1 then
                f.Text:SetTextColor(RGB(BG.dis))
            end
            if f.Text:GetStringWidth() > f.Text:GetWidth() or strfind(i_table[i], "\n") then
                f.onenter = i_table[i]
            end
            if i == 3 then
                BG.ItemLibMainFrame[num]["button" .. ii].item = f
                BG.ItemLibMainFrame[num]["button" .. ii].itemID = GetItemID(f.Text:GetText())
            end
            if i == 4 then
                BG.ItemLibMainFrame[num]["button" .. ii].get = f
            end

            f:SetScript("OnMouseDown", function(self)
                if IsShiftKeyDown() then
                    if AuctionatorShoppingFrame and AuctionatorShoppingFrame:IsVisible() then
                        ChatEdit_InsertLink(vv.link)
                    elseif AuctionFrameBrowse and AuctionFrameBrowse:IsVisible() then
                        ChatEdit_InsertLink(vv.link)
                    else
                        local f = GetCurrentKeyBoardFocus()
                        if not f then
                            ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                        end
                        ChatEdit_InsertLink(vv.link)
                    end
                elseif IsAltKeyDown() then
                    if BG.ItemLibMainFrame[num]["button" .. ii].item.hope:IsVisible() then return end
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
                                                            BiaoGe.Hope[RealmId][player][FB]["nandu" .. nandu]["boss" .. boss]["zhuangbei" .. i] = exItemLink
                                                            BG.ItemLibMainFrame[num]["button" .. ii].item.hope:Show()
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
                                            BiaoGe.Hope[RealmId][player][FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] = vv.link
                                            BG.ItemLibMainFrame[num]["button" .. ii].item.hope:Show()
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
                                    BiaoGe.Hope[RealmId][player][FB]["nandu" .. nandu]["boss" .. boss]["zhuangbei" .. i] = vv.link
                                    BG.ItemLibMainFrame[num]["button" .. ii].item.hope:Show()
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
                if self.onenter and i ~= 3 then
                    BiaoGeTooltip2:SetOwner(self, "ANCHOR_TOPRIGHT", 0, 0)
                    BiaoGeTooltip2:ClearLines()
                    BiaoGeTooltip2:AddLine(self.onenter, 1, 1, 1, false)
                    BiaoGeTooltip2:Show()
                end
                local itemID = GetItemInfoInstant(vv.link)
                if BG.ButtonIsInRight(BG.MainFrame, 0.67) then
                    GameTooltip:SetOwner(BG.ItemLibMainFrame["bg" .. num].tooltip2, "ANCHOR_BOTTOMLEFT", 0, 0)
                else
                    GameTooltip:SetOwner(BG.ItemLibMainFrame["bg" .. num].tooltip, "ANCHOR_BOTTOMRIGHT", 0, 0)
                end
                GameTooltip:ClearLines()
                GameTooltip:SetItemByID(itemID)
                GameTooltip:Show()
                BG.ItemLibMainFrame[num]["button" .. ii].ds:Show()
            end)
            f:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                BiaoGeTooltip2:Hide()
                BG.ItemLibMainFrame[num]["button" .. ii].ds:Hide()
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
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
                    BiaoGeTooltip2:AddLine(L["右键取消心愿装备"], 1, 0.82, 0, true)
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
        local f = BG.ItemLibMainFrame[num]["button" .. ii]
        f.ds = f:CreateTexture()
        f.ds:SetSize(BG.ItemLibFramewidth, f:GetHeight())
        f.ds:SetPoint("LEFT")
        f.ds:SetColorTexture(1, 1, 1, 0.1)
        f.ds:Hide()

        CreateLine(f, 0, BG.ItemLibFramewidth, 1, nil, 0.2)
    end
end
local function UpdateTiptext(num, itemtbale)
    local FB = BG.FB1
    if BiaoGe.FilterClassItemDB[RealmId][player].chooseID then
        BG.ItemLibMainFrame[num]["noItem"]:SetText(L["该部位没有合适当前过滤方案的装备"])
    else
        BG.ItemLibMainFrame[num]["noItem"]:SetText(L["请在下方选择一个过滤方案"])
    end
    BG.ItemLibMainFrame[num]["noItem"]:Show()
    if updateCDing or #itemtbale ~= 0 then
        BG.ItemLibMainFrame[num]["noItem"]:Hide()
    end

    local P = BG.GetFBinfo(FB, "phase")
    local B = ""
    for i, v in ipairs(BG.invtypetable) do
        if v.key[1] == BiaoGe["ItemLibInvType"][num][1] then
            B = (v.name)
        end
    end

    local F = BG.STC_dis(L["没有过滤方案"])
    local n = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
    if n then
        F = BiaoGe.FilterClassItemDB[RealmId][player][n].Name
    end

    local C
    local c = BG.ItemLibMainFrame[num].count
    if c == 0 then
        C = BG.STC_dis(BG.ItemLibMainFrame[num].count .. L["件"])
    else
        C = BG.STC_g1(BG.ItemLibMainFrame[num].count .. L["件"])
    end
    BG.ItemLibMainFrame[num]["toptitle"]:SetText(BG.STC_b1(P .. "   " .. B .. "   " .. F .. "   " .. C))
end
local function UpdateItemLib(num, EquipLocs)
    local itemtbale = GetItemLibTable(num, EquipLocs)
    SetItemLib(num, itemtbale)
    UpdateTiptext(num, itemtbale)
end
function BG.UpdateAllItemLib(num)
    local num = num or 1
    local EquipLocs = BiaoGe["ItemLibInvType"][num]
    UpdateItemLib(num, EquipLocs)
end

function BG.CacheAndUpdateAllItemLib()
    BG.itemLibCaches[BG.FB1] = true
    CheckItemCache()

    local num = 1
    local count = BG.ItemLibMainFrame[num].buttoncount
    if count then
        for i = 1, count do
            BG.ItemLibMainFrame[num]["button" .. i]:Hide()
        end
    end

    local t = CreateLoadingText()

    BG.After(0.5, function()
        t:Hide()
        BG.UpdateAllItemLib()
        BG.UpdateItemLib_RightHope_All()
        BG.UpdateItemLib_RightHope_IsHaved_All()
        BG.UpdateItemLib_RightHope_IsLooted_All()
    end)
end

BG.CheckItemCache = CheckItemCache

-- 更新心愿装备
do
    local function GetEquipLocName(EquipLoc) -- 返回该装备部位对应的invtypetable名称
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
                local hope = BG.ItemLibMainFrame.Hope[EquipLoc .. i]
                local _itemID = GetItemID(hope:GetText())
                if _itemID == itemID then
                    return true
                end
            end
        end
    end
    function BG.UpdateItemLib_RightHope(itemID, ShoworHide) -- 更新心愿汇总，ShoworHide：1为添加装备，0为删除装备
        local FB = BG.FB1
        local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID, bindType = GetItemInfo(itemID)
        local EquipLoc = GetEquipLocName(EquipLoc)
        if not EquipLoc then return end
        -- 只需历遍对应部位的心愿格子
        for i = 1, maxhope do
            local hope = BG.ItemLibMainFrame.Hope[EquipLoc .. i]
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
        local num = 1
        local count = BG.ItemLibMainFrame[num].buttoncount
        if count then
            for ii = 1, count do
                local _itemID = BG.ItemLibMainFrame[num]["button" .. ii].itemID

                local isExItem

                local exItemID, exItemLink = GetkExchangeItemInfo(_itemID)
                if itemID == exItemID then
                    isExItem = true
                end

                if itemID == _itemID or isExItem then
                    if ShoworHide == 1 then
                        BG.ItemLibMainFrame[num]["button" .. ii].item.hope:Show()
                    else
                        BG.ItemLibMainFrame[num]["button" .. ii].item.hope:Hide()
                    end
                end
            end
        end
    end

    function BG.UpdateItemLib_LeftHope_HideAll()
        local num = 1
        local count = BG.ItemLibMainFrame[num].buttoncount
        if count then
            for ii = 1, count do
                BG.ItemLibMainFrame[num]["button" .. ii].item.hope:Hide()
            end
        end
    end

    function BG.UpdateItemLib_RightHope_HideAll()
        for i, v in ipairs(BG.invtypetable) do
            local EquipLoc = v.name2
            for i = 1, maxhope do
                local hope = BG.ItemLibMainFrame.Hope[EquipLoc .. i]
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
                                    BiaoGe.Hope[RealmId][player][FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] = nil
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
                        local bt = BiaoGe.Hope[RealmId][player][FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
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
        if BG.IsVanilla_60() then
            FBtable = { BG.FB1 }
        end
        for _, FB in pairs(FBtable) do
            for n = HopeMaxn[FB], 1, -1 do
                for b = HopeMaxb[FB], 1, -1 do
                    for i = 1, HopeMaxi do
                        local bt = BiaoGe.Hope[RealmId][player][FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                        if bt then
                            local itemID = GetItemID(bt)
                            if itemID then
                                BG.UpdateItemLib_RightHope(itemID, 1)
                            end
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
        local num = 1
        local count = BG.ItemLibMainFrame[num].buttoncount
        if count then
            for i = 1, count do
                local item = BG.ItemLibMainFrame[num]["button" .. i].item
                local itemID = BG.ItemLibMainFrame[num]["button" .. i].itemID
                if BG.GetItemCount(itemID) ~= 0 then
                    item.haved:Show()
                else
                    item.haved:Hide()
                end
            end
        end
    end

    function BG.UpdateItemLib_RightHope_IsHaved_All()
        if BG.ItemLibMainFrame:IsVisible() then
            for k, bt in pairs(BG.ItemLibMainFrame.Hope) do
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
                for i = 1, Maxi[FB] do
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
        local num = 1
        local count = BG.ItemLibMainFrame[num].buttoncount
        if count then
            for i = 1, count do
                local get = BG.ItemLibMainFrame[num]["button" .. i].get
                local itemID = BG.ItemLibMainFrame[num]["button" .. i].itemID
                BG.Update_IsLooted(get, itemID)
            end
        end
    end

    function BG.UpdateItemLib_RightHope_IsLooted_All()
        if BG.ItemLibMainFrame:IsVisible() then
            for k, bt in pairs(BG.ItemLibMainFrame.Hope) do
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
            for k, bt in pairs(BG.ItemLibMainFrame.Hope) do
                if type(bt) == "table" and bt.EquipLoc then
                    BG.Update_IsLooted(bt)
                end
            end
        end
    end
end

------------------------------------------------------------------------
------------------------------------------------------------------------

function BG.ItemLibUI()
    local num = 1

    if not BiaoGe["ItemLibInvType"] then
        BiaoGe["ItemLibInvType"] = {}
    end
    if not BiaoGe["ItemLibInvType"][num] then
        BiaoGe["ItemLibInvType"][num] = { "INVTYPE_HEAD" }
    end
    if not BiaoGe.ItemLib then
        BiaoGe.ItemLib = {}
    end
    if not BiaoGe.ItemLib.itemLibOrderButtonId then
        BiaoGe.ItemLib.itemLibOrderButtonId = 3
    end
    if not BiaoGe.ItemLib.itemLibOrder then
        BiaoGe.ItemLib.itemLibOrder = 1
    end
    BiaoGe.ItemLib.fitlerGet = BiaoGe.ItemLib.fitlerGet or {}

    local width = BG.ItemLibFramewidth
    BG.itemLib_Hope_Buttons = {}
    BG.itemLib_Inv_Buttons = {}

    function BG.InvOnClick(self)
        BiaoGe["ItemLibInvType"][num] = self.key
        BG.UpdateAllItemLib()

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
            if BiaoGe["ItemLibInvType"][num][1] == v.key[1] then
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
    -- 主要UI
    do
        local f = CreateFrame("Frame", nil, BG.ItemLibMainFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 10,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetSize(width + 20, BUTTONHEIGHT * (MAXBUTTONS + 1) + 20)
        f:SetPoint("TOPLEFT", BG.MainFrame, 30, -80)
        BG.ItemLibMainFrame.bg1 = f

        local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
        scroll:SetPoint("TOPLEFT", 0, -35)
        scroll:SetPoint("BOTTOMRIGHT", -30, 5)
        scroll.ScrollBar.scrollStep = BUTTONHEIGHT * 4
        BG.CreateSrollBarBackdrop(scroll.ScrollBar)

        local frame = CreateFrame("Frame", nil, scroll)
        frame:SetSize(1, 1)
        BG.ItemLibMainFrame[num] = frame
        scroll:SetScrollChild(frame)

        -- 鼠标提示定位
        local _f = CreateFrame("Frame", nil, f)
        _f:SetSize(1, 1)
        _f:SetPoint("TOPRIGHT", 0, 1)
        f.tooltip = _f

        local _f = CreateFrame("Frame", nil, f)
        _f:SetSize(1, 1)
        _f:SetPoint("TOPLEFT", 0, 1)
        f.tooltip2 = _f

        -- 标题
        local buttons = {}
        for i, v in ipairs(title_table) do
            local bt = CreateFrame("Button", nil, f, "BackdropTemplate")
            -- f:SetBackdrop({
            --     bgFile = "Interface/ChatFrame/ChatFrameBackground",
            -- })
            bt:SetSize(title_table[i].width, BUTTONHEIGHT)
            if i == 1 then
                bt:SetPoint("TOPLEFT", 10, -10)
            else
                bt:SetPoint("LEFT", buttons[i - 1], "RIGHT", 0, 0)
            end
            bt:SetNormalFontObject(BG.FontWhite15)
            bt:SetText(title_table[i].name)
            bt.textwidth = bt:GetFontString():GetStringWidth()
            bt.textJustifyH = title_table[i].JustifyH
            bt.sortOrder = 1
            bt.id = i
            bt:SetHighlightTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
            bt:Disable()
            if i ~= 1 then
                bt:Enable()
            end
            BG.ItemLibMainFrame[num]["title" .. i] = bt
            tinsert(buttons, bt)

            bt.text = bt:GetFontString()
            bt.text:SetTextColor(RGB(title_table[i].color))
            bt.text:SetJustifyH(title_table[i].JustifyH)
            bt.text:SetWidth(bt:GetWidth())
            bt.text:SetWordWrap(false)
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                local isnewsorter
                if BiaoGe.ItemLib.itemLibOrderButtonId ~= self.id then
                    isnewsorter = true
                end
                if not isnewsorter then
                    BiaoGe.ItemLib.itemLibOrder = BiaoGe.ItemLib.itemLibOrder == 1 and 0 or 1
                end
                BiaoGe.ItemLib.itemLibOrderButtonId = self.id

                BG.itemLibItemTbl = SortItemLibTable(BG.itemLibItemTbl, isnewsorter)
                SetItemLib(1, BG.itemLibItemTbl)
            end)
        end
        CreateLine(BG.ItemLibMainFrame[num]["title1"], 0, width - 20)

        -- 排序按钮
        local sorter = f:CreateTexture(nil, "OVERLAY")
        sorter:SetSize(8, 8)
        sorter:SetTexture("Interface/Buttons/ui-sortarrow")
        BG.ItemLibMainFrame[num].sorter = sorter

        -- 获取途径过滤
        do
            local parent = BG.ItemLibMainFrame[num]["title4"]
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
            BG.ItemLibMainFrame[num].fitlerGetButton = bt
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["获取途径显示"], 1, 1, 1, true)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)

            local tbl
            if BG.IsVanilla_Sod() then
                tbl = {
                    { name = L["团本"], name2 = "raid", },
                    { name = L["5人本"], name2 = "fb5", },
                    { name = L["牌子/货币"], name2 = "currency", },
                    { name = L["声望"], name2 = "faction", },
                    { name = L["专业"], name2 = "profession", },
                    { name = L["世界掉落"], name2 = "world", },
                    { name = L["PVP"], name2 = "pvp", },
                }
            elseif BG.IsVanilla_60() then
                tbl = {
                    { name = L["团本"], name2 = "raid", },
                    { name = L["声望"], name2 = "faction", },
                    { name = L["专业"], name2 = "profession", },
                    { name = L["世界掉落"], name2 = "world", },
                    { name = L["世界BOSS"], name2 = "worldboss", },
                    { name = L["PVP"], name2 = "pvp", },
                }
            elseif BG.IsWLK() then
                tbl = {
                    { name = L["团本：25人"], name2 = "raid25", },
                    { name = L["团本：10人"], name2 = "raid10", },
                    { name = L["团本：英雄难度"], name2 = "raidhero", },
                    { name = L["团本：普通难度"], name2 = "raidnormal", },
                    -- { name = L["5人本"], name2 = "fb5", },
                    { name = L["牌子/货币"], name2 = "currency", },
                    { name = L["声望"], name2 = "faction", },
                    { name = L["专业"], name2 = "profession", },
                }
            elseif BG.IsCTM() then
                tbl = {
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
            f:SetPoint("TOPLEFT", BG.ItemLibMainFrame.bg1, "TOPRIGHT", 0, 1)

            f:EnableMouse(true)
            f:SetFrameLevel(110)
            f:Hide()

            BG.ItemLibMainFrame[num].fitlerGetButton:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                if f:IsVisible() then
                    f:Hide()
                else
                    f:Show()
                end
            end)

            local t = f:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOP", f, "TOP", 0, -10)
            t:SetTextColor(RGB("FFD100"))
            t:SetText(L["获取途径显示"])
            t:SetJustifyH("CENTER")

            f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
            f.CloseButton:SetPoint("TOPRIGHT", f, "TOPRIGHT", 2, 2)

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
                    BG.UpdateAllItemLib()
                end)
            end
        end

        -- 头顶大标题
        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("BOTTOM", BG.ItemLibMainFrame.bg1, "TOP", 0, 0)
        BG.ItemLibMainFrame[num]["toptitle"] = t

        -- 没有合适的装备
        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("TOPLEFT", BG.ItemLibMainFrame[num]["title" .. 3], "BOTTOMLEFT", 0, -5)
        t:SetTextColor(RGB(BG.dis))
        BG.ItemLibMainFrame[num]["noItem"] = t

        -- 过滤方案
        local t = BG.ItemLibMainFrame:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("RIGHT", BG.FilterClassItemMainFrame.Buttons2, "LEFT", -10, 0)
        t:SetText(L["过滤方案："])
        t:SetTextColor(1, 0.82, 0)
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


        local f = CreateFrame("Frame", nil, BG.ItemLibMainFrame.bg1, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 10,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetSize(width + 20, 0)
        f:SetPoint("TOPLEFT", f:GetParent(), "BOTTOMLEFT", 0, -10)
        BG.ItemLibMainFrame[num]["invtypeFrame"] = f
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
            if v.key[1] == BiaoGe["ItemLibInvType"][num][1] then
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

    -- 心愿汇总
    do
        local w = 140
        local w_jiange = 5
        local h_jiange = 1
        local width = 80 + (w + w_jiange) * 4 + 25

        local f = CreateFrame("Frame", nil, BG.ItemLibMainFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 10,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetSize(width, BG.ItemLibMainFrame.bg1:GetHeight())
        f:SetPoint("TOPLEFT", BG.ItemLibMainFrame.bg1, "TOPRIGHT", 30, 0)
        BG.ItemLibMainFrame.Hope = f

        -- 头顶大标题
        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("BOTTOM", BG.ItemLibMainFrame.Hope, "TOP", 0, 0)
        t:SetText(L["心愿汇总"])
        t:SetTextColor(RGB(BG.b1))
        -- 底下提示文字
        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
        t:SetPoint("TOP", BG.ItemLibMainFrame.Hope, "BOTTOM", 0, 0)
        t:SetText(L["（右键删除心愿装备）"])

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
            t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("CENTER")
            t:SetText(title_table[i].name)
            t:SetTextColor(RGB(title_table[i].color))
            t:SetJustifyH(title_table[i].JustifyH)
            t:SetWidth(f:GetWidth())
            t:SetWordWrap(false)
            right = f
            BG.ItemLibMainFrame[num]["Hopetitle" .. i] = f
        end
        -- CreateLine(BG.ItemLibMainFrame[num]["Hopetitle1"], 0, width - 25)

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
                    if v.key[1] == BiaoGe["ItemLibInvType"][num][1] then
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
                    BG.ItemLibMainFrame.Hope[v.name2 .. (ii - 1)] = edit
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

                        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID -- 隐藏
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
                                local f = GetCurrentKeyBoardFocus()
                                if not f then
                                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                                end
                                ChatEdit_InsertLink(link)
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
                        local itemLink = self:GetText()
                        local itemID = GetItemInfoInstant(itemLink)
                        if itemID then
                            if BG.ButtonIsInRight(self) then
                                GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
                            else
                                GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                            end
                            GameTooltip:ClearLines()
                            GameTooltip:SetItemByID(itemID)
                            GameTooltip:Show()
                        end
                        self.ds:Show()
                    end)
                    edit:SetScript("OnLeave", function(self)
                        GameTooltip:Hide()
                        self.ds:Hide()
                    end)
                end
            end
        end

        BG.ItemLibMainFrame[num].count = 0
    end
end

BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
    if not (isLogin or isReload) then return end

    BG.itemLibCaches = {}

    BG.ItemLibMainFrame:HookScript("OnShow", function(self)
        if not BG.itemLibCaches[BG.FB1] then
            BG.CacheAndUpdateAllItemLib()
        else
            if BG.lastItemLibFB ~= BG.FB1 then
                BG.UpdateAllItemLib()
            end
            BG.UpdateItemLib_LeftHope_All()
            BG.UpdateItemLib_LeftLib_IsHaved_All()
            BG.UpdateItemLib_LeftLib_IsLooted_All()
        end
        BG.UpdateItemLib_RightHope_All()
        BG.lastItemLibFB = BG.FB1
    end)
end)
