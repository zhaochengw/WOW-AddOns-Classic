--------------------------------------------------------------------------
-- zhTW.lua 
--------------------------------------------------------------------------
--[[
GTFO Traditional Chinese Localization
Translators: wowuicn, lsjyzjl, xazhaoyang, Andyca, BNSSNB
]]--

if (GetLocale() == "zhTW") then
	local L = GTFOLocal;
	L.Active_Off = "插件暫停";
	L.Active_On = "插件恢復";
	L.AlertType_Fail = "犯錯";
	L.AlertType_FriendlyFire = "友方攻擊";
	L.AlertType_High = "高";
	L.AlertType_Low = "低";
	L.ClosePopup_Message = "你可以稍後輸入：%s 來設定GTFO。";
	L.Group_None = "無";
	L.Group_NotInGroup = "你不一個隊伍或團隊中.";
	L.Group_PartyMembers = "其中有 %d 位 / 全隊： %d 位隊伍成員使用了本插件。";
	L.Group_RaidMembers = "其中有 %d 位 / 全隊： %d 位團員使用了本插件。";
	L.Help_Intro = "v%s (|cFFFFFFFF命令列表|r)";
	L.Help_Options = "顯示選項";
	L.Help_Suspend = "暫停/恢復插件";
	L.Help_Suspended = "該插件目前是暫停狀態.";
	L.Help_TestFail = "播放一個測試音效 (犯錯警報)";
	L.Help_TestFriendlyFire = "測試播放一個音效 (友方攻擊)";
	L.Help_TestHigh = "播放一個測試音效 (高傷害)";
	L.Help_TestLow = "播放一個測試音效 (低傷害)";
	L.Help_Version = "顯示團隊中，其他正在使用這個插件的成員";
	L.Loading_Loaded = "v%s 載入完成.";
	L.Loading_LoadedSuspended = "v%s 載入完成. (|cFFFF1111暫停|r)";
	L.Loading_LoadedWithPowerAuras = "v%s 與 Power Auras 同時載入完成.";
	L.Loading_NewDatabase = "v%s: 發現新的數據庫版本, 重設為預設.";
	L.Loading_OutOfDate = "v%s 發現一個新的版本下載!  |cFFFFFFFF請盡快更新.|r";
	L.LoadingPopup_Message = "你的GTFO設定已被重置為預設值。你是否想要立即設定GTFO？";
	L.Loading_PowerAurasOutOfDate = "你的 |cFFFFFFFFPower Auras Classic|r 版本已過期!  GTFO & Power Auras 將無法同時載入。";
	L.Recount_Environmental = "環境";
	L.Recount_Name = "GTFO 警報";
	L.Skada_AlertList = "GTFO 警報類型";
	L.Skada_Category = "警報";
	L.Skada_SpellList = "GTFO 法術";
	L.TestSound_Fail = "測試播放一個(犯錯警報)音效。";
	L.TestSound_FailMuted = "測試播放一個(犯錯警報)音效. [|cFFFF4444靜音|r]";
	L.TestSound_FriendlyFire = "測試播放一個(友方攻擊)音效.";
	L.TestSound_FriendlyFireMuted = "測試播放一個(友方攻擊)音效. [|cFFFF4444靜音|r]";
	L.TestSound_High = "測試播放一個(高傷害)音效.";
	L.TestSound_HighMuted = "測試播放一個(高傷害)音效. [|cFFFF4444靜音|r]";
	L.TestSound_Low = "測試播放一個(低傷害)音效.";
	L.TestSound_LowMuted = "測試播放一個(低傷害)音效. [|cFFFF4444靜音|r]";
	L.UI_Enabled = "啟用";
	L.UI_EnabledDescription = "啟用 GTFO 插件.";
	L.UI_Fail = "犯錯警報音效";
	L.UI_FailDescription = "當你應該走位卻沒走位時，播放GTFO警報音效 -- 希望下次能改善!";
	L.UI_FriendlyFire = "友方攻擊音效";
	L.UI_FriendlyFireDescription = "當你的站位受到友方攻擊時(如燃燒、爆炸等)，啟用GTFO警告音效。你們其中之一最好離開!";
	L.UI_HighDamage = "團隊/高傷害音效";
	L.UI_HighDamageDescription = "當你位於會受到高傷害的位置時，立即啟用播放GTFO強烈的警告音效。";
	L.UI_LowDamage = "PvP/環境/低傷害音效";
	L.UI_LowDamageDescription = "當你還在考慮或是沒離開低傷害區時，啟動GTFO低傷害音效。";
	L.UI_SoundChannel = "聲音頻道";
	L.UI_SoundChannelDescription = "這是GTFO警告聲音將歸屬的聲音頻道。";
	L.UI_SpecialAlerts = "特殊警報";
	L.UI_SpecialAlertsHeader = "啟用特殊警報";
	L.UI_Test = "測試";
	L.UI_TestDescription = "測試音效.";
	L.UI_TestMode = "實驗/測試模式";
	L.UI_TestModeDescription = "啟用未測試的/未驗證的警報。(Beta/PTR)";
	L.UI_TestModeDescription2 = "如有任何問題，請回報到 |cFF44FFFF%s@%s.%s|r";
	L.UI_Trivial = "低等級警報";
	L.UI_TrivialDescription = "啟用低等級的副本警報.";
	L.UI_TrivialDescription2 = "設定最低能承受傷害的HP值滑塊，警告才不會被認為無關緊要。";
	L.UI_TrivialSlider = "最低 % 的HP (玩家血量)";
	L.UI_Unmute = "當靜音時播放音效";
	L.UI_UnmuteDescription = "如果你關閉了主音量，GTFO將暫時開啟音量來播放GTFO的警報。";
	L.UI_UnmuteDescription2 = "這個設定需要主音量(並且頻道已選)高於 0%.";
	L.UI_Volume = "GTFO 音量";
	L.UI_VolumeDescription = "設置警報音效的音量.";
	L.UI_VolumeLoud = "4: 大聲";
	L.UI_VolumeLouder = "5: 大聲";
	L.UI_VolumeMax = "最大";
	L.UI_VolumeMin = "最小";
	L.UI_VolumeNormal = "3: 一般 (推薦)";
	L.UI_VolumeQuiet = "1: 安靜";
	L.UI_VolumeSoft = "2: 柔和";
	L.Version_Off = "版本更新提醒關閉";
	L.Version_On = "版本更新提醒啟用";
end
