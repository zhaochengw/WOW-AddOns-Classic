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