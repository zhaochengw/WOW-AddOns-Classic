-- tdBag2.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/17/2019, 12:04:55 AM
--
---- LUA
local format = string.format
local ipairs, pairs, tinsert, sort = ipairs, pairs, tinsert, sort
local ripairs = ipairs_reverse
local tInvert = tInvert
local tremove = table.remove
local assert = assert

local C = LibStub('C_Everywhere')

---- WOW
local CreateFrame = CreateFrame
local UnitFullName = UnitFullName
local GetAutoCompleteRealms = GetAutoCompleteRealms

local SEARCH = SEARCH

---- UI
local BankFrame = BankFrame
local UIParent = UIParent

---@class ns
-- modules
---@field Events Events
---@field Forever Forever
---@field Tooltip Tooltip
---@field GlobalSearch GlobalSearch
---@field Counter Counter
---@field Cache Cache
-- classes
---@field Thread Thread
---@field Cacher Addon.Cacher
---@field FrameMeta FrameMeta
local ns = select(2, ...)

local L = ns.L
local BAG_ID = ns.BAG_ID

local safeipairs = ns.safeipairs

BINDING_CATEGORY_TDBAG2 = C.AddOns.GetAddOnMetadata('tdBag2', 'Title')
BINDING_NAME_TDBAG2_TOGGLE_BAG = L.TOOLTIP_TOGGLE_BAG
BINDING_NAME_TDBAG2_TOGGLE_BANK = L.TOOLTIP_TOGGLE_BANK
BINDING_NAME_TDBAG2_TOGGLE_MAIL = L.TOOLTIP_TOGGLE_MAIL
BINDING_NAME_TDBAG2_TOGGLE_GLOBAL_SEARCH = L.TOOLTIP_TOGGLE_GLOBAL_SEARCH

---@class UI
---@field Container UI.Container
---@field ItemBase UI.ItemBase
---@field BagToggle UI.BagToggle
---@field SearchToggle UI.SearchToggle
---@field Bag UI.Bag
---@field MenuButton UI.MenuButton
---@field TitleFrame UI.TitleFrame
---@field Frame UI.Frame
---@field GlobalSearchBox UI.GlobalSearchBox
---@field Token UI.Token
---@field TokenFrame UI.TokenFrame
---@field TitleContainer UI.TitleContainer
---@field MoneyFrame UI.MoneyFrame
---@field BagFrame UI.BagFrame
---@field PluginFrame UI.PluginFrame
---@field SimpleFrame UI.SimpleFrame
---@field ContainerFrame UI.ContainerFrame
---@field OwnerSelector UI.OwnerSelector
---@field SearchBox UI.SearchBox
---@field EquipBagToggle UI.EquipBagToggle
ns.UI = {}
ns.Search = LibStub('ItemSearch-1.3')
ns.Unfit = LibStub('Unfit-1.0')

---@class Addon: AceAddon, LibClass-2.0, AceHook-3.0, AceEvent-3.0
local Addon = LibStub('AceAddon-3.0'):NewAddon('tdBag2', 'LibClass-2.0', 'AceHook-3.0', 'AceEvent-3.0')
ns.Addon = Addon
_G.tdBag2 = Addon

Addon.BAG_ID = BAG_ID

function Addon:OnInitialize()
    self.styles = {}
    self.demandStyles = {}
    self.frames = {}
    self.plugins = {}

    self:SetupBankHider()
    self:SetupDefaultStyles()

    self:RegisterMessage('FOREVER_LOADED')
end

function Addon:OnEnable()
    ns.PLAYER = format('%s-%s', UnitFullName('player'))
    ns.REALMS = (function()
        local realms = GetAutoCompleteRealms()
        if realms and realms[1] then
            return realms
        end
        return {ns.GetNormalizedRealmName()}
    end)()
    ns.REALM = ns.REALMS[1]

    self:SetupDatabase()
    self:ScanPluginAddons()
    self:SetupCurrentStyle()
    self:SetupDefaultOptions()
    self:CleanDeprecatedOptions()

    self:SetupOptionFrame()
    self:SetupPluginButtons()
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

function Addon:FOREVER_LOADED()
    for _, owner in ipairs(ns.Forever:GetOwners()) do
        if not ns.IsGuildOwner(owner) then
            self:SetupCharacterOptions(owner)
        end
    end
end

function Addon:OnProfileChanged()
    self:SetupDefaultOptions()
    self:UpdateAllFrameMeta()
    self:UpdateAllManaged()
    self:UpdateAllPosition()
    self:UpdateAll()
end

function Addon:ScanPluginAddons()
    for i = 1, C.AddOns.GetNumAddOns() do
        local name, _, _, _, reason = C.AddOns.GetAddOnInfo(i)
        if reason == 'DEMAND_LOADED' then
            local styleName = C.AddOns.GetAddOnMetadata(i, 'X-tdBag2-Style')
            if styleName then
                self.demandStyles[styleName] = name
            end
        end
    end
end

function Addon:SetupCurrentStyle()
    local style
    for _, styleName in ipairs {self.db.profile.style, ns.DEFAULT_STYLE} do
        local addon = self.demandStyles[styleName]
        if addon then
            C.AddOns.LoadAddOn(addon)
        end

        style = self.styles[styleName]
        if style then
            self.styleName = styleName
            break
        end
    end

    if self.styleName ~= self.db.profile.style then
        self.styleInProfileLosed = self.db.profile.style
    end

    if style.overrides then
        for className, overrides in pairs(style.overrides) do
            local class = ns.UI[className]

            for k, v in pairs(overrides) do
                class[k] = v
            end
        end
    end

    if style.hooks then
        for className, hooks in pairs(style.hooks) do
            local class = ns.UI[className]

            for k, v in pairs(hooks) do
                ns.Hook(class, k, v)
            end
        end
    end

    self.borderStyle = self.db.profile.borderStyle
end

function Addon:SetupDatabase()
    ---@class Db: Database, AceDBObject-3.0
    self.db = LibStub('AceDB-3.0'):New('TDDB_BAG2', ns.PROFILE, true)

    local function OnProfileChanged()
        self:OnProfileChanged()
    end

    local function OnDatabaseShutdown()
        local characters = self.db.global.characters
        for k, v in pairs(characters) do
            characters[k] = ns.RemoveDefaults(v, ns.CHARACTER_PROFILE)
        end
    end

    self.db:RegisterCallback('OnProfileChanged', OnProfileChanged)
    self.db:RegisterCallback('OnProfileReset', OnProfileChanged)
    self.db:RegisterCallback('OnDatabaseShutdown', OnDatabaseShutdown)
end

function Addon:CleanDeprecatedOptions()
    self.db.global.quickfix = nil

    self.db.profile.tokens = nil

    if self.db.profile.iconChar then
        for _, bagId in pairs(ns.BAG_ID) do
            self.db.profile.frames[bagId].iconCharacter = true
        end
        self.db.profile.iconChar = nil
    end

    local remainLimit = self.db.profile.frames[BAG_ID.MAIL].remainLimit
    if remainLimit then
        self.db.profile.remainLimit = remainLimit
        self.db.profile.frames[BAG_ID.MAIL].remainLimit = nil
    end
end

function Addon:SetupDefaultOptions()
    local searches = self.db.profile.searches
    if searches.first then
        searches.first = false

        local types = { --
            Enum.ItemClass.Weapon, --
            Enum.ItemClass.Armor, --
            Enum.ItemClass.Consumable, --
            Enum.ItemClass.Tradegoods, --
            Enum.ItemClass.Reagent, --
        }

        for _, item in ipairs(types) do
            tinsert(searches, (C.Item.GetItemClassInfo(item)))
        end
    end
end

function Addon:SetupCharacterOptions(owner)
    local characters = self.db.global.characters
    local realm, name = ns.GetOwnerAddress(owner)
    local profileKey = ns.GetCharacterProfileKey(name, realm)

    characters[profileKey] = ns.CopyDefaults(characters[profileKey], ns.CHARACTER_PROFILE)

    local character = characters[profileKey]
    local watches = character.watches
    if watches.first then
        watches.first = false

        local ownerInfo = ns.Cache:GetOwnerInfo(owner)
        local class = ownerInfo.class
        local defaultWatches = ns.DEFAULT_WATCHES[class]
        if defaultWatches then
            for _, itemId in ipairs(defaultWatches) do
                tinsert(watches, {itemId = itemId})
            end
        end

        if not ns.FEATURE_CURRENCY then
            for _, itemId in ipairs(ns.TOKENS) do
                tinsert(watches, {itemId = itemId})
            end
        end
    end

    if not character.version or character.version < 20200 then
        local oldTokens = tInvert(ns.TOKENS)

        for i, v in ripairs(watches) do
            if oldTokens[v.itemId] then
                tremove(watches, i)
            end
        end
    end

    character.version = ns.VERSION
end

function Addon:SetupBankHider()
    self.BankHider = CreateFrame('Frame')
    self.BankHider:Hide()

    BankFrame:UnregisterAllEvents()
    BankFrame:SetScript('OnShow', nil)
    BankFrame:SetParent(self.BankHider)
    BankFrame:ClearAllPoints()
    BankFrame:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 0, 0)
    BankFrame:SetSize(1, 1)
end

function Addon:SetupPluginButtons()
    if C.AddOns.IsAddOnLoaded('tdPack2') then
        ---@type any
        local tdPack2 = LibStub('AceAddon-3.0'):GetAddon('tdPack2', true)
        if tdPack2 then
            self:RegisterPlugin({
                type = 'Button',
                key = 'tdPack2',
                icon = [[Interface\AddOns\tdPack2\Resource\INV_Pet_Broom]],
                init = function(button, frame)
                    return tdPack2:SetupButton(button, frame.meta.bagId == BAG_ID.BANK)
                end,
            })
        end
    end

    self:RegisterPlugin({
        type = 'Button',
        key = 'BagToggle',
        text = L['Bag Toggle'],
        icon = ns.BAG_ICONS[ns.BAG_ID.BAG],
        order = 10000,
        init = function(button, frame)
            return ns.UI.BagToggle:Bind(button, frame.meta)
        end,
    })

    self:RegisterPlugin({
        type = 'Button',
        key = 'SearchToggle',
        text = SEARCH,
        icon = [[Interface\Minimap\Tracking\None]],
        order = 10001,
        init = function(button, frame)
            return ns.UI.SearchToggle:Bind(button, frame.meta)
        end,
    })

    if C_Container.SortBags then
        self:RegisterPlugin{
            type = 'Button',
            key = 'Sort',
            text = BAG_CLEANUP_BAGS,
            icon = [[Interface\Icons\INV_Pet_Broom]],
            order = 10002,
            init = function(button, frame)
                return ns.UI.SortButton:Bind(button, frame.meta)
            end,
        }
    end
end

function Addon:GetFrameProfile(bagId)
    return self.db.profile.frames[bagId]
end

function Addon:CreateFrame(bagId)
    local frame = ns.FrameMeta:New(bagId).frame
    self.frames[bagId] = frame
    return frame
end

function Addon:GetFrame(bagId)
    return self.frames[bagId]
end

function Addon:GetFrameMeta(bagId)
    local frame = self.frames[bagId]
    if frame then
        return frame.meta
    end
end

function Addon:ShowFrame(bagId, manual)
    local frame = self:GetFrame(bagId) or self:CreateFrame(bagId)
    if frame and not frame:IsShown() then
        frame.manual = manual
        ns.ShowUIPanel(frame)
    end
end

function Addon:HideFrame(bagId, manual)
    local frame = self:GetFrame(bagId)
    if frame and (manual or not frame.manual) then
        ns.HideUIPanel(frame)
    end
end

function Addon:ToggleFrame(bagId, manual)
    local frame = self:GetFrame(bagId)
    if not frame or not frame:IsShown() then
        self:ShowFrame(bagId, manual)
    else
        self:HideFrame(bagId, manual)
    end
end

function Addon:IsFrameShown(bagId)
    local frame = self:GetFrame(bagId)
    return frame and frame:IsShown()
end

function Addon:ToggleOwnerFrame(bagId, owner)
    local frame = self:GetFrame(bagId) or self:CreateFrame(bagId)
    if not frame:IsShown() or frame.meta.owner ~= owner then
        self:ShowFrame(bagId, true)
        self:SetFrameOwner(bagId, owner)
    else
        self:HideFrame(bagId, true)
    end
end

---- update

function Addon:UpdateAll()
    ns.Events:Fire('UPDATE_ALL')
end

function Addon:UpdateAllManaged()
    for _, frame in pairs(self.frames) do
        frame:UpdateManaged()
    end
end

function Addon:UpdateAllFrameMeta()
    for k, frame in pairs(self.frames) do
        frame.meta:Update()
    end
end

function Addon:UpdateAllPosition()
    for _, frame in pairs(self.frames) do
        frame:UpdatePosition()
    end
end

---- owner

function Addon:SetFrameOwner(bagId, owner)
    if not bagId then
        self:SetFrameOwner(BAG_ID.BAG, nil)
        self:SetFrameOwner(BAG_ID.BANK, nil)
    else
        local frame = self:GetFrame(bagId)
        if frame then
            frame.meta:SetOwner(owner)
        end
    end
end

---- focus bag

function Addon:FocusBag(bag)
    self.focusBag = bag
    ns.Events:Fire('BAG_FOCUS_UPDATED', bag)
end

function Addon:IsBagFocused(bag)
    return self.focusBag == bag
end

---- search

function Addon:SetSearch(text)
    if text and text:trim() == '' then
        text = nil
    end
    if self.searchText ~= text then
        self.searchText = text
        ns.Events:Fire('SEARCH_CHANGED')
    end
end

function Addon:GetSearch()
    return self.searchText
end

---- character database

function Addon:GetCharacterProfile(owner)
    local realm, name = ns.GetOwnerAddress(owner)
    local key = ns.GetCharacterProfileKey(name, realm)
    return self.db.global.characters[key] or ns.CHARACTER_PROFILE
end

---- plugin buttons

function Addon:IteratePluginButtons()
    return safeipairs(self.plugins.Button)
end

function Addon:RegisterPluginButton(opts)
    opts.type = 'Button'
    return self:RegisterPlugin(opts)
end

-- style

function Addon:RegisterStyle(styleName, style)
    self.demandStyles[styleName] = nil
    self.styles[styleName] = style
end

function Addon:GetCurrentStyle()
    return self.styles[self.styleName]
end

-- item plugin

function Addon:IterateItemPlugins()
    return safeipairs(self.plugins.Item)
end

function Addon:IterateItemSyncPlugins()

end

function Addon:IterateItemAsyncPlugins()

end

function Addon:HasAnyItemPlugin()
    return not not self.plugins.Item
end

--- plugin
---@param opts tdBag2PluginOptions
function Addon:RegisterPlugin(opts)
    if opts.type == 'Button' then
        ---@type tdBag2ButtonPluginOptions[]
        self.plugins.Button = self.plugins.Button or {}

        opts.order = opts.order or #self.plugins.Button
        opts.text = opts.text or opts.key

        tinsert(self.plugins.Button, opts)
        sort(self.plugins.Button, function(a, b)
            return a.order < b.order
        end)
    elseif opts.type == 'Item' then
        ---@type tdBag2ItemPluginOptions
        self.plugins.Item = self.plugins.Item or {}

        tinsert(self.plugins.Item, opts)
    else
        assert(false)
    end

    self:SetupPluginOptions(opts)

    if self.RefreshPluginOptions then
        self:RefreshPluginOptions()
    end
end

---@generic T
---@param key string
---@param default T
---@return T
function Addon:RegisterProfile(key, default)
    ns.PROFILE.profile.plugins[key] = CopyTable(default)

    return setmetatable({}, {
        __index = function(_, k)
            return self.db.profile.plugins[key][k]
        end,
        __newindex = function(_, k, v)
            self.db.profile.plugins[key][k] = v
            self:UpdateAll()
        end,
    })
end
