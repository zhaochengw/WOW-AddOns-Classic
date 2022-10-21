if ( GetLocale() ~= "deDE" ) then
	return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("SpellbookAbridged", "deDE")
if not L then return end

L["Auto UpRank"] = "Automatisch Hochgestuft"
