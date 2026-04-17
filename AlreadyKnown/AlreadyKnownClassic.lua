--[[----------------------------------------------------------------------------
	AlreadyKnown
----------------------------------------------------------------------------]]--
local ADDON_NAME = ...
local _G = _G


--[[----------------------------------------------------------------------------
	Init and Helper functions
----------------------------------------------------------------------------]]--
	local function initDB(db, defaults) -- This function copies values from one table into another:
		if type(db) ~= "table" then db = {} end
		if type(defaults) ~= "table" then return db end
		for k, v in pairs(defaults) do
			if type(v) == "table" then
				db[k] = initDB(db[k], v)
			elseif type(v) ~= type(db[k]) then
				db[k] = v
			end
		end
		return db
	end

	local dbDefaults = {
		r = 0,
		g = 1,
		b = 0,
		monochrome = false,
		debug = false
	}
	AlreadyKnownSettings = initDB(AlreadyKnownSettings, dbDefaults)
	local db = AlreadyKnownSettings


	local function Debug(text, ...)
		if (not db) or (not db.debug) then return end

		if text then
			if text:match("%%[dfqsx%d%.]") then
				(DEBUG_CHAT_FRAME or (ChatFrame3:IsShown() and ChatFrame3 or ChatFrame4)):AddMessage("|cffff9999"..ADDON_NAME..":|r " .. format(text, ...))
			else
				(DEBUG_CHAT_FRAME or (ChatFrame3:IsShown() and ChatFrame3 or ChatFrame4)):AddMessage("|cffff9999"..ADDON_NAME..":|r " .. strjoin(" ", text, tostringall(...)))
			end
		end
	end

	local function Print(text, ...)
		if text then
			if text:match("%%[dfqs%d%.]") then
				print("|cffffcc00".. ADDON_NAME ..":|r " .. format(text, ...))
			else
				print("|cffffcc00".. ADDON_NAME ..":|r " .. strjoin(" ", text, tostringall(...)))
			end
		end
	end


	--[[
	local isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
	local isWrathClassic = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
	local isCataClassic = WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC
	local isMoPClassic = WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC
	]]
	local isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
	local isBCClassic = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
	local isPTR = IsPublicTestClient and IsPublicTestClient() or false


--[[----------------------------------------------------------------------------
	ItemData
----------------------------------------------------------------------------]]--
	local knownTable = { -- Use itemtest to get the itemLinks
		--["|cffa335ee|Hitem:22450::::::::53:::::::::|h[Void Crystal]|h|r"] = true -- Debug (Void Crystal)
		--["|cffffffff|Hitem:4540::::::::7::::::::::|h[Tough Hunk of Bread]|h|r"] = true -- Debug (Tough Hunk of Bread)
	} -- Save known items for later use


	local questItems = { -- Quest [itemIds] and their matching [questsIds]
	}


	local specialItems = { -- Special [itemIds] that need hard coded handling for detecting upgrade items etc.
	}


	local containerItems = { -- These [itemIds] are containers containing [itemIds] we might know already, but don't get any marking about us knowing the contents already
		-- Vanilla
			[21740] = { -- Small Rocket Recipes
				21724, -- Schematic: Small Blue Rocket
				21725, -- Schematic: Small Green Rocket
				21726 -- Schematic: Small Red Rocket
			},
			[21741] = { -- Cluster Rocket Recipes
				21730, -- Schematic: Blue Rocket Cluster
				21731, -- Schematic: Green Rocket Cluster
				21732 -- Schematic: Red Rocket Cluster
			},
			[21742] = { -- Large Rocket Recipes
				21727, -- Schematic: Large Blue Rocket
				21728, -- Schematic: Large Green Rocket
				21729 -- Schematic: Large Red Rocket
			},
			[21743] = { -- Large Cluster Rocket Recipes
				21733, -- Schematic: Large Blue Rocket Cluster
				21734, -- Schematic: Large Green Rocket Cluster
				21735 -- Schematic: Large Red Rocket Cluster
			}
	}


	local spellbookItems = { -- Pair [ItemId] to matching [spellId] to detect Spell Books etc.
		-- Vanilla + TBC
			-- Warlock
				-- Imp
					-- Firebolt 1-7
						-- nil = 3110,
						[16302] = 7799,
						[16316] = 7800,
						[16317] = 7801,
						[16318] = 7802,
						[16319] = 11762,
						[16320] = 1176,
					-- Blood Pact 1-5
						[16321] = 6307,
						[16322] = 7804,
						[16323] = 7805,
						[16324] = 11766,
						[16325] = 1176,
					-- Fire Shield 1-5
						[16326] = 2947,
						[16327] = 8316,
						[16328] = 8317,
						[16329] = 11700,
						[16330] = 11701,
					-- Phase Shift
						[16331] = 4511,
				-- Voidwalker
					-- Torment 1-6
						--nil = 3716,
						[16346] = 7809,
						[16347] = 7810,
						[16348] = 7811,
						[16349] = 11774,
						[16350] = 11775,
					-- Sacrifice 1-6
						[16351] = 7812,
						[16352] = 19438,
						[16353] = 19440,
						[16354] = 19441,
						[16355] = 19442,
						[16356] = 1944,
					-- Consume Shadows 1-6
						[16357] = 17767,
						[16358] = 17850,
						[16359] = 17851,
						[16360] = 17852,
						[16361] = 17853,
						[16362] = 17854,
					-- Suffering 1-4
						[16363] = 17735,
						[16364] = 17750,
						[16365] = 17751,
						[16366] = 17752,
				-- Succubus
					-- Lash of Pain 1-6
						--nil = 7814,
						[16368] = 7815,
						[16371] = 7816,
						[16372] = 11778,
						[16373] = 11779,
						[16374] = 11780,
					-- Soothing Kiss 1-4
						[16375] = 6360,
						[16376] = 7813,
						[16377] = 11784,
						[16378] = 11785,
					-- Seduction
						[16379] = 6358,
					-- Lesser Invisibility
						[16380] = 7870,
				-- Felhunter
					-- Devour Magic 1-4
						--nil = 19505,
						[16381] = 19731,
						[16382] = 19734,
						[16383] = 19736,
					-- Tainted Blood 1-4
						[16384] = 19478,
						[16385] = 19655,
						[16386] = 19656,
						[16387] = 19660,
					-- Spell Lock 1-2
						[16388] = 19244,
						[16389] = 19647,
					-- Paranoia
						[16390] = 19480

	}


--[[----------------------------------------------------------------------------
	Scanning
----------------------------------------------------------------------------]]--
	-- Tooltip and scanning by Phanx @ http://www.wowinterface.com/forums/showthread.php?p=271406
	-- Search string by Phanx @ https://github.com/Phanx/BetterBattlePetTooltip/blob/master/Addon.lua
	local S_PET_KNOWN = strmatch(ITEM_PET_KNOWN, "[^%(]+")

	-- Construct your search patterns based on the existing global strings:
	local S_ITEM_MIN_LEVEL = "^" .. gsub(ITEM_MIN_LEVEL, "%%d", "(%%d+)")
	local S_ITEM_CLASSES_ALLOWED = "^" .. gsub(ITEM_CLASSES_ALLOWED, "%%s", "(%%a+)")
	-- Removed on Feb 23, 2023

	local scantip = CreateFrame("GameTooltip", "AKScanningTooltip", nil, "GameTooltipTemplate")
	scantip:SetOwner(UIParent, "ANCHOR_NONE")

	local function _checkTooltipLine(text, i, tooltipTable, itemId, itemLink)
		local lines = tooltipTable
		local toyLine = _G["AKScanningTooltipTextLeft"..i + 2] and _G["AKScanningTooltipTextLeft"..i + 2]:GetText()

		if text == ITEM_SPELL_KNOWN or strmatch(text, S_PET_KNOWN) then -- Known item or Pet
			Debug("%d - Tip %d/%d: %s (%s / %s)", itemId, i, lines, tostring(text), text == ITEM_SPELL_KNOWN and "true" or "false", strmatch(text, S_PET_KNOWN) and "true" or "false")

			knownTable[itemLink] = true -- Mark as known for later use
			return true -- Item is known and collected

		elseif text == TOY and toyLine == ITEM_SPELL_KNOWN then -- Check if items is Toy already known
			Debug("%d - Toy %d", itemId, i)
			return true -- Item is known and collected

		elseif text == ITEM_COSMETIC then -- Check if Cosmetic item has already known look (not all of them apparently get the "Already Known"-text added to the tooltip)
			local knownTransmog = C_TransmogCollection.PlayerHasTransmogByItemInfo(itemLink)
			if knownTransmog then
				Debug("%d - Cosmetic %d", itemId, i)
				return true -- Item is known and collected
			end

		-- Debug
		elseif isPTR then
			if strmatch(text, "Priest") then
				Debug("PTR Debug match:", text)
				return true
			elseif strmatch(text, "alcoholic beverage") then
				Debug("PTR Debug match:", text)
				return true
			end
		end

		return false
	end

	local function _checkIfKnown(itemLink)
		if knownTable[itemLink] then -- Check if we have scanned this item already and it was known then
			return true
		end

		local itemId, _, _, _, itemIcon, classId, subclassId = C_Item.GetItemInfoInstant(itemLink)
		itemId = itemId or tonumber(itemLink:match("item:(%d+)"))

		if itemId then
			if questItems[itemId] then -- Check if item is a quest item.
				if C_QuestLog.IsQuestFlaggedCompleted(questItems[itemId]) then -- Check if the quest for item is already done.
					Debug("%d - QuestItem", itemId)
					knownTable[itemLink] = true -- Mark as known for later use
					return true -- This quest item is already known
				end
				return false -- Quest item is uncollected... or something went wrong

			elseif specialItems[itemId] then -- Check if we need special handling, this is most likely going to break with then next item we add to this
				local specialData = specialItems[itemId]
				local _, specialLink = C_Item.GetItemInfo(specialData[1])
				if specialLink then
					local specialTbl = { strsplit(":", specialLink) }
					local specialInfo = tonumber(specialTbl[specialData[2]])
					if specialInfo == specialData[3] then
						Debug("%d, %d - SpecialItem", itemId, specialInfo)
						knownTable[itemLink] = true -- Mark as known for later use
						return true -- This specialItem is already known
					end
				end
				return false -- Item is specialItem, but data isn't special

			elseif containerItems[itemId] then -- Check the known contents of the item
				local knownItemCount, totalItemCount = 0, 0
				for itemIterator = 1, #containerItems[itemId] do
					totalItemCount = totalItemCount + 1
					local thisItem = _checkIfKnown(format("item:%d", containerItems[itemId][itemIterator])) -- Checkception
					if thisItem then
						knownItemCount = knownItemCount + 1
					end
				end
				Debug("%d (%d/%d) - ContainerItem", itemId, knownItemCount, totalItemCount)
				if knownItemCount == totalItemCount then
					knownTable[itemLink] = true -- Mark as known for later use
					return true -- This container item is already known
				end

			elseif (isClassic or isBCClassic) and spellbookItems[itemId] then -- Check Warlock Grimoires
				local numSpells, petToken = HasPetSpells()
				if numSpells and petToken == "DEMON" then
					for i = 1, numSpells do
						local spellName, spellSubName, spellId = GetSpellBookItemName(i, BOOKTYPE_PET)
						if spellbookItems[itemId] == spellId then
							Debug("%d (%s/%s/%d) - SpellBookItem", itemId, spellName, spellSubName, spellId)
							knownTable[itemLink] = true -- Mark as known for later use
							return true -- This spellbookItem item is already known
						end
					end
				end

			end
		end

		if C_PetJournal then
			if itemLink:match("|H(.-):") == "battlepet" then -- Check if item is Caged Battlepet (dummy item 82800)
				local _, battlepetId = strsplit(":", itemLink)
				battlepetId = tonumber(battlepetId)
				if battlepetId and C_PetJournal.GetNumCollectedInfo(battlepetId) > 0 then
					Debug("%d - BattlePet: %s %d", itemId, battlepetId, C_PetJournal.GetNumCollectedInfo(battlepetId))
					knownTable[itemLink] = true -- Mark as known for later use
					return true -- Battlepet is collected
				end
				return false -- Battlepet is uncollected... or something went wrong

			elseif classId == Enum.ItemClass.Miscellaneous and subclassId == Enum.ItemMiscellaneousSubclass.CompanionPet then -- CompanionPet
				local itemName = C_Item.GetItemInfo(itemId)
				if itemName then
					-- Hoping this works in the TBC Classic Anniversary and fixes the CF issues #23 and #24
					local _, numOwned = C_PetJournal.GetNumPets()
					for i = 1, numOwned do
						local _, _, owned, _, _, _, _, speciesName, icon, _, companionID = C_PetJournal.GetPetInfoByIndex(i)
						if owned and (itemIcon == icon and strmatch(itemName, speciesName)) then
							Debug("%d - CompanionPet: (%d/%d) %s - CId: %d TId: %d", itemId, i, numOwned, speciesName, companionID, icon)
							knownTable[itemLink] = true -- Mark as known for later use
							return true -- CompanionPet is collected
						end
					end
					return false -- CompanionPet is uncollected... or something went wrong
				end
			end

		elseif classId == Enum.ItemClass.Miscellaneous and subclassId == Enum.ItemMiscellaneousSubclass.CompanionPet then
			-- CurseForge issues #23 & #24 reported by gogo1951, this doesn't work in the TBC Classic Anniversary
			local numCompanions = GetNumCompanions("CRITTER")
			local itemName = C_Item.GetItemInfo(itemId)
			if itemName then
				for i = 1, numCompanions do
					local creatureId, creatureName, creatureSpellId, icon, issummoned, mountType = GetCompanionInfo("CRITTER", i)
					Debug("C: (%d/%d) Id: %d -> %s - CId: %d (%s), SId: %d (%s), TId: %d (%s)", i, numCompanions, itemId, creatureName, creatureId, tostring(itemId == creatureId), creatureSpellId, tostring(itemId == creatureSpellId), icon, tostring(itemIcon == icon))
					--[[
						Pet's name and the item's name might not match
							[Yellow Moth Egg] vs [Yellow Moth]
						Same icon can be used for multiple different pets and items
							[Blue Moth Egg], [White Moth Egg], [Yellow Moth Egg] and [Yellow Moth] all use textureId 236193
						Pet's creatureId doesn't have link to itemId or itemLink
							[Yellow Moth Egg] itemId 29903 vs [Yellow Moth] creatureId 21008
						Pet's creatureSpellId doesn't have anything useful from GetSpellInfo
							[Yellow Moth] creatureSpellId 35910
					]]--
					--Bandaid solution that is less than ideal:
					--DevTools_Dump({ strmatch((GetItemInfo(itemId)), creatureName) })
					--return (itemIcon == icon and strmatch((C_Item.GetItemInfo(itemId)), creatureName))
					if (itemIcon == icon and strmatch(itemName, creatureName)) then
						knownTable[itemLink] = true -- Mark as known for later use
						return true -- CompanionPet is collected
					end
				end
			end
		end

		if C_MountJournal and classId == Enum.ItemClass.Miscellaneous and subclassId == Enum.ItemMiscellaneousSubclass.Mount then -- Mount
			local numMounts = C_MountJournal.GetNumMounts()
			local itemName = C_Item.GetItemInfo(itemId)
			if itemName then
				for i = 1, numMounts do
					local creatureName, _, icon, _, _, _, _, _, _, _, isCollected, mountID = C_MountJournal.GetDisplayedMountInfo(i)
					if isCollected and (itemIcon == icon and strmatch(itemName, creatureName)) then
						Debug("%d Mount: (%d/%d) %s - MId: %d TId: %d", itemId, i, numMounts, creatureName, mountID, icon)
						knownTable[itemLink] = true -- Mark as known for later use
						return true -- Mount is collected
					end
				end
			end
		end

		scantip:ClearLines()
		scantip:SetHyperlink(itemLink)

		--for i = 2, scantip:NumLines() do -- Line 1 is always the name so you can skip it.
		local lines = scantip:NumLines()
		for i = 2, lines do -- Line 1 is always the name so you can skip it.
			local text = _G["AKScanningTooltipTextLeft"..i]:GetText()

			local lineResult = _checkTooltipLine(text, i, lines, itemId, itemLink)
			if lineResult == true then
				knownTable[itemLink] = true -- Mark as known for later use
				return true
			end
		end

		return false -- Item is not known, uncollected... or something went wrong
	end


--[[----------------------------------------------------------------------------
	AuctionHouse
----------------------------------------------------------------------------]]--
	local function _hookNewAH(self) -- Most of this found from FrameXML/Blizzard_AuctionHouseUI/Blizzard_AuctionHouseItemList.lua
		-- self = AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBox

		-- Derived from https://www.townlong-yak.com/framexml/10.0.0/Blizzard_AuctionHouseUI/Blizzard_AuctionHouseItemList.lua#322
		--self.ScrollBox:ForEachFrame(function(button)
		local children = { self.ScrollTarget:GetChildren() }
		for i = 1, #children do
			local button = children[i]
			--Debug(">", button.rowData.itemKey.itemID, button.cells[2].Text:GetText())
			if button and button.rowData and button.rowData.itemKey.itemID then
				local itemLink
				if button.rowData.itemKey.itemID == 82800 then -- BattlePet
					itemLink = format("|Hbattlepet:%d::::::|h[Dummy]|h", button.rowData.itemKey.battlePetSpeciesID)
				else -- Normal item
					itemLink = format("item:%d", button.rowData.itemKey.itemID)
				end

				if itemLink and _checkIfKnown(itemLink) then
					-- Highlight
					button.SelectedHighlight:Show()
					button.SelectedHighlight:SetVertexColor(db.r, db.g, db.b)
					button.SelectedHighlight:SetAlpha(.2)
					-- Icon
					button.cells[2].Icon:SetVertexColor(db.r, db.g, db.b)
					button.cells[2].IconBorder:SetVertexColor(db.r, db.g, db.b)
					button.cells[2].Icon:SetDesaturated((db.monochrome))
				else
					-- Highlight
					button.SelectedHighlight:SetVertexColor(1, 1, 1)
					-- Icon
					button.cells[2].Icon:SetVertexColor(1, 1, 1)
					button.cells[2].IconBorder:SetVertexColor(1, 1, 1)
					button.cells[2].Icon:SetDesaturated(false)
				end
			end
		--end)
		end
	end


	local function _hookAH() -- Most of this found from FrameXML/Blizzard_AuctionUI/Blizzard_AuctionUI.lua
		-- https://www.townlong-yak.com/framexml/8.2.5/Blizzard_AuctionUI/Blizzard_AuctionUI.lua#763
		local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)

		for i=1, NUM_BROWSE_TO_DISPLAY do
			--[[
			if _G["BrowseButton"..i].id then -- Something to do with ARL?
				local itemLink = GetAuctionItemLink('list', _G["BrowseButton"..i].id)

				if itemLink and _checkIfKnown(itemLink) then
					_G["BrowseButton"..i].Icon:SetVertexColor(db.r, db.g, db.b)
					_G["BrowseButton"..i].Icon:SetDesaturated((db.monochrome))
				else
					_G["BrowseButton"..i].Icon:SetVertexColor(1, 1, 1)
					_G["BrowseButton"..i].Icon:SetDesaturated(false)
				end
			elseif _G["BrowseButton"..i.."Item"] and _G["BrowseButton"..i.."ItemIconTexture"] then
			]]
			if _G["BrowseButton"..i.."Item"] and _G["BrowseButton"..i.."ItemIconTexture"] then
				local itemLink = GetAuctionItemLink('list', offset + i)

				--Debug(">", itemLink, _G["BrowseButton"..i.."Name"]:GetText())
				if itemLink and _checkIfKnown(itemLink) then
					_G["BrowseButton"..i.."ItemIconTexture"]:SetVertexColor(db.r, db.g, db.b)
					_G["BrowseButton"..i.."ItemIconTexture"]:SetDesaturated((db.monochrome))
				else
					_G["BrowseButton"..i.."ItemIconTexture"]:SetVertexColor(1, 1, 1)
					_G["BrowseButton"..i.."ItemIconTexture"]:SetDesaturated(false)
				end
			end
		end
	end


--[[----------------------------------------------------------------------------
	GuildBank
----------------------------------------------------------------------------]]--
	local AK_SLOTS_PER_TAB = MAX_GUILDBANK_SLOTS_PER_TAB or 98 -- These ain't Globals anymore in the new Mixin version so fallback for hardcoded version
	local AK_SLOTS_PER_GROUP = NUM_SLOTS_PER_GUILDBANK_GROUP or 14
	local function _hookGBank() -- FrameXML/Blizzard_GuildBankUI/Blizzard_GuildBankUI.lua
		-- https://www.townlong-yak.com/framexml/9.0.2/Blizzard_GuildBankUI/Blizzard_GuildBankUI.lua#203 -- Old version (Classic and pre-9.1.5)
		-- https://www.townlong-yak.com/framexml/9.1.5/Blizzard_GuildBankUI/Blizzard_GuildBankUI.lua#135 -- New Mixin-version (BCClassic and 9.1.5 ->)
		local tab = GetCurrentGuildBankTab()
		for i = 1, AK_SLOTS_PER_TAB do
			local index = mod(i, AK_SLOTS_PER_GROUP)
			if (index == 0) then
				index = AK_SLOTS_PER_GROUP
			end
			local column = math.ceil((i - .5) / AK_SLOTS_PER_GROUP)
			local button = GuildBankFrame.Columns[column].Buttons[index] -- New Mixin-version
			local itemLink = GetGuildBankItemLink(tab, i)

			if itemLink and itemLink:match("item:82800") then -- Check if item is Caged Battlepet (dummy item 82800)
				-- Combining the Hook New AH -way and suggestion made by Dairyman @ Github to improve the detection of caged battlepets in GBank
				scantip:ClearLines()
				local speciesId = scantip:SetGuildBankItem(tab, i)

				if speciesId and speciesId > 0 then
					itemLink = format("|Hbattlepet:%d::::::|h[Dummy]|h", speciesId)
				end
			end

			if itemLink and _checkIfKnown(itemLink) then
				SetItemButtonTextureVertexColor(button, 0.9*db.r, 0.9*db.g, 0.9*db.b)
				button:GetNormalTexture():SetVertexColor(0.9*db.r, 0.9*db.g, 0.9*db.b)
				SetItemButtonDesaturated(button, db.monochrome)
			else
				SetItemButtonTextureVertexColor(button, 1, 1, 1)
				button:GetNormalTexture():SetVertexColor(1, 1, 1)
				SetItemButtonDesaturated(button, false)
			end
		end
	end


--[[----------------------------------------------------------------------------
	Merchant
----------------------------------------------------------------------------]]--
	local function _hookMerchant() -- Most of this found from FrameXML/MerchantFrame.lua
		-- https://www.townlong-yak.com/framexml/9.0.2/MerchantFrame.lua#197
		for i = 1, MERCHANT_ITEMS_PER_PAGE do
			local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i)
			local itemButton = _G["MerchantItem"..i.."ItemButton"]
			local merchantButton = _G["MerchantItem"..i]
			local itemLink = GetMerchantItemLink(index)

			if itemLink and _checkIfKnown(itemLink) then
				SetItemButtonNameFrameVertexColor(merchantButton, db.r, db.g, db.b)
				SetItemButtonSlotVertexColor(merchantButton, db.r, db.g, db.b)
				SetItemButtonTextureVertexColor(itemButton, 0.9*db.r, 0.9*db.g, 0.9*db.b)
				SetItemButtonNormalTextureVertexColor(itemButton, 0.9*db.r, 0.9*db.g, 0.9*db.b)

				_G["MerchantItem"..i.."ItemButtonIconTexture"]:SetDesaturated((db.monochrome))
			else
				_G["MerchantItem"..i.."ItemButtonIconTexture"]:SetDesaturated(false)
			end
		end
	end
	hooksecurefunc("MerchantFrame_UpdateMerchantInfo", _hookMerchant)


--[[----------------------------------------------------------------------------
	Events
----------------------------------------------------------------------------]]--
	local f = CreateFrame("Frame")
	f:SetScript("OnEvent", function(self, event, ...)
		return self[event] and self[event](self, event, ...)
	end)
	f:RegisterEvent("ADDON_LOADED")

	local needHooking = {
		Blizzard_AuctionUI = true, -- => 8.2.5
		Blizzard_AuctionHouseUI = true, -- 8.3 =>
		Blizzard_GuildBankUI = true -- 2.3 =>
	}
	function f:ADDON_LOADED(event, addOnName, containsBindings)
		if not needHooking[addOnName] then return end
		Debug("===", event, addOnName)

		if addOnName == "Blizzard_AuctionHouseUI" then -- AH - Classic/Retail
			hooksecurefunc(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBox, "Update", _hookNewAH)
			needHooking["Blizzard_AuctionHouseUI"] = false
			needHooking["Blizzard_AuctionUI"] = false

		elseif addOnName == "Blizzard_AuctionUI" then -- AH - Classic Era
			--if C_AddOns.IsAddOnLoaded("Auc-Advanced") and AucAdvanced.Settings.GetSetting("util.compactui.activated") then
			--	hooksecurefunc("GetNumAuctionItems", _hookAH)
			--else
				hooksecurefunc("AuctionFrameBrowse_Update", _hookAH)
			--end
			needHooking["Blizzard_AuctionUI"] = false
			needHooking["Blizzard_AuctionHouseUI"] = false
			if isClassic then -- No GBank in Classic Era
				needHooking["Blizzard_GuildBankUI"] = false
			end

		elseif addOnName == "Blizzard_GuildBankUI" then -- GBank
			hooksecurefunc(GuildBankFrame, "Update", _hookGBank)
			needHooking["Blizzard_GuildBankUI"] = false

		end

		Debug("-> Hooks:", tostring(not needHooking["Blizzard_AuctionHouseUI"]), tostring(not needHooking["Blizzard_AuctionUI"]), tostring(not needHooking["Blizzard_GuildBankUI"]))

		if not (needHooking["Blizzard_AuctionHouseUI"] or needHooking["Blizzard_AuctionUI"] or needHooking["Blizzard_GuildBankUI"]) then -- No need to listen to the event anymore
			Debug("<- UnregisterEvent", event)
			self:UnregisterEvent(event)
		end
	end


--[[----------------------------------------------------------------------------
	SlashHandler
----------------------------------------------------------------------------]]--
	StaticPopupDialogs["ALREADYKNOWN_DEBUG"] = {
		text = "Check you have tested the correct item and then copy&paste the debug text from the editbox below, even if the editbox looks empty:\n\n(Use " .. NORMAL_FONT_COLOR:WrapTextInColorCode("Ctrl+A") .. " to select text, " .. NORMAL_FONT_COLOR:WrapTextInColorCode("Ctrl+C") .. " to copy text)\n\nItemTest: %s",
		button1 = OKAY,
		showAlert = true,
		hasEditBox = true,
		editBoxWidth = 260, --350,
		OnShow = function (self, data)
			self:GetEditBox():SetText("Something went wrong!") -- This will be overwritten if everything goes as expected
		end,
		EditBoxOnTextChanged = function (self, data) -- careful! 'self' here points to the editbox, not the dialog
			if self:GetText() ~= data then
				self:SetText(data)
			end
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true
	}

	local function _tooltipTest()
		local _, itemLink = GameTooltip:GetItem()
		if itemLink then
			local regionTable = {}
			local regions = { GameTooltip:GetRegions() }

			-- https://warcraft.wiki.gg/wiki/ItemType
			local itemName, _, _, _, _, _, _, _, _, itemTexture, _, classId, subclassId = C_Item.GetItemInfo(itemLink)
			local itemClass, itemSubclass
			for k, v in pairs(Enum.ItemClass) do
				if v == classId then
					itemClass = k
					break
				end
			end
			if itemClass and Enum["Item" .. itemClass .. "Subclass"] then
				for k, v in pairs(Enum["Item" .. itemClass .. "Subclass"]) do
					if v == subclassId then
						itemSubclass = k
						break
					end
				end
			end

			for i = 1, #regions do
				local region = regions[i]
				if region then
					local regionType = region:GetObjectType()
					if regionType == "FontString" then
						local text = region:GetText()
						if text and #strtrim(text) > 0 then -- Skip lines with just spaces
							regionTable[#regionTable + 1] = format("%d %s %s %s", i, regionType, tostring(region:GetName()), text)
						end
					elseif regionType == "Texture" then
						local texture = region:GetTexture()
						local atlas = region:GetAtlas()
						if (texture or atlas) and region:IsShown() then -- Check if the texture/atlas is set to be shown, because textures are not cleared from tooltip when changing items, just overwritten when needed.
							regionTable[#regionTable + 1] = format(atlas and "%d %s %s %s / %s" or "%d %s %s %s", i, regionType, tostring(region:GetName()), texture, atlas)
						end
					else
						regionTable[#regionTable + 1] = format("%d !%s! %s", i, regionType, tostring(region:GetName()))
					end
				end
			end

			if #regionTable > 0 then -- We have (some) data!
				local line = format(
					"ItemTest: %s %s / %s\nItem: %s (%d %s/%d %s) - Regions: %d/%d - Known: %s\nItemLink: %s",
					ADDON_NAME, C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version"), (GetBuildInfo()),
					tostring(itemLink), classId, tostring(itemClass), subclassId, tostring(itemSubclass), #regionTable, #regions, tostring(_checkIfKnown(itemLink)),
					tostring(itemLink):gsub("|", "||")
				)
				for j = 1, #regionTable do
					line = line .. "\n" .. regionTable[j]
				end

				-- Check these item types for additional info
				if C_PetJournal and classId == Enum.ItemClass.Miscellaneous and subclassId == Enum.ItemMiscellaneousSubclass.CompanionPet then
					line = line .. "\n-----\nCompanionPet:"
					local numPets, numOwned = C_PetJournal.GetNumPets()
					for index = 1, numOwned do
						local petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable = C_PetJournal.GetPetInfoByIndex(index)
						if owned and (itemTexture == icon and strmatch(itemName, speciesName)) then
							line = line .. "\n- Index: " .. index .. " / " .. numOwned .. "\n- Name: " .. speciesName .. "\n- companionID: " .. companionID .. "\n- Icon: " .. icon
							break
						end
					end

				elseif C_MountJournal and classId == Enum.ItemClass.Miscellaneous and subclassId == Enum.ItemMiscellaneousSubclass.Mount then
					line = line .. "\n-----\nMount:"
					local numMounts = C_MountJournal.GetNumMounts()
					for index = 1, numMounts do
						local creatureName, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isSteadyFlight = C_MountJournal.GetDisplayedMountInfo(index)
						if isCollected and (itemTexture == icon and strmatch(itemName, creatureName)) then
							line = line .. "\n- Index: " .. index .. " / " .. numMounts .. "\n- Name: " .. creatureName .. "\n- mountID: " .. mountID .. "\n- Icon: " .. icon
							break
						end
					end
				end

				--Print(line)
				local dialog = StaticPopup_Show("ALREADYKNOWN_DEBUG", tostring(itemLink)) -- Send to dialog for easy copy&paste for end user
					if dialog then
		 			dialog.data = line
		 		end
			else
				Print("%s GameTooltip is empty?", RED_FONT_COLOR:WrapTextInColorCode("!!!"))
			end
		else
			Print("%s No item under mouse?", RED_FONT_COLOR:WrapTextInColorCode("!!!"))
		end
	end


	local function _RGBToHex(r, g, b)
		r = r <= 255 and r >= 0 and r or 0
		g = g <= 255 and g >= 0 and g or 0
		b = b <= 255 and b >= 0 and b or 0
		return "ff" .. format("%02x%02x%02x", r, g, b)
	end

	local function _changedCallback()
		local R, G, B = ColorPickerFrame:GetColorRGB()
		local oR, oG, oB = ColorPickerFrame:GetPreviousValues()

		db.r, db.g, db.b = R, G, B
		RunNextFrame(function() -- In my testing on Retail PTR ColorPickerFrame is hidden only after this callback has ended
			if not ColorPickerFrame:IsShown() then -- Show this only after ColorPickerFrame is closed
				Print("%s, Monochrome: %s", WrapTextInColorCode("custom", _RGBToHex(db.r*255, db.g*255, db.b*255)), (db.monochrome and GREEN_FONT_COLOR:WrapTextInColorCode("true") or RED_FONT_COLOR:WrapTextInColorCode("false")))
			end
		end)
	end

	local function _cancelCallback()
		local R, G, B = ColorPickerFrame:GetPreviousValues()

		db.r, db.g, db.b = R, G, B
		Print("Canceled, %s restored.", WrapTextInColorCode("old color", _RGBToHex(db.r*255, db.g*255, db.b*255)))
	end

	local function _noopCallback()
	end

	local function _ShowColorPicker(r, g, b, a, ...)
		local options = {
			swatchFunc = _changedCallback,
			opacityFunc = _noopCallback,
			cancelFunc = _cancelCallback,
			hasOpacity = false,
			opacity = 1,
			r = r,
			g = g,
			b = b
		}
		ColorPickerFrame:SetupColorPickerAndShow(options)
	end


	SLASH_ALREADYKNOWN1 = "/alreadyknown"
	SLASH_ALREADYKNOWN2 = "/ak"
	local SlashHandlers = {
		["green"] = function()
			db.r = 0; db.g = 1; db.b = 0
			return 1
		end,
		["blue"] = function()
			db.r = 0; db.g = 0; db.b = 1
			return 1
		end,
		["yellow"] = function()
			db.r = 1; db.g = 1; db.b = 0
			return 1
		end,
		["cyan"] = function()
			db.r = 0; db.g = 1; db.b = 1
			return 1
		end,
		["purple"] = function()
			db.r = 1; db.g = 0; db.b = 1
			return 1
		end,
		["gray"] = function()
			db.r = 0.5; db.g = 0.5; db.b = 0.5
			return 1
		end,
		["custom"] = function()
			_ShowColorPicker(db.r, db.g, db.b, false, _changedCallback)
			return 3
		end,
		["monochrome"] = function()
			db.monochrome = not db.monochrome
			return 2
		end,
		["debug"] = function()
			db.debug = not db.debug
			if db.debug then wipe(knownTable) end
			return 2
		end,
		["itemtest"] = function()
			_tooltipTest()
			return 3
		end,
		["future"] = function()
			--DevTools_Dump(C_TooltipInfo)
			--DevTools_Dump(C_AddOns.IsAddOnLoaded("Blizzard_AuctionHouseUI"))
			--DevTools_Dump(C_AddOns.IsAddOnLoaded("Blizzard_AuctionUI"))
			--DevTools_Dump((GetBuildInfo()))
			Print("%s -> %s, %s, %s", (GetBuildInfo()), type(C_TooltipInfo), tostring(C_AddOns.IsAddOnLoaded("Blizzard_AuctionHouseUI")), tostring(C_AddOns.IsAddOnLoaded("Blizzard_AuctionUI")))
			return 3
		end
	}

	SlashCmdList.ALREADYKNOWN = function(text)
		local command, params = strsplit(" ", text, 2)

		if SlashHandlers[command] then
			local output = SlashHandlers[command](params)

			if output == 1 then
				Print("%s, Monochrome: %s",
					WrapTextInColorCode(command, _RGBToHex(db.r*255, db.g*255, db.b*255)),
					(db.monochrome and GREEN_FONT_COLOR:WrapTextInColorCode("true") or RED_FONT_COLOR:WrapTextInColorCode("false"))
				)
				Debug("Debug: %s", GREEN_FONT_COLOR:WrapTextInColorCode("true"))
			elseif output == 2 then
				Print("%s: %s", (command:lower():gsub("^%l", string.upper)), (db[command:lower()] and GREEN_FONT_COLOR:WrapTextInColorCode("true") or RED_FONT_COLOR:WrapTextInColorCode("false")))
			end
		else
			Print("/alreadyknown ( green | blue | yellow | cyan | purple | gray | custom | monochrome )")
		end
	end


------------------------------------------------------------------------- EOF --