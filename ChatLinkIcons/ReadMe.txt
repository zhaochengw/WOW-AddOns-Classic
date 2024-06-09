ChatLinkIcons
by SDPhantom
https://www.wowinterface.com/forums/member.php?u=34145
https://www.curseforge.com/members/sdphantomgamer/projects
===============================================================================

All Rights Reserved - Use at your own risk
UnZip contents into the "Interface\AddOns" folder in your WoW instalation directory

===============================================================================
Versions:
v3.4 (2024-01-23)
	-Converted race/class icons to use atlases to be more robust against Blizzard shuffling icons

v3.3 (2023-12-14)
	-Moved callback type processing from dispatcher to event module
	-Removed now unused EventRegistry API calls for Classic Vanilla
	-Removed now unused UICheckButtonTemplate .text fallback for Classic Vanilla

v3.2 (2023-07-16)
	-Dragon Flight 10.1.5 Support
	-Added native support for Blizzard's canvas options layout to Classic
	-Tweaked ScrollingMessageFrame display code to mitigate a Blizzard bug causing uninteractable links
	-Fixed race icons being scrambled

v3.1 (2023-05-26)
	-Fixed Events_UnregisterEvent() calling the wrong API functions for Classic Vanilla

v3.0 (2023-05-21)
	-Rewrote addon core from scratch
	-New modular design allows easier maintenance
	-Rewrote hooks to modify ScrollingMessageFrame's display code rather than the message history
	-Fixed texture duplication when popping messages out from a ChatFrame
	-Enabled CombatLog parsing (may disable again if performance suffers)
	-Added localization capability

v2.17 (2023-01-18)
	-Rewrote hooks to attach to ScrollingMessageFrame's intrinsic code
	-Fixed WotLK Classic switching to using .Text for the UICheckButtonTemplate's button text

v2.16 (2022-11-10)
	-Fixed Vanilla Classic race icon map
	-Fixed core module reading from defaults instead of SavedVar

v2.15 (2022-11-09)
	-Rewrote parts of the options system
	-Fixed panel functions no longer being called in Dragon Flight

v2.14 (2022-11-06)
	-Dragon Flight 10.0 Support
	-Dracthyr race and Evoker class icons added
	-Fixed race icons being scrambled
	-Moved icon maps to their own file
	-Icon maps now load based on ToC version

v2.13 (2022-09-22)
	-Fixed WOW_PROJECT_ID change in Wrath Classic (Build 45435)

v2.12 (2021-12-20)
	-Disabled BNPlayer link parsing

v2.11 (2021-05-22)
	-Fixed GetCurrencyInfo() call

v2.10 (2021-05-21)
	-Multi-ToC build implemented
	-Errors in the conversion function now show instead of being silently discarded
	-Fixed (previously silent) error when GetPlayerInfoByGUID() doesn't return info
	-Cleaned up unused locals in the race icon definitions

v2.9 (2021-04-14)
	-Fixed missing version enum in Classic Vanilla

v2.8 (2021-04-14)
	-Fixed Classic Burning Crusade client check

v2.7 (2021-04-05)
	-Fixed missing "IconSize" in Classic icon table

v2.6 (2021-04-02)
	-Classic Burning Crusade Support
	-Added Draenei and Blood Elf race icons for Classic Burning Crusade

v2.5 (2021-03-27)
	-Fixed BNplayer link parsing error

v2.4 (2020-11-25)
	-Switched to using CreateAtlasMarkup() for Pawn's upgrade arrow

v2.3 (2020-10-14)
	-Shadowlands 9.0 Support
	-Fixed race icons being scrambled
	-Workaround for missing GetAtlasInfo() in 9.0

v2.2 (2020-02-03)
	-Consolidated Classic and Modern versions into the same source code

v2.1 (2019-10-24)
	-BfA 8.3 PTR-ready
	-Fixed race icons being scrambled again (since 8.2.5)
	-Added Vulpera and Mechagnome races

v2.0 (2019-05-19)
	-Classic version available (uses UI-CharacterCreate-Races textures instead of CharacterCreateIcons)
	-Rewrote hook to use built-in MessageFilters
	-Support for CombatLog was dropped
	-Player links are now handled by hooking the link generators in ItemRef.lua
	-Fixed link color not resetting when the Pawn upgrade icon is shown

v1.7 (2019-04-28)
	-Fixed both "Draenei" racial icon pairs not showing
	-Link caching has been removed due to possible memory issues

v1.6 (2019-04-11)
	-BfA 8.1 Support
	-Icons added for the 8 Allied Races
	-Changed the Race/Gender initialization to make it easier to maintain
	-Fixed the Pawn upgrade icon corrupting item relinks

v1.5 (2017-02-03)
	-Pawn integration
	-Adds green upgrade arrow to the end of item links if it's an upgrade

v1.4 (2016-10-25)
	-Fixed 7.1 change to ScrollingMessageFrames

v1.3 (2016-06-14)
	-Legion Support
	-Added Demon Hunter icon and support for Wardrobe System links
	-Revamped link rewrite code
	-Fixed options panel refresh
	-Hidden anti-duplication signature no longer uses a blank texture

v1.2 (2012-07-01)
	-MoP Support
	-Added Pandaren race and Monk class icons
	-Fixed icon duplication when popping channels and whispers out into new window

v1.1 (2011-07-21)
	-Recoded options frame
	-Added the option to show/hide specific icons in player links
	-Fixed a glitch involving relinking copying textures in chat

v1.0 (2011-07-19)
	-Initial Version
