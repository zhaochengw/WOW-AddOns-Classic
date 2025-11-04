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

local L = LibStub("AceLocale-3.0"):NewLocale("Atlas_MistsofPandaria", "esES");
if not L then return end

L["Archritualist Kelada"] = "Archiritualista Kelada"
L["Auntie Stormstout"] = "Tía Cerveza de Trueno"
L["Ban Bearheart"] = "Ban Corazón Fiero"
L["Bowmistress Li <Guard Captain>"] = "Maestra arquera Li <Capitana de la Guardia>"
L["Bucket of Meaty Dog Food"] = "Cubo de comida para perros carnosa"
L["Chen Stormstout"] = "Chen Cerveza de Trueno"
L["Coffer of Forgotten Souls"] = "Arca de las almas olvidadas"
L["Commander Lindon"] = "Comandante Lindon"
L["Flesh'rok the Diseased <Primordial Saurok Horror>"] = "Flesh'rok el Enfermo <Horror saurok primordial>"
L["Focused Eye"] = "Ojo enfocado"
L["Forbidden Rites and other Rituals Necromantic"] = "Ritos prohibidos y otros rituales nigrománticos"
L["GSS"] = "GSS"
L["Halls"] = "Salas"
L["HoF"] = "HoF"
L["Hooded Crusader"] = "Cruzada encapuchada"
L["In the Shadow of the Light"] = "A la sombra de la Luz"
L["Instructor Chillheart's Phylactery"] = "Filacteria de la instructora Corazón Álgido"
L["Kel'Thuzad's Deep Knowledge"] = "Saber profundo de Kel'Thuzad"
L["Master Windstrong"] = "Maestro Viento Impetuoso"
L["Monara <The Last Queen>"] = "Monara <La Última Reina>"
L["MP"] = "MP"
L["MV"] = "MV"
L["No'ku Stormsayer <Lord of Tempest>"] = "Orador de la tormenta No'ku <Señor de la Tempestad>"
L["Polyformic Acid Potion"] = "La ciencia del ácido polifórmico"
L["Priestess Summerpetal"] = "Sacerdotisa Pétalo Estival"
L["Professor Slate"] = "Profesor Slate"
L["Reinforced Archery Target"] = "Objetivo de tiro con arco reforzado"
L["Rocky Horror"] = "Horror rocoso"
L["SB"] = "SB"
L["Scholo"] = "Scholo"
L["Shado-Master Chum Kiu"] = "Maestro Shado Chum Kiu"
L["Sinan the Dreamer"] = "Sinan la Soñadora <Custodia>"
L["SM"] = "SM"
L["SNT"] = "SNT"
L["SoO"] = "SoO"
L["SPM"] = "SPM"
L["Talking Skull"] = "Calavera parlante"
L["TES"] = "TES"
L["The Dark Grimoire"] = "El grimorio oscuro"
L["TJS"] = "TJS"
L["ToT"] = "ToT"
L["Unblinking Eye"] = "Ojo imperturbable"
L["Zao'cho <The Emperor's Shield>"] = "Zao'cho <El escudo del Emperador>"


--************************************************
-- Zone Names, Acronyms, and Common Strings
--************************************************
--MoP Acronyms
L["GSS"] = "GSS";       --Gate of the Setting Sun
L["Halls"] = "Salas";   -- Scarlet Halls
L["HoF"] = "HoF";       --Heart of Fear
L["MP"] = "MP";         --Mogu'shan Palace
L["MV"] = "MV";         --Mogu'shan Vaults
L["SM"] = "SM";         -- Scarlet Monastery
L["Scholo"] = "Scholo"; -- Scholomance
L["SPM"] = "SPM";       --Shado-Pan Monastery
L["SNT"] = "SNT";       --Siege of Niuzao Temple
L["SB"] = "SB";         --Stormstout Brewery
L["SoO"] = "SoO";       --Siege of Orgrimmar
L["TJS"] = "TJS";       --Temple of the Jade Serpent
L["TES"] = "TES";       --Terrace of Endless Spring
L["ToT"] = "ToT";       --Throne of Thunder

--*********************
-- Mists of Pandaria Instances
--*********************

--Gate of the Setting Sun
L["Bowmistress Li <Guard Captain>"] = "Maestra arquera Li <Capitana de la Guardia>";

--Heart of Fear

--Mogu'shan Palace
L["Sinan the Dreamer"] = "Sinan la Soñadora <Custodia>";

--Mogu'shan Vaults

--Scarlet Halls
L["Commander Lindon"] = "Comandante Lindon";
L["Hooded Crusader"] = "Cruzada encapuchada";
L["Bucket of Meaty Dog Food"] = "Cubo de comida para perros carnosa";
L["Reinforced Archery Target"] = "Objetivo de tiro con arco reforzado";

--Scarlet Monastery

--Scholomance
L["Instructor Chillheart's Phylactery"] = "Filacteria de la instructora Corazón Álgido";
L["Professor Slate"] = "Profesor Slate";
L["Polyformic Acid Potion"] = "La ciencia del ácido polifórmico";
L["Talking Skull"] = "Calavera parlante";
L["In the Shadow of the Light"] = "A la sombra de la Luz";
L["Kel'Thuzad's Deep Knowledge"] = "Saber profundo de Kel'Thuzad";
L["Forbidden Rites and other Rituals Necromantic"] = "Ritos prohibidos y otros rituales nigrománticos";
L["Coffer of Forgotten Souls"] = "Arca de las almas olvidadas";
L["The Dark Grimoire"] = "El grimorio oscuro";

--Shado-Pan Monastery
L["Ban Bearheart"] = "Ban Corazón Fiero";

--Siege of Niuzao Temple
L["Shado-Master Chum Kiu"] = "Maestro Shado Chum Kiu";

--Siege of Orgrimmar

--Stormstout Brewery
L["Auntie Stormstout"] = "Tía Cerveza de Trueno";
L["Chen Stormstout"] = "Chen Cerveza de Trueno";

--Temple of the Jade Serpent
L["Master Windstrong"] = "Maestro Viento Impetuoso";
L["Priestess Summerpetal"] = "Sacerdotisa Pétalo Estival";

--Terrace of Endless Spring

--Throne of Thunder
L["Monara <The Last Queen>"] = "Monara <La Última Reina>";
L["No'ku Stormsayer <Lord of Tempest>"] = "Orador de la tormenta No'ku <Señor de la Tempestad>";
L["Rocky Horror"] = "Horror rocoso";
L["Focused Eye"] = "Ojo enfocado";
L["Unblinking Eye"] = "Ojo imperturbable";
L["Archritualist Kelada"] = "Archiritualista Kelada";
L["Flesh'rok the Diseased <Primordial Saurok Horror>"] = "Flesh'rok el Enfermo <Horror saurok primordial>";
L["Zao'cho <The Emperor's Shield>"] = "Zao'cho <El escudo del Emperador>"; --check
