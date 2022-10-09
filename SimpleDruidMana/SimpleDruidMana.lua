
local UNIT_PLAYER = "player"
local POWERTYPE_MANA = Enum.PowerType.Mana

local function On_Event(self, evt, arg1, arg2, ...)
	if evt == "UNIT_POWER_UPDATE" then
		if arg2 == "MANA" then
			local mana = UnitPower(UNIT_PLAYER, POWERTYPE_MANA)
			self:SetValue(mana / UnitPowerMax(UNIT_PLAYER, POWERTYPE_MANA))
			self.Label:SetText(mana)
		end
	elseif evt == "UNIT_DISPLAYPOWER" then
		local powerType, _ = UnitPowerType(UNIT_PLAYER)
		if powerType ~= POWERTYPE_MANA then
			self:Show()
		else
			self:Hide()
		end
	elseif evt == "PLAYER_LOGIN" then
		-- Initialize
		On_Event(self, "UNIT_DISPLAYPOWER", UNIT_PLAYER)
		On_Event(self, "UNIT_POWER_UPDATE", UNIT_PLAYER, "MANA")

		-- Lable Justify, (Main Menu -> Interface -> Display -> Status Text Display)
		local style = GetCVar("statusTextDisplay")
		if style ~= "BOTH" then
			if style == "NONE" then
				self.Label:Hide()
			else
				self.Label:SetJustifyH("CENTER")
			end
		end
		-- Hide built-in druid manabar
		if (PlayerFrameAlternateManaBar) then
			local origin = PlayerFrameAlternateManaBar
			origin:SetScript("OnUpdate", nil)
			origin:SetScript("OnEvent", nil)
			origin:SetScript("OnMouseUp", nil)
			origin:UnregisterEvent("UNIT_POWER_UPDATE")
			origin:UnregisterEvent("UNIT_MAXPOWER")
			origin:UnregisterEvent("PLAYER_ENTERING_WORLD")
			origin:UnregisterEvent("UNIT_DISPLAYPOWER")
			origin:UnregisterEvent("UPDATE_VEHICLE_ACTIONBAR")
			origin:UnregisterEvent("UNIT_EXITED_VEHICLE")
			origin:Hide()
		end
	end
end

function SimpleDruidMana_OnLoad(self)
	local _, playerClass = UnitClass("player")
	if playerClass ~= "DRUID" then
		return
	end
	self:SetMinMaxValues(0, 1.0)
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterUnitEvent("UNIT_POWER_UPDATE", UNIT_PLAYER)
	self:RegisterUnitEvent("UNIT_DISPLAYPOWER", UNIT_PLAYER)
	self:SetScript("OnEvent", On_Event)
end
