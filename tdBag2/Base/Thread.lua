-- Thread.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/15/2020, 4:41:36 PM
--
---@type ns
local ns = select(2, ...)

local coroutine = coroutine
local profilestart, profilestop
do
    local tick = 0
    function profilestart()
        tick = debugprofilestop()
    end

    function profilestop()
        local t = debugprofilestop()
        return t - tick
    end
end

---@class Thread: Object
local Thread = ns.Addon:NewClass('Thread')

local KILLED = newproxy()

function Thread:Start(func, ...)
    self.co = coroutine.create(func)
    profilestart()
    coroutine.resume(self.co, ...)
end

function Thread:Kill()
    local co = self.co
    self.co = nil
    coroutine.resume(co, KILLED)
end

function Thread:Threshold()
    if not self.co or self.co ~= coroutine.running() then
        return true
    end

    if profilestop() > 16 then
        profilestart()

        local killed = coroutine.yield()
        if killed == KILLED then
            return true
        end
    end
end

function Thread:Resume()
    coroutine.resume(self.co)
end

function Thread:IsFinished()
    return self.co and coroutine.status(self.co) == 'dead'
end

function Thread:IsDead()
    return not self.co
end
