-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSLoot = private.NewLib("RareScannerLoot")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSLootDB = private.ImportLib("RareScannerLootDB")
local RSCollectionsDB = private.ImportLib("RareScannerCollectionsDB")

-- RareScanner general libraries
local RSLogger = private.ImportLib("RareScannerLogger")
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSTooltipScanners = private.ImportLib("RareScannerTooltipScanners")

---============================================================================
-- Class proficiencies and general functions to check if a class can wear an specific item
---============================================================================

private.CLASS_PROFICIENCIES = {
	[1] = { --Warrior
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Fishingpole, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Generic },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield, Enum.ItemArmorSubclass.Cosmetic, Enum.ItemArmorSubclass.Generic, Enum.ItemArmorSubclass.Relic }
	};
	[2] = { --Paladin
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Fishingpole, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Generic },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield, Enum.ItemArmorSubclass.Cosmetic, Enum.ItemArmorSubclass.Generic, Enum.ItemArmorSubclass.Relic }
	};
	[3] = { --Hunter
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Fishingpole, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Generic },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Mail, Enum.ItemArmorSubclass.Cosmetic, Enum.ItemArmorSubclass.Generic, Enum.ItemArmorSubclass.Relic }
	};
	[4] = { --Rogue
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Fishingpole, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Generic },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Leather, Enum.ItemArmorSubclass.Cosmetic, Enum.ItemArmorSubclass.Generic, Enum.ItemArmorSubclass.Relic }
	};
	[5] = { --Priest
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Fishingpole, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Wand },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Cloth, Enum.ItemArmorSubclass.Cosmetic, Enum.ItemArmorSubclass.Generic, Enum.ItemArmorSubclass.Relic }
	};
	[6] = { --DeathKnight
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Fishingpole, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Generic },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Cosmetic, Enum.ItemArmorSubclass.Generic, Enum.ItemArmorSubclass.Relic }
	};
	[7] = { --Shaman
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Fishingpole, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Generic },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Mail, Enum.ItemArmorSubclass.Shield, Enum.ItemArmorSubclass.Cosmetic, Enum.ItemArmorSubclass.Generic, Enum.ItemArmorSubclass.Relic }
	};
	[8] = { --Mage
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Fishingpole, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Wand },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Cloth, Enum.ItemArmorSubclass.Cosmetic, Enum.ItemArmorSubclass.Generic, Enum.ItemArmorSubclass.Relic }
	};
	[9] = { --Warlock
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Fishingpole, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Wand },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Cloth, Enum.ItemArmorSubclass.Cosmetic, Enum.ItemArmorSubclass.Generic, Enum.ItemArmorSubclass.Relic }
	};
	[11] = { --Druid
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Fishingpole, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Generic },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Leather, Enum.ItemArmorSubclass.Cosmetic, Enum.ItemArmorSubclass.Generic, Enum.ItemArmorSubclass.Relic }
	};
}

local function IsEquipable(itemClassID, itemSubClassID, itemEquipLoc)
	-- It cloack can always wear a cloack
	if (itemEquipLoc == "INVTYPE_CLOAK") then
		return true;
	end
	
	-- Otherwise check proficiency
	local _, _, classIndex = UnitClass("player")
	if (RSUtils.Contains(private.CLASS_PROFICIENCIES[classIndex][itemClassID], itemSubClassID)) then
		return true;
	else
		return false;
	end
end

---============================================================================
-- Filters to apply to the loot displayed under the main button and the worldmap
---============================================================================

local function IsToy(itemLink, itemID)
	if (RSLootDB.IsToy(itemID)) then
		return true
	elseif (RSTooltipScanners.ScanLoot(itemLink, TOY)) then
		RSLootDB.SetItemAsToy(itemID)
		return true
	end
end

local function IsFilteredByCategory(itemLink, itemID, itemClassID, itemSubClassID)
	-- If filtered by category
	if (RSConfigDB.GetLootFilterByCategory(itemClassID, itemSubClassID) == false) then
		-- We ignore toys from this filter because they are scattered all around
		if (IsToy(itemLink, itemID)) then
			return false
		end
		
		return true
	end
	
	return false
end

local function IsCollectionFiltered(type, entityID, itemID)
	local items = RSCollectionsDB.GetEntityCollectionsLoot(entityID, type)
	if (RSUtils.Contains(items, itemID)) then
		return false
	end
	
	RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por estar ya conseguido o estar filtrado en el explorador", itemID))
	return true
end

function RSLoot.IsFiltered(entityID, itemID, itemLink, itemRarity, itemEquipLoc, itemClassID, itemSubClassID)
	-- Quality filter
	if (itemRarity < tonumber(RSConfigDB.GetLootFilterMinQuality())) then
		RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por su calidad.", itemID))
		return true
	end
	
	-- Individual filter
	if (RSConfigDB.GetItemFiltered(itemID)) then
		RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado individualmente.", itemID))
		return true
	end

	-- Completed quests
	if (RSConfigDB.IsFilteringLootByCompletedQuest() and (itemClassID == Enum.ItemClass.Questitem or (itemClassID == Enum.ItemClass.Consumable and itemSubClassID == 8))) then --quest item
		local questIDs = RSLootDB.GetAssociatedQuestIDs(itemID)
		if (questIDs) then
			local filtered = false
			for i, questID in ipairs(questIDs) do
				if (C_QuestLog.IsQuestFlaggedCompleted(questID) or not C_TaskQuest.IsActive(questID)) then
					filtered = true
				else
					filtered = false
					break
				end
			end

			if (filtered) then
				RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por su mision asociada.", itemID))
				return true;
			end
		end
	end

	-- Equipable filter
	if (RSConfigDB.IsFilteringLootByNotEquipableItems() and (itemClassID == Enum.ItemClass.Weapon or itemClassID == Enum.ItemClass.Armor)) then --weapons or armor
		if (not IsEquipable(itemClassID, itemSubClassID, itemEquipLoc)) then
			RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por no ser equipable.", itemID))
			return true;
		end
	end

	-- Character class filter
	if (RSConfigDB.IsFilteringLootByNotMatchingClass() and RSTooltipScanners.ScanLoot(itemLink, string.gsub(ITEM_CLASSES_ALLOWED, ": %%s", ""))) then
		local localizedClass, _, _ = UnitClass("player")
		if (not RSTooltipScanners.ScanLoot(itemLink, localizedClass)) then
			RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por clase.", itemID))
			return true;
		end
	end

	-- Character faction filter
	if (RSConfigDB.IsFilteringLootByNotMatchingFaction()) then
		local _, localizedFaction = UnitFactionGroup("player")
		if ((RSTooltipScanners.ScanLoot(itemLink, ITEM_REQ_ALLIANCE) and localizedFaction ~= FACTION_ALLIANCE) or (RSTooltipScanners.ScanLoot(itemLink, ITEM_REQ_HORDE) and localizedFaction ~= FACTION_HORDE)) then
			RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por facción.", itemID))
			return true;
		end
	end
	
	-- Filter by explorer results
	if (RSConfigDB.IsFilteringByExplorerResults() and RSUtils.GetTableLength(RSCollectionsDB.GetAllEntitiesCollectionsLoot()) > 0) then
		return IsCollectionFiltered(RSConstants.ITEM_SOURCE.NPC, entityID, itemID) and IsCollectionFiltered(RSConstants.ITEM_SOURCE.CONTAINER, entityID, itemID)
	end

	-- Category filter
	if (not RSConfigDB.IsFilteringByExplorerResults() and IsFilteredByCategory(itemLink, itemID, itemClassID, itemSubClassID)) then
		RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por su categoria.", itemID))
		return true
	end
	
	return false
end
