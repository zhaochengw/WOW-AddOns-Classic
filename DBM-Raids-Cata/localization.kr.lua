if GetLocale() ~= "koKR" then return end
local L

----------------
--  Argaloth  --
----------------
L= DBM:GetModLocalization(139)

-----------------
--  Occu'thar  --
-----------------
L= DBM:GetModLocalization(140)

----------------------------------
--  Alizabal, Mistress of Hate  --
----------------------------------
L= DBM:GetModLocalization(339)

L:SetTimerLocalization({
	TimerFirstSpecial	= "첫번째 특수 기술"
})

L:SetOptionLocalization({
	TimerFirstSpecial	= "$spell:105738 후 첫번째 특수 기술 타이머 바 보기<br/>(첫번째 특수 기술은 $spell:105067와 $spell:104936 중에서 무작위로 결정됩니다.)"
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization(169)

L:SetTimerLocalization({
	timerShadowConductorCast	= "암흑 전도체",
	timerArcaneLockout			= "파괴자 비활성화",
	timerArcaneBlowbackCast		= "비전 역류",
	timerNefAblity				= "스킬 강화 쿨타임"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "$spell:92053 시전 타이머 바 보기",
	timerArcaneLockout			= "$spell:79710 주문 비활성화 타이머 바 보기",
	timerArcaneBlowbackCast		= "$spell:91879 시전 타이머 바 보기",
	timerNefAblity				= "영웅 스킬 강화 쿨타임 타이머 바 보기"
})

L:SetMiscLocalization({
	YellTargetLock				= "어둠의 휘감기! 저에게 오지마세요!"
})

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization(170)

L:SetWarningLocalization({
	SpecWarnInferno	= "곧 타오르는 해골 피조물 (~4초)"
})

L:SetOptionLocalization({
	SpecWarnInferno	= "$spell:92154 사전 특수 경고 보기 (~4초)"
})

L:SetMiscLocalization({
	Slump			= "기울입니다!",
	HeadExposed		= "노출되었습니다!",
	YellPhase2		= "이런 곤란할 데가! 이러다간 내 용암 벌레가 정말 질 수도 있겠군! 그럼... 내가 상황을 좀 바꿔 볼까?"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization(171)

L:SetMiscLocalization({
	NefAdd					= "아트라메데스, 적은 바로 저기에 있다!",
	Airphase				= "그래, 도망가라! 발을 디딜 때마다 맥박은 빨라지지. 점점 더 크게 울리는구나... 귀청이 터질 것만 같군! 넌 달아날 수 없다!"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization(172)

L:SetOptionLocalization({
	InfoFrame		= "생명력 정보 창에 표시 (&lt;1만)"
})

L:SetMiscLocalization({
	HealthInfo	= "생명력 정보"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization(173)

L:SetWarningLocalization({
	WarnPhase			= "%s단계"
})

L:SetTimerLocalization({
	TimerPhase			= "다음 단계"
})

L:SetOptionLocalization({
	WarnPhase			= "어느 단계가 오는지 경고 보기",
	SetTextures			= "암흑 단계에서 텍스쳐 투영 효과 자동으로 비활성화<br/>(암흑 단계가 끝나면 다시 활성화)"
})

L:SetMiscLocalization({
	YellRed			= "붉은색|r 약병을 가마솥",
	YellBlue		= "푸른색|r 약병을 가마솥",
	YellGreen		= "초록색|r 약병을 가마솥",
	YellDark		= "암흑|r 마법을 사용합니다!"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization(174)

L:SetTimerLocalization({
	timerNefLanding		= "네파리안 착지"
})

L:SetOptionLocalization({
	warnShadowblazeSoon		= "$spell:81031 사전 경고 초읽기 보기 (5초 전부터)<br/>(정확도를 유지하기 위해 첫번째 넴드 외침 이후부터 타이머가 동기화 됩니다)",
	timerNefLanding			= "네파리안 착지시 타이머 바 보기",
	SetWater				= "보스 풀링때 수면 자동 시점 옵션을 자동으로 비활성화<br/>(전투가 끝나면 다시 활성화)"
})

L:SetMiscLocalization({
	NefAoe				= "전기가 튀며 파지직하는 소리가 납니다!",
	YellPhase2			= "저주받을 필멸자들! 내 소중한 작품을 이렇게 망치다니! 쓴맛을 봐야 정신을 차리겠군!",
	YellPhase3			= "품위있는 집주인답게 행동하려 했건만, 네놈들이 도무지 죽질 않는군! 겉치레는 이제 집어치우자고. 그냥 모두 없애 버리겠어!",
	YellShadowBlaze			= "살을 재로 만들어 주마!",
	ShadowBlazeExact	= "%d초 후 암흑불꽃 불똥"
})

-------------------------------
--  Blackwing Descent Trash  --
-------------------------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "검은날개 강림지 일반몹"
})

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization(156)

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization(157)

L:SetOptionLocalization({
	TBwarnWhileBlackout		= "$spell:86788이 활성화됐을 때 $spell:86369 경고 보기",
	BlackoutShieldFrame		= "$spell:86788때 보스 생명력을 생명력 바로 보기"
})

L:SetMiscLocalization({
	Trigger1				= "들이쉽니다!",
	BlackoutTarget			= "의식 상실: %s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization(158)

L:SetWarningLocalization({
	specWarnBossLow			= "%s 30%% 이하 - 곧 다음 단계!",
	SpecWarnGrounded		= "접지 받기",
	SpecWarnSearingWinds	= "소용돌이치는 바람 받기"
})

L:SetTimerLocalization({
	timerTransition			= "단계 전환"
})

L:SetOptionLocalization({
	specWarnBossLow			= "보스 생명력이 30% 이하로 내려가면 특수 경고 보기",
	SpecWarnGrounded		= "$spell:83581 디버프가 없을때 특수 경고 보기<br/>(시전 ~10초 전)",
	SpecWarnSearingWinds	= "$spell:83500 디버프가 없을때 특수 경고 보기<br/>(시전 ~10초 전)",
	timerTransition			= "단계 전환 타이머 바 보기",
	yellScrewed				= "$spell:83099와 $spell:92307에 같이 걸리면 말풍선으로 알리기"
})

L:SetMiscLocalization({
	Quake			= "발밑의 땅이 불길하게 우르릉거립니다...",
	Thundershock	= "주변의 공기가 에너지로 진동합니다...",
	Switch			= "우리가 상대하겠다!",--"We will handle them!" comes 3 seconds after this one
	Phase3			= "꽤나 인상적이었다만...",--"BEHOLD YOUR DOOM!" is about 13 seconds after
	Kill			= "이럴 수가...",
	blizzHatesMe	= "봉화랑 막대 같이 걸림! 비키세요!",
	WrongDebuff		= "%s 없음"
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization(167)

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization(168)

L:SetWarningLocalization({
	WarnOrbSoon			= "%d초 후 구슬!",
	SpecWarnOrbs		= "구슬 나옴! 조심하세요!",
	warnWrackJump		= "%s|1이;가; >%s<에게 전이",
	warnAggro			= "어그로 획득 (구슬 후보): >%s<",
	SpecWarnAggroOnYou	= "어그로 먹음! 구슬 조심!"
})

L:SetTimerLocalization({
	TimerEggWeakening 	= "황혼 껍질 떨어짐",
	TimerEggWeaken		= "황혼 껍질 재생",
	TimerOrbs			= "어둠의 구슬 쿨타임"
})

L:SetOptionLocalization({
	WarnOrbSoon			= "구슬 사전 경고 보기 (시전 5초 전부터 1초 마다)<br/>(경고 기능을 기대하나 정확하지 않습니다. 도배가 될수도 있습니다.)",
	warnWrackJump		= "$spell:89421 전이 대상 알림",
	warnAggro			= "구슬이 나올 때 어그로를 먹은 사람들 알림 (구슬 대상이 될 수 있음)",
	SpecWarnAggroOnYou	= "구슬이 나올 때 어그로를 먹었으면 특수 경고 보기<br/>(구슬 대상이 될 수 있음)",
	SpecWarnOrbs		= "구슬이 나올 때 특수 경고 보기 (제대로 경고가 나오길 기대함)",
	TimerEggWeakening  	= "$spell:87654 떨어짐 타이머 바 보기",
	TimerEggWeaken		= "$spell:87654 재생 타이머 바 보기",
	TimerOrbs			= "다음 구슬 타이머 바 보기 (정확하지 않을 수 있음)",
	SetIconOnOrbs		= "구슬이 나올 때 어그로를 먹은 사람에게 공격대 징표 설정<br/>(구슬 대상이 될 수 있음)",
	InfoFrame			= "어그로를 가진 공대원들을 정보 창에 표시"
})

L:SetMiscLocalization({
	YellDragon		= "얘들아, 먹어치워라",
	YellEgg			= "이게 약해지는 걸로 보이느냐? 멍청한 놈!",
	HasAggro		= "어그로 먹음"
})

-------------------------------------
--  The Bastion of Twilight Trash  --
-------------------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"황혼의 요새 일반몹"
})

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization(154)

L:SetWarningLocalization({
	warnSpecial			= "싹쓸바람/미풍/진눈깨비 폭풍 활성화",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "특수 기술 활성화!",
	warnSpecialSoon		= "10초 후 특수 기술!"
})

L:SetTimerLocalization({
	timerSpecial		= "특수 기술 쿨타임",
	timerSpecialActive	= "특수 기술 활성화"
})

L:SetOptionLocalization({
	warnSpecial			= "싹쓸바람/미풍/진눈깨비 폭풍 시전 경고 보기",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "특수 기술이 시전되면 특수 경고 보기",
	timerSpecial			= "특수 기술 쿨타임 타이머 바 보기",
	timerSpecialActive		= "특수 기술 지속시간 타이머 바 보기",
	warnSpecialSoon			= "특수 기술 10초 전에 사전 경고 보기",
	OnlyWarnforMyTarget	= "대상과 주시대상의 경고/타이머 바만 보기<br/>(나머지는 숨깁니다. 이 설정은 풀링도 포함됩니다)"
})

L:SetMiscLocalization({
	gatherstrength	= "힘을 모으기 시작합니다!"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization(155)

L:SetTimerLocalization({
	TimerFeedback 		= "역순환 (%d)"
})

L:SetOptionLocalization({
	TimerFeedback		= "$spell:87904 지속시간 타이머 바 보기"
})

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetMiscLocalization({
	EmoteSpiderlings 	= "새끼거미가 둥지에서 쏟아져나옵니다!"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "%d단계",
	WarnNewInitiate		= "수습생 (%s)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "%d단계",
	TimerHatchEggs		= "알",
	timerNextInitiate	= "수습생 (%s)"
})

L:SetOptionLocalization({
	WarnPhase			= "각 단계 전환 경고 보기",
	WarnNewInitiate		= "타오르는 발톱 수습생 등장 경고 보기",
	timerNextInitiate	= "다음 타오르는 발톱 수습생 타이머 바 보기",
	TimerPhaseChange	= "다음 단계까지 타이머 바 보기",
	TimerHatchEggs		= "다음 알 부화까지 타이머 바 보기"
})

L:SetMiscLocalization({
	YellPull		= "이제 난 새 주인님을 섬긴다. 필멸자여!",
	YellPhase2		= "이 하늘은 나의 것이다!",
	LavaWorms		= "불타는 용암 벌레가 땅에서 튀어나옵니다!",--Might use this one day if i feel it needs a warning for something. Or maybe pre warning for something else (like transition soon)
	East			= "동쪽",
	West			= "서쪽",
	Both			= "양쪽"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetTimerLocalization({
	timerStrike			= "다음 %s",
	TimerBladeNext		= "다음 칼날"
})

L:SetOptionLocalization({
	ResetShardsinThrees	= "$spell:99259 중첩 횟수를 3개(25인)/2개(10인) 마다 초기화",
	warnStrike			= "학살/지옥불 칼날 경고 보기",
	timerStrike			= "다음 학살/지옥불 칼날 타이머 바 보기",
	TimerBladeActive	= "활성화된 칼날 지속시간 타이머 바 보기",
	TimerBladeNext		= "다음 학살/지옥불 칼날 타이머 바 보기"
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetTimerLocalization({
	timerNextSpecial	= "다음 %s (%d)"
})

L:SetOptionLocalization({
	timerNextSpecial		= "다음 특수 기술 타이머 바 보기"
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnRageRagnarosSoon	= "5초 후 %s: %s",
	warnSplittingBlow		= "%s (%s)",
	warnEngulfingFlame		= "%s (%s)",
	warnEmpoweredSulf		= "5초 후 %s"
})

L:SetTimerLocalization({
	timerRageRagnaros		= "%s: %s",--Spellname on targetname
	TimerPhaseSons			= "단계 전환 끝"
})

L:SetOptionLocalization({
	warnSplittingBlow			= "$spell:98951 위치 경고 보기",
	warnEngulfingFlame			= "$spell:99171 위치 경고 보기 (일반)",
	warnEngulfingFlameHeroic	= "$spell:99171 위치 경고 보기 (영웅)",
	warnSeedsLand				= "씨앗 시전 대신 $spell:98520이 땅에 떨어지는 시간에 맞춰 경고/타이머 바 보기",
	TimerPhaseSons				= "\"화염의 피조물 단계\" 지속시간 타이머 바 보기",
	InfoHealthFrame				= "생명력을 정보 창에 표시 (생명력 <10만)",
	MeteorFrame					= "$spell:99849 대상을 정보 창에 표시",
	AggroFrame					= "$journal:2647이 나왔을 때 어그로가 없는 공대원을 정보 창에 표시"
})

L:SetMiscLocalization({
	East				= "동쪽",
	West				= "서쪽",
	Middle				= "가운데",
	North				= "근접",
	South				= "뒤쪽",
	HealthInfo			= "생명력 10만 이하",
	HasNoAggro			= "어그로 없음",
	MeteorTargets		= "유성 조심!",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "여기까지! 이제 끝내주마.",--More reliable then adds method.
	TransitionEnded2	= "설퍼라스로 숨통을 끊어 주마.",
	TransitionEnded3	= "무릎 꿇어라, 필멸자여! 끝낼 시간이다.",
	Defeat				= "조금만!... 조금만 시간이 더 있었어도...",
	Phase4				= "너무 일러..."
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "불의 땅 일반몹"
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "볼카누스"
})

L:SetTimerLocalization({
	timerStaffTransition	= "단계 전환 끝"
})

L:SetOptionLocalization({
	timerStaffTransition	= "단계 전환 타이머 바 보기"
})

L:SetMiscLocalization({
	StaffEvent			= "(%S+)|1이;가; 놀드랏실의 가지를 건드리자 격렬하게 반응합니다!",
	StaffTrees			= "불타는 나무정령이 수호정령을 돕기 위해 땅에서 일어납니다!",--Might add a spec warning for this later.
	StaffTransition		= "고통받는 수호정령을 태우는 불이 사그라졌습니다!"
})

-----------------------
--  Nexus Legendary  --
-----------------------
L = DBM:GetModLocalization("NexusLegendary")

L:SetGeneralLocalization({
	name = "티리나르"
})

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetTimerLocalization({
	KohcromCD		= "크초르모 따라하기 %s"
})

L:SetOptionLocalization({
	KohcromWarning	= "$journal:4262의 스킬 따라하기 경고 보기",
	KohcromCD		= "$journal:4262의 다음 따라할 스킬 타이머 바 보기"
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetOptionLocalization({
	ShadowYell			= "$spell:103434에 걸렸을 때 말풍선으로 알리기<br/>(영웅 난이도 전용)"
})

L:SetMiscLocalization({
	voidYell	= "굴카와스 언고브 느조스."
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozesHit	= "%s|1이;가; %s|1을;를; 흡수함"
})

L:SetTimerLocalization({
	timerOozesActive	= "핏방울 공격 가능",
	timerOozesReach		= "핏방울이 보스에 닿음"
})

L:SetOptionLocalization({
	warnOozesHit		= "어떤 핏방울이 보스에 닿았는지 알림 보기",
	timerOozesActive	= "핏방울 공격 가능 타이머 바 보기",
	timerOozesReach		= "핏방울이 요르사지까지 가는 시간 타이머 바 보기"
})

L:SetMiscLocalization({
	Black			= "|cFF424242검정|r",
	Purple			= "|cFF9932CD보라|r",
	Red				= "|cFFFF0404빨강|r",
	Green			= "|cFF088A08녹색|r",
	Blue			= "|cFF0080FF파랑|r",
	Yellow			= "|cFFFFA901노랑|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s: %d 남음",
	warnFrostTombCast		= "8초 후 %s"
})

L:SetTimerLocalization({
	TimerSpecial			= "첫번째 특수 기술"
})

L:SetOptionLocalization({
	WarnPillars				= "$journal:3919와 $journal:4069 남은 개수 알림",
	TimerSpecial			= "첫번째 특수 기술 시전 타이머 바 보기",
	SpecialCount			= "$spell:105256와 $spell:105465 초읽기 효과음 재생",
	SetBubbles				= "$spell:104451을 시전할 수 있을 때 자동으로 말풍선 숨김<br/>(전투 종료 후 원상복구)"
})

L:SetMiscLocalization({
	TombIconSet				= "얼음 무덤 징표 {rt%d} %s에 설정"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "5초 후 %s (%d)"
})

L:SetTimerLocalization({
	TimerCombatStart	= "울트락시온 활성화"
})

L:SetOptionLocalization({
	TimerCombatStart	= "울트락시온 대사 타이머 바 보기",
	ResetHoTCounter		= "황혼의 시간 횟수 재시작",
	Never				= "사용 안함",
	ResetDynamic		= "3/2회를 한세트로 재시작 (영웅/일반)",
	Reset3Always		= "항상 3회를 한세트로 재시작",
	SpecWarnHoTN		= "황혼의 시간 5초 전에 특수 경고. 횟수 재시작 기능을 사용하지 않는다면 3회 1세트 규칙 적용",
	One					= "1 (예 1 4 7)",
	Two					= "2 (예 2 5)",
	Three				= "3 (예 3 6)"
})

L:SetMiscLocalization({
	Pull				= "엄청난 무언가가 느껴진다. 조화롭지 못한 그의 혼돈이 내 정신을 어지럽히는구나!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "황혼의 정예병!"
})

L:SetTimerLocalization({
	TimerAdd			= "다음 정예병"
})

L:SetOptionLocalization({
	TimerAdd			= "다음 황혼의 정예병 등장 타이머 바 보기",
	SpecWarnElites		= "황혼의 정예병 등장 특수 경고 보기",
	SetTextures			= "1단계에서 자동으로 텍스쳐 투영 효과 비활성화<br/>(2단계가 되면 다시 활성화)"
})

L:SetMiscLocalization({
	Pull				= "전속력으로! 모든게 우리 속도에 달려 있다. 파괴자가 도망치게 둬선 안 돼.",
	SapperEmote			= "비룡이 빠르게 날아와 황혼의 폭파병을 갑판에 떨어뜨립니다!",
	GorionaRetreat		= "고통에 울부짖으며, 소용돌이치는 구름 속으로 달아납니다."
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "촉수에 잡히세요!"
})

L:SetOptionLocalization({
	SpecWarnTendril			= "회전하는 동안 $spell:105563 디버프가 없으면 특수 경고 보기",
	InfoFrame				= "$spell:105563가 없는 공대원을 정보 창에 표시",
	ShowShieldInfo			= "$spell:105479 흡수량 바 보기<br/>(보스 프레임 설정 무시)"
})

L:SetMiscLocalization({
	Pull			= "저 갑옷! 놈의 갑옷이 벗겨지는군! 갑옷을 뜯어내면 놈을 쓰러뜨릴 기회가 생길 거요!",
	NoDebuff		= "%s 없음",
	PlasmaTarget	= "이글거리는 혈장: %s",
	DRoll			= "회전하려고",
	DLevels			= "수평으로 균형을"
})

---------------------------
-- Madness of Deathwing  --
---------------------------
L= DBM:GetModLocalization(333)

L:SetMiscLocalization({
	Pull				= "넌 아무것도 못 했다. 내가 이 세상을 조각내주마."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"용의 영혼 일반몹"
})

L:SetWarningLocalization({
	DrakesLeft			= "황혼의 습격자 남은 수: %d"
})

L:SetTimerLocalization({
	timerRoleplay		= "NPC 대사"
})

L:SetOptionLocalization({
	DrakesLeft			= "황혼의 습격자 남은 수 알림 보기",
	TimerDrakes			= "황혼의 습격자의 $spell:109904 시간 타이머 바 보기"
})

L:SetMiscLocalization({
	firstRP				= "티탄을 찬양하라. 그들이 돌아왔다!",
	UltraxionTrash		= "다시 만나 반갑군, 알렉스트라자. 난 떠나 있는 동안 좀 바쁘게 지냈다.",
	UltraxionTrashEnded	= "가련한 녀석들, 이 실험은 위대한 결말을 위한 희생이었다. 알 연구의 결과물을 직접 확인해라."
})
