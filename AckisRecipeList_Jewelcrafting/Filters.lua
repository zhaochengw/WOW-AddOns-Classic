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

local NONEQUIPSLOT = rawget(_G, "NONEQUIPSLOT") or L["Created Item"] or "Created Item"
local MOUNTS = rawget(_G, "MOUNTS") or L["Mounts"] or "Mounts"
local PETS = rawget(_G, "PETS") or L["Pets"] or "Pets"
local EQUIPPABLE_TITLE = rawget(_G, "TUTORIAL_TITLE24") or L["Equippable Items"] or "Equippable Items"
local GENERAL = rawget(_G, "GENERAL") or L["General"] or "General"
local BLUE_GEM = rawget(_G, "BLUE_GEM") or L["Blue Gem"] or "Blue Gem"
local META_GEM = rawget(_G, "META_GEM") or L["Meta Gem"] or "Meta Gem"
local RED_GEM = rawget(_G, "RED_GEM") or L["Red Gem"] or "Red Gem"
local YELLOW_GEM = rawget(_G, "YELLOW_GEM") or L["Yellow Gem"] or "Yellow Gem"
local INVTYPE_HEAD = rawget(_G, "INVTYPE_HEAD") or L["Head"] or "Head"
local INVTYPE_NECK = rawget(_G, "INVTYPE_NECK") or L["Neck"] or "Neck"
local INVTYPE_FINGER = rawget(_G, "INVTYPE_FINGER") or L["Finger"] or "Finger"
local INVTYPE_TRINKET = rawget(_G, "INVTYPE_TRINKET") or L["Trinket"] or "Trinket"

module.ITEM_FILTER_TYPES = {
	JEWELCRAFTING_CREATED_ITEM = true,
	JEWELCRAFTING_FIST_WEAPON = true,
	JEWELCRAFTING_HEAD = true,
	JEWELCRAFTING_MATERIALS = true,
	JEWELCRAFTING_NECK = true,
	JEWELCRAFTING_RING = true,
	JEWELCRAFTING_TRINKET = true,
	JEWELCRAFTING_GEM_BLUE = true,
	JEWELCRAFTING_GEM_GREEN = true,
	JEWELCRAFTING_GEM_META = true,
	JEWELCRAFTING_GEM_ORANGE = true,
	JEWELCRAFTING_GEM_PRISMATIC = true,
	JEWELCRAFTING_GEM_PURPLE = true,
	JEWELCRAFTING_GEM_RED = true,
	JEWELCRAFTING_GEM_YELLOW = true,
	JEWELCRAFTING_MOUNT = true,
	JEWELCRAFTING_PET = true,
	JEWELCRAFTING_ITEM_ENHANCEMENT = true,
	JEWELCRAFTING_STAFF = true,
}

function module:InitializeItemFilters(parent_panel)
	local MainPanel = addon.Frame

	local gem_toggle = _G.CreateFrame("Button", nil, parent_panel)
	gem_toggle:SetWidth(105)
	gem_toggle:SetHeight(20)
	gem_toggle:SetNormalFontObject("QuestTitleFont")
	gem_toggle:SetHighlightFontObject("QuestTitleFontBlackShadow")
	gem_toggle:SetText(L["Gems"] .. ":")
	gem_toggle:SetPoint("TOP", parent_panel, "TOP", 0, -7)
	gem_toggle:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	addon.SetTooltipScripts(gem_toggle, L["GROUP_TOGGLE_FORMAT"]:format(L["Gems"]))

	local gem_types = {
		jewelcrafting_gem_blue		= { tt = L["FILTER_DESC_FORMAT"]:format(BLUE_GEM), 		text = BLUE_GEM,		row = 1, col = 1 },
		jewelcrafting_gem_green		= { tt = L["FILTER_DESC_FORMAT"]:format(L["GREEN_GEM"]), 	text = L["GREEN_GEM"],		row = 1, col = 2 },
		jewelcrafting_gem_meta		= { tt = L["FILTER_DESC_FORMAT"]:format(META_GEM), 		text = META_GEM,		row = 2, col = 1 },
		jewelcrafting_gem_orange	= { tt = L["FILTER_DESC_FORMAT"]:format(L["ORANGE_GEM"]), 	text = L["ORANGE_GEM"],		row = 2, col = 2 },
		jewelcrafting_gem_prismatic	= { tt = L["FILTER_DESC_FORMAT"]:format(L["PRISMATIC_GEM"]), 	text = L["PRISMATIC_GEM"],	row = 3, col = 1 },
		jewelcrafting_gem_purple	= { tt = L["FILTER_DESC_FORMAT"]:format(L["PURPLE_GEM"]), 	text = L["PURPLE_GEM"],		row = 3, col = 2 },
		jewelcrafting_gem_red		= { tt = L["FILTER_DESC_FORMAT"]:format(RED_GEM), 		text = RED_GEM,		row = 4, col = 1 },
		jewelcrafting_gem_yellow	= { tt = L["FILTER_DESC_FORMAT"]:format(YELLOW_GEM), 	text = YELLOW_GEM,	row = 4, col = 2 },
	}

	gem_toggle:SetScript("OnClick", function(self, button)
		local toggle = (button == "LeftButton") and true or false

		for item in pairs(gem_types) do
			module.db.profile.filters.item[item] = toggle
			parent_panel[item]:SetChecked(toggle)
		end
		MainPanel:UpdateTitle()
		MainPanel.list_frame:Update(nil, false)
	end)

	parent_panel.gem_toggle = gem_toggle

	local gem_panel = _G.CreateFrame("Frame", nil, parent_panel)
	gem_panel:SetHeight(90)
	gem_panel:SetPoint("TOP", gem_toggle, "BOTTOM")
	gem_panel:SetPoint("LEFT", parent_panel, "LEFT")
	gem_panel:SetPoint("RIGHT", parent_panel, "RIGHT")

	addon.GenerateCheckBoxes(parent_panel, gem_types, gem_panel)

	for item_type in pairs(gem_types) do
		MainPanel.filter_menu.value_map[item_type] = {
			cb = MainPanel.filter_menu.item.items_jewelcrafting[item_type],
			svroot = self.db.profile.filters.item
		}
	end

	-------------------------------------------------------------------------------
	-- Create the Equippable Items toggle and CheckButtons
	-------------------------------------------------------------------------------
	local equippable_toggle = _G.CreateFrame("Button", nil, parent_panel)
	equippable_toggle:SetWidth(105)
	equippable_toggle:SetHeight(20)
	equippable_toggle:SetNormalFontObject("QuestTitleFont")
	equippable_toggle:SetHighlightFontObject("QuestTitleFontBlackShadow")
	equippable_toggle:SetText(EQUIPPABLE_TITLE .. ":")
	equippable_toggle:SetPoint("TOP", gem_panel, "BOTTOM", 0, 0)
	equippable_toggle:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	addon.SetTooltipScripts(equippable_toggle, L["GROUP_TOGGLE_FORMAT"]:format(EQUIPPABLE_TITLE))

	local equippable_types = {
		jewelcrafting_fist_weapon	= { tt = L["FILTER_DESC_FORMAT"]:format(L["Fist Weapon"]),	text = L["Fist Weapon"],	row = 1, col = 1 },
		jewelcrafting_head		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_HEAD),	text = INVTYPE_HEAD,	row = 1, col = 2 },
		jewelcrafting_neck		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_NECK),	text = INVTYPE_NECK,	row = 2, col = 1 },
		jewelcrafting_ring		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_FINGER),	text = INVTYPE_FINGER,	row = 2, col = 2 },
		jewelcrafting_trinket		= { tt = L["FILTER_DESC_FORMAT"]:format(INVTYPE_TRINKET),	text = INVTYPE_TRINKET,	row = 3, col = 1 },
		jewelcrafting_staff 		= { tt = L["FILTER_DESC_FORMAT"]:format(L["Staff"]),		text = L["Staff"],		row = 3, col = 2 },
	}

	equippable_toggle:SetScript("OnClick", function(self, button)
		local toggle = (button == "LeftButton") and true or false

		for item in pairs(equippable_types) do
			module.db.profile.filters.item[item] = toggle
			parent_panel[item]:SetChecked(toggle)
		end
		MainPanel:UpdateTitle()
		MainPanel.list_frame:Update(nil, false)
	end)

	parent_panel.equippable_toggle = equippable_toggle

	local equippable_panel = _G.CreateFrame("Frame", nil, parent_panel)
	equippable_panel:SetHeight(70)
	equippable_panel:SetPoint("TOP", equippable_toggle, "BOTTOM")
	equippable_panel:SetPoint("LEFT", parent_panel, "LEFT")
	equippable_panel:SetPoint("RIGHT", parent_panel, "RIGHT")

	addon.GenerateCheckBoxes(parent_panel, equippable_types, equippable_panel)

	for item_type in pairs(equippable_types) do
		MainPanel.filter_menu.value_map[item_type] = {
			cb = MainPanel.filter_menu.item.items_jewelcrafting[item_type],
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
	general_toggle:SetPoint("TOP", equippable_panel, "BOTTOM", 0, 0)
	general_toggle:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	addon.SetTooltipScripts(general_toggle, L["GROUP_TOGGLE_FORMAT"]:format(GENERAL))

	local general_types = {
		jewelcrafting_created_item	= { tt = L["FILTER_DESC_FORMAT"]:format(NONEQUIPSLOT),	text = NONEQUIPSLOT,		row = 1, col = 1 },
		jewelcrafting_materials		= { tt = L["FILTER_DESC_FORMAT"]:format(L["Materials"]),	text = L["Materials"],		row = 1, col = 2 },
		jewelcrafting_mount		= { tt = L["FILTER_DESC_FORMAT"]:format(MOUNTS),		text = MOUNTS,		row = 2, col = 1 },
		jewelcrafting_pet		= { tt = L["FILTER_DESC_FORMAT"]:format(PETS),		text = PETS,			row = 2, col = 2 },
		jewelcrafting_item_enhancement	= { tt = L["FILTER_DESC_FORMAT"]:format(L["Item Enhancement"]),	text = L["Item Enhancement"],	row = 3, col = 1 },
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
			cb = MainPanel.filter_menu.item.items_jewelcrafting[item_type],
			svroot = self.db.profile.filters.item
		}
	end
	self.InitializeItemFilters = nil
end
