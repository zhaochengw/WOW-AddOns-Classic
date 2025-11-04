-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSTooltipScanners = private.NewLib("RareScannerTooltipScanners")

-- RareScanner general libraries
local RSUtils = private.ImportLib("RareScannerUtils")

---============================================================================
-- NPCs tooltip scanner
---============================================================================

local tooltipNames = {}
local lootTooltip

local function GetTooltipNameScanner(npcID)
	local now = GetTime()
	for i, tip in ipairs(tooltipNames) do
		if (not tip.npcID or tip.npcID == npcID) then
			tip.npcID = npcID
			return tip
		end
	end

	local tip = CreateFrame('GameTooltip', 'TooltipNpcName' .. (#tooltipNames + 1), UIParent, 'GameTooltipTemplate')
	tip:Show()
	tip:SetHyperlink('unit:')
	tip.npcID = npcID
	tinsert(tooltipNames, tip)
	return tip
end
	
function RSTooltipScanners.ScanNpcName(npcID, callback, secondTry)
	if (not npcID) then
		return
	end
	
	local tip = GetTooltipNameScanner(npcID)
	tip:SetOwner(UIParent, 'ANCHOR_NONE')
	tip:SetScript('OnTooltipSetUnit', function(self)
		local tipName = self:GetName()
		local name, _ = _G[tipName .. 'TextLeft1']:GetText(), _G[tipName ..'TextLeft2']:GetText()
		if (name) then
			--Cannot use RSNpcDB.SetNpcName(self.npcID, name), cyclic import!
			private.dbglobal.rare_names[GetLocale()][self.npcID] = name
			if (callback) then
				callback(name)
			end
		end
		self:SetScript('OnTooltipSetUnit', nil)
		self.npcID = nil
	end)
	tip:SetHyperlink('unit:Creature-0-0-0-0-' .. npcID .. '-0')
	
	if (not private.dbglobal.rare_names[GetLocale()][npcID] and not secondTry) then
		C_Timer.After(1, function()
			RSTooltipScanners.ScanNpcName(npcID, callback, true)
		end)
	elseif (callback) then
		callback()
	end
end

---============================================================================
-- Loot tooltip scanner
---============================================================================

function RSTooltipScanners.ScanLoot(itemLink, value)
	-- Init tooltip
	if (not lootTooltip) then
		lootTooltip = CreateFrame("GAMETOOLTIP", "RSToolTipScan", nil, "GameTooltipTemplate")
		lootTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	end
	
	lootTooltip:SetHyperlink(itemLink)
	
	local foundText = false
	for i=1, lootTooltip:NumLines() do
		if (_G["RSToolTipScanTextLeft"..i]) then
			local toolTipText = _G["RSToolTipScanTextLeft"..i]:GetText()
			if (toolTipText and RSUtils.Contains(toolTipText, value)) then
				foundText = true
				break
			end
		end
	end

	return foundText
end
