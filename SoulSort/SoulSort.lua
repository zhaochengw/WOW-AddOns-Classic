local addonname = ...
local f = CreateFrame("Frame", addonname, UIParent)
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("BAG_UPDATE")
f:RegisterEvent("ADDON_LOADED")
f:Hide()

f:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
	if event == "ADDON_LOADED" and arg1 == addonname then
		--First time load, init default settings
		if not SoulSortOptions then
			SoulSortOptions = {}
			SoulSortOptions.MaxShards = 0
			SoulSortOptions.AutoMax = false
			SoulSortOptions.ShowCounter = false
			SoulSortOptions.ShowCounterPerBag = true
			SoulSortOptions.SortReverse = false
			SoulSortOptions.ShowSortInfo = false
			SoulSortOptions.ShowCombatWarning = true
			if SS_IsClassicVersion() then
				SoulSortOptions.AutoSort = true
			end
		end
		SS_InitSoulShardCounter()
	elseif event == "BAG_UPDATE" then
		SS_UpdateShardCount()
	end
end)

local _G = _G
local brsSoulSort = _G.LibStub("LibDataBroker-1.1"):NewDataObject("SoulSort", {
	type = "data source",
	icon = "Interface\\Icons\\inv_misc_gem_amethyst_02.blp",
	label = "SoulSort",
	OnClick = function(clickedframe, button)
		InterfaceOptionsFrame:Show()
		InterfaceOptionsFrame_OpenToCategory("SoulSort")
	end,
	OnTooltipShow = function()end,
})

SLASH_SOULSORT1 = "/soulsort"
SLASH_SOULSORT2 = "/ss"
SlashCmdList["SOULSORT"] = function(msg)
	local tokens = SS_Tokenize(msg)
	if table.getn(tokens) > 0 then
		if strlower(tokens[1]) == "sort" then
			if not InCombatLockdown() then
				SS_SortShards()
			elseif SoulSortOptions.ShowCombatWarning then
				print("SoulSort: Cannot sort shards while in combat!")
			end
		elseif strlower(tokens[1]) == "max" then
			if table.getn(tokens) > 1 then
				argument = tonumber(tokens[2])
				if argument and argument == math.floor(argument) and argument >= 0 then
					SS_SetMaxShards(argument)
					SoulSortOptions.AutoMax = false
					print("SoulSort: Max number of Soul Shards to keep set to", SoulSortOptions.MaxShards)
				else
					print("SoulSort: No number or invalid number provided.") 
					print("Use \"/ss max [number]\", 0 = infinite")
					if SoulSortOptions.AutoMax == true then
						print("Current maximum:", SoulSortOptions.MaxShards, "(AutoMax is on)")
					else
						print("Current maximum:", SoulSortOptions.MaxShards)
					end
				end
			else
				print("SoulSort: No number provided.")
				print("Use \"/ss max [number]\", 0 = infinite")
				if SoulSortOptions.AutoMax == true then
					print("Current maximum:", SoulSortOptions.MaxShards, "(AutoMax is on)")
				else
					print("Current maximum:", SoulSortOptions.MaxShards)
				end
			end
		elseif strlower(tokens[1]) == "autosort" and SS_IsClassicVersion() then
			if table.getn(tokens) > 1 then
				if tokens[2] == "on" or  tokens[2] == "true" then
					SoulSortOptions.AutoSort = true
					print("SoulSort: AutoSort Enabled")
				elseif tokens[2] == "off" or  tokens[2] == "false" then
					SoulSortOptions.AutoSort = false
					print("SoulSort: AutoSort Disabled")
				else
					print("SoulSort: No option provided. Use \"/ss autosort [on/off]\"")
				end
			else
				print("SoulSort: No option provided. Use \"/ss autosort [on/off]\"")
			end
		elseif strlower(tokens[1]) == "automax" then
			if table.getn(tokens) > 1 then
				if tokens[2] == "on" or  tokens[2] == "true" then
					SoulSortOptions.AutoMax = true
					SS_CalculateAutoSize()
					print("SoulSort: AutoMax Enabled")
				elseif tokens[2] == "off" or  tokens[2] == "false" then
					SoulSortOptions.AutoMax = false
					print("SoulSort: AutoMax Disabled")
				else
					print("SoulSort: No option provided. Use \"/ss automax [on/off]\"")
				end
			else
				print("SoulSort: No option provided. Use \"/ss automax [on/off]\"")
			end
		elseif strlower(tokens[1]) == "counter" or strlower(tokens[1]) == "count" then
			if table.getn(tokens) > 1 then
				if tokens[2] == "on" or  tokens[2] == "true" then
					SoulSortOptions.ShowCounter = true
					SS_UpdateCounterVisibilty()
					print("SoulSort: Counter Enabled")
				elseif tokens[2] == "off" or  tokens[2] == "false" then
					SoulSortOptions.ShowCounter = false
					SS_UpdateCounterVisibilty()
					print("SoulSort: Counter Disabled")
				else
					print("SoulSort: No option provided. Use \"/ss counter [on/off]\"")
				end
			else
				print("SoulSort: No option provided. Use \"/ss counter [on/off]\"")
			end			
		elseif strlower(tokens[1]) == "reverse" then
			if table.getn(tokens) > 1 then
				if tokens[2] == "on" or  tokens[2] == "true" then
					SoulSortOptions.SortReverse = true
					print("SoulSort: Reverse Sorting Enabled")
				elseif tokens[2] == "off" or  tokens[2] == "false" then
					SoulSortOptions.SortReverse = false
					print("SoulSort: Reverse Sorting Disabled")
				else
					print("SoulSort: No option provided. Use \"/ss reverse [on/off]\"")
				end
			else
				print("SoulSort: No option provided. Use \"/ss reverse [on/off]\"")
			end		
		elseif strlower(tokens[1]) == "combatwarning" then
			if table.getn(tokens) > 1 then
				if tokens[2] == "on" or  tokens[2] == "true" then
					SoulSortOptions.ShowCombatWarning = true
					print("SoulSort: Combat Warning Enabled")
				elseif tokens[2] == "off" or  tokens[2] == "false" then
					SoulSortOptions.ShowCombatWarning = false
					print("SoulSort: Combat Warning Disabled")
				else
					print("SoulSort: No option provided. Use \"/ss combatwarning [on/off]\"")
				end
			else
				print("SoulSort: No option provided. Use \"/ss combatwarning [on/off]\"")
			end
		elseif strlower(tokens[1]) == "showinfo" then
			if table.getn(tokens) > 1 then
				if tokens[2] == "on" or  tokens[2] == "true" then
					SoulSortOptions.ShowSortInfo = true
					print("SoulSort: Showing Sort Info Enabled")
				elseif tokens[2] == "off" or  tokens[2] == "false" then
					SoulSortOptions.ShowSortInfo = false
					print("SoulSort: Showing Sort Info Disabled")
				else
					print("SoulSort: No option provided. Use \"/ss showinfo [on/off]\"")
				end
			else
				print("SoulSort: No option provided. Use \"/ss showinfo [on/off]\"")
			end
		elseif strlower(tokens[1]) == "options" or strlower(tokens[1]) == "settings" or strlower(tokens[1]) == "opt" then
			InterfaceOptionsFrame:Show()
			InterfaceOptionsFrame_OpenToCategory("SoulSort")
		end
	else
		print("SoulSort Functions:")
		print("    /ss options - Opens the Options menu.")
		print("    /ss max [number] - Set the max number of Soul Shards to keep.")
		if SS_IsClassicVersion() then
			print("    /ss autosort [on/off] - Toggle automatic sorting when you leave combat.")
		end
		print("    /ss automax [on/off] - Toggle automatic max Soul Shards. This will fill your Soul Bag(s) or your last bag.")
		print("    /ss counter [on/off] - Toggles the Soul Shard counter on your bag bar.")
		print("    /ss reverse [on/off] - Toggles sorting Soul Shards to fill the end of your bags first.")
		print("    /ss showinfo [on/off] - Toggles showing information about your Soul Shards in chat when sorting.")
		print("    /ss combatwarning [on/off] - Toggles showing a warning when you try to sort shards in combat.")
		print("    /ss sort - Sorts your Soul Shards to the back of your inventory.")
	end
end

local SoulShardItemID = 6265

local DeletedList = {}
local DeletedListCount = 0
local SwapList = {}
local SwapListCount = 0

local SoulShardCounterStrings = {}

function SS_IsClassicVersion()
	return select(4, GetBuildInfo()) < 20000
end

function SS_Tokenize(str)
	local tbl = {};
	for v in string.gmatch(str, "[^ ]+") do
		tinsert(tbl, v);
	end
	return tbl;
end

function SS_SortShards()
	SS_PrepareSort()

	if SoulSortOptions.AutoMax then
		SS_CalculateAutoSize()
	end

	local shardsDeleted = SS_DeleteExcessShards()

	if SoulSortOptions.SortReverse then
		SS_PreCalculateSort_Reverse()
	else
		SS_PreCalculateSort()
	end
	SS_ExecuteSort()
	SS_CleanUp()
	
	if SoulSortOptions.ShowSortInfo == true and shardsDeleted > 0 then
		print("SoulSort: " .. shardsDeleted .. " Soul Shards deleted.")
	end
end

function SS_PrepareSort()
	ClearCursor()

	SwapListCount=0
	for k in pairs(SwapList) do
	    SwapList[k] = nil
	end

	DeletedListCount=0
	for k in pairs(DeletedList) do
	    DeletedList[k] = nil
	end
end

function SS_CleanUp()
	ClearCursor()
end

function SS_PreCalculateSort()
	for sourceBag=0,4 do
		for sourceSlot=C_Container.GetContainerNumSlots(sourceBag),1,-1 do 
			if not SS_IsShardDeleted(sourceBag, sourceSlot) then
				if C_Container.GetContainerItemID(sourceBag, sourceSlot) == SoulShardItemID then
					local slotFound = false
					for destinationBag=4,0,-1 do 
						for destinationSlot=1,C_Container.GetContainerNumSlots(destinationBag) do
							if SS_IsSameSlot(sourceBag, sourceSlot, destinationBag, destinationSlot) then
								slotFound = true
								break
							elseif C_Container.GetContainerItemID(destinationBag, destinationSlot) ~= SoulShardItemID then
								if SS_SlotIsNotTaken(destinationBag, destinationSlot) then
									SS_AddToSwapList(sourceBag, sourceSlot, destinationBag, destinationSlot)
									slotFound = true
									break
								end
							end
						end
						if slotFound == true then
							break;
						end
					end
				end
			end
		end
	end
end

function SS_PreCalculateSort_Reverse()
	for sourceBag=0,4 do
		for sourceSlot=C_Container.GetContainerNumSlots(sourceBag),1,-1 do 
			if not SS_IsShardDeleted(sourceBag, sourceSlot) then
				if C_Container.GetContainerItemID(sourceBag, sourceSlot) == SoulShardItemID then
					local slotFound = false
					for destinationBag=4,0,-1 do 
						for destinationSlot=C_Container.GetContainerNumSlots(destinationBag),1,-1 do
							if SS_IsSameSlot(sourceBag, sourceSlot, destinationBag, destinationSlot) then
								slotFound = true
								break
							elseif C_Container.GetContainerItemID(destinationBag, destinationSlot) ~= SoulShardItemID then
								if SS_SlotIsNotTaken(destinationBag, destinationSlot) then
									SS_AddToSwapList(sourceBag, sourceSlot, destinationBag, destinationSlot)
									slotFound = true
									break
								end
							end
						end
						if slotFound == true then
							break;
						end
					end
				end
			end
		end
	end
end

function SS_ExecuteSort()
	for i=0,SwapListCount-1 do
		C_Container.PickupContainerItem(SwapList[i].sourceBag, SwapList[i].sourceSlot)
		C_Container.PickupContainerItem(SwapList[i].destinationBag, SwapList[i].destinationSlot)
		--print("Swapping:", SwapList[i].sourceBag, SwapList[i].sourceSlot, SwapList[i].destinationBag, SwapList[i].destinationSlot)
	end
end

function SS_AddToSwapList(aSourceBag, aSourceSlot, aDestinationBag, aDestinationSlot)
	SwapList[SwapListCount] = 
	{ 
		sourceBag = aSourceBag, 
		sourceSlot = aSourceSlot, 
		destinationBag = aDestinationBag, 
		destinationSlot = aDestinationSlot
	}
	SwapListCount = SwapListCount+1
	--print("Adding to SwapList:", aSourceBag, aSourceSlot, aDestinationBag, aDestinationSlot)
end

function SS_IsSameSlot(aSourceBag, aSourceSlot, aDestinationBag, aDestinationSlot)
	if aSourceBag == aDestinationBag and aSourceSlot == aDestinationSlot then
		return true
	else
		return false
	end
end

function SS_SlotIsNotTaken(aDestinationBag, aDestinationSlot)
	for i=0,SwapListCount do
		if SwapList[i] then
			if SwapList[i].destinationBag == aDestinationBag and SwapList[i].destinationSlot == aDestinationSlot then
				--print("SS_SlotIsNotTaken returning false:", aDestinationBag, aDestinationSlot)
				return false
			end
		end
	end
	return true
end

function SS_IsShardDeleted(bag, slot)
	for i=0,DeletedListCount-1 do
		if DeletedList[i].bag == bag and DeletedList[i].slot == slot then
			return true
		end
	end
	return false
end

function SS_DeleteExcessShards()
	if SoulSortOptions.MaxShards == 0 then return 0 end

	local deletedShards = 0
	local numShards = 0
	for bag=4,0,-1 do 
		for slot=C_Container.GetContainerNumSlots(bag),1,-1 do
			if C_Container.GetContainerItemID(bag, slot) == SoulShardItemID then
				if numShards >= SoulSortOptions.MaxShards then
					C_Container.PickupContainerItem(bag, slot)
					_, cursorItemID = GetCursorInfo()
					if cursorItemID == SoulShardItemID then
						DeleteCursorItem()
						DeletedList[DeletedListCount] = { bag=bag, slot=slot }
						DeletedListCount = DeletedListCount + 1
						deletedShards = deletedShards+1
					else
						ClearCursor()
					end
				else
					numShards = numShards+1
				end
			end
		end
	end
	return deletedShards
end

function SS_SetMaxShards(count)
	SoulSortOptions.MaxShards = count;
	SS_UpdateShardCount()
end

function SS_CalculateAutoSize()
	local count = 0
	hasSoulBag = false
	for bag=1,4 do
		bagName = C_Container.GetBagName(bag)
		if bagName and SS_IsSoulBag(bagName) then
			hasSoulBag = true
			count = count + C_Container.GetContainerNumSlots(bag)
		end
	end
	if not hasSoulBag then
		for bag=4,1,-1 do
			numSlots = C_Container.GetContainerNumSlots(bag)
			if numSlots > 0 then
				count = numSlots
				break
			end
		end
	end
	SS_SetMaxShards(count)
end

function SS_IsSoulBag(bagName)
	if bagName:find("Soul") or bagName:find("Felcloth") or bagName:find("D'Sak's") then
		return true
	else
		return false
	end
end

function SS_GetSoulShardsCount()	
	local numShardsTotal = 0
	for bag=0,4 do 
		for slot=1,C_Container.GetContainerNumSlots(bag) do
			if C_Container.GetContainerItemID(bag, slot) == SoulShardItemID then
				numShardsTotal = numShardsTotal+1
			end
		end
	end
	return numShardsTotal
end

function SS_UpdateShardCount()
	for i in pairs(SoulShardCounterStrings) do
		SoulShardCounterStrings[i]:SetText("")
	end
	if SoulSortOptions.ShowCounterPerBag then
		for bag=0,4 do 
			bagName = C_Container.GetBagName(bag)
			if bagName and not SS_IsSoulBag(bagName) then
				local numShards = 0
				for slot=1,C_Container.GetContainerNumSlots(bag) do
					if C_Container.GetContainerItemID(bag, slot) == SoulShardItemID then
						numShards = numShards+1
					end
				end
				if numShards > 0 then 
					SoulShardCounterStrings[bag]:SetText(numShards)
				end
			end
		end
	end

	local numShardsTotal = SS_GetSoulShardsCount()
	SoulShardCounterStrings[5]:SetText(numShardsTotal) 

	brsSoulSort.value = numShardsTotal
	local shardColor = "|cFF8787ED"
	local countColor = "|cFFFFFFFF"
	if numShardsTotal == 0 then
		countColor = "|cFFFF0000"
	end
	local maxStr = ""
	local maxColor = "|cFFFF0000"
	if SoulSortOptions.MaxShards ~= 0 and numShardsTotal >= SoulSortOptions.MaxShards then
		maxStr = " (Full)"
	end
	brsSoulSort.text = shardColor.."Shards: "..countColor..numShardsTotal..maxColor..maxStr
end

function SS_InitSoulShardCounter()
	SoulShardCounterStrings[0] = MainMenuBarBackpackButton:CreateFontString()
	font = NumberFontNormal:GetFont() 
	SoulShardCounterStrings[0]:SetFont(font, 14, "OUTLINE") 
	SoulShardCounterStrings[0]:SetPoint("RIGHT", MainMenuBarBackpackButton, "BOTTOMRIGHT",-2,8.5)

	SoulShardCounterStrings[1] = CharacterBag0Slot:CreateFontString()
	font = NumberFontNormal:GetFont() 
	SoulShardCounterStrings[1]:SetFont(font, 14, "OUTLINE") 
	SoulShardCounterStrings[1]:SetPoint("RIGHT", CharacterBag0Slot, "BOTTOMRIGHT",-2,8.5)

	SoulShardCounterStrings[2] = CharacterBag1Slot:CreateFontString()
	font = NumberFontNormal:GetFont() 
	SoulShardCounterStrings[2]:SetFont(font, 14, "OUTLINE") 
	SoulShardCounterStrings[2]:SetPoint("RIGHT", CharacterBag1Slot, "BOTTOMRIGHT",-2,8.5)

	SoulShardCounterStrings[3] = CharacterBag2Slot:CreateFontString()
	font = NumberFontNormal:GetFont() 
	SoulShardCounterStrings[3]:SetFont(font, 14, "OUTLINE") 
	SoulShardCounterStrings[3]:SetPoint("RIGHT", CharacterBag2Slot, "BOTTOMRIGHT",-2,8.5)

	SoulShardCounterStrings[4] = CharacterBag3Slot:CreateFontString()
	font = NumberFontNormal:GetFont() 
	SoulShardCounterStrings[4]:SetFont(font, 14, "OUTLINE") 
	SoulShardCounterStrings[4]:SetPoint("RIGHT", CharacterBag3Slot, "BOTTOMRIGHT",-2,8.5)
	
	SoulShardCounterStrings[5] = CharacterBag3Slot:CreateFontString()
	font = NumberFontNormal:GetFont() 
	SoulShardCounterStrings[5]:SetFont(font, 14, "OUTLINE") 
	SoulShardCounterStrings[5]:SetPoint("LEFT", CharacterBag3Slot, "TOPLEFT",2,-10)

	SS_UpdateCounterVisibilty()
end

function SS_UpdateCounterVisibilty()
	SS_UpdateShardCount()
	if SoulSortOptions.ShowCounterPerBag then
		for i in pairs(SoulShardCounterStrings) do
			SoulShardCounterStrings[i]:Show()
		end
	else
		for i in pairs(SoulShardCounterStrings) do
			SoulShardCounterStrings[i]:Hide()
		end
	end
	
	if SoulSortOptions.ShowCounter then
		SoulShardCounterStrings[5]:Show()
	else
		SoulShardCounterStrings[5]:Hide()
	end
end