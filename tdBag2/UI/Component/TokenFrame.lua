-- TokenFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 11/29/2019, 11:10:36 AM
local ipairs, select = ipairs, select
local tinsert, tremove = table.insert, table.remove

local GetItemIcon = GetItemIcon
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local GetCursorInfo = GetCursorInfo
local ClearCursor = ClearCursor
local CloseDropDownMenus = CloseDropDownMenus

local GameTooltip = GameTooltip

---@type ns
local ns = select(2, ...)

local L = ns.L
local Events = ns.Events

---@class UI.TokenFrame: EventsMixin, UI.MenuButton
local TokenFrame = ns.Addon:NewClass('UI.TokenFrame', ns.UI.MenuButton)
TokenFrame.PADDING = 10

function TokenFrame:Constructor(_, meta)
    ---@type FrameMeta
    self.meta = meta
    self.buttons = {}
    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnReceiveDrag', self.OnReceiveDrag)
    self:SetScript('OnSizeChanged', self.Update)
    self:Update()
end

function TokenFrame:OnShow()
    if not self.meta:IsCached() then
        self:RegisterEvent('BAG_UPDATE_DELAYED', 'Update')
    else
        self:UnregisterAllEvents()
    end
    self:RegisterEvent('WATCHED_TOKEN_CHANGED', 'Update')
    self:RegisterEvent('UPDATE_ALL', 'Update')
    -- @build>3@
    self:RegisterEvent('WATCHED_CURRENCY_CHANGED', 'Update')
    -- @end-build>3@
    self:RegisterFrameEvent('OWNER_CHANGED', 'Update')
    self:Update()
end

function TokenFrame:OnClick(clicked)
    if not self.meta:IsSelf() then
        return
    end
    if clicked == 'RightButton' then
        if #self.meta.character.watches > 0 then
            self:ToggleMenu()
        end
    else
        self:OnReceiveDrag()
    end
end

function TokenFrame:OnReceiveDrag()
    if not self.meta:IsSelf() then
        return
    end

    local cursorType, itemId = GetCursorInfo()
    if cursorType ~= 'item' then
        return
    end

    local watches = self.meta.character.watches
    for _, watch in ipairs(watches) do
        if watch.itemId == itemId then
            return
        end
    end

    tinsert(watches, {itemId = itemId})
    ClearCursor()
    Events:Fire('WATCHED_TOKEN_CHANGED')
end

function TokenFrame:GetButton(i)
    if not self.buttons[i] then
        local button = ns.UI.Token:New(self)
        if i == 1 then
            button:SetPoint('LEFT', self.PADDING, 0)
        else
            button:SetPoint('LEFT', self.buttons[i - 1], 'RIGHT', 0, 0)
        end
        self.buttons[i] = button
    end
    return self.buttons[i]
end

function TokenFrame:Update()
    local index = 0
    local width = self.PADDING * 2

    -- @build>3@
    if self.meta:IsSelf() then
        for i = 1, MAX_WATCHED_TOKENS do
            local name, count, icon, currencyId = GetBackpackCurrencyInfo(i)
            if name then
                index = index + 1

                local button = self:GetButton(index)
                button:SetCurrency(self.meta.owner, currencyId, icon, count)
                button:Show()

                width = width + button:GetWidth()
                if width > self:GetWidth() then
                    button:Hide()
                    break
                end
            end
        end

        self.currencyCount = index
    end
    -- @end-build>3@

    for _, watch in ipairs(self.meta.character.watches) do
        index = index + 1
        local button = self:GetButton(index)
        button:SetItem(self.meta.owner, watch.itemId, watch.watchAll)
        button:Show()

        width = width + button:GetWidth()

        if width > self:GetWidth() then
            button:Hide()
            break
        end
    end

    for i = index + 1, #self.buttons do
        self.buttons[i]:Hide()
    end
end

function TokenFrame:CreateMenu()
    local menu = {}
    for i, watch in ipairs(self.meta.character.watches) do
        local name, _, quality = GetItemInfo(watch.itemId)
        local icon = GetItemIcon(watch.itemId)

        menu[i] = {
            text = format('|T%s:14|t', icon) .. (name or ('item:' .. watch.itemId)),
            notCheckable = true,
            colorCode = quality and '|c' .. select(4, GetItemQualityColor(quality)) or nil,
            keepShownOnClick = true,
            hasArrow = true,
            menuList = {
                {
                    text = L.TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG,
                    isNotRadio = true,
                    checked = function()
                        return not watch.watchAll
                    end,
                    func = function()
                        watch.watchAll = not watch.watchAll
                        Events:Fire('WATCHED_TOKEN_CHANGED')
                        CloseDropDownMenus()
                    end,
                }, self.SEPARATOR, {
                    text = L['Move up'],
                    notCheckable = true,
                    disabled = i == 1,
                    func = function()
                        tinsert(self.meta.character.watches, i - 1, tremove(self.meta.character.watches, i))
                        Events:Fire('WATCHED_TOKEN_CHANGED')
                        CloseDropDownMenus()
                    end,
                }, {
                    text = L['Move down'],
                    notCheckable = true,
                    disabled = i == #self.meta.character.watches,
                    func = function()
                        tinsert(self.meta.character.watches, i + 1, tremove(self.meta.character.watches, i))
                        Events:Fire('WATCHED_TOKEN_CHANGED')
                        CloseDropDownMenus()
                    end,
                }, self.SEPARATOR, {
                    text = DELETE,
                    notCheckable = true,
                    func = function()
                        tremove(self.meta.character.watches, i)
                        Events:Fire('WATCHED_TOKEN_CHANGED')
                        CloseDropDownMenus()
                    end,
                },
            },
        }
    end
    return menu
end
