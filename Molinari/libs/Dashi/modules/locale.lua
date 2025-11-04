local _, addon = ...

-- localization
local localizations = {}
local locale = GetLocale()

--[[ namespace.L ![](https://img.shields.io/badge/object-teal)
Metatable used specifically for managing localizations, see below for interactions.
--]]
--[[ namespace.L(_locale_) ![](https://img.shields.io/badge/function-blue)
Returns a localization object specific to the given `locale`.

Usage:
```lua
local L = namespace.L('frFR')
-- see methods below
```
--]]
--[[ namespace.L(_locale_)[`string`] ![](https://img.shields.io/badge/object-teal)
Sets a localization `string` for the given `locale`.

Usage:
```lua
local L = namespace.L('deDE')
L['New string'] = 'Neue saite'
```
--]]
--[[ namespace.L[`string`] ![](https://img.shields.io/badge/object-teal)
Reads a localized `string` for the active locale.  
If a localized string for the active locale is not available the `string` will be read back.

Usage:
```lua
print(namespace.L['New string']) --> "Neue saite" on german clients, "New string" on all others
print(namespace.L['Unknown']) --> "Unknown" on all clients since there are no localizations
```
--]]
addon.L = setmetatable({}, {
	__index = function(_, key)
		local localeTable = localizations[locale]
		return localeTable and localeTable[key] or tostring(key)
	end,
	__call = function(_, newLocale)
		localizations[newLocale] = localizations[newLocale] or {}
		return localizations[newLocale]
	end,
})
