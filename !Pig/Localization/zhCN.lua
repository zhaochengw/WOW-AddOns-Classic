local addonName, addonTable = ...;
local L ={}
--if GetLocale() == "zhCN" then
L["ERROR_CLEAR"] = "清空";
L["ERROR_PREVIOUS"] = "上一条";
L["ERROR_NEXT"] = "下一条";
L["ERROR_EMPTY"] = "没有错误发生";
L["ERROR_CURRENT"] = "本次错误";
L["ERROR_OLD"] = "之前错误";
L["ERROR_ADDON"] = "插件";
L["ERROR_ERROR1"] = "尝试调用保护功能";
L["ERROR_ERROR2"] = "宏尝试调用保护功能";
---
L["INVITE_NAME"] = "时空之门";
L["INVITE_LEISURE"] = "候车";
L["INVITE_CHEDUI"] = "车队";
L["INVITE_PLANE"] = "位面";
L["INVITE_RECEIVEDATA"] = "正在接收数据...";
L["INVITE_WARNING"] = "***请勿在非中国大陆服务器使用***";
L["INVITE_LFG_JOIN"] = "加入PIG频道";
L["INVITE_LFG_LEAVE"] = "已加入PIG频道";

-- L["enable"] = "启用";
-- L["add"] = "添加";
-- L["addQuick"] = "Added to the shortcut button bar";
-- L["addQuick_tooltip"] = L["到快捷按钮栏"].."，For quick opening.";
-- L["attention"] = "注意：此功能需先打开快捷按钮栏功能";
-- L["noenable"] = "尚未启用，请在功能内启用";
-- L["dungeon"] = "地下城";
-- L["raid"] = "团队副本";
-- L["free"] = "免费";
addonTable.locale=L