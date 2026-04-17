--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert@gmail.com>
	Copyright 2010 - Lothaer <lothayer@gmail.com>, Atlas Team
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

local L = LibStub("AceLocale-3.0"):NewLocale("Atlas_WrathoftheLichKing", "enUS", true, true);
if not L then return end

L["Ahn'kahet Brazier"] = "Ahn'kahet Brazier"
L["AK, Kahet"] = "AK, Kahet"
L["Ambrose Boltspark"] = "Ambrose Boltspark"
L["AN, Nerub"] = "AN, Nerub"
L["Archivum Console"] = "Archivum Console"
L["Archmage Elandra <Kirin Tor>"] = "Archmage Elandra <Kirin Tor>"
L["Archmage Koreln <Kirin Tor>"] = "Archmage Koreln <Kirin Tor>"
L["Belgaristrasz"] = "Belgaristrasz"
L["Berinand's Research"] = "Berinand's Research"
L["Black Dragonflight Chamber"] = "Black Dragonflight Chamber"
L["Brann Bronzebeard"] = "Brann Bronzebeard"
L["Brigg Smallshanks"] = "Brigg Smallshanks"
L["Cache of Eregos"] = "Cache of Eregos"
L["Cavern Entrance"] = "Cavern Entrance"
L["Centrifuge Construct"] = "Centrifuge Construct"
L["Champ"] = "Champ"
L["Chester Copperpot <General & Trade Supplies>"] = "Chester Copperpot <General & Trade Supplies>"
L["Chromie"] = "Chromie"
L["Chronicler Bah'Kini"] = "Chronicler Bah'Kini"
L["Colosos"] = "Colosos"
L["CoT-Strat"] = "CoT-Strat"
L["Crus"] = "Crus"
L["Crusaders' Coliseum"] = "Crusaders' Coliseum"
L["Dark Ranger Kalira"] = "Dark Ranger Kalira"
L["Dark Ranger Loralen"] = "Dark Ranger Loralen"
L["Dark Ranger Marrah"] = "Dark Ranger Marrah"
L["Defender Mordun"] = "Defender Mordun"
L["Drakuru's Brazier"] = "Drakuru's Brazier"
L["DTK"] = "DTK"
L["Elder Chogan'gada"] = "Elder Chogan'gada"
L["Elder Igasho"] = "Elder Igasho"
L["Elder Jarten"] = "Elder Jarten"
L["Elder Kilias"] = "Elder Kilias"
L["Elder Nurgen"] = "Elder Nurgen"
L["Elder Ohanzee"] = "Elder Ohanzee"
L["Elder Yurauk"] = "Elder Yurauk"
L["Eternos"] = "Eternos"
L["FH1"] = "FH1"
L["FH2"] = "FH2"
L["FH3"] = "FH3"
L["FoS"] = "FoS"
L["From previous map"] = "From previous map"
L["Frostwyrm Lair"] = "Frostwyrm Lair"
L["Gorkun Ironskull"] = "Gorkun Ironskull"
L["Guardian of Time"] = "Guardian of Time"
L["Gun"] = "Gun"
L["Heroic: Trial of the Grand Crusader"] = "Heroic: Trial of the Grand Crusader"
L["HoL"] = "HoL"
L["HoR"] = "HoR"
L["HoS"] = "HoS"
L["IC"] = "IC"
L["Image of Argent Confessor Paletress"] = "Image of Argent Confessor Paletress"
L["Image of Drakuru"] = "Image of Drakuru"
L["Jaelyne Evensong"] = "Jaelyne Evensong"
L["Kaldir Ironbane"] = "Kaldir Ironbane"
L["Kurzel"] = "Kurzel"
L["Lady Jaina Proudmoore"] = "Lady Jaina Proudmoore"
L["Lady Sylvanas Windrunner <Banshee Queen>"] = "Lady Sylvanas Windrunner <Banshee Queen>"
L["Lana Stouthammer"] = "Lana Stouthammer"
L["Lieutenant Sinclari"] = "Lieutenant Sinclari"
L["Marshal Jacob Alerius"] = "Marshal Jacob Alerius"
L["Martin Victus"] = "Martin Victus"
L["Mr. Bigglesworth"] = "Mr. Bigglesworth"
L["Nax"] = "Nax"
L["Nex, Nexus"] = "Nex, Nexus"
L["Ocu"] = "Ocu"
L["Ony"] = "Ony"
L["OS"] = "OS"
L["PoS"] = "PoS"
L["Precious"] = "Precious"
L["Prospector Doren"] = "Prospector Doren"
L["Reclaimer A'zak"] = "Reclaimer A'zak"
L["Red Dragonflight Chamber"] = "Red Dragonflight Chamber"
L["Rimefang"] = "Rimefang"
L["RS"] = "RS"
L["Scourge Invasion Points"] = "Scourge Invasion Points"
L["Seer Ixit"] = "Seer Ixit"
L["Shavalius the Fancy <Flight Master>"] = "Shavalius the Fancy <Flight Master>"
L["Sif"] = "Sif"
L["Sindragosa's Lair"] = "Sindragosa's Lair"
L["Sister Svalna"] = "Sister Svalna"
L["Slosh <Food & Drink>"] = "Slosh <Food & Drink>"
L["Spinestalker"] = "Spinestalker"
L["Stinky"] = "Stinky"
L["Stormherald Eljrrin"] = "Stormherald Eljrrin"
L["Teleporter to Middle"] = "Teleporter to Middle"
L["TEoE"] = "TEoE"
L["The Captain's Chest"] = "The Captain's Chest"
L["The Culling of Stratholme"] = "The Culling of Stratholme"
L["The Keepers"] = "The Keepers"
L["The Siege"] = "The Siege"
L["To next map"] = "To next map"
L["Tol'mar"] = "Tol'mar"
L["Tower of Flame"] = "Tower of Flame"
L["Tower of Frost"] = "Tower of Frost"
L["Tower of Life"] = "Tower of Life"
L["Tower of Storms"] = "Tower of Storms"
L["Tribunal Chest"] = "Tribunal Chest"
L["UK, Keep"] = "UK, Keep"
L["Uldu"] = "Uldu"
L["UP, Pinn"] = "UP, Pinn"
L["Upper Spire"] = "Upper Spire"
L["Verdisa"] = "Verdisa"
L["VH"] = "VH"
L["VoA"] = "VoA"
L["Warmage Kaitlyn"] = "Warmage Kaitlyn"
L["Watcher Gashra"] = "Watcher Gashra"
L["Watcher Narjil"] = "Watcher Narjil"
L["Watcher Silthik"] = "Watcher Silthik"
