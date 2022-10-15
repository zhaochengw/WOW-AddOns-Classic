local addon, L = ...
local util = MountsJournalUtil


MountsJournalFrame:on("MODULES_INIT", function(journal)
	local dd = LibStub("LibSFDropDown-1.4"):CreateButtonOriginal(journal.modelScene)
	dd:SetAlpha(.5)
	dd:SetPoint("LEFT", journal.modelScene.modelControl, "RIGHT", 10, -.5)
	journal.modelScene.animationsCombobox = dd

	dd:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
	dd:SetScript("OnLeave", function(self) self:SetAlpha(.5) end)
	dd.Button:HookScript("OnEnter", function(btn)
		local parent = btn:GetParent()
		parent:GetScript("OnEnter")(parent)
	end)
	dd.Button:HookScript("OnLeave", function(btn)
		local parent = btn:GetParent()
		parent:GetScript("OnLeave")(parent)
	end)

	StaticPopupDialogs[util.addonName.."DELETE_MOUNT_ANIMATION"] = {
		text = addon..": "..L["Are you sure you want to delete animation %s?"],
		button1 = DELETE,
		button2 = CANCEL,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function(_, cb) cb() end,
	}

	dd.animations = MountsJournal.globalDB.mountAnimations
	dd.animationsList = {
		{
			name = L["Default"],
			animation = 0,
		},
		{
			name = L["Mount special"],
			animation = 94,
		},
		{
			name = L["Walk"],
			animation = 4,
			type = 2,
		},
		{
			name = L["Walk backwards"],
			animation = 13,
			type = 2,
		},
		{
			name = L["Run"],
			animation = 5,
			type = 2,
		},
		{
			name = L["Swim idle"],
			animation = 41,
			type = 3,
		},
		{
			name = L["Swim"],
			animation = 42,
			type = 3,
		},
		{
			name = L["Swim backwards"],
			animation = 45,
			type = 3,
		},
		{
			name = L["Fly stand"],
			animation = 41,
			type = 1,
		},
		{
			name = L["Fly"],
			animation = 135,
			type = 1,
		},
		{
			name = L["Fly backwards"],
			animation = 45,
			type = 1,
		},
	}

	dd.customAnimationPanel = CreateFrame("FRAME", nil, journal.modelScene, "MJMountCustomAnimationPanel")
	dd.customAnimationPanel:SetPoint("BOTTOMRIGHT", dd, "TOPRIGHT", 0, 2)

	journal:on("MOUNT_MODEL_UPDATE", function(journal, mountType, spellID)
		if spellID == 30174 or spellID == 64731 then
			dd.currentMountType = 2
		else
			dd.currentMountType = mountType
		end
		dd:replayAnimation()
	end)

	function dd:replayAnimation()
		if self.selectedValue == "custom" or self.selectedValue and (self.selectedValue.type == nil or self.selectedValue.type >= self.currentMountType) then
			if self.selectedValue.animation ~= 0 then
				self:SetScript("OnUpdate", self.onUpdate)
			end
		else
			local actor = journal.modelScene:GetActorByTag("unwrapped")
			if actor then actor:StopAnimationKit() end
			self:ddSetSelectedValue(self.animationsList[1])
			self:ddSetSelectedText(self.animationsList[1].name)
		end
	end

	function dd:onUpdate()
		local actor = journal.modelScene:GetActorByTag("unwrapped")
		if actor and not actor:IsLoaded() then return end
		self:SetScript("OnUpdate", nil)

		C_Timer.After(0, function()
			if self.selectedValue == "custom" then
				self.customAnimationPanel:play()
			else
				self:playAnimation(self.selectedValue.animation, self.selectedValue.isKit, self.selectedValue.loop)
			end
		end)
	end

	function dd:initialize(level)
		local info = {}
		local mountType = self.currentMountType or 1

		local function checked(btn) return self.selectedValue == btn.value end
		local function func(btn)
			self.customAnimationPanel:Hide()
			self:playAnimation(btn.value.animation, btn.value.isKit, btn.value.loop)
			self:ddSetSelectedValue(btn.value, level)
			self:ddSetSelectedText(btn.value.name)
		end
		local function remove(btn) self:deleteAnimation(btn.arg1) end

		info.list = {}
		for _, v in ipairs(self.animationsList) do
			if v.type == nil or v.type >= mountType then
				tinsert(info.list, {
					text = ("%s|cff808080.%d%s|r"):format(v.name, v.animation, v.isKit and ".k" or ""),
					value = v,
					checked = checked,
					func = func,
				})
			end
		end
		for i, v in ipairs(self.animations) do
			tinsert(info.list, {
				text = ("%s|cff808080.%d%s|r"):format(v.name, v.animation, v.isKit and ".k" or ""),
				value = v,
				arg1 = i,
				checked = checked,
				func = func,
				remove = remove,
			})
		end
		tinsert(info.list, {
			text = CUSTOM,
			value = "custom",
			checked = checked,
			func = function(btn)
				self.customAnimationPanel:Show()
				self.customAnimationPanel:play()
				self:ddSetSelectedValue(btn.value, level)
			end,
		})
		self:ddAddButton(info, level)
	end

	function dd:playAnimation(animation, isKit, loop)
		local actor = journal.modelScene:GetActorByTag("unwrapped")
		actor:StopAnimationKit()
		--max animation 2^31 - 1
		if isKit then
			actor:PlayAnimationKit(animation, loop)
		else
			actor:PlayAnimationKit(0)
			actor:StopAnimationKit()
			actor:SetAnimation(animation, 0)
		end
	end

	function dd:deleteAnimation(id)
		local animation = self.animations[id]
		StaticPopup_Show(util.addonName.."DELETE_MOUNT_ANIMATION", NORMAL_FONT_COLOR_CODE..animation.name..FONT_COLOR_CODE_CLOSE, nil, function()
			if self.selectedValue == animation then
				local value = self.animationsList[1]
				self:playAnimation(value.animation, value.isKit, value.loop)
				self:ddSetSelectedValue(value)
				self:ddSetSelectedText(value.name)
			end
			for i = 1, #self.animations do
				if self.animations[i] == animation then
					tremove(self.animations, i)
					break
				end
			end
		end)
	end
end)


MJMountCustomAnimationMixin = {}


function MJMountCustomAnimationMixin:onLoad()
	self.journal = MountsJournalFrame
	self.animations = MountsJournal.globalDB.mountAnimations
	self.animationsCombobox = self:GetParent().animationsCombobox
	if type(self.animations.current) ~= "number" then
		self.animations.current = 0
	end

	self.animationNum:SetText(self.animations.current)
	self.animationNum:SetScript("OnEnterPressed", function(edit)
		self.animations.current = tonumber(edit:GetText()) or 0
		self:play()
		edit:ClearFocus()
	end)
	self.animationNum:SetScript("OnEscapePressed", function(edit)
		edit:SetText(self.animations.current)
		edit:ClearFocus()
	end)
	self.animationNum:SetScript("OnEditFocusLost", function(edit)
		self.animations.current = tonumber(edit:GetText()) or 0
	end)
	self.animationNum:SetScript("OnMouseWheel", function(_, delta)
		if delta > 0 then
			self:nextAnimation()
		else
			self:previousAnimation()
		end
	end)

	self.minus:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self:previousAnimation()
	end)

	self.plus:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self:nextAnimation()
	end)

	self.playButton:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self:play()
	end)
	self.playButton:HookScript("OnMouseDown", function(self)
		self.texture:SetPoint("CENTER", -1, -2)
	end)
	self.playButton:HookScript("OnMouseUp", function(self)
		self.texture:SetPoint("CENTER")
	end)

	self.stopButton:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self:stop()
	end)
	self.stopButton:HookScript("OnMouseDown", function(self)
		self.texture:SetPoint("CENTER", -1, -2)
	end)
	self.stopButton:HookScript("OnMouseUp", function(self)
		self.texture:SetPoint("CENTER")
	end)

	self.isKit.Text:SetText("IsKit")
	self.isKit:SetChecked(self.animations.isKit)
	self.isKit:SetScript("Onclick", function(btn)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		local checked = btn:GetChecked()
		self.animations.isKit = checked
		self.loop:SetEnabled(checked)
		self:play()
	end)

	self.loop.Text:SetText(L["Loop"])
	self.loop:SetChecked(self.animations.loop)
	self.loop:SetEnabled(self.animations.isKit)
	self.loop:SetScript("OnClick", function(btn)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self.animations.loop = btn:GetChecked()
		self:play()
	end)

	self.save:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self:saveAnimation()
	end)
end


function MJMountCustomAnimationMixin:previousAnimation()
	if self.animations.current > 0 then
		self:setAnimation(self.animations.current - 1)
	end
end


function MJMountCustomAnimationMixin:nextAnimation()
	if self.animations.current < 10000 then
		self:setAnimation(self.animations.current + 1)
	end
end


function MJMountCustomAnimationMixin:setAnimation(n)
	self.animations.current = n
	self.animationNum:SetText(n)
	self:play()
end


function MJMountCustomAnimationMixin:play()
	self.animationsCombobox:playAnimation(self.animations.current, self.animations.isKit, self.animations.loop)
end


function MJMountCustomAnimationMixin:stop()
	local actor = self.journal.modelScene:GetActorByTag("unwrapped")
	actor:StopAnimationKit()
	actor:SetAnimation(0)
end


function MJMountCustomAnimationMixin:saveAnimation()
	local name = self.nameBox:GetText()
	if #name > 0 then
		tinsert(self.animations, {
			name = name,
			animation = self.animations.current or 0,
			isKit = self.isKit:GetChecked(),
			loop = self.loop:GetChecked(),
		})
		sort(self.animations, function(a1, a2)
			if a1.name < a2.name then return true
			elseif a1.name > a2.name then return false end

			if not a1.isKit and a2.isKit then return true
			elseif a1.isKit and not a2.isKit then return false end

			return a1.animation < a2.animation
		end)
		self.nameBox:SetText("")
	end
end