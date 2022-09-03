-- $Id: Config.lua 81 2022-03-24 14:15:10Z arithmandar $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
local UnitFactionGroup = _G.UnitFactionGroup
local faction = UnitFactionGroup("player")
local string = _G.string
local format = string.format
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub;
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

local options, moduleOptions = nil, {}

local config = {}
private.config = config

local function ShowOption()
	local f
	if (faction == "Alliance") then
		f = FACTION_HORDE
	else
		f = FACTION_ALLIANCE
	end
	
	return format(L["Show %s's dungeon location maps"], f)
end

config.options = {
	type = "group",
	name = addon.LocName,
	desc = addon.Notes,
	args = {
		group1 = {
			type = "group",
			name = ShowOption,
			order = 10,
			inline = true,
			args = {
				all_faction = {
					name = ENABLE,
					desc = L["Change will take effect after next login; or type '/reload' command to reload addon"],
					type = "toggle",
					order = 10,
					get = function()
						return private.db.all_faction
						
					end,
					set = function(info, value)
						private.db.all_faction = value
					end,
				},
			},
		},
	},
}

