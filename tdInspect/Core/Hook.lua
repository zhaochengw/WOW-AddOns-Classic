-- Hook-Vanilla.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 11/27/2024, 11:08:24 AM
--
---@type ns
local ns = select(2, ...)

function InspectUnit(unit)
    return ns.Inspect:Query(unit)
end

local function HookSetupMenu(_, root)
    local name = root.contextData and (root.contextData.chatTarget or root.contextData.name)
    if name then
        root:CreateDivider()
        root:CreateTitle('tdInspect')
        root:CreateButton(INSPECT, function()
            ns.Inspect:Query(nil, name)
        end)
    end
end

Menu.ModifyMenu('MENU_UNIT_FRIEND', HookSetupMenu)
Menu.ModifyMenu('MENU_UNIT_RAID', HookSetupMenu)
Menu.ModifyMenu('MENU_UNIT_COMMUNITIES_GUILD_MEMBER', HookSetupMenu)
