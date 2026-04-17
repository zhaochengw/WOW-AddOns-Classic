-- =====================================================
-- File: Modules/InspectUnitExtras.lua
-- Author: Domekologe
-- Description: Adds Glyphs and Talent info for Mists of Pandaria Classic (API 11.20)
-- =====================================================

local locale = GetLocale()
if not (locale == "koKR" or locale == "enUS" or locale == "zhCN" or locale == "zhTW" or locale == "deDE") then
    return
end

------------------------------------------------------------
-- Helpers
------------------------------------------------------------
local function CreateLine(frame, anchor, text, r, g, b)
    local line = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    line:SetText(text or "")
    line:SetTextColor(r or 1, g or 1, b or 1)
    line:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -2)
    return line
end

------------------------------------------------------------
-- Build Glyph Info
------------------------------------------------------------
local function BuildGlyphInfo(unit)
    local major, minor = 0, 0
    local MAJOR_MAX, MINOR_MAX = 3, 3

    if not GetNumGlyphSockets or not GetGlyphSocketInfo then
        return "Glyphs: N/A", ""
    end

    for i = 1, GetNumGlyphSockets() do
        local enabled, _, _, glyphType = GetGlyphSocketInfo(i, unit)
        if enabled then
            if glyphType == 1 then
                major = major + 1
            elseif glyphType == 2 then
                minor = minor + 1
            end
        end
    end

    return string.format("Major Glyphs: %d/%d", major, MAJOR_MAX),
           string.format("Minor Glyphs: %d/%d", minor, MINOR_MAX)
end

------------------------------------------------------------
-- Build Talent Info
------------------------------------------------------------
local function BuildTalentInfo(unit)
    local isInspect = (unit and unit ~= "player")
    local specIndex

    if isInspect and GetInspectSpecialization then
        specIndex = GetInspectSpecialization(unit)
    elseif GetSpecialization then
        specIndex = GetSpecialization()
    end

    if not specIndex or specIndex == 0 then
        return "Specialization: Unknown", "Talents: None"
    end

    local id, name, description, icon, role = GetSpecializationInfo(specIndex)
    if not id then
        return "Specialization: Unknown", "Talents: None"
    end

    local talentsChosen = {}
    for tier = 1, 6 do
        local chosen = false
        for column = 1, 3 do
            local talentID, talentName, iconTexture, selected = GetTalentInfo(tier, column, isInspect, unit)
            if selected then
                table.insert(talentsChosen, tostring(tier * 15)) -- Level 15/30/45/60/75/90
                chosen = true
            end
        end
        if not chosen then
            table.insert(talentsChosen, "–")
        end
    end

    local spentStr = table.concat(talentsChosen, "/")
    return string.format("Spec: %s (%s)", name or "Unknown", role or "Role?"),
           string.format("Talents: %s", spentStr)
end

------------------------------------------------------------
-- Inspect Display Hook + Event Handling
------------------------------------------------------------
local pendingInspectUnit
local InspectFrameRef

local function UpdateInspectDisplay(unit)
    if not InspectFrameRef or not UnitExists(unit) then return end

    local g1, g2 = BuildGlyphInfo(unit)
    local t1, t2 = BuildTalentInfo(unit)

    local anchor = InspectFrameRef["item17"] or InspectFrameRef["item16"] or InspectFrameRef.closeButton

    if InspectFrameRef.glyphText1 then
        InspectFrameRef.glyphText1:SetText(g1)
        InspectFrameRef.glyphText2:SetText(g2)
        InspectFrameRef.talentText1:SetText(t1)
        InspectFrameRef.talentText2:SetText(t2)
        return
    end

    InspectFrameRef.glyphText1 = CreateLine(InspectFrameRef, anchor, g1, 0.6, 0.8, 1.0)
    InspectFrameRef.glyphText2 = CreateLine(InspectFrameRef, InspectFrameRef.glyphText1, g2, 0.6, 0.8, 1.0)
    InspectFrameRef.talentText1 = CreateLine(InspectFrameRef, InspectFrameRef.glyphText2, t1, 1.0, 0.9, 0.3)
    InspectFrameRef.talentText2 = CreateLine(InspectFrameRef, InspectFrameRef.talentText1, t2, 1.0, 0.9, 0.3)
end

-- Frame for event handling
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("INSPECT_READY")

eventFrame:SetScript("OnEvent", function(self, event, guid)
    if event == "INSPECT_READY" and pendingInspectUnit and UnitGUID(pendingInspectUnit) == guid then
        UpdateInspectDisplay(pendingInspectUnit)
        pendingInspectUnit = nil
    end
end)

-- Hook for when inspect UI opens
hooksecurefunc("ShowInspectItemListFrame", function(unit, parent, itemLevel, maxLevel)
    if InCombatLockdown() then return end
    if not parent or not parent.inspectFrame then return end
    if not TinyInspectClassicDB or not TinyInspectClassicDB.ShowInspectItemSheet then return end

    InspectFrameRef = parent.inspectFrame
    pendingInspectUnit = unit

    -- Request inspect data
    if CanInspect(unit) then
        NotifyInspect(unit)
    end
end)
