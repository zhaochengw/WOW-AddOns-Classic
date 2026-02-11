--[[
Copyright 2009, 2010 João Cardoso
EmbedHandler is distributed under the terms of the GNU General Public License (or the Lesser GPL).
This file is part of EmbedHandler.

EmbedHandler is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

EmbedHandler is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with EmbedHandler. If not, see <http://www.gnu.org/licenses/>.
--]]

local Lib = LibStub:NewLibrary('EmbedHandler-1.0', 4)
if not Lib then
    return
else
    Lib.embeds = Lib.embeds or {}
    Lib.empty = Lib.empty or {}
end

local type, pairs, unpack, select = type, pairs, unpack, select --speed up!
local Embeds, Empty = Lib.embeds, Lib.empty

local function Embed(self, target, data)
    for k,v in pairs(self) do
        local isFunc = type(v) == 'function'
        if (isFunc and not data[k]) or (data[k] and not isFunc) then
            target[k] = self[k]
        end
    end
end

local function SpecificEmbed(self, target, data)
    for i,k in ipairs(data) do
        target[k] = self[k]
    end
end

local function SaveData(self, target, data)
    Embeds[self] = Embeds[self] or {}
    Embeds[self][target] = data
end


--[[ API ]]--

function Lib:Embed(target, ...)
    local data = {}
    for i = 1, select('#', ...) do
        data[select(i, ...)] = true
    end

    SaveData(self, target, data)
    Embed(self, target, data)
end

function Lib:SpecificEmbed(target, ...)
    local data = {specific = 1, ...}

    SpecificEmbed(self, target, data)
    SaveData(self, target, data)
end

function Lib:IterateEmbeds()
    return pairs(Embeds[self] or Empty)
end

function Lib:UpdateEmbeds()
    for target, data in Lib.IterateEmbeds(self) do
        if data.specific ~= 1 then
            Embed(self, target, data)
        else
            SpecificEmbed(self, target, data)
        end
    end
end

Lib:UpdateEmbeds()
