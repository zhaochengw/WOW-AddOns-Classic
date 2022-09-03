-- $Id: Atlas_DungeonLocs-deDE.lua 71 2022-02-02 17:19:07Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbertat gmail dot com>
	Copyright 2010 - Lothaer <lothayerat gmail dot com>, Atlas Team
	Copyright 2011 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

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

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("Atlas_DungeonLocs", "deDE", false);

if L then
L["Blue"] = "Blau"
L["Change will take effect after next login; or type '/reload' command to reload addon"] = "Die Änderung wird nach der nächsten Anmeldung wirksam; oder gib den Befehl '/reload' ein, um das Addon neu zu laden"
L["Dungeon Locations"] = "Instanzstandorte"
L["Green"] = "Grün"
L["Instances"] = "Instanzen"
L["Meeting stone is inside the Sanctum of Order"] = "Der Versammlungsstein befindet sich innerhalb vom Sanktum der Ordnung"
L["Raid entrance is inside the Sanctum Depths of Sanctum of Order"] = "Der Schlachtzugseingang befindet sich innerhalb der Sanktumstiefen vom Sanktum der Ordnung"
L["Show %s's dungeon location maps"] = "Zeigt Dungeon-Standortkarten von %s an"
L["White"] = "Weiß"

end
