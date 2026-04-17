
local _TI_GetInspectSpec = _G.TI_GetInspectSpec
local _GetSpecialization = _G.GetSpecialization
local _GetSpecializationInfo = _G.GetSpecializationInfo
local _TI_GetSpecInfoByID = _G.TI_GetSpecInfoByID

local function TI_GetInspectSpec(unit)
    if _TI_GetInspectSpec then
        return _TI_GetInspectSpec(unit)
    end
    return nil
end
local function TI_GetPlayerSpec()
    if _GetSpecialization then
        return _GetSpecialization()
    end
    return nil
end
local function TI_GetSpecInfoByID(id)
    if _TI_GetSpecInfoByID then
        return _TI_GetSpecInfoByID(id)
    end
    return nil, nil, nil, nil
end
local function TI_GetSpecInfo(idx)
    if _GetSpecializationInfo then
        return _GetSpecializationInfo(idx)
    end
    return nil, nil, nil, nil
end

hooksecurefunc("ShowInspectItemListFrame", function(unit, parent, itemLevel, maxLevel)
    local frame = parent.inspectFrame
    if (not frame) then return end
    if (not frame.specicon) then
        frame.specicon = frame:CreateTexture(nil, "BORDER")
        frame.specicon:SetSize(42, 42)
        frame.specicon:SetPoint("TOPRIGHT", -6, -6)
        frame.specicon:SetAlpha(0.4)
        frame.specicon:SetMask("Interface\\Minimap\\UI-Minimap-Background")
        frame.spectext = frame:CreateFontString(nil, "BORDER")
        frame.spectext:SetFont(SystemFont_Outline_Small:GetFont(), 10, "THINOUTLINE")
        frame.spectext:SetPoint("BOTTOM", frame.specicon, "BOTTOM")
        frame.spectext:SetJustifyH("CENTER")
        frame.spectext:SetAlpha(0.5)
    end
    local _, specID, specName, specIcon
    if (unit == "player") then
        specID = TI_GetPlayerSpec()
        _, specName, _, specIcon = TI_GetSpecInfo(specID)
    else
        specID = TI_GetInspectSpec(unit)
        _, specName, _, specIcon = TI_GetSpecInfoByID(specID)
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
