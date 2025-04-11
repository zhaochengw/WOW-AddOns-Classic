local myname, ns = ...

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("DarkMagic", "AceEvent-3.0", "AceConsole-3.0")
local Debug = core.Debug
local DebugF = core.DebugF

local HBD = LibStub("HereBeDragons-2.0")

function module:OnInitialize()
	self.db = core.db:RegisterNamespace("DarkMagic", {
		profile = {
			enabled = false,
			suppress = false,
			vignette = false,
			interval = 0.5,
		},
	})
	self:RegisterEvent("ADDON_ACTION_FORBIDDEN")
	HBD.RegisterCallback(self, "PlayerZoneChanged", "Update")
	core.RegisterCallback(self, "Scan")
	core.RegisterCallback(self, "Seen", "Update")
	core.RegisterCallback(self, "Ready", "Update")
	core.RegisterCallback(self, "IgnoreChanged", "Update")
	core.RegisterCallback(self, "CustomChanged", "Update")

	local config = core:GetModule("Config", true)
	if config then
		config.options.args.scanning.plugins.darkmagic = {
			darkmagic = {
				type = "group",
				name = "黑科技",
				get = function(info) return self.db.profile[info[#info]] end,
				set = function(info, v)
					self.db.profile[info[#info]] = v
					self:Update(true)
				end,
				args = {
					about = config.desc("尝试使用受保护的功能来瞄准稀有怪物，并观察暴雪是否阻止我们，以此来扫描稀有怪物。这可能会导致你的用户界面（UI）出现污染问题，因此默认情况下是禁用的.",
							0),
					enabled = config.toggle("启用",
						"通过半禁用的手段进行扫描",
						10),
					vignette = config.toggle("包括带有小插图的怪物",
						"在扫描中包括已知带有小插图的怪物。过滤掉它们会减少在现代区域中看到错误的几率。（但是关于哪些怪物有小插图的数据并不完美)",
						15),
					suppress = config.toggle("抑制错误",
						"阻止暴雪的“action-forbidden”错误出现，这可能会在此过程中污染你的用户界面（UI）。如果你安装了BugSack，请将其禁用.",
						20),
					interval = {
						type = "range",
						name = "扫描间隔",
						desc = "尝试扫描每个稀有怪物之间等待的时间。某些区域可能有很多稀有怪物，因此设置较高的值可能会导致错过一个稀有怪物。将其设置为0意味着随时都在尝试瞄准一个稀有怪物。",
						min = 0, max = 10, step = 0.1,
						order = 30,
					},
				},
				-- order = 99,
			},
		}
	end

	self:Update()
end

local mobs = {}
local index = nil
local AttemptTargetUnit = function()
	local newindex, id = next(mobs, index)
	if not id then return false end
	index = newindex
	local name = core:NameForMob(id)
	-- print("considered", id, name)
	if name then
		local bugSackWasOpen = _G.BugSackFrame and _G.BugSackFrame:IsVisible()
		module.currentlyscanning = true
		TargetUnit(name)
		module.currentlyscanning = false
		if module.forbidden then
			module.forbidden = false
			if module.db.profile.suppress then
				local alert = StaticPopup_FindVisible("ADDON_ACTION_FORBIDDEN", myname)
				if alert then
					-- if they ever change `StaticPopupDialogs["ADDON_ACTION_FORBIDDEN"]` I may need to revisit this, but...
					StaticPopup_HideExclusive()
				end
				if _G.BugSack and _G.BugSackFrame and not bugSackWasOpen then
					-- CloseSack will error if the bugsack window isn't created yet
					_G.BugSack:CloseSack()
				end
			end
			local x, y, zone = HBD:GetPlayerZonePosition()
			-- id, zone, x, y, is_dead, source, unit, silent, force, GUID
			core:NotifyForMob(id, zone, x, y, nil, "darkmagic", false)
		end
	end
	return true
end

function module:Scan()
	if not next(mobs, index) then
		index = nil
	end
end

function module:Update(force)
	if (not self.db.profile.enabled) or (not core.db.profile.instances and IsInInstance()) then
		if self.timer then self.timer:Cancel() end
		self.timer = nil
		return
	end
	if force and self.timer then
		self.timer:Cancel()
		self.timer = nil
	end

	wipe(mobs)
	index = nil
	local zone = HBD:GetPlayerZone()
	-- Mobs from data, and custom mobs specific to the zone
	for id in core:IterateRelevantMobs(zone, true) do
		if
			(module.db.profile.vignette or not core:MobHasVignette(id)) and
			-- filter out ones we wouldn't notify for anyway
			core:WouldNotifyForMob(id, zone) and
			not core:ShouldIgnoreMob(id, zone) and
			core:IsMobInPhase(id, zone)
		then
			table.insert(mobs, id)
		end
	end

	if not self.timer then
		self.timer = C_Timer.NewTicker(self.db.profile.interval, AttemptTargetUnit)
	end
end

function module:ADDON_ACTION_FORBIDDEN(_, addon, blockedFunction)
	if addon == myname and blockedFunction == "TargetUnit()" and self.currentlyscanning then
		self.forbidden = true
	end
end
