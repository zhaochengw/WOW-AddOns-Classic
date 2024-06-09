---------------------------------------
-- 顯示職業圖標和天赋
-- @Author: M
-- @DepandsOn: InspectUnit.lua
---------------------------------------
local LibEvent = LibStub:GetLibrary("LibEvent.7000")

local function GetInspectTalentInfo(unit, isInspect, talentGroup)
    if (not GetTalentTabInfo) then
        return
    end

    local _, name, point, bgFile, name1, name2, name3, point1, point2, point3, fileName1, fileName2, fileName3

    -- 返回 名字，素材，总点数，背景图片
    -- 入参 天赋页，是否目标，是否宠物，第几天赋（双天赋）
    name1, _, point1, fileName1 = GetTalentTabInfo(1, isInspect, false, talentGroup)
    name2, _, point2, fileName2 = GetTalentTabInfo(2, isInspect, false, talentGroup)
    name3, _, point3, fileName3 = GetTalentTabInfo(3, isInspect, false, talentGroup)

    -- local id,name,description,iconTexture,pointsSpent,background,previewPointsSpent,isUnlocked=GetTalentTabInfo(1, isInspect,false,talentGroup)

    point = max(point1, point2, point3)

    if point == point1 then
        name = name1
        bgFile = fileName1

    elseif point == point2 then
        name = name2
        bgFile = fileName2

    elseif point == point3 then
        name = name3
        bgFile = fileName3

    end
    return name, point, point1, point2, point3, bgFile
end

hooksecurefunc("ShowInspectItemListFrame", function(unit, parent, itemLevel, maxLevel)
    local frame = parent.inspectFrame
    if (not frame) then
        return
    end
    if (not frame.specicon) then
        frame.specicon = frame:CreateTexture(nil, "BORDER")
        frame.specicon:SetSize(42, 42)
        frame.specicon:SetPoint("TOPRIGHT", -10, -11)
        frame.specicon:SetAlpha(0.5)
        frame.specicon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
        frame.spectext = frame:CreateFontString(nil, "BORDER")
        frame.spectext:SetFont(UNIT_NAME_FONT, 12, "THINOUTLINE")
        frame.spectext:SetPoint("BOTTOM", frame.specicon, "BOTTOM", 0, -4)
        frame.spectext:SetJustifyH("CENTER")
        -- frame.spectext:SetAlpha(0.9)

    end
    local class = select(2, UnitClass(unit))
    local x1, x2, y1, y2 = unpack(CLASS_ICON_TCOORDS[strupper(class)])
    frame.specicon:SetTexCoord(x1, x2, y1, y2)

    -- 目标类型
    local isInspect = (unit ~= "player")
    -- 获取当前 天赋 分组
    local talentGroup = GetActiveTalentGroup(isInspect, false);

    -- 副天赋
    local subTalentGroup

    -- 当前1，则2；当前2，则1
    if talentGroup == 1 then
        subTalentGroup = 2
    elseif talentGroup == 2 then
        subTalentGroup = 1
    end

    -- 当前天赋
    local name, point, point1, point2, point3, bgFile, iconTexture = GetInspectTalentInfo(unit, isInspect, talentGroup)

    -- 副天赋

    local subTalentName = GetInspectTalentInfo(unit, isInspect, subTalentGroup)

    -- 天赋背景图
    local bgFile = string.format("Interface\\TalentFrame\\%s-TopLeft", bgFile)

    if (not name and not point) then
        frame.spectext:SetText("")
    elseif (name and point > 0) then
        frame.spectext:SetText(format("|CFFFFD200%s|r\n%s/%s/%s", name, point1, point2, point3))
    else
        frame.spectext:SetText(format("%s/%s/%s", point1, point2, point3))
    end

    if (subTalentName and  not frame.subspecicon) then
        frame.subspecicon = frame:CreateTexture(nil, "BORDER")
        frame.subspecicon:SetSize(21, 21)
        frame.subspecicon:SetPoint("TOPRIGHT", -72, -21)
        frame.subspecicon:SetAlpha(0.5)
        frame.subspecicon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
        frame.subspectext = frame:CreateFontString(nil, "BORDER")
        frame.subspectext:SetFont(UNIT_NAME_FONT, 9, "THINOUTLINE")
        frame.subspectext:SetPoint("BOTTOM", frame.subspecicon, "BOTTOM", 0, -5)
        frame.subspectext:SetJustifyH("CENTER")
        -- frame.spectext:SetAlpha(0.9)
        frame.subspecicon:SetTexCoord(x1, x2, y1, y2)
    end
    if subTalentName then
        frame.subspectext:SetText(format("|CFF1EFF00次：%s|r", subTalentName))
    end

end)
