--[[--
	by ALA @ 163UI
--]]--
do return end	--	no need to do this
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;


-->		****
MT.BuildEnv("ElvUI");
-->		****


local function LF_Skin_ElvUI(addon, frame)
	if frame ~= nil and ElvUI ~= nil and ElvUI[1] then
		local S = ElvUI[1]:GetModule('Skins');
		if S ~= nil then
			if frame.call ~= nil then
				S:HandleButton(frame.call);
				-- if frame.profitFrame and frame.profitFrame.PROFIT_SHOW_COST_ONLY then
					-- S:HandleCheckBox(frame.profitFrame.PROFIT_SHOW_COST_ONLY);
				-- end
			end
		end
	end
end


MT.RegisterOnAddOnLoaded("ElvUI", function()
	MT.FireCallback("UI_MOD_LOADED", { Skin = LF_Skin_ElvUI, });
end);
