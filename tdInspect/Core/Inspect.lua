-- Core.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/17/2020, 11:08:38 PM
--
---@type ns
local ns = select(2, ...)

local ipairs, pairs, time = ipairs, pairs, time
local tostring = tostring
local tinsert, tconcat = table.insert, table.concat
local select = select

local CanInspect = CanInspect
local CheckInteractDistance = CheckInteractDistance
local ClearInspectPlayer = ClearInspectPlayer
local GetInventoryItemID = GetInventoryItemID
local GetInventoryItemLink = GetInventoryItemLink
local GetNumTalents = GetNumTalents
local GetNumTalentTabs = GetNumTalentTabs
local GetPlayerInfoByGUID = GetPlayerInfoByGUID
local GetTalentInfo = GetTalentInfo
local NotifyInspect = NotifyInspect
local UnitClass = UnitClass
local UnitClassBase = UnitClassBase
local UnitGUID = UnitGUID
local UnitLevel = UnitLevel
local UnitRace = UnitRace

local HideUIPanel = LibStub('LibShowUIPanel-1.0').HideUIPanel

local ALA_PREFIX = 'ATEADD'
local PROTO_PREFIX = 'tdInspect'
local PROTO_VERSION = 2

local Serializer = LibStub('AceSerializer-3.0')
local Encoder = ns.Encoder

---@class Inspect: AceAddon-3.0, AceEvent-3.0, AceComm-3.0
local Inspect = ns.Addon:NewModule('Inspect', 'AceEvent-3.0', 'AceComm-3.0')

function Inspect:OnInitialize()
    self.unitName = nil
    self.waitingItems = {}
    self.userCache = ns.Addon.db.global.userCache

    self.db = setmetatable({}, {
        __index = function(_, k)
            return self.userCache[self.unitName] and self.userCache[self.unitName][k]
        end,
        __newindex = function(_, k, v)
            self.userCache[self.unitName] = self.userCache[self.unitName] or {}
            self.userCache[self.unitName][k] = v
        end,
    })
    ---@type Talent[]
    self.talents = setmetatable({}, {
        __index = function(t, i)
            assert(i == 1 or i == 2)

            if not self.db.talents then
                return nil
            end

            local talent = ns.Talent:New(ns.GetClassFileName(self.db.class), self.db.talents[i])
            t[i] = talent
            return talent
        end,
    })
    ---@type Glyph
    self.glyphs = setmetatable({}, {
        __index = function(t, i)
            assert(i == 1 or i == 2)
            if not self.db.glyphs then
                return nil
            end

            local glyph = ns.Glyph:New(self.db.glyphs[i], self.db.level)
            t[i] = glyph
            return glyph
        end,
    })
end

function Inspect:OnEnable()
    local function Deal(sender, ok, cmd, ...)
        if ok then
            return self:OnComm(cmd, ns.GetFullName(sender), ...)
        end
    end

    local function OnComm(_, msg, d, sender)
        return Deal(sender, Serializer:Deserialize(msg))
    end

    self:RegisterEvent('GET_ITEM_INFO_RECEIVED')
    self:RegisterEvent('INSPECT_READY')
    self:RegisterComm(ALA_PREFIX, 'OnAlaCommand')
    self:RegisterComm(PROTO_PREFIX, OnComm)
end

function Inspect:SetUnit(unit, name)
    self.unit = unit
    self.unitName = unit and ns.UnitName(unit) or ns.GetFullName(name)
    wipe(self.waitingItems)

    INSPECTED_UNIT = unit
    if InspectFrame then
        InspectFrame.unit = unit
    end

    self:UnregisterEvent('PLAYER_TARGET_CHANGED')
    self:UnregisterEvent('UPDATE_MOUSEOVER_UNIT')

    if unit == 'target' then
        self:RegisterEvent('PLAYER_TARGET_CHANGED')
    elseif unit == 'mouseover' then
        self:RegisterEvent('UPDATE_MOUSEOVER_UNIT', 'GROUP_ROSTER_UPDATE')
    end
end

function Inspect:Clear()
    ClearInspectPlayer()
    self.unitName = nil
    self.unit = nil
    wipe(self.talents)
    wipe(self.glyphs)

    INSPECTED_UNIT = nil
    if InspectFrame then
        InspectFrame.unit = nil
    end
end

function Inspect:GetItemLink(slot)
    local link
    if self.unit then
        link = GetInventoryItemLink(self.unit, slot)
    end
    if not link and self.unitName and self.db.equips then
        link = self.db.equips[slot]
    end
    return link
end

function Inspect:IsItemEquipped(itemId)
    for slot = 1, 18 do
        local link = self:GetItemLink(slot)
        if link then
            local id = ns.ItemLinkToId(link)
            if id and id == itemId then
                return true
            end
        end
    end
end

-- @non-classic@
local GEM_COLORS = {
    [Enum.ItemGemSubclass.Red] = {Enum.ItemGemSubclass.Red},
    [Enum.ItemGemSubclass.Yellow] = {Enum.ItemGemSubclass.Yellow},
    [Enum.ItemGemSubclass.Blue] = {Enum.ItemGemSubclass.Blue},
    [Enum.ItemGemSubclass.Orange] = {Enum.ItemGemSubclass.Red, Enum.ItemGemSubclass.Yellow},
    [Enum.ItemGemSubclass.Purple] = {Enum.ItemGemSubclass.Red, Enum.ItemGemSubclass.Blue},
    [Enum.ItemGemSubclass.Green] = {Enum.ItemGemSubclass.Yellow, Enum.ItemGemSubclass.Blue},
    [Enum.ItemGemSubclass.Prismatic] = {
        Enum.ItemGemSubclass.Red, Enum.ItemGemSubclass.Yellow, Enum.ItemGemSubclass.Blue,
    },
}

local function CheckGem(out, itemId)
    if not itemId or itemId == 0 then
        return
    end

    local classId, subClassId = select(6, GetItemInfoInstant(itemId))
    if classId ~= Enum.ItemClass.Gem then
        return
    end

    local gemColors = GEM_COLORS[subClassId]
    if not gemColors then
        return
    end

    for _, v in ipairs(gemColors) do
        out[v] = (out[v] or 0) + 1
    end
end

function Inspect:GetEquippedGemCounts()
    local out = {}
    for slot = 1, 18 do
        local link = self:GetItemLink(slot)
        if link then
            for _, itemId in ipairs(ns.GetItemGems(link)) do
                CheckGem(out, itemId)
            end
        end
    end
    return out
end
-- @end-non-classic@

function Inspect:GetEquippedSetItems(id)
    local count = 0
    local items = {}
    local overrideNames = {}
    local slotItems = ns.ItemSets[id].slots

    for slot = 1, 18 do
        local link = self:GetItemLink(slot)
        if link then
            local name, _, _, _, _, _, _, _, equipLoc, _, _, _, _, _, _, setId = GetItemInfo(link)
            if name and setId and setId == id then
                local baseName
                local itemId = ns.ItemLinkToId(link)

                if equipLoc == 'INVTYPE_ROBE' then
                    equipLoc = 'INVTYPE_CHEST'
                end

                local isBaseItem = slotItems[equipLoc][itemId]
                if not isBaseItem then
                    local baseItemId = next(slotItems[equipLoc])
                    baseName = GetItemInfo(baseItemId)
                    if baseName then
                        overrideNames[baseName] = name
                    end
                    items[name] = (items[name] or 0) + 1
                end

                count = count + 1
                baseName = baseName or name
                items[baseName] = (items[baseName] or 0) + 1
            end
        end
    end
    return count, items, overrideNames
end

function Inspect:GetUnitClassFileName()
    if self.unit then
        return UnitClassBase(self.unit)
    else
        return ns.GetClassFileName(self.db.class)
    end
end

function Inspect:GetUnitClass()
    if self.unit then
        return (UnitClass(self.unit))
    else
        return ns.GetClassLocale(self.db.class)
    end
end

function Inspect:GetUnitRaceFileName()
    if self.unit then
        return (select(2, UnitRace(self.unit)))
    else
        return ns.GetRaceFileName(self.db.race)
    end
end

function Inspect:GetUnitRace()
    if self.unit then
        return (UnitRace(self.unit))
    else
        return ns.GetRaceLocale(self.db.race)
    end
end

function Inspect:GetUnitLevel()
    if self.unit then
        return UnitLevel(self.unit)
    else
        return self.db.level
    end
end

function Inspect:GetNumTalentGroups()
    return self.db.numGroups or 0
end

function Inspect:GetActiveTalentGroup()
    return self.db.activeGroup
end

function Inspect:GetUnitTalent(group)
    return self.talents[group or self:GetActiveTalentGroup()]
end

---@return Glyph
function Inspect:GetUnitGlyph(group)
    return self.glyphs[group or self:GetActiveTalentGroup()]
end

function Inspect:GetLastUpdate()
    return self.db.timestamp
end

function Inspect:CanBlizzardInspect(unit)
    if not unit then
        return false
    end
    --[=[@debug@
    if UnitIsUnit(unit, 'player') then
        return false
    end
    --@end-debug@]=]
    if UnitIsDeadOrGhost('player') then
        return false
    end
    if UnitIsDeadOrGhost(unit) then
        return false
    end
    if not CheckInteractDistance(unit, 1) then
        return false
    end
    if not CanInspect(unit) then
        return false
    end
    return true
end

function Inspect:CanOurInspect(unit)
    if unit then
        if UnitFactionGroup(unit) ~= UnitFactionGroup('player') then
            return false
        end
    end
    return true
end

function Inspect:Query(unit, name)
    if unit and not UnitIsPlayer(unit) then
        return
    end

    InspectFrame_LoadUI()
    HideUIPanel(InspectFrame)
    InspectSwitchTabs(1)

    self:SetUnit(unit, name)

    local queryTalent = false
    local queryEquip = false
    local queryGlyph = false

    if self:CanBlizzardInspect(unit) then
        NotifyInspect(unit)

        --[=[@classic@
        queryTalent = true
        --@end-classic@]=]
        -- @build>3@
        queryGlyph = true
        -- @end-build>3@

    elseif self:CanOurInspect(unit) then
        queryEquip = true
        queryTalent = true
        queryGlyph = true
    end

    if queryEquip or queryTalent or queryGlyph then
        self:SendCommMessage(PROTO_PREFIX,
                             Serializer:Serialize('Q', queryTalent, queryEquip, PROTO_VERSION, queryGlyph), 'WHISPER',
                             self.unitName)
        self:SendCommMessage(ALA_PREFIX, ns.Ala:PackQuery(queryEquip, queryTalent, queryGlyph), 'WHISPER', self.unitName)
    end

    self:CheckQuery()
end

function Inspect:CheckQuery()
    if self.userCache[self.unitName] then
        self:TryFireMessage(self.unit, self.unitName, self.userCache[self.unitName])
    end
end

function Inspect:BuildCharacterDb(name)
    self.userCache[name] = self.userCache[name] or {}
    self.userCache[name].timestamp = time()
    return self.userCache[name]
end

function Inspect:INSPECT_READY(_, guid)
    if not self.unit then
        return
    end

    if UnitGUID(self.unit) ~= guid then
        return
    end

    local name = ns.GetFullName(select(6, GetPlayerInfoByGUID(guid)))
    if name then
        local db = self:BuildCharacterDb(name)

        for slot = 0, 18 do
            local link = GetInventoryItemLink(self.unit, slot)
            if link then
                link = link:match('(item:[%-0-9:]+)')
            else
                local id = GetInventoryItemID(self.unit, slot)
                if id then
                    link = 'item:' .. id
                    GetItemInfo(id)
                    self.waitingItems[id] = self.waitingItems[id] or {}
                    tinsert(self.waitingItems[id], slot)
                end
            end

            db.equips = db.equips or {}
            db.equips[slot] = link
        end

        db.class = select(3, UnitClass(self.unit))
        db.race = select(3, UnitRace(self.unit))
        db.level = UnitLevel(self.unit)
        -- @build>2@
        db.talents = Encoder:PackTalents(true)
        -- @end-build>2@
        -- @build>3@
        db.numGroups = GetNumTalentGroups(true)
        db.activeGroup = GetActiveTalentGroup(true)
        -- @build>3@
        --[=[@build<3@
        db.numGroups = 1
        db.activeGroup = 1
        --@end-build<3@]=]

        self:TryFireMessage(self.unit, name, db)
    end
end

function Inspect:UpdateCharacter(sender, data)
    local name = ns.GetFullName(sender)
    local db = self:BuildCharacterDb(name)

    if data.class then
        db.class = data.class
    end
    if data.level then
        db.level = data.level
    end
    if data.equips then
        db.equips = db.equips or {}
        for k, v in pairs(data.equips) do
            db.equips[k] = v or nil
        end
    end
    if data.talents or data.glyphs then
        db.numGroups = data.numGroups
        db.activeGroup = data.activeGroup
    end
    if data.talents then
        db.talents = data.talents
    end
    if data.glyphs then
        db.glyphs = data.glyphs
    end

    self:TryFireMessage(nil, name, db)
end

function Inspect:OnComm(cmd, sender, ...)
    if cmd == 'Q' then
        local queryTalent, queryEquip, protoVersion, queryGlyph = ...
        if not protoVersion or protoVersion == 1 then
            -- @build>3@
            local talent = queryTalent and Encoder:PackTalent(nil, GetActiveTalentGroup(), true) or nil
            -- @end-build>3@
            -- @buid<3@
            local talent = queryTalent and Encoder:PackTalent(nil, 1, true) or nil
            --@end-build<3@]=]
            local equips = queryEquip and Encoder:PackEquips(true) or nil
            local class = select(3, UnitClass('player'))
            local race = select(3, UnitRace('player'))
            local level = UnitLevel('player')
            local msg = Serializer:Serialize('R', class, race, level, talent, equips)

            self:SendCommMessage(PROTO_PREFIX, msg, 'WHISPER', sender)
        elseif protoVersion >= 2 then
            local numGroups = GetNumTalentGroups()
            local activeGroup = GetActiveTalentGroup()
            local equips = queryEquip and Encoder:PackEquips() or nil
            local talents = queryTalent and Encoder:PackTalents() or nil
            local glyphs = queryGlyph and Encoder:PackGlyphs() or nil
            local class = select(3, UnitClass('player'))
            local race = select(3, UnitRace('player'))
            local level = UnitLevel('player')
            local msg = Serializer:Serialize('R2', protoVersion, class, race, level, equips, numGroups, activeGroup,
                                             talents, glyphs)

            self:SendCommMessage(PROTO_PREFIX, msg, 'WHISPER', sender)
        end

    elseif cmd == 'R' then
        local class, race, level, talent, equips = ...

        local name = ns.GetFullName(sender)
        local db = self:BuildCharacterDb(name)

        db.class = class
        db.race = race
        db.level = level

        if talent then
            db.numGroups = 1
            db.activeGroup = 1

            if talent then
                db.talents = {talent}
            end
        end

        if equips then
            db.equips = db.equips or {}
            for k, v in pairs(equips) do
                if v ~= '' then
                    db.equips[k] = 'item:' .. v
                else
                    db.equips[k] = nil
                end
            end
        end

        self:TryFireMessage(nil, name, db)
    elseif cmd == 'R2' then
        local protoVersion, class, race, level, equips, numGroups, activeGroup, talents, glyphs = ...
        local name = ns.GetFullName(sender)
        local db = self:BuildCharacterDb(name)

        db.class = class
        db.race = race
        db.level = level

        if talents or glyphs then
            db.numGroups = numGroups
            db.activeGroup = activeGroup
        end

        if talents then
            db.talents = Encoder:UnpackTalents(talents)
        end

        if equips then
            db.equips = Encoder:UnpackEquips(equips)
        end

        if glyphs then
            db.glyphs = Encoder:UnpackGlyphs(glyphs)
        end

        self:TryFireMessage(nil, name, db)
    end
end

function Inspect:TryFireMessage(unit, name, db)
    if name ~= self.unitName then
        return
    end

    self:SendMessage('INSPECT_READY', unit, name)

    if db and db.talents then
        self:SendMessage('INSPECT_TALENT_READY', unit, name)
    end
end

function Inspect:OnAlaCommand(_, msg, channel, sender)
    local data = ns.Ala:RecvComm(msg, channel, sender)
    if not data then
        return
    end

    self:UpdateCharacter(sender, data)
end

function Inspect:PLAYER_TARGET_CHANGED()
    if self.unit == 'target' then
        self:SetUnit(nil, self.unitName)
        self:SendMessage('INSPECT_TARGET_CHANGED')
    end
end

function Inspect:GROUP_ROSTER_UPDATE()
    C_Timer.After(0, function()
        if self.unit and self.unitName ~= ns.UnitName(self.unit) then
            self:SetUnit(nil, self.unitName)
            self:SendMessage('INSPECT_TARGET_CHANGED')
        end
    end)
end

function Inspect:GET_ITEM_INFO_RECEIVED(_, id, ok)
    if not ok then
        return
    end

    if not self.unit then
        return
    end

    if not self.waitingItems[id] then
        return
    end

    local guid = UnitGUID(self.unit)
    local name = ns.GetFullName(select(6, GetPlayerInfoByGUID(guid)))
    local db = self:BuildCharacterDb(name)

    for _, slot in ipairs(self.waitingItems[id]) do
        local link = GetInventoryItemLink(self.unit, slot)
        if link then
            link = link:match('(item:[%-0-9:]+)')
        end

        db.equips = db.equips or {}
        db.equips[slot] = link
    end

    self:SendMessage('INSPECT_READY', self.unit, name)
end
