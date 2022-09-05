local ADDON_NAME, Addon = ...
local ThreatPlates = Addon.ThreatPlates

-- Lua APIs

-- WoW APIs

-- ThreatPlates APIs

function Addon:SetCastbarColor(unit)
	if not unit.unitid then return end

	local db = Addon.db.profile

	local c
	-- Because of this ordering, IsInterrupted must be set to false when a new cast is cast. Otherwise
  -- the interrupt color may be shown for a cast
	if unit.IsInterrupted then
		c = db.castbarColorInterrupted
	elseif unit.spellIsShielded then
		c = db.castbarColorShield
	else
		c = db.castbarColor
	end

	db = db.settings.castbar
	if db.BackgroundUseForegroundColor then
		return c.r, c.g, c.b, c.a, c.r, c.g, c.b, 1 - db.BackgroundOpacity
	else
		local color = db.BackgroundColor
		return c.r, c.g, c.b, c.a, color.r, color.g, color.b, 1 - db.BackgroundOpacity
	end
end