-- Ala.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/21/2020, 12:59:07 PM
--
-- Code from https://github.com/alexqu0822/alaTalentEmu/blob/master/alaShared/core.lua
--

---@type ns
local ns = select(2, ...)

local Ala = {}
ns.Ala = Ala

local ALA_CLASSES = {}

local CODE_TABLE = {}
local REV_CODE_TABLE = {}
local INDEX_TO_CLASS = {
    11, -- DRUID
    3, -- HUNTER
    8, -- MAGE
    2, -- PALADIN
    5, -- PRIEST
    4, -- ROGUE
    7, -- SHAMAN
    9, -- WARLOCK
    1, -- WARRIOR
}

do
    for i = 0, 9 do
        CODE_TABLE[i] = tostring(i)
    end
    CODE_TABLE[10] = '-'
    CODE_TABLE[11] = '='
    for i = 0, 25 do
        CODE_TABLE[i + 1 + 11] = strchar(i + 65)
    end
    for i = 0, 25 do
        CODE_TABLE[i + 1 + 11 + 26] = strchar(i + 97)
    end

    for i = 0, 63 do
        REV_CODE_TABLE[CODE_TABLE[i]] = i
    end
end

function Ala:Decode(code)
    local data = ''
    local revCodeTable = REV_CODE_TABLE
    local classIndex = revCodeTable[strsub(code, 1, 1)]
    if not classIndex then
        return nil
    end

    local class = INDEX_TO_CLASS[classIndex]
    if not class then
        return nil
    end

    local len = #code
    if len < 3 then

    end
    local pos = 0
    local raw = 0
    local magic = 1
    local nChar = 0
    for p = 2, len - 2 do
        local c = strsub(code, p, p)
        pos = pos + 1
        if c == ':' then
            --
        elseif revCodeTable[c] then
            raw = raw + revCodeTable[c] * magic
            magic = bit.lshift(magic, 6)
            nChar = nChar + 1
        else

        end
        if c == ':' or nChar == 5 or p == len - 2 then
            pos = 0
            magic = 1
            nChar = 0
            local n = 0
            while raw > 0 do
                data = data .. raw % 6
                raw = floor(raw / 6)
                n = n + 1
            end
            if n < 11 then
                for i = n + 1, 11 do
                    data = data .. '0'
                end
            end
        end
    end

    if true then
        return class, data, revCodeTable[strsub(code, -2, -2)] + bit.lshift(revCodeTable[strsub(code, -1, -1)], 6)
    else
        return class, data, 60
    end
end
