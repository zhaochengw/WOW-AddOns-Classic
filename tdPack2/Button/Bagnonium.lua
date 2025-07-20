-- Bagnonium.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/17/2025, 12:19:54 AM
--
if not Bagnonium then
    return
end

local ns = select(2, ...)
local buttons = {}

local templates = {'BagnoniumSortButtonTemplate'}

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

if Bagnonium.Frame and Bagnonium.Frame.Layout then
    local hooked = {}

    ns.override(Bagnonium.Frame, 'Layout', function(orig, frame)
        if not hooked[frame] then
            hooked[frame] = true

            if frame.id == 'inventory' or frame.id == 'bank' then
                ns.override(frame, 'GetExtraButtons', GetExtraButtons)
            end
        end

        return orig(frame)
    end)
end
