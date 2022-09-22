local _, PTT_L   = ...
local locale = GetLocale()

local function badString (PTT_L, key)
	return "BAD TEXT \"".. (key or "NIL") .. "\""
end

setmetatable (PTT_L, {__index=badString})

-- ENGLISH DEFAULTS


PTT_L["COL_4"]	= "Listed"
PTT_L["COL_5"]	= "Expires"

PTT_L["COL_7"]	= "Alts"
PTT_L["COL_8"]	= "Active"
PTT_L["COL_9"]	= "Description"
PTT_L["COL_10"]	= "Filter"






PTT_L["ON"]		= "ON"
PTT_L["OFF"]	= "OFF"
PTT_L["DAY"]	= "day"
PTT_L["DAYS"]	= "days"
PTT_L["EXP_NVR"]	= "Never"
PTT_L["EXP_TDY"]	= "Today"
PTT_L["LIST_1"]	= "Characters on ignore for %d or more days:"
PTT_L["LIST_2"]	= "All ignored NPC characters:"
PTT_L["LIST_3"]	= "All ignored players on server %s:"
PTT_L["LIST_4"]	= "All characters on global ignore:"
PTT_L["LIST_5"]	= "Listed %d character(s)"
PTT_L["SYNC_1"]	= "Removing %s from character's ignore list"
PTT_L["SYNC_2"]	= "Adding %s to character's ignore list"
--"打开配置页面请输入 /PlayTag"	= "打开配置页面请输入 /PlayTag"
PTT_L["LOAD_2"]	= "New character found: Importing ignored players"
PTT_L["LOAD_3"]	= "Adding %s to global ignore list"
PTT_L["LOAD_4"] = "Synchronizing Ignore list..."
PTT_L["LOAD_5"] = "WARNING: Synchronization could not be preformed at this time because there were |cffffff00%s|cffffffff player(s) on Blizzard's ignore list reported as \"%s\". If synchronization continues to fail, the unknown player may need to be manually removed from Blizzard ignore list.  The list will try to synchronize the next time the GUI is opened, or by typing /gi sync in chat."
--"查看标签"	= "Edit note"
--"取消2"	= "Set Expiration"
PTT_L["RCM_3"]	= "Reset Expiration"


PTT_L["RCM_6"]  = "Add to Ignore"
PTT_L["OVER_1"]	= "Realm:"
PTT_L["OVER_2"]	= "Faction:"
PTT_L["OVER_3"]	= "Ignored:"
PTT_L["OVER_4"]	= "Expires:"
PTT_L["OVER_5"]	= "After %d day(s) (%d day(s) from today)"
PTT_L["ADD_1"]	= "%s is already ignored"
PTT_L["ADD_2"]	= "%s added to global ignore"
PTT_L["ADD_3"]	= "You cannot ignore yourself, silly!"
PTT_L["ADD_4"]	= "Cannot ignore player due to Blizzard bug. Try ignoring again"
PTT_L["REM_1"]	= "%s removed from global ignore"
PTT_L["BOX_1"]	= "Remove after how many days on the list?\n(Use 0 to disable expiration)"
PTT_L["BOX_2"]	= "Are you sure you wish to reset to the latest default spam filters?  You will lose all custom filters!"


--"知道了"  = "Accept"
PTT_L["BOX_7"]  = "|cffffff00INVITE WARNING: %s\n\n|cffffffffThis player is on your Global Ignore List.  Do you still want to invite them?\n"
--"|cffffff00警告：\n\n|cffffffff该团队有 |cffffff00%d |cffffffff名玩家存在负面标记:\n|cff69CCF0%s\n"  = "|cffffff00PARTY WARNING\n\n|cffffffffThere are |cffffff00%d |cffffffffplayer(s) on your ignore list in group:\n|cff69CCF0%s\n"
PTT_L["BOX_9"]	= "Are you sure wish to remove the selected filter?"
PTT_L["BOX_10"] = "Remove"
PTT_L["CMD_1"]	= "WARNING: You will remove all ignores on all characters on all servers. Type \"/gi clear confirm\" to clear the list"
PTT_L["CMD_2"]	= "Database cleared"
PTT_L["CMD_3"]	= "Newly ignored players will now be automatically removed after |cffffff00%d|cffffffff %s.  Existing ignored players will be unaffected.  If you want to disable auto expire, set this value to zero (0)."
PTT_L["CMD_4"]	= "Asking for ignore note when a player is ignored is now |cffffff00on"
PTT_L["CMD_5"]	= "Asking for ignore note when a player is ignored is now |cffffff00off"
PTT_L["CMD_6"]	= "Synchronization messages are now |cffffff00on"
PTT_L["CMD_7"]	= "Synchronization messages are now |cffffff00off"
PTT_L["CMD_8"]	= "UNUSED"
PTT_L["CMD_9"]	= "UNUSED"
PTT_L["CMD_10"]	= "Only sync same server characters is now |cffffff00on"
PTT_L["CMD_11"]	= "Only sync same server characters is now |cffffff00off"
PTT_L["CMD_12"]	= "|cffffff00%s|cffffffff has been removed from NPC ignore list"
PTT_L["CMD_13"]	= "|cffffff00%s|cffffffff has been added to NPC ignore list"
PTT_L["CMD_14"]	= "%s will be automatically removed after %d days."
PTT_L["CMD_15"]	= "Invalid command please double check what you've typed"
PTT_L["CMD_16"]	= "Remove players that have been ignored for |cffffff00%d|cffffffff or more days"
PTT_L["CMD_17"]	= "Type |cffffff00/gi prune confirm|cffffffff to prune |cffffff00%d|cffffffff players"
PTT_L["CMD_18"]	= "|cffffff00%s|cffffffff added to server ignore list"
PTT_L["CMD_19"]	= "|cffffff00%s|cffffffff removed from server ignore list"
PTT_L["HELP_1"]	= "|cffff99ffTYPE: |cffffffff/gi [command], where [command] is one of:"
PTT_L["HELP_2"]	= "|cffffff00list|cffffffff: List all players on global ignore list"
PTT_L["HELP_3"]	= "|cffffff00clear|cffffffff: Clear all names from global ignore list"
PTT_L["HELP_4"]	= "|cffffff00add player|cffffffff: Add [player] to ignore list"
PTT_L["HELP_5"]	= "|cffffff00remove player|cffffffff: Remove [player] from ignore list"
PTT_L["HELP_6"]	= "|cffffff00expire player days|cffffffff: Remove [player] from list after [days]"
PTT_L["HELP_7"]	= "|cffffff00prune days|cffffffff: Remove those on list for [days] or more days"
PTT_L["HELP_8"]	= "|cffffff00npc npcname|cffffffff: Add or remove an NPC character ignore"
PTT_L["HELP_9"]	= "|cffffff00sync|cffffffff: Synchronize ignore list"
PTT_L["HELP_10"]	= "|cffffff00showmsg on|off|cffffffff: Show actions during synchronization (%s)"
PTT_L["HELP_11"]	= "|cffffff00sameserver on|off|cffffffff: Only add same-server characters to account wide ignore (%s)"
PTT_L["HELP_12"]	= "|cffffff00defexpire days|cffffffff: Newly ignored players auto expire after (|cffffff00%d|cffffffff) days"
PTT_L["HELP_13"]	= "|cffffff00asknote on|off|cffffffff: Ask for ignore note on ignore (%s)"
PTT_L["HELP_14"]	= "|cffff99ffNOTE: |cffffffffUse /ignore, and UI as usual to add/remove players!"
PTT_L["HELP_15"]	= "|cffffff00server servername|cffffffff: Add or remove an entire server ignore"
PTT_L["HELP_16"]	= "|cffffff00gui|cffffffff: Open GIL user interface"
--"警告: 这个团队有 %d 个玩家存在负面标签: |cffffff00%s"	= "WARNING: There are %d ignored player(s) in this group: |cffffff00%s"
PTT_L["MSG_1"]	= "[Global Ignore List] You are being ignored."


PTT_L["BUT_2"]	= "Ignore Player"
PTT_L["BUT_3"]	= "Ignore NPC"
PTT_L["BUT_4"]	= "Ignore Server"
PTT_L["BUT_5"]	= "Create Filter"
PTT_L["BUT_6"]	= "Remove Filter"
PTT_L["BUT_7"]	= "Reset Defaults"
PTT_L["TAB_1"]	= "Ignore List"
PTT_L["TAB_2"]	= "Spam Filters"
PTT_L["TAB_3"]	= "Options"

PTT_L["INFO_2"]	= "Your spam filters have blocked a total of |cffffff00%d|cffffffff spammers"
PTT_L["INFO_3"]	= "This filter has blocked |cffffff00%d|cffffffff spammers"
PTT_L["OPT_1"]	= "Ask for note after adding a new ignore"
PTT_L["OPT_2"]	= "Open Global Ignore UI with Blizzard Friends/Ignore UI"
PTT_L["OPT_3"]	= "UNUSED"
PTT_L["OPT_4"]	= "Only add same server players to account-wide ignore (highly recommended on)"
PTT_L["OPT_5"]	= "Default expiration days for newly added ignores (Use 0 for never)"
PTT_L["OPT_6"]	= "Attempt to track character name changes and deleted characters (account wide ignore only)"
PTT_L["OPT_7"]	= "Enable chat spam filtering"
PTT_L["OPT_8"]	= "Ignore List Options:"
PTT_L["OPT_9"]	= "Spam Filtering Options:"
PTT_L["OPT_10"]	= "Perform reverse spam filtering (not recommended)"
PTT_L["OPT_11"] = "Automatically update default Spam Filters"
PTT_L["OPT_12"] = "Never filter Guild chat"
PTT_L["OPT_13"] = "Never filter Party/Group chat"
PTT_L["OPT_14"] = "Never filter private chat"
PTT_L["TIP_1"]  = "|cffffffffFilter Editing Help\n\n|cffffff00Enter chat filter in the box below.  Chat text is converted to lower cased letters before\napplying filters, so all filters must be defined using lower cased letters only.\n\nAny links entered into the edit box will be automatically converted to the appropriate\nfilter tag.\n\nPlease view the website for more detailed information on creating chat filters."
PTT_L["TIP_2"]  = "|cffffffffFilter Testing Help\n\n|cffffff00Enter chat text into the Filter Testing box and GIL will apply the current filter\nto the contents in the box whenever the Test button is clicked.\n\nThe result of the applied filter is shown as BLOCKED if the text would be\nfiltered, or PASSED if the text would not be filtered."

-- GERMAN
if locale == "deDE" then
end

-- PORTUGUESE
if locale == "ptBR" then
end

-- FRENCH
if locale == "frFR" then
end

-- RUSSIAN
if locale == "ruRU" then
end

-- SPANISH (SPAIN AND MEXICO)
if (locale == "esES") or (locale == "esMX") then
end

-- CHINESE (CHINA)
if locale == "zhCN" then
end

-- CHINESE (TAIWAN)
if locale == "zhTW" then
end

-- KOREAN
if locale == "koKR" then
end

-- ITALIAN
if locale == "itIT" then
end
