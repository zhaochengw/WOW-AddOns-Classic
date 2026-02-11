local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local GUI = PetBattleTeams:GetModule("GUI")

function GUI:CreateLockTeamsButton()

    local lockTeamsButton = CreateFrame("CheckButton")
    lockTeamsButton:SetChecked(false);
    lockTeamsButton:SetSize(32,32)
    lockTeamsButton:SetNormalTexture("Interface\\Buttons\\LockButton-Locked-Up")
    lockTeamsButton:SetPushedTexture("Interface\\Buttons\\LockButton-Unlocked-Down")
    lockTeamsButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight","ADD")
    lockTeamsButton:SetCheckedTexture("Interface\\Buttons\\LockButton-Unlocked-Up")

    return lockTeamsButton
end
