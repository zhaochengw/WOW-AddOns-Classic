-- $Id: HandyNotes.lua 107 2020-03-08 10:43:45Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local select, pairs = _G.select, _G.pairs
local math = _G.math
local ceil = math.ceil
local string = _G.string
local format = string.format
-- Libraries
local GetAddOnInfo, GetAddOnEnableState, UnitName, ToggleFrame, InterfaceOptionsFrame_OpenToCategory = _G.GetAddOnInfo, _G.GetAddOnEnableState, _G.UnitName, _G.ToggleFrame, _G.InterfaceOptionsFrame_OpenToCategory
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local MODNAME = "HandyNotes"

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local Module = addon:NewModule(MODNAME)
local db

local HN, LH
local iHandyNotes = select(4, GetAddOnInfo(MODNAME))
local enabled = GetAddOnEnableState(UnitName("player"), MODNAME)
local iMaxMenu = 20

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
					name = L["Show HandyNotes plugins in second level menu."],
					desc = L["Second level menu will be forced to be created when there are more than 20 of HandyNotes plugins."],
					width = "full",
				},
				showConfig = {
					order = 12, 
					type = "toggle",
					name = format(L["Show %s module's config link in menu."], L[MODNAME]),
					width = "full",
				},
			},
		},
	},
}

function Module:OnInitialize()
	if (enabled > 0 and iHandyNotes) then 
		HN = LibStub("AceAddon-3.0"):GetAddon(MODNAME) 
		LH = LibStub("AceLocale-3.0"):GetLocale(MODNAME, false)
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
	if (enabled > 0 and iHandyNotes) then
		local function toggleHandyNotes()
			HN.db.profile.enabled = not HN.db.profile.enabled
			if (HN.db.profile.enabled) then
				HN:Enable()
			else
				HN:Disable()
			end
		end

		local function checkHandyNotesStatus()
			return HN.db.profile.enabled or nil
		end

		local function getPlugins()
			local plugins = HN.plugins
			local i = 0
			for k,v in pairs(plugins) do
				i = i + 1
			end
			return plugins, i
		end

		local function checkPluginStatus(pluginName)
			return HN.db.profile.enabledPlugins[pluginName] and true or false
		end

		local function togglePlugin(pluginName)
			HN.db.profile.enabledPlugins[pluginName] = not HN.db.profile.enabledPlugins[pluginName]
			HN:UpdatePluginMap(nil, pluginName)
		end

		local plugins, n_plugins = getPlugins()
		
		local function getPluginMenu(t, i)
			for k, v in pairs(plugins) do
				t[i] = {}
				t[i].isNotRadio = true
				t[i].keepShownOnClick = true
				t[i].text = k
				if (not checkHandyNotesStatus()) then
					t[i].disabled = true
				else
					t[i].disabled = nil
				end
				t[i].checked = checkPluginStatus(k)
				t[i].func = (function(self)
					togglePlugin(k)
				end)
				t[i].num = i
				i = i + 1
			end
			return t, i
		end

		local menu = {}
		local menu2 = {}
		local i = 1

		-- Clear out the info from the separator wholesale.
		menu[i] = {}
		menu[i].text = LH["HandyNotes"]
		menu[i].isNotRadio = true
		if (db.contextMenu or n_plugins > iMaxMenu) then
			menu[i].hasArrow = true
		else
			menu[i].hasArrow = nil
		end
		menu[i].value = "HandyNotes"
		menu[i].colorCode = "|cFFFFC90E"
		menu[i].tooltipTitle = LH["HandyNotes"]
		menu[i].tooltipText = LH["Enable or disable HandyNotes"]
		menu[i].tooltipOnButton = true
		menu[i].checked = checkHandyNotesStatus
		menu[i].func = toggleHandyNotes
		menu[i].num = i
		i = i + 1
		
		-- Now create HandyNotes' plugins dropdown
		if (db.contextMenu or n_plugins > iMaxMenu) then
			if (n_plugins > iMaxMenu) then
				local menu3 = {}
				menu3 = getPluginMenu(menu3, 1)
				local n = ceil(n_plugins / iMaxMenu)
				for j = 1, n do
					menu2[j] = {}
					menu2[j].isNotRadio = true
					menu2[j].notCheckable = true
					menu2[j].keepShownOnClick = true
					menu2[j].hasArrow = true
					menu2[j].text = format("HandyNotes - %s/%s", j, n)
					menu2[j].value = "HandyNotes"..j

					local t = {}
					local i_st, i_en
					-- calculate the start and end number, for example, 1 - 20; 21 - 40
					i_st = 1 + (iMaxMenu * (j-1))
					if (j == n) then 
						i_en = #menu3
					else
						i_en = (iMaxMenu*j)
					end
					for k = i_st, i_en do
						t[k - (iMaxMenu * (j-1))] = menu3[k]
					end
					menu2[j].menuTable = t
				end
			else
				menu2 = getPluginMenu(menu2, 1)
			end		
		else
			menu, i = getPluginMenu(menu, i)
		end
		
		-- Last menu item for config option
		if (db.showConfig) then
			menu[i] = {}
			menu[i].isNotRadio = true
			menu[i].notCheckable = true
			menu[i].text = L["HandyNotes Config"]
			menu[i].colorCode = "|cFFB5E61D"
			menu[i].tooltipTitle = LH["HandyNotes"]
			menu[i].tooltipText = L["Click to open HandyNotes' config panel"]
			menu[i].tooltipOnButton = true
			menu[i].func = (function(self)
				ToggleFrame(WorldMapFrame)
				SlashCmdList["ACECONSOLE_HANDYNOTES"]("gui")
			end)
		end
		
		return menu, menu2
	else
		return nil
	end
end
