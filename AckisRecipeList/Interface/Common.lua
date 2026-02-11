--[[
Copyright (c) 2009 - 2012 Ackis <John Pasula>
All rights reserved by the original author Ackis.
]]

-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------

local table = _G.table
local pairs = _G.pairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon	= LibStub("AceAddon-3.0"):GetAddon(private.addon_name)

-- ----------------------------------------------------------------------------
-- Table cache mechanism
-- ----------------------------------------------------------------------------
do
	local table_cache = {}

	-- Returns a table
	function private.AcquireTable()
		local tbl = table.remove(table_cache) or {}
		return tbl
	end

	-- Cleans the table and stores it in the cache
	function private.ReleaseTable(tbl)
		if not tbl then return end
		table.wipe(tbl)
		table.insert(table_cache, tbl)
	end
end	-- do block

-- ----------------------------------------------------------------------------
-- Sort functions
-- ----------------------------------------------------------------------------
do
	addon.sorted_recipes = {}

	local recipe_list = private.recipe_list
	local sorted_recipes = addon.sorted_recipes

	local function Sort_SkillAsc(a, b)
		local recipeA, recipeB = recipe_list[a], recipe_list[b]

		if not recipeA.skill_level and not recipeA.skill_level then
			return recipeA:LocalizedName() < recipeB:LocalizedName()
		elseif not recipeA.skill_level then
			return recipeB.skill_level < 0
		elseif not recipeB.skill_level then
			return 0 < recipeA.skill_level
		end

		if recipeA.skill_level == recipeB.skill_level then
			return recipeA:LocalizedName() < recipeB:LocalizedName()
		else
			return recipeA.skill_level < recipeB.skill_level
		end
	end

	local function Sort_SkillDesc(a, b)
		local recipeA, recipeB = recipe_list[a], recipe_list[b]

		if recipeA.skill_level == recipeB.skill_level then
			return recipeA:LocalizedName() < recipeB:LocalizedName()
		else
			return recipeB.skill_level < recipeA.skill_level
		end
	end

	local function Sort_NameAsc(a, b)
		return recipe_list[a]:LocalizedName() < recipe_list[b]:LocalizedName()
	end

	local function Sort_NameDesc(a, b)
		return recipe_list[a]:LocalizedName() > recipe_list[b]:LocalizedName()
	end

	local RECIPE_SORT_FUNCS = {
		["SkillAscending"]	= Sort_SkillAsc,
		["SkillDescending"]	= Sort_SkillDesc,
		["NameAscending"]	= Sort_NameAsc,
		["NameDescending"]	= Sort_NameDesc,
	}

    function private.SortRecipePairs(recipePairs)
        if not recipePairs then
            return
        end

        table.wipe(sorted_recipes)

        for recipe in pairs(recipePairs) do
            sorted_recipes[#sorted_recipes + 1] = recipe:SpellID()
        end

        table.sort(sorted_recipes, RECIPE_SORT_FUNCS[(addon.db.profile.skill_view and "Skill" or "Name") .. addon.db.profile.sorting] or Sort_NameAsc)

        return sorted_recipes
    end

	-- Sorts the recipe_list according to configuration settings.
	function private.SortRecipeList(recipe_list)
		table.wipe(sorted_recipes)

		for recipe_id, recipe in pairs(recipe_list) do
			sorted_recipes[#sorted_recipes + 1] = recipe_id
		end
		table.sort(sorted_recipes, RECIPE_SORT_FUNCS[(addon.db.profile.skill_view and "Skill" or "Name") .. addon.db.profile.sorting] or Sort_NameAsc)
		return sorted_recipes
	end
end	-- do

-- ----------------------------------------------------------------------------
-- Sets show and hide scripts as well as text for a tooltip for the given frame.
-- ----------------------------------------------------------------------------
do
	local HIGHLIGHT_FONT_COLOR = _G.HIGHLIGHT_FONT_COLOR

	local function Show_Tooltip(frame, motion)
		_G.GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
		_G.GameTooltip:SetText(frame.tooltip_text, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		_G.GameTooltip:Show()
	end

	local function Hide_Tooltip()
		_G.GameTooltip:Hide()
	end

	function private.SetTooltipScripts(frame, textLabel)
		frame.tooltip_text = textLabel

		frame:SetScript("OnEnter", Show_Tooltip)
		frame:SetScript("OnLeave", Hide_Tooltip)
	end
	addon.SetTooltipScripts = private.SetTooltipScripts -- TODO: Move this somewhere more sensical.
end	-- do
