function eCastingBarMirror_Show(timer, value, maxvalue, scale, paused, label)
-- Pick a free dialog to use
	local dialog = nil;
	if ( not dialog ) then
-- Find an open dialog of the requested type
		for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
			local frame = _G["eCastingBarMirror"..index];
			if ( frame:IsShown() and (frame.timer == timer) ) then
				dialog = frame;
				break;
			end
		end
	end
	if ( not dialog ) then
		-- Find a free dialog
		for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
			local frame = _G["eCastingBarMirror"..index];
			if ( not frame:IsShown() ) then
				dialog = frame;
				break;
			end
		end
	end
	if ( not dialog ) then
		return nil;
	end
  dialog.unknown = nil
  dialog.flash = nil
  dialog.fadeOut = nil
	dialog.timer = timer;
	dialog.value = (value / 1000);
	dialog.scale = scale;
	dialog.startTime = GetTime()
	if ( paused > 0 ) then
		dialog.paused = 1;
	else
		dialog.paused = nil;
	end
  
-- Set the text of the dialog
--	local text = _G[dialog:GetName().."StatusBarText"];
--	text:SetText(label);
  
-- Set the status bar of the dialog
	local statusbar = _G[dialog:GetName().."StatusBar"];
  local Red, Green, Blue, Alpha
  if (timer == "FEIGNDEATH") then
    Red, Green, Blue, Alpha = unpack(eCastingBar_Saved.FeignDeathColor)
  elseif (timer == "EXHAUSTION") then
    Red, Green, Blue, Alpha = unpack(eCastingBar_Saved.ExhaustionColor)
  elseif (timer == "BREATH") then
    Red, Green, Blue, Alpha = unpack(eCastingBar_Saved.BreathColor)
  elseif (timer == "FLIGHT") then
    Red, Green, Blue, Alpha = unpack(eCastingBar_Saved.FlightColor)
  else
    Red, Green, Blue, Alpha = unpack(eCastingBar_Saved.ChannelColor)
  end
	statusbar:SetStatusBarColor(Red, Green, Blue, Alpha);
	if (timer == "FLIGHT" and value == 0) then 
		dialog.unknown = 1
		statusbar:SetMinMaxValues(0, 1);
		statusbar:SetValue(1);
		_G[statusbar:GetName().."Spark"]:Hide()
		_G[dialog:GetName().."Flash"]:Hide()


	else
 		statusbar:SetMinMaxValues(0, (maxvalue / 1000));
		statusbar:SetValue(dialog.value);
		_G[statusbar:GetName().."Spark"]:Show()
	end
  
-- set the text to the timer label
  if ( eCastingBar_Saved["MirrorShowTimerLabel"] == 1 ) then
  	_G[statusbar:GetName().."Text"]:SetText( label )
  else
    _G[statusbar:GetName().."Text"]:SetText( "" ) 
  end
	
-- set the bar to fully opaque
	dialog:SetAlpha( 1.0 )
	if (eCastingBar_Saved.MirrorEnabled == 1 or dialog.timer == "FLIGHT") then
		dialog:Show();
	end;
	return dialog;
end

function eCastingBarMirror_OnLoad(self)
	self:RegisterEvent("MIRROR_TIMER_START");
	self:RegisterEvent("MIRROR_TIMER_PAUSE");
	self:RegisterEvent("MIRROR_TIMER_STOP");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self.timer = nil;
	self.frame = "MirrorBar";
end


function eCastingBarMirror_OnEvent(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6 = ...;

	if( eCastingBar_Saved.MirrorEnabled == 0 or eCastingBar_Saved.MirrorLocked == 0 ) then
		return
	end

	if ( event == "PLAYER_ENTERING_WORLD" ) then
		self:Hide();
		self.timer = nil;
	end
	if( event == "MIRROR_TIMER_START" ) then
		if (eCastingBar_Saved.MirrorEnabled == 1) then 
      -- if we are not using Blizzards timers we should hide it.
			hideBlizzardMirrorFrame(arg1)
		else
      -- else make sure its shown
			showBlizzardMirrorFrame(arg1)
		end
		eCastingBarMirror_Show(arg1, arg2, arg3, arg4, arg5, arg6)
	end
	if (arg1 ~= self.timer) then
		return;
	end
	if ( event == "MIRROR_TIMER_PAUSE" ) then
		if ( arg1 > 0 ) then
			self.paused = 1;
		else
			self.paused = nil;
		end
		return;
	end
	if ( event == "MIRROR_TIMER_STOP" ) then
		_G[self:GetName().."Flash"]:SetAlpha( 0.0 )
		_G[self:GetName().."Flash"]:Show()
		self.flash = 1
		self.fadeOut = 1
		for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
			local frame = _G["MirrorTimer"..index]
			if frame.timer == self.timer then
				frame.timer = nil
			end
		end
	end
end

function eCastingBarMirror_OnUpdate(frame, elapsed)

	if ( not frame or frame.paused or not frame.timer or not frame.value ) then
		return;
	end

	if(eCastingBar_Saved.MirrorEnabled == 0 or eCastingBar_Saved.MirrorLocked == 0 ) then
		return
	end

	local statusbar = _G[frame:GetName().."StatusBar"];

  	if( frame.flash ) then
    	local intAlpha = _G[frame:GetName().."Flash"]:GetAlpha() + CASTING_BAR_FLASH_STEP
    	_G[frame:GetName().."StatusBar_Time"]:SetText( "" )
    	if( intAlpha < 1 ) then
      		_G[frame:GetName().."Flash"]:SetAlpha( intAlpha )
	    else
			frame.flash = nil
	    end
  	elseif ( frame.fadeOut ) then
    	local intAlpha = frame:GetAlpha() - CASTING_BAR_ALPHA_STEP
    	if( intAlpha > 0 ) then
      		frame:SetAlpha( intAlpha )
    	else
			frame.fadeOut = nil
			frame.timer = nil
			frame:Hide()
	    end
	elseif (frame.unknown) then
		_G[frame:GetName().."StatusBar_Time"]:SetText("(Unknown)")
  	else
    	if frame.timer == "FLIGHT" then
	    	frame.value = (frame.value + frame.scale * elapsed);
		else
			frame.value = GetMirrorTimerProgress(frame.timer)  / 1000;
		end;
    	statusbar:SetValue(frame.value);
    
    local intTimeLeft = frame.value
    local intBarValue = 0
    local min, max = statusbar:GetMinMaxValues();
    local intSparkPosition = max
    
-- Thanks to wbb at Cursed for the lovely formating
    if (eCastingBar_Saved.MirrorShowTime == 1) then    	
-- if we are over 1 minute, do minute:seconds
      local timeLeft = math.max( intTimeLeft - min, 0.0 )
      local timeMsg = nil
      
      local minutes = 0
      local seconds = 0
      
      if (timeLeft > max) then
        timeLeft = max
      end
      
      if (timeLeft > 60) then
        minutes = math.floor( ( timeLeft  / 60 ))
        local seconds = math.ceil( timeLeft - ( 60 * minutes ))
        
        if (seconds == 60) then
          minutes = minutes + 1
          seconds = 0
        end
        timeMsg = format("%s:%s", minutes, getFormattedNumber(seconds))
      else
        timeMsg = string.format( "%.1f", timeLeft )
      end
      
      _G[statusbar:GetName().."_Time"]:SetText( timeMsg )
    else
      _G[statusbar:GetName().."_Time"]:SetText("")
    end
    
-- is the time left greater than channeling end time?
    if( intTimeLeft > max ) then
      
-- yes, set it to the channeling end time (this will happen if you get delayed longer than the time left on channeling)
      intTimeLeft = max
    end
    intBarValue = intTimeLeft
    
--reset the flash to hidden
    _G[frame:GetName().."Flash"]:Hide()
    
-- updates the spark
    local width = _G[frame:GetName().."Background"]:GetWidth()
    intSparkPosition = ( intBarValue / max ) * width
    _G[frame:GetName().."StatusBarSpark"]:SetPoint( "CENTER", frame:GetName().."StatusBar", "LEFT", intSparkPosition, 0 )
  end
end

function eCastingBarMirror_MouseUp( strButton )
	if( eCastingBar_Saved.MirrorLocked == 0 ) then
		eCastingBarMirror_Outline:StopMovingOrSizing()

    eCastingBar_Saved.MirrorLeft = eCastingBarMirror_Outline:GetLeft()
    eCastingBar_Saved.MirrorBottom = eCastingBarMirror_Outline:GetBottom()
    
    eCastingBarMirrorLeftSlider:SetValue(eCastingBar_Saved.MirrorLeft)
    eCastingBarMirrorBottomSlider:SetValue(eCastingBar_Saved.MirrorBottom)
	end
end

--[[ Stops moving the frame. ]]--
function eCastingBarMirror_MouseDown( strButton )
	if( strButton == "LeftButton" and (eCastingBar_Saved.MirrorLocked == 0 ) ) then
		eCastingBarMirror_Outline:StartMoving()
	end
end

function hideBlizzardMirrorFrame(timer)
	for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
		local frame = _G["MirrorTimer"..index]
		if (frame.timer == timer) then
			frame:Hide()
		end
	end
end

function showBlizzardMirrorFrame(timer)
	for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
		local frame = _G["MirrorTimer"..index]
		if (frame.timer == timer) then
			frame:Show()
		end
	end
end

function hideAllBlizzardMirrorFrames()
	for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
		local frame = _G["MirrorTimer"..index]
		local frame2 = _G["eCastingBarMirror"..index]
		frame:Hide()
		if (frame2.timer ~= nil and not frame2.flash) then
			frame2:Show()
		end
	end
end

function showAllBlizzardMirrorFrames()
	for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
		local frame = _G["MirrorTimer"..index]
		local frame2 = _G["eCastingBarMirror"..index]
		if frame2.timer ~= "FLIGHT" then
			frame2:Hide()
		end
		if (frame.timer ~= nil) then
			frame:Show()
		end
	end
end
