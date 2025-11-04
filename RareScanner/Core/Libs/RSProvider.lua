-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local RSProvider = private.NewLib("RareScannerProvider")

local providers = {}

function RSProvider.AddDataProvider(provider)
	if (provider) then
		providers[provider] = true
	end
end

function RSProvider.RefreshAllDataProviders()
	for dp, _ in pairs(providers) do
		dp:RefreshAllData()
	end
end