local _, addon = ...

--[[ namespace:IsRetail() ![](https://img.shields.io/badge/function-blue)
Checks if the current client is running the "retail" version.
--]]
function addon:IsRetail()
	return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end

--[[ namespace:IsVanilla() ![](https://img.shields.io/badge/function-blue)
Checks if the current client vanilla.
--]]
function addon:IsVanilla()
	return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

--[[ namespace:IsBurningCrusade() ![](https://img.shields.io/badge/function-blue)
Checks if the current client is tbc.
--]]
function addon:IsBurningCrusade()
	return WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
end

--[[ namespace:IsWrath() ![](https://img.shields.io/badge/function-blue)
Checks if the current client is wrath.
--]]
function addon:IsWrath()
	return WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
end

--[[ namespace:IsCataclysm() ![](https://img.shields.io/badge/function-blue)
Checks if the current client is cataclysm.
--]]
function addon:IsCataclysm()
	return WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC
end

--[[ namespace:IsMists() ![](https://img.shields.io/badge/function-blue)
Checks if the current client is mists.
--]]
function addon:IsMists()
	return WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC
end

--[[ namespace:IsClassic() ![](https://img.shields.io/badge/function-blue)
Alias for the latest classic version method from the above.
--]]
function addon:IsClassic()
	return addon:IsMists()
end

local _, buildVersion, _, interfaceVersion = GetBuildInfo()
--[[ namespace:HasVersion(_interfaceVersion_) ![](https://img.shields.io/badge/function-blue)
Checks if the current client is running an interface version equal to or newer than the specified.
--]]
function addon:HasVersion(interface)
	return interfaceVersion >= interface
end

--[[ namespace:HasBuild(_buildNumber_[, _interfaceVersion_]) ![](https://img.shields.io/badge/function-blue)
Checks if the current client is running a build equal to or newer than the specified.  
Optionally also check against the interface version.
--]]
function addon:HasBuild(build, interface)
	if interface and interfaceVersion < interface then
		return
	end

	return tonumber(buildVersion) >= build
end
