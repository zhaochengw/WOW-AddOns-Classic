----------------------------------------------------------------------------------------
--	ClassicAutoDismount (by EsreverWoW)
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame")

local errorMessages = {
	[ERR_ATTACK_MOUNTED]			= true,
	[ERR_MOUNT_ALREADYMOUNTED]		= true,
	[ERR_NOT_WHILE_MOUNTED]			= true,
	[ERR_TAXIPLAYERALREADYMOUNTED]	= true,
	[SPELL_FAILED_NOT_MOUNTED]		= true,
}

local function CheckDismount(self, event, ...)
	if not IsMounted() or not errorMessages[select(2, ...)] then return end

	Dismount()
	UIErrorsFrame:Clear()
end

f:RegisterEvent("UI_ERROR_MESSAGE")
f:SetScript("OnEvent", CheckDismount)
