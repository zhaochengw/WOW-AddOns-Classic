local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local GUI = PetBattleTeams:GetModule("GUI")
local HEAL_PET_SPELL = 125439

-- luacheck: globals PetJournalHealPetButton_OnEnter

local PetJournalHealPetButton_OnEnter = PetJournalHealPetButton_OnEnter or function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT");
    GameTooltip:SetSpellByID(HEAL_PET_SPELL)
end

local function OnEvent(self,event)
    if event == "SPELL_UPDATE_COOLDOWN"  then
        local spellCD = C_Spell.GetSpellCooldown(self.spellID)
        local startTime, duration, isEnabled = spellCD.startTime, spellCD.duration, spellCD.isEnabled;
        CooldownFrame_Set(self.Cooldown, startTime, duration, isEnabled)
        if ( GameTooltip:GetOwner() == self ) then
            PetJournalHealPetButton_OnEnter(self)
        end
    end
end

local function OnLeave()
    GameTooltip:Hide()
end

local function OnShow(self)
    self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
end

local function OnHide(self)
    self:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
end

function GUI:CreateReviveButton(name,parent)
    local spellInfo = C_Spell.GetSpellInfo(HEAL_PET_SPELL)
    local spellName, spellIcon = spellInfo.name, spellInfo.iconID;
    local spellCD = C_Spell.GetSpellCooldown(HEAL_PET_SPELL);
    local startTime, duration, isEnabled = spellCD.startTime, spellCD.duration, spellCD.isEnabled;

    local button = CreateFrame("Button",parent:GetName()..name,UIParent,"secureactionbuttontemplate")
    button:EnableMouse(true);
    button:RegisterForClicks("AnyUp", "AnyDown");
    button:SetAttribute("type", "spell")
    button.spellID = HEAL_PET_SPELL
    button:SetAttribute("spell",spellName)
    button:SetSize(38,38)

    button.Icon = button:CreateTexture(name.."Icon","ARTWORK")
    button.Icon:SetTexture(spellIcon)
    button.Icon:SetAllPoints()

    button.Border = button:CreateTexture(name.."Border","OVERLAY","ActionBarFlyoutButton-IconFrame")
    button:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
    button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square","ADD")

    button.Cooldown = CreateFrame("Cooldown", name.."Cooldown",button, "CooldownFrameTemplate")
    CooldownFrame_Set(button.Cooldown, startTime, duration, isEnabled)

    button:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    button:RegisterEvent("PLAYER_REGEN_DISABLED")
    button:RegisterEvent("PLAYER_REGEN_ENABLED")

    button:SetScript("OnEvent", OnEvent)
    button:SetScript("OnShow", OnShow)
    button:SetScript("OnHide",OnHide)
    button:SetScript("OnEnter", PetJournalHealPetButton_OnEnter )
    button:SetScript("OnLeave",OnLeave)

    return button
end

