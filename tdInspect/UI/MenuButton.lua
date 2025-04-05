-- MenuButton.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 3/17/2025, 10:19:05 PM
--
---@type ns
local ns = select(2, ...)

---@class UI.MenuButton : Button
---@field DropMenu Frame
local MenuButton = ns.Addon:NewClass('UI.MenuButton', 'Button')

function MenuButton:Constructor(_, createMenu)
    self:SetScript('OnHide', self.OnHide)
    self.CreateMenu = createMenu
end

function MenuButton:OnHide()
    self:CloseMenu()
    self:UnregisterAllEvents()
end

function MenuButton:ToggleMenu()
    if self:IsMenuOpened() then
        CloseDropDownMenus()
        PlaySound(851) -- IG_MAINMENU_CLOSE
    else
        MenuButton.LastDropdown = self
        CloseDropDownMenus()
        ToggleDropDownMenu(1, nil, self:GetDropMenu(), self, 0, 0, self:CreateMenu())
        self:OnMenuOpened()
        PlaySound(850) -- IG_MAINMENU_OPEN
    end
end

function MenuButton:CloseMenu()
    if self:IsMenuOpened() then
        CloseDropDownMenus(1)
    end
end

function MenuButton:IsMenuOpened()
    return self.DropMenu and self.LastDropdown == self and UIDROPDOWNMENU_OPEN_MENU == self.DropMenu and
               DropDownList1:IsShown()
end

local function Initialize(_, level, menuList)
    for i, v in ipairs(menuList) do
        if v.isSeparator then
            UIDropDownMenu_AddSeparator(level)
        elseif v.text then
            v.index = i;
            UIDropDownMenu_AddButton(v, level);
        end
    end
end

function MenuButton:GetDropMenu()
    if not self.DropMenu then
        local frame = CreateFrame('Frame', 'tdInspectDropdown', UIParent, 'UIDropDownMenuTemplate')
        frame.displayMode = 'MENU'
        frame.initialize = Initialize
        frame.onHide = function(id)
            if id <= 2 then
                self:OnMenuClosed()
            end
        end

        self:GetType().DropMenu = frame
    end
    return self.DropMenu
end

function MenuButton:CreateEnterBlocker()
    local EnterBlocker = CreateFrame('Frame', nil, self)
    EnterBlocker:Hide()
    EnterBlocker:SetScript('OnEnter', function(self)
        return self:GetParent():LockHighlight()
    end)
    EnterBlocker:SetScript('OnLeave', function(self)
        return self:GetParent():UnlockHighlight()
    end)
    EnterBlocker:SetMouseClickEnabled(false)
    MenuButton.EnterBlocker = EnterBlocker
    return EnterBlocker
end

function MenuButton:OnMenuOpened()
    local EnterBlocker = self.EnterBlocker or self:CreateEnterBlocker()
    EnterBlocker:SetParent(self)
    EnterBlocker:SetAllPoints(true)
    EnterBlocker:SetFrameLevel(self:GetFrameLevel() + 10)
    EnterBlocker:Show()
end

function MenuButton:OnMenuClosed()
    if self.EnterBlocker then
        self.EnterBlocker:Hide()
    end
end
