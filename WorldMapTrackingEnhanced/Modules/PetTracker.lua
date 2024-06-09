-- $Id: PetTracker.lua 150 2022-11-08 13:57:42Z arithmandar $
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

local MODNAME = "PetTracker"

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local Module = addon:NewModule(MODNAME)
local db

local iPetTracker = select(4, GetAddOnInfo(MODNAME))
local enabled = GetAddOnEnableState(UnitName("player"), MODNAME)

local MapSearch

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
					name = format(L["Show %s module's menu items in second level of menu."], L[MODNAME]),
					width = "full",
				},
--[[				showConfig = {
					order = 12, 
					type = "toggle",
					name = format(L["Show %s module's config link in menu."], MODNAME),
					width = "full",
				},]]
			},
		},
	},
}

function Module:OnInitialize()
	if (enabled > 0 and iPetTracker) then 
		LPT = LibStub("AceLocale-3.0"):GetLocale(MODNAME, false)
		self.db = addon.db:RegisterNamespace(MODNAME, defaults)
		db = self.db.profile

		self:SetEnabledState(addon:GetModuleEnabled(MODNAME))
		addon:RegisterModuleOptions(MODNAME, options, MODNAME)
		
		MapSearch = PetTracker.MapSearch
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
	if (enabled > 0 and iPetTracker) then
	
		local function checkActiveSpecies()
			return not PetTracker.sets.hideSpecies
		end
			
		local function toggleSpecies()
			PetTracker.sets.hideSpecies = not PetTracker.sets.hideSpecies
			--PetTracker.WorldMap:UpdateBlips()
			PetTracker.MapCanvas:UpdateAll()
			MapSearch:UpdateFrames()
		end

		local function checkActiveStables()
			return not PetTracker.sets.hideStables
		end
			
		local function toggleStables()
			PetTracker.sets.hideStables = not PetTracker.sets.hideStables
			--PetTracker.WorldMap:UpdateBlips()
			PetTracker.MapCanvas:UpdateAll()
		end
		
		local menu = {}
		local menu2 = {}
		local i = 1
		local PAW_ICON = 'Interface\\Garrison\\MobileAppIcons:13:13:0:0:1024:1024:261:389:261:389'
		local mode_name = L["PetTracker"]
--		local mode_name = select(2, GetAddOnInfo(MODNAME)) or MODNAME
		
		local function getMenu(t, i)
			t[i] = {}
			t[i].isNotRadio = true
			t[i].keepShownOnClick = true
			t[i].text = LPT["Species"]
			t[i].func = toggleSpecies
			t[i].checked = checkActiveSpecies
			i = i + 1
			
			t[i] = {}
			t[i].isNotRadio = true
			t[i].keepShownOnClick = true
			t[i].text = MINIMAP_TRACKING_STABLEMASTER
			t[i].func = toggleStables
			t[i].checked = checkActiveStables
			i = i + 1
			
			return t, i
		end
		
		menu[i] = {}
		menu[i].notCheckable = true
		menu[i].isNotRadio = true
		menu[i].keepShownOnClick = true
		menu[i].value = MODNAME
		menu[i].colorCode = "|cFFFFC90E"
		menu[i].text = mode_name or MODNAME or PETS
		if (db.contextMenu) then
			menu[i].hasArrow = true
			i = i + 1
			menu2 = getMenu(menu2, 1)
		else
			menu[i].hasArrow = nil
			i = i + 1
			menu, i = getMenu(menu, i)
		end
--[[
		if (db.showConfig) then
			menu[i] = {}
			menu[i].isNotRadio = true
			menu[i].notCheckable = true
			menu[i].text = L["PetTracker Config"]
			menu[i].colorCode = "|cFFB5E61D"
			menu[i].tooltipTitle = mode_name
			menu[i].tooltipText = L["Click to open PetTracker's config panel"]
			menu[i].tooltipOnButton = true
			menu[i].func = (function(self)
				ToggleFrame(WorldMapFrame)
				InterfaceOptionsFrame_OpenToCategory(MODNAME)
				InterfaceOptionsFrame_OpenToCategory(MODNAME)
			end)
		end
]]	
		return menu, menu2
	else
		return nil
	end
end
