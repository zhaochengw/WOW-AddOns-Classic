local _, addonTable = ...;
local fuFrame = Pig_Options_RF_TAB_1_UI;
local _, _, _, tocversion = GetBuildInfo()
------------------------------------------------------
fuFrame.RP = fuFrame:CreateLine()
fuFrame.RP:SetColorTexture(0.8,0.8,0.8,0.5)
fuFrame.RP:SetThickness(1);
fuFrame.RP:SetStartPoint("TOPLEFT",1,-350)
fuFrame.RP:SetEndPoint("TOPRIGHT",-1,-350)
--------------------------------------------
local biaotou='!Pig-YCCK';
local YCinfo={}
YCinfo.shenqing = "qingqiuchakan"
C_ChatInfo.RegisterAddonMessagePrefix(biaotou)
--------
local tianfuBG = {
	["DEATHKNIGHT"]={136864,136865,136866,136867,136868,136869,136870,136871,136872,136873,136874,136875},
	["DRUID"]={136876,136877,136878,136879,136880,136881,136882,136883,136884,136885,136886,136887},
	["HUNTER"]={136888,136889,136890,136891,136892,136893,136894,136895,136896,136897,136898,136899},
	["MAGE"]={136900,136901,136902,136903,136904,136905,136906,136907,136908,136909,136910,136911},
	["PALADIN"]={136916,136917,136918,136919,136920,136921,136922,136923,136912,136913,136914,136915},
	["PRIEST"]={136924,136925,136926,136927,136928,136929,136930,136931,136932,136933,136934,136935},
	["ROGUE"]={136936,136937,136938,136939,136940,136941,136942,136943,136944,136945,136946,136947},
	["SHAMAN"]={136948,136949,136950,136951,136952,136953,136954,136955,136956,136957,136958,136959},
	["WARLOCK"]={136965,136966,136967,136968,136973,136974,136975,136976,136969,136970,136971,136972},
	["WARRIOR"]={136981,136982,136983,136984,136985,136986,136987,136988,136989,136990,136991,136992},
}
local tianfuTabName = {
	["DEATHKNIGHT"]={[1]="鲜血",[2]="冰霜",[3]="邪恶"},
	["DRUID"] ={[1]="平衡",[2]="野性战斗",[3]="恢复"},
	["HUNTER"] ={[1]="野兽控制",[2]="射击",[3]="生存"},
	["MAGE"] ={[1]="奥术",[2]="火焰",[3]="冰霜"},
	["PALADIN"] ={[1]="神圣",[2]="防护",[3]="惩戒"},
	["PRIEST"] ={[1]="戒律",[2]="神圣",[3]="暗影"},
	["ROGUE"] ={[1]="刺杀",[2]="战斗",[3]="敏锐"},
	["SHAMAN"] ={[1]="元素",[2]="增强",[3]="恢复"},
	["WARLOCK"] ={[1]="痛苦",[2]="恶魔学识",[3]="毁灭"},
	["WARRIOR"] ={[1]="武器",[2]="狂怒",[3]="防护"},
};
----
tianfuID={}
local tianfuID_classic = {
	["DRUID"]={		
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["HUNTER"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["MAGE"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["PALADIN"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["PRIEST"]={
		[1]={
			{nil,{14522,14788,14789,14790,14791},{14524,14525,14526,14527,14528},nil},
			{{14523,14784,14785,14786,14787},{14749,14767},{14748,14768,14769},{14531,14774}},
			{nil,{14751},{14521,14776,14777},nil},
			{{14747,14770,14771},{14520,14780,14781,14782,14783},nil,{14750,14772}},
			{nil,{18551,18552,18553,18554,18555},{14752},nil},
			{nil,nil,{18544,18547,18548,18549,18550},nil},
			{nil,{10060},nil,nil},
		},
		[2]={
			{{14913,15012},{14908,15020,17191},{14889,15008,15009,15010,15011},nil},
			{nil,{27900,27901,27902,27903,27904},{18530,18531,18533,18534,18535},nil},
			{{15237},{27811,27815,27816},nil,{14892,15362,15363}},
			{{27789,27790},{14912,15013,15014},{14909,15017},nil},
			{{14911,15018},{20711},{14901,15028,15029,15030,15031},nil},
			{nil,nil,{14898,15349,15354,15355,15356},nil},
			{nil,{724},nil,nil},
		},
		[3]={
			{nil,{15270,15335,15336,15337,15338},{15268,15323,15324,15325,15326},nil},
			{{15318,15272,15320},{15275,15317},{15260,15327,15328,15329,15330},nil},
			{{15392,15448},{15273,15312,15313,15314,15316},{15407},nil},
			{nil,{15274,15311},{17322,17323,17325},{15257,15331,15332,15333,15334}},
			{{15487},{15286},{27839,27840},nil},
			{nil,nil,{15259,15307,15308,15309,15310},nil},
			{nil,{15473},nil,nil},
		},
	},
	["ROGUE"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["SHAMAN"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["WARLOCK"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["WARRIOR"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
}
local tianfuID_BCC = {
	["DEATHKNIGHT"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["DRUID"]={		
		[1]={
			{{16814,16815,16816,16817,16818,},{16689},{17245,17247,17248,17249},nil},
			{{16918,16919,16920},{35363,35364},{16821,16822},nil},
			{{16836,16839,16840},nil,{5570},{16819,16820}},
			{nil,{16909,16910,16911,16912,16913},{16850,16923,16924},nil},
			{{33589,33590,33591},{16880},{16845,16846,16847},nil},
			{nil,{16896,16897,16899,16900,16901},{33592,33596},nil},
			{{33597,33599,33956},{24858},{33600,33601,33602},nil},
			{nil,{33603,33604,33605,33606,33607},nil,nil},
			{nil,{33831},nil,nil},
		},
		[2]={
			{nil,{16934,16935,16936,16937,16938},{16858,16859,16860,16861,16862},nil},
			{{16947,16948,16949},{16940,16941},{16929,16930,16931},nil},
			{{17002,24866},{16979},{16942,16943,16944},nil},
			{{16966,16968},{16972,16974,16975},{37116,37117},nil},
			{{16998,16999},nil,{16857},{33872,33873}},
			{nil,{17003,17004,17005,17006,24894,},{33853,33855,33856},nil},
			{{33851,33852,33957},{17007},{34297,34300},nil},
			{nil,nil,{33859,33866,33867,33868,33869,},nil},
			{nil,{33917},nil,nil},
		},
		[3]={
			{nil,{17050,17051,17053,17054,17055},{17056,17058,17059,17060,17061},nil},
			{{17069,17070,17071,17072,17073},{17063,17065,17066,17067,17068},{16833,16834,16835},nil},
			{{17106,17107,17108},{17118,17119,17120,17121,17122},{16864},nil},
			{nil,{24968,24969,24970,24971,24972},{17111,17112,17113},nil},
			{{17116},{17104,24943,24944,24945,24946,},nil,{17123,17124}},
			{{33879,33880},nil,{17074,17075,17076,17077,17078,},nil},
			{{34151,34152,34153},{18562},{33881,33882,33883},nil},
			{nil,{33886,33887,33888,33889,33890},nil,nil},
			{nil,{33891},nil,nil},
		},
	},
	["HUNTER"]={
		[1]={
			{nil,{19552,19553,19554,19555,19556},{19583,19584,19585,19586,19587},nil},
			{{35029,35030},{19549,19550,19551},{19609,19610,19612},{24443,19575}},
			{{19559,19560},{19596},{19616,19617,19618,19619,19620},nil},
			{nil,{19572,19573},{19598,19599,19600,19601,19602},nil},
			{{19578,20895},{19577},nil,{19590,19592}},
			{{34453,34454},nil,{19621,19622,19623,19624,19625},nil},
			{{34455,34459,34460},{19574},{34462,34464,34465},nil},
			{nil,nil,{34466,34467,34468,34469,34470},nil},
			{nil,{34692},nil,nil},
		},
		[2]={
			{nil,{19407,19412,19413,19414,19415},{19426,19427,19429,19430,19431},nil},
			{nil,{19421,19422,19423,19424,19425},{19416,19417,19418,19419,19420},nil},
			{{34950,34954},{19454,19455,19456,19457,19458},{19434},{34948,34949}},
			{nil,{19464,19465,19466,19467,19468},{19485,19487,19488,19489,19490},nil},
			{{35100,35102,35103},{19503},{19461,19462,24691},nil},
			{{34475,34476},nil,nil,{19507,19508,19509,19510,19511}},
			{{34482,34483,34484},{19506},{35104,35110,35111},nil},
			{nil,{34485,34486,34487,34488,34489},nil,nil},
			{nil,{34490},nil,nil},
		},
		[3]={
			{{24293,24294,24295},{19151,19152,19153},{19498,19499,19500},{19159,19160}},
			{{19184,19387,19388},{19295,19297,19298,19301,19300},{19228,19232,19233},nil},
			{{19239,19245},{19255,19256,19257,19258,19259},{19263},nil},
			{{19376,19377},{19290,19294,24283},nil,{19286,19287}},
			{{34494,34496},{19370,19371,19373},{19306},nil},
			{{34491,34492,34493},nil,{19168,19180,19181,24296,24297},nil},
			{{34497,34498,34499},{19386},{34500,34502,34503},nil},
			{nil,{34506,34507,34508,34838,34839},nil,nil},
			{nil,{23989},nil,nil},
		},
	},
	["MAGE"]={
		[1]={
			{{11210,12592},{11222,12839,12840,12841,12842},{11237,12463,12464,16769,16770},nil},
			{{6057,6085},{29441,29444,29445,29446,29447},{11213,12574,12575,12576,12577},nil},
			{{11247,12606},{11242,12467},nil,{28574}},
			{{11252,12605},{11255,12598},nil,{18462,18463,18464}},
			{{31569,31570},{12043},nil,{11232,12500,12501,12502,12503}},
			{{31574,31575},{15058,15059,15060},{31571,31572,31573},nil},
			{{31579,31582,31583},{12042},{35578,35581},nil},
			{nil,{31584,31585,31586,31587,31588},nil,nil},
			{nil,{31589},nil,nil},
		},
		[2]={
			{nil,{11069,12338,12339,12340,12341},{11103,12357,12358,12359,12360},nil},
			{{11119,11120,12846,12847,12848},{11100,12353},{11078,11080,12342},nil},
			{{18459,18460},{11108,12349,12350},{11366},{11083,12351}},
			{{11095,12872,12873},{11094,13043},nil,{29074,29075,29076}},
			{{31638,31639,31640},{11115,11367,11368},{11113},nil},
			{{31641,31642},nil,{11124,12378,12398,12399,12400},nil},
			{{34293,34295,34296},{11129},{31679,31680},nil},
			{nil,nil,{31656,31657,31658,31659,31660},nil},
			{nil,{31661},nil,nil},
		},
		[3]={
			{{11189,28332},{11070,12473,16763,16765,16766},{29438,29439,29440},nil},
			{{11207,12672,15047,15052,15053},{11071,12496,12497},{11165,12475},{11175,12569,12571}},
			{{11151,12952,12953},{12472},nil,{11185,12487,12488}},
			{{16757,16758},{11160,12518,12519},{11170,12982,12983,12984,12985},nil},
			{{31667,31668,31669},{11958},{11190,12489,12490},nil},
			{{31670,31672},nil,{11180,28592,28593,28594,28595},nil},
			{nil,{11426},{31674,31675,31676,31677,31678},nil},
			{nil,{31682,31683,31684,31685,31686},nil,nil},
			{nil,{31687},nil,nil},
		},
	},
	["PALADIN"]={
		[1]={
			{nil,{20262,20263,20264,20265,20266},{20257,20258,20259,20260,20261},nil},
			{nil,{20205,20206,20207,20209,20208},{20224,20225,20330,20331,20332},nil},
			{{20237,20238,20239},{31821},{20234,20235},{9453,25836}},
			{nil,{20210,20212,20213,20214,20215},{20244,20245},nil},
			{{31822,31823,31824},{20216},{20359,20360,20361},nil},
			{{31825,31826},nil,{5923,5924,5925,5926,25829},nil},
			{{31833,31835,31836},{20473},{31828,31829,31830},nil},
			{nil,{31837,31838,31839,31840,31841},nil,nil},
			{nil,{31842},nil,nil},
		},
		[2]={
			{nil,{20138,20139,20140,20141,20142},{20127,20130,20135,20136,20137},nil},
			{{20189,20192,20193},{20174,20175},nil,{20143,20144,20145,20146,20147}},
			{{20217},{20468,20469,20470},{20148,20149,20150},{20096,20097,20098,20099,20100}},
			{{31844,31845},{20487,20488,20489},{20254,20255,20256},nil},
			{{31846,31847},{20911},{20177,20179,20181,20180,20182},nil},
			{{31848,31849},nil,{20196,20197,20198,20199,20200},nil},
			{{41021,41026},{20925},{31850,31851,31852,31853,31854},nil},
			{nil,nil,{31858,31859,31860,31861,31862},nil},
			{nil,{31935},nil,nil},
		},
		[3]={
			{nil,{20042,20045,20046,20047,20048},{20101,20102,20103,20104,20105},nil},
			{{25956,25957},{20335,20336,20337},{20060,20061,20062,20063,20064},nil},
			{{9452,26016,26021},{20117,20118,20119,20120,20121},{20375},{26022,26023,44414}},
			{{9799,25988},nil,{20091,20092},{31866,31867,31868}},
			{{20111,20112,20113},nil,{20218},{31869,31870}},
			{nil,{20049,20056,20057,20058,20059},{31876,31877,31878},nil},
			{{32043,35396,35397},{20066},{31871,31872,31873},nil},
			{nil,{31879,31880,31881,31882,31883},nil,nil},
			{nil,{35395},nil,nil},
		},
	},
	["PRIEST"]={
		[1]={
			{nil,{14522,14788,14789,14790,14791},{14524,14525,14526,14527,14528},nil},
			{{14523,14784,14785,14786,14787},{14749,14767},{14748,14768,14769},{14531,14774}},
			{{33167,33171,33172},{14751},{14521,14776,14777},nil},
			{{14747,14770,14771},{14520,14780,14781,14782,14783},nil,{14750,14772}},
			{nil,{18551,18552,18553,18554,18555},{14752},{33174,33182}},
			{{33186,33190},nil,{18544,18547,18548,18549,18550},nil},
			{{45234,45243,45244},{10060},{33201,33202,33203,33204,33205}},
			{nil,{34908,34909,34910,34911,34912},nil,nil},
			{nil,{33206},nil,nil},
		},
		[2]={
			{{14913,15012},{14908,15020,17191},{14889,15008,15009,15010,15011},nil},
			{nil,{27900,27901,27902,27903,27904},{18530,18531,18533,18534,18535},nil},
			{{15237},{27811,27815,27816},nil,{14892,15362,15363}},
			{{27789,27790},{14912,15013,15014},{14909,15017},nil},
			{{14911,15018},{20711},{14901,15028,15029,15030,15031},nil},
			{{33150,33154},nil,{14898,15349,15354,15355,15356},nil},
			{{34753,34859,34860},{724},{33142,33145,33146},nil},
			{nil,{33158,33159,33160,33161,33162},nil,nil},
			{nil,{34861},nil,nil},
		},
		[3]={
			{nil,{15270,15335,15336,15337,15338},{15268,15323,15324,15325,15326},nil},
			{{15318,15272,15320},{15275,15317},{15260,15327,15328,15329,15330},nil},
			{{15392,15448},{15273,15312,15313,15314,15316},{15407},nil},
			{nil,{15274,15311},{17322,17323},{15257,15331,15332,15333,15334}},
			{{15487},{15286},{27839,27840},{33213,33214,33215}},
			{{14910,33371},nil,{15259,15307,15308,15309,15310},nil},
			{nil,{15473},{33221,33222,33223,33224,33225},nil},
			{nil,nil,{33191,33192,33193,33194,33195},nil},
			{nil,{34914},nil,nil},
		},
	},
	["ROGUE"]={
		[1]={
			{{14162,14163,14164},{14144,14148},{14138,14139,14140,14141,14142},nil},
			{{14156,14160,14161},{14158,14159},nil,{13733,13865,13866}},
			{{14179},{14168,14169},{14128,14132,14135,14136,14137},nil},
			{nil,{16513,16514,16515,16719,16720},{14113,14114,14115,14116,14117},nil},
			{{31208,31209},{14177},{14174,14175,14176},{31244,31245}},
			{nil,{14186,14190,14193,14194,14195},{31226,31227},nil},
			{nil,{14983},{31380,31382,31383,31384,31385},nil},
			{nil,nil,{31233,31239,31240,31241,31242},nil},
			{nil,{1329},nil,nil},
		},
		[2]={
			{{13741,13793,13792},{13732,13863},{13712,13788,13789,13790,13791},nil},
			{{14165,14166,14167},{13713,13853,13854,13855,13856},{13705,13832,13843,13844,13845},nil},
			{{13742,13872},{14251},nil,{13743,13875}},
			{{13754,13867},{13706,13804,13805,13806,13807},{13715,13848,13849,13851,13852},nil},
			{{13709,13800,13801,13802,13803},{13877},{13960,13961,13962,13963,13964},{13707,13966,13967,13968,13969}},
			{{31124,31126},{30919,30920},{18427,18428,18429},nil},
			{{31122,31123},{13750},{31130,31131},nil},
			{nil,nil,{35541,35550,35551,35552,35553},nil},
			{nil,{32601},nil,nil},
		},
		[3]={
			{nil,{13958,13970,13971,13972,13973},{14057,14072,14073,14074,14075},nil},
			{{30892,30893},{14076,14094},{13975,14062,14063,14064,14065},nil},
			{{13976,13979,13980},{14278},{14079,14080,14081},nil},
			{{13983,14070,14071},{13981,14066},{14171,14172,14173},nil},
			{{30894,30895},{14185},{14082,14083},{16511}},
			{{31221,31222,31223},nil,{30902,30903,30904,30905,30906},nil},
			{{31211,31212,31213},{14183},{31228,31229,31230},nil},
			{nil,{31216,31217,31218,31219,31220},nil,nil},
			{nil,{36554},nil,nil},	
		},
	},
	["SHAMAN"]={
		[1]={
			{nil,{16039,16109,16110,16111,16112},{16035,16105,16106,16107,16108},nil},
			{{16043,16130},{28996,28997,28998},{16038,16160,16161},nil},
			{{16164},{16040,16113,16114,16115,16116},{16041,16117,16118,16119,16120},nil},
			{{16086,16544},{29062,29064,29065},nil,{30160,29179,29180}},
			{{28999,29000},{16089},nil,{30664,30665,30666,30667,30668}},
			{{30672,30673,30674},nil,{16578,16579,16580,16581,16582},nil},
			{nil,{16166},{30669,30670,30671},nil},
			{nil,{30675,30678,30679,30680,30681},nil,nil},
			{nil,{30706},nil,nil},
		},
		[2]={
			{nil,{17485,17486,17487,17488,17489},{16253,16298,16299,16300,16301},nil},
			{{16258,16293},{16255,16302,16303,16304,16305},{16262,16287},{16261,16290,16291}},
			{{16259,16295},nil,{43338},{16254,16271,16272,16273,16274}},
			{nil,{16256,16281,16282,16283,16284},{16252,16306,16307,16308,16309},nil},
			{{29192,29193},{16268},{16266,29079,29080},nil},
			{{30812,30813,30814},nil,nil,{29082,29084,29086,29087,29088}},
			{{30816,30818,30819},{30798},{17364},nil},
			{nil,{30802,30808,30809,30810,30811},nil,nil},
			{nil,{30823},nil,nil},
		},
		[3]={
			{nil,{16182,16226,16227,16228,16229},{16179,16214,16215,16216,16217},nil},
			{{16184,16209},{16176,16235,16240},{16173,16222,16223,16224,16225},nil},
			{{16180,16196,16198},{16181,16230,16232,16233,16234},{16189},{29187,29189,29191}},
			{nil,{16187,16205,16206,16207,16208},{16194,16218,16219,16220,16221},nil},
			{{29206,29205,29202},nil,{16188},{30864,30865,30866}},
			{nil,nil,{16178,16210,16211,16212,16213},nil},
			{nil,{16190},{30881,30883,30884,30885,30886},nil},
			{nil,{30867,30868,30869},{30872,30873},nil},
			{nil,{974},nil,nil},
		},
	},
	["WARLOCK"]={
		[1]={
			{nil,{18174,18175,18176,18177,18178},{17810,17811,17812,17813,17814},nil},
			{{18179,18180},{18213,18372},{18182,18183},{17804,17805}},
			{{18827,18829},{17783,17784,17785,17786,17787},{18288},nil},
			{{18218,18219},{18094,18095},nil,{32381,32382,32383}},
			{{32385,32387,32392,32393,32394},{18265},{18223},nil},
			{nil,{18271,18272,18273,18274,18275},nil,nil},
			{nil,{30060,30061,30062,30063,30064},{18220},nil},
			{{30054,30057},nil,{32477,32483,32484},nil},
			{nil,{30108},nil,nil},
		},
		[2]={
			{{18692,18693},{18694,18695,18696},{18697,18698,18699,18700,18701},nil},
			{{18703,18704},{18705,18706,18707},{18731,18743,18744},nil},
			{{18754,18755,18756},{18708},{18748,18749,18750},{30143,30144,30145}},
			{nil,{18709,18710},{18769,18770,18771,18772,18773},nil},
			{{18821,18822},{18788},nil,{18767,18768}},
			{{30326,30327,30328},nil,{23785,23822,23823,23824,23825},nil},
			{{30319,30320,30321},{19028},{35691,35692,35693},nil},
			{nil,{30242,30245,30246,30247,30248},nil,nil},
			{nil,{30146},nil,nil},
		},
		[3]={
			{nil,{17793,17796,17801,17802,17803},{17778,17779,17780,17781,17782},nil},
			{nil,{17788,17789,17790,17791,17792},{18119,18120,18121,18122,18123},nil},
			{{18126,18127},{18128,18129},{18130,18131,18132,18133,18134},{17877}},
			{{18135,18136},{17917,17918},nil,{17927,17929,17930}},
			{{18096,18073},{17815,17833,17834,17835,17836},{17959},nil},
			{{30299,30301,30302},nil,{17954,17955,17956,17957,17958},nil},
			{{34935,34938,34939},{17962},{30293,30295,30296},nil},
			{nil,{30288,30289,30290,30291,30292},nil,nil},
			{nil,{30283},nil,nil},
		},
	},
	["WARRIOR"]={
		[1]={
			{{12282,12663,12664},{16462,16463,16464,16465,16466},{12286,12658,12659},nil},
			{{12285,12697},{12300,12959,12960,12961,12962},{12287,12665,12666},nil},
			{{12290,12963},{12296},{12834,12849,12867},nil},
			{nil,{12163,12711,12712,12713,12714},{16493,16494},nil},
			{{12700,12781,12783,12784,12785},{12292},{12284,12701,12702,12703,12704},{12281,12812,12813,12814,12815}},
			{{29888,29889},nil,{12289,12668,23695},{29723,29724,29725}},
			{{29836,29859},{12294},{29834,29838},nil},
			{nil,{35446,35448,35449,35450,35451},nil,nil},
			{nil,{29623},nil,nil},
		},
		[2]={
			{nil,{12321,12835,12836,12837,12838},{12320,12852,12853,12855,12856},nil},
			{nil,{12324,12876,12877,12878,12879},{12322,12999,13000,13001,13002},nil},
			{{12329,12950,20496},{12323},{16487,16489,16492},{12318,12857,12858,12860,12861}},
			{{23584,23585,23586,23587,23588},{20502,20503},{12317,13045,13046,13047,13048},nil},
			{{12862,12330},{12328},nil,{20504,20505}},
			{{20500,20501},nil,{12319,12971,12972,12973,12974},nil},
			{{29590,29591,29592},{23881},{29721,29776},nil},
			{nil,{29759,29760,29761,29762,29763},nil,nil},
			{nil,{29801},nil,nil},
		},
		[3]={
			{{12301,12818},{12295,12676,12677},{12297,12750,12751,12752,12753},nil},
			{nil,{12298,12724,12725,12726,12727},{12299,12761,12762,12763,12764},nil},
			{{12975},{12945},{12797,12799,12800},{12303,12788,12789}},
			{{12308,12810,12811},{12313,12804,12807},{12302,12765},nil},
			{{12312,12803},{12809},{12311,12958},nil},
			{{29598,29599,29600},nil,{16538,16539,16540,16541,16542},nil},
			{{29593,29594,29595},{23922},{29787,29790,29792},nil},
			{nil,{29140,29143,29144,29145,29146},nil,nil},
			{nil,{20243},nil,nil},
		},
	},
}
local tianfuID_WLK = {
	["DEATHKNIGHT"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["DRUID"]={		
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["HUNTER"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["MAGE"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["PALADIN"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["PRIEST"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["ROGUE"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["SHAMAN"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["WARLOCK"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
	["WARRIOR"]={
		[1]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[2]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
		[3]={
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
			{nil,nil,nil,nil},
		},
	},
}
-----------
local tianfuW,tianfuH = 500,500
if tocversion<20000 then
	tianfuW,tianfuH = 500,420
	PIGtianfuhangshu=7
	tianfuID=tianfuID_classic
elseif tocversion<30000 then
	tianfuW,tianfuH = 500,500
	PIGtianfuhangshu=9
	tianfuID=tianfuID_BCC
else
	tianfuW,tianfuH = 500,600
	PIGtianfuhangshu=0
	tianfuID=tianfuID
end
local function gengxinBG(zhiye,LV,TFinfo)
	yuanchengDuixiang_UI.TalentF.L_TOPLEFT:SetTexture(tianfuBG[zhiye][3]);
	yuanchengDuixiang_UI.TalentF.L_TOPRIGHT:SetTexture(tianfuBG[zhiye][4]);
	yuanchengDuixiang_UI.TalentF.L_BOTTOMLEFT:SetTexture(tianfuBG[zhiye][1]);
	yuanchengDuixiang_UI.TalentF.L_BOTTOMRIGHT:SetTexture(tianfuBG[zhiye][2]);
	--
	yuanchengDuixiang_UI.TalentF.C_TOPLEFT:SetTexture(tianfuBG[zhiye][7]);
	yuanchengDuixiang_UI.TalentF.C_TOPRIGHT:SetTexture(tianfuBG[zhiye][8]);
	yuanchengDuixiang_UI.TalentF.C_BOTTOMLEFT:SetTexture(tianfuBG[zhiye][5]);
	yuanchengDuixiang_UI.TalentF.C_BOTTOMRIGHT:SetTexture(tianfuBG[zhiye][6]);
	---
	yuanchengDuixiang_UI.TalentF.R_TOPLEFT:SetTexture(tianfuBG[zhiye][11]);
	yuanchengDuixiang_UI.TalentF.R_TOPRIGHT:SetTexture(tianfuBG[zhiye][12]);
	yuanchengDuixiang_UI.TalentF.R_BOTTOMLEFT:SetTexture(tianfuBG[zhiye][9]);
	yuanchengDuixiang_UI.TalentF.R_BOTTOMRIGHT:SetTexture(tianfuBG[zhiye][10]);
	local tianfuyidianshu,yiyongzongdianshu = 0,0
	for i=1,3 do
		local yidianzongshu = 0
		for ii=1,PIGtianfuhangshu do
			for iii=1,4 do
				if tianfuID[zhiye][i][ii][iii] then
					tianfuyidianshu = tianfuyidianshu+1
					local huoqudianshu=tonumber(TFinfo[tianfuyidianshu])
					yidianzongshu=yidianzongshu+huoqudianshu

					_G["tianfuBUT_"..i.."_"..ii.."_"..iii]:Show();
					_G["tianfuBUT_"..i.."_"..ii.."_"..iii].dianshu:SetText(huoqudianshu.."/"..#tianfuID[zhiye][i][ii][iii]);
					if huoqudianshu==#tianfuID[zhiye][i][ii][iii] then
						_G["tianfuBUT_"..i.."_"..ii.."_"..iii].dianshu:SetTextColor(1, 1, 0, 1);
					else
						_G["tianfuBUT_"..i.."_"..ii.."_"..iii].dianshu:SetTextColor(0, 1, 0, 1);
					end
					_G["tianfuBUT_"..i.."_"..ii.."_"..iii].Icon:SetTexture(GetSpellTexture(tianfuID[zhiye][i][ii][iii][1]))
					
					if huoqudianshu>0 then
						_G["tianfuBUT_"..i.."_"..ii.."_"..iii].Icon:SetDesaturated(false)
						_G["tianfuBUT_"..i.."_"..ii.."_"..iii]:SetScript("OnEnter", function (self)
							GameTooltip:ClearLines();
							GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
							GameTooltip:SetHyperlink("spell:"..tianfuID[zhiye][i][ii][iii][#tianfuID[zhiye][i][ii][iii]])
							GameTooltip:Show();
						end);
					else
						_G["tianfuBUT_"..i.."_"..ii.."_"..iii].Icon:SetDesaturated(true)
						_G["tianfuBUT_"..i.."_"..ii.."_"..iii]:SetScript("OnEnter", function (self)
							GameTooltip:ClearLines();
							GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
							GameTooltip:SetHyperlink("spell:"..tianfuID[zhiye][i][ii][iii][1])
							GameTooltip:Show();
						end);
					end
					_G["tianfuBUT_"..i.."_"..ii.."_"..iii]:SetScript("OnLeave", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
				else
					_G["tianfuBUT_"..i.."_"..ii.."_"..iii]:Hide();
				end
			end
		end
		yiyongzongdianshu=yiyongzongdianshu+yidianzongshu
		_G["TalentFYIDIAN"..i]:SetText(tianfuTabName[zhiye][i].."("..yidianzongshu..")");
	end
	yuanchengDuixiang_UI.TalentF.biaoti:SetText("当前可用点数"..(LV-9).."(已分配"..yiyongzongdianshu..")");
end
-----------------------------
local huoquF
local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice
 -- 如果元素多于 0，则此函数为 1。  它不返回元素的实际数量。  这是为了节省处理时间。
local function count(tab)
    for _ in pairs(tab) do
        return 1
    end
    return 0
end
local function process(self, item, ...)
    itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = ...
    if itemName then   
        self.itemQueue[item] = nil-- 从队列中删除项目
    end
end
----
local function update(self, e)
    self.updateTimer = self.updateTimer - e
    if self.updateTimer <= 0 then
        for _, item in pairs(self.itemQueue) do
            process(self, item, GetItemInfo(item))
        end
        self.updateTimer = 1
        
        -- 如果队列中没有项目，则隐藏 OnUpdate 框架。
        if count(self.itemQueue) == 0 then
            self:Hide()
        end
    end
end

 -- 将请求的项目添加到队列中。
 -- 如果该项目在本地缓存中，它将立即可用。
 -- 如果该项目不在本地缓存中，请以一秒为增量等待并重试。
 -- 调用它来代替 GetItemInfo(item)。
 -- 此函数不返回任何数据。
function GetItemInfoDelayed(item)
    if not huoquF then
        huoquF = CreateFrame("Frame")
        huoquF:SetScript("OnUpdate", update)
        huoquF.itemQueue = {}
    end
    -- 将计时器设置为 0，将项目添加到队列中，并显示 OnUpdate 帧
    huoquF.updateTimer = 0
    huoquF.itemQueue[item] = item
    huoquF:Show()
end
--
YCinfo.yuancZBxinxiX = {}
local function lixian_zhuangbei()
	for i=1,19 do
		if tonumber(YCinfo.yuancZBxinxiX[i])>0 then
			local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount,itemEquipLoc,itemTexture= GetItemInfo(YCinfo.yuancZBxinxiX[i]) 
			_G["yuanchengDuixiang_item_"..i]:SetNormalTexture(itemTexture)
			if i~=4 and i~=19 then
				_G["zbBuwei_"..i].itemlink:SetText(itemLink)
				if itemLevel>0 then
					_G["yuanchengDuixiang_item_"..i].LV:SetText(itemLevel)
					if itemQuality==0 then
						_G["yuanchengDuixiang_item_"..i].LV:SetTextColor(157/255,157/255,157/255, 1);
					elseif itemQuality==1 then
						_G["yuanchengDuixiang_item_"..i].LV:SetTextColor(1, 1, 1, 1);
					elseif itemQuality==2 then
						_G["yuanchengDuixiang_item_"..i].LV:SetTextColor(30/255, 1, 0, 1);
					elseif itemQuality==3 then
						_G["yuanchengDuixiang_item_"..i].LV:SetTextColor(0,112/255,221/255, 1);
					elseif itemQuality==4 then
						_G["yuanchengDuixiang_item_"..i].LV:SetTextColor(163/255,53/255,238/255, 1);
					elseif itemQuality==5 then
						_G["yuanchengDuixiang_item_"..i].LV:SetTextColor(1,128/255,0, 1);
					elseif itemQuality==6 then
						_G["yuanchengDuixiang_item_"..i].LV:SetTextColor(230/255,204/255,128/255, 1);
					elseif itemQuality==7 then
						_G["yuanchengDuixiang_item_"..i].LV:SetTextColor(0,204/255,1, 1);
					end
				end
			end
			_G["yuanchengDuixiang_item_"..i]:SetScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				GameTooltip:SetHyperlink(itemLink)
				GameTooltip:Show();
			end);
		else
			_G["yuanchengDuixiang_item_"..i]:SetNormalTexture("")
			_G["yuanchengDuixiang_item_"..i].LV:SetText()
			if i~=4 and i~=19 then
				_G["zbBuwei_"..i].itemlink:SetText("|cff666666无|r")
			end
			_G["yuanchengDuixiang_item_"..i]:SetScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				--GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				--GameTooltip:Show();
			end);
		end
		_G["yuanchengDuixiang_item_"..i]:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
	end
	yuanchengDuixiang_UI:Show()
end
local function panduanshifouhuoquOK()
	if count(huoquF.itemQueue) > 0 then
        C_Timer.After(0.2,panduanshifouhuoquOK)
    else
    	lixian_zhuangbei()
    end
end
local function huoqumubiaoZB()
	yuanchengDuixiang_UI.biaoti.t:SetText(YCinfo.ListName);
	local renwu,zhuangbei,tianfuxinxi = strsplit("&", YCinfo.ListInfo);

	local Lv,zhongzu,zhiye = strsplit("-", renwu);
	local raceInfo = C_CreatureInfo.GetRaceInfo(zhongzu)
	local classInfo = C_CreatureInfo.GetClassInfo(zhiye)
	yuanchengDuixiang_UI.Portrait_TEX:SetTexture("interface/targetingframe/ui-classes-circles.blp")
	local coords = CLASS_ICON_TCOORDS[classInfo["classFile"]]
	yuanchengDuixiang_UI.Portrait_TEX:SetTexCoord(unpack(coords));
	yuanchengDuixiang_UI.biaoti.t1:SetText("等级"..Lv.." "..raceInfo["raceName"].." "..classInfo["className"]);
	--天赋
	local TFinfo = {strsplit("-", tianfuxinxi)};
	gengxinBG(classInfo["classFile"],Lv,TFinfo)

	local ZBinfo = {strsplit("-", zhuangbei)};
	YCinfo.yuancZBxinxiX=ZBinfo
	for i=1,19 do
		if tonumber(ZBinfo[i])>0 then
			GetItemInfoDelayed(ZBinfo[i])
		end
	end
	panduanshifouhuoquOK()
end
local function weifanhuixinxi()
	yuanchengDuixiang_UI.biaoti.t:SetText(YCinfo.ListName);
	if not YCinfo.ListInfo then
		yuanchengDuixiang_UI.Portrait_TEX:SetTexture(130899);
		yuanchengDuixiang_UI.Portrait_TEX:SetTexCoord(0,1,0,1);
		yuanchengDuixiang_UI.biaoti.t1:SetText("|cffFF0000目标尚未安装!Pig插件|r");
		for i=1,19 do
			_G["yuanchengDuixiang_item_"..i]:SetNormalTexture("")
			_G["yuanchengDuixiang_item_"..i].LV:SetText()
			if i~=4 and i~=19 then
				_G["zbBuwei_"..i].itemlink:SetText()
			end
			_G["yuanchengDuixiang_item_"..i]:SetScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				GameTooltip:Show();
			end);
			_G["yuanchengDuixiang_item_"..i]:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
		end
		yuanchengDuixiang_UI.TalentF.L_TOPLEFT:SetTexture("");
		yuanchengDuixiang_UI.TalentF.L_TOPRIGHT:SetTexture("");
		yuanchengDuixiang_UI.TalentF.L_BOTTOMLEFT:SetTexture("");
		yuanchengDuixiang_UI.TalentF.L_BOTTOMRIGHT:SetTexture("");
		--
		yuanchengDuixiang_UI.TalentF.C_TOPLEFT:SetTexture("");
		yuanchengDuixiang_UI.TalentF.C_TOPRIGHT:SetTexture("");
		yuanchengDuixiang_UI.TalentF.C_BOTTOMLEFT:SetTexture("");
		yuanchengDuixiang_UI.TalentF.C_BOTTOMRIGHT:SetTexture("");
		---
		yuanchengDuixiang_UI.TalentF.R_TOPLEFT:SetTexture("");
		yuanchengDuixiang_UI.TalentF.R_TOPRIGHT:SetTexture("");
		yuanchengDuixiang_UI.TalentF.R_BOTTOMLEFT:SetTexture("");
		yuanchengDuixiang_UI.TalentF.R_BOTTOMRIGHT:SetTexture("");

		for i=1,3 do
			_G["TalentFYIDIAN"..i]:SetText();
			for ii=1,PIGtianfuhangshu do
				for iii=1,4 do
					_G["tianfuBUT_"..i.."_"..ii.."_"..iii]:Hide();
				end
			end
		end
		yuanchengDuixiang_UI.TalentF.biaoti:SetText();
		yuanchengDuixiang_UI:Show()
	end
end
----------------------------
--右键增强
local function fasongqingqiuYC(fullnameX)
	YCinfo.ListName=fullnameX
	YCinfo.ListInfo=nil
	C_ChatInfo.SendAddonMessage(biaotou,YCinfo.shenqing, "WHISPER", fullnameX)
	C_Timer.After(2,weifanhuixinxi)
end
addonTable.YCchaokanzhuangbei=fasongqingqiuYC
local function ClickGongNeng(menuName)
	local unitX = UIDROPDOWNMENU_INIT_MENU.unit
	local nameX = UIDROPDOWNMENU_INIT_MENU.name
	local serverX = UIDROPDOWNMENU_INIT_MENU.server
	local fullnameX = nameX
	local realmName = GetRealmName();
	if unitX then
		fullnameX = GetUnitName(unitX, true)
	else
		if serverX and serverX~=realmName then fullnameX = nameX.."-"..serverX end
	end
	
	if menuName=="目标信息" then
		C_FriendList.SendWho(fullnameX)
	end
	if menuName=="添加好友" then
		C_FriendList.AddFriend(fullnameX)
	end
	if menuName=="邀请入会" then
		GuildInvite(fullnameX)
	end
	if menuName=="复制名字" then
		local editBoxXX
		editBoxXX = ChatEdit_ChooseBoxForSend()
        local hasText = (editBoxXX:GetText() ~= "")
        ChatEdit_ActivateChat(editBoxXX)
		editBoxXX:Insert(fullnameX)
        if (not hasText) then editBoxXX:HighlightText() end
	end
	if menuName=="查看装备" then
		fasongqingqiuYC(fullnameX)
	end
end
-- -- --------------
local function RightPlus_Open()
	if DropDownList1.RightF then return end
	local listName={"目标信息","添加好友","邀请入会","复制名字","查看装备"}
	local caidanW,caidanH=86,20

	local beijingico=DropDownList1MenuBackdrop.NineSlice.Center:GetTexture()
	local beijing1,beijing2,beijing3,beijing4=DropDownList1MenuBackdrop.NineSlice.Center:GetVertexColor()
	local Biankuang1,Biankuang2,Biankuang3,Biankuang4=DropDownList1MenuBackdrop:GetBackdropBorderColor()
	DropDownList1.RightF = CreateFrame("Frame", nil, DropDownList1,"BackdropTemplate");
	DropDownList1.RightF:SetBackdrop( { bgFile = beijingico,
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 14, 
		insets = { left = 4, right = 4, top = 4, bottom = 4 } });
	DropDownList1.RightF:SetBackdropBorderColor(Biankuang1,Biankuang2,Biankuang3,Biankuang4);
	DropDownList1.RightF:SetBackdropColor(beijing1,beijing2,beijing3,beijing4);
	DropDownList1.RightF:SetSize(caidanW,caidanH*#listName+12);
	DropDownList1.RightF:SetPoint("TOPLEFT",DropDownList1,"TOPRIGHT",-2,0);
	DropDownList1.RightF:Hide();
	------
	for i=1,#listName do
		DropDownList1.RightF.TAB = CreateFrame("Frame", "RightF_TAB_"..i, DropDownList1.RightF);
		DropDownList1.RightF.TAB:SetSize(caidanW,caidanH);
		if i==1 then
			DropDownList1.RightF.TAB:SetPoint("TOPLEFT", DropDownList1.RightF, "TOPLEFT", 4, -6);
		else
			DropDownList1.RightF.TAB:SetPoint("TOPLEFT", _G["RightF_TAB_"..(i-1)], "BOTTOMLEFT", 0, 0);
		end
		DropDownList1.RightF.TAB.Title = DropDownList1.RightF.TAB:CreateFontString();
		DropDownList1.RightF.TAB.Title:SetPoint("LEFT", DropDownList1.RightF.TAB, "LEFT", 6, 0);
		DropDownList1.RightF.TAB.Title:SetFontObject(GameFontNormal);
		DropDownList1.RightF.TAB.Title:SetTextColor(1,1,1, 1);
		DropDownList1.RightF.TAB.Title:SetText(listName[i]);
		DropDownList1.RightF.TAB.highlight1 = DropDownList1.RightF.TAB:CreateTexture(nil, "BORDER");
		DropDownList1.RightF.TAB.highlight1:SetTexture("interface/buttons/ui-listbox-highlight.blp");
		DropDownList1.RightF.TAB.highlight1:SetPoint("CENTER", DropDownList1.RightF.TAB, "CENTER", -3,0);
		DropDownList1.RightF.TAB.highlight1:SetSize(70,16);
		DropDownList1.RightF.TAB.highlight1:SetAlpha(0.9);
		DropDownList1.RightF.TAB.highlight1:Hide();
		DropDownList1.RightF.TAB:SetScript("OnEnter", function(self)
			self.highlight1:Show()
		end);
		DropDownList1.RightF.TAB:SetScript("OnLeave", function(self)
			self.highlight1:Hide()
		end);
		DropDownList1.RightF.TAB:SetScript("OnMouseDown", function(self)
			self.Title:SetPoint("LEFT", self, "LEFT", 7.4, -1.4);
		end);
		DropDownList1.RightF.TAB:SetScript("OnMouseUp", function(self)
			self.Title:SetPoint("LEFT", self, "LEFT", 6, 0);
			DropDownList1.RightF:Hide();
			DropDownList1:Hide();
			ClickGongNeng(self.Title:GetText())
		end);
	end
	--------2
	local listName2={"邀请入会","复制名字","查看装备"}
	DropDownList1.RightF2 = CreateFrame("Frame", nil, DropDownList1,"BackdropTemplate");
	DropDownList1.RightF2:SetBackdrop( { bgFile = beijingico,
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 14, 
		insets = { left = 4, right = 4, top = 4, bottom = 4 } });
	DropDownList1.RightF2:SetBackdropColor(beijing1,beijing2,beijing3,beijing4);
	DropDownList1.RightF2:SetSize(caidanW,caidanH*#listName2+12);
	DropDownList1.RightF2:SetPoint("TOPLEFT",DropDownList1,"TOPRIGHT",-2,0);
	DropDownList1.RightF2:Hide();
	------
	for i=1,#listName2 do
		DropDownList1.RightF2.TAB = CreateFrame("Frame", "RightF_TAB_"..i, DropDownList1.RightF2);
		DropDownList1.RightF2.TAB:SetSize(caidanW,caidanH);
		if i==1 then
			DropDownList1.RightF2.TAB:SetPoint("TOPLEFT", DropDownList1.RightF2, "TOPLEFT", 4, -6);
		else
			DropDownList1.RightF2.TAB:SetPoint("TOPLEFT", _G["RightF_TAB_"..(i-1)], "BOTTOMLEFT", 0, 0);
		end
		DropDownList1.RightF2.TAB.Title = DropDownList1.RightF2.TAB:CreateFontString();
		DropDownList1.RightF2.TAB.Title:SetPoint("LEFT", DropDownList1.RightF2.TAB, "LEFT", 6, 0);
		DropDownList1.RightF2.TAB.Title:SetFontObject(GameFontNormal);
		DropDownList1.RightF2.TAB.Title:SetTextColor(1,1,1, 1);
		DropDownList1.RightF2.TAB.Title:SetText(listName2[i]);
		DropDownList1.RightF2.TAB.highlight1 = DropDownList1.RightF2.TAB:CreateTexture(nil, "BORDER");
		DropDownList1.RightF2.TAB.highlight1:SetTexture("interface/buttons/ui-listbox-highlight.blp");
		DropDownList1.RightF2.TAB.highlight1:SetPoint("CENTER", DropDownList1.RightF2.TAB, "CENTER", -3,0);
		DropDownList1.RightF2.TAB.highlight1:SetSize(70,16);
		DropDownList1.RightF2.TAB.highlight1:SetAlpha(0.9);
		DropDownList1.RightF2.TAB.highlight1:Hide();
		DropDownList1.RightF2.TAB:SetScript("OnEnter", function(self)
			self.highlight1:Show()
		end);
		DropDownList1.RightF2.TAB:SetScript("OnLeave", function(self)
			self.highlight1:Hide()
		end);
		DropDownList1.RightF2.TAB:SetScript("OnMouseDown", function(self)
			self.Title:SetPoint("LEFT", self, "LEFT", 7.4, -1.4);
		end);
		DropDownList1.RightF2.TAB:SetScript("OnMouseUp", function(self)
			self.Title:SetPoint("LEFT", self, "LEFT", 6, 0);
			DropDownList1.RightF2:Hide();
			DropDownList1:Hide();
			ClickGongNeng(self.Title:GetText())
		end);
	end
	hooksecurefunc("UnitPopup_ShowMenu", function(dropdownMenu, which, unit, name)
		--print(dropdownMenu:GetName())print(which)print(unit)print(name)
        if (UIDROPDOWNMENU_MENU_LEVEL > 1) then return end
		DropDownList1.RightF:Hide();
		DropDownList1.RightF2:Hide();
        ---------
        if dropdownMenu:GetName() == "FriendsDropDown" then
	        if which == "FRIEND" or which == "CHAT_ROSTER" then
	        	DropDownList1.RightF:Show();
	        end
	    end
    	if which == "CHAT_ROSTER" then
        	DropDownList1.RightF:Show();
        end

		if which == "PLAYER" or which == "PARTY" or which == "RAID_PLAYER" then
			DropDownList1.RightF2:Show();
		end
    end)

    DropDownList1:HookScript("OnHide", function()
    	DropDownList1.RightF:Hide();
		DropDownList1.RightF2:Hide();
    end)

    fuFrame.xiayiRPSlider.Text:SetText(PIG['ChatFrame']['xiayijuli']);
	fuFrame.xiayiRPSlider:SetValue(PIG['ChatFrame']['xiayijuli']);
	--远程查看装备天赋===========================
	local BKdangeW=CharacterHeadSlot:GetWidth()+5
	local yuanchengDuixiang = CreateFrame("Frame", "yuanchengDuixiang_UI", UIParent,"BackdropTemplate");
	yuanchengDuixiang:SetSize(360,444);
	yuanchengDuixiang:SetPoint("CENTER", UIParent, "CENTER", -300, 100)
	yuanchengDuixiang:SetMovable(true)
	yuanchengDuixiang:SetUserPlaced(false)
	yuanchengDuixiang:SetClampedToScreen(true)
	yuanchengDuixiang:SetFrameLevel(210)
	yuanchengDuixiang:Hide();
	tinsert(UISpecialFrames,"yuanchengDuixiang_UI");

	yuanchengDuixiang.Portrait_BG = yuanchengDuixiang:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.Portrait_BG:SetTexture("interface/buttons/iconborder-glowring.blp");
	yuanchengDuixiang.Portrait_BG:SetSize(57,57);
	yuanchengDuixiang.Portrait_BG:SetPoint("TOPLEFT",yuanchengDuixiang,"TOPLEFT",11,-7.8);
	yuanchengDuixiang.Portrait_BG:SetDrawLayer("BORDER", -2)
	yuanchengDuixiang.Portrait_BGmask = yuanchengDuixiang:CreateMaskTexture()
	yuanchengDuixiang.Portrait_BGmask:SetAllPoints(yuanchengDuixiang.Portrait_BG)
	yuanchengDuixiang.Portrait_BGmask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	yuanchengDuixiang.Portrait_BG:AddMaskTexture(yuanchengDuixiang.Portrait_BGmask)
	yuanchengDuixiang.Portrait_TEX = yuanchengDuixiang:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.Portrait_TEX:SetDrawLayer("BORDER", -1)
	yuanchengDuixiang.Portrait_TEX:SetAllPoints(yuanchengDuixiang.Portrait_BG)
	yuanchengDuixiang.TOPLEFT = yuanchengDuixiang:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TOPLEFT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-l1.blp");
	yuanchengDuixiang.TOPLEFT:SetPoint("TOPLEFT", yuanchengDuixiang, "TOPLEFT",0, 0);
	yuanchengDuixiang.TOPRIGHT = yuanchengDuixiang:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TOPRIGHT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-r1.blp");
	yuanchengDuixiang.TOPRIGHT:SetPoint("TOPLEFT", yuanchengDuixiang.TOPLEFT, "TOPRIGHT",0, 0);
	yuanchengDuixiang.BOTTOMLEFT = yuanchengDuixiang:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.BOTTOMLEFT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-bottomleft.blp");
	yuanchengDuixiang.BOTTOMLEFT:SetPoint("TOPLEFT", yuanchengDuixiang.TOPLEFT, "BOTTOMLEFT",0, 0);
	yuanchengDuixiang.BOTTOMRIGHT = yuanchengDuixiang:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.BOTTOMRIGHT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-bottomright.blp");
	yuanchengDuixiang.BOTTOMRIGHT:SetPoint("TOPLEFT", yuanchengDuixiang.BOTTOMLEFT, "TOPRIGHT",0, 0);

	yuanchengDuixiang.biaoti = CreateFrame("Frame", nil, yuanchengDuixiang)
	yuanchengDuixiang.biaoti:SetPoint("TOPLEFT", yuanchengDuixiang, "TOPLEFT",72, -14);
	yuanchengDuixiang.biaoti:SetPoint("TOPRIGHT", yuanchengDuixiang, "TOPRIGHT",-36, -1);
	yuanchengDuixiang.biaoti:SetHeight(20);
	yuanchengDuixiang.biaoti:EnableMouse(true)
	yuanchengDuixiang.biaoti:RegisterForDrag("LeftButton")
	yuanchengDuixiang.biaoti:SetScript("OnDragStart",function()
	    yuanchengDuixiang:StartMoving();
	    yuanchengDuixiang:SetUserPlaced(false)
	end)
	yuanchengDuixiang.biaoti:SetScript("OnDragStop",function()
	    yuanchengDuixiang:StopMovingOrSizing()
	    yuanchengDuixiang:SetUserPlaced(false)
	end)
	yuanchengDuixiang.biaoti.t = yuanchengDuixiang:CreateFontString();
	yuanchengDuixiang.biaoti.t:SetPoint("CENTER", yuanchengDuixiang.biaoti, "CENTER", 2, -1);
	yuanchengDuixiang.biaoti.t:SetFontObject(GameFontNormal);
	yuanchengDuixiang.biaoti.t:SetTextColor(1, 1, 1, 1);

	yuanchengDuixiang.biaoti.t1 = yuanchengDuixiang:CreateFontString();
	yuanchengDuixiang.biaoti.t1:SetPoint("CENTER", yuanchengDuixiang.biaoti, "CENTER", 2, -24);
	yuanchengDuixiang.biaoti.t1:SetFontObject(GameFontNormal);

	yuanchengDuixiang.Close = CreateFrame("Button",nil,yuanchengDuixiang, "UIPanelCloseButton");
	yuanchengDuixiang.Close:SetSize(32,32);
	yuanchengDuixiang.Close:SetPoint("TOPRIGHT",yuanchengDuixiang,"TOPRIGHT",-3.2,-8.6);
	local zhuangbeishunxuID = {1,2,3,15,5,4,19,9,10,6,7,8,11,12,13,14,16,17,18}
	for i=1,#zhuangbeishunxuID do
		yuanchengDuixiang.item = CreateFrame("Button", "yuanchengDuixiang_item_"..zhuangbeishunxuID[i], yuanchengDuixiang, "TruncatedButtonTemplate");
		yuanchengDuixiang.item:SetHighlightTexture(130718);
		yuanchengDuixiang.item:SetSize(BKdangeW-4,BKdangeW-4);
		if i<17 then
			if i==1 then
				yuanchengDuixiang.item:SetPoint("TOPLEFT",yuanchengDuixiang,"TOPLEFT",20,-74);
			elseif i==9 then
				yuanchengDuixiang.item:SetPoint("TOPLEFT",yuanchengDuixiang,"TOPLEFT",305,-74);
			else
				yuanchengDuixiang.item:SetPoint("TOP", _G["yuanchengDuixiang_item_"..(zhuangbeishunxuID[i-1])], "BOTTOM", 0, -3);
			end
		else
			if i==17 then
				yuanchengDuixiang.item:SetPoint("TOPLEFT",yuanchengDuixiang,"TOPLEFT",121,-385);
			else
				yuanchengDuixiang.item:SetPoint("LEFT", _G["yuanchengDuixiang_item_"..(zhuangbeishunxuID[i-1])], "RIGHT", 3, 0);
			end
		end
		yuanchengDuixiang.item.LV = yuanchengDuixiang.item:CreateFontString();
		yuanchengDuixiang.item.LV:SetPoint("TOPRIGHT", yuanchengDuixiang.item, "TOPRIGHT", 0,-1);
		yuanchengDuixiang.item.LV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	end
	local zhuangbeizhanshiID = {1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18}
	local buweiName = {HEADSLOT,NECKSLOT,SHOULDERSLOT,CHESTSLOT,WAISTSLOT,LEGSSLOT,FEETSLOT,WRISTSLOT,HANDSSLOT,FINGER0SLOT,FINGER1SLOT,TRINKET0SLOT,TRINKET1SLOT,BACKSLOT,MAINHANDSLOT,SECONDARYHANDSLOT,RANGEDSLOT}
	for i=1,#zhuangbeizhanshiID do
		local zbBuwei = CreateFrame("Frame", "zbBuwei_"..zhuangbeizhanshiID[i], yuanchengDuixiang,"BackdropTemplate");
		zbBuwei:SetSize(40,17);
		if i==1 then
			zbBuwei:SetPoint("TOPLEFT",yuanchengDuixiang,"TOPLEFT",70,-80);
		else
			zbBuwei:SetPoint("TOPLEFT",_G["zbBuwei_"..(zhuangbeizhanshiID[i-1])],"BOTTOMLEFT",0,0);
		end
		zbBuwei.itembuwei = zbBuwei:CreateFontString();
		zbBuwei.itembuwei:SetPoint("RIGHT",zbBuwei,"RIGHT",0,0);
		zbBuwei.itembuwei:SetFontObject(GameFontNormal);
		zbBuwei.itembuwei:SetText(buweiName[i])
		zbBuwei.itemlink = zbBuwei:CreateFontString();
		zbBuwei.itemlink:SetPoint("LEFT",zbBuwei.itembuwei,"RIGHT",6,0);
		zbBuwei.itemlink:SetFontObject(GameFontNormal);
	end

	--天赋----------------------------
	yuanchengDuixiang.TalentF = CreateFrame("Frame", nil, yuanchengDuixiang,"BackdropTemplate");
	yuanchengDuixiang.TalentF:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 16, 
		insets = { left = 4, right = 4, top = 4, bottom = 4 }});
	yuanchengDuixiang.TalentF:SetSize(tianfuW+140,tianfuH);
	yuanchengDuixiang.TalentF:SetPoint("TOPLEFT", yuanchengDuixiang, "TOPRIGHT", -8, -14)
	yuanchengDuixiang.TalentF:Hide()
	yuanchengDuixiang.TalentF.L_TOPLEFT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.L_TOPLEFT:SetSize(tianfuW/3,tianfuH-104);
	yuanchengDuixiang.TalentF.L_TOPLEFT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF, "TOPLEFT",4, -24);
	yuanchengDuixiang.TalentF.L_TOPRIGHT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.L_TOPRIGHT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF.L_TOPLEFT, "TOPRIGHT",0, 0);
	yuanchengDuixiang.TalentF.L_TOPRIGHT:SetPoint("BOTTOMLEFT", yuanchengDuixiang.TalentF.L_TOPLEFT, "BOTTOMRIGHT",0, 0);
	yuanchengDuixiang.TalentF.L_BOTTOMLEFT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.L_BOTTOMLEFT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF.L_TOPLEFT, "BOTTOMLEFT",0, 0);
	yuanchengDuixiang.TalentF.L_BOTTOMLEFT:SetPoint("TOPRIGHT", yuanchengDuixiang.TalentF.L_TOPLEFT, "BOTTOMRIGHT",0, 0);
	yuanchengDuixiang.TalentF.L_BOTTOMRIGHT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.L_BOTTOMRIGHT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF.L_BOTTOMLEFT, "TOPRIGHT",0, 0);
	---
	yuanchengDuixiang.TalentF.C_TOPLEFT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.C_TOPLEFT:SetWidth(tianfuW/3);
	yuanchengDuixiang.TalentF.C_TOPLEFT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF.L_TOPRIGHT, "TOPRIGHT",-20, 0);
	yuanchengDuixiang.TalentF.C_TOPLEFT:SetPoint("BOTTOMLEFT", yuanchengDuixiang.TalentF.L_TOPRIGHT, "BOTTOMRIGHT",-20, 0);
	yuanchengDuixiang.TalentF.C_TOPRIGHT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.C_TOPRIGHT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF.C_TOPLEFT, "TOPRIGHT",0, 0);
	yuanchengDuixiang.TalentF.C_TOPRIGHT:SetPoint("BOTTOMLEFT", yuanchengDuixiang.TalentF.C_TOPLEFT, "BOTTOMRIGHT",0, 0);
	yuanchengDuixiang.TalentF.C_BOTTOMLEFT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.C_BOTTOMLEFT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF.C_TOPLEFT, "BOTTOMLEFT",0, 0);
	yuanchengDuixiang.TalentF.C_BOTTOMLEFT:SetPoint("TOPRIGHT", yuanchengDuixiang.TalentF.C_TOPLEFT, "BOTTOMRIGHT",0, 0);
	yuanchengDuixiang.TalentF.C_BOTTOMRIGHT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.C_BOTTOMRIGHT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF.C_BOTTOMLEFT, "TOPRIGHT",0, 0);
	---
	yuanchengDuixiang.TalentF.R_TOPLEFT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.R_TOPLEFT:SetWidth(tianfuW/3);
	yuanchengDuixiang.TalentF.R_TOPLEFT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF.C_TOPRIGHT, "TOPRIGHT",-20, 0);
	yuanchengDuixiang.TalentF.R_TOPLEFT:SetPoint("BOTTOMLEFT", yuanchengDuixiang.TalentF.C_TOPRIGHT, "BOTTOMRIGHT",-20, 0);
	yuanchengDuixiang.TalentF.R_TOPRIGHT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.R_TOPRIGHT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF.R_TOPLEFT, "TOPRIGHT",0, 0);
	yuanchengDuixiang.TalentF.R_TOPRIGHT:SetPoint("BOTTOMLEFT", yuanchengDuixiang.TalentF.R_TOPLEFT, "BOTTOMRIGHT",0, 0);
	yuanchengDuixiang.TalentF.R_BOTTOMLEFT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.R_BOTTOMLEFT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF.R_TOPLEFT, "BOTTOMLEFT",0, 0);
	yuanchengDuixiang.TalentF.R_BOTTOMLEFT:SetPoint("TOPRIGHT", yuanchengDuixiang.TalentF.R_TOPLEFT, "BOTTOMRIGHT",0, 0);
	yuanchengDuixiang.TalentF.R_BOTTOMRIGHT = yuanchengDuixiang.TalentF:CreateTexture(nil, "BORDER");
	yuanchengDuixiang.TalentF.R_BOTTOMRIGHT:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF.R_BOTTOMLEFT, "TOPRIGHT",0, 0);
	--
	yuanchengDuixiang.TalentF.biaoti = yuanchengDuixiang.TalentF:CreateFontString();
	yuanchengDuixiang.TalentF.biaoti:SetPoint("TOP", yuanchengDuixiang.TalentF, "TOP", 0,-6);
	yuanchengDuixiang.TalentF.biaoti:SetFontObject(GameFontNormal);
	--
	yuanchengDuixiang.TalentF.ZJ1 = yuanchengDuixiang.TalentF:CreateFontString("TalentFYIDIAN1");
	yuanchengDuixiang.TalentF.ZJ1:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF, "TOPLEFT", 84,-27);
	yuanchengDuixiang.TalentF.ZJ1:SetFontObject(GameFontNormal);
	yuanchengDuixiang.TalentF.ZJ2 = yuanchengDuixiang.TalentF:CreateFontString("TalentFYIDIAN2");
	yuanchengDuixiang.TalentF.ZJ2:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF, "TOPLEFT", 300,-27);
	yuanchengDuixiang.TalentF.ZJ2:SetFontObject(GameFontNormal);
	yuanchengDuixiang.TalentF.ZJ3 = yuanchengDuixiang.TalentF:CreateFontString("TalentFYIDIAN3");
	yuanchengDuixiang.TalentF.ZJ3:SetPoint("TOPLEFT", yuanchengDuixiang.TalentF, "TOPLEFT", 510,-27);
	yuanchengDuixiang.TalentF.ZJ3:SetFontObject(GameFontNormal);
	---
	local tianfuB= 30
	for i=1,3 do
		for ii=1,PIGtianfuhangshu do
			for iii=1,4 do
				local tianfuBUT = CreateFrame("Button", "tianfuBUT_"..i.."_"..ii.."_"..iii, yuanchengDuixiang.TalentF, "SecureActionButtonTemplate");
				tianfuBUT:SetHighlightTexture(130718);
				tianfuBUT:SetSize(tianfuB,tianfuB);
				if i==1 then
					if ii==1 then
						if iii==1 then
							tianfuBUT:SetPoint("TOPLEFT",yuanchengDuixiang.TalentF,"TOPLEFT",20,-50);
						else
							tianfuBUT:SetPoint("LEFT", _G["tianfuBUT_"..i.."_"..ii.."_"..(iii-1)], "RIGHT", 20, 0);
						end
					else
						if iii==1 then
							tianfuBUT:SetPoint("TOP",_G["tianfuBUT_"..i.."_"..(ii-1).."_"..iii],"BOTTOM", 0, -20);
						else
							tianfuBUT:SetPoint("LEFT", _G["tianfuBUT_"..i.."_"..ii.."_"..(iii-1)], "RIGHT", 20, 0);
						end
					end
				elseif i==2 then
					if ii==1 then
						if iii==1 then
							tianfuBUT:SetPoint("TOPLEFT",yuanchengDuixiang.TalentF,"TOPLEFT",236,-50);
						else
							tianfuBUT:SetPoint("LEFT", _G["tianfuBUT_"..i.."_"..ii.."_"..(iii-1)], "RIGHT", 20, 0);
						end
					else
						if iii==1 then
							tianfuBUT:SetPoint("TOP",_G["tianfuBUT_"..i.."_"..(ii-1).."_"..iii],"BOTTOM", 0, -20);
						else
							tianfuBUT:SetPoint("LEFT", _G["tianfuBUT_"..i.."_"..ii.."_"..(iii-1)], "RIGHT", 20, 0);
						end
					end
				elseif i==3 then
					if ii==1 then
						if iii==1 then
							tianfuBUT:SetPoint("TOPLEFT",yuanchengDuixiang.TalentF,"TOPLEFT",444,-50);
						else
							tianfuBUT:SetPoint("LEFT", _G["tianfuBUT_"..i.."_"..ii.."_"..(iii-1)], "RIGHT", 20, 0);
						end
					else
						if iii==1 then
							tianfuBUT:SetPoint("TOP",_G["tianfuBUT_"..i.."_"..(ii-1).."_"..iii],"BOTTOM", 0, -20);
						else
							tianfuBUT:SetPoint("LEFT", _G["tianfuBUT_"..i.."_"..ii.."_"..(iii-1)], "RIGHT", 20, 0);
						end
					end
				end
				tianfuBUT.Border = tianfuBUT:CreateTexture(nil, "BORDER");
				tianfuBUT.Border:SetTexture(130841);
				tianfuBUT.Border:SetPoint("TOPLEFT",tianfuBUT,"TOPLEFT",-10,10);
				tianfuBUT.Border:SetPoint("BOTTOMRIGHT",tianfuBUT,"BOTTOMRIGHT",10,-10);
				tianfuBUT.Icon = tianfuBUT:CreateTexture(nil, "BORDER");
				tianfuBUT.Icon:SetPoint("TOPLEFT",tianfuBUT,"TOPLEFT",0,0);
				tianfuBUT.Icon:SetPoint("BOTTOMRIGHT",tianfuBUT,"BOTTOMRIGHT",0,0);
				tianfuBUT.dianshuBG = tianfuBUT:CreateTexture(nil, "ARTWORK");
				tianfuBUT.dianshuBG:SetTexture("interface/talentframe/talentframe-rankborder.blp");
				tianfuBUT.dianshuBG:SetSize(tianfuB*1.74,tianfuB);
				tianfuBUT.dianshuBG:SetPoint("BOTTOMRIGHT",tianfuBUT,"BOTTOMRIGHT",25,-14);
				tianfuBUT.dianshu = tianfuBUT:CreateFontString();
				tianfuBUT.dianshu:SetPoint("CENTER", tianfuBUT.dianshuBG, "CENTER", 1,2);
				tianfuBUT.dianshu:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");
			end
		end
	end

	---====
	yuanchengDuixiang.Talent = CreateFrame("Button", nil, yuanchengDuixiang, "TruncatedButtonTemplate");
	yuanchengDuixiang.Talent:SetNormalTexture("interface/buttons/ui-spellbookicon-nextpage-up.blp")
	yuanchengDuixiang.Talent:SetPushedTexture("interface/buttons/ui-spellbookicon-nextpage-down.blp")
	yuanchengDuixiang.Talent:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	yuanchengDuixiang.Talent:SetSize(26,26);
	yuanchengDuixiang.Talent:SetPoint("BOTTOMRIGHT",yuanchengDuixiang,"BOTTOMRIGHT",-20,14);
	yuanchengDuixiang.Talent:SetScript("OnClick", function (self)
		if yuanchengDuixiang.TalentF:IsShown() then
			self:SetNormalTexture("interface/buttons/ui-spellbookicon-nextpage-up.blp")
			self:SetPushedTexture("interface/buttons/ui-spellbookicon-nextpage-down.blp")
			yuanchengDuixiang.TalentF:Hide()
		else
			self:SetNormalTexture("interface/buttons/ui-spellbookicon-prevpage-up.blp")
			self:SetPushedTexture("interface/buttons/ui-spellbookicon-prevpage-down.blp")
			yuanchengDuixiang.TalentF:Show()
		end
	end);
end

---------------------
fuFrame.RightPlus = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.RightPlus:SetSize(30,32);
fuFrame.RightPlus:SetHitRectInsets(0,-80,0,0);
fuFrame.RightPlus:SetPoint("TOPLEFT",fuFrame.RP,"TOPLEFT",20,-10);
fuFrame.RightPlus.Text:SetText("右键增强");
fuFrame.RightPlus.tooltip = "增强交互时右键功能，例如点击聊天栏玩家名/查询页玩家名！";
fuFrame.RightPlus:SetScript("OnClick", function (self)
    if self:GetChecked() then
        PIG['ChatFrame']['RightPlus']="ON";
        RightPlus_Open();
        fuFrame.xiayiRPSlider:Enable();
    else
        PIG['ChatFrame']['RightPlus']="OFF";
        fuFrame.xiayiRPSlider:Disable();
        Pig_Options_RLtishi_UI:Show()
    end
end);

fuFrame.xiayiRP = fuFrame:CreateFontString();
fuFrame.xiayiRP:SetPoint("LEFT",fuFrame.RightPlus.Text,"RIGHT",10,0);
fuFrame.xiayiRP:SetFontObject(GameFontNormal);
fuFrame.xiayiRP:SetText("下移增强菜单：");
fuFrame.xiayiRPSlider = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.xiayiRPSlider:SetSize(100,14);
fuFrame.xiayiRPSlider:SetPoint("LEFT",fuFrame.xiayiRP,"RIGHT",10,0);
fuFrame.xiayiRPSlider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.xiayiRPSlider.Low:SetText('0');
fuFrame.xiayiRPSlider.High:SetText('100');
fuFrame.xiayiRPSlider:SetMinMaxValues(0, 100);
fuFrame.xiayiRPSlider:SetValueStep(1);
fuFrame.xiayiRPSlider:SetObeyStepOnDrag(true);
fuFrame.xiayiRPSlider:Disable();

fuFrame.xiayiRPSlider:EnableMouseWheel(true);--接受滚轮输入
fuFrame.xiayiRPSlider:SetScript("OnMouseWheel", function(self, arg1)
	if self:IsEnabled() then
		local step = 1 * arg1
		local value = self:GetValue()
		if step > 0 then
			self:SetValue(min(value + step, 100))
		else
			self:SetValue(max(value + step, 0))
		end
	end
end)
fuFrame.xiayiRPSlider:SetScript('OnValueChanged', function(self)
	local val = self:GetValue()
	self.Text:SetText(val);
	DropDownList1.RightF:SetPoint("TOPLEFT",DropDownList1,"TOPRIGHT",0,-val);
	DropDownList1.RightF2:SetPoint("TOPLEFT",DropDownList1,"TOPRIGHT",0,-val);
	PIG['ChatFrame']['xiayijuli']=val
end)
--------------------------------------
local yuanchangchakanFFF = CreateFrame("Frame")
yuanchangchakanFFF:RegisterEvent("CHAT_MSG_ADDON");     
yuanchangchakanFFF:SetScript("OnEvent",function(self, event, arg1, arg2, _, _, arg5,_,_,_,arg9)
	local function SAVE_C()
		local raceName, raceFile, raceID = UnitRace("player")
		local _, classId = UnitClassBase("player");
		local level = UnitLevel("player")
		local wupinshujuinfo = level.."-"..raceID.."-"..classId.."&"

		for inv = 1, 19 do
			local itemID=GetInventoryItemID("player", inv)
			if inv==19 then
				if itemID then
					wupinshujuinfo=wupinshujuinfo..itemID;
				else
					wupinshujuinfo=wupinshujuinfo.."0";
				end
			else
				if itemID then
					wupinshujuinfo=wupinshujuinfo..itemID.."-";
				else
					wupinshujuinfo=wupinshujuinfo.."0-";
				end
			end
			--local itemLink=GetInventoryItemLink("player", inv)
			-- if itemLink then
			-- 	wupinshujuinfo=wupinshujuinfo.."&"..itemLink;
			-- else
			-- 	wupinshujuinfo=wupinshujuinfo.."&"..itemLink;
			-- end		
		end
		return wupinshujuinfo
	end
	local function SAVE_TIANFU()
		local tianfuinfo = ""
		local numTabs = GetNumTalentTabs()
		for i=1,numTabs do
			--local name, texture, pointsSpent, fileName = GetTalentTabInfo(index)
			local XXX=GetNumTalents(i)
			for ii=1,XXX do
				local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(i, ii)
				if ii==XXX then
					if i==numTabs then
						tianfuinfo=tianfuinfo..rank
					else
						tianfuinfo=tianfuinfo..rank.."-"
					end
				else
					tianfuinfo=tianfuinfo..rank.."-"
				end
			end
		end
		return tianfuinfo
	end
	if event=="CHAT_MSG_ADDON" and arg1 == biaotou then
		if arg2==YCinfo.shenqing then
			local wupinxinxi =SAVE_C()
			local tianfuxinxi =SAVE_TIANFU()
			local xinxi =wupinxinxi.."&"..tianfuxinxi
			C_ChatInfo.SendAddonMessage(biaotou,xinxi, "WHISPER", arg5)
		else
			YCinfo.ListInfo=arg2
			huoqumubiaoZB()
		end
	end
end)
--=====================================
addonTable.Interaction_RightPlus = function()
	PIG['ChatFrame']['xiayijuli']=PIG['ChatFrame']['xiayijuli'] or addonTable.Default['ChatFrame']['xiayijuli']
    if PIG['ChatFrame']['RightPlus']=="ON" then
        fuFrame.RightPlus:SetChecked(true);
        RightPlus_Open();
        fuFrame.xiayiRPSlider:Enable();
    end
end