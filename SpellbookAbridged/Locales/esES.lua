if ( GetLocale() ~= "esES" ) then
	return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("SpellbookAbridged", "esES")
if not L then return end

L["Auto UpRank"] = "Rango Superior Automático"
