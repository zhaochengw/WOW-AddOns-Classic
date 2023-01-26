--localization file for Korean
local Lang = LibStub("AceLocale-3.0"):NewLocale("Attune", "koKR")
if (not Lang) then
	return;
end


-- INTERFACE
Lang["Credits"] = "애드온을 테스트하는 동안 길드 |cffffd100<Divine Heresy>|r 의 지원과 격려에 매우 감사합니다, 그리고 |cffffd100RoadBlock|r과 |cffffd100Bushido|r에게 큰 감사를 드립니다 그들의 도움을 위해!\n\n 또한 번역을 해주신 덕분에:\n  - 독어 번역: |cffffd100Sumaya @ Razorfen DE|r\n  - 노어 번역: |cffffd100Greymarch Guild @ Flamegor RU|r\n  - 스페인어 번역: |cffffd100Coyu @ Pyrewood Village EU|r\n  - 중국어 간체 번역: |cffffd100ly395842562|r 과 |cffffd100Icyblade|r\n  - 중국어 번체 번역: |cffffd100DayZ|r @ Ivus TW|r\n  - 한글 번역: |cffffd100Drix @ 로크홀라 KR|r\n\n/Hug Cixi/Gaya @ Remulos Horde 드림"
Lang["Mini"] = "작게"
Lang["Maxi"] = "크게"
Lang["Version"] = "Attune v##VERSION## by Cixi@Remulos"
Lang["Splash"] = "v##VERSION## by Cixi@Remulos. /attune 입력"
Lang["Survey"] = "조회"
Lang["Guild"] = "길드"
Lang["Party"] = "파티"
Lang["Raid"] = "공격대"
Lang["Run an attunement survey (for people with the addon)"] = "입장확인 조회 (애드온 설치자에 한해서)"
Lang["Toggle between attunements and survey results"] = "조회 입장요약과 입장확인 간 이동" 
Lang["Close"] = "닫기" 
Lang["Export"] = "내보내기"
Lang["My Data"] = "내 자료"
Lang["Last Survey"] = "마지막 조회"
Lang["Guild Data"] = "길드 내역"
Lang["All Data"] = "모든 자료"
Lang["Export your Attune data to the website"] = "웹으로 자료 내보내기"
Lang["Copy the text below, then upload it to"] = "아래 문자 복사 후 업로드"
Lang["Results"] = "입장요약"
Lang["Not in a guild"] = "길드가 없음"
Lang["Click on a header to sort the results"] = "헤더를 눌러 결과 정렬" 
Lang["Character"] = "케릭터" 
Lang["Characters"] = "케릭터들"
Lang["Last survey results"] = "마지막 조회 결과"	
Lang["All FACTION results"] = "모든 ##FACTION## 결과"
Lang["Guild members"] = "길드원" 
Lang["All results"] = "모든 결과" 
Lang["Minimum level"] = "최소레벨" 
Lang["Click to navigate to that attunement"] = "해당 입장퀘로 확인 시 클릭"
Lang["Attunes"] = "입장확인"
Lang["Guild members on this step"] = "현 단계 길드원만"
Lang["Attuned guild members"] = "입장가능 길드원"
Lang["Attuned alts"] = "입장가능 부케"
Lang["Alts on this step"] = "현 단계 부케"
Lang["Settings"] = "설정"
Lang["Survey Log"] = "조회 기록"
Lang["LeftClick"] = "좌클릭"
Lang["OpenAttune"] = " 애드온 열기"
Lang["RightClick"] = "우클릭"
Lang["OpenSettings"] = " 설정 열기"
Lang["Addon disabled"] = "애드온 비활성"
Lang["StartAutoGuildSurvey"] = "조용히 길드 자동 조회"
Lang["SendingDataTo"] = "|cffffd100##NAME##|r 자료 전송 중"
Lang["NewVersionAvailable"] = "|cffffd100new version|r 애드온 버전업이 되었으니 업데이트!"
Lang["CompletedStep"] = "완료됨 ##TYPE## |cffe4e400##STEP##|r 현 단계 |cffe4e400##NAME##|r."
Lang["AttuneComplete"] = "입장퀘 |cffe4e400##NAME##|r 완료!"
Lang["AttuneCompleteGuild"] = "##NAME## 입장퀘 완료!"
Lang["SendingSurveyWhat"] = "##WHAT## 를 조회 중"
Lang["SendingGuildSilentSurvey"] = "길드대화로 조회 중"
Lang["SendingYellSilentSurvey"] = "외침으로 조회 중"
Lang["ReceivedDataFromName"] = "|cffffd100##NAME##|r 자료 받음"
Lang["ExportingData"] = "##COUNT##개의 케릭 자료 내보내기 중"
Lang["ReceivedRequestFrom"] = "|cffffd100##FROM##|r 조회 요청받음"
Lang["Help1"] = "이 애드온은 입장퀘 진행현황을 확인하고 내보내기 함"
Lang["Help2"] = "|cfffff700/attune|r 시작하기 위해 실행"
Lang["Help3"] = "길드원의 진행현황을 확인하려면 |cfffff700survey|r 클릭하여 정보를 얻을 수 있음"
Lang["Help4"] = "애드온을 설치한 길드원에게 진행자료를 얻음"
Lang["Help5"] = "충분한 자료를 얻으면, |cfffff700export|r 클릭하여 길드진행현황에 내보내기"
Lang["Help6"] = "자료는 |cfffff700https://warcraftratings.com/attune/upload|r 업로드 가능"
Lang["Survey_DESC"] = "입장확인 조회 (애드온 설치한 사람에 한해)"
Lang["Export_DESC"] = "입장자료를 웹에 내보내기"
Lang["Toggle_DESC"] = "입장확인과 조회결과 간 토글"
--Lang["PreferredLocale_TEXT"] = "선호하는 언어"
--Lang["PreferredLocale_DESC"] = "선호하는 언어를 선택하세요. 리로드를 하셔야 적용"
--v220
Lang["My Toons"] = "내 케릭터"
Lang["No Target"] = "대상 없음"
Lang["No Response From"] = "##PLAYER## 회신없음"
Lang["Sync Request From"] = "새 동기화 요청왔음:\n\n##PLAYER##"
Lang["Could be slow"] = "자료량에 따라, 진행은 느려질 수 있음"
Lang["Accept"] = "수락"
Lang["Reject"] = "거부"
Lang["Busy right now"] = "##PLAYER## 지금 바쁨, 추후에 다시"
Lang["Sending Sync Request"] = "##PLAYER##에게 동기화 요청"
Lang["Request accepted, sending data to "] = "요청 수락, ##PLAYER##에게 자료 전송"
Lang["Received request from"] = "##PLAYER##에게 요청 받음"
Lang["Request rejected"] = "요청 거부"
Lang["Sync over"] = "동기화 시간 ##DURATION##"
Lang["Syncing Attune data with"] = "##PLAYER##와 동기화 중"
Lang["Cannot sync while another sync is in progress"] = "동기화 중 새 동기화 불가"
Lang["Sync with target"] = "대상과 동기화"
Lang["Show Profiles"] = "프로필 조회 및 내 프로필 설정"
Lang["Show Progress"] = "입장요약으로 돌아가기"
Lang["Status"] = "현황"
Lang["Role"] = "역할"
Lang["Last Surveyed"] = "마지막 조회"
Lang['Seconds ago'] = "##DURATION## 전에"
Lang["Main"] = "본케"
Lang["Alt"] = "부케"
Lang["Tank"] = "탱커"
Lang["Healer"] = "힐러"
Lang["Melee DPS"] = "근딜"
Lang["Ranged DPS"] = "원딜"
Lang["Bank"] = "은행"
Lang["DelAlts_TEXT"] = "부케 모두 삭제"
Lang["DelAlts_DESC"] = "부케 표시된 케릭들 모두 삭제"
Lang["DelAlts_CONF"] = "부케 모두 삭제할까요?"
Lang["DelAlts_DONE"] = "부케 모두 삭제됨"
Lang["DelUnspecified_TEXT"] = "불분명한 케릭삭제"
Lang["DelUnspecified_DESC"] = "본케/부케 표시가 없는 케릭을 모두 삭제"
Lang["DelUnspecified_CONF"] = "본케/부케 표시가 없는 케릭을 모두 삭제할까요?"
Lang["DelUnspecified_DONE"] = "불분명한 본케/부게 모두 삭제됨"
--v221
Lang["Open Raid Planner"] = "공대 계획표 확인"
Lang["Unspecified"] = "불분명한"
Lang["Empty"] = "삭제하기"
Lang["Guildies only"] = "길드원만 표시"
Lang["Show Mains"] = "본케 보이기"
Lang["Show Unspecified"] = "불분명한 케릭 표시"
Lang["Show Alts"] = "부케 표시"
Lang["Show Unattuned"] = "입장불가 케릭 표시"
Lang["Raid spots"] = "##SIZE##인 공대"
Lang["Group Number"] = "파티##NUMBER##"
Lang["Move to next group"] = "다음 파티로 이동"
Lang["Remove from raid"] = "공대에서 추방"
Lang["Select a raid and click on players to add them in"] = "계획할 공격대 던전을 선택하고 유저를 선택하여 공대에 삽입하세요"
--v224
Lang["Enter a new name for this raid group"] = "이 공대에 새 이름을 입력하세요"
Lang["Save"] = "저장"
--v226
Lang["Invite"] = "초대"
Lang["Send raid invites to all listed players?"] = "나열된 모든 플레이어에게 레이드 초대를 보내시겠습니까?"
Lang["External link"] = "온라인 데이터베이스에 연결"
--v243
Lang["Ogrila"] = "오그릴라"
Lang["Ogri'la Quest Hub"] = "오그릴라 퀘스트 허브"
Lang["Ogrila_Desc"] = "오그릴라의 개화된 오우거들은 칼날 산맥 서쪽에 자리잡고 있습니다. "
Lang["DelInactive_TEXT"] = "비활성 삭제"
Lang["DelInactive_DESC"] = "비활성으로 표시된 플레이어에 대한 모든 정보 삭제"
Lang["DelInactive_CONF"] = "모든 비활성을 삭제하시겠습니까?"
Lang["DelInactive_DONE"] = "모든 비활성 삭제됨"
Lang["RAIDS"] = "공격대"
Lang["KEYS"] = "열쇠"
Lang["MISC"] = "기타"
Lang["HEROICS"] = "영웅"
--v244
Lang["Ally of the Netherwing"] = "황천날개 용군단의 동맹"
Lang["Netherwing_Desc"] = "황천의 용군단은 아웃랜드에 위치한 드래곤의 진영입니다."
--v247
Lang["Tirisfal Glades"] = "티리스팔 숲"
Lang["Scholomance"] = "스칼로맨스"
--v248
Lang["Target"] = "대상"
Lang["SendingSurveyTo"] = "##TO## 에게 설문조사 보내기"
--WOTLK GENERIC
Lang["QUEST HUBS"] = "연퀘 목록"
Lang["PHASES"] = "위상"
Lang["Angrathar the Wrathgate"] = "분노의 관문 앙그라타르"
Lang["Unlock the Wrathgate events and the Battle for the Undercity"] = "분노의 관문과 언더시티 전투 선행퀘스트"
Lang["Sons of Hodir"] = "호디르의 후예"
Lang["Unlock the Sons of Hodir quest hub"] = "호디르의 후예 선행퀘스트"
Lang["Knights of the Ebon Blade"] = "칠흑의 기사단"
Lang["Unlock the Shadow Vault quest hub"] = "어둠의 무기고 선행퀘스트"
Lang["Goblin"] = "고블린"
Lang["Death Knight"] = "죽음의 기사"
Lang["Eye"] = "눈"
Lang["Abomination"] = "누더기골렘"
Lang["Banshee"] = "벤시"
Lang["Geist"] = "외눈박이"
Lang["Icecrown"] = "얼음왕관"
Lang["Dragonblight"] = "용의 안식처"
Lang["Borean Tundra"] = "북풍의 땅"
Lang["The Storm Peaks"] = "폭풍우 봉우리"
Lang["The Eye of Eternity"] = "영원의 눈"
Lang["Sapphiron"] = "샤피론"
Lang["One_Desc"] = "공대원 최소 1명 열쇠 필요"


-- OPTIONS
Lang["MinimapButton_TEXT"] = "미니맵 버튼 활성화"
Lang["MinimapButton_DESC"] = "미니맵에 Attune애드온 버튼을 활성화합니다."
Lang["AutoSurvey_TEXT"] = "로그인 시 자동 길드조회"
Lang["AutoSurvey_DESC"] = "로그인하면 항상 자동으로 길드를 조회합니다."
Lang["ShowSurveyed_TEXT"] = "나에게 조회 시 알림"
Lang["ShowSurveyed_DESC"] =  "챗창에 나에게 조회 요청(또는 회신)이 오면 알림"
Lang["ShowResponses_TEXT"] = "나의 회신 요청"
Lang["ShowResponses_DESC"] = "챗창에 각각의 회신을 표시함"
Lang["ShowSetMessages_TEXT"] = "단계별로 완료 발송"
Lang["ShowSetMessages_DESC"] = "입장퀘스트를 단계별로 완료할 때마다 챗창에 표시"
Lang["AnnounceToGuild_TEXT"] = "입장퀘 전체 완료 발송"
Lang["AnnounceToGuild_DESC"] = "길드대화창에 입장퀘스트를 모두 완료하면 알림"
Lang["ShowOther_TEXT"] = "다른 채팅 보기"
Lang["ShowOther_DESC"] = "모든 일반 채팅을 보기 (도움말, 조회 보내기, 업데이트 등등)."
Lang["ShowGuildies_TEXT"] = "진행단계마다 현단계 길드원 표시                                                      (최대 인원 설정)"  --this has a gap for the editbox
Lang["ShowGuildies_DESC"] = "현재 접속한 케릭터와 같은 단계를 진행하고 있는 길드원을 표시\n필요한 경우, 길드원의 표시 인원수를 제한"
Lang["ShowAltsInstead_TEXT"] = "길드원 대신 내 부케만 표시"
Lang["ShowAltsInstead_DESC"] = "현재 접속한 케릭터와 같은 단계인 길드원 대시 나의 부케들만 표시"
Lang["ClearAll_TEXT"] = "모든 결과 삭제"
Lang["ClearAll_DESC"] = "모든 타인 기록 삭제"
Lang["ClearAll_CONF"] = "정말로 삭제할까요?"
Lang["ClearAll_DONE"] = "모든 결과 삭제함"
Lang["DelNonGuildies_TEXT"] = "길드원 아닌 사람 삭제"
Lang["DelNonGuildies_DESC"] = "길드원이 아닌 사람의 정보를 모두 삭제"
Lang["DelNonGuildies_CONF"] = "정말로 삭제할까요?"
Lang["DelNonGuildies_DONE"] = "길드원이 아닌 사람의 정보 모두 삭제함"
Lang["DelUnder60_TEXT"] = "60랩미만 케릭 삭제"
Lang["DelUnder60_DESC"] = "60랩미만 케릭들의 자료를 삭제"
Lang["DelUnder60_CONF"] = "60랩미만 정말 삭제할까요?"
Lang["DelUnder60_DONE"] = "60랩미만 케릭들 삭제함"
Lang["DelUnder70_TEXT"] = "70랩미만 케릭 삭제"
Lang["DelUnder70_DESC"] = "70랩미만 케릭들의 자료를 삭제"
Lang["DelUnder70_CONF"] = "70랩미만 정말 삭제할까요?"
Lang["DelUnder70_DONE"] = "70랩미만 케릭들 삭제함"
--302
Lang["AnnounceAchieve_TEXT"] = "길드 채팅에서 업적 발표                                                                          한계점:"
Lang["AnnounceAchieve_DESC"] = "업적 달성 시 길드 메시지를 보냅니다."
Lang["AchieveCompleteGuild"] = "##LINK## 완료!" 
Lang["AchieveCompletePoints"] = "(##POINTS## 총 포인트)" 
Lang["AchieveSurvey"] = "|cFFFFD100Attune|r이 길드 채팅에서 |cFFFFD100##WHO##|r의 업적을 발표하시겠습니까?"
--306
Lang["showDeprecatedAttunes_TEXT"] = "더 이상 사용되지 않는 조정 표시"
Lang["showDeprecatedAttunes_DESC"] = "목록에서 오래된 조정(오닉시아 40, 낙스라마스 40)을 계속 볼 수 있도록 합니다."			


-- TREEVIEW
Lang["World of Warcraft"] = "시대서버"
Lang["The Burning Crusade"] = "불타는 성전"
Lang["Molten Core"] = "화산 심장부"
Lang["Onyxia's Lair"] = "오닉시아의 둥지"
Lang["Blackwing Lair"] = "검은날개 둥지"
Lang["Naxxramas"] = "낙스라마스"
Lang["Scepter of the Shifting Sands"] = "흐르는 모래의 홀"
Lang["Shadow Labyrinth"] = "어둠의 미궁"
Lang["The Shattered Halls"] = "으스러진 손의 전당"
Lang["The Arcatraz"] = "알카트라즈"
Lang["The Black Morass"] = "검은늪"
Lang["Thrallmar Heroics"] = "스랄마 영웅"
Lang["Honor Hold Heroics"] = "명예의 요새 영웅"
Lang["Cenarion Expedition Heroics"] = "세나리온 원정대 영웅"
Lang["Lower City Heroics"] = "고난의 거리 영웅"
Lang["Sha'tar Heroics"] = "샤티르 영웅"
Lang["Keepers of Time Heroics"] = "시간의 수호자 영웅"
Lang["Nightbane"] = "파멸의 어둠"
Lang["Karazhan"] = "카라잔"
Lang["Serpentshrine Cavern"] = "불뱀 제단"
Lang["The Eye"] = "폭풍우 요새"
Lang["Mount Hyjal"] = "하이잘 산"
Lang["Black Temple"] = "검은 사원"
Lang["MC_Desc"] = "공대원 모두 입장퀘가 완료되어야 지름길로 입장이 가능합니다. 나락을 직접 통과하여 오지 않는한.." 
Lang["Ony_Desc"] = "공대원 모두 비룡불꽃 아뮬렛을 소지하고 있어야 둥지 입장이 가능합니다."
Lang["BWL_Desc"] = "공대원 모두 입장퀘가 완료되어야 지름길로 입장이 가능합니다. 첨탑을 직접 통과하여 오지 않는한.."
Lang["All_Desc"] = "공대원 모두 입장퀘가 완료되어야 공격대 던전 입장이 가능합니다."
Lang["AQ_Desc"] = "서버 전체에서 1명만 홀 퀘스트를 완료하면 아무나 안퀴라즈 문을 통과할 수 있습니다."
Lang["OnlyOne_Desc"] = "파티원 중 1명만 열쇠가 있으면 인던 진입이 가능합니다. 도적은 자물쇠 따기 숙련도가 350 이상이면 문 열기가 가능합니다."
Lang["Heroic_Desc"] = "파티원 모두는 해당 영웅던전 입장열쇠가 있어야 입장이 가능합니다."
Lang["NB_Desc"] = "공대원 중 최소 1명만 어둠의 단지가 있으면 파멸의 어둠을 소환할 수 있습니다."
Lang["BT_Desc"] = "공대원 모두 카라보르의 메달을 소지하고 있어야 사원 입장이 가능합니다."
Lang["BM_Desc"] = "파티원 모두 입장퀘스트를 모두 완료하여야만 던젼에 들어갈 수 있습니다."
--v250
Lang["Aqual Quintessence"] = "물의 정기"
Lang["MC2_Desc"] = "청지기 이그 퀴버스를 소환할 때 사용합니다. 화산 심장부의 두 보스를 제외한 모든 보스는 바닥에 룬을 가지고 있습니다." 
--v254
Lang["Magisters' Terrace Heroic"] = "마법학자의 정원 영웅"
Lang["Magisters' Terrace"] = "마법학자의 정원"
Lang["MgT_Desc"] = "영웅 모드에서 던전을 실행하려면 모든 플레이어가 일반 모드에서 던전을 완료해야 합니다."
Lang["Isle of Quel'Danas"] = "쿠엘다나스 섬"
Lang["Wrath of the Lich King"] = "리치 왕의 분노"


-- GENERIC
Lang["Reach level"] = "최소 레벨"
Lang["Attuned"] = "입장가능"
Lang["Not attuned"] = "입장불가"
Lang["AttuneColors"] = "파랑: 완료\n빨강: 미완"
Lang["Minimum Level"] = "퀘스트를 시작하기 위한 최소레벨"
Lang["NPC Not Found"] = "엔피씨 정보 없음"
Lang["Level"] = "레벨"
Lang["Exalted with"] = "확고"
Lang["Revered with"] = "매우 우호"
Lang["Honored with"] = "우호"
Lang["Friendly with"] = "약간 우호"
Lang["Neutral with"] = "중립"
Lang["Quest"] = "퀘스트"
Lang["Pick Up"] = "받기"
Lang["Turn In"] = "반납"
Lang["Kill"] = "처치"
Lang["Interact"] = "상호작용"
Lang["Item"] = "아이템"
Lang["Required level"] = "필요 레벨"
Lang["Requires level"] = "필요한 레벨"
Lang["Attunement or key"] = "입장퀘 또는 열쇠"
Lang["Reputation"] = "평판"
Lang["in"] = " " -- Cixi leave it blank; English (I like you) and Korean (I you like) have different grammar for [subject object predicate]
Lang["Unknown Reputation"] = "모르는 평판"
Lang["Current progress"] = "현단계"
Lang["Completion"] = "완료"
Lang["Quest information not found"] = "퀘 정보 없음"
Lang["Information not found"] = "정보 없음"
Lang["Solo quest"] = "솔로 퀘스트"
Lang["Party quest"] = "파티 퀘스트 (##NB##인)"
Lang["Raid quest"] = "공격대 퀘스트 (##NB##인)"
Lang["HEROIC"] = "영웅"
Lang["Elite"] = "정예"
Lang["Boss"] = "보스"
Lang["Rare Elite"] = "희귀 정예"
Lang["Dragonkin"] = "용족"
Lang["Troll"] = "트롤"
Lang["Ogre"] = "오우거"
Lang["Orc"] = "오크"
Lang["Half-Orc"] = "하프오크"
Lang["Dragonkin (in Blood Elf form)"] = "용족 (블러드엘프 모습)"
Lang["Human"] = "인간"
Lang["Dwarf"] = "드워프"
Lang["Mechanical"] = "기계"
Lang["Arakkoa"] = "아라코아"
Lang["Dragonkin (in Humanoid form)"] = "용족 (인간 모습)"
Lang["Ethereal"] = "에테리얼"
Lang["Blood Elf"] = "블러드엘프"
Lang["Elemental"] = "정령"
Lang["Shiny thingy"] = "반짝이는 것"
Lang["Naga"] = "나가"
Lang["Demon"] = "악마"
Lang["Gronn"] = "그론"
Lang["Undead (in Dragon form)"] = "언데드 (용족 모습)"
Lang["Tauren"] = "타우렌"
Lang["Qiraji"] = "퀴라지"
Lang["Gnome"] = "노움"
Lang["Broken"] = "부서진"
Lang["Draenei"] = "드레나이"
Lang["Undead"] = "언데드"
Lang["Gorilla"] = "고릴라"
Lang["Shark"] = "상어"
Lang["Chimaera"] = "키메라"
Lang["Wisp"] = "위습"
Lang["Night-Elf"] = "나이트엘프"


-- REP
Lang["Argent Dawn"] = "은빛여명회"
Lang["Brood of Nozdormu"] = "노즈도르무 혈족"
Lang["Thrallmar"] = "스랄마"
Lang["Honor Hold"] = "명예의 요새"
Lang["Cenarion Expedition"] = "세나리온 원정대"
Lang["Lower City"] = "고난의 거리"
Lang["The Sha'tar"] = "샤타르"
Lang["Keepers of Time"] = "시간의 수호자"
Lang["The Violet Eye"] = "보랏빛 눈의 감시자"
Lang["The Aldor"] = "알도르 사제회"
Lang["The Scryers"] = "점술가 길드"


-- LOCATIONS
Lang["Blackrock Mountain"] = "검은바위 산"
Lang["Blackrock Depths"] = "검은바위 나락"
Lang["Badlands"] = "황야의 땅"
Lang["Lower Blackrock Spire"] = "검은바위 첨탑 하층"
Lang["Upper Blackrock Spire"] = "검은바위 첨탑 상층"
Lang["Orgrimmar"] = "오그리마"
Lang["Western Plaguelands"] = "서부 역병지대"
Lang["Desolace"] = "잊혀진 땅"
Lang["Dustwallow Marsh"] = "먼지 진흙습지대"
Lang["Tanaris"] = "타나리스"
Lang["Winterspring"] = "여명의 설원"
Lang["Swamp of Sorrows"] = "슬픔의 늪"
Lang["Wetlands"] = "저습지"
Lang["Burning Steppes"] = "불타는 평원"
Lang["Redridge Mountains"] = "붉은마루 산맥"
Lang["Stormwind City"] = "스톰윈드"
Lang["Eastern Plaguelands"] = "동부 역병지대"
Lang["Silithus"] = "실리더스"
Lang["The Temple of Atal'Hakkar"] = "아탈학카르 신전"
Lang["Teldrassil"] = "텔드랏실"
Lang["Moonglade"] = "달의 숲"
Lang["Hinterlands"] = "동부 내륙지"
Lang["Ashenvale"] = "잿빛골짜기"
Lang["Feralas"] = "페랄라스"
Lang["Duskwood"] = "그늘숲"
Lang["Azshara"] = "아즈샤라"
Lang["Blasted Lands"] = "저주받은 땅"
Lang["Undercity"] = "언더시티"
Lang["Silverpine Forest"] = "은빛소나무 숲"
Lang["Shadowmoon Valley"] = "어둠달 골짜기"
Lang["Hellfire Peninsula"] = "지옥불 반도"
Lang["Sethekk Halls"] = "세데크 전당"
Lang["Caverns Of Time"] = "시간의 동굴"
Lang["Netherstorm"] = "황천의 폭풍"
Lang["Shattrath City"] = "샤트라스"
Lang["The Mechanaar"] = "메카나르"
Lang["The Botanica"] = "신록의 정원"
Lang["Zangarmarsh"] = "장가르 습지대"
Lang["Terokkar Forest"] = "테로카르 숲"
Lang["Deadwind Pass"] = "죽음의 고개"
Lang["Alterac Mountains"] = "알터렉 산맥"
Lang["The Steamvault"] = "증기 저장고"
Lang["Slave Pens"] = "강제 노역소"
Lang["Gruul's Lair"] = "그룰의 둥지"
Lang["Magtheridon's Lair"] = "마그테리돈의 둥지"
Lang["Zul'Aman"] = "줄아만"
Lang["Sunwell Plateau"] = "태양샘 고원"



-- ITEMS
Lang["Drakkisath's Brand"] = "드라키사스의 낙인"
Lang["Crystalline Tear"] = "눈물의 결정"
Lang["I_18412"] = "핵 조각"			-- https://www.thegeekcrusade-serveur.com/db/?item=18412
Lang["I_12562"] = "중요한 검은바위 문서"			-- https://www.thegeekcrusade-serveur.com/db/?item=12562
Lang["I_16786"] = "검은 용혈족의 눈동자"			-- https://www.thegeekcrusade-serveur.com/db/?item=16786
Lang["I_11446"] = "꼬깃꼬깃한 쪽지"			-- https://www.thegeekcrusade-serveur.com/db/?item=11446
Lang["I_11465"] = "윈저의 잃어버린 첫번째 단서"			-- https://www.thegeekcrusade-serveur.com/db/?item=11465
Lang["I_11464"] = "윈저의 잃어버린 두번째 단서"			-- https://www.thegeekcrusade-serveur.com/db/?item=11464
Lang["I_18987"] = "블랙핸드의 명령서"			-- https://www.thegeekcrusade-serveur.com/db/?item=18987
Lang["I_20383"] = "용기대장 레쉬레이어의 머리"			-- https://www.thegeekcrusade-serveur.com/db/?item=20383
Lang["I_21138"] = "붉은색 홀 파편"			-- https://www.thegeekcrusade-serveur.com/db/?item=21138
Lang["I_21146"] = "오염된 악몽의 조각"			-- https://www.thegeekcrusade-serveur.com/db/?item=21146
Lang["I_21147"] = "오염된 악몽의 조각"			-- https://www.thegeekcrusade-serveur.com/db/?item=21147
Lang["I_21148"] = "오염된 악몽의 조각"			-- https://www.thegeekcrusade-serveur.com/db/?item=21148
Lang["I_21149"] = "오염된 악몽의 조각"			-- https://www.thegeekcrusade-serveur.com/db/?item=21149
Lang["I_21139"] = "녹색 홀 파편"			-- https://www.thegeekcrusade-serveur.com/db/?item=21139
Lang["I_21103"] = "왕초보를 위한 용언 완전정복 - 제 1 장"			-- https://www.thegeekcrusade-serveur.com/db/?item=21103
Lang["I_21104"] = "왕초보를 위한 용언 완전정복 - 제 2 장"			-- https://www.thegeekcrusade-serveur.com/db/?item=21104
Lang["I_21105"] = "왕초보를 위한 용언 완전정복 - 제 3 장"			-- https://www.thegeekcrusade-serveur.com/db/?item=21105
Lang["I_21106"] = "왕초보를 위한 용언 완전정복 - 제 4 장"			-- https://www.thegeekcrusade-serveur.com/db/?item=21106
Lang["I_21107"] = "왕초보를 위한 용언 완전정복 - 제 5 장"			-- https://www.thegeekcrusade-serveur.com/db/?item=21107
Lang["I_21108"] = "왕초보를 위한 용언 완전정복 - 제 6 장"			-- https://www.thegeekcrusade-serveur.com/db/?item=21108
Lang["I_21109"] = "왕초보를 위한 용언 완전정복 - 제 7 장"			-- https://www.thegeekcrusade-serveur.com/db/?item=21109
Lang["I_21110"] = "왕초보를 위한 용언 완전정복 - 제 8 장"			-- https://www.thegeekcrusade-serveur.com/db/?item=21110
Lang["I_21111"] = "왕초보를 위한 용언 완전정복: 제 2 권"			-- https://www.thegeekcrusade-serveur.com/db/?item=21111
Lang["I_21027"] = "라그메아란의 시체"			-- https://www.thegeekcrusade-serveur.com/db/?item=21027
Lang["I_21024"] = "키메로크 안심"			-- https://www.thegeekcrusade-serveur.com/db/?item=21024
Lang["I_20951"] = "나라인의 수정점 고글"			-- https://www.thegeekcrusade-serveur.com/db/?item=20951
Lang["I_21137"] = "파란색 홀 파편"			-- https://www.thegeekcrusade-serveur.com/db/?item=21137
Lang["I_21175"] = "흐르는 모래의 홀"			-- https://www.thegeekcrusade-serveur.com/db/?item=21175
Lang["I_31241"] = "준비된 열쇠 거푸집"			-- https://www.thegeekcrusade-serveur.com/db/?item=31241
Lang["I_31239"] = "준비된 열쇠 거푸집"			-- https://www.thegeekcrusade-serveur.com/db/?item=31239
Lang["I_27991"] = "어둠의 미궁 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=27991
Lang["I_31086"] = "알카트라즈 열쇠의 아랫조각"			-- https://www.thegeekcrusade-serveur.com/db/?item=31086
Lang["I_31085"] = "알카트라즈 열쇠의 윗조각"			-- https://www.thegeekcrusade-serveur.com/db/?item=31085
Lang["I_31084"] = "알카트라즈 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=31084
Lang["I_30637"] = "불꽃으로 버려낸 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30637
Lang["I_30622"] = "불꽃으로 버려낸 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30622
Lang["I_30623"] = "저수지 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30623
Lang["I_30633"] = "아카나이 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30633
Lang["I_30634"] = "초공간에서 버려낸 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30634
Lang["I_30635"] = "시간의 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30635
Lang["I_185686"] = "불꽃으로 버려낸 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30637
Lang["I_185687"] = "불꽃으로 버려낸 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30622
Lang["I_185690"] = "저수지 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30623
Lang["I_185691"] = "아카나이 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30633
Lang["I_185692"] = "초공간에서 버려낸 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30634
Lang["I_185693"] = "시간의 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=30635
Lang["I_24514"] = "첫번째 열쇠 조각"			-- https://www.thegeekcrusade-serveur.com/db/?item=24514
Lang["I_24487"] = "두번째 열쇠 조각"			-- https://www.thegeekcrusade-serveur.com/db/?item=24487
Lang["I_24488"] = "세번째 열쇠 조각"			-- https://www.thegeekcrusade-serveur.com/db/?item=24488
Lang["I_24490"] = "주인의 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=24490
Lang["I_23933"] = "메디브의 일지"			-- https://www.thegeekcrusade-serveur.com/db/?item=23933
Lang["I_25462"] = "어둠의 고서"			-- https://www.thegeekcrusade-serveur.com/db/?item=25462
Lang["I_25461"] = "잊혀진 이름의 고서"			-- https://www.thegeekcrusade-serveur.com/db/?item=25461
Lang["I_24140"] = "어둠의 단지"			-- https://www.thegeekcrusade-serveur.com/db/?item=24140
Lang["I_31750"] = "땅의 인장"			-- https://www.thegeekcrusade-serveur.com/db/?item=31750
Lang["I_31751"] = "불의 인장"			-- https://www.thegeekcrusade-serveur.com/db/?item=31751
Lang["I_31716"] = "사용되지 않은 집행자의 도끼"			-- https://www.thegeekcrusade-serveur.com/db/?item=31716
Lang["I_31721"] = "칼리스레쉬의 삼지창"			-- https://www.thegeekcrusade-serveur.com/db/?item=31721
Lang["I_31722"] = "울림의 정수"			-- https://www.thegeekcrusade-serveur.com/db/?item=31722
Lang["I_31704"] = "폭풍우 열쇠"			-- https://www.thegeekcrusade-serveur.com/db/?item=31704
Lang["I_29905"] = "캘타스의 유리병 잔여물"			-- https://www.thegeekcrusade-serveur.com/db/?item=29905
Lang["I_29906"] = "바쉬르의 유려빙 잔여물"			-- https://www.thegeekcrusade-serveur.com/db/?item=29906
Lang["I_31307"] = "격노의 심장"			-- https://www.thegeekcrusade-serveur.com/db/?item=31307
Lang["I_32649"] = "카라보르의 메달"			-- https://www.thegeekcrusade-serveur.com/db/?item=32649
--v247
Lang["Shrine of Thaurissan"] = "타우릿산의 신전"
Lang["I_14610"] = "아라즈의 스카라베"
--v250
Lang["I_17332"] = "샤즈라의 손"
Lang["I_17329"] = "루시프론의 손"
Lang["I_17331"] = "게헨나스의 손"
Lang["I_17330"] = "설퍼론의 손"
Lang["I_17333"] = "물의 정기"
--WOTLK ITEMS
Lang["I_41556"] = "잿가루 덮인 금속"
Lang["I_44569"] = "집중의 눈동자 열쇠"
Lang["I_44582"] = "집중의 눈동자 열쇠"
Lang["I_44577"] = "집중의 눈동자 영웅 열쇠"
Lang["I_44581"] = "집중의 눈동자 영웅 열쇠"

Lang["I_"] = ""


-- QUESTS - Classic
Lang["Q1_7848"] = "심장부와의 조화"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=7848
Lang["Q2_7848"] = "검은바위 나락의 화산 심장부 입구에 있는 차원의 문으로 가서 핵 조각을 하나 찾아야 합니다. 핵 조각을 가지고 검은바위 산에 있는 로소스 리프트웨이커에게로 돌아가십시오"
Lang["Q1_4903"] = "장군의 명령"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4903
Lang["Q2_4903"] = "대군주 오모크와 대장군 부네, 대군주 웜타라크를 처단해야 합니다. 검은바위의 중요한 문서들을 확보해야 합니다. 임무를 완수하는 대로 카르가스의 장군 고어투스에게로 돌아가야 합니다."
Lang["Q1_4941"] = "아이트리그의 지혜"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4941
Lang["Q2_4941"] = "오그리마의 스랄의 요새에 있는 아이트리그와 대화해야 합니다. 아이트리그의 얘기를 듣고 난 후에는 대족장 스랄과 상의해야 합니다."
Lang["Q1_4974"] = "호드를 위하여!"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4974
Lang["Q2_4974"] = "검은바위 첨탑으로 가서 대족장 렌드 블랙핸드를 처치하십시오. 그 증거로 그의 머리카락을 가지고 오그리마로 돌아와야 합니다."
Lang["Q1_6566"] = "바람이 전해 온 소식"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6566
Lang["Q2_6566"] = "스랄의 이야기를 들어야 합니다."
Lang["Q1_6567"] = "호드의 용사"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6567
Lang["Q2_6567"] = "렉사르를 찾아야 합니다. 그의 행방은 대족장이 설명해 주었습니다. 돌발톱 산맥과 페랄라스 사이에 있는 잊혀진 땅의 길에서 찾아 보십시오."
Lang["Q1_6568"] = "렉사르의 유언"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6568
Lang["Q2_6568"] = "서부 역병지대에 있는 노파 미란다에게 렉사르의 유서를 전달해야 합니다."
Lang["Q1_6569"] = "눈동자의 환영"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6569
Lang["Q2_6569"] = "검은바위 첨탑으로 가서 검은 용혈족의 눈동자 20개를 모아서 노파 미란다에게 돌아가야 합니다."
Lang["Q1_6570"] = "엠버스트라이프"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6570
Lang["Q2_6570"] = "먼지진흙 습지대에 있는 용의 둥지로 가서 엠버스트라이프의 굴을 찾아야 합니다. 안으로 들어가서 용족 파멸의 아뮬렛을 착용하고 엠버스트라이프와 대화해야 합니다."
Lang["Q1_6584"] = "해골 시험 - 크로날리스"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6584
Lang["Q2_6584"] = "노즈도르무의 자손인 크로날리스가 타나리스 사막에 있는 시간의 동굴을 지키고 있습니다. 그를 처치한 후 그의 해골을 엠버스트라이프에게 가져가야 합니다."
Lang["Q1_6582"] = "해골 시험 - 스크라이어"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6582
Lang["Q2_6582"] = "여명의 설원에서 찾을 수 있는 푸른용군단의 용사 스크라이어를 찾아 처치해야 합니다. 그의 시체에서 해골을 수습해서 엠버스트라이프에게 돌아가야 합니다."
Lang["Q1_6583"] = "해골 시험 - 솜누스"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6583
Lang["Q2_6583"] = "녹색용군단의 우두머리 솜누스를 처치한 후 그의 해골을 수습해서 엠버스트라이프에게 돌아가야 합니다."
Lang["Q1_6585"] = "해골 시험 - 악트로스"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6585
Lang["Q2_6585"] = "그림 바톨로 가서 붉은용군단의 우두머리 악트로즈를 찾아 그를 처치한 다음 그의 해골을 수습하여 엠버스트라이프에게 돌아가야 합니다."
Lang["Q1_6601"] = "진급"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6601
Lang["Q2_6601"] = "이제 가면놀이는 끝난 것 같습니다. 노파 미란다가 만든 용족 파멸의 아뮬렛이 검은바위 첨탐 안에서 원래 구실을 하지 않는 것을 알고 있습니다. 아마도 렉사르를 찾아가 곤경에 처한 상황을 설명하는 것이 좋겠습니다. 렉사르에게 흐릿한 비룡불꽃 아뮬렛을 보여주면 아마도 필요한 게 무엇인지 알 수 있을 겁니다."
Lang["Q1_6602"] = "검은용 용사의 피"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6602
Lang["Q2_6602"] = "검은바위 첨탑으로 가서 사령관 드라키사스를 처치하고 사령관의 피를 모아 렉사르에게 가져가야 합니다."
Lang["Q1_4182"] = "용혈족의 위협"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4182
Lang["Q2_4182"] = "검은 새끼용 15마리, 검은용혈족 10마리, 검은고룡족 4마리와 검은 비룡 1마리를 처치한 후, 헬렌디스 리버혼에게 돌아가야 합니다."
Lang["Q1_4183"] = "진정한 지도자"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4183
Lang["Q2_4183"] = "레이크샤이어로 가서 집정관 솔로몬에게 헬렌디스 리버혼의 편지를 전달해야 합니다."
Lang["Q1_4184"] = "진정한 지도자"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4184
Lang["Q2_4184"] = "스톰윈드로 가서 대영주 볼바르 폴드라곤에게 볼바르에게 보내는 솔로몬의 탄원서를 전해주어야 합니다."
Lang["Q1_4185"] = "진정한 지도자"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4185
Lang["Q2_4185"] = "여군주 카트라나 프레스톨과 얘기를 나눈 후, 대영주 볼바르 폴드라곤과 대화하십시오."
Lang["Q1_4186"] = "진정한 지도자"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4186
Lang["Q2_4186"] = "레이크샤이어에 있는 집정관 솔로몬에게 볼바르의 명령서를 가져가야 합니다."
Lang["Q1_4223"] = "진정한 지도자"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4223
Lang["Q2_4223"] = "불타는 평원에 있는 치안대장 맥스웰과 대화하십시오."
Lang["Q1_4224"] = "진정한 지도자"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4224
Lang["Q2_4224"] = "털보 존을 만나 치안대장 윈저의 행방에 대해서 알아낸 다음 치안대장 맥스웰에게 돌아가 보고해야 합니다.\n\n치안대장 맥스웰은 북쪽에 있는 동굴에서 털보 존을 찾아보라고 했습니다."
Lang["Q1_4241"] = "치안대장 윈저"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4241
Lang["Q2_4241"] = "북서쪽에 있는 검은바위 산으로 가서 검은바위 나락으로 들어가십시오. 치안대장 윈저에게 무슨 일이 있었는지 알아내야 합니다.\n\n털보 존은 윈저가 감옥으로 끌려갔다고 했습니다."
Lang["Q1_4242"] = "실망"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4242
Lang["Q2_4242"] = "치안대장 맥스웰에게 나쁜 소식을 전해줘야 합니다."
Lang["Q1_4264"] = "꼬깃꼬깃한 쪽지"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4264
Lang["Q2_4264"] = "방금 우연히 치안대장 윈저가 보고 싶어할 듯한 물건을 찾은 것 같습니다. 어쩌면 희망이 있을지도 모릅니다."
Lang["Q1_4282"] = "잔존하는 희망"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4282
Lang["Q2_4282"] = "치안대장 윈저의 잃어버린 단서를 가져 와야 합니다.\n\n치안대장 윈저는 골렘 군주 아젤마크와 사령관 앵거포지가 이 정보를 가지고 있을 것이라 생각합니다."
Lang["Q1_4322"] = "탈옥"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=4322
Lang["Q2_4322"] = "치안대장 윈저가 자신의 장비를 되찾고 갇힌 동료들을 풀어 주는 것을 도와야 합니다. 성공하면 치안대장 맥스웰에게 돌아가십시오."
Lang["Q1_6402"] = "스톰윈드 회합"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6402
Lang["Q2_6402"] = "스톰윈드 도시 성문으로 가서, 수습기사 로우와 대화하면 그가 당신의 도착을 치안대장 윈저에게 알릴 것입니다."
Lang["Q1_6403"] = "대단한 가장무도회"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6403
Lang["Q2_6403"] = "레지널드 윈저를 따라 스톰윈드를 통과해 왕궁으로 가야합니다. 윈저를 보호하십시오!"
Lang["Q1_6501"] = "용의 눈"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6501
Lang["Q2_6501"] = "전 세계를 뒤져 용의눈 조각의 힘을 복원할 수 있는 자를 찾아야 합니다. 이와 관련해 알고 있는 유일한 정보는 그러한 자들이 존재한다는 것뿐입니다."
Lang["Q1_6502"] = "비룡불꽃 아뮬렛"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=6502
Lang["Q2_6502"] = "사령관 드라키사스에게서 검은용 용사의 피를 가져와야 합니다. 드라키사스는 검은바위 첨탑의 승천의 전당 뒤에 있는 알현실에 있습니다."
Lang["Q1_7761"] = "블랙핸드의 명령서"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=7761
Lang["Q2_7761"] = "아주 멍청한 오크로군요. 지배의 보주를 사용하려면 드라키사스의 낙인을 찾아 드라키사스의 징표를 받아야 할 거 같습니다.\n\n이 편지에 따르면 드라키사스 사령관이 낙인을 지키고 있다고 하니 조사해 보는 것이 좋겠습니다."
Lang["Q1_9121"] = "공포의 요새 낙스라마스"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9121
Lang["Q2_9121"] = "동부 역병지대의 희망의 빛 예배당에 있는 대마법사 안젤라 도산토스가 신비한 수정 5개, 마력의 결정체 2개, 정의의 보주 1개, 60골드를 가져다달라고 부탁했습니다. 또한 은빛 여명회의 평판이 우호적이어야 합니다."
Lang["Q1_9122"] = "공포의 요새 낙스라마스"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9122
Lang["Q2_9122"] = "동부 역병지대의 희망의 빛 예배당에 있는 대마법사 안젤라 도산토스가 신비한 수정 2개, 마력의 결정체 1개, 30골드를 가져다 달라고 부탁했습니다. 또한 은빛 여명회의 평판이 매우 우호적이어야 합니다."
Lang["Q1_9123"] = "공포의 요새 낙스라마스"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9123
Lang["Q2_9123"] = "동부 역병지대의 희망의 빛 예배당에 있는 대마법사 안젤라 도산토스가 비전 은신 마법으로 낙스라마스로 들어갈 수 있도록 해 줄 것입니다. 은빛 여명회의 평판이 확고한 동맹이어야 합니다."
Lang["Q1_8286"] = "미래의 운명"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8286
Lang["Q2_8286"] = "타나리스에 있는 시간의 동굴로 가서 노즈도르무 혈족인 아나크로노스를 찾아야 합니다."
Lang["Q1_8288"] = "최후의 한 명"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8288
Lang["Q2_8288"] = "실리더스의 세나리온 요새에 있는 흐르는 모래의 바리스톨스에게 용기대장 래쉬레이어의 머리를 가져가야 합니다."
Lang["Q1_8301"] = "정의의 길"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8301
Lang["Q2_8301"] = "실리시드 등껍질 조각 200개를 모아 바리스톨스에게 가져가야 합니다."
Lang["Q1_8303"] = "아나크로노스"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8303
Lang["Q2_8303"] = "타나리스의 시간의 동굴에 있는 아나크로노스를 찾아가야 합니다."
Lang["Q1_8305"] = "잊혀진 오랜 기억"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8305
Lang["Q2_8305"] = "실리더스에서 눈물의 결정의 위치를 찾아 그 안을 응시하십시오."
Lang["Q1_8519"] = "장기판 위의 졸"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8519
Lang["Q2_8519"] = "잊혀진 오랜 기억에 대해 가능한 모든 것을 확인한 후 타나리스의 시간의 동굴에 있는 아나크로노스와 대화하십시오."
Lang["Q1_8555"] = "용군단의 임무"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8555
Lang["Q2_8555"] = "에라니쿠스, 밸라스트라즈, 아주어고스... 필멸의 존재여, 그대는 필시 이 용들에 대해 알고 있다. 그러니 이들이 우리 세계의 파수꾼으로서 중요한 역할을 해 왔다는 것은 결코 우연이 아니니라.\n\n불행히도 고대 신들의 추종자 아니면 그들을 친구라고 부르는 자들의 배신으로 인해 우리의 수호자들에게 비극이 일어났다. 물론 내 어리석음도 어느 정도 잘못이 있다는 것을 부인할 수는 없지만... 이 일로 그대의 종족에 대한 나의 불신은 그만큼 깊어졌느니라.\n\n그들을 찾아라... 그리고 최악의 상황에 대비하도록 하라."
Lang["Q1_8730"] = "네파리우스의 타락"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8730
Lang["Q2_8730"] = "네파리안을 해치우고 붉은색 홀 파편을 되찾아 타나리스의 시간의 동굴에 있는 아나크로노스에게 돌아가십시오. 5시간 내에 임무를 완수해야 합니다."
Lang["Q1_8733"] = "꿈의 폭군 에라니쿠스"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8733
Lang["Q2_8733"] = "나이트 엘프의 땅 텔드랏실로 가 다르나서스 성벽 밖에서 말퓨리온의 대리인을 찾아야 합니다."
Lang["Q1_8734"] = "티란데와 레물로스"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8734
Lang["Q2_8734"] = "달의 숲으로 가서 수호자 레물로스와 대화하십시오."
Lang["Q1_8735"] = "에라니쿠스의 타락"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8735
Lang["Q2_8735"] = "아제로스에 있는 4개의 에메랄드의 꿈의 차원문으로 간 다음 각 에메랄드의 꿈의 차원문에서 오염된 악몽의 조각을 모은 후, 임무를 완수하면 달의 숲에 있는 수호자 레물로스에게 돌아가야 합니다."
Lang["Q1_8736"] = "드러난 악몽"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8736
Lang["Q2_8736"] = "에라니쿠스로부터 나이트헤이븐을 지켜야 합니다. 수호자 레물로스가 죽지 않도록 지켜내고 에라니쿠스 또한 죽지 않아야 합니다. 자신을 지키며 티란데를 기다려야 합니다."
Lang["Q1_8741"] = "용사의 귀환"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8741
Lang["Q2_8741"] = "타나리스의 시간의 동굴에 있는 아나크로노스에게 녹색 홀 파편을 가져가야 합니다."
Lang["Q1_8575"] = "아주어고스의 마법 장부"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8575
Lang["Q2_8575"] = "타나리스에 있는 나라인 수스팬시에게 아주어고스의 마법 장부를 전달해야 합니다."
Lang["Q1_8576"] = "장부 해석"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8576
Lang["Q2_8576"] = "이걸 해석하려면 내 수정점 고글과 250kg짜리 닭, 그리고 왕초보를 위한 용언 완전정복: 제2권이 있어야 할 것 같군요. 순서는 바뀌어도 상관없어요."
Lang["Q1_8597"] = "왕초보를 위한 용언 완전정복"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8597
Lang["Q2_8597"] = "남쪽 바다의 한 섬에 묻혀 있는 나라인 수스팬시의 책을 찾아야 합니다."
Lang["Q1_8599"] = "나라인을 위한 사랑 노래"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8599
Lang["Q2_8599"] = "타나리스에 있는 나라인 수스팬시에게 메리디스의 연애 편지를 전해 주어야 합니다."
Lang["Q1_8598"] = "협박장"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8598
Lang["Q2_8598"] = "타나리스에 있는 나라인 수스팬시에게 협박장을 전달해야 합니다."
Lang["Q1_8606"] = "미끼!"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8606
Lang["Q2_8606"] = "타나리스에 있는 나라인 수스팬시가 여명의 설원으로 가서 책을 훔쳐 간 자들이 적어 놓은 접선 장소에 돈자루를 갖다 놓아 달라고 부탁했습니다."
Lang["Q1_8620"] = "유일한 방법"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8620
Lang["Q2_8620"] = "사라진 왕초보를 위한 용언 완전정복의 여덟 장을 모두 찾아서 마법의 제본 매듭으로 붙인 후, 타나리스에 있는 나라인 수스팬시에게 완성된 왕초보를 위한 용언 완전정복: 제 2권을 가져가야 합니다."
Lang["Q1_8584"] = "질문 사절"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8584
Lang["Q2_8584"] = "타나리스에 있는 나라인 수스팬시가 가젯잔에 있는 더지 퀵클레이브와 대화해 보라고 부탁했습니다."
Lang["Q1_8585"] = "공포의 섬!"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8585
Lang["Q2_8585"] = "라크마에란의 시체를 손에 넣고 키메로크 안심 20개를 구해서 타나리스에 있는 더지 퀵클레이브에게 돌아가야 합니다."
Lang["Q1_8586"] = "더지의 기똥찬 키메로크 찹스테이크"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8586
Lang["Q2_8586"] = "가젯잔에 있는 더지 퀵클레이브에게 고블린 로켓 연료와 깊은바다 소금을 각각 20개씩 가져가야 합니다."
Lang["Q1_8587"] = "나라인에게 돌아가기"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8587
Lang["Q2_8587"] = "타나리스에 있는 나라인 수스팬시에게 250Kg짜리 닭을 가져가야 합니다."
Lang["Q1_8577"] = "가장 절친했던 옛 친구 스튜불"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8577
Lang["Q2_8577"] = "나라인 수스팬시가 그의 가장 절친했던 옛 친구 스튜불을 찾아 자신에게서 훔쳐간 수정점 고글을 되찾아 달라고 부탁했습니다."
Lang["Q1_8578"] = "수정점 고글? 문제 없어요!"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8578
Lang["Q2_8578"] = "나라인의 수정점 고글을 찾은 후, 타나리스에 있는 나라인 수스팬시에게 돌아가야 합니다."
Lang["Q1_8728"] = "좋은 소식과 나쁜 소식"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8728
Lang["Q2_8728"] = "타나리스에 있는 나라인 수스팬시가 아케이나이트 주괴 20개, 엘레멘티움 광석 10개, 아제로스 다이아몬드 10개, 푸른 사파이어 10개를 가져다 달라고 부탁했습니다."
Lang["Q1_8729"] = "넵튤론의 분노"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8729
Lang["Q2_8729"] = "아즈샤라의 폭풍의 만에 있는 회오리치는 소용돌이에서 아케이나이트 부표를 사용해야 합니다."
Lang["Q1_8742"] = "칼림도어의 힘"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8742
Lang["Q2_8742"] = "수천년이 흘러 운명처럼 내 앞에 당신이 서 있습니다. 새로운 시대로 사람들을 이끄는 사람이 나타났습니다.\n\n옛 신이 공포에 떱니다. 맞습니다, 당신의 신념을 두려워합니다. 크툰의 신념을 산산조각내자.\n\n그것은 당신이 칼림도어의 힘을 가지고 온 영웅이 되었음을 알고 있습니다. 준비가 되면 당신에게 이 흐르는 모래의 홀을 드리겠습니다."
Lang["Q1_8745"] = "시간 지배자의 보물"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=8745
Lang["Q2_8745"] = "영웅이여 환영합니다. 나는 징의 수호자이며 청동군단의 추적자 조나단입니다.\n\n당신이 원하는 시간 지배자의 보물을 선택하세요. 크툰과의 전투에서 승리하는데 도움이 되길 바랍니다."


-- QUESTS - TBC
Lang["Q1_10755"] = "지옥불 성채로"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10755
Lang["Q2_10755"] = "지옥불 반도의 스랄마에 있는 나즈그렐에게 준비된 열쇠 거푸집을 가져가야 합니다."
Lang["Q1_10756"] = "대장기술의 거장 로호크"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10756
Lang["Q2_10756"] = "스랄마에 있는 로호크에게 준비된 열쇠 거푸집을 가져가야 합니다."
Lang["Q1_10757"] = "로호크의 부탁"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10757
Lang["Q2_10757"] = "지옥불 반도의 스랄마에 있는 로호크에게 지옥무쇠 주괴 4개, 신비한 수정 가루 2개, 불의 티끌 4개를 가져가야 합니다."
Lang["Q1_10758"] = "지옥보다 뜨거운"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10758
Lang["Q2_10758"] = "지옥불 반도에서 지옥절단기 1대를 파괴한 후 그 안에 달궈지지 않은 열쇠 거푸집을 넣어야 합니다. 스랄마에 있는 로호크에게 그을린 열쇠 거푸집을 가져가야 합니다."
Lang["Q1_10754"] = "지옥불 성채로"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10754
Lang["Q2_10754"] = "지옥불 반도의 명예의 요새에 있는 전투사령관 다나스에게 준비된 열쇠 거푸집을 가져가야 합니다."
Lang["Q1_10762"] = "거장 덤프리"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10762
Lang["Q2_10762"] = "명예의 요새에 있는 덤프리에게 준비된 열쇠 거푸집을 가져가야 합니다."
Lang["Q1_10763"] = "덤프리의 부탁"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10763
Lang["Q2_10763"] = "지옥불 반도의 명예의 요새에 있는 덤프리에게 지옥무쇠 주괴 4개, 신비한 수정 가루 2개, 불의 티끌 4개를 가져가야 합니다."
Lang["Q1_10764"] = "지옥보다 뜨거운 지옥절단기"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10764
Lang["Q2_10764"] = "지옥불 반도에서 지옥절단기 1대를 파괴한 후 그 안에 달궈지지 않은 열쇠 거푸집을 넣은 후, 그을린 열쇠 거푸집을 명예의 요새에 있는 덤프리에게 가져가야 합니다."
Lang["Q1_10279"] = "지배자의 둥지로"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10279
Lang["Q2_10279"] = "시간의 동굴에 있는 안도르무와 대화해야 합니다."
Lang["Q1_10277"] = "시간의 동굴"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10277
Lang["Q2_10277"] = "시간의 동굴에 있는 안도르무가 동굴 주변에 있는 시간의 관리인을 따라가 달라고 부탁했습니다."
Lang["Q1_10282"] = "옛 힐스브래드"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10282
Lang["Q2_10282"] = "시간의 동굴에 있는 안도르무가 옛 힐스브래드로 가서 에로지온과 대화해 달라고 부탁했습니다."
Lang["Q1_10283"] = "타레사의 작전"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10283
Lang["Q2_10283"] = "던홀드 요새로 가서 에로지온이 준 화염 폭탄 자루를 사용하여 모든 수용소의 안에 있는 맥주통에 화염 폭탄을 5개씩 설치해야 합니다. 수용소를 다 불태웠으면 던홀드 요새의 지하 감옥에 있는 스랄과 대화하십시오."
Lang["Q1_10284"] = "던홀드 탈출"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10284
Lang["Q2_10284"] = "준비가 되면 스랄에게 알려준 후, 던홀드 요새에서 스랄을 따라나가 그가 타레사를 구출하고 운명을 실현할 수 있도록 도와야 합니다. 이 임무를 완수하면 옛 힐스브래드에 있는 에로지온과 대화해야 합니다."
Lang["Q1_10285"] = "안도르무에게 돌아가기"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10285
Lang["Q2_10285"] = "타나리스의 시간의 동굴에 있는 어린 안도르무에게 돌아가야 합니다."
Lang["Q1_10265"] = "무역연합 수정 수집"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10265
Lang["Q2_10265"] = "황천의 폭풍의 52번 구역에 있는 황천추적자 케이지에게 알클론 수정 유물 1개를 가져가야 합니다."
Lang["Q1_10262"] = "에테리얼 무리"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10262
Lang["Q2_10262"] = "작시스 휘장 10개를 수집해서 황천의 폭풍 52번 구역에 있는 황천추적자 케이지에게 가져가야 합니다."
Lang["Q1_10205"] = "초공간 약탈자 네사드"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10205
Lang["Q2_10205"] = "초공간 약탈자 네사드를 처치한 후에 황천의 폭풍의 52번 구역에 있는 황천추적자 케이지에게 돌아가야 합니다"
Lang["Q1_10266"] = "원조 요청"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10266
Lang["Q2_10266"] = "가루즈를 찾아서 도와주어야 합니다. 황천의 폭풍, 중앙 생태지구 안에 있는 중앙 생태지구 주둔지로 가십시오."
Lang["Q1_10267"] = "정당한 회수"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10267
Lang["Q2_10267"] = "측량 장비 상자 10개를 모아서 황천의 폭풍, 중앙 생태지구 안에서 중앙 생태지구 주둔지에 있는 가루즈에게 돌려주어야 합니다."
Lang["Q1_10268"] = "왕자 알현"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10268
Lang["Q2_10268"] = "황천의 폭풍, 폭풍 첨탑에 있는 연합왕자 하라매드의 영상에게 측량 장비를 가져가야 합니다."
Lang["Q1_10269"] = "첫 번째 삼각측량 지점"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10269
Lang["Q2_10269"] = "삼각측량 장비를 사용하여 첫 번째 삼각측량 지점을 찾아가십시오. 발견한 후에는 황천의 폭풍의 울트리스 마나괴철로 섬에 있는 자유연합 경비초소의 무역업자 하진에게 가서 위치를 보고하십시오."
Lang["Q1_10275"] = "두 번째 삼각측량 지점"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10275
Lang["Q2_10275"] = "삼각측량 장비를 사용하여 두 번째 삼각측량 지점을 찾으십시오. 발견하면 황천의 폭풍의 아라 마나괴철로 섬으로 들어가는 다리 옆, 툴루만의 교역지에 있는 바람의 무역상 툴루만에게 가서 그 위치를 보고하십시오."
Lang["Q1_10276"] = "완전한 삼각형"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10276
Lang["Q2_10276"] = "아타말 수정을 찾아서 황천의 폭풍, 폭풍 첨탑에 있는 연합왕자 하라매드의 영상에게 가져가야 합니다."
Lang["Q1_10280"] = "샤트라스로 특별 배달"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10280
Lang["Q2_10280"] = "샤트라스의 빛의 정원에 있는 아달에게 아타말 수정을 배달해야 합니다."
Lang["Q1_10704"] = "알카트라즈에 잠입하는 방법"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10704
Lang["Q2_10704"] = "아달이 알카트라즈 열쇠의 윗조각과 아랫조각을 찾아달라고 부탁했습니다. 열쇠 조각을 다 모아서 가져가면 알카트라즈 열쇠로 만들어줄 것입니다."
Lang["Q1_9824"] = "발산되는 비전의 힘"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9824
Lang["Q2_9824"] = "지배자의 지하실에 있는 지하 수원 근처에서 보랏빛 수정구슬을 사용한 후 카라잔 밖에 있는 대마법사 알투루스에게 돌아가야 합니다."
Lang["Q1_9825"] = "끊임없는 유령의 활동"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9825
Lang["Q2_9825"] = "카라잔 밖에 있는 대마법사 알투루스에게 유령의 정수 10개를 가져가야 합니다."
Lang["Q1_9826"] = "달라란에서의 전갈"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9826
Lang["Q2_9826"] = "달라란 구덩이 외곽에 있는 대마법사 세드릭에게 알투루스의 보고서를 가져가야 합니다."
Lang["Q1_9829"] = "카드가"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9829
Lang["Q2_9829"] = "테로카르 숲의 샤트라스에 있는 카드가에게 알투루스의 보고서를 전달해야 합니다."
Lang["Q1_9831"] = "카라잔으로..."			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9831
Lang["Q2_9831"] = "카드가가 아킨둔의 어둠의 미궁으로 들어가서 그곳에 숨겨진 마법 단지에서 첫 번째 열쇠 조각을 꺼내오라고 부탁했습니다."
Lang["Q1_9832"] = "두 번째와 세 번째 조각"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9832
Lang["Q2_9832"] = "갈퀴송곳니 저수지 안의 마법 단지에서 두 번째 열쇠 조각을, 폭풍우 요새 내부의 마법 단지에서 세 번째 열쇠 조각을 찾아야 합니다. 모두 찾은 후 샤트라스에 있는 카드가에게 돌아가십시오."
Lang["Q1_9836"] = "메디브와의 만남"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9836
Lang["Q2_9836"] = "시간의 동굴 안에 들어간 후 메디브를 설득하여 복원된 수습생의 열쇠를 활성화해야 합니다."
Lang["Q1_9837"] = "카드가에게 돌아가기"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9837
Lang["Q2_9837"] = "샤트라스에 있는 카드가에게 돌아가서 주인의 열쇠를 보여 주어야 합니다."
Lang["Q1_9838"] = "보랏빛 눈"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9838
Lang["Q2_9838"] = "카라잔 밖에 있는 대마법사 알투루스와 대화해야 합니다."
Lang["Q1_9630"] = "메디브의 일지"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9630
Lang["Q2_9630"] = "죽음의 고개에 있는 대마법사 알투루스가 카라잔으로 가서 레비엔과 대화해 보라고 부탁했습니다."
Lang["Q1_9638"] = "그라다브와의 대화"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9638
Lang["Q2_9638"] = "카라잔의 수호자의 도서관에 있는 그라다브와 대화해야 합니다.."
Lang["Q1_9639"] = "캄시스와의 대화"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9639
Lang["Q2_9639"] = "카라잔의 수호자의 도서관에 있는 캄시스와 대화해야 합니다."
Lang["Q1_9640"] = "아란의 망령"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9640
Lang["Q2_9640"] = "메디브의 일지를 얻은 후 카라잔의 수호자의 도서관에 있는 캄시스에게 돌아가야 합니다."
Lang["Q1_9645"] = "주인의 테라스"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9645
Lang["Q2_9645"] = "카라잔에 있는 주인의 테라스로 가서 메디브의 일지를 읽은 후 메디브의 일기를 가지고 대마법사 알투루스에게 돌아가야 합니다."
Lang["Q1_9680"] = "과거의 추적"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9680
Lang["Q2_9680"] = "대마법사 알투루스가 카라잔 남쪽의 죽음의 고개에 있는 산으로 가서 그을린 뼈 조각을 되찾아 달라고 부탁했습니다."
Lang["Q1_9631"] = "동료의 도움"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9631
Lang["Q2_9631"] = "황천의 폭풍의 52번 구역에 있는 칼린나 나스레드에게 그을린 뼈 조각을 가져가야 합니다."
Lang["Q1_9637"] = "칼린나의 부탁"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9637
Lang["Q2_9637"] = "칼린나 나스레드가 지옥불 성채의 으스러진 손의 전당에 있는 대흑마법사 네더쿠르스로부터 어둠의 고서를, 아킨둔의 세데크 전당에 있는 흑마술사 시스에게서 잊혀진 이름의 고서를 되찾아 달라고 부탁했습니다.\n\n이 퀘스트는 던전 난이도를 영웅으로 설정한 후 수행해야 합니다."
Lang["Q1_9644"] = "파멸의 어둠"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=9644
Lang["Q2_9644"] = "카라잔에 있는 주인의 테라스로 간 후 어둠의 단지를 만져 파멸의 어둠을 소환한 후, 파멸의 어둠의 시체에서 희미한 비전 정수를 되찾은 후 대마법사 알투루스에게 가져가야 합니다."
Lang["Q1_10901|13431"] = "카르데쉬의 곤봉"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10901|13431
Lang["Q2_10901|13431"] = "갈퀴송곳니 저수지의 용사 강제 노역소에 있는 이단자 스카디스가 땅의 인장과 불의 인장을 가져다 달라고 부탁했습니다.\n\n이 퀘스트는 던전 난이도를 영웅으로 설정한 후 수행해야 합니다."
Lang["Q1_10900"] = "바쉬의 증표"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10900
Lang["Q2_10900"] = "(바로 완료됨)"
Lang["Q1_10681"] = "굴단의 손아귀"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10681
Lang["Q2_10681"] = "어둠달 골짜기의 저주의 제단에 있는 대지의 치유사 토르록과 대화하십시오."
Lang["Q1_10458"] = "분노한 불과 대지의 정령들"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10458
Lang["Q2_10458"] = "어둠달 골짜기 저주의 제단에 있는 대지의 치유사 토르록이 정기의 토템을 사용해 분노한 대지의 영혼 8명과 분노한 불의 영혼 8명을 사로잡아 달라고 부탁했습니다."
Lang["Q1_10480"] = "분노한 물의 정령"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10480
Lang["Q2_10480"] = "어둠달 골짜기의 저주의 제단에 있는 대지의 치유사 토르록이 정기의 토템을 사용하여 분노한 물의 영혼 5명을 사로잡아 달라고 부탁했습니다."
Lang["Q1_10481"] = "분노한 바람의 정령"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10481
Lang["Q2_10481"] = "어둠달 골짜기의 저주의 제단에 있는 대지의 치유사 토르록이 정기의 토템을 사용하여 분노한 바람의 영혼 10명을 사로잡아 달라고 부탁했습니다."
Lang["Q1_10513"] = "비통의 오로노크"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10513
Lang["Q2_10513"] = "갈퀴흉터 저수지 북쪽에 있는 융기한 지대 위에서 비통의 오로노크를 찾으십시오."
Lang["Q1_10514"] = "과거는 과거일 뿐..."			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10514
Lang["Q2_10514"] = "어둠달 골짜기의 오로노크의 농장에 있는 비통의 오로노크가 부서진 평원에서 어둠달 덩이줄기 10개를 캐달라고 부탁했습니다."
Lang["Q1_10515"] = "본때 보여주기"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10515
Lang["Q2_10515"] = "어둠달 골짜기의 오로노크의 농장에 있는 비통의 오로노크가 부서진 평원에 있는 걸신들린 바위갈퀴 알 10개를 파괴해 달라고 부탁했습니다."
Lang["Q1_10519"] = "파멸의 암호 - 진실과 역사"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10519
Lang["Q2_10519"] = "어둠달 골짜기의 오로노크의 농장에 있는 비통의 오로노크가 그의 이야기를 들어달라고 했습니다. 그에게 다시 말을 걸면 이야기를 들을 수 있습니다."
Lang["Q1_10521"] = "오로노크의 아들 그롬토르"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10521
Lang["Q2_10521"] = "어둠달 골짜기의 갈퀴흉터 거점에서 오로노크의 아들 그롬토르를 찾아야 합니다."
Lang["Q1_10527"] = "오로노크의 아들 알토르"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10527
Lang["Q2_10527"] = "어둠달 골짜기의 일리다리 거점에서 오로노크의 아들 알토르를 찾아야 합니다."
Lang["Q1_10546"] = "오로노크의 아들 보라크"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10546
Lang["Q2_10546"] = "어둠달 골짜기의 해그늘 주둔지 근처에 있는 오로노크의 아들 보라크를 찾아야 합니다."
Lang["Q1_10522"] = "파멸의 암호 - 그롬토르의 임무"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10522
Lang["Q2_10522"] = "어둠달 골짜기의 갈퀴흉터 거점에 있는 오로노크의 아들 그롬토르가 첫 번째 파멸의 암호 조각을 가져오라고 부탁했습니다."
Lang["Q1_10528"] = "악마의 수정 감옥"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10528
Lang["Q2_10528"] = "일리다리 거점에서 고통의 여왕 가브리사를 찾아 처치한 후에 수정 열쇠를 가지고 오로노크의 아들 알토르의 주검이 있는 곳으로 돌아가십시오."
Lang["Q1_10547"] = "엉겅퀴 중독자와 알"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10547
Lang["Q2_10547"] = "해그늘 주둔지에서 북쪽 다리에 있는 오로노크의 아들 보라크가 썩은 아라코아 알 한 개를 찾아서 북서쪽 테로카르 숲에 있는 샤트라스의 쓰레기 수집가 토비아스에게 가져가 달라고 부탁했습니다."
Lang["Q1_10523"] = "파멸의 암호 - 첫 번째 조각 입수"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10523
Lang["Q2_10523"] = "어둠달 골짜기의 오로노크의 농장에 있는 비통의 오로노크에게 그롬토르의 금고를 가져가야 합니다."
Lang["Q1_10537"] = "론고른, 비통의 장궁"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10537
Lang["Q2_10537"] = "어둠달 골짜기의 일리다리 거점에 있는 알토르의 영혼이 그 지역에 있는 악마들을 처치하고 론고른, 비통의 장궁을 찾아달라고 부탁했습니다."
Lang["Q1_10550"] = "피엉겅퀴 묶음"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10550
Lang["Q2_10550"] = "어둠달 골짜기의 해그늘 주둔지 근처에 있는 오로노크의 아들 보라크에게 피엉겅퀴 묶음을 돌려주어야 합니다."
Lang["Q1_10540"] = "파멸의 암호 - 알토르의 임무"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10540
Lang["Q2_10540"] = "어둠달 골짜기의 일리다리 거점에 있는 알토르의 영혼이 베네라투스를 처치하고 두 번째 파멸의 암호 조각을 찾아오라고 부탁했습니다.\n\n단, 정령사냥꾼이 공격하여 대부분의 피해를 입힌 몬스터는 전리품이나 경험치를 주지 않습니다."
Lang["Q1_10570"] = "엉겅퀴 중독자 포획"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10570
Lang["Q2_10570"] = "어둠달 골짜기의 해그늘 주둔지 근처에 있는 오로노크의 아들 보라크가 스톰레이지의 서신을 입수해 달라고 부탁했습니다."
Lang["Q1_10576"] = "어둠달의 속임수"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10576
Lang["Q2_10576"] = "어둠달 골짜기의 해그늘 주둔지 근처에 있는 오로노크의 아들 보라크가 해그늘 방어구 6벌을 구해오라고 부탁했습니다."
Lang["Q1_10577"] = "일리단은 원하면, 갖는다..."			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10577
Lang["Q2_10577"] = "어둠달 골짜기의 해그늘 주둔지 근처에 있는 오로노크의 아들 보라크가 해그늘 주둔지에 있는 총사령관에게 일리단의 전갈을 전해 달라고 부탁했습니다."
Lang["Q1_10578"] = "파멸의 암호 - 보라크의 임무"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10578
Lang["Q2_10578"] = "어둠달 골짜기, 해그늘 주둔지 근처의 다리에 있는 오로노크의 아들 보라크가 암흑의 인도자 루울을 처치하고 세 번째 파멸의 암호 조각을 찾아와 달라고 부탁했습니다."
Lang["Q1_10541"] = "파멸의 암호 - 두 번째 조각 입수"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10541
Lang["Q2_10541"] = "어둠달 골짜기의 오로노크의 농장에 있는 비통의 오로노크에게 알토르의 금고를 가져가야 합니다."
Lang["Q1_10579"] = "파멸의 암호 - 세 번째 조각 입수"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10579
Lang["Q2_10579"] = "어둠달 골짜기의 오로노크의 농장에 있는 비통의 오로노크에게 보라크의 금고를 가져가야 합니다."
Lang["Q1_10588"] = "파멸의 암호"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10588
Lang["Q2_10588"] = "저주의 제단에서 파멸의 암호를 사용하여 불의 군주 사이루크를 소환해야 합니다.\n\n불의 군주 사이루크를 파괴한 후 저주의 제단에 있는 대지의 치유사 토르록과 대화하십시오."
Lang["Q1_10883"] = "폭풍우 열쇠"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10883
Lang["Q2_10883"] = "샤트라스에 있는 아달과 대화해야 합니다."
Lang["Q1_10884"] = "나루의 시험: 자비"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10884
Lang["Q2_10884"] = "샤트라스에 있는 아달이 지옥불 성채의 으스러진 손의 전당에서 사용되지 않은 집행자의 도끼를 가져다 달라고 부탁했습니다.\n\n이 퀘스트는 던전 난이도를 영웅으로 설정한 후 수행해야 합니다."
Lang["Q1_10885"] = "나루의 시험: 힘"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10885
Lang["Q2_10885"] = "샤트라스에 있는 아달이 칼리스레쉬의 삼지창, 울림의 정수를 가져다 달라고 부탁했습니다.\n\n이 퀘스트는 던전 난이도를 영웅으로 설정한 후 수행해야 합니다."
Lang["Q1_10886"] = "나루의 시험: 끈기"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10886
Lang["Q2_10886"] = "샤트라스에 있는 아달이 폭풍우 요새의 알카트라즈에서 밀하우스 마나스톰을 구출해 달라고 부탁했습니다.\n\n이 퀘스트는 던전 난이도를 영웅으로 설정한 후 수행해야 합니다."
Lang["Q1_10888|13430"] = "나루의 시험: 마그테리돈"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10888|13430
Lang["Q2_10888|13430"] = "샤트라스에 있는 아달이 마그테리돈을 처치해 달라고 부탁했습니다."
Lang["Q1_10680"] = "굴단의 손아귀"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10680
Lang["Q2_10680"] = "어둠달 골짜기의 저주의 제단에 있는 대지의 치유사 토르록과 대화해야 합니다."
Lang["Q1_10445|13432"] = "영원의 샘"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10445|13432
Lang["Q2_10445|13432"] = "시간의 동굴에 있는 소리도르미가 갈퀴송곳니 저수지에 있는 여군주 바쉬에게서 유리병 잔여물을, 폭풍우 요새에 있는 캘타스 선스트라이더로부터 유리병 잔여물을 되찾아 달라고 부탁했습니다."
Lang["Q1_10568"] = "바아리 서판"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10568
Lang["Q2_10568"] = "샤타르 제단에 있는 수도사 케일라가 바아리 폐허에서 바아리 서판 12개를 모아달라고 부탁했습니다. 서판은 땅에서 줍거나 폐허의 잿빛혓바닥 일꾼을 처치해서 얻을 수 있습니다\n\n알도르 사제회를 위한 퀘스트를 완료하면 점술가 길드에 대한 평판은 떨어질 것입니다."
Lang["Q1_10683"] = "바아리 서판"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10683
Lang["Q2_10683"] = "별의 성소에 있는 비전술사 텔리스가 바아리 폐허에서 바아리 서판 12개를 모아달라고 부탁했습니다. 서판은 땅에서 줍거나 폐허의 잿빛혓바닥 일꾼을 처치해서 얻을 수 있습니다.\n\n점술가 길드를 위한 퀘스트를 완료하면 알도르 사제회에 대한 평판은 떨어질 것입니다."
Lang["Q1_10571"] = "장로 오로누"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10571
Lang["Q2_10571"] = "샤타르 제단에 있는 수도사 케일라가 바아리 폐허에 있는 장로 오로누를 해치우고 아카마의 명령서를 입수해 달라고 부탁했습니다.\n\n알도르 사제회를 위한 퀘스트를 완료하면 점술가 길드에 대한 평판은 떨어질 것입니다."
Lang["Q1_10684"] = "장로 오로누"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10684
Lang["Q2_10684"] = "별의 성소에 있는 비전술사 텔리스가 바아리 폐허에 있는 장로 오로누를 해치우고 아카마의 명령서를 입수해 달라고 부탁했습니다.\n\n점술가 길드를 위한 퀘스트를 완료하면 알도르 사제회에 대한 평판은 떨어질 것입니다."
Lang["Q1_10574"] = "잿빛혓바닥 타락자"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10574
Lang["Q2_10574"] = "할룸, 에이케넨, 라칸, 우일라루를 처치하고 메달 조각 4개를 입수한 후 어둠달 골짜기의 샤타르 제단에 있는 수도사 케일라에게 돌아가십시오.\n\n알도르 사제회를 위한 퀘스트를 완료하면 점술가 길드에 대한 당신의 평판은 떨어질 것입니다."
Lang["Q1_10685"] = "잿빛혓바닥 타락자"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10685
Lang["Q2_10685"] = "할룸, 에이케넨, 라칸, 우일라루를 처치하고 메달 조각 4개를 입수한 후 어둠달 골짜기의 별의 성소에 있는 비전술사 텔리스에게 돌아가십시오.\n\n점술가 길드를 위한 퀘스트를 완료하면 알도르 사제회에 대한 평판은 떨어질 것입니다."
Lang["Q1_10575"] = "감시자의 수용소"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10575
Lang["Q2_10575"] = "수도사 케일라가 바아리 폐허의 남쪽에 있는 감시자의 수용소로 들어가서 사노루를 심문해 아카마의 행방을 알아봐 달라고 부탁했습니다.\n\n알도르 사제회를 위한 퀘스트를 완료하면 점술가 길드에 대한 당신의 평판은 떨어질 것입니다."
Lang["Q1_10686"] = "감시자의 수용소"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10686
Lang["Q2_10686"] = "비전술사 텔리스가 바아리 폐허의 남쪽에 있는 감시자의 수용소로 들어가서 사노루를 심문해 아카마의 행방을 알아봐 달라고 부탁했습니다.\n\n점술가 길드를 위한 퀘스트를 완료하면 알도르 사제회에 대한 평판은 떨어질 것입니다."
Lang["Q1_10622"] = "충성의 증거"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10622
Lang["Q2_10622"] = "어둠달 골짜기의 감시자의 수용소에 있는 잔드라스를 해치운 후 사노루에게 돌아가십시오."
Lang["Q1_10628"] = "아카마"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10628
Lang["Q2_10628"] = "감시자의 수용소의 비밀 석실 안에 있는 아카마와 대화하십시오."
Lang["Q1_10705"] = "현자 우달로"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10705
Lang["Q2_10705"] = "폭풍우 요새의 알카트라즈 안에 있는 현자 우달로를 찾아야 합니다."
Lang["Q1_10706"] = "수수께끼의 징후"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10706
Lang["Q2_10706"] = "어둠달 골짜기의 감시자의 수용소에 있는 아카마에게 돌아가십시오."
Lang["Q1_10707"] = "아타말 언덕"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10707
Lang["Q2_10707"] = "어둠달 골짜기의 아타말 언덕 꼭대기에 가서 격노의 심장을 찾으십시오. 임무를 완수하면 어둠달 골짜기의 감시자의 수용소에 있는 아카마에게 돌아가십시오."
Lang["Q1_10708"] = "아카마의 약속"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10708
Lang["Q2_10708"] = "샤트라스에 있는 아달에게 카라보르의 메달을 가져가야 합니다."
Lang["Q1_10944"] = "위기에 빠진 비밀"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10944
Lang["Q2_10944"] = "어둠달 골짜기에 있는 감시자의 수용소로 가서 아카마를 만나야 합니다."
Lang["Q1_10946"] = "잿빛혓바닥의 환영"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10946
Lang["Q2_10946"] = "폭풍우 요새로 가서 잿빛혓바닥 두건을 착용한 채로 알라르를 처치한 후, 어둠달 골짜기에 있는 아카마에게 돌아가야 합니다."
Lang["Q1_10947"] = "과거로부터 온 유물"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10947
Lang["Q2_10947"] = "타나리스에 있는 시간의 동굴로 가서 하이잘 산의 전투가 벌어지는 곳으로 진입하십시오. 전투에 참여하면 격노한 윈터칠을 처치하고 어둠달 골짜기에 있는 아카마에게 시간을 거스른 성물함을 가져가야 합니다."
Lang["Q1_10948"] = "볼모가 된 영혼"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10948
Lang["Q2_10948"] = "샤트라스로 가서 아달에게 아카마의 요청에 대해서 알려줘야 합니다."
Lang["Q1_10949"] = "검은 사원 속으로"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10949
Lang["Q2_10949"] = "어둠달 골짜기에 있는 검은 사원의 입구로 간 후 지리와 대화해야 합니다.."
Lang["Q1_10985|13429"] = "아카마를 위한 소동"			-- https://wow.inven.co.kr/dataninfo/wdb/edb_quest/detail.php?id=10985|13429
Lang["Q2_10985|13429"] = "지리의 군대가 소동을 일으킨 후에 마이에브와 아카마가 어둠달 골짜기의 검은 사원에 진입하도록 도와야 합니다."
--v243
Lang["Q1_10984"] = "오우거와 대화"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10984
Lang["Q2_10984"] = "샤트라스의 고난의 거리에 있는 오우거, 그록과 대화하십시오."
Lang["Q1_10983"] = "주름투성이 모그도그"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10983
Lang["Q2_10983"] = "칼날 산맥, 피의 투기장 바깥에 있는 탑들 중 한 곳의 꼭대기에 있는 모그도그를 찾아가야 합니다."
Lang["Q1_10995"] = "그룰록이 아끼는 물건"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10995
Lang["Q2_10995"] = "그룰록의 용 해골을 회수하여 칼날 산맥의 피의 투기장의 탑 맨 꼭대기에 있는 주름투성이 모그도그에게 가져가야 합니다."
Lang["Q1_10996"] = "마그고크의 보물 상자"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10996
Lang["Q2_10996"] = "마그고크의 보물 상자를 회수하여 칼날 산맥의 피의 투기장 탑 맨 꼭대기에 있는 주름투성이 모그도그에게 가져가야 합니다."
Lang["Q1_10997"] = "그론에게도 깃발이..."			-- https://www.thegeekcrusade-serveur.com/db/?quest=10997
Lang["Q2_10997"] = "슬라그의 깃발을 회수하여 칼날 산맥의 피의 투기장에 있는 탑 맨꼭대기의 주름투성이 모그도그에게 가져가야 합니다."
Lang["Q1_10998"] = "흑마법서 회수"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10998
Lang["Q2_10998"] = "비열한 빔골의 흑마법서를 회수한 후, 칼날 산맥의 피의 투기장에 있는 경비탑 꼭대기의 주름투성이 모그도그에게 가져갸아 합니다."
Lang["Q1_11000"] = "영혼분쇄자에게로"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11000
Lang["Q2_11000"] = "영혼분쇄자 스컬록에게서 스컬록의 영혼을 회수한 후, 칼날 산맥의 피의 투기장 안에 있는 경비탑의 꼭대기에 있는 모그도그에게 가져가야 합니다."
Lang["Q1_11022"] = "모그도그와의 대화"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11022
Lang["Q2_11022"] = "칼날 산맥의 피의 투기장의 동쪽 끝 탑 위에 있는 주름투성이 모그도그와 대화해야 합니다."
Lang["Q1_11009"] = "오우거의 천국"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11009
Lang["Q2_11009"] = "칼날 산맥의 오그릴라에 있는 추알로르와 대화해야 합니다."
--v244
Lang["Q1_10804"] = "친절"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10804
Lang["Q2_10804"] = "어둠달 골짜기의 황천날개 벌판에 있는 모르데나이가 다 자란 황천날개 비룡 8마리에게 먹이를 주라고 부탁했습니다."
Lang["Q1_10811"] = "넬타라쿠 찾기"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10811
Lang["Q2_10811"] = "황천날개 용군단의 지도자인 넬타라쿠를 찾아야 합니다."
Lang["Q1_10814"] = "넬타라쿠의 이야기"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10814
Lang["Q2_10814"] = "넬타라쿠와 대화해서 그의 이야기를 들어야 합니다."
Lang["Q1_10836"] = "용아귀 요새 침입"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10836
Lang["Q2_10836"] = "어둠달 골짜기, 황천날개 벌판의 창공을 나는 넬타라쿠가 용아귀부족 오크 15명을 처치해 달라고 부탁했습니다."
Lang["Q1_10837"] = "황천날개 마루를 향해!"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10837
Lang["Q2_10837"] = "어둠달 골짜기, 황천날개 벌판의 창공을 나는 넬타라쿠가 황천날개 마루에 있는 황천덩굴 수정 12개를 모아오라고 부탁했습니다."
Lang["Q1_10854"] = "넬타라쿠의 힘"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10854
Lang["Q2_10854"] = "어둠달 골짜기, 황천날개 벌판의 창공을 나는 넬타라쿠가 사로잡힌 황천날개 비룡 5마리를 구출해 달라고 부탁했습니다."
Lang["Q1_10858"] = "카리나쿠"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10858
Lang["Q2_10858"] = "용아귀 요새에 있는 카리나쿠를 찾아야 합니다."
Lang["Q1_10866"] = "늙은 줄루헤드"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10866
Lang["Q2_10866"] = "늙은 줄루헤드를 처치한 후 손에 넣은 줄루헤드의 열쇠로 줄루헤드의 족쇄를 풀고 카리나쿠를 구출해야 합니다."
Lang["Q1_10870"] = "황천날개 용군단의 동맹"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10870
Lang["Q2_10870"] = "카리나쿠의 인도를 받아 황천날개 벌판에 있는 모르데나이에게 돌아가야 합니다."
--v247
Lang["Q1_3801"] = "검은무쇠단 유물"			-- https://www.thegeekcrusade-serveur.com/db/?quest=3801
Lang["Q2_3801"] = "도시 주요 지역으로 통하는 열쇠를 얻고 싶다면 프랑클론 포지라이트와 대화하십시오."
Lang["Q1_3802"] = "검은무쇠단 유물"			-- https://www.thegeekcrusade-serveur.com/db/?quest=3802
Lang["Q2_3802"] = "파이너스 다크바이어를 처치하고 거대한 망치, 무쇠지옥을 회수해야 합니다. 무쇠지옥을 타우릿산의 제단으로 가져가서 프랑클론 포지라이트의 석상에 두어야 합니다."
Lang["Q1_5096"] = "붉은십자군의 주의 끌기"
Lang["Q2_5096"] = "펠스톤 농장과 달슨의 눈물 사이에 있는 붉은십자군의 야영지로 가서 지휘 막사를 파괴하십시오."
Lang["Q1_5098"] = "감시탑 공격 준비"
Lang["Q2_5098"] = "신호 횃불로 안돌할의 각 탑을 표시해야 합니다. 성공적으로 표시하려면 탑의 입구에 서야 합니다."
Lang["Q1_838"] = "스칼로맨스"
Lang["Q2_838"] = "서부 역병지대의 보루에 있는 연금술사 디더스와 대화하십시오."
Lang["Q1_964"] = "뼈조각"
Lang["Q2_964"] = "서부 역병지대의 보루에 있는 연금술사 디더스에게 뼈조각 15개를 가져가야 합니다."
Lang["Q1_5514"] = "거푸집과 뼈조각"
Lang["Q2_5514"] = "가젯잔에 있는 크린클 굿스틸에게 15골드와 함께 마력 깃든 뼈조각을 가져가야 합니다."
Lang["Q1_5802"] = "불기둥 용광로"
Lang["Q2_5802"] = "운고로 분화구에 있는 불기둥 마루 꼭대기로 해골 열쇠 거푸집과 토륨 주괴 2개를 가져가야 합니다. 용암의 강에서 해골 열쇠 거푸집으로 불완전한 해골 열쇠를 만들어야 합니다."
Lang["Q1_5804"] = "아라즈의 스카라베"
Lang["Q2_5804"] = "소환사 아라즈를 처치하고 아라즈의 스카라베를 서부 역병지대에 보루에 있는 연금술사 디더스에게 돌아가야 합니다."
Lang["Q1_5511"] = "스칼로맨스로 가는 열쇠"
Lang["Q2_5511"] = "음, 완성된 해골 열쇠를 가지고 도착했군. 이거라면 분명 스칼로맨서 안으로 들어갈 수 있을 거라고 확신하네."
Lang["Q1_5092"] = "통로 확보"
Lang["Q2_5092"] = "슬픔의 언덕에 있는 해골 타작꾼 10마리와 걸신들린 구울 10마리를 처치해야 합니다."
Lang["Q1_5097"] = "감시탑 공격 준비"
Lang["Q2_5097"] = "신호 횃불로 안돌할의 각 탑을 표시해야 합니다. 성공적으로 표시하려면 탑의 입구에 서야 합니다."
Lang["Q1_5533"] = "스칼로맨스"
Lang["Q2_5533"] = "서부 역병지대의 서리바람 거점에 있는 연금술사 알빙턴과 대화해야 합니다."
Lang["Q1_5537"] = "뼈조각"
Lang["Q2_5537"] = "서부 역병지대에 서리바람 거점에 있는 연금술사 알빙턴에게 뼈조각 15개를 가져가야 합니다."
Lang["Q1_5538"] = "거푸집과 뼈조각"
Lang["Q2_5538"] = "가젯잔에 있는 크린클 굿스틸에게 15골드와 함께 마력 깃든 뼈조각을 가져가야 합니다."
Lang["Q1_5801"] = "불기둥 용광로"
Lang["Q2_5801"] = "운고로 분화구에 있는 불기둥 마루 꼭대기로 해골 열쇠 거푸집과 토륨 주괴 2개를 가져가야 합니다. 용암의 강에서 해골 열쇠 거푸집으로 불완전한 해골 열쇠를 만들어야 합니다."
Lang["Q1_5803"] = "아라즈의 스카라베"
Lang["Q2_5803"] = "소환사 아라즈를 처치하고 아라즈의 스카라베를 서부 역병지대의 서리바람 거점에 있는 연금술사 알빙턴에게 돌아가야 합니다."
Lang["Q1_5505"] = "스칼로맨스로 가는 열쇠"
Lang["Q2_5505"] = "음, 완성된 해골 열쇠를 가지고 도착했군. 이거라면 분명 스칼로맨서 안으로 들어갈 수 있을 거라고 확신하네."
--v250
Lang["Q1_6804"] = "독이 든 물"
Lang["Q2_6804"] = "동부 역병지대에 있는 역병에 걸린 정령들에게 넵튤론의 상을 사용하십시오. 아즈샤라에 있는 군주 히드락시스에게 불협의 팔보호구 12개와 넵튤론의 상을 가져가야 합니다."
Lang["Q1_6805"] = "먼지 폭풍과 우레의 모래정령"
Lang["Q2_6805"] = "먼지 폭풍 15마리와 우레의 모래정령 15마리를 처치하고 아즈샤라에 있는 군주 히드락시스에게 돌아가야 합니다."
Lang["Q1_6821"] = "엠버시어의 눈"
Lang["Q2_6821"] = "아즈샤라에 있는 군주 히드락시스에게 엠버시어의 눈을 가져가야 합니다."
Lang["Q1_6822"] = "화산 심장부"
Lang["Q2_6822"] = "불의 군주 1마리, 용암거인 1마리, 고대의 심장부 사냥개 1마리, 굽이치는 용암 정령 1마리를 처치한 후 아즈샤라에 있는 군주 히드락시스에게 돌아가야 합니다."
Lang["Q1_6823"] = "히드락시스의 하수인"
Lang["Q2_6823"] = "히드락시스 물의 군주들로부터 우호적인 평판을 얻은 후 아즈샤라에 있는 군주 히드락시스와 대화해야 합니다."
Lang["Q1_6824"] = "적의 손"
Lang["Q2_6824"] = "아즈샤라에 있는 군주 히드락시스에게 루시프론, 설퍼론, 게헨나스, 샤즈라의 손을 가져가야 합니다."
Lang["Q1_7486"] = "영웅의 보상"
Lang["Q2_7486"] = "히드락시스의 궤짝에 든 보상을 차지하십시오."
--v254
Lang["Q1_11481"] = "태양샘의 위기"
Lang["Q2_11481"] = "샤트라스의 알도르 마루에 있는 빛의 수호자 아드옌이 태양샘 고원으로 가서 라레소르와 이야기해 달라고 부탁했습니다."
Lang["Q1_11488"] = "마법학자의 정원"
Lang["Q2_11488"] = "무너진 태양 집결지에 있는 총독 라레소르가 마법학자의 정원에서 블러드 엘프 첩보원인 티리스를 찾아봐 달라고 부탁했습니다."
Lang["Q1_11490"] = "점술가의 수정구"
Lang["Q2_11490"] = "티리스가 마법학자의 정원 발코니에서 수정구를 사용해 달라고 부탁했습니다."
Lang["Q1_11492"] = "어려운 상대"
Lang["Q2_11492"] = "칼렉고스가 마법학자의 정원에 있는 캘타스를 처치해 달라고 부탁했습니다. 캘타스의 머리카락을 가지고 무너진 태양 집결지에 있는 총독 라레소르에게 보고해야 합니다."


--WOTLK QUESTS
-- The ids are Q1_<QuestId> and Q2_<QuestId>
-- Q1 is just the title of the quest
-- Q2 is the description/synopsis, with some helpful comments in between \n\n|cff33ff99 and |r
Lang["Q1_12892"] = "즐거운 장난"
Lang["Q2_12892"] = "왕의 눈을 파괴하고 어둠의 무기고에 있는 남작 슬리버에게 보고해야 합니다."
Lang["Q1_12887"] = "즐거운 장난"
Lang["Q2_12887"] = "왕의 눈을 파괴하고 어둠의 무기고에 있는 남작 슬리버에게 보고해야 합니다."
Lang["Q1_12891"] = "좋은 생각은 있지만, 일단..."
Lang["Q2_12891"] = "어둠의 무기고에 있는 남작 슬리버가 이교도 지팡이와 누더기골렘 고리, 외눈깨비 밧줄과 스컬지 정수 5개를 구해달라고 부탁했습니다.\n\n|cff33ff99무기고 주위 살펴보기|r"
Lang["Q1_12893"] = "실력 발휘"
Lang["Q2_12893"] = "어둠의 무기고에 있는 남작 슬리버가 군주의 지팡이를 썩은내, 여군주 나이츠우드, 껑충이 시체에 사용해 달라고 했습니다."
Lang["Q1_12897"] = "마음을 돌릴 수 없다면"
Lang["Q2_12897"] = "장군 라이츠베인을 무찌르고 비행포격선인 오그림의 망치호에 있는 콜티라 데스위버에게 돌아가 승전보를 알려야 합니다."
Lang["Q1_12896"] = "마음을 돌릴 수 없다면"
Lang["Q2_12896"] = "장군 라이츠베인을 무찌르고 비행포격선인 하늘파괴자호에 있는 타사리안에게 돌아가 승전보를 알려야 합니다."
Lang["Q1_12899"] = "어둠의 무기고"
Lang["Q2_12899"] = "어둠의 무기고에 있는 남작 슬리버에게 돌아가 보고해야 합니다."
Lang["Q1_12898"] = "어둠의 무기고"
Lang["Q2_12898"] = "어둠의 무기고에 있는 남작 슬리버에게 돌아가 보고해야 합니다."
Lang["Q1_11978"] = "맞아들일 준비"
Lang["Q2_11978"] = "용의 안식처의 서풍의 피난민 행렬에 있는 사절 브라이트후프가 호드 장비 10개를 모아달라고 부탁했습니다."
Lang["Q1_11983"] = "호드의 피의 맹세"
Lang["Q2_11983"] = "서풍의 피난민 행렬에 있는 타운카들과 대화하여 5명의 타운카에게서 호드에 대한 충성을 다짐받아야 합니다."
Lang["Q1_12008"] = "아그마르의 망치"
Lang["Q2_12008"] = "용의 안식처의 아그마르의 망치에서 대군주 아그마르와 대화해야 합니다.\n\n|cff33ff99주둔지(38.1, 46.3) 안에 있습니다.|r"
Lang["Q1_12034"] = "눈앞의 승리"
Lang["Q2_12034"] = "아그마르의 망치에 있는 정예수호병 주크토크과 대화해야 합니다.\n\n|cff33ff99중앙(36.6, 46.6)에 있습니다.|r"
Lang["Q1_12036"] = "아졸네룹의 심연에서"
Lang["Q2_12036"] = "나르준의 구덩이를 조사한 다음 아그마르의 망치에 있는 정예수호병 주크토크에게 돌아가야 합니다.\n\n|cff33ff99입구는 앙그마르의 망치 서쪽(26.2, 49.6)에 있습니다. 구멍으로 빠지세요.|r"
Lang["Q1_12053"] = "호드의 힘"
Lang["Q2_12053"] = "아그마르의 망치에 있는 정예수호병 주크토크가 얼음안개 마을에서 전쟁노래부족 전투 깃발을 땅에 꽂은 다음, 공격자들로부터 깃발을 보호해 달라고 부탁했습니다.\n\n|cff33ff99깃발을 (25.2, 24.8) 주위에 꽂으세요.|r"
Lang["Q1_12071"] = "공습!"
Lang["Q2_12071"] = "아그마르의 망치에 있는 발노크 윈드레이저와 대화해야 합니다."
Lang["Q1_12072"] = "파멸충 박멸!"
Lang["Q2_12072"] = "얼음안개 마을에서 발노크의 신호용 권총을 사용해 코르크론 전투와이번을 소환하여 올라탄 다음 아눕아르 파멸충 25마리를 처치해야 합니다!\n\n|cff33ff99마을 근처 하부 폭포에 약간 있으며, 큰 폭포 주위에 많습니다.|r"
Lang["Q1_12063"] = "아이스미스트의 힘"
Lang["Q2_12063"] = "얼음안개 마을에서 반토크 아이스미스트를 찾아야 합니다.\n\n|cff33ff99그는 물가 동굴(22.7, 41.6)에 있습니다.|r"
Lang["Q1_12064"] = "아눕아르의 사슬"
Lang["Q2_12064"] = "용의 안식처의 얼음안개 마을에 있는 반토크 아이스미스트가 아녹라의 열쇠 조각, 티바스의 열쇠 조각, 시노크의 열쇠 조각을 가져와 달라고 부탁했습니다.\n\n|cff33ff99건물 내부에 있습니다. 티바스는 (26.7, 39.0), 시노크는 (24.3, 44.2) 그리고 아녹라는 시녹크 아래(24.9, 43.9)에 있음.|r"
Lang["Q1_12069"] = "대족장의 귀환"
Lang["Q2_12069"] = "아눕아르 감옥 열쇠를 사용해 대족장 아이스미스트를 풀어주고 그를 도와 악마왕 아눕에칸을 처치해야 합니다.\n\n|cff33ff99대족장은 마법 감옥(25.3, 40.9)에 갇혀있습니다.|r"
Lang["Q1_12140"] = "로아나우크를 맞이하라!"
Lang["Q2_12140"] = "아그마르의 망치에서 로아나우크 아이스미스트를 찾아 그를 호드 군대의 일원으로 받아들이고 지도자로 임명해야 합니다."
Lang["Q1_12189"] = "온통 바보들뿐이야!"
Lang["Q2_12189"] = "용의 안식처에 있는 원한의 초소로 가서 고위 역병인도자 미들턴과 대화해야 합니다.\n\n|cff33ff99건물(77.7, 62.8) 안에 있습니다.|r"
Lang["Q1_12188"] = "포세이큰 파멸의 역병과 당신: 죽지 않는 비결"
Lang["Q2_12188"] = "용의 안식처에 있는 원한의 초소의 고위 역병인도자 미들턴이 심령체 잔류물 10개를 가져와 달라고 부탁했습니다."
Lang["Q1_12200"] = "에메랄드 용의 눈물"
Lang["Q2_12200"] = "용의 안식처에 있는 원한의 초소의 고위 역병인도자 미들턴이 에메랄드 용의 눈물 8개를 가져와 달라고 부탁했습니다.\n\n|cff33ff99눈물은 (63.5, 71.9) 땅에 박힌 녹색 보석처럼 생겼음.|r"
Lang["Q1_12218"] = "희소식 전파"
Lang["Q2_12218"] = "용의 안식처의 원한의 초소에 있는 고위 역병인도자 미들턴이 포세이큰 파멸의 역병 살포기의 파멸의 역병탄을 사용해 부패의 벌판 주변에 있는 굶주린 망자 30마리를 처치해 달라고 부탁했습니다."
Lang["Q1_12221"] = "포세이큰 파멸의 역병"
Lang["Q2_12221"] = "아그마르의 망치에 있는 의술사 신타르 말레피오스에게 포세이큰 파멸의 역병을 전달해야 합니다."
Lang["Q1_12224"] = "코르크론 선봉기지로!"
Lang["Q2_12224"] = "코르크론 선봉기지에 있는 사울팽의 아들에게 보고해야 합니다.\n\n|cff33ff99그는 (40.7, 18.2)에 있음.|r"
Lang["Q1_12496"] = "용의 여왕 알현"
Lang["Q2_12496"] = "용의 안식처에 있는 고룡쉼터 사원에서 생명의 어머니 알렉스트라자를 찾아야 합니다.\n\n|cff33ff99타리올스트라즈(57.9, 54.2)와 대화하여 탑 꼭대기로 이동. 그녀는 인간형 모습으로 있습니다 (59.8, 54.7).|r"
Lang["Q1_12497"] = "갈라크론드와 스컬지"
Lang["Q2_12497"] = "용의 안식처에 있는 고룡쉼터 사원의 토라스트라자와 대화해야 합니다."
Lang["Q1_12498"] = "루비의 날개 위에"
Lang["Q2_12498"] = "황무지 청소부 30마리를 처치하고 안티오크의 낫을 되찾아야 합니다. 임무를 마친 다음, 고룡쉼터 사원에 있는 생명의 어머니 알렉스트라자에게 돌아가십시오.\n\n|cff33ff99북쪽 (56.8, 33.3)에 있습니다. 안티오크의 낫 수집을 잊지 마세요 (54.6, 31.4).|r"
Lang["Q1_12500"] = "앙그라타르로 귀환"
Lang["Q2_12500"] = "코르크론 선봉기지에 있는 사울팽의 아들에게 돌아가, 스컬지에 대항해 승리를 거두었음을 알려야 합니다.\n\n|cff33ff99영상을 즐기세요! ^^|r"
Lang["Q1_13242"] = "어둠의 물결"
Lang["Q2_13242"] = "전장에서 사울팽의 전투 갑옷을 찾아 북풍의 땅 전쟁노래부족 요새에 있는 대군주 사울팽에게 돌려줘야 합니다."
Lang["Q1_13257"] = "전쟁의 사자"
Lang["Q2_13257"] = "오그리마의 그롬마쉬 요새에 있는 스랄에게 보고해야 합니다.\n\n|cff33ff99영상을 즐기세요! ^^|r"
Lang["Q1_13266"] = "후회 없는 삶"
Lang["Q2_13266"] = "그롬마쉬 요새에 있는 차원의 문을 타고 언더시티로 가 볼진에게 보고해야 합니다."
Lang["Q1_13267"] = "언더시티 수복 작전"
Lang["Q2_13267"] = "스랄과 실바나스를 도와 호드의 언더시티를 되찾아야 합니다."
Lang["Q1_12235"] = "윈터가드 성채와 낙스라마스"
Lang["Q2_12235"] = "윈터가드 성채의 그리핀 기지에 있는 그리핀 사령관 우릭과 이야기해야 합니다."
Lang["Q1_12237"] = "윈터가드 수호병의 비행"
Lang["Q2_12237"] = "무력한 윈터가드 주민 10명을 구해 윈터가드 성채의 그리핀 사령관 우릭에게 돌아가야 합니다."
Lang["Q1_12251"] = "총사령관에게 돌아가기"
Lang["Q2_12251"] = "용의 안식처에 있는 윈터가드 성채의 총사령관 할포드 웜베인과 대화해야 합니다."
Lang["Q1_12253"] = "마을 주민 구출 작전"
Lang["Q2_12253"] = "용의 안식처에 있는 윈터가드 성채의 총사령관 할포드 웜베인이 갇혀 있는 윈터가드 주민 6명을 구출해 달라고 부탁했습니다."
Lang["Q1_12309"] = "드류콘을 찾아라!"
Lang["Q2_12309"] = "용의 안식처에 있는 윈터가드 납골당에서 기병 드류콘을 찾아야 합니다.\n\n|cff33ff99납골당 바로 앞에 있습니다 (79.0, 53.2).|r"
Lang["Q1_12311"] = "귀족의 납골당"
Lang["Q2_12311"] = "윈터가드 성채에 있는 기병 드류콘이 강령군주 아마리온을 처치해 달라고 부탁했습니다.\n\n|cff33ff99납골당 맨 아래층에 있습니다.|r"
Lang["Q1_12275"] = "폭파전문노움 슬린킨"
Lang["Q2_12275"] = "용의 안식처에 있는 윈터가드 성채의 공성 기술자 쿼터플래쉬와 대화해야 합니다.\n\n|cff33ff99그는 그리폰 근처에 있습니다 (77.8, 50.3).|r"
Lang["Q1_12276"] = "슬린킨을 찾아서"
Lang["Q2_12276"] = "윈터가드 광산에서 폭파전문노움 슬린킨을 찾아야 합니다. 광산을 찾는 데 도움이 필요하면 쿼터플래쉬의 유도 로봇을 사용하십시오.\n\n|cff33ff99로봇은 빠르게 움직임. 필요 시 말을 타세요.\n맨 아래 입구를 통해 동굴(81.5, 42.2)로 진입하세요. 우측벽을 따라 움직이면 찾을 수 있음.|r"
Lang["Q1_12277"] = "운에 기대지 말라"
Lang["Q2_12277"] = "윈터가드 광산 폭탄을 입수하여 윈터가드 광산 위쪽 입구와 윈터가드 광산 아래쪽 입구를 폭파하고, 용의 안식처에 있는 윈터가드 성채의 공성 기술자 쿼터플래쉬에게 보고해야 합니다.\n\n|cff33ff99시체에서 우측 방향으로 돌면 폭발물이 있습니다 (80.7, 41.3).|r"
Lang["Q1_12325"] = "적진으로"
Lang["Q2_12325"] = "그리핀 사령관 우릭과 대화하여 토르손의 전초기지로 가는 이동 수단을 얻은 후, 용의 안식처에 있는 토르손의 전초기지에 도착하면 대공 어거스트 포해머에게 보고해야 합니다.\n\n|cff33ff99그리폰 조련사와 대화하지 마시고 바로 그리폰을 타세요.|r"
Lang["Q1_12312"] = "스컬지의 비밀"
Lang["Q2_12312"] = "용의 안식처에 있는 윈터가드 성채의 기병 드류콘에게 살점달린 고서를 전달해야 합니다."
Lang["Q1_12319"] = "고서의 비밀"
Lang["Q2_12319"] = "용의 안식처에 있는 윈터가드 성채의 총사령관 할포드 웜베인에게 살점달린 고서를 가져가야 합니다."
Lang["Q1_12320"] = "죽음의 언어 이해하기"
Lang["Q2_12320"] = "윈터가드 성채 감옥에 있는 심문관 할라드에게 살점달린 고서를 가져가야 합니다.\n\n|cff33ff99감옥은 큰 병영 건물내에 있습니다.\n안마당에서 아래층으로 내려가는 계단을 내려가세요. 할라드는 (76.7, 47.4)에 있음.|r"
Lang["Q1_12321"] = "정의로운 설교"
Lang["Q2_12321"] = "심문관 할라드의 설교가 끝날 때까지 기다렸다가 알아낸 정보를 가지고 용의 안식처에 있는 윈터가드 성채의 총사령관 할포드 웜베인에게 돌아가야 합니다."
Lang["Q1_12272"] = "피 흘리는 광석"
Lang["Q2_12272"] = "용의 안식처에 있는 윈터가드 성채의 공성 기술자 쿼터플래쉬가 윈터가드 광산에서 괴상한 광석 10개를 회수해 달라고 부탁했습니다."
Lang["Q1_12281"] = "스컬지 전쟁 기계 이해"
Lang["Q2_12281"] = "쿼터플래쉬의 꾸러미를 윈터가드 성채에 있는 총사령관 할포드 웜베인에게 전달해야 합니다."
Lang["Q1_12326"] = "증기 전차 작전"
Lang["Q2_12326"] = "얼라이언스 증기 전차를 사용해 역병 수레 6대를 파괴한 다음 7군단 정예병을 윈터가드 묘지로 데려가는 임무를 마친 후, 용의 안식처에 있는 윈터가드 묘지에서 앰보 캐시와 대화해야 합니다.\n\n|cff33ff99묘지 위치 (85.9, 50.8), 엠보 캐시는 안에 있습니다.|r"
Lang["Q1_12455"] = "바람 속에 흩어지다"
Lang["Q2_12455"] = "용의 안식처에 있는 윈터가드 묘지의 앰보 캐시가 윈터가드 군수품 8개를 가져와 달라고 부탁했습니다.\n\n|cff33ff99묘지 밖, 묘지 주위에 있습니다.|r"
Lang["Q1_12457"] = "퇴로를 뚫어라"
Lang["Q2_12457"] = "용의 안식처에 있는 윈터가드 묘지의 앰보 캐시가 부상당한 7군단 병사 8명을 구조해 달라고 부탁했습니다.\n\n|cff33ff99병사들은 항상 방 뒤쪽에서 생성되니 대포로 근처를 정리하세요.|r"
Lang["Q1_12463"] = "플런더비어드를 찾아라!"
Lang["Q2_12463"] = "용의 안식처에 있는 윈터가드 묘지의 앰보 캐시가 플런더비어드를 찾아달라고 부탁했습니다.\n\n|cff33ff99그는 방 끝 구석에 있습니다 (84.2, 54.7).|r"
Lang["Q1_12465"] = "플런더비어드의 일지"
Lang["Q2_12465"] = "플런더비어드의 일지 제4장, 플런더비어드의 일지 제5장, 플런더비어드의 일지 제6장, 플런더비어드의 일지 제7장을 찾아 용의 안식처에 있는 윈터가드 묘지의 앰보 캐시에게 가져가야 합니다.\n\n|cff33ff99플런더비어드에서 시작하여 터널길을 따라 이동하면 모두 처치/발견 가능합니다.|r"
Lang["Q1_12466"] = "얼음폭풍 추적: 7군단 전초지"
Lang["Q2_12466"] = "용의 안식처 중심부의 7군단 전초지에 있는 군단 사령관 티랄리온에게 보고해야 합니다.\n\n|cff33ff99전초지 위치는 (64.7, 27.9)|r"
Lang["Q1_12467"] = "얼음폭풍 추적: 텔잔의 성물함"
Lang["Q2_12467"] = "얼음폭풍에게서 텔잔의 성물함을 되찾아 윈터가드 성채에 있는 총사령관 할포드 웜베인에게 가져가야 합니다."
Lang["Q1_12472"] = "최후"
Lang["Q2_12472"] = "텔잔의 성물함을 용의 안식처에 있는 윈터가드 묘지의 군단 사령관 요릭에게 가져가야 합니다.\n\n|cff33ff99터널 입구는 (82.0, 50.7)에 있습니다.|r"
Lang["Q1_12473"] = "끝과 시작"
Lang["Q2_12473"] = "황혼의 인도자 텔잔을 처치한 다음 용의 안식처에 있는 윈터가드 성채의 총사령관 할포드 웜베인에게 보고해야 합니다.\n\n|cff33ff99혹시 전투중 사망하게 된다면 NPC가 싸움을 끝낼 수 있으니 대기하세요.|r"
Lang["Q1_12474"] = "폴드라곤 요새로!"
Lang["Q2_12474"] = "용의 안식처에 있는 폴드라곤 요새로 이동하여 대영주 볼바르 폴드라곤과 대화해야 합니다.\n\n|cff33ff99그는 맨 꼭대기 (37.8, 23.4)에 있습니다.|r"
Lang["Q1_12495"] = "용의 여왕 알현"
Lang["Q2_12495"] = "용의 안식처에 있는 고룡쉼터 사원에서 생명의 어머니 알렉스트라자를 찾아야 합니다.\n\n|cff33ff99타리올스트라즈(57.9, 54.2)와 대화하여 탑 꼭대기로 이동. 그녀는 인간형 모습으로 있습니다 (59.8, 54.7).|r"
Lang["Q1_12499"] = "앙그라타르로 귀환"
Lang["Q2_12499"] = "폴드라곤 요새에 있는 대영주 볼바르 폴드라곤에게 돌아가, 스컬지에 대항해 승리를 거두었음을 알려야 합니다."
Lang["Q1_13347"] = "잿더미로부터의 환생"
Lang["Q2_13347"] = "분노의 관문 앙그라타르의 전장에서 폴드라곤의 방패를 찾아 스톰윈드 왕궁에 있는 국왕 바리안 린에게 돌려줘야 합니다."
Lang["Q1_13369"] = "의지와 맞서는 운명"
Lang["Q2_13369"] = "칼림도어 대륙에 있는 오그리마에서 여군주 제이나 프라우드무어를 도와 호드의 대족장 스랄과 대화해야 합니다."
Lang["Q1_13370"] = "왕실 쿠데타"
Lang["Q2_13370"] = "그롬마쉬 요새의 차원문을 통해 스톰윈드 왕실로 돌아가 스랄의 전갈을 국왕 바리안 린에게 전해야 합니다."
Lang["Q1_13371"] = "시간 보내기"
Lang["Q2_13371"] = "스톰윈드 왕실 안에서 언더시티로 가는 차원문을 통해 언더시티로 이동한 다음, 브롤 비어맨틀에게 보고해야 합니다."
Lang["Q1_13377"] = "언더시티 함락 작전"
Lang["Q2_13377"] = "국왕 바리안 린과 여군주 제이나 프라우드무어가 정의의 이름으로 대연금술사 퓨트리스를 심판하도록 도운 다음, 국왕 바리안 린에게 보고해야 합니다."
--WOTLK Sons of Hodir
Lang["Q1_12843"] = "남자가 모자라!"
Lang["Q2_12843"] = "시프렐다르 마을로 가 고블린 포로 5명을 구출한 후 그레첸 피즐스파크에게 돌아가야 합니다.\n\n|cff33ff99마을(41.4, 70.6)로 가서, 거인들을 처치하여 감옥 열쇠를 얻은 후 주변의 감옥에서 남자들을 풀어주세요.|r"
Lang["Q1_12846"] = "한 명도 포기할 수 없다"
Lang["Q2_12846"] = "시프렐다르 마을 북부에서 쓸쓸한 광산의 입구를 찾아, 지브 피즐스파크의 행방에 관한 단서를 찾아야 합니다.\n\n|cff33ff99동굴 입구는 마을(42.1, 69.5)에 있습니다. 동굴 안에 거미가 보인다면 잘못 가셨습니다.|r"
Lang["Q1_12841"] = "마녀의 제안"
Lang["Q2_12841"] = "쓸쓸한 광산 안에 있는 마녀 로크리라가 감독관 시라를 처치하고 이르크빈의 룬을 되찾아 달라고 부탁했습니다.\n\n|cff33ff99시라는 광산 안 측면을 배회합니다.|r"
Lang["Q1_12905"] = "무자비한 밀드레드"
Lang["Q2_12905"] = "쓸쓸한 광산 안에서 무자비한 밀드레드와 대화해야 합니다.\n\n|cff33ff99밀드레드는 광산 안쪽 플렛폼에 서 있습니다.|r"
Lang["Q1_12906"] = "규율"
Lang["Q2_12906"] = "쓸쓸한 광산에 있는 지친 브리쿨 6명에게 규율의 지팡이를 사용한 다음 무자비한 밀드레드에게 돌아가야 합니다."
Lang["Q1_12907"] = "본보기"
Lang["Q2_12907"] = "쓸쓸한 광산에 있는 무자비한 밀드레드가 가르할을 처치해 달라고 부탁했습니다.\n\n|cff33ff99그는 광산 안쪽에 있으며, 전투 시 주위에서 도와줍니다.|r"
Lang["Q1_12908"] = "어떤 죄수"
Lang["Q2_12908"] = "쓸쓸한 광산에 있는 마녀 로크리라에게 밀드레드의 열쇠를 가져가야 합니다."
Lang["Q1_12921"] = "다른 무대에서"
Lang["Q2_12921"] = "브룬힐다르 마을에서 마녀 로크리라를 다시 만나야 합니다."
Lang["Q1_12969"] = "네가 찾는 그 고블린인가?"
Lang["Q2_12969"] = "지브 피즐스파크를 구하려면 아그네타 티르스도타르를 상대해야 합니다. 성공한 후 브룬힐다르 마을에 있는 마녀 로크리라에게 돌아가십시오."
Lang["Q1_12970"] = "힐드스미트"
Lang["Q2_12970"] = "로크리라의 제안을 들어봐야 합니다.\n\n|cff33ff99쭉 대화를 끝까지 이어가세요.|r"
Lang["Q1_12971"] = "상대해야 할 도전자들"
Lang["Q2_12971"] = "브룬힐다르 마을에 있는 마녀 로크리라가 승리한 도전자 6명과 싸워 이기라고 부탁했습니다.\n\n|cff33ff99비전투 중인 도전자들과 대화를 하고 전투해서 이기세요.|r"
Lang["Q1_12972"] = "곰이 필요한 일"
Lang["Q2_12972"] = "브룬힐다르 마을 밖에 있는 브리야나와 대화해야 합니다.\n\n|cff33ff99브리야나는 (53.1, 65.7)에 있음.|r"
Lang["Q1_12851"] = "곰을 타고"
Lang["Q2_12851"] = "얼음송곳니를 타고 고대의 겨울 계곡에서 서리 검은늑대 7마리와 서리 거인 15명을 쏘아 맞힌 후, 브룬힐다르 마을에 있는 브리야나에게 돌아가야 합니다."
Lang["Q1_12856"] = "얼음 감옥"
Lang["Q2_12856"] = "브룬힐다르 마을의 동쪽에 있는 브리야나가 던 니펠렘으로 날아가 사로잡힌 원시비룡 3마리를 풀어주고, 브룬힐다르 포로 9명을 구출해 달라고 부탁했습니다.\n\n|cff33ff99날아서 (64.3, 61.5) 위치로 갈아서 쇠사슬에 묶인 원시비룡을 타세요. 3번 얼음덩이 갇힌 사람들을 공격 뒤에 풀어준 후 다시 돌아갔다가 3번 더 해서 총 9명 구출합시다.|r"
Lang["Q1_13063"] = "가치 증명"
Lang["Q2_13063"] = "브리야나가 브룬힐다르 마을로 돌아가서 아스트리드 비요른리타와 대화하라고 했습니다.\n\n|cff33ff99아스트리드는 집(49.7, 71.8) 안에 있습니다.|r"
Lang["Q1_12900"] = "고삐 만들기"
Lang["Q2_12900"] = "얼음갈기 설인 가죽 3개를 모아 브룬힐다르 마을의 아스트리드 비요른리타에게 가져가야 합니다."
Lang["Q1_12983"] = "동족의 마지막 존재"
Lang["Q2_12983"] = "브룬힐다르 마을에 있는 아스트리드 비요른리타가 겨울 동굴에서 얼음아귀 우두머리를 구출해 달라고 부탁했습니다.\n\n|cff33ff99동굴 입구는 (55.9, 64.3). 우측벽면을 따라가면 우두머리 바로 발견할 수 있습니다.|r"
Lang["Q1_12996"] = "사전 연습"
Lang["Q2_12996"] = "브룬힐다르 마을에 있는 아스트리드 비요른리타가 우두머리 전투곰 고삐를 사용하여 키르가라아크를 무찔러 달라고 부탁했습니다.\n\n|cff33ff99쿨마다 후려치기(4), 돌진이 준비되면 넉백(5) 하고 돌진(6). 곰이 도중이 죽을 경우, 직접 처치하여도 퀘 진행에 반영됩니다.|r"
Lang["Q1_12997"] = "구덩이 속으로"
Lang["Q2_12997"] = "브룬힐다르 마을에 있는 아스트리드 비요른리타가 송곳니 구덩이 안에서 우두머리 전투곰 고삐를 사용하여 6마리의 힐드스미트 전투곰을 처치해 달라고 부탁했습니다."
Lang["Q1_13061"] = "영광의 서곡"
Lang["Q2_13061"] = "브룬힐다르 마을에 있는 마녀 로크리라와 대화해야 합니다."
Lang["Q1_13062"] = "로크리라의 이별 선물"
Lang["Q2_13062"] = "브룬힐다르 마을에 있는 중재자 그레타와 대화해야 합니다."
Lang["Q1_12886"] = "드라켄스리드"
Lang["Q2_12886"] = "힐드니르 작살을 사용해 폭풍의 신전에서 힐드스미트 비룡기수 10명을 처치해야 합니다. 힐드니르 작살을 기둥 장식에 사용하여 드라켄스리드에서 빠져나온 다음 토림과 대화하십시오.\n\n|cff33ff99작살로 원시비룡을 공격하여 다른 원시비룡으로 올라타고 NPC를 처치합니다. 10번을 처치한 후, 기둥에 보이는 장식(흰색 등)에 작살을 날리면 정상 땅에 안착할 수 있습니다.|r"
Lang["Q1_13064"] = "형제의 경쟁"
Lang["Q2_13064"] = "토림이 그의 이야기를 들어달라고 부탁했습니다."
Lang["Q1_12915"] = "마음의 벽 허물기"
Lang["Q2_12915"] = "던 니펠렘 동쪽에 있는 피요른의 모루에서 폭풍으로 벼려낸 무쇠 거인 5마리와 피요른을 처치하고, 폭풍의 신전에 있는 토림에게 돌아가야 합니다.\n\n|cff33ff99폭풍이 봉우리 동쪽 끝 (76.9, 63.2) 모루로 날라간 후 땅에서 화강암을 집으세요. 토림의 대지 부적을 사용하여 토석인들을 탱커로 활용합니다.\n한 번 전투를 치룬 후 새 화강암(화강암 소모품)이 필요하며 최소 6개를 집은 후 진행하세요.|r"
Lang["Q1_12922"] = "제련의 불꽃"
Lang["Q2_12922"] = "서리평원 호수의 소용돌이치는 망령에게서 성난 불꽃 10개를 모아 피요른의 모루에서 사용해야 합니다."
Lang["Q1_12956"] = "희망의 불꽃"
Lang["Q2_12956"] = "제련되어 빛나는 금속을 폭풍의 신전에 있는 토림에게 가져가야 합니다."
Lang["Q1_12924"] = "동맹 맺기"
Lang["Q2_12924"] = "던 니펠렘에 있는 제왕 요쿰에게 토림의 방어구를 재련해 달라고 부탁해야 합니다. 요쿰의 일을 마치고 던 니펠렘에 있는 요르멜드에게 돌아가야 합니다.\n\n|cff33ff99제왕은 던니펠름 중앙에 있습니다 (65.4, 60.1).\n\n퀘 완료는 요르멜드(63.2, 63.3)에게 합니다..|r"
Lang["Q1_13009"] = "새로운 시작"
Lang["Q2_13009"] = "요르멜드가 폭풍의 신전에 있는 토림에게 재련된 폭풍군주의 갑옷을 가져가 달라고 부탁했습니다."
Lang["Q1_13050"] = "베라누스"
Lang["Q2_13050"] = "폭풍의 신전에 있는 토림이 브룬힐다르 마을 근처에 있는 봉우리에서 작은 원시비룡 알 5개를 가져다 달라고 부탁했습니다.\n\n|cff33ff99다양한 둥지가 있습니다. 예를 들어, (52.5, 73.4)처럼.|r"
Lang["Q1_13051"] = "영역 침범"
Lang["Q2_13051"] = "폭풍의 신전에 있는 토림이 여왕 둥지 꼭대기에 가서 훔친 원시용 알을 놓아 달라고 부탁했습니다.\n\n|cff33ff99둥지 위치 (38.7, 65.5). 알을 내려놓고, 토림이 베라누스 위에 올라타는 것을 기다리세요.|r"
Lang["Q1_13010"] = "폭풍의 망치, 크롤미르"
Lang["Q2_13010"] = "토림이 던 니펠렘에 있는 제왕 요쿰과 대화하여 크롤미르에 대해서 알고 있는 사실을 확인해 달라고 부탁했습니다.\n\n|cff33ff99요쿰과 대화하기 위해 호디르 평판이 약간 모자를 수 있습니다. 호디르 평판 일퀘 2개 정도 완료하세요.|r"
Lang["Q1_12966"] = "놓쳐서는 안 된다"
Lang["Q2_12966"] = "던 니펠렘에 있는 제왕 요쿰이 피요른의 모루에 있는 요르멜드를 찾아보라고 했습니다."
Lang["Q1_12967"] = "정령과 한판 승부"
Lang["Q2_12967"] = "요르멜드가 스노리와 함께 피요른의 모루로 가서 소용돌이치는 망령 10마리를 처치하라고 했습니다."
Lang["Q1_12975"] = "평화의 기념비"
Lang["Q2_12975"] = "천둥 골짜기에서 뿔피리 조각 8개를 찾아 던 니펠렘에 있는 제왕 요쿰에게 가져가야 합니다.\n\n|cff33ff99지역(71.6, 48.9)에서 눈 사이로 보이는 회색빛 조각입니다.|r"
Lang["Q1_12976"] = "쓰러진 자들을 위한 기념비"
Lang["Q2_12976"] = "제왕 요쿰이 던 니펠렘에 있는 요르멜드에게 호디르의 뿔피리 조각을 가져가 달라고 부탁했습니다."
Lang["Q1_13011"] = "요르무타르의 비대함"
Lang["Q2_13011"] = "던 니펠렘에 있는 제왕 요쿰이 겨울 동굴에 있는 요르무타르를 처치해 달라고 부탁했습니다.\n\n|cff33ff99동굴로 진입한 후 우측벽면을 따라 이동하세요. 요르무타르를 (54.8, 61.0) 소환하세요. 몇 번 시도하다보면 살덩이를 얻을 수 있습니다.|r"
Lang["Q1_13372"] = "집중의 눈동자 열쇠"
Lang["Q2_13372"] = "집중의 눈동자 열쇠를 고룡쉼터 사원의 꼭대기에 있는 생명의 어머니 알렉스트라자에게 가져가야 합니다."
Lang["Q1_13375"] = "집중의 눈동자 영웅 열쇠"
Lang["Q2_13375"] = "집중의 눈동자 영웅 열쇠를 고룡쉼터 사원의 꼭대기에 있는 생명의 어머니 알렉스트라자에게 가져가야 합니다."

--  \n\n|cff33ff99 |r
Lang["Q1_"] = ""
Lang["Q2_"] = ""




-- NPC
Lang["N1_9196"] = "대군주 오모크"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9196
Lang["N2_9196"] = "대군주 오모크는 검은바위 첨탑 하층의 첫 보스"
Lang["N1_9237"] = "대장군 부네"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9237
Lang["N2_9237"] = "대장군 부네는 검은바위 첨탑 하층의 준보스"
Lang["N1_9568"] = "대군주 웜타라크"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9568
Lang["N2_9568"] = "대군주 웜타라크는 검은바위 첨탑 하층의 최종 보스"
Lang["N1_10429"] = "대족장 렌드 블랙핸드"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10429
Lang["N2_10429"] = "대족장 렌드 블랙핸드는 검은바위 첨탑 상층의 여섯번째 보스로 일명 랜드라고 부름"
Lang["N1_10182"] = "렉사르"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10182
Lang["N2_10182"] = "<호드의 용사>\n\n패랄라스 북쪽에서 잊혀진땅 돌발톱 인접지역까지 길위에 돌아다님"
Lang["N1_8197"] = "크로날리스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=8197
Lang["N2_8197"] = "크로날리스는 청동용군단.\n\n타나리스 시간의 동굴 입구에 있음"
Lang["N1_10664"] = "스크라이어"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10664
Lang["N2_10664"] = "스크라이어는 푸른용군단.\n\n여명의 설원 마즈소릴 근처 배회"
Lang["N1_12900"] = "솜누스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12900
Lang["N2_12900"] = "솜누스는 녹색용군단.\n\n슬픔의 늪 가라앉은 신전 동쪽 늪에서 배회"
Lang["N1_12899"] = "악트로즈"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12899
Lang["N2_12899"] = "악트로즈는 붉은용군단.\n\n저습지 그림바톨 배회"
Lang["N1_10363"] = "사령관 드라키사스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10363
Lang["N2_10363"] = "사령관 드라키사스는 검은바위 첨탑 상층의 최종 보스"
Lang["N1_8983"] = "골렘 군주 아젤마크"	-- https://www.thegeekcrusade-serveur.com/db/?npc=8983
Lang["N2_8983"] = "골렘 군주 아젤마크는 검은바위 나락 아홉번째 보스"
Lang["N1_9033"] = "사령관 앵거포지"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9033
Lang["N2_9033"] = "사령관 앵거포지는 검은바위 나락 일곱번째 보스"
Lang["N1_17804"] = "수습기사 로우"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17804
Lang["N2_17804"] = "스톰윈드 정문 입구에 있음"
Lang["N1_10929"] = "헬레"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10929
Lang["N2_10929"] = "여명의 설원 마즈소릴 동굴 (야외) 위에 있음.\n동굴 안쪽 푸른 바닥 포탈을 타고 올라갈 수 있음"
Lang["N1_9046"] = "방패부대 병참장교"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9046
Lang["N2_9046"] = "검은바위 첨탑 던전 입구 근처에 있음."
Lang["N1_15180"] = "흐르는 모래의 바리스톨스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15180
Lang["N2_15180"] = "실리더스 세나리온 요새 (49.6,36.6)."
Lang["N1_12017"] = "용기대장 레쉬레이어"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12017
Lang["N2_12017"] = "용기대장 레쉬레이어는 검은둥지 날개 세번째 보스"
Lang["N1_13020"] = "타락한 벨라스트라즈"	-- https://www.thegeekcrusade-serveur.com/db/?npc=13020
Lang["N2_13020"] = "타락한 벨라스트라즈는 검은둥지 날개 두번째 보스"
Lang["N1_11583"] = "네파리안"	-- https://www.thegeekcrusade-serveur.com/db/?npc=11583
Lang["N2_11583"] = "네파리안은 검은둥지 날개 최종보스"
Lang["N1_15362"] = "말퓨리온 스톰레이지"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15362
Lang["N2_15362"] = "아탈학카르 신전 안에 에라니쿠스의 사령 근처에 가면 나옴"
Lang["N1_15624"] = "숲 위습"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15624
Lang["N2_15624"] = "다르나서스 정문에서 조금 벗어난 텔드랏실에서 발견됨 (37.6,48.0)."
Lang["N1_15481"] = "아주어고스의 영혼"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15481
Lang["N2_15481"] = "영혼은 남부 아즈샤라 배회 (근처 58.8,82.2)"
Lang["N1_11811"] = "나라인 수스팬시"	-- https://www.thegeekcrusade-serveur.com/db/?npc=11811
Lang["N2_11811"] = "타나리스 스팀휘들 항구에 있음 (65.2,18.4)."
Lang["N1_15526"] = "인어공주 메리디스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15526
Lang["N2_15526"] = "타나리스 남쪽 해안가 바다 속에 있음 (59.6,95.6). 퀘를 완료하면 수영 버프를 줌"
Lang["N1_15554"] = "넘버투"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15554
Lang["N2_15554"] = "넘버투는 여명의 설원 (67.2,72.6)에서 소환. 리젠 시간이 길 수 있음"
Lang["N1_15552"] = "박사 위빌"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15552
Lang["N2_15552"] = "먼지 진흙습지대 알카즈 섬에서 발견 (77.8,17.6)"
Lang["N1_10184"] = "오닉시아"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10184
Lang["N2_10184"] = "스톰윈드 왕궁 안에 없다면 먼지 진흙습지대 오닉시아 둥지 안에 있음"
Lang["N1_11502"] = "라그나로스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=11502
Lang["N2_11502"] = "불의 군주 라그나로스, 화산 심장부 최종 보스"
Lang["N1_12803"] = "지배자 라크마에란"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12803
Lang["N2_12803"] = "페랄라스 서쪽 섬 키메라 서식지 근처에 있음 (29.8,72.6)"
Lang["N1_15571"] = "식인아귀"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15571
Lang["N2_15571"] = "아즈샤라 (65.6,54.6)"
Lang["N1_22037"] = "대장장이 고르룬크"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22037
Lang["N2_22037"] = "어둠골 골짜기 검은 사원 북쪽 외부에 있음 (67,36)"
Lang["N1_18733"] = "지옥절단기"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18733
Lang["N2_18733"] = "지옥불 반도 동쪽과 서쪽에 각각 한 마리씩 배회"
Lang["N1_18473"] = "갈퀴대왕 이키스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18473
Lang["N2_18473"] = "아킨둔 세데크 전당의 최종 보스"
Lang["N1_20142"] = "시간의 청지기"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20142
Lang["N2_20142"] = "청동용, 시간의 동굴 안쪽 모래시계 근처 배회"
Lang["N1_20130"] = "안도르무"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20130
Lang["N2_20130"] = "어린이, 시간의 동굴 안쪽 모래시계 근처 배회"
Lang["N1_18096"] = "시대의 사냥꾼"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18096
Lang["N2_18096"] = "시간의 동굴 옛힐스(던홀드 요새)의 최종 보스"
Lang["N1_19880"] = "황천의 추적자 케이지"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19880
Lang["N2_19880"] = "황천의 폭풍 52번 구역 (32,64)"
Lang["N1_19641"] = "초공간 약탈자 네사드"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19641
Lang["N2_19641"] = "황천의 폭풍 52번 구역 서쪽 (28,79). 쫄 2마리 데리고 다님"
Lang["N1_18481"] = "아달"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18481
Lang["N2_18481"] = "아달은 샤트라스 중앙에 거대한 인형.."
Lang["N1_19220"] = "철두철미한 판탈리온"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19220
Lang["N2_19220"] = "메카나르의 최종 보스"
Lang["N1_17977"] = "차원의 분리자"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17977
Lang["N2_17977"] = "신록의 정원 다섯번째 보스. 거대한 나무 정령"
Lang["N1_17613"] = "대마법사 알투루스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17613
Lang["N2_17613"] = "카라잔 입구에 서 있음"
Lang["N1_18708"] = "울림"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18708
Lang["N2_18708"] = "울림은 어둠의 미궁 최종 보스. 거대한 바람 정령"
Lang["N1_17797"] = "풍수사 세스피아"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17797
Lang["N2_17797"] = "증기 저장고 첫 보스Hydromancer Thespia is the first boss of The Steamvault in Coilfang Reservoir."
Lang["N1_20870"] = "속박이 풀린 제레케스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20870
Lang["N2_20870"] = "알카트라즈 첫 보스"
Lang["N1_15608"] = "메디브"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15608
Lang["N2_15608"] = "검은늪 남쪽 포탈 앞에 있음"
Lang["N1_16524"] = "아란의 망령"	-- https://www.thegeekcrusade-serveur.com/db/?npc=16524
Lang["N2_16524"] = "카라잔 안에 있는 메디브의 실성한 아버지"
Lang["N1_16807"] = "대흑마법사 네더쿠르스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=16807
Lang["N2_16807"] = "으스러진 손의 전당 첫번째 보스"
Lang["N1_18472"] = "흑마술사 시스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18472
Lang["N2_18472"] = "세데크 전당 첫 보스"
Lang["N1_22421"] = "이단자 스카디스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22421
Lang["N2_22421"] = "스카디스는 강제노역소(영웅)에서만 보임. 첫보스를 지나 두번째 보스 가는 길 물에 빠진 후 나오면 좌측 감옥에 있음"
Lang["N1_19044"] = "용 학살자 그롤"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19044
Lang["N2_19044"] = "칼날산맥 그룰의 둥지 최종 보스"
Lang["N1_17225"] = "파멸의 어둠"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17225
Lang["N2_17225"] = "파멸의 어둠은 카라잔 내에서 소환하는 보스. 파멸의 소환퀘에 대해서 확인하세요"
Lang["N1_21938"] = "대지의 치유사 스플린트후프"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21938
Lang["N2_21938"] = "스플린트후프는 어둠골 골짜기 북서쪽 가장 높은 지점 작은 건물 안에 있음 (28.6,26.6)."
Lang["N1_21183"] = "비통의 오로노크"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21183
Lang["N2_21183"] = "어둠골 골짜기 샤티르 제단과 갈퀴흉터 거점 중간 지점 오로노크 농장에 있음 (53.8,23.4)"
Lang["N1_21291"] = "오로노크의 아들 그롬토르"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21291
Lang["N2_21291"] = "어둠골 골짜기 갈퀴흉터 거점 (44.6,23.6)."
Lang["N1_21292"] = "오로노크의 아들 알토르"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21292
Lang["N2_21292"] = "어둠골 골짜기 일리다리 거점 (29.6,50.4), 빨강 광선으로 공중에 갇혀 있음"
Lang["N1_21293"] = "오로노크의 아들 보라크"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21293
Lang["N2_21293"] = "어둠골 골짜기 해그늘 주둔지 북쪽에 있음 (47.6,57.2)."
Lang["N1_18166"] = "카드가"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18166
Lang["N2_18166"] = "샤트라스 중앙 아달 옆에 있음."
Lang["N1_16808"] = "대족장 카르가스 블레이드피스트"	-- https://www.thegeekcrusade-serveur.com/db/?npc=16808
Lang["N2_16808"] = "으스러진 손의 전당 최종 보스."
Lang["N1_17798"] = "장군 칼리스레쉬"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17798
Lang["N2_17798"] = "증기 저장고 최종 보스"
Lang["N1_20912"] = "선구자 스키리스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20912
Lang["N2_20912"] = "알카트라즈 최종 보스. "
Lang["N1_20977"] = "밀하우스 마나스톰"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20977
Lang["N2_20977"] = "알카트자르 최종 보스를 잡을 때 감옥에서 나타나며 다른 감옥에서 나오는 준보스 처치 도와줌."
Lang["N1_17257"] = "마그테리돈"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17257
Lang["N2_17257"] = "지옥불 반도 중앙 지하감옥에 있으며 마그테리돈의 둥지 최종 보스"
Lang["N1_21937"] = "대지의 치유사 소푸루스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21937
Lang["N2_21937"] = "어둠골 골짜기 와일드해머 요새 여관 건물 앞에 있음(36.4,56.8)."
Lang["N1_19935"] = "소리도르미"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19935
Lang["N2_19935"] = "시간의 동굴 안쪽 모래시계 근처 배회"
Lang["N1_19622"] = "켈타스 선스타라이더"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19622
Lang["N2_19622"] = "폭풍우 요새 최종 보스"
Lang["N1_21212"] = "여군주 바쉬"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21212
Lang["N2_21212"] = "불뱀 제단 최종 보스"
Lang["N1_21402"] = "수도사 케일라"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21402
Lang["N2_21402"] = "어둠골 골짜기 샤티르 제단에 있음 (62.6,28.4)."
Lang["N1_21955"] = "비전술사 텔리스"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21955
Lang["N2_21955"] = "어둠골 골짜기 별의 성소에 있음 (56.2,59.6)"
Lang["N1_21962"] = "현자 우달로"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21962
Lang["N2_21962"] = "알카트라즈 최종 보스 가는 길 바닥에 죽어 있음"
Lang["N1_22006"] = "암흑군주 데스웨일"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22006
Lang["N2_22006"] = "어둠골 골짜기 검은 사원 북쪽 탑 근처에 용을 타고 있음 (71.6,35.6) "
Lang["N1_22820"] = "현자 올룸"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22820
Lang["N2_22820"] = "불뱀 제단 네번째 보스 카라드레스 뒤에 있음"
Lang["N1_21700"] = "아카마"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21700
Lang["N2_21700"] = "어둠골 골짜기 감시자의 수용소에 있음 (58.0,48.2)."
Lang["N1_19514"] = "알라르"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19514
Lang["N2_19514"] = "알라르는 폭풍우 요새의 첫 보스. 거대한 불새!"
Lang["N1_17767"] = "격노한 윈터칠"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17767
Lang["N2_17767"] = "하이잘 산 첫 보스"
Lang["N1_18528"] = "지리"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18528
Lang["N2_18528"] = "검은 사원 입구에 있음. 거대한 파랑 인형"
--v243
Lang["N1_22497"] = "베루"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22497
Lang["N2_22497"] = "베루는 아달과 같은 방에 있지만 파란색입니다. 그는 꼭대기 층에 있습니다."
--v244
Lang["N1_22113"] = "모르데나이"
Lang["N2_22113"] = "별의 성소 바로 동쪽에 있는 황천의 들판을 걷는 블러드 엘프(스포일러 주의, 실제로는 드래곤)"
--v247
Lang["N1_8888"]  = "프랑클론 포지라이트"
Lang["N2_8888"]  = "용암 위에 매달린 구조물에서 던전 밖 자신의 무덤에 서 있는 유령 드워프. 당신이 죽은 경우에만 그와 상호 작용할 수 있습니다."
Lang["N1_9056"]  = "파이너스 다크바이어"
Lang["N2_9056"]  = "그는 던전 내부에 있으며 인센디우스 경의 방 밖에 있는 채석장 지역을 순찰하고 있습니다."
Lang["N1_10837"] = "고위집행관 델링턴"
Lang["N2_10837"] = "그는 티리스팔과 서부 역병지대 경계 근처의 보루에서 찾을 수 있습니다."
Lang["N1_10838"] = "사령관 아쉬람 발러피스트"
Lang["N2_10838"] = "서부 역병지대 안돌할 바로 남쪽에 있는 서리바람 야영지에서 찾을 수 있습니다."
Lang["N1_1852"]  = "소환사 아라즈"
Lang["N2_1852"]  = "안돌할의 한가운데에 있는 리치"
--v250
Lang["N1_13278"]  = "군주 히드락시스"
Lang["N2_13278"]  = "아즈샤라의 아주 작은 섬에 있는 거대한 물의 정령 (79.2,73.6)"
Lang["N1_12264"]  = "샤즈라"
Lang["N2_12264"]  = "샤즈라 는 코어하트 의 5번째 보스입니다."
Lang["N1_12118"]  = "루시프론"
Lang["N2_12118"]  = "루시프론 는 코어하트의 첫 번째 보스입니다."
Lang["N1_12259"]  = "게헨나스"
Lang["N2_12259"]  = "게헨나스 는 코어하트 의 3번째 보스입니다."
Lang["N1_12098"]  = "설퍼론 사자"
Lang["N2_12098"]  = "설퍼론 사자 는 코어하트 의 8번째 보스입니다."




--WOTLK NPCs
--WOTLK QUESTS
-- The ids are N1_<NPCId> and N2_<NPCId>
-- N1 is just the name of the NPC
-- N2 is a helpful description
Lang["N1_29795"]  = "콜티라 데스위버"
Lang["N2_29795"]  = "콜티라는 얼음왕관 공중 오그림의 망치호를 타고 있습니다. 망치호는 이미르하임과 신드라고사의 추락지를 순회합니다."
Lang["N1_29799"]  = "타사리안"
Lang["N2_29799"]  = "타사리안은 얼음왕관 공중 하늘파괴자호를 타고 있습니다. 하늘파괴자호는 이미르하임과 신드라고사의 추락지를 순회합니다."
Lang["N1_29804"]  = "남작 슬리버"
Lang["N2_29804"]  = "어둠의 무기고 (44, 24.6) 입구 앞에 서 있습니다.\n\n연퀘를 모두 완료하면 위치가 바뀝니다 (42.8, 25.1)."
Lang["N1_29747"]  = "왕의 눈"
Lang["N2_29747"]  = "어둠의 무기고 (44.6, 21.6) 성채 꼭대기에 있는 거대한 파란 눈.\n\n눈엣가시 광선총으로 10번 공격하여 처치"
Lang["N1_29769"]  = "썩은내"
Lang["N2_29769"]  = "어둠의 무기고 입구 앞 (44.4, 26.9)."
Lang["N1_29770"]  = "여군주 나이츠우드"
Lang["N2_29770"]  = "어둠의 무기고 입구 근처 중간층쯤에 있음 (41.9, 24.5)."
Lang["N1_29840"]  = "껑충이"
Lang["N2_29840"]  = "어둠의 무기고 상층에서 빙글빙글 점프하고 있음 (45.0, 23.8).\n'/대상 껑충이'로 대상을 잡으세요."
Lang["N1_29851"]  = "장군 라이츠베인"
Lang["N2_29851"]  = "어둠의 무기고 안쪽 무기고 선반쪽에 있습니다. 전투 중 썩은내, 여군주, 껑충이가 와서 전투를 도와줍니다.\n\n어둠의 무기고 내에서 날탈이 가능합니다 (44.9, 20.0)."
Lang["N1_26181"]  = "사절 브라이트후프"
Lang["N2_26181"]  = "용의 안식처 서풍의 피난민 행렬 근처에서 배회하고 있습니다 (13.9, 48.6)."
Lang["N1_26652"]  = "대모 아이스미스트"
Lang["N2_26652"]  = "아그마르의 망치 안마당 중앙에서 배회하고 있습니다. 푸른 갑옷에 보라색 지팡이를 들고 있습니다."
Lang["N1_26505"]  = "의술사 신타르 말레피오스"
Lang["N2_26505"]  = "아그마라의 망치 연금술대에 있습니다 (36.1, 48.8)."
Lang["N1_25257"]  = "사울팽의 아들"
Lang["N2_25257"]  = "용의 안신척 북서쪽 분노의 관문 근처에 있습니다 (40.7, 18.1).\n\n그에게 너무 집착하지 마세요!"
Lang["N1_31333"]  = "생명의 어머니 알렉스트라자"
Lang["N2_31333"]  = "분노의 관문 앞 용의 모습으로 있습니다. 굉장히 커서 바로 보입니다 (38.3, 19.2)."
Lang["N1_25256"]  = "대군주 사울팽"
Lang["N2_25256"]  = "북풍의 땅 전쟁노래부족 요새 맨 아래층에 있습니다 (41.4, 53.7)."
Lang["N1_27136"]  = "총사령관 할포드 웜베인"
Lang["N2_27136"]  = "용의 안식처 윈터가드 성채 위쪽에 있습니다 (78.5, 48.3)."
Lang["N1_27872"]  = "대영주 볼바르 폴드라곤"
Lang["N2_27872"]  = "볼바르 폴드라곤은 얼라이언스의 진정한 영웅이지만, 끔찍한 운명을 맞았습니다.\n\n그를 만나러 (37.8, 23.4)로 가십시오."
Lang["N1_29611"]  = "국왕 바리안 린"
Lang["N2_29611"]  = "행복해 보이지 않네요.."
Lang["N1_29473"]  = "그레첸 피즐스파크"
Lang["N2_29473"]  = "폭풍우 봉우리 K3 여관 안에 있습니다 (41.2, 86.1)."
Lang["N1_15989"]  = "샤피론"
Lang["N2_15989"]  = "샤피론은 낙스라마스 켈투자드를 수호하는 거대한 언데드 서리고룡입니다."

Lang["N1_"]  = ""
Lang["N2_"]  = ""



Lang["O_1"] = "드라키사스의 낙인을 꼭 클릭하여 퀘를 완료!\n파랑 오브는 사령관 드라키사스 뒤에 있음"
Lang["O_2"] = "바닥에 붉게 빛나는 작은 점입니다.\n안퀴라즈 성문 앞에 있음 (28.7,89.2)."
--v247
Lang["O_3"] = "법륜의 상층부에서 시작되는 회랑 끝에 있는 신사."
Lang["O_189311"] = "|cFFFFFFFF살점달린 고서|r\n|cFF808080퀘스트 시작 아이템|r\n\n강령군주 아마리온 (78.3, 52.3) 옆에\n묘지 바닥에 보면 책이 있습니다.\n\n퀘스트를 받으면 바로 탈출하세요.\n묘지 안에 몹들이 재생성되어 당신을 공격합니다."
Lang["Flesh-bound Tome"] = "살점달린 고서"

