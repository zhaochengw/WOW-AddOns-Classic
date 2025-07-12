-- Addon.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/18/2020, 11:25:23 AM
--
---@type string, ns
local ADDON, NS = ...

---@class ns
---@field Inspect Inspect
---@field Talent Talent
---@field Glyph Glyph
---@field ItemLevelCalculator ItemLevelCalculator
---@field Events Events
---@field SpecGear SpecGear
local ns = NS

local ShowUIPanel = LibStub('LibShowUIPanel-1.0').ShowUIPanel
local HideUIPanel = LibStub('LibShowUIPanel-1.0').HideUIPanel

---@class UI
---@field BaseItem UI.BaseItem
---@field GearItem UI.GearItem
---@field GearFrame UI.GearFrame
---@field GemItem UI.GemItem
---@field EnchantItem UI.EnchantItem
---@field InspectFrame UI.InspectFrame
---@field InspectGearFrame UI.InspectGearFrame
---@field GlyphItem UI.GlyphItem
---@field TalentFrame UI.TalentFrame
---@field CharacterGearFrame UI.CharacterGearFrame
---@field GlyphFrame UI.GlyphFrame
---@field PaperDoll UI.PaperDoll
---@field InspectTalent UI.InspectTalent
---@field ModelFrame UI.ModelFrame
---@field SlotItem UI.SlotItem
---@field MenuButton UI.MenuButton
ns.UI = {}
ns.L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

ns.VERSION = tonumber((C_AddOns.GetAddOnMetadata(ADDON, 'Version'):gsub('(%d+)%.?', function(x)
    return format('%02d', tonumber(x))
end))) or 0

_G.BINDING_NAME_TDINSPECT_VIEW_TARGET = ns.L['Inspect target']
_G.BINDING_NAME_TDINSPECT_VIEW_MOUSEOVER = ns.L['Inspect mouseover']
_G.BINDING_CATEGORY_TDINSPECT = C_AddOns.GetAddOnMetadata(ADDON, 'Title')

---@class Addon: AceAddon, LibClass-2.0, EventHandler
local Addon = LibStub('AceAddon-3.0'):NewAddon(ADDON, 'LibClass-2.0')
ns.Addon = Addon

function Addon:OnInitialize()
    ns.Events:Embed(Addon)

    self:SetupDatabase()
    self:SetupCharacterProfile()
    self:SetupAnyAccount()
    self:SetupGearParent()
    self:SetupOptionFrame()
end

function Addon:OnEnable()
    self:Event('ADDON_LOADED')
    self:Event('TDINSPECT_READY')
    self:Event('TDINSPECT_TALENT_READY', 'TDINSPECT_READY')
    self:Event('TDINSPECT_OPTION_CHANGED')
end

function Addon:OnModuleCreated(module)
    ns[module:GetName()] = module
end

function Addon:OnClassCreated(class, name)
    local uiName = name:match('^UI%.(.+)$')
    if uiName then
        ns.UI[uiName] = class
        ns.Events:Embed(class)
    else
        ns[name] = class
    end
end

function Addon:SetupDatabase()
    ---@class tdInspectProfile: table
    local profile = { --
        global = { --
            characters = {},
            userCache = {},
        },
        profile = { --
            characterGear = true,
            inspectGear = true,
            inspectCompare = true,
            showTalentBackground = true,
            closeCharacterFrameWhenInspect = true,
            showOptionButtonInCharacter = true,
            showOptionButtonInInspect = true,
            showGem = true,
            showEnchant = true,
            showLost = true,
            showGemsFront = false,
            showRangedEnchantOnlyHunter = true,
            showLowLevelCharacters = false,
            itemLevelColor = 'Light',
        },
    }

    ---@type tdInspectProfile | AceDB.Schema
    ns.db = LibStub('AceDB-3.0'):New('TDDB_INSPECT2', profile, true)

    if not ns.db.global.version or ns.db.global.version < 20000 then
        wipe(ns.db.global.userCache)
    end

    for k, v in pairs(ns.db.global.userCache) do
        if not v.class then
            ns.db.global.userCache[k] = nil
        end
    end

    ns.db.global.version = ns.VERSION
end

function Addon:SetupCharacterProfile()
    ---@class CharacterProfile: table
    local characterProfile = {gears = {}, equipmentSets = {}}

    local name = ns.UnitName('player')
    local char = ns.db.global.characters[name]
    if type(char) ~= 'table' then
        char = nil
    end

    ns.db.global.characters[name] = ns.CopyDefaults(char, characterProfile)
    ---@type CharacterProfile
    ns.char = ns.db.global.characters[name]
end

function Addon:DeleteCharacter(name)
    ns.db.global.characters[name] = nil
    self.characters = nil
end

function Addon:SetupAnyAccount()
    if not _G.TDDB_INSPECT_ANYACCOUNT then
        return
    end

    ns.hasAnyAccount = true

    ns.otherCharacters = {}

    for _, v in pairs(_G.TDDB_INSPECT_ANYACCOUNT) do
        if v.global then
            if v.global.userCache then
                for name, p in pairs(v.global.userCache) do
                    if not ns.db.global.userCache[name] or p.timestamp > ns.db.global.userCache[name].timestamp then
                        ns.db.global.userCache[name] = p
                    end
                end
            end
            if v.global.characters then
                for name, p in pairs(v.global.characters) do
                    if not ns.db.global.characters[name] then
                        ns.otherCharacters[name] = p
                    end
                end
            end
        end
    end

    _G.TDDB_INSPECT_ANYACCOUNT = nil
end

function Addon:SetupGearParent()
    self.CharacterGearParent = CreateFrame('Frame', nil, PaperDollFrame)
    self.CharacterGearParent:SetPoint('TOPLEFT', CharacterFrame, 'TOPRIGHT', -33, -12)
    self.CharacterGearParent:SetSize(1, 1)
    self.CharacterGearParent:SetScript('OnShow', function()
        self:OpenCharacterGearFrame()
    end)
end

function Addon:SetupUI()
    self.InspectFrame = ns.UI.InspectFrame:Bind(InspectFrame)
end

function Addon:ADDON_LOADED(_, addon)
    if addon ~= 'Blizzard_InspectUI' then
        return
    end

    self:SetupUI()
    self:UnEvent('ADDON_LOADED')
end

function Addon:TDINSPECT_READY(_, unit, name)
    if not InspectFrame then
        return
    end
    if unit == ns.Inspect.unit or name == ns.Inspect.unitName then
        ShowUIPanel(self.InspectFrame)

        if ns.db.profile.closeCharacterFrameWhenInspect then
            HideUIPanel(CharacterFrame)
        end
    end
end

function Addon:TDINSPECT_OPTION_CHANGED(_, key, value)
    if key == 'characterGear' then
        if value then
            if self.CharacterGearParent:IsShown() then
                self:OpenCharacterGearFrame()
            end
        elseif self.CharacterGearFrame then
            if not ns.db.profile.inspectCompare or not self.InspectGearFrame or not self.InspectGearFrame:IsShown() then
                self.CharacterGearFrame:Hide()
            end
        end
    elseif key == 'inspectGear' and InspectPaperDollFrame then
        if value then
            if InspectPaperDollFrame:IsShown() then
                self:OpenInspectGearFrame()
            elseif self.InspectGearFrame then
                self.InspectGearFrame:Hide()
            end
        elseif self.InspectGearFrame then
            self.InspectGearFrame:Hide()
        end
    elseif key == 'inspectCompare' and InspectPaperDollFrame then
        if value then
            if InspectPaperDollFrame:IsVisible() then
                self:OpenInspectGearFrame()
            end
        elseif self.CharacterGearFrame then
            self.CharacterGearFrame:Hide()

            if self.CharacterGearParent:IsShown() then
                self:OpenCharacterGearFrame()
            end
        end
    end
end

---@return UI.CharacterGearFrame
function Addon:GetCharacterGearFrame()
    if not self.CharacterGearFrame then
        self.CharacterGearFrame = ns.UI.CharacterGearFrame:Create(self.CharacterGearParent)
    end
    return self.CharacterGearFrame
end

function Addon:GetInspectGearFrame()
    if not self.InspectGearFrame then
        self.InspectGearFrame = ns.UI.InspectGearFrame:Create(InspectPaperDollFrame, true)
        self.InspectGearFrame:SetPoint('TOPLEFT', InspectPaperDollFrame, 'TOPRIGHT', -33, -12)
    end
    return self.InspectGearFrame
end

function Addon:OpenCharacterGearFrame()
    if ns.db.profile.characterGear then
        local characterGearFrame = self:GetCharacterGearFrame()

        if characterGearFrame:IsShown() then
            return
        end

        characterGearFrame:TapTo(self.CharacterGearParent, 'TOPLEFT')
        characterGearFrame:Show()
    end
end

function Addon:OpenInspectGearFrame()
    if ns.db.profile.inspectGear then
        local inspectGearFrame = self:GetInspectGearFrame()
        inspectGearFrame:Show()

        if ns.db.profile.inspectCompare then
            local characterGearFrame = self:GetCharacterGearFrame()

            characterGearFrame:TapTo(inspectGearFrame, 'TOPRIGHT')
            characterGearFrame:Show()
        end
    end
end

function Addon:GetCharacters()
    if not self.characters then
        self.characters = {}

        local function TouchCharacter(name, otherAccount)
            local db = ns.db.global.userCache[name]
            if not db or not db.class then
                return
            end

            local class = select(2, GetClassInfo(db.class))
            local color = select(4, GetClassColor(class))
            local coloredName = format('|c%s%s%s|r', color, Ambiguate(name, 'none'), otherAccount and '*' or '')
            local sameRealm = ns.IsPlayerInOurRealm(name)
            local low = db.level < ns.MAX_LEVEL

            tinsert(self.characters, {
                name = name,
                coloredName = coloredName,
                class = db.class,
                level = db.level,
                low = low,
                sameRealm = sameRealm,
                otherAccount = otherAccount,
            })
        end

        local function TouchCharacters(characters, otherAccount)
            if not characters then
                return
            end
            for k in pairs(characters) do
                TouchCharacter(k, otherAccount)
            end
        end

        TouchCharacters(ns.db.global.characters)
        TouchCharacters(ns.otherCharacters, true)

        sort(self.characters, function(a, b)
            if a.level ~= b.level then
                return a.level > b.level
            end
            if a.sameRealm ~= b.sameRealm then
                return a.sameRealm
            end
            if a.otherAccount ~= b.otherAccount then
                return not a.otherAccount
            end
            if a.class ~= b.class then
                return a.class < b.class
            end
            return a.level > b.level
        end)
    end
    return self.characters
end

function Addon:InspectTarget()
    InspectUnit('target')
end

function Addon:InspectMouseover()
    local unit = select(2, GameTooltip:GetUnit())
    if unit and not UnitExists(unit) then
        unit = 'mouseover'
    end
    if not UnitExists(unit) then
        unit = 'target'
    end
    if unit == 'mouseover' then
        local guid = UnitGUID(unit)
        if guid then
            unit = UnitTokenFromGUID(guid) or unit
        end
    end
    if not unit then
        return
    end
    InspectUnit(unit)
end

if not InspectTalentFrameSpentPoints then
    InspectTalentFrameSpentPoints = {SetPoint = nop}
end
