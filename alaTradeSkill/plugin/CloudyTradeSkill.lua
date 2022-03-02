--[[--
	by ALA @ 163UI
--]]--

local __addon__, __namespace__ = ...;


-->		****
__namespace__:BuildEnv("CloudyTradeSkill");
-->		****


local function LF_Skin_CloudyTradeSkill(addon, frame)
	if frame ~= nil then
		C_Timer.After(1.0, function()
			local opt = _G["CTSOption-TradeSkillFrame"];
			if opt ~= nil then
				if frame.call ~= nil then
					frame.call:ClearAllPoints();
					frame.call:SetPoint("RIGHT", opt, "LEFT", -2, 0);
				end
			end
		end);
	end
end


__namespace__:AddAddOnCallback("CloudyTradeSkill", function()
	__namespace__:FireEvent("UI_MOD_LOADED", { Skin = LF_Skin_CloudyTradeSkill, });
end);
