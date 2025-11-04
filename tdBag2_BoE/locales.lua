local addonName, addon = ...

local L = setmetatable({}, { __index = function(t, k)
  local v = tostring(k)
  rawset(t, k, v)
  return v
end })
addon.L = L
local LOCALE = GetLocale()
if LOCALE == "enUS" then
  return
end
if LOCALE == "deDE" then

end
if LOCALE == "frFR" then

end
if LOCALE == "ruRU" then

end
if LOCALE == "zhCN" then

end
if LOCALE == "zhTW" then

end
