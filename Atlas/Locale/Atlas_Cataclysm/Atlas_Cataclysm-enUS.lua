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

local L = LibStub("AceLocale-3.0"):NewLocale("Atlas_Cataclysm", "enUS", true, true);
if not L then return end

L["Alurmi"] = "Alurmi"
L["Alyson Antille"] = "Alyson Antille"
L["Apothecary Baxter <Crown Chemical Co.>"] = "Apothecary Baxter <Crown Chemical Co.>"
L["Apothecary Frye <Crown Chemical Co.>"] = "Apothecary Frye <Crown Chemical Co.>"
L["Apothecary Hummel <Crown Chemical Co.>"] = "Apothecary Hummel <Crown Chemical Co.>"
L["Apothecary Trio"] = "Apothecary Trio"
L["Arinoth"] = "Arinoth"
L["Bakkalzu"] = "Bakkalzu"
L["Baleflame"] = "Baleflame"
L["Berserking Boulder Roller"] = "Berserking Boulder Roller"
L["BH"] = "BH"
L["Blood Guard Hakkuz <Darkspear Elite>"] = "Blood Guard Hakkuz <Darkspear Elite>"
L["Bloodslayer T'ara <Darkspear Veteran>"] = "Bloodslayer T'ara <Darkspear Veteran>"
L["Bloodslayer Vaena <Darkspear Veteran>"] = "Bloodslayer Vaena <Darkspear Veteran>"
L["Bloodslayer Zala <Darkspear Veteran>"] = "Bloodslayer Zala <Darkspear Veteran>"
L["BoT"] = "BoT"
L["Brann Bronzebeard"] = "Brann Bronzebeard"
L["BRC"] = "BRC"
L["Briney Boltcutter <Blackwater Financial Interests>"] = "Briney Boltcutter <Blackwater Financial Interests>"
L["BWD"] = "BWD"
L["Captain Hadan"] = "Captain Hadan"
L["Captain Taylor"] = "Captain Taylor"
L["Chromie"] = "Chromie"
L["CoT-DS"] = "CoT-DS"
L["CoT-ET"] = "CoT-ET"
L["CoT-HoT"] = "CoT-HoT"
L["CoT-WoE"] = "CoT-WoE"
L["Darkheart"] = "Darkheart"
L["Dasnurimi <Geologist & Conservator>"] = "Dasnurimi <Geologist & Conservator>"
L["Deathstalker Commander Belmont"] = "Deathstalker Commander Belmont"
L["Earthwarden Yrsa <The Earthen Ring>"] = "Earthwarden Yrsa <The Earthen Ring>"
L["Eulinda <Reagents>"] = "Eulinda <Reagents>"
L["Farseer Tooranu <The Earthen Ring>"] = "Farseer Tooranu <The Earthen Ring>"
L["Fenstalker"] = "Fenstalker"
L["Finkle Einhorn"] = "Finkle Einhorn"
L["FL"] = "FL"
L["Forest Frogs"] = "Forest Frogs"
L["Gazakroth"] = "Gazakroth"
L["GB"] = "GB"
L["Goblin Teleporter"] = "Goblin Teleporter"
L["Gub <Destroyer of Fish>"] = "Gub <Destroyer of Fish>"
L["Harald <Food Vendor>"] = "Harald <Food Vendor>"
L["Haunted Stable Hand"] = "Haunted Stable Hand"
L["Hazlek"] = "Hazlek"
L["Helpful Jungle Monkey"] = "Helpful Jungle Monkey"
L["HoO"] = "HoO"
L["Investigator Fezzen Brasstacks"] = "Investigator Fezzen Brasstacks"
L["Itesh"] = "Itesh"
L["Kagtha"] = "Kagtha"
L["Kaldrick"] = "Kaldrick"
L["Kasha"] = "Kasha"
L["Kaulema the Mover"] = "Kaulema the Mover"
L["Koragg"] = "Koragg"
L["Large Stone Obelisk"] = "Large Stone Obelisk"
L["LCoT"] = "LCoT"
L["Legionnaire Nazgrim"] = "Legionnaire Nazgrim"
L["Lenzo"] = "Lenzo"
L["Lieutenant Horatio Laine"] = "Lieutenant Horatio Laine"
L["Lord Afrasastrasz"] = "Lord Afrasastrasz"
L["Lord Raadan"] = "Lord Raadan"
L["Lurah Wrathvine <Crystallized Firestone Collector>"] = "Lurah Wrathvine <Crystallized Firestone Collector>"
L["Magical Brazier"] = "Magical Brazier"
L["Mawago"] = "Mawago"
L["Melasong"] = "Melasong"
L["Melissa"] = "Melissa"
L["Micah"] = "Micah"
L["Miss Mayhem"] = "Miss Mayhem"
L["Mor'Lek the Dismantler"] = "Mor'Lek the Dismantler"
L["Mortaxx <The Tolling Bell>"] = "Mortaxx <The Tolling Bell>"
L["Naresir Stormfury <Avengers of Hyjal Quartermaster>"] = "Naresir Stormfury <Avengers of Hyjal Quartermaster>"
L["Neptulon"] = "Neptulon"
L["Norkani"] = "Norkani"
L["Nozdormu"] = "Nozdormu"
L["Overseer Blingbang"] = "Overseer Blingbang"
L["Packleader Ivar Bloodfang"] = "Packleader Ivar Bloodfang"
L["Quartermaster Lewis <Quartermaster>"] = "Quartermaster Lewis <Quartermaster>"
L["Relissa"] = "Relissa"
L["Rosa"] = "Rosa"
L["SFK"] = "SFK"
L["Slinky Sharpshiv"] = "Slinky Sharpshiv"
L["Slither"] = "Slither"
L["The Map of Zul'Aman"] = "The Map of Zul'Aman"
L["Thrall"] = "Thrall"
L["Thurg"] = "Thurg"
L["Tiki Lord Mu'Loa"] = "Tiki Lord Mu'Loa"
L["Tiki Lord Zim'wae"] = "Tiki Lord Zim'wae"
L["Tol'vir Grave"] = "Tol'vir Grave"
L["Tor-Tun <The Slumberer>"] = "Tor-Tun <The Slumberer>"
L["ToTT"] = "ToTT"
L["TSC"] = "TSC"
L["TWT"] = "TWT"
L["Tyllan"] = "Tyllan"
L["VC"] = "VC"
L["Vehini <Assault Provisions>"] = "Vehini <Assault Provisions>"
L["Velastrasza"] = "Velastrasza"
L["Vend-O-Tron D-Luxe"] = "Vend-O-Tron D-Luxe"
L["Venomancer Mauri <The Snake's Whisper>"] = "Venomancer Mauri <The Snake's Whisper>"
L["Venomancer T'Kulu <The Toxic Bite>"] = "Venomancer T'Kulu <The Toxic Bite>"
L["Vol'jin"] = "Vol'jin"
L["Voodoo Pile"] = "Voodoo Pile"
L["VP"] = "VP"
L["Witch Doctor Qu'in <Medicine Woman>"] = "Witch Doctor Qu'in <Medicine Woman>"
L["Witch Doctor T'wansi"] = "Witch Doctor T'wansi"
L["ZA"] = "ZA"
L["Zanza the Restless"] = "Zanza the Restless"
L["Zanzil's Cauldron of Burning Blood"] = "Zanzil's Cauldron of Burning Blood"
L["Zanzil's Cauldron of Frostburn Formula"] = "Zanzil's Cauldron of Frostburn Formula"
L["Zanzil's Cauldron of Toxic Torment"] = "Zanzil's Cauldron of Toxic Torment"
L["ZG"] = "ZG"
L["Zungam"] = "Zungam"

--************************************************
-- Zone Names, Acronyms, and Common Strings
--************************************************
--Cataclysm Acronyms
L["BH"] = "BH";            --Baradin Hold
L["BoT"] = "BoT";          --Bastion of Twilight
L["BRC"] = "BRC";          --Blackrock Caverns
L["BWD"] = "BWD";          --Blackwing Descent
L["CoT-DS"] = "CoT-DS";    --Caverns of Time: Dragon Soul
L["CoT-ET"] = "CoT-ET";    --Caverns of Time: End Time
L["CoT-HoT"] = "CoT-HoT";  --Caverns of Time: Hour of Twilight
L["CoT-WoE"] = "CoT-WoE";  --Caverns of Time: Well of Eternity
L["FL"] = "FL";            --Firelands
L["GB"] = "GB";            --Grim Batol
L["HoO"] = "HoO";          --Halls of Origination
L["LCoT"] = "LCoT";        --Lost City of the Tol'vir
L["SFK"] = "SFK";          -- Shadowfang Keep
L["TSC"] = "TSC";          --The Stonecore
L["TWT"] = "TWT";          --Throne of the Four Winds
L["ToTT"] = "ToTT";        --Throne of the Tides
L["VC"] = "VC";            -- The Deadmines
L["VP"] = "VP";            --The Vortex Pinnacle
L["ZA"] = "ZA";            -- Zul'Aman
L["ZG"] = "ZG";            --Zul'Gurub

--*********************
-- Cataclysm Instances
--*********************

--Baradin Hold

--Blackrock Caverns
L["Finkle Einhorn"] = "Finkle Einhorn"

--Blackwing Descent

--Caverns of Time: Dragon Soul
L["Dasnurimi <Geologist & Conservator>"] = "Dasnurimi <Geologist & Conservator>";
L["Lord Afrasastrasz"] = "Lord Afrasastrasz";

--Caverns of Time: End Time
L["Alurmi"] = "Alurmi";
L["Nozdormu"] = "Nozdormu";
L["Chromie"] = "Chromie";

--Caverns of Time: Hour of Twilight
L["Thrall"] = "Thrall";

--Caverns of Time: Well of Eternity

--Firelands
L["Lurah Wrathvine <Crystallized Firestone Collector>"] = "Lurah Wrathvine <Crystallized Firestone Collector>";    -- 54402
L["Naresir Stormfury <Avengers of Hyjal Quartermaster>"] = "Naresir Stormfury <Avengers of Hyjal Quartermaster>";  -- 54401

--Grim Batol
L["Baleflame"] = "Baleflame";
L["Farseer Tooranu <The Earthen Ring>"] = "Farseer Tooranu <The Earthen Ring>";
L["Velastrasza"] = "Velastrasza";

--Halls of Origination
L["Large Stone Obelisk"] = "Large Stone Obelisk";
L["Brann Bronzebeard"] = "Brann Bronzebeard";

--Lost City of the Tol'vir
L["Captain Hadan"] = "Captain Hadan";
L["Tol'vir Grave"] = "Tol'vir Grave";

--Shadowfang Keep
L["Apothecary Trio"] = "Apothecary Trio";
L["Apothecary Hummel <Crown Chemical Co.>"] = "Apothecary Hummel <Crown Chemical Co.>";
L["Apothecary Baxter <Crown Chemical Co.>"] = "Apothecary Baxter <Crown Chemical Co.>";
L["Apothecary Frye <Crown Chemical Co.>"] = "Apothecary Frye <Crown Chemical Co.>";
L["Packleader Ivar Bloodfang"] = "Packleader Ivar Bloodfang";
L["Deathstalker Commander Belmont"] = "Deathstalker Commander Belmont";
L["Haunted Stable Hand"] = "Haunted Stable Hand";
L["Investigator Fezzen Brasstacks"] = "Investigator Fezzen Brasstacks";

--The Bastion of Twilight

--The Deadmines
L["Lieutenant Horatio Laine"] = "Lieutenant Horatio Laine";
L["Kagtha"] = "Kagtha";
L["Slinky Sharpshiv"] = "Slinky Sharpshiv";
L["Quartermaster Lewis <Quartermaster>"] = "Quartermaster Lewis <Quartermaster>";
L["Miss Mayhem"] = "Miss Mayhem";
L["Vend-O-Tron D-Luxe"] = "Vend-O-Tron D-Luxe";
L["Goblin Teleporter"] = "Goblin Teleporter";

--The Stonecore
L["Earthwarden Yrsa <The Earthen Ring>"] = "Earthwarden Yrsa <The Earthen Ring>";

--The Vortex Pinnacle
L["Itesh"] = "Itesh";
L["Magical Brazier"] = "Magical Brazier";

--Throne of the Four Winds

--Throne of the Tides
L["Captain Taylor"] = "Captain Taylor";
L["Legionnaire Nazgrim"] = "Legionnaire Nazgrim";
L["Neptulon"] = "Neptulon";

--Zul'Aman
L["Vol'jin"] = "Vol'jin";
L["Witch Doctor T'wansi"] = "Witch Doctor T'wansi";
L["Blood Guard Hakkuz <Darkspear Elite>"] = "Blood Guard Hakkuz <Darkspear Elite>";
L["Voodoo Pile"] = "Voodoo Pile";
L["Bakkalzu"] = "Bakkalzu";
L["Hazlek"] = "Hazlek";
L["The Map of Zul'Aman"] = "The Map of Zul'Aman";
L["Norkani"] = "Norkani";
L["Kasha"] = "Kasha";
L["Thurg"] = "Thurg";
L["Gazakroth"] = "Gazakroth";
L["Lord Raadan"] = "Lord Raadan";
L["Darkheart"] = "Darkheart";
L["Alyson Antille"] = "Alyson Antille";
L["Slither"] = "Slither";
L["Fenstalker"] = "Fenstalker";
L["Koragg"] = "Koragg";
L["Zungam"] = "Zungam";
L["Forest Frogs"] = "Forest Frogs";
L["Eulinda <Reagents>"] = "Eulinda <Reagents>";
L["Harald <Food Vendor>"] = "Harald <Food Vendor>";
L["Arinoth"] = "Arinoth";
L["Kaldrick"] = "Kaldrick";
L["Lenzo"] = "Lenzo";
L["Mawago"] = "Mawago";
L["Melasong"] = "Melasong";
L["Melissa"] = "Melissa";
L["Micah"] = "Micah";
L["Relissa"] = "Relissa";
L["Rosa"] = "Rosa";
L["Tyllan"] = "Tyllan";

--Zul'Gurub
L["Briney Boltcutter <Blackwater Financial Interests>"] = "Briney Boltcutter <Blackwater Financial Interests>";
L["Vehini <Assault Provisions>"] = "Vehini <Assault Provisions>";
L["Overseer Blingbang"] = "Overseer Blingbang";
L["Bloodslayer T'ara <Darkspear Veteran>"] = "Bloodslayer T'ara <Darkspear Veteran>";
L["Bloodslayer Vaena <Darkspear Veteran>"] = "Bloodslayer Vaena <Darkspear Veteran>";
L["Bloodslayer Zala <Darkspear Veteran>"] = "Bloodslayer Zala <Darkspear Veteran>";
L["Helpful Jungle Monkey"] = "Helpful Jungle Monkey";
L["Venomancer Mauri <The Snake's Whisper>"] = "Venomancer Mauri <The Snake's Whisper>";
L["Zanzil's Cauldron of Toxic Torment"] = "Zanzil's Cauldron of Toxic Torment";
L["Tiki Lord Mu'Loa"] = "Tiki Lord Mu'Loa";
L["Gub <Destroyer of Fish>"] = "Gub <Destroyer of Fish>";
L["Venomancer T'Kulu <The Toxic Bite>"] = "Venomancer T'Kulu <The Toxic Bite>";
L["Tor-Tun <The Slumberer>"] = "Tor-Tun <The Slumberer>";
L["Kaulema the Mover"] = "Kaulema the Mover";
L["Berserking Boulder Roller"] = "Berserking Boulder Roller";
L["Zanzil's Cauldron of Frostburn Formula"] = "Zanzil's Cauldron of Frostburn Formula";
L["Mor'Lek the Dismantler"] = "Mor'Lek the Dismantler";
L["Witch Doctor Qu'in <Medicine Woman>"] = "Witch Doctor Qu'in <Medicine Woman>";
L["Zanza the Restless"] = "Zanza the Restless";
L["Mortaxx <The Tolling Bell>"] = "Mortaxx <The Tolling Bell>";
L["Tiki Lord Zim'wae"] = "Tiki Lord Zim'wae";
L["Zanzil's Cauldron of Burning Blood"] = "Zanzil's Cauldron of Burning Blood";
