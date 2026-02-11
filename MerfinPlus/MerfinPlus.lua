local _, MerfinPlus = ...
MerfinPlus = LibStub("AceAddon-3.0"):NewAddon(MerfinPlus, "MerfinPlus", "AceEvent-3.0")

function MerfinPlus:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("MerfinPlusSaved", MerfinPlus.defaults, true)
  self:RegisterCustomFonts()
  self:RegisterCustomBars()
  self:RegisterMediaAliasesFromCallback()
  self:RegisterFonts()
  self:RegisterBars()
  self:SetupOptions()
end

function MerfinPlus:OnEnable()
  MerfinPlus:PullTimerEnable()
  MerfinPlus:LFGEnable()
end

function MerfinPlus:GetDB()
  if not self.db then
    error("[MerfinPlus] Database is not initialized yet!")
  end
  return self.db.profile
end

-- To identify the Toc version
MerfinPlus.BuildInfo = select(4, GetBuildInfo())

Merfin = Merfin or {}

Merfin.L = GetLocale()
Merfin.ForcedSoundLoc = false

local supportedLoc = {
  ["ruRU"] = true,
  ["enUS"] = true,
  ["zhCN"] = true,
}

Merfin.GetLocale = function()
  if Merfin.ForcedSoundLoc then
    return Merfin.ForcedSoundLoc
  elseif not supportedLoc[Merfin.L] then
    return "enUS"
  else
    return Merfin.L
  end
end
