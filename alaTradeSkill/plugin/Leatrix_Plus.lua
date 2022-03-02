--[[--
	by ALA @ 163UI
--]]--

local __addon__, __namespace__ = ...;


-->		****
__namespace__:BuildEnv("Leatrix_Plus");
-->		****


__namespace__:AddAddOnCallback("Leatrix_Plus", function()
	if LeaPlusDB ~= nil then
		LeaPlusDB["EnhanceProfessions"] = "Off";
	end
	__namespace__.F_uiFrameFixSkillList();
end);

