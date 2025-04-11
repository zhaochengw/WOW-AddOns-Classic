local myname, ns = ...

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("Macro", "AceEvent-3.0", "AceConsole-3.0")
local Debug = core.Debug
local DebugF = core.DebugF

local HBD = LibStub("HereBeDragons-2.0")

function module:OnInitialize()
	self.db = core.db:RegisterNamespace("Macro", {
		profile = {
			enabled = true,
			custom = true,
			verbose = true,
			relaxed = false,
		},
	})
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	HBD.RegisterCallback(self, "PlayerZoneChanged", "Update")
	core.RegisterCallback(self, "Seen", "Update")
	core.RegisterCallback(self, "Ready", "Update")
	core.RegisterCallback(self, "IgnoreChanged", "Update")
	core.RegisterCallback(self, "CustomChanged", "Update")

	C_Timer.NewTicker(5, function()
		self:Update()
	end)

	local config = core:GetModule("Config", true)
	if config then
		config.options.args.scanning.plugins.macro = {
			macro = {
				type = "group",
				name = "宏命令",
				get = function(info) return self.db.profile[info[#info]] end,
				set = function(info, v)
					self.db.profile[info[#info]] = v
					self:Update()
				end,
				args = {
					about = config.desc("创建一个可以在宏命令中使用的按钮，用于扫描可能附近的稀有怪物。\n\n"..
							"创建一个名为“SilverDragon”的宏，或者点击下面的“创建宏”按钮，它将尝试为你创建一个。"..
							"把它拖动到你的动作条上，点击它就可以选取附近可能出现的稀有目标。"..
							"由于宏长度有严格的限制，因此它只能扫描附近的稀有目标。",
							0),
					verbose = {
						type = "toggle",
						name = "通知",
						desc = "输出更多信息，以便你知道宏命令正在寻找什么",
						order = 10,
					},
					custom = {
						type = "toggle",
						name = CUSTOM,
						desc = "在宏中包含自定义怪物。因为我们不知道它们的位置，它们将优先被添加进宏中，"..
							"如果你有太多这样的怪物，可能会把实际靠近的怪物排除。",
						order = 20,
					},
					relaxed = {
						type = "toggle",
						name = "宽松选择目标",
						desc = "使用 /tar 而不是 /targetexact 来选择目标。这有时会选中错误的怪物，但也能让你在一个宏中兼容更多的怪物。",
						order = 30,
					},
					create = {
						type = "execute",
						name = "创建宏",
						desc = "点击此按钮以创建宏命令",
						func = function()
							self:CreateMacro()
						end,
						order = 50,
					},
				},
				-- order = 99,
			},
		}
	end
end

local lastmacrotext
function module:Update()
	if not self.db.profile.enabled then
		return
	end
	if InCombatLockdown() then
		self.waiting = true
		return
	end
	if MacroFrame and MacroFrame:IsVisible() then
		-- EditMacro will reset any manual editing in the macro frame
		return
	end
	-- Debug("Updating Macro")
	-- Make sure the core macro is up to date
	if GetMacroIndexByName("SilverDragon") then
		-- 1023 for macrotext on a button, but...
		local macroicon, macrotext = self:GetMacroArguments(255)
		if lastmacrotext ~= macrotext then
			EditMacro(GetMacroIndexByName("SilverDragon"), nil, macroicon, macrotext)
			lastmacrotext = macrotext
			DebugF("Updated macro: %d characters", #macrotext)
		end
	end
end

local macro = {}
function module:BuildTargetMacro(limit)
	local VERBOSE_ANNOUNCE = "/run print(\"Checking %d nearby mobs\")"
	-- first, create the macro text on the button:
	local zone = HBD:GetPlayerZone()
	local mobs = {}
	local distances = {}
	local length = self.db.profile.verbose and (#VERBOSE_ANNOUNCE + 1) or 0
	for id, hasCoords, isCustom in core:IterateRelevantMobs(zone, true) do
		if
			(self.db.profile.custom or not isCustom) and
			not core:ShouldIgnoreMob(id, zone) and
			core:IsMobInPhase(id, zone) and
			not ns:CompletionStatus(id)
		then
			local distance = hasCoords and select(4, core:GetClosestLocationForMob(id)) or 0
			if distance then
				distances[id] = distance
				table.insert(mobs, id)
			end
		end
	end
	table.sort(mobs, function(a, b)
		return distances[a] < distances[b]
	end)
	for _, id in ipairs(mobs) do
		local name = core:NameForMob(id)
		if name then
			local line = (self.db.profile.relaxed and "/tar " or "/targetexact ") .. name
			length = length + 1 + #line
			if length > limit then
				break
			end
			table.insert(macro, line)
		end
	end
	if #macro == 0 then
		table.insert(macro, "/script print(\"No mobs known to scan for\")")
	elseif self.db.profile.verbose then
		table.insert(macro, 1, VERBOSE_ANNOUNCE:format(#macro))
	end

	local mtext = ("\n"):join(unpack(macro))

	-- DebugF("Updated macro: %d statements, %d characters", #macro, #mtext)
	table.wipe(macro)
	return mtext
end

function module:CreateMacro()
	if InCombatLockdown() then
		return self:Print("|cffff0000Can't make a macro while in combat!|r")
	end
	local macroIndex = GetMacroIndexByName("SilverDragon")
	if macroIndex == 0 then
		local numglobal,numperchar = GetNumMacros()
		if numglobal < MAX_ACCOUNT_MACROS then
			CreateMacro("SilverDragon", self:GetMacroArguments())
			self:Print("Created the SilverDragon macro. Open the macro editor with /macro and drag it onto your actionbar to use it.")
		else
			self:Print("|cffff0000Couldn't create rare-scanning macro, too many macros already created.|r")
		end
	else
		self:Print("|cffff0000A macro named SilverDragon already exists.|r")
	end
end
function module:GetMacroArguments(limit)
	--/script for i=1,GetNumMacroIcons() do if GetMacroIconInfo(i):match("SniperTraining$") then DEFAULT_CHAT_FRAME:AddMessage(i) end end
	return 132222, self:BuildTargetMacro(limit or 255)
end

function module:PLAYER_REGEN_ENABLED()
	if self.waiting then
		self.waiting = false
		self:Update()
	end
end

-- /dump SilverDragonMacroButton:GetAttribute("macrotext")
function module:GetMacroButton(i)
	local name = "SilverDragonMacroButton"
	if i > 1 then
		name = name .. i
	end
	if _G[name] then
		return _G[name]
	end
	local button = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
	button:SetAttribute("type", "macro")
	button:SetAttribute("macrotext", "/script DEFAULT_CHAT_FRAME:AddMessage('SilverDragon Macro: Not initialized yet.', 1, 0, 0)")
	return button
end
