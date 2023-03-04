local addonName = ...;

LBIS.ClassSpec = {};
LBIS.NameToSpecId = {};
LBIS.ItemsByIdAndSpec = {};
LBIS.SpellsByIdAndSpec = {};

LBIS.ItemsBySpecAndId = {};
LBIS.GemsBySpecAndId = {};
LBIS.EnchantsBySpecAndId = {};

LBIS.SpellCache = {};

LBIS.AllItemsCached = false;
LBIS.CurrentPhase = 2;

LBIS.EventFrame = CreateFrame("FRAME",addonName.."Events")

SLASH_LOONBESTINSLOT1 = '/bis'
SLASH_LOONBESTINSLOT2 = '/비스'
SlashCmdList["LOONBESTINSLOT"] = function(command)
	command = command:lower()
    
	if command == "" then
		LBIS.BrowserWindow:OpenWindow()
	elseif command == "edit" then
		LBIS.BrowserWindow:OpenWindow("CustomEditList")
	elseif command == "custom" then
		LBIS.BrowserWindow:OpenWindow("CustomItemList")
	elseif command == "settings"	then
		InterfaceOptionsFrame_Show()
		InterfaceOptionsFrame_OpenToCategory("Loon Best In Slot")
	end
end

function LBIS:Startup()

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

	local itemId = tonumber(id);

	if LBIS.CurrentPhase < tonumber(bisEntry.Phase) then
		return;
	end	
	
		if not LBIS.ItemsByIdAndSpec[itemId] then
		LBIS.ItemsByIdAndSpec[itemId] = {}
	end
	
	if zone == nil then
		zone = "";
	end

	if bisEntry.Phase == "0" then
		bis = LBIS.L["PreRaid"];
	elseif tonumber(bisEntry.Phase) < LBIS.CurrentPhase then
		bis = string.gsub(bis, "BIS", "Alt");
	end

	local searchedItem = LBIS.ItemsByIdAndSpec[itemId][bisEntry.Id];	

	if searchedItem == nil then

		searchedItem = { Id = itemId, Bis = bis, Phase = bisEntry.Phase, Slot = slot }
		
		if not LBIS.ItemsBySpecAndId[bisEntry.Id] then
			LBIS.ItemsBySpecAndId[bisEntry.Id] = {}
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

	LBIS.ItemsBySpecAndId[bisEntry.Id][itemId] = searchedItem;
	LBIS.ItemsByIdAndSpec[itemId][bisEntry.Id] = searchedItem;
	
	local itemSource = LBIS.ItemSources[itemId];

	if itemSource == nil then
		LBIS:Error("Couldn't find item source for: ", id);
	end

	if itemSource.SourceType == LBIS.L["Profession"] and tonumber(itemSource.SourceNumber) ~= nil and tonumber(itemSource.SourceNumber) > 0 then	
		if not LBIS.ItemsByIdAndSpec[tonumber(itemSource.SourceNumber)] then
			LBIS.ItemsByIdAndSpec[tonumber(itemSource.SourceNumber)] = {}
		end			
		LBIS.ItemsByIdAndSpec[tonumber(itemSource.SourceNumber)][bisEntry.Id] = searchedItem
	end	
end

function LBIS:AddGem(bisEntry, id, quality, isMeta)

	if strlen(id) <= 0 then
		return
	end

	local gemId = tonumber(id);

	if LBIS.CurrentPhase < tonumber(bisEntry.Phase) then
		return;
	end
	
	if not LBIS.ItemsByIdAndSpec[gemId] then
		LBIS.ItemsByIdAndSpec[gemId] = {}
	end	

	local searchedItem = LBIS.ItemsByIdAndSpec[gemId][bisEntry.Id];

	if searchedItem == nil then

		searchedItem = { Id = gemId, Phase = "", Quality = quality, IsMeta = isMeta, Bis = "" }

		if not LBIS.GemsBySpecAndId[bisEntry.Id] then
			LBIS.GemsBySpecAndId[bisEntry.Id] = {}
		end
	end

	LBIS.GemsBySpecAndId[bisEntry.Id][gemId] = searchedItem;
	LBIS.ItemsByIdAndSpec[gemId][bisEntry.Id] = searchedItem

	local gemSource = LBIS.GemSources[gemId];

	local designId = tonumber(gemSource.DesignId);
	if designId > 0 then		
		if not LBIS.ItemsByIdAndSpec[designId] then
			LBIS.ItemsByIdAndSpec[designId] = {}
		end	

		LBIS.ItemsByIdAndSpec[designId][bisEntry.Id] = searchedItem;
	end
end

function LBIS:AddEnchant(bisEntry, id, slot)

	if strlen(id) <= 0 then
		return
	end

	local enchantId = tonumber(id);

	if LBIS.CurrentPhase < tonumber(bisEntry.Phase) then
		return;
	end	
	
	if not LBIS.EnchantsBySpecAndId[bisEntry.Id] then
		LBIS.EnchantsBySpecAndId[bisEntry.Id] = {}
	end

	local enchantSource = LBIS.EnchantSources[enchantId];
	local designId = tonumber(enchantSource.DesignId);
	local scrollId = tonumber(enchantSource.ScrollId);

	local item = { Id = enchantId, Slot = slot, Phase = "", Bis = "" };

	if enchantSource.IsSpell == "False" then
	
		if not LBIS.ItemsByIdAndSpec[enchantId] then
			LBIS.ItemsByIdAndSpec[enchantId] = {}
		end

		LBIS.ItemsByIdAndSpec[enchantId][bisEntry.Id] = { Id = enchantId, Slot = slot, Phase = "", Bis = "" }		
	else
		if not LBIS.SpellsByIdAndSpec[enchantId] then
			LBIS.SpellsByIdAndSpec[enchantId] = {}
		end

		LBIS.SpellsByIdAndSpec[enchantId][bisEntry.Id] = item;
	end

	if designId > 0 then
		if not LBIS.ItemsByIdAndSpec[designId] then
			LBIS.ItemsByIdAndSpec[designId] = {}
		end

		LBIS.ItemsByIdAndSpec[designId][bisEntry.Id] = item;
	end	

	if scrollId > 0 then
		if not LBIS.ItemsByIdAndSpec[scrollId] then
			LBIS.ItemsByIdAndSpec[scrollId] = {}
		end

		LBIS.ItemsByIdAndSpec[scrollId][bisEntry.Id] = item;
	end	

	LBIS.EnchantsBySpecAndId[bisEntry.Id][enchantId] = item;
end
