--[[
	Copyright (C) Udorn (Blackhand)
	
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.	
--]]

--[[
	The entry point of the addon.
--]]
vendor.Vendor = LibStub("AceAddon-3.0"):NewAddon("AuctionMaster", "AceConsole-3.0")
vendor.Vendor:SetDefaultModuleState(false)

local L = vendor.Locale.GetInstance()
vendor.Vendor.AceConfigDialog = LibStub("AceConfigDialog-3.0")
vendor.Vendor.AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigCmd = LibStub("AceConfigCmd-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local self = vendor.Vendor;
local log = vendor.Debug:new("Vendor")

local APP_NAME = "AuctionMaster"

--local prototype = { OnEnable = function(self) print("OnEnable called for ["..self:GetName().."]") end }
--vendor.Vendor:SetDefaultModulePrototype(prototype)

local function _CleanupDb(self)
	-- cleanup obsolete data
	if (VendorDb and VendorDb.namespaces) then
		VendorDb.namespaces.Statistics = nil
		VendorDb.namespaces.SellPrizes = nil
		VendorDb.namespaces.Scanner = nil
	end
end

--[[
	Taken from http://lua-users.org/wiki/CopyTable
--]]
local function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--[[
	Initializes the addon.
--]]
function vendor.Vendor:OnInitialize()
	log:Debug("OnInitialize")
	self.debug = vendor.Debug:new("AuctionMaster")
	-- initialize old ace2 database for migration
	self.oldDb = vendor.AceDb20:new()
	self.oldDb:RegisterDB("VendorDb")
	-- now the ace3 database
 	self.db = LibStub("AceDB-3.0"):New("VendorDb", {
 		profile = {
			useTooltips = true,
			moneyIcons = true
		},
		global = {
    		locale = "unknown",
    		checksum = "",
    		hasChargesPattern = false,
		}
	}, "Default")
	
	self.version = GetAddOnMetadata("AuctionMaster", "Version")
	log:Debug("OnInitialize exit")
end

--[[
	Enables the addon.
--]]
function vendor.Vendor:OnEnable()
	-- init Blizzard_AuctionUi
	vendor.Vendor:Debug("load auction house")
	vendor.AuctionHouse.EnsureAuctionHouseUI()
	-- remember the locale used
	self.db.global.locale = GetLocale()
	self.playerName = UnitName("player")
	_CleanupDb(self)

	-- global needed first
	self:GetModule("AuctionHouse"):Enable()
	self:GetModule("Seller"):Enable()
	for name, module in self:IterateModules() do
		if (name ~= "TooltipHook") then
			log:Debug("Enable module [%s]", name)
    		module:Enable()
    	end
	end

	-- init tabs in correct sequence
	vendor.OwnAuctions:InitTab()
	vendor.Seller:InitTab()
	vendor.SearchTab:InitTab()

	-- disable blizzard auctions tab by default
	--vendor.AuctionHouse:HideBlizzardAuctionsTab();
end

--[[
	Displays the given error message
--]]
function vendor.Vendor:Error(msg)
	self:Print(msg)
end

function vendor.Vendor:Print(msg)
	print("|cFFE2A5DC"..msg.."|r")
end

--[[
	Logs the given debug message.
--]]
function vendor.Vendor:Debug(...)
	self.debug:Debug(...)
end

function vendor.Vendor:Test(arg)
	vendor.Vendor:Debug("Test enter")
	if (1 == arg) then
		vendor.SearchTab:PickItem(vendor.Items:GetItemLink(52768))
	elseif (2 == arg) then
	end
	vendor.Vendor:Debug("Test exit")
end

--[[
	Returns an ordered table.
--]]
function vendor.Vendor:OrderTable(tbl)
	local cmds = {}
	for k,v in pairs(tbl) do
		table.insert(cmds, v)
	end
	table.sort(cmds, function(a, b) return a.order < b.order end)
	return cmds
end

function vendor.Vendor:ChatCommand(input)
	log:Debug("ChatCommand [%s]", input)
	if (input and strlen(input) > 0) then
		AceConfigCmd:HandleCommand("auctionmaster", APP_NAME, input)
	else
		AceConfigCmd:HandleCommand("auctionmaster", APP_NAME, input)
		vendor.Config:ToggleConfigDialog()
	end
--   -- Assuming "MyOptions" is the appName of a valid options table
--   if not input or input:trim() == "" then
--     LibStub("AceConfigDialog-3.0"):Open("MyOptions")
--   else
--     LibStub("AceConfigCmd-3.0").HandleCommand(MyAddon, "mychat", "MyOptions", input)
--   end
 end
