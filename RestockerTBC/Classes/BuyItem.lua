---@type RestockerAddon
local _, RS       = ...;

---@class RsBuyItem
---@field numNeeded number
---@field itemName string
---@field itemLink string
---@field itemID number

RS.RsBuyItem         = {}
RS.RsBuyItem.__index = RS.RsBuyItem

---@param fields table
---@return RsBuyItem
function RS.RsBuyItem:Create(fields)
  fields = fields or {}
  setmetatable(fields, RS.RsBuyItem)
  return fields
end
