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
	Some table helpers.
--]]

vendor.Tables = {}

--[[
	Returns the index to an item in the given table matching the specified value.
	The table has to be sorted. There may be other items, that also match the value.
--]]
function vendor.Tables.BinarySearch(t, v, extractValue)
	local left, right, idx = 1, #t, 0
  	local cmpV
  	while (left <= right) do
  		idx = math.floor((left + right) / 2)
  		if (extractValue) then
     		cmpV = extractValue(t[idx])
     	else
     		cmpV = t[idx]
     	end
     	if (v == cmpV) then
     		return idx
     	elseif (v < cmpV) then
     		-- search left
 			right = idx - 1
     	else
 			-- search right
     		left = idx + 1
     	end
	end
	return nil
end

--[[
	Copies all elements from the numbered table src to dest.
--]]
function vendor.Tables.Copy(src, dest)
	for i=1,#src do
		table.insert(dest, src[i])
	end
	return dest
end
