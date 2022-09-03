-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSLootTooltip = private.NewLib("RareScannerLootTooltip")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner general libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSTooltipScanners = private.ImportLib("RareScannerTooltipScanners")

---============================================================================
-- Adds extra information to loot tooltips
---============================================================================

function RSLootTooltip.AddRareScannerInformation(tooltip, itemLink, itemID, itemClassID, itemSubClassID)
	-- Adds commands	
	if (itemClassID and itemSubClassID and RSConfigDB.IsShowingLootTooltipsCommands()) then
		tooltip:AddLine(string.format(AL["LOOT_TOGGLE_FILTER"], GetItemClassInfo(itemClassID), GetItemSubClassInfo(itemClassID, itemSubClassID)), 1,1,0)
		tooltip:AddLine(AL["LOOT_TOGGLE_INDIVIDUAL_FILTER"], 1,1,0)
	end
	
	-- Adds DEBUG information
	if (RSConstants.DEBUG_MODE) then
		tooltip:AddLine(itemID, 1,1,0)
	end
end