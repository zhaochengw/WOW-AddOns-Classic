-- Menu.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/17/2020, 11:41:32 PM
--
---@type ns
local ns = select(2, ...)

local _G = _G
local select = select

local CloseDropDownMenus = CloseDropDownMenus
local UnitIsUnit = UnitIsUnit
local Ambiguate = Ambiguate

local WHISPER = WHISPER
local BUTTON_HEIGHT = UIDROPDOWNMENU_BUTTON_HEIGHT

local FriendsDropDown = FriendsDropDown

--[=[@build<3@
UnitPopupButtons.INSPECT.dist = nil
--@end-build<3@]=]

local function GetDropdownUnit()
    local menu = UIDROPDOWNMENU_INIT_MENU
    if not menu or not (menu == FriendsDropDown or menu == PVPDropDown) then
        return
    end

    if menu.which == 'FRIEND' then
        return nil, ns.GetFullName(menu.chatTarget)
    elseif menu.which == 'RAID' or menu.which == 'TEAM' then
        if menu.unit then
            return menu.unit, ns.UnitName(menu.unit)
        elseif menu.name then
            return nil, ns.GetFullName(menu.name)
        end
    end
end

---@type Button
local InspectButton = CreateFrame('Button', nil, UIParent)
do
    local ht = InspectButton:CreateTexture(nil, 'BACKGROUND')
    ht:SetAllPoints(true)
    ht:SetTexture([[Interface\QuestFrame\UI-QuestTitleHighlight]])
    ht:SetBlendMode('ADD')

    InspectButton:Hide()
    InspectButton:SetHeight(BUTTON_HEIGHT)
    InspectButton:SetHighlightTexture(ht)
    InspectButton:SetNormalFontObject('GameFontHighlightSmallLeft')
    InspectButton:SetText(INSPECT)

    InspectButton:SetScript('OnHide', InspectButton.Hide)
    InspectButton:SetScript('OnClick', function()
        local unit, name = GetDropdownUnit()
        if unit or name then
            ns.Inspect:Query(unit, name)
        end
        CloseDropDownMenus()
    end)
    InspectButton:SetScript('OnEnter', function(self)
        local parent = self:GetParent()
        if parent then
            parent.isCounting = nil
        end
    end)
end

local function FindDropdownItem(dropdown, text)
    local name = dropdown:GetName()
    for i = 1, UIDROPDOWNMENU_MAXBUTTONS do
        local dropdownItem = _G[name .. 'Button' .. i]
        if dropdownItem:IsShown() and dropdownItem:GetText() == text then
            return i, dropdownItem
        end
    end
end

local function FillToDropdownAfter(button, text, level)
    local dropdownName = 'DropDownList' .. level
    local dropdown = _G[dropdownName]
    local index, dropdownItem = FindDropdownItem(dropdown, text)
    if index then
        local x, y = select(4, dropdownItem:GetPoint())

        button:SetParent(dropdown)
        button:ClearAllPoints()
        button:SetPoint('TOPLEFT', x, y - BUTTON_HEIGHT)
        button:SetPoint('RIGHT', -x, 0)
        button:Show()

        for i = index + 1, UIDROPDOWNMENU_MAXBUTTONS do
            local dropdownItem = _G[dropdownName .. 'Button' .. i]
            if dropdownItem:IsShown() then
                local p, r, rp, x, y = dropdownItem:GetPoint(1)
                dropdownItem:SetPoint(p, r, rp, x, y - BUTTON_HEIGHT)
            else
                break
            end
        end

        dropdown:SetHeight(dropdown:GetHeight() + BUTTON_HEIGHT)
    end
end

hooksecurefunc('UnitPopup_ShowMenu', function(dropdownMenu, which, _, name)
    if not name then
        return
    end
    if UIDROPDOWNMENU_MENU_LEVEL == 1 and not UnitIsUnit('player', Ambiguate(name, 'none')) then
        if which == 'FRIEND' or which == 'TEAM' then
            FillToDropdownAfter(InspectButton, WHISPER, 1)
        elseif which == 'RAID' then
            FillToDropdownAfter(InspectButton, name, 1)
        end
    end
end)

local VALID_DROPS = {PARTY = true, PLAYER = true, RAID_PLAYER = true}

hooksecurefunc('UnitPopup_OnUpdate', function()
    local dropdown = OPEN_DROPDOWNMENUS[1]
    if not dropdown or not dropdown.unit or not VALID_DROPS[dropdown.which] then
        return
    end

    if not UnitIsConnected(dropdown.unit) then
        local i = FindDropdownItem(DropDownList1, INSPECT)
        UIDropDownMenu_DisableButton(1, i)
    end

    if UnitIsDeadOrGhost(dropdown.unit) then
        local i = FindDropdownItem(DropDownList1, INSPECT)
        UIDropDownMenu_EnableButton(1, i)
    end
end)

function InspectUnit(unit)
    return ns.Inspect:Query(unit)
end
