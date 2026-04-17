--[[
    Ackis Recipe List - Configuration
    
    Provides AceConfig-based options UI:
    - Main options (filters, exclusion list)
    - Waypoint settings (TomTom/HereBeDragons)
    - Display options (UI scale, tooltips)
    - Datamining tools (dev mode)
    - Documentation tabs
    
    Copyright (c) 2009 - 2012 Ackis <John Pasula>
    All rights reserved by the original author Ackis.
]]

-- ============================================================================
-- Upvalued Lua API
-- ============================================================================
local pairs = _G.pairs
local type = _G.type
local tonumber = _G.tonumber

local table = _G.table

-- ============================================================================
-- AddOn Namespace
-- ============================================================================
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub

local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

local AceConfigReg = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

-- ============================================================================
-- Local Variables
-- ============================================================================
local modularOptions = {}

-- ============================================================================
-- Helper Functions
-- ============================================================================

local function giveProfiles()
	return LibStub("AceDBOptions-3.0"):GetOptionsTable(addon.db)
end

--- Reset GUI position and scale to defaults
local function ResetGUI()
	local options = addon.db.profile.frameopts
	local MainPanel = addon.Frame

	options.offsetx = 0
	options.offsety = 0
	options.anchorTo = ""
	options.anchorFrom = ""
	options.uiscale = 1
	options.small_list_font = true

	if MainPanel then
		MainPanel:Hide()
		MainPanel:Show()
	end
end

-- ============================================================================
-- Main Options Builder
-- ============================================================================

local options

local function fullOptions()
	if not options then
		options = {
			type = "group",
			name = private.addon_display_name or private.addon_name,
			args = {
				general = {
					order = 1,
					type = "group",
					name = L["Main Options"],
					desc = L["MAIN_OPTIONS_DESC"],
					args = {
						version = {
							order = 11,
							type = "description",
							name = _G.GAME_VERSION_LABEL .. ": " .. addon.version .. "\n",
						},
						show_minimap_button = {
							order = 13,
							type = "toggle",
							name = L["Minimap Button"],
							desc = L["Toggle the ARL minimap button"],
							get = function()
								return not (addon.db.profile.minimapIcon and addon.db.profile.minimapIcon.hide)
							end,
							set = function()
								addon.db.profile.minimapIcon = addon.db.profile.minimapIcon or { hide = false }
								addon.db.profile.minimapIcon.hide = not addon.db.profile.minimapIcon.hide
								if addon.UpdateMinimapIcon then addon:UpdateMinimapIcon() end
							end,
						},
						spacer1 = {
							order = 12,
							type = "description",
							name = "\n",
						},
						header1 = {
							order = 15,
							type = "header",
							name = L["Main Filter Options"],
						},
						mainfilter_desc = {
							order = 20,
							type = "description",
							name = L["MAINFILTER_OPTIONS_DESC"] .. "\n",
						},
						includefiltered = {
							order = 25,
							type = "toggle",
							name = L["Include Filtered"],
							desc = L["FILTERCOUNT_DESC"],
							get = function()
								return addon.db.profile.includefiltered
							end,
							set = function()
								addon.db.profile.includefiltered = not addon.db.profile.includefiltered

								if addon.Frame and addon.Frame:IsVisible() then
									addon:Scan(false, false)
								end
							end,
						},
						includeexcluded = {
							order = 30,
							type = "toggle",
							name = L["Include Excluded"],
							desc = L["EXCLUDECOUNT_DESC"],
							get = function()
								return addon.db.profile.includeexcluded
							end,
							set = function()
								addon.db.profile.includeexcluded = not addon.db.profile.includeexcluded

								if addon.Frame and addon.Frame:IsVisible() then
									addon:Scan(false, false)
								end
							end,
						},
						exclusionlist = {
							order = 35,
							type = "execute",
							name = L["View Exclusion List"],
							desc = L["VIEW_EXCLUSION_LIST_DESC"],
							func = function(info)
								local exclusion_list = addon.db.profile.exclusionlist

								for spell_id in pairs(exclusion_list) do
									local spell_name = _G.GetSpellInfo(spell_id)

									if spell_name then
										addon:Printf("%d: %s", spell_id, spell_name)
									else
										addon:Printf("%d: **spell not found** Removing from exclusion list.", spell_id)
										exclusion_list[spell_id] = nil
									end
								end
							end,
							disabled = function(info)
								for spell_id in pairs(addon.db.profile.exclusionlist) do
									return false
								end
								return true
							end,
						},
						clearexclusionlist = {
							order = 40,
							type = "execute",
							name = L["Clear Exclusion List"],
							desc = L["CLEAR_EXCLUSION_LIST_DESC"],
							func = function(info)
								local exclusion_list = addon.db.profile.exclusionlist

								exclusion_list = table.wipe(exclusion_list)

								if addon.Frame:IsVisible() then
									addon:Scan()
								end
							end,
							disabled = function(info)
								for spell_id in pairs(addon.db.profile.exclusionlist) do
									return false
								end
								return true
							end,
						},
						spacer1 = {
							order = 45,
							type = "description",
							name = "\n",
						},
						-- Text Dump options removed (feature deprecated)
					},
				},
			},
		}

		for k, v in pairs(modularOptions) do
			options.args[k] = (type(v) == "function") and v() or v
		end
	end
	return options
end

-- ============================================================================
-- Waypoint Options
-- ============================================================================

local arlmap

local function GetMapOptions()
	local has_waypoints = _G.TomTom

	if not arlmap then
		arlmap = {
			order = 1,
			type = "group",
			name = L["Waypoints"],
			args = {
				map_desc = {
					order = 1,
					type = "description",
					name = L["MAP_OPTIONS_DESC"] .. "\n",
				},
				maptrainer = {
					order = 2,
					type = "toggle",
					name = L["Trainer"],
					desc = L["WAYPOINT_TOGGLE_FORMAT"]:format(L["Trainer"]),
					disabled = not has_waypoints,
					get = function()
						return addon.db.profile.maptrainer
					end,
					set = function()
						addon.db.profile.maptrainer = not addon.db.profile.maptrainer
					end,
				},
				mapvendor = {
					order = 3,
					type = "toggle",
					name = L["Vendor"],
					desc = L["WAYPOINT_TOGGLE_FORMAT"]:format(L["Vendor"]),
					disabled = not has_waypoints,
					get = function()
						return addon.db.profile.mapvendor
					end,
					set = function()
						addon.db.profile.mapvendor = not addon.db.profile.mapvendor
					end,
				},
				mapmob = {
					order = 4,
					type = "toggle",
					name = L["Mob Drop"],
					desc = L["WAYPOINT_TOGGLE_FORMAT"]:format(L["Mob Drop"]),
					disabled = not has_waypoints,
					get = function()
						return addon.db.profile.mapmob
					end,
					set = function()
						addon.db.profile.mapmob = not addon.db.profile.mapmob
					end,
				},
				mapquest = {
					order = 5,
					type = "toggle",
					name = L["Quest"],
					desc = L["WAYPOINT_TOGGLE_FORMAT"]:format(L["Quest"]),
					disabled = not has_waypoints,
					get = function()
						return addon.db.profile.mapquest
					end,
					set = function()
						addon.db.profile.mapquest = not addon.db.profile.mapquest
					end,
				},
				map_acquire_header = {
					order = 10,
					type = "header",
					name = "",
				},
				autoscanmap = {
					order = 11,
					type = "toggle",
					width = "full",
					name = L["Auto Scan Map"],
					desc = L["AUTOSCANMAP_DESC"],
					disabled = not has_waypoints,
					get = function()
						return addon.db.profile.autoscanmap
					end,
					set = function()
						addon.db.profile.autoscanmap = not addon.db.profile.autoscanmap
						if addon.db.profile.autoscanmap then
							addon:AutoScanZoneWaypoints()
						else
							addon:ClearWaypoints()
						end
					end,
				},
				worldmap = {
					order = 12,
					type = "toggle",
					width = "full",
					name = _G.WORLD_MAP,
					desc = L["WAYPOINT_MAP_FORMAT"]:format(_G.WORLD_MAP),
					disabled = not has_waypoints,
					get = function()
						return addon.db.profile.worldmap
					end,
					set = function()
						addon.db.profile.worldmap = not addon.db.profile.worldmap
					end,
				},
				minimap = {
					order = 13,
					type = "toggle",
					width = "full",
					name = _G.MINIMAP_LABEL,
					desc = L["WAYPOINT_MAP_FORMAT"]:format(_G.MINIMAP_LABEL),
					disabled = not has_waypoints,
					get = function()
						return addon.db.profile.minimap
					end,
					set = function()
						addon.db.profile.minimap = not addon.db.profile.minimap
					end,
				},
				clearmap = {
					order = 20,
					type = "execute",
					name = L["Clear Waypoints"],
					disabled = not has_waypoints,
					desc = L["CLEAR_WAYPOINTS_DESC"],
					func = function()
						addon:ClearWaypoints()
					end,
				},
			},
		}
	end

	return arlmap
end

-- ============================================================================
-- Datamine Options
-- ============================================================================

local datamine

local function GetDatamineOptions()
	if not datamine then
		datamine = {
			order = 1,
			type = "group",
			name = L["Datamine Options"],
			args = {
				datamine_desc = {
					order = 1,
					type = "description",
					name = L["DATAMINE_OPTIONS_DESC"] .. "\n",
				},
				datamine_warn = {
					order = 2,
					type = "description",
					name = L["DATAMINE_WARNING_DESC"] .. "\n",
				},
				scanentiredatabase = {
					order = 40,
					type = "execute",
					name = L["Scan Entire Database"],
					desc = L["SCAN_ENTIRE_DB_DESC"],
					func = function() addon:TooltipScanDatabase() end,
				},
				scanprofessiontooltip = {
					order = 60,
					type = "input",
					name = L["Scan A Profession"],
					desc = L["SCAN_PROF_DB_DESC"],
					get = false,
					set = function(info, v) addon:ScanProfession(v) end,
				},
				scanspellid = {
					order = 70,
					type = "input",
					name = L["Scan A Spell ID"],
					desc = L["SCAN_SPELL_ID_DESC"],
					get = false,
					set = function(info, v) addon:ScanTooltipRecipe(tonumber(v), false, false) end,
				},
				null2 = {
					order = 80,
					type = "description",
					name = "",
				},
				scantrainers = {
					width = "full",
					order = 90,
					type = "toggle",
					name = L["Auto Scan Trainers"],
					desc = L["AUTOSCAN_TRAINERS_DESC"],
					get = function() return addon.db.profile.scantrainers end,
					set = function()
						if addon.db.profile.scantrainers then
							addon:UnregisterEvent("TRAINER_SHOW")
						else
							addon:RegisterEvent("TRAINER_SHOW")
						end
						addon.db.profile.scantrainers = not addon.db.profile.scantrainers
					end,
				},
				scanvendors = {
					width = "full",
					order = 100,
					type = "toggle",
					name = L["Auto Scan Vendors"],
					desc = L["AUTOSCAN_VENDORS_DESC"],
					get = function() return addon.db.profile.scanvendors end,
					set = function()
						if addon.db.profile.scanvendors then
							addon:UnregisterEvent("MERCHANT_SHOW")
						else
							addon:RegisterEvent("MERCHANT_SHOW")
						end
						addon.db.profile.scanvendors = not addon.db.profile.scanvendors
					end,
				},
				autoloaddb = {
					width = "full",
					order = 110,
					type = "toggle",
					name = L["Auto Load Recipe Database"],
					desc = L["AUTOLOAD_DB_DESC"],
					get = function() return addon.db.profile.autoloaddb end,
					set = function() addon.db.profile.autoloaddb = not addon.db.profile.autoloaddb end,
				},
			},
		}
	end
	return datamine
end

-- ============================================================================
-- Documentation Options
-- ============================================================================

local documentation

local function GetDocumentation()
	if not documentation then
		documentation = {
			order = 1,
			type = "group",
			name = L["Documentation"],
			args = {
				header2 = {
					order = 1,
					type = "header",
					name = L["Using Filters"],
				},
				desc2 = {
					order = 2,
					type = "description",
					name = L["USING_FILTERS_DESC"],
				},
				header3 = {
					order = 3,
					type = "header",
					name = L["Common Issues"],
				},
				desc3 = {
					order = 4,
					type = "description",
					name = L["COMMON_ISSUES_DESC"],
				},
				header5 = {
					order = 5,
					type = "header",
					name = L["Exclusion Issues"],
				},
				desc5 = {
					order = 6,
					type = "description",
					name = L["EXCLUSION_ISSUES_DESC"],
				},
				header6 = {
					order = 7,
					type = "header",
					name = L["Map Issues"],
				},
				desc6 = {
					order = 8,
					type = "description",
					name = L["MAP_ISSUES_DESC"],
				},
				header7 = {
					order = 9,
					type = "header",
					name = L["Game Commands"],
				},
				desc7 = {
					order = 10,
					type = "description",
					name = L["GAME_COMMANDS_DESC"],
				},
			},
		}
	end
	return documentation
end

-- ============================================================================
-- Display Options
-- ============================================================================

local displayoptions

local SCAN_ANCHORS = {
	TR = L["Top Right"],
	TL = L["Top Left"],
	BR = L["Bottom Right"],
	BL = L["Bottom Left"]
}

local function GetDisplayOptions()
	if not displayoptions then
		displayoptions = {
			order = 1,
			name = _G.DISPLAY_OPTIONS,
			type = "group",
			childGroups = "tab",
			args = {
				interface_tab = {
					order = 10,
					name = _G.INTERFACE_OPTIONS,
					type = "group",
					args = {
						display_desc = {
							order = 1,
							name = L["DISPLAY_OPTIONS_DESC"] .. "\n",
							type = "description",
						},
						scanbuttonlocation = {
							order = 2,
							type = "select",
							name = L["Scan Button Position"],
							desc = L["SCANBUTTONPOSITION_DESC"],
							get = function()
								return addon.db.profile.scanbuttonlocation
							end,
							set = function(info, name)
								addon.db.profile.scanbuttonlocation = name
							end,
							values = function()
								return SCAN_ANCHORS
							end,
						},
						uiscale = {
							order = 3,
							type = "range",
							name = _G.UI_SCALE,
							desc = L["UI_SCALE_DESC"],
							min = .5,
							max = 1.5,
							step = .05,
							bigStep = .05,
							get = function()
								return addon.db.profile.frameopts.uiscale
							end,
							set = function(info, v)
								addon.db.profile.frameopts.uiscale = v
								if private.InitializeFrame then
									private.InitializeFrame()
								end
								addon.Frame:SetScale(v)
							end,
						},
						small_list_font = {
							order = 4,
							width = "full",
							type = "toggle",
							name = L["Small Font"],
							desc = L["SMALL_FONT_DESC"],
							get = function()
								return addon.db.profile.frameopts.small_list_font
							end,
							set = function(info, value)
								addon.db.profile.frameopts.small_list_font = value
								if private.InitializeFrame then
									private.InitializeFrame()
								end
								if addon.Frame:IsVisible() then
									addon:Scan()
								end
							end,
						},
						closegui = {
							width = "full",
							order = 5,
							type = "toggle",
							name = L["Close GUI"],
							desc = L["CLOSEGUI_DESC"],
							get = function()
								return addon.db.profile.closeguionskillclose
							end,
							set = function(info, value)
								addon.db.profile.closeguionskillclose = value
							end,
						},
						hidepopup = {
							width = "full",
							order = 6,
							type = "toggle",
							name = L["Hide Pop-Up"],
							desc = L["HIDEPOPUP_DESC"],
							get = function()
								return addon.db.profile.hidepopup
							end,
							set = function(info, value)
								addon.db.profile.hidepopup = value
							end,
						},
						resetguiwindow = {
							width = "double",
							order = 7,
							type = "execute",
							name = L["Reset Window Position"],
							desc = L["RESET_WINDOW_DESC"],
							func = ResetGUI,
						},
					},
				},
				tooltip_tab = {
					order = 20,
					name = L["Tooltip Options"],
					type = "group",
					args = {
						tooltip_desc = {
							order = 12,
							type = "description",
							name = L["TOOLTIP_OPTIONS_DESC"] .. "\n",
						},
						tooltip_fontsize = {
							order = 19,
							type = "range",
							name = _G.FONT_SIZE,
							desc = L["FONT_SIZE_DESC"],
							min = 6,
							max = 20,
							step = 1,
							bigStep = 1,
							get = function()
								return addon.db.profile.tooltip.acquire_fontsize
							end,
							set = function(info, v)
								addon.db.profile.tooltip.acquire_fontsize = v
							end,
						},
						tooltipscale = {
							order = 20,
							type = "range",
							name = L["Tooltip Scale"],
							desc = L["TOOLTIP_SCALE_DESC"],
							min = .5,
							max = 1.5,
							step = .05,
							bigStep = .05,
							get = function()
								return addon.db.profile.tooltip.scale
							end,
							set = function(info, v)
								addon.db.profile.tooltip.scale = v
							end,
						},
						acquiretooltiplocation = {
							order = 21,
							type = "select",
							name = L["Tooltip (Acquire) Position"],
							desc = L["ACQUIRETOOLTIPPOSITION_DESC"],
							get = function()
								return addon.db.profile.acquiretooltiplocation
							end,
							set = function(info, name)
								addon.db.profile.acquiretooltiplocation = name
							end,
							values = function()
								return {
									Right = L["Right"],
									Left = L["Left"],
									Top = L["Top"],
									Bottom = L["Bottom"],
									Off = _G.OFF,
									Mouse = _G.MOUSE_LABEL
								}
							end,
						},
						spelltooltiplocation = {
							order = 22,
							type = "select",
							name = L["Tooltip (Recipe) Position"],
							desc = L["SPELLTOOLTIPPOSITION_DESC"],
							get = function()
								return addon.db.profile.spelltooltiplocation
							end,
							set = function(info, name)
								addon.db.profile.spelltooltiplocation = name
							end,
							values = function()
								return {
									Right = L["Right"],
									Left = L["Left"],
									Top = L["Top"],
									Bottom = L["Bottom"],
									Off = _G.OFF
								}
							end,
						},
						spacer1 = {
							order = 23,
							type = "description",
							name = "\n",
						},
						unit_tooltip = {
							order = 24,
							type = "toggle",
							name = L["Recipes In Tooltips"],
							desc = L["UNIT_TOOLTIPS_DESC"],
							get = function()
								return addon.db.profile.recipes_in_tooltips
							end,
							set = function(info, value)
								addon.db.profile.recipes_in_tooltips = value
							end,
						},
						unit_max_tooltip = {
							order = 25,
							type = "range",
							name = _G.MAXIMUM,
							desc = L["UNIT_MAX_TOOLTIPS_DESC"],
							min = 1,
							max = 50,
							step = 1,
							bigStep = 5,
							disabled = function()
								return not addon.db.profile.recipes_in_tooltips
							end,
							get = function()
								return addon.db.profile.max_recipes_in_tooltips
							end,
							set = function(info, v)
								addon.db.profile.max_recipes_in_tooltips = v
							end,
						},
						tooltip_hint = {
							order = 26,
							type = "toggle",
							name = L["TOOLTIP_HINT"],
							desc = L["TOOLTIP_HINT_DESC"],
							get = function()
								return addon.db.profile.hide_tooltip_hint
							end,
							set = function(info, value)
								addon.db.profile.hide_tooltip_hint = value
							end,
						},
					},
				},
			},
		}
	end
	return displayoptions
end

-- ============================================================================
-- Options Registration
-- ============================================================================

function addon:SetupOptions()
	AceConfigReg:RegisterOptionsTable(private.addon_name, fullOptions)
	self.optionsFrame = AceConfigDialog:AddToBlizOptions(private.addon_name, private.addon_display_name or private.addon_name, nil, "general")

	-- Register module options
	self:RegisterModuleOptions("Display", GetDisplayOptions(), _G.DISPLAY_OPTIONS)

	if _G.TomTom then
		self:RegisterModuleOptions("Waypoint", GetMapOptions(), L["Waypoints"])
	end

	if addon.version == "Devel" then
		self:RegisterModuleOptions("Datamining", GetDatamineOptions(), L["Datamine Options"])
	else
		addon.db.profile.scantrainers = false
		addon.db.profile.scanvendors = false
		addon.db.profile.autoloaddb = false
	end

	self:RegisterModuleOptions("Documentation", GetDocumentation(), L["Documentation"])
	self:RegisterModuleOptions("Profiles", giveProfiles(), L["Profile Options"])
end

--- Register a module options table
--- @param name string The options table key
--- @param optionsTable table The options table or function returning one
--- @param displayName string The display name in config UI
function addon:RegisterModuleOptions(name, optionsTable, displayName)
	modularOptions[name] = optionsTable
	self.optionsFrame[name] = AceConfigDialog:AddToBlizOptions(private.addon_name, displayName, private.addon_display_name or private.addon_name, name)
end
