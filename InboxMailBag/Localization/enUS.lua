local L = LibStub("AceLocale-3.0"):NewLocale("InboxMailbag", "enUS", true)

if L then
	L["BAGNAME"] = "Bag"
	L["FRAMENAME"] = "Inbox Mailbag"
	L["Group Stacks"] = true
	
	L["DELETED_1"] = "%s from %s |cffFF2020 Deleted in %s|r"
	L["RETURNED_1"] = "%s from %s |cffFF2020 Returned in %s|r"
	L["DELETED_7"]  = "%s from %s |cffFF6020 Deleted in %d |4Day:Days;|r"
	L["RETURNED_7"] = "%s from %s |cffFFA020 Returned in %d |4Day:Days;|r"
	L["DELETED"]    = "%s from %s |cff20FF20 Deleted in %d |4Day:Days;|r"
	L["RETURNED"]   = "%s from %s |cff20FF20 Returned in %d |4Day:Days;|r"

	L["TOTAL"]      = "Total messages: %d"
	L["TOTAL_MORE"] = "Total messages: %d (%d)"
	
	L["Advanced"] = true
	L["ADVANCED_MODE_DESC"] = "Enable Advanced mode. Displaying more information about your mailbox, and allowing stacks of gold to be retrieved as well."
	L["ADVANCED_MODE_ENABLED"] =  "|cff00ff96InboxMailbag: Advanced mode|r enabled"
	L["ADVANCED_MODE_DISABLED"] = "|cff00ff96InboxMailbag: Advanced mode|r disabled"

	L["Quality Colors"] = true
	L["QUALITY_COLOR_MODE_DESC"] = "Enable the display of item quality via the item's border."
	L["QUALITY_COLORS_MODE_ENABLED"] =  "|cff00ff96InboxMailbag: Quality Colors|r enabled"
	L["QUALITY_COLORS_MODE_DISABLED"] = "|cff00ff96InboxMailbag: Quality Colors|r disabled"

	L["MAIL_DEFAULT"] = "Default to Mailbag"
	L["MAIL_DEFAULT_DESC"] = "Enabling this will cause the Mailbox to initially open to Inbox Mailbag instead of the normal %s"
	L["MAIL_DEFAULT_ENABLED"] =  "|cff00ff96InboxMailbag: Mailbox will default to|r Inbox Mailbag"
	L["MAIL_DEFAULT_DISABLED"] = "|cff00ff96InboxMailbag: Mailbox will default to|r %s"
end