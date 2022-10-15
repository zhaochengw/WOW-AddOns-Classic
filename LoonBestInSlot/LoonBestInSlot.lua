local addonName = ...;

LBIS.ClassSpec = {};
LBIS.SpecToName = {};
LBIS.Items = {};
LBIS.Spells = {};
LBIS.SpecItems = {};
LBIS.SpecGems = {};
LBIS.SpecEnchants = {};
LBIS.WowItemCache = {};
LBIS.WowSpellCache = {};
LBIS.AllItemsCached = false;
LBIS.CurrentPhase = 1;
LBIS.EventFrame = CreateFrame("FRAME",addonName.."Events")

SLASH_LOONBESTINSLOT1 = '/bis'
SlashCmdList["LOONBESTINSLOT"] = function(command)
	command = command:lower()
    
	if command == "" then
		LBIS.BrowserWindow:OpenWindow()
	elseif command == "settings"	then
		InterfaceOptionsFrame_Show()
		InterfaceOptionsFrame_OpenToCategory("Loon Best In Slot")
	end
end

function LBIS:Startup()

	if LBISSettings.ShowTooltip == nil then
		LBISSettings.ShowTooltip = true;
	end

	LBIS:CreateSettings();
	LBIS:RegisterMiniMap();
    LBIS:PreCacheItems();
end

function LBIS:RegisterEvent(...)
	if not LBIS.EventFrame.RegisteredEvents then
		LBIS.EventFrame.RegisteredEvents = { };
		LBIS.EventFrame:SetScript("OnEvent", function(self, event, ...)
			local handlers = self.RegisteredEvents[event];
			if handlers then
				for _, handler in ipairs(handlers) do
					handler(...);
				end
			end
		end);
	end

	local params = select("#", ...);

	local handler = select(params, ...);
	if type(handler) ~= "function" then
		error("LoonMasterLoot:RegisterEvent: The last passed parameter must be the handler function");
		return;
	end

	for i = 1, params - 1 do
		local event = select(i, ...);
		if type(event) == "string" then
			LBIS.EventFrame:RegisterEvent(event);
			LBIS.EventFrame.RegisteredEvents[event] = LBIS.EventFrame.RegisteredEvents[event] or { };
			table.insert(LBIS.EventFrame.RegisteredEvents[event], handler);
		else
			error("LBIS:RegisterEvent: All but the last passed parameters must be event names");
		end
	end
end

function LBIS:RegisterSpec(class, spec, phase)
	
	if not spec then spec = "" end
	
    local classSpec = {
		Class = class,
		Spec = spec,
		Phase = phase
	}
	
	classSpec.Id = spec..class

    LBIS.ClassSpec[classSpec.Id] = classSpec

    return classSpec
end

function LBIS:AddItem(bisEntry, id, slot, bis)

	if strlen(id) <= 0 then
		return
	end

	if LBIS.CurrentPhase < tonumber(bisEntry.Phase) then
		return;
	end
	
	if not LBIS.Items[id] then
		LBIS.Items[id] = {}
	end
	
	if zone == nil then
		zone = "";
	end

	if bisEntry.Phase == "0" then
		bis = LBIS.L["PreRaid"];
	elseif tonumber(bisEntry.Phase) < LBIS.CurrentPhase then
		bis = string.gsub(bis, "BIS", "Alt");
	end

	local searchedItem = LBIS.Items[id][bisEntry.Id];	

	if searchedItem == nil then		

		searchedItem = { Id = id, Bis = bis, Phase = bisEntry.Phase, Slot = slot }

		if not LBIS.SpecItems[bisEntry.Id] then
			LBIS.SpecItems[bisEntry.Id] = {}
		end
	
	else
		if bisEntry.Phase > searchedItem.Phase then
			searchedItem.Bis = bis;
		end

		local firstNumber, lastNumber = LBIS:GetPhaseNumbers(searchedItem.Phase);

		if tonumber(bisEntry.Phase) > tonumber(lastNumber) then
			searchedItem.Phase = firstNumber..">"..bisEntry.Phase;
		else
			searchedItem.Phase = bisEntry.Phase;
		end
	end

	LBIS.SpecItems[bisEntry.Id][tonumber(id)] = searchedItem;
	LBIS.Items[id][bisEntry.Id] = searchedItem;
	
	local itemSource = LBIS.ItemSources[tonumber(id)];

	if itemSource == nil then
		LBIS:Error("Couldn't find item source for: ", id);
	end

	if itemSource.SourceType == LBIS.L["Profession"] and tonumber(itemSource.SourceNumber) ~= nil and tonumber(itemSource.SourceNumber) > 0 then	
		if not LBIS.Items[itemSource.SourceNumber] then
			LBIS.Items[itemSource.SourceNumber] = {}
		end			
		LBIS.Items[itemSource.SourceNumber][bisEntry.Id] = searchedItem
	end

end

function LBIS:AddGem(bisEntry, id, quality, isMeta)

	if strlen(id) <= 0 then
		return
	end

	if LBIS.CurrentPhase < tonumber(bisEntry.Phase) then
		return;
	end
	
	if not LBIS.Items[id] then
		LBIS.Items[id] = {}
	end	

	local searchedItem = LBIS.Items[id][bisEntry.Id];

	if searchedItem == nil then

		searchedItem = { Id = id, Phase = "", Quality = quality, IsMeta = isMeta, Bis = "" }

		if not LBIS.SpecGems[bisEntry.Id] then
			LBIS.SpecGems[bisEntry.Id] = {}
		end
	end

	LBIS.SpecGems[bisEntry.Id][tonumber(searchedItem.Id)] = searchedItem;
	LBIS.Items[id][bisEntry.Id] = searchedItem
			
	local gemSource = LBIS.GemSources[tonumber(id)];

	if tonumber(gemSource.DesignId) > 0 then		
		if not LBIS.Items[gemSource.DesignId] then
			LBIS.Items[gemSource.DesignId] = {}
		end	

		LBIS.Items[gemSource.DesignId][bisEntry.Id] = searchedItem;
	end
end

function LBIS:AddEnchant(bisEntry, id, slot)

	if strlen(id) <= 0 then
		return
	end

	if LBIS.CurrentPhase < tonumber(bisEntry.Phase) then
		return;
	end
	
	if not LBIS.SpecEnchants[bisEntry.Id] then
		LBIS.SpecEnchants[bisEntry.Id] = {}
	end
		
	local enchantSource = LBIS.EnchantSources[tonumber(id)];

	local item = { Id = id, Slot = slot, Phase = "", Bis = "" };

	if enchantSource.IsSpell == "False" then
	
		if not LBIS.Items[id] then
			LBIS.Items[id] = {}
		end

		LBIS.Items[id][bisEntry.Id] = { Id = id, Slot = slot, Phase = "", Bis = "" }		
	else
		if not LBIS.Spells[id] then
			LBIS.Spells[id] = {}
		end

		LBIS.Spells[id][bisEntry.Id] = item;
	end

	if tonumber(enchantSource.DesignId) > 0 then
		if not LBIS.Items[enchantSource.DesignId] then
			LBIS.Items[enchantSource.DesignId] = {}
		end

		LBIS.Items[enchantSource.DesignId][bisEntry.Id] = item;
	end	

	LBIS.SpecEnchants[bisEntry.Id][tonumber(item.Id)] = item;
end