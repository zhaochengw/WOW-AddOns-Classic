-- GlobalSearchBox.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/11/2020, 2:38:56 PM
--
---@type ns
local ns = select(2, ...)

local GlobalSearch = ns.GlobalSearch

---@class UI.GlobalSearchBox: Object, EditBox, SearchBoxTemplate
local GlobalSearchBox = ns.Addon:NewClass('UI.GlobalSearchBox', 'EditBox')

function GlobalSearchBox:Constructor()
    self.Instructions:SetWordWrap(false)
    self:HookScript('OnTextChanged', self.OnTextChanged)
    self:HookScript('OnEditFocusLost', self.ClearFocus)
    self:SetScript('OnEscapePressed', self.ClearFocus)
    self:SetScript('OnEnterPressed', self.ClearFocus)
    self:SetScript('OnShow', self.SetFocus)
end

function GlobalSearchBox:OnTextChanged()
    if self:IsInIMECompositionMode() then
        return
    end
    self:SetSearch(self:GetText():lower())
end

function GlobalSearchBox:SetSearch(text)
    return GlobalSearch:Search(text)
end
