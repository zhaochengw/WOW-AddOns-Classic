---@type RestockerAddon
local _TOCNAME, RS = ...

---@class GIICacheItem
---@field itemName string
---@field itemLink string Printable colored clickable item link
---@field itemRarity number 0=poor, 1=normal, 2=uncommon, 3=rare ... etc
---@field itemLevel number
---@field itemMinLevel number
---@field itemType string One of "Armor", "Consumable", "Container", ... see Wiki "ItemType"
---@field itemSubType string Same as itemType
---@field itemStackCount number
---@field itemEquipLoc string "" or a constant INVTYPE_HEAD for example
---@field itemTexture string|number Texture or icon id
---@field itemSellPrice number Copper price for the item

---@type table<number|string, GIICacheItem> Stores arg to results mapping for GetItemInfo
local rs_gii_cache = {}

---Calls GetItemInfo and saves the results, or not (if nil was returned)
---@param arg number|string
---@return GIICacheItem|nil
function RS.GetItemInfo(arg)
  if rs_gii_cache[arg] ~= nil then
    --print("Cached item response for ", arg)
    return rs_gii_cache[arg]
  end

  local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType
  , itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(arg)
  if itemName == nil then
    return nil
  end

  local cache_item = {
    itemName = itemName,
    itemLink = itemLink,
    itemRarity = itemRarity,
    itemLevel = itemLevel,
    itemMinLevel = itemMinLevel,
    itemType = itemType,
    itemSubType = itemSubType,
    itemStackCount = itemStackCount,
    itemEquipLoc = itemEquipLoc,
    itemTexture = itemTexture,
    itemSellPrice = itemSellPrice
  }
  --print("Added to cache item info for ", arg)
  rs_gii_cache[arg] = cache_item
  return cache_item
end
