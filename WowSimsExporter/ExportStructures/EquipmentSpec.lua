-- An EquipmentSpec is the data representation for items used by the sim.
--
-- A table created with CreateEquipmentSpec() will behave much like a normal table,
-- but it will throw errors if doing anything but setting an ItemSpec (see ItemSpec.lua)
-- or nil for numeric keys on the EquipmentSpec.items subtable.
--
-- The helper functions EquipmentSpecMeta:UpdateEquippedItems(unit) and
-- EquipmentSpecMeta:FillFromBagItems() can be used to fill items depending on context.
--
-- When editing EquipmentSpec.items manually ensure that items are at their correct postion.

local Env = select(2, ...)

-- Values are constants for slotIds.
local itemLayout = {
    INVSLOT_HEAD,
    INVSLOT_NECK,
    INVSLOT_SHOULDER,
    INVSLOT_BACK,
    INVSLOT_CHEST,
    INVSLOT_WRIST,
    INVSLOT_HAND,
    INVSLOT_WAIST,
    INVSLOT_LEGS,
    INVSLOT_FEET,
    INVSLOT_FINGER1,
    INVSLOT_FINGER2,
    INVSLOT_TRINKET1,
    INVSLOT_TRINKET2,
    INVSLOT_MAINHAND,
    INVSLOT_OFFHAND,
    INVSLOT_RANGED,
    -- INVSLOT_AMMO, -- Not supported as item
}

local slotToIndex = {
    INVSLOT_HEAD = 1,
    INVSLOT_NECK = 2,
    INVSLOT_SHOULDER = 3,
    INVSLOT_BACK = 4,
    INVSLOT_CHEST = 5,
    INVSLOT_WRIST = 6,
    INVSLOT_HAND = 7,
    INVSLOT_WAIST = 8,
    INVSLOT_LEGS = 9,
    INVSLOT_FEET = 10,
    INVSLOT_FINGER1 = 11,
    INVSLOT_FINGER2 = 12,
    INVSLOT_TRINKET1 = 13,
    INVSLOT_TRINKET2 = 14,
    INVSLOT_MAINHAND = 15,
    INVSLOT_OFFHAND = 16,
    INVSLOT_RANGED = 17,
}


-- Metatable for the base EquipmentSpec table.
local EquipmentSpecMeta = { isEquipmentSpec = true }
EquipmentSpecMeta.__index = EquipmentSpecMeta

---Prevent adding keys for the base table entirely.
---@param self table
---@param key any The key that is being added.
---@param value any The value that is being added.
function EquipmentSpecMeta.__newindex(self, key, value)
    error("Adding keys to EquipmentSpec base is not allowed!")
end

---Clear all items.
function EquipmentSpecMeta:Reset()
    wipe(self.items)
end

---Fill items with currently equipped items.
function EquipmentSpecMeta:UpdateEquippedItems(unit)
    self:Reset()
    for itemIndex, slotId in ipairs(itemLayout) do
        local itemLink = GetInventoryItemLink(unit, slotId)
        if itemLink then
            local itemSpec = Env.CreateItemSpec()
            itemSpec:FillFromItemLink(itemLink)
            if Env.IS_CLASSIC_ERA_SOD then itemSpec:SetRuneSpellFromSlot(slotId) end
            if Env.IS_CLASSIC_CATA then itemSpec:SetReforge(unit, slotId) end
            if Env.IS_CLASSIC_MISTS then
                itemSpec:SetUpgrade(unit, slotId)
                if slotId == INVSLOT_HAND then
                    itemSpec:SetHandTinker(unit)
                end
            end
            self.items[itemIndex] = itemSpec
        end
    end
end

---Fill items with items from bag. Valid items are filtered by
---the Env.TreatItemAsPossibleUpgrade(itemLink) function.
function EquipmentSpecMeta:FillFromBagItems()
    local GetContainerNumSlots = C_Container.GetContainerNumSlots
    local GetContainerItemLink = C_Container.GetContainerItemLink
    self:Reset()
    for bagId = 0, NUM_BAG_SLOTS do
        for slotId = 1, GetContainerNumSlots(bagId) do
            local itemLink = GetContainerItemLink(bagId, slotId)
            if itemLink and Env.TreatItemAsPossibleUpgrade(itemLink) then
                local itemSpec = Env.CreateItemSpec()
                itemSpec:FillFromItemLink(itemLink)
                if Env.IS_CLASSIC_ERA_SOD then itemSpec:SetRuneSpellFromSlot(slotId, bagId) end
                table.insert(self.items, itemSpec)
            end
        end
    end
end

---Attempt to infer professions from gear
---@return table
local GetItemNumSockets = C_Item.GetItemNumSockets
function EquipmentSpecMeta:InferProfessions()
    local professions = {}
    if self.items[slotToIndex.INVSLOT_FINGER1]:GetEnchant() or self.items[slotToIndex.INVSLOT_FINGER2]:GetEnchant() then
        table.insert(professions,{name = "Enchanting", level = 600})
    end
    if #self.items[slotToIndex.INVSLOT_HAND]:GetGems() > GetItemNumSockets(self.items[slotToIndex.INVSLOT_HAND]:GetId()) or
       #self.items[slotToIndex.INVSLOT_WRIST]:GetGems() > GetItemNumSockets(self.items[slotToIndex.INVSLOT_WRIST]:GetId()) then
        table.insert(professions,{name = "Blacksmithing", level = 600})
    end
    if table.contains({4880,4881,4882}, self.items[slotToIndex.INVSLOT_LEGS]:GetEnchant()) or table.contains({4875,4877,4878,4879}, self.items[slotToIndex.INVSLOT_WRIST]:GetEnchant()) then
        table.insert(professions,{name = "Leatherworking", level = 600})
    end
    if table.contains({4895,4896}, self.items[slotToIndex.INVSLOT_LEGS]:GetEnchant()) or table.contains({4892,4893,4894}, self.items[slotToIndex.INVSLOT_BACK]:GetEnchant()) then
        table.insert(professions,{name = "Tailoring", level = 600})
    end
    if self.items[slotToIndex.INVSLOT_HAND]:GetTinker() ~= nil then
        table.insert(professions,{name = "Engineering", level = 600})
    end
    for _, item in ipairs(self.items) do
        if table.contains({83141,83147,83150,83151,83152}, item:GetGems()) then
            table.insert(professions,{name = "Jewelcrafting", level = 600})
            break
        end
    end
    if table.contains({4912,4913,4914,4915}, self.items[slotToIndex.INVSLOT_SHOULDER]:GetEnchant()) then
        table.insert(professions,{name = "Inscription", level = 600})
    end
    if #professions > 2 then
        error("Too many professions detected !")
    end
    return professions
end

-- Metatable for the EquipmentSpec.items table.
local EquipmentSpecItemsMeta = { isEquipmentSpecItems = true }
EquipmentSpecItemsMeta.__index = EquipmentSpecItemsMeta

---Prevent adding keys that are no valid item slot or no ItemSpec table.
---@param self table
---@param key any The key that is being added.
---@param value any The value that is being added.
function EquipmentSpecItemsMeta.__newindex(self, key, value)
    assert(type(key) == "number", "Can't add a non-numeric key " .. key .. " to EquipmentSpec.items!")
    assert(value == nil or value.isItemSpec, "Tried adding a non-ItemSpec value to EquipmentSpec.items!")
    rawset(self, key, value)
end

-- Create a new EquipmentSpec table.
local function CreateEquipmentSpec()
    local items = setmetatable({}, EquipmentSpecItemsMeta)
    local equipment = setmetatable({ items = items, version = Env.VERSION }, EquipmentSpecMeta)
    return equipment
end

Env.CreateEquipmentSpec = CreateEquipmentSpec
