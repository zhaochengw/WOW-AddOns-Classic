
---------------------------------------
-- 顯示職業圖標和天赋
-- @Author: M
-- @DepandsOn: InspectUnit.lua
---------------------------------------
local addon, ns = ...

local GetSpecialization = C_SpecializationInfo and C_SpecializationInfo.GetSpecialization or GetSpecialization
local GetSpecializationInfo = C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo or GetSpecializationInfo


local function GetInspectTalentInfo(isInspect, talentGroup)
    local maxPoint = 0
    local specName
    local specIcon
    local counts = {}
    for i = 1, GetNumTalentTabs() do
        local _, name, _, icon, point = GetTalentTabInfo(i, isInspect, false, talentGroup)
        if point > maxPoint then
            maxPoint = point
            specName = name
            specIcon = icon
        end

        tinsert(counts, point)
    end
    return specName, specIcon, table.concat(counts, '/')
end

if ns.GameVersion < 50000 then
    hooksecurefunc("ShowInspectItemListFrame", function(unit, parent)
        local frame = parent.inspectFrame
        if (not frame) then return end
        if (not frame.specicon) then
            frame.specicon = frame:CreateTexture(nil, "BORDER")
            frame.specicon:SetSize(42, 42)
            frame.specicon:SetPoint("TOPRIGHT", -10, -11)
            frame.specicon:SetAlpha(0.6)
            frame.specicon:SetMask("Interface\\Masks\\CircleMaskScalable")
            frame.classicon = frame:CreateTexture(nil, "BORDER")
            frame.classicon:SetSize(42, 42)
            frame.classicon:SetPoint("TOPRIGHT", -10, -11)
            frame.classicon:SetAlpha(0.6)
            frame.classicon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
            frame.spectext = frame:CreateFontString(nil, "BORDER")
            frame.spectext:SetFont(STANDARD_TEXT_FONT, 11, "THINOUTLINE")
            frame.spectext:SetTextColor(1, .82, 0)
            frame.spectext:SetPoint("CENTER", frame.specicon, "CENTER")
            frame.spectext:SetJustifyH("CENTER")
            frame.points = frame:CreateFontString(nil, "BORDER")
            frame.points:SetFont(STANDARD_TEXT_FONT, 11, "THINOUTLINE")
            frame.points:SetPoint("BOTTOM", frame.specicon, "BOTTOM", 0, -4)
            frame.points:SetJustifyH("CENTER")
        end

        local isInspect = unit ~= "player"
        local activeGroup = GetActiveTalentGroup(isInspect)
        local specName, specIcon, points = GetInspectTalentInfo(isInspect, activeGroup)

        frame.spectext:SetText(specName)
        frame.points:SetText(points)
        frame.specicon:SetShown(not not specIcon)
        frame.classicon:SetShown(not specIcon)

        if specIcon then
            frame.specicon:SetTexture(specIcon)
        else
            local class = select(2, UnitClass(unit))
            local x1, x2, y1, y2 = unpack(CLASS_ICON_TCOORDS[strupper(class)])
            frame.classicon:SetTexCoord(x1, x2, y1, y2)
        end
    end)
else
    hooksecurefunc("ShowInspectItemListFrame", function(unit, parent)
        local frame = parent.inspectFrame
        if (not frame) then return end
        if (not frame.specicon) then
            frame.specicon = frame:CreateTexture(nil, "BORDER")
            frame.specicon:SetSize(42, 42)
            frame.specicon:SetPoint("TOPRIGHT", -10, -11)
            frame.specicon:SetMask("Interface\\Masks\\CircleMaskScalable")
            frame.spectext = frame:CreateFontString(nil, "BORDER")
            frame.spectext:SetFont(SystemFont_Outline_Small:GetFont(), 10, "THINOUTLINE")
            frame.spectext:SetPoint("BOTTOM", frame.specicon, "BOTTOM")
            frame.spectext:SetJustifyH("CENTER")
        end
        local _, specID, specName, specIcon
        if (unit == "player") then
            specID = GetSpecialization()
            _, specName, _, specIcon = GetSpecializationInfo(specID)
        else
            specID = GetInspectSpecialization(unit)
            _, specName, _, specIcon = GetSpecializationInfoByID(specID)
        end
        if (specIcon) then
            frame.spectext:SetText(specName)
            frame.specicon:SetTexture(specIcon)
            frame.specicon:Show()
        else
            frame.spectext:SetText("")
            frame.specicon:Hide()
        end
    end)
end
