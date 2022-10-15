
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

	-- Spirit healers
	local spTex = "Vehicle-TempleofKotmogu-GreenBall"

	-- Zone crossings
	local arTex = "Garr_LevelUpgradeArrow"

	Leatrix_Maps["Icons"] = {

		-- pos for code then showinst on Encounter Journal for dungeon ID.

		----------------------------------------------------------------------
		--	Eastern Kingdoms
		----------------------------------------------------------------------

		--[[Alterac Mountains]] [1416] = {
			{"Spirit", 42.9, 38.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 80.7, 34.2, L["Western Plaguelands"], nil, arTex, nil, nil, nil, nil, nil, 0, 1422},
			{"Arrow", 51.8, 68.8, L["Hillsbrad Foothills"], nil, arTex, nil, nil, nil, nil, nil, 3, 1424},
			{"Arrow", 81.7, 77.5, L["Hillsbrad Foothills"], L["Ravenholdt Manor"], arTex, nil, nil, nil, nil, nil, 2.2, 1424},
			{"Arrow", 91.3, 45.8, L["Western Plaguelands"], nil, arTex, nil, nil, nil, nil, nil, 5.2, 1422},
			{"Arrow", 72, 67.5, L["Hillsbrad Foothills"], nil, arTex, nil, nil, nil, nil, nil, 2.6, 1424},
			{"Arrow", 8.9, 70.4, L["Silverpine Forest"], nil, arTex, nil, nil, nil, nil, nil, 1.3, 1421},
		},
		--[[Arathi Highlands]] [1417] = {
			{"FlightA", 45.8, 46.1, L["Refuge Pointe"] .. ", " .. L["Arathi Highlands"], nil, tATex, nil, nil},
			{"FlightH", 73.1, 32.7, L["Hammerfall"] .. ", " .. L["Arathi Highlands"], nil, tHTex, nil, nil},
			{"Spirit", 48.8, 55.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 45.4, 88.9, L["Wetlands"], L["Thandol Span"], arTex, nil, nil, nil, nil, nil, 3.2, 1437},
			{"Arrow", 20.9, 30.6, L["Hillsbrad Foothills"], nil, arTex, nil, nil, nil, nil, nil, 1, 1424},
		},
		--[[Badlands]] [1418] = {
			{"Dungeon", 44.6, 12.1, L["Uldaman"], L["Dungeon"], dnTex, 36, 40, 30, 36, 80}, -- sum cap was 44
			{"Dungeon", 65.1, 43.4, L["Uldaman (side entrance)"], L["Dungeon"], dnTex, 36, 40, 30, 36, 80}, -- sum cap was 44
			{"FlightH", 4.0, 44.8, L["Kargath"] .. ", " .. L["Badlands"], nil, tHTex, nil, nil},
			{"Spirit", 56.7, 23.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 8.4, 55.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 56.7, 73.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 51.1, 14.8, L["Loch Modan"], nil, arTex, nil, nil, nil, nil, nil, 0.8, 1432},
			{"Arrow", 5.3, 61.1, L["Searing Gorge"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1427},
		},
		--[[Blasted Lands]] [1419] = {
			{"FlightA", 65.5, 24.3, L["Nethergarde Keep"] .. ", " .. L["Blasted Lands"], nil, tATex, nil, nil},
			{"Spirit", 51.1, 12.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 52.2, 10.7, L["Swamp of Sorrows"], nil, arTex, nil, nil, nil, nil, nil, 0, 1435},
			{"Arrow", 58.8, 59.7, L["Hellfire Peninsula"], L["The Dark Portal"], arTex, nil, nil, nil, nil, nil, 3.5, 1944},
		},
		--[[Tirisfal Glades]] [1420] = {
			{"Dungeon", 82.6, 33.8, L["Scarlet Monastery"], L["Dungeon"], dnTex, 30, 40, 20, 28, 80}, -- sum cap was 44
			{"TravelH", 60.7, 58.8, L["Zeppelin to"] .. " " .. L["Orgrimmar"] .. ", " .. L["Durotar"], nil, fHTex, nil, nil},
			{"TravelH", 61.9, 59.1, L["Zeppelin to"] .. " " .. L["Grom'gol Base Camp"] .. ", " .. L["Stranglethorn Vale"], nil, fHTex, nil, nil},
			{"Spirit", 30.8, 64.9, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 56.2, 49.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 79.0, 41.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 62.3, 67.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 82.0, 69.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 83.4, 70.6, L["Western Plaguelands"], L["The Bulwark"], arTex, nil, nil, nil, nil, nil, 4.7, 1422},
			{"Arrow", 61.9, 65.0, L["Undercity"], nil, arTex, nil, nil, nil, nil, nil, 3, 1458},
			{"Arrow", 54.9, 72.7, L["Silverpine Forest"], nil, arTex, nil, nil, nil, nil, nil, 3, 1421},
			{"TravelH", 59.1, 59.0, L["Zeppelin to"] .. " " .. L["Vengeance Landing"] .. ", " .. L["Howling Fjord"], nil, fHTex, nil, nil},
			{"FlightH", 83.6, 69.9, L["The Bulwark"] .. ", " .. L["Tirisfal Glades"], nil, tHTex, nil, nil},
			{"Arrow", 51, 71.4, L["Undercity"], L["Sewers"], arTex, nil, nil, nil, nil, nil, 3.0, 1458},
		},
		--[[Silverpine Forest]] [1421] = {
			{"Dungeon", 44.8, 67.8, L["Shadowfang Keep"], L["Dungeon"], dnTex, 18, 21, 14, 17, 80}, -- sum cap was 25
			{"FlightH", 45.6, 42.6, L["The Sepulcher"] .. ", " .. L["Silverpine Forest"], nil, tHTex, nil, nil},
			{"Spirit", 44.1, 42.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 55.6, 73.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 66.3, 79.8, L["Hillsbrad Foothills"], nil, arTex, nil, nil, nil, nil, nil, 4.3, 1424},
			{"Arrow", 67.7, 5.0, L["Tirisfal Glades"], nil, arTex, nil, nil, nil, nil, nil, 5.7, 1420},
			{"Arrow", 68.7, 52.5, L["Alterac Mountains"], L["Dalaran Crater"], arTex, nil, nil, nil, nil, nil, 4.3, 1416},
		},
		--[[Western Plaguelands]] [1422] = {
			{"Dungeon", 69.7, 73.2, L["Scholomance"], L["Dungeon"], dnTex, 58, 60, 45, 56, 80}, -- sum cap was 61
			{"FlightA", 42.9, 85.1, L["Chillwind Camp"] .. ", " .. L["Western Plaguelands"], nil, tATex, nil, nil},
			{"Spirit", 59.7, 53.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 65.8, 74.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 45.0, 86.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 44.1, 87.1, L["Alterac Mountains"], nil, arTex, nil, nil, nil, nil, nil, 3, 1416},
			{"Arrow", 28.6, 57.5, L["Tirisfal Glades"], L["The Balwark"], arTex, nil, nil, nil, nil, nil, 1.6, 1420},
			{"Arrow", 69.7, 50.3, L["Eastern Plaguelands"], nil, arTex, nil, nil, nil, nil, nil, 4.7, 1423},
			{"Arrow", 65.3, 86.4, L["The Hinterlands"], nil, arTex, nil, nil, nil, nil, nil, 3, 1425},
			{"FlightN", 69.3, 49.7, L["Thondoril River"] .. ", " .. L["Western Plaguelands"], nil, tNTex, nil, nil},
			{"Arrow", 53.5, 92.9, L["Alterac Mountains"], nil, arTex, nil, nil, nil, nil, nil, 2.2, 1416},
		},
		--[[Eastern Plaguelands]] [1423] = {
			{"Dungeon", 27.1, 15.7, L["Stratholme (Main Gate)"], L["Dungeon"], dnTex, 58, 60, 45, 56, 80}, {"Dungeon", 43.5, 19.4, L["Stratholme (Service Gate)"], L["Dungeon"], dnTex, 58, 60, 45, 56, 80}, -- sum cap for both was 61
			{"FlightA", 75.9, 53.4, L["Light's Hope Chapel"] .. ", " .. L["Eastern Plaguelands"], nil, tATex, nil, nil},
			{"FlightH", 74.5, 51.2, L["Light's Hope Chapel"] .. ", " .. L["Eastern Plaguelands"], nil, tHTex, nil, nil},
			{"Spirit", 42.9, 38.9, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 35.0, 85.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 67.7, 60.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 15.8, 55.5, L["Spirit Healer"], nil, spTex, nil, nil}, -- New in Wrath
			{"Arrow", 8.7, 66.2, L["Western Plaguelands"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 1422},
			{"Arrow", 54.2, 14.4, L["Ghostlands"], nil, arTex, nil, nil, nil, nil, nil, 0.4, 1942},
			{"FlightN", 83.9, 50.4, L["Acherus: The Ebon Hold"] .. ", " .. L["Eastern Plaguelands"], nil, tNTex, nil, nil},
		},
		--[[Hillsbrad Foothills]] [1424] = {
			{"FlightA", 49.3, 52.3, L["Southshore"] .. ", " .. L["Hillsbrad Foothills"], nil, tATex, nil, nil},
			{"FlightH", 60.1, 18.6, L["Tarren Mill"] .. ", " .. L["Hillsbrad Foothills"], nil, tHTex, nil, nil},
			{"Spirit", 64.5, 19.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 51.8, 52.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 84.6, 31.8, L["The Hinterlands"], nil, arTex, nil, nil, nil, nil, nil, 5.4, 1425},
			{"Arrow", 54.8, 11.3, L["Alterac Mountains"], nil, arTex, nil, nil, nil, nil, nil, 0, 1416},
			{"Arrow", 13.7, 46.2, L["Silverpine Forest"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1421},
			{"Arrow", 76.0, 51.8, L["Arathi Highlands"], nil, arTex, nil, nil, nil, nil, nil, 4.1, 1417},
			{"Arrow", 75.5, 24.6, L["Alterac Mountains"], L["Ravenholdt Manor"], arTex, nil, nil, nil, nil, nil, 0.0, 1416},
			{"Arrow", 71.7, 8.6, L["Alterac Mountains"], nil, arTex, nil, nil, nil, nil, nil, 5.6, 1416},
		},
		--[[The Hinterlands]] [1425] = {
			{"FlightA", 11.1, 46.2, L["Aerie Peak"] .. ", " .. L["The Hinterlands"], nil, tATex, nil, nil},
			{"FlightH", 81.7, 81.8, L["Revantusk Village"] .. ", " .. L["The Hinterlands"], nil, tHTex, nil, nil},
			{"Spirit", 16.9, 44.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 73.1, 68.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 24.1, 30.4, L["Western Plaguelands"], nil, arTex, nil, nil, nil, nil, nil, 0, 1422},
			{"Arrow", 6.4, 61.5, L["Hillsbrad Foothills"], nil, arTex, nil, nil, nil, nil, nil, 2.3, 1424},
		},
		--[[Dun Morogh]] [1426] = {
			{"Dungeon", 24.3, 39.8, L["Gnomeregan"], L["Dungeon"], dnTex, 25, 28, 15, 24, 80}, -- sum cap was 40
			{"Spirit", 30.0, 69.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 47.3, 54.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 54.4, 39.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 84.3, 31.1, L["Loch Modan"], L["North Gate Pass"], arTex, nil, nil, nil, nil, nil, 0, 1432},
			{"Arrow", 82.2, 53.5, L["Loch Modan"], L["South Gate Pass"], arTex, nil, nil, nil, nil, nil, 5, 1432},
			{"Arrow", 30.5, 34.5, L["Wetlands"], L["You will die!"], arTex, nil, nil, nil, nil, nil, 6.2, 1437},
			{"Arrow", 53.3, 35.1, L["Ironforge"], nil, arTex, nil, nil, nil, nil, nil, 5.4, 1455},
		},
		--[[Searing Gorge]] [1427] = {
			{"Dunraid", 34.8, 85.3, L["Blackrock Mountain"], L["Blackrock Depths"]  .. " (" .. L["req"] .. ": 40)" .. ", " .. L["Blackwing Lair"] .. " (" .. L["req"] .. ": 55)" .. ", " .. L["Lower Blackrock Spire"] .. " (" .. L["req"] .. ": 45)" .. ", |n" .. L["Molten Core"] .. " (" .. L["req"] .. ": 50)" .. ", " .. L["Upper Blackrock Spire"] .. " (" .. L["req"] .. ": 45)", dnTex, 48, 60, nil, 48, 80},
			{"FlightA", 37.9, 30.8, L["Thorium Point"] .. ", " .. L["Searing Gorge"], nil, tATex, nil, nil},
			{"FlightH", 34.8, 30.9, L["Thorium Point"] .. ", " .. L["Searing Gorge"], nil, tHTex, nil, nil},
			{"Spirit", 35.5, 22.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 54.4, 51.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 78.5, 17.4, L["Loch Modan"], L["Requires Key to Searing Gorge"], arTex, nil, nil, nil, nil, nil, 5.4, 1432},
			{"Arrow", 33.6, 79.0, L["Burning Steppes"], L["Blackrock Mountain"], arTex, nil, nil, nil, nil, nil, 3, 1428},
			{"Arrow", 68.8, 53.9, L["Badlands"], nil, arTex, nil, nil, nil, nil, nil, 4.5, 1418},
		},
		--[[Burning Steppes]] [1428] = {
			{"Dunraid", 29.4, 38.3, L["Blackrock Mountain"], L["Blackrock Depths"]  .. " (" .. L["req"] .. ": 40)" .. ", " .. L["Blackwing Lair"] .. " (" .. L["req"] .. ": 55)" .. ", " .. L["Lower Blackrock Spire"] .. " (" .. L["req"] .. ": 45)" .. ", |n" .. L["Molten Core"] .. " (" .. L["req"] .. ": 50)" .. ", " .. L["Upper Blackrock Spire"] .. " (" .. L["req"] .. ": 45)", dnTex, 48, 60, nil, 48, 80},
			{"FlightA", 84.3, 68.3, L["Morgan's Vigil"] .. ", " .. L["Burning Steppes"], nil, tATex, nil, nil},
			{"FlightH", 65.7, 24.2, L["Flame Crest"] .. ", " .. L["Burning Steppes"], nil, tHTex, nil, nil},
			{"Spirit", 64.1, 24.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 78.3, 77.8, L["Redridge Mountains"], nil, arTex, nil, nil, nil, nil, nil, 3.3, 1433},
			{"Arrow", 31.9, 50.4, L["Searing Gorge"], L["Blackrock Mountain"], arTex, nil, nil, nil, nil, nil, 0.8, 1427},
		},
		--[[Elwynn Forest]] [1429] = {
			{"Spirit", 39.5, 60.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 49.7, 42.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 83.6, 69.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 21.0, 79.6, L["Westfall"], nil, arTex, nil, nil, nil, nil, nil, 2.2, 1436},
			{"Arrow", 93.2, 72.3, L["Redridge Mountains"], nil, arTex, nil, nil, nil, nil, nil, 4.7, 1433},
			{"Arrow", 32.2, 49.7, L["Stormwind City"], nil, arTex, nil, nil, nil, nil, nil, 0.6, 1453},
		},
		--[[Deadwind Pass]] [1430] = {
			{"Spirit", 40.0, 74.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Raid", 46.9, 74.7, L["Karazhan"], L["Raid"], rdTex, 70, 70, 68, 68, 80},
			{"Arrow", 32.0, 35.3, L["Duskwood"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1431},
			{"Arrow", 58.8, 42.2, L["Swamp of Sorrows"], nil, arTex, nil, nil, nil, nil, nil, 5.2, 1435},
		},
		--[[Duskwood]] [1431] = {
			{"FlightA", 77.5, 44.3, L["Darkshire"] .. ", " .. L["Duskwood"], nil, tATex, nil, nil},
			{"Spirit", 20.0, 49.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 75.1, 59.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 7.9, 63.8, L["Westfall"], nil, arTex, nil, nil, nil, nil, nil, 1.7, 1436},
			{"Arrow", 44.6, 87.9, L["Stranglethorn Vale"], nil, arTex, nil, nil, nil, nil, nil, 3, 1434},
			{"Arrow", 94.2, 10.3, L["Redridge Mountains"], nil, arTex, nil, nil, nil, nil, nil, 5.8, 1433},
			{"Arrow", 88.4, 40.9, L["Deadwind Pass"], nil, arTex, nil, nil, nil, nil, nil, 4.6, 1430},
		},
		--[[Loch Modan]] [1432] = {
			{"FlightA", 33.9, 50.9, L["Thelsamar"] .. ", " .. L["Loch Modan"], nil, tATex, nil, nil},
			{"Spirit", 32.6, 47.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 18.4, 83.0, L["Searing Gorge"], L["Requires Key to Searing Gorge"], arTex, nil, nil, nil, nil, nil, 2.6, 1427},
			{"Arrow", 20.4, 17.4, L["Dun Morogh"], L["North Gate Pass"], arTex, nil, nil, nil, nil, nil, 1.1, 1426},
			{"Arrow", 46.8, 76.9, L["Badlands"], nil, arTex, nil, nil, nil, nil, nil, 3.2, 1418},
			{"Arrow", 21.5, 66.2, L["Dun Morogh"], L["South Gate Pass"], arTex, nil, nil, nil, nil, nil, 0.5, 1426},
			{"Arrow", 25.4, 10.9, L["Wetlands"], L["Dun Algaz"], arTex, nil, nil, nil, nil, nil, 0.1, 1437},
		},
		--[[Redridge Mountains]] [1433] = {
			{"FlightA", 30.6, 59.4, L["Lake Everstill"] .. ", " .. L["Redridge Mountains"], nil, tATex, nil, nil},
			{"Spirit", 20.8, 56.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 8.5, 88.1, L["Duskwood"], nil, arTex, nil, nil, nil, nil, nil, 2.2, 1431},
			{"Arrow", 3.3, 73.1, L["Elwynn Forest"], nil, arTex, nil, nil, nil, nil, nil, 2.1, 1429},
			{"Arrow", 47.3, 14.3, L["Burning Steppes"], nil, arTex, nil, nil, nil, nil, nil, 5.9, 1428},
		},
		--[[Stranglethorn Vale]] [1434] = {
			{"Raid", 53.9, 17.6, L["Zul'Gurub"], L["Raid"], rdTex, 60, 60, 50, 55, 80},
			{"FlightA", 27.5, 77.8, L["Booty Bay"] .. ", " .. L["Stranglethorn Vale"], nil, tATex, nil, nil},
			{"FlightA", 38.2, 4.0, L["Rebel Camp"] .. ", " .. L["Stranglethorn Vale"], nil, tATex, nil, nil},
			{"FlightH", 26.9, 77.1, L["Booty Bay"] .. ", " .. L["Stranglethorn Vale"], nil, tHTex, nil, nil},
			{"FlightH", 32.5, 29.4, L["Grom'gol Base Camp"] .. ", " .. L["Stranglethorn Vale"], nil, tHTex, nil, nil},
			{"TravelN", 25.9, 73.1, L["Boat to"] .. " " .. L["Ratchet"] .. ", " .. L["The Barrens"], nil, fNTex, nil, nil},
			{"TravelH", 31.4, 30.2, L["Zeppelin to"] .. " " .. L["Orgrimmar"] .. ", " .. L["Durotar"], nil, fHTex, nil, nil},
			{"TravelH", 31.6, 29.1, L["Zeppelin to"] .. " " .. L["Undercity"] .. ", " .. L["Tirisfal Glades"], nil, fHTex, nil, nil},
			{"Spirit", 38.4, 9.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 30.4, 73.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 39.2, 6.5, L["Duskwood"], nil, arTex, nil, nil, nil, nil, nil, 0, 1431},
		},
		--[[Swamp of Sorrows]] [1435] = {
			{"Dungeon", 69.9, 53.6, L["Temple of Atal'Hakkar"], L["Dungeon"], dnTex, 47, 50, 35, 45, 80}, -- sum cap was 54
			{"FlightH", 46.1, 54.8, L["Stonard"] .. ", " .. L["Swamp of Sorrows"], nil, tHTex, nil, nil},
			{"Spirit", 50.3, 62.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 3.7, 61.1, L["Deadwind Pass"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1430},
			{"Arrow", 33.4, 74.8, L["Blasted Lands"], nil, arTex, nil, nil, nil, nil, nil, 3.1, 1419},
		},
		--[[Westfall]] [1436] = {
			{"Dungeon", 42.5, 71.7, L["The Deadmines"], L["Dungeon"], dnTex, 18, 22, 10, 16, 80}, -- sum cap was 24
			{"FlightA", 56.6, 52.6, L["Sentinel Hill"] .. ", " .. L["Westfall"], nil, tATex, nil, nil},
			{"Spirit", 51.7, 49.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 62.0, 17.9, L["Elwynn Forest"], nil, arTex, nil, nil, nil, nil, nil, 5.4, 1429},
			{"Arrow", 67.9, 62.8, L["Duskwood"], nil, arTex, nil, nil, nil, nil, nil, 4.7, 1431},
		},
		--[[Wetlands]] [1437] = {
			{"FlightA", 9.5, 59.7, L["Menethil Harbor"] .. ", " .. L["Wetlands"], nil, tATex, nil, nil},
			{"TravelA", 5.0, 63.5, L["Boat to"] .. " " .. L["Theramore Isle"] .. ", " .. L["Dustwallow Marsh"], nil, fATex, nil, nil},
			{"TravelA", 4.6, 57.1, L["Boat to"] .. " " .. L["Valgarde"] .. ", " .. L["Howling Fjord"], nil, fATex, nil, nil},
			{"Spirit", 11.0, 43.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 49.3, 41.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 51.3, 10.3, L["Arathi Highlands"], L["Thandol Span"], arTex, nil, nil, nil, nil, nil, 0, 1417},
			{"Arrow", 56.0, 70.3, L["Loch Modan"], L["Dun Algaz"], arTex, nil, nil, nil, nil, nil, 1.8, 1432},
		},
		--[[Stormwind City]] [1453] = {
			{"Dungeon", 52.4, 70.0, L["The Stockade"], L["Dungeon"], dnTex, 23, 29, 15, 21, 80}, -- sum cap was 29
			{"FlightA", 71.0, 72.5, L["Trade District"] .. ", " .. L["Stormwind"], nil, tATex, nil, nil},
			{"TravelA", 66.4, 34.1, L["Tram to"] .. " " .. L["Tinker Town"] .. ", " .. L["Ironforge"], nil, fATex, nil, nil},
			{"Arrow", 74.7, 93.4, L["Elwynn Forest"], nil, arTex, nil, nil, nil, nil, nil, 3.8, 1429},
			{"TravelA", 22.5, 56.1, L["Boat to"] .. " " .. L["Auberdine"] .. ", " .. L["Darkshore"], nil, fATex, nil, nil},
			{"TravelA", 18.1, 25.5, L["Boat to"] .. " " .. L["Valiance Keep"] .. ", " .. L["Borean Tundra"], nil, fATex, nil, nil},
			{"TravelA", 49.0, 87.3, L["Blasted Lands"], L["Portal"], pATex},
		},
		--[[Ironforge]] [1455] = {
			{"FlightA", 55.5, 47.8, L["The Great Forge"] .. ", " .. L["Ironforge"], nil, tATex, nil, nil},
			{"TravelA", 73.0, 50.2, L["Tram to"] .. " " .. L["Dwarven District"] .. ", " .. L["Stormwind"], nil, fATex, nil, nil},
			{"Arrow", 21.9, 77.5, L["Dun Morogh"], nil, arTex, nil, nil, nil, nil, nil, 2.2, 1426},
			{"TravelA", 27.3, 7.1, L["Blasted Lands"], L["Portal"], pATex},
		},
		--[[Undercity]] [1458] = {
			{"FlightH", 63.3, 48.5, L["Trade Quarter"] .. ", " .. L["Undercity"], nil, tHTex, nil, nil},
			{"Spirit", 67.9, 14.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 66.2, 5.2, L["Tirisfal Glades"], nil, arTex, nil, nil, nil, nil, nil, 0, 1420},
			{"TravelH", 54.9, 11.3, L["Silvermoon City"], L["Orb of Translocation"]},
			{"TravelH", 85.3, 17.0, L["Blasted Lands"], L["Portal"], pHTex},
			{"Arrow", 46.7, 44.3, L["Sewers"], L["Leads to Tirisfal Glades"], arTex, nil, nil, nil, nil, nil, 1.6},
			{"Arrow", 15.1, 31.9, L["Tirisfal Glades"], nil, arTex, nil, nil, nil, nil, nil, 6.1, 1420},
		},
		--[[Isle of Quel'Danas]] [1957] = {
			{"Spirit", 46.6, 32.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Dungeon", 61.2, 30.9, L["Magisters' Terrace"], L["Dungeon"], dnTex, 70, 80}, -- sum cap was 70
			{"Raid", 44.3, 45.6, L["Sunwell Plateau"], L["Raid"], rdTex, 70, 70},
			{"FlightH", 48.4, 25.1, L["Sun's Reach Harbor"] .. ", " .. L["Isle of Quel Danas"], nil, tHTex, nil, nil},
			{"FlightA", 48.5, 25.2, L["Sun's Reach Harbor"] .. ", " .. L["Isle of Quel Danas"], nil, tATex, nil, nil},
		},
		--[[Eversong Woods]] [1941] = {
			{"FlightH", 54.4, 50.7, L["Silvermoon City"] .. ", " .. L["Eversong Woods"], nil, tHTex, nil, nil},
			{"Spirit", 38.2, 17.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 48.0, 49.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 44.3, 71.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 60.0, 64.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 48.7, 91.0, L["Ghostlands"], nil, arTex, nil, nil, nil, nil, nil, 3, 1942},
			{"Arrow", 56.7, 49.7, L["Silvermoon City"], nil, arTex, nil, nil, nil, nil, nil, 0.0, 1954},
			{"Arrow", 68.2, 88.1, L["Ghostlands"], L["Zeb'Sora"], arTex, nil, nil, nil, nil, nil, 3.3, 1942},
		},
		--[[Ghostlands]] [1942] = {
			{"FlightH", 45.4, 30.5, L["Tranquillien"] .. ", " .. L["Ghostlands"], nil, tHTex, nil, nil},
			{"FlightN", 74.7, 67.1, L["Zul'Aman"] .. ", " .. L["Ghostlands"], nil, tNTex, nil, nil},
			{"Raid", 82.3, 64.3, L["Zul'Aman"], L["Raid"], rdTex, 70, 70, 68, 70, 80},
			{"Spirit", 43.9, 25.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 61.5, 57.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 80.5, 69.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 47.5, 84.0, L["Eastern Plaguelands"], nil, arTex, nil, nil, nil, nil, nil, 3, 1423},
			{"Arrow", 48.4, 13.2, L["Eversong Woods"], nil, arTex, nil, nil, nil, nil, nil, 0, 1941},
			{"Arrow", 77.7, 6.3, L["Eversong Woods"], nil, arTex, nil, nil, nil, nil, nil, 6.2, 1941},
		},
		--[[Silvermoon City]] [1954] = {
			{"TravelH", 49.5, 14.8, L["Undercity"], L["Orb of Translocation"]},
			{"Arrow", 72.6, 85.9, L["Eversong Woods"], nil, arTex, nil, nil, nil, nil, nil, 3.2, 1941},
		},

		----------------------------------------------------------------------
		--	Kalimdor
		----------------------------------------------------------------------

		--[[Durotar]] [1411] = {
			{"TravelH", 50.9, 13.9, L["Zeppelin to"] .. " " .. L["Undercity"] .. ", " .. L["Tirisfal Glades"], nil, fHTex, nil, nil, nil, nil},
			{"TravelH", 50.6, 12.6, L["Zeppelin to"] .. " " .. L["Grom'gol Base Camp"] .. ", " .. L["Stranglethorn Vale"], nil, fHTex, nil, nil, nil, nil},
			{"Spirit", 47.4, 17.9, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 53.5, 44.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 44.2, 69.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 57.2, 73.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 35.1, 42.4, L["The Barrens"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1413},
			{"Arrow", 45.5, 12.3, L["Orgrimmar"], nil, arTex, nil, nil, nil, nil, nil, 0, 1454},
			{"TravelH", 41.4, 17.8, L["Zeppelin to"] .. " " .. L["Warsong Hold"] .. ", " .. L["Borean Tundra"], nil, fHTex, nil, nil},
			{"TravelH", 41.4, 18.7, L["Zeppelin to"] .. " " .. L["Thunder Bluff"] .. ", " .. L["Orgrimmar"], nil, fHTex, nil, nil},
		},
		--[[Mulgore]] [1412] = {
			{"Spirit", 46.5, 55.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 42.6, 78.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 69.0, 60.5, L["The Barrens"], nil, arTex, nil, nil, nil, nil, nil, 4.9, 1413},
			{"Arrow", 37.7, 32.9, L["Thunder Bluff"], L["South"], arTex, nil, nil, nil, nil, nil, 0.9, 1456},
			{"Arrow", 40.5, 20.1, L["Thunder Bluff"], L["North"], arTex, nil, nil, nil, nil, nil, 2.8, 1456},
		},
		--[[The Barrens]] [1413] = {
			{"Dungeon", 46.0, 36.4, L["Wailing Caverns"], L["Dungeon"], dnTex, 17, 21, 10, 16, 80} --[[sum cap was 24]], {"Dungeon", 42.9, 90.2, L["Razorfen Kraul"], L["Dungeon"], dnTex, 24, 27, 17, 23, 80} --[[sum cap was 31]], {"Dungeon", 49.0, 93.9, L["Razorfen Downs"], L["Dungeon"], dnTex, 34, 37, 25, 33, 80} --[[sum cap was 41]],
			{"FlightN", 63.1, 37.2, L["Ratchet"] .. ", " .. L["The Barrens"], nil, tNTex, nil, nil},
			{"FlightH", 51.5, 30.3, L["The Crossroads"] .. ", " .. L["The Barrens"], nil, tHTex, nil, nil},
			{"FlightH", 44.4, 59.2, L["Camp Taurajo"] .. ", " .. L["The Barrens"], nil, tHTex, nil, nil},
			{"TravelN", 63.7, 38.6, L["Boat to"] .. " " .. L["Booty Bay"] .. ", " .. L["Stranglethorn Vale"], nil, fNTex, nil, nil, nil, nil},
			{"Spirit", 50.7, 32.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 60.2, 39.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 45.3, 61.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 45.8, 82.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 41.2, 58.6, L["Mulgore"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 1412},
			{"Arrow", 49.8, 78.4, L["Dustwallow Marsh"], nil, arTex, nil, nil, nil, nil, nil, 4.7, 1445},
			{"Arrow", 44.1, 91.5, L["Thousand Needles"], L["The Great Lift"], arTex, nil, nil, nil, nil, nil, 3, 1441},
			{"Arrow", 36.3, 27.5, L["Stonetalon Mountains"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1442},
			{"Arrow", 48.8, 7.1, L["Ashenvale"], nil, arTex, nil, nil, nil, nil, nil, 0, 1440},
			{"Arrow", 62.6, 19.2, L["Durotar"], nil, arTex, nil, nil, nil, nil, nil, 4.6, 1411},
			{"Arrow", 63.7, 1.5, L["Ashenvale"], L["Southfury River"], arTex, nil, nil, nil, nil, nil, 6.3, 1440},
		},
		--[[Teldrassil]] [1438] = {
			{"FlightA", 58.4, 94.0, L["Rut'theran Village"] .. ", " .. L["Teldrassil"], nil, tATex, nil, nil},
			{"TravelA", 54.9, 96.8, L["Boat to"] .. " " .. L["Auberdine"] .. ", " .. L["Darkshore"], nil, fATex, nil, nil, nil, nil},
			{"Spirit", 58.7, 42.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 56.2, 63.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 36.2, 54.4, L["Darnassus"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1457},
			{"Arrow", 56, 89.9, L["Darnassus"], L["Rut'Theran Village"], arTex, nil, nil, nil, nil, nil, 0.2, 1457},
			-- Rut'theran Village Spirit Healer (56, 92.1)
		},
		--[[Darkshore]] [1439] = {
			{"FlightA", 36.3, 45.6, L["Auberdine"] .. ", " .. L["Darkshore"], nil, tATex, nil, nil},
			{"TravelA", 32.4, 43.8, L["Boat to"] .. " " .. L["Stormwind City"] .. ", " .. L["Elwynn Forest"], nil, fATex, nil, nil, nil, nil},
			{"TravelA", 33.2, 40.1, L["Boat to"] .. " " .. L["Rut'theran Village"] .. ", " .. L["Teldrassil"], nil, fATex, nil, nil, nil, nil},
			{"TravelA", 30.7, 41.0, L["Boat to"] .. " " .. L["Valaar's Berth"] .. ", " .. L["Azuremyst Isle"], nil, fATex, nil, nil},
			{"Spirit", 41.8, 36.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 43.6, 92.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 43.3, 94.0, L["Ashenvale"], nil, arTex, nil, nil, nil, nil, nil, 4, 1440},
			{"Arrow", 37.6, 95, L["Ashenvale"], nil, arTex, nil, nil, nil, nil, nil, 3.1, 1440},
			{"Arrow", 27.7, 92.9, L["Ashenvale"], L["The Zoram Strand"], arTex, nil, nil, nil, nil, nil, 2.5, 1440},
		},
		--[[Ashenvale]] [1440] = {
			{"Dungeon", 14.5, 14.2, L["Blackfathom Deeps"], L["Dungeon"], dnTex, 22, 24, 19, 20, 80}, -- sum cap was 28
			{"FlightA", 34.4, 48.0, L["Astranaar"] .. ", " .. L["Ashenvale"], nil, tATex, nil, nil},
			{"FlightA", 85.0, 43.4, L["Forest Song"] .. ", " .. L["Ashenvale"], nil, tATex, nil, nil},
			{"FlightH", 73.2, 61.6, L["Splintertree Post"] .. ", " .. L["Ashenvale"], nil, tHTex, nil, nil},
			{"FlightH", 12.2, 33.8, L["Zoram'gar Outpost"] .. ", " .. L["Ashenvale"], nil, tHTex, nil, nil},
			{"Spirit", 40.5, 52.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 80.7, 58.4, L["Spirit Healer"], nil, spTex, nil, nil},
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
			{"FlightH", 45.1, 49.1, L["Freewind Post"] .. ", " .. L["Thousand Needles"], nil, tHTex, nil, nil},
			{"Spirit", 30.6, 23.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 68.7, 53.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 74.9, 93.3, L["Tanaris"], nil, arTex, nil, nil, nil, nil, nil, 3.2, 1446},
			{"Arrow", 8.3, 11.9, L["Feralas"], nil, arTex, nil, nil, nil, nil, nil, 0.7, 1444},
			{"Arrow", 32.2, 23.9, L["The Barrens"], L["The Great Lift"], arTex, nil, nil, nil, nil, nil, 5.4, 1413},
		},
		--[[Stonetalon Mountains]] [1442] = {
			{"FlightA", 36.4, 7.2, L["Stonetalon Peak"] .. ", " .. L["Stonetalon Mountains"], nil, tATex, nil, nil},
			{"FlightH", 45.1, 59.8, L["Sun Rock Retreat"] .. ", " .. L["Stonetalon Mountains"], nil, tHTex, nil, nil},
			{"Spirit", 40.3, 5.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 36.4, 75.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 57.5, 61.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 80.2, 92.4, L["The Barrens"], nil, arTex, nil, nil, nil, nil, nil, 3.4, 1413},
			{"Arrow", 30.4, 75.4, L["Desolace"], nil, arTex, nil, nil, nil, nil, nil, 2.7, 1443},
			{"Arrow", 78.2, 42.8, L["Ashenvale"], L["The Talondeep Path"], arTex, nil, nil, nil, nil, nil, 6.1, 1440},
		},
		--[[Desolace]] [1443] = {
			{"Dungeon", 29.1, 62.5, L["Maraudon"], L["Dungeon"], dnTex, 43, 48, 30, 40, 80}, -- sum cap was 52
			{"FlightA", 64.7, 10.5, L["Nijel's Point"] .. ", " .. L["Desolace"], nil, tATex, nil, nil},
			{"FlightH", 21.6, 74.1, L["Shadowprey Village"] .. ", " .. L["Desolace"], nil, tHTex, nil, nil},
			{"Spirit", 50.4, 62.9, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 53.4, 5.9, L["Stonetalon Mountains"], nil, arTex, nil, nil, nil, nil, nil, 5.9, 1442},
			{"Arrow", 41.6, 94.4, L["Feralas"], nil, arTex, nil, nil, nil, nil, nil, 3.3, 1444},
		},
		--[[Feralas]] [1444] = {
			{"FlightA", 30.2, 43.2, L["Feathermoon Stronghold"] .. ", " .. L["Feralas"], nil, tATex, nil, nil},
			{"FlightH", 75.4, 44.4, L["Camp Mojache"] .. ", " .. L["Feralas"], nil, tHTex, nil, nil},
			{"FlightA", 89.5, 45.9, L["Thalanaar"] .. ", " .. L["Feralas"], nil, tATex, nil, nil},
			{"Dungeon", 62.5, 24.9, L["Dire Maul (North)"], L["Dungeon"], dnTex, 57, 60, 45, 54, 80}, -- sum cap was 61
			{"Dungeon", 60.3, 30.2, L["Dire Maul (West)"], L["Dungeon"], dnTex, 57, 60, 45, 54, 80}, -- sum cap was 61
			{"Dungeon", 64.8, 30.2, L["Dire Maul (East)"], L["Dungeon"], dnTex, 55, 58, 45, 54, 80}, -- sum cap was 61
			{"Dungeon", 77.1, 36.9, L["Dire Maul (East) (side entrance)"], L["Dungeon (requires Crescent Key)"], dnTex, 55, 58, 45, 54, 80}, -- sum cap was 61
			{"TravelA", 43.3, 42.8, L["Boat to"] .. " " .. L["Feathermoon Stronghold"] .. ", " .. L["Feralas"], nil, fATex, nil, nil},
			{"TravelA", 31.0, 39.8, L["Boat to"] .. " " .. L["The Forgotten Coast"] .. ", " .. L["Feralas"], nil, fATex, nil, nil},
			{"Spirit", 31.8, 48.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 54.8, 48.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 73.0, 44.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 44.9, 7.7, L["Desolace"], nil, arTex, nil, nil, nil, nil, nil, 6, 1443},
			{"Arrow", 88.7, 41.1, L["Thousand Needles"], nil, arTex, nil, nil, nil, nil, nil, 4.5, 1441},
		},
		--[[Dustwallow Marsh]] [1445] = {
			{"Raid", 52.6, 76.8, L["Onyxia's Lair"], L["Raid"], rdTex, 60, 60, 50, 60, 80},
			{"FlightA", 67.5, 51.3, L["Theramore Isle"] .. ", " .. L["Dustwallow Marsh"], nil, tATex, nil, nil},
			{"FlightH", 35.6, 31.9, L["Brackenwall Village"] .. ", " .. L["Dustwallow Marsh"], nil, tHTex, nil, nil},
			{"FlightN", 42.8, 72.5, L["Mudsprocket"] .. ", " .. L["Dustwallow Marsh"], nil, tNTex, nil, nil},
			{"TravelA", 71.6, 56.4, L["Boat to"] .. " " .. L["Menethil Harbor"] .. ", " .. L["Wetlands"], nil, fATex, nil, nil, nil, nil},
			{"Spirit", 39.5, 31.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 46.6, 57.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 41.2, 74.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 63.6, 42.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 30.0, 47.1, L["The Barrens"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 1413},
		},
		--[[Tanaris]] [1446] = {
			{"Dungeon", 38.7, 20.0, L["Zul'Farrak"], L["Dungeon"], dnTex, 42, 46, 35, 42, 80}, -- sum cap was 50
			{"Dunraid", 65.7, 49.9, L["Caverns of Time"], L["Culling of Stratholme"] .. " (" .. L["req"] .. ": 75)" .. ", " .. L["Black Morass"]  .. " (" .. L["req"] .. ": 65)" .. ",|n" .. L["Hyjal Summit"]  .. " (" .. L["req"] .. ": 70)" .. "," .. L["Old Hillsbrad"]  .. " (" .. L["req"] .. ": 66)", dnTex, 66, 68, nil, 66, 80},
			{"FlightA", 51.0, 29.3, L["Gadgetzan"] .. ", " .. L["Tanaris"], nil, tATex, nil, nil},
			{"FlightH", 51.6, 25.4, L["Gadgetzan"] .. ", " .. L["Tanaris"], nil, tHTex, nil, nil},
			{"Spirit", 53.9, 28.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 49.4, 59.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 69.0, 40.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 63.6, 49.4, L["Spirit Healer"], L["(inside Caverns of Time)"], spTex, nil, nil},
			{"Arrow", 50.6, 24.4, L["Thousand Needles"], nil, arTex, nil, nil, nil, nil, nil, 5.7, 1441},
			{"Arrow", 27.1, 57.7, L["Un'Goro Crater"], nil, arTex, nil, nil, nil, nil, nil, 0.5, 1449},
		},
		--[[Azshara]] [1447] = {
			{"FlightA", 11.9, 77.6, L["Talrendis Point"] .. ", " .. L["Azshara"], nil, tATex, nil, nil},
			{"FlightH", 22.0, 49.6, L["Valormok"] .. ", " .. L["Azshara"], nil, tHTex, nil, nil},
			{"Spirit", 70.4, 16.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 54.3, 71.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 14.0, 78.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 10.6, 75.3, L["Ashenvale"], nil, arTex, nil, nil, nil, nil, nil, 0.9, 1440},
		},
		--[[Felwood]] [1448] = {
			{"FlightA", 62.5, 24.2, L["Talonbranch Glade"] .. ", " .. L["Felwood"], nil, tATex, nil, nil},
			{"FlightH", 34.4, 54.0, L["Bloodvenom Post"] .. ", " .. L["Felwood"], nil, tHTex, nil, nil},
			{"FlightN", 51.4, 82.2, L["Emerald Sanctuary"] .. ", " .. L["Felwood"], nil, tNTex, nil, nil},
			{"Spirit", 49.5, 31.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 56.8, 87.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 65.0, 8.3, L["Winterspring"] .. ", " .. L["Moonglade"], L["Timbermaw Hold"], arTex, nil, nil, nil, nil, nil, 5.9, 1452},
			{"Arrow", 54.5, 89.2, L["Ashenvale"], nil, arTex, nil, nil, nil, nil, nil, 3, 1440},
		},
		--[[Un'Goro Crater]] [1449] = {
			{"FlightN", 45.2, 5.8, L["Marshal's Refuge"] .. ", " .. L["Un'Goro Crater"], nil, tNTex, nil, nil},
			{"Spirit", 45.3, 7.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 50.0, 56.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 80.3, 50.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 70.5, 78.6, L["Tanaris"], nil, arTex, nil, nil, nil, nil, nil, 3.3, 1446},
			{"Arrow", 29.4, 22.3, L["Silithus"], nil, arTex, nil, nil, nil, nil, nil, 0.9, 1451},
		},
		--[[Moonglade]] [1450] =  {
			{"FlightA", 48.1, 67.4, L["Lake Elune'ara"] .. ", " .. L["Moonglade"], nil, tATex, nil, nil},
			{"FlightH", 32.1, 66.6, L["Moonglade"], nil, tHTex, nil, nil},
			{"Spirit", 62.2, 70.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 35.7, 72.4, L["Felwood"] .. ", " .. L["Winterspring"], L["Timbermaw Hold"], arTex, nil, nil, nil, nil, nil, 3, 1448},
		},
		--[[Silithus]] [1451] = {
			{"Raid", 28.6, 92.4, L["Ahn'Qiraj"], L["Ruins of Ahn'Qiraj"] .. ", " .. L["Temple of Ahn'Qiraj"], rdTex, 60, 60, 50, 60, 80},
			{"FlightA", 50.6, 34.5, L["Cenarion Hold"] .. ", " .. L["Silithus"], nil, tATex, nil, nil},
			{"FlightH", 48.7, 36.7, L["Cenarion Hold"] .. ", " .. L["Silithus"], nil, tHTex, nil, nil},
			{"Spirit", 47.2, 37.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 28.2, 87.1, L["Spirit Healer"], "(" .. L["Ahn'Qiraj"] .. ")", spTex, nil, nil},
			{"Spirit", 81.2, 20.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 82.4, 16.0, L["Un'Goro Crater"], nil, arTex, nil, nil, nil, nil, nil, 5.4, 1449},
		},
		--[[Winterspring]] [1452] = {
			{"FlightA", 62.3, 36.6, L["Everlook"] .. ", " .. L["Winterspring"], nil, tATex, nil, nil},
			{"FlightH", 60.5, 36.3, L["Everlook"] .. ", " .. L["Winterspring"], nil, tHTex, nil, nil},
			{"Spirit", 29.0, 43.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 61.5, 35.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 62.7, 61.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 27.9, 34.5, L["Felwood"] .. ", " .. L["Moonglade"], L["Timbermaw Hold"], arTex, nil, nil, nil, nil, nil, 0.7, 1448},
		},
		--[[Orgrimmar]] [1454] = {
			{"Dungeon", 52.6, 49.0, L["Ragefire Chasm"], L["Dungeon"], dnTex, 13, 16, 8, 13, 80}, -- sum cap was 20
			{"FlightH", 45.1, 63.9, L["Valley of Strength"] .. ", " .. L["Orgrimmar"], nil, tHTex, nil, nil},
			{"Arrow", 52.4, 83.7, L["Durotar"], nil, arTex, nil, nil, nil, nil, nil, 3, 1411},
			{"Arrow", 18.1, 60.6, L["The Barrens"], L["Southfury River"], arTex, nil, nil, nil, nil, nil, 2.1, 1413},
			{"TravelH", 38.1, 85.7, L["Blasted Lands"], L["Portal"], pHTex},
		},
		--[[Thunder Bluff]] [1456] = {
			{"FlightH", 47.0, 49.8, L["Central Mesa"] .. ", " .. L["Thunder Bluff"], nil, tHTex, nil, nil},
			{"Spirit", 56.7, 19.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 35.7, 62.8, L["Mulgore"], "South", arTex, nil, nil, nil, nil, nil, 2.0, 1412},
			{"Arrow", 51.3, 31.3, L["Mulgore"], "North", arTex, nil, nil, nil, nil, nil, 5.7, 1412},
			{"TravelH", 23.2, 13.5, L["Blasted Lands"], L["Portal"], pHTex},
			{"TravelH", 15.2, 25.7, L["Zeppelin to"] .. " " .. L["Orgrimmar"] .. ", " .. L["Durotar"], nil, fHTex, nil, nil},
		},
		--[[Darnassus]] [1457] = {
			{"Spirit", 77.7, 25.9, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 30.3, 41.4, L["Teldrassil"], L["Rut'Theran Village"], arTex, nil, nil, nil, nil, nil, 1.5, 1438},
			{"TravelA", 40.5, 81.7, L["Blasted Lands"], L["Portal"], pATex},
			{"Arrow", 84.8, 37.8, L["Teldrassil"], nil, arTex, nil, nil, nil, nil, nil, 5.5, 1438},
		},
		--[[The Exodar]] [1947] = {
			{"FlightA", 68.5, 63.7, L["The Exodar"] .. ", " .. L["Azuremyst Isle"], nil, tATex, nil, nil},
			{"Arrow", 76.0, 55.5, L["Azuremyst Isle"], L["Seat of the Naaru"], arTex, nil, nil, nil, nil, nil, 4.5, 1943},
			{"Arrow", 35.0, 74.8, L["Azuremyst Isle"], L["The Vault of Lights"], arTex, nil, nil, nil, nil, nil, 0.9, 1943},
		},
		--[[Azuremyst Isle]] [1943] = {
			{"FlightA", 31.9, 46.4, L["The Exodar"] .. ", " .. L["Azuremyst Isle"], nil, tATex, nil, nil},
			{"TravelA", 20.3, 54.2, L["Boat to"] .. " " .. L["Auberdine"] .. ", " .. L["Darkshore"], nil, fATex, nil, nil},
			{"Spirit", 39.2, 19.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 47.2, 55.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 77.7, 48.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 36.9, 47.0, L["The Exodar"], L["Seat of the Naaru"], arTex, nil, nil, nil, nil, nil, 1.5, 1947},
			{"Arrow", 24.7, 49.4, L["The Exodar"], L["The Vault of Lights"], arTex, nil, nil, nil, nil, nil, 5.8, 1947},
			{"Arrow", 42.5, 5.4, L["Bloodmyst Isle"], nil, arTex, nil, nil, nil, nil, nil, 0.2, 1950},
		},
		--[[Bloodmyst Isle]] [1950] = {
			{"FlightA", 57.7, 53.9, L["Blood Watch"] .. ", " .. L["Bloodmyst Isle"], nil, tATex, nil, nil},
			{"Spirit", 30.1, 45.9, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 58.1, 57.7, L["Spirit Healer"], nil, spTex, nil, nil},
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
			{"Spirit", 37.2, 24.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 33.6, 58.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 38.3, 67.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 52.1, 60.5, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 60.4, 66.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 69.3, 58.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 74.6, 26.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 62.8, 37.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 61.8, 14.7, L["Spirit Healer"], nil, spTex, nil, nil},
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
			{"Spirit", 22.8, 38.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 27.7, 63.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 60.0, 79.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 54.5, 66.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 57.5, 38.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 64.3, 22.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 86.8, 51.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 68.7, 27.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 40.3, 85.9, L["Terokkar Forest"], L["Razorthorn Trail"], arTex, nil, nil, nil, nil, nil, 2.7, 1952},
			{"Arrow", 6.7, 50.4, L["Zangarmarsh"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 1946},
			{"TravelA", 88.6, 52.8, L["Stormwind City"], L["Portal"], pATex},
			{"TravelH", 88.6, 47.7, L["Orgrimmar"], L["Portal"], pHTex},
			{"Arrow", 89.8, 50.2, L["Blasted Lands"], L["The Dark Portal"], arTex, nil, nil, nil, nil, nil, 4.7, 1419},
		},
		--[[Nagrand]] [1951] = {
			{"FlightA", 54.2, 75.0, L["Telaar"] .. ", " .. L["Nagrand"], nil, tATex, nil, nil},
			{"FlightH", 57.2, 35.2, L["Garadar"] .. ", " .. L["Nagrand"], nil, tHTex, nil, nil},
			{"Spirit", 20.4, 36.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 32.8, 56.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 39.8, 30.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 42.5, 46.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 66.6, 24.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 63.1, 69.3, L["Spirit Healer"], nil, spTex, nil, nil},
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
			{"Spirit", 42.9, 29.4, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 33.8, 65.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 64.8, 66.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 56.6, 83.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 22.7, 55.6, L["Blade's Edge Mountains"], nil, arTex, nil, nil, nil, nil, nil, 1.5, 1949},
		},
		--[[Shadowmoon Valley]] [1948] = {
			{"FlightA", 37.6, 55.4, L["Wildhammer Stronghold"] .. ", " .. L["Shadowmoon Valley"], nil, tATex, nil, nil},
			{"FlightH", 30.2, 29.2, L["Shadowmoon Village"] .. ", " .. L["Shadowmoon Valley"], nil, tHTex, nil, nil},
			{"FlightN", 63.4, 30.4, L["Altar of Sha'tar"] .. ", " .. L["Shadowmoon Valley"], nil, tNTex, nil, nil},
			{"FlightN", 56.2, 57.8, L["Sanctum of the Stars"] .. ", " .. L["Shadowmoon Valley"], nil, tNTex, nil, nil},
			{"Raid", 71.0, 46.4, L["Black Temple"], L["Raid"], rdTex, 70, 70, 70, 70, 80},
			{"Spirit", 32.2, 28.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 39.5, 56.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 57.5, 59.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 63.6, 32.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 65.5, 43.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 65.7, 45.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Arrow", 22.7, 28.6, L["Terokkar Forest"], nil, arTex, nil, nil, nil, nil, nil, 0.8, 1952},
		},
		--[[Shattrath City]] [1955] = {
			{"FlightN", 64.1, 41.1, L["Shattrath City"] .. ", " .. L["Terokkar Forest"], nil, tNTex, nil, nil},
			{"TravelN", 48.5, 42.0, L["Isle of Quel'Danas"], L["Portal"], pNTex},
			{"TravelA", 55.8, 36.5, L["Alliance Cities"], L["Darnassus"] .. ", " .. L["Stormwind"] .. ", " .. L["Ironforge"], pATex},
			{"TravelH", 52.2, 52.9, L["Horde Cities"], L["Thunder Bluff"] .. ", " .. L["Orgrimmar"] .. ", " .. L["Undercity"], pHTex},
			{"TravelA", 59.6, 46.7, L["The Exodar"], L["Portal"], pATex},
			{"TravelH", 59.2, 48.4, L["Silvermoon City"], L["Portal"], pHTex},
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
			{"Spirit", 39.9, 21.8, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 44.8, 40.0, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 59.5, 42.6, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 44.6, 71.2, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 62.9, 81.2, L["Spirit Healer"], nil, spTex, nil, nil},
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
			{"Spirit", 17.0, 48.1, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 36.8, 47.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 43.6, 31.7, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 47.5, 50.3, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 65.1, 50.9, L["Spirit Healer"], nil, spTex, nil, nil},
			{"Spirit", 77.2, 64.1, L["Spirit Healer"], nil, spTex, nil, nil},
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
			{"TravelN", 78.9, 53.7, L["Boat to"] .. " " .. L["Moa'ki Harbor"] .. ", " .. L["Dragonblight"], nil, fNTex, nil, nil},
		},

		--[[Crystalsong Forest]] [127] = {
			{"FlightA", 72.2, 81.0, L["Windrunner's Overlook"] .. ", " .. L["Crystalsong Forest"], nil, tATex, nil, nil}, -- Galendror Whitewing
			{"FlightH", 78.5, 50.4, L["Sunreaver's Command"] .. ", " .. L["Crystalsong Forest"], nil, tHTex, nil, nil}, -- Skymaster Baeric
			{"Arrow", 47.1, 68.4, L["Dragonblight"], nil, arTex, nil, nil, nil, nil, nil, 2.7, 115},
			{"Arrow", 58.7, 33.7, L["Icecrown"], nil, arTex, nil, nil, nil, nil, nil, 6.2, 118},
			{"Arrow", 70.4, 35.7, L["The Storm Peaks"], nil, arTex, nil, nil, nil, nil, nil, 5.9, 120},
			{"Arrow", 93.2, 58.4, L["Zul'Drak"], nil, arTex, nil, nil, nil, nil, nil, 4.6, 121},
			{"Arrow", 85.7, 44.7, L["The Storm Peaks"], nil, arTex, nil, nil, nil, nil, nil, 0.3, 120},
		},

		--[[Dalaran]] [125] = {
			{"FlightN", 72.2, 45.8, L["Dalaran"], nil, tNTex, nil, nil}, -- Aludane Whitecloud
			{"Dungeon", 66.8, 68.2, L["The Violet Hold"], L["Dungeon"], dnTex, 75, 77, 73},
			{"TravelA", 37.8, 62.2, L["Portals"], L["Stormwind"] .. ", " .. L["Ironforge"] .. ", " .. L["Darnassus"] .. ", " .. L["Exodar"] .. ", " .. L["Shattrath"], pATex},
			{"TravelH", 57.8, 24.5, L["Portals"], L["Orgrimmar"] .. ", " .. L["Undercity"] .. ", " .. L["Shattrath"] .. ", " .. L["Thunder Bluff"] .. ", " .. L["Silvermoon"], pHTex},
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
			{"Raid", 87.4, 51.1, L["Naxxramas"], L["Raid"], rdTex, 80, 80, 77, 77, 80},
			{"Dungeon", 26.2, 49.6,
				L["Azjol-Nerub"], L["Azjol-Nerub"]  .. " (72-74) (" .. L["req"] .. ": 70) (" .. L["sum"] .. ": 70-80)" .. "|n" ..
				L["The Old Kingdom"]  .. " (73-75) (" .. L["req"] .. ": 71) (" .. L["sum"] .. ": 70-80)",
				dnTex, 72, 75},
			{"Arrow", 92.3, 64.4, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 4.8, 116},
			{"Arrow", 88.8, 24.4, L["Zul'Drak"], nil, arTex, nil, nil, nil, nil, nil, 5.6, 121},
			{"Arrow", 61.1, 10.5, L["Crystalsong Forest"], nil, arTex, nil, nil, nil, nil, nil, 5.6, 127},
			{"Arrow", 12.4, 55.7, L["Borean Tundra"], nil, arTex, nil, nil, nil, nil, nil, 1.9, 114},
			{"TravelN", 49.6, 78.4, L["Boat to"] .. " " .. L["Kamagua"] .. ", " .. L["Howling Fjord"], nil, fNTex, nil, nil},
			{"TravelN", 47.9, 78.7, L["Boat to"] .. " " .. L["Unu'pe"] .. ", " .. L["Borean Tundra"], nil, fNTex, nil, nil},
		},

		--[[Grizzly Hills]] [116] = {
			{"FlightA", 31.3, 59.1, L["Amberpine Lodge"] .. ", " .. L["Grizzly Hills"], nil, tATex, nil, nil}, -- Vana Grey
			{"FlightA", 59.9, 26.7, L["Westfall Brigade"] .. ", " .. L["Grizzly Hills"], nil, tATex, nil, nil}, -- Samuel Clearbook
			{"FlightH", 65.0, 46.9, L["Camp Oneqwah"] .. ", " .. L["Grizzly Hills"], nil, tHTex, nil, nil}, -- Makki Wintergale
			{"FlightH", 22.0, 64.4, L["Conquest Hold"] .. ", " .. L["Grizzly Hills"], nil, tHTex, nil, nil}, -- Kragh
			{"Dungeon", 17.5, 27.0, L["Drak'Tharon Keep"], L["Dungeon"], dnTex, 74, 76, 72, 72, 80},
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
			{"Dungeon", 58.8, 48.3, L["Utgarde Keep"], L["Dungeon"]  .. " (" .. L["req"] .. ": 67) (" .. L["sum"] .. ": 68-80)", dnTex, 69, 72},
			{"Dungeon", 57.3, 46.8, L["Utgarde Pinnacle"], L["Dungeon"]  .. " (" .. L["req"] .. ": 75) (" .. L["sum"] .. ": 78-80)", dnTex, 79, 80},
			{"Arrow", 24.7, 11.4, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 0.3, 116},
			{"Arrow", 53.7, 2.7, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 0.0, 116},
			{"Arrow", 72.9, 2.9, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 0.7, 116},
			{"TravelN", 23.5, 57.8, L["Boat to"] .. " " .. L["Moa'ki Harbor"] .. ", " .. L["Dragonblight"], nil, fNTex, nil, nil},
		},

		--[[Icecrown]] [118] = {
			{"FlightN", 87.8, 78.1, L["The Argent Vanguard"] .. ", " .. L["Icecrown"], nil, tNTex, nil, nil}, -- Aedan Moran
			{"FlightN", 72.6, 22.8, L["Argent Tournament Grounds"] .. ", " .. L["Icecrown"], nil, tNTex, nil, nil}, -- Helidan Lightwing
			{"FlightN", 79.3, 72.3, L["Crusaders' Pinnacle"] .. ", " .. L["Icecrown"], nil, tNTex, nil, nil}, -- Penumbrius
			{"FlightN", 19.3, 47.8, L["Death's Rise"] .. ", " .. L["Icecrown"], nil, tNTex, nil, nil}, -- Dreadwind
			{"FlightN", 43.8, 24.4, L["The Shadow Vault"] .. ", " .. L["Icecrown"], nil, tNTex, nil, nil}, -- Morlia Doomwing
			{"Raid", 53.3, 85.5, L["Icecrown Citadel"], L["Raid"], rdTex, 80, 80, 80},
			{"Dungeon", 52.6, 89.4, L["The Frozen Halls"],
				L["The Forge of Souls"] .. " (80) (" .. L["req"] .. ": 78)" .. "|n" ..
				L["The Pit of Saron"] .. " (80) (" .. L["req"] .. ": 78)" .. "|n" ..
				L["The Halls of Reflection"] .. " (80) (" .. L["req"] .. ": 78)",
			dnTex, 80, 80},
			{"Dungeon", 74.2, 20.5, L["Trial of the Champion"], L["Dungeon"], dnTex, 80, 80, 80},
			{"Raid", 75.1, 21.8, L["Trial of the Crusader"], L["Raid"], rdTex, 80, 80, 80},
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
			{"Dungeon", 39.6, 26.9, L["Halls of Stone"], L["Dungeon"], dnTex, 77, 79, 73, 75, 80},
			{"Dungeon", 45.4, 21.4, L["Halls of Lightning"], L["Dungeon"], dnTex, 78, 80, 75, 75, 80},
			{"Raid", 41.6, 17.8, L["Ulduar"], L["Raid"], rdTex, 80, 80, 80, 75, 80},
			{"Arrow", 30.4, 93.8, L["Crystalsong Forest"], nil, arTex, nil, nil, nil, nil, nil, 2.4, 127},
			{"Arrow", 37.8, 90.2, L["Crystalsong Forest"], nil, arTex, nil, nil, nil, nil, nil, 3.6, 127},
			{"Arrow", 22.2, 36.4, L["Icecrown"], L["Head down the mountain from here."], arTex, nil, nil, nil, nil, nil, 2.1, 118},
		},

		--[[Wintergrasp]] [123] = {
			{"FlightA", 72.0, 31.0, L["Valiance Landing Camp"] .. ", " .. L["Wintergrasp"], nil, tATex, nil, nil}, -- Arzo Safeflight
			{"FlightH", 21.6, 34.9, L["Warsong Camp"] .. ", " .. L["Wintergrasp"], nil, tHTex, nil, nil}, -- Herzo Safeflight
			{"Raid", 50.5, 16.4, L["Vault of Archavon"], L["Raid"], rdTex, 80, 80, 80, 80, 80},
		},

		--[[Zul'Drak (*)]] [121] = {
			{"FlightN", 14.0, 73.6, L["Ebon Watch"] .. ", " .. L["Zul'Drak"], nil, tNTex, nil, nil}, -- Baneflight
			{"FlightN", 32.2, 74.4, L["Light's Breach"] .. ", " .. L["Zul'Drak"], nil, tNTex, nil, nil}, -- Danica Saint
			{"FlightN", 41.6, 64.4, L["The Argent Stand"] .. ", " .. L["Zul'Drak"], nil, tNTex, nil, nil}, -- Gurric
			{"FlightN", 70.5, 23.3, L["Gundrak"] .. ", " .. L["Zul'Drak"], nil, tNTex, nil, nil}, -- Rafae
			{"FlightN", 60.0, 56.7, L["Zim'Torga"] .. ", " .. L["Zul'Drak"], nil, tNTex, nil, nil}, -- Maaka
			{"Dungeon", 29.0, 83.9, L["Drak'Tharon Keep"], L["Dungeon"], dnTex, 74, 76, 72, 72, 80},
			{"Dungeon", 76.2, 21.1, L["Gundrak"], L["Dungeon"], dnTex, 76, 78, 73, 74, 80},
			{"Dungeon", 81.2, 28.9, L["Gundrak (rear entrance)"], L["Dungeon"], dnTex, 76, 78, 73, 74, 80},
			{"Arrow", 71.2, 78.3, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 4.0, 116},
			{"Arrow", 55.2, 91, L["Grizzly Hills"], nil, arTex, nil, nil, nil, nil, nil, 3.8, 116},
			{"Arrow", 29, 87.1, L["Grizzly Hills"], L["Drak'Tharon Keep"], arTex, nil, nil, nil, nil, nil, 3.2, 116},
			{"Arrow", 17.6, 85.3, L["Dragonblight"], nil, arTex, nil, nil, nil, nil, nil, 2.4, 115},
			{"Arrow", 12.5, 67.1, L["Crystalsong Forest"], nil, arTex, nil, nil, nil, nil, nil, 1.6, 127},
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
