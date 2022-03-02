--
--This Module contains auto-buy table for ingredients for craftable items (example rogue poisons)
--
---@type RestockerAddon
local _, RS = ...;

--- From 2 choices return TBC if BOM.TBC is true, otherwise return classic
local function tbcOrClassic(tbc, classic)
  if RS.TBC then
    return tbc
  end
  return classic
end

---@param recipe RsRecipe
local function rsAddCraftableRecipe(recipe)
  -- Two situations can happen:
  -- 1. GetItemInfo will work and return all values required
  -- 2. Some values will not work - then we place the task into RS.buyIngredientsWait and do later
  local function postpone()
    RS.buyIngredientsWait[recipe.item.id] = recipe
  end

  local itemVal = RS.GetItemInfo(recipe.item.id) --- @type GIICacheItem
  if not itemVal then
    postpone()
    return
  end
  recipe.item.localizedName = itemVal.itemName -- update localizedName

  local ing1 = recipe.ingredients[1][1]
  local ing1Val = RS.GetItemInfo(ing1.id) --- @type GIICacheItem
  if not ing1Val then
    postpone()
    return
  end
  ing1.localizedName = ing1Val.itemName -- update localizedName

  local ing2Val --- @type GIICacheItem
  local ing3Val --- @type GIICacheItem

  if recipe.ingredients[2] then
    local ing2 = recipe.ingredients[2][1]
    ing2Val = RS.GetItemInfo(ing2.id)
    if not ing2Val then
      postpone()
      return
    end
    ing2.localizedName = ing2Val.itemName -- update localizedName
  end

  if recipe.ingredients[3] then
    local ing3 = recipe.ingredients[3][1]
    ing3Val = RS.GetItemInfo(ing3.id)
    if not ing3Val then
      postpone()
      return
    end
    ing3.localizedName = ing3Val.itemName -- update localizedName
  end

  --RS.Dbg("Added craft recipe for item " .. recipe.item.id)
  RS.buyIngredients[itemVal.itemName] = recipe -- added with localized name key
  RS.buyIngredientsWait[recipe.item.id] = nil -- delete the waiting one
end

---@param item RsItem
---@param reagent1 table<RsItem|number> Pair of {Item, Count} First reagent to craft
---@param reagent2 table<RsItem|number>|nil Nil or pair of {Item, Count} 2nd reagent to craft
---@param reagent3 table<RsItem|number>|nil Nil or pair of {Item, Count} 3rd reagent to craft
local function rsAddCraftable(item, reagent1, reagent2, reagent3)
  local recipe = RS.RsRecipe:Create(item, reagent1, reagent2, reagent3)
  rsAddCraftableRecipe(recipe)
end

function RS.RetryWaitRecipes()
  for _, recipe in pairs(RS.buyIngredientsWait) do
    rsAddCraftableRecipe(recipe)
  end
end

local function rsAddCraftable_TBC(item, reagent1, reagent2, reagent3)
  if RS.TBC then
    rsAddCraftable(item, reagent1, reagent2, reagent3)
  end
end

local function rsAddCraftable_CLASSIC(item, reagent1, reagent2, reagent3)
  if not RS.TBC then
    rsAddCraftable(item, reagent1, reagent2, reagent3)
  end
end

function RS.SetupAutobuyIngredients()
  RS.buyIngredients = {}
  RS.buyIngredientsWait = {}

  local maidensAnguish = { RS.RsItem:Create(2931, "Maiden's Anguish"), 1 } -- always 1 in crafts
  local dustOfDeter = RS.RsItem:Create(8924, "Dust of Deterioration")
  local dustOfDecay = RS.RsItem:Create(2928, "Dust of Decay")
  local essOfAgony = RS.RsItem:Create(8923, "Essence of Agony")
  local essOfPain = RS.RsItem:Create(2930, "Essence of Pain")
  local deathweed = RS.RsItem:Create(5173, "Deathweed")

  local crystalVial = { RS.RsItem:Create(8925, "Crystal Vial"), 1 }
  local leadedVial = { RS.RsItem:Create(3372, "Leaded Vial"), 1 }
  local emptyVial = { RS.RsItem:Create(3371, "Empty Vial"), 1 }

  --
  -- INSTANT POISONS
  --
  local instant7 = RS.RsItem:Create(21927, "Instant Poison VII")
  local instant6 = RS.RsItem:Create(8928, "Instant Poison VI")
  local instant5 = RS.RsItem:Create(8927, "Instant Poison V")
  local instant4 = RS.RsItem:Create(8926, "Instant Poison IV")
  local instant3 = RS.RsItem:Create(6950, "Instant Poison III")
  local instant2 = RS.RsItem:Create(6949, "Instant Poison II")
  local instant1 = RS.RsItem:Create(6947, "Instant Poison")

  rsAddCraftable_TBC(instant7, maidensAnguish, crystalVial)
  rsAddCraftable_TBC(instant6, { dustOfDeter, 2 }, crystalVial)
  rsAddCraftable_TBC(instant5, { dustOfDeter, 2 }, crystalVial)
  rsAddCraftable_TBC(instant4, { dustOfDeter, 1 }, crystalVial)
  rsAddCraftable_TBC(instant3, { dustOfDeter, 2 }, leadedVial)
  rsAddCraftable_TBC(instant2, { dustOfDecay, 1 }, leadedVial)

  rsAddCraftable_CLASSIC(instant6, { dustOfDeter, 4 }, emptyVial)
  rsAddCraftable_CLASSIC(instant5, { dustOfDeter, 3 }, emptyVial)
  rsAddCraftable_CLASSIC(instant4, { dustOfDeter, 2 }, emptyVial)
  rsAddCraftable_CLASSIC(instant3, { dustOfDeter, 1 }, emptyVial)
  rsAddCraftable_CLASSIC(instant2, { dustOfDecay, 3 }, emptyVial)

  rsAddCraftable(instant1, { dustOfDecay, 1 }, emptyVial)

  --
  -- CRIPPLING POISONS
  --
  local crip2 = RS.RsItem:Create(3776, "Crippling Poison II")
  local crip1 = RS.RsItem:Create(3775, "Crippling Poison")

  rsAddCraftable_TBC(crip2, { essOfAgony, 1 }, crystalVial)
  rsAddCraftable_CLASSIC(crip2, { essOfAgony, 3 }, emptyVial)

  rsAddCraftable(crip1, { essOfPain, 1 }, emptyVial)

  --
  -- DEADLY POISONS
  --
  local deadly7 = RS.RsItem:Create(22054, "Deadly Poison VII")
  local deadly6 = RS.RsItem:Create(22053, "Deadly Poison VI")
  local deadly5 = RS.RsItem:Create(20844, "Deadly Poison V")
  local deadly4 = RS.RsItem:Create(8985, "Deadly Poison IV")
  local deadly3 = RS.RsItem:Create(8984, "Deadly Poison III")
  local deadly2 = RS.RsItem:Create(2893, "Deadly Poison II")
  local deadly1 = RS.RsItem:Create(2892, "Deadly Poison")

  rsAddCraftable_TBC(deadly7, maidensAnguish, crystalVial)
  rsAddCraftable_TBC(deadly6, maidensAnguish, crystalVial)
  rsAddCraftable_TBC(deadly5, { deathweed, 2 }, crystalVial)
  rsAddCraftable_TBC(deadly4, { deathweed, 2 }, crystalVial)
  rsAddCraftable_TBC(deadly3, { deathweed, 1 }, crystalVial)
  rsAddCraftable_TBC(deadly2, { deathweed, 2 }, leadedVial)
  rsAddCraftable_TBC(deadly1, { deathweed, 1 }, leadedVial)

  rsAddCraftable_CLASSIC(deadly5, { deathweed, 7 }, emptyVial)
  rsAddCraftable_CLASSIC(deadly4, { deathweed, 5 }, emptyVial)
  rsAddCraftable_CLASSIC(deadly3, { deathweed, 3 }, emptyVial)
  rsAddCraftable_CLASSIC(deadly2, { deathweed, 2 }, emptyVial)
  rsAddCraftable_CLASSIC(deadly1, { deathweed, 1 }, emptyVial)

  -- MIND-NUMBING POISONS
  local mindNumbing3 = RS.RsItem:Create(9186, "Mind-numbing Poison III")
  local mindNumbing2 = RS.RsItem:Create(6951, "Mind-numbing Poison II")
  local mindNumbing1 = RS.RsItem:Create(5237, "Mind-numbing Poison")

  rsAddCraftable_TBC(mindNumbing3, { essOfAgony, 1 }, crystalVial)
  rsAddCraftable_TBC(mindNumbing2, { essOfAgony, 1 }, leadedVial)
  rsAddCraftable_TBC(mindNumbing1, { dustOfDecay, 1 }, emptyVial)

  rsAddCraftable_CLASSIC(mindNumbing3, { dustOfDeter, 2 }, { essOfAgony, 2 }, emptyVial)
  rsAddCraftable_CLASSIC(mindNumbing2, { dustOfDecay, 4 }, { essOfPain, 4 }, emptyVial)
  rsAddCraftable_CLASSIC(mindNumbing1, { dustOfDecay, 1 }, { essOfPain, 1 }, emptyVial)

  -- WOUND POISONS
  local wound5 = RS.RsItem:Create(22055, "Wound Poison V")
  local wound4 = RS.RsItem:Create(10922, "Wound Poison IV")
  local wound3 = RS.RsItem:Create(10921, "Wound Poison III")
  local wound2 = RS.RsItem:Create(10920, "Wound Poison II")
  local wound1 = RS.RsItem:Create(10918, "Wound Poison")

  rsAddCraftable_TBC(wound5, { essOfAgony, 2 }, crystalVial)
  rsAddCraftable_TBC(wound4, { essOfAgony, 1 }, { deathweed, 1 }, crystalVial)
  rsAddCraftable_TBC(wound3, { essOfAgony, 1 }, crystalVial)
  rsAddCraftable_TBC(wound2, { essOfPain, 1 }, { deathweed, 1 }, leadedVial)
  rsAddCraftable_TBC(wound1, { essOfPain, 1 }, leadedVial)

  rsAddCraftable_CLASSIC(wound4, { essOfAgony, 2 }, { deathweed, 2 }, emptyVial)
  rsAddCraftable_CLASSIC(wound3, { essOfAgony, 1 }, { deathweed, 2 }, emptyVial)
  rsAddCraftable_CLASSIC(wound2, { essOfPain, 1 }, { deathweed, 2 }, emptyVial)
  rsAddCraftable_CLASSIC(wound1, { essOfPain, 1 }, { deathweed, 1 }, emptyVial)

  -- ANESTHETIC POISON
  local anesth1 = RS.RsItem:Create(21835, "Anesthetic Poison")
  rsAddCraftable_TBC(anesth1, maidensAnguish, { deathweed, 1 }, crystalVial)
end

--- Check if any of the items user wants to restock are on our crafting autobuy list
function RS.CraftingPurchaseOrder()
  local purchaseOrder = {} ---@type table<string, number> Maps localized item name to buy count

  -- Check auto-buy reagents table
  for _, item in ipairs(Restocker.profiles[Restocker.currentProfile]) do
    if RS.buyIngredients[item.itemName] ~= nil then
      local craftedName = item.itemName
      local craftedRestockAmount = item.amount
      local haveCrafted = GetItemCount(item.itemID, true)
      local inBags = GetItemCount(item.itemID, false)
      local craftedMissing = craftedRestockAmount - haveCrafted
      local inBank = haveCrafted - inBags
      local minDifference

      if inBank == 0 then
        minDifference = 1
      else
        minDifference = craftedRestockAmount / 2
      end

      if craftedMissing >= minDifference and craftedMissing > 0 then
        local recipe = RS.buyIngredients[craftedName]

        ---@type table<RsItem|number> each element in ingredients is {RsItem, Count :: number}
        for _, ingredient in pairs(recipe.ingredients) do
          if ingredient then
            local amountToGet = ingredient[2] * craftedMissing
            local locName = ingredient[1].localizedName
            local purchase = purchaseOrder[locName]

            purchaseOrder[locName] = purchase and purchase + amountToGet or amountToGet
          end -- if ingredient
        end -- each ingredient
      end -- if need to buy missing reagents/ingredients
    end
  end

  for reagent, val in pairs(purchaseOrder) do
    local inBags = GetItemCount(reagent, false)
    if inBags > 0 then
      purchaseOrder[reagent] = purchaseOrder[reagent] - inBags
    end
  end

  return purchaseOrder
end
