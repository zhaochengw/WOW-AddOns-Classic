local L = Grid2Options.L

local playerClass = Grid2.playerClass

local GetRangeList
do
	local list
	function GetRangeList(status)
		list = {}
		for range in pairs(status:GetRanges()) do
			list[range] = tonumber(range) and string.format(L["%d yards"],tonumber(range)) or nil
		end
		list.heal = L['Heal Range']
		list.spell = L['Spell Range']
		GetRangeList = function() return list end
		return list
	end
end

local GetPlayerSpells
do
	local GetSpellInfo = GetSpellInfo
	local IsPlayerSpell = IsPlayerSpell
	local IsSpellInRange = IsSpellInRange
	local customSpells = {}
	local stringMask = string.format("%%s (%s)",L["%d yards"])
	function GetPlayerSpells(status, hostile)
		local rezSpellID = select(3, status:GetRanges())
		wipe(customSpells)
		for i=1,1000 do
		   local type, spellID = GetSpellBookItemInfo(i,'spell')
		   if not spellID then break end
		   if type == 'SPELL' then
			   local name, _, _, _, minRange, maxRange = GetSpellInfo(spellID)
			   if maxRange>0 and maxRange<100 and spellID~=rezSpellID and IsPlayerSpell(spellID) and (hostile or IsSpellInRange(name, 'player')==1)  then
					customSpells[spellID] = string.format(stringMask, name, maxRange)
			   end
			end
		end
		if rezSpellID and friendly then
			customSpells[rezSpellID] = string.format(stringMask, GetSpellInfo(rezSpellID), 40)
		end
		return customSpells
	end
end

local function ToggleByClass(status, enabled)
	local rangeDB
	if enabled then
		rangeDB = { range = status.dbx.range }
		status.dbx.ranges = status.dbx.ranges or {}
		status.dbx.ranges[playerClass] = rangeDB
	else
		status.dbx.ranges[playerClass] = nil
		if next(status.dbx.ranges)==nil then status.dbx.ranges = nil end
		rangeDB = status.dbx
	end
	return rangeDB
end

local function MakeRangeOptions(self, status, options, optionParams)
	local rangeDB = status.dbx.ranges and status.dbx.ranges[playerClass] or status.dbx
	self:MakeStatusColorOptions(status, options, {
		width = "full",
		color1 = L["Out of range"]
	} )
	options.sep1 = {
		type = "header",
		order = 20,
		name = "",
	}
	options.default = {
		type = "range",
		order = 30,
		name = L["Out of range alpha"],
		desc = L["Alpha value when units are way out of range."],
		min = 0,
		max = 1,
		step = 0.01,
		get = function () return status.dbx.default	end,
		set = function (_, v)
			status.dbx.default = v
			status:UpdateDB()
			Grid2Frame:UpdateIndicators()
		end,
	}
	options.update = {
		type = "range",
		order = 35,
		name = L["Update rate"],
		desc = L["Rate at which the status gets updated"],
		min = 0,
		max = 5,
		step = 0.05,
		bigStep = 0.1,
		get = function () return status.dbx.elapsed	end,
		set = function (_, v) status.dbx.elapsed = v; status:UpdateDB()	end,
	}
	options.sep2 = {
		type = "header",
		order = 39,
		name = "",
	}
	options.range = {
		type = "select",
		order = 40,
		name = L["Range"],
		desc = L["Range in yards beyond which the status will be lost."],
		get = function ()
			return tonumber(rangeDB.range) or (rangeDB.range=='spell' and 'spell') or "heal"
		end,
		set = function (_, v)
			if v=='spell' and rangeDB.default then -- force storing range by class for spell option
				rangeDB = ToggleByClass(status, true)
			end
			rangeDB.range = v
			status:UpdateDB()
		end,
		values = function() return GetRangeList(status) end,
	}
	options.byClass = {
		type = "toggle",
		name = L["Range by class"],
		desc = L["Check this option to setup different range configuration for each player class."],
		order = 41,
		get = function ()
			return status.dbx.ranges and status.dbx.ranges[playerClass]
		end,
		set = function (_, v)
			rangeDB = ToggleByClass(status, v)
			status:UpdateDB()
		end,
	}
	options.newline = {
		order = 59,
		type = "description",
		name = "\n",
	}
	options.friendlySpell = {
		type = "select",
		order = 60,
		width = "double",
		name = L["Spell for friendly units"],
		desc = L["Spell to check the range of. The player must know the spell."],
		get = function () return rangeDB.friendlySpellID;	end,
		set = function (_, v) rangeDB.friendlySpellID = v; status:UpdateDB(); end,
		values = function() return GetPlayerSpells(status, false) end,
		hidden = function() return rangeDB.range~='spell' end,
	}
	options.hostileSpell = {
		type = "select",
		order = 70,
		width = "double",
		name = L["Spell for hostile units"],
		desc = L["Spell to check the range of. The player must know the spell."],
		get = function () return rangeDB.hostileSpellID;	end,
		set = function (_, v) rangeDB.hostileSpellID = v; status:UpdateDB(); end,
		values = function() return GetPlayerSpells(status, true) end,
		hidden = function() return rangeDB.range~='spell' end,
	}
end

Grid2Options:RegisterStatusOptions("range", "target", MakeRangeOptions, { groupOrder = 201 } )

Grid2Options:RegisterStatusOptions("rangealt", "target", MakeRangeOptions, { groupOrder = 202, title = L["Alternative Range"] } )
