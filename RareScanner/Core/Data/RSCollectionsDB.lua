-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local LibDialog = LibStub("LibDialog-1.0RS")

local RSCollectionsDB = private.NewLib("RareScannerCollectionsDB")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSAchievementDB = private.ImportLib("RareScannerAchievementDB")

-- RareScanner libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSRoutines = private.ImportLib("RareScannerRoutines")
local RSTooltipScanners = private.ImportLib("RareScannerTooltipScanners")

---============================================================================
-- Transmog locations (added in 9.2.5)
---============================================================================

local TRANSMOG_LOCATIONS = {
	["HEADSLOT"] = { Enum.TransmogCollectionType.Head };
	["SHOULDERSLOT"] = { Enum.TransmogCollectionType.Shoulder };
	["BACKSLOT"] = { Enum.TransmogCollectionType.Back };
	["CHESTSLOT"] = { Enum.TransmogCollectionType.Chest };
	["SHIRTSLOT"] = { Enum.TransmogCollectionType.Shirt };
	["TABARDSLOT"] = { Enum.TransmogCollectionType.Tabard };
	["WRISTSLOT"] = { Enum.TransmogCollectionType.Wrist };
	["HANDSSLOT"] = { Enum.TransmogCollectionType.Hands };
	["WAISTSLOT"] = { Enum.TransmogCollectionType.Waist };
	["LEGSSLOT"] = { Enum.TransmogCollectionType.Legs };
	["FEETSLOT"] = { Enum.TransmogCollectionType.Feet };
	["MAINHANDSLOT"] = { Enum.TransmogCollectionType.Wand, Enum.TransmogCollectionType.OneHAxe, Enum.TransmogCollectionType.OneHSword, Enum.TransmogCollectionType.OneHMace, Enum.TransmogCollectionType.Dagger, Enum.TransmogCollectionType.Fist, Enum.TransmogCollectionType.TwoHAxe, Enum.TransmogCollectionType.TwoHSword, Enum.TransmogCollectionType.TwoHMace, Enum.TransmogCollectionType.Staff, Enum.TransmogCollectionType.Polearm, Enum.TransmogCollectionType.Bow, Enum.TransmogCollectionType.Gun, Enum.TransmogCollectionType.Crossbow, Enum.TransmogCollectionType.Warglaives, Enum.TransmogCollectionType.Paired };
	["SECONDARYHANDSLOT"] = { Enum.TransmogCollectionType.Shield, Enum.TransmogCollectionType.Holdable };
}

local CLASS_MISSING_APPEARNACES = {
	[1] = { --Warrior
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Fishingpole },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield }
	};
	[2] = { --Paladin
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Fishingpole },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield }
	};
	[3] = { --Hunter
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Fishingpole },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Mail }
	};
	[4] = { --Rogue
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow,  Enum.ItemWeaponSubclass.Fishingpole },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Leather }
	};
	[5] = { --Priest
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Wand, Enum.ItemWeaponSubclass.Fishingpole },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Cloth }
	};
	[6] = { --DeathKnight
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Fishingpole },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Plate }
	};
	[7] = { --Shaman
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Fishingpole },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Mail, Enum.ItemArmorSubclass.Shield }
	};
	[8] = { --Mage
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Wand, Enum.ItemWeaponSubclass.Fishingpole },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Cloth }
	};
	[9] = { --Warlock
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Wand, Enum.ItemWeaponSubclass.Fishingpole },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Cloth }
	};
	[10] = { --Monk
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Fishingpole },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Leather }
	};
	[11] = { --Druid
		[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Fishingpole },
		[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Leather }
	};
}

---============================================================================
-- Auxiliar functions
---============================================================================

local function PlayerCanUseItem(itemID)
	local _, _, classIndex = UnitClass("player");
	local _, _, _, itemEquipLoc, _, classID, subclassID = C_Item.GetItemInfoInstant(itemID)
	
	-- If cloak
	if (itemEquipLoc == Enum.InventoryType.IndexCloakType) then
		return true
	end
	
	-- If weapon or armor
	if (CLASS_MISSING_APPEARNACES[classIndex][classID] and RSUtils.Contains(CLASS_MISSING_APPEARNACES[classIndex][classID], subclassID)) then
		return true
	end
	
	return false
end

---============================================================================
-- Manage database
---============================================================================

local function ResetEntitiesCollectionsLoot()
	if (not private.dbglobal.entity_collections_loot) then
		private.dbglobal.entity_collections_loot = {}
	else
		local _, _, classIndex = UnitClass("player");
		for _, source in pairs (RSConstants.ITEM_SOURCE) do
			if (private.dbglobal.entity_collections_loot[source]) then
				for entityID, itemTypes in pairs (private.dbglobal.entity_collections_loot[source]) do
					for itemType, _ in pairs (private.dbglobal.entity_collections_loot[source][entityID]) do
						if (itemType ~= RSConstants.ITEM_TYPE.APPEARANCE) then
							private.dbglobal.entity_collections_loot[source][entityID][itemType] = nil
						else
							for classID, _ in pairs (private.dbglobal.entity_collections_loot[source][entityID][itemType]) do
								if (classID == classIndex) then
									private.dbglobal.entity_collections_loot[source][entityID][itemType][classIndex] = nil
								end
							end
							
							if (RSUtils.GetTableLength(private.dbglobal.entity_collections_loot[source][entityID][itemType][classIndex]) == 0) then
								private.dbglobal.entity_collections_loot[source][entityID][itemType][classIndex] = nil
							end
						end
						
						if (RSUtils.GetTableLength(private.dbglobal.entity_collections_loot[source][entityID][itemType]) == 0) then
							private.dbglobal.entity_collections_loot[source][entityID][itemType] = nil
						end
					end
					
					if (RSUtils.GetTableLength(private.dbglobal.entity_collections_loot[source][entityID]) == 0) then
						private.dbglobal.entity_collections_loot[source][entityID] = nil
					end
				end
				
				if (RSUtils.GetTableLength(private.dbglobal.entity_collections_loot[source]) == 0) then
					private.dbglobal.entity_collections_loot[source] = nil
				end
			end
		end
	end
end

local function UpdateEntityCollection(itemID, entityID, source, itemType)
	if (not RSCollectionsDB.GetAllEntitiesCollectionsLoot()) then
		 ResetEntitiesCollectionsLoot()
	end
	
	if (not RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source]) then
		RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source] = {}
	end
	
	if (not RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID]) then
		RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID] = {}
	end
	
	if (not RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][itemType]) then
		RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][itemType] = {}
	end
	
	if (itemType == RSConstants.ITEM_TYPE.APPEARANCE) then
		local _, _, classIndex = UnitClass("player");
		if (not RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][itemType][classIndex]) then
			RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][itemType][classIndex] = {}
		end
		
		if (not RSUtils.Contains(RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][itemType][classIndex], itemID)) then
			table.insert(RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][itemType][classIndex], itemID)
		end
	elseif (not RSUtils.Contains(RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][itemType], itemID)) then
		table.insert(RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][itemType], itemID)
	end
end

---============================================================================
-- Toys
---============================================================================

local function UpdateNotCollectedToys(routines, routineTextOutput)
	-- Backup settings
	local collectedShown = C_ToyBox.GetCollectedShown();
	local uncollectedShown = C_ToyBox.GetUncollectedShown();
	local unusableShown = C_ToyBox.GetUnusableShown();
	
	-- Prepare filters
	C_ToyBox.SetCollectedShown(false);
	C_ToyBox.SetUncollectedShown(true);
	C_ToyBox.SetUnusableShown(true);
	C_ToyBox.SetAllExpansionTypeFilters(true);
	C_ToyBox.SetFilterString("");
		
	for i=1,C_PetJournal.GetNumPetSources() do
		if (i == 1) then
			C_ToyBox.SetSourceTypeFilter(i, true) -- Drop source
		else
			C_ToyBox.SetSourceTypeFilter(i, false) -- Other source
		end
	end
	
	private.dbglobal.not_colleted_toys = {}
	
	-- Query
	local notCollectedToyRoutine = RSRoutines.LoopIndexRoutineNew()
	notCollectedToyRoutine:Init(C_ToyBox.GetNumFilteredToys, 50, 
		function(context, i)
			local toyID = C_ToyBox.GetToyFromIndex(i)
			local itemID, _, _, _, _, _ = C_ToyBox.GetToyInfo(toyID)
			tinsert(private.dbglobal.not_colleted_toys, itemID)
		end,
		function(context)
			-- Restore settings
			C_ToyBox.SetCollectedShown(collectedShown);
			C_ToyBox.SetUncollectedShown(uncollectedShown);
			C_ToyBox.SetUnusableShown(unusableShown);
			C_ToyBox.SetAllExpansionTypeFilters(true);
			C_ToyBox.SetAllSourceTypeFilters(true);
			
			RSLogger:PrintDebugMessage(string.format("UpdateNotCollectedToys. [%s no conseguidos].", RSUtils.GetTableLength(private.dbglobal.not_colleted_toys)))
			
			if (routineTextOutput) then
				routineTextOutput:SetText(string.format(AL["EXPLORER_MISSING_TOYS"], RSUtils.GetTableLength(private.dbglobal.not_colleted_toys)))
			end
		end
	)
	table.insert(routines, notCollectedToyRoutine)
end

local function GetNotCollectedToys()
	return private.dbglobal.not_colleted_toys
end

local function CheckUpdateToy(itemID, entityID, source, checkedItems)
	-- If cached use it
	if (checkedItems[RSConstants.ITEM_TYPE.TOY][itemID]) then
		UpdateEntityCollection(itemID, entityID, source, RSConstants.ITEM_TYPE.TOY)
	else
		if (RSUtils.Contains(GetNotCollectedToys(), itemID)) then
			UpdateEntityCollection(itemID, entityID, source, RSConstants.ITEM_TYPE.TOY)
			checkedItems[RSConstants.ITEM_TYPE.TOY][itemID] = true
			return true
		end
	
		return false
	end
end

function RSCollectionsDB.RemoveNotCollectedToy(itemID, callback) --NEW_TOY_ADDED
	if (itemID and GetNotCollectedToys() and table.getn(GetNotCollectedToys()) ~= nil) then		
		-- Drop missing toy
		for i = #private.dbglobal.not_colleted_toys, 1, -1 do
    		if (private.dbglobal.not_colleted_toys[i] == itemID) then
       			table.remove(private.dbglobal.not_colleted_toys, i)
				RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedToy[%s]: Eliminado coleccionable conseguido.", itemID))
       			break
       		end
		end
		
		-- Update filters
		if (not RSCollectionsDB.GetAllEntitiesCollectionsLoot()) then
			return
		end
		
		local refresh = false
		for source, info in pairs (RSCollectionsDB.GetAllEntitiesCollectionsLoot()) do
			for entityID, itemTypes in pairs (RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source]) do
				local lootList = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][RSConstants.ITEM_TYPE.TOY]
				if (lootList) then
					for i = #lootList, 1, -1 do
						if (lootList[i] == itemID) then
							if (table.getn(lootList) == 1) then
								RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedToy[%s]: Eliminado coleccionable de la lista de la entidad [%s]. No tiene mas juguetes.", itemID, entityID))
								RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][RSConstants.ITEM_TYPE.TOY] = nil
							else
								RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedToy[%s]: Eliminado coleccionable de la lista de la entidad [%s].", itemID, entityID))
								table.remove(lootList, i)
							end
							
							-- Check if the entity doesn't have more collections
							if (RSUtils.GetTableLength(RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID]) == 0) then
								RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID] = nil
								
								-- Filter
								if (RSConfigDB.IsAutoFilteringOnCollect()) then
									if (source == RSConstants.ITEM_SOURCE.NPC) then
										RSConfigDB.SetNpcFiltered(entityID)
										RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedToy[%s]: Filtrado NPC [%s] por no disponer de mas coleccionables.", itemID, entityID))
										if (RSNpcDB.GetNpcName(entityID)) then
											RSLogger:PrintMessage(string.format(AL["EXPLORER_AUTOFILTER"], RSNpcDB.GetNpcName(entityID)))
										end
									elseif (source == RSConstants.ITEM_SOURCE.CONTAINER) then
										RSConfigDB.SetContainerFiltered(entityID)
										RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedToy[%s]: Filtrado Contenedor [%s] por no disponer de mas coleccionables.", itemID, entityID))
										if (RSContainerDB.GetContainerName(entityID)) then
											RSLogger:PrintMessage(string.format(AL["EXPLORER_AUTOFILTER"], RSContainerDB.GetContainerName(entityID)))
										end
									end
								end
							end
							
							refresh = true
							break
						end
					end
				end
			end
		end
		
		if (refresh and callback) then
			callback()
		end
    end
end

---============================================================================
-- Pets
---============================================================================

local function UpdateNotCollectedPetIDs(routines, routineTextOutput)
	-- Backup settings
	local filterCollected = C_PetJournal.IsFilterChecked(LE_PET_JOURNAL_FILTER_COLLECTED)
	local filterNotCollected = C_PetJournal.IsFilterChecked(LE_PET_JOURNAL_FILTER_NOT_COLLECTED)
	
	-- Prepare filters
	C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_COLLECTED, false)
	C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_NOT_COLLECTED, true)
	C_PetJournal.SetAllPetTypesChecked(true)
	C_PetJournal.ClearSearchFilter()
	
	for i=1,C_PetJournal.GetNumPetSources() do
		if (i == 1) then
			C_PetJournal.SetPetSourceChecked(i, true) -- Drop source
		else
			C_PetJournal.SetPetSourceChecked(i, false) -- Other source
		end
	end
	
	private.dbglobal.not_colleted_pets_ids = {}
	
	-- Query
	local notCollectedPetIDs = RSRoutines.LoopIndexRoutineNew()
	notCollectedPetIDs:Init(C_PetJournal.GetNumPets, 50, 
		function(context, i)
			local _, _, _, _, _, _, _, _, _, _, companionID, _, _, _, _, _, _, _ = C_PetJournal.GetPetInfoByIndex(i)
			-- The first parameter is the petID but for some reason it comes nil, so we must use the companionID
			if (companionID) then
				table.insert(private.dbglobal.not_colleted_pets_ids, companionID)
			end
		end,
		function(context)
			-- Restore settings
			C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_COLLECTED, filterCollected)
			C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_NOT_COLLECTED, filterNotCollected)
			C_PetJournal.SetAllPetSourcesChecked(true)
			
			RSLogger:PrintDebugMessage(string.format("UpdateNotCollectedPetIDs. [%s no conseguidas].", RSUtils.GetTableLength(private.dbglobal.not_colleted_pets_ids)))
			
			if (routineTextOutput) then
				routineTextOutput:SetText(string.format(AL["EXPLORER_MISSING_PETS"], RSUtils.GetTableLength(private.dbglobal.not_colleted_pets_ids)))
			end
		end
	)
	table.insert(routines, notCollectedPetIDs)	
end

local function GetNotCollectedPetsIDs()
	return private.dbglobal.not_colleted_pets_ids
end

local function GetPetItemID(creatureID)
	if (creatureID) then
		return private.DROPPED_PET_IDS[creatureID]
	end
	
	return nil
end

function RSCollectionsDB.GetCreatureID(itemID)
	if (itemID) then
		for creatureID, internalItemID in pairs(private.DROPPED_PET_IDS) do
			if (internalItemID == itemID) then
				return creatureID
			end
		end
	end
	
	return nil
end

local function CheckUpdatePet(itemID, entityID, source, checkedItems)
	-- If cached use it
	if (checkedItems[RSConstants.ITEM_TYPE.PET][itemID]) then
		UpdateEntityCollection(itemID, entityID, source, RSConstants.ITEM_TYPE.PET)
	else
		local creatureID = RSCollectionsDB.GetCreatureID(itemID)
		if (creatureID) then			
			if (RSUtils.Contains(GetNotCollectedPetsIDs(), creatureID)) then
				UpdateEntityCollection(itemID, entityID, source, RSConstants.ITEM_TYPE.PET)
				checkedItems[RSConstants.ITEM_TYPE.PET][itemID] = true
			end
			
			return true
		end
		
		return false
	end
end

function RSCollectionsDB.RemoveNotCollectedPet(petGUID, callback) --NEW_PET_ADDED
	if (petGUID and GetNotCollectedPetsIDs() and table.getn(GetNotCollectedPetsIDs()) ~= nil) then
		local _, _, _, _, _, _, _, _, _, _, creatureID, _, _, _, _, _, _, _ = C_PetJournal.GetPetInfoByPetID(petGUID)
		if (not creatureID) then
			RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedPet[%s]: No se ha localizado el creatureID asociado.", petGUID))
			return
		end
		
		-- Drop missing pet
		for i = #private.dbglobal.not_colleted_pets_ids, 1, -1 do
    		if (private.dbglobal.not_colleted_pets_ids[i] == creatureID) then
       			table.remove(private.dbglobal.not_colleted_pets_ids, i)
				RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedPet[%s]: Eliminado coleccionable conseguido.", petGUID))
       			break
       		end
		end
		
		-- Update filters
		if (not RSCollectionsDB.GetAllEntitiesCollectionsLoot()) then
			return
		end
		
		local refresh = false
		for source, info in pairs (RSCollectionsDB.GetAllEntitiesCollectionsLoot()) do
			for entityID, itemTypes in pairs (RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source]) do
				local lootList = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][RSConstants.ITEM_TYPE.PET]
				if (lootList) then
					for i = #lootList, 1, -1 do
						if (lootList[i] == GetPetItemID(creatureID)) then
							if (table.getn(lootList) == 1) then
								RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedPet[%s]: Eliminado coleccionable de la lista de la entidad [%s]. No tiene mas mascotas.", petGUID, entityID))
								RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][RSConstants.ITEM_TYPE.PET] = nil
							else
								RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedPet[%s]: Eliminado coleccionable de la lista de la entidad [%s].", petGUID, entityID))
								table.remove(lootList, i)
							end
							
							-- Check if the entity doesn't have more collections
							if (RSUtils.GetTableLength(RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID]) == 0) then
								RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID] = nil
								
								-- Filter
								if (RSConfigDB.IsAutoFilteringOnCollect()) then
									if (source == RSConstants.ITEM_SOURCE.NPC) then
										RSConfigDB.SetNpcFiltered(entityID)
										RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedPet[%s]: Filtrado NPC [%s] por no disponer de mas coleccionables.", petGUID, entityID))
										if (RSNpcDB.GetNpcName(entityID)) then
											RSLogger:PrintMessage(string.format(AL["EXPLORER_AUTOFILTER"], RSNpcDB.GetNpcName(entityID)))
										end
									elseif (source == RSConstants.ITEM_SOURCE.CONTAINER) then
										RSConfigDB.SetContainerFiltered(entityID)
										RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedPet[%s]: Filtrado Contenedor [%s] por no disponer de mas coleccionables.", petGUID, entityID))
										if (RSContainerDB.GetContainerName(entityID)) then
											RSLogger:PrintMessage(string.format(AL["EXPLORER_AUTOFILTER"], RSContainerDB.GetContainerName(entityID)))
										end
									end
								end
							end
							
							refresh = true
							break
						end
					end
				end
			end
		end
		
		if (refresh and callback) then
			callback()
		end
    end
end

---============================================================================
-- Mounts
---============================================================================

local function UpdateNotCollectedMountIDs(routines, routineTextOutput)
	-- Backup settings
	local colletedFilter = C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED)
	local notColletedFilter = C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED)
	local notUnusableFilter = C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_UNUSABLE)
	
	-- Prepare filters
	C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED, false);
	C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED, true);
	C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_UNUSABLE, true);
	C_MountJournal.SetSearch("");
	C_MountJournal.SetAllSourceFilters(true)
	C_MountJournal.SetAllTypeFilters(true)
	
	private.dbglobal.not_colleted_mounts_ids = {}
		
	-- Query
	local notCollectedMountIDs = RSRoutines.LoopIndexRoutineNew()
	notCollectedMountIDs:Init(C_MountJournal.GetNumMounts, 50, 
		function(context, i)
			local name, _, _, _, _, _, _, _, _, _, _, mountID = C_MountJournal.GetDisplayedMountInfo(i);
			if (mountID) then
				table.insert(private.dbglobal.not_colleted_mounts_ids, mountID)
			end
		end,
		function(context)			
			-- Recover settings
			C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED, colletedFilter);
			C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED, notColletedFilter);
			C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_UNUSABLE, notUnusableFilter);
			
			-- Process hidden mounts
			for _, mountID in ipairs (private.HIDDEN_MOUNT_IDS) do
				local name, _, _, _, _, _, _, _, _, _, isCollected, _ = C_MountJournal.GetMountInfoByID(mountID)
				if (not isCollected) then
					table.insert(private.dbglobal.not_colleted_mounts_ids, mountID)
				end
			end
			
			RSLogger:PrintDebugMessage(string.format("UpdateNotCollectedMountIDs. [%s no conseguidas].", RSUtils.GetTableLength(private.dbglobal.not_colleted_mounts_ids)))
			
			if (routineTextOutput) then
				routineTextOutput:SetText(string.format(AL["EXPLORER_MISSING_MOUNTS"], RSUtils.GetTableLength(private.dbglobal.not_colleted_mounts_ids)))
			end
		end
	)
	table.insert(routines, notCollectedMountIDs)
end

local function GetNotCollectedMountsIDs()
	return private.dbglobal.not_colleted_mounts_ids
end

local function GetMountItemID(mountID)
	if (mountID) then
		return private.DROPPED_MOUNT_IDS[mountID]
	end
	
	return nil
end

local function GetMountID(itemID)
	if (itemID) then
		for mountID, internalItemID in pairs(private.DROPPED_MOUNT_IDS) do
			if (RSUtils.Contains(internalItemID, itemID)) then
				return mountID
			end
		end
	end
	
	return nil
end

local function CheckUpdateMount(itemID, entityID, source, checkedItems)
	-- If cached use it
	if (checkedItems[RSConstants.ITEM_TYPE.MOUNT][itemID]) then
		UpdateEntityCollection(itemID, entityID, source, RSConstants.ITEM_TYPE.MOUNT)
	else
		local mountID = GetMountID(itemID)
		if (mountID) then		
			if (RSUtils.Contains(GetNotCollectedMountsIDs(), mountID)) then
				UpdateEntityCollection(itemID, entityID, source, RSConstants.ITEM_TYPE.MOUNT)
				checkedItems[RSConstants.ITEM_TYPE.MOUNT][itemID] = true
			end
			
			return true
		end
		
		return false
	end
end

function RSCollectionsDB.RemoveNotCollectedMount(mountID, callback) --NEW_MOUNT_ADDED
	if (mountID and GetNotCollectedMountsIDs() and table.getn(GetNotCollectedMountsIDs()) ~= nil) then
		RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedMount[%s]", mountID))
	
		-- Drop missing mount
		for i = #private.dbglobal.not_colleted_mounts_ids, 1, -1 do
    		if (private.dbglobal.not_colleted_mounts_ids[i] == mountID) then
       			table.remove(private.dbglobal.not_colleted_mounts_ids, i)
				RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedMount[%s]: Eliminado coleccionable conseguido.", mountID))
       			break
       		end
		end
		
		local refresh = false
		for source, _ in pairs (RSCollectionsDB.GetAllEntitiesCollectionsLoot()) do
			for entityID, itemTypes in pairs (RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source]) do
				local lootList = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][RSConstants.ITEM_TYPE.MOUNT]
				if (lootList) then
					for i = #lootList, 1, -1 do
						if (RSUtils.Contains(GetMountItemID(mountID), lootList[i])) then
							if (table.getn(lootList) == 1) then
								RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedMount[%s]: Eliminado coleccionable de la lista de la entidad [%s]. No tiene mas monturas.", mountID, entityID))
								RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][RSConstants.ITEM_TYPE.MOUNT] = nil
							else
								RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedMount[%s]: Eliminado coleccionable de la lista de la entidad [%s].", mountID, entityID))
								table.remove(lootList, i)
							end
							
							-- Check if the entity doesn't have more collections
							if (RSUtils.GetTableLength(RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID]) == 0) then
								RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID] = nil
								
								-- Filter
								if (RSConfigDB.IsAutoFilteringOnCollect()) then
									if (source == RSConstants.ITEM_SOURCE.NPC) then
										RSConfigDB.SetNpcFiltered(entityID)
										RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedMount[%s]: Filtrado NPC [%s] por no disponer de mas coleccionables.", mountID, entityID))
										if (RSNpcDB.GetNpcName(entityID)) then
											RSLogger:PrintMessage(string.format(AL["EXPLORER_AUTOFILTER"], RSNpcDB.GetNpcName(entityID)))
										end
									elseif (source == RSConstants.ITEM_SOURCE.CONTAINER) then
										RSConfigDB.SetContainerFiltered(entityID)
										RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedMount[%s]: Filtrado Contenedor [%s] por no disponer de mas coleccionables.", mountID, entityID))
										if (RSContainerDB.GetContainerName(entityID)) then
											RSLogger:PrintMessage(string.format(AL["EXPLORER_AUTOFILTER"], RSContainerDB.GetContainerName(entityID)))
										end
									end
								end
							end
							
							refresh = true
							break
						end
					end
				end
			end
		end
		
		if (refresh and callback) then
			callback()
		end
    end
end

---============================================================================
-- Appearances
---============================================================================

local function AddAppearanceItemID(appearanceID, itemID)
	if (not private.dbglobal.appearances_item_id) then
		private.dbglobal.appearances_item_id = {}
	end
	
	if (not private.dbglobal.appearances_item_id[appearanceID]) then
		private.dbglobal.appearances_item_id[appearanceID] = {}
	end
	
	if (not RSUtils.Contains(private.dbglobal.appearances_item_id[appearanceID], itemID)) then
		table.insert(private.dbglobal.appearances_item_id[appearanceID], itemID)
	end
end

local function GetNotCollectedAppearanceItemIDs()
	return private.dbchar.not_colleted_appearances_item_ids
end

local function DropNotCollectedAppearance(appearanceID)
	if (private.dbglobal.appearances_item_id and appearanceID and private.dbglobal.appearances_item_id[appearanceID]) then
		if (GetNotCollectedAppearanceItemIDs()) then
			local itemIDs = private.dbglobal.appearances_item_id[appearanceID]
			for _, itemID in ipairs (itemIDs) do
				if (GetNotCollectedAppearanceItemIDs()[itemID]) then
					RSLogger:PrintDebugMessage(string.format("DropNotCollectedAppearance[%s]. Eliminado item [%s].", appearanceID, itemID))
					GetNotCollectedAppearanceItemIDs()[itemID] = nil
				end
			end
		end

		private.dbglobal.appearances_item_id[appearanceID] = nil
		RSLogger:PrintDebugMessage(string.format("DropNotCollectedAppearance[%s]. Eliminada apariencia.", appearanceID))
		
		return true
	end
	
	return false
end

local function GetAppearanceItemIDs(appearanceID)
	if (private.dbglobal.appearances_item_id) then
		return private.dbglobal.appearances_item_id[appearanceID]
	end
	
	return nil
end

local function UpdateNotCollectedAppearanceItemIDs(routines, routineTextOutput)
	private.dbchar.not_colleted_appearances_item_ids = {}
	
	-- Prepare filters
	C_TransmogCollection.SetUncollectedShown(true);
	C_TransmogCollection.SetSearch(Enum.TransmogSearchType.Items, "");
	
	-- Query
	for transmogLocationName, transmogCollectionTypes in pairs (TRANSMOG_LOCATIONS) do
		local transmogLocation = TransmogUtil.GetTransmogLocation(transmogLocationName, Enum.TransmogType.Appearance, Enum.TransmogModification.Main)
		for _, categoryID in ipairs (transmogCollectionTypes) do
			local name, _, _, _, _ = C_TransmogCollection.GetCategoryInfo(categoryID) -- Returns name only for the current class proficiencie, so if there is no name, this class cannot transmog it
			if (name) then
				local visualsList = C_TransmogCollection.GetCategoryAppearances(categoryID, transmogLocation)
				
				-- Appearances hidden in the collections tab
				if (private.MISSING_SOURCES[categoryID]) then
					local notCollectedAppearanceItemIDs = RSRoutines.LoopIndexRoutineNew()
					notCollectedAppearanceItemIDs:Init(function() return private.MISSING_SOURCES[categoryID] end, 100, 
						function(context, i)
							if (not context.counter) then
								context.counter = 0
							end
							
							local visualItemID = private.MISSING_SOURCES[context.arguments[1]][i]
							local sVisualID, sItemID = strsplit(";",visualItemID)
							
							local visualID = tonumber(sVisualID)
							local itemID = tonumber(sItemID)
							
							if (visualsList) then
								local collected = false
								local inVisualList = false
								for j = 1, #visualsList do
									if (visualsList[j].visualID == visualID and visualsList[j].isCollected) then
										collected = true
										inVisualList = true
										break
									end	
								end
								
								if (not collected and not C_TransmogCollection.PlayerHasTransmog(itemID, visualID) and PlayerCanUseItem(itemID)) then	
									context.counter = context.counter + 1
									AddAppearanceItemID(visualID, itemID)
								
									if (not private.dbchar.not_colleted_appearances_item_ids[itemID]) then
										private.dbchar.not_colleted_appearances_item_ids[itemID] = true
									end
									
									-- Some items show up as not collected but they are, so if it wasnt in the visuallist check the tooltip
									if (not inVisualList) then
										local item = Item:CreateFromItemID(itemID)
										item:ContinueOnItemLoad(function()
											if (not RSTooltipScanners.ScanLoot(item:GetItemLink(), TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN)) then
												DropNotCollectedAppearance(visualID)
											end
										end)
									end
								end
							end
						end,
						function(context)
							local name, _, _, _, _ = C_TransmogCollection.GetCategoryInfo(context.arguments[1])
							if (not name) then
								for categoryName, categoryID in pairs(Enum.TransmogCollectionType) do
									if (categoryID == context.arguments[1]) then
										name = categoryName
										break;
									end
								end
							end
							RSLogger:PrintDebugMessage(string.format("UpdateNotCollectedAppearanceItemIDs. [%s] [%s no conseguidas (ocultas)].", name, context.counter or "0"))
						
							if (routineTextOutput) then
								--routineTextOutput:SetText(string.format(AL["EXPLORER_MISSING_APPEARANCES"], context.counter or "0", name))
							end
						end,
						categoryID
					)
					table.insert(routines, notCollectedAppearanceItemIDs)
				end
				
				-- Appearances shown in the collections tab
				if (visualsList) then
					local notCollectedAppearanceItemIDs = RSRoutines.LoopIndexRoutineNew()
					notCollectedAppearanceItemIDs:Init(C_TransmogCollection.GetCategoryAppearances, 100, 
						function(context, j)
							if (not context.counter) then
								context.counter = 0
							end
							if (visualsList[j] and not visualsList[j].isCollected) then
								local previousVisualID
								local sources = C_TransmogCollection.GetAppearanceSources(visualsList[j].visualID, context.arguments[1], context.arguments[2]);
								if (sources) then
									-- If any of the sources collected then ignore
									local collected = false
									for k = 1, #sources do
										if (sources[k].isCollected) then
											collected = true
											break
										end
									end
									
									if (not collected) then
										for k = 1, #sources do
											if ((sources[k].sourceType == 1 or sources[k].sourceType == 4)) and PlayerCanUseItem(sources[k].itemID) then --Boss Drop/World drop and only usable
												if (not GetAppearanceItemIDs(sources[k].visualID) or not RSUtils.Contains(GetAppearanceItemIDs(sources[k].visualID), sources[k].itemID)) then
													AddAppearanceItemID(sources[k].visualID, sources[k].itemID)
												end
												
												if (not previousVisualID or previousVisualID ~= sources[k].visualID) then
													context.counter = context.counter + 1
													previousVisualID = sources[k].visualID
												end
										
												if (not private.dbchar.not_colleted_appearances_item_ids[sources[k].itemID]) then
													private.dbchar.not_colleted_appearances_item_ids[sources[k].itemID] = true
												end
											end	
										end
									end
								end
							end
						end,
						function(context)							
							local name, _, _, _, _ = C_TransmogCollection.GetCategoryInfo(context.arguments[1])
							if (not name) then
								for categoryName, categoryID in pairs(Enum.TransmogCollectionType) do
									if (categoryID == context.arguments[1]) then
										name = categoryName
										break;
									end
								end
							end
							RSLogger:PrintDebugMessage(string.format("UpdateNotCollectedAppearanceItemIDs. [%s] [%s no conseguidas].", name, context.counter or "0"))
							
							if (routineTextOutput) then
								routineTextOutput:SetText(string.format(AL["EXPLORER_MISSING_APPEARANCES"], context.counter or "0", name))
							end
						end,
						categoryID,
						transmogLocation
					)
					table.insert(routines, notCollectedAppearanceItemIDs)
				end
			end
		end
	end
end

local function CheckUpdateAppearance(itemID, entityID, source, checkedItems)
	-- If cached use it
	if (checkedItems[RSConstants.ITEM_TYPE.APPEARANCE][itemID]) then
		UpdateEntityCollection(itemID, entityID, source, RSConstants.ITEM_TYPE.APPEARANCE)
		
		return true
	-- Otherwise query
	else				
		if (GetNotCollectedAppearanceItemIDs() and GetNotCollectedAppearanceItemIDs()[itemID]) then
			UpdateEntityCollection(itemID, entityID, source, RSConstants.ITEM_TYPE.APPEARANCE)
			
			if (not checkedItems[RSConstants.ITEM_TYPE.APPEARANCE][itemID]) then
				checkedItems[RSConstants.ITEM_TYPE.APPEARANCE][itemID] = true
			end
			
			return true
		end
		
		return false
	end
end

function RSCollectionsDB.IsNotcollectedAppearance(itemID)
	if (not GetNotCollectedAppearanceItemIDs()) then
		return false
	end
	
	if (GetNotCollectedAppearanceItemIDs()[itemID]) then
		return true
	end
	
	return false
end

function RSCollectionsDB.RemoveNotCollectedAppearance(appearanceID, callback) --TRANSMOG_COLLECTION_UPDATED
	if (appearanceID and GetAppearanceItemIDs(appearanceID) and table.getn(GetAppearanceItemIDs(appearanceID)) ~= nil) then	
		RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedAppearance[%s]", appearanceID))
		
		local routines = {}
	
		-- Update filters
		if (not RSCollectionsDB.GetAllEntitiesCollectionsLoot()) then
			return
		end
		
		for source, info in pairs (RSCollectionsDB.GetAllEntitiesCollectionsLoot()) do
			local removeNotCollectedAppearanceRoutine = RSRoutines.LoopRoutineNew()
			removeNotCollectedAppearanceRoutine:Init(function() return RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source] end, 20,
				function(context, entityID, _)
					local lootList = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][RSConstants.ITEM_TYPE.APPEARANCE]
					if (lootList) then
						for i = #lootList, 1, -1 do
							if (RSUtils.Contains(GetAppearanceItemIDs(appearanceID), lootList[i])) then
								if (table.getn(lootList) == 1) then
									--RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedAppearance[%s]: Eliminado coleccionable [%s] de la lista de la entidad [%s]. No tiene mas apariencias.", appearanceID, lootList[i], entityID))
									RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][RSConstants.ITEM_TYPE.APPEARANCE] = nil
								else
									--RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedAppearance[%s]: Eliminado coleccionable [%s] de la lista de la entidad [%s].", appearanceID, lootList[i], entityID))
									table.remove(lootList, i)
								end
								
								-- Check if the entity doesn't have more collections
								if (RSUtils.GetTableLength(RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID]) == 0) then
									RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID] = nil
									
									-- Filter
									if (RSConfigDB.IsAutoFilteringOnCollect()) then
										if (source == RSConstants.ITEM_SOURCE.NPC) then
											RSConfigDB.SetNpcFiltered(entityID)
											RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedAppearance[%s]: Filtrado NPC [%s] por no disponer de mas coleccionables.", appearanceID, entityID))
											if (RSNpcDB.GetNpcName(entityID)) then
												RSLogger:PrintMessage(string.format(AL["EXPLORER_AUTOFILTER"], RSNpcDB.GetNpcName(entityID)))
											end
										elseif (source == RSConstants.ITEM_SOURCE.CONTAINER) then
											RSConfigDB.SetContainerFiltered(entityID)
											RSLogger:PrintDebugMessage(string.format("RemoveNotCollectedAppearance[%s]: Filtrado Contenedor [%s] por no disponer de mas coleccionables.", appearanceID, entityID))
											if (RSContainerDB.GetContainerName(entityID)) then
												RSLogger:PrintMessage(string.format(AL["EXPLORER_AUTOFILTER"], RSContainerDB.GetContainerName(entityID)))
											end
										end
									end
								end
							end
						end
					end
				end,
				function(context) end
			)
			tinsert(routines, removeNotCollectedAppearanceRoutine)
		end
		
		local chainRoutines = RSRoutines.ChainLoopRoutineNew()
		chainRoutines:Init(routines)
		chainRoutines:Run(function(context)
			-- Drops not collected appearance
			local dropped = DropNotCollectedAppearance(appearanceID)
			if (dropped and callback) then
				callback()
			end
		end)
    end
end

---============================================================================
-- Custom items
---============================================================================

function RSCollectionsDB.GetItemGroups()
	if (not private.dbglobal.explorer_item_groups) then
		private.dbglobal.explorer_item_groups = {}
	end
	
	if (RSUtils.GetTableLength(private.dbglobal.explorer_item_groups) == 0) then
		RSCollectionsDB.AddItemGroup(AL["EXPLORER_CUSTOM_ITEMS_GROUP_DEFAULT"])
	end
	
	return private.dbglobal.explorer_item_groups
end

function RSCollectionsDB.SetGroupName(groupKey, value)
	if (value and strtrim(value) ~= '' and groupKey and private.dbglobal.explorer_item_groups and private.dbglobal.explorer_item_groups[groupKey]) then
		-- Ignore if already exists
		for _, v in pairs (private.dbglobal.explorer_item_groups) do
			if (value == v) then
				return
			end
		end
		
		private.dbglobal.explorer_item_groups[groupKey] = strtrim(value)
	end
end

function RSCollectionsDB.GetGroupKeyByName(groupName)
	if (private.dbglobal.explorer_item_groups) then
		for key, name in pairs (private.dbglobal.explorer_item_groups) do
			if (name == groupName) then
				return key
			end
		end
	end
	
	return nil
end

function RSCollectionsDB.AddItemGroup(value)
	if (value and strtrim(value) ~= '') then
		-- Ignore if already exists
		for _, v in pairs (private.dbglobal.explorer_item_groups) do
			if (value == v) then
				return
			end
		end
		
		local key = 1
		if (RSUtils.GetTableLength(private.dbglobal.explorer_item_groups) > 0) then
			local keys = {}
			for k, _ in pairs (private.dbglobal.explorer_item_groups) do
				tinsert(keys, k)
			end
			
			key = math.max(unpack(keys)) + 1
		end
		
		private.dbglobal.explorer_item_groups[key] = strtrim(value)
		return key
	end
end

function RSCollectionsDB.DeleteItemGroup(key)
	if (key) then
		-- Delete group
		private.dbglobal.explorer_item_groups[key] = nil
		
		-- Delete group's items
		if (private.dbglobal.explorer_item_list) then
			private.dbglobal.explorer_item_list[key] = nil
		end
		
		-- Delete explorer filter settings
		RSConfigDB.SetSearchingCustom(key, nil)
		
		-- Delete loot filter options
		RSConfigDB.SetShowingCustomItems(key, nil)
		
		-- Delete possible scanned items
		local droppedGroupKey = string.format(RSConstants.ITEM_TYPE.CUSTOM, key)
		if (RSCollectionsDB.GetAllEntitiesCollectionsLoot()) then
			local routines = {}
			
			for source, info in pairs (RSCollectionsDB.GetAllEntitiesCollectionsLoot()) do
				local removeDroppedGroupRoutine = RSRoutines.LoopRoutineNew()
				removeDroppedGroupRoutine:Init(function() return RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source] end, 20,
					function(context, entityID, _)
						if (RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][droppedGroupKey]) then
							RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID][droppedGroupKey] = nil
						end
										
						-- Check if the entity doesn't have more collections
						if (RSUtils.GetTableLength(RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID]) == 0) then
							RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source][entityID] = nil
						end
					end,
					function(context) end
				)
				tinsert(routines, removeDroppedGroupRoutine)
			end
		
			local chainRoutines = RSRoutines.ChainLoopRoutineNew()
			chainRoutines:Init(routines)
			chainRoutines:Run(function(context) end)
		end
	end
end

function RSCollectionsDB.AddGroupItem(key, itemID)
	if (key) then
		if (not private.dbglobal.explorer_item_list) then
			private.dbglobal.explorer_item_list = {}
		end
		
		if (not private.dbglobal.explorer_item_list[key]) then
			private.dbglobal.explorer_item_list[key] = {}
		end
		
		-- Skip if duplicated
		for _, itemID_ in ipairs(private.dbglobal.explorer_item_list[key]) do
			if (itemID == itemID_) then
				return
			end
		end
		
		tinsert(private.dbglobal.explorer_item_list[key], itemID)
	end
end

function RSCollectionsDB.DeleteGroupItem(key, itemID)
	if (key and itemID and private.dbglobal.explorer_item_list and private.dbglobal.explorer_item_list[key]) then
		-- Delete the item for this group
		for i, item in ipairs (private.dbglobal.explorer_item_list[key]) do
			if (item == itemID) then
				tremove(private.dbglobal.explorer_item_list[key], i)
				break
			end
		end
	end
end

function RSCollectionsDB.GetGroupItems(key)
	if (key and private.dbglobal.explorer_item_list and private.dbglobal.explorer_item_list[key]) then
		return private.dbglobal.explorer_item_list[key]
	end
end

function RSCollectionsDB.HasGroupItems(key)
	if (key and private.dbglobal.explorer_item_list and private.dbglobal.explorer_item_list[key]) then
		return true
	end
	
	return false
end

local function CheckUpdateCustom(itemID, entityID, source, checkedItems, customGroupKeys)
	-- If cached use it
	for _, customGroupKey in ipairs(customGroupKeys) do
		if (checkedItems[customGroupKey][itemID]) then
			UpdateEntityCollection(itemID, entityID, source, customGroupKey)
			return true
		end
	end
	
	for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do
		local itemIDs = RSCollectionsDB.GetGroupItems(groupKey)
		if (itemIDs and RSUtils.Contains(itemIDs, itemID)) then
			UpdateEntityCollection(itemID, entityID, source, string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey))
			checkedItems[string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)][itemID] = true
			return true
		end
	end

	return false
end

---============================================================================
-- Collections database
---============================================================================

function RSCollectionsDB.UpdateEntityCollectibles(entityID, items, source)
	if (not RSCollectionsDB.GetAllEntitiesCollectionsLoot()) then
		return
	end

	-- Clean previous version
	RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC][entityID] = nil
	
	-- If no loot stop
	if (not items) then
		return
	end
	
	local checkedItems = {}
	checkedItems[RSConstants.ITEM_TYPE.UNKNOWN] = {}
	checkedItems[RSConstants.ITEM_TYPE.APPEARANCE] = {}
	checkedItems[RSConstants.ITEM_TYPE.TOY] = {}
	checkedItems[RSConstants.ITEM_TYPE.PET] = {}
	checkedItems[RSConstants.ITEM_TYPE.MOUNT] = {}
	
	local customGroupKeys = {}
	for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do
		local itemTypeCustomKey = string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)
		tinsert(customGroupKeys, itemTypeCustomKey)
		checkedItems[itemTypeCustomKey] = {}
	end
	
	for _, itemID in ipairs (items) do
		if (not checkedItems[RSConstants.ITEM_TYPE.UNKNOWN][itemID]) then
			-- Custom items wont be taken into account in other categories
				
			-- Check if appearance
			if (not checkedItems[RSConstants.ITEM_TYPE.TOY][itemID] and not checkedItems[RSConstants.ITEM_TYPE.PET][itemID] and not checkedItems[RSConstants.ITEM_TYPE.MOUNT][itemID]) then
				CheckUpdateAppearance(itemID, entityID, source, checkedItems)
			end
			
			-- Check if toy
			if (not checkedItems[RSConstants.ITEM_TYPE.APPEARANCE][itemID] and not checkedItems[RSConstants.ITEM_TYPE.PET][itemID] and not checkedItems[RSConstants.ITEM_TYPE.MOUNT][itemID]) then
				CheckUpdateToy(itemID, entityID, source, checkedItems)
			end
					
			-- Check if pet
			if (not checkedItems[RSConstants.ITEM_TYPE.APPEARANCE][itemID] and not checkedItems[RSConstants.ITEM_TYPE.TOY][itemID] and not checkedItems[RSConstants.ITEM_TYPE.MOUNT][itemID]) then
				CheckUpdatePet(itemID, entityID, source, checkedItems)
			end
			
			-- Check if mount
			if (not checkedItems[RSConstants.ITEM_TYPE.APPEARANCE][itemID] and not checkedItems[RSConstants.ITEM_TYPE.TOY][itemID] and not checkedItems[RSConstants.ITEM_TYPE.PET][itemID]) then
				CheckUpdateMount(itemID, entityID, source, checkedItems)
			end
	
			-- Check if custom item
			CheckUpdateCustom(itemID, entityID, source, checkedItems, customGroupKeys)
			
			if (not checkedItems[RSConstants.ITEM_TYPE.APPEARANCE][itemID] and not checkedItems[RSConstants.ITEM_TYPE.PET][itemID] and not checkedItems[RSConstants.ITEM_TYPE.TOY][itemID] and not checkedItems[RSConstants.ITEM_TYPE.MOUNT][itemID] and not RSUtils.ContainsKeyValue(checkedItems, customGroupKeys, itemID)) then
				checkedItems[RSConstants.ITEM_TYPE.UNKNOWN][itemID] = true
			end
		end
	end
end

local function CheckUpdateCollectibles(checkedItems, customGroupKeys, getter, source, routines, routineTextOutput)
	local checkUpdateCollectiblesRoutine = RSRoutines.LoopRoutineNew()
	checkUpdateCollectiblesRoutine:Init(getter, 30, 
		function(context, entityID, items)
			for _, itemID in ipairs (items) do
				if (not checkedItems[RSConstants.ITEM_TYPE.UNKNOWN][itemID]) then	
					-- Custom items wont be taken into account in other categories
				
					-- Check if appearance
					if (not checkedItems[RSConstants.ITEM_TYPE.TOY][itemID] and not checkedItems[RSConstants.ITEM_TYPE.PET][itemID] and not checkedItems[RSConstants.ITEM_TYPE.MOUNT][itemID]) then
						CheckUpdateAppearance(itemID, entityID, source, checkedItems)
					end
					
					-- Check if toy
					if (not checkedItems[RSConstants.ITEM_TYPE.APPEARANCE][itemID] and not checkedItems[RSConstants.ITEM_TYPE.PET][itemID] and not checkedItems[RSConstants.ITEM_TYPE.MOUNT][itemID]) then
						CheckUpdateToy(itemID, entityID, source, checkedItems)
					end
							
					-- Check if pet
					if (not checkedItems[RSConstants.ITEM_TYPE.APPEARANCE][itemID] and not checkedItems[RSConstants.ITEM_TYPE.TOY][itemID] and not checkedItems[RSConstants.ITEM_TYPE.MOUNT][itemID]) then
						CheckUpdatePet(itemID, entityID, source, checkedItems)
					end
					
					-- Check if mount
					if (not checkedItems[RSConstants.ITEM_TYPE.APPEARANCE][itemID] and not checkedItems[RSConstants.ITEM_TYPE.TOY][itemID] and not checkedItems[RSConstants.ITEM_TYPE.PET][itemID]) then
						CheckUpdateMount(itemID, entityID, source, checkedItems)
					end
			
					-- Check if custom item
					CheckUpdateCustom(itemID, entityID, source, checkedItems, customGroupKeys)
					
					if (not checkedItems[RSConstants.ITEM_TYPE.APPEARANCE][itemID] and not checkedItems[RSConstants.ITEM_TYPE.PET][itemID] and not checkedItems[RSConstants.ITEM_TYPE.TOY][itemID] and not checkedItems[RSConstants.ITEM_TYPE.MOUNT][itemID] and not RSUtils.ContainsKeyValue(checkedItems, customGroupKeys, itemID)) then
						checkedItems[RSConstants.ITEM_TYPE.UNKNOWN][itemID] = true
					end
				end
			end
		end,
		function(context)
			RSLogger:PrintDebugMessage(string.format("CheckUpdateCollectibles. [%s]. Finalizado.", source == RSConstants.ITEM_SOURCE.NPC and "NPCs" or "Contenedores"))
			
			if (routineTextOutput) then
				if (source == RSConstants.ITEM_SOURCE.NPC) then
					routineTextOutput:SetText(string.format(AL["EXPLORER_FOUND_NPCS"], RSUtils.GetTableLength(RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source])))
				else
					routineTextOutput:SetText(string.format(AL["EXPLORER_FOUND_CONTAINERS"], RSUtils.GetTableLength(RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source])))
				end
			end
		end
	)
	table.insert(routines, checkUpdateCollectiblesRoutine)
end

local function UpdateEntitiesCollections(callback, routineTextOutput, manualScan)
	-- Saves current version
	if (not private.dbglobal.lastCollectionsScanVersion) then
		private.dbglobal.lastCollectionsScanVersion = {}
	end
	
	if (not private.dbglobal.lastCollectionsScanVersion[RSConstants.CURRENT_LOOT_DB_VERSION]) then
		private.dbglobal.lastCollectionsScanVersion[RSConstants.CURRENT_LOOT_DB_VERSION] = {}
	end
	
	local _, _, classIndex = UnitClass("player");
	if (not private.dbglobal.lastCollectionsScanVersion[RSConstants.CURRENT_LOOT_DB_VERSION][classIndex]) then
		private.dbglobal.lastCollectionsScanVersion[RSConstants.CURRENT_LOOT_DB_VERSION][classIndex] = true
	end

	-- Reset database
	ResetEntitiesCollectionsLoot()
	
	local checkedItems = {}
	checkedItems[RSConstants.ITEM_TYPE.UNKNOWN] = {}
	checkedItems[RSConstants.ITEM_TYPE.APPEARANCE] = {}
	checkedItems[RSConstants.ITEM_TYPE.TOY] = {}
	checkedItems[RSConstants.ITEM_TYPE.PET] = {}
	checkedItems[RSConstants.ITEM_TYPE.MOUNT] = {}

	local customGroupKeys = {}
	for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do
		local itemTypeCustomKey = string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)
		tinsert(customGroupKeys, itemTypeCustomKey)
		checkedItems[itemTypeCustomKey] = {}
	end
	
	local routines = {}
	
	-- Sync npc loot
	CheckUpdateCollectibles(checkedItems, customGroupKeys, RSNpcDB.GetAllInteralNpcLoot, RSConstants.ITEM_SOURCE.NPC, routines, routineTextOutput)
	RSLogger:PrintDebugMessage("UpdateEntitiesCollections. Actualizada la lista de collecionables de NPCs no conseguidos.")
	
	-- Sync container loot
	CheckUpdateCollectibles(checkedItems, customGroupKeys, RSContainerDB.GetAllInteralContainerLoot, RSConstants.ITEM_SOURCE.CONTAINER, routines, routineTextOutput)
	RSLogger:PrintDebugMessage("UpdateEntitiesCollections. Actualizada la lista de collecionables de contenedores no conseguidos.")
		
	-- Launch all the routines in order
	local chainRoutines = RSRoutines.ChainLoopRoutineNew()
	chainRoutines:Init(routines)
	chainRoutines:Run(function(context)
		checkedItems = nil
		RSLogger:PrintMessage(AL["LOG_DONE"])
		RSLogger:PrintDebugMessage("UpdateEntitiesCollections: Finalizado proceso.")
		callback()
	end)
end

local loaded = false
local function LoadNotCollectedItems(callback, routineTextOutput, manualScan)
	RSLogger:PrintMessage(AL["LOG_FETCHING_COLLECTIONS"])
	
	-- Prepare not collected queries routines
	local routines = {}
	UpdateNotCollectedToys(routines, routineTextOutput)
	UpdateNotCollectedPetIDs(routines, routineTextOutput)
	UpdateNotCollectedMountIDs(routines, routineTextOutput)
	UpdateNotCollectedAppearanceItemIDs(routines, routineTextOutput)
	
	-- Launch all the routines in order
	local chainRoutines = RSRoutines.ChainLoopRoutineNew()
	chainRoutines:Init(routines)
	chainRoutines:Run(function(context)
		-- Reset filters
		C_TransmogCollection.SetDefaultFilters()
							
		loaded = true
		RSLogger:PrintMessage(AL["LOG_DONE"])
		RSLogger:PrintMessage(AL["LOG_FILTERING_ENTITIES"])
		UpdateEntitiesCollections(callback, routineTextOutput, manualScan)
	end)
end

local function FindProfile(name)
	local profiles = {}
	for _, v in pairs(private.dbm:GetProfiles(profiles)) do
		if (v == name) then
			return true
		end
	end
	
	return false
end

function RSCollectionsDB.ApplyCollectionsEntitiesFilters(callback, routineTextOutput, manualScan)	
	-- Loads all not collected items if not done in this session --
	if (not loaded) then
		LoadNotCollectedItems(callback, routineTextOutput, manualScan)
	else
		UpdateEntitiesCollections(callback, routineTextOutput, manualScan)
	end
end

function RSCollectionsDB.ApplyFilters(filters, callback)	
	-- Creates profile backup if selected
	if (RSConfigDB.IsCreateProfileBackup()) then
		local name = GetUnitName("player", true)
		local realmName = GetRealmName()
		local currentProfile = private.dbm:GetCurrentProfile()
		if (name) then
			local i = 0
			local backupProfileName = string.format("%s-%s_col_%s", name, realmName, i)
			while (FindProfile(backupProfileName)) do
				i = i + 1
				backupProfileName = string.format("%s-%s_col_%s", name, realmName, i)
			end
			
			private.dbm:SetProfile(backupProfileName)
			private.dbm:CopyProfile(currentProfile, true)
			RSLogger:PrintMessage(string.format(AL["COLLECTION_FILTERS_PROFILE_BACKUP_CREATED"], backupProfileName))
		end
	end
	
	local routines = {}
	
	-- Filter all NPCs
	RSConfigDB.FilterAllNpcs(routines)
	RSConfigDB.FilterAllContainers(routines)
	
	-- Remove filters for NPCs with collections
	if (RSCollectionsDB.GetAllEntitiesCollectionsLoot() and RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC]) then
		local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC]
		
		local removeNPCFilterByCollectionRoutine = RSRoutines.LoopRoutineNew()
		removeNPCFilterByCollectionRoutine:Init(RSNpcDB.GetAllInternalNpcInfo, 500, 
			function(context, npcID, npcInfo)
				local removeFilter = false
				if (not removeFilter and filters[RSConstants.EXPLORER_FILTER_DROP_MOUNTS] and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.MOUNT]) > 0) then
					removeFilter = true
				end
				if (not removeFilter and filters[RSConstants.EXPLORER_FILTER_DROP_PETS] and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.PET]) > 0) then
					removeFilter = true
				end
				if (not removeFilter and filters[RSConstants.EXPLORER_FILTER_DROP_TOYS] and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.TOY]) > 0) then
					removeFilter = true
				end
				if (not removeFilter and filters[RSConstants.EXPLORER_FILTER_DROP_APPEARANCES] and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.APPEARANCE]) > 0) then
					removeFilter = true
				end
				if (not removeFilter and filters[RSConstants.EXPLORER_FILTER_ACHIEVEMENT_CRITERIA] and npcInfo.achievementID) then			
					if (RSAchievementDB.IsNotCompletedAchievementCriteria(npcID, npcInfo.achievementID, npcInfo.criteria)) then
						removeFilter = true
					end
				end
				if (not removeFilter) then
					for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do
						local droppedGroupKey = string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)				
						if (filters[string.format(RSConstants.EXPLORER_FILTER_DROP_CUSTOM, groupKey)] and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][droppedGroupKey]) > 0) then
							removeFilter = true
						end
					end
				end
				
				if (removeFilter) then
					RSConfigDB.DeleteNpcFiltered(npcID)
					
					for npcIDpostEvent, npcIDPpreEvent in pairs (RSConstants.NPCS_WITH_PRE_NPCS) do
						if (npcIDpostEvent == npcID or npcIDPpreEvent == npcID) then
							RSConfigDB.DeleteNpcFiltered(npcIDpostEvent)
							RSConfigDB.DeleteNpcFiltered(npcIDPpreEvent)
							break
						end
					end
				end
			end,
			function(context)
				RSLogger:PrintDebugMessage("ApplyFilters. Eliminados filtros de NPCs con coleccionables aun no conseguidos")
			end
		)
		table.insert(routines, removeNPCFilterByCollectionRoutine)
	end
	
	-- Remove filters for Containers with collections
	if (RSCollectionsDB.GetAllEntitiesCollectionsLoot() and RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.CONTAINER]) then
		local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.CONTAINER]
		
		local removeContainerFilterByCollectionRoutine = RSRoutines.LoopRoutineNew()
		removeContainerFilterByCollectionRoutine:Init(RSContainerDB.GetAllInternalContainerInfo, 500, 
			function(context, containerID, containerInfo)
				local removeFilter = false
				if (not removeFilter and filters[RSConstants.EXPLORER_FILTER_DROP_MOUNTS] and collectionsLoot[containerID] and RSUtils.GetTableLength(collectionsLoot[containerID][RSConstants.ITEM_TYPE.MOUNT]) > 0) then
					removeFilter = true
				end
				if (not removeFilter and filters[RSConstants.EXPLORER_FILTER_DROP_PETS] and collectionsLoot[containerID] and RSUtils.GetTableLength(collectionsLoot[containerID][RSConstants.ITEM_TYPE.PET]) > 0) then
					removeFilter = true
				end
				if (not removeFilter and filters[RSConstants.EXPLORER_FILTER_DROP_TOYS] and collectionsLoot[containerID] and RSUtils.GetTableLength(collectionsLoot[containerID][RSConstants.ITEM_TYPE.TOY]) > 0) then
					removeFilter = true
				end
				if (not removeFilter and filters[RSConstants.EXPLORER_FILTER_DROP_APPEARANCES] and collectionsLoot[containerID] and RSUtils.GetTableLength(collectionsLoot[containerID][RSConstants.ITEM_TYPE.APPEARANCE]) > 0) then
					removeFilter = true
				end
				if (not removeFilter and filters[RSConstants.EXPLORER_FILTER_ACHIEVEMENT_CRITERIA] and containerInfo.achievementID) then			
					-- If quest completed then the achievement criteria is completed too
					if (containerInfo.questID) then
						for _, questID in pairs(containerInfo.questID) do
							if (not C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)) then
								removeFilter = true
								break
							end
						end
					else
						if (RSAchievementDB.IsNotCompletedAchievementCriteria(containerID, containerInfo.achievementID, containerInfo.criteria, true)) then
							removeFilter = true
						end
					end
				end
				if (not removeFilter) then
					for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do
						local droppedGroupKey = string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)				
						if (filters[string.format(RSConstants.EXPLORER_FILTER_DROP_CUSTOM, groupKey)] and collectionsLoot[containerID] and RSUtils.GetTableLength(collectionsLoot[containerID][droppedGroupKey]) > 0) then
							removeFilter = true
						end
					end
				end
				
				if (removeFilter) then
					RSConfigDB.DeleteContainerFiltered(containerID)
				end
			end,
			function(context)
				RSLogger:PrintDebugMessage("ApplyFilters. Eliminados filtros de Contenedores con coleccionables aun no conseguidos")
			end
		)
		table.insert(routines, removeContainerFilterByCollectionRoutine)
	end
			
	-- Launch all the routines in order
	local chainRoutines = RSRoutines.ChainLoopRoutineNew()
	chainRoutines:Init(routines)
	chainRoutines:Run(function(context)	
		RSLogger:PrintDebugMessage("ApplyFilters: Finalizado proceso.")
		
		if (callback) then
			callback()
		end
	end)
end

function RSCollectionsDB.GetAllEntitiesCollectionsLoot()
	return private.dbglobal.entity_collections_loot
end

function RSCollectionsDB.GetEntityCollectionsLoot(entityID, type)
	local items = {}
	if (entityID and RSUtils.GetTableLength(RSCollectionsDB.GetAllEntitiesCollectionsLoot()) > 0) then
		local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[type]		
		if (collectionsLoot and collectionsLoot[entityID]) then
			local _, _, classIndex = UnitClass("player")
			
			-- If mount
			if (RSConfigDB.IsShowingMissingMounts() and collectionsLoot[entityID][RSConstants.ITEM_TYPE.MOUNT]) then
				items = RSUtils.JoinTables(items, collectionsLoot[entityID][RSConstants.ITEM_TYPE.MOUNT])
			end
			
			-- If pet
			if (RSConfigDB.IsShowingMissingPets() and collectionsLoot[entityID][RSConstants.ITEM_TYPE.PET]) then
				items = RSUtils.JoinTables(items, collectionsLoot[entityID][RSConstants.ITEM_TYPE.PET])
			end
			
			-- If toy
			if (RSConfigDB.IsShowingMissingToys() and collectionsLoot[entityID][RSConstants.ITEM_TYPE.TOY]) then
				items = RSUtils.JoinTables(items, collectionsLoot[entityID][RSConstants.ITEM_TYPE.TOY])
			end
			
			-- If appearance
			if (RSConfigDB.IsShowingMissingAppearances() and collectionsLoot[entityID][RSConstants.ITEM_TYPE.APPEARANCE] and collectionsLoot[entityID][RSConstants.ITEM_TYPE.APPEARANCE][classIndex]) then
				items = RSUtils.JoinTables(items, collectionsLoot[entityID][RSConstants.ITEM_TYPE.APPEARANCE][classIndex])
			end
			
			-- If custom items
			for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do
				local droppedGroupKey = string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)
				if (RSConfigDB.IsShowingCustomItems(groupKey) and collectionsLoot[entityID][droppedGroupKey]) then
					items = RSUtils.JoinTables(items, collectionsLoot[entityID][droppedGroupKey])
				end
			end
		end
	end
	
	return items
end

function RSCollectionsDB.IsCollectionsScanDoneWithCurrentVersion()
	if (private.dbglobal.lastCollectionsScanVersion and private.dbglobal.lastCollectionsScanVersion[RSConstants.CURRENT_LOOT_DB_VERSION]) then
		return true
	end
	
	return false
end

function RSCollectionsDB.IsCollectionsScanByClassDone()
	local _, _, classIndex = UnitClass("player");
	if (private.dbglobal.lastCollectionsScanVersion and private.dbglobal.lastCollectionsScanVersion[RSConstants.CURRENT_LOOT_DB_VERSION]) then
		return private.dbglobal.lastCollectionsScanVersion[RSConstants.CURRENT_LOOT_DB_VERSION][classIndex]
	end
	
	return nil
end