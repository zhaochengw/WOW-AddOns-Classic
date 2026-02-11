local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local Tooltip = PetBattleTeams:NewModule("Tooltip")
local teamManager = PetBattleTeams:GetModule("TeamManager")
local libPetBreedInfo = LibStub("LibPetBreedInfo-1.0")


local nameFormat = "|c%s%s|r"
local nameBreedFormat = "|c%s%s|r %s%s|r"
local function GetColor(confidence)
    if confidence and confidence < 2.5 then
        return "|cff888888"
    end
    return "|cffffcc00"
end

local _, addon = ...
local L = addon.L

local FRAME_HEIGHT_NO_TT = 215
local FRAME_HEIGHT_WITH_TT = 288 -- This height should include the help text

-- Define colors for clarity and reusability
local COLOR_GREEN = {0, 1, 0}
local COLOR_RED = {1, 0, 0}
local COLOR_WHITE = {1, 1, 1}
local COLOR_DISABLED = {.5, .5, .5}
local PET_ABILITIES = 3

local function tooltipText()
    local fullHelpText = L["Drag to swap pets between teams.|nShift-Drag to copy pet to a new team.|nControl-Drag to move team."]
    if teamManager:GetSortTeams() then
        local lastNPosInReversed = fullHelpText:reverse():find("n|")
        if lastNPosInReversed then
            local len = #fullHelpText
            local originalStartPos = len - lastNPosInReversed - 1
            fullHelpText = fullHelpText:sub(1, originalStartPos) .. "|n".. GetColor(1) .. fullHelpText:sub(originalStartPos + 3) .. "|r"
        end
    end
    return fullHelpText
end

function Tooltip:OnInitialize()

    local defaults = {
        global = {
            ShowHelpText = true,
            ShowStrongWeakHints = true,
            ShowBreedInfo = false,
        }
    }

    -- Assuming the .toc says ## SavedVariables: MyAddonDB
    local db = LibStub("AceDB-3.0"):New("PetBattleTeamsDB", {} , true)
    local name = self:GetName()
    self.db = db:RegisterNamespace(name, defaults)

    self.tooltip =  CreateFrame("frame","PetBattleTeamsTooltip",nil,"PetBattleUnitTooltipTemplate")
    local tooltip = self.tooltip
    tooltip:SetHeight(FRAME_HEIGHT_NO_TT)

    --icon quality glow
    tooltip.rarityGlow = tooltip:CreateTexture("PetBattleTeamTooltipGlow","OVERLAY")
    tooltip.rarityGlow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
    tooltip.rarityGlow:SetBlendMode("ADD")
    tooltip.rarityGlow:ClearAllPoints()
    tooltip.rarityGlow:SetDrawLayer("OVERLAY", 0)
    tooltip.rarityGlow:SetWidth(tooltip.Icon:GetWidth() * 1.7)
    tooltip.rarityGlow:SetHeight(tooltip.Icon:GetHeight() * 1.7)
    tooltip.rarityGlow:SetPoint("CENTER", tooltip.Icon, "CENTER", 0, 0)

    --team indicator
    tooltip.teamText = tooltip:CreateFontString("PetBattleTeamTooltipTeamText","OVERLAY","GameFontNormalSmall")
    tooltip.teamText:SetJustifyH("LEFT")
    tooltip.teamText:SetText(L["Team XX"])
    tooltip.teamText:SetTextColor(1,1,1)
    tooltip.teamText:SetSize(0,0)
    tooltip.teamText:SetFont(L["FONT"],L["FONT_SIZE_12"],"OUTLINE")
    tooltip.teamText:SetPoint("BOTTOMLEFT",tooltip.Name,"TOPLEFT",0,2)
    tooltip.teamText:SetPoint("BOTTOMRIGHT",tooltip.Name,"TOPRIGHT",0,2)

    --Helper Text
    tooltip.helpText = tooltip:CreateFontString("PetBattleTeamTooltipHelperText","OVERLAY","GameFontNormalSmall")
    tooltip.helpText:SetJustifyH("LEFT")
    tooltip.helpText:SetText(tooltipText())
    tooltip.helpText:SetTextColor(0,1,0)
    tooltip.helpText:SetSize(0,0)
    tooltip.helpText:SetFont(L["FONT"],L["FONT_SIZE_12"],"OUTLINE")
    tooltip.helpText:SetPoint("BOTTOMLEFT",tooltip,"BOTTOMLEFT",14,8)
    tooltip.helpText:SetPoint("BOTTOMRIGHT",tooltip,"BOTTOMRIGHT",-6,8)

    -- Main Pet Type Resistances/Weaknesses (for the pet itself)
    -- The icons tooltip.resistantToTextures[1] and tooltip.weakToTextures[1] are part of the template.
    -- StrongTo percentage text
    tooltip.strongToText = tooltip:CreateFontString("PetBattleTeamTooltipStrongToText", "OVERLAY", "GameFontNormalTiny")
    tooltip.strongToText:SetJustifyH("CENTER")
    tooltip.strongToText:SetWidth(40)
    tooltip.strongToText:SetHeight(15)
    tooltip.strongToText:SetAlpha(.5)
    tooltip.strongToText:Hide()

    -- WeakTo percentage text
    tooltip.weakToText = tooltip:CreateFontString("PetBattleTeamTooltipWeakToText", "OVERLAY", "GameFontNormalTiny")
    tooltip.weakToText:SetJustifyH("CENTER")
    tooltip.weakToText:SetWidth(40)
    tooltip.weakToText:SetHeight(15)
    tooltip.weakToText:SetAlpha(.5)
    tooltip.weakToText:Hide()

    -- Ability Type Effectiveness (for all abilities)
    tooltip.abilityStrongIcons = {}
    tooltip.abilityWeakIcons = {}
    tooltip.abilityStrongArrows = {}
    tooltip.abilityWeakArrows = {}

    for i = 1, PET_ABILITIES do
        local strongIcon = tooltip:CreateTexture(nil, "OVERLAY", "PetBattleUnitTooltipPetTypeStrengthTemplate")
        strongIcon:SetSize(16, 16)
        strongIcon:Hide()
        tooltip.abilityStrongIcons[i] = strongIcon

        local weakIcon = tooltip:CreateTexture(nil, "OVERLAY", "PetBattleUnitTooltipPetTypeStrengthTemplate")
        weakIcon:SetSize(16, 16)
        weakIcon:Hide()
        tooltip.abilityWeakIcons[i] = weakIcon

        local strongArrow = tooltip:CreateTexture(nil, "OVERLAY", nil, 7)
        strongArrow:SetSize(12, 12)
        strongArrow:SetTexture("Interface\\PetBattles\\BattleBar-AbilityBadge-Strong-Small")
        strongArrow:Hide()
        tooltip.abilityStrongArrows[i] = strongArrow

        local weakArrow = tooltip:CreateTexture(nil, "OVERLAY", nil, 7)
        weakArrow:SetSize(12, 12)
        weakArrow:SetTexture("Interface\\PetBattles\\BattleBar-AbilityBadge-Weak-Small")
        weakArrow:Hide()
        tooltip.abilityWeakArrows[i] = weakArrow
    end

    --template parts
    tooltip.Delimiter2:Show()
    tooltip.Delimiter2:SetPoint("TOPLEFT",tooltip.helpText,"TOPLEFT", -9, 8)
    tooltip.Delimiter:SetPoint("LEFT", tooltip, "LEFT", 4, 0)
    tooltip.Delimiter:SetPoint("RIGHT", tooltip, "RIGHT", -4, 0)
    tooltip.Delimiter2:SetPoint("LEFT", tooltip, "LEFT", 4, 0)
    tooltip.Delimiter2:SetPoint("RIGHT", tooltip, "RIGHT", -4, 0)
    tooltip.AbilitiesLabel:Show()
    tooltip.XPBar:Show()
    tooltip.XPBG:Show()
    tooltip.XPBorder:Show()
    tooltip.XPText:Show()
    tooltip.teamText:Show()
    tooltip.WeakToLabel:Hide() -- Hide default labels as we use custom icons/text
    tooltip.ResistantToLabel:Hide()
end

function Tooltip:Attach(frame)
    local tooltip = self.tooltip
    self.owner = frame
    tooltip:SetParent(UIParent)
    tooltip:SetFrameStrata("TOOLTIP")
    tooltip:ClearAllPoints()

    tooltip:SetPoint("TOPLEFT", frame, "BOTTOMRIGHT", 0, 0)
    local left, bottom, width, height = tooltip:GetBoundsRect()

    if left + width > GetScreenWidth() then
        tooltip:ClearAllPoints()
        tooltip:SetPoint( "TOPRIGHT", frame, "BOTTOMLEFT", 0, 0)
    end
    if bottom < 0 then
        tooltip:ClearAllPoints()
        tooltip:SetPoint("BOTTOMRIGHT", frame, "TOPLEFT", 0, 0)
    end

    -- Height is set in SetUnit based on help text visibility
    tooltip:Show()
end

function Tooltip:Hide()
    self.tooltip:Hide()
end

function Tooltip:IsShown()
    return self.tooltip:IsShown()
end

function Tooltip:GetOwner()
    return self.owner
end

function Tooltip:SetShowHelpText(enabled)
    self.db.global.ShowHelpText = enabled
end

function Tooltip:GetShowHelpText()
    return self.db.global.ShowHelpText
end

function Tooltip:SetShowBreedInfo(enabled)
    self.db.global.ShowBreedInfo = enabled
end

function Tooltip:GetShowBreedInfo()
    return self.db.global.ShowBreedInfo
end

function Tooltip:SetShowStrongWeakHints(enabled)
    self.db.global.ShowStrongWeakHints = enabled
end

function Tooltip:GetShowStrongWeakHints()
    return self.db.global.ShowStrongWeakHints
end


local PET_TYPE_RECEIVED_DAMAGES = {
    [1] = {5, 4},   -- Humanoid:	Critter / Undead
    [2] = {3, 1},   -- Dragonkin:	Flying / Humanoid
    [3] = {8, 6},   -- Flying:	    Beast / Magic
    [4] = {2, 5},   -- Undead:	    Dragonkin / Critter
    [5] = {7, 8},   -- Critter:	    Elemental / Beast
    [6] = {9, 2},   -- Magic:	    Aquatic / Dragonkin
    [7] = {10, 9},  -- Elemental:	Mechanical / Aquatic
    [8] = {1, 10},  -- Beast:	    Humanoid / Mechanical
    [9] = {4, 3},   -- Aquatic:	    Undead / Flying
    [10] = {6, 7},  -- Mechanical:	Magic / Elemental
}

local PET_TYPE_EFFECTIVENESS = {
    [1] = {2, 8},  -- Humanoid:	    Dragonkin / Beast
    [2] = {6, 4},  -- Dragonkin:	Magic / Undead
    [3] = {9, 2},  -- Flying:	    Aquatic / Dragonkin
    [4] = {1, 9},  -- Undead:	    Humanoid / Aquatic
    [5] = {4, 1},  -- Critter:	    Undead / Humanoid
    [6] = {3, 10}, -- Magic:	    Flying / Mechanical
    [7] = {10, 5}, -- Elemental:	Mechanical / Critter
    [8] = {5, 3},  -- Beast:	    Critter / Flying
    [9] = {7, 6},  -- Aquatic:	    Elemental / Magic
    [10] = {8, 7}, -- Mechanical:	Beast / Elemental
}

local function GetStrongWeakPetTypes(petType, petAbilities, strongOrWeak)
	if not petAbilities[petType] then
        return nil, nil
    end
	return petAbilities[petType][1], petAbilities[petType][2]
end

function Tooltip:SetUnit(petID,abilities,teamName)
    local speciesID, customName, level, xp, maxXp, displayID, _,petName, petIcon, petType, creatureID = C_PetJournal.GetPetInfoByPetID(petID)
    local health, maxHealth, attack, speed, rarity = C_PetJournal.GetPetStats(petID)

    if petID == 0 then return false end
    if not rarity then return false end

    local r, g, b,hex = C_Item.GetItemQualityColor(rarity-1)

    local tooltip = self.tooltip
    tooltip.rarityGlow:SetVertexColor(r, g, b)
    tooltip.Icon:SetTexture(petIcon)

    if Tooltip:GetShowBreedInfo() then
        local breedIndex, confidence = libPetBreedInfo:GetBreedByPetID(petID)
        local breedName = libPetBreedInfo:GetBreedName(breedIndex) or ""
        local breedColor = GetColor(confidence)
        tooltip.Name:SetText(string.format(nameBreedFormat,hex,petName,breedColor,breedName ))
    else
        tooltip.Name:SetText(string.format(nameFormat,hex,petName))
    end
    tooltip.Level:SetText(level)
    tooltip.XPBar:SetWidth(max((xp / max(maxXp,1)) * tooltip.xpBarWidth, 1))
    tooltip.Delimiter:SetPoint("TOP", tooltip.XPBG, "BOTTOM", 0, -10)
    tooltip.XPText:SetFormattedText(tooltip.xpTextFormat or PET_BATTLE_CURRENT_XP_FORMAT, xp, maxXp)
    tooltip.teamText:SetText(teamName)
    tooltip.AttackAmount:SetText(attack)
    tooltip.SpeedAmount:SetText(speed)
    tooltip.PetType.Icon:SetTexture(GetPetTypeTexture(petType))
    tooltip.PetType:SetPoint("TOPRIGHT", tooltip, "TOPRIGHT", 5, 5)

    -- Main Pet Type Resistances/Weaknesses
    if (Tooltip:GetShowStrongWeakHints()) then
        local strongTo, weakTo = GetStrongWeakPetTypes(petType, PET_TYPE_RECEIVED_DAMAGES)

        local strongToIcon = tooltip.resistantToTextures[1]
        local strongToText = tooltip.strongToText
        strongToIcon:SetTexture(GetPetTypeTexture(strongTo))
        strongToIcon:ClearAllPoints()
        strongToIcon:SetPoint("TOPLEFT", tooltip.SpeedIcon, "BOTTOMLEFT", 0, -7)
        strongToIcon:SetSize(20, 20)
        strongToIcon:SetVertexColor(COLOR_GREEN[1], COLOR_GREEN[2], COLOR_GREEN[3])
        strongToIcon:Show()
        strongToText:SetText("-33%")
        strongToText:SetTextColor(unpack(COLOR_GREEN))
        strongToText:ClearAllPoints()
        strongToText:SetPoint("TOPRIGHT", strongToIcon, "BOTTOMRIGHT", 0, 5)
        strongToText:Show()

        local weakToIcon = tooltip.weakToTextures[1]
        local weakToText = tooltip.weakToText
        weakToIcon:SetTexture(GetPetTypeTexture(weakTo))
        weakToIcon:ClearAllPoints()
        weakToIcon:SetPoint("TOPLEFT", strongToIcon, "TOPRIGHT", 8, 0)
        weakToIcon:SetSize(20, 20)
        weakToIcon:SetVertexColor(COLOR_RED[1], COLOR_RED[2], COLOR_RED[3])
        weakToIcon:Show()
        weakToText:SetText("+50%")
        weakToText:SetTextColor(unpack(COLOR_RED))
        weakToText:ClearAllPoints()
        weakToText:SetPoint("TOPLEFT", weakToIcon, "BOTTOMLEFT", 0, 5)
        weakToText:Show()

        tooltip.ActualHealthBar:SetWidth(240)
        tooltip:SetWidth(270)
    else
        tooltip.resistantToTextures[1]:Hide()
        tooltip.strongToText:Hide()
        tooltip.weakToTextures[1]:Hide()
        tooltip.weakToText:Hide()
        tooltip:SetWidth(260)
    end

    tooltip.SpeciesName:Hide()
    if customName then
        if ( customName ~= petName ) then
            tooltip.Name:SetText("|c"..hex..customName.."|r")
            tooltip.SpeciesName:SetText("|c"..hex..petName.."|r")
            tooltip.SpeciesName:Show()
        end
    end

    if Tooltip:GetShowHelpText() then
        tooltip:SetHeight(FRAME_HEIGHT_WITH_TT)
        tooltip.Delimiter2:Show()
        tooltip.helpText:SetText(tooltipText())
        tooltip.helpText:Show()
    else
        tooltip.Delimiter2:Hide()
        tooltip.helpText:Hide()
        tooltip:SetHeight(FRAME_HEIGHT_NO_TT)
    end

    if ( tooltip.HealthText ) then
        tooltip.HealthText:SetFormattedText(tooltip.healthTextFormat or PET_BATTLE_CURRENT_HEALTH_FORMAT, health, maxHealth)
    end

    if ( health == 0 ) then
        tooltip.ActualHealthBar:SetWidth(1)
    else
        tooltip.ActualHealthBar:SetWidth((health / max(maxHealth,1)) * tooltip.healthBarWidth)
    end

    for i=1, #abilities do
        local _, name, icon, _, _, _, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfoByID(abilities[i])
        local disabled = level < (i-1)*2

        local abilityIcon = tooltip["AbilityIcon"..i]
        local abilityName = tooltip["AbilityName"..i]

        local nameColor = disabled and COLOR_DISABLED or COLOR_WHITE
        abilityName:SetShown(true)
        abilityName:SetVertexColor(nameColor[1], nameColor[2], nameColor[3])
        abilityIcon:SetShown(true)
        abilityIcon:SetTexture("Interface\\PetBattles\\BattleBar-AbilityBadge-Neutral")
        abilityIcon:SetDesaturated(disabled)
        local iconColor = disabled and COLOR_DISABLED or COLOR_WHITE
        abilityIcon:SetVertexColor(iconColor[1], iconColor[2], iconColor[3])

        if name then
            abilityName:SetText(name)
        end
        if (icon) then
            abilityIcon:SetTexture(icon)
        end

        if (Tooltip:GetShowStrongWeakHints()) then
            local strongType, weakType = GetStrongWeakPetTypes(abilityPetType, PET_TYPE_EFFECTIVENESS)

            local abilityStrongIcon = tooltip.abilityStrongIcons[i]
            local abilityStrongArrow = tooltip.abilityStrongArrows[i]
            if (not noStrongWeakHints) then
                abilityStrongIcon:SetTexture(GetPetTypeTexture(strongType))
                abilityStrongIcon:ClearAllPoints()
                abilityStrongIcon:SetPoint("LEFT", abilityName, "RIGHT", -15, 0)
                abilityStrongIcon:SetDesaturated(disabled)
                abilityStrongIcon:Show()
                abilityStrongArrow:ClearAllPoints()
                abilityStrongArrow:SetPoint("LEFT", abilityStrongIcon, "RIGHT", -8, -5)
                abilityStrongArrow:SetDesaturated(disabled)
                abilityStrongArrow:Show()
            end

            local abilityWeakIcon = tooltip.abilityWeakIcons[i]
            local abilityWeakArrow = tooltip.abilityWeakArrows[i]
            if (not noStrongWeakHints) then
                abilityWeakIcon:SetTexture(GetPetTypeTexture(weakType))
                abilityWeakIcon:ClearAllPoints()
                abilityWeakIcon:SetPoint("LEFT", abilityStrongIcon, "RIGHT", 2, 0)
                abilityWeakIcon:SetDesaturated(disabled)
                abilityWeakIcon:Show()
                abilityWeakArrow:ClearAllPoints()
                abilityWeakArrow:SetPoint("LEFT", abilityWeakIcon, "RIGHT", -8, -5)
                abilityWeakArrow:SetDesaturated(disabled)
                abilityWeakArrow:Show()
            else
                abilityStrongIcon:Hide()
                abilityStrongArrow:Hide()
                abilityWeakIcon:Hide()
                abilityWeakArrow:Hide()
            end
        end
    end

    -- Hide any unused ability elements (fewer abilities, or hide all..)
    for i = (Tooltip:GetShowStrongWeakHints() and #abilities or 0) + 1, PET_ABILITIES do
        if tooltip.abilityStrongIcons[i] then tooltip.abilityStrongIcons[i]:Hide() end
        if tooltip.abilityWeakIcons[i] then tooltip.abilityWeakIcons[i]:Hide() end
        if tooltip.abilityStrongArrows[i] then tooltip.abilityStrongArrows[i]:Hide() end
        if tooltip.abilityWeakArrows[i] then tooltip.abilityWeakArrows[i]:Hide() end
    end

    return true
end
