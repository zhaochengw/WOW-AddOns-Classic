-- Global constants
CASTING_BAR_MAJOR_VERSION = "1";
CASTING_BAR_MINOR_VERSION = "4";
CASTING_BAR_REVISION = "4";
CASTING_BAR_ALPHA_STEP = 0.05;
CASTING_BAR_FLASH_STEP = 0.2;
CASTING_BAR_HOLD_TIME = 1;
CASTING_BAR_WIDTH = 264;
CASTING_BAR_HEIGHT = 32;
CASTING_BAR_LEFT = (GetScreenWidth()-CASTING_BAR_WIDTH)/2
CASTING_BAR_SLIDER_WIDTH_MIN = 100;
CASTING_BAR_SLIDER_WIDTH_MAX = 2000;
CASTING_BAR_SLIDER_HEIGHT_MIN = 20;
CASTING_BAR_SLIDER_HEIGHT_MAX = 60;
CASTING_BAR_SPELL_JUSTIFY = "Center";
CASTINGBAR_ICON_POSITION = {
	{ text = CASTINGBAR_LEFT_TEXT, value = "LEFT"},
	{ text = CASTINGBAR_RIGHT_TEXT, value = "RIGHT"},
	{ text = CASTINGBAR_HIDDEN_TEXT, value = "HIDDEN"}
};
CASTINGBAR_HEADER = strGreen.."eCastingBar "..strGreen.."Classic "..strYellow.."v"..strYellow..CASTING_BAR_MAJOR_VERSION..strYellow.."."..strYellow..CASTING_BAR_MINOR_VERSION..strYellow.."."..strYellow..CASTING_BAR_REVISION..strWhite;
CASTINGBAR_HELP = {
	strLine1 = strYellow.."--- "..CASTINGBAR_HEADER..strYellow.." --- ",
	strLine2 = strWhite..strTab..CASTINGBAR_CHAT_C1..strYellow..CASTINGBAR_HELP_STRING..strWhite
};
MIRROR_CASTING_BAR_HEIGHT = 26; 
-- Global variables
eCastingBar_Saved = {};
eCastingBar_Resolution = nil;
eCastingBar_ResolutionWidth = 0;
eCastingBar_ResolutionHeight = 0;
eCastingBar_MENU_SAVEDSETTINGS = nil;
eCastingBar_SETTINGS_INDEX = "";

-- Local Constants
local CASTING_BAR_COLOR_TEXTURE = "Interface\\TargetingFrame\\UI-StatusBar-Glow";
local CASTING_BAR_BACKGROUND_FILE = "Interface\\Tooltips\\UI-Tooltip-Background";
local CASTING_BAR_EDGE_FILE = "Interface\\Tooltips\\UI-Tooltip-Border";
local CASTING_BAR_EDGE_FILE_UNINT = "Interface\\Tooltips\\UI-Tooltip-Border";
-- Casting Bar Frame Suffixes
local frameSuffixes = { "", }
local castSendTime

local CASTING_BAR_DEFAULTS = {
  ["Locked"] = 0,
  ["Enabled"] = 1,
  ["Texture"] = "Perl",
  ["ShowTime"] = 1,
  ["HideBorder"] = 0,
  ["ShowTotalTime"] = 0,
  ["Width"] = CASTING_BAR_WIDTH,
  ["Height"] = CASTING_BAR_HEIGHT,
  ["Left"] = CASTING_BAR_LEFT,
  ["Bottom"] = 180,
  ["ShowSpellName"] = 1,
  ["ShowLatency"] = 0,
  ["FontSize"] = 12,
  ["Alpha"] = 100,
	["IconPosition"] = "HIDDEN",
	["ShowDelay"] = 1,
  ["ShowTicks"] = 0,
  ["MirrorLocked"] = 0,
  ["MirrorEnabled"] = 1,
  ["MirrorTexture"] = "Perl",
  ["MirrorShowTime"] = 1,
  ["MirrorHideBorder"] = 0,
  ["MirrorUseFlightTimer"] = 1,
  ["MirrorWidth"] = CASTING_BAR_WIDTH,
  ["MirrorHeight"] = MIRROR_CASTING_BAR_HEIGHT,
  ["MirrorLeft"] = CASTING_BAR_LEFT,
  ["MirrorBottom"] = 600,
  ["MirrorShowTimerLabel"] = 1,
  ["MirrorFontSize"] = 12,
  ["MirrorAlpha"] = 100,
}

local CASTING_BAR_DEFAULT_COLORS = {
  ["SpellColor"] = {1.0, 0.7, 0.0, 1.0},
  ["ChannelColor"] = {0.3, 0.3, 1.0, 1},
  ["SuccessColor"] = {0.0, 1.0, 0.0, 1},
  ["FailedColor"] = {1.0, 0.0, 0.0, 1},
  ["FlashBorderColor"] = {1.0, 0.88, 0.25, 1},
  ["FeignDeathColor"] = {1.0, 0.7, 0.0, 1},
  ["ExhaustionColor"] = {1.0, 0.9, 0.0, 1},
  ["BreathColor"] = {0.0, 0.5, 1.0, 1},
  ["FlightColor"] = {.26, 0.93, 1.0, 1.0},
  ["TimeColor"] = {1.0, 1.0, 1.0, 1},
	["LagColor"] = {1.0, 0.0, 0.0, 0.84},
	["DelayColor"] = {1.0, 0.0, 0.0, 1},
  ["MirrorTimeColor"] = {1.0, 1.0, 1.0, 1},
  ["MirrorFlashBorderColor"] = {1.0, 0.88, 0.25, 1},
}

-- Local variables

local eCastingBar__FlashBorders = {
	"TOPLEFT",
	"TOP",
	"TOPRIGHT",
	"LEFT",
	"RIGHT",
	"BOTTOMLEFT",
	"BOTTOM",
	"BOTTOMRIGHT"	
}

local sparkfactory = {
	__index = function(t,k)
		local spark = _G["eCastingBarStatusBar"]:CreateTexture(nil, 'OVERLAY')
		t[k] = spark
		spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
		spark:SetVertexColor(1.0, 1.0, 1.0, 0.7)
		spark:SetBlendMode('ADD')
		spark:SetWidth(16)
		spark:SetHeight(eCastingBar_Saved.Height)
		return spark
	end
}
local barticks = setmetatable({}, sparkfactory)

local function setBarTicks(tickRate, duration, ticks)
	if( tickRate and tickRate > 0) then
		local width = eCastingBar_Saved.Width
		for k = 0, duration-tickRate, tickRate do
			local t = barticks[k]
			t:ClearAllPoints()
			local x = ticks[k] / duration
			t:SetHeight(eCastingBar_Saved.Height)
			t:SetPoint("CENTER", _G["eCastingBarStatusBar"], "LEFT", width * x, 0 )
			t:Show()
		end
		for k = duration+1,#barticks do
			barticks[k]:Hide()
		end
	else
		cleanTicks()
	end
end

local function cleanTicks()
	for i=0,#barticks do
		barticks[i]:Hide()
	end
end

local channelingTicksRate = {
	-- Rain of Fire
	[5740] = 2, -- rank 1
	[6219] = 2, -- rank 2
	[11677] = 2, -- rank 3
	[11678] = 2, -- rank 4
	-- Drain Soul
	[1120] = 3, -- rank 1
	[8288] = 3, -- rank 2
	[8289] = 3, -- rank 3
	[11675] = 3, -- rank 4
}

local function getChannelingTicksRate(spell, duration)
	-- Spells longer than 15 seconds don't tick (afaik), maybe TODO check spells that don't tick and last less than 15 seconds
	if duration > 15 then 
		return 0
	end
	
	return channelingTicksRate[spell] or 1
end

function ECB_addChat(msg)
	DEFAULT_CHAT_FRAME:AddMessage(CASTINGBAR_HEADER.." "..msg)
end

function eCastingBar_Toggle()
	if eCB_OptionFrame:IsVisible() then
		HideUIPanel(eCB_OptionFrame);
	else
		ShowUIPanel(eCB_OptionFrame);
	end
end

function eCastingBar_OnLoad(self, unit, frame)
	self:RegisterEvent("UNIT_SPELLCAST_START");
	self:RegisterEvent("UNIT_SPELLCAST_STOP");
	self:RegisterEvent("UNIT_SPELLCAST_FAILED");
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
	self:RegisterEvent("UNIT_SPELLCAST_DELAYED");
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
	self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");

	self.unit = unit;
	self.frame = frame;
	self.casting = nil;
	self.channeling = nil;
	self.holdTime = 0;
end

function testMode()
	local castBar = _G["eCastingBar"];
	local barStatusBar = _G["eCastingBarStatusBar"];
	local lagText = _G["eCastingBarLagBarText"];
	local barFlash = _G["eCastingBarFlash"]
	local barStatusBar = _G["eCastingBarStatusBar"];
	local lagBar = _G["eCastingBarLagBar"];
	local barText = _G["eCastingBarStatusBarText"];
	local barSpark = _G["eCastingBarStatusBarSpark"];
	local barTime = _G["eCastingBarStatusBar_Time"];
	local barTotalTime = _G["eCastingBarStatusBar_TotalTime"];
	local barDelay = _G["eCastingBarStatusBar_Delay"];
	local barTexture = _G["eCastingBarStatusBarTexture"];
	local lagTexture = _G["eCastingBarLagBarTexture"];
	local barIcon = _G["eCastingBarStatusBarIcon"];

	local n,n,testIcon = GetSpellInfo(5)
	local testName = "Castbar Outline"
	local testCastTime = 2.4
	local testTotalTime = 4
	local testProgress = testCastTime/testTotalTime
	local testLag = 0.1
	local testDelay = 0.5

	cleanTicks()

	if (eCastingBar_Saved.Enabled == 1 and eCastingBar_Saved.Locked == 0) then
		castBar:Show()
	else
		castBar:Hide()
		return
	end

	-- set the text to the spell name
	if ( eCastingBar_Saved.ShowSpellName == 1 ) then
	  barText:SetText(testName)
	else
	barText:SetText( "" )
	end
	if ( barIcon and eCastingBar_Saved.IconPosition ~= "HIDDEN") then
		barIcon:SetTexture(testIcon);
		barIcon:Show();
	end
	castBar:SetAlpha( 1.0 )
	if eCastingBar_Saved.HideBorder == 0 then
		if (notInterruptible) then
	                castBar:SetBackdrop({bgFile = CASTING_BAR_BACKGROUND_FILE, edgeFile = CASTING_BAR_EDGE_FILE_UNINT, tile = true, tileSize = 16, edgeSize = 16, insets = { left = 2, right = 2, top = 2, bottom = 2 }}) 
        	        castBar:SetBackdropColor(0,0,0,0.5)
		else
			castBar:SetBackdrop({bgFile = CASTING_BAR_BACKGROUND_FILE, edgeFile = CASTING_BAR_EDGE_FILE, tile = true, tileSize = 16, edgeSize = 16, insets = { left = 2, right = 2, top = 2, bottom = 2 }}) 
            		castBar:SetBackdropColor(0,0,0,0.5)
		end
	end

	local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved.SpellColor)
	barStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
	if ( barSpark ) then
		barSpark:Show();
	end
	barStatusBar:SetMinMaxValues( 0, 1 )
	barStatusBar:SetValue( testProgress )

    if ( eCastingBar_Saved.ShowLatency == 1 ) then
		lagBar:SetMinMaxValues(0,1)
	  	lagBar:SetValue(1-testLag)
   		lagText:SetJustifyH("RIGHT")
   		lagText:SetPoint("RIGHT", lagBar, "RIGHT", 0, 0)
	  	lagText:SetTextColor(0.7,0.7,0.7,0.8)
      	lagText:SetText(string.format("%ims", testLag*1000))
		lagTexture:SetDrawLayer("ARTWORK")
		lagTexture:SetPoint("TOPLEFT", lagBar, "TOPRIGHT")
    else
      lagText:SetText("")
      lagBar:SetValue(0)
    end

    barTexture:SetTexCoord(0, testProgress, 0, 1) 
    barStatusBar:SetValue( testProgress )
    barFlash:Hide()
    local sparkPosition = ( testProgress ) * barStatusBar:GetWidth()
    if( sparkPosition < 0 ) then
		
      sparkPosition = 0	
    end
    barSpark:SetPoint( "CENTER", "eCastingBarStatusBar", "LEFT", sparkPosition, 0 )

		if (( eCastingBar_Saved.ShowDelay == 1 ) and ( testDelay ~= 0)) then  
	    barDelay:SetText("+"..string.format( "%.1f", testDelay ) )
    else
      barDelay:SetText("")
    end

    local timeText = ""
    if ( eCastingBar_Saved.ShowTime == 1) then
    	timeText = string.format( "%.1f", math.max( testCastTime, 0.0 ) )
    end
    if ( eCastingBar_Saved.ShowTime == 1 and eCastingBar_Saved.ShowTotalTime == 1) then
    	timeText = timeText .. " / "
		end
    if (( eCastingBar_Saved.ShowTotalTime == 1 )) then
	    timeText = timeText .. string.format( "%.1f", math.max(testTotalTime, 0.0))
    end
    barTime:SetText(timeText)

	if ( eCastingBar_Saved["ShowTicks"] == 1) then
		 -- Spell ticks once every 'ticksRate' seconds and assuming spell has unmodified duration
		local channelingDuration = math.max(testTotalTime, 0)
		local ticksRate = 1
		if(ticksRate > 0) then
			local barTicks = barTicks or {}
			for i = 0, channelingDuration-ticksRate, ticksRate do
				barTicks[i] = i
			end
			setBarTicks(ticksRate, channelingDuration, barTicks)
		end
	end
end

function testModeMirror()
	local mirrorName = "eCastingBarMirror1"
	local dialog = _G[mirrorName]
	local statusbar = _G[mirrorName.."StatusBar"]
	local text = _G[mirrorName.."StatusBarText"]
	local time = _G[mirrorName.."StatusBar_Time"]

	local testTotalTime = 60
	local testTimeLeft = 40

	if (eCastingBar_Saved.MirrorEnabled == 1 and eCastingBar_Saved.MirrorLocked == 0) then
		dialog:Show()
	else
		dialog:Hide()
		return
	end

    _G[mirrorName.."Flash"]:Hide()
    if(eCastingBar_Saved.MirrorShowTimerLabel == 1) then
		text:SetText("Mirror Bar Outline")
	else 
		text:SetText("")
	end
	statusbar:SetStatusBarColor(unpack(eCastingBar_Saved.BreathColor));
	statusbar:SetMinMaxValues(0,1)
	statusbar:SetValue(testTimeLeft/testTotalTime)

	dialog:SetAlpha( 1.0 )

    if (eCastingBar_Saved.MirrorShowTime == 1) then    	
		local timeMsg = string.format( "%.1f", testTimeLeft )
		time:SetText( timeMsg )
    else
     	time:SetText("")
    end
    
	-- updates the spark
    local width = _G[mirrorName.."Background"]:GetWidth()
    intSparkPosition = ( testTimeLeft / testTotalTime ) * width
    _G[mirrorName.."StatusBarSpark"]:SetPoint( "CENTER", mirrorName.."StatusBar", "LEFT", intSparkPosition, 0 )
end

--[[ Handles all the mods' events. ]]--

function eCastingBar_OnEvent(self, newevent, ...)

	if(eCastingBar_Saved["Enabled"] == 0 or eCastingBar_Saved["Locked"] == 0) then
		return
	end

	local newarg1 = ...;

	local unit = self.unit;

	local lag;

	if(newevent == "CURRENT_SPELL_CAST_CHANGED") then
		castSendTime = GetTime()
	elseif(castSendTime and (newevent == "UNIT_SPELLCAST_START" or newevent == "UNIT_SPELLCAST_CHANNEL_START")) then
		lag = math.max(GetTime() - castSendTime, 0)*1000
	end

	if newevent == "PLAYER_ENTERING_WORLD" then
		self:Hide();
		local nameChannel  = ChannelInfo(unit);
		local nameSpell  = CastingInfo(unit);
		if ( nameChannel ) then
			newevent = "UNIT_SPELLCAST_CHANNEL_START";
			newarg1 = unit;
		elseif ( nameSpell ) then
			newevent = "UNIT_SPELLCAST_START";
			newarg1 = unit;
		end
	end
	if ( newarg1 ~= unit ) then
		return;
	end
	local name = self:GetName();
	local barIcon = _G[name.."StatusBarIcon"];
	local barFlash = _G[name.."Flash"]
	local barStatusBar = _G[name.."StatusBar"];
	local barSpark = _G[name.."StatusBarSpark"];
	local barText = _G[name.."StatusBarText"];
	local lagText = _G[name.."LagBarText"];
	local lagTexture = _G[name.."LagBarTexture"];
	local lagBar = _G[name.."LagBar"];
	local frame = self.frame
	if( newevent == "UNIT_SPELLCAST_START" ) then
		local spellName, displayName, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = CastingInfo(unit)

		if ( not spellName ) then
			self:Hide();
			return;
		end

		cleanTicks()

		local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[frame.."SpellColor"])
		barStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
		if ( barSpark ) then
			barSpark:Show();
		end
		self.startTime = (startTime/1000)
		self.maxValue = (endTime/1000)
		barStatusBar:SetMinMaxValues( 0, 1 )
		barStatusBar:SetValue( 0 )

    if ( eCastingBar_Saved[frame.."ShowLatency"] == 1 ) then
		lagBar:SetMinMaxValues(0,1)
	  	lagBar:SetValue(1-lag/(endTime-startTime))
   		lagText:SetJustifyH("RIGHT")
   		lagText:SetPoint("RIGHT", lagBar, "RIGHT", 0, 0)
	  	lagText:SetTextColor(0.7,0.7,0.7,0.8)
      	lagText:SetText(string.format("%ims", lag))
		lagTexture:SetPoint("TOPLEFT", lagBar, "TOPRIGHT", 0, 0)
    else
      lagText:SetText("")
      lagBar:SetValue(0)
    end

	  -- set the text to the spell name
	  if ( eCastingBar_Saved[frame.."ShowSpellName"] == 1 ) then
		  barText:SetText( spellName )
	  else
	    barText:SetText( "" )
	  end
		if ( barIcon and eCastingBar_Saved[frame.."IconPosition"] ~= "HIDDEN") then
			barIcon:SetTexture(texture);
			barIcon:Show();
		end
		self:SetAlpha( 1.0 )
		self.holdTime = 0
		self.casting = 1
		self.castID = castID;
		self.channeling = nil
		self.fadeOut = nil
		self.delay = 0

		if eCastingBar_Saved[frame.."HideBorder"] == 0 then
			if (notInterruptible) then
		                self:SetBackdrop({bgFile = CASTING_BAR_BACKGROUND_FILE, edgeFile = CASTING_BAR_EDGE_FILE_UNINT, tile = true, tileSize = 16, edgeSize = 16, insets = { left = 2, right = 2, top = 2, bottom = 2 }}) 
	        	        self:SetBackdropColor(0,0,0,0.5)
			else
				self:SetBackdrop({bgFile = CASTING_BAR_BACKGROUND_FILE, edgeFile = CASTING_BAR_EDGE_FILE, tile = true, tileSize = 16, edgeSize = 16, insets = { left = 2, right = 2, top = 2, bottom = 2 }}) 
                		self:SetBackdropColor(0,0,0,0.5)
			end
		end
		if (eCastingBar_Saved[frame.."Enabled"] == 1) then
			self:Show()
		end

	elseif( newevent == "UNIT_SPELLCAST_STOP" ) or ( newevent == "UNIT_SPELLCAST_CHANNEL_STOP" ) then

		if ( not self:IsVisible() ) then
			self:Hide()
		end
		if ( (self.casting and newevent == "UNIT_SPELLCAST_STOP") or
		     (self.channeling and newevent == "UNIT_SPELLCAST_CHANNEL_STOP") ) then
			barSpark:Hide();
			barFlash:SetAlpha(0.0);
			barFlash:Show();
			barStatusBar:SetValue(1);
			lagText:SetText("")
			if ( newevent == "UNIT_SPELLCAST_STOP" ) then
  				local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[frame.."SuccessColor"])
  				barStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
				self.casting = nil;
			else
				self.channeling = nil;
			end
			self.delay = 0
			self.flash = 1;
			self.fadeOut = 1;
			self.holdTime = 0
		end

	elseif( newevent == "UNIT_SPELLCAST_INTERRUPTED" or (newevent == "UNIT_SPELLCAST_FAILED" and spellName ~= barText.spellName) ) then

		if ( self:IsShown() and self.casting and not self.fadeOut ) then
			barStatusBar:SetValue( 1 )
	    local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[frame.."FailedColor"])
	    barStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
			barSpark:Hide()
			if ( newevent == "UNIT_SPELLCAST_FAILED" ) then
				barText:SetText( FAILED )
			else
				barText:SetText( INTERRUPTED )
			end
			self.casting = nil
			self.channeling = nil
			self.delay = 0
			self.fadeOut = 1
			self.holdTime = GetTime() + CASTING_BAR_HOLD_TIME
			lagText:SetText("")
		end
    
	elseif( newevent == "UNIT_SPELLCAST_DELAYED" ) then
		if( self:IsShown() ) then
			local spellName, displayName, texture, startTime, endTime, isTradeSkill = CastingInfo(unit)
			if (not endTime) then return; end;
			local delayTime = (endTime - (self.maxValue * 1000))
			if ( not spellName) then
				self:Hide();
				return;
			end
			self.startTime = (startTime/1000)
			self.maxValue = (endTime/1000)
			barStatusBar:SetMinMaxValues( 0, 1 )
	    if self.delay == nil then
  	  	self.delay = 0
    	end
			self.delay = self.delay + (delayTime / 1000)
			if ( not self.casting ) then
				local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[frame.."SpellColor"])
				barStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
				barSpark:Show();
				barFlash:SetAlpha(0.0);
				barFlash:Hide();
				self.casting = 1;
				self.channeling = nil;
				self.flash = 0;
				self.fadeOut = 0;
			end
		end
		
	elseif( newevent == "UNIT_SPELLCAST_CHANNEL_START" ) then
		local spellName, displayName, texture, startTime, endTime, isTradeSkill, notInterruptible, spellId = ChannelInfo(newarg1)
		if ( not spellName) then
			self:Hide();
			return;
		end

		cleanTicks()
		if ( eCastingBar_Saved[frame.."ShowTicks"] == 1) then
			 -- Spell ticks once every 'ticksRate' seconds and assuming spell has unmodified duration
			local channelingDuration = math.max(math.floor((endTime-startTime)/1000+0.5, 0))
			local ticksRate = getChannelingTicksRate(spellId, channelingDuration)
			if(ticksRate > 0) then
				local barTicks = barTicks or {}
				for i = 0, channelingDuration-ticksRate, ticksRate do
					barTicks[i] = i
				end
				setBarTicks(ticksRate, channelingDuration, barTicks)
			end
		end

  	local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[frame.."ChannelColor"])
  	barStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
		self.startTime = (startTime/1000)
		self.endTime = (endTime/1000)
		self.maxValue = self.startTime
	    if ( eCastingBar_Saved[frame.."ShowLatency"] == 1 ) then
	   	lagText:SetJustifyH("LEFT")
	   	lagText:SetPoint("LEFT", lagBar, "LEFT", 0, 0)
	    lagText:SetTextColor(0.7,0.7,0.7,0.8)
	    lagText:SetText(string.format("%ims", lag))
	    else
	      lagText:SetText("")
	    end
			barStatusBar:SetMinMaxValues( 0, 1 )
			barStatusBar:SetValue( (GetTime() - startTime) / (endTime - startTime) )
	    if ( eCastingBar_Saved[frame.."ShowLatency"] == 1 ) then
	  		lagBar:SetMinMaxValues(0,1)
	  		lagBar:SetValue(lag/(endTime-startTime))
	    else
	      lagBar:SetValue(0)
	    end
		barSpark:Show()
		if ( barIcon and eCastingBar_Saved[frame.."IconPosition"] ~= "HIDDEN") then
			barIcon:SetTexture(texture);
			barIcon:Show();
		end
	  if ( eCastingBar_Saved[frame.."ShowSpellName"] == 1 ) then
		  barText:SetText( spellName )
		else
			barText:SetText( "" )
		end
		self:SetAlpha( 1.0 )
  		self.delay = 0
		self.holdTime = 0
		self.casting = nil
		self.channeling = 1
		self.fadeOut = nil
		if(eCastingBar_Saved.HideBorder == 0) then
			if (notInterruptible) then
		                self:SetBackdrop({bgFile = CASTING_BAR_BACKGROUND_FILE, edgeFile = CASTING_BAR_EDGE_FILE_UNINT, tile = true, tileSize = 16, edgeSize = 16, insets = { left = 2, right = 2, top = 2, bottom = 2 }}) 
		                self:SetBackdropColor(0,0,0,0.5)
			else
				self:SetBackdrop({bgFile = CASTING_BAR_BACKGROUND_FILE, edgeFile = CASTING_BAR_EDGE_FILE, tile = true, tileSize = 16, edgeSize = 16, insets = { left = 2, right = 2, top = 2, bottom = 2 }}) 
	                	self:SetBackdropColor(0,0,0,0.5)
			end
		end
		if (  eCastingBar_Saved[frame.."Enabled"] == 1) then
			self:Show()
		end

	elseif( newevent == "UNIT_SPELLCAST_CHANNEL_UPDATE" ) then
		if( self:IsShown() ) then
			local spellName, displayName, texture, startTime, endTime = ChannelInfo(newarg1)
			if ( not spellName) then
				self:Hide();
				return;
			end
			self.startTime = startTime / 1000;
			self.endTime = endTime / 1000;
			self.maxValue = self.startTime;
			barStatusBar:SetMinMaxValues(0, 1);			
		end
	end
end

function eCastingBar_OnUpdate(self, elapsed)

	local lagBar = _G["eCastingBarLagBar"];
	local lagTexture = _G["eCastingBarLagBarTexture"];
	local one,two,three = lagTexture:GetPoint()
	-- Sometimes the lag texture sets "three" value to TOPLEFT, this is a temp fix until finding why
	if(three ~= "TOPRIGHT" and not self.channeling and not self.fadeOut) then
		lagTexture:SetPoint("TOPLEFT", lagBar, "TOPRIGHT")
	end

	if(eCastingBar_Saved["Locked"] == 0 or eCastingBar_Saved["Enabled"] == 0) then
		return
	end

	local frame = self.frame
	local bar = _G["eCastingBar"..frame]
	local barFlash = _G["eCastingBar"..frame.."Flash"]
	local barStatusBar = _G["eCastingBar"..frame.."StatusBar"];
	local barSpark = _G["eCastingBar"..frame.."StatusBarSpark"];
	local barTime = _G["eCastingBar"..frame.."StatusBar_Time"];
	local barTotalTime = _G["eCastingBar"..frame.."StatusBar_TotalTime"];
	local barDelay = _G["eCastingBar"..frame.."StatusBar_Delay"];
	local barTexture = _G["eCastingBar"..frame.."StatusBarTexture"];

  if( self.casting ) then    
	lagTexture:SetDrawLayer("ARTWORK")
    local intCurrentTime = GetTime()
    if (intCurrentTime > self.maxValue) then
    	intCurrentTime = self.maxValue
    end
 		if ( intCurrentTime == self.maxValue ) then
			barStatusBar:SetValue(1);

			barTexture:SetTexCoord(0,1,0,1);
		  local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[frame.."SuccessColor"])
			barStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
			self.flash = 1;
			self.delay = 0;
			self.fadeOut = 1;
			self.casting = nil;
			self.channeling = nil;
			return;
		end
	local progress = ( intCurrentTime - self.startTime ) / ( self.maxValue - self.startTime );
    barTexture:SetTexCoord(0, progress, 0, 1) 
    barStatusBar:SetValue( progress )
	lagTexture:SetPoint("TOPLEFT", lagBar, "TOPRIGHT", 0, 0)
    barFlash:Hide()
    local sparkPosition = ( progress ) * barStatusBar:GetWidth()
    if( sparkPosition < 0 ) then
		
      sparkPosition = 0	
    end
    barSpark:SetPoint( "CENTER", "eCastingBar"..frame.."StatusBar", "LEFT", sparkPosition, 0 )

		if (( eCastingBar_Saved[frame.."ShowDelay"] == 1 ) and ( self.delay ~= 0)) then  
	    barDelay:SetText("+"..string.format( "%.1f", self.delay ) )
    else
      barDelay:SetText("")
    end

    local timeText = ""
    if ( eCastingBar_Saved[frame.."ShowTime"] == 1) then
    	timeText = string.format( "%.1f", math.max( self.maxValue - intCurrentTime, 0.0 ) )
    end
    if ( eCastingBar_Saved[frame.."ShowTime"] == 1 and eCastingBar_Saved[frame.."ShowTotalTime"] == 1) then
    	timeText = timeText .. " / "
		end
    if (( eCastingBar_Saved[frame.."ShowTotalTime"] == 1 )) then
	    timeText = timeText .. string.format( "%.1f", math.max(self.maxValue - self.startTime, 0.0))
    end
    barTime:SetText(timeText)
  -- no, we channeling?	
  elseif ( self.channeling ) then
    -- yes
	lagTexture:SetDrawLayer("OVERLAY")
    local intTimeLeft = GetTime()
		if ( intTimeLeft > self.endTime ) then
			intTimeLeft = self.endTime;
		end
		if ( intTimeLeft == self.endTime ) then
		  local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[frame.."SuccessColor"])
			barStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
			self.flash = 1;
			self.delay = 0;
			self.fadeOut = 1;
			self.casting = nil;
			self.channeling = nil;
			return;
		end
    local intBarValue = self.startTime + ( self.endTime - intTimeLeft )
    local intBarValueProgress = ( intBarValue - self.startTime ) / ( self.endTime - self.startTime );
    barTexture:SetTexCoord(0, intBarValueProgress, 0, 1) 
    barStatusBar:SetValue( intBarValueProgress )
    barFlash:Hide()
    local sparkPosition = ( intBarValueProgress ) * _G["eCastingBar"..frame.."Background"]:GetWidth()
    barSpark:SetPoint( "CENTER", "eCastingBar"..frame.."StatusBar", "LEFT", sparkPosition, 0 )

    local timeText = ""
    if ( eCastingBar_Saved[frame.."ShowTime"] == 1) then
      local timeLeft = math.max( _G["eCastingBar"..frame].endTime - intTimeLeft, 0.0 )
      local minutes = 0
      local seconds = 0
      
      if (timeLeft > 60) then
        minutes = math.floor( ( timeLeft / 60 ))
        local seconds = math.ceil( timeLeft - ( 60 * minutes ))
        if (seconds == 60) then
          minutes = minutes + 1
          seconds = 0
        end
        timeText = format("%s:%s", minutes, getFormattedNumber(seconds))
      else
        timeText = string.format( "%.1f", timeLeft )
      end
    end
    if ( eCastingBar_Saved[frame.."ShowTime"] == 1 and eCastingBar_Saved[frame.."ShowTotalTime"] == 1) then
    	timeText = timeText .. " / "
	end
    if (( eCastingBar_Saved[frame.."ShowTotalTime"] == 1 )) then
      local totalTime = self.endTime - self.startTime 
      local minutes = 0
      local seconds = 0
      
      if (totalTime > 60) then
        minutes = math.floor( ( totalTime / 60 ))
        local seconds = math.ceil( totalTime - ( 60 * minutes ))
        if (seconds == 60) then
          minutes = minutes + 1
          seconds = 0
        end
        timeText = timeText .. format("%s:%s", minutes, getFormattedNumber(seconds))
      else
        timeText = timeText .. string.format( "%.1f", totalTime )
      end
    end
    barTime:SetText(timeText)

		if ((eCastingBar_Saved[frame.."ShowDelay"] == 1) and (self.delay ~= 0)) then
      barDelay:SetText("+"..string.format( "%.1f", self.delay ) )
    else
      barDelay:SetText("")
    end
  elseif( GetTime() < self.holdTime ) then
    return
  elseif( self.flash ) then
    local intAlpha = barFlash:GetAlpha() + CASTING_BAR_FLASH_STEP
    barTime:SetText( "" )
    if( intAlpha < 1 ) then
      barFlash:SetAlpha( intAlpha )
    else
			barFlash:SetAlpha(1.0);
      self.flash = nil
    end
  elseif ( self.fadeOut ) then
    local intAlpha = self:GetAlpha() - CASTING_BAR_ALPHA_STEP
    if( intAlpha > 0 ) then
      self:SetAlpha( intAlpha )
    else
      self.fadeOut = nil
      self:Hide()
    end
  end
end

function eCastingBar_ResetSettings()
	ECB_addChat(CASTINGBAR_RESET)
	eCastingBar_Saved = {}
  -- reset General Options
	for option in pairs(CASTING_BAR_DEFAULTS) do
		eCastingBar_Saved[option] = CASTING_BAR_DEFAULTS[option]
	end
  -- reset Colors
	for color in pairs(CASTING_BAR_DEFAULT_COLORS) do
		eCastingBar_Saved[color] = CASTING_BAR_DEFAULT_COLORS[color]
	end
  setup()
  
  for option in pairs(CASTING_BAR_BUTTONS) do
    local btn = _G["eCastingBar"..option]
    btn:SetChecked(eCastingBar_Saved[option] == 1 and true or false)
  end
end

function eCastingBar_CheckSettings()
  -- reset General Options
	for option in pairs(CASTING_BAR_DEFAULTS) do
		if (eCastingBar_Saved[option] == nil) then
			eCastingBar_Saved[option] = CASTING_BAR_DEFAULTS[option]
		end
	end
  -- check for nil colors
	for color in pairs(CASTING_BAR_DEFAULT_COLORS) do
		if (eCastingBar_Saved[color] == nil) then
			eCastingBar_Saved[color] = CASTING_BAR_DEFAULT_COLORS[color]
		end
  end

  for option in pairs(CASTING_BAR_BUTTONS) do
    local btn = _G["eCastingBar"..option]
    btn:SetChecked(eCastingBar_Saved[option] == 1 and true or false)
  end
end

function setup()
	eCastingBar_checkEnabled()
	eCastingBar_checkLocked()
	eCastingBar_checkBorders()
  	eCastingBar_checkTimeColors()
	eCastingBar_setLagColor()
	eCastingBar_setDelayColor()
	eCastingBar_SetSize()
	eCastingBar_checkFlashBorderColors()
	eCastingBar_checkTextures()
	eCastingBar_setIcons()

	testMode()
	testModeMirror()
end

--[[ Iniitialization ]]--

function eCastingBar_LoadVariables()	
    setup()
    eCastingBar_SetSavedSettingsMenu()
    
    -- make the casting bar link to the movable button
		eCastingBar:SetPoint("TOPLEFT", "eCastingBar_Outline", "TOPLEFT", 0, 0 )
    
    -- make the mirror casting bar link to the movable button
		eCastingBarMirror1:SetPoint("TOPLEFT", "eCastingBarMirror_Outline", "TOPLEFT", 0, 0 )
		
    -- reset variables
    for index, option in pairs(frameSuffixes) do
      _G["eCastingBar"..option].casting = nil
      _G["eCastingBar"..option].holdTime = 0
    end
    
		SlashCmdList["ECASTINGBAR"] = eCastingBar_SlashHandler
		SLASH_ECASTINGBAR1 = "/eCastingBar"
		SLASH_ECASTINGBAR2 = "/eCB"
		SLASH_ECASTINGBAR3 = "/???"    
    -- resolution
    SetResolution(GetScreenResolutions())
    --[[
    local i,j = string.find(eCastingBar_Resolution, "x")
    eCastingBar_ResolutionWidth = tonumber(string.sub(eCastingBar_Resolution, 0, i - 1))
    eCastingBar_ResolutionHeight = tonumber(string.sub(eCastingBar_Resolution, i + 1, string.len(eCastingBar_Resolution)))
    ]]
    -- override these for now until I can figure out why blizzard is jacked up
    eCastingBar_ResolutionWidth = 2000
    eCastingBar_ResolutionHeight = 2000
    
    setupConfigFrame()
    setupDefaultConfigFrame()
    setupColorsConfigFrame()
end

function setupConfigFrame()
  -- set all text values
  eCB_Option_DefaultsButton:SetText(CASTINGBAR_DEFAULTS_BUTTON)
  eCB_Option_CloseButton:SetText(CASTINGBAR_CLOSE_BUTTON)
  eCastingBarSaveSettingsButton:SetText(CASTINGBAR_SAVE_BUTTON)
  eCastingBarLoadSettingsButton:SetText(CASTINGBAR_LOAD_BUTTON)
  eCastingBarDeleteSettingsButton:SetText(CASTINGBAR_DELETE_BUTTON)
end

function setupDefaultConfigFrame()
  -- set all text values
  for option in pairs(CASTING_BAR_BUTTONS) do
    local btnText = _G["eCastingBar"..option.."Text"]
    btnText:SetText(CASTING_BAR_BUTTONS[option])
  end
  
  eCastingBarStatusBarText:SetJustifyH(CASTING_BAR_SPELL_JUSTIFY)
  eCastingBarSelectTexture_Label:SetText(CASTINGBAR_CASTINGBAR_TEXTURE_TEXT)
  eCastingBarSelectTexture_Setting:SetText(eCastingBar_Saved.Texture)

  eCastingBarIconPosition_Label:SetText(CASTINGBAR_ICON_POSITION_TEXT)
  eCastingBarIconPosition_Setting:SetText(_G["CASTINGBAR_"..eCastingBar_Saved.IconPosition.."_TEXT"])
  
	for index, option in pairs(frameSuffixes) do
		local	Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[option.."SpellColor"])
		_G["eCastingBar"..option.."ExampleStatusBar"]:SetStatusBarColor( Red, Green, Blue, Alpha )
	end
  local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved.BreathColor)
  eCastingBarMirrorExampleStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
  
  eCastingBarMirrorSelectTexture_Label:SetText(CASTINGBAR_MIRRORBAR_TEXTURE_TEXT)
  eCastingBarMirrorSelectTexture_Setting:SetText(eCastingBar_Saved.MirrorTexture)
  
  for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
    _G["eCastingBarMirror"..index.."StatusBarText"]:SetJustifyH(CASTING_BAR_SPELL_JUSTIFY)
  end

	-- Disable the Load and Delete Buttons on Startup
	eCastingBarLoadSettingsButton:Disable(); 
	eCastingBarDeleteSettingsButton:Disable();
  
  local slider, sliderText, low, high, width, height
  local optionTabs = { "", "Mirror", }
  
  for index, option in pairs(optionTabs) do
    local slidervalue
    -- setup the width slider
    slider = _G["eCastingBar"..option.."WidthSlider"]
    sliderText = _G["eCastingBar"..option.."WidthSliderText"]
    low = _G["eCastingBar"..option.."WidthSliderLow"]
    high = _G["eCastingBar"..option.."WidthSliderHigh"]
    slidervalue = eCastingBar_Saved[option.."Width"]
    slider:SetMinMaxValues(CASTING_BAR_SLIDER_WIDTH_MIN, eCastingBar_ResolutionWidth)
    slider:SetValueStep(1)
    slider:SetValue(slidervalue)
    sliderText:SetText(CASTINGBAR_SLIDER_WIDTH_TEXT)
    low:SetText(CASTING_BAR_SLIDER_WIDTH_MIN)
    high:SetText(eCastingBar_ResolutionWidth)
    
    -- setup the height slider
    slidervalue = eCastingBar_Saved[option.."Height"]
    slider = _G["eCastingBar"..option.."HeightSlider"]
    sliderText = _G["eCastingBar"..option.."HeightSliderText"]
    low = _G["eCastingBar"..option.."HeightSliderLow"]
    high = _G["eCastingBar"..option.."HeightSliderHigh"]
    
    slider:SetMinMaxValues(CASTING_BAR_SLIDER_HEIGHT_MIN, CASTING_BAR_SLIDER_HEIGHT_MAX)
    slider:SetValueStep(1)
    slider:SetValue(slidervalue)
    sliderText:SetText(CASTINGBAR_SLIDER_HEIGHT_TEXT)
    low:SetText(CASTING_BAR_SLIDER_HEIGHT_MIN)
    high:SetText(CASTING_BAR_SLIDER_HEIGHT_MAX)
    
    -- setup the x slider
    slider = _G["eCastingBar"..option.."LeftSlider"]
    sliderText = _G["eCastingBar"..option.."LeftSliderText"]
    low = _G["eCastingBar"..option.."LeftSliderLow"]
    high = _G["eCastingBar"..option.."LeftSliderHigh"]
    
    if (option == "Mirror") then
      width = tonumber(string.format("%.0f", _G["eCastingBarMirror1"]:GetWidth()))
      height = tonumber(string.format("%.0f", _G["eCastingBarMirror1"]:GetHeight()))
    else
      width = tonumber(string.format("%.0f", _G["eCastingBar"..option]:GetWidth()))
      height = tonumber(string.format("%.0f", _G["eCastingBar"..option]:GetHeight()))
    end
    slidervalue = eCastingBar_Saved[option.."Left"]
    slider:SetMinMaxValues(-1000, eCastingBar_ResolutionWidth)
    slider:SetValueStep(1)
    slider:SetValue(slidervalue)
    sliderText:SetText(CASTINGBAR_SLIDER_LEFT_TEXT)
    low:SetText(-1000)
    high:SetText(eCastingBar_ResolutionWidth)
    
    -- setup the y slider
    slider = _G["eCastingBar"..option.."BottomSlider"]
    sliderText = _G["eCastingBar"..option.."BottomSliderText"]
    low = _G["eCastingBar"..option.."BottomSliderLow"]
    high = _G["eCastingBar"..option.."BottomSliderHigh"]
    
    slidervalue = eCastingBar_Saved[option.."Bottom"]
    slider:SetMinMaxValues(-1000, eCastingBar_ResolutionHeight)
    slider:SetValueStep(1)
    slider:SetValue(slidervalue)
    sliderText:SetText(CASTINGBAR_SLIDER_BOTTOM_TEXT)
    low:SetText(-1000)
    high:SetText(eCastingBar_ResolutionHeight)
    
    -- setup the font slider
    slider = _G["eCastingBar"..option.."FontSlider"]
    sliderText = _G["eCastingBar"..option.."FontSliderText"]
    low = _G["eCastingBar"..option.."FontSliderLow"]
    high = _G["eCastingBar"..option.."FontSliderHigh"]
    
    slidervalue = eCastingBar_Saved[option.."FontSize"]
    slider:SetMinMaxValues(6, 40)
    slider:SetValueStep(1)
    slider:SetValue(slidervalue)
    sliderText:SetText(CASTINGBAR_SLIDER_FONT_TEXT)
    low:SetText(6)
    high:SetText(40)
    
    -- setup the alpha slider
    slider = _G["eCastingBar"..option.."AlphaSlider"]
    sliderText = _G["eCastingBar"..option.."AlphaSliderText"]

    low = _G["eCastingBar"..option.."AlphaSliderLow"]
    high = _G["eCastingBar"..option.."AlphaSliderHigh"]
    slidervalue = eCastingBar_Saved[option.."Alpha"]
    slider:SetMinMaxValues(0, 100)
    slider:SetValueStep(1)
    slider:SetValue(slidervalue)
    sliderText:SetText(CASTINGBAR_SLIDER_ALPHA_TEXT)
    low:SetText("0%")
    high:SetText("100%")
  end
end

function setupColorsConfigFrame()
  -- set the textures
  for color in pairs(CASTINGBAR_COLOR_LABEL) do
    local btnColor = _G["btn"..color.."Texture"]
    
    -- set the texture
    btnColor:SetTexture(CASTING_BAR_COLOR_TEXTURE)
    
    -- set the vertex color
    btnColor:SetVertexColor(unpack(eCastingBar_Saved[color]))
    
    -- set the label
    _G["lbl"..color.."Text"]:SetText(CASTINGBAR_COLOR_LABEL[color])
  end
end

function SetResolution(...)
  local iRes = GetCurrentResolution()
  for i=1, select("#",...), 1 do
    if (iRes == i) then
    	eCastingBar_Resolution = select(i,...)
    end
  end
end

--[[ Handles all the slash commands if cosmos isn't present. ]]--

function eCastingBar_SlashHandler( strMessage )
  local command, param
  -- make it it all lower case to be sure
	strMessage = string.lower( strMessage )
  
  if(index) then
		command = string.sub(strMessage, 1, (index - 1))
		param = string.sub(strMessage, (index + 1)  )
	else
		command = strMessage
	end
  
	if( command == CASTINGBAR_CHAT_C1 ) then 
    ShowUIPanel(eCB_OptionFrame);
  elseif ( command == CASTINGBAR_CHAT_C2) then
    eCastingBar_ChatHelp()
	else
    ShowUIPanel(eCB_OptionFrame);
	end
	
  setupDefaultConfigFrame()
  setupColorsConfigFrame()
end

--[[ Handles chat help messages. ]]--

function eCastingBar_ChatHelp()
	local intIndex = 0
	local strMessage = ""
	
  -- prints each line in CASTINGBAR_HELP = { }
	for intIndex, strMessage in pairs(CASTINGBAR_HELP) do
		ECB_addChat( strMessage )
	end
end

function getFormattedNumber(number)
	if (strlen(number) < 2 ) then
		return "0"..number
	else
		return number
	end	
end

--[[ Starts moving the frame. ]]--

function eCastingBar_MouseUp( strButton, frmFrame, frameType )
	if( eCastingBar_Saved[frameType.."Locked"] == 0 ) then
		_G[ frmFrame ]:StopMovingOrSizing()

    eCastingBar_Saved[frameType.."Left"] = _G[frmFrame]:GetLeft()
    eCastingBar_Saved[frameType.."Bottom"] = _G[frmFrame]:GetBottom()
    
    _G["eCastingBar"..frameType.."LeftSlider"]:SetValue(eCastingBar_Saved[frameType.."Left"])
    _G["eCastingBar"..frameType.."BottomSlider"]:SetValue(eCastingBar_Saved[frameType.."Bottom"])
	end
end

--[[ Stops moving the frame. ]]--

function eCastingBar_MouseDown( strButton, frmFrame, frameType )

	if( strButton == "LeftButton" and (eCastingBar_Saved[frameType.."Locked"] == 0 ) ) then
		_G[ frmFrame ]:StartMoving()
	end
end

function eCastingBarGeneral_MouseUp( strButton, frmFrame )
		_G[ frmFrame ]:StopMovingOrSizing()
end

--[[ Stops moving the frame. ]]--

function eCastingBarGeneral_MouseDown( strButton, frmFrame, frameType )
	if( strButton == "LeftButton") then
		_G[ frmFrame ]:StartMoving()
	end
end

function eCastingBar_getShowTotalTime()
	return eCastingBar_Saved.ShowTotalTime
end

function eCastingBar_setShowTotalTime( intShowTotalTime )
	eCastingBar_Saved.ShowTotalTime = intShowTotalTime
end

function eCastingBar_getShowDelay()
	return eCastingBar_Saved.ShowDelay
end

function eCastingBar_setShowDelay( intShowDelay )
	eCastingBar_Saved.ShowDelay = intShowDelay
end

function eCastingBar_checkBorders()
  for index, option in pairs(frameSuffixes) do
  	local bar = _G["eCastingBar"..option]
    if (eCastingBar_Saved[option.."HideBorder"] == 1) then
      bar:SetBackdrop(nil)
    else
      bar:SetBackdrop({bgFile = CASTING_BAR_BACKGROUND_FILE, edgeFile = CASTING_BAR_EDGE_FILE, tile = true, tileSize = 16, edgeSize = 16, insets = { left = 2, right = 2, top = 2, bottom = 2 }}) 
      bar:SetBackdropColor(0,0,0,0.5)
    end
  end
  for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
  	local bar = _G["eCastingBarMirror"..index]
    if (eCastingBar_Saved.MirrorHideBorder == 1) then
      bar:SetBackdrop(nil)
    else
      bar:SetBackdrop({bgFile = CASTING_BAR_BACKGROUND_FILE, edgeFile = CASTING_BAR_EDGE_FILE, tile = true, tileSize = 16, edgeSize = 16, insets = { left = 2, right = 2, top = 2, bottom = 2 }}) 
      bar:SetBackdropColor(0,0,0,0.5)
    end
  end
end

--[[-------------------------------------------
	Functions for Locked State
-------------------------------------------]]--

function eCastingBar_checkLocked()
	local barOutline = _G["eCastingBar_Outline"]
	if(eCastingBar_Saved["Locked"] == 0 and eCastingBar_Saved["Enabled"] == 1) then
		barOutline:Show()
	else
		barOutline:Hide()
		_G["eCastingBar"]:Hide()
	end

	-- only show the outline if we are enabled
	if (eCastingBar_Saved.MirrorEnabled == 1 and eCastingBar_Saved.MirrorLocked == 0) then
		eCastingBarMirror_Outline:Show()
	else
		eCastingBarMirror_Outline:Hide()
		_G["eCastingBarMirror1"]:Hide()
	end
end

--[[-------------------------------------------
	Functions for Enabled State
-------------------------------------------]]--

--[[ Disables the frame. ]]--

function eCastingBar_Disable( frame )
  eCastingBar_Saved[frame.."Enabled"] = 0
  local bar = _G["eCastingBar"..frame]
  if (frame == "") then
		local oldbar = CastingBarFrame
		if (BCastBarCastBar) then
			oldbar = BCastBarCastBar
		end
  	oldbar.showCastbar = true
 		if CastingInfo(oldbar.unit) or ChannelInfo(oldbar.unit) then
		oldbar:Show()
	end

  end
 	if bar.casting then
		bar:Hide()
	end
  -- the frame unlocked?
	if( eCastingBar_Saved[frame.."Locked"] == 0 ) then
    -- yes, lets hide the outline
		_G["eCastingBar"..frame.."_Outline"]:Hide()
	end
end


--[[ Enables the frame. ]]--

function eCastingBar_Enable( frame )
  eCastingBar_Saved[frame.."Enabled"] = 1  
  local bar = _G["eCastingBar"..frame]
  if (frame == "") then
		local oldbar = CastingBarFrame
		if (BCastBarCastBar) then
			oldbar = BCastBarCastBar
		end
  	oldbar.showCastbar = nil;
  	oldbar:Hide();
	end
	if CastingInfo(bar.unit) or ChannelInfo(bar.unit) then
		bar:Show()
	end
  -- the frame unlocked?
	if( eCastingBar_Saved[frame.."Locked"] == 0 ) then
    -- yes, lets show the outline
		_G["eCastingBar"..frame.."_Outline"]:Show()
	end
end

--[[ Toggle enabled state. ]]--

function eCastingBar_checkEnabled()
  for index, option in pairs(frameSuffixes) do
  	if (eCastingBar_Saved[option.."Enabled"] == 1) then
  		eCastingBar_Enable(option)
    else
      eCastingBar_Disable(option)
  	end
  end
  
  for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
    if (eCastingBar_Saved.MirrorEnabled == 1) then
  		if( eCastingBar_Saved.MirrorLocked == 0 ) then	
        -- yes, lets show the outline
        _G["eCastingBarMirror_Outline"]:Show()  
      end		
    else
      if( eCastingBar_Saved.MirrorLocked == 0 ) then
        -- yes, lets hide the outline
        _G["eCastingBarMirror_Outline"]:Hide()
      end
  	end
  end
end

--[[-------------------------------------------
	Functions for using the Texture 
-------------------------------------------]]--

--[[ Toggle enabled state. ]]--

function eCastingBar_checkTextures()
  for index, option in pairs(frameSuffixes) do
  	if eCastingBar_Saved[option.."Texture"] == nil then 
  		eCastingBar_Saved[option.."Texture"] = "Perl"
  	end
  	if eCastingBar_Saved[option.."Texture"] == "Halycon" then
  		eCastingBar_Saved[option.."Texture"] = "Halcyon"
  	end
    _G["eCastingBar"..option.."StatusBarTexture"]:SetTexture( CASTING_BAR_TEXTURES[eCastingBar_Saved[option.."Texture"]] )
    _G["eCastingBar"..option.."StatusBarTexture"]:SetWidth(20)
    _G["eCastingBar"..option.."StatusBarTexture"]:SetHeight(10)
    _G["eCastingBar"..option.."StatusBarTexture"]:SetHorizTile(True)
    _G["eCastingBar"..option.."StatusBarTexture"]:SetVertTile(True)
    _G["eCastingBar"..option.."LagBarTexture"]:SetTexture( CASTING_BAR_TEXTURES[eCastingBar_Saved[option.."Texture"]] )
    _G["eCastingBar"..option.."LagBarTexture"]:SetWidth(20)
    _G["eCastingBar"..option.."LagBarTexture"]:SetHeight(10)
    _G["eCastingBar"..option.."LagBarTexture"]:SetHorizTile(True)
    _G["eCastingBar"..option.."LagBarTexture"]:SetVertTile(True)
    _G["eCastingBar"..option.."ExampleStatusBarTexture"]:SetTexture( CASTING_BAR_TEXTURES[eCastingBar_Saved[option.."Texture"]] )
    _G["eCastingBar"..option.."ExampleStatusBarText"]:SetText( eCastingBar_Saved[option.."Texture"] )
    _G["eCastingBar"..option.."ExampleStatusBarTexture"]:SetHorizTile(True)
    _G["eCastingBar"..option.."ExampleStatusBarTexture"]:SetVertTile(True)

  end
  
  for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
  	if eCastingBar_Saved.MirrorTexture == nil then
  		eCastingBar_Saved.MirrorTexture = "Perl"
  	end
  	if eCastingBar_Saved.MirrorTexture == "Halycon" then
  		eCastingBar_Saved.MirrorTexture = "Halcyon"
  	end
   	_G["eCastingBarMirror"..index.."StatusBarTexture"]:SetTexture( CASTING_BAR_TEXTURES[eCastingBar_Saved.MirrorTexture] )
    _G["eCastingBarMirror"..index.."StatusBarTexture"]:SetWidth(20)
    _G["eCastingBarMirror"..index.."StatusBarTexture"]:SetHeight(10)
    _G["eCastingBarMirror"..index.."StatusBarTexture"]:SetHorizTile(True)
    _G["eCastingBarMirror"..index.."StatusBarTexture"]:SetVertTile(True)

  end
  eCastingBarMirrorExampleStatusBarTexture:SetTexture( CASTING_BAR_TEXTURES[eCastingBar_Saved.MirrorTexture] )
  eCastingBarMirrorExampleStatusBarText:SetText(eCastingBar_Saved.MirrorTexture)
  eCastingBarMirrorExampleStatusBarTexture:SetHorizTile(True)
  eCastingBarMirrorExampleStatusBarTexture:SetVertTile(True)

end

function eCastingBar_setColor(colorFrame)
	if colorFrame == "SpellColor" or colorFrame == "ChannelColor" then
		local	Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[colorFrame])
  	eCastingBarExampleStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
  	if (eCastingBar.casting) then
  	  local	Red, Green, Blue, Alpha = unpack(eCastingBar_Saved.SpellColor)
		  eCastingBarStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
		elseif (eCastingBar.channeling) then
			local	Red, Green, Blue, Alpha = unpack(eCastingBar_Saved.ChannelColor)
  		eCastingBarStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
  	end
	else
		local	Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[colorFrame])
  	eCastingBarMirrorExampleStatusBar:SetStatusBarColor( Red, Green, Blue, Alpha )
		local timer = strupper(gsub(colorFrame, "Color", ""))
	  for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
			local frame = _G["eCastingBarMirror"..index];
			if ( frame:IsVisible() and (frame.timer == timer) ) then
				local	Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[colorFrame])
  			_G["eCastingBarMirror"..index.."StatusBar"]:SetStatusBarColor( Red, Green, Blue, Alpha )
  		end
  	end
  end
end

--I love my girlfriend Elise so so much, this commented line's for her <3
function eCastingBar_setIcons()
  for index, option in pairs(frameSuffixes) do
  	if (eCastingBar_Saved[option.."IconPosition"] == nil) then 
  		eCastingBar_Saved[option.."IconPosition"] = "HIDDEN"
  	end
  	if (eCastingBar_Saved[option.."IconPosition"] == "LEFT") then
	  	_G["eCastingBar"..option.."StatusBarIcon"]:ClearAllPoints()
			_G["eCastingBar"..option.."StatusBarIcon"]:SetPoint("RIGHT", _G["eCastingBar"..option], "LEFT", -5)
			if _G["eCastingBar"..option].casting or _G["eCastingBar"..option].channeling then
				_G["eCastingBar"..option.."StatusBarIcon"]:Show()
			end
		elseif (eCastingBar_Saved[option.."IconPosition"] == "RIGHT") then
	  	_G["eCastingBar"..option.."StatusBarIcon"]:ClearAllPoints()
			_G["eCastingBar"..option.."StatusBarIcon"]:SetPoint("LEFT", _G["eCastingBar"..option], "RIGHT", 5)
			if _G["eCastingBar"..option].casting or _G["eCastingBar"..option].channeling then
				_G["eCastingBar"..option.."StatusBarIcon"]:Show()
			end
		else
			_G["eCastingBar"..option.."StatusBarIcon"]:Hide()
		end
  end
end

function eCastingBar_checkTimeColors()
  for index, option in pairs(frameSuffixes) do
    local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[option.."TimeColor"])
    _G["eCastingBar"..option.."StatusBar_Time"]:SetTextColor(Red,Green,Blue, Alpha )
  end
  local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved.MirrorTimeColor)
  for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
    _G["eCastingBarMirror"..index.."StatusBar_Time"]:SetTextColor(Red,Green,Blue, Alpha )
  end
  for index, option in pairs(frameSuffixes) do
    local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[option.."TimeColor"])
    _G["eCastingBar"..option.."StatusBar_TotalTime"]:SetTextColor(Red,Green,Blue, Alpha )
  end
end

function eCastingBar_setDelayColor()
  for index, option in pairs(frameSuffixes) do
    local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[option.."DelayColor"])
    _G["eCastingBar"..option.."StatusBar_Delay"]:SetTextColor(Red,Green,Blue, Alpha )
  end
end

function eCastingBar_setLagColor()
  for index, option in pairs(frameSuffixes) do
    local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[option.."LagColor"])
    _G["eCastingBar"..option.."LagBar"]:SetStatusBarColor(Red,Green,Blue, Alpha )
  end
end

--[[ sets up the flash to look cool ]]--

--(thanks goes to kaitlin for the code used while resting). 

function eCastingBar_checkFlashBorderColors()
	local frmFrame = "eCastingBarFlash"
	local intIndex = 0
	local strBorder = ""
  
  for index, option in pairs(frameSuffixes) do
    local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[option.."FlashBorderColor"])
    
    -- for each border in eCastingBar__FlashBorders set the color to gold.
    for intIndex, strBorder in pairs(eCastingBar__FlashBorders) do
      _G[ "eCastingBar"..option.."Flash_"..strBorder ]:SetVertexColor( Red, Green, Blue, Alpha )	
    end
  end
	
  for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
    local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved.MirrorFlashBorderColor)
    for intIndex, strBorder in pairs(eCastingBar__FlashBorders) do
      _G[ "eCastingBarMirror"..index.."Flash_"..strBorder ]:SetVertexColor( Red, Green, Blue, Alpha )	
    end
  end
end


-- Sets the width and height of the casting bar

function eCastingBar_SetSize()
  local width, height, bottom, left, bar
  for index, option in pairs(frameSuffixes) do
    -- check boundaries
    if (eCastingBar_Saved[option.."Width"] < CASTING_BAR_SLIDER_WIDTH_MIN) then
      width = CASTING_BAR_SLIDER_WIDTH_MIN
    elseif (eCastingBar_Saved[option.."Width"] > CASTING_BAR_SLIDER_WIDTH_MAX ) then
      width = CASTING_BAR_SLIDER_WIDTH_MAX
    else
      width = eCastingBar_Saved[option.."Width"]
    end
    
    if (eCastingBar_Saved[option.."Height"] > CASTING_BAR_SLIDER_HEIGHT_MAX) then
      height = CASTING_BAR_SLIDER_HEIGHT_MAX
    elseif (eCastingBar_Saved[option.."Height"] < CASTING_BAR_SLIDER_HEIGHT_MIN ) then
      height = CASTING_BAR_SLIDER_HEIGHT_MIN
    else
      height = eCastingBar_Saved[option.."Height"]
    end
    
    left = eCastingBar_Saved[option.."Left"]
    bottom = eCastingBar_Saved[option.."Bottom"]
    
    --[[
    if (eCastingBar_Saved[option.."Left"] < 0) then
      left = 0;
    else
      left = eCastingBar_Saved[option.."Left"];
    end
    
    if (eCastingBar_Saved[option.."Bottom"] < 0 ) then
      bottom = 0;;
    else
      bottom = eCastingBar_Saved[option.."Bottom"];
    end
    ]]--
    
    _G["eCastingBar"..option]:SetWidth(width)
    _G["eCastingBar"..option]:SetHeight(height)
    
    _G["eCastingBar"..option.."Background"]:SetWidth(width - 9)
    _G["eCastingBar"..option.."Background"]:SetHeight(height - 10)
    
    _G["eCastingBar"..option.."Flash"]:SetWidth(width)
    _G["eCastingBar"..option.."Flash"]:SetHeight(height)
    
    _G["eCastingBar"..option.."StatusBar"]:SetWidth(width - 9)
    _G["eCastingBar"..option.."StatusBar"]:SetHeight(height - 10)
    
    _G["eCastingBar"..option.."LagBar"]:SetWidth(width - 9)
    _G["eCastingBar"..option.."LagBar"]:SetHeight(height - 10)

    _G["eCastingBar"..option.."StatusBarIcon"]:SetWidth(height - 6)
    _G["eCastingBar"..option.."StatusBarIcon"]:SetHeight(height - 6)
    
    _G["eCastingBar"..option.."_Outline"]:SetWidth(width)
    _G["eCastingBar"..option.."_Outline"]:SetHeight(height)
    _G["eCastingBar"..option.."_Outline"]:ClearAllPoints()
    _G["eCastingBar"..option.."_Outline"]:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", left, bottom )
    
    _G["eCastingBar"..option.."Flash_TOP"]:SetWidth(width - 24)
    _G["eCastingBar"..option.."Flash_BOTTOM"]:SetWidth(width - 24)
    _G["eCastingBar"..option.."Flash_LEFT"]:SetHeight(height - 24)
    _G["eCastingBar"..option.."Flash_RIGHT"]:SetHeight(height - 24)
    
    _G["eCastingBar"..option.."StatusBarSpark"]:SetHeight(height + 13)
    
    _G["eCastingBar"..option.."StatusBarText"]:SetWidth(width - 49)
    _G["eCastingBar"..option.."StatusBarText"]:SetHeight(height + 13)
    
    _G["eCastingBar"..option.."LagBarText"]:SetWidth(width - 49)
    _G["eCastingBar"..option.."LagBarText"]:SetHeight(height + 13)
    
    -- set the font size
    local fontName, _, fontFlags = _G["eCastingBar"..option.."StatusBarText"]:GetFont()
		_G["eCastingBar"..option.."StatusBarText"]:SetFont(fontName, eCastingBar_Saved[option.."FontSize"], fontFlags)
		_G["eCastingBar"..option.."LagBarText"]:SetFont(fontName, math.max(eCastingBar_Saved[option.."FontSize"]*7/12,1), fontFlags)
		_G["eCastingBar"..option.."StatusBar_Time"]:SetFont(fontName, eCastingBar_Saved[option.."FontSize"], fontFlags)

		-- set the Alpha
		local newAlpha = (eCastingBar_Saved[option.."Alpha"]/100)
		local Red, Green, Blue, Alpha = _G["eCastingBar"..option]:GetBackdropColor()
		_G["eCastingBar"..option]:SetBackdropColor(Red, Green, Blue, newAlpha)
		_G["eCastingBar"..option.."Background"]:SetAlpha(newAlpha)
		Red, Green, Blue, Alpha = _G["eCastingBar"..option.."_Outline"]:GetBackdropColor()
		_G["eCastingBar"..option.."_Outline"]:SetBackdropColor(Red, Green, Blue, newAlpha)
  end
  
  for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
    
    -- check boundaries
    if (eCastingBar_Saved.MirrorWidth < CASTING_BAR_SLIDER_WIDTH_MIN) then
      width = CASTING_BAR_SLIDER_WIDTH_MIN
    elseif (eCastingBar_Saved.MirrorWidth > CASTING_BAR_SLIDER_WIDTH_MAX ) then
      width = CASTING_BAR_SLIDER_WIDTH_MAX
    else
      width = eCastingBar_Saved.MirrorWidth
    end
    
    if (eCastingBar_Saved.MirrorHeight > CASTING_BAR_SLIDER_HEIGHT_MAX) then
      height = CASTING_BAR_SLIDER_HEIGHT_MAX
    elseif (eCastingBar_Saved.MirrorHeight < CASTING_BAR_SLIDER_HEIGHT_MIN ) then
      height = CASTING_BAR_SLIDER_HEIGHT_MIN
    else
      height = eCastingBar_Saved.MirrorHeight
    end
    
    left = eCastingBar_Saved.MirrorLeft
    bottom = eCastingBar_Saved.MirrorBottom
    
    --[[
    if (eCastingBar_Saved.MirrorLeft < 0) then
      left = 0
    else
      left = eCastingBar_Saved.MirrorLeft
    end
    
    if (eCastingBar_Saved.MirrorBottom < 0 ) then
      bottom = 0
    else
      bottom = eCastingBar_Saved.MirrorBottom
    end
    ]]--
    
    _G["eCastingBarMirror"..index]:SetWidth(width)
    _G["eCastingBarMirror"..index]:SetHeight(height)
    
    _G["eCastingBarMirror"..index.."Background"]:SetWidth(width - 9)
    _G["eCastingBarMirror"..index.."Background"]:SetHeight(height - 10)
   
    _G["eCastingBarMirror"..index.."Flash"]:SetWidth(width)
    _G["eCastingBarMirror"..index.."Flash"]:SetHeight(height)
    
    _G["eCastingBarMirror"..index.."StatusBar"]:SetWidth(width - 9)
    _G["eCastingBarMirror"..index.."StatusBar"]:SetHeight(height - 10)
    
    _G["eCastingBarMirror_Outline"]:SetWidth(width)
    _G["eCastingBarMirror_Outline"]:SetHeight(height)
    _G["eCastingBarMirror_Outline"]:ClearAllPoints()
    _G["eCastingBarMirror_Outline"]:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", left, bottom )
    
    _G["eCastingBarMirror"..index.."Flash_TOP"]:SetWidth(width - 24)
    _G["eCastingBarMirror"..index.."Flash_BOTTOM"]:SetWidth(width - 24)
    _G["eCastingBarMirror"..index.."Flash_LEFT"]:SetHeight(height - 24)
    _G["eCastingBarMirror"..index.."Flash_RIGHT"]:SetHeight(height - 24)
    
    _G["eCastingBarMirror"..index.."StatusBarSpark"]:SetHeight(height + 13)
    
    _G["eCastingBarMirror"..index.."StatusBarText"]:SetWidth(width - 49)
    _G["eCastingBarMirror"..index.."StatusBarText"]:SetHeight(height + 13)
    
    -- set the font size
    local fontName, _, fontFlags = _G["eCastingBarMirror"..index.."StatusBarText"]:GetFont()
		_G["eCastingBarMirror"..index.."StatusBarText"]:SetFont(fontName, eCastingBar_Saved.MirrorFontSize, fontFlags)
		_G["eCastingBarMirror"..index.."StatusBar_Time"]:SetFont(fontName, eCastingBar_Saved.MirrorFontSize, fontFlags)
		-- set the Alpha
		local newAlpha = (eCastingBar_Saved.MirrorAlpha/100)
		local Red, Green, Blue, Alpha = _G["eCastingBarMirror"..index]:GetBackdropColor()
		_G["eCastingBarMirror"..index]:SetBackdropColor(Red, Green, Blue, newAlpha)
		_G["eCastingBarMirror"..index.."Background"]:SetAlpha(newAlpha)
		Red, Green, Blue, Alpha = eCastingBarMirror_Outline:GetBackdropColor()
		eCastingBarMirror_Outline:SetBackdropColor(Red, Green, Blue, newAlpha)
  end
end

function eCastingBar_Copy_Table(src, dest)
	for index, value in pairs(src) do
		if (type(value) == "table") then
			dest[index] = {};
			eCastingBar_Copy_Table(value, dest[index]);
		else
			dest[index] = value;
		end
	end
end
