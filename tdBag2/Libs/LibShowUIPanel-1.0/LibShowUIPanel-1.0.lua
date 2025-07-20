-- LibShowUIPanel-1.0.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 6/15/2021, 11:20:01 PM
--
local MAJOR, MINOR = 'LibShowUIPanel-1.0', 7

---@class LibShowUIPanel-1.0
local Lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not Lib then
    return
end

local ShowUIPanel = Lib.orig_ShowUIPanel or _G.ShowUIPanel
local HideUIPanel = Lib.orig_HideUIPanel or _G.HideUIPanel

Lib.orig_ShowUIPanel = ShowUIPanel
Lib.orig_HideUIPanel = HideUIPanel

local InCombatLockdown = InCombatLockdown

Lib.Delegate = Lib.Delegate or (function()
    local frame = EnumerateFrames()
    while frame do
        if frame.SetUIPanel and issecurevariable(frame, 'SetUIPanel') then
            return frame
        end
        frame = EnumerateFrames(frame)
    end
end)()

local Delegate = Lib.Delegate

local function GetUIPanelAttribute(frame, name)
    if not frame:GetAttribute('UIPanelLayout-defined') then
        local info = UIPanelWindows[frame:GetName()]
        if not info then
            return
        end
        frame:SetAttribute('UIPanelLayout-defined', true)
        for k, v in pairs(info) do
            frame:SetAttribute('UIPanelLayout-' .. k, v)
        end
    end
    return frame:GetAttribute('UIPanelLayout-' .. name)
end

local function ShowPanel(frame, force)
    Delegate:SetAttribute('panel-force', force)
    Delegate:SetAttribute('panel-frame', frame)
    Delegate:SetAttribute('panel-show', true)
end

local function HidePanel(frame, skipSetPoint)
    Delegate:SetAttribute('panel-frame', frame)
    Delegate:SetAttribute('panel-skipSetPoint', skipSetPoint)
    Delegate:SetAttribute('panel-hide', true)
end

local function ShowNormal(frame)
    return Lib.NoDelegate:Show(frame)
end

local function HideNormal(frame)
    return Lib.NoDelegate:Hide(frame)
end

if not Delegate then
    local NoDelegate = Lib.NoDelegate or {}
    Lib.NoDelegate = NoDelegate

    local function onCloseCallback(button)
        return HideNormal(button:GetParent())
    end

    function NoDelegate:SetupHider(hider)
        if not hider then
            hider = CreateFrame('Frame')
            hider:Hide()
            self.Hider = hider
        end
        hider:SetScript('OnHide', function(h)
            local frame = h:GetParent()
            if frame ~= self.Frame then
                return
            end

            h:Hide()
            self.Frame.onCloseCallback = nil
            self.Frame:Hide()
            self.Frame = nil
        end)
    end

    if NoDelegate.Hider then
        NoDelegate:SetupHider(NoDelegate.Hider)
    end

    function NoDelegate:Show(frame)
        if not frame then
            return
        end
        self:Hide(self.Frame)

        if not self.Hider then
            self:SetupHider()
        end

        self.Frame = frame
        self.Frame.onCloseCallback = onCloseCallback

        self.Hider:SetParent(frame)
        self.Hider:Show()
        self.Frame:Show()
        self:AdjuestPosition()
    end

    function NoDelegate:AdjuestPosition()
        local frame = self.Frame
        if not frame then
            return
        end

        local right = GetUIPanel('right')
        local center = GetUIPanel('center')
        local left = GetUIPanel('left')

        local topOffset = UIParent:GetAttribute('TOP_OFFSET')
        local xSpacing = UIParent:GetAttribute('PANEl_SPACING_X')
        local xOff = GetUIPanelAttribute(frame, 'xoffset') or 0
        local yOff = GetUIPanelAttribute(frame, 'yoffset') or 0
        local bottomClampOverride = GetUIPanelAttribute(frame, 'bottomClampOverride')
        local minYOffset = GetUIPanelAttribute(frame, 'minYOffset')
        local yPos = ClampUIPanelY(frame, yOff + topOffset, minYOffset, bottomClampOverride)

        local leftOffset
        if right then
            leftOffset = UIParent:GetAttribute('RIGHT_OFFSET') + xOff + xSpacing * 2 + GetUIPanelWidth(frame)
        elseif center then
            leftOffset = UIParent:GetAttribute('RIGHT_OFFSET') + xOff + xSpacing
        elseif left then
            leftOffset = UIParent:GetAttribute('CENTER_OFFSET') + xOff + xSpacing
        else
            leftOffset = UIParent:GetAttribute('LEFT_OFFSET') + xOff
        end

        frame:ClearAllPoints()
        frame:SetPoint('TOPLEFT', 'UIParent', 'TOPLEFT', leftOffset, yPos)
    end

    function NoDelegate:Hide(frame)
        if frame and frame == self.Frame then
            frame:Hide()
        end
    end

    function NoDelegate:Close()
        if self.Frame and self.Frame:IsShown() then
            self.Frame:Hide()
            return true
        end
        return false
    end

    if not Lib.OnUpdateUIPanelPositions then
        hooksecurefunc('UpdateUIPanelPositions', function()
            return C_Timer.After(0, Lib.OnUpdateUIPanelPositions)
        end)
    end

    function Lib.OnUpdateUIPanelPositions()
        return Lib.NoDelegate:AdjuestPosition()
    end

    if not Lib.CloseSpecialWindows then
        local orig_CloseSpecialWindows = CloseSpecialWindows

        _G.CloseSpecialWindows = function()
            local found = orig_CloseSpecialWindows()
            return Lib.CloseSpecialWindows() or found
        end
    end

    function Lib.CloseSpecialWindows()
        return NoDelegate:Close()
    end
end

function Lib.Show(frame, force)
    if not frame or frame:IsShown() then
        return
    end

    if not GetUIPanelAttribute(frame, 'area') then
        frame:Show()
        return
    end

    if not InCombatLockdown() then
        return ShowUIPanel(frame, force)
    elseif Delegate then
        return ShowPanel(frame, force)
    else
        return ShowNormal(frame)
    end
end

function Lib.Hide(frame, skipSetPoint)
    if not frame or not frame:IsShown() then
        return
    end

    if not GetUIPanelAttribute(frame, 'area') then
        frame:Hide()
        return
    end

    if not InCombatLockdown() then
        return HideUIPanel(frame, skipSetPoint)
    elseif Delegate then
        return HidePanel(frame, skipSetPoint)
    else
        return HideNormal(frame)
    end
end

function Lib.Toggle(frame)
    if frame:IsShown() then
        Lib.Hide(frame)
    else
        Lib.Show(frame)
    end
end

if not oldminor or oldminor < 6 then
    -- 可长期持有的API
    function Lib.ShowUIPanel(frame, force)
        return Lib.Show(frame, force)
    end

    function Lib.HideUIPanel(frame, skipSetPoint)
        return Lib.Hide(frame, skipSetPoint)
    end

    function Lib.ToggleFrame(frame)
        return Lib.Toggle(frame)
    end
end

---- hooks

if Delegate then
    if not Lib.OnCallShowUIPanel then
        hooksecurefunc('ShowUIPanel', function(...)
            return Lib.OnCallShowUIPanel(...)
        end)
    end

    if not Lib.OnCallHideUIPanel then
        hooksecurefunc('HideUIPanel', function(...)
            return Lib.OnCallHideUIPanel(...)
        end)
    end

    function Lib.OnCallShowUIPanel(frame, force)
        if not frame or frame:IsShown() or not InCombatLockdown() then
            return
        end
        return Lib.Show(frame, force)
    end

    function Lib.OnCallHideUIPanel(frame, skipSetPoint)
        if not frame or not frame:IsShown() or not InCombatLockdown() then
            return
        end
        return Lib.Hide(frame, skipSetPoint)
    end
else
    local nop = nop or function()
    end

    if Lib.OnCallShowUIPanel then
        Lib.OnCallShowUIPanel = nop
    end
    if Lib.OnCallHideUIPanel then
        Lib.OnCallHideUIPanel = nop
    end
end
