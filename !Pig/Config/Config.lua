local _, addonTable = ...;

addonTable.Default = {
	["AKF"]={
		["Open"] = false,
		["QuickButton"]=true,
	},
	["AHPlus"]={
		["Open"] = false,
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
		["Jiuwei"] = false,
		["Yijiao"]=false,
	},
	["RaidFrame"]={
		["xiufu"] = "OFF",
	},
	["PlaneInvite"]={
		["Kaiqi"] = "ON",
		["AddBut"] = "ON",
		["zidongjieshou"]="OFF",
		["WeimianList"]={},
	},
	["ShowPlus"] = {
		["ItemSell"] = "OFF",
		["ItemLevel"] = "OFF",
		["SpellID"] = "OFF",
	},
	["zhegnheBAG"]={
		["BAGkongyu"]="OFF",
		["Open"] = "OFF",
		["SortBagsRightToLeft"] = false,
		["JianjieMOD"] = false,
		["hulueBAG"] = {false,false,false,false,false},
		["hulueBANK"] = {false,false,false,false,false,false,false,false},
		["lixian"] = {},
		["SortBag_Config"]=true,
		["qitashulaing"]=false,
		["qitajinbi"]=true,
		["wupinLV"]=false,
		["JunkShow"]=true,
		["BAGmeihangshu"]=8,
		["BAGmeihangshu_retail"]=10,
		["jiaoyiOpen"]=true,
		["AHOpen"]=true,
		["wupinRanse"]=true,
	},
	["AutoSellBuy"] = {
		["AutoRepair"] = "OFF",
		["AutoRepair_GUILD"]="OFF",
		["AutoSell"] = "OFF",
		["Kaiqi"] = "ON",
		["AddBut"] = "ON",
		["zidongKaiqi"]="OFF",
		["diuqitishi"]="OFF",
		["AutoSell_Open"]="OFF",
		["AutoSell_List"]={},
		["SellPlus"]="OFF",
		["Openlist"]={},
	},
	["CVars"]={
		["cameraDistanceMaxZoomFactor"]="OFF",
	},
	["PigUI"] = {
		["Hide_shijiu"] = "OFF",
		["Hide_ActionBG"] = "OFF",
		["MenuBag"] = false,
		["MenuBag_bili_value"]=0.9;
		["ActionBar"] = "OFF",
		["ActionBar_bili"]="OFF",
		["ActionBar_bili_value"]=0.8;
		["ChatFrame_Width"] = "OFF",
		["ChatFrame_Width_value"] = 350,
		["ChatFrame_Height"] = "OFF",
		["ChatFrame_Height_value"] = 180,
		["ChatFrame_Point"] = "OFF",
		["ChatFrame_Point_X"] = 35,
		["ChatFrame_Point_Y"] = 80,
		["ChatFrame_Loot"] = "OFF",
		["ChatFrame_Loot_Width"] = "OFF",
		["ChatFrame_Loot_Width_value"] = 350,
		["ChatFrame_Loot_Height"] = "OFF",
		["ChatFrame_Loot_Height_value"] = 180,
		["ChatFrame_Loot_Point"] = "OFF",
		["ChatFrame_Loot_Point_X"] = 26,
		["ChatFrame_Loot_Point_Y"] = 8,
		["xianshiNeirong"] = "OFF",
	},
	["ChatFrame"] = {
		["zhixiangShow"]="OFF",
		["Jianyin"] = "OFF",
		["Bianju"] = "OFF",
		["AltEX"] = "OFF",
		["Guolv"] = "OFF",
		["QuickChat"] = "OFF",
		["QuickChat_style"]=1,
		["QuickChat_maodian"] = 2,
		["MinMaxB"] = "OFF",
		["RightPlus"] = "OFF",
		["FontSize"] = "OFF",
		["FontSize_value"] = 12,
		["JoinPindao"] = "OFF",
		["JoinPindaoPIG"] = "ON",
		["JoinPindaoPIG_Color"]="ON",
		["jingjian"] = "OFF",
		["TABqiehuanOpen"] = false,
		["TABqiehuanList"] = {},
		["chatZhanlian"] = {},
		["xiayijuli"]=0,
		["fanyejianR"] = "OFF",
		["gaoduH"] = 150,
		["toumingdu"] = 0.8,
		["guolvzishen"]="OFF",
		["xitongjihuoB"]="OFF",
		["guolvchongfu"]="OFF",
		["FFShow"]="OFF",
		["Keyword"]={},
		["Blacklist"]={},
	},
	["Chatjilu"] = {
		["tianshu"]=7,
		["jiluinfo"]={
			["WHISPER"]={["kaiguan"]="ON",["tixing"]="ON",["neirong"]={}},
			["PARTY"]={["kaiguan"]="ON",["tixing"]="OFF",["neirong"]={}},
			["RAID"]={["kaiguan"]="ON",["tixing"]="OFF",["neirong"]={}},
		},
	},
	["CombatPlus"] = {
		["ActionBar_Ranse"] = "OFF",
		["ActionBar_AutoFanye"] = "OFF",
		["BGtongbao"] = "OFF",
		["Zhuizong"] = "OFF",
		["PetTishi"] = "OFF",
		["CombatTime"]=false,
		["Miaobian"]="OUTLINE",
		["Beijing"]=3,
		["ziyuantiao"]=false,
		["zhandouHide"]=true,
		["suofangbili"]=1,
		["Xpianyi"]=0,
		["Ypianyi"]=0,
		["Showshuzhi"]=true,
		["Biaoji"] = {
			["Open"] = false,
			["Yidong"] = false,
			["AutoShow"] = false,
		},
	},
	["MinimapBpaichu"] = {
	},
	["FramePlus"] = {
		["ExtFrame_Talent"] = "OFF",
		["ExtFrame_Zhuanye"] = "OFF",
		["ExtFrame_ZhuanyeQKBUT"]=false,
		["ExtFrame_Renwu"] = "OFF",
		["CharacterFrame_LV"]="OFF",
		["CharacterFrame_shuxing"]="OFF",
		["CharacterFrame_zhuangbeList"]="OFF",
		["CharacterFrame_Juese"] = "OFF",
		["CharacterFrame_naijiu"] = "OFF",
		["CharacterFrame_ranse"] = "OFF",
		["Cailiao"] = "OFF",
		["BuffTime"] = "OFF",
		["yidongUI"] = "OFF",
	},
	["UnitFrame"] = {
		["PlayerFrame"] = {
			["Plus"] = false,
			["HPFF"] = false,
			["youyi"] = false,
		},
		["TargetFrame"] = {
			["Plus"] = false,
			["ToToToT"] = false,
			["Yisu"] = false,
		},
		["PartyMemberFrame"] = {
			["Plus"] = false,
		},
	},
	["Interaction"] = {
		["Autoloot"] = "OFF",
		["AutoDown"] = "OFF",
		["AutoDialogue"]="OFF",
		["AutoJierenwu"]="OFF",
		["AutoJiaorenwu"]="OFF",
		["AutoJyaoqing"]="OFF",
		["AutoFuhuo"]="OFF",
		["SpellLinkPlus"]="OFF",
		["QuestLinkPlus"]="OFF",
		["jiaoyizengqiang"]=false,
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
		["MinimapShouNa"] = false,
		["MinimapShouNa_hang"] = 5,
		["MinimapShouNa_BS"] = false,
		["WorldMapBili"] = 0.8,
		["WorldMapPlus"] = false,
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
		["ErrorTishi"] = false,
	},
	["FastDiuqi"] = {},
	["RaidRecord"] = {
		["Kaiqi"] = "OFF",
		["Invite"]={
			["YYhao"]=113213,
			["dangqianpeizhi"]=0,
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

addonTable.Default_Per = {
	["QuickFollow"]={
		["beidongOpen"]=false,
	},
	["CombatCycle"]={
		["Open"]=false,
		["Size"]=35,
		["jiange"]=4,
		["suoding"]=false,
		["SpellList"]={},
	},
	["ChatFrame"]={
		["Keyword"]={},
		["Blacklist"]={},
		["RollList"]={},
	},
	["AutoSellBuy"] = {
		["BuyList"]={},
		["BuyOpen"]="OFF",
	},
	["SpellJK"] = {
		["Kaiqi"] = "OFF",
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
			"OFF", -- [1]
			"OFF", -- [2]
			"OFF", -- [3]
			"OFF", -- [4]
			"OFF", -- [5]
		},
		["ShowSpellOpen"] = "OFF",
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