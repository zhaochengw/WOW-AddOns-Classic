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

	AddQuest(39175,		Z.FROSTWALL,		42.0,	55.0,	"Horde")
	AddQuest(39195,		Z.LUNARFALL,		32.0,	31.4,	"Alliance")
	AddQuest(40526,		Z.AZSUNA,		46.6,	41.4,	"Neutral")
	AddQuest(40527,		Z.AZSUNA,		46.6,	41.4,	"Neutral")
	AddQuest(40528,		Z.AZSUNA,		46.6,	41.4,	"Neutral")
	AddQuest(40529,		Z.DALARAN_BROKENISLES,	39.6,	34.8,	"Neutral")
	AddQuest(40532,		Z.DALARAN_BROKENISLES,	39.6,	34.8,	"Neutral")
	AddQuest(40533,		Z.DALARAN_BROKENISLES,	39.6,	34.8,	"Neutral")
	AddQuest(40534,		Z.DALARAN_BROKENISLES,	39.6,	34.8,	"Neutral")
	AddQuest(40536,		Z.VALSHARAH,		45.4,	67.4,	"Neutral")
	AddQuest(40538,		Z.DALARAN_BROKENISLES,	39.6,	34.8,	"Neutral")
	AddQuest(40539,		Z.DALARAN_BROKENISLES,	0.0,	0.0,	"Neutral")
	AddQuest(40542,		Z.STORMHEIM,		42.2,	35.0,	"Neutral")
	AddQuest(40543,		Z.STORMHEIM,		42.2,	35.0,	"Neutral")
	AddQuest(40544,		Z.STORMHEIM,		42.2,	35.0,	"Neutral")
	AddQuest(40546,		Z.STORMHEIM,		42.2,	35.0,	"Neutral")
	AddQuest(40558,		Z.DALARAN_BROKENISLES,	39.6,	34.8,	"Neutral")
	AddQuest(40559,		Z.DALARAN_BROKENISLES,	39.6,	34.8,	"Neutral")
	AddQuest(40560,		Z.DALARAN_BROKENISLES,	39.6,	34.8,	"Neutral")
	AddQuest(40561,		Z.DALARAN_BROKENISLES,	39.6,	34.8,	"Neutral")
	AddQuest(41652,		Z.VALSHARAH,		54.6,	73.2,	"Neutral")
	AddQuest(41651,		Z.AZSUNA,		46.8,	41.4,	"Neutral")
	AddQuest(41653,		Z.THUNDER_TOTEM,	38.4,	46.0,	"Neutral")
	AddQuest(41654,		Z.STORMHEIM,		60.2,	51.2,	"Neutral")
	AddQuest(41655,		Z.SURAMAR,		36.8,	46.6,	"Neutral")
	AddQuest(41656,		Z.DALARAN_BROKENISLES,	33.4,	18.0,	"Neutral")
	AddQuest(48075,		Z.ARGUS,		0.0,	0.0,	"Neutral") -- Needs updating
	AddQuest(48076,		Z.ARGUS,		0.0,	0.0,	"Neutral") -- Needs updating
	AddQuest(49570,		Z.BORALUS,		0.0,	0.0,	"Alliance") -- Needs updating
	AddQuest(49585,		Z.DAZARALOR,		0.0,	0.0,	"Horde") -- Needs updating

	self.InitializeQuests = nil
end
