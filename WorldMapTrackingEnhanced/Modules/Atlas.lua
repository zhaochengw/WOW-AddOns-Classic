-- $Id: Atlas.lua 152 2022-11-12 07:25:33Z arithmandar $
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

local MODNAME = "Atlas"

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local Module = addon:NewModule(MODNAME)
local db

local AT, profile, WorldMap

local iAtlas = select(4, GetAddOnInfo(MODNAME))
local enabled = GetAddOnEnableState(UnitName("player"), MODNAME)

local defaults = {
	profile = {
		contextMenu = true,
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
--[[		intro = {
			order = 1,
			type = "description",
			name = L["Atlas Config"],
		},
		contextMenu = {
			order = 2,
			type = "toggle",
			name = L["Show Atlas menu items in second level menu."],
		},]]
	},
}

function Module:OnInitialize()
	if (enabled > 0 and iAtlas) then 
		AT = LibStub("AceAddon-3.0"):GetAddon(MODNAME) 
		profile = AT.db.profile
		
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
	if (enabled > 0 and iAtlas) then
		local menu = {}
		local i = 1
		local mode_name = L[MODNAME]
		
		local function buttonOnClick()
			AT:WorldMapButtonSelectMap()
			ToggleFrame(WorldMapFrame)
			AT:Toggle()
		end
		
		menu[i] = {}
		menu[i].isNotRadio = true
		menu[i].notCheckable = true
		menu[i].keepShownOnClick = false
		menu[i].hasArrow = nil
		menu[i].value = MODNAME
		menu[i].colorCode = "|cFFFFC90E"
		menu[i].text = mode_name
		menu[i].tooltipTitle = mode_name
		menu[i].tooltipText = select(3, GetAddOnInfo(MODNAME)) or nil
		menu[i].tooltipOnButton = true
		menu[i].func = buttonOnClick
		menu[i].checked = nil
		menu[i].icon = "Interface\\WorldMap\\WorldMap-Icon"

		return menu
	else
		return nil
	end
end
