local _, addonTable = ...;

addonTable.PIG = {
	["AKF"]={
		["Open"] = true,
		['QuickButton']=true,
	},
	["AHPlus"]={
		["Open"] = true,
		["AHtooltip"] = true,
		["Time"] = 48,
		["Tokens"] = {},
		["Coll"] = {},
		["Data"] = {},
		["DaojiTime"] = 0,
	},
	["daiben"]={
		["Point"]={"CENTER","CENTER",0,200},
		["hanhua_pindao"]={},
	},
	["QuickButton"]={
		["Open"] = true,
		["Point"]={"BOTTOM","BOTTOM",200,200},
		["bili"]=0.8,
		["suoding"]=false,
		["Lushi"]=true,
		["Spell"]=true,
		["AutoEquip"]=true,
	},
	["QuickFollow"] = {
		["QuickBut"] = true,
		["Name"] = "猪猪加油",
		["Kaishi"] = "1",
		["Jieshu"] = "2",
		["Duizhang"] = true,
		["Tishi"] = false,
		["Qiangli"]=false,
		["Jiuwei"] = true,
		["Yijiao"]=true,
	},
	["RaidFrame"]={
		["xiufu"] = "OFF",
	},
	["PlaneInvite"]={
		["Kaiqi"] = "ON",
		["AddBut"] = "ON",
		["zidongjieshou"]="ON",
		["WeimianList"]={},
	},
	["ShowPlus"] = {
		["ItemSell"] = "ON",
		["ItemLevel"] = "ON",
		["SpellID"] = "ON",
	},
	["zhegnheBAG"]={
		["BAGkongyu"]="ON",
		["Open"] = "ON",
		["SortBagsRightToLeft"] = false,
		["JianjieMOD"] = false,
		["hulueBAG"] = {false,false,false,false,false},
		["hulueBANK"] = {false,false,false,false,false,false,false,false},
		["lixian"] = {},
		["SortBag_Config"]=true,
		["qitashulaing"]=true,
		["qitajinbi"]=true,
		["wupinLV"]=true,
		["JunkShow"]=true,
		["BAGmeihangshu"]=8,
		["BAGmeihangshu_retail"]=10,
		["jiaoyiOpen"]=true,
		["AHOpen"]=true,
		["wupinRanse"]=true,
	},
	["AutoSellBuy"] = {
		["AutoRepair"] = "ON",
		["AutoRepair_GUILD"]="ON",
		["AutoSell"] = "ON",
		["Kaiqi"] = "ON",
		["AddBut"] = "ON",
		["zidongKaiqi"]="ON",
		["diuqitishi"]="OFF",
		["AutoSell_Open"]="ON",
		["AutoSell_List"]={},
		["SellPlus"]="ON",
		["Openlist"]={},
	},
	["CVars"]={
		["cameraDistanceMaxZoomFactor"]="OFF",
	},
	["PigUI"] = {
		["Hide_shijiu"] = "ON",
		["Hide_ActionBG"] = "OFF",
		["MenuBag"] = true,
		["MenuBag_bili_value"]=0.9;
		["ActionBar"] = "ON",
		["ActionBar_bili"]="ON",
		["ActionBar_bili_value"]=0.8;
		["ChatFrame_Width"] = "ON",
		["ChatFrame_Width_value"] = 350,
		["ChatFrame_Height"] = "ON",
		["ChatFrame_Height_value"] = 180,
		["ChatFrame_Point"] = "ON",
		["ChatFrame_Point_X"] = 35,
		["ChatFrame_Point_Y"] = 80,
		["ChatFrame_Loot"] = "OFF",
		["ChatFrame_Loot_Width"] = "ON",
		["ChatFrame_Loot_Width_value"] = 350,
		["ChatFrame_Loot_Height"] = "ON",
		["ChatFrame_Loot_Height_value"] = 180,
		["ChatFrame_Loot_Point"] = "ON",
		["ChatFrame_Loot_Point_X"] = 26,
		["ChatFrame_Loot_Point_Y"] = 8,
		["xianshiNeirong"] = "ON",
	},
	["ChatFrame"] = {
		["zhixiangShow"]="OFF",
		["Jianyin"] = "OFF",
		["Bianju"] = "ON",
		["AltEX"] = "OFF",
		["Guolv"] = "OFF",
		["QuickChat"] = "ON",
		["QuickChat_style"]=1,
		["QuickChat_maodian"] = 1,
		["MinMaxB"] = "ON",
		["RightPlus"] = "ON",
		["FontSize"] = "ON",
		["FontSize_value"] = 12,
		["JoinPindao"] = "ON",
		["JoinPindaoPIG"] = "ON",
		["JoinPindaoPIG_Color"]="ON",
		["jingjian"] = "ON",
		["TABqiehuanOpen"] = true,
		["TABqiehuanList"] = {},
		["chatZhanlian"] = {},
		["xiayijuli"]=0,
		["fanyejianR"] = "OFF",
		["gaoduH"] = 150,
		["toumingdu"] = 0.8,
		["guolvzishen"]="OFF",
		["xitongjihuoB"]="ON",
		["guolvchongfu"]="ON",
		["FFShow"]="OFF",
		["Keyword"]={},
		["Blacklist"]={},
	},
	["Chatjilu"] = {
		["tianshu"]=7,
		["miyutixing"]="OFF",
		["jiluinfo"]={
			["WHISPER"]={["kaiguan"]="ON",["tixing"]="ON",["neirong"]={}},
			["PARTY"]={["kaiguan"]="ON",["tixing"]="OFF",["neirong"]={}},
			["RAID"]={["kaiguan"]="ON",["tixing"]="OFF",["neirong"]={}},
		},
	},
	["CombatPlus"] = {
		["ActionBar_Ranse"] = "ON",
		["ActionBar_AutoFanye"] = "ON",
		["BGtongbao"] = "ON",
		["Zhuizong"] = "ON",
		["PetTishi"] = "ON",
		["CombatTime"]=true,
		["Miaobian"]="OUTLINE",
		["Beijing"]=3,
		["ziyuantiao"]=true,
		["zhandouHide"]=true,
		["suofangbili"]=1,
		["Xpianyi"]=0,
		["Ypianyi"]=0,
		["Showshuzhi"]=false,
		["Biaoji"] = {
			["Open"] = true,
			["Yidong"] = false,
			["AutoShow"] = false,
		},
	},
	["MinimapBpaichu"] = {
	},
	["FramePlus"] = {
		["ExtFrame_Talent"] = "ON",
		["ExtFrame_Zhuanye"] = "ON",
		["ExtFrame_ZhuanyeQKBUT"]=true,
		["ExtFrame_Renwu"] = "ON",
		["CharacterFrame_LV"]="ON",
		["CharacterFrame_shuxing"]="ON",
		["CharacterFrame_zhuangbeList"]="ON",
		["CharacterFrame_Juese"] = "ON",
		["CharacterFrame_naijiu"] = "ON",
		["CharacterFrame_ranse"] = "ON",
		["Cailiao"] = "ON",
		["BuffTime"] = "ON",
		["yidongUI"] = "ON",
	},
	["UnitFrame"] = {
		["PlayerFrame"] = {
			["Plus"] = true,
			["HPFF"] = true,
			["youyi"] = true,
		},
		["TargetFrame"] = {
			["Plus"] = true,
			["ToToToT"] = true,
			["Yisu"] = true,
		},
		["PartyMemberFrame"] = {
			["Plus"] = true,
		},
	},
	["Interaction"] = {
		["Autoloot"] = "ON",
		["AutoDown"] = "ON",
		["AutoDialogue"]="ON",
		["AutoJierenwu"]="OFF",
		["AutoJiaorenwu"]="OFF",
		["AutoJyaoqing"]="OFF",
		["AutoFuhuo"]="OFF",
		["SpellLinkPlus"]="ON",
		["QuestLinkPlus"]="ON",
		["jiaoyizengqiang"]=true,
	},
	["SkillFBCD"] = {
		["Open"] = "ON",
		["AddBut"] = "ON",
		["SkillCD"] = {
		},
		["FubenCD"] = {
		},
	},
	["Map"] = {
		["MinimapPos"] = -13.62698465698976,
		["MinimapBut"] = true,
		["MinimapShouNa"] = true,
		["MinimapShouNa_hang"] = 5,
		["MinimapShouNa_BS"] = false,
		["WorldMapPlus"] = true,
		["WorldMapWind"] = true,
		["WorldMapXY"] = true,
		["WorldMapLV"] = true,
		["WorldMapSkill"] = true,
		["WorldMapMiwu"] = true,
		["WorldMapFuben"] = true,
		["WorldMapNPC"] = true,
	},
	["Error"] = {
		["ErrorInfo"] = {},
		["ErrorTishi"] = true,
	},
	["FastDiuqi"] = {},
	["RaidRecord"] = {
		["Kaiqi"] = "OFF",
		["Invite"]={
			["YYhao"]=113213,
			["zairupeizhi"]=0,
			["kaituanName"]="[Pig]开团助手测试喊话....",
			["jinzuZhiling"]="888",
			["wutiaojianjINV"]="OFF",
			["hanhuapindao"]={},
			["shijianjiange"]=300,
			["PlayersInfo"] = {},
			["linshiInfo"] = {},
			["LMBL"]={
				["10人配置"]={
					[1]={1,1,0,0,0,0,0,0,0,0,0,0},
					[2]={1,1,1,0,0,0,0,0,0,0,0,0},
					[3]={0,1,1,2,1,0,0,0,0,0,0,0},
				},
				["15人配置"]={
					[1]={1,1,0,0,0,0,0,0,0,0,0,0},
					[2]={1,1,1,1,0,0,0,0,0,0,0,0},
					[3]={1,1,2,2,1,2,0,0,0,0,0,0},
				},
				["20人配置"]={
					[1]={1,1,0,0,0,0,0,0,0,0,0,0},
					[2]={1,1,1,1,0,0,0,0,0,0,0,0},
					[3]={4,2,3,3,2,0,0,0,0,0,0,0},
				},
				["25人配置"]={
					[1]={1,1,1,0,0,0,0,0,0,0,0,0},
					[2]={2,1,1,1,0,0,0,0,0,0,0,0},
					[3]={1,5,3,3,4,1,0,0,0,0,0,0},
				},
				["40人配置"]={
					[1]={2,1,1,0,0,0,0,0,0,0,0,0},
					[2]={2,2,2,2,0,0,0,0,0,0,0,0},
					[3]={6,6,6,4,4,2,0,0,0,0,0,0},
				},
			},
			["LM"]={
				["10人配置"]={
					[1]={2,0,0,0,0},
					[2]={1,0,1,0},
					[3]={0,1,1,2,2,0,0,0,0},
				},
				["15人配置"]={
					[1]={2,0,0,0,0},
					[2]={1,1,1,0},
					[3]={2,2,2,2,2,0,0,0,0},
				},
				["20人配置"]={
					[1]={2,0,0,0,0},
					[2]={2,1,1,0},
					[3]={4,2,3,3,2,0,0,0,0},
				},
				["25人配置"]={
					[1]={1,1,1,0,0},
					[2]={2,2,2,0},
					[3]={1,5,2,3,4,1,0,0,0},
				},
				["40人配置"]={
					[1]={4,0,0,0,0},
					[2]={4,2,3,0},
					[3]={8,4,6,6,3,0,0,0,0},
				},
			},
			["BL"]={
				["10人配置"]={
					[1]={1,1,0,0,0},
					[2]={1,0,1,0},
					[3]={0,2,1,2,1,0,0,0,0},
				},
				["15人配置"]={
					[1]={2,0,0,0,0},
					[2]={1,1,1,0},
					[3]={2,2,2,2,2,0,0,0,0},
				},
				["20人配置"]={
					[1]={2,0,0,0,0},
					[2]={2,1,1,0},
					[3]={4,2,3,3,2,0,0,0,0},
				},
				["25人配置"]={
					[1]={2,1,0,0,0},
					[2]={2,2,2,0},
					[3]={1,5,2,3,4,1,0,0,0},
				},
				["40人配置"]={
					[1]={4,0,0,0,0},
					[2]={4,2,3,0},
					[3]={8,4,6,6,3,0,0,0,0},
				},
			},
			["dangqianrenshu"]={
				[1]={0,0,0,0,0,0,0,0,0,0,0,0},
				[2]={0,0,0,0,0,0,0,0,0,0,0,0},
				[3]={0,0,0,0,0,0,0,0,0,0,0,0},
			},
		},
		["Rsetting"] ={
			["bobaomingxi"] = "ON",
			["liupaibobao"] = "ON",
			["caizhixiufu"] = "OFF",
			["jiaoyidaojishi"] = "ON",
			["shoudongloot"] = "ON",
			["fubenwai"] = "OFF",
			["wurenben"] = "OFF",
			["jiaoyijilu"] = "ON",
			["jiaoyitonggao"] = "ON",
			["zidonghuifuYY"]="OFF",
			["YYguanjianzi"]={"YY","yy","歪歪"},
			["YYneirong"]="YY频道:113213,组人不易,请耐心等待",
		},
		["AddBut"] = "ON",
		["Dongjie"] = "OFF",
		["Raidinfo"] = {{},{},{},{},{},{},{},{}},
		["History"]={},
		["instanceName"]={},
		["pinzhimoren"]=3,
		["ItemList_Paichu"]={
		},
		["ItemList"]={},
		["buzhuG"]={100,100},
		["buzhu"]={
			["tanke"]={},
			["zhiliao"]={},
		},
		["jiangli"]={
			{
				"治疗第一", -- [1]
				150, -- [2]
				"无", -- [3]
			}, -- [1]
			{
				"治疗第二", -- [1]
				100, -- [2]
				"无", -- [3]
			}, -- [2]
			{
				"治疗第三", -- [1]
				80, -- [2]
				"无", -- [3]
			}, -- [3]
			{
				"DPS第一", -- [1]
				150, -- [2]
				"无", -- [3]
			}, -- [4]
			{
				"DPS第二", -- [1]
				100, -- [2]
				"无", -- [3]
			}, -- [5]
			{
				"DPS第三", -- [1]
				80, -- [2]
				"无", -- [3]
			}, -- [6]
		},
		["fakuan"]={
			{
				"包地板", -- [1]
				0, -- [2]
				0, -- [3]
				"无", -- [4]
			}, -- [1]
			{
				"指挥失误", -- [1]
				0, -- [2]
				0, -- [3]
				"无", -- [4]
			}, -- [2]
			{
				"ADD罚款1", -- [1]
				0, -- [2]
				0, -- [3]
				"无", -- [4]
			}, -- [3]
			{
				"ADD罚款2", -- [1]
				0, -- [2]
					0, -- [3]
				"无", -- [4]
			}, -- [4]
			{
				"ADD罚款3", -- [1]
				0, -- [2]
				0, -- [3]
				"无", -- [4]
			}, -- [5]
			{
				"跑位失误罚款1", -- [1]
				0, -- [2]
				0, -- [3]
				"无", -- [4]
			}, -- [6]
			{
				"跑位失误罚款2", -- [1]
				0, -- [2]
				0, -- [3]
				"无", -- [4]
			}, -- [7]
			{
				"跑位失误罚款3", -- [1]
				0, -- [2]
				0, -- [3]
				"无", -- [4]
			}, -- [8]
		},
	},
};

addonTable.PIG_Per = {
	["QuickFollow"]={
		["beidongOpen"]=false,
	},
	["ChatFrame"]={
		["Keyword"]={},
		["Blacklist"]={},
		["RollList"]={},
	},
	["AutoSellBuy"] = {
		["BuyList"]={},
		["BuyOpen"]="ON",
	},
	["SpellJK"] = {
		["Kaiqi"] = "ON",
		["AddBut"]="ON",
		["WHF_list"] = {
			{
				["H"] = 35,
				["W"] = 35,
				["font"] = 12,
			}, -- [1]
			{
				["H"] = 20,
				["W"] = 150,
				["font"] = 12,
			}, -- [2]
			{
				["H"] = 20,
				["W"] = 150,
				["font"] = 12,
			}, -- [3]
			{
				["H"] = 35,
				["W"] = 35,
				["font"] = 14,
			}, -- [4]
			{
				["H"] = 20,
				["W"] = 150,
				["font"] = 12,
			}, -- [5]
		},
		["Open"] = {
			"ON", -- [1]
			"ON", -- [2]
			"OFF", -- [3]
			"OFF", -- [4]
			"OFF", -- [5]
		},
		["ShowSpellOpen"] = "ON",
		["Spell_list"] = {
			{
			}, -- [1]
			{
			}, -- [2]
			{
			}, -- [3]
			{
			}, -- [4]
			{
			}, -- [5]
		},
	},
	["PigAction"] = {
		["Open"] = {"OFF","OFF","OFF","OFF"},
		["Look"] = {"OFF","OFF","OFF","OFF"},
		["Pailie"] = {1,1,1,1},
		["ShowTJ"] = {1,1,1,1},
		["ActionInfo"] = {},
	},
	["QuickButton"]={
		["ActionInfo"] = {},
		["AutoEquipInfo"] = {},
	},
	["daiben"] = {
		["Open"] = false,
		["AddBut"]=true,
		["Show"] = true,
		["Time_Show"]=true,
		["Jizhang_Show"]=true,
		["autohuifu"]=false,
		["autohuifu_NR"]="永不翻车，自由拾取",
		["autohuifu_danjia"] = true,
		["autohuifu_lv"]=true,
		["autohuifu_inv"]=true,
		["autohuifu_invCMD"] = "666",
		["autohuifu_key"]= {"有位","消费","有坑","多少","价格"},
		["fubenName"]="无",
		["hanhua_lv"]=true,
		["hanhua_danjia"]=false,
		["hanhuaMSG"] = "[Pig]带本助手喊话测试....",
		["LV_danjia"] = {},
		["CZ_timejisha"]=true,
		["CZ_expSw"]=true,
		["CZ_yueyuci"]=true,
		["CZ_jiuwei"]=true,
		["SDdanjia"]=false,
		["CBbukouG"]=false,
		["HideYue"]=false,
		["bangdingUI"]=true,
		["shoudongMOD"] = false,
		["Namelist"] = {},
		["Timelist"] = {},
		["Over_Time"] = 0,
		["Shouru"] = 0,
		["shuabenshu"] = 0,
		["YijingCZ"] = false,
		["FBneiYN"] = false,
		["DuiwuNei"] = {false,false},
	},
};