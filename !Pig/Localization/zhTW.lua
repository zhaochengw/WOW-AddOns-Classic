local addonName, addonTable = ...;
local L=addonTable.locale
if GetLocale() == "zhTW" then
L["ERROR_CLEAR"] = "清空";
L["ERROR_PREVIOUS"] = "上一條";
L["ERROR_NEXT"] = "下一條";
L["ERROR_EMPTY"] = "沒有錯誤髮生";
L["ERROR_CURRENT"] = "本次錯誤";
L["ERROR_OLD"] = "之前錯誤";
L["ERROR_ADDON"] = "插件";
L["ERROR_ERROR1"] = "嚐試調用保護功能";
L["ERROR_ERROR2"] = "宏嚐試調用保護功能";
--
L["INVITE_NAME"] = "時空之門";
L["INVITE_LEISURE"] = "候車";
L["INVITE_CHEDUI"] = "車隊";
L["INVITE_PLANE"] = "位麵";
L["INVITE_RECEIVEDATA"] = "正在接收數據...";
L["INVITE_WARNING"] = "***請勿在非中國大陸服務器使用***";
L["INVITE_LFG_JOIN"] = "加入PIG頻道";
L["INVITE_LFG_LEAVE"] = "已加入PIG頻道";
end