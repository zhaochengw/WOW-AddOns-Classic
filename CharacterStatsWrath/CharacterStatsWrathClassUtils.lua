--[[
    Util functions specific for Classes
]]

-- returns the spell hit from Arcane Focus talents
function CSC_GetMageSpellHitFromTalents()
	local arcaneHit = 0;

	-- Arcane Focus, 1% for each point
	local spellRank = select(5, GetTalentInfo(1, 3));
	arcaneHit = spellRank;

	return arcaneHit
end

-- return the spell hit from Shadow Focus
function CSC_GetPriestSpellHitFromTalents()
	local spellRank = select(5, GetTalentInfo(3, 3));
	
	return spellRank;
end

-- returns the spell hit from Elemental Precision
function CSC_GetShamanHitFromTalents()
	local spellRank = select(5, GetTalentInfo(1, 16));

	return spellRank;
end

-- returns the bonus crit from the Call of Thunder talent for Shamans
function CSC_GetShamanCallOfThunderCrit()
	-- Call of Thunder (Lightning), 5% per a single point
	local spellRank = select(5, GetTalentInfo(1, 2));
	return spellRank * 5;
end

-- returns the bonus crit from the Tidal Mastery telent for Shamans
function CSC_GetShamanTidalMasteryCrit()
	-- Tidal Mastery (Nature/Lightning), 1% per each point
	local spellRank = select(5, GetTalentInfo(3, 12));
	return spellRank;
end

-- returns the spell crit from Devastation talent
function CSC_GetWarlockCritStatsFromTalents()
	-- the spell rank is equal to the value, 5% per a single point
	local devastationCrit = select(5, GetTalentInfo(3, 11));

	return devastationCrit * 5;
end



-- returns the healing modifier from Spiritual Healing talent for Priests
function CSC_GetPriestBonusHealingModifierFromTalents()
	-- Spiritual Healing
	local spellRank = select(5, GetTalentInfo(2, 15));
	return spellRank * 0.02;
end

-- returns the modifier from Improved Blessing of Wisdom Holy talent
function CSC_GetPaladinImprovedBoWModifier()
	-- Improved Blessing of Wisdom
	local spellRank = select(5, GetTalentInfo(1, 10));

	return spellRank * 0.1;
end

-- Checks if spellId is Blessing of Wisdom
function CSC_IsBoWSpellId(spellId)

	if (spellId == 19742 or spellId == 19850 or spellId == 19852 or spellId == 19853 or spellId == 19854 or spellId == 25290 or spellId == 27142 or spellId == 25894 or spellId == 25918 or spellId == 27143) then
		return true;
	end

	return false;
end

-- returns the shapeshift form index for druids
function CSC_GetShapeshiftForm()
	local shapeIndex = 0;

	for possibleForm=1, GetNumShapeshiftForms() do
		if select(2, GetShapeshiftFormInfo(possibleForm)) then
			shapeIndex = possibleForm;
		end
	end

	return shapeIndex;
end





-- ITEMS AND ENCHANTS RELATED
function CSC_GetMP5ModifierFromTalents(unit)
    local unitClassId = select(3, UnitClass(unit));
	local spellRank = 0;

	-- All of these spells have 3 ranks (10%, 20%, 30%)
	if unitClassId == CSC_PRIEST_CLASS_ID then
		-- Meditation
        spellRank = select(5, GetTalentInfo(1, 9));
	elseif unitClassId == CSC_MAGE_CLASS_ID then
		-- Arcane Meditation
		spellRank = select(5, GetTalentInfo(1, 12));
	elseif unitClassId == CSC_DRUID_CLASS_ID then
		-- Intensity
        spellRank = select(5, GetTalentInfo(3, 6));
	end
	
	local modifier = spellRank * 0.1;

    return modifier;
end

function CSC_GetMP5FromSetBonus(unit)
	local unitClassId = select(3, UnitClass(unit));
	local mp5 = 0;
	
	-- not Druid or Priest
	if unitClassId ~= CSC_DRUID_CLASS_ID and unitClassId ~= CSC_PRIEST_CLASS_ID then
		return mp5;
	end
	
	local firstItemslotIndex = 1;
	local lastItemslotIndex = 18;

	local equippedSetItems = 0;
    for itemSlot = firstItemslotIndex, lastItemslotIndex do
        local itemId = GetInventoryItemID(unit, itemSlot);
		
		if (itemId) then
			if (itemId == g_VestmentsOfTranscendenceIds[itemId] or itemId == g_StormrageRaimentIds[itemId]) then
				equippedSetItems = equippedSetItems + 1;
			end
		end
    end

    if equippedSetItems >= 3 then
        mp5 = 20;
	end

    return mp5;
end

function CSC_GetMP5ModifierFromSetBonus(unit)
	local unitClassId = select(3, UnitClass(unit));
	local modifier = 0;

	if unitClassId ~= CSC_DRUID_CLASS_ID and unitClassId ~= CSC_PRIEST_CLASS_ID  and unitClassId ~= CSC_PALADIN_CLASS_ID and unitClassId ~= CSC_SHAMAN_CLASS_ID then
		return modifier;
	end

	local firstItemslotIndex = 1;
	local lastItemslotIndex = 18;

	local equippedSetItems = 0;
    for itemSlot = firstItemslotIndex, lastItemslotIndex do
        local itemId = GetInventoryItemID(unit, itemSlot);
		
		if (itemId) then
			if (itemId == g_PrimalMooncloth[itemId]) then
				equippedSetItems = equippedSetItems + 1;
			end
		end
    end

    if equippedSetItems >= 3 then
        modifier = 0.05;
	end

    return modifier;
end

function CSC_GetBlockValueFromWarriorZGEnchants(unit)
	local blockValue = 0;

	if CSC_HasEnchant(unit, INVSLOT_HEAD, 2583) then
		blockValue = blockValue + 15;
	end

	if CSC_HasEnchant(unit, INVSLOT_LEGS, 2583) then
		blockValue = blockValue + 15;
	end

	return blockValue;
end

function CSC_GetMp5FromPriestZGEnchants(unit)
	local mp5 = 0;

	if CSC_HasEnchant(unit, INVSLOT_HEAD, 2590) then
		mp5 = mp5 + 4;
	end

	if CSC_HasEnchant(unit, INVSLOT_LEGS, 2590) then
		mp5 = mp5 + 4;
	end

	return mp5;
end
