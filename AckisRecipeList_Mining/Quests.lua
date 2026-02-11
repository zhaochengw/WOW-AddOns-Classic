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

	AddQuest(4083,	Z.BLACKROCK_DEPTHS,		0,	0,	"Neutral")
	AddQuest(38792,	Z.HIGHMOUNTAIN,			55.0,	84.0,	"Neutral")
	AddQuest(38793,	Z.HIGHMOUNTAIN,			55.0,	84.0,	"Neutral")
	AddQuest(38794,	Z.HIGHMOUNTAIN,			55.0,	84.0,	"Neutral")
	AddQuest(38800,	Z.SURAMAR,			29.8,	53.4,	"Neutral")
	AddQuest(38801,	Z.SURAMAR,			29.8,	53.4,	"Neutral")
	AddQuest(38802,	Z.SURAMAR,			29.8,	53.4,	"Neutral")
	AddQuest(38804,	Z.SURAMAR,			37.2,	70.8,	"Neutral")
	AddQuest(38805,	Z.SURAMAR,			64.2,	54.3,	"Neutral")
	AddQuest(38807,	Z.DALARAN_BROKENISLES,		0,	0,	"Neutral") --Needs updating

	self.InitializeQuests = nil
end
