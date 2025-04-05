-- RuleView.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/28/2019, 1:35:42 PM
--
---- LUA
local format = string.format
local tremove = table.remove
local type, ipairs = type, ipairs

---- WOW
local ClearCursor = ClearCursor
local CreateFrame = CreateFrame
local GetCursorInfo = GetCursorInfo

---- UI
local GameTooltip = GameTooltip
local UIParent = UIParent

---- LOCAL
local DELETE, EDIT, CANCEL = DELETE, EDIT, CANCEL

---@type string, ns
local ADDON, ns = ...
local L = ns.L
local UI = ns.UI
local Addon = ns.Addon

---@class UI.RuleView: AceEvent-3.0, UI.TreeView
local RuleView = UI:NewClass('RuleView', UI.TreeView)
LibStub('AceEvent-3.0'):Embed(RuleView)

RuleView.__treeStatus = setmetatable({}, {
    __index = function(t, k)
        t[k] = UI.TreeStatus:New()
        return t[k]
    end,
})

function RuleView:Constructor()
    self:Hide()
    self:SetItemTemplate('tdPack2RuleItemTemplate')
    self:SetCallback('OnItemFormatting', self.OnItemFormatting)
    self:SetCallback('OnItemEnter', self.OnItemEnter)
    self:SetCallback('OnItemLeave', self.OnItemLeave)
    self:SetCallback('OnItemClick', self.OnItemClick)
    self:SetCallback('OnItemRightClick', self.OnItemRightClick)
    self:SetCallback('OnCheckItemCanPutIn', self.OnCheckItemCanPutIn)
    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
end

function RuleView:Free()
    self.treeStatus = nil
    self.ruleType = nil
    self:Hide()
end

function RuleView:OnShow()
    self:RegisterEvent('CURSOR_CHANGED')
    self:RegisterEvent('GET_ITEM_INFO_RECEIVED', 'Refresh')
    self:RegisterMessage('TDPACK_PROFILE_CHANGED', 'RefreshRules')
    self:RegisterMessage('TDPACK_RULES_UPDATE')
    self:CURSOR_CHANGED()
end

function RuleView:OnHide()
    self:UnregisterAllEvents()
    self:UnregisterAllMessages()
end

function RuleView:TDPACK_RULES_UPDATE(_, ruleType)
    if ruleType == self.ruleType then
        self:RefreshRules()
    end
end

function RuleView:CURSOR_CHANGED()
    local cursorType, itemId = GetCursorInfo()
    if cursorType == 'item' then
        self:StartCursorCatching(itemId)
    else
        self:StopCursorCatching()
    end
end

function RuleView:OnCheckItemCanPutIn(_, to)
    return ns.IsAdvanceRule(to)
end

function RuleView:OnItemFormatting(button, item, depth)
    local name, icon, rule, hasChild = ns.GetRuleInfo(item)
    button.Status:SetPoint('LEFT', 5 + 20 * (depth - 1), 0)
    button.Text:SetFontObject((ns.IsAdvanceRule(item) and not rule) and 'GameFontDisable' or 'GameFontNormal')
    button.Text:SetText(format('|T%s:14|t %s', icon, name))
    button.Rule:SetText(rule or '')
    button.Status:SetShown(hasChild)
    button.Status:SetTexture(self:IsItemExpend(item) and [[Interface\Buttons\UI-MinusButton-UP]] or
                                 [[Interface\Buttons\UI-PlusButton-Up]])
end

function RuleView:OnItemClick(button)
    self:ToggleItem(button.item)
end

function RuleView:OnItemRightClick(button)
    self:ShowRuleMenu(button, button.item)
end

function RuleView:OnItemEnter(button)
    local item = button.item
    GameTooltip:SetOwner(button, 'ANCHOR_RIGHT')
    if type(item) == 'number' then
        GameTooltip:SetHyperlink('item:' .. item)
    elseif ns.IsAdvanceRule(item) then
        if item.comment then
            GameTooltip:AddLine(item.comment)
        end
        if item.rule then
            GameTooltip:AddLine(item.rule, 1, 1, 1)
        end
    end
    GameTooltip:Show()
end

function RuleView:OnItemLeave()
    GameTooltip:Hide()
end

local function Contains(tree, item)
    for i, v in ipairs(tree) do
        if v == item then
            return true
        elseif ns.IsAdvanceRule(v) then
            if v.children and Contains(v.children, item) then
                return true
            end
        end
    end
end

function RuleView:StartCursorCatching(item)
    local catcher = self.cursorCatcher or self:CreateCursorCatcher()
    local exists = Contains(self:GetItemTree(), item)
    catcher.item = item
    catcher.exists = exists
    catcher.bg:SetShown(exists)
    catcher:SetText(exists and L['Already exists'] or '')
    catcher:Show()
end

function RuleView:StopCursorCatching()
    if self.cursorCatcher then
        self.cursorCatcher:Hide()
        self:StopSorting()
    end
end

function RuleView:CreateCursorCatcher()
    local catcher = CreateFrame('Button', nil, self)
    catcher:RegisterForClicks('LeftButtonUp')
    catcher:SetAllPoints(self.mouseHolder or self)
    catcher:SetFrameLevel(self:GetFrameLevel() + 100)
    catcher:SetNormalFontObject('GameFontHighlightHuge')
    catcher.bg = catcher:CreateTexture(nil, 'BACKGROUND')
    catcher.bg:SetAllPoints(self)
    catcher.bg:SetColorTexture(0.3, 0, 0, 0.9)

    local function OnClick(catcher)
        if catcher.exists then
            return
        end
        self:CommitSorting()
        ClearCursor()
    end

    local function OnEnter(catcher)
        if not catcher.item or catcher.exists then
            return
        end
        local x, y = ns.GetCursorPosition()
        local button = self:AllocButton()

        button.parent = self:GetItemTree()
        button.index = #button.parent + 1
        button.item = catcher.item
        button:SetWidth(self:GetWidth(), self.itemHeight)
        button:SetParent(UIParent)
        button:ClearAllPoints()
        button:SetPoint('BOTTOMLEFT', x - button:GetWidth() / 2, y - button:GetHeight() / 2)

        self:OnItemFormatting(button, button.item, 1)
        self:StartSorting(button)
    end

    catcher:SetScript('OnClick', OnClick)
    catcher:SetScript('OnReceiveDrag', OnClick)
    catcher:SetScript('OnEnter', OnEnter)
    -- catcher:SetScript('OnLeave', OnLeave)
    self:SetCallback('OnSortingOut', function()
        if catcher:IsShown() then
            self:StopSorting()
        end
    end)

    self.cursorCatcher = catcher
    return catcher
end

function RuleView:ShowRuleMenu(button, item)
    local name, icon, _, hasChild = ns.GetRuleInfo(item)

    ns.ToggleMenu(button, {
        { --
            text = format('|T%s:14|t %s', icon, name),
            isTitle = true,
            notCheckable = true,
        }, {isSeparator = true}, {
            text = DELETE,
            notCheckable = true,
            func = function()
                if self.obj then
                    self.obj:Fire('OnClick', {hasChild = hasChild, parent = button.parent, index = button.index})
                end
            end,
        }, {
            text = EDIT,
            notCheckable = true,
            disabled = not ns.IsAdvanceRule(button.item),
            func = function()
                self:OpenEditor(button.item)
            end,
        }, {text = CANCEL, notCheckable = true},
    })
end

function RuleView:OpenEditor(item)
    UI.RuleEditor:Open(item, self:GetItemTree(), function()
        self:OnListChanged()
    end)
end

function RuleView:OnListChanged()
    Addon:SendMessage('TDPACK_RULES_UPDATE', self.ruleType)
end

function RuleView:SetRuleType(t)
    local ruleType = ns.SORT_TYPE[t]
    if ruleType then
        self.ruleType = ruleType
    else
        error('Unknown sorting type: ' .. t)
    end
    self:RefreshRules()
end

function RuleView:RefreshRules()
    self.treeStatus = self.__treeStatus[self.ruleType]
    self:SetItemTree(Addon:GetRules(self.ruleType))
    self:Refresh()
end

--- AceGUI

local AceGUI = LibStub('AceGUI-3.0')
local TYPE = ADDON .. 'RuleView'

local methods = {
    OnAcquire = function(self)
        self:SetHeight(290)
        self:SetFullWidth(true)
    end,

    OnRelease = function(self)
        self.frame:Free()
        if self.inject then
            self.inject:Cancel()
            self.inject = nil
        end
    end,

    OnWidthSet = function(self, width)
        self.frame.scrollChild:SetWidth(width - 18)
    end,

    OnHeightSet = function(self, height)
        self.frame.scrollChild:SetHeight(height)
    end,

    SetText = function(self, t)
        self.frame:SetRuleType(t)

        self.inject = C_Timer.NewTimer(0, function()
            self.inject = nil
            self:UpdateOptions()
        end)
    end,

    UpdateOptions = function(self)
        local option = self:GetUserData('option')
        if option then
            if not option.confirm then
                option.confirm = function(_, env)
                    if env.hasChild then
                        return L['Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?']
                    else
                        return L['Are you sure |cffff191919DELETE|r rule?']
                    end
                end
            end

            if not option.func then
                option.func = function(_, env)
                    local parent, index = env.parent, env.index
                    tremove(parent, index)
                    self.frame:OnListChanged()
                end
            end
        end
        self.frame:Refresh()
    end,
}

local function Constructor()
    local frame = ns.UI.RuleView:Bind(CreateFrame('ScrollFrame', nil, UIParent, 'tdPack2ScrollFrameTemplate'))

    local widget = { --
        frame = frame,
        type = TYPE,
    }
    for method, func in pairs(methods) do
        widget[method] = func
    end

    return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(TYPE, Constructor, 1)
