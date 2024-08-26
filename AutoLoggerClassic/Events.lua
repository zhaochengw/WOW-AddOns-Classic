local _, ns = ...

-- Variables.
local eventFrame
local hasRegistered = false
local callbacks = {}
local wowEvents, events

-- Called when any registered WoW event fires.
function ns:OnEvent(event, ...)
    wowEvents[event](self, ...)
end

-- Registers all events.
function ns:RegisterAllEvents(_eventFrame)
    if not hasRegistered then
        eventFrame = _eventFrame
        eventFrame:SetScript("OnEvent", ns.OnEvent)
        events = {}
        wowEvents = {ADDON_LOADED = ns.OnAddonLoaded, PLAYER_ENTERING_WORLD = ns.OnPlayerEnteringWorld, RAID_INSTANCE_WELCOME = ns.OnRaidInstanceWelcome}
        for event, callback in pairs(wowEvents) do
            eventFrame:RegisterEvent(event, callback)
        end
        for event, callback in pairs(events) do
            ns:RegisterEvent(event, callback)
        end
        hasRegistered = true
    end
end

-- Registers for the given WoW event.
function ns:RegisterWowEvent(event, callback)
    wowEvents[event] = callback
    eventFrame:RegisterEvent(event, callback)
end

-- Unregisters the given WoW event.
function ns:UnregisterWowEvent(event)
    eventFrame:UnregisterEvent(event)
    wowEvents[event] = nil
end

-- Register for the given event.
function ns:RegisterEvent(event, callback)
    callbacks[event] = callbacks[event] or {}
    callbacks[event][#callbacks[event] + 1] = callback
end

-- Unregister for the given event.
function ns:UnregisterEvent(event)
    callbacks[event] = nil
end

-- Call this to fire an event.
function ns:Fire(event, ...)
    if callbacks[event] and #callbacks[event] > 0 then
        for i = 1, #callbacks[event] do
            callbacks[event][i](self, ...)
        end
    end
end
