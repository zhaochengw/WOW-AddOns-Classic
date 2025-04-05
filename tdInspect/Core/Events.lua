-- Events.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 1/17/2025, 10:54:37 AM
--
---@class ns
local ns = select(2, ...)

---@class Events: AceModule, AceEvent-3.0
local Events = ns.Addon:NewModule('Events', 'AceEvent-3.0')
ns.Events = Events

local METHODS = {'Event', 'UnEvent', 'UnAllEvents'}

Events.handler = {}
Events.events = LibStub('CallbackHandler-1.0'):New(Events.handler, unpack(METHODS, 1, 3))

local isOurEvent = ns.memorize(function(key)
    return key:find('^TDINSPECT_')
end)

function Events.events:OnUsed(_, event)
    if not isOurEvent(event) then
        Events:RegisterEvent(event, 'Fire')
    end
end

function Events.events:OnUnused(_, event)
    if not isOurEvent(event) then
        Events:UnregisterEvent(event)
    end
end

function Events:Embed(target)
    for _, v in ipairs(METHODS) do
        target[v] = self.handler[v]
    end
end

function Events:Fire(event, ...)
    return self.events:Fire(event, ...)
end
