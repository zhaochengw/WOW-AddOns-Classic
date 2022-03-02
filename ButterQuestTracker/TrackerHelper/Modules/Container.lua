local CreateClass = LibStub("Poncho-1.0");

TrackerHelperContainer = CreateClass("Frame", "TrackerHelperContainer", nil, nil, TrackerHelperBaseElement);
local Container = TrackerHelperContainer;

function Container:OnAcquire()
    TrackerHelperBaseElement.OnAcquire(self);

    self.type = "container";
    self.elements = {};
    self.listeners = {};

    self:EnableMouse(false);

    self:SetScript('OnEnter', self.OnEnter);
    self:SetScript('OnLeave', self.OnLeave);
    self:SetScript('OnMouseUp', self.OnMouseUp);
    self:SetScript('OnMouseDown', self.OnMouseDown);

    self:SetHeight(0);
    self:SetHidden(false);
end

function Container:OnRelease()
    TrackerHelperBaseElement.OnRelease(self);

    self:EnableMouse(false);
    self:ClearAllPoints();
    self:SetHeight(0);
    self:SetBackgroundColor(nil);
    self:SetMetadata(nil);

    self:SetScript('OnEnter', nil);
    self:SetScript('OnLeave', nil);
    self:SetScript('OnMouseUp', nil);
    self:SetScript('OnMouseDown', nil);

    for _, child in pairs(self.elements) do
        child:Release();
    end

    self.elements = {};
end

function Container:ToggleHidden()
    local hidden = not self.hidden;

    self:SetHidden(hidden);

    return hidden;
end

function Container:RefreshSize()
    if self.hidden then
        local original = self:GetFullHeight();

        self:SetHeight(0);

        self:UpdateParentsHeight(self:GetFullHeight() - original);
    else
        self:SetHeight(0);

        self:UpdateParentsHeight(self:GetFullHeight());

        for _, child in pairs(self.elements) do
            child:RefreshSize();
        end
    end
end

function Container:Order()
    table.sort(self.elements, function(element, otherElement)
        if element.order == otherElement.order then
            return false;
        end

        if element.order == nil and otherElement.order ~= nil then
            return true;
        end

        if element.order ~= nil and otherElement.order == nil then
            return false;
        end

        return element.order < otherElement.order;
    end);

    local previousElement;
    for _, element in pairs(self.elements) do
        element:SetPreviousElement(previousElement);
        previousElement = element;
    end
end

-- Getters & Setters

function Container:GetMetadata(metadata)
    return self.metadata;
end

function Container:SetMetadata(metadata)
    self.metadata = metadata;
end


function Container:AddElement(element)
    if type(element.SetLocked) == "function" then
        element:SetLocked(self.locked);
    end

    tinsert(self.elements, element);
end

function Container:SetHidden(hidden)
    local previouslyHidden = self.hidden;
    self.hidden = hidden;

    if hidden then -- If we're hiding this element and it's not already hidden
        if not previouslyHidden then
            self:RefreshSize();
        end

        self:Hide();
    elseif not hidden then -- If we're showing this element and it's not already shown
        self:Show();

        if previouslyHidden then
            self:RefreshSize();
        end
    end
end

function Container:SetBackgroundColor(backgroundColor)
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

function Container:SetLocked(locked)
    self.locked = locked;

    if not self.elements then return end

    for _, child in pairs(self.elements) do
        if child.type == "container" then
            child:SetLocked(locked);
        end
    end
end

-- Events & Listeners

function Container:AddListener(event, listener)
    if not listener then return end

    self.listeners[event] = self.listeners[event] or {};

    tinsert(self.listeners[event], listener);
    self:EnableMouse(true);
end

function Container:OnEnter(...)
    if not self:_hasAnyMouseListeners() then return end

    -- Take a snapshot of the listeners just encase...
    local listeners = self.listeners;

    self:_updateFontElementsRecursively(self, function(font)
        font:SetHovering(true);
    end);

    self:_invoke(listeners.OnEnter, ...);
end

function Container:OnLeave(...)
    if not self:_hasAnyMouseListeners() then return end

    -- Take a snapshot of the listeners just encase...
    local listeners = self.listeners;

    self:_updateFontElementsRecursively(self, function(font)
        font:SetHovering(false);
    end);

    self:_invoke(listeners.OnLeave, ...);
end

function Container:OnMouseDown(...)
    if not self:_hasAnyMouseListeners() then return end

    -- Take a snapshot of the listeners just encase...
    local listeners = self.listeners;

    local previousCursorX, previousCursorY = GetCursorPosition();
    self.dragged = false;

    if self:_count(self.elements) > 0 then
        self.elements[1]:AdjustPosition(2, -2);
    end

    local button = ...;
    if button == "LeftButton" and not self.locked then
        self.dragTimer = C_Timer.NewTicker(0.1, function()
            local cursorX, cursorY = GetCursorPosition();
            local distance = self:_distance(previousCursorX, previousCursorY, cursorX, cursorY);

            if distance ~= 0 then
                self.dragged = true;
                self.dragTimer:Cancel();
                self:_invoke(listeners.OnButterDragStart);
            end
        end);
    end

    self:_invoke(listeners.OnMouseDown, ...);
end

function Container:OnMouseUp(...)
    if not self:_hasAnyMouseListeners() then return end

    -- Take a snapshot of the listeners, to prevent them getting blown away...
    local listeners = self.listeners;

    if self.dragTimer then
        self.dragTimer:Cancel();
    end

    if self:_count(self.elements) > 0 then
        self.elements[1]:RefreshPosition();
    end

    if self.dragged then
        self:_invoke(listeners.OnButterDragStop);
    else
        self:_invoke(listeners.OnButterMouseUp, ...);
    end

    self:_invoke(listeners.OnMouseUp, ...);
end

-- Helpers

function Container:_updateFontElementsRecursively(element, func)
    for _, child in pairs(element.elements) do
        if child.type == "container" then
            self:_updateFontElementsRecursively(child, func);
        elseif child.type == "font" then
            func(child);
        end
    end
end

function Container:_hasAnyMouseListeners()
    return self.listeners.OnMouseUp or self.listeners.OnButterMouseUp or
        self.listeners.OnMouseDown or
        self.listeners.OnEnter or
        self.listeners.OnLeave or
        self.listeners.OnButterDragStart or
        self.listeners.OnButterDragEnd;
end

function Container:_invoke(listeners, ...)
    if not listeners then return end

    for _, listener in pairs(listeners) do
        listener(..., self);
    end
end
