--------------------------------------------------------------------------
-- zhCN.lua 
--------------------------------------------------------------------------
--[[
GTFO Simplified Chinese Localization
Translator: wowuicn, xazhaoyang, lsjyzjl, Mini_Dragon
]]--

if (GetLocale() == "zhCN") then
	local L = GTFOLocal;
	L.Active_Off = "插件暂停";
	L.Active_On = "插件恢复";
	L.AlertType_Fail = "犯错";
	L.AlertType_FriendlyFire = "友方攻击";
	L.AlertType_High = "高";
	L.AlertType_Low = "低";
	L.ClosePopup_Message = "你可以稍后输入: %s 来配置GTFO.";
	L.Group_None = "无";
	L.Group_NotInGroup = "你不一个小队或团队中.";
	L.Group_PartyMembers = "%d 超过 %d 位小队成员使用了本插件.";
	L.Group_RaidMembers = "%d 超过 %d 位团员使用了本插件.";
	L.Help_Intro = "v%s (|cFFFFFFFF命令列表|r)";
	L.Help_Options = "显示选项";
	L.Help_Suspend = "暂停/恢复插件";
	L.Help_Suspended = "该插件目前是暂停状态.";
	L.Help_TestFail = "播放一个测试音效 (犯错警报)";
	L.Help_TestFriendlyFire = "测试播放一个音效 (友方攻击)";
	L.Help_TestHigh = "播放一个测试音效 (高伤害)";
	L.Help_TestLow = "播放一个测试音效 (低伤害)";
	L.Help_Version = "显示其他团队中正在使用这个插件的人员";
	L.Loading_Loaded = "v%s 载入完成.";
	L.Loading_LoadedSuspended = "v%s 载入完成. (|cFFFF1111暂停|r)";
	L.Loading_LoadedWithPowerAuras = "v%s 与 Power Auras 同时载入完成.";
	L.Loading_NewDatabase = "v%s: 发现新的数据库版本, 重设为预设.";
	L.Loading_OutOfDate = "v%s 发现一个新的版本下载!  |cFFFFFFFF请尽快更新.|r";
	L.LoadingPopup_Message = "你的GTFO设置已被重置为默认。你是否想要立即配置GTFO？";
	L.Loading_PowerAurasOutOfDate = "你的 |cFFFFFFFFPower Auras Classic|r 版本已过期!  GTFO & Power Auras 将无法同时加载.";
	L.Recount_Environmental = "环境";
	L.Recount_Name = "GTFO 警报";
	L.Skada_AlertList = "GTFO 警报类型";
	L.Skada_Category = "警报";
	L.Skada_SpellList = "GTFO 法术";
	L.TestSound_Fail = "测试播放一个(犯错警报)音效.";
	L.TestSound_FailMuted = "测试播放一个(犯错警报)音效. [|cFFFF4444静音|r]";
	L.TestSound_FriendlyFire = "测试播放一个(友方攻击)音效.";
	L.TestSound_FriendlyFireMuted = "测试播放一个(友方攻击)音效. [|cFFFF4444静音|r]";
	L.TestSound_High = "测试播放一个(高伤害)音效.";
	L.TestSound_HighMuted = "测试播放一个(高伤害)音效. [|cFFFF4444静音|r]";
	L.TestSound_Low = "测试播放一个(低伤害)音效.";
	L.TestSound_LowMuted = "测试播放一个(低伤害)音效. [|cFFFF4444静音|r]";
	L.UI_Enabled = "启用";
	L.UI_EnabledDescription = "启用 GTFO 插件.";
	L.UI_Fail = "犯错警报 音效";
	L.UI_FailDescription = "当错误移动时 GTFO 警报音效!";
	L.UI_FriendlyFire = "友方攻击音效";
	L.UI_FriendlyFireDescription = "当你的站位受到友方攻击时，启用 GTFO 警告音效!";
	L.UI_HighDamage = "团队/高伤害 音效";
	L.UI_HighDamageDescription = "当你于团队中处在一个高伤害站位时，立即启用这个警报音效.";
	L.UI_LowDamage = "PvP/环境/低伤害 音效";
	L.UI_LowDamageDescription = "当你在低危险环境/PVP环境的站位时，发出GTFO-boop音效";
	L.UI_SoundChannel = "声音通道";
	L.UI_SoundChannelDescription = "GTFO将会使用这个声道播放警告";
	L.UI_SpecialAlerts = "特殊警报";
	L.UI_SpecialAlertsHeader = "启用特殊警报";
	L.UI_Test = "测试";
	L.UI_TestDescription = "测试这个音效.";
	L.UI_TestMode = "实验/测试 模式";
	L.UI_TestModeDescription = "激活未测试的/未验证的警报（BETA/PTR）";
	L.UI_TestModeDescription2 = "请报告任何问题到 |cFF44FFFF%s@%s.%s|r";
	L.UI_Trivial = "琐碎内容警报";
	L.UI_TrivialDescription = "启用低等级的副本警报.";
	L.UI_TrivialDescription2 = "设置伤害承受的最低HP百分比，警告会忽略较低的伤害。";
	L.UI_TrivialSlider = "HP最低百分比 (玩家血量)";
	L.UI_Unmute = "当静音时播放音效";
	L.UI_UnmuteDescription = "如果你禁音了主音效，GTFO将临时开启来播放 GTFO 警报音效.";
	L.UI_UnmuteDescription2 = "这个设定需要主音量高于 0%.";
	L.UI_Volume = "GTFO 音量";
	L.UI_VolumeDescription = "设置警报音效的音量.";
	L.UI_VolumeLoud = "4: 高声";
	L.UI_VolumeLouder = "5: 洪亮";
	L.UI_VolumeMax = "最大";
	L.UI_VolumeMin = "最小";
	L.UI_VolumeNormal = "3: 默认 (推荐)";
	L.UI_VolumeQuiet = "1: 安静";
	L.UI_VolumeSoft = "2: 柔和";
	L.Version_Off = "关闭版本更新提醒";
	L.Version_On = "开启版本更新提醒";
end
