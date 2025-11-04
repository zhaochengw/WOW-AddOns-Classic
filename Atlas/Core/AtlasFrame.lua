--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert at gmail dot com>
	Copyright 2010 - Lothaer <lothayer at gmail dot com>, Atlas Team
	Copyright 2011 ~ 2023 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

-- AtlasFrame's related handling to be managed here

-- ----------------------------------------------------------------------------
-- AddOn namespace
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

-- Simple function to toggle the Atlas frame's lock status and update it's appearance
function addon:ToggleLock()
	addon.db.profile.options.frames.lock = not addon.db.profile.options.frames.lock
	addon:UpdateLock()
	Atlas_Refresh()
end

-- Updates the appearance of the lock button based on the status of AtlasLocked
function addon:UpdateLock()
	local btnLckUp = "Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Up"
	local btnLckDn = "Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Down"
	local btnUlckUp = "Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Up"
	local btnUnlckDn = "Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Down"
	if (addon.db.profile.options.frames.lock) then
		AtlasLockNorm:SetTexture(btnLckUp)
		AtlasLockPush:SetTexture(btnLckDn)
		AtlasLockSmallNorm:SetTexture(btnLckUp)
		AtlasLockSmallPush:SetTexture(btnLckDn)
	else
		AtlasLockNorm:SetTexture(btnUlckUp)
		AtlasLockPush:SetTexture(btnUnlckDn)
		AtlasLockSmallNorm:SetTexture(btnUlckUp)
		AtlasLockSmallPush:SetTexture(btnUnlckDn)
	end
end

-- Begin moving the Atlas frame if it's unlocked
function addon:StartMoving(self)
	if (not addon.db.profile.options.frames.lock) then
		self:StartMoving()
	end
end

-- Sets the transparency of the Atlas frame based on AtlasAlpha
function addon:UpdateAlpha()
	local alpha = addon.db.profile.options.frames.alpha
	AtlasFrame:SetAlpha(alpha)
end

function addon:UpdateSmallAlpha()
	local alpha = addon.db.profile.options.frames.smallAlpha
	AtlasFrameSmall:SetAlpha(alpha)
end

-- Sets the scale of the Atlas frame based on AtlasScale
function addon:UpdateScale()
	local scale = addon.db.profile.options.frames.scale
	AtlasFrame:SetScale(scale)
end

function addon:UpdateSmallScale()
	local scale = addon.db.profile.options.frames.smallScale
	AtlasFrameSmall:SetScale(scale)
end

function addon:PrevNextMap_OnClick(self)
	local mapID = self.mapID
	if not mapID then return; end

	for k, v in pairs(ATLAS_DROPDOWNS) do
		for k2, v2 in pairs(v) do
			if (v2 == mapID) then
				addon.db.profile.options.dropdowns.module = k
				addon.db.profile.options.dropdowns.zone = k2

				AtlasFrameDropDownType_OnShow()
				AtlasFrameDropDown_OnShow()
				Atlas_Refresh()
				return
			end
		end
	end
end

function addon:ToggleLegendPanel()
	if (AtlasFrameSmall:IsVisible()) then
		ATLAS_SMALLFRAME_SELECTED = false
		AtlasFrameSmall:Hide()
		AtlasFrame:Show()
	else
		ATLAS_SMALLFRAME_SELECTED = true
		AtlasFrame:Hide()
		AtlasFrameSmall:Show()
	end
end

-- Called whenever the map type dropdown menu is shown
function AtlasFrameDropDownType_OnShow()
	wipe(ATLAS_DROPDOWN_TYPES)
	local i = 1
	local catName = addon.dropdowns.DropDownLayouts_Order[addon.db.profile.options.dropdowns.menuType]
	local subcatOrder = addon.dropdowns.DropDownLayouts_Order[catName]
	if (subcatOrder and type(subcatOrder) == "table") then
		sort(subcatOrder)
		for n = 1, #subcatOrder, 1 do
			local subcatItems = addon.dropdowns.DropDownLayouts[catName][subcatOrder[n]]
			local q = (#subcatItems - (#subcatItems % ATLAS_MAX_MENUITEMS)) / ATLAS_MAX_MENUITEMS

			if (q > 0) then
				for p = 0, q do
					ATLAS_DROPDOWN_TYPES[i + p] = subcatOrder[n]..format(" %d/%d", p + 1, q + 1)
				end
			else
				ATLAS_DROPDOWN_TYPES[i] = subcatOrder[n]
			end
			i = i + q + 1
		end
	end
	for j = 1, #Atlas_MapTypes, 1 do
		ATLAS_DROPDOWN_TYPES[i] = Atlas_MapTypes[j]
		i = i + 1
	end

	local function IsSelected(index) return index == addon.db.profile.options.dropdowns.module; end
	local function SetSelection(index)
		AtlasFrameDropDownType_OnClick(index);
	end

	local function GeneratorFunction(dropdown, rootDescription)
		for key, option in ipairs(ATLAS_DROPDOWN_TYPES) do
			rootDescription:CreateRadio(option, IsSelected, SetSelection, key);
		end
	end
	AtlasFrameDropDownType:SetupMenu(GeneratorFunction);
	AtlasFrameSmallDropDownType:SetupMenu(GeneratorFunction);
end

-- Called whenever an item in the map type dropdown menu is clicked
-- Sets the main dropdown menu contents to reflect the category of map selected
function AtlasFrameDropDownType_OnClick(typeID)
	local profile = addon.db.profile

	profile.options.dropdowns.module = typeID
	local dropdowns_catKey = AtlasFrameDropDownType:GetText()
	local index = profile.dropdowns[dropdowns_catKey]
	if (index and ATLAS_DROPDOWNS[typeID] and ATLAS_DROPDOWNS[typeID][index]) then
		profile.options.dropdowns.zone = profile.dropdowns[dropdowns_catKey]
	else
		profile.options.dropdowns.zone = 1
	end

	AtlasFrameDropDown_OnShow()
	Atlas_Refresh()
end

-- Called whenever the main dropdown menu is shown
function AtlasFrameDropDown_OnShow()
	if (ATLAS_DROPDOWNS[addon.db.profile.options.dropdowns.module]) then
		local temp = {}
		for k, v in pairs(ATLAS_DROPDOWNS[addon.db.profile.options.dropdowns.module]) do
			local colortag = ""

			if (addon.db.profile.options.dropdowns.color and AtlasMaps[v].DungeonID) then
				local minLevel, minRecLevel
				if (GetLFGDungeonInfo) then
					_, _, _, minLevel, _, _, minRecLevel = GetLFGDungeonInfo(AtlasMaps[v].DungeonID)
				end
				if (minRecLevel == 0) then
					minRecLevel = minLevel
				end

				if (not minRecLevel and AtlasMaps[v].ActivityID) then
					local info = C_LFGList.GetActivityInfoTable(AtlasMaps[v].ActivityID[2])
					minRecLevel = info.minLevelSuggestion == 0 and info.minLevel or info.minLevelSuggestion
				end

				local dungeon_difficulty = addon:GetDungeonDifficultyColor(minRecLevel)
				colortag = addon:FormatColor(dungeon_difficulty)
			elseif (addon.db.profile.options.dropdowns.color and AtlasMaps[v].DungeonHeroicID) then
				local minLevelH, minRecLevelH
				if (GetLFGDungeonInfo) then
					_, _, _, minLevelH, _, _, minRecLevelH = GetLFGDungeonInfo(AtlasMaps[v].DungeonHeroicID)
				end
				if (minRecLevelH == 0) then
					minRecLevelH = minLevelH
				end
				local dungeon_difficulty = addon:GetDungeonDifficultyColor(minRecLevelH)
				colortag = addon:FormatColor(dungeon_difficulty)
			elseif (addon.db.profile.options.dropdowns.color and AtlasMaps[v].DungeonMythicID) then
				local minLevelM, minRecLevelM
				if (GetLFGDungeonInfo) then
					_, _, _, minLevelM, _, _, minRecLevelM = GetLFGDungeonInfo(AtlasMaps[v].DungeonMythicID)
				end
				if (minRecLevelM == 0) then
					minRecLevelM = minLevelM
				end
				local dungeon_difficulty = addon:GetDungeonDifficultyColor(minRecLevelM)
				colortag = addon:FormatColor(dungeon_difficulty)
			elseif (addon.db.profile.options.dropdowns.color and AtlasMaps[v].MinLevel) then
				if (type(AtlasMaps[v].MinLevel) == "number") then
					local dungeon_difficulty = addon:GetDungeonDifficultyColor(AtlasMaps[v].MinLevel)
					colortag = addon:FormatColor(dungeon_difficulty)
				else
					--colortag = ""
				end
			else
				--colortag = ""
			end

			local zoneName         = AtlasMaps[v].ZoneName[1]
			local instanceID       = AtlasMaps[v].JournalInstanceID or nil
			local DungeonID        = AtlasMaps[v].DungeonID or nil
			local DungeonHeroicID  = AtlasMaps[v].DungeonHeroicID or nil
			local DungeonMythicID  = AtlasMaps[v].DungeonMythicID or nil

			local typeID, subtypeID, minLevel, maxLevel
			local typeIDH, subtypeIDH, minLevelH, maxLevelH
			local typeIDM, subtypeIDM, minLevelM, maxLevelM
			local colortagL, dungeon_difficulty
			local icontext_heroic  = " |TInterface\\EncounterJournal\\UI-EJ-HeroicTextIcon:0:0|t"
			local icontext_mythic  = " |TInterface\\AddOns\\Atlas\\Images\\UI-EJ-MythicTextIcon:0:0|t"
			local icontext_dungeon = "|TInterface\\MINIMAP\\Dungeon:0:0|t"
			local icontext_raid    = "|TInterface\\MINIMAP\\Raid:0:0|t"
			local icontext_instance

			if (DungeonID) then
				if (GetLFGDungeonInfo) then
					_, typeID, subtypeID, minLevel, maxLevel = GetLFGDungeonInfo(DungeonID)
				end
			end
			if (DungeonHeroicID) then
				if (GetLFGDungeonInfo) then
					_, typeIDH, subtypeIDH, minLevelH, maxLevelH = GetLFGDungeonInfo(DungeonHeroicID)
				end
			end
			if (DungeonMythicID) then
				if (GetLFGDungeonInfo) then
					_, typeIDM, subtypeIDM, minLevelM, maxLevelM = GetLFGDungeonInfo(DungeonMythicID)
				end
			end
			if ((typeID and typeID == 2) or (typeIDH and typeIDH == 2) or (typeIDM and typeIDM == 2)) then
				icontext_instance = icontext_raid
			elseif ((typeID and typeID == 1 and subtypeID == 3) or (typeIDH and typeIDH == 1 and subtypeIDH == 3) or (typeIDM and typeIDM == 1 and subtypeIDM == 3)) then
				icontext_instance = icontext_raid
			else
				icontext_instance = icontext_dungeon
			end
			local levelString = ""
			if (minLevel or minLevelH or minLevelM) then
				local tmp_LR = " - "
				if (minLevel) then
					dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevel)
					colortagL = addon:FormatColor(dungeon_difficulty)
					if (minLevel ~= maxLevel) then
						tmp_LR = tmp_LR..colortagL..minLevel.."-"..maxLevel..icontext_instance
					else
						tmp_LR = tmp_LR..colortagL..minLevel..icontext_instance
					end
				end
				if (minLevelH) then
					dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevelH)
					colortagL = addon:FormatColor(dungeon_difficulty)
					local slash
					if (minLevel) then
						slash = L["Slash"]
					else
						slash = ""
					end
					if (minLevelH ~= maxLevelH) then
						tmp_LR = tmp_LR..slash..colortagL..minLevelH.."-"..maxLevelH..icontext_heroic
					else
						tmp_LR = tmp_LR..slash..colortagL..minLevelH..icontext_heroic
					end
				end
				if (minLevelM) then
					dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevelM)
					colortagL = addon:FormatColor(dungeon_difficulty)
					local slash
					if (minLevelH) then
						slash = L["Slash"]
					else
						slash = ""
					end
					if (minLevelM ~= maxLevelM) then
						tmp_LR = tmp_LR..slash..colortagL..minLevelM.."-"..maxLevelM..icontext_mythic
					else
						tmp_LR = tmp_LR..slash..colortagL..minLevelM..icontext_mythic
					end
				end
				levelString = tmp_LR
			end

			local tooltipTitle, tooltipText
			if (instanceID and EJ_GetInstanceInfo and EJ_GetInstanceInfo(instanceID)) then
				instanceID = tonumber(instanceID)
				EJ_SelectInstance(instanceID)
				tooltipTitle, tooltipText = EJ_GetInstanceInfo()
			end
			if (tooltipTitle and levelString) then
				tooltipTitle = tooltipTitle..levelString
			end

			temp[k] = {
				text = zoneName,
				colorCode = colortag,
				tooltipTitle = tooltipTitle,
				tooltipText = tooltipText,
			}
		end

		local function IsSelected(index) return index == addon.db.profile.options.dropdowns.zone; end
		local function SetSelection(index)
			AtlasFrameDropDown_OnClick(index);
		end

		local function GeneratorFunction(dropdown, rootDescription)
			for key, option in ipairs(temp) do
				local radio = rootDescription:CreateRadio(option.colorCode..option.text, IsSelected, SetSelection, key);
				radio:SetTooltip(function(tooltip, elementDescription)
					GameTooltip_SetTitle(tooltip, option.tooltipTitle);
					GameTooltip_AddNormalLine(tooltip, option.tooltipText);
				end);
			end
		end
		AtlasFrameDropDown:SetupMenu(GeneratorFunction);
		AtlasFrameSmallDropDown:SetupMenu(GeneratorFunction);
	end
end

-- Called whenever an item in the main dropdown menu is clicked
-- Sets the newly selected map as current and refreshes the frame
function AtlasFrameDropDown_OnClick(mapID)
	local profile = addon.db.profile
	local typeID = profile.options.dropdowns.module

	profile.options.dropdowns.zone = mapID
	profile.dropdowns[ATLAS_DROPDOWN_TYPES[typeID]] = mapID
	Atlas_Refresh()
end

function AtlasSwitch_OnSet(index)
	for k, v in pairs(ATLAS_DROPDOWNS) do
		for k2, v2 in pairs(v) do
			if (v2 == index) then
				addon.db.profile.options.dropdowns.module = k
				addon.db.profile.options.dropdowns.zone = k2

				AtlasFrameDropDownType_OnShow()
				AtlasFrameDropDown_OnShow()
				Atlas_Refresh()
				return
			end
		end
	end
end
