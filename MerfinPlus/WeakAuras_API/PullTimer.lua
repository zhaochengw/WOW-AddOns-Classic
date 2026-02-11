local MerfinPlus = LibStub("AceAddon-3.0"):GetAddon("MerfinPlus")

local db

local WAScanEvents = function(...)
  if not WeakAuras then
    return
  end
  WeakAuras.ScanEvents(...)
end

function MerfinPlus:PullTimerEnable()
  db = self.db.profile

  self:RegisterEvent("CHAT_MSG_ADDON", "HandleChatMsgAddon")
  self:RegisterEvent("GROUP_ROSTER_UPDATE", "HandleGroupRosterUpdate")
  self:RegisterEvent("START_PLAYER_COUNTDOWN", "HandleStartPlayerCountdown")
  self:RegisterEvent("CANCEL_PLAYER_COUNTDOWN", "HandleCancelPlayerCountdown")
end

local function IsSolo()
  return not (IsInRaid() or IsInGroup())
end

local function GetClassColorName(unit)
  if unit and UnitExists(unit) then
    local name = UnitName(unit)
    local _, class = UnitClass(unit)
    local classData = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
    return classData and ("|c%s%s|r"):format(classData.colorStr, name) or name
  end
  return ""
end

local function SendChatMessage(text)
  print("|cffffff80MerfinPlus:|r ", text)
end

local function GetUnitNameFromGUID(guid)
  if not guid then
    return
  end
  local _, _, _, _, _, name = GetPlayerInfoByGUID(guid)
  return name
end

local function HandleTimerCommand(msg, timerType)
  local duration = tonumber(msg)
  if not duration or IsSolo() then
    SendChatMessage("You need to be in a party or raid group to start a timer")
    return
  end

  local sendChannel = IsInRaid() and "RAID" or "PARTY"
  C_ChatInfo.SendAddonMessage("MERFIN_PT", "TIMER:" .. timerType .. ":" .. duration, sendChannel)

  if timerType == "PULL" then
    C_PartyInfo.DoCountdown(duration)
    db.pullStartTime = time()
    db.pullExpTime = db.pullStartTime + duration
  else
    db.breakStartTime = time()
    db.breakExpTime = db.breakStartTime + (duration < 60 and duration * 60 or duration)
  end
  --SendChatMessage(string.format("%s timer set for %d seconds.", timerType, duration))
end

SLASH_PULL1 = "/pull"
SlashCmdList["PULL"] = function(msg)
  HandleTimerCommand(msg, "PULL")
end

SLASH_BREAK1 = "/break"
SlashCmdList["BREAK"] = function(msg)
  HandleTimerCommand(msg, "BREAK")
end

local antispam = { PULL = {}, BREAK = {} }
local IsSpam = function(duration, senderName, type)
  if not antispam[type][senderName] then
    antispam[type][senderName] = {
      duration = duration,
      last = GetTime(),
    }
    return
  end

  if antispam[type][senderName] then
    if GetTime() - antispam[type][senderName].last > 0.2 or antispam[type][senderName].duration ~= duration then
      antispam[type][senderName].duration = duration
      antispam[type][senderName].last = GetTime()
      return
    end
  end

  return true
end

local SendChatTimer = function(senderName, duration, isPull, isBreak)
  local senderName = GetClassColorName(senderName)
  local message
  if duration == 0 then
    message =
      string.format("%s %s", senderName, isPull and " canceled pull timer." or isBreak and " canceled break timer.")
  else
    message = string.format(
      "%s %s for %1.fs",
      senderName,
      isPull and "started a pull timer" or isBreak and "started a break timer",
      duration
    )
  end
  if message then
    SendChatMessage(message)
  end
end

local function StartTimer(duration, senderName, timerType)
  -- If Sender is Leader of Assist
  if not senderName then
    return
  end
  local isLeader = UnitIsGroupLeader(senderName)
  local isAssistant = UnitIsGroupAssistant(senderName)
  if isLeader or isAssistant and not IsSolo() then
    if not timerType or not antispam[timerType] or IsSpam(duration, senderName, timerType) then
      return
    end
    if timerType == "PULL" then
      db.pullStartTime = time()
      db.pullExpTime = duration + db.pullStartTime
      db.pullTotalTime = duration
      db.pullSenderName = senderName

      WAScanEvents("MERFIN_PULL_TIMER", duration, duration, senderName)
      SendChatTimer(senderName, duration, true)
    elseif timerType == "BREAK" then
      if duration > 0 and duration < 60 then
        duration = duration * 60
      end
      db.breakStartTime = time()
      db.breakExpTime = duration + db.breakStartTime
      db.breakTotalTime = duration
      db.breakSenderName = senderName

      WAScanEvents("MERFIN_BREAK_TIMER", duration, duration, senderName)
      SendChatTimer(senderName, duration, false, true)
    end
  end
end

-- Register the addon message prefixes
C_ChatInfo.RegisterAddonMessagePrefix("MERFIN_PT")
C_ChatInfo.RegisterAddonMessagePrefix("BigWigs")
C_ChatInfo.RegisterAddonMessagePrefix("D5")

function MerfinPlus:HandleChatMsgAddon(event, prefix, msg, channel, sender)
  if prefix == "MERFIN_PT" and msg:find("^TIMER:") then
    local _, timerType, duration = strsplit(":", msg)
    duration = tonumber(duration)
    -- Get unit name of sender without server name
    local senderName = Ambiguate(sender, "none")
    StartTimer(duration, senderName, timerType)
  elseif prefix == "BigWigs" then
    local _, timerType, duration = strsplit("^", msg)
    duration = tonumber(duration)
    -- Get unit name of sender without server name
    local senderName = Ambiguate(sender, "none")
    StartTimer(duration, senderName, string.upper(timerType))
  elseif prefix == "D5" then
    local _, _, timerType, duration = strsplit("	", msg)
    duration = tonumber(duration)
    local senderName = Ambiguate(sender, "none")
    if timerType == "BT" then
      StartTimer(duration, senderName, "BREAK")
    end
  end
end

function MerfinPlus:HandleGroupRosterUpdate()
  if IsSolo() then
    db.pullStartTime = 0
    db.pullExpTime = 0
    db.breakStartTime = 0
    db.breakExpTime = 0
  end
end

function MerfinPlus:HandleStartPlayerCountdown(event, initiatedBy, timeRemaining, _)
  local senderName = GetUnitNameFromGUID(initiatedBy)
  StartTimer(timeRemaining, senderName, "PULL")
end

function MerfinPlus:HandleCancelPlayerCountdown(event, initiatedBy)
  local senderName = GetUnitNameFromGUID(initiatedBy)
  StartTimer(0, senderName, "PULL")
end

local function GetSavedTimer(timerType)
  local curTime = time()
  local startTime = db[timerType .. "StartTime"] or 0
  local expTime = db[timerType .. "ExpTime"] or 0
  local totalTime = db[timerType .. "TotalTime"] or 0
  local senderName = db[timerType .. "SenderName"] or "Unknown"

  if expTime > curTime then
    return expTime - curTime, totalTime, senderName
  end
end

function Merfin.GetPullTimer()
  return GetSavedTimer("pull")
end

function Merfin.GetBreakTimer()
  return GetSavedTimer("break")
end
