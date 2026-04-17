--[[
    Ackis Recipe List - Core
    Main addon initialization, event handling, and scanning logic

    Provides:
    - AceAddon lifecycle management (OnInitialize, OnEnable, OnDisable)
    - Trade skill scanning and recipe detection
    - Event registration with conditional UI events
    - GameTooltip hooks for NPC recipe information
    - Database and saved variable handling
]]

-- ============================================================================
-- Upvalued Lua API
-- ============================================================================
local pairs, ipairs = _G.pairs, _G.ipairs
local select = _G.select
local tonumber, tostring = _G.tonumber, _G.tostring
local type = _G.type

local bit = _G.bit
local string = _G.string
local table = _G.table

-- ============================================================================
-- AddOn Namespace
-- ============================================================================
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):NewAddon(private.addon_name, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
addon.constants = private.constants
addon.constants.addon_name = private.addon_name
addon.Name = FOLDER_NAME
private.addon_display_name = "Ackis Recipe List Classic"
addon.name = private.addon_display_name or private.addon_name

local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local Dialog = LibStub("LibDialog-1.0")
local ldb = LibStub("LibDataBroker-1.1")
local ldbi = LibStub("LibDBIcon-1.0")

local dataBroker = ldb:NewDataObject("AckisRecipeList", {
    type = "launcher",
    label = "Ackis Recipe List",
    icon = [[Interface\Icons\INV_Misc_Book_11]],
    tocname = "AckisRecipeList",
})

function dataBroker.OnClick(_, button)
    if button == "LeftButton" then
        if addon.Frame and addon.Frame:IsVisible() then
            addon.Frame:Hide()
        else
            if private.InitializeFrame then private.InitializeFrame() end
            if addon.EnsureProfessionOpenAndScan then
                addon:EnsureProfessionOpenAndScan()
            else
                addon:Scan(false, false)
            end
        end
    elseif button == "RightButton" then
        local ACD = LibStub and LibStub("AceConfigDialog-3.0", true)
        if ACD and ACD.Open then
            ACD:Open(private.addon_name)
            if ACD.SelectGroup then ACD:SelectGroup(private.addon_name, "general") end
        end
    end
end

function dataBroker.OnTooltipShow(tt)
    tt:AddLine(private.addon_display_name or private.addon_name)
    tt:AddLine("Left-click: Toggle GUI", 0.2, 1, 0.2)
    tt:AddLine("Right-click: Options", 0.2, 1, 0.2)
end

local wow_version, wow_build_num, wow_date, wow_ui_version = private.GetBuildInfo()
private.wow_version = wow_version
private.wow_build_num = wow_build_num
private.wow_ui_version = wow_ui_version

-- NOTE: Ensure Blizzard dialog globals exist for LibDialog
-- Some client variants may not initialize StaticPopup_DisplayedFrames early
if type(_G.StaticPopup_DisplayedFrames) ~= "table" then
    _G.StaticPopup_DisplayedFrames = {}
end

-- Helper to open Blizzard options reliably
local function OpenOptions(category)
    -- Ensure options are registered
    if (not addon.optionsFrame) and addon.SetupOptions then
        addon:SetupOptions()
    end

    -- Retail-like Settings API (some clients backport this); prefer when available
    if _G.Settings and _G.Settings.OpenToCategory then
        local ACD = LibStub and LibStub("AceConfigDialog-3.0", true)
        if ACD then
            local catID = ACD.GetCategoryID and ACD:GetCategoryID(private.addon_name)
            if catID then
                _G.Settings.OpenToCategory(catID)
                return
            end
        end
    end

    -- Classic/MoP: InterfaceOptionsFrame
    local panel = category or addon.optionsFrame
    if _G.InterfaceOptionsFrame_OpenToCategory then
        -- Accept both a panel reference and the addon name
        if panel then
            _G.InterfaceOptionsFrame_OpenToCategory(panel)
            _G.InterfaceOptionsFrame_OpenToCategory(panel)
            return
        else
            local catName = (private.addon_display_name or private.addon_name)
            _G.InterfaceOptionsFrame_OpenToCategory(catName)
            _G.InterfaceOptionsFrame_OpenToCategory(catName)
            return
        end
    end

    -- Fallback: open AceConfigDialog's standalone window
    local ACD = LibStub and LibStub("AceConfigDialog-3.0", true)
    if ACD and ACD.Open then
        ACD:Open(private.addon_name)
    end
end

-- ----------------------------------------------------------------------------
-- Constants.
-- ----------------------------------------------------------------------------
local SUPPORTED_MODULE_VERSION = 4

-- ----------------------------------------------------------------------------
-- Provides a minimal C_TradeSkillUI facade using legacy APIs when needed.
-- ----------------------------------------------------------------------------
do
    if not _G.C_TradeSkillUI then
        _G.C_TradeSkillUI = {}
    end

    local CT = _G.C_TradeSkillUI

    -- GetTradeSkillLine: return values expected by this addon are sometimes (nil, localizedProfessionName)
    -- and sometimes (professionID=nil, parentSkillLineID=nil, professionRank, _, _, _, localizedProfessionName).
    -- To satisfy both call patterns, return (nil, name, rank, nil, nil, nil, name).
    -- IMPORTANT: Always wrap/replace, even if it exists, to add Craft API support

    local originalGetTradeSkillLine = CT.GetTradeSkillLine
    function CT.GetTradeSkillLine()
        local debugEnabled = false -- Set to true for troubleshooting

        --  If CraftFrame is visible, use Craft API
        if _G.CraftFrame and _G.CraftFrame:IsVisible() and _G.GetCraftName then
            local name, rank = _G.GetCraftName()
            if debugEnabled then
                print("[ARL] CraftFrame visible, GetCraftName: name=" .. tostring(name) .. ", rank=" .. tostring(rank))
            end
            if name and name ~= "" and name ~= _G.UNKNOWN then
                if debugEnabled then
                    print("[ARL] Using Craft API result: " .. tostring(name))
                end
                return nil, name, (rank or 0), nil, nil, nil, name
            end
        end

        -- PRIORITY 2: Try original function if it exists
        if originalGetTradeSkillLine then
            local profID, name, rank, maxRank, modifier, parentSkillLineID, name2 = originalGetTradeSkillLine()
            -- Use either the 2nd or 7th return value as profession name
            local profName = name or name2
            if debugEnabled then
                print("[ARL] originalGetTradeSkillLine: profID=" ..
                    tostring(profID) .. ", name=" .. tostring(profName) .. ", rank=" .. tostring(rank))
            end
            if profName and profName ~= "" and profName ~= _G.UNKNOWN then
                return profID, profName, rank, maxRank, modifier, parentSkillLineID, profName
            end
        end

        -- PRIORITY 3: Fallback to legacy GetTradeSkillLine API
        if _G.GetTradeSkillLine then
            local name, rank = _G.GetTradeSkillLine()
            if debugEnabled then
                print("[ARL] GetTradeSkillLine: name=" .. tostring(name) .. ", rank=" .. tostring(rank))
            end
            if name and name ~= "" and name ~= _G.UNKNOWN then
                return nil, name, (rank or 0), nil, nil, nil, name
            end
        end

        -- PRIORITY 4: Final fallback to Craft API (even if CraftFrame not visible)
        if _G.GetCraftName then
            local name, rank = _G.GetCraftName()
            if debugEnabled then
                print("[ARL] Final fallback GetCraftName: name=" .. tostring(name) .. ", rank=" .. tostring(rank))
            end
            if name and name ~= "" and name ~= _G.UNKNOWN then
                return nil, name, (rank or 0), nil, nil, nil, name
            end
        end

        if debugEnabled then
            print("[ARL] GetTradeSkillLine returning UNKNOWN")
        end
        return nil, _G.UNKNOWN, 0, nil, nil, nil, _G.UNKNOWN
    end

    if not CT.IsTradeSkillLinked then
        function CT.IsTradeSkillLinked()
            return (_G.IsTradeSkillLinked and _G.IsTradeSkillLinked()) or false
        end
    end

    if not CT.IsTradeSkillGuild then
        function CT.IsTradeSkillGuild()
            return (_G.IsTradeSkillGuild and _G.IsTradeSkillGuild()) or false
        end
    end

    local function ParseSpellIDFromLink(link)
        if type(link) ~= "string" then return nil end
        -- Common patterns across trade/enchant/spell links
        local id = link:match("enchant:(%d+)") or link:match("spell:(%d+)") or link:match("trade:(%d+)") or
            link:match("item:(%d+)")
        return id and tonumber(id) or nil
    end

    if not CT.GetAllRecipeIDs then
        local cachedRecipeIDs = {}

        function CT.GetAllRecipeIDs()
            table.wipe(cachedRecipeIDs)

            -- Ccheck which frame is visible to determine which API to use
            local useCraftAPI = _G.CraftFrame and _G.CraftFrame:IsVisible() and _G.GetNumCrafts

            if useCraftAPI then
                -- Use Craft API (Enchanting on Classic/TBC)
                local cNum = _G.GetNumCrafts()
                local expandCraft = _G.ExpandCraftSkillLine
                -- Expand craft headers
                if expandCraft then
                    local i = 1
                    while i <= cNum do
                        local _, craftType, _, isExpanded = _G.GetCraftInfo(i)
                        if craftType == "header" and not isExpanded then
                            expandCraft(i)
                            cNum = _G.GetNumCrafts()
                        end
                        i = i + 1
                    end
                end
                for i = 1, cNum do
                    local _, craftType = _G.GetCraftInfo(i)
                    if craftType ~= "header" and craftType ~= "subheader" then
                        local link = _G.GetCraftRecipeLink(i)
                        local spellID = ParseSpellIDFromLink(link)
                        if spellID then
                            cachedRecipeIDs[#cachedRecipeIDs + 1] = spellID
                        end
                    end
                end
            else
                -- Use TradeSkill API
                local getNum = _G.GetNumTradeSkills
                local getInfo = _G.GetTradeSkillInfo
                local getLink = _G.GetTradeSkillRecipeLink
                local getSel = _G.GetTradeSkillSelectionIndex
                local selectSkill = _G.SelectTradeSkill
                local getSpellLink = _G.GetSpellLink
                local expandSubClass = _G.ExpandTradeSkillSubClass

                local function ExpandAllTradeSkillHeaders()
                    if not (getNum and getInfo and expandSubClass) then return end
                    local n = getNum()
                    local i = 1
                    while i <= n do
                        local _, skillType, _, isExpanded = getInfo(i)
                        if skillType == "header" and not isExpanded then
                            expandSubClass(i)
                            n = getNum()
                        end
                        i = i + 1
                    end
                end

                if getNum and getInfo and getLink then
                    local n = getNum()
                    local prevSelection = getSel and getSel() or nil
                    ExpandAllTradeSkillHeaders()
                    n = getNum()
                    for i = 1, n do
                        local _, skillType = getInfo(i)
                        if skillType ~= "header" and skillType ~= "subheader" then
                            local link = getLink(i)
                            if not link and selectSkill then
                                -- On Classic/Era, some clients only return a link for the selected row
                                selectSkill(i)
                                link = getLink(i)
                            end
                            local spellID = ParseSpellIDFromLink(link)
                            -- Last resort: try to get the spell link from the currently selected spell
                            if not spellID and getSel and getSel() == i and getSpellLink and _G.GetTradeSkillInfo then
                                local skillName = select(1, getInfo(i))
                                if skillName then
                                    local sLink = getSpellLink(skillName)
                                    spellID = ParseSpellIDFromLink(sLink)
                                end
                            end
                            if spellID then
                                cachedRecipeIDs[#cachedRecipeIDs + 1] = spellID
                            end
                        end
                    end
                    -- Restore previous selection if changed
                    if prevSelection and selectSkill then
                        selectSkill(prevSelection)
                    end
                end
            end
            return cachedRecipeIDs
        end
    end

    if not CT.GetRecipeInfo then
        function CT.GetRecipeInfo(recipeID)
            local name = _G.GetSpellInfo and _G.GetSpellInfo(recipeID)
            local isLearned = false
            if name and _G.GetSpellInfo(recipeID) then
                if _G.IsPlayerSpell and _G.IsPlayerSpell(recipeID) then
                    isLearned = true
                elseif _G.IsSpellKnown and _G.IsSpellKnown(recipeID, false) then
                    isLearned = true
                end
            end
            return {
                recipeID = recipeID,
                name = name or tostring(recipeID),
                learned = isLearned,
                previousRecipeID = nil,
                nextRecipeID = nil,
            }
        end
    end

    if not CT.GetTradeSkillTexture then
        function CT.GetTradeSkillTexture()
            if private and private.CurrentProfession and private.CurrentProfession.WaypointIconTexture then
                local ok, tex = pcall(private.CurrentProfession.WaypointIconTexture, private.CurrentProfession)
                if ok and tex then
                    return tex
                end
            end
            -- Fallback
            return [[Interface\Icons\INV_Misc_Book_11]]
        end
    end
end

-- ----------------------------------------------------------------------------
-- Dialogs.
-- ----------------------------------------------------------------------------
Dialog:Register("ARL_ModuleErrorDialog", {
    buttons = {
        {
            text = _G.OKAY
        },
    },
    show_while_dead = true,
    hide_on_escape = true,
    icon = [[Interface\DialogFrame\UI-Dialog-Icon-AlertNew]],
    text_justify_h = "LEFT",
    width = 400,
    on_show = function(self, profession_name)
        self.text:SetFormattedText("%s - %s\n\n%s", (private.addon_display_name or private.addon_name), addon.version,
            L.MODULE_ERROR_FORMAT:format(profession_name))
    end
})

Dialog:Register("ARL_ModuleWrongVersionDialog", {
    buttons = {
        {
            text = _G.OKAY
        },
    },
    show_while_dead = true,
    hide_on_escape = true,
    icon = [[Interface\DialogFrame\UI-Dialog-Icon-AlertNew]],
    is_exclusive = true,
    text_justify_h = "LEFT",
    width = 400,
    on_show = function(self, data)
        self.text:SetFormattedText("%s - %s\n\n%s", (private.addon_display_name or private.addon_name), addon.version,
            L.MODULE_WRONG_VERSION_FORMAT:format(data.moduleName, data.moduleVersion, SUPPORTED_MODULE_VERSION))
    end
})

-- Invoked from the module itself.
function addon:SpawnModuleWrongVersionDialog(data)
    Dialog:Spawn("ARL_ModuleWrongVersionDialog", data)
end

Dialog:Register("ARL_NoModulesErrorDialog", {
    buttons = {
        {
            text = _G.OKAY
        },
    },
    show_while_dead = true,
    hide_on_escape = true,
    icon = [[Interface\DialogFrame\UI-Dialog-Icon-AlertNew]],
    text_justify_h = "LEFT",
    width = 400,
    on_show = function(self)
        -- Profession Module not found pop-up.
        self.text:SetFormattedText(
            "No profession module AddOns were found.\n\nEach profession is a separate modular AddOn. You can find and install them on CurseForge or via the Ackis Recipe List Classic page, which lists links to all profession modules."
        )
    end
})

Dialog:Register("ARL_MissingProfessionModuleDialog", {
    buttons = {
        {
            text = _G.OKAY
        },
    },
    show_while_dead = true,
    hide_on_escape = true,
    icon = [[Interface\DialogFrame\UI-Dialog-Icon-AlertNew]],
    text_justify_h = "LEFT",
    width = 420,
    on_show = function(self, data)
        local prof = data and data.localizedProfessionName or "this profession"
        local moduleName = data and data.moduleName or "(unknown)"
        self.text:SetFormattedText(
            "%s - %s\n\nThe profession module for %s is not installed.\n\nInstall the AddOn \"%s\" to view recipes for this profession. You can find it on CurseForge or via the Ackis Recipe List Classic page.",
            (private.addon_display_name or private.addon_name), addon.version, prof, moduleName
        )
    end
})

-- ----------------------------------------------------------------------------
-- Database tables
-- ----------------------------------------------------------------------------
local AllSpecialtiesTable = {}
local SpecialtyTable

-- Cached tables for performance (avoid allocations in hot paths)
local candidateSpellNames = {}

-- Global Frame Variables
addon.optionsFrame = {}

-- ----------------------------------------------------------------------------
-- Debugger.
-- ----------------------------------------------------------------------------
function addon:Debug(...)
    -- Debug disabled - no output for end users
    return
end

-- ----------------------------------------------------------------------------
-- Initialization functions
-- ----------------------------------------------------------------------------
local REQUIRED_LIBS = {
    "AceLocale-3.0",
}

function addon:OnInitialize()
    -- ----------------------------------------------------------------------------
    -- Check to see if we have mandatory libraries loaded. If not, notify the user
    -- which are missing and return.
    -- ----------------------------------------------------------------------------
    local missing_libraries = false

    for index = 1, #REQUIRED_LIBS do
        local library_name = REQUIRED_LIBS[index]

        if not LibStub:GetLibrary(library_name, true) then
            missing_libraries = true
            addon:Print(L["MISSING_LIBRARY"]:format(library_name))
        end
    end
    REQUIRED_LIBS = nil

    if missing_libraries then
        return
    end

    -- Register slash commands early so they are always available
    self:RegisterChatCommand("arl", "ChatCommand")
    self:RegisterChatCommand("ackisrecipelist", "ChatCommand")


    -- Set default options, which are to include everything in the scan
    local defaults = {
        global = {
            -- Saving alts tradeskills (needs to be global so all profiles can access it) TODO: Remove everything having to do with this, since Blizzard killed the functionality sometime during WoW 5.x
            tradeskill = {},
        },
        profile = {
            -- ----------------------------------------------------------------------------
            -- Frame options
            -- ----------------------------------------------------------------------------
            frameopts = {
                offsetx = 0,
                offsety = 0,
                anchorTo = "",
                anchorFrom = "",
                uiscale = 1,
                small_list_font = true,
            },

            -- Minimap icon state (LibDBIcon compatible)
            minimapIcon = { hide = false },

            -- ----------------------------------------------------------------------------
            -- Tooltip Options
            -- ----------------------------------------------------------------------------
            tooltip = {
                scale = 1,
                acquire_fontsize = 11,
            },
            -- ----------------------------------------------------------------------------
            -- Sorting Options
            -- ----------------------------------------------------------------------------
            sorting = "Ascending",
            current_tab = 3,    -- Name tab
            skill_view = false, -- Sort the recipes by skill level instead of name?

            -- ----------------------------------------------------------------------------
            -- Display Options
            -- ----------------------------------------------------------------------------
            includefiltered = false,
            includeexcluded = false,
            closeguionskillclose = false,
            ignoreexclusionlist = false,
            scanbuttonlocation = "TR",
            spelltooltiplocation = "Right",
            acquiretooltiplocation = "Right",
            recipes_in_tooltips = true,
            max_recipes_in_tooltips = 10,
            hide_tooltip_hint = false,
            hidepopup = false,
            minimap = true,
            worldmap = true,
            autoscanmap = false,
            scantrainers = false,
            scanvendors = false,
            autoloaddb = false,
            maptrainer = true,
            mapvendor = true,
            mapmob = false,
            mapquest = false,

            -- ----------------------------------------------------------------------------
            -- Retain SV key if present but unused

            -- ----------------------------------------------------------------------------
            -- Recipe Exclusion
            -- ----------------------------------------------------------------------------
            exclusionlist = {},

            -- ----------------------------------------------------------------------------
            -- Filter Options
            -- ----------------------------------------------------------------------------
            filters = {
                -- ----------------------------------------------------------------------------
                -- General Filters
                -- ----------------------------------------------------------------------------
                general = {
                    faction = true,
                    specialty = false,
                    skill = true,
                    known = false,
                    unknown = true,
                },
                -- ----------------------------------------------------------------------------
                -- Obtain Filters
                -- ----------------------------------------------------------------------------
                obtain = {
                    achievement = true,
                    custom = true,
                    discovery = true,
                    instance = true,
                    mobdrop = true,
                    pvp = true,
                    quest = true,
                    raid = true,
                    reputation = true,
                    retired = false,
                    trainer = true,
                    vendor = true,
                    worlddrop = true,
                    worldevent = true,
                    tradeskill = true,
                    mixed = true,
                },
                -- ----------------------------------------------------------------------------
                -- Profession Item Filters
                -- ----------------------------------------------------------------------------
                item = { -- These are populated from the item flags defined in profession modules.
                },
                -- ----------------------------------------------------------------------------
                -- Quality Filters
                -- ----------------------------------------------------------------------------
                quality = {
                    common = true,
                    uncommon = true,
                    rare = true,
                    epic = true,
                },
                -- ----------------------------------------------------------------------------
                -- Binding Filters
                -- ----------------------------------------------------------------------------
                binding = {
                    item_bind_on_equip = true,
                    item_bind_on_pickup = true,
                    recipe_bind_on_equip = true,
                    recipe_bind_on_pickup = true,
                },
                -- ----------------------------------------------------------------------------
                -- Player Role Filters
                -- ----------------------------------------------------------------------------
                player = {
                    caster = true,
                    healer = true,
                    melee = true,
                    tank = true,
                },
                -- ----------------------------------------------------------------------------
                -- Reputation Filters
                -- ----------------------------------------------------------------------------
                rep = { -- These are populated from the reputations defined in Constants.lua
                },
                -- ----------------------------------------------------------------------------
                -- Class Filters
                -- ----------------------------------------------------------------------------
                classes = {
                    deathknight = true,
                    druid = true,
                    hunter = true,
                    mage = true,
                    paladin = true,
                    priest = true,
                    rogue = true,
                    shaman = true,
                    warlock = true,
                    warrior = true,
                    -- monk and demonhunter default values may be overridden below based on client expansion
                    monk = true,
                    demonhunter = true,
                },
            }
        }
    }

    self.SUPPORTED_MODULE_VERSION = SUPPORTED_MODULE_VERSION

    -- Enable only expansions up to the current client expansion (MoP Classic); later ones stay off
    local effectiveExpansion = private.GetEffectiveExpansionID() or #private.GAME_VERSION_NAMES

    -- Gate classes by expansion for defaults: hide Monk pre-MoP and Demon Hunter pre-Legion
    if effectiveExpansion < addon.constants.GAME_VERSIONS.MOP then
        defaults.profile.filters.classes.monk = false
    end
    if effectiveExpansion < addon.constants.GAME_VERSIONS.LEGION then
        defaults.profile.filters.classes.demonhunter = false
    end
    for index = 1, #private.GAME_VERSION_NAMES do
        local expName = ("expansion%d"):format(index - 1)
        defaults.profile.filters.obtain[expName] = (index <= effectiveExpansion)
    end

    for index = 1, #private.REP_FLAGS do
        for reputation_name in pairs(private.REP_FLAGS[index]) do
            defaults.profile.filters.rep[reputation_name:lower()] = true
        end
    end

    for filter_name in pairs(self.constants.ITEM_FILTER_TYPES) do
        defaults.profile.filters.item[filter_name:lower()] = true
    end

    self.db = LibStub("AceDB-3.0"):New("ARLDB2", defaults)
    if not self.db then
        self:Print(
            "Error: Database not loaded correctly.  Please exit out of WoW and delete the ARL database file (AckisRecipeList.lua) found in: \\World of Warcraft\\WTF\\Account\\<Account Name>>\\SavedVariables\\")
        return
    end

    -- Hard gate: ensure expansions beyond the current client expansion remain disabled even if present in SV
    do
        local eff = private.GetEffectiveExpansionID() or #private.GAME_VERSION_NAMES
        for idx = eff + 1, #private.GAME_VERSION_NAMES do
            local expKey = ("expansion%d"):format(idx - 1)
            if self.db.profile and self.db.profile.filters and self.db.profile.filters.obtain then
                self.db.profile.filters.obtain[expKey] = false
            end
        end

        -- Also enforce class gating in SV
        if self.db and self.db.profile and self.db.profile.filters and self.db.profile.filters.classes then
            if eff < addon.constants.GAME_VERSIONS.MOP then
                self.db.profile.filters.classes.monk = false
            end
            if eff < addon.constants.GAME_VERSIONS.LEGION then
                self.db.profile.filters.classes.demonhunter = false
            end
        end
    end

    -- LibDBIcon minimap button setup
    ldbi:Register("AckisRecipeList", dataBroker, self.db.profile.minimapIcon)

    private.db = self.db

    local version = private.GetAddOnMetadata("AckisRecipeList", "Version")
    self.version = version
    self:SetupOptions()

    -- ----------------------------------------------------------------------------
    -- Hook GameTooltip to show recipe information on mobs that drop/sell/train
    -- ----------------------------------------------------------------------------
    local npcRecipeCache = {}
    local lastCacheTime = 0
    local CACHE_DURATION = 30

    local function GetNPCRecipeList(npcID)
        local now = _G.GetTime()
        local cached = npcRecipeCache[npcID]
        if cached and (now - cached.time) < CACHE_DURATION then
            return cached.recipes
        end
        return nil
    end

    local function CacheNPCRecipes(npcID, unit)
        if not unit or not unit.item_list then
            return nil
        end
        local recipes = {}
        local count = 0
        for spell_id in pairs(unit.item_list) do
            local recipe = private.recipe_list[spell_id]
            if recipe then
                count = count + 1
                recipes[count] = recipe
            end
        end
        npcRecipeCache[npcID] = {
            recipes = recipes,
            time = _G.GetTime()
        }
        return recipes
    end

    local function AddRecipeLine(tooltip, recipe)
        local qualityID = recipe:QualityID()
        local hex = "ffffffff"
        if _G.GetItemQualityColor then
            local ok, r, g, b, h = pcall(_G.GetItemQualityColor, qualityID)
            if ok and h then
                hex = h
            end
        end

        local professionName = recipe.Profession and recipe.Profession:LocalizedName() or UNKNOWN
        local recipeName = recipe:LocalizedName() or UNKNOWN
        local skillLevel = recipe.skill_level or 0

        tooltip:AddLine(("%s: |c%s%s|r (%d)"):format(professionName, hex, recipeName, skillLevel))
    end

    _G.GameTooltip:HookScript("OnTooltipSetUnit", function(tooltip)
        if not addon.db.profile.recipes_in_tooltips then
            return
        end

        local _, tooltipUnit = tooltip:GetUnit()
        if not tooltipUnit then
            return
        end

        local guid = _G.UnitGUID(tooltipUnit)
        if not guid then
            return
        end

        local npcID = private.MobGUIDToIDNum(guid)
        if not npcID then
            return
        end

        local recipes = GetNPCRecipeList(npcID)
        if not recipes then
            local unit = private.AcquireTypes.MobDrop:GetEntity(npcID)
                or private.AcquireTypes.Vendor:GetEntity(npcID)
                or private.AcquireTypes.Trainer:GetEntity(npcID)
                or private.AcquireTypes.Mixed:GetEntity(npcID)

            if not unit then
                npcRecipeCache[npcID] = { recipes = {}, time = _G.GetTime() }
                return
            end

            recipes = CacheNPCRecipes(npcID, unit)
            if not recipes or #recipes == 0 then
                return
            end
        end

        if #recipes == 0 then
            return
        end

        local player = private.Player
        local maxRecipes = addon.db.profile.max_recipes_in_tooltips or 10
        local showAll = _G.IsShiftKeyDown()
        local addedCount = 0

        for i = 1, #recipes do
            local recipe = recipes[i]
            local professionName = recipe.Profession and recipe.Profession:LocalizedName()

            if professionName and player.scanned_professions[professionName] then
                local skillLevel = player.professions[professionName]
                local hasLevel = skillLevel and (type(skillLevel) == "boolean" or skillLevel >= (recipe.skill_level or 0))

                local isKnown = recipe.HasState and recipe:HasState("KNOWN")
                local hasFaction = player.HasRecipeFaction and player:HasRecipeFaction(recipe)

                if (showAll or (not isKnown and hasLevel)) and hasFaction then
                    AddRecipeLine(tooltip, recipe)
                    addedCount = addedCount + 1

                    if addedCount >= maxRecipes then
                        break
                    end
                end
            end
        end
    end)
end

function addon:UpdateMinimapIcon()
    ldbi:Refresh("AckisRecipeList", self.db and self.db.profile and self.db.profile.minimapIcon)
end

-- Function run when the addon is enabled.  Registers events and pre-loads certain variables.
function addon:OnEnable()
    self.AcquireTypes = private.AcquireTypes

    -- Base events - always needed
    self:RegisterEvent("TRADE_SKILL_SHOW")
    self:RegisterEvent("TRADE_SKILL_CLOSE")
    self:RegisterEvent("CRAFT_SHOW")
    self:RegisterEvent("CRAFT_CLOSE")
    self:RegisterEvent("CRAFT_UPDATE")

    if addon.db.profile.scantrainers then
        self:RegisterEvent("TRAINER_SHOW")
    end

    if addon.db.profile.scanvendors then
        self:RegisterEvent("MERCHANT_SHOW")
    end

    private.Player:Initialize()

    -- ----------------------------------------------------------------------------
    -- Initialize the SpecialtyTable and AllSpecialtiesTable.
    -- ----------------------------------------------------------------------------
    do
        local EngineeringSpec = {
            [private.GetSpellName(20219)] = 20219, -- Gnomish
            [private.GetSpellName(20222)] = 20222, -- Goblin
        }

        SpecialtyTable = {
            [private.LOCALIZED_PROFESSION_NAMES.ENGINEERING] = EngineeringSpec,
        }

        for i in pairs(EngineeringSpec) do
            AllSpecialtiesTable[i] = true
        end
    end
end

-- ============================================================================
-- CONDITIONAL UI EVENTS
-- Events registered only when the main panel is visible.
-- This reduces event dispatch overhead when the UI is hidden.
-- Called from Panel.lua OnShow/OnHide handlers.
-- ============================================================================

local uiEventsRegistered = false

--- Register UI events when the main panel is shown
--- @return void
function private.RegisterUIEvents()
    if uiEventsRegistered then return end
    uiEventsRegistered = true

    addon:RegisterEvent("TRADE_SKILL_LIST_UPDATE")
    addon:RegisterEvent("NEW_RECIPE_LEARNED")
    addon:RegisterEvent("TRADE_SKILL_UPDATE")
    addon:RegisterEvent("CHAT_MSG_SYSTEM")
end

--- Unregister UI events when the main panel is hidden
--- @return void
function private.UnregisterUIEvents()
    if not uiEventsRegistered then return end
    uiEventsRegistered = false

    addon:UnregisterEvent("TRADE_SKILL_LIST_UPDATE")
    addon:UnregisterEvent("NEW_RECIPE_LEARNED")
    addon:UnregisterEvent("TRADE_SKILL_UPDATE")
    addon:UnregisterEvent("CHAT_MSG_SYSTEM")
end

-- ============================================================================
-- ADDON LIFECYCLE
-- ============================================================================

function addon:OnDisable()
    if addon.Frame then
        addon.Frame:Hide()
    end
end

-- ============================================================================
-- EVENT HANDLERS
-- ============================================================================
function addon:TRAINER_SHOW()
    self:ScanTrainerData(true)
end

function addon:MERCHANT_SHOW()
    self:ScanVendor()
end

-- ----------------------------------------------------------------------------
-- Create the scan button
-- ----------------------------------------------------------------------------
local TRADESKILL_ADDON_INITS = {
    BPM_ShowTrainerFrame = function(scanButton)
        scanButton:SetParent(_G.BPM_ShowTrainerFrame)
        scanButton:SetPoint("RIGHT", _G.BPM_ShowTrainerFrame, "LEFT", 4, 0)
        scanButton:SetWidth(scanButton:GetTextWidth() + 10)
        scanButton:Show()
    end,
    Skillet = function(scanButton)
        if not _G.Skillet:IsActive() then
            return
        end
        scanButton:SetParent(_G.SkilletFrame)
        scanButton:SetWidth(80)
        _G.Skillet:AddButtonToTradeskillWindow(scanButton)
    end,
    TSMCraftingTradeSkillFrame = function(scanButton)
        local anchor = _G.TSMCraftingTradeSkillFrame
        scanButton:SetParent(anchor)
        scanButton:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", -30, -3)
        scanButton:Show()
    end,
}

-- ============================================================================
-- PROFESSION HELPERS
-- ============================================================================

--- First Aid spell ID (used for locale-agnostic detection)
local FIRST_AID_SPELL_ID = 3273

--- Cached First Aid spell name (populated on first use)
local firstAidSpellName = nil

--- Check if a profession name is First Aid
--- First Aid has no recipes to scan, so the Scan button should be hidden.
--- @param name string The profession name to check
--- @return boolean True if the profession is First Aid
local function IsFirstAidProfessionName(name)
    if not name or name == _G.UNKNOWN then
        return false
    end

    -- Check against localized string from addon locale
    if L["First Aid"] and name == L["First Aid"] then
        return true
    end

    -- Fallback: check against spell name (works for all locales)
    if not firstAidSpellName then
        firstAidSpellName = _G.GetSpellInfo and _G.GetSpellInfo(FIRST_AID_SPELL_ID)
    end

    return firstAidSpellName and name == firstAidSpellName
end

-- ============================================================================
-- SCAN BUTTON MANAGEMENT
-- The Scan button attaches to various TradeSkill frame variants.
-- Hidden for First Aid (no recipes to scan).
-- ============================================================================

function addon:TRADE_SKILL_SHOW()
    local scanButton = self.scan_button

    -- Get current profession
    local _, localizedProfessionName = _G.C_TradeSkillUI.GetTradeSkillLine()

    -- Hide scan button for First Aid (no recipes to discover)
    if IsFirstAidProfessionName(localizedProfessionName) then
        if scanButton then
            scanButton:Hide()
        end
        return
    end

    -- Create scan button on first use
    if not scanButton then
        scanButton = self:CreateScanButton()
        self.scan_button = scanButton
    end

    -- Position the scan button based on available TradeSkill addon frames
    self:PositionScanButton(scanButton)

    -- Show button only if we have a valid profession
    if localizedProfessionName and localizedProfessionName ~= _G.UNKNOWN then
        scanButton:Show()
    else
        scanButton:Hide()
    end
end

--- Create the Scan button with click handlers and tooltips
--- @return Frame The created scan button
function addon:CreateScanButton()
    local scanButton = _G.CreateFrame("Button", nil, _G.TradeSkillFrame or _G.UIParent, "UIPanelButtonTemplate")
    scanButton:SetHeight(20)
    scanButton:RegisterForClicks("LeftButtonUp")
    scanButton:SetText(L["Scan"])

    scanButton:SetScript("OnClick", function(self, mouseButton, isDown)
        local isShiftKeyDown = _G.IsShiftKeyDown()
        local isAltKeyDown = _G.IsAltKeyDown()
        local isControlKeyDown = _G.IsControlKeyDown()

        if isAltKeyDown and not isControlKeyDown then
            -- Alt+Click: Clear all waypoints
            addon:ClearWaypoints()
        elseif not isAltKeyDown and not isControlKeyDown then
            -- Click: Scan recipes (open profession if needed)
            local _, localizedProfessionName = _G.C_TradeSkillUI.GetTradeSkillLine()
            if not localizedProfessionName or localizedProfessionName == _G.UNKNOWN then
                if private.InitializeFrame then private.InitializeFrame() end
                addon:EnsureProfessionOpenAndScan()
            else
                addon:Scan(false, false)
                if addon.db.profile.autoscanmap then
                    addon:AutoScanZoneWaypoints()
                else
                    addon:AddWaypoint()
                end
            end
        end
    end)

    scanButton:SetScript("OnEnter", function(self)
        local tooltip = _G.GameTooltip
        _G.GameTooltip_SetDefaultAnchor(tooltip, self)
        tooltip:SetText(L["SCAN_RECIPES_DESC"])
        tooltip:Show()
    end)

    scanButton:SetScript("OnLeave", _G.GameTooltip_Hide)

    return scanButton
end

--- Position the scan button based on available TradeSkill frames
--- Handles various TradeSkill addon frames (TSM, GnomeWorks, Skillet, etc.)
--- @param scanButton Frame The scan button to position
function addon:PositionScanButton(scanButton)
    -- Try to attach to a known TradeSkill addon frame first
    for entity, initFunction in pairs(TRADESKILL_ADDON_INITS) do
        if _G[entity] then
            scanButton:ClearAllPoints()
            initFunction(scanButton)
            return
        end
    end

    -- Default: attach to Blizzard TradeSkillFrame
    scanButton:Enable()

    if _G.TradeSkillFrame and scanButton:GetParent() ~= _G.TradeSkillFrame then
        scanButton:SetParent(_G.TradeSkillFrame)
    end

    if scanButton:GetParent() == _G.TradeSkillFrame then
        scanButton:ClearAllPoints()
        local scanButtonLocation = addon.db.profile.scanbuttonlocation

        if scanButtonLocation == "TR" then
            scanButton:SetPoint("RIGHT", _G.TradeSkillFrameCloseButton, "LEFT", 4, 0)
        elseif scanButtonLocation == "TL" then
            scanButton:SetPoint("LEFT", _G.TradeSkillFramePortrait, "RIGHT", 2, 12)
        elseif scanButtonLocation == "BR" then
            local details = _G.TradeSkillFrame.DetailsFrame
            if details and details.ExitButton then
                scanButton:SetPoint("TOP", details.ExitButton, "BOTTOM", 0, -5)
            else
                scanButton:SetPoint("BOTTOMRIGHT", _G.TradeSkillFrame, "BOTTOMRIGHT", -38, 10)
            end
        elseif scanButtonLocation == "BL" then
            local details = _G.TradeSkillFrame.DetailsFrame
            if details and details.CreateAllButton then
                scanButton:SetPoint("TOP", details.CreateAllButton, "BOTTOM", 0, -5)
            else
                scanButton:SetPoint("BOTTOMLEFT", _G.TradeSkillFrame, "BOTTOMLEFT", 15, 10)
            end
        end

        scanButton:SetWidth(scanButton:GetTextWidth() + 10)
    end
end

function addon:TRADE_SKILL_CLOSE()
    if self.Frame and addon.db.profile.closeguionskillclose then
        self.Frame:Hide()
    end
end

function addon:CRAFT_SHOW()
    local scanButton = self.scan_button

    if not scanButton then
        scanButton = _G.CreateFrame("Button", nil, _G.CraftFrame or _G.UIParent, "UIPanelButtonTemplate")
        scanButton:SetHeight(20)
        scanButton:RegisterForClicks("LeftButtonUp")
        scanButton:SetText(L["Scan"])

        scanButton:SetScript("OnClick", function(self, mouseButton, isDown)
            local isShiftKeyDown = _G.IsShiftKeyDown()
            local isAltKeyDown = _G.IsAltKeyDown()
            local isControlKeyDown = _G.IsControlKeyDown()

            if isAltKeyDown and not isControlKeyDown then
                addon:ClearWaypoints()
            elseif not isAltKeyDown and not isControlKeyDown then
                -- Click (with or without Shift): if no profession is open, open one and scan; otherwise scan immediately.
                local _, localizedProfessionName = _G.C_TradeSkillUI.GetTradeSkillLine()
                if not localizedProfessionName or localizedProfessionName == _G.UNKNOWN then
                    if private.InitializeFrame then private.InitializeFrame() end
                    addon:EnsureProfessionOpenAndScan()
                else
                    addon:Scan(false, false)
                    if addon.db.profile.autoscanmap then
                        addon:AutoScanZoneWaypoints()
                    else
                        addon:AddWaypoint()
                    end
                end
            end
        end)

        scanButton:SetScript("OnEnter", function(self)
            local tooltip = _G.GameTooltip

            _G.GameTooltip_SetDefaultAnchor(tooltip, self)
            tooltip:SetText(L["SCAN_RECIPES_DESC"])
            tooltip:Show()
        end)

        scanButton:SetScript("OnLeave", _G.GameTooltip_Hide)

        self.scan_button = scanButton
    end

    -- Position button for CraftFrame
    scanButton:Enable()

    if _G.CraftFrame and scanButton:GetParent() ~= _G.CraftFrame then
        scanButton:SetParent(_G.CraftFrame)
    end

    if scanButton:GetParent() == _G.CraftFrame then
        scanButton:ClearAllPoints()
        local scanButtonLocation = addon.db.profile.scanbuttonlocation

        if scanButtonLocation == "TR" then
            scanButton:SetPoint("RIGHT", _G.CraftFrameCloseButton, "LEFT", 4, 0)
        elseif scanButtonLocation == "TL" then
            scanButton:SetPoint("LEFT", _G.CraftFramePortrait, "RIGHT", 2, 12)
        elseif scanButtonLocation == "BR" then
            -- Anchor near bottom-right of the craft frame
            scanButton:SetPoint("BOTTOMRIGHT", _G.CraftFrame, "BOTTOMRIGHT", -38, 10)
        elseif scanButtonLocation == "BL" then
            -- Anchor near bottom-left of the craft frame
            scanButton:SetPoint("BOTTOMLEFT", _G.CraftFrame, "BOTTOMLEFT", 15, 10)
        end

        scanButton:SetWidth(scanButton:GetTextWidth() + 10)
    end

    local _, localizedProfessionName = _G.C_TradeSkillUI.GetTradeSkillLine()
    if localizedProfessionName and localizedProfessionName ~= _G.UNKNOWN then
        scanButton:Show()
    else
        scanButton:Hide()
    end
end

function addon:CRAFT_CLOSE()
    if self.Frame and addon.db.profile.closeguionskillclose then
        self.Frame:Hide()
    end
end

function addon:CRAFT_UPDATE()
    -- Trigger the same behavior as TRADE_SKILL_UPDATE
    self:TRADE_SKILL_UPDATE()
end

do
    local last_update = 0
    local updater = _G.CreateFrame("Frame")
    updater:Hide()

    updater:SetScript("OnUpdate", function(self, elapsed)
        last_update = last_update + elapsed

        if last_update >= 0.5 then
            local _, localizedProfessionName = _G.C_TradeSkillUI.GetTradeSkillLine()

            if localizedProfessionName ~= "UNKNOWN" then
                addon:Scan(false, true)
            end
            self:Hide()
        end
    end)

    function addon:TRADE_SKILL_LIST_UPDATE()
        if not self.Frame or not self.Frame:IsVisible() then
            return
        end

        if not updater:IsVisible() then
            last_update = 0
            updater:Show()
        end
    end

    -- Debounced refresh when a new spell/recipe is learned or the trade skill system updates
    local function DebouncedScanIfVisible()
        if not addon.Frame or not addon.Frame:IsVisible() then
            return
        end
        local _, lp = _G.C_TradeSkillUI.GetTradeSkillLine()
        if not lp or lp == _G.UNKNOWN then
            -- No profession window open: open one and scan
            if addon.EnsureProfessionOpenAndScan then
                addon:EnsureProfessionOpenAndScan()
            end
            return
        end
        if not updater:IsVisible() then
            last_update = 0
            updater:Show()
        end
    end

    function addon:LEARNED_SPELL_IN_TAB()
        DebouncedScanIfVisible()
    end

    function addon:NEW_RECIPE_LEARNED()
        DebouncedScanIfVisible()
    end

    function addon:TRADE_SKILL_UPDATE()
        DebouncedScanIfVisible()
    end

    -- Fallback: react to system learn messages by debouncing a refresh; avoid parsing locale strings
    function addon:CHAT_MSG_SYSTEM()
        DebouncedScanIfVisible()
    end
end

-- ----------------------------------------------------------------------------
-- ARL Logic Functions
-- ----------------------------------------------------------------------------
do
    local function InitializeLookups()
        addon:InitCustom()
        addon:InitDiscoveries()
        addon:InitMob()
        addon:InitQuest()
        addon:InitReputation()
        addon:InitTrainer()
        addon:InitWorldEvents()
        addon:InitVendor()
        addon:InitMixed()

        InitializeLookups = nil
    end

    -- Returns true if a profession was initialized.
    function addon:InitializeProfession(localizedProfessionName, suppressDialogs)
        -- Some professions (e.g., Cooking in MoP) can return a split skillline name (e.g., Way of the Grill).
        -- Normalize to the base localized profession name if needed.
        local professionModuleName = localizedProfessionName and
            private.LOCALIZED_PROFESSION_NAME_TO_MODULE_NAME_MAPPING[localizedProfessionName] or nil
        if not professionModuleName and private.LOCALIZED_SPELL_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING then
            local baseName = private.LOCALIZED_SPELL_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING[localizedProfessionName]
            if baseName then
                localizedProfessionName = baseName
                professionModuleName = private.LOCALIZED_PROFESSION_NAME_TO_MODULE_NAME_MAPPING[localizedProfessionName]
            end
        end
        if not professionModuleName then
            addon:Debug("Invalid profession name (%s) passed to InitializeProfession()",
                tostring(localizedProfessionName))
            return false
        end

        if InitializeLookups then
            InitializeLookups()
        end

        if private.Professions[professionModuleName] then
            return true
        end

        local professionModule = self:GetModule(professionModuleName, true)
        if not professionModule then
            local foundModule
            local moduleFolderName = FOLDER_NAME .. "_" .. (professionModuleName or "")
            local _, _, _, _, reason = private.GetAddOnInfo(moduleFolderName)

            if reason == "DISABLED" then
                if not suppressDialogs then
                    Dialog:Spawn("ARL_ModuleErrorDialog", professionModuleName)
                end
                return false
            elseif not private.LoadAddOn(moduleFolderName) then
                -- Fallback: create a minimal stub module so the UI can operate with empty data
                local label = private.LOCALIZED_PROFESSION_NAME_TO_LABEL[localizedProfessionName]
                local activationSpellID = label and addon.constants.PROFESSION_SPELL_IDS[label]
                local stub = {
                    GetName = function() return professionModuleName end,
                    ModuleName = professionModuleName,
                    Version = SUPPORTED_MODULE_VERSION,
                    IsStub = true,
                    ITEM_FILTER_TYPES = {},
                    Recipes = {},
                    ActivationSpellID = activationSpellID,
                }
                if addon.CreateProfessionFromModule then
                    addon.CreateProfessionFromModule(stub)
                end
                -- Warn the user about this specific missing profession module (once per profession per session)
                addon._missingModuleWarned = addon._missingModuleWarned or {}
                if not addon._missingModuleWarned[professionModuleName] then
                    addon._missingModuleWarned[professionModuleName] = true
                    local displayModuleName = (private.addon_display_name or private.addon_name) ..
                        ": " .. (professionModuleName or localizedProfessionName or "Unknown")
                    Dialog:Spawn("ARL_MissingProfessionModuleDialog", {
                        localizedProfessionName = localizedProfessionName,
                        moduleName = displayModuleName,
                    })
                end

                -- Only warn if truly no profession modules are present at all; avoid false positives when a specific module fails to load.
                if not addon._warnedNoModules then
                    local hasAnyModule = false
                    for modName in pairs(private.MODULE_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING or {}) do
                        local _, _, _, _, r = private.GetAddOnInfo(FOLDER_NAME .. "_" .. modName)
                        if r ~= "MISSING" then
                            hasAnyModule = true
                            break
                        end
                    end
                    if not hasAnyModule then
                        addon._warnedNoModules = true
                        if not suppressDialogs then
                            Dialog:Spawn("ARL_NoModulesErrorDialog")
                        end
                    end
                end
                return true
            end

            -- LoadOnDemand module was successfully loaded - retrieve and enable it
            professionModule = self:GetModule(professionModuleName, true)
            if professionModule then
                -- Enable the module if not already enabled to trigger OnEnable
                -- This ensures CreateProfessionFromModule is called
                local isEnabled = professionModule:IsEnabled()
                if not isEnabled then
                    professionModule:Enable()
                end
            end
            return true
        elseif professionModule.Version and professionModule.Version ~= SUPPORTED_MODULE_VERSION then
            if not suppressDialogs then
                Dialog:Spawn("ARL_ModuleWrongVersionDialog", {
                    moduleName = professionModuleName,
                    moduleVersion = professionModule.Version
                })
            end

            return false
        else
            -- Module is present and version is acceptable (or not set yet) -> success
            return true
        end
    end
end -- do-block

local SUBCOMMAND_FUNCS = {
    [L["Profile"]:lower()] = function()
        if not addon.optionsFrame or not addon.optionsFrame["Profiles"] then
            if addon.SetupOptions then addon:SetupOptions() end
        end
        if addon.optionsFrame and addon.optionsFrame["Profiles"] then
            OpenOptions(addon.optionsFrame["Profiles"])
        else
            OpenOptions(addon.optionsFrame)
        end
    end,
    [L["Scan"] and L["Scan"]:lower() or "scan"] = function()
        if private.InitializeFrame then private.InitializeFrame() end
        addon:EnsureProfessionOpenAndScan()
    end,
    scan = function()
        if private.InitializeFrame then private.InitializeFrame() end
        addon:EnsureProfessionOpenAndScan()
    end,
    -- alias for profiles
    profiles = function() return SUBCOMMAND_FUNCS[L["Profile"]:lower()]() end,
    -- Open UI by auto-opening a known profession if needed
    ui = function()
        if private.InitializeFrame then private.InitializeFrame() end
        addon:EnsureProfessionOpenAndScan()
    end,
    toggle = function()
        if private.InitializeFrame then private.InitializeFrame() end
        addon:EnsureProfessionOpenAndScan()
    end,
    -- Debug command to test GetTradeSkillLine
    test = function()
        print("|cFF00FF00=== ARL GetTradeSkillLine Test ===|r")
        print("CraftFrame exists: " .. tostring(_G.CraftFrame ~= nil))
        print("CraftFrame visible: " .. tostring(_G.CraftFrame and _G.CraftFrame:IsVisible()))
        print("TradeSkillFrame exists: " .. tostring(_G.TradeSkillFrame ~= nil))
        print("TradeSkillFrame visible: " .. tostring(_G.TradeSkillFrame and _G.TradeSkillFrame:IsVisible()))

        if _G.GetCraftName then
            local cName, cRank = _G.GetCraftName()
            print("GetCraftName(): " .. tostring(cName) .. " (rank " .. tostring(cRank) .. ")")
        else
            print("GetCraftName: NOT AVAILABLE")
        end

        if _G.GetTradeSkillLine then
            local tName, tRank = _G.GetTradeSkillLine()
            print("GetTradeSkillLine(): " .. tostring(tName) .. " (rank " .. tostring(tRank) .. ")")
        else
            print("GetTradeSkillLine: NOT AVAILABLE")
        end

        local profID, name, rank, maxRank, modifier, parentSkillLineID, name2 = _G.C_TradeSkillUI.GetTradeSkillLine()
        print("C_TradeSkillUI.GetTradeSkillLine():")
        print("  profID: " .. tostring(profID))
        print("  name (2nd): " .. tostring(name))
        print("  rank: " .. tostring(rank))
        print("  name2 (7th): " .. tostring(name2))
        print("|cFF00FF00=== End Test ===|r")
    end,

}

-- Check whether a trade skill window is open
local function IsTradeSkillOpen()
    -- Check frame visibility first (most reliable)
    local craftFrameVisible = _G.CraftFrame and _G.CraftFrame:IsVisible()
    local tradeSkillFrameVisible = _G.TradeSkillFrame and _G.TradeSkillFrame:IsVisible()

    if not craftFrameVisible and not tradeSkillFrameVisible then
        return false
    end

    -- Frame is visible, verify we can get profession name
    local _, lp = _G.C_TradeSkillUI.GetTradeSkillLine()

    -- If GetTradeSkillLine returns valid data, we're good
    if lp and lp ~= _G.UNKNOWN and lp ~= "UNKNOWN" then
        return true
    end

    -- If CraftFrame is visible but GetTradeSkillLine returned UNKNOWN,
    -- try GetCraftName directly as a last resort
    if craftFrameVisible and _G.GetCraftName then
        local craftName = _G.GetCraftName()
        if craftName and craftName ~= "" and craftName ~= _G.UNKNOWN then
            return true
        end
    end

    return false
end

function addon:ChatCommand(input)
    local arg1, arg2, arg3 = self:GetArgs(input, 3)

    if arg1 then
        arg1 = arg1:trim():lower()
    end

    -- If no args, open the ARL UI (ensure a profession is open, then scan)
    if not arg1 then
        -- Requirement: if no profession window is open, print a chat message and do not auto-open
        if not IsTradeSkillOpen() then
            self:Print("Please open a profession window first to start the scan.")
            return
        end
        if private.InitializeFrame then private.InitializeFrame() end
        self:EnsureProfessionOpenAndScan()
    elseif arg1 == "ui" or arg1 == "toggle" then
        if private.InitializeFrame then private.InitializeFrame() end
        self:EnsureProfessionOpenAndScan()
    else
        local func = SUBCOMMAND_FUNCS[arg1]
        if func then
            func(arg2)
        else
            -- Unknown subcommand: default to opening the UI (no AceConfigCmd fallback)
            if private.InitializeFrame then private.InitializeFrame() end
            addon:EnsureProfessionOpenAndScan()
        end
    end
end

-- Ensure a profession is open;
function addon:EnsureProfessionOpenAndScan()
    local _, localizedProfessionName = _G.C_TradeSkillUI.GetTradeSkillLine()
    if localizedProfessionName and localizedProfessionName ~= _G.UNKNOWN then
        self:Scan(false, false)
        if not self.scan_button then
            -- Ensure the scan button is created/positioned
            -- Check which frame is open and call the appropriate handler
            if _G.CraftFrame and _G.CraftFrame:IsVisible() then
                if self.CRAFT_SHOW then self:CRAFT_SHOW() end
            elseif _G.TradeSkillFrame and _G.TradeSkillFrame:IsVisible() then
                if self.TRADE_SKILL_SHOW then self:TRADE_SKILL_SHOW() end
            end
        end
        return
    end

    -- Find a known profession and open it; try all known candidates (skip First Aid)
    local player = private.Player
    player:UpdateProfessions()
    -- Build candidate list of spell names to try (reusing cached table)
    table.wipe(candidateSpellNames)
    local candidateCount = 0
    local function ResolveActivationSpellForName(name)
        if not name or IsFirstAidProfessionName(name) then return nil end
        if not private.Professions[name] then
            self:InitializeProfession(name)
        end
        local profession = private.Professions[name]
        -- Resolve activation spell even if the module failed to load (wrong version, disabled, missing)
        local spellName
        if profession and profession.ActivationSpellName then
            spellName = profession:ActivationSpellName()
        end
        if not spellName then
            local label = private.LOCALIZED_PROFESSION_NAME_TO_LABEL and private.LOCALIZED_PROFESSION_NAME_TO_LABEL
                [name]
            local function GetSpellNameForLabel(lbl)
                if not lbl then return nil end
                -- Special-case Mining: prefer Smelting, which opens the tradeskill UI reliably
                if lbl == 'MINING' then
                    local nm = _G.GetSpellInfo and _G.GetSpellInfo(2656)
                    if nm then return nm end
                end
                if addon.constants and addon.constants.PROFESSION_SPELL_IDS and addon.constants.PROFESSION_SPELL_IDS[lbl] then
                    return _G.GetSpellInfo and _G.GetSpellInfo(addon.constants.PROFESSION_SPELL_IDS[lbl]) or nil
                end
                return nil
            end
            spellName = GetSpellNameForLabel(label) or name
            -- Last-resort: try any expansion-specific sub-spell that maps to this profession (e.g., MoP Cooking "Way of ...")
            if (not spellName or (_G.GetSpellInfo and not _G.GetSpellInfo(spellName))) and private.LOCALIZED_SPELL_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING then
                for subSpellName, profName in pairs(private.LOCALIZED_SPELL_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING) do
                    if profName == name and _G.GetSpellInfo and _G.GetSpellInfo(subSpellName) then
                        spellName = subSpellName
                        break
                    end
                end
            end
        end
        return spellName
    end
    for pname in pairs(player.professions) do
        local sname = ResolveActivationSpellForName(pname)
        if sname then
            candidateCount = candidateCount + 1
            candidateSpellNames[candidateCount] = sname
        end
    end
    if candidateCount > 0 then
        local currentIndex = 1
        local attempts = 0
        local maxAttemptsPerCandidate = 15
        local pollFrame
        local function scheduleNextTick(callback)
            if _G.C_Timer and _G.C_Timer.After then
                _G.C_Timer.After(0.2, callback)
            else
                if not pollFrame then
                    pollFrame = _G.CreateFrame("Frame", nil, _G.UIParent)
                    pollFrame._elapsed = 0
                    pollFrame:SetScript("OnUpdate", function(self, elapsed)
                        self._elapsed = (self._elapsed or 0) + elapsed
                        if self._elapsed >= 0.2 then
                            self._elapsed = 0
                            self:Hide()
                            callback()
                        end
                    end)
                end
                pollFrame:Show()
            end
        end
        local function castCurrent()
            local spellName = candidateSpellNames[currentIndex]
            if spellName then _G.CastSpellByName(spellName) end
        end
        local function tryScan()
            attempts = attempts + 1
            local _, lp = _G.C_TradeSkillUI.GetTradeSkillLine()
            if lp and lp ~= _G.UNKNOWN then
                addon:Scan(false, false)
                if not addon.scan_button then
                    -- Check which frame is open and call the appropriate handler
                    if _G.CraftFrame and _G.CraftFrame:IsVisible() then
                        if addon.CRAFT_SHOW then addon:CRAFT_SHOW() end
                    elseif _G.TradeSkillFrame and _G.TradeSkillFrame:IsVisible() then
                        if addon.TRADE_SKILL_SHOW then addon:TRADE_SKILL_SHOW() end
                    end
                end
                return
            end
            if attempts < maxAttemptsPerCandidate then
                scheduleNextTick(tryScan)
            else
                if currentIndex < candidateCount then
                    -- Try the next known profession
                    currentIndex = currentIndex + 1
                    attempts = 0
                    castCurrent()
                    scheduleNextTick(tryScan)
                else
                    addon:Print("Open a profession window (e.g., via the spellbook) before opening ARLC.")
                    addon:Print(L["OpenTradeSkillWindow"]) -- keep localized fallback
                end
            end
        end
        -- Kick off with the first candidate
        castCurrent()
        scheduleNextTick(tryScan)
        return
    end
    -- Fallback: ask the user to open a tradeskill window
    self:Print("Open a profession window (e.g., via the spellbook) before opening ARLC.")
    self:Print(L["OpenTradeSkillWindow"]) -- keep localized fallback
end

-- ----------------------------------------------------------------------------
-- Recipe Scanning Functions
-- ----------------------------------------------------------------------------
do
    local current_recipe_count, previous_recipe_count = 0, 0

    -- Indices of the spells in the spell book which may contain a speciality
    local specialtices_indices = {}

    local PROFESSION_BUTTONS = {
        _G.PrimaryProfession1SpellButtonTop,
        _G.PrimaryProfession1SpellButtonBottom,
        _G.PrimaryProfession2SpellButtonTop,
        _G.PrimaryProfession2SpellButtonBottom,
    }

    local function IsRecipeInfoLearnedByDescendant(recipeInfo)
        local nextRecipeID = recipeInfo.nextRecipeID

        while nextRecipeID do
            local nextRecipeInfo = _G.C_TradeSkillUI.GetRecipeInfo(nextRecipeID)
            if not nextRecipeInfo then
                break
            end

            if nextRecipeInfo.learned then
                return true
            end

            nextRecipeID = nextRecipeInfo.nextRecipeID
        end

        return false
    end

    local function IsRecipeInfoUnlearnedByAncestor(recipeInfo)
        local previousRecipeID = recipeInfo.previousRecipeID

        while previousRecipeID do
            local previousRecipeInfo = _G.C_TradeSkillUI.GetRecipeInfo(previousRecipeID)

            if not previousRecipeInfo then
                break
            end

            if not previousRecipeInfo.learned then
                return true
            end

            previousRecipeID = previousRecipeInfo.previousRecipeID
        end

        return false
    end

    --- Causes a scan of the tradeskill to be conducted. Function called when the scan button is clicked.   Parses recipes and displays output
    -- @name AckisRecipeList:Scan
    -- @usage AckisRecipeList:Scan(true)
    -- @param isTextDump (unused) legacy flag; output is always the ARL GUI
    -- @return The ARL frame
    function addon:Scan(isTextDump, isRefresh)
        local professionID, _, professionRank, _, _, _, localizedProfessionName = _G.C_TradeSkillUI.GetTradeSkillLine()
        if localizedProfessionName == _G.UNKNOWN then
            self:Print(L["OpenTradeSkillWindow"])
            return
        end
        private.current_profession_specialty = nil

        local professionModuleName = private.LOCALIZED_PROFESSION_NAME_TO_MODULE_NAME_MAPPING[localizedProfessionName]
        if not professionModuleName or not self:InitializeProfession(localizedProfessionName) then
            return
        end

        local player = private.Player
        player:UpdateProfessions()

        private.current_profession_scanlevel = professionRank

        -- Clear the search box and its focus so the scan will have correct results.
        if _G.TradeSkillFrame and _G.TradeSkillFrame:IsVisible() then
            local search_box = _G.TradeSkillFrame.SearchBox or
                (_G.TradeSkillFrame.DetailsFrame and _G.TradeSkillFrame.DetailsFrame.SearchBox)
            if search_box and search_box.ClearFocus and search_box.GetScript and search_box.SetText then
                search_box:ClearFocus()
                local onLost = search_box:GetScript("OnEditFocusLost")
                if type(onLost) == "function" then
                    onLost(search_box)
                end
                search_box:SetText("")
            end
        end
        -- CraftFrame (Enchanting) doesn't have a search box, but check if it's visible
        if _G.CraftFrame and _G.CraftFrame:IsVisible() then
            -- CraftFrame has no search box to clear, but this confirms it's the active frame
        end

        -- Make sure we're only updating a profession the character actually knows - this could be a scan from a tradeskill link.
        local isTradesSkillLinked = _G.C_TradeSkillUI.IsTradeSkillLinked() or _G.C_TradeSkillUI.IsTradeSkillGuild()
        if not isTradesSkillLinked then
            player.scanned_professions[localizedProfessionName] = true
        end

        table.wipe(specialtices_indices)

        local insertIndex = 1
        for index = 1, #PROFESSION_BUTTONS do
            local button = PROFESSION_BUTTONS[index]
            if button and button.GetParent then
                local parent = button:GetParent()
                if parent then
                    local spellOffset = parent.spellOffset
                    local specializationOffset = parent.specializationOffset

                    if spellOffset and specializationOffset then
                        specialtices_indices[insertIndex] = specializationOffset + spellOffset
                        insertIndex = insertIndex + 1
                    end
                end
            end
        end

        local professionSpecialties = SpecialtyTable[localizedProfessionName]
        if professionSpecialties then
            -- First attempt: Check spell book indices (original method)
            for _, bookIndex in ipairs(specialtices_indices) do
                local spellName = _G.GetSpellBookItemName(bookIndex, _G.BOOKTYPE_PROFESSION)
                if not spellName then
                    break
                elseif professionSpecialties[spellName] then
                    private.current_profession_specialty = professionSpecialties[spellName]
                    break
                end
            end

            -- Fallback: If no specialty found via spell book, check directly if specialty spells are known
            -- This is needed for MoP Classic where spell book scanning may not work reliably
            if not private.current_profession_specialty then
                for spellName, spellID in pairs(professionSpecialties) do
                    -- Check if the specialty spell is known
                    if (_G.IsPlayerSpell and _G.IsPlayerSpell(spellID)) or
                        (_G.IsSpellKnown and _G.IsSpellKnown(spellID, false)) then
                        private.current_profession_specialty = spellID
                        break
                    end
                end
            end
        end

        -- ----------------------------------------------------------------------------
        -- Scan all recipes and mark the ones we know
        -- ----------------------------------------------------------------------------
        local foundRecipeCount = 0
        local profession = private.Professions[localizedProfessionName]
        local recipeIDs = _G.C_TradeSkillUI.GetAllRecipeIDs()
        local fallbackSpellCheck = (not recipeIDs) or (#recipeIDs == 0)

        -- If this profession is backed by a stub (module missing), ensure the user gets a warning once
        if profession and profession.IsStub then
            addon._missingModuleWarned = addon._missingModuleWarned or {}
            local moduleName = private.LOCALIZED_PROFESSION_NAME_TO_MODULE_NAME_MAPPING[localizedProfessionName]
            if moduleName and not addon._missingModuleWarned[moduleName] then
                addon._missingModuleWarned[moduleName] = true
                local displayModuleName = (private.addon_display_name or private.addon_name) ..
                    ": " .. (moduleName or localizedProfessionName or "Unknown")
                Dialog:Spawn("ARL_MissingProfessionModuleDialog", {
                    localizedProfessionName = localizedProfessionName,
                    moduleName = displayModuleName
                })
            end
        end

        local function IsRecipeLearnedBySpell(spellID)
            -- Prefer IsPlayerSpell when available; fallback to IsSpellKnown; ensure spell exists
            if not spellID or not _G.GetSpellInfo or not _G.GetSpellInfo(spellID) then return false end
            if _G.IsPlayerSpell and _G.IsPlayerSpell(spellID) then return true end
            if _G.IsSpellKnown and _G.IsSpellKnown(spellID, false) then return true end
            return false
        end
        local effectiveExpansion = private.GetEffectiveExpansionID() or #private.GAME_VERSION_NAMES

        if not fallbackSpellCheck then
            for recipeIndex = 1, #recipeIDs do
                local recipeID = recipeIDs[recipeIndex]
                local recipe = profession.Recipes[recipeID]
                local recipeInfo = _G.C_TradeSkillUI.GetRecipeInfo(recipeID)

                if recipe then
                    recipe.isValidated = true

                    -- Gate: hide recipes from expansions beyond current client expansion (e.g., post-MoP on MoP Classic)
                    if recipe:ExpansionID() and recipe:ExpansionID() > effectiveExpansion then
                        recipe:AddState("IGNORED")
                    else
                        recipe:RemoveState("IGNORED")
                    end

                    if recipeInfo and recipeInfo.learned then
                        recipe:RemoveState("IGNORED")

                        if isTradesSkillLinked then
                            recipe:AddState("LINKED")
                        else
                            recipe:AddState("KNOWN")
                            recipe:RemoveState("LINKED")
                        end

                        foundRecipeCount = foundRecipeCount + 1
                    elseif recipeInfo and (IsRecipeInfoLearnedByDescendant(recipeInfo) or IsRecipeInfoUnlearnedByAncestor(recipeInfo)) then
                        recipe:AddState("IGNORED")
                    else
                        recipe:RemoveState("KNOWN")
                        recipe:RemoveState("LINKED")
                    end
                else
                    -- Non-DB recipe discovered via UI scan. Keep quiet in release; optional debug retained.
                    local debugName = (recipeInfo and recipeInfo.name) or tostring(recipeID)
                    self:Debug("%s (%d): %s", debugName, recipeID, L["MissingFromDB"])
                end
            end
        else
            -- Fallback path for Classic/Era: determine known state via spell knowledge without relying on UI-provided recipe IDs
            for recipeID, recipe in pairs(profession.Recipes) do
                if recipe then
                    recipe.isValidated = true
                    if recipe:ExpansionID() and recipe:ExpansionID() > effectiveExpansion then
                        recipe:AddState("IGNORED")
                    else
                        recipe:RemoveState("IGNORED")
                    end

                    if IsRecipeLearnedBySpell(recipeID) then
                        recipe:RemoveState("IGNORED")
                        recipe:AddState(isTradesSkillLinked and "LINKED" or "KNOWN")
                        recipe:RemoveState(isTradesSkillLinked and "KNOWN" or "LINKED")
                        foundRecipeCount = foundRecipeCount + 1
                    else
                        recipe:RemoveState("KNOWN")
                        recipe:RemoveState("LINKED")
                    end
                end
            end
        end

        previous_recipe_count = current_recipe_count
        current_recipe_count = foundRecipeCount

        if isRefresh and previous_recipe_count == foundRecipeCount then
            return
        end
        player:UpdateReputations()

        -- ----------------------------------------------------------------------------
        -- Everything is ready - display the GUI.
        -- ----------------------------------------------------------------------------
        -- Always display GUI (ignore isTextDump)
        if true then
            private.PreviousProfession = private.CurrentProfession
            private.CurrentProfession = private.Professions[localizedProfessionName]

            if private.InitializeFrame then
                private.InitializeFrame()
            end

            self.Frame:Display(isTradesSkillLinked)
        end
    end
end
