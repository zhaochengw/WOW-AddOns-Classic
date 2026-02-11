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

	AddQuest(14151,	Z.DALARAN_NORTHREND,			42.5,	32.1,	"Neutral")
	AddQuest(41657,	Z.AZSUNA,				46.8,	41.1,	"Neutral")
	AddQuest(41658,	Z.VALSHARAH,				54.6,	73.2,	"Neutral")
	AddQuest(41659,	Z.THUNDER_TOTEM,			38.4,	46.0,	"Neutral")
	AddQuest(41661,	Z.SURAMAR,				36.4,	46.8,	"Neutral")
	AddQuest(41662,	Z.DALARAN_BROKENISLES,			33.4,	47.8,	"Neutral")
	AddQuest(48002,	Z.KROKUUN,				56.1,	66.8,	"Neutral")
	AddQuest(48013,	Z.KROKUUN,				56.1,	66.8,	"Neutral")
	AddQuest(48016,	Z.KROKUUN,				56.1,	66.8,	"Neutral")
	AddQuest(48318,	Z.KROKUUN,				56.1,	66.8,	"Neutral")
	AddQuest(48323,	Z.KROKUUN,				56.1,	66.8,	"Neutral")
	AddQuest(52331,	Z.BORALUS,				73.2,	11.0,	"Alliance") -- World Quest
	AddQuest(52332,	Z.STORMSONG_VALLEY,			59.2,	69.4,	"Alliance") -- World Quest
	AddQuest(52333,	Z.BORALUS,				67.6,	21.8,	"Alliance") -- World Quest
	AddQuest(52334,	Z.DRUSTVAR,				37.8,	49.0,	"Alliance") -- World Quest
	AddQuest(52335,	Z.DAZARALOR,				44.2,	32.2,	"Horde") -- World Quest
	AddQuest(52336,	Z.DAZARALOR,				65.6,	72.4,	"Horde") -- World Quest
	AddQuest(52337,	Z.NAZMIR,				39.0,	79.4,	"Horde") -- World Quest
	AddQuest(52338,	Z.VOLDUN,				56.6,	49.8,	"Horde") -- World Quest
	AddQuest(50112,	Z.DAZARALOR,				42.2,	38.0,	"Horde")
	AddQuest(50121,	Z.BORALUS,				74.2,	6.6,	"Alliance")
	AddQuest(56570,	Z.NAZJATAR,				38.0,	55.6,	"Alliance") -- World Quest
	AddQuest(56767,	Z.NAZJATAR,				38.0,	55.6,	"Alliance") -- World Quest
	AddQuest(56768,	Z.NAZJATAR,				38.0,	55.6,	"Alliance") -- World Quest
	AddQuest(56769,	Z.NAZJATAR,				38.0,	55.6,	"Alliance") -- World Quest
	AddQuest(56770,	Z.NAZJATAR,				50.8,	65.2,	"Horde") -- World Quest
	AddQuest(56772,	Z.NAZJATAR,				50.8,	65.2,	"Horde") -- World Quest
	AddQuest(56773,	Z.NAZJATAR,				50.8,	65.2,	"Horde") -- World Quest
	AddQuest(56774,	Z.NAZJATAR,				50.8,	65.2,	"Horde") -- World Quest

	self.InitializeQuests = nil
end
