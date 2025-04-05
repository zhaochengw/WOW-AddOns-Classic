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
};

----------------------------------
--[[	Localization Loader	]]--	Nothing to localize below this line
----------------------------------
local AddOn=select(2,...);
setmetatable(Localization.enUS,{__index=function(t,k) return k; end});
AddOn.Localization=Localization[GetLocale()] or Localization.enUS;
if AddOn.Localization~=Localization.enUS then setmetatable(AddOn.Localization,{__index=Localization.enUS}); end
