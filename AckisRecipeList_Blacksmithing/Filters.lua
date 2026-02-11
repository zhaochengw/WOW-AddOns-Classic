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

-------------------------------------------------------------------------------
-- What we're really here for.
-------------------------------------------------------------------------------
module.ITEM_FILTER_TYPES = {
	BLACKSMITHING_CHEST = true,
	BLACKSMITHING_DAGGER = true,
	BLACKSMITHING_FEET = true,
	BLACKSMITHING_HANDS = true,
	BLACKSMITHING_HEAD = true,
	BLACKSMITHING_ITEM_ENHANCEMENT = true,
	BLACKSMITHING_LEGS = true,
	BLACKSMITHING_MATERIALS = true,
	BLACKSMITHING_ONE_HAND_AXE = true,
	BLACKSMITHING_ONE_HAND_MACE = true,
	BLACKSMITHING_ONE_HAND_SWORD = true,
	BLACKSMITHING_POLEARM = true,
	BLACKSMITHING_SHIELD = true,
	BLACKSMITHING_SHOULDER = true,
	BLACKSMITHING_SKELETON_KEY = true,
	BLACKSMITHING_THROWN = true,
	BLACKSMITHING_TWO_HAND_AXE = true,
	BLACKSMITHING_TWO_HAND_MACE = true,
	BLACKSMITHING_TWO_HAND_SWORD = true,
	BLACKSMITHING_WAIST = true,
	BLACKSMITHING_WRIST = true,
	BLACKSMITHING_CREATED_ITEM = true,
	BLACKSMITHING_MOUNT = true,
	BLACKSMITHING_RELIC = true,
	BLACKSMITHING_WARGLAIVE = true,
}

function module:InitializeItemFilters(parent_panel)
	local MainPanel = addon.Frame

	local armor_toggle = _G.CreateFrame("Button", nil, parent_panel)
	armor_toggle:SetWidth(105)
	armor_toggle:SetHeight(20)
	armor_toggle:SetNormalFontObject("QuestTitleFont")
	armor_toggle:SetHighlightFontObject("QuestTitleFontBlackShadow")
	armor_toggle:SetText(_G.ARMOR .. ":")
	armor_toggle:SetPoint("TOP", parent_panel, "TOP", 0, -7)
	armor_toggle:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	addon.SetTooltipScripts(armor_toggle, L["GROUP_TOGGLE_FORMAT"]:format(_G.ARMOR))

	local armor_types = {
		blacksmithing_chest	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_CHEST), 	text = _G.INVTYPE_CHEST,	row = 1, col = 1 },
		blacksmithing_feet	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_FEET), 	text = _G.INVTYPE_FEET,		row = 1, col = 2 },
		blacksmithing_hands	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_HAND), 	text = _G.INVTYPE_HAND,		row = 2, col = 1 },
		blacksmithing_head	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_HEAD), 	text = _G.INVTYPE_HEAD,		row = 2, col = 2 },
		blacksmithing_legs	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_LEGS), 	text = _G.INVTYPE_LEGS,		row = 3, col = 1 },
		blacksmithing_shield    = { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_SHIELD), 	text = _G.INVTYPE_SHIELD,	row = 3, col = 2 },
		blacksmithing_shoulder	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_SHOULDER), 	text = _G.INVTYPE_SHOULDER,	row = 4, col = 1 },
		blacksmithing_waist	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_WAIST), 	text = _G.INVTYPE_WAIST,	row = 4, col = 2 },
		blacksmithing_wrist	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_WRIST), 	text = _G.INVTYPE_WRIST,	row = 5, col = 1 },
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
			cb = MainPanel.filter_menu.item.items_blacksmithing[item_type],
			svroot = self.db.profile.filters.item
		}
	end

	-------------------------------------------------------------------------------
	-- Create the Weapon toggle and CheckButtons
	-------------------------------------------------------------------------------
	local weapon_toggle = _G.CreateFrame("Button", nil, parent_panel)
	weapon_toggle:SetWidth(105)
	weapon_toggle:SetHeight(20)
	weapon_toggle:SetNormalFontObject("QuestTitleFont")
	weapon_toggle:SetHighlightFontObject("QuestTitleFontBlackShadow")
	weapon_toggle:SetText(L["Weapon"] .. ":")
	weapon_toggle:SetPoint("TOP", armor_panel, "BOTTOM", 0, 0)
	weapon_toggle:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	addon.SetTooltipScripts(weapon_toggle, L["GROUP_TOGGLE_FORMAT"]:format(L["Weapon"]))

	local weapon_types = {
		blacksmithing_dagger		= { tt = L["FILTER_DESC_FORMAT"]:format(L["Dagger"]),		text = L["Dagger"],		row = 1, col = 1 },
		blacksmithing_one_hand_axe	= { tt = L["FILTER_DESC_FORMAT"]:format(L["One-Handed Axe"]),	text = L["One-Handed Axe"],	row = 1, col = 2 },
		blacksmithing_one_hand_mace	= { tt = L["FILTER_DESC_FORMAT"]:format(L["One-Handed Mace"]),	text = L["One-Handed Mace"],	row = 2, col = 1 },
		blacksmithing_one_hand_sword	= { tt = L["FILTER_DESC_FORMAT"]:format(L["One-Handed Sword"]),	text = L["One-Handed Sword"],	row = 2, col = 2 },
		blacksmithing_polearm		= { tt = L["FILTER_DESC_FORMAT"]:format(L["Polearm"]),		text = L["Polearm"],		row = 3, col = 1 },
		blacksmithing_thrown		= { tt = L["FILTER_DESC_FORMAT"]:format(L["Thrown"]),		text = L["Thrown"],		row = 3, col = 2 },
		blacksmithing_two_hand_axe	= { tt = L["FILTER_DESC_FORMAT"]:format(L["Two-Handed Axe"]),	text = L["Two-Handed Axe"],	row = 4, col = 1 },
		blacksmithing_two_hand_mace	= { tt = L["FILTER_DESC_FORMAT"]:format(L["Two-Handed Mace"]),	text = L["Two-Handed Mace"],	row = 4, col = 2 },
		blacksmithing_two_hand_sword	= { tt = L["FILTER_DESC_FORMAT"]:format(L["Two-Handed Sword"]),	text = L["Two-Handed Sword"],	row = 5, col = 1 },
		blacksmithing_warglaive		= { tt = L["FILTER_DESC_FORMAT"]:format(L["Warglaive"]),	text = L["Warglaive"],		row = 5, col = 2 },
	}

	weapon_toggle:SetScript("OnClick", function(self, button)
		local toggle = (button == "LeftButton") and true or false

		for item in pairs(weapon_types) do
			module.db.profile.filters.item[item] = toggle
			parent_panel[item]:SetChecked(toggle)
		end
		MainPanel:UpdateTitle()
		MainPanel.list_frame:Update(nil, false)
	end)

	parent_panel.weapon_toggle = weapon_toggle

	local weapon_panel = _G.CreateFrame("Frame", nil, parent_panel)
	weapon_panel:SetHeight(110)
	weapon_panel:SetPoint("TOP", weapon_toggle, "BOTTOM")
	weapon_panel:SetPoint("LEFT", parent_panel, "LEFT")
	weapon_panel:SetPoint("RIGHT", parent_panel, "RIGHT")

	addon.GenerateCheckBoxes(parent_panel, weapon_types, weapon_panel)

	for item_type in pairs(weapon_types) do
		MainPanel.filter_menu.value_map[item_type] = {
			cb = MainPanel.filter_menu.item.items_blacksmithing[item_type],
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
	general_toggle:SetText(_G.GENERAL .. ":")
	general_toggle:SetPoint("TOP", weapon_panel, "BOTTOM", 0, 0)
	general_toggle:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	addon.SetTooltipScripts(general_toggle, L["GROUP_TOGGLE_FORMAT"]:format(_G.GENERAL))

	local general_types = {
		blacksmithing_item_enhancement	= { tt = L["FILTER_DESC_FORMAT"]:format(L["Item Enhancement"]),	text = L["Item Enhancement"],	row = 1, col = 1 },
		blacksmithing_materials		= { tt = L["FILTER_DESC_FORMAT"]:format(L["Materials"]),	text = L["Materials"],		row = 1, col = 2 },
		blacksmithing_mount		= { tt = L["FILTER_DESC_FORMAT"]:format(_G.MOUNTS),		text = _G.MOUNTS,		row = 2, col = 1 },
		blacksmithing_skeleton_key	= { tt = L["FILTER_DESC_FORMAT"]:format(L["Skeleton Key"]),	text = L["Skeleton Key"],	row = 2, col = 2 },
		blacksmithing_created_item	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.NONEQUIPSLOT),	text = _G.NONEQUIPSLOT,		row = 3, col = 1 },
		blacksmithing_relic		= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_RELIC), 	text = _G.INVTYPE_RELIC,	row = 3, col = 2 },
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
			cb = MainPanel.filter_menu.item.items_blacksmithing[item_type],
			svroot = self.db.profile.filters.item
		}
	end

	self.InitializeItemFilters = nil
end
