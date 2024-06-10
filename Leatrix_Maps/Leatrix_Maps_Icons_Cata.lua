
	----------------------------------------------------------------------
	-- Leatrix Maps Icons
	----------------------------------------------------------------------

	local void, Leatrix_Maps = ...
	local L = Leatrix_Maps.L

	-- Dungeons
	local dnTex, rdTex = "Dungeon", "Raid"

	-- Flight points
	local tATex, tHTex, tNTex = "TaxiNode_Alliance", "TaxiNode_Horde", "TaxiNode_Neutral"

	-- Portals
	local pATex, pHTex, pNTex = "TaxiNode_Continent_Alliance", "TaxiNode_Continent_Horde", "TaxiNode_Continent_Neutral"

	-- Boat harbors, zeppelin towers and tram stations (these are just templates, they will be replaced)
	local fATex, fHTex, fNTex = "Vehicle-TempleofKotmogu-CyanBall", "Vehicle-TempleofKotmogu-CyanBall", "Vehicle-TempleofKotmogu-CyanBall"

	-- Zone crossings
	local arTex = "Garr_LevelUpgradeArrow"

	Leatrix_Maps["Icons"] = {

		-- pos for code then showinst on Encounter Journal for dungeon ID.

		----------------------------------------------------------------------
		--	Eastern Kingdoms
		----------------------------------------------------------------------

		--[[Arathi Highlands]] [1417] = {
			{"FlightA", 39.9, 47.4, L["Refuge Pointe"] .. ", " .. L["Arathi Highlands"], nil, tATex, nil, nil},
			{"FlightH", 13.3, 34.8, L["Galen's Fall"] .. ", " .. L["Arathi Highlands"], nil, tHTex, nil, nil},
			{"FlightH", 68.2, 33.4, L["Hammerfall"] .. ", " .. L["Arathi Highlands"], nil, tHTex, nil, nil},
			{"Arrow", 45.4, 88.9, L["Wetlands"], L["Thandol Span"], arTex, nil, nil, nil, nil, nil, 3.2, 1437},
			{"Arrow", 20.9, 30.6, L["Hillsbrad Foothills"], nil, arTex, nil, nil, nil, nil, nil, 1, 1424},
		},
		--[[Badlands]] [1418] = {
			{"FlightA", 21.6, 57.6, L["Dragon's Mouth"] .. ", " .. L["Badlands"], nil, tATex, nil, nil},
			{"FlightA", 48.8, 36.2, L["Dustwind Dig"] .. ", " .. L["Badlands"], nil, tATex, nil, nil},
			{"FlightN", 64.2, 35.2, L["Fuselight"] .. ", " .. L["Badlands"], nil, tNTex, nil, nil},
			{"FlightH", 17.2, 40.0, L["New Kargath"] .. ", " .. L["Badlands"], nil, tHTex, nil, nil},
			{"FlightH", 52.4, 50.8, L["Bloodwatcher Point"] .. ", " .. L["Badlands"], nil, tHTex, nil, nil},
			{"Dungeon", 41.7, 11.6, L["Uldaman"], L["Dungeon"], dnTex, 36, 40, 30, 36, 80}, -- sum cap was 44
			{"Arrow", 51.1, 14.8, L["Loch Modan"], nil, arTex, nil, nil, nil, nil, nil, 0.8, 1432},
			{"Arrow", 5.3, 61.1, L["Searing Gorge"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1427},
		},
		--[[Blasted Lands]] [1419] = {
			{"FlightA", 61.3, 21.6, L["Nethergarde Keep"] .. ", " .. L["Blasted Lands"], nil, tATex, nil, nil},
			{"FlightA", 47.1, 89.3, L["Surwich"] .. ", " .. L["Blasted Lands"], nil, tATex, nil, nil},
			{"FlightH", 50.9, 72.9, L["Sunveil Excursion"] .. ", " .. L["Blasted Lands"], nil, tHTex, nil, nil},
			{"FlightH", 43.7, 14.2, L["Dreadmaul Hold"] .. ", " .. L["Blasted Lands"], nil, tHTex, nil, nil},
			{"Arrow", 52.2, 10.7, L["Swamp of Sorrows"], nil, arTex, nil, nil, nil, nil, nil, 0, 1435},
			{"Arrow", 58.8, 59.7, L["Hellfire Peninsula"], L["The Dark Portal"], arTex, nil, nil, nil, nil, nil, 3.5, 1944},
		},
		--[[Tirisfal Glades]] [1420] = {
			{"FlightH", 58.8, 51.9, L["Brill"] .. ", " .. L["Tirisfal Glades"], nil, tHTex, nil, nil},
			{"FlightH", 83.4, 70.0, L["The Bulwark"] .. ", " .. L["Tirisfal Glades"], nil, tHTex, nil, nil},
			{"Dungeon", 82.5, 33.3, L["Scarlet Halls"] .. ", " .. L["Scarlet Monastery"], L["Dungeon"], dnTex},
			{"TravelH", 60.7, 58.8, L["Zeppelin to"] .. " " .. L["Orgrimmar"] .. ", " .. L["Durotar"], nil, fHTex, nil, nil, nil, nil, nil, 0, 1411},
			{"TravelH", 61.9, 59.0, L["Zeppelin to"] .. " " .. L["Grom'gol"] .. ", " .. L["Stranglethorn Vale"], nil, pHTex},
			{"TravelH", 59.1, 58.9, L["Zeppelin to"] .. " " .. L["Vengeance Landing"] .. ", " .. L["Howling Fjord"], nil, pHTex},
			{"Arrow", 83.4, 70.6, L["Western Plaguelands"], L["The Bulwark"], arTex, nil, nil, nil, nil, nil, 4.7, 1422},
			{"Arrow", 61.9, 65.0, L["Undercity"], nil, arTex, nil, nil, nil, nil, nil, 3, 1458},
			{"Arrow", 54.9, 72.7, L["Silverpine Forest"], nil, arTex, nil, nil, nil, nil, nil, 3, 1421},
			{"Arrow", 51, 71.4, L["Undercity"], L["Sewers"], arTex, nil, nil, nil, nil, nil, 3.0, 1458},
		},
		--[[Silverpine Forest]] [1421] = {
			{"FlightH", 45.4, 42.5, L["The Sepulcher"] .. ", " .. L["Silverpine Forest"], nil, tHTex, nil, nil},
			{"FlightH", 57.8, 8.8, L["Forsaken High Command"] .. ", " .. L["Silverpine Forest"], nil, tHTex, nil, nil},
			{"FlightH", 45.8, 21.8, L["Forsaken Rear Guard"] .. ", " .. L["Silverpine Forest"], nil, tHTex, nil, nil},
			{"FlightH", 50.8, 63.6, L["The Forsaken Front"] .. ", " .. L["Silverpine Forest"], nil, tHTex, nil, nil},
			{"Dungeon", 44.8, 67.8, L["Shadowfang Keep"], L["Dungeon"], dnTex, 18, 21, 14, 17, 80}, -- sum cap was 25
			{"Arrow", 66.3, 79.8, L["Hillsbrad Foothills"], nil, arTex, nil, nil, nil, nil, nil, 4.3, 1424},
			{"Arrow", 67.7, 5.0, L["Tirisfal Glades"], nil, arTex, nil, nil, nil, nil, nil, 5.7, 1420},
			{"Arrow", 68.7, 52.5, L["Alterac Mountains"], L["Dalaran Crater"], arTex, nil, nil, nil, nil, nil, 4.3, 1416},
		},
		--[[Western Plaguelands]] [1422] = {
			{"Dungeon", 69.7, 73.2, L["Scholomance"], L["Dungeon"], dnTex, 58, 60, 45, 56, 80}, -- sum cap was 61
			{"FlightA", 39.4, 69.5, L["Andorhal"] .. ", " .. L["Western Plaguelands"], nil, tATex, nil, nil},
			{"FlightA", 42.9, 85.1, L["Chillwind Camp"] .. ", " .. L["Western Plaguelands"], nil, tATex, nil, nil},
			{"FlightH", 46.6, 64.6, L["Andorhal"] .. ", " .. L["Western Plaguelands"], nil, tHTex, nil, nil},
			{"FlightN", 44.6, 18.4, L["Hearthglen"] .. ", " .. L["Western Plaguelands"], nil, tNTex, nil, nil},
			{"FlightN", 50.5, 52.2, L["The Menders' Stead"] .. ", " .. L["Western Plaguelands"], nil, tNTex, nil, nil},
			{"Arrow", 44.1, 87.1, L["Alterac Mountains"], nil, arTex, nil, nil, nil, nil, nil, 3, 1416},
			{"Arrow", 28.6, 57.5, L["Tirisfal Glades"], L["The Balwark"], arTex, nil, nil, nil, nil, nil, 1.6, 1420},
			{"Arrow", 69.7, 50.3, L["Eastern Plaguelands"], nil, arTex, nil, nil, nil, nil, nil, 4.7, 1423},
			{"Arrow", 65.3, 86.4, L["The Hinterlands"], nil, arTex, nil, nil, nil, nil, nil, 3, 1425},
			{"Arrow", 53.5, 92.9, L["Alterac Mountains"], nil, arTex, nil, nil, nil, nil, nil, 2.2, 1416},
		},
		--[[Eastern Plaguelands]] [1423] = {
			{"Dungeon", 27.7, 11.6, L["Stratholme: Crusader's Square"], L["Dungeon"], dnTex},
			{"Dungeon", 43.5, 19.4, L["Stratholme: The Gauntlet"], L["Dungeon"], dnTex},
			{"FlightA", 75.9, 53.4, L["Light's Hope Chapel"] .. ", " .. L["Eastern Plaguelands"], nil, tATex, nil, nil},
			{"FlightH", 75.8, 53.3, L["Light's Hope Chapel"] .. ", " .. L["Eastern Plaguelands"], nil, tHTex, nil, nil},
			{"FlightN", 18.5, 27.4, L["Plaguewood Tower"] .. ", " .. L["Eastern Plaguelands"], nil, tNTex, nil, nil},
			{"FlightN", 51.3, 21.3, L["Northpass Tower"] .. ", " .. L["Eastern Plaguelands"], nil, tNTex, nil, nil},
			{"FlightN", 61.6, 43.8, L["Eastwall Tower"] .. ", " .. L["Eastern Plaguelands"], nil, tNTex, nil, nil},
			{"FlightN", 52.8, 53.6, L["Light's Shield Tower"] .. ", " .. L["Eastern Plaguelands"], nil, tNTex, nil, nil},
			{"FlightN", 34.9, 67.9, L["Crown Guard Tower"] .. ", " .. L["Eastern Plaguelands"], nil, tNTex, nil, nil},
			{"FlightN", 10.1, 65.7, L["Thondroril River"] .. ", " .. L["Eastern Plaguelands"], nil, tNTex, nil, nil},
			{"FlightN", 83.9, 50.4, L["Acherus: The Ebon Hold"] .. ", " .. L["Eastern Plaguelands"], nil, tNTex, nil, nil},
			{"Arrow", 8.7, 66.2, L["Western Plaguelands"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 1422},
			{"Arrow", 54.2, 14.4, L["Ghostlands"], nil, arTex, nil, nil, nil, nil, nil, 0.4, 1942},
		},
		--[[Hillsbrad Foothills]] [1424] = {
			{"FlightH", 29.0, 64.4, L["Southpoint Gate"] .. ", " .. L["Hillsbrad Foothills"], nil, tHTex, nil, nil},
			{"FlightH", 49.0, 66.2, L["Ruins of Southshore"] .. ", " .. L["Hillsbrad Foothills"], nil, tHTex, nil, nil},
			{"FlightH", 59.6, 63.2, L["Eastpoint Tower"] .. ", " .. L["Hillsbrad Foothills"], nil, tHTex, nil, nil},
			{"FlightH", 56.1, 46.1, L["Tarren Mill"] .. ", " .. L["Hillsbrad Foothills"], nil, tHTex, nil, nil},
			{"FlightH", 58.2, 26.4, L["Strahnbrad"] .. ", " .. L["Hillsbrad Foothills"], nil, tHTex, nil, nil},
			{"Arrow", 84.6, 31.8, L["The Hinterlands"], nil, arTex, nil, nil, nil, nil, nil, 5.4, 1425},
			{"Arrow", 54.8, 11.3, L["Alterac Mountains"], nil, arTex, nil, nil, nil, nil, nil, 0, 1416},
			{"Arrow", 13.7, 46.2, L["Silverpine Forest"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1421},
			{"Arrow", 81.0, 56.1, L["Arathi Highlands"], nil, arTex, nil, nil, nil, nil, nil, 4.1, 1417},
			{"Arrow", 75.5, 24.6, L["Alterac Mountains"], L["Ravenholdt Manor"], arTex, nil, nil, nil, nil, nil, 0.0, 1416},
			{"Arrow", 71.7, 8.6, L["Alterac Mountains"], nil, arTex, nil, nil, nil, nil, nil, 5.6, 1416},
		},
		--[[The Hinterlands]] [1425] = {
			{"FlightA", 11.1, 46.2, L["Aerie Peak"] .. ", " .. L["The Hinterlands"], nil, tATex, nil, nil},
			{"FlightA", 65.8, 44.9, L["Stormfeather Outpost"] .. ", " .. L["The Hinterlands"], nil, tATex, nil, nil},
			{"FlightH", 81.7, 81.8, L["Revantusk Village"] .. ", " .. L["The Hinterlands"], nil, tHTex, nil, nil},
			{"FlightH", 32.4, 58.1, L["Hiri'watha Research Station"] .. ", " .. L["The Hinterlands"], nil, tHTex, nil, nil},
			{"Arrow", 24.1, 30.4, L["Western Plaguelands"], nil, arTex, nil, nil, nil, nil, nil, 0, 1422},
			{"Arrow", 6.4, 61.5, L["Hillsbrad Foothills"], nil, arTex, nil, nil, nil, nil, nil, 2.3, 1424},
		},
		--[[Dun Morogh]] [1426] = {
			{"FlightA", 75.9, 54.4, L["Gol'Bolar Quarry"] .. ", " .. L["Dun Morogh"], nil, tATex, nil, nil},
			{"FlightA", 53.8, 52.7, L["Kharanos"] .. ", " .. L["Dun Morogh"], nil, tATex, nil, nil},
			{"Dungeon", 31.1, 37.9, L["Gnomeregan"], L["Dungeon"], dnTex},
			{"Arrow", 84.3, 31.1, L["Loch Modan"], L["North Gate Pass"], arTex, nil, nil, nil, nil, nil, 0, 1432},
			{"Arrow", 82.2, 53.5, L["Loch Modan"], L["South Gate Pass"], arTex, nil, nil, nil, nil, nil, 5, 1432},
			{"Arrow", 30.5, 34.5, L["Wetlands"], L["You will die!"], arTex, nil, nil, nil, nil, nil, 6.2, 1437},
			{"Arrow", 53.3, 35.1, L["Ironforge"], nil, arTex, nil, nil, nil, nil, nil, 5.4, 1455},
		},
		--[[Searing Gorge]] [1427] = {
			{"Dunraid", 34.9, 83.9, L["Blackrock Mountain"], L["Blackrock Caverns"] .. "," .. L["Blackrock Depths"] .. "|n" .. L["Blackrock Spire"] .. "," .. L["Blackwing Lair"] .. ", " .. L["Blackwing Descent"] .. "," .. L["Molten Core"], dnTex},
			{"FlightA", 37.9, 30.8, L["Thorium Point"] .. ", " .. L["Searing Gorge"], nil, tATex, nil, nil},
			{"FlightH", 34.8, 30.9, L["Thorium Point"] .. ", " .. L["Searing Gorge"], nil, tHTex, nil, nil},
			{"FlightN", 41.0, 68.6, L["Iron Summit"] .. ", " .. L["Searing Gorge"], nil, tNTex, nil, nil},
			{"Arrow", 78.5, 17.4, L["Loch Modan"], nil, arTex, nil, nil, nil, nil, nil, 5.4, 1432},
			{"Arrow", 33.6, 79.0, L["Burning Steppes"], L["Blackrock Mountain"], arTex, nil, nil, nil, nil, nil, 3, 1428},
			{"Arrow", 68.8, 53.9, L["Badlands"], nil, arTex, nil, nil, nil, nil, nil, 4.5, 1418},
		},
		--[[Burning Steppes]] [1428] = {
			{"Dunraid", 21.0, 37.9, L["Blackrock Mountain"], L["Blackrock Caverns"] .. "," .. L["Blackrock Depths"] .. "|n" .. L["Blackrock Spire"] .. "," .. L["Blackwing Lair"] .. ", " .. L["Blackwing Descent"] .. "," .. L["Molten Core"], dnTex},
			{"FlightA", 72.1, 65.7, L["Morgan's Vigil"] .. ", " .. L["Burning Steppes"], nil, tATex, nil, nil},
			{"FlightH", 54.2, 24.2, L["Flame Crest"] .. ", " .. L["Burning Steppes"], nil, tHTex, nil, nil},
			{"FlightN", 17.6, 52.6, L["Flamestar Post"] .. ", " .. L["Burning Steppes"], nil, tNTex, nil, nil},
			{"FlightN", 46.0, 41.8, L["Chiselgrip"] .. ", " .. L["Burning Steppes"], nil, tNTex, nil, nil},
			{"Arrow", 78.3, 77.8, L["Redridge Mountains"], nil, arTex, nil, nil, nil, nil, nil, 3.3, 1433},
			{"Arrow", 31.9, 50.4, L["Searing Gorge"], L["Blackrock Mountain"], arTex, nil, nil, nil, nil, nil, 0.8, 1427},
		},
		--[[Elwynn Forest]] [1429] = {
			{"Dungeon", 19.1, 36.9, L["The Stockade"], L["Dungeon"], dnTex},
			{"FlightA", 41.8, 64.6, L["Goldshire"] .. ", " .. L["Elwynn Forest"], nil, tATex, nil, nil},
			{"FlightA", 81.8, 66.4, L["Eastvale Logging Camp"] .. ", " .. L["Elwynn Forest"], nil, tATex, nil, nil},
			{"Arrow", 21.0, 79.6, L["Westfall"], nil, arTex, nil, nil, nil, nil, nil, 2.2, 1436},
			{"Arrow", 93.2, 72.3, L["Redridge Mountains"], nil, arTex, nil, nil, nil, nil, nil, 4.7, 1433},
			{"Arrow", 32.2, 49.7, L["Stormwind City"], nil, arTex, nil, nil, nil, nil, nil, 0.6, 1453},
		},
		--[[Deadwind Pass]] [1430] = {
			{"Dungeon", 46.7, 70.2, L["Return to Karazhan"], L["Dungeon"], dnTex},
			{"Raid", 46.9, 74.7, L["Karazhan"], L["Raid"], rdTex, 70, 70, 68, 68, 80},
			{"Arrow", 32.0, 35.3, L["Duskwood"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1431},
			{"Arrow", 58.8, 42.2, L["Swamp of Sorrows"], nil, arTex, nil, nil, nil, nil, nil, 5.2, 1435},
		},
		--[[Duskwood]] [1431] = {
			{"FlightA", 21.0, 56.6, L["Raven Hill"] .. ", " .. L["Duskwood"], nil, tATex, nil, nil},
			{"FlightA", 77.5, 44.3, L["Darkshire"] .. ", " .. L["Duskwood"], nil, tATex, nil, nil},
			{"Arrow", 7.9, 63.8, L["Westfall"], nil, arTex, nil, nil, nil, nil, nil, 1.7, 1436},
			{"Arrow", 44.6, 87.9, L["Stranglethorn Vale"], nil, arTex, nil, nil, nil, nil, nil, 3, 1434},
			{"Arrow", 94.2, 10.3, L["Redridge Mountains"], nil, arTex, nil, nil, nil, nil, nil, 5.8, 1433},
			{"Arrow", 88.4, 40.9, L["Deadwind Pass"], nil, arTex, nil, nil, nil, nil, nil, 4.6, 1430},
		},
		--[[Loch Modan]] [1432] = {
			{"FlightA", 33.9, 51.0, L["Thelsamar"] .. ", " .. L["Loch Modan"], nil, tATex, nil, nil},
			{"FlightA", 81.9, 64.1, L["The Farstrider Lodge"] .. ", " .. L["Loch Modan"], nil, tATex, nil, nil},
			{"Arrow", 18.4, 83.0, L["Searing Gorge"], nil, arTex, nil, nil, nil, nil, nil, 2.6, 1427},
			{"Arrow", 20.4, 17.4, L["Dun Morogh"], L["North Gate Pass"], arTex, nil, nil, nil, nil, nil, 1.1, 1426},
			{"Arrow", 46.8, 76.9, L["Badlands"], nil, arTex, nil, nil, nil, nil, nil, 3.2, 1418},
			{"Arrow", 21.5, 66.2, L["Dun Morogh"], L["South Gate Pass"], arTex, nil, nil, nil, nil, nil, 0.5, 1426},
			{"Arrow", 25.4, 10.9, L["Wetlands"], L["Dun Algaz"], arTex, nil, nil, nil, nil, nil, 0.1, 1437},
		},
		--[[Redridge Mountains]] [1433] = {
			{"FlightA", 29.4, 53.8, L["Lakeshire"] .. ", " .. L["Redridge Mountains"], nil, tATex, nil, nil},
			{"FlightA", 52.8, 54.6, L["Camp Everstill"] .. ", " .. L["Redridge Mountains"], nil, tATex, nil, nil},
			{"FlightA", 78.0, 65.9, L["Shalewind Canyon"] .. ", " .. L["Redridge Mountains"], nil, tATex, nil, nil},
			{"Arrow", 8.5, 88.1, L["Duskwood"], nil, arTex, nil, nil, nil, nil, nil, 2.2, 1431},
			{"Arrow", 3.3, 73.1, L["Elwynn Forest"], nil, arTex, nil, nil, nil, nil, nil, 2.1, 1429},
			{"Arrow", 47.3, 14.3, L["Burning Steppes"], nil, arTex, nil, nil, nil, nil, nil, 5.9, 1428},
		},
		--[[The Cape of Stranglethorn]] [210] = {
			{"FlightA", 41.7, 74.5, L["Booty Bay"] .. ", " .. L["The Cape of Stranglethorn"], nil, tATex, nil, nil},
			{"FlightA", 41.7, 74.5, L["Explorer's League Digsite"] .. ", " .. L["The Cape of Stranglethorn"], nil, tATex, nil, nil},
			{"FlightH", 35.0, 29.2, L["Hardwrench Hideaway"] .. ", " .. L["The Cape of Stranglethorn"], nil, tHTex, nil, nil},
			{"FlightH", 40.6, 73.4, L["Booty Bay"] .. ", " .. L["The Cape of Stranglethorn"], nil, tHTex, nil, nil},
			{"TravelN", 39.0, 67.0, L["Boat to"] .. " " .. L["Ratchet"] .. ", " .. L["The Barrens"], nil, fNTex, nil, nil, nil, nil, nil, 0, 1413},
			{"Arrow", 39.2, 6.5, L["Duskwood"], nil, arTex, nil, nil, nil, nil, nil, 0, 1431},
		},
		--[[Northern Stranglethorn]] [1434] = {
			{"Dungeon", 72.1, 32.9, L["Zul'Gurub"], L["Dungeon"], dnTex},
			{"FlightA", 52.6, 66.1, L["Fort Livingston"] .. ", " .. L["Northern Stranglethorn"], nil, tATex, nil, nil},
			{"FlightA", 47.9, 11.9, L["Rebel Camp"] .. ", " .. L["Northern Stranglethorn"], nil, tATex, nil, nil},
			{"FlightH", 39.0, 51.2, L["Grom'gol Base Camp"] .. ", " .. L["Northern Stranglethorn"], nil, tHTex, nil, nil},
			{"FlightH", 62.4, 39.2, L["Bambala"] .. ", " .. L["Northern Stranglethorn"], nil, tHTex, nil, nil},
			{"TravelH", 31.4, 30.2, L["Zeppelin to"] .. " " .. L["Orgrimmar"] .. ", " .. L["Durotar"], nil, fHTex, nil, nil, nil, nil, nil, 0, 1411},
			{"TravelH", 31.6, 29.1, L["Zeppelin to"] .. " " .. L["Undercity"] .. ", " .. L["Tirisfal Glades"], nil, fHTex, nil, nil, nil, nil, nil, 0, 1420},
		},
		--[[Swamp of Sorrows]] [1435] = {
			{"Dungeon", 69.7, 53.5, L["Temple of Atal'Hakkar"], L["Dungeon"], dnTex},
			{"FlightA", 70.0, 38.6, L["Marshtide Watch"] .. ", " .. L["Swamp of Sorrows"], nil, tATex, nil, nil},
			{"FlightA", 30.8, 34.6, L["The Harborage"] .. ", " .. L["Swamp of Sorrows"], nil, tATex, nil, nil},
			{"FlightN", 72.0, 12.0, L["Bogpaddle"] .. ", " .. L["Swamp of Sorrows"], nil, tNTex, nil, nil},
			{"FlightH", 47.8, 55.2, L["Stonard"] .. ", " .. L["Swamp of Sorrows"], nil, tHTex, nil, nil},
			{"Arrow", 3.7, 61.1, L["Deadwind Pass"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1430},
			{"Arrow", 33.4, 74.8, L["Blasted Lands"], nil, arTex, nil, nil, nil, nil, nil, 3.1, 1419},
		},
		--[[Westfall]] [1436] = {
			{"Dungeon", 42.6, 71.8, L["The Deadmines"], L["Dungeon"], dnTex},
			{"FlightA", 56.6, 49.4, L["Sentinel Hill"] .. ", " .. L["Westfall"], nil, tATex, nil, nil},
			{"FlightA", 49.8, 18.7, L["Fulbrow's Pumpkin Farm"] .. ", " .. L["Westfall"], nil, tATex, nil, nil},
			{"FlightA", 42.1, 63.3, L["Moonbrook"] .. ", " .. L["Westfall"], nil, tATex, nil, nil},
			{"Arrow", 62.0, 17.9, L["Elwynn Forest"], nil, arTex, nil, nil, nil, nil, nil, 5.4, 1429},
			{"Arrow", 67.9, 62.8, L["Duskwood"], nil, arTex, nil, nil, nil, nil, nil, 4.7, 1431},
		},
		--[[Wetlands]] [1437] = {
			{"FlightA", 9.4, 59.6, L["Menethil Harbor"] .. ", " .. L["Wetlands"], nil, tATex, nil, nil},
			{"FlightA", 56.3, 41.9, L["Greenwarden's Grove"] .. ", " .. L["Wetlands"], nil, tATex, nil, nil},
			{"FlightA", 56.9, 71.1, L["Slabchisel's Survey"] .. ", " .. L["Wetlands"], nil, tATex, nil, nil},
			{"FlightA", 38.8, 39.0, L["Whelgar's Retreat"] .. ", " .. L["Wetlands"], nil, tATex, nil, nil},
			{"FlightA", 50.0, 18.4, L["Dun Modr"] .. ", " .. L["Wetlands"], nil, tATex, nil, nil},
			{"TravelA", 6.4, 62.2, L["Boat to"] .. " " .. L["Theramore Isle"] .. ", " .. L["Dustwallow Marsh"], nil, fATex, nil, nil, nil, nil, nil, 0, 1445},
			{"TravelA", 4.6, 56.9, L["Boat to"] .. " " .. L["Valgarde"] .. ", " .. L["Howling Fjord"], nil, fATex, nil, nil, nil, nil, nil, 0, 117},
			{"Arrow", 51.3, 10.3, L["Arathi Highlands"], L["Thandol Span"], arTex, nil, nil, nil, nil, nil, 0, 1417},
			{"Arrow", 56.0, 70.3, L["Loch Modan"], L["Dun Algaz"], arTex, nil, nil, nil, nil, nil, 1.8, 1432},
		},
		--[[Stormwind City]] [1453] = {
			{"Dungeon", 52.4, 70.0, L["The Stockade"], L["Dungeon"], dnTex, 23, 29, 15, 21, 80}, -- sum cap was 29
			{"FlightA", 70.9, 72.5, L["Trade District"] .. ", " .. L["Stormwind"], nil, tATex, nil, nil},
			{"TravelA", 66.6, 34.7, L["Tram to"] .. " " .. L["Tinker Town"] .. ", " .. L["Ironforge"], nil, fATex, nil, nil, nil, nil, nil, 0, 1455},
			{"TravelA", 22.5, 56.1, L["Boat to"] .. " " .. L["Rut'theran Village"] .. ", " .. L["Teldrassil"], nil, fATex, nil, nil, nil, nil, nil, 0, 1439},
			{"TravelA", 18.1, 25.5, L["Boat to"] .. " " .. L["Valiance Keep"] .. ", " .. L["Borean Tundra"], nil, fATex, nil, nil, nil, nil, nil, 0, 114},
			{"TravelA", 49.0, 87.3, L["Blasted Lands"], L["Portal"], pATex, nil, nil, nil, nil, nil, 0, 1419},
			{"TravelA", 74.4, 18.4, L["Eastern Earthshrine"], L["Deepholm"] .. ", " .. L["Hyjal"] .. ", " .. L["Tol Barad"] .. ", " .. L["Twilight Highlands"] .. ", " .. L["Uldum"] .. ", " .. L["Vashj'ir"], L["Portal"], pATex},
			{"Arrow", 74.7, 93.4, L["Elwynn Forest"], nil, arTex, nil, nil, nil, nil, nil, 3.8, 1429},
		},
		--[[Ironforge]] [1455] = {
			{"FlightA", 55.5, 47.8, L["The Great Forge"] .. ", " .. L["Ironforge"], nil, tATex, nil, nil},
			{"TravelA", 73.0, 50.2, L["Tram to"] .. " " .. L["Dwarven District"] .. ", " .. L["Stormwind"], nil, fATex, nil, nil, nil, nil, nil, 0, 1453},
			{"TravelA", 27.3, 7.1, L["Blasted Lands"], L["Portal"], pATex, nil, nil, nil, nil, nil, 0, 1419},
			{"Arrow", 21.9, 77.5, L["Dun Morogh"], nil, arTex, nil, nil, nil, nil, nil, 2.2, 1426},
		},
		--[[Undercity]] [1458] = {
			{"FlightH", 63.3, 48.5, L["Trade Quarter"] .. ", " .. L["Undercity"], nil, tHTex, nil, nil},
			{"TravelH", 54.9, 11.3, L["Silvermoon City"], L["Orb of Translocation"], nil, nil, nil, nil, nil, nil, 0, 1954},
			{"TravelH", 85.3, 17.0, L["Blasted Lands"], L["Portal"], pHTex, nil, nil, nil, nil, nil, 0, 1419},
			{"Arrow", 66.2, 5.2, L["Tirisfal Glades"], nil, arTex, nil, nil, nil, nil, nil, 0, 1420},
			{"Arrow", 46.7, 44.3, L["Sewers"], L["Leads to Tirisfal Glades"], arTex, nil, nil, nil, nil, nil, 1.6},
			{"Arrow", 15.1, 31.9, L["Tirisfal Glades"], nil, arTex, nil, nil, nil, nil, nil, 6.1, 1420},
		},
		--[[Isle of Quel'Danas]] [1957] = {
			{"Dungeon", 61.2, 30.9, L["Magisters' Terrace"], L["Dungeon"], dnTex, 70, 80}, -- sum cap was 70
			{"Raid", 44.3, 45.6, L["Sunwell Plateau"], L["Raid"], rdTex, 70, 70},
			{"FlightA", 48.5, 25.2, L["Sun's Reach Harbor"] .. ", " .. L["Isle of Quel Danas"], nil, tATex, nil, nil},
			{"FlightH", 48.4, 25.1, L["Sun's Reach Harbor"] .. ", " .. L["Isle of Quel Danas"], nil, tHTex, nil, nil},
		},
		--[[Eversong Woods]] [1941] = {
			{"FlightH", 43.9, 70.0, L["Fairbreeze Village"] .. ", " .. L["Eversong Woods"], nil, tHTex, nil, nil},
			{"FlightH", 54.4, 50.7, L["Silvermoon City"] .. ", " .. L["Eversong Woods"], nil, tHTex, nil, nil},
			{"FlightH", 46.2, 46.8, L["Falconwing Square"] .. ", " .. L["Eversong Woods"], nil, tHTex, nil, nil},
			{"Arrow", 48.7, 91.0, L["Ghostlands"], nil, arTex, nil, nil, nil, nil, nil, 3, 1942},
			{"Arrow", 56.7, 49.7, L["Silvermoon City"], nil, arTex, nil, nil, nil, nil, nil, 0.0, 1954},
			{"Arrow", 68.2, 88.1, L["Ghostlands"], L["Zeb'Sora"], arTex, nil, nil, nil, nil, nil, 3.3, 1942},
		},
		--[[Ghostlands]] [1942] = {
			{"FlightH", 45.4, 30.5, L["Tranquillien"] .. ", " .. L["Ghostlands"], nil, tHTex, nil, nil},
			{"FlightN", 74.7, 67.1, L["Zul'Aman"] .. ", " .. L["Ghostlands"], nil, tNTex, nil, nil},
			{"Raid", 82.3, 64.3, L["Zul'Aman"], L["Raid"], rdTex, 70, 70, 68, 70, 80},
			{"Arrow", 47.5, 84.0, L["Eastern Plaguelands"], nil, arTex, nil, nil, nil, nil, nil, 3, 1423},
			{"Arrow", 48.4, 13.2, L["Eversong Woods"], nil, arTex, nil, nil, nil, nil, nil, 0, 1941},
			{"Arrow", 77.7, 6.3, L["Eversong Woods"], nil, arTex, nil, nil, nil, nil, nil, 6.2, 1941},
		},
		--[[Silvermoon City]] [1954] = {
			{"TravelH", 49.5, 14.8, L["Undercity"], L["Orb of Translocation"], nil, nil, nil, nil, nil, nil, 0, 1458},
			{"Arrow", 72.6, 85.9, L["Eversong Woods"], nil, arTex, nil, nil, nil, nil, nil, 3.2, 1941},
		},

		----------------------------------------------------------------------
		--	Kalimdor
		----------------------------------------------------------------------

		--[[Durotar]] [1411] = {
			{"FlightH", 53.1, 43.6, L["Razor Hill"] .. ", " .. L["Durotar"], nil, tHTex, nil, nil},
			{"FlightH", 55.4, 73.3, L["Sen'jin Village"] .. ", " .. L["Durotar"], nil, tHTex, nil, nil},
			{"Arrow", 35.1, 42.4, L["The Barrens"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1413},
			{"Arrow", 45.5, 12.3, L["Orgrimmar"], nil, arTex, nil, nil, nil, nil, nil, 0, 1454},
		},
		--[[Mulgore]] [1412] = {
			{"FlightH", 47.4, 58.6, L["Bloodhoof Village"] .. ", " .. L["Mulgore"], nil, tHTex, nil, nil},
			{"Arrow", 69.0, 60.5, L["The Barrens"], nil, arTex, nil, nil, nil, nil, nil, 4.9, 1413},
			{"Arrow", 37.7, 32.9, L["Thunder Bluff"], L["South"], arTex, nil, nil, nil, nil, nil, 0.9, 1456},
			{"Arrow", 40.5, 20.1, L["Thunder Bluff"], L["North"], arTex, nil, nil, nil, nil, nil, 2.8, 1456},
		},
		--[[Northern Barrens]] [1413] = {
			{"Dungeon", 38.9, 69.1, L["Wailing Caverns"], L["Dungeon"], dnTex},
			{"FlightH", 42.0, 15.8, L["The Mor'shan Rampart"] .. ", " .. L["Northern Barrens"], nil, tHTex, nil, nil},
			{"FlightH", 62.3, 17.1, L["Nozzlepot's Outpost"] .. ", " .. L["Northern Barrens"], nil, tHTex, nil, nil},
			{"FlightH", 48.7, 58.7, L["The Crossroads"] .. ", " .. L["Northern Barrens"], nil, tHTex, nil, nil},
			{"FlightN", 69.1, 70.7, L["Ratchet"] .. ", " .. L["Northern Barrens"], nil, tNTex, nil, nil},
			{"TravelN", 63.7, 38.6, L["Boat to"] .. " " .. L["Booty Bay"] .. ", " .. L["The Cape of Stranglethorn"], nil, fNTex, nil, nil, nil, nil, nil, 0, 1434},
			{"Arrow", 41.2, 58.6, L["Mulgore"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 1412},
			{"Arrow", 49.8, 78.4, L["Dustwallow Marsh"], nil, arTex, nil, nil, nil, nil, nil, 4.7, 1445},
			{"Arrow", 44.1, 91.5, L["Thousand Needles"], L["The Great Lift"], arTex, nil, nil, nil, nil, nil, 3, 1441},
			{"Arrow", 36.3, 27.5, L["Stonetalon Mountains"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1442},
			{"Arrow", 48.8, 7.1, L["Ashenvale"], nil, arTex, nil, nil, nil, nil, nil, 0, 1440},
			{"Arrow", 62.6, 19.2, L["Durotar"], nil, arTex, nil, nil, nil, nil, nil, 4.6, 1411},
			{"Arrow", 63.7, 1.5, L["Ashenvale"], L["Southfury River"], arTex, nil, nil, nil, nil, nil, 6.3, 1440},
		},
		--[[Teldrassil]] [1438] = {
			{"FlightA", 55.4, 88.4, L["Rut'theran Village"] .. ", " .. L["Teldrassil"], nil, tATex, nil, nil},
			{"FlightA", 55.5, 50.4, L["Dolanaar"] .. ", " .. L["Teldrassil"], nil, tATex, nil, nil},
			{"TravelA", 54.9, 96.8, L["Boat to"] .. " " .. L["Stormwind City"] .. ", " .. L["Elwynn Forest"], nil, fATex, nil, nil, nil, nil, nil, 0, 1439},
			{"Arrow", 36.2, 54.4, L["Darnassus"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1457},
			{"Arrow", 56, 89.9, L["Darnassus"], L["Rut'Theran Village"], arTex, nil, nil, nil, nil, nil, 0.2, 1457},
			{"TravelA", 52.3, 89.5, L["Boat to"] .. " " .. L["Valaar's Berth"] .. ", " .. L["Azuremyst Isle"], nil, fATex, nil, nil, nil, nil, nil, 0, 1439},
		},
		--[[Darkshore]] [1439] = {
			{"FlightA", 51.7, 17.7, L["Lor'danel"] .. ", " .. L["Darkshore"], nil, tATex, nil, nil},
			{"FlightA", 44.4, 75.5, L["Grove of the Ancients"] .. ", " .. L["Darkshore"], nil, tATex, nil, nil},
			{"Arrow", 43.3, 94.0, L["Ashenvale"], nil, arTex, nil, nil, nil, nil, nil, 4, 1440},
			{"Arrow", 37.6, 95, L["Ashenvale"], nil, arTex, nil, nil, nil, nil, nil, 3.1, 1440},
			{"Arrow", 27.7, 92.9, L["Ashenvale"], L["The Zoram Strand"], arTex, nil, nil, nil, nil, nil, 2.5, 1440},
		},
		--[[Ashenvale]] [1440] = {
			{"Dungeon", 14.2, 13.9, L["Blackfathom Deeps"], L["Dungeon"], dnTex},
			{"FlightA", 18.1, 20.6, L["Blackfathom Camp"] .. ", " .. L["Ashenvale"], nil, tATex, nil, nil},
			{"FlightA", 34.4, 48.0, L["Astranaar"] .. ", " .. L["Ashenvale"], nil, tATex, nil, nil},
			{"FlightA", 85.1, 43.5, L["Forest Song"] .. ", " .. L["Ashenvale"], nil, tATex, nil, nil},
			{"FlightA", 35.0, 72.1, L["Stardust Spire"] .. ", " .. L["Ashenvale"], nil, tATex, nil, nil},
			{"FlightH", 73.2, 61.6, L["Splintertree Post"] .. ", " .. L["Ashenvale"], nil, tHTex, nil, nil},
			{"FlightH", 11.2, 34.4, L["Zoram'gar Outpost"] .. ", " .. L["Ashenvale"], nil, tHTex, nil, nil},
			{"FlightH", 38.0, 42.2, L["Hellscream's Watch"] .. ", " .. L["Ashenvale"], nil, tHTex, nil, nil},
			{"FlightH", 49.2, 65.2, L["Silverwind Refuge"] .. ", " .. L["Ashenvale"], nil, tHTex, nil, nil},
			{"Arrow", 29.1, 14.8, L["Darkshore"], nil, arTex, nil, nil, nil, nil, nil, 0, 1439},
			{"Arrow", 42.3, 71.1, L["Stonetalon Mountains"], L["The Talondeep Path"], arTex, nil, nil, nil, nil, nil, 2.7, 1442},
			{"Arrow", 55.8, 30.2, L["Felwood"], nil, arTex, nil, nil, nil, nil, nil, 0, 1448},
			{"Arrow", 94.2, 47.3, L["Azshara"], nil, arTex, nil, nil, nil, nil, nil, 4.4, 1447},
			{"Arrow", 68.6, 86.8, L["The Barrens"], nil, arTex, nil, nil, nil, nil, nil, 3.2, 1413},
			{"Arrow", 94.5, 76.3, L["The Barrens"], L["Southfury River"], arTex, nil, nil, nil, nil, nil, 3.6, 1413},
			{"Arrow", 20.5, 16.4, L["Darkshore"], L["Twilight Vale"], arTex, nil, nil, nil, nil, nil, 5.8, 1439},
			{"Arrow", 9.5, 10.7, L["Darkshore"], L["Twilight Shore"], arTex, nil, nil, nil, nil, nil, 5.3, 1439},
		},
		--[[Thousand Needles]] [1441] = {
			{"FlightN", 79.1, 71.9, L["Fizzle & Pozzik's Speedbarge"] .. ", " .. L["Thousand Needles"], nil, tNTex, nil, nil},
			{"FlightH", 11.2, 11.6, L["Westreach Summit"] .. ", " .. L["Thousand Needles"], nil, tHTex, nil, nil},
			{"Dungeon", 41.5, 29.4, L["Razorfen Downs"], L["Dungeon"], dnTex},
			{"Arrow", 74.9, 93.3, L["Tanaris"], nil, arTex, nil, nil, nil, nil, nil, 3.2, 1446},
			{"Arrow", 8.3, 11.9, L["Feralas"], nil, arTex, nil, nil, nil, nil, nil, 0.7, 1444},
			{"Arrow", 32.2, 23.9, L["The Barrens"], L["The Great Lift"], arTex, nil, nil, nil, nil, nil, 5.4, 1413},
		},
		--[[Stonetalon Mountains]] [1442] = {
			{"FlightA", 32.0, 61.8, L["Farwatcher's Glen"] .. ", " .. L["Stonetalon Mountains"], nil, tATex, nil, nil},
			{"FlightA", 40.1, 32.0, L["Thal'darah Overlook"] .. ", " .. L["Stonetalon Mountains"], nil, tATex, nil, nil},
			{"FlightA", 48.6, 51.5, L["Mirkfallon Post"] .. ", " .. L["Stonetalon Mountains"], nil, tATex, nil, nil},
			{"FlightA", 58.8, 54.2, L["Windshear Hold"] .. ", " .. L["Stonetalon Mountains"], nil, tATex, nil, nil},
			{"FlightH", 45.0, 30.8, L["Cliffwalker Post"] .. ", " .. L["Stonetalon Mountains"], nil, tHTex, nil, nil},
			{"FlightH", 53.8, 40.0, L["Sludgewerks"] .. ", " .. L["Stonetalon Mountains"], nil, tHTex, nil, nil},
			{"FlightH", 48.5, 61.9, L["Sun Rock Retreat"] .. ", " .. L["Stonetalon Mountains"], nil, tHTex, nil, nil},
			{"FlightH", 66.4, 62.8, L["Krom'gar Fortress"] .. ", " .. L["Stonetalon Mountains"], nil, tHTex, nil, nil},
			{"FlightH", 70.6, 89.4, L["Malaka'jin"] .. ", " .. L["Stonetalon Mountains"], nil, tHTex, nil, nil},
			{"Arrow", 80.2, 92.4, L["The Barrens"], nil, arTex, nil, nil, nil, nil, nil, 3.4, 1413},
			{"Arrow", 30.4, 75.4, L["Desolace"], nil, arTex, nil, nil, nil, nil, nil, 2.7, 1443},
			{"Arrow", 78.2, 42.8, L["Ashenvale"], L["The Talondeep Path"], arTex, nil, nil, nil, nil, nil, 6.1, 1440},
		},
		--[[Desolace]] [1443] = {
			{"Dungeon", 29.1, 62.6, L["Maraudon"], L["Dungeon"], dnTex},
			{"FlightA", 64.7, 10.5, L["Nijel's Point"] .. ", " .. L["Desolace"], nil, tATex, nil, nil},
			{"FlightA", 36.8, 71.6, L["Thargad's Camp"] .. ", " .. L["Desolace"], nil, tATex, nil, nil},
			{"FlightA", 39.0, 27.0, L["Ethel Rethor"] .. ", " .. L["Desolace"], nil, tATex, nil, nil},
			{"FlightH", 44.2, 29.6, L["Furien's Post"] .. ", " .. L["Desolace"], nil, tHTex, nil, nil},
			{"FlightH", 21.6, 74.1, L["Shadowprey Village"] .. ", " .. L["Desolace"], nil, tHTex, nil, nil},
			{"FlightN", 57.6, 49.6, L["Karnum's Glade"] .. ", " .. L["Desolace"], nil, tNTex, nil, nil},
			{"FlightN", 70.6, 32.8, L["Thunk's Abode"] .. ", " .. L["Desolace"], nil, tNTex, nil, nil},
			{"Arrow", 53.4, 5.9, L["Stonetalon Mountains"], nil, arTex, nil, nil, nil, nil, nil, 5.9, 1442},
			{"Arrow", 41.6, 94.4, L["Feralas"], nil, arTex, nil, nil, nil, nil, nil, 3.3, 1444},
		},
		--[[Feralas]] [1444] = {
			{"FlightA", 77.3, 56.8, L["Shadebough"] .. ", " .. L["Feralas"], nil, tATex, nil, nil},
			{"FlightA", 57.1, 54.0, L["Tower of Estulan"] .. ", " .. L["Feralas"], nil, tATex, nil, nil},
			{"FlightA", 50.2, 16.7, L["Dreamer's Rest"] .. ", " .. L["Feralas"], nil, tATex, nil, nil},
			{"FlightA", 46.8, 45.3, L["Feathermoon Stronghold"] .. ", " .. L["Feralas"], nil, tATex, nil, nil},
			{"FlightH", 75.4, 44.4, L["Camp Mojache"] .. ", " .. L["Feralas"], nil, tHTex, nil, nil},
			{"FlightH", 51.0, 48.4, L["Stonemaul Hold"] .. ", " .. L["Feralas"], nil, tHTex, nil, nil},
			{"FlightH", 41.5, 15.4, L["Camp Ataya"] .. ", " .. L["Feralas"], nil, tHTex, nil, nil},
			{"Dungeon", 60.3, 31.3, L["Dire Maul (West): Capital Gardens"], L["Dungeon"], dnTex},
			{"Dungeon", 64.8, 30.2, L["Dire Maul (East): Warpwood Quarter"], L["Dungeon"], dnTex},
			{"Dungeon", 62.5, 24.9, L["Dire Maul (North): Gordok Commons"], L["Dungeon"], dnTex},
			--{"Dungeon", 77.1, 36.9, L["Dire Maul (East) (side entrance)"], L["Dungeon (requires Crescent Key)"], dnTex, 55, 58, 45, 54, 80}, -- sum cap was 61
			{"TravelA", 43.3, 42.8, L["Boat to"] .. " " .. L["Feathermoon Stronghold"] .. ", " .. L["Feralas"], nil, fATex, nil, nil, nil, nil, nil, 0, 1444},
			{"TravelA", 31.0, 39.8, L["Boat to"] .. " " .. L["The Forgotten Coast"] .. ", " .. L["Feralas"], nil, fATex, nil, nil, nil, nil, nil, 0, 1444},
			{"Arrow", 44.9, 7.7, L["Desolace"], nil, arTex, nil, nil, nil, nil, nil, 6, 1443},
			{"Arrow", 88.7, 41.1, L["Thousand Needles"], nil, arTex, nil, nil, nil, nil, nil, 4.5, 1441},
		},
		--[[Dustwallow Marsh]] [1445] = {
			{"Raid", 52.6, 76.8, L["Onyxia's Lair"], L["Raid"], rdTex, 60, 60, 50, 60, 80},
			{"FlightA", 67.5, 51.3, L["Theramore Isle"] .. ", " .. L["Dustwallow Marsh"], nil, tATex, nil, nil},
			{"FlightH", 35.6, 31.9, L["Brackenwall Village"] .. ", " .. L["Dustwallow Marsh"], nil, tHTex, nil, nil},
			{"FlightN", 42.8, 72.4, L["Mudsprocket"] .. ", " .. L["Dustwallow Marsh"], nil, tNTex, nil, nil},
			{"TravelA", 71.6, 56.4, L["Boat to"] .. " " .. L["Menethil Harbor"] .. ", " .. L["Wetlands"], nil, fATex, nil, nil, nil, nil, nil, 0, 1437},
			{"Arrow", 30.0, 47.1, L["The Barrens"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 1413},
		},
		--[[Tanaris]] [1446] = {
			{"Dungeon", 39.2, 21.3, L["Zul'Farrak"], L["Dungeon"], dnTex, 42, 46, 35, 42, 80}, -- sum cap was 50
			{"Dunraid", 64.8, 50.0, L["Caverns of Time"], L["Culling of Stratholme"] .. ", " .. L["Black Morass"]  .. ",|n" .. L["Hyjal Summit"] .. "," .. L["Old Hillsbrad"]  .. "," .. L["Well of Eternity"]  .. "|n|n" .. dnTex, 66, 68, nil, nil, 80},
			{"FlightA", 51.4, 29.5, L["Gadgetzan"] .. ", " .. L["Tanaris"], nil, tATex, nil, nil},
			{"FlightA", 40.0, 77.5, L["Gunstan's Dig"] .. ", " .. L["Tanaris"], nil, tATex, nil, nil},
			{"FlightH", 52.0, 27.6, L["Gadgetzan"] .. ", " .. L["Tanaris"], nil, tHTex, nil, nil},
			{"FlightH", 33.3, 77.4, L["Dawnrise Expedition"] .. ", " .. L["Tanaris"], nil, tHTex, nil, nil},
			{"FlightN", 55.8, 60.6, L["Bootlegger Outpost"] .. ", " .. L["Tanaris"], nil, tNTex, nil, nil},
			{"Arrow", 50.6, 24.4, L["Thousand Needles"], nil, arTex, nil, nil, nil, nil, nil, 5.7, 1441},
			{"Arrow", 28.2, 57.6, L["Un'Goro Crater"], nil, arTex, nil, nil, nil, nil, nil, 0.5, 1449},
		},
		--[[Azshara]] [1447] = {
			{"FlightH", 66.5, 21.0, L["Northern Rocketway"] .. ", " .. L["Azshara"], nil, tHTex, nil, nil},
			{"FlightH", 51.5, 74.3, L["Southern Rocketway"] .. ", " .. L["Azshara"], nil, tHTex, nil, nil},
			{"FlightH", 52.9, 49.9, L["Bilgewater Harbor"] .. ", " .. L["Azshara"], nil, tHTex, nil, nil},
			{"FlightH", 14.2, 65.0, L["Valormok"] .. ", " .. L["Azshara"], nil, tHTex, nil, nil},
			{"Arrow", 10.6, 75.3, L["Ashenvale"], nil, arTex, nil, nil, nil, nil, nil, 0.9, 1440},
		},
		--[[Felwood]] [1448] = {
			{"FlightA", 60.5, 25.3, L["Talonbranch Glade"] .. ", " .. L["Felwood"], nil, tATex, nil, nil},
			{"FlightH", 56.4, 8.6, L["Irontree Clearing"] .. ", " .. L["Felwood"], nil, tHTex, nil, nil},
			{"FlightN", 43.6, 28.7, L["Whisperwind Grove"] .. ", " .. L["Felwood"], nil, tNTex, nil, nil},
			{"FlightN", 44.3, 61.9, L["Wildheart Point"] .. ", " .. L["Felwood"], nil, tNTex, nil, nil},
			{"FlightN", 51.5, 80.9, L["Emerald Sanctuary"] .. ", " .. L["Felwood"], nil, tNTex, nil, nil},
			{"Arrow", 65.0, 8.3, L["Winterspring"] .. ", " .. L["Moonglade"], L["Timbermaw Hold"], arTex, nil, nil, nil, nil, nil, 5.9, 1452},
			{"Arrow", 54.5, 89.2, L["Ashenvale"], nil, arTex, nil, nil, nil, nil, nil, 3, 1440},
		},
		--[[Un'Goro Crater]] [1449] = {
			{"FlightN", 56.0, 64.2, L["Marshal's Stand"] .. ", " .. L["Un'Goro Crater"], nil, tNTex, nil, nil},
			{"FlightN", 44.1, 40.3, L["Mossy Pile"] .. ", " .. L["Un'Goro Crater"], nil, tNTex, nil, nil},
			{"Arrow", 70.5, 78.6, L["Tanaris"], nil, arTex, nil, nil, nil, nil, nil, 3.3, 1446},
			{"Arrow", 29.4, 22.3, L["Silithus"], nil, arTex, nil, nil, nil, nil, nil, 0.9, 1451},
		},
		--[[Moonglade]] [1450] =  {
			{"FlightA", 48.1, 67.3, L["Lake Elune'ara"] .. ", " .. L["Moonglade"], nil, tATex, nil, nil},
			{"FlightH", 32.1, 66.6, L["Moonglade"], nil, tHTex, nil, nil},
			{"Arrow", 35.7, 72.4, L["Felwood"] .. ", " .. L["Winterspring"], L["Timbermaw Hold"], arTex, nil, nil, nil, nil, nil, 3, 1448},
		},
		--[[Silithus]] [1451] = {
			{"Raid", 28.6, 92.4, L["Ahn'Qiraj"], L["Ruins of Ahn'Qiraj"] .. ", " .. L["Temple of Ahn'Qiraj"], rdTex, 60, 60, 50, 60, 80},
			{"FlightA", 54.4, 32.7, L["Cenarion Hold"] .. ", " .. L["Silithus"], nil, tATex, nil, nil},
			{"FlightH", 52.8, 34.6, L["Cenarion Hold"] .. ", " .. L["Silithus"], nil, tHTex, nil, nil},
			{"Arrow", 82.4, 16.0, L["Un'Goro Crater"], nil, arTex, nil, nil, nil, nil, nil, 5.4, 1449},
		},
		--[[Winterspring]] [1452] = {
			{"FlightA", 61.0, 48.6, L["Everlook"] .. ", " .. L["Winterspring"], nil, tATex, nil, nil},
			{"FlightH", 58.8, 48.3, L["Everlook"] .. ", " .. L["Winterspring"], nil, tHTex, nil, nil},
			{"Arrow", 27.9, 34.5, L["Felwood"] .. ", " .. L["Moonglade"], L["Timbermaw Hold"], arTex, nil, nil, nil, nil, nil, 0.7, 1448},
		},
		--[[Orgrimmar]] [1454] = {
			{"Dungeon", 55.2, 51.2, L["Ragefire Chasm"], L["Dungeon"], dnTex},
			{"FlightH", 49.6, 59.2, L["Valley of Strength"] .. ", " .. L["Orgrimmar"], nil, tHTex, nil, nil},
			{"Arrow", 52.4, 83.7, L["Durotar"], nil, arTex, nil, nil, nil, nil, nil, 3, 1411},
			{"Arrow", 18.1, 60.6, L["The Barrens"], L["Southfury River"], arTex, nil, nil, nil, nil, nil, 2.1, 1413},
			{"TravelH", 50.1, 37.8, L["Western Earthshrine"], L["Deepholm"] .. ", " .. L["Hyjal"] .. ", " .. L["Twilight Highlands"] .. ", " .. L["Uldum"] .. ", " .. L["Vashj'ir"], nil, pHTex},
			{"TravelH", 47.4, 39.3, L["Tol Barad"], L["Portal"], nil, pHTex},
			{"TravelH", 43.0, 65.0, L["Zeppelin to"] .." " .. L["Thunder Bluff"] .. ", " .. L["Mulgore"], nil, pHTex},
			{"TravelH", 44.8, 62.5, L["Zeppelin to"] .. " " .. L["Borean Tundra"] .. ", " .. L["Northrend"], nil, pHTex},
			{"TravelH", 51.0, 55.8, L["Zeppelin to"] .. " " .. L["Undercity"] .. ", " .. L["Tirisfal Glades"], nil, pHTex},
			{"TravelH", 52.3, 53.1, L["Zeppelin to"] .. " " .. L["Grom'gol"] .. ", " .. L["Stranglethorn Vale"], nil, pHTex},

		},
		--[[Orgrimmar: The Drag]] [86] = {
			{"Dungeon", 70.0, 49.2, L["Ragefire Chasm"], L["Dungeon"], dnTex},
			{"TravelH", 44.8, 67.6, L["Blasted Lands"] .. " " .. L["Portal"], nil, pHTex},
		},
		--[[Thunder Bluff]] [1456] = {
			{"FlightH", 47.0, 49.6, L["Central Mesa"] .. ", " .. L["Thunder Bluff"], nil, tHTex, nil, nil},
			{"TravelH", 23.2, 13.5, L["Blasted Lands"], L["Portal"], pHTex, nil, nil, nil, nil, nil, 0, 1419},
			{"TravelH", 14.6, 26.4, L["Zeppelin to"] .. " " .. L["Orgrimmar"] .. ", " .. L["Durotar"], nil, fHTex, nil, nil, nil, nil, nil, 0, 1411},
			{"Arrow", 51.3, 31.3, L["Mulgore"], "North", arTex, nil, nil, nil, nil, nil, 5.7, 1412},
			{"Arrow", 35.7, 62.8, L["Mulgore"], "South", arTex, nil, nil, nil, nil, nil, 2.0, 1412},
		},
		--[[Darnassus]] [1457] = {
			{"FlightA", 36.6, 47.8, L["Darnassus"] .. ", " .. L["Teldrassil"], nil, tATex, nil, nil},
			{"TravelA", 40.5, 81.7, L["Blasted Lands"], L["Portal"], pATex, nil, nil, nil, nil, nil, 0, 1419},
			{"Arrow", 30.3, 41.4, L["Teldrassil"], L["Rut'Theran Village"], arTex, nil, nil, nil, nil, nil, 1.5, 1438},
			{"Arrow", 84.8, 37.8, L["Teldrassil"], nil, arTex, nil, nil, nil, nil, nil, 5.5, 1438},
		},
		--[[The Exodar]] [1947] = {
			{"FlightA", 54.5, 36.3, L["The Exodar"] .. ", " .. L["Azuremyst Isle"], nil, tATex, nil, nil},
			{"TravelA", 48.3, 62.9, L["Stormwind"], L["Portal"], pATex},
			{"Arrow", 76.0, 55.5, L["Azuremyst Isle"], L["Seat of the Naaru"], arTex, nil, nil, nil, nil, nil, 4.5, 1943},
			{"Arrow", 35.0, 74.8, L["Azuremyst Isle"], L["The Vault of Lights"], arTex, nil, nil, nil, nil, nil, 0.9, 1943},
		},
		--[[Azuremyst Isle]] [1943] = {
			{"FlightA", 49.7, 49.1, L["Azure Watch"] .. ", " .. L["Azuremyst Isle"], nil, tATex, nil, nil},
			{"TravelA", 20.3, 54.2, L["Boat to"] .. " " .. L["Rut'theran Village"] .. ", " .. L["Teldrassil"], nil, fATex, nil, nil, nil, nil, nil, 0, 1439},
			{"Arrow", 36.9, 47.0, L["The Exodar"], L["Seat of the Naaru"], arTex, nil, nil, nil, nil, nil, 1.5, 1947},
			{"Arrow", 24.7, 49.4, L["The Exodar"], L["The Vault of Lights"], arTex, nil, nil, nil, nil, nil, 5.8, 1947},
			{"Arrow", 42.5, 5.4, L["Bloodmyst Isle"], nil, arTex, nil, nil, nil, nil, nil, 0.2, 1950},
		},
		--[[Bloodmyst Isle]] [1950] = {
			{"FlightA", 57.7, 53.9, L["Blood Watch"] .. ", " .. L["Bloodmyst Isle"], nil, tATex, nil, nil},
			{"Arrow", 65.4, 92.6, L["Azuremyst Isle"], nil, arTex, nil, nil, nil, nil, nil, 3, 1943},
		},

		----------------------------------------------------------------------
		--	Outland
		----------------------------------------------------------------------

		--[[Blade's Edge Mountains]] [1949] = {
			{"FlightA", 37.8, 61.4, L["Sylvanaar"] .. ", " .. L["Blade's Edge Mountains"], nil, tATex, nil, nil},
			{"FlightA", 61.0, 70.4, L["Toshley's Station"] .. ", " .. L["Blade's Edge Mountains"], nil, tATex, nil, nil},
			{"FlightH", 52.0, 54.2, L["Thunderlord Stronghold"] .. ", " .. L["Blade's Edge Mountains"], nil, tHTex, nil, nil},
			{"FlightH", 76.4, 65.8, L["Mok'Nathal Village"] .. ", " .. L["Blade's Edge Mountains"], nil, tHTex, nil, nil},
			{"FlightN", 61.6, 39.6, L["Evergrove"] .. ", " .. L["Blade's Edge Mountains"], nil, tNTex, nil, nil},
			{"Raid", 68.7, 24.3, L["Gruul's Lair"], L["Raid"], rdTex, 70, 70, 65, 70, 80},
			{"Arrow", 37.3, 80.5, L["Zangarmarsh"], L["Blade Tooth Canyon"], arTex, nil, nil, nil, nil, nil, 3, 1946},
			{"Arrow", 51.7, 74.7, L["Zangarmarsh"], L["Blades' Run"], arTex, nil, nil, nil, nil, nil, 3, 1946},
			{"Arrow", 82.4, 28.7, L["Netherstorm"], nil, arTex, nil, nil, nil, nil, nil, 4.7, 1953},
		},
		--[[Hellfire Peninsula]] [1944] = {
			{"FlightA", 25.2, 37.2, L["Temple of Telhamat"] .. ", " .. L["Hellfire Peninsula"], nil, tATex, nil, nil},
			{"FlightA", 54.6, 62.4, L["Honor Hold"] .. ", " .. L["Hellfire Peninsula"], nil, tATex, nil, nil},
			{"FlightA", 87.4, 52.4, L["The Dark Portal"] .. ", " .. L["Hellfire Peninsula"], nil, tATex, nil, nil},
			{"FlightH", 56.2, 36.2, L["Thrallmar"] .. ", " .. L["Hellfire Peninsula"], nil, tHTex, nil, nil},
			{"FlightH", 27.8, 60.0, L["Falcon Watch"] .. ", " .. L["Hellfire Peninsula"], nil, tHTex, nil, nil},
			{"FlightH", 87.4, 48.2, L["The Dark Portal"] .. ", " .. L["Hellfire Peninsula"], nil, tHTex, nil, nil},
			{"FlightH", 61.6, 81.2, L["Spinebreaker Ridge"] .. ", " .. L["Hellfire Peninsula"], nil, tHTex, nil, nil},
			{"Raid", 46.6, 52.8, L["Magtheridon's Lair"], L["Raid"], rdTex, 70, 70, 65, 70, 80},
			{"Dungeon", 47.7, 53.6, L["Hellfire Ramparts"], L["Dungeon"], dnTex, 60, 62, 55, 58, 80},
			{"Dungeon", 47.7, 52.0, L["The Shattered Halls"], L["Dungeon"], dnTex, 69, 70, 55, 58, 80},
			{"Dungeon", 46.0, 51.8, L["The Blood Furnace"], L["Dungeon"], dnTex, 61, 63, 55, 58, 80},
			{"FlightA", 78.4, 34.9, L["Shatter Point"] .. ", " .. L["Hellfire Peninsula"], nil, tATex, nil, nil},
			{"Arrow", 40.3, 85.9, L["Terokkar Forest"], L["Razorthorn Trail"], arTex, nil, nil, nil, nil, nil, 2.7, 1952},
			{"Arrow", 6.7, 50.4, L["Zangarmarsh"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 1946},
			{"TravelA", 88.6, 52.8, L["Stormwind City"], L["Portal"], pATex, nil, nil, nil, nil, nil, 0, 1453},
			{"TravelH", 88.6, 47.7, L["Orgrimmar"], L["Portal"], pHTex, nil, nil, nil, nil, nil, 0, 1454},
			{"Arrow", 89.8, 50.2, L["Blasted Lands"], L["The Dark Portal"], arTex, nil, nil, nil, nil, nil, 4.7, 1419},
			{"PortalH", 88.6, 47.7, L["Orgrimmar"], L["Portal"]},
			{"PortalA", 88.6, 52.8, L["Stormwind"], L["Portal"]},
		},
		--[[Nagrand]] [1951] = {
			{"FlightA", 54.2, 75.0, L["Telaar"] .. ", " .. L["Nagrand"], nil, tATex, nil, nil},
			{"FlightH", 57.2, 35.2, L["Garadar"] .. ", " .. L["Nagrand"], nil, tHTex, nil, nil},
			{"Arrow", 33.5, 17.8, L["Zangarmarsh"], nil, arTex, nil, nil, nil, nil, nil, 0, 1946},
			{"Arrow", 77.5, 77.0, L["Terokkar Forest"], nil, arTex, nil, nil, nil, nil, nil, 3.7, 1952},
			{"Arrow", 72.3, 36.6, L["Zangarmarsh"], nil, arTex, nil, nil, nil, nil, nil, 5.4, 1946},
			{"Arrow", 77.5, 55.7, L["Shattrath City"], L["Aldor"], arTex, nil, nil, nil, nil, nil, 5.4, 1955},
		},
		--[[Netherstorm]] [1953] = {
			{"FlightN", 33.8, 64.0, L["Area 52"] .. ", " .. L["Netherstorm"], nil, tNTex, nil, nil},
			{"FlightN", 45.2, 34.8, L["The Stormspire"] .. ", " .. L["Netherstorm"], nil, tNTex, nil, nil},
			{"FlightN", 65.2, 66.6, L["Cosmowrench"] .. ", " .. L["Netherstorm"], nil, tNTex, nil, nil},
			{"Raid", 73.7, 63.7, L["The Eye"], L["Raid"], rdTex, 70, 70, nil, 69, 80},
			{"Dungeon", 71.7, 55.0, L["The Botanica"], L["Dungeon"], dnTex, 70, 70, 68, 69, 80},
			{"Dungeon", 74.4, 57.7, L["The Arcatraz"], L["Dungeon"], dnTex, 70, 70, 68, 69, 80},
			{"Dungeon", 70.6, 69.7, L["The Mechanar"], L["Dungeon"], dnTex, 70, 70, 68, 69, 80},
			{"Arrow", 22.7, 55.6, L["Blade's Edge Mountains"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1949},
		},
		--[[Shadowmoon Valley]] [1948] = {
			{"FlightA", 37.6, 55.4, L["Wildhammer Stronghold"] .. ", " .. L["Shadowmoon Valley"], nil, tATex, nil, nil},
			{"FlightH", 30.2, 29.2, L["Shadowmoon Village"] .. ", " .. L["Shadowmoon Valley"], nil, tHTex, nil, nil},
			{"FlightN", 63.4, 30.4, L["Altar of Sha'tar"] .. ", " .. L["Shadowmoon Valley"], nil, tNTex, nil, nil},
			{"FlightN", 56.2, 57.8, L["Sanctum of the Stars"] .. ", " .. L["Shadowmoon Valley"], nil, tNTex, nil, nil},
			{"Raid", 71.0, 46.4, L["Black Temple"], L["Raid"], rdTex, 70, 70, 70, 70, 80},
			{"Arrow", 22.7, 28.6, L["Terokkar Forest"], nil, arTex, nil, nil, nil, nil, nil, 0.8, 1952},
		},
		--[[Shattrath City]] [1955] = {
			{"FlightN", 64.1, 41.1, L["Shattrath City"] .. ", " .. L["Terokkar Forest"], nil, tNTex, nil, nil},
			{"TravelN", 48.5, 42.0, L["Isle of Quel'Danas"], L["Portal"], pNTex, nil, nil, nil, nil, nil, 0, 1957},
			{"TravelA", 55.8, 36.5, L["Alliance Cities"], L["Darnassus"] .. ", " .. L["Stormwind"] .. ", " .. L["Ironforge"], pATex},
			{"TravelH", 52.2, 52.9, L["Horde Cities"], L["Thunder Bluff"] .. ", " .. L["Orgrimmar"] .. ", " .. L["Undercity"], pHTex},
			{"TravelA", 59.6, 46.7, L["The Exodar"], L["Portal"], pATex, nil, nil, nil, nil, nil, 0, 1947},
			{"TravelH", 59.2, 48.4, L["Silvermoon City"], L["Portal"], pHTex, nil, nil, nil, nil, nil, 0, 1954},
			{"Arrow", 62.3, 7.9, L["Terokkar Forest"], nil, arTex, nil, nil, nil, nil, nil, 6.1, 1952},
			{"Arrow", 79.0, 57.5, L["Terokkar Forest"], nil, arTex, nil, nil, nil, nil, nil, 4, 1952},
			{"Arrow", 23.0, 49.5, L["Nagrand"], L["Aldor"], arTex, nil, nil, nil, nil, nil, 1.9, 1951},
			{"Arrow", 68.3, 65.1, L["Terokkar Forest"], nil, arTex, nil, nil, nil, nil, nil, 3.9, 1952},
			{"Arrow", 71.1, 21.9, L["Terokkar Forest"], nil, arTex, nil, nil, nil, nil, nil, 5.8, 1952},
			{"Arrow", 76.3, 43.2, L["Terokkar Forest"], nil, arTex, nil, nil, nil, nil, nil, 4.7, 1952},
		},
		--[[Terokkar Forest]] [1952] = {
			{"FlightA", 59.4, 55.4, L["Allerian Stronghold"] .. ", " .. L["Terokkar Forest"], nil, tATex, nil, nil},
			{"FlightH", 49.2, 43.4, L["Stonebreaker Hold"] .. ", " .. L["Terokkar Forest"], nil, tHTex, nil, nil},
			{"FlightN", 33.1, 23.1, L["Shattrath City"] .. ", " .. L["Terokkar Forest"], nil, tNTex, nil, nil},
			{"Dungeon", 43.2, 65.6, L["Sethekk Halls"], L["Dungeon"], dnTex, 67, 69, 55, 63, 80},
			{"Dungeon", 36.1, 65.6, L["Auchenai Crypts"], L["Dungeon"], dnTex, 65, 67, 55, 63, 80},
			{"Dungeon", 39.6, 71.0, L["Shadow Labyrinth"], L["Dungeon"], dnTex, 69, 70, 65, 63, 80},
			{"Dungeon", 39.7, 60.2, L["Mana-Tombs"], L["Dungeon"], dnTex, 64, 66, 55, 63, 80},
			{"Arrow", 70.6, 49.4, L["Shadowmoon Valley"], nil, arTex, nil, nil, nil, nil, nil, 3.9, 1948},
			{"Arrow", 58.3, 19.3, L["Hellfire Peninsula"], L["Razorthorn Trail"], arTex, nil, nil, nil, nil, nil, 5.0, 1944},
			{"Arrow", 20.3, 56.3, L["Nagrand"], nil, arTex, nil, nil, nil, nil, nil, 0.3, 1951},
			{"Arrow", 33.1, 6.2, L["Zangarmarsh"], nil, arTex, nil, nil, nil, nil, nil, 0.6, 1946},
			{"Arrow", 34.8, 13.4, L["Shattrath City"], nil, arTex, nil, nil, nil, nil, nil, 2.4, 1955},
			{"Arrow", 38.2, 26.6, L["Shattrath City"], nil, arTex, nil, nil, nil, nil, nil, 1.4, 1955},
		},
		--[[Zangarmarsh]] [1946] = {
			{"FlightA", 41.2, 28.8, L["Orebor Harborage"] .. ", " .. L["Zangarmarsh"], nil, tATex, nil, nil},
			{"FlightA", 67.8, 51.4, L["Telredor"] .. ", " .. L["Zangarmarsh"], nil, tATex, nil, nil},
			{"FlightH", 33.0, 51.0, L["Zabra'jin"] .. ", " .. L["Zangarmarsh"], nil, tHTex, nil, nil},
			{"FlightH", 84.8, 55.0, L["Swamprat Post"] .. ", " .. L["Zangarmarsh"], nil, tHTex, nil, nil},
			{"Dunraid", 50.4, 40.9, L["Coilfang Reservoir"], L["Serpentshrine Cavern"]  .. " (" .. L["req"] .. ": 70)" .. ", " .. L["Slave Pens"]  .. " (" .. L["req"] .. ": 59)" .. ",|n" .. L["Steamvault"]  .. " (" .. L["req"] .. ": 65)" .. ", " .. L["Underbog"]  .. " (" .. L["req"] .. ": 60)", dnTex, 62, 70, nil, 61, 80},
			{"Arrow", 81.2, 64.4, L["Hellfire Peninsula"], nil, arTex, nil, nil, nil, nil, nil, 5.4, 1944},
			{"Arrow", 82.0, 90.8, L["Terokkar Forest"], nil, arTex, nil, nil, nil, nil, nil, 3.3, 1952},
			{"Arrow", 69.6, 35.3, L["Blade's Edge Mountains"], L["Blades' Run"], arTex, nil, nil, nil, nil, nil, 5.4, 1949},
			{"Arrow", 40.8, 31.0, L["Blade's Edge Mountains"], L["Blade Tooth Canyon"], arTex, nil, nil, nil, nil, nil, 5.4, 1949},
			{"Arrow", 21.1, 70.5, L["Nagrand"], nil, arTex, nil, nil, nil, nil, nil, 3.1, 1951},
			{"Arrow", 67.9, 86.9, L["Nagrand"], nil, arTex, nil, nil, nil, nil, nil, 2.6, 1951},
		},

		----------------------------------------------------------------------
		--	Northrend (https://www.warcrafttavern.com/wotlk/guides/dungeons/)
		----------------------------------------------------------------------

		--[[Borean Tundra]] [114] = {
			{"FlightA", 56.6, 20.1, L["Fizzcrank Airstrip"] .. ", " .. L["Borean Tundra"], nil, tATex, nil, nil}, -- Kara Thricestar
			{"FlightA", 58.7, 68.3, L["Valiance Keep"] .. ", " .. L["Borean Tundra"], nil, tATex, nil, nil}, -- Tomas Riverwell
			{"FlightH", 49.6, 11.0, L["Bor'gorok Outpost"] .. ", " .. L["Borean Tundra"], nil, tHTex, nil, nil}, -- Kimbiza
			{"FlightH", 77.8, 37.8, L["Taunka'le Village"] .. ", " .. L["Borean Tundra"], nil, tHTex, nil, nil}, -- Omu Spiritbreeze
			{"FlightH", 40.4, 51.4, L["Warsong Hold"] .. ", " .. L["Borean Tundra"], nil, tHTex, nil, nil}, -- Turida Coldwind
			{"FlightN", 33.1, 34.4, L["Transitus Shield"] .. ", " .. L["Coldarra"], nil, tNTex, nil, nil}, -- Warmage Adami
			{"FlightN", 45.3, 34.5, L["Amber Lodge"] .. ", " .. L["Borean Tundra"], nil, tNTex, nil, nil}, -- Surristrasz
			{"FlightN", 78.5, 51.5, L["Unu'pe"] .. ", " .. L["Borean Tundra"], nil, tNTex, nil, nil}, -- Bilko Driftspark
			{"Dunraid", 27.6, 26.6, L["The Nexus"],
				L["The Nexus"]  .. " (69-73) (" .. L["req"] .. ": 67)" .. " (" .. L["sum"] .. ": 70-80)" .. "|n" ..
				L["The Oculus"]  .. " (79-80) " .. L["req"] .. ": 75)" .. " (" .. L["sum"] .. ": 70-80)" .. "|n" ..
				L["The Eye of Eternity"] .. " (80) (" .. L["req"] .. ": 80) " .. " (" .. L["sum"] .. ": 70-80)",
				dnTex, 69, 80},
			{"Arrow", 52.5, 7.6, L["Sholazar Basin"], nil, arTex, nil, nil, nil, nil, nil, 6.1, 119},
			{"Arrow", 93.4, 35.7, L["Dragonblight"], nil, arTex, nil, nil, nil, nil, nil, 4.9, 115},
			{"TravelN", 78.9, 53.7, L["Boat to"] .. " " .. L["Moa'ki Harbor"] .. ", " .. L["Dragonblight"], nil, fNTex, nil, nil, nil, nil, nil, 0, 115},
			{"TravelA", 59.7, 69.4, L["Boat to"] .. " " .. L["Stormwind"] .. ", " .. L["Elwynn Forest"], nil, fATex, nil, nil, nil, nil, nil, 0, 1453},
			{"TravelH", 41.4, 53.6, L["Zeppelin to"] .. " " .. L["Orgrimmar"] .. ", " .. L["Durotar"], nil, fHTex, nil, nil, nil, nil, nil, 0, 1411},
		},

		--[[Crystalsong Forest]] [127] = {
			{"FlightA", 72.2, 81.0, L["Windrunner's Overlook"] .. ", " .. L["Crystalsong Forest"], nil, tATex, nil, nil}, -- Galendror Whitewing
			{"FlightH", 78.5, 50.4, L["Sunreaver's Command"] .. ", " .. L["Crystalsong Forest"], nil, tHTex, nil, nil}, -- Skymaster Baeric
			{"Arrow", 47.1, 68.4, L["Dragonblight"], nil, arTex, nil, nil, nil, nil, nil, 2.7, 115},
			{"Arrow", 58.7, 33.7, L["Icecrown"], nil, arTex, nil, nil, nil, nil, nil, 6.2, 118},
			{"Arrow", 70.4, 35.7, L["The Storm Peaks"], nil, arTex, nil, nil, nil, nil, nil, 5.9, 120},
			{"Arrow", 93.2, 58.4, L["Zul'Drak"], nil, arTex, nil, nil, nil, nil, nil, 4.6, 121},
			{"Arrow", 85.7, 44.7, L["The Storm Peaks"], nil, arTex, nil, nil, nil, nil, nil, 0.3, 120},
			{"TravelN", 15.7, 42.5, L["Dalaran"], L["Teleport Crystal"], pNTex, nil, nil, nil, nil, nil, 0, 125},
			{"Arrow", 36.4, 37.6, L["Dalaran"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 125},
		},

		--[[Dalaran]] [125] = {
			{"FlightN", 72.2, 45.8, L["Dalaran"], nil, tNTex, nil, nil}, -- Aludane Whitecloud
			{"Dungeon", 66.8, 68.2, L["The Violet Hold"], L["Dungeon"], dnTex, 75, 77, 73, nil, nil, 0, 168},
			{"TravelA", 37.8, 62.2, L["Portals"], L["Stormwind"] .. ", " .. L["Ironforge"] .. ", " .. L["Darnassus"] .. ", " .. L["Exodar"] .. ", " .. L["Shattrath"], pATex},
			{"TravelH", 57.8, 24.5, L["Portals"], L["Orgrimmar"] .. ", " .. L["Undercity"] .. ", " .. L["Shattrath"] .. ", " .. L["Thunder Bluff"] .. ", " .. L["Silvermoon"], pHTex},
			{"TravelN", 56.0, 46.8, L["Crystalsong Forest"], L["Teleport Crystal"], pNTex, nil, nil, nil, nil, nil, 0, 127},
			{"Arrow", 80.9, 46.6, L["Crystalsong Forest"], nil, arTex, nil, nil, nil, nil, nil, 4.6, 127},
		},

		--[[Dragonblight]] [115] = {
			{"FlightA", 39.5, 25.9, L["Fordragon Hold"] .. ", " .. L["Dragonblight"], nil, tATex, nil, nil}, -- Derek Rammel
			{"FlightA", 29.2, 55.3, L["Stars' Rest"] .. ", " .. L["Dragonblight"], nil, tATex, nil, nil}, -- Palena Silvercloud
			{"FlightA", 77.1, 49.8, L["Wintergarde Keep"] .. ", " .. L["Dragonblight"], nil, tATex, nil, nil}, -- Rodney Wells
			{"FlightH", 37.5, 45.8, L["Agmar's Hammer"] .. ", " .. L["Dragonblight"], nil, tHTex, nil, nil}, -- Narzun Skybreaker
			{"FlightH", 43.9, 16.9, L["Kor'kron Vanguard"] .. ", " .. L["Dragonblight"], nil, tHTex, nil, nil}, -- Numo Spiritbreeze
			{"FlightH", 76.5, 62.2, L["Venomspite"] .. ", " .. L["Dragonblight"], nil, tHTex, nil, nil}, -- Junter Weiss
			{"FlightN", 48.5, 74.4, L["Moa'ki"] .. ", " .. L["Dragonblight"], nil, tNTex, nil, nil}, -- Cid Flounderfix
			{"FlightN", 60.3, 51.6, L["Wyrmrest Temple"] .. ", " .. L["Dragonblight"], nil, tNTex, nil, nil}, -- Nethestrasz
			{"Raid", 59.6, 51.1, L["Wyrmrest Temple"],
				L["The Ruby Sanctum"] .. " (80) (" .. L["req"] .. ": 80) (" .. L["sum"] .. ": 80)" .. "|n" ..
				L["The Obsidian Sanctum"] .. " (80) (" .. L["req"] .. ": 80) (" .. L["sum"] .. ": 80)",
				rdTex, 80, 80},
			{"Raid", 87.4, 51.1, L["Naxxramas"], L["Raid"], rdTex, 80, 80, 77, 77, 80, 0, 162},
			{"Dungeon", 26.2, 49.6,
				L["Azjol-Nerub"], L["Azjol-Nerub"]  .. " (72-74) (" .. L["req"] .. ": 70) (" .. L["sum"] .. ": 70-80)" .. "|n" ..
				L["The Old Kingdom"]  .. " (73-75) (" .. L["req"] .. ": 71) (" .. L["sum"] .. ": 70-80)",
				dnTex, 72, 75},
			{"Arrow", 92.3, 64.4, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 4.8, 116},
			{"Arrow", 88.8, 24.4, L["Zul'Drak"], nil, arTex, nil, nil, nil, nil, nil, 5.6, 121},
			{"Arrow", 61.1, 10.5, L["Crystalsong Forest"], nil, arTex, nil, nil, nil, nil, nil, 5.6, 127},
			{"Arrow", 12.4, 55.7, L["Borean Tundra"], nil, arTex, nil, nil, nil, nil, nil, 1.9, 114},
			{"TravelN", 49.6, 78.4, L["Boat to"] .. " " .. L["Kamagua"] .. ", " .. L["Howling Fjord"], nil, fNTex, nil, nil, nil, nil, nil, 0, 117},
			{"TravelN", 47.9, 78.7, L["Boat to"] .. " " .. L["Unu'pe"] .. ", " .. L["Borean Tundra"], nil, fNTex, nil, nil, nil, nil, nil, 0, 114},
		},

		--[[Grizzly Hills]] [116] = {
			{"FlightA", 31.3, 59.1, L["Amberpine Lodge"] .. ", " .. L["Grizzly Hills"], nil, tATex, nil, nil}, -- Vana Grey
			{"FlightA", 59.9, 26.7, L["Westfall Brigade"] .. ", " .. L["Grizzly Hills"], nil, tATex, nil, nil}, -- Samuel Clearbook
			{"FlightH", 65.0, 46.9, L["Camp Oneqwah"] .. ", " .. L["Grizzly Hills"], nil, tHTex, nil, nil}, -- Makki Wintergale
			{"FlightH", 22.0, 64.4, L["Conquest Hold"] .. ", " .. L["Grizzly Hills"], nil, tHTex, nil, nil}, -- Kragh
			{"Dungeon", 17.5, 27.0, L["Drak'Tharon Keep"], L["Dungeon"], dnTex, 74, 76, 72, 72, 80, 0, 160},
			{"Arrow", 9.8, 66.8, L["Dragonblight"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 115},
			{"Arrow", 9.6, 31.8, L["Dragonblight"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 115},
			{"Arrow", 34, 81.2, L["Howling Fjord"], nil, arTex, nil, nil, nil, nil, nil, 3.3, 117},
			{"Arrow", 67.2, 69.5, L["Howling Fjord"], nil, arTex, nil, nil, nil, nil, nil, 3.2, 117},
			{"Arrow", 87.9, 69.7, L["Howling Fjord"], nil, arTex, nil, nil, nil, nil, nil, 3.9, 117},
			{"Arrow", 60.1, 17.1, L["Zul'Drak"], nil, arTex, nil, nil, nil, nil, nil, 0.6, 121},
			{"Arrow", 44.5, 28, L["Zul'Drak"], nil, arTex, nil, nil, nil, nil, nil, 0.7, 121},
			{"Arrow", 18.1, 30.1, L["Zul'Drak"], L["Drak'Tharon Keep"], arTex, nil, nil, nil, nil, nil, 0.0, 121},
		},

		--[[Howlong Fjord]] [117] = {
			{"FlightA", 59.8, 63.2, L["Valgarde Port"] .. ", " .. L["Howling Fjord"], nil, tATex, nil, nil}, -- Pricilla Winterwind
			{"FlightA", 60.1, 16.1, L["Fort Wildervar"] .. ", " .. L["Howling Fjord"], nil, tATex, nil, nil}, -- James Ormsby
			{"FlightA", 31.3, 44.0, L["Westguard Keep"] .. ", " .. L["Howling Fjord"], nil, tATex, nil, nil}, -- Greer Orehammer
			{"FlightH", 26.0, 25.1, L["Apothecary Camp"] .. ", " .. L["Howling Fjord"], nil, tHTex, nil, nil}, -- Lilleth Radescu
			{"FlightH", 49.6, 11.6, L["Camp Winterhoof"] .. ", " .. L["Howling Fjord"], nil, tHTex, nil, nil}, -- Celea Frozenmane
			{"FlightH", 52.0, 67.4, L["New Agamand"] .. ", " .. L["Howling Fjord"], nil, tHTex, nil, nil}, -- Tobias Sarkhoff
			{"FlightH", 79.0, 29.7, L["Vengeance Landing"] .. ", " .. L["Howling Fjord"], nil, tHTex, nil, nil}, -- Bat Handler Adeline
			{"FlightN", 24.7, 57.8, L["Kamagua"] .. ", " .. L["Howling Fjord"], nil, tNTex, nil, nil}, -- Kip Trawlskip
			{"Dungeon", 58.8, 48.3, L["Utgarde Keep"], L["Dungeon"]  .. " (" .. L["req"] .. ": 67) (" .. L["sum"] .. ": 68-80)", dnTex, 69, 72, nil, nil, nil, 0, 133},
			{"Dungeon", 57.3, 46.8, L["Utgarde Pinnacle"], L["Dungeon"]  .. " (" .. L["req"] .. ": 75) (" .. L["sum"] .. ": 78-80)", dnTex, 79, 80, nil, nil, nil, 0, 137},
			{"Arrow", 24.7, 11.4, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 0.3, 116},
			{"Arrow", 53.7, 2.7, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 0.0, 116},
			{"Arrow", 72.9, 2.9, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 0.7, 116},
			{"TravelN", 23.5, 57.8, L["Boat to"] .. " " .. L["Moa'ki Harbor"] .. ", " .. L["Dragonblight"], nil, fNTex, nil, nil, nil, nil, nil, 0, 115},
			{"TravelA", 61.3, 62.6, L["Boat to"] .. " " .. L["Menethil Harbor"] .. ", " .. L["Wetlands"], nil, fATex, nil, nil, nil, nil, nil, 0, 1437},
			{"TravelH", 77.7, 28.3, L["Zeppelin to"] .. " " .. L["Undercity"] .. ", " .. L["Tirisfal Glades"], nil, fHTex, nil, nil, nil, nil, nil, 0, 1420},
		},

		--[[Icecrown]] [118] = {
			{"FlightN", 87.8, 78.1, L["The Argent Vanguard"] .. ", " .. L["Icecrown"], nil, tNTex, nil, nil}, -- Aedan Moran
			{"FlightN", 72.6, 22.8, L["Argent Tournament Grounds"] .. ", " .. L["Icecrown"], nil, tNTex, nil, nil}, -- Helidan Lightwing
			{"FlightN", 79.3, 72.3, L["Crusaders' Pinnacle"] .. ", " .. L["Icecrown"], nil, tNTex, nil, nil}, -- Penumbrius
			{"FlightN", 19.3, 47.8, L["Death's Rise"] .. ", " .. L["Icecrown"], nil, tNTex, nil, nil}, -- Dreadwind
			{"FlightN", 43.8, 24.4, L["The Shadow Vault"] .. ", " .. L["Icecrown"], nil, tNTex, nil, nil}, -- Morlia Doomwing
			{"Raid", 53.3, 85.5, L["Icecrown Citadel"], L["Raid"], rdTex, 80, 80, 80, nil, nil, 0, 186},
			{"Dungeon", 52.6, 89.4, L["The Frozen Halls"],
				L["The Forge of Souls"] .. " (80) (" .. L["req"] .. ": 78)" .. "|n" ..
				L["The Pit of Saron"] .. " (80) (" .. L["req"] .. ": 78)" .. "|n" ..
				L["The Halls of Reflection"] .. " (80) (" .. L["req"] .. ": 78)",
			dnTex, 80, 80},
			{"Dungeon", 74.2, 20.5, L["Trial of the Champion"], L["Dungeon"], dnTex, 80, 80, 80, nil, nil, 0, 171},
			{"Raid", 75.1, 21.8, L["Trial of the Crusader"], L["Raid"], rdTex, 80, 80, 80, nil, nil, 0, 172},
			{"Arrow", 89.2, 82.2, L["Crystalsong Forest"], nil, arTex, nil, nil, nil, nil, nil, 3.4, 127},
			{"Arrow", 80.7, 24.9, L["The Storm Peaks"], L["Head southeast from here and go up the mountain."], arTex, nil, nil, nil, nil, nil, 4.7, 120},
		},

		--[[Sholazar Basin]] [119] = {
			{"FlightN", 50.1, 61.4, L["River's Heart"] .. ", " .. L["Sholazar Basin"], nil, tNTex, nil, nil}, -- Tamara Wobblesprocket
			{"FlightN", 25.2,58.5, L["Nesingwary Base Camp"] .. ", " .. L["Sholazar Basin"], nil, tNTex, nil, nil}, -- The Spirit of Gnomeregan
			{"Arrow", 31.6, 89.5, L["Borean Tundra"], nil, arTex, nil, nil, nil, nil, nil, 3.4, 114},
		},

		--[[The Storm Peaks]] [120] = {
			{"FlightA", 29.5, 74.5, L["Frosthold"] .. ", " .. L["The Storm Peaks"], nil, tATex, nil, nil}, -- Faldorf Bitterchill
			{"FlightH", 65.4, 50.6, L["Camp Tunka'lo"] .. ", " .. L["The Storm Peaks"], nil, tHTex, nil, nil}, -- Hyeyoung Parka
			{"FlightH", 36.2, 49.4, L["Grom'arsh Crash Site"] .. ", " .. L["The Storm Peaks"], nil, tHTex, nil, nil}, -- Kabarg Windtamer
			{"FlightN", 40.8, 84.5, L["K3"] .. ", " .. L["The Storm Peaks"], nil, tNTex, nil, nil}, -- Skizzle Slickslide
			{"FlightN", 62.6, 60.9, L["Dun Nifflelem"] .. ", " .. L["The Storm Peaks"], nil, tNTex, nil, nil}, -- Halvdan
			{"FlightN", 44.5, 28.2, L["Ulduar"] .. ", " .. L["The Storm Peaks"], nil, tNTex, nil, nil}, -- Shavalius the Fancy
			{"FlightN", 30.6, 36.3, L["Bouldercrag's Refuge"] .. ", " .. L["The Storm Peaks"], nil, tNTex, nil, nil}, -- Breck Rockbrow
			{"Dungeon", 39.6, 26.9, L["Halls of Stone"], L["Dungeon"], dnTex, 77, 79, 73, 75, 80, 0, 140},
			{"Dungeon", 45.4, 21.4, L["Halls of Lightning"], L["Dungeon"], dnTex, 78, 80, 75, 75, 80, 0, 138},
			{"Raid", 41.6, 17.8, L["Ulduar"], L["Raid"], rdTex, 80, 80, 80, 75, 80, 0, 147},
			{"Arrow", 30.4, 93.8, L["Crystalsong Forest"], nil, arTex, nil, nil, nil, nil, nil, 2.4, 127},
			{"Arrow", 37.8, 90.2, L["Crystalsong Forest"], nil, arTex, nil, nil, nil, nil, nil, 3.6, 127},
			{"Arrow", 22.2, 36.4, L["Icecrown"], L["Head down the mountain from here."], arTex, nil, nil, nil, nil, nil, 2.1, 118},
		},

		--[[Wintergrasp]] [123] = {
			{"FlightA", 72.0, 31.0, L["Valiance Landing Camp"] .. ", " .. L["Wintergrasp"], nil, tATex, nil, nil}, -- Arzo Safeflight
			{"FlightH", 21.6, 34.9, L["Warsong Camp"] .. ", " .. L["Wintergrasp"], nil, tHTex, nil, nil}, -- Herzo Safeflight
			{"Raid", 50.5, 16.4, L["Vault of Archavon"], L["Raid"], rdTex, 80, 80, 80, 80, 80, 0, 156},
		},

		--[[Zul'Drak (*)]] [121] = {
			{"FlightN", 14.0, 73.6, L["Ebon Watch"] .. ", " .. L["Zul'Drak"], nil, tNTex, nil, nil}, -- Baneflight
			{"FlightN", 32.2, 74.4, L["Light's Breach"] .. ", " .. L["Zul'Drak"], nil, tNTex, nil, nil}, -- Danica Saint
			{"FlightN", 41.6, 64.4, L["The Argent Stand"] .. ", " .. L["Zul'Drak"], nil, tNTex, nil, nil}, -- Gurric
			{"FlightN", 70.5, 23.3, L["Gundrak"] .. ", " .. L["Zul'Drak"], nil, tNTex, nil, nil}, -- Rafae
			{"FlightN", 60.0, 56.7, L["Zim'Torga"] .. ", " .. L["Zul'Drak"], nil, tNTex, nil, nil}, -- Maaka
			{"Dungeon", 29.0, 83.9, L["Drak'Tharon Keep"], L["Dungeon"], dnTex, 74, 76, 72, 72, 80, 0, 160},
			{"Dungeon", 76.2, 21.1, L["Gundrak"], L["Dungeon"], dnTex, 76, 78, 73, 74, 80, 0, 153},
			{"Dungeon", 81.2, 28.9, L["Gundrak (rear entrance)"], L["Dungeon"], dnTex, 76, 78, 73, 74, 80, 0, 161},
			{"Arrow", 71.2, 78.3, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 4.0, 116},
			{"Arrow", 55.2, 91, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 3.8, 116},
			{"Arrow", 29, 87.1, L["Grizzly Hills"], L["Drak'Tharon Keep"], arTex, nil, nil, nil, nil, nil, 3.2, 116},
			{"Arrow", 17.6, 85.3, L["Dragonblight"], nil, arTex, nil, nil, nil, nil, nil, 2.4, 115},
			{"Arrow", 12.5, 67.1, L["Crystalsong Forest"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 127},
		},

		----------------------------------------------------------------------
		--	Cataclysm
		----------------------------------------------------------------------

		--[[Mount Hyjal]] [198] = {
			{"FlightN", 62.1, 21.6, L["Nordrassil"] .. ", " .. L["Mount Hyjal"], nil, tNTex, nil, nil},
			{"FlightN", 41.2, 42.6, L["Shrine of Aviana"] .. ", " .. L["Mount Hyjal"], nil, tNTex, nil, nil},
			{"FlightN", 19.6, 36.4, L["Grove of Aessina"] .. ", " .. L["Mount Hyjal"], nil, tNTex, nil, nil},
			{"FlightN", 27.8, 63.4, L["Sanctuary of Malorne"] .. ", " .. L["Mount Hyjal"], nil, tNTex, nil, nil},
			{"FlightN", 71.6, 75.2, L["Gates of Sothann"] .. ", " .. L["Mount Hyjal"], nil, tNTex, nil, nil},
			{"Raid", 47.3, 78.0, L["Firelands"], L["Raid"], rdTex},
		},

		--[[Southern Barrens]] [199] = {
			{"FlightA", 38.9, 10.9, L["Honor's Stand"] .. ", " .. L["Southern Barrens"], nil, tATex, nil, nil},
			{"FlightA", 66.4, 47.1, L["Northwatch Hold"] .. ", " .. L["Southern Barrens"], nil, tATex, nil, nil},
			{"FlightA", 49.2, 67.8, L["Fort Triumph"] .. ", " .. L["Southern Barrens"], nil, tATex, nil, nil},
			{"FlightH", 39.8, 20.3, L["Hunter's Hill"] .. ", " .. L["Southern Barrens"], nil, tHTex, nil, nil},
			{"FlightH", 41.6, 47.6, L["Vendetta Point"] .. ", " .. L["Southern Barrens"], nil, tHTex, nil, nil},
			{"FlightH", 41.2, 70.8, L["Desolation Hold"] .. ", " .. L["Southern Barrens"], nil, tHTex, nil, nil},
			{"Dungeon", 41.0, 94.6, L["Razorfen Kraul"], L["Dungeon"], dnTex},
		},

		--[[Kelp'thar Forest (Vashj'ir)]] [201] = {
			{"FlightN", 56.2, 31.0, L["Smuggler's Scar"] .. ", " .. L["Kelp'thar Forest"], nil, tNTex, nil, nil},
		},

		--[[Vashj'ir]] [203] = {
			{"Dungeon", 49.1, 42.4, L["Throne of the Tides"], L["Dungeon"], dnTex},
			{"FlightN", 74.8, 22.4, L["Smuggler's Scar"] .. ", " .. L["Kelp'thar Forest"], nil, tNTex, nil, nil},
			{"FlightA", 69.4, 75.2, L["Voldrin's Hold"] .. ", " .. L["Shimmering Expanse"], nil, tATex, nil, nil},
			{"FlightA", 64.0, 62.6, L["Tranquil Wash"] .. ", " .. L["Shimmering Expanse"], nil, tATex, nil, nil},
			{"FlightN", 64.2, 49.8, L["Silver Tide Hollow"] .. ", " .. L["Shimmering Expanse"], nil, tNTex, nil, nil},
			{"FlightA", 69.5, 34.0, L["Sandy Beach"] .. ", " .. L["Shimmering Expanse"], nil, tATex, nil, nil},
			{"FlightH", 64.8, 69.4, L["Legion's Rest"] .. ", " .. L["Shimmering Expanse"], nil, tHTex, nil, nil},
			{"FlightH", 68.9, 68.1, L["Stygian Bounty"] .. ", " .. L["Shimmering Expanse"], nil, tHTex, nil, nil},
			{"FlightH", 72.4, 41.9, L["Sandy Beach"] .. ", " .. L["Shimmering Expanse"], nil, tHTex, nil, nil},
			{"FlightA", 42.3, 73.9, L["Darkbreak Cove"] .. ", " .. L["Abyssal Depths"], nil, tATex, nil, nil},
			{"FlightH", 45.7, 57.3, L["Tenebrous Cavern"] .. ", " .. L["Abyssal Depths"], nil, tHTex, nil, nil},
		},

		--[[Abyssal Depths (Vashj'ir)]] [204] = {
			{"Dungeon", 70.8, 29.0, L["Throne of the Tides"], L["Dungeon"], dnTex},
			{"FlightA", 56.8, 75.4, L["Darkbreak Cove"] .. ", " .. L["Abyssal Depths"], nil, tATex, nil, nil},
			{"FlightH", 53.8, 59.6, L["Tenebrous Cavern"] .. ", " .. L["Abyssal Depths"], nil, tHTex, nil, nil},
		},

		--[[Shimmering Expanse (Vashj'ir)]] [205] = {
			{"FlightA", 57.0, 17.0, L["Sandy Beach"] .. ", " .. L["Shimmering Expanse"], nil, tATex, nil, nil},
			{"FlightN", 49.4, 39.8, L["Silver Tide Hollow"] .. ", " .. L["Shimmering Expanse"], nil, tNTex, nil, nil},
			{"FlightA", 48.9, 57.1, L["Tranquil Wash"] .. ", " .. L["Shimmering Expanse"], nil, tATex, nil, nil},
			{"FlightA", 56.5, 75.2, L["Voldrin's Hold"] .. ", " .. L["Shimmering Expanse"], nil, tATex, nil, nil},
			{"FlightH", 60.9, 28.4, L["Sandy Beach"] .. ", " .. L["Shimmering Expanse"], nil, tHTex, nil, nil},
			{"FlightH", 49.4, 39.8, L["Silver Tide Hollow"] .. ", " .. L["Shimmering Expanse"], nil, tHTex, nil, nil},
			{"FlightH", 50.3, 65.9, L["Legion's Rest"] .. ", " .. L["Shimmering Expanse"], nil, tHTex, nil, nil},
			{"FlightH", 54.0, 65.2, L["Stygian Bounty"] .. ", " .. L["Shimmering Expanse"], nil, tHTex, nil, nil},
		},

		--[[Deepholm]] [207] = {
			{"Dungeon", 47.6, 52.0, L["The Stonecore"], L["Dungeon"], dnTex},
		},

		--[[Twilight Highlands]] [241] = {
			{"FlightN", 28.4, 24.8, L["Vermillion Redoubt"] .. ", " .. L["Twilight Highlands"], nil, tNTex, nil, nil},
			{"FlightA", 48.4, 28.2, L["Thundermar"] .. ", " .. L["Twilight Highlands"], nil, tATex, nil, nil},
			{"FlightA", 56.6, 15.2, L["Kirthaven"] .. ", " .. L["Twilight Highlands"], nil, tATex, nil, nil},
			{"FlightA", 43.8, 57.2, L["Victor's Point"] .. ", " .. L["Twilight Highlands"], nil, tATex, nil, nil},
			{"FlightA", 60.4, 57.6, L["Firebeard's Patrol"] .. ", " .. L["Twilight Highlands"], nil, tATex, nil, nil},
			{"FlightA", 81.6, 77.0, L["Highbank"] .. ", " .. L["Twilight Highlands"], nil, tATex, nil, nil},
			{"FlightH", 75.4, 17.8, L["The Krazzworks"] .. ", " .. L["Twilight Highlands"], nil, tHTex, nil, nil},
			{"FlightH", 45.8, 76.2, L["Crushblow"] .. ", " .. L["Twilight Highlands"], nil, tHTex, nil, nil},
			{"FlightH", 36.9, 38.0, L["The Gullet"] .. ", " .. L["Twilight Highlands"], nil, tHTex, nil, nil},
			{"FlightH", 54.1, 42.2, L["Bloodgulch"] .. ", " .. L["Twilight Highlands"], nil, tHTex, nil, nil},
			{"FlightH", 73.6, 52.9, L["Dragonmaw Port"] .. ", " .. L["Twilight Highlands"], nil, tHTex, nil, nil},
			{"Raid", 34.0, 78.0, L["The Bastion of Twilight"], L["Raid"], rdTex},
			{"Dungeon", 19.2, 54.0, L["Grim Batol"], L["Dungeon"], dnTex},
		},

		--[[Tol Barad]] [244] = {
			{"Raid", 46.3, 47.9, L["Baradin Hold"], L["Raid"], rdTex},
		},

		--[[Uldum]] [249] = {
			{"FlightN", 26.6, 8.2, L["Oasis of Vir'sar"] .. ", " .. L["Uldum"], nil, tNTex, nil, nil},
			{"FlightN", 22.2, 64.8, L["Schnottz's Landing"] .. ", " .. L["Uldum"], nil, tNTex, nil, nil},
			{"FlightN", 45.8, 76.2, L["Ramkahen"] .. ", " .. L["Uldum"], nil, tNTex, nil, nil},
			{"Dungeon", 71.6, 52.2, L["Halls of Origination"], L["Dungeon"], dnTex},
			{"Dungeon", 60.5, 64.2, L["Lost City of the Tol'vir"], L["Dungeon"], dnTex},
			{"Dungeon", 76.7, 84.4, L["The Vortex Pinnacle"], L["Dungeon"], dnTex},
			{"Raid", 38.4, 80.6, L["Throne of the Four Winds"], L["Raid"], rdTex},
		},

	}

	local frame = CreateFrame("FRAME")
	frame:RegisterEvent("PLAYER_LOGIN")
	frame:SetScript("OnEvent", function()

		-- Add Caverns of Time portal to Shattrath if reputation with Keepers of Time is revered or higher
		local name, description, standingID = GetFactionInfoByID(989)
		if standingID and standingID >= 7 then
			Leatrix_Maps["Icons"][1955] = Leatrix_Maps["Icons"][1955] or {}; tinsert(Leatrix_Maps["Icons"][1955], {"TravelN", 74.7, 31.4, L["Caverns of Time"], L["Portal from Zephyr"], pNTex})
		end

		-- Add situational data
		local void, class = UnitClass("player")
		if class == "DRUID" then
			-- Moonglade flight points for druids only
			tinsert(Leatrix_Maps["Icons"][1450], {"FlightA", 44.1, 45.2, L["Nighthaven"] .. ", " .. L["Moonglade"], L["Druid only flight point to Darnassus"], tATex, nil, nil})
			tinsert(Leatrix_Maps["Icons"][1450], {"FlightH", 44.3, 45.9, L["Nighthaven"] .. ", " .. L["Moonglade"], L["Druid only flight point to Thunder Bluff"], tHTex, nil, nil})
		end

	end)
