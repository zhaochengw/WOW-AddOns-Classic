local _, ns = ...

-- zhCN localization error
do
    if not InspectTalentFrameSpentPoints then
        InspectTalentFrameSpentPoints = {SetPoint = nop}
    end
end

-- SoD rune frame
do
    local function ReanchorInspect()
        local frame = PaperDollFrame.inspectFrame
        if not frame then return end
        local x = EngravingFrame and EngravingFrame:IsVisible() and -178 or 33
        local offset = MerInspectDB and MerInspectDB.ShowInspectAngularBorder and 2 or 0
        frame:SetPoint("TOPLEFT", PaperDollFrame, "TOPRIGHT", offset - x, -14)
    end

    if ns.IsClassicSoD then
        hooksecurefunc("ToggleEngravingFrame", ReanchorInspect)
    end
end

-- Raise the layering strata of WotLK gear manager dialog
do
    if ns.IsWrath and GearManagerDialog then
        GearManagerDialog:SetFrameLevel(6)
    end
end