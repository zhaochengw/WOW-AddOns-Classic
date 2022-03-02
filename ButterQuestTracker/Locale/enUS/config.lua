ButterQuestTrackerLocale.locale['enUS'] = {
    -- Quest Tracker

    ['QT_QUESTS'] = "Quests",
    ['QT_READY_TO_TURN_IN'] = "Ready to turn in",
    ['QT_FAILED'] = "Quest failed, abandon to restart.",
    ['QT_UNTRACK_QUEST'] = "Untrack Quest",
    ['QT_VIEW_QUEST'] = "View Quest",
    ['QT_WOWHEAD_URL'] = "|cff33ff99Wowhead|r URL",
    ['QT_SHARE_QUEST'] = "Share Quest",
    ['QT_CANCEL_QUEST'] = "Cancel Quest",
    ['QT_ABANDON_QUEST'] = "Abandon Quest",

    -- Settings

    ['SETTINGS_NAME'] = "Butter Quest Tracker |cFFFFFFFFv%s|r",
    ['SETTINGS_ENABLED_NAME'] = "Enabled",
    ['SETTINGS_FORMAT_NAME'] = "Format",

    ['SETTINGS_DISPLAY_DUMMY_DATA_NAME'] = "Display Dummy Data",
    ['SETTINGS_DISPLAY_DUMMY_DATA_DESC'] = "Displays dummy data in the tracker to allow you to tweak the visuals easier.\n\nThis also acts like your current zone is Thunder Bluff.",

    -- Settings > Filters & Sorting

    ['SETTINGS_FILTERS_AND_SORTING_TAB'] = "Filters & Sorting",

    ['SETTINGS_AUTO_TRACK_UPDATED_QUESTS_NAME'] = "Automatically Track Updated Quests",
    ['SETTINGS_AUTO_TRACK_UPDATED_QUESTS_DESC'] = "If a quest is accepted / updated it will bypass the filters and be automatically tracked.\n\n|c00FF9696This functionality utilizes the tracking overrides to bypass the filters. As such, disabling this option will also wipe out your overrides.|r",

    ['SETTINGS_SORTING_NAME'] = "Sorting",
    ['SETTINGS_SORTING_DESC'] = "Dictate how quests are sorted in the tracker.",

    ['SETTINGS_AUTO_HIDE_QUEST_HELPER_ICONS_NAME'] = "Automatically Hide Quest Helper Icons",
    ['SETTINGS_AUTO_HIDE_QUEST_HELPER_ICONS_DESC'] = "Enabling this will automatically hide icons from supported Quest Helper Addons.\n\n|c00FF9696Supported Addons: %s",

    ['SETTINGS_SORTING_DISABLED_OPTION'] = "Don't Sort",
    ['SETTINGS_SORTING_BY_LEVEL_OPTION'] = "By Level",
    ['SETTINGS_SORTING_BY_LEVEL_REVERSED_OPTION'] = "By Level (Reversed)",
    ['SETTINGS_SORTING_BY_PERCENT_COMPLETED_OPTION'] = "By %% Completed",
    ['SETTINGS_SORTING_BY_RECENTLY_UPDATED_OPTION'] = "By Recently Updated",
    ['SETTINGS_SORTING_BY_QUEST_PROXIMITY_OPTION'] = "By Quest Proximity",

    -- Settings > Filters & Sorting > Filters

    ['SETTINGS_DISABLE_FILTERS_NAME'] = "Disable Filters / Manually Track Quests",
    ['SETTINGS_DISABLE_FILTERS_DESC'] = "Disables the automatic filtering functionality, requiring you to manually track quests.\n\n|c00FF9696Unchecking this will wipe out your overrides.|r",

    ['SETTINGS_CURRENT_ZONE_ONLY_NAME'] = "Current Zone Only",
    ['SETTINGS_CURRENT_ZONE_ONLY_DESC'] = "Displays quests relevant to the current zone / subzone.",

    ['SETTINGS_QUEST_LIMIT_NAME'] = "Quest Limit",
    ['SETTINGS_QUEST_LIMIT_DESC'] = "Limits the number of quests visible on the screen at a given time.",

    ['SETTINGS_HIDE_COMPLETED_QUESTS_NAME'] = "Hide Completed Quests",
    ['SETTINGS_HIDE_COMPLETED_QUESTS_DESC'] = "Displays quests that have been completed.",

    ['SETTINGS_RESET_TRACKING_OVERRIDES_NAME'] = "Reset Tracking Overrides",
    ['SETTINGS_RESET_TRACKING_OVERRIDES_DESC'] = "Reset's all manual quest watch overrides.",

    -- Settings > Visual Settings

    ['SETTINGS_VISUAL_TAB'] = "Visual Settings",

    ['SETTINGS_FONT_SIZE_NAME'] = "Font Size",
    ['SETTINGS_FONT_COLOR_NAME'] = "Font Color",

    ['SETTINGS_BACKGROUND_ALWAYS_VISIBLE_NAME'] = "Background Always Visible",
    ['SETTINGS_BACKGROUND_ALWAYS_VISIBLE_DESC'] = "The background for the tracker will always be visible.",

    ['SETTINGS_BACKGROUND_COLOR_NAME'] = "Background Color",
    ['SETTINGS_BACKGROUND_COLOR_DESC'] = "The background color of the tracker.",

    ['SETTINGS_QUEST_PADDING_NAME'] = "Quest Padding",

    -- Settings > Visual Settings > Tracker Header Settings

    ['SETTINGS_TRACKER_HEADER_ENABLED_DESC'] = "Whether the tracker header should be visible.",

    ['SETTINGS_TRACKER_HEADER_FORMAT_DESC'] = "How should we format the tracker header?",
    ['SETTINGS_TRACKER_HEADER_FORMAT_QUESTS_OPTION'] = "Quests",
    ['SETTINGS_TRACKER_HEADER_FORMAT_QUESTS_NUMBER_VISIBLE_OPTION'] = "Quests (10/17)",
    ['SETTINGS_TRACKER_HEADER_FORMAT_QUESTS_NUMBER_VISIBLE_TOTAL_OPTION'] = "Quests (10/20)",

    -- Settings > Visual Settings > Zone Header Settings

    ['SETTINGS_ZONE_HEADER_ENABLED_DESC'] = "Adds collapsible zone headers above the quests.",

    -- Settings > Visual Settings > Quest Header Settings

    ['SETTINGS_COLOR_HEADERS_BY_DIFFICULTY_NAME'] = "Color by Difficulty Level",
    ['SETTINGS_COLOR_HEADERS_BY_DIFFICULTY_DESC'] = "Colors the headers by their difficulty level.",

    ['SETTINGS_QUEST_HEADER_FORMAT_DESC'] = "Fine-grained control over the quest header formatting.\n\n|c00FF9696{{title}}|r\nName of the quest.\n\n|c00FF9696{{level}}|r\nThe level of the quest\n\n|c00FF9696{{zone}}|r\nThe zone the quest belongs to",
    ['SETTINGS_QUEST_HEADER_FORMAT_CLASSIC_OPTION'] = "Classic",
    ['SETTINGS_QUEST_HEADER_FORMAT_LEVELS_OPTION'] = "Levels",

    -- Settings > Visual Settings > Objective Settings

    -- Settings > Frame Settings

    ['SETTINGS_FRAME_TAB'] = "Frame Settings",

    ['SETTINGS_LOCK_FRAME_NAME'] = "Lock Frame",
    ['SETTINGS_LOCK_FRAME_DESC'] = "Prevents the frame from being moved.",

    ['SETTINGS_POSITIONX_NAME'] = "Position X",
    ['SETTINGS_POSITIONY_NAME'] = "Position Y",

    ['SETTINGS_WIDTH_NAME'] = "Width",
    ['SETTINGS_MAX_HEIGHT_NAME'] = "Max Height",

    ['SETTINGS_RESET_POSITION_NAME'] = "Reset Position",

    ['SETTINGS_RESET_SIZE_NAME'] = "Reset Size",

    -- Settings > Advanced Settings

    ['SETTINGS_ADVANCED_TAB'] = "Advanced",

    ['SETTINGS_DEVELOPER_HEADER'] = "Developer Options",
    ['SETTINGS_DEVELOPER_MODE_NAME'] = "Developer Mode",
    ['SETTINGS_DEVELOPER_MODE_DESC'] = "Enables logging and other visual helpers.",

    ['SETTINGS_DEBUG_LEVEL_NAME'] = "Debug Level",

    ['SETTINGS_LOCALE_HEADER'] = "Localization Settings",
    ['SETTINGS_LOCALE_NAME'] = "Select UI Locale",

    ['SETTINGS_RESET_HEADER'] = "Reset Butter Quest Tracker",
    ['SETTINGS_RESET_TEXT'] = "Hitting this button will reset all Butter Quest Tracker configuration settings back to their default values.",

    ['SETTINGS_RESET_NAME'] = "Reset Settings",
    ['SETTINGS_RESET_DESC'] = "Reset all of Butter Quest Tracker's settings to their default values.",
    ['SETTINGS_ADVERT_TEXT'] = "|c00FF9696Butter Quest Tracker is under active development for World of Warcraft: Classic. Please check out our GitHub for the alpha builds or to report issues. \n\nhttps://github.com/butter-cookie-kitkat/ButterQuestTracker"
};
