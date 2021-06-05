--[[
	Standalone implementation of AceDB-2.0 for migration to AceDB-3.0. The external dependencies
	where removed.

	Old header:
Name: AceDB-2.0
Revision: $Rev: 1094 $
Developed by: The Ace Development Team (http://www.wowace.com/index.php/The_Ace_Development_Team)
Inspired By: Ace 1.x by Turan (turan@gryphon.com)
Website: http://www.wowace.com/
Documentation: http://www.wowace.com/index.php/AceDB-2.0
SVN: http://svn.wowace.com/wowace/trunk/Ace2/AceDB-2.0
Description: Mixin to allow for fast, clean, and featureful saved variable
             access.
License: LGPL v2.1
]]

vendor.AceDb20 = {}
vendor.AceDb20.prototype = {}
vendor.AceDb20.metatable = {__index = vendor.AceDb20.prototype}

local function safecall(func,...)
	local success, err = pcall(func,...)
	if not success then geterrorhandler()(err) end
end

local ACTIVE, ENABLED, STATE, TOGGLE_ACTIVE, MAP_ACTIVESUSPENDED, SET_PROFILE, SET_PROFILE_USAGE, PROFILE, PLAYER_OF_REALM, CHOOSE_PROFILE_DESC, CHOOSE_PROFILE_GUI, COPY_PROFILE_DESC, COPY_PROFILE_GUI, OTHER_PROFILE_DESC, OTHER_PROFILE_GUI, OTHER_PROFILE_USAGE, RESET_PROFILE, RESET_PROFILE_DESC, CHARACTER_COLON, REALM_COLON, CLASS_COLON, DEFAULT, ALTERNATIVE

-- Move these into "enUS" when they've been translated in all other locales
local DELETE_PROFILE = "Delete"
local DELETE_PROFILE_DESC = "Deletes a profile. Note that no check is made whether this profile is in use by other characters or not."
local DELETE_PROFILE_USAGE = "<profile name>"

	ACTIVE = "Active"
	ENABLED = "Enabled"
	STATE = "State"
	TOGGLE_ACTIVE = "Suspend/resume this addon."
	MAP_ACTIVESUSPENDED = { [true] = "|cff00ff00Active|r", [false] = "|cffff0000Suspended|r" }
	SET_PROFILE = "Set profile for this addon."
	SET_PROFILE_USAGE = "{char || class || realm || <profile name>}"
	PROFILE = "Profile"
	PLAYER_OF_REALM = "%s of %s"
	CHOOSE_PROFILE_DESC = "Choose a profile."
	CHOOSE_PROFILE_GUI = "Choose"
	COPY_PROFILE_DESC = "Copy settings from another profile."
	COPY_PROFILE_GUI = "Copy from"
	OTHER_PROFILE_DESC = "Choose another profile."
	OTHER_PROFILE_GUI = "Other"
	OTHER_PROFILE_USAGE = "<profile name>"
	RESET_PROFILE = "Reset profile"
	RESET_PROFILE_DESC = "Clear all settings of the current profile."

	CHARACTER_COLON = "Character: "
	REALM_COLON = "Realm: "
	CLASS_COLON = "Class: "

	DEFAULT = "Default"
	ALTERNATIVE = "Alternative"
	
local convertFromOldCharID
do
	local matchStr = "^" .. PLAYER_OF_REALM:gsub("([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1"):gsub("%%s", "(.+)") .. "$"
	function convertFromOldCharID(str)
		local player, realm = str:match(matchStr)
		if not player then
			return str
		end
		return player .. " - " .. realm
	end
end

local _G = getfenv(0)

local function inheritDefaults(t, defaults)
	if not defaults then
		return t
	end
	for k,v in pairs(defaults) do
		if k == "*" or k == "**" then
			local v = v
			if type(v) == "table" then
				setmetatable(t, {
					__index = function(self, key)
						if key == nil then
							return nil
						end
						self[key] = {}
						inheritDefaults(self[key], v)
						return self[key]
					end
				} )
			else
				setmetatable(t, {
					__index = function(self, key)
						if key == nil then
							return nil
						end
						self[key] = v
						return self[key]
					end
				} )
			end
			for key in pairs(t) do
				if (defaults[key] == nil or key == k) and type(t[key]) == "table" then
					inheritDefaults(t[key], v)
				end
			end
		else
			if type(v) == "table" then
				if type(rawget(t, k)) ~= "table" then
					t[k] = {}
				end
				inheritDefaults(t[k], v)
				if defaults["**"] then
					inheritDefaults(t[k], defaults["**"])
				end
			elseif rawget(t, k) == nil then
				t[k] = v
			end
		end
	end
	return t
end

local _,race = UnitRace("player")
local faction
if race == "Orc" or race == "Scourge" or race == "Troll" or race == "Tauren" or race == "BloodElf" then
	faction = FACTION_HORDE
else
	faction = FACTION_ALLIANCE
end
local server = GetRealmName():trim()
local charID = UnitName("player") .. " - " .. server
local realmID = server .. " - " .. faction
local classID = UnitClass("player")

vendor.AceDb20.prototype.CHAR_ID = charID
vendor.AceDb20.prototype.REALM_ID = realmID
vendor.AceDb20.prototype.CLASS_ID = classID

vendor.AceDb20.prototype.FACTION = faction
vendor.AceDb20.prototype.REALM = server
vendor.AceDb20.prototype.NAME = UnitName("player")

local new, del
do
	local list = setmetatable({}, {__mode="k"})
	function new()
		local t = next(list)
		if t then
			list[t] = nil
			return t
		else
			return {}
		end
	end

	function del(t)
		setmetatable(t, nil)
		for k in pairs(t) do
			t[k] = nil
		end
		list[t] = true
	end
end

local caseInsensitive_mt = {
	__index = function(self, key)
		if type(key) ~= "string" then
			return nil
		end
		local lowerKey = key:lower()
		for k,v in pairs(self) do
			if k:lower() == lowerKey then
				return self[k]
			end
		end
	end,
	__newindex = function(self, key, value)
		if type(key) ~= "string" then
			return error("table index is nil", 2)
		end
		local lowerKey = key:lower()
		for k in pairs(self) do
			if k:lower() == lowerKey then
				rawset(self, k, nil)
				rawset(self, key, value)
				return
			end
		end
		rawset(self, key, value)
	end
}

local db_mt = { __index = function(db, key)
	if key == "char" then
		if db.charName then
			if type(_G[db.charName]) ~= "table" then
				_G[db.charName] = {}
			end
			if type(_G[db.charName].global) ~= "table" then
				_G[db.charName].global = {}
			end
			rawset(db, 'char', _G[db.charName].global)
		else
			if type(db.raw.chars) ~= "table" then
				db.raw.chars = {}
			end
			local id = charID
			if type(db.raw.chars[id]) ~= "table" then
				db.raw.chars[id] = {}
			end
			rawset(db, 'char', db.raw.chars[id])
		end
		if db.defaults and db.defaults.char then
			inheritDefaults(db.char, db.defaults.char)
		end
		return db.char
	elseif key == "realm" then
		if type(db.raw.realms) ~= "table" then
			db.raw.realms = {}
		end
		local id = realmID
		if type(db.raw.realms[id]) ~= "table" then
			db.raw.realms[id] = {}
		end
		rawset(db, 'realm', db.raw.realms[id])
		if db.defaults and db.defaults.realm then
			inheritDefaults(db.realm, db.defaults.realm)
		end
		return db.realm
	elseif key == "server" then
		if type(db.raw.servers) ~= "table" then
			db.raw.servers = {}
		end
		local id = server
		if type(db.raw.servers[id]) ~= "table" then
			db.raw.servers[id] = {}
		end
		rawset(db, 'server', db.raw.servers[id])
		if db.defaults and db.defaults.server then
			inheritDefaults(db.server, db.defaults.server)
		end
		return db.server
	elseif key == "account" then
		if type(db.raw.account) ~= "table" then
			db.raw.account = {}
		end
		rawset(db, 'account', db.raw.account)
		if db.defaults and db.defaults.account then
			inheritDefaults(db.account, db.defaults.account)
		end
		return db.account
	elseif key == "faction" then
		if type(db.raw.factions) ~= "table" then
			db.raw.factions = {}
		end
		local id = faction
		if type(db.raw.factions[id]) ~= "table" then
			db.raw.factions[id] = {}
		end
		rawset(db, 'faction', db.raw.factions[id])
		if db.defaults and db.defaults.faction then
			inheritDefaults(db.faction, db.defaults.faction)
		end
		return db.faction
	elseif key == "class" then
		if type(db.raw.classes) ~= "table" then
			db.raw.classes = {}
		end
		local id = classID
		if type(db.raw.classes[id]) ~= "table" then
			db.raw.classes[id] = {}
		end
		rawset(db, 'class', db.raw.classes[id])
		if db.defaults and db.defaults.class then
			inheritDefaults(db.class, db.defaults.class)
		end
		return db.class
	elseif key == "profile" then
		if type(db.raw.profiles) ~= "table" then
			db.raw.profiles = setmetatable({}, caseInsensitive_mt)
		else
			setmetatable(db.raw.profiles, caseInsensitive_mt)
		end
		local id = db.raw.currentProfile[charID]
		if id == "char" then
			id = "char/" .. charID
		elseif id == "class" then
			id = "class/" .. classID
		elseif id == "realm" then
			id = "realm/" .. realmID
		end
		if type(db.raw.profiles[id]) ~= "table" then
			db.raw.profiles[id] = {}
		end
		rawset(db, 'profile', db.raw.profiles[id])
		if db.defaults and db.defaults.profile then
			inheritDefaults(db.profile, db.defaults.profile)
		end
		return db.profile
	elseif key == "raw" or key == "defaults" or key == "name" or key == "charName" or key == "namespaces" then
		return nil
	end
	error(("Cannot access key %q in db table. You may want to use db.profile[%q]"):format(tostring(key), tostring(key)), 2)
end, __newindex = function(db, key, value)
	error(("Cannot access key %q in db table. You may want to use db.profile[%q]"):format(tostring(key), tostring(key)), 2)
end }

local function RecalculateAceDBCopyFromList(target)
	local db = target.db
	local t = target['acedb-profile-copylist']
	for k,v in pairs(t) do
		t[k] = nil
	end
	local _,currentProfile = vendor.AceDb20.prototype.GetProfile(target)
	if db and db.raw then
		if db.raw.profiles then
			for k in pairs(db.raw.profiles) do
				if currentProfile ~= k then
					if k:find("^char/") then
						local name = k:sub(6)
						local player, realm = name:match("^(.*) %- (.*)$")
						if player then
							name = PLAYER_OF_REALM:format(player, realm)
						end
						t[k] = CHARACTER_COLON .. name
					elseif k:find("^realm/") then
						local name = k:sub(7)
						t[k] = REALM_COLON .. name
					elseif k:find("^class/") then
						local name = k:sub(7)
						t[k] = CLASS_COLON .. name
					else
						t[k] = k
					end
				end
			end
		end
		if db.raw.namespaces then
			for _,n in pairs(db.raw.namespaces) do
				if n.profiles then
					for k in pairs(n.profiles) do
						if currentProfile ~= k then
							if k:find('^char/') then
								local name = k:sub(6)
								local player, realm = name:match("^(.*) %- (.*)$")
								if player then
									name = PLAYER_OF_REALM:format(player, realm)
								end
								t[k] = CHARACTER_COLON .. name
							elseif k:find('^realm/') then
								local name = k:sub(7)
								t[k] = REALM_COLON .. name
							elseif k:find('^class/') then
								local name = k:sub(7)
								t[k] = CLASS_COLON .. name
							else
								t[k] = k
							end
						end
					end
				end
			end
		end
	end
	if t.Default then
		t.Default = DEFAULT
	end
	if t.Alternative then
		t.Alternative = ALTERNATIVE
	end
end

local function RecalculateAceDBProfileList(target)
	local t = target['acedb-profile-list']
	for k,v in pairs(t) do
		t[k] = nil
	end
	t.char = CHARACTER_COLON .. PLAYER_OF_REALM:format(UnitName("player"), server)
	t.realm = REALM_COLON .. realmID
	t.class = CLASS_COLON .. classID
	t.Default = DEFAULT
	local db = target.db
	if db and db.raw then
		if db.raw.profiles then
			for k in pairs(db.raw.profiles) do
				if not k:find("^char/") and not k:find("^realm/") and not k:find("^class/") then
					t[k] = k
				end
			end
		end
		if db.raw.namespaces then
			for _,n in pairs(db.raw.namespaces) do
				if n.profiles then
					for k in pairs(n.profiles) do
						if not k:find("^char/") and not k:find("^realm/") and not k:find("^class/") then
							t[k] = k
						end
					end
				end
			end
		end
		local curr = db.raw.currentProfile and db.raw.currentProfile[charID]
		if curr and not t[curr] then
			t[curr] = curr
		end
	end
	if t.Alternative then
		t.Alternative = ALTERNATIVE
	end
end

local CrawlForSerialization
local CrawlForDeserialization

local function SerializeObject(o)
	local t = { o:Serialize() }
	CrawlForSerialization(t)
	t[0] = o.class:GetLibraryVersion()
	return t
end

local function DeserializeObject(t)
	CrawlForDeserialization(t)
	local className = t[0]
	t[0] = nil
	return AceLibrary(className):Deserialize(unpack(t))
end

local function IsSerializable(t)
	return t.class and type(t.class.Deserialize) == "function" and type(t.Serialize) == "function" and type(t.class.GetLibraryVersion) == "function"
end

local function CrawlForSerialization(t)
	local tmp = new()
	for k,v in pairs(t) do
		tmp[k] = v
	end
	for k,v in pairs(tmp) do
		if type(v) == "table" and type(rawget(v, 0)) ~= "userdata" then
			if IsSerializable(v) then
				v = SerializeObject(v)
				t[k] = v
			else
				CrawlForSerialization(v)
			end
		end
		if type(k) == "table" and type(rawget(k, 0)) ~= "userdata" then
			if IsSerializable(k) then
				t[k] = nil
				t[SerializeObject(k)] = v
			else
				CrawlForSerialization(k)
			end
		end
		tmp[k] = nil
		k = nil
	end
	tmp = del(tmp)
end

local function IsDeserializable(t)
	return type(rawget(t, 0)) == "string" and AceLibrary:HasInstance(rawget(t, 0))
end

local function CrawlForDeserialization(t)
	local tmp = new()
	for k,v in pairs(t) do
		tmp[k] = v
	end
	for k,v in pairs(tmp) do
		if type(v) == "table" then
			if IsDeserializable(v) then
				t[k] = DeserializeObject(v)
				del(v)
				v = t[k]
			elseif type(rawget(v, 0)) ~= "userdata" then
				CrawlForDeserialization(v)
			end
		end
		if type(k) == "table" then
			if IsDeserializable(k) then
				t[k] = nil
				t[DeserializeObject(k)] = v
				del(k)
			elseif type(rawget(k, 0)) ~= "userdata" then
				CrawlForDeserialization(k)
			end
		end
		tmp[k] = nil
		k = nil
	end
	tmp = del(tmp)
end

local namespace_mt = { __index = function(namespace, key)
	local db = namespace.db
	local name = namespace.name
	if key == "char" then
		if db.charName then
			if type(_G[db.charName]) ~= "table" then
				_G[db.charName] = {}
			end
			if type(_G[db.charName].namespaces) ~= "table" then
				_G[db.charName].namespaces = {}
			end
			if type(_G[db.charName].namespaces[name]) ~= "table" then
				_G[db.charName].namespaces[name] = {}
			end
			rawset(namespace, 'char', _G[db.charName].namespaces[name])
		else
			if type(db.raw.namespaces) ~= "table" then
				db.raw.namespaces = {}
			end
			if type(db.raw.namespaces[name]) ~= "table" then
				db.raw.namespaces[name] = {}
			end
			if type(db.raw.namespaces[name].chars) ~= "table" then
				db.raw.namespaces[name].chars = {}
			end
			local id = charID
			if type(db.raw.namespaces[name].chars[id]) ~= "table" then
				db.raw.namespaces[name].chars[id] = {}
			end
			rawset(namespace, 'char', db.raw.namespaces[name].chars[id])
		end
		if namespace.defaults and namespace.defaults.char then
			inheritDefaults(namespace.char, namespace.defaults.char)
		end
		return namespace.char
	elseif key == "realm" then
		if type(db.raw.namespaces) ~= "table" then
			db.raw.namespaces = {}
		end
		if type(db.raw.namespaces[name]) ~= "table" then
			db.raw.namespaces[name] = {}
		end
		if type(db.raw.namespaces[name].realms) ~= "table" then
			db.raw.namespaces[name].realms = {}
		end
		local id = realmID
		if type(db.raw.namespaces[name].realms[id]) ~= "table" then
			db.raw.namespaces[name].realms[id] = {}
		end
		rawset(namespace, 'realm', db.raw.namespaces[name].realms[id])
		if namespace.defaults and namespace.defaults.realm then
			inheritDefaults(namespace.realm, namespace.defaults.realm)
		end
		return namespace.realm
	elseif key == "server" then
		if type(db.raw.namespaces) ~= "table" then
			db.raw.namespaces = {}
		end
		if type(db.raw.namespaces[name]) ~= "table" then
			db.raw.namespaces[name] = {}
		end
		if type(db.raw.namespaces[name].servers) ~= "table" then
			db.raw.namespaces[name].servers = {}
		end
		local id = server
		if type(db.raw.namespaces[name].servers[id]) ~= "table" then
			db.raw.namespaces[name].servers[id] = {}
		end
		rawset(namespace, 'server', db.raw.namespaces[name].servers[id])
		if namespace.defaults and namespace.defaults.server then
			inheritDefaults(namespace.server, namespace.defaults.server)
		end
		return namespace.server
	elseif key == "account" then
		if type(db.raw.namespaces) ~= "table" then
			db.raw.namespaces = {}
		end
		if type(db.raw.namespaces[name]) ~= "table" then
			db.raw.namespaces[name] = {}
		end
		if type(db.raw.namespaces[name].account) ~= "table" then
			db.raw.namespaces[name].account = {}
		end
		rawset(namespace, 'account', db.raw.namespaces[name].account)
		if namespace.defaults and namespace.defaults.account then
			inheritDefaults(namespace.account, namespace.defaults.account)
		end
		return namespace.account
	elseif key == "faction" then
		if type(db.raw.namespaces) ~= "table" then
			db.raw.namespaces = {}
		end
		if type(db.raw.namespaces[name]) ~= "table" then
			db.raw.namespaces[name] = {}
		end
		if type(db.raw.namespaces[name].factions) ~= "table" then
			db.raw.namespaces[name].factions = {}
		end
		local id = faction
		if type(db.raw.namespaces[name].factions[id]) ~= "table" then
			db.raw.namespaces[name].factions[id] = {}
		end
		rawset(namespace, 'faction', db.raw.namespaces[name].factions[id])
		if namespace.defaults and namespace.defaults.faction then
			inheritDefaults(namespace.faction, namespace.defaults.faction)
		end
		return namespace.faction
	elseif key == "class" then
		if type(db.raw.namespaces) ~= "table" then
			db.raw.namespaces = {}
		end
		if type(db.raw.namespaces[name]) ~= "table" then
			db.raw.namespaces[name] = {}
		end
		if type(db.raw.namespaces[name].classes) ~= "table" then
			db.raw.namespaces[name].classes = {}
		end
		local id = classID
		if type(db.raw.namespaces[name].classes[id]) ~= "table" then
			db.raw.namespaces[name].classes[id] = {}
		end
		rawset(namespace, 'class', db.raw.namespaces[name].classes[id])
		if namespace.defaults and namespace.defaults.class then
			inheritDefaults(namespace.class, namespace.defaults.class)
		end
		return namespace.class
	elseif key == "profile" then
		if type(db.raw.namespaces) ~= "table" then
			db.raw.namespaces = {}
		end
		if type(db.raw.namespaces[name]) ~= "table" then
			db.raw.namespaces[name] = {}
		end
		if type(db.raw.namespaces[name].profiles) ~= "table" then
			db.raw.namespaces[name].profiles = setmetatable({}, caseInsensitive_mt)
		else
			setmetatable(db.raw.namespaces[name].profiles, caseInsensitive_mt)
		end
		local id = db.raw.currentProfile[charID]
		if id == "char" then
			id = "char/" .. charID
		elseif id == "class" then
			id = "class/" .. classID
		elseif id == "realm" then
			id = "realm/" .. realmID
		end
		if type(db.raw.namespaces[name].profiles[id]) ~= "table" then
			db.raw.namespaces[name].profiles[id] = {}
		end
		rawset(namespace, 'profile', db.raw.namespaces[name].profiles[id])
		if namespace.defaults and namespace.defaults.profile then
			inheritDefaults(namespace.profile, namespace.defaults.profile)
		end
		return namespace.profile
	elseif key == "defaults" or key == "name" or key == "db" then
		return nil
	end
	error(("Cannot access key %q in db table. You may want to use db.profile[%q]"):format(tostring(key), tostring(key)), 2)
end, __newindex = function(db, key, value)
	error(("Cannot access key %q in db table. You may want to use db.profile[%q]"):format(tostring(key), tostring(key)), 2)
end }

local tmp = {}

--[[ 
	Creates a new instance.
--]]
function vendor.AceDb20:new()
	local instance = setmetatable({}, self.metatable)
	instance.registry = {}
	return instance
end

function vendor.AceDb20.prototype:InitializeDB(addonName)
	local db = self.db

	if db.raw then
		-- someone manually initialized
		return
	end

	if type(_G[db.name]) ~= "table" then
		_G[db.name] = {}
	else
		CrawlForDeserialization(_G[db.name])
	end
	if db.charName then
		if type(_G[db.charName]) ~= "table" then
			_G[db.charName] = {}
		else
			CrawlForDeserialization(_G[db.charName])
		end
	end
	rawset(db, 'raw', _G[db.name])
	if not db.raw.currentProfile then
		db.raw.currentProfile = {}
	else
		for k,v in pairs(db.raw.currentProfile) do
			tmp[convertFromOldCharID(k)] = v
			db.raw.currentProfile[k] = nil
		end
		for k,v in pairs(tmp) do
			db.raw.currentProfile[k] = v
			tmp[k] = nil
		end
	end
	if not db.raw.currentProfile[charID] then
		db.raw.currentProfile[charID] = self.registry[self] or "Default"
	end
	if db.raw.profiles then
		for k,v in pairs(db.raw.profiles) do
			local new_k = k
			if k:find("^char/") then
				new_k = "char/" .. convertFromOldCharID(k:sub(6))
			end
			tmp[new_k] = v
			db.raw.profiles[k] = nil
		end
		for k,v in pairs(tmp) do
			db.raw.profiles[k] = v
			tmp[k] = nil
		end
	end
	if db.raw.disabledModules then -- AceModuleCore-2.0
		for k,v in pairs(db.raw.disabledModules) do
			local new_k = k
			if k:find("^char/") then
				new_k = "char/" .. convertFromOldCharID(k:sub(6))
			end
			tmp[new_k] = v
			db.raw.disabledModules[k] = nil
		end
		for k,v in pairs(tmp) do
			db.raw.disabledModules[k] = v
			tmp[k] = nil
		end
	end
	if db.raw.chars then
		for k,v in pairs(db.raw.chars) do
			tmp[convertFromOldCharID(k)] = v
			db.raw.chars[k] = nil
		end
		for k,v in pairs(tmp) do
			db.raw.chars[k] = v
			tmp[k] = nil
		end
	end
	if db.raw.namespaces then
		for l,u in pairs(db.raw.namespaces) do
			if u.chars then
				for k,v in pairs(u.chars) do
					tmp[convertFromOldCharID(k)] = v
					u.chars[k] = nil
				end
				for k,v in pairs(tmp) do
					u.chars[k] = v
					tmp[k] = nil
				end
			end
		end
	end
	if db.raw.disabled then
		setmetatable(db.raw.disabled, caseInsensitive_mt)
	end
	if self['acedb-profile-copylist'] then
		RecalculateAceDBCopyFromList(self)
	end
	if self['acedb-profile-list'] then
		RecalculateAceDBProfileList(self)
	end
	setmetatable(db, db_mt)
end

function vendor.AceDb20.prototype:RegisterDB(name, charName, defaultProfile)
	if self.db then
		error("Cannot call \"RegisterDB\" if self.db is set.")
	end
	local stack = debugstack()
	local addonName = stack:gsub(".-\n.-\\AddOns\\(.-)\\.*", "%1")
	self.db = {
		name = name,
		charName = charName
	}
	self.registry[self] = defaultProfile or "Default"
	self.InitializeDB(self, addonName)
end

function vendor.AceDb20.prototype:GetProfile()
	if not self.db or not self.db.raw then
		return nil
	end
	if not self.db.raw.currentProfile then
		self.db.raw.currentProfile = {}
	end
	if not self.db.raw.currentProfile[charID] then
		self.db.raw.currentProfile[charID] = self.registry[self] or "Default"
	end
	local profile = self.db.raw.currentProfile[charID]
	if profile == "char" then
		return "char", "char/" .. charID
	elseif profile == "class" then
		return "class", "class/" .. classID
	elseif profile == "realm" then
		return "realm", "realm/" .. realmID
	end
	return profile, profile
end

local function copyTable(to, from)
	setmetatable(to, nil)
	for k,v in pairs(from) do
		if type(k) == "table" then
			k = copyTable({}, k)
		end
		if type(v) == "table" then
			v = copyTable({}, v)
		end
		to[k] = v
	end
	setmetatable(to, from)
	return to
end

function vendor.AceDb20.prototype:IsActive()
	return not self.db or not self.db.raw or not self.db.raw.disabled or not self.db.raw.disabled[self.db.raw.currentProfile[charID]]
end

function vendor.AceDb20.prototype:AcquireDBNamespace(name)
	local db = self.db
	if not db then
		error("Cannot call `AcquireDBNamespace' before `RegisterDB' has been called.", 2)
	end
	if not db.namespaces then
		rawset(db, 'namespaces', {})
	end
	if not db.namespaces[name] then
		local namespace = {}
		db.namespaces[name] = namespace
		namespace.db = db
		namespace.name = name
		setmetatable(namespace, namespace_mt)
	end
	return db.namespaces[name]
end
