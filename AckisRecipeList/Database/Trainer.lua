-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name, true)

-- ----------------------------------------------------------------------------
-- Imports.
-- ----------------------------------------------------------------------------
local Z = private.ZONE_NAMES

function addon:AddTrainer(module, entity)
	private.AcquireTypes.Trainer:AddEntity(module, entity)

	if _G.type(entity.name) == "number" then
		entity.spell_id = entity.name
		entity.name = _G.GetSpellInfo(entity.name)
	else
		entity.name = L[entity.name]
	end
end

function addon:InitTrainer()
	local function AddTrainer(trainerID, trainerName, zoneName, coordX, coordY, faction)
		return addon:AddTrainer(addon, {
			coord_x = coordX,
			coord_y = coordY,
			faction = faction,
			identifier = trainerID,
			item_list = {},
			locationName = zoneName,
			name = trainerName,
		})
	end

	AddTrainer(45286, "KTC Train-a-Tron Deluxe", 	Z.THE_LOST_ISLES, 	53.0, 35.6, 	"Horde")
	AddTrainer(47384, "Lien Farner", 		Z.ELWYNN_FOREST, 	41.95, 67.16, 	"Alliance")
	AddTrainer(47396, "Wembil Taskwidget", 		Z.DUN_MOROGH, 		53.8, 52.0, 	"Alliance")
	AddTrainer(47400, "Nedric Sallow", 		Z.TIRISFAL_GLADES, 	61.1, 51.1, 	"Horde")
	AddTrainer(47418, "Runda", 			Z.DUROTAR, 		52.8, 42.0, 	"Horde")
	AddTrainer(47419, "Lalum Darkmane", 		Z.MULGORE, 		46.4, 57.6, 	"Horde")
	AddTrainer(47420, "Iranis Shadebloom", 		Z.TELDRASSIL, 		56.0, 52.2, 	"Alliance")
	AddTrainer(47421, "Saren", 			Z.EVERSONG_WOODS, 	48.8, 46.8, 	"Horde")
	AddTrainer(47431, "Valn", 			Z.AZUREMYST_ISLE, 	48.7, 52.4, 	"Alliance")
	AddTrainer(48619, "Therisa Sallow", 		Z.TIRISFAL_GLADES,	44.6, 53.1, 	"Horde")
	AddTrainer(49885, "KTC Train-a-Tron Deluxe", 	Z.AZSHARA, 		57.0, 50.6, 	"Horde")
	AddTrainer(50247, "Jack \"All-Trades\" Derrington", Z.GILNEAS, 		41.6, 37.6, 	"Alliance")
	AddTrainer(57620, "Whittler Dewei", 		Z.THE_WANDERING_ISLE, 	63.0, 41.4, 	"Neutral")
	AddTrainer(65043, "Elder Oakpaw", 		Z.THE_WANDERING_ISLE, 	50.6, 58.6, 	"Neutral")
	AddTrainer(153811, "Instructor Okanu",		Z.NAZJATAR,		38.0, 53.2,	"Alliance")
	AddTrainer(153817, "Instructor Alikana",	Z.NAZJATAR,		38.0, 53.6,	"Alliance")
	AddTrainer(154257, "Instructor Ulooaka",	Z.NAZJATAR,		38.0, 53.0,	"Alliance")
	AddTrainer(154321, "Jada",			Z.NAZJATAR,		49.0, 61.4,	"Horde")
	AddTrainer(154393, "Narv",			Z.NAZJATAR,		49.0, 61.4,	"Horde")
	AddTrainer(154408, "Rolm",			Z.NAZJATAR,		49.2, 61.8,	"Horde")

	self.InitTrainer = nil
end
