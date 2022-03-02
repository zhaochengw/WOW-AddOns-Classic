local Talented = LibStub("AceAddon-3.0"):NewAddon("Talented",
	"AceConsole-3.0", "AceComm-3.0", "AceHook-3.0", "AceEvent-3.0", "AceSerializer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

local classes = {'DRUID','HUNTER','MAGE','PALADIN','PRIEST','ROGUE','SHAMAN','WARLOCK','WARRIOR'}
Talented.prev_Print = Talented.Print
function Talented:Print(s, ...)
	if type(s) == "string" and s:find("%", nil, true) then
		self:prev_Print(s:format(...))
	else
		self:prev_Print(s, ...)
	end
end

function Talented:Debug(...)
	if not self.db or self.db.profile.debug then
		self:Print(...)
	end
end

function Talented:MakeTarget(targetName)
	local tar = self.db.char.targets[targetName]
	local name = nil; local class = nil
    if tar then
        name = tar.name
        class = tar.class
    end

	local src = tar and self.db.global.templates[class] and self.db.global.templates[class][name]
	if not src then
		if tar then
			self.db.char.targets[targetName] = nil
		end
		return
	end

	local target = self.target
	if not target then
		target = {}
		self.target = target
	end
	self:CopyPackedTemplate(src, target)

	if not self:ValidateTemplate(target) or target.class ~= select(2, UnitClass"player")
	then
		self.db.char.targets[targetName] = nil
		return nil
	end
	target.name = name
	target.class = class
	return target
end

function Talented:GetMode()
	return self.mode
end

function Talented:SetMode(mode)
	if self.mode ~= mode then
		self.mode = mode
		if mode == "apply" then
			self:ApplyCurrentTemplate()
		elseif self.base and self.base.view then
			self.base.view:SetViewMode(mode)
		end
	end
	local cb = self.base and self.base.checkbox
	if cb then
		cb:SetChecked(mode == "edit")
	end
end

-- Hook this function if you wanna change the way Talented loads its modules
function Talented:LoadAddOn(name)
	LoadAddOn(name)
end

function Talented:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("TalentedDB", self.defaults)
	self:UpgradeOptions()
	self:LoadTemplates()

	local AceDBOptions = LibStub("AceDBOptions-3.0", true)
	if AceDBOptions then
		self.options.args.profiles = AceDBOptions:GetOptionsTable(self.db)
		self.options.args.profiles.order = 200
	end

	LibStub("AceConfig-3.0"):RegisterOptionsTable("Talented", self.options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Talented", "Talented")
	self:RegisterChatCommand("talented", "OnChatCommand")

	self:RegisterComm("Talented")
	if IsLoggedIn() then
		self:LoadAddOn"Talented_SpecTabs"
	else
		self.PLAYER_LOGIN = function (self)
			self:LoadAddOn"Talented_SpecTabs"
			self:UnregisterEvent"PLAYER_LOGIN"
			self.PLAYER_LOGIN = nil
		end
		self:RegisterEvent"PLAYER_LOGIN"
	end
	self.OnInitialize = nil
end

function Talented:OnChatCommand(input)
	if not input or input:trim() == "" then
		self:OpenOptionsFrame()
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(self, "talented", "Talented", input)
	end
end

function Talented:DeleteCurrentTemplate()
	local template = self.template
	if template == self.current then return end
	local templates = self.db.global.templates
	templates[template.class][template.name] = nil
	self:SetTemplate()
end

function Talented:UpdateTemplateName(template, newname)
	local class = template.class
	if self.db.global.templates[class][newname] or
			self.current == template or
			type(newname) ~= "string" or newname == "" then
		return
	end

	local oldname = template.name
	template.name = newname
	local t = self.db.global.templates
	t[class][newname] = template
	t[class][oldname] = nil
end

do
	local function new(templates, name, class)
		local count = 0
		local template = {
			name = name,
			class = class
		}
		while templates[template.class][template.name] do
			count = count + 1
			template.name = format(L["%s (%d)"], name, count)
		end
		templates[template.class][template.name] = template
		return template
	end

	local function copy(dst, src)
		dst.class = src.class
		if src.code then
			dst.code = src.code
			return
		else
			for tab, tree in ipairs(Talented:GetTalentInfo(src.class)) do
				local s, d = src[tab], {}
				dst[tab] = d
				for index = 1, #tree.talents do
					d[index] = s[index]
				end
			end
		end
	end

	function Talented:ImportFromOther(name, src)
		if not self:GetTalentInfo(src.class) then return end

		local dst = new(self.db.global.templates, name, src.class)

		copy(dst, src)

		self:OpenTemplate(dst)

		return dst
	end

	function Talented:CopyTemplate(src)
		local dst = new(self.db.global.templates, format(L["Copy of %s"], src.name), src.class)

		copy(dst, src)

		return dst
	end

	function Talented:CreateEmptyTemplate(class)
		class = class or select(2, UnitClass"player")
		
		local template = new(self.db.global.templates, L["Empty"], class)
		local info = self:GetTalentInfo(class)
		if not info then return end
		
		for tab, tree in ipairs(info) do
			local t = {}
			template[tab] = t
				for index = 1, #tree.talents do
				t[index] = 0
			end
		end

		return template
	end

	Talented.importers = {}
	Talented.exporters = {}
	function Talented:ImportTemplate(url)
		--Get class
		for pattern, method in pairs(self.importers) do
			if url:find(pattern) then
				class = method(self, url)
				if class then break end
			end
		end
		assert(class)

		--Decode the template
		local dst, result = new(self.db.global.templates, L["Imported"], class)
		for pattern, method in pairs(self.importers) do
			if url:find(pattern) then
				result = method(self, url, dst)
				assert(dst.class == class)
				if result then break end
			end
		end

		--Error-check
		if result then
			if not self:ValidateTemplate(dst) then
				self:Print(L["The given template is not a valid one!"])
				self.db.global.templates[dst.class][dst.name] = nil
			else
				return dst
			end
		else
			self:Print(L["\"%s\" does not appear to be a valid URL!"], url)
			self.db.global.templates[dst.class][dst.name] = nil
		end
	end
end

function Talented:OpenTemplate(template)
	self:UnpackTemplate(template)
	if not self:ValidateTemplate(template, true) then
		local name = template.name
		local class = template.class
		self.db.global.templates[class][name] = nil
		self:Print(L["The template '%s' is no longer valid and has been removed."], name)
		return
	end
	local base = self:CreateBaseFrame()
	if not self.current then
		self:UpdateCurrentTemplate()
	end
	self:SetTemplate(template)
	if not base:IsVisible() then
		-- ShowUIPanel(base)
		base:Show()
	end
end

function Talented:SetTemplate(template)
	if not template then template = self.current end
	local view = self:CreateBaseFrame().view
	local old = view.template
	if template ~= old then
		if self.current == template then
			local target = self:MakeTarget(1)
			view:SetTemplate(template, target)
		else
			view:SetTemplate(template)
		end
		self.template = template
	end
	if template and self.current ~= template then
		self.db.profile.last_template = template.name
	end
	self:SetMode(self:GetDefaultMode())

	-- self:UpdateView() --TODO: Why is this commented out?
end

function Talented:GetDefaultMode()
	return self.db.profile.always_edit and "edit" or "view"
end

function Talented:OnEnable()
	self:RawHook("ToggleTalentFrame", true)
	--Non-taint option that loads Talented's frame IN ADDITION to Blizzard's frame: self:SecureHook("ToggleTalentFrame")
	self:SecureHook("UpdateMicroButtons")

	UIParent:UnregisterEvent("CONFIRM_TALENT_WIPE")
	self:RegisterEvent("CONFIRM_TALENT_WIPE")
	self:RegisterEvent("CHARACTER_POINTS_CHANGED")
	TalentMicroButton:SetScript("OnClick", ToggleTalentFrame)
end

function Talented:OnDisable()
	-- self:UnhookInspectUI()
	UIParent:RegisterEvent("CONFIRM_TALENT_WIPE")
end

function Talented:PLAYER_TALENT_UPDATE()
	self:UpdateCurrentTemplate()
end

function Talented:CONFIRM_TALENT_WIPE(_, cost)
    StaticPopupDialogs["CONFIRM_TALENT_WIPE"].text = L['CONFIRM_TALENT_WIPE_TEXT'] --the problem: text for CONFIRM_TALENT_WIPE are nil, eventualy in conjunction of unregisterevent from uiparent??? now let us set the text manually...
	local dialog = StaticPopup_Show("CONFIRM_TALENT_WIPE")
	if dialog then
		MoneyFrame_Update(dialog:GetName().."MoneyFrame", cost)
		local frame = self.base
        if not frame or not frame:IsVisible() then
			self:Update()
			-- ShowUIPanel(self.base)
			self.base:Show()
		end
        --dialog:SetFrameLevel(self.base:GetFrameLevel() + 5) frame level dosn't work, so let's us set the frame strata
        dialog:SetFrameStrata('FULLSCREEN_DIALOG')
	end
end


function Talented:CHARACTER_POINTS_CHANGED()
	self:UpdateCurrentTemplate()
	self:UpdateView()
	if self.mode == "apply" then
		self:ApplyNextTalentPoint()
	end
end


function Talented:UpdateMicroButtons()
	local button = TalentMicroButton
	if self.db.profile.donthide and UnitLevel"player" < button.minLevel then
		button:Enable()
	end
	if self.base and self.base:IsShown() then
		button:SetButtonState("PUSHED", 1)
	else
		button:SetButtonState"NORMAL"
	end
end

function Talented:ToggleTalentFrame()
	local frame = self.base
	if not frame or not frame:IsVisible() then
		self:Update()
		if self.template then
			-- reset editing mode to the default every time we open the panel after the initial open
			self:SetMode(self:GetDefaultMode())
		end
		-- ShowUIPanel(self.base)
		self.base:Show()
	else
		-- HideUIPanel(frame)
		frame:Hide()
	end
end

function Talented:Update()
	self:CreateBaseFrame()
	self:UpdateCurrentTemplate()
	if not self.template then
		self:SetTemplate()
	end
	self:UpdateView()
end

function Talented:is_class(class)
    for index, value in ipairs(classes) do
        if class == value then
            return true
        end
    end
    return false
end

function Talented:MakeSubArrays(db)
	local madeArrays = 0
    for index, class in ipairs(classes) do
        if db[class] == nil then
			db[class] = {}
			madeArrays = 1
        
        --If there is an existing template named after the class...
        elseif type(db[class]) == "string" then
            --rename the template
            local count = 1
            local name = class
            name = format("%s (%d)", name, count)
            while db[name] do
                count = count + 1
                template.name = format("%s (%d)", name, count)
            end

            --THEN make the class sub-array
            db[name] = db[class]
			db[class] = {}
			madeArrays = 1
        end
	end
	
	return madeArrays
end


function Talented:LoadOldTemplates(db)
	local invalid = {}
	local converted = {}

	--Load old template and place it into the db by class
	for name, code in pairs(db) do
		if not self:is_class(name) then 
			if type(code) == "string" then
				local class = self:GetTemplateStringClass(code)
				if class then
					db[class][name] = {
						name = name,
						code = code,
						class = class,
					}
					converted[#converted +1] = name
				else
					invalid[#invalid +1] = name
				end

			elseif not self:ValidateTemplate(code) then
				invalid[#invalid +1] = name
			end

			--Erase this old template
			db[name] = nil
		end
	end

	if next(converted) then
		table.sort(converted)
		self:Print(L["The following templates were converted from a previous version of the addon. Ensure that none are 'invalid' (below); retrieve the backup of your config file from the WTF folder if so."])
		self:Print(table.concat(converted, ", "))
	end
	
	if next(invalid) then
		table.sort(invalid)
		self:Print(L["The following templates are no longer valid and have been removed:"])
		self:Print(table.concat(invalid, ", "))
		return 1 --indicates bad things
	end

	return 0
end

function Talented:LoadTemplates()
	local db = self.db.global.templates
	if Talented:MakeSubArrays(db)==1 then
		--If we had to make the sub arrays, either the database was empty or it has templates as defined in an older version of the addon (arranged by name, not by class)
		self:LoadOldTemplates(db)
	else
		--If we have the nice new layout for templates
		local returnValue = 0
		local invalid = {}
		for class, classdb in pairs(db) do
			assert(self:is_class(class))
			
			for name, code in pairs(classdb) do
				if type(code) == "string" then
					db[class][name] = {
						name = name,
						code = code,
						class = class,
					}
				elseif not self:ValidateTemplate(code) then
					db[class][name] = nil
					invalid[#invalid + 1] = name
				end
			end
		end
		
		if next(invalid) then
			table.sort(invalid)
			self:Print(L["The following templates are no longer valid and have been removed:"])
			self:Print(table.concat(invalid, ", "))
		end
	end

	self.OnDatabaseShutdown = function (self, event, db)
		local db = db.global.templates
		for class, classdb in pairs(db) do
			for name, template in pairs(classdb) do
				template.current = nil
				Talented:PackTemplate(template)
				if template.code then
					db[class][name] = template.code
				end
			end
		end
		self.db = nil
	end
	self.db.RegisterCallback(self, "OnDatabaseShutdown")
	self.LoadTemplates = nil
end

_G.Talented = Talented
