-- LibShowUIPanel-1.0.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 6/15/2021, 11:20:01 PM
--
local MAJOR, MINOR = 'LibShowUIPanel-1.0', 1

---@class LibShowUIPanel-1.0
local Lib = LibStub:NewLibrary(MAJOR, MINOR)
if not Lib then
    return
end

if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
    Lib.ShowUIPanel = ShowUIPanel
    Lib.HideUIPanel = HideUIPanel
else
    local Delegate = (function()
        local frame = EnumerateFrames()
        while frame do
            if frame.SetUIPanel and issecurevariable(frame, 'SetUIPanel') then
                return frame
            end
            frame = EnumerateFrames(frame)
        end
    end)()

    function Lib.ShowUIPanel(frame)
        if not frame or frame:IsShown() then
            return
        end

        if not frame:GetAttribute('UIPanelLayout-defined') or not frame:GetAttribute('UIPanelLayout-area') then
            frame:Show()
            return
        end

        Delegate:SetAttribute('panel-force', nil)
        Delegate:SetAttribute('panel-frame', frame)
        Delegate:SetAttribute('panel-show', true)
    end

    function Lib.HideUIPanel(frame)
        if not frame or not frame:IsShown() then
            return
        end

        if not frame:GetAttribute('UIPanelLayout-defined') or not frame:GetAttribute('UIPanelLayout-area') then
            frame:Hide()
            return
        end

        Delegate:SetAttribute('panel-frame', frame)
        Delegate:SetAttribute('panel-skipSetPoint', nil)
        Delegate:SetAttribute('panel-hide', true)
    end
end
