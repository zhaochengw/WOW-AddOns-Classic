--变量
local deg = math.deg;
local atan2 = math.atan2;
local GetCursorPosition = GetCursorPosition;

--地图按钮，参考了Xinhuan的BankItems
local MinimapButton = CreateFrame("Button", "UFP_MinimapButton", Minimap);
MinimapButton:EnableMouse(true);
MinimapButton:SetMovable(false);
MinimapButton:SetFrameStrata("MEDIUM");
MinimapButton:SetWidth(33);
MinimapButton:SetHeight(33);
MinimapButton:ClearAllPoints();
MinimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");

MinimapButton.Icon = MinimapButton:CreateTexture("UFP_MinimapButtonIcon", "BORDER");
MinimapButton.Icon:SetWidth(20);
MinimapButton.Icon:SetHeight(20);
MinimapButton.Icon:ClearAllPoints();
MinimapButton.Icon:SetPoint("CENTER", -2, 1);
MinimapButton.Icon:SetTexture("Interface\\AddOns\\UnitFramesPlus\\MinimapButton");

MinimapButton.Border = MinimapButton:CreateTexture("UFP_MinimapButtonBorder", "OVERLAY");
MinimapButton.Border:SetWidth(52);
MinimapButton.Border:SetHeight(52);
MinimapButton.Border:ClearAllPoints();
MinimapButton.Border:SetPoint("TOPLEFT");
MinimapButton.Border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder");

local function UnitFramesPlus_MinimapButton_UpdatePosition()
    MinimapButton:ClearAllPoints();
    MinimapButton:SetPoint(
        "TOPLEFT",
        Minimap,
        "TOPLEFT",
        53.5 - (UnitFramesPlusDB["minimap"]["radius"] * cos(UnitFramesPlusDB["minimap"]["position"])),
        (UnitFramesPlusDB["minimap"]["radius"] * sin(UnitFramesPlusDB["minimap"]["position"])) - 55.5
    );
end

local function UnitFramesPlus_MinimapButton_BeingDragged()
    local xpos, ypos = GetCursorPosition();
    local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom();

    xpos = xmin-xpos/UIParent:GetScale()+70;
    ypos = ypos/UIParent:GetScale()-ymin-70;

    local v = deg(atan2(ypos, xpos));
    if v < 0 then
        v = v + 360;
    end
    UnitFramesPlusDB["minimap"]["position"] = v;
    UnitFramesPlus_MinimapButton_UpdatePosition();
end

function UnitFramesPlus_MinimapButton()
    if UnitFramesPlusDB["minimap"]["button"]==1 then
        MinimapButton:RegisterForDrag("RightButton");
        MinimapButton:SetScript("OnDragStart", function(self)
            self:SetScript("OnUpdate", UnitFramesPlus_MinimapButton_BeingDragged);
        end)
        MinimapButton:SetScript("OnDragStop", function(self)
            self:SetScript("OnUpdate", nil);
        end)
        MinimapButton:SetScript("OnClick", function(self)
            UnitFramesPlus_SlashHandler();
        end)
        MinimapButton:EnableMouse(true);
        MinimapButton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:SetText("UnitFramesPlus v"..GetAddOnMetadata("UnitFramesPlus", "Version"));
            GameTooltip:AddLine(UFPLocal_LeftOpen);
            GameTooltip:AddLine(UFPLocal_RightMove);
            GameTooltip:Show();
        end)
        MinimapButton:SetScript("OnLeave", function(self)
            GameTooltip:Hide();
        end)
        MinimapButton:Show();
    else
        MinimapButton:RegisterForDrag(nil);
        MinimapButton:SetScript("OnDragStart", nil);
        MinimapButton:SetScript("OnDragStop", nil);
        MinimapButton:SetScript("OnClick", nil);
        MinimapButton:SetScript("OnEnter", nil);
        MinimapButton:SetScript("OnLeave", nil);
        MinimapButton:Hide();
    end
end

function UnitFramesPlus_MinimapButtonInit()
    UnitFramesPlus_MinimapButton();
end

function UnitFramesPlus_MinimapButtonLayout()
    UnitFramesPlus_MinimapButton_UpdatePosition();
end