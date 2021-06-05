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
	Evaluates whether a given item is usable by the current user. The result is cached.
	The cache is cleared after the auction house has been closed. Therefore it should
	only be used while the auction house is open.
	May hopefully be replaced by a blizzard function someday.
--]]
vendor.CanUseEval = {}
vendor.CanUseEval.prototype = {}
vendor.CanUseEval.metatable = {__index = vendor.CanUseEval.prototype}

local log = vendor.Debug:new("CanUseEval")

local function _CreateTooltip(self)
    self.tp = CreateFrame("GameTooltip", "CanUseEvalTooltip")
    self.tp:SetOwner(WorldFrame, "ANCHOR_NONE")
    self.numLines = 60
    self.cells = {}
    for l = 1, self.numLines do
    	self.cells[l] = {}
    	self.cells[l][1] = self.tp:CreateFontString("$parentTextLeft"..l, nil, "GameTooltipText") 
    	self.cells[l][2] = self.tp:CreateFontString("$parentTextRight"..l, nil, "GameTooltipText")
    	self.tp:AddFontStrings(self.cells[l][1], self.cells[l][2])
    end
end

--[[ 
	Creates a new instance.
--]]
function vendor.CanUseEval:new()
	local instance = setmetatable({}, self.metatable)
	LibStub("AceEvent-3.0"):Embed(instance)
	instance.cache = {}
	instance.minLevelPat = string.gsub(ITEM_MIN_LEVEL, "(%%d)", "(.+)")
	_CreateTooltip(instance)
	instance:RegisterEvent("AUCTION_HOUSE_CLOSED")
	return instance
end

--[[
	Returns whether the given item is usable by the current user.
--]]
function vendor.CanUseEval.prototype:IsUsable(itemLink)
	local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
	local rtn = self.cache[itemLinkKey]
	if (rtn == nil) then
		rtn = false
    	local itemMinLevel = select(5, GetItemInfo(itemLink)) or 0 
    	if (UnitLevel("player") >= itemMinLevel) then
    		rtn = true
    		self.tp:ClearLines()
    		self.tp:SetHyperlink(itemLink)
    		-- search for a red text
    		local n = math.min(self.tp:NumLines(), self.numLines)
    		for l = 1, n do
    			for r = 1, 2 do
    				local msg = self.cells[l][r]:GetText()
    				local r, g, b = self.cells[l][r]:GetTextColor()
    				if (r > 0.7 and g < 0.3 and b < 0.3) then
    					local _, _, _, _, _, itemType, itemSubtype = GetItemInfo(itemLink) 
    					log:Debug("itemType: %s itemSubtype: %s", itemType, itemSubtype)
--    				Recipe
--
--    * "Alchemy"
--    * "Blacksmithing"
--    * "Book"
--    * "Cooking"
--    * "Enchanting"
--    * "Engineering"
--    * "First Aid"
--    * "Leatherworking"
--    * "Tailoring" 
--    
    					if (not (itemMinLevel == 0 and string.find(msg, self.minLevelPat))) then
       						rtn = false
       						l = n
       						break
    					end
    				end
    			end
    		end
    	end
    	self.cache[itemLinkKey] = rtn
    end
	return rtn
end

--[[
	Invalidate the cache.
--]]
function vendor.CanUseEval.prototype:AUCTION_HOUSE_CLOSED()
	self.cache = wipe(self.cache)
end
