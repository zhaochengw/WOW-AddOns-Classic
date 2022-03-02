---@type RestockerAddon
local _, RS         = ...;

---@class RsRecipe
---@field item RsItem
---@field ingredients table<RsItem>

RS.RsRecipe         = {}
RS.RsRecipe.__index = RS.RsRecipe

---@return RsRecipe
function RS.RsRecipe:Create(item, reagent1, reagent2, reagent3)
  local fields = { item        = item,
                   ingredients = { reagent1, reagent2, reagent3 } }

  setmetatable(fields, RS.RsRecipe)

  return fields
end
