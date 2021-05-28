local _, parentAddonTable = ...
local addon = parentAddonTable.BugGrabber
-- Bail out in case we didn't load up for some reason, which
-- happens for example when an embedded BugGrabber finds a
-- standalone !BugGrabber addon.
if not addon then return end

-- We don't need to bail out here if BugGrabber has been loaded from
-- some other embedding addon already, because :LoadTranslations is
-- only invoked on login. All we do is replace the method with a new
-- one that will never be invoked.

function addon:LoadTranslations(locale, L)
	if locale == "zhTW" then
L["ADDON_CALL_PROTECTED"] = "[%s] 插件 '%s' 嘗試調用保護功能 '%s'。"
L["ADDON_CALL_PROTECTED_MATCH"] = "^%[(.*)%] (插件 '.*' 嘗試調用保護功能 '.*'.)$"
L["ADDON_DISABLED"] = "|cffffff00!BugGrabber和%s不能共存;%s已經被強制停用。如果你要使用它,你可能需要登出，然後禁用!BugGrabber，再啟用%s。|r"
L["BUGGRABBER_STOPPED"] = "|cffffff00你的UI有太多的錯誤。這可能導致糟糕的遊戲體驗。禁用或是更新錯誤的插件如果你不想看到再次看到這個訊息。|r"
L["ERROR_DETECTED"] = "%s |cffffff00已捕捉，點擊連結以獲得更多訊息。|r"
L["ERROR_UNABLE"] = "|cffffff00!BugGrabber 本身無法檢索其他玩家的錯誤。請安裝 BugSack 或類似的錯誤顯示插件，可能會包含這些功能。|r"
L["NO_DISPLAY_1"] = "|cffffff00你似乎沒有與 !BugGrabber 一起運行的錯誤顯示插件。雖然斜線命令訪問錯誤報告，但錯誤顯示插件可以以更快捷的方式幫助您管理這些錯誤。|r"
L["NO_DISPLAY_2"] = "|cffffff00標準的錯誤顯示插件名叫 BugSack，可以在找到 !BugGrabber 的網站上找到它。|r"
L["NO_DISPLAY_STOP"] = "|cffffff00如果你不希望再次被提醒，請輸入 /stopnag。|r"
L["STOP_NAG"] = "|cffffff00!BugGrabber將不再提示缺失錯誤顯示插件資訊直到下個版本發佈。|r"
L["USAGE"] = "用法：/buggrabber <1-%d>。"

	elseif locale == "zhCN" then
L["ADDON_CALL_PROTECTED"] = "[%s] 插件 '%s' 尝试调用保护功能 '%s'。"
L["ADDON_CALL_PROTECTED_MATCH"] = "^%[(.*)%] (插件 '.*' 尝试调用保护功能 '.*'.)$"
L["ADDON_DISABLED"] = "|cffffff00!BugGrabber|r 和 %s 不能共存。%s 已被强制停用。如果愿意，可在登出游戏后，停用 !BugGrabber 并启用 %s|r。"
L["BUGGRABBER_STOPPED"] = "|cffffff00用户界面有太多的错误。所以，游戏体验会被降低。如不想再看到此信息请禁用或升级失效插件。|r"
L["ERROR_DETECTED"] = "%s |cffffff00已抓取，点击链接获取更多信息。|r"
L["ERROR_UNABLE"] = "|cffffff00!BugGrabber 本身无法检索其他玩家的错误。请安装 BugSack 或类似的错误显示插件，可能会包含这些功能。|r"
L["NO_DISPLAY_1"] = "|cffffff00似乎没有与 !BugGrabber 一起运行的错误显示插件。虽然斜线命令访问错误报告，但错误显示插件可以以更快捷的方式帮助您管理这些错误。|r"
L["NO_DISPLAY_2"] = "|cffffff00标准的错误显示插件名叫 BugSack，可以在找到 !BugGrabber 的网站上找到它。|r"
L["NO_DISPLAY_STOP"] = "|cffffff00如果你不希望再次被提醒，请输入 /stopnag。|r"
L["STOP_NAG"] = "|cffffff00!BugGrabber 将不再提示缺失错误显示插件信息知道下个版本发布。|r"
L["USAGE"] = "|cffffff00用法：/buggrabber <1-%d>。|r"

	end
end

