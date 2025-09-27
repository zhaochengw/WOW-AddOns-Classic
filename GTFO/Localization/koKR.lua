--------------------------------------------------------------------------
-- koKR.lua 
--------------------------------------------------------------------------
--[[
GTFO Korean Localization
Translators: Sunyruru, Maknae
]]--

if (GetLocale() == "koKR") then
	local L = GTFOLocal;
	L.Active_Off = "애드온 중지";
	L.Active_On = "애드온 시작";
	L.AlertType_Fail = "피해";
	L.AlertType_FriendlyFire = "약한 불";
	L.AlertType_High = "높은 피해";
	L.AlertType_Low = "낮은 피해";
	L.ClosePopup_Message = "다음 명령을 입력해 GTFO 애드온을 설정할 수 있습니다: %s";
	L.Group_None = "그룹 없음";
	L.Group_NotInGroup = "파티나 레이드에 참가중이 아닙니다.";
	L.Group_PartyMembers = "파티원 중 %d/%d 명이 이 애드온을 사용중입니다.";
	L.Group_RaidMembers = "레이드 구성원 중 %d/%d 명이 이 애드온을 사용중입니다.";
	L.Help_Intro = "v%s (|cFFFFFFFF명령어 목록|r)";
	L.Help_Options = "옵션 표시";
	L.Help_Suspend = "애드온 시작/중지";
	L.Help_Suspended = "애드온이 현재 중지중입니다.";
	L.Help_TestFail = "테스트 소리 재생 (피해 알림)";
	L.Help_TestFriendlyFire = "테스트 음향 재생 (약한 불)";
	L.Help_TestHigh = "테스트 소리 재생 (높은 데미지)";
	L.Help_TestLow = "테스트 소리 재생 (낮은 데미지)";
	L.Help_Version = "이 애드온을 실행중인 레이드 구성원 표시.";
	L.LoadingPopup_Message = "GTFO 설정을 초기값으로 설정합니다. 설정을 지금 하시겠습니까?";
	L.Loading_Loaded = "v%s 로드 됨.";
	L.Loading_LoadedSuspended = "v%s 로드 됨. (|cFFFF1111중지중|r)";
	L.Loading_LoadedWithPowerAuras = "v%s & Power Auras 애드온과 함께 로드 됨.";
	L.Loading_NewDatabase = "v%s: 새로운 버전의 데이터베이스 발견, 세팅을 초기화 함.";
	L.Loading_OutOfDate = "v%s 을 새로 다운받을 수 있습니다.  |cFFFFFFFF업데이트 해주세요.|r";
	L.Loading_PowerAurasOutOfDate = "당신의 |cFFFFFFFFPower Auras Classic|r 버전은 옛날거에요! GTFO 와 Power Auras 애드온이 호환되지 않네요. ㅠㅅㅠ";
	L.Recount_Environmental = "주변환경 피해";
	L.Recount_Name = "GTFO 경고";
	L.Skada_AlertList = "GTFO 경고 방식";
	L.Skada_Category = "경고";
	L.Skada_SpellList = "GTFO 기술";
	L.TestSound_Fail = "테스트 소리(피해 알림) 재생중.";
	L.TestSound_FailMuted = "테스트 소리(피해 알림) 재생중. [|cFFFF4444소리 끄기|r]";
	L.TestSound_FriendlyFire = "테스트 음향(약한 불) 재생중.";
	L.TestSound_FriendlyFireMuted = "테스트 음향(약한 불) 재생중. [|cFFFF4444소리 꺼짐|r]";
	L.TestSound_High = "테스트 소리(높은 데미지) 재생중.";
	L.TestSound_HighMuted = "테스트 소리(높은 데미지) 재생중. [|cFFFF4444소리 끄기|r]";
	L.TestSound_Low = "테스트 소리(낮은 데미지) 재생중.";
	L.TestSound_LowMuted = "테스트 소리(낮은 데미지) 재생중. [|cFFFF4444소리 끄기|r]";
	L.UI_Enabled = "활성화";
	L.UI_EnabledDescription = "GTFO 애드온을 활성화 합니다.";
	L.UI_Fail = "피해 알림 소리";
	L.UI_FailDescription = "이동 실패에 대한 GTFO 알림 활성화 -- 다음에는 배워서 피하기를!";
	L.UI_FriendlyFire = "약한 불 음향";
	L.UI_FriendlyFireDescription = "GTFO 사용시 아군이 불위를 걸어갈 때 경고음을 재생합니다. -- 누군가는 움직이는게 좋겠죠?";
	L.UI_HighDamage = "레이드:높은 데미지 소리";
	L.UI_HighDamageDescription = "GTFO 사용시 즉시 다른 곳으로 움직여야 할 때 소리 재생됩니다.";
	L.UI_LowDamage = "PVP 또는 평소: 낮은 데미지 소리";
	L.UI_LowDamageDescription = "GTFO 사용시 움직이던 말던 상관없는 낮은 데미지에 소리가 재생됩니다.";
	L.UI_Test = "테스트";
	L.UI_TestDescription = "테스트 소리";
	L.UI_TestMode = "시험(베타) 모드";
	L.UI_TestModeDescription = "테스트되지 않고 검증되지 않은 경고 모드를 활성화합니다. (베타)";
	L.UI_TestModeDescription2 = "어떠한 문제점이 발견되면 꼭!  |cFF44FFFF%s@%s.%s|r 으로 내용을 보내주세요!";
	L.UI_Trivial = "무시해도 되는 경고";
	L.UI_TrivialDescription = "현재 레벨의 당신의 캐릭터에게 무시해도 되는 낮은 수준의 경고를 활성화합니다.";
	L.UI_Unmute = "소리가 꺼졌을 때에도 소리 재생";
	L.UI_UnmuteDescription = "주 음향과 음향효과를 껐을 때에도, GTFO 애드온이 잠시 소리를 켭니다.";
	L.UI_Volume = "GTFO 소리";
	L.UI_VolumeDescription = "음향을 재생할 소리 크기";
	L.UI_VolumeLoud = "4: 크게";
	L.UI_VolumeLouder = "5: 시끄럽게";
	L.UI_VolumeMax = "최대";
	L.UI_VolumeMin = "최소";
	L.UI_VolumeNormal = "3: 보통 (권장)";
	L.UI_VolumeQuiet = "1:조용히";
	L.UI_VolumeSoft = "2:작게";
	-- 4.12
	L.UI_SpecialAlerts = "특별 알림";
	L.UI_SpecialAlertsHeader = "특별 알림 활성화";	
	-- 4.12.3
	L.Version_On = "버전 업데이트 알림";
	L.Version_Off = "버전 업데이트 알림 해제";
	-- 4.19.1
	L.UI_TrivialSlider = "Minimum % of HP";
	L.UI_TrivialDescription2 = "Set the slider to the minimum % amount of HP damage taken for alerts to not be considered trivial.";
	-- 4.32
	L.UI_UnmuteDescription2 = "This requires the master volume slider to be higher than 0% and will override the sound channel option.";
	L.UI_SoundChannel = "Sound Channel";
	L.UI_SoundChannelDescription = "This is the volume channel that GTFO alert sounds will attach themselves to.";

end
