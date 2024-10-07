--版本控制：1.9.3 新增/sw tl命令
local AddonName, Addon = ...

local L = Addon.L

SLASH_MLC1 = "/maillogger"
SLASH_MLC2 = "/ml"

SlashCmdList["MLC"] = function(Command)
	if Command:lower() == "gui" then
		if Addon.SetWindow.background:IsShown() then
			Addon.SetWindow.background:Hide()
		else
			Addon.SetWindow.background:Show()
		end
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
		Addon:GetAvailableDate()
		Addon.Calendar.background:Show()
		Addon:RefreshCalendar()
	elseif Command:lower() == "maillog" or Command:lower() == "ml" then
		Addon.Output.dropdowntitle:Show()
		Addon.Output.dropdownlist:Show()
		Addon.Output.dropdownbutton:Show()
		Addon:PrintTradeLog("MAIL", nil)
		Addon:GetAvailableDate()
		Addon.Calendar.background:Show()
		Addon:RefreshCalendar()
	elseif Command:lower() == "sent" or Command:lower() == "sm" then
		Addon.Output.dropdowntitle:Show()
		Addon.Output.dropdownlist:Show()
		Addon.Output.dropdownbutton:Show()
		Addon:PrintTradeLog("SMAIL", nil)
		Addon:GetAvailableDate()
		Addon.Calendar.background:Show()
		Addon:RefreshCalendar()
	elseif Command:lower() == "received" or Command:lower() == "rm" then
		Addon.Output.dropdowntitle:Show()
		Addon.Output.dropdownlist:Show()
		Addon.Output.dropdownbutton:Show()
		Addon:PrintTradeLog("RMAIL", nil)
		Addon:GetAvailableDate()
		Addon.Calendar.background:Show()
		Addon:RefreshCalendar()
	else
		print(L["MAILLOGGER TIPS"])
	end
end