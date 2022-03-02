local CreateClass = LibStub("Poncho-1.0");

TrackerHelperFont = CreateClass("Frame", "TrackerHelperFont", nil, nil, TrackerHelperBaseElement);
local Font = TrackerHelperFont;

function Font:OnAcquire()
    TrackerHelperBaseElement.OnAcquire(self);

    self.type = "font";

    if not self.font then
        self.font = self:CreateFontString(nil, nil, "GameFontNormal");
        self.font:SetParent(self);
        self.font:SetJustifyH("LEFT");
    end

    self.font:ClearAllPoints();
    self.font:SetPoint("TOPLEFT", 0, 0);
    self.font:SetPoint("RIGHT", 0, 0);

    self:SetColor(NORMAL_FONT_COLOR);
    self:SetHoverColor(HIGHLIGHT_FONT_COLOR);
    self:SetHovering(false);

    self:RefreshPosition();
    self:RefreshColor();
    self:Show();
end

function Font:SetLabel(label)
    self.font:SetText(label);

    self:SetHeight(self.font:GetHeight());
end

function Font:SetSize(size)
    if not size then return end

    self.font:SetFont(self.font:GetFont(), size);
    self:SetHeight(self.font:GetHeight());
end

function Font:SetColor(color)
    if not color then return end

    self.color = self:_normalizeColor(color);

    self:RefreshColor();
end

function Font:SetHoverColor(hoverColor)
    if not hoverColor then return end

    self.hoverColor = self:_normalizeColor(hoverColor);

    self:RefreshColor();
end

function Font:SetHovering(hovering)
    self.hovering = hovering;

    self:RefreshColor();
end

function Font:RefreshSize()
    self:SetHeight(self.font:GetHeight());
    self:UpdateParentsHeight(self:GetFullHeight());
end

function Font:RefreshColor()
    local activeColor = self.hovering and self.hoverColor or self.color;

    self.font:SetTextColor(activeColor.r, activeColor.g, activeColor.b);
end
