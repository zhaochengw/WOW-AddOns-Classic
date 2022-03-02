local CreateClass = LibStub("Poncho-1.0");

TrackerHelperBaseElement = CreateClass("Frame", "TrackerHelperBaseElement", nil, nil, TrackerHelperBase);
local BaseElement = TrackerHelperBaseElement;

function BaseElement:OnAcquire()
    local parent = self:GetParent();

    self:SetMargin({
        top = 0,
        left = 0,
        right = 0,
        bottom = 0
    });

    local numberOfSiblings = self:_count(parent.elements);
    if numberOfSiblings > 0 then
        self:SetPreviousElement(parent.elements[numberOfSiblings]);
    else
        self:SetPreviousElement(nil);
    end

    if parent.type == "container" then
        parent:AddElement(self);
    end
end

function BaseElement:OnRelease()
    TrackerHelperBase.OnRelease(self);
    self.previousElement = nil;
    self:Hide();
end

function BaseElement:SetMargin(margin)
    self.margin = margin or {};
    self.margin.top = self.margin.top or self.margin.y or 0;
    self.margin.bottom = self.margin.bottom or self.margin.y or 0;
    self.margin.left = self.margin.left or self.margin.x or 0;
    self.margin.right = self.margin.right or self.margin.x or 0;

    self:RefreshPosition();
end

function BaseElement:SetOrder(order, notify)
    self.order = order;

    if notify == nil or notify then
        local parent = self:GetParent();

        if parent.type == "container" then
            parent:Order();
        end
    end
end

function BaseElement:SetPreviousElement(element)
    self.previousElement = element;

    self:RefreshPosition();
end

function BaseElement:RefreshPosition()
    self:AdjustPosition(0, 0);
end

function BaseElement:AdjustPosition(x, y)
    local top = -self.margin.top + y;
    local left = self.margin.left + x;
    local right = -self.margin.right + x;

    local parent = self:GetParent();
    if self.previousElement then
        left = left + parent:GetLeft() - self.previousElement:GetLeft();
    end

    self:ClearAllPoints();
    if self.previousElement then
        self:SetPoint("TOP", self.previousElement, "BOTTOM", 0, top - self.previousElement.margin.bottom);
        self:SetPoint("LEFT", self.previousElement, left, 0);
        self:SetPoint("RIGHT", self.previousElement, right, 0);
    else
        self:SetPoint("TOP", parent, 0, top);
        self:SetPoint("LEFT", parent, left, 0);
        self:SetPoint("RIGHT", parent, right, 0);
    end
end

function BaseElement:UpdateParentsHeight(delta)
    local parent = self:GetParent();
    while parent ~= UIParent and not parent.hidden do
        parent:SetHeight(parent:GetRealHeight() + delta);
        parent = parent:GetParent();
    end
end

function BaseElement:GetVerticalMargin()
    return self.margin.top + self.margin.bottom;
end

function BaseElement:GetHorizontalMargin()
    return self.margin.left + self.margin.right;
end

-- Height + Vertical Margin
function BaseElement:GetFullHeight()
    return self:GetRealHeight() + self:GetVerticalMargin();
end

-- Width + Horizontal Margin
function BaseElement:GetFullWidth()
    return self:GetWidth() + self:GetHorizontalMargin();
end
