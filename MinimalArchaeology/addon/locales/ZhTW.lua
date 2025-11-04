-- If you would like to help with translations, please use https://curseforge.com/wow/addons/minimal-archaeology/localization
local L = LibStub("AceLocale-3.0"):NewLocale("MinArch", "zhTW")
if not L then return end

--[[Translation missing --]]
L["BINDINGS_COMMANDS"] = "Commands"
--[[Translation missing --]]
L["BINDINGS_COMPANION_MORE"] = "Companion related commands, for more information type:"
--[[Translation missing --]]
L["BINDINGS_COMPANION_RESETPOS"] = "Resets the position of the Companion box"
--[[Translation missing --]]
L["BINDINGS_HIDEMAIN"] = "Hide the main Minimal Archaeology Frame"
--[[Translation missing --]]
L["BINDINGS_MINARCH_CASTSURVEY"] = "Cast Survey"
--[[Translation missing --]]
L["BINDINGS_MINARCH_COMPANION_COMMANDS"] = "Minimal Archaeology Companion related Commands"
--[[Translation missing --]]
L["BINDINGS_MINARCH_MAIN_COMMANDS"] = "Minimal Archaeology Commands"
--[[Translation missing --]]
L["BINDINGS_MINARCH_SHOWHIDE"] = "Show/Hide Minimal Archaeology"
--[[Translation missing --]]
L["BINDINGS_MINARCH_VERSION"] = "Display the running version of Minimal Archaeology"
--[[Translation missing --]]
L["BINDINGS_SHOWMAIN"] = "Show the main Minimal Archaeology Frame"
--[[Translation missing --]]
L["BINDINGS_TOGGLEMAIN"] = "Toggle the main Minimal Archaeology Frame"
--[[Translation missing --]]
L["BINDINGS_USAGE"] = "Usage"
--[[Translation missing --]]
L["COMPANION_TUTORIAL_1"] = "This is the Mininimal Archaeology Companion frame with distance tracker and more.|n|n|cFFFFD100[Right-Click]|r to disable this tutorial tooltip and to show customization settings."
--[[Translation missing --]]
L["DATABROKER_HINT_ALT_LEFTCLICK"] = "Alt + Left-Click to hide every MinArch window."
--[[Translation missing --]]
L["DATABROKER_HINT_CTRL_LEFTCLICK"] = "Ctrl + Left-Click to toggle MinArch dig sites window."
--[[Translation missing --]]
L["DATABROKER_HINT_LEFTCLICK"] = "Hint: Left-Click to toggle MinArch main window."
--[[Translation missing --]]
L["DATABROKER_HINT_RIGHTCLICK"] = "Right-click to open settings"
--[[Translation missing --]]
L["DATABROKER_HINT_SHIFT_LEFTCLICK"] = "Shift + Left-Click to toggle MinArch history window."
--[[Translation missing --]]
L["DIGSITES_DIGSITE"] = "Digsite"
L["GLOBAL_BROKEN_ISLES"] = "破碎群島"
L["GLOBAL_DRAENOR"] = "德拉諾"
L["GLOBAL_EASTERN_KINGDOMS"] = "東部王國"
L["GLOBAL_KALIMDOR"] = "卡林多"
L["GLOBAL_KUL_TIRAS"] = "庫爾提拉斯"
L["GLOBAL_NORTHREND"] = "北裂境"
L["GLOBAL_OUTLAND"] = "外域"
L["GLOBAL_PANDARIA"] = "潘達利亞"
L["GLOBAL_ZANDALAR"] = "贊達拉"
--[[Translation missing --]]
L["HISTORY_SOLVE_CONFIRMATION_ALWAYS"] = "Yes, always!"
--[[Translation missing --]]
L["HISTORY_SOLVE_CONFIRMATION_NO"] = "No"
--[[Translation missing --]]
L["HISTORY_SOLVE_CONFIRMATION_QUESTION"] = "Are you sure you want to solve this artifact for this fragment-capped race?"
--[[Translation missing --]]
L["HISTORY_SOLVE_CONFIRMATION_YES"] = "Yes"
--[[Translation missing --]]
L["HISTORY_TOOLTIP_PROGRESSINFO"] = "Artifact Progress Information"
--[[Translation missing --]]
L["HISTORY_TOTAL"] = "Total"
--[[Translation missing --]]
L["NAVIGATION_CLOSEST"] = "closest"
--[[Translation missing --]]
L["NAVIGATION_FLIGHTMASTER"] = "Flight Master"
--[[Translation missing --]]
L["OPTIONS_AUTOHIDE_TITLE"] = "Auto-hide main window"
--[[Translation missing --]]
L["OPTIONS_AUTOSHOW_CAP_DESC"] = "Auto-show Minimal Archaeology when the fragment cap is reached with a race."
--[[Translation missing --]]
L["OPTIONS_AUTOSHOW_CAP_TITLE"] = "Show on cap"
--[[Translation missing --]]
L["OPTIONS_AUTOSHOW_DIGSITES_DESC"] = "Auto-show Minimal Archaeology when moving around in a digsite."
--[[Translation missing --]]
L["OPTIONS_AUTOSHOW_DIGSITES_TITLE"] = "Show in digsites"
--[[Translation missing --]]
L["OPTIONS_AUTOSHOW_SOLVES_DESC"] = "Auto-show Minimal Archaeology when a solve becomes available."
--[[Translation missing --]]
L["OPTIONS_AUTOSHOW_SOLVES_TITLE"] = "Show for solves"
--[[Translation missing --]]
L["OPTIONS_AUTOSHOW_SURVEY_DESC"] = "Auto-show Minimal Archaeology when surveying in a digsite."
--[[Translation missing --]]
L["OPTIONS_AUTOSHOW_SURVEY_TITLE"] = "Show when surveying"
--[[Translation missing --]]
L["OPTIONS_AUTOSHOW_TITLE"] = "Auto-show main window"
--[[Translation missing --]]
L["OPTIONS_COMPANION_DESCRIPTION"] = "The |cFFF96854Companion|r is a tiny floating window that features a skill bar, distance tracker, and buttons for waypoints, solves, crates and a button for summoning a random mount. Each button can be disabled and you can also customize their order. The Companion has separate scaling and auto-show/auto-hide functionality from the rest of the windows."
--[[Translation missing --]]
L["OPTIONS_COMPANION_FEATURES_TITLE"] = "Customize Companion features"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_ALWAYS_SHOW_DESC"] = "Enable to always show the companion frame, even if you're not in a digsite (except in instances and if 'Hide in combat' is enabled)."
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_ALWAYS_SHOW_TITLE"] = "Always show"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_COLORING_BG_TITLE"] = "Background color"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_COLORING_OPACITY_TITLE"] = "Background opacity"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_COLORING_TITLE"] = "|nColoring"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_ENABLE_DESC"] = "Toggles the Companion frame plugin of MinArch. The companion is a tiny frame with a distance tracker and waypoint/survey/solve/crate buttons."
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_ENABLE_TITLE"] = "Enable the Companion frame"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_HIDEINCOMBAT_DESC"] = "Enable to hide in combat (even if alway show is enabled)."
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_HIDEINCOMBAT_TITLE"] = "Hide in combat"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_HIDENA_DESC"] = "Enable to hide when there are no digsites available on the world map."
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_HIDENA_TITLE"] = "Hide when unavailable"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_SIZING_PADDING_DESC"] = "Set the size of the padding of the Companion frame. Default: 3."
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_SIZING_PADDING_TITLE"] = "Padding size"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_SIZING_SCALE_DESC"] = "Set the size of the companion. Default: 100."
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_SIZING_SCALE_TITLE"] = "Companion scale"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_SIZING_SPACING_DESC"] = "Set the size of the spacing between buttons. Default: 2."
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_SIZING_SPACING_TITLE"] = "Button spacing"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_SIZING_TITLE"] = "Sizing"
--[[Translation missing --]]
L["OPTIONS_COMPANION_GENERAL_TITLE"] = "General Settings"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_CRATE_SHOW_DESC"] = "Show the crate button on the companion frame"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_CRATE_SHOW_TITLE"] = "Show Crate button"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_CRATE_TITLE"] = "Crate button settings"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_DT_SHAPE_TITLE"] = "Shape"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_DT_SHOW_DESC"] = "Toggles the distance tracker on the companion frame"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_DT_SHOW_TITLE"] = "Show distance tracker"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_DT_TITLE"] = "Distance Tracker settings"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_MOUNT_SHOW_DESC"] = "Show the random mount button on the companion frame"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_MOUNT_SHOW_TITLE"] = "Show random mount button"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_MOUNT_TITLE"] = "Random mount button settings"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_PROGBAR_CLICK_DESC"] = "Solve the currently activate artifact when clicking the progress bar"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_PROGBAR_CLICK_TITLE"] = "Solve on click"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_PROGBAR_SHOW_DESC"] = "Display the artifact progress progress bar on the Companion frame"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_PROGBAR_SHOW_TITLE"] = "Show progress bar"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_PROGBAR_TITLE"] = "Progress bar settings"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_PROGBAR_TOOLTIP_DESC"] = "Display the artifact tooltip when hovering over the progress bar"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_PROGBAR_TOOLTIP_TITLE"] = "Show tooltip"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SKILLBAR_SHOW_DESC"] = "Display the skill progress bar on the Companion frame"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SKILLBAR_SHOW_TITLE"] = "Show skill bar"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SKILLBAR_TITLE"] = "Skill bar settings"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SOLVE_SHOW_DESC"] = "Show the solve button on the companion frame"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SOLVE_SHOW_KEYSTONES_DESC"] = "Enable to displays keystones on the solve button if available for the current solve. Also allows you to and apply/remove keystones (if auto-apply is not set)"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SOLVE_SHOW_KEYSTONES_TITLE"] = "Show keystones"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SOLVE_SHOW_NEAREST_DESC"] = "Enable to displays the project related to the nearest digsite, even if you can't solve the project yet"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SOLVE_SHOW_NEAREST_TITLE"] = "Show artifacts in progress"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SOLVE_SHOW_RELEVANT_DESC"] = "Enable to only show solves for relevant races (customized in the Races section)"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SOLVE_SHOW_RELEVANT_TITLE"] = "Only show relevant"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SOLVE_SHOW_SOLVABLE_DESC"] = "Enable to override the previous setting by displaying projects that can be solved, even if it's not related to the nearest digsite"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SOLVE_SHOW_SOLVABLE_TITLE"] = "Always show solvable artifacts"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SOLVE_SHOW_TITLE"] = "Show Solve button"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SOLVE_TITLE"] = "Solve button settings"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SURVEY_SHOW_DESC"] = "Show the survey button on the companion frame"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SURVEY_SHOW_TITLE"] = "Show Survey button"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_SURVEY_TITLE"] = "Survey button settings"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_WP_SHOW_DESC"] = "Show the auto-waypoint button on the companion frame"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_WP_SHOW_TITLE"] = "Show waypoint button"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_FEATURES_WP_TITLE"] = "Waypoint button settings"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_HOFFSET_DESC"] = "Horizontal position on the screen"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_HOFFSET_TITLE"] = "Horizontal offset"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_LOCK_DESC"] = "Disables dragging on the companion frame, but you can still move it by modifying the offset manually on this options page."
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_LOCK_TITLE"] = "Lock in place"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_RESET"] = "Reset position"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_SAVEPOS_DESC"] = "Enable to save position in settings profile so the companion will be in the same spot on all your characters using the same settings profile."
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_SAVEPOS_TITLE"] = "Save position in profile"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_TITLE"] = "Positioning"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_VOFFSET_DESC"] = "Vertical position on the screen"
--[[Translation missing --]]
L["OPTIONS_COMPANION_POSITION_VOFFSET_TITLE"] = "Vertical offset"
--[[Translation missing --]]
L["OPTIONS_COMPANION_TITLE"] = "Companion Settings"
--[[Translation missing --]]
L["OPTIONS_DEV_DEBUG_DEV_DESC"] = "Show debug messages in the chat. Debug messages show more detailed information about the addon than status messages."
--[[Translation missing --]]
L["OPTIONS_DEV_DEBUG_DEV_TITLE"] = "Show debug messages"
--[[Translation missing --]]
L["OPTIONS_DEV_DEBUG_STATUS_DESC"] = "Show Minimal Archaeology status messages in the chat."
--[[Translation missing --]]
L["OPTIONS_DEV_DEBUG_STATUS_TITLE"] = "Show status messages"
--[[Translation missing --]]
L["OPTIONS_DEV_DEBUG_TITLE"] = "Debug messages"
--[[Translation missing --]]
L["OPTIONS_DEV_EXPERIMENTAL_DESC"] = "Experimental Features are placed here, because they're in a beta state, and might need additional work and feedback. Experimental features can be used without debug messages enabled, but I might ask for them in some cases if there are any issues."
--[[Translation missing --]]
L["OPTIONS_DEV_EXPERIMENTAL_OPTIMIZE_DESC"] = "The waypoint will not always point to the nearest site, but tries to optimize travel times on the long run."
--[[Translation missing --]]
L["OPTIONS_DEV_EXPERIMENTAL_OPTIMIZE_MOD_DESC"] = "Sets the optimization modifier to a custom value."
--[[Translation missing --]]
L["OPTIONS_DEV_EXPERIMENTAL_OPTIMIZE_MOD_TITLE"] = "Optimization Modifier"
--[[Translation missing --]]
L["OPTIONS_DEV_EXPERIMENTAL_OPTIMIZE_TITLE"] = "Optimize Path"
--[[Translation missing --]]
L["OPTIONS_DEV_EXPERIMENTAL_TITLE"] = "Experimental Features"
--[[Translation missing --]]
L["OPTIONS_DEV_TITLE"] = "Tester/Developer Settings"
--[[Translation missing --]]
L["OPTIONS_DISABLE_SOUND_DESC"] = "Disable the sound that is played when an artifact can be solved."
--[[Translation missing --]]
L["OPTIONS_DISABLE_SOUND_TITLE"] = "Disable Sound"
--[[Translation missing --]]
L["OPTIONS_GENERAL_MAIN_TITLE"] = "General Settings - Main windows"
--[[Translation missing --]]
L["OPTIONS_GENERAL_MAIN_WINDOWS"] = "Open this section to configure |cFFF96854double right click surveying|r, and the |cFFF96854Main|r, |cFFF96854History|r and |cFFF96854Digsites|r windows. If you're unfamiliar with MinArch, click the buttons below to toggle each specific window."
--[[Translation missing --]]
L["OPTIONS_GENERAL_TITLE"] = "General Settings"
--[[Translation missing --]]
L["OPTIONS_GLOBAL_CIRCLE"] = "Circle"
--[[Translation missing --]]
L["OPTIONS_GLOBAL_ORDER_TITLE"] = "Order"
--[[Translation missing --]]
L["OPTIONS_GLOBAL_SQUARE"] = "Square"
--[[Translation missing --]]
L["OPTIONS_GLOBAL_TRIANGLE"] = "Triangle"
--[[Translation missing --]]
L["OPTIONS_HIDE_AFTER_DIGSITES_DESC"] = "Hide Minimal Archaeology after completing a digsite."
--[[Translation missing --]]
L["OPTIONS_HIDE_AFTER_DIGSITES_TITLE"] = "Auto-hide after digsites"
--[[Translation missing --]]
L["OPTIONS_HIDE_IN_COMBAT_DESC"] = "Hide Minimal Archaeology when combat starts, and re-open it after combat."
--[[Translation missing --]]
L["OPTIONS_HIDE_IN_COMBAT_TITLE"] = "Auto-hide in combat"
--[[Translation missing --]]
L["OPTIONS_HIDE_MINIMAPBUTTON_DESC"] = "Hide the minimap button"
--[[Translation missing --]]
L["OPTIONS_HIDE_MINIMAPBUTTON_TITLE"] = "Hide Minimap Button"
--[[Translation missing --]]
L["OPTIONS_HIDE_WATE_FOR_SOLVES_DESC"] = "Wait until all artifacts are solved before auto-hiding."
--[[Translation missing --]]
L["OPTIONS_HIDE_WATE_FOR_SOLVES_TITLE"] = "Wait to solve artifacts"
--[[Translation missing --]]
L["OPTIONS_HISTORY_AUTORESIZE_DESC"] = "Enable to automatically resize the history window to fit all items"
--[[Translation missing --]]
L["OPTIONS_HISTORY_AUTORESIZE_TITLE"] = "Auto-resize"
--[[Translation missing --]]
L["OPTIONS_HISTORY_GROUP_DESC"] = "If enabled, artifacts will be grouped by progress: current > incomplete > completed."
--[[Translation missing --]]
L["OPTIONS_HISTORY_GROUP_TITLE"] = "Group by progress"
--[[Translation missing --]]
L["OPTIONS_HISTORY_SHOW_STATS_DESC"] = "Show progress and number of total solves for each race."
--[[Translation missing --]]
L["OPTIONS_HISTORY_SHOW_STATS_TITLE"] = "Show statistics"
--[[Translation missing --]]
L["OPTIONS_HISTORY_WINDOW_TITLE"] = "History Window settings"
--[[Translation missing --]]
L["OPTIONS_INTRO"] = "For configuration options, please expand the Minimal Archaeology section on the left. Here's an overview for the addon and the settings:"
--[[Translation missing --]]
L["OPTIONS_MAP_PIN_SCALE_DESC"] = "Scale for the digsite icons on the world map. Reopen your map after changing."
--[[Translation missing --]]
L["OPTIONS_MAP_PIN_SCALE_TITLE"] = "Map Pin Scale"
--[[Translation missing --]]
L["OPTIONS_MISC_TITLE"] = "Miscellaneous options"
--[[Translation missing --]]
L["OPTIONS_NAV_AUTO_CONT_DESC"] = "Continuously create/update the automatic waypoint to the closest digsite."
--[[Translation missing --]]
L["OPTIONS_NAV_AUTO_CONT_TITLE"] = "Continuously"
--[[Translation missing --]]
L["OPTIONS_NAV_AUTO_IGNOREHIDDEN_DESC"] = "Enable this to ignore hidden races when creating waypoints. Note: it will still navigate to a hidden race, if all the currently available digsites belong to that race."
--[[Translation missing --]]
L["OPTIONS_NAV_AUTO_IGNOREHIDDEN_TITLE"] = "Ignore hidden races"
--[[Translation missing --]]
L["OPTIONS_NAV_AUTO_ONCOMPLETE_DESC"] = "Automatically create a waypoint to the closest digsite after completing one."
--[[Translation missing --]]
L["OPTIONS_NAV_AUTO_ONCOMPLETE_TITLE"] = "When completed"
--[[Translation missing --]]
L["OPTIONS_NAV_AUTO_PRIORITY_NOTE"] = "Note: Priority options have been moved to the Race Settings section"
--[[Translation missing --]]
L["OPTIONS_NAV_AUTO_TITLE"] = "Automatically create waypoints for the closest digsite."
--[[Translation missing --]]
L["OPTIONS_NAV_BLIZZ_FLOATPIN_DESC"] = "Enable to show the floating pin over the destination (only available in Mainline)."
--[[Translation missing --]]
L["OPTIONS_NAV_BLIZZ_FLOATPIN_TITLE"] = "Show floating pin"
--[[Translation missing --]]
L["OPTIONS_NAV_BLIZZ_PIN_DESC"] = "Enable to create a map pin over digsites (only available in Mainline)."
--[[Translation missing --]]
L["OPTIONS_NAV_BLIZZ_PIN_TITLE"] = "Map pin"
--[[Translation missing --]]
L["OPTIONS_NAV_BLIZZ_TITLE"] = "Blizzard Waypoints"
--[[Translation missing --]]
L["OPTIONS_NAV_TAXI_AUTODISABLE_DESC"] = "Automatically disable Archaeology Mode on flight maps when there are no digsites on the world map and upon login"
--[[Translation missing --]]
L["OPTIONS_NAV_TAXI_AUTODISABLE_TITLE"] = "Auto-Disable"
--[[Translation missing --]]
L["OPTIONS_NAV_TAXI_AUTOENABLE_DESC"] = "Automatically enable Archeology Mode on flight maps when a waypoint is created by MinArch"
--[[Translation missing --]]
L["OPTIONS_NAV_TAXI_AUTOENABLE_TITLE"] = "Auto Enable"
--[[Translation missing --]]
L["OPTIONS_NAV_TAXI_DISTANCE_DESC"] = "If enabled, waypoints will be created to the nearest flight master, if the nearest digsite is farther than the configured distance limit."
--[[Translation missing --]]
L["OPTIONS_NAV_TAXI_DISTANCE_TITLE"] = "Distance limit"
--[[Translation missing --]]
L["OPTIONS_NAV_TAXI_ENABLE_DESC"] = "Enable to set the waypoint to the nearest flight master, if the nearest digsite is farther than the configured distance limit."
--[[Translation missing --]]
L["OPTIONS_NAV_TAXI_ENABLE_TITLE"] = "Navigate to nearest Flight Master"
--[[Translation missing --]]
L["OPTIONS_NAV_TAXI_PINOPA_DESC"] = "Set the opacity of unrelated taxi nodes on the flight map"
--[[Translation missing --]]
L["OPTIONS_NAV_TAXI_PINOPA_TITLE"] = "Pin Opacity"
--[[Translation missing --]]
L["OPTIONS_NAV_TAXI_TITLE"] = "Taxi Options"
--[[Translation missing --]]
L["OPTIONS_NAV_TITLE"] = "MinArch - TomTom"
--[[Translation missing --]]
L["OPTIONS_NAV_TOMTOM_ARROW_DESC"] = "Show arrow for waypoints created by MinArch. This won't change already existing waypoints."
--[[Translation missing --]]
L["OPTIONS_NAV_TOMTOM_ARROW_TITLE"] = "Show Arrow"
--[[Translation missing --]]
L["OPTIONS_NAV_TOMTOM_ENABLE_DESC"] = "Toggles TomTom integration in MinArch. Disabling TomTom integration will remove all waypoints created by MinArch"
--[[Translation missing --]]
L["OPTIONS_NAV_TOMTOM_ENABLE_TITLE"] = "Enable TomTom integration in MinArch"
--[[Translation missing --]]
L["OPTIONS_NAV_TOMTOM_TITLE"] = "TomTom Options"
--[[Translation missing --]]
L["OPTIONS_NAV_TOMTOM_WP_DESC"] = "Toggle waypoint persistence. This won't change already existing waypoints."
--[[Translation missing --]]
L["OPTIONS_NAV_TOMTOM_WP_TITLE"] = "Persist waypoints"
--[[Translation missing --]]
L["OPTIONS_NAVIGATION_DESCRIPTION"] = "Options for |cFFF96854TomTom|r integration and Blizzard |cFFF96854Waypoint|r system support (if available)."
--[[Translation missing --]]
L["OPTIONS_NAVIGATION_TITLE"] = "Navigation Settings"
--[[Translation missing --]]
L["OPTIONS_PATRONS_DESC"] = "Thanks for using Minimal Archaeology. If you like this addon, please consider supporting development by becoming a patron at |cFFF96854patreon.com/minarch|r."
--[[Translation missing --]]
L["OPTIONS_PATRONS_SUBTITLE"] = "Patrons"
--[[Translation missing --]]
L["OPTIONS_PATRONS_TITLE"] = "MinArch Patrons"
--[[Translation missing --]]
L["OPTIONS_RACE_AFFECTS_BOTH"] = " (affects both Northrend and Eastern Kingdom)"
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_ALWAYS"] = "Always use all available "
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_ALWAYS_USE"] = " artifacts."
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_ALWAYS_USE_TO_SOLVE"] = "s to solve "
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_CONFIRM_DESC"] = "Show confirmation before solving artifacts for races with farming mode enabled"
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_CONFIRM_TITLE"] = "Show confirmation for fragment-capped solves"
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_DESC"] = "If you enable farming mode for a race, the Main window will show the fragment cap for the race instead of the fragments required for the current solve. Useful for collecting fossil fragments for Darkmoon Faire."
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_KEYSTONE_DESC"] = "Automatically applies keystones (uncommon fragments) for checked races."
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_KEYSTONE_FOSSIL_NOTE"] = "Note: There are no keystones for Fossil."
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_KEYSTONE_TITLE"] = "Auto-keystone"
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_PRIORITY_DESC"] = "Priority currently only applies to waypoint generation order. Automatic waypoints will point to the prioritized races before pointing to other (otherwise closer) digsites. Smaller number means higher priority."
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_PRIORITY_RESETALL"] = "Reset All"
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_PRIORITY_TITLE"] = "Priority"
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_TITLE"] = "Farming mode"
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_USE"] = "Use the fragment cap for the "
--[[Translation missing --]]
L["OPTIONS_RACE_CAP_USE_FOR"] = " artifact bar."
--[[Translation missing --]]
L["OPTIONS_RACE_DESCRIPTION"] = "Race related options: |cFFF96854hide|r or |cFFF96854prioritizy|r races, set |cFFF96854farming mode|r or enable |cFFF96854automatic keystone|r application."
--[[Translation missing --]]
L["OPTIONS_RACE_HIDE_DESC"] = "Check races you would like to hide at all times. This overrides relevancy settings.\\n\\n Hidden races won't show up in the main window, and the Companion will not show solves for them."
--[[Translation missing --]]
L["OPTIONS_RACE_HIDE_EVEN"] = " artifact bar even if it has been discovered."
--[[Translation missing --]]
L["OPTIONS_RACE_HIDE_THE"] = "Hide the "
--[[Translation missing --]]
L["OPTIONS_RACE_HIDE_TITLE"] = "Hide"
--[[Translation missing --]]
L["OPTIONS_RACE_HIDE_WPIGNORE_DESC"] = "Enable this to also ignore hidden races when creating waypoints."
--[[Translation missing --]]
L["OPTIONS_RACE_HIDE_WPIGNORE_TITLE"] = "Ignore hidden races when creating waypoints"
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_CUSTOMIZE"] = "Customize relevancy"
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_DESC"] = "Customize which races you would like to be displayed in the Main window when the relevant races switch is toggled.\\n"
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_EXPANSION_DESC"] = "Show races which could be available on your current continent (or expansion), even if they don't have an active digsite at the moment."
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_EXPANSION_TITLE"] = "Expansion-specific"
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_NEARBY_DESC"] = "Show races which have currently available digsites on your current continent."
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_NEARBY_TITLE"] = "Available nearby"
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_OVERRIDE_FRAGCAP_DESC"] = "Enable to treat races with farming mode enabled (fragment-capped) as irrelevant when they have a solve available, but they would be irrelevant based on other relevancy settings."
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_OVERRIDE_FRAGCAP_TITLE"] = "Hide irrelevant solves for races set to Farming mode (fragment-capped)"
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_OVERRIDES_TITLE"] = "Relevancy overrides"
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_SOLVABLE_DESC"] = "Show races which have a solve available, even if they're neither available nor related to your current continent."
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_SOLVABLE_TITLE"] = "Solvable"
--[[Translation missing --]]
L["OPTIONS_RACE_RELEVANCY_TITLE"] = "Relevancy"
--[[Translation missing --]]
L["OPTIONS_RACE_SECTION_TITLE"] = "Race Settings"
--[[Translation missing --]]
L["OPTIONS_RACE_SET"] = "Set "
--[[Translation missing --]]
L["OPTIONS_RACE_SET_PRIORITY"] = " pirority"
--[[Translation missing --]]
L["OPTIONS_RACE_TITLE"] = "Race Settings"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH"] = "Minimal Archaeology"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_COMPANION_SUBTITLE"] = "Companion Settings"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_COMPANION_TITLE"] = "MinArch Companion Settings"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_DEV_SUBTITLE"] = "Developer Settings"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_DEV_TITLE"] = "MinArch Developer Settings"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_GENERAL_SUBTITLE"] = "General Settings"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_GENERAL_TITLE"] = "MinArch General Settings"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_NAV_SUBTITLE"] = "Navigation Settings"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_NAV_TITLE"] = "MinArch Navigation Settings"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_PATRONS_SUBTITLE"] = "Patrons"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_PATRONS_TITLE"] = "MinArch Patrons"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_PROFILES_SUBTITLE"] = "Profiles"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_PROFILES_TITLE"] = "MinArch Profiles"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_RACE_SUBTITLE"] = "Race Settings"
--[[Translation missing --]]
L["OPTIONS_REGISTER_MINARCH_RACE_TITLE"] = "MinArch Race Settings"
--[[Translation missing --]]
L["OPTIONS_REMEMBER_WINDOW_STATES_DESC"] = "Remember which MinArch windows were open when logging out (or reloading UI)."
--[[Translation missing --]]
L["OPTIONS_REMEMBER_WINDOW_STATES_TITLE"] = "Remember window states"
--[[Translation missing --]]
L["OPTIONS_SHOW_WORLD_MAP_ICONS_DESC"] = "Show race icons next to digsites on the world map."
--[[Translation missing --]]
L["OPTIONS_SHOW_WORLD_MAP_ICONS_TITLE"] = "Show world map overlay icons"
--[[Translation missing --]]
L["OPTIONS_START_HIDDEN_DESC"] = "Always start Minimal Archaeology hidden."
--[[Translation missing --]]
L["OPTIONS_START_HIDDEN_TITLE"] = "Start Hidden"
--[[Translation missing --]]
L["OPTIONS_STARTUP_NOTE"] = "Note: these settings do not affect the Companion frame."
--[[Translation missing --]]
L["OPTIONS_STARTUP_SETTINGS_TITLE"] = "Startup settings"
--[[Translation missing --]]
L["OPTIONS_SURVEY_DONT_FLYING_DESC"] = "Check this option to prevent casting survey while you're flying."
--[[Translation missing --]]
L["OPTIONS_SURVEY_DONT_FLYING_TITLE"] = "Don't cast while flying"
--[[Translation missing --]]
L["OPTIONS_SURVEY_DONT_MOUNTED_DESC"] = "Check this option to prevent casting survey while you're mounted."
--[[Translation missing --]]
L["OPTIONS_SURVEY_DONT_MOUNTED_TITLE"] = "Don't cast while mounted"
--[[Translation missing --]]
L["OPTIONS_SURVEY_ON_DBL_CLICK_BTN_DESC"] = "Button for double click surveying."
--[[Translation missing --]]
L["OPTIONS_SURVEY_ON_DBL_CLICK_BTN_LMB"] = "Left Mouse Button"
--[[Translation missing --]]
L["OPTIONS_SURVEY_ON_DBL_CLICK_BTN_RMB"] = "Right Mouse Button"
--[[Translation missing --]]
L["OPTIONS_SURVEY_ON_DBL_CLICK_BTN_TITLE"] = "Double click button"
--[[Translation missing --]]
L["OPTIONS_SURVEY_ON_DBL_RCLICK_DESC"] = "Enable to cast survey when you double-click with your right mouse button."
--[[Translation missing --]]
L["OPTIONS_SURVEY_ON_DBL_RCLICK_TITLE"] = "Survey on Double Right Click"
--[[Translation missing --]]
L["OPTIONS_SURVEYING_TITLE"] = "Surveying"
--[[Translation missing --]]
L["OPTIONS_THANKS"] = "Thanks for using Minimal Archaeology"
--[[Translation missing --]]
L["OPTIONS_TOGGLE_DIGSITES"] = "Toggle Digsites"
--[[Translation missing --]]
L["OPTIONS_TOGGLE_HISTORY"] = "Toggle History"
--[[Translation missing --]]
L["OPTIONS_TOGGLE_MAIN"] = "Toggle Main"
--[[Translation missing --]]
L["OPTIONS_WINDOW_SCALE_DESC"] = "Scale for the Main, History and Digsites windows. The Companion is scaled using a separate slider in the Companion section."
--[[Translation missing --]]
L["OPTIONS_WINDOW_SCALE_TITLE"] = "Window Scale"
--[[Translation missing --]]
L["TOOLTIP_CRATE_BUTTON_LEFTCLICK"] = "Click to crate this artifact"
--[[Translation missing --]]
L["TOOLTIP_CRATE_BUTTON_RIGHTCLICK"] = "You don't have anything to crate."
--[[Translation missing --]]
L["TOOLTIP_DIGSITE_TAXI_TRAVEL"] = "Hint: Left-Click to travel here."
--[[Translation missing --]]
L["TOOLTIP_DIGSITE_WP"] = "Hint: Left-Click to create waypoint here."
--[[Translation missing --]]
L["TOOLTIP_FRAGMENTS"] = "fragments"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_AUTORESIZE_DISABLE"] = "Click to set the height of the History window to a fixed size|r"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_AUTORESIZE_ENABLE"] = "Click to enable automatic resizing for the History window"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_DISCOVEREDON"] = "Discovered On"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_HAVENT_DISCOVERED"] = "You haven't discovered this race yet."
--[[Translation missing --]]
L["TOOLTIP_HISTORY_LEGIONQUEST_AVAILABLE"] = "Currently available from the bi-weekly Legion quest"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_PRISTINE_COMPLETE"] = "Pristine version already found"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_PRISTINE_INCOMPLETE"] = "Pristine version not found yet"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_PRISTINE_ONQUEST"] = "Pristine version found, but not yet handed in"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_PROGRESS_ACHI_COMPLETE"] = "Collector achievement completed"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_PROGRESS_ACHI_INCOMPLETE"] = "Collector achievement in progress: "
--[[Translation missing --]]
L["TOOLTIP_HISTORY_PROGRESS_CURRENT"] = "Currently available for this race"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_PROGRESS_KNOWN"] = "Completed |cFFDDDDDD"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_PROGRESS_PLURAL"] = "times"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_PROGRESS_SINGULAR"] = "time"
--[[Translation missing --]]
L["TOOLTIP_HISTORY_PROGRESS_UNKNOWN"] = "You haven't found this artifact yet"
--[[Translation missing --]]
L["TOOLTIP_KEYSTONES_LEFTCLICK"] = "Left click to apply a keystone"
--[[Translation missing --]]
L["TOOLTIP_KEYSTONES_RIGHTCLICK"] = "Right click to remove a keystone"
--[[Translation missing --]]
L["TOOLTIP_KEYSTONES_YOUHAVE"] = "You have"
--[[Translation missing --]]
L["TOOLTIP_KEYSTONES_YOUHAVE_INYOURBAGS"] = "in your bags"
--[[Translation missing --]]
L["TOOLTIP_KEYSTONES_YOUHAVE_INYOURBAGS_PLURAL"] = "s"
--[[Translation missing --]]
L["TOOLTIP_LEFTCLICK_SOLVE"] = "Left click to solve this artifact"
--[[Translation missing --]]
L["TOOLTIP_MAIN_RELEVANCY_DISABLE"] = "Show all races. |n|n|cFF00FF00Right click to open settings and customize relevancy options.|r"
--[[Translation missing --]]
L["TOOLTIP_MAIN_RELEVANCY_ENABLE"] = "Only show relevant races. |n|n|cFF00FF00Right click to open settings and customize relevancy options.|r"
--[[Translation missing --]]
L["TOOLTIP_NEW"] = "New"
--[[Translation missing --]]
L["TOOLTIP_OPEN_DIGSITES"] = "Open Digsites"
--[[Translation missing --]]
L["TOOLTIP_OPEN_HISTORY"] = "Open History"
--[[Translation missing --]]
L["TOOLTIP_PROGRESS"] = "Progress"
--[[Translation missing --]]
L["TOOLTIP_PROJECT"] = "Project"
--[[Translation missing --]]
L["TOOLTIP_RACE"] = "Race"
--[[Translation missing --]]
L["TOOLTIP_SOLVABLE"] = "Solvable"
--[[Translation missing --]]
L["TOOLTIP_SURVEY_CANTCAST"] = "Can't be casted right now"
--[[Translation missing --]]
L["TOOLTIP_TAXIFRAME_TOGGLE_DIGSITE"] = "Toggle digsites"
--[[Translation missing --]]
L["TOOLTIP_WP_BUTTON_LEFTCLICK"] = "Left click to create waypoint to the closest available digsite"
--[[Translation missing --]]
L["TOOLTIP_WP_BUTTON_RIGHTCLICK"] = "Right Click to open waypoint settings"

