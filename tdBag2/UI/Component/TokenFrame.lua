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

---@type tdBag2TokenFrame
local TokenFrame = ns.Addon:NewClass('UI.TokenFrame', ns.UI.MenuButton)
TokenFrame.SPACING = 5
TokenFrame.PADDING = 10

function TokenFrame:Constructor(_, meta)
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
    self:RegisterFrameEvent('OWNER_CHANGED', 'Update')
    self:Update()
end

function TokenFrame:OnClick(clicked)
    if not self.meta:IsSelf() then
        return
    end
    if clicked == 'RightButton' then
        self:ToggleMenu()
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
            button:SetPoint('LEFT', 10, 0)
        else
            button:SetPoint('LEFT', self.buttons[i - 1], 'RIGHT', 5, 0)
        end
        self.buttons[i] = button
    end
    return self.buttons[i]
end

function TokenFrame:Update()
    local index = 0
    local width = self.PADDING * 2
    for _, watch in ipairs(self.meta.character.watches) do
        index = index + 1
        local button = self:GetButton(index)
        button:SetItem(self.meta.owner, watch.itemId, watch.watchAll)
        button:Show()

        width = width + button:GetWidth() + self.SPACING

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
            text = format('|T%s:14|t', icon) .. (name or 'item:' .. watch.itemId),
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
