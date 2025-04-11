local myname = ...

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:GetModule("Overlay")
local Debug = core.Debug
local ns = core.NAMESPACE

function module:RegisterConfig()
    local config = core:GetModule("Config", true)
    if not config then return end
    config.options.plugins.overlay = { overlay = {
        type = "group",
        name = "地图覆盖层",
        get = function(info) return self.db.profile[info[#info]] end,
        set = function(info, v)
            self.db.profile[info[#info]] = v
            module:Update()
        end,
        args = {
            display = {
                type = "group",
                name = "显示内容",
                inline = true,
                args = {
                    achieved = {
                        type = "toggle",
                        name = "显示达成情况",
                        desc = "是否显示你已经击杀过的怪物的图标(通过你是否获得了它们的成就进度来判断)",
                        order = 10,
                    },
                    questcomplete = {
                        type = "toggle",
                        name = "显示任务完成情况",
                        desc = "是否显示你已经完成追踪任务的怪物的图标(这可能意味着它们不会再掉落任何物品)",
                        order = 15,
                    },
                    achievementless = {
                        type = "toggle",
                        name = "显示非成就怪物",
                        desc = "是否显示不属于任何已知成就条件的怪物的图标",
                        width = "full",
                        order = 20,
                    },
                    unhide = {
                        type = "execute",
                        name = "重置隐藏的怪物",
                        desc = "显示所有你通过右键点击并选择“隐藏”手动隐藏的节点.",
                        func = function()
                            wipe(self.db.profile.hidden)
                            module:Update()
                        end,
                        order = 50,
                    },
                },
                order = 0,
            },
            icon = {
                type = "group",
                name = "图标设置",
                inline = true,
                args = {
                    desc = {
                        name = "这些设置控制图标的外观和感觉.",
                        type = "description",
                        order = 0,
                    },
                    icon_theme = {
                        type = "select",
                        name = "主题",
                        desc = "使用哪个图标集",
                        values = {
                            ["skulls"] = "骷髅头",
                            ["circles"] = "圆形",
                            ["stars"] = "星星",
                        },
                        order = 40,
                    },
                    icon_color = {
                        type = "select",
                        name = "颜色",
                        desc = "如何给图标上色",
                        values = {
                            ["distinct"] = "每个生物独特的颜色",
                            ["completion"] = "完成状态",
                        },
                        order = 50,
                    },
                },
                order = 10,
            },
            worldmap = {
                type = "group",
                name = "世界地图",
                inline = true,
                get = function(info) return self.db.profile.worldmap[info[#info]] end,
                set = function(info, v)
                    self.db.profile.worldmap[info[#info]] = v
                    module:Update()
                    if WorldMapFrame.RefreshOverlayFrames then
                        WorldMapFrame:RefreshOverlayFrames()
                    end
                end,
                args = {
                    enabled = {
                        type = "toggle",
                        name = "启用",
                        desc = "在世界地图上显示图标",
                        width = "full",
                        order = 0,
                    },
                    icon_scale = {
                        type = "range",
                        name = "图标缩放",
                        desc = "图标的缩放比例",
                        min = 0.25, max = 2, step = 0.01,
                        order = 20,
                    },
                    icon_alpha = {
                        type = "range",
                        name = "图标透明度",
                        desc = "图标的透明度",
                        min = 0, max = 1, step = 0.01,
                        order = 30,
                    },
                    routes = config.toggle("路线", "显示某些生物的行走路径", 40),
                    tooltip_completion = config.toggle("完成", "在工具提示中显示成就/掉落完成情况", 50),
                    tooltip_regularloot = config.toggle("常规战利品", "在工具提示中显示常规的不可追踪战利品", 51),
                    tooltip_lootwindow = config.toggle("弹出宝箱提示", "显示一个弹出窗口，以便查看战利品的详细信息", 52),
                    tooltip_help = config.toggle("帮助", "在工具提示中显示点击快捷方式", 53),
                },
                order = 20,
            },
            minimap = {
                type = "group",
                name = "小地图",
                inline = true,
                get = function(info) return self.db.profile.minimap[info[#info]] end,
                set = function(info, v)
                    self.db.profile.minimap[info[#info]] = v
                    module:Update()
                end,
                args = {
                    enabled = {
                        type = "toggle",
                        name = "启用",
                        desc = "在小地图上显示图标",
                        width = "full",
                        order = 0,
                    },
                    edge = {
                        type = "select",
                        name = "在边缘显示",
                        values = {
                            [module.const.EDGE_NEVER] = "从不",
                            [module.const.EDGE_FOCUS] = "专注",
                            [module.const.EDGE_ALWAYS] = "总是",
                        },
                        order = 10,
                    },
                    icon_scale = {
                        type = "range",
                        name = "图标缩放",
                        desc = "图标的缩放比例",
                        min = 0.25, max = 2, step = 0.01,
                        order = 20,
                    },
                    icon_alpha = {
                        type = "range",
                        name = "图标透明度",
                        desc = "图标的透明度",
                        min = 0, max = 1, step = 0.01,
                        order = 30,
                    },
                    routes = config.toggle("路线", "显示某些怪物的行走路径", 40),
                    tooltip_completion = config.toggle("完成", "在工具提示中显示成就/掉落完成情况", 40),
                    tooltip_regularloot = config.toggle("常规战利品", "在工具提示中显示常规的不可追踪战利品", 41),
                    tooltip_lootwindow = config.toggle("弹出式战利品窗口", "显示一个弹出窗口，以便查看战利品的详细信息", 42),
                    tooltip_help = config.toggle("帮助", "在工具提示中显示点击快捷方式", 43),
                },
                order = 30,
            },
        },
    }, }
end