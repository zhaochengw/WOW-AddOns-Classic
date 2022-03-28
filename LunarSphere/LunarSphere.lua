-- /**********************
--   LunarSphere Info
--  *********************/
--	Author		: Moongaze (Twisting Nether - Horde - US)
--	Description		: A universal sphere for all classes.
--	Email			: moongazemods@gmail.com
--	Website		: 
--
--	Project Start	: April 7, 2007		- Didn't really know what I was getting myself into...
--
--	Project Milestones:
--				: May 5, 2007		- version 0.100 ready (Beta stage 1.0, "Sphere Test")
--				: May 14, 2007		- version 0.105 ready (Beta stage 1.5, bug fixes and button tease)
--				: May 26, 2007		- version 0.200 ready (Beta stage 2.0, "Button Test")
--				: May 31, 2007		- version 0.203 ready (Beta stage 2.3, bug fixes and menu buttons added)
--				: June 4, 2007		- version 0.206 ready (Beta stage 2.6, bug fixes and button settings added)
--				: June 8, 2007		- version 0.209 ready (Beta stage 2.9, left-middle-right click support)
--				: June 10, 2007		- version 0.300 ready (Beta stage 3.0, Inventory and Misc settings)
--				: June 29, 2007		- version 0.400 ready (Beta stage 4.0, Upgraded button settings)
--				: July 10, 2007		- version 0.403 ready (Beta stage 4.3, bug fixes, better item support)
--				: July 18, 2007		- version 0.406 ready (Beta stage 4.6, Skin tab added)
--				: August 19, 2007		- version 0.500 ready (Beta stage 5.0, Stance support)
--				: August 30, 2007		- version 0.506 ready (Beta stage 5.3, Lots of button options)
--				: October 7, 2007		- version 0.515 ready (Beta stage 5.5, Keybinds)
--				: November 4, 2007	- version 0.519 ready (Beta stage 5.8, Import art and more button types)
--				: December 2, 2007	- version 0.600 ready (Beta stage 6.0, Speech tab)
--				: December 28, 2007	- version 0.602 ready (Beta stage 6.2, More speech tags and channels)
--				: February 4, 2008	- version 0.608 ready (Beta stage 6.5, DrDamage support, spell ranks on buttons)
--				: March 30, 2008		- version 0.700 ready (Beta stage 7.0, Template tab, memory tab, and lots of small stuff)
--				: June 16, 2008		- version 0.709 ready (Beta stage 7.4, Button tab)
--				: October 14, 2008	- version 0.800 ready (Beta stage 8.0, WOW 3.0 compliant, lots of small features, Stage 7 was SO long!)
--				: December 19, 2008	- version 0.809 ready (Beta stage 8.7, Last template finally added, almost finished)
--
--	Project End		: January 1, 2009	- 20 months of ups and downs
--
--	Beta Downloads	: Over 20 months, around 200,000 downloads ... but about 10,000 actual unique
--				  visitors on a fairly unknown forum ... woot! Roughly 1,600 unique downloads
--				  per version near the end of the beta, meaning at least 1,600 active testers
--				  at the end, on an unknown forum ... word of mouth? O.O
--
--	Wish List for Version 2	: One step at a time ... but yes, there will be a version 2, or a lot of releases after version 1.
--
---------------------------------------------------
--
--	Fix Author		: Shaun Voysey (UK)
--	Email			: sv.public@hotmail.com
--
--	v1.20 Fixed		: 21st June, 2015	- 3 Days Banging my Head in try to fix this.  Most seemed ok, bu Manastone no longer exists
--				  and Healthstone now down to one.  And why is it always the Mount system thats the pain...
--
--	v1.23 Fixed		: 21st July, 2015	- Mounts now working in the sphere.
--				  Pets are not yet working, nor the movement of the buttons.
--				  have removed some old code I put in a while ago for the Profession mounts.  No longer needed.
--
--	v1.26 Fixed		: 11th September, 2015	- Shine on ready - Fixed.
--				  Found an issue with reverse Guages not working. Sorted. Blasted GetCheck() with True/False, when a number were needes.
--				  Found some template issues with mounts.  Fixed.
--
--	v1.27 Fixed		: 17th October, 2015	- Auction and Bid totals on Standard Auction frames - Fixed.
--				  Corrected am issue with the setting windows for the skins. Did not scroll through properly.
--				  Corected some Debug issues.  Mainly to do with mounts.
--
--	v1.30 Fixed		: 28th July, 2016		- Mount System Fixed.
--								  Icon/Tectures Fixed.
--								  Items from Auction List fixed.
--								  And thanks to Dootchie,  Menus - Fixed
--								  Rogue Outerguage is woking, but can be improved
--
-- v1.50 Fixed		: 8th September, 2020	-- Background fix.
--
--
---------------------------------------------------
--
-- Fix Author		: Toludin-Stormrage
--
-- v1.40 Fixed		: July 24, 2018 - initial BfA compatibility release
--
-- v1.42 Fixed		: January 29, 2020

-- /***********************************************

-- Fun LDB support if I want to add it to the buttons. This will show the tooltip of a LDB addon that's loaded. This
-- code will show all tooltips of all addons, but only the last one will be shown. If I do this support, I just iterate through all
-- of the LDB addons and see if they these attributes:
--
--	.text (The text to be shown on the FuBar or TitanPanel addon
--	.OnClick (The on click action for clicking the button)
--	.icon (The icon to be used for the addon)
--	.OnTooltipShow (The tooltip to be shown)
--
-- /script local key, value; for key, value in pairs(LibStub:GetLibrary("LibDataBroker-1.1").proxystorage) do GameTooltip:ClearLines(); value.OnTooltipShow(GameTooltip); GameTooltip:Show() end

LUNARSPHERE_CHAT = "|cFF82B8E1Lunar|cFFA1CAE8Sph|cFFC7DFF1ere: |r";
LUNAR_ICON_PREFIX = "Interface\\Icons\\"
LUNAR_CURRENT_VERSION = 1.52;

-- Luunar Backdrop texture
LS_BACKDROP = {
	--The background texture Information
	bginfo = "BACKDROP_DIALOG_12_12",

	-- path to the background texture
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",

	-- path to the border texture
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",

	-- true to repeat the background texture to fill the frame, false to scale it
	tile = true,

	-- size (width or height) of the square repeating background tiles (in pixels)
	tileSize = 32,

	-- thickness of edge segments and square size of edge corners (in pixels)
	edgeSize = 10,

	-- distance from the edges of the frame to those of the background texture (in pixels)
	insets = { left = 1, right = 1, top = 1, bottom = 1 }
}

-- Define built-in texture counts
Lunar.includedButtons = 38;
Lunar.includedSpheres = 8;
Lunar.includedBorders = 4;
Lunar.includedGauges = 6;

local playerLoginCheck = {};

-- /***********************************************
--   LunarSphere Functions
--  *********************/

-- /***********************************************
--   LunarSphere_OnLoad
--
--   Prepares the mod for initial setup
--
--   accepts:	none
--   returns:	none
--  *********************/
function LunarSphere_OnLoad(self)

	-- Register our events
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("PLAYER_LOGIN");

	SLASH_LUNARSPHERE1 = "/lunarsphere";
	SLASH_LUNARSPHERE2 = "/ls";
	SlashCmdList["LUNARSPHERE"] = LunarSphere_SlashHandler;

	Lunar.Items:Initialize();

end

-- /***********************************************
--   LunarSphere_OnEvent
--
--   Handles all event messages
--
--   accepts:	none (event and args are passed)
--   returns:	none
--  *********************/
function LunarSphere_OnEvent(self, event)

	-- If we just loaded up...
	if (event == "VARIABLES_LOADED") then

		LunarSphere_VariablesLoaded();

	end

	-- If the player finished logging in (spells are now in the spell book)
	if (event == "PLAYER_LOGIN") then

		-- If the variables loaded event never fired, or wasn't caught in time (?), execute the code anyway
		-- This seems to happen sometimes with Decursive users, I'm a little stumped myself...
		if (not Lunar.varLoaded) then
			LunarSphere_VariablesLoaded();
		end

		-- Load up our exporter and get our export database ready
		local isLoaded = IsAddOnLoaded("LunarSphereExporter");
		if ( not isLoaded ) then
			EnableAddOn("LunarSphereExporter") 
			isLoaded = LoadAddOn("LunarSphereExporter");
		end
		
		if (Lunar.Settings.BuildTemplateList) then
			Lunar.Settings:BuildTemplateList();
		end

		-- If we are loading a template, do so now.
		if (LunarSphereSettings.loadTemplate) then
			Lunar.Template:LoadTemplateData();
		end

		-- Set the random seed for the randomizer, for the random sphere texture feature
		-- and throw away the first number.
		if (math) and (math.randomseed) then
			math.randomseed(math.random(0,214748364)+(GetTime()*1000));
			math.random(1,1000);
		end

		-- Stop watching these events
		self:UnregisterEvent("PLAYER_LOGIN");
		self:UnregisterEvent("VARIABLES_LOADED");

--		Lunar.Sphere:Initialize();

		-- Run the backwards compatibility that requires player login, fairly rare to use it...
		LunarSphere_BackwardsCompatibility_PlayerLogin();

		-- Now that we have spell data, time to finish the template loading
		if (LunarSphereSettings.loadTemplate) then
			Lunar.Template:ParseTemplateData();
			LunarSphereSettings.loadTemplate = nil;
		end

		-- Initialize our buttons
		Lunar.Button:Initialize();
		Lunar.API:SupportForDrDamage();

--		_G["LSbackground"]:RegisterEvent("CURSOR_UPDATE");

		-- Create our auction house frames
		if not (LunarSphereSettings.memoryDisableAHTotals) then
--			Lunar.API:CreateBidTotals();
--			Lunar.API:CreateAuctionTotals();
		end
--		Lunar.API:CreateMinimapText()

		-- If we are using imported button skin art, apply it now
		if (LunarSphereSettings.buttonSkin > Lunar.includedButtons) then
			artIndex, artType, width, height, artFilename = Lunar.API:GetArtByCatagoryIndex("button", LunarSphereSettings.buttonSkin - Lunar.includedButtons);
			if (artFilename) then
				Lunar.Button:UpdateSkin(LUNAR_IMPORT_PATH .. artFilename);
			else
				Lunar.Button:UpdateSkin(LUNAR_ART_PATH .. "buttonSkin_1.blp");
			end
		end	

		Lunar.Sphere:RunPlayerLoginGaugeSetup();

		-- If the user has the Sphere Unlocked glow turned on, show it now
		Lunar.Sphere:ShowSphereEditGlow(LunarSphereSettings.showSphereEditGlow);

		if (Lunar.Settings.StartupDialog) then
			Lunar.Settings.StartupDialog:Show();
			Lunar.Settings.StartupDialog:Show();
		end

		_G["LSmain"]:ClearAllPoints();
		_G["LSmain"]:SetPoint(LunarSphereSettings.relativePoint, UIParent, LunarSphereSettings.relativePoint, LunarSphereSettings.xOfs, LunarSphereSettings.yOfs);

		-- Make our buttons that need to show or hide appear or disappear :)
--		Lunar.Button:CheckVisibilityOptions();

		if not (LunarSphereSettings.memoryDisableSpeech) then
			Lunar.Speech:Initialize()
		end

--		Lunar.API:SetupGuildRepairDialog()

		hooksecurefunc(getmetatable(GameTooltip).__index, "SetOwner", Lunar.Button.TooltipSetOwner);
		hooksecurefunc(getmetatable(GameTooltip).__index, "Show", Lunar.Button.TooltipOnShow);
--		hooksecurefunc(GameTooltip, "SetOwner", Lunar.Button.TooltipSetOwner);
--		hooksecurefunc(GameTooltip, "Show", Lunar.Button.TooltipOnShow);
--		hooksecurefunc(GameTooltip, "ClearLines", Lunar.Button.TooltipOnShow);
--		hooksecurefunc(GameTooltip, "SetPoint", Lunar.Button.TooltipSetOwner);
		hooksecurefunc("GameTooltip_OnHide", Lunar.Button.TooltipOnHide);
		hooksecurefunc("GameTooltip_SetDefaultAnchor", Lunar.Button.SetDefaultAnchor);

		hooksecurefunc("ToggleDropDownMenu", Lunar.Object.SkinDropDown);
--		hooksecurefunc("CompanionButton_OnDrag", Lunar.Button.CompanionButton_OnDrag);
--hooksecurefunc(
--ToggleDropDownMenu

		if not (LunarSphereSettings.memoryDisableDefaultUI) then
			Lunar.API:HidePlayerFrame(LunarSphereSettings.hidePlayer, true);
--			Lunar.API:HideMinimapTime(LunarSphereSettings.hideTime, true);
			Lunar.API:HideMinimapZoom(LunarSphereSettings.hideZoom, true);
			Lunar.API:HideMinimap(LunarSphereSettings.hideMinimap, true);
			Lunar.API:HideTotemBar(LunarSphereSettings.hideTotemBar, true);
			Lunar.API:HideExpBars(LunarSphereSettings.hideEXP, true);
			Lunar.API:HideGryphons(LunarSphereSettings.hideGryphons, true);
			Lunar.API:HideMenus(LunarSphereSettings.hideMenus, true);
			Lunar.API:HideBags(LunarSphereSettings.hideBags, true);
			Lunar.API:HideBottomBar(LunarSphereSettings.hideBottomBar, true);
			Lunar.API:HideStanceBar(LunarSphereSettings.hideStance, true);
			Lunar.API:HideActionButtons(LunarSphereSettings.hideActions, true);
			Lunar.API:HidePetBar(LunarSphereSettings.hidePetBar, true);
			Lunar.API:HideCalendar(LunarSphereSettings.hideCalendar, true);
			Lunar.API:HideWorldmap(LunarSphereSettings.hideWorldmap, true);
			Lunar.API:HideTracking(LunarSphereSettings.hideTracking, true);
		end

		-- The following block of code was taken from worldofwar.net in the forums.
		-- It was provided by Telic and is a fix for some of the open menu taint issues
		-- introduced with the fun Focus frame.
		-- From: http://www.worldofwar.net/forums/showthread.php?p=4165675
		-- ============================ Start block of code ============================
--[[ No longer needed?
		if ( UIDROPDOWNMENU_MAXBUTTONS < 29 ) then
			local toggle;
			if ( not WorldMapFrame:IsVisible() ) then
				ToggleFrame(WorldMapFrame);
				toggle = true;
			end
			SetMapZoom(2);
			if ( toggle ) then
				ToggleFrame(WorldMapFrame);
			end
		end
--]]
		-- ============================ End block of code ============================

		-- Free all the functions we no longer need from memory
		if (LunarSphereGlobal.debugModeOn == true) then
			collectgarbage();
		end
		Lunar.Debug("LunarSphere memory usage (before memory dump): " .. Lunar.API:MemoryUsage());
		LunarSphere_OnEvent = nil;
		self:SetScript("OnLoad", Lunar.API.BlankFunction);
		self:SetScript("OnEvent", Lunar.API.BlankFunction);
		LunarSphere_FreeMemory()
		LunarSphere_FreeMemory = nil;
--		collectgarbage();

		if not (LunarSphereSettings.memoryDisableMinimap) then
			Lunar.API:SetMinimapScroll(LunarSphereSettings.minimapScroll);
		end

		Lunar.Sphere:ToggleSphere(LunarSphereSettings.sphereAlpha);
		Lunar.Sphere:ToggleAll(LunarSphereSettings.toggleAll or (1))
		
		if (LunarSphereSettings.debugMinimapTexture) then
			Lunar.Sphere:MinimapTest()
		end
		
		a = {}
		
		-- Croq added a check to see if IO was empty
		if not io == nil then
			for line in io.lines() do
			  table.insert(a, line)
			end
			print(table.getn(a))         --> (number of lines read)
		end
	end
end

function LunarSphere_VariablesLoaded()

	Lunar.varLoaded = true;

	-- Import our data from the export file in the LunarSphere folder
	LunarSphereImport = LunarSphereExport;
	LunarSphereExport = nil;

	-- If we wiped all data from LS, restore our backup data.
	if LunarSphereGlobal.backupDB then
		LunarSphereSettings.backupDB = LunarSphereGlobal.backupDB;
		LunarSphereSettings.backupSize = LunarSphereGlobal.backupSize;
		LunarSphereGlobal.backupDB = nil;
		LunarSphereGlobal.backupSize = nil;
	end

	-- Load up our exporter and get our export database ready
--	local isLoaded = IsAddOnLoaded("LunarSphereExporter");
--	if ( not isLoaded ) then
--		EnableAddOn("LunarSphereExporter") 
--		isLoaded = LoadAddOn("LunarSphereExporter");
--	end

	-- Run our version checking code. If the versions are not current,
	-- we'll attach a message to the LunarSphere startup message box
	-- and display it (while also saving the original settings if they
	-- existed)
	local versionOK = true;

	versionOK = (versionOK == true) and (Lunar.API.version == LUNAR_CURRENT_VERSION);
	versionOK = (versionOK == true) and (Lunar.Button.version == LUNAR_CURRENT_VERSION); 
	versionOK = (versionOK == true) and (Lunar.Items.version == LUNAR_CURRENT_VERSION);
	versionOK = (versionOK == true) and (Lunar.Object.version == LUNAR_CURRENT_VERSION);
	versionOK = (versionOK == true) and (Lunar.Settings.version == LUNAR_CURRENT_VERSION);
	versionOK = (versionOK == true) and (Lunar.Sphere.version == LUNAR_CURRENT_VERSION);
	versionOK = (versionOK == true) and (Lunar.Template.version == LUNAR_CURRENT_VERSION);
	versionOK = (versionOK == true) and (Lunar.Memory.version == LUNAR_CURRENT_VERSION);
	versionOK = (versionOK == true) and (Lunar.Locale.version == LUNAR_CURRENT_VERSION);
	if (Lunar.Export) then
		versionOK = (versionOK == true) and (Lunar.Export.version == LUNAR_CURRENT_VERSION);
	end
	
	if not (versionOK) then
		--[[Lunar.showStartupMessage = LunarSphereSettings.showStartupMessage;
		Lunar.startupMessage = LunarSphereSettings.startupMessage;
		LunarSphereSettings.showStartupMessage = true;
		LunarSphereSettings.startupMessage = Lunar.Locale["ERROR_STARTUP"];]]--
	end
	
	--Lunar.API:MemoryLoader();

	-- Run our backward compatibility function to add any new
	-- entries to a user's saved variables, and fix any changes
	-- made since the last patch of LunarSphere
	
	LunarSphere_BackwardsCompatibility();

	-- Fix our extra power text to be the proper power for our class
	local _, playerClass = UnitClass("player");
	local powerType = NONE;
	if (playerClass == "PALADIN") then
		powerType = HOLY_POWER;
	elseif (playerClass == "WARLOCK") then
		powerType = SOUL_SHARDS;
	elseif (playerClass == "DRUID") then
		powerType = ECLIPSE;
	elseif (playerClass == "ROGUE") then
		powerType = COMBAT_TEXT_SHOW_COMBO_POINTS_TEXT;
	end
	Lunar.Locale["EVENT_EXTRA_POWER"] = (string.gsub(Lunar.Locale["EVENT_EXTRA_POWER"], "___", powerType));

	Lunar.Object.dropdownData["Gauge_Events"][8][1] = Lunar.Locale["EVENT_EXTRA_POWER"];
	Lunar.Object.dropdownData["Sphere_Events"][9][1] = Lunar.Locale["EVENT_EXTRA_POWER"];

	Lunar.API:Load();
	Lunar.Settings:Load();
	Lunar.Speech:Load();

	-- If we are loading a template, do so now.
--	if (LunarSphereSettings.loadTemplate) then
--		Lunar.Template:LoadTemplateData();			
--	end
	
	-- Fix old event types
	LunarSphere_ConvertOldEventTypes()

	-- Check our art database for missing files and remove them.
	-- Also check our sphere skin index and if it is no longer
	-- valid, set it to the last skin image found.

	Lunar.API:CheckArtDatabase()
	local artCount = Lunar.includedSpheres + LUNAR_EXTRA_SPHERE_ICON_COUNT;
	if LunarSphereGlobal.artDatabase then
		artCount = artCount + table.getn(LunarSphereGlobal.artDatabase);
	end
	if LunarSphereSettings.sphereSkin > artCount then
		LunarSphereSettings.sphereSkin = artCount;
	end

	if not (LunarSphereSettings.memoryDisableTemplates) then
		Lunar.Settings:BuildTemplateList();
	end

	if not (LunarSphereSettings.memoryDisableMinimap) then
		Lunar.API:CreateMinimapText()
	end

	-- Run our initialization routinues for our Lunar objects
	Lunar.Sphere:Initialize();
	Lunar.Settings:Initialize();

	-- If the random sphere image feature is turned on, randomize our sphere
	-- image.
	if (LunarSphereSettings.randomSphereTexture == true) then
		Lunar.Sphere:SetSphereTexture(math.random(1, (Lunar.includedSpheres + LUNAR_EXTRA_SPHERE_ICON_COUNT + Lunar.API:GetArtCount("sphere"))))
	end

--		Lunar.Settings.updateScale = GetCVar("useUiScale");
	Lunar.Settings.updateScale = tonumber(GetCVar("useUiScale"));

	-- Restore the original saved startup messages
	if (not (versionOK)) or (Lunar.startupMessage) then
		if (LunarSphereSettings.startupMessage) then
			_G["LSSettingsStartUpMessage"]:SetText(Lunar.startupMessage);
		end
		_G["LSSettingsshowStartupMessage"]:SetChecked(Lunar.showStartupMessage);
		LunarSphereSettings.showStartupMessage = Lunar.showStartupMessage;
		LunarSphereSettings.startupMessage = Lunar.startupMessage;
		Lunar.showStartupMessage = nil;
		Lunar.startupMessage = nil;
	end

	Lunar.Settings:CreateAnchorPlaceholders();

	if not (LunarSphereSettings.memoryDisableTemplates) then
		Lunar.Settings:CreateTemplateHandlerDialog();
	end

	-- Set the internal LunarSphere text messages
	Lunar.API.junkSaleText = Lunar.Locale["JUNK_SALE_TEXT"];
	Lunar.API.repairCostText = Lunar.Locale["REPAIR_COST_TEXT"];

	-- Do the Blizzard Macro Fix, if need be.
	if (LunarSphereSettings.debugMacroFix == 1) then
		LunarSphere_MacroFix();
	end
--
--]]
--		if (LunarSphereSettings.drDamageSupport == true) then
--
--		end

	-- Move the Blizzard color picker frame to the dialog strata
	ColorPickerFrame:SetFrameStrata("Dialog");

	if (LunarSphereSettings.debugMinimapTexture) then
		Lunar.Sphere:MinimapTest()
	end

end

-- /***********************************************
--   LunarSphere_FreeMemory
--
--   Frees all functions from memory that are no longer needed
--
--   accepts:	none
--   returns:	none
--  *********************/
function LunarSphere_FreeMemory()

	-- Since those routinues only needed to be ran once, free that
	-- space from memory and collect the garbage left over
	-- Total freed memory: 86.2k 

	Lunar.Sphere.Initialize = nil;
	Lunar.API.CreateBidTotals = nil;
	Lunar.API.CreateAuctionTotals = nil;
	Lunar.API.CreateMinimapText = nil;
	Lunar.Button.Initialize  = nil;
	Lunar.Button.Create = nil;
--	Lunar.Button.LoadButtonData = nil;
	Lunar.Items.Initialize = nil;
	Lunar.Settings.Initialize  = nil;
	Lunar.Settings.CreateActionAssignmentDialog = nil;
	Lunar.Settings.CreateButtonDialog = nil;
	Lunar.Settings.CreateRepairLogDialog = nil;
	Lunar.Settings.CreateStartupDialog = nil;
	Lunar.Settings.CreateAnchorPlaceholders = nil;
	Lunar.Settings.CreateTemplateHandlerDialog = nil;
	Lunar.Object.CreateDropdown = nil;
	Lunar.Object.CreateSlider = nil;
	Lunar.Object.CreateImage = nil;
	Lunar.Object.CreateButton = nil;
	Lunar.Object.CreateColorSelector = nil;
	Lunar.Object.CreateCheckbox = nil;
	Lunar.Object.CreateIconPlaceholder = nil;
	Lunar.Object.CreateCaption = nil;
	Lunar.Object.Create = nil;
	Lunar.Speech.Initialize = nil;
	Lunar.Speech.LoadLibrary = nil;
--	Lunar.Template = nil;
	LunarSphere_BackwardsCompatibility = nil;
	LunarSphere_BackwardsCompatibility_PlayerLogin = nil;
	LunarSphere_FreeMemory = nil;
	LunarSphere_MacroFix = nil;
	LunarSphere_ConvertOldEventTypes = nil;
	LunarSphere_VariablesLoaded = nil;

	Lunar.Speech.Load = nil;
	Lunar.Settings.Load = nil;
	Lunar.API.Load = nil;

	-- If hot swapping of templates is off, or templates are off, clear it all up.
	if LunarSphereSettings.memoryDisableTemplates or (not LunarSphereSettings.enableTemplateHotswapping) then
		Lunar.Template = nil;
		Lunar.Button.ReloadAllButtons = nil;

	-- Otherwise, just wipe the templates we don't need.
	else
		local i;
		local templateDB = {};
		local _, playerClass = UnitClass("player");
		local templateClass;
		for i = 1, table.getn(Lunar.Template.template) do 
			_, templateClass = string.match(Lunar.Template.template[i].listData, "(.*):::(.*):::(.*):::(.*)")
			if (templateClass == "ANY") or (templateClass == playerClass) then
				table.insert(templateDB, Lunar.Template.template[i]);
			end
		end
		Lunar.Template.template = templateDB;
	end			

	if (LunarSphereSettings.memoryDisableSkins) then
		Lunar.API.GetNextArt = nil;
		Lunar.API.GetArtCount = nil;
		Lunar.API.FindArt = nil;
		Lunar.API.RemoveArt = nil;
		Lunar.API.ArtExists = nil;
		Lunar.API.AddArt = nil;
		Lunar.API.CheckArtDatabase = nil;
	end

	local key, value;
	for key, value in pairs(Lunar.Locale) do
		if not (string.sub(key, 1, 6) == "BUTTON") then
			if not (string.sub(key, 1, 5) == "EVENT") then
				if not (string.sub(key, 1, 1) == "_") and not (key == "BUTTON_MENU")  then
					if not (key == "OUT_OF_STOCK") and not (key == "REPAIR_COST_TEXT") and not (key == "JUNK_SALE_TEXT") and not (key == "REAGENT_TOTALCOST_TEXT") then
						Lunar.Locale[key] = nil;
					end
				end
			end
		end
	end

	collectgarbage();

	Lunar.Debug("LunarSphere memory usage (after memory dump): " .. Lunar.API:MemoryUsage());

end

-- /***********************************************
--   LunarSphere_BackwardsCompatibility
--
--   Ensures that the saved variables LunarSphere uses is up-to-date
--   and modified if new changes come up.
--
--   accepts:	none
--   returns:	none
--  *********************/
function LunarSphere_BackwardsCompatibility()

	-- Set our locals
	local index, newIndex, tempIndex;

	-- Ensure that our Tuesday Debug Mode is turned on by default if not found
	-- (actually, now we remove it)
	if (LunarSphereSettings.debugTuesday) then
		LunarSphereSettings.debugTuesday = nil;
	end

	-- If the scale doesn't exist, set it
	if (not LunarSphereSettings.sphereScale) then
		LunarSphereSettings.sphereScale = 1.0;
	end

	-- If the gauge colors don't have a reference, set them
	if (not LunarSphereSettings.gaugeColor) then
		LunarSphereSettings.gaugeColor = {
			["mana"]   = {0.0, 0.3, 1.0, false, 0.0, 0.3, 1.0};
			["five"]   = {1.0, 1.0, 1.0, false, 1.0, 1.0, 1.0};
			["health"] = {0.0, 1.0, 0.0, false, 0.0, 1.0, 0.0};
			["exp"]    = {0.7, 0.0, 0.7, false, 0.7, 0.0, 0.7};
			["rep"]    = {0.0, 0.7, 0.7, false, 0.0, 0.7, 0.7};
			["rage"]   = {1.0, 0.0, 0.0, false, 1.0, 0.0, 0.0};
			["combo"]  = {1.0, 0.0, 0.0, false, 1.0, 0.0, 0.0};
			["energy"] = {1.0, 1.0, 0.0, false, 1.0, 1.0, 0.0};
		};
	end

	-- If we don't have button data, create it
	if (not LunarSphereSettings.buttonData) then
		LunarSphereSettings.buttonData = {};
	end

	-- If the skin ID isn't set, do so now
	if (not LunarSphereSettings.buttonSkin) then
		LunarSphereSettings.buttonSkin = 1;
	end

	-- If the menu button color doesn't exist, set it
	if (not LunarSphereSettings.menuButtonColor) then
		LunarSphereSettings.menuButtonColor = {0.0, 0.0, 1.0};
	end

	-- If the button color doesn't exist, set it
	if (not LunarSphereSettings.buttonColor) then
		LunarSphereSettings.buttonColor = {1.0, 1.0, 1.0};
	end

	-- If the edit mode glow doesn't exist, set it.
	if (not LunarSphereSettings.showSphereEditGlow) then
		LunarSphereSettings.showSphereEditGlow = 1;
	end

	-- If the reagent list table doesn't exist, make it
	if (not LunarSphereSettings.reagentList) then
		LunarSphereSettings.reagentList = {};
	end

	-- Database Conversion: Converts the original actionName, actionType, and buttonType
	-- entries into the left click naming standard, and then deletes the original entry.
	for index=1, table.getn(LunarSphereSettings.buttonData) do 
		if (LunarSphereSettings.buttonData[index].texture) then
			LunarSphereSettings.buttonData[index].actionName1 = LunarSphereSettings.buttonData[index].actionName
			LunarSphereSettings.buttonData[index].actionType1 = LunarSphereSettings.buttonData[index].actionType
			LunarSphereSettings.buttonData[index].buttonType1 = LunarSphereSettings.buttonData[index].buttonType
			LunarSphereSettings.buttonData[index].texture1 = LunarSphereSettings.buttonData[index].texture
			if (LunarSphereSettings.buttonData[index].actionName) then
				LunarSphereSettings.buttonData[index].buttonType1 = 1;
			end
			if (LunarSphereSettings.buttonData[index].isMenu) then
				LunarSphereSettings.buttonData[index].buttonType1 = 2;
			end
			LunarSphereSettings.buttonData[index].actionName = nil
			LunarSphereSettings.buttonData[index].actionType = nil
			LunarSphereSettings.buttonData[index].buttonType = nil
			LunarSphereSettings.buttonData[index].texture = nil
		end
	end

	-- Make sure we have a server time offset if the user wants to show the time on the minimap
	if (not LunarSphereSettings.timeOffset) then
		LunarSphereSettings.timeOffset = 0;
	end

	-- Database conversion: Converts the old sellArmor, sellWeapons, and sellNonEquip entries to the
	-- new format (keepArmor, keepWeapons, and keepNonEquip)
--[[	if (not LunarSphereSettings.keepNonEquip) then
		LunarSphereSettings.keepArmor = 1;
		LunarSphereSettings.keepWeapons = 1;
		LunarSphereSettings.keepNonEquip = 1;
		if (LunarSphereSettings.sellNonEquip) then
			LunarSphereSettings.keepNonEquip = 0;
			LunarSphereSettings.sellNonEquip = nil;
		end
		if (LunarSphereSettings.sellArmor) then
			LunarSphereSettings.keepArmor = 0;
			LunarSphereSettings.sellArmor = nil;
		end
		if (LunarSphereSettings.sellWeapons) then
			LunarSphereSettings.keepWeapons = 0;
			LunarSphereSettings.sellWeapons = nil;
		end
	end
--]]
	-- If the version number doesn't exist, make it now (and set it for the version it should have existed)
	if (not LunarSphereSettings.versionID) then
		LunarSphereSettings.versionID = 0.35;
	end

	-- If our version is older than 0.4, update our button database to the new database
	if (LunarSphereSettings.versionID < 0.4) then
		LunarSphereSettings.versionID = 0.4;
		for index = 1, 130 do 
			if (not LunarSphereSettings.buttonData[index]) then
				LunarSphereSettings.buttonData[index] = {};
				Lunar.Button:ResetButtonData(index);
			end
		end
		newIndex = 130;
		tempIndex = 12;
		index = 110;
		local key, value;
		while (index > 10) do 
			if (tempIndex > 10) then
				Lunar.Button:ResetButtonData(newIndex);
			else
				LunarSphereSettings.buttonData[newIndex] = {};
				for key, value in pairs(LunarSphereSettings.buttonData[index]) do
					LunarSphereSettings.buttonData[newIndex][key] = value;
				end
				index = index - 1;
			end
			newIndex = newIndex - 1;
			tempIndex = tempIndex - 1;
			if (tempIndex <= 0) then
				tempIndex = 12;
			end
		end
	end

	-- If our version is older than 0.401, update our button database to the new database
	if (LunarSphereSettings.versionID < 0.401) then
		LunarSphereSettings.versionID = 0.401;
		for index = 1, 10 do 
			if (LunarSphereSettings.buttonData[index].isMenu) then
				LunarSphereSettings.buttonData[index].buttonType1 = 2;
			end
		end
	end

	-- If our version is older than 0.402, check each menu button for broken data and convert the
	-- auction house settings
	if (LunarSphereSettings.versionID < 0.402) then
		LunarSphereSettings.versionID = 0.402;
		
		if (LunarSphereSettings.showTotalBid) or (LunarSphereSettings.showTotalAH)  then
			LunarSphereSettings.showTotalAH = true;
		end

		local clickType, repairedMenu;
		repairedMenu = 0;
		for index = 1, 10 do 
			if (LunarSphereSettings.buttonData[index].isMenu) then
				for clickType = 1, 3 do 
					if (LunarSphereSettings.buttonData[index]["texture" .. clickType]) then
						if (not LunarSphereSettings.buttonData[index]["buttonType" .. clickType]) then
							LunarSphereSettings.buttonData[index]["buttonType" .. clickType] = 2;
							repairedMenu = repairedMenu + 1;
						end
					end
				end
			end
		end
		if (repairedMenu > 0) then
			Lunar.API:Print(LUNARSPHERE_CHAT .. repairedMenu .. " broken menu button(s) found. Button database repaired =)");
		end
	end

	-- If our version is older than 0.403, add the new pet experience gauge colors
	if (LunarSphereSettings.versionID < 0.403) then
		LunarSphereSettings.versionID = 0.403;
		LunarSphereSettings.gaugeColor["petxp"] = {0.6, 0.0, 0.6, false, 0.6, 0.0, 0.6};
	end

	-- If our version is older than 0.406, add our new skin tracking data.
	if (LunarSphereSettings.versionID < 0.406) then
		LunarSphereSettings.versionID = 0.406;
		LunarSphereSettings.sphereSkin = 1;
		if LunarSphereSettings.sphereImageType then
			if (LunarSphereSettings.sphereImageType == 0) then
				LunarSphereSettings.sphereSkin = 1;
			else
				LunarSphereSettings.sphereSkin = Lunar.includedSpheres + 1;
			end
		else
			LunarSphereSettings.sphereSkin = 1;
		end
		LunarSphereSettings.sphereImageType = nil;
		LunarSphereSettings.currentSkinEdit = 0;
		LunarSphereSettings.buttonEdit = true
	end

	-- If our version is older than 0.407, add our new outer gauge enabler.
	if (LunarSphereSettings.versionID < 0.407) then
		LunarSphereSettings.versionID = 0.407;
		LunarSphereSettings.showOuter = true;
	end

	-- If our version is older than 0.410, add some new values to our settings and
	-- rename some settings
	if (LunarSphereSettings.versionID < 0.410) then
		LunarSphereSettings.versionID = 0.410;
		LunarSphereSettings.menuButtonDistance = 58;
		LunarSphereSettings.subMenuButtonDistance = 4;
		LunarSphereSettings.sphereMoveable = (not LunarSphereSettings.sphereLockdown);
		LunarSphereSettings.sphereLockdown = nil;
	end
--373.5 (original)
--387.5 (new database with original data too) 
--371.5 (new database)
	-- If our version is older than 0.500, convert our button database now
	if (LunarSphereSettings.versionID < 0.5) then
		LunarSphereSettings.versionID = 0.5
		local clickType
		if (LunarSphereSettings.buttonData[1]) then
			for index = 1, 130 do 
				if not (LunarSphereSettings.buttonData[index].empty) then
					for clickType = 1, 3 do 
						Lunar.Button:SetButtonData(index, 0, clickType, 
							LunarSphereSettings.buttonData[index]["buttonType" .. clickType],
							LunarSphereSettings.buttonData[index]["actionType" .. clickType],
							LunarSphereSettings.buttonData[index]["actionName" .. clickType],
							LunarSphereSettings.buttonData[index]["texture" .. clickType]);

						LunarSphereSettings.buttonData[index]["buttonType" .. clickType] = nil;
						LunarSphereSettings.buttonData[index]["actionType" .. clickType] = nil;
						LunarSphereSettings.buttonData[index]["actionName" .. clickType] = nil;
						LunarSphereSettings.buttonData[index]["texture" .. clickType] = nil;
					end
				end
			end
		end
	end

	if (LunarSphereSettings.versionID < 0.502) then
		LunarSphereSettings.versionID = 0.502
		local clickType, clickTypeMenu, buttonType, stance;
		if (LunarSphereSettings.buttonData[1]) then
			for index = 1, 130 do
				if not (LunarSphereSettings.buttonData[index].empty) then

					-- First, make sure all buttons have actionData and actionTexture
					-- if there is a button type;
					if (LunarSphereSettings.buttonData[index].buttonTypeData) then
						if (not LunarSphereSettings.buttonData[index].actionData) then
							LunarSphereSettings.buttonData[index].actionData = "";
						end
						if (not LunarSphereSettings.buttonData[index].actionTexture) then
							LunarSphereSettings.buttonData[index].actionTexture = "";
						end
					end

					if (LunarSphereSettings.buttonData[index].actionData) then
						while (string.find(LunarSphereSettings.buttonData[index].actionData, "||||")) do 
							LunarSphereSettings.buttonData[index].actionData = string.gsub(LunarSphereSettings.buttonData[index].actionData, "||||", "|| ||");
						end
					end
					if (LunarSphereSettings.buttonData[index].actionTexture) then
						while (string.find(LunarSphereSettings.buttonData[index].actionTexture, "||||")) do 
							LunarSphereSettings.buttonData[index].actionTexture = string.gsub(LunarSphereSettings.buttonData[index].actionTexture, "||||", "|| ||");
						end
					end
				end
			end
		end
	end

	if (LunarSphereSettings.versionID < 0.504) then
		LunarSphereSettings.versionID = 0.504
		local clickType, clickTypeMenu, buttonType, stance;
		if (LunarSphereSettings.buttonData[1]) then
			for index = 1, 130 do

				-- Due to an issue with a 5003, some buttons have longer buttonTypeData than required.
				-- So, chop it a little bit, and then rebuild it to the size it needs to be.
				if (LunarSphereSettings.buttonData[index].buttonTypeData) then
					if (string.len(LunarSphereSettings.buttonData[index].buttonTypeData) > (9*12)) then
						LunarSphereSettings.buttonData[index].buttonTypeData = string.sub(LunarSphereSettings.buttonData[index].buttonTypeData, 1, 9*12);
						LunarSphereSettings.buttonData[index].buttonTypeData = LunarSphereSettings.buttonData[index].buttonTypeData .. "000000000";
					end
					if (string.len(LunarSphereSettings.buttonData[index].buttonTypeData) < (9*13)) then
						LunarSphereSettings.buttonData[index].buttonTypeData = LunarSphereSettings.buttonData[index].buttonTypeData .. string.rep("0", 9*13 - string.len(LunarSphereSettings.buttonData[index].buttonTypeData));
					end
				end
			end
		end
	end

	if (LunarSphereSettings.versionID < 0.505) then
		LunarSphereSettings.versionID = 0.505
		local clickType, clickTypeMenu, buttonType, stance;
		if (LunarSphereSettings.buttonData[1]) then
			for index = 1, 130 do
				if not (LunarSphereSettings.buttonData[index].empty) then
					-- icon, count, cooldown
					LunarSphereSettings.buttonData[index].buttonSettings = string.rep("111", 13);
				end
			end
		end
	end

	if (LunarSphereSettings.versionID < 0.506) then
		LunarSphereSettings.versionID = 0.506
		LunarSphereSettings.buttonSpacing = 100;
		LunarSphereSettings.buttonOffset = 0;
		LunarSphereSettings.buttonDistance = 0;
		if (GetLocale() == "enUS") then
			if (not LunarSphereGlobal.searchData) then
				LunarSphereGlobal.searchData = {};
			end

			LunarSphereGlobal.searchData.energyDrink = "Restore Energy";
			LunarSphereGlobal.searchData.drink = "Drink";
			LunarSphereGlobal.searchData.bandage = "First Aid";
			LunarSphereGlobal.searchData.manaStone = "Replenish Mana";
			LunarSphereGlobal.searchData.potionHealing = "Healing Potion";
			LunarSphereGlobal.searchData.food = "Food";
			LunarSphereGlobal.searchData.potionMana = "Restore Mana";
		end
	end

	if (LunarSphereSettings.versionID < 0.510) then
		LunarSphereSettings.versionID = 0.510
		LunarSphereSettings.keepNonEquip = (LunarSphereSettings.keepNonEquip == 1)
		LunarSphereSettings.keepWeapons = (LunarSphereSettings.keepWeapons == 1)
		LunarSphereSettings.keepArmor = (LunarSphereSettings.keepArmor == 1)
		Lunar.Button:ResetButtonData(0);
		for index = 0, 130 do 
			if (LunarSphereSettings.buttonData[index]) then
				if (LunarSphereSettings.buttonData[index].buttonSettings) then
					newIndex = "";
					for tempIndex = 1, 13 do 
						newIndex = newIndex .. string.sub(LunarSphereSettings.buttonData[index].buttonSettings, (tempIndex - 1) * 3 + 1, tempIndex * 3) .. "0000";
					end
					LunarSphereSettings.buttonData[index].buttonSettings = newIndex;
				end
			end
		end				
	end

	if (LunarSphereSettings.versionID < 0.512) then
		LunarSphereSettings.versionID = 0.512
		LunarSphereSettings.keepNonEquip = (LunarSphereSettings.keepNonEquip == 1) or (LunarSphereSettings.keepNonEquip == true);
		LunarSphereSettings.keepWeapons = (LunarSphereSettings.keepWeapons == 1) or (LunarSphereSettings.keepWeapons == true);
		LunarSphereSettings.keepArmor = (LunarSphereSettings.keepArmor == 1) or (LunarSphereSettings.keepArmor == true);
	end

	if (LunarSphereSettings.versionID < 0.513) then
		LunarSphereSettings.versionID = 0.513
		if (select(2, UnitClass("player")) == "WARRIOR") then
			for index = 0, 130 do 
				if (LunarSphereSettings.buttonData[index]) then
					buttonType, actionType, actionName, buttonTexture = Lunar.Button:GetButtonData(index, 0, 1)
					Lunar.Button:SetButtonData(index, 1, 1, buttonType, actionType, actionName, buttonTexture);
				end
			end				
		end		
	end

	if (LunarSphereSettings.versionID < 0.515) then
		LunarSphereSettings.versionID = 0.515
		Lunar.API:Print(LUNARSPHERE_CHAT .. "Due to some issues with some armor and weapons in previous LunarSphere versions, it is adviced that if you have weapons or armor assigned to any LunarSphere button that you re-assign that item in order to update its item link data. I wanted to do an automatic database conversion for everyone, but it didn't turn out well =( -Moongaze");
	end

	if (LunarSphereSettings.versionID < 0.518) then
		LunarSphereSettings.versionID = 0.518
		Lunar.API:Print(LUNARSPHERE_CHAT .. "With version of LunarSphere has new code for handling item assignments. If you have a button that is not using an item properly, try re-assigning the item in this new version. Thanks! -Moongaze");
	end

	if (LunarSphereSettings.versionID < 0.519) then
		LunarSphereSettings.versionID = 0.519
		LunarSphereGlobal.artDatabase = {};
	end

	if (LunarSphereSettings.versionID < 0.520) then
		LunarSphereSettings.versionID = 0.520;
		local clickType, stance, buttonID;
		local buttonType, cursorType, objectName, objectTexture
		for buttonID = 0, 130 do 
			if (LunarSphereSettings.buttonData[buttonID]) then
				for clickType = 1, 3 do 
					for stance = 0, 12 do 
						buttonType, cursorType, objectName, objectTexture = Lunar.Button:GetButtonData(buttonID, stance, clickType);
						if (cursorType == "item") and (string.find(objectName, "%a") == nil) and (string.len(objectName) > 0) then
							objectName = "item:" .. objectName;
							Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, objectName, objectTexture);
						end
					end
				end
			end
		end
	end

	if (LunarSphereSettings.versionID < 0.523) then
		LunarSphereSettings.versionID = 0.523;
		local clickType, stance, buttonID;
		local buttonType, cursorType, objectName, objectTexture, newName;
		for buttonID = 0, 130 do 
			if (LunarSphereSettings.buttonData[buttonID]) then
				for clickType = 1, 3 do 
					for stance = 0, 12 do 
						buttonType, cursorType, objectName, objectTexture = Lunar.Button:GetButtonData(buttonID, stance, clickType);
						if (buttonType) then
							if (buttonType >= 112) and (buttonType < 130) then
								newName = GetItemInfo(objectName);
								if (newName) then
									Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, newName, objectTexture);
								end
							end
						end
					end
				end
			end
		end
		if (not LunarSphereGlobal.artDatabase) then
			LunarSphereGlobal.artDatabase = {};
		end
		LunarSphereSettings.debugPortraitFix = true;
		LunarSphereSettings.debugCooldownFix1 = nil;
		LunarSphereSettings.debugCooldownFix2 = nil;
		LunarSphereSettings.stackTradeTotal = 1;
	end

	if (LunarSphereSettings.versionID < 0.600) then
		LunarSphereSettings.versionID = 0.600;
		LunarSphereSettings.vividMana = {0.0, 0.0, 1.0};
		LunarSphereSettings.vividManaRange = {0.6, 0.2, 1.0};
		LunarSphereSettings.vividRange = {1.0, 0.0, 0.0};
	end

	if (LunarSphereSettings.versionID < 0.603) then
		LunarSphereSettings.versionID = 0.603;

		if (LunarSphereGlobal.speechLibrary) then
			for index = 1, table.getn(LunarSphereGlobal.speechLibrary) do 
				LunarSphereGlobal.speechLibrary[index].id = index;
			end
			LunarSphereGlobal.speechLibrary[1].active = "1111111111";
			LunarSphereGlobal.speechLibrary[2].active = "1111111111";
			LunarSphereGlobal.speechLibrary[3].active = "1111111111111111111111111";
			LunarSphereGlobal.scriptData = {active = "111", lastID = table.getn(LunarSphereGlobal.speechLibrary)};
			if (LunarSpeechLibrary) then
				if (table.getn(LunarSphereGlobal.speechLibrary) == table.getn(LunarSpeechLibrary)) then
					Lunar.API:Print(LUNARSPHERE_CHAT .. "Speech Library - Your database was converted to a new format. Your settings were kept intact. ^_^ -Moongaze");
					for index = 1, table.getn(LunarSpeechLibrary) do 
						LunarSpeechLibrary[index].id = index;
					end
				else
					Lunar.API:Print(LUNARSPHERE_CHAT .. "Speech Library - The database was rebuilt. All custom scripts are intact, however, the script settings (spell assignment, odds, chat channels) had to be reset. Sorry =( -Moongaze");
					LunarSpeechLibrary = nil;
				end
			end
		end
	end

	if (LunarSphereSettings.versionID < 0.608) then
		LunarSphereSettings.versionID = 0.608
		LunarSphereSettings.debugMacroFix = nil;
	end

	if (LunarSphereSettings.versionID < 0.609) then
		LunarSphereSettings.versionID = 0.609
		if (LunarSphereGlobal) then
			LunarSphereGlobal.searchData = nil;
		end
	end

	if (LunarSphereSettings.versionID < 0.610) then
		LunarSphereSettings.versionID = 0.610
		LunarSphereSettings.skipSpellMounts = nil;
	end

	if (LunarSphereSettings.versionID < 0.611) then
		LunarSphereSettings.skipSpellMounts = nil
		LunarSphereSettings.versionID = 0.611
		table.insert(playerLoginCheck, 0.611);
	end

	if (LunarSphereSettings.versionID < 0.613) then
		LunarSphereSettings.versionID = 0.613

		-- If the user has a speech library set up, time to convert it to the new database.
		-- Since the database used to be global, we're now making it local for the first
		-- time it is ran on a character.
		
		if LunarSpeechLibrary then
			if not LunarSpeechLibrary.script then
				LunarSpeechLibrary.script = {};
				for index = 1, table.getn(LunarSpeechLibrary) do 
					LunarSpeechLibrary.script[index] = LunarSpeechLibrary[index];
					LunarSpeechLibrary[index] = nil;
				end
			end
			if (LunarSphereGlobal.speechLibrary) then
				for index = 1, table.getn(LunarSphereGlobal.speechLibrary) do 
					LunarSpeechLibrary.script[index].speeches = {};
					if (LunarSphereGlobal.speechLibrary[index].default) then
						
						LunarSpeechLibrary.script[index].default = LunarSphereGlobal.speechLibrary[index].default;

						-- Load all default speeches, and the overwrite them if there are edited versions of
						-- it in the database
						
						local scriptName, _ = string.match(LunarSphereGlobal.speechLibrary[index].default, "LIB_NAME_(.*)-(%d+)");
						local speechName, speechIndex, defaultSpeech
						if (scriptName) then
							speechIndex = 1;
							speechName = "SPEECH_" .. scriptName;
							defaultSpeech = Lunar.Locale[speechName .. speechIndex];

							while (defaultSpeech) do 
								LunarSpeechLibrary.script[index].speeches[speechIndex] = defaultSpeech;
								speechIndex = speechIndex + 1;
								defaultSpeech = Lunar.Locale[speechName .. speechIndex];
							end
						end

						-- Overwrite time
						
						local key, value;
						for key, value in pairs(LunarSphereGlobal.speechLibrary[index]) do
							if type(key) == "number" then
								LunarSpeechLibrary.script[index].speeches[key] = LunarSphereGlobal.speechLibrary[index][key];
								LunarSphereGlobal.speechLibrary[index][key] = nil;
							end
						end
					
					else
						local i = 1;	
						while (LunarSphereGlobal.speechLibrary[index][i]) do 
							LunarSpeechLibrary.script[index].speeches[i] = LunarSphereGlobal.speechLibrary[index][i];
							LunarSphereGlobal.speechLibrary[index][i] = nil;
							i = i + 1;
						end
						LunarSpeechLibrary.script[index].speeches[0] = LunarSphereGlobal.speechLibrary[index][0];
					end
					LunarSpeechLibrary.script[index].speeches.speechCount = table.getn(LunarSpeechLibrary.script[index].speeches);
				end
				LunarSphereGlobal.speechLibrary = nil;
			end
		end
	end

	if (LunarSphereSettings.versionID < 0.614) then
		LunarSphereSettings.versionID = 0.614
		-- Fix mangled scripts (give them names)
		if (LunarSpeechLibrary) and (LunarSpeechLibrary.script) then
			local i;
			for i = 1, table.getn(LunarSpeechLibrary.script) do 
				if (LunarSpeechLibrary.script[i].speeches) then
					if not (LunarSpeechLibrary.script[i].speeches[0]) then
						LunarSpeechLibrary.script[i].speeches[0] = tostring(LunarSpeechLibrary.script[i].id);
					end
				end
			end
		end
		if (LunarSphereGlobal) and (LunarSphereGlobal.script) then
			local i;
			for i = 1, table.getn(LunarSphereGlobal.script) do 
				if (LunarSphereGlobal.script[i].speeches) then
					if not (LunarSphereGlobal.script[i].speeches[0]) then
						LunarSphereGlobal.script[i].speeches[0] = tostring(LunarSphereGlobal.script[i].id);
					end
				end
			end
		end
	end

	if (LunarSphereSettings.versionID < 0.615) then
		LunarSphereSettings.versionID = 0.615
		LunarSphereSettings.debugHealthstoneFix = nil;
		-- Fix mangled scripts (again ... because some names are "numbers" and not "strings")
		if (LunarSpeechLibrary) and (LunarSpeechLibrary.script) then
			local i;
			for i = 1, table.getn(LunarSpeechLibrary.script) do 
				if (LunarSpeechLibrary.script[i].speeches) then
					if (LunarSpeechLibrary.script[i].speeches[0]) then
						LunarSpeechLibrary.script[i].speeches[0] = tostring(LunarSpeechLibrary.script[i].speeches[0]);
					end
				end
			end
		end
		if (LunarSphereGlobal) and (LunarSphereGlobal.script) then
			local i;
			for i = 1, table.getn(LunarSphereGlobal.script) do 
				if (LunarSphereGlobal.script[i].speeches) then
					if (LunarSphereGlobal.script[i].speeches[0]) then
						LunarSphereGlobal.script[i].speeches[0] = tostring(LunarSphereGlobal.script[i].speeches[0]);
					end
				end
			end
		end
	end

	if (LunarSphereSettings.versionID < 0.700) then
		LunarSphereSettings.versionID = 0.700;

		-- Convert to the new tooltip options
		LunarSphereSettings.tooltipType = 1;
		if (LunarSphereSettings.hideButtonTooltips == true) then
			LunarSphereSettings.tooltipType = 0;
		else
			if (LunarSphereSettings.basicTooltips == true) then
				LunarSphereSettings.tooltipType = 3;
			end
		end

		LunarSphereSettings.yellowTooltipType = 0;
		LunarSphereSettings.greenTooltipType = 0;
		if (LunarSphereSettings.hideLongGreenTooltips) then
			LunarSphereSettings.greenTooltipType = 1;
		end

		LunarSphereSettings.hideLongGreenTooltips = nil;
		LunarSphereSettings.hideButtonTooltips = nil;
		LunarSphereSettings.basicTooltips = nil;

		LunarSphereSettings.tooltipBackground = {0.05, 0.05, 0.10, 0.75};
		LunarSphereSettings.tooltipBorder = {1,1,1,1};
		LunarSphereSettings.anchorModeLS = 0;
		LunarSphereSettings.anchorMode = 0;
		LunarSphereSettings.anchorCornerLS = 0;
		LunarSphereSettings.anchorCorner = 0;

		LunarSphereSettings.mainButtonCount = 10;

	end

	-- Fix the guild repair text in the repair bill
	if (LunarSphereSettings.versionID < 0.703) then
		LunarSphereSettings.versionID = 0.703;

		if LunarSphereSettings.repairLog then
			local index, repairBill;
			for index = 10, 1, -1 do 
				if (LunarSphereSettings.repairLog[index]) then
					repairBill = LunarSphereSettings.repairLog[index];
					repairBill = string.gsub(repairBill, "%(Guild Funds%)", "|cFF00CC00(G)");
					LunarSphereSettings.repairLog[index] = repairBill;
				end
			end
		end
	end

	if (LunarSphereSettings.versionID < 0.704) then
		LunarSphereSettings.versionID = 0.704;
		LunarSphere_ConvertOldEventTypes();
	end

	if (LunarSphereSettings.versionID < 0.707) then
		LunarSphereSettings.versionID = 0.707;
		LunarSphereSettings.gaugeFill = 2;
		LunarSphereSettings.gaugeBorder = 1;
		LunarSphereSettings.gaugeBorderColor = {0,0,0};
		if (LunarSphereSettings.sphereTextType == "Ammo Count") then
			LunarSphereSettings.sphereTextType = LS_EVENT_AMMO
		end
	end

	if (LunarSphereSettings.versionID < 0.708) then
		LunarSphereSettings.versionID = 0.708;
		local index;
		-- Set all main buttons that are menus to have the new menu type and delay.
		for index = 1, 10 do
			if not (LunarSphereSettings.buttonData[index].empty) and (LunarSphereSettings.buttonData[index].isMenu) then
				LunarSphereSettings.menuType = 1;
				LunarSphereSettings.menuDelay = 3;
				LunarSphereSettings.menuUseDelay = LunarSphereSettings.menuAutoHide;
			end
		end
	end

	if (LunarSphereSettings.versionID < 0.709) then
		LunarSphereSettings.versionID = 0.709;
		-- update all pet buttons to the new format
		local clickType, stance, buttonID;
		local buttonType, cursorType, objectName, objectTexture
		for buttonID = 0, 130 do 
			if (LunarSphereSettings.buttonData[buttonID]) then
				for clickType = 1, 3 do 
					for stance = 0, 12 do 
						buttonType, cursorType, objectName, objectTexture = Lunar.Button:GetButtonData(buttonID, stance, clickType);
						if (buttonType) then
							if (buttonType >= 140) and (buttonType < 150) then
								cursorType = "pet";
								objectName = buttonType - 139;
								Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, objectName, objectTexture);
							end
						end
					end
				end
			end
		end
		LunarSphereSettings.cooldownEffect = 0;
		LunarSphereSettings.cooldownColorText = {1.0, 1.0, 0.2};
		LunarSphereSettings.cooldownColorTint = {0.0, 0.0, 0.0, 0.7};
		LunarSphereSettings.cooldownShowShine = true;
		LunarSphereSettings.cooldownShowText = true;
		LunarSphereGlobal.searchData = {[GetLocale()] = nil};
		
	end

	if (LunarSphereSettings.versionID < 0.711) then
		LunarSphereSettings.versionID = 0.711;
		LunarSphereSettings.innerGaugeAngle = 90;
		LunarSphereSettings.innerGaugeDirection = nil;
		LunarSphereSettings.outerGaugeAngle = 90;
		LunarSphereSettings.outerGaugeDirection = nil;
		LunarSphereSettings.gaugeColor[LS_EVENT_T_HEALTH] = {0.0, 1.0, 0.0, false, 0.0, 1.0, 0.0};
		LunarSphereSettings.gaugeColor[LS_EVENT_T_POWER] = {0.5, 0.0, 0.7, false, 0.5, 0.0, 0.7};
	end

	if (LunarSphereSettings.versionID < 0.712) then
		LunarSphereSettings.versionID = 0.712
		LunarSphereSettings.menuAutoHide = nil;
		table.insert(playerLoginCheck, 0.712);
	end

	if (LunarSphereSettings.versionID < 0.715) then
		LunarSphereSettings.versionID = 0.715;

		-- re-update all pet buttons to the new format (because I still had old code that
		-- was converting it back to the old stuff.
		local clickType, stance, buttonID;
		local buttonType, cursorType, objectName, objectTexture
		for buttonID = 0, 130 do 
			if (LunarSphereSettings.buttonData[buttonID]) then
				for clickType = 1, 3 do 
					for stance = 0, 12 do 
						buttonType, cursorType, objectName, objectTexture = Lunar.Button:GetButtonData(buttonID, stance, clickType);
						if (buttonType) then
							if (buttonType >= 140) and (buttonType < 150) then
								cursorType = "pet";
								objectName = buttonType - 139;
								Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, objectName, objectTexture);
							end
						end
					end
				end
			end
		end
		
	end

	if (LunarSphereSettings.versionID < 0.807) then
		LunarSphereSettings.versionID = 0.807;
		LunarSphereSettings.gaugeColor[LS_EVENT_RUNIC] = {0.0, 0.8, 1.0, false, 0.0, 0.8, 1.0};
	end

	if (LunarSphereSettings.versionID < 0.808) then
		LunarSphereSettings.versionID = 0.808;
		if (LunarSphereSettings.sphereSkin >= (Lunar.includedSpheres + LUNAR_EXTRA_SPHERE_ICON_COUNT - 2)) then
			LunarSphereSettings.sphereSkin = LunarSphereSettings.sphereSkin + 1;
		end
	end

	if (LunarSphereSettings.versionID < 0.809) then
		LunarSphereSettings.versionID = 0.809;
		LunarSphereSettings.sphereTextColor = {1, 1, 1};
		if (LunarSphereSettings.sphereTextType == 1) or (LunarSphereSettings.sphereTextType == 2)  then
			LunarSphereSettings.sphereTextType = 0;
			Lunar.API:Print(LUNARSPHERE_CHAT .. "It appears that you were using \"Sphere Button Count\" or \"Sphere Button Cooldown\" as your sphere text event.");
			Lunar.API:Print(LUNARSPHERE_CHAT .. "These events have been removed and replaced with new custom events that lets you set the count or cooldown to be displayed.");
			Lunar.API:Print(LUNARSPHERE_CHAT .. "Please cheack the LunarSphere Settings window, in the Sphere tab, for these new options. Thanks! -Moongaze");
		end
	end

	if (LunarSphereSettings.versionID < 1.01) then
		LunarSphereSettings.versionID = 1.01;
		LunarSphereSettings.alwaysShowPet = true;
		if (LunarSphereSettings.sphereScale) then
			local scale = math.floor((LunarSphereSettings.sphereScale + 0.01) * 10)
			buttonDistance = LunarSphereSettings.buttonDistance;
			if (scale > 10) then
				scale = scale - 10;
				buttonDistance = math.min((buttonDistance + 4 * scale), 200);
				LunarSphereSettings.buttonDistance = buttonDistance;
			end

			Lunar.showStartupMessage = Lunar.showStartupMessage or LunarSphereSettings.showStartupMessage;
			Lunar.startupMessage = Lunar.startupMessage or LunarSphereSettings.startupMessage;
			LunarSphereSettings.showStartupMessage = true;
			LunarSphereSettings.startupMessage =
				"Part of your LunarSphere database was edited due to a new feature with this version. " ..
				"This version makes it so that scaling the sphere no longer scales the buttons as well. " ..
				"You may need to re-scale your buttons or change your \"Button Distance\" setting in the Sphere tab.\n\n-Moongaze";
		end
	end

	if (LunarSphereSettings.versionID < 1.02) then
		LunarSphereSettings.versionID = 1.02;
		if (LunarSphereSettings.buttonDistance) then
			LunarSphereSettings.buttonDistance = math.min((LunarSphereSettings.buttonDistance + 8), 200);
		else
			LunarSphereSettings.buttonDistance = 8;
		end

		Lunar.showStartupMessage = Lunar.showStartupMessage or LunarSphereSettings.showStartupMessage;
		Lunar.startupMessage = Lunar.startupMessage or LunarSphereSettings.startupMessage;
		LunarSphereSettings.showStartupMessage = true;
		LunarSphereSettings.startupMessage =
				"Part of your LunarSphere database was edited due to a feature upgrade with this version. " ..
				"This version makes the \"Button Distance\" setting in the Sphere tab much more accurate and  " ..
				"as such, having a value less than 6 might make your buttons appear too close to the sphere, depending " ..
				"on your button scale and skin. You may need to re-adjust this.\n\n" ..
				"Also, timed auto-closing of LunarSphere menu buttons has been broken by the 3.0.8 patch. Blizzard " ..
				"stated that this might be addressed with new code in the next patch, but no ETA on that.\n\n-Moongaze";
	end

	if (LunarSphereSettings.versionID < 1.06) then
		LunarSphereSettings.versionID = 1.06;
		Lunar.showStartupMessage = false;
		Lunar.startupMessage = "";

		-- In the future, I will need to use a boolean to track if I have modifed the start-up message and if I did,
		-- to NOT CHANGE THE SAVED VERSION AGAIN with the LS message!

--		LunarSphereSettings.showStartupMessage = true;
--		LunarSphereSettings.startupMessage = 
--				"\n\n-Moongaze";
		table.insert(playerLoginCheck, 1.06);
	end

	if (LunarSphereSettings.versionID < 1.08) then
		LunarSphereSettings.versionID = 1.08;
		Lunar.showStartupMessage = false;
		Lunar.startupMessage = "";

		-- In the future, I will need to use a boolean to track if I have modifed the start-up message and if I did,
		-- to NOT CHANGE THE SAVED VERSION AGAIN with the LS message!

--		LunarSphereSettings.showStartupMessage = true;
--		LunarSphereSettings.startupMessage = 
--				"Part of the LunarSphere speech database was modified to correct some issues with Warlock" .. 
--				"pet summoning not triggering a speech.\n\n-Moongaze";
		table.insert(playerLoginCheck, 1.08);
	end

	if (LunarSphereSettings.versionID < 1.09) then
		LunarSphereSettings.versionID = 1.09;

		local clickType, stance, buttonID;
		local buttonType, cursorType, objectName, objectTexture
		for buttonID = 0, 130 do 
			if (LunarSphereSettings.buttonData[buttonID]) then
				for clickType = 1, 3 do 
					for stance = 0, 12 do 
						buttonType, cursorType, objectName, objectTexture = Lunar.Button:GetButtonData(buttonID, stance, clickType);
						if (buttonType) then
							-- Update all "Open Spellbook" menu bar tab button types
							if (buttonType == 101) then
								cursorType = "macrotext"
								objectName = "/click SpellbookMicroButton";
								Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, objectName, objectTexture);
							end
						end
					end
				end
			end
		end
	end

	if (LunarSphereSettings.versionID < 1.10) then
		LunarSphereSettings.versionID = 1.10;
		LunarSphereSettings.fooled = nil;
		LunarSphereSettings.gaugeColor[LS_EVENT_EXTRA_POWER] = {0.85, 0.0, 0.85, false, 0.85, 0.0, 0.85};
		LunarSphereSettings.gaugeColor[LS_EVENT_FOCUS] = {0.9, 0.45, 0.10, false, 0.9, 0.45, 0.10};

		Lunar.showStartupMessage = Lunar.showStartupMessage or LunarSphereSettings.showStartupMessage;
		Lunar.startupMessage = Lunar.startupMessage or LunarSphereSettings.startupMessage;
		LunarSphereSettings.showStartupMessage = true;
		LunarSphereSettings.startupMessage =
				"Welcome to the WOW 4.0 version of LunarSphere! Due to many spell updates and changes, some " ..
				"spells may be broken and need to be re-assigned to your buttons and saved to your templates. A " ..
				"database conversion was performed to try and keep as much data as possible and carry over spells. " ..
				"However, some spells might have been missed. Hunter and Warlock pets will probably need to be reassigned.\n\n" ..
				"Some spells in the Speech database may need to be reconfigured (such as pets) to work properly. " ..
				"The built-in templates for classes are out-of-date and will be rebuilt when Cataclysm launches.\n\n" ..
				"-Moongaze";
	end
	
	if (LunarSphereSettings.versionID < 1.3) then
		LunarSphereSettings.versionID = 1.3;
		LunarSphereSettings.fooled = nil;
		LunarSphereSettings.gaugeColor[LS_EVENT_EXTRA_POWER] = {0.85, 0.0, 0.85, false, 0.85, 0.0, 0.85};
		LunarSphereSettings.gaugeColor[LS_EVENT_FOCUS] = {0.9, 0.45, 0.10, false, 0.9, 0.45, 0.10};

		Lunar.showStartupMessage = Lunar.showStartupMessage or LunarSphereSettings.showStartupMessage;
		Lunar.startupMessage = Lunar.startupMessage or LunarSphereSettings.startupMessage;
		LunarSphereSettings.showStartupMessage = true;
		LunarSphereSettings.startupMessage =
				"Welcome to Legion";
	end
end

function LunarSphere_BackwardsCompatibility_PlayerLogin()

	if (table.getn(playerLoginCheck) > 0) then
		if (playerLoginCheck[1] == 0.611) then
			table.remove(playerLoginCheck, 1);
			-- fix trade skills
			local generalTabSkills = select(4, GetSpellTabInfo(1));
			local newName;

			for buttonID = 0, 130 do 
				if (LunarSphereSettings.buttonData[buttonID]) then
					for clickType = 1, 3 do 
						for stance = 0, 12 do 
							buttonType, cursorType, objectName, objectTexture = Lunar.Button:GetButtonData(buttonID, stance, clickType);
							if (buttonType) and (buttonType == 1)then
								spellID = Lunar.API:GetSpellID(objectName)
								if (spellID) then 
									if (spellID <= generalTabSkills) then
										-- Just grab the name without rank and set it again
										objectName = GetSpellBookItemName(objectName);
										Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, objectName, objectTexture);
									end
								end
							end
						end
					end
				end
			end
		end

		if (playerLoginCheck[1] == 0.712) then
			table.remove(playerLoginCheck, 1);
			local point, relativeTo, relativePoint, xOfs, yOfs = _G["LSmain"]:GetPoint();
			LunarSphereSettings.relativePoint = relativePoint;
			LunarSphereSettings.xOfs = xOfs;
			LunarSphereSettings.yOfs = yOfs;
		end

		if (playerLoginCheck[1] == 1.06) then
			table.remove(playerLoginCheck, 1);
			-- fix pvp button
			local newName;
			local button;
			for buttonID = 0, 130 do 
				if (LunarSphereSettings.buttonData[buttonID]) then
					for clickType = 1, 3 do 
						for stance = 0, 12 do 
							buttonType, cursorType, objectName, objectTexture = Lunar.Button:GetButtonData(buttonID, stance, clickType);
							if (buttonType) and (buttonType == 109)then
								if (UnitFactionGroup("player") == "Alliance") then
									objectTexture = LUNAR_ART_PATH .. "menuPVP2.blp";
								end
								Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, objectName, objectTexture);
							end
						end
					end
				end
			end
		end

		if (playerLoginCheck[1] == 1.08) then
			table.remove(playerLoginCheck, 1);
			-- fix the summon spells in the speech database
			local scriptIndex, spellIndex;
			local summonText = select(2, GetSpellInfo(23214));
			local tempSummon = "%(" .. summonText .. "%)";
			if (LunarSpeechLibrary and LunarSpeechLibrary.script) then
				for scriptIndex = 1, table.getn(LunarSpeechLibrary.script) do 
					if LunarSpeechLibrary.script[scriptIndex].spells then
						for spellIndex = 1, table.getn(LunarSpeechLibrary.script[scriptIndex].spells) do
							LunarSpeechLibrary.script[scriptIndex].spells[spellIndex] = string.gsub(LunarSpeechLibrary.script[scriptIndex].spells[spellIndex], tempSummon, "");
						end
					end
				end
			end
		end
	end

	playerLoginCheck = nil;
end

function LunarSphere_SlashHandler(msg)

	local params = msg;
	local command = params;

	-- Find the position of the parameters
	local index = string.find(command, " ");

	-- If there were parameters found, separate them from the command
	if ( index ) then
		command = string.sub(command, 1, index-1);
		params = string.sub(params, index+1);

	-- Otherwise, we just have a command
	else
		params = "";
	end

	command = string.lower(command);

	local obj = _G["LSsphere"];
	local alpha = 1;
	if (command == "hidesphere") then
		Lunar.Sphere:ToggleSphere(0);
		_G["LSSettingssphereAlpha"]:SetChecked(true);
	elseif (command == "showsphere") then
		Lunar.Sphere:ToggleSphere(1);
		_G["LSSettingssphereAlpha"]:SetChecked(false);
	elseif (command == "hide") then
		Lunar.Sphere:ToggleAll(0);
	elseif (command == "show") then
		Lunar.Sphere:ToggleAll(1);
	elseif ((command == "settings") or (command == "options"))  then
		Lunar.Settings:ToggleSettingsFrame();
	else
		Lunar.API:Print(LUNARSPHERE_CHAT .. Lunar.Locale["_HELP1"]);
		Lunar.API:Print(Lunar.Locale["_HELP2"]);
		Lunar.API:Print(Lunar.Locale["_HELP3"]);
		Lunar.API:Print(Lunar.Locale["_HELP4"]);
		Lunar.API:Print(Lunar.Locale["_HELP5"]);
		Lunar.API:Print(Lunar.Locale["_HELP6"]);
		Lunar.API:Print(Lunar.Locale["_HELP7"]);
		Lunar.API:Print(Lunar.Locale["_HELP8"]);
	end
end

function LunarSphere_ConvertOldEventTypes()
	-- Update the event types
	local loop, value;
	for loop = 1, 3 do 
		if (loop == 1) then
			value = LunarSphereSettings.innerGaugeType;
		elseif (loop == 2) then
			value = LunarSphereSettings.outerGaugeType;
		else
			value = LunarSphereSettings.sphereTextType;
		end
		if (value == "none") then
			value = LS_EVENT_NONE;
		elseif (value == "health") then
			value = LS_EVENT_HEALTH;
		elseif (value == "mana") then
			value = LS_EVENT_POWER;
		elseif (value == "combo") then
			value = LS_EVENT_COMBO;
		elseif (value == "petxp") then
			value = LS_EVENT_P_EXP;
		elseif (value == "exp") then
			value = LS_EVENT_EXP;
		elseif (value == "rep") then
			value = LS_EVENT_REP;
		elseif (value == "ammo") then
			value = LS_EVENT_AMMO;
		elseif (value == "five") then
			value = LS_EVENT_FIVE;
		elseif (value == "buttonCount") then
			value = LS_EVENT_SPHERE_COUNT;
		elseif (value == "buttonCooldown") then
			value = LS_EVENT_SPHERE_COOLDOWN;
		end				
		if (loop == 1) then
			LunarSphereSettings.innerGaugeType = value;
		elseif (loop == 2) then
			LunarSphereSettings.outerGaugeType = value;
		else
			LunarSphereSettings.sphereTextType = value;
		end
	end
	local db = LunarSphereSettings.gaugeColor;

	if (db["mana"]) then
		db[LS_EVENT_MANA]	= db["mana"];
		db[LS_EVENT_FIVE]   = db["five"];
		db[LS_EVENT_HEALTH] = db["health"];
		db[LS_EVENT_EXP]    = db["exp"];
		db[LS_EVENT_REP]    = db["rep"];
		db[LS_EVENT_RAGE]   = db["rage"];
		db[LS_EVENT_COMBO]  = db["combo"];
		db[LS_EVENT_ENERGY] = db["energy"];
		db[LS_EVENT_P_EXP]  = db["petxp"];
		db["mana"] = nil;
		db["five"] = nil;
		db["health"] = nil;
		db["exp"] = nil;
		db["rep"] = nil;
		db["rage"] = nil;
		db["combo"] = nil;
		db["energy"] = nil;
		db["petxp"] = nil;
	end
end

local oldGetMacroInfo, oldGetActionTexture;

function LunarSphere_MacroFix()
	if (true) then
		return;	
	end

	oldGetMacroInfo = GetMacroInfo;
	GetMacroInfo =
	function(macroName)
		local macroName, macroTexture, macroBody, arg4 = oldGetMacroInfo(macroName);
		if (not macroTexture) or (macroTexture == "Interface\\Icons\\INV_Misc_QuestionMark") then
			local objectName = GetActionFromMacroText(macroBody);
			if (objectName) then
				_,_,_,_,_,_,_,_,_,macroTexture = GetItemInfo(objectName);
			end
		end
		return macroName, macroTexture, macroBody, arg4;
	end;

	oldGetActionTexture = GetActionTexture;
	GetActionTexture =
	function(action)
		local actionTexture = oldGetActionTexture(action);
		if (actionTexture == "Interface\\Icons\\INV_Misc_QuestionMark") then
			if (GetActionInfo(action) == "macro") then
				_,actionTexture = GetMacroInfo(GetActionText(action));
			end
		end
		return actionTexture;
	end;
end

function LunarSphere_cow()

	if (_G["cowFrame"]) then
		_G["cowFrame"]:Hide();
	end

	if (LunarSphereSettings.gievcowlevel) then
		LunarSphereSettings.gievcowlevel = nil;
		if not (_G["cowFrame"]) then

			local x, y, cowFrame, subFrame, width, height;
			width = math.ceil(GetScreenWidth() / 16);
			height = math.ceil(GetScreenHeight() / 10);

			cowFrame = Lunar.API:CreateFrame("Frame", "cowFrame", UIParent, 100, 100, nil, nil, 0);

			cowFrame:SetPoint("Topleft");
			for y = 1, 10 do 
				for x = 1, 16 do 
					subFrame = Lunar.API:CreateFrame("Button", "cowSubFrame" .. x + ((y - 1) * 16), cowFrame, width, height, "Interface\\DialogFrame\\UI-DialogBox-Background", nil,0);
					subFrame:GetNormalTexture():SetColorTexture(1,1,1);
					subFrame:GetNormalTexture():SetVertexColor(0, 0, x/16);
	--				subFrame:GetNormalTexture():SetVertexColor(x/16, 0, 0);
					subFrame:SetAlpha(0.4);
					subFrame:ClearAllPoints();
					subFrame.glowX = x + y;
					subFrame.glowY = y;
					subFrame:SetPoint("Topleft", cowFrame, "Topleft", (x-1) * width, -((y-1) * height));
					subFrame:Show();
				end		
			end
			cowFrame:SetScript("OnUpdate", function(self, arg1)
				if (not self.timer) then
					self.timer = 0;
				end
				self.timer = self.timer + arg1;
				if (self.timer < 0.05) then
					return;
				end
				self.timer = 0;
				local buttonID, subFrame, valX, valY;
				for buttonID = 1, 160 do 
					subFrame = _G["cowSubFrame" .. buttonID];
					subFrame.glowX = subFrame.glowX + 1;
					subFrame.glowY = subFrame.glowY + 1;
					if (subFrame.glowX > 32) then
						subFrame.glowX = 0;
					end
					if (subFrame.glowY > 32) then
						subFrame.glowY = 0;
					end
					valX = subFrame.glowX;
					if (valX > 16) then
						valX = 32 - valX; 
					end
					valY = subFrame.glowY;
					if (valY > 16) then
						valY = 32 - valY; 
					end
					subFrame:GetNormalTexture():SetVertexColor(0, 0, valX / 16);
				end
			end);
		end
		cowFrame:Show();
	end	
end

-- /***********************************************
--   DrDamage Support Function
--
--   DrDamage will use this function for its LunarSphere support. This allows for me to
--   upkeep the function so that if I make changes to a button's structure, DrDamage
--   will not require an update, only LS.
-- ***********************/
function Lunar.DrDamageFunc(button)
	if LunarSphereSettings.enableDrDamage == true then
		if (button.actionType == "spell" and button.buttonType == 1 and button.spellReagent == nil) then
			local _, spellRank = GetSpellBookItemName(button.actionName);
			local spellName;
			if (string.find(button.actionName, "%(")) then
				spellName = string.match(button.actionName, "(.*)%(");
			else
				spellName = button.actionName;
			end
			return nil, spellName, spellRank;
		end
	end
	return nil;
end

-- /***********************************************
--   Macro Patch 
--
--   Due to the removal of several functions from the chatframe.lua file from
--   WOW 2.1 to WOW 2.2, I had to search around and restore these functions until
--   Blizzard gives us more functions in 2.3 that will do the same thing. These
--   lines of code were taken from the original ChatFrame.lua file in WOW pre 2.2.
--   
--   Due to the fact that I am unsure if other addons have remade this function,
--   or are using their own version of it, I have renamed it with an "LS" in front
--  *********************/

function LSGetActionFromMacroText(text)
	if (text) then
		return LSGetActionFromMacroLines(strsplit('\n', text));
	end
end

GetActionFromMacroText = LSGetActionFromMacroText;

LSActionCommandList = {
	"CAST",
	"CASTRANDOM",
	"CASTSEQUENCE",
	"USE",
	"USERANDOM",
	"EQUIP",
	"EQUIP_TO_SLOT",
};

function LSGetActionFromMacroLine(text)
	if (not text) then
		return;
	end

	local command = strmatch(text, "^(#%s*[Ss][Hh][Oo][Ww]:*)%s[^%s]") or
	                strmatch(text, "^(#%s*[Ss][Hh][Oo][Ww][Tt][Oo][Oo][Ll][Tt][Ii][Pp]:*)%s[^%s]") or
	                strmatch(text, "^(/[^%s]+)");
	if ( not command or command == text ) then
		return;
	end
	local msg = strsub(text, strlen(command) + 2);

	if ( strfind(command, "^#") ) then
		-- This is a hack, but the "USE" code below handles bags and slots
		command = SLASH_USE1;
	end

	command = strupper(command);

	for index, value in ipairs(LSActionCommandList) do
		local i = 1;
		local cmdString = _G["SLASH_"..value..i];
		while ( cmdString ) do
			cmdString = strupper(cmdString);
			if ( cmdString == command ) then
				local action, target = SecureCmdOptionParse(msg);
				if ( not action ) then
					return nil;
				end
				if ( value == "CASTSEQUENCE" ) then
					local index, item, spell = QueryCastSequence(action);
					action = item or spell;
				elseif ( value == "CASTRANDOM" or value == "USERANDOM" ) then
					action = strtrim((strsplit(",", action)));
				elseif ( value == "EQUIP_TO_SLOT" ) then
					local slot, item = strmatch(action, "^(%d+)%s+(.*)");
					action = item;
				end
				return (SecureCmdItemParse(action)), target;
			end
			i = i + 1;
			cmdString = _G["SLASH_"..value..i];
		end
	end
end

function LSGetActionFromMacroLines(...)
	local action, target, i;
	for i=1, select("#",...) do
		action, target = LSGetActionFromMacroLine(select(i,...));
		if ( action ) then
			return action, target;
		end
	end
end 