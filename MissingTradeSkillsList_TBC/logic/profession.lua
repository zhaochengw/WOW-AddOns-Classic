---------------------------------------------
-- Contains all functions for a profession --
---------------------------------------------

MTSL_LOGIC_PROFESSION = {
    BONUS_RACIAL = {
        ["Enchanting"] = 10, -- Blood Elf,
        ["Herbalism"] = 15, -- Tauren
        ["Jewelcrafting"] = 5, -- Draenei
    },

    ----------------------------------------------------------------------------------------
    -- Returns the current rank learned for a profession (1 Apprentice to  4 Artisan)
    --
    -- @profession_name     String      The name of the profession
    -- @max_level           Number      The current maximum number of skill that can be learned
    --
    -- returns              Array       The array with the ids of the missing levels
    -----------------------------------------------------------------------------------------
    GetRankForProfessionByMaxLevel = function(self, profession_name, max_level)
        local ranks = self:GetRanksForProfession(profession_name)
        for _, v in pairs(ranks) do
            -- also add racial if exsists
            if v.max_skill == max_level or (self.BONUS_RACIAL[profession_name] and v.max_skill + self.BONUS_RACIAL[profession_name] == max_level) then
                return v.rank
            end
        end
        -- always return lowest possible rank (for poisons)
        return 1
    end,

    -----------------------------------------------------------------------------------------------
    -- Get all the levels of a profession, ordered by rank (Apprentice, Journeyman, Expert, Artisan)
    --
    -- @profession_name     String      The name of the profession
    --
    -- returns              Array       The array with levels
    -----------------------------------------------------------------------------------------------
    GetRanksForProfession = function(self, profession_name)
        return MTSL_TOOLS:SortArrayByProperty(MTSL_DATA["levels"][profession_name], "rank")
    end,

    -----------------------------------------------------------------------------------------------
    -- Returns a list of skills based on the filters
    --
    -- @list_skills         Array       The list of skills to filter
    -- @profession_name     String      The name of the profession
    -- @skill_name          String      The (partial) name of the skill
    -- @source_types        Array       The sourcetypes allowed for the skill
    -- @specialisation_ids  Array       The ids of the specialisation
    -- @expansions			Array		The numbers of expansions and phases in expansion for during one the recipe has to be available
    -- @zone_id				Number		The id of the zone in which we must be able to learn skill (0 = all)
    -- @faction_ids			Array		The ids of the faction from which we must be able to learn skill (0 = all)
    --
    -- returns              Array       The skills passed the filter
    -----------------------------------------------------------------------------------------------
    FilterListOfSkills = function(self, list_skills, profession_name, skill_name, source_types, specialisation_ids, expansions, zone_id, faction_ids)
        local filtered_list = {}

        -- alter the skill_name now if needed
        local check_skill_name = false
        if skill_name ~= nil then
            -- remove leading & trailing spaces
            skill_name = string.gsub(skill_name, "^%s*(.-)%s*$", "%1")
            -- if we still have text to search enable the flag and lowercase the text
            if string.len(skill_name) > 0 then
                check_skill_name = true
                skill_name = string.lower(skill_name)
            end
        end

        -- add all the skills
        if list_skills ~= nil then
            for _, v in pairs(list_skills) do
                local skill_passed_filter = true
                -- Check if name is ok
                if check_skill_name == true then
                    local name = string.lower(MTSLUI_TOOLS:GetLocalisedData(v))
                    local start_index, _ = string.find(name, skill_name)
                    -- if we dont have a start index, the name does not contain the pattern
                    if start_index == nil then
                        skill_passed_filter = false
                    end
                end

                local spec_id = v.specialisation
                --  check specialisation (added check for no specialisation = -1)
                if v.specialisation == nil then
                    spec_id = 0
                end

                if skill_passed_filter == true and MTSL_TOOLS:ListContainsNumber(specialisation_ids, spec_id) == false then
                    skill_passed_filter = false
                end
                -- Check availability in expansion
                if skill_passed_filter == true and MTSL_TOOLS:ListContainsNumber(expansions, v.expansion + v.phase) == false then
                    skill_passed_filter = false
                end
                -- Check availability in zone
                if skill_passed_filter == true and MTSL_LOGIC_SKILL:IsSkillAvailableInZone(v, profession_name, zone_id) == false then
                    skill_passed_filter = false
                end
                -- check if source type is ok
                if skill_passed_filter == true and MTSL_LOGIC_SKILL:IsAvailableForSourceTypes(v.id, profession_name, source_types) == false then
                    skill_passed_filter = false
                end
                -- check if faction is ok
                if skill_passed_filter == true and MTSL_LOGIC_SKILL:IsAvailableForFactions(v.id, profession_name, faction_ids) == false then
                    skill_passed_filter = false
                end
                -- passed all filters so add it to list
                if skill_passed_filter then
                    table.insert(filtered_list, v)
                end
            end
        end
        return filtered_list
    end,

    -----------------------------------------------------------------------------------------------
    -- Get All the available (in the given phase) skills and levels in a zone for one profession sorted by minimum skill
    --
    -- @profession_name		String		The name of the profession
    -- @max_phase			Number		The maximum content phase for skill to be included (default = current)
    -- @zone_id				Number		The id of the zone in which we must be able to learn skill (0 = all)
    --
    -- return				Array		All the skills for one profession sorted by name or minimim skill
    ------------------------------------------------------------------------------------------------
    GetAllAvailableSkillsAndLevelsForProfessionInZone = function(self, profession_name, max_phase, zone_id)
        local profession_skills = {}

        local arrays_to_loop = { "skills", "levels", "specialisations" }

        for _, a in pairs(arrays_to_loop) do
            if MTSL_DATA[a][profession_name] then
                for _, v in pairs(MTSL_DATA[a][profession_name]) do
                    if MTSL_LOGIC_SKILL:IsSkillAvailableInPhase(v, max_phase) and
                            MTSL_LOGIC_SKILL:IsSkillAvailableInZone(v, profession_name, zone_id) then
                        table.insert(profession_skills, v)
                    end
                end
            end
        end

        -- sort the array by minimum skill
        MTSL_TOOLS:SortArrayByProperty(profession_skills, "min_skill")

        return profession_skills
    end,

    -----------------------------------------------------------------------------------------------
    -- Get All the skills and levels for one profession sorted by minimim skill (regardless the zone, phase)
    --
    -- @prof_name			String		The name of the profession
    -- @max_phase			Number		The maximum content phase for skill to be included (default = current)
    -- @zone_id				Number		The id of the zone in which we must be able to learn skill (0 = all)
    --
    -- return				Array		All the skills for one profession sorted by name or minimim skill
    ------------------------------------------------------------------------------------------------
    GetAllSkillsAndLevelsForProfession = function(self, profession_name)
        -- MAX_PHASE to allow all skills to be considered
        -- pass 0 as zone_id for all zones
        return self:GetAllAvailableSkillsAndLevelsForProfessionInZone(profession_name, MTSL_DATA.MAX_PATCH_LEVEL, 0)
    end,

    -----------------------------------------------------------------------------------------------
    -- Get All the available (in the given phase) skills (EXCL the levels) for one profession sorted by minimim skill
    --
    -- @prof_name			String		The name of the profession
    -- @max_phase			Number		The maximum content phase for skill to be included (default = current)
    -- @class_name          String      The name of the class of the player
    --
    -- return				Array		All the skills for one profession sorted by name or minimim skill
    ------------------------------------------------------------------------------------------------
    GetAllAvailableSkillsForProfession = function(self, profession_name, max_phase, class_name)
        local profession_skills = {}

        if MTSL_DATA["skills"][profession_name] then
            -- add all the skills, dont add a skill if obtainable for ohter classes
            for _, skill in pairs(MTSL_DATA["skills"][profession_name]) do
                if tonumber(skill.phase) <= tonumber(max_phase) and
                        (not skill.classes or (skill.classes and MTSL_TOOLS:ListContainsKeyIngoreCasingAndSpaces(skill.classes, class_name))) then
                    table.insert(profession_skills, skill)
                end
            end
        end
        -- sort the array by minimum skill
        MTSL_TOOLS:SortArrayByProperty(profession_skills, "min_skill")

        return profession_skills
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets a list of skill ids for the current craft that are learned
    --
    -- return				Array		Array containing all the ids
    ------------------------------------------------------------------------------------------------
    GetSkillIdsCurrentCraft = function(self)
        local learned_skill_ids = {}
        if CraftFrame then
            -- Loop all known skills
            for i = 1, GetNumCrafts() do
                local _, _, skill_type = GetCraftInfo(i)
                -- Skip the headers, only check real skills
                if skill_type ~= "header" then
                    local itemLink = GetCraftItemLink(i)
                    local itemID = itemLink:match("enchant:(%d+)")
                    table.insert(learned_skill_ids, itemID)
                end
            end
        end
        -- Sort the list
        learned_skill_ids = MTSL_TOOLS:SortArrayNumeric(learned_skill_ids)
        -- return the found list
        return learned_skill_ids
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets a list of localised skill names for the current tradeskill that are learned
    --
    -- return				Array		Array containing all the names
    ------------------------------------------------------------------------------------------------
    GetSkillNamesCurrentTradeSkill = function(self)
        local learned_skill_names = {}
        -- Loop all known skills
        for i = 1, GetNumTradeSkills() do
            local skill_name, skill_type = GetTradeSkillInfo(i)
            -- Skip the headers, only check real skills
            if skill_name ~= nil and skill_type ~= "header" then
                table.insert(learned_skill_names, skill_name)
            end
        end
        -- return the found list
        return learned_skill_names
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets a list of skill ids for the current tradeskill that are learned
    --
    -- return				Array		Array containing all the ids
    ------------------------------------------------------------------------------------------------
    GetSkillIdsCurrentTradeSkill = function(self, profession_name)
        local learned_skill_ids = {}
        if TradeSkillFrame then
            local localise_profession_name, _, _ = GetTradeSkillLine()
            local localised_profession_name = MTSL_LOGIC_PROFESSION:GetEnglishProfessionNameFromLocalisedName(localise_profession_name)
            -- make sure we try to get the skills for the openeed tradeskill window
            if profession_name and localised_profession_name == profession_name then
                -- Loop all known skills
                for i = 1, GetNumTradeSkills() do
                    local skill_name, skill_type = GetTradeSkillInfo(i)
                    -- Skip the headers, only check real skills
                    if skill_name and skill_type ~= "header" then
                        local crafted_item_id = GetTradeSkillItemLink(i):match("item:(%d+)")
                        if crafted_item_id then
                            local skill_id = MTSL_LOGIC_SKILL:GetSkillIdForProfessionByCraftedItemId(crafted_item_id, profession_name)
                            if skill_id ~= 0 then
                                table.insert(learned_skill_ids, skill_id)
                            else
                                local skill_id = MTSL_LOGIC_SKILL:GetSkillIdForProfessionByLocalisedName(skill_name, profession_name)
                                if skill_id ~= 0 then
                                    table.insert(learned_skill_ids, skill_id)
                                end
                            end
                        end
                    end
                end
                -- Sort the list
                learned_skill_ids = MTSL_TOOLS:SortArrayNumeric(learned_skill_ids)
            end
        end
        -- return the found list
        return learned_skill_ids
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the status for a player for a skill of a Profession
    --
    -- @player				Object		The player for who to check
    -- @profession_name	    String		The name of the profession
    -- @skill_id			Number		The id of the skill to search
    --
    -- return				Number		Status of the skill
    ------------------------------------------------------------------------------------------------
    IsSkillKnownForPlayer = function(self, player, profession_name, skill_id)
        local trade_skill = player.TRADESKILLS[profession_name]
        -- returns 0 if tadeskill not trained, 1 if trained but skill not learned and current skill to low, 2 if skill is learnable, 3 if skill learned
        local known_status
        if trade_skill == nil or trade_skill == 0 then
            known_status = 0
        else
            local skill_known = MTSL_TOOLS:ListContainsNumber(trade_skill.MISSING_SKILLS, skill_id)
            if skill_known == true then
                known_status = 3
            else
                -- try to find the skill
                local skill = MTSL_TOOLS:GetItemFromUnsortedListById(MTSL_DATA["skills"][profession_name], skill_id)
                -- its a level
                if skill == nil then
                    skill = MTSL_TOOLS:GetItemFromUnsortedListById(MTSL_DATA["levels"][profession_name], skill_id)
                end
                if trade_skill.SKILL_LEVEL < skill.min_skill then
                    known_status = 1
                else
                    known_status = 2
                end
            end
        end
        return known_status
    end,

    -----------------------------------------------------------------------------------------------
    -- Get number of available skills for one profession up to max content phase
    --
    -- @profession_name		String		The name of the profession
    -- @max_phase			Number		The maximum content phase for skill to be included
    -- @specialisation_ids  Array       The ids of the specialisation to include in count
    --
    -- return				Number		the number
    ------------------------------------------------------------------------------------------------
    GetTotalNumberOfAvailableSkillsForProfession = function(self, profession_name, max_phase, specialisation_ids)
        local amount = 0
        -- No specilisation learned, so return the max number
        if MTSL_TOOLS:CountItemsInArray(specialisation_ids) <= 0 then
            for k, s in pairs(MTSL_DATA["AMOUNT_SKILLS"]["phase_" .. max_phase][profession_name]) do
                amount = amount + tonumber(s)
            end
        else
            amount = tonumber(MTSL_DATA["AMOUNT_SKILLS"]["phase_" .. max_phase][profession_name]["spec_0"])
            for _, s in pairs(specialisation_ids) do
                if MTSL_DATA["AMOUNT_SKILLS"]["phase_" .. max_phase][profession_name]["spec_" .. s] ~= nil then
                    amount = amount + tonumber(MTSL_DATA["AMOUNT_SKILLS"]["phase_" .. max_phase][profession_name]["spec_" .. s])
                end
            end
        end

        return amount
    end,

    -----------------------------------------------------------------------------------------------
    -- Get list of specialisations for a profession
    --
    -- @profession_name		String		The name of the profession
    --
    -- return				Array		List or {}
    ------------------------------------------------------------------------------------------------
    GetSpecialisationsForProfession = function(self, profession_name)
        return MTSL_DATA["specialisations"][profession_name] or {}
    end,

    -----------------------------------------------------------------------------------------------
    -- Get the name of specialisation for a profession
    --
    -- @profession_name		    String		The name of the profession
    -- @specialisation_id	    Number		The id of the specialisation
    --
    -- return				    String		Name or nil
    ------------------------------------------------------------------------------------------------
    GetNameSpecialisation = function(self, profession_name, specialisation_id)
        local spec = MTSL_TOOLS:GetItemFromArrayByKeyValue(MTSL_DATA["specialisations"][profession_name], "id", specialisation_id)
        if spec ~= nil then
            return MTSLUI_TOOLS:GetLocalisedData(spec)
        end

        return ""
    end,

    -----------------------------------------------------------------------------------------------
    -- Get the name of the profession based on a skill
    --
    -- @skill               Object      The skill for which we search the profession
    --
    -- return				String      The name of the profession
    ------------------------------------------------------------------------------------------------
    GetProfessionNameBySkill = function(self, skill)
        local profession_name = ""
        -- loop each profession until we find it
        for k, v in pairs(MTSL_DATA["professions"]) do
            -- loop each skill for this profession and compare to skill we seek
            local skills = self:GetAllSkillsAndLevelsForProfession(k)
            local s = 1
            while profession_name == "" and skills[s] do
                if skills[s].id == skill.id then
                    profession_name = k
                end
                -- next skill
                s = s + 1
            end
        end

        return profession_name
    end,

    GetEnglishProfessionNameFromLocalisedName = function(self, profession_name)
        local prof_name_eng = nil

        for k, v in pairs(MTSL_DATA["professions"]) do
            if v["name"][MTSLUI_CURRENT_LANGUAGE] == profession_name then
                prof_name_eng = k
            end
        end

        return prof_name_eng
    end,

    GetLocalisedProfessionNameFromEnglishName = function(self, profession_name)
        return MTSL_DATA["professions"][profession_name]["name"][MTSLUI_CURRENT_LANGUAGE]
    end,

    -----------------------------------------------------------------------------------------------
    -- Checks if a profession has a real tradeskill/craftframe or not
    --
    -- @profession_name     String      The name of the profession
    --
    -- return				Boolean     Flag for being frameless or not
    ------------------------------------------------------------------------------------------------
    IsFramelessProfession = function(self, profession_name)
        local frameless = false

        if profession_name == "Fishing" or
                profession_name == "Skinning" or
                profession_name == "Herbalism" then
            frameless = true
        end

        return frameless
    end,

    -----------------------------------------------------------------------------------------------
    -- Checks if a profession is secondary or not
    --
    -- @profession_name     String      The name of the profession
    --
    -- return				Boolean     Flag for being secondary or not
    ------------------------------------------------------------------------------------------------
    IsSecondaryProfession = function(self, profession_name)
        local secondary = false

        if profession_name == "Cooking" or
                profession_name == "First Aid" or
                profession_name == "Fishing" then
            secondary = true
        end

        return secondary
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets a list of auto learned skills for a profession
    --
    -- @profession_name     String      The name of the profession
    --
    -- return				Array       The list of auto learned skills (id)
    ------------------------------------------------------------------------------------------------
    GetAutoLearnedSkillsForProfession = function(self, profession_name)
        local auto_learned = {}

        -- Make sure the profession has skills (herb/skin/fish do not)
        if MTSL_DATA["skills"][profession_name] ~= nil then
            for _, v in pairs(MTSL_DATA["skills"][profession_name]) do
                if v.special_action and v.special_action == "auto learned" then
                    table.insert(auto_learned, v.id)
                end
            end
        end

        return auto_learned
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets a list of auto learned skills for a profession
    --
    -- @profession_name     String      The name of the profession
    --
    -- return				Array       The list of auto learned skills (id)
    ------------------------------------------------------------------------------------------------
    GetAutoLearnedLevelForProfession = function(self, profession_name)
        local auto_learned_level = nil

        if not MTSL_DATA["levels"][profession_name] then
            print(profession_name)
        else
            for _, v in pairs(MTSL_DATA["levels"][profession_name]) do
                if v.rank == 1 then
                    auto_learned_level = v.id
                end
            end
        end
        return auto_learned_level
    end,
}