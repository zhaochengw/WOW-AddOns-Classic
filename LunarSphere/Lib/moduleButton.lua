-- /***********************************************
--  Lunar Button Module
--  *********************
--
--  Author	: Moongaze (Twisting Nether)
--  Description	: Button handler of Lunar.
--
--  ***********************************************/

-- /***********************************************
--  * Module Setup
--  *********************

-- Create our Lunar object if it's not made
if (not Lunar) then
	Lunar = {};
end

-- Create our Button object
if (not Lunar.Button) then
	Lunar.Button = {};
end

-- Set our current version for the module (used for version checking later on)
Lunar.Button.version = 1.52;

-- Create post WOW 2.2 bug fix, if Stage 5 comes out before 2.2 comes out.
-- Otherwise, I will rename GetActionFromMacroText in this code to SecureCmdOptionParse
-- if released after the 2.2 patch.

if (not GetActionFromMacroText) then
	GetActionFromMacroText = SecureCmdOptionParse;
end

-- Set our object settings
Lunar.Button.combatLockdown = false;
Lunar.Button.swapButton = false;
Lunar.Button.oldChecked = false;
Lunar.Button.startSwap = false;
Lunar.Button.buttonCount = 0;

-- Create some default texture data (for menu bar icons)
Lunar.Button.texturePath = {
	"Interface\\Icons\\INV_Misc_Book_09.blp",
	"Interface\\Icons\\Ability_Marksmanship.blp",
	LUNAR_ART_PATH .. "menuQuest.blp",
	LUNAR_ART_PATH .. "menuGuild.blp",
	LUNAR_ART_PATH .. "menuLFG.blp",
	LUNAR_ART_PATH .. "menuMainMenu.blp",
	LUNAR_ART_PATH .. "menuHelp.blp",
	LUNAR_ART_PATH .. "menuAchieve.blp",
	LUNAR_ART_PATH .. "menuPVP.blp",
};

-- Create some type data for easy converting of types
Lunar.Button.typeData = {
	["s"] = "spell",
	["i"] = "item",
	["m"] = "macro",
	["t"] = "macrotext",
	["p"] = "pet",
	["f"] = "flyout",
	["spell"] = "s",
	["item"] = "i",
	["macro"] = "m",
	["macrotext"] = "t",
	["pet"] = "p",
	["flyout"] = "f",
};

LUNAR_GET_SHOW_ICON		= 1;
LUNAR_GET_SHOW_COUNT		= 2;
LUNAR_GET_SHOW_COOLDOWN		= 3;
LUNAR_GET_SHOW_COMBAT		= 4;
LUNAR_GET_HIDE_COMBAT		= 5;
LUNAR_GET_SHOW_NO_COMBAT	= 6;
LUNAR_GET_HIDE_NO_COMBAT	= 7;

Lunar.Button.tooltipPos = {"TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT"};

-- /***********************************************
--   Locals
--  *********************/

local buttonCount = 0;		-- Track how many buttons have been made
local timerData = {};		-- Tracks our cooldown timers and "in-range" timers
local swapData = {};		-- Placeholder for a button while swapping
local menuOffsetY = {55, 10, 0, 0, 350, 235, 190, 180, 180, 170};

local stateTransitions;			-- Transition string for normal clicks
local stateTransitionsEnter;		-- Transition string for mouse over (entering)
local stateTransitionsLeave;		-- Transition string for mouse over (leaving)
local stateTransitionsAlwaysShown;	-- Transistion string for always visible menus

local string = string;
local tonumber = tonumber;
local GetItemInfo = GetItemInfo;
local IsUsableItem = IsUsableItem;
local ItemHasRange = ItemHasRange;
local IsItemInRange = IsItemInRange;
local IsUsableSpell = IsUsableSpell;
local IsSpellInRange = IsSpellInRange;

Lunar.origBackdrop = nil;
Lunar.origBackdropColor = nil;
Lunar.origBackdropBorderColor = nil;

local backdrop;

-- Need to add support for main sphere cooldown as well

-- Our cooldown effects
Lunar.cooldownEffectFunction = {
	[0] = function (button, percent, setup)
		local fx = button.cooldown;
		if (setup) then
			fx:Show();
			fx:SetWidth(25);
			fx:SetHeight(25);
			fx:SetAlpha(LunarSphereSettings.cooldownColorTint[4]);
			button:SetAlpha(1);
			button.readyShine:Hide();
			_G[button:GetName() .. "Icon"]:SetAlpha(1);
		end
	end,
	[1] = function (button, percent, setup)
		local fx = button.cooldown;
		if (setup) then
			fx:Show();
			fx:SetWidth(25);
			fx:SetHeight(25);
			button:SetAlpha(1);
			button.readyShine:Hide();
			_G[button:GetName() .. "Icon"]:SetAlpha(1);
		end
		fx:SetAlpha(percent);
	end,
	[2] = function (button, percent, setup)
		if (setup) then
			button.readyShine:Hide();
			button.cooldown:Hide();
			_G[button:GetName() .. "Icon"]:SetAlpha(1);
		end
		button:SetAlpha(1 - percent);
	end,
	[3] = function (button, percent, setup)
		if (setup) then
			button.cooldown:Hide();
			button.readyShine:Hide();
			button:SetAlpha(1);
			_G[button:GetName() .. "Icon"]:SetAlpha(1);
		end
		_G[button:GetName() .. "Icon"]:SetAlpha(1 - percent);
	end,
	[4] = function (button, percent, setup)
		local fx = button.cooldown;
		local size = 25 * percent;
		if (setup) then
			fx:Show();
			fx:SetAlpha(LunarSphereSettings.cooldownColorTint[4]);
			fx:SetWidth(25);
			fx:SetHeight(25);
			button:SetAlpha(1);
			button.readyShine:Hide();
			_G[button:GetName() .. "Icon"]:SetAlpha(1);
		end
		fx:SetWidth(size);
	end,
	[5] = function (button, percent, setup)
		local fx = button.cooldown;
		local size = 25 * percent;
		if (setup) then
			fx:Show();
			fx:SetAlpha(LunarSphereSettings.cooldownColorTint[4]);
			fx:SetWidth(25);
			fx:SetHeight(25);
			button:SetAlpha(1);
			button.readyShine:Hide();
			_G[button:GetName() .. "Icon"]:SetAlpha(1);
		end
		fx:SetHeight(size);
	end,
	[6] = function (button, percent, setup)
		local fx = button.cooldown;
		local size = 25 * percent;
		if (setup) then
			fx:Show();
			fx:SetAlpha(LunarSphereSettings.cooldownColorTint[4]);
			fx:SetWidth(25);
			fx:SetHeight(25);
			button:SetAlpha(1);
			button.readyShine:Hide();
			_G[button:GetName() .. "Icon"]:SetAlpha(1);
		end
		fx:SetWidth(size);
		fx:SetHeight(size);
	end,
	[7] = function (button, percent, setup, startTime, duration, enabled)
		if (setup) then
			button.cooldown:Hide();
			button:SetAlpha(1);
			_G[button:GetName() .. "Icon"]:SetAlpha(1);
			CooldownFrame_SetTimer(button.readyShine, startTime, duration, enabled)
		end
	end,
	}

-- /***********************************************
--   Functions
--  *********************/

-- /***********************************************
--  * Initialize
--  * ========================
--  *
--  * Creates the initial buttons needed to make this bad boy work
--  *
--  * Accepts: None
--  * Returns: None
--  *********************
function Lunar.Button:Initialize()

	Lunar.Button.enabledButtons = LunarSphereSettings.buttonEditMode;

--	_, Lunar.Items.reagentString = GetAuctionItemSubClasses(10);

	-- Create our locals
	local newButton, menuHeader, parentButton, xLoc, yLoc, radians, index, subIndex, menuIndex;
	local xOffset, xDir, sphereHeader, sphereMainHeader;
	
	-- Create the state header for the sphere (for stance changing for the main buttons)
--	sphereHeader = CreateFrame("Frame", "LunarSphereButtonHeader", _G["LSmain"], "SecureStateHeaderTemplate, SecureStateDriverTemplate")
	if (select(2, UnitClass("player")) == "WARRIOR") then
		Lunar.Button.defaultStance = 1;
	else
		Lunar.Button.defaultStance = 0;
	end

	Lunar.Button.shootIcon = "Interface\\Icons\\Ability_Whirlwind";
	index = select(2, UnitClass("player"));
	if ((index == "PRIEST") or (index == "WARLOCK") or (index == "MAGE")) then
		Lunar.Button.shootIcon = "Interface\\Icons\\Ability_ShootWand";
	end

	sphereMainHeader = CreateFrame("Frame", "LunarSphereMainButtonHeader", UIParent, "SecureHandlerStateTemplate")

	sphereMainHeader:SetWidth(1);
	sphereMainHeader:SetHeight(1);
	sphereMainHeader:SetPoint("Topleft");
	sphereMainHeader:SetAttribute("width", 1);
	sphereMainHeader:SetAttribute("height", 1);
	sphereMainHeader:SetAttribute('state-state', Lunar.Button.defaultStance);
	sphereMainHeader:SetAttribute("_onstate-state",
	[[ -- (self, stateid, newstate)
		state = newstate;
		self:SetAttribute("state", newstate);
		control:ChildUpdate(stateid, newstate)
	]]
);

	sphereMainHeader:SetAttribute("*unit*", "");
	sphereMainHeader:SetAttribute('statebindings', '*:S0;');
	sphereMainHeader:SetAttribute('childraise', true);

	_G["LSmain"]:SetParent(sphereMainHeader);

	sphereHeader = CreateFrame("Frame", "LunarSphereButtonHeader", UIParent, "SecureHandlerStateTemplate")

	sphereHeader:SetWidth(64);
	sphereHeader:SetHeight(64);
	sphereHeader:SetPoint("Topleft");
	sphereHeader:SetAttribute("width", 1);
	sphereHeader:SetAttribute("height", 1);
	sphereHeader:SetAttribute('state-state', Lunar.Button.defaultStance);
	sphereHeader:SetAttribute("_onstate-state",
	[[ -- (self, stateid, newstate)
		if (tonumber(newstate) == 15) then
			newstate = state;
		end
		state = newstate;
		self:SetAttribute("state", newstate);
		control:ChildUpdate(stateid, newstate)
	]]
);

	sphereHeader:SetFrameLevel(10);	

	sphereHeader:SetAttribute("*unit*", "");
	sphereHeader:SetAttribute('statebindings', "*:S0;");
	sphereHeader:SetAttribute('childraise', false);
	sphereHeader:SetAttribute('childraise', true);

	stateTransitions = "";
	stateTransitionsEnter = "";
	stateTransitionsLeave = "";
	stateTransitionsAlwaysShown = "";
	for xOffset = 0, 12 do 
		stateTransitions = stateTransitions .. xOffset .. ":" .. (30+xOffset) .. ";" .. (30+xOffset) .. ":" .. xOffset .. ";"
		stateTransitionsEnter = stateTransitionsEnter .. (30+xOffset) .. ":" .. xOffset .. ";"
		stateTransitionsLeave = stateTransitionsLeave .. xOffset .. ":" .. (30+xOffset) .. ";"
		stateTransitionsAlwaysShown = stateTransitionsAlwaysShown .. xOffset .. ":" .. xOffset .. ";"
	end

	-- Repair any broken menus that might appear
	Lunar.Button:FixMenus()

	-- Make our sphere be clickable
	local buttonType, cursorType, objectName, objectTexture, stance;
	local sphere = _G["LSmain"];
	sphere.currentStance = Lunar.Button.defaultStance;

	sphere:SetAttribute("checkselfcast", true);
	sphere:SetAttribute("checkfocuscast", true);
	sphere:SetAttribute("useparent-unit", true)
	sphere:SetAttribute('childraise', false);
	sphere:SetAttribute('childraise', true);

	if (not LunarSphereSettings.buttonData[0]) then
		Lunar.Button:ResetButtonData(0);
	end
	if (LunarSphereSettings.buttonData[0].useStances) then
		RegisterStateDriver(sphereMainHeader, "state", "[stance:1] 1; [stance:2] 2; [stance:3] 3; [stance:4] 4; [stance:5] 5; [stance:6] 6; [stance:7] 7; " .. Lunar.Button.defaultStance);
	else
		RegisterStateDriver(sphereMainHeader, "state", "[stance:*] " .. Lunar.Button.defaultStance .. "; " .. Lunar.Button.defaultStance);
	end		

	Lunar.Button:LoadButtonData(0);

	local buttonScale;

	-- Add OnEnter and OnLeave support to buttons (since they are using the secure
	-- action templates, this workaround will ensure our tooltips and updates on the
	-- buttons work properly.
    hooksecurefunc("SecureHandler_OnSimpleEvent",
	function(self, scriptEvent)
		if not self.enableMouseMotion then
			return
		end
		if scriptEvent == "_onenter" then
			Lunar.Button.OnEnter(self);
		elseif scriptEvent == "_onleave" then
			Lunar.Button.OnLeave(self);
		end
	end)

local buttonOnEnter = [[
	if (self:GetID() > 0) and (self:GetID() <= 10) then
		if ((menuType == "enter") and ((menuOpen1 == true) or (menuOpen2 == true) or (menuOpen3 == true))) then
			toggle = false;
			control:RunAttribute("_onclick");
		end
	end
	totalElapsed = nil;
]];

local buttonOnLeave = [[
	if ((useMenuDelay == true) and ((menuOpen1 == true) or (menuOpen2 == true) or (menuOpen3 == true))) then
		--print("  Left " .. menuDelay)
		totalElapsed = 0
		-- Broken in 3.0.8 patch, 3.0.9 may have resolved the issue with new code, check back then.

--		CooldownFrame_SetTimer(self.readyShine, GetTime(), menuDelay, 1)
		CooldownFrame_SetTimer(frame, GetTime(), menuDelay, 1)
--		control:SetAnimating(true);
		--SetUpAnimation(self, "SetScale", "if (elapsedFraction >= 1) then return 0.001; end; return 1;", menuDelay, nil, nil)
		--SetUpAnimation(frame, updateFunc, posBody, totalTime, postFunc, reverse);
	end
]];

local buttonOnClick = [[
	if (menuType ~= "always") and (useSubmenuClose) and ((menuOpen1 == true) or (menuOpen2 == true) or (menuOpen3 == true)) then
		if (toggle == true) then
			control:RunAttribute("_onclick");
		end
	end
]];

	-- Create 10 buttons, each circling around the main sphere in
	-- 36 degree shifts
	for index = 1, 10 do 

		-- Create button and hide it;
		newButton = Lunar.Button:Create("Menu"..index, sphereHeader); --"LSmain", true);
		newButton:Hide();

		if (index == 1) then
			_G["LSmain"]:SetAttribute("_childupdate", newButton:GetAttribute("_childupdate"));
			sphereMainHeader:SetAttribute('state-state', Lunar.Button.defaultStance);  -- + 30);
		end

		-- Calculate it's location around the sphere
		radians = -math.rad(((index-1) * 36) - 90);
		buttonScale = LunarSphereSettings.buttonData[index].buttonScale or (1.0);

		xLoc = ((16 + 32) - 18 * (buttonScale - 1.0)) * math.cos(radians)
		yLoc = ((16 + 32) - 18 * (buttonScale - 1.0)) * math.sin(radians)

		-- Attach it to the sphere and hide it
		newButton:SetPoint("CENTER", xLoc, yLoc);
		newButton:SetScale(1.0); --0.9

		-- Create the state headers for the menu
		menuHeader = CreateFrame("Button", "LunarMenu" .. index .. "ButtonHeader", sphereHeader, "SecureHandlerStateTemplate, SecureHandlerClickTemplate, SecureHandlerEnterLeaveTemplate") --, SecureHandlerAttributeTemplate")

menuHeader:SetAttribute("_onstate-state",
	[[ -- (self, stateid, newstate)
		if (tonumber(newstate) == 15) then
			newstate = state;
		end
		state = newstate;
		self:SetAttribute("state", newstate);
		control:ChildUpdate(stateid, newstate)
	]]
);
menuHeader:WrapScript(newButton, "OnClick",
[[
	if (button == "LeftButton") and (menuOpen1 == true) and (menuType ~= "always") then
		control:RunAttribute("_onclick");
		return false;
	elseif (button == "RightButton") and (menuOpen2 == true) and (menuType ~= "always") then
		control:RunAttribute("_onclick");
		return false;
	elseif (button == "MiddleButton") and (menuOpen3 == true) and (menuType ~= "always") then
		control:RunAttribute("_onclick");
		return false;
	end
]]);

menuHeader:WrapScript(newButton, "OnEnter", buttonOnEnter);
menuHeader:WrapScript(newButton, "OnLeave", buttonOnLeave);


menuHeader:SetAttribute('_onupdate',
[[
	if not useMenuDelay then
		control:SetAnimating(false);
		return;
	end
	if (totalElapsed) then
		totalElapsed = totalElapsed + elapsed;
		if (totalElapsed >= menuDelay) then
			totalElapsed = nil;
			toggle = true;
			control:RunAttribute("_onclick");
		end
	end
]]);
	
menuHeader:Show();
menuHeader:SetAttribute('_onclick',
	[[
		if not updateMenuOpening then
			if (editMode == true) then
				return;
			end
		end

		toggle = not toggle;
		self:SetAttribute("toggle", toggle);

		local i = 2
		local child = select(i, self:GetChildren())
		local showState

		if (toggle == true) then
			while child do
				showState = child:GetAttribute("showstates");
				if (showState == "!*") or (string.find(showState, state .. ",") == nil) then
					child:Hide();
				else
					child:Show();
				end
				i = i + 1
				child = select(i, self:GetChildren())
			end
		else
			while child do
				child:Hide();
				i = i + 1
				child = select(i, self:GetChildren())
			end
		end
	]]	
);

		menuHeader:SetAttribute('statebindings', '*:S0;');
		menuHeader:SetAttribute('childraise', false);
		menuHeader:SetAttribute('childraise', true);
                
		-- Set the points for the headers
	  	menuHeader:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up");
 
		-- events to childs
		newButton:SetAttribute('childraise', false);
		newButton:SetAttribute('childraise', true);
		newButton:SetParent(menuHeader);

		menuHeader:SetAttribute('statemap-anchor-mousedown', stateTransitions);

		-- On enter support
		newButton:SetAttribute("anchorchild-OnEnter", menuHeader);
		newButton:SetAttribute("anchorchild-OnLeave", menuHeader);
		newButton:SetAttribute("childstate-OnEnter", "enter");
		newButton:SetAttribute("childstate-OnLeave", "leave");

		menuHeader:SetAttribute('statemap-anchor-enter', stateTransitionsEnter);
		menuHeader:SetAttribute('statemap-anchor-leave', ';');
		menuHeader:SetAttribute("delaystatemap-anchor-leave", stateTransitionsLeave);
		menuHeader:SetAttribute("delaytimemap-anchor-leave",  "0-15:0.5");
		menuHeader:SetAttribute("delayhovermap-anchor-leave", "0-15:true");

		-- Mouse click / delay support

		menuHeader:SetAttribute('delaystatemap-anchor', Lunar.Button.defaultStance + 30);
		menuHeader:SetAttribute('delaytimemap-anchor', "");
		menuHeader:SetAttribute('delayhovermap-anchor', 'true');

		-- Add the button to the sphere header, for left-middle-right click and stance button
--		menuHeader:SetAttribute("addchild", newButton);
--		sphereHeader:SetAttribute("addchild", newButton);

		-- If the button doesn't have a save entry yet, create it and reset
		-- it's data
		if (not LunarSphereSettings.buttonData[index]) then
			Lunar.Button:ResetButtonData(index);
			newButton:Hide();

		-- Otherwise, we have a button entry saved, so load it up and set the
		-- button up to the last saved state
		else
			-- Set the menu button up for stance support, if it is turned on
			if (LunarSphereSettings.buttonData[index].useStances) then
				RegisterStateDriver(menuHeader, "state", "[stance:1] 1; [stance:2] 2; [stance:3] 3; [stance:4] 4; [stance:5] 5; [stance:6] 6; [stance:7] 7; " .. Lunar.Button.defaultStance);
			else
				RegisterStateDriver(menuHeader, "state", "[stance:*] " .. Lunar.Button.defaultStance .."; " .. Lunar.Button.defaultStance);
			end					

			-- If no action was assigned and the button is not a menu button,
			-- reset the button and hide it	
			if (LunarSphereSettings.buttonData[index].empty) and (not LunarSphereSettings.buttonData[index].isMenu)  then
				Lunar.Button:ResetButtonData(index);
				newButton:Hide();
			
			-- Otherwise, load it up and show it
			else
				-- Show the button
				newButton:Show();
				
				-- Load the data if it still exists
				Lunar.Button:LoadButtonData(index);

				-- Next, if it was a menu button, we check to see if it was open
				-- when the user logged out. If so, reopen it.
				if (LunarSphereSettings.buttonData[index].isMenu) then
					if ((LunarSphereSettings.buttonData[index].menuOpen == true) and not (LunarSphereSettings.buttonData[index].menuUseDelay == 1)) then
						if not (LunarSphereSettings.buttonData[index].useStances) then
							menuHeader:SetAttribute("state-state", Lunar.Button.defaultStance);
						else
							menuHeader:SetAttribute("state-state", GetShapeshiftForm());
						end
						menuHeader:Execute("toggle = nil; control:RunAttribute('_onclick');");
					else
						if not (LunarSphereSettings.buttonData[index].useStances) then
							menuHeader:SetAttribute("state-state", Lunar.Button.defaultStance) -- + 30);
						else
							menuHeader:SetAttribute("state-state", GetShapeshiftForm()); -- + 30);
						end
						menuHeader:Execute("toggle = true; control:RunAttribute('_onclick');");
						LunarSphereSettings.buttonData[index].menuOpen = false;
					end
				else
					menuHeader:SetAttribute('state-state', Lunar.Button.defaultStance);  -- + 30);
				end
			end
		end

		newButton:SetFrameLevel(_G["LSoverlay"]:GetFrameLevel() + 1);
	end

	index = 10;
	local offsetY = {28, 6, 0, 0, -6, -28, -6, 0, 0, 6}

	for menuIndex = 1, 10 do 

		menuButton = _G["LunarMenu" .. menuIndex .. "Button"]

		xDir = 1;
		if (menuIndex > 5) then
			xDir = -1;
		end

		for xLoc = 1, 12 do --0, (320 - 32), 32 do 

			-- Increase our global button index
			index = index + 1;

			-- Create button
			newButton = Lunar.Button:Create("Sub"..index, "LSmain");

			-- Save our parent's ID
			newButton.parentID = menuIndex;

			newButton:SetAttribute("showstates", "!*") --!0,!1");
			newButton:Show();

			_G[menuButton:GetName() .. "Header"]:WrapScript(newButton, "OnEnter", buttonOnEnter);
			_G[menuButton:GetName() .. "Header"]:WrapScript(newButton, "OnLeave", buttonOnLeave);
			_G[menuButton:GetName() .. "Header"]:WrapScript(newButton, "OnClick", buttonOnClick);

			-- Sub buttons are all hidden while in the menu without an action. This lets
			-- buttons that have actions appear, lined up, without gaping holes. If the button
			-- has an action, the width will increase while the button is loading
			if (LunarSphereSettings.submenuCompression) then
				newButton:SetWidth(4);
				newButton:SetAttribute("width", 4);
			end

			if (not LunarSphereSettings.buttonData[index]) then
				Lunar.Button:ResetButtonData(index);
				newButton:Hide();
			else
				if (LunarSphereSettings.buttonData[index].child) then
					Lunar.Button:LoadButtonData(index);
				else
					Lunar.Button:LoadButtonData(index);
--					newButton:Show();
				end
				newButton:Hide();
			end

			-- If we have a broken child because it got deleted improperly, fix it
			if (LunarSphereSettings.buttonData[menuIndex].isMenu == true) then
				LunarSphereSettings.buttonData[index].child = true;
			else
				if (LunarSphereSettings.buttonData[index].child == true) then
					LunarSphereSettings.buttonData[index].child = false;
				end
			end

			newButton:SetParent(_G["LunarMenu" .. menuIndex .. "ButtonHeader"]);
		end
		Lunar.Button:SetupMenuAngle(menuIndex)
		_G["LunarMenu" .. menuIndex .. "ButtonHeader"]:SetAttribute("state-state", tostring(_G["LunarMenu" .. menuIndex .. "ButtonHeader"]:GetAttribute("state") or tostring(Lunar.Button.defaultStance))); 

				-- Next, if it was a menu button, we check to see if it was open
				-- when the user logged out. If so, reopen it.
				if (LunarSphereSettings.buttonData[menuIndex].isMenu) then
					if ((LunarSphereSettings.buttonData[menuIndex].menuOpen == true) and not (LunarSphereSettings.buttonData[menuIndex].menuUseDelay == 1)) then
						_G[menuButton:GetName() .. "Header"]:Execute("toggle = nil; control:RunAttribute('_onclick');");
					else
						_G[menuButton:GetName() .. "Header"]:Execute("toggle = true; control:RunAttribute('_onclick');");
						LunarSphereSettings.buttonData[menuIndex].menuOpen = false;
					end
				end
	end

	_G["LSmain"]:SetAttribute('_childupdate', _G["LunarMenu1Button"]:GetAttribute('_childupdate'));
	sphereMainHeader:SetAttribute('_onclick', _G["LunarMenu1ButtonHeader"]:GetAttribute('_onclick'));
	sphereMainHeader:WrapScript(_G["LSmain"], "OnClick",
[[
	if (IsControlKeyDown()) then
		if (button == "LeftButton") then
			control:RunAttribute("_onclick");
			return false;
		elseif (button == "RightButton") then
			control:RunAttribute("_onclick");
			return false;
		elseif (button == "MiddleButton") then
			control:RunAttribute("_onclick");
			return false;
		end
	end
]]);

	-- Set our menus to auto-hide if specified
	Lunar.Button:ToggleMenuAutoHide();

	-- Show the shines if they are on
	Lunar.Button:ShowButtonShine();

	-- Show or hide the keybind text based upon settings
	Lunar.Button:ToggleKeybinds()

	-- Update the art of the sphere, if its skin is set to the sphere button's click icon
	Lunar.Sphere:SetSphereTexture();

	-- Create the frame that will watch for screen updates (used for
	-- assigning a button a new action. This method prevents the player
	-- from automatically using an item that they place on the button when
	-- they are assigning it)
	Lunar.Button.updateFrame = CreateFrame("Frame", "LunarButtonUpdates", UIParent, BackdropTemplateMixin and "BackdropTemplate");

	-- Create the update counter frame. This will run at all times and when a set amount
	-- of time passes, it will run through all active buttons with a "canUpdate" flag
	-- and run their OnUpdate code.
	Lunar.Button.updateCounterFrame = CreateFrame("Frame", "LunarButtonUpdateTimer", UIParent, BackdropTemplateMixin and "BackdropTemplate");

	Lunar.Button.updateCounterFrame.elapsed = 0;
	Lunar.Button.updateCounterFrame.elapsedCooldown = 0;
	Lunar.Button.updateCounterFrame.updateHighLowItems = 0
	Lunar.Button.updateCounterFrame:SetScript("OnUpdate",
	function(self, arg1)

		self.elapsed = self.elapsed + arg1;

		if (LunarSphereSettings.cooldownEffect > 0) then
			self.elapsedCooldown = self.elapsedCooldown + arg1;
			if (self.elapsedCooldown > 0.1) then
				if (self.updateButtons == 1) then
					self.updateButtons = nil;
					self.elapsedCooldown = 0;
				elseif (self.updateButtons ~= 2) then
					self.currentTime = GetTime();
					self.updateButtons = 1;
				end
			end
		end
--]]
		if self.updateCurrentCast then
			if (self.updateCurrentCast >= 0) then
				self.updateCurrentCast = self.updateCurrentCast + 1;
				if (self.updateCurrentCast > 2) then
					self.updateCurrentCast = nil;
				end
			end
		end

		if (self.elapsed > 0.4) then
			if (self.updateButtons == 2) then
				self.updateButtons = nil;
				self.elapsed = 0;
			else
				self.updateButtons = 2;
				self.currentTime = GetTime();

				local frame = Lunar.sphereFrame;
				if (frame.updateCount == true) then
					local temp = self;
					Lunar.updateButtons = 2;
					Lunar.Button.OnUpdate(frame, self.elapsed, frame);
					self = temp;
				end

			end
		end
		Lunar.updateButtons = self.updateButtons;

		--Trade updater
		if (Lunar.Button.tradingStage == 2) then
			Lunar.Button:ContinueTrade();
		end

		if (Lunar.Button.portraitTimer) then
			Lunar.Button.portraitTimer = Lunar.Button.portraitTimer + arg1;
			if (Lunar.Button.portraitTimer >= 1.5) then
				Lunar.Button:UpdatePlayerPortrait();
				Lunar.Button.portraitTimer = nil;
			end
		end

	end);

	-- Flag that our buttons are loaded
	Lunar.Button.Loaded = true;

	-- Update the button counts (primarily for items with charges)
	Lunar.Items.bagUpdateTimer = 0.01;
	Lunar.Button.portraitTimer = 0;
end

function Lunar.Button:ReloadAllButtons()

	-- Create our locals
	local newButton, menuHeader, parentButton, xLoc, yLoc, radians, index, subIndex, menuIndex;
	local xOffset, xDir, sphereHeader, sphereMainHeader;
	
	-- Load the sphere button data
	Lunar.Button:LoadButtonData(0);

	-- Load the 10 menu buttons
	for index = 1, 10 do 

		menuButton = _G["LunarMenu" .. index .. "Button"];
		menuHeader = _G["LunarMenu" .. index .. "ButtonHeader"];

		-- If the button doesn't have a save entry yet, create it and reset
		-- it's data
		if (not LunarSphereSettings.buttonData[index]) then
			Lunar.Button:Unassign(menuButton);
			Lunar.Button:ResetButtonData(index);
			menuButton:Hide();

		-- Otherwise, we have a button entry saved, so load it up and set the
		-- button up to the last saved state
		else
			-- If no action was assigned and the button is not a menu button,
			-- reset the button and hide it	
			if (LunarSphereSettings.buttonData[index].empty == true) then
				Lunar.Button:Unassign(menuButton);
				Lunar.Button:ResetButtonData(index);
				menuButton:Hide();
			
			-- Otherwise, load it up and show it
			else

				-- Set the menu button up for stance support, if it is turned on
				-- Show the button
				menuButton:Show();
				
				-- Load the data if it still exists
				Lunar.Button:LoadButtonData(index);

				if (LunarSphereSettings.buttonData[index].isMenu) then
					if ((LunarSphereSettings.buttonData[index].menuOpen == true) and not (LunarSphereSettings.buttonData[index].menuUseDelay == 1)) then
						if not (LunarSphereSettings.buttonData[index].useStances) then
							menuHeader:SetAttribute("state-state", Lunar.Button.defaultStance);
						else
							menuHeader:SetAttribute("state-state", GetShapeshiftForm());
						end
						menuHeader:Execute("toggle = nil; control:RunAttribute('_onclick');");
					else
						if not (LunarSphereSettings.buttonData[index].useStances) then
							menuHeader:SetAttribute("state-state", Lunar.Button.defaultStance);
						else
							menuHeader:SetAttribute("state-state", GetShapeshiftForm()); 
						end
						menuHeader:Execute("toggle = true; control:RunAttribute('_onclick');");
						LunarSphereSettings.buttonData[index].menuOpen = false;
					end
				else
					menuHeader:SetAttribute('state-state', Lunar.Button.defaultStance);
				end
			end
		end

		menuButton:SetFrameLevel(_G["LSoverlay"]:GetFrameLevel() + 1);
	end

	index = 10;

	for menuIndex = 1, 10 do 

		menuButton = _G["LunarMenu" .. menuIndex .. "Button"]

		for xLoc = 1, 12 do

			-- Increase our global button index
			index = index + 1;

			-- Get button
			newButton = _G["LunarSub"..index.."Button"];

			newButton:SetAttribute("showstates", "!*") --!0,!1");
			newButton:Show();

			-- Sub buttons are all hidden while in the menu without an action. This lets
			-- buttons that have actions appear, lined up, without gaping holes. If the button
			-- has an action, the width will increase while the button is loading
			if (LunarSphereSettings.submenuCompression) then
				newButton:SetWidth(4);
				newButton:SetAttribute("width", 4);
			end

			if (not LunarSphereSettings.buttonData[index]) then
				Lunar.Button:Unassign(newButton);
				Lunar.Button:ResetButtonData(index);
				newButton:Hide();
			else
				-- If no action was assigned and the button is not a menu button,
				-- reset the button and hide it	
				if (LunarSphereSettings.buttonData[index].empty == true) then
					Lunar.Button:Unassign(newButton);
					Lunar.Button:ResetButtonData(index);
				-- Otherwise, load it
				else
					if (LunarSphereSettings.buttonData[index].child) then
						Lunar.Button:LoadButtonData(index);
					else
						Lunar.Button:LoadButtonData(index);
					end
				end
				newButton:Hide();
			end

			-- If we have a broken child because it got deleted improperly, fix it
			if (LunarSphereSettings.buttonData[menuIndex].isMenu == true) then
				LunarSphereSettings.buttonData[index].child = true;
			else
				if (LunarSphereSettings.buttonData[index].child == true) then
					LunarSphereSettings.buttonData[index].child = false;
				end
			end

		end
		Lunar.Button:SetupMenuAngle(menuIndex)
		_G["LunarMenu" .. menuIndex .. "ButtonHeader"]:SetAttribute("state-state", tostring(_G["LunarMenu" .. menuIndex .. "ButtonHeader"]:GetAttribute("state") or tostring(Lunar.Button.defaultStance))); 

		-- Next, if it was a menu button, we check to see if it was open
		-- when the user logged out. If so, reopen it.
		if (LunarSphereSettings.buttonData[menuIndex].isMenu) then
			if ((LunarSphereSettings.buttonData[menuIndex].menuOpen == true) and not (LunarSphereSettings.buttonData[menuIndex].menuUseDelay == 1)) then
				_G[menuButton:GetName() .. "Header"]:Execute("toggle = nil; control:RunAttribute('_onclick');");
			else
				_G[menuButton:GetName() .. "Header"]:Execute("toggle = true; control:RunAttribute('_onclick');");
				LunarSphereSettings.buttonData[menuIndex].menuOpen = false;
			end
		end
	end

	-- Set our menus to auto-hide if specified
	Lunar.Button:ToggleMenuAutoHide();

	-- Show the shines if they are on
	Lunar.Button:ShowButtonShine();

	-- Show or hide the keybind text based upon settings
	Lunar.Button:ToggleKeybinds()

	-- Update the art of the sphere, if its skin is set to the sphere button's click icon
	Lunar.Sphere:SetSphereTexture();

	-- Update all sphere art.
	Lunar.Sphere:SetInnerMarkSize(LunarSphereSettings.innerMarkSize);
	Lunar.Sphere:SetOuterMarkSize(LunarSphereSettings.outerMarkSize);
	Lunar.Sphere:ShowInnerGauge(LunarSphereSettings.showInner);
	Lunar.Sphere:ShowOuterGauge(LunarSphereSettings.showOuter);
	Lunar.Sphere:ShowSphereShine(LunarSphereSettings.showSphereShine);
	
	if not (LunarSphereSettings.sphereTextColor) then
		LunarSphereSettings.sphereTextColor = {1,1,1};
	end
	Lunar.Sphere:SetSphereTextColor(unpack(LunarSphereSettings.sphereTextColor))

	Lunar.Sphere:UpdateSkin("gaugeFill");
	Lunar.Sphere:UpdateSkin("gaugeBorder");

	if (LunarSphereSettings.buttonSkin > Lunar.includedButtons) then
		artIndex, artType, width, height, artFilename = Lunar.API:GetArtByCatagoryIndex("button", LunarSphereSettings.buttonSkin - Lunar.includedButtons);
		if (artFilename) then
			Lunar.Button:UpdateSkin(LUNAR_IMPORT_PATH .. artFilename);
		else
			Lunar.Button:UpdateSkin(LUNAR_ART_PATH .. "buttonSkin_1.blp");
		end
	else
		Lunar.Button:UpdateSkin(LUNAR_ART_PATH .. "buttonSkin_" .. LunarSphereSettings.buttonSkin .. ".blp");
	end

	_G["LSmain"]:SetScale(LunarSphereSettings.sphereScale);

	-- Update all the button art!
	local oldMode = LunarSphereSettings.buttonEditMode;
	LunarSphereSettings.buttonEditMode = true;
	Lunar.Sphere:ShowSphereEditGlow(LunarSphereSettings.showSphereEditGlow);
	LunarSphereSettings.buttonEditMode = false;
	Lunar.Sphere:ShowSphereEditGlow(LunarSphereSettings.showSphereEditGlow);
	LunarSphereSettings.buttonEditMode = oldMode;
	Lunar.Sphere:ShowSphereEditGlow(LunarSphereSettings.showSphereEditGlow);

	-- Update the button counts (primarily for items with charges)
	Lunar.Items.bagUpdateTimer = 0.01;
	Lunar.Button.portraitTimer = 0;

	collectgarbage();
end

function Lunar.Button:SetupMenuAngle(menuButtonID)

	-- Make sure we have valid data, if not ... exit now
	if (not menuButtonID) then
		return;
	end

	local mainButtonCount = LunarSphereSettings.mainButtonCount;

	if (menuButtonID > 10) then
		return;	
	end

	if (menuButtonID > mainButtonCount) then
		local button = _G["LunarMenu" .. menuButtonID .. "Button"]
		button:SetAttribute("showstates", "!*");
		_G["LunarMenu" .. menuButtonID .. "ButtonHeader"]:Hide(); --SetAttribute("state-state", tostring(_G["LunarMenu" .. menuButtonID .. "ButtonHeader"]:GetAttribute("state") or tostring(Lunar.Button.defaultStance))); 
		return;
	end
	_G["LunarMenu" .. menuButtonID .. "ButtonHeader"]:Show(); --SetAttribute("state-state", tostring(_G["LunarMenu" .. menuButtonID .. "ButtonHeader"]:GetAttribute("state") or tostring(Lunar.Button.defaultStance))); 

	-- Set our locals
	local xDir, yDir, xMenuDir, yMenuDir, index, button, menuButton, buttonPadding, buttonAngleID, menuAngle, menuOffset;

	-- Grab our beginning button data
	local buttonScale = (LunarSphereSettings.buttonData[menuButtonID].buttonScale or (1.0)); -- - 0.1;
	local childScale = (LunarSphereSettings.buttonData[menuButtonID].childScale or (1.0)); -- - 0.1;
	local buttonSpacing = LunarSphereSettings.buttonData[menuButtonID].childSpacing or (LunarSphereSettings.subMenuButtonDistance) or (4);

	-- If we are not using certain settings, set our settings to their defaults
	if (not LunarSphereSettings.buttonData[menuButtonID].useButtonScale) then
		buttonScale = 1.0;
	end
	if (not LunarSphereSettings.buttonData[menuButtonID].useChildScale) then
		childScale = 1.0;
	end
	if (not LunarSphereSettings.buttonData[menuButtonID].useChildSpacing) then
		buttonSpacing = LunarSphereSettings.buttonData[menuButtonID].subMenuButtonDistance or 4; 
	end
	buttonSpacing = buttonSpacing + 28;

	-- Make sure the child scale is scaled properly to match the menu button's scale. If we don't do
	-- this, the buttons scales get REALLY messed up (because the child scales are based on the menu
	-- scale, not the sphere scale)

	_G["LunarMenu" .. menuButtonID .. "ButtonHeader"]:Execute("buttonScale = " .. buttonScale);
	_G["LunarMenu" .. menuButtonID .. "ButtonHeader"]:Execute("childScale = " .. childScale);
	_G["LunarMenu" .. menuButtonID .. "ButtonHeader"]:Execute("compressButtons = " .. tostring(LunarSphereSettings.submenuCompression));
	_G["LunarMenu" .. menuButtonID .. "ButtonHeader"]:Execute("autoShowPet = " .. tostring((LunarSphereSettings.alwaysShowPet == true)));

	-- Grab more menu button position data that we need, based on the button offset around the
	-- sphere, the distance from the sphere, and the scale
	local angleIncrement = 360 / mainButtonCount;
	local buttonAngle = (menuButtonID - 1) * angleIncrement * ((LunarSphereSettings.buttonSpacing or (100)) / 100)
	local radians = -math.rad(buttonAngle - 90 + (LunarSphereSettings.buttonOffset or (0)) );

	local xDir = (((30 * LunarSphereSettings.sphereScale) + (13 * buttonScale)) * math.cos(radians) + (LunarSphereSettings.buttonDistance or (0)) * math.cos(radians)) / buttonScale
	local yDir = (((30 * LunarSphereSettings.sphereScale) + (13 * buttonScale)) * math.sin(radians) + (LunarSphereSettings.buttonDistance or (0)) * math.sin(radians)) / buttonScale

	-- Grab our menu button, set its location around the sphere
	menuButton = _G["LunarMenu" .. menuButtonID .. "Button"]
	menuButton:SetScale(buttonScale);
	menuButton:ClearAllPoints();
	if LunarSphereSettings.buttonData[menuButtonID].detached then
		menuButton:SetPoint(
			LunarSphereSettings.buttonData[menuButtonID].relativePoint or "CENTER",
			UIparent,
			LunarSphereSettings.buttonData[menuButtonID].relativePoint or "CENTER",
			LunarSphereSettings.buttonData[menuButtonID].xOfs or 0,
			LunarSphereSettings.buttonData[menuButtonID].yOfs or 0);
	else
		menuButton:SetPoint("Center", _G["LSmain"], "Center", xDir, yDir);
	end

	-- Now, if we are not using a menu angle, we have some default angles that the
	-- menu pops out from, as well as the menu angle the buttons go to
	if not (LunarSphereSettings.buttonData[menuButtonID].useMenuAngle) then

		-- Adjust our button's angle around the sphere if it's out of range
		if (buttonAngle + LunarSphereSettings.buttonOffset >= 360) then
			buttonAngle = buttonAngle - 360;
		end

		-- Determine where the button is located in the default angle ID table and adjust
		-- the ID if it's out of range
		buttonAngleID = math.floor((buttonAngle + LunarSphereSettings.buttonOffset) / angleIncrement) + 1
		if (buttonAngleID < 1) then
			buttonAngleID = buttonAngleID + mainButtonCount;
		end
		if (buttonAngleID > mainButtonCount) then
			buttonAngleID = buttonAngleID - mainButtonCount;
		end

		-- Grab the angle the menu shoots off to as well as the menu angle opening position
		menuAngle = math.floor((buttonAngle + LunarSphereSettings.buttonOffset) / 180) * 180;
		menuOffset = menuOffsetY[buttonAngleID];
		if (LunarSphereSettings.buttonData[menuButtonID].useMenuOffset) then
			menuOffset = LunarSphereSettings.buttonData[menuButtonID].menuOffset or 0;
		end

	-- Otherwise, build the menu angle and menu opening offset based upon saved settings
	else
		menuAngle = LunarSphereSettings.buttonData[menuButtonID].menuAngle or 0;
		menuOffset = LunarSphereSettings.buttonData[menuButtonID].menuOffset or 0;
		if (not LunarSphereSettings.buttonData[menuButtonID].useMenuOffset) then
			menuOffset = menuAngle;
		end
	end

	-- Build the menu's opening x and y coordinates and then place it
	xMenuDir = math.cos(math.rad(menuOffset)) * (32);
	yMenuDir = math.sin(math.rad(menuOffset)) * (32);

	-- Cycle through all 12 submenu buttons and reposition them
	for index = 1, 12 do

		-- Grab submenu button
		button = _G["LunarSub" .. ((menuButtonID - 1) * 12 + index + 10) .. "Button"];
		button:ClearAllPoints();
		button:SetScale(childScale);

		-- If the button has padding enabled, grab that data now
		buttonPadding = 0;
		if (LunarSphereSettings.buttonData[button:GetID()].useButtonPadding) then
			buttonPadding = (LunarSphereSettings.buttonData[button:GetID()].buttonPadding or (0)) 
		end

		-- Find the x and y coordinates that the button will appear at. If there is padding
		-- on the first submenu button, we add it to the starting position as well
		xDir = math.cos(math.rad(menuAngle)) * (buttonSpacing + buttonPadding);
		yDir = math.sin(math.rad(menuAngle)) * (buttonSpacing + buttonPadding);
		if (buttonPadding > 0) then
			xMenuDir = math.cos(math.rad(menuOffset)) * (32 + buttonPadding);
			yMenuDir = math.sin(math.rad(menuOffset)) * (32 + buttonPadding);
		end

		-- Position the button in reference to the menu button if it's the first submenu button,
		-- or position the button in reference to the previous submenu button
		if (index == 1) then
			button:SetPoint("CENTER", menuButton, "CENTER", xMenuDir, yMenuDir);
		else
			button:SetPoint("CENTER", _G["LunarSub" .. (button:GetID() - 1) .. "Button"], "CENTER", xDir, yDir);
		end
	end
end

function Lunar.Button:FixMenus()

	local index, clickType, clickTypeMenu, stance, buttonType, blankButtonString;
	blankButtonString = string.rep("000", 39);

	-- Repair any broken menus that might appear
	if (LunarSphereSettings.buttonData[1]) then
		for index = 1, 130 do
			if (LunarSphereSettings.buttonData[index]) then
				if not (LunarSphereSettings.buttonData[index].empty) then
					for clickType = 1, 3 do 
						clickTypeMenu = nil;
						for stance = Lunar.Button.defaultStance, 12 do 
							buttonType = Lunar.Button:GetButtonType(index, stance, clickType);
							if (buttonType == 2) and (stance == Lunar.Button.defaultStance) then
								clickTypeMenu = true;
							end
							if (stance > Lunar.Button.defaultStance) then
								if (clickTypeMenu) then
									Lunar.Button:SetButtonData(index, stance, clickType, 2, "spell", "");
								else
									if (buttonType == 2) then
										Lunar.Button:SetButtonType(index, stance, clickType, 0);
									end
								end
							end
						end
					end
				end

				-- If we found an empty button but it wasn't set as empty, mark it now
				if (LunarSphereSettings.buttonData[index].buttonTypeData == blankButtonString) then
					LunarSphereSettings.buttonData[index].empty = true;
				end
			end
		end
	end
end

function Lunar.Button:SetupAsMenu(button, clickType, isActive)

	if (button) and (clickType)  then
		if (button:GetID() > 0) and (button:GetID() <= 10)  then
			if (isActive == nil) then
				isActive = true;
			end
			_G[button:GetName() .. "Header"]:Execute("menuOpen" .. clickType .. " = " .. tostring(isActive));
		end
	end
end

-- /***********************************************
--  * ToggleMenuAutoHide
--  * ========================
--  *
--  * Sets all menu buttons to either automatically hide when the mouse moves away from them, or
--  * stay open until the user closes them
--  *
--  * Accepts: true or false, for whether or not the menus should auto hide
--  * Returns: None
--  *********************
function Lunar.Button:ToggleMenuAutoHide()

	local index, menuHeader;
	for index = 1, 10 do 

		menuHeader = _G["LunarMenu" .. index .. "ButtonHeader"];

		menuHeader:Execute("useMenuDelay = nil; menuDelay = nil; useSubmenuClose = nil");
		if (LunarSphereSettings.buttonData[index].menuUseSubmenuClose) then
			menuHeader:Execute("useSubmenuClose = true");
		end

		UnregisterAutoHide(_G["LunarSub" .. ((index * 12) - 1) .. "Button"]);

		-- Click to open, click to close
		if ((LunarSphereSettings.buttonData[index].menuType == nil) or (LunarSphereSettings.buttonData[index].menuType == 1)) then
			menuHeader:Execute("menuType = 'open'");

		-- Hover to open, leave to close
		elseif (LunarSphereSettings.buttonData[index].menuType == 2) then
			menuHeader:Execute("useMenuDelay = true; menuDelay = 0.5");
			menuHeader:Execute("menuType = 'enter';	updateMenuOpening = true; toggle = true; control:RunAttribute('_onclick'); updateMenuOpening = nil;");

		-- Always open, never closed
		elseif (LunarSphereSettings.buttonData[index].menuType == 3) then
			menuHeader:Execute("menuType = 'always'; updateMenuOpening = true; toggle = false; control:RunAttribute('_onclick'); updateMenuOpening = nil;");
		end

		-- Delay handling
		if (LunarSphereSettings.buttonData[index].menuUseDelay == 1) and (LunarSphereSettings.buttonData[index].menuType ~= 3) then
			menuHeader:Execute("useMenuDelay = true; menuDelay = " .. LunarSphereSettings.buttonData[index].menuDelay or ('3'));
		end
	end
end

function Lunar.Button:ToggleKeybinds()
	local hide = LunarSphereSettings.hideKeybinds
	local index, visibleFunction, button;
	if (hide == true) then
		for index = 1, 10 do
			_G["LunarMenu" .. index .. "ButtonHotKey"]:Hide()
		end
		for index = 11, 130 do
			_G["LunarSub" .. index .. "ButtonHotKey"]:Hide()
		end
	else
		for index = 1, 10 do
			_G["LunarMenu" .. index .. "ButtonHotKey"]:Show()
		end
		for index = 11, 130 do
			_G["LunarSub" .. index .. "ButtonHotKey"]:Show()
		end
	end
end

-- /***********************************************
--  * AssignmentUpdate
--  * ========================
--  *
--  * Used for assigning new actions to a button, to prevent the user from accidently using
--  * an item they just assigned.
--  *
--  * Accepts: None
--  * Returns: None
--  *********************
function Lunar.Button:AssignmentUpdate()

	-- Find out the button click
	local clickType = 1;
	if (Lunar.Button.updateClick == "RightButton") then
		clickType = 2;
	elseif (Lunar.Button.updateClick == "MiddleButton") then
		clickType = 3;
	end

	-- Assign the button with whatever is currently on the cursor
	if (LunarSphereSettings.buttonEditMode == true) or (LunarSphereSettings.forceDragDrop == true) then
		Lunar.Button:Assign(Lunar.Button.updateButton, clickType);
	end

	-- Wipe the reference to the button and stop the updating events
	Lunar.Button.updateButton = nil;
	Lunar.Button.updateClick = nil;
	Lunar.Button.updateFrame:SetScript("OnUpdate", nil);
end

-- /***********************************************
--  * Create
--  * ========================
--  *
--  * Creates a new button
--  *
--  * Accepts: name of button, parent to attach button to
--  * Returns: the new button
--  *********************
function Lunar.Button:Create(name, parent, includeHeader)

	-- If no parent was specified, we attach to the main UI. Otherwise,
	-- we just use the specified parent
	if (parent == nil) then
		parent = _G["UIParent"];
	else
		parent = _G[parent];
	end

	-- Increase our button counter
	buttonCount = buttonCount + 1;
	Lunar.Button.buttonCount = Lunar.Button.buttonCount + 1;

	-- Setup our locals
	local background, highlight, pushed, checked, icon, border, count;

	-- If this button doesn't have a save entry yet, add it
	if (not LunarSphereSettings.buttonData[buttonCount]) then
		LunarSphereSettings.buttonData[buttonCount] = {};
		Lunar.Button:ResetButtonData(buttonCount);
	end

	-- Create our locals, create the name of the button, and create the button
	local name = "Lunar" .. name .. "Button";
	local button;
	if (includeHeader) then
		button = CreateFrame("CheckButton", name, parent, "SecureActionButtonTemplate, ActionButtonTemplate, SecureHandlerClickTemplate, SecureHandlerStateTemplate, SecureHandlerEnterLeaveTemplate");
	else
		button = CreateFrame("CheckButton", name, parent, "SecureActionButtonTemplate, ActionButtonTemplate"); --, SecureHandlerClickTemplate, SecureHandlerEnterLeaveTemplate, SecureHandlerShowHideTemplate, ActionButtonTemplate")
	end

	-- Make our new button accept mouse clicks
	button:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up");
	button:RegisterForDrag("LeftButton", "MiddleButton", "RightButton", "Button4", "Button5")
	button:SetClampedToScreen(true);
	button:SetMovable(true);
	button:SetAttribute("checkselfcast", true);
	button:SetAttribute("checkfocuscast", true);

-- Add an "*" before the statebuttons above to activate modifiers

	-- Make the hit rectangle smaller so the player doesn't accidently click on
	-- another button nearby
	button:SetHitRectInsets(3, 3, 3, 3);

	button:SetScript("OnUpdate", nil);
	button:SetScript("OnShow", nil);

	button:SetScript("OnMouseUp", Lunar.Button.OnMouseUp); 
	button:SetScript("PostClick", Lunar.Button.PostClick);
	button:SetScript("OnDragStart", Lunar.Button.OnDragStart);
	button:SetScript("OnDragStop", Lunar.Button.OnDragStop);
	button:SetScript("OnReceiveDrag", Lunar.Button.OnReceiveDrag);
	button:SetScript("OnEnter", Lunar.Button.OnEnter);
	button:SetScript("OnLeave", Lunar.Button.OnLeave);
	button.enableMouseMotion = true;
	button:SetScript("OnEvent", Lunar.Button.OnEvent);
	button:RegisterEvent("PLAYER_ENTERING_WORLD");

	-- Store a reference to many parts of the button, for easy finding later
	-- (may remove some as time goes on)
	background = button:GetNormalTexture();
	highlight = button:GetHighlightTexture();
	pushed = button:GetPushedTexture();
	checked = button:GetCheckedTexture();
	icon = _G[name.."Icon"];
	border = _G[name.."Border"];
	count = _G[name.."Count"];

	button.texture = icon;

	button.readyShine = _G[name .. "Cooldown"];
	button.readyShine:ClearAllPoints();
	button.readyShine:SetPoint("Center", 0, -1);
	button.readyShine:SetWidth(22);
	button.readyShine:SetHeight(22);
	button.readyShine:SetAlpha(1);

	button.cooldown = button:CreateTexture("BACKGROUND");
	button.cooldown:SetTexture(LUNAR_ART_PATH .. "background");
	button.cooldown:SetWidth(25);
	button.cooldown:SetHeight(25);
	button.cooldown:SetAlpha(1);
	button.cooldown:SetVertexColor(0,0,0);

--	drawEdge
	button.cooldown:SetPoint("CENTER", button, "CENTER");
	SetPortraitToTexture(button.cooldown, button.cooldown:GetTexture());
	button.cooldown:Hide();

	button.procGlow = button:CreateTexture("BACKGROUND");

	button.procGlow:SetTexture("Interface\\Cooldown\\starburst");
	button.procGlow:SetWidth(38);
	button.procGlow:SetHeight(38);
	button.procGlow:SetPoint("CENTER", button, "CENTER");
	button.procGlow:SetBlendMode("ADD");
	button.procGlow:SetVertexColor(1,1,0);
	button.procGlow:Hide();

	local fontPath = count:GetFont();
	count:SetFont(fontPath, 11, "OUTLINE");

	_G[name.."HotKey"]:SetWidth(48);
	_G[name.."HotKey"]:ClearAllPoints();
	_G[name.."HotKey"]:SetPoint("Topright", button, "Topright", 2, -2);

	-- Setup our button textures
	if (LunarSphereSettings.buttonSkin) then

		button:SetPushedTexture(LUNAR_ART_PATH .. "buttonSkin_" .. LunarSphereSettings.buttonSkin .. ".blp");
		button:SetNormalTexture(LUNAR_ART_PATH .. "buttonSkin_" .. LunarSphereSettings.buttonSkin .. ".blp");
	else
		button:SetPushedTexture(LUNAR_ART_PATH .. "buttonSkin_1.blp");
		button:SetNormalTexture(LUNAR_ART_PATH .. "buttonSkin_1.blp");
	end
	button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
	button:SetCheckedTexture(LUNAR_ART_PATH .. "highlight_circle.blp");
	button:GetCheckedTexture():SetVertexColor(1,1,0,1);
	button:GetCheckedTexture():SetBlendMode("ADD");


	-- Resize our background and center it in the proper location
	background:ClearAllPoints();
	background:SetWidth(32);
	background:SetHeight(32);
	background:SetPoint("CENTER", 0, 0);

	-- Resize and setup our border texture (mainly for checked buttons)
	border:SetTexture(checked:GetTexture());
	border:ClearAllPoints();
	border:SetPoint("CENTER", 0, -1);
	border:SetWidth(32);
	border:SetHeight(32);

	-- Resize our pushed graphic and center it in the proper location
	pushed:ClearAllPoints();
	pushed:SetWidth(32);
	pushed:SetHeight(32);
	pushed:SetPoint("CENTER", 0, 0);

	-- Recenter our highlight and checked textures
	highlight:ClearAllPoints();
	highlight:SetPoint("CENTER", 0, -1); ---1);
	checked:ClearAllPoints();
	checked:SetPoint("CENTER", 0, -1); ---1);

	-- Set our button's default icon, make it round, make it transparent a little bit, resize
	-- and then center it where it needs to go
	icon:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background");
	SetPortraitToTexture(icon, icon:GetTexture());
	icon:SetAlpha(0.5);
	icon:ClearAllPoints();
	icon:SetWidth(25);
	icon:SetHeight(25);
	icon:SetPoint("CENTER", button, "CENTER", 0, 0);

	-- Make sure it doesn't automatically raise it's frame level
	-- when clicked (incase multiple buttons are near each other
	-- and, well, start taking over screen real estate)
	button:SetToplevel(false);

	button.cooldownText = button:CreateFontString("", "OVERLAY")
	button.cooldownText:SetPoint("CENTER")
	button.cooldownText:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
	button.cooldownText:SetTextColor(1, 1, 0.2)
	button.cooldownText:SetText("30")
	button.cooldownText:Hide()

	-- Create the shine image for the button and hide it until it's needed
	button.shine = button:CreateTexture(button:GetName() .. "Shine");
	button.shine:SetTexture(LUNAR_ART_PATH .. "shine_1.blp");
	button.shine:SetWidth(25);
	button.shine:SetHeight(25);
	button.shine:SetPoint("CENTER", button, "CENTER", 0, 0);
	button.shine:Hide()

	-- Hide our item count text
	count:SetText("");
	count:Hide();

	-- Remember it's unique ID (for saving purposes)
	button:SetID(buttonCount);

	button.currentStance = Lunar.Button.defaultStance;

	-- Add the button to its parent
	button:SetAttribute('_childupdate',
		[[ -- (self, stateid, newstate)
			local state = message;
			local actionType, actionName
			local i, actionFound, keybind, petButton;
			-- Update the current actions
			self:ClearBindings();

			for i = 1, 3 do 
				actionType = self:GetAttribute("*type-S" .. state .. i);
				self:SetAttribute("*spell" .. i, "");
				self:SetAttribute("*action" .. i, "");
				self:SetAttribute("*item" .. i, "");
				self:SetAttribute("*macro" .. i, "");
				self:SetAttribute("*macrotext" .. i, "");
				self:SetAttribute("unit" .. i, "");
				self:SetAttribute("target-slot" .. i, "");
				if (editMode ~= true) and (actionType) and (actionType ~= "none") then
					if (actionType == "pet") then
						petButton = true;
						actionName = self:GetAttribute("*action-S" .. state .. i);
						self:SetAttribute("*type" .. i, actionType);
						self:SetAttribute("*action" .. i, actionName);
						self:SetAttribute("shift-type" .. i, "macro");
					elseif (actionType == "flyout") then
						actionName = self:GetAttribute("*spell-S" .. state .. i);
						self:SetAttribute("*type" .. i, "flyout");
						self:SetAttribute("*spell" .. i, actionName);
					else
						actionName = self:GetAttribute("*" .. actionType .. "-S" .. state .. i);
						actionName2 = self:GetAttribute("*" .. actionType .. "2-S" .. state .. i);
						if (actionType == "macrotext") then
							self:SetAttribute("*type" .. i, "macro");
						else
							self:SetAttribute("*type" .. i, actionType);
						end
						if (actionName2) then
							self:SetAttribute("*" .. actionType .. i, actionName2);
						else
							self:SetAttribute("*" .. actionType .. i, actionName);
						end
					end
					self:SetAttribute("unit" .. i, self:GetAttribute("unit-S" .. state .. i));
					self:SetAttribute("target-slot" .. i, self:GetAttribute("target-slot-S" .. state .. i));
				else
					self:SetAttribute("*type" .. i, "spell");
				end
			end

			keybind = self:GetAttribute("bindings-S0");
			if (keybind) then
				local bind1, bind2, bind3 = string.match(keybind, "(.*);(.*);(.*);")
				local tempBind, tempAction, bindCheck;

				if (bind1 and bind1 ~= "") then
					if (GetBonusBarOffset() == 5) then
						-- We check to see if the possess bar or vehicle bar has this bound.
						-- If so, we ignore it as the possess bar and vehicle bar get
						-- 100% elite status.
						for bindCheck = 1, 6 do 
							if (GetBindingKey("ACTIONBUTTON" .. bindCheck) == bind1) then
								bind1 = nil;
								break;
							end
						end
						if (bind1) then
							self:SetBindingClick(true, bind1, self, "LeftButton");
						end
					else
						self:SetBindingClick(true, bind1, self, "LeftButton");
					end
				end
				if (bind2 and bind2 ~= "") then
					if (GetBonusBarOffset() == 5) then
						-- We check to see if the possess bar or vehicle bar has this bound.
						-- If so, we ignore it as the possess bar and vehicle bar get
						-- 100% elite status.
						for bindCheck = 1, 6 do 
							if (GetBindingKey("ACTIONBUTTON" .. bindCheck) == bind2) then
								bind2 = nil;
								break;
							end
						end
						if (bind2) then
							self:SetBindingClick(true, bind2, self, "MiddleButton");
						end
					else
						self:SetBindingClick(true, bind2, self, "MiddleButton");
					end
				end
				if (bind3 and bind3 ~= "") then
					if (GetBonusBarOffset() == 5) then
						-- We check to see if the possess bar or vehicle bar has this bound.
						-- If so, we ignore it as the possess bar and vehicle bar get
						-- 100% elite status.
						for bindCheck = 1, 6 do 
							if (GetBindingKey("ACTIONBUTTON" .. bindCheck) == bind3) then
								bind3 = nil;
								break;
							end
						end
						if (bind3) then
							self:SetBindingClick(true, bind3, self, "RightButton");
						end
					else
						self:SetBindingClick(true, bind3, self, "RightButton");
					end
				end
			end

			if (self:GetID() > 0) then
				
				-- If we had an action, show the button.
				local showState = self:GetAttribute("showstates");

				if (showState) and (string.find(showState, state .. ",")) then
					actionFound = true;
					self:SetWidth(36);
					self:Show();
					if (petButton) and (self:GetID() > 10) and (petAutoShow) then
						if (UnitExists("pet") == nil) then
							self:Hide();
						end
					end
					self:SetAlpha(1);
					if (buttonScale) then
						if (self:GetID() > 10) then
							self:SetScale(childScale);
						else
							self:SetScale(buttonScale);
						end
					end
					if (menuOpen1 or menuOpen2 or menuOpen3) and (toggle ~= true) and (self:GetID() > 10) then
						self:Hide();
					end

				-- Otherwise, we show or hide the button based upon other factors
				else

					local isVisible = true;
					if ((self:GetID() > 10) and (not (menuOpen1 or menuOpen2 or menuOpen3))) or (showState == "!*") then
						isVisible = nil;
					end

					-- If edit mode is on, we don't hide it...	
					if (editMode) and (isVisible) then
				-- Don't submenu buttons if there is no menu button for them...
						self:SetWidth(36);
						self:Show();
						if (buttonScale) then
							if (self:GetID() > 10) then
								self:SetScale(childScale);
							else
								self:SetScale(buttonScale);
							end
						end
					-- If edit mode is off, we do.
					else
						-- If compression mode is on, we compress this button
						self:Hide();
						if (compressButtons) then
							self:SetWidth(4);
							self:SetScale(0.01);
						end
					end
				end

				-- If this is a menu button, we need to show or hide the header as well.
				if (self:GetID() > 0) and (self:GetID() < 10) then
					if (actionFound) or (editMode) then
						self:GetParent():Show();
					else
						self:GetParent():Hide();
					end
				end
			end
		]]
	);

	-- Return our creation
	return button;
end

function Lunar.Button.OnDragStart(self)
-- ~~ Movement
	if LunarSphereSettings.buttonData[self:GetID()].detached and (LunarSphereSettings.detachedMoveable == true) then
		self:StartMoving(); 
	end

	if (Lunar.combatLockdown == false) and (LunarSphereSettings.buttonEditMode == true) then

		-- We have two choices. If the button is one of the 10 main buttons, and it is set
		-- to detach from the sphere, and the detached buttons are able to be moved, we actually
		-- start dragging the button.
		if LunarSphereSettings.buttonData[self:GetID()].detached and (LunarSphereSettings.detachedMoveable == true) then

			-- Start the drag
			self:StartMoving();
		
		-- Otherwise, we simple start the swapping of buttons
		else
			if (Lunar.Button.startSwap) then
				_G[Lunar.Button.swapButton]:UnlockHighlight();
				_G[Lunar.Button.swapButton]:SetChecked(Lunar.Button.oldChecked);
				Lunar.Button.swapButton = false;
				Lunar.Button.oldChecked = false;
				Lunar.Button.startSwap = false;
			end
			Lunar.Button.startSwap = true;
			Lunar.Button.swapButton = self:GetName();
			Lunar.Button.oldChecked = self:GetChecked();
			self:LockHighlight();
			self:SetChecked(true);
			Lunar.Button:ShowEmptyMenuButtons();
		end
	elseif (self.buttonType > 90 and self.buttonType < 95) then
		local bagID = self.buttonType - 90;
		local translatedID = CharacterBag0Slot:GetID() + bagID - 1;
		PickupBagFromSlot(translatedID);
	end
end

function Lunar.Button.OnDragStop(self)

	-- We have two choices. If the button is set to detach from the sphere (index 1 - 10), and the
	-- detached buttons are able to be moved, we actually stop dragging the button and save its location
	-- for the future reloads of the UI
	if LunarSphereSettings.buttonData[self:GetID()].detached and (LunarSphereSettings.detachedMoveable == true) then

		-- Stop moving and save the location data
		self:StopMovingOrSizing();

		local btnID = self:GetID();
		local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint();

		LunarSphereSettings.buttonData[btnID].relativePoint = relativePoint;
		LunarSphereSettings.buttonData[btnID].xOfs = xOfs;
		LunarSphereSettings.buttonData[btnID].yOfs = yOfs;

	-- Otherwise, it's probably just a swap, so let's do that instead
	else
		if (Lunar.Button.swapButton) then
			_G[Lunar.Button.swapButton]:UnlockHighlight();
			_G[Lunar.Button.swapButton]:SetChecked(Lunar.Button.oldChecked);
			Lunar.Button.startSwap = false;
			Lunar.Button.oldChecked = false;
		end
	end
end

function Lunar.Button.OnReceiveDrag(self)

	-- Bag drag check
	if (GetCursorInfo()) then
		if (self.buttonType == 90) then
			local hadItem = PutItemInBackpack();
			if ( hadItem ) then
				return;
			end
		elseif ((self.buttonType > 90) and (self.buttonType <= 94)) then
			local bagID = self.buttonType - 90;
			local translatedID = CharacterBag0Slot:GetID() + bagID - 1;
			local hadItem = PutItemInBag(translatedID);
			if ( hadItem ) then
				return;
			end
		end
	end

	if (Lunar.combatLockdown == false) and ((LunarSphereSettings.buttonEditMode == true) or (LunarSphereSettings.forceDragDrop == true)) then

		-- If we're currently moving a button, take care of that.
		if (Lunar.Button.swapButton) then
			_G[Lunar.Button.swapButton]:UnlockHighlight();
			_G[Lunar.Button.swapButton]:SetChecked(Lunar.Button.oldChecked);
			if (self:GetName() ~= Lunar.Button.swapButton) then
				Lunar.Button:Swap(_G[Lunar.Button.swapButton], self);	
			end
			Lunar.Button.startSwap = false;
			Lunar.Button.swapButton = false;
			Lunar.Button.oldChecked = false;
			Lunar.Button:HideEmptyMenuButtons();
			Lunar.Button:SetTooltip(self);

		-- Otherwise, we continue with (hopefully) a new action drag
		else
			if (GetCursorInfo()) then
				if (IsControlKeyDown()) then
					self:SetAttribute("*type-S01", "spell");
					self:SetAttribute("*spell-S01", "");
					self:SetAttribute("*item-S01", "");
					self:SetAttribute("*macro-S01", "");
					Lunar.Button:ConvertToMenu(self);
					Lunar.Button:SetTooltip(self);
					Lunar.Button:ShowEmptyMenuButtons();
				else
					Lunar.Button.updateType, Lunar.Button.updateID, Lunar.Button.updateData = GetCursorInfo();
					local tempID = Lunar.Button.currentMouseOver;
					Lunar.Button.currentMouseOver = nil;
					Lunar.Button:Assign(self, 1)
					Lunar.Button.currentMouseOver = tempID;
					if (LunarSphereSettings.forceDragDrop) then
						local header;
						if (self:GetID() > 10) then
							header = _G["LunarMenu" .. self.parentID .. "ButtonHeader"];
						elseif (self:GetID() == 0) then
							header = _G["LunarSphereMainButtonHeader"];
						else
							header = _G["LunarMenu" .. self:GetID() .. "ButtonHeader"];
						end
						header:SetAttribute("state-state", header:GetAttribute("state"));
					end
				end
			end
		end
	end
end

function Lunar.Button.OnEnter(self)
	Lunar.Button.currentMouseOver = self:GetID();
	Lunar.Button.currentMouseOverFrame = self;
	Lunar.Button.tooltipStance = nil;
	Lunar.Button:SetTooltip(self);
end

function Lunar.Button.OnLeave(self)
	if (Lunar.Button.currentMouseOver == self:GetID()) then
		Lunar.Button.currentMouseOver = nil;	
		Lunar.Button.currentMouseOverFrame = nil;
	end
	GameTooltip:Hide();
end

function Lunar.Button.OnMouseUp(self, arg1)

	-- If we're not in combat, and the buttons are unlocked, update the button with a
	-- new action if required
	if (Lunar.combatLockdown == false) and ((LunarSphereSettings.buttonEditMode == true) or (LunarSphereSettings.forceDragDrop == true))  then

		-- Check if we were currently swapping a button. If so, signal that we stopped
		-- moving it.
		if (Lunar.Button.swapButton) then
			_G[Lunar.Button.swapButton]:UnlockHighlight();
			_G[Lunar.Button.swapButton]:SetChecked(Lunar.Button.oldChecked);
			Lunar.Button.startSwap = false;
			Lunar.Button.swapButton = false;
			Lunar.Button.oldChecked = false;
			Lunar.Button:HideEmptyMenuButtons();

		-- Otherwise, continue as planned
		else
		
			-- If the control key is down and we right click the button, delete
			-- the button's contents. Only if the Edit Button mode is on (so we
			-- don't delete stuff by accident if the "Force drag and drop assignment"
			-- mode is on
			if (IsControlKeyDown() and (arg1 == "RightButton") and (LunarSphereSettings.buttonEditMode == true)) then

				Lunar.Button:Unassign(self);
				Lunar.Button:SetTooltip(self);
				Lunar.Sphere:ShowSphereEditGlow(LunarSphereSettings.showSphereEditGlow);

			-- If the control key is down and we left click the button, convert it into
			-- a menu
			elseif (IsControlKeyDown() and (arg1 == "LeftButton")) then
				if (GetCursorInfo()) then
					self:SetAttribute("*type-S01", "spell");
					self:SetAttribute("*spell-S01", "");
					self:SetAttribute("*item-S01", "");
					self:SetAttribute("*macro-S01", "");
					Lunar.Button:ConvertToMenu(self);
					Lunar.Button:SetTooltip(self);
					Lunar.Button:ShowEmptyMenuButtons();
				end

			-- If the alt button is down when we click the button, we pop out the button
			-- settings window
				
			-- Otherwise, set our updater to update this button
			else
				if (GetCursorInfo() or (Lunar.Button.updateType) ) then
					local clickType = Lunar.API:ConvertClick(arg1);
					local stance = GetShapeshiftForm();

					--STANCE
					self:SetAttribute("*type-S" .. stance .. clickType, "spell");
					self:SetAttribute("*spell-S" .. stance .. clickType, "");
					self:SetAttribute("*item-S" .. stance .. clickType, "");
					self:SetAttribute("*macro-S" .. stance .. clickType, "");
					Lunar.Button.updateButton = self;
					Lunar.Button.updateType, Lunar.Button.updateID, Lunar.Button.updateData = GetCursorInfo();
					Lunar.Button.updateClick = arg1;
					--OLD
					--Lunar.Button.updateFrame:SetScript("OnUpdate", function () Lunar.Button:AssignmentUpdate() end);
					Lunar.Button.updateFrame:SetScript("OnUpdate", Lunar.Button.AssignmentUpdate);
				else
					if (LunarSphereSettings.buttonEditMode == true) then
						if (Lunar.Settings.buttonEdit ~= self:GetID()) then
							Lunar.Settings.ButtonDialog:Hide();
							Lunar.Settings.buttonEdit = self:GetID();
							Lunar.Settings.ButtonDialog:Show();
						else
							Lunar.Settings.ButtonDialog:Hide();
						end;
					end
				end
			end
		end
	end
end

function Lunar.Button.PostClick(self, arg1)

	-- Make the button unchecked
	if (self:GetID() > 0) then
		self:SetChecked(false);
	end

	if (LunarSphereSettings.buttonEditMode == true) then
		return;
	end

	local stance = self.currentStance or Lunar.Button.defaultStance;
	local buttonType, actionType, actionName = Lunar.Button:GetButtonData(self:GetID(), stance, Lunar.API:ConvertClick(arg1));

	-- Now, if it is an item button, and it is currently equiped, mark it as checked
	-- (so we have more green!)
	if (self:GetID() > 0) then
		if (actionType == "item") then
			if (IsEquippedItem(actionName)) then
				if (self.actionType == actionType) and (self.actionName == actionName) then
					self:SetChecked(true);
				end
			end
		end
	end

	-- Check if this button is a submenu button. If it is, check if it's parent menu button
	-- has the button type of 3 assigned to one of the clicks. If so, we update that menu
	-- button's actions and icon
	if (LunarSphereSettings.buttonData[self:GetID()].child == true) then
		local clickType, menuButton, buttonType

		-- click 1 check

		local lastActionFound;
		for clickType = 1, 3 do

			-- If we found a match, add this button's data to the menu button's data
			buttonType = Lunar.Button:GetButtonData(self.parentID, stance, clickType)
			if (buttonType == 3) or (buttonType == 4) then
				menuButton = _G["LunarMenu" .. self.parentID .. "Button"];
				if not lastActionFound then
					menuButton.stance = stance;
					menuButton.clickType2 = menuButton.clickType;
					menuButton.childID2 = menuButton.childID;
					menuButton.clickType = Lunar.API:ConvertClick(arg1);
					menuButton.childID = self:GetID();
					lastActionFound = true;
				end
				if (Lunar.combatLockdown == true) then
					menuButton.useLastSubmenu = true;
				else
					if (buttonType == 3) and (menuButton.childID) then
						Lunar.Button:UpdateLastUsedSubmenu(menuButton, _G["LunarSub" .. menuButton.childID .. "Button"], menuButton.clickType);
					end
					if (buttonType == 4) and (menuButton.childID2) then
						Lunar.Button:UpdateLastUsedSubmenu(menuButton, _G["LunarSub" .. menuButton.childID2 .. "Button"], menuButton.clickType2, 4);
					end
				end
				--break;
			end
		end
--]]
	end

	-- Next, if the button type is 10 or higher, it's time to call the special clicking
	-- events
	if (buttonType == 3) and (self.subButtonType) then
		buttonType = self.subButtonType;
	elseif (buttonType == 4) and (self.subButtonType2) then
		buttonType = self.subButtonType2;
	end

	if (buttonType) then
		if (buttonType >= 10) and not ((self:GetID() == 0) and (IsControlKeyDown())) then
			if (buttonType >= 110) and (buttonType < 120) then
				if (Lunar.Button.tradingStage ~= 3) then
					if not Lunar.Button.tradingQueue then
						Lunar.Button.tradingQueue = {};
					end
					table.insert(Lunar.Button.tradingQueue, actionName);
				end
			end
			if (buttonType >= 80) and (buttonType < 90) then
				Lunar.Items:UpdateLowHighItems();
			end
			if (buttonType == 132) then
				Lunar.Items:UpdateLowHighItems();
			end
			Lunar.Button:ButtonTypeClick(buttonType);
		end
	end

	if (self:GetID() > 0) and (self:GetID() <= 10) then
		LunarSphereSettings.buttonData[self:GetID()].menuOpen = _G[self:GetName() .. "Header"]:GetAttribute("toggle");
	end
end

function Lunar.Button:GetButtonData(buttonID, stance, clickType, useCached)
	
	if (not buttonID) or (not stance) or (not clickType) or (clickType == 0) or (clickType > 3) then
		return nil;
	end

	-- If we grab data from a stance that doesn't exist or have anything assigned,
	-- we need to just grab from stance 0;
	if (not Lunar.Button:GetButtonType(buttonID, stance, clickType, useCached)) then
		return;
	end
	
	local buttonData, buttonTexture, actionName, actionType, buttonType;
	local preString, postString = Lunar.Button:GetPrePostString(stance, clickType);
	local searchString = preString .. "(.*)" .. postString;

	if (searchString) then

		if (not useCached) then
			buttonData = LunarSphereSettings.buttonData[buttonID].actionData;
			buttonTexture = LunarSphereSettings.buttonData[buttonID].actionTexture;
			buttonType = LunarSphereSettings.buttonData[buttonID].buttonTypeData;
		else
			buttonData = Lunar.Button.cached_actionData;
			buttonTexture = Lunar.Button.cached_actionTexture;
			buttonType = Lunar.Button.cached_buttonTypeData;
		end				
		
		if (buttonData) then
			buttonData = string.match(buttonData, searchString);
			if (buttonData) then
				actionType, actionName = string.match(buttonData, "(%l)(.*)");
				if (actionType) then
					actionType = Lunar.Button.typeData[actionType];
				end
			end
		end

		if (buttonTexture) then
			buttonTexture = string.match(buttonTexture, searchString)
			if (buttonTexture == " ") then
				buttonTexture = nil;
			end
		end

		if (buttonType) then
			buttonType = tonumber(string.sub(buttonType, ((stance * 9) + (clickType - 1) * 3) + 1, ((stance * 9) + (clickType * 3))));
			if (buttonType == 0) then
				buttonType = nil;
			end
		end
	end

	return buttonType, actionType, actionName, buttonTexture;
end

function Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, actionType, actionName, buttonTexture, useCached)

--	print("Lunar.Button:SetButtonData (2030): ", buttonID, stance, clickType, buttonType, actionType, actionName, buttonTexture, useCached)

	-- Stop now if we have invalid data
	if (not buttonID) or (not stance) or (not clickType) or (not buttonType) then
		return nil;
	end

	-- Assign the button type
	if (buttonType) then
		Lunar.Button:SetButtonType(buttonID, stance, clickType, buttonType, useCached);
	end

	-- Assign the actionType and actionName
	if (actionType) then
		Lunar.Button:SetData(buttonID, stance, clickType, "actionData", actionType, actionName, useCached);
	end

	-- Assign the actionTexture
	if (buttonTexture) then

		-- If the buttonTexture happens to become a table (i.e., targets the player
		-- portrait) ... we make it nothing. We don't want that.
		if (type(buttonTexture) == "table") then
			buttonTexture = " ";
		end

		Lunar.Button:SetData(buttonID, stance, clickType, "actionTexture", buttonTexture, nil, useCached);
	end
end

function Lunar.Button:SetData(buttonID, stance, clickType, dataEntry, arg1, arg2, useCached)

	-- Stop now if we have invalid data
	if (not buttonID) or (not stance) or (not clickType) or (not dataEntry) then
		return nil;
	end

	-- If we're doing button type data, proceed through a different route
	if dataEntry == "buttonTypeData" then
		Lunar.Button:SetButtonType(buttonID, stance, clickType, arg1, useCached);
		return;
	end

	-- Since I haven't finished stance-specific keybinds, we pull from and set all keybinds
	-- to the stance 0 entries.
	if (dataEntry == "keybindData") then
		stance = 0;
	end

	-- Create our locals and grab our search string data
	local buttonData;
	local preString, postString = Lunar.Button:GetPrePostString(stance, clickType);
	local searchString = preString .. "(.*)" .. postString;

	-- If we're doing "actionData" then combine our arguments
	if (dataEntry == "actionData") then

		-- arg2 represents the actionName. If we don't have an arg2, make
		-- it blank (a space)
		if (not arg2) or (arg2 == "")  then
			arg2 = " "
		end

		-- Now convert arg1 into a combination of actionType (what it stands
		-- for) and the arg2 (actionName) so we can dump it into the database
		if (arg1) and (arg1 ~= "") then
			arg1 = Lunar.Button.typeData[arg1] .. arg2;
		else
			arg1 = arg2;
		end
	end

	if (dataEntry == "actionTexture") or (dataEntry == "keybindData") then
		if arg1 == "" then
			arg1 = " ";
		end
	end

	arg1 = preString .. arg1 .. postString;

	if (not useCached) then
		-- If the dataEntry doesn't yet, create it
		if (not LunarSphereSettings.buttonData[buttonID][dataEntry]) then
			LunarSphereSettings.buttonData[buttonID][dataEntry] = "";
		end

		-- If the data for this stance doesn't exist yet, add it
		if not (string.find(LunarSphereSettings.buttonData[buttonID][dataEntry], preString)) then
			LunarSphereSettings.buttonData[buttonID][dataEntry] = LunarSphereSettings.buttonData[buttonID][dataEntry] .. Lunar.Button:CreateBlankStanceData(stance);
		end

		-- Now, substitute our new data in place of the old data
		LunarSphereSettings.buttonData[buttonID][dataEntry] = string.gsub(LunarSphereSettings.buttonData[buttonID][dataEntry], searchString, arg1);
	else
		-- If the dataEntry doesn't yet, create it
		if (not Lunar.Button["cached_" .. dataEntry]) then
			Lunar.Button["cached_" .. dataEntry] = "";
		end

		-- If the data for this stance doesn't exist yet, add it
		if not (string.find(Lunar.Button["cached_" .. dataEntry], preString)) then
			Lunar.Button["cached_" .. dataEntry] = Lunar.Button["cached_" .. dataEntry] .. Lunar.Button:CreateBlankStanceData(stance);
		end

		-- Now, substitute our new data in place of the old data
		Lunar.Button["cached_" .. dataEntry] = string.gsub(Lunar.Button["cached_" .. dataEntry], searchString, arg1);
	end
end

function Lunar.Button:GetButtonKeybind(buttonID, stance, clickType, useCached)
	
	if (not buttonID) or (not stance) or (not clickType) or (clickType == 0) then
		return nil;
	end

	-- I haven't added stance specific keybind support yet, so we will always get
	-- from stance 0;
	stance = 0;

	local keybindData, keybind;
	local preString, postString = Lunar.Button:GetPrePostString(stance, clickType);
	local searchString = preString .. "(.*)" .. postString;

	if (searchString) then

		if (not useCached) then
			keybindData = LunarSphereSettings.buttonData[buttonID].keybindData;
		else
			keybindData = Lunar.Button.cached_keybindData;
		end				
		
		if (keybindData) then
			keybind = string.match(keybindData, searchString);
			if (keybind == " ") then
				keybind = nil;
			end
		end
	end

	return keybind;
end

function Lunar.Button:CreateBlankStanceData(stance)

	local index
	local tempData = "";

	-- Make sure the stance is a 2 digit string
	if (tonumber(stance) < 10) then
		stance = "0" .. tonumber(stance);
	end

	-- Build the stance's blank data and then save it
	for index = 1, 3 do 
		if (index == 3) then
			tempData = tempData .. 	"||" .. stance .. index .. "|| ||" .. stance .. "X|| ";
		else
			tempData = tempData .. 	"||" .. stance .. index .. "|| ";
		end
	end

	return tempData;
end

function Lunar.Button:GetButtonType(buttonID, stance, clickType, useCached)

	if (not buttonID) or (not stance) or (not clickType) then
		return nil;
	end

	local typeID;
	if (not useCached) then
		if (not LunarSphereSettings.buttonData[buttonID].buttonTypeData) then
			return nil;
		end
		typeID = tonumber(string.sub(LunarSphereSettings.buttonData[buttonID].buttonTypeData, ((stance * 9) + (clickType - 1) * 3) + 1, ((stance * 9) + (clickType * 3))));
	else
		if (not Lunar.Button.cached_buttonTypeData) then
			return nil;
		end
		typeID = tonumber(string.sub(Lunar.Button.cached_buttonTypeData, ((stance * 9) + (clickType - 1) * 3) + 1, ((stance * 9) + (clickType * 3))));	
	end

	if (typeID == 0) then
		typeID = nil;
	end

	return typeID;
end

function Lunar.Button:SetButtonType(buttonID, stance, clickType, buttonType, useCached)

	-- Stop now if we have invalid info
	if (not buttonID) or (not stance) or (not clickType) or (not buttonType) then
		return nil;
	end

	-- Convert buttonType into 3 digit string
	if (tonumber(buttonType) < 10) then
		buttonType = "00" .. buttonType;
	elseif (tonumber(buttonType) < 100) then
		buttonType = "0" .. buttonType;
	end

	local tempData ;

	-- If the button's type data doesn't exist, create it, then grab the data
	-- (12 stance support, 3 click types each = 36 entries)
	if not (useCached) then
		if (not LunarSphereSettings.buttonData[buttonID].buttonTypeData) then
			LunarSphereSettings.buttonData[buttonID].buttonTypeData = string.rep("000", 39);
			LunarSphereSettings.buttonData[buttonID].actionData = LunarSphereSettings.buttonData[buttonID].actionData or ""
			LunarSphereSettings.buttonData[buttonID].actionTexture = LunarSphereSettings.buttonData[buttonID].actionTexture or ""
		end
		tempData = LunarSphereSettings.buttonData[buttonID].buttonTypeData;
	else
		if (not Lunar.Button.cached_buttonTypeData) then
			Lunar.Button.cached_buttonTypeData = string.rep("000", 39);
		end
		tempData = Lunar.Button.cached_buttonTypeData;
	end

	-- Based upon if we're editing the start, end, or middle of the button type
	-- data, proceed down the right path.
	if (stance == 0) and (clickType == 1)  then
		tempData = buttonType .. string.sub(tempData, 4);
	elseif (stance == 12) and (clickType == 3) then
		tempData = string.sub(tempData, 1, (13 * 3 - 1) * 3) .. buttonType;
	else
		tempData = string.sub(tempData, 1, ((stance * 9) + (clickType - 1) * 3)) .. buttonType .. string.sub(tempData, ((stance * 9) + (clickType * 3) + 1));
	end

	-- Save our new settings
	if (not useCached) then
		LunarSphereSettings.buttonData[buttonID].buttonTypeData = tempData;
	else
		Lunar.Button.cached_buttonTypeData = tempData;
	end
	
end

function Lunar.Button:GetButtonSetting(buttonID, stance, setting, useCached)

	if (not buttonID) or (not stance) or (not setting) then
		return nil;
	end

	local foundSetting;
	local totalSettings = 7;

	if (not useCached) then
		if (not LunarSphereSettings.buttonData[buttonID].buttonSettings) then
			return nil;
		end
		foundSetting = tonumber(string.sub(LunarSphereSettings.buttonData[buttonID].buttonSettings, (stance * totalSettings) + setting, (stance * totalSettings) + setting));
	else
		if (not Lunar.Button.cached_buttonSettings) then
			return nil;
		end
		foundSetting = tonumber(string.sub(Lunar.Button.cached_buttonSettings, (stance * totalSettings) + setting, (stance * totalSettings) + setting));
	end

	return foundSetting;
end

function Lunar.Button:SetButtonSetting(buttonID, stance, setting, settingValue, useCached)

	-- Stop now if we have invalid info
	if (not buttonID) or (not stance) or (not setting) then
		return nil;
	end

	local tempData ;
	local totalSettings = 7;

	-- If the button's Setting data doesn't exist, create it, then grab the data
	if not (useCached) then
		if (not LunarSphereSettings.buttonData[buttonID].buttonSettings) then
			LunarSphereSettings.buttonData[buttonID].buttonSettings = string.rep("1110000", 13);
		end
		tempData = LunarSphereSettings.buttonData[buttonID].buttonSettings;
	else
		if (not Lunar.Button.cached_buttonSettings) then
			Lunar.Button.cached_buttonSettings = string.rep("1110000", 13);
		end
		tempData = Lunar.Button.cached_buttonSettings;
	end

	-- Based upon if we're editing the start, end, or middle of the button type
	-- data, proceed down the right path.
	if (stance == 0) and (setting == 1) then
		tempData = settingValue .. string.sub(tempData, 2); --totalSettings - 1);
	elseif (stance == 12) and (setting == totalSettings) then
		tempData = string.sub(tempData, 1, (13 * totalSettings - 1)) .. settingValue;
	else
		tempData = string.sub(tempData, 1, (stance * totalSettings) + setting - 1) .. settingValue .. string.sub(tempData, ((stance * totalSettings) + setting + 1));
	end

	-- Save our new settings
	if (not useCached) then
		LunarSphereSettings.buttonData[buttonID].buttonSettings = tempData;
	else
		Lunar.Button.cached_buttonSettings = tempData;
	end
end


function Lunar.Button:GetPrePostString(stance, clickType)

	if (tonumber(stance) < 10) then
		stance = "0" .. tonumber(stance);
	end

	local preString = "||" .. stance .. clickType .. "||";
	local postString = "||" .. stance;

	if (clickType == 3) then
		postString = postString .. "X|| ";
	else
		postString = postString .. (clickType + 1) .. "||";	
	end

	return preString, postString;

end

function Lunar.Button:UpdateLastUsedSubmenu(menuButton, childButton, clickType, secondToLast)

	if (not menuButton) or (not childButton) or (not clickType)   then
		return;
	end

	local stance = menuButton.stance;

	local attributeType, attributeValue, attributeValue2, updateClick;
	if (Lunar.Button:GetButtonType(childButton:GetID(), stance, clickType)) then
		attributeType = childButton:GetAttribute("*type-S" .. stance .. clickType);

		if (attributeType) then

			attributeValue = childButton:GetAttribute("*"..attributeType .. "-S" .. stance .. clickType);
			attributeValue2 = childButton:GetAttribute("*" .. attributeType .. "2-S" .. stance .. clickType);
			if (attributeValue ~= "") then

				local buttonType, actionType, actionName, buttonTexture;
				
				for updateClick = 1, 3 do

					buttonType = Lunar.Button:GetButtonType(menuButton:GetID(), stance, updateClick);

					if (buttonType == (secondToLast or 3) ) then
						
						menuButton:SetAttribute("*type-S" .. stance .. updateClick, attributeType);
						menuButton:SetAttribute("*" .. attributeType .. "-S" .. stance .. updateClick, attributeValue);
						menuButton:SetAttribute("*" .. attributeType .. "2-S" .. stance .. updateClick, attributeValue2);
						
						buttonType,_,_,buttonTexture = Lunar.Button:GetButtonData(childButton:GetID(), stance, clickType);
						if (secondToLast) then
							menuButton.subButtonType2 = buttonType;
						else
							menuButton.subButtonType = buttonType;
						end

						if (buttonType == 5) then
							menuButton:SetAttribute("unit-S" .. stance .. updateClick, "player");
						elseif (buttonType == 6) then
							menuButton:SetAttribute("unit-S" .. stance .. updateClick, "focus");
						else
							menuButton:SetAttribute("unit-S" .. stance .. updateClick, "");
						end

						if (buttonType > 51) and (buttonType < 60) then
							if (math.fmod(buttonType, 2) == 0) then
								menuButton:SetAttribute("target-slot-S" .. stance .. updateClick, GetInventorySlotInfo("MainHandSlot"));
							else
								menuButton:SetAttribute("target-slot-S" .. stance .. updateClick, GetInventorySlotInfo("SecondaryHandSlot"));
							end

						-- Weapon Apply types
						elseif (buttonType >= 112) and (buttonType < 130) then
							if (buttonType == 120) then
								menuButton:SetAttribute("target-slot-S" .. stance .. updateClick, GetInventorySlotInfo("MainHandSlot"));
							elseif (buttonType == 121) then
								menuButton:SetAttribute("target-slot-S" .. stance .. updateClick, GetInventorySlotInfo("SecondaryHandSlot"));
							elseif (buttonType == 122) then
								menuButton:SetAttribute("target-slot-S" .. stance .. updateClick, GetInventorySlotInfo("RangedSlot"));
							end
						else
							menuButton:SetAttribute("target-slot-S" .. stance .. updateClick, "");
						end

						-- Handle pet actions (these are a little different)
						if (buttonType >= 140) and (buttonType < 150) then
	--						attributeType = "pet"
							attributeValue = buttonType - 139;
							menuButton:SetAttribute("*type-S" .. stance .. updateClick, "pet");
							menuButton:SetAttribute("*action-S" .. stance .. updateClick, attributeValue);
						end

						if (updateClick == Lunar.Button:GetButtonSetting(menuButton:GetID(), stance, LUNAR_GET_SHOW_ICON)) then
							if (buttonType == 100) then
								SetPortraitTexture(_G[menuButton:GetName() .. "Icon"], "player");
								buttonTexture = "portrait";
							else
								_G[menuButton:GetName() .. "Icon"]:SetTexture(buttonTexture);
								SetPortraitToTexture(_G[menuButton:GetName() .. "Icon"], _G[menuButton:GetName() .. "Icon"]:GetTexture());
							end
						end

						Lunar.Button:SetButtonData(menuButton:GetID(), stance, updateClick, (secondToLast or 3), attributeType, attributeValue, buttonTexture);
	--					LunarSphereSettings.buttonData[menuButton:GetID()]["actionType" .. updateClick] = attributeType;
	--					LunarSphereSettings.buttonData[menuButton:GetID()]["actionName" .. updateClick] = attributeValue;
	--					LunarSphereSettings.buttonData[menuButton:GetID()]["texture" .. updateClick] = LunarSphereSettings.buttonData[childButton:GetID()]["texture" .. clickType];

						if (updateClick == Lunar.Button:GetButtonSetting(menuButton:GetID(), stance, LUNAR_GET_SHOW_COUNT)) then
							_G[menuButton:GetName() .. "Count"]:Hide();
							LunarSphereSettings.buttonData[menuButton:GetID()].showCount = false;
							if (buttonType >= 90) and (buttonType < 100) then
								Lunar.Button:UpdateBagDisplay(menuButton, stance, updateClick);
							elseif (attributeType == "item") then
								local objectType, stackTotal
								_,_,_,_,_,objectType,_,stackTotal = GetItemInfo(attributeValue);

								if (IsConsumableItem(attributeValue) or (stackTotal > 1) or (objectType == Lunar.Items.reagentString)) then
									_G[menuButton:GetName() .. "Count"]:SetText(GetItemCount(attributeValue, nil, true));

									if (not LunarSphereSettings.showAssignedCounts == true) then
										_G[menuButton:GetName() .. "Count"]:Show();
										LunarSphereSettings.buttonData[menuButton:GetID()].showCount = true;
									end
								end
							end
						end

					end
				end
			end

			menuButton.buttonType = nil;
			Lunar.Button:Update(menuButton);
			Lunar.Button:UpdateSpellState(menuButton);

			_G[menuButton:GetName() .. "Header"]:SetAttribute("state-state", _G[menuButton:GetName() .. "Header"]:GetAttribute("state"));

		end

	end

	menuButton.useLastSubmenu = nil;
--	menuButton.clickType = nil;
--	menuButton.childID = nil;
	menuButton.buttonType = nil;

end

function Lunar.Button:ContinueTrade()

	-- Needs refresh for each item
	if table.getn(Lunar.Button.tradingQueue) > 0 then
		local index, bagID, slotID, count, totalCount, stackSize, itemCount;
		local tradeSlot = 1;
		local totalStacks = 0;
		local stacksToTrade = LunarSphereSettings.stackTradeTotal or (1) ;

		-- Run through each item in the trading queue (I doubt we'll ever have more that
		-- one item though ...
		for itemIndex = 1, table.getn(Lunar.Button.tradingQueue) do

			-- Reset the count of this item being traded
			totalCount = 0;
			itemCount = GetItemCount(Lunar.Button.tradingQueue[1]) or (0);

			-- If we have this item, continue
			if (itemCount > 0) then
			
				-- While we have free trade slots, continue
				while (tradeSlot < 7) do 
					
					-- If this slot is free, continue
					if not GetTradeTargetItemInfo(tradeSlot) then
						
						-- Get the next bag/slot ID of the item to be traded, along with
						-- the count of that item in the slot. If it exist, continue
						bagID, slotID, count, stackSize = Lunar.API:GetItemBagInfo(Lunar.Button.tradingQueue[1]);
						if (bagID) then

							-- If the count + total amount trades so far is larger than the
							-- stack size of the item (we only trade a maximum of the
							-- stack size), we cut down the count of the item we will grab
--							if (count + totalCount > stackSize) then
--								count = stackSize - totalCount
--							end
--
--							-- Update the total count we are trading
--							totalCount = totalCount + count;

							-- We assume that each stack selected will be the max
							-- stack size (so we trade the right amount, or a little less,
							-- since we can't split stacks and trade them at this time)
							totalCount = totalCount + stackSize;
							totalStacks = totalStacks + 1;

							-- Pickup the item and drop it into the trade window
							SplitContainerItem(bagID, slotID, count); 
	--						PickupContainerItem(bagID, slotID);
							ClickTradeButton(tradeSlot);

							-- If we hit our limit, or ran out of this item, we stop messing
							-- with this item
--							if (totalCount == stackSize) or (totalCount == itemCount) then
--								break;
--							end
							if (totalStacks == stacksToTrade) then
								break;
							end
						else
							break;
						end
					end
					tradeSlot = tradeSlot + 1;
				end
			end

			table.remove(Lunar.Button.tradingQueue, 1);
		end
		
--		PickupContainerItem(0,2);
--		ClickTradeButton(2);
	else
		-- Needs refresh first
		Lunar.Button.tradingStage = 3
--		AcceptTrade();
--		end
	end
	Lunar.Button.tradingStage = 3

--	PickupContainerItem(0,1);
--	ClickTradeButton(1-7);
--	AcceptTrade();
end

function Lunar.Button:ButtonTypeClick(buttonType)

	if (LunarSphereSettings.buttonEditMode == true) then
		return;
	end

	if (buttonType == 90) then
		local hadItem = PutItemInBackpack();
		if ( not hadItem ) then
			ToggleBackpack();
		end
		return;
	end
	if ((buttonType > 90) and (buttonType <= 94)) then
		local bagID = buttonType - 90;
		local translatedID = CharacterBag0Slot:GetID() + bagID - 1;
		local hadItem = PutItemInBag(translatedID);
		if ( not hadItem ) then
			ToggleBag(bagID);
		end
		return;
	end
	if (buttonType == 95) then OpenAllBags(); return; end;
	if (buttonType == 96) then ToggleKeyRing(); return; end;
	if (buttonType == 100) then ToggleCharacter("PaperDollFrame"); return; end;
	if (buttonType == 101) then return; end;
		-- Can't use ToggleSpellBook, it introduces taint and doesn't work with securecall ...
--[[
		if (SpellBookFrame:IsVisible()) then
			SpellBookFrame:Hide();
		else
			SpellBookFrame:Show();
		end
		return;
	end
--]]

	if (buttonType == 102) then ToggleTalentFrame(); return; end;
-- Croq Updated 	if (buttonType == 103) then ToggleFrame(QuestLogFrame); return; end;
	if (buttonType == 104) then ToggleGuildFrame(); return; end; --ToggleFriendsFrame(); return; end;
	if (buttonType == 105) then ToggleLFDParentFrame(); return; end;
	if (buttonType == 106) then ToggleFrame(GameMenuFrame); return; end;
	if (buttonType == 107) then ToggleHelpFrame(); return; end;
	if (buttonType == 108) then ToggleAchievementFrame(); return; end;
--	if (buttonType == 109) then TogglePVPFrame(); return; end;
	-- Croq Updated to PVEFrame_ToggleFrame("PVPUIFrame", HonorFrame)
	if (buttonType == 109) then PVEFrame_ToggleFrame("PVPUIFrame", HonorFrame); return; end;

	-- Trade clicks
	if (buttonType >= 110) and (buttonType < 120) then
		if (Lunar.Button.tradingStage == 3) then
			AcceptTrade();
		else
			if UnitExists("target") then
				_G["LSbackground"]:RegisterEvent("TRADE_CLOSED");
				_G["LSbackground"]:RegisterEvent("TRADE_REQUEST_CANCEL");
				_G["LSbackground"]:RegisterEvent("CHAT_MSG_SYSTEM");

				if (TradeFrame:IsShown() and (TradeFrameRecipientNameText:GetText() ~= UnitName("target"))) then
					-- We close the trade window, but the window will reopen when the event
					-- "TRADE_CLOSED" is called, which is our stage 0 flag.
					Lunar.Button.tradingStage = 0;
					CloseTrade();

				-- Or, if the trade window is not open, request the trade.
				elseif not TradeFrame:IsShown() then
					_G["LSbackground"]:RegisterEvent("TRADE_SHOW");
					Lunar.Button.tradingStage = 1;
					InitiateTrade("target");
				-- Otherwise, we just continue with the trade with the same person.
				else
					Lunar.Button.tradingStage = 1;
					Lunar.Button:ContinueTrade();
				end
			end
		end
	end

end

-- /***********************************************
--  * ShowEmptyMenuButtons
--  * ========================
--  *
--  * Shows all menu buttons that are empty (and will be slightly transparent)
--  *
--  * Accepts: none
--  * Returns: none
--  *********************
function Lunar.Button:ShowEmptyMenuButtons(compressionOnly)

	-- If we're not in combat, and our buttons aren't locked, show our buttons (we can't ADD stuff
	-- while in combat, so this is why this exists)
	if (Lunar.combatLockdown == false) and (LunarSphereSettings.buttonEditMode == true) then

		Lunar.Button.hiddenButtons = nil;

		local button;
		local showSubButtons = true;
--		if (this) and (self:GetID() > 0) then
--			if (LunarSphereSettings.buttonData[self:GetID()].isMenu) then
--				showSubButtons = false;
--			end
--		end

		local mainButtonCount = LunarSphereSettings.mainButtonCount;

		if (showSubButtons) then
			
			-- Cycle through all the sub menu buttons first
			local index, subButtonCount, subIndex;
			for index = 11, buttonCount do --110 do 

				-- Grab the button and make sure it's always visible in all states
				button = _G["LunarSub" .. index .. "Button"];

				-- Pet button auto-show/hide disabling
				Lunar.Button:PetButtonCheck(button, index, true);
--				button:SetAttribute("unit","")
--				UnregisterUnitWatch(button);

				if (LunarSphereSettings.buttonData[index].child == true) then

					-- Determine how many submenu buttons are to be shown
					subIndex = math.fmod(index + 1, 12) + 1;
					subButtonCount = LunarSphereSettings.buttonData[math.floor((index - 11) / 12) + 1].subButtonCount or (12);
					if (subIndex <= subButtonCount) then
						button:SetAttribute("showstates", "*");
					else
						button:SetAttribute("showstates", "!*");
					end

					button:SetWidth(36);
					button:SetAttribute("width", 36);
--					button:SetHeight(36);
--					button:SetAttribute("height", 36);

					-- If it states that it is empty, show it with 50% alpha, and make sure
					-- the button width is increased
					if (LunarSphereSettings.buttonData[index].empty == true) then
						button:SetAlpha(0.5);
					else
						button:SetAlpha(1.0);
					end

				end

			end

		end

		_G["LunarSphereMainButtonHeader"]:Execute("editMode = true");

		-- Now cycle through all the menu buttons
		for index = 1, 10 do 

			-- Pet button auto-show/hide disabling
			button = _G["LunarMenu" .. index .. "Button"];
			Lunar.Button:PetButtonCheck(button, index, true);

--			button:SetAttribute("unit","")
--			UnregisterUnitWatch(button);

			Lunar.Button:SetupMenuAngle(index);

			if (index <= mainButtonCount) then
				
				-- Grab the button. If it states that it is empty, show it with 50% alpha
				button:SetAttribute("width", 36);
				button:SetWidth(36);

				_G[button:GetName() .. "Header"]:Execute("editMode = true");

				button:SetAttribute("showstates", "*");

				if (LunarSphereSettings.buttonData[button:GetID()].empty == true) then
					button:SetAlpha(0.5);
					button:Show();
				end

	--			button:SetAttribute("showstates", "*");

				-- Refresh the header for that menu button (this is why we let the children
				-- go first. Since they will have had changes, this will refresh their visibility
				-- as well
				if (not compressionOnly) then
					_G["LunarMenu" .. index .. "ButtonHeader"]:SetAttribute('state-state', 
					_G["LunarMenu" .. index .. "ButtonHeader"]:GetAttribute('state'));
				end

			end
		end
		if (not compressionOnly) then
			_G["LunarSphereButtonHeader"]:SetAttribute('state-state', _G["LunarSphereButtonHeader"]:GetAttribute('state'));
			_G["LunarSphereMainButtonHeader"]:SetAttribute('state-state', _G["LunarSphereMainButtonHeader"]:GetAttribute('state'));
		end

	end
end

-- /***********************************************
--  * HideEmptyMenuButtons
--  * ========================
--  *
--  * Hides all menu buttons that are empty
--  *
--  * Accepts: none
--  * Returns: none
--  *********************
function Lunar.Button:HideEmptyMenuButtons(compressionOnly)

	if ((LunarSphereSettings.buttonEditMode == true) and (Lunar.combatLockdown ~= true)) or (Lunar.Button.hiddenButtons == true) then
		return;
	end

	Lunar.Button.hiddenButtons = true;

	-- Cycle through all the sub menu buttons first
	local index;
	local point,relativeTo,relativePoint,xOfs,yOfs;
	local type1, type2, type3;

	local mainButtonCount = LunarSphereSettings.mainButtonCount;

	_G["LunarSphereMainButtonHeader"]:Execute("editMode = nil");

	-- Cycle through all the menu buttons
	for index = 1, 10 do 

		-- Grab the button. If it's empty, hide it
		button = _G["LunarMenu" .. index .. "Button"];
		button:SetAttribute("showstates", Lunar.Button:GetShowStates(index));

		_G[button:GetName() .. "Header"]:Execute("editMode = nil");

		if (LunarSphereSettings.buttonData[button:GetID()].empty == true) or (index > mainButtonCount) then
			button:Hide();
			button:SetAttribute("showstates", "!*");
		end

		Lunar.Button:PetButtonCheck(button, index, (not LunarSphereSettings.alwaysShowPet));

	end

	local buttonCheck = 1;
	local buttonsShown = 0;
	for index = 11, buttonCount do --10 do 

		-- Grab the button and make sure it's always shown on state 1
		button = _G["LunarSub" .. index .. "Button"];

		if (not compressionOnly) then
			button:SetAttribute("showstates", Lunar.Button:GetShowStates(index));
		end

--Always shown
-- always shown (but if the state is set to be "hidden" but is shown, the text display on the button will be wrong)
--button:SetAttribute("showstates", "*"); --Lunar.Button:GetShowStates(index));

		-- Pet button auto-show/hide enabling
		Lunar.Button:PetButtonCheck(button, index, (not LunarSphereSettings.alwaysShowPet))

--		type1, type2, type3 = Lunar.Button:GetButtonType(index, 0, 1) or 0, Lunar.Button:GetButtonType(index, 0, 2) or 0, Lunar.Button:GetButtonType(index, 0, 3) or 0;
--		if ((type1 >= 140) and (type1 < 150)) or ((type2 >= 140) and (type2 < 150)) or ((type3 >= 140) and (type3 < 150)) then
--			button:SetAttribute("unit","pet")
--			RegisterUnitWatch(button);
--		else
--			button:SetAttribute("unit","")
--			UnregisterUnitWatch(button);
--		end

		-- Now, if the button is actually empty, hide it during state 1 instead, and
		-- make the width small again, to hide it.
		if (LunarSphereSettings.buttonData[button:GetID()].empty == true) then

			button:SetAttribute("showstates", "!*");
			if (LunarSphereSettings.submenuCompression) then
				button:SetWidth(4);
				button:SetAttribute("width", 4);
--				button:SetHeight(4);
--				button:SetAttribute("height", 4);
--				if (LunarSphereSettings.buttonData[button.parentID].useMenuAngle) then
					point,relativeTo,relativePoint,xOfs,yOfs = button:GetPoint("Center");
--					button:ClearAllPoints();
					if (index <= 12 * mainButtonCount + 10) then
						if not (math.fmod((index + 1), 12) == 0) then
							button:SetPoint(point, _G["LunarSub" .. index - 1 .. "Button"], relativePoint, 0,0)
--							button:SetPoint("Center", _G["LunarSub" .. index - 1 .. "Button"], "Center", 0,0)
						else
							button:SetPoint(point, relativeTo, relativePoint, xOfs - (xOfs / 1.1), yOfs - (yOfs / 1.1))
						end
					end
--				end
			end
		end

		-- Determine how many submenu buttons are to be shown
		subButtonCount = LunarSphereSettings.buttonData[math.floor((index - 11) / 12) + 1].subButtonCount or (12);
		if (buttonsShown >= subButtonCount) then
			button:SetAttribute("showstates", "!*");
		else
			buttonsShown = buttonsShown + 1;	
		end

		buttonCheck = buttonCheck + 1;
		if (buttonCheck > 12) then
			buttonCheck = 1;
			buttonsShown = 0;
		end
	end

	if (not compressionOnly) then

		-- Now cycle through all the menu buttons
		for index = 1, 10 do 

			-- Grab the button. If it's empty, hide it
			button = _G["LunarMenu" .. index .. "Button"];
	--[[
	--		if (LunarSphereSettings.buttonData[index].useStances == true) then
				button:SetAttribute("showstates", Lunar.Button:GetShowStates(index));
	--			button:SetAttribute("hidestates", "!*");
	--		else
	--			button:SetAttribute("showstates", "*");
	--		end

			if (LunarSphereSettings.buttonData[button:GetID()].empty == true) then
				button:Hide();
				button:SetAttribute("showstates", "!*");
			end
	--]]
			-- Refresh the header for that menu button (this is why we let the children
			-- go first. Since they will have had changes, this will refresh their visibility
			-- as well. If the "auto-hide menu" feature is turned on, we set the state to 0
			-- always. Otherwise, we return it to it's previous state)
			if (LunarSphereSettings.menuUseDelay == 1) then
				_G["LunarMenu" .. index .. "ButtonHeader"]:SetAttribute('state-state', Lunar.Button:GetAssignedStance(button) + 30);
			else
				_G["LunarMenu" .. index .. "ButtonHeader"]:SetAttribute('state-state', 
				_G["LunarMenu" .. index .. "ButtonHeader"]:GetAttribute('state'));
			end
		end
		_G["LunarSphereButtonHeader"]:SetAttribute('state-state', _G["LunarSphereButtonHeader"]:GetAttribute('state'));
		_G["LunarSphereMainButtonHeader"]:SetAttribute('state-state', _G["LunarSphereMainButtonHeader"]:GetAttribute('state'));

	end

end

function Lunar.Button:PetButtonCheck(button, index, disabled)

	local type1, type2, type3 = Lunar.Button:GetButtonType(index, 0, 1) or 0, Lunar.Button:GetButtonType(index, 0, 2) or 0, Lunar.Button:GetButtonType(index, 0, 3) or 0;
--	if (not disabled) and (type1 + type2 + type3 ~= 0) and (((type1 >= 140) and (type1 < 150)) or (type1 == 0)) and (((type2 >= 140) and (type2 < 150)) or (type2 == 0)) and (((type3 >= 140) and (type3 < 150)) or (type3 == 0)) then
	if (not disabled) and (((type1 >= 140) and (type1 < 150)) or ((type2 >= 140) and (type2 < 150)) or ((type3 >= 140) and (type3 < 150))) then
		button:SetAttribute("unit","pet")
		RegisterUnitWatch(button);
	else
		button:SetAttribute("unit","")
		UnregisterUnitWatch(button);
	end
	
end

function Lunar.Button:GetShowStates(buttonID)

	if (LunarSphereSettings.buttonData[buttonID].empty == true) then
		return "";
	end

	local stance, showSetting, hideSetting, settingID, visibleNumber, button;
	local showState = "";
	local maxStances = Lunar.Button.defaultStance;
	local useStances = true;

	if Lunar.Settings.hasStances then
		maxStances = GetNumShapeshiftForms() + 1;
		if (maxStances > 12) then
			maxStances = 12;
		end
	end

	if not (Lunar.Button:GetUseStances(buttonID)) then
		maxStances = Lunar.Button.defaultStance;
		useStances = false;
	end

--[[	if (buttonID > 0) and (buttonID <= 10) then
		button = _G["LunarMenu" .. buttonID .. "Button"];
		button.showCombat = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_SHOW_COMBAT)
		button.hideCombat = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_HIDE_COMBAT)
		button.showNoCombat = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_SHOW_NO_COMBAT)
		button.hideNoComabt = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_HIDE_NO_COMBAT)
	elseif (buttonID > 10) then
		button = _G["LunarMenu" .. _G["LunarSub" .. buttonID .. "Button"].parentID .. "Button"];
	end
--]]	
	if (LunarSphereSettings.buttonData[buttonID].buttonTypeData) then
--		if (buttonID <= 10) then
--			settingID = buttonID;
--			visibleNumber = 1;
--		else
--			settingID = _G["LunarSub" .. buttonID .. "Button"].parentID;
--			visibleNumber = 2;
--		end

--		if (buttonID <= 10) or ((buttonID > 10) and (buttonID == (settingID * 12 - 1))) then

			for stance = Lunar.Button.defaultStance, 12 do
				if (stance <= maxStances) then
					if (string.sub(LunarSphereSettings.buttonData[buttonID].buttonTypeData, stance * 9 + 1, stance * 9 + 9) ~= "000000000") then
						if (buttonID > 0) then

	--						if (buttonID > 10) and (buttonID == (settingID * 12 - 1))  then
	--							combatShow = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_SHOW_COMBAT)
	--							noCombatShow = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_SHOW_NO_COMBAT)
	--							combatHide = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_HIDE_COMBAT)
	--							noCombatHide = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_HIDE_NO_COMBAT)
			--[[					if (Lunar.combatLockdown == true) then
									showSetting = button.showCombat
									hideSetting = button.hideCombat
								else
									showSetting = button.showNoCombat
									hideSetting = button.hideNoCombat
								end
			--]]
	--							if (Lunar.combatLockdown == true) then
	--								showSetting = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_SHOW_COMBAT)
	--								hideSetting = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_HIDE_COMBAT)
	--							else
	--								showSetting = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_SHOW_NO_COMBAT)
	--								hideSetting = Lunar.Button:GetButtonSetting(settingID, stance, LUNAR_GET_HIDE_NO_COMBAT)
	--							end
	--							if not ((showSetting == visibleNumber) or (showSetting == 3)) then
	--								showSetting = nil;
	--							end
	--							if not ((hideSetting == visibleNumber) or (hideSetting == 3)) then
	--								hideSetting = nil;
	--							end
	--							if (showSetting) and (hideSetting)  then
	--								showSetting, hideSetting = nil, nil;
	--							end
	--							if (showSetting) or (hideSetting)  then
	--								if (showSetting) then
	--									showState = showState .. stance .. ",";
			--						else
			--							showState = showState .. "!" .. stance .. "," .. "!" .. stance + 30 .. ",";
	--								end
	--							else
									showState = showState .. stance .. ",";
	--							end
	--						end
						end

		--				showState = showState .. stance .. ",";
	--				elseif (LunarSphereSettings.buttonData[buttonID].isMenu) and (buttonID <= 10)  then
	--					showState = showState .. stance .. ",";
	--				elseif (buttonID <= 10) then
	--					showState = showState .. stance .. ",";
					end
				else
					if (useStances == false) then
						showState = showState .. stance .. ",";
					end
				end
						
			end
--			showState = showState .. "!*";
--		else
--			showState = _G["LunarSub" .. (settingID * 12 - 1) .. "Button"]:GetAttribute("showstate");
		--end
--	else
	end
	showState = showState .. "!*";
--	end

	return showState;
	
end

function Lunar.Button:CheckVisibilityOptions()

	local index, setState, button, offset, showData, hideData
	local showState;
	for index = 1, 10 do
		if (LunarSphereSettings.buttonData[index].buttonTypeData) then
			button = _G["LunarMenu" .. index .. "Button"];
			offset = 0;
			setState = _G[button:GetName() .. "Header"]:GetAttribute("state");
			if not (Lunar.combatLockdown == true) then
				offset = 2;
			end

--			button:Show();

			showData = Lunar.Button:GetButtonSetting(index, button.currentStance, LUNAR_GET_SHOW_COMBAT + offset)
			if (showData == 1) or (showData == 3)  then
				_G[button:GetName() .. "Header"]:Show();
				button:Show();
			end
			if (showData >= 2) then
				if (LunarSphereSettings.buttonData[index].isMenu) then
					_G[button:GetName() .. "Header"]:Execute("toggle = nil; control:RunAttribute('_onclick');");
				end
--				setState = button.currentStance;
			end
			
			hideData = Lunar.Button:GetButtonSetting(index, button.currentStance, LUNAR_GET_HIDE_COMBAT + offset)
			if (hideData == 1) or (hideData == 3)  then
				_G[button:GetName() .. "Header"]:Hide();
				button:Hide();
			end
			if (hideData >= 2) then
				if (LunarSphereSettings.buttonData[index].isMenu) then
					_G[button:GetName() .. "Header"]:Execute("toggle = true; control:RunAttribute('_onclick');");
				end
--				setState = button.currentStance + 30;
			end
				
--			_G[button:GetName() .. "Header"]:SetAttribute('state-state', setState);
		end
	end

--	_G["LunarSphereButtonHeader"]:SetAttribute('state', _G["LunarSphereButtonHeader"]:GetAttribute('state'));
--	_G["LunarSphereMainButtonHeader"]:SetAttribute('state', _G["LunarSphereMainButtonHeader"]:GetAttribute('state'));
end

-- /***********************************************
--  * ShowButtonShine
--  * ========================
--  *
--  * Shows or hides the button shines
--  *
--  * Accepts: flag (true to show, false to hide, nil to use current settings)
--  * Returns: none
--  *********************
function Lunar.Button:ShowButtonShine(flag)

	-- Set our local
	local index;

	-- If our flag isn't set, pull from the current settings. Then save our
	-- new setting
	if not flag then
		flag = LunarSphereSettings.showButtonShine;
	end
	LunarSphereSettings.showButtonShine = flag;

	-- Now show or hide the shines based upon the flag
	if (flag == true) then

		-- Cycle through all the sub menu buttons first, then the normal buttons
		for index = 11, buttonCount do
			_G["LunarSub" .. index .. "Button"].shine:Show();
		end
		for index = 1, 10 do 
			_G["LunarMenu" .. index .. "Button"].shine:Show();
		end

	else

		-- Cycle through all the sub menu buttons first, then the normal buttons
		for index = 11, buttonCount do
			_G["LunarSub" .. index .. "Button"].shine:Hide();
		end
		for index = 1, 10 do 
			_G["LunarMenu" .. index .. "Button"].shine:Hide();
		end
	end

end

-- /***********************************************
--  * EnableActions
--  * ========================
--  *
--  * Enables or disable click actions of button (for edit mode)
--  *
--  * Accepts: enabled flag (true to turn on, everything else to turn off)
--  * Returns: none
--  *********************
function Lunar.Button:EnableActions(enabled)

	-- Set our local
	local index, button;

	-- Now turn on the actions if specified
	if (enabled == true) then
		if not (Lunar.Button.enabledButtons == true) then
			Lunar.Button.enabledButtons = true;
			Lunar.Button:SetupStances(_G["LSmain"]);
			-- Cycle through all buttons
			for index = 1, buttonCount do
				if (index <= 10) then
					Lunar.Button:SetupStances(_G["LunarMenu" .. index .. "Button"]);
				else
					Lunar.Button:SetupStances(_G["LunarSub" .. index .. "Button"]);
				end
			end
		end
	else
		if (Lunar.Button.enabledButtons == true) then
			Lunar.Button.enabledButtons = nil;
			-- Cycle through all buttons
			for index = 1, buttonCount do
				if (index <= 10) then
					button = _G["LunarMenu" .. index .. "Button"];
				else
					button = _G["LunarSub" .. index .. "Button"];
				end
				button:SetAttribute("*statebutton1", "");
				button:SetAttribute("*statebutton2", "");
				button:SetAttribute("*statebutton3", "");
			end
			_G["LSmain"]:SetAttribute("*statebutton1", "");
			_G["LSmain"]:SetAttribute("*statebutton2", "");
			_G["LSmain"]:SetAttribute("*statebutton3", "");
		end
	end

end

-- /***********************************************
--  * ConvertToMenu
--  * ========================
--  *
--  * Converts one of the 10 main buttons into a menu button. If it was already
--  * a menu button, it just updates the button icon. Otherwise, it prepares the
--  * menu and submenu buttons
--  *
--  * Accepts: button to be converted
--  * Returns: none
--  *********************
function Lunar.Button:ConvertToMenu(self, clickType)

	if (not clickType) then
		clickType = 1;
	end

	-- Create our locals and store the data that's in the player's cursor
	local cursorType, objectID, objectData = GetCursorInfo();

	-- If the cursor isn't holding something, check our cached data
	if (not cursorType) then
		cursorType = Lunar.Button.updateType;
		objectID = Lunar.Button.updateID;
		objectData = Lunar.Button.updateData;
	end

	-- Clear our update cache
	Lunar.Button.updateType = nil;
	Lunar.Button.updateID = nil
	Lunar.Button.updateData = nil;

	local buttonID = self:GetID();

	-- If there is something being held, and the button is a valid menu button, continue...
	if (cursorType) and (buttonID <= 10) then

		-- Create more locals
		local objectTexture, buttonName, index;

		-- Grab the name of the button
		buttonName = self:GetName();

		if (not LunarSphereSettings.buttonData[self:GetID()].buttonSettings) then
			LunarSphereSettings.buttonData[self:GetID()].buttonSettings = string.rep("1110000", 13);
		end

		-- Hide the counter and make sure the icon is fully visible
		if (clickType == Lunar.Button:GetButtonSetting(self:GetID(), self.currentStance, LUNAR_GET_SHOW_COUNT)) then
			_G[buttonName .. "Count"]:Hide();
		end
		_G[buttonName .. "Icon"]:SetAlpha(1);

		-- Set the button as a menu and make sure its children know that they
		-- are now part of a menu
		LunarSphereSettings.buttonData[buttonID].isMenu = true;
		for index = (buttonID * 12) - 1, (buttonID * 12) + 10 do 
			LunarSphereSettings.buttonData[index].child = true;
		end
		LunarSphereSettings.buttonData[buttonID].menuType = LunarSphereSettings.buttonData[buttonID].menuType or 1;
		LunarSphereSettings.buttonData[buttonID].menuDelay = LunarSphereSettings.buttonData[buttonID].menuDelay or 3;

		-- Ensure that the OnUpdate on OnShow event handler is destroyed
		self.canUpdate = false;
--		self:SetScript("OnUpdate", nil);
		self:SetScript("OnShow", nil);

		-- Make sure the icon is the right color
		_G[buttonName .. "Icon"]:SetVertexColor(1.0, 1.0, 1.0, 1.0);

		-- Reset the rest of the button's data
		LunarSphereSettings.buttonData[buttonID].parent = nil;
		LunarSphereSettings.buttonData[buttonID].stateID = nil;
		LunarSphereSettings.buttonData[buttonID].visibilityRule = nil;
--		LunarSphereSettings.buttonData[buttonID]["buttonType" .. clickType] = nil;
--		LunarSphereSettings.buttonData[buttonID].texture1 = nil;
		LunarSphereSettings.buttonData[buttonID].child = false;
		LunarSphereSettings.buttonData[buttonID].empty = false;
		LunarSphereSettings.buttonData[buttonID].showCount = false;

		-- If it was a spell drag ...
		if ((cursorType == "spell") and (objectID)) then

			-- Attach the texture of the spell to the icon
			objectTexture = GetSpellTexture(objectID, objectData);

		-- If it was an item drag ...
		elseif (cursorType == "item") then

			-- Get the texture of the item
			_, _, _, _, _, _, _, _, _, objectTexture = GetItemInfo(objectID);

		-- If it was a macro drag ...
		elseif (cursorType == "macro") then

			-- Grab the macro information and set the new texture
			_, objectTexture = GetMacroInfo(objectID);

		end

		-- Now, save the texture if it's a new one, or use the old one
--		if (objectTexture) then
--			LunarSphereSettings.buttonData[buttonID]["texture" .. clickType] = objectTexture;
--		end

		-- Assign the new data for the button
		Lunar.Button:SetButtonData(buttonID, Lunar.Button:GetAssignedStance(self), clickType, 2, "spell", "", objectTexture);

		-- Save the button type as a menu button
--		LunarSphereSettings.buttonData[buttonID]["buttonType" .. clickType] = 2;

		-- Clear any action that might be saved (because we're a menu now)
--		LunarSphereSettings.buttonData[buttonID]["actionType" .. clickType] = nil;
--		LunarSphereSettings.buttonData[buttonID]["actionName" .. clickType] = nil;

		-- Needs to assign current selected icon.
--		_,_,_,objectTexture = Lunar.Button:GetButtonData(buttonID, GetShapeshiftForm(), 1);
		_,_,_,objectTexture = Lunar.Button:GetButtonData(buttonID, Lunar.Button:GetAssignedStance(self), Lunar.Button:GetButtonSetting(buttonID, Lunar.Button:GetAssignedStance(self), LUNAR_GET_SHOW_ICON));
		_G[buttonName .. "Icon"]:SetTexture(objectTexture);

		-- Prepare the button so it will open the menu with the current clickType
		Lunar.Button:SetupAsMenu(self, clickType);
		
--		self:SetAttribute("type", "spell");
--		self:SetAttribute("spell", ATTRIBUTE_NOOP);

		-- Make our icon fully visible and cut it into a circle
		self:SetAlpha(1);
		SetPortraitToTexture(_G[buttonName .. "Icon"], _G[buttonName .. "Icon"]:GetTexture());

		-- Clear our cursor of what its holding and hide all the left over empty buttons
		ClearCursor();
		Lunar.Button:HideEmptyMenuButtons();

		-- Update our button events
		self.registeredEvents = false;
		Lunar.Button:Update(self);
	end
end

-- /***********************************************
--  * Assign
--  * ========================
--  *
--  * Assigns a new action to the button
--  *
--  * Accepts: button to be modified
--  * Returns: none
--  *********************
function Lunar.Button:Assign(self, clickType, stance)

	
	-- Create our locals and store the data that's in the player's cursor
	local cursorType, objectID, objectData, objectSpellID = GetCursorInfo();
	local buttonID = self:GetID();
	local secondCursorType = nil;

	-- If the cursor isn't holding something, check our cached data (incase it was
	-- a right-click assignment)
	if (not cursorType) then
		cursorType = Lunar.Button.updateType;
		objectID = Lunar.Button.updateID;
		objectData = Lunar.Button.updateData;
	end

	local nextSpellName, spellRank;

	-- Now, let's find out if we were actually dragging a PET or MOUNT
	-- so that we can, you know, assign those instead.
	--9/12 Croq - removed in favor of GetMountInfoByID
	if (cursorType == "companion") then
		objectID, objectData = select(3, GetCompanionInfo(objectData, objectID));
	end

	if (cursorType == "spell") then
--		_, spellName = GetSpellBookItemName( objectID, objectData );
--		nextSpellName = GetSpellBookItemName( objectID + 1, objectData );
--		spellRank = "(" .. spellRank .. ")";
	end

	-- Croq Modified, mounts are now pulled from the Journal
	-- Croq - No need to pull the based off objectData.  Use the objectID being passed
	-- Info creatureName, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected, mountID = C_MountJournal.GetDisplayedMountInfo(index)
	-- Info creatureName, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected, mountID = C_MountJournal.GetMountInfoByID(mountID)
	-- Info creatureDisplayID, descriptionText, sourceText, isSelfMount, mountType = C_MountJournal.GetMountInfoExtraByID(mountID)
	if (cursorType == "mount") then
	
		----print("BEFORE objectID = ", objectID, " and objectData = ", objectData);
		local creatureName, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected, mountID = C_MountJournal.GetMountInfoByID(objectID);
		local creatureDisplayID, descriptionText, sourceText, isSelfMount, mountType = C_MountJournal.GetMountInfoExtraByID(mountID);
		
		objectID = mountID;
		objectData = spellID;
		objectData = select(3, GetSpellInfo(spellID));
	end
	
	if (cursorType == "battlepet") then
		Lunar.API:--print("Battle pet shortcuts are not yet supported.");
		ClearCursor();
		return;
	end
	
	--if (cursorType == "item") then
	--		local itemType = select(6, GetItemInfo(objectID));
	--		local oID = objectID;
			
			--print(itemType.." "..objectID);
			
	--		objectID = "item:" .. objectID;
	--		objectData = GetItemIcon(objectID);
			
	--		if C_ToyBox.GetToyInfo(oID) ~= nil then
				--objectID, _, objectData = C_ToyBox.GetToyInfo(oID);
	--			print(C_ToyBox.GetToyInfo(oID));
	--			Lunar.API:Print("Toy item shortcuts are not yet supported.");
	--			ClearCursor();
	--			return;
	--		end		

	-- Flyout spells are odd. If the player wants to drag this to the sphere, um ..
	-- We assign the first spell in the flyout or just the flyout spell (and force a flyout to
	-- appear on our sphere?
	if (cursorType == "flyout") then
--		secondCursorType = "spell"
		ClearCursor();
		Lunar.Button.updateType = nil;
		Lunar.Button.updateData = nil;
		Lunar.Button.updateID = nil;
		return;
	end


	-- If stance wasn't specified, we need to check if this button is affected by
	-- stance support. If it is, we assign the current form we're in. Otherwise,
	-- we do stance 0;
	if (not stance) then
		stance = self.currentStance;
	end

	if ((LunarSphereSettings.debugSpellAdd == true) and (Lunar.Button.debugTexture ~= nil )) then
		cursorType = "spell";
		objectID = "";
		objectData = "";
		stance = Lunar.Button.debugStance or stance;
	end

	-- Clear our update cache
	Lunar.Button.updateType = nil;
	Lunar.Button.updateID = nil
	Lunar.Button.updateData = nil;

	-- If there is something being held, continue...
	if (cursorType) then

		if (not clickType) then
			clickType = 1;
		end

		-- Create more locals
		local objectName, objectTexture, objectMainType, objectType, buttonName, stackTotal, spellID, spellName;
		local buttonType;

		-- Grab the name of the button
		buttonName = self:GetName();

		if (not LunarSphereSettings.buttonData[buttonID].buttonSettings) then
			LunarSphereSettings.buttonData[buttonID].buttonSettings = string.rep("1110000", 13);
		end

		if (not self.cooldownID) then
			self.cooldownID = Lunar.Button:GetButtonSetting(self:GetID(), Lunar.Button:GetAssignedStance(self), LUNAR_GET_SHOW_COOLDOWN)
			self.actionTypeCooldown = false;
		end

		if (buttonID ~= 0) then
			if (clickType == Lunar.Button:GetButtonSetting(buttonID, stance, LUNAR_GET_SHOW_COUNT)) then
				LunarSphereSettings.buttonData[buttonID].showCount = false;
				_G[buttonName .. "Count"]:Hide();
			end
			_G[buttonName .. "Icon"]:SetAlpha(1);
		end

		-- Cheap hack does the trick... *sigh*
		if (cursorType == "equipmentset") then
			Lunar.Button.updateType = cursorType;
			Lunar.Button.updateData = objectID;
			Lunar.Button.updateID = objectID;
			Lunar.Button:AssignByType(self, clickType, 133, stance)
			ClearCursor();
			Lunar.Button.updateType = nil;
			Lunar.Button.updateData = nil;
			Lunar.Button.updateID = nil;
			return;
		end

		-- Reset the rest of the button's data
		LunarSphereSettings.buttonData[buttonID].empty = true;
--		LunarSphereSettings.buttonData[buttonID].parent = nil;
--		LunarSphereSettings.buttonData[buttonID].stateID = 0;
--		LunarSphereSettings.buttonData[buttonID].visibilityRule = nil;
--		LunarSphereSettings.buttonData[buttonID].child = false;

		--LunarSphereSettings.buttonData[buttonID]["buttonType" .. clickType] = nil;
		--LunarSphereSettings.buttonData[buttonID]["texture" .. clickType] = nil;
		Lunar.Button:SetButtonType(buttonID, stance, clickType, 0, nil, nil, " ");

		-- If the button is currently a menu, and this assignment will wipe all menu actions
		-- from the button, wipe the menu completely
		if (LunarSphereSettings.buttonData[buttonID].isMenu == true) then
			Lunar.Button:SetupAsMenu(self, clickType, false)
--			Lunar.Button:SetButtonType(buttonID, stance, clickType, 0);
--			LunarSphereSettings.buttonData[buttonID]["buttonType" .. clickType] = nil;
			Lunar.Button:MenuDestroyCheck(buttonID)
		end

		-- Set our button type based upon the action we assign
		if ((cursorType == "spell") or (cursorType == "item") or (cursorType == "macro") or (cursorType == "companion") or (cursorType == "equipmentset") or (cursorType == "flyout") or (cursorType == "mount")) then
			buttonType = 1;
--			LunarSphereSettings.buttonData[buttonID]["buttonType" .. clickType] = 1;
		end

		if ((LunarSphereSettings.debugSpellAdd == true) and (Lunar.Button.debugTexture ~= nil )) then
			cursorType = nil;
		end

		-- If it was a spell drag ...
		if (cursorType == "spell") then

			-- Get the name of the spell and its texture
			--_, spellID = GetSpellBookItemInfo(objectSpellID, objectData);
			objectName = GetSpellBookItemName(objectID, objectData);
			objectTexture = GetSpellTexture(objectSpellID);
			spellName = GetSpellInfo(objectSpellID);

			-- Fix for Call Pet for hunters.
			if (objectName ~= spellName) then
				objectName = objectSpellID;
			-- Fix for normal sheep polymorph
			elseif (objectSpellID == 118) then
				objectName = objectSpellID;
			else
--				if (objectName ~= nextSpellName) then
--					if (string.find(spellRank, "%d")) then
--						spellRank = "";
--						objectName = Lunar.API:FixFaerie(objectName);
--					end
					if (spellRank == "()") then
						spellRank = "";
						objectName = Lunar.API:FixFaerie(objectName);
					end
--				end
				-- We don't want spell ranks on the first spell tab data or the professions tab ... these are generic
				if (objectID <= (select(4, GetSpellTabInfo(1))) or objectSpellID >= (select(3, GetSpellTabInfo(5)))) then
					spellRank = "";
				end
	--			objectName = objectName .. spellRank;
			end

		elseif (cursorType == "companion") then

			-- Set the name of the spell and its texture
			cursorType = "spell";
			objectName = objectID;
			objectTexture = objectData;
			self:SetAttribute("*"..cursorType .. "2-S" .. stance .. clickType, GetSpellInfo(objectName));

		elseif (cursorType == "flyout") then

			-- Get the name of the spell and its texture
			objectName = objectID GetSpellBookItemName(objectID, objectData);
			objectTexture = objectData;

		-- If it was an item drag ...
		elseif (cursorType == "item") then

			-- Get the name of the item, what it can stack as, and its texture
			objectName, _, _, _, _, objectMainType, objectType, stackTotal, _, objectTexture = GetItemInfo(objectData);
			

			if Lunar.API:IsVersionRetail() and C_ToyBox.GetToyInfo(objectID) then
				--print(objectName.." is a toy")
				--print("/usetoy ".. objectID)	
			end

			-- NEW code for item names (item link for weapons/armor, to remember their "of the bear" and other animal
			-- modifiers, all other items is JUST the item ID)
			if (objectMainType == LunarSphereGlobal.searchData.armor) or (objectMainType == LunarSphereGlobal.searchData.weapon) then
				-- Grab the item link and secure only the parts that we need for the item
				objectName = select(3, string.find(objectData, "^|c%x+|H(.+)|h%[.+%]"));
			else
				objectName = "item:" .. Lunar.API:GetItemID(objectData);
			end
--[[

			-- Grab the item link and secure only the parts that we need for the item
			objectName = select(3, string.find(objectData, "^|c%x+|H(.+)|h%[.+%]"));
			if IsConsumableItem(objectName) then
				local uniqueID = select(10, string.find(objectName, "^item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+)"));
				if (uniqueID) and (uniqueID ~= "0")  then
					objectName = string.gsub(objectName, ":-" .. uniqueID, "");
					objectName = string.gsub(objectName, ":" .. uniqueID, "");
				end
			end
--]]

			-- If the item is consumable, or can stack, or is a reagent ... we will show the
			-- count of the item on the button
			if (buttonID ~= 0) then
				if (clickType == Lunar.Button:GetButtonSetting(buttonID, stance, LUNAR_GET_SHOW_COUNT)) then
					if (objectName == "item:6265") or (IsConsumableItem(objectName) or (stackTotal > 1) or (objectType == Lunar.Items.reagentString)) then
						_G[buttonName .. "Count"]:SetText(GetItemCount(objectID, nil, true));

						if (not LunarSphereSettings.showAssignedCounts == true) then
							_G[buttonName .. "Count"]:Show();
							LunarSphereSettings.buttonData[buttonID].showCount = true;
						end
					end
				end
			end

		-- If it was a macro drag ...
		elseif (cursorType == "macro") then

			-- Grab the macro information and texture
			objectName, objectTexture = GetMacroInfo(objectID);

		end

		if (cursorType == "mount") then

			-- Get the name of the spell and its texture
			local creatureName, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected, mountID = C_MountJournal.GetMountInfoByID(objectID);
			
			objectName = creatureName;
			objectTexture = icon;
			
			--something goofy with the mount system. have to put the cursortype to "spell" to get the icon to show up
			cursorType = "spell"

		end

		if ((LunarSphereSettings.debugSpellAdd == true) and (Lunar.Button.debugTexture ~= nil )) then
			cursorType = "spell";
			objectName = "";
			if (Lunar.Button.debugTexture == tostring(tonumber(Lunar.Button.debugTexture))) then
				objectTexture = Lunar.Button.debugTexture;
			else
				objectTexture = "Interface\\Icons\\" .. Lunar.Button.debugTexture;
			end
			stance = Lunar.Button.debugStance or stance;
		end

		Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, objectName, objectTexture);

		-- Save the texture data. If it's a left click (main) action, also assign the texture to 
		-- the button icon
		if (buttonID ~= 0) then
			if (clickType == Lunar.Button:GetButtonSetting(buttonID, stance, LUNAR_GET_SHOW_ICON)) then
				_G[buttonName .. "Icon"]:SetTexture(objectTexture);
				SetPortraitToTexture(_G[buttonName .. "Icon"], _G[buttonName .. "Icon"]:GetTexture());
			end
		end

		-- If we have an action name, state that our button is no longer empty
		if (objectName) then
			LunarSphereSettings.buttonData[buttonID].empty = false;
			if (buttonID ~= 0) then
				self:SetWidth(36);
				self:SetAttribute("width", 36);
			end
		end

		-- Now set the actual action to be performed

		self:SetAttribute("*type-S" .. stance .. clickType, cursorType)
		cursorType = secondCursorType or cursorType;
		self:SetAttribute("*"..cursorType .. "-S" .. stance .. clickType, objectName)
--		self:SetAttribute("*"..cursorType .. "-S" .. stance .. clickType, Lunar.API:FixFaerie(objectName))


--		LunarSphereSettings.buttonData[buttonID]["actionType" .. clickType] = cursorType;
--		LunarSphereSettings.buttonData[buttonID]["actionName" .. clickType] = objectName;
--		LunarSphereSettings.buttonData[buttonID]["texture" .. clickType] = objectTexture;

		-- Make our icon fully visible
		self:SetAlpha(1);

		-- Clear our cursor of what its holding and hide all the left over empty buttons
		ClearCursor();
		Lunar.Button:HideEmptyMenuButtons();

		-- Update the tooltip
		Lunar.Button:SetTooltip(self);

		-- Update our button events
		if (buttonID ~= 0) then
			self.registeredEvents = false;
			Lunar.Button:Update(self);
		end

		-- Preserve our fade out
--		local tempFade = LunarSphereSettings.fadeOutTooltips;
--		LunarSphereSettings.fadeOutTooltips = nil;
		Lunar.Button:UpdateSpellState(self);
--		LunarSphereSettings.fadeOutTooltips = tempFade;

	end
end

function Lunar.Button:GetAssignedStance(self, useCached)

	local stance;

	if (Lunar.Button:GetUseStances(self:GetID(), useCached) == true) then
		stance = GetShapeshiftForm();
	else
		stance = Lunar.Button.defaultStance;
	end

	return stance;

end

function Lunar.Button:MenuDestroyCheck(buttonID)
	local clickType, keepIt
	local stance = GetShapeshiftForm()
	--STANCE
	stance = Lunar.Button.defaultStance;

	for clickType = 1, 3 do 
		if (Lunar.Button:GetButtonType(buttonID, stance, clickType) == 2) then
			keepIt = true;
			break;
		end
	end
	if (not keepIt) then
		Lunar.Button:WipeMenu(buttonID);
	end
end

function Lunar.Button:WipeMenu(buttonID)
	LunarSphereSettings.buttonData[buttonID].isMenu = nil;
	local index;
	for index = (buttonID * 12) - 1, (buttonID * 12) + 10 do 
		Lunar.Button:Unassign(_G["LunarSub" .. index .. "Button"]);
		LunarSphereSettings.buttonData[index].child = false;
	end
end

-- /***********************************************
--  * AssignByType
--  * ========================
--  *
--  * Assigns a new action to the button based on button type
--  *
--  * Accepts: button to be modified
--  * Returns: none
--  *********************
function Lunar.Button:AssignByType(button, clickType, buttonType, stance, lastUsedUpdate)

	--print("Lunar.Button:AssignByType: 3751 ", button, clickType, buttonType, stance, lastUsedUpdate)

	-- Create our locals and store the data that's in the player's cursor
--	local cursorType, objectID, objectData = GetCursorInfo();
	local buttonID = button:GetID();

	-- If the cursor isn't holding something, check our cached data (incase it was
	-- a right-click assignment)
--	if (not cursorType) then
--		cursorType = Lunar.Button.updateType;
--		objectID = Lunar.Button.updateID;
--		objectData = Lunar.Button.updateData;
--	end

	-- Clear our update cache
--	Lunar.Button.updateType = nil;
--	Lunar.Button.updateID = nil
--	Lunar.Button.updateData = nil;

	-- If there is something being held, continue...
--	if (cursorType) then

		if (not clickType) then
			return;
--			clickType = 1;
		end

		-- If stance wasn't specified, we need to check if this button is affected by
		-- stance support. If it is, we assign the current form we're in. Otherwise,
		-- we do stance 0;
		if (not stance) then
			stance = button.currentStance;
		end

		-- Create more locals
		local objectName, objectTexture, objectType, buttonName, stackTotal, objectName1, objectName2;

		-- Grab the name of the button
		buttonName = button:GetName();

		-- Hide the counter if this is a left click (main) action and make sure the
		-- icon is fully visible
		if (stance == button.currentStance) then
				if (buttonID > 0) then
					if (clickType == Lunar.Button:GetButtonSetting(buttonID, stance, LUNAR_GET_SHOW_COUNT)) then
						LunarSphereSettings.buttonData[buttonID].showCount = false;
						_G[buttonName .. "Count"]:Hide();
					end
					_G[buttonName .. "Icon"]:SetAlpha(1);
				end
		end
		-- Reset the rest of the button's data
		LunarSphereSettings.buttonData[buttonID].empty = true;
--		LunarSphereSettings.buttonData[buttonID].parent = nil;
--		LunarSphereSettings.buttonData[buttonID].stateID = 0;
--		LunarSphereSettings.buttonData[buttonID].visibilityRule = nil;
--		LunarSphereSettings.buttonData[buttonID].child = false;

--		LunarSphereSettings.buttonData[buttonID]["buttonType" .. clickType] = nil;

		_,_,_,objectTexture = Lunar.Button:GetButtonData(buttonID, stance, clickType);

		Lunar.Button:SetButtonData(buttonID, stance, clickType, (lastUsedUpdate or buttonType) , nil, nil, " ");

		-- If the button is currently a menu, and this assignment will wipe all menu actions
		-- from the button, wipe the menu completely
		if (LunarSphereSettings.buttonData[buttonID].isMenu == true) then
			Lunar.Button:SetupAsMenu(button, clickType, false)
--			Lunar.Button:SetButtonType(buttonID, stance, clickType, 0);
--			LunarSphereSettings.buttonData[buttonID]["buttonType" .. clickType] = nil;
			Lunar.Button:MenuDestroyCheck(buttonID)
		end

--		objectTexture = LunarSphereSettings.buttonData[buttonID]["texture" .. clickType];

--		LunarSphereSettings.buttonData[buttonID]["texture" .. clickType] = nil;

		-- Set our button type based upon the action we assign
--		if ((cursorType == "spell") or (cursorType == "item") or (cursorType == "macro")) then
--			LunarSphereSettings.buttonData[buttonID]["buttonType" .. clickType] = buttonType;
--		end

		-- Now, run down the list of button types and set things up.
		cursorType = "spell";
		objectName = ""
		-- Consumable Types
		if (buttonType >= 10) and (buttonType < 90) or ((buttonType >= 110) and (buttonType <= 111)) or (buttonType == 132) then
			
			cursorType = "item";
			
			-- Grab our weakest item
--			if (math.fmod(buttonType, 10) == 0) then
			if (buttonType < 90) then
				if (buttonType == 12) or (buttonType == 22) or (buttonType == 13) or (buttonType == 23) then
					if (buttonType == 12) or (buttonType == 22) then
						objectName1 = Lunar.Items:GetItem("food", 0);
						objectName2 = Lunar.Items:GetItem("drink", 0);
					else
						objectName1 = Lunar.Items:GetItem("food", 1);
						objectName2 = Lunar.Items:GetItem("drink", 1);
					end

					-- Make the icon and count shown be the item with the smallest count
					local count1, count2 = GetItemCount(objectName1), GetItemCount(objectName2);
					if ((count1 or (0))  > (count2 or (0))) then
						objectName = objectName2 or objectName1;
						if (objectName == "") then
							objectName = objectName1;
						end
					else
						objectName = objectName1 or objectName2;
						if (objectName == "") then
							objectName = objectName2;
						end
					end
				elseif (buttonType >= 50) and (buttonType < 60)  then
					local subType;
					if (buttonType < 52) then
						subType = buttonType - 50 + 2;
					elseif (buttonType < 54) then
						subType = 4;
					elseif (buttonType < 56) then
						subType = 5;
					elseif (buttonType < 58) then
						subType = 0;
					else
						subType = 1;
					end	
					objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)), subType);
					if (objectName == "") then
						objectName = " ";
					end
					if (buttonType > 51) then
						LunarSphereSettings.buttonData[buttonID].showCount = true;
					end
				else
					-- HEREEEE we get the mount by type of button: 0 is randon, 1 is random ground, etc.
					objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)), math.fmod(buttonType, 10));
				end
			elseif (buttonType == 132) then
				objectName = Lunar.Items:GetItem("companion", 1, true);
			else
				objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(buttonType - 109), 3, true);
			end

				--print("objectName (3893) : ", objectName)

			-- Or grab our strongest
--			elseif (math.fmod(buttonType, 10) == 1) then
--				objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)));
--			end

			-- grab the texture, if the object exists
			if (objectName) then
				local objectType_l, stackTotal_l;
				_, _, _, _, _, objectMainType, objectType_l, stackTotal_l, _, objectTexture = GetItemInfo(objectName);

				--print("objectMainType : ", objectMainType, objectType_l, stackTotal_l, objectTexture)

				-- If the item is consumable, or can stack, or is a reagent ... we will show the
				-- count of the item on the button
				if (stance == button.currentStance) then
					if (buttonID > 0) then
						if (clickType == Lunar.Button:GetButtonSetting(buttonID, stance, LUNAR_GET_SHOW_COUNT)) then
							if (stackTotal_l) then
								if (IsConsumableItem(objectName) or (stackTotal_l > 1) or (objectType_l == Lunar.Items.reagentString)) then
									_G[buttonName .. "Count"]:SetText(GetItemCount(objectName, nil, true));

									if (not LunarSphereSettings.showAssignedCounts == true) then
										_G[buttonName .. "Count"]:Show();
										LunarSphereSettings.buttonData[buttonID].showCount = true;
									end
								end
							end
						end
					end
				end
			end
		end

		--print("objectMainType (3928) : ", objectMainType, objectType, stackTotal, objectTexture)

		-- Mount Buttons ... we check for spell mounts here
		if (buttonType >= 80) and (buttonType < 90) and (objectName) then
			--print("objectName (3932) : ", objectName, objectTexture, cursorType)
			if (string.sub(objectName, 1, 2) == "**") then
				objectName = string.sub(objectName, 3);
--				objectName, _, objectTexture = string.match(objectName, "%*%*(.*)~(.*)~(.*)") --string.sub(objectName, 3);
				objectTexture = select(3, GetSpellInfo(objectName));
				cursorType = "spell";
			end

			--print("objectMainType (3937) : ", objectMainType, objectType, stackTotal, objectTexture)

		-- Companion button
		elseif (buttonType == 132) then
			objectTexture = "Interface\\Icons\\Ability_Hunter_BeastCall";
			if (string.sub(objectName, 1, 2) == "**") then
				objectName = string.sub(objectName, 3);
--				objectTexture = "Interface\\Icons\\Ability_Hunter_BeastCall";
--				objectTexture = select(3, GetSpellInfo(objectName));
				cursorType = "spell";
			end

		-- Bag Buttons
		elseif (buttonType >= 90) and (buttonType < 100) then
			objectTexture = Lunar.Button:GetBagTexture(buttonType);
			if (stance == button.currentStance) then
				if (buttonID > 0) then
					Lunar.Button:UpdateBagDisplay(button, stance, clickType);
				end
			end

		-- Menu tabs
		elseif (buttonType >= 100) and (buttonType < 110) then
			if (buttonType == 100) then
				if (button:GetID() > 0) then
					SetPortraitTexture(_G[buttonName .. "Icon"], "player");
					objectTexture = _G[buttonName .. "Icon"]:GetTexture();
				end
			else
				objectTexture = Lunar.Button.texturePath[buttonType - 100];
				if (buttonType == 109 ) and (UnitFactionGroup("player") == "Alliance")  then
					objectTexture = LUNAR_ART_PATH .. "menuPVP2.blp";
				end
			end
--			cursorType = "spell";
--			objectName = "";
		end

		-- Clear any slot target information for this click type
		button:SetAttribute("target-slot-S" .. stance .. clickType, "");

		-- Poison apply types
		if (buttonType > 51) and (buttonType < 60) then
			if (math.fmod(buttonType, 2) == 0) then
				button:SetAttribute("target-slot-S" .. stance .. clickType, GetInventorySlotInfo("MainHandSlot"));
			else
				button:SetAttribute("target-slot-S" .. stance .. clickType, GetInventorySlotInfo("SecondaryHandSlot"));
			end

		-- Weapon Apply types
		elseif (buttonType >= 112) and (buttonType < 130) then
			if (buttonType == 120) then
				button:SetAttribute("target-slot-S" .. stance .. clickType, GetInventorySlotInfo("MainHandSlot"));
			elseif (buttonType == 121) then
				button:SetAttribute("target-slot-S" .. stance .. clickType, GetInventorySlotInfo("SecondaryHandSlot"));
			elseif (buttonType == 122) then
				button:SetAttribute("target-slot-S" .. stance .. clickType, GetInventorySlotInfo("RangedSlot"));
			end
				
			cursorType = Lunar.Button.updateType;
			objectID = Lunar.Button.updateID;
			objectData = Lunar.Button.updateData;

			if (not cursorType) then
				_, cursorType, objectName = Lunar.Button:GetButtonData(buttonID, stance, clickType);
			end			

			if (cursorType) then
				
				-- If it was a spell drag ...
				if (cursorType == "spell") then

					if (objectData) then
						-- Get the name of the spell and its texture
						objectName = GetSpellBookItemName(objectID, objectData);
						objectTexture = GetSpellTexture(objectID, objectData);
					end

				-- If it was an item drag ...
				elseif (cursorType == "item") then

					-- If we have object data (from an assignment), get the name of the item,
					-- what it can stack as, and its texture
					if (objectData) then

						objectName, _, _, _, _, objectType, _, stackTotal, _, objectTexture = GetItemInfo(objectData);

--						if (objectType == LunarSphereGlobal.searchData.armor) or (objectType == LunarSphereGlobal.searchData.weapon) then
--							-- Grab the item link and secure only the parts that we need for the item
--							objectName = select(3, string.find(objectData, "^|c%x+|H(.+)|h%[.+%]"));
--						else
--							objectName = "item:" .. Lunar.API:GetItemID(objectData);
--						end

					-- If we don't have objectData, we're pulling from saved data. All we care about is the stackTotal
					-- and the objectType (if they exist because they are in our inventory)
					else
						_, _, _, _, _, _, objectType, stackTotal = GetItemInfo(objectName);
					end

					-- If the item is consumable, or can stack, or is a reagent ... we will show the
					-- count of the item on the button if it exists
					if (buttonID > 0) then
						if (clickType == Lunar.Button:GetButtonSetting(buttonID, stance, LUNAR_GET_SHOW_COUNT)) and (stackTotal) then
							if (IsConsumableItem(objectName) or (stackTotal > 1) or (objectType == Lunar.Items.reagentString)) then
								_G[buttonName .. "Count"]:SetText(GetItemCount(objectName, nil, true));

								if (not LunarSphereSettings.showAssignedCounts == true) then
									_G[buttonName .. "Count"]:Show();
									LunarSphereSettings.buttonData[buttonID].showCount = true;
								end
							end
						end
					end

				-- If it was a macro drag ...
				elseif (cursorType == "macro") then

					-- Grab the macro information and texture
					objectName, objectTexture = GetMacroInfo(objectID);

				end
			end

		elseif (buttonType == 130) or (buttonType == 131) then
			objectTexture = GetInventoryItemTexture("player", buttonType - 117);
		elseif (buttonType == 133) then
			cursorType = Lunar.Button.updateType;
			objectName = Lunar.Button.updateID;
			local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(objectName)
			objectTexture = select(2, C_EquipmentSet.GetEquipmentSetInfo(equipmentSetID));
			
		-- Pet action buttons
		elseif (buttonType >= 140) and (buttonType < 150)  then
			local _, _, texture, isToken = GetPetActionInfo(buttonType - 139);
			if ( not isToken ) then
				objectTexture = texture;
			else
				objectTexture = _G[texture];
			end
			cursorType = "pet";
			objectName = buttonType - 139;
		end

		--print("AssignByType (4084) : ", objectName, objectTexture, cursorType)

		-- Save the texture data. If it's a left click (main) action, also assign the texture to 
		-- the button icon
--		if (clickType == 1) then
if (stance == button.currentStance) then
		--print("AssignByType (4090) : ", objectName, objectTexture, cursorType)
		if (clickType == Lunar.Button:GetButtonSetting(buttonID, stance, LUNAR_GET_SHOW_ICON)) then
			if (buttonID > 0) then
				if (buttonType ~= 100) then
					if not objectTexture then
						if (buttonType < 100) then
							-- None in stock images
							objectTexture = string.match(Lunar.Speech.actionAssignNames[math.floor(buttonType / 10) + 1], ":::(.*)");

							-- Healthstone, mana gem, and mount textures are a little different than the default textures for the catagories...
							if (buttonType == 34) or (buttonType == 35) then
								objectTexture = "Interface\\Icons\\INV_Stone_04";
							elseif (buttonType == 44) or (buttonType == 45)  then
								objectTexture = "Interface\\Icons\\INV_Misc_Gem_Emerald_01";
							elseif (buttonType >= 52) and (buttonType < 60) then
								objectTexture = "Interface\\Icons\\" .. Lunar.Items.poisonImages[(buttonType - 52) / 2 + 1];
							elseif (buttonType > 80) and (buttonType < 83)  then
								objectTexture = string.match(Lunar.Speech.actionAssignNames[math.floor(buttonType / 10) + 1 + (buttonType - 80)], ":::(.*)");
							elseif (buttonType > 82) and (buttonType < 86)  then
								objectTexture = string.match(Lunar.Speech.actionAssignNames[math.floor(buttonType / 10) + 1 + (buttonType - 83)], ":::(.*)");
							elseif (buttonType == 86) then
								objectTexture = string.match(Lunar.Speech.actionAssignNames[9], ":::(.*)");
							end

							--print("AssignByType (4114) : ", objectName, objectTexture, cursorType)
							_G[buttonName .. "Icon"]:SetTexture(objectTexture);
						else
							--print("AssignByType (4117) : ", objectName, objectTexture, cursorType)
							_G[buttonName .. "Icon"]:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background");
						end
					else
						-- random mounts get no unique picture
--						if (buttonType > 82) and (buttonType < 86)  then
--							objectTexture = string.match(Lunar.Speech.actionAssignNames[math.floor(buttonType / 10) + 1 + (buttonType - 83)], ":::(.*)");
--						elseif (buttonType == 86) then
--							objectTexture = string.match(Lunar.Speech.actionAssignNames[9], ":::(.*)");
--						end
						--print("AssignByType (4127) : ", buttonName .. "Icon", objectName, objectTexture, cursorType)
						_G[buttonName .. "Icon"]:SetTexture(objectTexture);
					end
					--print("AssignByType (4130) : ", buttonName .. "Icon", objectName, objectTexture, cursorType)
					SetPortraitToTexture(_G[buttonName .. "Icon"], _G[buttonName .. "Icon"]:GetTexture());
				end
			end
		end
		if (buttonID > 0) then
			button:SetAlpha(1);
--		end
--		if (buttonID > 0) then
			button:SetWidth(36);
			button:SetAttribute("width", 36);
		end
end
		if (buttonType == 100) then
			buttonTexture = "portrait";
		end

		-- If we have an action name, state that our button is no longer empty
		LunarSphereSettings.buttonData[button:GetID()].empty = false;

		-- Now set the actual action to be performed. For the trade click types,
		-- we don't store anything in the button, that way we don't USE the item
		-- that is to be traded.
		if (buttonType >= 110) and (buttonType < 120) then
			button:SetAttribute("*type-S" .. stance  .. clickType, "spell")
			button:SetAttribute("*spell-S" .. stance .. clickType, "")
		else
			-- Food and drink button types, weakest
			if (buttonType == 12) or (buttonType == 22) or (buttonType == 13) or (buttonType == 23) then
				cursorType = "macrotext"
				objectName = "/use " .. objectName1 .. "\n/use " .. objectName2;
				button:SetAttribute("*type-S" .. stance  .. clickType, "macrotext")
				button:SetAttribute("*macrotext-S" .. stance .. clickType, objectName)
			elseif (buttonType == 101) then
				cursorType = "macrotext"
				objectName = "/click SpellbookMicroButton";
				button:SetAttribute("*type-S" .. stance  .. clickType, "macrotext")
				button:SetAttribute("*macrotext-S" .. stance .. clickType, objectName)
			elseif (buttonType == 130) or (buttonType == 131) then
				cursorType = "macrotext"
				objectName = "/use " .. (buttonType - 117);
				button:SetAttribute("*type-S" .. stance  .. clickType, "macrotext")
				button:SetAttribute("*macrotext-S" .. stance .. clickType, objectName)
			elseif (buttonType == 133) then
				cursorType = "macrotext"
				objectName = "/equipset " .. objectName;
				button:SetAttribute("*type-S" .. stance  .. clickType, "macrotext")
				button:SetAttribute("*macrotext-S" .. stance .. clickType, objectName)
			-- Pet bars
			elseif (buttonType >= 140) and (buttonType < 150) then
--				cursorType = "pet"
				objectName = buttonType - 139;
				button:SetAttribute("*type-S" .. stance  .. clickType, "pet")
				button:SetAttribute("*action-S" .. stance .. clickType, objectName)
--				button:SetAttribute("shift-clickbutton" .. clickType, _G["PetActionButton" .. objectName]);
			elseif ((buttonType >= 80) and (buttonType < 90)) or (buttonType == 132) then

				--print("AssignByType (4180) : ", buttonName .. "Icon", objectName, objectTexture, cursorType, buttonType)
				--print("objectName (4180) : ", objectName, objectTexture)
				if (buttonType == 132) then
					button:SetAttribute("*type-S" .. stance  .. clickType, cursorType)
					button:SetAttribute("*"..cursorType .. "-S" .. stance .. clickType, objectName); -- tempName);
					button:SetAttribute("*"..cursorType .. "2-S" .. stance .. clickType, GetSpellInfo(objectName)); -- tempName);
				elseif (Lunar.API:IsVersionRetail() ) then
					--print("4194 : ", "*type-S" .. stance  .. clickType, "macrotext")
					button:SetAttribute("*type-S" .. stance  .. clickType, "macrotext")
--				local tempName = select(1, GetSpellInfo(objectName));
					button:SetAttribute("*macrotext-S" .. stance .. clickType, objectName); -- tempName);
					button:SetAttribute("*macrotext2-S" .. stance .. clickType, "/stopcasting\n/cast [nomounted] " .. (GetSpellInfo(objectName) or "")  .. "\n/dismount"); -- tempName);
--"/cast [nomounted] " .. objectName .. "\n/dismount"
				elseif (Lunar.API:IsVersionRetail() == false ) then
					-- OMG, could this be more complicated? We have to set
					-- the '*item-S01' attribute with the name of the fucking
					-- item we want to use, so it gets picked up when
					-- Lunar.Items:UpdateSpecialButtons() is called, so
					-- SetAttribute called THERE gets the correct item name
					-- and we use the mount. I mean, fuck you Blizzard for
					-- creating that stupid SecureActionButtonTemplate API.
					-- Fuck you PUC Rio for not properly supporting OOP in
					-- LUA so we could abstract this nonsense. And last but
					-- not least, fuck me for spending four hours trying to
					-- undertand this spaghetti code.

					button:SetAttribute("*"..cursorType .. "-S" .. stance .. clickType, objectName)
				end
			else
				button:SetAttribute("*type-S" .. stance  .. clickType, cursorType)
				button:SetAttribute("*"..cursorType .. "-S" .. stance .. clickType, objectName)
			end
			-- Call the update function of the button to map the new actions!
		end
		--print("SetButtonData (4212)", buttonID, stance, clickType, (lastUsedUpdate or buttonType), cursorType, objectName, objectTexture)
		Lunar.Button:SetButtonData(buttonID, stance, clickType, (lastUsedUpdate or buttonType), cursorType, objectName, objectTexture);

--		LunarSphereSettings.buttonData[buttonID]["actionType" .. clickType] = cursorType;
--		LunarSphereSettings.buttonData[buttonID]["actionName" .. clickType] = objectName;
--		LunarSphereSettings.buttonData[buttonID]["texture" .. clickType] = objectTexture;

		-- Make our icon fully visible
--		if (buttonID > 0) then
--			button:SetAlpha(1);
--		end

		-- Clear our cursor of what its holding and hide all the left over empty buttons
--		ClearCursor();

		Lunar.Button:HideEmptyMenuButtons();

	-- Clear our update cache
	Lunar.Button.updateType = nil;
	Lunar.Button.updateID = nil
	Lunar.Button.updateData = nil;

		-- Update the tooltip
--		Lunar.Button:SetTooltip(this);

		-- Update our button events
if (stance == button.currentStance) then
		button.registeredEvents = false;
		if (buttonID > 0) then
			Lunar.Button:Update(button);
		end
end
--	end
end

function Lunar.Button:UpdateBagDisplay(button, stance, clickType)

	if (Lunar.Button:GetButtonSetting(button:GetID(), stance, LUNAR_GET_SHOW_COUNT) == clickType) then

		local usedSlots = 0;
		local totalSlots = 0;
		local buttonType = Lunar.Button:GetButtonType(button:GetID(), stance, clickType);
		if (buttonType == 3) and (button.subButtonType) then -- and (button.subButtonType >= 90) and (button.subButtonType <= 95)) then
			buttonType = button.subButtonType;
		end
		if (buttonType == 4) and (button.subButtonType2) then -- and (button.subButtonType >= 90) and (button.subButtonType <= 95)) then
			buttonType = button.subButtonType2;
		end

		usedSlots, totalSlots = Lunar.Button:GetBagCountData(buttonType);
		
--		_G[button:GetName() .. "Count"]:SetText("|cFFFFCC44" .. usedSlots .. "/" .. totalSlots);
		if (usedSlots ~= "?") and (totalSlots ~= "?") and (totalSlots ~= 0) then
			_G[button:GetName() .. "Count"]:SetText("|cFFFFCC44" .. math.floor(tonumber(usedSlots) / tonumber(totalSlots) * 100) .. "%");
		else
			_G[button:GetName() .. "Count"]:SetText("");
		end
		_G[button:GetName() .. "Count"]:Show();
		LunarSphereSettings.buttonData[button:GetID()].showCount = true;
--		button.cooldownText:SetText(usedSlots .. "/" .. totalSlots);
--		button.cooldownTextFrame:SetScale(3/5);
--		button.cooldownText:Show();
	end
end

function Lunar.Button:GetBagCountData(buttonType)

	local usedSlots, totalSlots = 0, 0;

	-- All bags
	if (buttonType == 95) then
		local bagID;
		for bagID = 0, 4 do 
			usedSlots = usedSlots + (GetContainerNumFreeSlots(bagID) or 0);--(Lunar.Items.bagSlots[bagID] or 0);
			totalSlots = totalSlots + (GetContainerNumSlots(bagID) or 0);
		end
		usedSlots = totalSlots - usedSlots;
									
	-- Individual bags
	else
--		usedSlots = Lunar.Items.bagSlots[buttonType - 90] or "?";
		totalSlots = GetContainerNumSlots(buttonType - 90) or "?";
		if (totalSlots == "?") then
			usedSlots = "?";
		else
			usedSlots = totalSlots - (GetContainerNumFreeSlots(buttonType - 90) or 0);
		end
	end	

	return usedSlots, totalSlots;
end

function Lunar.Button:GetBagTexture(buttonType)

	local objectTexture = "Interface\\Paperdoll\\UI-PaperDoll-Slot-Bag";

	if (buttonType == 90) or (buttonType == 95) then
		objectTexture = "Interface\\Buttons\\Button-Backpack-Up";
	elseif (buttonType <= 94) then
		local objectName = GetBagName(buttonType - 90);
		if (objectName) then
			_,_,_,_,_,_,_,_,_, objectTexture = GetItemInfo(objectName);
		end
	else
		objectTexture = LUNAR_ART_PATH .. "menuKey";
	end

	return objectTexture;
	
end
-- /***********************************************
--  * Unassign
--  * ========================
--  *
--  * Unassigns all actions on a button (deleting it)
--  *
--  * Accepts: none (this is passed globally)
--  * Returns: none
--  *********************
function Lunar.Button:Unassign(self, buttonDeassign)

	local button = buttonDeassign or self;

	-- Create a local and store the name of the button
	local buttonName = button:GetName();

	-- Clear the button's action
	button:SetAttribute("*type-S01", "spell");
	button:SetAttribute("*type-S02", "spell");
	button:SetAttribute("*type-S03", "spell");
	button:SetAttribute("*spell-S01", "");
	button:SetAttribute("*spell-S02", "");
	button:SetAttribute("*spell-S03", "");

	-- Hide the count, remove the checked state...
	_G[buttonName .. "Count"]:Hide();
	button:SetChecked(false);

	-- Set the icon image to the "empty" image and make it a circle, and then make its alpha
	-- value 50% ... and then hide it if the button edit mode is off
	_G[buttonName .. "Icon"]:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background");
	SetPortraitToTexture(_G[buttonName .. "Icon"], _G[buttonName .. "Icon"]:GetTexture());
	_G[buttonName .. "Icon"]:SetAlpha(0.5);
	button:Hide();

	-- If the button is currently a menu, and this assignment will wipe all menu actions
	-- from the button, wipe the menu completely
	if (LunarSphereSettings.buttonData[button:GetID()].isMenu == true) then
		Lunar.Button:SetupAsMenu(button, 1, false)
		Lunar.Button:SetupAsMenu(button, 2, false)
		Lunar.Button:SetupAsMenu(button, 3, false)
		Lunar.Button:WipeMenu(button:GetID());
	end

	-- Reset the button data of the child buttons
	if (LunarSphereSettings.buttonData[button:GetID()].child == true) then
		_G["LunarSub" .. button:GetID() .. "Button"]:SetAttribute("showstates", "!*"); --!0,!1");
		if (LunarSphereSettings.submenuCompression) then
			button:SetWidth(4);
			button:SetAttribute("width", 4);
		end
	end

	Lunar.Button:ResetButtonData(button:GetID(), true);

	if (button:GetID() > 10) then
		_G["LunarMenu" .. button.parentID .. "ButtonHeader"]:SetAttribute("_bindingset", "");
	elseif (button:GetID() == 0) then
		_G["LunarSphereMainButtonHeader"]:SetAttribute("_bindingset", "");
		Lunar.Sphere:SetSphereTexture();
	else		
		_G["LunarSphereButtonHeader"]:SetAttribute("_bindingset", "");
	end

	Lunar.Button:SetupKeybinds(button);

	-- Update the button's events
	button.registeredEvents = false;
	Lunar.Button:Update(button);

end

-- /***********************************************
--  * LoadButtonData
--  * ========================
--  *
--  * Takes a buttonID of a saved button and attaches all the saved info to an
--  * in-game button. Basically, loads a saved button...
--  *
--  * Accepts: ButtonID to load
--  * Returns: none
--  *********************
function Lunar.Button:LoadButtonData(buttonID)

	-- If the button is not empty, continue
	if (not LunarSphereSettings.buttonData[buttonID].empty) then

		-- Create our locals
		local objectTexture, stackTotal, objectType, cursorType, objectName, clickType, buttonType, buttonName, macroBody;
		local uniqueID, newTexture, macroAction;

		-- Grab the name of the button. The first 10 buttons are menu buttons,
		-- the rest are sub menu buttons.
		if (buttonID > 10) then
			buttonName = "LunarSub" .. buttonID .. "Button";
		elseif (buttonID == 0) then
			buttonName = "LSmain";
		else
			buttonName = "LunarMenu" .. buttonID .. "Button";
		end

		if (not LunarSphereSettings.buttonData[buttonID].buttonSettings) and (buttonID > 0) then
			LunarSphereSettings.buttonData[buttonID].buttonSettings = string.rep("1110000", 13);
		elseif (not LunarSphereSettings.buttonData[buttonID].buttonSettings) and (buttonID == 0) then
			LunarSphereSettings.buttonData[buttonID].buttonSettings = string.rep("0000000", 13);
		end

		if (LunarSphereSettings.buttonData[buttonID].buttonSettings) then
			if (string.len(LunarSphereSettings.buttonData[buttonID].buttonSettings) < (13 * 7)) then
				LunarSphereSettings.buttonData[buttonID].buttonSettings = string.rep("1110000", 13);
			end
		end

		-- Make sure the icon is visible
		if (buttonID > 0) then
			_G[buttonName .. "Icon"]:SetAlpha(1);
			_G[buttonName .. "Icon"]:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background");
		end

		-- If the button is a menu button, attach its icon
--[[ might not need
		if (LunarSphereSettings.buttonData[buttonID].isMenu == true) then
			_,_,_,objectTexture = Lunar.Button:GetButtonData(buttonID, 0, Lunar.Button:GetButtonSetting(buttonID, Lunar.Button:GetAssignedStance(_G[buttonName]), LUNAR_GET_SHOW_ICON));
			_G[buttonName .. "Icon"]:SetTexture(objectTexture);
		end
--]]

		-- If the button is a child of a menu button, we make sure it's attached
		-- to that menu button
		if (LunarSphereSettings.buttonData[buttonID].parent) then
			-- Attach it
	--		LunarSphereSettings.buttonData[buttonID].stateID = 0;
-- don't think i'll need this ...
		end

		-- Honor its visibility rules
		if (LunarSphereSettings.buttonData[buttonID].visibilityRule) then
			-- 1 auto-show if in combat
			-- 2 auto-hide if in combat
			-- do nothing
		end

		-- not used yet
		-- LunarSphereSettings.buttonData[buttonID].buttonType1 = nil;

		local defaultButtonType, defaultActionType, defaultActionName, defaultButtonTexture
		local stance;
		local stanceHasData;

		-- Now, cycle through the possible click types and see if an action exists,
		-- if so, attach it
		LunarSphereSettings.buttonData[buttonID].showCount = nil;

		for clickType = 1, 3 do 

			for stance = 0, 12 do 
				
				-- Grab our data
				buttonType, cursorType, objectName, objectTexture = Lunar.Button:GetButtonData(buttonID, stance, clickType);
				if (cursorType == "item") and (string.find(objectName, "%a") == nil) and (string.len(objectName) > 0) then
					objectName = "item:" .. objectName;
					Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, objectName, objectTexture);
				end

				if (buttonType == 2) then
					cursorType = "spell"
					objectName = "";
				end

--				if (stance == 0) then
--					defaultActionType, defaultActionName, defaultButtonTexture = cursorType, objectName, objectTexture;
--				end

				-- Might not be needed
--				if (buttonType == 0) then
--					cursorType, objectName, objectTexture = defaultActionType, defaultActionName, defaultButtonTexture;
--				end

--				cursorType = LunarSphereSettings.buttonData[buttonID]["actionType" .. clickType];
--				objectName = LunarSphereSettings.buttonData[buttonID]["actionName" .. clickType];

				-- If there is an action to attach (because it's not a menu button), attach it
				if (cursorType) and (buttonType) then

					-- If it was a spell drag ...
					if (cursorType == "spell") then

						-- Fix the faerie fire (feral)
--						objectName = Lunar.API:FixFaerie(objectName);

						-- Support for spells with reagents
--						Lunar.Button:FindSpellReagent(_G[buttonName], stance, clickType, objectName, cursorType);

						-- Attach its texture to our button
	--					_G[buttonName .. "Icon"]:SetTexture(LunarSphereSettings.buttonData[buttonID].texture1);

					-- If it was an item drag ...
					elseif (cursorType == "item") then

--[[						if IsConsumableItem(objectName) then
							uniqueID = select(10, string.find(objectName, "^item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+)"));
							if (uniqueID) and (uniqueID ~= "0")  then
								objectName = string.gsub(objectName, ":-" .. uniqueID, "");
								objectName = string.gsub(objectName, ":" .. uniqueID, "");
								Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, objectName, objectTexture);
							end
						end
--]]
						-- Get the name of the item, what it can stack as, and its texture
						_, _, _, _, _, _, objectType, stackTotal = GetItemInfo(objectName);

						-- If the item is consumable, or can stack, or we set it to show a count ... we will show the
						-- count of the item on the button
						if (stance == Lunar.Button:GetAssignedStance(_G[buttonName])) then
							if (clickType == Lunar.Button:GetButtonSetting(buttonID, stance, LUNAR_GET_SHOW_COUNT)) then
								if (buttonID > 0) then
									if (stackTotal) then
										if ((objectName == "item:6265") or IsConsumableItem(objectName) or (stackTotal > 1) or (objectType == Lunar.Items.reagentString) or (LunarSphereSettings.buttonData[buttonID].showCount == true)) then
											_G[buttonName .. "Count"]:SetText(GetItemCount(objectName));
	--										if (clickType == Lunar.Button:GetButtonSetting(buttonID, stance, LUNAR_GET_SHOW_COUNT)) then
												LunarSphereSettings.buttonData[buttonID].showCount = true;
	--										end
										end
									else
										_G[buttonName .. "Count"]:SetText(0);
										LunarSphereSettings.buttonData[buttonID].showCount = true;
									end
								end
							end
						end
								
						-- Set the button's texture
	--					_G[buttonName .. "Icon"]:SetTexture(LunarSphereSettings.buttonData[buttonID].texture1);

					-- If it was a macro drag ...
					elseif (cursorType == "macro") then

						-- Grab the macro information and set the new texture. Since a macro's
						-- texture might have changed, we load the current one, not the saved
						-- one.

--						objectName, objectTexture = GetMacroInfo(objectName);

						objectName, objectTexture, macroBody = GetMacroInfo(objectName);
						if (not objectName) then
							buttonType = 0;
						else
							macroAction = GetActionFromMacroText(macroBody);
							if (macroAction) then
								_,_,_,_,_,_,_,_,_,newTexture = GetItemInfo(macroAction);
								if not newTexture then
									newTexture = GetSpellTexture(macroAction);
								end
							end
							if string.find(macroBody, "#show") and not string.find(macroBody, "#showt") then
							if (newTexture) and (newTexture ~= objectTexture) then -- or string.find(macroBody, "#show ") then
								objectTexture = newTexture;
							end
							end
						end

	--					_G[buttonName .. "Icon"]:SetTexture(objectTexture);
						Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, nil, nil, objectTexture);

--						LunarSphereSettings.buttonData[buttonID]["texture" .. clickType] = objectTexture;
						_G[buttonName].updateIcon = true;
	
					end

					if (buttonType == 130) or (buttonType == 131) then
						objectTexture = GetInventoryItemTexture("player", buttonType - 117) or ("Interface\\Icons\\INV_Misc_QuestionMark");
						Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, nil, nil, objectTexture);
--					end

--					_G[buttonName .. "Icon"]:SetTexture(LunarSphereSettings.buttonData[buttonID].texture1);

					-- If the button type is a trade type, we need to wipe the
					-- data so we don't USE the item to be traded.
					elseif (buttonType >= 110) and (buttonType < 120)  then
						cursorType = "spell";
						objectName = "";
--					end

					elseif (buttonType >= 52) and (buttonType < 60)  then
						if (math.fmod(buttonType, 2) == 0) then
							_G[buttonName]:SetAttribute("target-slot-S" .. stance .. clickType, GetInventorySlotInfo("MainHandSlot"));
						else
							_G[buttonName]:SetAttribute("target-slot-S" .. stance .. clickType, GetInventorySlotInfo("SecondaryHandSlot"));
						end

					-- Apply to weapon types
					elseif (buttonType >= 120) and (buttonType < 130) then
						if (buttonType == 120) then
							_G[buttonName]:SetAttribute("target-slot-S" .. stance .. clickType, GetInventorySlotInfo("MainHandSlot"));
						elseif (buttonType == 121) then
							_G[buttonName]:SetAttribute("target-slot-S" .. stance .. clickType, GetInventorySlotInfo("SecondaryHandSlot"));
						elseif (buttonType == 122) then
							_G[buttonName]:SetAttribute("target-slot-S" .. stance .. clickType, GetInventorySlotInfo("RangedSlot"));
						end
					end

					-- Now set the actual action to be performed
					if (cursorType == "macrotext") then
						_G[buttonName]:SetAttribute("*type-S" .. stance .. clickType, "macrotext")
						_G[buttonName]:SetAttribute("*" ..cursorType .. "-S" .. stance .. clickType, objectName)
					else
						if (buttonType >= 140) and (buttonType < 150) then
							_G[buttonName]:SetAttribute("*type-S" .. stance .. clickType, "pet")
							_G[buttonName]:SetAttribute("*" .."action" .. "-S" .. stance .. clickType, buttonType - 139)
						elseif (cursorType == "flyout") then
							_G[buttonName]:SetAttribute("*type-S" .. stance .. clickType, "flyout")
							_G[buttonName]:SetAttribute("*" .."spell" .. "-S" .. stance .. clickType, objectName)
						else
							_G[buttonName]:SetAttribute("*type-S" .. stance .. clickType, cursorType)
							_G[buttonName]:SetAttribute("*" ..cursorType .. "-S" .. stance .. clickType, objectName)
							if (tostring(tonumber(objectName)) == objectName) then
								_G[buttonName]:SetAttribute("*" ..cursorType .. "2-S" .. stance .. clickType, GetSpellInfo(objectName));
								_G[buttonName]:SetAttribute("*" ..cursorType .. "-S" .. stance .. clickType, objectName);
							end
						end
					end							

					--modifier needs * before type and cursorType

					if (LunarSphereSettings.buttonData[buttonID].child) then
						_G[buttonName]:SetAttribute("showstates", "0,!30");
					end
				else
					_G[buttonName]:SetAttribute("*type-S" .. stance .. clickType, "none"); --"spell")
					_G[buttonName]:SetAttribute("*spell-S" .. stance .. clickType, "")
				end

				-- Attach its texture to our button
				if (buttonID > 0) then
					if (stance == Lunar.Button.defaultStance) and (clickType == Lunar.Button:GetButtonSetting(buttonID, stance, LUNAR_GET_SHOW_ICON)) then
						_G[buttonName]:SetAlpha(1);
						if not (objectTexture) or (not buttonType) then
							objectTexture = "Interface\\DialogFrame\\UI-DialogBox-Background";
							if (not buttonType) then
								if not (Lunar.Button:ButtonHasAction(buttonID, stance)) then
									_G[buttonName]:SetAlpha(0.5);
									_G[buttonName .. "Icon"]:SetAlpha(0.5);
								end
							end
						end
	--					else
	--						_G[buttonName]:SetAlpha(1);
	--					end
						_G[buttonName .. "Icon"]:SetTexture(objectTexture);
					end
				end

				-- Next, check the button type and act based upon its type
--				buttonType = LunarSphereSettings.buttonData[buttonID]["buttonType" .. clickType];
				if (buttonType) then
					if (buttonType == 2) then -- and (stance == 0) then
						Lunar.Button:SetupAsMenu(_G[buttonName], clickType)
					end
					
					-- Self-cast and focus-cast button types will set the target to the player or focus
					if (buttonType == 5) then
						_G[buttonName]:SetAttribute("unit-S" .. stance .. clickType, "player");
					elseif (buttonType == 6) then
						_G[buttonName]:SetAttribute("unit-S" .. stance .. clickType, "focus");
					else
						_G[buttonName]:SetAttribute("unit-S" .. stance .. clickType, "");
					end

					if (buttonType >= 90) and (buttonType <= 95) then
						if (buttonID > 0) then
							if (Lunar.Button:GetButtonSetting(buttonID, stance, LUNAR_GET_SHOW_COUNT) == clickType) then
								Lunar.Button:UpdateBagDisplay(_G[buttonName], stance, clickType);
							end
						end
					end
				end
		
				if (buttonID == 0) then
					_G[buttonName]:SetAttribute("CTRL-type-S" .. stance .. clickType, "spell")
					_G[buttonName]:SetAttribute("CTRL-spell-S" .. stance .. clickType, "")
				end

			end

			-- Stance Support turned off
	--		_G[buttonName]:SetAttribute("statebutton1", "S01");
	--		_G[buttonName]:SetAttribute("statebutton2", "S02");
	--		_G[buttonName]:SetAttribute("statebutton3", "S03");

		end

		if (buttonID > 0) then
			-- Set the width of the button
			_G[buttonName]:SetAttribute("width", 36);
			_G[buttonName]:SetWidth(36);

			-- Show or hide the counter as needed
			if (LunarSphereSettings.buttonData[buttonID].showCount == true) then
				_G[buttonName .. "Count"]:Show();
			else
				_G[buttonName .. "Count"]:Hide();
			end				

--			-- Make our icon fully visible and cut it into a circle
--			SetPortraitToTexture(_G[buttonName .. "Icon"], _G[buttonName .. "Icon"]:GetTexture());

			-- If the button type is 100 (character tab button), reskin it to show the current player portrait
			if (Lunar.Button:GetButtonType(buttonID, Lunar.Button.defaultStance, 1) == 100) then
				SetPortraitTexture(_G[buttonName .. "Icon"], "player");
			end
			
			-- Croq added a check to see if it was the portrait icon. If it is then don't make it circular since it already is
			-- Make our icon fully visible and cut it into a circle
			if not (_G[buttonName .. "Icon"]:GetTexture() == "RTPortrait1") then
				SetPortraitToTexture(_G[buttonName .. "Icon"], _G[buttonName .. "Icon"]:GetTexture());
			end
			
		else
			Lunar.Sphere:SetSphereTexture();
		end

		Lunar.Button:SetupStances(_G[buttonName]);

		-- Update the button's events
		if (buttonID >= 0) then
			_G[buttonName].registeredEvents = nil;
			_G[buttonName].cooldownID = Lunar.Button:GetButtonSetting(buttonID, Lunar.Button:GetAssignedStance(_G[buttonName]), LUNAR_GET_SHOW_COOLDOWN)
			_G[buttonName].actionTypeCooldown = nil;
		end

		Lunar.Button:SetupKeybinds(_G[buttonName]);

		if (buttonID > 0) then
			Lunar.Button:Update(_G[buttonName]);
		else
			_G["LSmain"].currentStance = Lunar.Button.defaultStance	
			if not timerData[0] then
				timerData[0] = {};
			end
			timerData[0].cooldownElapsed = 0;
			timerData[0].cooldownTimer = nil;
			_G["LSmain"]:RegisterEvent("SPELL_UPDATE_COOLDOWN");
			_G["LSmain"]:RegisterEvent("BAG_UPDATE_COOLDOWN");
			_G["LSmain"].actionTypeCooldown = nil;
			_G["LSmain"].actionTypeCount = nil;
			if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COUNT) then
				Lunar.Sphere:SetSphereText("");
			end
			Lunar.Button:UpdateUsable(_G["LSmain"]);
			Lunar.Button.UpdateCooldown(_G["LSmain"]);
			Lunar.Button:UpdateCount(_G["LSmain"]);
		end
	else
		Lunar.Button:ResetButtonData(buttonID, true);
	end

end

function Lunar.Button:FindSpellReagent(button, stance, clickType, actionName, cursorType)

	if (stance == 0) and (clickType == 1) then
		button.spellReagent = nil;
	end

	--If our current stance is being checked and our action type is a spell, continue
	if (stance == Lunar.Button:GetAssignedStance(button)) and (cursorType == "spell") then

		-- If the click we're checking is the one to show the count, continue
		if (clickType == Lunar.Button:GetButtonSetting(button:GetID(), stance, LUNAR_GET_SHOW_COUNT)) or (clickType == -1) then

			-- Reset our values and clean up our temp tooltip
			button.spellReagent = nil;
			Lunar.Items.tooltip:ClearLines();
			Lunar.Items.tooltip:SetOwner(UIParent, "ANCHOR_NONE");

			-- Grab the spell ID of the spell. If we have an ID (the spell exists), continue
			local spellID, spellRank = Lunar.API:GetSpellID(actionName);
			if (spellID) then

				-- Set our locals, then set our spell to the temp tooltip
				local textLine, searchText, textContainer;
				LunarSphereSettings.buttonData[button:GetID()].showCount = false;
				Lunar.Items.tooltip:SetSpellBookItem(spellID, BOOKTYPE_SPELL);

				-- Scan each line until all have been scanned or a match was found
				for textLine = 2, Lunar.Items.tooltip:NumLines() do
					searchText = nil;
					textContainer = _G[Lunar.Items.tooltip:GetName() .. "TextLeft" .. textLine];
					if (textContainer) then
						searchText = textContainer:GetText();
					end
					if (searchText) then

						-- Check if there is reagent text. If so, we grab the reagent name
						if string.find(searchText, SPELL_REAGENTS) then
							button.spellReagent = string.match(searchText, SPELL_REAGENTS .. "(.*)")

							-- Now, if we don't have the reagent in-stock, the name
							-- will be red. We MUST strip the color codes or else future
							-- calls to this name will fail.
							if (string.sub(button.spellReagent, 1, 2) == "|c") then
								button.spellReagent = string.sub(button.spellReagent, 11);
								button.spellReagent = string.gsub(button.spellReagent, "|r", "");
							end

							-- Set the button up to show counts and exit the loop
							LunarSphereSettings.buttonData[button:GetID()].showCount = true;
							break;
						end
					end
				end
			end
		end
	end
end

function Lunar.Button:GetUseStances(buttonID, useCached)

	local useStances;
	if (useCached == true) then
		useStances = Lunar.Button.useStances;
	else
		useStances = LunarSphereSettings.buttonData[buttonID].useStances;
		if (buttonID > 10) then
			useStances = LunarSphereSettings.buttonData[_G["LunarSub" .. buttonID .. "Button"].parentID].useStances;
		end
	end
	if not (useStances == true) then
		useStances = nil;
	end
	return useStances;
	
end

function Lunar.Button:ButtonHasAction(buttonID, stance)

	if (not buttonID) or (not LunarSphereSettings.buttonData[buttonID]) then
		return;
	end

	stance = stance or 0;

	if (LunarSphereSettings.buttonData[buttonID].buttonTypeData) then
		if not (string.sub(LunarSphereSettings.buttonData[buttonID].buttonTypeData, stance * 9 + 1, (stance + 1) * 9) == "000000000") then
			return true;
		end
	end

end

function Lunar.Button:SetupStances(button)

	local useStances = Lunar.Button:GetUseStances(button:GetID());
	local header;

	if (button:GetID() > 10) then
		header = _G["LunarMenu" .. button.parentID .. "ButtonHeader"];
	elseif (button:GetID() == 0) then
		header = _G["LunarSphereMainButtonHeader"];
	else
		header = _G[button:GetName() .. "Header"];
	end

	if (useStances) then
		if not header.stanceOn then
			header.stanceOn = true;
			local extraStanceInfo = "[stance:2] 2; [stance:3] 3; ";
			if ((select(2, UnitClass("player"))) == "ROGUE") then
				extraStanceInfo = "[bonusbar:1] 3; [stance:2] 3; [stance:3] 3; ";
			end
			RegisterStateDriver(header, "state", "[bonusbar:5] 15; [stance:1] 1; " .. extraStanceInfo ..  "[stance:4] 4; [stance:5] 5; [stance:6] 6; [stance:7] 7; " .. Lunar.Button.defaultStance);
		end
		button:SetScript("OnAttributeChanged", Lunar.Button.UpdateState)
	else
--		if header.stanceOn then
--			header.stanceOn = nil;
			RegisterStateDriver(header, "state", "[bonusbar:5] 15; [stance:*] " .. Lunar.Button.defaultStance .. "; " .. Lunar.Button.defaultStance);
--		end
		button:SetScript("OnAttributeChanged", nil);
	end


--[[
		if (button:GetID() > 10) then
			_G["LunarMenu" .. button.parentID .. "ButtonHeader"]:SetAttribute("statemap-stance", "$input");
		end

		-- Stance Support turned on, if we're not in button edit mode
		if not (LunarSphereSettings.buttonEditMode == true) then
--			button:SetAttribute("*statebutton1", "0:S01;1:S11;2:S21;3:S31;4:S41;5:S51;6:S61;7:S71;8:S81;9:S91;10:S101;11:S111;12:S121;30:S01;31:S11;32:S21;33:S31;34:S41;35:S51;36:S61;37:S71;38:S81;39:S91;40:S101;41:S111;42:S121")
			button:SetAttribute("*statebutton1", "0,30:S01;1,31:S11;2,32:S21;3,33:S31;4,34:S41;5,35:S51;6,36:S61;7,37:S71;8,38:S81;9,39:S91;10,40:S101;11,41:S111;12,42:S121;")
			button:SetAttribute("*statebutton2", "0:S02;1:S12;2:S22;3:S32;4:S42;5:S52;6:S62;7:S72;8:S82;9:S92;10:S102;11:S112;12:S122;")
			button:SetAttribute("*statebutton3", "0:S03;1:S13;2:S23;3:S33;4:S43;5:S53;6:S63;7:S73;8:S83;9:S93;10:S103;11:S113;12:S123;")
		end

		-- If the stance changes on the button, we need to update the icon picture
		button:SetScript("OnAttributeChanged", Lunar.Button.UpdateState)
		button:SetAttribute("newstate");

	else

		if (button:GetID() > 10) then
			_G["LunarMenu" .. button.parentID .. "ButtonHeader"]:SetAttribute("statemap-stance", "");
		end

		-- Stance Support turned off, if we're not in button edit mode
		if not (LunarSphereSettings.buttonEditMode == true) then
			button:SetAttribute("*statebutton1", "*:S" .. Lunar.Button.defaultStance .. "1")
			button:SetAttribute("*statebutton2", "*:S" .. Lunar.Button.defaultStance .. "2")
			button:SetAttribute("*statebutton3", "*:S" .. Lunar.Button.defaultStance .. "3")
		end
		-- Remove any attribute changing stuff
		button:SetAttribute("newstate");
		button:SetScript("OnAttributeChanged", nil)
	end
--]]
	
end

function Lunar.Button:SetupKeybinds(button)

	local buttonID = button:GetID();

	-- Wipe the keybind entry if all clicks are set as undefined keybinds (if the user deletes them)
	if (LunarSphereSettings.buttonData[buttonID].keybindData == "||001|| ||002|| ||003|| ||00X|| ") then
		LunarSphereSettings.buttonData[buttonID].keybindData = nil;
	end
	local keybindData = "";
	ClearOverrideBindings(button);
	if LunarSphereSettings.buttonData[buttonID].keybindData then
		local keybind = Lunar.Button:GetButtonKeybind(buttonID, 0, 1);
		if (keybind) then
			keybindData = keybindData .. keybind .. ";" --:LeftButton;";
--			keybindData = keybindData .. "*" .. keybind .. ";" --:LeftButton;";
--			SetOverrideBindingClick(button, true, keybind, button:GetName(), "LeftButton");
		else
			keybindData = keybindData .. ";";	
		end
		keybind = Lunar.Button:GetButtonKeybind(buttonID, 0, 2);
		if (keybind) then
			keybindData = keybindData .. keybind .. ";" --:MiddleButton;";
--			keybindData = keybindData .. "*" .. keybind .. ";" --:MiddleButton;";
--			SetOverrideBindingClick(button, true, keybind, button:GetName(), "MiddleButton");
		else
			keybindData = keybindData .. ";";	
		end
		keybind = Lunar.Button:GetButtonKeybind(buttonID, 0, 3);
		if (keybind) then
			keybindData = keybindData .. keybind .. ";" --:RightButton;";
--			keybindData = keybindData .. "*" .. keybind .. ";" --:RightButton;";
--			SetOverrideBindingClick(button, true, keybind, button:GetName(), "RightButton");
		else
			keybindData = keybindData .. ";";	
		end
	end
	button:SetAttribute('bindings-S0', keybindData);
end

-- /***********************************************
--  * ResetButtonData
--  * ========================
--  *
--  * Wipes the saved button entry and resets it (good for when you delete a button)
--  *
--  * Accepts: ButtonID to wipe
--  * Returns: none
--  *********************
function Lunar.Button:ResetButtonData(buttonID, keepAsChild)

	if (not LunarSphereSettings.buttonData[buttonID]) then
		LunarSphereSettings.buttonData[buttonID] = {};
	end

	-- Reset all the values to nil
	local key, value;
	for key, value in pairs(LunarSphereSettings.buttonData[buttonID]) do
		if (LunarSphereSettings.buttonData[buttonID][key]) then
			if (key == "child") then
				if (not keepAsChild) then
					LunarSphereSettings.buttonData[buttonID].child = false;
				end	
			else
				LunarSphereSettings.buttonData[buttonID][key] = nil;
			end
		end
	end

	LunarSphereSettings.buttonData[buttonID].empty = true;

--	LunarSphereSettings.buttonData[buttonID].actionType1 = nil;
--	LunarSphereSettings.buttonData[buttonID].actionName1 = nil;
--	LunarSphereSettings.buttonData[buttonID].buttonType1 = nil;
--	LunarSphereSettings.buttonData[buttonID].actionType2 = nil;
--	LunarSphereSettings.buttonData[buttonID].actionName2 = nil;
--	LunarSphereSettings.buttonData[buttonID].buttonType2 = nil;
--	LunarSphereSettings.buttonData[buttonID].actionType3 = nil;
--	LunarSphereSettings.buttonData[buttonID].actionName3 = nil;
--	LunarSphereSettings.buttonData[buttonID].buttonType3 = nil;
--	LunarSphereSettings.buttonData[buttonID].isMenu = nil;
--	LunarSphereSettings.buttonData[buttonID].parent = nil;
--	LunarSphereSettings.buttonData[buttonID].stateID = nil;
--	LunarSphereSettings.buttonData[buttonID].visibilityRule = nil;
--	LunarSphereSettings.buttonData[buttonID].showCount = nil;
--	LunarSphereSettings.buttonData[buttonID].texture1 = nil;
--	LunarSphereSettings.buttonData[buttonID].texture2 = nil;
--	LunarSphereSettings.buttonData[buttonID].texture3 = nil;

--	if (not keepAsChild) then
--		LunarSphereSettings.buttonData[buttonID].child = false;
--	end
			

end

-- /***********************************************
--  * ResetAllButtons
--  * ========================
--  *
--  * Resets all buttons (imagine that)
--  *
--  * Accepts: none
--  * Returns: none
--  *********************
function Lunar.Button:ResetAllButtons()

	-- Local creation
	local index, buttonName;

	-- Search for each button
	for index=1, 10 do 

		-- Store the name of the button
		buttonName = "LunarMenu" .. index .. "Button";

		-- Clear the button's action and state that it's empty
		_G[buttonName]:SetAttribute("*spell", "");

		-- Hide the count, remove the checked state...
		_G[buttonName .. "Count"]:Hide();
		_G[buttonName]:SetChecked(false);

		-- Set the icon image to the "empty" image and make it a circle, and then make its alpha
		-- value 50% ... and then hide it
		_G[buttonName .. "Icon"]:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background");
		SetPortraitToTexture(_G[buttonName .. "Icon"], _G[buttonName .. "Icon"]:GetTexture());
		_G[buttonName .. "Icon"]:SetAlpha(0.5);
		_G[buttonName]:Hide();

		-- Reset the saved button data
		Lunar.Button:ResetButtonData(_G[buttonName]:GetID());

		-- Update the button's events
		_G[buttonName].registeredEvents = nil;
		Lunar.Button:Update(_G[buttonName]);

	end
	
end

Lunar.eventHandler = {
	["PLAYER_TARGET_CHANGED"] = Lunar.Button.UpdateUsable,
	["UNIT_AURA"] = function (self)
		Lunar.Button:UpdateUsable(self);
		Lunar.Button:UpdateSpellState(self);
	end,
	["UNIT_INVENTORY_CHANGED"] = function (self, event, arg1)
		if ( arg1 == "player" ) then
			if (self.buttonType == 130) or 
			   (self.buttonType == 131) or 
			   ((self.buttonType == 3) and (self.subButtonType) and ((self.subButtonType == 130) or (self.subButtonType == 131))) or
			   ((self.buttonType == 4) and (self.subButtonType2) and ((self.subButtonType2 == 130) or (self.subButtonType2 == 131))) then
				Lunar.Button.updateCounterFrame.elapsed = 0.2
				self.updateIcon = true;
			end
			Lunar.Button:Update(self, true);
		end
	end,
	["BAG_UPDATE"] = function (self) self.bagUpdate = true; Lunar.Button.updateCounterFrame.elapsed = 0.2; end,
	["UPDATE_INVENTORY_ALERTS"] = function (self)
		if (Lunar.Button.updateCounterFrame.elapsed < 0.2) then
			Lunar.Button.updateCounterFrame.elapsed = 0.2
		end
		timerData[self:GetID()].rangeTimer = -15;
	end,
	["SPELL_UPDATE_USABLE"] = function (self)
		if (Lunar.Button.updateCounterFrame.elapsed < 0.2) then
			Lunar.Button.updateCounterFrame.elapsed = 0.2
		end
		timerData[self:GetID()].rangeTimer = -15;
	end,
	["SPELL_UPDATE_COOLDOWN"] = function (self)
--		if (arg1) then
			Lunar.Button.UpdateCooldown(self, "spell");
--		end
	end,
	["BAG_UPDATE_COOLDOWN"] = function (self)
		Lunar.Button.UpdateCooldown(self, "item");
		Lunar.Button:UpdateCount(self);
	end,
	["PET_BAR_UPDATE"] = function (self)
		if ((self.buttonType >= 140) and (self.buttonType < 150)) or 
		((self.buttonType == 3) and (self.subButtonType) and (self.subButtonType >= 140) and (self.subButtonType < 150)) or
		((self.buttonType == 4) and (self.subButtonType2) and (self.subButtonType2 >= 140) and (self.subButtonType2 < 150)) then
			local texture, isToken, isActive, isAuto;

			if (self.buttonType == 3) then
				_, _, texture, isToken, isActive, _, autoOn  = GetPetActionInfo(self.subButtonType - 139);
			elseif (self.buttonType == 4) then
				_, _, texture, isToken, isActive, _, autoOn = GetPetActionInfo(self.subButtonType2 - 139);
			else
				_, _, texture, isToken, isActive, _, autoOn = GetPetActionInfo(self.buttonType - 139);
			end
			texture = texture or ("Interface\\AddOns\\LunarSphere\\Art\\blankIcon.blp");
			local icon;
			if (self:GetID() > 0) then
				icon = _G[self:GetName() .. "Icon"];
				if ( not isToken ) then
					icon:SetTexture(texture);
				else
					icon:SetTexture(_G[texture]);
				end
				SetPortraitToTexture(icon, icon:GetTexture());

				-- Update the "active" glow
				local border = _G[self:GetName().."Border"];
				if (autoOn) then
					border:SetVertexColor(0,1,0);
					border:Show();
				else
					if (isActive) then
						border:SetVertexColor(1,1,0);
						border:Show();
					else
						border:Hide();
					end
				end
			else
				if (LunarSphereSettings.useSphereClickIcon == true) then
					icon = _G["LSsphere"];
					if ( not isToken ) then
						icon:SetNormalTexture(texture);
					else
						icon:SetNormalTexture(_G[texture]);
					end
					SetPortraitToTexture(icon:GetNormalTexture(), icon:GetNormalTexture():GetTexture());
				end	
			end
		end

		-- Update the action names...
		if (Lunar.combatLockdown ~= true) then
			local clickType;
			for clickType = 1, 3 do
				if (self:GetAttribute("*type" .. clickType) == "pet") then
					self:SetAttribute("shift-macrotext" .. clickType, "/petautocasttoggle " .. ( GetPetActionInfo(tonumber(self:GetAttribute("*action" .. clickType) or "1")) or ("")) );
				end
			end
		end
	end,
	["PET_BAR_UPDATE_COOLDOWN"] = function (self)
		Lunar.Button.UpdateCooldown(self, "pet");
	end,
	["PLAYER_ENTERING_WORLD"] = function (self)
		self.registeredEvents = false;
		Lunar.Button:Update(self);
	end,
	["MODIFIER_STATE_CHANGED"] = function (self)
		if (self.actionType == "macro") then
			Lunar.Button:UpdateSpellState(self);
		end
	end,
	["ACTIONBAR_UPDATE_STATE"] = function (self)
		Lunar.Button:UpdateSpellState(self);
	end,
	["ACTIONBAR_SLOT_CHANGED"] = function (self)
		Lunar.Button:UpdateSpellState(self);
	end,
--	["CURRENT_SPELL_CAST_CHANGED"] = function (self)
--		Lunar.Button:UpdateSpellState(self);
--	end,
	["UPDATE_SHAPESHIFT_FORM"] = function (self)
		Lunar.Button:UpdateSpellState(self);
	end,
	["SPELL_ACTIVATION_OVERLAY_GLOW_HIDE"] = function (self, event, arg1)
		if (self.buttonType == 1) then
			-- Get spell ID and check it against the arg
			local _, spellID = GetSpellBookItemInfo((GetSpellInfo(self.actionName)) or "");
			if (spellID == arg1) then
				self.procGlow:Hide();
				self.procGlowShown = nil;
			end
		end			
	end,
	["SPELL_ACTIVATION_OVERLAY_GLOW_SHOW"] = function (self, event, arg1)
		if (self.buttonType == 1) then
			-- Get spell ID and check it against the arg
			local _, spellID = GetSpellBookItemInfo((GetSpellInfo(self.actionName)) or "");
			if (spellID == arg1) then
				self.procGlow:Show();
				self.procGlowShown = true;
			end
		end			
	end,
};

-- /***********************************************
--  * OnEvent
--  * ========================
--  *
--  * Handles events that the button intercepts
--  *
--  * Accepts: event passed
--  * Returns: none
--  *********************
function Lunar.Button.OnEvent(self, event, ...) --event)
	if Lunar.eventHandler[event] then
		Lunar.eventHandler[event](self, event, ...);
	elseif ( event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		Lunar.Button:UpdateSpellState(self);
	end
end

function Lunar.Button.UpdateState(self, stateData)

	-- This function can fire a lot, so we only want to capture one of the events and work with that.
	-- Doing so will save some CPU cycles.

	if (stateData == "state-parent") or ("newstate") then

		if (self.currentStance == Lunar.Button:GetAssignedStance(self)) then
			return;
		else
			self.buttonType = nil;
			self.actionTypeCooldown = nil;
			self.actionTypeCount = nil;
			self.currentStance = Lunar.Button:GetAssignedStance(self);
		end

		if (self:GetID() > 0) then
			self.cooldownID = Lunar.Button:GetButtonSetting(self:GetID(), self.currentStance, LUNAR_GET_SHOW_COOLDOWN)
		end

		local buttonType, actionType, actionName, buttonTexture = Lunar.Button:GetButtonData(self:GetID(), self.currentStance, Lunar.Button:GetButtonSetting(self:GetID(), self.currentStance, LUNAR_GET_SHOW_ICON));
		if not (buttonTexture) or (not buttonType) then
			buttonTexture = "Interface\\DialogFrame\\UI-DialogBox-Background";
		end

		if (self:GetID() > 0) then
			self:SetAlpha(1);
			_G[self:GetName() .. "Icon"]:SetAlpha(1);

			if not (buttonType) then
				if (self:GetID() > 10) then
					self:SetAlpha(0.5);
				end
				_G[self:GetName() .. "Icon"]:SetAlpha(0.5);
			end

			if (buttonType ~= 100) then
				_G[self:GetName() .. "Icon"]:SetTexture(buttonTexture);
				SetPortraitToTexture(_G[self:GetName() .. "Icon"], _G[self:GetName() .. "Icon"]:GetTexture());
			else
				SetPortraitTexture(_G[self:GetName() .. "Icon"], "player");
			end

		else
			Lunar.Sphere:SetSphereTexture();
		end

		local showActionCount = Lunar.Button:GetButtonSetting(self:GetID(), self.currentStance, LUNAR_GET_SHOW_COUNT);
		LunarSphereSettings.buttonData[self:GetID()].showCount = false;

		if (self:GetID() > 0) then
			if (showActionCount) then
				if (showActionCount > 0) then
					_, actionType, actionName = Lunar.Button:GetButtonData(self:GetID(), self.currentStance, showActionCount);

					if (actionType == "item") then
						local objectName, _, _, _, _, _, objectType, stackTotal = GetItemInfo(actionName);

						if (objectName) then
							if (IsConsumableItem(objectName) or (stackTotal > 1) or (objectType == Lunar.Items.reagentString)) then
				--				_G[self:GetName() .. "Count"]:SetText(GetItemCount(objectID));

				--				if (not LunarSphereSettings.showAssignedCounts == true) then
				--					_G[buttonName .. "Count"]:Show();
									LunarSphereSettings.buttonData[self:GetID()].showCount = true;
				--				end
							end
						end
					end
				end
			end

			if (buttonType) then
				if (buttonType >= 90) and (buttonType <= 95)  then
					Lunar.Button:UpdateBagDisplay(self, self.currentStance, Lunar.Button:GetButtonSetting(self:GetID(), self.currentStance, LUNAR_GET_SHOW_ICON))
				end
			end

			Lunar.Button:Update(self);
		end
	end
end

-- /***********************************************
--  * Update
--  * ========================
--  *
--  * Updates the recognized events of the button
--  *
--  * Accepts: button to update
--  * Returns: none
--  *********************
function Lunar.Button:Update(self, countOnly)

	-- Update the item count on the button
--	Lunar.Button:UpdateCount(this);
--	Lunar.Button:UpdateCooldown(this);

	local clickType, registerEvents, buttonType, actionType, actionName;

--	for clickType = 1, 3 do
--		buttonType = Lunar.Button:GetButtonType(self:GetID(), this.currentStance, clickType);
--		if (buttonType) then
--			if (buttonType == 1) or (buttonType > 2)  then
				registerEvents = true;
--				break;
--			end
--		end
--	end

	if not countOnly then

		self.buttonType = nil;
		self.actionTypeCooldown = nil;
		self.actionTypeCount = nil;
		self.buttonType, self.actionType, self.actionName = Lunar.Button:GetButtonData(self:GetID(), self.currentStance, Lunar.Button:GetButtonSetting(self:GetID(), self.currentStance, LUNAR_GET_SHOW_ICON));
		if (self.actionType == "spell") then
--			this.actionName = Lunar.API:FixFaerie(this.actionName);
		end

		--_, actionType, actionName = Lunar.Button:GetButtonData(self:GetID(), this.currentStance, Lunar.Button:GetButtonSetting(self:GetID(), this.currentStance, LUNAR_GET_SHOW_COUNT));
		actionType, actionName = self.actionType, self.actionName;
--		Lunar.Button:FindSpellReagent(this, this.currentStance, Lunar.Button:GetButtonSetting(self:GetID(), this.currentStance, LUNAR_GET_SHOW_COUNT), actionName, actionType)

	end

	Lunar.Button:UpdateCount(self);

	-- Now, if the button has an action assigned, and it is not a menu, make sure it registers the proper
	-- events it needs to look for
	if not (LunarSphereSettings.buttonData[self:GetID()].empty) and (registerEvents) then

		if (not self.registeredEvents) then

			self.registeredEvents = true;

			-- Standard events
			self:RegisterEvent("ACTIONBAR_UPDATE_STATE");
			self:RegisterEvent("SPELL_UPDATE_USABLE");
			self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
			--self:RegisterEvent("PLAYER_AURAS_CHANGED");
			self:RegisterEvent("UNIT_AURA");
			self:RegisterEvent("PLAYER_TARGET_CHANGED");
--			self:RegisterEvent("MODIFIER_STATE_CHANGED");
			self:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
			if( Lunar.API:IsVersionClassic() == false ) then
				self:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW");
				self:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE");
			end
--			self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED");

--			if (this.actionType == "spell") then
--				self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED");
--			end

			-- If it's an item button, we also add these events
			if (self.actionType == "item") or (self.spellReagent) or (self.actionType == "macrotext") or (self.buttonType == 3)  then
				self:RegisterEvent("UNIT_INVENTORY_CHANGED");
				self:RegisterEvent("UPDATE_INVENTORY_ALERTS");
				self:RegisterEvent("BAG_UPDATE");
				self:RegisterEvent("BAG_UPDATE_COOLDOWN");
			end

			if (self.actionType == "macro") or (self.buttonType == 3) then
				self:RegisterEvent("MODIFIER_STATE_CHANGED");
				self:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
--				self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED");
			end

			if (self.buttonType) and ((self.buttonType >= 140) and (self.buttonType < 150)) or (self.buttonType == 3) then
				self:RegisterEvent("PET_BAR_UPDATE");
				self:RegisterEvent("PET_BAR_UPDATE_COOLDOWN");
			end

			-- If the button doesn't have an update function (because it was deleted
			-- to save function call times) ... add it back in
			if (not self:GetScript("OnUpdate")) then
				self:SetScript("OnUpdate", Lunar.Button.OnUpdate)
			end

			-- Make sure the button is flagged for range and cooldown updates
			self.canUpdate = true;

			-- If it's a child button, we need to add an OnShow event to take care of
			-- cooldowns and range checks when showing the menu items
			if (not self:GetScript("OnShow")) then
				--OLD
				--self:SetScript("OnShow", function() Lunar.Button:UpdateCooldown(this) end);
				self:SetScript("OnShow", Lunar.Button.UpdateCooldown);
			end

			-- If the timer data table for the button doesn't exist yet, create it.
			-- Then, start the range checker for the spells
			if (not timerData[self:GetID()]) then
				timerData[self:GetID()] = {};
			end
			timerData[self:GetID()].rangeTimer = 0

			-- If we want to highlight the button when we have a profession
			-- window open, I guess we could use these...
			self:RegisterEvent("TRADE_SKILL_SHOW");
			self:RegisterEvent("TRADE_SKILL_CLOSE");

			-- Might be useful at some point ...
	--		self:RegisterEvent("PLAYER_ENTER_COMBAT");
	--		self:RegisterEvent("PLAYER_LEAVE_COMBAT");

			-- Maybe ...
	--		self:RegisterEvent("START_AUTOREPEAT_SPELL");
	--		self:RegisterEvent("STOP_AUTOREPEAT_SPELL");

		end

		-- Update the button
--		Lunar.Button:UpdateState(this);
--		Lunar.Button:UpdateUsable(this);
--		Lunar.Button:UpdateCooldown(this);
--		ActionButton_UpdateFlash();

	-- Otherwise, the button is being erased, or is a menu button, so clear it's events as well
	else

		self.registeredEvents = false;
		
		-- Unregister any event we might have done	
		self:UnregisterEvent("ACTIONBAR_UPDATE_STATE");
		self:UnregisterEvent("SPELL_UPDATE_USABLE");
		self:UnregisterEvent("SPELL_UPDATE_COOLDOWN");
		self:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
		--self:UnregisterEvent("PLAYER_AURAS_CHANGED");
		self:UnregisterEvent("UNIT_AURA");
		self:UnregisterEvent("PLAYER_TARGET_CHANGED");
		self:UnregisterEvent("MODIFIER_STATE_CHANGED");
		self:UnregisterEvent("ACTIONBAR_SLOT_CHANGED");
		self:UnregisterEvent("UNIT_INVENTORY_CHANGED");
		self:UnregisterEvent("BAG_UPDATE");
		self:UnregisterEvent("BAG_UPDATE_COOLDOWN");
		self:UnregisterEvent("TRADE_SKILL_SHOW");
		self:UnregisterEvent("TRADE_SKILL_CLOSE");
		self:UnregisterEvent("PET_BAR_UPDATE");
		self:UnregisterEvent("PET_BAR_UPDATE_COOLDOWN");
		if( Lunar.API:IsVersionClassic() == false ) then
			self:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW");
			self:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE");
		end
--		self:UnregisterEvent("CURRENT_SPELL_CAST_CHANGED");

--		self:UnregisterEvent("PLAYER_ENTER_COMBAT");
--		self:UnregisterEvent("PLAYER_LEAVE_COMBAT");
--		self:UnregisterEvent("START_AUTOREPEAT_SPELL");
--		self:UnregisterEvent("STOP_AUTOREPEAT_SPELL");

		-- Wipe the update handler, so we don't keep running
		-- a function that's not needed
		self.canUpdate = false;
		self:SetScript("OnUpdate", nil)
		self:SetScript("OnShow", nil);

	end

	-- If the button is a menu, color its borders to reflect so
	if (LunarSphereSettings.buttonData[self:GetID()].isMenu) then
		self:GetNormalTexture():SetVertexColor(LunarSphereSettings.menuButtonColor[1], LunarSphereSettings.menuButtonColor[2], LunarSphereSettings.menuButtonColor[3]);
		self:GetPushedTexture():SetVertexColor(LunarSphereSettings.menuButtonColor[1], LunarSphereSettings.menuButtonColor[2], LunarSphereSettings.menuButtonColor[3]);
	else
		self:GetNormalTexture():SetVertexColor(LunarSphereSettings.buttonColor[1], LunarSphereSettings.buttonColor[2], LunarSphereSettings.buttonColor[3], 1);
		self:GetPushedTexture():SetVertexColor(LunarSphereSettings.buttonColor[1], LunarSphereSettings.buttonColor[2], LunarSphereSettings.buttonColor[3], 1);
--		self:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0);
--		self:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0);
	end				

	-- Grab the border of the button
	local border = _G[self:GetName().."Border"];
	border:Hide();

	local macroEquiped;
	if (self.actionType == "macro") then
		local macroBody, objectName;
		_,_, macroBody = GetMacroInfo(self.actionName);
		objectName = GetActionFromMacroText(macroBody);

		if (objectName) then
			_, itemString = GetItemInfo(objectName);
			if (itemString) then
				macroEquiped = IsEquippedItem(objectName);
			end
		end
	elseif (self.buttonType) and ((self.buttonType == 130) or (self.buttonType == 131)) then
		macroEquiped = IsEquippedItem(GetInventoryItemLink("player", self.buttonType - 117));
	end

	-- Now, if the button is an item button ...
	if (self.actionType == "item") or (macroEquiped) then
-- Here
		-- Add a green border if it is an equipped item
		if ( IsEquippedItem(self.actionName) or (macroEquiped) ) then
			border:SetVertexColor(0, 1.0, 0, 1.0);
--			border:Show();
			self:GetCheckedTexture():SetVertexColor(0,1,0);
--			self:SetChecked(true);
		else
--			border:Hide();
--			self:SetChecked(false);
		end

	end			

	if (timerData[self:GetID()]) then
		timerData[self:GetID()].cooldownElapsed = 0;
		timerData[self:GetID()].cooldownTimer = nil;
	end

	Lunar.Button:UpdateUsable(self);
	Lunar.Button.UpdateCooldown(self);
	Lunar.Button:UpdateBindingText(self);

	-- Make sure we show the item count if requested
	_G[self:GetName() .. "Count"]:Hide()
	if (LunarSphereSettings.buttonData[self:GetID()].showCount) then
		_G[self:GetName() .. "Count"]:Show()
	end

end

function Lunar.Button:UpdatePlayerPortrait()

	if (LunarSphereSettings.useSphereClickIcon ~= true) then
		if (LunarSphereSettings.sphereSkin == Lunar.includedSpheres + 1) then
			Lunar.Sphere:SetSphereTexture();
--			SetPortraitTexture(_G["LSsphere"]:GetNormalTexture(), "player");
		end
		if (LunarSphereSettings.sphereSkin == Lunar.includedSpheres + 2) then
			Lunar.Sphere:SetSphereTexture();
--			SetPortraitTexture(_G["LSsphere"]:GetNormalTexture(), "player");
		end
	else
		if (_G["LSmain"].buttonType == 100) then
			SetPortraitTexture(_G["LSsphere"]:GetNormalTexture(), "player");
		end
	end

	local index, stance, button;
	for index = 0, 130 do
		if (index > 10) then
			button = _G["LunarSub" .. index .. "Button"];
		else
			button = _G["LunarMenu" .. index .. "Button"];
		end
		if (button) then
			if (button.buttonType == 100) then
				if (index > 10) then
					SetPortraitTexture(_G["LunarSub" .. index .. "ButtonIcon"], "player");
				else
					SetPortraitTexture(_G["LunarMenu" .. index .. "ButtonIcon"], "player");
				end
			end
		end
	end
	
end

-- /***********************************************
--  * UpdateCount
--  * ========================
--  *
--  * Updates the item count of an item button
--  *
--  * Accepts: button to update
--  * Returns: none
--  *********************
function Lunar.Button:UpdateCount(self)

	if (not self.actionTypeCount) then
		if (self:GetID() == 0) then
			self.actionNameCount = LunarSphereSettings.sphereAction or ("") 
			if GetSpellInfo(self.actionNameCount) then
				self.actionTypeCount = "spell";
				Lunar.Button:FindSpellReagent(self, self.currentStance, -1, self.actionNameCount, self.actionTypeCount)
			else
				self.actionTypeCount = "item";
				LunarSphereSettings.buttonData[0].showCount = true;
			end
		else
			local clickType = Lunar.Button:GetButtonSetting(self:GetID(), self.currentStance, LUNAR_GET_SHOW_COUNT)
			_, self.actionTypeCount, self.actionNameCount = Lunar.Button:GetButtonData(self:GetID(), self.currentStance, clickType);
			Lunar.Button:FindSpellReagent(self, self.currentStance, clickType, self.actionNameCount, self.actionTypeCount)
		end
	end

	local actionType = self.actionTypeCount;
	local actionName = self.actionNameCount;
--	local _, actionType, actionName = Lunar.Button:GetButtonData(self:GetID(), this.currentStance, Lunar.Button:GetButtonSetting(self:GetID(), this.currentStance, LUNAR_GET_SHOW_COUNT));

	-- If the button contains something, we continue
	if (actionType) then

		local reagentCount;
		
		-- Possibly just switch actionType and actionName to "item" and the reagent name, instead of this code ... to save space?
		if (actionType == "spell") and (self.spellReagent) then
			reagentCount = GetSpellCount(actionName) or (0);
			if (reagentCount > 0) then
				if (self:GetID() > 0) then
					_G[self:GetName() .. "Count"]:Show();
					_G[self:GetName() .. "Count"]:SetText(reagentCount);
				else
					if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COUNT) then
						Lunar.Sphere:SetSphereText(reagentCount);
					end
				end
			else
				if (self:GetID() > 0) then
					_G[self:GetName() .. "Count"]:Hide();
				else
					if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COUNT) then
						Lunar.Sphere:SetSphereText("");
					end
				end
			end


		-- If it is an item it contains, we continue
		elseif (actionType == "item") or (actionType == "macrotext") then

			if (actionType == "macrotext") then
				if (self.buttonType) then
					if (self.buttonType < 130) then --if (self.buttonType == 12) or (self.buttonType == 22) or (self.buttonType == 13) or (self.buttonType == 23) then
						local actionName1, actionName2 = string.match(actionName, "/use (.*)\n/use (.*)");
						local count1 = GetItemCount(actionName1) or (0);
						local count2 = GetItemCount(actionName2) or (0);
						if (count1 > count2) then
							actionName = actionName2;
							if (actionName == "") then
								actionName = actionName1;
							end
						else
							actionName = actionName1;
							if (actionName == "") then
								actionName = actionName2;
							end
						end
					else
						actionName = GetItemInfo(GetInventoryItemLink("player", self.buttonType - 117) or ("")) or ("");
					end
					actionName = actionName or ("") ;

				-- Only happens in odd situations, this is just to fix a bug...
				else
					if (self:GetID() > 0) then
						_G[self:GetName() .. "Count"]:Hide();
					else
						if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COUNT) then
							Lunar.Sphere:SetSphereText("");
						end
					end
					return;
				end
						
			end

			-- Obtain the stackTotal that the item can have
			local stackTotal, objectMainType, objectType, itemLink, itemID, itemCount;
			_, itemLink, _, _, _, objectMainType, objectType, stackTotal = GetItemInfo(actionName);

			-- Make sure we have a stackTotal (meaning, we have it in our in our inventory)
			if (stackTotal) then

--				itemID = Lunar.API:GetItemID(itemLink);

				-- First, check if we have an item that's in our "charges" database. If so, use the
				-- charges instead of the item count
--				totalCharges = Lunar.Items:GetCharges(itemID);
--				if (totalCharges) then
				itemCount = GetItemCount(actionName, nil, true);
--				_G[self:GetName() .. "Count"]:SetText(itemCount);

				-- If the item is consumable, a reagent, or can stack, we will show the count of the item
				if (IsConsumableItem(actionName) or (stackTotal > 1) or (objectType == Lunar.Items.reagentString) or (objectMainType == Lunar.Items:GetItemType("consume")) or (actionName == "item:6265")) then

--				elseif (IsConsumableItem(actionName) or (stackTotal > 1) or (objectType == Lunar.Items.reagentString) ) then

--				-- If the item is consumable, a reagent, or can stack, we will show the count of the item
--				if (IsConsumableItem(LunarSphereSettings.buttonData[self:GetID()].actionName1) or (stackTotal > 1) or (objectType == Lunar.Items.reagentString) ) then
--					if (totalCharges) then
--						if (totalCharges ~= -1) then
--							if (self:GetID() == 0) then
--								if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COUNT) then
--									Lunar.Sphere:SetSphereText(totalCharges);
--								end
--							else
--								_G[self:GetName() .. "Count"]:SetText(totalCharges);
--							end
--						end
--					else
						if (self:GetID() == 0) then
							if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COUNT) then
								Lunar.Sphere:SetSphereText(itemCount or (0));
							end
						else
							_G[self:GetName() .. "Count"]:SetText(itemCount or (0));
							_G[self:GetName() .. "Count"]:Show();

						end
--					end
--					if (self:GetID() > 0) then
--						_G[self:GetName() .. "Count"]:Show();
--					end
				else
					if (itemCount == 0) and (objectType == Lunar.Items:GetItemType("consume")) then
						if (self:GetID() == 0) then
							if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COUNT) then
								Lunar.Sphere:SetSphereText(0);
							end
						else
							_G[self:GetName() .. "Count"]:SetText(0);
							_G[self:GetName() .. "Count"]:Show();
						end
					else
						if (self:GetID() == 0) then
							Lunar.Sphere:SetSphereText(itemCount);
						end
					end
				end

			-- Otherwise, we don't have it and the count is set to 0
			else
				if (self:GetID() == 0) then
					if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COUNT) then
						Lunar.Sphere:SetSphereText(0);
					end
				else
					_G[self:GetName() .. "Count"]:SetText(0);
				end
			end
		end
			
	end

end

-- /***********************************************
--  * UpdateCooldown
--  * ========================
--  *
--  * Updates the cooldown of the button
--  *
--  * Accepts: button to update
--  * Returns: none
--  *********************
function Lunar.Button.UpdateCooldown(self, filter)

	local button = self

	-- Set our locals
	local filteredCooldown = "0";
	local enable, actionType, actionName, startTime, duration, percent, buttonID;
	buttonID = button:GetID();

	if ((button.cooldownID) and (button.cooldownID > 0)) or (buttonID == 0)  then

		if (not button.actionTypeCooldown) then
			if (self:GetID() == 0) then
				self.actionNameCooldown = LunarSphereSettings.sphereAction or ("") 
				if GetSpellInfo(self.actionNameCooldown) then
					self.actionTypeCooldown = "spell";
					LunarSphereSettings.buttonData[0].showCount = true;
				else
					self.actionTypeCooldown = "item";
					LunarSphereSettings.buttonData[0].showCount = true;
				end
			else
				button.actionButtonTypeCooldown, button.actionTypeCooldown, button.actionNameCooldown = Lunar.Button:GetButtonData(button:GetID(), button.currentStance, button.cooldownID);
				if (button.actionTypeCooldown == "spell") then
--					button.actionNameCooldown = Lunar.API:FixFaerie(button.actionNameCooldown);
				end
			end
		end

		-- If the filter exists, check the action type. If it is not a part of the filter, exit now
		if (filter) and not ((filter == button.actionTypeCooldown) or (button.actionTypeCooldown == "macro") or (button.actionTypeCooldown == "macrotext")) then
			return;
		end

		actionType = button.actionTypeCooldown;
		actionName = button.actionNameCooldown;

		-- Build the startTime and durations based on whether it is a spell, item, or macro
		-- that we're looking at
		enable = 1;
		if (actionType == "spell") then
			startTime, duration, enable = GetSpellCooldown(actionName);
		elseif (actionType == "item") then
			startTime, duration = Lunar.API:GetItemCooldown(actionName);
		elseif (actionType == "macro") or (actionType == "macrotext") then
			if (actionType == "macro") then
				actionName = GetActionFromMacroText(GetMacroBody(actionName));
			else
				if (button.buttonType == 130) or (button.buttonType == 131) then
					actionName = GetInventoryItemLink("player", button.buttonType - 117);
				end
			end
			if actionName then
				if GetItemInfo(actionName) then
					startTime, duration = Lunar.API:GetItemCooldown(actionName);
				else
					startTime, duration, enable = GetSpellCooldown(actionName);
				end
			end
		elseif (actionType == "pet") then
			-- Fix issues with pet actions as the last used submenu type
			if (button.actionButtonTypeCooldown == 3) and (button.subButtonType) then
				actionName = tostring(button.subButtonType - 139)
			elseif (button.actionButtonTypeCooldown == 4) and (button.subButtonType2) then
				actionName = tostring(button.subButtonType2 - 139)
			end
			if (actionName == " ") then
				actionName = "1";
			end

			startTime, duration, enable = GetPetActionCooldown(tonumber(actionName));
		end

		-- Retrieve the cooldown text, with seconds, minutes, or hours as well
		filteredCooldown = Lunar.API:FilterCooldown(startTime, duration);
		
	end

	-- If the cooldown is not 0... and "enable" is not set to 0 (happens on shadowform
	-- and other shapeshifts when activated) ...
	if (filteredCooldown and (filteredCooldown ~= "0") and (enable ~= 0) ) then

		-- If the timer data table doesn't exist for this button yet, make it
		if (not timerData[button:GetID()]) then
			timerData[button:GetID()] = {}
		end

		if ((duration > 2) and (LunarSphereSettings.skipGlobalCooldown == true)) or not (LunarSphereSettings.skipGlobalCooldown == true) then

			if (buttonID == 0) then
				if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COOLDOWN) then
					Lunar.Sphere:SetSphereText(filteredCooldown);
				end
			else
--[[COOLDOWN EDIT
				-- Set the cooldown text and show it
				if (string.len(filteredCooldown) > 3) then
					button.cooldownTextFrame:SetScale(3/string.len(filteredCooldown));
				elseif (string.len(filteredCooldown) > 2) then
					button.cooldownTextFrame:SetScale(string.len(filteredCooldown) / 4);
				else
					button.cooldownTextFrame:SetScale(1);
				end
--]]
				if (LunarSphereSettings.cooldownShowText == true) then

					-- Set the cooldown text and show it
					if (string.len(filteredCooldown) > 3) then
						button.cooldownText:SetFont(STANDARD_TEXT_FONT, 10.5, "OUTLINE")
	--					button.cooldownTextFrame:SetScale(3/string.len(filteredCooldown));
					elseif (string.len(filteredCooldown) > 2) then
						button.cooldownText:SetFont(STANDARD_TEXT_FONT, 10.5, "OUTLINE")
	--					button.cooldownTextFrame:SetScale(string.len(filteredCooldown) / 4);
					else
						button.cooldownText:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
	--					button.cooldownTextFrame:SetScale(1);
					end

					button.cooldownText:SetText(filteredCooldown);
					button.cooldownText:Show()
				end

				Lunar.cooldownEffectFunction[LunarSphereSettings.cooldownEffect](button, (1 - (GetTime() - startTime) / duration), true, startTime, duration, enable);
--[[
				if (LunarSphereSettings.cooldownEffect > 0) then
					button.cooldown:Show();
					percent = 1 - (GetTime() - startTime) / duration
--					button.cooldown:SetWidth(25 * percent);
--					button.cooldown:SetHeight(25 * percent);
					button.cooldown:SetAlpha(percent);
--					button:SetAlpha(1-percent);
				end
--

--]]
			end

			-- Reset the cooldown timer data
			timerData[buttonID].cooldownElapsed = duration;
			timerData[buttonID].cooldownTimer = startTime;

-- Original Cooldown code section
--			timerData[button:GetID()].cooldownElapsed = 0;
--			timerData[button:GetID()].cooldownTimer = duration - (GetTime() - startTime);
		end

	-- Otherwise, we're done with the cooldown
	else
		if (buttonID == 0) then
			if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COOLDOWN) then
				Lunar.Sphere:SetSphereText("");	
			end
		else
			-- Hide the cooldown text	
			button.cooldownText:SetText("");
			button.cooldownText:Hide()

			button.cooldown:Hide();
			if (actionType) then
				button:SetAlpha(1);
				_G[button:GetName() .. "Icon"]:SetAlpha(1);
			end

		end

		-- If the button had cooldown data, clear it
		if (timerData[buttonID]) then
			timerData[buttonID].cooldownElapsed = 0;
			timerData[buttonID].cooldownTimer = nil;
		end
	end
end

function Lunar.Button.OnUpdate(self, elapsed, button)

	if (Lunar.updateButtons == nil) then-- or Lunar.Button.updateCounterFrame.updateCooldown) then --and not Lunar.Button.updateDrDamage then
		return;
	end

	self = button or self;

	local buttonID = self:GetID();
	local timerDB = timerData[buttonID];

	if (self.bagUpdate) then
		self.bagUpdate = nil;
		Lunar.Button:Update(self, true)
	end

	if (Lunar.Button.updateCounterFrame.updateCurrentCast == 2) then
		Lunar.Button:UpdateSpellState(self);
		return;
	end

	if self.updateIcon and ((self:GetAttribute("updateIconName")) or (self.buttonType == 130) or (self.buttonType == 131) or (self.actionType == "macro")) then
		self.updateIcon = false;
		self.updatedIcon = true;

		Lunar.Button:UpdateIcon(self);

		local actionType = self:GetAttribute("updateIconType");
		local actionName = self:GetAttribute("updateIconName");
		if (actionType == "spell") then
			self.texture:SetTexture(GetSpellTexture(actionName));
		end
	end

	if (self.updatedIcon and not UnitAffectingCombat("player")) then
		self.updatedIcon = false;
		self:SetAttribute("updateIconName", nil);
		self:SetAttribute("updateIconType", nil);
	end

	-- If we have timer data, continue
	if (timerDB) then

		if (Lunar.updateButtons == 2) and (buttonID ~= 0) then
			if not self.buttonType then
				self.buttonType, self.actionType, self.actionName = Lunar.Button:GetButtonData(buttonID, self.currentStance, 1);
			end

			if not self.buttonType then
				return;
			end

			-- We don't care about bag and menu tab buttons
			if (self.buttonType >= 90) and (self.buttonType < 110) then
				return;
			end

			Lunar.Button:UpdateUsable(self, nil, true);
		end

		-- Handle the cooldown updating
		if (timerDB.cooldownTimer) then

			local remaining = timerDB.cooldownTimer + timerDB.cooldownElapsed - Lunar.Button.updateCounterFrame.currentTime;
			local percent;

			-- If the cooldown is finished, hide the text and wipe the timer data
			if (remaining <= 0) then
				if (buttonID == 0) then
					if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COOLDOWN) then
						Lunar.Sphere:SetSphereText("");
					end
				else
					self.cooldownText:SetText("");
					self.cooldownText:Hide()
					timerDB.cooldownTimer = nil;
					timerDB.cooldownElapsed = 0;

					self.cooldown:Hide();
					self:SetAlpha(1);
					_G[self:GetName() .. "Icon"]:SetAlpha(1);

					if (LunarSphereSettings.cooldownShowShine == true) then
						--Croq updated to new: CooldownFrame_Set(self.cooldown, start, duration, enable)
						
						--Old: CooldownFrame_SetTimer(self.readyShine, GetTime(), 0.1, 1)
						CooldownFrame_Set(self.readyShine, GetTime(), 0.1, 1);
					end
				end

			-- Otherwise, show the text and update the text contents
			else
				if (Lunar.updateButtons == 2) then
					if (LunarSphereSettings.cooldownShowText == true) then
						if (buttonID == 0) then
							if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COOLDOWN) then
								Lunar.Sphere:SetSphereText(Lunar.API:FilterCooldown(remaining));
							end
						else
							local remainingFiltered = Lunar.API:FilterCooldown(remaining);
							if (string.len(remainingFiltered) < string.len(self.cooldownText:GetText())) then
								if (string.len(remainingFiltered) > 2) then
									self.cooldownText:SetFont(STANDARD_TEXT_FONT, 10.5, "OUTLINE")
								else
									self.cooldownText:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
								end
							end
										
							self.cooldownText:Show()
							self.cooldownText:SetText(remainingFiltered);
						end
					end
				end

				if (buttonID ~= 0) then
					Lunar.cooldownEffectFunction[LunarSphereSettings.cooldownEffect](self, (1 - (Lunar.Button.updateCounterFrame.currentTime - timerDB.cooldownTimer) / timerDB.cooldownElapsed));
				end
			end
		end
	end
end

-- /***********************************************
--  * UpdateUsable
--  * ========================
--  *
--  * Updates the button's coloring to reflect its usability
--  *
--  * Accepts: button to update
--  * Returns: none
--  *********************
function Lunar.Button:UpdateUsable(self, filter, rangeOnly)
-- Here
	-- Create our locals
	local isUsable, notEnoughMana, autoOn
	local inRange = true;
	local isUsable = true;
	local spellLink, texture, isToken, name, rank;

	if (not self.buttonType) then
		self.buttonType, self.actionType, self.actionName = Lunar.Button:GetButtonData(self:GetID(), self.currentStance, Lunar.Button:GetButtonSetting(self:GetID(), self.currentStance, LUNAR_GET_SHOW_ICON));
--		if (this.actionType == "spell") then
--			this.actionName = Lunar.API:FixFaerie(this.actionName);
--		end
	end

	-- If the filter exists, check the action type. If it is not a part of the filter, exit now
	if (filter) and not ((filter == self.actionType) or (self.actionType == "macro")) then
		return;
	end

	if (self:GetID() == 0) then
		return;
	end

	if (not self.buttonType) then
		self.buttonType = 0;
	end

	if timerData[self:GetID()] then
		if (timerData[self:GetID()].rangeTimer <= -15) then
			rangeOnly = nil;
		end
	end

	-- If the button happens to be a menu, menu tab button or a bag button, it's always usable
	if ((self.buttonType == 2) or ((self.buttonType >= 80) and (self.buttonType < 90)) or ((self.buttonType >= 90) and (self.buttonType < 110))) or 
	   ((self.buttonType == 3) and (self.subButtonType and ((self.subButtonType == 2) or ((self.subButtonType >= 90) and (self.subButtonType < 110))))) or  
	   ((self.buttonType == 4) and (self.subButtonType2 and ((self.subButtonType2 == 2) or ((self.subButtonType2 >= 90) and (self.subButtonType2 < 110))))) then
		isUsable = true;
	elseif ((self.buttonType >= 140) and (self.buttonType < 150)) or 
	   ((self.buttonType == 3) and (self.subButtonType and ((self.subButtonType >= 140) and (self.subButtonType < 150)))) or 
	   ((self.buttonType == 4) and (self.subButtonType2 and ((self.subButtonType2 >= 140) and (self.subButtonType2 < 150)))) then
		local border = _G[self:GetName().."Border"];
		if (self.buttonType == 3) and (self.subButtonType) then
			texture, isToken, active, _, autoOn = select(3, GetPetActionInfo(self.subButtonType - 139));
		elseif (self.buttonType == 4) and (self.subButtonType2) then
			texture, isToken, active, _, autoOn = select(3, GetPetActionInfo(self.subButtonType2 - 139));
		elseif (self.buttonType >= 140) then
			texture, isToken, active, _, autoOn = select(3, GetPetActionInfo(self.buttonType - 139));
		end

		texture = texture or ("Interface\\AddOns\\LunarSphere\\Art\\blankIcon.blp");
		if (self:GetID() > 0) then
			local icon = _G[self:GetName() .. "Icon"];
			if ( not isToken ) then
				icon:SetTexture(texture);
			else
				icon:SetTexture(_G[texture]);
			end
			SetPortraitToTexture(icon, icon:GetTexture());
		end

		if (autoOn) then
			border:SetVertexColor(0,1,0);
			border:Show();
		else
			if (active) then
				border:SetVertexColor(1,1,0);
				border:Show();
			else
				border:Hide();
			end
		end
		isUsable = true;
	else

		-- First, see if we can even use the spell

		-- Pull the data based on the type of button we have
		if (self.actionType == "spell") then

			_, spellLink = GetSpellBookItemInfo(self.actionName);
			texture = GetSpellTexture(self.actionName);
			if (not spellLink) then
				spellLink, _, texture = GetSpellInfo(self.actionName); -- or ("");
			end
			name, rank = GetSpellInfo(self.actionName) or "";
			if (rank) then
				name = name .. "(" .. rank .. ")";
			end

			spellLink = spellLink or ("");
--			spellLink = self.actionName;
			if not (rangeOnly == true) then
				isUsable, notEnoughMana = IsUsableSpell(spellLink); --self.actionName);
				-- Adjust for spell mounts since we assign by number. They can always be used ... kinda.
				if (not isUsable) then
					if (tostring(tonumber(self.actionName)) == self.actionName) then
						isUsable = true;
					end
				end
				self.notEnoughMana = notEnoughMana;
				self.isUsable = isUsable;
			end
			if (spellLink ~= "") then
				if (texture == nil) then
					texture = Lunar.Button.shootIcon;
				elseif (texture == "Interface\\Buttons\\Spell-Reset") then
					texture = "Interface\\Icons\\INV_Sword_04";
				end
				if (texture ~= self.texture:GetTexture()) then
					self.texture:SetTexture(texture);
					SetPortraitToTexture(self.texture, texture);
				end
			end
			if (IsAttackSpell(self.actionName) and not IsCurrentSpell(self.actionName)) then
				local border = _G[self:GetName().."Border"];
				if (border) then
					border:Hide();
				end
			end
			inRange = IsSpellInRange(name, "target"); --self.actionName, "target");
		elseif (self.actionType == "item") then
			if (not (rangeOnly == true)) then
				isUsable, notEnoughMana = IsUsableItem(self.actionName);
				self.notEnoughMana = nil; --notEnoughMana;
				self.isUsable = isUsable;
			end
			if ItemHasRange(self.actionName) then
				inRange = IsItemInRange(self.actionName, "target");	
			end
		elseif (self.actionType == "macro") or (self.actionType == "macrotext") then
			isUsable = true;
			local macroAction;
			if (self.actionType == "macro") then
				macroAction = GetActionFromMacroText(GetMacroBody(self.actionName));
			else
--				if (this.buttonType < 130) then
					macroAction = GetActionFromMacroText(self.actionName);
--				else
--					macroAction = GetInventoryItemLink("player", this.buttonType - 117);
--				end
			end
			if macroAction and (macroAction ~= "") then
				if GetItemInfo(macroAction) then
					if not (rangeOnly == true) then
						isUsable, notEnoughMana = IsUsableItem(macroAction);
						self.notEnoughMana = nil --notEnoughMana;
						self.isUsable = isUsable;
					end
					if ItemHasRange(macroAction) then
						inRange = IsItemInRange(macroAction, "target");	
					end
				else
					if not (rangeOnly == true) then
						isUsable, notEnoughMana = IsUsableSpell(macroAction);
						self.notEnoughMana = notEnoughMana;
						self.isUsable = isUsable;
					end
					inRange = IsSpellInRange(macroAction, "target");
				end
			else
				self.isUsable = isUsable;
			end
		end

		notEnoughMana = self.notEnoughMana;
		isUsable = self.isUsable;

	end

	local vividR, vividG, vividB;

	-- If we can, continue
	if (isUsable) then

		-- Check if the spell is in range to our target. If not, make the icon red. Otherwise,
		-- return the color to normal
		if ( inRange == false ) then
			if (LunarSphereSettings.vividButtons == true) then
				vividR, vividG, vividB = 1,0,0;
				if (LunarSphereSettings.vividRange) then
					vividR, vividG, vividB = unpack(LunarSphereSettings.vividRange);
				end
				_G[self:GetName() .. "Icon"]:SetVertexColor(vividR, vividG, vividB);
			else
				_G[self:GetName() .. "Icon"]:SetVertexColor(1.0, 0.6, 0.6);
			end
		else
			_G[self:GetName() .. "Icon"]:SetVertexColor(1.0, 1.0, 1.0);
		end

	-- If we don't have enough mana, paint the icon a shade of blue with red
	elseif ( notEnoughMana ) then
			
		-- Check if the spell is in range to our target. If not, make the icon blueish. Otherwise,
		-- return the color to normal
		if ( inRange == false ) then
			if (LunarSphereSettings.vividButtons == true) then
				vividR, vividG, vividB = 0.6, 0.2, 1;
				if (LunarSphereSettings.vividRange) then
					vividR, vividG, vividB = unpack(LunarSphereSettings.vividManaRange);
				end
				_G[self:GetName() .. "Icon"]:SetVertexColor(vividR, vividG, vividB);
			else
				_G[self:GetName() .. "Icon"]:SetVertexColor(0.8, 0.2, 0.8);
			end
		else
			if (LunarSphereSettings.vividButtons == true) then
				vividR, vividG, vividB = 0, 0, 1;
				if (LunarSphereSettings.vividRange) then
					vividR, vividG, vividB = unpack(LunarSphereSettings.vividMana);
				end
				_G[self:GetName() .. "Icon"]:SetVertexColor(vividR, vividG, vividB);
			else
				_G[self:GetName() .. "Icon"]:SetVertexColor(0.5, 0.5, 1.0);
			end
		end
	
	-- Otherwise, we can't use the button at all (maybe we're flying, or shapeshifted
	else
		_G[self:GetName() .. "Icon"]:SetVertexColor(0.4, 0.4, 0.4);
	end
end

function Lunar.Button:UpdateSpellState(self)

	if (not self.buttonType) then
		self.buttonType, self.actionType, self.actionName = Lunar.Button:GetButtonData(self:GetID(), self.currentStance, Lunar.Button:GetButtonSetting(self:GetID(), self.currentStance, LUNAR_GET_SHOW_ICON));

--		if (this.actionType == "spell") then
--			this.actionName = Lunar.API:FixFaerie(this.actionName);
--		end
	end

	if (self.actionType == "macro") then
		Lunar.Button.updateCounterFrame.elapsed = 0.2
		self.updateIcon = true;
	else
		if (self.actionType == "spell") and ((self.buttonType < 140) or (self.buttonType >= 150)) then
			local border = _G[self:GetName().."Border"];
			if (border) then
				if ( (IsAttackSpell(self.actionName) and IsCurrentSpell(self.actionName)) or IsCurrentSpell(self.actionName) or IsAutoRepeatSpell(self.actionName) ) then --spellID, BOOKTYPE_SPELL)) then
					border:SetVertexColor(1,1,0);
					border:Show();
				else
					border:Hide();
				end

				-- Paladins and Death Knights get some love too, for their auras/presences
				--REMOVED as DKs, Hunters and Paladins no longer have stances
				--[[if (Lunar.Settings.hasAuras) then
					local auraID = GetShapeshiftForm(false);
					if (auraID > 0) then
						if (self.actionName == select(4, GetShapeshiftFormInfo(auraID))) then
							border:SetVertexColor(1,1,0);
							border:Show();
						end
					end
					
				-- Hunters get some love too...
				elseif (Lunar.Settings.hasAspects) then
					local buffIndex = Lunar.getBuffIndex("player", self.actionName)
					if buffIndex then
						local casterName = select(7, UnitBuff("player", buffIndex));
						if (casterName == "player") then
							border:SetVertexColor(1,1,0);
							border:Show();
						end
					end
				end]]--
			end
		end
	end
	if (self:GetID() == Lunar.Button.currentMouseOver) then
		if not (LunarSphereSettings.fadeOutTooltips) then
			Lunar.Button:SetTooltip(self);
		end
	end

end

-- /***********************************************
--  * UpdateSkin
--  * ========================
--  *
--  * Updates all of the buttons with the given skin
--  *
--  * Accepts: skin file to update with
--  * Returns: none
--  *********************
function Lunar.Button:UpdateSkin(skinFile, useColor)

	-- Set our local
	local index;

	-- Cycle through our original ten menu buttons
	for index=1, 10 do 

		-- Set the new texture
		_G["LunarMenu" .. index .. "Button"]:SetPushedTexture(skinFile);
		_G["LunarMenu" .. index .. "Button"]:SetNormalTexture(skinFile);
--		_G["LunarMenu" .. index .. "Button"]:SetPushedTexture(LUNAR_ART_PATH .. skinFile);
--		_G["LunarMenu" .. index .. "Button"]:SetNormalTexture(LUNAR_ART_PATH .. skinFile);

		-- If the use color flag is on, we will paint the button skin to the specified button color
--		if (useColor) then
--			_G["LunarMenu" .. index .. "Button"]:GetNormalTexture():SetVertexColor(
--				LunarSphereSettings.sphereColor[1], LunarSphereSettings.sphereColor[2], LunarSphereSettings.sphereColor[3], 1);
--			_G["LunarMenu" .. index .. "Button"]:GetPushedTexture():SetVertexColor(
--				LunarSphereSettings.sphereColor[1], LunarSphereSettings.sphereColor[2], LunarSphereSettings.sphereColor[3], 1);

		-- Otherwise, make it the normal color
--		else
			_G["LunarMenu" .. index .. "Button"]:GetNormalTexture():SetVertexColor(LunarSphereSettings.buttonColor[1], LunarSphereSettings.buttonColor[2], LunarSphereSettings.buttonColor[3], 1);
			_G["LunarMenu" .. index .. "Button"]:GetPushedTexture():SetVertexColor(LunarSphereSettings.buttonColor[1], LunarSphereSettings.buttonColor[2], LunarSphereSettings.buttonColor[3], 1);
--		end

		-- If the button happens to be a menu, we paint it the menu button color
		if (LunarSphereSettings.buttonData[index].isMenu) then
			_G["LunarMenu" .. index .. "Button"]:GetNormalTexture():SetVertexColor(LunarSphereSettings.menuButtonColor[1], LunarSphereSettings.menuButtonColor[2], LunarSphereSettings.menuButtonColor[3]);
			_G["LunarMenu" .. index .. "Button"]:GetPushedTexture():SetVertexColor(LunarSphereSettings.menuButtonColor[1], LunarSphereSettings.menuButtonColor[2], LunarSphereSettings.menuButtonColor[3]);
		end
	end

	-- If any other buttons exist (submenu buttons), skin those too
	if (buttonCount > 10) then
		for index=11, buttonCount do 

			-- Set the new texture
			_G["LunarSub" .. index .. "Button"]:SetPushedTexture(skinFile);
			_G["LunarSub" .. index .. "Button"]:SetNormalTexture(skinFile);
--			_G["LunarSub" .. index .. "Button"]:SetPushedTexture(LUNAR_ART_PATH .. "" .. skinFile);
--			_G["LunarSub" .. index .. "Button"]:SetNormalTexture(LUNAR_ART_PATH .. "" .. skinFile);

			-- If the use color flag is on, we will paint the button skin to the specified button color
--			if (useColor) then
--				_G["LunarSub" .. index .. "Button"]:GetNormalTexture():SetVertexColor(
--					LunarSphereSettings.sphereColor[1], LunarSphereSettings.sphereColor[2], LunarSphereSettings.sphereColor[3], 1);
--				_G["LunarSub" .. index .. "Button"]:GetPushedTexture():SetVertexColor(
--					LunarSphereSettings.sphereColor[1], LunarSphereSettings.sphereColor[2], LunarSphereSettings.sphereColor[3], 1);

			-- Otherwise, make it the normal color
--			else
				_G["LunarSub" .. index .. "Button"]:GetNormalTexture():SetVertexColor(LunarSphereSettings.buttonColor[1], LunarSphereSettings.buttonColor[2], LunarSphereSettings.buttonColor[3], 1);
				_G["LunarSub" .. index .. "Button"]:GetPushedTexture():SetVertexColor(LunarSphereSettings.buttonColor[1], LunarSphereSettings.buttonColor[2], LunarSphereSettings.buttonColor[3], 1);
--			end
					
		end
	end
end

function Lunar.Button:UpdateIcon(button)

--	local buttonType, actionType, actionName = Lunar.Button:GetButtonData(button:GetID(), button.currentStance, Lunar.Button:GetButtonSetting(button:GetID(), button.currentStance, LUNAR_GET_SHOW_ICON));
	if (not button.buttonType) then
		button.buttonType, button.actionType, button.actionName = Lunar.Button:GetButtonData(button:GetID(), button.currentStance, Lunar.Button:GetButtonSetting(button:GetID(), button.currentStance, LUNAR_GET_SHOW_ICON));
		if (button.actionType == "spell") then
--			button.actionName = Lunar.API:FixFaerie(button.actionName);
		end
	end
	local buttonType, actionType, actionName = button.buttonType, button.actionType, button.actionName;

	if (actionType == "macro") or (actionType == "macrotext") then
		local objectTexture, macroBody, objectName, newTexture;

		if (actionType == "macro") then
			
			_,objectTexture, macroBody = GetMacroInfo(actionName);
	----		objectName, test1, test2 = SecureCmdOptionParse(macroBody);

			if (macroBody) then
				if string.find(macroBody, "#show") and not string.find(macroBody, "#showt") then
				
	--			objectName = GetMacroSpell(actionName);
				objectName = GetActionFromMacroText(macroBody);
			
	--			if not objectName then
	--				objectName = GetMacroItem(actionName);
					if (objectName) then
						_,_,_,_,_,_,_,_,_,newTexture = GetItemInfo(objectName); --GetActionFromMacroText(macroBody));
						if not newTexture then
							newTexture = GetSpellTexture(objectName);
						end
					end
				end
			end
		else
			newTexture = GetInventoryItemTexture("player", buttonType - 117) or ("Interface\\Icons\\INV_Misc_QuestionMark");
		end		

--		else
--			local spellID = Lunar.API:GetSpellID(objectName);
--			if (spellID) then
--				newTexture = GetSpellTexture(spellID, "spell");
--			end
--		if not newTexture then
--			newTexture = GetSpellTexture(objectName);
--		end

		-- Grab the item texture first.
--[[		if (objectName) then
			_,_,_,_,_,_,_,_,_,newTexture = GetItemInfo(objectName); --GetActionFromMacroText(macroBody));
		end

		-- If it wasn't an item, we'll have no texture. So, grab the spell texture
		if (not newTexture) then
			local spellID = Lunar.API:GetSpellID(objectName);
			if (spellID) then
				newTexture = GetSpellTexture(spellID, "spell");
			end
		end
--]]
		if (newTexture) and (newTexture ~= objectTexture) then
			objectTexture = newTexture;
			Lunar.Button:SetButtonData(button:GetID(), button.currentStance, Lunar.Button:GetButtonSetting(button:GetID(), button.currentStance, LUNAR_GET_SHOW_ICON), buttonType, nil, nil, objectTexture);
		end

		if (button:GetID() > 0) then
			_G[button:GetName() .. "Icon"]:SetTexture(objectTexture);
			SetPortraitToTexture(_G[button:GetName() .. "Icon"], _G[button:GetName() .. "Icon"]:GetTexture());
		else
			if (LunarSphereSettings.useSphereClickIcon == true) then
				_G["LSsphere"]:SetNormalTexture(objectTexture);
				SetPortraitToTexture(_G["LSsphere"]:GetNormalTexture(), _G["LSsphere"]:GetNormalTexture():GetTexture());
			end	
		end
	end
end

function Lunar.Button:GetIconTexture(cursorType, objectID, objectData)

	local objectTexture = "";

	-- If it was a spell drag ...
	if (cursorType == "spell") then

		-- Get the name of the spell and its texture
--		objectName = GetSpellBookItemName(objectID, objectData);
		objectTexture = GetSpellTexture(objectID, objectData);

	-- If it was an item drag ...
	elseif (cursorType == "item") then

		-- Get the name of the item, what it can stack as, and its texture
		_,_,_,_,_,_,_,_,_,objectTexture = GetItemInfo(objectData);

	-- If it was a macro drag ...
	elseif (cursorType == "macro") then

		-- Grab the macro information and texture
		_,objectTexture = GetMacroInfo(objectID);
	end

	return objectTexture;
end

function Lunar.Button:UpdateButtonColors(menuOnly)

	local index;
	for index = 1, 10 do 
		if (LunarSphereSettings.buttonData[index].isMenu) then
			_G["LunarMenu" .. index .. "Button"]:GetNormalTexture():SetVertexColor(unpack(LunarSphereSettings.menuButtonColor));
			_G["LunarMenu" .. index .. "Button"]:GetPushedTexture():SetVertexColor(unpack(LunarSphereSettings.menuButtonColor));
		else
			_G["LunarMenu" .. index .. "Button"]:GetNormalTexture():SetVertexColor(unpack(LunarSphereSettings.buttonColor));
			_G["LunarMenu" .. index .. "Button"]:GetPushedTexture():SetVertexColor(unpack(LunarSphereSettings.buttonColor));
		end
	end

	if (not menuOnly) then
		for index = 11, 130 do 
			_G["LunarSub" .. index .. "Button"]:GetNormalTexture():SetVertexColor(unpack(LunarSphereSettings.buttonColor));
			_G["LunarSub" .. index .. "Button"]:GetPushedTexture():SetVertexColor(unpack(LunarSphereSettings.buttonColor));
		end
	end
end

-- /***********************************************
--  * Swap
--  * ========================
--  *
--  * Swaps two given buttons around the sphere or in sub menus
--  *
--  * Accepts: source and destination buttons to swap
--  * Returns: none
--  *********************
function Lunar.Button:Swap(srcButton, destButton, childSwap)

	-- Make sure we actually have a source and destination...
	if ((srcButton) and (destButton)) then

		local buttonType;

		-- Grab our button IDs
		local destID = destButton:GetID();
		local srcID = srcButton:GetID();

		srcButton.spellReagent = nil;
		destButton.spellReagent = nil;

		-- Determine if we're swapping a menu button
		local swapMenu = (LunarSphereSettings.buttonData[srcID].isMenu) or (LunarSphereSettings.buttonData[destID].isMenu);

		-- Next, make sure that if we're moving a menu button, it goes into
		-- one of the 10 main buttons (we cannot drag a menu button onto
		-- a sub menu button!) If it fails the test, exit now
		if ( (srcButton:GetID() > 10) or (destButton:GetID() > 10) ) and (swapMenu) then
			return;
		end

		-- Next, we check for stance support. Right now, if you try to swap a button that has
		-- stance support with a button that does not have stance support, you will not succeed.
		local srcStance = Lunar.Button:GetUseStances(srcID);
		local destStance = Lunar.Button:GetUseStances(destID);
		if (srcStance ~= destStance) then
			return;
		end

		-- Save the destination button's info in a temporary table and then delete
		-- the destination button's data. Make sure we don't transfer the child flag
		for key, value in pairs(LunarSphereSettings.buttonData[destID]) do
			if (key ~= "child") or (childSwap) then
				if (key ~= "detached") and (key ~= "relativePoint") and (key ~= "xOfs") and (key ~= "yOfs") then
					if ((LunarSphereSettings.keepKeybinds == true) and (key ~= "keybindData")) or (LunarSphereSettings.keepKeybinds ~= true) then
						swapData[key] = value;
						LunarSphereSettings.buttonData[destID][key] = nil;
					end
				end
			end
		end

		-- Transfer the data from the source button into our destination button, and then clear
		-- the source button's data. Make sure we don't transfer the child flag
		for key, value in pairs(LunarSphereSettings.buttonData[srcID]) do
			if (key ~= "child") or (childSwap) then
				if (key ~= "detached") and (key ~= "relativePoint") and (key ~= "xOfs") and (key ~= "yOfs") then
					if ((LunarSphereSettings.keepKeybinds == true) and (key ~= "keybindData")) or (LunarSphereSettings.keepKeybinds ~= true) then
						LunarSphereSettings.buttonData[destID][key] = LunarSphereSettings.buttonData[srcID][key];
						LunarSphereSettings.buttonData[srcID][key] = nil;
					end
				end
			end
		end

		-- Transfer our saved destination button's data into the source button and then
		-- delete the temporary data. Make sure we don't transfer the child flag
		for key, value in pairs(swapData) do
			if (key ~= "child") or (childSwap) then
				if (key ~= "detached") and (key ~= "relativePoint") and (key ~= "xOfs") and (key ~= "yOfs") then
					if ((LunarSphereSettings.keepKeybinds == true) and (key ~= "keybindData")) or (LunarSphereSettings.keepKeybinds ~= true) then
						LunarSphereSettings.buttonData[srcID][key] = swapData[key];
						swapData[key] = nil;
					end
				end
			end
		end		

		-- Swap the current stance data
		swapData.attributeType = destButton.currentStance;
		destButton.currentStance = srcButton.currentStance;
		srcButton.currentStance = swapData.attributeType;

		-- Swap the current cooldownIDs
		swapData.attributeType = destButton.cooldownID;
		destButton.cooldownID = srcButton.cooldownID;
		srcButton.cooldownID = swapData.attributeType;

		srcButton.actionTypeCount = nil;
		destButton.actionTypeCount = nil;

		-- Transfer our show states
		swapData.attributeType = destButton:GetAttribute("showstates");
		destButton:SetAttribute("showstates", srcButton:GetAttribute("showstates"));
		srcButton:SetAttribute("showstates", swapData.attributeType);

		-- Now, loop through all stance data and all three click types and transfer their actions
		local clickType, stance;
		for stance = 0, 12 do 
			for clickType = 1, 3 do 

				-- Save the attributes of the destination button into the table
				swapData.attributeType = destButton:GetAttribute("*type-S" .. stance .. clickType);
				if (swapData.attributeType) then
					swapData.attributeValue = destButton:GetAttribute("*"..swapData.attributeType .. "-S" .. stance .. clickType);
					swapData.attributeValue2 = destButton:GetAttribute("*"..swapData.attributeType .. "2-S" .. stance .. clickType);
--					Lunar.Debug(swapData.attributeValue);
				end

				-- Swap the actions of the destination button and the source button
				destButton:SetAttribute("*type-S" .. stance .. clickType, srcButton:GetAttribute("*type-S" .. stance .. clickType));
				if (srcButton:GetAttribute("*type-S" .. stance .. clickType)) then
					destButton:SetAttribute("*" .. srcButton:GetAttribute("*type-S" .. stance .. clickType) .. "-S" .. stance .. clickType, srcButton:GetAttribute("*" .. srcButton:GetAttribute("*type-S" .. stance .. clickType) .. "-S" .. stance .. clickType));
					destButton:SetAttribute("*" .. srcButton:GetAttribute("*type-S" .. stance .. clickType) .. "2-S" .. stance .. clickType, srcButton:GetAttribute("*" .. srcButton:GetAttribute("*type-S" .. stance .. clickType) .. "2-S" .. stance .. clickType));
				end

				srcButton:SetAttribute("*type-S" .. stance .. clickType, swapData.attributeType);
				if (swapData.attributeType) then
					srcButton:SetAttribute("*" .. swapData.attributeType .. "-S" .. stance .. clickType, swapData.attributeValue);
					srcButton:SetAttribute("*" .. swapData.attributeType .. "2-S" .. stance .. clickType, swapData.attributeValue2);
				end

				-- Transfer any opening menu support
				if (stance == 0) then

					if (Lunar.Button:GetButtonType(srcButton:GetID(), 0, clickType) == 2) then
						Lunar.Button:SetupAsMenu(srcButton, clickType)
					else
						Lunar.Button:SetupAsMenu(srcButton, clickType, false)
					end

					-- Transfer any opening menu support for the other button
					if (Lunar.Button:GetButtonType(destButton:GetID(), 0, clickType) == 2) then
						Lunar.Button:SetupAsMenu(destButton, clickType)
					else
						Lunar.Button:SetupAsMenu(destButton, clickType, false)
					end
				end
			end
		end

		-- Now reset the source and destination button's timers
		if (timerData[destID]) then
			timerData[destID].rangeTimer = 0;
			timerData[destID].cooldownTimer = 0;
			timerData[destID].cooldownelapsed = 0;
		end
		if (timerData[srcID]) then
			timerData[srcID].rangeTimer = 0;
			timerData[srcID].cooldownTimer = 0;
			timerData[srcID].cooldownelapsed = 0;
		end

		-- Update the artwork. First, change the icon to the empty texture and make the button 50% visible.
		-- Then, if the button is not empty, attach its real texture and show it completely. After all
		-- textures are applied, make them circular.
		_G[srcButton:GetName() .. "Icon"]:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background");
		_G[destButton:GetName() .. "Icon"]:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background");
		srcButton:SetAlpha(0.5);
		_G[srcButton:GetName() .. "Icon"]:SetAlpha(0.5);
		destButton:SetAlpha(0.5);
		_G[destButton:GetName() .. "Icon"]:SetAlpha(0.5);

		if (LunarSphereSettings.submenuCompression) then
			if (LunarSphereSettings.buttonEditMode ~= true) then
				if (srcID > 10) then
					srcButton:SetWidth(4);
					srcButton:SetAttribute("width", 4);
				end
				if (destID > 10) then
					destButton:SetWidth(4);
					destButton:SetAttribute("width", 4);
				end
			else
				if (srcID > 10) then
					srcButton:SetWidth(36);
					srcButton:SetAttribute("width", 36);
				end
				if (destID > 10) then
					destButton:SetWidth(36);
					destButton:SetAttribute("width", 36);
				end
			end	
		end

		local buttonTexture;
		stance = GetShapeshiftForm();
		
		if (not LunarSphereSettings.buttonData[srcID].empty) then
			_,_,_,buttonTexture = Lunar.Button:GetButtonData(srcID, srcButton.currentStance, Lunar.Button:GetButtonSetting(srcID, srcButton.currentStance, LUNAR_GET_SHOW_ICON));
			if (buttonTexture) and not (buttonTexture == "") then
				_G[srcButton:GetName() .. "Icon"]:SetTexture(buttonTexture);
			end
			srcButton:SetAlpha(1);
			_G[srcButton:GetName() .. "Icon"]:SetAlpha(1);
			srcButton:SetWidth(36);
			srcButton:SetAttribute("width", 36);
--			srcButton:SetHeight(36);
--			srcButton:SetAttribute("height", 36);

			buttonType = Lunar.Button:GetButtonType(srcID, srcButton.currentStance, Lunar.Button:GetButtonSetting(srcID, srcButton.currentStance, LUNAR_GET_SHOW_COUNT)) or 0; 
			if (buttonType >= 90) and (buttonType <= 95) then
				Lunar.Button:UpdateBagDisplay(srcButton, srcButton.currentStance, Lunar.Button:GetButtonSetting(srcID, srcButton.currentStance, LUNAR_GET_SHOW_COUNT));
			end

		end
		if (not LunarSphereSettings.buttonData[destID].empty) then
			_,_,_,buttonTexture = Lunar.Button:GetButtonData(destID, destButton.currentStance, Lunar.Button:GetButtonSetting(destID, destButton.currentStance, LUNAR_GET_SHOW_ICON));
			if (buttonTexture) and not (buttonTexture == "") then
				_G[destButton:GetName() .. "Icon"]:SetTexture(buttonTexture);
			end
			destButton:SetAlpha(1);
			_G[destButton:GetName() .. "Icon"]:SetAlpha(1);
			destButton:SetWidth(36);
			destButton:SetAttribute("width", 36);
--			destButton:SetHeight(36);
--			destButton:SetAttribute("height", 36);

			buttonType = Lunar.Button:GetButtonType(destID, destButton.currentStance, Lunar.Button:GetButtonSetting(destID, destButton.currentStance, LUNAR_GET_SHOW_COUNT)) or 0; 
			if (buttonType >= 90) and (buttonType <= 95) then
				Lunar.Button:UpdateBagDisplay(destButton, destButton.currentStance, Lunar.Button:GetButtonSetting(destID, destButton.currentStance, LUNAR_GET_SHOW_COUNT));
			end

		end
		SetPortraitToTexture(_G[srcButton:GetName() .. "Icon"], _G[srcButton:GetName() .. "Icon"]:GetTexture());
		SetPortraitToTexture(_G[destButton:GetName() .. "Icon"], _G[destButton:GetName() .. "Icon"]:GetTexture());
		_G[srcButton:GetName() .. "Icon"]:SetVertexColor(1.0, 1.0, 1.0);
		_G[destButton:GetName() .. "Icon"]:SetVertexColor(1.0, 1.0, 1.0);

		-- If it was a player portait on the button, we need to update that as well
		if (Lunar.Button:GetButtonType(srcID, srcButton.currentStance, Lunar.Button:GetButtonSetting(srcID, srcButton.currentStance, LUNAR_GET_SHOW_ICON)) == 100) then
			SetPortraitTexture(_G[srcButton:GetName() .. "Icon"], "player");
		end
		if (Lunar.Button:GetButtonType(destID, destButton.currentStance, Lunar.Button:GetButtonSetting(destID, destButton.currentStance, LUNAR_GET_SHOW_ICON)) == 100) then
			SetPortraitTexture(_G[destButton:GetName() .. "Icon"], "player");
		end

		-- Update the button events
		srcButton.registeredEvents = false;
		destButton.registeredEvents = false;

		srcButton:SetAttribute('bindings-S0', ";;;");
		destButton:SetAttribute('bindings-S0', ";;;");
		Lunar.Button:SetupKeybinds(srcButton);
		Lunar.Button:SetupKeybinds(destButton);

		if (srcID > 10) then
			_G["LunarMenu" .. srcButton.parentID .. "ButtonHeader"]:SetAttribute("_bindingset", "");
			_G["LunarMenu" .. srcButton.parentID .. "ButtonHeader"]:SetAttribute('state-state', 
			_G["LunarMenu" .. srcButton.parentID .. "ButtonHeader"]:GetAttribute('state'));
		elseif (srcID == 0) then
			_G["LunarSphereMainButtonHeader"]:SetAttribute("_bindingset", "");
			_G["LunarSphereMainButtonHeader"]:SetAttribute('state-state', _G["LunarSphereMainButtonHeader"]:GetAttribute('state'));
		else		
			_G["LunarSphereButtonHeader"]:SetAttribute("_bindingset", "");
			_G["LunarSphereButtonHeader"]:SetAttribute('state-state', _G["LunarSphereButtonHeader"]:GetAttribute('state'));
		end

		if (destID > 10) then
			_G["LunarMenu" .. destButton.parentID .. "ButtonHeader"]:SetAttribute("_bindingset", "");
			_G["LunarMenu" .. destButton.parentID .. "ButtonHeader"]:SetAttribute('state-state', 
			_G["LunarMenu" .. destButton.parentID .. "ButtonHeader"]:GetAttribute('state'));
		elseif (srcID == 0) then
			_G["LunarSphereMainButtonHeader"]:SetAttribute("_bindingset", "");
			_G["LunarSphereMainButtonHeader"]:SetAttribute('state-state', _G["LunarSphereMainButtonHeader"]:GetAttribute('state'));
		else		
			_G["LunarSphereButtonHeader"]:SetAttribute("_bindingset", "");
			_G["LunarSphereButtonHeader"]:SetAttribute('state-state', _G["LunarSphereButtonHeader"]:GetAttribute('state'));
		end

		Lunar.Button:Update(srcButton);
		Lunar.Button:Update(destButton);

		-- Update currently selected spells or stances
		Lunar.Button:UpdateSpellState(srcButton);
		Lunar.Button:UpdateSpellState(destButton);

		-- Wipe our temporary table of left over data
		swapData.attributeType = nil;
		swapData.attributeValue = nil;
		swapData.texture = nil;

		-- Now, if it was a menu button, we need to swap the children too!
		if (swapMenu) then

			Lunar.Button:SetupMenuAngle(srcID);
			Lunar.Button:SetupMenuAngle(destID);

			-- Move the source and destination IDs to their children
			srcID = srcID * 12 - 2;
			destID = destID * 12 - 2;
			
			-- Start the swapping
			local index, tempState;
			for index = 1, 12 do --0 do 
				Lunar.Button:Swap(_G["LunarSub" .. tostring(srcID + index) .. "Button"], _G["LunarSub" .. tostring(destID + index) .. "Button"], true);
				if (LunarSphereSettings.buttonData[srcID + index].child ~= true) then
					_G["LunarSub" .. tostring(srcID + index) .. "Button"]:Hide();
--					_G["LunarSub" .. tostring(srcID + index) .. "Button"]:SetAttribute("showstates", "!0,!1");

				end
				if (LunarSphereSettings.buttonData[destID + index].child ~= true) then
					_G["LunarSub" .. tostring(destID + index) .. "Button"]:Hide();
--					_G["LunarSub" .. tostring(destID + index) .. "Button"]:SetAttribute("showstates", "!0,!1");
				end
			end
			
			_G["LunarMenu" .. ((srcID + 2) / 12) .. "ButtonHeader"]:SetAttribute('state-state', 
			_G["LunarMenu" .. ((srcID + 2) / 12) .. "ButtonHeader"]:GetAttribute('state'));
			_G["LunarMenu" .. ((destID + 2) / 12) .. "ButtonHeader"]:SetAttribute('state-state', 
			_G["LunarMenu" .. ((destID + 2) / 12) .. "ButtonHeader"]:GetAttribute('state'));

		end

--		Lunar.Button:ShowEmptyMenuButtons();
		Lunar.API:SupportForDrDamage();
	end
end

function Lunar.Button:TooltipOnShow()

--	GameTooltip:SetBackdrop(ItemRefTooltip:GetBackdrop()); --origBackdrop);
--	GameTooltip:SetBackdropColor(ItemRefTooltip:GetBackdropColor()); --unpack(origBackdropColor));

	if not Lunar.origBackdrop then
		Lunar.origBackdrop = GameTooltip:GetBackdrop();
		Lunar.origBackdropColor = {GameTooltip:GetBackdropColor()};
		Lunar.origBackdropBorderColor = {GameTooltip:GetBackdropBorderColor()};
	end

	-- Skinning
	if (LunarSphereSettings.skinTooltips == true) and ((Lunar.Button.tooltipCalled == true) or (LunarSphereSettings.skinAllTooltips == true)) then
		if not (Lunar.Button.tooltipSkinned) then
			Lunar.Button.tooltipSkinned = true;
			GameTooltip:SetBackdrop(LS_backdropTemplate);
			GameTooltip:SetBackdropBorderColor(unpack(LunarSphereSettings.tooltipBorder));
			GameTooltip:SetBackdropColor(unpack(LunarSphereSettings.tooltipBackground));
		end
	else
		if Lunar.Button.tooltipSkinned then
			Lunar.Button:TooltipOnHide();
		end
	end

	-- Positioning
--[[
	if not Lunar.Button.tooltipSetOwner then
		if (LunarSphereSettings.anchorMode == true) then
			if (Lunar.Button.tooltipCalled ~= true) then
				Lunar.Button.tooltipSetOwner = true;
				GameTooltip:SetOwner(GameTooltip:GetOwner(), "ANCHOR_NONE");

				local pos = LunarSphereSettings.anchorCorner +  1;
				GameTooltip:ClearAllPoints();
				GameTooltip:SetPoint(Lunar.Button.tooltipPos[9 - pos], _G["LSSettingsAnchor"], Lunar.Button.tooltipPos[pos]);
			end
		end
	else
		Lunar.Button.tooltipSetOwner = nil;
	end
--]]
	Lunar.Button.tooltipCalled = nil;
end

function Lunar.Button:TooltipSetOwner()

	Lunar.Button:TooltipOnShow()

	-- Positioning
--[[
	if not Lunar.Button.tooltipSetOwner then
		if (LunarSphereSettings.anchorMode == true) then
			if (Lunar.Button.tooltipCalled ~= true) then
				Lunar.Button.tooltipSetOwner = true;
				GameTooltip:SetOwner(GameTooltip:GetOwner(), "ANCHOR_NONE");
				local pos = LunarSphereSettings.anchorCorner +  1;
				GameTooltip:ClearAllPoints();
				GameTooltip:SetPoint(Lunar.Button.tooltipPos[9 - pos], _G["LSSettingsAnchor"], Lunar.Button.tooltipPos[pos]);
			end
		end
	else
		Lunar.Button.tooltipSetOwner = nil;
	end
--]]
end

function Lunar.Button:TooltipOnHide()
	if (LunarSphereSettings.skinTooltips) then --or (Lunar.Button.tooltipSkinned) then
		if (LunarSphereSettings.skinAllTooltips ~= true) then --or (LunarSphereSettings.skinTooltips ~= true) then
			if not Lunar.origBackdrop then
				Lunar.origBackdrop = GameTooltip:GetBackdrop();
				Lunar.origBackdropColor = {GameTooltip:GetBackdropColor()};
				Lunar.origBackdropBorderColor = {GameTooltip:GetBackdropBorderColor()};
			end
			GameTooltip:SetBackdrop(Lunar.origBackdrop); --ItemRefTooltip:GetBackdrop()); --Lunar.origBackdrop);
			GameTooltip:SetBackdropColor(unpack(Lunar.origBackdropColor)); --TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b); --unpack(Lunar.origBackdropColor));
			GameTooltip:SetBackdropBorderColor(unpack(Lunar.origBackdropBorderColor)); --TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
--	else

--		GameTooltip:SetBackdrop(backdrop);
--		GameTooltip:SetBackdropColor(unpack(LunarSphereSettings.tooltipBackground));
--		GameTooltip:SetBackdropBorderColor(unpack(LunarSphereSettings.tooltipBorder));
--		Lunar.Button.tooltipSkinned = true;
		end
	end
	Lunar.Button.tooltipSkinned = nil;
--[[
	if Lunar.Button.tooltipSkinned then

		Lunar.Button.tooltipSkinned = nil;
		GameTooltip:SetBackdrop(ItemRefTooltip:GetBackdrop()); --Lunar.origBackdrop);
		GameTooltip:SetBackdropColor(ItemRefTooltip:GetBackdropColor()); --unpack(Lunar.origBackdropColor));
		GameTooltip:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
	end
--]]
end

function Lunar.Button.SetDefaultAnchor(tooltip, parent, ...)
	if (tooltip == GameTooltip) then
		if not Lunar.Button.tooltipSetOwner then
			if (LunarSphereSettings.anchorMode == true) then
				GameTooltip:SetOwner(parent, "ANCHOR_NONE");
				local pos = LunarSphereSettings.anchorCorner +  1;
				GameTooltip:ClearAllPoints();
				GameTooltip:SetPoint(Lunar.Button.tooltipPos[9 - pos], _G["LSSettingsAnchor"], Lunar.Button.tooltipPos[pos]);
			end
		else
			Lunar.Button.tooltipSetOwner = nil;
		end
	end
end


function Lunar.Button:SetTooltip(self)

	if (not self) or (LunarSphereSettings.tooltipType == 0)  then
		return;
	end

	local myGameTooltip = GameTooltip;
	local catagoryStart = 7;

	if ((not LunarSphereSettings.buttonData[self:GetID()].empty)) or (self:GetID() == 0) then -- and (LunarSphereSettings.debugTooltips)) then

		myGameTooltip:ClearLines();

--		GameTooltip_SetDefaultAnchor(myGameTooltip, UIParent);
--		if ((self:GetID() < 6) or ((self:GetID() > 10) and (self:GetID() < (10 + (12*5))))) then
--			myGameTooltip:SetOwner(this, "ANCHOR_TOPLEFT"); --"ANCHOR_CURSOR");
--		else
--			myGameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT"); --"ANCHOR_CURSOR");
--		end
--		myGameTooltip:SetBackdrop(backdrop);
--		myGameTooltip:SetBackdropBorderColor(0,0,0,1);
--		myGameTooltip:SetBackdropColor(0,0,1,1);
--		myGameTooltip:SetOwner(this, "ANCHOR_TOPLEFT"); --"ANCHOR_CURSOR");
--		myGameTooltip:SetWidth(180);
		
		Lunar.Button.tooltipSetOwner = nil; --true;

--		Lunar.Button.tooltipCalled = true;
		GameTooltip_SetDefaultAnchor(myGameTooltip, self); --UIParent);
--		Lunar.Button.tooltipCalled = nil;

--		Lunar.Button.tooltipSetOwner = true;
--		Lunar.Button.tooltipSetOwner = true;

		local tooltipType = LunarSphereSettings.anchorModeLS;
		local pos = LunarSphereSettings.anchorCornerLS +  1;
		if (tooltipType == 0) then
--			GameTooltip_SetDefaultAnchor(myGameTooltip, UIParent);
		elseif (tooltipType == 1) then
			myGameTooltip:ClearAllPoints();
			myGameTooltip:SetPoint(Lunar.Button.tooltipPos[9 - pos], _G["LSSettingsLSAnchor"], Lunar.Button.tooltipPos[pos]);
		elseif (tooltipType == 2) then
			myGameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR");
		else
			pos = tooltipType - 2;	
			myGameTooltip:SetOwner(self, "ANCHOR_NONE");
			myGameTooltip:SetPoint(Lunar.Button.tooltipPos[9 - pos], self, Lunar.Button.tooltipPos[pos]);
		end

		if (self:GetID() == 0) then
			if (LunarSphereSettings.buttonEditMode == true) then
				myGameTooltip:AddLine(Lunar.Locale["_LS_DETAILS"], 1, 1, 1);
--				myGameTooltip:AddLine(Lunar.Locale["_LS_DETAILS"] .. " " .. Lunar.Locale["_EDIT_MODE_ON"], 1, 1, 1);
				myGameTooltip:AddLine(Lunar.Locale["_EDIT_MODE_ON"] .. "\n" .. Lunar.Locale["_EDIT_MODE_ON_DESC"], 1, 1, 1);
			else	
				myGameTooltip:AddLine(Lunar.Locale["_LS_DETAILS"], 1, 1, 1);
			end
			myGameTooltip:AddLine("========================", 1, 1, 1);
			myGameTooltip:AddLine("CTRL: " .. Lunar.Locale["_DROPDOWN_MENU"], 1, 1, 1);
			myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse1");
			myGameTooltip:AddLine("CTRL: " .. Lunar.Locale["_SETTINGS_MENU"], 1, 1, 1);
			myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse2");
			myGameTooltip:AddLine("========================", 1, 1, 1);

--			myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\Versions\\Source\\buttonSkin_scale.png");
		else
			if (LunarSphereSettings.buttonEditMode == true) then
				myGameTooltip:AddLine(Lunar.Locale["_CLICKS"] .. " " .. Lunar.Locale["_EDIT_MODE_ON"], 1, 1, 1);
				myGameTooltip:AddLine(Lunar.Locale["_EDIT_MODE_ON_DESC"], 1, 1, 1);
			else	
				myGameTooltip:AddLine(Lunar.Locale["_CLICKS"], 1, 1, 1);
			end
		end

		local index, buttonName, buttonType, actionType, actionName, buttonTexture, itemCount, keybindText;
		local textContainer, textContainerRight, r1, g1, b1, r2, g2, b2, spellID, spellRank, macroCommand;
		local stance = self.currentStance or Lunar.Button.defaultStance;
		local itemLink, objectMainType, objectType, stackTotal, itemCount;
		
		for index = 1, 3 do 
--			buttonName = "|cFFFFFF00";
			buttonName = "";
			if (index == 2) then
--				buttonName = "|cFFFFFF00R: ";
			end
			if (index == 3) then
--				buttonName = "|cFFFFFF00M: ";
			end
	
			-- Reuse old settings if we're using the same button
			if ((self:GetID() == Lunar.Button.currentMouseOver) and (Lunar.Button.tooltipStance == stance)) then
				buttonType = Lunar.Button["tooltipButtonType" .. index];
				actionType = Lunar.Button["tooltipActionType" .. index];
				actionName = Lunar.Button["tooltipActionName" .. index];
				buttonTexture = Lunar.Button["tooltipTex" .. index];
			else
				buttonType, actionType, actionName, buttonTexture = Lunar.Button:GetButtonData(self:GetID(), stance, index);
				if (buttonType == 3) and (self.subButtonType) then
					buttonType = self.subButtonType;
				elseif (buttonType == 4) and (self.subButtonType2) then
					buttonType = self.subButtonType2;
				end
				Lunar.Button["tooltipButtonType" .. index] = buttonType
				Lunar.Button["tooltipActionType" .. index] = actionType;
				Lunar.Button["tooltipActionName" .. index] = actionName;
				Lunar.Button["tooltipTex" .. index] = buttonTexture;

				if (index == 3) then
					Lunar.Button.tooltipStance = stance;
				end
			end

			if (LunarSphereSettings.buttonData[self:GetID()].isMenu) then
				if (Lunar.Button:GetButtonType(self:GetID(), 0, index)) == 2 then
					buttonType = 2;
				end
			end

			if not (LunarSphereSettings.hideKeybindTooltips) then
				local clickType = index;
				if (index == 2) then
					clickType = 3;
				elseif (index == 3) then
					clickType = 2;
				end
				keybindText = Lunar.Button:GetButtonKeybind(self:GetID(), stance, clickType) or ("") ;
				if (keybindText) and (keybindText ~= "") then
					keybindText = " |cFFFFFF00(" .. keybindText .. ")|r";
				end
			else
				keybindText = "";
			end

--			buttonType = LunarSphereSettings.buttonData[self:GetID()]["buttonType" .. index];
			itemCount = "";

			--print("buttonType (7121):", buttonType)

			if (buttonType) then

				--print("actionType (7125):", actionType)

				if (actionType == "item") then
					_, itemLink, _, _, _, objectMainType, objectType, stackTotal = GetItemInfo(actionName);

					-- Make sure we have a stackTotal (meaning, we have it in our in our inventory)
					-- Then, make sure the item is eligible for showing a count
					if (stackTotal) then

						if (IsConsumableItem(objectName) or (stackTotal > 1) or (objectType == Lunar.Items.reagentString) or (objectMainType == Lunar.Items:GetItemType("consume"))) then

							-- Grab the item ID and use that to find the item count based
							-- on charges left, or if that fails, the actual item count
							itemID = Lunar.API:GetItemID(itemLink);
--							itemCount = Lunar.Items:GetCharges(itemID);
--							if (itemCount) then
--								itemCount = " (" .. itemCount .. ")";
--							else
								itemCount = " (" .. GetItemCount(actionName, nil, true) .. ")";
--							end
						end
					end

				end

				if (buttonType == 1) or ((buttonType >= 3) and (buttonType <= 6)) then

					--print("buttonType (7152):", buttonType, ", ", actionName)

					if (actionName) and not ((actionName == "") or (actionName == " "))  then

						--print("buttonType (7169):", buttonType, ", ", actionName, ", ", actionType)

						if (buttonType == 5) then
							itemCount = itemCount .. "  |cFF00EE00" .. "[" .. Lunar.Locale["_SELFCAST"] .. "]|r";
						elseif (buttonType == 6) then
							itemCount = itemCount .. "  |cFF00EE00" .. "[" .. Lunar.Locale["_FOCUSCAST"] .. "]|r";
						end

						if (index > 1) then
							myGameTooltip:AddLine(" ", 1, 1, 1);
						end

--						if (actionType == "spell") then
							if (LunarSphereSettings.tooltipType == 2) then

								--print("buttonType (7184):", buttonType, ", ", actionName, ", ", actionType)

								if (actionType == "item") then
									myGameTooltip:AddLine(buttonName .. (GetItemInfo(actionName) or (actionName .. " " .. Lunar.Locale["_NOT_IN_CACHE"]))  .. " " .. itemCount .. keybindText, 1, 1, 1);
								else
									-- Make sure we don't show spell IDs
									if (actionName == tostring(tonumber(actionName))) then
										actionName = GetSpellInfo(actionName);
									end
										
									myGameTooltip:AddLine(buttonName .. actionName .. " " .. itemCount .. keybindText, 1, 1, 1);
								end
								myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
							else
								macroCommand = Lunar.API:MultiAddToTooltip(actionType, actionName, index, itemCount .. keybindText);

								--print("macroCommand : 7200, ", macroCommand)
							end

							--print("buttonType (7203):", buttonType, ", ", actionName, ", ", actionType)
--						else
--							Lunar.API:MultiAddToTooltip(actionType, actionName, index, itemCount);

							-- Small Tooltips
--							myGameTooltip:AddLine(buttonName .. actionName .. " " .. itemCount, 1, 1, 1);
--							myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
--						end
						if DrDamage and (actionType == "spell") and (LunarSphereSettings.enableDrDamageTips == true) then
--						if DrDamage and (LunarSphereSettings.enableDrDamage == true) and (actionType == "spell") and (LunarSphereSettings.enableDrDamageTips == true) then
							local spellID = Lunar.API:GetSpellID(actionName);
							if (spellID) then
								DrDamage:SetSpell(myGameTooltip, spellID);
							end
						end
						--print("buttonType (7218):", buttonType, ", ", actionName, ", ", actionType)
					else
						--print("buttonType (7220):", buttonType, ", ", actionName, ", ", actionType)
						if (buttonType == 3) then
							myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_LASTSUBMENU"] .. ": " .. NONE  .. keybindText, 1, 1, 1);
							myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
						elseif (buttonType == 4) then
							myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_LASTSUBMENU2"] .. ": " .. NONE  .. keybindText, 1, 1, 1);
							myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
						end
					end
--				if (actionType == "spell") then
--					
--				end

--]]

--				if (buttonType == 1) or (buttonType == 3)  then
--					if (actionName) and not ((actionName == "") or (actionName == " "))  then
--						myGameTooltip:AddLine(buttonName .. actionName .. " " .. itemCount, 1, 1, 1);
--					else
--						if (buttonType == 3) then
--							myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_LASTSUBMENU"] .. ": " .. NONE, 1, 1, 1);
--						end
--					end

				--print("SetTooltip (7240)")

				elseif (buttonType == 2) then
					--print("SetTooltip (7243)")
					if (index > 1) then
						myGameTooltip:AddLine(" ", 1, 1, 1);
					end
					myGameTooltip:AddLine(buttonName .. "Open Menu"  .. keybindText, 1, 1, 1);
					myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
				elseif (buttonType >= 10) then
					--print("SetTooltip (7250)")
					if (index > 1) then
						myGameTooltip:AddLine(" ", 1, 1, 1);
					end
					-- Random mount tooltip
--					if (buttonType > 82) and (buttonType < 90) then
--						myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_MOUNT" .. ((buttonType - 80) + 1)]  .. keybindText, 1, 1, 1);
--						myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
--					elseif (buttonType >= 90) and (buttonType < 100) then
					if (buttonType >= 90) and (buttonType < 100) then
						local usedSlots, totalSlots = Lunar.Button:GetBagCountData(buttonType);
						-- Don't show count on keyring
						if (buttonType == 96) then
							myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_BAG" .. ((buttonType - 90) + 1)] .. keybindText, 1, 1, 1);
						else
							myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_BAG" .. ((buttonType - 90) + 1)] .. " (" .. usedSlots .. "/" .. totalSlots .. ")"  .. keybindText, 1, 1, 1);
						end
						myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
					elseif (buttonType >= 100) and (buttonType < 110) then
						myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_MENUBAR" .. ((buttonType - 100) + 1)]  .. keybindText, 1, 1, 1);
						myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
					elseif (buttonType >= 52) and (buttonType < 60)  then
						myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_ENERGY" .. ((buttonType - 50) + 1)] .. ":"  .. keybindText, 1, 1, 1);
						myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
						if not ((actionName == "") or (actionName == "item: ") or (actionName == " ") or (actionName == nil)) then
							myGameTooltip:AddLine(actionName .. " " .. itemCount, 0.7, 0.7, 1);
						else
							myGameTooltip:AddLine(Lunar.Locale["OUT_OF_STOCK"], 1.0, 0, 0);
						end
					elseif (buttonType >= 110) and (buttonType < 130) then
						if (buttonType < 120) then
							myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_TRADE" .. ((buttonType - 110) + 1)] .. ":"  .. keybindText, 1, 1, 1);
						else
							myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_WEAPONAPPLY" .. ((buttonType - 120) + 1)] .. ":"  .. keybindText, 1, 1, 1);
						end
						myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
						if not ((actionName == "") or (actionName == "item: ") or (actionName == " ") or (actionName == nil)) then
							actionName = GetItemInfo(actionName);
							if (actionName == nil) then
								myGameTooltip:AddLine(Lunar.Locale["OUT_OF_STOCK"], 1.0, 0, 0);
							else
								myGameTooltip:AddLine(actionName .. " " .. itemCount, 0.7, 0.7, 1);
							end
						else
							myGameTooltip:AddLine(Lunar.Locale["OUT_OF_STOCK"], 1.0, 0, 0);
						end
					elseif (buttonType == 132) then
						myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_INVENTORY3"] .. keybindText, 1, 1, 1);
						myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
					elseif (buttonType == 133) then
						myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_INVENTORY4"] .. keybindText, 1, 1, 1);
						myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
						myGameTooltip:AddLine(buttonName .. string.gsub(actionName, "/equipset ", ""), 0.7, 0.7, 1);
					elseif (buttonType >= 140) and (buttonType < 150) then
						if (GetPetActionInfo(buttonType - 139)) then
							macroCommand = Lunar.API:MultiAddToTooltip("pet", tostring(buttonType - 139), index, itemCount  .. keybindText);
						else
							myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_PET" .. (buttonType - 139)] .. keybindText, 1, 1, 1);
							myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
						end
					elseif (actionType == "item") then
						-- Check to see if there is a texture attached (which means we have it in stock). If
						-- so, print the name. Otherwise, say that we're out of stock on this item catagory

						--print("SetTooltip (7309)")

						if (buttonTexture) and (GetItemCount(actionName) > 0) then
							if (LunarSphereSettings.tooltipType == 2) then
								myGameTooltip:AddLine(buttonName .. actionName .. " " .. itemCount  .. keybindText, 1, 1, 1);
								myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
							else
								Lunar.API:MultiAddToTooltip(actionType, actionName, index, itemCount .. keybindText);
--macroCommand = true;
							end
						else
							if (buttonType >= 50) and (buttonType < 52) then --60) then
--								if (buttonType < 52) then
									myGameTooltip:AddLine(buttonName .. Lunar.Locale["_ENERGY_DRINK"]  .. ": " .. Lunar.Locale["OUT_OF_STOCK"]  .. keybindText, 1, 1, 1);
									myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
--								else
--									myGameTooltip:AddLine(buttonName .. Lunar.Locale["BUTTON_ENERGY" .. ((buttonType - 50) + 1)] .. ":"  .. keybindText, 1, 1, 1);
--									myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
--									myGameTooltip:AddLine(Lunar.Locale["OUT_OF_STOCK"], 1.0, 0, 0);
--								end
							else
								myGameTooltip:AddLine(buttonName .. Lunar.Object.dropdownData["Button_Type"][math.floor(buttonType / 10) + catagoryStart][1] .. ": " .. Lunar.Locale["OUT_OF_STOCK"]  .. keybindText, 1, 1, 1);
								myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
							end
						end
					-- Spell mount support
					elseif (actionType == "spell") then
						if (LunarSphereSettings.tooltipType == 2) then
							myGameTooltip:AddLine(buttonName .. actionName .. " " .. itemCount  .. keybindText, 1, 1, 1);
							myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
						else
							Lunar.API:MultiAddToTooltip(actionType, actionName, index, itemCount  .. keybindText);
--macroCommand = true;
						end
					elseif (actionType == "macrotext") then
						-- Since this type only exists for the food AND water button type,
						-- we need to grab the food and water entries and list them
						local actionName2 = "";
						--if (buttonType == 12) or (buttonType == 22) or (buttonType == 13) or (buttonType == 23) then
						if (buttonType < 130) then
							actionName, actionName2 = string.match(actionName, "/use (.*)\n/use (.*)");
						else
							actionName = GetItemInfo(GetInventoryItemLink("player", buttonType - 117) or ("")) or ("");
						end
						myGameTooltip:AddLine(buttonName .. Lunar.Locale[Lunar.Object.dropdownData["Button_Type"][math.floor(buttonType / 10) + catagoryStart][3] .. (math.fmod(buttonType, 10) + 1)] .. keybindText, 1, 1, 1);
						myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
						if (actionName ~= "") then
							if (buttonType < 130) then
								myGameTooltip:AddLine("" .. buttonName .. actionName .. " (" .. (GetItemCount(actionName) or (0)) .. ")", 1, 1, 1);
							else
								myGameTooltip:AddLine("" .. buttonName .. actionName, 0.7, 0.7, 1);
							end
						else
							if (buttonType < 130) then
								myGameTooltip:AddLine(buttonName .. Lunar.Object.dropdownData["Button_Type"][2 + catagoryStart][1] .. ": " .. Lunar.Locale["OUT_OF_STOCK"], 1, 1, 1);
							else
								myGameTooltip:AddLine(buttonName .. Lunar.Locale["OUT_OF_STOCK"], 1, 1, 1);
							end
						end								
						if (actionName2 ~= "") then
							myGameTooltip:AddLine("" .. buttonName .. actionName2 .. " (" .. (GetItemCount(actionName2) or (0)) .. ")", 1, 1, 1);
						else
							if (buttonType < 130) then
								myGameTooltip:AddLine(buttonName .. Lunar.Object.dropdownData["Button_Type"][1 + catagoryStart][1] .. ": " .. Lunar.Locale["OUT_OF_STOCK"], 1, 1, 1);
							end
						end								
					end
				end

				--print("SetTooltip (7383)")
--
--				myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
--]]
			else
-- Simple Tooltip
--				if (index == 2) and (Lunar.Button:GetButtonType(self:GetID(), stance, 3)) then
--					myGameTooltip:AddLine(" ", 1, 1, 1);	
--					myGameTooltip:AddTexture("Interface\\Addons\\LunarSphere\\art\\tooltipMouse" .. index);
--				end
			end					
		end
		Lunar.Button.tooltipCalled = true;

		myGameTooltip:Show();

		--print("macroCommand : 7389, ", macroCommand)

		if (macroCommand) then
			--print("buttonType (7406)")
			myGameTooltip:SetWidth(myGameTooltip:GetWidth() + 32);
		else
			--print("buttonType (7409)")
			myGameTooltip:SetWidth(myGameTooltip:GetWidth() + 16);-- + 48);
			--print("buttonType (7411)")
		end
		--print("buttonType (7412)")
--		myGameTooltip:Show();
		if (LunarSphereSettings.fadeOutTooltips) then

			-- Check for CowTip auto-hide stuff... since it will hide our tooltip if it is set to hide and not
			-- fade out
			if not (CowTip and CowTip:IsModuleActive("Fade") and (CowTip:GetDatabaseNamespace("Fade").profile.otherFrames == "hide")) then
				myGameTooltip:FadeOut();
			end
		end
	end
end




function Lunar.Button:UpdateBindingText(button)

	local clickType = Lunar.Button:GetButtonSetting(button:GetID(), button.currentStance or (0), LUNAR_GET_SHOW_ICON);
	local keybind = "";
	if Lunar.Button:GetButtonType(button:GetID(), button.currentStance or (0), clickType) and (button:GetID() > 0) then
		if (clickType == 2) then
			clickType = 3;
		elseif (clickType == 3) then
			clickType = 2;
		end
		keybind = Lunar.Button:GetButtonKeybind(button:GetID(), 0, clickType);
		if (keybind) then
			keybind = "|cFFFFFFFF" .. Lunar.API:ShortKeybindText(keybind);
		end
	end
	_G[button:GetName() .. "HotKey"]:SetText(keybind);
end

function Lunar.getBuffIndex(unitId, spellName)
	for i = 1, 40 do
		if UnitBuff(unitName, i) == spellName then
			return i
		end
	end
	return false
end

--[[  No longer needed. GetCursorInfo returns proper data now.

function Lunar.Button.CompanionButton_OnDrag(self)
	
	-- Modified code from Blizzard's "CompanionButton_OnDrag"
	-- function from the PetPaperDollFrame.lua file, so I can
	-- figure out which pet is being dragged around =)

	local offset;
	local obj = PetPaperDollFrameCompanionFrame;
	if ( obj.mode=="CRITTER" ) then
		offset = (obj.pageCritter or 0) * NUM_COMPANIONS_PER_PAGE;
	elseif ( obj.mode=="MOUNT" ) then
		offset = (obj.pageMount or 0) * NUM_COMPANIONS_PER_PAGE;
	end
	dragged = self:GetID() + offset;
	Lunar.Button.CompanionType = obj.mode;
	Lunar.Button.CompanionID = dragged;

end
--]]

--[[

Icons: 
Talents: Interface\\Icons\\Ability_Marksmanship.png
Spellbook: Interface\\Icons\\INV_Misc_Book_09.png
]]

--[[

Vanity pet and mount items have been converted over to spells for the companion UI. 

There are two types of companions, "CRITTER" and "MOUNT" 

There is a new event which is sent to notify the UI that it should update, if visible. 
COMPANION_UPDATE type 
If the type is nil, the UI should update if it's visible, regardless of which type it's managing. If the type is non-nil, then it will be either "CRITTER" or "MOUNT" and that signifies that the active companion has changed and the UI should update if it's currently showing that type. 

There are several new companion script API functions: 
Return the number of that type of companion available: 
count = GetNumCompanions(type) 

Return information about the specified companion: 

creatureID, creatureName, spellID, icon, active = GetCompanionInfo(type, index) 

Place the corresponding spell into the cursor for placing on the action bar: 
PickupCompanion(type, index) 

Cast the corresponding spell to summon your companion or mount up. Note that this spell cast is currently not protected from AddOns, which means they can mount or call vanity pets at will. 
CallCompanion(type, index) 

Added PlayerModel:SetCreature(creatureID)

--]]