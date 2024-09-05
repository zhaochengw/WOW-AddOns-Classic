--[[
Tidy Bar
--]]


-- Tidy Bar
local TidyBarScale = 1
local TidyBarHideBagAndMenu = true
-- local 

local MenuButtonFrames = {
	CharacterMicroButton,
	SpellbookMicroButton,
	TalentMicroButton,
	AchievementMicroButton,
	QuestLogMicroButton,
	SocialsMicroButton,
	CollectionsMicroButton,
	PVPMicroButton,
	LFGMicroButton,
	MainMenuMicroButton,
	HelpMicroButton,
	--MainMenuBarPerformanceBarFrame,
}

local BagButtonFrameList = {
	MainMenuBarBackpackButton,
	CharacterBag0Slot,
	CharacterBag1Slot,
	CharacterBag2Slot,
	CharacterBag3Slot,
	KeyRingButton,
}

local maxLevel = 80
local playerLevel = UnitLevel("player")
local ButtonGridIsShown = false
local Corner_Artwork_Texture = "Interface\\Addons\\TidyBar\\CornerArt"
local Empty_Art = "Interface\\Addons\\TidyBar\\Empty"
local MouseInSidebar, MouseInCorner = false

local TidyBar = CreateFrame("Frame", "TidyBar", WorldFrame)
local CornerMenuFrame = CreateFrame("Frame", "TidyBar_CornerMenuFrame", UIParent)
local SideMouseoverFrame = CreateFrame("Frame", "TidyBar_SideBarMouseoverFrame", UIParent)
local CornerMouseoverFrame = CreateFrame("Frame", "TidyBar_CornerBarMouseoverFrame", UIParent)



TidyBar.defaults = {
	HideMainButtonArt = false,
	HideExperienceBar = false,
	AlwaysShowBagFrame = false,
}


function TidyBar:HideMainButtonArt()
	MainMenuBarLeftEndCap:Hide()
	MainMenuBarLeftEndCap:SetAlpha(0)
	MainMenuBarRightEndCap:Hide()
	MainMenuBarRightEndCap:SetAlpha(0)

	MainMenuBarTexture0:SetAlpha(0)
	MainMenuBarTexture0:Hide()
	MainMenuBarTexture1:SetAlpha(0)
	MainMenuBarTexture1:Hide()

	MainMenuBarTextureExtender:SetAlpha(0)
	MainMenuBarTextureExtender:Hide()
end
function TidyBar:ShowMainButtonArt()
	MainMenuBarLeftEndCap:Show()
	MainMenuBarLeftEndCap:SetAlpha(1)
	MainMenuBarRightEndCap:Show()
	MainMenuBarRightEndCap:SetAlpha(1)

	MainMenuBarTexture0:SetAlpha(1)
	MainMenuBarTexture0:Show()
	MainMenuBarTexture1:SetAlpha(1)
	MainMenuBarTexture1:Show()

	MainMenuBarTextureExtender:SetAlpha(1)
	MainMenuBarTextureExtender:Show()
end

function TidyBar:HideExperienceBar()
	MainMenuExpBar:Hide()
	MainMenuExpBar:SetHeight(.001)
	ReputationWatchBar:Hide()
	ReputationWatchBar:SetHeight(.001)
end
function TidyBar:ShowExperienceBar()
	MainMenuExpBar:Show()
	local watchedFaction, _ = GetWatchedFactionInfo();
	if (watchedFaction == nil) then
		ReputationWatchBar:Hide()
		ReputationWatchBar:SetHeight(.001)
	else
		ReputationWatchBar:Show()
		ReputationWatchBar:SetHeight(11)
	end

	if (playerLevel == maxLevel) then
		MainMenuExpBar:Hide()
	end
end

hookRunCounter = 0
function TidyBar:HideBagFrame()
	CornerMenuFrame:SetAlpha(0);
	CornerMouseoverFrame:EnableMouse(true);
	CornerMouseoverFrame:Show();
	if (hookRunCounter < 1) then
		HookCornerFrame(CornerMouseoverFrame)
		for i, name in pairs(BagButtonFrameList) do HookCornerFrame(name) end
		for i, name in pairs(MenuButtonFrames) do HookCornerFrame(name) end
	end
	hookRunCounter = hookRunCounter + 1
end
function TidyBar:ShowBagFrame()
	CornerMenuFrame:SetAlpha(1)
	-- Setup the Corner Menu Mouseover frame
	CornerMouseoverFrame:EnableMouse(false);
	CornerMouseoverFrame:Hide();
	if (hookRunCounter < 1) then
		UnhookCornerFrame(CornerMouseoverFrame)
		for i, name in pairs(BagButtonFrameList) do UnhookCornerFrame(name) end
		for i, name in pairs(MenuButtonFrames) do UnhookCornerFrame(name) end
	end
	hookRunCounter = hookRunCounter + 1
end

CornerMenuFrame:SetFrameStrata("LOW")
CornerMenuFrame:SetWidth(300)
CornerMenuFrame:SetHeight(128)
CornerMenuFrame:SetPoint("BOTTOMRIGHT")
CornerMenuFrame:SetScale(TidyBarScale)

CornerMenuFrame.BagButtonFrame = CreateFrame("Frame", nil, CornerMenuFrame)
CornerMenuFrame.MicroButtons = CreateFrame("Frame", nil, CornerMenuFrame)

-- Event Delay
local DelayedEventWatcher = CreateFrame("Frame")
local DelayedEvents = {}
local function CheckDelayedEvent(self)
	local pendingEvents, currentTime = 0, GetTime()
	for functionToCall, timeToCall in pairs(DelayedEvents) do
		if currentTime > timeToCall then
			DelayedEvents[functionToCall] = nil
			functionToCall()
		end
	end
	-- Check afterward to prevent missing a recall
	for functionToCall, timeToCall in pairs(DelayedEvents) do pendingEvents = pendingEvents + 1 end
	if pendingEvents == 0 then DelayedEventWatcher:SetScript("OnUpdate", nil) end
end
local function DelayEvent(functionToCall, timeToCall)
	DelayedEvents[functionToCall] = timeToCall
	DelayedEventWatcher:SetScript("OnUpdate", CheckDelayedEvent)
end
-- Event Delay

local function ForceTransparent(frame)
		frame:Hide()
		frame:SetAlpha(0)
end

local function RefreshMainActionBars()
	local anchor = ActionButton1
	local anchorOffset = 7
	local reputationBarOffset = 16
	local initialOffset = 32
	local indentOffset = 16

	MainMenuExpBar:SetWidth(500)
	MainMenuExpBar:SetHeight(11)
	ExhaustionLevelFillBar:SetWidth(500)
	ExhaustionLevelFillBar:SetHeight(11)
	ReputationWatchBar.StatusBar:SetWidth(500)

	if TidyBar.opts.HideExperienceBar == true then
		TidyBar:HideExperienceBar()
	else
		TidyBar:ShowExperienceBar()
	end

	if TidyBar.opts.HideMainButtonArt == true then
		TidyBar:HideMainButtonArt()
	else
		TidyBar:ShowMainButtonArt()
	end

	if MainMenuExpBar:IsShown() and ReputationWatchBar:IsShown() then
		anchorOffset = 16 + 8
	elseif MainMenuExpBar:IsShown() or ReputationWatchBar:IsShown() then
		anchorOffset = 16
	end

	reputationBarOffset = anchorOffset

	if MultiBarBottomLeft:IsShown() then
		MultiBarBottomLeft:ClearAllPoints()
		MultiBarBottomLeft:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset )
		anchor = MultiBarBottomLeft
		anchorOffset = 4
	else
		anchor = ActionButton1;
		anchorOffset = 7 + reputationBarOffset
	end

	if MultiBarBottomRight:IsShown() then
		--print("MultiBarBottomRight")
		MultiBarBottomRight:ClearAllPoints()
		MultiBarBottomRight:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset )
		anchor = MultiBarBottomRight
		anchorOffset = 4
	end

	-- PetActionBarFrame, PetActionButton1
	if PetActionBarFrame:IsShown() then
		--print("PetActionBarFrame")
		PetActionButton1:ClearAllPoints()
		PetActionButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", initialOffset, anchorOffset)
		anchor = PetActionButton1
		anchorOffset = 4
	end

	if StanceBarFrame:IsShown() then
		local xAnchorOffset = 0;
		if PetActionBarFrame:IsShown() then
			xAnchorOffset = initialOffset * -1
		end
		StanceButton1:ClearAllPoints();
		StanceButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", xAnchorOffset, anchorOffset);
		anchor = StanceButton1
		anchorOffset = 4
	end

	if MultiCastActionBarFrame:IsShown() then
		anchorOffset = 0
		MultiCastActionBarFrame:ClearAllPoints();
		MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", -4, anchorOffset);
		anchor = MultiCastActionBarFrame;
		anchorOffset = 4
	end

	-- Vehicle Leave Button
	if MainMenuBarVehicleLeaveButton:IsShown() then
		MainMenuBarVehicleLeaveButton:ClearAllPoints();
		MainMenuBarVehicleLeaveButton:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset);
		anchor = MainMenuBarVehicleLeaveButton
		anchorOffset = 4
	end

end

function ShowCornerMenuFrame()
	MouseInCorner = true
	if (CornerMenuFrame:GetAlpha() ~= 1) then
		CornerMenuFrame:SetAlpha(1)
	end
end

function HideCornerMenuFrame()
	DelayEvent(function() 
		if (MouseInCorner == true) then return end
		if (CornerMenuFrame:GetAlpha() ~= 0) then
			CornerMenuFrame:SetAlpha(0)
		end
	end, GetTime()+5)
	MouseInCorner = false
end

function HookCornerFrame(frameTarget)
	frameTarget:HookScript("OnEnter", ShowCornerMenuFrame)
	frameTarget:HookScript("OnLeave", HideCornerMenuFrame)
end
function UnhookCornerFrame(frameTarget)
	frameTarget:HookScript("OnEnter", ShowCornerMenuFrame)
	frameTarget:HookScript("OnLeave", ShowCornerMenuFrame)
end

local function ConfigureCornerBars()
	--if not UnitHasVehicleUI("player") then
		CharacterMicroButton:ClearAllPoints();
		local microButtonOffset = #MenuButtonFrames * 23 * -1;
		CharacterMicroButton:SetPoint("BOTTOMRIGHT", microButtonOffset, 0);

		-- MainMenuBarPerformanceBarFrame:SetScale(TidyBarScale);
		-- MainMenuBarPerformanceBarFrame:ClearAllPoints();
		-- MainMenuBarPerformanceBarFrame:SetPoint("BOTTOMRIGHT", 0, -10);

		for i, name in pairs(MenuButtonFrames) do 
			name:SetParent(CornerMenuFrame.MicroButtons) 
		end

		if TidyBar.opts.AlwaysShowBagFrame == true then
			TidyBar:ShowBagFrame()
		else
			TidyBar:HideBagFrame()
		end
	--end
end

local function ConfigureSideBars()
	-- Right Bar
	if MultiBarRight:IsShown() then
		SideMouseoverFrame:Show()
		MultiBarRight:EnableMouse();
		SideMouseoverFrame:SetPoint("BOTTOMRIGHT", MultiBarRight, "BOTTOMRIGHT", 0,0)
		-- Right Bar 2
		if MultiBarLeft:IsShown() then
			MultiBarLeft:EnableMouse();
			SideMouseoverFrame:SetPoint("TOPLEFT", MultiBarLeft, "TOPLEFT", -6,0)
		else SideMouseoverFrame:SetPoint("TOPLEFT", MultiBarRight, "TOPLEFT", -6,0) end
	else SideMouseoverFrame:Hide() 	end
end


local function RefreshExperienceBars()

	-- Hide Unwanted Art
	MainMenuBarPageNumber:Hide();
    ActionBarUpButton:Hide();
    ActionBarDownButton:Hide();
	-- Experience Bar
	MainMenuBarTexture2:SetTexture(Empty_Art)
	MainMenuBarTexture3:SetTexture(Empty_Art)
	MainMenuBarTexture2:SetAlpha(0)
	MainMenuBarTexture3:SetAlpha(0)
	for i=0,3 do _G["MainMenuXPBarTexture"..i]:SetTexture(Empty_Art) end



	-- Hide Rested State
	--ExhaustionLevelFillBar:SetTexture(Empty_Art)
	ExhaustionTick:SetAlpha(0)

	-- Max-level Rep Bar
	MainMenuMaxLevelBar0:SetAlpha(0)
	MainMenuMaxLevelBar1:SetAlpha(0)
	MainMenuMaxLevelBar2:SetAlpha(0)
	MainMenuMaxLevelBar3:SetAlpha(0)

	ReputationWatchBar.StatusBar.XPBarTexture0:SetAlpha(0)
	ReputationWatchBar.StatusBar.XPBarTexture1:SetAlpha(0)
	ReputationWatchBar.StatusBar.XPBarTexture2:SetAlpha(0)
	ReputationWatchBar.StatusBar.XPBarTexture3:SetAlpha(0)


	-- Rep Bar Bubbles (For the Rep Bar)
	--ReputationWatchBarTexture0:SetAlpha(0)
	ReputationWatchBar.StatusBar.WatchBarTexture0:SetAlpha(0)
	ReputationWatchBar.StatusBar.WatchBarTexture1:SetAlpha(0)
	ReputationWatchBar.StatusBar.WatchBarTexture2:SetAlpha(0)
	ReputationWatchBar.StatusBar.WatchBarTexture3:SetAlpha(0)
	--ReputationWatchBarTexture1:SetAlpha(0)
	--ReputationWatchBarTexture2:SetAlpha(0)
	--ReputationWatchBarTexture3:SetAlpha(0)

	-- Repositions the bubbles for the Rep Watch bar
	ReputationWatchBar.StatusBar.WatchBarTexture0:ClearAllPoints()
	ReputationWatchBar.StatusBar.WatchBarTexture0:SetPoint("LEFT", ReputationWatchBar, "LEFT", 0, 2)
	ReputationWatchBar.StatusBar.WatchBarTexture3:ClearAllPoints()
	ReputationWatchBar.StatusBar.WatchBarTexture3:SetPoint("LEFT", ReputationWatchBarTexture0, "RIGHT")

end

function RefreshPositions()
	if InCombatLockdown() then return end
	-- Change the size of the central button and status bars
    MainMenuBar:SetWidth(512);
	MainMenuExpBar:SetWidth(512);
    ReputationWatchBar:SetWidth(512);
    MainMenuBarMaxLevelBar:SetWidth(512);
    ReputationWatchBar.StatusBar:SetWidth(512);

	-- Hide backgrounds
	SlidingActionBarTexture0:Hide()
	SlidingActionBarTexture0:SetAlpha(0)
	SlidingActionBarTexture1:Hide()
	SlidingActionBarTexture1:SetAlpha(0)

	StanceBarLeft:Hide()
	StanceBarLeft:SetAlpha(0)
	StanceBarMiddle:Hide()
	StanceBarMiddle:SetAlpha(0)
	StanceBarRight:Hide()
	StanceBarRight:SetAlpha(0)

	ConfigureSideBars()
    RefreshMainActionBars()
	ConfigureCornerBars()
	RefreshExperienceBars()
end

optionRunCount = 0
function ConfigureOptions()
    TidyBarOptions = TidyBarOptions or {}
    TidyBar.opts = TidyBarOptions or {}
    TidyBar.opts.HideMainButtonArt = TidyBarOptions.HideMainButtonArt or TidyBar.defaults.HideMainButtonArt
    TidyBar.opts.HideExperienceBar = TidyBarOptions.HideExperienceBar or TidyBar.defaults.HideExperienceBar
    TidyBar.opts.AlwaysShowBagFrame = TidyBarOptions.AlwaysShowBagFrame or TidyBar.defaults.AlwaysShowBagFrame

    if (optionRunCount < 1) then
        -- Create options interface
        TidyBar.panel = CreateFrame("Frame")
        TidyBar.panel.name = "TidyBar"

        local cb_art = CreateCheckbox("HideMainButtonArt", "Hide main button art?", TidyBar.panel, RefreshPositions)
        cb_art:SetPoint("TOPLEFT", 20, -20)
        local cb_xpbar = CreateCheckbox("HideExperienceBar", "Hide experience & reputation bar?", TidyBar.panel, RefreshPositions)
        cb_xpbar:SetPoint("TOPLEFT", cb_art, 0, -30)
        local cb_mo_bags = CreateCheckbox("AlwaysShowBagFrame", "Always show bags?", TidyBar.panel, RefreshPositions)
        cb_mo_bags:SetPoint("TOPLEFT", cb_xpbar, 0, -30)

        -- Add Slider for TidyBar Scale
        local Slider = CreateFrame("Slider", "TidyBarScaleSlider", TidyBar.panel, "OptionsSliderTemplate")
        Slider:SetWidth(150)
        Slider:SetHeight(20)
        Slider:SetPoint("TOPLEFT", cb_mo_bags, "BOTTOMLEFT", 0, -30) -- Adjust position according to your layout
        Slider:SetMinMaxValues(0.2, 2.0)
        Slider:SetValueStep(0.1)
        Slider:SetObeyStepOnDrag(true)
        Slider:SetOrientation("HORIZONTAL")
        Slider:SetValue(TidyBarScale)

        -- Slider value text display
        local SliderText = TidyBar.panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        SliderText:SetPoint("BOTTOM", Slider, "TOP", 0, 5)
        SliderText:SetText(string.format("TidyBar Scale: %.1f", TidyBarScale))

        Slider:SetScript("OnValueChanged", function(self, value)
            TidyBarScale = value
	   MainMenuBar:SetScale(TidyBarScale)
	   MultiBarRight:SetScale(TidyBarScale)
	   MultiBarLeft:SetScale(TidyBarScale)
            CornerMenuFrame:SetScale(TidyBarScale)  -- Update the scale of CornerMenuFrame
            SliderText:SetText(string.format("TidyBar Scale: %.1f", TidyBarScale))  -- Update the text display
        end)

        -- Fix for setting slider values
        _G[Slider:GetName() .. "Low"]:SetText("0.2")
        _G[Slider:GetName() .. "High"]:SetText("2.0")
        _G[Slider:GetName() .. "Text"]:SetText("")

        -- Interface options category
        InterfaceOptions_AddCategory(TidyBar.panel)
    end
    optionRunCount = optionRunCount + 1
end


function CreateCheckbox(savedvar, label, parent, update)
	local cb = CreateFrame("CheckButton", "cb" .. savedvar, parent, "ChatConfigCheckButtonTemplate")
	getglobal("cb" .. savedvar .. "Text"):SetText(label)
	cb.key = savedvar;
	--cb.text:SetText(label)
	cb:SetChecked(TidyBar.opts[savedvar]);
	cb:SetScript("OnClick",
    function(self)
		TidyBarOptions[self.key] = not TidyBarOptions[self.key];
		TidyBar.opts[self.key] = TidyBarOptions[self.key];

		RefreshPositions();
    end);
	return cb
end


-- Event Handlers
local events = {}

function events:ACTIONBAR_SHOWGRID() ButtonGridIsShown = true; end
function events:ACTIONBAR_HIDEGRID() ButtonGridIsShown = false; end
function events:UNIT_EXITED_VEHICLE()  RefreshPositions(); DelayEvent(ConfigureCornerBars, GetTime()+1) end	-- Echos the event to verify positions
function events:UNIT_ENTERED_VEHICLE()  RefreshPositions(); DelayEvent(ConfigureCornerBars, GetTime()+1) end	-- Echos the event to verify positions
events.PLAYER_ENTERING_WORLD = RefreshPositions
events.UPDATE_INSTANCE_INFO = RefreshPositions
events.PET_BAR_UPDATE = RefreshPositions
events.UPDATE_BONUS_ACTIONBAR = RefreshPositions
events.PLAYER_LEVEL_UP = RefreshPositions
events.UPDATE_SHAPESHIFT_FORM = RefreshPositions
events.QUEST_WATCH_UPDATE = RefreshPositions
events.ADDON_LOADED = ConfigureOptions

local function EventHandler(frame, event)
	if events[event] then
		events[event]()
	end
end

-- Set Event Monitoring
for eventname in pairs(events) do
	TidyBar:RegisterEvent(eventname)
end


-----------------------------------------------------------------------------
-- Menu Menu and Artwork
do
	-- Call Update Function when the default UI makes changes
	hooksecurefunc("UIParent_ManageFramePositions", RefreshPositions);
	-- Required in order to move the frames around
	UIPARENT_MANAGED_FRAME_POSITIONS["MultiBarBottomRight"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["PetActionBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["ShapeshiftBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["PossessBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["MultiCastActionBarFrame"] = nil

	-- Scaling
	MainMenuBar:SetScale(TidyBarScale)
	MultiBarRight:SetScale(TidyBarScale)
	MultiBarLeft:SetScale(TidyBarScale)

	-- Adjust the fill and endcap artwork
	MainMenuBarTexture0:SetPoint("LEFT", MainMenuBar, "LEFT", 0, 0);
    MainMenuBarTexture1:SetPoint("RIGHT", MainMenuBar, "RIGHT", 0, 0);
 	MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBar, "LEFT", 32, 0);
    MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBar, "RIGHT", -32, 0);

	-- Hide 'ring' around the stance/shapeshift buttons
	for i = 1, 10 do
		_G["StanceButton"..i.."NormalTexture2"]:SetTexture(Empty_Art)
	end

	RefreshExperienceBars()

	-- Set Pet Bars
	PetActionBarFrame:SetAttribute("unit", "pet")

	ConfigureSideBars()

	MainMenuBar:HookScript("OnShow", function()
		RefreshPositions()
	end)
end

-----------------------------------------------------------------------------
-- Corner Menu
do
	-- Keyring etc
	for i, name in pairs(BagButtonFrameList) do
		name:SetParent(CornerMenuFrame.BagButtonFrame)
		local width = name:GetWidth();
		name:SetWidth(width-2);
		--print( name:GetWidth() )
		--name:ClearAllPoints()
		--name:SetPoint("LEFT", 0, 0)
	end

    MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("BOTTOM");
	MainMenuBarBackpackButton:SetPoint("RIGHT", 0, 0);

	-- Setup the Corner Menu Artwork
	CornerMenuFrame:SetScale(TidyBarScale)

	-- 根据 TidyBarHideBagAndMenu 的值来设置显示或隐藏
if TidyBarHideBagAndMenu then
    -- 隐藏背包和菜单栏
    CornerMenuFrame.MicroButtons:SetHeight(0)
    CornerMenuFrame.MicroButtons:SetWidth(0)
    CornerMenuFrame.BagButtonFrame:SetHeight(0)
    CornerMenuFrame.BagButtonFrame:SetWidth(0)
else
    -- 显示背包和菜单栏
    -- 你可以根据需要设置具体的位置和大小
	CornerMenuFrame:SetScale(TidyBarScale)
	CornerMenuFrame.MicroButtons:SetPoint("BOTTOMRIGHT", 0, 1)
	CornerMenuFrame.MicroButtons:SetHeight(45)
	CornerMenuFrame.MicroButtons:SetWidth(256)
	CornerMenuFrame.BagButtonFrame:SetPoint("BOTTOMRIGHT", -5, 40)
	CornerMenuFrame.BagButtonFrame:SetHeight(45)
	CornerMenuFrame.BagButtonFrame:SetWidth(256)
	--CornerMenuFrame.BagButtonFrame:SetScale(TidyBarScale)
	CornerMouseoverFrame:SetFrameStrata("BACKGROUND")
	CornerMouseoverFrame:SetPoint("TOP", MainMenuBarBackpackButton, "TOP", 0,10)
	CornerMouseoverFrame:SetPoint("RIGHT", UIParent, "RIGHT")
	CornerMouseoverFrame:SetPoint("BOTTOM", UIParent, "BOTTOM")
	CornerMouseoverFrame:SetWidth(200)
end

-- 设置鼠标悬停效果
CornerMouseoverFrame:SetScript("OnEnter", function()
    if not TidyBarHideBagAndMenu then
        CornerMenuFrame:SetAlpha(1)
    end
end)
CornerMouseoverFrame:SetScript("OnLeave", function()
    if not TidyBarHideBagAndMenu then
        CornerMenuFrame:SetAlpha(0)
    end
end)
end

-- Start Tidy Bar
TidyBar:SetScript("OnEvent", EventHandler);
TidyBar:SetFrameStrata("TOOLTIP")
TidyBar:Show()

SLASH_TIDYBAR1 = '/tidybar'
SlashCmdList.TIDYBAR = function(msg, editBox)
	-- https://github.com/Stanzilla/WoWUIBugs/issues/89
	InterfaceOptionsFrame_OpenToCategory(TidyBar.panel)
	InterfaceOptionsFrame_OpenToCategory(TidyBar.panel)
end


