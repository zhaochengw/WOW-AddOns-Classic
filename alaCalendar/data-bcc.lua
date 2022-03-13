--[[--
	by ALA @ 163UI
--]]--

if WOW_PROJECT_ID ~= WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
	return;
end

local ADDON, NS = ...;
local ARTWORK_PATH = "Interface\\AddOns\\alaCalendar\\ARTWORK\\";

--	fixed_cycle		1_first_seen,	2_cycle,		3_nil,			4_nil,		5_dur,	6_tex_start,	7_curtain,	8_tex_end,	9_tex_start_coord,	10_curtain_coord,	11_tex_end_coord
--	month_week_day	1_first_seen,	2_cycle_month,	3_check_day,	4_latency,	5_dur,	6_tex_start,	7_curtain,	8_tex_end,	9_tex_start_coord,	10_curtain_coord,	11_tex_end_coord
--	using UTC-0
NS.milestone = {
	--	Vanilla
		--	P1	MC, ONY			--	Global Time	--	UTC-8	2019-08-27 7:00
		["MC"] = {
			phase = 1,
			type = "fixed_cycle",
			-1,
			7 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-moltencore",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 60,
		},
		["ONY"] = {
			phase = 1,
			type = "fixed_cycle",
			-1,
			5 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-onyxiaencounter",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 60,
		},
		--	DM									--	UTC-8	2019-10-16-Wed
		--	P2	No more RAID					--	UTC-8	2019-11-15-Fri
		--	BG	Warsong Gulch & Alterac Valley	--	UTC-8	2019-12-12-Thu
		--	P3	BWL								--	Global Time	--	UTC-8	2020-2-13-Thu-7:00	PST	2020-2-12-15:00	EST	2020-2-12:18:00
		["BWL"] = {
			phase = 1,
			type = "fixed_cycle",
			-1,
			7 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-blackwinglair",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 60,
		},
		--	BG	Arathi Basin		--	UTC-8	2020-3-12-Thu
		--	P4	ZG, SILITHUS		--	Global Time	--	UTC-8	2020-4-16-Thu-7:00	PDT	2020-4-16-15:00
		["ZG"] = {
			phase = 1,
			type = "fixed_cycle",
			-1,
			3 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-zulgurub",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 60,
		},
		--	P5
		["TAQ"] = {
			phase = 1,
			type = "fixed_cycle",
			-1,
			7 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-aqtemple",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 60,
		},
		["RAQ"] = {
			phase = 1,
			type = "fixed_cycle",
			-1,
			3 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-aqruins",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 60,
		},
		--	P6
		["NAXX"] = {
			phase = 1,
			type = "fixed_cycle",
			-1,
			7 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-naxxramas",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 60,
		},
	--	TBC
		--	P1
		["Kara"] = {
			phase = 1,
			type = "fixed_cycle",
			-1,
			7 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-karazhan",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 70,
		},
		["Magtheridon"] = {
			phase = 1,
			type = "fixed_cycle",
			-1,
			7 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\Magtheridon's Lair",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 70,
		},
		["Gruul"] = {
			phase = 1,
			type = "fixed_cycle",
			-1,
			7 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-gruulslair",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 70,
		},
		--	P2
		["Serpent"] = {
			phase = 2,
			type = "fixed_cycle",
			-1,
			7 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-serpentshrinecavern",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 70,
		},
		["Tempest"] = {
			phase = 2,
			type = "fixed_cycle",
			-1,
			7 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-tempestkeep",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 70,
		},
		--	P3
		["Hyjal"] = {
			phase = 3,
			type = "fixed_cycle",
			-1,
			7 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-hyjalpast",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 70,
		},
		["BT"] = {
			phase = 3,
			type = "fixed_cycle",
			-1,
			7 * 86400,
			nil,
			nil,
			0,
			ARTWORK_PATH .. "Milestone\\lfgicon-blacktemple",
			nil,
			nil,
			nil,
			nil,
			nil,
			instance = true,
			min = 70,
		},
		--	P4
		--	P5
	--
	--	Festival
	--	P3	DarkMoon			--	UTC-8	2020-2-7
	["DarkMoon: Terokkar"] = {
		phase = 1,
		type = "month_week_day",
		dst = true,
		-1,
		3,
		7,
		1 * 86400 + 4 * 3600,
		7 * 86400 - 1,
		"interface\\calendar\\holidays\\calendar_darkmoonfaireterokkarstart",
		"interface\\calendar\\holidays\\calendar_darkmoonfaireterokkarongoing",
		"interface\\calendar\\holidays\\calendar_darkmoonfaireterokkarend",
		{ 0.0, 91 / 128, 0.0, 91 / 128, },
		{ 0.0, 91 / 128, 0.0, 91 / 128, },
		{ 0.0, 91 / 128, 0.0, 91 / 128, },
		festival = true,
		min = 0,
	},
	["DarkMoon: Mulgore"] = {
		phase = 1,
		type = "month_week_day",
		dst = true,
		-1,
		3,
		7,
		1 * 86400 + 4 * 3600,
		7 * 86400 - 1,
		"interface\\calendar\\holidays\\calendar_darkmoonfairemulgorestart",
		"interface\\calendar\\holidays\\calendar_darkmoonfairemulgoreongoing",
		"interface\\calendar\\holidays\\calendar_darkmoonfairemulgoreend",
		{ 0.0, 91 / 128, 0.0, 91 / 128, },
		{ 0.0, 91 / 128, 0.0, 91 / 128, },
		{ 0.0, 91 / 128, 0.0, 91 / 128, },
		festival = true,
		min = 0,
	},
	["DarkMoon: Elwynn"] = {
		phase = 1,
		type = "month_week_day",
		dst = true,
		-1,
		3,
		7,
		1 * 86400 + 4 * 3600,
		7 * 86400 - 1,
		"interface\\calendar\\holidays\\calendar_darkmoonfaireelwynnstart",
		"interface\\calendar\\holidays\\calendar_darkmoonfaireelwynnongoing",
		"interface\\calendar\\holidays\\calendar_darkmoonfaireelwynnend",
		{ 0.0, 91 / 128, 0.0, 91 / 128, },
		{ 0.0, 91 / 128, 0.0, 91 / 128, },
		{ 0.0, 91 / 128, 0.0, 91 / 128, },
		festival = true,
		min = 0,
	},
	--	P4	Fishing Extravaganza
	["Fishing Extravaganza"] = {
		phase = 1,
		type = "fixed_cycle",
		dst = true,
		-1,
		7 * 86400,
		nil,
		nil,
		7200 - 1,
		"interface\\calendar\\holidays\\calendar_fishingextravaganza",
		nil,
		nil,
		{ 0.0, 91 / 128, 0.0, 91 / 128, },
		nil,
		nil,
		festival = true,
		texture_channel2 = true,
		min = 0,
	},
	--	Server Time	--	03-13	04-10	05-08	Warsong Gulch
	["Warsong Gulch"] = {
		phase = 1,
		type = "fixed_cycle",
		dst = true,
		-1,
		28 * 86400,
		nil,
		nil,
		4 * 86400 - 1,
		"interface\\glues\\loadingscreens\\loadscreenwarsonggulch",		-- "interface\\lfgframe\\lfgicon-battleground",
		"interface\\calendar\\holidays\\calendar_weekendmistsofpandariaongoing",
		nil,
		nil,
		{ 0.0, 91 / 128, 91 / 128, 0.0, },
		nil,
		festival = true,
		curtain_channel2 = true,
		min = 0,
	},
	--	Server Time	--	03-20	04-17	05-15	Arathi Basin
	["Arathi Basin"] = {
		phase = 1,
		type = "fixed_cycle",
		dst = true,
		-1,
		28 * 86400,
		nil,
		nil,
		4 * 86400 - 1,
		"interface\\glues\\loadingscreens\\loadscreenarathibasin",		-- "interface\\calendar\\holidays\\calendar_volunteerguardday",
		"interface\\calendar\\holidays\\calendar_weekendpvpskirmishongoing",
		nil,
		nil,
		{ 0.0, 91 / 128, 91 / 128, 0.0, },
		nil,
		festival = true,
		curtain_channel2 = true,
		min = 0,
	},
	--	Server Time	--	03-27	04-24	05-22	None
	--	Server Time	--	04-03	05-01	05-29	Alterac Valley
	["Alterac Valley"] = {
		phase = 1,
		type = "fixed_cycle",
		dst = true,
		-1,
		28 * 86400,
		nil,
		nil,
		4 * 86400 - 1,
		"interface\\glues\\loadingscreens\\loadscreenpvpbattleground",	-- "interface\\lfgframe\\lfgicon-battleground",
		"interface\\calendar\\holidays\\calendar_weekendworldquestongoing",
		nil,
		nil,
		{ 0.0, 91 / 128, 91 / 128, 0.0, },
		nil,
		festival = true,
		curtain_channel2 = true,
		min = 0,
	},
	["Eye of the Storm"] = {
		phase = 1,
		type = "fixed_cycle",
		dst = true,
		-1,
		28 * 86400,
		nil,
		nil,
		4 * 86400 - 1,
		"interface\\glues\\loadingscreens\\loadscreenoutland",	-- "interface\\lfgframe\\lfgicon-battleground",
		"interface\\calendar\\holidays\\calendar_weekendwrathofthelichkingongoing",
		nil,
		nil,
		{ 0.0, 91 / 128, 91 / 128, 0.0, },
		nil,
		festival = true,
		curtain_channel2 = true,
		min = 0,
	},
	["ala"] = {
		phase = 0,
		type = "fixed_cycle",
		1566835200,
		7 * 86400,
		nil,
		nil,
		86400,
		"interface\\lfgframe\\lfgicon-moltencore",
		nil,
		nil,
		instance = true,
		min = 0,
	},
};
NS.milestone_list = {
	"SW",
	"BT",
	"Hyjal",
	"ZAM",
	"Tempest",
	"Serpent",
	"Gruul",
	"Magtheridon",
	"Kara",
	--
	"NAXX",
	"TAQ",
	"BWL",
	"ONY",
	"MC",
	"RAQ",
	"ZG",
	-- "ala",
	"Warsong Gulch",
	"Arathi Basin",
	"Alterac Valley",
	"Eye of the Storm",
	"DarkMoon: Terokkar",
	"DarkMoon: Mulgore",
	"DarkMoon: Elwynn",
	"Fishing Extravaganza",
};

--	实际开放时间的UNIX时间戳
NS.apply_region = {
	[1] = function(region)	--	1 = US Pacific		UTC-8
		NS.milestone["MC"][1] = 18135 * 86400 + 16 * 3600;		--
		NS.milestone["ONY"][1] = 18141 * 86400 + 16 * 3600;		--
		NS.milestone["BWL"][1] = 18310 * 86400 + 16 * 3600;		--
		NS.milestone["ZG"][1] = 18368 * 86400 + 16 * 3600;		--
		NS.milestone["TAQ"][1] = 18471 * 86400 + 16 * 3600;		--
		NS.milestone["RAQ"][1] = 18470 * 86400 + 16 * 3600;		--~
		NS.milestone["NAXX"][1] = 18597 * 86400 + 16 * 3600;	--
		NS.milestone["Kara"][1] = 18779 * 86400 + 16 * 3600;		--
		NS.milestone["Magtheridon"][1] = 18779 * 86400 + 16 * 3600;	--
		NS.milestone["Gruul"][1] = 18779 * 86400 + 16 * 3600;		--
		NS.milestone["Serpent"][1] = 18779 * 86400 + 16 * 3600 + 105 * 86400;		--
		NS.milestone["Tempest"][1] = 18779 * 86400 + 16 * 3600 + 105 * 86400;		--
		NS.milestone["Hyjal"][1] = 18779 * 86400 + 16 * 3600 + 238 * 86400;		--
		NS.milestone["BT"][1] = 18779 * 86400 + 16 * 3600 + 238 * 86400;		--
		NS.milestone["DarkMoon: Terokkar"][1] = 18840 * 86400 + 16 * 3600;
		NS.milestone["DarkMoon: Mulgore"][1] = 18812 * 86400 + 16 * 3600;
		NS.milestone["DarkMoon: Elwynn"][1] = 18784 * 86400 + 16 * 3600;
		NS.milestone["Fishing Extravaganza"][1] = 18371 * 86400 + 22 * 3600;
		NS.milestone["Warsong Gulch"][1] = 18782 * 86400 + 8 * 3600;
		NS.milestone["Arathi Basin"][1] = 18789 * 86400 + 8 * 3600;
		NS.milestone["Eye of the Storm"][1] = 18796 * 86400 + 8 * 3600;
		NS.milestone["Alterac Valley"][1] = 18803 * 86400 + 8 * 3600;
		NS.realmTimeZone = -8;
		NS.set_time_zone();
	end,
	[2] = function(region)	--	2 = US Eastern		UTC-5
		NS.milestone["MC"][1] = 18135 * 86400 + 16 * 3600;		--
		NS.milestone["ONY"][1] = 18141 * 86400 + 16 * 3600;		--
		NS.milestone["BWL"][1] = 18310 * 86400 + 16 * 3600;		--
		NS.milestone["ZG"][1] = 18368 * 86400 + 16 * 3600;		--
		NS.milestone["TAQ"][1] = 18471 * 86400 + 16 * 3600;		--
		NS.milestone["RAQ"][1] = 18470 * 86400 + 16 * 3600;		--~
		NS.milestone["NAXX"][1] = 18597 * 86400 + 16 * 3600;	--
		NS.milestone["Kara"][1] = 18779 * 86400 + 16 * 3600;		--
		NS.milestone["Magtheridon"][1] = 18779 * 86400 + 16 * 3600;	--
		NS.milestone["Gruul"][1] = 18779 * 86400 + 16 * 3600;		--
		NS.milestone["Serpent"][1] = 18779 * 86400 + 16 * 3600 + 105 * 86400;		--
		NS.milestone["Tempest"][1] = 18779 * 86400 + 16 * 3600 + 105 * 86400;		--
		NS.milestone["Hyjal"][1] = 18779 * 86400 + 16 * 3600 + 238 * 86400;		--
		NS.milestone["BT"][1] = 18779 * 86400 + 16 * 3600 + 238 * 86400;		--
		NS.milestone["DarkMoon: Terokkar"][1] = 18840 * 86400 + 13 * 3600;
		NS.milestone["DarkMoon: Mulgore"][1] = 18812 * 86400 + 13 * 3600;
		NS.milestone["DarkMoon: Elwynn"][1] = 18784 * 86400 + 13 * 3600;
		NS.milestone["Fishing Extravaganza"][1] = 18371 * 86400 + 22 * 3600;
		NS.milestone["Warsong Gulch"][1] = 18782 * 86400 + 8 * 3600;
		NS.milestone["Arathi Basin"][1] = 18789 * 86400 + 8 * 3600;
		NS.milestone["Eye of the Storm"][1] = 18796 * 86400 + 8 * 3600;
		NS.milestone["Alterac Valley"][1] = 18803 * 86400 + 8 * 3600;
		NS.realmTimeZone = -5;
		NS.set_time_zone();
	end,
	[3] = function(region)	--	3 = Korea
		NS.milestone["MC"][1] = 18137 * 86400 + 1 * 3600;		-- 1567040400
		NS.milestone["ONY"][1] = 18136 * 86400 + 1 * 3600;		-- 1566954000
		NS.milestone["BWL"][1] = 18305 * 86400 + 1 * 3600;		-- 1581555600
		NS.milestone["ZG"][1] = 18366 * 86400 + 1 * 3600;		-- 1586826000
		NS.milestone["TAQ"][1] = 18473 * 86400 + 1 * 3600;		-- 1567040400
		NS.milestone["RAQ"][1] = 18471 * 86400 + 1 * 3600;		--~ 1567213200
		NS.milestone["NAXX"][1] = 18599 * 86400 + 1 * 3600;		-- 1567040400
		NS.milestone["Kara"][1] = 18781 * 86400 + 1 * 3600;
		NS.milestone["Magtheridon"][1] = 18781 * 86400 + 1 * 3600;
		NS.milestone["Gruul"][1] = 18781 * 86400 + 1 * 3600;
		NS.milestone["Serpent"][1] = 18781 * 86400 + 1 * 3600 + 105 * 86400;
		NS.milestone["Tempest"][1] = 18781 * 86400 + 1 * 3600 + 105 * 86400;
		NS.milestone["Hyjal"][1] = 18781 * 86400 + 1 * 3600 + 238 * 86400;
		NS.milestone["BT"][1] = 18781 * 86400 + 1 * 3600 + 238 * 86400;
		NS.milestone["DarkMoon: Terokkar"][1] = 18840 * 86400 - 5 * 3600;
		NS.milestone["DarkMoon: Mulgore"][1] = 18812 * 86400 - 5 * 3600;
		NS.milestone["DarkMoon: Elwynn"][1] = 18784 * 86400 - 5 * 3600;
		NS.milestone["Fishing Extravaganza"][1] = 18371 * 86400 + 5 * 3600;
		NS.milestone["Warsong Gulch"][1] = 18789 * 86400 - 9 * 3600;
		NS.milestone["Arathi Basin"][1] = 18796 * 86400 - 9 * 3600;
		NS.milestone["Alterac Valley"][1] = 18803 * 86400 - 9 * 3600;
		NS.milestone["Eye of the Storm"][1] = 18782 * 86400 - 9 * 3600;
		NS.realmTimeZone = 9;
		NS.set_time_zone();
	end,
	[4] = function(region)	--	4 = Europe			UTC+1
		NS.milestone["MC"][1] = 18136 * 86400 + 7 * 3600;		--
		NS.milestone["ONY"][1] = 18140 * 86400 + 7 * 3600;		--
		NS.milestone["BWL"][1] = 18304 * 86400 + 7 * 3600;		--
		NS.milestone["ZG"][1] = 18368 * 86400 + 7 * 3600;		--
		NS.milestone["TAQ"][1] = 18472 * 86400 + 7 * 3600;		--
		NS.milestone["RAQ"][1] = 18470 * 86400 + 7 * 3600;		--~
		NS.milestone["NAXX"][1] = 18598 * 86400 + 7 * 3600;		--
		NS.milestone["Kara"][1] = 18780 * 86400 + 7 * 3600;			--
		NS.milestone["Magtheridon"][1] = 18780 * 86400 + 7 * 3600;	--
		NS.milestone["Gruul"][1] = 18780 * 86400 + 7 * 3600;		--
		NS.milestone["Serpent"][1] = 18780 * 86400 + 7 * 3600 + 105 * 86400;		--
		NS.milestone["Tempest"][1] = 18780 * 86400 + 7 * 3600 + 105 * 86400;		--
		NS.milestone["Hyjal"][1] = 18780 * 86400 + 7 * 3600 + 238 * 86400;		--
		NS.milestone["BT"][1] = 18780 * 86400 + 7 * 3600 + 238 * 86400;		--
		NS.milestone["DarkMoon: Terokkar"][1] = 18840 * 86400 + 3 * 3600;
		NS.milestone["DarkMoon: Mulgore"][1] = 18812 * 86400 + 3 * 3600;
		NS.milestone["DarkMoon: Elwynn"][1] = 18784 * 86400 + 3 * 3600;
		NS.milestone["Fishing Extravaganza"][1] = 18371 * 86400 + 13 * 3600;
		NS.milestone["Warsong Gulch"][1] = 18782 * 86400 - 1 * 3600;
		NS.milestone["Arathi Basin"][1] = 18789 * 86400 - 1 * 3600;
		NS.milestone["Eye of the Storm"][1] = 18796 * 86400 - 1 * 3600;
		NS.milestone["Alterac Valley"][1] = 18803 * 86400 - 1 * 3600;
		NS.realmTimeZone = 1;
		NS.set_time_zone();
	end,
	[5] = function(region)	--	5 = Taiwan
		NS.milestone["MC"][1] = 18137 * 86400 + 1 * 3600;		-- 1567040400
		NS.milestone["ONY"][1] = 18136 * 86400 + 1 * 3600;		-- 1566954000
		NS.milestone["BWL"][1] = 18305 * 86400 + 1 * 3600;		-- 1581555600
		NS.milestone["ZG"][1] = 18366 * 86400 + 1 * 3600;		-- 1586826000
		NS.milestone["TAQ"][1] = 18473 * 86400 + 1 * 3600;		-- 1567040400
		NS.milestone["RAQ"][1] = 18471 * 86400 + 1 * 3600;		-- 1567213200
		NS.milestone["NAXX"][1] = 18599 * 86400 + 1 * 3600;		-- 1567040400
		NS.milestone["Kara"][1] = 18781 * 86400 + 1 * 3600;
		NS.milestone["Magtheridon"][1] = 18781 * 86400 + 1 * 3600;
		NS.milestone["Gruul"][1] = 18781 * 86400 + 1 * 3600;
		NS.milestone["Serpent"][1] = 18781 * 86400 + 1 * 3600 + 105 * 86400;
		NS.milestone["Tempest"][1] = 18781 * 86400 + 1 * 3600 + 105 * 86400;
		NS.milestone["Hyjal"][1] = 18781 * 86400 + 1 * 3600 + 238 * 86400;
		NS.milestone["BT"][1] = 18781 * 86400 + 1 * 3600 + 238 * 86400;
		NS.milestone["DarkMoon: Terokkar"][1] = 18840 * 86400 - 4 * 3600;
		NS.milestone["DarkMoon: Mulgore"][1] = 18812 * 86400 - 4 * 3600;
		NS.milestone["DarkMoon: Elwynn"][1] = 18784 * 86400 - 4 * 3600;
		NS.milestone["Fishing Extravaganza"][1] = 18371 * 86400 + 6 * 3600;
		NS.milestone["Warsong Gulch"][1] = 18796 * 86400 - 8 * 3600;
		NS.milestone["Arathi Basin"][1] = 18803 * 86400 - 8 * 3600;
		NS.milestone["Eye of the Storm"][1] = 18782 * 86400 - 8 * 3600;
		NS.milestone["Alterac Valley"][1] = 18789 * 86400 - 8 * 3600;
		NS.realmTimeZone = 8;
		NS.set_time_zone();
	end,
	[6] = function(region)	--	6 = China
		NS.milestone["MC"][1] = 18766 * 86400 + 23 * 3600;		--	--	2021-05-20	1621465200
		NS.milestone["ONY"][1] = 18765 * 86400 + 23 * 3600;		--	--	2021-05-19	1621353600
		NS.milestone["BWL"][1] = 18766 * 86400 + 23 * 3600;		--	
		NS.milestone["ZG"][1] = 18764 * 86400 + 23 * 3600;		--	--	2021-05-18	1621267200
		NS.milestone["TAQ"][1] = 18766 * 86400 + 23 * 3600;		--
		NS.milestone["RAQ"][1] = 18764 * 86400 + 23 * 3600;		--~
		NS.milestone["NAXX"][1] = 18766 * 86400 + 23 * 3600;	--
		NS.milestone["Kara"][1] = 18780 * 86400 + 23 * 3600;		--	--	2021-06-03	1621465200
		NS.milestone["Magtheridon"][1] = 18780 * 86400 + 23 * 3600;	--	--	2021-06-03	1621465200
		NS.milestone["Gruul"][1] = 18780 * 86400 + 23 * 3600;		--	--	2021-06-03	1621465200
		NS.milestone["Serpent"][1] = 18780 * 86400 + 23 * 3600 + 105 * 86400;		--	--	2021-06-03	1621465200
		NS.milestone["Tempest"][1] = 18780 * 86400 + 23 * 3600 + 105 * 86400;		--	--	2021-06-03	1621465200
		NS.milestone["Hyjal"][1] = 18780 * 86400 + 23 * 3600 + 238 * 86400;			--	--	2022-01-27	1643238000
		NS.milestone["BT"][1] = 18780 * 86400 + 23 * 3600 + 238 * 86400;			--	--	2022-01-27	1643238000
		NS.milestone["DarkMoon: Terokkar"][1] = 18840 * 86400 - 4 * 3600;
		NS.milestone["DarkMoon: Mulgore"][1] = 18812 * 86400 - 4 * 3600;
		NS.milestone["DarkMoon: Elwynn"][1] = 18784 * 86400 - 4 * 3600;
		NS.milestone["Fishing Extravaganza"][1] = 18371 * 86400 + 6 * 3600;
		NS.milestone["Warsong Gulch"][1] = 18796 * 86400 - 8 * 3600;	--	2021-06-18
		NS.milestone["Arathi Basin"][1] = 18803 * 86400 - 8 * 3600;		--	2021-06-25
		NS.milestone["Eye of the Storm"][1] = 18782 * 86400 - 8 * 3600;	--	2021-06-04
		NS.milestone["Alterac Valley"][1] = 18789 * 86400 - 8 * 3600;	--	2021-06-11
		NS.realmTimeZone = 8;
		NS.set_time_zone();
	end,
};

NS.raid_list = {
	"SW",
	"BT",
	"Hyjal",
	"ZAM",
	"Tempest",
	"Serpent",
	"Gruul",
	"Magtheridon",
	"Kara",
	--
	"NAXX",
	"TAQ",
	"BWL",
	"ONY",
	"MC",
	"RAQ",
	"ZG",
	-- "ala",
};
NS.instances_hash = {
	["NAXX"] = false,
	["TAQ"] = false,
	["RAQ"] = false,
	["BWL"] = false,
	["ZG"] = true,
	["MC"] = false,
	["ONY"] = false,
	["Kara"] = true,
	["Magtheridon"] = true,
	["Gruul"] = true,
	["Serpent"] = true,
	["Tempest"] = true,
	["ZAM"] = true,
	["Hyjal"] = true,
	["BT"] = true,
	["SW"] = true,
	["Warsong Gulch"] = true,
	["Arathi Basin"] = true,
	["Alterac Valley"] = true,
	["Eye of the Storm"] = true,
	["DarkMoon: Terokkar"] = true,
	["DarkMoon: Mulgore"] = true,
	["DarkMoon: Elwynn"] = true,
	["Fishing Extravaganza"] = true,
};

NS.DailyQuests = {
	MonitoredNPC = {
		["24370"] = true,
		["24369"] = true,
		["24393"] = true,
		["25580"] = true,
	},
	[1] = {	--	24370
		[11364] = { "悬赏：碎手百夫长", 3714, },		--	破碎大厅
		[11371] = { "悬赏：盘牙侍从", 3715, },			--	蒸汽地窟
		[11376] = { "悬赏：恶毒导师", 3789, },			--	暗影迷宫
		[11383] = { "悬赏：裂隙领主", 2366, },			--	黑色沼泽
		[11385] = { "悬赏：寻日者导魔者", 3847, },		--	生态船
		[11387] = { "悬赏：风暴锻铸摧毁者", 3849, },	--	能源舰
		[11389] = { "悬赏：禁魔监狱斥候", 3848, },		--	禁魔监狱	3846, 3848
		[11500] = { "悬赏：痛苦妖女", 4131, },			--	魔导师平台	4095, 4131
	},
	[2] = {	--	24369
		[11354] = { "悬赏：纳杉的骑鞭", 3562, },		--	地狱火城墙
		[11362] = { "悬赏：克里丹的羽饰法杖", 3713, },	--	鲜血熔炉
		[11363] = { "悬赏：刃拳的印记", 3714, },		--	破碎大厅
		[11368] = { "悬赏：夸格米拉之心", 3717, },		--	奴隶围栏
		[11369] = { "悬赏：黑色阔步者的卵", 3716, },	--	幽暗沼泽
		[11370] = { "悬赏：督军的论文", 3715, },		--	蒸汽地窟
		[11372] = { "悬赏：艾吉斯的冠羽", 3791, },		--	塞泰克大厅
		[11373] = { "悬赏：沙法尔的精致饰物", 3792, },	--	法力陵墓
		[11374] = { "悬赏：主教的灵魂宝钻", 3790, },	--	奥金尼地穴
		[11375] = { "悬赏：摩摩尔的低语", 3789, },		--	暗影迷宫
		[11378] = { "悬赏：时空猎手的头颅", 2367, },	--	旧希尔斯布莱德丘陵
		[11382] = { "悬赏：埃欧努斯的沙漏", 2366, },	--	黑色沼泽
		[11384] = { "悬赏：扭木碎片", 3847, },			--	生态船
		[11386] = { "悬赏：帕萨雷恩的投影仪", 3849, },	--	能源舰
		[11388] = { "悬赏：斯克瑞斯的卷轴", 3848, },	--	禁魔监狱	3846, 3848
		[11499] = { "悬赏：凯尔萨斯王子的徽记之戒", 4131, },	--	魔导师平台	4095, 4131
	},
	[3] = {	--	24393
		[11377] = { "甜美的复仇", },
		[11379] = { "超级美味烧烤", },
		[11380] = { "魔法美味", },
		[11381] = { "灵魂之汤", },
	},
	[4] = {	--	25580
		[11665] = { "城中的鳄鱼", },
		[11666] = { "黑鳞镖鲈", },
		[11667] = { "世界上最大的泥鱼", },
		[11668] = { "巨型淡水虾", },
		[11669] = { "魔血鲷鱼", },
	},
};
