-- SimpleFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/11/2020, 2:11:55 PM
--
---@type ns
local ns = select(2, ...)
local Frame = ns.UI.Frame

---@class UI.SimpleFrame: UI.Frame
local SimpleFrame = ns.Addon:NewClass('UI.SimpleFrame', Frame)

function SimpleFrame:Constructor()
    ns.UI.OwnerSelector:Bind(self.OwnerSelector, self.meta)
    ns.UI.SearchBox:Bind(self.SearchBox, self.meta)
end

function SimpleFrame:ToggleSearchBoxFocus()
    if self.SearchBox:HasFocus() then
        self.SearchBox:ClearFocus()
    else
        self.SearchBox:Show()
        self.SearchBox:SetFocus()
    end
end
