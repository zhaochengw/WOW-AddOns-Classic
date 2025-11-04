-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSProfessionDB = private.NewLib("RareScannerProfessionDB")


---============================================================================
-- Professions
---============================================================================

function RSProfessionDB.HasPlayerProfession(prof)
	local pindex1, pindex2, _, _, _, _ = GetProfessions();
	local matches
	if (pindex1) then
		local _, _, _, _, _, _, skillLine, _, _, _ = GetProfessionInfo(pindex1)
		matches = skillLine and skillLine == prof
	end
	if (not matches and pindex2) then
		local _, _, _, _, _, _, skillLine, _, _, _ = GetProfessionInfo(pindex2)
		matches = skillLine and skillLine == prof
	end
	
	if (not matches) then
		return false
	end
	
	return true
end