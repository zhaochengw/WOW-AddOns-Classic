local Env = select(2, ...)

-- Map stat IDs used in reforging to their localised (tooltip) strings.
---@type table<integer, {statString:string, statStringNoVar:string}>
local statIdToStrings = {
    [6] = { statString = ITEM_MOD_SPIRIT_SHORT },          -- Spirit
    [13] = { statString = ITEM_MOD_DODGE_RATING },         -- Increases your dodge rating by %s.
    [14] = { statString = ITEM_MOD_PARRY_RATING },         -- Increases your parry rating by %s.
    [31] = { statString = ITEM_MOD_HIT_RATING },           -- Improves hit rating by %s.
    [32] = { statString = ITEM_MOD_CRIT_RATING },          -- Improves critical strike rating by %s.
    [36] = { statString = ITEM_MOD_HASTE_RATING },         -- Improves haste rating by %s.
    [37] = { statString = ITEM_MOD_EXPERTISE_RATING },     -- Increases your expertise rating by %s.
    [49] = { statString = ITEM_MOD_MASTERY_RATING_SHORT }, -- Mastery
}
-- Add strings without the placeholder.
for _, v in pairs(statIdToStrings) do
    v.statStringNoVar = v.statString:format(".-")
end

-- Map localised strings to stat IDs.
local statStringToId = (function()
    ---@type table<string, integer>
    local t = {}
    for id, v in pairs(statIdToStrings) do
        t[v.statString] = id
    end
    return t
end)()

---Table of reforgeIds and the corresponding src and dest stat ID.
---@type table<integer, {srcStat:integer, destStat:integer}>
local reforges = {
    [113] = { srcStat = 6, destStat = 13 },
    [114] = { srcStat = 6, destStat = 14 },
    [115] = { srcStat = 6, destStat = 31 },
    [116] = { srcStat = 6, destStat = 32 },
    [117] = { srcStat = 6, destStat = 36 },
    [118] = { srcStat = 6, destStat = 37 },
    [119] = { srcStat = 6, destStat = 49 },
    [120] = { srcStat = 13, destStat = 6 },
    [121] = { srcStat = 13, destStat = 14 },
    [122] = { srcStat = 13, destStat = 31 },
    [123] = { srcStat = 13, destStat = 32 },
    [124] = { srcStat = 13, destStat = 36 },
    [125] = { srcStat = 13, destStat = 37 },
    [126] = { srcStat = 13, destStat = 49 },
    [127] = { srcStat = 14, destStat = 6 },
    [128] = { srcStat = 14, destStat = 13 },
    [129] = { srcStat = 14, destStat = 31 },
    [130] = { srcStat = 14, destStat = 32 },
    [131] = { srcStat = 14, destStat = 36 },
    [132] = { srcStat = 14, destStat = 37 },
    [133] = { srcStat = 14, destStat = 49 },
    [134] = { srcStat = 31, destStat = 6 },
    [135] = { srcStat = 31, destStat = 13 },
    [136] = { srcStat = 31, destStat = 14 },
    [137] = { srcStat = 31, destStat = 32 },
    [138] = { srcStat = 31, destStat = 36 },
    [139] = { srcStat = 31, destStat = 37 },
    [140] = { srcStat = 31, destStat = 49 },
    [141] = { srcStat = 32, destStat = 6 },
    [142] = { srcStat = 32, destStat = 13 },
    [143] = { srcStat = 32, destStat = 14 },
    [144] = { srcStat = 32, destStat = 31 },
    [145] = { srcStat = 32, destStat = 36 },
    [146] = { srcStat = 32, destStat = 37 },
    [147] = { srcStat = 32, destStat = 49 },
    [148] = { srcStat = 36, destStat = 6 },
    [149] = { srcStat = 36, destStat = 13 },
    [150] = { srcStat = 36, destStat = 14 },
    [151] = { srcStat = 36, destStat = 31 },
    [152] = { srcStat = 36, destStat = 32 },
    [153] = { srcStat = 36, destStat = 37 },
    [154] = { srcStat = 36, destStat = 49 },
    [155] = { srcStat = 37, destStat = 6 },
    [156] = { srcStat = 37, destStat = 13 },
    [157] = { srcStat = 37, destStat = 14 },
    [158] = { srcStat = 37, destStat = 31 },
    [159] = { srcStat = 37, destStat = 32 },
    [160] = { srcStat = 37, destStat = 36 },
    [161] = { srcStat = 37, destStat = 49 },
    [162] = { srcStat = 49, destStat = 6 },
    [163] = { srcStat = 49, destStat = 13 },
    [164] = { srcStat = 49, destStat = 14 },
    [165] = { srcStat = 49, destStat = 31 },
    [166] = { srcStat = 49, destStat = 32 },
    [167] = { srcStat = 49, destStat = 36 },
    [168] = { srcStat = 49, destStat = 37 },
}

--------------------------------------------------------
-- Item stat functions
--------------------------------------------------------

---Get table of stat IDs used in reforging and their default value for an item.
---@param unit string
---@param itemSlot integer
---@return table<integer, number>
local function GetItemDefaultStats(unit, itemSlot)
    local itemLink = GetInventoryItemLink(unit, itemSlot)
    local stats = GetItemStats(itemLink)
    local defaultStats = {}
    for statStringConstName, value in pairs(stats) do
        local statString = _G[statStringConstName]
        local statId = statStringToId[statString]
        if statId then
            defaultStats[statId] = value
        end
    end
    return defaultStats
end

---Get the text of an inventory item's enchant as it will appear in the tooltip
---@param unit string
---@param itemSlot integer
---@return string
local function GetItemEnchantText(unit, itemSlot)
    local itemLink = GetInventoryItemLink(unit, itemSlot)
    local enchantID = itemLink:match("item:.-:(.-):")
    return Env.GetEnchantText(enchantID)
end

local socketBonus = "^" .. ITEM_SOCKET_BONUS:format("")

---Parse stats used in reforging and their current value from item tooltip.
---@param unit string
---@param itemSlot integer
---@param enchantText string
---@return table<integer, number>
local function GetItemCurrentStats(unit, itemSlot, enchantText)
    local currentStats = {}

    WSEScanningTooltip:ClearLines()
    WSEScanningTooltip:SetInventoryItem(unit, itemSlot)
    local regions = { WSEScanningTooltip:GetRegions() }

    for i = 1, #regions do
        local region = regions[i]
        if region and region:GetObjectType() == "FontString" then
            local text = region:GetText()
            if text and text ~= enchantText and not text:find(socketBonus) and not text:find("^|") then
                for statId, v in pairs(statIdToStrings) do
                    local pos = text:find(v.statStringNoVar)
                    if pos then
                        local value = text:match("%d+")
                        currentStats[statId] = tonumber(value)
                    end
                end
            end
        end
    end

    return currentStats
end

--------------------------------------------------------
-- Reforge detection
--------------------------------------------------------

---Attempt to get reforged src and dest stat.
---@param unit string
---@param itemSlot integer
local function GetItemReforgedStats(unit, itemSlot)
    local enchantText = GetItemEnchantText(unit, itemSlot)
    local statsCurrent = GetItemCurrentStats(unit, itemSlot, enchantText)
    local statsDefault = GetItemDefaultStats(unit, itemSlot)

    -- Find src stat, i.e. the reduced default stat
    for statId, baseValue in pairs(statsDefault) do
        local currentValue = statsCurrent[statId]
        if currentValue and currentValue < baseValue then
            -- Find dest stat, i.e. the stat that does not exist by default
            for destStatId in pairs(statsCurrent) do
                if not statsDefault[destStatId] then
                    return statId, destStatId
                end
            end
            break
        end
    end
end

---Try to get the reforge ID for an item.
---@param unit string
---@param itemSlot integer
---@return integer|nil
function Env.GetReforgeId(unit, itemSlot)
    local srcId, destId = GetItemReforgedStats(unit, itemSlot)
    if srcId and destId then
        for reforgeId, v in pairs(reforges) do
            if v.srcStat == srcId and v.destStat == destId then
                return reforgeId
            end
        end
    end
end
