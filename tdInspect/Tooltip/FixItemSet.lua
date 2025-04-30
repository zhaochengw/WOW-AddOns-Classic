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

    local equippedCount, equippedSetItems = ns.Inspect:GetEquippedSetItems(setId)
    local setNameLinePattern = '^(' .. setName .. '.+)(%d+)/(%d+)(.+)$'

    local setLine
    local firstBonusLine
    local bonus = ns.ItemSets[setId].bouns
    local slots = ns.ItemSets[setId].slots
    local setLineFinished = false

    for i = 2, tip:NumLines() do
        local textLeft = tip:GetFontStringLeft(i)
        local text = textLeft:GetText()
        if text and text:trim() ~= '' then
            if not setLine then
                local prefix, n, maxCount, suffix = text:match(setNameLinePattern)
                if prefix then
                    setLine = i
                    textLeft:SetText(prefix .. equippedCount .. '/' .. maxCount .. suffix)
                end
            elseif setLine and not setLineFinished then
                local line = text:trim()
                local setSlotIndex = i - setLine
                local slotItem = slots[setSlotIndex]

                if not slotItem or line == '' then
                    setLineFinished = true
                else
                    local item = equippedSetItems[slotItem.slot]
                    local hasItem = item
                    if not item then
                        item = slotItem.itemId
                    end

                    local name = GetItemInfo(item)
                    if name then
                        textLeft:SetText('  ' .. name)
                        if hasItem then
                            textLeft:SetTextColor(1, 1, 0.6)
                        else
                            textLeft:SetTextColor(0.5, 0.5, 0.5)
                        end
                    end
                end
            elseif setLineFinished then
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
end
