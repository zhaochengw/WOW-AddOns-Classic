-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSUtils = private.NewLib("RareScannerUtils")

---============================================================================
-- Table utils
---============================================================================

function RSUtils.FilterRepeated(originTable, tableToCompate)
	if (originTable and type(originTable) == "table") then
		local notRepeatedValues = {}

		for _, value in ipairs(originTable) do
			if (tableToCompate and type(tableToCompate) == "table" and not RSUtils.Contains(tableToCompate, value) and not RSUtils.Contains(notRepeatedValues, value)) then
				table.insert(notRepeatedValues, value)
			elseif (not RSUtils.Contains(notRepeatedValues, value)) then
				table.insert(notRepeatedValues, value)
			end
		end

		if (next(notRepeatedValues) ~= nil) then
			return notRepeatedValues
		end
	end

	return nil
end

function RSUtils.JoinTables(table1, table2)
	local joinedTable = {}
	local joined = false
	if (table1 and type(table1) == "table") then
		for _, value in ipairs (table1) do
			if (not RSUtils.Contains(joinedTable, value)) then
				tinsert(joinedTable, value)
				joined = true
			end
		end
	end

	if (table2 and type(table2) == "table") then
		for _, value in ipairs (table2) do
			if (not RSUtils.Contains(joinedTable, value)) then
				tinsert(joinedTable, value)
				joined = true
			end
		end
	end

	if (joined) then
		return joinedTable
	end
	
	return nil
end

function RSUtils.GetTableLength(table)
	if (not table) then
		return 0
	end
	
	local getN = 0
	for n in pairs(table) do 
    	getN = getN + 1 
	end
	
  	return getN
end

function RSUtils.CloneTable(src, dest)
	for index, value in pairs(src) do
		if (type(value) == "table") then
			dest[index] = {}
			RSUtils.CloneTable(value, dest[index])
		else
			dest[index] = value
		end
	end
end

function RSUtils.GetSortedKeysByValue(tbl, sortFunction)
	local keys = {}
	
	if (tbl) then
		for key in pairs(tbl) do
	    	table.insert(keys, key)
	 	end
	
	  	table.sort(keys, function(a, b)
	    	return sortFunction(tbl[a], tbl[b])
	  	end)
	end

  	return keys
end

---============================================================================
-- Auxiliar utils
---============================================================================

function RSUtils.Contains(cTable, item)
	if (not cTable or not item) then
		return false
	end

	if (type(cTable) == "table") then
		for _, v in pairs(cTable) do
			if (type(v) == "table") then
				return RSUtils.Contains(v, item)
			elseif (type(item) == "table") then
				return RSUtils.Contains(item, v)
			elseif (type(v) == "string" and string.find(string.upper(strtrim(v)), string.upper(strtrim(item)))) then
				return true;
			elseif (v == item) then
				return true;
			end
		end
	else
		if (type(item) == "table") then
			return RSUtils.Contains(item, cTable)
		elseif (type(cTable) == "string" and string.find(string.upper(strtrim(cTable)), string.upper(strtrim(item)))) then
			return true;
		elseif (cTable == item) then
			return true;
		end
	end

	return false;
end

function RSUtils.ContainsKeyValue(table, keyTable, value)
	if (not table or not keyTable or not value) then
		return false
	end
	
	if (type(table) ~= "table") then
		return false
	elseif (type(keyTable) ~= "table") then
		return false
	else
		for k, _ in pairs (table) do
			local currentKey = nil
			for _, key in ipairs (keyTable) do
				if (k == key) then
					currentKey = k;
					break
				end
			end
			
			if (currentKey and table[currentKey][value]) then
				return true
			end
		end
		
		return false
	end
end

---============================================================================
-- String utils
---============================================================================

function RSUtils.StartsWith(string, start)
	return string.sub(string,1,string.len(start)) == start
end

function RSUtils.Lpad(s, l, c)
	if (type(s) ~= "string") then
		s = tostring(s)
	end
	
	local res = string.rep(c or ' ', l - #s) .. s
	return res, res ~= s
end

function RSUtils.Rpad(s, l, c)
	if (type(s) ~= "string") then
		s = tostring(s)
	end
	
	if (l - #s > 0) then
		local res = s.. string.rep(c or ' ', l - #s)
		return res, res ~= s
	end

	return s
end

function RSUtils.tostring(s)
	if (s) then
		return tostring(s)
	end
	
	return nil
end

function RSUtils.IsNumber(n)
	if (n and type(n) == "number") then
		return true
	end
	
	return false
end

---============================================================================
-- Arithmetic utils
---============================================================================

function RSUtils.DistanceBetweenCoords(x1, x2, y1, y2)
	if (RSUtils.IsNumber(x1) and RSUtils.IsNumber(x2) and RSUtils.IsNumber(y1) and RSUtils.IsNumber(y2)) then
		local dx = RSUtils.FixCoord(x1) - RSUtils.FixCoord(x2)
		local dy = RSUtils.FixCoord(y1) - RSUtils.FixCoord(y2)
		return math.sqrt ( (dx * dx) + (dy * dy) )
	else
		return -1;
	end
end

function RSUtils.Distance(POIa, POIb)
	return RSUtils.DistanceBetweenCoords(POIa.x, POIb.x, POIa.y, POIb.y)
end

---
-- @param #string text Text to add color
-- @param #string color Color
-- @return Text with color
---
function RSUtils.TextColor(text, color)
	return string.format("|cff%s%s|r", color, text)
end

---
-- @param #number Number to round
-- @param #decimals Number of decimals
-- @return Rounded number
---
function RSUtils.Round(number, decimals)
    return (("%%.%df"):format(decimals)):format(number)
end

---============================================================================
-- Adjust coordinates to the new format
---============================================================================

function RSUtils.FixCoord(coord)
	if (RSUtils.Contains(tostring(coord), "0.")) then
		coord = RSUtils.Rpad(tostring(coord):gsub('(0%.)',''), 4, '0')
	else
		coord = RSUtils.Lpad(coord, 4, '0')
	end
	
	if (tonumber(strsub(coord, 1, 3)) == 0) then
		return tonumber(string.format("0.00%s", strsub(coord, 3)));
	elseif (tonumber(strsub(coord, 1, 2)) == 0) then
		return tonumber(string.format("0.0%s", strsub(coord, 2)));
	else
		return tonumber(string.format("0.%s", coord));
	end
end

---============================================================================
-- RGB to HEX
---============================================================================

local color = CreateFromMixins(ColorMixin)

function RSUtils.RGBToHex(r, g, b)
	color:SetRGBA(r, g, b)
	return string.sub(color:GenerateHexColor(), 3, 8)
end

function RSUtils.HexToRGB(hex)
	local rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)
	return tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255
end