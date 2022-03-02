local CreateClass = LibStub("Poncho-1.0");

TrackerHelperFrame = CreateClass("Frame", "TrackerHelperFrame", nil, nil, TrackerHelperBase);
local Frame = TrackerHelperFrame;

function Frame:OnCreate()
    TrackerHelperBase.OnCreate(self);

    local setWidth = self.SetWidth;
    function self:SetWidth(width)
        setWidth(self, width);
        self.content:RefreshSize();
        -- Re-anchor the frame to prevent sizing issues
        self:SetPosition(self:GetPosition());
    end

    local setHeight = self.SetHeight;
    function self:SetHeight(height)
        if not self.maxHeight then
            setHeight(self, self.content:GetFullHeight());
        else
            setHeight(self, math.min(self.content:GetFullHeight(), self.maxHeight));
        end

        -- Re-anchor the frame to prevent sizing issues
        self:SetPosition(self:GetPosition());
        self:_clampScroll();
    end

    local stopMovingOrSizing = self.StopMovingOrSizing;
    function self:StopMovingOrSizing()
        stopMovingOrSizing(self);
        self:SetUserPlaced(false);
        -- Re-anchor the frame to prevent sizing issues
        self:SetPosition(self:GetPosition());
    end
end

function Frame:OnAcquire()
    self.locked = false;
    self.background = TrackerHelperBackgroundFrame(self);

    self:SetClipsChildren(true);
    self:SetClampedToScreen(true);
    self:SetFrameStrata("BACKGROUND");
    self:SetSize(1, 1);
    self:EnableMouseWheel(true);
    self:SetMovable(true);
    self:SetBackgroundColor({
        r = 0.0,
        g = 0.0,
        b = 0.0,
        a = 0.5
    });
    self:SetPosition(0, 400);

    self:SetBackgroundVisibility(false);
    self:SetLocked(false);

    self:SetScript("OnMouseWheel", self.OnMouseWheel);

    self:Clear();
    self:SetWidth(200);
    self:SetMaxHeight(500);
end

function Frame:Clear()
    if self.content then
        self.content:Release();
    end

    self.elements = {};
    self.content = TrackerHelperContainer(self);
end

-- Element Creators

function Frame:Container(options)
    options = options or {};

    local container = TrackerHelperContainer(options.container or self.content);

    container:SetMargin(options.margin);
    container:SetBackgroundColor(options.backgroundColor);

    if options.events then
        for event, listener in pairs(options.events) do
            container:AddListener(event, listener);
        end
    end

    container:UpdateParentsHeight(container:GetFullHeight());
    container:SetHidden(options.hidden);
    container:SetMetadata(options.metadata);

    return container;
end

function Frame:Font(options)
    options = options or {};

    local font = TrackerHelperFont(options.container or self.content);
    font:SetMargin(options.margin);
    font:SetColor(options.color);
    font:SetHoverColor(options.hoverColor);
    font:SetLabel(options.label);
    font:SetSize(options.size or 12);

    font:UpdateParentsHeight(font:GetFullHeight());

    return font;
end

-- Getters & Setters

function Frame:UpdateSettings(settings)
    if settings.maxHeight ~= nil then
        self:SetMaxHeight(settings.maxHeight);
    end

    if settings.width ~= nil then
        self:SetWidth(settings.width);
    end

    if settings.backgroundColor ~= nil then
        self:SetBackgroundColor(settings.backgroundColor);
    end

    if settings.position ~= nil then
        self:SetPosition(settings.position.x, settings.position.y);
    end

    if settings.backgroundVisible ~= nil then
        self:SetBackgroundVisibility(settings.backgroundVisible);
    end

    if settings.locked ~= nil then
        self:SetLocked(settings.locked);
    end
end

function Frame:SetBackgroundVisibility(visible)
    self.background:SetBackgroundVisibility(visible);
end

function Frame:SetBackgroundColor(backgroundColor)
    self.background:SetBackgroundColor(backgroundColor);
end

function Frame:GetPosition()
    local x = self:GetRight();
    local y = self:GetTop();

    local inversedX = x - GetScreenWidth();
    local inversedY = y - GetScreenHeight();

    return inversedX, inversedY;
end

function Frame:SetPosition(x, y)
    if x == nil then
        x = self.position.x;
    end

    if y == nil then
        y = self.position.y;
    end

    self:ClearAllPoints();
    self:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", x, y);

    self.position = { x = x, y = y };
end

function Frame:SetMaxHeight(maxHeight)
    self.maxHeight = maxHeight;

    self:SetHeight(self:GetHeight());
end

function Frame:SetLocked(locked)
    self.locked = locked;

    if self.content then
        self.content:SetLocked(locked);
    end
end

-- Events

function Frame:OnMouseWheel(value)
    local _, _, _, _, y = self.content:GetPoint("TOP");

    self.content:SetPoint("TOP", self, 0, y + 10 * -value);

    self:_clampScroll(self.content);
end

-- Helpers

function Frame:_clampScroll()
    local parent = self.content:GetParent();

    local top = self.content:GetTop();
    local ptop = parent:GetTop();
    local bot = self.content:GetBottom();
    local pbot = parent:GetBottom();
    if top and ptop and top < ptop then
        self.content:SetPoint("TOP", parent, 0, 0);
    elseif bot and pbot and bot > pbot then
        self.content:SetPoint("TOP", parent, 0, self.content:GetHeight() - parent:GetHeight());
    end
end
