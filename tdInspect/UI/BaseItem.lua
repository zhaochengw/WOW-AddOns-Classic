-- BaseItem.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/18/2020, 3:25:21 PM

---@type ns
local ns = select(2, ...)

local tonumber = tonumber

---@type tdInspectBaseItem
local BaseItem = ns.Addon:NewClass('UI.BaseItem', 'Button')

function BaseItem:Constructor()
    self:SetScript('OnHide', self.OnHide)
end

function BaseItem:OnHide()
    self:UnregisterAllEvents()
end

function BaseItem:GET_ITEM_INFO_RECEIVED(_, itemId, ok)
    if not ok then
        return
    end
    if self.itemId ~= itemId then
        return
    end
    self.itemId = nil
    self:Update()
end

function BaseItem:WaitItem(item)
    self.itemId = ns.ItemLinkToId(item)
    self:RegisterEvent('GET_ITEM_INFO_RECEIVED')
end
