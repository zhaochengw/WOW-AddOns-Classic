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

local WoWClassicEra, WoWClassicTBC, WoWRetail
local wowversion = select(4, GetBuildInfo())
if wowversion < 20000 then
	WoWClassicEra = true
elseif wowversion > 19999 and wowversion < 90000 then
	WoWClassicTBC = true
else
	WoWRetail = true
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)

-- Atlas to AtlasLoot's module mapping
local modules = {}
if WoWClassicEra then
	modules = {
		Atlas_ClassicWoW = "AtlasLoot_Classic",
	}
elseif WoWClassicTBC then
	modules = {
		Atlas_ClassicWoW     = "AtlasLoot_Classic",
		Atlas_BurningCrusade = "AtlasLoot_BurningCrusade",
	}
else
	modules = {
		Atlas_ClassicWoW         = "AtlasLoot_Classic",
		Atlas_BurningCrusade     = "AtlasLoot_BurningCrusade",
		Atlas_WrathoftheLichKing = "AtlasLoot_WrathoftheLichKing",
		Atlas_Cataclysm          = "AtlasLoot_Cataclysm",
		Atlas_MistsofPandaria    = "AtlasLoot_MistsofPandaria",
		Atlas_WarlordsofDraenor  = "AtlasLoot_WarlordsofDraenor",
		Atlas_Legion             = "AtlasLoot_Legion",
		Atlas_BattleforAzeroth   = "AtlasLoot_BattleforAzeroth",
		Atlas_Shadowlands        = "AtlasLoot_Shadowlands",
		Atlas_Dragonflight       = "AtlasLoot_Dragonflight",
		Atlas_TheWarWithin       = "AtlasLoot_TheWarWithin",
	}
end

function addon:EnableAtlasLootButton(base, zoneID)
	if (addon:CheckAddonStatus("AtlasLoot")) then
		local showbutton = false;

		if (modules[base.Module] or modules[base.ALModule]) then
			local enabled = C_AddOns.GetAddOnEnableState(modules[base.Module] or modules[base.ALModule], UnitName("player"));
			if (enabled > 0) then
				showbutton = true;
			end
		end
		if (showbutton and base.JournalInstanceID) then
			AtlasFrame.AtlasLoot.data = {
				instanceID = base.JournalInstanceID,
				module = base.Module or base.ALModule,
			};
			AtlasFrameSmall.AtlasLoot.data = {
				instanceID = base.JournalInstanceID,
				module = base.Module or base.ALModule,
			};

			AtlasFrameAtlasLootButton:Show();
			AtlasFrameSmallAtlasLootButton:Show();
		else
			AtlasFrameAtlasLootButton:Hide();
			AtlasFrameSmallAtlasLootButton:Hide();
		end
	end
end

function addon:AtlasLootButton_OnClick(self, button)
	if (not addon:CheckAddonStatus("AtlasLoot")) then return end

	if (button == "RightButton") then
		if (AtlasLoot.GUI.frame:IsVisible()) then
			AtlasLoot.GUI.frame:Hide();
		end
	else
		local db = AtlasLoot.db.GUI;

		local instanceID = self.data.instanceID or nil;
		local ALModule = modules[self.data.module] or nil;
		local encounterID = self.data.encounterID or nil;
		local bossID = self.data.bossID or nil;

		if (not instanceID) then return; end
		if (not ALModule) then return; end

		instanceID = tonumber(instanceID);

		if (not AtlasLoot.GUI.frame:IsVisible()) then
			AtlasLoot.GUI.frame:Show();
		end
		-- Set module
		if (ALModule ~= db.selected[1]) then
			AtlasLoot.GUI.frame.moduleSelect:SetSelected(ALModule); -- this should also force AtlasLoot to load the module data
		end

		local moduleData = AtlasLoot.ItemDB:Get(ALModule);
		local dataID;
		-- to search the right instance
		for k, v in pairs(moduleData) do
			if (type(v) == "table") then
				for ka, va in pairs(v) do
					if (ka == "EncounterJournalID" and va == instanceID) then
						dataID = k;
						break;
					end
				end
			end
			if (dataID) then break; end
		end
		dataID = dataID or db.selected[2];
		-- Set sub-category (instance)
		if (dataID ~= db.selected[2]) then
			AtlasLoot.GUI.frame.subCatSelect:SetSelected(dataID);
		end

		for count = 1, #moduleData[dataID].items do
			if (encounterID and moduleData[dataID].items[count].EncounterJournalID and moduleData[dataID].items[count].EncounterJournalID == encounterID) then
				bossID = count;
				break;
			end
		end

		-- Set boss selection
		if (bossID and bossID ~= db.selected[3]) then
			AtlasLoot.GUI.frame.boss:SetSelected(bossID)
		end

		AtlasLoot.GUI.ItemFrame:Refresh(true);
	end
end
