if ( GetLocale() ~= "ruRU" ) then
	return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("SpellbookAbridged", "ruRU")
if not L then return end

L["Auto UpRank"] = "Автообновление заклинаний"
