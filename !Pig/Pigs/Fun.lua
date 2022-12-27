local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
-------------
function table.removekey(table, key)
    local element = table[key]
    table[key] = nil
    return element
end
function PIG_print(msg)
	print("|cff00FFFF!Pig:|r|cffFFFF00"..msg.."！|r");
end
----
local OLD_SetRotation=SetRotation
function PIGRotation(self,dushu)
	local angle = math.rad(dushu)
	self:SetRotation(angle)
end

function PIGEnable(self)
	self:Enable() self.Text:SetTextColor(1, 1, 1, 1) 
end
function PIGDisable(self)
	self:Disable() self.Text:SetTextColor(0.4, 0.4, 0.4, 1) 
end
---
if tocversion<40000 then
	PIG_InviteUnit=InviteUnit
else
	PIG_InviteUnit=C_PartyInfo.InviteUnit
	--PIG_InviteUnit=C_PartyInfo.ConfirmInviteUnit
end