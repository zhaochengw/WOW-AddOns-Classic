-- Thread.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/15/2020, 4:41:36 PM
---@type ns
local ns = select(2, ...)

local coroutine = coroutine
local debugprofilestart = debugprofilestart
local debugprofilestop = debugprofilestop

---@type tdBag2Thread
local Thread = ns.Addon:NewClass('Thread')

local KILLED = newproxy()

function Thread:Start(func, ...)
    self.co = coroutine.create(func)
    debugprofilestart()
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

    if debugprofilestop() > 16 then
        debugprofilestart()

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
