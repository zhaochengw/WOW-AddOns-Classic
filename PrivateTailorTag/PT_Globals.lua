----------------------
-- GLOBAL FUNCTIONS --
----------------------

function trim (str)

	local n = str:find"%S"
	return n and str:match(".*%S", n) or ""

end


function strDown (str)

	local len    = strlen(str)
	local count  = 1
	local res    = ""
	local c
	local char   = string.char
	local lower  = string.lower

	while count <= len do
		c = strbyte(str, count)

		if c < 32 or c > 126 then
			res = res .. char(c)
		else
			res = res .. lower(char(c))
		end

		count = count + 1
	end

	return res
end

function Proper (name, okSpaces)

	if name == nil then return nil end

	local len    = strlen(name)
	local count  = 1
	local res    = ""
	local needUp = true
	local gotOP  = false
	local c
	local char   = string.char
	local upper  = string.upper
	local lower  = string.lower
	local sb     = strbyte

	while count <= len do
		c = sb(name, count)

		if c < 32 or c > 126 then
			res    = res .. char(c)
			needUp = false
		else
			if c ~= 32 or okSpaces == true then
				if needUp then
					res = res .. upper(char(c))
				else
					res = res .. lower(char(c))
				end

				gotOP  = (c == 40 or gotOP) and (c ~= 41)
				needUp = (c == 32 or c == 45 or gotOP == true)
			end
		end

		count  = count + 1
	end

	return res
end


function getServer (name, def)

	local index = string.find(name, "-", 1, true)

	if index ~= nil then
		return string.sub(name, index + 1, string.len(name))
	end

	if def then return def else return serverName end
end

function removeServer (name, strict)

	if name == nil then
		return nil
	end

	result = name

	local index = string.find(name, "-", 1, true)

	if strict == nil then
		strict = false
	end

	if index ~= nil then
		local server = Proper(string.sub(name, index + 1, string.len(name)));

		if strict == true or server == Proper(serverName) then
			result = string.sub(name, 1, index - 1)
		end
	end

	return result
end




function getNameFromNameTag (nameTag)

	local index = string.find(nameTag, " ", 1, true)

	if index ~= nil then
		return string.gsub(string.sub(nameTag, 1, index-1), '^[%s]*([^%s].*[^%s])[%s]*$', "%1")
	end

end


function getTagFromNameTag (nameTag)

	local index = string.find(nameTag, " ", 1, true)

	if index ~= nil then
		return string.gsub(string.sub(nameTag, index + 1, string.len(nameTag)), '^[%s]*([^%s].*[^%s])[%s]*$', "%1")
	end

end






function addServer (name)

	if not name then return nil end

	if string.find(name, "-", 1, true) == nil then
		return name .. "-" .. serverName
	end
	
	return name
end


function table_length(t)
	local length =0
	for k, v in pairs(t) do
		length = length +1
	end
	return length;
end


----------------------
-- GLOBAL VARIABLES --
----------------------

_, PTT_L		= ...
serverName	= Proper(GetRealmName())
playerName	= addServer(GetUnitName("player"), true)

