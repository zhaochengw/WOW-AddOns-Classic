if GetLocale() ~= "koKR" then return end
local L

------------
-- The Stone Guard --
------------
L = DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "곧 %s!",
	specWarnBreakJasperChains	= "벽옥 사슬 푸세요!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "과부하되기 전에 특수 알림 보기",
	specWarnBreakJasperChains	= "$spell:130395을 안전하게 풀 수 있을 때 특수 알림 보기",
	InfoFrame					= "보스 기력, 석화 상태, 어느 보스가 석화를 시전중인지 정보 창에 표시"
})

L:SetMiscLocalization({
	Overload	= "과부하되기 직전입니다!"
})

------------
-- Feng the Accursed --
------------
L = DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase			= "%d단계",
	specWarnBarrierNow	= "무효화의 장벽을 사용하세요!"
})

L:SetOptionLocalization({
	WarnPhase			= "단계 전환 알림",
	specWarnBarrierNow	= "$spell:115817을 사용해야 할 때 특수 알림 보기 (공찾에서만 작동)",
	RangeFrame			= "비전 단계 동안 " .. DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("6")
})

L:SetMiscLocalization({
	Fire	= "오 고귀한 자여! 나와 함께 발라내자! 뼈에서 살을!",
	Arcane	= "오 세기의 현자여! 내게 비전의 지혜를 불어넣어라!",
	Nature	= "오 위대한 영혼이여! 내게 대지의 힘을 부여하라!",
	Shadow	= "과거의 위대한 영웅들이여! 너희의 방패를 빌려다오!"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L = DBM:GetModLocalization(682)

L:SetMiscLocalization({
	Pull		= "죽을 시간이다!",
	RolePlay	= "날 열받게 했겠다!"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon	= "암흑의 방패 %d초 전"
})

L:SetTimerLocalization({
	timerUSRevive		= "불멸의 어둠 재형성"
})

L:SetOptionLocalization({
	DarknessSoon	= "$spell:117697에 사전 경고 초읽기 보기 (5초 전부터)",
	timerUSRevive	= "$spell:117506 재형성 타이머 바 보기"
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "바닥 사라짐 6초 전!"
})

L:SetTimerLocalization({
	timerDespawnFloor	= "바닥 사라짐"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "바닥이 사라지기 전 특수 알림 보기",
	timerDespawnFloor		= "바닥이 사라지면 타이머 바 표시"
})

------------
-- Will of the Emperor --
------------
L = DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "$spell:116525에 걸린 사람을 정보 창에 표시",
	CountOutCombo	= "$journal:5673 시전 횟수 음성 알림<br/>알림: 현재는 음성이 Corsica 일때만 작동합니다.",
	ArrowOnCombo	= "$journal:5673 도중 DBM 화살표 표시<br/>알림: 방향은 탱커가 보스 앞에 있고 본진이 뒤에 있을때가 기준입니다."
})

L:SetMiscLocalization({
	Pull		= "기계가 윙윙거리며 동작하기 시작합니다! 아래층으로 가십시오!",--Emote
	Rage		= "황제의 분노가 온 언덕에 울려퍼진다.",--Yell
	Strength	= "황제의 힘이 벽감에 나타납니다!",--Emote
	Courage		= "황제의 용기가 벽감에 나타납니다!",--Emote
	Boss		= "거대한 모구 조형체 둘이 큰 벽감에 나타납니다!"--Emote
})

------------
-- Imperial Vizier Zor'lok --
------------
L = DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnEcho			= "메아리 등장",
	warnEchoDown		= "메아리 처치",
	specwarnAttenuation	= "%s : %s (%s)",
	specwarnPlatform	= "단상 변경"
})

L:SetOptionLocalization({
	warnEcho			= "메아리 등장시 알림",
	warnEchoDown		= "메아리가 잡히면 알림",
	specwarnPlatform	= "보스가 단상을 바꾸면 특수 알림 보기",
	ArrowOnAttenuation	= "$spell:127834 동안 이동할 방향을 DBM 화살표로 표시"
})

L:SetMiscLocalization({
	Platform	= "단상으로 날아갑니다!",
	Defeat		= "우리는 어두운 공허의 절망에 지지 않으리라. 우리가 죽는 것이 그분의 뜻이라면, 그대로 따르리라."
})

------------
-- Blade Lord Ta'yak --
------------
--L = DBM:GetModLocalization(744)

-------------------------------
-- Garalon --
-------------------------------
L = DBM:GetModLocalization(713)

L:SetWarningLocalization({
	specwarnUnder	= "보라색 원 밖으로 나가세요!"
})

L:SetOptionLocalization({
	specwarnUnder	= "보스의 주시 대상일 때 특수 알림 보기"
})

L:SetMiscLocalization({
	UnderHim	= "있는 것을 감지하고",
	Phase2		= "장갑이 갈라지면서 쪼개지기"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
--L = DBM:GetModLocalization(741)

------------
-- Amber-Shaper Un'sok --
------------
L = DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s : >%s< (%d)",
	warnReshapeLifeTutor		= "1: 대상 차단/디버프 걸기 (보스에 디버프 중첩 쌓는 용도), 2: 호박석 폭발 시전시 차단, 3: 의지력 낮을 때 회복 (주로 3단계에서 사용), 4: 피조물 탈주 (1, 2단계 전용)",
	warnAmberExplosion			= ">%s<가 %s|1을;를; 시전합니다",
	warnAmberExplosionAM		= "호박석 괴수가 호박석 폭발 시전 - 차단!",--personal warning.
	warnInterruptsAvailable		= "%s 차단 가능: >%s<",
	warnWillPower				= "현재 의지력: %s",
	specwarnWillPower			= "의지력 낮음! - 피조물에서 탈주하거나 바닥을 흡수하세요!",
	specwarnAmberExplosionYou	= "%s|1을;를; 차단!",
	specwarnAmberExplosionAM	= "%s: %s 차단!",
	specwarnAmberExplosionOther	= "%s: %s 차단!"
})

L:SetTimerLocalization({
	timerDestabalize		= "불안정화 (%2$d) : %1$s",
	timerAmberExplosionAMCD	= "폭발 쿨타임: 괴수"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "돌연변이 피조물의 스킬 용도 표시",
	warnAmberExplosion			= "$spell:122398 시전시 특수 알림 보기 (시전자 포함)",
	warnAmberExplosionAM		= "호박석 괴수가 $spell:122398을 시전할 때<br/> 개인 알림 보기 (차단)",
	warnInterruptsAvailable		= "누가 $spell:122402을 차단 가능한 지 알림",
	warnWillPower				= "현재 의지력이 80, 50, 30, 10, 4일 때 알림",
	specwarnWillPower			= "피조물에 탑승한 동안 의지력이 낮을 때 특수 알림 보기",
	specwarnAmberExplosionYou	= "$spell:122398 차단 특수 알림 보기",
	specwarnAmberExplosionAM	= "호박석 괴수의 $spell:122402 차단 특수 알림 보기",
	specwarnAmberExplosionOther	= "풀려난 돌연변이 피조물의 $spell:122398 차단 특수 알림 보기",
	timerAmberExplosionAMCD		= "호박석 괴수의 다음 $spell:122402 타이머 바 보기",
	InfoFrame					= "의지력을 정보 창에 표시",
	FixNameplates				= "피조물에 탑승한 동안 이름표 관련 기능 작동 중단<br/>(전투가 끝나면 설정 복구)"
})

L:SetMiscLocalization({
	WillPower	= "의지력"
})

------------
-- Grand Empress Shek'zeer --
------------
L = DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap	= "호박석 덪 설치: (%d/5)"
})

L:SetOptionLocalization({
	warnAmberTrap	= "$spell:125826이 깔리면 알림 보기",
	InfoFrame		= "$spell:125390 대상을 정보 창에 표시"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "주시 대상",
	YellPhase3		= "변명은 이제 지겹다, 여제! 당장 이 멍청이들을 쓸어버리지 않으면 내가 몸소 널 죽이겠다!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name	= "공포의 심장 일반몹"
})

------------
-- Protectors of the Endless --
------------
L = DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "디버프 순서: %s파티",
	specWarnYourGroup	= "당신 파티 차례 - 디버프 받으세요!"
})

L:SetOptionLocalization({
	warnGroupOrder		= "$spell:118191를 받을 파티 순서 알림<br/>(25인 전용으로 5,2,2,2씩 맞는 공략)",
	specWarnYourGroup	= "내가 속한 파티가 $spell:118191를 받을 차례가 되면 특수 알림 보기<br/>(25인 전용)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(8, 111850) .. "<br/>(디버프에 걸리면 모든 공대원을 표시하고 안걸렸을땐 대상자만)"
})

------------
-- Tsulong --
------------
L = DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "고맙다, 이방인이여. 날 자유롭게 해줘서."
}

-------------------------------
-- Lei Shi --
-------------------------------
L = DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver	= "%s 종료"
})

L:SetTimerLocalization({
	timerSpecialCD	= "특수 기술 쿨타임 (%d)"
})

L:SetOptionLocalization({
	warnHideOver	= "$spell:123244 종료시 알림 보기",
	timerSpecialCD	= "특수 스킬 쿨타임 타이머 바 보기",
	RangeFrame		= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(3, 123121).."<br/>(숨어있을 땐 모든 공대원을 표시하고 나오면 탱커만 표시)"
})

L:SetMiscLocalization{
	Victory	= "아... 앗! 내가 무슨...? 혹시...? 너무... 흐릿해."
}

----------------------
-- Sha of Fear --
----------------------
L = DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveForward					= "건너편으로 이동",
	MoveRight					= "오른쪽으로 이동",
	MoveBack					= "이전 위치로 이동",
	specWarnBreathOfFearSoon	= "곧 공포 숨결 - 장벽 안으로 이동!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD	= "다음 특수 기술",
	timerSpoHudCD			= "공포 / 용오름 쿨타임",
	timerSpoStrCD			= "용오름 / 일격 쿨타임",
	timerHudStrCD			= "공포 / 일격 쿨타임"
})

L:SetOptionLocalization({
	warnBreathOnPlatform		= "단상에 있을 때에도 $spell:119414 알림 보기<br/>(권장하지 않음, 공대장용)",
	specWarnBreathOfFearSoon	= "$spell:117964 버프가 없으면 $spell:119414 사전 경고 보기",
	specWarnMovement			= "$spell:120047가 시전되면 이동 방향 특수 알림 보기<br/>(입구에서 시작해서 이동하는 일반적인 공략을 기반으로 하며 DBM이 제시하는 방향을 따라가야 합니다)",
	timerSpecialAbility			= "다음 특수 기술 시전 타이머 바 보기"
})

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L = DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "곧 %s - 전도성 물 밖으로 나오세요!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "$spell:138470 속에 있을 때 특수 알림 보기<br/>($spell:137313 시전 이전 또는 $spell:138732 디버프가 사라지기 직전에 알림)"
})

--------------
-- Horridon --
--------------
L = DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnOrbofControl		= "조종의 구슬 떨어짐",
	specWarnOrbofControl	= "조종의 구슬 떨어짐!"
})

L:SetTimerLocalization({
	timerDoor				= "다음 부족의 문",
	timerAdds				= "다음 %s"
})

L:SetOptionLocalization({
	warnAdds				= "새로운 쫄이 내려오면 알림",
	warnOrbofControl		= "$journal:7092이 떨어지면 알림",
	specWarnOrbofControl	= "$journal:7092이 떨어지면 특수 알림 보기",
	timerDoor				= "다음 부족의 문 단계 타이머 바 보기",
	timerAdds				= "다음 쫄 등장 타이머 바 보기",
	SetIconOnAdds			= "벽에서 내려오는 쫄에 공격대 징표 설정"
})

L:SetMiscLocalization({
	newForces				= "병력들이 쏟아져",
	chargeTarget			= "꼬리를 바닥에 쿵쿵 내려칩니다!"
})

---------------------------
-- The Council of Elders --
---------------------------
L = DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed	= "%s : %s - 대상 변경!"
})

L:SetOptionLocalization({
	AnnounceCooldowns	= "공생기 사용을 위해 $spell:137166 시전 횟수 음성 알림 (3회 까지)"
})

------------
-- Tortos --
------------
L = DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s 사용 : >%s< (%d 남음)",
	specWarnCrystalShell	= "%s을 집으세요"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "$spell:137633 디버프가 없고 생명력이<br/> 90% 이상이면 특수 알림 보기",
	InfoFrame				= "$spell:137633이 없는 공대원 정보 창에 표시",
	ClearIconOnTurtles		= "$spell:133971에 걸리면 $journal:7129에 공격대 징표 해제",
	AnnounceCooldowns		= "공생기 사용을 위해 $spell:134920 시전 횟수 음성 알림"
})

L:SetMiscLocalization({
	WrongDebuff	= "%s 없음"
})

-------------
-- Megaera --
-------------
L = DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD	= "다음 숨결"
})

L:SetOptionLocalization({
	timerBreaths			= "다음 숨결 타이머 바 보기",
	AnnounceCooldowns		= "공생기 사용을 위해 광란 시전 횟수 음성 알림",
	Never					= "사용 안함",
	Every					= "모두 (계속 증가)",
	EveryTwo				= "2번 이후 초기화",
	EveryThree				= "3번 이후 초기화",
	EveryTwoExcludeDiff		= "2번 이후 초기화 (확산 제외)",
	EveryThreeExcludeDiff	= "3번 이후 초기화 (확산 제외)"
})

L:SetMiscLocalization({
	rampageEnds	= "분노가 가라앉습니다."
})

------------
-- Ji-Kun --
------------
L = DBM:GetModLocalization(828)

L:SetWarningLocalization({
	specWarnBigBird	= "둥지 수호자: %s",
	specWarnBigBirdSoon	= "곧 둥지 수호자: %s"
})

L:SetTimerLocalization({
	timerFlockCD	= "둥지 (%d): %s"
})

L:SetOptionLocalization({
	ShowNestArrows	= "선택한 둥지 위치만 특수 알림 보기",
	Never			= "모든 둥지",
	Northeast		= "파랑 - 북동쪽 아래,위",
	Southeast		= "녹색 - 남동쪽 아래,위",
	Southwest		= "보라/빨강 - 남서쪽 아래, 남서쪽 위(25)/중앙 위(10)",
	West			= "빨강 - 서쪽 아래, 위 중앙 (25인 전용)",
	Northwest		= "노랑 - 북서쪽 아래,위 (25인 전용)",
	Guardians		= "둥지 수호자"
})

L:SetMiscLocalization({
	eggsHatch		= "있는 알들이 부화하기 시작합니다!",
	Upper			= "위쪽",
	Lower			= "아래쪽",
	UpperAndLower	= "위쪽, 아래쪽",
	TrippleD		= "3번 (아래 2번)",
	TrippleU		= "3번 (위 2번)",
	NorthEast		= "|cff0000ff북동쪽|r",
	SouthEast		= "|cFF088A08남동쪽|r",
	SouthWest		= "|cFF9932CD남서쪽|r",
	West			= "|cffff0000서쪽|r",
	NorthWest		= "|cffffff00북서쪽|r",
	Middle10		= "|cFF9932CD중앙|r",
	Middle25		= "|cffff0000중앙|r"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L = DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "광선 - |cffff0000빨강|r : >%s<, |cff0000ff파랑|r : >%s<",
	warnBeamHeroic				= "광선 - |cffff0000빨강|r : >%s<, |cff0000ff파랑|r : >%s<, |cffffff00노랑|r : >%s<",
	warnAddsLeft				= "안개도깨비 남음: %d",
	specWarnBlueBeam			= "파란 광선 - 이동 금지",
	specWarnFogRevealed			= "%s 발견!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam			= "광선 대상 알림",
	warnAddsLeft		= "안개도깨비 남은 숫자 알림",
	specWarnFogRevealed	= "안개도깨비가 발견됐을 때 특수 알림 보기",
	ArrowOnBeam			= "$journal:6882 중에 이동 방향을 보여주는 DBM 화살표 표시",
	InfoFrame			= "$spell:133795 중첩을 정보 창에 표시",
	SetParticle			= "보스가 시작되면 입자 밀도를 낮음으로 자동 설정<br/>(전투가 끝나면 설정 복구)"
})

L:SetMiscLocalization({
	LifeYell	= "%s에 생명력 흡수 (%d)"
})

----------------
-- Primordius --
----------------
L = DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount	= "변형 상황 : %d/5개 좋은 효과 & %d개 나쁜 효과"
})

L:SetOptionLocalization({
	warnDebuffCount		= "웅덩이 흡수시 디버프 중첩 알림 보기",
	SetIconOnBigOoze	= "$journal:6969에 공격대 징표 설정"
})

-----------------
-- Dark Animus --
-----------------
L = DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s<|1과;와; >%s< 자리 바꿈"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "$spell:138618에 의해 자리가 바뀐 대상 알림"
})

L:SetMiscLocalization({
	Pull	= "구슬이 폭발합니다!"
})

--------------
-- Iron Qon --
--------------
L = DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: %s|1과;와; %s 보호 상태"
})

L:SetOptionLocalization({
	RangeFrame	= "동적 거리 창 보기(10m)<br/>(많은 사람이 뭉쳐있을 때만 나오는 스마트 거리 창입니다)",
	InfoFrame	= "$spell:136193 대상을 정보 창에 표시"
})

-------------------
-- Twin Consorts --
-------------------
L = DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight	= "밤 단계",
	warnDay		= "낮 단계",
	warnDusk	= "황혼 단계"
})

L:SetTimerLocalization({
	timerDayCD	= "다음 낮 단계",
	timerDuskCD	= "다음 황혼 단계"
})

L:SetMiscLocalization({
	DuskPhase	= "루린! 힘을 빌려다오!"
})

--------------
-- Lei Shen --
--------------
L = DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "곧 사잇단계",
	warnDiffusionChainSpread	= "%s: >%s<에 전이"
})

L:SetTimerLocalization({
	timerConduitCD	= "첫번째 도관 쿨타임"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "사잇단계 사전 경고 보기",
	warnDiffusionChainSpread	= "$spell:135991의 전이 대상 알림",
	timerConduitCD				= "첫번째 도관 기술 쿨타임 타이머 바 보기",
	StaticShockArrow			= "$spell:135695에 걸린 사람이 있으면 DBM 화살표 표시",
	OverchargeArrow				= "$spell:136295에 걸린 사람이 있으면 DBM 화살표 표시"
})

L:SetMiscLocalization({
	StaticYell	= "%s에 전하 충격 (%d)"
})

------------
-- Ra-den --
------------
L = DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnUnstablVitaJump	= "불안정한 생령 전이됨!"
})

L:SetOptionLocalization({
	specWarnUnstablVitaJump	= "$spell:138297이 전이되면 특수 알림 보기"
})

L:SetMiscLocalization({
	Defeat	= "잠깐"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name	= "천둥의 왕좌 일반몹"
})

---------------
-- Immerseus --
---------------
L = DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory	= "아, 역시 해냈군! 골짜기의 물이 다시 깨끗해졌네."
})

---------------------------
-- The Fallen Protectors --
---------------------------
L = DBM:GetModLocalization(849)

L:SetWarningLocalization({
	specWarnMeasures	= "곧 궁책 (%s)!"
})

---------------------------
-- Norushen --
---------------------------
L = DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime	= "그래, 좋다. 너희 타락을 가두어 둘 공간을 만들겠다."
})

------------------
-- Sha of Pride --
------------------
L = DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "타락한 조각에 공격대 징표 설정"
})

L:SetMiscLocalization({
	PortalRP	= "헬스크림의 오만함이 결국 마지막 샤를 풀어줬군요. 놀랍진 않네요."
})

--------------
-- Galakras --
--------------
L = DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen	= "탑 문 열림",
	warnTowerGrunt	= "탑 그런트"
})

L:SetTimerLocalization({
	timerTowerCD		= "다음 탑 열림",
	timerTowerGruntCD	= "다음 탑 그런트"
})

L:SetOptionLocalization({
	warnTowerOpen		= "탑 문이 열리면 알림",
	warnTowerGrunt		= "탑 그런트 등장시 알림",
	timerTowerCD		= "다음 탑 공격 타이머 바 보기",
	timerTowerGruntCD	= "다음 탑 그런트 타이머 바 보기"
})

L:SetMiscLocalization({
	wasteOfTime		= "잘했다! 상륙 부대, 정렬! 보병대, 앞으로!",--Alliance Version
	wasteOfTime2	= "잘 했소. 선봉대가 성공적으로 상륙했군.",--Horde Version
	Pull			= "용아귀 부족 용사들이여! 항구를 탈환하고 적을 바다로 몰아내라! 헬스크림 님과 진정한 호드를 위하여!",
	newForces1		= "놈들이 와요!",--제이나 대사
	newForces1H		= "저 계집을 당장 끌어내려라. 내가 친히 그녀의 목을 죌 것이다.",--실바나스 대사 (확인 필요)
	newForces2		= "용아귀 용사들아, 진격하라!",
	newForces3		= "헬스크림 님을 위하여!",
	newForces4		= "다음 분대, 진격!",
	tower			= "문이 뚫렸습니다!"
})

--------------------
--Iron Juggernaut --
--------------------
--L = DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L = DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell	= "%s에 감옥 종료 (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L = DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon	= "방어 태세 %d초 전"
})

L:SetMiscLocalization({
	newForces1	= "전사들이여! 이리로!",
	newForces2	= "놈들을 막아라!",--확인 필요
	newForces3	= "병력 집결!",
	newForces4	= "코르크론! 날 지원하라!",
	newForces5	= "다음 분대, 앞으로!",
	allForces	= "전 코르크론, 내 명령을 따르라. 모두 죽여!",
	nextAdds	= "다음 쫄: "
})

------------------------
-- Spoils of Pandaria --
------------------------
L = DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime	= "녹음되고 있는 건가? 응? 좋아. 고블린 티탄 제어 모듈 시동 중. 물러서라고.",
	Module1 	= "제1 모듈, 시스템 초기화 준비 완료.",
	Victory		= "제2 모듈, 시스템 초기화 준비 완료."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L = DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "동적 거리 창 보기 (10m)<br/>(광란 사거리에 닿을 경우에만 보이는 스마트 거리 창입니다)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L = DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "생산 설비에서 미완성 무기가 나오기 시작합니다.",
	newShredder	= "자동 분쇄기가 다가옵니다!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L = DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable	= "%s에게 취약함 - 피하세요!",
	specWarnMoreParasites		= "기생충이 더 필요합니다 - 막지마세요!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable	= "용장이 활성화 될 때 주의해야 할 용장이 있으면 특수 알림 보기",
	specWarnMoreParasites		= "기생충이 더 필요할 때 특수 알림 보기"
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one				= "가 1",
	two				= "가 2",
	three			= "가 3",
	four			= "가 4",
	five			= "가 5",
	hisekFlavor		= "누가 이제 조용한지 봐라.",
	KilrukFlavor	= "무리의 도태가 일어난 또 다른 날이 되었군.",
	XarilFlavor		= "너의 미래에 검은 하늘만 보일뿐.",
	KaztikFlavor	= "단지 쿤총 특식이 되어버렸군.",
	KaztikFlavor2	= "사마귀 한마리 처치. 199마리 남았음.",
	KorvenFlavor	= "고대 제국의 멸망.",
	KorvenFlavor2	= "구르다니 서판을 가져온 후 그들의 숨통을 끊어!",
	IyyokukFlavor	= "기회를 포착하고, 활용해라!",
	KarozFlavor		= "힘 안 들이고 잡아 없애면서도 명성이 높아지는데 뭘 그러나.",
	SkeerFlavor		= "피투성이의 즐거움!",
	RikkalFlavor	= "표본 요청 달성됨."
})

------------------------
-- Garrosh Hellscream --
------------------------
L = DBM:GetModLocalization(869)

L:SetTimerLocalization({
	timerRoleplay	= "NPC 대사"
})

L:SetOptionLocalization({
	timerRoleplay		= "가로쉬/스랄 NPC 대사 타이머 바 보기",
	RangeFrame			= "동적 거리 창 보기(8m)<br/>($spell:147126의 사거리에 닿을 경우에만 보이는 스마트 거리 창입니다)",
	InfoFrame			= "사잇단계에서 뎀감이 없는 대상을 정보 창에 표시"
})

L:SetMiscLocalization({
	wasteOfTime		= "아직 늦지 않았다, 가로쉬. 대족장이라는 짐을 내려놓거라. 지금, 여기서 끝내자. 피를 흘릴 필요는 없다.",
	NoReduce		= "피해 감소 없음",
	phase3End		= "네가 이겼다고 생각하나?"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name	= "오그리마 공성전 일반몹"
})
