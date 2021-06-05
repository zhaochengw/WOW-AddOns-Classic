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

vendor.Config = vendor.Vendor:NewModule("Config", "AceEvent-3.0")
local L = vendor.Locale.GetInstance()

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

local log = vendor.Debug:new("Config")

local APP_NAME = "AuctionMaster"

local self = vendor.Config

--[[
	"Reset" popup
--]]
StaticPopupDialogs["VENDOR_RESET_DIALOG"] = {
	text = L["Do you really want to reset the AuctionMaster database? All data gathered will be lost!"],
	button1 = L["Yes"],
  	button2 = L["No"],
  	OnAccept = function()
		vendor.Vendor.db:ResetDB("Default")
		ReloadUI()
  	end,
  	timeout = 0,
  	whileDead = 1,
  	hideOnEscape = 1
}

vendor.Config.DEFAULT_CONFIG = {
	profile = {
	}
}

local function _NextOrder()
	local order = self.nextOrder or 1
	self.nextOrder = order + 1
	return order
end

local function _UpdateMain()
	if (vendor.Vendor.db.profile.dev) then
		self.opts.args.main.args.debug.guiHidden = nil
		self.opts.args.main.args.debug.cmdHidden = nil
	else
		self.opts.args.main.args.debug.guiHidden = true
		self.opts.args.main.args.debug.cmdHidden = true
	end
end

local function _UpdateTooltip()
	local hidden = not vendor.TooltipHook.db.profile.isActive
	self.opts.args.view.args.showLabel.disabled = hidden
	self.opts.args.view.args.adjustCurrentPrices.disabled = hidden
	self.opts.args.view.args.showLower.disabled = hidden
	self.opts.args.view.args.showMedian.disabled = hidden
	self.opts.args.view.args.showDisenchant.disabled = hidden
	self.opts.args.view.args.compactMarketPrice.disabled = hidden
	self.opts.args.view.args.compactColor.disabled = hidden
	if (hidden) then
		vendor.Vendor:GetModule("TooltipHook"):Disable()
	else
		vendor.Vendor:GetModule("TooltipHook"):Enable()
	end
end

local function _MainOpts()
	return {
		type = "group",
		name = L["Main"],
		order = _NextOrder(),
		args = {
			startTabDesc = {
				type = "description",
				name = L["Tab to be selected when opening the auction house."],
				order = _NextOrder()
			},
			startTab = {
				type = "select",
				name = "",
				get = function() return vendor.AuctionHouse.db.profile.startTab end,
				set = function(info, value) vendor.AuctionHouse.db.profile.startTab = value end,
				values = {L["Browse"], L["Bids"], L["Auctions"], L["Sell"], L["Scanner"]},
				order = _NextOrder()
			},
			minQualityDesc = {
				type = "description",
				name = "\n"..L["Selects the minimum quality for items to be scanned in the auction house."],
				order = _NextOrder()
			},
			minQuality = {
				type = "select",
				name = "",
				desc = L["Selects the minimum quality for items to be scanned in the auction house."],
				get = function() return vendor.Scanner.db.profile.minQuality + 1 end,
				set = function(info, value) vendor.Scanner.db.profile.minQuality = value - 1 end,
				values = {vendor.Scanner.QUALITY_INDEX[0], vendor.Scanner.QUALITY_INDEX[1], vendor.Scanner.QUALITY_INDEX[2], vendor.Scanner.QUALITY_INDEX[3], vendor.Scanner.QUALITY_INDEX[4], vendor.Scanner.QUALITY_INDEX[5], vendor.Scanner.QUALITY_INDEX[6]},
				order = _NextOrder()
			},
			newLine1 = {
				type = "description",
				name = "\n",
				order = _NextOrder()
			},
			vspace = {
				type = "description",
				name = "\n\n",
				order = _NextOrder()
			},
			helpDesc = {
				type = "description",
				name = L["Opens the documentation for AuctionsMaster."],
				order = _NextOrder()
			},
			help = {
				type = "execute",
				name = L["Help"],
				func = function()
					vendor.Help:Show(vendor.Help.DOCUMENTATION)
				end,
				order = _NextOrder()
			},
			releaseNotesDesc = {
				type = "description",
				name = L["Shows the release notes for AuctionsMaster."],
				order = _NextOrder()
			},
			releaseNotes = {
				type = "execute",
				name = L["Release notes"],
				func = function()
					vendor.Help:Show(vendor.Help.RELEASES_4X)
				end,
				order = _NextOrder()
			},
			resetDesc = {
				type = "description",
				name = L["Resets the complete database of AuctionMaster. This will set everything to it's default values. The GUI will be restarted for refreshing all modules of AuctionMaster."],
				order = _NextOrder()
			},
			reset = {
				type = "execute",
				name = L["Reset database"],
				func = function() StaticPopup_Show("VENDOR_RESET_DIALOG") end,
				order = _NextOrder()
			},
			conf = {
				type = "execute",
				name = L["Configuration"],
				desc = L["Opens a configuration window."],
				guiHidden = true,
				func = function() self:ToggleConfigDialog() end,
				order = _NextOrder()
			},
			dev = {
				type = "toggle",
				name = "Devmode",
				desc = "Activates the developer mode",
				guiHidden = true,
				get = function() return vendor.Vendor.db.profile.dev end,
				set = function(info, value) 
					vendor.Vendor.db.profile.dev = value;
					if (vendor.Vendor.db.profile.dev) then
						vendor.Vendor:Print("Activated dev mode")
					else
						vendor.Vendor:Print("Deactivated dev mode")
					end 
					_UpdateMain() 
				end,
				order = _NextOrder()
			},
			debug = vendor.Debug.GetOptions(),
		}
	}
end

local function _StatisticOpts()
	return {
		type = "group",
		name = L["Statistics"],
		order = _NextOrder(),
		args = {
			movAvgDesc = {
				type = "description",
				name = L["Selects the number of (approximated) values, that should be taken for the moving average of the historically auction scan statistics."],
				order = _NextOrder(),
			},
			movAvg = {
				type = "range",
				name = "",
				min = 2,
				max = 256,
				step = 1,
				get = function() return vendor.Statistic.db.profile.movingAverage end,
				set = function(info, value) vendor.Statistic.db.profile.movingAverage = value end,
				order = _NextOrder(),
			},
			smallerStdDevMulDesc = {
				type = "description",
				name = L["Selects the standard deviation multiplicator for statistical values to be removed, which are smaller than the average. The larger the multiplicator is selected, the lesser values are removed from the average calculation."],
				order = _NextOrder(),
			},
			smallerStdDevMul = {
				type = "range",
				name = "",			
				min = 1,
				max = 10,
				step = 0.1,
				get = function() return vendor.Statistic.db.profile.smallerStdDevMul end,
				set = function(info, value) vendor.Statistic.db.profile.smallerStdDevMul = value end,
				order = _NextOrder(),
			},
			largerStdDevMulDesc = {
				type = "description",
				name = L["Selects the standard deviation multiplicator for statistical values to be removed, which are larger than the average. The larger the multiplicator is selected, the lesser values are removed from the average calculation."],
				order = _NextOrder(),
			},
			largerStdDevMul = {
				type = "range",
				name = "",
				min = 1,
				max = 10,
				step = 0.1,
				get = function() return vendor.Statistic.db.profile.largerStdDevMul end,
				set = function(info, value) vendor.Statistic.db.profile.largerStdDevMul = value end,
				order = _NextOrder(),
			}
		}			
	}
end

local function _UpdateSeller()
	if (vendor.Seller.db.profile.bidCalc) then
		self.opts.args.seller.args.bidMul.disabled = true
	else
		self.opts.args.seller.args.bidMul.disabled = nil
	end
 	vendor.Seller:UpdateConfig()
end

local function _SellerOpts()
	return {
		type = "group",
		name = L["Selling"],
		order = _NextOrder(),
		args = {
			editDesc = {
				type = "description",
				order = _NextOrder(),
				name = L["Many of the selling settings has to be given by pressing \"Edit\" in the sell tab. Here are only a few general settings left over."],
			},
        	pickupByClick = {
	        	type = "toggle",
	        	name = L["Pickup by click"],
	        	desc = L["Pickup items to be soled, when they are shift left clicked."],
				get = function() return vendor.Seller.db.profile.pickupByClick end,
				set = function(info, value) vendor.Seller.db.profile.pickupByClick = value; _UpdateSeller(info, value) end,
	        	order = _NextOrder(),
        	},
        	bidType = {
	        	type = "select",
	        	name = L["Bid type"],
	        	desc = L["Selects which prices should be shown in the bid and buyout input fields."],
				get = function() return vendor.Seller.db.profile.bidType end,
				set = function(info, value) vendor.Seller.db.profile.bidType = value; _UpdateSeller() end,
	        	values = vendor.Seller.BID_TYPES, 
	        	order = _NextOrder(),
        	},
        	bidCalcDesc = {
	        	type = "description",
	        	order = _NextOrder(),
	        	name = L["Should the starting price be calculated? Otherwise it is dependant from the buyout price."],
        	},
        	bidCalc = {
	        	type = "toggle",
	        	name = L["Calculate starting price"],
	        	desc = L["Should the starting price be calculated? Otherwise it is dependant from the buyout price."],
				get = function() return vendor.Seller.db.profile.bidCalc end,
				set = function(info, value) vendor.Seller.db.profile.bidCalc = value; _UpdateSeller(info, value) end,
	        	order = _NextOrder(),
        	},																		
        	bidMul = {
	        	type = "range",
	        	name = L["Bid multiplier"],
	        	desc = L["Selects the percentage of the buyout price the bid value should be set to. A value of 100 will set it to the equal value as the buyout price. It will never fall under blizzard's suggested starting price, which is based on the vendor selling value of the item."],
	        	min = 1,
	        	max = 100,
	        	step = 1,
				get = function() return vendor.Seller.db.profile.bidMul end,
				set = function(info, value) vendor.Seller.db.profile.bidMul = value; _UpdateSeller(info, value) end,
	        	order = _NextOrder(),
        	},
			autoMode ={
				type = "group",
				name = L["Auto selling"],
				desc = L["Settings for automatically selecting the best fitting price model."],
				order = _NextOrder(),
				inline = true,
				args = {
					aboveMarketThreshold = {
						type = "range",
						name = L["Upper market threshold"],
						desc = L["Minimal needed percentage of buyouts compared to market price, until they are assumed to be considerably above the market price."],
						min = 101,
						max = 500,
						step = 1,
						get = function() return vendor.Seller.db.profile.upperMarketThreshold end,
						set = function(info, value) vendor.Seller.db.profile.upperMarketThreshold = value; _UpdateSeller(info, value) end,
						order = _NextOrder(),
					},
					underMarketThreshold = {
						type = "range",
						name = L["Lower market threshold"],
						desc = L["Maximal allowed percentage of buyouts compared to market price, until they are assumed to be considerably under the market price."],
						min = 1,
						max = 99,
						step = 1,
						get = function() return vendor.Seller.db.profile.lowerMarketThreshold end,
						set = function(info, value) vendor.Seller.db.profile.lowerMarketThreshold = value; _UpdateSeller(info, value) end,
						order = _NextOrder(),
					}
				}
	        }
		}
	}
end

local function _DisenchantOpts()
	return {
		type = "group",
		name = L["Disenchant"],
		order = _NextOrder(),
		args = {
			editDesc = {
				type = "description",
				order = _NextOrder(),
				name = L["The database with disenchanting information should be edited by experienced users only. Normally this data should be left untouched."],
			},
			advanced = {
				type = "toggle",
				order = _NextOrder(),
				name = L["Advanced"],
				desc = L["Offers the ability to edit the disenchanting database. Should only be used by experts!"],
				get = function() return vendor.Disenchant.db.profile.advanced end,
				set = function(info, value) vendor.Disenchant.db.profile.advanced = value  end
			},
			reset = {
				type = "execute",
				order = _NextOrder(),
				name = L["Reset to default"],
				desc = L["Resets the disenchant database to it's default state."],
				func = function() vendor.Disenchant:ResetData() end
			},
        	data = {
	        	type = "input",
	        	name = L["Disenchant database"],
	        	desc = L["Database with disenchant information. The format is described inline."],
	        	multiline = 25,
	        	width = "full",
	        	hidden = function() return not vendor.Disenchant.db.profile.advanced end,
				get = function() return vendor.Disenchant.db.profile.data end,
				set = function(info, value) vendor.Disenchant.db.profile.data = value; vendor.Disenchant:UpdateData() end,
	        	order = _NextOrder(),
        	}
        }
	}
end

local function _ViewOpts()
	return {
		type = "group",
		name = L["View"],
		order = _NextOrder(),
		args = {
			general = {
				type = "header",
				name = L["General"],
				order = _NextOrder(),
			},
			moneyIcons = {
				type = "toggle",
				name = L["Coin icons"],
				desc = L["Show coin icons when displaying prices"],
				get = function() return vendor.Vendor.db.profile.moneyIcons end,
				set = function(info, value) vendor.Vendor.db.profile.moneyIcons = value end,
				order = _NextOrder(),
			},
			misc = {
				type = "header",
				name = L["Tooltip"],
				order = _NextOrder(),
			},
			tooltipDesc = {
				type = "description",
				name = L["Shows auction statistics in item tooltips in the format: Type [Number of auctions](Stacksize) Single value (Stack value)"],
				order = _NextOrder(),
			},
			isActive = {
				type = "toggle",
				name = L["Activated"],
				desc = L["Selects whether any informations from AuctionMaster should be shown in the GameTooltip."],
				get = function() return vendor.TooltipHook.db.profile.isActive end,
				set = function(info, value) vendor.TooltipHook.db.profile.isActive = value; _UpdateTooltip() end,
				order = _NextOrder(),
			},
			newLine = {
				type = "description",
				name = "",
				order = _NextOrder(),
			},
			showLabel = {
				type = "toggle",
				name = L["AuctionMaster label"],
				desc = L["Selects whether the AuctionMaster label should be shown in the GameTooltip."],
				get = function() return vendor.TooltipHook.db.profile.showLabel end,
				set = function(info, value) vendor.TooltipHook.db.profile.showLabel = value end,
				order = _NextOrder(),
			},
			adjustCurrentPrices = {
				type = "toggle",
				name = L["Adjust current prices"],
				desc = L["Will adjust the current prices with a standard deviation, configured in the statistics section."],
				get = function() return vendor.TooltipHook.db.profile.adjustCurrentPrices end,
				set = function(info, value) vendor.TooltipHook.db.profile.adjustCurrentPrices = value end,
				order = _NextOrder(),
			},
			newLine2 = {
				type = "description",
				name = "",
				order = _NextOrder(),
			},
			showLower = {
				type = "toggle",
				name = L["Lower buyout"],
				desc = L["Show lower buyout of current auctions"],
				get = function() return vendor.Statistic.db.profile.showLower end,
				set = function(info, value) vendor.Statistic.db.profile.showLower = value end,
				order = _NextOrder(),
			},
			showMedian = {
				type = "toggle",
				name = L["Median buyout"],
				desc = L["Show median buyout of current auctions"],
				get = function() return vendor.Statistic.db.profile.showMedian end,
				set = function(info, value) vendor.Statistic.db.profile.showMedian = value end,
				order = _NextOrder(),
			},
			newLine3 = {
				type = "description",
				name = "",
				order = _NextOrder(),
			},
			compactMarketPrice = {
				type = "toggle",
				name = L["Always historic value"],
				desc = L["Will display the historic value, even if there are current auctions"],
				get = function() return vendor.TooltipHook.db.profile.compactMarketPrice end,
				set = function(info, value) vendor.TooltipHook.db.profile.compactMarketPrice = value end,
				order = _NextOrder(),
			},
			compactColor = {
				type = "color",
				name = L["Historic-only color"],
				desc = L["The color for the historic value, if there are no current auctions"],
				get = function()
					local color = vendor.TooltipHook.db.profile.compactColor or {}
					return color.r, color.g, color.b 
				end,
				set = function(info, val1, val2, val3) vendor.TooltipHook.db.profile.compactColor = {r = val1, g = val2, b = val3} end,
				order = _NextOrder(),
			},
			newLine4 = {
				type = "description",
				name = "",
				order = _NextOrder(),
			},
			showDisenchant = {
				type = "toggle",
				name = L["Disenchant info"],
				desc = L["Show disenchant info for armor and weapons"],
				get = function() return vendor.TooltipHook.db.profile.showDisenchant end,
				set = function(info, value) vendor.TooltipHook.db.profile.showDisenchant = value end,
				order = _NextOrder(),
			},
		}
	}
end

function vendor.Config:OnInitialize()
	self.db = vendor.Vendor.db
	self.profile = self.db.profile

	self.opts = {
		type = "group",
		childGroups = "tab",
		args = {
			main = _MainOpts(),
			view = _ViewOpts(),
			seller = _SellerOpts(),
			statistic = _StatisticOpts(),
			disenchant = _DisenchantOpts(),
			profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
		}
	}

--	AceConfig:RegisterOptionsTable("AuctionMaster", self.opts, {"am", "auctionmaster"})
--	AceConfigDialog:SetDefaultSize("AuctionMaster", 800, 500)

	--AceConfig:RegisterOptionsTable(APP_NAME, OPTIONS)
	AceConfig:RegisterOptionsTable(APP_NAME, self.opts, {"am", "auctionmaster"})
	self.configFrame = AceConfigDialog:AddToBlizOptions(APP_NAME)
--	self.configFrame.obj:SetTitle("")
--	log:Debug("label [%s]", self.configFrame.obj.label:GetText())
	
--	LibStub("AceConfig-3.0"):RegisterOptionsTable("AuctionMaster", self.options2, {"am", "auctionmaster"})
--	self.AceConfigRegistry:RegisterOptionsTable("AuctionMaster Blizz", self.options)
--	self.AceConfigDialog:AddToBlizOptions("AuctionMaster Blizz", "AuctionMaster")

	self.db.RegisterCallback(self, "OnProfileChanged", "Reset")
	self.db.RegisterCallback(self, "OnProfileCopied", "Reset")
	self.db.RegisterCallback(self, "OnProfileReset", "Reset")

	vendor.Vendor:RegisterChatCommand("auctionmaster", "ChatCommand")
	vendor.Vendor:RegisterChatCommand("am", "ChatCommand")
--	vendor.Vendor:RegisterChatCommand("am", function() self:ToggleConfigDialog() end)
end

function vendor.Config:OnEnable()
	_UpdateMain()
	_UpdateSeller()
	_UpdateTooltip()
end

function vendor.Config:ToggleConfigDialog()
--	if (AceConfigDialog.OpenFrames["AuctionMaster"]) then
--		AceConfigDialog:Close("AuctionMaster")
--	else
--		AceConfigDialog:Open("AuctionMaster")
--	end
	InterfaceOptionsFrame_OpenToCategory(self.configFrame)
    InterfaceOptionsFrame_OpenToCategory(self.configFrame)
end

function vendor.Config:Reset()
	--qmstr.QuestMaster:Reset()
end
