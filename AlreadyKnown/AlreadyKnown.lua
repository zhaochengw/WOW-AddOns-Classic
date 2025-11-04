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
		debug = false,
		exclude = false -- Exclude extra debug info about non-text elements from Tooltip-test
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
	local isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
	local isBCClassic = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
	local isWrathClassic = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
	local isCataClassic = WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC
	local isMoPClassic = WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC
	]]
	local isPTR = IsPublicTestClient and IsPublicTestClient() or false


--[[----------------------------------------------------------------------------
	ItemData
----------------------------------------------------------------------------]]--
	local knownTable = { -- Use itemtest to get the itemLinks
		--["|cffa335ee|Hitem:22450::::::::53:::::::::|h[Void Crystal]|h|r"] = true -- Debug (Void Crystal)
	} -- Save known items for later use


	local questItems = { -- Quest [itemIds] and their matching [questsIds]
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


	local specialItems = { -- Special [itemIds] that need hard coded handling for detecting upgrade items etc.
		-- Legion
			-- Krokul Flute -> Flight Master's Whistle
				[152964] = { 141605, 11, 269 } -- 269 for Flute applied Whistle, 257 (or anything else than 269) for pre-apply Whistle
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
			},
		-- WoD
			[128319] = { -- Void-Shrouded Satchel
				128318 -- Touch of the Void
			}
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

	local function _checkTooltipLine(text, i, tooltipTable, itemId, itemLink)
		local lines = #tooltipTable
		local toyLine = tooltipTable[i + 2] and tooltipTable[i + 2].leftText

		if text == ITEM_SPELL_KNOWN or strmatch(text, S_PET_KNOWN) then -- Known item or Pet
			Debug("%d - Tip %d/%d: %s (%s / %s)", itemId, i, lines, tostring(text), text == ITEM_SPELL_KNOWN and "true" or "false", strmatch(text, S_PET_KNOWN) and "true" or "false")

			if lines - i <= 3 then -- Mounts have Riding skill and Reputation requirements under Already Known -line
				return true -- Item is known and collected
			end

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
			end
		end

		if C_PetJournal and itemLink:match("|H(.-):") == "battlepet" then -- Check if item is Caged Battlepet (dummy item 82800)
			local _, battlepetId = strsplit(":", itemLink)
			if C_PetJournal.GetNumCollectedInfo(battlepetId) > 0 then
				Debug("%d - BattlePet: %s %d", itemId, battlepetId, C_PetJournal.GetNumCollectedInfo(battlepetId))
				knownTable[itemLink] = true -- Mark as known for later use
				return true -- Battlepet is collected
			end
			return false -- Battlepet is uncollected... or something went wrong
		end

		local tooltipData = C_TooltipInfo.GetHyperlink(itemLink)

		for i, line in ipairs(tooltipData.lines) do
			if line.leftText then
				local lineResult = _checkTooltipLine(line.leftText, i, tooltipData.lines, itemId, itemLink)
				if lineResult == true then
					knownTable[itemLink] = true -- Mark as known for later use
					return true
				end
			end
		end

		return false -- Item is not known, uncollected... or something went wrong
	end


--[[----------------------------------------------------------------------------
	AuctionHouse
----------------------------------------------------------------------------]]--
	local function _hookAH(self) -- Most of this found from FrameXML/Blizzard_AuctionHouseUI/Blizzard_AuctionHouseItemList.lua
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
				local tooltipData = C_TooltipInfo.GetGuildBankItem(tab, i)

				if tooltipData and tooltipData.battlePetSpeciesID then
					local speciesId = tooltipData.battlePetSpeciesID

					if speciesId and speciesId > 0 then
						itemLink = format("|Hbattlepet:%d::::::|h[Dummy]|h", speciesId)
					end
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
		Blizzard_AuctionHouseUI = true, -- 8.3 =>
		Blizzard_GuildBankUI = true -- 2.3 =>
	}
	function f:ADDON_LOADED(event, addOnName, containsBindings)
		if not needHooking[addOnName] then return end
		Debug("===", event, addOnName)

		if addOnName == "Blizzard_AuctionHouseUI" then -- AH - Classic/Retail
			hooksecurefunc(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBox, "Update", _hookAH)
			needHooking["Blizzard_AuctionHouseUI"] = false

		elseif addOnName == "Blizzard_GuildBankUI" then -- GBank
			hooksecurefunc(GuildBankFrame, "Update", _hookGBank)
			needHooking["Blizzard_GuildBankUI"] = false

		end

		Debug("-> Hooks:", tostring(not needHooking["Blizzard_AuctionHouseUI"]), tostring(not needHooking["Blizzard_GuildBankUI"]))

		if not (needHooking["Blizzard_AuctionHouseUI"] or needHooking["Blizzard_GuildBankUI"]) then -- No need to listen to the event anymore
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
						iterationString = iterationString .. string.rep("\t", depth) .. tableName .. " = {\n" .. _tooltipTableDebugIterator(v, depth + 1) .. string.rep("\t", depth) .. "},\n"
					end
				elseif type(v) ~= "function" then
					iterationString = iterationString .. string.rep("\t", depth) .. k .. " = " .. tostring(v) .. ",\n"
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

	local function _tooltipTest()
		local _, itemLink = GameTooltip:GetItem()
		if itemLink then
			local regionTable = {}
			local regions = { GameTooltip:GetRegions() }

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
		["exclude"] = function()
			db.exclude = not db.exclude
			return 2
		end,
		["itemtest"] = function()
			_tooltipTest()
			return 3
		end,
		["future"] = function()
			Print("The future is now old man!")
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
				Debug("Debug: %s, Exclude: %s",
					GREEN_FONT_COLOR:WrapTextInColorCode("true"),
					(db.exclude and GREEN_FONT_COLOR:WrapTextInColorCode("true") or RED_FONT_COLOR:WrapTextInColorCode("false"))
				)
			elseif output == 2 then
				Print("%s: %s", (command:lower():gsub("^%l", string.upper)), (db[command:lower()] and GREEN_FONT_COLOR:WrapTextInColorCode("true") or RED_FONT_COLOR:WrapTextInColorCode("false")))
			end
		else
			Print("/alreadyknown ( green | blue | yellow | cyan | purple | gray | custom | monochrome )")
		end
	end


------------------------------------------------------------------------- EOF --