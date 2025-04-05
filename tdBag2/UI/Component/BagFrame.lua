-- BagFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/20/2019, 3:32:48 AM
--
---- LUA
local ipairs = ipairs

---- WOW
local CreateFrame = CreateFrame

---@type ns
local ns = select(2, ...)

---@class UI.BagFrame: EventsMixin, Object, Frame
local BagFrame = ns.Addon:NewClass('UI.BagFrame', 'Frame')
BagFrame.SPACING = 3
BagFrame.BAG_TEMPLATE = 'tdBag2BagTemplate'
BagFrame.KEYRING_TEMPLATE = 'tdBag2KeyringTemplate'

function BagFrame:Constructor(_, meta)
    ---@type FrameMeta
    self.meta = meta
    self:SetScript('OnShow', self.OnShow)
end

function BagFrame:OnShow()
    self:SetScript('OnShow', nil)
    self:Update()
end

function BagFrame:Update()
    local spacing = self.SPACING
    local button, prevButton
    local width = 0

    for i, bag in ipairs(self.meta.bags) do
        local template = ns.IsKeyring(bag) and self.KEYRING_TEMPLATE or self.BAG_TEMPLATE
        button = ns.UI.Bag:Bind(CreateFrame('Button', nil, self, template), self.meta, bag)
        if i == 1 then
            button:SetPoint('LEFT')
        else
            button:SetPoint('LEFT', prevButton, 'RIGHT', spacing, 0)
        end
        prevButton = button
        width = width + button:GetWidth() + spacing
    end
    if button then
        width = width - spacing
    end

    self:SetSize(width, button:GetHeight())
end
