function LowHPPulser_OnUpdate(self, elapsed)
	if (LowHPPulserDB["instance"] == 1) then
		local inInstance = IsInInstance();
		if (inInstance == false) then
			return;
		end
	end

	if (LowHPPulserDB["health"] == 1) then
		local remaining_hp_percent = UnitHealth("player") / UnitHealthMax("player");
		LowHPPulser_CheckStatus(LowHPPulser_LowHealthFrame, remaining_hp_percent, LowHPPulserDB["healthpct"]/100)
	end

	if (LowHPPulserDB["mana"] == 1) and UnitPowerType("player") == 0 then
		local remaining_mp_percent = UnitPower("player", SPELL_POWER_MANA) / UnitPowerMax("player", SPELL_POWER_MANA);
		LowHPPulser_CheckStatus(LowHPPulser_OutOfControlFrame, remaining_mp_percent, LowHPPulserDB["manapct"]/100)
	end
end

function LowHPPulser_CheckStatus(frame, percent, trigger)
	if ( (not UnitIsDeadOrGhost("player")) and (not UnitOnTaxi("player")) and (percent <= trigger) ) then
		LowHPPulser_StartPulsing(frame)
		return
	end

	LowHPPulser_StopPulsing(frame)
end

function LowHPPulser_StartPulsing(frame)
	if (frame.pulsing == "in") then
		if (frame:GetAlpha() == 1) then
			LowHPPulser_PulseOut(frame)
		end
	elseif (frame.pulsing == "out") then
		if (frame:GetAlpha() == 0) then
			LowHPPulser_PulseIn(frame)
		end
	else
		frame:SetAlpha(0)
		LowHPPulser_PulseIn(frame)
	end
end

function LowHPPulser_StopPulsing(frame)
	frame.pulsing = false
	UIFrameFadeIn(frame, 1, frame:GetAlpha(), 0)
end

function LowHPPulser_PulseIn(frame)
	frame.pulsing = "in"
	UIFrameFadeIn(frame, 1, frame:GetAlpha(), 1)
end

function LowHPPulser_PulseOut(frame)
	frame.pulsing = "out"
	UIFrameFadeIn(frame, 1, frame:GetAlpha(), 0)
end
