local f = CreateFrame("Frame", "LetMeCast", UIParent)
f:RegisterEvent("UI_ERROR_MESSAGE")
f:RegisterEvent("TAXIMAP_OPENED")

f:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
	--print("arg1:", arg1, "| arg2:", arg2)
	if event == "UI_ERROR_MESSAGE" then
		if arg1 == 50 then
			if arg2 == SPELL_FAILED_NOT_STANDING then
				DoEmote("STAND")
			elseif arg2 == SPELL_FAILED_NOT_MOUNTED then
				Dismount()
			end
		elseif arg1 == 159 then
			if arg2 == ERR_LOOT_NOTSTANDING then
				DoEmote("STAND")
			end
		elseif arg1 == 198 then
			if arg2 == ERR_ATTACK_MOUNTED then
				Dismount()
			end
		elseif arg1 == 213 then
			if arg2 == ERR_TAXIPLAYERALREADYMOUNTED then
				Dismount()
			end
		elseif arg1 == 504 then
			if arg2 == ERR_NOT_WHILE_MOUNTED then
				Dismount()
			end
		end
	elseif event == "TAXIMAP_OPENED" then
		Dismount()
	end
end)

f:Hide()