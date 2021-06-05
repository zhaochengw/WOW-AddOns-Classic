--[[
	Defines the vendor namespace.
	
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

-- overall package name
vendor = vendor or {}

vendor.OUTDATED_FONT_COLOR_CODE = "|cff505050"

-- misc db for debugging etc.
if (not AuctionMasterMiscDb) then
	AuctionMasterMiscDb = {}
end

--[[
	Returns true, if the given argument is a number.
--]]
function vendor.isnumber(arg)
	if (type(arg) == "number") then
		return true
	elseif (type(arg) == "string") then
		local s, e = string.find(arg, "%d+")
		if (s and e) then
			return (s == 1 and e == string.len(arg))
		end 
	end
	return false
end

--[[
	Copies elements of src to dest.
--]]
function vendor.AddToTable(dest, src)
	for i=1,#src do
		table.insert(dest, src[i])
	end
end

function vendor.clickAuctionSellItemButton()
	if (not AuctionFrameAuctions.duration) then
		-- needed since patch 4.0.1
		AuctionFrameAuctions.duration = 2
	end
	ClickAuctionSellItemButton()
end

function vendor.currentDay()
	return ceil(time() / 86400)
end

-- Returns true, if str starts with prefix.
function vendor.strStartsWith(str, prefix)
	return string.sub(str, 1, string.len(prefix)) == prefix
end

-- Splits the string according to the given pattern like "([^\n]+)". 
function vendor.strSplit(str, pattern)
	local fields = {}
    str:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

function vendor.backdropFrame(frame)
	if (BackdropTemplateMixin) then
		Mixin(frame, BackdropTemplateMixin)
	end
	return frame
end