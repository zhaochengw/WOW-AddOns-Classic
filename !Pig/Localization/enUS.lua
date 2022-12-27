local addonName, addonTable = ...;
local L =addonTable.locale
if GetLocale() == "enUS" then
L["ERROR_CLEAR"] = "clear";
L["ERROR_PREVIOUS"] = "previous";
L["ERROR_NEXT"] = "next";
L["ERROR_EMPTY"] = "No errors occur";
L["ERROR_CURRENT"] = "current";
L["ERROR_OLD"] = "old";
L["ERROR_ADDON"] = "addon";
L["ERROR_ERROR1"] = "Try to invoke the protection function";
L["ERROR_ERROR2"] = "The macro attempts to invoke the protection function";
--
L["INVITE_NAME"] = "invite";
L["INVITE_LEISURE"] = "waiting";
L["INVITE_CHEDUI"] = "team";
L["INVITE_PLANE"] = "layer";
L["INVITE_RECEIVEDATA"] = "Receiving data...";
L["INVITE_WARNING"] = "***Do not use it on servers outside mainland China***";
L["INVITE_LFG_JOIN"] = "Join PIGCHANNEL";
L["INVITE_LFG_LEAVE"] = "Already joined PIGCHANNEL";
end