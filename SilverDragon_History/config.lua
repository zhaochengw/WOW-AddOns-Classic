local myname = ...

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:GetModule("History")
local Debug = core.Debug
local ns = core.NAMESPACE

local LibWindow = LibStub("LibWindow-1.1")

function module:RegisterConfig()
	local config = core:GetModule("Config", true)
	if not config then return end
	config.options.plugins.history = { history = {
		type = "group",
		name = HISTORY,
		get = function(info) return self.db.profile[info[#info]] end,
		set = function(info, v)
			self.db.profile[info[#info]] = v
			self:Refresh()
		end,
		args = {
			about = config.desc("显示最近发现的生物列表，以便更容易推断未来刷新的时间.", 0),
			enabled = {
				type = "toggle",
				name = "启用",
				set = function(info, v)
					self.db.profile[info[#info]] = v
					if v then
						self:Enable()
					else
						self:Disable()
					end
				end,
				order = 10,
			},
			combat = config.toggle("在战斗中显示", "战斗开始时是否隐藏", 15),
			empty = config.toggle("为空时显示", "是否在看到任何东西之前显示窗口", 20),
			grow = config.toggle("增长到最大高度", "是否在达到最大高度之前根据内容调整窗口大小", 25),
			relative = config.toggle("使用相对时间", "是否在窗口中显示相对时间或绝对时间", 30),
			loot = config.toggle("包含宝箱", "是否包含宝藏小插图", 35),
			othershard = {
				type = "select", name = "来自其他碎片的生物",
				desc = "如何对待那些不属于你当前碎片的生物，因此可能目前对你来说是不可接触的",
				values = {
					show = "显示",
					dim = "暗淡",
					hide = "隐藏",
				},
				order = 40,
			},
			scale = {
				type = "range",
				name = UI_SCALE,
				width = "full",
				min = 0.5,
				max = 2,
				step = 0.05,
				get = function(info) return self.db.profile.position.scale end,
				set = function(info, value)
					self.db.profile.position.scale = value
					LibWindow.SetScale(self.window, value)
				end,
				order = 50,
			},
		},
	}, }
end
