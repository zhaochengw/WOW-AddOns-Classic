local ADDON, NS = ...;

NS.L = {  };

local LOCALE = GetLocale();
local L = NS.L;
if LOCALE == "zhCN" or LOCALE == "zhTW" then
	L["CONFLICT"] = "alaTrade插件冲突: ";
	L["pop_status"] = "清理...";
	L["Scan full finished."] = "扫描完成";
	L["Scan normal finished."] = "扫描完成";
	L["pages"] = "页面: 当前/已缓存/总共 ";
	L["PRICE"] = "价格";
	L["HISTORY_PRICE"] = "历史价格";
	L["AH_PRICE"] = "拍卖";
	L["VENDOR_PRICE"] = "商人";
	L["CACHE_TIME"] = "缓存时间";
	L["UNKOWN"] = "未知";
	L["BOP_ITEM"] = "拾取绑定";
	L["QUEST_ITEM"] = "任务物品";
	L["6H"] = "\124cffffff006小时前\124r";
	L["24H"] = "\124cffff000024小时前\124r";
	L["Disenchant"] = "分解";
	L["DURATION"] = "持续时间";
	L["ExactQuery"] = "精确匹配";
	L["Reset"] = "重置";
	L["CacheAll"] = "扫描全部";
	L["timeLeft"] = {
		[1] = "\124cffff0000小于30分钟\124r",
		[2] = "\124cffff7f7f30分钟-2小时\124r",
		[3] = "\124cffffff002小时-8小时\124r",
		[4] = "\124cff00ff008小时-24小时\124r",
	};
	L["buyout"] = "一口价 ";
	L["configButton"] = "设置";
	L["TIP_SEARCH_NAME_ONLY_INFO"] = "只搜索名称，不搜索id";
	L["close"] = "关闭";
	L["OK"] = "确定";
	L["showEmpty"] = "显示无价格记录的物品";
	L["query_online"] = "向其他玩家查询价格";
	L["show_vendor_price"] = "显示商人价格（单个物品）";
	L["show_vendor_price_multi"] = "显示商人价格（当前数量）";
	L["show_ah_price"] = "显示拍卖价格（单个物品）";
	L["show_ah_price_multi"] = "显示拍卖价格（当前数量）";
	L["show_disenchant_price"] = "显示分解价格";
	L["show_disenchant_detail"] = "显示分解详细信息";
	L["cache_history"] = "保存历史价格\124cff00ff00占用很多内存\124r";
	L["BaudAuctionFrame"] = "改变购买窗口";
	L["regular_exp"] = "正则表达式搜索\124cffff0000!!!慎用!!!\124r";
	L["show_DBIcon"] = "显示小地图按钮";
	L["avoid_stuck_cost"] = "全局扫描速度\124cffff0000警告: 人口较多的服务器请降低此数值\124r";
	L["data_valid_time"] = "日期着色的基准时间";
	L["auto_clean_time"] = "自动清理超过以下时间的数据";
	L["TIME900"] = "15分钟";
	L["TIME86400"] = "24小时";
	L["TIME43200"] = "12小时";
	L["TIME2592000"] = "30天";
	L["SORT_METHOD"] = {
		[1] = "ID",
		[2] = "品质",
		[3] = "名字",
		[4] = "单价",
		[5] = "缓存时间",
		[6] = "等级",
	};
	L["COLORED_FORMATTED_TIME_LEN"] = {
		"\124cff%.2x%.2x00%d天%02d时%02d分%02d秒\124r",
		"\124cff%.2x%.2x00%d时%02d分%02d秒\124r",
		"\124cff%.2x%.2x00%d分%02d秒\124r",
		"\124cff%.2x%.2x00%d秒\124r",
	};
	L["FORMATTED_TIME_LEN"] = {
		"%d天%02d时%02d分%02d秒",
		"%d时%02d分%02d秒",
		"%d分%02d秒",
		"%d秒",
	};
	L["FORMATTED_TIME"] = "%Y年%m月%d日\n%H:%M:%S";
	L["TIME_NA"] = "\124cffff0000未知\124r";
	L["UI_TITLE"] = "ALA @ 网易有爱 \124cff00ff00wowui.w.163.com\124r";
	L["DBIcon_Text"] = "\124cff00ff00左键\124r 搜索缓存的物品价格\n\124cff00ff00右键\124r 打开设置界面";
	L["PRCIE_NOT_CACHED"] = "无数据";
	L["ITEM_COUNT"] = "物品数";
	L["MoneyString_Dec_Char_Format"] = {
		"%d金%02d银%02d.%02d铜",
		"%d银%02d.%02d铜",
		"%d.%02d铜",
	};
else
	L["CONFLICT"] = "alaTrade conflicted addon : ";
	L["pop_status"] = "Cleaning up...";
	L["Scan full finished."] = "Scan finished";
	L["Scan normal finished."] = "Scan finished";
	L["pages"] = "Pages: current/cached/total ";
	L["PRICE"] = "Price";
	L["HISTORY_PRICE"] = "History Price";
	L["AH_PRICE"] = "AH";
	L["VENDOR_PRICE"] = "Vendor";
	L["CACHE_TIME"] = "Cache Time";
	L["UNKOWN"] = "Unkown";
	L["BOP_ITEM"] = "BOP";
	L["QUEST_ITEM"] = "Quest items";
	L["6H"] = "\124cffffff006hours ago\124r";
	L["24H"] = "\124cffff000024hours ago\124r";
	L["Disenchant"] = "Disenchant";
	L["DURATION"] = "Duration";
	L["ExactQuery"] = "Exact";
	L["Reset"] = "Reset";
	L["CacheAll"] = "CacheAll";
	L["timeLeft"] = {
		[1] = "\124cffff0000Less than 30min\124r",
		[2] = "\124cffff7f7f30mins-2hours\124r",
		[3] = "\124cffffff002hours-8hours\124r",
		[4] = "\124cff00ff008hours-24hours\124r",
	};
	L["buyout"] = "buyout ";
	L["configButton"] = "config";
	L["TIP_SEARCH_NAME_ONLY_INFO"] = "Search name only, otherwise both name and id";
	L["close"] = "close";
	L["OK"] = "OK";
	L["showEmpty"] = "Show items without recorded prices";
	L["query_online"] = "Query price from others";
	L["show_vendor_price"] = "Vendor price (Single item)";
	L["show_vendor_price_multi"] = "Vendor price (Current stack)";
	L["show_ah_price"] = "AH price (Single item)";
	L["show_ah_price_multi"] = "AH price (Current stack)";
	L["show_disenchant_price"] = "Disenchant price ";
	L["show_disenchant_detail"] = "Disenchant details";
	L["cache_history"] = "Price history. \124cff00ff00Take up lots of ram\124r";
	L["BaudAuctionFrame"] = "BaudAuctionFrame";
	L["regular_exp"] = "Regular Expression\124cffff0000!!!Caution!!!\124r";
	L["show_DBIcon"] = "Icon around the minimap";
	L["avoid_stuck_cost"] = "Speed of full scan \124cff00ff00Warning: Make it lower if the realm is crowded.\124r";
	L["data_valid_time"] = "Baseline of the color of timestamp. (Value older than this value is \124cffff0000red\124r)";
	L["auto_clean_time"] = "Auto clean data older than ";
	L["TIME900"] = "15mins";
	L["TIME43200"] = "12hours";
	L["TIME86400"] = "24hours";
	L["TIME2592000"] = "30days";
	L["SORT_METHOD"] = {
		[1] = "ID",
		[2] = "Quality",
		[3] = "Name",
		[4] = "Price",
		[5] = "Cached time",
		[6] = "Level",
	};
	L["COLORED_FORMATTED_TIME_LEN"] = {
		"\124cff%.2x%.2x00%dd %02dh %02dm %02ds\124r",
		"\124cff%.2x%.2x00%dh %02dm %02ds\124r",
		"\124cff%.2x%.2x00%dm %02ds\124r",
		"\124cff%.2x%.2x00%ds\124r",
	};
	L["FORMATTED_TIME_LEN"] = {
		"%dd %02dh %02dm %02ds",
		"%dh %02dm %02ds",
		"%dm %02dsr",
		"%ds",
	};
	L["FORMATTED_TIME"] = "%Y-%m-%d\n%H:%M:%S";
	L["TIME_NA"] = "\124cffff0000NA\124r";
	L["UI_TITLE"] = "ALA @ 163UI";
	L["DBIcon_Text"] = "\124cff00ff00Left click\124r Search cached price.\n\124cff00ff00Right Click\124r Configure.";
	L["PRCIE_NOT_CACHED"] = "No data";
	L["ITEM_COUNT"] = "Item count";
	L["MoneyString_Dec_Char_Format"] = {
		"%dG%02dS%02d.%02dC",
		"%dS%02d.%02dC",
		"%d.%02dC",
	};
end
