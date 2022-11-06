-- FishingSetup
--
-- Load out translation strings and such

local FL = LibStub("LibFishing-1.0");

FBConstants = {};

FBConstants.CURRENTVERSION = 19500;
FBConstants.DEFAULT_MINIMAP_POSITION = 256;
FBConstants.DEFAULT_MINIMAP_RADIUS = 80;

-- don't override debugging code, if it loaded
if ( not FishingBuddy ) then
	FishingBuddy = {};
	FishingBuddy.Commands = {};

	FishingBuddy.Debug = function(msg, fixlinks)
	end

	FishingBuddy.DebugVars = function()
	end

	FishingBuddy.Dump = function(thing)
	end
end

FishingBuddy.Output = function(msg, r, g, b)
	if ( DEFAULT_CHAT_FRAME ) then
		if ( not r ) then
			DEFAULT_CHAT_FRAME:AddMessage(msg);
		else
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
		end
	end
end

FishingBuddy.Message = function(msg, r, g, b)
	FishingBuddy.Output(FL:Green(FBConstants.NAME)..": "..msg, r, g, b);
end

FishingBuddy.Error = function(msg)
	FishingBuddy.Output(FBConstants.NAME..": "..msg, 1.0, 0, 0);
end

local FL = LibStub("LibFishing-1.0");

local uselocale = FishingBuddy.DebugLocale;

local major,_,_ = FL:WOWVersion();
local printfunc;
if ( FL:IsClassic() or major > 1 ) then
	printfunc = "function(...) FishingBuddy.Message(string.format(...)); end;";
else
	printfunc = "function(...) FishingBuddy.Message(string.format(unpack(arg))); end;";
end
local func, err = loadstring("return "..printfunc);
if ( func ) then
	FishingBuddy.Print = func();
else
	FishingBuddy.DebugOutput("Print function failed "..err);
end

FL:Translate("FishingBuddy", FishingTranslations, FBConstants, uselocale);
FishingBuddy.Missing = nil;

-- FishingBuddy.Missing = FL:Translate("FishingBuddy", FishingTranslations, FBConstants, "frFR");
FishingBuddy.Commands["missing"] = {};
FishingBuddy.Commands["missing"].func =
	function()
		FishingBuddy_Info["Missing"] = FishingBuddy.Missing;
		return true;
	end

-- Set the bobber name if we have a custom translation for it
if ( FBConstants.BOBBER_NAME ~= FishingTranslations["enUS"].BOBBER_NAME) then
	FL:SetBobberName(FBConstants.BOBBER_NAME);
end

-- dump the memory we've allocated for all the translations
FishingTranslations = nil;

FishingBuddy.ChatLink = function(...)
	return FL:ChatLink(...);
end

FBConstants.ID = "FishingBuddy";
FBConstants.MSGID = "FBAM";	-- Fishing Buddy Addon Message

FBConstants.UNKNOWN = "UNKNOWN";

FBConstants.FISHINGTEXTURE = "Interface\\Icons\\Trade_Fishing";
FBConstants.FINDFISHTEXTURE = "Interface\\Icons\\INV_Misc_Fish_02";

FBConstants.SPELL_FAILED_FISHING_TOO_LOW = string.gsub(SPELL_FAILED_FISHING_TOO_LOW, "%%d", "(%%d+)");

FBConstants.KEYS_NONE = 0;
FBConstants.KEYS_SHIFT = 1;
FBConstants.KEYS_CTRL = 2;
FBConstants.KEYS_ALT = 3;
FBConstants.Keys = {};
FBConstants.Keys[FBConstants.KEYS_NONE] = FBConstants.KEYS_NONE_TEXT;
FBConstants.Keys[FBConstants.KEYS_SHIFT] = FBConstants.KEYS_SHIFT_TEXT;
FBConstants.Keys[FBConstants.KEYS_CTRL] = FBConstants.KEYS_CTRL_TEXT;
FBConstants.Keys[FBConstants.KEYS_ALT] = FBConstants.KEYS_ALT_TEXT;

FBConstants.CastingKeyLabel = {};
FBConstants.CastingKeyLabel[FL.MOUSE1] = KEY_BUTTON2;
FBConstants.CastingKeyLabel[FL.MOUSE2] = KEY_BUTTON4;
FBConstants.CastingKeyLabel[FL.MOUSE3] = KEY_BUTTON5;
FBConstants.CastingKeyLabel[FL.MOUSE4] = KEY_BUTTON3;

-- Continents
FBConstants.KALIMDOR = FL.KALIMDOR
FBConstants.EASTERN_KINDOMS = FL.EASTERN_KINDOMS
FBConstants.OUTLAND = FL.OUTLAND
FBConstants.NORTHREND = FL.NORTHREND
FBConstants.THE_MAELSTROM = FL.THE_MAELSTROM
FBConstants.PANDARIA = FL.PANDARIA
FBConstants.DRAENOR = FL.DRAENOR
FBConstants.BROKEN_ISLES = FL.BROKEN_ISLES
FBConstants.KUL_TIRAS = FL.KUL_TIRAS
FBConstants.ZANDALAR = FL.ZANDALAR
FBConstants.SHADOWLANDS = FL.SHADOWLANDS

local CustomEvents = {
	["WILDCARD_EVT"] = "*",
	["ADD_FISHIE_EVT"] = "ADD_FISHIE",
	["ADD_SCHOOL_EVT"] = "ADD_SCHOOL",
	["RESET_FISHDATA_EVT"] = "RESET_FISHDATA",
	
	["FISHING_ENABLED_EVT"] = "FISHING_ENABLED",
	["FISHING_DISABLED_EVT"] = "FISHING_DISABLED",

	["INVENTORY_EVT"] = "INVENTORY",
	
	["LOGIN_EVT"] = "LOGIN",
	["LOGOUT_EVT"] = "LOGOUT",
	["LEAVING_EVT"] = "LEAVING",

	-- option frame
	["OPT_UPDATE_EVT"] = "OPT_UPDATE",
	-- main FB frame handler
	["FRAME_SHOW_EVT"] = "FRAME_SHOW",
	["FIRST_UPDATE_EVT"] = "FIRST_UPDATE"
}

FBConstants.FBEvents = {};
for event,constant in pairs(CustomEvents) do
	FBConstants[event] = constant;
	-- register "fake" events
	FBConstants.FBEvents[constant] = 1;
end
