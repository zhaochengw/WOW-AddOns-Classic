local AddonName, Addon = ...

local L = setmetatable({}, {
    __index = function(table, key)
        if key then
            table[key] = tostring(key)
        end
        return tostring(key)
    end,
})

Addon.L = L

L["Feedback & Update Link"] = "https://www.curseforge.com/wow/addons/maillogger"

local locale = GetLocale()

if locale == "enUS" then
	--Tips
	L["MAILLOGGER TIPS"] = "|cFFBA55D3MailLogger|r Tips:Use |cFF00BFFF/maillogger|r |cFFFF4500gui|r or |cFF00BFFF/ml|r |cFFFF4500gui|r open Option Interface, Use |cFF00BFFF/maillogger|r |cFFFF9000all|r or |cFF00BFFF/ml|r |cFFFF9000all|r open All Logs, |cFF00BFFF/maillogger|r |cFFFF9000tl|r or |cFF00BFFF/ml|r |cFFFF9000tl|r open Trade Logs, |cFF00BFFF/maillogger|r |cFFFF9000ml|r or |cFF00BFFF/ml|r |cFFFF9000ml|r open Mail Logs, Use |cFF00BFFF/maillogger|r |cFFFF9000all|r or |cFF00BFFF/ml|r |cFFFF9000sm|r open Sent Mail Logs, Use |cFF00BFFF/maillogger|r |cFFFF9000all|r or |cFF00BFFF/ml|r |cFFFF9000rm|r open Received Mail Logs."
	--Trades
	L["MAILLOGGER_TEXT_TRADE_ERROR"] = "Trade with %s failed, caused by %s."
	L["MAILLOGGER_TEXT_TRADE_SUCCEED"] = "Trade with %s succeed."
	L["MAILLOGGER_TEXT_TRADE_ITEMS_RECEIVE"] = " Received #num# item(s), included #item# (#quantity#)."
	L["MAILLOGGER_TEXT_TRADE_ITEMS_GIVE"] = " Gave #num# item(s), included #item# (#quantity#)."
	L["MAILLOGGER_TEXT_TRADE_MONEY_RECEIVE"] = " Received %s."
	L["MAILLOGGER_TEXT_TRADE_MONEY_GIVE"] = " Gave %s."
	L["MAILLOGGER_TEXT_TRADE_ENCHANTMENT"] = " Item %s got Enchantment %s."
	--补全
	L["MAILLOGGER_TEXT_UNKNOWN"] = "Unknown"

elseif locale == "zhCN" then
	--Tips
	L["MAILLOGGER TIPS"] = "|cFFBA55D3MailLogger|r命令行提示：使用|cFF00BFFF/maillogger|r |cFFFF4500gui|r或者|cFF00BFFF/ml|r |cFFFF4500gui|r显示设置窗口，使用|cFF00BFFF/maillogger|r |cFFFF9000all|r或者|cFF00BFFF/ml|r |cFFFF9000all|r显示全部记录，|cFF00BFFF/maillogger|r |cFFFF9000tl|r或者|cFF00BFFF/ml|r |cFFFF9000tl|r显示交易记录，|cFF00BFFF/maillogger|r |cFFFF9000ml|r或者|cFF00BFFF/ml|r |cFFFF9000ml|r显示邮件记录，|cFF00BFFF/maillogger|r |cFFFF9000all|r或者|cFF00BFFF/ml|r |cFFFF9000sm|r显示发件记录，使用|cFF00BFFF/maillogger|r |cFFFF9000all|r或者|cFF00BFFF/ml|r |cFFFF9000rm|r显示收件记录。"
	--交易
	L["MAILLOGGER_TEXT_TRADE_ERROR"] = "与<%s>的交易失败了，因为<%s>。"
	L["MAILLOGGER_TEXT_TRADE_SUCCEED"] = "与<%s>的交易成功了。"
	L["MAILLOGGER_TEXT_TRADE_MONEY_RECEIVE"] = "收入%s。"
	L["MAILLOGGER_TEXT_TRADE_MONEY_GIVE"] = "付出%s。"
	L["MAILLOGGER_TEXT_TRADE_ITEMS_RECEIVE"] = "获得#item#(#quantity#)等#num#件物品。"
	L["MAILLOGGER_TEXT_TRADE_ITEMS_GIVE"] = "给予#item#(#quantity#)等#num#件物品。"
	L["MAILLOGGER_TEXT_TRADE_ENCHANTMENT"] = "物品%s获得了附魔<%s>。"
	--补全
	L["MAILLOGGER_TEXT_UNKNOWN"] = "未知目标"
	--载入提示文字
	L["|cFFBA55D3MailLogger|r v%s|cFFB0C4DE is Loaded.|r"] = "|cFFBA55D3MailLogger|r v%s已|cFFB0C4DE成功|r加载！"
	--Config界面文字
	L["|cFFFFC040By:|r |cFF9382C9Aoikaze|r-|cFFFF66FFZeroZone|r-|cFFDE2910CN|r"] = "|cFFFFC040By:|r |cFF9382C9Aoikaze|r-|cFFFF66FF零界|r-|cFFDE2910CN|r"
	L["|cFFFF33CCFeedback & Update: |r"] = "|cFFFF33CC反馈与更新：|r"
	L["Enable |cFFBA55D3MailLogger|r"] = "启用|cFFBA55D3MailLogger|r"
	L["Trade Function"] = "交易管理"
	L["Enable |cFF00CD00Whisper|r"] = "启用|cFF00CD00交易密语|r"
	L["Send to |cFFF0F000Group|r"] = "发送到|cFFF0F000团队|r"
	L["Show |cFF4169E1Minimap Button|r"] = "显示|cFF4169E1小地图按钮|r"
	L["Log |cFFFF7F50Every Day|r"] = "记录|cFFFF7F50每一天|r"
	L["Enable |cFF00FFFFCalendar|r"] = "启用|cFF00FFFF日历筛选|r"
	L["[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r trades with |cFF00FF00%s|r at |cFF00FF00%s|r"] = "[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r与|cFF00FF00%s|r在|cFF00FF00%s|r交易"
	L["[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r sent a mail to |cFF00FF00%s|r"] = "[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r向|cFF00FF00%s|r发送邮件"
	L["[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r received item(s) from |cFF00FF00%s|r"] = "[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r收到|cFF00FF00%s|r的邮件"
	L["|cFFDAA520Receive|r "] = "|cFFDAA520收入|r "
	L["|cFFFF4500Give|r "] = "|cFFFF4500支出|r "
	L["|cFFDAA520Receive Item(s)|r: "] = "|cFFDAA520获得物品|r："
	L["|cFFFF4500Give Item(s)|r: "] = "|cFFFF4500给予物品|r："
	L["|cFFFF4500Provide Enchantment|r: "] = "|cFFFF4500提供附魔|r："
	L["|cFFDAA520Receive Enchantment|r: "] = "|cFFDAA520获得附魔|r："
	L["Trade Log Days"] = "日志保存期"
	L["365 Days"] = "365天"
	L["Print Logs"] = "显示记录"
	L["Delete All"] = "清空记录"
	L["Prevent Robot Trades Me"] = "阻止脚本交易"
	L["Enable |cFFFF0000Preventer|r"] = "启用|cFFFF0000阻止交易|r"
	L["<|cFFBA55D3MailLogger|r>Not any Logs!"] = "<|cFFBA55D3MailLogger|r>没有任何记录！"
	L["<|cFFBA55D3MailLogger|r>All Logs was deleted!"] = "<|cFFBA55D3MailLogger|r>已清空全部记录！"
	L["<|cFFBA55D3MailLogger|r>All other Alts was deleted!"] = "<|cFFBA55D3MailLogger|r>已清理所有小号！"
	L["All Logs"] = "全部记录"
	L["Trade Logs"] = "交易记录"
	L["Mail Logs"] = "邮件记录"
	L["Sent Mail"] = "发送记录"
	L["Received Mail"] = "接收记录"
	L["off"] = "禁用"
	L["All"] = "全部"
	L["Trades"] = "交易"
	L["Mails"] = "邮件"
	L["Sent"] = "发件"
	L["Received"] = "收件"
	L["|cFF00FF00Left Click|r to Open Log Frame"] = "|cFF00FF00左键|r打开记录窗口"
	L["|cFF00FF00Right Click|r to Open Config Frame"] = "|cFF00FF00右键|r打开设置窗口"
	L["|cFF00FF00Shift+Left|r to Restore Log Frame Position"] = "|cFF00FF00Shift+左键|r重置记录窗口位置"
	L["|cFF00FF00Shift+Right|r to Restore Minimap Icon Position"] = "|cFF00FF00Shift+右键|r重置小地图按钮位置"
	L["Ignore Items List Editor"] = "忽略物品编辑器"
	L["Ignore Items List"] = "忽略物品列表"
	L["No Ignore Item"] = "没有被忽略的物品"
	L["Display"] = "显示"
	L["Restore"] = "默认"
	L["Add"] = "添加"
	L["Remove"] = "删除"
	L["Alt Name"] = "角色名称"
	L["Sift"] = "筛选"
	L["Maintance"] = "维护"
	L["Delete All Alts"] = "清理角色数据库"
	L["Calendar"] = "日历"
	L["Year"] = " 年份"
	L["Month"] = "    月份"
	-- 默认物品本地化
	L["Conjured Crystal Water"] = "魔法晶水"
	L["Conjured Cinnamon Roll"] = "魔法肉桂面包"
	L["Major Healthstone"] = "特效治疗石"
elseif locale == "zhTW" then --Taiwan is a part of China forever
    --Tips
	L["MAILLOGGER TIPS"] = "|cFFBA55D3MailLogger|r命令列提示：使用|cFF00BFFF/maillogger|r |cFFFF4500gui|r或者|cFF00BFFF/ml|r |cFFFF4500gui|r顯示設定視窗，使用|cFF00BFFF/maillogger|r |cFFFF9000all|r或者|cFF00BFFF/ml|r |cFFFF9000all|r顯示全部記錄，|cFF00BFFF/maillogger|r |cFFFF9000tl|r或者|cFF00BFFF/ml|r |cFFFF9000tl|r顯示交易記錄，|cFF00BFFF/maillogger|r |cFFFF9000ml|r或者|cFF00BFFF/ml|r |cFFFF9000ml|r顯示郵件記錄，|cFF00BFFF/maillogger|r |cFFFF9000all|r或者|cFF00BFFF/ml|r |cFFFF9000sm|r顯示發件記錄，使用|cFF00BFFF/maillogger|r |cFFFF9000all|r或者|cFF00BFFF/ml|r |cFFFF9000rm|r顯示收件記錄。"
	--交易
    L["MAILLOGGER_TEXT_TRADE_ERROR"] = "與<%s>的交易失敗了，因為<%s>。"
    L["MAILLOGGER_TEXT_TRADE_SUCCEED"] = "與<%s>的交易成功了。"
    L["MAILLOGGER_TEXT_TRADE_MONEY_RECEIVE"] = "收入%s。"
    L["MAILLOGGER_TEXT_TRADE_MONEY_GIVE"] = "付出%s。"
    L["MAILLOGGER_TEXT_TRADE_ITEMS_RECEIVE"] = "獲得#item#(#quantity#)等#num#件物品。"
    L["MAILLOGGER_TEXT_TRADE_ITEMS_GIVE"] = "給予#item#(#quantity#)等#num#件物品。"
    L["MAILLOGGER_TEXT_TRADE_ENCHANTMENT"] = "物品%s獲得了附魔<%s>。"
    --補全
    L["MAILLOGGER_TEXT_UNKNOWN"] = "未知目標"
    --載入提示文字
    L["|cFFBA55D3MailLogger|r v%s|cFFB0C4DE is Loaded.|r"] = "|cFFBA55D3MailLogger|r v%s已|cFFB0C4DE成功|r載入！"
    --Config介面文字
    L["|cFFFFC040By:|r |cFF9382C9Aoikaze|r-|cFFFF66FFZeroZone|r-|cFFDE2910CN|r"] = "|cFFFFC040By:|r |cFF9382C9Aoikaze|r-|cFFFF66FF零界|r-|cFFDE2910CN|r"
    L["|cFFFF33CCFeedback & Update: |r"] = "|cFFFF33CC回饋與更新：|r"
    L["Enable |cFFBA55D3MailLogger|r"] = "啟用|cFFBA55D3MailLogger|r"
    L["Trade Function"] = "交易管理"
    L["Enable |cFF00CD00Whisper|r"] = "啟用|cFF00CD00交易密語|r"
    L["Send to |cFFF0F000Group|r"] = "發送到|cFFF0F000團隊|r"
	L["Show |cFF4169E1Minimap Button|r"] = "顯示|cFF4169E1迷你地圖按鈕|r"
	L["Log |cFFFF7F50Every Day|r"] = "記錄|cFFFF7F50每一天|r"
	L["Enable |cFF00FFFFCalendar|r"] = "啓用|cFF00FFFF日曆篩選|r"
    L["[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r trades with |cFF00FF00%s|r at |cFF00FF00%s|r"] = "[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r與|cFF00FF00%s|r在|cFF00FF00%s|r交易"
    L["[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r sent a mail to |cFF00FF00%s|r"] = "[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r向|cFF00FF00%s|r發送郵件"
    L["[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r received item(s) from |cFF00FF00%s|r"] = "[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r收到|cFF00FF00%s|r的郵件"
    L["|cFFDAA520Receive|r "] = "|cFFDAA520收入|r "
    L["|cFFFF4500Give|r "] = "|cFFFF4500支出|r "
    L["|cFFDAA520Receive Item(s)|r: "] = "|cFFDAA520獲得物品|r："
    L["|cFFFF4500Give Item(s)|r: "] = "|cFFFF4500給予物品|r："
    L["|cFFFF4500Provide Enchantment|r: "] = "|cFFFF4500提供附魔|r："
    L["|cFFDAA520Receive Enchantment|r: "] = "|cFFDAA520獲得附魔|r："
    L["Trade Log Days"] = "日誌保存期"
    L["365 Days"] = "365天"
    L["Print Logs"] = "顯示記錄"
    L["Delete All"] = "清空記錄"
    L["Prevent Robot Trades Me"] = "阻止腳本交易"
    L["Enable |cFFFF0000Preventer|r"] = "啟用|cFFFF0000阻止交易|r"
	L["<|cFFBA55D3MailLogger|r>Not any Logs!"] = "<|cFFBA55D3MailLogger|r>沒有任何記錄！"
	L["<|cFFBA55D3MailLogger|r>All Logs was deleted!"] = "<|cFFBA55D3MailLogger|r>已清空全部記錄！"
	L["<|cFFBA55D3MailLogger|r>All other Alts was deleted!"] = "<|cFFBA55D3MailLogger|r>已清理所有分身！"
    L["All Logs"] = "全部記錄"
    L["Trade Logs"] = "交易記錄"
    L["Mail Logs"] = "郵件記錄"
    L["Sent Mail"] = "發送記錄"
    L["Received Mail"] = "接收記錄"
	L["off"] = "禁用"
	L["All"] = "全部"
	L["Trades"] = "交易"
	L["Mails"] = "郵件"
	L["Sent"] = "發件"
	L["Received"] = "收件"
    L["|cFF00FF00Left Click|r to Open Log Frame"] = "|cFF00FF00左鍵|r打開記錄視窗"
    L["|cFF00FF00Right Click|r to Open Config Frame"] = "|cFF00FF00右鍵|r打開設置視窗"
    L["|cFF00FF00Shift+Left|r to Restore Log Frame Position"] = "|cFF00FF00Shift+左鍵|r重置記錄視窗位置"
    L["|cFF00FF00Shift+Right|r to Restore Minimap Icon Position"] = "|cFF00FF00Shift+右鍵|r重置小地圖按鈕位置"
    L["Ignore Items List Editor"] = "忽略物品編輯器"
    L["Ignore Items List"] = "忽略物品列表"
    L["No Ignore Item"] = "沒有被忽略的物品"
    L["Display"] = "顯示"
    L["Restore"] = "默認"
    L["Add"] = "添加"
    L["Remove"] = "刪除"
	L["Alt Name"] = "角色名稱"
	L["Sift"] = "篩選"
	L["Maintance"] = "維護"
	L["Delete All Alts"] = "清理角色數據庫"
	L["Calendar"] = "日曆"
	L["Year"] = " 年份"
	L["Month"] = "    月份"
	-- 默认物品本地化
	L["Conjured Crystal Water"] = "魔法晶水"
	L["Conjured Cinnamon Roll"] = "魔法肉桂麵包"
	L["Major Healthstone"] = "極效治療石"
end