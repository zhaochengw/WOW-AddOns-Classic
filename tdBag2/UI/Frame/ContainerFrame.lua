-- ContainerFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/17/2019, 10:21:54 AM
--
local error = error

---- WOW
local CreateFrame = CreateFrame

---- UI
local UIParent = UIParent

---@type ns
local ns = select(2, ...)
local Addon = ns.Addon
local SimpleFrame = ns.UI.SimpleFrame

---@class UI.ContainerFrame: EventsMixin, tdBag2FrameTemplate, UI.SimpleFrame
local ContainerFrame = Addon:NewClass('UI.ContainerFrame', SimpleFrame)
ContainerFrame.TEMPLATE = 'tdBag2FrameTemplate'

function ContainerFrame:Constructor()
    ns.UI.MoneyFrame:Bind(self.MoneyFrame, self.meta)
    ns.UI.TokenFrame:Bind(self.TokenFrame, self.meta)
    ns.UI.BagFrame:Bind(self.BagFrame, self.meta)
    ns.UI.PluginFrame:Bind(self.PluginFrame, self.meta)

    local function OnFocusChanged()
        if self:IsVisible() then
            self:SEARCH_CHANGED()
        end
    end

    self.SearchBox:HookScript('OnEditFocusLost', OnFocusChanged)
    self.SearchBox:HookScript('OnEditFocusGained', OnFocusChanged)
end

function ContainerFrame:Create(bagId)
    return self:Bind(CreateFrame('Frame', nil, UIParent, self.TEMPLATE), bagId)
end

function ContainerFrame:OnShow()
    SimpleFrame.OnShow(self)
    self:RegisterEvent('UPDATE_ALL', 'Update')
    self:RegisterEvent('SEARCH_CHANGED')
    self:RegisterFrameEvent('TOKEN_FRAME_TOGGLED', 'PlaceTokenFrame')
    self:RegisterFrameEvent('BAG_FRAME_TOGGLED', 'SEARCH_CHANGED')
    self:RegisterFrameEvent('PLUGIN_FRAME_TOGGLED')
    self:RegisterFrameEvent('PLUGIN_BUTTON_UPDATE')
    self:Update()
end

function ContainerFrame:SEARCH_CHANGED()
    self:PlaceBagFrame()
    self:PlaceSearchBox()
end

function ContainerFrame:PLUGIN_FRAME_TOGGLED()
    self:PlacePluginFrame()
    self:PlaceSearchBox()
end

function ContainerFrame:UpdateSize()
    SimpleFrame.UpdateSize(self)
    self:PlaceBagFrame()
    self:PlaceSearchBox()
end

function ContainerFrame:Update()
    self:PlacePluginFrame()
    self:PlaceBagFrame()
    self:PlaceSearchBox()
    self:PlaceTokenFrame()
end

function ContainerFrame:PlacePluginFrame()
    self.PluginFrame:SetShown(self.meta.profile.pluginButtons)
end

function ContainerFrame:PlaceBagFrame()
    return self.BagFrame:SetShown(self.meta.profile.bagFrame and
                                      (self:IsSearchBoxSpaceEnough() or
                                          not (self.SearchBox:HasFocus() or Addon:GetSearch())))
end

function ContainerFrame:PlaceTokenFrame()
    return self.TokenFrame:SetShown(self.meta.profile.tokenFrame)
end

function ContainerFrame:PlaceSearchBox()
    error('Not implemented')
end

ContainerFrame.PLUGIN_BUTTON_UPDATE = ns.Spawned(function(self)
    return self:PlaceSearchBox()
end)

function ContainerFrame:IsSearchBoxSpaceEnough()
    return true
end
