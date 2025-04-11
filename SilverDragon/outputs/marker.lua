local myname, ns = ...

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("Marker")
local Debug = core.Debug

local HBD = LibStub("HereBeDragons-2.0")

local mod_announce

function module:OnInitialize()
	self.db = core.db:RegisterNamespace("Marker", {
		profile = {
			enabled = true,
			safely = true,
			marker = 3,
		},
	})

	local config = core:GetModule("Config", true)
	if config then
		config.options.args.general.plugins.marker = {
			marker = {
				type = "group",
				name = "标记",
				get = function(info) return self.db.profile[info[#info]] end,
				set = function(info, v) self.db.profile[info[#info]] = v end,
				args = {
					about = config.desc("一旦我们看到单位，我们可以自动用团队目标标记标记它。在这个上下文中，“看到它”意味着选中它或将鼠标移到它上面.", 0),
					enabled = config.toggle("标记它", "一旦看到怪物，就给它设置一个团队目标标记.", 30),
					safely = config.toggle("...安全地?", "但如果不在队伍中!", 31),
					marker = {
						type = "select",
						name = "用哪个",
						values = {
							[1] = ICON_LIST[1] .. "0|t 星星",
							[2] = ICON_LIST[2] .. "0|t 大饼",
							[3] = ICON_LIST[3] .. "0|t 钻石",
							[4] = ICON_LIST[4] .. "0|t 三角",
							[5] = ICON_LIST[5] .. "0|t 月亮",
							[6] = ICON_LIST[6] .. "0|t 方块",
							[7] = ICON_LIST[7] .. "0|t 叉叉",
							[8] = ICON_LIST[8] .. "0|t 骷髅",
						},
					},
				},
			},
		}
	end

	mod_announce = core:GetModule("Announce", true)
end

function module:OnEnable()
	core.RegisterCallback(self, "Seen_Raw")
end

function module:Seen_Raw(callback, id, zone, x, y, dead, source, unit)
	if not unit then
		return
	end
	if not self.db.profile.enabled then
		return
	end
	if IsInGroup() then
		if self.db.profile.safely then
			-- Just don't do anything in groups
			return
		end
		if IsInRaid() and not UnitIsGroupLeader("player") then
			-- In raids, only the leader can set icons
			-- TODO: also assistants, apparently
			return
		end
		-- But in parties, anyone can set icons
	end
	if GetRaidTargetIndex(unit) then
		-- Don't overwrite an existing icon
		return
	end
	if id and core:ShouldIgnoreMob(id, HBD:GetPlayerZone()) then
		return
	end
	if mod_announce and not mod_announce:ShouldAnnounce(id, zone, x, y, dead, source, unit) then
		return
	end
	SetRaidTarget(unit, self.db.profile.marker)
	core.events:Fire("Marked", id, self.db.profile.marker, unit)
end
