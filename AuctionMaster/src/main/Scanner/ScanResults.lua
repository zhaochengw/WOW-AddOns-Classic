--[[
	Helper for working with the per item lines of scans.
	
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

vendor.ScanResults = {};

--[[
	Packs the given entries in a compressed format.
	@return The compressed representation of the parameters.
--]]
function vendor.ScanResults.Pack(key, time, timeLeft, count, minBid, minIncrement, buyoutPrice, bidAmount, owner, highBidder, index)
	assert(key, "key is nil")
	assert(time, "time is nil")
	assert(timeLeft, "timeLeft is nil")
	assert(count, "count is nil")
	assert(minBid, "minBid is nil")
	assert(minIncrement, "minIncrement is nil")
	assert(buyoutPrice, "buyoutPrice is nil")
	assert(bidAmount, "bidAmount is nil")
	assert(owner, "owner is nil")
	assert(highBidder, "highBidder is nil")
	assert(index, "index is nil")
	local keyPart = strjoin(";", key, tostring(count), tostring(minBid), tostring(minIncrement), tostring(buyoutPrice), tostring(bidAmount), owner, highBidder, tostring(index));
	local timePart = strjoin(";", tostring(time), tostring(timeLeft));
	return keyPart.."#"..timePart;
end
	
--[[
	Unpacks the compressed data into the corresponding parameters.
	@Return key, time, timeLeft, count, minBid, minIncrement, buyoutPrice, bidAmount, owner, highBidder, index
--]]
function vendor.ScanResults.Unpack(data)
	local keyPart, timePart = strsplit("#", data)
	local key, count, minBid, minIncrement, buyoutPrice, bidAmount, owner, highBidder, index = strsplit(";", keyPart);
	local time, timeLeft = strsplit(";", timePart);
	return key, tonumber(time), tonumber(timeLeft), tonumber(count), tonumber(minBid), tonumber(minIncrement), tonumber(buyoutPrice), tonumber(bidAmount), owner, highBidder, tonumber(index);
end

--[[
	Returns the key from the given compressed data line.
--]]
function vendor.ScanResults.ExtractKey(data)
	local _, _, key = string.find(data, "^([0-9:]+);");
	return key;
end	
