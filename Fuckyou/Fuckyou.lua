local function FixLanguageFilterSideEffects()
	local OLD_GetFriendGameAccountInfo = C_BattleNet.GetFriendGameAccountInfo
	function C_BattleNet.GetFriendGameAccountInfo(...)
		local gameAccountInfo = OLD_GetFriendGameAccountInfo(...)
		if gameAccountInfo then
			gameAccountInfo.isInCurrentRegion = true
		end
		return gameAccountInfo
	end

	local OLD_GetFriendAccountInfo = C_BattleNet.GetFriendAccountInfo
	function C_BattleNet.GetFriendAccountInfo(...)
		local accountInfo = OLD_GetFriendAccountInfo(...)
		if accountInfo and accountInfo.gameAccountInfo then
			accountInfo.gameAccountInfo.isInCurrentRegion = true
		end
		return accountInfo
	end
end

local function fuckyou(self)
	-- 戰網不可用時自動停止
	if not BNFeaturesEnabledAndConnected() then return end
	
	if GetCVar("portal") == "CN" then
		ConsoleExec("portal TW")
		FixLanguageFilterSideEffects()
	end
	SetCVar("profanityFilter", 0)	-- 語言過濾器
	SetCVar("overrideArchive", 0)	-- 模型反和諧
	self:UnregisterEvent("ADDON_LOADED")
end

local godie = CreateFrame("FRAME", nil)
	godie:RegisterEvent("ADDON_LOADED")
	godie:SetScript("OnEvent", fuckyou)