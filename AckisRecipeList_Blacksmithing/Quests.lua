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

	AddQuest(1578,	Z.IRONFORGE,			48.5,	43.0,	"Alliance")
	AddQuest(1618,	Z.IRONFORGE,			48.5,	43.0,	"Alliance")
	AddQuest(2751,	Z.ORGRIMMAR,			78.0,	21.4,	"Horde")
	AddQuest(2752,	Z.ORGRIMMAR,			78.0,	21.4,	"Horde")
	AddQuest(2753,	Z.ORGRIMMAR,			78.0,	21.4,	"Horde")
	AddQuest(2754,	Z.ORGRIMMAR,			78.0,	21.4,	"Horde")
	AddQuest(2755,	Z.ORGRIMMAR,			78.0,	21.4,	"Horde")
	AddQuest(7604,	Z.BLACKROCK_DEPTHS,		0,	0,	"Neutral")
	AddQuest(38500,	Z.DALARAN_BROKENISLES,		44.2,	28.7,	"Neutral")
	AddQuest(38501,	Z.DALARAN_BROKENISLES,		44.2,	28.7,	"Neutral")
	AddQuest(38519,	Z.HIGHMOUNTAIN,			55.0,	84.4,	"Neutral")
	AddQuest(38523,	Z.DALARAN_BROKENISLES,		44.2,	28.7,	"Neutral")
	AddQuest(38526,	Z.SURAMAR,			30.0,	53.2,	"Neutral")
	AddQuest(38528,	Z.SURAMAR,			30.0,	53.2,	"Neutral")
	AddQuest(38531,	Z.HIGHMOUNTAIN,			55.2,	84.2,	"Neutral")
	AddQuest(38533,	Z.HIGHMOUNTAIN,			54.6,	84.0,	"Neutral")
	AddQuest(38534,	Z.HIGHMOUNTAIN,			54.6,	84.0,	"Neutral")
	AddQuest(38536,	Z.HIGHMOUNTAIN,			54.6,	84.0,	"Neutral")
	AddQuest(38537,	Z.HIGHMOUNTAIN,			54.6,	84.0,	"Neutral")
	AddQuest(38538,	Z.HIGHMOUNTAIN,			54.6,	84.0,	"Neutral")
	AddQuest(38539,	Z.HIGHMOUNTAIN,			54.6,	84.0,	"Neutral")
	AddQuest(38541,	Z.HIGHMOUNTAIN,			54.6,	84.0,	"Neutral")
	AddQuest(38542,	Z.HIGHMOUNTAIN,			54.6,	84.0,	"Neutral")
	AddQuest(38833,	Z.HIGHMOUNTAIN,			54.6,	84.0,	"Neutral")
	AddQuest(39680,	Z.VALSHARAH,			40.0,	54.8,	"Neutral")
	AddQuest(39681,	Z.DALARAN_BROKENISLES,		44.2,	28.7,	"Neutral")
	AddQuest(39699,	Z.HIGHMOUNTAIN,			55.2,	84.2,	"Neutral")
	AddQuest(41160,	Z.SHATTRATH_CITY,		64.3,	71.8,	"Neutral")
	AddQuest(41633,	Z.AZSUNA,			46.8,	41.4,	"Neutral")
	AddQuest(41634,	Z.VALSHARAH,			54.6,	73.2,	"Neutral")
	AddQuest(41635,	Z.THUNDER_TOTEM,		38.4,	46.0,	"Neutral")
	AddQuest(41636,	Z.STORMHEIM,			60.2,	51.2,	"Neutral")
	AddQuest(41637,	Z.SURAMAR,			36.4,	46.8,	"Neutral")
	AddQuest(41638,	Z.DALARAN_BROKENISLES,		33.4,	47.8,	"Neutral")
	AddQuest(44449,	Z.DALARAN_BROKENISLES,		44.4,	28.8,	"Neutral")
	AddQuest(44863,	Z.SHATTRATH_CITY,		64.3,	71.8,	"Neutral")
	AddQuest(44926,	Z.BURNING_STEPPES,		00.0,	00.0,	"Neutral") -- Needs updating - Bleakwood Hew, not active
	AddQuest(44952,	Z.WINTERSPRING,			00.0,	00.0,	"Neutral") -- Needs updating
	AddQuest(45044,	Z.UNGORO_CRATER,		00.0,	00.0,	"Neutral") -- Needs updating - Darkspear, not active
	AddQuest(48053,	Z.DALARAN_BROKENISLES,		45.1,	28.6,	"Alliance")
	AddQuest(48054,	Z.DALARAN_BROKENISLES,		45.1,	28.6,	"Horde")
	AddQuest(48055,	Z.ARGUS,			0.0,	0.0,	"Neutral") -- Needs updating
	AddQuest(50123,	Z.BORALUS,			73.6,	8.6,	"Alliance")
	AddQuest(50276,	Z.DAZARALOR,			42.2,	38.0,	"Horde")

	self.InitializeQuests = nil
end
