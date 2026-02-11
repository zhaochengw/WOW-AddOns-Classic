-------------------------------------------------------------------------------
-- Module namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local addon = private.addon
if not addon then
	return
end

local constants = addon.constants
local module = addon:GetModule(private.module_name)

local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeQuests()
	local function AddQuest(questID, zoneName, coordX, coordY, faction)
		addon.AcquireTypes.Quest:AddEntity(module, {
			coord_x = coordX,
			coord_y = coordY,
			faction = faction,
			identifier = questID,
			item_list = {},
			locationName = zoneName,
			name = nil, -- Handled by memoizing table in the core.
		})
	end

	AddQuest(769,	Z.THUNDER_BLUFF,		44.1,	44.6,	"Horde")
	AddQuest(1582,	Z.DARNASSUS,			60.5,	37.3,	"Alliance")
	AddQuest(7493,	Z.ORGRIMMAR,			51.0,	76.5,	"Horde")
	AddQuest(7497,	Z.STORMWIND_CITY,		67.2,	85.5,	"Alliance")
	AddQuest(40176,	Z.DALARAN_BROKENISLES,		35.2,	29.2,	"Neutral")
	AddQuest(40178,	Z.DALARAN_BROKENISLES,		35.4,	29.8,	"Neutral")
	AddQuest(40179,	Z.DALARAN_BROKENISLES,		35.4,	29.8,	"Neutral")
	AddQuest(40181,	Z.DALARAN_BROKENISLES,		34.6,	28.4,	"Neutral")
	AddQuest(40182,	Z.DALARAN_BROKENISLES,		34.6,	28.4,	"Neutral")
	AddQuest(40183,	Z.DALARAN_BROKENISLES,		35.2,	29.2,	"Neutral")
	AddQuest(40185,	Z.THUNDER_TOTEM,		36.8,	78.8,	"Neutral")
	AddQuest(40186,	Z.THUNDER_TOTEM,		36.8,	78.8,	"Neutral")
	AddQuest(40188,	Z.AZSUNA,			47.4,	44.0,	"Neutral")
	AddQuest(40189,	Z.AZSUNA,			47.4,	44.0,	"Neutral")
	AddQuest(40191,	Z.THUNDER_TOTEM,		36.8,	78.8,	"Neutral")
	AddQuest(40192,	Z.THUNDER_TOTEM,		36.8,	78.8,	"Neutral")
	AddQuest(40194,	Z.AZSUNA,			47.4,	44.0,	"Neutral")
	AddQuest(40198,	Z.DALARAN_BROKENISLES,		35.4,	29.8,	"Neutral")
	AddQuest(40199,	Z.DALARAN_BROKENISLES,		34.6,	28.4,	"Neutral")
	AddQuest(40201,	Z.DALARAN_BROKENISLES,		35.2,	29.2,	"Neutral")
	AddQuest(40203,	Z.THUNDER_TOTEM,		36.8,	78.8,	"Neutral")
	AddQuest(40204, Z.THUNDER_TOTEM,		36.8,	78.8,	"Neutral")
	AddQuest(40205,	Z.THUNDER_TOTEM,		36.8,	78.8,	"Neutral")
	AddQuest(40207,	Z.AZSUNA,			47.4,	44.0,	"Neutral")
	AddQuest(40208,	Z.AZSUNA,			47.4,	44.0,	"Neutral")
	AddQuest(40209,	Z.AZSUNA,			47.4,	44.0,	"Neutral")
	AddQuest(40215,	Z.DALARAN_BROKENISLES,		35.2,	29.2,	"Neutral")
	AddQuest(40214,	Z.SURAMAR,			26.6,	71.6,	"Neutral")
	AddQuest(40327,	Z.AZSUNA,			51.6,	58.0,	"Neutral")
	AddQuest(41639,	Z.AZSUNA,			46.8,	41.4,	"Neutral")
	AddQuest(41640,	Z.VALSHARAH,			54.6,	73.2,	"Neutral")
	AddQuest(41641,	Z.THUNDER_TOTEM,		38.4,	46.0,	"Neutral")
	AddQuest(41642,	Z.STORMHEIM,			60.2,	51.2,	"Neutral")
	AddQuest(41643,	Z.SURAMAR,			36.8,	46.6,	"Neutral")
	AddQuest(41644,	Z.DALARAN_BROKENISLES,		33.4,	48.0,	"Neutral")
	AddQuest(41889,	Z.DALARAN_BROKENISLES,		35.2,	29.2,	"Neutral")
	AddQuest(48078, Z.ARGUS,			0.0,	0.0,	"Neutral") --Needs updating
	AddQuest(55223,	Z.DAZARALOR,			42.2,	38.0,	"Horde")
	AddQuest(55235,	Z.BORALUS,			69.4,	29.8,	"Alliance")
	AddQuest(64016, Z.KORTHIA,			60.4,	27.8,	"Neutral")
	AddQuest(64065, Z.KORTHIA,			60.4,	27.8,	"Neutral")

	self.InitializeQuests = nil
end
