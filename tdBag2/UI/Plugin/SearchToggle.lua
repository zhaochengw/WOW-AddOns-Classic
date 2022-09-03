-- SearchToggle.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/28/2019, 1:35:39 AM
--
---@type ns
local ns = select(2, ...)
local L = ns.L

local GameTooltip = GameTooltip

local ipairs = ipairs
local tinsert, tremove = table.insert, table.remove
local format = string.format
local tContains = tContains

local ADD = ADD
local DELETE = DELETE
local SEARCH = SEARCH

---@class UI.SearchToggle: UI.MenuButton
local SearchToggle = ns.Addon:NewClass('UI.SearchToggle', ns.UI.MenuButton)

function SearchToggle:Constructor(_, meta)
    ---@type FrameMeta
    self.meta = meta
    self:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', GameTooltip_Hide)
    self:SetScript('OnShow', self.OnShow)
end

function SearchToggle:OnShow()
    self:RegisterEvent('SEARCH_CHANGED', 'CloseMenu')
end

function SearchToggle:OnClick(button)
    if button == 'LeftButton' then
        self.meta.frame:ToggleSearchBoxFocus()
        ns.PlayToggleSound(1)
    else
        self:ToggleMenu()
    end
end

function SearchToggle:OnEnter()
    ns.AnchorTooltip(self)
    GameTooltip:SetText(SEARCH)
    GameTooltip:AddLine(ns.LeftButtonTip(L.TOOLTIP_SEARCH_TOGGLE))
    GameTooltip:AddLine(ns.RightButtonTip(L.TOOLTIP_SEARCH_RECORDS))
    GameTooltip:Show()
end

function SearchToggle:CreateMenu()
    local result = {}
    local searches = self.meta.sets.searches

    local text = ns.Addon:GetSearch()
    if text and text ~= '' and not tContains(searches, text) then
        tinsert(result, {
            text = format('%s |cff00ffff%s|r', ADD, text),
            notCheckable = true,
            func = function()
                tinsert(searches, text)
            end,
        })
        tinsert(result, self.SEPARATOR)
    end

    if #searches == 0 then
        tinsert(result, {text = L['No record'], disabled = true, notCheckable = true})
    else
        for i, item in ipairs(searches) do
            tinsert(result, {
                text = item,
                func = function()
                    ns.Addon:SetSearch(item)
                end,
                hasArrow = true,
                checked = text == item,
                menuList = {
                    {
                        text = DELETE,
                        notCheckable = true,
                        func = function()
                            tremove(searches, i)
                            self:CloseMenu()
                        end,
                    },
                },
            })
        end
    end

    tinsert(result, self.SEPARATOR)
    tinsert(result, {
        text = L['Global search'],
        notCheckable = true,
        func = function()
            ns.Addon:ToggleFrame(ns.BAG_ID.SEARCH, true)
        end,
    })

    return result
end
