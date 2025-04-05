-- Bagnon.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 7:37:46 PM
if not Bagnon then
    return
end

local ns = select(2, ...)
local buttons = {}

local function CreateButton(frame, isBank)
    local button = CreateFrame('Button', nil, frame, 'BagnonMenuButtonTemplate')
    button.Icon:SetTexture(ns.ICON)
    ns.SetupButton(button, isBank)
    buttons[frame] = button
    return buttons[frame]
end


local function GetExtraButtons(orig,frame)
    local buttons = orig(frame)
    if frame.id == 'inventory' or frame.id == 'bank' then
        tinsert(buttons, buttons[frame] or CreateButton(frame, frame.id == 'bank'))
    end
    return buttons
end

ns.override(Bagnon.Inventory, 'GetExtraButtons', GetExtraButtons)
ns.override(Bagnon.Bank, 'GetExtraButtons', GetExtraButtons)
