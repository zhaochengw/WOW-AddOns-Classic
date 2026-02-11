------------------------------------------------------------
-- HunterTrapsBar V2 - Core/Frame.lua
-- Main bar creation, drag, layout, BAR border visibility, sizing
------------------------------------------------------------

local HTB = HunterTrapsBar
if not HTB then return end

HTB.DEFAULT_POINT = { "CENTER", "UIParent", "CENTER", 0, -220 }

local function EnsureDefaults()
    if not HTB.DB then HTB.DB = {} end

    if HTB.DB.locked == nil then
        HTB.DB.locked = true
    end

    -- Default: BAR border always shown (locked or unlocked)
    if HTB.DB.hideBorderWhenLocked == nil then
        HTB.DB.hideBorderWhenLocked = false
    end

    if HTB.DB.scale == nil then
        HTB.DB.scale = 1
    end
end

local function ResolveFrame(name)
    if type(name) == "string" and _G[name] then
        return _G[name]
    end
    return UIParent
end

local function SavePosition(bar)
    if not bar or not bar.GetPoint then return end
    local point, relativeTo, relativePoint, xOfs, yOfs = bar:GetPoint(1)
    local relName = (relativeTo and relativeTo.GetName and relativeTo:GetName()) or "UIParent"
    HTB.DB.point = { point or "CENTER", relName, relativePoint or "CENTER", xOfs or 0, yOfs or 0 }
end

local function ApplySavedPosition(bar)
    if not bar then return end

    if HTB.DB.point and #HTB.DB.point == 5 then
        local p, relName, rp, x, y = unpack(HTB.DB.point)
        local rel = ResolveFrame(relName)
        bar:ClearAllPoints()
        bar:SetPoint(p, rel, rp, x, y)
    else
        -- Default position (safe fallback)
        bar:ClearAllPoints()
        bar:SetPoint(unpack(HTB.DEFAULT_POINT))
    end
end

------------------------------------------------------------
-- BAR border visibility logic
------------------------------------------------------------

function HTB:UpdateBarBorderVisibility()
    if not self.Bar then return end

    local hide = (HTB.DB.hideBorderWhenLocked == true) and (HTB.DB.locked == true)

    if hide then
        -- Hide BOTH border and background
        self.Bar:SetBackdropBorderColor(0, 0, 0, 0)
        self.Bar:SetBackdropColor(0, 0, 0, 0)
    else
        -- Restore background (green @ 80%)
        self.Bar:SetBackdropColor(0, 0.8, 0, 0.8)

        -- Restore border color based on lock state
        if HTB.DB.locked then
            self.Bar:SetBackdropBorderColor(0, 1, 0, 1)      -- green locked
        else
            self.Bar:SetBackdropBorderColor(1, 0.82, 0, 1)   -- gold unlocked
        end
    end
end

------------------------------------------------------------
-- Resize bar to fit buttons
------------------------------------------------------------

function HTB:ResizeBarForButtons(count)
    if not self.Bar or not count or count <= 0 then return end

    local buttonSize = 36
    local padding = 3
    local leftRightInset = 12 -- matches first button x=6 and right inset=6

    local width = leftRightInset + (count * buttonSize) + ((count - 1) * padding)
    self.Bar:SetWidth(width)
end

------------------------------------------------------------
-- Apply layout (lock state + mouse + color)
------------------------------------------------------------

function HTB:ApplyLayout()
    EnsureDefaults()
    if not self.Bar then return end

    self.Bar:SetScale(HTB.DB.scale or 1)

    if HTB.DB.locked then
        self.Bar:EnableMouse(false)
        self.Bar:SetBackdropBorderColor(0, 1, 0, 1)
    else
        self.Bar:EnableMouse(true)
        self.Bar:SetBackdropBorderColor(1, 0.82, 0, 1)
    end

    self:UpdateBarBorderVisibility()
end

------------------------------------------------------------
-- Create bar frame
------------------------------------------------------------

function HTB:CreateBar()
    EnsureDefaults()
    if self.Bar then return end

    local bar = CreateFrame("Frame", "HunterTrapsBarFrame", UIParent, "BackdropTemplate")
    bar:SetSize(200, 48)
    bar:SetMovable(true)
    bar:EnableMouse(true)
    bar:RegisterForDrag("LeftButton")

    bar:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    bar:SetBackdropColor(0, 0.8, 0, 0.8)

    bar:SetScript("OnDragStart", function(selfFrame)
        if not HTB.DB.locked then
            selfFrame:StartMoving()
        end
    end)

    bar:SetScript("OnDragStop", function(selfFrame)
        selfFrame:StopMovingOrSizing()
        SavePosition(selfFrame)
    end)

    self.Bar = bar

    ApplySavedPosition(bar)
    self:ApplyLayout()
end
