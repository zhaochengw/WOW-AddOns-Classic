local Env = select(2, ...)

Env.IS_CLASSIC_ERA = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
Env.IS_CLASSIC_ERA_SOD = Env.IS_CLASSIC_ERA and C_Engraving.IsEngravingEnabled()
Env.IS_CLASSIC_WRATH = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
Env.IS_CLASSIC_CATA = WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC
Env.IS_CLASSIC_MISTS = WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC
Env.IS_CLIENT_SUPPORTED = Env.IS_CLASSIC_ERA or Env.IS_CLASSIC_ERA_SOD or Env.IS_CLASSIC_WRATH or Env.IS_CLASSIC_CATA or Env.IS_CLASSIC_MISTS

if Env.IS_CLASSIC_MISTS then
    Env.VERSION = C_AddOns.GetAddOnMetadata(select(1, ...), "Version")
    Env.AUTHORS = C_AddOns.GetAddOnMetadata(select(1, ...), "Author")
else
    Env.VERSION = GetAddOnMetadata(select(1, ...), "Version")
    Env.AUTHORS = GetAddOnMetadata(select(1, ...), "Author")
end

Env.supportedClientNames = {
    "Classic: Mists of Pandaria",
    "Classic: Cataclysm",
    "Classic: WotLK",
    "Classic: SoD",
    "Classic: Era/Anniversary",
}

-- SkillLine.db2
local professionSkillLineIDs = {
    Blacksmithing  = 164,
    Leatherworking = 165,
    Alchemy        = 171,
    Herbalism      = 182,
    Mining         = 186,
    Tailoring      = 197,
    Engineering    = 202,
    Enchanting     = 333,
    Skinning       = 393,
    Jewelcrafting  = 755,
    Inscription    = 773,
}

Env.professionNames = {}
for engName, skillLine in pairs(professionSkillLineIDs) do
    local localizedName = C_TradeSkillUI.GetTradeSkillDisplayName(skillLine)
    if localizedName then
        Env.professionNames[localizedName] = {
            skillLine = skillLine,
            engName = engName
        }
    end
end

local statToStatId = {
    str = 1,
    strength = 1,
    agi = 2,
    agility = 2,
    stam = 3,
    stm = 3,
    stamina = 3,
    int = 4,
    intellect = 4,
    spi = 5,
    spirit = 5,
}

---Determine if an item should be exported on bag item export.
-- TODO(Riotdog-GehennasEU): Is this sufficient? This seems to be what simc uses:
-- https://github.com/simulationcraft/simc-addon/blob/master/core.lua
-- Except we don't need the artifact check for wotlk classic.
---@param itemLink string See https://wowpedia.fandom.com/wiki/ItemLink
---@return boolean exportItem true if item should be exported
function Env.TreatItemAsPossibleUpgrade(itemLink)
    if not IsEquippableItem(itemLink) then return false end

    local itemInfo = { GetItemInfo(itemLink) }
    local itemRarity = itemInfo[3]
    local itemLevel = itemInfo[4]
    local itemClassId = itemInfo[12]

    if Env.IS_CLASSIC_ERA then
        local minIlvl = UnitLevel("player") - 15
        if itemLevel <= minIlvl
            or itemRarity < Enum.ItemQuality.Good then
            return false
        end
    elseif Env.IS_CLASSIC_WRATH or Env.IS_CLASSIC_CATA then
        -- Ignore TBC items like Rocket Boots Xtreme (Lite). The ilvl limit is intentionally set low
        -- to limit accidental filtering.
        if itemLevel <= 112
            or itemRarity < Enum.ItemQuality.Rare then
            return false
        end
    end

    -- Ignore ammunition.
    if itemClassId == Enum.ItemClass.Projectile then
        return false
    end

    return true
end

---Check if stat1 is bigger than stat2.
---Accepts short (agi) or full stat names (agility)
---@param stat1 string
---@param stat2 string
---@return boolean
function Env.StatBiggerThanStat(stat1, stat2)
    local statId1 = statToStatId[stat1:lower()]
    local statId2 = statToStatId[stat2:lower()]
    assert(statId1 and statId2, "Invalid stat identifiers provided!")
    return select(2, UnitStat("player", statId1)) > select(2, UnitStat("player", statId2))
end

-- Some runes learn multiple spells, i.e. the learnedAbilitySpellIDs array of the
-- rune data returned by C_Engraving.GetRuneForEquipmentSlot and C_Engraving.GetRuneForInventorySlot
-- has multiple entries. The sim uses one of those Ids to indentify runes.
-- Map the first spell Id to the expected spell Id for runes that do not have it at position 1.
local runeSpellRemap = {
    [407993] = 407995, -- Mangle: The bear version is expected.
}

-- Ring Runes don't provide a Spell ID like other runes do. We have to convert the Enchant ID back to the Spell ID manually.
-- Ordered by spell name
local enchantmentIDToSpellID = {
    [7514] = 442893, -- Arcane Specialization
    [7508] = 442876, -- Axe Specialization
    [7510] = 442887, -- Dagger Specialization
    [7555] = 459312, -- Defense Specialization
    [7520] = 453622, -- Feral Combat Specialization
    [7515] = 442894, -- Fire Specialization
    [7511] = 442890, -- Fist Weapon Specialization
    [7516] = 442895, -- Frost Specialization
    [7519] = 442898, -- Holy Specialization
    [7509] = 442881, -- Mace Specialization
    [7517] = 442896, -- Nature Specialization
    [7513] = 442892, -- Pole Weapon Specialization
    [7512] = 442891, -- Ranged Weapon Specialization
    [7518] = 442897, -- Shadow Specialization
    [7507] = 442813, -- Sword Specialization
}

---Get rune spell from an item in a slot, if item has a rune engraved.
---@param slotId integer
---@param bagId integer|nil If not nil check bag items instead of equipped items.
---@return integer|nil abilitySpellId The first spell id granted by the rune, or nil if no rune engraved.
function Env.GetEngravedRuneSpell(slotId, bagId)
    -- After first login the whole engraving stuff may not be loaded yet!
    -- GetNumRunesKnown will return 0 for maximum runes available in that case.
    if select(2, C_Engraving.GetNumRunesKnown()) == 0 then
        LoadAddOn("Blizzard_EngravingUI")
        C_Engraving.RefreshRunesList()
    end

    -- The shoulder "runes" are special and don't use the C_Engraving API
    -- Instead they override a special spell "Soul Engraving" (1219955)
    if bagId == nil then
        if slotId == INVSLOT_SHOULDER then
            return FindSpellOverrideByID(1219955)
        end
    else
        local itemLocation = ItemLocation:CreateFromBagAndSlot(bagId, slotId)
        local inventoryType = C_Item.GetItemInventoryType(itemLocation)
        if inventoryType == Enum.InventoryType.IndexShoulderType then
            return Env.GetSoulEngravingSpellID(slotId, bagId)
        end
    end

    local runeData
    if bagId == nil then
        runeData = C_Engraving.GetRuneForEquipmentSlot(slotId)
    else
        runeData = C_Engraving.GetRuneForInventorySlot(bagId, slotId)
    end

    if runeData then
        local firstSpellId = runeData.learnedAbilitySpellIDs[1]
        if firstSpellId == nil then
            -- Fall back to re-mapping the enchant ID.
            -- Should only apply to ring specializations for now.
            return enchantmentIDToSpellID[runeData.itemEnchantmentID]
        else
            -- All non-ring runes should have a Spell ID
            if runeSpellRemap[firstSpellId] then
                return runeSpellRemap[firstSpellId]
            end
            return firstSpellId
        end
    end
end

---Counts spent talent points per tree.
---@param isInspect boolean If true use inspect target.
---@return table pointsPerTreeTable { tree1Count, tree2Count, tree3Count }
local function CountSpentTalentsPerTree(isInspect)
    local trees = {}

    for tab = 1, GetNumTalentTabs(isInspect) do
        trees[tab] = 0
        for i = 1, GetNumTalents(tab, isInspect) do
            local _, _, _, _, currentRank = GetTalentInfo(tab, i, isInspect)
            trees[tab] = trees[tab] + currentRank
        end
    end

    return trees
end

local specializations = {}

---Try to find spec. Returns empty strings if spec could not be found.
---@param unit string "player" or the inspected unit
---@return string specName The name of the spec, e.g. "feral".
---@return string specUrl The URL part of the spec, e.g. "feral_druid"
function Env.GetSpec(unit)
    local playerClass = select(2, UnitClass(unit))

    if specializations[playerClass] then
        if Env.IS_CLASSIC_MISTS then
            local activeSpec, specId
            if unit =="player" then
                activeSpec = C_SpecializationInfo.GetSpecialization()
                specId, _ = C_SpecializationInfo.GetSpecializationInfo(activeSpec)
            else
                specId = GetInspectSpecialization(unit)
            end
            for _, specData in pairs(specializations[playerClass]) do
                if specData.specId == specId then
                    return specData.spec, specData.url
                end
            end
        else
            local spentTalentPoints
            spentTalentPoints = CountSpentTalentsPerTree(unit == "target")
            for _, specData in pairs(specializations[playerClass]) do
                if specData.isCurrentSpec(spentTalentPoints) then
                    return specData.spec, specData.url
                end
            end
        end
    end

    return "", ""
end

---Add spec to detection list.
---@param playerClass string
---@param spec string The name of the spec, e.g. "feral".
---@param url string The URL part of the spec, e.g. "feral_druid"
---@param checkFunc fun(spentTanlents:number[]):boolean
---@param specId integer|nil The SpecializationID of the spec
function Env.AddSpec(playerClass, spec, url, checkFunc, specId)
    playerClass = playerClass:upper()
    specializations[playerClass] = specializations[playerClass] or {}
    table.insert(specializations[playerClass], {
        spec = spec,
        url = url,
        isCurrentSpec = checkFunc,
        specId = specId,
    })
end

CreateFrame("GameTooltip", "WSEScanningTooltip", nil, "GameTooltipTemplate")
WSEScanningTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

local baseItemLink = "item:9333:"
C_Item.RequestLoadItemDataByID(baseItemLink)

---@return table<integer, string>
local function GetBaseItemText()
    WSEScanningTooltip:ClearLines()
    WSEScanningTooltip:SetHyperlink(baseItemLink)
    local regions = { WSEScanningTooltip:GetRegions() }

    local itemText = {}

    for i = 1, #regions do
        local region = regions[i]
        if region and region:GetObjectType() == "FontString" then
            local text = region:GetText()
            if text then
                itemText[i] = text
            end
        end
    end

    return itemText
end

local baseItemText

---Get the localized text of a given enchantID as it will appear in an tooltip
---@param enchantID integer
---@return string
function Env.GetEnchantText(enchantID)
    if not baseItemText then
        baseItemText = GetBaseItemText()
    end

    WSEScanningTooltip:ClearLines()
    WSEScanningTooltip:SetHyperlink(baseItemLink .. enchantID)
    local regions = { WSEScanningTooltip:GetRegions() }

    for i = 1, #regions do
        local region = regions[i]
        if region and region:GetObjectType() == "FontString" then
            local text = region:GetText()
            if text and baseItemText[i] ~= text then
                return text
            end
        end
    end

    return ""
end

---Parse current item upgrade level from item tooltip.
---@param unit string
---@param itemSlot integer
---@return integer
function Env.GetItemUpgradeLevel(unit, itemSlot)
    WSEScanningTooltip:ClearLines()
    WSEScanningTooltip:SetInventoryItem(unit, itemSlot)
    local regions = { WSEScanningTooltip:GetRegions() }

    for i = 1, #regions do
        local region = regions[i]
        if region and region:GetObjectType() == "FontString" then
            local text = region:GetText()
            if text and text:find(ITEM_UPGRADE_TOOLTIP_FORMAT) then
                local pattern, _ = ITEM_UPGRADE_TOOLTIP_FORMAT:gsub("%%d","%(%%d%)")
                local _, _, curLevel, maxLevel = text:find(pattern)
                return tonumber(curLevel)
            end
        end
    end
    return -1
end


---Parse hand tinker from item tooltip.
---@param unit string
---@return integer
function Env.GetHandTinker(unit)
    WSEScanningTooltip:ClearLines()
    WSEScanningTooltip:SetInventoryItem(unit, INVSLOT_HAND)
    local regions = { WSEScanningTooltip:GetRegions() }

    local use_localized = ITEM_SPELL_TRIGGER_ONUSE
    local cooldown_m_localized = ITEM_COOLDOWN_TOTAL_MIN
    local cooldown_s_localized = ITEM_COOLDOWN_TOTAL_SEC

    for i = 1, #regions do
        local region = regions[i]
        if region and region:GetObjectType() == "FontString" then
            local text = region:GetText()
            -- some client have wierd character as separator, so hopefuly .?.? picks them all
            if text and text:find(use_localized..".+1.?.?920.+"..cooldown_m_localized) then
                return 4898 -- Synapse Srping
            end
            if text and text:find(use_localized..".+2.?.?880.+"..cooldown_m_localized) then
                return 4697 -- Phase Fingers
            end
            if text and text:find(use_localized..".+42.?.?000.+63.?.?000.+"..cooldown_s_localized) then
                return 4698 -- Incendiary Fireworks Launcher
            end
        end
    end
    return 0
end
