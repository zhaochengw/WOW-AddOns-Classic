--------------------------------------------------
-- Contains all functions for an item or object --
--------------------------------------------------

MTSL_LOGIC_ITEM_OBJECT = {
    -----------------------------------------------------------------------------------------------
    -- Gets a list of all objects (based on their ids)
    --
    -- @ids					Array		The ids of objects to search
    --
    -- return				Array		List of found items
    ------------------------------------------------------------------------------------------------
    GetObjectsByIds = function(self, ids)
        local objects = {}

        for k, id in pairs(ids)
        do
            local object = self:GetObjectById(id)
            -- If we found one add to list
            if object ~= nil then
                table.insert(objects, object)
            else
                MTSL_TOOLS:AddMissingData("object", id)
            end
        end

        -- Return the found objects sorted by localised name
        return MTSL_TOOLS:SortArrayByLocalisedProperty(objects, "name")
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets an object (based on it's id)
    --
    -- @id				Number		The id of the item to search
    --
    -- return			Object		Found item (nil if not found)
    ------------------------------------------------------------------------------------------------
    GetObjectById = function(self, id)
        return MTSL_TOOLS:GetItemFromArrayByKeyValue(MTSL_DATA["objects"], "id", id)
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets a list of all items (based on their ids)
    --
    -- @ids					Array		The ids of items to search
    -- @profession_name     String      The name of the profession
    --
    -- return				Array		List of found items
    ------------------------------------------------------------------------------------------------
    GetItemsForProfessionByIds = function(self, ids, profession_name)
        local items = {}

        for k, id in pairs(ids)
        do
            local item = self:GetItemForProfessionById(id, profession_name)
            -- If we found one add to list
            if item ~= nil then
                table.insert(items, item)
            else
                MTSL_TOOLS:AddMissingData("item ", id)
            end
        end

        -- Return the found items sorted by localised name
        return MTSL_TOOLS:SortArrayByLocalisedProperty(items, "name")
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets an item (based on it's id)
    --
    -- @id				    Number		The id of the item to search
    -- @profession_name     String      The name of the profession
    --
    -- return			    Object		Found item (nil if not found)
    ------------------------------------------------------------------------------------------------
    GetItemForProfessionById = function(self, id, profession_name)
        return MTSL_TOOLS:GetItemFromArrayByKeyValue(MTSL_DATA["items"][profession_name], "id", id)
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets the name of a currency (based on it's id)
    --
    -- @id				    Number		The id of the currency to search
    --
    -- return			    Object		Found name (nil if not found)
    ------------------------------------------------------------------------------------------------
    GetCurrencyNameById = function(self, id)
        local currency = MTSL_TOOLS:GetItemFromArrayByKeyValue(MTSL_DATA["currencies"], "id", id)
        if currency then
            return MTSLUI_TOOLS:GetLocalisedData(currency)
        else
            MTSL_TOOLS:AddMissingData("currency", id)
            return ""
        end
    end,

    GetItemQualityNameById = function(self, id)
        local item_quality = MTSL_TOOLS:GetItemFromArrayByKeyValue(MTSL_DATA["item_qualities"], "id", id)
        if item_quality then
            return item_quality.name
        end
        return "poor"
    end
}