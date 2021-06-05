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
	Small sell info area in seller tab.
--]]
vendor.SellInfo = {}
vendor.SellInfo.prototype = {}
vendor.SellInfo.metatable = {__index = vendor.SellInfo.prototype}

local L = vendor.Locale.GetInstance()
local log = vendor.Debug:new("SellInfo")

--[[
	Creates the gui.
--]]
local function _InitGui(self, parent)
	local frame = CreateFrame("Frame", nil, parent)
	self.text = {}
	local yOff = 0
	local width = 90
	local height = 13
	frame:SetWidth(2 * width)
	frame:SetHeight(self.rows * height)
	for r=1,self.rows do
		self.text[r] = {}
	 	local xOff = 0
		for c=1,2 do
			local f = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
			self.text[r][c] = f
			if (c == 1) then
				f:SetJustifyH("LEFT")
			else
				f:SetJustifyH("LEFT")
			end
			f:SetPoint("TOPLEFT", xOff, yOff)
			f:SetWidth(width)
			f:SetHeight(height)
			xOff = xOff + width
		end
		yOff = yOff - height
	end
	self.frame = frame
end

--[[ 
	Creates a new instance.
--]]
function vendor.SellInfo:new(parent, sellingPrice)
	local instance = setmetatable({}, self.metatable)
	instance.rows = 3
	instance.sellingPrice = sellingPrice
	_InitGui(instance, parent)
	return instance
end

--[[
	Sets the postion of the frame.
--]]
function vendor.SellInfo.prototype:SetPoint(...)
	self.frame:SetPoint(...)
end

--[[
	Clears the information displayed.
--]]
function vendor.SellInfo.prototype:Clear()
	for r=1,self.rows do
		self.text[r][1]:SetText("")
		self.text[r][2]:SetText("")
	end
end

--[[
	Updates the displayed information.
--]]
function vendor.SellInfo.prototype:Update()
	local bidType = vendor.Seller.db.profile.bidType
	local deposit = select(3, self.sellingPrice:GetPrices(bidType))
	self.text[1][1]:SetText(L["Deposit:"])
	self.text[1][2]:SetText(vendor.Format.FormatMoney(deposit, false))
	local off = 2
	if (bidType ~= vendor.SellingPrice.BID_TYPE_PER_ITEM) then
		local minBid, buyout = self.sellingPrice:GetPrices(vendor.SellingPrice.BID_TYPE_PER_ITEM)
		self.text[off][1]:SetText(L["Per item"]..":")
		self.text[off][2]:SetText(vendor.Format.FormatMoney(buyout, false))
		off = off + 1
	end
	if (bidType ~= vendor.SellingPrice.BID_TYPE_PER_STACK) then
		local minBid, buyout = self.sellingPrice:GetPrices(vendor.SellingPrice.BID_TYPE_PER_STACK)
		self.text[off][1]:SetText(L["Stack"]..":")
		self.text[off][2]:SetText(vendor.Format.FormatMoney(buyout, false))
		off = off + 1
	end
	if (bidType ~= vendor.SellingPrice.BID_TYPE_ALL and off < 4) then
		local minBid, buyout = self.sellingPrice:GetPrices(vendor.SellingPrice.BID_TYPE_ALL)
		self.text[off][1]:SetText(L["Overall"]..":")
		self.text[off][2]:SetText(vendor.Format.FormatMoney(buyout, false))
		off = off + 1
	end
end
