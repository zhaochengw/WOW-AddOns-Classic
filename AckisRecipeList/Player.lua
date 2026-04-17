--[[
Copyright (c) 2009 - 2012 Ackis <John Pasula>
All rights reserved by the original author Ackis.
]]

-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Libraries
local table = _G.table

-- Functions
local pairs = _G.pairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)

-- ----------------------------------------------------------------------------
-- Data which is stored regarding a players statistics (luadoc copied from Collectinator, needs updating)
-- ----------------------------------------------------------------------------
-- @class table
-- @name Player
-- @field known_filtered Total number of items known filtered during the scan.
-- @field faction Player's faction
-- @field class Player's class
-- @field reputation_levels Listing of players reputation levels
local Player = {}
private.Player = Player

-- ----------------------------------------------------------------------------
-- Constants
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Player methods.
-- ----------------------------------------------------------------------------
function Player:Initialize()
	self.faction = _G.UnitFactionGroup("player")
	self.class = _G.select(2, _G.UnitClass("player"))

	self.scanned_professions = {}
	self.professions = {}

	self:UpdateProfessions()
end

do
	local headers = {}

	function Player:UpdateReputations()
		self.reputation_levels = self.reputation_levels or {}

		table.wipe(headers)

		-- Number of factions before expansion
		local num_factions = _G.GetNumFactions()

		for index = num_factions, 1, -1 do
			-- Expand collapsed headers, storing them so they can be collapsed again when we're finished.
			local name, _, _, _, _, _, _, _, _, isCollapsed = _G.GetFactionInfo(index)
			if isCollapsed then
				_G.ExpandFactionHeader(index)
				headers[name] = true
			end
		end

		-- Number of factions with everything expanded.
		num_factions = _G.GetNumFactions()

		for index = 1, num_factions, 1 do
			local name, _, replevel = _G.GetFactionInfo(index)

			-- If the rep is greater than neutral
			if replevel and replevel > 4 then
				-- We use levels of 0, 1, 2, 3, 4 internally for reputation levels, make it correspond here
				self.reputation_levels[name] = replevel - 4
			end
		end

		-- Re-collapse stored headers.
		for index = num_factions, 1, -1 do
			local name = _G.GetFactionInfo(index)

			if headers[name] then
				_G.CollapseFactionHeader(index)
			end
		end
	end
end -- do-block

function Player:HasProperRepLevel(rep_data)
	if not rep_data then
		return true
	end
	local is_alliance = self.faction == "Alliance"
	local reputation_levels = self.reputation_levels
	local FAC = private.FACTION_IDS_FROM_LABEL
	local has_faction = true

	for rep_id, rep_info in pairs(rep_data) do
		local reputation = private.AcquireTypes.Reputation:GetEntity(rep_id)

		if reputation then
			local rep_name = reputation.name
			for rep_level in pairs(rep_info) do
				if rep_id == FAC.HONOR_HOLD or rep_id == FAC.THRALLMAR then
					rep_id = is_alliance and FAC.HONOR_HOLD or FAC.THRALLMAR
				elseif rep_id == FAC.MAGHAR or rep_id == FAC.KURENAI then
					rep_id = is_alliance and FAC.KURENAI or FAC.MAGHAR
				elseif rep_id == FAC.STORMS_WAKE or rep_id == FAC.ZANDALARI_EMPIRE then
					rep_id = is_alliance and FAC.STORMS_WAKE or FAC.ZANDALARI_EMPIRE
				end

				if not reputation_levels[rep_name] or reputation_levels[rep_name] < rep_level then
					has_faction = false
				else
					has_faction = true
					break
				end
			end
		else
			addon:Debug("Unable to find reputation data for ID %d.", rep_id)
		end
	end
	return has_faction
end

function Player:HasRecipeFaction(recipe)
	local flagged_horde = recipe:HasFilter("common1", "HORDE")
	local flagged_alliance = recipe:HasFilter("common1", "ALLIANCE")

	if self.faction == "Alliance" and flagged_horde and not flagged_alliance then
		return false
	elseif self.faction == "Horde" and flagged_alliance and not flagged_horde then
		return false
	end
	return true
end

do
	-- Sets the player's professions. Used when the AddOn initializes and when a profession has been learned or unlearned.
	-- Also removes saved profession links if the profession is no longer known.
	function Player:UpdateProfessions()
		table.wipe(self.professions)

		for skillIndex = 1, GetNumSkillLines() do
			local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier,
			skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType,
			skillDescription = GetSkillLineInfo(skillIndex)

			local skillNameLower = string.lower(skillName)
			if skillName and not isHeader then
				if isAbandonable or skillNameLower == "cooking" or skillNameLower == "first aid" or skillNameLower == "fishing" then
					self.professions[skillName] = skillRank
				end
			end
		end

		addon.db.global.tradeskill[private.REALM_NAME] = addon.db.global.tradeskill[private.REALM_NAME] or {}
		addon.db.global.tradeskill[private.REALM_NAME][private.PLAYER_NAME] = addon.db.global.tradeskill[private.REALM_NAME][private.PLAYER_NAME] or {}

		local skills_to_purge

		for profession_name, link in pairs(addon.db.global.tradeskill[private.REALM_NAME][private.PLAYER_NAME]) do
			if not self.professions[profession_name] then
				if not skills_to_purge then
					skills_to_purge = {}
				end
				skills_to_purge[profession_name] = true
			end
		end

		if skills_to_purge then
			for profession_name in pairs(skills_to_purge) do
				addon.db.global.tradeskill[private.REALM_NAME][private.PLAYER_NAME][profession_name] = nil
			end
		end
	end
end -- do-block
