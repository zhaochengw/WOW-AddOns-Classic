
local MAJOR, MINOR = "LibItemInfo.7000", 6
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

local locale = GetLocale()

local ItemLevelPattern = gsub(ITEM_LEVEL, "%%d", "(%%d+)")
local ItemLevelPlusPat = gsub(ITEM_LEVEL_PLUS, "%%d%+", "(%%d+%%+)")

local tooltip = CreateFrame("GameTooltip", "LibItemLevelTooltip1", UIParent, "GameTooltipTemplate")
local unittip = CreateFrame("GameTooltip", "LibItemLevelTooltip2", UIParent, "GameTooltipTemplate")

function lib:HasLocalCached(item)
    if (not item or item == "" or item == "0") then return true end
    if (tonumber(item)) then
        return select(10, GetItemInfo(tonumber(item)))
    else
        local id, gem1, gem2, gem3 = string.match(item, "item:(%d+):[^:]*:(%d-):(%d-):(%d-):")
        return self:HasLocalCached(id) and self:HasLocalCached(gem1) and self:HasLocalCached(gem2) and self:HasLocalCached(gem3)
    end
end

function lib:GetStatsViaTooltip(tip, stats)
    if (type(stats) == "table") then
        local line, text, r, g, b, statValue, statName
        for i = 2, tip:NumLines() do
            line = _G[tip:GetName().."TextLeft" .. i]
            text = line:GetText() or ""
            r, g, b = line:GetTextColor()
            for statValue, statName in string.gmatch(text, "%+([0-9,]+)([^%+%|]+)") do
                statName = strtrim(statName)
                statName = statName:gsub("與$", "") --zhTW
                statName = statName:gsub("和$", "") --zhTW
                statName = statName:gsub("，", "")  --zhCN
                statName = statName:gsub("%s*&$", "") --enUS
                statValue = statValue:gsub(",","")
                statValue = tonumber(statValue) or 0
                if (not stats[statName]) then
                    stats[statName] = { value = statValue, r = r, g = g, b = b }
                else
                    stats[statName].value = stats[statName].value + statValue
                    if (g > stats[statName].g) then
                        stats[statName].r = r
                        stats[statName].g = g
                        stats[statName].b = b
                    end
                end
            end
        end
    end
    return stats
end

-- koKR
if (locale == "koKR") then
    function lib:GetStatsViaTooltip(tip, stats)
        if (type(stats) == "table") then
            local line, text, r, g, b, statValue, statName
            for i = 2, tip:NumLines() do
                line = _G[tip:GetName().."TextLeft" .. i]
                text = line:GetText() or ""
                r, g, b = line:GetTextColor()
                for statName, statValue in string.gmatch(text, "([^%+]+)%+([0-9,]+)") do
                    statName = statName:gsub("|c%x%x%x%x%x%x%x%x", "")
                    statName = statName:gsub(".-:", "")
                    statName = strtrim(statName)
                    statName = statName:gsub("%s*/%s*", "")
                    statValue = statValue:gsub(",","")
                    statValue = tonumber(statValue) or 0
                    if (not stats[statName]) then
                        stats[statName] = { value = statValue, r = r, g = g, b = b }
                    else
                        stats[statName].value = stats[statName].value + statValue
                        if (g > stats[statName].g) then
                            stats[statName].r = r
                            stats[statName].g = g
                            stats[statName].b = b
                        end
                    end
                end
            end
        end
        return stats
    end
end

function lib:GetItemInfo(link, stats, withoutExtra)
    return self:GetItemInfoViaTooltip(link, stats, withoutExtra)
end

function lib:GetItemInfoViaTooltip(link, stats)
    if (not link or link == "") then
        return 0, 0
    end
    if (not string.match(link, "item:%d+:")) then
        return 1, -1
    end
    if (not self:HasLocalCached(link)) then
        return 1, 0
    end
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:SetHyperlink(link)
    local text, level
    for i = 2, 5 do
        if (_G[tooltip:GetName().."TextLeft" .. i]) then
            text = _G[tooltip:GetName().."TextLeft" .. i]:GetText() or ""
            level = string.match(text, ItemLevelPattern)
            if (level) then break end
            level = string.match(text, ItemLevelPlusPat)
            if (level) then break end
        end
    end
    self:GetStatsViaTooltip(tooltip, stats)
    if (level and string.find(level, "+")) then else
        level = tonumber(level) or 0
    end
    if (withoutExtra) then
        return 0, level
    else
        return 0, level, GetItemInfo(link)
    end
end

function lib:GetContainerItemLevel(pid, id)
    if (pid < 0) then
        local link = GetContainerItemLink(pid, id)
        return self:GetItemInfo(link)
    end
    local text, level
    if (pid and id) then
        tooltip:SetOwner(UIParent, "ANCHOR_NONE")
        tooltip:SetBagItem(pid, id)
        for i = 2, 5 do
            if (_G[tooltip:GetName().."TextLeft" .. i]) then
                text = _G[tooltip:GetName().."TextLeft" .. i]:GetText() or ""
                level = string.match(text, ItemLevelPattern)
                if (level) then break end
            end
        end
    end
    return 0, tonumber(level) or 0
end

function lib:GetUnitItemInfo(unit, index, stats)
    if (not UnitExists(unit)) then return 1, -1 end  --C_PaperDollInfo.GetInspectItemLevel
    unittip:SetOwner(UIParent, "ANCHOR_NONE")
    unittip:SetInventoryItem(unit, index)
    local link = GetInventoryItemLink(unit, index) or select(2, unittip:GetItem())

    if (not link or link == "") then
        return 0, 0
    end
    if (not self:HasLocalCached(link)) then
        return 1, 0
    end
    local text, level
    for i = 2, 5 do
        if (_G[unittip:GetName().."TextLeft" .. i]) then
            text = _G[unittip:GetName().."TextLeft" .. i]:GetText() or ""
            level = string.match(text, ItemLevelPattern)
            if (level) then break end
        end
    end
    self:GetStatsViaTooltip(unittip, stats)
    if (string.match(link, "item:(%d+):")) then
        return 0, tonumber(level) or 0, GetItemInfo(link)
    else
        local line = _G[unittip:GetName().."TextLeft1"]
        local r, g, b = line:GetTextColor()
        local name = ("|cff%.2x%.2x%.2x%s|r"):format((r or 1)*255, (g or 1)*255, (b or 1)*255, line:GetText() or "")
        return 0, tonumber(level) or 0, name
    end
end

function lib:GetUnitItemUpgradeInfo(unit, index)
	local _, _, _, _, _, _, _, _, _, _, _ = self:GetUnitItemInfo(unit, index)
	local stage, maxStage = 0, 0

	unittip:SetOwner(UIParent, "ANCHOR_NONE")
	unittip:SetInventoryItem(unit, index)

	for i = 2, unittip:NumLines() do
		local line = _G[unittip:GetName().."TextLeft" .. i]
		local txt = line and line:GetText()
		if txt then
			-- Finde jedes Muster "X / Y"
			local a, b = txt:match("(%d+)%s*/%s*(%d+)")
			if a and b then
				local na, nb = tonumber(a), tonumber(b)

				-- Nur akzeptieren, wenn plausible Upgrade-Stufen:
				-- maxStage 1–3 (Upgrade-System), niemals >3 (z. B. Setteile 1/5)
				if nb <= 3 then
					stage, maxStage = na, nb
					break
				end
			end
		end
	end

	return stage, maxStage
end



function lib:GetUnitItemLevel(unit, stats)
    local total, counts, maxlevel = 0, 0, 0
    local _, count, level
    for i = 1, 15 do
        if (i ~= 4) then
            count, level = self:GetUnitItemInfo(unit, i, stats)
            total = total + level
            counts = counts + count
            maxlevel = max(maxlevel, level)
        end
    end
    local mcount, mlevel, mquality, mslot, ocount, olevel, oquality, oslot
    mcount, mlevel, _, _, mquality, _, _, _, _, _, mslot = self:GetUnitItemInfo(unit, 16, stats)
    ocount, olevel, _, _, oquality, _, _, _, _, _, oslot = self:GetUnitItemInfo(unit, 17, stats)
    counts = counts + mcount + ocount
    if (mquality == 6 or oquality == 6) then
        total = total + max(mlevel, olevel) * 2
    elseif (oslot == "INVTYPE_2HWEAPON" or mslot == "INVTYPE_2HWEAPON" or mslot == "INVTYPE_RANGED" or mslot == "INVTYPE_RANGEDRIGHT") then 
        total = total + max(mlevel, olevel) * 2
    else
        total = total + mlevel + olevel
    end
    maxlevel = max(maxlevel, mlevel, olevel)
    return counts, total/max(16-counts,1), total, max(mlevel,olevel), (mquality == 6 or oquality == 6), maxlevel
end

function lib:GetQuestItemlink(questType, id)
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:SetQuestLogItem(questType, id)
    return select(2, tooltip:GetItem()) or GetQuestLogItemLink(questType, id)
end


-- 2025-08-19 - Adding new functions to get values of the items


local STAT_MAP = {
  -- Primary
  ITEM_MOD_STRENGTH_SHORT = "STR",       ITEM_MOD_STRENGTH = "STR",
  ITEM_MOD_AGILITY_SHORT  = "AGI",       ITEM_MOD_AGILITY  = "AGI",
  ITEM_MOD_STAMINA_SHORT  = "STA",       ITEM_MOD_STAMINA  = "STA",
  ITEM_MOD_INTELLECT_SHORT= "INT",       ITEM_MOD_INTELLECT= "INT",

  -- Haste (unified + legacy spell/melee/ranged variants)
  ITEM_MOD_HASTE_RATING_SHORT   = "HASTE", ITEM_MOD_HASTE_RATING   = "HASTE",
  ITEM_MOD_SPELL_HASTE_RATING_SHORT = "HASTE", ITEM_MOD_SPELL_HASTE_RATING = "HASTE",
  ITEM_MOD_MELEE_HASTE_RATING_SHORT = "HASTE", ITEM_MOD_MELEE_HASTE_RATING = "HASTE",
  ITEM_MOD_RANGED_HASTE_RATING_SHORT= "HASTE", ITEM_MOD_RANGED_HASTE_RATING= "HASTE",

  -- Crit (unified + legacy split)
  ITEM_MOD_CRIT_RATING_SHORT    = "CRIT",  ITEM_MOD_CRIT_RATING    = "CRIT",
  ITEM_MOD_CRIT_MELEE_RATING_SHORT = "CRIT", ITEM_MOD_CRIT_MELEE_RATING = "CRIT",
  ITEM_MOD_CRIT_RANGED_RATING_SHORT= "CRIT", ITEM_MOD_CRIT_RANGED_RATING= "CRIT",
  ITEM_MOD_CRIT_SPELL_RATING_SHORT = "CRIT", ITEM_MOD_CRIT_SPELL_RATING = "CRIT",

  -- Mastery
  ITEM_MOD_MASTERY_RATING_SHORT = "MASTERY", ITEM_MOD_MASTERY_RATING = "MASTERY",

  -- Hit (unified + legacy split)
  ITEM_MOD_HIT_RATING_SHORT     = "HIT",  ITEM_MOD_HIT_RATING     = "HIT",
  ITEM_MOD_HIT_MELEE_RATING_SHORT  = "HIT", ITEM_MOD_HIT_MELEE_RATING  = "HIT",
  ITEM_MOD_HIT_RANGED_RATING_SHORT = "HIT", ITEM_MOD_HIT_RANGED_RATING = "HIT",
  ITEM_MOD_HIT_SPELL_RATING_SHORT  = "HIT", ITEM_MOD_HIT_SPELL_RATING  = "HIT",

  -- Expertise
  ITEM_MOD_EXPERTISE_RATING_SHORT = "EXPERTISE", ITEM_MOD_EXPERTISE_RATING = "EXPERTISE",

  -- Dodge / Parry
  ITEM_MOD_DODGE_RATING_SHORT   = "DODGE", ITEM_MOD_DODGE_RATING   = "DODGE",
  ITEM_MOD_PARRY_RATING_SHORT   = "PARRY", ITEM_MOD_PARRY_RATING   = "PARRY",
  
  ITEM_MOD_SPELL_POWER = "SP",
  ITEM_MOD_MASTERY_SHORT = "MASTERY",
  ITEM_MOD_DAMAGE_PER_SECOND_SHORT = "DPS",
  ITEM_MOD_PVP_POWER_SHORT = "PVP_PWR",
  
  -- Sockets (Anzahl der Sockel)
  EMPTY_SOCKET_META = "SOCKET_META",EMPTY_SOCKET_META1 = "SOCKET_META",EMPTY_SOCKET_META2 = "SOCKET_META",
  EMPTY_SOCKET_BLUE = "SOCKET_BLUE",EMPTY_SOCKET_BLUE1 = "SOCKET_BLUE",EMPTY_SOCKET_BLUE2 = "SOCKET_BLUE",EMPTY_SOCKET_BLUE3 = "SOCKET_BLUE",
  EMPTY_SOCKET_RED = "SOCKET_RED",EMPTY_SOCKET_RED1 = "SOCKET_RED",EMPTY_SOCKET_RED2 = "SOCKET_RED",EMPTY_SOCKET_RED3 = "SOCKET_RED",
  EMPTY_SOCKET_YELLOW = "SOCKET_YELLOW",EMPTY_SOCKET_YELLOW1 = "SOCKET_YELLOW",EMPTY_SOCKET_YELLOW2 = "SOCKET_YELLOW",EMPTY_SOCKET_YELLOW3 = "SOCKET_YELLOW",
  EMPTY_SOCKET_ORANGE = "SOCKET_ORANGE",EMPTY_SOCKET_ORANGE1 = "SOCKET_ORANGE",EMPTY_SOCKET_ORANGE2 = "SOCKET_ORANGE",EMPTY_SOCKET_ORANGE3 = "SOCKET_ORANGE",
  EMPTY_SOCKET_VIOLET = "SOCKET_VIOLET",EMPTY_SOCKET_VIOLET1 = "SOCKET_VIOLET",EMPTY_SOCKET_VIOLET2 = "SOCKET_VIOLET",EMPTY_SOCKET_VIOLET3 = "SOCKET_VIOLET",
  EMPTY_SOCKET_GREEN = "SOCKET_GREEN",EMPTY_SOCKET_GREEN1 = "SOCKET_GREEN",EMPTY_SOCKET_GREEN2 = "SOCKET_GREEN",EMPTY_SOCKET_GREEN3 = "SOCKET_GREEN",
  
  -- Armor (GetItemStats nutzt RESISTANCE0_NAME für Rüstung)
  RESISTANCE0_NAME = "ARMOR",
  
  
}


local STAT_KEYS = {
  "STA", "STR", "AGI", "INT",
  "HIT", "HASTE", "CRIT", "MASTERY", "EXPERTISE",
  "DODGE", "PARRY", "ARMOR",
}

local SOCKET_KEYS = {
  "META", "BLUE", "RED", "YELLOW", "PRISMATIC",
}


function lib:GetNormalizedItemStats(unit, slot)
	local link = GetInventoryItemLink(unit, slot)
	if not link then return nil end

	local statTbl = GetItemStats(link)
	if not statTbl then return nil end

	-- Ergebnis mit fixen Werten
	local result = {}

	-- Initialisieren
	for _, key in ipairs(STAT_KEYS) do
		result[key] = 0
	end

	-- Socket-Container
	result.SOCKETS = {}
	for _, key in ipairs(SOCKET_KEYS) do
		result.SOCKETS[key] = 0
	end

	-- Werte befüllen
	for statKey, value in pairs(statTbl) do
	local shortName = STAT_MAP[statKey]

	if shortName and result[shortName] ~= nil then
		result[shortName] = result[shortName] + value
	elseif statKey:match("^EMPTY_SOCKET_") then
		local socketType = statKey:gsub("EMPTY_SOCKET_", "")
		result.SOCKETS[socketType] = (result.SOCKETS[socketType] or 0) + value
	elseif statKey == "RESISTANCE0_NAME" then
		result.ARMOR = value
	end
	end

	return result
end

function lib:GetItemValues(unit,slot)
	local link = GetInventoryItemLink(unit, slot)
	if link then
		local statTbl = GetItemStats(link)
		if statTbl then
			for statKey, value in pairs(statTbl) do
				local shortName = STAT_MAP[statKey]
				print("ItemID: " .. slot .. " with Stat " .. shortName .. " = " .. value)
			end
		end
	end
end