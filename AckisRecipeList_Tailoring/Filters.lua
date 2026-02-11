-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local pairs = _G.pairs

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

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(constants.addon_name)

-- MoP-safe fallbacks for globals that may not exist or to satisfy static analyzers
local ARMOR = rawget(_G, "ARMOR") or L["Armor"] or "Armor"
local GENERAL = rawget(_G, "GENERAL") or L["General"] or "General"
local INVTYPE_CLOAK = rawget(_G, "INVTYPE_CLOAK") or L["Back"] or "Back"
local INVTYPE_CHEST = rawget(_G, "INVTYPE_CHEST") or L["Chest"] or "Chest"
local INVTYPE_FEET = rawget(_G, "INVTYPE_FEET") or L["Feet"] or "Feet"
local INVTYPE_HAND = rawget(_G, "INVTYPE_HAND") or L["Hands"] or "Hands"
local INVTYPE_HEAD = rawget(_G, "INVTYPE_HEAD") or L["Head"] or "Head"
local INVTYPE_LEGS = rawget(_G, "INVTYPE_LEGS") or L["Legs"] or "Legs"
local INVTYPE_BODY = rawget(_G, "INVTYPE_BODY") or L["Shirt"] or "Shirt"
local INVTYPE_SHOULDER = rawget(_G, "INVTYPE_SHOULDER") or L["Shoulder"] or "Shoulder"
local INVTYPE_WAIST = rawget(_G, "INVTYPE_WAIST") or L["Waist"] or "Waist"
local INVTYPE_WRIST = rawget(_G, "INVTYPE_WRIST") or L["Wrist"] or "Wrist"
local INVTYPE_BAG = rawget(_G, "INVTYPE_BAG") or L["Bag"] or "Bag"
local MISCELLANEOUS = rawget(_G, "MISCELLANEOUS") or L["Miscellaneous"] or "Miscellaneous"
local TRANSMOGRIFY = rawget(_G, "TRANSMOGRIFY") or L["Transmogrify"] or "Transmogrify"

-------------------------------------------------------------------------------
-- What we're really here for.
-------------------------------------------------------------------------------
module.ITEM_FILTER_TYPES = {
	TAILORING_BACK = true,
	TAILORING_BAG = true,
	TAILORING_CHEST = true,
	TAILORING_FEET = true,
	TAILORING_HANDS = true,
	TAILORING_HEAD = true,
	TAILORING_ITEM_ENHANCEMENT = true,
	TAILORING_LEGS = true,
	TAILORING_MATERIALS = true,
	TAILORING_MISC = true,
	TAILORING_SHIRT = true,
	TAILORING_SHOULDER = true,
	TAILORING_TRANSMOG = true,
	TAILORING_WAIST = true,
	TAILORING_WRIST = true,
	TAILORING_BANDAGES = true,
}

function module:InitializeItemFilters(parent_panel)
	local MainPanel = addon.Frame

	local armor_toggle = _G.CreateFrame("Button", nil, parent_panel)
	armor_toggle:SetWidth(105)
	armor_toggle:SetHeight(20)
	armor_toggle:SetNormalFontObject("QuestTitleFont")
	armor_toggle:SetHighlightFontObject("QuestTitleFontBlackShadow")
	armor_toggle:SetText(ARMOR .. ":")
	armor_toggle:SetPoint("TOP", parent_panel, "TOP", 0, -7)
	armor_toggle:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	addon.SetTooltipScripts(armor_toggle, L["GROUP_TOGGLE_FORMAT"]:format(ARMOR))

	local armor_types = {
		tailoring_back		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_CLOAK), 	text = INVTYPE_CLOAK,	row = 1, col = 1 },
		tailoring_chest		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_CHEST), 	text = INVTYPE_CHEST,	row = 1, col = 2 },
		tailoring_feet		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_FEET), 	text = INVTYPE_FEET,		row = 2, col = 1 },
		tailoring_hands		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_HAND), 	text = INVTYPE_HAND,		row = 2, col = 2 },
		tailoring_head		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_HEAD), 	text = INVTYPE_HEAD,		row = 3, col = 1 },
		tailoring_legs		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_LEGS), 	text = INVTYPE_LEGS,		row = 3, col = 2 },
		tailoring_shirt		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_BODY), 	text = INVTYPE_BODY,		row = 4, col = 1 },
		tailoring_shoulder	= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_SHOULDER), 	text = INVTYPE_SHOULDER,	row = 4, col = 2 },
		tailoring_waist		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_WAIST), 	text = INVTYPE_WAIST,	row = 5, col = 1 },
		tailoring_wrist		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_WRIST), 	text = INVTYPE_WRIST,	row = 5, col = 2 },
	}

	armor_toggle:SetScript("OnClick", function(self, button)
		local toggle = (button == "LeftButton") and true or false

		for item in pairs(armor_types) do
			module.db.profile.filters.item[item] = toggle
			parent_panel[item]:SetChecked(toggle)
		end
		MainPanel:UpdateTitle()
		MainPanel.list_frame:Update(nil, false)
	end)

	parent_panel.armor_toggle = armor_toggle

	local armor_panel = _G.CreateFrame("Frame", nil, parent_panel)
	armor_panel:SetHeight(100)
	armor_panel:SetPoint("TOP", armor_toggle, "BOTTOM")
	armor_panel:SetPoint("LEFT", parent_panel, "LEFT")
	armor_panel:SetPoint("RIGHT", parent_panel, "RIGHT")

	addon.GenerateCheckBoxes(parent_panel, armor_types, armor_panel)

	for item_type in pairs(armor_types) do
		MainPanel.filter_menu.value_map[item_type] = {
			cb = MainPanel.filter_menu.item.items_tailoring[item_type],
			svroot = self.db.profile.filters.item
		}
	end

	-------------------------------------------------------------------------------
	-- Create the General toggle and CheckButtons
	-------------------------------------------------------------------------------
	local general_toggle = _G.CreateFrame("Button", nil, parent_panel)
	general_toggle:SetWidth(105)
	general_toggle:SetHeight(20)
	general_toggle:SetNormalFontObject("QuestTitleFont")
	general_toggle:SetHighlightFontObject("QuestTitleFontBlackShadow")
	general_toggle:SetText(GENERAL .. ":")
	general_toggle:SetPoint("TOP", armor_panel, "BOTTOM", 0, 0)
	general_toggle:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	addon.SetTooltipScripts(general_toggle, L["GROUP_TOGGLE_FORMAT"]:format(GENERAL))

	local general_types = {
		tailoring_bag			= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_BAG),	text = INVTYPE_BAG,		row = 1, col = 1 },
		tailoring_item_enhancement	= { tt = L["FILTER_DESC_FORMAT"]:format(L["Item Enhancement"]),	text = L["Item Enhancement"],	row = 1, col = 2 },
		tailoring_materials		= { tt = L["FILTER_DESC_FORMAT"]:format(L["Materials"]),	text = L["Materials"],		row = 2, col = 1 },
		tailoring_misc			= { tt = L["FILTER_DESC_FORMAT"]:format(MISCELLANEOUS),	text = MISCELLANEOUS,	row = 2, col = 2 },
		tailoring_transmog		= { tt = L["FILTER_DESC_FORMAT"]:format(TRANSMOGRIFY),	text = TRANSMOGRIFY,		row = 3, col = 1 },
		tailoring_bandages 		= { tt = L["FILTER_DESC_FORMAT"]:format(L["Bandages"]),		text = L["Bandages"],		row = 3, col = 2 },
	}

	general_toggle:SetScript("OnClick", function(self, button)
		local toggle = (button == "LeftButton") and true or false

		for item in pairs(general_types) do
			module.db.profile.filters.item[item] = toggle
			parent_panel[item]:SetChecked(toggle)
		end
		MainPanel:UpdateTitle()
		MainPanel.list_frame:Update(nil, false)
	end)

	parent_panel.general_toggle = general_toggle

	local general_panel = _G.CreateFrame("Frame", nil, parent_panel)
	general_panel:SetHeight(70)
	general_panel:SetPoint("TOP", general_toggle, "BOTTOM")
	general_panel:SetPoint("LEFT", parent_panel, "LEFT")
	general_panel:SetPoint("RIGHT", parent_panel, "RIGHT")

	addon.GenerateCheckBoxes(parent_panel, general_types, general_panel)

	for item_type in pairs(general_types) do
		MainPanel.filter_menu.value_map[item_type] = {
			cb = MainPanel.filter_menu.item.items_tailoring[item_type],
			svroot = self.db.profile.filters.item
		}
	end
	self.InitializeItemFilters = nil
end
