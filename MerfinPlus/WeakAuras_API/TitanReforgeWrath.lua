local WA_GetUnitAura = function(unit, spell, filter)
  if filter and not filter:upper():find("FUL") then
    filter = filter .. "|HELPFUL"
  end
  for i = 1, 255 do
    local name, _, _, _, _, _, _, _, _, _, spellId = UnitAura(unit, i, filter)
    if not name then
      return
    end
    if spell == spellId or spell == name then
      return UnitAura(unit, i, filter)
    end
  end
end

local WA_GetUnitBuff = function(unit, spell, filter)
  filter = filter and filter .. "|HELPFUL" or "HELPFUL"
  return WA_GetUnitAura(unit, spell, filter)
end

local WA_GetUnitDebuff = function(unit, spell, filter)
  filter = filter and filter .. "|HARMFUL" or "HARMFUL"
  return WA_GetUnitAura(unit, spell, filter)
end

--- Anticlip Check
local channelMain = {
  ["WARLOCK"] = C_Spell.GetSpellName(47855),
  ["PRIEST"] = C_Spell.GetSpellName(48156),
}

local channelSpell = channelMain[myClass]

local IsSafeToCast = function(unitId, debuffs, isCast)
  if not UnitExists(unitId) then
    return
  end

  local debuffName, dur, expTime
  for _, spellId in ipairs(debuffs) do
    local spellName = GetSpellInfo(spellId)
    debuffName, _, _, _, dur, expTime = WA_GetUnitDebuff(unitId, spellName, "PLAYER|HARMFUL")
    if debuffName then
      break
    end
  end

  if not debuffName then
    return true
  end

  local remDebuffTime = expTime - GetTime()

  -- Cast Time of given Spell if is Cast
  local castTime = isCast and C_Spell.GetSpellInfo(debuffName).castTime / 1000 or 0

  local isCasting, _, _, _, endTimeMS = UnitCastingInfo("player")

  if isCasting then
    -- Cast Time Remaining
    local remCastTime = (endTimeMS / 1000) - GetTime()
    return (castTime + remCastTime) > remDebuffTime
  end

  isCasting, _, _, startTimeMS, endTimeMS = UnitChannelInfo("player")

  if isCasting then
    local remCastTime = (endTimeMS / 1000) - GetTime()

    -- We prefer to calculate the time til next Drain Soul tick on Warlocks
    if isCasting == channelSpell and myClass == "WARLOCK" then
      local totalChannelTime = (endTimeMS - startTimeMS) / 1000
      local tilNextTick = remCastTime % (totalChannelTime / 5)
      return (tilNextTick + castTime) > remDebuffTime
    end

    return (castTime + remCastTime) > remDebuffTime
  end

  -- GCD check
  local s, d = GetSpellCooldown(61304)
  if s == 0 then
    return castTime > remDebuffTime
  end
  return (castTime + s + d - GetTime()) > remDebuffTime
end

Merfin.AnticlipCheck = function(a, unitId, debuffs, isCast)
  if IsSafeToCast(unitId, debuffs, isCast) then
    if not a[""] then
      a[""] = {
        show = true,
        changed = true,
      }
      return true
    end
  elseif a[""] then
    a[""].show = false
    a[""].changed = true
    return true
  end
end
