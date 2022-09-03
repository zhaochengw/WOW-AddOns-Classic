local function LoadAddons()
	local _, class = UnitClass("player");
	if (class == "WARLOCK") then
		local _, _, _, _, loadable = GetAddOnInfo("SoulSort");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("SoulSort")) then
			LoadAddOn("SoulSort");
		end
		local _, _, _, _, loadable = GetAddOnInfo("GrimoireKeeper");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("GrimoireKeeper")) then
			LoadAddOn("GrimoireKeeper");
		end
	end

	--[[
	if (class == "DEATHKNIGHT") then
		local _, _, _, _, loadable = GetAddOnInfo("RuneItAll");
		if (loadable == "DEMAND_LOADED") and (IsAddOnLoaded("RuneItAll")) then
			LoadAddOn("RuneItAll");
		end
	end
	]]
	--[[
	if (class == "WARRIOR") then

	end
	]]

	if (class == "HUNTER") then
		local _, _, _, _, loadable = GetAddOnInfo("TrackingEye");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("TrackingEye")) then
			LoadAddOn("TrackingEye");
		end
		local _, _, _, _, loadable = GetAddOnInfo("GFW_FeedOMatic");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("GFW_FeedOMatic")) then
			LoadAddOn("GFW_FeedOMatic");
		end
		local _, _, _, _, loadable = GetAddOnInfo("YaHT");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("YaHT")) then
			LoadAddOn("YaHT");
		end
		local _, _, _, _, loadable = GetAddOnInfo("TranqRotate");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("TranqRotate")) then
			LoadAddOn("TranqRotate");
		end
	end

	if (class == "MAGE") then
		local _, _, _, _, loadable = GetAddOnInfo("Decursive");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("Decursive")) then
			LoadAddOn("Decursive");
		end
	end

	if (class == "PRIEST") then
		local _, _, _, _, loadable = GetAddOnInfo("Decursive");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("Decursive")) then
			LoadAddOn("Decursive");
		end
	end

	if (class == "DRUID") then
		-- local _, _, _, _, loadable = GetAddOnInfo("ComboPoints");
		-- if loadable and (not IsAddOnLoaded("ComboPoints")) then
		-- 	LoadAddOn("ComboPoints");
		-- end
		local _, _, _, _, loadable = GetAddOnInfo("Decursive");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("Decursive")) then
			LoadAddOn("Decursive");
		end
		local _, _, _, _, loadable = GetAddOnInfo("solQuickShifter");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("solQuickShifter")) then
			LoadAddOn("solQuickShifter");
		end
	end

	if (class == "PALADIN") then
		local _, _, _, _, loadable = GetAddOnInfo("Decursive");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("Decursive")) then
			LoadAddOn("Decursive");
		end
		local _, _, _, _, loadable = GetAddOnInfo("PallyPower");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("PallyPower")) then
			LoadAddOn("PallyPower");
		end
	end

	if (class == "SHAMAN") then
		local _, _, _, _, loadable = GetAddOnInfo("Decursive");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("Decursive")) then
			LoadAddOn("Decursive");
		end
		local _, _, _, _, loadable = GetAddOnInfo("TotemTimers");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("TotemTimers")) then
			LoadAddOn("TotemTimers");
		end
	end

	if (class == "ROGUE") then
		-- local _, _, _, _, loadable = GetAddOnInfo("ComboPoints");
		-- if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("ComboPoints")) then
		-- 	LoadAddOn("ComboPoints");
		-- end
		local _, _, _, _, loadable = GetAddOnInfo("PicoPoisons");
		if (loadable == "DEMAND_LOADED") and (not IsAddOnLoaded("PicoPoisons")) then
			LoadAddOn("PicoPoisons");
		end
	end
end

local al = CreateFrame("Frame");
al:RegisterEvent("PLAYER_LOGIN");
al:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		LoadAddons();
		al:UnregisterEvent("PLAYER_LOGIN");
	end
end)
