--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert at gmail dot com>
	Copyright 2010 - Lothaer <lothayer at gmail dot com>, Atlas Team
	Copyright 2011 ~ 2023 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

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

-- Atlas WorldMap Integration

local addon    = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local WorldMap = {}
addon.WorldMap = WorldMap

local function createButton()
	local KButtons = LibStub("Krowi_WorldMapButtons-1.4")
	WorldMap.Button = KButtons:Add("AtlasWorldMapButtonTemplate", "BUTTON")
end

function addon:WorldMapButtonSelectMap()
	local mapID = WorldMapFrame:GetMapID() or 0
	local profile = addon.db.profile

	for type_k, type_v in pairs(ATLAS_DROPDOWNS) do
		for zone_k, zone_v in pairs(type_v) do
			local AtlasWorldMapID = AtlasMaps[zone_v].WorldMapID
			local AtlasMapFaction = AtlasMaps[zone_v].Faction
			if (AtlasWorldMapID and AtlasWorldMapID == mapID) then
				if (AtlasMapFaction and AtlasMapFaction == ATLAS_PLAYER_FACTION) then
					profile.options.dropdowns.module = type_k
					profile.options.dropdowns.zone = zone_k
				else
					profile.options.dropdowns.module = type_k
					profile.options.dropdowns.zone = zone_k
				end
				Atlas_Refresh()
				return
			end
		end
	end
end

do
	createButton()
end
