local Env = select(2, ...)

---Create glyphs table.
---@return table
function Env.CreateGlyphEntry(isInspect)
    local unit = isInspect and Env.inspectUnit or "player"
    local numGlyphSockets = GetNumGlyphSockets();
    local glyphs = {
        prime = {},
        major = {},
        minor = {},
    }
    
    if Env.IS_CLASSIC_WRATH then
        for t = 1, numGlyphSockets do
            local enabled, glyphType, glyphSpellID = GetGlyphSocketInfo(t)
            if enabled and glyphSpellID then
                local glyphtable = glyphType == 1 and glyphs.major or glyphs.minor
                table.insert(glyphtable, { spellID = glyphSpellID })
            end
        end
        return glyphs
    elseif (Env.IS_CLASSIC_CATA or Env.IS_CLASSIC_MISTS) then
        local activeSpecGroup = C_SpecializationInfo.GetActiveSpecGroup(isInspect)
        for t = 1, numGlyphSockets do
            local enabled, glyphType, glyphTooltipIndex, glyphID = GetGlyphSocketInfo(t, activeSpecGroup, isInspect, unit)
            if enabled and glyphType and glyphID then
                local glyphtable = glyphType == 1 and glyphs.major or glyphType == 2 and glyphs.minor or glyphs.prime
                table.insert(glyphtable, { spellID = glyphID })
            end
        end
    end
    -- hack? unsure.. seems normal to me, prime shouldn't be shown in the dat if its mists!
    if(Env.IS_CLASSIC_MISTS) then glyphs.prime = nil end 
    return glyphs

end

Env.profInspectTable = Env.profInspectTable or {}
function Env.AddInspectedProfessions(name, entry)
    Env.profInspectTable[name] = entry
end

---Create professions table.
---@param isInspect boolean
function Env.CreateProfessionEntry(isInspect)
    if isInspect then
        local unit = Env.inspectUnit
        return Env.profInspectTable[UnitName(unit)] or {}
    end
    local professionNames = Env.professionNames
    local professions = {}

    for i = 1, GetNumSkillLines() do
        local name, _, _, skillLevel = GetSkillLineInfo(i)
        if professionNames[name] then
            table.insert(professions, {
                name = professionNames[name].engName,
                level = skillLevel,
            })
        end
    end

    return professions
end

---Create a string in the format "000..000-000..000-000..000". Used for Pre-Mists classic
---@return string
function Env.CreateTalentString()
    local GetTalentRank = Env.GetTalentRankOrdered
    local GetNumTalents = Env.GetNumTalentsFixed
    local tabs = {}
    for tab = 1, GetNumTalentTabs() do
        local talents = {}
        for i = 1, GetNumTalents(tab) do
            local currRank = GetTalentRank(tab, i)
            table.insert(talents, tostring(currRank))
        end
        table.insert(tabs, table.concat(talents))
    end
    return table.concat(tabs, "-")
end

---Create a string in the format "000000". Used for Mists classic
---@return string
function Env.CreateMistsTalentString(isInspect)
    local unit = isInspect and Env.inspectUnit or "player"
    local GetTalentInfo = C_SpecializationInfo.GetTalentInfo
    local activeSpecGroup = C_SpecializationInfo.GetActiveSpecGroup(isInspect)
    local talents = {}
    for row = 1, MAX_NUM_TALENT_TIERS do
        local found = false
        for column = 1, 3 do
            local talentInfo = GetTalentInfo({
                isInspect = isInspect,
                target = unit,
                groupIndex = activeSpecGroup,
                tier = row,
                column = column,
            })
            if talentInfo.selected then
                found = true
                table.insert(talents, tostring(column))
                break
            end
        end
        if not found then
            table.insert(talents, tostring(0))
        end
    end
    return table.concat(talents)
end
