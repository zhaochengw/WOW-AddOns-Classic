local _, MerfinPlus = ...
MerfinPlus = LibStub("AceAddon-3.0"):NewAddon(MerfinPlus, "MerfinPlus", "AceEvent-3.0")

MerfinPlus.BuildInfo = select(4, GetBuildInfo())

function MerfinPlus:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("MerfinPlusSaved", MerfinPlus.defaults, true)
  self:RegisterCustomFonts()
  self:RegisterCustomBars()
  self:RegisterMediaAliasesFromCallback()
  self:RegisterFonts()
  self:RegisterBars()
  self:SetupOptions()
  if self.InitializeWoWSimDefaults then
    self:InitializeWoWSimDefaults()
  end
end

function MerfinPlus:OnEnable()
  if MerfinPlus.BuildInfo < 120000 then
    MerfinPlus:PullTimerEnable()
    MerfinPlus:LFGEnable()
  end
end

function MerfinPlus:GetDB()
  if not self.db then
    error("[MerfinPlus] Database is not initialized yet!")
  end
  return self.db.profile
end

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
