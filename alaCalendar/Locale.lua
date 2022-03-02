--[[--
	by ALA @ 163UI
--]]--

local ADDON, NS = ...;
local LOCALE = GetLocale();

local L = {  };

L.REGION = {
	[1] = "US-Pacific",
	[2] = "US-Eastern",
	[3] = "Korea-대한민국",
	[4] = "Europe",
	[5] = "Taiwan, China-中國台灣",
	[6] = "China-中国大陆",
};
L.CLASS = {  };
for class, lClass in next, Mixin({  }, LOCALIZED_CLASS_NAMES_MALE, LOCALIZED_CLASS_NAMES_FEMALE) do
	L.CLASS[strupper(class)] = lClass;
end
L.COLORED_CLASS = {  };
for class, lClass in next, L.CLASS do
	local classColorTable = RAID_CLASS_COLORS[class];
	if classColorTable then
		L.COLORED_CLASS[class] = format("\124cff%.2x%.2x%.2x%s\124r", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255, lClass);
	else
		L.COLORED_CLASS[class] = "\124cffffffff" .. lClass .. "\124r";
	end
end
if LOCALE == "zhCN" then
	L.CALENDAR = "日历";
	L.BOARD = "进度";
	L.WEEKTITLE = {
		[1] = "星期一";
		[2] = "星期二";
		[3] = "星期三";
		[4] = "星期四";
		[5] = "星期五";
		[6] = "星期六";
		[0] = "星期日";
	};
	L.YEAR_FORMAT = "%d";
	L.MONTH_FORMAT = "年%s";
	L.MONTH = {
		"1月",
		"2月",
		"3月",
		"4月",
		"5月",
		"6月",
		"7月",
		"8月",
		"9月",
		"10月",
		"11月",
		"12月",
	};
	L.FORMAT_DATE_TODAY = "%Y年%m月%d日 %lw";
	L.FORMAT_CLOCK = "%H:%M:%S";
	L.INSTANCE_RESET = " \124cffff9f00重置\124r";
	L.FESTIVAL_START = " \124cff00ff00开始\124r";
	L.FESTIVAL_END = " \124cffff0000结束\124r";
	L.INSTANCE_LOCKED_DOWN = "锁定";
	L.SLASH_NOTE = {
		region = "地区设置为：%s",
		dst = "使用DST时间",
		use_realm_time_zone = "使用服务器时区",
		instance_icon = "副本图标",
		instance_text = "副本文本",
		first_col_day = "首列设置为：%s",
		show_DBIcon = "小地图按钮",
		scale = "缩放",
		alpha = "透明度",
		show_unlocked = "显示所有角色",
		hide_calendar_on_esc = "按ESC隐藏日历",
		hide_board_on_esc = "按ESC隐藏进度面板",
	};
	L.TooltipLines = {
		"\124cff00ff00左键点击\124r打开/关闭日历",
		"\124cff00ff00右键点击\124r打开/关闭副本进度",
	};
	L.DBIcon_Text = "日历";
	L.CLOSE = "关闭";
	L.RESET_ALL_SETTINGS = "重置所有设置";
	L.RESET_ALL_SETTINGS_NOTIFY = "确定要重置所有设置？";
	L.CALL_BOARD = "副本进度";
	L.CALL_CALENDAR = "日历";
	L.CALL_CONFIG = "设置";
	L.CALL_CHAR_LIST = "角色列表";
	L.AD_TEXT = "要有爱，不要魔兽世界";
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
	L["COOLDOWN_EXPIRED"] = "冷却结束";
	L.CHAR_LIST = "角色列表";
	L.CHAR_ADD = "手动添加";
	L.CHAR_DEL = "删除角色";
	L.CHAR_MOD = "修改角色"
	L.EXISTED = "\124cffff0000角色已经存在\124r";
	L.LOCKDOWN_ADD = "副本锁定";
	L.LOCKDOWN_DEL = "副本未锁定";
elseif LOCALE == "zhTW" then
	L.CALENDAR = "日曆";
	L.BOARD = "進度";
	L.WEEKTITLE = {
		[1] = "星期一";
		[2] = "星期二";
		[3] = "星期三";
		[4] = "星期四";
		[5] = "星期五";
		[6] = "星期六";
		[0] = "星期日";
	};
	L.YEAR_FORMAT = "%d";
	L.MONTH_FORMAT = "年%s";
	L.MONTH = {
		"1月",
		"2月",
		"3月",
		"4月",
		"5月",
		"6月",
		"7月",
		"8月",
		"9月",
		"10月",
		"11月",
		"12月",
	};
	L.FORMAT_DATE_TODAY = "%Y年%m月%d日 %lw";
	L.FORMAT_CLOCK = "%H:%M:%S";
	L.INSTANCE_RESET = " \124cffff9f00重置\124r";
	L.FESTIVAL_START = " \124cff00ff00開始\124r";
	L.FESTIVAL_END = " \124cffff0000結束\124r";
	L.INSTANCE_LOCKED_DOWN = "鎖定";
	L.SLASH_NOTE = {
		region = "地區設定為：%s",
		dst = "使用DST時間",
		use_realm_time_zone = "使用伺服器時區",
		instance_icon = "複本圖示",
		instance_text = "副本文本",
		first_col_day = "首欄設置爲：%s",
		show_DBIcon = "小地圖按鈕",
		scale = "縮放",
		alpha = "透明度",
		show_unlocked = "顯示所有角色",
		hide_calendar_on_esc = "按ESC隱藏日曆",
		hide_board_on_esc = "按ESC隱藏進度面板",
	};
	L.TooltipLines = {
		"\124cff00ff00左鍵點擊\124r打開/關閉日曆",
		"\124cff00ff00右鍵點擊\124r打開/關閉副本進度",
	};
	L.DBIcon_Text = "日曆";
	L.CLOSE = "關閉";
	L.RESET_ALL_SETTINGS = "重置所有配置";
	L.RESET_ALL_SETTINGS_NOTIFY = "確定要重置所有配置？";
	L.CALL_BOARD = "副本進度";
	L.CALL_CALENDAR = "日曆";
	L.CALL_CONFIG = "設置";
	L.CALL_CHAR_LIST = "角色列表";
	L.AD_TEXT = "要有愛，不要魔獸爭霸";
	L["COLORED_FORMATTED_TIME_LEN"] = {
		"\124cff%.2x%.2x00%d天%02d時%02d分%02d秒\124r",
		"\124cff%.2x%.2x00%d時%02d分%02d秒\124r",
		"\124cff%.2x%.2x00%d分%02d秒\124r",
		"\124cff%.2x%.2x00%d秒\124r",
	};
	L["FORMATTED_TIME_LEN"] = {
		"%d天%02d時%02d分%02d秒",
		"%d時%02d分%02d秒",
		"%d分%02d秒",
		"%d秒",
	};
	L["FORMATTED_TIME"] = "%Y年%m月%d日\n%H:%M:%S";
	L["COOLDOWN_EXPIRED"] = "冷卻結束";
	L.CHAR_LIST = "角色列表";
	L.CHAR_ADD = "手動添加";
	L.CHAR_DEL = "刪除角色";
	L.CHAR_MOD = "修改角色"
	L.EXISTED = "\124cffff0000角色已經存在\124r";
	L.LOCKDOWN_ADD = "副本鎖定";
	L.LOCKDOWN_DEL = "副本未鎖定";
elseif LOCALE == "koKR" then
	L.CALENDAR = "달력";
	L.BOARD = "인스턴스";
	L.WEEKTITLE = {
		[1] = "월";
		[2] = "화";
		[3] = "수";
		[4] = "목";
		[5] = "금";
		[6] = "토";
		[0] = "일";
	};
	L.YEAR_FORMAT = "%d";
	L.MONTH_FORMAT = "년%s";
	L.MONTH = {
		" 1월",
		" 2월",
		" 3월",
		" 4월",
		" 5월",
		" 6월",
		" 7월",
		" 8월",
		" 9월",
		" 10월",
		" 11월",
		" 12월",
	};
	L.FORMAT_DATE_TODAY = "%Y년 %m월 %d일 %lw요일";
	L.FORMAT_CLOCK = "%H:%M:%S";
	L.INSTANCE_RESET = " \124cffff9f00초기화\124r";
	L.FESTIVAL_START = " \124cff00ff00시작\124r";
	L.FESTIVAL_END = " \124cffff0000종료\124r";
	L.INSTANCE_LOCKED_DOWN = "잠김";
	L.SLASH_NOTE = {
		region = "지역 변경: %s",
		dst = "DST 시간 사용 하기",
		use_realm_time_zone = "서버 시간 대 사용 하기",
		instance_icon = "복사 아이콘",
		instance_text = "복사 본 텍스트",
		first_col_day = "첫번째 열의 요일 변경: %s",
		show_DBIcon = "미니맵 버튼",
		scale = "Scale",
		alpha = "Alpha",
		show_unlocked = "잠긴 인스턴스 문자 표시",
		hide_calendar_on_esc = "ESC 로 달력 숨 기기",
		hide_board_on_esc = "ESC 숨 기기 패 널 누 르 기",
	};
	L.TooltipLines = {
		"\124cff00ff00좌클릭\124r 달력 토글",
		"\124cff00ff00우클릭\124r 잠긴 인스턴스 토글",
	};
	L.DBIcon_Text = "달력";
	L.CLOSE = "닫기";
	L.RESET_ALL_SETTINGS = "모든 설정 초기 화";
	L.RESET_ALL_SETTINGS_NOTIFY = "모든 설정 을 리 셋 하 시 겠 습 니까?";
	L.CALL_BOARD = "인던 잠김";
	L.CALL_CALENDAR = "달력";
	L.CALL_CONFIG = "설치";
	L.CALL_CHAR_LIST = "캐릭터 목록";
	L.AD_TEXT = "More Love Less Hatred";
	L["COLORED_FORMATTED_TIME_LEN"] = {
		"\124cff%.2x%.2x00%d일 %02d시간 %02d분 %02d초\124r",
		"\124cff%.2x%.2x00%d시간 %02d분 %02d초\124r",
		"\124cff%.2x%.2x00%d분 %02d초\124r",
		"\124cff%.2x%.2x00%d초\124r",
	};
	L["FORMATTED_TIME_LEN"] = {
		"%d일 %02d시간 %02d분 %02d초",
		"%d시 %02d분 %02d초",
		"%d분 %02d초",
		"%d초",
	};
	L["FORMATTED_TIME"] = "%Y년%m월%d일\n%H:%M:%S";
	L["COOLDOWN_EXPIRED"] = "유효함";
	L.CHAR_LIST = "캐릭터 목록";
	L.CHAR_ADD = "수 동 추가";
	L.CHAR_DEL = "캐릭터 삭제";
	L.CHAR_MOD = "역할 변경"
	L.EXISTED = "\124cffff0000캐릭터 가 이미 존재 합 니 다\124r";
	L.LOCKDOWN_ADD = "잠 금";
	L.LOCKDOWN_DEL = "잠 금 되 지 않 음";
else
	L.CALENDAR = "Calendar";
	L.BOARD = "Instance";
	L.WEEKTITLE = {
		[1] = "Mon.";
		[2] = "Tues.";
		[3] = "Wed.";
		[4] = "Thur.";
		[5] = "Fri.";
		[6] = "Sat.";
		[0] = "Sun.";
	};
	L.YEAR_FORMAT = "%d";
	L.MONTH_FORMAT = "%s ";
	L.MONTH = {
		"Jan.",
		"Feb.",
		"Mar.",
		"Apr.",
		"May.",
		"Jun.",
		"Jul.",
		"Aug.",
		"Sep.",
		"Oct.",
		"Nov.",
		"Dec.",
	};
	L.FORMAT_DATE_TODAY = "%b %d, %y %lw";
	L.FORMAT_CLOCK = "%H:%M:%S";
	L.INSTANCE_RESET = " \124cffff9f00reset\124r";
	L.FESTIVAL_START = " \124cff00ff00starts\124r";
	L.FESTIVAL_END = " \124cffff0000ends\124r";
	L.INSTANCE_LOCKED_DOWN = "Locked";
	L.SLASH_NOTE = {
		region = "Set region to: %s",
		dst = "Use DST",
		use_realm_time_zone = "Use realm time zone",
		instance_icon = "Instance icon",
		instance_text = "Instance text",
		first_col_day = "Fist row is set to: %s",
		show_DBIcon = "Minimap button",
		scale = "Scale",
		alpha = "Alpha",
		show_unlocked = "Show all characters",
		hide_calendar_on_esc = "Hide calendar on Esc",
		hide_board_on_esc = "Hide board on Esc",
	};
	L.TooltipLines = {
		"\124cff00ff00Left click\124r to toggle calendar",
		"\124cff00ff00Right click\124r to toggle board displaying instance locked down",
	};
	L.DBIcon_Text = "Calendar";
	L.CLOSE = "Close";
	L.RESET_ALL_SETTINGS = "Reset all settings";
	L.RESET_ALL_SETTINGS_NOTIFY = "Are you sure to reset all settings ?";
	L.CALL_BOARD = "Instance locked down";
	L.CALL_CALENDAR = "Calendar";
	L.CALL_CONFIG = "Config";
	L.CALL_CHAR_LIST = "Character list";
	L.AD_TEXT = "More Love Less Hatred";
	L["COLORED_FORMATTED_TIME_LEN"] = {
		"\124cff%.2x%.2x00%dd %02dh %02dm %02ds\124r",
		"\124cff%.2x%.2x00%dh %02dm %02ds\124r",
		"\124cff%.2x%.2x00%dm %02ds\124r",
		"\124cff%.2x%.2x00%ds\124r",
	};
	L["FORMATTED_TIME_LEN"] = {
		"%dd %02dh %02dm %02ds",
		"%dh %02dm %02ds",
		"%dm %02ds",
		"%ds",
	};
	L["FORMATTED_TIME"] = "%Y-%m-%d\n%H:%M:%S";
	L["COOLDOWN_EXPIRED"] = "Available";
	L.CHAR_LIST = "Character list";
	L.CHAR_ADD = "Manual added";
	L.CHAR_DEL = "Del character";
	L.CHAR_MOD = "Mod character"
	L.EXISTED = "\124cffff0000Character existed\124r";
	L.LOCKDOWN_ADD = "Lock";
	L.LOCKDOWN_DEL = "Unlock";
end

NS.L = L;
