local addon = select(2, ...).addon

local CopyAnything = {}

_G["CopyAnything"] = setmetatable(CopyAnything, {
	__call = function()
		addon:SlashCopy()
	end,
})
