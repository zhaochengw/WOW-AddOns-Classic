local iconpath = "Interface\\GLUES\\CHARACTERCREATE\\UI-CharacterCreate-Classes"
local iconCutoff = 6

local function iconOffset(col, row)
	local offsetString = (col * 64 + iconCutoff) .. ":" .. ((col + 1) * 64 - iconCutoff)
	return offsetString .. ":" .. (row * 64 + iconCutoff) .. ":" .. ((row + 1) * 64 - iconCutoff)
end

local function isInEnabledPhase(phaseText) 

	if phaseText == "" then
		return true;
	end
	
	if LBISSettings.PhaseTooltip[LBIS.L["PreRaid"]] then
		if LBIS:FindInPhase(phaseText, "0") then
			return true;
		end
	end
	if LBISSettings.PhaseTooltip[LBIS.L["Phase 1"]] then
		if LBIS:FindInPhase(phaseText, "1") then
			return true;
		end
	end
	if LBISSettings.PhaseTooltip[LBIS.L["Phase 2"]] then
	 	if LBIS:FindInPhase(phaseText, "2") then
			return true;
	 	end
	end
	-- if LBISSettings.PhaseTooltip[LBIS.L["Phase 3"]] then
	-- 	if LBIS:FindInPhase(phaseText, "3") then
	--		return true;
	-- 	end
	-- end
	-- if LBISSettings.PhaseTooltip[LBIS.L["Phase 4"]] then
	-- 	if LBIS:FindInPhase(phaseText, "4") then
	--		return true;
	-- 	end
	-- end
	-- if LBISSettings.PhaseTooltip[LBIS.L["Phase 5"]] then
	-- 	if LBIS:FindInPhase(phaseText, "5") then
	--		return true;
	-- 	end
	-- end
	
	return false;
end

local function buildCombinedTooltip(entry, combinedTooltip, foundCustom)

	local classCount = {};
	local combinedSpecs = {};

	for k, v in pairs(entry) do
		if LBISSettings.Tooltip[k] and isInEnabledPhase(v.Phase) and foundCustom[k] == nil then
			local classSpec = LBIS.ClassSpec[k]

			classCount[classSpec.Class..v.Bis..v.Phase] = (classCount[classSpec.Class..v.Bis..v.Phase] or 0) + 1;
			if (combinedSpecs[classSpec.Class..v.Bis..v.Phase] == nil) then
				combinedSpecs[classSpec.Class..v.Bis..v.Phase] = { Class = classSpec.Class, Spec = classSpec.Spec, Bis = v.Bis, Phase = v.Phase }
			else				
				combinedSpecs[classSpec.Class..v.Bis..v.Phase].Spec = combinedSpecs[classSpec.Class..v.Bis..v.Phase].Spec..", "..classSpec.Spec;
			end
		end
	end
	
	for _, v in pairs(combinedSpecs) do
		if (v.Class ~= "Druid" and classCount[v.Class..v.Bis..v.Phase] == 3) then
			v.Spec = "";
		elseif (v.Class == "Druid" and classCount[v.Class..v.Bis..v.Phase] == 4) then
			v.Spec = "";
		end
		table.insert(combinedTooltip, { Class = v.Class, Spec = v.Spec, Bis = v.Bis, Phase = v.Phase })
	end
end

local function buildCustomTooltip(priorityEntry, combinedTooltip)

	local foundCustom = {}
	local showTooltip = false;
	if LBISSettings.ShowCustom and priorityEntry ~= nil then
		for k, v in pairs(priorityEntry) do
		
			local classSpec = LBIS.ClassSpec[k]
			foundCustom[k] = true;
				
			table.insert(combinedTooltip, { Class = classSpec.Class, Spec = classSpec.Spec, Bis = v.TooltipText, Phase = "" })
		end
	end

	return foundCustom;
end

local function buildTooltip(tooltip, combinedTooltip)

	if #combinedTooltip > 0 then
		local r,g,b = .9,.8,.5
		tooltip:AddLine(" ",r,g,b,true)
		tooltip:AddLine(LBIS.L["# Best for:"],r,g,b,true)
	end

	for k, v in pairs(combinedTooltip) do
		local class = LBIS.ENGLISH_CLASS[v.Class]:upper()
		local color = RAID_CLASS_COLORS[class]
		local coords = CLASS_ICON_TCOORDS[class]
		local classfontstring = "|T" .. iconpath .. ":14:14:::256:256:" .. iconOffset(coords[1] * 4, coords[3] * 4) .. "|t"
		
        if v.Phase == "0" then
            tooltip:AddDoubleLine(classfontstring .. " " .. v.Class .. " " .. v.Spec, v.Bis, color.r, color.g, color.b, color.r, color.g, color.b, true)
        else
            tooltip:AddDoubleLine(classfontstring .. " " .. v.Class .. " " .. v.Spec, v.Bis.." "..string.gsub(v.Phase, "0", "P"), color.r, color.g, color.b, color.r, color.g, color.b, true)
        end
	end
end

local tooltip_modified = {}
local function onTooltipSetItem(tooltip, ...)

	if tooltip_modified[tooltip:GetName()] then
		-- this happens twice, because of how recipes work
		return
	end
	tooltip_modified[tooltip:GetName()] = true

	local _, itemLink = tooltip:GetItem()
    if not itemLink then return end
	local itemString = string.match(itemLink, "item[%-?%d:]+")
	local itemId = tonumber(({ strsplit(":", itemString) })[2])

	LBIS:GetItemInfo(itemId, function(item)
		local combinedTooltip = {};
		local foundCustom = {};

		
		if LBIS.CustomEditList.Items[itemId] then
			foundCustom = buildCustomTooltip(LBIS.CustomEditList.Items[itemId], combinedTooltip)
		end

		local itemEntries = {};
		if LBIS.ItemsByIdAndSpec[itemId] then		
			for key, entry in pairs(LBIS.ItemsByIdAndSpec[itemId]) do 	
				itemEntries[key] = entry;
			end
		end

		if LBIS.TierSources[itemId] then
			for k, v in pairs(LBIS.TierSources[itemId]) do
				if LBIS.CustomEditList.Items[v] then
					foundCustom = buildCustomTooltip(LBIS.CustomEditList.Items[v], combinedTooltip)
				end
				
				if LBIS.ItemsByIdAndSpec[v] then
					for key, entry in pairs(LBIS.ItemsByIdAndSpec[v]) do 	
						itemEntries[key] = entry;
					end
				end
			end
		end

		buildCombinedTooltip(itemEntries, combinedTooltip, foundCustom);

		buildTooltip(tooltip, combinedTooltip);
	end)
end

local function onTooltipCleared(tooltip)
    tooltip_modified[tooltip:GetName()] = nil
end

local function onTooltipSetSpell(tooltip, ...)

	local _, spellId = tooltip:GetSpell()
    if not spellId then return end

	local combinedTooltip = {};

	if LBIS.SpellsByIdAndSpec[spellId] then
		buildCombinedTooltip(LBIS.SpellsByIdAndSpec[spellId], combinedTooltip, {})
	end

	buildTooltip(tooltip, combinedTooltip);
end

local hookStore = {};
local function hookScript(tip, script, prehook)
	if not hookStore[tip] then hookStore[tip] = {} end
	local control
	-- check for existing hook
	control = hookStore[tip][script]
	if control then
		control[1] = prehook or control[1]
		return
	end
	-- prepare upvalues
	local orig = tip:GetScript(script)
	control = {prehook}
	hookStore[tip][script] = control
	-- install hook stub
	local stub = function(...)
		local h
		-- prehook
		h = control[1]
		if h then h(...) end
		-- original hook
		if orig then orig(...) end
	end
	tip:SetScript(script, stub)
end

local function registerTooltip(tooltip)

	hookScript(tooltip, "OnTooltipSetItem", onTooltipSetItem);
	hookScript(tooltip, "OnTooltipSetSpell", onTooltipSetSpell);
	hookScript(tooltip, "OnTooltipCleared", onTooltipCleared);

end

local function linkWranglerHook(frame)
	registerTooltip(frame)
end

LBIS:RegisterEvent("PLAYER_ENTERING_WORLD" , function ()
	LBIS.EventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")

	registerTooltip(GameTooltip);
	registerTooltip(ShoppingTooltip1);
	registerTooltip(ShoppingTooltip2);

	registerTooltip(ItemRefTooltip);
	registerTooltip(ItemRefShoppingTooltip1)
	registerTooltip(ItemRefShoppingTooltip2)

	if LinkWrangler then
        LinkWrangler.RegisterCallback("EdrikGameFixes", linkWranglerHook, "allocate", "allocatecomp")
    end

    LBIS:Startup();
end);