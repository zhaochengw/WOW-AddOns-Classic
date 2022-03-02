local _, ns = ...

local ACD = LibStub("AceConfigDialog-3.0");
local QH = LibStub("LibQuestHelpers-1.0");
local BQTL = ButterQuestTrackerLocale;

local BQT = ButterQuestTracker

local _order = 0;
local function order()
    _order = _order + 1;
    return _order;
end

local function Spacer(options)
    options = options or {};
    options.size = options.size or "small";
    options.width = options.width or "full";

    return {
        type = "description",
        order = order(),
        name = " ",
        fontSize = options.size,
        width = options.width
    };
end

local function GetFromDB(info)
    return BQT.db.global[info.arg];
end

local function SetInDB(info, value)
    BQT.db.global[info.arg] = value;
end

local function SetAndRefreshQuestWatch(info, value)
    SetInDB(info, value);
    BQT:RefreshQuestWatch();
end

local function SetAndRefreshView(info, value)
    SetInDB(info, value);
    BQT:RefreshView();
end

local function hex2rgb(hex)
    hex = hex:gsub("#","")
    if #hex == 8 then
        return {
            r = tonumber("0x" .. hex:sub(3,4)) / 255,
            g = tonumber("0x" .. hex:sub(5,6)) / 255,
            b = tonumber("0x" .. hex:sub(7,8)) / 255,
            a = tonumber("0x" .. hex:sub(1,2)) / 255
        };
    end

    return {
        r = tonumber("0x" .. hex:sub(1,2)) / 255,
        g = tonumber("0x" .. hex:sub(3,4)) / 255,
        b = tonumber("0x" .. hex:sub(5,6)) / 255
    };
end

local function rgb2hex(rgba)
    local hex = "";

    local index = 1;
    for _, color in pairs(rgba) do
        local segment = ('%02X'):format(tonumber(color * 255));

        if index == 4 then
            hex = segment .. hex;
        else
            hex = hex .. segment;
        end

        index = index + 1;
	end

	return hex;
end

local function GetColor(info)
    local color = hex2rgb(BQT.db.global[info.arg]);

    return color.r, color.g, color.b, color.a;
end

local function SetColor(info, r, g, b, a)
    BQT.db.global[info.arg] = rgb2hex({
        r,
        g,
        b,
        a
    });
end

LibStub("AceConfig-3.0"):RegisterOptionsTable("ButterQuestTracker", function()
    return {
        name = function() return BQTL:GetString('SETTINGS_NAME', ns.CONSTANTS.VERSION) end,
        type = "group",
        childGroups = "tab",

        get = GetFromDB,
        set = SetInDB,

        args = {
            displayDummyData = {
                name = BQTL:GetStringWrap('SETTINGS_DISPLAY_DUMMY_DATA_NAME'),
                desc = BQTL:GetStringWrap('SETTINGS_DISPLAY_DUMMY_DATA_DESC'),
                arg = "DisplayDummyData",
                type = "toggle",
                order = order(),

                set = SetAndRefreshView
            },

            filtersAndSorting = {
                name = BQTL:GetStringWrap('SETTINGS_FILTERS_AND_SORTING_TAB'),
                type = "group",
                order = order(),

                args = {
                    autoTrackUpdatedQuests = {
                        name = BQTL:GetStringWrap('SETTINGS_AUTO_TRACK_UPDATED_QUESTS_NAME'),
                        desc = BQTL:GetStringWrap('SETTINGS_AUTO_TRACK_UPDATED_QUESTS_DESC'),
                        arg = "AutoTrackUpdatedQuests",
                        type = "toggle",
                        width = 1.6,
                        order = order(),

                        set = function(info, value)
                            SetInDB(info, value);

                            if not value then
                                BQT:ResetOverrides();
                            end
                        end
                    },

                    spacer0 = Spacer({
                        width = 0.8
                    }),

                    sorting = {
                        name = BQTL:GetStringWrap('SETTINGS_SORTING_NAME'),
                        desc = BQTL:GetStringWrap('SETTINGS_SORTING_DESC'),
                        arg = "Sorting",
                        type = "select",
                        order = order(),

                        values = function()
                            local options = {
                                Disabled = BQTL:GetString('SETTINGS_SORTING_DISABLED_OPTION'),
                                ByLevel = BQTL:GetString('SETTINGS_SORTING_BY_LEVEL_OPTION'),
                                ByLevelReversed = BQTL:GetString('SETTINGS_SORTING_BY_LEVEL_REVERSED_OPTION'),
                                ByPercentCompleted = BQTL:GetString('SETTINGS_SORTING_BY_PERCENT_COMPLETED_OPTION'),
                                ByRecentlyUpdated = BQTL:GetString('SETTINGS_SORTING_BY_RECENTLY_UPDATED_OPTION')
                            };

                            if QH:IsSupported() then
                                options['ByQuestProximity'] = BQTL:GetString('SETTINGS_SORTING_BY_QUEST_PROXIMITY_OPTION');
                            end

                            return options;
                        end,

                        sorting = function()
                            local options = {
                                "Disabled",
                                "ByLevel",
                                "ByLevelReversed",
                                "ByPercentCompleted",
                                "ByRecentlyUpdated"
                            };

                            if QH:IsSupported() then
                                tinsert(options, "ByQuestProximity");
                            end

                            return options;
                        end,

                        set = function(info, value)
                            SetInDB(info, value);

                            BQT:UpdateQuestProximityTimer();
                            if value ~= "ByQuestProximity" then
                                BQT:Sort();
                            end
                        end
                    },

                    spacer1 = Spacer(),

                    autoHideQuestHelperIcons = {
                        name = BQTL:GetStringWrap('SETTINGS_AUTO_HIDE_QUEST_HELPER_ICONS_NAME'),
                        desc = function() return BQTL:GetString('SETTINGS_AUTO_HIDE_QUEST_HELPER_ICONS_DESC', table.concat(QH:GetActiveAddons(), ", ")) end,
                        arg = "AutoHideQuestHelperIcons",
                        type = "toggle",
                        width = 1.6,
                        order = order(),

                        disabled = function() return not QH:IsSupported() end,

                        set = function(info, value)
                            SetInDB(info, value);

                            QH:SetAutoHideQuestHelperIcons(value);
                        end
                    },

                    spacer2 = Spacer({
                        width = 0.8
                    }),

                    filtersHeader = {
                        name = "Filters",
                        type = "header",
                        order = order()
                    },

                    spacer3 = Spacer(),

                    disableFilters = {
                        name = BQTL:GetStringWrap('SETTINGS_DISABLE_FILTERS_NAME'),
                        desc = BQTL:GetStringWrap('SETTINGS_DISABLE_FILTERS_DESC'),
                        arg = "DisableFilters",
                        type = "toggle",
                        width = 1.6,
                        order = order(),

                        set = function(info, value)
                            if value == false then
                                BQT:ResetOverrides();
                            end
                            SetAndRefreshQuestWatch(info, value);
                        end
                    },

                    spacer4 = Spacer(),

                    currentZoneOnly = {
                        name = BQTL:GetStringWrap('SETTINGS_CURRENT_ZONE_ONLY_NAME'),
                        desc = BQTL:GetStringWrap('SETTINGS_CURRENT_ZONE_ONLY_DESC'),
                        arg = "CurrentZoneOnly",
                        type = "toggle",
                        width = 1.6,
                        order = order(),

                        disabled = function() return BQT.db.global.DisableFilters end,

                        set = SetAndRefreshQuestWatch
                    },

                    spacer5 = Spacer(),

                    hideCompletedQuests = {
                        name = BQTL:GetStringWrap('SETTINGS_HIDE_COMPLETED_QUESTS_NAME'),
                        desc = BQTL:GetStringWrap('SETTINGS_HIDE_COMPLETED_QUESTS_DESC'),
                        arg = "HideCompletedQuests",
                        type = "toggle",
                        width = 1.6,
                        order = order(),

                        disabled = function() return BQT.db.global.DisableFilters end,

                        set = SetAndRefreshQuestWatch
                    },

                    spacer6 = Spacer(),

                    reset = {
                        name = BQTL:GetStringWrap('SETTINGS_RESET_TRACKING_OVERRIDES_NAME'),
                        desc = BQTL:GetStringWrap('SETTINGS_RESET_TRACKING_OVERRIDES_DESC'),
                        type = "execute",
                        width = 1.3,
                        order = order(),

                        func = function()
                            BQT:ResetOverrides();
                        end
                    },

                    spacerEnd = Spacer({
                        size = "large"
                    }),
                }
            },

            visuals = {
                name = "框架格式设置",
                type = "group",
                order = order(),

                args = {
                    spacerStart = Spacer(),

                    backgroundAlwaysVisible = {
                        name = BQTL:GetStringWrap('SETTINGS_BACKGROUND_ALWAYS_VISIBLE_NAME'),
                        desc = BQTL:GetStringWrap('SETTINGS_BACKGROUND_ALWAYS_VISIBLE_DESC'),
                        arg = "BackgroundAlwaysVisible",
                        type = "toggle",
                        width = 2.3,
                        order = order(),

                        set = function(info, value)
                            SetInDB(info, value);

                            BQT.tracker:UpdateSettings({
                                backgroundVisible = BQT.db.global.DeveloperMode or value
                            });
                        end
                    },

                    backgroundColor = {
                        name = BQTL:GetStringWrap('SETTINGS_BACKGROUND_COLOR_NAME'),
                        desc = BQTL:GetStringWrap('SETTINGS_BACKGROUND_COLOR_DESC'),
                        arg = "BackgroundColor",
                        type = "color",
                        order = order(),
                        hasAlpha = true,

                        get = GetColor,
                        set = function(info, r, g, b, a)
                            SetColor(info, r, g, b, a);

                            BQT.tracker:UpdateSettings({
                                backgroundColor = BQT.db.global.BackgroundColor
                            });
                        end
                    },

                    spacer1 = Spacer(),

                    trackerHeaderSettings = {
                        name = "追踪器顶部标题设置",
                        type = "group",
                        inline = true,
                        order = order(),

                        args = {
                            enabled = {
                                name = BQTL:GetStringWrap('SETTINGS_ENABLED_NAME'),
                                desc = BQTL:GetStringWrap('SETTINGS_TRACKER_HEADER_ENABLED_DESC'),
                                arg = "TrackerHeaderEnabled",
                                type = "toggle",
                                order = order(),

                                set = SetAndRefreshView
                            },

                            spacer1 = Spacer({
                                width = 1.1
                            }),

                            format = {
                                name = BQTL:GetStringWrap('SETTINGS_FORMAT_NAME'),
                                desc = BQTL:GetStringWrap('SETTINGS_TRACKER_HEADER_FORMAT_DESC'),
                                arg = "TrackerHeaderFormat",
                                type = "select",
                                order = order(),

                                values = function()
                                    return {
                                        Quests = BQTL:GetString('SETTINGS_TRACKER_HEADER_FORMAT_QUESTS_OPTION'),
                                        QuestsNumberVisible = BQTL:GetString('SETTINGS_TRACKER_HEADER_FORMAT_QUESTS_NUMBER_VISIBLE_OPTION'),
                                        QuestsNumberVisibleTotal = BQTL:GetString('SETTINGS_TRACKER_HEADER_FORMAT_QUESTS_NUMBER_VISIBLE_TOTAL_OPTION')
                                    };
                                end,

                                sorting = {
                                    "Quests",
                                    "QuestsNumberVisible",
                                    "QuestsNumberVisibleTotal"
                                },

                                set = function(...)
                                    SetInDB(...);

                                    BQT:RefreshView();
                                end,

                                disabled = function() return not BQT.db.global.TrackerHeaderEnabled end
                            },

                            spacer2 = Spacer(),

                            fontSize = {
                                name = BQTL:GetStringWrap('SETTINGS_FONT_SIZE_NAME'),
                                arg = "TrackerHeaderFontSize",
                                type = "range",
                                min = 4,
                                max = 20,
                                step = 1,
                                order = order(),

                                set = SetAndRefreshView,

                                disabled = function() return not BQT.db.global.TrackerHeaderEnabled end
                            },

                            spacer3 = Spacer({
                                width = 1.1
                            }),

                            fontColor = {
                                name = BQTL:GetStringWrap('SETTINGS_FONT_COLOR_NAME'),
                                arg = "TrackerHeaderFontColor",
                                type = "color",
                                order = order(),
                                hasAlpha = false,

                                get = GetColor,
                                set = function(info, r, g, b)
                                    SetColor(info, r, g, b);

                                    BQT:RefreshView();
                                end,

                                disabled = function() return not BQT.db.global.TrackerHeaderEnabled end
                            },
                        }
                    },

                    zoneHeaderSettings = {
                        name = "任务地区标题设置",
                        type = "group",
                        inline = true,
                        order = order(),

                        args = {
                            enabled = {
                                name = BQTL:GetStringWrap('SETTINGS_ENABLED_NAME'),
                                desc = BQTL:GetStringWrap('SETTINGS_ZONE_HEADER_ENABLED_DESC'),
                                arg = "ZoneHeaderEnabled",
                                type = "toggle",
                                order = order(),

                                set = SetAndRefreshView
                            },

                            spacer2 = Spacer(),

                            fontSize = {
                                name = BQTL:GetStringWrap('SETTINGS_FONT_SIZE_NAME'),
                                arg = "ZoneHeaderFontSize",
                                type = "range",
                                min = 4,
                                max = 20,
                                step = 1,
                                order = order(),

                                set = SetAndRefreshView,

                                disabled = function() return not BQT.db.global.ZoneHeaderEnabled end
                            },

                            spacer3 = Spacer({
                                width = 1.1
                            }),

                            fontColor = {
                                name = BQTL:GetStringWrap('SETTINGS_FONT_COLOR_NAME'),
                                arg = "ZoneHeaderFontColor",
                                type = "color",
                                order = order(),
                                hasAlpha = false,

                                get = GetColor,
                                set = function(info, r, g, b)
                                    SetColor(info, r, g, b);

                                    BQT:RefreshView();
                                end,

                                disabled = function() return not BQT.db.global.ZoneHeaderEnabled end
                            },
                        }
                    },

                    questHeaderSettings = {
                        name = "任务标题设置",
                        type = "group",
                        inline = true,
                        order = order(),

                        args = {
                            questPadding = {
                                name = BQTL:GetStringWrap('SETTINGS_QUEST_PADDING_NAME'),
                                arg = "QuestPadding",
                                type = "range",
                                min = 0,
                                max = 20,
                                step = 1,
                                order = order(),

                                set = SetAndRefreshView
                            },

                            spacer1 = Spacer({
                                width = 1.1
                            }),

                            format = {
                                name = BQTL:GetStringWrap('SETTINGS_FORMAT_NAME'),
                                desc = BQTL:GetStringWrap('SETTINGS_QUEST_HEADER_FORMAT_DESC'),
                                arg = "QuestHeaderFormat",
                                type = "input",
                                order = order(),

                                set = SetAndRefreshView
                            },

                            spacer2 = Spacer(),

                            colorHeadersByDifficultyLevel = {
                                name = BQTL:GetStringWrap('SETTINGS_COLOR_HEADERS_BY_DIFFICULTY_NAME'),
                                desc = BQTL:GetStringWrap('SETTINGS_COLOR_HEADERS_BY_DIFFICULTY_DESC'),
                                arg = "ColorHeadersByDifficultyLevel",
                                type = "toggle",
                                width = 1.4,
                                order = order(),

                                set = SetAndRefreshView
                            },

                            spacer3 = Spacer({
                                width = 0.7
                            }),

                            fontColor = {
                                name = BQTL:GetStringWrap('SETTINGS_FONT_COLOR_NAME'),
                                arg = "QuestHeaderFontColor",
                                type = "color",
                                order = order(),
                                hasAlpha = false,

                                get = GetColor,
                                set = function(info, r, g, b)
                                    SetColor(info, r, g, b);

                                    BQT:RefreshView();
                                end,

                                disabled = function() return BQT.db.global.ColorHeadersByDifficultyLevel end
                            },

                            spacer4 = Spacer(),

                            fontSize = {
                                name = BQTL:GetStringWrap('SETTINGS_FONT_SIZE_NAME'),
                                arg = "QuestHeaderFontSize",
                                type = "range",
                                min = 4,
                                max = 20,
                                step = 1,
                                order = order(),

                                set = SetAndRefreshView
                            },
                        }
                    },

                    objectiveSettings = {
                        name = "任务目标设置",
                        type = "group",
                        inline = true,
                        order = order(),

                        args = {
                            fontSize = {
                                name = BQTL:GetStringWrap('SETTINGS_FONT_SIZE_NAME'),
                                arg = "ObjectiveFontSize",
                                type = "range",
                                min = 4,
                                max = 20,
                                step = 1,
                                order = order(),

                                set = SetAndRefreshView
                            },

                            spacer3 = Spacer({
                                width = 1.1
                            }),

                            fontColor = {
                                name = BQTL:GetStringWrap('SETTINGS_FONT_COLOR_NAME'),
                                arg = "ObjectiveFontColor",
                                type = "color",
                                order = order(),
                                hasAlpha = false,

                                get = GetColor,
                                set = function(info, r, g, b)
                                    SetColor(info, r, g, b);

                                    BQT:RefreshView();
                                end
                            },
                        }
                    },

                    spacerEnd = Spacer({
                        size = "large"
                    }),
                }
            },

            frameSettings = {
                name = BQTL:GetStringWrap('SETTINGS_FRAME_TAB'),
                type = "group",
                order = order(),

                args = {
                    lockFrame = {
                        name = BQTL:GetStringWrap('SETTINGS_LOCK_FRAME_NAME'),
                        desc = BQTL:GetStringWrap('SETTINGS_LOCK_FRAME_DESC'),
                        arg = "LockFrame",
                        type = "toggle",
                        order = order(),

                        set = function(info, value)
                            SetInDB(info, value);

                            BQT.tracker:UpdateSettings({
                                locked = value
                            });
                        end
                    },

                    spacer0 = Spacer(),

                    positionX = {
                        name = BQTL:GetStringWrap('SETTINGS_POSITIONX_NAME'),
                        arg = "PositionX",
                        type = "range",
                        width = 1.6,
                        min = 0,
                        max = math.ceil(GetScreenWidth()),
                        step = 0.01,
                        bigStep = 10,
                        order = order(),

                        get = function(info)
                            return -GetFromDB(info);
                        end,

                        set = function(info, value)
                            SetInDB(info, -value);

                            BQT.tracker:UpdateSettings({
                                position = {
                                    x = -value
                                }
                            });
                        end
                    },

                    positionY = {
                        name = BQTL:GetStringWrap('SETTINGS_POSITIONY_NAME'),
                        arg = "PositionY",
                        type = "range",
                        width = 1.6,
                        min = 0,
                        max = math.ceil(GetScreenHeight());
                        step = 0.01,
                        bigStep = 10,
                        order = order(),

                        get = function(info)
                            return -GetFromDB(info);
                        end,

                        set = function(info, value)
                            SetInDB(info, -value);

                            BQT.tracker:UpdateSettings({
                                position = {
                                    y = -value
                                }
                            });
                        end
                    },

                    spacer1 = Spacer(),

                    width = {
                        name = BQTL:GetStringWrap('SETTINGS_WIDTH_NAME'),
                        arg = "Width",
                        type = "range",
                        width = 1.6,
                        min = 100,
                        max = 400,
                        step = 1,
                        bigStep = 10,
                        order = order(),

                        set = function(info, value)
                            SetInDB(info, value);

                            BQT.tracker:UpdateSettings({
                                width = value
                            });
                        end
                    },

                    maxHeight = {
                        name = BQTL:GetStringWrap('SETTINGS_MAX_HEIGHT_NAME'),
                        arg = "MaxHeight",
                        type = "range",
                        width = 1.6,
                        min = 100,
                        max = math.ceil(GetScreenHeight() * UIParent:GetEffectiveScale()),
                        step = 1,
                        bigStep = 10,
                        order = order(),

                        set = function(info, value)
                            SetInDB(info, value);

                            BQT.tracker:UpdateSettings({
                                maxHeight = value
                            });
                        end
                    },

                    spacer2 = Spacer(),

                    resetPosition = {
                        name = BQTL:GetStringWrap('SETTINGS_RESET_POSITION_NAME'),
                        type = "execute",
                        width = 0.8,
                        order = order(),

                        func = function()
                            BQT.db.global.PositionX = ns.CONSTANTS.DB_DEFAULTS.global.PositionX;
                            BQT.db.global.PositionY = ns.CONSTANTS.DB_DEFAULTS.global.PositionY;

                            BQT.tracker:UpdateSettings({
                                position = {
                                    x = BQT.db.global.PositionX,
                                    y = BQT.db.global.PositionY
                                }
                            });
                        end
                    },

                    resetSize = {
                        name = BQTL:GetStringWrap('SETTINGS_RESET_SIZE_NAME'),
                        type = "execute",
                        width = 0.7,
                        order = order(),

                        func = function()
                            BQT.db.global.Width = ns.CONSTANTS.DB_DEFAULTS.global.Width;
                            BQT.db.global.MaxHeight = ns.CONSTANTS.DB_DEFAULTS.global.MaxHeight;

                            BQT.tracker:UpdateSettings({
                                width = BQT.db.global.Width,
                                maxHeight = BQT.db.global.MaxHeight
                            });
                        end
                    },

                    spacerEnd = Spacer({
                        size = "large"
                    }),
                }
            },

            advanced = {
                name = BQTL:GetStringWrap('SETTINGS_ADVANCED_TAB'),
                type = "group",
                order = order(),

                args = {
                    developerOptionsHeader = {
                        name = BQTL:GetStringWrap('SETTINGS_DEVELOPER_HEADER'),
                        type = "header",
                        order = order(),
                    },

                    spacer1 = Spacer(),

                    developerMode = {
                        name = BQTL:GetStringWrap('SETTINGS_DEVELOPER_MODE_NAME'),
                        desc = BQTL:GetStringWrap('SETTINGS_DEVELOPER_MODE_DESC'),
                        arg = "DeveloperMode",
                        type = "toggle",
                        order = order(),

                        set = function(info, value)
                            SetAndRefreshView(info, value);

                            BQT.tracker:UpdateSettings({
                                backgroundVisible = BQT.db.global.BackgroundAlwaysVisible or value
                            });
                        end
                    },

                    spacer2 = Spacer(),

                    debugLevel = {
                        name = BQTL:GetStringWrap('SETTINGS_DEBUG_LEVEL_NAME'),
                        desc = "ERROR = 1\nWARN = 2\nINFO = 3\nTRACE = 4",
                        arg = "DebugLevel",
                        type = "range",
                        min = 1,
                        max = 4,
                        step = 1,
                        order = order(),

                        disabled = function()
                            return not BQT.db.global.DeveloperMode;
                        end
                    },

                    spacer3 = Spacer(),

                    localeHeader = {
                        name = BQTL:GetStringWrap('SETTINGS_LOCALE_HEADER'),
                        type = "header",
                        order = order(),
                    },

                    spacer4 = Spacer(),

                    locale = {
                        name = BQTL:GetStringWrap('SETTINGS_LOCALE_NAME'),
                        type = "select",
                        style = 'dropdown',
                        order = order(),

                        values = {
                            ['enUS'] = 'English',
                            -- ['esES'] = 'Español',
                            -- ['ptBR'] = 'Português',
                            -- ['frFR'] = 'Français',
                            -- ['deDE'] = 'Deutsch',
                            ['ruRU'] = 'русский',
                            ['zhCN'] = '简体中文',
                            -- ['zhTW'] = '正體中文',
                            -- ['koKR'] = '한국어'
                        },

                        get = function() return BQTL:GetLocale() end,
                        set = function(input, locale)
                            BQT.db.global.Locale = locale;
                            BQTL:SetLocale(locale);
                            BQT:RefreshView();
                        end,
                    },

                    spacer5 = Spacer(),

                    resetHeader = {
                        name = BQTL:GetStringWrap('SETTINGS_RESET_HEADER'),
                        type = "header",
                        order = order(),
                    },

                    spacer6 = Spacer(),

                    resetDescription = {
                        name = BQTL:GetStringWrap('SETTINGS_RESET_TEXT'),
                        type = "description",
                        fontSize = "medium",
                        order = order(),
                    },

                    spacer7 = Spacer(),

                    reset = {
                        name = BQTL:GetStringWrap('SETTINGS_RESET_NAME'),
                        desc = BQTL:GetStringWrap('SETTINGS_RESET_DESC'),
                        type = "execute",
                        width = 1.0,
                        order = order(),

                        func = function()
                            for k, v in pairs(ns.CONSTANTS.DB_DEFAULTS.global) do
                            BQT.db.global[k] = v
                            end

                            for k, v in pairs(ns.CONSTANTS.DB_DEFAULTS.char) do
                            BQT.db.char[k] = v
                            end

                            BQT.tracker:UpdateSettings({
                                position = {
                                    x = BQT.db.global.PositionX,
                                    y = BQT.db.global.PositionY
                                },

                                width = BQT.db.global.Width,
                                maxHeight = BQT.db.global.MaxHeight,

                                backgroundColor = BQT.db.global.BackgroundColor,

                                backgroundVisible = BQT.db.global.BackgroundAlwaysVisible,

                                locked = BQT.db.global.LockFrame
                            });

                            BQT:RefreshQuestWatch();
                            BQT:RefreshView();
                        end
                    },

                    spacer8 = Spacer(),

                    advert = {
                        name = BQTL:GetStringWrap('SETTINGS_ADVERT_TEXT'),
                        type = "description",
                        fontSize = "medium",
                        order = order(),
                    },

                    spacerEnd = Spacer({
                        size = "large"
                    }),
                }
            },
        },
    }
end);
ACD:AddToBlizOptions("ButterQuestTracker");

InterfaceOptionsFrame:HookScript("OnShow", function()
    if BQT.db.global.DisplayDummyData then
        BQT:RefreshView();
    end
end);

InterfaceOptionsFrame:HookScript("OnHide", function()
    if BQT.db.global.DisplayDummyData then
        BQT:RefreshView();
    end
end);

-- Handling ButterQuestTracker's options.
SLASH_BUTTER_QUEST_TRACKER_COMMAND1 = '/bqt'
SlashCmdList['BUTTER_QUEST_TRACKER_COMMAND'] = function(command)
    if command == "" then
        if InterfaceOptionsFrame:IsShown() then
            InterfaceOptionsFrame:Hide();
        else
            InterfaceOptionsFrame:Show();
            InterfaceOptionsFrame_OpenToCategory("ButterQuestTracker");
        end
    elseif command == "reset" then
        print('command', command);
    end
end
