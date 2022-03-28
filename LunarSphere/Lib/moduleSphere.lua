-- /***********************************************
--  Lunar Sphere Module
--  *********************
--
--  Author	: Moongaze (Twisting Nether)
--  Description	: Sphere handler of Lunar.
--
--  ***********************************************/

-- /***********************************************
--  * Module Setup
--  *********************

-- Create our Lunar object if it's not made
if (not Lunar) then
	Lunar = {};
end

-- Create our Sphere module
Lunar.Sphere = {};

-- Set our current version for the module (used for version checking later on)
Lunar.Sphere.version = 1.52;

-- Set some settings for Lunar
Lunar.combatLockdown = false;		-- Tracks if we're in combat
Lunar.refreshUpdate = 0;		-- Tracks the update timer (we do updates every 0.05 seconds)

-- /***********************************************
--   Globals
--  *********************/

LS_EVENT_NONE = 0;
LS_EVENT_SPHERE_COOLDOWN = 1;
LS_EVENT_SPHERE_COUNT = 2;

LS_EVENT_HEALTH = 10;
LS_EVENT_POWER = 11;
LS_EVENT_COMBO = 12;
LS_EVENT_CAST = 13; -- not in yet
LS_EVENT_MANA = 14;
LS_EVENT_ENERGY = 15
LS_EVENT_RAGE = 16;
LS_EVENT_RUNIC = 17;
LS_EVENT_EXTRA_POWER = 18; -- Eclipse, Soul Shards, Holy Power, etc.
LS_EVENT_FOCUS = 19;

LS_EVENT_T_HEALTH = 20;
LS_EVENT_T_POWER = 21;
LS_EVENT_T_CAST = 22; -- not in yet

LS_EVENT_P_HEALTH = 30; -- not in yet
LS_EVENT_P_POWER = 31; -- not in yet
LS_EVENT_P_EXP = 32;
LS_EVENT_P_HAPPYNESS = 33; -- not in yet

LS_EVENT_EXP = 40;
LS_EVENT_REP = 41;
LS_EVENT_SKILL = 42; -- not in yet
LS_EVENT_AMMO = 43;
LS_EVENT_ITEM = 44; -- not in yet
LS_EVENT_FIVE = 45;
LS_EVENT_POWERTICK = 46; -- not in yet

-- Create our settings table. Will be overwritten if the user has saved variables.
LunarSphereSettings = {
	versionID = Lunar.Sphere.version;
	firstRun = true;
	showInner = true;
	showOuter = true;
	showSphereShine = true;
	showSphereTextShadow = true;
	sphereColor = {1.0, 1.0, 1.0};
	innerGaugeColor = {0.0, 0.3, 1.0};
	sphereTextColor = {1.0, 1.0, 1.0};
	innerGaugeType = LS_EVENT_POWER;
	innerGaugeTypeID = nil;
	innerGaugeAnimate = true;
	innerMarkSize = 10;
	innerMarkDark = false;
	innerGaugeAngle = 90;
	innerGaugeDirection = -1;
	outerGaugeColor = {0.0, 1.0, 0.0};
	outerGaugeType = LS_EVENT_HEALTH;
	outerGaugeTypeID = nil;
	outerGaugeAnimate = true;
	outerMarkSize = 10;
	outerMarkDark = false;
	outerGaugeAngle = 90;
	outerGaugeDirection = -1;
	sphereTextType = LS_EVENT_NONE;
	sphereTextTypeID = nil;
	sphereTextEnd = "%";
	customSphereColor = true;
	alwaysShowPet = true;
	debugTuesday = true;
	sphereScale = 1.0;
	gaugeColor = {
		[LS_EVENT_MANA]   = {0.0, 0.3, 1.0, false, 0.0, 0.3, 1.0};
		[LS_EVENT_FIVE]   = {1.0, 1.0, 1.0, false, 1.0, 1.0, 1.0};
		[LS_EVENT_HEALTH] = {0.0, 1.0, 0.0, false, 0.0, 1.0, 0.0};
		[LS_EVENT_POWER] = {0.5, 0.0, 0.7, false, 0.5, 0.0, 0.7}; --1.3 Croq Add
		[LS_EVENT_EXP]    = {0.7, 0.0, 0.7, false, 0.7, 0.0, 0.7};
		[LS_EVENT_REP]    = {0.0, 0.7, 0.7, false, 0.0, 0.7, 0.7};
		[LS_EVENT_RAGE]   = {1.0, 0.0, 0.0, false, 1.0, 0.0, 0.0};
		[LS_EVENT_COMBO]  = {1.0, 0.0, 0.0, false, 1.0, 0.0, 0.0};
		[LS_EVENT_ENERGY] = {1.0, 1.0, 0.0, false, 1.0, 1.0, 0.0};
		[LS_EVENT_FOCUS] = {0.9, 0.45, 0.10, false, 0.9, 0.45, 0.10};
		[LS_EVENT_EXTRA_POWER] = {0.85, 0.0, 0.85, false, 0.85, 0.0, 0.85};
		[LS_EVENT_RUNIC] = {0.0, 0.8, 1.0, false, 0.0, 0.8, 1.0};
		[LS_EVENT_P_EXP]  = {0.6, 0.0, 0.6, false, 0.6, 0.0, 0.6};
		[LS_EVENT_T_HEALTH] = {0.0, 1.0, 0.0, false, 0.0, 1.0, 0.0};
		[LS_EVENT_T_POWER] = {0.5, 0.0, 0.7, false, 0.5, 0.0, 0.7};
	};
	buttonData = {};
	showAssignedCounts = false;
	buttonSkin = 36;
	sphereMoveable = true;
	buttonEditMode = true;
	submenuCompression = true;
	menuButtonColor = {0.3, 0.6, 1.0};
	buttonColor = {1.0, 1.0, 1.0};
	vividMana = {0.0, 0.0, 1.0};
	vividManaRange = {0.6, 0.2, 1.0};
	vividRange = {1.0, 0.0, 0.0};
	gaugeFill = 4;
	gaugeBorder = 3;
	gaugeBorderColor = {1,1,1};
	showSphereEditGlow = 1;
	reagentList = {};
	timeOffset = 0;
	keepArmor = true;
	keepWeapons = true;
	keepNonEquip = true;
	currentSkinEdit = 0;
	sphereSkin = 1;
	menuButtonDistance = 58;
	subMenuButtonDistance = 4;
	buttonDistance = 6;
	buttonOffset = 0;
	buttonSpacing = 100;
	tooltipType = 1;
	yellowTooltipType = 0;
	greenTooltipType = 0;
	tooltipBackground = {0.05, 0.05, 0.10, 0.75};
	tooltipBorder = {1,1,1,1};
	anchorModeLS = 0;
	anchorMode = 0;
	anchorCornerLS = 0;
	anchorCorner = 0;
	mainButtonCount = 10;
	cooldownEffect = 0;
	cooldownColorText = {1.0, 1.0, 0.2};
	cooldownColorTint = {0.0, 0.0, 0.0, 0.7};
	cooldownShowShine = true;
	cooldownShowText = true;
	relativePoint = "Center";
	xOfs = 0;
	yOfs = 0;
};

LunarSphereGlobal = {};
LunarSphereGlobal.artDatabase = {};

if (GetLocale() == "enUS") then
	if (not LunarSphereGlobal.searchData) then
		LunarSphereGlobal.searchData = {};
	end
	if (not LunarSphereGlobal.searchData["enUS"]) then
		LunarSphereGlobal.searchData["enUS"] = {};
	end
	LunarSphereGlobal.searchData["enUS"].energyDrink = "Restore Energy";
	LunarSphereGlobal.searchData["enUS"].drink = "Drink";
	LunarSphereGlobal.searchData["enUS"].bandage = "First Aid";
	LunarSphereGlobal.searchData["enUS"].manaStone = "Replenish Mana";
	LunarSphereGlobal.searchData["enUS"].potionHealing = "Healing Potion";
	LunarSphereGlobal.searchData["enUS"].food = "Food";
	LunarSphereGlobal.searchData["enUS"].potionMana = "Restore Mana";
end

--[[
		{Lunar.Locale["EVENT_NONE"], "none"},
		{Lunar.Locale["EVENT_HEALTH"], "health"},
		{Lunar.Locale["EVENT_MANA"], "mana"},
		{Lunar.Locale["EVENT_FIVE"], "five"},
		{Lunar.Locale["EVENT_EXP"], "exp"},
		{Lunar.Locale["EVENT_REP"], "rep"},
		{Lunar.Locale["EVENT_COMBO"], "combo"},
		{Lunar.Locale["EVENT_PETXP"], "petxp"},
		{Lunar.Locale["EVENT_AMMO"], "ammo"},
		{Lunar.Locale["EVENT_SPHERE_COOLDOWN"], "buttonCooldown"},
		{Lunar.Locale["EVENT_SPHERE_COUNT"], "buttonCount"},
--]]
-- /***********************************************
--   Locals
--  *********************/

-- Sphere object data, holds data for the art
local sphereData = {};		

-- Table of default gauge colors for gauge watching events
--[[
local gaugeDefaultColor = {
	[LS_EVENT_MANA]   = {0.0, 0.3, 1.0, true};
	[LS_EVENT_FIVE]   = {1.0, 1.0, 1.0, true};
	[LS_EVENT_HEALTH] = {0.0, 1.0, 0.0, true};
	[LS_EVENT_EXP]    = {0.7, 0.0, 0.7, true};
	[LS_EVENT_REP]    = {0.0, 0.7, 0.7, true};
	[LS_EVENT_RAGE]   = {1.0, 0.0, 0.0, true};
	[LS_EVENT_COMBO]  = {1.0, 0.0, 0.0, true};
	[LS_EVENT_ENERGY] = {1.0, 1.0, 0.0, true};
	[LS_EVENT_PETXP]  = {0.6, 0.0, 0.6, true};
};
--]]
-- Special tracking information the sphere relies on
local dataTracking = {
	playerMana = 0;		-- Current mana of player
	powerType = nil;	-- Player's power (mana, energy, rage, etc)
	fiveSec = -1;		-- Five second counter, -1 is not activated
	sphereText = "";	-- Saved text that is current displayed on the text
	gaugeInnerStart = nil;	-- Starting (or current) percentage of gauge during animation
	gaugeOuterStart = nil;  -- Starting (or current) percentage of gauge during animation
	animateInner = nil;	-- States whether or not we're animating the inner gauge
	animateOuter = nil;	-- States whether or not we're animating the outer gauge
	loadedPlayer = false;	-- Tracks if the player had been loaded into the game after login
	isDruid = false;	-- Tracks if the player is a druid (for swapping of powers when shapeshifting)

	-- Table of events to watch, indexed by the tags the sphere recognizes
	eventWatch = {
		[LS_EVENT_MANA] = "UNIT_POWER_UPDATE", --"UNIT_MANA",
		[LS_EVENT_RUNIC] = "UNIT_POWER_UPDATE", --"UNIT_RUNIC_POWER",
		[LS_EVENT_FIVE] = "UNIT_POWER_UPDATE", --"UNIT_MANA",
		[LS_EVENT_HEALTH] = "UNIT_HEALTH",
		[LS_EVENT_EXP] = "PLAYER_XP_UPDATE",
		[LS_EVENT_REP] = "UPDATE_FACTION",
		[LS_EVENT_RAGE] = "UNIT_POWER_UPDATE", --"UNIT_RAGE",
		[LS_EVENT_COMBO] = "UNIT_COMBO_POINTS",
		[LS_EVENT_ENERGY] = "UNIT_POWER_UPDATE", --"UNIT_ENERGY",
		[LS_EVENT_FOCUS] = "UNIT_POWER_UPDATE", --"UNIT_FOCUS",
		[LS_EVENT_EXTRA_POWER] = "UNIT_POWER_UPDATE",
		[LS_EVENT_P_EXP] = "UNIT_PET_EXPERIENCE",
		[LS_EVENT_AMMO] = "UNIT_INVENTORY_CHANGED",
		[LS_EVENT_T_HEALTH] = "UNIT_HEALTH",
--		[LS_EVENT_T_POWER] = "UNIT_POWER", --"UNIT_MANA",
		[LS_EVENT_POWER] = "UNIT_POWER_UPDATE", --Croq Added in 1.30
	};

	-- Table for the names of the different powers
	powerName = {
		[0] = LS_EVENT_MANA, -- 14
		[1] = LS_EVENT_RAGE, -- 16
		[2] = LS_EVENT_FOCUS, -- 19
		[3] = LS_EVENT_ENERGY, -- 15
		[4] = "happiness",
		[5] = LS_EVENT_RUNIC, -- 17
		[6] = LS_EVENT_RUNIC, -- 17
		[7] = LS_EVENT_MANA, --Croq Added in 1.30
		[8] = LS_EVENT_RAGE, --Croq Added in 1.30
		[9] = LS_EVENT_FOCUS, --Croq Added in 1.30
		[10] = LS_EVENT_ENERGY, --Croq Added in 1.30
		[11] = LS_EVENT_ENERGY, --Croq Added in 1.30 -- 1.3 Croq Add Had to add for Mealstrome (shaman)
		[12] = LS_EVENT_ENERGY, --Croq Added in 1.30
		[13] = LS_EVENT_ENERGY, --Croq Added in 1.30
		[14] = LS_EVENT_ENERGY, --Croq Added in 1.30
		[15] = LS_EVENT_ENERGY, --Croq Added in 1.30
		[16] = LS_EVENT_ENERGY, --Croq Added in 1.30
		[17] = LS_EVENT_ENERGY, --Croq Added in 1.30 - for demon hunters
	};

	extraPowerType = {
		["DEATHKNIGHT"] = 0,
		["DRUID"] = 8,
		["HUNTER"] = 0,
		["MAGE"] = 0,
		["PALADIN"] = 9,
		["PRIEST"] = 0,
		["ROGUE"] = -1,
		["SHAMAN"] = 0,
		["WARLOCK"] = 7,	-- Shards
		["WARRIOR"] = 0,
	};
};

-- /***********************************************
--   Functions
--  *********************/

function Lunar.Sphere:Initialize()

	-- Populate our sphereData table with frame references to segments our sphere will
	-- be using throughout the running of the module
--	mainAnchor = Lunar.API:CreateFrame("Button", "LSmainAnchor", UIParent, 64, 64, "$addon\\art\\sphereBackground", true, 0)
--	mainAnchor:Show();
--	mainAnchor:SetClampedToScreen(true);
--	mainAnchor:SetMovable(true);
--	mainAnchor:SetUserPlaced(false);
--	mainAnchor:SetPoint("Center");
--	mainAnchor:RegisterForDrag("LeftButton");
--	mainAnchor:SetScript("OnDragStart", function () mainAnchor:StartMoving(); end);
--	mainAnchor:SetScript("OnDragStop", function () mainAnchor:StopMovingOrSizing(); end);

--	sphereData.main = Lunar.API:CreateFrame("Frame", "LSmain", mainAnchor, 64, 64, "", true, 0)

	sphereData.main = CreateFrame("Button", "LSmain", UIParent, "SecureActionButtonTemplate");

	sphereData.main:SetWidth(64);
	sphereData.main:SetHeight(64);
	sphereData.main:EnableMouse(true);
	sphereData.main:SetID(0);
--	sphereData.main:SetHitRectInsets(12, 12, 12, 12);

	Lunar.sphereFrame = sphereData.main;

--	sphereData.main:SetMovable(true);
--	sphereData.main:SetUserPlaced(false);
--	sphereData.main:ClearAllPoints();
--	sphereData.main:SetPoint("Center", mainAnchor, "Center", 0, 0);

	sphereData.background = Lunar.API:CreateFrame("Button", "LSbackground", sphereData.main, 64, 64, "$addon\\art\\sphereBackground", false, 0)
	sphereData.sphereTexture = Lunar.API:CreateFrame("Button", "LSsphere", sphereData.main, 66, 66, "$addon\\art\\sphereSkin_2", false, 0)
	sphereData.sphereShine = Lunar.API:CreateFrame("Button", "LSsphereShine", sphereData.main, 64, 64, "$addon\\art\\shine_1", false, 0)
	sphereData.gaugeOuter = Lunar.API:CreateFrame("Button", "LSgaugeOuter", sphereData.main, 64, 64, "$addon\\art\\gaugeFill_1", false, 0)
	sphereData.gaugeOuterHalf = Lunar.API:CreateFrame("Button", "LSgaugeOuterHalf", sphereData.main, 64, 64, "$addon\\art\\gaugeFill_1", false, 0)
	sphereData.gaugeOuterBottom = Lunar.API:CreateFrame("Button", "LSgaugeOuterBottom", sphereData.main, 64, 64, "$addon\\art\\gaugeFill_1", false, 0)
	sphereData.gaugeOuterBottom2 = Lunar.API:CreateFrame("Button", "LSgaugeOuterBottom2", sphereData.main, 64, 64, "$addon\\art\\gaugeFill_1", false, 0)
--	sphereData.gaugeOuter = Lunar.API:CreateFrame("Button", "LSgaugeOuter", sphereData.main, 66, 66, "$addon\\art\\outerGaugeFill", false, 0)
--	sphereData.gaugeOuterHalf = Lunar.API:CreateFrame("Button", "LSgaugeOuterHalf", sphereData.main, 66, 66, "$addon\\art\\outerGaugeFill", false, 0)
	sphereData.gaugeOuterCover = Lunar.API:CreateFrame("Button", "LSgaugeOuterCover", sphereData.main, 64, 64, "$addon\\art\\gaugeFill_1", false, 0)
	sphereData.gaugeOuterMarks = Lunar.API:CreateFrame("Button", "LSgaugeOuterMarks", sphereData.main, 64, 64, "$addon\\art\\outerGaugeMarks5", false, 0)
	sphereData.gaugeOuterShine = Lunar.API:CreateFrame("Button", "LSgaugeOuterShine", sphereData.main, 60, 60, "$addon\\art\\shine_1", false, 0)
--	sphereData.gaugeInner = Lunar.API:CreateFrame("Button", "LSgaugeInner", sphereData.main, 66, 66, "$addon\\art\\innerGaugeFill", false, 0)
--	sphereData.gaugeInnerHalf = Lunar.API:CreateFrame("Button", "LSgaugeInnerHalf", sphereData.main, 66, 66, "$addon\\art\\innerGaugeFill", false, 0)
--	sphereData.gaugeInnerCover = Lunar.API:CreateFrame("Button", "LSgaugeInnerCover", sphereData.main, 66, 66, "$addon\\art\\innerGaugeCover", false, 0)
	sphereData.gaugeInner = Lunar.API:CreateFrame("Button", "LSgaugeInner", sphereData.main, 44, 44, "$addon\\art\\gaugeFill_1", false, 0)
	sphereData.gaugeInnerHalf = Lunar.API:CreateFrame("Button", "LSgaugeInnerHalf", sphereData.main, 44, 44, "$addon\\art\\gaugeFill_1", false, 0)
	sphereData.gaugeInnerBottom = Lunar.API:CreateFrame("Button", "LSgaugeInnerBottom", sphereData.main, 44, 44, "$addon\\art\\gaugeFill_1", false, 0)
	sphereData.gaugeInnerBottom2 = Lunar.API:CreateFrame("Button", "LSgaugeInnerBottom2", sphereData.main, 44, 44, "$addon\\art\\gaugeFill_1", false, 0)
	sphereData.gaugeInnerCover = Lunar.API:CreateFrame("Button", "LSgaugeInnerCover", sphereData.main, 44, 44, "$addon\\art\\gaugeFill_1", false, 0)
	sphereData.gaugeInnerMarks = Lunar.API:CreateFrame("Button", "LSgaugeInnerMarks", sphereData.main, 64, 64, "$addon\\art\\innerGaugeMarks20", false, 0)
	sphereData.gaugeInnerShine = Lunar.API:CreateFrame("Button", "LSgaugeInnerShine", sphereData.main, 44, 44, "$addon\\art\\shine_1", false, 0)
	sphereData.overlay = Lunar.API:CreateFrame("Button", "LSoverlay", sphereData.main, 64, 64, "", false, 0)
	sphereData.combatGlow = Lunar.API:CreateFrame("Button", "LScombatGlow", sphereData.main, 80, 80, "$addon\\art\\combatGlow", false, 0)

	sphereData.sphereBorder = Lunar.API:CreateFrame("Button", "LSsphereBorder", sphereData.main, 62, 62, "$addon\\art\\gaugeBorder_1", false, 0)
	sphereData.gaugeOuterBorder = Lunar.API:CreateFrame("Button", "LSgaugeOuterBorder", sphereData.main, 44, 44, "$addon\\art\\gaugeBorder_1", false, 0)
	sphereData.gaugeInnerBorder = Lunar.API:CreateFrame("Button", "LSgaugeInnerBorder", sphereData.main, 30, 30, "$addon\\art\\gaugeBorder_1", false, 0)

	sphereData.sphereTexture2 = CreateFrame("PlayerModel", "LSsphere2", sphereData.main, BackdropTemplateMixin and "BackdropTemplate");

	sphereData.sphereTexture2:SetWidth(64);
	sphereData.sphereTexture2:SetHeight(64);
	sphereData.sphereTexture2:SetScript("OnUpdate", function (self) self:SetCamera(0) end);
	sphereData.sphereTexture2:Hide();

	-- Rotate the "Half Full" textures, as these will be displayed on the bottom of the
	-- gauge anyway.
	Lunar.API:RotateTexture(sphereData.gaugeOuterHalf:GetNormalTexture(), 180, 0.5, 0.5)
	Lunar.API:RotateTexture(sphereData.gaugeInnerHalf:GetNormalTexture(), 180, 0.5, 0.5)

	-- Hide parts of the gauge that show a filled aspect
	sphereData.gaugeOuterHalf:Hide();
	sphereData.gaugeInnerHalf:Hide();

	-- Grab the frame level of one of our frames ...

	local oldFrameLevel = sphereData.sphereTexture:GetFrameLevel();

	-- And by using that oldFrameLevel as a guide, raise some frames above others
	-- so we have overlapping frames (for the animation of our gauge when it fills,
	-- and other special stuff)

--	sphereData.main:SetToplevel("true");
	sphereData.main:SetToplevel("false");
--	sphereData.main:SetFrameStrata("Medium");
	sphereData.combatGlow:SetFrameLevel(oldFrameLevel - 2); 
	sphereData.gaugeOuterBottom:SetFrameLevel(oldFrameLevel + 1);
	sphereData.gaugeOuterBottom2:SetFrameLevel(oldFrameLevel + 1);
	sphereData.gaugeInnerBottom:SetFrameLevel(oldFrameLevel + 1);
	sphereData.gaugeInnerBottom2:SetFrameLevel(oldFrameLevel + 1);
	sphereData.gaugeOuter:SetFrameLevel(oldFrameLevel + 2);
	sphereData.gaugeInner:SetFrameLevel(oldFrameLevel + 2);
	sphereData.gaugeOuterCover:SetFrameLevel(oldFrameLevel + 3);
	sphereData.gaugeOuterHalf:SetFrameLevel(oldFrameLevel + 3);
	sphereData.gaugeInnerCover:SetFrameLevel(oldFrameLevel + 3);
	sphereData.gaugeInnerHalf:SetFrameLevel(oldFrameLevel + 3);
	sphereData.gaugeOuterShine:SetFrameLevel(oldFrameLevel + 4);
	sphereData.gaugeInnerShine:SetFrameLevel(oldFrameLevel + 4);
	sphereData.sphereTexture:SetFrameLevel(oldFrameLevel + 5);
	sphereData.sphereShine:SetFrameLevel(oldFrameLevel + 6);
	sphereData.gaugeOuterMarks:SetFrameLevel(oldFrameLevel + 5);
	sphereData.gaugeInnerMarks:SetFrameLevel(oldFrameLevel + 5);
	sphereData.gaugeOuterBorder:SetFrameLevel(oldFrameLevel + 7);
	sphereData.gaugeInnerBorder:SetFrameLevel(oldFrameLevel + 7);
	sphereData.sphereBorder:SetFrameLevel(oldFrameLevel + 7);
	sphereData.overlay:SetFrameLevel(oldFrameLevel + 8);
	sphereData.sphereTexture2:SetFrameLevel(oldFrameLevel - 1);

	sphereData.gaugeInnerCover:GetNormalTexture():SetVertexColor(0.15,0.15,0.15);
	sphereData.gaugeOuterCover:GetNormalTexture():SetVertexColor(0.15,0.15,0.15);
	sphereData.gaugeInnerBottom:GetNormalTexture():SetVertexColor(0.15,0.15,0.15);
	sphereData.gaugeOuterBottom:GetNormalTexture():SetVertexColor(0.15,0.15,0.15);
	sphereData.gaugeInnerBottom2:GetNormalTexture():SetVertexColor(0.15,0.15,0.15);
	sphereData.gaugeOuterBottom2:GetNormalTexture():SetVertexColor(0.15,0.15,0.15);

	-- Make our gauge shines a little transparent...
	sphereData.gaugeOuterShine:SetAlpha(0.8);
	sphereData.gaugeInnerShine:SetAlpha(0.8);
--	sphereData.sphereShine:SetAlpha(0.8);

--	sphereData.gaugeOuterShine:SetWidth(60);
--	sphereData.gaugeOuterShine:SetHeight(60);

--	sphereData.gaugeInnerShine:SetWidth(44);
--	sphereData.gaugeInnerShine:SetHeight(44);

	-- Set the center point for all frames to the middle of it's parent

	for _, child in pairs(sphereData) do
		child:SetPoint("Center");
--		child:SetAlpha(1);
	end

	-- Setup our combat glow
	sphereData.combatGlow:ClearAllPoints();
	sphereData.combatGlow:GetNormalTexture():SetVertexColor(1,0,0,1);
--	sphereData.combatGlow:GetNormalTexture():SetBlendMode("ADD");
	sphereData.combatGlow:SetPoint("Center", sphereData.main, "Center", 1, -1);
	sphereData.combatGlow:Hide();

	-- Create the sphere text and ensure that it's empty.

--	sphereData.overlay:SetToplevel("true");
	
	sphereData.sphereText = sphereData.overlay:CreateFontString(nil, "OVERLAY")
	sphereData.sphereText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
	sphereData.sphereText:SetTextColor(1, 1, 1)
	sphereData.sphereText:SetPoint("Center", 0, 0);
	sphereData.sphereText:Show()
	sphereData.sphereText:SetText("");
	dataTracking.sphereText = "";

	-- Create the sphere text background, for those who want it shown. This
	-- will make it easier to read the text on some sphere colors. Also set
	-- the size of the sphere texture.

	sphereData.sphereTextBack = sphereData.overlay:CreateTexture(nil, "ART")
	sphereData.sphereTextBack:SetColorTexture(0,0,0,0.7)
	sphereData.sphereTextBack:SetHeight(9);
	if (LunarSphereSettings.showInner == true) then
		sphereData.sphereTextBack:SetWidth(26);
		sphereData.sphereTexture:SetWidth(28);
		sphereData.sphereTexture:SetHeight(28);
		sphereData.sphereShine:SetWidth(28);
		sphereData.sphereShine:SetHeight(28);
	else
		sphereData.sphereTextBack:SetWidth(40);
		sphereData.sphereTexture:SetWidth(40);
		sphereData.sphereTexture:SetHeight(40);
		sphereData.sphereShine:SetWidth(40);
		sphereData.sphereShine:SetHeight(40);
	end
	sphereData.sphereTextBack:SetPoint("Center");
	sphereData.sphereTextBack:Hide();

	-- Allow our sphere sections to react to events
	sphereData.main:SetScript("OnUpdate", Lunar.Sphere.Updates); --function () Lunar.Sphere:Updates(arg1) end);
	sphereData.main:SetScript("OnEvent", Lunar.Sphere.Events); --function () Lunar.Sphere:Events() end);
	sphereData.gaugeOuterBorder:SetScript("OnEvent", Lunar.Sphere.Events); --function () Lunar.Sphere:Events() end);
	sphereData.gaugeInnerBorder:SetScript("OnEvent", Lunar.Sphere.Events); --function () Lunar.Sphere:Events() end);
	sphereData.background:SetScript("OnEvent", Lunar.Sphere.Events); --function () Lunar.Sphere:Events() end);

	-- Register the events the sphere will always be watching in the background
	sphereData.background:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	sphereData.background:RegisterEvent("PLAYER_LOGIN");
	--sphereData.background:RegisterEvent("PLAYER_AURAS_CHANGED");
	sphereData.background:RegisterEvent("UNIT_AURA");
	sphereData.background:RegisterEvent("PLAYER_ENTERING_WORLD");
--	sphereData.background:RegisterEvent("ZONE_CHANGED");
	sphereData.background:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	if ( Lunar.API:IsVersionRetail() == true ) then
		sphereData.background:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
	end

	-- Item/Spell/Macro pick-up events
	sphereData.background:RegisterEvent("ACTIONBAR_SHOWGRID");
	sphereData.background:RegisterEvent("ACTIONBAR_HIDEGRID");
	sphereData.background:RegisterEvent("PLAYER_REGEN_DISABLED");
	sphereData.background:RegisterEvent("PLAYER_REGEN_ENABLED");
	sphereData.background:RegisterEvent("ITEM_LOCK_CHANGED");
	sphereData.background:RegisterEvent("CURRENT_SPELL_CAST_CHANGED");

	-- Reagent buying / grabbing from bank
	sphereData.background:RegisterEvent("MERCHANT_SHOW");
	sphereData.background:RegisterEvent("BANKFRAME_OPENED");

	-- Macro icon changing events
	sphereData.background:RegisterEvent("MODIFIER_STATE_CHANGED");
	--sphereData.background:RegisterEvent("PLAYER_AURAS_CHANGED");
	sphereData.background:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
	sphereData.background:RegisterEvent("ACTIONBAR_UPDATE_STATE");
	sphereData.background:RegisterEvent("ACTIONBAR_SLOT_CHANGED")

	-- Bag changing events
	sphereData.background:RegisterEvent("BAG_CLOSED");

	-- Gossip events
	sphereData.background:RegisterEvent("GOSSIP_SHOW");

	-- Item/Spell/Macro right-click assignment helper
--	sphereData.background:RegisterEvent("CURSOR_UPDATE");

	-- Auto-Scale helper for the settings windows (No more tiny windows if the user interface
	-- scale is stupid small)
	sphereData.background:RegisterEvent("CVAR_UPDATE");

--[[ debug 
	sphereData.sphereShine:RegisterAllEvents();
	sphereData.sphereShine:UnregisterEvent("CHAT_MSG_ADDON");
--	sphereData.sphereShine:UnregisterEvent("CHAT_MSG_CHANNEL");
	sphereData.sphereShine:UnregisterEvent("UPDATE_CHAT_COLOR");
	sphereData.sphereShine:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	sphereData.sphereShine:UnregisterEvent("WORLD_MAP_UPDATE");
	sphereData.sphereShine:UnregisterEvent("UPDATE_WORLD_STATES");

--	sphereData.sphereShine:RegisterEvent("CVAR_UPDATE");
--	sphereData.sphereShine:RegisterEvent("UNIT_INVENTORY_CHANGED");
--	sphereData.sphereShine:RegisterEvent("UPDATE_INVENTORY_ALERTS");
--	sphereData.sphereShine:RegisterEvent("BAG_UPDATE");
	sphereData.sphereShine:RegisterEvent("PET_BAR_UPDATE_COOLDOWN");
--	sphereData.sphereShine:RegisterEvent("BAG_UPDATE_COOLDOWN");
--	sphereData.sphereShine:RegisterEvent("PLAYER_AURAS_CHANGED");
--	sphereData.sphereShine:RegisterEvent("SPELL_UPDATE_USABLE");
	sphereData.sphereShine:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	sphereData.sphereShine:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");

	sphereData.sphereShine:SetScript("OnEvent", 
	function (self, event, ...) 

		if (event == "MEETINGSTONE_CHANGED") then
			if (not Lunar.API.testValue1) then
				Lunar.API.testValue1 = 0
			end

			Lunar.API.testValue1 = Lunar.API.testValue1 + 1;
			Lunar.API:Print(Lunar.API.testValue1);
		
		end

		if (event == "ACTIVE_TALENT_GROUP_CHANGED") then
			Lunar.API:Print(GetActiveTalentGroup());
		end

		if (event == "CURSOR_UPDATE") then
			if (SpellIsTargeting()) then
				Lunar.API:Print("Waiting Casting!");
				if (IsCurrentItem("Superior Wizard Oil")) then
					PickupInventoryItem(16)
				end
			end
		
			local cursorType, objectID, objectData = GetCursorInfo();
		end

		print(...);
--		if (arg1) then
--			Lunar.API:Print("1: " .. tostring(arg1))	
--		end
--		if (arg2) then
--			Lunar.API:Print("2: " .. tostring(arg2))	
--		end
--		if (arg3) then
--			Lunar.API:Print("3: " .. arg3)	
--		end
--		if (arg4) then
--			Lunar.API:Print("4: " .. arg4)	
--		end
	end);
--]]
	-- Make the sphere dragable

	sphereData.main:SetClampedToScreen(true);

	sphereData.main:SetMovable(true);
	sphereData.main:RegisterForDrag("LeftButton");
	sphereData.main:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp");
	sphereData.main:SetScript("OnDragStart", 
	function (self) 
		if (LunarSphereSettings.sphereMoveable) then
			self:StartMoving(); 
		end
	end);

	sphereData.main:SetScript("OnDragStop", function (self)

		local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint();
		LunarSphereSettings.relativePoint = relativePoint;
		LunarSphereSettings.xOfs = xOfs;
		LunarSphereSettings.yOfs = yOfs;
--		_G["LSSettingsXLocationEdit"]:SetText(xOfs);
--		_G["LSSettingsYLocationEdit"]:SetText(yOfs);
		self:StopMovingOrSizing();
	end);

	sphereData.main:SetScript("OnMouseUp", 
	function (self, arg1)

		if arg1 == "RightButton" and (IsControlKeyDown()) then
			Lunar.Settings:ToggleSettingsFrame();
--			ToggleDropDownMenu(1, nil, _G["LSSettingsMenuDropdown"], "LSmain", 0, 0);
			return;
		end

		if arg1 == "LeftButton" and (IsControlKeyDown()) then
--			Lunar.Settings:ToggleSettingsFrame();
			ToggleDropDownMenu(1, nil, _G["LSSettingsMenuDropdown"], "LSmain", 0, 0);
			return;
		end

		-- If we're not in combat, and the buttons are unlocked, update the button with a
		-- new action if required
		if (Lunar.combatLockdown == false) and (LunarSphereSettings.buttonEditMode == true) then
			if (GetCursorInfo() or (Lunar.Button.updateType) ) then
				local clickType = Lunar.API:ConvertClick(arg1);
				local stance = GetShapeshiftForm();

				local _,_,_,buttonTexture = Lunar.Button:GetButtonData(self:GetID(), stance, clickType)

				if (clickType ~= 1) and (not buttonTexture) then
					ClearCursor();
					return;
				end

				self:SetAttribute("*type-S" .. stance .. clickType, "spell");
				self:SetAttribute("*spell-S" .. stance .. clickType, "");
				self:SetAttribute("*item-S" .. stance .. clickType, "");
				self:SetAttribute("*macro-S" .. stance .. clickType, "");
				Lunar.Button.updateButton = _G["LSmain"];
				Lunar.Button.updateType, Lunar.Button.updateID, Lunar.Button.updateData = GetCursorInfo();
				Lunar.Button.updateClick = arg1;
				Lunar.Button.updateFrame:SetScript("OnUpdate", Lunar.Button.AssignmentUpdate);
			else
				if (Lunar.Settings.buttonEdit ~= self:GetID()) then
					Lunar.Settings.ButtonDialog:Hide();
					Lunar.Settings.buttonEdit = self:GetID();
					Lunar.Settings.ButtonDialog:Show();
				else
					Lunar.Settings.ButtonDialog:Hide();
				end;
			end
		end
	end);

	sphereData.main:SetScript("PostClick", Lunar.Button.PostClick);
	sphereData.main:SetScript("OnEnter", Lunar.Button.OnEnter);
	sphereData.main:SetScript("OnLeave", Lunar.Button.OnLeave);

	sphereData.main:SetScript("OnReceiveDrag", 
	function (self)
		if (Lunar.combatLockdown == false) and (LunarSphereSettings.buttonEditMode == true) then
			if (GetCursorInfo()) then
				if not IsControlKeyDown() then
					Lunar.Button.updateType, Lunar.Button.updateID, Lunar.Button.updateData = GetCursorInfo();
					Lunar.Button:Assign(self, 1)
					Lunar.Button:SetTooltip(self);
				end
			end

			ClearCursor();
		end
	end);

	-- Set the colors of the sphere and gauges

--	Lunar.Sphere:SetSphereColor();
	Lunar.Sphere:SetSphereTexture();
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

--	Lunar.Sphere:SetInnerGaugeColor();
--	Lunar.Sphere:SetOuterGaugeColor();

	sphereData.main:SetScale(LunarSphereSettings.sphereScale);

--
--	sphereData.sphereBorder:SetWidth(60);
--	sphereData.sphereBorder:SetHeight(60);
--	sphereData.gaugeInnerBorder:SetWidth(30);
--	sphereData.gaugeInnerBorder:SetHeight(30);
--	sphereData.gaugeOuterBorder:SetWidth(42);
--	sphereData.gaugeOuterBorder:SetHeight(42);
--	sphereData.sphereBorder:SetAlpha(0.5);
--	sphereData.gaugeInnerBorder:SetAlpha(0.5);
--	sphereData.gaugeOuterBorder:SetAlpha(0.5);
--	sphereData.sphereBorder:ClearAllPoints();
--	sphereData.gaugeInnerBorder:ClearAllPoints();
--	sphereData.gaugeOuterBorder:ClearAllPoints();
--	sphereData.sphereBorder:SetPoint("Center", 0, 0);
--	sphereData.gaugeInnerBorder:SetPoint("Center", 0, 0);
--	sphereData.gaugeOuterBorder:SetPoint("Center", 0, 0);

--	sphereData.sphereBorder:GetNormalTexture():SetVertexColor(0.2,0.4,0.8);
--	sphereData.gaugeInnerBorder:GetNormalTexture():SetVertexColor(0.4,0.2,0.8);
--	sphereData.gaugeOuterBorder:GetNormalTexture():SetVertexColor(0.8,0.2,0.4);
--	sphereData.sphereBorder:GetNormalTexture():SetVertexColor(0,0,0);
--	sphereData.gaugeInnerBorder:GetNormalTexture():SetVertexColor(0,0,0);
--	sphereData.gaugeOuterBorder:GetNormalTexture():SetVertexColor(0,0,0);
	local tex = sphereData.sphereTexture2:CreateTexture("LSSphereModelBackground", "BACKGROUND");
	tex:SetColorTexture(0,0,0,1);
	tex:SetAllPoints(sphereData.sphereTexture2);

--	sphereData.sphereBorder:Hide();
--	sphereData.gaugeInnerBorder:Hide();
--	sphereData.gaugeOuterBorder:Hide();

end

function Lunar.Sphere:SetSphereTexture(textureType)

	if (not textureType) then
		textureType = LunarSphereSettings.sphereSkin;
	end

	-- The shine for the first sphere is different than the rest
	if (textureType == 1) and (LunarSphereSettings.useSphereClickIcon ~= true) then
		sphereData.sphereShine:SetNormalTexture(LUNAR_ART_PATH .. "shine_2");
	else
		sphereData.sphereShine:SetNormalTexture(LUNAR_ART_PATH .. "shine_1");
	end

	sphereData.sphereTexture2:Hide();
	sphereData.sphereTexture:Show();

	local updateSkin = true;
	if (LunarSphereSettings.useSphereClickIcon == true) then
		updateSkin = false;
		local clickType = Lunar.Button:GetButtonSetting(0, _G["LSmain"].currentStance or (Lunar.Button.defaultStance), LUNAR_GET_SHOW_ICON)
		local _, _, _, objectTexture = Lunar.Button:GetButtonData(0, _G["LSmain"].currentStance or (Lunar.Button.defaultStance), clickType);

		if (objectTexture ~= "") and (objectTexture ~= nil) then
			_G["LSsphere"]:SetNormalTexture(objectTexture);
		else
			updateSkin = true;	
			_G["LSsphere"]:SetNormalTexture("Interface\\DialogFrame\\UI-DialogBox-Background");
		end

		SetPortraitToTexture(_G["LSsphere"]:GetNormalTexture(), _G["LSsphere"]:GetNormalTexture():GetTexture());
		if (objectTexture == "portrait") then
			SetPortraitTexture(sphereData.sphereTexture:GetNormalTexture(), "player");
			sphereData.sphereTexture:GetNormalTexture():SetVertexColor(1, 1, 1);
		end
	end

	if (updateSkin == true) then
		-- Standard sphere images
		if (textureType <= Lunar.includedSpheres) then
			sphereData.sphereTexture:SetNormalTexture(LUNAR_ART_PATH .. "sphereSkin_" .. textureType);
		-- 2D Player Portrait
		elseif (textureType == Lunar.includedSpheres + 1) then
			SetPortraitTexture(sphereData.sphereTexture:GetNormalTexture(), "player");
			sphereData.sphereTexture:GetNormalTexture():SetVertexColor(1, 1, 1);
		-- 3D Player Portrait
		elseif (textureType == Lunar.includedSpheres + 2) then
			sphereData.sphereTexture2:SetCamera(0);
			sphereData.sphereTexture2:SetUnit("player");

			sphereData.sphereTexture:Hide();
			sphereData.sphereTexture2:Show();
		-- Class icon spheres
		elseif ((textureType > Lunar.includedSpheres + 2) and (textureType <= Lunar.includedSpheres + LUNAR_EXTRA_SPHERE_ICON_COUNT)) then

			sphereData.sphereTexture:SetNormalTexture(LUNAR_ART_PATH .. "sphereClass_" .. (textureType - Lunar.includedSpheres - 2));
		-- Custom import art images
		else
			local artIndex, artType, width, height, artFilename = Lunar.API:GetArtByCatagoryIndex("sphere", textureType - Lunar.includedSpheres - LUNAR_EXTRA_SPHERE_ICON_COUNT);

			if (artFilename) then
				sphereData.sphereTexture:SetNormalTexture(LUNAR_IMPORT_PATH .. artFilename);
			end
		end
--[[ TABARD TEXTURE
		if (not sphereData.sphereTexture.tabardBackground) then
			sphereData.sphereTexture.tabardBackground = sphereData.sphereTexture:CreateTexture(nil, "BACKGROUND")
			sphereData.sphereTexture.tabardBackground:SetTexture("Interface\\GuildFrame\\GuildFrame");
			sphereData.sphereTexture.tabardBackground:SetTexCoord(0.63183594, 0.69238281, 0.61914063, 0.74023438);
			sphereData.sphereTexture.tabardBackground:ClearAllPoints();
			sphereData.sphereTexture.tabardBackground:SetWidth(sphereData.sphereTexture:GetWidth());
			sphereData.sphereTexture.tabardBackground:SetHeight(sphereData.sphereTexture:GetHeight());
			sphereData.sphereTexture.tabardBackground:SetPoint("Center", sphereData.sphereTexture, "Center");
			sphereData.sphereTexture.tabardBackground:Show();
			sphereData.sphereTexture.tabardBorder = sphereData.sphereTexture:CreateTexture(nil, "ART")
			sphereData.sphereTexture.tabardBorder:SetTexture("Interface\\GuildFrame\\GuildFrame");
			sphereData.sphereTexture.tabardBorder:SetTexCoord(0.63183594, 0.69238281, 0.74414063, 0.86523438);
			sphereData.sphereTexture.tabardBorder:ClearAllPoints();
			sphereData.sphereTexture.tabardBorder:SetWidth(sphereData.sphereTexture:GetWidth());
			sphereData.sphereTexture.tabardBorder:SetHeight(sphereData.sphereTexture:GetHeight());
			sphereData.sphereTexture.tabardBorder:SetPoint("Center", sphereData.sphereTexture, "Center");
			sphereData.sphereTexture.tabardBorder:Show();
		end
		sphereData.sphereTexture.tabardBackground:SetWidth(sphereData.sphereTexture:GetWidth());
		sphereData.sphereTexture.tabardBackground:SetHeight(sphereData.sphereTexture:GetHeight());
		SetLargeGuildTabardTextures("player", sphereData.sphereTexture:GetNormalTexture(), sphereData.sphereTexture.tabardBackground, sphereData.sphereTexture.tabardBorder); --GuildFrameTabardBorder)
--]]				
	end
	LunarSphereSettings.sphereSkin = textureType;
	Lunar.Sphere:SetSphereColor();
	Lunar.Sphere:SetPortraitBorder();
end

function Lunar.Sphere:MinimapTest()
--/script Lunar.Sphere:MinimapTest()
	if (sphereData.background:IsVisible()) then
		sphereData.background:Hide()
		Minimap:ClearAllPoints();
		Minimap:SetParent(sphereData.sphereTexture);
		Minimap:SetScale(sphereData.sphereTexture:GetWidth() / Minimap:GetWidth());
		Minimap:SetPoint("Center");
		Minimap:EnableMouse(false);
		local kids = { Minimap:GetChildren() };
		for _, child in ipairs(kids) do
			if (child:GetObjectType() ~= "Model") then
				if (child:IsVisible()) then
					child.hidden = true;
					child:Hide();
				end
			end
		end
	else
		sphereData.background:Show()
		Minimap:ClearAllPoints();
		Minimap:SetParent(MinimapCluster);
		Minimap:SetScale(1);
		Minimap:SetPoint("Center", MinimapCluster, "Top", 9, -92);
		Minimap:EnableMouse(true);
		local kids = { Minimap:GetChildren() };
		for _, child in ipairs(kids) do
			if (child.hidden) then
				child.hidden = nil;
				child:Show();
			end
		end
	end
end
function Lunar.Sphere:SetPortraitBorder()

	-- We need to make sure there is a border around our 3D portrait. So, make sure
	-- the sphere background is reset to normal. Then, if the sphere texture
	-- is set to a 3D portrait, continue

	sphereData.background:SetNormalTexture(LUNAR_ART_PATH .. "sphereBackground");
	if (LunarSphereSettings.sphereSkin == Lunar.includedSpheres + 2) then

		-- Show the sphere background image (with a cut-out for the portrait)
		-- that matches the size of the background to be shown.

		sphereData.background:SetWidth(64);
		sphereData.background:SetHeight(64);

		local textureID = 1;
		if LunarSphereSettings.showOuter and not LunarSphereSettings.showInner then
			textureID = 2;
		elseif not LunarSphereSettings.showOuter and LunarSphereSettings.showInner then
			textureID = 3;
		elseif not LunarSphereSettings.showOuter and not LunarSphereSettings.showInner then
			textureID = 4;
		end
		sphereData.background:SetNormalTexture(LUNAR_ART_PATH .. "sphereBackground" .. textureID);
	end
end

function Lunar.Sphere:SetSphereText(sphereText)

	if (dataTracking.sphereText ~= sphereText) then

		sphereData.sphereText:SetText(sphereText);
		dataTracking.sphereText = sphereText;
		if ((sphereText == "") or (LunarSphereSettings.showSphereTextShadow == false)) then
			sphereData.sphereTextBack:Hide();
		else			
			sphereData.sphereTextBack:Show();
		end	
	end
end

function Lunar.Sphere:SetSphereColor(r, g, b)

	if (r) then
		LunarSphereSettings.sphereColor[1] = r;
		LunarSphereSettings.sphereColor[2] = g;
		LunarSphereSettings.sphereColor[3] = b;
	end

	if (LunarSphereSettings.useSphereClickIcon == true) then
		sphereData.sphereTexture:GetNormalTexture():SetVertexColor(1, 1, 1);
	else
		if ((not r) and (LunarSphereSettings.customSphereColor == true)) then
			r = LunarSphereSettings.sphereColor[1];
			g = LunarSphereSettings.sphereColor[2];
			b = LunarSphereSettings.sphereColor[3];
		elseif (not r) then
			r = 1.0;
			g = 1.0;
			b = 1.0;
		end

		if (not ((LunarSphereSettings.sphereSkin > Lunar.includedSpheres) and (LunarSphereSettings.sphereSkin <= Lunar.includedSpheres + 2))) then
			sphereData.sphereTexture:GetNormalTexture():SetVertexColor(r, g, b);
		end
	end
end

function Lunar.Sphere:SetInnerGaugeColor(r, g, b)

	if (not r) then
		r = LunarSphereSettings.innerGaugeColor[1];
		g = LunarSphereSettings.innerGaugeColor[2];
		b = LunarSphereSettings.innerGaugeColor[3];
	end

	sphereData.gaugeInner:GetNormalTexture():SetVertexColor(r, g, b);
	sphereData.gaugeInnerHalf:GetNormalTexture():SetVertexColor(r, g, b);
end

function Lunar.Sphere:SetOuterGaugeColor(r, g, b)

	if (not r) then
		r = LunarSphereSettings.outerGaugeColor[1];
		g = LunarSphereSettings.outerGaugeColor[2];
		b = LunarSphereSettings.outerGaugeColor[3];
	end

	sphereData.gaugeOuter:GetNormalTexture():SetVertexColor(r, g, b);
	sphereData.gaugeOuterHalf:GetNormalTexture():SetVertexColor(r, g, b);
end

function Lunar.Sphere:SetSphereTextColor(r, g, b)

	if (not r) then
		r = LunarSphereSettings.sphereTextColor[1];
		g = LunarSphereSettings.sphereTextColor[2];
		b = LunarSphereSettings.sphereTextColor[3];
	end

	sphereData.sphereText:SetTextColor(r, g, b)
end

function Lunar.Sphere:ResetDefaultColor(gaugeType)

	if (gaugeType == LS_EVENT_POWER) then
		gaugeType = dataTracking.powerName[dataTracking.powerType]
	end
	LunarSphereSettings.gaugeColor[gaugeType][4] = false;

--	local colorR = LunarSphereSettings.gaugeColor[gaugeType][1];
--	local colorG = LunarSphereSettings.gaugeColor[gaugeType][2];
--	local colorB = LunarSphereSettings.gaugeColor[gaugeType][3];
--	LunarSphereSettings[gaugeID .. "GaugeColor"][1] = colorR;
--	LunarSphereSettings[gaugeID .. "GaugeColor"][2] = colorG;
--	LunarSphereSettings[gaugeID .. "GaugeColor"][3] = colorB;

--	if (_G["LSSettings" .. gaugeID .. "GaugeColor" .. "Color"]) then
--		_G["LSSettings" .. gaugeID .. "GaugeColor" .. "Color"]:SetColorTexture(colorR, colorG, colorB);
--	end

	Lunar.Sphere:UpdateGaugeColors();
end

function Lunar.Sphere:SetInnerMarkSize(markPercents)

	if (markPercents == 5) or (markPercents == 10) or (markPercents == 20) then
		LunarSphereSettings.innerMarkSize = markPercents;
		sphereData.gaugeInnerMarks:SetNormalTexture(LUNAR_ADDON_PATH .. "\\art\\innerGaugeMarks" .. tostring(LunarSphereSettings.innerMarkSize));
		Lunar.Sphere:ShowInnerMarks(true);
	else
		LunarSphereSettings.innerMarkSize = 0	
		Lunar.Sphere:ShowInnerMarks(false);
	end
end

function Lunar.Sphere:SetOuterMarkSize(markPercents)

	if (markPercents == 5) or (markPercents == 10) or (markPercents == 20) then
		LunarSphereSettings.outerMarkSize = markPercents;
		sphereData.gaugeOuterMarks:SetNormalTexture(LUNAR_ADDON_PATH .. "\\art\\outerGaugeMarks" .. tostring(LunarSphereSettings.outerMarkSize));
		Lunar.Sphere:ShowOuterMarks(true);
	else
		LunarSphereSettings.outerMarkSize = 0;
		Lunar.Sphere:ShowOuterMarks(false);
	end
end

function Lunar.Sphere:ShowInnerGauge(toggle)

	LunarSphereSettings.showInner = toggle;
	if (toggle == true) then
		sphereData.gaugeInner:Show();
		sphereData.gaugeInnerHalf:SetID(0);
		sphereData.gaugeInnerHalf:Hide();
		sphereData.gaugeInnerBottom:Show();
		sphereData.gaugeInnerBottom2:Show();
		sphereData.gaugeInnerCover:Show();
		sphereData.gaugeInnerBorder:Show();
		sphereData.gaugeOuterBorder:Show();
		sphereData.sphereTexture:SetWidth(28);
		sphereData.sphereTexture:SetHeight(28);
		sphereData.sphereTexture2:SetWidth(28);
		sphereData.sphereTexture2:SetHeight(28);
		sphereData.sphereShine:SetWidth(28);
		sphereData.sphereShine:SetHeight(28);
		if (LunarSphereSettings.innerMarkSize > 0) then
			Lunar.Sphere:ShowInnerMarks(true);
		end
		Lunar.Sphere:UpdateGauge("Inner");
	else
		sphereData.gaugeInner:Hide();
		sphereData.gaugeInnerHalf:SetID(0);
		sphereData.gaugeInnerHalf:Hide();
		sphereData.gaugeInnerBottom:Hide();
		sphereData.gaugeInnerBottom2:Hide();
		sphereData.gaugeInnerCover:Hide();
		sphereData.gaugeInnerBorder:Hide();
		sphereData.sphereTexture:SetWidth(40);
		sphereData.sphereTexture:SetHeight(40);
		sphereData.sphereTexture2:SetWidth(40);
		sphereData.sphereTexture2:SetHeight(40);
		sphereData.sphereShine:SetWidth(40);
		sphereData.sphereShine:SetHeight(40);
		sphereData.gaugeInnerMarks:Hide();
	end

	if (LunarSphereSettings.showInner == true) then
		sphereData.sphereTextBack:SetWidth(26);
	else
		sphereData.sphereTextBack:SetWidth(40);
	end

	Lunar.Sphere:ShowGaugeShines();
end

function Lunar.Sphere:ShowOuterGauge(toggle)

	LunarSphereSettings.showOuter = toggle;
	if (toggle == true) then
		sphereData.background:SetWidth(64);
		sphereData.background:SetHeight(64);
		sphereData.gaugeOuter:Show();
		sphereData.gaugeOuterHalf:SetID(0);
		sphereData.gaugeOuterHalf:Hide();
		sphereData.gaugeOuterBottom:Show();
		sphereData.gaugeOuterBottom2:Show();
		sphereData.gaugeOuterCover:Show();
		sphereData.gaugeOuterBorder:Show();
		sphereData.sphereBorder:Show();
		sphereData.sphereTexture:SetWidth(40);
		sphereData.sphereTexture:SetHeight(40);
		sphereData.sphereTexture2:SetWidth(40);
		sphereData.sphereTexture2:SetHeight(40);
		sphereData.sphereShine:SetWidth(40);
		sphereData.sphereShine:SetHeight(40);
		sphereData.combatGlow:SetWidth(80);
		sphereData.combatGlow:SetHeight(80);
		if (LunarSphereSettings.outerMarkSize > 0) then
			Lunar.Sphere:ShowOuterMarks(true);
		end
		Lunar.Sphere:UpdateGauge("Outer");
		Lunar.Sphere:ShowInnerGauge(LunarSphereSettings.showInner);
		if (LunarSphereSettings.showInner == true) then
			sphereData.sphereTextBack:SetWidth(26);
		else
			sphereData.sphereTextBack:SetWidth(40);
		end
	else
		sphereData.background:SetWidth(46);
		sphereData.background:SetHeight(46);
		sphereData.gaugeOuter:Hide();
		sphereData.gaugeOuterHalf:SetID(0);
		sphereData.gaugeOuterHalf:Hide();
		sphereData.gaugeOuterBottom:Hide();
		sphereData.gaugeOuterBottom2:Hide();
		sphereData.gaugeOuterCover:Hide();
		sphereData.gaugeOuterBorder:Hide();
		sphereData.gaugeInnerBorder:Hide();
		sphereData.sphereBorder:Hide();
		sphereData.gaugeOuterMarks:Hide();
		sphereData.combatGlow:SetWidth(62);
		sphereData.combatGlow:SetHeight(62);
		Lunar.Sphere:ShowInnerGauge(LunarSphereSettings.showInner);
		if (LunarSphereSettings.showInner ~= true) then
			sphereData.background:SetWidth(64);
			sphereData.background:SetHeight(64);
			sphereData.combatGlow:SetWidth(80);
			sphereData.combatGlow:SetHeight(80);
			sphereData.sphereBorder:Show();
			sphereData.sphereTexture:SetWidth(56);
			sphereData.sphereTexture:SetHeight(56);
			sphereData.sphereTexture2:SetWidth(40);
			sphereData.sphereTexture2:SetHeight(40);
			sphereData.sphereShine:SetWidth(56);
			sphereData.sphereShine:SetHeight(56);
		end
		if (LunarSphereSettings.showInner == true) then
			sphereData.sphereTextBack:SetWidth(26);
		else
			sphereData.sphereTextBack:SetWidth(56);
		end
	end

	Lunar.Sphere:ShowGaugeShines();
end

function Lunar.Sphere:ShowInnerMarks(toggle)

	if (LunarSphereSettings.innerMarkDark == true) then
		sphereData.gaugeInnerMarks:SetAlpha(1);
	else
		sphereData.gaugeInnerMarks:SetAlpha(0.5);
	end

	if (toggle == true) and (LunarSphereSettings.showInner)  then
		sphereData.gaugeInnerMarks:Show();
	else
		sphereData.gaugeInnerMarks:Hide();
	end
end

function Lunar.Sphere:ShowOuterMarks(toggle)

	if (LunarSphereSettings.outerMarkDark == true) then
		sphereData.gaugeOuterMarks:SetAlpha(1);
	else
		sphereData.gaugeOuterMarks:SetAlpha(0.5);
	end

	if (toggle == true) then
		sphereData.gaugeOuterMarks:Show();
	else
		sphereData.gaugeOuterMarks:Hide();
	end
end

function Lunar.Sphere:ShowInnerAnimation(toggle)

	LunarSphereSettings.innerGaugeAnimate = toggle;
	dataTracking.gaugeInnerStart = nil;
	dataTracking.animateInner = nil;
end

function Lunar.Sphere:ShowOuterAnimation(toggle)

	LunarSphereSettings.outerGaugeAnimate = toggle;
	dataTracking.gaugeOuterStart = nil;
	dataTracking.animateOuter = nil;
end

function Lunar.Sphere:ShowSphereShine(toggle)

	LunarSphereSettings.showSphereShine = toggle;
	if (toggle == true) then
		sphereData.sphereShine:Show();
	else
		sphereData.sphereShine:Hide();
	end
end

function Lunar.Sphere:ShowGaugeShines(innerToggle, outerToggle)

	if (not innerToggle) then innerToggle = LunarSphereSettings.showInnerGaugeShine end;
	if (not outerToggle) then outerToggle = LunarSphereSettings.showOuterGaugeShine end;

	LunarSphereSettings.showInnerGaugeShine = innerToggle;
	LunarSphereSettings.showOuterGaugeShine = outerToggle;

	if ((outerToggle == 1) and (LunarSphereSettings.showOuter == true))then
		sphereData.gaugeOuterShine:Show();
	else
		sphereData.gaugeOuterShine:Hide();
	end

	if ((innerToggle == 1) and (LunarSphereSettings.showInner == true)) then
		sphereData.gaugeInnerShine:Show();
	else
		sphereData.gaugeInnerShine:Hide();
	end

	Lunar.Sphere:SetPortraitBorder()
end

function Lunar.Sphere:ShowSphereEditGlow(toggle)

	if (not toggle) then
		toggle = 0;
	end

	LunarSphereSettings.showSphereEditGlow = toggle;
--	if ( not Lunar.combatLockdown) then
		sphereData.combatGlow:Hide();
		if (LunarSphereSettings.showSphereEditGlow == true) and (LunarSphereSettings.buttonEditMode == true) then
			sphereData.combatGlow:Show();
			sphereData.combatGlow:GetNormalTexture():SetVertexColor(1,1,0,1);
		end

		if (Lunar.combatLockdown ~= true) and (LunarSphereSettings.buttonEditMode == true) then 
			Lunar.Button:ShowEmptyMenuButtons();
			Lunar.Button:EnableActions(false);
		else
			Lunar.Button:HideEmptyMenuButtons();
			if (LunarSphereSettings.buttonEditMode == true) then
				LunarSphereSettings.buttonEditMode = -1;
			end
			Lunar.Button:EnableActions(true);
			if (LunarSphereSettings.buttonEditMode == -1) then
				LunarSphereSettings.buttonEditMode = true;
			end
			Lunar.Button:CheckVisibilityOptions();
			Lunar.Button:ToggleMenuAutoHide();
		end
--	end
end

function Lunar.Sphere:ShowSphereTextShadow(toggle)

	LunarSphereSettings.showSphereTextShadow = toggle;
	if ((toggle == true) and (dataTracking.sphereText ~= ""))  then
		sphereData.sphereTextBack:Show();
	else
		sphereData.sphereTextBack:Hide();
	end
end

function Lunar.Sphere:ShowSphereTextPercentage(toggle)

	LunarSphereSettings.useSphereTextPercentage = toggle;
	Lunar.Sphere:UpdateSphere();
end

function Lunar.Sphere:SetSphereTextType(eventType, specificID)

	sphereData.main:UnregisterAllEvents();
	sphereData.main.updateCount = nil;

	sphereData["sphereEvent"] = dataTracking.eventWatch[eventType] or ("");

	-- Although it's listed as the "mana" event, we will watch the proper type
	-- of power type the player uses.

	sphereData.main.source = "player";

	if ((eventType >= LS_EVENT_T_HEALTH) and (eventType <= LS_EVENT_T_POWER)) then
		sphereData.main.source = "target";
	end

	if (eventType == LS_EVENT_POWER) then
		sphereData.main:RegisterEvent(dataTracking.eventWatch[dataTracking.powerName[dataTracking.powerType]]);
		LunarSphereSettings.sphereTextType = eventType; --dataTracking.powerName[dataTracking.powerType];
		sphereData["sphereEvent"] = dataTracking.eventWatch[dataTracking.powerName[dataTracking.powerType]];
	elseif ((eventType == LS_EVENT_NONE) or (eventType == nil)) then
		LunarSphereSettings.sphereTextType = LS_EVENT_NONE;
	else
		if (dataTracking.eventWatch[eventType]) then
			sphereData.main:RegisterEvent(dataTracking.eventWatch[eventType]);
		end	
		LunarSphereSettings.sphereTextType = eventType;
	end

	if (eventType == LS_EVENT_P_EXP) then
		sphereData.main:RegisterEvent("UNIT_PET");
	elseif (eventType == LS_EVENT_COMBO) then
		sphereData.main:RegisterEvent("PLAYER_TARGET_CHANGED");
	elseif (eventType == LS_EVENT_SPHERE_COOLDOWN) then
		sphereData.main:RegisterEvent("SPELL_UPDATE_COOLDOWN");
		sphereData.main:RegisterEvent("BAG_UPDATE_COOLDOWN");
		sphereData.main.updateCount = true;
		sphereData.main.actionTypeCount = nil;
		sphereData.main.actionTypeCooldown = nil;
		Lunar.Button.UpdateCooldown(_G["LSmain"], nil);
	elseif (eventType == LS_EVENT_SPHERE_COUNT) then
		sphereData.main:RegisterEvent("UNIT_INVENTORY_CHANGED");
		sphereData.main:RegisterEvent("BAG_UPDATE");
		sphereData.main.updateCount = true;
		sphereData.main.actionTypeCount = nil;
		sphereData.main.actionTypeCooldown = nil;
		Lunar.Button:UpdateCount(_G["LSmain"]);
	end

	if ((eventType == LS_EVENT_POWER) or (eventType == LS_EVENT_FIVE)) then
		dataTracking.playerMana = UnitPower("player", 0);
	end
	
	LunarSphereSettings.sphereTextTypeID = specificID;

	Lunar.Sphere:UpdateSphere();
end

function Lunar.Sphere:SetOuterGaugeType(eventType, specificID)

	Lunar.Sphere:SetGaugeType("Outer", eventType, specificID)
end

function Lunar.Sphere:SetInnerGaugeType(eventType, specificID)

	Lunar.Sphere:SetGaugeType("Inner", eventType, specificID);
end

function Lunar.Sphere:SetGaugeType(gaugeID, eventType, specificID)

	local smallID = string.lower(string.sub(gaugeID, 1, 1)) .. string.sub(gaugeID, 2, string.len(gaugeID));

	sphereData["gauge" .. gaugeID .. "Border"]:UnregisterAllEvents();
	sphereData["gauge" .. gaugeID .. "Border"].source = "player";

	if ((eventType >= LS_EVENT_T_HEALTH) and (eventType <= LS_EVENT_T_POWER)) then
		sphereData["gauge" .. gaugeID .. "Border"].source = "target";
	end

	local colorR, colorG, colorB;
	local colorStart = 0;
	local eventWatch = eventType;

	-- Although it's listed as the "mana" event, we will watch the proper type
	-- of power type the player uses.
	if (eventType == LS_EVENT_POWER) or (eventType == LS_EVENT_T_POWER)  then
--		eventWatch = dataTracking.powerName[dataTracking.powerType];
		eventWatch = dataTracking.powerName[UnitPowerType(sphereData["gauge" .. gaugeID .. "Border"].source)];
	end

	sphereData["gauge" .. gaugeID .. "Border"]:RegisterEvent(dataTracking.eventWatch[eventWatch]);

	sphereData[gaugeID .. "Event"] = dataTracking.eventWatch[eventWatch];

	if (eventType == LS_EVENT_P_EXP) then
		sphereData["gauge" .. gaugeID .. "Border"]:RegisterEvent("UNIT_PET");
	end

	if (eventType == LS_EVENT_COMBO) or ((eventType >= LS_EVENT_T_HEALTH) and (eventType <= LS_EVENT_T_POWER)) then
		sphereData["gauge" .. gaugeID .. "Border"]:RegisterEvent("PLAYER_TARGET_CHANGED");
	end

	LunarSphereSettings[smallID .. "GaugeType"] = eventType;

	Lunar.Sphere:UpdateGaugeColors();

--[[	if (LunarSphereSettings.gaugeColor[eventWatch][4] == true) then
		colorStart = 4;
	end
	colorR = LunarSphereSettings.gaugeColor[eventWatch][colorStart + 1]
	colorG = LunarSphereSettings.gaugeColor[eventWatch][colorStart + 2]
	colorB = LunarSphereSettings.gaugeColor[eventWatch][colorStart + 3]
	LunarSphereSettings[smallID .. "GaugeColor"][1] = colorR;
	LunarSphereSettings[smallID .. "GaugeColor"][2] = colorG;
	LunarSphereSettings[smallID .. "GaugeColor"][3] = colorB;

	if (smallID == "outer") then
		Lunar.Sphere:SetOuterGaugeColor();
	else
		Lunar.Sphere:SetInnerGaugeColor();
	end

	if (_G["LSSettings" .. smallID .. "GaugeColor" .. "Color"]) then
		_G["LSSettings" .. smallID .. "GaugeColor" .. "Color"]:SetColorTexture(colorR, colorG, colorB);
	end
]]--
	dataTracking["gauge" .. gaugeID .. "Start"] = nil;
	dataTracking["animate" .. gaugeID] = nil;

	if ((eventType == LS_EVENT_POWER) or (LS_EVENT_FIVE)) then
		dataTracking.playerMana = UnitPower("player", 0);
	end

	LunarSphereSettings[smallID .. "GaugeTypeID"] = specificID;

	Lunar.Sphere:UpdateGauge(gaugeID);
end

function Lunar.Sphere:UpdateGauge(gaugeType)

	local max = math.max;
	local spherePercent = 0;
	local checkType, checkTypeID, gaugeHalf, gaugeCover, gauge, gaugeStart, gaugeAnimate, dir, angle;

	if (gaugeType == "Inner") and (LunarSphereSettings.showInner ~= true)  then
		return;
	end
	if (gaugeType == "Outer") and (LunarSphereSettings.showOuter ~= true)  then
		return;
	end
	if (LunarSphereSettings.sphereAlpha == 0) then
		return;
	end

	if (gaugeType == "Inner") then
		gaugeHalf = sphereData.gaugeInnerHalf;
		gaugeCover = sphereData.gaugeInnerCover;
		gauge = sphereData.gaugeInner;
		checkType = LunarSphereSettings.innerGaugeType;
		checkTypeID = LunarSphereSettings.innerGaugeTypeID;
		gaugeStart = dataTracking.gaugeInnerStart;
		gaugeAnimate = LunarSphereSettings.innerGaugeAnimate;
		dir = -1 * (LunarSphereSettings.innerGaugeDirection or (-1));
		angle = 180 - (dir + 1) * 90 + LunarSphereSettings.innerGaugeAngle - 90;
	elseif (gaugeType == "Outer") then
		gaugeHalf = sphereData.gaugeOuterHalf;
		gaugeCover = sphereData.gaugeOuterCover;
		gauge = sphereData.gaugeOuter;
		checkType = LunarSphereSettings.outerGaugeType;
		checkTypeID = LunarSphereSettings.outerGaugeTypeID;
		gaugeStart = dataTracking.gaugeOuterStart;
		gaugeAnimate = LunarSphereSettings.outerGaugeAnimate;
		dir = -1 * (LunarSphereSettings.outerGaugeDirection or (-1));
		angle = 180 - (dir + 1) * 90 + LunarSphereSettings.outerGaugeAngle - 90;
	else
		return;
	end

	if (checkType == LS_EVENT_POWER) then --or (checkType == "energy") or (checkType == "rage"))   then
		if UnitPowerMax("player") > 0 then
			spherePercent =	UnitPower("player") / UnitPowerMax("player") * 100;
		else
			spherePercent = 0;
		end
	elseif (checkType == LS_EVENT_EXTRA_POWER) then
		local _, playerClass = UnitClass("player");
		local powerToTrack = dataTracking.extraPowerType[playerClass];
		-- Combo points
		if (powerToTrack == -1) then
			spherePercent =	GetComboPoints("player") / 5 * 100;
		-- Everything else
		elseif (powerToTrack ~= 0) then
			if UnitPowerMax("player", powerToTrack) > 0 then
				spherePercent = UnitPower("player", powerToTrack) / UnitPowerMax("player", powerToTrack) * 100;
			else
				spherePercent = 0;
			end
		else
			spherePercent = 0;
		end
	elseif (checkType == LS_EVENT_HEALTH) then
		if UnitHealthMax("player") > 0 then
			spherePercent =	UnitHealth("player") / UnitHealthMax("player") * 100;
		else
			spherePercent = 0;
		end
	elseif (checkType == LS_EVENT_T_POWER) then
		if UnitPowerMax("target") > 0 then
			spherePercent =	UnitPower("target") / UnitPowerMax("target") * 100;
		else
			spherePercent = 0;
		end
	elseif (checkType == LS_EVENT_T_HEALTH) then
		if UnitHealthMax("target") > 0 then
			spherePercent =	UnitHealth("target") / UnitHealthMax("target") * 100;
		else
			spherePercent = 0;
		end
	elseif (checkType == LS_EVENT_COMBO) then
-- Lunar.API:Print("LS_EVENT_COMBO   " .. UnitPower("player").. "   " .. UnitPowerMax("player", COMBO_POINTS)); -- Here Again
--		spherePercent =	GetComboPoints("player") / 5 * 100;
		spherePercent = (UnitPower("player") / UnitPowerMax("player", COMBO_POINTS)) * 100;
	elseif (checkType == LS_EVENT_FIVE) then
		local checkMana = UnitPower("player");
		gaugeStart = nil;
		if (checkMana < dataTracking.playerMana) then
			dataTracking.playerMana = checkMana;
			dataTracking.fiveSec = 5;
			gaugeStart = nil;
		end
		spherePercent = 100 - (dataTracking.fiveSec / 5) * 100;
		if (spherePercent > 100) then
			spherePercent = 100;
		end
	elseif ((checkType == LS_EVENT_EXP) or (checkType == LS_EVENT_REP) or (checkType == LS_EVENT_P_EXP)) then
		local currentValue, valueMax = 0, 1;
		if (checkType == LS_EVENT_EXP) then
			currentValue = UnitXP("player");
			valueMax = max(UnitXPMax("player"), 1);
		elseif (checkType == LS_EVENT_P_EXP) then
			currentValue, valueMax = GetPetExperience();
			if (valueMax == 0) then
				valueMax = 1;
			end
		else
			local name, reaction, min, max, value = GetWatchedFactionInfo();
			if (name) then
				valueMax = max - min;
				currentValue = value - min;
			end
		end
		if (checkTypeID == 1) then
			local bubbleSize = math.floor(valueMax / 20)
			local currentBubble = currentValue - math.floor(currentValue / bubbleSize) * bubbleSize;
			spherePercent = currentBubble / bubbleSize * 100
		else
			spherePercent = currentValue / valueMax * 100
		end
	end

	if (gaugeAnimate) then
		if (gaugeStart == nil) then
			gaugeStart = spherePercent;
		end
		dataTracking["animate" .. gaugeType] = true;
		if (gaugeStart > spherePercent) then
			gaugeStart = gaugeStart - math.ceil((gaugeStart - spherePercent) / 4);
			if (gaugeStart <= spherePercent) then
				gaugeStart = spherePercent;
				dataTracking["animate" .. gaugeType] = false;
			end
		else
			gaugeStart = gaugeStart + math.ceil((spherePercent - gaugeStart) / 4);
			if (gaugeStart >= spherePercent) then
				gaugeStart = spherePercent;
				dataTracking["animate" .. gaugeType] = false;
			end
		end
		spherePercent = gaugeStart;
		dataTracking["gauge" .. gaugeType .. "Start"] = gaugeStart;
	end

	if (spherePercent > 100) then
		spherePercent = 100;
	end

	if (spherePercent <= 0) then
		gaugeHalf:Hide();
		gaugeHalf:SetID(0);
		gaugeCover:Show();
		gauge:SetAlpha(0);
	end

	if (spherePercent > 0) then
		if ((spherePercent >= 50) and (gaugeHalf:GetID() ~= 1)) then
			gaugeHalf:Show();
			gaugeHalf:SetID(1);
			gaugeCover:Hide();
		elseif ((spherePercent < 50) and (gaugeHalf:GetID() == 1)) then
			gaugeHalf:Hide();
			gaugeHalf:SetID(0);
			gaugeCover:Show();
		end
		gauge:SetAlpha(1);
	else
		gauge:SetAlpha(0);
	end

--	local newAngle = (math.floor(spherePercent * dir * 3.6) + angle)

	Lunar.API:RotateTexture(gauge:GetNormalTexture(), (math.floor(spherePercent * dir * 3.6) + angle), 0.5, 0.5)
end

function Lunar.Sphere:UpdateSphere()

	local sphereText = "";
	local checkType, checkTypeID;
	local showAsPercent = LunarSphereSettings.useSphereTextPercentage;

	checkType = LunarSphereSettings.sphereTextType;
	checkTypeID = LunarSphereSettings.sphereTextTypeID;

	if (checkType == LS_EVENT_SPHERE_COUNT) or (checkType == LS_EVENT_SPHERE_COOLDOWN) then
		return;
	end

	if (checkType == LS_EVENT_POWER) then --or (checkType == "energy") or (checkType == "rage"))   then
		if (checkTypeID == 1) then
			sphereText = UnitPower("player");
		else
			if UnitPowerMax("player") > 0 then
				if (showAsPercent) then
					sphereText = math.floor(UnitPower("player") / UnitPowerMax("player") * 100) .. LunarSphereSettings.sphereTextEnd;
				else
					sphereText = UnitPower("player");
				end
			else
				sphereText = "0";
			end
		end
	elseif (checkType == LS_EVENT_EXTRA_POWER) then
		local _, playerClass = UnitClass("player");
		local powerToTrack = dataTracking.extraPowerType[playerClass];
		-- Combo points
		if (powerToTrack == -1) then
			if (showAsPercent) then
				sphereText = math.floor(GetComboPoints("player") / 5 * 100) .. LunarSphereSettings.sphereTextEnd;
			else
				sphereText = GetComboPoints("player");
			end
		-- Everything else
		elseif (powerToTrack ~= 0) then
			if UnitPowerMax("player", powerToTrack) > 0 then
				if (showAsPercent) then
					sphereText = math.floor(UnitPower("player", powerToTrack) / UnitPowerMax("player", powerToTrack) * 100) .. LunarSphereSettings.sphereTextEnd;
				else
					sphereText = UnitPower("player", powerToTrack);
				end
			else
				sphereText = "0";
			end
		else
			sphereText = "0";
		end
	elseif (checkType == LS_EVENT_HEALTH) then
		if (showAsPercent) then
			sphereText = math.floor(UnitHealth("player") / UnitHealthMax("player") * 100) .. LunarSphereSettings.sphereTextEnd;
		else
			sphereText = UnitHealth("player");
		end
	elseif (checkType == LS_EVENT_COMBO) then
		if (showAsPercent) then
--			sphereText = math.floor(GetComboPoints("player") / 5 * 100) .. LunarSphereSettings.sphereTextEnd;
			sphereText = math.floor(GetComboPoints("player") / UnitPowerMax("player") * 100) .. LunarSphereSettings.sphereTextEnd;
		else
			sphereText = GetComboPoints("player");
		end
	elseif (checkType == LS_EVENT_FIVE) then
		local checkMana = UnitPower("player");
		if (checkMana < dataTracking.playerMana) then
			dataTracking.playerMana = checkMana;
			dataTracking.fiveSec = 5;
		end
		if (dataTracking.fiveSec > 0) then
			local found, _, number1, number2 = string.find(tostring(dataTracking.fiveSec), "(%d).(%d)")
			if (dataTracking.fiveSec == 5) then
				number1, number2 = 5, 0;
			else
				if (number1 == nil) then
					number1 = 0;
				end
				if (number2 == nil) then
					number2 = 0;
				end
			end
			sphereText = number1 .. "." .. number2;
		end
	elseif ((checkType == LS_EVENT_EXP) or (checkType == LS_EVENT_REP) or (checkType == LS_EVENT_P_EXP)) then
		local currentValue, valueMax = 0, 1;
		if (checkType == LS_EVENT_EXP) then
			currentValue = UnitXP("player");
			valueMax = UnitXPMax("player");
		elseif (checkType == LS_EVENT_P_EXP) then
			currentValue, valueMax = GetPetExperience();
			if (valueMax == 0) then
				valueMax = 1;
			end
		else
			local name, reaction, min, max, value = GetWatchedFactionInfo();
			if (name) then
				valueMax = max - min;
				currentValue = value - min;
			end
		end

		if (checkTypeID == 1) then
			local bubbleSize = math.floor(valueMax / 20)
			local currentBubble = currentValue - math.floor(currentValue / bubbleSize) * bubbleSize;
--[[			local found, _, number1, number2 = string.find(tostring(currentBubble / bubbleSize), "(%d).(%d)")
			if (number1 == nil) then
				number1 = 0;
			end
			if (number2 == nil) then
				number2 = 0;
			end
--			LunarSkin_ChatPrint(currentValue .. " " .. bubbleSize);
			sphereText = tostring(math.floor(currentBubble / bubbleSize)) .. "." .. number2;
--]]			sphereText = string.format("%.1f%s", (currentBubble / bubbleSize * 100 - 0.05), LunarSphereSettings.sphereTextEnd);
		else
--[[			local found, _, number1, number2 = string.find(tostring(currentValue / valueMax * 100), "(%d).(%d)")
			if (number1 == nil) then
				number1 = 0;
			end
			if (number2 == nil) then
				number2 = 0;
			end
			sphereText = math.floor(currentValue / valueMax * 100) .. "." .. number2 .. LunarSphereSettings.sphereTextEnd;
			number1 = (currentValue / valueMax * 100 - 0.05)
--]]
			number1 = (currentValue / valueMax * 100 - 0.05);
			if (number1 < 0) then number1 = 0; end;
			sphereText = string.format("%.1f%s", number1, LunarSphereSettings.sphereTextEnd);

		end

--/script Lunar.API:Print(tostring(19110/21000*100));
--/script Lunar.API:Print(string.format("%.1f%s", (0 / 21000 * 100), "%"));
	elseif (checkType == LS_EVENT_AMMO) then
		local slotID = GetInventorySlotInfo("AmmoSlot");
		local ammoCount = GetInventoryItemCount("player", slotID);
		if ((ammoCount == 1) and (not GetInventoryItemTexture("player", slotID))) then
		    ammoCount = 0;
		end
		sphereText = tostring(ammoCount);
	end

	-- Only update the text in the sphere if it is different (saves on memory usage)
	Lunar.Sphere:SetSphereText(sphereText);
end

function Lunar.Sphere:UpdateDefaultColors(objectType)

	if (LunarSphereSettings[objectType .. "Type"] == LS_EVENT_POWER) then
		LunarSphereSettings.gaugeColor[dataTracking.powerName[dataTracking.powerType]][4] = true;
		LunarSphereSettings.gaugeColor[dataTracking.powerName[dataTracking.powerType]][5] = LunarSphereSettings[objectType .. "Color"][1]
		LunarSphereSettings.gaugeColor[dataTracking.powerName[dataTracking.powerType]][6] = LunarSphereSettings[objectType .. "Color"][2]
		LunarSphereSettings.gaugeColor[dataTracking.powerName[dataTracking.powerType]][7] = LunarSphereSettings[objectType .. "Color"][3]
	else
		LunarSphereSettings.gaugeColor[LunarSphereSettings[objectType .. "Type"]][4] = true;
		LunarSphereSettings.gaugeColor[LunarSphereSettings[objectType .. "Type"]][5] = LunarSphereSettings[objectType .. "Color"][1]
		LunarSphereSettings.gaugeColor[LunarSphereSettings[objectType .. "Type"]][6] = LunarSphereSettings[objectType .. "Color"][2]
		LunarSphereSettings.gaugeColor[LunarSphereSettings[objectType .. "Type"]][7] = LunarSphereSettings[objectType .. "Color"][3]
	end
end

function Lunar.Sphere:UpdateSkin(skinType, filename)

	local skinID = LunarSphereSettings[skinType] or (1);
	if (skinType == "gaugeFill") then
		if not filename then
			if (skinID <= Lunar.includedGauges) then
				filename = LUNAR_ART_PATH .. skinType .. "_" .. skinID;
			else
				local artFilename = select(5, Lunar.API:GetArtByCatagoryIndex("gauge", skinID - Lunar.includedGauges));
				if (artFilename) then
					filename = LUNAR_IMPORT_PATH .. artFilename;
				end
			end
		end
		sphereData.gaugeOuter:SetNormalTexture(filename);
		sphereData.gaugeOuterHalf:SetNormalTexture(filename);
		sphereData.gaugeOuterCover:SetNormalTexture(filename);
		sphereData.gaugeOuterBottom:SetNormalTexture(filename);
		sphereData.gaugeOuterBottom2:SetNormalTexture(filename);
		sphereData.gaugeInner:SetNormalTexture(filename);
		sphereData.gaugeInnerHalf:SetNormalTexture(filename);
		sphereData.gaugeInnerCover:SetNormalTexture(filename);
		sphereData.gaugeInnerBottom:SetNormalTexture(filename);
		sphereData.gaugeInnerBottom2:SetNormalTexture(filename);

		local innerDir = -1 * (LunarSphereSettings.innerGaugeDirection or (-1));
		local outerDir = -1 * (LunarSphereSettings.outerGaugeDirection or (-1));
		local innerAngle = LunarSphereSettings.innerGaugeAngle - 90;
		local outerAngle = LunarSphereSettings.outerGaugeAngle - 90;

		Lunar.API:RotateTexture(sphereData.gaugeOuterHalf:GetNormalTexture(), (outerDir + 1) * 90 + outerAngle, 0.5, 0.5)
		Lunar.API:RotateTexture(sphereData.gaugeOuterBottom:GetNormalTexture(), (outerDir + 1) * 90 + outerAngle, 0.5, 0.5)
		Lunar.API:RotateTexture(sphereData.gaugeInnerHalf:GetNormalTexture(), (innerDir + 1) * 90 + innerAngle, 0.5, 0.5)
		Lunar.API:RotateTexture(sphereData.gaugeInnerBottom:GetNormalTexture(), (innerDir + 1) * 90 + innerAngle, 0.5, 0.5)
		Lunar.API:RotateTexture(sphereData.gaugeOuterCover:GetNormalTexture(), (outerDir - 1) * 90 + outerAngle, 0.5, 0.5)
		Lunar.API:RotateTexture(sphereData.gaugeOuterBottom2:GetNormalTexture(), (outerDir - 1) * 90 + outerAngle, 0.5, 0.5)
		Lunar.API:RotateTexture(sphereData.gaugeInnerCover:GetNormalTexture(), (innerDir - 1) * 90 + innerAngle, 0.5, 0.5)

		Lunar.API:RotateTexture(sphereData.gaugeInnerBottom2:GetNormalTexture(), (innerDir - 1) * 90 + innerAngle, 0.5, 0.5)
		Lunar.API:RotateTexture(sphereData.gaugeOuterMarks:GetNormalTexture(), (outerDir - 1) * 90 + outerAngle, 0.5, 0.5)
		Lunar.API:RotateTexture(sphereData.gaugeInnerMarks:GetNormalTexture(), (innerDir - 1) * 90 + innerAngle, 0.5, 0.5)
		Lunar.Sphere:UpdateGauge("Inner")
		Lunar.Sphere:UpdateGauge("Outer")
	else
		if (skinType) then
			if not filename then
				if (skinID <= Lunar.includedBorders) then
					filename = LUNAR_ART_PATH .. skinType .. "_" .. skinID;
				else
					local artFilename = select(5, Lunar.API:GetArtByCatagoryIndex("border", skinID - Lunar.includedBorders));
					if (artFilename) then
						filename = LUNAR_IMPORT_PATH .. artFilename;
					end
				end
			end
			sphereData.sphereBorder:SetNormalTexture(filename);
			sphereData.gaugeOuterBorder:SetNormalTexture(filename);
			sphereData.gaugeInnerBorder:SetNormalTexture(filename);
		end
		local r, g, b = unpack(LunarSphereSettings.gaugeBorderColor);
		sphereData.sphereBorder:GetNormalTexture():SetVertexColor(r,g,b,1);
		sphereData.gaugeOuterBorder:GetNormalTexture():SetVertexColor(r,g,b,1);
		sphereData.gaugeInnerBorder:GetNormalTexture():SetVertexColor(r,g,b,1);
	end
end

function Lunar.Sphere:UpdateGaugeColors()

	local loopCount, colorIndex, checkType;
	local gaugeName = "outer";
	local gaugeNameUpper = "Outer";

	for loopCount = 1, 2 do 
		colorIndex = 0;
		checkType = LunarSphereSettings[gaugeName .. "GaugeType"];

		if (checkType == LS_EVENT_POWER) then
			checkType = dataTracking.powerName[dataTracking.powerType];
		end

		if (LunarSphereSettings.gaugeColor[checkType][4] == true) then
			colorIndex = 4;
		end
		LunarSphereSettings[gaugeName .. "GaugeColor"][1] = LunarSphereSettings.gaugeColor[checkType][colorIndex + 1];
		LunarSphereSettings[gaugeName .. "GaugeColor"][2] = LunarSphereSettings.gaugeColor[checkType][colorIndex + 2];
		LunarSphereSettings[gaugeName .. "GaugeColor"][3] = LunarSphereSettings.gaugeColor[checkType][colorIndex + 3];

		if (_G["LSSettings" .. gaugeName .. "GaugeColor" .. "Color"]) then
			_G["LSSettings" .. gaugeName .. "GaugeColor" .. "Color"]:SetColorTexture(
				LunarSphereSettings[gaugeName .. "GaugeColor"][1],
				LunarSphereSettings[gaugeName .. "GaugeColor"][2],
				LunarSphereSettings[gaugeName .. "GaugeColor"][3]);
		end
		
		gaugeName = "inner";
		gaugeNameUpper = "Inner";
	end

	Lunar.Sphere:SetOuterGaugeColor();
	Lunar.Sphere:SetInnerGaugeColor();
end

function Lunar.Sphere:ToggleSphere(alpha)

	alpha = alpha or 1;
	LunarSphereSettings.sphereAlpha = alpha;
	
	sphereData.sphereTexture:SetAlpha(alpha);
	sphereData.sphereTexture2:SetAlpha(alpha);
	sphereData.sphereBorder:SetAlpha(alpha);
	sphereData.sphereShine:SetAlpha(alpha);
	sphereData.background:SetAlpha(alpha);
	sphereData.combatGlow:SetAlpha(alpha);
	sphereData.overlay:SetAlpha(alpha);

	if (alpha == 1) then
		Lunar.Sphere:ShowInnerGauge(LunarSphereSettings.showInner);
		Lunar.Sphere:ShowOuterGauge(LunarSphereSettings.showOuter);
		Lunar.Sphere:UpdateGauge("Inner");
		Lunar.Sphere:UpdateGauge("Outer");
		Lunar.Sphere:UpdateSphere();
	else
		local temp1 = LunarSphereSettings.showInner;
		local temp2 = LunarSphereSettings.showOuter;
		Lunar.Sphere:ShowInnerGauge(false);
		Lunar.Sphere:ShowOuterGauge(false);
		LunarSphereSettings.showInner = temp1;
		LunarSphereSettings.showOuter = temp2;
	end

--[[
	sphereData.gaugeInner:SetAlpha(alpha);
	sphereData.gaugeInnerHalf:SetAlpha(alpha);
	sphereData.gaugeInnerBottom:SetAlpha(alpha);
	sphereData.gaugeInnerBottom2:SetAlpha(alpha);
	sphereData.gaugeInnerCover:SetAlpha(alpha);
	sphereData.gaugeInnerBorder:SetAlpha(alpha);

	sphereData.gaugeOuter:SetAlpha(alpha);
	sphereData.gaugeOuterHalf:SetAlpha(alpha);
	sphereData.gaugeOuterBottom:SetAlpha(alpha);
	sphereData.gaugeOuterBottom2:SetAlpha(alpha);
	sphereData.gaugeOuterCover:SetAlpha(alpha);
	sphereData.gaugeOuterBorder:SetAlpha(alpha);
--]]
	if (alpha == 1) then
		sphereData.main:EnableMouse(true)
	else
		sphereData.main:EnableMouse(false)
	end
end

function Lunar.Sphere:ToggleAll(show)
	LunarSphereSettings.toggleAll = show;
	if (show == 1) then
		sphereData.main:Show();
		_G["LunarSphereButtonHeader"]:Show();
	else
		sphereData.main:Hide();
		_G["LunarSphereButtonHeader"]:Hide();
	end
end

function Lunar.Sphere.UpdateMacroEvent()

	-- Since this can fire before the button code is finished loading, check if
	-- the button code finished loading. If it hasn't, we ignore this code.
	-- If it has, run the code and then update this function to never do the
	-- check again, to increase performance.

	if (Lunar.Button.updateCounterFrame) then
		Lunar.Button.updateCounterFrame.elapsed = 0.2
		sphereData.main.updateIcon = true;

		Lunar.Sphere.UpdateMacroEvent = function ()
			Lunar.Button.updateCounterFrame.elapsed = 0.2
			sphereData.main.updateIcon = true;
		end
	end
end

function Lunar.Sphere.UpdateCurrentCast()

	-- Since this can fire before the button code is finished loading, check if
	-- the button code finished loading. If it hasn't, we ignore this code.
	-- If it has, run the code and then update this function to never do the
	-- check again, to increase performance.

	if (Lunar.Button.updateCounterFrame) then
		Lunar.Button.updateCounterFrame.updateCurrentCast = 0;
		Lunar.Sphere.UpdateCurrentCast = function ()
			Lunar.Button.updateCounterFrame.updateCurrentCast = 0;
		end
	end
end

function Lunar.Sphere.Events(self, event, arg1, arg2)

	if (event == sphereData.sphereEvent) or (event == sphereData.InnerEvent) or (event == sphereData.OuterEvent) or (event == "PLAYER_TARGET_CHANGED") then

--		if ((arg1 == self.source) or (event == "PLAYER_XP_UPDATE") or (event == "UNIT_COMBO_POINTS") or (event == "UPDATE_FACTION") or (event == "PLAYER_TARGET_CHANGED")) then
		if ((arg1 == self.source) or (event == "PLAYER_XP_UPDATE") or (event == "UNIT_POWER_UPDATE") or (event == "UPDATE_FACTION") or (event == "PLAYER_TARGET_CHANGED")) then
			local gaugeType = "sphere";
			if (self == sphereData.gaugeOuterBorder) then
				gaugeType = "Outer";
			elseif (self == sphereData.gaugeInnerBorder) then
				gaugeType = "Inner";
			end

			-- If the mana went down, update the mana tracking for the 5 second timer

			if ((event == "UNIT_MANA") and (self.source == "player") and (dataTracking.powerType == 0) ) then
				if (dataTracking.playerMana < UnitPower("player")) then
					dataTracking.playerMana = UnitPower("player");
				end
			end

--			if ((arg1 == "player") or (event == "PLAYER_COMBO_POINTS") or (event == "UPDATE_FACTION") or (event == "PLAYER_TARGET_CHANGED") ) then
			if (gaugeType ~= "sphere") then
				Lunar.Sphere:UpdateGauge(gaugeType);
			else
				Lunar.Sphere:UpdateSphere();
			end
--			end
		end
		return;
	end

--	if ((arg1 == "player") or (event == "PLAYER_COMBO_POINTS") or (event == "UPDATE_FACTION") or (event == "PLAYER_TARGET_CHANGED")) then
--		if (gaugeType ~= "sphere") then
--			Lunar.Sphere:UpdateGauge(gaugeType);
--		else
--			Lunar.Sphere:UpdateSphere();
--		end
--		return;
--	end

-- LAG ISSUE (update state, called multiple times, I need a throttle here and in buttons)
	if (event == "MODIFIER_STATE_CHANGED") or (event == "PLAYER_AURAS_CHANGED") or (event == "ACTIONBAR_UPDATE_STATE") or (event == "ACTIONBAR_SLOT_CHANGED") then
--		local actionType;
--		_,actionType = Lunar.Button:GetButtonData(0, _G["LSmain"].currentStance, Lunar.Button:GetButtonSetting(0, _G["LSmain"].currentStance, LUNAR_GET_SHOW_ICON));
		if (sphereData.main.actionType == "macro") then
			Lunar.Sphere.UpdateMacroEvent();
		end
		if (Lunar.Button.currentMouseOver == 0) then
			Lunar.Button:SetTooltip(_G["LSmain"]);
		end
		return;
	end

	if (event == "CURRENT_SPELL_CAST_CHANGED") then
		Lunar.Sphere.UpdateCurrentCast();
		return;
	end

	if (event == "UNIT_INVENTORY_CHANGED") or (event == "BAG_UPDATE") then
--		if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COUNT) then
			Lunar.Button:UpdateCount(self);
--		end
		return;
	end

	if (event == "SPELL_UPDATE_COOLDOWN") or (event == "BAG_UPDATE_COOLDOWN" ) then
--		if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COOLDOWN) then
			Lunar.Button.UpdateCooldown(self, nil);
--		end
		return;
	end

--
--==
--==
--

--	if (event == "UNIT_PORTRAIT_UPDATE") then
--		Lunar.Sphere:UpdateGauge("Inner");
--		Lunar.Sphere:UpdateGauge("Outer");
--		Lunar.Sphere:UpdateSphere();
--		return;
--	end

	if ((event == "UNIT_PET") and (arg1 == "player"))  then
--		if (GetPetExperience() == 0) then
			Lunar.Sphere:UpdateGauge("Inner");
			Lunar.Sphere:UpdateGauge("Outer");
			Lunar.Sphere:UpdateSphere();
--		end
		return;
	end

	if ((event == "CURSOR_UPDATE") or (event == "ITEM_LOCK_CHANGED") or (event == "ACTIONBAR_SHOWGRID")) then
		local cursorType, objectID, objectData = GetCursorInfo();
		local index, button;

		if ((cursorType) and (not Lunar.Button.updateType)) then

			Lunar.Button:ShowEmptyMenuButtons();
			Lunar.Button.updateType, Lunar.Button.updateID, Lunar.Button.updateData = GetCursorInfo();

			-- Add Cursor Update event to deal with "Dropping item into same bag
			-- slot doesn't hide buttons" bug
			sphereData.background:RegisterEvent("CURSOR_UPDATE");

		elseif (not cursorType) then
				
			Lunar.Button:HideEmptyMenuButtons();

			-- Remove Cursor Update event that dealt with "Dropping item into
			-- same bag slot doesn't hide buttons" bug.
			sphereData.background:UnregisterEvent("CURSOR_UPDATE");

			if (Lunar.Button.currentMouseOver) and ((LunarSphereSettings.buttonEditMode == true) or (LunarSphereSettings.forceDragDrop == true)) then
				if (IsMouseButtonDown("RightButton") )then
					self:SetAttribute("type-S02", "spell");
					self:SetAttribute("spell-S02", "");
					self:SetAttribute("item-S02", "");
					self:SetAttribute("macro-S02", "");
					if (Lunar.Button.currentMouseOver > 10) then
						Lunar.Button.updateButton = _G["LunarSub" .. Lunar.Button.currentMouseOver .. "Button"];
					elseif (Lunar.Button.currentMouseOver == 0) then
						Lunar.Button.updateButton = _G["LSmain"];
					else						
						Lunar.Button.updateButton = _G["LunarMenu" .. Lunar.Button.currentMouseOver .. "Button"];
					end
					Lunar.Button:Assign(Lunar.Button.updateButton, 2);
				end
				Lunar.Button.currentMouseOver = nil;
			end
			Lunar.Button.updateType = nil;
		end

		return;
	end

--	if ( event == "UNIT_INVENTORY_CHANGED" ) then
--		if ( arg1 == "player" ) then
--			ActionButton_Update();
--		end
--		return;
--	end

	if (event == "ACTIONBAR_HIDEGRID") then
		Lunar.Button:HideEmptyMenuButtons();
		return;
	end

	if (event == "PLAYER_REGEN_DISABLED") then
--		Lunar.Button.hiddenButtons = nil;
		Lunar.combatLockdown = true;
		if (LunarSphereSettings.buttonEditMode == true) then
			Lunar.Button:HideEmptyMenuButtons();
		end
		-- ISSUE?
		Lunar.Settings.ButtonDialog:Hide();
		Lunar.Sphere:ShowSphereEditGlow(LunarSphereSettings.showSphereEditGlow);
--		Lunar.Button:CheckVisibilityOptions()
		sphereData.combatGlow:Show();
		sphereData.combatGlow:GetNormalTexture():SetVertexColor(1,0,0,1);
--		Lunar.Settings:EnableHideUI(false);
		return;
	end

	if (event == "PLAYER_REGEN_ENABLED") then
		Lunar.combatLockdown = false;
		sphereData.combatGlow:Hide();
--		Lunar.Button.hiddenButtons = nil;
		Lunar.Sphere:ShowSphereEditGlow(LunarSphereSettings.showSphereEditGlow);
--		Lunar.Button:CheckVisibilityOptions()
		if (Lunar.Items.combatUpdate == true) then
			Lunar.Sphere.combatUpdate = true;
			Lunar.Items.combatUpdate = false;
		end

		local buttonID, menuButton
		for buttonID = 1, 10 do
			menuButton = _G["LunarMenu" .. buttonID .. "Button"]
			if (menuButton.useLastSubmenu == true) then
				if (menuButton.childID) then
					Lunar.Button:UpdateLastUsedSubmenu(menuButton, _G["LunarSub" .. menuButton.childID .. "Button"], menuButton.clickType);
				end
				if (menuButton.childID2) then
					Lunar.Button:UpdateLastUsedSubmenu(menuButton, _G["LunarSub" .. menuButton.childID2 .. "Button"], menuButton.clickType2, 4);
				end
--				Lunar.Button:UpdateLastUsedSubmenu(
--					_G["LunarMenu" .. buttonID .. "Button"], 
--					_G["LunarSub" .. (_G["LunarMenu" .. buttonID .. "Button"].childID2) .. "Button"),
--					_G["LunarMenu" .. buttonID .. "Button"].clickType2, 4);
			end
		end
		Lunar.Settings:EnableHideUI(true);
		return;
	end

	if (event == "UPDATE_SHAPESHIFT_FORM") then
		dataTracking.powerType = UnitPowerType("player");
		Lunar.Sphere:SetOuterGaugeType(LunarSphereSettings.outerGaugeType)
		Lunar.Sphere:SetInnerGaugeType(LunarSphereSettings.innerGaugeType)
		Lunar.Sphere:SetSphereTextType(LunarSphereSettings.sphereTextType)
		-- Also fires on warrior stance change and rogue's stealth...
		return;
	end

--	if (event == "PLAYER_AURAS_CHANGED") then
		-- Trying to decide what I can use this for. Shadowform or aspect changing...
--		return;
--	end
--==
	if (event == "PLAYER_ENTERING_WORLD") or (event == "ZONE_CHANGED_NEW_AREA") then --or ("ZONE_CHANGED")
		if (_G["LunarMenu1Button"]) then
			Lunar.Items:UpdateLowHighItems();
			--SetMapToCurrentZone();
		end
	end

	if ((event == "BAG_CLOSED") and (arg1 > 0) and (arg1 <= 4)) then
		local index;
		local stance = GetShapeshiftForm();
		for index = 1, 130 do 
			if (Lunar.Button:GetButtonType(index, stance, 1) == (90 + arg1)) then
				if (index > 10) then
					SetPortraitToTexture(_G["LunarSub" .. index .. "ButtonIcon"], _G["CharacterBag" .. (arg1 - 1) .. "SlotIconTexture"]:GetTexture());
					_G["LunarSub" .. index .. "ButtonIcon"]:SetVertexColor(1.0, 1.0, 1.0);
					_G["LunarSub" .. index .. "ButtonIcon"]:SetAlpha(1);
				else
					SetPortraitToTexture(_G["LunarMenu" .. index .. "ButtonIcon"], _G["CharacterBag" .. (arg1 - 1) .. "SlotIconTexture"]:GetTexture());
					_G["LunarMenu" .. index .. "ButtonIcon"]:SetVertexColor(1.0, 1.0, 1.0);
					_G["LunarMenu" .. index .. "ButtonIcon"]:SetAlpha(1);
				end
			end
		end

		return;
	end

	if (event == "TRADE_SHOW") then
		Lunar.Button.tradingStage = 2;
		self:UnregisterEvent("TRADE_SHOW");
		return;
	end
	if (event == "TRADE_CLOSED") or (event == "TRADE_REQUEST_CANCEL") then
		if (Lunar.Button.tradingStage == 0) then
			self:RegisterEvent("TRADE_SHOW");
			Lunar.tradingStage = 1;
			InitiateTrade("target");
		else
			Lunar.Button.tradingStage = nil;
			self:UnregisterEvent("TRADE_CLOSED");
			self:UnregisterEvent("TRADE_REQUEST_CANCEL");
			self:UnregisterEvent("CHAT_MSG_SYSTEM");
		end
		return;
	end

	if (event == "MERCHANT_SHOW") then

		-- If we're to repair our stuff, do so
		if not (LunarSphereSettings.memoryDisableRepairs) then

			if (LunarSphereSettings.autoRepair) then
				-- Repair and get our bill
				local repairBill = Lunar.API:RepairInventory(LunarSphereSettings.printRepairBill);

				-- If the bill exists ...
				if (repairBill) then
					
					-- Add it to the log. If the log is currently open, update it's contents
					Lunar.Settings:AddToRepairLog(repairBill);
-- ISSUE?
					if (Lunar.Settings.RepairLogDialog:IsShown()) then
						Lunar.Settings.RepairLogDialog:Hide();
						Lunar.Settings.RepairLogDialog:Show();
					end
				end
			end
		end

		if not (LunarSphereSettings.memoryDisableJunk) then

			-- If we're to sell our junk, do so
			if (LunarSphereSettings.autoSellJunk) then
				Lunar.API:SellJunkItems(LunarSphereSettings.keepNonEquip, LunarSphereSettings.keepArmor, LunarSphereSettings.keepWeapons, LunarSphereSettings.printJunkProfit);
			end
		end

		if not (LunarSphereSettings.memoryDisableReagents) then

			-- If we're to buy reagents, do so
			if (LunarSphereSettings.autoReagents == true) then
				Lunar.API.isBanker = nil;
				Lunar.API.isGuildBanker = nil;
				Lunar.API:RestockReagents(LunarSphereSettings.printReagentPurchase);
			end

		end
		return;
	end

	if (event == "BANKFRAME_OPENED") then
		if not (LunarSphereSettings.memoryDisableReagents) then

			-- If we're to grab reagents from the bank, do so
			if (LunarSphereSettings.autoReagentsBank == true) then
				Lunar.API.isBanker = true;
				Lunar.API.isGuildBanker = nil;
				Lunar.API:RestockReagents(LunarSphereSettings.printReagentPurchase);
			end

		end
	elseif (event == "GUILDBANKFRAME_OPENED") then
		if not (LunarSphereSettings.memoryDisableReagents) then

			-- If we're to grab reagents from the guild bank, do so
			if (LunarSphereSettings.autoReagentsGuildBank == true) then
				Lunar.API.isBanker = true;
				Lunar.API.isGuildBanker = true;
				Lunar.API:RestockReagents(LunarSphereSettings.printReagentPurchase);
			end
		end
	end

	-- If a gossip screen appeared, let's handle it
	if (event == "GOSSIP_SHOW") then

		-- If we made the frame hidden in the past, make sure it's visible again
		GossipFrame:SetAlpha(1);

		-- If we're supposed to skip gossips, continue
		if (LunarSphereSettings.skipGossip) then

			-- Grab the type of gossip we have. If it is a banker, battlemaster, taxi, or vendor,
			-- we'll skip the gossip. Anything else, we'll leave be, since we might want to select a different option
			local _, gossipType, _, moreGossip = GetGossipOptions()

			if ((((gossipType == "banker") or (gossipType == "battlemaster") or (gossipType == "taxi") or (gossipType == "vendor")) and (not moreGossip)) or (gossipType == "trainer" and (not moreGossip))) then

				-- Next, check to see if the vendor has quests. If they don't we continue
				if (not GetGossipAvailableQuests() and not GetGossipActiveQuests()) then

					-- We set the frame's alpha to 0 so it never really appears to the user.
					-- Then, select the option and we're off!
					GossipFrame:SetAlpha(0);
					SelectGossipOption(1);
				end
			end
		end

		return;
	end
--==
	if (event == "UNIT_PORTRAIT_UPDATE") then
		if (arg1 == "player") then
--			if (LunarSphereSettings.debugPortraitFix == true) then
				Lunar.Button.portraitTimer = 0;
--			else
--				Lunar.Button:UpdatePlayerPortrait();
--			end
		end
		return;
	end

	if (event == "PLAYER_LOGIN") then

		Lunar.Sphere:RunPlayerLoginGaugeSetup();

--		sphereData.background:RegisterEvent("CURSOR_UPDATE");
		
		return;
	end

	if (event == "CHAT_MSG_SYSTEM") then
		-- We adjust the busy text of Blizzards, because "%s " is looking for TWO SPACES...
		-- %s does NOT mean string >.>
		local busyText = string.gsub(ERR_PLAYER_BUSY_S, "%%s ", "%%s");
		if string.find(arg1, busyText) then
			Lunar.Button.tradingStage = nil;
			self:UnregisterEvent("TRADE_CLOSED");
			self:UnregisterEvent("TRADE_REQUEST_CANCEL");
			self:UnregisterEvent("CHAT_MSG_SYSTEM");
		end
	end

	if (event == "CVAR_UPDATE") and ((arg1 == "USE_UISCALE") or (arg1 == "UISCALE")) then
		Lunar.Settings.updateScale = tonumber(arg2);
		return;
	end

	if (event == "ACTIVE_TALENT_GROUP_CHANGED") then
		if (LunarSphereSettings.enableTemplateHotswapping) then
			Lunar.templateSwapTimer = 0;
		end
	end

--[[
	local gaugeType = "sphere";

	if (this == sphereData.gaugeOuterBorder) then
		gaugeType = "Outer";
	elseif (this == sphereData.gaugeInnerBorder) then
		gaugeType = "Inner";
	end

	-- If the mana went down, update the mana tracking for the 5 second timer

	if ((event == "UNIT_MANA") and (arg1 == "player") and (dataTracking.powerType == 0) ) then
		if (dataTracking.playerMana < UnitMana("player")) then
			dataTracking.playerMana = UnitMana("player");
		end
	end

--	if ((arg1 == "player") or (event == "PLAYER_COMBO_POINTS") or (event == "UPDATE_FACTION") or (event == "PLAYER_TARGET_CHANGED") ) then
	if ((arg1 == "player") or (event == "UNIT_POWER") or (event == "UPDATE_FACTION") or (event == "PLAYER_TARGET_CHANGED") ) then
		if (gaugeType ~= "sphere") then
			Lunar.Sphere:UpdateGauge(gaugeType);
		else
			Lunar.Sphere:UpdateSphere();
		end
	end
--]]
end

function Lunar.Sphere:RunPlayerLoginGaugeSetup()

	-- Save the type of power the player uses (mana, rage, energy, etc)
	dataTracking.powerType = UnitPowerType("player");

	local playerClass;
	_, playerClass = UnitClass("player");
	if (playerClass == "DRUID") then
		dataTracking.isDruid = true;
		sphereData.background:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
	end

	Lunar.Sphere:SetOuterGaugeType(LunarSphereSettings.outerGaugeType);
	Lunar.Sphere:SetInnerGaugeType(LunarSphereSettings.innerGaugeType);
	Lunar.Sphere:SetSphereTextType(LunarSphereSettings.sphereTextType);
	
end

function Lunar.Sphere.Updates(self, elapsed)

	if (dataTracking.loadedPlayer == false) then
		if (HasPetSpells()) then
			local minXP, maxXP = GetPetExperience();
			if (maxXP == 0) then
				return;
			end
		end
		if (UnitXPMax("Player") ~= 0) then
			dataTracking.loadedPlayer = true;
			dataTracking.gaugeInnerStart = nil;
			dataTracking.gaugeOuterStart = nil;
			Lunar.Sphere:UpdateGauge("Inner");
			Lunar.Sphere:UpdateGauge("Outer");
			Lunar.Sphere:UpdateSphere();
			dataTracking.playerMana = UnitPower("player");

--			Lunar.Button:UpdateCount(_G["LSmain"]);

			-- Load up some of our previously saved settings
--			if not (LunarSphereSettings.memoryDisableAHTotals) then
--				Lunar.API:ShowBidTotals(LunarSphereSettings.showTotalBid);
--				Lunar.API:ShowAuctionTotals(LunarSphereSettings.showTotalAH);
--			end
--[[
			Lunar.API:HidePlayerFrame(LunarSphereSettings.hidePlayer, true);
			Lunar.API:HideMinimapTime(LunarSphereSettings.hideTime, true);
			Lunar.API:HideMinimapZoom(LunarSphereSettings.hideZoom, true);
			Lunar.API:HideExpBars(LunarSphereSettings.hideEXP, true);
			Lunar.API:HideGryphons(LunarSphereSettings.hideGryphons, true);
			Lunar.API:HideMenus(LunarSphereSettings.hideMenus, true);
			Lunar.API:HideBags(LunarSphereSettings.hideBags, true);
			Lunar.API:HideBottomBar(LunarSphereSettings.hideBottomBar, true);
			Lunar.API:HideStanceBar(LunarSphereSettings.hideStance, true);
			Lunar.API:HideActionButtons(LunarSphereSettings.hideActions, true);
--]]
			if not (LunarSphereSettings.memoryDisableMinimap) then
				Lunar.API:ShowMinimapCoords(LunarSphereSettings.showCoordinates);
				Lunar.API:ShowMinimapTime(LunarSphereSettings.showTime, LunarSphereSettings.militaryTime, LunarSphereSettings.timeOffset);
			end

			if not (LunarSphereSettings.memoryDisableAHMail) then
				Lunar.API:GetMailSetup(LunarSphereSettings.getMailMoney, LunarSphereSettings.getMailItems);
			end

			_G["LSSettings"]:ClearAllPoints();
			_G["LSSettings"]:SetPoint("Center", UIParent, "Center", 0, 200);
			Lunar.Settings.ButtonDialog:ClearAllPoints();
			Lunar.Settings.ButtonDialog:SetPoint("Center", UIParent, "Center", 0, 200);

		else
			return;
		end
	end

	if (Lunar.templateSwapTimer) then
		Lunar.templateSwapTimer = Lunar.templateSwapTimer + elapsed;
		if (Lunar.templateSwapTimer >= 0.5) then
			Lunar.templateSwapTimer = nil;
			local activeGroup = GetActiveSpecGroup();
			local loadIt;
			if (LunarSphereSettings.dualTemplate1 and activeGroup == 1) then
				LunarSphereSettings.loadTemplate = LunarSphereSettings.dualTemplate1
				loadIt = true;
			elseif (LunarSphereSettings.dualTemplate2 and activeGroup == 2) then
				LunarSphereSettings.loadTemplate = LunarSphereSettings.dualTemplate2
				loadIt = true;
			end
			if (loadIt and Lunar.Button.defaultStance) then
				-- Save our template before doing this?

				Lunar.Template:LoadTemplateData();
				Lunar.Template:ParseTemplateData();
				LunarSphereSettings.loadTemplate = nil;
				Lunar.Button:ReloadAllButtons();
			end
		end
	end

	Lunar.refreshUpdate = Lunar.refreshUpdate + elapsed;
	if (dataTracking.fiveSec > 0) then
		dataTracking.fiveSec = dataTracking.fiveSec - elapsed;
		if (dataTracking.fiveSec <= 0) then
			dataTracking.fiveSec = 0;
		end
	end
	if (Lunar.refreshUpdate < 0.1) then
		return;
	end

	if (Lunar.Sphere.combatUpdate == true) then
		Lunar.Sphere.combatUpdate = nil;
		Lunar.Items:UpdateItemCounts();

		-- Create our local variables and start scanning our containers that need updating
--[[		local container;
		for container = 0, 4 do
			if (Lunar.Items["updateContainer" .. container]) then
				Lunar.Items:UpdateBagContents(container, "exists");
				Lunar.Items["updateContainer" .. container] = nil;
			end
		end
--]]
		Lunar.Items.bagUpdateTimer = 0.0;

--		Lunar.Items:UpdateLowHighItems();
--		Lunar.Items:UpdateSpecialButtons();
	end

	if (dataTracking.fiveSec >= 0) then
		if (LunarSphereSettings.innerGaugeType == LS_EVENT_FIVE) then
			Lunar.Sphere:UpdateGauge("Inner");
		end
		if (LunarSphereSettings.outerGaugeType == LS_EVENT_FIVE) then
			Lunar.Sphere:UpdateGauge("Outer");
		end
		if (LunarSphereSettings.sphereTextType == LS_EVENT_FIVE) then
			Lunar.Sphere:UpdateSphere();
		end
		if (dataTracking.fiveSec == 0) then
			dataTracking.fiveSec = -1;
		end
	end

	if (dataTracking.animateOuter == true) and (LunarSphereSettings.outerGaugeAnimate == true) then
		Lunar.Sphere:UpdateGauge("Outer");
	end

	if (dataTracking.animateInner == true) and (LunarSphereSettings.innerGaugeAnimate == true) then
		Lunar.Sphere:UpdateGauge("Inner");
	end

	Lunar.refreshUpdate = 0;

	if (Lunar.Settings.updateScale) then
		Lunar.Settings.Frame:SetScale(1);
		Lunar.Settings.ButtonDialog:SetScale(1);

		if (Lunar.Settings.RepairLogDialog) then
			Lunar.Settings.RepairLogDialog:SetScale(1);
		end
		if (LunarSphereSettings.autoScaleWindows == true) then
			if not (Lunar.Settings.updateScale == 0) then
				Lunar.Settings.Frame:SetScale(1 / GetCVar("uiscale"));
				Lunar.Settings.ButtonDialog:SetScale(1 / GetCVar("uiscale"));

				if (Lunar.Settings.RepairLogDialog) then
					Lunar.Settings.RepairLogDialog:SetScale(1 / GetCVar("uiscale"));
				end
			end
		end
		Lunar.Settings.updateScale = nil
	end

end

-- Some notes ...
	-- Drink, Potion, and Food finder =)
	--local spellName = GetItemSpell("Refreshing Spring Water");
	--local sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo("Honey Bread");
	--message(sName..","..iLevel..","..iMinLevel..","..sType..","..sSubType);
	-- Drink, Restore Mana, Healing Potion, Food
	-- Honey Bread, Darnassian Bleu, Shiny Red Apple, Tough Hunk of Bread, Forest Mushroom Cap, Tough Jerky
	-- Minor Healing Potion, Minor Mana Potion
	
	-- local found, _, itemId = string.find(sLink, "^item:(%d+):")

