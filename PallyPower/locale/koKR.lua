local L = LibStub("AceLocale-3.0"):NewLocale("PallyPower", "koKR", false, false)
if not L then return end 
L["ALTMENU_LINE1"] = "할당 가능"
L["ALTMENU_LINE2"] = "일반 축복:"
L["AURA"] = "오라 버튼"
L["AURA_DESC"] = "오라 버튼 [|cffffd200사용|r/|cffffd200사용안함|r] 또는 추적하려는 오라를 선택하세요."
L["AURABTN"] = "오라 버튼"
L["AURABTN_DESC"] = "오라 버튼 [사용/사용안함]"
L["AURATRACKER"] = "오라 추적기"
L["AURATRACKER_DESC"] = "추적하려는 오라를 선택하세요."
L["AUTO"] = "자동 버프 버튼"
L["AUTO_DESC"] = "자동 버프 버튼 [|cffffd200사용|r/|cffffd200사용안함|r] 또는 플레이어 기다림 [|cffffd200사용|r/|cffffd200사용안함|r]"
L["AUTOASSIGN"] = "자동 할당"
L["AUTOASSIGN_DESC"] = [=[이용 가능한 성기사의 수와
사용 가능한 축복을 기반으로
모든 축복을 자동 할당합니다.

|cffffffff[쉬프트 + 좌클릭]|r 공격대 할당
템플릿을 대신해 전장 할당
템플릿을 사용합니다.]=]
L["AUTOBTN"] = "자동 버프 버튼"
L["AUTOBTN_DESC"] = "자동 버프 버튼 [사용/사용안함]"
L["AUTOKEY1"] = "자동 일반 축복 단축키"
L["AUTOKEY1_DESC"] = "일반 축복의 자동 버프를 위한 단축키"
L["AUTOKEY2"] = "자동 상급 축복 단축키"
L["AUTOKEY2_DESC"] = "상급 축복의 자동 버프를 위한 단축키"
L["BAP"] = "축복 할당창 크기"
L["BAP_DESC"] = "이것으로 축복 할당창의 전체 크기를 조정할 수 있습니다."
L["BRPT"] = "축복 알리미"
L["BRPT_DESC"] = [=[공격대 또는 파티 
채널에 모든 축복 
할당을 알립니다.]=]
L["BSC"] = "PallyPower 버튼 크기"
L["BSC_DESC"] = "이것으로 PallyPower 버튼의 전체 크기를 조정할 수 있습니다."
L["BUFFDURATION"] = "버프 지속시간"
L["BUFFDURATION_DESC"] = "이 옵션을 사용하지 않으면 직업 및 플레이어 버튼은 버프 지속시간을 무시하고 버프를 다시 적용 할 수 있습니다. 이것은 보호 성기사가 상급 축복을 스팸으로 만들어 더 많은 위협을 생성 할 때 특히 유용합니다."
L["BUTTONS"] = "버튼"
L["BUTTONS_DESC"] = "버튼 설정을 변경합니다."
L["CANCEL"] = "취소"
L["CLASSBTN"] = "직업 버튼"
L["CLASSBTN_DESC"] = "이 옵션을 사용 안하면 플레이어 버튼도 사용 안하게 되며 자동 버프 버튼을 사용해야만 버프 할 수 있습니다."
L["CPBTNS"] = "직업 및 플레이어 버튼"
L["CPBTNS_DESC"] = "플레이어 또는 직업 버튼 [|cffffd200사용|r/|cffffd200사용안함|r]"
L["DISPEDGES"] = "테두리"
L["DISPEDGES_DESC"] = "버튼 테두리를 변경합니다."
L["DRAG"] = "드래그 손잡이 버튼"
L["DRAG_DESC"] = "드래그 손잡이 버튼 [|cffffd200사용|r/|cffffd200사용안함|r]"
L["DRAGHANDLE"] = [=[|cffffffff[좌-클릭]|r PallyPower |cffff0000잠금|r/|cff00ff00해제|r 
|cffffffff[좌-클릭 + 고정]|r PallyPower 이동 
|cffffffff[우-클릭]|r 축복 할당 열기 
|cffffffff[쉬프트 + 우클릭]|r 설정 열기]=]
L["DRAGHANDLE_ENABLED"] = "드래그 손잡이"
L["DRAGHANDLE_ENABLED_DESC"] = "드래그 손잡이 [사용/사용안함]"
L["ENABLEPP"] = "전역 표시"
L["ENABLEPP_DESC"] = "PallyPower [표시/숨김]"
L["FREEASSIGN"] = "자유 할당"
L["FREEASSIGN_DESC"] = [=[파티장 / 공격대 관리자가 아닌 
다른 사람들이 당신의 축복을 
바꿀 수 있도록 허용합니다.]=]
L["FULLY_BUFFED"] = "전체 버프됨"
L["HORLEFTDOWN"] = "수평 왼쪽 | 아래"
L["HORLEFTUP"] = "수평 왼쪽 | 위"
L["HORRIGHTDOWN"] = "수평 오른쪽 | 아래"
L["HORRIGHTUP"] = "수평 오른쪽 | 위"
L["LAYOUT"] = "버프 버튼 | 플레이어 버튼 모양"
L["LAYOUT_DESC"] = "수직 [좌/우] 수평 [상/하]"
L["MAINASSISTANT"] = "지원공격 전담 자동 버프"
L["MAINASSISTANT_DESC"] = "이 옵션을 사용하면 블리자드 공격대 창에서 |cffffd200지원공격 전담|r 역할이 표시된 플레이어에 PallyPower가 일반 축복으로 상급 축복을 자동으로 덮어 씁니다. 이것은 상급 구원의 축복으로 |cffffd200지원공격 전담|r 역할을 축복하지 않도록 하는 데 유용합니다."
L["MAINASSISTANTGBUFFDP"] = "드루이드 / 성기사 무시..."
L["MAINASSISTANTGBUFFDP_DESC"] = "방어 전담에 덮어 쓰려는 상급 축복 할당을 선택하세요: 드루이드 / 성기사."
L["MAINASSISTANTGBUFFW"] = "전사 무시..."
L["MAINASSISTANTGBUFFW_DESC"] = "방어 전담에 덮어 쓰려는 상급 축복 할당을 선택하세요: 전사."
L["MAINASSISTANTNBUFFDP"] = "...정상..."
L["MAINASSISTANTNBUFFDP_DESC"] = "방어 전담에 덮어 쓰는 데 사용할 일반 축복을 선택하세요: 드루이드 / 성기사."
L["MAINASSISTANTNBUFFW"] = "...정상..."
L["MAINASSISTANTNBUFFW_DESC"] = "방어 전담에 덮어 쓰는 데 사용할 일반 축복을 선택하세요: 전사."
L["MAINROLES"] = "메인 탱커 / 공격지원 전담 역할"
L["MAINROLES_DESC"] = [=[이 옵션을 사용하면 |cffff0000전사, 드루이드 또는 성기사에게만|r 부여되는 상급 축복에 대한 대체 일반 축복을 자동으로 할당 할 수 있습니다. 

일반적으로 방어 전담과 공격지원 전담의 역할은 메인 탱커와 딜러(공격지원 전담)를 식별하는 데 사용되었지만 일부 길드는 방어 전담 역할을 메인 탱커와 딜러에 할당하고 공격지원 전담 역할을 힐러에게 할당합니다. 

두 역할에 대해 별도의 설정을 함으로 성기사 클래스장 또는 공격대장이 제거할 수 있습니다. 예를 들어, 탱킹 클래스에 대한 '상급 구원의 축복' 또는 드루이드나 성기사 힐러가 공격지원 전담 역할이면 딜러 특성의 드루이드와 성기사에 '상급 힘의 축복'을 할당하고 힐러 특성의 드루이드와 성기사에 '일반 지혜의 축복'을 할당하여 '일반 지혜의 축복' 및 '상급 힘의 축복'을 얻도록 설정할 수 있습니다. 

|cffffff00참고: 공격대에 성기사 축복이 모두 주어질만큼 충분한 성기사가 있는 경우, 이 설정은 무시해도됩니다. 탱킹 클래스는 구원의 축복을 수동으로 해제해야 합니다.|r]=]
L["MAINTANKGBUFFDP"] = "드루이드 / 성기사 무시..."
L["MAINTANKGBUFFDP_DESC"] = "방어 전담에 덮어 쓰려는 상급 축복 할당을 선택하세요: 드루이드 / 성기사."
L["MAINTANKGBUFFW"] = "전사 무시..."
L["MAINTANKGBUFFW_DESC"] = "방어 전담에 덮어 쓰려는 상급 축복 할당을 선택하세요: 전사."
L["MAINTANKNBUFFDP"] = "...정상..."
L["MAINTANKNBUFFDP_DESC"] = "방어 전담에 덮어 쓰는데 사용할 일반 축복을 선택하세요: 드루이드 / 성기사."
L["MAINTANKNBUFFW"] = "...정상..."
L["MAINTANKNBUFFW_DESC"] = "방어 전담에 덮어 쓰는데 사용할 일반 축복을 선택하세요: 전사."
L["MINIMAPICON"] = "|cffffffff[좌-클릭]|r 축복 할당 열기 |cffffffff[우-클릭]|r 설정 열기"
L["NONE"] = "없음"
L["NONE_BUFFED"] = "버프 없음"
L["OPTIONS"] = "옵션"
L["OPTIONS_DESC"] = [=[PallyPower 애드온 
설정창을 엽니다.]=]
L["PARTIALLY_BUFFED"] = "일부만 버프됨"
L["PLAYERBTNS"] = "플레이어 버튼"
L["PLAYERBTNS_DESC"] = "이 옵션을 사용안하게 되면 더 이상 개별 플레이어를 표시하는 팝업 버튼이 표시되지 않으며 전투 중에 일반 축복을 다시 적용 할 수 없습니다."
L["PP_CLEAR"] = "지우기"
L["PP_CLEAR_DESC"] = [=[자신, 파티 및 공격대 
성기사의 모든 축복 
할당을 지웁니다.]=]
L["PP_COLOR"] = "버프 버튼의 상태 색상 변경"
L["PP_LOOKS"] = "PallyPower 외관 변경"
L["PP_MAIN"] = "PallyPower 표시 시기"
L["PP_NAME"] = "PallyPower 클래식"
L["PP_RAS1"] = "--- 성기사 할당 ---"
L["PP_RAS2"] = "--- 할당의 끝 ---"
L["PP_RAS3"] = "경고: 공격대 내 5명 이상의 성기사가 있습니다."
L["PP_RAS4"] = "탱커는 구원의 축복을 수동으로 꺼야합니다!"
L["PP_REFRESH"] = "새로고침"
L["PP_REFRESH_DESC"] = [=[자신, 파티 및 공격대 
성기사 중 모든 축복 
할당, 특성 및 왕의 징표를 
새로고침 합니다.]=]
L["PP_RESET"] = "당신이 엉망인 경우의 대비책"
L["PPMAINTANK"] = "방어 전담 자동 버프"
L["PPMAINTANK_DESC"] = "이 옵션을 사용하면 블리자드 공격대 창에서 |cffffd200방어 전담|r 역할이 표시된 플레이어에 PallyPower가 일반 축복으로 상급 축복을 자동으로 덮어 씌웁니다. 이것은 상급 구원의 축복을 |cffffd200방어 전담|r 역할에 축복하지 않도록 하는 데 유용합니다."
L["RAID"] = "공격대"
L["RAID_DESC"] = "공격대 전용 옵션"
L["REPORTCHANNEL"] = "축복 알림 채널"
L["REPORTCHANNEL_DESC"] = [=[축복을 알릴 방송 채널을 다음과 같이 설정하세요:

|cffffd200[없음]|r 그룹 구성에 따라 채널을 선택합니다. (파티/공격대)

|cffffd200[채널 목록]|r 플레이어가 입장한 채널을 기반으로 자동으로 채워진 채널 목록입니다. 거래, 일반 등과 같은 기본 채널은 목록에서 자동으로 필터링됩니다.

|cffffff00알림: 채널 순서를 변경하면 UI를 재시작하고 UI가 올바른 채널로 방송되는지 확인해야합니다.|r]=]
L["RESET"] = "프레임 초기화"
L["RESET_DESC"] = "모든 PallyPower 프레임을 중앙으로 초기화"
L["RESIZEGRIP"] = [=[좌클릭-고정으로 크기 변경 
우클릭 시 기본 크기로 초기화]=]
L["RFM"] = "정의의 격노"
L["RFM_DESC"] = "정의의 격노 [사용/사용안함]"
L["SALVCOMBAT"] = "전투 중 구축"
L["SALVCOMBAT_DESC"] = [=[이 옵션을 사용하면 전투 중 상급 구원의 축복으로 전사, 드루이드 및 성기사를 버프할 수 있습니다.

|cffffff00참고: 이 설정은 현재 보편적으로 많은 탱커가 스크립트/애드온을 사용하여 전투 중이 아닌 동안에 버프를 취소 할 수 있기 때문에 공격대 그룹에서만 적용됩니다. 이 옵션은 기본적으로 전투 중에 실수로 구축을 탱커에 버프하는 것을 방지하기 위한 안전장치 입니다.|r]=]
L["SEAL"] = "문장 버튼"
L["SEAL_DESC"] = "문장 버튼 [|cffffd200사용|r/|cffffd200사용안함|r], 정의의 격노 사용/사용안함 또는 추적하려는 문장을 선택하세요."
L["SEALBTN"] = "문장 버튼"
L["SEALBTN_DESC"] = "문장 버튼 [사용/사용안함]"
L["SEALTRACKER"] = "문장 추적기"
L["SEALTRACKER_DESC"] = "추적하려는 문장을 선택하세요."
L["SETTINGS"] = "설정"
L["SETTINGS_DESC"] = "전역 설정을 변경합니다."
L["SETTINGSBUFF"] = "PallyPower로 버프할 내용"
L["SHOWMINIMAPICON"] = "미니맵 아이콘 표시"
L["SHOWMINIMAPICON_DESC"] = "미니맵 아이콘 [표시/숨김]"
L["SHOWPETS"] = "소환수 표시"
L["SHOWPETS_DESC"] = [=[이 옵션을 사용하면 소환수가 자신의 직업 아래에 나타납니다. 

|cffffff00참고: 상급 축복이 작동하는 방식과 소환수가 분류되는 방식 때문에, 소환수는 별도로 버프해야 합니다. 또한, 흑마법사 임프는 위상 변화가 꺼지지 않는 한 자동으로 숨겨집니다.|r]=]
L["SHOWTIPS"] = "툴팁 표시"
L["SHOWTIPS_DESC"] = "PallyPower 툴팁 [표시/숨김]"
L["SKIN"] = "배경 무늬"
L["SKIN_DESC"] = "버튼 배경 무늬를 변경합니다."
L["SMARTBUFF"] = "스마트 버프"
L["SMARTBUFF_DESC"] = "이 옵션을 사용하면 전사 또는 도적에게 지혜의 축복을 할당하고 마법사, 흑마법사 및 사냥꾼에게 힘의 축복을 할당 할 수 없습니다."
L["USEPARTY"] = "파티 시 표시"
L["USEPARTY_DESC"] = "파티 시 PallyPower [표시/숨김]"
L["USESOLO"] = "솔로 시 표시"
L["USESOLO_DESC"] = "솔로일 때 PallyPower [표시/숨김]"
L["VERDOWNLEFT"] = "수직 아래 | 왼쪽"
L["VERDOWNRIGHT"] = "수직 아래 | 오른쪽"
L["VERUPLEFT"] = "수직 위 | 왼쪽"
L["VERUPRIGHT"] = "수직 위 | 오른쪽"
L["WAIT"] = "플레이어 기다림"
L["WAIT_DESC"] = "이 옵션을 사용하면 버프받을 사용자가 접속종료이거나 성기사 범위에 속하지 않을 경우 자동 버프 버튼과 직업 버프 버튼이 상급 축복을 자동으로 버프하지 않습니다."
 
