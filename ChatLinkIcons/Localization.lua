--[[	ChatLinkIcons - Localization
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

----------------------------------
--[[	Localization Table	]]
----------------------------------
local Localization={
	enUS={--	Native locale by SDPhantom
--		Options Panel
		Options_ByAuthor_Format="by %s";

--		Options Panel (Settings)
		OptionsSetting_Links_Achievement="Achievements";
		OptionsSetting_Links_BattlePet="Battle Pets";
		OptionsSetting_Links_BattlePet_Ability="Abilities";
		OptionsSetting_Links_CalendarEvent="Calendar Events";
		OptionsSetting_Links_GarrisonFollower="Garrison Followers";
		OptionsSetting_Links_GarrisonFollower_Ability="Abilities";
		OptionsSetting_Links_Item="Items";
		OptionsSetting_Links_Player="Players";
		OptionsSetting_Links_Player_RaceGender="Race/Gender";
		OptionsSetting_Links_Player_Class="Class";
		OptionsSetting_Links_Spell="Spells";
		OptionsSetting_Links_Tradeskill="Tradeskills";
		OptionsSetting_Links_Transmog="Transmog";

		OptionsSetting_Integration_Format="%1$s Integration |cff%2$s(%3$s)|r";--	Receives title/name, color code, and load state
		OptionsSetting_Integration_Loaded="Loaded";
	};
	ruRU={--	Translated by ZamestoTV
--		Options Panel
		Options_ByAuthor_Format="от %s";

--		Options Panel (Settings)
		OptionsSetting_Links_Achievement="Достижения";
		OptionsSetting_Links_BattlePet="Боевые питомцы";
		OptionsSetting_Links_BattlePet_Ability="Способности";
		OptionsSetting_Links_CalendarEvent="События календаря";
		OptionsSetting_Links_GarrisonFollower="Гарнизонные соратники";
		OptionsSetting_Links_GarrisonFollower_Ability="Способности";
		OptionsSetting_Links_Item="Предметы";
		OptionsSetting_Links_Player="Игроки";
		OptionsSetting_Links_Player_RaceGender="Раса/Пол";
		OptionsSetting_Links_Player_Class="Класс";
		OptionsSetting_Links_Spell="Заклинания";
		OptionsSetting_Links_Tradeskill="Профессии";
		OptionsSetting_Links_Transmog="Трансмогрификация";

		OptionsSetting_Integration_Format="Интеграция %1$s |cff%2$s(%3$s)|r";--	Receives title/name, color code, and load state
		OptionsSetting_Integration_Loaded="Загружено";
	};
	zhCN={--	Translated by Loukky
--		Options Panel
		Options_ByAuthor_Format="由 %s";

--		Options Panel (Settings)
		OptionsSetting_Links_Achievement="成就";
		OptionsSetting_Links_BattlePet="战斗宠物";
		OptionsSetting_Links_BattlePet_Ability="能力";
		OptionsSetting_Links_CalendarEvent="日历事件";
		OptionsSetting_Links_GarrisonFollower="要塞追随者";
		OptionsSetting_Links_GarrisonFollower_Ability="能力";
		OptionsSetting_Links_Item="物品";
		OptionsSetting_Links_Player="玩家";
		OptionsSetting_Links_Player_RaceGender="种族/性别";
		OptionsSetting_Links_Player_Class="职业";
		OptionsSetting_Links_Spell="技能";
		OptionsSetting_Links_Tradeskill="商业技能";
		OptionsSetting_Links_Transmog="幻化";

		OptionsSetting_Integration_Format="%1$s 一体化 |cff%2$s(%3$s)|r";--	Receives title/name, color code, and load state
		OptionsSetting_Integration_Loaded="已加载";
	};
};

----------------------------------
--[[	Localization Loader	]]--	Nothing to localize below this line
----------------------------------
local AddOn=select(2,...);
setmetatable(Localization.enUS,{__index=function(t,k) return k; end});
AddOn.Localization=Localization[GetLocale()] or Localization.enUS;
if AddOn.Localization~=Localization.enUS then setmetatable(AddOn.Localization,{__index=Localization.enUS}); end
