local modifier = "shift" -- shift, alt or ctrl
local mouseButton = "1" -- 1 = left, 2 = right, 3 = middle, 4 and 5 = thumb buttons if there are any

local function SetFocusHotkey(frame)
frame:SetAttribute(modifier.."-type"..mouseButton,"focus")
end

local function CreateFrame_Hook(type, name, parent, template)
if template == "SecureUnitButtonTemplate" then
SetFocusHotkey(_G[name])
end
end

hooksecurefunc("CreateFrame", CreateFrame_Hook)

-- Keybinding override so that models can be shift/alt/ctrl+clicked
local f = CreateFrame("CheckButton", "FocuserButton", UIParent, "SecureActionButtonTemplate")
f:SetAttribute("type1","macro")
f:SetAttribute("macrotext","/focus mouseover")
SetOverrideBindingClick(FocuserButton,true,modifier.."-BUTTON"..mouseButton,"FocuserButton")

-- Set the keybindings on the default unit frames since we won't get any CreateFrame notification about them
local duf = {
PlayerFrame,
PetFrame,
PartyMemberFrame1,
PartyMemberFrame2,
PartyMemberFrame3,
PartyMemberFrame4,
PartyMemberFrame1PetFrame,
PartyMemberFrame2PetFrame,
PartyMemberFrame3PetFrame,
PartyMemberFrame4PetFrame,
TargetFrame,
TargetofTargetFrame,
ElvUF_Player,
ElvUF_Target,
ElvUF_TargetTarget,
ElvUF_PartyGroup1UnitButton1,
ElvUF_PartyGroup1UnitButton2,
ElvUF_PartyGroup1UnitButton3,
ElvUF_PartyGroup1UnitButton4,
ElvUF_PartyGroup1UnitButton5,
ElvUF_Raid40Group1UnitButton1,
ElvUF_Raid40Group1UnitButton2,
ElvUF_Raid40Group1UnitButton3,
ElvUF_Raid40Group1UnitButton4,
ElvUF_Raid40Group1UnitButton5,
ElvUF_Raid40Group2UnitButton1,
ElvUF_Raid40Group2UnitButton2,
ElvUF_Raid40Group2UnitButton3,
ElvUF_Raid40Group2UnitButton4,
ElvUF_Raid40Group2UnitButton5,
ElvUF_Raid40Group3UnitButton1,
ElvUF_Raid40Group3UnitButton2,
ElvUF_Raid40Group3UnitButton3,
ElvUF_Raid40Group3UnitButton4,
ElvUF_Raid40Group3UnitButton5,
ElvUF_Raid40Group4UnitButton1,
ElvUF_Raid40Group4UnitButton2,
ElvUF_Raid40Group4UnitButton3,
ElvUF_Raid40Group4UnitButton4,
ElvUF_Raid40Group4UnitButton5,
ElvUF_Raid40Group5UnitButton1,
ElvUF_Raid40Group5UnitButton2,
ElvUF_Raid40Group5UnitButton3,
ElvUF_Raid40Group5UnitButton4,
ElvUF_Raid40Group5UnitButton5,
ElvUF_Raid40Group6UnitButton1,
ElvUF_Raid40Group6UnitButton2,
ElvUF_Raid40Group6UnitButton3,
ElvUF_Raid40Group6UnitButton4,
ElvUF_Raid40Group6UnitButton5,
ElvUF_Raid40Group7UnitButton1,
ElvUF_Raid40Group7UnitButton2,
ElvUF_Raid40Group7UnitButton3,
ElvUF_Raid40Group7UnitButton4,
ElvUF_Raid40Group7UnitButton5,
ElvUF_Raid40Group8UnitButton1,
ElvUF_Raid40Group8UnitButton2,
ElvUF_Raid40Group8UnitButton3,
ElvUF_Raid40Group8UnitButton4,
ElvUF_Raid40Group8UnitButton5,
}

for i,frame in pairs(duf) do
SetFocusHotkey(frame)
end


--露露备注：引用自https://nga.178.com/read.php?tid=14876118&page=2&rand=796




-- --姓名版代码
-- local prefix = "GuildFrameButton%sName"
-- local s = ""
-- for i=1,20 do s = prefix:format(i) if _G[s] then _G[s]:SetFont(STANDARD_TEXT_FONT, 14) end end

-- --地区代码
-- local prefix = "GuildFrameButton%sZone"
-- local s = ""
-- for i=1,20 do s = prefix:format(i) if _G[s] then _G[s]:SetFont(STANDARD_TEXT_FONT, 12) end end

-- --等级代码
-- local prefix = "GuildFrameButton%sLevel"
-- local s = ""
-- for i=1,20 do s = prefix:format(i) if _G[s] then _G[s]:SetFont(STANDARD_TEXT_FONT, 10) end end
-- --露露备注：引用自https://nga.178.com/read.php?tid=33157093&_fp=5