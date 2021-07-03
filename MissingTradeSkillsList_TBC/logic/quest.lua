----------------------------------------
-- Contains all functions for a quest --
----------------------------------------

MTSL_LOGIC_QUEST = {
    -----------------------------------------------------------------------------------------------
    -- Gets a quest available to the player's faction (based on it's ids)
    --
    -- @id				Number		The ids of the quests to search
    --
    -- return			Object		Found quest (nil if not found)
    ------------------------------------------------------------------------------------------------
    GetQuestByIds = function(self, ids)
        if ids then
            local i = 1

            while ids[i] ~= nil do
                local quest = MTSL_TOOLS:GetItemFromSortedListById(MTSL_DATA["quests"], ids[i])
                -- Check if q started from NPC
                if quest ~= nil then
                    if quest.npcs then
                        local npcs = MTSL_LOGIC_PLAYER_NPC:GetNpcsByIds(quest.npcs)
                        if not npcs then
                            for _, npc_id in pairs(quest.npcs) do
                                MTSL_TOOLS:AddMissingData("npc", npc_id)
                            end
                        else
                            -- only 1 NPC possible
                            local npc = npcs[1]
                            -- check if we are able to interact with npc
                            if npc then
                                if npc.reacts == "Neutral" or npc.reacts == MTSL_CURRENT_PLAYER.FACTION then
                                    return quest
                                end
                            end
                        end
                        -- Started from item/object so available to all
                    else
                        return quest
                    end
                else
                    MTSL_TOOLS:AddMissingData("quest", ids[i])
                end

                i = i + 1
            end
        end

        return nil
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets a quest based on its id
    --
    -- @quest_id		Number		The id of the quest to search
    --
    -- return			Object		Found quest
    ------------------------------------------------------------------------------------------------
    GetQuestById = function(self, id)
        return MTSL_TOOLS:GetItemFromSortedListById(MTSL_DATA["quests"], id)
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets a quest based on its id
    --
    -- @quest_id		Number		The id of the quest to search
    --
    -- return			Object		Found quest
    ------------------------------------------------------------------------------------------------
    GetQuestsByIds = function(self, ids)
        local quests = {}
        for _, i in pairs(ids) do
            table.insert(quests,  MTSL_TOOLS:GetItemFromUnsortedListById(MTSL_DATA["quests"], i))
        end
        return quests
    end,
}