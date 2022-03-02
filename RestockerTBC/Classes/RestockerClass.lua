---@type RestockerAddon
local _, RS = ...;

---@class RestockerAddon
---@field MainFrame table Main frame of the addon
---@field EventFrame table Hidden frame for addon events
---@field loaded boolean
---@field bankIsOpen boolean
---@field merchantIsOpen boolean
---@field TBC boolean Whether we are running TBC or Classic Era
---
---@field addItemWait table<number, any> Item ids waiting for resolution to be added to the buy list
---@field buyIngredients table<string, RsRecipe> Auto buy table contains ingredients to buy if restocking some crafted item
---@field buyIngredientsWait table<number, RsRecipe> Item ids waiting for resolution for auto-buy setup
