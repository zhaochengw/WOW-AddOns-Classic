local addonName, addon = ...
do
	local _G = _G;
	if addon.__fenv == nil then
		addon.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, addon.__fenv);
end

if UnitClassBase("player") ~= "MAGE" then
	print("MageButtons disabled, you are not a mage :(")
	return 0
end

local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")

------------------
--- Main frame ---
------------------
local MageButtonsConfig = CreateFrame("Frame", nil, UIParent)
MageButtonsConfig:SetMovable(false)
MageButtonsConfig:EnableMouse(false)
MageButtonsConfig:RegisterForDrag("LeftButton")
MageButtonsConfig:SetScript("OnDragStart", MageButtonsConfig.StartMoving)
MageButtonsConfig:SetScript("OnDragStop", function() MageButtonsConfig:StopMovingOrSizing(); addon:savePos(); end)
MageButtonsConfig:SetPoint("CENTER", UIParent, "CENTER", 200, 0)
MageButtonsConfig:SetSize(40, 10)
-- SetPoint is done after ADDON_LOADED

MageButtonsConfig.texture = MageButtonsConfig:CreateTexture(nil, "BACKGROUND")
MageButtonsConfig.texture:SetAllPoints(MageButtonsConfig)
MageButtonsConfig:SetBackdrop({bgFile = [[Interface\ChatFrame\ChatFrameBackground]]})
MageButtonsConfig:SetBackdropColor(0, 0, 0, 0)
addon.config_frame = MageButtonsConfig;

local buttonTypes = { "Water", "Food", "Teleports", "Portals", "Gems", "Polymorph", "_RITUAL", };
local spell_id_table = {  };
local spell_name_table = {  };
local spell_name_to_id = {  };
--	spell_table
	spell_id_table["Water"] = { 5504, 5505, 5506, 6127, 10138, 10139, 10140, 37420, 27090, };
	spell_id_table["Food"] = { 587, 597, 990, 6129, 10144, 10145, 28612, 33717, };
	if UnitFactionGroup("player") == "Alliance" then
		spell_id_table["Teleports"] = { 3565, 3561, 3562, 35715, 32271, 49359, 35715, 33690, };
		spell_id_table["Portals"] = { 11419, 10059, 11416, 35717, 32266, 49360, 35717, 33691, };
	else
		spell_id_table["Teleports"] = { 3566, 3563, 3567, 35715, 32272, 49358, 35715, 33690, };
		spell_id_table["Portals"] = { 11420, 11418, 11417, 35717, 32267, 49361, 35717, 33691, };
	end
	spell_id_table["Gems"] = { 759, 3552, 10053, 10054, 27101, };
	spell_id_table["Polymorph"] = { 118, 28272, 28271, 28270, };
	spell_id_table["_RITUAL"] = { 43987, };
--
local delayed = 0.0;
function addon.cache_name()
	local completed = true;
	for k = 1, #buttonTypes, 1 do
		local btnType = buttonTypes[k]
		if btnType ~= nil and btnType ~= "none" then
			local nameTable = spell_name_table[btnType];
			if nameTable == nil then
				nameTable = {  };
				spell_name_table[btnType] = nameTable;
			end
			local idTable = spell_id_table[btnType];
			for i = 1, #idTable, 1 do
				local id = idTable[i];
				if IsSpellKnown(id) then
					local name = GetSpellInfo(id);
					local subt = GetSpellSubtext(id);
					if name and subt then
						name = name .. "(" .. subt .. ")";
						if spell_name_to_id[name] == nil then
							tinsert(nameTable, name);
							spell_name_to_id[name] = id;
						end
					else
						completed = false;
					end
				end
			end
		end
	end
	if completed or delayed >= 2.0 then
		C_Timer.After(max(0.2, 1.0 - delayed), function() addon.OnEvent(_, "CACHE_NAME_COMPLETED"); end);
	else
		C_Timer.After(0.2, addon.cache_name);
		delayed = delayed + 0.2;
	end
end

function addon.OnEvent(self, event)
	-- Stuff to do after addon is loaded
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if MageButtonsDB == nil or MageButtonsDB.version == nil then
			_G.MageButtonsDB = {}
			MageButtonsDB["position"] = {}
			MageButtonsDB["water"] = {}
			MageButtonsDB["food"] = {}
			MageButtonsDB["teleport"] = {}
			MageButtonsDB["portal"] = {}
			MageButtonsDB["managem"] = {}
			MageButtonsDB["ai"] = {}
			MageButtonsDB["buttons"] = {}
			MageButtonsDB["minimap"] = {}
			MageButtonsDB.version = 20051
		end
		local b = MageButtonsDB["buttons"];
		if b ~= nil then
			if b.a then b["1"] = b.a; b.a = nil; end
			if b.b then b["2"] = b.b; b.b = nil; end
			if b.c then b["3"] = b.c; b.c = nil; end
			if b.d then b["4"] = b.d; b.d = nil; end
			if b.e then b["5"] = b.e; b.e = nil; end
			if b.f then b["6"] = b.f; b.f = nil; end
		end

		if IsSpellKnown(12826) then
			spell_id_table["Polymorph"][1] = 12826;
		elseif IsSpellKnown(12825) then
			spell_id_table["Polymorph"][1] = 12825;
		elseif IsSpellKnown(12824) then
			spell_id_table["Polymorph"][1] = 12824;
		elseif IsSpellKnown(118) then
			spell_id_table["Polymorph"][1] = 118;
		else
			spell_id_table["Polymorph"][1] = 9999;
		end
		C_Timer.After(1.0, addon.cache_name);
	elseif event == "CACHE_NAME_COMPLETED" then
		-- Get saved frame location
		local relPoint, anchorX, anchorY = addon:getAnchorPosition()
		MageButtonsConfig:ClearAllPoints()
		MageButtonsConfig:SetPoint(relPoint, UIParent, relPoint, anchorX, anchorY)

		addon:makeBaseButtons()

		-----------------
		-- Data Broker --
		-----------------
		local lockStatus = addon:getSV("framelock", "lock")

		MageButtonsMinimapData = LibDataBroker:NewDataObject("MageButtons",{
			type = "data source",
			text = "MageButtons",
			icon = "Interface/Icons/Spell_Holy_MagicalSentry.blp",
			OnClick = function(self, button)
				if button == "RightButton" then
					if IsShiftKeyDown() then
						addon:maptoggle("0")
						print("MageButtons: Hiding icon, re-enable with: /MageButtons minimap 1")
					else
						InterfaceOptionsFrame_OpenToCategory(mbPanel)
					end

				elseif button == "LeftButton" then
					if lockStatus == 0 then
						-- Not locked, lock it and save the anchor position
						MageButtonsConfig:SetMovable(false)
						MageButtonsConfig:EnableMouse(false)
						MageButtonsConfig:SetBackdropColor(0, 0, 0, 0)

						local _, _, relativePoint, xPos, yPos = MageButtonsConfig:GetPoint()
						addon:setAnchorPosition(relativePoint, xPos, yPos)
						lockStatus = 1
						lockTbl = {
							lock = 1,
						}

						MageButtonsDB["framelock"] = lockTbl
					else
						-- locked, unlock
						MageButtonsConfig:SetMovable(true)
						MageButtonsConfig:EnableMouse(true)
						MageButtonsConfig:SetBackdropColor(0, .7, 1, 1)
						lockStatus = 0
						lockTbl = {
							lock = 0,
						}

						MageButtonsDB["framelock"] = lockTbl
					end
				end
			end,

			-- Minimap Icon tooltip
			OnTooltipShow = function(tooltip)
				tooltip:AddLine("|cffffffff法师按钮|r\n左键解锁/unlock.\n右键打开菜单.")
			end,
		})

		LibDBIcon:Register("mageButtonsIcon", MageButtonsMinimapData, MageButtonsDB)
		addon:maptoggle(addon:getSV("minimap", "icon"))
		addon.init_config();
	end
end

-------------------------------
--- Minimap toggle function ---
-------------------------------
function addon:maptoggle(mtoggle)
	mtoggle = tonumber(mtoggle)

	local mmTbl = {
		icon = mtoggle
	}

	MageButtonsDB["minimap"] = mmTbl

	if mtoggle == 0 then
		LibDBIcon:Hide("mageButtonsIcon")
	else
		LibDBIcon:Show("mageButtonsIcon")
	end
end

------------------------------
-- Retrieve anchor position --
------------------------------
function addon:getAnchorPosition()
	local posTbl = MageButtonsDB["position"]
	if posTbl == nil then
		return "CENTER", 200, -200
	else
		-- Table exists, get the value if it is defined
		local relativePoint = posTbl["relativePoint"] or "CENTER"
		local xPos = posTbl["xPos"] or 200
		local yPos = posTbl["yPos"] or -200
		return relativePoint, xPos, yPos
	end
end
function addon:savePos()
	local _, _, relativePoint, xPos, yPos = MageButtonsConfig:GetPoint()
	addon:setAnchorPosition(relativePoint, xPos, yPos)
end
--------------------------
-- Save anchor position --
--------------------------
function addon:setAnchorPosition(relativePoint, xPos, yPos)
	posTbl = {
		relativePoint = relativePoint,
		xPos = xPos,
		yPos = yPos,
	}

	MageButtonsDB["position"] = posTbl

	--MageButtonsConfig:SetPoint("CENTER", xPos, yPos)
end

local baseButtons = {}

------------------
-- Base Buttons --
------------------
function addon:makeBaseButtons()
	-- Pull items from Saved Variables
	local btnSize = addon:getSV("buttonSettings", "size")
	local padding = addon:getSV("buttonSettings", "padding")
	local border = addon:getSV("borderStatus", "borderStatus")
	local backdropPadding = addon:getSV("buttonSettings", "bgpadding")
	local backdropRed = addon:getSV("bgcolor", "red")
	local backdropGreen = addon:getSV("bgcolor", "green")
	local backdropBlue = addon:getSV("bgcolor", "blue")
	local backdropAlpha = addon:getSV("bgcolor", "alpha")

	local xOffset = 0
	local yOffset = 0

	for j = 1, 7 do
		local btnType = addon:getSV("buttons", tostring(j));
		local nameTable = spell_name_table[btnType];
		if nameTable then
			local spellCount = #nameTable
			local baseSpell = nameTable[spellCount]

			if baseSpell ~= nil and baseSpell ~= "none" then
				-- Hide the button if it already exists
				local name = btnType .. "Base";
				local baseButton = baseButtons[btnType];
				if baseButton and baseButton:GetName() ~= name then
					baseButton:Hide();
					baseButton = nil;
				end
				if baseButton == nil then
					baseButton = CreateFrame("Button", btnType .. "Base", MageButtonsConfig, "SecureActionButtonTemplate");
					baseButtons[btnType] = baseButton;
				end

				baseButton:SetSize(btnSize, btnSize);
				baseButton:ClearAllPoints();
				baseButton:SetPoint("TOP", MageButtonsConfig, "BOTTOM", xOffset, yOffset);
				baseButton:SetFrameStrata("MEDIUM");
				baseButton:RegisterForClicks("LeftButtonDown", "RightButtonDown");
				baseButton:SetAttribute("*type1", "spell");
				baseButton:SetAttribute("spell", baseSpell);
				baseButton:Show();

				-- Get keybindings
				local bind = "MAGEBUTTONS_BUTTON" .. j
				if GetBindingKey(bind) ~= nil then
					keybind = GetBindingKey(bind)
					SetBindingClick(keybind, baseButton:GetName());
				end

				baseButton.menuStatus = false;
				baseButton:SetScript("PostClick", function(self, button)
					if button == "RightButton" then
						if self.menuStatus then
							addon:hideButtons(btnType, spellCount)
							self.menuStatus = false
						else
							addon:showButtons(btnType, spellCount)
							self.menuStatus = true
						end
					else
						addon:hideButtons(btnType, spellCount)
						self.menuStatus = false
					end
				end)

				baseButton.t = baseButton.t or baseButton:CreateTexture(nil, "ARTWORK")
				local _, _, buttonTexture = GetSpellInfo(baseSpell)
				baseButton.t:SetTexture(buttonTexture)
				if border == 1 then
					baseButton.t:SetTexCoord(0.06,0.94,0.06,0.94)
				end
				baseButton.t:SetAllPoints()

				-- Tooltip
				baseButton.Spell = baseSpell;
				baseButton:SetScript("OnEnter",function(self,motion)
					local bookItem = addon:getTooltipNumber(self.Spell);
					if bookItem then
						GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
						GameTooltip:ClearAllPoints()
						GameTooltip:SetPoint("BOTTOMLEFT", baseButton, "TOPRIGHT", 10, 5)
						GameTooltip:SetSpellBookItem(bookItem, BOOKTYPE_SPELL)
						GameTooltip:Show()
					end
				end)

				baseButton:SetScript("OnLeave",function(self,motion)
					GameTooltip:Hide()
				end)

				local Backdrop = baseButton.Backdrop or baseButton:CreateTexture(nil, "BACKGROUND");
				Backdrop:SetSize(btnSize + backdropPadding * 2, btnSize + backdropPadding * 2);
				Backdrop:ClearAllPoints();
				Backdrop:SetPoint("CENTER");
				Backdrop:SetTexture("Interface\\ChatFrame\\ChatFrameBackground");
				Backdrop:SetVertexColor(backdropRed, backdropGreen, backdropBlue, backdropAlpha);
				baseButton.Backdrop = Backdrop;

				-- Show the backdrop
				baseButton.buttons = {  };

				local growthDir = addon:getSV("growth", "direction")
				-- Determine the growth criteria based on user settings
				if growthDir == "Vertical" then
					xOffset = 0
					yOffset = yOffset - (btnSize + padding)
				elseif growthDir == "Horizontal" then
					xOffset = xOffset + (btnSize + padding)
					yOffset = 0
				else
					print("MageButtons: Invalid growth direction")
				end

				addon:makeButtons(btnType, spell_name_table[btnType])
			end
		end
	end
end

-----------------------
-- Make menu buttons --
-----------------------
function addon:makeButtons(btnType, nameTable)
	-- Create buttons of the requested type
	-- type = Portal, Water, etc
	-- nameTable = table of values from the start of this file
	-- i = index to define uniqe button names (PortalsButton1, PortalsButton2, etc)
	local btnSize = addon:getSV("buttonSettings", "size")
	local padding = addon:getSV("buttonSettings", "padding")
	local backdropPadding = addon:getSV("buttonSettings", "bgpadding")
	local backdropRed = addon:getSV("bgcolor", "red")
	local backdropGreen = addon:getSV("bgcolor", "green")
	local backdropBlue = addon:getSV("bgcolor", "blue")
	local backdropAlpha = addon:getSV("bgcolor", "alpha")

	local baseButton = baseButtons[btnType];
	local btnAnchor = nil
	local parentAnchor = nil
	local xOffset, yOffset = 0, 0
	local xOffsetGrowth, yOffsetGrowth = 0, 0

	local menuDir = addon:getSV("growth", "buttons")
	if menuDir == "Down" then
		--yOffset = yOffset - (btnSize + padding)
		btnAnchor = "TOP"
		parentAnchor = "BOTTOM"
		yOffset = -padding
		yOffsetGrowth = -(btnSize + padding)
		xOffsetGrowth = 0
	elseif menuDir == "Up" then
		--yOffset = yOffset + (btnSize + padding)
		btnAnchor = "BOTTOM"
		parentAnchor = "TOP"
		yOffset = padding
		yOffsetGrowth = btnSize + padding
		xOffsetGrowth = 0
	elseif menuDir == "Right" then
		--xOffset = xOffset + (btnSize + padding)
		btnAnchor = "LEFT"
		parentAnchor = "RIGHT"
		xOffset = padding
		yOffsetGrowth = 0
		xOffsetGrowth = btnSize + padding
	elseif menuDir == "Left" then
		--yOffset = 0
		--xOffset = xOffset - (btnSize + padding)
		btnAnchor = "RIGHT"
		parentAnchor = "LEFT"
		xOffset = -padding
		yOffsetGrowth = 0
		xOffsetGrowth = -(btnSize + padding)
	else
		print("MageButtons: Invalid growth direction")
	end

	local buttons = baseButton.buttons;
	for i = 1, #nameTable, 1 do
		if nameTable[i] ~= nil then

			-- Hide the button if it already exists
			local button = buttons[i];
			if button == nil then
				button = CreateFrame("Button", nil, MageButtonsConfig);
				buttons[i] = button;
			end

			-- Create new button
			button:SetFrameStrata("HIGH");
			button:SetSize(btnSize, btnSize);
			button:ClearAllPoints();
			button:SetPoint(btnAnchor, baseButton, parentAnchor, xOffset, yOffset);
			button:Hide();
			button:SetScript("OnClick", function()
				addon:hideButtons(btnType, #nameTable)
				baseButton:SetAttribute("spell", nameTable[i])
				local _, _, buttonTexture = GetSpellInfo(nameTable[i])
				baseButton.t:SetTexture(buttonTexture)
				baseButton.Spell = nameTable[i]
				baseButton.menuStatus = false;
			end)

			-- Tooltip
			button:SetScript("OnEnter",function(self,motion)
				local bookItem = addon:getTooltipNumber(nameTable[i]);
				if bookItem then
					GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
					GameTooltip:ClearAllPoints()
					GameTooltip:SetPoint("BOTTOMLEFT", self, "TOPRIGHT", 10, 5)
					GameTooltip:SetSpellBookItem(bookItem, BOOKTYPE_SPELL)
					GameTooltip:Show()
				end
			end)

			button:SetScript("OnLeave",function(self,motion)
				GameTooltip:Hide()
			end)

			button.t = button.t or button:CreateTexture(nil, "ARTWORK")
			local _, _, buttonTexture2 = GetSpellInfo(nameTable[i])
			button.t:SetTexture(buttonTexture2)
			button.t:SetAllPoints()

			local Backdrop = button.Backdrop or button:CreateTexture(nil, "BACKGROUND");
			Backdrop:SetSize(btnSize + backdropPadding * 2, btnSize + backdropPadding * 2);
			Backdrop:ClearAllPoints();
			Backdrop:SetPoint("CENTER");
			Backdrop:SetTexture("Interface\\ChatFrame\\ChatFrameBackground");
			Backdrop:SetVertexColor(backdropRed, backdropGreen, backdropBlue, backdropAlpha);
			button.Backdrop = Backdrop;

			yOffset = yOffset + yOffsetGrowth
			xOffset = xOffset + xOffsetGrowth

			buttons[i] = button
		end
	end
end

-- Show the menu buttons
function addon:showButtons(btnType, count)
	local buttons = baseButtons[btnType].buttons;
	for i = 1, count, 1 do
		buttons[i]:Show()
	end
end

-- Hide the menu buttons
function addon:hideButtons(btnType, count)
	local buttons = baseButtons[btnType].buttons;
	for i = 1, count, 1 do
		buttons[i]:Hide()
	end
end

-- Get tooltip information
function addon:getTooltipNumber(spellName)
	local slot = 1
	while true do
		local spell, rank = GetSpellBookItemName(slot, BOOKTYPE_SPELL)
		if not spell then
			break;
		end
		if rank ~= nil then
			spell = spell .. "(" .. rank .. ")"
		end
		if spell == spellName then
			return slot
		end
		slot = slot + 1
	end
end


local default_set = {
	buttons = {
		["1"] = buttonTypes[1],
		["2"] = buttonTypes[2],
		["3"] = buttonTypes[3],
		["4"] = buttonTypes[4],
		["5"] = buttonTypes[5],
		["6"] = buttonTypes[6],
		["7"] = buttonTypes[7],
	},
	buttonSettings = {
		["size"] = 26,
		["padding"] = 5,
		["bgpadding"] = 2.5,
	},
	borderStatus = {
		["borderStatus"] = 1,
	},
	bgcolor = {
		["red"] = .1,
		["green"] = .1,
		["blue"] = .1,
		["alpha"] = 1,
	},
	growth = {
		["direction"] = "Horizontal",
		["buttons"] = "Up",
	},
};
-- Function to retrieve Saved Variables
function addon:getSV(category, variable)
	local vartbl = MageButtonsDB[category]

	if vartbl == nil or vartbl[variable] == nil then
		local def = default_set[category];
		if def == nil then
			return nil;
		else
			return def[variable];
		end
	else
		return vartbl[variable]
	end
end

-- Not used
-- function addon:getButtonType(btnNumber)
	-- local buttontbl = MageButtonsDB["buttons"]
	-- if ( buttontbl[btnNumber] == "none" ) then
		-- return "none"
	-- else
		-- return buttontbl[btnNumber]
	-- end
-- end

-- Register Events
MageButtonsConfig:RegisterEvent("PLAYER_ENTERING_WORLD")
MageButtonsConfig:SetScript("OnEvent", addon.OnEvent)


-- slash commands
SlashCmdList["MAGEBUTTONS"] = function(inArgs)
	local wArgs = strtrim(inArgs)
	if wArgs == "" then
		print("usage: /magebuttons lock|move|unlock")
	elseif wArgs == "minimap 1" or wArgs == "minimap 0" then
		cmdarg, tog = string.split(" ", wArgs)
		MageButtons:maptoggle(tog)
	elseif wArgs == "move" or wArgs == "unlock" then
		print("NYI")
	elseif wArgs == "lock" then
		print("NYI")
	else
		print("usage: /MageButtons lock|move|unlock")
	end

end
SLASH_MAGEBUTTONS1 = "/magebuttons"

-- Add entries to keybinds page
BINDING_HEADER_MAGEBUTTONS = "MageButtons"
BINDING_NAME_MAGEBUTTONS_BUTTON1 = "Button 1"
BINDING_NAME_MAGEBUTTONS_BUTTON2 = "Button 2"
BINDING_NAME_MAGEBUTTONS_BUTTON3 = "Button 3"
BINDING_NAME_MAGEBUTTONS_BUTTON4 = "Button 4"
BINDING_NAME_MAGEBUTTONS_BUTTON5 = "Button 5"
BINDING_NAME_MAGEBUTTONS_BUTTON6 = "Button 6"
BINDING_NAME_MAGEBUTTONS_BUTTON7 = "Button 7"
