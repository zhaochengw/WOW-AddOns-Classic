local myname = ...

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:GetModule("ClickTarget")
local Debug = core.Debug
local ns = core.NAMESPACE

local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local LibWindow = LibStub("LibWindow-1.1")

function module:RegisterConfig()
	local config = core:GetModule("Config", true)
	if not config then return end

	config.options.plugins.clicktarget = {
		clicktarget = {
			type = "group",
			name = "点击目标",
			get = function(info) return self.db.profile[info[#info]] end,
			set = function(info, v)
				self.db.profile[info[#info]] = v
			end,
			order = 25,
			args = {
				about = config.desc("一旦你找到了一个稀有怪，实际锁定它会很不错。因此，这个功能会在你点击它时弹出一个锁定稀有怪的框架。", 0),
				show = config.toggle("显示生物", "显示生物的点击目标框架", 10),
				loot = config.toggle("显示宝藏", "显示宝藏的点击目标框架", 11),
				appearanceHeader = {
					type = "header",
					name = "外观",
					order = 20,
				},
				style = {
					type = "select",
					name = "类型",
					desc = "框架的外观",
					values = function(info)
						local values = {}
						for key in pairs(self.Looks) do
							values[key] = key:gsub("_", ": ")
						end
						-- replace ourself with the built values table
						info.option.values = values
						return values
					end,
					set = function(info, v)
						self.db.profile[info[#info]] = v
						module:Redraw()
					end,
					order = 21,
				},
				model = {
					type = "toggle",
					name = "显示3D模型",
					desc = "是否显示怪物的完整3D模型。在某些风格中，这将回退到2D图标，而在其他风格中，它可能会完全消失。",
					set = function(info, v)
						self.db.profile[info[#info]] = v
						module:Redraw()
					end,
					order = 23,
				},
				anchor = {
					type = "execute",
					name = function() return self.anchor:IsShown() and "隐藏锚点" or "显示锚点" end,
					descStyle = "inline",
					desc = "显示弹出窗口将附加到的锚点框架",
					func = function()
						self.anchor[self.anchor:IsShown() and "Hide" or "Show"](self.anchor)
						AceConfigRegistry:NotifyChange(myname)
					end,
					order = 25,
				},
				stacksize = {
					type = "range",
					name = "堆栈数量",
					desc = "一次显示多少个弹出框",
					min = 1,
					max = 6,
					step = 1,
					order = 30,
				},
				scale = {
					type = "range",
					name = UI_SCALE,
					width = "full",
					min = 0.5,
					max = 2,
					get = function(info) return self.db.profile.anchor.scale end,
					set = function(info, value)
						self.db.profile.anchor.scale = value
						LibWindow.SetScale(self.anchor, value)
						for _, popup in ipairs(self.stack) do
							popup:SetScale(self.db.profile.anchor.scale)
							self:SetModel(popup)
						end
					end,
					order = 35,
				},
				closeAfter = {
					type = "range",
					name = "关闭",
					desc = "在没有交互的情况下，目标框体保持显示的时间长度，以秒为单位。每次鼠标悬停在该框体上时，计时器会重置.",
					width = "full",
					min = 5,
					max = 600,
					step = 1,
					order = 40,
				},
				closeDead = config.toggle("死亡时关闭", "尝试在怪物死亡时关闭点击目标框体。只有在附近并处于战斗状态时，我们才能确定它是否死亡。可能需要等到脱离战斗状态后才能进行隐藏操作", 30),
				announceHeader = {
					type = "header",
					name = "聊天通报",
					order = 50,
				},
				announceDesc = config.desc("按住Shift键点击目标弹出框将尝试发送关于稀有怪物的消息。如果你已经选中了它或者足够近能看到它的姓名板，消息中将包含它的生命值。如果你已经打开了编辑框，消息将被粘贴到编辑框中以便你发送。如果没有打开编辑框，它将按照这些设置进行操作:", 41),
				announce = {
					type = "select",
					name = "在聊天中通知",
					values = {
						OPENLAST = "打开编辑框",
						IMMEDIATELY = "立即发送",
					},
					order = 55,
				},
				announceChannel = {
					type = "select",
					name = "立即通报到...",
					values = {
						["CHANNEL"] = COMMUNITIES_DEFAULT_CHANNEL_NAME, -- strictly this isn't correct, but...
						["SAY"] = CHAT_MSG_SAY,
						["YELL"] = CHAT_MSG_YELL,
						["PARTY"] = CHAT_MSG_PARTY,
						["RAID"] = CHAT_MSG_RAID,
						["GUILD"] = CHAT_MSG_GUILD,
						["OFFICER"] = CHAT_MSG_OFFICER,
					},
					order = 60,
				},
				sources = {
					type = "group",
					name = "稀有来源",
					args = {
						desc = config.desc("哪些寻找稀有生物的方法会导致此框架出现？", 0),
						sources = {
							type="multiselect",
							name = "来源",
							get = function(info, key) return self.db.profile.sources[key] end,
							set = function(info, key, v) self.db.profile.sources[key] = v end,
							values = {
								target = "目标",
								grouptarget = "团队目标",
								mouseover = "鼠标悬停",
								nameplate = "姓名板",
								vignette = "小插图",
								['point-of-interest'] = "兴趣点",
								chat = "聊天喊话",
								groupsync = "团队同步",
								guildsync = "公会同步",
								darkmagic = "黑科技",
							},
							order = 10,
						},
					},
				},
				style_options = {
					type = "group",
					name = "样式选项",
					get = function(info)
						local value = self.db.profile.style_options[info[#info - 1]][info[#info]]
						if info.type == "color" then
							return unpack(value)
						end
						return value
					end,
					set = function(info, ...)
						local value = ...
						if info.type == "color" then
							value = {...}
						end
						self.db.profile.style_options[info[#info - 1]][info[#info]] = value
						for popup, look in self:EnumerateActive() do
							if look == info[#info - 1] then
								self:ResetLook(popup)
							end
						end
					end,
					args = module.LookConfig,
				},
			},
		},
	}
	module.LookConfig.about = config.desc("某些样式具有选项. 在这里进行更改.", 0)
end

function module:RegisterLookConfig(look, config, defaults, reset)
	self.LookConfig[look] = {
		type = "group",
		name = look:gsub("_", ": "),
		args = config,
		inline = true,
	}
	if defaults then
		self.defaults.profile.style_options[look] = defaults
		if self.db then
			self.db:RegisterDefaults(self.db.defaults)
		end
	end
	self.LookReset[look] = reset
end
