--版本控制：1.9.3 新增/sw tl命令
local AddonName, Addon = ...

local L = Addon.L

SLASH_MLC1 = "/maillogger"
SLASH_MLC2 = "/ml"

SlashCmdList["MLC"] = function(Command)
	if Command:lower() == "gui" then
		InterfaceOptionsFrame_OpenToCategory("MailLogger")
		InterfaceOptionsFrame_OpenToCategory("MailLogger")
	elseif Command:lower() == "all" then
		Addon.Output.dropdowntitle:Show()
		Addon.Output.dropdownlist:Show()
		Addon.Output.dropdownbutton:Show()
		Addon:PrintTradeLog("ALL", nil)
		if Addon.Config.EnableCalendar then
			Addon:GetAvailableDate()
			Addon.Calendar.background:Show()
			Addon:RefreshCalendar()
		end
	elseif Command:lower() == "tradelog" or Command:lower() == "tl" then
		Addon.Output.dropdowntitle:Show()
		Addon.Output.dropdownlist:Show()
		Addon.Output.dropdownbutton:Show()
		Addon:PrintTradeLog("TRADE", nil)
		if Addon.Config.EnableCalendar then
			Addon:GetAvailableDate()
			Addon.Calendar.background:Show()
			Addon:RefreshCalendar()
		end
	elseif Command:lower() == "maillog" or Command:lower() == "ml" then
		Addon.Output.dropdowntitle:Show()
		Addon.Output.dropdownlist:Show()
		Addon.Output.dropdownbutton:Show()
		Addon:PrintTradeLog("MAIL", nil)
		if Addon.Config.EnableCalendar then
			Addon:GetAvailableDate()
			Addon.Calendar.background:Show()
			Addon:RefreshCalendar()
		end
	elseif Command:lower() == "sent" or Command:lower() == "sm" then
		Addon.Output.dropdowntitle:Show()
		Addon.Output.dropdownlist:Show()
		Addon.Output.dropdownbutton:Show()
		Addon:PrintTradeLog("SMAIL", nil)
		if Addon.Config.EnableCalendar then
			Addon:GetAvailableDate()
			Addon.Calendar.background:Show()
			Addon:RefreshCalendar()
		end
	elseif Command:lower() == "received" or Command:lower() == "rm" then
		Addon.Output.dropdowntitle:Show()
		Addon.Output.dropdownlist:Show()
		Addon.Output.dropdownbutton:Show()
		Addon:PrintTradeLog("RMAIL", nil)
		if Addon.Config.EnableCalendar then
			Addon:GetAvailableDate()
			Addon.Calendar.background:Show()
			Addon:RefreshCalendar()
		end
	else
		print(L["MAILLOGGER TIPS"])
	end
end