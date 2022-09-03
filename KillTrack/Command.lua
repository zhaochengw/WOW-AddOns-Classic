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

KT.Command = {
    Slash = {
        "killtrack",
        "kt"
    },
    Commands = {}
}

local C = KT.Command
local KTT = KT.Tools

-- Argument #1 (command) can be either string or a table.
function C:Register(command, func)
    if type(command) == "string" then
        command = {command}
    end
    for _,v in pairs(command) do
        if not self:HasCommand(v) then
            if v ~= "__DEFAULT__" then v = v:lower() end
            self.Commands[v] = func
        end
    end
end

function C:HasCommand(command)
    for k,_ in pairs(self.Commands) do
        if k == command then return true end
    end
    return false
end

function C:GetCommand(command)
    local cmd = self.Commands[command]
    if cmd then return cmd else return self.Commands["__DEFAULT__"] end
end

function C:HandleCommand(command, args)
    local cmd = self:GetCommand(command)
    if cmd then
        cmd(args)
    else
        KT:Msg(("%q is not a valid command."):format(command))
    end
end

C:Register("__DEFAULT__", function()
    KT:Msg("/kt loadmessage - Toggles showing a message when AddOn loads.")
    KT:Msg("/kt target - Display number of kills on target mob.")
    KT:Msg("/kt lookup <name> - Display number of kills on <name>, <name> can also be NPC ID.")
    KT:Msg("/kt print - Toggle printing kill updates to chat.")
    KT:Msg("/kt list - Display a list of all mobs entries.")
    KT:Msg("/kt set <id> <name> <global> <char> - Set kill counts for a mob")
    KT:Msg("/kt delete <id> - Delete entry with NPC id <id>.")
    KT:Msg("/kt purge [threshold] - Open dialog to purge entries, specifiying a threshold here is optional.")
    KT:Msg("/kt reset - Clear the mob database.")
    KT:Msg("/kt time - Track kills within specified time.")
    KT:Msg("/kt immediate - Track kills made from this point on.")
    KT:Msg("/kt threshold <threshold> - Set threshold for kill record notices to show.")
    KT:Msg("/kt countmode - Toggle between counting group killing blows or your killing blows only.")
    KT:Msg("/kt minimap - Toggles the minimap icon")
    KT:Msg("/kt tooltip - Toggles showing mob data in tooltip")
    KT:Msg("/kt - Displays this help message.")
end)

C:Register({"loadmessage", "lm"}, function()
    KT:ToggleLoadMessage()
end)

C:Register({"target", "t", "tar"}, function()
    if not UnitExists("target") or UnitIsPlayer("target") then return end
    local id = KTT:GUIDToID(UnitGUID("target"))
    KT:PrintKills(id)
end)

C:Register({"print", "p"}, function()
    KT.Global.PRINTKILLS = not KT.Global.PRINTKILLS
    if KT.Global.PRINTKILLS then
        KT:Msg("Announcing kill updates.")
    else
        KT:Msg("No longer announcing kill updates.")
    end
end)

C:Register({"printnew", "pn"}, function()
    KT.Global.PRINTNEW = not KT.Global.PRINTNEW
    if KT.Global.PRINTNEW then
        KT:Msg("Announcing new mob entries")
    else
        KT:Msg("No longer announcing new mob entries")
    end
end)

C:Register({"set", "edit"}, function(args)
    local id = tonumber(args[1])
    local name = args[2]
    local global = tonumber(args[3])
    local char = tonumber(args[4])

    local err

    if not id then
        KT:Msg("Missing or invalid argument: id")
        err = true
    end

    if not name then
        KT:Msg("Missing or invalid argument: name")
        err = true
    end

    if not global then
        KT:Msg("Missing or invalid argument: global")
        err = true
    end

    if not char then
        KT:Msg("Missing or invalid argument: char")
        err = true
    end

    if err then
        KT:Msg("Usage: /kt set <id> <name> <global> <char>")
        return
    end

    KT:SetKills(id, name, global, char)
end)

C:Register({"delete", "del", "remove", "rem"}, function(args)
    if #args <= 0 then
        KT:Msg("Missing argument: id")
        return
    end
    local id = tonumber(args[1])
    if not id then
        KT:Msg("Id must be a number")
        return
    end
    if not KT.Global.MOBS[id] then
        KT:Msg(("Id %d does not exist in the database."):format(id))
        return
    end
    local name = KT.Global.MOBS[id].Name
    KT:ShowDelete(id, name)
end)

C:Register({"purge"}, function(args)
    local threshold
    if #args >= 1 then threshold = tonumber(args[1]) end
    KT:ShowPurge(threshold)
end)

C:Register({"reset", "r"}, function() KT:ShowReset() end)

C:Register({"lookup", "lo", "check"}, function(args)
    if #args <= 0 then
        KT:Msg("Missing argument: name")
        return
    end
    local name = table.concat(args, " ")
    KT:PrintKills(name)
end)

C:Register({"list", "moblist", "mobs"}, function() KT.MobList:Show() end)

C:Register({"time", "timer"}, function(args)
    if #args <= 0 then
        KT:Msg("Usage: time <seconds> [minutes] [hours]")
        KT:Msg("Usage: time [<seconds>s][<minutes>m][<hours>h]")
        return
    end

    local s, m, h

    if #args == 1 then
        if not tonumber(args[1]) then
            args[1] = args[1]:lower()
            s = args[1]:match("(%d+)s")
            m = args[1]:match("(%d+)m")
            h = args[1]:match("(%d+)h")
            if not s and not m and not h then
                KT:Msg("Invalid number format.")
                return
            end
        else
            s = tonumber(args[1])
        end
    else
        s = tonumber(args[1])
        m = tonumber(args[2])
        h = tonumber(args[3])
    end
    KT.TimerFrame:Start(s, m, h)
end)

C:Register({"immediate", "imm", "i"}, function(args)
    if #args < 1 then
        KT.Immediate:Show()
    elseif args[1]:match("^t") then
        local threshold = tonumber(args[2])
        if #args < 2 then
            KT:Msg("Usage: immediate threshold <threshold>")
            KT:Msg("E.g: /kt immediate threshold 50")
            KT:Msg("    Notice will be shown on every 50th kill when immediate frame is active")
        else
            KT:SetImmediateThreshold(threshold)
        end
    elseif args[1]:match("^f") then
        if #args < 2 then
            local current = KT.Global.IMMEDIATE.FILTER
            KT:Msg("The current immediate filter is set to: " .. (current and current or "<No filter>"))
            KT:Msg("Use /kt immediate filter <filter> to set a new filter")
            KT:Msg("Use /kt immediate clearfilter to clear the filter")
        else
            KT:SetImmediateFilter(tostring(args[2]))
        end
    elseif args[1]:match("^c") then
        KT:ClearImmediateFilter()
    end
end)

C:Register({"threshold"}, function(args)
    if #args <= 0 then
        KT:Msg("Usage: threshold <threshold>")
        KT:Msg("E.g: /kt threshold 100")
        KT:Msg("    Notice will be shown on every 100th kill.")
        return
    end
    local t = tonumber(args[1])
    if t then
        KT:SetThreshold(t)
    else
        KT:Msg("Argument must be a number.")
    end
end)

C:Register({"countmode", "cm", "count", "counttype", "changecount", "switchcount"}, function() KT:ToggleCountMode() end)
C:Register({"debug", "toggledebug", "d", "td"}, function() KT:ToggleDebug() end)
C:Register({"exp", "xp", "experience", "shoexp", "showxp"}, function() KT:ToggleExp() end)
C:Register({"options", "opt", "config", "conf"}, function() KT.Options:Open() end)
C:Register({"minimap", "mp"}, function() KT.Broker:SetMinimap(KT.Global.BROKER.MINIMAP.hide) end)

C:Register({"tooltip", "tt"}, function()
    KT.Global.TOOLTIP = not KT.Global.TOOLTIP
    KT:Msg("Tooltip data " .. (KT.Global.TOOLTIP and "enabled" or "disabled"))
end)

for i,v in ipairs(C.Slash) do
    _G["SLASH_" .. KT.Name:upper() .. i] = "/" .. v
end

SlashCmdList[KT.Name:upper()] = function(msg)
    msg = KTT:Trim(msg)
    local args = KTT:Split(msg)
    local cmd = args[1]
    local t = {}
    if #args > 1 then
        for i = 2, #args do
            t[#t + 1] = args[i]
        end
    end
    C:HandleCommand(cmd, t)
end
