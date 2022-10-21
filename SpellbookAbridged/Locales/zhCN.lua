if ( GetLocale() ~= "zhCN" ) then
	return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("SpellbookAbridged", "zhCN")
if not L then return end


L["Auto UpRank"] = "自动提升动作条技能等级"
