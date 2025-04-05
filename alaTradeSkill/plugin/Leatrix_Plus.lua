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
MT.BuildEnv("Leatrix_Plus");
-->		****


MT.RegisterOnAddOnLoaded("Leatrix_Plus", function()
	if LeaPlusDB ~= nil then
		LeaPlusDB["EnhanceProfessions"] = "Off";
	end
	MT.FrameFixSkillList();
end);

