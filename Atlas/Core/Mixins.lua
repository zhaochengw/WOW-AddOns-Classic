AtlasAchievementEntryMixin = {}

function AtlasAchievementEntryMixin:Init(data)
	Atlas:GetAchievementName(self, data.achievementID)
end

function AtlasAchievementEntryMixin:OnClick()
	if IsShiftKeyDown() then
		local chat = ChatEdit_GetActiveWindow();
		if chat then
			chat:Insert(GetAchievementLink(self.data.achievementID));
		end
	else
		Atlas:OpenAchievement(self.data.achievementID)
	end
end

function AtlasAchievementEntryMixin:OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
	GameTooltip:SetHyperlink(GetAchievementLink(self.data.achievementID))
	GameTooltip:Show()
end

function AtlasAchievementEntryMixin:OnLeave()
	GameTooltip:Hide()
end

--------------------------------------------------------------------------------------------

AtlasBossEntryMixin = {}

function AtlasBossEntryMixin:Init(data)
	self.Text:SetText(data.text)
end

function AtlasBossEntryMixin:OnClick(button)
	if (self.data.instanceID and self.data.encounterID) then
		if IsShiftKeyDown() then
			local chat = ChatEdit_GetActiveWindow();
			if chat then
				local _, _, _, _, link = EJ_GetEncounterInfo(self.data.encounterID)
				if link then
					chat:Insert(link);
				end
			end
		elseif (button == "RightButton") then
			Atlas:AtlasLootButton_OnClick(self)
		else
			Atlas:AdventureJournal_EncounterButton_OnClick(self.data.instanceID, self.data.encounterID)
		end
	end
end

function AtlasBossEntryMixin:OnEnter()
	local name, description = EJ_GetEncounterInfo(self.data.encounterID)
	if (name) then
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
		GameTooltip:SetText(name, 1, 1, 1, 1)

		if (self.data.encounterID and C_EncounterJournal.IsEncounterComplete(self.data.encounterID)) then
			GameTooltip_AddColoredLine(GameTooltip, DUNGEON_ENCOUNTER_DEFEATED, RED_FONT_COLOR);
		end

		if (description) then
			GameTooltip:AddLine(description, nil, nil, nil, 1)
		end

		-- TODO: When holding shift?
		--[[ if (self.overviewDescription) then
			GameTooltip:AddLine("\n"..OVERVIEW, 1, 1, 1, 1)
			GameTooltip:AddLine(self.overviewDescription, nil, nil, nil, 1)
			if (self.roleOverview) then
				GameTooltip:AddLine("\n"..self.roleOverview, nil, nil, nil, 1)
			end
		end ]]

		if (self.data.encounterID) then
			if (EJ_GetEncounterInfo) then
				GameTooltip:AddLine(ATLAS_OPEN_ADVENTURE, 0.5, 0.5, 1, true)
			end
			if (Atlas:CheckAddonStatus("AtlasLoot")) then
				GameTooltip:AddLine(ATLAS_ROPEN_ATLASLOOT_WINDOW, 0.5, 0.5, 1, true)
			end
		end

		GameTooltip:Show()
	end
end

function AtlasBossEntryMixin:OnLeave()
	GameTooltip:Hide()
end

--------------------------------------------------------------------------------------------

AtlasItemEntryMixin = {}

function AtlasItemEntryMixin:Init(data)
	local itemName = C_Item.GetItemInfo(data.itemID)
	itemName = itemName or C_Item.GetItemInfo(data.itemID) or data.fallbackName or ""
	self.Text:SetText(data.text..itemName)
end

function AtlasItemEntryMixin:OnClick()
	if IsShiftKeyDown() then
		local chat = ChatEdit_GetActiveWindow();
		if chat then
			-- item should be cached already because it was fetched when displayed
			local _, link = C_Item.GetItemInfo(self.data.itemID);
			chat:Insert(link);
		end
	end
end

function AtlasItemEntryMixin:OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
	GameTooltip:SetHyperlink("item:"..self.data.itemID)
	GameTooltip:Show()
end

function AtlasItemEntryMixin:OnLeave()
	GameTooltip:Hide()
end

--------------------------------------------------------------------------------------------

AtlasStringEntryMixin = {}

function AtlasStringEntryMixin:Init(data)
	self.Text:SetText(data.text)
end
