local addon, L = ...
local util = MountsJournalUtil


MountsJournalFrame:on("MODULES_INIT", function(journal)
	local dd = LibStub("LibSFDropDown-1.4"):CreateStretchButtonOriginal(journal.bgFrame, 130, 22)
	dd:SetPoint("LEFT", journal.summonButton, "RIGHT", 4, 0)
	dd:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
		GameTooltip:SetText(self.Text:GetText())
		GameTooltip:AddLine(L["ProfilesTooltipDescription"], 1, 1, 1, true)
		GameTooltip:Show()
	end)

	util.setEventsMixin(dd)
	journal.bgFrame.profilesMenu = dd

	StaticPopupDialogs[util.addonName.."NEW_PROFILE"] = {
		text = addon..": "..L["New profile"],
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = 48,
		editBoxWidth = 350,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function(popup, data)
			local text = popup.editBox:GetText()
			if text and text ~= "" then
				if dd.profiles[text] ~= nil then
					popup:Hide()
					dd.lastProfileName = text
					StaticPopup_Show(util.addonName.."PROFILE_EXISTS", nil, nil, data)
					return
				end
				dd.profiles[text] = data and util:copyTable(data) or {}
				dd.mounts:checkProfile(dd.profiles[text])
				dd:setProfile(text)
			end
		end,
		EditBoxOnEnterPressed = function(self)
			StaticPopup_OnClick(self:GetParent(), 1)
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide()
		end,
		OnShow = function(self)
			self.editBox:SetText(UnitName("player").." - "..GetRealmName())
			self.editBox:HighlightText()
		end,
	}
	local function profileExistsAccept(popup, data)
		if not popup then return end
		popup:Hide()
		local dialog = StaticPopup_Show(util.addonName.."NEW_PROFILE", nil, nil, data)
		if dialog and dd.lastProfileName then
			dialog.editBox:SetText(dd.lastProfileName)
			dialog.editBox:HighlightText()
			dd.lastProfileName = nil
		end
	end
	StaticPopupDialogs[util.addonName.."PROFILE_EXISTS"] = {
		text = addon..": "..L["A profile with the same name exists."],
		button1 = OKAY,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = profileExistsAccept,
		OnCancel = profileExistsAccept,
	}
	StaticPopupDialogs[util.addonName.."DELETE_PROFILE"] = {
		text = addon..": "..L["Are you sure you want to delete profile %s?"],
		button1 = DELETE,
		button2 = CANCEL,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function(_, cb) cb() end,
	}
	StaticPopupDialogs[util.addonName.."YOU_WANT"] = {
		text = addon..": "..L["Are you sure you want %s?"],
		button1 = OKAY,
		button2 = CANCEL,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function(_, cb) cb() end,
	}

	function dd:createProfile(copy)
		local currentProfile = copy and self.journal.db or nil
		StaticPopup_Show(util.addonName.."NEW_PROFILE", nil, nil, currentProfile)
	end

	function dd:deleteProfile(profileName)
		StaticPopup_Show(util.addonName.."DELETE_PROFILE", NORMAL_FONT_COLOR:WrapTextInColorCode(profileName), nil, function()
			self.profiles[profileName] = nil
			if self.charDB.currentProfileName == profileName then
				self:setProfile()
			else
				self.mounts:setDB()
			end
		end)
	end

	function dd:setProfile(profileName)
		if profileName == nil or self.profiles[profileName] then
			self.charDB.currentProfileName = profileName
			self:SetText(profileName or DEFAULT)
			self:event("UPDATE_PROFILE", true)
		end
	end

	function dd:selectAllMounts(actionText, onlyFavorites)
		StaticPopup_Show(util.addonName.."YOU_WANT", NORMAL_FONT_COLOR:WrapTextInColorCode(actionText), nil, function()
			if not self.journal.list then
				self.journal:createMountList(self.journal.listMapID)
			end

			for i = 1, GetNumCompanions("MOUNT") do
				local creatureID, creatureName, spellID, icon, isSummoned = GetCompanionInfo("MOUNT", i)
				if not onlyFavorites or self.mounts.mountFavoritesList[spellID] then
					self.mounts:addMountToList(self.journal.list, spellID)
				end
			end
			self:event("UPDATE_PROFILE")
		end)
	end

	function dd:unselectAllMounts()
		StaticPopup_Show(util.addonName.."YOU_WANT", NORMAL_FONT_COLOR:WrapTextInColorCode(L["Unselect all mounts in selected zone"]), nil, function()
			if self.journal.list then
				wipe(self.journal.list.fly)
				wipe(self.journal.list.ground)
				wipe(self.journal.list.swimming)
				self.journal:getRemoveMountList(self.journal.listMapID)
				self:event("UPDATE_PROFILE")
			end
		end)
	end

	dd.mounts = MountsJournal
	dd.journal = journal
	dd.profiles = dd.mounts.profiles
	dd.charDB = dd.mounts.charDB
	dd.profileNames = {}
	dd:SetText(dd.charDB.currentProfileName or DEFAULT)

	dd:ddSetDisplayMode(addon)
	dd:ddSetInitFunc(function(self, level, value)
		local info = {}

		if level == 1 then -- MENU
			info.notCheckable = true
			info.isTitle = true
			info.text = L["Profiles"]
			self:ddAddButton(info, level)

			self:ddAddSeparator(level)

			info.notCheckable = nil
			info.isTitle = nil

			info.list = {
				{
					text = DEFAULT,
					checked = function() return self.charDB.currentProfileName == nil end,
					func = function() self:setProfile() end,
				},
			}
			for _, profileName in ipairs(self.profileNames) do
				tinsert(info.list, {
					text = profileName,
					checked = function(btn) return self.charDB.currentProfileName == btn.text end,
					func = function(btn) self:setProfile(btn.text) end,
					remove = function(btn) self:deleteProfile(btn.text) end,
				})
			end
			self:ddAddButton(info, level)
			info.list = nil

			self:ddAddSeparator(level)

			info.keepShownOnClick = true
			info.notCheckable = true
			info.hasArrow = true

			info.text = L["Profile settings"]
			info.value = "settings"
			self:ddAddButton(info, level)

			info.text = L["New profile"]
			info.value = "new"
			self:ddAddButton(info, level)

			self:ddAddSeparator(level)

			info.notCheckable = nil
			info.isNotRadio = true
			info.text = L["Areans and Battlegrounds"]
			info.value = "pvp"
			info.checked = function() return self.charDB.profileBySpecializationPVP.enable end
			info.func = function(_,_,_, checked)
				self.charDB.profileBySpecializationPVP.enable = checked
				self.mounts:setDB()
			end
			self:ddAddButton(info, level)

		elseif value == "settings" then -- PROFILE SETTINGS
			info.notCheckable = true
			info.isTitle = true
			info.text = self.charDB.currentProfileName or DEFAULT
			self:ddAddButton(info, level)

			self:ddAddSeparator(level)

			info.notCheckable = nil
			info.isTitle = nil
			info.isNotRadio = true
			info.keepShownOnClick = true

			if self.charDB.currentProfileName ~= nil then
				info.text = L["Pet binding from default profile"]
				info.checked = function() return self.journal.db.petListFromProfile end
				info.func = function(_,_,_, checked)
					self.journal.db.petListFromProfile = checked and true or nil
					self:event("UPDATE_PROFILE")
				end
				self:ddAddButton(info, level)

				info.text = L["Zones settings from default profile"]
				info.checked = function() return self.journal.db.zoneMountsFromProfile end
				info.func = function(_,_,_, checked)
					self.journal.db.zoneMountsFromProfile = checked and true or nil
					self:event("UPDATE_PROFILE")
				end
				self:ddAddButton(info, level)
			end

			info.text = L["Auto add new mounts to selected"]
			info.checked = function() return self.journal.db.autoAddNewMount end
			info.func = function(_,_,_, checked)
				self.journal.db.autoAddNewMount = checked and true or nil
			end
			self:ddAddButton(info, level)

			info.notCheckable = true
			info.keepShownOnClick = nil

			info.text = L["Select all favorite mounts by type in the selected zone"]
			info.func = function(btn) self:selectAllMounts(btn.text, true) end
			self:ddAddButton(info, level)

			info.text = L["Select all mounts by type in selected zone"]
			info.func = function(btn) self:selectAllMounts(btn.text) end
			self:ddAddButton(info, level)

			info.text = L["Unselect all mounts in selected zone"]
			info.func = function() self:unselectAllMounts() end
			self:ddAddButton(info, level)

		elseif value == "new" then -- NEW PROFLE
			info.notCheckable = true

			info.text = L["Create"]
			info.func = function() self:createProfile() end
			self:ddAddButton(info, level)

			info.text = L["Copy current"]
			info.func = function() self:createProfile(true) end
			self:ddAddButton(info, level)

		elseif value == "pvp" then -- PVP
			local profileBy = self.charDB.profileBySpecializationPVP

			info.list = {
				{
					keepShownOnClick = true,
					arg1 = 1,
					text = DEFAULT,
					checked = function(btn)
						return profileBy[btn.arg1] == nil
					end,
					func = function(_, arg1)
						profileBy[arg1] = nil
						self.mounts:setDB()
						self:ddRefresh(level)
					end,
				}
			}
			for _, profileName in ipairs(self.profileNames) do
				tinsert(info.list, {
					keepShownOnClick = true,
					arg1 = 1,
					text = profileName,
					checked = function(btn)
						return profileBy[btn.arg1] == btn.text
					end,
					func = function(btn, arg1)
						profileBy[arg1] = btn.text
						self.mounts:setDB()
						self:ddRefresh(level)
					end,
				})
			end
			self:ddAddButton(info, level)
		end
	end)

	dd:SetScript("OnClick", function(self)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		wipe(self.profileNames)
		for k in pairs(self.profiles) do tinsert(self.profileNames, k) end
		sort(self.profileNames)
		self:ddToggle(1, nil, self, 112, 17)
	end)
end)