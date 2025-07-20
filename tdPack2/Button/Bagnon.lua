-- Bagnon.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 7:37:46 PM
--
if not Bagnon then
    return
end

local ns = select(2, ...)
local buttons = {}

local templates = {'BagnonButtonTemplate', 'BagnonMenuButtonTemplate'}

local function Create(frame)
    for _, v in ipairs(templates) do
        local ok, button = pcall(function()
            return CreateFrame('Button', nil, frame, v)
        end)
        if ok then
            return button
        end
    end
end

local function CreateButton(frame, isBank)
    local button = assert(Create(frame))
    button.Icon:SetTexture(ns.ICON)
    ns.SetupButton(button, isBank)
    buttons[frame] = button
    return buttons[frame]
end

local function GetExtraButtons(orig, frame)
    local ret = orig(frame)
    if frame.id == 'inventory' or frame.id == 'bank' then
        tinsert(ret, ret[frame] or CreateButton(frame, frame.id == 'bank'))
    end
    return ret
end

if Bagnon.Inventory and Bagnon.Bank then

    ns.override(Bagnon.Inventory, 'GetExtraButtons', GetExtraButtons)
    ns.override(Bagnon.Bank, 'GetExtraButtons', GetExtraButtons)

elseif Bagnon.Frame and Bagnon.Frame.PlaceMenuButtons then
    local hooked = {}

    ns.override(Bagnon.Frame, 'PlaceMenuButtons', function(orig, frame)
        if not hooked[frame] then
            hooked[frame] = true

            if frame.id == 'inventory' or frame.id == 'bank' then
                ns.override(frame, 'GetExtraButtons', GetExtraButtons)
            end
        end

        return orig(frame)
    end)
end
