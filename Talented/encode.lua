--[[
	Template encoding code is heavily borrowed from wowhead, but use a different map.
	StringToTemplate and TemplateToString
]]
local assert = assert
local ipairs = ipairs
local modf = math.modf
local fmod = math.fmod
local Talented = Talented

local stop = 'Z'
local talented_map = "012345abcdefABCDEFmnopqrMNOPQRtuvwxy*"
local classmap = { 'DRUID','HUNTER','MAGE','PALADIN','PRIEST','ROGUE','SHAMAN','WARLOCK','WARRIOR' }--,'DEATHKNIGHT', 'Ferocity', 'Cunning', 'Tenacity' }

function Talented:GetTemplateStringClass(code, nmap)
	nmap = nmap or talented_map
	if code:len() <= 0 then return end
	local index = modf((nmap:find(code:sub(1, 1), nil, true) - 1) / 3) + 1
	if not index or index > #classmap then return end
	return classmap[index]
end

local function get_point_string(class, tabs, primary)
	if type(tabs) == "number" then return " - |cffffd200"..tabs.."|r" end
	local start = " - |cffffd200"
	if primary then
		start = start..Talented.tabdata[class][primary].name.." "
		tabs[primary] = "|cffffffff"..tostring(tabs[primary]).."|cffffd200"
	end
	return start..table.concat(tabs, "/", 1, 3).."|r"
end

local temp_tabcount = {}
local function GetTemplateStringInfo(code)
	if code:len() <= 0 then return end
	local index = modf((talented_map:find(code:sub(1, 1), nil, true) - 1) / 3) + 1
	if not index or index > #classmap then return end
	local class = classmap[index]
	local trees = Talented:UncompressSpellData(class)
	local tabs, count, t = 1, 0, 0
	for i = 2, code:len() do
		local char = code:sub(i, i)
		if char == stop then
			if t >= #trees[tabs].talents then
				temp_tabcount[tabs] = count
				tabs = tabs + 1
				count, t = 0, 0
			end
			temp_tabcount[tabs] = count
			tabs = tabs + 1
			count, t = 0, 0
		else
			index = talented_map:find(char, nil, true) - 1
			if not index then return end
			local b = fmod(index, 6)
			local a = (index - b) / 6
			if t >= #trees[tabs].talents then
				temp_tabcount[tabs] = count
				tabs = tabs + 1
				count, t = 0, 0
			end
			t = t + 2
			count = count + a + b
		end
	end

	if count > 0 then
		temp_tabcount[tabs] = count
	else
		tabs = tabs - 1
	end
	for i = tabs + 1, #trees do
		temp_tabcount[i] = 0
	end
	tabs = #trees
	if tabs == 1 then
		return get_point_string(class, temp_tabcount[1])
	else -- tab == 3
		local primary, min, max, total = 0, 0, 0, 0
		for i = 1, tabs do
			local points = temp_tabcount[i]
			if points < min then
				min = points
			end
			if points > max then
				primary, max = i, points
			end
			total = total + points
		end
		local middle = total - min - max
		if 3 * (middle - min) >= 2 * (max - min) then
			primary = nil
		end
		return get_point_string(class, temp_tabcount, primary)
	end
end

function Talented:GetTemplateInfo(template)
	self:Debug("GET TEMPLATE INFO", template.name)
	if template.code then
		return GetTemplateStringInfo(template.code)
	else
		local tabs = #template
		if tabs == 1 then
			return get_point_string(template.class, self:GetPointCount(template))
		else
			local primary, min, max, total = 0, 0, 0, 0
			for i = 1, tabs do
				local points = 0
				for _, value in ipairs(template[i]) do
					points = points + value
				end
				temp_tabcount[i] = points
				if points < min then
					min = points
				end
				if points > max then
					primary, max = i, points
				end
				total = total + points
			end
			local middle = total - min - max
			if 3 * (middle - min) >= 2 * (max - min) then
					primary = nil
			end
			return get_point_string(template.class, temp_tabcount, primary)
		end
	end
end

function Talented:StringToTemplate(code, template, nmap)
	if code == nil or code:len() <= 0 then return end
	nmap = nmap or talented_map

	local index = modf((nmap:find(code:sub(1, 1), nil, true) - 1) / 3) + 1
	assert(index and index <= #classmap, "Unknown class code")

	local class = classmap[index]
	template = template or {}
	template.class = class

	local trees = self:UncompressSpellData(class)
	assert(trees)

	local tab = 1
	local t = wipe(template[tab] or {})
	template[tab] = t

	for i = 2, code:len() do
		local char = code:sub(i, i)
		if char == stop then
			if #t >= #trees[tab].talents then
				tab = tab + 1
				t = wipe(template[tab] or {})
				template[tab] = t
			end
			tab = tab + 1
			t = wipe(template[tab] or {})
			template[tab] = t
		else
			index = nmap:find(char, nil, true) - 1
			if not index then return end
			local b = fmod(index, 6)
			local a = (index - b) / 6

			if #t >= #trees[tab].talents then
				tab = tab + 1
				t = wipe(template[tab] or {})
				template[tab] = t
			end
			t[#t + 1] = a

			if #t < #trees[tab].talents then
				t[#t + 1] = b
			else
				assert(b == 0)
			end
		end
	end

	assert(#template <= #trees, "Too many branches")
	do
		for tab, tree in ipairs(trees) do
			local t = template[tab] or {}
			template[tab] = t
			for index = 1, #tree.talents do
				t[index] = t[index] or 0
			end
		end
	end

	return template, class
end

local function rtrim(s, c)
	local l = #s
	while l >= 1 and s:sub(l, l) == c do
		l = l - 1
	end
	return s:sub(1, l)
end

local function get_next_valid_index(tmpl, index, tree)
	if not tree[index] then
		return 0, index
	else
		return tmpl[index], index + 1
	end
end

function Talented:TemplateToString(template, nmap)
	nmap = nmap or talented_map
	local class = template.class

	local code, ccode = ""
	do
		for index, c in ipairs(classmap) do
			if c == class then
				local i = (index - 1) * 3 + 1
				ccode = nmap:sub(i, i)
				break
			end
		end
	end
	assert(ccode, "invalid class")
	local s = nmap:sub(1, 1)
	local trees = self:UncompressSpellData(class)
	for tab, tree in ipairs(trees) do
		local tmpTree    = template[tab] --n.b. unlike spellData, this IS the array of talent ranks -- don't need tmpTree.talents
		local index = 1
		while index <= #tmpTree do
			local r1, r2
			r1, index = get_next_valid_index(tmpTree, index, tree.talents)
			r2, index = get_next_valid_index(tmpTree, index, tree.talents)
			local v = r1 * 6 + r2 + 1
			local c = nmap:sub(v, v)
			assert(c)
			code = code .. c
		end
		local ncode = rtrim(code, s)
		if ncode ~= code then
			code = ncode..stop
		end
	end
	return ccode..rtrim(code, stop)
end

function Talented:PackTemplate(template)
	if not template or template == self.current or template.code then return end
	self:Debug("PACK TEMPLATE", template.name)
	template.code = self:TemplateToString(template)
	for tab in ipairs(template) do
		template[tab] = nil
	end
end

function Talented:UnpackTemplate(template)
	if template == self.current or not template.code then return end
	self:Debug("UNPACK TEMPLATE", template.name)
	self:StringToTemplate(template.code, template) 
	template.code = nil
end

function Talented:CopyPackedTemplate(src, dst)
	local packed = src.code
	if packed then self:UnpackTemplate(src) end
	dst.class = src.class
	for tab, tree in ipairs(src) do
		local d = dst[tab]
		if not d then
			d = {}
			dst[tab] = d
		end
		for index, value in ipairs(tree) do --templates don't have tree.talents like Talented_Data members do
			dst[tab][index] = value
		end
	end
	if packed then self:PackTemplate(src) end
end
