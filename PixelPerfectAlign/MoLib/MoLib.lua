--[[
  MoLib -- (c) 2009-2019 moorea@ymail.com (MooreaTv)
  Covered by the GNU Lesser General Public License v3.0 (LGPLv3)
  NO WARRANTY
  (contact the author if you need a different license)

  MoLib library sources are at https://github.com/mooreatv/MoLib
]] --
--
-- name of the addon embedding us, our empty default anonymous ns (not used)
local addon, _ns = ...

-- install into addon's namespace by default
if not _G[addon] then
  -- we may not be the first file loaded in the addon, create its global NS if we are
  _G[addon] = {}
  -- Note that if we do that CreateFrame won't work later, so we shouldn't be loaded first for WhoTracker for instance
end

local ML = _G[addon]

ML.name = addon

if _G.WOW_PROJECT_ID == nil then
  ML.isLegacy = true
  ML.isClassic = false
  ML.isBurningCrusade = false
  ML.isClassicEra = false
  function IsInRaid()
    return (GetNumRaidMembers() > 0)
  end
  function GetNumGroupMembers()
	  return IsInRaid() and GetNumRaidMembers() or GetNumPartyMembers()
  end
  function UnitFullName(unit)
    local thisRealm = ML:NormalizeRealm(GetRealmName())
    local name, realm = UnitName(unit)
    if realm == nil or realm == "" then
      realm = thisRealm
    end
    return name, realm
  end
  function IsInGroup()
    return (GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0)
  end
  function UnitIsGroupLeader(unit)
    if not IsInGroup() then
      return false
    elseif unit == "player" then
      return (IsInRaid() and IsRaidLeader() or IsPartyLeader())
    else
      local index = strmatch(unit, "%d+")
      if IsInRaid() then
        return (index and select(2, GetRaidRosterInfo(index)) == 2)
      end
      return (index and GetPartyLeaderIndex() == tonumber(index))
    end
  end
else
    -- Cover both classic (2) and bc (5)
  ML.isLegacy = false
  ML.isClassic = (_G.WOW_PROJECT_ID >= _G.WOW_PROJECT_CLASSIC)
  ML.isBurningCrusade = (_G.WOW_PROJECT_ID >= (_G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5))
  ML.isWrath = (_G.WOW_PROJECT_ID >= (_G.WOW_PROJECT_WRATH_CLASSIC or 11))
  ML.isClassicEra = (_G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC)
end

ML.Factions = {"Horde", "Alliance", "Neutral"}

function ML:deepmerge(dstTable, dstKey, src)
  if type(src) ~= 'table' then
    if not dstKey then
      self:ErrorAndThrow("can't call deepmerge on nil key % with src not a table: %", dstKey, src)
    end
    dstTable[dstKey] = src
    return
  end
  if dstKey then
    if not dstTable[dstKey] then
      dstTable[dstKey] = {}
    end
    dstTable = dstTable[dstKey]
  end
  for k, v in pairs(src) do
    ML:deepmerge(dstTable, k, v)
  end
end

-- Deep Clone a src table into a new returned copy, nil input returns an empty table
-- if src is not a table, it is inserted in the resulting table
function ML:CloneTable(src)
  local copy = {}
  if src == nil then
    return copy
  end
  if type(src) ~= 'table' then
    table.insert(copy, src)
  end
  ML:deepmerge(copy, nil, src)
  return copy
end

function ML:MoLibInstallInto(namespace, name)
  ML:deepmerge(namespace, nil, ML)
  namespace.name = name
  namespace:Print("MoLib aliased into " .. name)
end

-- to force debug from empty state, uncomment: (otherwise "/<addon> debug on" to turn on later
-- and /reload to get it save/start over)
-- ML.debug = 1

ML.sessionLog = {}

function ML:Print(msg, ...)
  for _, line in ipairs({ strsplit("\n",msg)}) do
        DEFAULT_CHAT_FRAME:AddMessage(line, ...)
  end
  table.insert(self.sessionLog, msg)
end

-- Escapes non printable characters
function ML:EscNonPrintable(str)
  local s, _count = gsub(str, "%c", function(match)
    if match == "\n" then -- maybe add \r too but...
      return match
    end
    return string.format("\\%03d", string.byte(match))
  end)
  return s
end

-- Escapes non printable characters (copy pasted most from
-- previous function for efficiency as we do this a lot)
function ML:EscNonPrintableAndPipe(str)
  local s = gsub(str, "[%c|]", function(match)
    if match == "\n" then -- maybe add \r too but...
      return match
    end
    if match == "|" then
      return "||"
    end
    return string.format("\\%03d", string.byte(match))
  end)
  s = gsub(s, "||||", "||") -- we can double escape pipes when going through layers
  return s
end

-- like format except simpler... just use % to replace a value that will be tostring()'ed
-- string arguments are quoted (ie "Zone") so you can distinguish nil from "nil" etc
-- and works for all types (like boolean), unlike format
function ML:format(fmtstr, firstarg, ...)
  local i = fmtstr:find("%%")
  if not i then
    return fmtstr -- no % in the format string anymore, we're done with literal value returned
  end
  local t = type(firstarg)
  local s
  if t == "string" then -- if the argument is a string, quote it, also escape | sequences
    s = '"' .. self:EscNonPrintableAndPipe(firstarg) .. '"'
  elseif t == "table" then
    local tt = {}
    local seen = {id = 0, t = {}}
    ML.DumpT.table(tt, firstarg, seen)
    s = table.concat(tt, "")
  else
    s = tostring(firstarg)
  end
  -- emit the part of the format string up to %, the processed first argument and recurse with the rest
  return fmtstr:sub(1, i - 1) .. s .. ML:format(fmtstr:sub(i + 1), ...)
end

-- Use: YourAddon:Debug("foo is %, bar is %!", foo, bar)
-- must be called with : (as method, to access state)
-- first argument is optional debug level for more verbose level set to 9
function ML:Debug(level, ...)
  if not self.debug then
    return
  end
  if type(level) == "number" then
    if level > self.debug then
      return
    end
    self:debugPrint(level, ...)
  else
    -- level was omitted
    self:debugPrint(1, level, ...)
  end
end

function ML:debugPrint(level, ...)
  local ts = string.format("%05.2f ", (100 * select(2, math.modf(GetTime() / 100)) + 0.5))
  self:Print(ts .. self.name .. " DBG[" .. tostring(level) .. "]: " .. ML:format(...), .1, .65, .1)
end

function ML:Error(...)
  self:Print(self.name .. " Error: " .. ML:format(...), 0.9, .1, .1)
end

function ML:ErrorAndThrow(...)
  local msg = self.name .. " Error: " .. ML:format(...)
  self:Print(msg, 0.9, .1, .1)
  self:BugReport("MoLib detected bug, email moorea@ymail.com", msg .. "\nStack:\n" .. debugstack(2))
  error(msg)
end

function ML:Warning(...)
  self:Print(self.name .. " Warning: " .. ML:format(...), 0.96, 0.63, 0.26)
end

function ML:DebugStack(...)
  self:Print(self.name .. " Debug: " .. ML:format(...) .. ". Stack:\n" .. debugstack(2, 4, 3), 0.96, 0.63, 0.26)
end

-- color translations
function ML:RgbToHex(r, g, b, a)
  local h = string.format("%02X%02X%02X", 255 * r, 255 * g, 255 * b)
  if not a then
    return h
  end
  return string.format("%02X", 255 * a) .. h
end

-- default printing (white) with our formatting
function ML:PrintDefault(...)
  self:Print(ML:format(...))
end

-- info printing (blue-ish) with our formatting, for more important messages, not warning/errors
function ML:PrintInfo(...)
  self:Print(ML:format(...), .6, .9, 1)
end

ML.initNotDone = 1
ML.manifestVersion = GetAddOnMetadata(addon, "Version")
local globe = "MooreaTvLibrary"

-- Returns 1 if already done; must be called with : (as method, to access state)
function ML:MoLibInit()
  if not (self.initNotDone == 1) then
    return true
  end
  self.initNotDone = 0
  local version = addon .. " / " .. self.name .. " " .. ML.manifestVersion .. " / " .. _G[globe]
  local wowV, wowP = GetBuildInfo()
  self.WowVersion = " v" .. wowV .. "-" .. wowP
  self:Print("MoLib embedded in " .. version .. " running on WoW " ..
            (self.isLegacy and "legacy" or (self.isClassic and "classic" or "mainline")) ..
             " p" .. (_G.WOW_PROJECT_ID or 0) ..
               self.WowVersion)
  return false -- so caller can continue with 1 time init
end

-- Realm functions (optional, if used it needs the auto-generated Realms.lua)

function ML:InitRealms()
  if RealmIdsByName then
    self:Debug(8, "Init region already done")
    return
  end
  local reg = self:GetMyRegion()
  RealmIdsByName = {}
  for k, v in pairs(Realms) do
    local name, region = unpack(v)
    if region == reg then
      RealmIdsByName[name] = k
    end
  end
end

-- returns region (and not reliable realmid and namebyguid)
function ML:GetMyRegion()
  if self.myRegion then
    return self.myRegion, self.myRid, self.myRealmByGuid
  end
  if self.isClassic then
    self:Warning("No realm DB yet for classic so using 'classic' as the region for now.")
    self.myRegion = "classic"
    return self.myRegion, nil, nil
  end
  -- we can only get the region, not the server reliably from our own GUID
  self.myGuid = UnitGUID("player")
  self.myRid = ML:extractRealmID(self.myGuid)
  if not Realms[self.myRid] then
    self:Error("This realm id % (%) is unknown to Realm DB - please report!", self.myRid, GetRealmName())
    self.myRealmByGuid = "unknown"
    self.myRegion = "unknown"
  else
    self.myRealmByGuid, self.myRegion = unpack(Realms[self.myRid])
  end
  return self.myRegion, self.myRid, self.myRealmByGuid -- don't rely on last 2
end

-- returns region, id, realm - reliable if id is reliable
function ML:GetRealmByID(id)
  local mapping = Realms[id]
  self:Debug("GetRealmByID %: %", id, mapping)
  if not mapping then
    return
  end
  return mapping[2], id, mapping[1]
end

function ML:GetUnitRealmUsingGuid(unit)
  unit = unit or "target"
  local guid = UnitGUID(unit)
  self:Debug("In UnitUsingGuid: GUID of % : %", unit, guid)
  return self:GetRealmByID(self:extractRealmID(guid))
end

function ML:GetRealRealm(unit)
  self:InitRealms()
  unit = unit or "target"
  local guid = UnitGUID(unit)
  self:Debug("In RealRealm: GUID of % : %", unit, guid)
  local _className, _classId, _raceName, _raceId, _gender, name, realm = GetPlayerInfoByGUID(guid)
  local n2 = ""
  if not realm or #realm == 0 then
    n2, realm = UnitFullName("player")
  end
  local id = RealmIdsByName[realm]
  local reg, _, rname = self:GetRealmByID(id)
  self:Debug(1, "% is % (%) from % -> % -> % %", unit, name, n2, realm, id, reg, rname)
  return reg, id, rname
end

function ML:extractRealmID(guid)
  if not guid then
    self:ErrorAndThrow("Can't extract realm id from nil guid")
  end
  local rid = tonumber(guid:match("^Player%-([0-9]+)%-"))
  if not rid then
    self:ErrorAndThrow("No match for expected Player-nnnn-... in %", guid)
  end
  return rid
end

function ML:RealmAbbrev(_str)
  -- Kil'Jaeden -> KJ
  -- Wyrmrest Accord -> WA or WrA
end

-- Start of handy poor man's "/dump" --

ML.DumpT = {}
ML.DumpT["string"] = function(into, v)
  table.insert(into, "\"")
  local e, _ = ML:EscNonPrintableAndPipe(v)
  table.insert(into, e)
  table.insert(into, "\"")
end
ML.DumpT["number"] = function(into, v)
  table.insert(into, tostring(v))
end
ML.DumpT["boolean"] = ML.DumpT["number"]

for _, t in next, {"function", "nil", "userdata"} do
  ML.DumpT[t] = function(into, _)
    table.insert(into, t)
  end
end

ML.DumpT["table"] = function(into, t, seen)
  if seen.t[t] then
    table.insert(into, "&" .. tostring(seen.t[t]))
    return
  end
  seen.id = seen.id + 1
  seen.t[t] = seen.id
  table.insert(into, ML:format("t%[", seen.id))
  local sep = ""
  for k, v in pairs(t) do
    table.insert(into, sep)
    sep = ", " -- inserts comma separator after the first one
    ML:DumpInto(into, k, seen) -- so we get the type/difference between [1] and ["1"]
    table.insert(into, " = ")
    ML:DumpInto(into, v, seen)
  end
  table.insert(into, "]")
end

function ML:DumpInto(into, v, seen)
  local type = type(v)
  if ML.DumpT[type] then
    ML.DumpT[type](into, v, seen)
  else
    table.insert(into, "<Unknown Type " .. type .. ">")
  end
end

function ML:Dump(...)
  local seen = {id = 0, t = {}}
  local into = {}
  for i = 1, select("#", ...) do
    if i > 1 then
      table.insert(into, " , ")
    end
    ML:DumpInto(into, select(i, ...), seen)
  end
  return table.concat(into, "")
end
-- End of handy poor man's "/dump" --

function ML:DebugEvCall(level, ...)
  self:Debug(level, "On ev " .. ML:Dump(...))
end

--- Lisp inspired functions ---

--- Returns the first argument (lisp's (car...)
function ML:first(first) -- implied , ...
  return first
end
--- Returns the remaining of the list after first argument (lisp's (cdr ...))
function ML:rest(_first, ...)
  return ...
end
--- Length of argument list
function ML:numArgs(...)
  return select("#", ...)
end
--- Map (in lisp term) applies function to each of the arguments
--- works when passed fn, x, nil, y and doesn't stop at first nil
function ML:Map(fn, ...)
  if self:numArgs(...) == 0 then
    -- end of recursion/we're done
    return
  end
  return fn(self:first(...)), self:Map(fn, self:rest(...))
end

--- end of lisp --

-- returns name, realm when passed a name-realm full name
function ML:SplitFullName(fullName)
  if type(fullName) ~= 'string' then
    self:DebugStack("trying to split non string %", fullName)
    return
  end
  return fullName:match("(.+)-(.+)")
end

function ML:NormalizeRealm(realm)
  return string.gsub(realm, "[ -]", "")
end

-- Returns the normalized fully qualified name of the player and the short name and the
-- normalized realm name
function ML:GetMyFQN()
  if self.myFullName and self.myRealm then
    self:Debug(4, "Returning already calculated GetMyFQN % % %", self.myFullName, self.myShortName, self.myRealm)
    return self.myFullName, self.myShortName, self.myRealm
  end
  local p, realm = UnitFullName("player")
  local rn = self:NormalizeRealm(GetRealmName())
  self:Debug(1, "GetMyFQN % , % - %", p, realm, rn)
  if realm then
    if realm ~= rn then
      self:Warning("GetMyFQN(): Unexpected difference between realm from UnitFullName % vs GetRealmName %", realm, rn)
    end
  else
    self:Warning("GetMyFQN(): Got nil realm from UnitFullName() trying GetRealmName() = % instead", rn)
    realm = rn
  end
  if not realm then
    self:ErrorAndThrow("GetMyFQN: Realm not yet available!, called too early (wait until PLAYER_ENTERING_WORLD)!")
  end
  self.myRealm = realm
  self.myShortName = p
  self.myFullName = p .. "-" .. realm
  return self.myFullName, self.myShortName, self.myRealm
end

-- returns fullname, shortname, realm, region
-- (ie GetMyFQN and GetMyRegion)
function ML:GetMyInfo()
  self:GetMyFQN()
  self:GetMyRegion()
  return self.myFullName, self.myShortName, self.myRealm, self.myRegion
end

ML.AlphaNum = {}
ML.Base64 = {}

-- Generate the 62 alphanums (A-Za-z0-9 but in 1 pass so not in order)
-- and the 64 std Base64 alphabet
for i = 1, 26 do
  local ascii = 64 + i -- 'A' - 1
  local upper = string.format("%c", ascii)
  local lower = string.format("%c", ascii + 32) -- 'a'-1
  ML.Base64[i] = upper
  ML.Base64[i + 26] = lower
  table.insert(ML.AlphaNum, upper)
  table.insert(ML.AlphaNum, lower)
  if i <= 10 then
    local digit = string.format("%c", 47 + i) -- '0'-1
    ML.Base64[i + 52] = digit
    table.insert(ML.AlphaNum, digit)
  end
end
ML.Base64[63] = "+"
ML.Base64[64] = "/"
ML:Debug("Done generating AlphaNum table, % elems: %", #ML.AlphaNum, ML.AlphaNum)
ML:Debug("and Base64 table, % elems: %", #ML.Base64, ML.Base64)

-- function ML:Base64Encode(_binary)
--  for i = 1, #binary, 3 do
--  end
-- end

-- takes either 1 fixed length argument or a range; eg RandomId(3,12) will generate a random id from 3 to 12 characters long
function ML:RandomId(len1, len2)
  local len = len1
  if len2 ~= nil then
    len = math.random(len1, len2)
  end
  local res = {}
  for _ = 1, len do
    table.insert(res, ML.AlphaNum[math.random(1, #ML.AlphaNum)])
  end
  local strRes = table.concat(res)
  self:Debug(8, "Generated % long id from alphabet of % characters: %", len, #ML.AlphaNum, strRes)
  return strRes
end

--  (binary) string to hex string
function ML:HexDump(input)
  local res = {}
  local fmt = string.format
  local byt = string.byte
  for i = 1, #input do
    table.insert(res, fmt("%02X", byt(input, i)))
  end
  return table.concat(res, "")
end

-- unsigned 32 bit number (like bit.bxor returns) to hex
ML.NumToHex = {}
for i = 0, 15 do
  table.insert(ML.NumToHex, i < 10 and tostring(i) or string.format("%c", 65 + i - 10)) -- A + i - 10; so A for 10...F for 15
end
ML:Debug("Done generating Hex table, % elems: %", #ML.NumToHex, ML.NumToHex)

function ML:ToHex(num)
  local r = {}
  for i = 8, 1, -1 do
    local v = num % 16
    num = (num - v) / 16
    r[i] = ML.NumToHex[v + 1]
  end
  return table.concat(r, "")
end

-- based on http://www.cse.yorku.ca/~oz/hash.html djb2 xor version for 32bits
-- and sdbm for another 32 bits
function ML:Hash(str)
  local hash1 = 0
  local hash2 = 0
  for i = 1, #str do
    -- don't hash the same characters with both or one could use the hash values to reverse the process
    local c = string.byte(str, i)
    if i % 2 == 1 then
      hash1 = bit.bxor(33 * hash1, c)
    else
      -- c + (hash << 6) + (hash << 16) - hash;
      hash2 = c + bit.lshift(hash2, 6) + bit.lshift(hash2, 16) - hash2
    end
  end
  return hash1, hash2
end
-- returns a short printable 1 character hash and 2 long numerical 32 bit hashes
function ML:ShortHash(str)
  local hash1, hash2 = ML:Hash(str)
  return ML.AlphaNum[1 + (bit.bxor(hash1, hash2) % #ML.AlphaNum)], hash1, hash2
end

-- add hash key at the end of text
function ML:AddHashKey(text)
  local hashC = ML:ShortHash(text)
  self:Debug(3, "Hashed % adding %", text, hashC)
  return text .. hashC
end

-- checks correctness of hash and returns the pair true, original
-- if correct, false otherwise (do check that first return arg!)
function ML:UnHash(str)
  if type(str) ~= 'string' then
    self:Debug(1, "Passed non string % to UnHash!", str)
    return false
  end
  local lastC = string.sub(str, #str) -- last character is ascii/alphanum so this works
  local begin = string.sub(str, 1, #str - 1)
  local sh = ML:ShortHash(begin)
  self:Debug(3, "Hash of % is %, expecting %", begin, sh, lastC)
  return lastC == sh, begin -- hopefully caller does check first value
end

-- sign a payload with a secret (ie simply hash the two)
function ML:Sign(str, secret)
  local hash1, hash2 = ML:Hash(str .. secret)
  return ML:ToHex(hash1) .. ML:ToHex(hash2)
end

-- creates a time limited secure message based on two tokens, one exposed, one staying secret
-- adds noise plus timestamp to payload to avoid replay and guessing secret based on observing
-- messages (though that's still doable because the hashing function we use isn't cryptographically
-- secure, but if only a handful of messages are exchanged, or the tokens change often enough, it
-- should be secure, feedback/analysis welcome about it!)
-- note that the resulting message is signed (tries to prevent spoofing and confirms authenticity),
-- not encrypted (the original message is visible in clear in the resulting string).
-- the signature is returned to be used as unique (well, within 32 bits) messageId
-- ps: well aware of https://www.vice.com/en_us/article/wnx8nq/why-you-dont-roll-your-own-crypto
function ML:CreateSecureMessage(msg, visibleToken, secretToken)
  local base = visibleToken .. ":" .. msg .. ":" .. self:RandomId(4) .. tostring(GetServerTime()) .. ":"
  local sig = ML:Sign(base, secretToken)
  return base .. sig, sig
end

-- in case some server's time are out of sync by a few seconds
ML.secureFutureThreshold = -5
-- shouldn't need to be so high but some addons are verbose and consuming msg'ing bandwith/trigger throttle
ML.securePastThreshold = 45

-- parse and checks validity of a message created with CreateSecureMessage
-- returns false and an error message if invalid
-- true, the original message, lag , messageId when valid
-- (lag can only be between -5 and +60 seconds otherwise the message is rejected
-- and messageId is the signature of the message)
function ML:VerifySecureMessage(msg, visibleToken, secretToken)
  -- skip the 4 noise characters to get to timestamp (todo: detect lack of entropy/fixed/hacked noise,
  -- but hopefully the time part covers that)
  local b, v, m, t, s = msg:match("^(([^:]+):(.+):....([^:]+):)([^:]+)$")
  if v ~= visibleToken then
    self:Debug(2, "Token mismatch (% vs %) in msg %", v, visibleToken, msg)
    return false, self:format("Token mismatch (% vs %)", v, visibleToken)
  end
  if ML:Sign(b, secretToken) ~= s then
    self:Debug(2, "Invalid signature in msg %", msg)
    return false, "Invalid signature"
  end
  local now = GetServerTime()
  local msgTs = tonumber(t)
  if not msgTs then
    self:Debug(1, "Invalid message timestamp % in %", t, msg)
    return false, self:format("Timestamp % is not a number", t)
  end
  local delta = now - msgTs
  if delta < self.secureFutureThreshold then
    self:Debug(1, "Invalid message from %s in future % vs % in %", delta, msgTs, now, msg)
    return false, self:format("message from %s in future % vs %", delta, msgTs, now)
  end
  if delta > self.securePastThreshold then
    self:Debug(3, "Message %s in past, too old (replay attack? lag/throttling?) % vs % in %", delta, msgTs, now, msg)
    return false, self:format("message %s in the past", delta)
  end
  -- all good!
  return true, m, delta, s
end

-- Returns an escaped string such as it can be used literally
-- as a string.gsub(haystack, needle, replace) needle (ie escapes %?*-...)
function ML:GsubEsc(str)
  if not str then
    self:Debug(1, "Unexpected GsubEsc of nil")
    return ""
  end
  -- escape ( ) . % + - * ? [ ^ $
  local sub, _ = string.gsub(str, "[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1")
  return sub
end

function ML:ReplaceAll(haystack, needle, replace, ...)
  -- only need to escape % on replace but a few more won't hurt
  if not haystack then
    self:Debug(1, "Called replace all on % % %", haystack, needle, replace)
    return "", 0
  end
  return string.gsub(haystack, ML:GsubEsc(needle), ML:GsubEsc(replace), ...)
end

-- returns true if str starts with prefix and calls the optional function cb
-- with the reminder, false otherwise
function ML:StartsWith(str, prefix, cb)
  if not prefix then
    if cb then
      cb("") -- being extra nice to caller passing random nils
    end
    return true
  end
  if not str then
    return false
  end
  if str:sub(1, #prefix) == prefix then
    if cb then
      cb(str:sub(#prefix + 1))
    end
    return true
  end
  return false
end

-- Create a new LRU instance with the given maximum capacity
-- everything is/should be O(1) {except garbage collecting}
-- takes in an optional history flat table to initialize with
-- (created by lru:toTable())
function ML:LRU(capacity, initialData)
  local obj = {}
  obj.capacity = capacity
  obj.size = 0
  obj.head = nil -- the double linked list for ordering
  obj.tail = nil -- the tail for eviction
  obj.direct = {} -- the direct access to the element
  -- check if entry exists
  obj.exists = function(o, entry)
    return o.direct[entry]
  end
  -- return most recent
  obj.newest = function(o)
    if not o.head then
      return
    end
    return o.head.value
  end
  -- iterator, most recent first
  obj.iterateNewest = function(o)
    local cptr = o.head
    return function() -- next() function
      if cptr then
        local r = cptr.value
        local c = cptr.count
        cptr = cptr.next
        return r, c
      end
    end
  end
  -- iterator, oldest first, use this to save in a table which can then restore the
  -- same state (minus the count) using add()
  obj.iterateOldest = function(o)
    local cptr = o.tail
    return function() -- next() function
      if cptr then
        local r = cptr.value
        local c = cptr.count
        cptr = cptr.prev
        return r, c
      end
    end
  end
  -- add/record data point in the set
  obj.add = function(o, elem)
    ML:Debug(9, "adding % tail list is %", elem, o.tail)
    ML:Debug(9, "adding % head list is %", elem, o.head)
    local node = o.direct[elem]
    if node then -- found move it to top
      ML:Debug(9, "looking for %, found %", elem, node.value)
      assert(node.value == elem, "elem not found where expected")
      node.count = node.count + 1
      local p = node.prev
      if not p then -- already at the top, we're done
        return
      end
      local n = node.next
      p.next = n
      if n then
        n.prev = p
      end
      node.next = o.head
      node.next.prev = node
      o.head = node
      node.prev = nil
      if o.tail == node then
        if n then
          o.tail = n
        else
          o.tail = p
        end
        ML:Debug(9, "moving existing to front, setting tail to %", o.tail.value)
      end
      return
    end
    -- new entry, make a new node at the head:
    node = {}
    node.value = elem
    node.count = 1 -- we could also store a timestamp for time based pruning
    node.next = o.head
    if node.next then
      node.next.prev = node
    end
    o.head = node
    o.direct[elem] = node
    if not o.tail then
      o.tail = node
      ML:Debug(9, "setting tail to %", node.value)
    end
    if o.size == o.capacity then
      -- drop the tail
      local t = o.tail
      ML:Debug(3, "reaching capacity %, will evict % (tail list is %)", o.size, t.value, t)
      o.tail = t.prev
      t.prev.next = nil
      o.direct[t.value] = nil
    else
      o.size = o.size + 1
    end
  end
  -- export to table (that can be put in saved vars for instance), newest last
  obj.toTable = function(o)
    local res = {}
    for v in o:iterateOldest() do
      table.insert(res, v)
    end
    return res
  end
  -- import from table
  obj.fromTable = function(o, data)
    if not data then
      return -- allow nil to be passed in
    end
    for _, v in ipairs(data) do
      o:add(v)
    end
  end
  -- end of methods
  -- initialize
  obj:fromTable(initialData)
  -- and return the instance
  return obj
end

if not _G[globe] then
  _G[globe] = 1
else
  _G[globe] = _G[globe] + 1
end

--- localization helpers
ML.debugLocalization = true

-- returns the L array with meta suitable for
-- https://authors.curseforge.com/knowledge-base/world-of-warcraft/531-localization-substitutions
-- with lua_additive_table same-key-is-true handle-unlocalized=ignore
function ML:GetLocalization()
  local L = {}
  local Lmeta = {}
  Lmeta.__newindex = function(t, k, v)
    if v == true then -- allow for the shorter L["Foo bar"] = true
      v = k
    end
    rawset(t, k, v)
  end
  Lmeta.__index = function(t, k)
    if self.debugLocalization then
      self:Debug(1, "Localization not found for %", k)
    end
    rawset(t, k, k) -- cache it
    return k
  end
  setmetatable(L, Lmeta)
  return L
end

--- end of localization helpers

--- Watched table, ie table whose value can be tracked/sent to watchers
function ML:WatchedTable()
  self:Debug("Creating watched table")
  local t = {}
  local tMeta = {}
  tMeta.values = {}
  tMeta.callback = {}
  tMeta.__newindex = function(_t, k, v)
    local oldValue = tMeta.values[k]
    self:Debug(6, "For key %, new value % old value %", k, v, oldValue)
    if v == oldValue then -- no change
      return
    end
    tMeta.values[k] = v
    local cb = tMeta.callback[k]
    self:Debug(5, "For key %, value changed from % to %; cb is %", k, oldValue, v, cb)
    if cb then
      cb(k, v, oldValue)
    end
  end
  tMeta.__index = function(_t, k)
    local v = tMeta.values[k]
    self:Debug(5, "returning value % for key %", v, k)
    return v
  end
  -- Add a watch to be called when the value of key k changes (with params k, newValue, oldValue)
  t.AddWatch = function(tbl, k, cb)
    self:Debug(1, "Adding watch for key % (table %)", k, tbl)
    tMeta.callback[k] = cb
  end
  setmetatable(t, tMeta)
  return t
end

-- saved var (reference to which is expected to be in self.savedVar) handling

-- returns 1 if changed, 0 if same as live value
-- number instead of boolean so we can add them in handleOk
-- (saved var isn't checked/always set)
function ML:SetSaved(name, value)
  local changed = (value ~= self[name])
  self[name] = value
  self.savedVar[name] = value
  self:Debug(7, "(Saved) Setting % set to %", name, value)
  if changed then
    return 1
  else
    return 0
  end
end

-- more common code

-- default event handlers

function ML:AfterSavedVars()
  -- Nothing special by default; overridable in addons that need it
end

ML.author = "MooreaTv" -- default author

ML.EventHdlrs = {

  ADDON_LOADED = function(frame, _event, name)
    local addonP = frame.addonPtr
    addonP:Debug(9, "Addon % loaded", name)
    if name ~= addon then
      return -- not us, return
    end
    -- check for dev version (need to split the tags or they get substituted)
    if addonP.manifestVersion == "@" .. "project-version" .. "@" then
      addonP.manifestVersion = "vX.YY.ZZ"
    end
    addonP:PrintDefault(addonP.name .. " " .. addonP.manifestVersion .. " by " .. addonP.author .. ": type /" ..
                          addonP.slashCmdName .. " for command list/help.")
    if not addonP.savedVarName then
      addonP:ErrorAndThrow("addon % didn't set the required savedVarName", addonP.name)
    end
    if _G[addonP.savedVarName] == nil then
      addonP:Debug("Initialized empty saved vars")
      _G[addonP.savedVarName] = {}
    end
    local savedVar = _G[addonP.savedVarName]
    savedVar.addonVersion = addonP.manifestVersion
    savedVar.addonHash = addonP.addonHash
    addonP:deepmerge(addonP, nil, savedVar)
    addonP.savedVar = savedVar -- reference not copy, changes to one change the other
    addonP:Debug(3, "Merged in saved variables.")
    addonP:AfterSavedVars()
  end

}

function ML.OnEvent(frame, event, first, ...)
  local addonP = frame.addonPtr
  if not addonP then
    ML:ErrorAndThrow("Unexpected event processing % on frame % without addonPtr!", event, frame)
  end
  addonP:Debug(8, "OnEvent called for %,% e=% %", frame:GetName(), frame.name, event, first)
  local handler = addonP.EventHdlrs and addonP.EventHdlrs[event]
  if handler then
    return handler(frame, event, first, ...)
  end
  addonP:ErrorAndThrow("Unexpected event without handler % (frame is % - %)", event, frame:GetName(), frame.name)
end

-- Assumes the frame is self.frame and the event handlers in .EventHdlrs
function ML:RegisterEventHandlers(handlers)
  if handlers then
    for k, v in pairs(handlers) do
      self.EventHdlrs[k] = v
    end
  end
  if not self.frame then
    self.frame = CreateFrame("Frame")
    self.frame.name = self.name
  end
  self.frame.addonPtr = self
  self.frame:SetScript("OnEvent", self.OnEvent)
  for k, _ in pairs(self.EventHdlrs) do
    self.frame:RegisterEvent(k)
  end
end

function ML:SetupGuildInfo()
  -- Seems like at startup we can have IsInGuild() false...
  --if not IsInGuild() then
  --  self:Debug("Not in a guild, no rooster cache to update")
  --  return
  --end
  local guildHandler = {
    GUILD_ROSTER_UPDATE = function(frame, ...)
    local addonP = frame.addonPtr
    addonP:Debug(1, "GUILD_ROSTER_UPDATE called for % % % [%]", addonP.name, frame:GetName(), frame.name, addonP:Dump(...))
    addonP:UpdateGuildInfo()
  end
  }
  self:RegisterEventHandlers(guildHandler)
  self:Debug("Requesting Guild Roster")
  GuildRoster() -- will call UpdateGuildInfo() from GUILD_ROSTER_UPDATE firing off
end

ML.GuildCache = {}
ML.GuildCache.n = 0

function ML:UpdateGuildInfo()
  self:Debug("Received Guild Roster")
  local numTotalGuildMembers, numOnlineGuildMembers = GetNumGuildMembers()
  if numTotalGuildMembers == self.GuildCache.n then
    self:Debug("Unchanged count %, online is %", numTotalGuildMembers, numOnlineGuildMembers)
    return
  end
  self:PrintDefault(self.name .. ": In guild, % total, % online.", numTotalGuildMembers, numOnlineGuildMembers)
  self.GuildCache = {}
  self.GuildCache.n = numTotalGuildMembers
  for i = 1, numTotalGuildMembers do
    local name= GetGuildRosterInfo(i)
    self.GuildCache[name] = true
  end
end

-- Unlike UnitIsInMyGuild this takes the fullName (name-realm) as input
function ML:IsInOurGuild(fullName)
  local result = self.GuildCache[fullName]
  self:Debug("IsInOurGuild(%) with % in cache: %", fullName, self.GuildCache.n, result)
  return result
end


---
-- perf tests

function ML.testPerfGlobal(n)
  local x
  for i = 1, n do
    x = math.sin(i)
  end
  return x
end
function ML.testPerfLocal(n)
  local x
  local sin = math.sin
  for i = 1, n do
    x = sin(i)
  end
  return x
end

function ML:measure(msg, f, n)
  local x
  local t1 = debugprofilestop()
  x = f(n)
  local t2 = debugprofilestop()
  self:PrintDefault("Perf measure: % calls result is % after % iter: %", msg, x, n, t2 - t1)
end

function ML:testPerfLocalGlobal(n)
  self:measure("global", ML.testPerfGlobal, n)
  self:measure("local", ML.testPerfLocal, n)
  self:measure("global", ML.testPerfGlobal, n)
  self:measure("local", ML.testPerfLocal, n)
end
---
ML:Debug(2, "Done loading MoLib.lua #%", _G[globe])
