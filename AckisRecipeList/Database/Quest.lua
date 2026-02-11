-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

-- ----------------------------------------------------------------------------
-- Imports
-- ----------------------------------------------------------------------------
local Z = private.ZONE_NAMES

-- ----------------------------------------------------------------------------
-- Memoizing table for quest names.
-- ----------------------------------------------------------------------------

-- Safely reference C_QuestLog. It exists in WotLK+, but we need to check methods.
local C_QuestLog = _G.C_QuestLog or {}

local function SafeGetQuestTitle(id)
    if type(id) ~= "number" then return nil end

    -- 1. Try Modern Retail / SoD API (if available)
    if type(C_QuestLog.GetTitleForQuestID) == "function" then
        local title = C_QuestLog.GetTitleForQuestID(id)
        if title and title ~= "" then
            return title
        end

        -- Async
        if type(C_QuestLog.RequestLoadQuestByID) == "function" then
            C_QuestLog.RequestLoadQuestByID(id)
        end
    end

    -- If the function doesn't exist (WotLK/Cata), we return nil immediately.
    return nil
end

local pendingQuestNameRetry = {}
local questNameRetryCount = {}

local function TryResolveQuestName(id)
    local quest_name = SafeGetQuestTitle(id)
    if quest_name and quest_name ~= "" then
        return quest_name
    end

    _G.GameTooltip:ClearLines()
    _G.GameTooltip:SetOwner(_G.UIParent, _G.ANCHOR_NONE)
    
    local success = pcall(_G.GameTooltip.SetHyperlink, _G.GameTooltip, ("quest:%s"):format(id))
    
    if success then
        local tooltipName = _G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText()
        _G.GameTooltip:Hide()
        
        if tooltipName and tooltipName ~= "" and tooltipName ~= "Retrieving..." then
            private.quest_names[id] = tooltipName
            return tooltipName
        end
    else
        _G.GameTooltip:Hide()
    end

    -- Attempt 3: Curated fallback for known tricky quests
    local FALLBACK_QUEST_TITLES = {
        [2751] = "Barbaric Battlements", -- BS quest chain (Horde)
        [2752] = "On Iron Pauldrons", -- BS quest chain (Horde)
        [2753] = "Trampled Under Foot", -- BS quest chain (Horde)
        [2755] = "Joys of Omosh", -- BS quest chain (Horde)
        [1618] = "Gearing Redridge", -- BS quest (Alliance)
        [7604] = "A Binding Contract", -- Plans: Sulfuron Hammer
        [33022] = "Catch and Carry", -- Cooking: Noodle Cart progression
        [33024] = "Is That A Real Measurement?", -- Cooking: Noodle Cart progression
        [33027] = "The Secret Ingredient Is...", -- Cooking: Noodle Cart scenario
        [7493]  = "The Journey Has Just Begun", -- Leatherworking Black Dragonflight cloak (H)
        [31539] = "A Thing of Beauty", -- Inscription weekly (Scroll of Wisdom)
        [44952] = "Blackrock Depths: Jewel of the Depths", -- Legion BS quest
        [41160] = "Earth to Earth", -- Legion BS quest
        [44863] = "Clearing the Air", -- Legion BS quest
    }
    return FALLBACK_QUEST_TITLES[id]
end

private.quest_names = _G.setmetatable({}, {
    __index = function(t, id_num)
        -- First, try to resolve immediately via safe APIs
        local quest_name = TryResolveQuestName(id_num)
        if quest_name and quest_name ~= "" then
            return quest_name
        end

        -- Schedule a short retry to capture late-available titles.
        -- This is especially important for WotLK/Cata/Classic where the Tooltip needs time to fetch data.
        if not pendingQuestNameRetry[id_num] then
            pendingQuestNameRetry[id_num] = true
            questNameRetryCount[id_num] = (questNameRetryCount[id_num] or 0) + 1
            
            addon:ScheduleTimer(function()
                pendingQuestNameRetry[id_num] = nil
                
                -- Try Retail API again first (in case it exists and data loaded)
                if type(C_QuestLog.GetTitleForQuestID) == "function" then
                    local resolved = C_QuestLog.GetTitleForQuestID(id_num)
                    if not resolved or resolved == "" then
                        resolved = TryResolveQuestName(id_num)
                    end
                else
                    -- Retail API not present, try Tooltip/Fallback again
                    resolved = TryResolveQuestName(id_num)
                end
                
                if resolved and resolved ~= "" then
                    -- Force a light rebuild so displayed texts pick up the resolved name
                    if private.list_frame and private.list_frame.Initialize then
                        private.list_frame:Initialize(nil)
                    end
                elseif (questNameRetryCount[id_num] or 0) < 3 then
                    -- Try up to 3 times in total
                    pendingQuestNameRetry[id_num] = true
                    addon:ScheduleTimer(function()
                        pendingQuestNameRetry[id_num] = nil
                        local resolved2 = TryResolveQuestName(id_num)
                        
                        if resolved2 and resolved2 ~= "" then
                            if private.list_frame and private.list_frame.Initialize then
                                private.list_frame:Initialize(nil)
                            end
                        end
                    end, 1) -- Wait 1 second before second retry
                end
            end, 0.5) -- Wait 0.5s for first retry
        end

        -- Localized placeholder
        return ("%s %s"):format(L["Quest"] or "Quest", _G.tostring(id_num))
    end,
})

function addon:InitQuest()
    local function AddQuest(questID, zoneName, coordX, coordY, faction)
        private.AcquireTypes.Quest:AddEntity(addon, {
            coord_x = coordX,
            coord_y = coordY,
            faction = faction,
            identifier = questID,
            item_list = {},
            locationName = zoneName,
            name = nil, -- Handled by memoizing table above.
        })
    end

    AddQuest(8323,	Z.SILITHUS,			67.1,	69.7,	"Neutral") -- Blacksmithing, Tailoring
    AddQuest(43943,	Z.SURAMAR,			36.5,	46.8,	"Neutral") -- Jewelcrafting, Leatherworking

    self.InitQuest = nil
end