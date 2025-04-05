local L = LibStub("AceLocale-3.0"):NewLocale("CopyAnything", "zhCN")
if not L then return end

--[[Translation missing --]]
--[[ L["copyAnything"] = "Copy Anything"--]] 
L["copyFrame"] = "复制文字弹窗"
L["fastCopy"] = "快速复制"
L["fastCopyDesc"] = "按 CTRL+C 复制文字后，自动关闭复制文字弹窗。"
L["fontStrings"] = "文字字符"
L["general"] = "常规"
--[[Translation missing --]]
--[[ L["invalidSearchType"] = "Invalid search type '%s'. Check options."--]] 
L["mouseFocus"] = "鼠标指向"
L["noTextFound"] = "未找到文字"
L["parentFrames"] = "父级框体"
L["profiles"] = "配置"
L["searchType"] = "查找类型"
L["searchTypeDesc"] = "请选择要用什么方式在鼠标指向的位置查找文字。"
L["searchTypeDescExtended"] = [=[文字字符（默认）：查找鼠标指向位置的单行文字。
父级框体：查找鼠标指向框体的父级框体，将其子框体的内容全部复制。
鼠标指向：复制鼠标指向框体中的文字，只在注册过鼠标事件、可以触发鼠标操作的框体（如点击、指向高亮）才有效果。]=]
--[[Translation missing --]]
--[[ L["show"] = "Show"--]] 
L["tooManyFontStrings"] = "找到超过 %d 个文字字串。为了避免游戏卡死，已取消复制。"

