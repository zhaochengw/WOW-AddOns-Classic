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
local STAT_CONVERSIONS = {
  DRUID = {
    specs = {
      [SPEC_DRUID_BALANCE] = HYBRID_SPEC,
      [4] = CASTER_SPEC -- Resto
    }
  },
  MAGE = { base = CASTER_SPEC },
  MONK = {
    specs = {
      [SPEC_MONK_MISTWEAVER] = {
        [statIds.SPIRIT] = {[statIds.HIT] = 0.5, [statIds.EXP] = 0.5},
        [statIds.HASTE] = {[statIds.HASTE] = 0.5},
      }
    }
  },
  PALADIN = {
    specs = {
      [1] = CASTER_SPEC -- Holy
    }
  },
  PRIEST = {
    base = CASTER_SPEC,
    specs = {
      [SPEC_PRIEST_SHADOW] = HYBRID_SPEC -- Shadow
    }
  },
  SHAMAN = {
    specs = {
      [1] = HYBRID_SPEC, -- Ele
      [SPEC_SHAMAN_RESTORATION] = CASTER_SPEC -- Resto
    }
  },
  WARLOCK = { base = CASTER_SPEC },
}

---Gets stat conversion rules for the current class/spec
---Handles special conversions like Spirit->Hit for casters, Expertise->Hit for hybrids
---@return table<number, table<number, number>>|nil conversion Nested table of source stat to {dest stat = conversion rate}
function ReforgeLite:GetConversion()
  self.conversion = wipe(self.conversion or {})
  local classInfo = STAT_CONVERSIONS[playerClass]
  if classInfo then
    if classInfo.base then
      MergeTable(self.conversion, classInfo.base)
    end

    local spec = C_SpecializationInfo.GetSpecialization()
    if spec and classInfo.specs and classInfo.specs[spec] then
      MergeTable(self.conversion, classInfo.specs[spec])
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
  local char, floor = string.char, floor
  local scores, codes = {0}, {""}
  for i, opt in ipairs(reforgeOptions) do
    local newscores, newcodes = {}, {}
    for k, score in pairs(scores) do
      self:RunYieldCheck(200000)
      local s1, s2 = k % self.TABLE_SIZE, floor(k / self.TABLE_SIZE)
      for j = 1, #opt do
        local nscore = score + opt[j].score
        local nk = s1 + opt[j].d1 + (s2 + opt[j].d2) * self.TABLE_SIZE
        if not newscores[nk] or nscore > newscores[nk] then
          newscores[nk] = nscore
          newcodes[nk] = codes[k] .. char(j)
        end
      end
    end
    scores, codes = newscores, newcodes
  end
  return scores, codes
end

function ReforgeLite:ChooseReforgeClassic (data, reforgeOptions, scores, codes)
  local bestCode = {nil, nil, nil, nil}
  local bestScore = {0, 0, 0, 0}
  for k, score in pairs(scores) do
    self:RunYieldCheck(500000)
    local s1 = data.caps[1].init
    local s2 = data.caps[2].init
    local code = codes[k]
    for i = 1, #code do
      local b = code:byte (i)
      s1 = s1 + reforgeOptions[i][b].d1
      s2 = s2 + reforgeOptions[i][b].d2
    end
    local a1, a2 = true, true
    if data.caps[1].stat > 0 then
      a1 = a1 and self:CapAllows (data.caps[1], s1)
      score = score + self:GetCapScore (data.caps[1], s1)
    end
    if data.caps[2].stat > 0 then
      a2 = a2 and self:CapAllows (data.caps[2], s2)
      score = score + self:GetCapScore (data.caps[2], s2)
    end
    local allow = a1 and (a2 and 1 or 2) or (a2 and 3 or 4)
    if not bestCode[allow] or score > bestScore[allow] then
      bestCode[allow] = code
      bestScore[allow] = score
    end
  end
  return bestCode[1] or bestCode[2] or bestCode[3] or bestCode[4]
end

local chooseLoops = 0

---Main entry point for Classic (DP) reforge algorithm
---Initializes data, generates reforge options, computes optimal solution
---@return nil
function ReforgeLite:ComputeReforgeClassic()
  self.TABLE_SIZE = floor(10000 * (self.db.accuracy / addonTable.MAX_SPEED))
  local data = self:InitReforgeClassic()
  local reforgeOptions = {}
  for i = 1, #self.itemData do
    reforgeOptions[i] = self:GetItemReforgeOptions(data.method.items[i], data, i)
  end

  chooseLoops = 0

  local scores, codes = self:ComputeReforgeCore(reforgeOptions)

  chooseLoops = 0

  local code = self:ChooseReforgeClassic(data, reforgeOptions, scores, codes)

  for i = 1, #data.method.items do
    local opt = reforgeOptions[i][code:byte(i)]
    if data.conv[statIds.SPIRIT] and data.conv[statIds.SPIRIT][statIds.HIT] == 1 then
      if opt.dst == statIds.HIT and data.method.items[i].stats[statIds.SPIRIT] == 0 then
        opt.dst = statIds.SPIRIT
      end
    end
    data.method.items[i].src = opt.src
    data.method.items[i].dst = opt.dst
  end
  addonTable.methodDebug = { data = CopyTable(data) }
  self:FinalizeReforge (data)
  addonTable.methodDebug.method = CopyTable(data.method)
  if data.method then
    self.pdb.method = data.method
    self.pdb.methodOrigin = addonName
    self:UpdateMethodCategory ()
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

---Resumes the compute coroutine from a yield
---Handles errors and completes computation when coroutine finishes
---@return nil
function ReforgeLite:ResumeCompute()
  if not routine then return end
  local success, err = coroutine.resume(routine)
  if not success then
    print("Coroutine error - " .. tostring(err))
    self:EndCompute()
  elseif not NORMAL_STATUS_CODES[coroutine.status(routine)] then
    self:EndCompute()
  end
end

---Schedules compute resume on next frame
---@return nil
function ReforgeLite:ResumeComputeNextFrame()
  RunNextFrame(function() self:ResumeCompute() end)
end

---Checks if coroutine should yield to prevent freezing
---Yields every maxLoops iterations or when paused
---@param maxLoops number Number of iterations before yielding
---@return nil
function ReforgeLite:RunYieldCheck(maxLoops)
  if addonTable.pauseRoutine then
    chooseLoops = 0
    coroutine.yield()
  else
    if chooseLoops >= maxLoops then
      chooseLoops = 0
      self:ResumeComputeNextFrame()
      coroutine.yield()
    else
      chooseLoops = chooseLoops + 1
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
  routine = nil
  collectgarbage('collect')
end
