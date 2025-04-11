local myname = ...

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:GetModule("VignetteStretch")
local Debug = core.Debug
local ns = core.NAMESPACE

function module:RegisterConfig()
	local config = core:GetModule("Config", true)
	if not config then return end
	config.options.plugins.rangeextender = { rangeextender = {
		type = "group",
		name = "范围扩展器",
		get = function(info) return self.db.profile[info[#info]] end,
		set = function(info, v)
			self.db.profile[info[#info]] = v
			module:VIGNETTES_UPDATED()
		end,
		args = {
			about = config.desc("小地图上的小插图会告诉我们各种事物的位置。暴雪有时会在它们出现在小地图上之前就让我们知道它们的存在，可能是因为缩放级别或某些东西遮挡了小插图的视线。因此，我们可以伪造那些隐藏的小插图，以便提前给你一些你可能想要追求的事物的警告.", 0),
			enabled = config.toggle("启用", "扩大小地图小插图出现的范围.", 10),
			mystery = config.toggle("神秘小插图", "显示那些不会从API返回任何信息的神秘小插图", 15),
			types_desc = config.desc("你可以调整小插图的类型以扩展范围。这本质上是不确定的，因为我们没有太多关于它们的信息，所以这只是根据它们的内部图标名称来进行的。没有什么能阻止暴雪以奇怪的方式对事物进行分类，或者制作新的图标。", 20),
			types = {
				type = "multiselect",
				name = "类型",
				get = function(info, key) return self.db.profile[info[#info]][key] end,
				set = function(info, key, value)
					self.db.profile[info[#info]][key] = value
					module:VIGNETTES_UPDATED()
				end,
				values = {
					vignettekill = CreateAtlasMarkup("vignettekill", 20, 20) .. " 击杀",
					vignettekillelite = CreateAtlasMarkup("vignettekillelite", 24, 24) .. " 精英击杀",
					vignetteloot = CreateAtlasMarkup("vignetteloot", 20, 20) .. " 宝箱",
					vignettelootelite = CreateAtlasMarkup("vignettelootelite", 24, 24) .. " 精英宝箱",
					vignetteevent = CreateAtlasMarkup("vignetteevent", 20, 20) .. " 事件",
					vignetteeventelite = CreateAtlasMarkup("vignetteeventelite", 24, 24) .. " 精英事件",
				},
				order=21,
			},
		},
	}, }
	if self.compat_disabled then
		config.options.plugins.rangeextender.rangeextender.args.enabled.disabled = true
		config.options.plugins.rangeextender.rangeextender.args.disabled = config.desc("由于安装并加载了MinimapRangeExtender，该功能已被禁用，因为它具有相同的功能", 15)
	end
end
