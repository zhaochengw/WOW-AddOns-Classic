--[[--
	by ALA 
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;


-->		****
MT.BuildEnv("CloudyTradeSkill");
-->		****


local function LF_Skin_CloudyTradeSkill(addon, frame)
	if frame ~= nil then
		MT.After(1.0, function()
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


MT.RegisterOnAddOnLoaded("CloudyTradeSkill", function()
	MT.FireCallback("UI_MOD_LOADED", { Skin = LF_Skin_CloudyTradeSkill, });
end);
