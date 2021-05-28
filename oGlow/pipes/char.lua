-- TODO:
--  - Write a description.

if(select(4, GetAddOnInfo("Fizzle"))) then return end

local _E
local hook
local slots = {
	"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist",
	"Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand",
	"SecondaryHand", "Ranged", [19] = "Tabard",
}

local function GetDurabilityNumbers(slotId)
	local cur, max = GetInventoryItemDurability(slotId)
	cur, max = tonumber(cur) or 0, tonumber(max) or 0

	local percent = math.floor(cur / max * 100)

	return cur, max, percent
end

local function GetThresholdColour(percent)
	if percent < 0 then
		return 1, 0, 0
	elseif percent <= 0.5 then
		return 1, percent * 2, 0
	elseif percent >= 1 then
		return 0, 1, 0
	else
		return 2 - percent * 2, 1, 0
	end
end

local update = function(self)
	if(CharacterFrame:IsShown()) then
		for key, slotName in pairs(slots) do
			local slotFrame = _G['Character' .. slotName .. 'Slot']
			local slotLink = GetInventoryItemLink('player', key)

			oGlow:CallFilters('char', slotFrame, _E and slotLink)

			local id, _ = GetInventorySlotInfo(slotName .. 'Slot')
			local cur, max, percent = GetDurabilityNumbers(id)
			if max ~= 0 then
				slotFrame.oGlowDurability:SetText(percent .. '%')
				slotFrame.oGlowDurability:SetTextColor(GetThresholdColour(cur / max))
			else
				slotFrame.oGlowDurability:SetText('')
			end
		end
	end
end

local UNIT_INVENTORY_CHANGED = function(self, event, unit)
	if(unit == 'player') then
		update(self)
	end
end

local UPDATE_INVENTORY_DURABILITY = function(self, event)
	update(self)
end

local enable = function(self)
	_E = true

	self:RegisterEvent('UNIT_INVENTORY_CHANGED', UNIT_INVENTORY_CHANGED)

    self:RegisterEvent("UPDATE_INVENTORY_DURABILITY", UPDATE_INVENTORY_DURABILITY)

	if(not hook) then
		hook = function(...)
			if(_E) then return update(...) end
		end

		CharacterFrame:HookScript('OnShow', hook)
	end
end

local disable = function(self)
	_E = nil
	self:UnregisterEvent('UNIT_INVENTORY_CHANGED', UNIT_INVENTORY_CHANGED)
end

oGlow:RegisterPipe('char', enable, disable, update, 'Character frame', nil)
