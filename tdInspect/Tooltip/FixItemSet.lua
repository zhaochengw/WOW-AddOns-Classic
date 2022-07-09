-- FixItemSet.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2022/6/23 17:42:48
--
---@class ns
local ns = select(2, ...)

local ITEM_SET_BONUS_GRAY_P = '^' .. ITEM_SET_BONUS_GRAY:gsub('%%s', '(.+)'):gsub('%(%%d%)', '%%((%%d+)%%)') .. '$'
local ITEM_SET_BONUS_P = '^' .. format(ITEM_SET_BONUS, '(.+)')

local function MatchBonus(text)
    local count, summary = text:match(ITEM_SET_BONUS_GRAY_P)
    if count then
        return summary, tonumber(count)
    end
    return text:match(ITEM_SET_BONUS_P)
end

---@param tip LibGameTooltip
function ns.FixItemSets(tip, id)
    local setId = select(16, GetItemInfo(id))
    if not setId then
        return
    end

    local setName = GetItemSetInfo(setId)
    if not setName then
        return
    end

    local equippedCount, itemNames, overrideNames = ns.Inspect:GetEquippedSetItems(setId)
    local setNameLinePattern = '^(' .. setName .. '.+)(%d+)/(%d+)(.+)$'

    local setLine
    local firstBonusLine
    local inSetLine = true
    local bonus = ns.ItemSets[setId].bouns

    for i = 2, tip:NumLines() do
        local textLeft = tip:GetFontStringLeft(i)
        local text = textLeft:GetText()

        if not setLine then
            local prefix, n, maxCount, suffix = text:match(setNameLinePattern)
            if prefix then
                setLine = i
                textLeft:SetText(prefix .. equippedCount .. '/' .. maxCount .. suffix)
            end
        elseif inSetLine then
            local line = text:trim()

            if line == '' then
                inSetLine = false
            else
                local n = itemNames[line]
                if n and n > 0 then
                    local overrideName = overrideNames[line]
                    if overrideName and line ~= overrideName then
                        textLeft:SetText(text:sub(1, #text - #line) .. overrideName)
                    end

                    textLeft:SetTextColor(1, 1, 0.6)
                    itemNames[line] = n > 1 and n - 1 or nil
                else
                    textLeft:SetTextColor(0.5, 0.5, 0.5)
                end
            end
        else
            local summary, count = MatchBonus(text)
            if summary then
                if not firstBonusLine then
                    firstBonusLine = i
                end

                if not count and firstBonusLine then
                    count = bonus[i - firstBonusLine + 1]
                end

                if count then
                    if equippedCount >= count then
                        textLeft:SetText(ITEM_SET_BONUS:format(summary))
                        textLeft:SetTextColor(0.1, 1, 0.1)
                    else
                        textLeft:SetText(ITEM_SET_BONUS_GRAY:format(count, summary))
                        textLeft:SetTextColor(0.5, 0.5, 0.5)
                    end
                end
            end
        end
    end
end
