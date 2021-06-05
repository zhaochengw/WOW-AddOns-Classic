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
	Snipe using bookmarks.
--]]
vendor.BookmarkSniper = {}
vendor.BookmarkSniper.prototype = {}
vendor.BookmarkSniper.metatable = {__index = vendor.BookmarkSniper.prototype}

local L = vendor.Locale.GetInstance()

local function _SnipeMatches(info, link)
	local itemName, _, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType = GetItemInfo(link)
	if (itemName) then
		local maxRarity = info.maxRarity or 10
    	if (info.name and strlen(info.name) > 0) then
    		local lowerPat = info.lowerName
    		if (not lowerPat) then
    			info.lowerName = strlower(info.name)
    			lowerPat = info.lowerName 
    		end
    		local lowerName = strlower(itemName)
    		local idx = strfind(lowerName, lowerPat)
    		if (not idx) then
    			return false
    		end
    	end
    	if (info.minLevel and info.minLevel > 0 and itemMinLevel < info.minLevel) then
    		return false
    	end
    	if (info.maxLevel and info.maxLevel > 0 and itemMinLevel > info.maxLevel) then
    		return false
    	end
    	if (info.class and info.class ~= itemType) then
    		return false
    	end
    	if (rtn and info.subclass and info.subclass ~= itemSubType) then
    		return false
    	end
    	if (rtn and info.rarity > 0 and itemRarity < info.rarity) then
    		return false
    	end
	    if (rtn and itemRarity > maxRarity) then
	    	return false    		
    	end
    	return true
	end
	return false
end


--[[ 
	Creates a new instance.
--]]
function vendor.BookmarkSniper:new(auctions)
	local instance = setmetatable({}, self.metatable)
	instance.auctions = auctions
	instance.config = vendor.SniperConfig:new(instance)
	return instance
end

--[[
	Checks whether to snipe for the item and returns doBuy, reason
--]]
function vendor.BookmarkSniper.prototype:Snipe(itemLink, itemName, count, bid, buyout, highBidder)
	--local maxBid, maxBuyout = vendor.Sniper:GetWanted(itemName)
	local infos = vendor.Scanner.db.factionrealm.searchInfos
	for i = 1, #infos do
		local info = infos[i]
		if (info.snipe) then
			if (_SnipeMatches(info, itemLink)) then
				if (info.maxPrice and info.maxPrice > 0) then
					local maxPrice = info.maxPrice * count
					if (info.buyout and buyout > 0 and maxPrice >= buyout) then
						local reasonSort = vendor.Sniper:CreateReasonSort(99999999, true, self:GetId())
						return true, L["Buyout <= %s"]:format(vendor.Format.FormatMoney(maxPrice)), reasonSort
					elseif (info.bid and maxPrice >= bid and not highBidder) then
						local reasonSort = vendor.Sniper:CreateReasonSort(99999999, false, self:GetId())
						return true, L["Bid <= %s"]:format(vendor.Format.FormatMoney(maxPrice)), reasonSort
					end
				else
					local reasonSort = vendor.Sniper:CreateReasonSort(99999999, true, self:GetId())
					return true, L["Item is on wanted list"], reasonSort
				end
			end
		end
	end
end

--[[
	Returns the unique identifier of the sniper.
--]]
function vendor.BookmarkSniper.prototype:GetId()
	return "bookmarkSniper"
end

--[[
	Returns the name to be displayed for this sniper module.
--]]
function vendor.BookmarkSniper.prototype:GetDisplayName()
	return L["Saved searches"]
end

--[[
	Returns an ordering information for the sniper. Lower numbers will be executed first.
--]]
function vendor.BookmarkSniper.prototype:GetOrder()
	return 1
end

function vendor.BookmarkSniper.prototype:GetDescription()
	return L["BOOKMARK_SNIPER_DESC"]
end
