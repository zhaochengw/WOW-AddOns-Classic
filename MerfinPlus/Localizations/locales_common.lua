Merfin = Merfin or {}
Merfin.Localizations = Merfin.Localizations or {}

-- Add or override keys for a specific locale
function Merfin:AddLocaleLang(locale, data)
  local dst = self.Localizations[locale] or {}
  for k, v in pairs(data) do
    dst[k] = v
  end
  self.Localizations[locale] = dst
end

-- Set fallback to enUS for any missing keys
function Merfin:FinalizeLocales(defaultLocale)
  local baseLocale = defaultLocale or "enUS"
  local base = self.Localizations[baseLocale] or {}
  for locale, tbl in pairs(self.Localizations) do
    if locale ~= baseLocale then
      setmetatable(tbl, { __index = base })
    end
  end

  -- build lowercase maps after all locales are finalized
  self.LocaleKeyMap = self.LocaleKeyMap or {}
  for locale in pairs(self.Localizations) do
    self:BuildLowerKeyMap(locale)
  end
end

Merfin.LocaleKeyMap = Merfin.LocaleKeyMap or {}

function Merfin:BuildLowerKeyMap(locale)
  local locs = self.Localizations or {}
  local src = locs[locale]
  if not src then
    return
  end

  local map = {}
  for k in pairs(src) do
    if type(k) == "string" then
      map[k:lower()] = k
    end
  end

  self.LocaleKeyMap[locale] = map
end

function Merfin:L(key, vars, localeOverride)
  local locs = self.Localizations or {}
  local locale = localeOverride or (GetLocale and GetLocale()) or "enUS"

  local cur = locs[locale] or {}
  local base = locs.enUS or {}

  -- Lowercase maps (lazy build if needed)
  self.LocaleKeyMap = self.LocaleKeyMap or {}
  if not self.LocaleKeyMap[locale] then
    self:BuildLowerKeyMap(locale)
  end
  if not self.LocaleKeyMap["enUS"] then
    self:BuildLowerKeyMap("enUS")
  end

  local curMap = self.LocaleKeyMap[locale]
  local baseMap = self.LocaleKeyMap["enUS"]

  local s

  -- exact match first (fastest)
  s = cur[key] or base[key]

  -- case-insensitive lookup (also fast)
  if not s and type(key) == "string" then
    local lk = key:lower()

    local realKey = (curMap and curMap[lk]) or (baseMap and baseMap[lk])

    if realKey then
      s = cur[realKey] or base[realKey]
    end
  end

  -- fallback to key itself
  if not s then
    s = key
  end

  -- variable replacement logic remains unchanged
  if not vars then
    return s
  end

  if type(vars) == "table" then
    s = s:gsub("%%{(%w+)}", function(k)
      local v = vars[k]
      return v ~= nil and tostring(v) or ""
    end)

    if vars[1] ~= nil then
      s = string.format(s, unpack(vars))
    end
  end

  return s
end
