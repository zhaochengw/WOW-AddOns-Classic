-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

local RSNotes = private.NewLib("RareScannerNotes")

-- RareScanner general libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")

---============================================================================
-- NPCs notes
---============================================================================

function RSNotes.GetNote(entityID, mapID)
	-- Individual note by entityID
	if (AL[string.format("NOTE_%s", entityID)] ~= string.format("NOTE_%s", entityID)) then
		return AL[string.format("NOTE_%s", entityID)]
	-- Individual note by entityID and mapID
	elseif (AL[string.format("NOTE_%s_%s", entityID, mapID)] ~= string.format("NOTE_%s_%s", entityID, mapID)) then
		return AL[string.format("NOTE_%s_%s", entityID, mapID)]
	end
	
end