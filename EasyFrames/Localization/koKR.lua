-- Translated by CountWrynn
-- Hyjal server(KR)

local L = LibStub("AceLocale-3.0"):NewLocale("EasyFrames", "koKR")
if not L then return end
L["loaded. Options:"] = "로드됨. 이지프레임 설정창 열기:"

L["Opacity"] = "불투명도"
L["Opacity of combat texture"] = "전투메시지 불투명도"

L["Main options"] = "기본설정"
L["In main options you can set the global options like colored frames, buffs settings, etc"] = "기본설정에서 프레임 색상, 직업 초상화 등과 같은 전역변수 설정 가능"

L["Percent"] = "퍼센트"
L["Current + Max"] = "현재체력 + 최대체력"
L["Current + Max + Percent"] = "현재체력 + 최대체력 + 퍼센트"
L["Current + Percent"] = "현재체력 + 퍼센트"
L["Custom format"] = "임의설정"
L["Smart"] = "스마트"

L["None"] = "없음"
L["Outline"] = "외곽선"
L["Thickoutline"] = "두꺼운 외곽선"
L["Monochrome"] = "모노크롬"

L["HP and MP bars"] = "체력바와 마나바"

L["Font size"] = "글꼴 크기"
L["Healthbar font size"] = "체력바 글꼴 크기"
L["Manabar font size"] = "마나바 글꼴 크기"
L["Font family"] = "글꼴"
L["Healthbar font family"] = "체력바 글꼴"
L["Manabar font family"] = "마나바 글꼴"
L["Font style"] = "글꼴 스타일"

L["Reverse the direction of losing health/mana"] = "체력/마나 손실 방향 반대로 전환"
L["By default direction starting from right to left. If checked direction of losing health/mana will be from left to right"] = "기본방향은 오른쪽에서 시작해서 왼쪽. 이 설정을 선택하면 체력이나 마나 손실시 왼쪽에서 오른쪽으로 전환"

L["Custom format of HP"] = "체력 상태 숫자 형식 임의설정"
L["You can set custom HP format. More information about custom HP format you can read on project site.\n\n" ..
        "Formulas:"] = "임의로 체력 상태 숫자 형식 설정 가능. 설정에 대해 더 알고 싶으시면 EasyFrames 프로젝트 사이트 참조.\n\n" .. "계산식:"
L["Use full values of health"] = "체력 전체 수치 사용"
L["Formula converts the original value to the specified value.\n\n" ..
        "Description: for example formula is '%.fM'.\n" ..
        "The first part '%.f' is the formula itself, the second part 'M' is the abbreviation\n\n" ..
        "Example, value is 150550. '%.f' will be converted to '151' and '%.1f' to '150.6'"] = "변환식은 원래 수치를 특정값으로 변환.\n\n" .. "설명: 예를 들어 '%.fM'이면,\n" .. "첫부분 '%.f'은 변환식이고, 두번째 부분 'M'은 단위 축약문자 \n\n" .."예를 들어 체력수치가 150,550이면.\n'%.f'은 '151'로 바뀌고, '%.1f' 은 '150.6'로 바뀜"
L["Value greater than 1000"] = "1,000 초과값"
L["Value greater than 100 000"] = "100,000 초과값"
L["Value greater than 1 000 000"] = "1,000,000 초과값"
L["Value greater than 10 000 000"] = "10,000,000 초과값"
L["Value greater than 100 000 000"] = "100,000,000 초과값"
L["Value greater than 1 000 000 000"] = "1,000,000,000 초과값"
L["By default all formulas use divider (for value eq 1000 and more it's 1000, for 1 000 000 and more it's 1 000 000, etc).\n\n" ..
        "If checked formulas will use full values of HP (without divider)"] = "기본설정은 모든 변환식에서 몫 반환값 사용 (값이 1,000 이상이면 1,000, 1,000,000 이상이면 1,000,000).\n\n" .. "선택하면 변환식은 체력 수치 전체값을 사용(몫 반환값 사용안함)"
L["Displayed HP by pattern"] = "체력 수치 형식"
L["You can use patterns:\n\n" ..
        "%CURRENT% - return current health\n" ..
        "%MAX% - return maximum of health\n" ..
        "%PERCENT% - return percent of current/max health\n\n" ..
        "All values are returned from formulas. For set abbreviation use formulas' fields"] = "수치 패턴 사용:\n\n" .. "%CURRENT% - 현재 체력값\n" .. "%MAX% - 최대 체력값\n" .. "%PERCENT% - 최대 체력 대비 현재 체력 퍼센트 값\n\n" .. "모든 값은 변환식에서 산출. 단위 축약문자 사용하려면 변환식 필드 사용"

L["Custom format of mana"] = "마나 수치 형식 임의설정"
L["You can set custom mana format. More information about custom mana format you can read on project site.\n\n" ..
        "Formulas:"] = "임의로 마나 숫자 형식 설정 가능. 설정에 대해 더 알고 싶으시면 EasyFrames 프로젝트 사이트 참조.\n\n" .. "계산식:"
L["Use full values of mana"] = "마나 전체 수치 사용"
L["By default all formulas use divider (for value eq 1000 and more it's 1000, for 1 000 000 and more it's 1 000 000, etc).\n\n" ..
        "If checked formulas will use full values of mana (without divider)"] = "기본설정은 모든 변환식에서 몫 반환값 사용 (값이 1,000 이상이면 1,000, 1,000,000 이상이면 1,000,000).\n\n" .. "선택하면 변환식은 마나 수치 전체값을 사용(몫 반환값 사용안함)"
L["Displayed mana by pattern"] = "마나 수치 형식"
L["You can use patterns:\n\n" .. 
        "%CURRENT% - return current mana\n" ..
        "%MAX% - return maximum of mana\n" ..
        "%PERCENT% - return percent of current/max mana\n\n" ..
        "All values are returned from formulas. For set abbreviation use formulas' fields"] = "수치 패턴 사용:\n\n" .. "%CURRENT% - 현재 마나값\n" .. "%MAX% - 최대 마나값\n" .. "%PERCENT% - 최대 마나 대비 현재 마나 퍼센트 값\n\n" .. "모든 값은 변환식에서 산출. 단위 축약문자 사용하려면 변환식 필드 사용"
			

L["Frames"] = "프레임"
L["Setting for unit frames"] = "유닛 프레임 설정"

L["Class colored healthbars"] = "직업 색상 체력바"
L["If checked frames becomes class colored.\n\n" ..
    "This option excludes the option 'Healthbar color is based on the current health value'"] = "선택하면 프레임 색은 직업 색상으로 변환\n\n" .. "이 선택값은 '체력바 색상이 현재 체력값에 따라 바뀜' 선택지 제외시킴"
L["Healthbar color is based on the current health value"] = "체력바 색상이 현재 체력값에 따라 바뀜"
L["Healthbar color is based on the current health value.\n\n" ..
    "This option excludes the option 'Class colored healthbars'"] = "체력바 색상이 현재 체력값에 따라 바뀜\n\n" .. "이 선택값은 '직업 색상 체력바' 선택지 제외시킴"
L["Custom buffsize"] = "버프 크기 임의설정"
L["Buffs settings (like custom buffsize, highlight dispelled buffs, etc)"] = "버프 설정 (버프 크기 조절, 시전 버프 강조 등)"
L["Turn on custom buffsize"] = "버프 크기 임의설정"
L["Turn on custom target and focus frames buffsize"] = "대상 프레임과 주시대상 프레임 버프 크기 임의설정 켬"
L["Buffs"] = "버프"
L["Buffsize"] = "버프 크기"
L["Self buffsize"] = "자기 버프"
L["Buffsize that you create"] = "자기시전 버프"
L["Highlight dispelled buffs"] = "시전 버프 강조"
L["Highlight buffs that can be dispelled from target frame"] = "대상 프레임에 시전한 버프 강조"
L["Dispelled buff scale"] = "시전 버프 크기"
L["Dispelled buff scale that can be dispelled from target frame"] = "대상 프레임에 시전한 버프 크기"
L["Only if player can dispel them"] = "플레이어만 시전가능 버프"
L["Highlight dispelled buffs only if player can dispel them"] = "플레이어만 시전가능한 버프 강조"

L["Class portraits"] = "직업 초상화"
L["Replaces the unit-frame portrait with their class icon"] = "유닛 프레임 초상화를 직업 아이콘으로 대체"
L["Hide frames out of combat"] = "전투 종료 시 프레임 숨김"
L["Hide frames out of combat (for example in resting)"] = "비 전투 시(휴식 등) 프레임 숨김"
L["Only if HP equal to 100%"] = "체력이 100%일 때만"
L["Hide frames out of combat only if HP equal to 100%"] = "체력이 100%이고 비 전투 시 프레임 숨김"
L["Opacity of frames"] = "프레임 투명도"
L["Opacity of frames when frames is hidden (in out of combat)"] = "비 전투 시 프레임 숨겨졌을 때 프레임 투명도"

L["Texture"] = "무늬"
L["Set the frames bar Texture"] = "프레임 바 무늬 설정"
L["Bright frames border"] = "프레임 경계선 밝기"
L["You can set frames border bright/dark color. From bright to dark. 0 - dark, 100 - bright"] = "프레임 경계 명암 선택 가능. 0 - 어두움, 100 - 밝음"
L["Use a light texture"] = "밝은 무늬 사용"
L["Use a brighter texture (like Blizzard's default texture)"] = "보다 밝은 무늬 사용 (블리자드 기본 무늬와 같은)"

L["Frames colors"] = "프레임 색상"
L["In this section you can set the default colors for friendly, enemy and neutral frames"] = "여기에서 아군, 적군, 중립 대상 기본색상 설정 가능"
L["Set default friendly healthbar color"] = "아군 체력바 기본색상"
L["You can set the default friendly healthbar color for frames"] = "프레임에 아군 체력바 기본색상 설정 가능"
L["Set default enemy healthbar color"] = "적군 체력바 기본색상"
L["You can set the default enemy healthbar color for frames"] = "프레임에 적군 체력바 기본색상 설정 가능"
L["Set default neutral healthbar color"] = "NPC 체력바 기본색상"
L["You can set the default neutral healthbar color for frames"] = "프레임에 NPC 체력바 기본색상 설정 가능"
L["Reset color to default"] = "초기화"

L["Other"] = "기타"
L["In this section you can set the settings like 'show welcome message' etc"] = "환영 메시지 보여주기 설정 가능"
L["Show welcome message"] = "환영 메시지 보여주기"
L["Show welcome message when addon is loaded"] = "애드온 불러올 때 환영 메시지 보임"


L["Player"] = "플레이어"
L["In player options you can set scale player frame, healthbar text format, etc"] = "플레이어 설정에서 플레이어 프레임 크기, 체력바 텍스트 형식 등 설정 가능"
L["Player name"] = "플레이어 이름"
L["Player name font family"] = "플레이어 이름 글꼴"
L["Player name font size"] = "플레이어 이름 글꼴 크기"
L["Player name font style"] = "플레이어 이름 글꼴 스타일"
L["Show or hide some elements of frame"] = "프레임 일부 요소 보임/숨김"
L["Show player name"] = "플레이어 이름 보임"
L["Show player name inside the frame"] = "체력바 안에 플레이어 이름 넣기"
L["Player frame scale"] = "플레이어 프레임 크기"
L["Scale of player unit frame"] = "플레이어 유닛 프레임 크기"
L["Enable hit indicators"] = "히트 알람 사용"
L["Show or hide the damage/heal which you take on your unit frame"] = "유닛 프레임에 받은 피해나 치유 보임/숨김"
L["Player healthbar text format"] = "플레이어 체력바 텍스트 형식"
L["Set the player healthbar text format"] = "플레이어 체력바 텍스트 형식 설정"
L["Player manabar text format"] = "플레이어 마나바 텍스트 형식"
L["Set the player manabar text format"] = "플레이어 마나바 텍스트 형식 설정"
L["Show player specialbar"] = "플레이어 직업특수바 보임"
L["Show or hide the player specialbar, like Paladin's holy power, Priest's orbs, Monk's harmony or Warlock's soul shards"] = "성기사 신성한 힘, 수도사 조화, 흑마 영혼조각 등과 같은 직업특수바 보임/숨김"
L["Show player resting icon"] = "플레이어 휴식 아이콘 보임"
L["Show or hide player resting icon when player is resting (e.g. in the tavern or in the capital)"] = "휴식 상태일때 플레이어 휴식 아이콘 보임/숨김 (여관, 대도시 등에서)"
L["Show player status texture (inside the frame)"] = "플레이어 상태 텍스처 (프레임 안)"
L["Show or hide player status texture (blinking glow inside the frame when player is resting or in combat)"] = "플레이어 상태 텍스처 보임/숨김 (플레이어 휴식 시 혹은 전투 시 프레임 안에서 깜박거림)"
L["Show player combat texture (outside the frame)"] = "전투 텍스처 보임 (프레임 밖)"
L["Show or hide player red background texture (blinking red glow outside the frame in combat)"] = "적색 배경텍스처 보임/숨김 (전투 시 프레임 밖에서 붉게 빛나며 깜박거림)"
L["Show player group number"] = "플레이어 그룹 번호 보임"
L["Show or hide player group number when player is in a raid group (over portrait)"] = "플레이어가 공격대 소속시 그룹 번호 보임/숨김 (초상화 위)"
L["Show player role icon"] = "플레이어 역할 아이콘 보임"
L["Show or hide player role icon when player is in a group"] = "그룹 소속시 플레이어 역할 아이콘 보임/숨김"


L["Target"] = "대상"
L["In target options you can set scale target frame, healthbar text format, etc"] = "대상 프레임 설정에서 대상 프레임 크기, 체력바 텍스트 형식 등 설정 가능"
L["Target name"] = "대상 이름"
L["Target name font family"] = "대상 이름 글꼴"
L["Target name font size"] = "대상 이름 글꼴 크기"
L["Target name font style"] = "대상 이름 글꼴 스타일"
L["Target frame scale"] = "대상 프레임 크기"
L["Scale of target unit frame"] = "대상 유닛 프레임 크기"
L["Target healthbar text format"] = "대상 프레임 체력바 텍스트 형식"
L["Set the target healthbar text format"] = "대상 프레임 체력바 텍스트 형식 설정"
L["Target manabar text format"] = "대상 프레임 마나바 텍스트 형식"
L["Set the target manabar text format"] = "대상 프레임 마나바 텍스트 형식 설정"
L["Show target name"] = "대상 이름 보임"
L["Show target name inside the frame"] = "대상 체력바 안에 대상 이름 넣기"
L["Show target of target frame"] = "대상의 대상 프레임 보임"
L["Show target combat texture (outside the frame)"] = "대상 프레임 전투 텍스처 보임 (프레임 밖)"
L["Show or hide target red background texture (blinking red glow outside the frame in combat)"] = "타겟 프레임에 적색 배경텍스처 보임/숨김 (전투 시 프레임 밖에서 붉게 빛나며 깜박거림)"
L["Show blizzard's target castbar"] = "블리자드 대상 시전바 보임"
L["When you change this option you need to reload your UI (because it's Blizzard config variable). \n\nCommand /reload"] = "설정 변경시 UI 다시 로드(블리자드 설정 변수 때문). \n\n명령어 /reload"


L["Focus"] = "주시 대상"
L["In focus options you can set scale focus frame, healthbar text format, etc"] = "주시 프레임 설정에서 대상 프레임 크기, 체력바 텍스트 형식 등 설정 가능"
L["Focus name"] = "주시 대상 이름"
L["Focus name font family"] = "주시 대상 이름 글꼴"
L["Focus name font size"] = "주시 대상 글꼴 크기"
L["Focus name font style"] = "주시 대상 글꼴 스타일"
L["Focus frame scale"] = "주시 프레임 크기"
L["Scale of focus unit frame"] = "주시 유닛 프레임 크기"
L["Focus healthbar text format"] = "주시대상 체력바 텍스트 형식"
L["Set the focus healthbar text format"] = "주시대상 체력바 텍스트 형식 설정"
L["Focus manabar text format"] = "주시 대상 마나바 텍스트 형식"
L["Set the focus manabar text format"] = "주시 대상 마나바 텍스트 형식 설정"
L["Show target of focus frame"] = "주시 대상의 대상 프레임 보임"
L["Show name of focus frame"] = "주시 대상 이름 보임"
L["Show name of focus frame inside the frame"] = "주시 대상 체력바 안에 주시 대상 이름 넣기"
L["Show focus combat texture (outside the frame)"] = "주시 대상 전투 텍스처 보임"
L["Show or hide focus red background texture (blinking red glow outside the frame in combat)"] = "주시대상 프레임에 적색 배경텍스처 보임/숨김 (전투 시 프레임 밖에서 붉게 빛나며 깜박거림)"


L["Pet"] = "펫"
L["In pet options you can set scale pet frame, show/hide pet name, enable/disable pet hit indicators, etc"] = "펫 프레임 설정에서 프레임 크기, 펫 이름, 펫 히트 알람 등 설정 가능"
L["Pet name"] = "펫 이름"
L["Pet name font family"] = "펫 이름 글꼴"
L["Pet name font size"] = "펫 이름 글꼴 크기"
L["Pet name font style"] = "펫 이름 글꼴 스타일"
L["Pet frame scale"] = "펫 프레임 크기"
L["Scale of pet unit frame"] = "펫 유닛 프레임 크기"
L["Lock pet frame"] = "펫 프레임 잠금"
L["Lock or unlock pet frame. When unlocked you can move frame using your mouse (draggable)"] = "펫 프레임 잠금/해제. 프레임 해제시 마우스 드래그로 프레임 이동가능"
L["Pet healthbar text format"] = "펫 체력바 텍스트 형식"
L["Set the pet healthbar text format"] = "펫 체력바 텍스트 형식 설정"
L["Pet manabar text format"] = "펫 마나바 텍스트 형식"
L["Set the pet manabar text format"] = "펫 마나바 텍스트 형식 설정"
L["Show pet name"] = "펫 이름 보임"
L["Show or hide the damage/heal which your pet take on pet unit frame"] = "펫 유닛 프레임에 펫이 받는 피해나 치유 보임/숨김"
L["Show pet combat texture (inside the frame)"] = "펫 전투 텍스처 보임 (프레임 안)"
L["Show or hide pet red background texture (blinking red glow inside the frame in combat)"] = "펫 프레임에 적색 배경텍스처 보임/숨김 (전투 시 프레임 안에서 붉게 빛나며 깜박거림)"
L["Show pet combat texture (outside the frame)"] = "펫 전투 텍스처 보임 (프레임 밖)"
L["Show or hide pet red background texture (blinking red glow outside the frame in combat)"] = "펫 프레임 적색 배경텍스처 보임/숨김 (전투시 프레임 밖에서 붉게 빛나며 깜박거림)"


L["Party"] = "파티"
L["In party options you can set scale party frames, healthbar text format, etc"] = "파티 프레임 설정에서 파티 프레임 크기, 파티원 체력바 텍스트 형식 등 설정 가능"
L["Party frames scale"] = "파티 프레임 크기"
L["Scale of party unit frames"] = "파티 유닛 프임 크기"
L["Party healthbar text format"] = "파티원 체력바 텍스트 형식"
L["Set the party healthbar text format"] = "파티원 체력바 텍스트 형식 설정"
L["Party manabar text format"] = "파티원 마나바 텍스트 형식"
L["Set the party manabar text format"] = "파티원 마나바 텍스트 형식 설정"
L["Party frames names"] = "파티 프레임 이름"
L["Show names of party frames"] = "파티원 이름 보임"
L["Party names font family"] = "파티원 이름 글꼴"
L["Party names font size"] = "파티원 이름 글꼴 크기"
L["Party names font style"] = "파티원 글꼴 스타일"
L["Show party pet frames"] = "파티원 펫 프레임 보기"