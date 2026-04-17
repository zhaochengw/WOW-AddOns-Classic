--[[
    Ackis Recipe List - Scanner
    Recipe scanning and datamining functionality
    
    Provides:
    - Profession recipe scanning via tooltip parsing
    - Trainer data scanning for recipe discovery
    - Coroutine-based scanning with progress display
    - Datamining tools for recipe database building
]]

-- ============================================================================
-- Upvalued Lua API
-- ============================================================================
local ipairs, pairs = _G.ipairs, _G.pairs
local pcall = _G.pcall
local tonumber, tostring = _G.tonumber, _G.tostring
local type = _G.type
local select = _G.select

local coroutine = _G.coroutine
local math = _G.math
local table = _G.table
local string = _G.string

-- ============================================================================
-- AddOn Namespace
-- ============================================================================
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local HBD = LibStub("HereBeDragons-2.0")

local LibStub = _G.LibStub

local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

-- ============================================================================
-- Constants
-- ============================================================================
local NO_ROLE_FLAG -- Populated at the end of the file.

-- ============================================================================
-- Recipe Loading
-- ============================================================================
function private.LoadAllRecipes()
	local recipe_list = private.recipe_list

	if addon.db.profile.autoloaddb then
		for identifier, name in pairs(private.LOCALIZED_PROFESSION_NAMES) do
			addon:InitializeProfession(name)
		end
	end
	return recipe_list
end

-- ----------------------------------------------------------------------------
-- Tooltip for data-mining.
-- ----------------------------------------------------------------------------
local ARLDatamineTT = _G.CreateFrame("GameTooltip", "ARLDatamineTT", _G.UIParent, "GameTooltipTemplate")
do
	-- Tables used in addon:ScanTrainerData
	local ExtraSpellIDs = {}
	local IncorrectItemIDs = {}
	local MismatchedRecipeLevels = {}
	local MissingSpellIDs = {}
	local ScannedRecipeIDToItemIDMapping = {}
	local ScannedRecipeIDToSkillLevelMapping = {}

	--- Function to compare which recipes are available from a trainer and compare with the internal ARL database.
	-- @name AckisRecipeList:ScanTrainerData
	-- @param autoscan True when autoscan is enabled in preferences, it will inform you when a scan has occured.
	-- @return Does a comparison of the information in your internal ARL database, and those items which are available on the trainer.
	-- Compares the acquire information of the ARL database with what is available on the trainer.
	function addon:ScanTrainerData(autoscan)
		if not _G.UnitExists("target") or _G.UnitIsPlayer("target") or _G.UnitIsEnemy("player", "target") then
			if not autoscan then
				self:Debug(L["DATAMINER_TRAINER_NOTTARGETTED"])
			end
			return
		end

		if not _G.IsTradeskillTrainer() then
			if not autoscan then
				self:Debug(L["DATAMINER_SKILLLEVEL_ERROR"])
			end
			return
		end

		-- Get the initial values for the trainer filters
		local available = _G.GetTrainerServiceTypeFilter("available") and 1 or 0
		local unavailable = _G.GetTrainerServiceTypeFilter("unavailable") and 1 or 0
		local used = _G.GetTrainerServiceTypeFilter("used") and 1 or 0

		-- Clear the trainer filters
		_G.SetTrainerServiceTypeFilter("available", 1)
		_G.SetTrainerServiceTypeFilter("unavailable", 1)
		_G.SetTrainerServiceTypeFilter("used", 1)

		local trainerServicesCount = _G.GetNumTrainerServices()
		if trainerServicesCount == 0 then
			self:Debug("Warning: Trainer is bugged, reporting 0 trainer items.")
			return
		end

		local trainerProfession = private.LOCALIZED_SPELL_NAME_TO_LOCALIZED_PROFESSION_NAME_MAPPING[_G.GetTrainerServiceSkillLine(1)]
		if not trainerProfession then
			return
		end

		addon:InitializeProfession(trainerProfession)

		local profession = private.Professions[trainerProfession]
		if not profession then
			return
		end

		local professionRecipes = profession.Recipes
		if not professionRecipes then
			self:Debug(L["DATAMINER_NODB_ERROR"])
			return
		end

		table.wipe(ScannedRecipeIDToSkillLevelMapping)

		ARLDatamineTT:SetOwner(_G.WorldFrame, "ANCHOR_NONE")
		_G.GameTooltip_SetDefaultAnchor(ARLDatamineTT, _G.UIParent)

		for index = 1, trainerServicesCount, 1 do
			ARLDatamineTT:SetTrainerService(index)

			local spellName, spellID, spellRank = ARLDatamineTT:GetSpell()
			local itemID = private.ItemLinkToID(_G.GetTrainerServiceItemLink(index))
			local _, skillLevel = _G.GetTrainerServiceSkillReq(index)

			ScannedRecipeIDToSkillLevelMapping[spellID] = skillLevel

			if itemID then
				ScannedRecipeIDToItemIDMapping[spellID] = itemID
			end
		end
		ARLDatamineTT:Hide()

	-- Dump out trainer info
		local mapID, trainer_x, trainer_y = HBD:GetPlayerZone()
		
		local trainerID = private.MobGUIDToIDNum(_G.UnitGUID("target"))
		local trainerName = _G.UnitName("target")
		local trainer_entry = private.AcquireTypes.Trainer:GetEntity(trainerID)
		local trainerzone = mapID and HBD:GetLocalizedMap(mapID) or UNKNOWN

		if trainer_x and trainer_y then
			trainer_x = ("%.2f"):format(trainer_x * 100)
			trainer_y = ("%.2f"):format(trainer_y * 100)
		else
			trainer_x = "0"
			trainer_y = "0"
		end

		local output = private.TextDump
		output:Clear()

		if trainer_entry then
			if trainer_entry.coord_x ~= trainer_x or trainer_entry.coord_y ~= trainer_y then
				output:AddLine(("%s appears to have different coordinates (%s, %s) than those in the database (%s, %s) - a trainer dump for %s will fix this."):format(trainerName, trainer_x, trainer_y, trainer_entry.coord_x, trainer_entry.coord_y, trainerProfession))
				trainer_entry.coord_x = trainer_x
				trainer_entry.coord_y = trainer_y
			end
		else
			L[trainerName] = trainerName

			output:AddLine(("Trainer not in Database."))
			output:AddLine(("AddTrainer(%s, \"%s\", Z.%s, %s, %s, \"%s\")"):format(trainerID,
						trainerName,
						trainerzone,
						trainer_x,
						trainer_y,
						private.Player.faction))
		--	addon:AddTrainer(trainerID, trainerName, trainerzone, trainer_x, trainer_y, private.Player.faction)
		end

		table.wipe(MissingSpellIDs)
		table.wipe(ExtraSpellIDs)
		table.wipe(IncorrectItemIDs)
		table.wipe(MismatchedRecipeLevels)

		for recipeSpellID, recipe in pairs(professionRecipes) do
			local scannedRecipeItemID = ScannedRecipeIDToItemIDMapping[recipeSpellID]
			local scannedRecipeSkillLevel = ScannedRecipeIDToSkillLevelMapping[recipeSpellID]
			local recipeTrainerData = recipe:AcquireDataOfType(private.AcquireTypes.Trainer)
			local recipeMatchesTrainer = recipeTrainerData and recipeTrainerData[trainerID]

			if recipeMatchesTrainer then
				if not scannedRecipeSkillLevel then
					table.insert(ExtraSpellIDs, recipeSpellID)
				end
			elseif scannedRecipeSkillLevel then
				table.insert(MissingSpellIDs, recipeSpellID)

				if not tonumber(trainerName) and not L[trainerName] then
					L[trainerName] = true
				end
				recipe:AddTrainer(trainerID)

				if not recipe:HasFilter("common1", "TRAINER") then
					recipe:AddFilters(private.FILTER_IDS.TRAINER)
					output:AddLine(("    %s -- %d: Added trainer flag."):format(recipe:LocalizedName(), recipeSpellID))
				end
			end

			if scannedRecipeSkillLevel and scannedRecipeSkillLevel ~= recipe:SkillLevels() then
				table.insert(MismatchedRecipeLevels, recipeSpellID)
			end

			if scannedRecipeItemID and scannedRecipeItemID ~= recipe:CraftedItem() then
				recipe:SetCraftedItem(scannedRecipeItemID, "BIND_ON_EQUIP")
				table.insert(IncorrectItemIDs, recipeSpellID)
			end
		end

		if #MissingSpellIDs > 0 then
			output:AddLine("\nTrainer is missing from the following entries:")
			table.sort(MissingSpellIDs)

			for index in ipairs(MissingSpellIDs) do
				local recipeSpellID = MissingSpellIDs[index]
				output:AddLine(("    %s -- %d"):format(professionRecipes[recipeSpellID]:LocalizedName(), recipeSpellID))
			end
		end

		if #ExtraSpellIDs > 0 then
			output:AddLine("\nRecipes which are wrongly assigned to the trainer:")
			table.sort(ExtraSpellIDs)

			for index in ipairs(ExtraSpellIDs) do
				local recipeSpellID = ExtraSpellIDs[index]
				output:AddLine(("    %s -- %s"):format(professionRecipes[recipeSpellID]:LocalizedName(), recipeSpellID))
			end
		end

		if #IncorrectItemIDs > 0 then
			output:AddLine("\nRecipes which were missing or had an incorrect crafted item ID:")
			table.sort(IncorrectItemIDs)

			for index in ipairs(IncorrectItemIDs) do
				local recipeSpellID = IncorrectItemIDs[index]
				output:AddLine(("    %s -- %d"):format(professionRecipes[recipeSpellID]:LocalizedName(), recipeSpellID))
			end
		end

		if #MismatchedRecipeLevels > 0 then
			output:AddLine("\nRecipes which had an incorrect skill level, but will not once a dump is performed:")
			table.sort(MismatchedRecipeLevels)

			for index in ipairs(MismatchedRecipeLevels) do
				local spellID = MismatchedRecipeLevels[index]
				local recipe = professionRecipes[spellID]
				local recipeSkillLevel = recipe:SkillLevels()
				local correctedSkillLevel = ScannedRecipeIDToSkillLevelMapping[spellID]
				output:AddLine(("    %s -- %d:"):format(recipe:LocalizedName(), spellID))
				output:AddLine(("        %d => %d."):format(recipeSkillLevel, correctedSkillLevel))
				recipe:SetSkillLevels(correctedSkillLevel)
			end
		end

		if output:Lines() > 0 then
			output:InsertLine(1, ("ARL Version: %s"):format(self.version))
			output:InsertLine(2, L["DATAMINER_TRAINER_INFO"]:format(trainerName, trainerID))

			if #ExtraSpellIDs > 0 and trainerProfession == private.LOCALIZED_PROFESSION_NAMES.ENGINEERING then
				output:AddLine("\nSome goggles may be listed as extra. These goggles ONLY show up for the classes who can make them, so they may be false positives.")
			end
			output:Display()
		end

		-- Reset the filters to what they were before
		_G.SetTrainerServiceTypeFilter("available", available or 0)
		_G.SetTrainerServiceTypeFilter("unavailable", unavailable or 0)
		_G.SetTrainerServiceTypeFilter("used", used or 0)
	end
end -- do


-- ----------------------------------------------------------------------------
-- Recipe/Profession scanning and dumping routines.
-- ----------------------------------------------------------------------------
do
	local intermediary_recipe_list = {}
	local progressBar

	local PROGRESSBAR_TEXTURES = {
		[[Interface\BlackMarket\BlackMarketBackground-BottomShadow]],
		[[Interface\BUTTONS\GreyScaleRamp64]],
		[[Interface\OPTIONSFRAME\21STEPGRAYSCALE]],
		[[Interface\RAIDFRAME\Raid-Bar-Hp-Fill]],
		[[Interface\Scenarios\Objective-Sheen]],
		[[Interface\TARGETINGFRAME\BarFill2]],
		[[Interface\UnitPowerBarAlt\Generic1_Horizontal_Fill]],
		[[Interface\UnitPowerBarAlt\Generic1_Pill_Fill]],
	}

	local function ProgressBar()
		if not progressBar then
			if _G.BackdropTemplateMixin then
				progressBar = _G.CreateFrame("Frame", "ARL_DatamineProgressBar", _G.UIParent, "BackdropTemplate")
			else
				progressBar = _G.CreateFrame("Frame", "ARL_DatamineProgressBar", _G.UIParent)
			end
			progressBar:SetSize(450, 30)
			progressBar:SetPoint("CENTER", 0, -250)
			progressBar:SetFrameStrata("DIALOG")
			progressBar:SetClampedToScreen(true)
			progressBar:EnableMouse()
			progressBar:SetMovable(true)

			local backdropInfo = {
				bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
				edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
				tile = true,
				tileSize = 16,
				edgeSize = 16,
				insets = {
					left = 4,
					right = 4,
					top = 4,
					bottom = 4
				}
			}
			private.BackdropUtil.SafeSetBackdrop(progressBar, backdropInfo, {0, 0, 0, 1})

			progressBar.fg = progressBar:CreateTexture()
			progressBar.fg:SetPoint("LEFT", progressBar, "LEFT", 5, 0)
			progressBar.fg:SetSize(300, 20)

			progressBar.left_text = progressBar:CreateFontString(nil, "ARTWORK", "GameFontWhiteSmall")
			progressBar.left_text:SetPoint("LEFT", 10, 0)

			progressBar.right_text = progressBar:CreateFontString(nil, "ARTWORK", "GameFontWhiteSmall")
			progressBar.right_text:SetPoint("RIGHT", -10, 0)

			progressBar:SetScript("OnMouseDown", progressBar.StartMoving)
			progressBar:SetScript("OnMouseUp", progressBar.StopMovingOrSizing)

			local function PercentColorGradient(min, max)
				local red_low, green_low, blue_low = 1, 0.10, 0.10
				local red_mid, green_mid, blue_mid = 1, 1, 0
				local red_high, green_high, blue_high = 0.25, 0.75, 0.25
				local percentage = min / max

				if percentage >= 1 then
					return red_high, green_high, blue_high
				elseif percentage <= 0 then
					return red_low, green_low, blue_low
				end

				local integral, fractional = math.modf(percentage * 2)
				if integral == 1 then
					red_low, green_low, blue_low, red_mid, green_mid, blue_mid = red_mid, green_mid, blue_mid, red_high, green_high, blue_high
				end

				return red_low + (red_mid - red_low) * fractional, green_low + (green_mid - green_low) * fractional, blue_low + (blue_mid - blue_low) * fractional
			end

			function progressBar:Update(current, max, spellID)
				current = current or 1
				max = max or 1

				local percentage = math.floor(current / max * 100)

				self.fg:SetVertexColor(PercentColorGradient(current, max), 0.5)
				self.fg:SetWidth(4.4 * percentage)

				if spellID then
					local recipe = private.recipe_list[spellID]

					self.left_text:SetFormattedText("%s (%d)", recipe and recipe:LocalizedName() or _G.UNKNOWN, spellID)
				else
					self.left_text:SetText(_G.UNKNOWN)
				end

				self.right_text:SetFormattedText("%d/%d (%d%%)", current, max, percentage)
			end
		end

		progressBar.fg:SetTexture(PROGRESSBAR_TEXTURES[math.random(1, #PROGRESSBAR_TEXTURES)])
		progressBar.fg:SetWidth(0)

		return progressBar
	end

	-- ============================================================================
	-- COROUTINE-BASED SCANNING
	-- Uses coroutines to yield per-recipe, preventing UI freeze during
	-- long scans. OnUpdate driver resumes the coroutine each frame.
	-- ============================================================================

	local ScannerUpdateFrame = _G.CreateFrame("Frame", nil, copyFrame)

	--- Safely resume a coroutine, catching any errors
	--- @param co thread The coroutine to resume
	--- @param ... any Arguments to pass to the coroutine
	--- @return boolean success True if resume succeeded
	--- @return string|nil error Error message if failed
	local function ResumeCoroutine(co, ...)
		local ok, err = pcall(coroutine.resume, co, ...)
		if not ok then
			return false, err
		end
		return true
	end

	--- Get a human-readable status for a failed coroutine
	--- @param co thread The coroutine to check
	--- @return string Status description
	local function GetCoroutineStatus(co)
		if coroutine.status(co) == "dead" then
			return "coroutine died unexpectedly"
		end
		return "unknown error"
	end

	--- Clean up scanner state after completion or error
	function ScannerUpdateFrame:Cleanup()
		self:SetScript("OnUpdate", nil)
		self.isRunning = nil
		self.profession = nil
		if self.scanner then
			self.scanner = nil
		end
		-- NOTE: Hide UI elements to reset visual state
		if progressBar then
			progressBar:Hide()
		end
		if ARLDatamineTT then
			ARLDatamineTT:Hide()
		end
	end

	--- Handle coroutine errors gracefully
	--- @param err string The error message
	function ScannerUpdateFrame:OnError(err)
		addon:Debug("Scanner coroutine error: %s", tostring(err))
		self:Cleanup()
	end

	--- OnUpdate driver that resumes the coroutine each frame
	--- Each resume processes one recipe, then yields back
	function ScannerUpdateFrame:OnUpdate(elapsed)
		if not self.scanner then
			self:Cleanup()
			return
		end

		local ok, err = ResumeCoroutine(self.scanner)

		if not ok then
			self:OnError(err or GetCoroutineStatus(self.scanner))
			return
		end

		if coroutine.status(self.scanner) == "dead" then
			self:Cleanup()
		end
	end

	local function Sort_AscID(a, b)
		local reca, recb = private.recipe_list[a], private.recipe_list[b]

		return reca:SpellID() < recb:SpellID()
	end

	local function SortRecipesByID()
		local sorted_recipes = addon.sorted_recipes
		table.wipe(sorted_recipes)

		for spellID in pairs(intermediary_recipe_list) do
			table.insert(sorted_recipes, spellID)
		end
		table.sort(sorted_recipes, Sort_AscID)
	end

	-- ----------------------------------------------------------------------------
	-- Scans the items in the specified profession
	-- ----------------------------------------------------------------------------
	local function CoroutineProfessionScan(localizedProfessionName)
		if not localizedProfessionName then
			addon:Debug("CoroutineProfessionScan: No profession name provided")
			return
		end

		local profession = private.Professions[localizedProfessionName]
		if not profession or not profession.Recipes then
			addon:Debug("CoroutineProfessionScan: Profession '%s' not found or has no recipes", tostring(localizedProfessionName))
			return
		end

		ScannerUpdateFrame.profession = localizedProfessionName
		table.wipe(intermediary_recipe_list)

		for recipeSpellID, recipe in pairs(profession.Recipes) do
			intermediary_recipe_list[recipeSpellID] = recipe
		end

		local output = private.TextDump
		output:Clear()

		SortRecipesByID()

		local num_recipes = #addon.sorted_recipes
		if num_recipes == 0 then
			addon:Debug("CoroutineProfessionScan: No recipes to scan")
			return
		end

		local progress_bar = ProgressBar()
		progress_bar:Show()

		for index, spellID in ipairs(addon.sorted_recipes) do
			progress_bar:Update(index, num_recipes, spellID)
			addon:ScanTooltipRecipe(spellID, false, true)
			coroutine.yield()
		end

		if output:Lines() == 0 then
			addon:Debug("ProfessionScan(): output is empty.")
		end
		progress_bar:Hide()
		output:Display()
		ARLDatamineTT:Hide()
	end

	local function ProfessionScan(profession_name)
		if ScannerUpdateFrame.isRunning then
			addon:Debug("ProfessionScan: Scanner already running")
			return
		end

		if not profession_name then
			addon:Debug("ProfessionScan: No profession name provided")
			return
		end

		local ok, co = pcall(coroutine.create, CoroutineProfessionScan)
		if not ok then
			addon:Debug("ProfessionScan: Failed to create coroutine - %s", tostring(co))
			return
		end

		ScannerUpdateFrame.scanner = co
		ScannerUpdateFrame:SetScript("OnUpdate", ScannerUpdateFrame.OnUpdate)
		ScannerUpdateFrame.isRunning = true

		local success, err = ResumeCoroutine(ScannerUpdateFrame.scanner, profession_name)
		if not success then
			addon:Debug("ProfessionScan: Failed to start coroutine - %s", tostring(err))
			ScannerUpdateFrame:Cleanup()
		end
	end

	local function ScheduleProfessionScan(profession_name)
		if ScannerUpdateFrame.profession then
			addon:Debug("Already scanning %s - wait until finished.", ScannerUpdateFrame.profession)
			return
		end

		if addon:InitializeProfession(profession_name) then
			addon:ScheduleTimer(ProfessionScan, 2, profession_name)
			addon:Debug("%s had to be loaded - starting scan in 2 seconds to ensure everything is in the cache.", profession_name)
		else
			ProfessionScan(profession_name)
		end
	end

	--- Parses all recipes for a specified profession, scanning their tool tips.
	-- @name AckisRecipeList:ScanProfession
	-- @usage AckisRecipeList:ScanProfession("first aid")
	-- @param prof_name The profession name or the spell ID of it, which you wish to scan.
	-- @return Recipes in the given profession have their tooltips scanned.
	function addon:ScanProfession(input_text)
		if type(input_text) == "number" then
			input_text = _G.GetSpellInfo(input_text)
		end
		input_text = input_text:lower()

		if input_text == "all" then
			for index, professionName in ipairs(private.ORDERED_LOCALIZED_PROFESSION_NAMES) do
				ScheduleProfessionScan(professionName)
			end
			return
		end

		for index, professionName in ipairs(private.ORDERED_LOCALIZED_PROFESSION_NAMES) do
			if input_text == professionName:lower() then
				ScheduleProfessionScan(professionName)
				return
			end
		end
		self:Debug(L["DATAMINER_NODB_ERROR"])
	end




end -- do

local RECIPE_TYPES = {
	-- JC
	["design: "] = true,
	-- LW or Tailoring
	["pattern: "] = true,
	-- Alchemy or Cooking
	["recipe: "] = true,
	-- BS
	["plans: "] = true,
	-- Enchanting
	["formula: "] = true,
	-- Engineering
	["schematic: "] = true,
	-- Inscription
	["technique: "] = true,
	["alchemy: "] = true,
	["blacksmithing: "] = true,
	["cooking: "] = true,
	["enchanting: "] = true,
	["engineering: "] = true,
	["inscription: "] = true,
	["jewelcrafting: "] = true,
	["leatherworking: "] = true,
	["tailoring: "] = true,
}

--- Scans the items on a vendor, determining which recipes are available if any and compares it with the database entries
-- @name AckisRecipeList:ScanVendor
-- @usage AckisRecipeList:ScanVendor()
-- @return Obtains all the vendor information on tradeskill recipes and attempts to compare the current vendor with the internal database
do
	local output = private.TextDump
	local RECIPE_ITEM_TO_SPELL_MAP

	local function NormalizeVendorData(recipeSpellID, supply, vendorID, vendorName)
		local recipe = private.recipe_list[recipeSpellID]
		local vendorAcquireType = private.AcquireTypes.Vendor
		local sourceExistsInData = false

		local vendorData = recipe:AcquireDataOfType(vendorAcquireType)
		if vendorData then
			for sourceID in pairs(vendorData) do
				if sourceID == vendorID then
					sourceExistsInData = true
					break
				end
			end
		else
			local reputationData = recipe:AcquireDataOfType(private.AcquireTypes.Reputation)
			if reputationData then
				for id_num, info in pairs(reputationData) do
					if sourceExistsInData then
						break
					end

					for reputationLevel, dataForLevel in pairs(info) do
						if sourceExistsInData then
							break
						end

						for rep_vendor_id in pairs(dataForLevel) do
							if rep_vendor_id == vendorID then
								sourceExistsInData = true
								break
							end
						end
					end
				end
			end
		end

	local vendor = vendorAcquireType:GetEntity(vendorID)

		local mapID, vendorcoords_x, vendorcoords_y = HBD:GetPlayerZone()
		local vendorZone = mapID and HBD:GetLocalizedMap(mapID) or UNKNOWN

		if mapID == 582 or mapID == 590 then
			return
		elseif vendorcoords_x and vendorcoords_y then
			vendorX = ("%.2f"):format(vendorcoords_x * 100)
			vendorY = ("%.2f"):format(vendorcoords_y * 100)
		else
			vendorX = "0"
			vendorY = "0"
		end


		if vendor then
			if vendor.coord_x ~= vendorX or vendor.coord_y ~= vendorY then
				output:AddLine(("%s appears to have different coordinates (%s, %s) than those in the database (%s, %s)."):format(vendorName, vendor.coord_x, vendor.coord_y, vendorX, vendorY))
				vendor.coord_x = vendorX
				vendor.coord_y = vendorY
			end
		else
			output:AddLine(("%s was not found in the vendor list"):format(vendorName))

			if not L[vendorName] then
				L[vendorName] = true
			end
			output:AddLine(("AddVendor(%s, [\"%s\"], Z.%s, %s, %s, \"%s\")"):format(vendorID,
						vendorName,
						vendorZone,
						vendorX,
						vendorY,
						private.Player.faction))

			vendorAcquireType:AddEntity(addon, {
				coord_x = vendorX,
				coord_y = vendorY,
				faction = _G.UnitFactionGroup("target") or "Neutral",
				identifier = vendorID,
				Location = private.LocationsByLocalizedName[vendorZone],
				name = L[vendorName],
			})
		end

		if sourceExistsInData and vendor and vendor.item_list then
			local recordedSupply = vendor.item_list[recipeSpellID]

			if recordedSupply == true and supply > -1 then
				recipe:AddLimitedVendor(vendorID, supply)
				output:AddLine(("Limited quantity for \"%s\" (%d) found on vendor %d - listed as unlimited quantity."):format(recipe:LocalizedName(), recipeSpellID, vendorID))
			elseif type(recordedSupply) ~= "boolean" and supply == -1 then
				recipe:AddVendor(vendorID)
				output:AddLine(("Unlimited quantity for \"%s\" (%d) found on vendor %d - listed as limited quantity."):format(recipe:LocalizedName(), recipeSpellID, vendorID))
			end

			if not recipe:HasFilter("common1", "VENDOR") and not recipe:HasFilter("common1", "WORLD_EVENT") then
				recipe:AddFilters(private.FILTER_IDS.VENDOR)
				output:AddLine(("%d: Vendor flag was not set."):format(recipeSpellID))
			end
		elseif not sourceExistsInData then
			if supply > -1 then
				recipe:AddLimitedVendor(vendorID, supply)
			else
				recipe:AddVendor(vendorID)
			end

			if not recipe:HasFilter("common1", "VENDOR") and not recipe:HasFilter("common1", "WORLD_EVENT") then
				recipe:AddFilters(private.FILTER_IDS.VENDOR)
				output:AddLine(("%d: Vendor flag was not set."):format(recipeSpellID))
			end
			output:AddLine(("Vendor ID missing from \"%s\" %d."):format(recipe and recipe:LocalizedName() or _G.UNKNOWN, recipeSpellID))
		end
	end

	function addon:ScanVendor()
		if not _G.UnitExists("target") or _G.UnitIsPlayer("target") or _G.UnitIsEnemy("player", "target") then
			self:Debug(L["DATAMINER_VENDOR_NOTTARGETTED"])
			return
		end
		local recipe_list = private.LoadAllRecipes() -- Get internal database

		if not recipe_list then
			self:Debug(L["DATAMINER_NODB_ERROR"])
			return
		end
		local vendor_name = _G.UnitName("target")
		local vendor_id = private.MobGUIDToIDNum(_G.UnitGUID("target"))

		if not RECIPE_ITEM_TO_SPELL_MAP then
			RECIPE_ITEM_TO_SPELL_MAP = {}

			for spell_id, recipe in pairs(private.recipe_list) do
				local recipe_item_id = recipe:RecipeItem()

				if recipe_item_id then
					RECIPE_ITEM_TO_SPELL_MAP[recipe_item_id] = spell_id
				end
			end
		end
		output:Clear()

		for index = 1, _G.GetMerchantNumItems(), 1 do
			local item_name, _, _, _, supply = _G.GetMerchantItemInfo(index)

			if item_name then
				local match_text = item_name:match("%a+: ")

				if match_text and RECIPE_TYPES[match_text:lower()] then
					local item_id = private.ItemLinkToID(_G.GetMerchantItemLink(index))
					local spell_id = RECIPE_ITEM_TO_SPELL_MAP[item_id]

					if spell_id then
						addon:ScanTooltipRecipe(spell_id, true, true)
						NormalizeVendorData(spell_id, supply, vendor_id, vendor_name)
					else
						for spell_id, recipe in pairs(private.recipe_list) do
							local recipe_type, match_text = (":"):split(item_name, 2)

							if recipe:LocalizedName() == match_text:trim() then
								recipe:SetRecipeItem(item_id, "BIND_ON_EQUIP")
								RECIPE_ITEM_TO_SPELL_MAP[item_id] = spell_id
								NormalizeVendorData(spell_id, supply, vendor_id, vendor_name)
							end
						end
					end
				end
			end
		end

		if output:Lines() > 0 then
			output:InsertLine(1, ("ARL Version: %s"):format(self.version))
			output:InsertLine(2, L["DATAMINER_VENDOR_INFO"]:format(vendor_name, vendor_id))
			output:Display()
		end
		ARLDatamineTT:Hide()
	end
end -- do

--- Parses all the recipes in the database, and scanning their tooltips.
-- @name AckisRecipeList:TooltipScanDatabase
-- @usage AckisRecipeList:TooltipScanDatabase()
-- @return Entire recipe database has its tooltips scanned.
function addon:TooltipScanDatabase()
	local recipe_list = private.LoadAllRecipes()

	if not recipe_list then
		self:Debug(L["DATAMINER_NODB_ERROR"])
		return
	end
	local output = private.TextDump
	output:Clear()

	for i in pairs(recipe_list) do
		addon:ScanTooltipRecipe(i, false, true)
	end
	output:Display()
end

-- Table to store scanned information. Wiped and re-used every scan.
local scan_data = {}

do
	-- ------------------------------------------------------------------------------------------------------
	-- This table, DO_NOT_SCAN, contains itemid's that will not cache on the servers
	-- ------------------------------------------------------------------------------------------------------

	local DO_NOT_SCAN = {
		-- ----------------------------------------------------------------------------
		-- Leatherworking
		-- ----------------------------------------------------------------------------
		[35214]	=	true,	[32434]	=	true,	[15769]	=	true,	[32431]	=	true,	[32432]	=	true,
		[35215]	=	true,	[35521]	=	true,	[35520]	=	true,	[35524]	=	true,	[35517]	=	true,
		[35528]	=	true,	[35527]	=	true,	[35523]	=	true,	[35549]	=	true,	[35218]	=	true,
		[35217]	=	true,	[35216]	=	true,	[35546]	=	true,	[35541]	=	true,	[15756]	=	true,
		[15777]	=	true,	[32433]	=	true,	[29729]	=	true,	[29732]	=	true,	[32744]	=	true,
		[15773]	=	true,	[30301]	=	true,	[15745]	=	true,	[35302]	=	true,	[15774]	=	true,

		-- ----------------------------------------------------------------------------
		-- Tailoring
		-- ----------------------------------------------------------------------------
		[14477]	=	true,	[14485]	=	true,	[30281]	=	true,	[14478]	=	true,	[14500]	=	true,
		[32439]	=	true,	[14479]	=	true,	[32447]	=	true,	[14480]	=	true,	[32437]	=	true,
		[14495]	=	true,	[14505]	=	true,	[35204]	=	true,	[35205]	=	true,	[35206]	=	true,
		[14473]	=	true,	[14488]	=	true,	[14481]	=	true,	[35309]	=	true,	[30280]	=	true,
		[14492]	=	true,	[14491]	=	true,

		-- ----------------------------------------------------------------------------
		-- Jewelcrafting
		-- ----------------------------------------------------------------------------
		[23130]	=	true,	[23140]	=	true,	[23137]	=	true,	[23131]	=	true,	[23148]	=	true,
		[35538]	=	true,	[35201]	=	true,	[35533]	=	true,	[35200]	=	true,	[23147]	=	true,
		[23135]	=	true,	[35203]	=	true,	[35198]	=	true,	[23152]	=	true,	[23151]	=	true,
		[23141]	=	true,	[28596]	=	true,	[28291]	=	true,	[23153]	=	true,

		-- ----------------------------------------------------------------------------
		-- Alchemy
		-- ----------------------------------------------------------------------------
		[22925]	=	true,	[13480]	=	true,	[13481]	=	true,	[13493]	=	true,	[35295]	=	true,
		[44568]	=	true,

		-- ----------------------------------------------------------------------------
		-- Cooking
		-- ----------------------------------------------------------------------------
		[39644]	=	true,

		-- ----------------------------------------------------------------------------
		-- Blacksmithing
		-- ----------------------------------------------------------------------------
		[32441]	=	true,	[32443]	=	true,	[12687]	=	true,	[12714]	=	true,	[12688]	=	true,
		[35211]	=	true,	[35209]	=	true,	[35210]	=	true,	[12706]	=	true,	[7982]	=	true,
		[12718]	=	true,	[23621]	=	true,	[35208]	=	true,	[12716]	=	true,	[23632]	=	true,
		[23633]	=	true,	[30324]	=	true,	[23637]	=	true,	[31393]	=	true,	[22221]	=	true,
		[12690]	=	true,	[31394]	=	true,	[31395]	=	true,	[23630]	=	true,	[23629]	=	true,
		[7978]	=	true,	[41120]	=	true,	[12717]	=	true,	[22219]	=	true,	[23627]	=	true,

		-- ----------------------------------------------------------------------------
		-- Engineering
		-- ----------------------------------------------------------------------------
		[35196]	=	true,	[21734]	=	true,	[18292]	=	true,	[21727]	=	true,	[21735]	=	true,
		[16053]	=	true,	[21729]	=	true,	[16047]	=	true,	[21730]	=	true,	[21731]	=	true,
		[21732]	=	true,	[4411]	=	true,	[21733]	=	true,	[21728]	=	true,	[35186]	=	true,
		[18655]	=	true,

		-- ----------------------------------------------------------------------------
		-- Enchanting
		-- ----------------------------------------------------------------------------
		[16222]	=	true,	[20734]	=	true,	[20729]	=	true,	[20731]	=	true,	[16246]	=	true,
	}

	local output = private.TextDump

-- ----------------------------------------------------------------------------
-- Tooltip-scanning code
-- ----------------------------------------------------------------------------
	local SPECIALTY_TEXT = {
		["requires gnomish engineer"] = 20219,
		["requires goblin engineer"] = 20222,
	}

	local FACTION_TEXT = {
		["thorium brotherhood"] = 98,
		["zandalar tribe"] = 100,
		["argent dawn"] = 96,
		["timbermaw hold"] = 99,
		["cenarion circle"] = 97,
		["the aldor"] = 101,
		["the consortium"] = 105,
		["the scryers"] = 110,
		["the sha'tar"] = 111,
		["the mag'har"] = 108,
		["cenarion expedition"] = 103,
		["honor hold"] = 104,
		["thrallmar"] = 104,
		["the violet eye"] = 114,
		["sporeggar"] = 113,
		["kurenai"] = 108,
		["keepers of time"] = 106,
		["the scale of the sands"] = 109,
		["lower city"] = 107,
		["ashtongue deathsworn"] = 102,
		["alliance vanguard"] = 131,
		["valiance expedition"] = 126,
		["horde expedition"] = 130,
		["the taunka"] = 128,
		["the hand of vengeance"] = 127,
		["explorers' league"] = 125,
		["the kalu'ak"] = 120,
		["shattered sun offensive"] = 112,
		["warsong offensive"] = 129,
		["kirin tor"] = 118,
		["the wyrmrest accord"] = 122,
		["knights of the ebon blade"] = 117,
		["frenzyheart tribe"] = 116,
		["the oracles"] = 121,
		["argent crusade"] = 115,
		["the sons of hodir"] = 119,
	}

	local FACTION_LEVELS = {
		neutral = 0,
		friendly = 1,
		honored = 2,
		revered = 3,
		exalted = 4,
	}

	local CLASS_TYPES = {
		["Death Knight"] = "DK",
		["Druid"] = "DRUID",
		["Hunter"] = "HUNTER",
		["Mage"] = "MAGE",
		["Paladin"] = "PALADIN",
		["Priest"] = "PRIEST",
		["Shaman"] = "SHAMAN",
		["Rogue"] = "ROGUE",
		["Warlock"] = "WARLOCK",
		["Warrior"] = "WARRIOR",
		["Monk"] = "MONK",
		["Demon Hunter"] = "DEMONHUNTER",
	}

	local ORDERED_CLASS_TYPES = {
		"Death Knight",
		"Druid",
		"Hunter",
		"Mage",
		"Paladin",
		"Priest",
		"Shaman",
		"Rogue",
		"Warlock",
		"Warrior",
		"Monk",
		"Demon Hunter"
	}


	local ROLE_FILTERS = {
		dps = private.FILTER_IDS.DPS,
		tank = private.FILTER_IDS.TANK,
		healer = private.FILTER_IDS.HEALER,
		caster = private.FILTER_IDS.CASTER
	}

	local ROLE_TYPES = {
		dps = "DPS",
		tank = "TANK",
		healer = "HEALER",
		caster = "CASTER",
	}


	local ORDERED_ROLE_TYPES = {
		"dps",
		"tank",
		"healer",
		"caster",
	}


	local ROLE_STAT_MATCHES = {
		["agility"] = {
			"dps",
		},
		["armor"] = {
			"tank",
		},
		["attack power"] = {
			"dps",
		},
		["block rating"] = {
			"tank",
		},
		["critical strike"] = {
			"caster",
			"dps",
			"healer",
		},
		["critical strike rating"] = {
			"caster",
			"dps",
			"healer",
		},
		["dodge"] = {
			"tank",
		},
		["dodge rating"] = {
			"tank",
		},
		["expertise"] = {
			"dps",
			"tank",
		},
		["expertise rating"] = {
			"dps",
			"tank",
		},
		["haste"] = {
			"caster",
			"dps",
			"healer",
		},
		["haste rating"] = {
			"caster",
			"dps",
			"healer",
		},
		["hit"] = {
			"caster",
			"dps",
		},
		["hit rating"] = {
			"caster",
			"dps",
		},
		["intellect"] = {
			"caster",
			"healer",
		},
		["mana"] = {
			"caster",
			"healer",
		},
		["mana every 5 seconds"] = {
			"caster",
			"healer",
		},
		["parry"] = {
			"tank",
		},
		["parry rating"] = {
			"tank",
		},
		["pvp power"] = {
			"pvp",
		},
		["pvp resilience"] = {
			"pvp",
		},
		["rage"] = {
			"dps",
			"tank",
		},
		["spell penetration"] = {
			"caster",
		},
		["spell power"] = {
			"caster",
			"healer",
		},
		["spirit"] = {
			"caster",
			"healer",
		},
		["strength"] = {
			"dps",
		},
		["threat from all attacks and spells"] = {
			"tank",
		},
	}

	local ROLE_STAT_MATCH_FORMATS = {
		"use: permanently attach (%%a+) %s by",
		"adds (%%d+) %s",
		"become well fed and gain (.+) %s",
		"+(%%d+) %s",
		"%s by (%%d+)",
		"%s is increased by (%%d+)",
		"equip: increases your %s by (%%d+)",
		"to increase %s by (%%d+)",
		"increase your %s",
		"increasing %s",
		"grant you (%%d+) %s",
		"generates (%%d+) to (%%d+) %s",
		"restores (%%d+) %s",
		"gain (%%d+) %s",
		"gain (%%d+) (%%a+) and %s",
	}

	local INSCRIPTION_MATCH_FILTERS = {
		["Major Glyph"] = "INSCRIPTION_MAJOR_GLYPH",
		["Minor Glyph"] = "INSCRIPTION_MINOR_GLYPH",
		["Scroll of (.+)"] = "INSCRIPTION_SCROLL",
		["Ink of(.+)"] = "INSCRIPTION_MATERIALS",
		["(.+) Ink"] = "INSCRIPTION_MATERIALS",
		["Permanently add(.+)"] = "INSCRIPTION_ITEM_ENHANCEMENT",
		["Held In Off-hand"] = "INSCRIPTION_OFF_HAND",
	}

	local FilterStrings = private.FILTER_STRINGS
    local AcquireTypes = private.AcquireTypes

	-- Flag data for printing. Wiped and re-used.
	local missing_flags = {}
	local extra_flags = {}
	local general_issues = {}

	local ACQUIRE_TO_FILTER_MAP = {
		[AcquireTypes.MobDrop] = private.FILTER_IDS.MOB_DROP,
		[AcquireTypes.Quest] = private.FILTER_IDS.QUEST,
		[AcquireTypes.WorldEvent] = private.FILTER_IDS.WORLD_EVENT,
		[AcquireTypes.WorldDrop] = private.FILTER_IDS.WORLD_DROP,
    }

	local OBTAIN_FILTERS = {
        	ACHIEVEMENT = true,
        	CUSTOM = true,
        	DISC = true,
        	INSTANCE = true,
		MOB_DROP = true,
		PVP = true,
		QUEST = true,
		RAID = true,
		REPUTATION = true,
		TRAINER = true,
        	VENDOR = true,
        	WORLD_DROP = true,
        	WORLD_EVENT = true,
   	 }

	-- Prints out the results of the tooltip scan.
	local function ProcessScanData()
		local recipe = scan_data.recipe
		if not recipe then
			output:AddLine("No scan_data.recipe")
			return
		end

		local flag_format = "F.%s"
		local firstLineNumber = output:Lines()

		table.wipe(missing_flags)
		table.wipe(extra_flags)
		table.wipe(general_issues)

		-- ----------------------------------------------------------------------------
		-- Things which will be automatically fixed. (Requires a profession dump)
		-- ----------------------------------------------------------------------------
		-- If we're a vendor scan,  do some extra checks
		if scan_data.is_vendor then
			if not recipe:HasFilter("common1", "VENDOR") and not recipe:HasFilter("common1", "WORLD_EVENT") then
				recipe:AddFilters(private.FILTER_IDS.VENDOR)
				table.insert(missing_flags, flag_format:format(FilterStrings[private.FILTER_IDS.VENDOR]))
			end
			local subzone_text = _G.GetSubZoneText()

			if (subzone_text == "Wintergrasp Fortress" or subzone_text == "Halaa") and not recipe:HasFilter("common1", "PVP") then
				table.insert(missing_flags, flag_format:format(FilterStrings[private.FILTER_IDS.PVP]))
			elseif recipe:HasFilter("common1", "PVP") and not (subzone_text == "Wintergrasp Fortress" or subzone_text == "Halaa") then
				table.insert(extra_flags, flag_format:format(FilterStrings[private.FILTER_IDS.PVP]))
			end
		end

		if scan_data.found_class then
			for index, class_name in ipairs(ORDERED_CLASS_TYPES) do
				if scan_data[class_name] and not recipe:HasFilter("class1", CLASS_TYPES[class_name]) then
					recipe:AddFilters(private.FILTER_IDS[CLASS_TYPES[class_name]])
					table.insert(missing_flags, flag_format:format(CLASS_TYPES[class_name]))
				elseif not scan_data[class_name] and recipe:HasFilter("class1", CLASS_TYPES[class_name]) then
					table.insert(extra_flags, flag_format:format(CLASS_TYPES[class_name]))
				end
			end
		end

		for role_index, role in ipairs(ORDERED_ROLE_TYPES) do
			local role_string = ROLE_TYPES[role]

			if scan_data[role] and not recipe:HasFilter("common1", role_string) then
				recipe:AddFilters(ROLE_FILTERS[role])
				table.insert(missing_flags, flag_format:format(role_string))
			elseif not scan_data[role] and recipe:HasFilter("common1", role_string) then
				recipe:RemoveFilters(ROLE_FILTERS[role])
				table.insert(extra_flags, flag_format:format(role_string))
			end
		end

		local repid = scan_data.repid
		if repid then
			if not recipe:HasFilter("reputation1", FilterStrings[repid]) and not recipe:HasFilter("reputation2", FilterStrings[repid]) then
				table.insert(missing_flags, repid)
			end

			local reputationAcquireData = recipe:AcquireDataOfType(private.AcquireTypes.Reputation)
			if reputationAcquireData then
				for sourceID, sourceData in pairs(reputationAcquireData) do
					for level, levelData in pairs(sourceData) do
						if level ~= scan_data.repidlevel then
							output:AddLine("    Wrong reputation level.")
						end
					end
				end
			end
		end

		-- Make sure the recipe's filter flags match with its acquire types.
		for acquireType, flag in pairs(ACQUIRE_TO_FILTER_MAP) do
            local acquireData = recipe:AcquireDataOfType(acquireType)
            local hasFilter = recipe:HasFilter("common1", FilterStrings[flag])
			if acquireData and not hasFilter then
				local canAdd = true
				if (acquireType == AcquireTypes.WorldDrop or acquireType == AcquireTypes.MobDrop) and (recipe:HasFilter("common1", "INSTANCE") or recipe:HasFilter("common1", "RAID")) then
					canAdd = false
				end

				if canAdd then
					recipe:AddFilters(flag)
					table.insert(missing_flags, flag_format:format(FilterStrings[flag]))
				end
			elseif not acquireData and hasFilter then
				local canRemove = true
				if acquireType == AcquireTypes.WorldDrop and (not recipe:HasFilter("common1", "INSTANCE") and not recipe:HasFilter("common1", "RAID")) then
					canRemove = false
				end

				if canRemove then
					recipe:RemoveFilters(flag)
					table.insert(extra_flags, flag_format:format(FilterStrings[flag]))
				end
			end
		end

        local vendorAcquireData = recipe:AcquireDataOfType(AcquireTypes.Vendor)
        local reputationAcquireData = recipe:AcquireDataOfType(AcquireTypes.Reputation)

		if vendorAcquireData then
			if not recipe:HasFilter("common1", "VENDOR") and not recipe:HasFilter("common1", "WORLD_EVENT") and not recipe:HasFilter("common1", "REPUTATION") then
				recipe:AddFilters(private.FILTER_IDS.VENDOR)
				table.insert(missing_flags, flag_format:format(FilterStrings[private.FILTER_IDS.VENDOR]))
			end
		end

		if reputationAcquireData then
			if not recipe:HasFilter("common1", "REPUTATION") then
				recipe:AddFilters(private.FILTER_IDS.REPUTATION)
				table.insert(missing_flags, FilterStrings[private.FILTER_IDS.REPUTATION])
			end
		end

		if recipe:HasFilter("common1", "VENDOR") and not (vendorAcquireData or reputationAcquireData) then
			recipe:RemoveFilters(private.FILTER_IDS.VENDOR)
			table.insert(extra_flags, flag_format:format(FilterStrings[private.FILTER_IDS.VENDOR]))
		end

        local trainerAcquireData = recipe:AcquireDataOfType(AcquireTypes.Trainer)
		if trainerAcquireData and not recipe:HasFilter("common1", "TRAINER") then
			recipe:AddFilters(private.FILTER_IDS.TRAINER)
			table.insert(missing_flags, flag_format:format(FilterStrings[private.FILTER_IDS.TRAINER]))
		end

		if recipe:HasFilter("common1", "TRAINER") and not trainerAcquireData and not recipe:AcquireDataOfType(AcquireTypes.Custom) then
			recipe:RemoveFilters(private.FILTER_IDS.TRAINER)
			table.insert(extra_flags, flag_format:format(FilterStrings[private.FILTER_IDS.TRAINER]))
		end

		if scan_data.quality and scan_data.quality ~= recipe:QualityID() then
			local QS = private.ITEM_QUALITY_NAMES
			table.insert(general_issues, ("    Wrong quality: Q.%s - should be Q.%s."):format(QS[recipe:QualityID()], QS[scan_data.quality]))
			recipe:SetQualityID(scan_data.quality)
		end

		-- ----------------------------------------------------------------------------
		-- Things which will only be warned about.
		-- ----------------------------------------------------------------------------
		if not recipe:ItemFilterType() then
			output:AddLine("    Missing item filter type.")
		end

		-- Check to see if we have a horde/alliance flag,  all recipes must have one of these
		if not recipe:HasFilter("common1", "ALLIANCE") and not recipe:HasFilter("common1", "HORDE") then
			output:AddLine("    Horde or Alliance not selected.")
		end

		-- Check to see if we have an obtain method flag,  all recipes must have at least one of these
		if not recipe:HasFilter("common1", "RETIRED") then
			local matching_filter = false

			for filter in pairs(OBTAIN_FILTERS) do
				if recipe:HasFilter("common1", filter) then
					matching_filter = true
					break
				end
			end

			if not matching_filter then
				output:AddLine("    No obtain flag.")
			end
		end

		-- Check for player role flags
		local spellID = recipe:SpellID()
		if not scan_data.no_role and not scan_data.tank and not scan_data.healer and not scan_data.caster and not scan_data.dps and not NO_ROLE_FLAG[spellID] then
			output:AddLine("    No player role flag.")
		end

		if scan_data.specialty then
			if not recipe.specialty then
				output:AddLine(("    Missing Specialty: %s"):format(scan_data.specialty))
			elseif recipe.specialty ~= scan_data.specialty then
				output:AddLine(("    Wrong Specialty: %s - should be %s "):format(recipe.specialty,scan_data.specialty))
			end
		elseif recipe.specialty then
			output:AddLine(("    Extra Specialty: %s"):format(recipe.specialty))
		end

		if scan_data.filter_type then
			local recipe_filter = recipe:ItemFilterType()

			if recipe_filter then
				recipe_filter = recipe_filter:upper()
			end

			if recipe_filter ~= scan_data.filter_type then
				table.insert(missing_flags, ("    Wrong filter type: %s - should be %s."):format(recipe_filter or "NONE", scan_data.filter_type))
				recipe:SetItemFilterType(scan_data.filter_type)
				scan_data.filter_type = nil
			end
		end

		if #missing_flags > 0 or #extra_flags > 0 or #general_issues > 0 then
			output:AddLine("    Issues which will be resolved with a profession dump:")

			if #missing_flags > 0 then
				output:AddLine("        Missing flags: " .. table.concat(missing_flags, ", "))
			end

			if #extra_flags > 0 then
				output:AddLine("        Extra flags: " .. table.concat(extra_flags, ", "))
			end

			if #general_issues > 0 then
				output:AddLine("        General issues: " .. table.concat(general_issues, ", "))
			end
		end

		if output:Lines() > firstLineNumber then
			output:InsertLine(firstLineNumber + 1, ("\n%s: <a href=\"http://www.wowhead.com/?spell=%d\">%d</a>"):format(recipe:LocalizedName(), spellID, spellID))
		end
	end

	-- Parses the mining tooltip for certain keywords, comparing them with the database flags
	local function ScanTooltip()
		local recipe = scan_data.recipe
		if not recipe then
			return
		end

		-- Parse all the lines of the tooltip
		for i = 1, ARLDatamineTT:NumLines(), 1 do
			local text_l = _G["ARLDatamineTTTextLeft" .. i]:GetText()
			local text_r = _G["ARLDatamineTTTextRight" .. i]:GetText()
			local text = (text_r and ("%s %s"):format(text_l, text_r) or text_l):lower()

			-- Check for recipe/item binding
			-- The recipe binding is within the first few lines of the tooltip always
			if text:match("binds when picked up") then
				if (i < 3) then
					scan_data.recipe_bop = true
				else
					scan_data.item_bop = true
				end
			end

			-- Recipe Specialities
			if SPECIALTY_TEXT[text] then
				scan_data.specialty = SPECIALTY_TEXT[text]
			end

			-- Recipe Reputations
			local rep, replevel = text_l:match("Requires (.+) %- (.+)")
			if rep and replevel and FACTION_TEXT[rep] then
				scan_data.repid = FACTION_TEXT[rep]
				scan_data.repidlevel = FACTION_LEVELS[replevel]
			end


			-- ----------------------------------------------------------------------------
			-- Do things the smart way and assign the filter type here. Uncomment when needed.
			-- ----------------------------------------------------------------------------
			if recipe.Profession == private.Professions.Inscription then
				scan_data.filter_type = nil

				if not text_l:match("Tools: (.+)") and not text_l:match("Reagents:") and not text_l:match("Requires") then
					for pattern, filter in pairs(INSCRIPTION_MATCH_FILTERS) do
						if text_l:match(pattern) then
							recipe:SetItemFilterType(filter)
							break
						end
					end

					if not scan_data.filter_type and text_r and text_r:match("Staff") then
						scan_data.filter_type = "INSCRIPTION_STAFF"
					end
				end
			end

			for stat, roles in pairs(ROLE_STAT_MATCHES) do
				for match_index = 1, #ROLE_STAT_MATCH_FORMATS do
					if text:match(ROLE_STAT_MATCH_FORMATS[match_index]:format(stat)) then
						for role_index = 1, #roles do
							scan_data[roles[role_index]] = true
						end
					end
				end
			end

			-- Special cases.
			-- TODO: Some or all of these may not even exist anymore.
			if text:match("weapon damage") then
				scan_data.dps = true
			elseif text:match("increases (%a+) health by (%d+)") then
				scan_data.tank = true
			end

			local class_type = text_l:match("Classes: (.+)")
			if class_type then
				for idx, class in ipairs(ORDERED_CLASS_TYPES) do
					if class_type:match(class) then
						scan_data[class] = true
						scan_data.found_class = true
					end
				end
			end

			if text:match("(%d+) slot(.+)bag") or text:find("crafting reagent") then
				scan_data.no_role = true
			end
		end	-- for
	end


	--- Parses a specific recipe in the database, and scanning its tooltip
	-- @name AckisRecipeList:ScanTooltipRecipe
	-- @param spell_id The [[[http://www.wowpedia.org/SpellLink|Spell ID]]] of the recipe being added to the database
	-- @param is_vendor Boolean to determine if we're viewing a vendor or not
	-- @param is_largescan Boolean to determine if we're doing a large scan
	-- @return Recipe has its tooltips scanned
	-- Output is always returned by the caller.
	function addon:ScanTooltipRecipe(spellID, isVendor, isLargeScan)
		local recipe_list = private.recipe_list
		if not recipe_list then
			self:Debug(L["DATAMINER_NODB_ERROR"])
			return
		end

		local recipe = recipe_list[spellID]
		if not recipe then
			self:Debug("Spell ID %d does not exist in the database.", tonumber(spellID))
			return
		end
		local recipeName = recipe:LocalizedName()
		local expansionID = recipe:ExpansionID()

		if not expansionID then
			output:AddLine("No expansion information: " .. tostring(spellID) .. " " .. recipeName)
		elseif expansionID > #private.GAME_VERSION_NAMES then
			output:AddLine("Expansion information too high: " .. tostring(spellID) .. " " .. recipeName)
		end
		local optimal = recipe.optimal_level
		local medium = recipe.medium_level
		local easy = recipe.easy_level
		local trivial = recipe.trivial_level
		local skill_level = recipe.skill_level

		if not optimal then
			output:AddLine("No skill level information: " .. tostring(spellID) .. " " .. recipeName)
		else
			-- Highest level is greater than the skill of the recipe
			if optimal > skill_level then
				output:AddLine("Skill Level Error (optimal_level > skill_level): " .. tostring(spellID) .. " " .. recipeName)
			elseif optimal < skill_level then
				output:AddLine("Skill Level Error (optimal_level < skill_level): " .. tostring(spellID) .. " " .. recipeName)
			end

			-- Level info is messed up
			if optimal > medium or optimal > easy or optimal > trivial or medium > easy or medium > trivial or easy > trivial then
				output:AddLine("Skill Level Error: " .. tostring(spellID) .. " " .. recipeName)
			end
		end

		local recipeLink = _G.GetSpellLink(recipe:SpellID())
		if not recipeLink then
			self:Debug("Missing spell_link for ID %d (%s).", spellID, recipeName)
			return
		end
		ARLDatamineTT:SetOwner(_G.WorldFrame, "ANCHOR_NONE")
		_G.GameTooltip_SetDefaultAnchor(ARLDatamineTT, _G.UIParent)

		ARLDatamineTT:SetHyperlink(recipeLink)

		-- Check to see if this is a recipe tooltip.
		local text = _G["ARLDatamineTTTextLeft1"]:GetText():lower()
		local match_text = (":"):split(text)

		if match_text then
			match_text = ("%s: "):format(match_text)
		end

		if not RECIPE_TYPES[match_text] and not (text:find("smelt") or text:find("sunder") or text:find("shatter")) then
			ARLDatamineTT:Hide()
			return
		end
		table.wipe(scan_data)
		scan_data.recipe = recipe
		scan_data.is_vendor = isVendor

		ScanTooltip()

		local recipeItemID = recipe:RecipeItem()
		if recipeItemID then
			if recipe:HasFilter("common1", "TRAINER") and not recipe:HasFilter("common1", "VENDOR") and not recipe:HasFilter("common1", "INSTANCE") and not recipe:HasFilter("common1", "RAID") and not recipe:HasFilter("common1", "WORLD_DROP") then
				output:AddLine(("    Has Trainer filter flag, but also has a recipe item (%d)."):format(recipeItemID))
			end

			if not DO_NOT_SCAN[recipeItemID] then
				local item_name, item_link, item_quality = _G.GetItemInfo(recipeItemID)

				if item_name and item_link and item_quality then
					if item_quality > 0 then
						scan_data.quality = item_quality

						ARLDatamineTT:SetHyperlink(item_link)
						ScanTooltip()
					else
						output:AddLine("    Recipe item quality is 0 (junk), which probably means it has been removed from the game.")
					end
				else

					if _G.Querier then
						output:AddLine(("    Recipe item not in cache. To fix: /iq %d"):format(recipeItemID))
					else
						output:AddLine("    Recipe item not in cache.")
					end
				end
			end
		elseif not recipe:HasFilter("common1", "RETIRED") then
			-- We are dealing with a recipe that does not have an item to learn it from.
			-- Lets check the recipe flags to see if we have a data error and the item should exist
			if recipe:HasFilter("common1", "VENDOR") or recipe:HasFilter("common1", "INSTANCE") or recipe:HasFilter("common1", "RAID") or recipe:HasFilter("common1", "MOB_DROP") or recipe:HasFilter("common1", "WORLD_DROP") then
				output:AddLine(("    Missing a recipe item ID."))
			elseif recipe:HasFilter("common1", "TRAINER") and recipe:QualityID() ~= private.ITEM_QUALITIES["COMMON"] then
				output:AddLine("    Issues which will be resolved with a profession dump:")
				output:AddLine(("    Wrong quality: Q.%s - should be Q.COMMON."):format(private.ITEM_QUALITY_NAMES[recipe:QualityID()]))
				recipe:SetQualityID(private.ITEM_QUALITIES.COMMON)
			end
		end
		ARLDatamineTT:Hide()

		ProcessScanData()

		if not isLargeScan then
			self:Print(output:String())
		end
	end
end

-- ----------------------------------------------------------------------------
-- Look up table of spell IDs for recipes which do not have a player flag
-- BASICALLY A TEMPORARY STORAGE FOR IDS, SO WE CAN SEE CLEANER SCANS AND WHAT NOT,
-- WE'LL GO BACK HERE LATER DOWN THE ROAD.
-- ----------------------------------------------------------------------------
NO_ROLE_FLAG = {
	-- -----------------------------------------------------------------------------------------
	-- ASSORTED CRAP
	-- -----------------------------------------------------------------------------------------

	-- --------------------------------------------------------------------------------------
	-- JEWELCRAFTING
	-- --------------------------------------------------------------------------------------
	[25305] =	true,	[25612] =	true,	[26873] =	true,	[26903] =	true,	[26926] =	true,
	[26927] =	true,	[28950] =	true,	[28955] =	true,	[31051] =	true,	[31052] =	true,
	[31062] =	true,	[31063] =	true,	[31064] =	true,	[31065] =	true,	[31066] =	true,
	[31067] =	true,	[31092] =	true,	[31095] =	true,	[31101] =	true,	[32259] =	true,
	[32801] =	true,	[32807] =	true,	[32808] =	true,	[32809] =	true,	[32866] =	true,
	[32869] =	true,	[32872] =	true,	[37855] =	true,	[38175] =	true,	[38503] =	true,
	[38504] =	true,	[39715] =	true,	[39718] =	true,	[39724] =	true,	[39963] =	true,
	[42590] =	true,	[43493] =	true,	[47054] =	true,	[47280] =	true,	[53857] =	true,
	[53919] =	true,	[53924] =	true,	[53934] =	true,	[53943] =	true,	[53952] =	true,
	[53954] =	true,	[53955] =	true,	[53960] =	true,	[54000] =	true,	[55384] =	true,
	[55395] =	true,	[55399] =	true,	[55401] =	true,	[55407] =	true,	[56079] =	true,
	[56086] =	true,	[56087] =	true,	[56088] =	true,	[56197] =	true,	[56199] =	true,
	[56205] =	true,	[56206] =	true,	[56208] =	true,	[56530] =	true,	[56531] =	true,
	[58954] =	true,	[62242] =	true,	[62941] =	true,	[66428] =	true,	[66445] =	true,
	[66497] =	true,	[66498] =	true,
	[66499] =	true,	[66505] =	true,	[68253] =	true,	[73227] =	true,	[73229] =	true,
	[73239] =	true,	[73276] =	true,	[73279] =	true,	[73340] =	true,	[73343] =	true,
	[73347] =	true,	[73349] =	true,	[73379] =	true,	[73382] =	true,	[73401] =	true,
	[73403] =	true,	[73407] =	true,	[73409] =	true,	[73464] =	true,	[73467] =	true,
	[73468] =	true,	[73469] =	true,	[73473] =	true,	[73478] =	true,	[73494] =	true,
	[73495] =	true,	[73496] =	true,	[73497] =	true,	[73622] =	true,	[73623] =	true,
	[73625] =	true,	[73626] =	true,	[73627] =	true,	[96226] =	true,	[101740] =	true,
	[101742] =	true,	[101747] =	true,	[101750] =	true,	[101759] =	true,	[101760] =	true,
	[101803] =	true,	[101804] =	true,	[106948] =	true,	[106950] =	true,	[106957] =	true,
	[106961] =	true,	[107599] =	true,	[107608] =	true,	[107613] =	true,	[107615] =	true,
	[107619] =	true,	[107621] =	true,	[107640] =	true,	[107641] =	true,	[107710] =	true,
	[107711] =	true,	[107742] =	true,	[107746] =	true,	[107754] =	true,	[107758] =	true,
	[107763] =	true,	[107766] =	true,	[120045] =	true,	[121841] =	true,	[121842] =	true,
	[121843] =	true,	[121844] =	true,	[122661] =	true,	[122662] =	true,	[122663] =	true,
	[122678] =	true,	[122684] =	true,	[131593] =	true,	[131686] =	true,	[131688] =	true,
	[131690] =	true,	[131691] =	true,	[131695] =	true,	[131759] =	true,	[131897] =	true,
	[131898] =	true,	[140050] =	true,	[170701] =	true,	[170702] =	true,	[170703] =	true,
	[170721] =	true,	[170722] =	true,	[170723] =	true,	[170724] =	true,	[170727] =	true,
	[170728] =	true,	[170729] =	true,	[170730] =	true,	[170731] =	true,	[170732] =	true,
	[176087] =	true,	[181419] =	true,	[195857] =	true,	[195860] =	true,	[195866] =	true,
	[195870] =	true,	[195872] = 	true,	[195873] = 	true,	[195874] = 	true,	[195876] = 	true,
	[195902] =	true,	[195903] =	true,	[195904] =	true,	[195905] =	true,	[195906] =	true,
	[195907] =	true,	[195911] =	true,	[195912] =	true,	[195913] =	true,	[195914] =	true,
	[195915] =	true,	[195916] = 	true,	[195917] = 	true,	[195918] = 	true,	[195919] = 	true,
	[195920] = 	true,	[195921] = 	true,	[195922] = 	true,	[195924] = 	true,	[195927] = 	true,
	[195933] = 	true,	[195936] = 	true,	[195938] = 	true,	[195940] = 	true,	[195941] = 	true,
	[195942] = 	true,	[195943] = 	true,	[209606] =	true,	[209607] =	true,	[209609] = 	true,
	[209610] = 	true,
	[256512] =	true,

	-- ------------------------------------------------------------------------------------
	-- COOKING
	-- ------------------------------------------------------------------------------------
	[2538] =	true,	[2539] =	true,	[2540] =	true,	[2543] =	true,	[2545] =	true,
	[2548] =	true,	[2795] =	true,	[6412] =	true,	[6413] =	true,	[6414] =	true,
	[6417] =	true,	[6501] =	true,	[7751] =	true,	[7752] =	true,	[7753] =	true,
	[7754] =	true,	[7755] =	true,	[7827] =	true,	[7828] =	true,	[8238] =	true,
	[8604] =	true,	[8607] =	true,	[9513] =	true,	[13028] =	true,	[15906] =	true,
	[15935] =	true,	[18238] =	true,	[18239] =	true,	[18241] =	true,	[18244] =	true,
	[18245] =	true,	[18246] =	true,	[18247] =	true,	[20626] =	true,	[20916] =	true,
	[21143] =	true,	[21144] =	true,	[25659] =	true,	[33276] =	true,	[33277] =	true,
	[33290] =	true,	[37836] =	true,	[42296] =	true,	[42305] =	true,	[43758] =	true,
	[43772] =	true,	[43779] =	true,	[45560] =	true,	[45561] =	true,	[45562] =	true,
	[45695] =	true,	[53056] =	true,	[57421] =	true,	[57435] =	true,	[57438] =	true,
	[57440] =	true,	[57443] =	true,	[58512] =	true,	[58521] =	true,	[58523] =	true,
	[58525] =	true,	[58527] =	true,	[58528] =	true,	[62044] =	true,	[62050] =	true,
	[62051] =	true,	[64358] =	true,	[65454] =	true,	[88006] =	true,	[88011] =	true,
	[88013] =	true,	[88015] =	true,	[88017] =	true,	[88018] =	true,	[88019] =	true,
	[88022] =	true,	[88025] =	true,	[88035] =	true,	[88036] =	true,	[88044] =	true,
	[88045] =	true,	[93741] =	true,	[96133] =	true,	[104237] =	true,	[104297] =	true,
	[105190] =	true,	[105194] =	true,	[124029] =	true,	[124032] =	true,	[125067] =	true,
	[125078] =	true,	[125080] =	true,	[125117] =	true,	[145038] =	true,	[145061] =	true,
	[145062] =	true,	[145308] =	true,	[160958] =	true,	[160962] =	true,	[160968] =	true,
	[160969] =	true,	[160971] =	true,	[160973] =	true,	[160981] =	true,	[160982] =	true,
	[160983] =	true,	[160984] =	true,	[160989] =	true,	[160999] =	true,	[161000] =	true,
	[161001] =	true,	[161002] =	true,	[173978] =	true,	[173979] =	true,	[180757] =	true,
	[180759] =	true,	[180762] =	true,	[185704] =	true,	[185705] =	true,	[185708] =	true,

	-- ------------------------------------------------------------------------------------
	-- BLACKSMITHING
	-- ------------------------------------------------------------------------------------
	[2661] =	true,	[2662] =	true,	[2663] =	true,	[2737] =	true,	[2738] =	true,
	[2739] =	true,	[2741] =	true,	[3292] =	true,	[3293] =	true,	[3319] =	true,
	[3491] =	true,	[3494] =	true,	[3501] =	true,	[3513] =	true,	[7221] =	true,
	[7224] =	true,	[8880] =	true,	[9928] =	true,	[9933] =	true,	[9939] =	true,
	[9964] =	true,	[9974] =	true,	[9983] =	true,	[10003] =	true,	[10007] =	true,
	[10011] =	true,	[10015] =	true,	[12260] =	true,	[15292] =	true,	[15296] =	true,
	[16651] =	true,	[16655] =	true,	[16664] =	true,	[16665] =	true,	[16667] =	true,
	[16726] =	true,	[16731] =	true,	[16732] =	true,	[16978] =	true,	[16983] =	true,
	[16984] =	true,	[16992] =	true,	[16993] =	true,	[19666] =	true,	[19667] =	true,
	[19668] =	true,	[19669] =	true,	[20874] =	true,	[20876] =	true,	[20890] =	true,
	[21161] =	true,	[21913] =	true,	[23636] =	true,	[23638] =	true,	[23650] =	true,
	[23653] =	true,	[24399] =	true,	[29657] =	true,	[29728] =	true,	[29729] =	true,
	[32284] =	true,	[32285] =	true,	[38475] =	true,	[38478] =	true,	[40033] =	true,
	[40034] =	true,	[40035] =	true,	[40036] =	true,	[55206] =	true,	[55656] =	true,
	[56357] =	true,	[59405] =	true,	[59406] =	true,	[61008] =	true,	[61009] =	true,
	[61010] =	true,	[76438] =	true,	[76439] =	true,	[76440] =	true,	[76441] =	true,
	[122576] =	true,	[122577] =	true,	[122578] =	true,	[122579] =	true,	[122580] =	true,
	[122581] =	true,	[122582] =	true,	[122583] =	true,	[122632] =	true,	[122633] =	true,
	[131928] =	true,	[139745] =	true,	[139746] =	true,	[139747] =	true,	[139748] =	true,
	[139749] =	true,	[139750] =	true,	[139751] =	true,	[139753] =	true,	[139754] =	true,
	[139755] =	true,	[139756] =	true,	[139757] =	true,	[139759] =	true,	[139760] =	true,
	[139761] =	true,	[139762] =	true,	[139763] =	true,	[139764] =	true,	[140165] =	true,
	[140166] =	true,	[140167] =	true,	[140168] =	true,	[171699] =	true,	[171708] =	true,
	[171709] =	true,	[171710] =	true,	[171711] =	true,	[173355] =	true,	[176090] =	true,
	[177169] =	true,	[181416] =	true,	[181417] =	true,	[182962] =	true,	[182963] =	true,
	[182964] =	true,	[182965] =	true,	[182966] =	true,	[182967] =	true,	[182968] =	true,
	[182969] =	true,	[182971] =	true,	[182983] =	true,
	[209499] =	true,

	-- ------------------------------------------------------------------------------------
	-- INSCRIPTION
	-- ------------------------------------------------------------------------------------
	[45382] =	true,	[48247] =	true,	[48248] =	true,	[50612] =	true,	[50614] =	true,
	[50616] =	true,	[50617] =	true,	[50618] =	true,	[50619] =	true,	[50620] =	true,
	[52739] =	true,	[56946] =	true,	[56948] =	true,	[56950] =	true,	[56952] =	true,
	[56954] =	true,	[56958] =	true,	[56959] =	true,	[56965] =	true,	[56972] =	true,
	[56975] =	true,	[56978] =	true,	[56979] =	true,	[56980] =	true,	[56981] =	true,
	[56983] =	true,	[56986] =	true,	[56988] =	true,	[56989] =	true,	[56990] =	true,
	[56991] =	true,	[56994] =	true,	[56995] =	true,	[56998] =	true,	[56999] =	true,
	[57000] =	true,	[57001] =	true,	[57002] =	true,	[57003] =	true,	[57005] =	true,
	[57007] =	true,	[57009] =	true,	[57012] =	true,	[57014] =	true,	[57019] =	true,
	[57022] =	true,	[57023] =	true,	[57027] =	true,	[57031] =	true,	[57032] =	true,
	[57033] =	true,	[57034] =	true,	[57036] =	true,	[57037] =	true,	[57114] =	true,
	[57115] =	true,	[57119] =	true,	[57120] =	true,	[57122] =	true,	[57123] =	true,
	[57124] =	true,	[57125] =	true,	[57126] =	true,	[57127] =	true,	[57129] =	true,
	[57130] =	true,	[57132] =	true,	[57133] =	true,	[57152] =	true,	[57153] =	true,
	[57154] =	true,	[57157] =	true,	[57159] =	true,	[57160] =	true,	[57161] =	true,
	[57164] =	true,	[57172] =	true,	[57181] =	true,	[57183] =	true,	[57185] =	true,
	[57189] =	true,	[57190] =	true,	[57191] =	true,	[57193] =	true,	[57194] =	true,
	[57195] =	true,	[57196] =	true,	[57198] =	true,	[57200] =	true,	[57202] =	true,
	[57207] =	true,	[57209] =	true,	[57210] =	true,	[57211] =	true,	[57215] =	true,
	[57217] =	true,	[57219] =	true,	[57220] =	true,	[57221] =	true,	[57222] =	true,
	[57223] =	true,	[57224] =	true,	[57225] =	true,	[57226] =	true,	[57227] =	true,
	[57228] =	true,	[57229] =	true,	[57230] =	true,	[57232] =	true,	[57233] =	true,
	[57234] =	true,	[57235] =	true,	[57236] =	true,	[57237] =	true,	[57238] =	true,
	[57240] =	true,	[57242] =	true,	[57246] =	true,	[57247] =	true,	[57249] =	true,
	[57250] =	true,	[57251] =	true,	[57252] =	true,	[57253] =	true,	[57257] =	true,
	[57258] =	true,	[57260] =	true,	[57261] =	true,	[57263] =	true,	[57265] =	true,
	[57267] =	true,	[57269] =	true,	[57270] =	true,	[57271] =	true,	[57274] =	true,
	[57276] =	true,	[57277] =	true,	[58286] =	true,	[58287] =	true,	[58288] =	true,
	[58289] =	true,	[58296] =	true,	[58297] =	true,	[58298] =	true,	[58299] =	true,
	[58301] =	true,	[58302] =	true,	[58306] =	true,	[58308] =	true,	[58311] =	true,
	[58312] =	true,	[58314] =	true,	[58315] =	true,	[58316] =	true,	[58317] =	true,
	[58318] =	true,	[58320] =	true,	[58322] =	true,	[58323] =	true,	[58324] =	true,
	[58325] =	true,	[58326] =	true,	[58327] =	true,	[58328] =	true,	[58329] =	true,
	[58330] =	true,	[58332] =	true,	[58333] =	true,	[58336] =	true,	[58337] =	true,
	[58339] =	true,	[58340] =	true,	[58341] =	true,	[58342] =	true,	[58343] =	true,
	[58345] =	true,	[58347] =	true,	[59326] =	true,	[59339] =	true,	[59340] =	true,
	[59387] =	true,	[59478] =	true,	[59480] =	true,	[59487] =	true,	[59491] =	true,
	[59502] =	true,	[59503] =	true,	[59504] =	true,	[59561] =	true,	[60336] =	true,
	[60337] =	true,	[64051] =	true,	[64246] =	true,	[64247] =	true,	[64248] =	true,
	[64250] =	true,	[64253] =	true,	[64255] =	true,	[64257] =	true,	[64258] =	true,
	[64259] =	true,	[64260] =	true,	[64261] =	true,	[64262] =	true,	[64266] =	true,
	[64268] =	true,	[64270] =	true,	[64273] =	true,	[64276] =	true,	[64277] =	true,
	[64281] =	true,	[64283] =	true,	[64284] =	true,	[64285] =	true,	[64288] =	true,
	[64289] =	true,	[64295] =	true,	[64296] =	true,	[64297] =	true,	[64298] =	true,
	[64300] =	true,	[64302] =	true,	[64303] =	true,	[64304] =	true,	[64307] =	true,
	[64309] =	true,	[64311] =	true,	[64312] =	true,	[64317] =	true,	[68166] =	true,
	[69385] =	true,	[71101] =	true,	[71102] =	true,	[85785] =	true,	[86402] =	true,
	[86609] =	true,	[86615] =	true,	[86644] =	true,	[86645] =	true,	[86646] =	true,
	[89244] =	true,	[89372] =	true,	[92026] =	true,	[92027] =	true,	[92579] =	true,
	[94000] =	true,	[94004] =	true,	[94005] =	true,	[94404] =	true,	[94405] =	true,
	[94711] =	true,	[95215] =	true,	[95710] =	true,	[95825] =	true,	[107907] =	true,
	[111830] =	true,	[112045] =	true,	[112264] =	true,	[112265] =	true,	[112266] =	true,
	[112429] =	true,	[112430] =	true,	[112437] =	true,	[112440] =	true,	[112442] =	true,
	[112444] =	true,	[112450] =	true,	[112454] =	true,	[112458] =	true,	[112460] =	true,
	[112461] =	true,	[112462] =	true,	[112463] =	true,	[112464] =	true,	[112465] =	true,
	[112466] =	true,	[112468] =	true,	[112469] =	true,	[112883] =	true,	[119481] =	true,
	[122030] =	true,	[123781] =	true,	[124442] =	true,	[124449] =	true,	[124451] =	true,
	[124452] =	true,	[124455] =	true,	[124456] =	true,	[124457] =	true,	[124459] =	true,
	[124460] =	true,	[124461] =	true,	[124466] =	true,	[126153] =	true,	[126687] =	true,
	[126696] =	true,	[126800] =	true,	[126801] =	true,	[126988] =	true,	[126989] =	true,
	[126994] =	true,	[127007] =	true,	[127009] =	true,	[127019] =	true,	[127024] =	true,
	[127378] =	true,	[127625] =	true,	[131152] =	true,	[132167] =	true,	[135561] =	true,
	[146638] =	true,	[148255] =	true,	[148257] =	true,	[148259] =	true,	[148260] =	true,
	[148261] =	true,	[148266] =	true,	[148268] =	true,	[148269] =	true,	[148270] =	true,
	[148271] =	true,	[148272] =	true,	[148273] =	true,	[148274] =	true,	[148275] =	true,
	[148276] =	true,	[148278] =	true,	[148279] =	true,	[148280] =	true,	[148281] =	true,
	[148282] =	true,	[148283] =	true,	[148284] =	true,	[148285] =	true,	[148286] =	true,
	[148287] =	true,	[148288] =	true,	[148289] =	true,	[148290] =	true,	[148291] =	true,
	[148292] =	true,	[148487] =	true,	[148489] =	true,	[162805] =	true,	[162806] =	true,
	[162807] =	true,	[162808] =	true,	[162810] =	true,	[162811] =	true,	[162812] =	true,
	[162813] =	true,	[162814] =	true,	[162815] =	true,	[162817] =	true,	[162818] =	true,
	[162819] =	true,	[162820] =	true,	[162821] =	true,	[162822] =	true,	[162823] =	true,
	[162824] =	true,	[162826] =	true,	[162827] =	true,	[162829] =	true,	[162830] =	true,
	[162831] =	true,	[162832] =	true,	[162833] =	true,	[162834] =	true,	[162835] =	true,
	[162837] =	true,	[162838] =	true,	[162839] =	true,	[162840] =	true,	[162841] =	true,
	[162842] =	true,	[162843] =	true,	[162844] =	true,	[162846] =	true,	[162847] =	true,
	[162848] =	true,	[162849] =	true,	[162850] =	true,	[162851] =	true,	[162852] =	true,
	[162853] =	true,	[162854] =	true,	[162855] =	true,	[162856] =	true,	[162857] =	true,
	[162858] =	true,	[162860] =	true,	[162861] =	true,	[162862] =	true,	[162863] =	true,
	[162865] =	true,	[162866] =	true,	[162867] =	true,	[162869] =	true,	[162871] =	true,
	[162872] =	true,	[162873] =	true,	[162874] =	true,	[162876] =	true,	[162877] =	true,
	[162879] =	true,	[162880] =	true,	[162881] =	true,	[162882] =	true,	[162883] =	true,
	[162884] =	true,	[163294] =	true,	[165304] =	true,	[165456] =	true,	[165460] =	true,
	[165461] =	true,	[165463] =	true,	[165464] =	true,	[165465] =	true,	[165466] =	true,
	[165467] =	true,	[165564] =	true,	[166366] =	true,	[166367] =	true,	[166432] =	true,
	[166669] =	true,	[167950] =	true,	[175186] =	true,	[177045] =	true,	[178248] =	true,
	[178249] =	true,	[178448] =	true,	[181420] =	true,	[181421] =	true,	[182154] =	true,
	[182155] =	true,	[182156] =	true,	[182157] =	true,	[182158] =	true,	[225550] =	true,
	[256277] =	true,	[311424] =	true,

	-- ------------------------------------------------------------------------------------
	-- ENCHANTING
	-- ------------------------------------------------------------------------------------
	[7418] =	true,	[7420] =	true,	[7421] =	true,	[7426] =	true,	[7457] =	true,
	[7745] =	true,	[7748] =	true,	[7786] =	true,	[7788] =	true,	[7857] =	true,
	[7863] =	true,	[13378] =	true,	[13501] =	true,	[13503] =	true,	[13529] =	true,
	[13538] =	true,	[13612] =	true,	[13617] =	true,	[13620] =	true,	[13626] =	true,
	[13626] =	true,	[13631] =	true,	[13640] =	true,	[13644] =	true,	[13648] =	true,
	[13653] =	true,	[13655] =	true,	[13693] =	true,	[13695] =	true,	[13698] =	true,
	[13700] =	true,	[13817] =	true,	[13836] =	true,	[13841] =	true,	[13858] =	true,
	[13868] =	true,	[13890] =	true,	[13898] =	true,	[13915] =	true,	[13937] =	true,
	[13941] =	true,	[13943] =	true,	[13945] =	true,	[13947] =	true,	[14293] =	true,
	[20011] =	true,	[20017] =	true,	[20020] =	true,	[20025] =	true,	[20026] =	true,
	[20029] =	true,	[20030] =	true,	[20031] =	true,	[20032] =	true,	[20033] =	true,
	[25125] =	true,
	[27905] =	true,	[27914] =	true,	[27948] =	true,	[27950] =	true,	[27957] =	true,
	[27960] =	true,	[27967] =	true,	[28003] =	true,	[28004] =	true,	[28027] =	true,
	[28028] =	true,	[33992] =	true,	[33994] =	true,	[34003] =	true,	[34008] =	true,
	[34009] =	true,	[44383] =	true,	[44492] =	true,	[44506] =	true,	[44524] =	true,
	[44528] =	true,	[44576] =	true,	[44582] =	true,	[44588] =	true,	[44595] =	true,
	[44616] =	true,	[44621] =	true,	[44623] =	true,	[46578] =	true,	[47672] =	true,
	[47900] =	true,	[47901] =	true,	[60692] =	true,	[62256] =	true,	[63746] =	true,
	[64579] =	true,	[69412] =	true,	[71692] =	true,	[74132] =	true,	[74189] =	true,
	[74191] =	true,	[74192] =	true,	[74195] =	true,	[74197] =	true,	[74200] =	true,
	[74207] =	true,	[74211] =	true,	[74214] =	true,	[74226] =	true,	[74232] =	true,
	[74234] =	true,	[74236] =	true,	[74238] =	true,	[74250] =	true,	[74251] =	true,
	[74253] =	true,	[74255] =	true,	[93843] =	true,	[104338] =	true,	[104392] =	true,
	[104395] =	true,	[104397] =	true,	[104398] =	true,	[104401] =	true,	[104408] =	true,
	[104414] =	true,	[104420] =	true,	[104430] =	true,	[104440] =	true,	[158879] =	true,
	[158880] =	true,	[158881] =	true,	[158886] =	true,	[158887] =	true,	[158889] =	true,
	[158894] =	true,	[158895] =	true,	[158896] =	true,	[158901] =	true,	[158902] =	true,
	[158903] =	true,	[158909] =	true,	[158910] =	true,	[158911] =	true,	[158916] =	true,
	[158917] =	true,	[158918] =	true,	[159236] =	true,	[159672] =	true,	[159673] =	true,
	[159674] =	true,	[162948] =	true,	[173323] =	true,	[177043] =	true,	[190995] =	true,
	[190997] =	true,	[190999] =	true,	[191078] =	true,	[217655] =	true,	[255100] =	true,
	[255112] =	true,	[268903] =	true,

	-- ------------------------------------------------------------------------------------
	-- TAILORING
	-- ------------------------------------------------------------------------------------
	[2385] =	true,	[2387] =	true,	[2392] =	true,	[2393] =	true,	[2394] =	true,
	[2396] =	true,	[2402] =	true,	[2406] =	true,	[3841] =	true,	[3848] =	true,
	[3866] =	true,	[3869] =	true,	[3870] =	true,	[3871] =	true,	[3872] =	true,
	[3873] =	true,	[3915] =	true,	[7892] =	true,	[7893] =	true,	[8465] =	true,
	[8467] =	true,	[8483] =	true,	[8489] =	true,	[8776] =	true,	[8789] =	true,
	[12044] =	true,	[12045] =	true,	[12061] =	true,	[12064] =	true,	[12075] =	true,
	[12077] =	true,	[12080] =	true,	[12085] =	true,	[12089] =	true,	[12091] =	true,
	[12093] =	true,	[18414] =	true,	[18415] =	true,	[18421] =	true,	[18422] =	true,
	[18439] =	true,	[18446] =	true,	[18450] =	true,	[21945] =	true,	[22813] =	true,
	[26403] =	true,	[26407] =	true,	[28208] =	true,	[28210] =	true,	[31448] =	true,
	[31460] =	true,	[37873] =	true,	[40020] =	true,	[40021] =	true,	[40023] =	true,
	[40024] =	true,	[40060] =	true,	[44950] =	true,	[44958] =	true,	[49677] =	true,
	[50644] =	true,	[50647] =	true,	[55898] =	true,	[55993] =	true,	[55994] =	true,
	[55995] =	true,	[55996] =	true,	[55997] =	true,	[55998] =	true,	[55999] =	true,
	[56000] =	true,	[60969] =	true,	[60971] =	true,	[60990] =	true,	[60993] =	true,
	[60994] =	true,	[75247] =	true,	[75288] =	true,	[75597] =	true,	[125557] =	true,
	[168836] =	true,	[168849] =	true,	[168850] =	true,	[168855] =	true,	[168856] =	true,
	[176058] =	true,	[181418] =	true,	[185935] =	true,	[185943] =	true,	[185947] =	true,
	[185955] =	true,	[213035] =	true,

	-- ------------------------------------------------------------------------------------
	-- LEATHERWORKING
	-- ------------------------------------------------------------------------------------
	[2149] =	true,	[2152] =	true,	[2153] =	true,	[2159] =	true,	[2160] =	true,
	[2165] =	true,	[2166] =	true,	[3753] =	true,	[3763] =	true,	[3778] =	true,
	[3780] =	true,	[7126] =	true,	[9058] =	true,	[9059] =	true,	[9064] =	true,
	[9065] =	true,	[9070] =	true,	[9072] =	true,	[9146] =	true,	[9147] =	true,
	[9208] =	true,	[10487] =	true,	[10529] =	true,	[10544] =	true,	[10546] =	true,
	[10566] =	true,	[10572] =	true,	[10574] =	true,	[19053] =	true,	[19058] =	true,
	[19059] =	true,	[19063] =	true,	[19066] =	true,	[19073] =	true,	[19074] =	true,
	[19076] =	true,	[19081] =	true,	[19087] =	true,	[19093] =	true,	[19101] =	true,
	[19104] =	true,	[22815] =	true,	[22923] =	true,	[23190] =	true,	[23707] =	true,
	[24849] =	true,	[24850] =	true,	[24851] =	true,	[28472] =	true,	[28473] =	true,
	[28474] =	true,	[32456] =	true,	[32457] =	true,	[32461] =	true,	[32482] =	true,
	[35538] =	true,	[35539] =	true,	[35543] =	true,	[35544] =	true,	[39997] =	true,
	[40001] =	true,	[40002] =	true,	[40003] =	true,	[40004] =	true,	[40005] =	true,
	[40006] =	true,	[44770] =	true,	[44953] =	true,	[44970] =	true,	[50962] =	true,
	[50963] =	true,	[52733] =	true,	[60996] =	true,	[60997] =	true,	[60998] =	true,
	[60999] =	true,	[61000] =	true,	[61002] =	true,	[62448] =	true,	[69388] =	true,
	[78379] =	true,	[78388] =	true,	[78396] =	true,	[78398] =	true,	[78399] =	true,
	[78406] =	true,	[78407] =	true,	[78410] =	true,	[78411] =	true,	[78415] =	true,
	[78416] =	true,	[78423] =	true,	[78424] =	true,	[78427] =	true,	[78428] =	true,
	[78432] =	true,	[78433] =	true,	[78437] =	true,	[124571] =	true,	[124572] =	true,
	[124573] =	true,	[124574] =	true,	[124575] =	true,	[124576] =	true,	[124577] =	true,
	[124578] =	true,	[124579] =	true,	[124580] =	true,	[124581] =	true,	[124582] =	true,
	[124583] =	true,	[124584] =	true,	[124585] =	true,	[124586] =	true,	[124628] =	true,
	[124635] =	true,	[171266] =	true,	[171286] =	true,	[171287] =	true,	[171291] =	true,
	[176089] =	true,	[181415] =	true,	[185934] =	true,	[185936] =	true,	[185937] =	true,
	[185938] =	true,	[185939] =	true,	[185940] =	true,	[185941] =	true,
	[185946] =	true,	[185948] =	true,	[185949] =	true,	[185950] =	true,	[185951] =	true,
	[185952] =	true,	[185953] =	true,	[186388] =	true,	[194756] =	true,	[194760] =	true,
	[194768] =	true,	[194775] =	true,	[194778] =	true,

	-- ------------------------------------------------------------------------------------
	-- ALCHEMY
	-- ------------------------------------------------------------------------------------
	[2330] =	true,	[2334] =	true,	[2335] =	true,	[2337] =	true,	[3170] =	true,
	[3174] =	true,	[3175] =	true,	[3176] =	true,	[3447] =	true,	[3448] =	true,
	[3449] =	true,	[3450] =	true,	[3451] =	true,	[3452] =	true,	[3453] =	true,
	[3454] =	true,	[4508] =	true,	[6624] =	true,	[7179] =	true,	[7181] =	true,
	[7255] =	true,	[7256] =	true,	[7257] =	true,	[7258] =	true,	[7259] =	true,
	[7841] =	true,	[11448] =	true,	[11451] =	true,	[11452] =	true,	[11457] =	true,
	[11458] =	true,	[11460] =	true,	[11464] =	true,	[11466] =	true,	[11468] =	true,
	[11478] =	true,	[12609] =	true,	[15833] =	true,	[17553] =	true,	[17556] =	true,
	[17557] =	true,	[17572] =	true,	[17574] =	true,	[17575] =	true,	[17576] =	true,
	[17577] =	true,	[17578] =	true,	[17580] =	true,	[17634] =	true,	[17635] =	true,
	[22732] =	true,	[22808] =	true,	[24266] =	true,	[24366] =	true,	[24367] =	true,
	[24368] =	true,	[28543] =	true,	[28546] =	true,	[28551] =	true,	[28552] =	true,
	[28554] =	true,	[28555] =	true,	[28562] =	true,	[28571] =	true,	[28572] =	true,
	[28573] =	true,	[28575] =	true,	[28576] =	true,	[28577] =	true,	[28577] =	true,
	[28578] =	true,	[28586] =	true,	[33732] =	true,	[33733] =	true,	[33741] =	true,
	[38962] =	true,	[39637] =	true,	[39639] =	true,	[41458] =	true,	[41500] =	true,
	[41501] =	true,	[41502] =	true,	[41503] =	true,	[45061] =	true,	[53836] =	true,
	[53837] =	true,	[53838] =	true,	[53839] =	true,	[53848] =	true,	[53895] =	true,
	[53899] =	true,	[53900] =	true,	[53904] =	true,	[53936] =	true,	[53937] =	true,
	[53938] =	true,	[53939] =	true,	[53942] =	true,	[58868] =	true,	[58871] =	true,
	[60893] =	true,	[62410] =	true,	[78866] =	true,	[80269] =	true,	[80479] =	true,
	[80482] =	true,	[80487] =	true,	[80490] =	true,	[80492] =	true,	[80494] =	true,
	[80497] =	true,	[80498] =	true,	[80719] =	true,	[80725] =	true,	[80726] =	true,
	[92643] =	true,	[92688] =	true,	[93328] =	true,	[93935] =	true,	[114751] =	true,
	[114752] =	true,	[114758] =	true,	[114761] =	true,	[114770] =	true,	[114774] =	true,
	[114775] =	true,	[114779] =	true,	[114782] =	true,	[156561] =	true,	[156568] =	true,
	[156576] =	true,	[156581] =	true,	[156582] =	true,	[156584] =	true,	[162403] =	true,
	[175853] =	true,	[175865] =	true,	[175866] =	true,	[175867] =	true,	[175868] =	true,
	[175869] =	true,	[175880] =	true,	[188297] =	true,	[188299] =	true,	[188301] =	true,
	[188304] =	true,	[23787] = 	true,	[252343] =	true,	[252356] =	true,	[252378] =	true,
	[252387] =	true,	[252384] =	true,

	-- ------------------------------------------------------------------------------------
	-- ENGINEERING
	-- ------------------------------------------------------------------------------------
	[3919] =	true,	[3923] =	true,	[3925] =	true,	[3928] =	true,	[3931] =	true,
	[3932] =	true,	[3933] =	true,	[3936] =	true,	[3937] =	true,	[3939] =	true,
	[3941] =	true,	[3944] =	true,	[3946] =	true,	[3949] =	true,	[3950] =	true,
	[3952] =	true,	[3954] =	true,	[3955] =	true,	[3957] =	true,	[3960] =	true,
	[3962] =	true,	[3963] =	true,	[3965] =	true,	[3967] =	true,	[3968] =	true,
	[3969] =	true,	[3971] =	true,	[3972] =	true,	[3977] =	true,	[3978] =	true,
	[3979] =	true,	[6458] =	true,	[7430] =	true,	[8243] =	true,	[8334] =	true,
	[8339] =	true,	[8895] =	true,	[9269] =	true,	[9271] =	true,	[9273] =	true,
	[12586] =	true,	[12590] =	true,	[12594] =	true,	[12597] =	true,	[12603] =	true,
	[12607] =	true,	[12614] =	true,	[12617] =	true,	[12619] =	true,	[12620] =	true,
	[12622] =	true,	[12624] =	true,	[12716] =	true,	[12717] =	true,	[12718] =	true,
	[12754] =	true,	[12755] =	true,	[12758] =	true,	[12759] =	true,	[12760] =	true,
	[12902] =	true,	[12903] =	true,	[12905] =	true,	[12906] =	true,	[12908] =	true,
	[13240] =	true,	[15255] =	true,	[15628] =	true,	[15633] =	true,	[19790] =	true,
	[19792] =	true,	[19793] =	true,	[19796] =	true,	[19799] =	true,	[19814] =	true,
	[19819] =	true,	[19830] =	true,	[19831] =	true,	[21940] =	true,	[22704] =	true,
	[22797] =	true,	[23066] =	true,	[23067] =	true,	[23068] =	true,	[23069] =	true,
	[23070] =	true,	[23077] =	true,	[23078] =	true,	[23079] =	true,	[23080] =	true,
	[23081] =	true,	[23082] =	true,	[23096] =	true,	[23129] =	true,	[23078] =	true,
	[23486] =	true,	[23489] =	true,	[23507] =	true,	[26011] =	true,	[26416] =	true,
	[26417] =	true,	[26418] =	true,	[26420] =	true,	[26421] =	true,	[26422] =	true,
	[26423] =	true,	[26424] =	true,	[26425] =	true,	[26426] =	true,	[26427] =	true,
	[26428] =	true,	[26442] =	true,	[26443] =	true,	[28327] =	true,	[30310] =	true,
	[30311] =	true,	[30312] =	true,	[30316] =	true,	[30329] =	true,	[30332] =	true,
	[30337] =	true,	[30341] =	true,	[30344] =	true,	[30547] =	true,	[30548] =	true,
	[30349] =	true,	[30551] =	true,	[30552] =	true,	[30558] =	true,	[30560] =	true,
	[30563] =	true,	[30568] =	true,	[30569] =	true,	[30570] =	true,	[32814] =	true,
	[36954] =	true,
	[36955] =	true,	[39973] =	true,	[41307] =	true,	[44155] =	true,	[44157] =	true,
	[44391] =	true,	[54736] =	true,	[54793] =	true,	[55002] =	true,	[55016] =	true,
	[55252] =	true,	[56459] =	true,	[56460] =	true,	[56461] =	true,	[56462] =	true,
	[56463] =	true,	[56465] =	true,	[56468] =	true,	[56472] =	true,	[56473] =	true,
	[56476] =	true,	[56477] =	true,	[56514] =	true,	[60866] =	true,	[60867] =	true,
	[61471] =	true,	[67326] =	true,	[67839] =	true,	[67920] =	true,	[68067] =	true,
	[82200] =	true,	[84406] =	true,	[84409] =	true,	[84411] =	true,	[84412] =	true,
	[84413] =	true,	[84415] =	true,	[84418] =	true,	[84421] =	true,	[84424] =	true,
	[84425] =	true,	[84427] =	true,	[84429] =	true,	[84430] =	true,	[95703] =	true,
	[95705] =	true,	[95707] =	true,	[109099] =	true,	[126392] =	true,	[127124] =	true,
	[127127] =	true,	[127128] =	true,	[127129] =	true,	[127130] =	true,	[127131] =	true,
	[127132] =	true,	[127134] =	true,	[127135] =	true,	[127138] =	true,	[127139] =	true,
	[128260] =	true,	[128261] =	true,	[128262] =	true,	[131212] =	true,	[131256] =	true,
	[131258] =	true,	[131353] =	true,	[139192] =	true,	[139196] =	true,	[143714] =	true,
	[162202] =	true,	[162204] =	true,	[162205] =	true,	[162206] =	true,	[162207] =	true,
	[162209] =	true,	[162210] =	true,	[162214] =	true,	[162216] =	true,	[162217] =	true,
	[162218] =	true,	[169076] =	true,	[169077] =	true,	[169078] =	true,	[169140] =	true,
	[171072] =	true,	[171073] =	true,	[171074] =	true,	[173289] =	true,	[173308] =	true,
	[173309] =	true,	[176732] =	true,	[177054] =	true,	[177363] =	true,	[177364] =	true,
	[181422] =	true,	[181423] =	true,	[198979] =	true,	[198999] =	true,	[199001] =	true,
	[199002] =	true,	[199003] =	true,	[199004] =	true,
	[199013] =	true,	[199015] =	true,	[199018] =	true,	[255409] =	true,
	[225539] =	true,	[256084] =	true,	[256156] =	true,	[272063] =	true,	[283915] =	true,
}
