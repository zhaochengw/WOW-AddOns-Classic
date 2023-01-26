--localization file for english/United States
local Lang = LibStub("AceLocale-3.0"):NewLocale("Attune", "zhTW")
if (not Lang) then
	return;
end


-- INTERFACE
Lang["Credits"] = "非常感謝我的公會團員|cffffd100<Divine Heresy>|r在我測試此UI時給予的支持與理解，並感謝|cffffd100RoadBlock|r 和 |cffffd100Bushido|r在上的幫助！\n\n 另外，非常感謝翻譯人員：\n  - 德語翻譯: |cffffd100Sumaya @ Razorfen DE|r\n  - 俄語翻譯: |cffffd100Greymarch Guild @ Flamegor RU|r\n  - 西班牙語翻譯: |cffffd100Coyu @ Pyrewood Village EU|r\n  - 簡體中文翻譯: |cffffd100ly395842562|r 和 |cffffd100Icyblade|r\n  - 繁體中文翻譯: |cffffd100DayZ 三指打天下|r 和 |cffffd100薇兒 @ Ivus TW|r\n  - 韓語翻譯: |cffffd100Drix @ Azshara KR|r\n\n/Hug 来自 Cixi/Gaya @ Remulos Horde"
Lang["Mini"] = "縮小"
Lang["Maxi"] = "放大"
Lang["Version"] = "Attune v##VERSION## by Cixi@Remulos"
Lang["Splash"] = "v##VERSION## by Cixi@Remulos. 輸入/attune開始。"
Lang["Survey"] = "調查"
Lang["Guild"] = "公會"
Lang["Party"] = "隊伍"
Lang["Raid"] = "團隊"
Lang["Run an attunement survey (for people with the addon)"] = "進行開門任務調查（安裝此插件的玩家）"
Lang["Toggle between attunements and survey results"] = "切換調查結果" 
Lang["Close"] = "關閉" 
Lang["Export"] = "匯出"
Lang["My Data"] = "我的資料"
Lang["Last Survey"] = "上次調查"
Lang["Guild Data"] = "公會數據"
Lang["All Data"] = "所有數據"
Lang["Export your Attune data to the website"] = "將您的Attune數據匯出到網站"
Lang["Copy the text below, then upload it to"] = "複製下面的文本，然後將其上傳到"
Lang["Results"] = "調查結果"
Lang["Not in a guild"] = "沒有加入公會"
Lang["Click on a header to sort the results"] = "點擊標題以對結果進行排序" 
Lang["Character"] = "特質" 
Lang["Characters"] = "角色"
Lang["Last survey results"] = "上次調查结果"	
Lang["All FACTION results"] = "所有 ##FACTION## 结果"
Lang["Guild members"] = "公會成員" 
Lang["All results"] = "所有結果" 
Lang["Minimum level"] = "最低等級" 
Lang["Click to navigate to that attunement"] = "點擊以導航到該開門任務權限"
Lang["Attunes"] = "使用權"
Lang["Guild members on this step"] = "同任務進度的公會成員"
Lang["Attuned guild members"] = "Attuned 公會成員"
Lang["Attuned alts"] = "Attuned 超越"
Lang["Alts on this step"] = "超越該任務進度"
Lang["Settings"] = "設定"
Lang["Survey Log"] = "調查紀錄"
Lang["LeftClick"] = "左鍵點選"
Lang["OpenAttune"] = "打開 Attune"
Lang["RightClick"] = "右鍵點選"
Lang["OpenSettings"] = "打開設定"
Lang["Addon disabled"] = "插件已禁用"
Lang["StartAutoGuildSurvey"] = "開始公會自動調查"
Lang["SendingDataTo"] = "發送Attune數據给 |cffffd100NA##NAME##|r"
Lang["NewVersionAvailable"] = "一個Attune的 |cffffd100新版本|r 可用, 請更新它！"
Lang["CompletedStep"] = "已完成該 ##TYPE## |cffe4e400##STEP##|r  |cffe4e400##NAME##|r."
Lang["AttuneComplete"] = " |cffe4e400##NAME##|r 聲望已達到!"
Lang["AttuneCompleteGuild"] = "##NAME## 聲望已達到!"
Lang["SendingSurveyWhat"] = "發送調查"
Lang["SendingGuildSilentSurvey"] = "發送公會靜默調查"
Lang["SendingYellSilentSurvey"] = "發送 /大喊 靜默調查"
Lang["ReceivedDataFromName"] = "從 |cffffd100##NAME##接收的數據|r"
Lang["ExportingData"] = "統計Attune人物數據 ##COUNT##"
Lang["ReceivedRequestFrom"] = "收到 |cffffd100##FROM##的請求|r"
Lang["Help1"] = "該插件可讓您檢查並導出聲望進度。"
Lang["Help2"] = "運行 |cfffff700/attune|r 開始。"
Lang["Help3"] = "要調查公會的進度，請點擊 |cfffff700調查|r 收集訊息。"
Lang["Help4"] = "您將從帶有插件的任何公會成員那裡收到任務進度數據。"
Lang["Help5"] = "獲得足夠的訊息後，請點擊 |cfffff700導出|r 以導出公會進度。"
Lang["Help6"] = "數據可以上傳到 |cfffff700https://warcraftratings.com/attune/upload|r"
Lang["Survey_DESC"] = "進行聲望調查 (安裝本插件的玩家)"
Lang["Export_DESC"] = "將您的Attune數據導出到網站"
Lang["Toggle_DESC"] = "顯示調查結果"
--Lang["PreferredLocale_TEXT"] = "首選語言"
--Lang["PreferredLocale_DESC"] = "選擇您想要使用的Attune語言。對此進行更改將需要重新加載才能生效。"
--v220
Lang["My Toons"] = "我的角色"
Lang["No Target"] = "你沒有目標"
Lang["No Response From"] = " ##PLAYER##沒有回應"
Lang["Sync Request From"] = "來自:\n\n##PLAYER##的同步請求"
Lang["Could be slow"] = "根據您擁有的數據量，這可能是一個非常緩慢的過程。"
Lang["Accept"] = "接受"
Lang["Reject"] = "拒絕"
Lang["Busy right now"] = "##PLAYER## 正在忙碌，稍後再試"
Lang["Sending Sync Request"] = "發送同步請求到 ##PLAYER##"
Lang["Request accepted, sending data to "] = "請求已接受，將數據發送到 ##PLAYER##"
Lang["Received request from"] = "收到來自 ##PLAYER##的請求"
Lang["Request rejected"] = "請求被拒絕"
Lang["Sync over"] = "同步結束，使用時間##DURATION##"
Lang["Syncing Attune data with"] = "與##PLAYER##數據同步"
Lang["Cannot sync while another sync is in progress"] = "無法同時進行兩個同步"
Lang["Sync with target"] = "正在與目標同步"
Lang["Show Profiles"] = "顯示個人資料"
Lang["Show Progress"] = "顯示進度"
Lang["Status"] = "狀態"
Lang["Role"] = "角色"
Lang["Last Surveyed"] = "上次的調查"
Lang['Seconds ago'] = "##DURATION## 秒"
Lang["Main"] = "主選單"
Lang["Alt"] = "備用角色"
Lang["Tank"] = "坦克"
Lang["Healer"] = "治療"
Lang["Melee DPS"] = "近戰輸出"
Lang["Ranged DPS"] = "遠程輸出"
Lang["Bank"] = "銀行"
Lang["DelAlts_TEXT"] = "刪除所有備用角色。"
Lang["DelAlts_DESC"] = "刪除所有標記為備用角色訊息。"
Lang["DelAlts_CONF"] = "確定刪除所有備用角色?"
Lang["DelAlts_DONE"] = "所有備用角色已刪除。"
Lang["DelUnspecified_TEXT"] = "刪除未指定。"
Lang["DelUnspecified_DESC"] = "刪除有關未指定主/備用狀態的玩家的所有訊息。"
Lang["DelUnspecified_CONF"] = "確定刪除所有未指定主/備用狀態的玩家的所有訊息嗎？"
Lang["DelUnspecified_DONE"] = "所有未指定的主/備用狀態的玩家的所有訊息都已刪除。"
--v221
Lang["Open Raid Planner"] = "公開團隊副本設計師"
Lang["Unspecified"] = "未指定"
Lang["Empty"] = "空的"
Lang["Guildies only"] = "僅顯示公會成員"
Lang["Show Mains"] = "顯示主要角色"
Lang["Show Unspecified"] = "顯示未指定角色"
Lang["Show Alts"] = "顯示備用角色"
Lang["Show Unattuned"] = "顯示未完成開門任務角色"
Lang["Raid spots"] = "##SIZE## 團隊副本陣地"
Lang["Group Number"] = "團本 ##NUMBER##"
Lang["Move to next group"] = "移至下一組"
Lang["Remove from raid"] = "從團隊副本中移除"
Lang["Select a raid and click on players to add them in"] = "選擇一個團隊並點擊玩家以添加他們"
--v224
Lang["Enter a new name for this raid group"] = "輸入此團隊的新名稱"
Lang["Save"] = "保存"
--v226
Lang["Invite"] = "邀請"
Lang["Send raid invites to all listed players?"] = "向所有列出的玩家發送團隊副本邀請？"
Lang["External link"] = "連接到在線數據庫"
--v243
Lang["Ogrila"] = "奧格瑞拉"
Lang["Ogri'la Quest Hub"] = "奧格瑞拉宣教中心"
Lang["Ogrila_Desc"] = "聰明而開化的奧格瑞拉食人魔居住在刀鋒山的西部區域。"
Lang["DelInactive_TEXT"] = "刪除不活動"
Lang["DelInactive_DESC"] = "刪除所有標記為非活動玩家的信息"
Lang["DelInactive_CONF"] = "真的刪除所有非活動嗎？"
Lang["DelInactive_DONE"] = "已刪除所有非活動"
Lang["RAIDS"] = "團隊"
Lang["KEYS"] = "鑰匙"
Lang["MISC"] = "雜項"
Lang["HEROICS"] = "英雄"
--v244
Lang["Ally of the Netherwing"] = "靈翼之盟"
Lang["Netherwing_Desc"] = "虛空之翼是位於外域的一個龍派系。"
--v247
Lang["Tirisfal Glades"] = "提瑞斯法林地"
Lang["Scholomance"] = "通灵学院"
--v248
Lang["Target"] = "目標"
Lang["SendingSurveyTo"] = "向 ##TO## 發送調查"
--WOTLK
Lang["QUEST HUBS"] = "任務線"
Lang["PHASES"] = "事件"
Lang["Angrathar the Wrathgate"] = "安加薩 天譴之門"
Lang["Unlock the Wrathgate events and the Battle for the Undercity"] = "解鎖天譴之門事件和幽暗城之戰"
Lang["Sons of Hodir"] = "霍迪爾之子"
Lang["Unlock the Sons of Hodir quest hub"] = "解鎖霍迪爾之子任務線"
Lang["Knights of the Ebon Blade"] = "黑鋒騎士團"
Lang["Unlock the Shadow Vault quest hub"] = "解鎖暗影穹頂任務線"
Lang["Goblin"] = "地精"
Lang["Death Knight"] = "死亡騎士"
Lang["Eye"] = "眼"
Lang["Abomination"] = "憎惡"
Lang["Banshee"] = "女妖"
Lang["Geist"] = "惡鬼"
Lang["Icecrown"] = "冰冠冰川"
Lang["Dragonblight"] = "龍骨荒野"
Lang["Borean Tundra"] = "北風苔原"
Lang["The Storm Peaks"] = "風暴峭壁"
Lang["The Eye of Eternity"] = "永恆之眼"
Lang["Sapphiron"] = "薩菲隆"
Lang["One_Desc"] = "團隊中只需一個人擁有此鑰匙。"


-- OPTIONS
Lang["MinimapButton_TEXT"] = "顯示小地圖按鈕"
Lang["MinimapButton_DESC"] = "顯示小地圖按鈕可快速訪問插件介面或選項。"
Lang["AutoSurvey_TEXT"] = "對登入玩家進行公會自動調查"
Lang["AutoSurvey_DESC"] = "每當您登入遊戲時，插件都會進行公會調查。"
Lang["ShowSurveyed_TEXT"] = "在接受調查時顯示"
Lang["ShowSurveyed_DESC"] =  "接受（和回答）調查請求時顯示聊天訊息。"
Lang["ShowResponses_TEXT"] = "進行調查時顯示答覆"
Lang["ShowResponses_DESC"] = "顯示每隔調查響應的聊天消訊息。"
Lang["ShowSetMessages_TEXT"] = "顯示步驟完成訊息"
Lang["ShowSetMessages_DESC"] = "當步調完成時，顯示聊天訊息。"
Lang["AnnounceToGuild_TEXT"] = "在公會聊天中宣布完成"
Lang["AnnounceToGuild_DESC"] = "開門任務完成後發送公會訊息。"
Lang["ShowOther_TEXT"] = "顯示其他聊天訊息"
Lang["ShowOther_DESC"] = "顯示所有其他常規聊天訊息（啟動訊息，發送調查，可用更新等）。"
Lang["ShowGuildies_TEXT"] = "在每個使用權步驟中顯示公會成員列表。             最大清單大小"  --this has a gap for the editbox
Lang["ShowGuildies_DESC"] = "當前在使用權步驟中的公會成員列表顯示在步驟工具提示中。\n如有必要，請調整要在每個調整步驟中列出的最大結果數。"
Lang["ShowAltsInstead_TEXT"] = "顯示備用角色，而不是公會成員"
Lang["ShowAltsInstead_DESC"] = "步驟工具提示將顯示您當前在該使用權步驟中的所有備用角色，而不是公會成員。"
Lang["ClearAll_TEXT"] = "刪除所有結果"
Lang["ClearAll_DESC"] = "刪除所有收集的有關其他玩家的訊息。"
Lang["ClearAll_CONF"] = "真的要刪除所有結果嗎？"
Lang["ClearAll_DONE"] = "所有結果已刪除。"
Lang["DelNonGuildies_TEXT"] = "刪除非公會成員"
Lang["DelNonGuildies_DESC"] = "從公會外部刪除所有有關玩家的信息。"
Lang["DelNonGuildies_CONF"] = "真的刪除所有非公會會員嗎？"
Lang["DelNonGuildies_DONE"] = "公會以外的所有結果均已刪除。"
Lang["DelUnder60_TEXT"] = "刪除60等以下的角色"
Lang["DelUnder60_DESC"] = "刪除所有收集的有關60級以下玩家的信息。"
Lang["DelUnder60_CONF"] = "真的要刪除60級以下的所有角色嗎？"
Lang["DelUnder60_DONE"] = "所有低於60的角色均已刪除。"
Lang["DelUnder70_TEXT"] = "刪除70等以下的角色"
Lang["DelUnder70_DESC"] = "刪除所有收集的有關70級以下玩家的信息。"
Lang["DelUnder70_CONF"] = "真的要刪除70級以下的所有角色嗎？"
Lang["DelUnder70_DONE"] = "所有低於70的角色均已刪除。"
--302
Lang["AnnounceAchieve_TEXT"] = "在公會聊天中宣布成就                                      臨界點:"
Lang["AnnounceAchieve_DESC"] = "獲得成就時發送公會消息。"
Lang["AchieveCompleteGuild"] = "##LINK## 聲望已達到!" 
Lang["AchieveCompletePoints"] = "(##POINTS## 總積分)" 
Lang["AchieveSurvey"] = "想要|cFFFFD100Attune|r 在公會聊天中公佈|cFFFFD100##WHO##|r 的成就嗎？"
--306
Lang["showDeprecatedAttunes_TEXT"] = "顯示已棄用的調諧"
Lang["showDeprecatedAttunes_DESC"] = "在列表中保持較舊的調音（奧妮克希亞 40、納克薩馬斯 40）可見"


-- TREEVIEW
Lang["World of Warcraft"] = "魔獸世界"
Lang["The Burning Crusade"] = "燃燒的遠征"
Lang["Molten Core"] = "熔火之心"
Lang["Onyxia's Lair"] = "奧妮克希亞的巢穴"
Lang["Blackwing Lair"] = "黑翼之巢"
Lang["Naxxramas"] = "納克薩馬斯"
Lang["Scepter of the Shifting Sands"] = "流沙節杖"
Lang["Shadow Labyrinth"] = "暗影迷宮"
Lang["The Shattered Halls"] = "破碎大廳"
Lang["The Arcatraz"] = "亞克崔茲"
Lang["The Black Morass"] = "黑色沼澤"
Lang["Thrallmar Heroics"] = "索爾瑪英雄"
Lang["Honor Hold Heroics"] = "榮譽堡英雄"
Lang["Cenarion Expedition Heroics"] = "塞納里奧遠征隊英雄"
Lang["Lower City Heroics"] = "陰鬱城英雄"
Lang["Sha'tar Heroics"] = "薩塔英雄"
Lang["Keepers of Time Heroics"] = "時光守望者英雄"
Lang["Nightbane"] = "夜禍"
Lang["Karazhan"] = "卡拉贊"
Lang["Serpentshrine Cavern"] = "毒蛇神殿"
Lang["The Eye"] = "風暴要塞"
Lang["Mount Hyjal"] = "海加爾山"
Lang["Black Temple"] = "黑暗神廟"
Lang["MC_Desc"] = "團隊中的所有成員都必須完成該任務，才能進入該副本，除非他們通過黑石深淵進入。" 
Lang["Ony_Desc"] = "團隊中的所有成員都必須在其背包中攜帶龍火護符，才能進入該副本。"
Lang["BWL_Desc"] = "團隊中的所有成員都必須完成該任務，才能進入該副本，除非他們從黑石塔上層進入。"
Lang["All_Desc"] = "團隊中的所有成員都必須完成該任務，才能進入該副本"
Lang["AQ_Desc"] = "每個伺服器只要有一個人完成此任務，就能打開安琪拉之門。"
Lang["OnlyOne_Desc"] = "隊伍中只需要有一個人擁有此鑰匙。350開鎖技能的盜賊也可以打開大門。"
Lang["Heroic_Desc"] = "隊伍中地所有成員都需要聲望和鑰匙，才能進入英雄難度的副本。"
Lang["NB_Desc"] = "團隊中需要有一名成員擁有黑色骨灰才能招喚夜禍。"
Lang["BT_Desc"] = "團隊中的所有成員都必須擁有卡拉伯爾勳章，才能進入該團隊副本。"
Lang["BM_Desc"] = "團隊中的所有成員都需要完成任務鏈才能劃分到團隊副本中。" 
--v250
Lang["Aqual Quintessence"] = "水之精萃"
Lang["MC2_Desc"] = "用於召喚 管理者埃克索图斯。 除了兩個以外，熔火之心中的每個 Boss 都在地面上有符文，需要將其澆灌以使 管理者埃克索图斯 生成。" 
--v254
Lang["Magisters' Terrace Heroic"] = "魔導師露台英雄"
Lang["Magisters' Terrace"] = "魔導師露台"
Lang["MgT_Desc"] = "所有玩家都需要在普通模式下完成地牢才能在英雄模式下運行它。"
Lang["Isle of Quel'Danas"] = "奎爾丹納斯島"
Lang["Wrath of the Lich King"] = "巫妖王之怒"


-- GENERIC
Lang["Reach level"] = "達到等級"
Lang["Attuned"] = "完成"
Lang["Not attuned"] = "未完成"
Lang["AttuneColors"] = "藍色: 完成\n红色:未完成"
Lang["Minimum Level"] = "接取任務的最低等級。"
Lang["NPC Not Found"] = "找不到NPC訊息"
Lang["Level"] = "等級"
Lang["Exalted with"] = "崇拜"
Lang["Revered with"] = "崇敬"
Lang["Honored with"] = "尊敬"
Lang["Friendly with"] = "友好"
Lang["Neutral with"] = "中立"
Lang["Quest"] = "任務"
Lang["Pick Up"] = "拾取"
Lang["Turn In"] = "上繳"
Lang["Kill"] = "擊殺"
Lang["Interact"] = "互動"
Lang["Item"] = "物品"
Lang["Required level"] = "所需等級"
Lang["Requires level"] = "需要等級"
Lang["Attunement or key"] = "開門任務或鑰匙"
Lang["Reputation"] = "聲望"
Lang["in"] = "進入"
Lang["Unknown Reputation"] = "未知聲望"
Lang["Current progress"] = "當前進度"
Lang["Completion"] = "完成時間"
Lang["Quest information not found"] = "找不到任務訊息"
Lang["Information not found"] = "找不到訊息"
Lang["Solo quest"] = "單人任務"
Lang["Party quest"] = "隊伍任務 (##NB##-man)"
Lang["Raid quest"] = "團隊任務   (##NB##-man)"
Lang["HEROIC"] = "英雄"
Lang["Elite"] = "精英"
Lang["Boss"] = "首領"
Lang["Rare Elite"] = "稀有精英"
Lang["Dragonkin"] = "龍類"
Lang["Troll"] = "食人妖"
Lang["Ogre"] = "巨魔"
Lang["Orc"] = "獸人"
Lang["Half-Orc"] = "半獸人"
Lang["Dragonkin (in Blood Elf form)"] = "龍類（血精靈型態）"
Lang["Human"] = "人類"
Lang["Dwarf"] = "矮人"
Lang["Mechanical"] = "機械"
Lang["Arakkoa"] = "阿拉卡"
Lang["Dragonkin (in Humanoid form)"] = "龍類（人形態）"
Lang["Ethereal"] = "乙太"
Lang["Blood Elf"] = "血精靈"
Lang["Elemental"] = "元素"
Lang["Shiny thingy"] = "閃亮的東東"
Lang["Naga"] = "納迦"
Lang["Demon"] = "惡魔"
Lang["Gronn"] = "戈隆"
Lang["Undead (in Dragon form)"] = "不死族（龍型態）"
Lang["Tauren"] = "牛頭人"
Lang["Qiraji"] = "其拉蟲族"
Lang["Gnome"] = "地精"
Lang["Broken"] = "破碎者"
Lang["Draenei"] = "德萊尼"
Lang["Undead"] = "不死族"
Lang["Gorilla"] = "猩猩"
Lang["Shark"] = "鯊魚"
Lang["Chimaera"] = "奇美拉"
Lang["Wisp"] = "幽光"
Lang["Night-Elf"] = "夜精靈"


-- REP
Lang["Argent Dawn"] = "銀色黎明"
Lang["Brood of Nozdormu"] = "諾茲多姆的子嗣"
Lang["Thrallmar"] = "索爾瑪"
Lang["Honor Hold"] = "榮譽堡"
Lang["Cenarion Expedition"] = "塞納里奧遠征隊"
Lang["Lower City"] = "陰鬱城"
Lang["The Sha'tar"] = "薩塔"
Lang["Keepers of Time"] = "時光守望者"
Lang["The Violet Eye"] = "紫羅蘭之眼"
Lang["The Aldor"] = "奧爾多"
Lang["The Scryers"] = "占卜者"


-- LOCATIONS
Lang["Blackrock Mountain"] = "黑石山"
Lang["Blackrock Depths"] = "黑石深淵"
Lang["Badlands"] = "荒蕪之地"
Lang["Lower Blackrock Spire"] = "黑石塔下層"
Lang["Upper Blackrock Spire"] = "黑石塔上層"
Lang["Orgrimmar"] = "奧格瑪"
Lang["Western Plaguelands"] = "西瘟疫之地"
Lang["Desolace"] = "淒涼之地"
Lang["Dustwallow Marsh"] = "塵泥沼澤"
Lang["Tanaris"] = "塔納利斯"
Lang["Winterspring"] = "冬泉谷"
Lang["Swamp of Sorrows"] = "悲傷沼澤"
Lang["Wetlands"] = "濕地"
Lang["Burning Steppes"] = "燃燒平原"
Lang["Redridge Mountains"] = "赤脊山"
Lang["Stormwind City"] = "暴風城"
Lang["Eastern Plaguelands"] = "東瘟疫之地"
Lang["Silithus"] = "希利蘇斯"
Lang["The Temple of Atal'Hakkar"] = "阿塔哈卡神廟"
Lang["Teldrassil"] = "泰達希爾"
Lang["Moonglade"] = "月光林地"
Lang["Hinterlands"] = "辛特蘭"
Lang["Ashenvale"] = "梣谷"
Lang["Feralas"] = "菲拉斯"
Lang["Duskwood"] = "暮色森林"
Lang["Azshara"] = "艾薩拉"
Lang["Blasted Lands"] = "詛咒之地"
Lang["Undercity"] = "幽暗城"
Lang["Silverpine Forest"] = "銀松森林"
Lang["Shadowmoon Valley"] = "影月谷"
Lang["Hellfire Peninsula"] = "地獄火半島"
Lang["Sethekk Halls"] = "塞司克大廳"
Lang["Caverns Of Time"] = "時光之穴"
Lang["Netherstorm"] = "虛空風暴"
Lang["Shattrath City"] = "撒塔斯城"
Lang["The Mechanaar"] = "麥克納爾"
Lang["The Botanica"] = "波塔尼卡"
Lang["Zangarmarsh"] = "贊格沼澤"
Lang["Terokkar Forest"] = "泰洛卡森林"
Lang["Deadwind Pass"] = "逆風小徑"
Lang["Alterac Mountains"] = "奧特蘭克山脈"
Lang["The Steamvault"] = "蒸氣洞窟"
Lang["Slave Pens"] = "奴隸監獄"
Lang["Gruul's Lair"] = "戈魯爾的巢穴"
Lang["Magtheridon's Lair"] = "瑪瑟里頓的巢穴"
Lang["Zul'Aman"] = "祖阿曼"
Lang["Sunwell Plateau"] = "太陽之井高地"



-- ITEMS
Lang["Drakkisath's Brand"] = "達基薩斯的烙印"
Lang["Crystalline Tear"] = "水晶之淚"
Lang["I_18412"] = "熔核碎片"			-- https://cn.tbc.wowhead.com/?item=18412
Lang["I_12562"] = "重要的黑石文件"			-- https://cn.tbc.wowhead.com/?item=12562
Lang["I_16786"] = "黑色龍人的眼球"			-- https://cn.tbc.wowhead.com/?item=16786
Lang["I_11446"] = "弄皺的便箋"			-- https://cn.tbc.wowhead.com/?item=11446
Lang["I_11465"] = "溫德索爾元帥遺失的情報"			-- https://cn.tbc.wowhead.com/?item=11465
Lang["I_11464"] = "溫德索爾元帥遺失的情報"			-- https://cn.tbc.wowhead.com/?item=11464
Lang["I_18987"] = "黑手的命令"			-- https://cn.tbc.wowhead.com/?item=18987
Lang["I_20383"] = "勒西雷爾的頭顱"			-- https://cn.tbc.wowhead.com/?item=20383
Lang["I_21138"] = "紅色節杖碎片"			-- https://cn.tbc.wowhead.com/?item=21138
Lang["I_21146"] = "腐蝕夢魘的碎片"			-- https://cn.tbc.wowhead.com/?item=21146
Lang["I_21147"] = "腐蝕夢魘的碎片"			-- https://cn.tbc.wowhead.com/?item=21147
Lang["I_21148"] = "腐蝕夢魘的碎片"			-- https://cn.tbc.wowhead.com/?item=21148
Lang["I_21149"] = "腐蝕夢魘的碎片"			-- https://cn.tbc.wowhead.com/?item=21149
Lang["I_21139"] = "綠色節杖碎片"			-- https://cn.tbc.wowhead.com/?item=21139
Lang["I_21103"] = "龍語傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21103
Lang["I_21104"] = "龍語傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21104
Lang["I_21105"] = "龍語傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21105
Lang["I_21106"] = "龍語傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21106
Lang["I_21107"] = "龍語傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21107
Lang["I_21108"] = "龍語傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21108
Lang["I_21109"] = "龍語傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21109
Lang["I_21110"] = "龍語傻瓜教程"			-- https://cn.tbc.wowhead.com/?item=21110
Lang["I_21111"] = "龍語傻瓜教程：第二卷"			-- https://cn.tbc.wowhead.com/?item=21111
Lang["I_21027"] = "拉克麥拉的屍體"			-- https://cn.tbc.wowhead.com/?item=21027
Lang["I_21024"] = "奇美洛克的腰肋肉"			-- https://cn.tbc.wowhead.com/?item=21024
Lang["I_20951"] = "納里安的占卜眼鏡"			-- https://cn.tbc.wowhead.com/?item=20951
Lang["I_21137"] = "藍色節杖碎片"			-- https://cn.tbc.wowhead.com/?item=21137
Lang["I_21175"] = "流沙節杖"			-- https://cn.tbc.wowhead.com/?item=21175
Lang["I_31241"] = "原始鑰匙模子"			-- https://cn.tbc.wowhead.com/?item=31241
Lang["I_31239"] = "原始鑰匙模子"			-- https://cn.tbc.wowhead.com/?item=31239
Lang["I_27991"] = "暗影迷宫鑰匙"			-- https://cn.tbc.wowhead.com/?item=27991
Lang["I_31086"] = "亞克崔茲鑰匙的底部裂片"			-- https://cn.tbc.wowhead.com/?item=31086
Lang["I_31085"] = "亞克崔茲鑰匙的頂部裂片"			-- https://cn.tbc.wowhead.com/?item=31085
Lang["I_31084"] = "亞克崔茲鑰匙"			-- https://cn.tbc.wowhead.com/?item=31084
Lang["I_30637"] = "火鑄之鑰"			-- https://cn.tbc.wowhead.com/?item=30637
Lang["I_30622"] = "火鑄之鑰"			-- https://cn.tbc.wowhead.com/?item=30622
Lang["I_30623"] = "蓄湖之鑰"			-- https://cn.tbc.wowhead.com/?item=30623
Lang["I_30633"] = "奧奇奈鑰匙"			-- https://cn.tbc.wowhead.com/?item=30633
Lang["I_30634"] = "扭曲鍛造鑰匙"			-- https://cn.tbc.wowhead.com/?item=30634
Lang["I_30635"] = "時光之鑰"			-- https://cn.tbc.wowhead.com/?item=30635
Lang["I_185686"] = "火鑄之鑰"			-- https://cn.tbc.wowhead.com/?item=30637
Lang["I_185687"] = "火鑄之鑰"			-- https://cn.tbc.wowhead.com/?item=30622
Lang["I_185690"] = "蓄湖之鑰"			-- https://cn.tbc.wowhead.com/?item=30623
Lang["I_185691"] = "奧奇奈鑰匙"			-- https://cn.tbc.wowhead.com/?item=30633
Lang["I_185692"] = "扭曲鍛造鑰匙"			-- https://cn.tbc.wowhead.com/?item=30634
Lang["I_185693"] = "時光之鑰"			-- https://cn.tbc.wowhead.com/?item=30635
Lang["I_24514"] = "第一塊鑰匙碎片"			-- https://cn.tbc.wowhead.com/?item=24514
Lang["I_24487"] = "第二塊鑰匙碎片"			-- https://cn.tbc.wowhead.com/?item=24487
Lang["I_24488"] = "第三塊鑰匙碎片"			-- https://cn.tbc.wowhead.com/?item=24488
Lang["I_24490"] = "麥迪文的鑰匙"			-- https://cn.tbc.wowhead.com/?item=24490
Lang["I_23933"] = "麥迪文的日記"			-- https://cn.tbc.wowhead.com/?item=23933
Lang["I_25462"] = "黑暗之書"			-- https://cn.tbc.wowhead.com/?item=25462
Lang["I_25461"] = "遺忘之名魔典"			-- https://cn.tbc.wowhead.com/?item=25461
Lang["I_24140"] = "燻黑的骨灰甕"			-- https://cn.tbc.wowhead.com/?item=24140
Lang["I_31750"] = "土靈徽記"			-- https://cn.tbc.wowhead.com/?item=31750
Lang["I_31751"] = "熾亮徽記"			-- https://cn.tbc.wowhead.com/?item=31751
Lang["I_31716"] = "劊子手的廢棄之斧"			-- https://cn.tbc.wowhead.com/?item=31716
Lang["I_31721"] = "卡利斯瑞的三叉戟"			-- https://cn.tbc.wowhead.com/?item=31721
Lang["I_31722"] = "莫爾墨的精華"			-- https://cn.tbc.wowhead.com/?item=31722
Lang["I_31704"] = "風暴鑰匙"			-- https://cn.tbc.wowhead.com/?item=31704
Lang["I_29905"] = "凱爾薩斯的殘存之瓶"			-- https://cn.tbc.wowhead.com/?item=29905
Lang["I_29906"] = "瓦許的殘存之瓶"			-- https://cn.tbc.wowhead.com/?item=29906
Lang["I_31307"] = "狂怒之心"			-- https://cn.tbc.wowhead.com/?item=31307
Lang["I_32649"] = "卡拉伯爾勳章"			-- https://cn.tbc.wowhead.com/?item=32649
--v247
Lang["Shrine of Thaurissan"] = "索瑞森神殿"
Lang["I_14610"] = "阿拉基的圣甲虫"
--v250
Lang["I_17332"] = "沙斯拉爾之手"
Lang["I_17329"] = "魯西弗隆之手"
Lang["I_17331"] = "基赫納斯之手"
Lang["I_17330"] = "薩弗隆之手"
Lang["I_17333"] = "水之精萃"
--WOTLK
Lang["I_41556"] = "熔渣包裹的金屬"
Lang["I_44569"] = "聚焦之虹的鑰匙"
Lang["I_44582"] = "聚焦之虹的鑰匙"
Lang["I_44577"] = "英雄聚焦之虹的鑰匙"
Lang["I_44581"] = "英雄聚焦之虹的鑰匙"

Lang["I_"] = ""


-- QUESTS - Classic
Lang["Q1_7848"] = "熔火之心的傳送門"			-- https://cn.tbc.wowhead.com/?quest=7848
Lang["Q2_7848"] = "進入黑石深淵，在通往熔火之心的傳送門附近找到一塊熔核碎片，然後回到黑石山的洛索斯·天痕那裡。"
Lang["Q1_4903"] = "高圖斯的命令"			-- https://cn.tbc.wowhead.com/?quest=4903
Lang["Q2_4903"] = "殺死歐莫克大王、將領沃恩和維姆薩拉克主宰。找到重要的黑石文件，然後向卡加斯的督軍高圖斯彙報。"
Lang["Q1_4941"] = "伊崔格的智慧"			-- https://cn.tbc.wowhead.com/?quest=4941
Lang["Q2_4941"] = "和奧格瑪的伊崔格談一談。討論完畢後，諮詢索爾的意見。\n\n你回憶起曾在索爾的大廳中見過伊崔格。"
Lang["Q1_4974"] = "為部落而戰！"			-- https://cn.tbc.wowhead.com/?quest=4974
Lang["Q2_4974"] = "去黑石塔殺死大酋長雷德·黑手，帶著他的頭顱返回奧格瑪。"
Lang["Q1_6566"] = "風吹來的消息"			-- https://cn.tbc.wowhead.com/?quest=6566
Lang["Q2_6566"] = "聽索爾講話。"
Lang["Q1_6567"] = "部落的勇士"			-- https://cn.tbc.wowhead.com/?quest=6567
Lang["Q2_6567"] = "按照酋長的指示找到雷克薩。他在石爪山脈和菲拉斯之間的淒涼之地遊蕩。"
Lang["Q1_6568"] = "雷克薩的證明"			-- https://cn.tbc.wowhead.com/?quest=6568
Lang["Q2_6568"] = "把雷克薩的證明交给西瘟疫之地的巫女米蘭達。"
Lang["Q1_6569"] = "黑龍幻象"			-- https://cn.tbc.wowhead.com/?quest=6569
Lang["Q2_6569"] = "到黑石塔去收集20顆黑色龍人的眼球，完成任務之後回到巫女米蘭達那裡。"
Lang["Q1_6570"] = "埃博斯塔夫"			-- https://cn.tbc.wowhead.com/?quest=6570
Lang["Q2_6570"] = "到塵泥沼澤中的巨龍沼澤去，找到埃博斯塔夫的洞穴。進入洞穴之後戴上龍形護符，然後跟埃博斯塔夫交談。"
Lang["Q1_6584"] = "龍骨試煉，克鲁纳里斯"			-- https://cn.tbc.wowhead.com/?quest=6584
Lang["Q2_6584"] = "諾茲多姆的孩子克魯納裡斯在塔納利斯沙漠守衛著時光之穴。殺了他，把他的顱骨交給埃博斯塔夫。"
Lang["Q1_6582"] = "龍骨試煉，斯克利爾"			-- https://cn.tbc.wowhead.com/?quest=6582
Lang["Q2_6582"] = "找到藍龍斯克利爾並殺掉他。從他的身上取下他的顱骨，然後將其交給埃博斯塔夫。"
Lang["Q1_6583"] = "龍骨試煉，索姆努斯"			-- https://cn.tbc.wowhead.com/?quest=6583
Lang["Q2_6583"] = "殺掉綠龍索姆努斯，把他的顱骨交給埃博斯塔夫。"
Lang["Q1_6585"] = "龍骨試煉，埃克托兹"			-- https://cn.tbc.wowhead.com/?quest=6585
Lang["Q2_6585"] = "到格瑞姆巴托去殺掉紅龍埃克托兹，把他的顱骨交給埃博斯塔夫。"
Lang["Q1_6601"] = "晉升……"			-- https://cn.tbc.wowhead.com/?quest=6601
Lang["Q2_6601"] = "看來這場假面舞會就要結束了。你知道米蘭達為你製作的龍形護符在黑石塔裡面不會發揮作用，也許你應該去找雷克薩，將你的困境告訴他。把黯淡的龍火護符給他看看，也許他知道下一步該怎麼做。"
Lang["Q1_6602"] = "黑龍勇士之血"			-- https://cn.tbc.wowhead.com/?quest=6602
Lang["Q2_6602"] = "到黑石塔去殺掉達基薩斯將軍，把它的血交給雷克薩。"
Lang["Q1_4182"] = "黑龍的威脅"			-- https://cn.tbc.wowhead.com/?quest=4182
Lang["Q2_4182"] = "殺掉15條黑色小龍、10條黑色龍人、4條火鱗龍人和1條黑色幼龍。"
Lang["Q1_4183"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4183
Lang["Q2_4183"] = "把赫林迪斯·河角的信交给赤脊山湖畔鎮的索羅門鎮長。"
Lang["Q1_4184"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4184
Lang["Q2_4184"] = "到暴風成去把索羅門的求援信交给伯瓦爾·弗塔根公爵。\n\n伯瓦爾在暴風要塞裡。"
Lang["Q1_4185"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4185
Lang["Q2_4185"] = "與女伯爵卡特拉娜·普瑞斯托談話，然後再與伯瓦爾·弗塔根公爵談話。"
Lang["Q1_4186"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4186
Lang["Q2_4186"] = "把伯瓦爾的命令交给湖畔鎮的索羅門鎮長。"
Lang["Q1_4223"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4223
Lang["Q2_4223"] = "和燃燒平原的麥克斯爾元帥談一談。"
Lang["Q1_4224"] = "真正的主人"			-- https://cn.tbc.wowhead.com/?quest=4224
Lang["Q2_4224"] = "和狼狽不堪的約翰談談來了解溫德索爾元帥的命運，然後回到麥克斯爾元帥那裡。\n\n你想起麥克斯爾元帥說過他在一個北面的洞穴那裡。"
Lang["Q1_4241"] = "溫德索爾元帥"			-- https://cn.tbc.wowhead.com/?quest=4241
Lang["Q2_4241"] = "到西北部的黑石山脈去，在黑石深淵中找到溫德索爾元帥的下落。\n\n狼狽不堪的約翰曾告訴你說溫德索爾被關進了一個監獄。"
Lang["Q1_4242"] = "被遺棄的希望"			-- https://cn.tbc.wowhead.com/?quest=4242
Lang["Q2_4242"] = "把這個壞消息傳達給麥克斯爾元帥。"
Lang["Q1_4264"] = "弄皺的便箋"			-- https://cn.tbc.wowhead.com/?quest=4264
Lang["Q2_4264"] = "溫德索爾元帥也許會對你手中的東西感興趣。畢竟，希望還沒有被完全扼殺。"
Lang["Q1_4282"] = "一絲希望"			-- https://cn.tbc.wowhead.com/?quest=4282
Lang["Q2_4282"] = "找回溫德索爾元帥遺失的情報。\n\n溫德索爾元帥確信那些情報在安格佛將軍和魔像領主阿格曼奇的手裡。"
Lang["Q1_4322"] = "衝破牢籠！"			-- https://cn.tbc.wowhead.com/?quest=4322
Lang["Q2_4322"] = "幫助溫德索爾元帥拿回他的裝備並救出他的朋友。當你成功之後就回去向麥克斯爾元帥覆命。"
Lang["Q1_6402"] = "集合在暴風成"			-- https://cn.tbc.wowhead.com/?quest=6402
Lang["Q2_6402"] = "前往暴風城的城門。與侍衛洛文交談，他會通知溫德索爾元帥你已經到達了。"
Lang["Q1_6403"] = "潛藏者"			-- https://cn.tbc.wowhead.com/?quest=6403
Lang["Q2_6403"] = "跟隨雷吉納德·溫德索爾元帥在暴風城中前進。保護他，別讓他受到傷害！"
Lang["Q1_6501"] = "巨龍之眼"			-- https://cn.tbc.wowhead.com/?quest=6501
Lang["Q2_6501"] = "你必須尋遍世界以找到一種能恢復龍眼碎片的能量的生物。你對這種生物的唯一了解就是：他們確實存在。"
Lang["Q1_6502"] = "龍火護符"			-- https://cn.tbc.wowhead.com/?quest=6502
Lang["Q2_6502"] = "你必須從達基薩斯將軍身上取回黑龍勇士之血，你可以在黑石塔的晋升大廳後面的房間裡找到他。"
Lang["Q1_7761"] = "黑手的命令"			-- https://cn.tbc.wowhead.com/?quest=7761
Lang["Q2_7761"] = "真是個愚蠢的獸人。看來你需要找到那枚烙印並獲得達基薩斯徽記才可以使用命令寶珠。\n\n你從信中獲知，達基薩斯將軍守衛著烙印。也許你應該就此進行更深入的調查。"
Lang["Q1_9121"] = "驚懼城塞，納克薩瑪斯"			-- https://cn.tbc.wowhead.com/?quest=9121
Lang["Q2_9121"] = "東瘟疫之地聖光之願禮拜堂的大法師安琪拉·多桑杜需要5個秘法水晶，2個聯結水晶，1個正義寶珠和60金。你一定要在銀色黎明達到尊敬聲望。"
Lang["Q1_9122"] = "驚懼城塞，納克薩瑪斯"			-- https://cn.tbc.wowhead.com/?quest=9122
Lang["Q2_9122"] = "東瘟疫之地聖光之願禮拜堂的大法師安琪拉·多桑杜需要2個秘法水晶、1個聯結水晶和30金。你在銀色黎明中的聲望必須達到崇敬。"
Lang["Q1_9123"] = "驚懼城塞，納克薩瑪斯"			-- https://cn.tbc.wowhead.com/?quest=9123
Lang["Q2_9123"] = "東瘟疫之地聖光之願禮拜堂的大法師安琪拉·多桑杜會免費為你施放奧術遮罩的咒語。你在銀色黎明中的聲望必須達到崇拜。"
Lang["Q1_8286"] = "明天的希望"			-- https://cn.tbc.wowhead.com/?quest=8286
Lang["Q2_8286"] = "到塔納利斯的時光之穴尋找諾茲多姆的子嗣安納克羅斯。"
Lang["Q1_8288"] = "唯一的領袖"			-- https://cn.tbc.wowhead.com/?quest=8288
Lang["Q2_8288"] = "到黑石山中的黑翼之巢去，殺死勒西雷爾，並帶回他的頭顱。\n\n將勒西雷爾的頭顱交给希利蘇斯塞納裡奧城堡的流沙守望者巴里斯托爾斯。"
Lang["Q1_8301"] = "正義之路"			-- https://cn.tbc.wowhead.com/?quest=8301
Lang["Q2_8301"] = "為流沙守望者巴里斯托爾斯收集200塊異種蠍殼碎片。"
Lang["Q1_8303"] = "阿納克洛斯"			-- https://cn.tbc.wowhead.com/?quest=8303
Lang["Q2_8303"] = "到塔納利斯的時光之穴去尋找阿納克洛斯。"
Lang["Q1_8305"] = "久遠的記憶"			-- https://cn.tbc.wowhead.com/?quest=8305
Lang["Q2_8305"] = "找到希利蘇斯的水晶之淚，並凝視它。"
Lang["Q1_8519"] = "往日的回憶"			-- https://cn.tbc.wowhead.com/?quest=8519
Lang["Q2_8519"] = "了解所有可以了解的關於的過去的事情，然後和塔納利斯時光之穴的阿納克洛斯談談。"
Lang["Q1_8555"] = "守護之龍"			-- https://cn.tbc.wowhead.com/?quest=8555
Lang["Q2_8555"] = "伊蘭尼庫斯、瓦拉斯塔兹、和艾索雷葛斯……你的確知道這些龍，凡人。這不是巧合，他們看守我們的世界，扮演著如此有影響力的角色。\n\n不幸的是(有部份也要怪我涉世未深)不論是上古諸神的密探或者稱他們為朋友的背叛者，每個首位都淪陷了。其程度只加深了我對你的種族的不信任。\n\n找到他们……，做好最壞的準備吧。"
Lang["Q1_8730"] = "奈法里奥斯的腐蝕"			-- https://cn.tbc.wowhead.com/?quest=8730
Lang["Q2_8730"] = "殺死奈法利安，並拿到红色節杖碎片。把红色節杖碎片交给塔納利斯時光之穴入口處的阿納克洛斯。你必須在5小時之內完成這個任務。"
Lang["Q1_8733"] = "伊蘭尼庫斯，夢境之暴君"			-- https://cn.tbc.wowhead.com/?quest=8733
Lang["Q2_8733"] = "到達納蘇斯的城牆外去找到瑪法里恩的親信。"
Lang["Q1_8734"] = "泰蘭達和雷姆洛斯"			-- https://cn.tbc.wowhead.com/?quest=8734
Lang["Q2_8734"] = "到月光林地去，和守護者雷姆洛斯談一談。"
Lang["Q1_8735"] = "腐蝕夢魘"			-- https://cn.tbc.wowhead.com/?quest=8735
Lang["Q2_8735"] = "到艾澤拉斯世界的四個翡翠夢境入口去，分别收集該處的腐蝕夢魘的碎片。當你任務完成之後，就回到月光林地的守護者雷姆洛斯那裡。"
Lang["Q1_8736"] = "噩夢顯現"			-- https://cn.tbc.wowhead.com/?quest=8736
Lang["Q2_8736"] = "保護永夜港免受伊蘭尼庫斯的傷害。不要讓守護者雷姆洛斯死亡。不要殺掉伊蘭尼庫斯。保護好你們自己。等待泰蘭達。"
Lang["Q1_8741"] = "勇士歸來"			-- https://cn.tbc.wowhead.com/?quest=8741
Lang["Q2_8741"] = "把綠色節杖碎片交给塔納利斯時光之穴的阿納克洛斯。"
Lang["Q1_8575"] = "艾索雷葛斯的魔法帳本"			-- https://cn.tbc.wowhead.com/?quest=8575
Lang["Q2_8575"] = "把魔法帳本交给塔納利斯的納瑞安。"
Lang["Q1_8576"] = "翻譯龍語"			-- https://cn.tbc.wowhead.com/?quest=8576
Lang["Q2_8576"] = "先處理當務之急，我們必須搞清楚艾索雷葛斯到底在石板上寫了什麽。\n\n你說它叫你做一個奧金浮標而這只是個概要圖嗎?可是他會用龍語寫還真奇怪。那個討厭的老傢伙知道我看不懂這亂七八糟的文字。\n\n如果有用的話，我需要我的水晶球護目鏡，一隻500磅的雞和〝龍語傻瓜教程〞第二卷。不需要按照順序。"
Lang["Q1_8597"] = "龍語傻瓜教程"			-- https://cn.tbc.wowhead.com/?quest=8597
Lang["Q2_8597"] = "尋找納瑞安埋在南海的某座小島上的書。"
Lang["Q1_8599"] = "唱给納瑞安的情歌"			-- https://cn.tbc.wowhead.com/?quest=8599
Lang["Q2_8599"] = "把米莉蒂私的情書交给塔納利斯的納瑞安。"
Lang["Q1_8598"] = "敲詐"			-- https://cn.tbc.wowhead.com/?quest=8598
Lang["Q2_8598"] = "把勒索信交给塔納利斯的納瑞安。"
Lang["Q1_8606"] = "螳螂捕蟬！"			-- https://cn.tbc.wowhead.com/?quest=8606
Lang["Q2_8606"] = "塔納利斯的納瑞安要你去冬泉谷，把一袋金子放在绑匪的勒索信上所寫的位置。他還要求你教訓一下那些傢伙！"
Lang["Q1_8620"] = "唯一的方案"			-- https://cn.tbc.wowhead.com/?quest=8620
Lang["Q2_8620"] = "把8章《龍語傻瓜教程》的章節用魔法書封面合起来，然後把完整的《龍語傻瓜教程：第二卷》交给塔納利斯的納瑞安。"
Lang["Q1_8584"] = "少管閒事"			-- https://cn.tbc.wowhead.com/?quest=8584
Lang["Q2_8584"] = "塔納利斯的納瑞安讓你和加基森的迪爾格·奎克里弗談一談。"
Lang["Q1_8585"] = "恐怖之島！"			-- https://cn.tbc.wowhead.com/?quest=8585
Lang["Q2_8585"] = "加基森的迪爾格·奎克里弗要你去菲拉斯的恐怖之島擊殺拉克麥拉，獲得拉克麥拉的屍體，並從島上收集20份奇美洛克的腰肋肉。"
Lang["Q1_8586"] = "迪爾格的超美味奇美拉肉片"			-- https://cn.tbc.wowhead.com/?quest=8586
Lang["Q2_8586"] = "加基森的迪爾格·奎克里弗要你給他帶去20份地精火箭燃油和20份石中鹽。"
Lang["Q1_8587"] = "向納瑞安回覆"			-- https://cn.tbc.wowhead.com/?quest=8587
Lang["Q2_8587"] = "把500磅的小雞交给塔納利斯的納瑞安。"
Lang["Q1_8577"] = "斯圖沃爾，前任死黨"			-- https://cn.tbc.wowhead.com/?quest=8577
Lang["Q2_8577"] = "納瑞安要你找到他的前任死黨斯圖沃爾，從他那裡拿回從納瑞安那裡偷走的占卜眼鏡。"
Lang["Q1_8578"] = "占卜眼鏡？沒問題！"			-- https://cn.tbc.wowhead.com/?quest=8578
Lang["Q2_8578"] = "找到納瑞安的占卜眼鏡。"
Lang["Q1_8728"] = "好消息和壞消息"			-- https://cn.tbc.wowhead.com/?quest=8728
Lang["Q2_8728"] = "塔納利斯的納瑞安要你給他帶去20塊奥金錠、10塊原質礦石、10顆艾澤拉斯鑽石，以及10顆藍寶石。"
Lang["Q1_8729"] = "耐普圖洛斯的憤怒"			-- https://cn.tbc.wowhead.com/?quest=8729
Lang["Q2_8729"] = "在艾薩拉風暴海灣一帶的湍急的漩渦處使用奥金魚標。"
Lang["Q1_8742"] = "卡利姆多的力量"			-- https://cn.tbc.wowhead.com/?quest=8742
Lang["Q2_8742"] = "一千年過去了，正如命中注定的那樣，一位勇士站在了我的面前。這位勇士將會帶領他的人民走向新的紀元。\n\n上古之神在顫抖，是的，它在你堅定的信念面前恐懼地顫抖著。打破克蘇恩的預言吧。\n\它知道你會到來的，勇士―它還知道卡利姆多的力量與你同在。當你做好準備之後，請通知我，我將把流沙節杖賜予你。"
Lang["Q1_8745"] = "時光之王的財寶"			-- https://cn.tbc.wowhead.com/?quest=8745
Lang["Q2_8745"] = "你好，勇士。我是神聖之鑼和青銅龍軍團的永恆觀察者，喬納森。\n\n永恆之王授權我讓你從他永恆的寶物箱裡選擇一樣物品。願它能在你對抗克蘇恩的戰役中幫助你。"


-- QUESTS - TBC
Lang["Q1_10755"] = "進入堡壘"			-- https://cn.tbc.wowhead.com/?quest=10755
Lang["Q2_10755"] = "將原始鑰匙模子帶去給地獄火半島上索爾瑪的納茲格雷爾。"
Lang["Q1_10756"] = "洛赫克大師"			-- https://cn.tbc.wowhead.com/?quest=10756
Lang["Q2_10756"] = "將原始鑰匙模子交給索爾瑪的洛赫克。"
Lang["Q1_10757"] = "洛赫克的請求"			-- https://cn.tbc.wowhead.com/?quest=10757
Lang["Q2_10757"] = "帶4個魔鐵錠，2個魔塵和4個火焰微粒回到地獄火半島的索爾瑪交給洛赫克。"
Lang["Q1_10758"] = "比地獄還熱"			-- https://cn.tbc.wowhead.com/?quest=10758
Lang["Q2_10758"] = "在地獄火半島破壞一部惡魔劫奪者，並且將未淬火的鑰匙模插入它的殘骸裡。將燒焦的鑰匙模型帶到洛赫克給索爾瑪。"
Lang["Q1_10754"] = "進入堡壘"			-- https://cn.tbc.wowhead.com/?quest=10754
Lang["Q2_10754"] = "將原始鑰匙模子帶去給地獄火半島上榮譽堡的軍隊指揮官達納斯。"
Lang["Q1_10762"] = "戴夫利大師"			-- https://cn.tbc.wowhead.com/?quest=10762
Lang["Q2_10762"] = "將原始鑰匙模子交給榮譽堡的戴夫利。"
Lang["Q1_10763"] = "戴夫利的請求"			-- https://cn.tbc.wowhead.com/?quest=10763
Lang["Q2_10763"] = "帶4個魔鐵錠，2個魔塵和4個火焰微粒回到地獄火半島的榮譽堡給戴夫利。"
Lang["Q1_10764"] = "比地獄還熱"			-- https://cn.tbc.wowhead.com/?quest=10764
Lang["Q2_10764"] = "在地獄火半島破壞一部惡魔劫奪者，並且將未淬火的鑰匙模插入它的殘骸裡。將燒焦的鑰匙模型帶到榮譽堡給戴夫利。"
Lang["Q1_10279"] = "前往主人的巢穴"			-- https://cn.tbc.wowhead.com/?quest=10279
Lang["Q2_10279"] = "與時光之穴的安杜姆談談。"
Lang["Q1_10277"] = "時光之穴"			-- https://cn.tbc.wowhead.com/?quest=10277
Lang["Q2_10277"] = "在時光之穴的安杜姆要你跟隨洞穴附近的時間管理人。"
Lang["Q1_10282"] = "舊時的希爾斯布萊德"			-- https://cn.tbc.wowhead.com/?quest=10282
Lang["Q2_10282"] = "時光之穴的安杜姆要你到希爾斯布萊德丘陵去跟伊洛森談談。"
Lang["Q1_10283"] = "塔蕾莎的聲東擊西"			-- https://cn.tbc.wowhead.com/?quest=10283
Lang["Q2_10283"] = "前往敦霍爾德城堡，使用伊洛森交給你的燃燒炸彈包裹，在每一個拘留守衛室裡的桶中放置5個燃燒炸藥。\n\n當你引爆拘留守衛室後，與敦霍爾德城堡地牢裡的索爾談談。"
Lang["Q1_10284"] = "逃離敦霍爾德"			-- https://cn.tbc.wowhead.com/?quest=10284
Lang["Q2_10284"] = "當你準備開始時，讓索爾知道。跟著索爾離開敦霍爾德城堡，並協助他釋放塔蕾莎以及完成他的天命。\n\n任務完成後到希爾斯布萊德找伊洛森談談。"
Lang["Q1_10285"] = "回去安杜姆身邊"			-- https://cn.tbc.wowhead.com/?quest=10285
Lang["Q2_10285"] = "回去塔納利斯沙漠的時光之穴找小孩安杜姆。"
Lang["Q1_10265"] = "聯合團水晶收集"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10265
Lang["Q2_10265"] = "取得阿克隆水晶手工品，並且將它帶回虛空風暴的52區交給虛空巡者凱澤。"
Lang["Q1_10262"] = "一堆以太族"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10262
Lang["Q2_10262"] = "收集10枚薩希斯徽記，並且將它們帶回虛空風暴的52區交給虛空巡者凱澤。"
Lang["Q1_10205"] = "星移劫掠者尼薩德"			-- https://cn.tbc.wowhead.com/?quest=10205
Lang["Q2_10205"] = "殺掉星移劫掠者尼薩德，完成後回到虛空風暴的52區找虛空巡者凱澤。"
Lang["Q1_10266"] = "要求幫助"			-- https://cn.tbc.wowhead.com/?quest=10266
Lang["Q2_10266"] = "尋找並提供加魯你的幫助。他就在虛空風暴的秘境領地裡的領地崗哨。"
Lang["Q1_10267"] = "合法的回收"			-- https://cn.tbc.wowhead.com/?quest=10267
Lang["Q2_10267"] = "收集10箱勘探設備帶回虛空風暴秘境領地的領地崗哨給加魯。"
Lang["Q1_10268"] = "晉見王子"			-- https://cn.tbc.wowhead.com/?quest=10268
Lang["Q2_10268"] = "將勘探設備送到虛空風暴的風暴之尖交給奈薩斯王子哈拉瑪德的影像。"
Lang["Q1_10269"] = "三角測量點之一"			-- https://cn.tbc.wowhead.com/?quest=10269
Lang["Q2_10269"] = "使用三角裝置指引你前往第一個三角測量點的方向。一旦你找到它，把位置報告給虛空風暴法力熔爐奧崔斯島上護國者哨站的商人海辛。"
Lang["Q1_10275"] = "三角測量點之二"			-- https://cn.tbc.wowhead.com/?quest=10275
Lang["Q2_10275"] = "使用三角裝置指引你前往第二個三角測量點的方向。一旦你找到它，將位置報告給在虛空風暴的吐魯曼平臺的風之貿易者吐魯曼，他就在從法力熔爐艾拉島出來的橋的另一邊。"
Lang["Q1_10276"] = "完整三角形"			-- https://cn.tbc.wowhead.com/?quest=10276
Lang["Q2_10276"] = "取回阿塔莫水晶並且將它帶到虛空風暴的風暴之尖交給奈薩斯王子哈拉瑪德的影像。"
Lang["Q1_10280"] = "給撒塔斯城的特件"			-- https://cn.tbc.wowhead.com/?quest=10280
Lang["Q2_10280"] = "將阿塔莫水晶送交到撒塔斯城的聖光露臺交給阿達歐。"
Lang["Q1_10704"] = "闖入亞克崔茲的方法"			-- https://cn.tbc.wowhead.com/?quest=10704
Lang["Q2_10704"] = "阿達歐派你去取得亞克崔茲鑰匙的頂部和底部裂片。將它們帶回去給他，他會將他們合成亞克崔茲鑰匙後交給你。"
Lang["Q1_9824"] = "秘法干擾"			-- https://cn.tbc.wowhead.com/?quest=9824
Lang["Q2_9824"] = "到大師的地窖，在靠近地下水源的地方使用紫羅蘭占卜水晶再回到卡拉贊外面的大法師艾特羅斯那裡。"
Lang["Q1_9825"] = "不安的活動"			-- https://cn.tbc.wowhead.com/?quest=9825
Lang["Q2_9825"] = "帶10個鬼魅精華給卡拉贊外面的大法師艾特羅斯。"
Lang["Q1_9826"] = "達拉然的聯繫"			-- https://cn.tbc.wowhead.com/?quest=9826
Lang["Q2_9826"] = "將艾特羅斯的報告帶給達拉然陷坑郊區的大法師賽卓克。"
Lang["Q1_9829"] = "卡德加"			-- https://cn.tbc.wowhead.com/?quest=9829
Lang["Q2_9829"] = "將艾特羅斯的報告送到泰洛卡森林給撒塔斯城的卡德加。"
Lang["Q1_9831"] = "卡拉贊的入口"			-- https://cn.tbc.wowhead.com/?quest=9831
Lang["Q2_9831"] = "卡德加要你進入奧齊頓的暗影迷宮並從藏在那裡的秘法容器取得第一塊鑰匙碎片。"
Lang["Q1_9832"] = "第二和第三個碎片"			-- https://cn.tbc.wowhead.com/?quest=9832
Lang["Q2_9832"] = "在盤牙蓄湖的秘法容器裡取得第二塊鑰匙碎片，風暴要塞的秘法容器裡取得第三塊鑰匙碎片。完成任務後回到撒塔斯城的卡德加那裡。"
Lang["Q1_9836"] = "大師之觸"			-- https://cn.tbc.wowhead.com/?quest=9836
Lang["Q2_9836"] = "進入時光之穴說服麥迪文讓復原的初生之鑰恢復能力。"
Lang["Q1_9837"] = "回到卡德加那裡"			-- https://cn.tbc.wowhead.com/?quest=9837
Lang["Q2_9837"] = "回到撒塔斯城的卡德加那裡並給他大師之鑰。"
Lang["Q1_9838"] = "紫羅蘭之眼"			-- https://cn.tbc.wowhead.com/?quest=9838
Lang["Q2_9838"] = "和卡拉贊外的大法師艾特羅斯談談。"
Lang["Q1_9630"] = "麥迪文的日記"			-- https://cn.tbc.wowhead.com/?quest=9630
Lang["Q2_9630"] = "逆風小徑的大法師艾特羅斯要你進入卡拉贊並和瑞依恩談談。"
Lang["Q1_9638"] = "妥善保管"			-- https://cn.tbc.wowhead.com/?quest=9638
Lang["Q2_9638"] = "到卡拉贊和守護者圖書館的葛瑞戴談談。"
Lang["Q1_9639"] = "康席斯"			-- https://cn.tbc.wowhead.com/?quest=9639
Lang["Q2_9639"] = "到卡拉贊和守護者圖書館的康席斯談談。"
Lang["Q1_9640"] = "埃蘭之影"			-- https://cn.tbc.wowhead.com/?quest=9640
Lang["Q2_9640"] = "取得麥迪文的日記並帶到卡拉贊的守護者圖書館交給康席斯。"
Lang["Q1_9645"] = "大師的露臺"			-- https://cn.tbc.wowhead.com/?quest=9645
Lang["Q2_9645"] = "前往卡拉贊的大師的露臺並閱讀麥迪文的日記。完成任務後將麥迪文的日記交給大法師艾特羅斯。"
Lang["Q1_9680"] = "挖掘历史"			-- https://cn.tbc.wowhead.com/?quest=9680
Lang["Q2_9680"] = "大法師艾特羅斯要你去卡拉贊南方山脈的逆風小徑取回一個燒焦的白骨碎片。"
Lang["Q1_9631"] = "朋友的協助"			-- https://cn.tbc.wowhead.com/?quest=9631
Lang["Q2_9631"] = "將燒焦的白骨碎片帶給虛空風暴的凱娜·拉斯蕊德。"
Lang["Q1_9637"] = "凱娜的要求"			-- https://cn.tbc.wowhead.com/?quest=9637
Lang["Q2_9637"] = "凱娜·拉斯蕊德要你到地獄火堡壘的破碎大廳，從大術士奈德克斯那裡取得黑暗之書，再到奧齊頓的塞司克大廳，從暗織者希斯那裡取得遺忘之名魔典。這個任務必須在英雄難度中完成。"
Lang["Q1_9644"] = "夜禍"			-- https://cn.tbc.wowhead.com/?quest=9644
Lang["Q2_9644"] = "前往卡拉贊大師的露臺並碰觸燻黑的骨灰甕來召喚夜禍。從夜禍的屍體取得微弱的秘法精華並帶給大法師艾特羅斯。"
Lang["Q1_10901|13431"] = "卡德許的鬥棍"			-- https://cn.tbc.wowhead.com/?quest=10901|13431
Lang["Q2_10901|13431"] = "盤牙蓄湖中奴隸監獄的『異端』司卡利斯要你帶給他土靈徽記和熾烈徽記。"
Lang["Q1_10900"] = "瓦許的印記"			-- https://cn.tbc.wowhead.com/?quest=10900
Lang["Q2_10900"] = ""
Lang["Q1_10681"] = "古爾丹火山"			-- https://cn.tbc.wowhead.com/?quest=10681
Lang["Q2_10681"] = "跟影月谷詛咒祭壇的大地治癒者托爾洛克交談。"
Lang["Q1_10458"] = "火與大地的暴怒之靈"			-- https://cn.tbc.wowhead.com/?quest=10458
Lang["Q2_10458"] = "影月谷裡詛咒祭壇的大地治癒者托爾洛克要你使用靈魂圖騰捕捉8個土靈之魂及8個熾熱之魂"
Lang["Q1_10480"] = "暴怒的水靈"			-- https://cn.tbc.wowhead.com/?quest=10480
Lang["Q2_10480"] = "影月谷的詛咒祭壇的大地治癒者托爾洛克要你使用靈魂圖騰去捕獲5個水之魂。"
Lang["Q1_10481"] = "暴怒的風之靈"			-- https://cn.tbc.wowhead.com/?quest=10481
Lang["Q2_10481"] = "影月谷的詛咒祭壇的大地治癒者托爾洛克要你使用靈魂圖騰去捕獲10個大氣之魂。"
Lang["Q1_10513"] = "歐朗諾克·碎心"			-- https://cn.tbc.wowhead.com/?quest=10513
Lang["Q2_10513"] = "到破碎暗礁去找歐朗諾克·碎心 - 就在考斯卡水池的北方。"
Lang["Q1_10514"] = "我經歷過很多事..."			-- https://cn.tbc.wowhead.com/?quest=10514
Lang["Q2_10514"] = "影月谷內歐朗諾克的農場的歐朗諾克·碎心要你去破碎平原取回10個影月塊莖。\n\n他也要你在完成任務後將歐朗諾克的野豬哨帶回來。"
Lang["Q1_10515"] = "學到一課"			-- https://cn.tbc.wowhead.com/?quest=10515
Lang["Q2_10515"] = "影月谷內歐朗諾克的農場的歐朗諾克·碎心要你去破碎平原破壞10個掠食鐮奪怪的蛋。"
Lang["Q1_10519"] = "毀滅密碼 - 歷史與真相"			-- https://cn.tbc.wowhead.com/?quest=10519
Lang["Q2_10519"] = "影月谷裡歐朗諾克的農場的歐朗諾克·碎心要你聆聽他的故事。"
Lang["Q1_10521"] = "葛洛姆特，歐朗諾克之子"			-- https://cn.tbc.wowhead.com/?quest=10521
Lang["Q2_10521"] = "在影月谷的考斯卡崗哨找到葛洛姆特，歐朗諾克之子。"
Lang["Q1_10527"] = "阿爾托，歐朗諾克之子"			-- https://cn.tbc.wowhead.com/?quest=10527
Lang["Q2_10527"] = "在影月谷的伊利達瑞崗哨找到阿爾托，歐朗諾克之子。"
Lang["Q1_10546"] = "柏爾拉克，歐朗諾克之子"			-- https://cn.tbc.wowhead.com/?quest=10546
Lang["Q2_10546"] = "到影月谷的日蝕崗哨附近尋找柏爾拉克，歐朗諾克之子。"
Lang["Q1_10522"] = "毀滅密碼 - 葛洛姆特的命令"			-- https://cn.tbc.wowhead.com/?quest=10522
Lang["Q2_10522"] = "在影月谷考斯卡崗哨的葛洛姆特，歐朗諾克之子要你奪回毀滅密碼第一部。"
Lang["Q1_10528"] = "惡魔水晶囚牢"			-- https://cn.tbc.wowhead.com/?quest=10528
Lang["Q2_10528"] = "在伊利達瑞崗哨找到並殺掉痛苦魔女卡布利莎，拿著結晶鑰匙回到阿爾托，歐朗諾克之子的屍體那。"
Lang["Q1_10547"] = "血薊與蛋"			-- https://cn.tbc.wowhead.com/?quest=10547
Lang["Q2_10547"] = "在日蝕崗哨北邊橋上的柏爾拉克, 歐朗諾克之子要你找到腐爛的阿拉卡蛋然後交給泰洛卡森林西北邊撒塔斯城的『骯髒暴食者』托比亞斯。"
Lang["Q1_10523"] = "毀滅密碼 - 取回第一部"			-- https://cn.tbc.wowhead.com/?quest=10523
Lang["Q2_10523"] = "帶著葛洛姆特的帶鎖箱到影月谷的歐朗諾克的農場給歐朗諾克·碎心。"
Lang["Q1_10537"] = "羅恩格隆，碎心之弓"			-- https://cn.tbc.wowhead.com/?quest=10537
Lang["Q2_10537"] = "影月谷內伊利達瑞崗哨的阿爾托之靈要你去從本地的惡魔手中取回羅恩格隆，碎心之弓。"
Lang["Q1_10550"] = "一捆血薊"			-- https://cn.tbc.wowhead.com/?quest=10550
Lang["Q2_10550"] = "將一捆血薊交給影月谷的日蝕崗哨附近橋上的柏爾拉克，歐朗諾克之子。"
Lang["Q1_10540"] = "毀滅密碼 - 阿爾托的命令"			-- https://cn.tbc.wowhead.com/?quest=10540
Lang["Q2_10540"] = "影月谷中伊利達瑞崗哨的阿爾托之靈要你從『百觸』威納拉圖斯邊取回毀滅密碼第二部。\n\n遭受幽魂獵手攻擊或傷害的生物將無法獲得戰利品或經驗值。"
Lang["Q1_10570"] = "血薊花的陷阱"			-- https://cn.tbc.wowhead.com/?quest=10570
Lang["Q2_10570"] = "影月谷的日蝕崗哨附近橋上的柏爾拉克，歐朗諾克之子要你取回怒風信件。"
Lang["Q1_10576"] = "影月谷的潛行"			-- https://cn.tbc.wowhead.com/?quest=10576
Lang["Q2_10576"] = "位在影月谷靠近日蝕崗哨一座橋上的柏爾拉克, 歐朗諾克之子要你找回6件日蝕護甲。"
Lang["Q1_10577"] = "予取予求的伊利丹..."			-- https://cn.tbc.wowhead.com/?quest=10577
Lang["Q2_10577"] = "位在影月谷靠近日蝕崗哨的一座橋上的柏爾拉克, 歐朗諾克之子要你傳遞伊利丹的一段訊息給日蝕崗哨的大指揮官魯斯克。"
Lang["Q1_10578"] = "毀滅密碼 - 柏爾拉克的命令"			-- https://cn.tbc.wowhead.com/?quest=10578
Lang["Q2_10578"] = "影月谷的日蝕崗哨附近橋上的柏爾拉克，歐朗諾克之子要你從『晦暗者』魯歐身上奪回毀滅密碼第三部。"
Lang["Q1_10541"] = "毀滅密碼 - 取回第二部"			-- https://cn.tbc.wowhead.com/?quest=10541
Lang["Q2_10541"] = "將阿爾托的上鎖帶鎖箱交給影月谷裡歐朗諾克的農場的歐朗諾克·碎心。"
Lang["Q1_10579"] = "毀滅密碼 - 取回第三部"			-- https://cn.tbc.wowhead.com/?quest=10579
Lang["Q2_10579"] = "帶著柏爾拉克的帶鎖箱到影月谷的歐朗諾克的農場交給歐朗諾克·碎心。"
Lang["Q1_10588"] = "毀滅密碼"			-- https://cn.tbc.wowhead.com/?quest=10588
Lang["Q2_10588"] = "在詛咒祭壇使用毀滅密碼，召喚『火焰之王』賽洛庫。\n\n殺死火焰之王賽洛庫然後去跟大地治癒者托爾洛克談話，你同樣可以在詛咒祭壇找到他"
Lang["Q1_10883"] = "風暴之鑰"			-- https://cn.tbc.wowhead.com/?quest=10883
Lang["Q2_10883"] = "與撒塔斯城的阿達歐談談。"
Lang["Q1_10884"] = "那魯的試煉：寬容"			-- https://cn.tbc.wowhead.com/?quest=10884
Lang["Q2_10884"] = "撒塔斯城的阿達歐要你自地獄火堡壘的破碎大廳取回劊子手的廢棄之斧。\n\n此任務必須在英雄難度的地城裡完成。"
Lang["Q1_10885"] = "那魯的試煉：力量"			-- https://cn.tbc.wowhead.com/?quest=10885
Lang["Q2_10885"] = "撒塔斯城的阿達歐要你去取回卡利斯瑞的三叉戟和莫爾墨的精華。\n\n此任務必須在英雄難度的地城裡完成。"
Lang["Q1_10886"] = "那魯的試煉：堅毅"			-- https://cn.tbc.wowhead.com/?quest=10886
Lang["Q2_10886"] = "撒塔斯城的阿達歐要你去援救來自風暴要塞，亞克崔茲的米歐浩斯·曼納斯頓。\n\n此任務必須在英雄難度的地城裡完成。"
Lang["Q1_10888|13430"] = "那魯的試煉：瑪瑟里頓"			-- https://cn.tbc.wowhead.com/?quest=10888|13430
Lang["Q2_10888|13430"] = "撒塔斯城的阿達歐要你殺死瑪瑟里頓。"
Lang["Q1_10680"] = "古爾丹火山"			-- https://cn.tbc.wowhead.com/?quest=10680
Lang["Q2_10680"] = "跟影月谷詛咒祭壇的大地治癒者托爾洛克交談。"
Lang["Q1_10445|13432"] = "永恆之瓶"			-- https://cn.tbc.wowhead.com/?quest=10445|13432
Lang["Q2_10445|13432"] = "時光之穴的索芮朵蜜要你去從盤牙蓄湖的瓦許女士身上取得瓦許的殘存之瓶，從風暴要塞的凱爾薩斯·逐日者身上取得凱爾薩斯的殘存之瓶。"
Lang["Q1_10568"] = "巴瑞碑文"			-- https://cn.tbc.wowhead.com/?quest=10568
Lang["Q2_10568"] = "薩塔祭壇的隱士希拉要你去巴瑞廢墟從地上或者灰舌勞工的身上收集12個巴瑞碑文。\n\n為奧多爾完成任務會讓你的占卜者聲望降低。"
Lang["Q1_10683"] = "巴瑞碑文"			-- https://cn.tbc.wowhead.com/?quest=10683
Lang["Q2_10683"] = "星光聖所的秘法師賽利斯要你去巴瑞廢墟從地上及灰舌勞工身上收集12個巴瑞碑文。\n\n為占卜者完成任務會讓你的奧多爾聲望降低。"
Lang["Q1_10571"] = "長者奧洛努"			-- https://cn.tbc.wowhead.com/?quest=10571
Lang["Q2_10571"] = "薩塔祭壇的隱士希拉要你去巴瑞廢墟的長者奧洛努手中奪得阿卡瑪的命令。\n\n為奧多爾完成任務會讓你的占卜者聲望降低。"
Lang["Q1_10684"] = "長者奧洛努"			-- https://cn.tbc.wowhead.com/?quest=10684
Lang["Q2_10684"] = "星光聖所的秘法師賽利斯要你去巴瑞廢墟的長者奧洛努手中奪得阿卡瑪的命令。\n\n為占卜者完成任務會讓你的奧多爾聲望降低。"
Lang["Q1_10574"] = "灰舌墮落者"			-- https://cn.tbc.wowhead.com/?quest=10574
Lang["Q2_10574"] = "從哈盧姆，伊肯尼恩，拉卡恩和烏拉魯那邊取回四個勳章碎片然後回到影月谷的薩塔祭壇找隱士希拉。\n\n為奧多爾完成任務會使你的占卜者聲望降低。"
Lang["Q1_10685"] = "灰舌墮落者"			-- https://cn.tbc.wowhead.com/?quest=10685
Lang["Q2_10685"] = "從哈盧姆，伊肯尼恩，拉卡恩和烏拉魯那邊取回四個勳章碎片然後回到影月谷的星光聖所的秘法師賽利斯。\n\n為占卜者完成任務會讓你的奧多爾聲望降低。"
Lang["Q1_10575"] = "典獄官監牢"			-- https://cn.tbc.wowhead.com/?quest=10575
Lang["Q2_10575"] = "隱士希拉要求你進入巴瑞廢墟以南的典獄官監牢，從薩諾魯口中審問出阿卡瑪的下落。\n\n為奧多爾完成任務會讓你的占卜者聲望降低。"
Lang["Q1_10686"] = "典獄官監牢"			-- https://cn.tbc.wowhead.com/?quest=10686
Lang["Q2_10686"] = "秘法師賽利斯要求你進入巴瑞廢墟以南的典獄官監牢，從薩諾魯口中審問出阿卡瑪的下落。\n\n為占卜者完成任務會讓你的奧多爾聲望降低。"
Lang["Q1_10622"] = "忠誠的證明"			-- https://cn.tbc.wowhead.com/?quest=10622
Lang["Q2_10622"] = "殺死影月谷内典獄官監牢的杉德拉斯，然後向薩諾魯覆命。"
Lang["Q1_10628"] = "阿卡瑪"			-- https://cn.tbc.wowhead.com/?quest=10628
Lang["Q2_10628"] = "與典獄官監牢的密室中的阿卡瑪談一談。"
Lang["Q1_10705"] = "先知烏達羅"			-- https://cn.tbc.wowhead.com/?quest=10705
Lang["Q2_10705"] = "到風暴要塞的亞克崔茲找到先知烏達羅。"
Lang["Q1_10706"] = "神秘的前兆"			-- https://cn.tbc.wowhead.com/?quest=10706
Lang["Q2_10706"] = "回到影月谷的典獄官監牢找阿卡瑪。"
Lang["Q1_10707"] = "阿塔莫露臺"			-- https://cn.tbc.wowhead.com/?quest=10707
Lang["Q2_10707"] = "到影月谷內阿塔莫露臺的頂端取得狂怒之心。完成任務後回到影月谷的典獄官監牢找阿卡瑪。"
Lang["Q1_10708"] = "阿卡瑪的保證"			-- https://cn.tbc.wowhead.com/?quest=10708
Lang["Q2_10708"] = "將卡拉伯爾勳章交給撒塔斯城的阿達歐。"
Lang["Q1_10944"] = "保守的秘密"			-- https://cn.tbc.wowhead.com/?quest=10944
Lang["Q2_10944"] = "前往影月谷的典獄官監牢並且跟阿卡瑪交談。"
Lang["Q1_10946"] = "灰舌偽裝"			-- https://cn.tbc.wowhead.com/?quest=10946
Lang["Q2_10946"] = "前往風暴要塞並且戴上灰舌風帽殺死歐爾。完成任務後回到影月谷找阿卡瑪。"
Lang["Q1_10947"] = "古老的神器"			-- https://cn.tbc.wowhead.com/?quest=10947
Lang["Q2_10947"] = "前往塔納利斯的時光之穴並且進入海加爾山戰役。進入之後，擊敗瑞齊·凜冬並且將時間定相骨匣交給影月谷的阿卡瑪。"
Lang["Q1_10948"] = "靈魂之囚"			-- https://cn.tbc.wowhead.com/?quest=10948
Lang["Q2_10948"] = "前往塔斯城，將阿卡瑪的請求告訴阿達歐。"
Lang["Q1_10949"] = "進入黑暗神廟"			-- https://cn.tbc.wowhead.com/?quest=10949
Lang["Q2_10949"] = "前往影月谷的黑暗神廟，在入口處與希瑞談話。"
Lang["Q1_10985|13429"] = "幫助阿卡瑪"			-- https://cn.tbc.wowhead.com/?quest=10985|13429
Lang["Q2_10985|13429"] = "在克希利的軍隊發動佯攻之後，保護阿卡瑪和瑪維進入影月谷内的黑暗神廟。"
--v243
Lang["Q1_10984"] = "援助食人魔"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10984
Lang["Q2_10984"] = "與沙塔斯城貧民窟的食人魔格羅科爾談一談。"
Lang["Q1_10983"] = "枯瘦的莫戈多格"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10983
Lang["Q2_10983"] = "與枯瘦的莫戈多格談一談，他就在刀鋒山鮮血之環外的某座塔頂上。"
Lang["Q1_10995"] = "格魯洛克的巨龍顱骨"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10995
Lang["Q2_10995"] = "奪回格魯洛克的巨龍顱骨，將其交給刀鋒山鮮血之環塔頂上的枯瘦的莫戈多格。"
Lang["Q1_10996"] = "瑪古克的寶箱"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10996
Lang["Q2_10996"] = "奪取瑪古克的寶箱，將它交給刀鋒山鮮血之環塔頂上的枯瘦的莫戈多格。"
Lang["Q1_10997"] = "戈隆的軍旗"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10997
Lang["Q2_10997"] = "奪取斯萊格的軍旗，將其交給刀鋒山鮮血之環塔頂上的枯瘦的莫戈多格。"
Lang["Q1_10998"] = "維姆高爾的魔典"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10998
Lang["Q2_10998"] = "奪取維姆高爾的魔典，並將它帶回刀鋒山內鮮血之環的塔頂上，交給枯瘦的莫戈多格。"
Lang["Q1_11000"] = "磨魂者"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11000
Lang["Q2_11000"] = "奪得斯古洛克的靈魂，然後返回刀鋒山的鮮血之環，將它交給塔樓頂部的枯瘦的莫戈多格。"
Lang["Q1_11022"] = "與莫戈多格會面"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11022
Lang["Q2_11022"] = "與枯瘦的莫戈多格談一談，他就在刀鋒山鮮血之環東側的塔樓頂部。"
Lang["Q1_11009"] = "食人魔的天堂"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11009
Lang["Q2_11009"] = "枯瘦的莫戈多格要求你與刀鋒山奧格瑞拉的庫洛爾談一談。"
--v244
Lang["Q1_10804"] = "友善"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10804
Lang["Q2_10804"] = "影月谷靈翼平原的莫德奈要你餵養8只成熟的靈翼幼龍。"
Lang["Q1_10811"] = "尋找奈爾薩拉庫"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10811
Lang["Q2_10811"] = "尋找奈爾薩拉庫，虛空龍族的領袖。"
Lang["Q1_10814"] = "奈爾薩拉庫的故事"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10814
Lang["Q2_10814"] = "與奈爾薩拉庫談一談，聽聽他的故事。"
Lang["Q1_10836"] = "攻擊龍喉要塞"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10836
Lang["Q2_10836"] = "殺死15名龍喉獸人，然後向飛翔在影月谷靈翼平原上空的奈爾薩拉庫復命。"
Lang["Q1_10837"] = "前往靈翼浮島！"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10837
Lang["Q2_10837"] = "前往靈翼浮島收集12枚靈藤水晶，然後向飛翔在影月谷靈翼平原上空的奈爾薩拉庫復命。"
Lang["Q1_10854"] = "奈爾薩拉庫之力"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10854
Lang["Q2_10854"] = "解救5只被奴役的靈翼幼龍，然後向飛翔在影月谷靈翼平原上空的奈爾薩拉庫復命。"
Lang["Q1_10858"] = "卡瑞納庫"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10858
Lang["Q2_10858"] = "前往龍喉要塞，尋找卡瑞納庫。"
Lang["Q1_10866"] = "疲憊的祖魯希德"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10866
Lang["Q2_10866"] = "殺死疲憊的祖魯希德，取回祖魯希德的鑰匙，並用它打開祖魯希德的鎖鏈，釋放卡瑞納庫。"
Lang["Q1_10870"] = "靈翼之盟"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10870
Lang["Q2_10870"] = "让卡瑞纳库把你送回灵翼平原的莫德奈身边。"
--v247
Lang["Q1_3801"] = "黑鐵的遺產"		
Lang["Q2_3801"] = "如果你想要得到進入這座城市主城區的鑰匙，就去和弗蘭克羅恩·鑄鐵談一談。"
Lang["Q1_3802"] = "黑鐵的遺產"		
Lang["Q2_3802"] = "殺掉弗諾斯·達克維爾並拿回戰鎚鐵膽。把鐵膽之鎚拿到索瑞森神殿去，將其放在弗蘭克羅恩·鑄鐵的雕像上。"
Lang["Q1_5096"] = "誤導血色十字軍"
Lang["Q2_5096"] = "到血色十字軍建在費爾斯通農場和達爾松之淚之間的營地去，摧毀他們的指揮帳篷。"
Lang["Q1_5098"] = "標記哨塔"
Lang["Q2_5098"] = "使用信號火炬為安多哈爾城中的四座哨塔做上標記，你必須站在哨塔門口才能成功地進行標記。"
Lang["Q1_838"] = "通靈學院"
Lang["Q2_838"] = "和西瘟疫之地亡靈壁壘的藥劑師迪瑟斯談一談。"
Lang["Q1_964"] = "骸骨碎片"
Lang["Q2_964"] = "將15塊骸骨碎片交給西瘟疫之地亡靈壁壘的藥劑師迪瑟斯。"
Lang["Q1_5514"] = "昂貴的模具"
Lang["Q2_5514"] = "把灌魔的骸骨碎片和15枚金幣交給加基森的克林科·古德斯迪爾。"
Lang["Q1_5802"] = "火羽山"
Lang["Q2_5802"] = "把骷髏鑰匙模具和2塊瑟銀錠帶到安戈洛爾環形山地區的火羽山頂部。在熔岩湖旁使用骷髏鑰匙模具，鑄造出一把未完工的骷髏鑰匙。"
Lang["Q1_5804"] = "阿拉基的聖甲蟲"
Lang["Q2_5804"] = "殺掉召喚者阿拉基，並將阿拉基的聖甲蟲交給西瘟疫之地亡靈壁壘的藥劑師迪瑟斯。"
Lang["Q1_5511"] = "通靈學院的鑰匙"
Lang["Q2_5511"] = "好吧，你在這裡 - 完成的萬能鑰匙。我可以肯定，這把鑰匙會讓你在通靈學院的範圍內。"
Lang["Q1_5092"] = "掃清道路"
Lang["Q2_5092"] = "殺掉悔恨嶺中的10個骷髏剝皮者和10個被奴役的食屍鬼。"
Lang["Q1_5097"] = "標記哨塔"
Lang["Q2_5097"] = "使用信號火炬為安多哈爾城中的四座哨塔做上標記，你必須站在哨塔門口才能成功地進行標記。"
Lang["Q1_5533"] = "通靈學院"
Lang["Q2_5533"] = "和西瘟疫之地冰風崗的化學家阿爾比頓談一談。"
Lang["Q1_5537"] = "骸骨碎片"
Lang["Q2_5537"] = "將15塊骷髏碎片交給西瘟疫之地冰風崗的化學家阿爾比頓。"
Lang["Q1_5538"] = "昂貴的模具"
Lang["Q2_5538"] = "把灌魔的骸骨碎片和15枚金幣交給加基森的克林科·古德斯迪爾。"
Lang["Q1_5801"] = "火羽山"
Lang["Q2_5801"] = "把骷髏鑰匙模具和2塊瑟銀錠帶到安戈洛爾環形山地區的火羽山頂部。在熔岩湖旁使用骷髏鑰匙模具，鑄造出一把未完工的骷髏鑰匙。"
Lang["Q1_5803"] = "阿拉基的聖甲蟲"
Lang["Q2_5803"] = "殺掉召喚者阿拉基，並將阿拉基的聖甲蟲交給西瘟疫之地冰風崗的化學家阿爾比頓。"
Lang["Q1_5505"] = "通靈學院的鑰匙"
Lang["Q2_5505"] = "通靈學院的鑰好吧，你在這裡 - 完成的萬能鑰匙。我可以肯定，這把鑰匙會讓你在通靈學院的範圍內。匙"
--v250
Lang["Q1_6804"] = "被囚禁的水元素"
Lang["Q2_6804"] = "對東瘟疫之地的被感染的水元素使用海神之水。把12副不諧護腕和海神之水交給艾薩拉的海達克西斯公爵。"
Lang["Q1_6805"] = "雷暴和磐石"
Lang["Q2_6805"] = "殺死15個灰塵風暴和15個沙漠奔行者，然後回到艾薩拉的海達克西斯公爵那兒。"
Lang["Q1_6821"] = "艾博希爾之眼"
Lang["Q2_6821"] = "將艾博希爾之眼交給艾薩拉的海達克西斯公爵。"
Lang["Q1_6822"] = "熔火之心"
Lang["Q2_6822"] = "殺死一個火焰之王、一個熔岩巨人、一個上古熔火惡犬和一個熔岩奔騰者，然後回到艾薩拉的海達克西斯公爵那裡。"
Lang["Q1_6823"] = "海達克西斯的使者"
Lang["Q2_6823"] = "在海達希亞水元素中達到被尊敬的聲望，然後與艾薩拉的海達克西斯公爵談一談。"
Lang["Q1_6824"] = "敵人之手"
Lang["Q2_6824"] = "將魯西弗隆之手、薩弗隆之手、基赫納斯之手和沙斯拉爾之手交給艾薩拉的海達克西斯公爵。"
Lang["Q1_7486"] = "英雄的獎賞"
Lang["Q2_7486"] = "從海達克西斯的箱子拿取你的獎勵。"
--v254
Lang["Q1_11481"] = "太陽之井的危機"
Lang["Q2_11481"] = "沙塔斯城奧爾多高地的聖光護衛者阿德因要求你前往太陽之井高地，與主教拉雷索爾談一談。"
Lang["Q1_11488"] = "魔導師平台"
Lang["Q2_11488"] = "瑟里斯·黎明之心希望你找到在魔导师平台的主教拉雷索尔。"
Lang["Q1_11490"] = "占星球"
Lang["Q2_11490"] = "塔雷斯要求你使用魔導師平台內的陽台上的寶珠。"
Lang["Q1_11492"] = "大難不死"
Lang["Q2_11492"] = "卡雷苟斯要求你擊敗魔導師平台內的凱爾薩斯。取下凱爾薩斯的徽記之後，立刻向破碎殘陽基地的主教拉雷索爾復命。"


--WOTLK QUESTS
-- The ids are Q1_<QuestId> and Q2_<QuestId>
-- Q1 is just the title of the quest
-- Q2 is the description/synopsis, with some helpful comments in between \n\n|cff33ff99 and |r--WOTLK
Lang["Q1_12892"] = "樂趣十足"
Lang["Q2_12892"] = "摧毀魔眼，然後向暗影拱頂的斯利文男爵報告。"
Lang["Q1_12887"] = "樂趣十足"
Lang["Q2_12887"] = "摧毀魔眼，然後向暗影拱頂的斯利文男爵報告。"
Lang["Q1_12891"] = "我有一計……"
Lang["Q2_12891"] = "暗影拱頂的斯利文男爵要求你去收集一根教徒的魔棒、一根憎惡的彎鉤、一條惡鬼的繩子和5份天災精華。\n\n|cff33ff99它們在暗影拱頂周圍的平台上漫遊。|r"
Lang["Q1_12893"] = "解放你的思想"
Lang["Q2_12893"] = "暗影拱頂的斯利文男爵希望你在劣屍維爾、奈絲伍德夫人和跳線者的屍體上使用統治魔棒。"
Lang["Q1_12897"] = "頑固的敵人"
Lang["Q2_12897"] = "擊敗萊斯班恩將軍，然後向部落飛行戰艦上的庫爾迪拉·織亡者報捷。"
Lang["Q1_12896"] = "頑固的敵人"
Lang["Q2_12896"] = "擊敗萊斯班恩將軍，然後向聯盟飛行戰艦上的薩薩里安報捷。"
Lang["Q1_12899"] = "暗影拱頂"
Lang["Q2_12899"] = "向暗影拱頂的斯利文男爵報到。"
Lang["Q1_12898"] = "暗影拱頂"
Lang["Q2_12898"] = "向暗影拱頂的斯利文男爵報到。"
Lang["Q1_11978"] = "深入密林"
Lang["Q2_11978"] = "龍骨荒野西風避難營的特使艾米薩·閃蹄要求你找回10套部落軍備。"
Lang["Q1_11983"] = "部落的血誓"
Lang["Q2_11983"] = "與西風避難營的牛頭人交談，並收集5份他們對部落的效忠宣誓書。"
Lang["Q1_12008"] = "阿格瑪之鎚"
Lang["Q2_12008"] = "轉至龍骨平原的阿格瑪之鎚，與阿格瑪大王談一談。.\n\n|cff33ff99他位於(38.1, 46.3).|r"
Lang["Q1_12034"] = "勝利將近……"
Lang["Q2_12034"] = "與阿格瑪之鎚的軍士長祖托克談一談。\n\n|cff33ff99在營地中間，在 (36.6, 46.6).|r"
Lang["Q1_12036"] = "艾卓-尼魯布的深淵"
Lang["Q2_12036"] = "探索納爾蘇深淵，並將你的發現匯報給阿格瑪之鎚的軍士長祖托克。\n\n|cff33ff99入口位於阿格瑪之鎚西側 (26.2, 49.6). 跳入洞口完成任務。|r"
Lang["Q1_12053"] = "部落的力量"
Lang["Q2_12053"] = "阿格瑪之鎚的軍士長祖托克要求你在冰霧村使用戰歌軍旗，並確保它免遭一切攻擊。\n\n|cff33ff99你可以放置軍旗在 (25.2, 24.8).|r"
Lang["Q1_12071"] = "空中打擊！"
Lang["Q2_12071"] = "與阿格瑪之鎚的瓦諾克·風怒談一談。"
Lang["Q1_12072"] = "該死的荒蕪獸！"
Lang["Q2_12072"] = "在冰霧村內使用瓦諾克的信號槍調用一隻庫卡隆作戰雙足飛龍，騎坐它殺死25只阿努巴爾荒蕪獸！\n\n|cff33ff99在村莊下面靠近低處瀑布的地方有一些，在大型瀑布附近有更多。|r"
Lang["Q1_12063"] = "冰霧的力量"
Lang["Q2_12063"] = "在冰霧村內找到班索克·冰霧。\n\n|cff33ff99他位于水边 (22.7, 41.6).|r"
Lang["Q1_12064"] = "在冰霧村內找到班索克·冰霧。"
Lang["Q2_12064"] = "冰霧村的班索克·冰霧要求你將安諾科拉的鑰匙碎片、提瓦克斯的鑰匙碎片和西諾克的鑰匙碎片交給他。\n\n|cff33ff99它們在建築裡。提瓦克斯 位于 (26.7, 39.0), 西诺克 位于(24.3, 44.2) 安諾科拉 位於 (24.9, 43.9).|r"
Lang["Q1_12069"] = "大酋長歸來"
Lang["Q2_12069"] = "使用阿努巴爾牢籠鑰匙放出冰霧部族的大酋長，並協助他擊敗蟲王阿努布耶坎。\n\n|cff33ff99大酋長被關在一個魔法牢籠裡位於 (25.3, 40.9).|r"
Lang["Q1_12140"] = "洛納烏克萬歲！"
Lang["Q2_12140"] = "在阿格瑪之鎚找到洛納烏克·冰霧，並引導他加入部落，成為部落的領袖之一。"
Lang["Q1_12189"] = "笨蛋加白痴！"
Lang["Q2_12189"] = "轉至龍骨荒野的怨毒鎮，與首席藥劑師米德爾頓談一談。\n\n|cff33ff99他在建築裡面, 位于 (77.7, 62.8).|r"
Lang["Q1_12188"] = "凋零藥劑與你：如何自保"
Lang["Q2_12188"] = "怨毒鎮的首席藥劑師米德爾頓要求你給他帶回10份靈質殘渣。"
Lang["Q1_12200"] = "翡翠龍淚"
Lang["Q2_12200"] = "怨毒鎮的首席藥劑師米德爾頓要求你收集8份翡翠龍淚。\n\n|cff33ff99它們看起來像綠色寶石分佈在周圍地面上 (63.5, 71.9).|r"
Lang["Q1_12218"] = "傳達好消息"
Lang["Q2_12218"] = "怨毒鎮的首席藥劑師米德爾頓要求你使用被遺忘者雕零戰車上的雕零炸彈，在腐臭平原外圍消滅30名飢餓的死屍。"
Lang["Q1_12221"] = "被遺忘者的凋零藥劑"
Lang["Q2_12221"] = "將被遺忘者的凋零藥劑交給阿格瑪之鎚的辛塔爾·瑪菲奧斯博士。"
Lang["Q1_12224"] = "庫卡隆先鋒！"
Lang["Q2_12224"] = "轉至庫卡隆先鋒營地，向小薩魯法爾報到。\n\n|cff33ff99他位于 (40.7, 18.2).|r"
Lang["Q1_12496"] = "紅龍女王的指引"
Lang["Q2_12496"] = "在龍骨荒野的龍眠神殿尋找阿萊克絲塔薩，生命的縛誓者。\n\n|cff33ff99與塔里奧斯塔茲交談 (57.9, 54.2) 要求去塔頂。她以人形形態位於 (59.8, 54.7).|r"
Lang["Q1_12497"] = "迦拉克隆與天災軍團"
Lang["Q2_12497"] = "與龍骨荒野龍眠神殿的托拉斯塔薩談一談。"
Lang["Q1_12498"] = "紅龍之翼"
Lang["Q2_12498"] = "消滅30個廢土挖掘者並奪取安提沃克的鐮刀。完成這個任務之後，回到龍眠神殿去找阿萊克絲塔薩，生命的縛誓者。\n\n|cff33ff99你可以在北面發現它們(56.8, 33.3). 别忘了镰刀 位于 (54.6, 31.4).|r"
Lang["Q1_12500"] = "返回安加薩"
Lang["Q2_12500"] = "回到庫卡隆先鋒營地，向小薩魯法爾匯報你對天災軍團取得的勝利。\n\n|cff33ff99享受动画！ :-)|r"
Lang["Q1_13242"] = "黑暗的騷動"
Lang["Q2_13242"] = "在戰場上收集薩魯法爾的戰甲，然後轉至北風苔原的戰歌要塞，將它交給薩魯法爾大王。"
Lang["Q1_13257"] = "戰爭的使者"
Lang["Q2_13257"] = "轉至奧格瑞瑪的格羅瑪什堡壘，向薩爾報到。\n\n|cff33ff99享受角色扮演 :-)|r"
Lang["Q1_13266"] = "毫無遺憾的一生"
Lang["Q2_13266"] = "穿過格羅瑪什堡壘內的傳送門，轉至幽暗城，向沃金報到。"
Lang["Q1_13267"] = "幽暗城之戰"
Lang["Q2_13267"] = "幫助薩爾和希爾瓦娜斯為部落奪回幽暗城。"
Lang["Q1_12235"] = "納克薩瑪斯與暮冬城的陷落"
Lang["Q2_12235"] = "與暮冬要塞飛行點的獅鷲指揮官烏瑞克談一談。"
Lang["Q1_12237"] = "拯救暮冬城平民"
Lang["Q2_12237"] = "營救10名無助的暮冬城平民，然後向暮冬城的獅鷲指揮官烏瑞克復命。"
Lang["Q1_12251"] = "向高級指揮官復命"
Lang["Q2_12251"] = "轉至龍骨荒野的暮冬要塞，與高級指揮官哈爾弗·維姆班恩談一談。"
Lang["Q1_12253"] = "拯救暮冬城的平民"
Lang["Q2_12253"] = "暮冬要塞的高級指揮官哈爾弗·維姆班恩要求你救回6名被困的暮冬城平民。"
Lang["Q1_12309"] = "找到杜爾庫！"
Lang["Q2_12309"] = "在龍骨荒野的暮冬地穴找到騎兵杜爾庫。\n\n|cff33ff99他就站在地穴外面,位于 (79.0, 53.2).|r"
Lang["Q1_12311"] = "貴族的陵墓"
Lang["Q2_12311"] = "暮冬要塞的騎兵杜爾庫要求你殺死通靈領主阿瑪里恩。\n\n|cff33ff99一直走到地窖底部.|r"
Lang["Q1_12275"] = "破壞專家斯林奇"
Lang["Q2_12275"] = "轉至龍骨荒野的暮冬要塞，與攻城技師夸特弗拉什談一談。\n\n|cff33ff99他在獅鷲管理員附近, 位于(77.8, 50.3).|r"
Lang["Q1_12276"] = "尋找斯林奇"
Lang["Q2_12276"] = "轉至暮冬礦洞尋找破壞專家斯林奇。你可以使用夸特弗拉什的導航機器人來幫忙尋找礦洞。\n\n|cff33ff99機器人速度很快，如果你需要跟隨它，可以上車。\n從底部入口進入礦井，然後向右尋找屍體位於 (81.5, 42.2).|r"
Lang["Q1_12277"] = "阻絕邪惡"
Lang["Q2_12277"] = "找到暮冬礦洞炸彈，並用它把暮冬礦洞的上層入口和暮冬礦洞的下層入口炸掉。完成任務後，轉至龍骨荒野的暮冬要塞，向攻城技師夸特弗拉什復命。\n\n|cff33ff99炸药位于 (80.7, 41.3).|r"
Lang["Q1_12325"] = "進入敵占區"
Lang["Q2_12325"] = "與獅鷲指揮官烏瑞克交談，搭乘獅鷲飛往索爾森的崗哨。抵達目的地之後，向奧古斯特公爵報到。\n\n|cff33ff99不要和狮鹫管理员说话，而是跳上狮鹫载具。|r"
Lang["Q1_12312"] = "天災的秘密"
Lang["Q2_12312"] = "將血之魔典交給龍骨荒野暮冬要塞的騎兵杜爾庫。"
Lang["Q1_12319"] = "血之魔典"
Lang["Q2_12319"] = "將血之魔典交給龍骨荒野暮冬要塞的高級指揮官哈爾弗·維姆班恩。"
Lang["Q1_12320"] = "破譯魔典"
Lang["Q2_12320"] = "將血之魔典交給龍骨荒野暮冬要塞監獄內的審訊員哈爾拉德。\n\n|cff33ff99沿門口的路一直走到兵營。進入兵營以後直接從樓梯下樓。哈爾拉德位於 (76.7, 47.4).|r"
Lang["Q1_12321"] = "正義的審判"
Lang["Q2_12321"] = "等待審訊員哈爾拉德完成他的正義審訊，然後帶著你獲得的情報回到暮冬要塞的高級指揮官哈爾弗·維姆班恩那裡復命。"
Lang["Q1_12272"] = "流血的礦石"
Lang["Q2_12272"] = "龍骨荒野暮冬要塞的攻城技師夸特弗拉什要你轉至暮冬礦洞，取回10份奇怪的礦石的樣品。"
Lang["Q1_12281"] = "天災戰爭機器的奧秘"
Lang["Q2_12281"] = "把夸特弗拉什的包裹交給暮冬要塞的高級指揮官哈爾弗·維姆班恩。"
Lang["Q1_12326"] = "蒸汽坦克行動"
Lang["Q2_12326"] = "使用聯盟蒸汽坦克摧毀6台天災戰車，並將第七軍團精英送入暮冬陵園。成功之後與暮冬陵園裡的阿姆博·卡什談一談。\n\n|cff33ff99暮冬陵园位于 (85.9, 50.8), 阿姆博·卡什在里面等着。|r"
Lang["Q1_12455"] = "隨風散落"
Lang["Q2_12455"] = "龍骨荒野暮冬陵園的阿姆博·卡什要你取回8箱暮冬軍需品。\n\n|cff33ff99它们在陵墓外面，分散在田野周围。|r"
Lang["Q1_12457"] = "重機槍與你"
Lang["Q2_12457"] = "龍骨荒野暮冬陵園的阿姆博·卡什要你營救8名受傷的第七軍團士兵。\n\n|cff33ff99士兵总是在房间后面刷新，所以一定要用枪把它清除掉。|r"
Lang["Q1_12463"] = "找到普蘭比爾德！"
Lang["Q2_12463"] = "龍骨荒野暮冬陵園的阿姆博·卡什要你尋找普蘭比爾德的下落。\n\n|cff33ff99他在房间的尽头，在一个角落里 (84.2, 54.7).|r"
Lang["Q1_12465"] = "普蘭比爾德的日記"
Lang["Q2_12465"] = "將普蘭比爾德的日記的第4頁、第5頁、第6頁和第7頁交給龍骨荒野暮冬陵園的阿姆博·卡什。\n\n|cff33ff99沿着从普兰比尔德开始的隧道寻找合适的怪物|r"
Lang["Q1_12466"] = "追擊冰雪風暴：第七軍團前線"
Lang["Q2_12466"] = "轉至龍骨荒野中部的第七軍團前線，向軍團司令泰拉里安報到。\n\n|cff33ff99军团前线位于 (64.7, 27.9)|r"
Lang["Q1_12467"] = "追擊冰雪風暴：塞爾讚的護命匣"
Lang["Q2_12467"] = "從冰雪風暴手中奪得塞爾讚的護命匣，將它交給暮冬要塞的高級指揮官哈爾弗·維姆班恩。"
Lang["Q1_12472"] = "終結"
Lang["Q2_12472"] = "帶著塞爾讚的護命匣轉至龍骨荒野的暮冬陵園，向軍團司令尤瑞克報到。\n\n|cff33ff99隧道入口就在要塞外面, 位于(82.0, 50.7).|r"
Lang["Q1_12473"] = "結束和開始"
Lang["Q2_12473"] = "擊敗塞爾贊，然後轉至龍骨荒野的暮冬要塞，向高級指揮官哈爾弗·維姆班恩報告。\n\n|cff33ff99如果你死了，不要释放；NPC可能会帮你完成任务。|r"
Lang["Q1_12474"] = "轉至弗塔根要塞！"
Lang["Q2_12474"] = "轉至龍骨荒野的弗塔根要塞，與伯瓦爾·弗塔根公爵談一談。\n\n|cff33ff99他位于 (37.8, 23.4).|r"
Lang["Q1_12495"] = "紅龍女王的指引"
Lang["Q2_12495"] = "在龍骨荒野的龍眠神殿尋找阿萊克絲塔薩，生命的縛誓者。\n\n|cff33ff99与塔里奥斯塔兹交谈 (57.9, 54.2) 要求去塔顶。她以人形形态位于 (59.8, 54.7).|r"
Lang["Q1_12499"] = "返回安加薩"
Lang["Q2_12499"] = "回到弗塔根要塞，向伯瓦爾·弗塔根公爵匯報你對天災軍團取得的勝利。"
Lang["Q1_13347"] = "浴火重生"
Lang["Q2_13347"] = "從天災之門安加薩的戰場上取回弗塔根之盾，把它交給暴風城要塞中的瓦里安·烏瑞恩國王。"
Lang["Q1_13369"] = "造化弄人"
Lang["Q2_13369"] = "陪同吉安娜·普羅德摩爾轉至卡利姆多大陸的奧格瑞瑪，與部落的薩爾酋長交談。"
Lang["Q1_13370"] = "政變"
Lang["Q2_13370"] = "使用格羅瑪什堡壘中的傳送門返回暴風要塞，把薩爾的消息轉達給瓦里安·烏瑞恩國王。"
Lang["Q1_13371"] = "殺戮時刻"
Lang["Q2_13371"] = "使用暴風要塞內的通往幽暗城的傳送門轉至幽暗城。到達目的地之後，向布羅爾·熊皮報到。"
Lang["Q1_13377"] = "幽暗城之戰"
Lang["Q2_13377"] = "協助瓦里安·烏瑞恩國王和吉安娜·普羅德摩爾，剿滅大藥劑師普特雷斯！成功之後，向瓦里安·烏瑞恩國王報告。"
--WOTLK Sons of Hodir
Lang["Q1_12843"] = "她們把男人都抓走了！"
Lang["Q2_12843"] = "格萊奇·菲茲巴克要你轉至希弗列爾達村，救出5名地精囚犯。\n\n|cff33ff99希弗列尔达村位于 (41.4, 70.6), 杀死维库人，以获得散落在村庄里的囚犯笼子的钥匙。|r"
Lang["Q1_12846"] = "一個地精也不能少"
Lang["Q2_12846"] = "轉至希弗列爾達村的北部，找到荒棄礦洞的入口，並尋找西弗·菲茲巴克的下落。\n\n|cff33ff99矿井的入口在村庄里位于 (42.1, 69.5), 不在下面，如果你看到蜘蛛，你就错了:-).|r"
Lang["Q1_12841"] = "女巫的交易"
Lang["Q2_12841"] = "荒棄礦洞的女巫洛莉拉要求你從監督者希爾拉手中奪回伊克芬符文。\n\n|cff33ff99希尔拉在矿井的侧廊巡逻.|r"
Lang["Q1_12905"] = "殘酷的米爾德蕾"
Lang["Q2_12905"] = "在荒棄礦洞內與殘酷的米爾德蕾談一談。\n\n|cff33ff99米尔德蕾在平台上，你在矿井里走得更远。|r"
Lang["Q1_12906"] = "訓誡"
Lang["Q2_12906"] = "荒棄礦洞中的殘酷的米爾德蕾要求你使用訓誡之杖威嚇6個筋疲力盡的維庫人。"
Lang["Q1_12907"] = "殺一儆百"
Lang["Q2_12907"] = "荒棄礦洞內的殘酷的米爾德蕾命令你去處死加哈爾。\n\n|cff33ff99加哈尔和另外几个人在矿井的另一头，位于（45.4, 69.1）。卫兵会帮助你.|r"
Lang["Q1_12908"] = "特殊的囚犯"
Lang["Q2_12908"] = "把米爾德蕾的鑰匙交給荒棄礦洞的女巫洛莉拉。"
Lang["Q1_12921"] = "改頭換面"
Lang["Q2_12921"] = "到布倫希爾達村與女巫洛莉拉匯合。"
Lang["Q1_12969"] = "這是你的地精嗎？"
Lang["Q2_12969"] = "向安格妮塔·泰斯多達爾發起挑戰，救出西弗·菲茲巴克。成功之後，向布倫希爾達村的女巫洛莉拉復命。"
Lang["Q1_12970"] = "海德比武會"
Lang["Q2_12970"] = "聽取女巫洛莉拉的提議。\n\n|cff33ff99只需交谈并点击各种消息即可。|r"
Lang["Q1_12971"] = "迎接挑戰者"
Lang["Q2_12971"] = "布倫希爾達村的女巫洛莉拉要你去打敗6名獲勝的挑戰者。\n\n|cff33ff99只需与未参与战斗的各种挑战者交谈.|r"
Lang["Q1_12972"] = "你需要一頭熊"
Lang["Q2_12972"] = "與布倫希爾達村外的布莉亞娜談一談。\n\n|cff33ff99布莉亚娜位于 (53.1, 65.7).|r"
Lang["Q1_12851"] = "騎熊作戰"
Lang["Q2_12851"] = "布倫希爾達村的布莉亞娜要求你騎著冰牙轉至上古寒冬山谷，在那裡射擊7頭冰霜座狼和15個冰霜巨人。"
Lang["Q1_12856"] = "冰冷的心"
Lang["Q2_12856"] = "布倫希爾達村東邊的布莉亞娜要你飛往丹尼芬雷，解救3頭被俘虜的始祖幼龍，然後解救9名布倫希爾達囚犯。\n\n|cff33ff99飞往 (64.3, 61.5)  跳上一只被束缚的始祖龙。然后，你可以向维库女“射击”击落她们。做3次，然后返回。这样做三次就可以解救9名囚犯.|r"
Lang["Q1_13063"] = "證明價值"
Lang["Q2_13063"] = "布莉亞娜希望你轉至布倫希爾達村，與艾絲崔·約利塔爾談一談。\n\n|cff33ff99艾丝崔在一所房子里位于(49.7, 71.8).|r"
Lang["Q1_12900"] = "製造挽具"
Lang["Q2_12900"] = "布倫希爾達村的艾絲崔·約利塔爾希望你交給她3張冰鬃雪人的毛皮。"
Lang["Q1_12983"] = "最後的母熊"
Lang["Q2_12983"] = "布倫希爾達村的艾絲崔·約利塔爾要你去冬眠洞穴解救一頭冰喉母熊。\n\n|cff33ff99洞穴的入口位于 (55.9, 64.3). 沿着右边的路走，你会很容易找到冰喉母熊。|r"
Lang["Q1_12996"] = "熱身賽"
Lang["Q2_12996"] = "布倫希爾達村的艾絲崔·約利塔爾要你使用冰喉母熊的韁繩打敗基加拉格。\n\n|cff33ff99冷却时裂伤（4），当冲锋准备好时，击退（5），然后冲锋（6）。如果熊死了，你可以自己完成击杀，它仍然会算数。|r"
Lang["Q1_12997"] = "進入利齒之坑"
Lang["Q2_12997"] = "布倫希爾達村的艾絲崔·約利塔爾要你在利齒之坑里使用冰喉母熊的韁繩，並打敗6頭海德比武會戰熊。"
Lang["Q1_13061"] = "為榮耀而戰"
Lang["Q2_13061"] = "與布倫希爾達村的女巫洛莉拉談一談。"
Lang["Q1_13062"] = "洛莉拉的離別贈禮"
Lang["Q2_13062"] = "與布倫希爾達村的仲裁者格蕾塔談一談。"
Lang["Q1_12886"] = "馭龍賽"
Lang["Q2_12886"] = "使用海德尼爾魚叉，在風暴神殿擊敗10名海德比武會龍騎士。獲勝後對裝飾石柱使用海德尼爾魚叉以完成馭龍賽，然後與托里姆談一談。\n\n|cff33ff99用鱼叉跳到其他龙兽身上，杀死它们的骑手。10次后，用鱼叉在一个挂在柱子上的小灯上，这会把你带到平台上。|r"
Lang["Q1_13064"] = "骨肉相殘"
Lang["Q2_13064"] = "托里姆希望你能傾聽他的故事。"
Lang["Q1_12915"] = "彌補關係"
Lang["Q2_12915"] = "風暴神殿的托里姆要你轉至丹尼芬雷東邊的弗約恩之砧，殺死弗約恩和5名雷鑄鐵巨人。\n\n|cff33ff99飞到丹尼芬雷以东的铁砧 (76.9, 63.2), 从地板上捡起一块花岗岩石块。对目标使用托里姆的大地符咒，召唤土灵斩铁者。\n注意，每个目标都需要一个新的（唯一的）花岗岩石块（总计需要最少6个）。|r"
Lang["Q1_12922"] = "精煉之火"
Lang["Q2_12922"] = "從霜原湖的火熱的亡魂身上收集10份狂怒火花，然後轉至弗約恩之砧，使用那裡的鐵砧。"
Lang["Q1_12956"] = "希望的火花"
Lang["Q2_12956"] = "將精煉閃光礦石交給風暴神殿的托里姆。"
Lang["Q1_12924"] = "重鑄盟約"
Lang["Q2_12924"] = "轉至丹尼芬雷，請求約庫姆國王幫忙重鑄托里姆的護甲。完成約庫姆交付的任務之後，與丹尼芬雷的亞米爾德談一談。\n\n|cff33ff99约库姆国王位于丹尼芬雷的中心 (65.4, 60.1).\n\n但你最终还是把这个任务交给了亚米尔德(63.2, 63.3).|r"
Lang["Q1_13009"] = "新的開始"
Lang["Q2_13009"] = "亞米爾德要求你將重鑄的風暴之王鎧甲交給風暴神殿的托里姆。"
Lang["Q1_13050"] = "維拉努斯"
Lang["Q2_13050"] = "維拉努斯風暴神殿的托里姆要你從布倫希爾達村附近的峭壁上取回5枚規模始祖龍卵。\n\n|cff33ff99布伦希尔达村周围有各种巢穴例如 (52.5, 73.4).|r"
Lang["Q1_13051"] = "侵犯領土"
Lang["Q2_13051"] = "將偷來的始祖龍卵放置在母龍之巢的頂部，然後返回風暴神殿向托里姆復命。\n\n|cff33ff99正确的巢穴位于 (38.7, 65.5). 放下龙卵，等待托里姆出现在母龙之巢。|r"
Lang["Q1_13010"] = "科洛米爾，風暴之鎚"
Lang["Q2_13010"] = "托里姆要你與丹尼芬雷的約庫姆國王談一談，向他打聽科洛米爾的消息。\n\n|cff33ff99你可能差一点声望让国王回答你的问题。完成两个日常任务中的一个，声望达到友善。|r"
Lang["Q1_12966"] = "你不會找不到他"
Lang["Q2_12966"] = "丹尼芬雷的約庫姆國王要你轉至弗約恩之砧，找到找亞米爾德。"
Lang["Q1_12967"] = "元素之戰"
Lang["Q2_12967"] = "亞米爾德要求你陪伴斯諾雷轉至弗約恩之砧，並幫助他殺死10個火熱的亡魂。"
Lang["Q1_12975"] = "回首往事"
Lang["Q2_12975"] = "丹尼芬雷的約庫姆國王要求你前往落雷谷，收集8塊號角碎片。\n\n|cff33ff99它们看起来像雪中的灰色小碎片位于 (71.6, 48.9).|r"
Lang["Q1_12976"] = "亡者的紀念碑"
Lang["Q2_12976"] = "約庫姆國王要求你將號角碎片交給丹尼芬雷的亞米爾德。"
Lang["Q1_13011"] = "肥胖的尤姆塔爾"
Lang["Q2_13011"] = "丹尼芬雷的約庫姆國王要求你轉至冬眠洞穴，殺死尤姆塔爾。\n\n|cff33ff99进入洞穴，靠右走。你可以从 (54.8, 61.0)召唤尤姆塔尔. 可能需要几次尝试才能得到熊肉。|r"
Lang["Q1_13372"] = "聚焦之虹的鑰匙"
Lang["Q2_13372"] = "轉至龍骨荒野的龍眠神殿，將聚焦之虹的鑰匙交給阿萊克絲塔薩，生命的縛誓者。"
Lang["Q1_13375"] = "英雄聚焦之虹的鑰匙"
Lang["Q2_13375"] = "轉至龍骨荒野的龍眠神殿，將英雄聚焦之虹的鑰匙交給阿萊克絲塔薩，生命的縛誓者。"

--  \n\n|cff33ff99 |r
Lang["Q1_"] = ""
Lang["Q2_"] = ""




-- NPC
Lang["N1_9196"] = "歐莫克大王"	-- https://cn.tbc.wowhead.com/?npc=9196
Lang["N2_9196"] = "歐莫克大王能在以下地區找到：黑石塔下層。"
Lang["N1_9237"] = "指揮官沃恩"	-- https://cn.tbc.wowhead.com/?npc=9237
Lang["N2_9237"] = "指揮官沃恩能在以下地區找到：​黑石塔下層。"
Lang["N1_9568"] = "維姆薩拉克主宰"	-- https://cn.tbc.wowhead.com/?npc=9568
Lang["N2_9568"] = "維姆薩拉克主宰能在以下地區找到：​黑石塔下層。"
Lang["N1_10429"] = "大酋長雷德·黑手"	-- https://cn.tbc.wowhead.com/?npc=10429
Lang["N2_10429"] = "大酋長雷德·黑手能在以下地區找到：​黑石塔上層。"
Lang["N1_10182"] = "雷克萨<部落的勇士>"	-- https://cn.tbc.wowhead.com/?npc=10182
Lang["N2_10182"] = "雷克薩能能在以下地區找到：淒涼之地、菲拉斯、石爪山脈。"
Lang["N1_8197"] = "克魯納里斯"	-- https://cn.tbc.wowhead.com/?npc=8197
Lang["N2_8197"] = "克魯納里斯能在塔納利斯的時光之穴門外找到。"
Lang["N1_10664"] = "斯克利爾"	-- https://cn.tbc.wowhead.com/?npc=10664
Lang["N2_10664"] = "斯克利爾能在冬泉谷的藍龍洞深處找到。"
Lang["N1_12900"] = "索姆努斯"	-- https://cn.tbc.wowhead.com/?npc=12900
Lang["N2_12900"] = "索姆努斯能在悲傷沼澤的沉默的神廟東側找到。"
Lang["N1_12899"] = "埃克托茲"	-- https://cn.tbc.wowhead.com/?npc=12899
Lang["N2_12899"] = "埃克托茲能在濕地的格瑞姆巴托找到。"
Lang["N1_10363"] = "達基薩斯將軍"	-- https://cn.tbc.wowhead.com/?npc=10363
Lang["N2_10363"] = "達基薩斯將軍是黑石塔上層的最終首領。"
Lang["N1_8983"] = "魔像領主阿格曼奇"	-- https://cn.tbc.wowhead.com/?npc=8983
Lang["N2_8983"] = "魔像領主阿格曼奇能在以下地區找到：​黑石深淵。"
Lang["N1_9033"] = "安格佛將軍"	-- https://cn.tbc.wowhead.com/?npc=9033
Lang["N2_9033"] = "安格佛將軍能在以下地區找到：​黑石深淵。"
Lang["N1_17804"] = "侍衛洛文"	-- https://cn.tbc.wowhead.com/?npc=17804
Lang["N2_17804"] = "侍衛洛文能在暴風城大門找到。"
Lang["N1_10929"] = "哈爾琳"	-- https://cn.tbc.wowhead.com/?npc=10929
Lang["N2_10929"] = "站在馬茲索里爾洞穴頂部。\n可以通過洞穴深處地板上的藍色符文到達。"
Lang["N1_9046"] = "裂盾軍需官 <裂盾軍團>"	-- https://cn.tbc.wowhead.com/?npc=9046
Lang["N2_9046"] = "位於副本外，在黑石塔陽台入口附近。"
Lang["N1_15180"] = "流沙守望者巴里斯托爾斯"	-- https://cn.tbc.wowhead.com/?npc=15180
Lang["N2_15180"] = "流沙守望者巴里斯托爾斯位於希利蘇斯 (49.6,36.6)。"
Lang["N1_12017"] = "龍領主勒西雷爾"	-- https://cn.tbc.wowhead.com/?npc=12017
Lang["N2_12017"] = "龍領主勒西雷爾是黑翼之巢的第三位首領。"
Lang["N1_13020"] = "堕落的瓦拉斯塔兹"	-- https://cn.tbc.wowhead.com/?npc=13020
Lang["N2_13020"] = "堕落的瓦拉斯塔兹是黑翼之巢的第二位首領。"
Lang["N1_11583"] = "奈法利安"	-- https://cn.tbc.wowhead.com/?npc=11583
Lang["N2_11583"] = "奈法利安是黑翼之巢的最終首領。"
Lang["N1_15362"] = "瑪法里恩·怒風"	-- https://cn.tbc.wowhead.com/?npc=15362
Lang["N2_15362"] = "瑪法里恩·怒風位於沉默的神廟最終首領附近。"
Lang["N1_15624"] = "森林幽光"	-- https://cn.tbc.wowhead.com/?npc=15624
Lang["N2_15624"] = "森林幽光位於達納蘇斯(37.6,48.0)。"
Lang["N1_15481"] = "艾索雷葛斯之魂"	-- https://cn.tbc.wowhead.com/?npc=15481
Lang["N2_15481"] = "艾索雷葛斯之魂位於艾薩拉 (58.8,82.2)。"
Lang["N1_11811"] = "納瑞安"	-- https://cn.tbc.wowhead.com/?npc=11811
Lang["N2_11811"] = "納瑞安位於塔納利斯 (65.2,18.4)."
Lang["N1_15526"] = "人魚米莉蒂絲"	-- https://cn.tbc.wowhead.com/?npc=15526
Lang["N2_15526"] = "人魚米莉蒂絲位於塔納利斯 (59.6,95.6)。"
Lang["N1_15554"] = "人造猿二號"	-- https://cn.tbc.wowhead.com/?npc=15554
Lang["N2_15554"] = "人造猿二號位於冬泉谷 (67.2,72.6). "
Lang["N1_15552"] = "維維爾博士"	-- https://cn.tbc.wowhead.com/?npc=15552
Lang["N2_15552"] = "維維爾博士位於塵泥沼澤(77.8,17.6)。"
Lang["N1_10184"] = "奧妮克希亞"	-- https://cn.tbc.wowhead.com/?npc=10184
Lang["N2_10184"] = "奧妮克希亞位於奧妮克希亞的巢穴。"
Lang["N1_11502"] = "拉格納羅斯"	-- https://cn.tbc.wowhead.com/?npc=11502
Lang["N2_11502"] = "拉格納羅斯是熔火之心的最終首領。"
Lang["N1_12803"] = "拉克麥拉"	-- https://cn.tbc.wowhead.com/?npc=12803
Lang["N2_12803"] = "拉克麥拉位於菲拉斯 (29.8,72.6)。"
Lang["N1_15571"] = "巨齒鯊"	-- https://cn.tbc.wowhead.com/?npc=15571
Lang["N2_15571"] = "巨齒鯊位於艾薩拉 (65.6,54.6)。"
Lang["N1_22037"] = "鐵匠戈蘭克"	-- https://cn.tbc.wowhead.com/?npc=22037
Lang["N2_22037"] = "鐵匠戈蘭克位於影月谷 (67,36)。"
Lang["N1_18733"] = "惡魔劫奪者"	-- https://cn.tbc.wowhead.com/?npc=18733
Lang["N2_18733"] = "傾向於漫遊在地獄火壁壘的西側。"
Lang["N1_18473"] = "鷹王伊奇斯"	-- https://cn.tbc.wowhead.com/?npc=18473
Lang["N2_18473"] = "鷹王伊奇斯是塞司克大廳的最終首領"
Lang["N1_20142"] = "時間服務員 <時光守望者>"	-- https://cn.tbc.wowhead.com/?npc=20142
Lang["N2_20142"] = "時間服務員 <時光守望者>位於時光之穴的入口"
Lang["N1_20130"] = "安杜姆 <時光守望者>"	-- https://cn.tbc.wowhead.com/?npc=20130
Lang["N2_20130"] = "看起來像一個小男孩，靠近時光之穴的沙漏."
Lang["N1_18096"] = "紀元狩獵者"	-- https://cn.tbc.wowhead.com/?npc=18096
Lang["N2_18096"] = "紀元狩獵者是希爾斯布萊德丘陵舊址的最終首領."
Lang["N1_19880"] = "虛空巡者凱澤"	-- https://cn.tbc.wowhead.com/?npc=19880
Lang["N2_19880"] = "虛空巡者凱澤位於虛空風暴52區 (32,64)"
Lang["N1_19641"] = "星界強盜奈薩德"	-- https://cn.tbc.wowhead.com/?npc=19641
Lang["N2_19641"] = "星界強盜奈薩德於虛空風暴(28,79)。"
Lang["N1_18481"] = "阿達歐"	-- https://cn.tbc.wowhead.com/?npc=18481
Lang["N2_18481"] = "阿達歐位於撒塔斯城的中央。"
Lang["N1_19220"] = "操縱者帕薩里歐"	-- https://cn.tbc.wowhead.com/?npc=19220
Lang["N2_19220"] = "操縱者帕薩里歐是麥克納爾的最終首領。"
Lang["N1_17977"] = "扭曲分裂者"	-- https://cn.tbc.wowhead.com/?npc=17977
Lang["N2_17977"] = "扭曲分裂者波塔尼卡的最終首領。"
Lang["N1_17613"] = "大法師艾特羅斯"	-- https://cn.tbc.wowhead.com/?npc=17613
Lang["N2_17613"] = "大法師艾特羅斯站在卡拉贊的入口。"
Lang["N1_18708"] = "莫爾墨"	-- https://cn.tbc.wowhead.com/?npc=18708
Lang["N2_18708"] = "莫爾墨是暗影迷宫的最終首領。"
Lang["N1_17797"] = "水占師希斯比亞"	-- https://cn.tbc.wowhead.com/?npc=17797
Lang["N2_17797"] = "水占師希斯比亞是蒸氣洞窟的第一位首領。"
Lang["N1_20870"] = "無約束的希瑞奇斯"	-- https://cn.tbc.wowhead.com/?npc=20870
Lang["N2_20870"] = "無約束的希瑞奇斯亞克崔茲的第一位首領。"
Lang["N1_15608"] = "麥迪文"	-- https://cn.tbc.wowhead.com/?npc=15608
Lang["N2_15608"] = "麥迪文在黑色沼澤南部的黑暗之門附近。"
Lang["N1_16524"] = "埃蘭之影"	-- https://cn.tbc.wowhead.com/?npc=16524
Lang["N2_16524"] = "麥迪文的瘋狂父親，在卡拉贊。"
Lang["N1_16807"] = "大術士奈德克斯"	-- https://cn.tbc.wowhead.com/?npc=16807
Lang["N2_16807"] = "大術士奈德克斯是破碎大廳的第一位首領。"
Lang["N1_18472"] = "暗織者希斯"	-- https://cn.tbc.wowhead.com/?npc=18472
Lang["N2_18472"] = "暗織者希斯是塞司克大廳的第一位首領。"
Lang["N1_22421"] = "異教徒司卡利斯"	-- https://cn.tbc.wowhead.com/?npc=22421
Lang["N2_22421"] = "異教徒司卡利斯在英雄難度的奴隸監獄。"
Lang["N1_19044"] = "弒龍者戈魯爾"	-- https://cn.tbc.wowhead.com/?npc=19044
Lang["N2_19044"] = "弒龍者戈魯爾是戈魯爾的巢穴的最終首領。"
Lang["N1_17225"] = "夜禍"	-- https://cn.tbc.wowhead.com/?npc=17225
Lang["N2_17225"] = "夜禍是卡拉贊的召喚首領。"
Lang["N1_21938"] = "大地治愈者斯普林·裂蹄 <陶土議會>"	-- https://cn.tbc.wowhead.com/?npc=21938
Lang["N2_21938"] = "大地治愈者斯普林·裂蹄 <陶土議會>位於影月谷 (28.6,26.6)。"
Lang["N1_21183"] = "歐朗諾克·碎心 <隱士和商人>"	-- https://cn.tbc.wowhead.com/?npc=21183
Lang["N2_21183"] = "歐朗諾克·碎心 <隱士和商人>位於影月谷 (53.8,23.4)。"
Lang["N1_21291"] = "葛洛姆特，歐朗諾克之子"	-- https://cn.tbc.wowhead.com/?npc=21291
Lang["N2_21291"] = "葛洛姆特，歐朗諾克之子位於影月谷 (44.6,23.6)。"
Lang["N1_21292"] = "阿爾托，歐朗諾克之子"	-- https://cn.tbc.wowhead.com/?npc=21292
Lang["N2_21292"] = "阿爾托，歐朗諾克之子位於影月谷 (29.6,50.4)。"
Lang["N1_21293"] = "柏爾拉克，歐朗諾克之子"	-- https://cn.tbc.wowhead.com/?npc=21293
Lang["N2_21293"] = "柏爾拉克，歐朗諾克之子位於影月谷 (47.6,57.2)。"
Lang["N1_18166"] = "卡德加 <洛薩之子>"	-- https://cn.tbc.wowhead.com/?npc=18166
Lang["N2_18166"] = "他站在撒塔斯城的中心，就在黄色發光的阿達歐旁邊。"
Lang["N1_16808"] = "大酋長卡加斯·刃拳"	-- https://cn.tbc.wowhead.com/?npc=16808
Lang["N2_16808"] = "大酋長卡加斯·刃拳是破碎大廳的最終首領。"
Lang["N1_17798"] = "督軍卡利斯瑞"	-- https://cn.tbc.wowhead.com/?npc=17798
Lang["N2_17798"] = "督軍卡利斯瑞是蒸氣洞窟的最終首領。"
Lang["N1_20912"] = "先驅者史蓋力司"	-- https://cn.tbc.wowhead.com/?npc=20912
Lang["N2_20912"] = "先驅者史蓋力司是亞克崔茲的最終首領。"
Lang["N1_20977"] = "米歐浩斯·曼納斯頓"	-- https://cn.tbc.wowhead.com/?npc=20977
Lang["N2_20977"] = "米歐浩斯·曼納斯頓是在亞克崔茲中發現的地精法師。 他將協助攻擊從監獄釋放的其他生物。"
Lang["N1_17257"] = "瑪瑟里頓"	-- https://cn.tbc.wowhead.com/?npc=17257
Lang["N2_17257"] = "瑪瑟里頓被關押在地獄火壁壘的下層，團隊副本被稱為瑪瑟里頓的巢穴."
Lang["N1_21937"] = "大地治癒者索菲魯斯 <陶土議會>"	-- https://cn.tbc.wowhead.com/?npc=21937
Lang["N2_21937"] = "大地治癒者索菲魯斯 <陶土議會>位於影月谷 (36.4,56.8)。"
Lang["N1_19935"] = "索芮朵蜜 <流沙之鳞>"	-- https://cn.tbc.wowhead.com/?npc=19935
Lang["N2_19935"] = "索芮朵蜜徘徊在時光之穴的大沙漏周圍."
Lang["N1_19622"] = "凱爾薩斯·逐日者 <血精靈之王>"	-- https://cn.tbc.wowhead.com/?npc=19622
Lang["N2_19622"] = "凱爾薩斯·逐日者 <血精靈之王>是風暴要塞的最終首領。"
Lang["N1_21212"] = "瓦許女士 <盤牙女王>"	-- https://cn.tbc.wowhead.com/?npc=21212
Lang["N2_21212"] = "瓦許女士 <盤牙女王>是毒蛇神殿的最終首領。"
Lang["N1_21402"] = "隱士希拉"	-- https://cn.tbc.wowhead.com/?npc=21402
Lang["N2_21402"] = "隱士希拉位於影月谷 (62.6,28.4)。"
Lang["N1_21955"] = "秘法師賽利斯"	-- https://cn.tbc.wowhead.com/?npc=21955
Lang["N2_21955"] = "秘法師賽利斯位於影月谷 (56.2,59.6)。"
Lang["N1_21962"] = "烏達羅"	-- https://cn.tbc.wowhead.com/?npc=21962
Lang["N2_21962"] = "烏達羅在亞克崔茲的最終首領戰鬥之前，他躺在小坡道上死了."
Lang["N1_22006"] = "暗影領主達斯維爾"	-- https://cn.tbc.wowhead.com/?npc=22006
Lang["N2_22006"] = "暗影領主達斯維爾騎龍在黑暗神廟的北塔上 (71.6,35.6)。"
Lang["N1_22820"] = "先知奧魯姆"	-- https://cn.tbc.wowhead.com/?npc=22820
Lang["N2_22820"] = "先知奥鲁姆位於毒蛇神殿深淵之王卡拉薩瑞斯附近。"
Lang["N1_21700"] = "阿卡瑪"	-- https://cn.tbc.wowhead.com/?npc=21700
Lang["N2_21700"] = "阿卡瑪位於影月谷 (58.0,48.2)。"
Lang["N1_19514"] = "歐爾 <鳳凰神>"	-- https://cn.tbc.wowhead.com/?npc=19514
Lang["N2_19514"] = "歐爾 <鳳凰神>是風暴要塞的第一位首領。"
Lang["N1_17767"] = "瑞齊·凜冬"	-- https://cn.tbc.wowhead.com/?npc=17767
Lang["N2_17767"] = "瑞齊·凜冬是海加爾山的第一位首領。"
Lang["N1_18528"] = "希瑞"	-- https://cn.tbc.wowhead.com/?npc=18528
Lang["N2_18528"] = "希瑞位於黑暗神廟的門外."
--v243
Lang["N1_22497"] = "弗埃盧"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22497
Lang["N2_22497"] = "弗埃盧和阿達爾在同一個房間，但他是藍色的。他在頂層著陸。"
--v244
Lang["N1_22113"] = "莫德奈"
Lang["N2_22113"] = "一個血精靈（劇透警報，實際上是一條龍）走在星辰聖殿東邊的虛空之翼領域"
--v247
Lang["N1_8888"]  = "弗蘭克羅恩·鑄鐵"
Lang["N2_8888"]  = "一個幽靈矮人，站在地牢外他自己的墳墓上，在懸浮在熔岩上方的結構中。 只有死了才能與他互動。"
Lang["N1_9056"]  = "弗諾斯·達克維爾"
Lang["N2_9056"]  = "他在地牢內，在伊森迪烏斯勳爵房間外的採石場巡邏。"
Lang["N1_10837"] = "高級執行官德靈頓"
Lang["N2_10837"] = "他可以在壁壘中找到，靠近提瑞斯法和西瘟疫之地的邊界"
Lang["N1_10838"] = "指揮官阿什拉姆·瓦羅菲斯特"
Lang["N2_10838"] = "他可以在西瘟疫之地安多哈爾以南的寒風營地找到"
Lang["N1_1852"]  = "召喚者阿拉吉"
Lang["N2_1852"]  = "巫妖，在安多哈爾的中央"
--v250
Lang["N1_13278"]  = "海達克西斯公爵"
Lang["N2_13278"]  = "艾薩拉一個遙遠的小島上的大型水元素 (79.2,73.6)"
Lang["N1_12264"]  = "沙斯拉爾"
Lang["N2_12264"]  = "沙斯拉爾 是熔火之心的第五個boss。"
Lang["N1_12118"]  = "魯西弗隆"
Lang["N2_12118"]  = "魯西弗隆 是熔火之心的第一個boss。"
Lang["N1_12259"]  = "基赫纳斯"
Lang["N2_12259"]  = "基赫纳斯 是熔火之心的第三个boss。"
Lang["N1_12098"]  = "S薩弗隆先驅者r"
Lang["N2_12098"]  = "薩弗隆先驅者 是熔火之心的第八個boss。"




--WOTLK NPCs
--WOTLK QUESTS
-- The ids are N1_<NPCId> and N2_<NPCId>
-- N1 is just the name of the NPC
-- N2 is a helpful description
Lang["N1_29795"]  = "庫爾迪拉·織亡者"
Lang["N2_29795"]  = "不要在地面上尋找他。他在奧格瑞姆之鎚上，在伊米海姆和辛達苟薩之墓之間的平原上空飛行。"
Lang["N1_29799"]  = "薩薩里安"
Lang["N2_29799"]  = "不要在地面上尋找他。他在破天號上, 在伊米海姆和辛達苟薩之墓之間的平原上空飛行。"
Lang["N1_29804"]  = "斯利文男爵"
Lang["N2_29804"]  = "他站在外面，塔的南邊，靠近地面入口(44, 24.6).\n\n一旦任務鏈結束，他就會移動到 (42.8, 25.1)."
Lang["N1_29747"]  = "魔眼"
Lang["N2_29747"]  = "一隻藍色大眼睛，在陰影穹頂的最頂端 (44.6, 21.6).\n\n只需使用魔眼衝擊砲將其擊打10次即可。"
Lang["N1_29769"]  = "劣屍維爾"
Lang["N2_29769"]  = "站在中間平台上，距離斯利文男爵稍南(44.4, 26.9)."
Lang["N1_29770"]  = "奈絲伍德夫人"
Lang["N2_29770"]  = "站在斯利文男爵西邊的小平台上 (41.9, 24.5)."
Lang["N1_29840"]  = "跳躍者"
Lang["N2_29840"]  = "在斯利文男爵上方的頂部平台周圍跳躍 (45.0, 23.8).\n可能很難發現，使用目標宏 '/tar 跳躍者'"
Lang["N1_29851"]  = "萊斯班恩將軍"
Lang["N2_29851"]  = "當點擊暗影拱頂末端的武器架時出現。你剛剛殺死的另外三個人在戰鬥中前來幫忙。\n\n你可以飛進飛出(44.9, 20.0)."
Lang["N1_26181"]  = "特使艾米薩·閃蹄 <牛頭人大使>"
Lang["N2_26181"]  = "環繞著位於龍骨荒野的西風避難營下部，位於北風苔原邊境 (13.9, 48.6)."
Lang["N1_26652"]  = "冰霧祖母"
Lang["N2_26652"]  = "她在阿格瑪之鎚繞著圓心走。她身穿藍色盔甲，手持紫色手杖。"
Lang["N1_26505"]  = "辛塔爾·瑪菲奧斯博士 <大藥劑師>"
Lang["N2_26505"]  = "他在阿格瑪之鎚的煉金術角落(36.1, 48.8)."
Lang["N1_25257"]  = "小薩魯法爾"
Lang["N2_25257"]  = "他在龍骨荒野西北角的天譴之門附近，位於(40.7, 18.1).\n\n不要太依恋他！"
Lang["N1_31333"]  = "阿萊克絲塔薩，生命的縛誓者 <巨龍的女王>"
Lang["N2_31333"]  = "她現在是龍的形態，在天譴之門前。相當大，不能錯過她 (38.3, 19.2)."
Lang["N1_25256"]  = "薩魯法爾大王"
Lang["N2_25256"]  = "他位於北風苔原戰歌要塞的底部 (41.4, 53.7)."
Lang["N1_27136"]  = "高級指揮官哈爾弗·維姆班恩 <第七軍團>"
Lang["N2_27136"]  = "他就在龍骨荒野暮冬要塞的頂端 (78.5, 48.3)."
Lang["N1_27872"]  = "伯瓦爾·弗塔根公爵"
Lang["N2_27872"]  = "伯瓦爾·弗塔根，聯盟中真正的英雄，遭遇了可怕的命運。\n\n他在龙骨荒野(37.8, 23.4)等待."
Lang["N1_29611"]  = "瓦里安·烏瑞恩國王 <暴風城國王>"
Lang["N2_29611"]  = "看起來不太高興。 。"
Lang["N1_29473"]  = "格萊奇·菲茲巴克"
Lang["N2_29473"]  = "她在K3旅店 (41.2, 86.1)."
Lang["N1_15989"]  = "薩菲隆"
Lang["N2_15989"]  = "薩菲隆是一隻巨大的亡靈冰霜巨龍，守衛著納克薩瑪斯克爾蘇加德內部聖所的入口。"

Lang["N1_"]  = ""
Lang["N2_"]  = ""



Lang["O_1"] = "擊殺達基薩斯將軍以完成任務。\n位於達基薩斯將軍後面的發光球。"
Lang["O_2"] = "這是一個在地面上發光的小紅點\n位於安琪拉之門 (28.7,89.2)。"
--v247
Lang["O_3"] = "神殿位於一條走廊的盡頭，這條走廊從法則之環的上層開始。"
Lang["O_189311"] = "|cFFFFFFFF血之魔典|r\n|cFF808080開始新任務|r\n\n書在地下室的地板上,\n旁边是通灵领主阿玛里恩 (78.3, 52.3).\n\n完成任務後，趕快離開\n因為怪物會刷新並攻擊你"
Lang["Flesh-bound Tome"] = "血之魔典"

