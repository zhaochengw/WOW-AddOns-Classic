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

	AddQuest(39905,	Z.AZSUNA,			43.2,	43.6,	"Neutral")
	AddQuest(39923,	Z.AZSUNA,			47.2,	26.4,	"Neutral")
	AddQuest(39875, Z.DALARAN_BROKENISLES,		38.3,	41.5,	"Neutral")
	AddQuest(39882,	Z.VALSHARAH,			54.4,	57.6,	"Neutral")
	AddQuest(39883,	Z.THUNDER_TOTEM,		44.2,	45.2,	"Neutral")
	AddQuest(39904,	Z.STORMHEIM,			39.4,	42.6,	"Neutral")
	AddQuest(39910,	Z.AZSUNA,			46.8,	40.8,	"Neutral")
	AddQuest(39914,	Z.AZSUNA,			46.8,	40.8,	"Neutral")
	AddQuest(39918,	Z.AZSUNA,			46.8,	40.8,	"Neutral")
	AddQuest(41669,	Z.AZSUNA,			46.8,	41.4,	"Neutral")
	AddQuest(41670,	Z.VALSHARAH,			54.6,	73.2,	"Neutral")
	AddQuest(41671,	Z.THUNDER_TOTEM,		38.4,	46.0,	"Neutral")
	AddQuest(41672, Z.STORMHEIM,			60.2,	51.2,	"Neutral")
	AddQuest(41673,	Z.SURAMAR,			36.8,	46.6,	"Neutral")
	AddQuest(41674,	Z.DALARAN_BROKENISLES,		33.4,	48.0,	"Neutral")
	AddQuest(42170,	Z.VALSHARAH,			00.0,	00.0,	"Neutral")
	AddQuest(42233,	Z.HIGHMOUNTAIN,			00.0,	00.0,	"Neutral")
	AddQuest(42234,	Z.STORMHEIM,			00.0,	00.0,	"Neutral")
	AddQuest(42420,	Z.AZSUNA,			00.0,	00.0,	"Neutral")
	AddQuest(42971,	Z.DEEPHOLM,			56.4,	12.2,	"Neutral")
	AddQuest(52353,	Z.STORMSONG_VALLEY,		59.2,	69.4,	"Alliance")
	AddQuest(52354,	Z.STORMSONG_VALLEY,		59.2,	69.4,	"Alliance")
	AddQuest(52355,	Z.STORMSONG_VALLEY,		59.2,	69.4,	"Alliance")
	AddQuest(52356,	Z.BORALUS,			67.6,	21.8,	"Alliance")
	AddQuest(52357,	Z.DRUSTVAR,			37.8,	49.0,	"Alliance")
	AddQuest(52358,	Z.DAZARALOR,			65.6,	72.4,	"Horde")
	AddQuest(52359,	Z.DAZARALOR,			65.6,	72.4,	"Horde")
	AddQuest(52360,	Z.DAZARALOR,			65.6,	72.4,	"Horde")
	AddQuest(52361,	Z.NAZMIR,			39.0,	79.4,	"Horde")
	AddQuest(52362,	Z.VOLDUN,			56.6,	49.8,	"Horde")
	AddQuest(54005,	Z.BORALUS,			74.2,	11.4,	"Alliance")
	AddQuest(54161,	Z.DAZARALOR,			47.0,	35.8,	"Horde")
	AddQuest(56818,	Z.NAZJATAR,			50.8,	65.2,	"Horde")
	AddQuest(56819,	Z.NAZJATAR,			50.8,	65.2,	"Horde")
	AddQuest(56820,	Z.NAZJATAR,			50.8,	65.2,	"Horde")
	AddQuest(56821,	Z.NAZJATAR,			50.8,	65.2,	"Horde")
	AddQuest(56824,	Z.NAZJATAR,			38.0,	55.6,	"Alliance")
	AddQuest(56825,	Z.NAZJATAR,			38.0,	55.6,	"Alliance")
	AddQuest(56826,	Z.NAZJATAR,			38.0,	55.6,	"Alliance")
	AddQuest(56827,	Z.NAZJATAR,			38.0,	55.6,	"Alliance")

	self.InitializeQuests = nil
end
