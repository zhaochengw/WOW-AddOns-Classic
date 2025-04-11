local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("Config", "AceConsole-3.0")

local function toggle(name, desc, order, inline, disabled)
	return {
		type = "toggle",
		name = name,
		desc = desc,
		order = order,
		descStyle = (inline or (inline == nil)) and "inline" or nil,
		width = (inline or (inline == nil)) and "full" or nil,
		disabled = disabled,
	}
end
module.toggle = toggle
local function desc(text, order)
	return {
		type = "description",
		name = text,
		order = order,
		fontSize = "medium",
	}
end
module.desc = desc

local options = {
	type = "group",
	name = "SilverDragon",
	get = function(info) return core.db.profile[info[#info]] end,
	set = function(info, v) core.db.profile[info[#info]] = v end,
	args = {
		about = {
			type = "group",
			name = "关于",
			args = {
				about = desc("银龙会为你留意稀有怪物.\n\n"..
						"如果你想调整它的工作方式，请前往\"扫描\"部分"..
						"在配置文件的扫描部分，你可以启用或禁用不同的方法，"..
						"并且可以调整其中一些方法的行为方式。\n\n"..
						"如果你想调整目标弹出窗口的显示方式，请前往\"点击目标\"部分\n\n"..
						"如果你想改变得知稀有怪物出现的方式，请查看 输出设置 部分。\n\n"..
						"如果你想添加一个自定义的怪物进行扫描，请查看\"怪物\"部分中的\"自定义\"选项。\n\n"..
						"如果你想让银龙不再提醒你某个特定的怪物，请查看\"怪物\"部分中的\"忽略\"选项。"),
			},
			order = 0,
		},
		general = {
			type = "group",
			name = "常规设置",
			order = 10,
			args = {
				about = desc("银龙想要告诉你一些事情。请查看这里的子部分，以调整它的通知方式.", 0),
				loot = {
					type = "group",
					name = "掉落物品",
					inline = true,
					order = 5,
					args = {
						about = desc("银龙处理怪物掉落物品的一些选项", 0),
						charloot = toggle("仅限当前角色", "仅显示当前角色应掉落的物品.", 10),
						transmog_specific = toggle("精确物品幻化", "对于幻化外观，只有当你确实地获得了该物品的外观，才会被认为已获得，而不是从另一个共享外观的物品获得的外观。", 20),
					}
				},
			},
			plugins = {},
		},
		scanning = {
			type = "group",
			name = "扫描设置",
			order = 20,
			args = {
				about = desc("银龙专注于扫描稀有怪物。你在这个标签页看到的选项通常适用于所有扫描方法。对于更具体的控制，请查看子部分.", 0),
				scan = {
					type = "range",
					name = "扫描间隔",
					desc = "扫描附近稀有怪物的频率，以秒为单位（0 表示禁用扫描）",
					min = 0, max = 10, step = 0.1,
					order = 10,
				},
				delay = {
					type = "range",
					name = "记录延迟",
					desc = "在记录同一个稀有怪物之前等待的时间长度",
					min = 30, max = (60 * 60), step = 10,
					order = 20,
				},
				instances = toggle("在副本中扫描", "副本中实际的稀有怪物并不多，而且扫描可能会在您最需要性能的时候降低速度.", 50),
				taxi = toggle("在飞行中扫描", "在乘坐飞行器或参加龙赛时继续扫描稀有怪物。只是希望在你着陆并返回时它还在那里...", 55),
			},
			plugins = {},
		},
	},
	plugins = {
	},
}
module.options = options

function module:OnInitialize()
	options.plugins["profiles"] = {
		profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(core.db)
	}
	options.plugins.profiles.profiles.order = -1 -- last!

	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("SilverDragon", function()
		core.events:Fire("OptionsRequested", options)
		return options
	end)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SilverDragon", "SilverDragon")
end

function module:ShowConfig(...)
	LibStub("AceConfigDialog-3.0"):Open("SilverDragon", ...)
end
