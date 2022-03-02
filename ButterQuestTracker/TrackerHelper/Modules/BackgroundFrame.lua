local CreateClass = LibStub("Poncho-1.0");

TrackerHelperBackgroundFrame = CreateClass("Frame", "TrackerHelperBackgroundFrame", nil, nil, TrackerHelperBase);
local Frame = TrackerHelperBackgroundFrame;

function Frame:OnAcquire()
    self:SetAllPoints();

    self:SetBackgroundColor({
        r = 0.0,
        g = 0.0,
        b = 0.0,
        a = 0.5
    });

    self:SetBackgroundVisibility(false);
end

function Frame:SetBackgroundVisibility(visible)
    self.initial = self.initial == nil or self.initial;
    local from = visible and 0 or 1;
    local to = visible and 1 or 0;

    if self.initial then
        self:SetAlpha(to);
        self.initial = false;
    elseif self:GetAlpha() ~= to then
        if not self.group then
            self.group = self:CreateAnimationGroup();
            self.group.fade = self.group:CreateAnimation("Alpha");
            self.group.fade:SetDuration(0.125);
        end

        local group = self.group;
        local fade = group.fade;

        fade:SetFromAlpha(from);
        fade:SetToAlpha(to);
        fade:SetSmoothing("OUT")
        fade:SetScript("OnFinished", function()
            group:Stop();
            self:SetAlpha(to);
        end);

        group:Play();
    end
end

function Frame:SetBackgroundColor(backgroundColor)
    backgroundColor = self:_normalizeColor(backgroundColor);

    if backgroundColor then
        if not self.texture then
            self.texture = self:CreateTexture(nil, "BACKGROUND");
            self.texture:SetAllPoints();
        end

        self.texture:Show();
        self.texture:SetColorTexture(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a);
    elseif self.texture then
        self.texture:Hide();
    end
end
