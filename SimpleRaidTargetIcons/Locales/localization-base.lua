local _, srti = ...
local L = setmetatable({}, {__index = function(t,k)
  local v = tostring(k)
  rawset(t,k,v)
  return v
end})

srti.L = L
