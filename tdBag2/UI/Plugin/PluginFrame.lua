-- PluginFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 1/4/2020, 1:18:14 AM

local ipairs = ipairs
local wipe = table.wipe or wipe
local tinsert = table.insert

local CreateFrame = CreateFrame

---@type ns
local ns = select(2, ...)

---@class UI.PluginFrame: EventsMixin, Object, Frame
local PluginFrame = ns.Addon:NewClass('UI.PluginFrame', 'Frame')
PluginFrame.SPACING = 3
PluginFrame.BUTTON_TEMPLATE = 'tdBag2ToggleButtonTemplate'

function PluginFrame:Constructor(_, meta)
    self.meta = meta
    self.menuButtons = {}
    self.pluginButtons = {}

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.UnregisterAllEvents)
end

function PluginFrame:OnShow()
    self:RegisterFrameEvent('PLUGIN_BUTTON_UPDATE', 'Update')
    self:RegisterEvent('UPDATE_ALL', 'Update')
    self:Update()
end

function PluginFrame:Update()
    local menuButtons = self.menuButtons

    for _, button in ipairs(self.menuButtons) do
        button:Hide()
    end

    wipe(menuButtons)

    for _, plugin in ns.Addon:IteratePluginButtons() do
        if not self.meta.profile.disableButtons[plugin.key] then
            tinsert(menuButtons, self.pluginButtons[plugin.key] or self:CreatePluginButton(plugin))
        end
    end

    for i, button in ipairs(menuButtons) do
        button:ClearAllPoints()
        button:SetPoint('RIGHT', -(i - 1) * (button:GetWidth() + self.SPACING), 0)
        button:Show()
    end

    self:SetWidth(#menuButtons == 0 and 1 or #menuButtons * (menuButtons[1]:GetWidth() + self.SPACING) - self.SPACING)
end

function PluginFrame:CreatePluginButton(plugin)
    ---@type tdBag2ToggleButtonTemplate
    local button = CreateFrame('CheckButton', nil, self, self.BUTTON_TEMPLATE)
    button:Hide()
    button.texture:SetTexture(plugin.icon)
    plugin.init(button, self)
    self.pluginButtons[plugin.key] = button
    return button
end
