--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
NS.WA = NS.WA or {  };
NS.WA.L = NS.WA.L or {  };
local L = NS.WA.L;

if L.Locale ~= nil and L.Locale ~= "" then return;end

L["CONFLICTED: "] = "\124cffff0000Conflicted\124r: ";
L["ALL_EXIST"] = "\124cff00ffff>>All Exist<<\124r";

L["DROP_IMPORT"] = "Import Codes";
L["DROP_FORCE_IMPORT"] = "\124cffff0000Forced Import Codes\124r";
L["WeakAuraOptions_LOAD_FAILED"] = "Fail to load WeakAuraOptions";
L["OK"] = "OK";
L["Search"] = "Search";
L["Author: "] = "Author: ";

L["Are you sure to load WA ?"] = "Are you sure to load WA ?";
L["OK"] = "OK";
L["Cancel"] = "Cancel";
