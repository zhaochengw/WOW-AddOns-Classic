-- ComboBox.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/21/2020, 4:27:11 PM
--
---@type ns
local ns = select(2, ...)

---@type ComboBox
local ComboBox = ns.Addon:NewClass('UI.ComboBox', 'Frame')

local function ButtonOnClick(self)
    local parent = self:GetParent()
    ToggleDropDownMenu(1, nil, parent, nil, nil, nil, parent.menuList)
    PlaySound(856)
end

function ComboBox:Constructor()
    self:SetScript('OnShow', nil)
    self.Button:SetScript('OnClick', ButtonOnClick)
end

local function ItemOnClick(button, value)
    local dropdown = button.arg2
    if dropdown then
        dropdown:SetValue(value)
    end
end

local function ItemChecked(button)
    local dropdown = button.arg2
    return dropdown and dropdown.selectedValue == button.arg1
end

function ComboBox:SetItems(list)
    local menuList = {}
    for i, v in ipairs(list) do
        menuList[i] = {text = v.text, arg1 = v.value, arg2 = self, func = ItemOnClick, checked = ItemChecked}
    end

    UIDropDownMenu_Initialize(self, EasyMenu_Initialize, nil, nil, menuList)
end

function ComboBox:Refresh()
    for i, v in ipairs(self.menuList) do
        if v.arg1 == self.selectedValue then
            self.Text:SetText(v.text)
            break
        end
    end
end

function ComboBox:SetValue(value)
    if value ~= self.selectedValue then
        self.selectedName = nil
        self.selectedID = nil
        self.selectedValue = value
        self:Refresh()
        self:Fire('OnValueChanged', value)
    end
end

ComboBox.GetValue = UIDropDownMenu_GetSelectedValue

hooksecurefunc('UIDropDownMenu_SetSelectedValue', function(obj, value)
    if obj and obj.GetType and obj:GetType() == ComboBox then
        obj.selectedValue = nil
        obj:SetValue(value)
    end
end)
