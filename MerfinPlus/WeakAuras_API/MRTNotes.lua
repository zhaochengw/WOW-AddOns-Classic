local IsAddOnLoaded = C_AddOns.IsAddOnLoaded

-- Iterate group/raid units
local WA_IterateGroupMembers = function(reversed, forceParty)
  local unit = (not forceParty and IsInRaid()) and "raid" or "party"
  local numGroupMembers = unit == "party" and GetNumSubgroupMembers() or GetNumGroupMembers()
  local i = reversed and numGroupMembers or (unit == "party" and 0 or 1)
  return function()
    local ret
    if i == 0 and unit == "party" then
      ret = "player"
    elseif i <= numGroupMembers and i > 0 then
      ret = unit .. i
    end
    i = i + (reversed and -1 or 1)
    return ret
  end
end

local function NormalizeName(s)
  if not s then
    return nil
  end
  -- strip colors/links/textures/masks and any pipes; trim and drop realm suffix
  s = s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
  s = s:gsub("|H.-|h", ""):gsub("|h", "")
  s = s:gsub("|T.-|t", "")
  s = s:gsub("|K.-|k", "")
  s = s:gsub("%%", "%%%%")
  s = s:gsub("%|", "")
  s = s:match("^%s*(.-)%s*$") or s
  s = s:gsub("%-.+$", "")
  return s
end

-- Build a set of player names from the current group/raid (used only for canonicalization)
local function BuildPlayerSet()
  local t = {}
  for unit in WA_IterateGroupMembers() do
    local unitName = UnitName(unit)
    if unitName then
      t[unitName] = true
    end
  end
  return t
end

local function ExtractIndex(line, mode)
  if mode == "numeric" then
    local idx, rest = line:match("^%s*(%d+)%.%s*(.+)$")
    if idx then
      return tonumber(idx), rest, "numeric"
    end
  elseif mode == "token" then
    local token, rest = line:match("^%s*(%b{})%.?%s*(.+)$")
    if token then
      return token, rest, "token"
    end
    local alnum, rest2 = line:match("^%s*([%w_%-]+)%.%s*(.+)$")
    if alnum then
      return alnum, rest2, "token"
    end
  elseif mode == "auto" then
    local idx, rest = line:match("^%s*(%d+)%.%s*(.+)$")
    if idx then
      return tonumber(idx), rest, "numeric"
    end
    local token, rest2 = line:match("^%s*(%b{})%.?%s*(.+)$")
    if token then
      return token, rest2, "token"
    end
    local alnum, rest3 = line:match("^%s*([%w_%-]+)%.%s*(.+)$")
    if alnum then
      return alnum, rest3, "token"
    end
  end
  return nil, nil, nil
end

-- Collect names from a comma-separated chunk.
-- New behavior: always include names even if they are NOT in the current group/raid.
-- If a name matches a current group member (exact or substring), we use the canonical group casing.
-- If it matches your alias, we substitute your real character name.
local function CollectNames(chunk, playerSet)
  local names, seen = {}, {}
  local myName = NormalizeName(UnitName("player") or (select(1, UnitFullName("player"))) or "")

  for token in chunk:gmatch("[^,]+") do
    local name = NormalizeName(token)
    if name and name ~= "" then
      local matched = nil

      if playerSet and next(playerSet) then
        if playerSet[name] then
          matched = name
        else
          local low = name:lower()
          for playerName in pairs(playerSet) do
            local plow = playerName:lower()
            if plow:find(low, 1, true) or low:find(plow, 1, true) then
              matched = playerName
              break
            end
          end
        end
      end

      if not matched and Merfin and Merfin.isMyAlias and Merfin.isMyAlias(name) then
        matched = myName ~= "" and myName or name
      end

      matched = matched or name

      local key = matched:lower()
      if not seen[key] then
        names[#names + 1] = matched
        seen[key] = true
      end
    end
  end
  return names
end

local Parsers = {}

Parsers.plain = function(text, opts)
  if not text then
    return
  end
  local playerSet = BuildPlayerSet()
  local order, lineCount = {}, 0
  local indexMode = opts and opts.index_mode or "numeric"

  for raw in text:gmatch("[^\r\n]+") do
    local idx, rest, kind = ExtractIndex(raw, indexMode)
    if idx and rest then
      local names = CollectNames(rest, playerSet)
      if #names > 0 then
        if kind == "numeric" then
          if type(idx) == "number" then
            order[idx] = names
          else
            lineCount = lineCount + 1
            order[lineCount] = names
          end
        else
          order[idx] = names
        end
        lineCount = lineCount + 1
      end
    end
  end

  return order, lineCount
end

Parsers.stacked = function(text, opts)
  if not text then
    return
  end
  local playerSet = BuildPlayerSet()
  local order, stacks = {}, {}
  local indexMode = opts and opts.index_mode or "numeric"

  for raw in text:gmatch("[^\r\n]+") do
    local idx, rest, kind = ExtractIndex(raw, indexMode)
    if idx and rest then
      local sc, namesStr = rest:match("^%(%s*(%d+)%s*%)%s*(.+)$")
      if sc and namesStr then
        local names = CollectNames(namesStr, playerSet)
        if #names > 0 then
          if kind == "numeric" then
            order[#order + 1] = names
            stacks[#stacks + 1] = tonumber(sc)
          else
            order[idx] = names
            stacks[idx] = tonumber(sc)
          end
        end
      end
    end
  end

  return order, stacks
end

-- Supports team declarations and both schedule formats:
-- Decls: "T1. Name1, Name2", "Tank1. Name", "Team1. Name"
-- Schedule (new): "1. T1 + Tank1" or "1. Team1 + Tank1"
-- Schedule (legacy): "1. (3) T1"
Parsers.teams_stacked = function(text, opts)
  if not text then
    return
  end

  local playerSet = BuildPlayerSet()
  local order = {}

  local prefixes = opts and opts.team_prefix or { "T", "Tank", "Team" }
  if type(prefixes) == "string" then
    prefixes = { prefixes }
  end
  local prefixSet = {}
  for _, p in ipairs(prefixes) do
    prefixSet[p] = true
  end

  local function matchTeamDef(line)
    for p in pairs(prefixSet) do
      local num, names = line:match("^%s*" .. p .. "(%d+)%.%s*(.+)$")
      if num and names then
        return p .. tostring(num), names
      end
    end
  end

  local function parseTeamToken(tok)
    tok = (tok or ""):match("^%s*(.-)%s*$")
    for p in pairs(prefixSet) do
      local num = tok:match("^" .. p .. "(%d+)$")
      if num then
        return p .. tostring(num)
      end
    end
  end

  -- Pass 1: define teams
  for raw in text:gmatch("[^\r\n]+") do
    local teamKey, namesStr = matchTeamDef(raw)
    if teamKey and namesStr then
      local names = CollectNames(namesStr, playerSet)
      if #names > 0 then
        order[teamKey] = names
      end
    end
  end

  -- Pass 2: schedule
  local combined = {}
  local legacyStacks = {}
  local useCombined = false
  local scheduleIndex = 0

  for raw in text:gmatch("[^\r\n]+") do
    local idxStr, rest = raw:match("^%s*(%d+)%.%s*(.-)%s*$")
    if idxStr then
      scheduleIndex = scheduleIndex + 1
      if rest == "" then
        combined[scheduleIndex] = {}
        useCombined = true
      else
        local sc, after = rest:match("^%(%s*(%d+)%s*%)%s*(.+)$")
        if sc and not after:find("%+") then
          local tok = parseTeamToken(after)
          if tok then
            local num = tonumber(after:match("(%d+)$"))
            table.insert(legacyStacks, { stacks = tonumber(sc), team = num })
            if not order[tok] then
              order[tok] = {}
            end
          else
            combined[scheduleIndex] = {}
            useCombined = true
          end
        else
          local lineMembers = {}
          for part in rest:gmatch("[^+]+") do
            local tok = parseTeamToken(part)
            if tok then
              local teamList = order[tok] or {}
              for i = 1, #teamList do
                lineMembers[#lineMembers + 1] = teamList[i]
              end
            else
              local names = CollectNames(part, playerSet)
              for i = 1, #names do
                lineMembers[#lineMembers + 1] = names[i]
              end
            end
          end
          combined[scheduleIndex] = lineMembers
          useCombined = true
        end
      end
    end
  end

  if useCombined then
    return order, combined
  else
    return order, legacyStacks
  end
end

Merfin = Merfin or {}
Merfin._MRTParsers = {
  plain = Parsers.plain,
  stacked = Parsers.stacked,
  teams_stacked = Parsers.teams_stacked,
}

Merfin.RegisterMRTParser = function(name, fn)
  if type(name) == "string" and type(fn) == "function" then
    Merfin._MRTParsers[name] = fn
  end
end

local function ParseAssignmentString(text, opts)
  local algo = (opts and opts.algorithm) or "plain"
  local parser = Merfin._MRTParsers[algo]
  if parser then
    return parser(text, opts)
  end
end

Merfin.GetMRTOrder = function(keyWordStart, keyWordEnd, opts)
  if
    not (IsAddOnLoaded("ExRT") or IsAddOnLoaded("MRT"))
    or not _G.VExRT
    or not _G.VExRT.Note
    or not _G.VExRT.Note.Text1
  then
    return
  end

  local isNoteActive = false
  local lines = {}

  for line in _G.VExRT.Note.Text1:gmatch("[^\r\n]+") do
    local trimmed = strtrim(line:lower())
    if trimmed == keyWordStart then
      isNoteActive = true
    elseif trimmed == keyWordEnd then
      break
    elseif isNoteActive then
      lines[#lines + 1] = line
    end
  end

  local textToParse = table.concat(lines, "\n")
  local a, b = ParseAssignmentString(textToParse, opts)

  return isNoteActive, a, b
end

-- Returns true if 'alia' is in Merfin.myAlias (case-insensitive; trims spaces; ignores realm suffix)
Merfin.isMyAlias = function(alia)
  if not Merfin or type(Merfin.myAlias) ~= "table" then
    return false
  end
  if type(alia) ~= "string" or alia == "" then
    return false
  end

  local function norm(s)
    s = tostring(s or "")
    s = s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    s = s:gsub("|H.-|h", ""):gsub("|h", "")
    s = s:gsub("|T.-|t", ""):gsub("|K.-|k", "")
    s = s:gsub("%|", "")
    s = s:match("^%s*(.-)%s*$") or s
    s = s:lower()
    s = s:gsub("%-.+$", "")
    return s
  end

  local key = norm(alia)
  for i = 1, #Merfin.myAlias do
    if norm(Merfin.myAlias[i]) == key then
      return true
    end
  end
  return false
end
