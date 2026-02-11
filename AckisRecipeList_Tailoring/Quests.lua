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

	AddQuest(6032,	Z.FELWOOD,			65.7,	2.9,	"Neutral")
	AddQuest(38945,	Z.DALARAN_BROKENISLES,		35.2,	34.2,	"Neutral")
	AddQuest(38949,	Z.DALARAN_BROKENISLES,		49.8,	39.6,	"Neutral")
	AddQuest(38955,	Z.DALARAN_BROKENISLES,		49.8,	39.6,	"Neutral")
	AddQuest(38957,	Z.DALARAN_BROKENISLES,		49.8,	39.6,	"Neutral")
	AddQuest(38958,	Z.DALARAN_BROKENISLES,		36.2,	33.8,	"Neutral")
	AddQuest(38961,	Z.DALARAN_BROKENISLES,		35.2,	34.2,	"Neutral")
	AddQuest(38963,	Z.DALARAN_BROKENISLES,		49.8,	36.6,	"Neutral")
	AddQuest(38966,	Z.DALARAN_BROKENISLES,		35.2,	34.2,	"Neutral")
	AddQuest(38970, Z.SURAMAR,			40.4,	69.4,	"Neutral")
	AddQuest(38971,	Z.SURAMAR,			26.6,	71.6,	"Neutral") --Leyweather Athystro
	AddQuest(38974,	Z.STORMHEIM,			65.6,	56.4,	"Neutral")
	AddQuest(38975,	Z.SURAMAR,			40.2,	69.4,	"Neutral") --Leyweaver Mithrogane
	AddQuest(41645,	Z.AZSUNA,			46.8,	41.4,	"Neutral")
	AddQuest(41646,	Z.VALSHARAH,			54.6,	73.2,	"Neutral")
	AddQuest(41647,	Z.THUNDER_TOTEM,		38.4,	45.8,	"Neutral")
	AddQuest(41648,	Z.STORMHEIM,			60.2,	51.2,	"Neutral")
	AddQuest(41649,	Z.SURAMAR,			36.8,	46.6,	"Neutral")
	AddQuest(41650,	Z.DALARAN_BROKENISLES,		33.4,	48.0,	"Neutral")
	AddQuest(44741,	Z.SURAMAR,			40.4,	69.4,	"Neutral")
	AddQuest(48074,	Z.ARGUS,			0.0,	0.0,	"Neutral") -- Needs updating
	AddQuest(52422,	Z.STORMSONG_VALLEY,		59.2,	69.4,	"Alliance") -- Spirit of Freedom
	AddQuest(52423,	Z.BORALUS,			67.6,	21.8,	"Alliance") -- Phalanx Defense
	AddQuest(52424,	Z.DRUSTVAR,			37.8,	49.0,	"Alliance") -- Rallying Swiftness
	AddQuest(52425,	Z.DAZARALOR,			65.6,	72.4,	"Horde") -- Spirit of Freedom
	AddQuest(52426,	Z.NAZMIR,			39.0,	79.4,	"Horde") -- Phalanx Defense
	AddQuest(52427, Z.VOLDUN,			56.6,	49.8,	"Horde") -- Rallying Swiftness
	AddQuest(53881,	Z.BORALUS,			76.6,	11.8,	"Alliance") -- Synchronous Thread
	AddQuest(53962,	Z.DAZARALOR,			43.4,	34.6,	"Horde")  -- Synchronous Thread

	self.InitializeQuests = nil
end
