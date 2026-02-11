local addonName, addon = ...
-- get a reference to localization entries
local L = addon.L
-- use this array to share variables between addon files
addon.V = {}
local V = addon.V
-- use this to share methods between addon files
addon.M = {}
local M = addon.M

----------------------
-- SHARED FUNCTIONS --
----------------------

function M.GILDUMP (o)
	if type(o) == 'table' then
		local s = '{ '
		
		for key, value in pairs(o) do
			if type(key) ~= 'number' then
				key = '"'..key..'"'
			end
			s = s .. '['..key..'] = ' .. M.GILDUMP(value) .. ','
		end
		
		return s .. '} '
	else
		return tostring(o)
	end
end

function M.GILDUMP2 (tbl, indent)
	if not indent then
		indent = 0
	end

	local formatting
	
	for key, value in pairs(tbl) do
		formatting = string.rep("  ", indent) .. key .. ": "
		if type(value) == "table" then
			print(formatting)
			M.GILDUMP2(value, indent + 1)
		elseif type(value) == 'boolean' then
			print(formatting .. tostring(value))
		elseif type(value) == 'function' then
			print(formatting .. "function")
		else
			print(formatting .. value)
		end
	end
end

function M.popWord (str, ch)

	local idx = string.find(str, ch, 1, true)
	
	if idx == nil then
		return "", str
	end
	
	return string.sub(str, 1, idx - 1), string.sub(str, idx + 1)
end

function M.trim (str)

	local n = str:find"%S"
	return n and str:match(".*%S", n) or ""
 
end

function M.dateToJulianDate (dateStr)
	
	if dateStr == nil then
		return 0
	end

	local monthList = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }
	local words     = {}

	for word in dateStr:gmatch("%w+") do
		table.insert(words, word)
	end
	
	local day   = tonumber(words[1])
	local year  = tonumber(words[3])
	local month = 0

	for key, value in pairs(monthList) do
	
		if value == words[2] then
			month = tonumber(key)
			
			break
		end
	end

	--print ("monthStr="..monthStr.." month="..month.." day="..day.." year="..year)

	if (not month) or (not day) or (not year) or (month < 1) or (month > 12) or (day < 1) or (day > 31) or (year < 2014) then
		return 0
	end
	
	local calc1 = (month - 14) / 12
	local calc2 = day - 32075 + (1461 * (year + 4800 + calc1) / 4)
	
	calc2 = calc2 + (367 * (month - 2 - calc1 * 12) / 12)
	calc2 = calc2 - (3 * ((year + 4900 + calc1) / 100) / 4)
	
	return calc2
end

function M.daysFromToday (dateStr)

	local addDate = M.dateToJulianDate(dateStr)
	local today   = M.dateToJulianDate(date("%d %b %Y"))
	
	if addDate == 0 then
		return -1
	else
	
		if addDate < today then
			return math.floor(today - addDate)
		else
			return math.floor(addDate - today)
		end
	end
end

function M.strDown (str)

	local len    = strlen(str)
	local count  = 1
	local res    = ""
	local c
	local char   = string.char
	local lower  = string.lower
	
	while count <= len do
		c = strbyte(str, count)
		
		if c < 32 or c > 126 then
			res = res .. char(c)
		else
			res = res .. lower(char(c))
		end
		
		count = count + 1
	end
	
	return res
end

function M.Proper (name, okSpaces)

	if name == nil then return nil end
	if name == "" then return nil end
	
	local len    = strlen(name)
	local count  = 1
	local res    = ""
	local needUp = true
	local gotOP  = false
	local c
	local char   = string.char
	local upper  = string.upper
	local lower  = string.lower
	local sb     = strbyte
	
	while count <= len do
		c = sb(name, count)
				
		if c < 32 or c > 126 then
			res    = res .. char(c)
			needUp = false
		else
			if c ~= 32 or okSpaces == true then
				if needUp then
					res = res .. upper(char(c))
				else
					res = res .. lower(char(c))
				end
			
				gotOP  = (c == 40 or gotOP) and (c ~= 41)
				needUp = (c == 32 or c == 45 or gotOP == true)
			end
		end
		
		count  = count + 1
	end
	
	return res
end

function M.GetWord (str, wordnumber)

	local len     = strlen(str)
	local count   = 1
	local res     = ""
	local words   = 0
	local nextInc = true
	local c
	
	while count <= len do
		if nextInc then
			words = words + 1
			
			if words > wordnumber then
				break
			end
		end
		
		c = strbyte(str, count)
		
		nextInc = (c == 32) and nextInc == false
		
		if words == wordnumber and c ~= 32 then
			res = res .. string.char(c)
		end
		
		count = count + 1
	end
	
	return res
end

function M.prettyServer (origName)

	if origName == nil then return nil end

	local name = origName

	if name == "Aeriepeak" then name = "Aerie Peak"
	elseif name == "Aggra(português)" then name = "Aggra (Português)"
	elseif name == "Ahn'qiraj" then name = "Ahn'Qiraj"
	elseif name == "Al'akir" then name = "Al'Akir"
	elseif name == "Altarofstorms" then name = "Altar of Storms"
	elseif name == "Alteracmountains" then name = "Alterac Mountains"
	elseif name == "Aman'thul" then name = "Aman'Thul"
	elseif name == "Arathibasin" then name = "Arathi Basin"
	elseif name == "Arcanitereaper" then name = "Arcanite Reaper"
	elseif name == "Area52" then name = "Area 52"
	elseif name == "Argentdawn" then name = "Argent Dawn"
	elseif name == "Arugal(au)" then name = "Arugal (AU)"
	elseif name == "Azjol-nerub" then name = "Azjol-Nerub"
	elseif name == "Blackdragonflight" then name = "Black Dragonflight"
	elseif name == "Blackwaterraiders" then name = "Blackwater Raiders"
	elseif name == "Blackwinglair" then name = "Blackwing Lair"
	elseif name == "Blade'sedge" then name = "Blade's Edge"
	elseif name == "Bleedinghollow" then name = "Bleeding Hollow"
	elseif name == "Bloodfurnace" then name = "Blood Furnace"
	elseif name == "Bloodsailbuccaneers" then name = "Bloodsail Buccaneers"
	elseif name == "Bootybay" then name = "Booty Bay"
	elseif name == "Boreantundra" then name = "Borean Tundra"
	elseif name == "Bronzedragonflight" then name = "Bronze Dragonflight"
	elseif name == "Burningblade" then name = "Burning Blade"
	elseif name == "Burninglegion" then name = "Burning Legion"
	elseif name == "Burningsteppes" then name = "Burning Steppes"
	elseif name == "Cenarioncircle" then name = "Cenarion Circle"
	elseif name == "Chamberofaspects" then name = "Chamber of Aspects"
	elseif name == "Chantséternels" then name = "Chants éternels"
	elseif name == "Chaosbolt" then name = "Chaos Bolt"
	elseif name == "Chillwindpoint" then name = "Chillwind Point"
	elseif name == "Chromie(ru)" then name = "Chromie (RU)"
	elseif name == "Colinaspardas" then name = "Colinas Pardas"
	elseif name == "Confrérieduthorium" then name = "Confrérie du Thorium"
	elseif name == "Conseildesombres" then name = "Conseil des Ombres"
	elseif name == "Crusaderstrike" then name = "Crusader Strike"
	elseif name == "Crystalpinestinger" then name = "Crystalpine Stinger"
	elseif name == "C'thun" then name = "C'Thun"
	elseif name == "Cultedelarivenoire" then name = "Culte de la Rive noire"
	elseif name == "Darkiron" then name = "Dark Iron"
	elseif name == "Darkmoonfaire" then name = "Darkmoon Faire"
	elseif name == "Daskonsortium" then name = "Das Konsortium"
	elseif name == "Dassyndikat" then name = "Das Syndikat"
	elseif name == "Dath'remar" then name = "Dath'Remar"
	elseif name == "Defiasbrotherhood" then name = "Defias Brotherhood"
	elseif name == "Defiaspillager" then name = "Defias Pillager"
	elseif name == "Demonfallcanyon" then name = "Demon Fall Canyon"
	elseif name == "Demonsoul" then name = "Demon Soul"
	elseif name == "Derabyssischerat" then name = "Der abyssische Rat"
	elseif name == "Dermithrilorden" then name = "Der Mithrilorden"
	elseif name == "Derratvondalaran" then name = "Der Rat von Dalaran"
	elseif name == "Deviatedelight" then name = "Deviate Delight"
	elseif name == "Diealdor" then name = "Die Aldor"
	elseif name == "Diearguswacht" then name = "Die Arguswacht"
	elseif name == "Dieewigewacht" then name = "Die ewige Wacht"
	elseif name == "Dienachtwache" then name = "Die Nachtwache"
	elseif name == "Diesilbernehand" then name = "Die Silberne Hand"
	elseif name == "Dietodeskrallen" then name = "Die Todeskrallen"
	elseif name == "Dragon'scall" then name = "Dragon's Call"
	elseif name == "Drak'tharon" then name = "Drak'Tharon"
	elseif name == "Drek'thar" then name = "Drek'Thar"
	elseif name == "Dunmodr" then name = "Dun Modr"
	elseif name == "Dunmorogh" then name = "Dun Morogh"
	elseif name == "Earthenring" then name = "Earthen Ring"
	elseif name == "Echoisles" then name = "Echo Isles"
	elseif name == "Eldre'thalas" then name = "Eldre'Thalas"
	elseif name == "Emeralddream" then name = "Emerald Dream"
	elseif name == "Fengus'ferocity" then name = "Fengus' Ferocity"
	elseif name == "Festungderstürme" then name = "Festung der Stürme"
	elseif name == "Flamegor(ru)" then name = "Flamegor (RU)"
	elseif name == "Grimbatol" then name = "Grim Batol"
	elseif name == "Grizzlyhills" then name = "Grizzly Hills"
	elseif name == "Harbingerofdoom(ru)" then name = "Harbinger of Doom (RU)"
	elseif name == "Howlingfjord" then name = "Howling Fjord"
	elseif name == "Hydraxianwaterlords" then name = "Hydraxian Waterlords"
	elseif name == "Jubei'thos" then name = "Jubei'Thos"
	elseif name == "Kel'thuzad" then name = "Kel'Thuzad"
	elseif name == "Khazmodan" then name = "Khaz Modan"
	elseif name == "Kirintor" then name = "Kirin Tor"
	elseif name == "Krolblade" then name = "Krol Blade"
	elseif name == "Kultiras" then name = "Kul Tiras"
	elseif name == "Kultderverdammten" then name = "Kult der Verdammten"
	elseif name == "Lacroisadeécarlate" then name = "La Croisade écarlate"
	elseif name == "Laughingskull" then name = "Laughing Skull"
	elseif name == "Lavalash" then name = "Lava Lash"
	elseif name == "Leishen" then name = "Lei Shen"
	elseif name == "Lesclairvoyants" then name = "Les Clairvoyants"
	elseif name == "Lessentinelles" then name = "Les Sentinelles"
	elseif name == "Lichking" then name = "Lich King"
	elseif name == "Lightning'sblade" then name = "Lightning's Blade"
	elseif name == "Light'shope" then name = "Light's Hope"
	elseif name == "Livingflame" then name = "Living Flame"
	elseif name == "Lonewolf" then name = "Lone Wolf"
	elseif name == "Loserrantes" then name = "Los Errantes"
	elseif name == "Maladath(au)" then name = "Maladath (AU)"
	elseif name == "Mal'ganis" then name = "Mal'Ganis"
	elseif name == "Marécagedezangar" then name = "Marécage de Zangar"
	elseif name == "Mirageraceway" then name = "Mirage Raceway"
	elseif name == "Mok'nathal" then name = "Mok'Nathal"
	elseif name == "Mol'dar'smoxie" then name = "Mol'dar's Moxie"
	elseif name == "Moonguard" then name = "Moon Guard"
	elseif name == "Nek'rosh" then name = "Nek'Rosh"
	elseif name == "Nethergardekeep" then name = "Nethergarde Keep"
	elseif name == "Oldblanchy" then name = "Old Blanchy"
	elseif name == "Ookook" then name = "Ook Ook"
	elseif name == "Orderofthecloudserpent" then name = "Order of the Cloud Serpent"
	elseif name == "Penance(au)" then name = "Penance (AU)"
	elseif name == "Penance(season)" then name = "Penance (Season)"
	elseif name == "Pozzodell'eternità" then name = "Pozzo dell'Eternità"
	elseif name == "Pyrewoodvillage" then name = "Pyrewood Village"
	elseif name == "Quel'thalas" then name = "Quel'Thalas"
	elseif name == "Remulos(au)" then name = "Remulos (AU)"
	elseif name == "Rhok'delar(ru)" then name = "Rhok'delar (RU)"
	elseif name == "Scarletcrusade" then name = "Scarlet Crusade"
	elseif name == "Scarshieldlegion" then name = "Scarshield Legion"
	elseif name == "Shadowcouncil" then name = "Shadow Council"
	elseif name == "Shadowstrike(au)" then name = "Shadowstrike (AU)"
	elseif name == "Shadowstrike(season)" then name = "Shadowstrike (Season)"
	elseif name == "Shatteredhalls" then name = "Shattered Halls"
	elseif name == "Shatteredhand" then name = "Shattered Hand"
	elseif name == "Shimmeringflats" then name = "Shimmering Flats"
	elseif name == "Silverhand" then name = "Silver Hand"
	elseif name == "Silverwinghold" then name = "Silverwing Hold"
	elseif name == "Sistersofelune" then name = "Sisters of Elune"
	elseif name == "Skullrock" then name = "Skull Rock"
	elseif name == "Slip'kik'ssavvy" then name = "Slip'kik's Savvy"
	elseif name == "Steamwheedlecartel" then name = "Steamwheedle Cartel"
	elseif name == "Sundownmarsh" then name = "Sundown Marsh"
	elseif name == "Tarrenmill" then name = "Tarren Mill"
	elseif name == "Templenoir" then name = "Temple noir"
	elseif name == "Tenstorms" then name = "Ten Storms"
	elseif name == "Theforgottencoast" then name = "The Forgotten Coast"
	elseif name == "Themaelstrom" then name = "The Maelstrom"
	elseif name == "Thescryers" then name = "The Scryers"
	elseif name == "Thesha'tar" then name = "The Sha'tar"
	elseif name == "Theunderbog" then name = "The Underbog"
	elseif name == "Theventureco" then name = "The Venture Co"
	elseif name == "Thoriumbrotherhood" then name = "Thorium Brotherhood"
	elseif name == "Throk'feroth" then name = "Throk'Feroth"
	elseif name == "Tolbarad" then name = "Tol Barad"
	elseif name == "Twilight'shammer" then name = "Twilight's Hammer"
	elseif name == "Twistingnether" then name = "Twisting Nether"
	elseif name == "Un'goro" then name = "Un'Goro"
	elseif name == "Wildgrowth" then name = "Wild Growth"
	elseif name == "Worldtree" then name = "World Tree"
	elseif name == "Wyrmrestaccord" then name = "Wyrmrest Accord"
	elseif name == "Wyrmthalak(ru)" then name = "Wyrmthalak (RU)"
	elseif name == "Yojamba(au)" then name = "Yojamba (AU)"
	elseif name == "Zandalartribe" then name = "Zandalar Tribe"
	elseif name == "Zealotblade" then name = "Zealot Blade"
	elseif name == "Zirkeldescenarius" then name = "Zirkel des Cenarius"
	else
		local len  = strlen(origName)
		local sb   = strbyte
		local char = string.char
		local c1
		local c
		local gotP = false
		
		name = ""
	
		for count = 1, len do
			c  = sb(origName, count)
			c1 = sb(origName, count+1) or 32
		
			if ((c1 > 47 and c1 < 58) or (c1 > 64 and c1 < 91) or (c1 == 40)) and gotP == false then
				name = name .. char(c) .. " "
			
				if (c1 == 40) or (c1 > 47 and c1 < 58) then gotP = true end
			else
				name = name .. char(c)
			end
		end
	end

	return name
end

function M.getServer (name, def)

	local index = string.find(name, "-", 1, true)
	
	if index ~= nil then
		return string.sub(name, index + 1, string.len(name))
	end
	
	if def then return def else return V.serverName end
end

function M.removeServer (name, strict)
	
	if name == nil then
		return nil
	end

	result = name
	
	local index = string.find(name, "-", 1, true)
	
	if strict == nil then
		strict = false
	end
	
	if index ~= nil then
		local server = M.Proper(string.sub(name, index + 1, string.len(name)));
		
		if strict == true or server == M.Proper(V.serverName) then
			result = string.sub(name, 1, index - 1)
		end
	end
	
	return result	
end

function M.addServer (name)

	if not name then return nil end

	if string.find(name, "-", 1, true) == nil then
		return name .. "-" .. V.serverName
	end
	
	return name
end

----------------------
-- SHARED VARIABLES --
----------------------

V.serverName		= M.Proper(GetRealmName())
V.playerName		= M.addServer(GetUnitName("player"), true)
V.wowIsERA			= false
V.wowIsTBC			= false
V.wowIsWrath		= false
V.wowIsCata			= false
V.wowIsMOP			= false
V.wowIsRetail		= false
V.wowLongName		= "Unknown"
V.wowName			= V.wowLongName

-- Color yellow: ffff0000
-- Color white: ffffff00
-- Color red: 00ff0000
-- Color Horde red: ffe60000
-- Color Cyan: ff69CCF0

-- Set wow version information

local toc, toc, toc, toc = GetBuildInfo()

if (toc >= 10000 and toc <= 19999) then
	V.wowIsERA	= true
	V.wowLongName	= "Classic Era"
	V.wowName		= "Era"
elseif (toc >= 20000 and toc <= 29999) then
	V.wowIsTBC	= true
	V.wowLongName	= "The Burning Crusade"
	V.wowName		= "TBC"
elseif (toc >= 30000 and toc <= 39999) then
	V.wowIsWrath	= true
	V.wowLongName	= "Wrath of the Lich King"
	V.wowName		= "WOTLK"
elseif (toc >= 40000 and toc <= 49999) then
	V.wowIsCata	= true
	V.wowLongName	= "Cataclysm"
	V.wowName		= "Cata"
elseif (toc >= 50000 and toc <= 59999) then
	V.wowIsMOP	= true
	V.wowLongName	= "Mists of Pandaria"
	V.wowName		= "MOP"
else
	V.wowIsRetail = true
end

if (toc >= 100000 and toc < 109999) then
	V.wowLongName = "Dragonflight"
	V.wowName		= "DF"
elseif (toc >= 110000 and toc < 119999) then
	V.wowLongName = "The War Within"
	V.wowName		= "TWW"
elseif (toc >= 120000 and toc < 129999) then
	V.wowLongName = "Midnight"
	V.wowName		= "MN"
end

V.wowIsClassic = (V.wowIsRetail == false)
