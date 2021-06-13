--版本控制：1.9.3 新增/sw tl命令
local AddonName, Addon = ...

local L = Addon.L

SLASH_SWC1 = "/spellwhisper"
SLASH_SWC2 = "/sw"

SlashCmdList["SWC"] = function(Input)
    local Command, Rest = Input:match("^(%S*)%s*(.-)$")
	if Command:lower() == "gui" then
		if not UnitAffectingCombat("player") then
			InterfaceOptionsFrame_OpenToCategory("SpellWhisper")
			InterfaceOptionsFrame_OpenToCategory("SpellWhisper")
		else
			print(L["<|cFFBA55D3SW|r>Can NOT Open |cFFBA55D3SpellWhisper|r GUI when you in COMBAT."])
		end
	elseif Command:lower() == "unlock" then
		Addon.Warning:Show()
		Addon.Warning.Text:Show()
		Addon.Warning:SetMovable(true)
		Addon.Warning:EnableMouse(true)
		Addon.Warning.Text:SetText(L["Use Mouse Middle Button to Move"])
		print(L["<|cFFBA55D3SW|r>The HUD Frame is Unlocked!"])
	elseif Command:lower() == "lock" then
		if Addon.Config.OutputChannel ~= "hud" then
			Addon.Warning:Hide()
			Addon.Warning.Text:Hide()
		end
		Addon.Warning:SetMovable(false)
		Addon.Warning:EnableMouse(false)
		Addon.Warning.Text:SetText("")
		print(L["<|cFFBA55D3SW|r>The HUD Frame is Locked!"])
		Addon.Config.HUDPos[1], _, Addon.Config.HUDPos[3], Addon.Config.HUDPos[4], Addon.Config.HUDPos[5] = Addon.Warning:GetPoint()
	elseif Command:lower() == "reset" then
		Addon.Warning:SetPoint("CENTER", nil, "CENTER", 0, 240)
		print(L["<|cFFBA55D3SW|r>The HUD Frame Position is Reset!"])
	elseif Command:lower() == "f" or Command:lower() == "follow" then
		Addon.Followed.FromWhisper = false
		Addon:FollowTargetUnit(UnitGUID("target"), Addon.Config.StartFollow)
		print(string.format(L["<|cFFBA55D3SW|r>Start Super Follow <%s>!"], GetUnitName("target", true)))
	elseif Command:lower() == "in" then
		if Rest then
			local Delay, Task = Rest:match("([%d.]+)%s*(.+)")
			Delay = tonumber(Delay)
			Task = strtrim(Task or "")
			if Delay and Delay > 0 and Task ~= "" then
				if not Addon.Frame:IsShown() then
					Addon.Frame:Show()
				end
				Addon:NewTask(Delay, Task)
			else
				print(L["|cFFBA55D3SpellWhisper|r Delay Command Tips: Please Input |cFF00E09EValid|r |cFFCCA4E3[Seconds]|r and |cFF00E09ELegal|r |cFFCCA4E3[Command]|r!"])
			end
		else
			print(L["|cFFBA55D3SpellWhisper|r Delay Command Tips:Use |cFF00BFFF/spellwhisper|r |cFFFF0000in|r |cFFCCA4E3[Seconds] [Task]|r or |cFF00BFFF/sw|r |cFFCCA4E3in [Seconds] [Task]|r create a Delay Task."])
		end
	else
		print(L["SPELLWHISPER TIPS"])
	end
end