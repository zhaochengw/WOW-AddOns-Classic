-- SearchBox.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/22/2019, 4:02:14 PM
--
---@type ns
local ns = select(2, ...)
local Addon = ns.Addon

---@class UI.SearchBox: EventsMixin, Object, SearchBoxTemplate
local SearchBox = Addon:NewClass('UI.SearchBox', 'EditBox')

function SearchBox:Constructor(_, meta)
    self.meta = meta
    self.Instructions:SetWordWrap(false)
    self:HookScript('OnTextChanged', self.OnTextChanged)
    self:HookScript('OnEditFocusLost', self.ClearFocus)
    self:SetScript('OnEscapePressed', self.OnEscapePressed)
    self:SetScript('OnEnterPressed', self.ClearFocus)
    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.UnregisterAllEvents)
    self:UpdateText()
end

function SearchBox:OnShow()
    self:RegisterEvent('SEARCH_CHANGED', 'UpdateText')
    self:UpdateText()
end

function SearchBox:OnTextChanged()
    if self:IsInIMECompositionMode() then
        return
    end
    self:SetSearch(self:GetText():lower())
end

function SearchBox:OnEscapePressed()
    self:ClearFocus()
    self:SetText('')
    self:SetSearch(nil)
end

function SearchBox:UpdateText()
    local text = Addon:GetSearch()
    if text ~= self:GetText() then
        self:SetText(text or '')
    end
end

function SearchBox:SetSearch(text)
    return Addon:SetSearch(text)
end
