-- $Id: AtlasLoot.lua 107 2020-03-08 10:43:45Z arith $
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

local MODNAME = "AtlasLoot"

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local Module = addon:NewModule(MODNAME)
local db

local AT, profile

local iAtlasLoot = select(4, GetAddOnInfo(MODNAME))
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
			name = L["AtlasLoot Config"],
		},
		contextMenu = {
			order = 2,
			type = "toggle",
			name = L["Show AtlasLoot menu items in second level menu."],
		},]]
	},
}

function Module:OnInitialize()
	if (enabled > 0 and iAtlasLoot) then 
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
	if (enabled > 0 and iAtlasLoot) then
		local menu = {}
		local i = 1
		local mode_name = L[MODNAME]
		
		menu[i] = {}
		menu[i].isNotRadio = true
		menu[i].notCheckable = true
		--menu[i].keepShownOnClick = true
		menu[i].hasArrow = nil
		menu[i].value = MODNAME
		menu[i].colorCode = "|cFFFFC90E"
		menu[i].text = mode_name
		menu[i].tooltipTitle = mode_name
		menu[i].tooltipText = select(3, GetAddOnInfo(MODNAME)) or nil
		menu[i].tooltipOnButton = true
		menu[i].func = AtlasLoot.WorldMap.Button_OnClick
		menu[i].checked = nil
		menu[i].icon = "Interface\\AddOns\\AtlasLoot\\Images\\AtlasLootButton-Up"

		return menu
	else
		return nil
	end
end
