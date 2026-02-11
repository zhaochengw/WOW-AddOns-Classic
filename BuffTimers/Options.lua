local BuffTimers = LibStub("AceAddon-3.0"):GetAddon("BuffTimers")
local module = BuffTimers:NewModule("Config")
local L = LibStub("AceLocale-3.0"):GetLocale("BuffTimers")
BuffTimersLibSharedMedia = LibStub("LibSharedMedia-3.0", true)
local db

function module:OnInitialize()
    db = BuffTimers.db

    local options = {
        type = "group",
        name = "BuffTimers",
        args = {
            time = {
                type = "group",
                name = L["Time"],
                order = 10,
                args = {
                    formatGroup = {
                        type = "group",
                        name = L["Format"],
                        inline = true,
                        args = {
                            timeFormat = {
                                type = "select",
                                name = L["Time Stamp Format"],
                                desc = L["Choose the format for displaying buff duration"],
                                values = {
                                    ["m"] = "minutes (119m)",
                                    ["hm"] = "h:mm (1:59h)",
                                },
                                get = function() return db.profile.time_stamp end,
                                set = function(_, value) db.profile.time_stamp = value end,
                                order = 1,
                            },
                        },
                    },
                    secondsThresholdGroup = {
                        type = "group",
                        name = L["Seconds"],
                        inline = true,
                        args = {
                            showSeconds = {
                                type = "toggle",
                                name = L["Show seconds"],
                                desc = L["Show seconds for buff timers"],
                                get = function() return db.profile.seconds end,
                                set = function(_, value) db.profile.seconds = value end,
                                order = 2,
                            },
                            secondsThreshold = {
                                type = "range",
                                name = L["Show seconds below this time"],
                                desc = L["Only show seconds when buffs have less than this many minutes"],
                                width = "full",
                                min = 1,
                                max = 120,
                                step = 1,
                                get = function() return db.profile.seconds_threshold end,
                                set = function(_, value) db.profile.seconds_threshold = value end,
                                order = 3,
                            },
                            showMilliseconds = {
                                type = "toggle",
                                name = L["Show milliseconds below 5 seconds"],
                                desc = L["Show milliseconds for buff timers with less than 5 seconds remaining"],
                                width = "full",
                                get = function() return db.profile.milliseconds end,
                                set = function(_, value) db.profile.milliseconds = value end,
                                order = 4,
                            },
                        }
                    }
                }
            },
            textGroup = {
                type = "group",
                name = L["Text"],
                order = 15,
                args = {
                    colorGroup = {  
                        type = "group",
                        name = L["Color"],
                        inline = true,
                        args = {
                            yellowText = {
                                type = "toggle",
                                name = L["Always yellow text color"],
                                desc = L["Always use yellow for buff timer text"],
                                get = function() return db.profile.yellow_text end,
                                set = function(_, value) db.profile.yellow_text = value end,
                                width = "full",
                                order = 1,
                            },
                            coloredText = {
                                type = "toggle",
                                name = L["Add more colors to the timer"],
                                desc = L["Use different colors based on remaining time"],
                                get = function() return db.profile.colored_text end,
                                set = function(_, value) db.profile.colored_text = value end,
                                width = "full",
                                order = 2,
                            },
                        }
                    },
                    customizeTextGroup = {
                        type = "group",
                        name = L["Customization"],
                        inline = true,
                        args = {
                            enableCustomizeText = {
                                type = "toggle",
                                name = L["Enable"],
                                desc = L["Enable text customization"],
                                get = function() return db.profile.customize_text end,
                                set = function(_, value) db.profile.customize_text = value end,
                                width = "full",
                                order = 7,
                            },
                            verticalPosition = {
                                type = "range",
                                name = L["Text vertical position"],
                                desc = L["Adjust the vertical position of the timer text"],
                                min = -100,
                                max = 100,
                                step = 1,
                                get = function() return db.profile.vertical_position end,
                                set = function(_, value) db.profile.vertical_position = value end,
                                order = 8,
                            },
                            fontGroup = {
                                type = "group",
                                name = L["Font"],
                                inline = true,
                                args = {
                                    font = {
                                        type = "select",
                                        name = L["Font"],
                                        desc = L["Choose the font for the timer text"],
                                        values = function()
                                            local fonts = BuffTimersLibSharedMedia:List("font")
                                            local values = {}
                                            for _, font in ipairs(fonts) do
                                                values[font] = font
                                            end
                                            return values
                                        end,
                                        get = function() return db.profile.font end,
                                        set = function(_, value) db.profile.font = value end,
                                        order = 1,
                                    },
                                    fontSize = {
                                        type = "range",
                                        name = L["Font Size"],
                                        desc = L["Adjust the font size of the timer text"],
                                        min = 1,
                                        max = 100,
                                        step = 1,
                                        get = function() return db.profile.font_size end,
                                        set = function(_, value) db.profile.font_size = value end,
                                        order = 2,
                                    },
                                    fontOutline = {
                                        type = "select",
                                        name = L["Outline"],
                                        desc = L["Choose the outline for the timer text"],
                                        values = {
                                            [""] = "None",
                                            ["OUTLINE"] = "Outline",
                                            ["THICK"] = "Thick",
                                            ["MONOCHROME"] = "Monochrome",
                                        },
                                        get = function() return db.profile.font_outline end,
                                        set = function(_, value) db.profile.font_outline = value end,
                                        order = 3,
                                    }
                                }
                            }
                        }
                    }
                },
            },
        },
    }

    -- Register the options with AceConfig
    LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("BuffTimers", options)
    
    -- Create the options panel
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("BuffTimers", "BuffTimers")
end

function module:ShowConfig()
	LibStub("AceConfigDialog-3.0"):Open("BuffTimers")
end

SLASH_BUFFTIMERS1 = "/bufftimers"
function SlashCmdList.BUFFTIMERS()
	module:ShowConfig()
end