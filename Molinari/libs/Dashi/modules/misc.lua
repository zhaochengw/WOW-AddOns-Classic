local _, addon = ...

--[[ namespace:header
In each example `namespace` refers to the 2nd value of the addon vararg, e.g:

```lua
local _, namespace = ...
```
--]]

--[[ namespace:ArgCheck(arg, argIndex, type[, type...]) ![](https://img.shields.io/badge/function-blue)
Checks if the argument `arg` at position `argIndex` is of `type`(s).
--]]
function addon:ArgCheck(arg, argIndex, ...)
	assert(type(argIndex) == 'number', 'Bad argument #2 to \'ArgCheck\' (number expected, got ' .. type(argIndex) .. ')')

	for index = 1, select('#', ...) do
		if type(arg) == select(index, ...) then
			return
		end
	end

	local types = string.join(', ', ...)
	local name = debugstack(2, 2, 0):match(': in function [`<](.-)[\'>]')
	error(string.format('Bad argument #%d to \'%s\' (%s expected, got %s)', argIndex, name, types, type(arg)), 3)
end

do
	-- UnitType-0-ServerID-InstanceID-ZoneUID-ID-SpawnUID
	local GUID_PATTERN = '(%w+)%-0%-(%d+)%-(%d+)%-(%d+)%-(%d+)%-(.+)'
	--[[ namespace:ExtractFieldsFromUnitGUID(_guid_) ![](https://img.shields.io/badge/function-blue)
	Returns the individual fields from the given [`guid`](https://warcraft.wiki.gg/wiki/GUID), typecast to their correct types.
	--]]
	function addon:ExtractFieldsFromUnitGUID(guid)
		if guid then
			local unitType, serverID, instanceID, zoneUID, id, spawnUID = guid:match(GUID_PATTERN)
			if unitType then
				return unitType, tonumber(serverID), tonumber(instanceID), tonumber(zoneUID), tonumber(id), spawnUID
			end
		end
	end
end

--[[ namespace:GetUnitID(_unit_) ![](https://img.shields.io/badge/function-blue)
Returns the integer `id` of the given [`unit`](https://warcraft.wiki.gg/wiki/UnitId).
--]]
function addon:GetUnitID(unit)
	if unit and UnitExists(unit) then
		local unitGUID = UnitGUID(unit)
		local _, _, _, _, unitID = addon:ExtractFieldsFromUnitGUID(unitGUID)
		return unitID, unitGUID
	end
end

--[[ namespace:GetNPCName(_npcID_) ![](https://img.shields.io/badge/function-blue)
Returns the name for the NPC by the given `npcID`.

* Warning: this depends on the cache, and might not yield results the first time.
--]]
do
	local creatureNames = setmetatable({}, {
		__index = function(self, npcID)
			local data = C_TooltipInfo.GetHyperlink('unit:Creature-0-0-0-0-' .. npcID .. '-0')
			local name = data and data.lines and data.lines[1] and data.lines[1].leftText
			if name then
				rawset(self, npcID, name)
				return name
			end
		end
	})

	function addon:GetNPCName(npcID)
		return creatureNames[npcID]
	end
end

do
	local ITEM_LINK_FORMAT = '|Hitem:%d|h'
	--[[ namespace:GetItemLinkFromID(_itemID_) ![](https://img.shields.io/badge/function-blue)
	Generates an [item link](https://warcraft.wiki.gg/wiki/ItemLink) from an `itemID`.  
	This is a crude generation and won't have valid data for complex items.
	--]]
	function addon:GetItemLinkFromID(itemID)
		return ITEM_LINK_FORMAT:format(itemID)
	end
end

--[[ namespace:GetPlayerMapID() ![](https://img.shields.io/badge/function-blue)
Returns the ID of the current map/zone the player is located in.
--]]
function addon:GetPlayerMapID()
	-- TODO: maybe use HBD data if it's available
	return C_Map.GetBestMapForUnit('player') or -1
end

--[[ namespace:GetPlayerPosition(_mapID_) ![](https://img.shields.io/badge/function-blue)
Returns the `x` and `y` coordinates for the player in the given `mapID` (if they are valid).
--]]
function addon:GetPlayerPosition(mapID)
	local pos = C_Map.GetPlayerMapPosition(mapID, 'player')
	if pos then
		return pos:GetXY()
	end
end

--[[ namespace:GetUnitAura(_unitID_, _spellID_[, _filter_]) ![](https://img.shields.io/badge/function-blue)
Returns the aura by `spellID` on the [`unitID`](https://warcraft.wiki.gg/wiki/UnitId), if it exists.  
See [UnitAura](https://warcraft.wiki.gg/wiki/API_C_UnitAuras.GetAuraDataByIndex#Filters) for the `filter` arg.

`filter` no longer works as of patch 11.2.5, as this method just wraps a C_UnitAuras method directly.
--]]
if addon:HasBuild(110205) then
	function addon:GetUnitAura(unit, spellID)
		return C_UnitAuras.GetUnitAuraBySpellID(unit, spellID)
	end
else
	do
		local function auraSlotsWrapper(unit, spellID, token, ...)
			local slot, data
			for index = 1, select('#', ...) do
				slot = select(index, ...)
				data = C_UnitAuras.GetAuraDataBySlot(unit, slot)
				if spellID == data.spellId and data.sourceUnit then
					return nil, data
				end
			end

			return token
		end

		function addon:GetUnitAura(unit, spellID, filter)
			local token, data
			repeat
				token, data = auraSlotsWrapper(unit, spellID, C_UnitAuras.GetAuraSlots(unit, filter, nil, token))
			until token == nil

			return data
		end
	end
end

--[[ namespace:CreateColor(r, g, b[, a]) ![](https://img.shields.io/badge/function-blue)
Wrapper for CreateColor that can handle >1-255 range as well.  
Alpha (`a`) will always be in the 0-1 range.
--]]
--[[ namespace:CreateColor(hex) ![](https://img.shields.io/badge/function-blue)
Wrapper for CreateColor that can handle hex colors (both `RRGGBB` and `AARRGGBB`).
--]]
function addon:CreateColor(r, g, b, a)
	if type(r) == 'table' then
		return addon:CreateColor(r.r, r.g, r.b, r.a)
	elseif type(r) == 'string' then
		-- load from hex
		local hex = r:gsub('#', '')
		if #hex == 8 then
			-- prefixed with alpha
			a = tonumber(hex:sub(1, 2), 16) / 255
			r = tonumber(hex:sub(3, 4), 16) / 255
			g = tonumber(hex:sub(5, 6), 16) / 255
			b = tonumber(hex:sub(7, 8), 16) / 255
		elseif #hex == 6 then
			r = tonumber(hex:sub(1, 2), 16) / 255
			g = tonumber(hex:sub(3, 4), 16) / 255
			b = tonumber(hex:sub(5, 6), 16) / 255
		end
	elseif r > 1 or g > 1 or b > 1 then
		r = r / 255
		g = g / 255
		b = b / 255
	end

	local color = CreateColor(r, g, b, a)
	-- oUF compat; TODO: do something with this in oUF?
	color[1] = r
	color[2] = g
	color[3] = b
	return color
end

do
	local timeFormatter = CreateFromMixins(SecondsFormatterMixin)
	timeFormatter:Init(1, SecondsFormatter.Abbreviation.OneLetter)
	timeFormatter:SetStripIntervalWhitespace(true)
	--[[ namespace:FormatTime(_timeInSeconds_) ![](https://img.shields.io/badge/function-blue)
	Formats the given `timeInSeconds` to a readable, but abbreviated format.
	--]]
	function addon:FormatTime(timeInSeconds)
		return timeFormatter:Format(tonumber(timeInSeconds))
	end
end
