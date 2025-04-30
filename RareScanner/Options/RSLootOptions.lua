-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)
local LibDialog = LibStub("LibDialog-1.0")

local RSLootOptions = private.NewLib("RareScannerLootOptions")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSCollectionsDB  = private.ImportLib("RareScannerCollectionsDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSLogger = private.ImportLib("RareScannerLogger")

-- RareScanner service libraries
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSMap = private.ImportLib("RareScannerMap")

local options

-----------------------------------------------------------------------
-- Item qualities
-----------------------------------------------------------------------

private.ITEM_QUALITY = {
	[Enum.ItemQuality.Poor] = ITEM_QUALITY0_DESC,
	[Enum.ItemQuality.Standard] = ITEM_QUALITY1_DESC,
	[Enum.ItemQuality.Good] = ITEM_QUALITY2_DESC,
	[Enum.ItemQuality.Rare] = ITEM_QUALITY3_DESC,
	[Enum.ItemQuality.Epic] = ITEM_QUALITY4_DESC,
	[Enum.ItemQuality.Legendary] = ITEM_QUALITY5_DESC,
	[Enum.ItemQuality.Artifact] = ITEM_QUALITY6_DESC,
	[Enum.ItemQuality.Heirloom] = ITEM_QUALITY7_DESC,
}

-----------------------------------------------------------------------
-- Item classes
-----------------------------------------------------------------------

local SPEAR_ID = 17 --CHECK (none uses it)

private.ITEM_CLASSES = {
	[Enum.ItemClass.Consumable] = { 0, 1, 2, 3, 4, 5, 7, 8 }, --consumables
	[Enum.ItemClass.Container] = { 0, 1, 2, 3, 4, 5, 6, 7 }, --bags
	[Enum.ItemClass.Weapon] = { Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Bearclaw, Enum.ItemWeaponSubclass.Catclaw, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Generic, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Thrown, SPEAR_ID, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Wand, Enum.ItemWeaponSubclass.Fishingpole }, --weapons
	[Enum.ItemClass.Gem] = { 0, 1, 2, 3, 4, 5, 6, 7, 8 }, --gemes
	[Enum.ItemClass.Armor] = { Enum.ItemArmorSubclass.Generic, Enum.ItemArmorSubclass.Cloth, Enum.ItemArmorSubclass.Leather, Enum.ItemArmorSubclass.Mail, Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Cosmetic, Enum.ItemArmorSubclass.Shield, Enum.ItemArmorSubclass.Libram, Enum.ItemArmorSubclass.Idol, Enum.ItemArmorSubclass.Totem }, --armor
	[Enum.ItemClass.Reagent] = { 0 }, --consumable
	[Enum.ItemClass.Projectile] = { 2, 3 }, --projectile
	[Enum.ItemClass.Tradegoods] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 }, --tradeables
	[Enum.ItemClass.Recipe] = { Enum.ItemRecipeSubclass.Book, Enum.ItemRecipeSubclass.Leatherworking, Enum.ItemRecipeSubclass.Tailoring, Enum.ItemRecipeSubclass.Engineering, Enum.ItemRecipeSubclass.Blacksmithing, Enum.ItemRecipeSubclass.Cooking, Enum.ItemRecipeSubclass.Alchemy, Enum.ItemRecipeSubclass.FirstAid, Enum.ItemRecipeSubclass.Enchanting, Enum.ItemRecipeSubclass.Fishing, Enum.ItemRecipeSubclass.Jewelcrafting }, --recipes
	[Enum.ItemClass.Questitem] = { 0 }, --quests
	[Enum.ItemClass.Key] = { 0, 1 }, --keys
	[Enum.ItemClass.Miscellaneous] = { Enum.ItemMiscellaneousSubclass.Junk, Enum.ItemMiscellaneousSubclass.Reagent, Enum.ItemMiscellaneousSubclass.CompanionPet, Enum.ItemMiscellaneousSubclass.Holiday, Enum.ItemMiscellaneousSubclass.Other, Enum.ItemMiscellaneousSubclass.Mount }, --miscellaneous
}

-----------------------------------------------------------------------
-- Functions
-----------------------------------------------------------------------

local main_categories

local function GetMainCategories()
	if (not main_categories) then
		main_categories = {}
		
		for k, v in pairs(private.ITEM_CLASSES) do
			main_categories[k] = GetItemClassInfo(k)
		end
	end
	
	return main_categories
end

local function LoadSubcategoryCombo(mainClassID)
	options.args.filters.args.category_filters.args.lootFilters.values = {}
	for _, subcategoryID in ipairs(private.ITEM_CLASSES[mainClassID]) do
		options.args.filters.args.category_filters.args.lootFilters.values[subcategoryID] = GetItemSubClassInfo(mainClassID, subcategoryID)
	end
end

local function LoadFilteredItems()
	for itemID, _ in pairs(RSConfigDB.GetAllFilteredItems()) do
		local item = Item:CreateFromItemID(itemID)
		item:ContinueOnItemLoad(function()
			local itemLink = item:GetItemLink()
			if (itemLink) then
				options.args.filters.args.individual.args.filteredItems.values[itemID] = itemLink
			end
		end)
	end
end

local function SearchItem(name)
	if (name) then
		for itemID, _ in pairs(RSConfigDB.GetAllFilteredItems()) do
			local item = Item:CreateFromItemID(itemID)
			item:ContinueOnItemLoad(function()
				local itemName = item:GetItemName()
				local itemLink = item:GetItemLink()
				if (itemName and RSUtils.Contains(itemName,name) and itemLink) then
					options.args.filters.args.individual.args.filteredItems.values[itemID] = itemLink
				end
			end)
		end
	else
		LoadFilteredItems()
	end
end

-----------------------------------------------------------------------
-- Options tab: Display
-----------------------------------------------------------------------

function RSLootOptions.GetLootOptions()	
	if (not options) then
		private.loot_toggle_all = true
		private.loot_main_category_ID = nil
		
		options = {
			type = "group",
			name = AL["LOOT_OPTIONS"],
			handler = RareScanner,
			desc = AL["LOOT_OPTIONS"],
			args = {
				displayLoot = {
					order = 0,
					type = "toggle",
					name = AL["DISPLAY_LOOT_PANEL"],
					desc = AL["DISPLAY_LOOT_PANEL_DESC"],
					get = function() return RSConfigDB.IsDisplayingLootBar() end,
					set = function(_, value)
						RSConfigDB.SetDisplayingLootBar(value)
					end,
					width = "full",
				},
				display_options = {
					type = "group",
					order = 1,
					name = AL["LOOT_DISPLAY_OPTIONS"],
					handler = RareScanner,
					desc = AL["LOOT_DISPLAY_OPTIONS_DESC"],
					args = {
						lootTooltipPosition = {
							order = 0,
							type = "select",
							name = AL["LOOT_TOOLTIP_POSITION"],
							desc = AL["LOOT_TOOLTIP_POSITION_DESC"],
							values = private.TOOLTIP_POSITIONS,
							get = function() return RSConfigDB:GetLootTooltipPosition() end,
							set = function(_, value)
								RSConfigDB:SetLootTooltipPosition(value)
							end,
							width = "double",
							disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
						},
						itemsToShow = {
							order = 1,
							type = "range",
							name = AL["LOOT_MAX_ITEMS"],
							desc = AL["LOOT_MAX_ITEMS_DESC"],
							min	= 1,
							max	= 30,
							step	= 1,
							bigStep = 1,
							get = function() return RSConfigDB.GetMaxNumItemsToShow() end,
							set = function(_, value)
								RSConfigDB.SetMaxNumItemsToShow(value)
							end,
							width = "full",
							disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
						},
						itemsPerRow = {
							order = 2,
							type = "range",
							name = AL["LOOT_ITEMS_PER_ROW"],
							desc = AL["LOOT_ITEMS_PER_ROW_DESC"],
							min	= 1,
							max	= 30,
							step	= 1,
							bigStep = 1,
							get = function() return RSConfigDB.GetNumItemsPerRow() end,
							set = function(_, value)
								RSConfigDB.SetNumItemsPerRow(value)
							end,
							width = "full",
							disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
						}
					},
				},
				tooltips = {
					type = "group",
					order = 2,
					name = AL["MAP_TOOLTIPS"],
					handler = RareScanner,
					desc = AL["MAP_TOOLTIPS"],
					args = {
						commands = {
							order = 0,
							type = "toggle",
							name = AL["MAP_TOOLTIPS_COMMANDS"],
							desc = AL["MAP_TOOLTIPS_COMMANDS_DESC"],
							get = function() return RSConfigDB.IsShowingLootTooltipsCommands() end,
							set = function(_, value)
								RSConfigDB.SetShowingLootTooltipsCommands(value)
							end,
							width = "full",
							disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
						}
					},
					disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
				},
				filters = {
					type = "group",
					order = 3,
					name = AL["LOOT_FILTERS"],
					handler = RareScanner,
					desc = AL["LOOT_FILTERS_DESC"],
					args = {
						separator_explorer = {
							order = 0,
							type = "header",
							name = AL["LOOT_EXPLORER"],
						},
						filter_explorer_desc = {
							order = 1,
							type = "description",
							name = AL["LOOT_EXPLORER_FILTER_LONG_DESC"]
						},
						filter_explorer = {
							order = 2,
							type = "toggle",
							name = AL["LOOT_EXPLORER_FILTER"],
							desc = AL["LOOT_EXPLORER_FILTER_DESC"],
							get = function() return RSConfigDB.IsFilteringByExplorerResults() end,
							set = function(_, value)
								if (value and RSUtils.GetTableLength(RSCollectionsDB.GetAllEntitiesCollectionsLoot()) == 0) then
									LibDialog:Spawn(RSConstants.EXPLORER_SCAN_NOT_DONE)
								else
									RSConfigDB.SetFilteringByExplorerResults(value)
								end
							end,
							width = "full"
						},
						show_mounts = {
							order = 3,
							type = "toggle",
							name = AL["LOOT_EXPLORER_SHOW_MISSING_MOUNTS"],
							desc = AL["LOOT_EXPLORER_SHOW_MISSING_MOUNTS_DESC"],
							get = function() return RSConfigDB.IsShowingMissingMounts() end,
							set = function(_, value)
								RSConfigDB.SetShowingMissingMounts(value)
							end,
							width = "full",
							disabled = function() return (not RSConfigDB.IsFilteringByExplorerResults()) end,
						},
						show_pets = {
							order = 4,
							type = "toggle",
							name = AL["LOOT_EXPLORER_SHOW_MISSING_PETS"],
							desc = AL["LOOT_EXPLORER_SHOW_MISSING_PETS_DESC"],
							get = function() return RSConfigDB.IsShowingMissingPets() end,
							set = function(_, value)
								RSConfigDB.SetShowingMissingPets(value)
							end,
							width = "full",
							disabled = function() return (not RSConfigDB.IsFilteringByExplorerResults()) end,
						},
						show_toys = {
							order = 5,
							type = "toggle",
							name = AL["LOOT_EXPLORER_SHOW_MISSING_TOYS"],
							desc = AL["LOOT_EXPLORER_SHOW_MISSING_TOYS_DESC"],
							get = function() return RSConfigDB.IsShowingMissingToys() end,
							set = function(_, value)
								RSConfigDB.SetShowingMissingToys(value)
							end,
							width = "full",
							disabled = function() return (not RSConfigDB.IsFilteringByExplorerResults()) end,
						},
						open_explorer = {
							order = 6,
							name = AL["LOOT_EXPLORER_OPEN"],
							desc = AL["LOOT_EXPLORER_OPEN"],
							type = "execute",
							func = function() 
								RSExplorerFrame:Show()
							end,
							width = "normal",
						},
						separator_reset = {
							order = 7,
							type = "header",
							name = AL["LOOT_RESET"],
						},
						reset = {
							order = 8,
							name = AL["LOOT_RESET"],
							desc = AL["LOOT_RESET_DESC"],
							type = "execute",
							func = function() 
								RSConfigDB.ResetLootFilters() 
								RSLogger:PrintMessage(AL["LOOT_RESET_DONE"])
							end,
							width = "normal",
						},
						category_filters = {
							type = "group",
							order = 9,
							name = AL["LOOT_CATEGORY_FILTERS"],
							handler = RareScanner,
							desc = AL["LOOT_CATEGORY_FILTERS_DESC"],
							args = {
								categories = {
									order = 0,
									type = "select",
									name = AL["LOOT_MAIN_CATEGORY"],
									desc = AL["LOOT_MAIN_CATEGORY"],
									values = GetMainCategories(),
									get = function(_, key)
										-- initialize
										if (not private.loot_main_category_ID) then
											private.loot_main_category_ID = 0
											LoadSubcategoryCombo(private.loot_main_category_ID)
										end
		
										return private.loot_main_category_ID
									end,
									set = function(_, key, value)
										private.loot_main_category_ID = key
		
										-- load subcategory combo
										LoadSubcategoryCombo(key)
									end,
									width = "normal",
									disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
								},
								separator = {
									order = 1,
									type = "header",
									name = AL["LOOT_SUBCATEGORY_FILTERS"],
								},
								lootFiltersToogleAll = {
									order = 2,
									name = AL["TOGGLE_FILTERS"],
									desc = AL["TOGGLE_FILTERS_DESC"],
									type = "execute",
									func = function()
										if (private.loot_toggle_all) then
											private.loot_toggle_all = false
										else
											private.loot_toggle_all = true
										end
		
										for _, v in pairs(options.args.filters.args.category_filters.args.lootFilters.values) do
											RSConfigDB.SetLootFilterByCategory(private.loot_main_category_ID, v, private.loot_toggle_all)
										end
									end,
									width = "full",
									disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
								},
								lootFilters = {
									order = 3,
									type = "multiselect",
									name = AL["LOOT_FILTER_SUBCATEGORY_LIST"],
									desc = AL["LOOT_FILTER_SUBCATEGORY_DESC"],
									values = {},
									get = function(_, key) return RSConfigDB.GetLootFilterByCategory(private.loot_main_category_ID, key) end,
									set = function(_, key, value)
										RSLogger:PrintDebugMessage(string.format("Cambiando el valor de ClassID [%s], SubClassID [%s]", private.loot_main_category_ID, key))
										RSConfigDB.SetLootFilterByCategory(private.loot_main_category_ID, key, value);
									end,
									disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
								}
							},
						},
						individual = {
							type = "group",
							order = 10,
							name = AL["LOOT_INDIVIDUAL_FILTERS"],
							handler = RareScanner,
							desc = AL["LOOT_INDIVIDUAL_FILTERS_DESC"],
							args = {
								search = {
									order = 0,
									type = "input",
									name = AL["FILTERS_SEARCH"],
									desc = AL["LOOT_SEARCH_ITEMS_DESC"],
									get = function(_, value) return private.loot_individual_filter_input end,
									set = function(_, value)
										private.loot_individual_filter_input = value
										-- search
										options.args.filters.args.individual.args.filteredItems.values = {}
										SearchItem(value)
									end,
									width = "full",
									disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
								},
								filteredItems = {
									order = 1,
									type = "multiselect",
									name = AL["LOOT_FILTER_ITEM_LIST"],
									desc = nil,
									values = {},
									get = function(_, itemID) return RSConfigDB.GetItemFiltered(itemID) end,
									set = function(_, itemID, value)
										RSConfigDB.SetItemFiltered(itemID, value)
									end,
									disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
								}
							}
						},
						other_filters = {
							type = "group",
							order = 11,
							name = AL["LOOT_OTHER_FILTERS"],
							handler = RareScanner,
							desc = AL["LOOT_OTHER_FILTERS_DESC"],
							args = {
								lootMinQuality = {
									order = 0,
									type = "select",
									name = AL["LOOT_MIN_QUALITY"],
									desc = AL["LOOT_MIN_QUALITY_DESC"],
									values = private.ITEM_QUALITY,
									get = function() return RSConfigDB.GetLootFilterMinQuality() end,
									set = function(_, value)
										RSConfigDB.SetLootFilterMinQuality(value)
									end,
									width = "double",
									disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
								},
								filterNotEquipableItems = {
									order = 1,
									type = "toggle",
									name = AL["LOOT_FILTER_NOT_EQUIPABLE"],
									desc = AL["LOOT_FILTER_NOT_EQUIPABLE_DESC"],
									get = function() return RSConfigDB.IsFilteringLootByNotEquipableItems() end,
									set = function(_, value)
										RSConfigDB.SetFilteringLootByNotEquipableItems(value)
									end,
									width = "full",
									disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
								},
								filterItemsCompletedQuest = {
									order = 2,
									type = "toggle",
									name = AL["LOOT_FILTER_COMPLETED_QUEST"],
									desc = AL["LOOT_FILTER_COMPLETED_QUEST_DESC"],
									get = function() return RSConfigDB.IsFilteringLootByCompletedQuest() end,
									set = function(_, value)
										RSConfigDB.SetFilteringLootByCompletedQuest(value)
									end,
									width = "full",
									disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
								},
								filterNotMatchingClass = {
									order = 3,
									type = "toggle",
									name = AL["LOOT_FILTER_NOT_MATCHING_CLASS"],
									desc = AL["LOOT_FILTER_NOT_MATCHING_CLASS_DESC"],
									get = function() return RSConfigDB.IsFilteringLootByNotMatchingClass() end,
									set = function(_, value)
										RSConfigDB.SetFilteringLootByNotMatchingClass(value)
									end,
									width = "full",
									disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
								},
								filterNotMatchingFaction = {
									order = 4,
									type = "toggle",
									name = AL["LOOT_FILTER_NOT_MATCHING_FACTION"],
									desc = AL["LOOT_FILTER_NOT_MATCHING_FACTION_DESC"],
									get = function() return RSConfigDB.IsFilteringLootByNotMatchingFaction() end,
									set = function(_, value)
										RSConfigDB.SetFilteringLootByNotMatchingFaction(value)
									end,
									width = "full",
									disabled = function() return (not RSConfigDB.IsDisplayingLootBar() and not RSConfigDB.IsShowingLootOnWorldMap()) end,
								},
							},
						},
					},
				},
			},
		}
	end
		
	-- Load filtered items
	LoadFilteredItems()

	return options
end