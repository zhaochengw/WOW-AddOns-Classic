local _, L = ...


MJExistingListsMixin = {}


function MJExistingListsMixin:onLoad()
	self.util = MountsJournalUtil
	self.journal = MountsJournalFrame

	self.searchBox:SetScript("OnTextChanged", function(searchBox)
		SearchBoxTemplate_OnTextChanged(searchBox)
		self:refresh()
	end)

	self.child = self.scrollFrame.child
	self.optionsButtonPool = CreateFramePool("BUTTON", self.child, "MJOptionButtonTemplate", function(_, frame)
		frame:Hide()
		frame:ClearAllPoints()
		frame:Enable()
	end)
	self.lists = {}
	local listNames = {
		L["Zones with list"],
		L["Zones with relation"],
		L["Zones with flags"],
	}

	for i, name in ipairs(listNames) do
		local button = CreateFrame("CheckButton", nil, self.child, "MJCollapseButtonTemplate")
		button.name = name
		button.childs = {}
		button:SetScript("OnClick", function(btn)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			self:collapse(btn, i)
		end)
		tinsert(self.lists, button)
	end

	self.lists[1]:SetPoint("TOPLEFT", self.child)
	self.lists[1]:SetPoint("TOPRIGHT", self.child)
end


function MJExistingListsMixin:collapse(btn, i)
	local checked = btn:GetChecked()
	btn.toggle.plusMinus:SetTexture(checked and "Interface/Buttons/UI-PlusButton-UP" or "Interface/Buttons/UI-MinusButton-UP")

	for _, child in ipairs(btn.childs) do
		child:SetShown(not checked)
	end

	local nextButton = self.lists[i + 1]
	if nextButton then
		local relativeFrame = checked and btn or btn.childs[#btn.childs]
		nextButton:SetPoint("TOPLEFT", relativeFrame,"BOTTOMLEFT")
		nextButton:SetPoint("TOPRIGHT", relativeFrame,"BOTTOMRIGHT")
	end
end


do
	local function getTextBool(bool)
		return bool and "+" or "-"
	end

	function MJExistingListsMixin:refresh()
		if not self:IsVisible() then return end
		local lastWidth = 0
		local text = self.util.cleanText(self.searchBox:GetText())

		for _, withList in ipairs(self.lists) do
			wipe(withList.childs)
		end
		self.optionsButtonPool:ReleaseAll()

		local function createOptionButton(tbl, mapID, groupID, flags)
			local btnText = self.util.getMapFullNameInfo(mapID).name
			if groupID then
				btnText = ("[%d] %s"):format(groupID, btnText)
			elseif flags then
				btnText = ("%s [%s%s]"):format(btnText, getTextBool(flags.groundOnly), getTextBool(flags.waterWalkOnly))
			end
			if #text == 0 or btnText:lower():find(text, 1, true) then
				local optionButton = self.optionsButtonPool:Acquire()
				optionButton.isGray = flags and not flags.enableFlags
				local color = optionButton.isGray and GRAY_FONT_COLOR or WHITE_FONT_COLOR
				optionButton.text:SetTextColor(color:GetRGB())
				optionButton:SetText(btnText)

				optionButton:SetScript("OnClick", function()
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
					self.journal.navBar:setMapID(mapID)
				end)
				local width = optionButton.text:GetStringWidth()
				if width > lastWidth then lastWidth = width end
				tinsert(tbl, optionButton)
			end
		end

		for mapID, mapConfig in pairs(self.journal.zoneMounts) do
			if mapConfig.listFromID then
				createOptionButton(self.lists[2].childs, mapID, mapConfig.listFromID)
			elseif next(mapConfig.fly) or next(mapConfig.ground) or next(mapConfig.swimming) then
				createOptionButton(self.lists[1].childs, mapID)
			end

			local flags
			for _, value in pairs(mapConfig.flags) do
				if value then
					flags = true
					break
				end
			end

			if flags then
				createOptionButton(self.lists[3].childs, mapID, nil, mapConfig.flags)
			end
		end

		for i, withList in ipairs(self.lists) do
			local childsCount = #withList.childs

			if childsCount == 0 then
				withList:SetText(withList.name)
				local optionButton = self.optionsButtonPool:Acquire()
				optionButton:SetText(EMPTY)
				optionButton:Disable()
				tinsert(withList.childs, optionButton)
			else
				withList:SetText(("%s [%s]"):format(withList.name, childsCount))
				sort(withList.childs, function(a, b)
					return not a.isGray and b.isGray
						or a.isGray == b.isGray and a:GetText() < b:GetText()
				end)
			end

			local width = withList.text:GetStringWidth() + 10
			if lastWidth < width then lastWidth = width end

			local lastChild
			for _, child in ipairs(withList.childs) do
				local relativeFrame = lastChild or withList
				child:SetPoint("TOPLEFT", relativeFrame, "BOTTOMLEFT")
				child:SetPoint("TOPRIGHT", relativeFrame, "BOTTOMRIGHT")
				lastChild = child
			end

			self:collapse(withList, i)
		end

		self.child:SetWidth(lastWidth + 35)
		self:SetWidth(lastWidth + 65)
	end
end