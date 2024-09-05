-- Ala.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/21/2020, 12:59:07 PM
--
-- Code from https://github.com/alexqu0822/alaTalentEmu/blob/master/alaShared/core.lua
--
---@class ns
local ns = select(2, ...)

local strsub = string.sub

local Ala = {}
ns.Ala = Ala

local __base64, __debase64 = {}, {}
do
    for i = 0, 9 do
        __base64[i] = tostring(i)
    end
    __base64[10] = '-'
    __base64[11] = '='
    for i = 0, 25 do
        __base64[i + 1 + 11] = strchar(i + 65)
    end
    for i = 0, 25 do
        __base64[i + 1 + 11 + 26] = strchar(i + 97)
    end
    for i = 0, 63 do
        __debase64[__base64[i]] = i
    end
end

local __classList = {
    11, -- DRUID
    3, -- HUNTER
    8, -- MAGE
    2, -- PALADIN
    5, -- PRIEST
    4, -- ROGUE
    7, -- SHAMAN
    9, -- WARLOCK
    1, -- WARRIOR
    6, -- DEATHKNIGHT
    10, -- MONK
    12, -- DEAMONHUNTER
}

local CMD_LEN_V1 = 6
local CLIENT_MAJOR = floor(select(4, GetBuildInfo()) / 10000)
local LIB_MAJOR = 2
local COMM_QUERY_PREFIX = '!Q' .. __base64[CLIENT_MAJOR] .. __base64[LIB_MAJOR]

local __zero = setmetatable({[0] = '', [1] = '0'}, {
    __index = function(t, i)
        assert(type(i) == 'number')
        t[i] = strrep('0', i)
        return t[i]
    end,
})

local _colon = setmetatable({[0] = '', [1] = ':'}, {
    __index = function(tbl, key)
        local str = strrep(':', key)
        tbl[key] = str
        return str
    end,
})

local function DecodeNumber(code)
    local isnegative = false
    if strsub(code, 1, 1) == '^' then
        code = strsub(code, 2)
        isnegative = true
    end
    local v = nil
    local n = #code
    if n == 1 then
        v = __debase64[code]
    else
        v = 0
        for i = n, 1, -1 do
            v = v * 64 + __debase64[strsub(code, i, i)]
        end
    end
    return isnegative and -v or v
end

local function DecodeItem(code)
    if code == '^' then
        return
    end

    local item = 'item:'
    local data = strsplittable(':', code)
    if not data[1] then
        return
    end
    local id = DecodeNumber(data[1])
    if not id then
        return
    end
    item = item .. id
    for i = 2, #data do
        local v = data[i]
        if #v > 1 then
            item = item .. _colon[__debase64[strsub(v, 1, 1)]] .. DecodeNumber(strsub(v, 2))
        else
            item = item .. _colon[__debase64[v]]
        end
    end
    return item
end

function Ala:DecodeEquipmentV1(code)
    local data = strsplittable('+', code)
    if not data[3] then
        return
    end

    local equips = {}
    for i = 2, #data, 2 do
        local slot, link = tonumber(data[i]), data[i + 1]
        local id = tonumber(link:match('item:(%d+)'))

        if id then
            equips[slot] = link
        else
            equips[slot] = false
        end
    end
    return equips
end

function Ala:DecodeEquipmentV2(code)
    local data = strsplittable('+', code)
    if not data[2] then
        return
    end
    local equips = {}
    local start = __debase64[data[1]] - 2
    local num = #data
    for i = 2, num do
        local slot = start + i
        local item = DecodeItem(data[i])
        equips[slot] = item or false
    end
    return equips
end

function Ala:DecodeTalentV1(code)
    local len = #code
    local data = ''

    local raw = 0
    local magic = 1
    local nChar = 0
    for index = 1, len do
        local c = strsub(code, index, index)
        if c == ':' then
            --
        elseif __debase64[c] then
            raw = raw + __debase64[c] * magic
            magic = magic * 64
            nChar = nChar + 1
        else

        end
        if c == ':' or nChar == 5 or index == len then
            magic = 1
            nChar = 0
            local n = 0
            while raw > 0 do
                local val = raw % 6
                data = data .. val
                raw = (raw - val) / 6
                n = n + 1
            end
            if n < 11 then
                data = data .. __zero[11 - n]
            end
        end
    end
    return data
end

function Ala:DecodeGlyph(code)
    local list = strsplittable('+', code)
    if list[2] ~= nil then
        local data = {}
        for i = 1, 6 do
            local str = list[i + 1]
            if str and str ~= '' then
                local val = strsplittable(':', str)
                -- local v = DecodeNumber(val[1])
                -- local enabled = v % 8
                -- local glyphType = (v - enabled) / 8
                local spellId = DecodeNumber(val[2])
                -- local icon = DecodeNumber(val[3])
                local glyphId = ns.GetGlyphIdBySpellId(spellId)
                data[i] = glyphId or nil
            end
        end
        return data
    end
end

function Ala:RecvEquipmentV1(code)
    local c = strsplit('#', code)
    local equips = self:DecodeEquipmentV1(c)
    if not equips then
        return
    end
    return {equips = equips}
end

function Ala:RecvTalentV1(code, maybeOld)
    local classIndex = __debase64[strsub(code, 1, 1)]
    if not classIndex then
        return
    end
    local class = __classList[classIndex]
    if not class then
        return
    end

    local level = __debase64[strsub(code, -2, -2)] + __debase64[strsub(code, -1, -1)] * 64
    local talent = self:DecodeTalentV1(strsub(code, 2, -3))
    local result = {class = class, level = level}

    if maybeOld then
        talent = ns.ResolveTalent(ns.GetClassFileName(class), talent)
    end

    if talent then
        result.numGroups = 1
        result.activeGroup = 1
        result.talents = {talent}
    end

    return result
end

function Ala:RecvCommV1(msg)
    local cmd = strsub(msg, 1, CMD_LEN_V1)
    if cmd == '_repeq' or cmd == '_r_equ' or cmd == '_r_eq3' then
        return self:RecvEquipmentV1(strsub(msg, CMD_LEN_V1 + 1, -1))
    elseif cmd == '_reply' or cmd == '_r_tal' then
        return self:RecvTalentV1(strsub(msg, CMD_LEN_V1 + 1, -1), true)
    end
end

local _RecvBuffer = {}

function Ala:RecvPacket(msg, sender)
    local num = __debase64[strsub(msg, 5, 5)] + __debase64[strsub(msg, 6, 6)] * 64;
    local index = __debase64[strsub(msg, 7, 7)] + __debase64[strsub(msg, 8, 8)] * 64;
    local buffer = _RecvBuffer[sender] or {}
    _RecvBuffer[sender] = buffer
    -- Buffer[receiver] = Buffer[receiver] or {};
    -- Buffer = Buffer[receiver];
    -- buffer[sender] = buffer[sender] or {};
    -- buffer = buffer[sender];
    buffer[index] = strsub(msg, 9);
    for i = 1, num do
        if not buffer[i] then
            return
        end
    end
    _RecvBuffer[sender] = nil
    return table.concat(buffer)
end

function Ala:RecvTalentV2Step2(code)
    local classIndex = __debase64[strsub(code, 1, 1)]
    if not classIndex then
        return
    end
    local class = __classList[classIndex]
    if not class then
        return
    end
    local level = __debase64[strsub(code, 2, 2)] + __debase64[strsub(code, 3, 3)] * 64
    local numGroups = tonumber(__debase64[strsub(code, 4, 4)])
    if not numGroups then
        return
    end
    local activeGroup = tonumber(__debase64[strsub(code, 5, 5)])
    if not activeGroup then
        return
    end
    local lenTal1 = tonumber(__debase64[strsub(code, 6, 6)])
    if not lenTal1 then
        return
    end
    local code1 = strsub(code, 7, lenTal1 + 6)

    assert(lenTal1 == #code1)

    if numGroups < 2 then
        return {
            class = class,
            level = level,
            numGroups = 1,
            activeGroup = activeGroup,
            talents = {self:DecodeTalentV1(code1)},
        }
    else
        local lenTal2 = tonumber(__debase64[strsub(code, 7 + lenTal1, 7 + lenTal1)])
        if not lenTal2 then
            return
        end
        local code2 = strsub(code, lenTal1 + 8, lenTal1 + lenTal2 + 7)

        assert(lenTal2 == #code2)

        return {
            class = class,
            level = level,
            numGroups = 2,
            activeGroup = activeGroup,
            talents = {self:DecodeTalentV1(code1), self:DecodeTalentV1(code2)},
        }
    end
end

function Ala:RecvTalentV2(code)
    if strsub(code, 1, 2) ~= '!T' then
        return
    end
    local clientMajor = __debase64[strsub(code, 3, 3)]
    if clientMajor ~= CLIENT_MAJOR then
        return
    end
    local protoVersion = __debase64[strsub(code, 4, 4)]
    if protoVersion == 1 then
        return self:RecvTalentV1(strsub(code, 5))
    elseif protoVersion == 2 then
        return self:RecvTalentV2Step2(strsub(code, 5))
    end
end

function Ala:RecvGlyphV2Step2(code)
    local numGroups = tonumber(__debase64[strsub(code, 1, 1)])
    if not numGroups then
        return
    end
    local activeGroup = tonumber(__debase64[strsub(code, 2, 2)])
    if not activeGroup then
        return
    end

    local ofs = 3
    local len1
    local code1
    local c4_1 = strsub(code, ofs + 1, ofs + 1)
    if c4_1 == '+' then
        len1 = __debase64[strsub(code, ofs, ofs)]
        code1 = strsub(code, ofs + 1, ofs + len1)
        ofs = ofs + 1 + len1
    else
        len1 = __debase64[strsub(code, ofs, ofs)] + __debase64[c4_1] * 64
        code1 = strsub(code, ofs + 2, ofs + len1 + 1)
        ofs = ofs + 2 + len1
    end

    if numGroups < 2 then
        return { --
            numGroups = numGroups,
            activeGroup = activeGroup,
            glyphs = {self:DecodeGlyph(code1)},
        }
    else
        local c4_2 = strsub(code, ofs + 1, ofs + 1);
        local len2 = __debase64[strsub(code, ofs, ofs)] + (c4_2 == '+' and 0 or __debase64[c4_2] * 64)
        local code2 = c4_2 == '+' and strsub(code, ofs + 1, ofs + len2) or strsub(code, ofs + 2, ofs + len2 + 1)

        return {
            numGroups = numGroups,
            activeGroup = activeGroup,
            glyphs = {self:DecodeGlyph(code1), self:DecodeGlyph(code2)},
        }
    end
end

function Ala:RecvGlyphV2(code)
    if strsub(code, 1, 2) ~= '!G' then
        return
    end
    local clientMajor = __debase64[strsub(code, 3, 3)]
    if clientMajor ~= CLIENT_MAJOR then
        return
    end
    -- local protoVersion = __debase64[strsub(code, 4, 4)]
    return self:RecvGlyphV2Step2(strsub(code, 5))
end

function Ala:RecvEquipmentV2Step2(code)
    local equips = self:DecodeEquipmentV2(code)
    if not equips then
        return
    end
    return {equips = equips}
end

function Ala:RecvEquipmentV2(code)
    if strsub(code, 1, 2) ~= '!E' then
        return
    end
    local clientMajor = __debase64[strsub(code, 3, 3)]
    if clientMajor ~= CLIENT_MAJOR then
        return
    end
    local protoVersion = __debase64[strsub(code, 4, 4)]
    if protoVersion == 1 then
        return self:RecvEquipmentV1(strsub(code, 5))
    elseif protoVersion == 2 then
        return self:RecvEquipmentV2Step2(strsub(code, 5))
    end
end

function Ala:RecvRune(code)
    if strsub(code, 1, 2) ~= '!N' then
        return false;
    end
    local clientMajor = __debase64[strsub(code, 3, 3)];
    if clientMajor ~= CLIENT_MAJOR then
        return
    end

    local runes = {}
    local val = strsplittable('+', strsub(code, 5));
    for i = 1, #val do
        local slot, id, icon = strsplit(':', val[i]);
        slot = slot and __debase64[slot] or nil;
        id = id and DecodeNumber(id) or nil;
        icon = icon and DecodeNumber(icon) or nil;
        if slot ~= nil and id ~= nil then
            runes[slot] = {slot = slot, spellId = id, icon = icon};
        end
    end
    return {runes = runes}
end

local function merge(dst, src)
    if not dst then
        return src
    end
    if not src then
        return dst
    end
    for k, v in pairs(src) do
        dst[k] = v
    end
    return dst
end

function Ala:RecvCommV2(msg, sender)
    if not msg then
        return
    end
    if strsub(msg, 1, 2) == '!P' then
        return self:RecvCommV2(self:RecvPacket(msg, sender), sender)
    end

    local _
    local pos = 1
    local code
    local v2_ctrl_code
    local len = #msg
    local r
    while pos < len do
        _, pos, code, v2_ctrl_code = strfind(msg, '((![^!])[^!]+)', pos)
        if v2_ctrl_code == '!T' then
            r = merge(r, self:RecvTalentV2(code))
        elseif v2_ctrl_code == '!G' then
            r = merge(r, self:RecvGlyphV2(code))
        elseif v2_ctrl_code == '!E' then
            r = merge(r, self:RecvEquipmentV2(code))
        elseif v2_ctrl_code == '!N' then
            r = merge(r, self:RecvRune(code))
        end
    end
    if r then
        r.v2 = true
    end
    return r
end

function Ala:RecvComm(msg, channel, sender)
    if channel ~= 'WHISPER' then
        return
    end
    local p = strsub(msg, 1, 1)
    if p == '_' then
        return self:RecvCommV1(msg)
    elseif p == '!' then
        return self:RecvCommV2(msg, sender)
    end
end

function Ala:PackQuery(queryEquip, queryTalent, queryGlyph, queryRune)
    return COMM_QUERY_PREFIX .. (queryTalent and 'T' or '') .. (queryGlyph and 'G' or '') ..
               ((queryEquip or queryRune) and 'E' or '')
end
