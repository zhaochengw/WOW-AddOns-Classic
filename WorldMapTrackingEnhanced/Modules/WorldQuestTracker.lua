-- $Id: WorldQuestTracker.lua 107 2020-03-08 10:43:45Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local select = _G.select
-- Libraries
local GetAddOnInfo, GetAddOnEnableState, UnitName, ToggleFrame, InterfaceOptionsFrame_OpenToCategory = _G.GetAddOnInfo, _G.GetAddOnEnableState, _G.UnitName, _G.ToggleFrame, _G.InterfaceOptionsFrame_OpenToCategory
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local MODNAME = "WorldQuestTracker"

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local Module = addon:NewModule(MODNAME)
local db

local WorldQuestTracker, profile, LW
local filters = {}
local iWorldQuestTracker = select(4, GetAddOnInfo(MODNAME))
local enabled = GetAddOnEnableState(UnitName("player"), MODNAME)

local defaults = {
	profile = {
		contextMenu = true,
		showConfig = false,
	}
}

local optGetter, optSetter
do
	function optGetter(info)
		local key = info[#info]
		return Module.db.profile[key]
	end

	function optSetter(info, value)
		local key = info[#info]
		Module.db.profile[key] = value
		Module:Refresh()
	end
end

local options = {
	type = "group",
	name = MODNAME,
	get = optGetter,
	set = optSetter,
	args = {
		config = {
			order = 10,
			type = "group",
			name = L["Config"],
			inline = true,
			args = {
				contextMenu = {
					order = 11,
					type = "toggle",
					name = format(L["Show %s module's menu items in second level of menu."], MODNAME),
					width = "full",
				},
				showConfig = {
					order = 12, 
					type = "toggle",
					name = format(L["Show %s module's config link in menu."], MODNAME),
					width = "full",
				},
			},
		},
	},
}

function Module:OnInitialize()
	if (enabled > 0 and iWorldQuestTracker) then 
		WorldQuestTracker = WorldQuestTrackerAddon
		profile = WorldQuestTracker.db.profile
		LW = LibStub("AceLocale-3.0"):GetLocale("WorldQuestTrackerAddon")
		filters = {
			{ 
				key = "artifact_power",	
				name = LW["S_QUESTTYPE_ARTIFACTPOWER"],
				icon = "Interface\\AddOns\\WorldQuestTracker\\media\\icon_artifactpower_red_roundT" },
			{ 
				key = "dungeon",
				name = LW["S_QUESTTYPE_DUNGEON"],
				icon = "Interface\\TARGETINGFRAME\\Nameplates" ,
				coords = {41/256, 0/256, 42/128, 80/128} },
			{ 
				key = "equipment",
				name = LW["S_QUESTTYPE_EQUIPMENT"],
				icon = "Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle" },
			{ 
				key = "gold",
				name = LW["S_QUESTTYPE_GOLD"],
				icon = "Interface\\GossipFrame\\auctioneerGossipIcon" },
			{ 
				key = "pet_battles",
				name = LW["S_QUESTTYPE_PETBATTLE"],
				icon = "Interface\\MINIMAP\\OBJECTICONS",
				coords = {3/8, 4/8, 4/8, 5/8} },
			{ 
				key = "profession",
				name = LW["S_QUESTTYPE_PROFESSION"],
				icon = "Interface\\MINIMAP\\TRACKING\\Profession",
				coords = {2/32, 30/32, 2/32, 30/32} },
			{ 
				key = "pvp",
				name = LW["S_QUESTTYPE_PVP"],
				icon = "Interface\\QUESTFRAME\\QuestTypeIcons",
				coords = {37/128, 53/128, 19/64, 36/64} },
			{ 
				key = "garrison_resource",
				name = LW["S_QUESTTYPE_RESOURCE"],
				icon = "Interface\\AddOns\\WorldQuestTracker\\media\\resource_iconT" },
			{ 
				key = "trade_skill",
				name = LW["S_QUESTTYPE_TRADESKILL"],
				icon = "Interface\\ICONS\\INV_Blood of Sargeras",
				coords = {5/64, 59/64, 5/64, 59/64} },
		}

		self.db = addon.db:RegisterNamespace(MODNAME, defaults)
		db = self.db.profile

		self:SetEnabledState(addon:GetModuleEnabled(MODNAME))
		addon:RegisterModuleOptions(MODNAME, options, MODNAME)
	else
		addon:DisableModule(MODNAME)
	end
end

function Module:OnEnable()

end

function Module:OnDisable()

end

function Module:DropDownMenus()
	if (enabled > 0 and iWorldQuestTracker) then
		local function checkWorldMapWidget()
			return profile.disable_world_map_widgets
		end
			
		local function toggleWorldMapWidget()
			profile.disable_world_map_widgets = not profile.disable_world_map_widgets
			if (WorldQuestTracker.GetCurrentZoneType() == "world") then
				WorldQuestTracker.UpdateWorldQuestsOnWorldMap()
			end
		end

		local function checkFilterStatus(filterType)
			return profile.filters[filterType]
		end
			
		local function toggleFilterStatus(filterType)
			profile.filters[filterType] = not profile.filters[filterType]
			if (filterType == "pet_battles") then
				SetCVar("showTamers", profile.filters[filterType] and "1" or "0");
				--WorldMapFrame_Update()
				local FilterButton = WorldMapFrame.overlayFrames[2]
				FilterButton:GetParent():RefreshAllDataProviders()
			end
			WorldQuestTracker.UpdateZoneWidgets()
		end
		
		local function getMenu(menu, i)
			for j = 1, #filters do
				menu[i] = {}
				menu[i].isNotRadio = true
				menu[i].keepShownOnClick = true
				menu[i].text = filters[j].name
				menu[i].checked = checkFilterStatus(filters[j].key)
				menu[i].func = (function(self)
					toggleFilterStatus(filters[j].key)
				end)
				if filters[j].icon then
					menu[i].icon = filters[j].icon
				end
				if filters[j].coords then
					menu[i].tCoordLeft = filters[j].coords[1] or 0
					menu[i].tCoordRight = filters[j].coords[2] or 1
					menu[i].tCoordTop = filters[j].coords[3] or 0
					menu[i].tCoordBottom = filters[j].coords[4] or 1
				end
				menu[i].num = i
				i = i + 1
			end
			return menu, i
		end

		local menu = {}
		local menu2 = {}
		local i = 1

		menu[i] = {}
--		menu[i].isTitle = true
		menu[i].notCheckable = true
		menu[i].isNotRadio = true
		menu[i].keepShownOnClick = true
		if addon.db.profile.worldQuestTracker_contextMenu then
			menu[i].hasArrow = true
		else
			menu[i].hasArrow = nil
		end
		menu[i].value = MODNAME
		menu[i].text = LW["World Quest Tracker"] or MODNAME
		menu[i].colorCode = "|cFFFFC90E"
		menu[i].num = i
		i = i + 1
		if (db.contextMenu) then
			menu2 = getMenu(menu2, 1)
		else
			menu, i = getMenu(menu, i)
		end
		
		if (db.showConfig) then
			menu[i] = {}
			menu[i].isNotRadio = true
			menu[i].keepShownOnClick = true
			menu[i].text = L["Disable Icons on World Map"]
			menu[i].func = toggleWorldMapWidget
			menu[i].checked = checkWorldMapWidget
			menu[i].num = i
		end

		return menu, menu2
	else
		return nil
	end
end
