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

local L = LibStub("AceLocale-3.0"):NewLocale("Atlas_MistsofPandaria", "frFR");
if not L then return end

L["Archritualist Kelada"] = "Archiritualiste Kelada"
L["Auntie Stormstout"] = "Tatie Brune d’Orage"
L["Ban Bearheart"] = "Ban Cœur d’Ours"
L["Bowmistress Li <Guard Captain>"] = "Maître-archer Li <Capitaine de la Garde>"
L["Bucket of Meaty Dog Food"] = "Seau de pâtée pour chien riche en viande"
L["Chen Stormstout"] = "Chen Brune d’Orage"
L["Coffer of Forgotten Souls"] = "Coffre des âmes oubliées"
L["Commander Lindon"] = "Commandant Lindon"
L["Flesh'rok the Diseased <Primordial Saurok Horror>"] = "Carne’rok le Malade <Horreur saurok primordiale>"
L["Focused Eye"] = "Oeil focalisé"
L["Forbidden Rites and other Rituals Necromantic"] = "Rites interdits et autres rituels nécromantiques"
L["GSS"] = "GSS"
L["Halls"] = "Salles"
L["HoF"] = "HoF"
L["Hooded Crusader"] = "Croisée capuchonnée"
L["In the Shadow of the Light"] = "À l’ombre de la Lumière"
L["Instructor Chillheart's Phylactery"] = "Phylactère de l'Instructrice Froidecœur"
L["Kel'Thuzad's Deep Knowledge"] = "Connaissances approfondies de Kel’Thuzad"
L["Master Windstrong"] = "Maître Vent Violent"
L["Monara <The Last Queen>"] = "Monara <La dernière reine>"
L["MP"] = "MP"
L["MV"] = "MV"
L["No'ku Stormsayer <Lord of Tempest>"] = "No’ku Parle-Tempête <Seigneur de la tourmente>"
L["Polyformic Acid Potion"] = "Potion d'acide polyformique"
L["Priestess Summerpetal"] = "Prêtresse Pétale de l’Été"
L["Professor Slate"] = "Professeur Alambic"
L["Reinforced Archery Target"] = "Cible de tir à l’arc renforcée"
L["Rocky Horror"] = "Horreur rocheuse"
L["SB"] = "SB"
L["Scholo"] = "Scholo"
L["Shado-Master Chum Kiu"] = "Maître-pandashan Chum Kiu"
L["Sinan the Dreamer"] = "Sinan la Rêveuse"
L["SM"] = "SM/Le Mona"
L["SNT"] = "SNT"
L["SoO"] = "SoO"
L["SPM"] = "SPM"
L["Talking Skull"] = "Crâne parlant"
L["TES"] = "TES"
L["The Dark Grimoire"] = "Le grimoire noir"
L["TJS"] = "TJS"
L["ToT"] = "ToT"
L["Unblinking Eye"] = "Oeil impassible"
L["Zao'cho <The Emperor's Shield>"] = "Zao’cho <Le bouclier de l’empereur>"

--************************************************
-- Zone Names, Acronyms, and Common Strings
--************************************************
--MoP Acronyms
L["GSS"] = "GSS";        --Gate of the Setting Sun
L["Halls"] = "Salles";   -- Salles Écarlates
L["HoF"] = "HoF";        --Heart of Fear
L["MP"] = "MP";          --Mogu'shan Palace
L["MV"] = "MV";          --Mogu'shan Vaults
L["SM"] = "SM/Le Mona";  -- Scarlet Monastery, Monastère écarlate
L["Scholo"] = "Scholo";  -- Scholomance
L["SPM"] = "SPM";        --Shado-Pan Monastery
L["SNT"] = "SNT";        --Siege of Niuzao Temple
L["SB"] = "SB";          --Stormstout Brewery
L["SoO"] = "SoO";        --Siege of Orgrimmar
L["TJS"] = "TJS";        --Temple of the Jade Serpent
L["TES"] = "TES";        --Terrace of Endless Spring
L["ToT"] = "ToT";        --Throne of Thunder

--*********************
-- Mists of Pandaria Instances
--*********************

--Gate of the Setting Sun
L["Bowmistress Li <Guard Captain>"] = "Maître-archer Li <Capitaine de la Garde>";

--Heart of Fear

--Mogu'shan Palace
L["Sinan the Dreamer"] = "Sinan la Rêveuse";

--Mogu'shan Vaults

--Scarlet Halls
L["Commander Lindon"] = "Commandant Lindon";
L["Hooded Crusader"] = "Croisée capuchonnée";
L["Bucket of Meaty Dog Food"] = "Seau de pâtée pour chien riche en viande";
L["Reinforced Archery Target"] = "Cible de tir à l’arc renforcée";

--Scarlet Monastery

--Scholomance
L["Instructor Chillheart's Phylactery"] = "Phylactère de l'Instructrice Froidecœur";
L["Professor Slate"] = "Professeur Alambic";
L["Polyformic Acid Potion"] = "Potion d'acide polyformique";
L["Talking Skull"] = "Crâne parlant";
L["In the Shadow of the Light"] = "À l’ombre de la Lumière";
L["Kel'Thuzad's Deep Knowledge"] = "Connaissances approfondies de Kel’Thuzad";
L["Forbidden Rites and other Rituals Necromantic"] = "Rites interdits et autres rituels nécromantiques";
L["Coffer of Forgotten Souls"] = "Coffre des âmes oubliées";
L["The Dark Grimoire"] = "Le grimoire noir";

--Shado-Pan Monastery
L["Ban Bearheart"] = "Ban Cœur d’Ours";

--Siege of Niuzao Temple
L["Shado-Master Chum Kiu"] = "Maître-pandashan Chum Kiu";

--Siege of Orgrimmar

--Stormstout Brewery
L["Auntie Stormstout"] = "Tatie Brune d’Orage";
L["Chen Stormstout"] = "Chen Brune d’Orage";

--Temple of the Jade Serpent
L["Master Windstrong"] = "Maître Vent Violent";
L["Priestess Summerpetal"] = "Prêtresse Pétale de l’Été";

--Terrace of Endless Spring

--Throne of Thunder
L["Monara <The Last Queen>"] = "Monara <La dernière reine>";
L["No'ku Stormsayer <Lord of Tempest>"] = "No’ku Parle-Tempête <Seigneur de la tourmente>";
L["Rocky Horror"] = "Horreur rocheuse";
L["Focused Eye"] = "Oeil focalisé";
L["Unblinking Eye"] = "Oeil impassible";
L["Archritualist Kelada"] = "Archiritualiste Kelada";
L["Flesh'rok the Diseased <Primordial Saurok Horror>"] = "Carne’rok le Malade <Horreur saurok primordiale>";
L["Zao'cho <The Emperor's Shield>"] = "Zao’cho <Le bouclier de l’empereur>";
