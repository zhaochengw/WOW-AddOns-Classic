--[[
Copyright (c) 2009 - 2012 Ackis <John Pasula>
All rights reserved by the original author Ackis.
]]



local pairs = _G.pairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)

-- ----------------------------------------------------------------------------
-- Profession data.
-- ----------------------------------------------------------------------------
local PROFESSION_SPELL_IDS = {
	ALCHEMY = 2259,
	ARCHAEOLOGY = 78670, -- Only used for AcquireType.TradeSkill
	BLACKSMITHING = 2018,
	COOKING = 2550,
	ENCHANTING = 7411,
	ENGINEERING = 4036,
	FISHING = 7731, -- Only used for AcquireType.TradeSkill
	INSCRIPTION = 45357,
	JEWELCRAFTING = 25229,
	LEATHERWORKING = 2108,
	MINING = 2575,
	TAILORING = 3908,
}

private.PROFESSION_SPELL_IDS = PROFESSION_SPELL_IDS
private.constants.PROFESSION_SPELL_IDS = PROFESSION_SPELL_IDS

local LOCALIZED_PROFESSION_NAMES = {}
private.LOCALIZED_PROFESSION_NAMES = LOCALIZED_PROFESSION_NAMES

local LOCALIZED_PROFESSION_NAME_TO_LABEL = {}
private.LOCALIZED_PROFESSION_NAME_TO_LABEL = LOCALIZED_PROFESSION_NAME_TO_LABEL

local PROFESSION_ID_TO_LOCALIZED_NAME = {}
private.PROFESSION_ID_TO_LOCALIZED_NAME = PROFESSION_ID_TO_LOCALIZED_NAME

for label, spellID in pairs(PROFESSION_SPELL_IDS) do
	local professionName = _G.GetSpellInfo(spellID)
	if professionName then
		LOCALIZED_PROFESSION_NAME_TO_LABEL[professionName] = label
		LOCALIZED_PROFESSION_NAMES[label] = professionName
		PROFESSION_ID_TO_LOCALIZED_NAME[spellID] = professionName
	end
end

local LOCALIZED_SPELL_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING = {}

local function MapSpellToProfession(spellID, label)
	local name = _G.GetSpellInfo(spellID)
	local profName = LOCALIZED_PROFESSION_NAMES[label]
	if name and profName then
		LOCALIZED_SPELL_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING[name] = profName
	end
end

-- Alchemy
MapSpellToProfession(264213, 'ALCHEMY') -- Outland Alchemy
MapSpellToProfession(264220, 'ALCHEMY') -- Northrend Alchemy
MapSpellToProfession(264243, 'ALCHEMY') -- Cataclysm Alchemy
MapSpellToProfession(264245, 'ALCHEMY') -- Pandaria Alchemy
MapSpellToProfession(264247, 'ALCHEMY') -- Draenor Alchemy
MapSpellToProfession(264250, 'ALCHEMY') -- Legion Alchemy
MapSpellToProfession(264255, 'ALCHEMY') -- Kul Tiran Alchemy
MapSpellToProfession(265787, 'ALCHEMY') -- Zandalari Alchemy

-- Blacksmithing
MapSpellToProfession(264436, 'BLACKSMITHING') -- Outland
MapSpellToProfession(264438, 'BLACKSMITHING') -- Northrend
MapSpellToProfession(264440, 'BLACKSMITHING') -- Cataclysm
MapSpellToProfession(264442, 'BLACKSMITHING') -- Pandaria
MapSpellToProfession(264444, 'BLACKSMITHING') -- Draenor
MapSpellToProfession(264446, 'BLACKSMITHING') -- Legion
MapSpellToProfession(264448, 'BLACKSMITHING') -- Kul Tiran
MapSpellToProfession(265803, 'BLACKSMITHING') -- Zandalari

-- Cooking (Way of ...)
MapSpellToProfession(124694, 'COOKING') -- Way of the Grill
MapSpellToProfession(125584, 'COOKING') -- Way of the Wok
MapSpellToProfession(125586, 'COOKING') -- Way of the Pot
MapSpellToProfession(125587, 'COOKING') -- Way of the Steamer
MapSpellToProfession(125588, 'COOKING') -- Way of the Oven
MapSpellToProfession(125589, 'COOKING') -- Way of the Brew
-- Cooking (expansion tracks)
MapSpellToProfession(264634, 'COOKING') -- Outland
MapSpellToProfession(264636, 'COOKING') -- Northrend
MapSpellToProfession(264638, 'COOKING') -- Cataclysm
MapSpellToProfession(264640, 'COOKING') -- Pandaria
MapSpellToProfession(264642, 'COOKING') -- Draenor
MapSpellToProfession(264644, 'COOKING') -- Legion
MapSpellToProfession(264647, 'COOKING') -- Kul Tiran
MapSpellToProfession(265817, 'COOKING') -- Zandalari

-- Enchanting
MapSpellToProfession(264460, 'ENCHANTING') -- Outland
MapSpellToProfession(264462, 'ENCHANTING') -- Northrend
MapSpellToProfession(264464, 'ENCHANTING') -- Cataclysm
MapSpellToProfession(264467, 'ENCHANTING') -- Pandaria
MapSpellToProfession(264469, 'ENCHANTING') -- Draenor
MapSpellToProfession(264471, 'ENCHANTING') -- Legion
MapSpellToProfession(264473, 'ENCHANTING') -- Kul Tiran
MapSpellToProfession(265805, 'ENCHANTING') -- Zandalari

-- Engineering
MapSpellToProfession(264479, 'ENGINEERING') -- Outland
MapSpellToProfession(264481, 'ENGINEERING') -- Northrend
MapSpellToProfession(264483, 'ENGINEERING') -- Cataclysm
MapSpellToProfession(264485, 'ENGINEERING') -- Pandaria
MapSpellToProfession(264487, 'ENGINEERING') -- Draenor
MapSpellToProfession(264490, 'ENGINEERING') -- Legion
MapSpellToProfession(264492, 'ENGINEERING') -- Kul Tiran
MapSpellToProfession(265807, 'ENGINEERING') -- Zandalari

-- Inscription
MapSpellToProfession(264496, 'INSCRIPTION') -- Outland
MapSpellToProfession(264498, 'INSCRIPTION') -- Northrend
MapSpellToProfession(264500, 'INSCRIPTION') -- Cataclysm
MapSpellToProfession(264502, 'INSCRIPTION') -- Pandaria
MapSpellToProfession(264504, 'INSCRIPTION') -- Draenor
MapSpellToProfession(264506, 'INSCRIPTION') -- Legion
MapSpellToProfession(264508, 'INSCRIPTION') -- Kul Tiran
MapSpellToProfession(265809, 'INSCRIPTION') -- Zandalari

-- Jewelcrafting
MapSpellToProfession(264534, 'JEWELCRAFTING') -- Outland
MapSpellToProfession(264537, 'JEWELCRAFTING') -- Northrend
MapSpellToProfession(264539, 'JEWELCRAFTING') -- Cataclysm
MapSpellToProfession(264542, 'JEWELCRAFTING') -- Pandaria
MapSpellToProfession(264544, 'JEWELCRAFTING') -- Draenor
MapSpellToProfession(264546, 'JEWELCRAFTING') -- Legion
MapSpellToProfession(264548, 'JEWELCRAFTING') -- Kul Tiran
MapSpellToProfession(265811, 'JEWELCRAFTING') -- Zandalari

-- Leatherworking
MapSpellToProfession(264579, 'LEATHERWORKING') -- Outland
MapSpellToProfession(264581, 'LEATHERWORKING') -- Northrend
MapSpellToProfession(264583, 'LEATHERWORKING') -- Cataclysm
MapSpellToProfession(264585, 'LEATHERWORKING') -- Pandaria
MapSpellToProfession(264588, 'LEATHERWORKING') -- Draenor
MapSpellToProfession(264590, 'LEATHERWORKING') -- Legion
MapSpellToProfession(264592, 'LEATHERWORKING') -- Kul Tiran
MapSpellToProfession(265813, 'LEATHERWORKING') -- Zandalari

-- Tailoring
MapSpellToProfession(264618, 'TAILORING') -- Outland
MapSpellToProfession(264620, 'TAILORING') -- Northrend
MapSpellToProfession(264622, 'TAILORING') -- Cataclysm
MapSpellToProfession(264624, 'TAILORING') -- Pandaria
MapSpellToProfession(264626, 'TAILORING') -- Draenor
MapSpellToProfession(264628, 'TAILORING') -- Legion
MapSpellToProfession(264630, 'TAILORING') -- Kul Tiran
MapSpellToProfession(265815, 'TAILORING') -- Zandalari

private.LOCALIZED_SPELL_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING = LOCALIZED_SPELL_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING

for name, localized_name in pairs(LOCALIZED_PROFESSION_NAMES) do
	LOCALIZED_SPELL_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING[localized_name] = localized_name
end

local ORDERED_LOCALIZED_PROFESSION_NAMES = {
	LOCALIZED_PROFESSION_NAMES.ALCHEMY, -- 1
	LOCALIZED_PROFESSION_NAMES.BLACKSMITHING, -- 2
	LOCALIZED_PROFESSION_NAMES.COOKING, -- 3
	LOCALIZED_PROFESSION_NAMES.ENCHANTING, -- 4
	LOCALIZED_PROFESSION_NAMES.ENGINEERING, -- 5
	LOCALIZED_PROFESSION_NAMES.INSCRIPTION, -- 7
	LOCALIZED_PROFESSION_NAMES.JEWELCRAFTING, -- 8
	LOCALIZED_PROFESSION_NAMES.LEATHERWORKING, -- 9
	LOCALIZED_PROFESSION_NAMES.MINING, -- 10
	LOCALIZED_PROFESSION_NAMES.TAILORING, -- 11
}

private.ORDERED_LOCALIZED_PROFESSION_NAMES = ORDERED_LOCALIZED_PROFESSION_NAMES

-- Required for loading profession modules.
-- Build mapping only for professions that exist on this client (avoid nil keys on Classic Era)
local LOCALIZED_PROFESSION_NAME_TO_MODULE_NAME_MAPPING = {}
local function AddProfMap(label, moduleName)
	local name = LOCALIZED_PROFESSION_NAMES[label]
	if name then
		LOCALIZED_PROFESSION_NAME_TO_MODULE_NAME_MAPPING[name] = moduleName
	end
end
AddProfMap('ALCHEMY', 'Alchemy')
AddProfMap('BLACKSMITHING', 'Blacksmithing')
AddProfMap('COOKING', 'Cooking')
AddProfMap('ENCHANTING', 'Enchanting')
AddProfMap('ENGINEERING', 'Engineering')
AddProfMap('INSCRIPTION', 'Inscription')
AddProfMap('JEWELCRAFTING', 'Jewelcrafting')
AddProfMap('LEATHERWORKING', 'Leatherworking')
AddProfMap('MINING', 'Mining')
AddProfMap('TAILORING', 'Tailoring')

private.LOCALIZED_PROFESSION_NAME_TO_MODULE_NAME_MAPPING = LOCALIZED_PROFESSION_NAME_TO_MODULE_NAME_MAPPING

local LOCALIZED_PROFESSION_NAME_TO_ID_MAPPING = {}
for index = 1, #ORDERED_LOCALIZED_PROFESSION_NAMES do
	local name = ORDERED_LOCALIZED_PROFESSION_NAMES[index]
	if name then
		LOCALIZED_PROFESSION_NAME_TO_ID_MAPPING[name] = index
	end
end

local MODULE_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING = {}
for localizedName, moduleName in pairs(LOCALIZED_PROFESSION_NAME_TO_MODULE_NAME_MAPPING) do
	if localizedName and moduleName then
		MODULE_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING[moduleName] = localizedName
		MODULE_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING[moduleName:lower()] = localizedName
	end
end

private.MODULE_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING = MODULE_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING

local ICON_TEXTURE_FORMAT = [[Interface\ICONS\%s]]
local WAYPOINT_ICON_TEXTURES = {
	[[Trade_Alchemy]], -- 01 (Alchemy)
	[[Trade_BlackSmithing]], -- 02 (Blacksmithing)
	[[INV_Misc_Food_15]], -- 03 (Cooking)
	[[Trade_Engraving]], -- 04 (Enchanting)
	[[Trade_Engineering]], -- 05 (Engineering)
	[[INV_Inscription_Tradeskill01]], -- 07 (Inscription)
	[[INV_Misc_Gem_01]], -- 08 (Jewelcrafting)
	[[Trade_LeatherWorking]], -- 09 (Leatherworking)
	[[Spell_Fire_FlameBlades]], -- 10 (Smelting)
	[[Trade_Tailoring]], -- 11 (Tailoring)
}

-- ----------------------------------------------------------------------------
-- Objects.
-- ----------------------------------------------------------------------------
local Profession = {}
local ProfessionMetatable = {
	__index = Profession,
}

private.Professions = {}

-- ----------------------------------------------------------------------------
-- Profession Methods.
-- ----------------------------------------------------------------------------
function Profession:ActivationSpellName()
	return self._activationSpellName
end

function Profession:ID()
	return self._id
end

function Profession:LocalizedName()
	return self._localizedName
end

function Profession:Module()
	return self._module
end

function Profession:Name()
	return self._name
end

function Profession:WaypointIconTexture()
	local idx = self._id or 1
	local icon = WAYPOINT_ICON_TEXTURES[idx] or WAYPOINT_ICON_TEXTURES[1]
	return ICON_TEXTURE_FORMAT:format(icon)
end

-- ----------------------------------------------------------------------------
-- Instantiation.
-- ----------------------------------------------------------------------------
function addon.CreateProfessionFromModule(module)
	local moduleName = module:GetName()

	local localizedProfessionName = MODULE_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING[moduleName]
	if localizedProfessionName then
		local profession = _G.setmetatable({
			_id = LOCALIZED_PROFESSION_NAME_TO_ID_MAPPING[localizedProfessionName],
			_localizedName = localizedProfessionName,
			_name = moduleName,
			_module = module,
			_recipeCount = 0,
			_activationSpellName = module.ActivationSpellID and _G.GetSpellInfo(module.ActivationSpellID) or localizedProfessionName,
			Recipes = module.Recipes,
		}, ProfessionMetatable)

		private.Professions[moduleName] = profession
		private.Professions[localizedProfessionName] = profession
		module.Profession = profession

		local defaults = {
			profile = {
				filters = {
					item = {} -- Populated below.
				}
			}
		}

		for filter_name in pairs(module.ITEM_FILTER_TYPES) do
			defaults.profile.filters.item[filter_name:lower()] = true
			addon.constants.ITEM_FILTER_TYPES[filter_name] = true
		end

		module.db = addon.db:RegisterNamespace(module.ModuleName, defaults)
	end
end
