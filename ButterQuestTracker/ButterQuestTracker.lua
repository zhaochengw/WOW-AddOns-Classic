local NAME, ns = ...

local isWoWClassic = select(4, GetBuildInfo()) < 20000;

local QWH = LibStub("QuestWatchHelper-1.0");
local QLH = LibStub("QuestLogHelper-1.0");
local ZH = LibStub("BQTZoneHelper-1.0");
local QH = LibStub("LibQuestHelpers-1.0");

local BQTL = ButterQuestTrackerLocale;
ButterQuestTracker = LibStub("AceAddon-3.0"):NewAddon("ButterQuestTracker", "AceEvent-3.0");
local BQT = ButterQuestTracker;

StaticPopupDialogs[NAME .. "_WowheadURL"] = {
    text = ns.CONSTANTS.PATHS.LOGO .. ns.CONSTANTS.BRAND_COLOR .. " Butter Quest Tracker" .. "|r - Wowhead URL " .. ns.CONSTANTS.PATHS.LOGO,
    button2 = CLOSE,
    hasEditBox = true,
    editBoxWidth = 300,

    EditBoxOnEnterPressed = function(self)
        self:GetParent():Hide()
    end,

    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,

    OnShow = function(self)
        local questID = self.text.text_arg1;
        local quest = QLH:GetQuest(questID);
        local name = quest.title;

        self.text:SetText(self.text:GetText() .. "\n\n|cffff7f00" .. name .. "|r");
        self.editBox:SetText(QLH:GetWowheadURL(questID));
        self.editBox:SetFocus();
        self.editBox:HighlightText();
    end,

    whileDead = true,
    hideOnEscape = true
}

function BQT:OnEnable()
    self.db = LibStub("AceDB-3.0"):New("ButterQuestTrackerConfig", ns.CONSTANTS.DB_DEFAULTS, true);
    self.hiddenContainers = {};

    -- TODO: This is for backwards compatible support of the SavedVariables
    -- Remove this in v2.0.0
    if ButterQuestTrackerCharacterConfig then
        for key, value in pairs(ButterQuestTrackerCharacterConfig) do
            self.db.char[key] = value;
            ButterQuestTrackerCharacterConfig[key] = nil;
        end
    end
    -- END TODO

    QWH:BypassWatchLimit(self.db.char.MANUALLY_TRACKED_QUESTS);
    QWH:KeepHidden();
end

function BQT:OnPlayerEnteringWorld()
    self:UnregisterEvent("PLAYER_ENTERING_WORLD");

    BQTL:SetLocale(BQT.db.global.Locale);
    QWH:OnQuestWatchUpdated(function(questWatchUpdates)
        for _, updateInfo in pairs(questWatchUpdates) do
            if updateInfo.byUser then
                if updateInfo.watched then
                    self.db.char.MANUALLY_TRACKED_QUESTS[updateInfo.questID] = true;
                else
                    self.db.char.MANUALLY_TRACKED_QUESTS[updateInfo.questID] = false;
                end
            end
        end

        self:RefreshView();
    end);

    QLH:OnQuestUpdated(function(quests)
        self:LogTrace("Event(OnQuestUpdated)");

        local currentZone = GetRealZoneText();
        local minimapZone = GetMinimapZoneText();

        for questID, quest in pairs(quests) do
            if quest.abandoned then
                self.db.char.QUESTS_LAST_UPDATED[questID] = nil;
                self.db.char.MANUALLY_TRACKED_QUESTS[questID] = nil;
            elseif quest.accepted or quest.updated then
                self.db.char.QUESTS_LAST_UPDATED[questID] = quest.lastUpdated;

                -- If the quest is updated then remove it from the manually tracked quests list.
                if self.db.global.AutoTrackUpdatedQuests then
                    self.db.char.MANUALLY_TRACKED_QUESTS[questID] = true;
                elseif self.db.char.MANUALLY_TRACKED_QUESTS[questID] == false then
                    self.db.char.MANUALLY_TRACKED_QUESTS[questID] = nil;
                end

                self:UpdateQuestWatch(currentZone, minimapZone, QLH:GetQuest(questID));
            end
        end

        self:RefreshView();
    end);

    ZH:OnZoneChanged(function(info)
        self:LogInfo("Changed Zones: (" .. info.zone .. ", " .. info.subZone .. ")");
        self:RefreshQuestWatch();
    end);

    self.tracker = LibStub("TrackerHelper-1.0"):New({
        position = {
            x = self.db.global.PositionX,
            y = self.db.global.PositionY
        },

        width = self.db.global.Width,
        maxHeight = self.db.global.MaxHeight,

        backgroundColor = self.db.global.BackgroundColor,

        backgroundVisible = self.db.global.BackgroundAlwaysVisible or self.db.global.DeveloperMode,

        locked = self.db.global.LockFrame
    });

    -- TODO: This automatically updates invalid last updated values to the current time
    -- Remove this in v2.0.0
    for questID, lastUpdated in pairs(self.db.char.QUESTS_LAST_UPDATED) do
        if lastUpdated < 1000000 then
            self.db.char.QUESTS_LAST_UPDATED[questID] = time();
        end
    end
    -- END TODO

    self.db.char.QUESTS_LAST_UPDATED = QLH:SetQuestsLastUpdated(self.db.char.QUESTS_LAST_UPDATED);

    self:RefreshQuestWatch();
    self:RefreshView();
    if self.db.global.Sorting == "ByQuestProximity" then
        self:UpdateQuestProximityTimer();
    end

    -- This is a massive hack to prevent questie from ignoring us.
    C_Timer.After(3.0, function()
        QH:SetAutoHideQuestHelperIcons(self.db.global.AutoHideQuestHelperIcons);
    end);

    self:LogInfo("Enabled");
end

BQT:RegisterEvent("PLAYER_ENTERING_WORLD", "OnPlayerEnteringWorld")

function BQT:ShowWowheadPopup(id)
    StaticPopup_Show(NAME .. "_WowheadURL", id)
end

local function getDistance(x1, y1, x2, y2)
	return math.min( (x2-x1)^2 + (y2-y1)^2 );
end

local function count(t)
    local _count = 0;
    if t then
        for _, _ in pairs(t) do _count = _count + 1 end
    end
    return _count;
end

local function getWorldPlayerPosition()
    local uiMapID = C_Map.GetBestMapForUnit("player");

    if not uiMapID then
        return nil;
    end

    local mapPosition = C_Map.GetPlayerMapPosition(uiMapID, "player");

    if not mapPosition then
        return nil;
    end

    local _, worldPosition = C_Map.GetWorldPosFromMapPos(uiMapID, mapPosition);

    return worldPosition;
end

local function sortQuestFallback(quest, otherQuest, field, comparator)
    local value = quest[field];
    local otherValue = otherQuest[field];

    if value == otherValue then
        return quest.index < otherQuest.index;
    end

    if not value and otherValue then
        return false;
    elseif value and not otherValue then
        return true;
    end

    if comparator == ">" then
        return value > otherValue;
    elseif comparator == "<" then
        return value < otherValue;
    else
        BQT:LogError("Unknown Comparator. (" .. comparator .. ")");
    end
end

local function sortQuests(quest, otherQuest)
    local sorting = BQT.db.global.Sorting or "nil";
    if sorting == "Disabled" then
        return sortQuestFallback(quest, otherQuest);
    end

    if sorting == "ByLevel" then
        return sortQuestFallback(quest, otherQuest, "level", "<");
    elseif sorting == "ByLevelReversed" then
        return sortQuestFallback(quest, otherQuest, "level", ">");
    elseif sorting == "ByPercentCompleted" then
        return sortQuestFallback(quest, otherQuest, "completionPercent", ">");
    elseif sorting == "ByRecentlyUpdated" then
        return sortQuestFallback(quest, otherQuest, "lastUpdated", ">");
    elseif sorting == "ByQuestProximity" then
        if QH:IsSupported() then
            quest.distance = QH:GetDistanceToClosestObjective(quest.questID);
            otherQuest.distance = QH:GetDistanceToClosestObjective(otherQuest.questID);
        else
            quest.distance = 0;
            otherQuest.distance = 0;
        end

        return sortQuestFallback(quest, otherQuest, "distance", "<");
    else
        BQT:LogError("Unknown Sorting value. (" .. sorting .. ")")
    end

    return false;
end

function BQT:UpdateQuestProximityTimer()
    if self.db.global.Sorting == "ByQuestProximity" then
        local initialized = false;
        self:Sort();

        self.questProximityTimer = C_Timer.NewTicker(5.0, function()
            self:LogTrace("-- Starting ByQuestProximity Checks --");
            self:LogTrace("Checking if player has moved...");
            local position = getWorldPlayerPosition();

            if position then
                local distance = self.playerPosition and getDistance(position.x, position.y, self.playerPosition.x, self.playerPosition.y);

                if not initialized or not distance or distance > 0.01 then
                    initialized = true;
                    self.playerPosition = position;
                    self:Sort();
                else
                    self:LogTrace("Player movement wasn't greater then 5, ignoring... (" .. distance .. ")");
                end
                self:LogTrace("-- Ending ByQuestProximity Checks --");
            end
        end);
    elseif self.questProximityTimer then
        self.playerPosition = nil;
        self.questProximityTimer:Cancel();
    end
end

function BQT:RefreshQuestWatch()
    self:LogTrace("Refreshing Quest Watch");

    local quests = QLH:GetQuests();

    local currentZone = GetRealZoneText();
    local minimapZone = GetMinimapZoneText();

    for _, quest in pairs(quests) do
        self:UpdateQuestWatch(currentZone, minimapZone, quest);
    end
end

function BQT:UpdateQuestWatch(currentZone, minimapZone, quest)
    if self:ShouldWatchQuest(currentZone, minimapZone, quest) then
        AddQuestWatch(quest.index);
    else
        RemoveQuestWatch(quest.index);
    end
end

function BQT:ShouldWatchQuest(currentZone, minimapZone, quest)
    quest.isCurrentZone = quest.zone == currentZone or quest.zone == minimapZone;

    if self.db.char.MANUALLY_TRACKED_QUESTS[quest.questID] == true then
        return true;
    elseif self.db.char.MANUALLY_TRACKED_QUESTS[quest.questID] == false or self.db.global.DisableFilters then
        return false;
    end

    if self.db.global.HideCompletedQuests and quest.completed then
        return false;
    end

    if self.db.global.CurrentZoneOnly and not quest.isCurrentZone and not quest.isClassQuest and not quest.isProfessionQuest then
        return false;
    end

    return true;
end

function BQT:GetQuestInfo()
    if self.db.global.DisplayDummyData and InterfaceOptionsFrame:IsShown() then
        -- TODO: Move this into QuestLogHelper
        local quests = {
            -- Partially Completed
            [6563] = {
                index = 1,
                questID = 6563,
                title = "The Essence of Aku'Mai",
                zone = "Blackfathom Deeps",
                completed = false,
                failed = false,
                isClassQuest = false,
                isProfessionQuest = false,
                sharable = true,
                level = 22,
                difficulty = QLH:GetDifficulty(22),
                completionPercent = 0.25,

                objectives = {
                    [1] = {
                        text = "Sapphire of Aku'Mai: 5/20",
                        fulfilled = 5,
                        required = 20,
                        completed = false
                    }
                }
            },

            -- No objectives, summary only
            [1196] = {
                index = 2,
                questID = 1196,
                title = "The Sacred Flame",
                summary = "Deliver the Filled Etched Phial to Rau Cliffrunner at the Freewind Post.",
                zone = "Thunder Bluff",
                completed = false,
                failed = false,
                isClassQuest = false,
                isProfessionQuest = false,
                sharable = true,
                level = 29,
                difficulty = QLH:GetDifficulty(29),
                completionPercent = 1
            },

            -- Multiple Objectives, partially completed.
            [4841] = {
                index = 3,
                questID = 4841,
                title = "Pacify the Centaur",
                zone = "Thousand Needles",
                completed = false,
                failed = false,
                isClassQuest = false,
                isProfessionQuest = false,
                sharable = true,
                level = 25,
                difficulty = QLH:GetDifficulty(25),
                completionPercent = 0.5714,

                objectives = {
                    [1] = {
                        text = "Galak Scout slain: 0/12",
                        fulfilled = 0,
                        required = 12,
                        completed = false
                    },

                    [2] = {
                        text = "Galak Wrangler slain: 10/10",
                        fulfilled = 10,
                        required = 10,
                        completed = true
                    },

                    [3] = {
                        text = "Galak Windchaser slain: 6/6",
                        fulfilled = 6,
                        required = 6,
                        completed = true
                    }
                }
            },

            -- Completed
            [5147] = {
                index = 4,
                questID = 5147,
                title = "Compendium of the Fallen",
                zone = "Scarlet Monastery",
                completed = true,
                failed = false,
                isClassQuest = false,
                isProfessionQuest = false,
                sharable = true,
                level = 38,
                difficulty = QLH:GetDifficulty(38),
                completionPercent = 1,

                objectives = {
                    [1] = {
                        text = "Compendium of the Fallen: 1/1",
                        fulfilled = 1,
                        required = 1,
                        completed = true
                    }
                }
            },

            -- Failed
            [4904] = {
                index = 5,
                questID = 4904,
                title = "Free at Last",
                zone = "Thousand Needles",
                completed = false,
                failed = true,
                isClassQuest = false,
                isProfessionQuest = false,
                sharable = false,
                level = 29,
                difficulty = QLH:GetDifficulty(29),
                completionPercent = 0,

                objectives = {
                    [1] = {
                        text = "Escort Lakota Windsong from the Darkcloud Pinnacle.",
                        type = "event",
                        fulfilled = 0,
                        required = 1,
                        completed = false
                    }
                }
            }
        };

        local currentZone = "Thunder Bluff";
        local minimapZone = GetMinimapZoneText();

        local watchedQuests = {};
        for questID, quest in pairs(quests) do
            if self:ShouldWatchQuest(currentZone, minimapZone, quest) then
                watchedQuests[questID] = quest;
            end
        end

        return watchedQuests, count(quests), true;
    end

    return QLH:GetWatchedQuests(), QLH:GetQuestCount(), false;
end

function BQT:GetTrackerHeader(visibleQuestCount, questCount)
    if self.db.global.TrackerHeaderFormat == "QuestsNumberVisible" then
        return BQTL:GetString('QT_QUESTS') .. " (" .. visibleQuestCount .. "/" .. questCount .. ")";
    elseif self.db.global.TrackerHeaderFormat == "QuestsNumberVisibleTotal" then
        return BQTL:GetString('QT_QUESTS') .. " (" .. visibleQuestCount .. "/" .. C_QuestLog.GetMaxNumQuests() .. ")";
    end

    return BQTL:GetString('QT_QUESTS');
end

function BQT:GetQuestHeader(quest)
    local format = self.db.global.QuestHeaderFormat;

    for match, key in format:gmatch("({{(%w+)}})" ) do
        local value = quest[key] or "";

        if type(value) == "number" and math.floor(value) ~= value then
            value = string.format("%.1f", value);
        end

        format = format:gsub(match, value, 1);
    end

    return format;
end

function BQT:Sort()
    self:LogInfo("Sort");

    if not self.questContainers then return end

    -- collect the keys
    local quests = self:GetQuestInfo();
    local keys = {};
    for k in pairs(quests) do keys[#keys+1] = k end
    table.sort(keys, function(a, b) return sortQuests(quests[a], quests[b]) end);

    local questIDToOrderMap = {};
    local zoneToOrderMap = {};
    for i, questID in pairs(keys) do
        questIDToOrderMap[questID] = i;
        zoneToOrderMap[quests[questID].zone] = zoneToOrderMap[quests[questID].zone] or i;
    end

    for _, element in pairs(self.questContainers) do
        element:SetOrder(questIDToOrderMap[element.metadata.quest.questID]);
    end

    if self.db.global.ZoneHeaderEnabled then
        for _, element in ipairs(self.questsContainer.elements) do
            local order = zoneToOrderMap[element.metadata.zone];

            if order then
                if not element.metadata.header then
                    order = order + 0.1;
                end

                element:SetOrder(order, false);
            end
        end

        self.questsContainer:Order();
    end
end

function BQT:RefreshView()
    self:LogInfo("Refresh Quests");
    self.tracker:Clear();

    local watchedQuests, questCount = self:GetQuestInfo();

    self:LogTrace("Quest Count:", questCount);

    local trackerContainer = self.tracker:Container({
        margin = {
            x = 10,
            y = 10
        },

        backgroundColor = self.db.global.DeveloperMode and {
            r = 1.0,
            g = 1.0,
            a = 0.2
        }
    });

    if self.db.global.TrackerHeaderEnabled then
        self.tracker:Font({
            label = self:GetTrackerHeader(count(watchedQuests), questCount),
            color = self.db.global.TrackerHeaderFontColor,
            size = self.db.global.TrackerHeaderFontSize,

            container = self.tracker:Container({
                container = trackerContainer,

                margin = {
                    bottom = 10
                },

                events = {
                    OnMouseDown = function(button)
                        if button ~= "LeftButton" or self.db.global.LockFrame then return end

                        self.tracker:StartMoving();
                    end,

                    OnMouseUp = function(button)
                        if button ~= "LeftButton" or self.db.global.LockFrame then return end

                        self.tracker:StopMovingOrSizing();
                    end,

                    OnButterDragStart = function()
                        self.tracker:SetBackgroundVisibility(true);
                    end,

                    -- This fires only if OnButterDragStart fires as well.
                    OnButterDragStop = function()
                        local x, y = self.tracker:GetPosition();
                        if not self.db.global.DeveloperMode and not self.db.global.BackgroundAlwaysVisible then
                            self.tracker:SetBackgroundVisibility(false);
                        end

                        self.db.global.PositionX = x;
                        self.db.global.PositionY = y;

                        LibStub("AceConfigRegistry-3.0"):NotifyChange("ButterQuestTracker");
                    end,

                    -- This fires only if OnButterDragStart doesn't fire.
                    OnButterMouseUp = function(button)
                        if button == "LeftButton" then
                            self.hiddenContainers["QUESTS"] = self.questsContainer:ToggleHidden() or nil;
                            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
                        else
                            if InterfaceOptionsFrame:IsShown() then
                                InterfaceOptionsFrame:Hide();
                            else
                                InterfaceOptionsFrame:Show();
                                InterfaceOptionsFrame_OpenToCategory("ButterQuestTracker");
                            end
                        end
                    end
                }
            })
        });
    end

    self.questsContainer = self.tracker:Container({
        container = trackerContainer,
        hidden = self.hiddenContainers["QUESTS"]
    });
    self.questContainers = {};
    local zoneContainers = {};
    local index = 1;
    for _, quest in pairs(watchedQuests) do
        if not zoneContainers[quest.zone] then
            if self.db.global.ZoneHeaderEnabled then
                -- Zone Header
                self.tracker:Font({
                    label = quest.zone,
                    color = self.db.global.ZoneHeaderFontColor,
                    size = self.db.global.ZoneHeaderFontSize,

                    container = self.tracker:Container({
                        container = self.questsContainer,

                        margin = {
                            bottom = 10,
                            left = 2
                        },

                        metadata = {
                            header = true,
                            zone = quest.zone
                        },

                        events = {
                            OnMouseUp = function()
                                self.hiddenContainers["Z-" .. quest.zone] = zoneContainers[quest.zone]:ToggleHidden() or nil;
                                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
                            end
                        }
                    })
                });

                zoneContainers[quest.zone] = self.tracker:Container({
                    container = self.questsContainer,
                    hidden = self.hiddenContainers["Z-" .. quest.zone],

                    margin = {
                        left = 8
                    },

                    metadata = {
                        header = false,
                        zone = quest.zone
                    }
                });
            end
        end

        local questContainer = self.tracker:Container({
            container = self.db.global.ZoneHeaderEnabled and zoneContainers[quest.zone] or self.questsContainer,

            backgroundColor = self.db.global.DeveloperMode and {
                g = 1.0,
                a = 0.2
            },

            margin = {
                bottom = self.db.global.QuestPadding,
                left = (self.db.global.ZoneHeaderEnabled or not self.db.global.TrackerHeaderEnabled) and 0 or 5
            },

            metadata = {
                quest = quest
            },

            events = {
                OnMouseUp = function(button)
                    if button == "LeftButton" then
                        if IsShiftKeyDown() then
                            self.db.char.MANUALLY_TRACKED_QUESTS[quest.questID] = false;
                            RemoveQuestWatch(quest.index);
                            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
                        elseif IsAltKeyDown() then
                            self:ShowWowheadPopup(quest.questID);
                        elseif IsControlKeyDown() then
                            if isWoWClassic then
                                ChatEdit_InsertLink("[" .. quest.title .. "]");
                            else
                                ChatEdit_InsertLink(GetQuestLink(quest.questID));
                            end
                        else
                            QLH:ToggleQuest(quest.index);
                        end
                    else
                        self:ToggleContextMenu(quest);
                    end
                end,

                OnEnter = function(_, target)
                    GameTooltip:SetOwner(target, "ANCHOR_NONE");
                    GameTooltip:SetPoint("RIGHT", target, "LEFT");
                    GameTooltip:AddLine(quest.title .. "\n", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
                    GameTooltip:AddLine(quest.summary, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, true);

                    if self.db.global.DeveloperMode then
                        GameTooltip:AddDoubleLine("\nQuest ID:", quest.questID, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
                        GameTooltip:AddDoubleLine("Quest Index:", quest.index, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);

                        for _, addon in ipairs(QH:GetActiveAddons()) do
                            local distance = QH:GetDistanceToClosestObjective(quest.questID, addon);
                            if distance then
                                GameTooltip:AddDoubleLine(addon .. " (distance):", string.format("%.1fm", distance), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
                            else
                                GameTooltip:AddDoubleLine(addon .. " (distance):", "N/A", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
                            end
                        end
                    end

                    GameTooltip:Show();
                end,

                OnLeave = function()
                    GameTooltip:ClearLines();
                    GameTooltip:Hide();
                end
            }
        });
        tinsert(self.questContainers, questContainer);

        self.tracker:Font({
            label = self:GetQuestHeader(quest),
            size = self.db.global.QuestHeaderFontSize,
            color = self.db.global.ColorHeadersByDifficultyLevel and QLH:GetDifficultyColor(quest.difficulty) or self.db.global.QuestHeaderFontColor,
            container = questContainer
        });

        local objectiveCount = count(quest.objectives);

        if objectiveCount == 0 then
            self.tracker:Font({
                label = ' - ' .. quest.summary,
                size = self.db.global.ObjectiveFontSize,
                color = self.db.global.ObjectiveFontColor,
                container = questContainer,
                margin = {
                    bottom = 2.5
                }
            });
        elseif quest.completed then
            self.tracker:Font({
                label = ' - ' .. BQTL:GetString('QT_READY_TO_TURN_IN'),
                size = self.db.global.ObjectiveFontSize,
                color = "00b205",
                container = questContainer,
                margin = {
                    bottom = 2.5
                }
            });
        elseif quest.failed then
            self.tracker:Font({
                label = ' - ' .. BQTL:GetString('QT_FAILED'),
                size = self.db.global.ObjectiveFontSize,
                color = { r = 1, g = 0.1, b = 0.1 },
                container = questContainer,
                margin = {
                    bottom = 2.5
                }
            });
        else
            for _, objective in ipairs(quest.objectives) do
                self.tracker:Font({
                    label = ' - ' .. objective.text,
                    size = self.db.global.ObjectiveFontSize,
                    color = objective.completed and HIGHLIGHT_FONT_COLOR or self.db.global.ObjectiveFontColor,
                    container = questContainer,
                    margin = {
                        bottom = 2.5
                    }
                });
            end
        end
        index = index + 1;
    end

    self:Sort();
end

function BQT:ToggleContextMenu(quest)
    if not self.contextMenu then
        self.contextMenu = CreateFrame("Frame", "WPDemoContextMenu", UIParent, "UIDropDownMenuTemplate");
    end

    local isActive = UIDROPDOWNMENU_OPEN_MENU == self.contextMenu;
    local hasQuestChanged = not self.contextMenu.quest or self.contextMenu.quest.questID ~= quest.questID;

    self.contextMenu.quest = quest;

    UIDropDownMenu_Initialize(self.contextMenu, function()
        UIDropDownMenu_AddButton({
            text = self.contextMenu.quest.title,
            notCheckable = true,
            isTitle = true
        });

        UIDropDownMenu_AddButton({
            text = BQTL:GetString('QT_UNTRACK_QUEST'),
            notCheckable = true,
            func = function()
                self.db.char.MANUALLY_TRACKED_QUESTS[self.contextMenu.quest.questID] = false;
                RemoveQuestWatch(self.contextMenu.quest.index);
            end
        });

        UIDropDownMenu_AddButton({
            text = BQTL:GetString('QT_VIEW_QUEST'),
            notCheckable = true,
            func = function()
                QLH:ToggleQuest(self.contextMenu.quest.index);
            end
        });

        UIDropDownMenu_AddButton({
            text = BQTL:GetString('QT_WOWHEAD_URL'),
            notCheckable = true,
            func = function()
                BQT:ShowWowheadPopup(self.contextMenu.quest.questID);
            end
        });

        UIDropDownMenu_AddButton({
            text = BQTL:GetString('QT_SHARE_QUEST'),
            notCheckable = true,
            disabled = not UnitInParty("player") or not self.contextMenu.quest.sharable,
            func = function()
                QLH:ShareQuest(self.contextMenu.quest.index);
            end
        });

        UIDropDownMenu_AddButton({
            text = BQTL:GetString('QT_CANCEL_QUEST'),
            notCheckable = true,
            func = function()
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
            end
        });

        UIDropDownMenu_AddButton({
            isTitle = true
        });

        UIDropDownMenu_AddButton({
            text = BQTL:GetString('QT_ABANDON_QUEST'),
            notCheckable = true,
            colorCode = "|cffff0000",
            func = function()
                QLH:AbandonQuest(self.contextMenu.quest.index);
                PlaySound(SOUNDKIT.IG_QUEST_LOG_ABANDON_QUEST);
            end
        });
    end, "MENU");

    -- If this Dropdown menu isn't already open then play the sound effect.
    if isActive and not hasQuestChanged then
        CloseDropDownMenus();
    else
        ToggleDropDownMenu(1, nil, self.contextMenu, "cursor", 0, -3);
        PlaySound(SOUNDKIT.IG_MAINMENU_OPEN);
    end
end

function BQT:ResetOverrides()
    self:LogInfo("Clearing Tracking Overrides...");
    self.db.char.MANUALLY_TRACKED_QUESTS = {};
    self:RefreshQuestWatch();
end

function BQT:Debug(type, bypass, ...)
    if bypass or (self.db.global.DeveloperMode and self.db.global.DebugLevel >= type.LEVEL) then
        print(ns.CONSTANTS.LOGGER.PREFIX .. type.COLOR, ...);
    end
end

function BQT:LogError(...)
    self:Debug(ns.CONSTANTS.LOGGER.TYPES.ERROR, true, ...);
end

function BQT:LogWarn(...)
    self:Debug(ns.CONSTANTS.LOGGER.TYPES.WARN, false, ...);
end

function BQT:LogInfo(...)
    self:Debug(ns.CONSTANTS.LOGGER.TYPES.INFO, false, ...);
end

function BQT:LogTrace(...)
    self:Debug(ns.CONSTANTS.LOGGER.TYPES.TRACE, false, ...);
end
