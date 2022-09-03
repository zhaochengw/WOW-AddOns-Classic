--[[
    * Copyright (c) 2011-2020 by Adam Hellberg.
    *
    * This file is part of KillTrack.
    *
    * KillTrack is free software: you can redistribute it and/or modify
    * it under the terms of the GNU General Public License as published by
    * the Free Software Foundation, either version 3 of the License, or
    * (at your option) any later version.
    *
    * KillTrack is distributed in the hope that it will be useful,
    * but WITHOUT ANY WARRANTY; without even the implied warranty of
    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    * GNU General Public License for more details.
    *
    * You should have received a copy of the GNU General Public License
    * along with KillTrack. If not, see <http://www.gnu.org/licenses/>.
--]]

local _, KT = ...

KT.Tools = {}

local KTT = KT.Tools

------------------
-- NUMBER TOOLS --
------------------

function KTT:FormatSeconds(seconds)
    local hours = floor(seconds / 3600)
    local minutes = floor(seconds / 60) - hours * 60
    seconds = seconds - minutes * 60 - hours * 3600
    return ("%02d:%02d:%02d"):format(hours, minutes, seconds)
end

------------------
-- STRING TOOLS --
------------------

function KTT:Trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function KTT:Split(s)
    local r = {}
    local tokpat = "%S+"
    local spat = [=[^(['"])]=]
    local epat = [=[(['"])$]=]
    local escpat = [=[(\*)['"]$]=]
    local buf, quoted
    for token in string.gmatch(s, tokpat) do
        local squoted = token:match(spat)
        local equoted = token:match(epat)
        local escaped = token:match(escpat)
        if squoted and not quoted and not equoted then
            buf, quoted = token, squoted
        elseif buf and equoted == quoted and #escaped % 2 == 0 then
            token, buf, quoted = buf .. " "  .. token, nil, nil
        elseif buf then
            buf = buf .. " " .. token
        end
        if not buf then
            r[#r + 1] = token:gsub(spat, ""):gsub(epat, ""):gsub([[\(.)]], "%1")
        end
    end
    if buf then
        r[#r + 1] = buf
    end
    return r
end

-----------------
-- TABLE TOOLS --
-----------------

function KTT:InTable(tbl, val)
    for _,v in pairs(tbl) do
        if v == val then return true end
    end
    return false
end

function KTT:TableCopy(tbl, cache)
    if type(tbl) ~= "table" then return tbl end
    cache = cache or {}
    if cache[tbl] then return cache[tbl] end
    local copy = {}
    cache[tbl] = copy
    for k, v in pairs(tbl) do
        copy[self:TableCopy(k, cache)] = self:TableCopy(v, cache)
    end
    return copy
end

function KTT:TableLength(table)
    local count = 0
    for _, _ in pairs(table) do
        count = count + 1
    end
    return count
end

--------------------
-- DATETIME TOOLS --
--------------------

function KTT:FormatDateTime(timestamp, format)
    timestamp = timestamp or GetServerTime()
    format = format or KT.Global.DATETIME_FORMAT or KT.Defaults.DateTimeFormat
    return date(format, timestamp)
end

-----------------
-- OTHER TOOLS --
-----------------

function KTT:GUIDToID(guid)
    if not guid then return nil end
    local id = guid:match("^%w+%-0%-%d+%-%d+%-%d+%-(%d+)%-[A-Z%d]+$")
    return tonumber(id)
end
