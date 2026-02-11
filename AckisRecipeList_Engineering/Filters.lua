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
	ENGINEERING_BACK = true,
	ENGINEERING_BAG = true,
	ENGINEERING_BOW = true,
	ENGINEERING_CREATED_ITEM = true,
	ENGINEERING_CROSSBOW = true,
	ENGINEERING_FEET = true,
	ENGINEERING_GUN = true,
	ENGINEERING_HEAD = true,
	ENGINEERING_ITEM_ENHANCEMENT = true,
	ENGINEERING_MAIN_HAND = true,
	ENGINEERING_MATERIALS = true,
	ENGINEERING_MOUNT = true,
	ENGINEERING_NECK = true,
	ENGINEERING_ONE_HAND_MACE = true,
	ENGINEERING_PET = true,
	ENGINEERING_RELIC = true,
	ENGINEERING_SHIELD = true,
	ENGINEERING_TRINKET = true,
	ENGINEERING_TOY = true,

}

function module:InitializeItemFilters(parent_panel)
	local MainPanel = addon.Frame

	-------------------------------------------------------------------------------
	-- Create the Armor toggle and CheckButtons
	-------------------------------------------------------------------------------
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
		engineering_back	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_CLOAK), 	text = _G.INVTYPE_CLOAK,	row = 1, col = 1 },
		engineering_feet	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_FEET), 	text = _G.INVTYPE_FEET,		row = 1, col = 2 },
		engineering_head	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_HEAD), 	text = _G.INVTYPE_HEAD,		row = 2, col = 1 },
		engineering_neck	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_NECK), 	text = _G.INVTYPE_NECK,		row = 2, col = 2 },
		engineering_shield 	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_SHIELD),  	text = _G.INVTYPE_SHIELD,	row = 3, col = 1 },
		engineering_trinket	= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_TRINKET), 	text = _G.INVTYPE_TRINKET,	row = 3, col = 2 },
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
	armor_panel:SetHeight(70)
	armor_panel:SetPoint("TOP", armor_toggle, "BOTTOM")
	armor_panel:SetPoint("LEFT", parent_panel, "LEFT")
	armor_panel:SetPoint("RIGHT", parent_panel, "RIGHT")

	addon.GenerateCheckBoxes(parent_panel, armor_types, armor_panel)

	for item_type in pairs(armor_types) do
		MainPanel.filter_menu.value_map[item_type] = {
			cb = MainPanel.filter_menu.item.items_engineering[item_type],
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
		engineering_bow			= { tt = L["FILTER_DESC_FORMAT"]:format(L["Bow"]), 			text = L["Bow"],			row = 1, col = 1 },
		engineering_crossbow		= { tt = L["FILTER_DESC_FORMAT"]:format(L["Crossbow"]), 		text = L["Crossbow"],			row = 1, col = 2 },
		engineering_gun			= { tt = L["FILTER_DESC_FORMAT"]:format(L["Gun"]), 			text = L["Gun"],			row = 2, col = 1 },
		engineering_main_hand		= { tt = L["FILTER_DESC_FORMAT"]:format(_G.INVTYPE_WEAPONMAINHAND), 	text = _G.INVTYPE_WEAPONMAINHAND,	row = 2, col = 2 },
		engineering_one_hand_mace 	= { tt = L["FILTER_DESC_FORMAT"]:format(L["One-Handed Mace"]), 		text = L["One-Handed Mace"],		row = 3, col = 1 },
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
	weapon_panel:SetHeight(70)
	weapon_panel:SetPoint("TOP", weapon_toggle, "BOTTOM")
	weapon_panel:SetPoint("LEFT", parent_panel, "LEFT")
	weapon_panel:SetPoint("RIGHT", parent_panel, "RIGHT")

	addon.GenerateCheckBoxes(parent_panel, weapon_types, weapon_panel)

	for item_type in pairs(weapon_types) do
		MainPanel.filter_menu.value_map[item_type] = {
			cb = MainPanel.filter_menu.item.items_engineering[item_type],
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

	-- Safe fallback labels for MoP Classic
	local bagText = rawget(_G, "INVTYPE_BAG") or L["Bag"] or "Bag"
	local createdItemText = rawget(_G, "NONEQUIPSLOT") or L["Created Item"] or "Created Item"
	local mountsText = rawget(_G, "MOUNTS") or L["Mounts"] or "Mounts"
	local petText = rawget(_G, "PETS") or L["Pets"] or "Pets"
	local toyText = rawget(_G, "TOY_BOX") or L["Toy"] or "Toy"
	local relicText = rawget(_G, "INVTYPE_RELIC") or L["Relic"] or "Relic"

	local general_types = {
		engineering_bag			= { tt = L["FILTER_DESC_FORMAT"]:format(bagText),			text = bagText,			row = 1, col = 1 },
		engineering_created_item	= { tt = L["FILTER_DESC_FORMAT"]:format(createdItemText),	text = createdItemText,		row = 1, col = 2 },
		engineering_item_enhancement	= { tt = L["FILTER_DESC_FORMAT"]:format(L["Item Enhancement"]),	text = L["Item Enhancement"],	row = 2, col = 1 },
		engineering_materials		= { tt = L["FILTER_DESC_FORMAT"]:format(L["Materials"]),		text = L["Materials"],		row = 2, col = 2 },
		engineering_mount		= { tt = L["FILTER_DESC_FORMAT"]:format(mountsText),		text = mountsText,		row = 3, col = 1 },
		engineering_pet		= { tt = L["FILTER_DESC_FORMAT"]:format(petText),			text = petText,			row = 3, col = 2 },
		engineering_toy		= { tt = L["FILTER_DESC_FORMAT"]:format(toyText),			text = toyText,			row = 4, col = 1 },
		engineering_relic		= { tt = L["FILTER_DESC_FORMAT"]:format(relicText), 		text = relicText,		row = 4, col = 2 },
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
			cb = MainPanel.filter_menu.item.items_engineering[item_type],
			svroot = self.db.profile.filters.item
		}
	end

	self.InitializeItemFilters = nil
end
