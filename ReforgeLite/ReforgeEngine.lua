---@type string, AddonTable
local addonName, addonTable = ...
local REFORGE_COEFF = addonTable.REFORGE_COEFF

local ReforgeLite = addonTable.ReforgeLite
local playerClass = addonTable.playerClass
local statIds = addonTable.statIds
local print = addonTable.print

local GetItemStats = addonTable.GetItemStatsFromTooltip
local playerRace = select(2, UnitRace("player"))

---------------------------------------------------------------------------------------

---Gets stat multipliers from equipped amplification items
---Calculates bonus factors for Haste, Mastery, and Spirit based on item level
---@return table<number, number> multipliers Table of stat ID to multiplier (e.g., {[statIds.HASTE] = 1.05})
function ReforgeLite:GetStatMultipliers()
  local result = {}
  for _, v in ipairs(self.itemData) do
    if addonTable.AmplificationItems[v.itemInfo.itemId] then
      local factor = 1 + 0.01 * Round(addonTable.GetRandPropPoints(v.itemInfo.ilvl, 2) / 420)
      result[statIds.HASTE] = (result[statIds.HASTE] or 1) * factor
      result[statIds.MASTERY] = (result[statIds.MASTERY] or 1) * factor
      result[statIds.SPIRIT] = (result[statIds.SPIRIT] or 1) * factor
    end
  end
  return result
end

local CASTER_SPEC = {[statIds.EXP] = {[statIds.HIT] = 1}}
local HYBRID_SPEC = {[statIds.SPIRIT] = {[statIds.HIT] = 1}, [statIds.EXP] = {[statIds.HIT] = 1}}

addonTable.SPEC_IDS = {
  DEATHKNIGHT = { blood = 250, frost = 251, unholy = 252 },
  DRUID = { balance = 102, feralcombat = 103, guardian = 104, restoration = 105 },
  HUNTER = { beastmastery = 253, marksmanship = 254, survival = 255 },
  MAGE = { arcane = 62, fire = 63, frost = 64 },
  MONK = { brewmaster = 268, mistweaver = 270, windwalker = 269 },
  PALADIN = { holy = 65, protection = 66, retribution = 70 },
  PRIEST = { discipline = 256, holy = 257, shadow = 258 },
  ROGUE = { assassination = 259, combat = 260, subtlety = 261 },
  SHAMAN = { elemental = 262, enhancement = 263, restoration = 264 },
  WARLOCK = { affliction = 265, demonology = 266, destruction = 267 },
  WARRIOR = { arms = 71, fury = 72, protection = 73 }
}

local STAT_CONVERSIONS = {
  DRUID = {
    specs = {
      [addonTable.SPEC_IDS.DRUID.balance] = HYBRID_SPEC,
      [addonTable.SPEC_IDS.DRUID.restoration] = CASTER_SPEC -- Resto
    }
  },
  MAGE = { base = CASTER_SPEC },
  MONK = {
    specs = {
      [addonTable.SPEC_IDS.MONK.mistweaver] = {
        [statIds.SPIRIT] = {[statIds.HIT] = 0.5, [statIds.EXP] = 0.5},
        [statIds.HASTE] = {[statIds.HASTE] = 0.5},
      }
    }
  },
  PALADIN = {
    specs = {
      [addonTable.SPEC_IDS.PALADIN.holy] = CASTER_SPEC -- Holy
    }
  },
  PRIEST = {
    base = CASTER_SPEC,
    specs = {
      [addonTable.SPEC_IDS.PRIEST.shadow] = HYBRID_SPEC -- Shadow
    }
  },
  SHAMAN = {
    specs = {
      [addonTable.SPEC_IDS.SHAMAN.elemental] = HYBRID_SPEC, -- Ele
      [addonTable.SPEC_IDS.SHAMAN.restoration] = CASTER_SPEC -- Resto
    }
  },
  WARLOCK = { base = CASTER_SPEC },
}

---Gets stat conversion rules for the current class/spec
---Handles special conversions like Spirit->Hit for casters, Expertise->Hit for hybrids
---@return table<number, table<number, number>>|nil conversion Nested table of source stat to {dest stat = conversion rate}
function ReforgeLite:GetConversion()
  self.conversion = wipe(self.conversion or {})
  self.specID = PlayerUtil.GetCurrentSpecID()
  local classInfo = STAT_CONVERSIONS[playerClass]
  if classInfo then
    if classInfo.base then
      MergeTable(self.conversion, classInfo.base)
    end
    if self.specID and classInfo.specs and classInfo.specs[self.specID] then
      MergeTable(self.conversion, classInfo.specs[self.specID])
    end
  end
  if playerRace == "Human" then
    self.conversion[statIds.SPIRIT] = self.conversion[statIds.SPIRIT] or {}
    self.conversion[statIds.SPIRIT][statIds.SPIRIT] = (self.conversion[statIds.SPIRIT][statIds.SPIRIT] or 1) * 0.03
  end
end


---Updates method stats with final calculations including conversions
---Applies stat conversions, rating adjustments, and calculates final stat totals
---@param method table The reforge method containing stats and orig_stats
---@return nil
function ReforgeLite:UpdateMethodStats (method)
  local mult = self:GetStatMultipliers()
  local oldstats = {}
  method.stats = {}
  for i = 1, addonTable.itemStatCount do
    oldstats[i] = addonTable.itemStats[i].getter ()
    method.stats[i] = oldstats[i] / (mult[i] or 1)
  end
  method.items = method.items or {}
  for k, item in ipairs(self.itemData) do
    local stats = GetItemStats(item.itemInfo)
    local orgstats = CopyTable(stats)
    local reforge = item.itemInfo.reforge

    method.items[k] = method.items[k] or {}

    method.items[k].stats = nil
    method.items[k].amount = nil

    for s, v in ipairs(addonTable.itemStats) do
      method.stats[s] = method.stats[s] - (orgstats[v.name] or 0) + (stats[v.name] or 0)
    end
    if reforge then
      local src, dst = unpack(self.reforgeTable[reforge])
      local amount = floor ((orgstats[addonTable.itemStats[src].name] or 0) * REFORGE_COEFF)
      method.stats[src] = method.stats[src] + amount
      method.stats[dst] = method.stats[dst] - amount
    end
    if method.items[k].src and method.items[k].dst then
      method.items[k].amount = floor ((stats[addonTable.itemStats[method.items[k].src].name] or 0) * REFORGE_COEFF)
      method.stats[method.items[k].src] = method.stats[method.items[k].src] - method.items[k].amount
      method.stats[method.items[k].dst] = method.stats[method.items[k].dst] + method.items[k].amount
    end
  end

  for s, f in pairs(mult) do
    method.stats[s] = Round(method.stats[s] * f)
  end

  for src, c in pairs(self.conversion) do
    for dst, f in pairs(c) do
      method.stats[dst] = method.stats[dst] + Round((method.stats[src] - oldstats[src]) * f)
    end
  end
end

---Finalizes a reforge solution and displays results
---Creates the method window, updates stats, and shows the reforge plan
---@param data table The reforge solution data with item reforges
---@return nil
function ReforgeLite:FinalizeReforge (data)
  for _,item in ipairs(data.method.items) do
    item.reforge = nil
    if item.src and item.dst then
      item.reforge = self:GetReforgeTableIndex(item.src, item.dst)
    end
    item.stats = nil
  end
  self:UpdateMethodStats (data.method)
end

---Resets the current reforge method
---Clears all reforges and restores original stats
---@return nil
function ReforgeLite:ResetMethod ()
  local method = { items = {} }
  for k, v in ipairs(self.itemData) do
    method.items[k] = {}
    if v.itemInfo.reforge then
      method.items[k].reforge = v.itemInfo.reforge
      method.items[k].src, method.items[k].dst = unpack(self.reforgeTable[v.itemInfo.reforge])
    end
  end
  self:UpdateMethodStats (method)
  self.pdb.method = method
  self.pdb.methodOrigin = addonName
  self:UpdateMethodCategory()
end

---Checks if a stat value satisfies the cap constraints
---@param cap table The cap configuration with stat, method (AtLeast/AtMost/etc), and value
---@param value number The stat value to check
---@return boolean allowed True if the value satisfies the cap constraint
function ReforgeLite:CapAllows (cap, value)
  for _,v in ipairs(cap.points) do
    if v.method == addonTable.StatCapMethods.AtLeast and value < v.value then
      return false
    elseif v.method == addonTable.StatCapMethods.AtMost and value > v.value then
      return false
    elseif v.method == addonTable.StatCapMethods.Exactly and value ~= v.value then
      return false
    end
  end
  return true
end

---Checks if an item slot is locked from reforging
---Items are locked if empty, below ilvl 200, or manually locked by user
---@param slot number The item slot index
---@return boolean locked True if the item is locked
function ReforgeLite:IsItemLocked (slot)
  local slotData = self.itemData[slot].itemInfo
  return not slotData.link
  or slotData.ilvl < 200
  or self.pdb.itemsLocked[slotData.itemGUID]
end

------------------------------------- CLASSIC REFORGE ------------------------------

---Creates a reforge option for an item
---Calculates stat deltas and score changes for reforging src stat to dst stat
---@param item table The item data with stats
---@param data table Global reforge data (caps, weights, conversions, multipliers)
---@param src? number Source stat ID to reforge from (nil for no reforge)
---@param dst? number Destination stat ID to reforge to (nil for no reforge)
---@return table option Reforge option with src, dst, delta1, delta2, dscore
function ReforgeLite:MakeReforgeOption(item, data, src, dst)
  local delta1, delta2, dscore = 0, 0, 0
  if src and dst then
    local amountRaw = floor(item.stats[src] * REFORGE_COEFF)
    local amount = Round(amountRaw * (data.mult[src] or 1))
    if src == data.caps[1].stat then
      delta1 = delta1 - amount
    elseif src == data.caps[2].stat then
      delta2 = delta2 - amount
    else
      dscore = dscore - data.weights[src] * amount
    end
    if data.conv[src] then
      for to, factor in pairs(data.conv[src]) do
        local conv = Round(amount * factor)
        if data.caps[1].stat == to then
          delta1 = delta1 - conv
        elseif data.caps[2].stat == to then
          delta2 = delta2 - conv
        else
          dscore = dscore - data.weights[to] * conv
        end
      end
    end
    amount = Round(amountRaw * (data.mult[dst] or 1))
    if dst == data.caps[1].stat then
      delta1 = delta1 + amount
    elseif dst == data.caps[2].stat then
      delta2 = delta2 + amount
    else
      dscore = dscore + data.weights[dst] * amount
    end
    if data.conv[dst] then
      for to, factor in pairs(data.conv[dst]) do
        local conv = Round(amount * factor)
        if data.caps[1].stat == to then
          delta1 = delta1 + conv
        elseif data.caps[2].stat == to then
          delta2 = delta2 + conv
        else
          dscore = dscore + data.weights[to] * conv
        end
      end
    end
  end
  return {d1 = delta1, d2 = delta2, src = src, dst = dst, score = dscore}
end

---Gets all valid reforge options for an item
---Returns locked item's current reforge if locked, otherwise all possible reforges
---@param item table The item data with stats
---@param data table Global reforge data (caps, weights, conversions, multipliers)
---@param slot number The item slot index
---@return table<number, table> options Array of reforge options indexed by state key
function ReforgeLite:GetItemReforgeOptions (item, data, slot)
  if self:IsItemLocked (slot) then
    local src, dst = nil, nil
    if self.itemData[slot].itemInfo.reforge then
      src, dst = unpack(self.reforgeTable[self.itemData[slot].itemInfo.reforge])
    end
    return { self:MakeReforgeOption (item, data, src, dst) }
  end
  local aopt = {}
  aopt[0] = self:MakeReforgeOption (item, data)
  for src = 1, addonTable.itemStatCount do
    if item.stats[src] > 0 then
      for dst = 1, addonTable.itemStatCount do
        if item.stats[dst] == 0 then
          local o = self:MakeReforgeOption (item, data, src, dst)
          local pos = o.d1 + o.d2 * self.TABLE_SIZE
          if not aopt[pos] or aopt[pos].score < o.score then
            aopt[pos] = o
          end
        end
      end
    end
  end
  local opt = {}
  for _, v in pairs (aopt) do
    tinsert (opt, v)
  end
  return opt
end

function ReforgeLite:InitializeMethod()
  local method = { items = {} }
  local orgitems = {}
  for k, v in ipairs(self.itemData) do
    method.items[k] = { stats = {} }
    orgitems[k] = {}
    local stats = GetItemStats(v.itemInfo)
    local orgstats = CopyTable(stats)
    for j, stat in ipairs(addonTable.itemStats) do
      method.items[k].stats[j] = (stats[stat.name] or 0)
      orgitems[k][j] = (orgstats[stat.name] or 0)
    end
  end
  return method, orgitems
end

function ReforgeLite:InitReforgeClassic()
  local method, orgitems = self:InitializeMethod()
  local data = {}
  data.method = method
  data.weights = CopyTable (self.pdb.weights)
  data.caps = CopyTable (self.pdb.caps)
  data.caps[1].init = 0
  data.caps[2].init = 0
  data.initial = {}

  data.mult = self:GetStatMultipliers()
  data.conv = CopyTable(self.conversion)

  for i = 1, 2 do
    for point = 1, #data.caps[i].points do
      local preset = data.caps[i].points[point].preset
      if self.capPresets[preset] == nil then
        preset = 1
      end
      if self.capPresets[preset].getter then
        data.caps[i].points[point].value = floor(self.capPresets[preset].getter())
      end
    end
  end

  for i = 1, addonTable.itemStatCount do
    data.initial[i] = addonTable.itemStats[i].getter() / (data.mult[i] or 1)
    for j = 1, #orgitems do
      data.initial[i] = data.initial[i] - orgitems[j][i]
    end
  end
  local reforged = {}
  for i = 1, addonTable.itemStatCount do
    reforged[i] = 0
  end
  for i = 1, #data.method.items do
    local reforge = self.itemData[i].itemInfo.reforge
    if reforge then
      local src, dst = unpack(self.reforgeTable[reforge])
      local amount = floor (method.items[i].stats[src] * REFORGE_COEFF)
      data.initial[src] = data.initial[src] + amount
      data.initial[dst] = data.initial[dst] - amount
      reforged[src] = reforged[src] - amount
      reforged[dst] = reforged[dst] + amount
    end
  end
  for src, c in pairs(data.conv) do
    for dst, f in pairs(c) do
      data.initial[dst] = data.initial[dst] - Round(reforged[src] * (data.mult[src] or 1) * f)
    end
  end
  if data.caps[1].stat > 0 then
    data.caps[1].init = data.initial[data.caps[1].stat]
    for i = 1, #data.method.items do
      data.caps[1].init = data.caps[1].init + data.method.items[i].stats[data.caps[1].stat]
    end
  end
  if data.caps[2].stat > 0 then
    data.caps[2].init = data.initial[data.caps[2].stat]
    for i = 1, #data.method.items do
      data.caps[2].init = data.caps[2].init + data.method.items[i].stats[data.caps[2].stat]
    end
  end
  if data.caps[1].stat == 0 then
    data.caps[1], data.caps[2] = data.caps[2], data.caps[1]
  end
  if data.caps[2].stat == data.caps[1].stat then
    data.caps[2].stat = 0
    data.caps[2].init = 0
  end

  for src, conv in pairs(data.conv) do
    if data.weights[src] == 0 then
      if (data.caps[1].stat and conv[data.caps[1].stat]) or (data.caps[2].stat and conv[data.caps[2].stat]) then
        if src == statIds.EXP then
          data.weights[src] = -1
        else
          data.weights[src] = 1
        end
      end
    end
  end

  return data
end

function ReforgeLite:ComputeReforgeCore(reforgeOptions)
  local floor = floor
  local TABLE_SIZE = self.TABLE_SIZE
  -- scores[k]     = non-cap score for state k
  -- d1a[k], d2a[k] = exact (non-modular) accumulated cap deltas for state k
  -- allChoices[i][k] = option index j chosen for item i to reach state k
  -- allPrev[i][k]    = predecessor state before item i that led to state k
  local scores = {[0] = 0}
  local d1a    = {[0] = 0}
  local d2a    = {[0] = 0}
  local allChoices, allPrev = {}, {}
  local debug = self.db.debug
  local profItems  -- per-item timing array, only allocated in debug mode
  if debug then profItems = {} end

  for i = 1, #reforgeOptions do
    local opt = reforgeOptions[i]
    local optLen = #opt
    local newscores, newd1a, newd2a = {}, {}, {}
    local choices, prevs = {}, {}
    allChoices[i] = choices
    allPrev[i]    = prevs

    local stateCount = 0
    local itemStart
    if debug then
      stateCount = 0
      for _ in pairs(scores) do stateCount = stateCount + 1 end
      itemStart = debugprofilestop()
    end

    for k, score in pairs(scores) do
      if i > 9 then
        self:RunYieldCheck()
      end
      local s1   = k % TABLE_SIZE
      local s2   = floor(k / TABLE_SIZE)
      local kd1  = d1a[k]
      local kd2  = d2a[k]
      for j = 1, optLen do
        local o      = opt[j]
        local nscore = score + o.score
        local nk     = s1 + o.d1 + (s2 + o.d2) * TABLE_SIZE
        if not newscores[nk] or nscore > newscores[nk] then
          newscores[nk] = nscore
          newd1a[nk]    = kd1 + o.d1
          newd2a[nk]    = kd2 + o.d2
          choices[nk]   = j
          prevs[nk]     = k
        end
      end
    end
    scores, d1a, d2a = newscores, newd1a, newd2a

    if debug then
      local elapsed = debugprofilestop() - itemStart
      local newCount = 0
      for _ in pairs(scores) do newCount = newCount + 1 end
      profItems[i] = { states = stateCount, opts = optLen, ms = elapsed, outStates = newCount }
    end
  end

  if debug then
    for i, p in ipairs(profItems) do
      print(("RFL Core item %d: %d states x %d opts → %d states  %.1fms"):format(i, p.states, p.opts, p.outStates, p.ms))
    end
  end

  return scores, d1a, d2a, allChoices, allPrev
end

function ReforgeLite:ChooseReforgeClassic(data, scores, d1a, d2a)
  local bestKey   = {nil, nil, nil, nil}
  local bestScore = {0, 0, 0, 0}
  local cap1      = data.caps[1]
  local cap2      = data.caps[2]
  local init1     = cap1.init
  local init2     = cap2.init

  for k, score in pairs(scores) do
    self:RunYieldCheck()
    local a1, a2 = true, true
    if cap1.stat > 0 then
      local s1 = init1 + d1a[k]
      a1    = self:CapAllows(cap1, s1)
      score = score + self:GetCapScore(cap1, s1)
    end
    if cap2.stat > 0 then
      local s2 = init2 + d2a[k]
      a2    = self:CapAllows(cap2, s2)
      score = score + self:GetCapScore(cap2, s2)
    end
    local allow = a1 and (a2 and 1 or 2) or (a2 and 3 or 4)
    if not bestKey[allow] or score > bestScore[allow] then
      bestKey[allow]   = k
      bestScore[allow] = score
    end
  end

  return bestKey[1] or bestKey[2] or bestKey[3] or bestKey[4]
end

---Main entry point for Classic (DP) reforge algorithm
---Initializes data, generates reforge options, computes optimal solution
---@return nil
function ReforgeLite:ComputeReforgeClassic()
  self.TABLE_SIZE = floor(10000 * (self.db.accuracy / addonTable.MAX_SPEED))
  local debug = self.db.debug
  local t0, t1, t2, t3, t4
  if debug then
    t0 = debugprofilestop()
    print(("RFL Classic start  TABLE_SIZE=%d"):format(self.TABLE_SIZE))
  end

  local data = self:InitReforgeClassic()
  if debug then t1 = debugprofilestop() end

  local reforgeOptions = {}
  for i = 1, #self.itemData do
    reforgeOptions[i] = self:GetItemReforgeOptions(data.method.items[i], data, i)
  end
  if debug then t2 = debugprofilestop() end

  local scores, d1a, d2a, allChoices, allPrev = self:ComputeReforgeCore(reforgeOptions)
  if debug then t3 = debugprofilestop() end

  local bestK = self:ChooseReforgeClassic(data, scores, d1a, d2a)
  if debug then t4 = debugprofilestop() end

  -- Backtrack through allPrev to reconstruct the chosen reforge for each item
  local k = bestK
  for i = #data.method.items, 1, -1 do
    local opt = reforgeOptions[i][allChoices[i][k]]
    local dst = opt.dst
    if data.conv[statIds.SPIRIT] and data.conv[statIds.SPIRIT][statIds.HIT] == 1 then
      if dst == statIds.HIT and data.method.items[i].stats[statIds.SPIRIT] == 0 then
        dst = statIds.SPIRIT
      end
    end
    data.method.items[i].src = opt.src
    data.method.items[i].dst = dst
    k = allPrev[i][k]
  end

  addonTable.methodDebug = { data = CopyTable(data) }
  self:FinalizeReforge(data)
  addonTable.methodDebug.method = CopyTable(data.method)
  if data.method then
    self.pdb.method = data.method
    self.pdb.methodOrigin = addonName
    self:UpdateMethodCategory()
  end

  if debug then
    local t5 = debugprofilestop()
    print(("RFL Phase  Init=%.1fms  Options=%.1fms  Core=%.1fms  Choose=%.1fms  Finalize=%.1fms  Total=%.1fms"):format(
      t1-t0, t2-t1, t3-t2, t4-t3, t5-t4, t5-t0))
  end
end

---Main compute dispatcher - chooses algorithm based on settings
---Uses Branch & Bound if enabled and dual caps configured, otherwise uses DP
---@return nil
function ReforgeLite:ComputeReforge()
  if self.pdb.useBranchBound and self.pdb.caps[2].stat ~= 0 then
    self:ComputeReforgeBranchBound()
  else
    self:ComputeReforgeClassic()
  end
end

local NORMAL_STATUS_CODES = { suspended = true, running = true }
local routine

local YIELD_BUDGET_MS = 20  -- max ms of Lua execution per frame before yielding
local frameStartTime = 0

-- OnUpdate frame used to resume the coroutine. Each OnUpdate fires as a fresh C->Lua call,
-- which resets WoW's per-execution script time counter — unlike RunNextFrame which may not.
-- Created lazily so it only exists while the addon is actively computing.
local scheduleFrame

---Resumes the compute coroutine from a yield
---Handles errors and completes computation when coroutine finishes
---@return nil
function ReforgeLite:ResumeCompute()
  if not routine then return end
  frameStartTime = debugprofilestop()
  local success, err = coroutine.resume(routine)
  if not success then
    print("Coroutine error - " .. tostring(err))
    self:EndCompute()
  elseif not NORMAL_STATUS_CODES[coroutine.status(routine)] then
    self:EndCompute()
  end
end

---Schedules compute resume on next frame via OnUpdate (fresh C->Lua call per frame)
---@return nil
function ReforgeLite:ResumeComputeNextFrame()
  if not scheduleFrame then
    scheduleFrame = CreateFrame("Frame")
    scheduleFrame:SetScript("OnUpdate", function(frame)
      frame:Hide()
      ReforgeLite:ResumeCompute()
    end)
  end
  scheduleFrame:Show()
end

---Checks if coroutine should yield to prevent freezing
---Uses a cheap counter gate so debugprofilestop() is only called every YIELD_CHECK_INTERVAL iterations
---@return nil
function ReforgeLite:RunYieldCheck()
  if addonTable.pauseRoutine then
    coroutine.yield()
  else
    if debugprofilestop() - frameStartTime >= YIELD_BUDGET_MS then
      self:ResumeComputeNextFrame()
      coroutine.yield()
    end
  end
end

---Creates and starts a new computation coroutine
---@param func function The computation function to run as a coroutine
---@return nil
function ReforgeLite:CreateRoutine(func)
  addonTable.pauseRoutine = nil
  addonTable.callbacks:TriggerEvent("PreCalculateStart")
  if routine and NORMAL_STATUS_CODES[coroutine.status(routine)] then
    coroutine.resume(routine)
  else
    routine = coroutine.create(function() self[func](self) end)
  end
  self:ResumeComputeNextFrame()
end

---Starts algorithm comparison mode (debug feature)
---@return nil
function ReforgeLite:StartAlgorithmComparison()
  self:CreateRoutine("RunAlgorithmComparison")
end

---Starts the main reforge computation
---Creates coroutine and begins async calculation
---@return nil
function ReforgeLite:StartCompute()
  self:CreateRoutine("ComputeReforge")
end

---Ends the computation and cleans up
---Triggers callbacks and garbage collection
---@return nil
function ReforgeLite:EndCompute()
  addonTable.callbacks:TriggerEvent("OnCalculateFinish")
  if scheduleFrame then scheduleFrame:Hide() end
  routine = nil
  collectgarbage('collect')
end
