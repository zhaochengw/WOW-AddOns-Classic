
local MAJOR, MINOR = "LibSchedule.7000", 1
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

local frame = CreateFrame("Frame", nil, UIParent)

frame.schedules, frame.timer = {}, 0

frame:SetScript("OnUpdate", function(self, elasped)
    if (self.paused) then return end
    local t = GetTime()
    local item
    for i = #self.schedules, 1, -1 do
        item = self.schedules[i]
        if (item.stopped) then
            tremove(self.schedules, i)
        elseif (t >= item.begined) then
            item.timer = item.timer + elasped
            if (item.timer >= item.elasped) then
                item.timer = 0
                if (t > item.expired) then
                    tremove(self.schedules, i)
                    item.onTimeout(item)
                elseif (item.onExecute(item)) then
                    tremove(self.schedules, i)
                end
            end
        end
    end
    if (#self.schedules == 0) then
        self.paused = true
    end
end)

local metatable = {
    identity  = '', 
    timer     = 0, 
    elasped   = 1, 
    begined   = 0, 
    expired   = 0, 
    override  = false, 
    onStart   = function(self) end, 
    onTimeout = function(self) end, 
    onExecute = function(self) return true end, 
    onRemove  = function(self) end, 
}

function lib:AddTask(item, override)
    if (override or item.override) then
        for i, v in ipairs(frame.schedules) do
            if (v.identity == item.identity) then
                v.stopped = true
            end
        end
    else
        for i, v in ipairs(frame.schedules) do
            if (v.identity == item.identity) then
                return self
            end
        end
    end
    setmetatable(item, {__index = metatable})
    item.onStart(item)
    tinsert(frame.schedules, item)
    frame.paused = false
    return self
end

function lib:RemoveTask(identity, useLike)
    for i, v in ipairs(frame.schedules) do
        if (useLike) then
            if (string.find(v.identity,identity)) then
                v.stopped = true
                v:onRemove()
            end
        elseif (v.identity == identity) then
            v.stopped = true
            v:onRemove()
        end
    end
    return self
end

function lib:AwakeTask(identity, useLike)
    for i, v in ipairs(frame.schedules) do
        if (useLike) then
            if (string.find(v.identity,identity) and not v.stopped and v.onExecute(v)) then
                v.stopped = true
            end
        elseif (v.identity == identity and not v.stopped and v.onExecute(v)) then
            v.stopped = true
        end
    end
    return self
end

function lib:SearchTask(identity, useLike)
    local identities = {}
    for i, v in ipairs(frame.schedules) do
        if (useLike) then
            if (string.find(v.identity,identity) and not v.stopped) then
                tinsert(identities, v.identity)
            end
        elseif (v.identity == identity and not v.stopped) then
            tinsert(identities, v.identity)
        end
    end
    return #identities==0 and nil or identities
end
