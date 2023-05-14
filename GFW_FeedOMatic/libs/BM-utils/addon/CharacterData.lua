---@class CharacterData
_G['CharacterData'] = {}
local Character = _G['CharacterData']

---Get information about the current character
---@return CharacterData
function Character:current()
    local o = {}

    o.money = (_G.GetMoney() or 0) - _G.GetCursorMoney() - _G.GetPlayerTradeMoney()
    o.class = select(2, _G.UnitClass('player'))
    o.race = select(2, _G.UnitRace('player'))

    --https://wow.gamepedia.com/API_UnitRace
    o.raceName, o.raceFile, o.raceID = _G.UnitRace('player')

    --https://wow.gamepedia.com/API_UnitClass
    o.className, o.classFilename, o.classId = _G.UnitClass('player')

    o.guild = _G.GetGuildInfo('player')
    o.gender = _G.UnitSex('player')
    o.name = _G.UnitName("player")
    o.realm = _G.GetRealmName()

    self.info = o

    setmetatable(o, self)
    self.__index = self
    return o
end

--/run _G['CharacterData'].save(_G['CharacterData']:current())
---Save character information
function Character:save()
    if not _G['Characters'] then
        _G['Characters'] = {}
    end
    if not _G['Characters'][self.realm] then
        _G['Characters'][self.realm] = {}
    end
    _G['Characters'][self.realm][self.name] = self.info
end

---Load character info
---@param realm string Realm
---@param name string Character name
---@return CharacterData
function Character:load(realm, name)
    if not _G['Characters'][realm] or not _G['Characters'][realm][name] then
        --error(('Realm %s or character %s is not found'):format(realm, name))
        return
    end

    local char = _G['Characters'][realm][name]
    setmetatable(char, self)
    self.__index = self
    return char
end

---Get character class color
---@return ColorMixin
function Character:color()
    return _G.RAID_CLASS_COLORS[self.class]
end

--[[function Character:banner()
    --if self.faction
    local ALLIANCE_BANNER = 'Interface/Icons/inv_bannerpvp_02'
    local HORDE_BANNER = 'Interface/Icons/inv_bannerpvp_01'
end]]

---Get gender as string
function Character:genderString()
    if self.gender == 3 then
        return 'female'
    elseif self.gender == 2 then
        return 'male'
    else
        return 'unknown'
    end
end

---Get character race icon
function Character:icon()

    local atlas = 'Interface/Glues/CharacterCreate/UI-CharacterCreate-Races'
    local race_coordinates = {
        HUMAN_MALE = { 0, 0.25, 0, 0.25 },
        DWARF_MALE = { 0.25, 0.5, 0, 0.25 },
        GNOME_MALE = { 0.5, 0.75, 0, 0.25 },
        NIGHTELF_MALE = { 0.75, 1.0, 0, 0.25 },
        TAUREN_MALE = { 0, 0.25, 0.25, 0.5 },
        SCOURGE_MALE = { 0.25, 0.5, 0.25, 0.5 },
        TROLL_MALE = { 0.5, 0.75, 0.25, 0.5 },
        ORC_MALE = { 0.75, 1.0, 0.25, 0.5 },
        HUMAN_FEMALE = { 0, 0.25, 0.5, 0.75 },
        DWARF_FEMALE = { 0.25, 0.5, 0.5, 0.75 },
        GNOME_FEMALE = { 0.5, 0.75, 0.5, 0.75 },
        NIGHTELF_FEMALE = { 0.75, 1.0, 0.5, 0.75 },
        TAUREN_FEMALE = { 0, 0.25, 0.75, 1.0 },
        SCOURGE_FEMALE = { 0.25, 0.5, 0.75, 1.0 },
        TROLL_FEMALE = { 0.5, 0.75, 0.75, 1.0 },
        ORC_FEMALE = { 0.75, 1.0, 0.75, 1.0 },
    }

    local key = self.raceFile:upper() .. '_' .. self:genderString():upper()
    return atlas, race_coordinates[key]
end

function Character:iconString(size, x, y)
    if size == nil then
        size = 12
    end
    local atlas, coordinates = self:icon()
    local u, v, w, z = unpack(coordinates)
    return _G.CreateTextureMarkup(atlas, 128, 128, size, size, u, v, w, z, x, y)
end
