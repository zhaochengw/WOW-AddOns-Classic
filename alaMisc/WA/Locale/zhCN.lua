--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
NS.WA = NS.WA or {  };
NS.WA.L = NS.WA.L or {  };
local L = NS.WA.L;

if GetLocale() ~= "zhCN" and GetLocale() ~= "zhTW" then return;end

L["CONFLICTED: "] = "\124cffff0000存在冲突\124r: ";
L["ALL_EXIST"] = "\124cff00ffff>>全部存在<<\124r";

L["DROP_IMPORT"] = "导入WA代码";
L["DROP_FORCE_IMPORT"] = "\124cffff0000强制导入WA代码\124r";
L["WeakAuraOptions_LOAD_FAILED"] = "WeakAuraOptions加载失败";
L["OK"] = "确定";
L["Search"] = "搜索";
L["Author: "] = "作者: ";

L["Are you sure to load WA ?"] = "是否加载WeakAuras？";
L["OK"] = "是";
L["Cancel"] = "否";
