-- $Id: Core.lua 81 2022-03-24 14:15:10Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert@gmail.com>
	Copyright 2010 - Lothaer <lothayer@gmail.com>, Atlas Team
	Copyright 2011 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail.com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]
-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
local UnitFactionGroup = _G.UnitFactionGroup
local faction = UnitFactionGroup("player")

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local AceDB = LibStub("AceDB-3.0")
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local addon = LibStub("AceAddon-3.0"):NewAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

addon.Name = FOLDER_NAME
addon.LocName = select(2, GetAddOnInfo(addon.Name))
addon.Notes = select(3, GetAddOnInfo(addon.Name))

local function copy_faction_tables(faction)
	for k, v in pairs(private[faction].maps) do
		private.data.maps[k] = v
	end
	for k, v in pairs(private[faction].coords) do
		private.data.coords[k] = v
	end
end

-- //////////////////////////////////////////////////////////////////////////
function addon:OnInitialize()
	self.db = AceDB:New(private.addon_name.."DB", private.constants.defaults, true)
	
	private.db = self.db.profile

	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")
	
	Atlas:RegisterModuleOptions(addon.Name, private.config.options, addon.LocName)
	--self:SetupOptions()

	if (private.db.all_faction or faction == "Alliance") then
		copy_faction_tables("alliance")
	end
	if (private.db.all_faction or faction == "Horde") then
		copy_faction_tables("horde")
	end
end


function addon:OnEnable()
	Atlas:RegisterPlugin(private.addon_name, L[private.category], private.data.maps, private.data.coords)
end

function addon:Refresh()

end
