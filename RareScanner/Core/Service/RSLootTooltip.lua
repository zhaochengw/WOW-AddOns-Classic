-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSLootTooltip = private.NewLib("RareScannerLootTooltip")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSCollectionsDB = private.ImportLib("RareScannerCollectionsDB")

-- RareScanner general libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSTooltipScanners = private.ImportLib("RareScannerTooltipScanners")

---============================================================================
-- Handle item events
---============================================================================

function RSLootTooltip.HandleInputEvents(button, itemLink, itemClassID, itemSubClassID, itemID)
	if (button == "LeftButton" and IsControlKeyDown() and not IsAltKeyDown() and not IsShiftKeyDown()) then
		DressUpItemLink(itemLink)
		DressUpBattlePetLink(itemLink)
		DressUpMountLink(itemLink)
	-- Filter by category
	elseif (button == "LeftButton" and not IsControlKeyDown() and IsAltKeyDown() and IsShiftKeyDown()) then
		if (RSConfigDB.GetLootFilterByCategory(itemClassID, itemSubClassID)) then
			RSConfigDB.SetLootFilterByCategory(itemClassID, itemSubClassID, false)
			RSLogger:PrintMessage(string.format(AL["LOOT_CATEGORY_FILTERED"], C_Item.GetItemClassInfo(itemClassID), C_Item.GetItemSubClassInfo(itemClassID, itemSubClassID)))
		else
			RSConfigDB.SetLootFilterByCategory(itemClassID, itemSubClassID, true)
			RSLogger:PrintMessage(string.format(AL["LOOT_CATEGORY_NOT_FILTERED"], C_Item.GetItemClassInfo(itemClassID), C_Item.GetItemSubClassInfo(itemClassID, itemSubClassID)))
		end
	-- Individual filter
	elseif (button == "RightButton" and not IsControlKeyDown() and IsAltKeyDown() and not IsShiftKeyDown()) then
		if (not RSConfigDB.GetItemFiltered(itemID)) then
			RSConfigDB.SetItemFiltered(itemID, true)
			RSLogger:PrintMessage(string.format(AL["LOOT_INDIVIDUAL_FILTERED"], itemLink))
		else
			RSConfigDB.SetItemFiltered(itemID, false)
			RSLogger:PrintMessage(string.format(AL["LOOT_INDIVIDUAL_NOT_FILTERED"], itemLink))
		end
		-- Refresh options panel (if its being initialized)
		if (private.loadFilteredItems) then
			private.loadFilteredItems()
		end
	end
end

---============================================================================
-- Adds extra information to loot tooltips
---============================================================================

local function AddTSMInfo(tooltip, source, itemLink, itemID, separatorAdded)
	if (TSM_API and TSM_API.GetCustomPriceValue) then
		local value
		local status, res = pcall(TSM_API.GetCustomPriceValue, source, TSM_API.ToItemString(itemLink))
		if (status and res) then
			value = tonumber(res)
		else
			-- If pet check for the NPC, not the cage
			local name, _, _, _, _, _, _, _, _, _, _, _ = C_PetJournal.GetPetInfoByItemID(itemID)
			if (name) then
				local speciesId, _ = C_PetJournal.FindPetIDByName(name)
				if (speciesId) then
			  		status, res = pcall(TSM_API.GetCustomPriceValue, source, string.format("p:%s:1:3", speciesId))
					if (status and res) then
						value = tonumber(res)
					end
				end
			end
		end
		
		if (value) then
			if (not separatorAdded) then
				tooltip:AddLine(" ")
			end
			tooltip:AddLine(string.format("%s: %s", RSUtils.TextColor(string.format("TSM (%s)", source), "FFFF00"), TSM_API.FormatMoneyString(value)))
			return true
		end
	end	
end

function RSLootTooltip.AddRareScannerInformation(tooltip, itemLink, itemID, itemClassID, itemSubClassID)	
	-- Adds TSM price
	if (RSConfigDB.IsShowingLootTSMTooltip()) then
		local added = false
		for _, source in ipairs(RSConstants.TSM_SOURCES) do
			if (AddTSMInfo(tooltip, source, itemLink, itemID, added)) then
				added = true
			end
		end
	end

	-- Adds commands	
	if (itemClassID and itemSubClassID and RSConfigDB.IsShowingLootTooltipsCommands()) then
		tooltip:AddLine(" ")
		tooltip:AddLine("|TInterface\\AddOns\\RareScanner\\Media\\Textures\\tooltip_shortcuts:18:60:::256:256:0:96:0:32|t "..RSUtils.TextColor(string.format(AL["LOOT_TOGGLE_FILTER"], C_Item.GetItemClassInfo(itemClassID), C_Item.GetItemSubClassInfo(itemClassID, itemSubClassID)), "00FF00"))
		tooltip:AddLine("|TInterface\\AddOns\\RareScanner\\Media\\Textures\\tooltip_shortcuts:18:60:::256:256:0:96:128:160|t "..RSUtils.TextColor(AL["LOOT_TOGGLE_INDIVIDUAL_FILTER"], "FFFF00"))
	end
	
	-- Adds DEBUG information
	if (RSConstants.DEBUG_MODE) then
		tooltip:AddLine(itemID, 1,1,0)
	end
	
	-- Other addons support
	if (CanIMogIt and RSConfigDB.IsShowingLootCanimogitTooltip()) then
		tooltip:AddLine(CanIMogIt:GetTooltipText(itemLink))
	end
end