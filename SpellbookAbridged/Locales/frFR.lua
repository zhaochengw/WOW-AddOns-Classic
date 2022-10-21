if ( GetLocale() ~= "frFR" ) then
	return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("SpellbookAbridged", "frFR")
if not L then return end

L["Auto UpRank"] = "Classement Automatique"
