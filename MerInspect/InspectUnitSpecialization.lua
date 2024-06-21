
---------------------------------------
-- 顯示職業圖標和天赋
-- @Author: M
-- @DepandsOn: InspectUnit.lua
---------------------------------------

local LibEvent = LibStub:GetLibrary("LibEvent.7000")

local cache = {}

local function GetInspectTalentInfo(unit)
    if (not GetTalentTabInfo) then return end
    local isInspect = (unit ~= "player")
    local talentGroup = GetActiveTalentGroup(isInspect)

    local index
    local higher = 0
    for i = 1, 3 do
        cache[i] = {}

        local name, icon, point = GetTalentTabInfo(i, isInspect, false, talentGroup)
        if point > higher then
            higher = point
            index = i
        end

        cache[i].name = name
        cache[i].icon = icon
        cache[i].point = point
    end

    return index, cache
end

hooksecurefunc("ShowInspectItemListFrame", function(unit, parent, itemLevel, maxLevel)
    local frame = parent.inspectFrame
    if (not frame) then return end
    if (not frame.specicon) then
        frame.specicon = frame:CreateTexture(nil, "BORDER")
        frame.specicon:SetSize(42, 42)
        frame.specicon:SetPoint("TOPRIGHT", -10, -11)
        frame.specicon:SetAlpha(0.5)
        frame.specicon:SetMask("Interface\\Minimap\\UI-Minimap-Background")
        frame.classicon = frame:CreateTexture(nil, "BORDER")
        frame.classicon:SetSize(42, 42)
        frame.classicon:SetPoint("TOPRIGHT", -10, -11)
        frame.classicon:SetAlpha(0.5)
        frame.classicon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
        frame.spectext = frame:CreateFontString(nil, "BORDER")
        frame.spectext:SetFont(SystemFont_Outline_Small:GetFont(), 11, "THINOUTLINE")
        frame.spectext:SetPoint("BOTTOM", frame.specicon, "BOTTOM", 0, -7)
        frame.spectext:SetJustifyH("CENTER")
        --frame.spectext:SetAlpha(0.9)
    end

    local index, talentCache = GetInspectTalentInfo(unit)
    local specIcon = index and talentCache[index].icon
    frame.spectext:SetText(index and format("|CFFFFD200%s|r\n\n%s/%s/%s", talentCache[index].name, talentCache[1].point, talentCache[2].point, talentCache[3].point) or format("%s/%s/%s", 0, 0, 0))
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
