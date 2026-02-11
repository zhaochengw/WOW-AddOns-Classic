local _, MerfinPlus = ...
local LSM = LibStub("LibSharedMedia-3.0")

_G.Merfin = _G.Merfin or {}
local Merfin = _G.Merfin

local stformat = string.format
local SpeakText = C_VoiceChat.SpeakText

local localization = MerfinPlus.localization

-- Color for names in LSM (blue)
local NAME_COLOR_HEX = "33AAFF"
local Colorize = function(text)
  return ("|cff%s%s|r"):format(NAME_COLOR_HEX, text)
end

---------------------
-- Registering Sounds
---------------------

local soundsFileNames = {}

soundsFileNames.noloc = {
  "Alert Bell",
  "Important Mechanic",
  "Soft Alert",
  "Error",
  "Info Beep",
  "Level Up",
  "Spell On You",
  "Alarm",
  "Alert",
  "Pull Timer Start",
  "Boing",
  "Bloop",
  "Frog",
  "Chomp",
  "Bonk",
  "Info",
  "Long",
  "Spell Under You",
  "Victory",
}

soundsFileNames.General = {
  "1",
  "2",
  "3",
  "4",
  "5",
  "Add Spawned",
  "Adds Spawned",
  "Air Phase",
  "Avoid",
  "Bait",
  "Burst the boss",
  "Defensive",
  "Face away",
  "Frontal",
  "Interrupt",
  "Knockback",
  "Move the boss",
  "Phase 1",
  "Phase 2",
  "Phase 3",
  "Phase 4",
  "Platform 2",
  "Platform 3",
  "Prepare for Frontal",
  "Run Away",
  "Run in",
  "Run out",
  "Spread out",
  "Stack with raid",
  "Spread",
  "Stack",
  "Stop Casting",
  "Switch Targets",
  "Taunt",
  "Watch your feet",
  "Dance",
  "Plus Damage",
  "Close",
  "Middle",
  "Far",
  "Explosion in",
  "Left",
  "Right",
  "Out",
  "Forward",
  "Behind",
  "Dodge",
  "Adds",
  "High Stacks",
  "Prepare to Dodge",
  "Prepare to throw",
  "Start in 1",
  "Start in 3",
  "Start in 4",
  "Double Right",
}

soundsFileNames.Reminders = {
  "DrainSoul",
  "EatFeast",
  "Magefood",
  "Mailbox",
  "Repairbot",
  "SummonStone",
  "TakeHealhtstoneIdiot",
}

local SoundDisplayNames = {
  DrainSoul = "Reminder: Drain Soul",
  EatFeast = "Reminder: Eat Feast",
  Magefood = "Reminder: Conjure Food",
  Mailbox = "Reminder: Mailbox",
  Repairbot = "Reminder: Repair Bot",
  SummonStone = "Reminder: Click Summoning Stone",
  TakeHealhtstoneIdiot = "Reminder: Take Healthstone",
}

local soundPaths = {}
local mainPath = [[Interface\Addons\MerfinPlus\Media\sound]]
local GetSoundPath = function(folderPath, soundFileName)
  return stformat([[%s\%s\%s.mp3]], mainPath, folderPath, soundFileName)
end

local RegisterSounds = function(folderName, folderPath, RegisterLSM)
  for _, soundName in ipairs(soundsFileNames[folderName]) do
    local soundPath = GetSoundPath(folderPath, soundName)
    soundPaths[soundName] = soundPath
    if RegisterLSM then
      local displayName = SoundDisplayNames[soundName] or soundName
      LSM:Register("sound", "M: " .. displayName, soundPath)
    end
  end
end

----------------
-- WeakAuras API
----------------
if select(4, GetBuildInfo()) < 120000 then -- not on retail
  Merfin.PlaySound = function(replica, speed, volume, voiceId)
    if Merfin.L == "ruRU" then
      local soundPath = soundPaths[replica]
      if soundPath then
        PlaySoundFile(soundPath, "Master")
      end
    else
      local soundPath = soundPaths[replica]
      if soundPath and PlaySoundFile(soundPath, "Master") then
      elseif Merfin.L == "enUS" then
        SpeakText(voiceId or 1, replica, Enum.VoiceTtsDestination.LocalPlayback, speed or 1, volume or 100)
      end
    end
  end
end

Merfin.RegisterSoundPaths = function()
  local locale = (GetLocale() == "zhTW" and "zhCN") or GetLocale()
  RegisterSounds("noloc", "noloc", true)
  RegisterSounds("General", stformat([[%s\%s]], locale, "General"), true)
  RegisterSounds("Reminders", "reminders", true)
end

Merfin.RegisterSoundPaths()
