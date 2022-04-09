local _, addonTable = ...;

addonTable.AllNO = {
	['RaidFrame']={
		["xiufu"] = "OFF",
	},
	['PlaneInvite']={
		["Kaiqi"] = "ON",
		["AddBut"] = "ON",
		['zidongjieshou']="ON",
		['WeimianList']={},
	},
	["ShowPlus"] = {
		["ItemSell"] = "ON",
		["ItemLevel"] = "ON",
		["SpellID"] = "ON",
		['zhuangbeiLV']="ON",
	},
	['zhegnheBAG']={
		['BAGkongyu']="ON",
		["Open"] = "ON",
		["SortBagsRightToLeft"] = false,
		["JianjieMOD"] = false,
		["hulueBAG"] = {false,false,false,false,false},
		["hulueBANK"] = {false,false,false,false,false,false,false,false},
		["lixian"] = {},
		["SortBag_Config"]=true,
		["qitashulaing"]=true,
		["wupinLV"]=true,
	},
	["AutoSellBuy"] = {
		["AutoRepair"] = "ON",
		['AutoRepair_GUILD']="ON",
		['AutoSell'] = "ON",
		["Kaiqi"] = "ON",
		["AddBut"] = "ON",
		['zidongKaiqi']="ON",
		['diuqitishi']="OFF",
		['AutoSell_Open']="ON",
		["AutoSell_List"]={},
		['SellPlus']="ON",
		["Openlist"]={},
	},
	['CVars']={
		["cameraDistanceMaxZoomFactor"]="OFF",
	},
	["Classes"] = {
		['bili']=1,
		["Assistant"] = "ON",
		["suoding"] = "OFF",
		["Lushi"] = "ON",
		["Spell"] = "ON",
		["Gensui"] = "ON",
		["GensuiName"] = "猪猪加油",
		["Duizhang"] = "OFF",
		["gensuitishi"] = "OFF",
		["GensuiKaishi"] = "1",
		["GensuiJieshu"] = "2",
		['gensuijiuwei'] = "ON",
		['yijiaoduizhang']="ON",
		['qianglimoshi']="OFF",
	},
	["PigUI"] = {
		["ShhijiuIcon"] = "ON",
		["ActionBar"] = "ON",
		['ActionBar_bili']="ON",
		['ActionBar_bili_value']=0.8;
		["ChatFrame_Width"] = "OFF",
		["ChatFrame_Height"] = "OFF",
		["ChatFrame_Height_value"] = 180,
		["ChatFrame_Point"] = "ON",
		["ChatFrame_Point_value"] = 50,
		["ChatFrame_Loot"] = "OFF",
		["ChatFrame_Loot_Width"] = "ON",
		["ChatFrame_Loot_Height"] = "ON",
		["ChatFrame_Loot_Height_value"] = 120,
		["ChatFrame_Loot_Point"] = "ON",
		["ChatFrame_Loot_Point_value"] = 50,
		["xianshiNeirong"] = "ON",
	},
	["ChatFrame"] = {
		["Jianyin"] = "ON",
		["Bianju"] = "ON",
		["AltEX"] = "ON",
		["Guolv"] = "ON",
		["QuickChat"] = "ON",
		['wubiankuang']= "OFF",
		["QuickChat_maodian"] = 2,
		["MinMaxB"] = "ON",
		["RightPlus"] = "ON",
		["FontSize"] = "ON",
		["FontSize_value"] = 12,
		["JoinPindao"] = "ON",
		['JoinPindaoPIG'] = "ON",
		['JoinPindaoPIG_Color']="ON",
		["jingjian"] = "ON",
		["chatZhanlian"] = {["SAY"]=1,["PARTY"]=1,["RAID"]=1,["GUILD"]=1,["OFFICER"]=1,["WHISPER"]=1,["BN_WHISPER"]=1},
		['xiayijuli']=0,
		['fanyejianR'] = "OFF",
		['gaoduH'] = 150,
		['toumingdu'] = 0.8,
		['guolvzishen']="OFF",
		['xitongjihuoB']="ON",
		['guolvchongfu']="ON",
		['FFShow']="OFF",
		['Keyword']={},
		['Blacklist']={},
	},
	["Chatjilu"] = {
		["tianshu"]=7,
		["miyutixing"]="OFF",
		["jiluinfo"]={
			["WHISPER"]={["kaiguan"]="ON",["tixing"]="ON",["neirong"]={}},
			["PARTY"]={["kaiguan"]="OFF",["tixing"]="OFF",["neirong"]={}},
			["RAID"]={["kaiguan"]="OFF",["tixing"]="OFF",["neirong"]={}},
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
		["Showshuzhi"]=true,
	},
	["MinimapBpaichu"] = {
		"MiniMapTrackingFrame", -- [1]
		"MiniMapMeetingStoneFrame", -- [2]
		"MiniMapMailFrame", -- [3]
		"MiniMapBattlefieldFrame", -- [4]
		"MiniMapWorldMapButton", -- [5]
		"MiniMapPing", -- [6]
		"MinimapBackdrop", -- [7]
		"MinimapZoomIn", -- [8]
		"MinimapZoomOut", -- [9]
		"BookOfTracksFrame", -- [10]
		"GatherNote", -- [11]
		"FishingExtravaganzaMini", -- [12]
		"MiniNotePOI", -- [13]
		"RecipeRadarMinimapIcon", -- [14]
		"FWGMinimapPOI", -- [15]
		"CartographerNotesPOI", -- [16]
		"MBB_MinimapButtonFrame", -- [17]
		"EnhancedFrameMinimapButton", -- [18]
		"GFW_TrackMenuFrame", -- [19]
		"GFW_TrackMenuButton", -- [20]
		"TDial_TrackingIcon", -- [21]
		"TDial_TrackButton", -- [22]
		"MiniMapTracking", -- [23]
		"GatherMatePin", -- [24]
		"HandyNotesPin", -- [25]
		"TimeManagerClockButton", -- [26]
		"GameTimeFrame", -- [27]
		"DA_Minimap", -- [28]
		"ElvConfigToggle", -- [29]
		"MiniMapInstanceDifficulty", -- [30]
		"MinimapZoneTextButton", -- [31]
		"GuildInstanceDifficulty", -- [32]
		"MiniMapVoiceChatFrame", -- [33]
		"MiniMapRecordingButton", -- [34]
		"QueueStatusMinimapButton", -- [35]
		"GatherArchNote", -- [36]
		"ZGVMarker", -- [37]
		"QuestPointerPOI", -- [38]
		"poiMinimap", -- [39]
		"MiniMapLFGFrame", -- [40]
		"PremadeFilter_MinimapButton", -- [41]
		"QuestieFrame", -- [42]
		"Guidelime", -- [43]
		"MiniMapBattlefieldFrame", -- [44]
		"LibDBIcon10_BugSack", -- [45]
		"MinimapButton_PigUI", -- [46]
		"MinimapLayerFrame", -- [46]
		"NWBNaxxMarkerMini", -- [46]
		"NWBMini", -- [46]
	},
	["FramePlus"] = {
		["ExtFrame_Zhuanye"] = "ON",
		["ExtFrame_Renwu"] = "ON",
		["CharacterFrame_Juese"] = "ON",
		["CharacterFrame_naijiu"] = "ON",
		["CharacterFrame_ranse"] = "ON",
		["Cailiao"] = "ON",
		["TouxiangFrame_Duiyou"] = "ON",
		["BuffTime"] = "ON",
		["TouxiangFrame_Zishen"] = "ON",
		['TouxiangFrame_HPFF']="ON",
		["TouxiangFrame_Mubiao_Biaoji"] = "ON",
		['TouxiangFrame_Mubiao_Biaoji_YD']="OFF",
		['TouxiangFrame_Mubiao_Biaoji_AUSW']="ON",
		["TouxiangFrame_Mubiao"] = "ON",
		['TouxiangFrame_Mubiao_youyi']="ON",
		['ToToToT']="ON",
		['yisu']="ON",
		["yidongUI"] = "ON",
		['jiaoyizengqiang']="ON",
	},
	["Interaction"] = {
		["Autoloot"] = "ON",
		["AutoDown"] = "ON",
		['AutoDialogue']="ON",
		['AutoJierenwu']="OFF",
		['AutoJiaorenwu']="OFF",
		['AutoJyaoqing']="OFF",
		['AutoFuhuo']="OFF",
		['SpellLinkPlus']="ON",
		['QuestLinkPlus']="ON",
		['AutoLOOTqwueren']="OFF",
	},
	["SkillFBCD"] = {
		["Open"] = "ON",
		["AddBut"] = "ON",
		["SkillCD"] = {
		},
		["FubenCD"] = {
		},
	},
	["Other"] = {
		["MinimapPos"] = -24,
		["MinimapB"] = "ON",
		["ShounaB"] = "ON",
		["ShounaB_Shu_value"] = 5,
		["ErrorTishi"] = false,
	},
	["AutoGensui"]={
		["Kaiguan"]="ON",
		["Duizhang"]="ON",
		["Bgensui_Kaishi"]="1",
		["Bgensui_Jieshu"]="2",
	},
	["FastDiuqi"] = {},
	["RaidRecord"] = {
		["Kaiqi"] = "ON",
		["Invite"]={
			["YYhao"]=113213,
			["zairupeizhi"]=0,
			["kaituanName"]="[Pig]开团助手测试喊话....",
			["jinzuZhiling"]="888",
			["wutiaojianjINV"]="OFF",
			["hanhuapindao"]={{false,false,false,false,false},{false,true,true,false,false,false,false}},
			["shijianjiange"]=300,
			["PlayersInfo"] = {},
			["linshiInfo"] = {},
			["LMBL"]={
				["10人配置"]={
					[1]={1,1,0,0,0,0,0,0,0,0,0,0},
					[2]={1,1,1,0,0,0,0,0,0,0,0,0},
					[3]={0,1,1,2,1,0,0,0,0,0,0,0},
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

addonTable.AllNO_Per = {
	['ChatFrame']={
		['Keyword']={},
		['Blacklist']={},
		['RollList']={},
	},
	["AutoSellBuy"] = {
		["BuyList"]={},
		['BuyOpen']="ON",
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
		["Spell_list"] = {{},{},{},{}}
	},
	["Classes"] = {
		["beidongkaiqi"] = false,
		["Spell_list"] = {}
	},
	["FarmRecord"] = {
		["bangdingUI"]="OFF",
		["yuedanjiasuoding"]=false,
		['chunjizhang']="OFF",
		['dongtaizhankai'] = "OFF",
		['jiuweiqueren']="ON",
		["Kaiqi"] = "ON",
		["CDjiange"]=true,
		["Show"] = "OFF",
		["MaxMin"] = "OFF",
		["Time_Show"] = "OFF",
		["AddBut"] = "ON",
		["hanhuapindao_lv"]="ON",
		['hanhuapindao_lvdanjia']="ON",
		["hanhuapindao"]={{true,false,false,false,false},{false,false,false,false,false,false,false}},
		["hanhuaMSG"] = "[Pig]带本助手喊话测试....",
		["autohuifu"] = "OFF",
		["autohuifu_inv"] = "666",
		["autohuifu_Qianzhui"]="永不翻车，自由拾取",
		["autohuifu_inv_lv"] = {1,80},
		["autohuifu_TXT"] = {"有位","消费","有坑","多少","价格"},
		["autoyaoqing"] = "ON",
		['huifudengji'] = "ON",
		["autohuifu_danjia"] = "ON",
		["autobobao"] = "ON",
		["autobobao_yuci"] = "OFF",
		["autobobao_TXT"] = {"上次副本耗时","，总击杀数"},
		["Time"] = {{},{},{},{},{}},
		["shuabenshu"] = 0,
		['Time_jisha_Open'] = "OFF",
		["Time_jisha"] = {{},{},{},{},{}},
		["Time_Over"] = 1615444084,
		["FBneiYN"] = "ON",
		["YijingCZ"] = "OFF",
		["DuiwuNei"] = {false,false},
		["kaichemudidi"]="无",
		["LV-danjia"] = {},
		["namelist"] = {},
		["shouruG"] = {0,0},
	},
};