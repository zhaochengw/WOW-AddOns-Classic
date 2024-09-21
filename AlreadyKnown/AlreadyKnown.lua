local ADDON_NAME = ...
local _G = _G
local knownTable = {
	-- ["|cffa335ee|Hitem:22450::::::::53:::::::::|h[Void Crystal]|h|r"] = true -- Debug (Void Crystal)
} -- Save known items for later use
local db
local questItems = { -- Quest items and matching quests
	-- WoD
		-- Equipment Blueprint: Tuskarr Fishing Net
			[128491] = 39359, -- Alliance
			[128251] = 39359, -- Horde
		-- Equipment Blueprint: Unsinkable
			[128250] = 39358, -- Alliance
			[128489] = 39358, -- Horde
	-- Shadowlands
		-- Soulshapes (Data by Dairyman @ Github)
			[181313] = 62420, -- Snapper Soul
			[181314] = 62421, -- Gulper Soul
			[182165] = 62422, -- Ardenmoth Soul
			[182166] = 62423, -- Ursine soul
			-- [182167] = 0, -- Cobra Sape
			[182168] = 62424, -- Crane Soul
			[182169] = 62425, -- Veilwing Soul
			[182170] = 62426, -- Gryphon Soul
			[182171] = 62427, -- Hippogryph Soul
			[182172] = 62428, -- Equine Soul
			-- [182173] = 0, -- Hyena Sape
			[182174] = 62429, -- Leonine Soul
			[182175] = 62430, -- Moose Soul
			[182176] = 62431, -- Shadowstalker Soul
			[182177] = 62432, -- Owlcat Soul
			[182178] = 62433, -- Raptor Soul
			[182179] = 62434, -- Runestag Soul
			[182180] = 62435, -- Stag Soul
			[182181] = 62437, -- Tiger soul
			[182182] = 62438, -- Lupine Soul
			[182183] = 62439, -- Wolfhawk Soul
			[182184] = 62440, -- Wyvern Soul
			[182185] = 62436, -- Shrieker Soul
}
local specialItems = { -- Items needing special treatment
	-- Krokul Flute -> Flight Master's Whistle
		[152964] = { 141605, 11, 269 } -- 269 for Flute applied Whistle, 257 (or anything else than 269) for pre-apply Whistle
}
local containerItems = { -- These items are containers containing items we might know already, but don't get any marking about us knowing the contents already
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
	},
	[128319] = { -- Void-Shrouded Satchel
		128318 -- Touch of the Void
	}
}
local spellbookItems = { -- Pair [ItemId] to matching [spellId]

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


local isRetail = (_G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE)
local isClassic = (_G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC)
local isBCClassic = (_G.WOW_PROJECT_ID == _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
local isWrathClassic = (_G.WOW_PROJECT_ID == _G.WOW_PROJECT_WRATH_CLASSIC)
local isCataClassic = (_G.WOW_PROJECT_ID == _G.WOW_PROJECT_CATACLYSM_CLASSIC)
local isAnyClassic = (isClassic or isBCClassic or isWrathClassic or isCataClassic)

local function Print(text, ...)
	if text then
		if text:match("%%[dfqs%d%.]") then
			print("|cffffcc00".. ADDON_NAME ..":|r " .. format(text, ...))
		else
			print("|cffffcc00".. ADDON_NAME ..":|r " .. strjoin(" ", text, tostringall(...)))
		end
	end
end

local function _debugTooltipData(tooltipData, header) -- Debug C_TooltipInfo stuff
	local function _tooltipTableDebugIterator(debugTable, depth)
		local orderTable, iterationString = {}, ""
		depth = depth or 1

		for k, v in pairs(debugTable) do
			orderTable[#orderTable + 1] = k
		end
		table.sort(orderTable)

		for i = 1, #orderTable do
			local k, v = orderTable[i], debugTable[orderTable[i]]
			if type(v) == "table" then
				local tableName = type(k) == "string" and k or "[" .. k .. "]"
				if tableName ~= "args" and ((not db.exclude) or (db.exclude and tableName ~= "lines")) then
					iterationString = iterationString .. string.rep(" ", 4 * depth) .. tableName .. " = {\n" .. _tooltipTableDebugIterator(v, depth + 1) .. string.rep(" ", 4 * depth) .. "},\n"
				end
			elseif type(v) ~= "function" then
				iterationString = iterationString .. string.rep(" ", 4 * depth) .. k .. " = " .. tostring(v) .. ",\n"
			end
		end

		return iterationString
	end

	local debugOutput = "-----\n"
	if header and header ~= "" then
		debugOutput = debugOutput .. header .. "\n-----\n"
	end

	debugOutput = debugOutput .. "tooltipData = {\n" .. _tooltipTableDebugIterator(tooltipData) .. "}\n"
	debugOutput = debugOutput .. "-----"

	return debugOutput
end

-- Tooltip and scanning by Phanx @ http://www.wowinterface.com/forums/showthread.php?p=271406
-- Search string by Phanx @ https://github.com/Phanx/BetterBattlePetTooltip/blob/master/Addon.lua
local S_PET_KNOWN = strmatch(_G.ITEM_PET_KNOWN, "[^%(]+")

-- Construct your search patterns based on the existing global strings:
local S_ITEM_MIN_LEVEL = "^" .. gsub(_G.ITEM_MIN_LEVEL, "%%d", "(%%d+)")
local S_ITEM_CLASSES_ALLOWED = "^" .. gsub(_G.ITEM_CLASSES_ALLOWED, "%%s", "(%%a+)")

local scantip
if not C_TooltipInfo then
	scantip = CreateFrame("GameTooltip", "AKScanningTooltip", nil, "GameTooltipTemplate")
	scantip:SetOwner(UIParent, "ANCHOR_NONE")
end

local function _checkTooltipLine(text, i, tooltipTable, itemId, itemLink)
	local lines = (isRetail) and #tooltipTable or tooltipTable
	local toyLine = (isRetail) and (tooltipTable[i + 2] and tooltipTable[i + 2].leftText) or (_G["AKScanningTooltipTextLeft"..i + 2] and _G["AKScanningTooltipTextLeft"..i + 2]:GetText())

	if text == _G.ITEM_SPELL_KNOWN or strmatch(text, S_PET_KNOWN) then
		-- Known item or Pet
		if db.debug then Print("%d - Tip %d/%d: %s (%s / %s)", itemId, i, lines, tostring(text), text == _G.ITEM_SPELL_KNOWN and "true" or "false", strmatch(text, S_PET_KNOWN) and "true" or "false") end
		--knownTable[itemLink] = true -- Mark as known for later use
		--return true -- Item is known and collected

		if isAnyClassic then -- Fix for (BC)Classic, hope this covers all the cases.
			knownTable[itemLink] = true -- Mark as known for later use
			return true -- Item is known and collected
		elseif lines - i <= 3 then -- Mounts have Riding skill and Reputation requirements under Already Known -line
			knownTable[itemLink] = true -- Mark as known for later use
			return true -- Item is known and collected
		end

	elseif text == _G.TOY and toyLine == _G.ITEM_SPELL_KNOWN then
		-- Check if items is Toy already known
		if db.debug then Print("%d - Toy %d", itemId, i) end
		knownTable[itemLink] = true
		return true -- Item is known and collected

	elseif text == _G.ITEM_COSMETIC then
		-- Check if Cosmetic item has already known look (not all of them apparently get the "Already Known"-text added to the tooltip)
		-- 1 function calls way, don't know if this is the right way, but seems to work according to my limited testing
		local knownTransmog = C_TransmogCollection.PlayerHasTransmogByItemInfo(itemLink)
		--[[
		-- 2 function calls way, should work 100% of the time
		local appearanceId, sourceId = C_TransmogCollection.GetItemInfo(itemLink)
		local knownTransmog = C_TransmogCollection.GetSourceInfo(sourceId)
		]]
		if knownTransmog then
			if db.debug then Print("%d - Cosmetic %d", itemId, i) end
			knownTable[itemLink] = true
			return true -- Item is known and collected
		end

	-- Debug
	--[[
	elseif strmatch(text, "Priest") then -- Retail PTR
		knownTable[itemLink] = true
		return true
	elseif strmatch(text, "alcoholic beverage") then -- Wratch Classic PTR
		Print("PTR Debug match:", text)
		knownTable[itemLink] = true
		return true
	]]
	end

	return false
end

local function _checkIfKnown(itemLink)
	if knownTable[itemLink] then -- Check if we have scanned this item already and it was known then
		return true
	end

	local itemId, _, _, _, itemIcon, classId, subclassId = GetItemInfoInstant(itemLink)
	itemId = itemId or tonumber(itemLink:match("item:(%d+)"))
	--if itemId == 82800 then Print("itemLink:", gsub(itemLink, "\124", "\124\124")) end
	-- How to handle Pet Cages inside GBanks? They look like this and don't have any information about the pet inside:
	-- |cff0070dd|Hitem:82800::::::::120:269::::::|h[Pet Cage]|h|r
	if itemId then
		if questItems[itemId] then -- Check if item is a quest item.
			if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted(questItems[itemId]) then -- Check if the quest for item is already done.
				if db.debug then Print("%d - QuestItem", itemId) end
				knownTable[itemLink] = true -- Mark as known for later use
				return true -- This quest item is already known
			end
			return false -- Quest item is uncollected... or something went wrong
		elseif specialItems[itemId] then -- Check if we need special handling, this is most likely going to break with then next item we add to this
			local specialData = specialItems[itemId]
			local _, specialLink = GetItemInfo(specialData[1])
			if specialLink then
				local specialTbl = { strsplit(":", specialLink) }
				local specialInfo = tonumber(specialTbl[specialData[2]])
				if specialInfo == specialData[3] then
					if db.debug then Print("%d, %d - SpecialItem", itemId, specialInfo) end
					knownTable[itemLink] = true -- Mark as known for later use
					return true -- This specialItem is already known
				end
			end
			return false -- Item is specialItem, but data isn't special
		elseif containerItems[itemId] then -- Check the known contents of the item
			local knownCount, totalCount = 0, 0
			for cI = 1, #containerItems[itemId] do
				totalCount = totalCount + 1
				local thisItem = _checkIfKnown(format("item:%d", containerItems[itemId][cI])) -- Checkception
				if thisItem then
					knownCount = knownCount + 1
				end
			end
			if db.debug then Print("%d (%d/%d) - ContainerItem", itemId, knownCount, totalCount) end
			return (knownCount == totalCount)
		elseif isAnyClassic and spellbookItems[itemId] then -- Check Warlock Grimoires
			local numSpells, petToken = HasPetSpells()
			if numSpells and petToken == "DEMON" then
				for i = 1, numSpells do
					local spellName, spellSubName, spellId = GetSpellBookItemName(i, BOOKTYPE_PET)
					if spellbookItems[itemId] == spellId then
						if db.debug then Print("%d (%s/%s/%d) - SpellBookItem", itemId, spellName, spellSubName, spellId) end
						knownTable[itemLink] = true -- Mark as known for later use
						return true -- This spellbookItem item is already known
					end
				end
			end

		end
	end

	if C_PetJournal and itemLink:match("|H(.-):") == "battlepet" then -- Check if item is Caged Battlepet (dummy item 82800)
		local _, battlepetId = strsplit(":", itemLink)
		if C_PetJournal.GetNumCollectedInfo(battlepetId) > 0 then
			if db.debug then Print("%d - BattlePet: %s %d", itemId, battlepetId, C_PetJournal.GetNumCollectedInfo(battlepetId)) end
			knownTable[itemLink] = true -- Mark as known for later use
			return true -- Battlepet is collected
		end
		return false -- Battlepet is uncollected... or something went wrong
	end

	if isAnyClassic then -- Wrath Classic doesn't show "Already Known" text for Companion Pets in Vendors etc.
		if classId == Enum.ItemClass.Miscellaneous and subclassId == Enum.ItemMiscellaneousSubclass.CompanionPet then
			local numCompanions = GetNumCompanions("CRITTER")
			for i = 1, numCompanions do
				local creatureId, creatureName, creatureSpellId, icon, issummoned, mountType = GetCompanionInfo("CRITTER", i)
				if db.debug then Print("C: (%d/%d) Id: %d -> %s - CId: %d (%s), SId: %d (%s), TId: %d (%s)", i, numCompanions, itemId, creatureName, creatureId, tostring(itemId == creatureId), creatureSpellId, tostring(itemId == creatureSpellId), icon, tostring(itemIcon == icon)) end
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
				return (itemIcon == icon and strmatch((GetItemInfo(itemId)), creatureName))
			end
		end
	end

	local midResult = false
	if C_TooltipInfo then -- Retail in 10.0.2->, maybe comes to Wrath Classic later?
		local tooltipData = C_TooltipInfo.GetHyperlink(itemLink)

		for i, line in ipairs(tooltipData.lines) do
			if line.leftText then
				midResult = _checkTooltipLine(line.leftText, i, tooltipData.lines, itemId, itemLink)
				if (midResult == true) then
					return true
				end
			end
		end

	else
		scantip:ClearLines()
		scantip:SetHyperlink(itemLink)

		--for i = 2, scantip:NumLines() do -- Line 1 is always the name so you can skip it.
		local lines = scantip:NumLines()
		for i = 2, lines do -- Line 1 is always the name so you can skip it.
			local text = _G["AKScanningTooltipTextLeft"..i]:GetText()

			midResult = _checkTooltipLine(text, i, lines, itemId, itemLink)
			if (midResult == true) then
				return true
			end
		end

	end

	--return false -- Item is not known, uncollected... or something went wrong
	return knownTable[itemLink] and true or false
end

local function _hookNewAH(self) -- Most of this found from FrameXML/Blizzard_AuctionHouseUI/Blizzard_AuctionHouseItemList.lua
	if isAnyClassic then return end -- Only for Retail 8.3 and newer

	-- Derived from https://www.townlong-yak.com/framexml/10.0.0/Blizzard_AuctionHouseUI/Blizzard_AuctionHouseItemList.lua#322
	--self.ScrollBox:ForEachFrame(function(button)
	local children = { self.ScrollTarget:GetChildren() }
	for i = 1, #children do
		local button = children[i]
		--Print(">", button.rowData.itemKey.itemID, button.cells[2].Text:GetText())
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
	if not isAnyClassic then return end -- Retail 8.3 changed the AH, this old one is still used for (BC)Classic

	-- https://www.townlong-yak.com/framexml/8.2.5/Blizzard_AuctionUI/Blizzard_AuctionUI.lua#763
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)

	for i=1, _G.NUM_BROWSE_TO_DISPLAY do
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
			local itemLink = GetAuctionItemLink('list', offset + i)

			--Print(">", itemLink, _G["BrowseButton"..i.."Name"]:GetText())
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

local function _hookMerchant() -- Most of this found from FrameXML/MerchantFrame.lua
	-- https://www.townlong-yak.com/framexml/9.0.2/MerchantFrame.lua#197
	for i = 1, _G.MERCHANT_ITEMS_PER_PAGE do
		local index = (((MerchantFrame.page - 1) * _G.MERCHANT_ITEMS_PER_PAGE) + i)
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

local AK_SLOTS_PER_TAB = _G.MAX_GUILDBANK_SLOTS_PER_TAB or 98 -- These ain't Globals anymore in the new Mixin version so fallback for hardcoded version
local AK_SLOTS_PER_GROUP = _G.NUM_SLOTS_PER_GUILDBANK_GROUP or 14
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
		local button
		if GuildBankFrameMixin then
			button = GuildBankFrame.Columns[column].Buttons[index] -- New Mixin-version
		else
			button = _G["GuildBankColumn" .. column .. "Button" .. index] -- Old Classic/Pre-9.1.5 -version
		end
		--local texture = GetGuildBankItemInfo(tab, i)
		local itemLink = GetGuildBankItemLink(tab, i)

		--if texture and texture == 132599 then -- Inv_box_petcarrier_01 (BattlePet, itemId 82800)
		if itemLink and itemLink:match("item:82800") then -- Check if item is Caged Battlepet (dummy item 82800)
			-- Combining the Hook New AH -way and suggestion made by Dairyman @ Github to improve the detection of caged battlepets in GBank
			local speciesId
			if C_TooltipInfo then
				local tooltipData = C_TooltipInfo.GetGuildBankItem(tab, i)

				if tooltipData and tooltipData.battlePetSpeciesID then
					speciesId = tooltipData.battlePetSpeciesID
				end
			else
				scantip:ClearLines()
				speciesId = scantip:SetGuildBankItem(tab, i)
			end

			if speciesId and speciesId > 0 then
				itemLink = format("|Hbattlepet:%d::::::|h[Dummy]|h", speciesId)
			end
		end

		if itemLink and _checkIfKnown(itemLink) then
			SetItemButtonTextureVertexColor(button, 0.9*db.r, 0.9*db.g, 0.9*db.b)
			if GuildBankFrameMixin then -- Mixin version doesn't have names for the buttons and SetItemButtonNormalTextureVertexColor requires buttons to have names to work
				button:GetNormalTexture():SetVertexColor(0.9*db.r, 0.9*db.g, 0.9*db.b)
			else
				SetItemButtonNormalTextureVertexColor(button, 0.9*db.r, 0.9*db.g, 0.9*db.b)
			end

			SetItemButtonDesaturated(button, db.monochrome)
		else
			SetItemButtonTextureVertexColor(button, 1, 1, 1)
			if GuildBankFrameMixin then
				button:GetNormalTexture():SetVertexColor(1, 1, 1)
			else
				SetItemButtonNormalTextureVertexColor(button, 1, 1, 1)
			end

			SetItemButtonDesaturated(button, false)
		end
	end
end

local alreadyHookedAddOns = {
	[ADDON_NAME] = false,
	["Blizzard_AuctionUI"] = false, -- => 8.2.5
	["Blizzard_AuctionHouseUI"] = false, -- 8.3 =>
	["Blizzard_GuildBankUI"] = false -- 2.3 =>
}
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" and alreadyHookedAddOns[(...)] == false then
		local addOnName = ...
		if addOnName == "Blizzard_AuctionHouseUI" then -- New AH
			--hooksecurefunc(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBox, "OnViewDataChanged", function(...) Print(">OnViewDataChanged") end)
			hooksecurefunc(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBox, "Update", _hookNewAH)
			--hooksecurefunc(AuctionHouseFrame.BrowseResultsFrame.ItemList, "UpdateRefreshFrame", function(...) DevTools_Dump({ ... }) end)
			alreadyHookedAddOns["Blizzard_AuctionHouseUI"] = true

		elseif addOnName == "Blizzard_AuctionUI" then -- Old AH
			if IsAddOnLoaded("Auc-Advanced") and _G.AucAdvanced.Settings.GetSetting("util.compactui.activated") then
				hooksecurefunc("GetNumAuctionItems", _hookAH)
			else
				hooksecurefunc("AuctionFrameBrowse_Update", _hookAH)
			end
			alreadyHookedAddOns["Blizzard_AuctionUI"] = true

		elseif addOnName == "Blizzard_GuildBankUI" then -- GBank
			if GuildBankFrameMixin then -- New Mixin-version for BCClassic/9.1.5 =>
				hooksecurefunc(GuildBankFrame, "Update", _hookGBank) -- GuildBankFrameMixin:Update()
			else -- Classic/Pre-9.1.5 version not using the Mixin
				hooksecurefunc("GuildBankFrame_Update", _hookGBank) -- Old pre-9.1.5 -version
			end
			alreadyHookedAddOns["Blizzard_GuildBankUI"] = true

		elseif addOnName == ADDON_NAME then -- Self
			if type(AlreadyKnownSettings) ~= "table" then
				AlreadyKnownSettings = { r = 0, g = 1, b = 0, monochrome = false }
			end
			db = AlreadyKnownSettings

			if isAnyClassic then -- These weren't/aren't in the Classic
				alreadyHookedAddOns["Blizzard_AuctionHouseUI"] = nil
				if isClassic then -- GuildBank should be in BCClassic (at least in the end of TBC it was)
					alreadyHookedAddOns["Blizzard_GuildBankUI"] = nil
				end
			else -- These aren't in the Retail anymore
				alreadyHookedAddOns["Blizzard_AuctionUI"] = nil
			end

			hooksecurefunc("MerchantFrame_UpdateMerchantInfo", _hookMerchant)

		end
		alreadyHookedAddOns[addOnName] = true -- Mark addOnName as hooked

		local everythingHooked = true
		for _, hooked in pairs(alreadyHookedAddOns) do -- Check if everything is hooked already
			if not hooked then -- Something isn't hooked yet, keep on listening
				everythingHooked = false 
				break
			end
		end
		if everythingHooked then -- No need to listen to the event anymore
			if db.debug then Print("UnregisterEvent", event) end
			self:UnregisterEvent(event)
		end
		if db.debug then Print("ADDON_LOADED:", alreadyHookedAddOns[ADDON_NAME], alreadyHookedAddOns["Blizzard_AuctionHouseUI"], alreadyHookedAddOns["Blizzard_AuctionUI"], alreadyHookedAddOns["Blizzard_GuildBankUI"]) end

	end
end)

local function _RGBToHex(r, g, b)
	r = r <= 255 and r >= 0 and r or 0
	g = g <= 255 and g >= 0 and g or 0
	b = b <= 255 and b >= 0 and b or 0
	return format("%02x%02x%02x", r, g, b)
end

local function _changedCallback(restore)
	local R, G, B
	if restore then -- The user bailed, we extract the old color from the table created by ShowColorPicker.
		R, G, B = unpack(restore)
	else -- Something changed
		R, G, B = ColorPickerFrame:GetColorRGB()
	end

	db.r, db.g, db.b = R, G, B
	Print("|cff%scustom|r, Monochrome: %s", _RGBToHex(db.r*255, db.g*255, db.b*255), (db.monochrome and "|cff00ff00true|r" or "|cffff0000false|r"))
end

local function _ShowColorPicker(r, g, b, a, changedCallback)
	ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = false, 1
	ColorPickerFrame.previousValues = { r, g, b }
	ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = changedCallback, changedCallback, changedCallback
	ColorPickerFrame:SetColorRGB(r, g, b)
	ColorPickerFrame:Hide() -- Need to run the OnShow handler.
	ColorPickerFrame:Show()
end

SLASH_ALREADYKNOWN1 = "/alreadyknown"
SLASH_ALREADYKNOWN2 = "/ak"
StaticPopupDialogs["ALREADYKNOWN_DEBUG"] = {
	text = "If possible, please kindly disable all tooltip altering addons when copying this information to your bug report.\n\nCheck you have tested the correct item and then copy&paste the debug text from the editbox below, even if the editbox looks empty:\n\n(Use |cffffcc00Ctrl+A|r to select text, |cffffcc00Ctrl+C|r to copy text)\n\nItemTest: %s",
	button1 = OKAY,
	showAlert = true,
	hasEditBox = true,
	editBoxWidth = 260, --350,
	OnShow = function (self, data)
		self.editBox:SetText("Something went wrong!") -- This will be overwritten if everything goes as expected
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

SlashCmdList.ALREADYKNOWN = function(...)
	if (...) == "green" then
		db.r = 0; db.g = 1; db.b = 0
	elseif (...) == "blue" then
		db.r = 0; db.g = 0; db.b = 1
	elseif (...) == "yellow" then
		db.r = 1; db.g = 1; db.b = 0
	elseif (...) == "cyan" then
		db.r = 0; db.g = 1; db.b = 1
	elseif (...) == "purple" then
		db.r = 1; db.g = 0; db.b = 1
	elseif (...) == "gray" then
		db.r = 0.5; db.g = 0.5; db.b = 0.5
	elseif (...) == "custom" then
		_ShowColorPicker(db.r, db.g, db.b, false, _changedCallback)
	elseif (...) == "monochrome" then
		db.monochrome = not db.monochrome
		Print("Monochrome: %s", (db.monochrome and "|cff00ff00true|r" or "|cffff0000false|r"))
	elseif (...) == "debug" then
		db.debug = not db.debug
		if db.debug then wipe(knownTable) end
		Print("Debug: %s", (db.debug and "|cff00ff00true|r" or "|cffff0000false|r"))
	elseif (...) == "exclude" then
		db.exclude = not db.exclude
		Print("Exclude: %s", (db.exclude and "|cff00ff00true|r" or "|cffff0000false|r"))
	elseif (...) == "itemtest" then -- For getting debug data from people in the future
		local _, itemLink = _G.GameTooltip:GetItem()
		local regionTable = {}
		local regions = { _G.GameTooltip:GetRegions() }

		-- https://warcraft.wiki.gg/wiki/ItemType
		local _, _, _, _, _, _, _, _, _, _, _, classId, subclassId = C_Item.GetItemInfo(itemLink)
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
			if db.debug then
				local tooltipData = C_TooltipInfo.GetHyperlink(itemLink)
				line = line .. "\n" .. _debugTooltipData(tooltipData)
			end
			--Print(line)
			local dialog = StaticPopup_Show("ALREADYKNOWN_DEBUG", tostring(itemLink)) -- Send to dialog for easy copy&paste for end user
 			if dialog then
     			dialog.data = line
     		end
		else
			Print("!!! GameTooltip is empty?")
		end
	else
		Print("/alreadyknown ( green | blue | yellow | cyan | purple | gray | custom | monochrome )")
	end

	if (...) ~= "" and (...) ~= "custom" and (...) ~= "monochrome" and (...) ~= "debug" and (...) ~= "itemtest" and (...) ~= "exclude" then
		Print("|cff%s%s|r, Monochrome: %s", _RGBToHex(db.r*255, db.g*255, db.b*255), (...), (db.monochrome and "|cff00ff00true|r" or "|cffff0000false|r"))
		if db.debug then Print("Debug: |cff00ff00true|r, Exclude: |cff00ff00%s|r", (db.exclude and "|cff00ff00true|r" or "|cffff0000false|r")) end
	end

	if ColorPickerFrame:IsShown() and (...) ~= "custom" then
		_ShowColorPicker(db.r, db.g, db.b, false, _changedCallback)
	end
end