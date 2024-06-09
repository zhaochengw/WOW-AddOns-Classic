-- $Id: GatherMate2.lua 107 2020-03-08 10:43:45Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local select = _G.select
-- Libraries
local GetAddOnInfo, GetAddOnEnableState, UnitName, ToggleFrame, InterfaceOptionsFrame_OpenToCategory = _G.GetAddOnInfo, _G.GetAddOnEnableState, _G.UnitName, _G.ToggleFrame, _G.InterfaceOptionsFrame_OpenToCategory
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local MODNAME = "GatherMate2"

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local Module = addon:NewModule(MODNAME)
local db

local GM, profile, LGM
local prof_options = {}
local prof_options2 = {}
local prof_options3 = {}
local prof_options4 = {}
local filters = {}
local Config

local iGatherMate2 = select(4, GetAddOnInfo(MODNAME))
local enabled = GetAddOnEnableState(UnitName("player"), MODNAME)

local defaults = {
	profile = {
		contextMenu = true,
		showConfig = false,
	}
}

local optGetter, optSetter
do
	function optGetter(info)
		local key = info[#info]
		return Module.db.profile[key]
	end

	function optSetter(info, value)
		local key = info[#info]
		Module.db.profile[key] = value
		Module:Refresh()
	end
end

local options = {
	type = "group",
	name = L[MODNAME],
	get = optGetter,
	set = optSetter,
	args = {
		config = {
			order = 10,
			type = "group",
			name = L["Config"],
			inline = true,
			args = {
				contextMenu = {
					order = 11,
					type = "toggle",
					name = format(L["Show %s module's menu items in second level of menu."], L[MODNAME]),
					width = "full",
				},
				showConfig = {
					order = 12, 
					type = "toggle",
					name = format(L["Show %s module's config link in menu."], L[MODNAME]),
					width = "full",
				},
			},
		},
	},
}

function Module:OnInitialize()
	if (enabled > 0 and iGatherMate2) then 
		GM = LibStub("AceAddon-3.0"):GetAddon(MODNAME) 
		profile = GM.db.profile
		LGM = LibStub("AceLocale-3.0"):GetLocale(MODNAME, false)
		Config = GM:GetModule("Config")

		prof_options = {
			always          = LGM["Always show"],
			with_profession = LGM["Only with profession"],
			active          = LGM["Only while tracking"],
			never           = LGM["Never show"],
		}
		prof_options2 = { -- For Gas, which doesn't have tracking as a skill
			always           = LGM["Always show"],
			with_profession  = LGM["Only with profession"],
			never            = LGM["Never show"],
		}
		prof_options3 = {
			always          = LGM["Always show"],
			active          = LGM["Only while tracking"],
			never           = LGM["Never show"],
		}
		prof_options4 = { -- For Archaeology, which doesn't have tracking as a skill
			always           = LGM["Always show"],
			active		 = LGM["Only with digsite"],
			with_profession  = LGM["Only with profession"],
			never            = LGM["Never show"],
		}
		filters = {
			showMinerals = {
				name = LGM["Show Mining Nodes"], 
				desc = LGM["Toggle showing mining nodes."], 
				opts = prof_options, 
				arg = "Mining"
			},
			showHerbs = {
				name = LGM["Show Herbalism Nodes"], 
				desc = LGM["Toggle showing herbalism nodes."], 
				opts = prof_options, 
				arg = "Herb Gathering"
			},
			showFishes = {
				name = LGM["Show Fishing Nodes"], 
				desc = LGM["Toggle showing fishing nodes."], 
				opts = prof_options, 
				arg = "Fishing"
			},
			showGases = {
				name = LGM["Show Gas Clouds"], 
				desc = LGM["Toggle showing gas clouds."], 
				opts = prof_options2, 
				arg = "Extract Gas"
			},
			showTreasure = {
				name = LGM["Show Treasure Nodes"], 
				desc = LGM["Toggle showing treasure nodes."], 
				opts = prof_options3, 
				arg = "Treasure"
			},
			showArchaeology = {
				name = LGM["Show Archaeology Nodes"], 
				desc = LGM["Toggle showing archaeology nodes."], 
				opts = prof_options4, 
				arg = "Archaeology"
			},
			showTimber = {
				name = LGM["Show Timber Nodes"], 
				desc = LGM["Toggle showing timber nodes."], 
				opts = prof_options3, 
				arg = "Logging"
			},
		}

		self.db = addon.db:RegisterNamespace(MODNAME, defaults)
		db = self.db.profile

		self:SetEnabledState(addon:GetModuleEnabled(MODNAME))
		addon:RegisterModuleOptions(MODNAME, options, MODNAME)
	else
		addon:DisableModule(MODNAME)
	end
end

function Module:OnEnable()

end

function Module:OnDisable()

end

function Module:Refresh()
	if not self:IsEnabled() then return end
end
	
function Module:DropDownMenus()
	if (enabled > 0 and iGatherMate2) then
		local function toggleGatherMate2()
			profile.showWorldMap = not profile.showWorldMap
			GM:OnProfileChanged()
		end

		local function checkWorldMapStatus()
			return profile.showWorldMap or nil
		end

		local menu = {}
		local menu2 = {}
		local i = 1
		local j = 1
		local mode_name = L[MODNAME]
		
		menu[i] = {}
		menu[i].isNotRadio = true
		--menu[i].keepShownOnClick = true
		menu[i].hasArrow = true
		menu[i].value = MODNAME
		menu[i].colorCode = "|cFFFFC90E"
		menu[i].text = mode_name
		menu[i].tooltipTitle = LGM["Show World Map Icons"]
		menu[i].tooltipText = LGM["Toggle showing World Map icons."]
		menu[i].tooltipOnButton = true
		menu[i].func = toggleGatherMate2
		menu[i].checked = checkWorldMapStatus
		i = i + 1
		if (db.showConfig) then 
			-- Last menu item for config option
			menu[i] = {}
			menu[i].isNotRadio = true
			menu[i].notCheckable = true
			menu[i].text = L["GatherMate2 Config"]
			menu[i].colorCode = "|cFFB5E61D"
			menu[i].tooltipTitle = mode_name
			menu[i].tooltipText = L["Click to open GatherMate2's config panel"]
			menu[i].tooltipOnButton = true
			menu[i].func = (function(self)
				ToggleFrame(WorldMapFrame)
				InterfaceOptionsFrame_OpenToCategory(LGM["GatherMate 2"] or "GatherMate 2")
				InterfaceOptionsFrame_OpenToCategory(LGM["GatherMate 2"] or "GatherMate 2")
			end)
		end

		for k, v in pairs(filters) do
			menu2[j] = {}
			menu2[j].isNotRadio = true
			menu2[j].notCheckable = true
			menu2[j].hasArrow = true
			menu2[j].keepShownOnClick = true
			menu2[j].colorCode = "|cFFFFC90E"
			menu2[j].value = MODNAME..j
			menu2[j].text = v.name
			menu2[j].tooltipTitle = v.name
			menu2[j].tooltipText = v.desc
			menu2[j].tooltipOnButton = true
			if (not checkWorldMapStatus()) then
				menu2[j].disabled = true
			else
				menu2[j].disabled = nil
			end
			local menu3 = {}
			local n = 1
			for ka, va in pairs(v.opts) do
				menu3[n] = {}
				menu3[n].isNotRadio = true
				--menu2[n].keepShownOnClick = true
				menu3[n].text = va
				menu3[n].disabled = (not checkWorldMapStatus()) and true or nil
				menu3[n].checked = (function(self)
					return profile.show[v.arg] == ka and true or false
				end)
				menu3[n].func = (function(self)
					profile.show[v.arg] = ka
					Config:UpdateConfig()
				end)
				n = n + 1
			end
			menu2[j].menuTable = menu3
			j = j + 1
		end
		
		return menu, menu2
	else
		return nil
	end
end
