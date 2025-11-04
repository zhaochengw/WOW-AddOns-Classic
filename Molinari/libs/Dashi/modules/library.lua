local _, addon = ...

--[[ namespace:tsize(_tbl_) ![](https://img.shields.io/badge/function-blue)
Returns the number of entries in the table `tbl`.  
Works for associative tables as opposed to `#table`.
--]]
function addon:tsize(tbl)
	-- would really like Lua 5.2 for this
	local size = 0
	if tbl then
		for _ in next, tbl do
			size = size + 1
		end
	end
	return size
end

--[[ namespace:startswith(_str_, _contents_) ![](https://img.shields.io/badge/function-blue)
Checks if the first string starts with the 2nd string.
--]]
function addon:startswith(str, contents)
	return str:sub(1, contents:len()) == contents
end

--[[ namespace:T([_tbl_]) ![](https://img.shields.io/badge/function-blue)
Returns the table _`tbl`_ with meta methods. If _`tbl`_ is not provided a new empty table is used.

Included are all meta methods from the `table` library, as well as a few extra handy methods:

- `tbl:size()` returns the number of entries in the table
- `tbl:contains(value)` returns `true` if the table contains the given `value`, otherwise `false`
- `tbl:merge(t)` merges (and returns) the table with the supplied table `t`
    - can also be used by using an addition arithmetic metamethod

It's also possible to add extra meta methods by supplying mixins through the variable argument.

Example usage:

```lua
local t = namespace:T{'one', 'two'}
t:insert('three')
t:size() --> 3
t:contains('four') --> false
t + {'five', 'six'} --> {'one', 'two', 'three', 'five', 'six'}
```
--]]
do
	local tableMethods = CreateFromMixins(table)
	function tableMethods:size()
		return addon:tsize(self)
	end

	function tableMethods:merge(tbl)
		addon:ArgCheck(tbl, 1, 'table')

		for k, v in next, tbl do
			if type(self[k] or false) == 'table' then
				tableMethods.merge(self[k], tbl[k])
			else
				self[k] = v
			end
		end

		return self
	end

	function tableMethods:contains(value)
		for _, v in next, self do
			if value == v then
				return true
			end
		end

		return false
	end

	function tableMethods:random()
		local size = self:size()
		if size > 0 then
			return self[math.random(size)]
		end
	end

	function tableMethods:copy(shallow)
		local tbl = addon:T()
		for k, v in next, self do
			if type(v) == 'table' and not shallow then
				tbl[k] = tableMethods.copy(v)
			else
				tbl[k] = v
			end
		end
		return tbl
	end

	-- remove obsolete and deprecated methods present in the table library
	-- https://warcraft.wiki.gg/wiki/Lua_functions#Deprecated_functions
	tableMethods.foreach = nil
	tableMethods.foreachi = nil
	tableMethods.getn = nil
	tableMethods.setn = nil

	local function newIndex(self, key, value)
		-- turn child tables into this metatable too
		if type(value) == 'table' and not getmetatable(value) then
			rawset(self, key, addon:T(value))
		else
			rawset(self, key, value)
		end
	end

	function addon:T(tbl)
		addon:ArgCheck(tbl, 1, 'table', 'nil')

		return setmetatable(tbl or {}, {
			__index = tableMethods,
			__newindex = newIndex,
			__add = tableMethods.merge,
		})
	end
end

--[[ namespace:sub(_string_, start[, stop])
UTF-8 aware [`string.sub`](https://warcraft.wiki.gg/wiki/API_strsub).
--]]
do
	-- cherry-picked from Phanx's implementation back in 2007, I'm sure
	-- they'd be fine with me borrowing it like this after all these years
	local function utf8bytes(str, pos)
		-- count the number of bytes based on the character
		if not pos then
			pos = 1
		end

		local byte1 = str:byte(pos)
		if byte1 > 0 and byte1 <= 127 then
			-- ASCII
			return 1
		elseif byte1 >= 194 and byte1 <= 223 then
			local byte2 = str:byte(pos + 1)
			if not byte2 then
				error('UTF-8 string terminated early')
			elseif byte2 < 128 or byte2 > 191 then
				error('Invalid UTF-8 character')
			end

			return 2
		elseif byte1 >= 224 and byte1 <= 239 then
			local byte2 = str:byte(pos + 1)
			local byte3 = str:byte(pos + 2)
			if not byte2 or not byte3 then
				error('UTF-8 string terminated early')
			elseif byte1 == 224 and (byte2 < 160 or byte2 > 191) then
				error('Invalid UTF-8 character')
			elseif byte1 == 237 and (byte2 < 128 or byte2 > 159) then
				error('Invalid UTF-8 character')
			elseif byte2 < 128 or byte2 > 191 then
				error('Invalid UTF-8 character')
			elseif byte3 < 128 or byte3 > 191 then
				error('Invalid UTF-8 character')
			end

			return 3
		elseif byte1 >= 240 and byte1 <= 244 then
			local byte2 = str:byte(pos + 1)
			local byte3 = str:byte(pos + 2)
			local byte4 = str:byte(pos + 3)

			if not byte2 or not byte3 or not byte4 then
				error('UTF-8 string terminated early')
			elseif byte1 == 240 and (byte2 < 144 or byte2 > 191) then
				error('Invalid UTF-8 character')
			elseif byte1 == 244 and (byte2 < 128 or byte2 > 143) then
				error('Invalid UTF-8 character')
			elseif byte2 < 128 or byte2 > 191 then
				error('Invalid UTF-8 character')
			elseif byte3 < 128 or byte3 > 191 then
				error('Invalid UTF-8 character')
			elseif byte4 < 128 or byte4 > 191 then
				error('Invalid UTF-8 character')
			end

			return 4
		end

		error('Invalid UTF-8 character')
	end

	function addon:sub(str, start, stop)
		addon:ArgCheck(str, 1, 'string')
		addon:ArgCheck(start, 2, 'number')
		addon:ArgCheck(stop, 3, 'number', 'nil')

		if not stop then
			-- default to stop at the end of the string
			stop = -1
		end

		local offset = (start >= 0 and stop >= 0) or strlenutf8(str)
		local startChar = (start >= 0) and start or (offset + start + 1)
		local stopChar = (stop >= 0) and stop or (offset + stop + 1)

		if startChar > stopChar then
			-- can't start before the stop
			return ''
		end

		local bytes = str:len()
		local startByte, stopByte = 1, str:len()
		local pos, len = 1, 0

		while pos <= bytes do
			len = len + 1

			if len == startChar then
				startByte = pos
			end

			pos = pos + utf8bytes(str, pos)

			if len == stopChar then
				stopByte = pos - 1
				break
			end
		end

		return str:sub(startByte, stopByte)
	end
end
