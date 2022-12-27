local addon, TNI = ...
local ACR = LibStub("AceConfigRegistry-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local ACC = LibStub("AceConfigCmd-3.0")
local frameref

local L = LibStub("AceLocale-3.0"):GetLocale(addon)

-- The indicator textures provided by the AddOn. Used for the texture dropdowns.
local TEXTURE_NAMES = {
	"Reticule",
	"RedArrow",
	"NeonReticule",
	"NeonRedArrow",
	"RedChevronArrow",
	"PaleRedChevronArrow",
	"arrow_tip_green",
	"arrow_tip_red",
	"skull",
	"circles_target",
	"red_star",
	"greenarrowtarget",
	"BlueArrow",
	"bluearrow1",
	"gearsofwar",
	"malthael",
	"NewRedArrow",
	"NewSkull",
	"PurpleArrow",
	"Shield",
	"NeonGreenArrow",
	"Q_FelFlamingSkull",
	"Q_RedFlamingSkull",
	"Q_ShadowFlamingSkull",
	"Q_GreenGPS",
	"Q_RedGPS",
	"Q_WhiteGPS",
	"Q_GreenTarget",
	"Q_RedTarget",
	"Q_WhiteTarget",
	"Hunters_Mark",
	"Arrows_Towards",
	"Arrows_Away",
	"Arrows_SelfTowards",
	"Arrows_SelfAway",
	"Arrows_FriendTowards",
	"Arrows_FriendAway",
	"Arrows_FocusTowards",
	"Arrows_FocusAway",
}

-- Add the directory prefix to the texture names and localise the descriptions
local TEXTURES = {
	custom = "Custom"
}
do
	for _, textureName in ipairs(TEXTURE_NAMES) do
		local description = L[("Dropdown.Texture.%s.Desc"):format(textureName)]
		TEXTURES["Interface\\AddOns\\TargetNameplateIndicator\\Textures\\" .. textureName] = ("%s - %s"):format(textureName, description)
	end
end

-- The points that regions can be anchored to/by. Used for the texture and anchor point dropdowns.
local REGION_POINT_NAMES = {
	"TOP",
	"RIGHT",
	"BOTTOM",
	"LEFT",
	"TOPRIGHT",
	"TOPLEFT",
	"BOTTOMLEFT",
	"BOTTOMRIGHT",
	"CENTER",
}

-- Localise the region point descriptions
local REGION_POINTS = {}
do
	for _, regionPoint in ipairs(REGION_POINT_NAMES) do
		REGION_POINTS[regionPoint] = L[("Dropdown.RegionPoint.%s.Desc"):format(regionPoint)]
	end
end

-- The index of the unit token in the AceConfig info table
local UNIT_INFO_INDEX = 2

-- Finds the table and key in the DB profile from an AceConfig info table
local function findProfileTableAndKey(info)
	local tab = TNI.db.profile
	local key = info[UNIT_INFO_INDEX] -- Skip the "indicators" group at index 1

	for i = UNIT_INFO_INDEX + 1, #info do
		tab = tab[key]
		key = info[i]
	end

	return tab, key
end

local function get(info)
	local tab, key = findProfileTableAndKey(info)
	return tab[key]
end

local function set(info, val)
	local tab, key = findProfileTableAndKey(info)
	tab[key] = val

	local unit = info[UNIT_INFO_INDEX]
	TNI:RefreshIndicator(unit)
end

local function getNumber(info)
	local val = get(info)
	return tostring(val)
end

local function setNumber(info, val)
	val = tonumber(val)
	set(info, val)
end

local function getName(info)
	return L[("Option.UnitReactionType.%s.Name"):format(info[#info])]
end

local function getDesc(info)
	return L[("Option.UnitReactionType.%s.Desc"):format(info[#info])]
end

-- Validates that the value is a number
local function validateAnyNumber(info, val)
	local number = tonumber(val)

	-- Must be a number
	if not number then
		return false
	end

	return true
end

-- Validates that the value is a positive number
local function validatePositiveNumber(info, val)
	local number = tonumber(val)

	-- Must be a number
	if not number then
		return false
	end

	-- Must be positive
	if number <= 0 then
		return false
	end

	return true
end

-- Validates that the value is a number between 0 and 1
local function validateFractionalNumber(info, val)
	local number = tonumber(val)

	-- Must be a number
	if not number then
		return false
	end

	-- Must be between 0 and 1
	if number < 0 or number > 1 then
		return false
	end

	return true
end

local function CreateUnitRectionTypeConfigTable(unit, unitReactionType, order)
	local index = 0

	local function nextIndex()
		index = index + 1
		return index
	end

	return {
		name = L[("Group.%s.Name"):format(unitReactionType)],
		desc = L[("Group.%s.%s.Desc"):format(unit, unitReactionType)],
		order = order,
		type = "group",
		args = {
			enable = {
				name = getName,
				desc = getDesc,
				order = nextIndex(),
				type = "toggle",
			},
			texture = {
				name = getName,
				desc = getDesc,
				order = nextIndex(),
				width = "full",
				type = "select",
				values = TEXTURES,
				style = "dropdown",
			},
			textureCustom = {
				name = getName,
				desc = getDesc,
				order = nextIndex(),
				width = "full",
				type = "input",
				hidden = function(info)
					local unitConfig, _ = findProfileTableAndKey(info)
					return unitConfig.texture ~= "custom"
				end,
			},
			textureDisplay = {
				name = "",
				width = "full",
				order = nextIndex(),
				type = "description",
				image = function(info)
					local unitConfig, _ = findProfileTableAndKey(info)

					if unitConfig.texture == "custom" then
						return unitConfig.textureCustom
					end

					return unitConfig.texture
				end,
				imageWidth = 100,
				imageHeight = 100,
			},
			width = {
				name = getName,
				desc = getDesc,
				order = nextIndex(),
				type = "input",
				validate = validatePositiveNumber,
				usage = L["Usage.PositiveNumber"],
				get = getNumber,
				set = setNumber,
			},
			height = {
				name = getName,
				desc = getDesc,
				order = nextIndex(),
				type = "input",
				validate = validatePositiveNumber,
				usage = L["Usage.PositiveNumber"],
				get = getNumber,
				set = setNumber,
			},
			opacity = {
				name = getName,
				desc = getDesc,
				order = nextIndex(),
				type = "input",
				validate = validateFractionalNumber,
				usage = L["Usage.FractionalNumber"],
				get = getNumber,
				set = setNumber,
			},
			texturePoint = {
				name = getName,
				desc = getDesc,
				order = nextIndex(),
				width = "full",
				type = "select",
				values = REGION_POINTS,
				style = "dropdown",
			},
			anchorPoint = {
				name = getName,
				desc = getDesc,
				order = nextIndex(),
				type = "select",
				width = "full",
				values = REGION_POINTS,
				style = "dropdown",
			},
			xOffset = {
				name = getName,
				desc = getDesc,
				order = nextIndex(),
				type = "input",
				validate = validateAnyNumber,
				usage = L["Usage.AnyNumber"],
				get = getNumber,
				set = setNumber,
			},
			yOffset = {
				name = getName,
				desc = getDesc,
				order = nextIndex(),
				type = "input",
				validate = validateAnyNumber,
				usage = L["Usage.AnyNumber"],
				get = getNumber,
				set = setNumber,
			},
		},
	}
end

local function CreateUnitConfigTable(unit)
	return {
		name = L[("Group.%s.Name"):format(unit)],
		type = "group",
		childGroups = "tab",
		args = {
			enable = {
				name = L["Option.Unit.enable.Name"],
				desc = L["Option.Unit.enable.Desc"],
				type = "toggle",
			},
			self = CreateUnitRectionTypeConfigTable(unit, "self", 1),
			friendly = CreateUnitRectionTypeConfigTable(unit, "friendly", 2),
			hostile = CreateUnitRectionTypeConfigTable(unit, "hostile", 3),
		},
	}
end

local options = {
	name = "Target Nameplate Indicator",
	type = "group",
	args = {
		indicators = {
			name = L["Group.indicators.Name"],
			order = 1,
			type = "group",
			args = {
				target = CreateUnitConfigTable("target"),
				mouseover = CreateUnitConfigTable("mouseover"),
				focus = CreateUnitConfigTable("focus"),
				targettarget = CreateUnitConfigTable("targettarget"),
			},
		},
	},
	get = get,
	set = set,
}

local slashes = {
	"targetnameplateindicator",
	"tni",
}

TNI.ACC_HandleCommand = ACC.HandleCommand

local slash = slashes[1]
function TNI:HandleChatCommand(input)
	if input:trim() == "" then
		InterfaceOptionsFrame_OpenToCategory(frameref)
	else
		self:ACC_HandleCommand(slash, addon, input)
	end
end

function TNI:RegisterOptions()
	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	ACR:RegisterOptionsTable(addon, options)
	frameref = ACD:AddToBlizOptions(addon)
	for _, cmd in ipairs(slashes) do
		self:RegisterChatCommand(cmd, "HandleChatCommand")
	end
end
