
--====================================================================================================================================================
-- TrackingEye-1.0
--
-- A simple addon to add a tracking button to the minimap.
--
-- License: MIT
--====================================================================================================================================================

local TrackingEye = LibStub("AceAddon-3.0"):NewAddon("TrackingEye", "AceConsole-3.0", "AceEvent-3.0")
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Initialise Tracking Eye
--
-- Setups up default profile values, and registers for all events etc.
------------------------------------------------------------------------------------------------------------------------------------------------------
function TrackingEye:OnInitialize()
	self:RegisterChatCommand("te", "MinimapButton_ChatCommand")

	MiniMapTracking:GetScript("OnMouseUp");
	MiniMapTracking:SetScript("OnMouseUp", function( self, button )
		if (button == "RightButton") then
			TrackingEye:TrackingMenu_Open();
		else
			ToggleDropDownMenu(1,nil,MiniMapTrackingDropDown,"cursor")
		end
	end)

	local Minimap_OnMouseUp = Minimap:GetScript("OnMouseUp");
	Minimap:SetScript("OnMouseUp", function( self, button )
		if (button == "RightButton") then
			TrackingEye:TargetMenu_Open()
		else
			Minimap_OnMouseUp(self, button)
		end
	end)
end

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create the Tracking Eye tracking context menu.
--
-- Will check what spells are known and populate the menu with all usable tracking types.
------------------------------------------------------------------------------------------------------------------------------------------------------
function TrackingEye:TrackingMenu_Open()
	local menu =
	{
		{
			text = "Select Tracking", isTitle = true
		}
	}

	-- In level order, with racial/professions last
	local spells =
	{
		1494,	--Track Beasts
		19883,	--Track Humanoids
		19884,	--Track Undead
		19885,	--Track Hidden
		19880,	--Track Elementals
		19878,	--Track Demons
		19882,	--Track Giants
		19879,	--Track Dragonkin
		5225,	--Track Humanoids: Druid
		5500,	--Sense Demons
		5502,	--Sense Undead
		2383,	--Find Herbs
		2580,	--Find Minerals
		2481	--Find Treasure
	}

	for key,spellId in ipairs(spells) do
		spellName = GetSpellInfo(spellId)
		if IsPlayerSpell(spellId) then
			table.insert(menu,
			{
				text = spellName,
				icon = GetSpellTexture(spellId),
				func = function()
					CastSpellByID(spellId)
				end
			})
		end
	end

	table.insert(menu,
	{
		text = "None",
		func = function()
			CancelTrackingBuff()
		end
	})

	local menuFrame = CreateFrame("Frame", "TrackingEyeTrackingMenu", UIParent, "UIDropDownMenuTemplate")
	EasyMenu(menu, menuFrame, "cursor", 0 , 0, "MENU");
end

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create the Tracking Eye target context menu.
--
-- Will search for a context menu and then convert it to a targeting menu.
------------------------------------------------------------------------------------------------------------------------------------------------------
function TrackingEye:TargetMenu_Open()
	if UnitAffectingCombat('player') then
		print("|c00ff0000Tracking eye menu can't be used in combat.")
		return
	end

	local targets = GameTooltipTextLeft1:GetText();

	if (targets == nil or targets == '') then
		return
	end

	local lines = split(targets, "\n")

	local menu =
	{
		{
			text = "Select Target", isTitle = true
		}
	}

	for i, line in ipairs(lines) do
		table.insert(menu,
		{
			attributes =
			{
				type = "macro",
				macrotext = "/target " .. stripColour(line)
			},
			text = line
		})
	end

	-- I have added some custom code to LibUIDropDownMenu that handle an "attributes" entry using secure buttons for macro support.
	local menuFrame = LibDD:Create_UIDropDownMenu("TrackingEyeTargetMenu", UIParent)
	LibDD:EasyMenu(menu, menuFrame, "cursor", 0 , 0, "MENU");
end

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Split the passed string into a table using the passed delimiter to mark the end of each item.
------------------------------------------------------------------------------------------------------------------------------------------------------
function split(str, delimiter)
	local result = {};
	for match in (str..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match);
	end
	return result;
end

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Remove colour markers from a string
------------------------------------------------------------------------------------------------------------------------------------------------------
function stripColour(str)
	stripped, count  = str:gsub("|c[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]", "")
	stripped, count  = stripped:gsub("|r", "")
	return stripped
end
