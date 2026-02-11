local Env = select(2, ...)

-- Borrowed from rating buster!!
-- As of Classic Patch 3.4.0, GetTalentInfo indices no longer correlate
-- to their positions in the tree. Building a talent cache ordered by
-- tier then column allows us to replicate the previous behavior.
local orderedTalentCache = {}
do
    local f = CreateFrame("Frame")
    f:RegisterEvent("SPELLS_CHANGED")
    f:SetScript("OnEvent", function()
        local temp = {}
        for tab = 1, GetNumTalentTabs() do
            temp[tab] = {}
            local products = {}
            for i = 1, GetNumTalents(tab) do
                local name, _, tier, column, _, _, _, avail, _ = GetTalentInfo(tab, i)
                if avail then -- sometimes indices are empty ...
                    local product = (tier - 1) * 4 + column
                    temp[tab][product] = i
                    table.insert(products, product)
                end
            end

            table.sort(products)

            orderedTalentCache[tab] = {}
            local j = 1
            for _, product in ipairs(products) do
                if product then
                    orderedTalentCache[tab][j] = temp[tab][product]
                    j = j + 1
                end
            end
        end
        f:UnregisterEvent("SPELLS_CHANGED")
    end)
end

---Get current talent rank, treating talents sequentially ordered.
---@param tab integer The tree numer. 1-3
---@param num integer The talent index, counted from left to right, line by line.
---@return integer currentRank
function Env.GetTalentRankOrdered(tab, num)
    return select(5, GetTalentInfo(tab, orderedTalentCache[tab][num]))
end

function Env.GetNumTalentsFixed(tab)
    return #orderedTalentCache[tab]
end

-- table extension contains
function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

---Return the index of the biggest value in a numerically keyed table of numbers.
---@param table number[]
function Env.TableMaxValIndex(table)
    local idxMax = 1
    for i = 2, #table do
        if table[i] > table[idxMax] then
            idxMax = i
        end
    end
    return idxMax
end
