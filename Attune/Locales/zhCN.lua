--localization file for english/United States
local Lang = LibStub("AceLocale-3.0"):NewLocale("Attune", "zhCN")
if (not Lang) then
	return;
end


-- INTERFACE
Lang["Credits"] = "非常感谢我的行会|cffffd100<Divine Heresy>|r在我测试插件时给予的支持和理解，并感谢|cffffd100Bushido @ Pyrewood Village|r在TBC上的帮助！\n\n 另外，非常感谢翻译人员：\n  - 德语翻译: |cffffd100Sumaya @ Razorfen DE|r\n  - 俄语翻译: |cffffd100Greymarch Guild @ Flamegor RU|r\n  - 西班牙语翻译: |cffffd100Coyu @ Pyrewood Village EU|r\n  - 简体中文翻译: |cffffd100ly395842562|r 和 |cffffd100Icyblade|r\n  - 繁体中文翻译: |cffffd100DayZ 三指打天下|r 和 |cffffd100薇兒 @ Ivus TW|r\n  - 韩语翻译: |cffffd100Drix @ Azshara KR|r\n\n/Hug 来自 Cixi/Gaya @ Remulos Horde"
Lang["Mini"] = "缩小"
Lang["Maxi"] = "放大"
Lang["Version"] = "Attune v##VERSION## by Cixi@Remulos"
Lang["Splash"] = "v##VERSION## by Cixi@Remulos. 键入/ attune开始。"
Lang["Survey"] = "扫描"
Lang["Guild"] = "公会"
Lang["Party"] = "小队"
Lang["Raid"] = "团队"
Lang["Run an attunement survey (for people with the addon)"] = "运行访问扫描（安装此插件的玩家）"
Lang["Toggle between attunements and survey results"] = "切换扫描结果" 
Lang["Close"] = "关闭" 
Lang["Export"] = "导出"
Lang["My Data"] = "我的资料"
Lang["Last Survey"] = "上次扫描"
Lang["Guild Data"] = "公会数据"
Lang["All Data"] = "所有数据"
Lang["Export your Attune data to the website"] = "将您的Attune数据导出到网站"
Lang["Copy the text below, then upload it to"] = "复制下面的文本，然后将其上传到"
Lang["Results"] = "扫描结果"
Lang["Not in a guild"] = "没有加入公会"
Lang["Click on a header to sort the results"] = "单击标题以对结果进行排序" 
Lang["Character"] = "特点" 
Lang["Characters"] = "人物"
Lang["Last survey results"] = "上次扫描结果"	
Lang["All FACTION results"] = "所有 ##FACTION## 结果"
Lang["Guild members"] = "公会成员" 
Lang["All results"] = "所有结果" 
Lang["Minimum level"] = "最低等级" 
Lang["Click to navigate to that attunement"] = "单击以导航到该访问权限"
Lang["Attunes"] = "使用权"
Lang["Guild members on this step"] = "同任务进度的公会成员"
Lang["Attuned guild members"] = "Attuned 公会成员"
Lang["Attuned alts"] = "Attuned 超越"
Lang["Alts on this step"] = "超越该任务进度"
Lang["Settings"] = "设置"
Lang["Survey Log"] = "扫描记录"
Lang["LeftClick"] = "左键单击"
Lang["OpenAttune"] = "    打开 Attune"
Lang["RightClick"] = "右键单击"
Lang["OpenSettings"] = "  打开设置"
Lang["Addon disabled"] = "插件已禁用"
Lang["StartAutoGuildSurvey"] = "开始公会自动扫描"
Lang["SendingDataTo"] = "发送Attune数据给 |cffffd100NA##NAME##|r"
Lang["NewVersionAvailable"] = "一个Attune的 |cffffd100新版本|r 可用, 请更新它！"
Lang["CompletedStep"] = "已完成该 ##TYPE## |cffe4e400##STEP##|r  |cffe4e400##NAME##|r."
Lang["AttuneComplete"] = " |cffe4e400##NAME##|r 声望已达到!"
Lang["AttuneCompleteGuild"] = "##NAME## 声望已达到!"
Lang["SendingSurveyWhat"] = "发送检测"
Lang["SendingGuildSilentSurvey"] = "发送公会静默调查"
Lang["SendingYellSilentSurvey"] = "发送 /大喊 静默调查"
Lang["ReceivedDataFromName"] = "从 |cffffd100##NAME##接收的数据|r"
Lang["ExportingData"] = "统计Attune人物数据 ##COUNT##"
Lang["ReceivedRequestFrom"] = "收到 |cffffd100##FROM##的请求|r"
Lang["Help1"] = "该插件可让您检查并导出声望进度"
Lang["Help2"] = "运行 |cfffff700/attune|r 开始。"
Lang["Help3"] = "要调查公会的进度，请单击 |cfffff700扫描|r 收集信息。"
Lang["Help4"] = "您将从带有插件的任何公会成员那里收到任务进度数据。"
Lang["Help5"] = "获得足够的信息后，请单击 |cfffff700导出|r 以导出公会进度"
Lang["Help6"] = "数据可以上传到 |cfffff700https://warcraftratings.com/attune/upload|r"
Lang["Survey_DESC"] = "运行声望检测 (安装本插件的玩家)"
Lang["Export_DESC"] = "将您的Attune数据导出到网站"
Lang["Toggle_DESC"] = "显示扫描结果"
--Lang["PreferredLocale_TEXT"] = "首选语言"
--Lang["PreferredLocale_DESC"] = "选择您想要使用的Attune语言。对此进行更改将需要重新加载才能生效。"
--v220
Lang["My Toons"] = "我的角色"
Lang["No Target"] = "你没有目标"
Lang["No Response From"] = " ##PLAYER##没有响应"
Lang["Sync Request From"] = "来自:\n\n##PLAYER##的扫描请求"
Lang["Could be slow"] = "根据您拥有的数据量，这可能是一个非常缓慢的过程"
Lang["Accept"] = "接受"
Lang["Reject"] = "拒绝"
Lang["Busy right now"] = "##PLAYER## 正忙，稍后再试"
Lang["Sending Sync Request"] = "发送同步请求到 ##PLAYER##"
Lang["Request accepted, sending data to "] = "请求已接受，将数据发送到 ##PLAYER##"
Lang["Received request from"] = "收到来自 ##PLAYER##的请求"
Lang["Request rejected"] = "请求被拒绝"
Lang["Sync over"] = "同步结束，用时##DURATION##"
Lang["Syncing Attune data with"] = "与##PLAYER##数据同步"
Lang["Cannot sync while another sync is in progress"] = "正在进行另一个同步时无法同步"
Lang["Sync with target"] = "正在与目标同步"
Lang["Show Profiles"] = "显示个人资料"
Lang["Show Progress"] = "显示进度"
Lang["Status"] = "状态"
Lang["Role"] = "角色"
Lang["Last Surveyed"] = "上次扫描"
Lang['Seconds ago'] = "##DURATION## 秒"
Lang["Main"] = "主菜单"
Lang["Alt"] = "备用"
Lang["Tank"] = "坦克"
Lang["Healer"] = "治疗"
Lang["Melee DPS"] = "近战输出"
Lang["Ranged DPS"] = "远程输出"
Lang["Bank"] = "银行"
Lang["DelAlts_TEXT"] = "删除所有Alts"
Lang["DelAlts_DESC"] = "删除所有标记为Alt的玩家信息"
Lang["DelAlts_CONF"] = "确定删除所有Alts?"
Lang["DelAlts_DONE"] = "所有Alts已删除"
Lang["DelUnspecified_TEXT"] = "删除未指定"
Lang["DelUnspecified_DESC"] = "删除有关未指定主/备用状态的玩家的所有信息"
Lang["DelUnspecified_CONF"] = "确定删除所有未指定主/备用状态的玩家的所有信息么？"
Lang["DelUnspecified_DONE"] = "所有未指定的主/备用状态的玩家的所有信息都已删除"
--v221
Lang["Open Raid Planner"] = "公开突袭计划师"
Lang["Unspecified"] = "未指定"
Lang["Empty"] = "空的"
Lang["Guildies only"] = "仅显示公会成员"
Lang["Show Mains"] = "显示主要角色"
Lang["Show Unspecified"] = "显示未指定"
Lang["Show Alts"] = "显示替代项"
Lang["Show Unattuned"] = "显示不协调"
Lang["Raid spots"] = "##SIZE## 突袭阵地"
Lang["Group Number"] = "团体 ##NUMBER##"
Lang["Move to next group"] = "    移至下一组"
Lang["Remove from raid"] = "  从团队中移除"
Lang["Select a raid and click on players to add them in"] = "选择一个团队并单击玩家以添加他们"
--v224
Lang["Enter a new name for this raid group"] = "输入此团队的新名称"
Lang["Save"] = "保存"
--v226
Lang["Invite"] = "邀请"
Lang["Send raid invites to all listed players?"] = "向所有列出的玩家发送突袭邀请？"
Lang["External link"] = "链接到在线数据库"
--v243
Lang["Ogrila"] = "奥格瑞拉"
Lang["Ogri'la Quest Hub"] = "奥格瑞拉宣教中心"
Lang["Ogrila_Desc"] = "聪明而开化的奥格瑞拉食人魔居住在刀锋山的西部区域。"
Lang["DelInactive_TEXT"] = "删除不活动"
Lang["DelInactive_DESC"] = "删除有关标记为非活动的玩家的所有信息"
Lang["DelInactive_CONF"] = "真的删除所有非活动吗？"
Lang["DelInactive_DONE"] = "已删除所有非活动"
Lang["RAIDS"] = "团队"
Lang["KEYS"] = "钥匙"
Lang["MISC"] = "杂项"
Lang["HEROICS"] = "英雄"
--v244
Lang["Ally of the Netherwing"] = "灵翼之盟"
Lang["Netherwing_Desc"] = "虚空之翼是位于外域的一个龙派系。"
--v247
Lang["Tirisfal Glades"] = "提瑞斯法林地"
Lang["Scholomance"] = "通灵学院"
--v248
Lang["Target"] = "目标"
Lang["SendingSurveyTo"] = "向 ##TO## 发送调查"
--WOTLK
Lang["QUEST HUBS"] = "任务线"
Lang["PHASES"] = "事件"
Lang["Angrathar the Wrathgate"] = "安加萨 天谴之门"
Lang["Unlock the Wrathgate events and the Battle for the Undercity"] = "解锁天谴之门事件和幽暗城之战"
Lang["Sons of Hodir"] = "霍迪尔之子"
Lang["Unlock the Sons of Hodir quest hub"] = "解锁霍迪尔之子任务线"
Lang["Knights of the Ebon Blade"] = "黑锋骑士团"
Lang["Unlock the Shadow Vault quest hub"] = "解锁暗影穹顶任务线"
Lang["Goblin"] = "地精"
Lang["Death Knight"] = "死亡骑士"
Lang["Eye"] = "眼"
Lang["Abomination"] = "憎恶"
Lang["Banshee"] = "女妖"
Lang["Geist"] = "恶鬼"
Lang["Icecrown"] = "冰冠冰川"
Lang["Dragonblight"] = "龙骨荒野"
Lang["Borean Tundra"] = "北风苔原"
Lang["The Storm Peaks"] = "风暴峭壁"
Lang["The Eye of Eternity"] = "永恒之眼"
Lang["Sapphiron"] = "萨菲隆"
Lang["One_Desc"] = "团队中只需一个人拥有此钥匙。"


-- OPTIONS
Lang["MinimapButton_TEXT"] = "显示小地图按钮"
Lang["MinimapButton_DESC"] = "显示小地图按钮可快速访问插件界面或选项。"
Lang["AutoSurvey_TEXT"] = "对登录运行公会自动调查"
Lang["AutoSurvey_DESC"] = "每当您登录游戏时，插件都会进行行会调查。"
Lang["ShowSurveyed_TEXT"] = "在接受调查时显示"
Lang["ShowSurveyed_DESC"] =  "接收（和回答）调查请求时显示聊天消息。"
Lang["ShowResponses_TEXT"] = "进行调查时显示答复"
Lang["ShowResponses_DESC"] = "显示每个调查响应的聊天消息。"
Lang["ShowSetMessages_TEXT"] = "显示步骤完成消息"
Lang["ShowSetMessages_DESC"] = "当步调完成时，显示聊天消息。"
Lang["AnnounceToGuild_TEXT"] = "在公会聊天中宣布完成"
Lang["AnnounceToGuild_DESC"] = "使用权完成后发送公会消息。"
Lang["ShowOther_TEXT"] = "显示其他聊天消息"
Lang["ShowOther_DESC"] = "显示所有其他常规聊天消息（启动消息，发送调查，可用更新等）。"
Lang["ShowGuildies_TEXT"] = "在每个使用权步骤中显示行会成员列表。             最大清单大小"  --this has a gap for the editbox
Lang["ShowGuildies_DESC"] = "当前在使用权步骤中的行会成员列表显示在步骤工具提示中。\n如有必要，请调整要在每个调整步骤中列出的最大结果数。"
Lang["ShowAltsInstead_TEXT"] = "显示替代列表，而不是公会成员"
Lang["ShowAltsInstead_DESC"] = "步骤工具提示将显示您当前在该使用权步骤中的所有替代项，而不是行会成员。"
Lang["ClearAll_TEXT"] = "删除所有结果"
Lang["ClearAll_DESC"] = "删除所有收集的有关其他玩家的信息。"
Lang["ClearAll_CONF"] = "真的要删除所有结果吗？"
Lang["ClearAll_DONE"] = "所有结果已删除。"
Lang["DelNonGuildies_TEXT"] = "删除非公会会员"
Lang["DelNonGuildies_DESC"] = "从公会外部删除所有有关玩家的信息。"
Lang["DelNonGuildies_CONF"] = "真的删除所有非公会会员吗？"
Lang["DelNonGuildies_DONE"] = "公会以外的所有结果均已删除。"
Lang["DelUnder60_TEXT"] = "删除60岁以下的字符"
Lang["DelUnder60_DESC"] = "删除所有收集的有关60级以下玩家的信息。"
Lang["DelUnder60_CONF"] = "真的要删除60级以下的所有角色吗？"
Lang["DelUnder60_DONE"] = "所有低于60的结果均已删除."
Lang["DelUnder70_TEXT"] = "删除70岁以下的字符"
Lang["DelUnder70_DESC"] = "删除所有收集的有关70级以下玩家的信息。"
Lang["DelUnder70_CONF"] = "真的要删除70级以下的所有角色吗？"
Lang["DelUnder70_DONE"] = "所有低于70的结果均已删除."
--302
Lang["AnnounceAchieve_TEXT"] = "在公会聊天中宣布成就                                      临界点:"
Lang["AnnounceAchieve_DESC"] = "获得成就时发送公会消息。"
Lang["AchieveCompleteGuild"] = "##LINK## 声望已达到!" 
Lang["AchieveCompletePoints"] = "(##POINTS## 总积分)" 
Lang["AchieveSurvey"] = "想要|cFFFFD100Attune|r 在公会聊天中公布|cFFFFD100##WHO##|r 的成就吗？"
--306
Lang["showDeprecatedAttunes_TEXT"] = "显示已弃用的调谐"
Lang["showDeprecatedAttunes_DESC"] = "在列表中保持较旧的调音（奥妮克希亚 40、纳克萨玛斯 40）可见"


-- TREEVIEW
Lang["World of Warcraft"] = "经典旧世"
Lang["The Burning Crusade"] = "燃烧的远征"
Lang["Molten Core"] = "熔火之心"
Lang["Onyxia's Lair"] = "奥妮克希亚的巢穴"
Lang["Blackwing Lair"] = "黑翼之巢"
Lang["Naxxramas"] = "纳克萨玛斯"
Lang["Scepter of the Shifting Sands"] = "流沙节杖"
Lang["Shadow Labyrinth"] = "暗影迷宫"
Lang["The Shattered Halls"] = "破碎大厅"
Lang["The Arcatraz"] = "禁魔监狱"
Lang["The Black Morass"] = "黑色沼泽"
Lang["Thrallmar Heroics"] = "萨尔玛英雄"
Lang["Honor Hold Heroics"] = "荣耀堡英雄"
Lang["Cenarion Expedition Heroics"] = "塞纳里奥远征队英雄"
Lang["Lower City Heroics"] = "贫民窟英雄"
Lang["Sha'tar Heroics"] = "沙塔尔英雄"
Lang["Keepers of Time Heroics"] = "时光守护者英雄"
Lang["Nightbane"] = "夜之魇"
Lang["Karazhan"] = "卡拉赞"
Lang["Serpentshrine Cavern"] = "毒蛇神殿"
Lang["The Eye"] = "风暴要塞"
Lang["Mount Hyjal"] = "海加尔山"
Lang["Black Temple"] = "黑暗神殿"
Lang["MC_Desc"] = "团队中的所有成员都必须完成该任务，才能进入该副本，除非他们通过黑石深渊进入。" 
Lang["Ony_Desc"] = "团队中的所有成员都必须在其背包中携带龙火护符，才能进入该副本。"
Lang["BWL_Desc"] = "团队中的所有成员都必须完成该任务，才能进入该副本，除非他们通过黑石塔上层进入。"
Lang["All_Desc"] = "团队中的所有成员都必须完成该任务，才能进入该副本"
Lang["AQ_Desc"] = "每个服务器只要有一个人完成此任务，就能打开安其拉之门。"
Lang["OnlyOne_Desc"] = "小队中只需要有一个人拥有此钥匙。 350开锁技能的潜行者也可以打开大门。"
Lang["Heroic_Desc"] = "该小队的所有成员都需要声望和钥匙，才能进入英雄难度的地下城。"
Lang["NB_Desc"] = "团队中需要有一名成员拥有黑色骨灰才能召唤夜之魇。"
Lang["BT_Desc"] = "团队中的所有成员都必须拥有卡拉伯勋章，才能进入团队副本。"
Lang["BM_Desc"] = "组中的所有成员都需要完成任务链才能划分到实例中。" 
--v250
Lang["Aqual Quintessence"] = "水之精萃"
Lang["MC2_Desc"] = "用于召唤 管理者埃克索图斯。除了两个以外，熔火之心中的每个 Boss 都在地面上有符文，需要将其浇灌以使 管理者埃克索图斯 生成。" 
--v254
Lang["Magisters' Terrace Heroic"] = "魔导师平台英雄"
Lang["Magisters' Terrace"] = "魔导师平台"
Lang["MgT_Desc"] = "所有玩家都需要在普通模式下完成地牢才能在英雄模式下运行它。"
Lang["Isle of Quel'Danas"] = "奎尔丹纳斯岛"
Lang["Wrath of the Lich King"] = "巫妖王之怒"


-- GENERIC
Lang["Reach level"] = "达到等级"
Lang["Attuned"] = "完成"
Lang["Not attuned"] = "未完成"
Lang["AttuneColors"] = "蓝色: 完成\n红色:  未完成"
Lang["Minimum Level"] = "这是接取任务的最低等级。"
Lang["NPC Not Found"] = "找不到NPC信息"
Lang["Level"] = "等级"
Lang["Exalted with"] = "崇拜"
Lang["Revered with"] = "崇敬"
Lang["Honored with"] = "尊敬"
Lang["Friendly with"] = "友善"
Lang["Neutral with"] = "中立"
Lang["Quest"] = "任务"
Lang["Pick Up"] = "拾取"
Lang["Turn In"] = "上交"
Lang["Kill"] = "击杀"
Lang["Interact"] = "交互"
Lang["Item"] = "物品"
Lang["Required level"] = "所需等级"
Lang["Requires level"] = "需要等级"
Lang["Attunement or key"] = "开门任务或钥匙"
Lang["Reputation"] = "声望"
Lang["in"] = "进入"
Lang["Unknown Reputation"] = "未知声望"
Lang["Current progress"] = "当前进度"
Lang["Completion"] = "完成时间"
Lang["Quest information not found"] = "找不到任务信息"
Lang["Information not found"] = "找不到信息"
Lang["Solo quest"] = "单人任务"
Lang["Party quest"] = "小队任务 (##NB##-man)"
Lang["Raid quest"] = "团队任务 (##NB##-man)"
Lang["HEROIC"] = "英雄"
Lang["Elite"] = "精英"
Lang["Boss"] = "首领"
Lang["Rare Elite"] = "稀有精英"
Lang["Dragonkin"] = "龙类"
Lang["Troll"] = "巨魔"
Lang["Ogre"] = "食人魔"
Lang["Orc"] = "兽人"
Lang["Half-Orc"] = "半兽人"
Lang["Dragonkin (in Blood Elf form)"] = "龙类（血精灵形态）"
Lang["Human"] = "人类"
Lang["Dwarf"] = "矮人"
Lang["Mechanical"] = "机械"
Lang["Arakkoa"] = "鸦人"
Lang["Dragonkin (in Humanoid form)"] = "龙类（人形态）"
Lang["Ethereal"] = "虚空人"
Lang["Blood Elf"] = "血精灵"
Lang["Elemental"] = "元素"
Lang["Shiny thingy"] = "Shiny thingy"
Lang["Naga"] = "娜迦"
Lang["Demon"] = "恶魔"
Lang["Gronn"] = "戈隆"
Lang["Undead (in Dragon form)"] = "亡灵（龙形态）"
Lang["Tauren"] = "牛头人"
Lang["Qiraji"] = "其拉虫人"
Lang["Gnome"] = "侏儒"
Lang["Broken"] = "破碎者"
Lang["Draenei"] = "德莱尼"
Lang["Undead"] = "亡灵"
Lang["Gorilla"] = "猩猩"
Lang["Shark"] = "鲨鱼"
Lang["Chimaera"] = "奇美拉"
Lang["Wisp"] = "小精灵"
Lang["Night-Elf"] = "暗夜精灵"


-- REP
Lang["Argent Dawn"] = "银色黎明"
Lang["Brood of Nozdormu"] = "诺兹多姆的子嗣"
Lang["Thrallmar"] = "萨尔玛"
Lang["Honor Hold"] = "荣耀堡"
Lang["Cenarion Expedition"] = "塞纳里奥远征队"
Lang["Lower City"] = "贫民窟"
Lang["The Sha'tar"] = "沙塔尔"
Lang["Keepers of Time"] = "时光守护者"
Lang["The Violet Eye"] = "紫罗兰之眼"
Lang["The Aldor"] = "奥尔多"
Lang["The Scryers"] = "占星者"


-- LOCATIONS
Lang["Blackrock Mountain"] = "黑石山"
Lang["Blackrock Depths"] = "黑石深渊"
Lang["Badlands"] = "荒芜之地"
Lang["Lower Blackrock Spire"] = "黑石塔下层"
Lang["Upper Blackrock Spire"] = "黑石塔上层"
Lang["Orgrimmar"] = "奥格瑞玛"
Lang["Western Plaguelands"] = "西瘟疫之地"
Lang["Desolace"] = "凄凉之地"
Lang["Dustwallow Marsh"] = "尘泥沼泽"
Lang["Tanaris"] = "塔纳利斯"
Lang["Winterspring"] = "冬泉谷"
Lang["Swamp of Sorrows"] = "悲伤沼泽"
Lang["Wetlands"] = "湿地"
Lang["Burning Steppes"] = "燃烧平原"
Lang["Redridge Mountains"] = "赤脊山"
Lang["Stormwind City"] = "暴风城"
Lang["Eastern Plaguelands"] = "东瘟疫之地"
Lang["Silithus"] = "希利苏斯"
Lang["The Temple of Atal'Hakkar"] = "阿塔哈卡神庙"
Lang["Teldrassil"] = "泰达希尔"
Lang["Moonglade"] = "月光林地"
Lang["Hinterlands"] = "辛特兰"
Lang["Ashenvale"] = "灰谷"
Lang["Feralas"] = "菲拉斯"
Lang["Duskwood"] = "暮色森林"
Lang["Azshara"] = "艾萨拉"
Lang["Blasted Lands"] = "诅咒之地"
Lang["Undercity"] = "幽暗城"
Lang["Silverpine Forest"] = "银松森林"
Lang["Shadowmoon Valley"] = "影月谷"
Lang["Hellfire Peninsula"] = "地狱火半岛"
Lang["Sethekk Halls"] = "塞泰克大厅"
Lang["Caverns Of Time"] = "时光之穴"
Lang["Netherstorm"] = "虚空风暴"
Lang["Shattrath City"] = "沙塔斯城"
Lang["The Mechanaar"] = "能源舰"
Lang["The Botanica"] = "生态船"
Lang["Zangarmarsh"] = "赞加沼泽"
Lang["Terokkar Forest"] = "泰罗卡森林"
Lang["Deadwind Pass"] = "逆风小径"
Lang["Alterac Mountains"] = "奥特兰克山脉"
Lang["The Steamvault"] = "蒸汽地窟"
Lang["Slave Pens"] = "奴隶围栏"
Lang["Gruul's Lair"] = "格鲁尔的巢穴"
Lang["Magtheridon's Lair"] = "玛瑟里顿的巢穴"
Lang["Zul'Aman"] = "祖阿曼"
Lang["Sunwell Plateau"] = "太阳之井高地"



-- ITEMS
Lang["Drakkisath's Brand"] = "达基萨斯的烙印"
Lang["Crystalline Tear"] = "水晶之泪"
Lang["I_18412"] = "熔火碎片"			-- https://cn.tbc.wowhead.com/?item=18412
Lang["I_12562"] = "重要的黑石文件"			-- https://cn.tbc.wowhead.com/?item=12562
Lang["I_16786"] = "黑色龙人的眼球"			-- https://cn.tbc.wowhead.com/?item=16786
Lang["I_11446"] = "弄皱的便笺"			-- https://cn.tbc.wowhead.com/?item=11446
Lang["I_11465"] = "温德索尔元帅遗失的情报"			-- https://cn.tbc.wowhead.com/?item=11465
Lang["I_11464"] = "温德索尔元帅遗失的情报"			-- https://cn.tbc.wowhead.com/?item=11464
Lang["I_18987"] = "黑手的命令"			-- https://cn.tbc.wowhead.com/?item=18987
Lang["I_20383"] = "勒什雷尔的徽记"			-- https://cn.tbc.wowhead.com/?item=20383
Lang["I_21138"] = "红色节杖碎片"			-- https://cn.tbc.wowhead.com/?item=21138
Lang["I_21146"] = "腐蚀梦魇的碎片"			-- https://cn.tbc.wowhead.com/?item=21146
Lang["I_21147"] = "腐蚀梦魇的碎片"			-- https://cn.tbc.wowhead.com/?item=21147
Lang["I_21148"] = "腐蚀梦魇的碎片"			-- https://cn.tbc.wowhead.com/?item=21148
Lang["I_21149"] = "腐蚀梦魇的碎片"			-- https://cn.tbc.wowhead.com/?item=21149
Lang["I_21139"] = "绿色节杖碎片"			-- https://cn.tbc.wowhead.com/?item=21139
Lang["I_21103"] = "龙语傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21103
Lang["I_21104"] = "龙语傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21104
Lang["I_21105"] = "龙语傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21105
Lang["I_21106"] = "龙语傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21106
Lang["I_21107"] = "龙语傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21107
Lang["I_21108"] = "龙语傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21108
Lang["I_21109"] = "龙语傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21109
Lang["I_21110"] = "龙语傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21110
Lang["I_21111"] = "龙语傻瓜教程：第二卷"			-- https://cn.tbc.wowhead.com/?item=21111
Lang["I_21027"] = "拉克麦拉的肉"			-- https://cn.tbc.wowhead.com/?item=21027
Lang["I_21024"] = "奇美洛克的腰肋肉"			-- https://cn.tbc.wowhead.com/?item=21024
Lang["I_20951"] = "纳瑞安的占卜眼镜"			-- https://cn.tbc.wowhead.com/?item=20951
Lang["I_21137"] = "蓝色节杖碎片"			-- https://cn.tbc.wowhead.com/?item=21137
Lang["I_21175"] = "流沙节杖"			-- https://cn.tbc.wowhead.com/?item=21175
Lang["I_31241"] = "原始钥匙模具"			-- https://cn.tbc.wowhead.com/?item=31241
Lang["I_31239"] = "原始钥匙模具"			-- https://cn.tbc.wowhead.com/?item=31239
Lang["I_27991"] = "暗影迷宫钥匙"			-- https://cn.tbc.wowhead.com/?item=27991
Lang["I_31086"] = "禁魔监狱钥匙的下半块"			-- https://cn.tbc.wowhead.com/?item=31086
Lang["I_31085"] = "禁魔监狱钥匙的上半块"			-- https://cn.tbc.wowhead.com/?item=31085
Lang["I_31084"] = "禁魔监狱钥匙"			-- https://cn.tbc.wowhead.com/?item=31084
Lang["I_30637"] = "焰铸钥匙"			-- https://cn.tbc.wowhead.com/?item=30637
Lang["I_30622"] = "焰铸钥匙"			-- https://cn.tbc.wowhead.com/?item=30622
Lang["I_30623"] = "水库钥匙"			-- https://cn.tbc.wowhead.com/?item=30623
Lang["I_30633"] = "奥金尼钥匙"			-- https://cn.tbc.wowhead.com/?item=30633
Lang["I_30634"] = "星船钥匙"			-- https://cn.tbc.wowhead.com/?item=30634
Lang["I_30635"] = "时光之钥"			-- https://cn.tbc.wowhead.com/?item=30635
Lang["I_185686"] = "焰铸钥匙"			-- https://cn.tbc.wowhead.com/?item=30637
Lang["I_185687"] = "焰铸钥匙"			-- https://cn.tbc.wowhead.com/?item=30622
Lang["I_185690"] = "水库钥匙"			-- https://cn.tbc.wowhead.com/?item=30623
Lang["I_185691"] = "奥金尼钥匙"			-- https://cn.tbc.wowhead.com/?item=30633
Lang["I_185692"] = "星船钥匙"			-- https://cn.tbc.wowhead.com/?item=30634
Lang["I_185693"] = "时光之钥"			-- https://cn.tbc.wowhead.com/?item=30635
Lang["I_24514"] = "第一块钥匙碎片"			-- https://cn.tbc.wowhead.com/?item=24514
Lang["I_24487"] = "第二块钥匙碎片"			-- https://cn.tbc.wowhead.com/?item=24487
Lang["I_24488"] = "第三块钥匙碎片"			-- https://cn.tbc.wowhead.com/?item=24488
Lang["I_24490"] = "麦迪文的钥匙"			-- https://cn.tbc.wowhead.com/?item=24490
Lang["I_23933"] = "麦迪文的日记"			-- https://cn.tbc.wowhead.com/?item=23933
Lang["I_25462"] = "暮色魔典"			-- https://cn.tbc.wowhead.com/?item=25462
Lang["I_25461"] = "忘却之名"			-- https://cn.tbc.wowhead.com/?item=25461
Lang["I_24140"] = "黑色骨灰"			-- https://cn.tbc.wowhead.com/?item=24140
Lang["I_31750"] = "土灵徽记"			-- https://cn.tbc.wowhead.com/?item=31750
Lang["I_31751"] = "灿烂徽记"			-- https://cn.tbc.wowhead.com/?item=31751
Lang["I_31716"] = "未使用的刽子手之斧"			-- https://cn.tbc.wowhead.com/?item=31716
Lang["I_31721"] = "卡利瑟里斯的三叉戟"			-- https://cn.tbc.wowhead.com/?item=31721
Lang["I_31722"] = "摩摩尔的精华"			-- https://cn.tbc.wowhead.com/?item=31722
Lang["I_31704"] = "风暴钥匙"			-- https://cn.tbc.wowhead.com/?item=31704
Lang["I_29905"] = "凯尔萨斯的水瓶残余"			-- https://cn.tbc.wowhead.com/?item=29905
Lang["I_29906"] = "瓦丝琪的水瓶残余"			-- https://cn.tbc.wowhead.com/?item=29906
Lang["I_31307"] = "愤怒之心"			-- https://cn.tbc.wowhead.com/?item=31307
Lang["I_32649"] = "卡拉波勋章"			-- https://cn.tbc.wowhead.com/?item=32649
--v247
Lang["Shrine of Thaurissan"] = "索瑞森神殿"
Lang["I_14610"] = "阿拉基的圣甲虫"
--v250
Lang["I_17332"] = "沙斯拉尔之手"
Lang["I_17329"] = "鲁西弗隆之手"
Lang["I_17331"] = "基赫纳斯之手"
Lang["I_17330"] = "萨弗隆之手"
Lang["I_17333"] = "水之精萃"
--WOTLK
Lang["I_41556"] = "熔渣包裹的金属"
Lang["I_44569"] = "聚焦之虹的钥匙"
Lang["I_44582"] = "聚焦之虹的钥匙"
Lang["I_44577"] = "英雄聚焦之虹的钥匙"
Lang["I_44581"] = "英雄聚焦之虹的钥匙"

Lang["I_"] = ""


-- QUESTS - Classic
Lang["Q1_7848"] = "熔火之心的传送门"			-- https://cn.tbc.wowhead.com/?quest=7848
Lang["Q2_7848"] = "进入黑石深渊，在通往熔火之心的传送门附近找到一块熔火碎片，然后回到黑石山脉的洛索斯·天痕那里。"
Lang["Q1_4903"] = "高图斯的命令"			-- https://cn.tbc.wowhead.com/?quest=4903
Lang["Q2_4903"] = "杀死欧莫克大王、指挥官沃恩和维姆萨拉克。找到重要的黑石文件，然后向卡加斯的军官高图斯汇报。"
Lang["Q1_4941"] = "伊崔格的智慧"			-- https://cn.tbc.wowhead.com/?quest=4941
Lang["Q2_4941"] = "和奥格瑞玛的伊崔格谈一谈。讨论完毕后，咨询萨尔的意见。\n\n你回忆起曾在萨尔的大厅中见过伊崔格。"
Lang["Q1_4974"] = "为部落而战！"			-- https://cn.tbc.wowhead.com/?quest=4974
Lang["Q2_4974"] = "去黑石塔杀死大酋长雷德·黑手，带着他的徽记返回奥格瑞玛。"
Lang["Q1_6566"] = "风吹来的消息"			-- https://cn.tbc.wowhead.com/?quest=6566
Lang["Q2_6566"] = "听萨尔讲话。"
Lang["Q1_6567"] = "部落的勇士"			-- https://cn.tbc.wowhead.com/?quest=6567
Lang["Q2_6567"] = "按照酋长的指示找到雷克萨。他在石爪山和菲拉斯之间的凄凉之地游荡。"
Lang["Q1_6568"] = "雷克萨的证明"			-- https://cn.tbc.wowhead.com/?quest=6568
Lang["Q2_6568"] = "把雷克萨的证明交给西瘟疫之地的巫女麦兰达。"
Lang["Q1_6569"] = "黑龙幻象"			-- https://cn.tbc.wowhead.com/?quest=6569
Lang["Q2_6569"] = "到黑石塔去收集20颗黑色龙人的眼球，完成任务之后回到巫女麦兰达那里。"
Lang["Q1_6570"] = "埃博斯塔夫"			-- https://cn.tbc.wowhead.com/?quest=6570
Lang["Q2_6570"] = "到尘泥沼泽中的巨龙沼泽去，找到埃博斯塔夫的洞穴。进入洞穴之后戴上龙形护符，然后跟埃博斯塔夫交谈。"
Lang["Q1_6584"] = "龙骨试炼，克鲁纳里斯"			-- https://cn.tbc.wowhead.com/?quest=6584
Lang["Q2_6584"] = "诺兹多姆的孩子克鲁纳里斯在塔纳利斯沙漠守卫着时光之穴。杀了他，把他的颅骨交给埃博斯塔夫。"
Lang["Q1_6582"] = "龙骨试炼，斯克利尔"			-- https://cn.tbc.wowhead.com/?quest=6582
Lang["Q2_6582"] = "找到蓝龙斯克利尔并杀掉他。从他的身上取下他的颅骨，然后将其交给埃博斯塔夫。"
Lang["Q1_6583"] = "龙骨试炼，索姆努斯"			-- https://cn.tbc.wowhead.com/?quest=6583
Lang["Q2_6583"] = "杀掉绿龙索姆努斯，把他的颅骨交给埃博斯塔夫。"
Lang["Q1_6585"] = "龙骨试炼，埃克托兹"			-- https://cn.tbc.wowhead.com/?quest=6585
Lang["Q2_6585"] = "到格瑞姆巴托去杀掉红龙埃克托兹，把他的颅骨交给埃博斯塔夫。"
Lang["Q1_6601"] = "晋升……"			-- https://cn.tbc.wowhead.com/?quest=6601
Lang["Q2_6601"] = "看来这场假面舞会就要结束了。你知道麦兰达为你制作的龙形护符在黑石塔里面不会发挥作用，也许你应该去找雷克萨，将你的困境告诉他。把黯淡的龙火护符给他看看，也许他知道下一步该怎么做。"
Lang["Q1_6602"] = "黑龙勇士之血"			-- https://cn.tbc.wowhead.com/?quest=6602
Lang["Q2_6602"] = "到黑石塔去杀掉达基萨斯将军，把它的血交给雷克萨。"
Lang["Q1_4182"] = "黑龙的威胁"			-- https://cn.tbc.wowhead.com/?quest=4182
Lang["Q2_4182"] = "杀掉15条黑色小龙、10条黑色龙人、4条火鳞龙人和1条黑色幼龙。"
Lang["Q1_4183"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4183
Lang["Q2_4183"] = "把赫林迪斯·河角的信交给赤脊山湖畔镇的所罗门镇长。"
Lang["Q1_4184"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4184
Lang["Q2_4184"] = "到暴风城去把所罗门的求援信交给伯瓦尔·弗塔根公爵。\n\n伯瓦尔在暴风要塞里。"
Lang["Q1_4185"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4185
Lang["Q2_4185"] = "与女伯爵卡特拉娜·普瑞斯托谈话，然后再与伯瓦尔·弗塔根公爵谈话。"
Lang["Q1_4186"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4186
Lang["Q2_4186"] = "把伯瓦尔的命令交给湖畔镇的所罗门镇长。"
Lang["Q1_4223"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4223
Lang["Q2_4223"] = "和燃烧平原的麦克斯韦尔元帅谈一谈。"
Lang["Q1_4224"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4224
Lang["Q2_4224"] = "和狼狈不堪的约翰谈谈来了解温德索尔元帅的命运，然后回到麦克斯韦尔元帅那里。\n\n你想起麦克斯韦尔元帅说过他在一个北面的洞穴那里。"
Lang["Q1_4241"] = "温德索尔元帅"			-- https://cn.tbc.wowhead.com/?quest=4241
Lang["Q2_4241"] = "到西北部的黑石山脉去，在黑石深渊中找到温德索尔元帅的下落。\n\n狼狈不堪的约翰曾告诉你说温德索尔被关进了一个监狱。"
Lang["Q1_4242"] = "被遗弃的希望"			-- https://cn.tbc.wowhead.com/?quest=4242
Lang["Q2_4242"] = "把这个坏消息传达给麦克斯韦尔元帅。"
Lang["Q1_4264"] = "弄皱的便笺"			-- https://cn.tbc.wowhead.com/?quest=4264
Lang["Q2_4264"] = "温德索尔元帅也许会对你手中的东西感兴趣。毕竟，希望还没有被完全扼杀。"
Lang["Q1_4282"] = "一丝希望"			-- https://cn.tbc.wowhead.com/?quest=4282
Lang["Q2_4282"] = "找回温德索尔元帅遗失的情报。\n\n温德索尔元帅确信那些情报在安格弗将军和傀儡统帅阿格曼奇的手里。"
Lang["Q1_4322"] = "冲破牢笼！"			-- https://cn.tbc.wowhead.com/?quest=4322
Lang["Q2_4322"] = "帮助温德索尔元帅拿回他的装备并救出他的朋友。当你成功之后就回去向麦克斯韦尔元帅复命。"
Lang["Q1_6402"] = "集合在暴风城"			-- https://cn.tbc.wowhead.com/?quest=6402
Lang["Q2_6402"] = "前往暴风城的城门。与侍卫洛文交谈，他会通知温德索尔元帅你已经到达了。"
Lang["Q1_6403"] = "潜藏者"			-- https://cn.tbc.wowhead.com/?quest=6403
Lang["Q2_6403"] = "跟随雷吉纳德·温德索尔元帅在暴风城中前进。保护他，别让他受到伤害！"
Lang["Q1_6501"] = "巨龙之眼"			-- https://cn.tbc.wowhead.com/?quest=6501
Lang["Q2_6501"] = "你必须寻遍世界以找到一种能恢复龙眼碎片的能量的生物。你对这种生物的唯一了解就是：他们确实存在。"
Lang["Q1_6502"] = "龙火护符"			-- https://cn.tbc.wowhead.com/?quest=6502
Lang["Q2_6502"] = "你必须从达基萨斯将军身上取回黑龙勇士之血，你可以在黑石塔的晋升大厅后面的房间里找到他。"
Lang["Q1_7761"] = "黑手的命令"			-- https://cn.tbc.wowhead.com/?quest=7761
Lang["Q2_7761"] = "真是个愚蠢的兽人。看来你需要找到那枚烙印并获得达基萨斯徽记才可以使用命令宝珠。\n\n你从信中获知，达基萨斯将军守卫着烙印。也许你应该就此进行更深入的调查。"
Lang["Q1_9121"] = "恐怖之城，纳克萨玛斯"			-- https://cn.tbc.wowhead.com/?quest=9121
Lang["Q2_9121"] = "东瘟疫之地圣光之愿礼拜堂的大法师安吉拉·杜萨图斯需要5块奥术水晶、2块连结水晶、1个正义宝珠和60金币。你在银色黎明中的声望必须达到尊敬。"
Lang["Q1_9122"] = "恐怖之城，纳克萨玛斯"			-- https://cn.tbc.wowhead.com/?quest=9122
Lang["Q2_9122"] = "东瘟疫之地圣光之愿礼拜堂的大法师安吉拉·杜萨图斯需要2块奥术水晶、1块连结水晶和30金币。你在银色黎明中的声望必须达到崇敬。"
Lang["Q1_9123"] = "恐怖之城，纳克萨玛斯"			-- https://cn.tbc.wowhead.com/?quest=9123
Lang["Q2_9123"] = "东瘟疫之地圣光之愿礼拜堂的大法师安吉拉·杜萨图斯会免费为你施放奥术遮罩的咒语。你在银色黎明中的声望必须达到崇拜。"
Lang["Q1_8286"] = "明天的希望"			-- https://cn.tbc.wowhead.com/?quest=8286
Lang["Q2_8286"] = "前往塔纳利斯的时光之穴寻找诺兹多姆的子嗣，阿纳克洛斯。"
Lang["Q1_8288"] = "唯一的领袖"			-- https://cn.tbc.wowhead.com/?quest=8288
Lang["Q2_8288"] = "到黑石山中的奈法利安巢穴去，杀死勒什雷尔，并带回它的头颅。\n\n将勒什雷尔的头颅交给希利苏斯塞纳里奥要塞的流沙守望者巴里斯托尔斯。"
Lang["Q1_8301"] = "正义之路"			-- https://cn.tbc.wowhead.com/?quest=8301
Lang["Q2_8301"] = "为流沙守望者巴里斯托尔斯收集200块异种蝎壳碎片。"
Lang["Q1_8303"] = "阿纳克洛斯"			-- https://cn.tbc.wowhead.com/?quest=8303
Lang["Q2_8303"] = "到塔纳利斯的时光之穴去寻找阿纳克洛斯。"
Lang["Q1_8305"] = "久远的记忆"			-- https://cn.tbc.wowhead.com/?quest=8305
Lang["Q2_8305"] = "找到希利苏斯的水晶之泪，并凝视它。"
Lang["Q1_8519"] = "往日的回忆"			-- https://cn.tbc.wowhead.com/?quest=8519
Lang["Q2_8519"] = "了解所有可以了解的关于的过去的事情，然后和塔纳利斯时光之穴的阿纳克洛斯谈谈。"
Lang["Q1_8555"] = "守护之龙"			-- https://cn.tbc.wowhead.com/?quest=8555
Lang["Q2_8555"] = "伊兰尼库斯、瓦拉斯塔兹、和艾索雷葛斯……你的确知道这些龙，凡人。这不是巧合，他们看守我们的世界，扮演着如此有影响力的角色。\n\n不幸的是(有部份也要怪我涉世未深)不论是上古诸神的密探或者称他们为朋友的背叛者，每个守卫都沦陷了。其程度只加深了我对你的种族的不信任。\n\n找到他们……，做好最坏的准备吧。"
Lang["Q1_8730"] = "奈法里奥斯的腐蚀"			-- https://cn.tbc.wowhead.com/?quest=8730
Lang["Q2_8730"] = "杀死奈法利安，并拿到红色节杖碎片。把红色节杖碎片交给塔纳利斯时光之穴入口处的阿纳克洛斯。你必须在5小时之内完成这个任务。"
Lang["Q1_8733"] = "伊兰尼库斯，梦境之暴君"			-- https://cn.tbc.wowhead.com/?quest=8733
Lang["Q2_8733"] = "到达纳苏斯的城墙外去找到玛法里奥的亲信。"
Lang["Q1_8734"] = "泰兰德和雷姆洛斯"			-- https://cn.tbc.wowhead.com/?quest=8734
Lang["Q2_8734"] = "到月光林地去，和守护者雷姆洛斯谈一谈。"
Lang["Q1_8735"] = "腐蚀梦魇"			-- https://cn.tbc.wowhead.com/?quest=8735
Lang["Q2_8735"] = "到艾泽拉斯世界的四个翡翠梦境入口去，分别收集该处的腐蚀梦魇的碎片。当你任务完成之后，就回到月光林地的守护者雷姆洛斯那里。"
Lang["Q1_8736"] = "噩梦显现"			-- https://cn.tbc.wowhead.com/?quest=8736
Lang["Q2_8736"] = "保护永夜港免受伊兰尼库斯的伤害。不要让守护者雷姆洛斯死亡。不要杀掉伊兰尼库斯。保护好你们自己。等待泰兰德。"
Lang["Q1_8741"] = "勇士归来"			-- https://cn.tbc.wowhead.com/?quest=8741
Lang["Q2_8741"] = "把绿色节杖碎片交给塔纳利斯时光之穴的阿纳克洛斯。"
Lang["Q1_8575"] = "艾索雷葛斯的魔法账本"			-- https://cn.tbc.wowhead.com/?quest=8575
Lang["Q2_8575"] = "把魔法账本交给塔纳利斯的纳瑞安。"
Lang["Q1_8576"] = "翻译龙语"			-- https://cn.tbc.wowhead.com/?quest=8576
Lang["Q2_8576"] = "先处理当务之急，我们必须搞清楚艾索雷葛斯到底在石板上写了什麽。\n\n你说他叫你做一个奥金浮标而这只是个概要图吗?可是他会用龙语写还真奇怪。那个讨厌的老家伙知道我看不懂这乱七八糟的文字。\n\n如果有用的话，我需要我的水晶球护目镜，一只500磅的鸡和〝龙语傻瓜教程〞第二卷。不需要按照顺序。"
Lang["Q1_8597"] = "龙语傻瓜教程"			-- https://cn.tbc.wowhead.com/?quest=8597
Lang["Q2_8597"] = "寻找纳瑞安埋在南海的某座小岛上的书。"
Lang["Q1_8599"] = "唱给纳瑞安的情歌"			-- https://cn.tbc.wowhead.com/?quest=8599
Lang["Q2_8599"] = "把米莉蒂丝的情书交给塔纳利斯的纳瑞安。"
Lang["Q1_8598"] = "敲诈"			-- https://cn.tbc.wowhead.com/?quest=8598
Lang["Q2_8598"] = "把勒索信交给塔纳利斯的纳瑞安。"
Lang["Q1_8606"] = "螳螂捕蝉！"			-- https://cn.tbc.wowhead.com/?quest=8606
Lang["Q2_8606"] = "塔纳利斯的纳瑞安要你去冬泉谷，把一袋金子放在绑匪的勒索信上所写的位置。他还要求你教训一下那些家伙！"
Lang["Q1_8620"] = "唯一的方案"			-- https://cn.tbc.wowhead.com/?quest=8620
Lang["Q2_8620"] = "把8章《龙语傻瓜教程》的章节用魔法书封面合起来，然后把完整的《龙语傻瓜教程：第二卷》交给塔纳利斯的纳瑞安。"
Lang["Q1_8584"] = "少管闲事"			-- https://cn.tbc.wowhead.com/?quest=8584
Lang["Q2_8584"] = "塔纳利斯的纳瑞安让你和加基森的迪尔格·奎克里弗谈一谈。"
Lang["Q1_8585"] = "恐怖之岛！"			-- https://cn.tbc.wowhead.com/?quest=8585
Lang["Q2_8585"] = "加基森的迪尔格·奎克里弗要你去菲拉斯的恐怖之岛击杀拉克麦拉，获得拉克麦拉的肉，并从岛上收集20份奇美洛克的腰肋肉。"
Lang["Q1_8586"] = "迪尔格的超美味奇美拉肉片"			-- https://cn.tbc.wowhead.com/?quest=8586
Lang["Q2_8586"] = "加基森的迪尔格·奎克里弗要你给他带去20份地精火箭燃油和20份石中盐。"
Lang["Q1_8587"] = "向纳瑞安回复"			-- https://cn.tbc.wowhead.com/?quest=8587
Lang["Q2_8587"] = "把500磅的小鸡交给塔纳利斯的纳瑞安。"
Lang["Q1_8577"] = "斯图沃尔，前任死党"			-- https://cn.tbc.wowhead.com/?quest=8577
Lang["Q2_8577"] = "纳瑞安要你找到他的前任死党斯图沃尔，从他那里拿回从纳瑞安那里偷走的占卜眼镜。"
Lang["Q1_8578"] = "占卜眼镜？没问题！"			-- https://cn.tbc.wowhead.com/?quest=8578
Lang["Q2_8578"] = "找到纳瑞安的占卜眼镜。"
Lang["Q1_8728"] = "好消息和坏消息"			-- https://cn.tbc.wowhead.com/?quest=8728
Lang["Q2_8728"] = "塔纳利斯的纳瑞安要你给他带去20块奥金锭、10块源质矿石、10颗艾泽拉斯钻石，以及10颗蓝宝石。"
Lang["Q1_8729"] = "耐普图洛斯的愤怒"			-- https://cn.tbc.wowhead.com/?quest=8729
Lang["Q2_8729"] = "在艾萨拉风暴海湾一带的湍急的漩涡处使用奥金鱼漂。"
Lang["Q1_8742"] = "卡利姆多的力量"			-- https://cn.tbc.wowhead.com/?quest=8742
Lang["Q2_8742"] = "一千年过去了，正如命中注定的那样，一位勇士站在了我的面前。这位勇士将会带领他的人民走向新的纪元。\n\n上古之神在颤抖，是的，它在你坚定的信念面前恐惧地颤抖着。打破克苏恩的预言吧。\n\它知道你会到来的，勇士―它还知道卡利姆多的力量与你同在。当你做好准备之后，请通知我，我将把流沙权杖赐予你。"
Lang["Q1_8745"] = "时光之王的财宝"			-- https://cn.tbc.wowhead.com/?quest=8745
Lang["Q2_8745"] = "你好，勇士。我是神圣之锣和青铜龙军团的永恒观察者，乔纳森。\n\n永恒之王授权我让你从他永恒的宝物箱里选择一样物品。愿它能在你对抗克苏恩的战役中帮助你。"


-- QUESTS - TBC
Lang["Q1_10755"] = "堡垒的钥匙"			-- https://cn.tbc.wowhead.com/?quest=10755
Lang["Q2_10755"] = "将原始钥匙模具交给地狱火半岛萨尔玛的纳兹格雷尔。"
Lang["Q1_10756"] = "罗霍克大师"			-- https://cn.tbc.wowhead.com/?quest=10756
Lang["Q2_10756"] = "将原始钥匙模具交给萨尔玛的罗霍克。"
Lang["Q1_10757"] = "罗霍克的要求"			-- https://cn.tbc.wowhead.com/?quest=10757
Lang["Q2_10757"] = "将4块魔铁锭、2份奥法之尘和4颗火焰微粒交给地狱火半岛萨尔玛的罗霍克。"
Lang["Q1_10758"] = "比地狱更炎热"			-- https://cn.tbc.wowhead.com/?quest=10758
Lang["Q2_10758"] = "摧毁地狱火半岛的魔能机甲，将未淬火的钥匙模具插入魔能机甲的残骸，然后将灼烧过的钥匙模具交给萨尔玛的罗霍克。"
Lang["Q1_10754"] = "堡垒的钥匙"			-- https://cn.tbc.wowhead.com/?quest=10754
Lang["Q2_10754"] = "将原始钥匙模具交给地狱火半岛荣耀堡的远征军指挥官达纳斯·托尔贝恩。"
Lang["Q1_10762"] = "达姆菲大师"			-- https://cn.tbc.wowhead.com/?quest=10762
Lang["Q2_10762"] = "将原始钥匙模具交给荣耀堡的达姆菲。"
Lang["Q1_10763"] = "达姆菲的要求"			-- https://cn.tbc.wowhead.com/?quest=10763
Lang["Q2_10763"] = "将4块魔铁锭、2份奥法之尘和4颗火焰微粒交给地狱火半岛荣耀堡的达姆菲。"
Lang["Q1_10764"] = "比地狱更炎热"			-- https://cn.tbc.wowhead.com/?quest=10764
Lang["Q2_10764"] = "摧毁地狱火半岛的魔能机甲，将未淬火的钥匙模具插入魔能机甲的残骸，然后将灼烧过的钥匙模具交给荣耀堡的达姆菲。"
Lang["Q1_10279"] = "主宰之巢"			-- https://cn.tbc.wowhead.com/?quest=10279
Lang["Q2_10279"] = "与时光之穴的安多尔姆谈一谈。"
Lang["Q1_10277"] = "时光之穴"			-- https://cn.tbc.wowhead.com/?quest=10277
Lang["Q2_10277"] = "时光之穴的安多尔姆要你跟随时光监护者游览时光之穴。"
Lang["Q1_10282"] = "往日的希尔斯布莱德"			-- https://cn.tbc.wowhead.com/?quest=10282
Lang["Q2_10282"] = "时光之穴的安多尔姆要求你进入旧希尔斯布莱德丘陵，与伊洛希恩谈一谈。"
Lang["Q1_10283"] = "塔蕾莎的计谋"			-- https://cn.tbc.wowhead.com/?quest=10283
Lang["Q2_10283"] = "进入敦霍尔德城堡，将伊洛希恩交给你的燃烧弹包分别放入5间收容所内的木桶，并启动定时装置。"
Lang["Q1_10284"] = "逃离敦霍尔德"			-- https://cn.tbc.wowhead.com/?quest=10284
Lang["Q2_10284"] = "准备就绪后告知萨尔。保护萨尔逃离敦霍尔德城堡，并与他一起搭救塔蕾莎。\n\任务完成后与旧希尔斯布莱德丘陵的伊洛希恩谈一谈。"
Lang["Q1_10285"] = "返回安多尔姆身边"			-- https://cn.tbc.wowhead.com/?quest=10285
Lang["Q2_10285"] = "返回塔纳利斯沙漠的时光之穴，向幼时的安多尔姆复命。"
Lang["Q1_10265"] = "星界财团的水晶"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10265
Lang["Q2_10265"] = "将一件阿尔科隆水晶神器交给虚空风暴52区的虚空猎手卡尔伊。"
Lang["Q1_10262"] = "叛徒的徽记"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10262
Lang["Q2_10262"] = "收集10枚萨克希斯徽记，将它们交给虚空风暴52区的虚空猎手卡尔伊。"
Lang["Q1_10205"] = "星界强盗奈萨德"			-- https://cn.tbc.wowhead.com/?quest=10205
Lang["Q2_10205"] = "杀死星界强盗奈萨德，然后返回虚空风暴52区，向虚空猎手卡尔伊复命。"
Lang["Q1_10266"] = "寻求帮助"			-- https://cn.tbc.wowhead.com/?quest=10266
Lang["Q2_10266"] = "转至虚空风暴中央生态圆顶的中央圆顶哨站，找到加鲁斯并为他效力。"
Lang["Q1_10267"] = "贸易终结"			-- https://cn.tbc.wowhead.com/?quest=10267
Lang["Q2_10267"] = "收集10箱测量装置，然后返回虚空风暴中央生态圆顶的中央圆顶哨站，将它们交给加鲁斯。"
Lang["Q1_10268"] = "与节点亲王会面"			-- https://cn.tbc.wowhead.com/?quest=10268
Lang["Q2_10268"] = "转至虚空风暴的风暴尖塔，将测量装置交给节点亲王哈拉迈德的影像。"
Lang["Q1_10269"] = "一号三角点"			-- https://cn.tbc.wowhead.com/?quest=10269
Lang["Q2_10269"] = "利用三角测量仪找到一号三角点。找到之后，立刻转至虚空风暴法力熔炉：乌提斯的维序派哨站，向商人哈斯辛汇报三角点的位置。"
Lang["Q1_10275"] = "二号三角点"			-- https://cn.tbc.wowhead.com/?quest=10275
Lang["Q2_10275"] = "利用三角测量仪找到二号三角点。找到之后，立刻转至虚空风暴法力熔炉：艾拉对面的图鲁曼的营地，向星界商人图鲁曼汇报三角点的位置。"
Lang["Q1_10276"] = "三角测量"			-- https://cn.tbc.wowhead.com/?quest=10276
Lang["Q2_10276"] = "夺得阿塔玛水晶，然后返回虚空风暴的风暴之塔，将它交给节点亲王哈拉迈德的影像。"
Lang["Q1_10280"] = "送往沙塔斯的特殊货物"			-- https://cn.tbc.wowhead.com/?quest=10280
Lang["Q2_10280"] = "将阿塔玛水晶交给沙塔斯城圣光广场的阿达尔。"
Lang["Q1_10704"] = "如何杀入禁魔监狱"			-- https://cn.tbc.wowhead.com/?quest=10704
Lang["Q2_10704"] = "阿达尔要你取回禁魔监狱钥匙的上半块和下半块，他会将这两块碎片组合成禁魔监狱钥匙。"
Lang["Q1_9824"] = "奥术扰动"			-- https://cn.tbc.wowhead.com/?quest=9824
Lang["Q2_9824"] = "在麦迪文的酒窖内的地下水源附近使用紫罗兰占卜水晶，然后向卡拉赞外的大法师奥图鲁斯复命。"
Lang["Q1_9825"] = "幽灵的活动"			-- https://cn.tbc.wowhead.com/?quest=9825
Lang["Q2_9825"] = "将10个幽灵精华交给卡拉赞外的大法师奥图鲁斯。"
Lang["Q1_9826"] = "联络达拉然"			-- https://cn.tbc.wowhead.com/?quest=9826
Lang["Q2_9826"] = "将奥图鲁斯的报告交给达拉然巨坑外的大法师塞德瑞克。"
Lang["Q1_9829"] = "卡德加"			-- https://cn.tbc.wowhead.com/?quest=9829
Lang["Q2_9829"] = "将奥图鲁斯的报告交给泰罗卡森林中沙塔斯城的卡德加。"
Lang["Q1_9831"] = "卡拉赞的钥匙"			-- https://cn.tbc.wowhead.com/?quest=9831
Lang["Q2_9831"] = "卡德加要求你进入奥金顿的暗影迷宫中，回收储藏在那里的一个奥术容器中的第一块钥匙碎片。"
Lang["Q1_9832"] = "第二块和第三块"			-- https://cn.tbc.wowhead.com/?quest=9832
Lang["Q2_9832"] = "从盘牙水库内的一个奥术容器中拿到第二块钥匙碎片，从风暴要塞内的一个奥术容器中拿到第三块钥匙碎片。任务完成之后向沙塔斯城的卡德加复命。"
Lang["Q1_9836"] = "麦迪文的触摸"			-- https://cn.tbc.wowhead.com/?quest=9836
Lang["Q2_9836"] = "进入时光之穴，说服麦迪文让复原的学徒钥匙重新获得打开卡拉赞大门的能力。"
Lang["Q1_9837"] = "返回卡德加身边"			-- https://cn.tbc.wowhead.com/?quest=9837
Lang["Q2_9837"] = "将麦迪文的钥匙交给沙塔斯城的卡德加。"
Lang["Q1_9838"] = "紫罗兰之眼"			-- https://cn.tbc.wowhead.com/?quest=9838
Lang["Q2_9838"] = "与卡拉赞外的大法师奥图鲁斯谈一谈。"
Lang["Q1_9630"] = "麦迪文的日记"			-- https://cn.tbc.wowhead.com/?quest=9630
Lang["Q2_9630"] = "逆风小径的大法师奥图鲁斯要你进入卡拉赞，与拉维恩谈一谈。"
Lang["Q1_9638"] = "书呆子"			-- https://cn.tbc.wowhead.com/?quest=9638
Lang["Q2_9638"] = "与卡拉赞守护者的图书馆中的格拉达夫谈一谈。"
Lang["Q1_9639"] = "卡姆希丝"			-- https://cn.tbc.wowhead.com/?quest=9639
Lang["Q2_9639"] = "与卡拉赞守护者的图书馆中的卡姆希丝谈一谈。"
Lang["Q1_9640"] = "埃兰之影"			-- https://cn.tbc.wowhead.com/?quest=9640
Lang["Q2_9640"] = "将麦迪文的日记交给卡拉赞守护者的图书馆中的卡姆希丝。"
Lang["Q1_9645"] = "主宰的露台"			-- https://cn.tbc.wowhead.com/?quest=9645
Lang["Q2_9645"] = "进入卡拉赞的主宰的露台，阅读麦迪文的日记。完成任务后将麦迪文的日记交给大法师奥图鲁斯。"
Lang["Q1_9680"] = "挖掘历史"			-- https://cn.tbc.wowhead.com/?quest=9680
Lang["Q2_9680"] = "大法师奥图鲁斯要求你转至逆风小径，从卡拉赞以南的山脉中取回一块焦骨碎块。"
Lang["Q1_9631"] = "同事的帮助"			-- https://cn.tbc.wowhead.com/?quest=9631
Lang["Q2_9631"] = "将焦骨碎块交给虚空风暴52区的卡琳娜·拉瑟德。"
Lang["Q1_9637"] = "卡琳娜的要求"			-- https://cn.tbc.wowhead.com/?quest=9637
Lang["Q2_9637"] = "从地狱火堡垒破碎大厅的高阶术士奈瑟库斯手中夺得暮色魔典，从奥金顿塞泰克大厅的黑暗编织者塞斯手中夺得忘却之名，将它们交给卡琳娜·拉瑟德。"
Lang["Q1_9644"] = "夜之魇"			-- https://cn.tbc.wowhead.com/?quest=9644
Lang["Q2_9644"] = "进入卡拉赞的主宰的露台，碰触黑色骨灰，召唤夜之魇并杀死它，然后从夜之魇的尸体上取得暗淡的奥术精华，并将它交给大法师奥图鲁斯。"
Lang["Q1_10901|13431"] = "卡达什圣杖"			-- https://cn.tbc.wowhead.com/?quest=10901|13431
Lang["Q2_10901|13431"] = "将土灵徽记和灿烂徽记交给盘牙水库奴隶围栏的异教徒斯卡希斯。"
Lang["Q1_10900"] = "瓦丝琪的印记"			-- https://cn.tbc.wowhead.com/?quest=10900
Lang["Q2_10900"] = ""
Lang["Q1_10681"] = "古尔丹之手"			-- https://cn.tbc.wowhead.com/?quest=10681
Lang["Q2_10681"] = "与影月谷诅咒祭坛的大地治愈者托洛克谈一谈。"
Lang["Q1_10458"] = "愤怒的火灵和地灵"			-- https://cn.tbc.wowhead.com/?quest=10458
Lang["Q2_10458"] = "使用灵魂图腾俘获8个土之魂和8个火之魂，然后向影月谷诅咒祭坛的大地治愈者托洛克复命。"
Lang["Q1_10480"] = "愤怒的水灵"			-- https://cn.tbc.wowhead.com/?quest=10480
Lang["Q2_10480"] = "使用灵魂图腾俘获5个水之魂，然后向影月谷诅咒祭坛的大地治愈者托洛克复命。"
Lang["Q1_10481"] = "愤怒的气灵"			-- https://cn.tbc.wowhead.com/?quest=10481
Lang["Q2_10481"] = "使用灵魂图腾俘获10个气之魂，然后向影月谷诅咒祭坛的大地治愈者托洛克复命。"
Lang["Q1_10513"] = "欧鲁诺克·裂心"			-- https://cn.tbc.wowhead.com/?quest=10513
Lang["Q2_10513"] = "转至库斯卡水池北边的破碎岩床寻找欧鲁诺克·裂心。"
Lang["Q1_10514"] = "历经沧桑……"			-- https://cn.tbc.wowhead.com/?quest=10514
Lang["Q2_10514"] = "影月谷欧鲁诺克农场的欧鲁诺克·裂心要你在破碎平原收集10个影月块茎。"
Lang["Q1_10515"] = "严厉的教训"			-- https://cn.tbc.wowhead.com/?quest=10515
Lang["Q2_10515"] = "返回破碎平原，摧毁10枚贪婪剥石者的卵，然后向影月谷欧鲁诺克农场的欧鲁诺克·裂心复命。"
Lang["Q1_10519"] = "诅咒密码 - 真相和历史"			-- https://cn.tbc.wowhead.com/?quest=10519
Lang["Q2_10519"] = "影月谷欧鲁诺克农场的欧鲁诺克·裂心要你听听他的故事。跟欧鲁诺克谈谈，听这位年老的兽人讲述他的故事。"
Lang["Q1_10521"] = "格洛姆托，欧鲁诺克之子"			-- https://cn.tbc.wowhead.com/?quest=10521
Lang["Q2_10521"] = "转至影月谷的库斯卡岗哨寻找格洛姆托，欧鲁诺克之子。"
Lang["Q1_10527"] = "阿托尔，欧鲁诺克之子"			-- https://cn.tbc.wowhead.com/?quest=10527
Lang["Q2_10527"] = "转至影月谷的伊利达雷岗哨寻找阿托尔，欧鲁诺克之子。"
Lang["Q1_10546"] = "伯拉克，欧鲁诺克之子"			-- https://cn.tbc.wowhead.com/?quest=10546
Lang["Q2_10546"] = "转至影月谷的日蚀岗哨附近寻找伯拉克，欧鲁诺克之子。"
Lang["Q1_10522"] = "诅咒密码 - 格洛姆托的命令"			-- https://cn.tbc.wowhead.com/?quest=10522
Lang["Q2_10522"] = "取回诅咒密码的第一块碎片，然后向影月谷库斯卡岗哨的欧鲁诺克之子格洛姆托复命。"
Lang["Q1_10528"] = "恶魔的水晶牢笼"			-- https://cn.tbc.wowhead.com/?quest=10528
Lang["Q2_10528"] = "杀死伊利达雷岗哨的痛苦女王加布莉萨，夺得晶体钥匙，然后返回欧鲁诺克之子阿托尔的尸体旁。"
Lang["Q1_10547"] = "血蓟交易……"			-- https://cn.tbc.wowhead.com/?quest=10547
Lang["Q2_10547"] = "位于日蚀岗哨北面石桥旁的欧鲁诺克之子伯拉克要你将一枚腐烂的鸦人之卵交给沙塔斯城中的暴食者托比亚斯。"
Lang["Q1_10523"] = "诅咒密码 - 第一块碎片"			-- https://cn.tbc.wowhead.com/?quest=10523
Lang["Q2_10523"] = "将格洛姆托的箱子交给影月谷欧鲁诺克农场的欧鲁诺克·裂心。"
Lang["Q1_10537"] = "洛恩戈鲁，裂心之弓"			-- https://cn.tbc.wowhead.com/?quest=10537
Lang["Q2_10537"] = "影月谷伊利达雷岗哨的阿托尔的灵魂要你从驻守岗哨的恶魔手中夺得洛恩戈鲁，裂心之弓。"
Lang["Q1_10550"] = "一捆血蓟"			-- https://cn.tbc.wowhead.com/?quest=10550
Lang["Q2_10550"] = "将一捆血蓟交给位于影月谷日蚀岗哨附近石桥处的欧鲁诺克之子伯拉克。"
Lang["Q1_10540"] = "诅咒密码 - 阿托尔的命令"			-- https://cn.tbc.wowhead.com/?quest=10540
Lang["Q2_10540"] = "从维内拉图斯手中夺得诅咒密码的第二块碎片，然后向影月谷伊利达雷岗哨的阿托尔的灵魂复命。\n\n你无法从被灵魂猎手攻击或杀死的怪物身上获得物品和经验值。"
Lang["Q1_10570"] = "血蓟瘾君子"			-- https://cn.tbc.wowhead.com/?quest=10570
Lang["Q2_10570"] = "将怒风的信件交给位于影月谷日蚀岗哨附近石桥处的欧鲁诺克之子伯拉克。"
Lang["Q1_10576"] = "影月谷的乔装者"			-- https://cn.tbc.wowhead.com/?quest=10576
Lang["Q2_10576"] = "将6件日蚀护甲交给位于影月谷日蚀岗哨附近石桥处的欧鲁诺克之子伯拉克。"
Lang["Q1_10577"] = "伊利丹的信使……"			-- https://cn.tbc.wowhead.com/?quest=10577
Lang["Q2_10577"] = "位于影月谷日蚀岗哨附近石桥处的欧鲁诺克之子伯拉克要求你将伊利丹的口信传达给日蚀岗哨的总指挥官卢斯克。"
Lang["Q1_10578"] = "诅咒密码 - 伯拉克的命令"			-- https://cn.tbc.wowhead.com/?quest=10578
Lang["Q2_10578"] = "从亵渎者鲁尔手中夺回诅咒密码的第二块碎片，然后向位于影月谷日蚀岗哨附近石桥处的欧鲁诺克之子伯拉克复命。"
Lang["Q1_10541"] = "诅咒密码 - 第二块碎片"			-- https://cn.tbc.wowhead.com/?quest=10541
Lang["Q2_10541"] = "将阿托尔的箱子交给影月谷欧鲁诺克农场的欧鲁诺克·裂心。"
Lang["Q1_10579"] = "诅咒密码 - 第三块碎片"			-- https://cn.tbc.wowhead.com/?quest=10579
Lang["Q2_10579"] = "将伯拉克的箱子交给影月谷欧鲁诺克农场的欧鲁诺克·裂心。"
Lang["Q1_10588"] = "诅咒密码"			-- https://cn.tbc.wowhead.com/?quest=10588
Lang["Q2_10588"] = "在诅咒祭坛念诵诅咒密码，召唤出火焰之王森卢肯。\n\n杀死火焰之王森卢肯，然后与诅咒祭坛的大地治愈者托洛克谈一谈。"
Lang["Q1_10883"] = "风暴钥匙"			-- https://cn.tbc.wowhead.com/?quest=10883
Lang["Q2_10883"] = "与沙塔斯城的阿达尔谈一谈。"
Lang["Q1_10884"] = "纳鲁的试炼：仁慈"			-- https://cn.tbc.wowhead.com/?quest=10884
Lang["Q2_10884"] = "沙塔斯城的阿达尔要求你从地狱火堡垒的破碎大厅中取回未使用的刽子手之斧。\n\n该任务必须在英雄等级难度的地下城中完成。"
Lang["Q1_10885"] = "纳鲁的试炼：力量"			-- https://cn.tbc.wowhead.com/?quest=10885
Lang["Q2_10885"] = "沙塔斯城的阿达尔要求你取回卡利瑟里斯的三叉戟和摩摩尔的精华。\n\n该任务必须在英雄等级难度的地下城中完成。"
Lang["Q1_10886"] = "纳鲁的试炼：坚韧"			-- https://cn.tbc.wowhead.com/?quest=10886
Lang["Q2_10886"] = "沙塔斯城的阿达尔要求你从风暴要塞的禁魔监狱中救出米尔豪斯·法力风暴。\n\n该任务必须在英雄等级难度的地下城中完成。"
Lang["Q1_10888|13430"] = "纳鲁的试炼：玛瑟里顿"			-- https://cn.tbc.wowhead.com/?quest=10888|13430
Lang["Q2_10888|13430"] = "沙塔斯城的阿达尔要求你杀死玛瑟里顿。"
Lang["Q1_10680"] = "古尔丹之手"			-- https://cn.tbc.wowhead.com/?quest=10680
Lang["Q2_10680"] = "与影月谷诅咒祭坛的大地治愈者托洛克谈一谈。"
Lang["Q1_10445|13432"] = "永恒水瓶"			-- https://cn.tbc.wowhead.com/?quest=10445|13432
Lang["Q2_10445|13432"] = "时光之穴的索莉多米要你从盘牙水库的瓦丝琪那里取回瓦丝琪的水瓶残馀，并从风暴要塞的凯尔萨斯·逐日者那里取回凯尔萨斯的水瓶残馀。"
Lang["Q1_10568"] = "巴尔里石板"			-- https://cn.tbc.wowhead.com/?quest=10568
Lang["Q2_10568"] = "沙塔尔祭坛的学者希拉要你收集12块巴尔里石板，它们散落在巴尔里废墟中，那里的灰舌工人身上也携带着这种石板。\n\n为奥尔多阵营完成任务将降低你在占星者阵营中的声望等级。"
Lang["Q1_10683"] = "巴尔里石板"			-- https://cn.tbc.wowhead.com/?quest=10683
Lang["Q2_10683"] = "群星圣殿的奥术师塞里斯要你收集12块巴尔里石板。它们散落在巴尔里废墟中，那里的灰舌工人身上也携带着这种石板。\n\n为占星者阵营完成任务将降低你在奥尔多阵营中的声望等级。"
Lang["Q1_10571"] = "长者奥洛努"			-- https://cn.tbc.wowhead.com/?quest=10571
Lang["Q2_10571"] = "沙塔尔祭坛的学者希拉要求你从巴尔里废墟的长者奥洛努手中夺得阿卡玛的命令。\n\n为奥尔多阵营完成任务将降低你在占星者阵营中的声望等级。"
Lang["Q1_10684"] = "长者奥洛努"			-- https://cn.tbc.wowhead.com/?quest=10684
Lang["Q2_10684"] = "群星圣殿的奥术师塞里斯要求你从巴尔里废墟的长者奥洛努手中夺得阿卡玛的命令。\n\n为占星者阵营完成任务将降低你在奥尔多阵营中的声望等级。"
Lang["Q1_10574"] = "灰舌腐蚀者"			-- https://cn.tbc.wowhead.com/?quest=10574
Lang["Q2_10574"] = "从哈鲁姆、埃肯尼、拉坎恩和乌拉鲁手中夺得他们的勋章碎片，并把这些碎片交给影月谷沙塔尔祭坛的学者希拉。\n\n为奥尔多阵营完成任务将降低你在占星者阵营中的声望等级。"
Lang["Q1_10685"] = "灰舌腐蚀者"			-- https://cn.tbc.wowhead.com/?quest=10685
Lang["Q2_10685"] = "从哈鲁姆、埃肯尼、拉坎恩和乌拉鲁手中夺得他们的勋章碎片，并把这些碎片交给影月谷群星圣殿的奥术师塞里斯。\n\n为占星者阵营完成任务将降低你在奥尔多阵营中的声望等级。"
Lang["Q1_10575"] = "守望者的牢笼"			-- https://cn.tbc.wowhead.com/?quest=10575
Lang["Q2_10575"] = "学者希拉要求你进入巴尔里废墟以南的守望者牢笼，从萨诺鲁口中审问出阿卡玛的下落。\n\n为奥尔多完成任务将降低你在占星者阵营中的声望等级。"
Lang["Q1_10686"] = "守望者的牢笼"			-- https://cn.tbc.wowhead.com/?quest=10686
Lang["Q2_10686"] = "奥术师塞里斯要求你进入巴尔里废墟以南的守望者牢笼，从萨诺鲁口中审问出阿卡玛的下落。\n\n为占星者完成任务将降低你在奥尔多阵营中的声望等级。"
Lang["Q1_10622"] = "忠诚的证明"			-- https://cn.tbc.wowhead.com/?quest=10622
Lang["Q2_10622"] = "杀死影月谷内守望者牢笼的杉德拉斯，然后向萨诺鲁复命。"
Lang["Q1_10628"] = "阿卡玛"			-- https://cn.tbc.wowhead.com/?quest=10628
Lang["Q2_10628"] = "与守望者牢笼的密室中的阿卡玛谈一谈。"
Lang["Q1_10705"] = "先知乌达鲁"			-- https://cn.tbc.wowhead.com/?quest=10705
Lang["Q2_10705"] = "转至风暴要塞的禁魔监狱，寻找乌达鲁。"
Lang["Q1_10706"] = "神秘的征兆"			-- https://cn.tbc.wowhead.com/?quest=10706
Lang["Q2_10706"] = "向影月谷守望者牢笼的阿卡玛复命。"
Lang["Q1_10707"] = "阿塔玛平台"			-- https://cn.tbc.wowhead.com/?quest=10707
Lang["Q2_10707"] = "转至影月谷的阿塔玛平台顶部，夺得愤怒之心。完成任务后向影月谷守望者牢笼的阿卡玛复命。"
Lang["Q1_10708"] = "阿卡玛的保证"			-- https://cn.tbc.wowhead.com/?quest=10708
Lang["Q2_10708"] = "将卡拉波护符交给沙塔斯城的阿达尔。"
Lang["Q1_10944"] = "危险的秘密"			-- https://cn.tbc.wowhead.com/?quest=10944
Lang["Q2_10944"] = "转至影月谷内的守望者牢笼，与阿卡玛谈一谈。"
Lang["Q1_10946"] = "灰舌的计谋"			-- https://cn.tbc.wowhead.com/?quest=10946
Lang["Q2_10946"] = "转至风暴要塞，在穿着灰舌兜帽的情况下杀死奥。完成任务之后回到影月谷，向阿卡玛复命。"
Lang["Q1_10947"] = "往日的神器"			-- https://cn.tbc.wowhead.com/?quest=10947
Lang["Q2_10947"] = "转至塔纳利斯的时空之穴，进入海加尔山战役之后击败雷基·冬寒，将他的时光护符匣交给影月谷的阿卡玛。"
Lang["Q1_10948"] = "灵魂之囚"			-- https://cn.tbc.wowhead.com/?quest=10948
Lang["Q2_10948"] = "转至沙塔斯城，将阿卡玛的请求告诉阿达尔。"
Lang["Q1_10949"] = "进入黑暗神殿"			-- https://cn.tbc.wowhead.com/?quest=10949
Lang["Q2_10949"] = "转至影月谷的黑暗神殿入口处，与克希利谈一谈。"
Lang["Q1_10985|13429"] = "帮助阿卡玛"			-- https://cn.tbc.wowhead.com/?quest=10985|13429
Lang["Q2_10985|13429"] = "在克希利的军队发动佯攻之后，保护阿卡玛和玛维进入影月谷内的黑暗神殿。"
--v243
Lang["Q1_10984"] = "援助食人魔"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10984
Lang["Q2_10984"] = "与沙塔斯城贫民窟的食人魔格罗科尔谈一谈。"
Lang["Q1_10983"] = "枯瘦的莫戈多格"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10983
Lang["Q2_10983"] = "与枯瘦的莫戈多格谈一谈，他就在刀锋山鲜血之环外的某座塔顶上。"
Lang["Q1_10995"] = "格鲁洛克的巨龙颅骨"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10995
Lang["Q2_10995"] = "夺回格鲁洛克的巨龙颅骨，将其交给刀锋山鲜血之环塔顶上的枯瘦的莫戈多格。"
Lang["Q1_10996"] = "玛古克的宝箱"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10996
Lang["Q2_10996"] = "夺取玛古克的宝箱，将它交给刀锋山鲜血之环塔顶上的枯瘦的莫戈多格。"
Lang["Q1_10997"] = "戈隆的军旗"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10997
Lang["Q2_10997"] = "夺取斯莱格的军旗，将其交给刀锋山鲜血之环塔顶上的枯瘦的莫戈多格。"
Lang["Q1_10998"] = "维姆高尔的魔典"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10998
Lang["Q2_10998"] = "夺取维姆高尔的魔典，并将它带回刀锋山内鲜血之环的塔顶上，交给枯瘦的莫戈多格。"
Lang["Q1_11000"] = "磨魂者"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11000
Lang["Q2_11000"] = "夺得斯古洛克的灵魂，然后返回刀锋山的鲜血之环，将它交给塔楼顶部的枯瘦的莫戈多格。"
Lang["Q1_11022"] = "与莫戈多格会面"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11022
Lang["Q2_11022"] = "与枯瘦的莫戈多格谈一谈，他就在刀锋山鲜血之环东侧的塔楼顶部。"
Lang["Q1_11009"] = "食人魔的天堂"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11009
Lang["Q2_11009"] = "枯瘦的莫戈多格要求你与刀锋山奥格瑞拉的库洛尔谈一谈。"
--v244
Lang["Q1_10804"] = "友善"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10804
Lang["Q2_10804"] = "影月谷灵翼平原的莫德奈要你喂养8只成熟的灵翼幼龙。"
Lang["Q1_10811"] = "寻找奈尔萨拉库"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10811
Lang["Q2_10811"] = "寻找奈尔萨拉库，虚空龙族的领袖。"
Lang["Q1_10814"] = "奈尔萨拉库的故事"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10814
Lang["Q2_10814"] = "与奈尔萨拉库谈一谈，听听他的故事。"
Lang["Q1_10836"] = "攻击龙喉要塞"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10836
Lang["Q2_10836"] = "杀死15名龙喉兽人，然后向飞翔在影月谷灵翼平原上空的奈尔萨拉库复命。"
Lang["Q1_10837"] = "前往灵翼浮岛！"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10837
Lang["Q2_10837"] = "前往灵翼浮岛收集12枚灵藤水晶，然后向飞翔在影月谷灵翼平原上空的奈尔萨拉库复命。"
Lang["Q1_10854"] = "奈尔萨拉库之力"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10854
Lang["Q2_10854"] = "解救5只被奴役的灵翼幼龙，然后向飞翔在影月谷灵翼平原上空的奈尔萨拉库复命。"
Lang["Q1_10858"] = "卡瑞纳库"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10858
Lang["Q2_10858"] = "前往龙喉要塞，寻找卡瑞纳库。"
Lang["Q1_10866"] = "疲惫的祖鲁希德"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10866
Lang["Q2_10866"] = "杀死疲惫的祖鲁希德，取回祖鲁希德的钥匙，并用它打开祖鲁希德的锁链，释放卡瑞纳库。"
Lang["Q1_10870"] = "灵翼之盟"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10870
Lang["Q2_10870"] = "让卡瑞纳库把你送回灵翼平原的莫德奈身边。"
--v247
Lang["Q1_3801"] = "黑铁的遗产"			-- https://www.thegeekcrusade-serveur.com/db/?quest=3801
Lang["Q2_3801"] = "如果你想要得到进入这座城市主城区的钥匙，就去和弗兰克罗恩·铸铁谈一谈。"
Lang["Q1_3802"] = "黑铁的遗产"			-- https://www.thegeekcrusade-serveur.com/db/?quest=3802
Lang["Q2_3802"] = "杀掉弗诺斯·达克维尔并拿回战锤铁胆。把铁胆之锤拿到索瑞森神殿去，将其放在弗兰克罗恩·铸铁的雕像上。"
Lang["Q1_5096"] = "误导血色十字军"
Lang["Q2_5096"] = "到血色十字军建在费尔斯通农场和达尔松之泪之间的营地去，摧毁他们的指挥帐篷。"
Lang["Q1_5098"] = "标记哨塔"
Lang["Q2_5098"] = "使用信号火炬为安多哈尔城中的四座哨塔做上标记，你必须站在哨塔门口才能成功地进行标记。"
Lang["Q1_838"] = "通灵学院"
Lang["Q2_838"] = "和西瘟疫之地亡灵壁垒的药剂师迪瑟斯谈一谈。"
Lang["Q1_964"] = "骸骨碎片"
Lang["Q2_964"] = "将15块骸骨碎片交给西瘟疫之地亡灵壁垒的药剂师迪瑟斯。"
Lang["Q1_5514"] = "昂贵的模具"
Lang["Q2_5514"] = "把灌魔的骸骨碎片和15枚金币交给加基森的克林科·古德斯迪尔。"
Lang["Q1_5802"] = "火羽山"
Lang["Q2_5802"] = "把骷髅钥匙模具和2块瑟银锭带到安戈洛尔环形山地区的火羽山顶部。在熔岩湖旁使用骷髅钥匙模具，铸造出一把未完工的骷髅钥匙。"
Lang["Q1_5804"] = "阿拉基的圣甲虫"
Lang["Q2_5804"] = "杀掉召唤者阿拉基，并将阿拉基的圣甲虫交给西瘟疫之地亡灵壁垒的药剂师迪瑟斯。"
Lang["Q1_5511"] = "通灵学院的钥匙"
Lang["Q2_5511"] = "好吧，你在这里 - 完成的万能钥匙。 我可以肯定，这把钥匙会让你在通灵学院的范围内。"
Lang["Q1_5092"] = "扫清道路"
Lang["Q2_5092"] = "杀掉悔恨岭中的10个骷髅剥皮者和10个被奴役的食尸鬼。"
Lang["Q1_5097"] = "标记哨塔"
Lang["Q2_5097"] = "使用信号火炬为安多哈尔城中的四座哨塔做上标记，你必须站在哨塔门口才能成功地进行标记。"
Lang["Q1_5533"] = "通灵学院"
Lang["Q2_5533"] = "和西瘟疫之地冰风岗的化学家阿尔比顿谈一谈。"
Lang["Q1_5537"] = "骸骨碎片"
Lang["Q2_5537"] = "将15块骷髅碎片交给西瘟疫之地冰风岗的化学家阿尔比顿。"
Lang["Q1_5538"] = "昂贵的模具"
Lang["Q2_5538"] = "把灌魔的骸骨碎片和15枚金币交给加基森的克林科·古德斯迪尔。"
Lang["Q1_5801"] = "火羽山"
Lang["Q2_5801"] = "把骷髅钥匙模具和2块瑟银锭带到安戈洛尔环形山地区的火羽山顶部。在熔岩湖旁使用骷髅钥匙模具，铸造出一把未完工的骷髅钥匙。"
Lang["Q1_5803"] = "阿拉基的圣甲虫"
Lang["Q2_5803"] = "杀掉召唤者阿拉基，并将阿拉基的圣甲虫交给西瘟疫之地冰风岗的化学家阿尔比顿。"
Lang["Q1_5505"] = "通灵学院的钥匙"
Lang["Q2_5505"] = "好吧，你在这里 - 完成的万能钥匙。 我可以肯定，这把钥匙会让你在通灵学院的范围内。"
--v250
Lang["Q1_6804"] = "被囚禁的水元素"
Lang["Q2_6804"] = "对东瘟疫之地的被感染的水元素使用海神之水。把12副不谐护腕和海神之水交给艾萨拉的海达克西斯公爵。"
Lang["Q1_6805"] = "雷暴和磐石"
Lang["Q2_6805"] = "杀死15个灰尘风暴和15个沙漠奔行者，然后回到艾萨拉的海达克西斯公爵那儿。"
Lang["Q1_6821"] = "艾博希尔之眼"
Lang["Q2_6821"] = "将艾博希尔之眼交给艾萨拉的海达克西斯公爵。"
Lang["Q1_6822"] = "熔火之心"
Lang["Q2_6822"] = "杀死一个火焰之王、一个熔岩巨人、一个上古熔火恶犬和一个熔岩奔腾者，然后回到艾萨拉的海达克西斯公爵那里。"
Lang["Q1_6823"] = "海达克西斯的使者"
Lang["Q2_6823"] = "在海达希亚水元素中达到被尊敬的声望，然后与艾萨拉的海达克西斯公爵谈一谈。"
Lang["Q1_6824"] = "敌人之手"
Lang["Q2_6824"] = "将鲁西弗隆之手、萨弗隆之手、基赫纳斯之手和沙斯拉尔之手交给艾萨拉的海达克西斯公爵。"
Lang["Q1_7486"] = "英雄的奖赏"
Lang["Q2_7486"] = "从海达克西斯的箱子拿取你的奖励。"
--v254
Lang["Q1_11481"] = "太阳之井的危机"
Lang["Q2_11481"] = "沙塔斯城奥尔多高地的圣光护卫者阿德因要求你前往太阳之井高地，与主教拉雷索尔谈一谈。"
Lang["Q1_11488"] = "魔导师平台"
Lang["Q2_11488"] = "破碎残阳基地的主教拉雷索尔要求你前往魔导师平台，寻找血精灵间谍塔雷斯的踪迹。"
Lang["Q1_11490"] = "占星球"
Lang["Q2_11490"] = "塔雷斯要求你使用魔导师平台内的阳台上的宝珠。"
Lang["Q1_11492"] = "大难不死"
Lang["Q2_11492"] = "卡雷苟斯要求你击败魔导师平台内的凯尔萨斯。取下凯尔萨斯的徽记之后，立刻向破碎残阳基地的主教拉雷索尔复命。"


--WOTLK QUESTS
-- The ids are Q1_<QuestId> and Q2_<QuestId>
-- Q1 is just the title of the quest
-- Q2 is the description/synopsis, with some helpful comments in between \n\n|cff33ff99 and |r--WOTLK
Lang["Q1_12892"] = "乐趣十足"
Lang["Q2_12892"] = "摧毁魔眼，然后向暗影拱顶的斯利文男爵报告。"
Lang["Q1_12887"] = "乐趣十足"
Lang["Q2_12887"] = "摧毁魔眼，然后向暗影拱顶的斯利文男爵报告。"
Lang["Q1_12891"] = "我有一计……"
Lang["Q2_12891"] = "暗影拱顶的斯利文男爵要求你去收集一根教徒的魔棒、一根憎恶的弯钩、一条恶鬼的绳子和5份天灾精华。\n\n|cff33ff99它们在暗影拱顶周围的平台上漫游。|r"
Lang["Q1_12893"] = "解放你的思想"
Lang["Q2_12893"] = "暗影拱顶的斯利文男爵希望你在劣尸维尔、奈丝伍德夫人和跳线者的尸体上使用统治魔棒。"
Lang["Q1_12897"] = "顽固的敌人"
Lang["Q2_12897"] = "击败莱斯班恩将军，然后向部落飞行战舰上的库尔迪拉·织亡者报捷。"
Lang["Q1_12896"] = "顽固的敌人"
Lang["Q2_12896"] = "击败莱斯班恩将军，然后向联盟飞行战舰上的萨萨里安报捷。"
Lang["Q1_12899"] = "暗影拱顶"
Lang["Q2_12899"] = "向暗影拱顶的斯利文男爵报到。"
Lang["Q1_12898"] = "暗影拱顶"
Lang["Q2_12898"] = "向暗影拱顶的斯利文男爵报到。"
Lang["Q1_11978"] = "深入密林"
Lang["Q2_11978"] = "龙骨荒野西风避难营的特使艾米萨·闪蹄要求你找回10套部落军备。"
Lang["Q1_11983"] = "部落的血誓"
Lang["Q2_11983"] = "与西风避难营的牛头人交谈，并收集5份他们对部落的效忠宣誓书。"
Lang["Q1_12008"] = "阿格玛之锤"
Lang["Q2_12008"] = "转至龙骨平原的阿格玛之锤，与阿格玛大王谈一谈。.\n\n|cff33ff99他位于(38.1, 46.3).|r"
Lang["Q1_12034"] = "胜利将近……"
Lang["Q2_12034"] = "与阿格玛之锤的军士长祖托克谈一谈。\n\n|cff33ff99在营地中间，在 (36.6, 46.6).|r"
Lang["Q1_12036"] = "艾卓-尼鲁布的深渊"
Lang["Q2_12036"] = "探索纳尔苏深渊，并将你的发现汇报给阿格玛之锤的军士长祖托克。\n\n|cff33ff99入口位于阿格玛之锤西侧 (26.2, 49.6). 跳入洞口完成任务。|r"
Lang["Q1_12053"] = "部落的力量"
Lang["Q2_12053"] = "阿格玛之锤的军士长祖托克要求你在冰雾村使用战歌军旗，并确保它免遭一切攻击。\n\n|cff33ff99你可以放置军旗在 (25.2, 24.8).|r"
Lang["Q1_12071"] = "空中打击！"
Lang["Q2_12071"] = "与阿格玛之锤的瓦诺克·风怒谈一谈。"
Lang["Q1_12072"] = "该死的荒芜兽！"
Lang["Q2_12072"] = "在冰雾村内使用瓦诺克的信号枪调用一只库卡隆作战双足飞龙，骑坐它杀死25只阿努巴尔荒芜兽！\n\n|cff33ff99在村庄下面靠近低处瀑布的地方有一些，在大型瀑布附近有更多。|r"
Lang["Q1_12063"] = "冰雾的力量"
Lang["Q2_12063"] = "在冰雾村内找到班索克·冰雾。\n\n|cff33ff99他位于水边 (22.7, 41.6).|r"
Lang["Q1_12064"] = "阿努巴尔的束缚"
Lang["Q2_12064"] = "冰雾村的班索克·冰雾要求你将安诺科拉的钥匙碎片、提瓦克斯的钥匙碎片和西诺克的钥匙碎片交给他。\n\n|cff33ff99它们在建筑里。 提瓦克斯 位于 (26.7, 39.0), 西诺克 位于(24.3, 44.2) 安诺科拉 位于 (24.9, 43.9).|r"
Lang["Q1_12069"] = "大酋长归来"
Lang["Q2_12069"] = "使用阿努巴尔牢笼钥匙放出冰雾部族的大酋长，并协助他击败虫王阿努布耶坎。\n\n|cff33ff99大酋长被关在一个魔法牢笼里位于 (25.3, 40.9).|r"
Lang["Q1_12140"] = "洛纳乌克万岁！"
Lang["Q2_12140"] = "在阿格玛之锤找到洛纳乌克·冰雾，并引导他加入部落，成为部落的领袖之一。"
Lang["Q1_12189"] = "笨蛋加白痴！"
Lang["Q2_12189"] = "转至龙骨荒野的怨毒镇，与首席药剂师米德尔顿谈一谈。\n\n|cff33ff99他在建筑里面, 位于 (77.7, 62.8).|r"
Lang["Q1_12188"] = "凋零药剂与你：如何自保"
Lang["Q2_12188"] = "怨毒镇的首席药剂师米德尔顿要求你给他带回10份灵质残渣。"
Lang["Q1_12200"] = "翡翠龙泪"
Lang["Q2_12200"] = "怨毒镇的首席药剂师米德尔顿要求你收集8份翡翠龙泪。\n\n|cff33ff99它们看起来像绿色宝石分布在周围地面上 (63.5, 71.9).|r"
Lang["Q1_12218"] = "传达好消息"
Lang["Q2_12218"] = "怨毒镇的首席药剂师米德尔顿要求你使用被遗忘者雕零战车上的雕零炸弹，在腐臭平原外围消灭30名饥饿的死尸。"
Lang["Q1_12221"] = "被遗忘者的凋零药剂"
Lang["Q2_12221"] = "将被遗忘者的凋零药剂交给阿格玛之锤的辛塔尔·玛菲奥斯博士。"
Lang["Q1_12224"] = "库卡隆先锋！"
Lang["Q2_12224"] = "转至库卡隆先锋营地，向小萨鲁法尔报到。\n\n|cff33ff99他位于 (40.7, 18.2).|r"
Lang["Q1_12496"] = "红龙女王的指引"
Lang["Q2_12496"] = "在龙骨荒野的龙眠神殿寻找阿莱克丝塔萨，生命的缚誓者。\n\n|cff33ff99与塔里奥斯塔兹交谈 (57.9, 54.2) 要求去塔顶。她以人形形态位于 (59.8, 54.7).|r"
Lang["Q1_12497"] = "迦拉克隆与天灾军团"
Lang["Q2_12497"] = "与龙骨荒野龙眠神殿的托拉斯塔萨谈一谈。"
Lang["Q1_12498"] = "红龙之翼"
Lang["Q2_12498"] = "消灭30个废土挖掘者并夺取安提沃克的镰刀。完成这个任务之后，回到龙眠神殿去找阿莱克丝塔萨，生命的缚誓者。\n\n|cff33ff99你可以在北面发现它们(56.8, 33.3). 别忘了镰刀 位于 (54.6, 31.4).|r"
Lang["Q1_12500"] = "返回安加萨"
Lang["Q2_12500"] = "回到库卡隆先锋营地，向小萨鲁法尔汇报你对天灾军团取得的胜利。\n\n|cff33ff99享受动画！ :-)|r"
Lang["Q1_13242"] = "黑暗的骚动"
Lang["Q2_13242"] = "在战场上收集萨鲁法尔的战甲，然后转至北风苔原的战歌要塞，将它交给萨鲁法尔大王。"
Lang["Q1_13257"] = "战争的使者"
Lang["Q2_13257"] = "转至奥格瑞玛的格罗玛什堡垒，向萨尔报到。\n\n|cff33ff99享受角色扮演 :-)|r"
Lang["Q1_13266"] = "毫无遗憾的一生"
Lang["Q2_13266"] = "穿过格罗玛什堡垒内的传送门，转至幽暗城，向沃金报到。"
Lang["Q1_13267"] = "幽暗城之战"
Lang["Q2_13267"] = "帮助萨尔和希尔瓦娜斯为部落夺回幽暗城。"
Lang["Q1_12235"] = "纳克萨玛斯与暮冬城的陷落"
Lang["Q2_12235"] = "与暮冬要塞飞行点的狮鹫指挥官乌瑞克谈一谈。"
Lang["Q1_12237"] = "拯救暮冬城平民"
Lang["Q2_12237"] = "营救10名无助的暮冬城平民，然后向暮冬城的狮鹫指挥官乌瑞克复命。"
Lang["Q1_12251"] = "向高级指挥官复命"
Lang["Q2_12251"] = "转至龙骨荒野的暮冬要塞，与高级指挥官哈尔弗·维姆班恩谈一谈。"
Lang["Q1_12253"] = "拯救暮冬城的平民"
Lang["Q2_12253"] = "暮冬要塞的高级指挥官哈尔弗·维姆班恩要求你救回6名被困的暮冬城平民。"
Lang["Q1_12309"] = "找到杜尔库！"
Lang["Q2_12309"] = "在龙骨荒野的暮冬地穴找到骑兵杜尔库。\n\n|cff33ff99他就站在地穴外面,位于 (79.0, 53.2).|r"
Lang["Q1_12311"] = "贵族的陵墓"
Lang["Q2_12311"] = "暮冬要塞的骑兵杜尔库要求你杀死通灵领主阿玛里恩。\n\n|cff33ff99一直走到地窖底部.|r"
Lang["Q1_12275"] = "破坏专家斯林奇"
Lang["Q2_12275"] = "转至龙骨荒野的暮冬要塞，与攻城技师夸特弗拉什谈一谈。\n\n|cff33ff99他在狮鹫管理员附近, 位于(77.8, 50.3).|r"
Lang["Q1_12276"] = "寻找斯林奇"
Lang["Q2_12276"] = "转至暮冬矿洞寻找破坏专家斯林奇。你可以使用夸特弗拉什的导航机器人来帮忙寻找矿洞。\n\n|cff33ff99机器人速度很快，如果你需要跟随它，可以上车。\n从底部入口进入矿井，然后向右寻找尸体位于 (81.5, 42.2).|r"
Lang["Q1_12277"] = "阻绝邪恶"
Lang["Q2_12277"] = "找到暮冬矿洞炸弹，并用它把暮冬矿洞的上层入口和暮冬矿洞的下层入口炸掉。完成任务后，转至龙骨荒野的暮冬要塞，向攻城技师夸特弗拉什复命。\n\n|cff33ff99炸药位于 (80.7, 41.3).|r"
Lang["Q1_12325"] = "进入敌占区"
Lang["Q2_12325"] = "与狮鹫指挥官乌瑞克交谈，搭乘狮鹫飞往索尔森的岗哨。抵达目的地之后，向奥古斯特公爵报到。\n\n|cff33ff99不要和狮鹫管理员说话，而是跳上狮鹫载具。|r"
Lang["Q1_12312"] = "天灾的秘密"
Lang["Q2_12312"] = "将血之魔典交给龙骨荒野暮冬要塞的骑兵杜尔库。"
Lang["Q1_12319"] = "血之魔典"
Lang["Q2_12319"] = "将血之魔典交给龙骨荒野暮冬要塞的高级指挥官哈尔弗·维姆班恩。"
Lang["Q1_12320"] = "破译魔典"
Lang["Q2_12320"] = "将血之魔典交给龙骨荒野暮冬要塞监狱内的审讯员哈尔拉德。\n\n|cff33ff99沿门口的路一直走到兵营。进入兵营以后直接从楼梯下楼。哈尔拉德位于 (76.7, 47.4).|r"
Lang["Q1_12321"] = "正义的审判"
Lang["Q2_12321"] = "等待审讯员哈尔拉德完成他的正义审讯，然后带着你获得的情报回到暮冬要塞的高级指挥官哈尔弗·维姆班恩那里复命。"
Lang["Q1_12272"] = "流血的矿石"
Lang["Q2_12272"] = "龙骨荒野暮冬要塞的攻城技师夸特弗拉什要你转至暮冬矿洞，取回10份奇怪的矿石的样品。"
Lang["Q1_12281"] = "天灾战争机器的奥秘"
Lang["Q2_12281"] = "把夸特弗拉什的包裹交给暮冬要塞的高级指挥官哈尔弗·维姆班恩。"
Lang["Q1_12326"] = "蒸汽坦克行动"
Lang["Q2_12326"] = "使用联盟蒸汽坦克摧毁6台天灾战车，并将第七军团精英送入暮冬陵园。成功之后与暮冬陵园里的阿姆博·卡什谈一谈。\n\n|cff33ff99暮冬陵园位于 (85.9, 50.8), 阿姆博·卡什在里面等着。|r"
Lang["Q1_12455"] = "随风散落"
Lang["Q2_12455"] = "龙骨荒野暮冬陵园的阿姆博·卡什要你取回8箱暮冬军需品。\n\n|cff33ff99它们在陵墓外面，分散在田野周围。|r"
Lang["Q1_12457"] = "重机枪与你"
Lang["Q2_12457"] = "龙骨荒野暮冬陵园的阿姆博·卡什要你营救8名受伤的第七军团士兵。\n\n|cff33ff99士兵总是在房间后面刷新，所以一定要用枪把它清除掉。|r"
Lang["Q1_12463"] = "找到普兰比尔德！"
Lang["Q2_12463"] = "龙骨荒野暮冬陵园的阿姆博·卡什要你寻找普兰比尔德的下落。\n\n|cff33ff99他在房间的尽头，在一个角落里 (84.2, 54.7).|r"
Lang["Q1_12465"] = "普兰比尔德的日记"
Lang["Q2_12465"] = "将普兰比尔德的日记的第4页、第5页、第6页和第7页交给龙骨荒野暮冬陵园的阿姆博·卡什。\n\n|cff33ff99沿着从普兰比尔德开始的隧道寻找合适的怪物|r"
Lang["Q1_12466"] = "追击冰雪风暴：第七军团前线"
Lang["Q2_12466"] = "转至龙骨荒野中部的第七军团前线，向军团司令泰拉里安报到。\n\n|cff33ff99军团前线位于 (64.7, 27.9)|r"
Lang["Q1_12467"] = "追击冰雪风暴：塞尔赞的护命匣"
Lang["Q2_12467"] = "从冰雪风暴手中夺得塞尔赞的护命匣，将它交给暮冬要塞的高级指挥官哈尔弗·维姆班恩。"
Lang["Q1_12472"] = "终结"
Lang["Q2_12472"] = "带着塞尔赞的护命匣转至龙骨荒野的暮冬陵园，向军团司令尤瑞克报到。\n\n|cff33ff99隧道入口就在要塞外面, 位于(82.0, 50.7).|r"
Lang["Q1_12473"] = "结束和开始"
Lang["Q2_12473"] = "击败塞尔赞，然后转至龙骨荒野的暮冬要塞，向高级指挥官哈尔弗·维姆班恩报告。\n\n|cff33ff99如果你死了，不要释放；NPC可能会帮你完成任务。|r"
Lang["Q1_12474"] = "转至弗塔根要塞！"
Lang["Q2_12474"] = "转至龙骨荒野的弗塔根要塞，与伯瓦尔·弗塔根公爵谈一谈。\n\n|cff33ff99他位于 (37.8, 23.4).|r"
Lang["Q1_12495"] = "红龙女王的指引"
Lang["Q2_12495"] = "在龙骨荒野的龙眠神殿寻找阿莱克丝塔萨，生命的缚誓者。\n\n|cff33ff99与塔里奥斯塔兹交谈 (57.9, 54.2) 要求去塔顶。她以人形形态位于 (59.8, 54.7).|r"
Lang["Q1_12499"] = "返回安加萨"
Lang["Q2_12499"] = "回到弗塔根要塞，向伯瓦尔·弗塔根公爵汇报你对天灾军团取得的胜利。"
Lang["Q1_13347"] = "浴火重生"
Lang["Q2_13347"] = "从天灾之门安加萨的战场上取回弗塔根之盾，把它交给暴风城要塞中的瓦里安·乌瑞恩国王。"
Lang["Q1_13369"] = "造化弄人"
Lang["Q2_13369"] = "陪同吉安娜·普罗德摩尔转至卡利姆多大陆的奥格瑞玛，与部落的萨尔酋长交谈。"
Lang["Q1_13370"] = "政变"
Lang["Q2_13370"] = "使用格罗玛什堡垒中的传送门返回暴风要塞，把萨尔的消息转达给瓦里安·乌瑞恩国王。"
Lang["Q1_13371"] = "杀戮时刻"
Lang["Q2_13371"] = "使用暴风要塞内的通往幽暗城的传送门转至幽暗城。到达目的地之后，向布罗尔·熊皮报到。"
Lang["Q1_13377"] = "幽暗城之战"
Lang["Q2_13377"] = "协助瓦里安·乌瑞恩国王和吉安娜·普罗德摩尔，剿灭大药剂师普特雷斯！成功之后，向瓦里安·乌瑞恩国王报告。"
--WOTLK Sons of Hodir
Lang["Q1_12843"] = "她们把男人都抓走了！"
Lang["Q2_12843"] = "格莱奇·菲兹巴克要你转至希弗列尔达村，救出5名地精囚犯。\n\n|cff33ff99希弗列尔达村位于 (41.4, 70.6), 杀死维库人，以获得散落在村庄里的囚犯笼子的钥匙。|r"
Lang["Q1_12846"] = "一个地精也不能少"
Lang["Q2_12846"] = "转至希弗列尔达村的北部，找到荒弃矿洞的入口，并寻找西弗·菲兹巴克的下落。\n\n|cff33ff99矿井的入口在村庄里位于 (42.1, 69.5), 不在下面，如果你看到蜘蛛，你就错了:-).|r"
Lang["Q1_12841"] = "女巫的交易"
Lang["Q2_12841"] = "荒弃矿洞的女巫洛莉拉要求你从监督者希尔拉手中夺回伊克芬符文。\n\n|cff33ff99希尔拉在矿井的侧廊巡逻.|r"
Lang["Q1_12905"] = "残酷的米尔德蕾"
Lang["Q2_12905"] = "在荒弃矿洞内与残酷的米尔德蕾谈一谈。\n\n|cff33ff99米尔德蕾在平台上，你在矿井里走得更远。|r"
Lang["Q1_12906"] = "训诫"
Lang["Q2_12906"] = "荒弃矿洞中的残酷的米尔德蕾要求你使用训诫之杖威吓6个筋疲力尽的维库人。"
Lang["Q1_12907"] = "杀一儆百"
Lang["Q2_12907"] = "荒弃矿洞内的残酷的米尔德蕾命令你去处死加哈尔。\n\n|cff33ff99加哈尔和另外几个人在矿井的另一头，位于（45.4, 69.1）。卫兵会帮助你.|r"
Lang["Q1_12908"] = "特殊的囚犯"
Lang["Q2_12908"] = "把米尔德蕾的钥匙交给荒弃矿洞的女巫洛莉拉。"
Lang["Q1_12921"] = "改头换面"
Lang["Q2_12921"] = "到布伦希尔达村与女巫洛莉拉汇合。"
Lang["Q1_12969"] = "这是你的地精吗？"
Lang["Q2_12969"] = "向安格妮塔·泰斯多达尔发起挑战，救出西弗·菲兹巴克。成功之后，向布伦希尔达村的女巫洛莉拉复命。"
Lang["Q1_12970"] = "海德比武会"
Lang["Q2_12970"] = "听取女巫洛莉拉的提议。\n\n|cff33ff99只需交谈并点击各种消息即可。|r"
Lang["Q1_12971"] = "迎接挑战者"
Lang["Q2_12971"] = "布伦希尔达村的女巫洛莉拉要你去打败6名获胜的挑战者。\n\n|cff33ff99只需与未参与战斗的各种挑战者交谈.|r"
Lang["Q1_12972"] = "你需要一头熊"
Lang["Q2_12972"] = "与布伦希尔达村外的布莉亚娜谈一谈。\n\n|cff33ff99布莉亚娜位于 (53.1, 65.7).|r"
Lang["Q1_12851"] = "骑熊作战"
Lang["Q2_12851"] = "布伦希尔达村的布莉亚娜要求你骑着冰牙转至上古寒冬山谷，在那里射击7头冰霜座狼和15个冰霜巨人。"
Lang["Q1_12856"] = "冰冷的心"
Lang["Q2_12856"] = "布伦希尔达村东边的布莉亚娜要你飞往丹尼芬雷，解救3头被俘虏的始祖幼龙，然后解救9名布伦希尔达囚犯。\n\n|cff33ff99飞往 (64.3, 61.5)  跳上一只被束缚的始祖龙。然后，你可以向维库女“射击”击落她们。做3次，然后返回。这样做三次就可以解救9名囚犯.|r"
Lang["Q1_13063"] = "证明价值"
Lang["Q2_13063"] = "布莉亚娜希望你转至布伦希尔达村，与艾丝崔·约利塔尔谈一谈。\n\n|cff33ff99艾丝崔在一所房子里位于(49.7, 71.8).|r"
Lang["Q1_12900"] = "制造挽具"
Lang["Q2_12900"] = "布伦希尔达村的艾丝崔·约利塔尔希望你交给她3张冰鬃雪人的毛皮。"
Lang["Q1_12983"] = "最后的母熊"
Lang["Q2_12983"] = "布伦希尔达村的艾丝崔·约利塔尔要你去冬眠洞穴解救一头冰喉母熊。\n\n|cff33ff99洞穴的入口位于 (55.9, 64.3). 沿着右边的路走，你会很容易找到冰喉母熊。|r"
Lang["Q1_12996"] = "热身赛"
Lang["Q2_12996"] = "布伦希尔达村的艾丝崔·约利塔尔要你使用冰喉母熊的缰绳打败基加拉格。\n\n|cff33ff99冷却时裂伤（4），当冲锋准备好时，击退（5），然后冲锋（6）。如果熊死了，你可以自己完成击杀，它仍然会算数。|r"
Lang["Q1_12997"] = "进入利齿之坑"
Lang["Q2_12997"] = "布伦希尔达村的艾丝崔·约利塔尔要你在利齿之坑里使用冰喉母熊的缰绳，并打败6头海德比武会战熊。"
Lang["Q1_13061"] = "为荣耀而战"
Lang["Q2_13061"] = "与布伦希尔达村的女巫洛莉拉谈一谈。"
Lang["Q1_13062"] = "洛莉拉的离别赠礼"
Lang["Q2_13062"] = "与布伦希尔达村的仲裁者格蕾塔谈一谈。"
Lang["Q1_12886"] = "驭龙赛"
Lang["Q2_12886"] = "使用海德尼尔鱼叉，在风暴神殿击败10名海德比武会龙骑士。获胜后对装饰石柱使用海德尼尔鱼叉以完成驭龙赛，然后与托里姆谈一谈。\n\n|cff33ff99用鱼叉跳到其他龙兽身上，杀死它们的骑手。10次后，用鱼叉在一个挂在柱子上的小灯上，这会把你带到平台上。|r"
Lang["Q1_13064"] = "骨肉相残"
Lang["Q2_13064"] = "托里姆希望你能倾听他的故事。"
Lang["Q1_12915"] = "弥补关系"
Lang["Q2_12915"] = "风暴神殿的托里姆要你转至丹尼芬雷东边的弗约恩之砧，杀死弗约恩和5名雷铸铁巨人。\n\n|cff33ff99飞到丹尼芬雷以东的铁砧 (76.9, 63.2), 从地板上捡起一块花岗岩石块。对目标使用托里姆的大地符咒，召唤土灵斩铁者。\n注意，每个目标都需要一个新的（唯一的）花岗岩石块（总计需要最少6个）。|r"
Lang["Q1_12922"] = "精炼之火"
Lang["Q2_12922"] = "从霜原湖的火热的亡魂身上收集10份狂怒火花，然后转至弗约恩之砧，使用那里的铁砧。"
Lang["Q1_12956"] = "希望的火花"
Lang["Q2_12956"] = "将精炼闪光矿石交给风暴神殿的托里姆。"
Lang["Q1_12924"] = "重铸盟约"
Lang["Q2_12924"] = "转至丹尼芬雷，请求约库姆国王帮忙重铸托里姆的护甲。完成约库姆交付的任务之后，与丹尼芬雷的亚米尔德谈一谈。\n\n|cff33ff99约库姆国王位于丹尼芬雷的中心 (65.4, 60.1).\n\n但你最终还是把这个任务交给了亚米尔德(63.2, 63.3).|r"
Lang["Q1_13009"] = "新的开始"
Lang["Q2_13009"] = "亚米尔德要求你将重铸的风暴之王铠甲交给风暴神殿的托里姆。"
Lang["Q1_13050"] = "维拉努斯"
Lang["Q2_13050"] = "风暴神殿的托里姆要你从布伦希尔达村附近的峭壁上取回5枚规模始祖龙卵。\n\n|cff33ff99布伦希尔达村周围有各种巢穴例如 (52.5, 73.4).|r"
Lang["Q1_13051"] = "侵犯领土"
Lang["Q2_13051"] = "将偷来的始祖龙卵放置在母龙之巢的顶部，然后返回风暴神殿向托里姆复命。\n\n|cff33ff99正确的巢穴位于 (38.7, 65.5). 放下龙卵，等待托里姆出现在母龙之巢。|r"
Lang["Q1_13010"] = "科洛米尔，风暴之锤"
Lang["Q2_13010"] = "托里姆要你与丹尼芬雷的约库姆国王谈一谈，向他打听科洛米尔的消息。\n\n|cff33ff99你可能差一点声望让国王回答你的问题。完成两个日常任务中的一个，声望达到友善。|r"
Lang["Q1_12966"] = "你不会找不到他"
Lang["Q2_12966"] = "丹尼芬雷的约库姆国王要你转至弗约恩之砧，找到找亚米尔德。"
Lang["Q1_12967"] = "元素之战"
Lang["Q2_12967"] = "亚米尔德要求你陪伴斯诺雷转至弗约恩之砧，并帮助他杀死10个火热的亡魂。"
Lang["Q1_12975"] = "回首往事"
Lang["Q2_12975"] = "丹尼芬雷的约库姆国王要求你前往落雷谷，收集8块号角碎片。\n\n|cff33ff99它们看起来像雪中的灰色小碎片位于 (71.6, 48.9).|r"
Lang["Q1_12976"] = "亡者的纪念碑"
Lang["Q2_12976"] = "约库姆国王要求你将号角碎片交给丹尼芬雷的亚米尔德。"
Lang["Q1_13011"] = "肥胖的尤姆塔尔"
Lang["Q2_13011"] = "丹尼芬雷的约库姆国王要求你转至冬眠洞穴，杀死尤姆塔尔。\n\n|cff33ff99进入洞穴，靠右走。你可以从 (54.8, 61.0)召唤尤姆塔尔. 可能需要几次尝试才能得到熊肉。|r"
Lang["Q1_13372"] = "聚焦之虹的钥匙"
Lang["Q2_13372"] = "转至龙骨荒野的龙眠神殿，将聚焦之虹的钥匙交给阿莱克丝塔萨，生命的缚誓者。"
Lang["Q1_13375"] = "英雄聚焦之虹的钥匙"
Lang["Q2_13375"] = "转至龙骨荒野的龙眠神殿，将英雄聚焦之虹的钥匙交给阿莱克丝塔萨，生命的缚誓者。"

--  \n\n|cff33ff99 |r
Lang["Q1_"] = ""
Lang["Q2_"] = ""




-- NPC
Lang["N1_9196"] = "欧莫克大王"	-- https://cn.tbc.wowhead.com/?npc=9196
Lang["N2_9196"] = "欧莫克大王能在以下地区找到：​黑石塔下层."
Lang["N1_9237"] = "指挥官沃恩"	-- https://cn.tbc.wowhead.com/?npc=9237
Lang["N2_9237"] = "指挥官沃恩能在以下地区找到：​黑石塔下层."
Lang["N1_9568"] = "维姆萨拉克"	-- https://cn.tbc.wowhead.com/?npc=9568
Lang["N2_9568"] = "维姆萨拉克能在以下地区找到：​黑石塔下层."
Lang["N1_10429"] = "大酋长雷德·黑手"	-- https://cn.tbc.wowhead.com/?npc=10429
Lang["N2_10429"] = "大酋长雷德·黑手能在以下地区找到：​黑石塔上层."
Lang["N1_10182"] = "雷克萨<部落的勇士>"	-- https://cn.tbc.wowhead.com/?npc=10182
Lang["N2_10182"] = "雷克萨能在以下地区找到：​ 凄凉之地、菲拉斯、石爪山脉."
Lang["N1_8197"] = "克鲁纳里斯"	-- https://cn.tbc.wowhead.com/?npc=8197
Lang["N2_8197"] = "克鲁纳里斯能在塔纳利斯的时光之穴门外找到."
Lang["N1_10664"] = "斯克利尔"	-- https://cn.tbc.wowhead.com/?npc=10664
Lang["N2_10664"] = "斯克利尔能在冬泉谷的蓝龙洞深处找到."
Lang["N1_12900"] = "索姆努斯"	-- https://cn.tbc.wowhead.com/?npc=12900
Lang["N2_12900"] = "索姆努斯能在悲伤沼泽的沉没的神庙东侧找到."
Lang["N1_12899"] = "埃克托兹"	-- https://cn.tbc.wowhead.com/?npc=12899
Lang["N2_12899"] = "埃克托兹能在湿地的格瑞姆巴托找到."
Lang["N1_10363"] = "达基萨斯将军"	-- https://cn.tbc.wowhead.com/?npc=10363
Lang["N2_10363"] = "达基萨斯将军是黑石塔上层的最终首领."
Lang["N1_8983"] = "傀儡统帅阿格曼奇"	-- https://cn.tbc.wowhead.com/?npc=8983
Lang["N2_8983"] = "傀儡统帅阿格曼奇能在以下地区找到：​黑石深渊."
Lang["N1_9033"] = "安格弗将军"	-- https://cn.tbc.wowhead.com/?npc=9033
Lang["N2_9033"] = "安格弗将军能在以下地区找到：​黑石深渊."
Lang["N1_17804"] = "侍卫洛文"	-- https://cn.tbc.wowhead.com/?npc=17804
Lang["N2_17804"] = "侍卫洛文能在暴风城大门找到."
Lang["N1_10929"] = "哈尔琳"	-- https://cn.tbc.wowhead.com/?npc=10929
Lang["N2_10929"] = "站在外面的Mazthoril洞穴顶部。\n可以通过洞穴深处地板上的蓝色符文到达。"
Lang["N1_9046"] = "裂盾军需官 <裂盾军团>"	-- https://cn.tbc.wowhead.com/?npc=9046
Lang["N2_9046"] = "位于副本外部，在黑石塔楼阳台入口附近."
Lang["N1_15180"] = "流沙守望者巴里斯托尔斯"	-- https://cn.tbc.wowhead.com/?npc=15180
Lang["N2_15180"] = "流沙守望者巴里斯托尔斯位于希利苏斯 (49.6,36.6)."
Lang["N1_12017"] = "勒什雷尔"	-- https://cn.tbc.wowhead.com/?npc=12017
Lang["N2_12017"] = "勒什雷尔是黑翼之巢的三号首领."
Lang["N1_13020"] = "堕落的瓦拉斯塔兹"	-- https://cn.tbc.wowhead.com/?npc=13020
Lang["N2_13020"] = "堕落的瓦拉斯塔兹是黑翼之巢的二号首领."
Lang["N1_11583"] = "奈法利安"	-- https://cn.tbc.wowhead.com/?npc=11583
Lang["N2_11583"] = "奈法利安是黑翼之巢的最终首领."
Lang["N1_15362"] = "玛法里奥·怒风"	-- https://cn.tbc.wowhead.com/?npc=15362
Lang["N2_15362"] = "玛法里奥·怒风位于沉没的神庙最终首领附近"
Lang["N1_15624"] = "森林小精灵"	-- https://cn.tbc.wowhead.com/?npc=15624
Lang["N2_15624"] = "森林小精灵位于达纳苏斯(37.6,48.0)."
Lang["N1_15481"] = "艾索雷葛斯之魂"	-- https://cn.tbc.wowhead.com/?npc=15481
Lang["N2_15481"] = "艾索雷葛斯之魂位于艾萨拉 (58.8,82.2). "
Lang["N1_11811"] = "纳瑞安"	-- https://cn.tbc.wowhead.com/?npc=11811
Lang["N2_11811"] = "纳瑞安位于塔纳利斯 (65.2,18.4)."
Lang["N1_15526"] = "人鱼米莉蒂丝"	-- https://cn.tbc.wowhead.com/?npc=15526
Lang["N2_15526"] = "人鱼米莉蒂丝位于塔纳利斯 (59.6,95.6)."
Lang["N1_15554"] = "人造猿二号"	-- https://cn.tbc.wowhead.com/?npc=15554
Lang["N2_15554"] = "人造猿二号位于冬泉谷 (67.2,72.6). "
Lang["N1_15552"] = "维维尔博士"	-- https://cn.tbc.wowhead.com/?npc=15552
Lang["N2_15552"] = "维维尔博士位于尘泥沼泽(77.8,17.6). "
Lang["N1_10184"] = "奥妮克希亚"	-- https://cn.tbc.wowhead.com/?npc=10184
Lang["N2_10184"] = "奥妮克希亚位于奥妮克希亚的巢穴"
Lang["N1_11502"] = "拉格纳罗斯"	-- https://cn.tbc.wowhead.com/?npc=11502
Lang["N2_11502"] = "拉格纳罗斯是熔火之心的最终首领."
Lang["N1_12803"] = "拉克麦拉"	-- https://cn.tbc.wowhead.com/?npc=12803
Lang["N2_12803"] = "拉克麦拉位于菲拉斯 (29.8,72.6)."
Lang["N1_15571"] = "巨齿鲨"	-- https://cn.tbc.wowhead.com/?npc=15571
Lang["N2_15571"] = "巨齿鲨位于艾萨拉 (65.6,54.6)"
Lang["N1_22037"] = "铁匠戈伦克"	-- https://cn.tbc.wowhead.com/?npc=22037
Lang["N2_22037"] = "铁匠戈伦克位于影月谷 (67,36)."
Lang["N1_18733"] = "魔能机甲"	-- https://cn.tbc.wowhead.com/?npc=18733
Lang["N2_18733"] = "倾向于漫游地狱火城堡的西侧."
Lang["N1_18473"] = "利爪之王艾吉斯"	-- https://cn.tbc.wowhead.com/?npc=18473
Lang["N2_18473"] = "利爪之王艾吉斯是塞泰克大厅的最终首领"
Lang["N1_20142"] = "时间管理者 <时光守护者>"	-- https://cn.tbc.wowhead.com/?npc=20142
Lang["N2_20142"] = "时间管理者 <时光守护者>位于时光之穴的入口"
Lang["N1_20130"] = "安多尔姆 <时光守护者>"	-- https://cn.tbc.wowhead.com/?npc=20130
Lang["N2_20130"] = "看起来像一个小男孩，靠近时间之穴的沙漏."
Lang["N1_18096"] = "时空猎手"	-- https://cn.tbc.wowhead.com/?npc=18096
Lang["N2_18096"] = "时空猎手是旧希尔斯布莱德丘陵的最终首领."
Lang["N1_19880"] = "虚空猎手卡尔伊"	-- https://cn.tbc.wowhead.com/?npc=19880
Lang["N2_19880"] = "虚空猎手卡尔伊位于虚空风暴52区 (32,64)"
Lang["N1_19641"] = "星界强盗奈萨德"	-- https://cn.tbc.wowhead.com/?npc=19641
Lang["N2_19641"] = "星界强盗奈萨德位于虚空风暴(28,79). "
Lang["N1_18481"] = "阿达尔"	-- https://cn.tbc.wowhead.com/?npc=18481
Lang["N2_18481"] = "阿达尔位于沙塔斯城的中央"
Lang["N1_19220"] = "计算者帕萨雷恩"	-- https://cn.tbc.wowhead.com/?npc=19220
Lang["N2_19220"] = "计算者帕萨雷恩是能源舰的最终首领."
Lang["N1_17977"] = "迁跃扭木"	-- https://cn.tbc.wowhead.com/?npc=17977
Lang["N2_17977"] = "迁跃扭木是生态船的最终首领."
Lang["N1_17613"] = "大法师奥图鲁斯"	-- https://cn.tbc.wowhead.com/?npc=17613
Lang["N2_17613"] = "大法师奥图鲁斯站在卡拉赞的入口."
Lang["N1_18708"] = "摩摩尔"	-- https://cn.tbc.wowhead.com/?npc=18708
Lang["N2_18708"] = "摩摩尔是暗影迷宫的最终首领."
Lang["N1_17797"] = "水术师瑟丝比娅"	-- https://cn.tbc.wowhead.com/?npc=17797
Lang["N2_17797"] = "水术师瑟丝比娅是蒸汽地窟的一号首领."
Lang["N1_20870"] = "自由的瑟雷凯斯"	-- https://cn.tbc.wowhead.com/?npc=20870
Lang["N2_20870"] = "自由的瑟雷凯斯是禁魔监狱的一号首领."
Lang["N1_15608"] = "麦迪文"	-- https://cn.tbc.wowhead.com/?npc=15608
Lang["N2_15608"] = "麦迪文在黑色沼泽南部的黑暗之门附近。"
Lang["N1_16524"] = "埃兰之影"	-- https://cn.tbc.wowhead.com/?npc=16524
Lang["N2_16524"] = "麦迪文的疯狂父亲，在卡拉赞"
Lang["N1_16807"] = "高阶术士奈瑟库斯"	-- https://cn.tbc.wowhead.com/?npc=16807
Lang["N2_16807"] = "高阶术士奈瑟库斯是破碎大厅的一号首领."
Lang["N1_18472"] = "黑暗编织者塞斯"	-- https://cn.tbc.wowhead.com/?npc=18472
Lang["N2_18472"] = "黑暗编织者塞斯是赛泰克大厅的一号首领."
Lang["N1_22421"] = "异教徒斯卡希斯"	-- https://cn.tbc.wowhead.com/?npc=22421
Lang["N2_22421"] = "异教徒斯卡希斯在英雄难度奴隶围栏."
Lang["N1_19044"] = "屠龙者格鲁尔"	-- https://cn.tbc.wowhead.com/?npc=19044
Lang["N2_19044"] = "屠龙者格鲁尔是格鲁尔的巢穴的最终首领."
Lang["N1_17225"] = "夜之魇"	-- https://cn.tbc.wowhead.com/?npc=17225
Lang["N2_17225"] = "夜魔是卡拉赞的召唤首领。."
Lang["N1_21938"] = "大地治愈者斯普林·裂蹄 <大地之环>"	-- https://cn.tbc.wowhead.com/?npc=21938
Lang["N2_21938"] = "大地治愈者斯普林·裂蹄 <大地之环>位于影月谷 (28.6,26.6)."
Lang["N1_21183"] = "欧鲁诺克·裂心 <隐士商人>"	-- https://cn.tbc.wowhead.com/?npc=21183
Lang["N2_21183"] = "欧鲁诺克·裂心 <隐士商人>位于影月谷 (53.8,23.4)."
Lang["N1_21291"] = "格洛姆托，欧鲁诺克之子"	-- https://cn.tbc.wowhead.com/?npc=21291
Lang["N2_21291"] = "格洛姆托，欧鲁诺克之子位于影月谷 (44.6,23.6)."
Lang["N1_21292"] = "阿托尔，欧鲁诺克之子"	-- https://cn.tbc.wowhead.com/?npc=21292
Lang["N2_21292"] = "阿托尔，欧鲁诺克之子位于影月谷 (29.6,50.4)."
Lang["N1_21293"] = "伯拉克，欧鲁诺克之子"	-- https://cn.tbc.wowhead.com/?npc=21293
Lang["N2_21293"] = "伯拉克，欧鲁诺克之子位于影月谷 (47.6,57.2)."
Lang["N1_18166"] = "卡德加 <洛萨之子>"	-- https://cn.tbc.wowhead.com/?npc=18166
Lang["N2_18166"] = "他站在沙塔斯城的中心，就在黄色发光的阿达尔旁边。"
Lang["N1_16808"] = "酋长卡加斯·刃拳"	-- https://cn.tbc.wowhead.com/?npc=16808
Lang["N2_16808"] = "酋长卡加斯·刃拳是破碎大厅的最终首领."
Lang["N1_17798"] = "督军卡利瑟里斯"	-- https://cn.tbc.wowhead.com/?npc=17798
Lang["N2_17798"] = "督军卡利瑟里斯是蒸汽地窟的最终首领."
Lang["N1_20912"] = "预言者斯克瑞斯"	-- https://cn.tbc.wowhead.com/?npc=20912
Lang["N2_20912"] = "预言者斯克瑞斯是禁魔监狱的最终首领."
Lang["N1_20977"] = "米尔豪斯·法力风暴"	-- https://cn.tbc.wowhead.com/?npc=20977
Lang["N2_20977"] = "米尔豪斯·法力风暴是在禁魔监狱中发现的侏儒法师。 他将协助攻击从监狱释放的其他生物."
Lang["N1_17257"] = "玛瑟里顿"	-- https://cn.tbc.wowhead.com/?npc=17257
Lang["N2_17257"] = "玛瑟瑟顿在地狱火堡垒的下层被关押，团队副本被称为玛瑟瑟顿的巢穴."
Lang["N1_21937"] = "大地治愈者索弗鲁斯 <大地之环>"	-- https://cn.tbc.wowhead.com/?npc=21937
Lang["N2_21937"] = "大地治愈者索弗鲁斯 <大地之环>位于影月谷 (36.4,56.8)."
Lang["N1_19935"] = "索莉多米 <流沙之鳞>"	-- https://cn.tbc.wowhead.com/?npc=19935
Lang["N2_19935"] = "索里多米徘徊在时光之穴的大沙漏周围."
Lang["N1_19622"] = "凯尔萨斯·逐日者 <血精灵之王>"	-- https://cn.tbc.wowhead.com/?npc=19622
Lang["N2_19622"] = "凯尔萨斯·逐日者 <血精灵之王>是风暴要塞的最终首领."
Lang["N1_21212"] = "瓦丝琪 <盘牙女王>"	-- https://cn.tbc.wowhead.com/?npc=21212
Lang["N2_21212"] = "瓦丝琪 <盘牙女王>是毒蛇神殿的最终首领."
Lang["N1_21402"] = "学者希拉"	-- https://cn.tbc.wowhead.com/?npc=21402
Lang["N2_21402"] = "学者希拉位于影月谷 (62.6,28.4)."
Lang["N1_21955"] = "奥术师塞里斯"	-- https://cn.tbc.wowhead.com/?npc=21955
Lang["N2_21955"] = "奥术师塞里斯位于影月谷 (56.2,59.6)"
Lang["N1_21962"] = "乌达鲁"	-- https://cn.tbc.wowhead.com/?npc=21962
Lang["N2_21962"] = "乌达鲁在禁魔监狱的最终首领战斗之前，他躺在小坡道上死了."
Lang["N1_22006"] = "暗影领主达斯维尔"	-- https://cn.tbc.wowhead.com/?npc=22006
Lang["N2_22006"] = "暗影领主达斯维尔在黑暗神殿的北塔上骑龙 (71.6,35.6) "
Lang["N1_22820"] = "先知奥鲁姆"	-- https://cn.tbc.wowhead.com/?npc=22820
Lang["N2_22820"] = "先知奥鲁姆位于毒蛇神殿深水领主卡拉瑟雷斯附近."
Lang["N1_21700"] = "阿卡玛"	-- https://cn.tbc.wowhead.com/?npc=21700
Lang["N2_21700"] = "阿卡玛位于影月谷 (58.0,48.2)."
Lang["N1_19514"] = "奥 <凤凰之神>"	-- https://cn.tbc.wowhead.com/?npc=19514
Lang["N2_19514"] = "奥 <凤凰之神>是风暴要塞的一号首领"
Lang["N1_17767"] = "雷基·冬寒"	-- https://cn.tbc.wowhead.com/?npc=17767
Lang["N2_17767"] = "雷基·冬寒是海加尔山的一号首领."
Lang["N1_18528"] = "克希利"	-- https://cn.tbc.wowhead.com/?npc=18528
Lang["N2_18528"] = "克希利位于黑暗神殿的门外."
--v243
Lang["N1_22497"] = "弗埃卢"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22497
Lang["N2_22497"] = "弗埃盧和阿達爾在同一個房間，但他是藍色的。 他在頂層著陸。"
--v244
Lang["N1_22113"] = "莫德奈"
Lang["N2_22113"] = "一个血精灵（剧透警报，实际上是一条龙）走在星辰圣殿东边的虚空之翼领域"
--v247
Lang["N1_8888"]  = "弗兰克罗恩·铸铁"
Lang["N2_8888"]  = "一个幽灵矮人，站在地牢外他自己的坟墓上，在悬浮在熔岩上方的结构中。 只有死了才能与他互动。"
Lang["N1_9056"]  = "弗诺斯·达克维尔"
Lang["N2_9056"]  = "他在地牢内，在伊森迪乌斯勋爵的房间外的采石场巡逻。"
Lang["N1_10837"] = "高级执行官德灵顿"
Lang["N2_10837"] = "他可以在壁垒中找到，靠近提瑞斯法和西瘟疫之地的边界"
Lang["N1_10838"] = "指挥官阿什拉姆·瓦罗菲斯特"
Lang["N2_10838"] = "他可以在西瘟疫之地安多哈尔以南的寒风营地找到"
Lang["N1_1852"]  = "召唤者阿拉基"
Lang["N2_1852"]  = "巫妖，在安多哈尔的中央"
--v250
Lang["N1_13278"]  = "海达克西斯公爵"
Lang["N2_13278"]  = "艾萨拉一个遥远的小岛上的大型水元素 (79.2,73.6)"
Lang["N1_12264"]  = "沙斯拉尔"
Lang["N2_12264"]  = "沙斯拉尔 是熔火之心的第五个boss。"
Lang["N1_12118"]  = "鲁西弗隆"
Lang["N2_12118"]  = "鲁西弗隆 是熔火之心的第一个boss。"
Lang["N1_12259"]  = "基赫纳斯"
Lang["N2_12259"]  = "基赫纳斯 是熔火之心的第三个boss。"
Lang["N1_12098"]  = "萨弗隆先驱者"
Lang["N2_12098"]  = "萨弗隆先驱者 是熔火之心的第八个boss。"




--WOTLK NPCs
--WOTLK QUESTS
-- The ids are N1_<NPCId> and N2_<NPCId>
-- N1 is just the name of the NPC
-- N2 is a helpful description
Lang["N1_29795"]  = "库尔迪拉·织亡者"
Lang["N2_29795"]  = "不要在地面上寻找他。他在奥格瑞姆之锤上，在伊米海姆和辛达苟萨之墓之间的平原上空飞行。"
Lang["N1_29799"]  = "萨萨里安"
Lang["N2_29799"]  = "不要在地面上寻找他。他在破天号上, 在伊米海姆和辛达苟萨之墓之间的平原上空飞行。"
Lang["N1_29804"]  = "斯利文男爵"
Lang["N2_29804"]  = "他站在外面，塔的南边，靠近地面入口(44, 24.6).\n\n一旦任务链结束，他就会移动到 (42.8, 25.1)."
Lang["N1_29747"]  = "魔眼"
Lang["N2_29747"]  = "一只蓝色大眼睛，在阴影穹顶的最顶端 (44.6, 21.6).\n\n只需使用魔眼冲击炮将其击打10次即可。"
Lang["N1_29769"]  = "劣尸维尔"
Lang["N2_29769"]  = "站在中间平台上，距离斯利文男爵稍南(44.4, 26.9)."
Lang["N1_29770"]  = "奈丝伍德夫人"
Lang["N2_29770"]  = "站在斯利文男爵西边的小平台上 (41.9, 24.5)."
Lang["N1_29840"]  = "跳跃者"
Lang["N2_29840"]  = "在斯利文男爵上方的顶部平台周围跳跃 (45.0, 23.8).\n可能很难发现，使用目标宏 '/tar 跳跃者'"
Lang["N1_29851"]  = "莱斯班恩将军"
Lang["N2_29851"]  = "当点击暗影拱顶末端的武器架时出现。你刚刚杀死的另外三个人在战斗中前来帮忙。\n\n你可以飞进飞出(44.9, 20.0)."
Lang["N1_26181"]  = "特使艾米萨·闪蹄 <牛头人大使>"
Lang["N2_26181"]  = "环绕着位于龙骨荒野的西风避难营下部，位于北风苔原边境 (13.9, 48.6)."
Lang["N1_26652"]  = "冰雾祖母"
Lang["N2_26652"]  = "她在阿格玛之锤绕着圆心走。她身穿蓝色盔甲，手持紫色手杖。"
Lang["N1_26505"]  = "辛塔尔·玛菲奥斯博士 <大药剂师>"
Lang["N2_26505"]  = "他在阿格玛之锤的炼金术角落(36.1, 48.8)."
Lang["N1_25257"]  = "小萨鲁法尔"
Lang["N2_25257"]  = "他在龙骨荒野西北角的天谴之门附近，位于(40.7, 18.1).\n\n不要太依恋他！"
Lang["N1_31333"]  = "阿莱克丝塔萨，生命的缚誓者 <巨龙的女王>"
Lang["N2_31333"]  = "她现在是龙的形态，在天谴之门前。相当大，不能错过她 (38.3, 19.2)."
Lang["N1_25256"]  = "萨鲁法尔大王"
Lang["N2_25256"]  = "他位于北风苔原战歌要塞的底部 (41.4, 53.7)."
Lang["N1_27136"]  = "高级指挥官哈尔弗·维姆班恩 <第七军团>"
Lang["N2_27136"]  = "他就在龙骨荒野暮冬要塞的顶端 (78.5, 48.3)."
Lang["N1_27872"]  = "伯瓦尔·弗塔根公爵"
Lang["N2_27872"]  = "伯瓦尔·弗塔根，联盟中真正的英雄，遭遇了可怕的命运。\n\n他在龙骨荒野(37.8, 23.4)等待."
Lang["N1_29611"]  = "瓦里安·乌瑞恩国王 <暴风城国王>"
Lang["N2_29611"]  = "看起来不太高兴。。"
Lang["N1_29473"]  = "格莱奇·菲兹巴克"
Lang["N2_29473"]  = "她在K3旅店 (41.2, 86.1)."
Lang["N1_15989"]  = "萨菲隆"
Lang["N2_15989"]  = "萨菲隆是一只巨大的亡灵冰霜巨龙，守卫着纳克萨玛斯克尔苏加德内部圣所的入口。"

Lang["N1_"]  = ""
Lang["N2_"]  = ""



Lang["O_1"] = "击杀达基萨斯将军以完成任务。\n位于达基萨斯将军后面的发光球."
Lang["O_2"] = "这是一个在地面上发光的小红点\n位于安其拉之门 (28.7,89.2)."
--v247
Lang["O_3"] = "神殿位于一条走廊的尽头，这条走廊从法则之环的上层开始。"
Lang["O_189311"] = "|cFFFFFFFF血之魔典|r\n|cFF808080开始新任务|r\n\n书在地下室的地板上,\n旁边是通灵领主阿玛里恩 (78.3, 52.3).\n\n完成任务后，赶快离开\n因为怪物会刷新并攻击你"
Lang["Flesh-bound Tome"] = "血之魔典"

