local L = LibStub("AceLocale-3.0"):GetLocale("Talented")
local Talented = Talented

Talented.max_talent_points = 61 --Level 70 is max

Talented.defaults = {
	profile = {

-- Always Edit the template, never lock
		always_edit = nil,

-- Manually confirm each talent before learning
		confirmlearn = true,

-- Call LearnTalent() even if Talented has determined that it would not have any effect
		-- always_call_learn_talents = nil,

-- Limit Talented to the level cap
		level_cap = true,

-- Show the required level for any template
		show_level_req = true,

-- Offset between Talent icons
		offset = 64,

-- Global frame scale
		scale = 1,

-- Detect whether Talented_Data is loaded
	report_unavailable = true,
	reported_once = false,

-- the template that was selected last
	--	last_template = nil,

		framepos = {},

-- Do we force loading of old data from Talented_Data?
	force_load = false,

-- Do we hook the inspect UI to replace it by Talented ?
		-- hook_inspect_ui = nil,

-- Use a dialog to output URL or show them directly in Chat ?
		-- show_url_in_chat = nil,

	},
	global = {
	-- the list of saved templates, see below for the format
			templates = {},
	},
	char = {
		targets = {},
	},
}

function Talented:SetOption(info, value)
	local name = info[#info]
	self.db.profile[name] = value
	local arg = info.arg
	if arg then self[arg](self) end
end

function Talented:GetOption(info)
	local name = info[#info]
	return self.db.profile[name]
end

function Talented:MustNotConfirmLearn()
	return not Talented.db.profile.confirmlearn
end

Talented.options = {
	desc = L["Talented - Talent Editor"],
	type = "group",
	childGroups = "tab",
	handler = Talented,
	get = "GetOption",
	set = "SetOption",
	args = {
		options = {
			name = L["Options"],
			desc = L["General Options for Talented."],
			type = "group",
			args = {
				header1 = {
					name = L["General options"],
					type = "header",
					order = 1,
				},
				always_edit = {
					name = L["Always edit"],
					desc = L["Always allow templates and the current build to be modified, instead of having to Unlock them first."],
					type = "toggle",
					arg = "SetMode",
					order = 100,
				},
				confirmlearn = {
					name = L["Confirm Learning"],
					desc = L["Ask for user confirmation before learning any talent."],
					type = "toggle",
					order = 200,
				},
				always_call_learn_talents = {
					name = L["Always try to learn talent"],
					desc = L["Always call the underlying API when a user input is made, even when no talent should be learned from it."],
					type = "toggle",
					disabled = "MustNotConfirmLearn",
					order = 220,
				},
				level_cap = {
					name = L["Talent cap"],
					desc = L["Restrict templates to a maximum of %d points."]:format(Talented.max_talent_points),
					type = "toggle",
					arg = "UpdateView",
					order = 300,
				},
				show_level_req = {
					name = L["Level restriction"],
					desc = L["Show the required level for the template, instead of the number of points."],
					type = "toggle",
					arg = "UpdateView",
					order = 400,
				},
				force_load = {
					name = L["Load outdated data"],
					desc = L["Load Talented_Data, even if outdated."],
					type = "toggle",
					order = 500,
				},
				-- hook_inspect_ui = {
				-- 	name = L["Hook Inspect UI"],
				-- 	desc = L["Hook the Talent Inspection UI."],
				-- 	type = "toggle",
				-- 	arg = "CheckHookInspectUI",
				-- 	order = 700,
				-- },
				show_url_in_chat = {
					name = L["Output URL in Chat"],
					desc = L["Directly outputs the URL in Chat instead of using a Dialog."],
					type = "toggle",
					order = 750,
				},
				header3 = {
					name = L["Display options"],
					type = "header",
					order = 799,
				},
				offset = {
					name = L["Icon offset"],
					desc = L["Distance between icons."],
					type = "range",
					min = 42,
					max = 64,
					step = 1,
					order = 800,
					arg = "ReLayout",
				},
				scale = {
					name = L["Frame scale"],
					desc = L["Overall scale of the Talented frame."],
					type = "range",
					min = 0.5,
					max = 1.0,
					step = 0.01,
					order = 900,
					arg = "ReLayout",
				},
				add_bottom_offset = {
					name = L["Add bottom offset"],
					desc = L["Add some space below the talents to show the bottom information."],
					type = "toggle",
					order = 950,
					arg = "ReLayout",
				},
			}
		},
		apply = {
			name = "Apply",
			desc = "Apply the specified template",
			type = "input",
			dialogHidden = true,
			set = function (_, class, name)
				local template = Talented.db.global.templates[class][name]
				if not template then
					Talented:Print(L["Can not apply, unknown template \"%s\""], name)
					return
				end
				Talented:SetTemplate(template)
				Talented:SetMode"apply"
			end,
		},
		-- template = {
		-- 	name = L["Template"],
		-- 	desc = L["Template"],
		-- 	type = "group",
		-- 	args = {
		-- 		new = {
		-- 			name = L["New Template"],
		-- 			desc = L["Create a new Template."],
		-- 			type = "group",
		-- 			order = 100,
		-- 			args = {
		-- 				empty = {
		-- 					name = L["New empty template"],
		-- 					desc = L["Create a new template from scratch."],
		-- 					type = "execute",
		-- 					order = 100,
		-- 					func = function() Talented:SetTemplate(Talented:CreateEmptyTemplate()) end,
		-- 				},
		-- 				h1 = {
		-- 					name = L["Copy current talent spec"],
		-- 					type = "header",
		-- 					order = 150,
		-- 				},
		-- 				-- copy from existing templates here
		-- 				current = {
		-- 					name = L["Copy current talent spec"],
		-- 					desc = L["Create a new template from your current spec."],
		-- 					type = "execute",
		-- 					order = 300,
		-- 					func = function() Talented:SetTemplate(Talented:CopyTemplate(Talented.current)) end,
		-- 				},
		-- 				clone = {
		-- 					name = L["Clone selected"],
		-- 					desc = L["Make a copy of the current template."],
		-- 					type = "execute",
		-- 					order = 400,
		-- 					func = function () Talented:SetTemplate(Talented:CopyTemplate(Talented.template)) end,
		-- 				}
		-- 			},
		-- 		},
		-- 	}
		-- },
	},
}

function Talented:ReLayout()
	self:ViewsReLayout(true)
end

function Talented:UpgradeOptions()
	local p = self.db.profile
	if p.point or p.offsetx or p.offsety then
		local opts = {
			anchor = p.point or "CENTER",
			anchorTo = p.point or "CENTER",
			x = p.offsetx or 0,
			y = p.offsety or 0,
		}
		p.framepos.TalentedFrame = opts
		p.point, p.offsetx, p.offsety = nil, nil, nil
	end
	local c = self.db.char
	if c.target then
		c.targets[1] = c.target
		c.target = nil
	end
	self.UpgradeOptions = nil
end

function Talented:SaveFramePosition(frame)
	local db = self.db.profile.framepos
	local name = frame:GetName()

	local data, _ = db[name]
	if not data then
		data = {}
		db[name] = data
	end
	data.anchor, _, data.anchorTo, data.x, data.y = frame:GetPoint(1)
end

function Talented:LoadFramePosition(frame)
	local data = self.db.profile.framepos[frame:GetName()]
	if data and data.anchor then
		frame:ClearAllPoints()
		frame:SetPoint(data.anchor, UIParent, data.anchorTo, data.x, data.y)
	else
		frame:SetPoint"CENTER"
		self:SaveFramePosition(frame)
	end
end

local function BaseFrame_OnMouseDown(self)
	if self.OnMouseDown then self:OnMouseDown() end
	self:StartMoving()
end

local function BaseFrame_OnMouseUp(self)
	self:StopMovingOrSizing()
	Talented:SaveFramePosition(self)
	if self.OnMouseUp then self:OnMouseUp() end
end

function Talented:SetFrameLock(frame, locked)
	local db = self.db.profile.framepos
	local name = frame:GetName()
	local data = db[name]
	if not data then
		data = {}
		db[name] = data
	end
	if locked == nil then
		locked = data.locked
	elseif locked == false then
		locked = nil
	end
	data.locked = locked
	if locked then
		frame:SetMovable(false)
		frame:SetScript("OnMouseDown", nil)
		frame:SetScript("OnMouseUp", nil)
	else
		frame:SetMovable(true)
		frame:SetScript("OnMouseDown", BaseFrame_OnMouseDown)
		frame:SetScript("OnMouseUp", BaseFrame_OnMouseUp)
	end
	frame:SetClampedToScreen(true)
end

function Talented:GetFrameLock(frame)
	local data = self.db.profile.framepos[frame:GetName()]
	return data and data.locked
end
