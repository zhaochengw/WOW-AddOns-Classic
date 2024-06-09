-- $Id: RareScanner.lua 107 2020-03-08 10:43:45Z arith $
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

local MODNAME = "RareScanner"

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local Module = addon:NewModule(MODNAME)
local db

local RS, profile, LRS

local iRareScanner = select(4, GetAddOnInfo(MODNAME))
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
	name = L[MODNAME],
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
	if (enabled > 0 and iRareScanner) then 
		RS = LibStub("AceAddon-3.0"):GetAddon(MODNAME) 
		profile = RS.db.profile
		LRS = LibStub("AceLocale-3.0"):GetLocale(MODNAME, false)

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

function Module:Refresh()
	if not self:IsEnabled() then return end
end

function Module:DropDownMenus()
	if (enabled > 0 and iRareScanner) then
		local function toggleRareScanner(key)
			profile.map[key] = not profile.map[key]
			WorldMapFrame:RefreshAllDataProviders()
			if (not profile.map.maxSeenTimeBak) then
				profile.map.maxSeenTimeBak = profile.map.maxSeenTime
			end
			if (profile.map.disableLastSeenFilter) then
				profile.map.maxSeenTime = 0
			else
				profile.map.maxSeenTime = profile.map.maxSeenTimeBak 
			end
			if (not profile.map.maxSeenContainerTimeBak) then
				profile.map.maxSeenContainerTimeBak = profile.map.maxSeenTimeContainer
			end
			if (profile.map.disableLastSeenContainerFilter) then
				profile.map.maxSeenTimeContainer = 0
			else
				profile.map.maxSeenTimeContainer = profile.map.maxSeenContainerTimeBak 
			end
			if (not profile.map.maxSeenEventTimeBak) then
				profile.map.maxSeenEventTimeBak = profile.map.maxSeenTimeEvent
			end
			if (profile.map.disableLastSeenEventFilter) then
				profile.map.maxSeenTimeEvent = 0
			else
				profile.map.maxSeenTimeEvent = profile.map.maxSeenEventTimeBak 
			end
		end
		
		local function getMenu(menu, i)
			local menuitems = {
				{ text = "MAP_MENU_SHOW_RARE_NPCS", tip = "DISPLAY_NPC_ICONS_DESC", key = "displayNpcIcons" },
				{ text = "MAP_MENU_SHOW_CONTAINERS", tip = "DISPLAY_CONTAINER_ICONS_DESC", key = "displayContainerIcons" },
				{ text = "MAP_MENU_SHOW_EVENTS", tip = "DISPLAY_EVENT_ICONS_DESC", key = "displayEventIcons" },
				{ text = "MAP_MENU_DISABLE_LAST_SEEN_FILTER", key = "disableLastSeenFilter" },
				{ text = "MAP_MENU_DISABLE_LAST_SEEN_CONTAINER_FILTER", key = "disableLastSeenContainerFilter" },
				{ text = "MAP_MENU_DISABLE_LAST_SEEN_EVENT_FILTER", key = "disableLastSeenEventFilter" },
				{ text = "MAP_MENU_SHOW_NOT_DISCOVERED", tip = "DISPLAY_MAP_NOT_DISCOVERED_ICONS_DESC", key = "displayNotDiscoveredMapIcons" },
				{ text = "MAP_MENU_SHOW_NOT_DISCOVERED_OLD", tip = "DISPLAY_MAP_OLD_NOT_DISCOVERED_ICONS_DESC", key = "displayOldNotDiscoveredMapIcons" },
			}
			
			for j=1, #menuitems do
				menu[i] = {}
				menu[i].isNotRadio = true
				menu[i].keepShownOnClick = true
				menu[i].text = LRS[menuitems[j].text]
				menu[i].tooltipTitle = menuitems[j].tip and MODNAME
				menu[i].tooltipText = menuitems[j].tip and LRS[menuitems[j].tip] or nil
				menu[i].tooltipOnButton = menuitems[j].tip and true or nil
				menu[i].value = menuitems[j].key
				menu[i].func = (function(self)
					toggleRareScanner(self.value)
				end)
				menu[i].checked = profile.map[menuitems[j].key]
				i = i + 1
			end

			return menu, i
		end

		local menu = {}
		local menu2 = {}
		local i = 1
		local mode_name = L[MODNAME]
		
		menu[i] = {}
		menu[i].isNotRadio = true
		menu[i].notCheckable = true
		--menu[i].keepShownOnClick = true
		menu[i].value = MODNAME
		menu[i].colorCode = "|cFFFFC90E"
		menu[i].text = mode_name
		menu[i].tooltipTitle = mode_name
		menu[i].tooltipText = select(3, GetAddOnInfo(MODNAME)) or nil
		menu[i].tooltipOnButton = true
		--menu[i].func = toggleRareScanner
		menu[i].checked = nil
		if (db.contextMenu) then
			menu[i].hasArrow = true
			i = i + 1
			menu2 = getMenu(menu2, 1)
		else
			menu[i].hasArrow = nil
			i = i + 1
			menu, i = getMenu(menu, i)
		end
		
		if (db.showConfig) then
			menu[i] = {}
			menu[i].isNotRadio = true
			menu[i].notCheckable = true
			menu[i].text = L["RareScanner Config"]
			menu[i].colorCode = "|cFFB5E61D"
			menu[i].tooltipTitle = mode_name
			menu[i].tooltipText = L["Click to open RareScanner's config panel"]
			menu[i].tooltipOnButton = true
			menu[i].func = (function(self)
				ToggleFrame(WorldMapFrame)
				InterfaceOptionsFrame_OpenToCategory("RareScanner")
				InterfaceOptionsFrame_OpenToCategory("RareScanner")
				InterfaceOptionsFrame_OpenToCategory(LRS["MAP_OPTIONS"])
			end)
		end
		
		return menu, menu2
	else
		return nil
	end
end
