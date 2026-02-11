local _, MerfinPlus = ...

local LSM = LibStub("LibSharedMedia-3.0")

local L = GetLocale()

local localizedFonts = {
  ["enUS"] = "Expressway.ttf",
  ["ruRU"] = "Expressway.ttf",
}

local SetMediaName = function(name)
  return "Merfin: " .. name
end

local RegisterFont = function(name, filename, locales)
  LSM:Register("font", name, ([[Interface\AddOns\MerfinPlus\Media\font\%s]]):format(filename), locales)
end

local LSM = LibStub("LibSharedMedia-3.0")

local RegisterFont = function(name, filename, locales)
  LSM:Register("font", name, ([[Interface\AddOns\MerfinPlus\Media\font\%s]]):format(filename), locales)
end

function MerfinPlus:RegisterFonts()
  local WEST = LSM.LOCALE_BIT_western
  local RU = LSM.LOCALE_BIT_ruRU
  local ZHCN = LSM.LOCALE_BIT_zhCN
  local ZHTW = LSM.LOCALE_BIT_zhTW

  -- Latin/RU
  RegisterFont("ArchivoNarrow-Bold", "ArchivoNarrow-Bold.ttf", WEST + RU)
  RegisterFont("Expressway", "Expressway.ttf", WEST + RU)
  RegisterFont("HOOGE", "HOOGE.TTF", WEST + RU + ZHCN + ZHTW)
  RegisterFont("SFUIDisplayCondensed-Bold", "SFUIDisplayCondensed-Bold.otf", WEST + RU)
  RegisterFont("SFUIDisplayCondensed-Semibold", "SFUIDisplayCondensed-Semibold.otf", WEST + RU)

  -- Chinese-capable
  --if L == 'zhTW' or L == 'zhCN' then
  RegisterFont("CN Merged (SF-Yahee)", "CN Merged (SF-Yahee).ttf", WEST + ZHCN + ZHTW)
  --end
end
