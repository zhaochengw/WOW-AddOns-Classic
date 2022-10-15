local addon, L = ...
local util = MountsJournalUtil
local petRandomIcon = "Interface/AddOns/MountsJournal/textures/INV_Pet_Achievement_CaptureAPetFromEachFamily_Battle" -- select(3, GetSpellInfo(243819))


MJSetPetMixin = util.createFromEventsMixin()


function MJSetPetMixin:onLoad()
	self.mounts = MountsJournal
	self.journal = MountsJournalFrame

	self:SetScript("OnEnter", function(self)
		self.highlight:Show()
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
		GameTooltip:SetText(L["Summonable Battle Pet"])
		local description
		if self.id ~= nil then
			if type(self.id) == "number" then
				description = self.name
			elseif self.id then
				description = L["Summon Random Battle Pet"]
			else
				description = PET_JOURNAL_SUMMON_RANDOM_FAVORITE_PET
			end
		else
			description = L["No Battle Pet"]
		end
		GameTooltip:AddLine(description, 1, 1, 1, false)
		GameTooltip:Show()
	end)
	self:SetScript("OnLeave", function(self)
		self.highlight:Hide()
		GameTooltip:Hide()
	end)
end


function MJSetPetMixin:onEvent(event, ...) self[event](self, ...) end


function MJSetPetMixin:onShow()
	self:SetScript("OnShow", nil)
	C_Timer.After(0, function()
		self:SetScript("OnShow", self.refresh)
		self:refresh()
		self:on("MOUNT_SELECT", self.refresh)
		self:on("UPDATE_PROFILE", self.refresh)
	end)
end


function MJSetPetMixin:onClick()
	if not self.petSelectionList then
		self.petSelectionList = CreateFrame("FRAME", nil, self, "MJCompanionsPanel")
	end
	self.petSelectionList:SetShown(not self.petSelectionList:IsShown())
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end


function MJSetPetMixin:refresh()
	local spellID = self.journal.selectedSpellID
	local petID = self.journal.petForMount[spellID]
	self.id = petID

	if petID == nil then
		self.infoFrame:Hide()
	elseif type(petID) == "number" then
		local name, _, icon = GetSpellInfo(petID)

		self.name = name
		self.infoFrame.icon:SetTexture(icon)
		self.infoFrame.favorite:SetShown(self.mounts.charDB.petFavoritesList[petID])
		self.infoFrame:Show()
	else
		self.infoFrame.icon:SetTexture(petRandomIcon)
		self.infoFrame.favorite:SetShown(not petID)
		self.infoFrame:Show()
	end
end


MJCompanionsPanelMixin = util.createFromEventsMixin()


function MJCompanionsPanelMixin:onEvent(event, ...) self[event](self, ...) end


function MJCompanionsPanelMixin:onLoad()
	self.util = MountsJournalUtil
	self.mounts = MountsJournal
	self.journal = MountsJournalFrame

	self:SetWidth(250)
	self:SetPoint("TOPLEFT", self.journal.bgFrame, "TOPRIGHT")
	self:SetPoint("BOTTOMLEFT", self.journal.bgFrame, "BOTTOMRIGHT")

	self.randomFavoritePet.infoFrame.favorite:Show()
	self.randomFavoritePet.infoFrame.icon:SetTexture(petRandomIcon)
	self.randomFavoritePet.name:SetWidth(180)
	self.randomFavoritePet.name:SetText(PET_JOURNAL_SUMMON_RANDOM_FAVORITE_PET)
	self.randomPet.infoFrame.icon:SetTexture(petRandomIcon)
	self.randomPet.name:SetWidth(180)
	self.randomPet.name:SetText(L["Summon Random Battle Pet"])
	self.noPet.infoFrame.icon:SetTexture("Interface/PaperDoll/UI-Backpack-EmptySlot")
	self.noPet.name:SetWidth(180)
	self.noPet.name:SetText(L["No Battle Pet"])

	self.petList = {}
	self.petFiltredList = {}

	self.searchBox:SetScript("OnTextChanged", function(searchBox)
		SearchBoxTemplate_OnTextChanged(searchBox)
		self:updateFilters()
	end)

	self.listScroll.update = function() self:refresh() end
	self.listScroll.scrollBar.doNotHide = true
	HybridScrollFrame_CreateButtons(self.listScroll, "MJPetListButton")

	self.companionOptionsMenu = LibStub("LibSFDropDown-1.4"):SetMixin({})
	self.companionOptionsMenu:ddHideWhenButtonHidden(self)
	self.companionOptionsMenu:ddSetInitFunc(function(...) self:companionOptionsMenu_Init(...) end)
	self.companionOptionsMenu:ddSetDisplayMode(addon)

	self:on("MOUNT_SELECT", self.Hide)
end


function MJCompanionsPanelMixin:onShow()
	self:SetScript("OnShow", nil)
	C_Timer.After(0, function()
		self:SetScript("OnShow", function(self)
			self:refresh()
			self:scrollToSelectedPet()
			self:on("UPDATE_PROFILE", self.refresh)
		end)
		self:petListUpdate()
		self:scrollToSelectedPet()
		self:on("UPDATE_PROFILE", self.refresh)
		self:on("CRITTER_LEARNED", self.petListUpdate)
	end)
end


function MJCompanionsPanelMixin:onHide()
	self:off("UPDATE_PROFILE", self.refresh)
	self:Hide()
end


function MJCompanionsPanelMixin:showCompanionOptionsMenu(btn)
	if type(btn.id) ~= "number" then
		self.companionOptionsMenu:ddCloseMenus()
		return
	end

	local index = self.mounts.indexPetBySpellID[btn.id]
	if index then
		self.companionOptionsMenu:ddToggle(1, btn.id, btn, 37, 0)
	else
		self.companionOptionsMenu:ddCloseMenus()
	end
end


function MJCompanionsPanelMixin:companionOptionsMenu_Init(btn, level, petSpellID)
	local index = self.mounts.indexPetBySpellID[petSpellID]
	local creatureID, creatureName, creatureSpellID, icon, active = GetCompanionInfo("CRITTER", index)
	local info = {}
	info.notCheckable = true

	info.text = active and PET_DISMISS or SUMMON
	info.func = function() CallCompanion("CRITTER", index) end
	btn:ddAddButton(info, level)

	if self.mounts.charDB.petFavoritesList[petSpellID] then
		info.text = BATTLE_PET_UNFAVORITE
		info.func = function()
			self.mounts.charDB.petFavoritesList[petSpellID] = nil
			self:petListSort()
			self:GetParent():refresh()
		end
	else
		info.text = BATTLE_PET_FAVORITE
		info.func = function()
			self.mounts.charDB.petFavoritesList[petSpellID] = true
			self:petListSort()
			self:GetParent():refresh()
		end
	end
	btn:ddAddButton(info, level)

	info.func = nil
	info.text = CANCEL
	btn:ddAddButton(info, level)
end


function MJCompanionsPanelMixin:scrollToSelectedPet()
	local selectedPetSpellID = self.journal.petForMount[self.journal.selectedSpellID]
	if type(selectedPetSpellID) ~= "number" then return end
	local scrollFrame = self.listScroll

	for i = 1, #self.petFiltredList do
		local critterIndex = self.petFiltredList[i]
		local creatureID, name, creatureSpellID = GetCompanionInfo("CRITTER", critterIndex)
		if selectedPetSpellID == creatureSpellID then
			local curHeight = scrollFrame.scrollBar:GetValue()
			local maxHeight = i * scrollFrame.buttonHeight
			local minHeight = maxHeight - math.floor(scrollFrame:GetHeight() + .5)

			if curHeight < minHeight then
				scrollFrame.scrollBar:SetValue(minHeight)
			elseif curHeight >= maxHeight then
				scrollFrame.scrollBar:SetValue(maxHeight - scrollFrame.buttonHeight)
			end
			break
		end
	end
end


function MJCompanionsPanelMixin:selectButtonClick(id)
	self.journal.petForMount[self.journal.selectedSpellID] = id
	self.journal:updateMountsList()
	self:GetParent():refresh()
	self:Hide()
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end


function MJCompanionsPanelMixin:refresh()
	local scrollFrame = self.listScroll
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local numPets = #self.petFiltredList
	local selectedPetSpellID = self.journal.petForMount[self.journal.selectedSpellID]

	for i, btn in ipairs(scrollFrame.buttons) do
		local index = i + offset

		if index <= numPets then
			local critterIndex = self.petFiltredList[index]
			local creatureID, name, creatureSpellID, icon, isSummoned = GetCompanionInfo("CRITTER", critterIndex)

			btn.id = creatureSpellID
			btn.creatureID = creatureID
			btn.selectedTexture:SetShown(creatureSpellID == selectedPetSpellID)
			btn.name:SetText(name)
			btn.infoFrame.icon:SetTexture(icon)
			btn.infoFrame.favorite:SetShown(self.mounts.charDB.petFavoritesList[creatureSpellID])

			if btn.showingTooltip then
				btn:GetScript("OnEnter")(btn)
			end

			btn:Show()
		else
			btn:Hide()
		end
	end

	HybridScrollFrame_Update(scrollFrame, scrollFrame.buttonHeight * numPets, scrollFrame:GetHeight())
end


function MJCompanionsPanelMixin:petListUpdate()
	wipe(self.petList)
	for i = 1, GetNumCompanions("CRITTER") do
		self.petList[#self.petList + 1] = i
	end

	self:petListSort()
end


function MJCompanionsPanelMixin:petListSort()
	sort(self.petList, function(p1, p2)
		local _, name1, creatureSpellID1 = GetCompanionInfo("CRITTER", p1)
		local _, name2, creatureSpellID2 = GetCompanionInfo("CRITTER", p2)

		local favorite1 = self.mounts.charDB.petFavoritesList[creatureSpellID1]
		local favorite2 = self.mounts.charDB.petFavoritesList[creatureSpellID2]
		if favorite1 and not favorite2 then return true
		elseif not favorite1 and favorite2 then return false end

		if name1 < name2 then return true
		elseif name1 > name2 then return false end

		return creatureSpellID1 < creatureSpellID2
	end)

	self:updateFilters()
end


function MJCompanionsPanelMixin:updateFilters()
	local text = self.util.cleanText(self.searchBox:GetText())

	wipe(self.petFiltredList)
	for i = 1, #self.petList do
		local petIndex = self.petList[i]
		local _, name = GetCompanionInfo("CRITTER", petIndex)

		if #text == 0
		or name:lower():find(text, 1, true)
		then
			self.petFiltredList[#self.petFiltredList + 1] = petIndex
		end
	end

	self:refresh()
end