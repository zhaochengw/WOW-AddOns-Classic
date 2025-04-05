-- SCT localization information
-- Korean Locale
-- Initial translation by Next96, SayClub
-- Translation by Next96
-- Date 08/09/2006

if GetLocale() ~= "koKR" then return end

local media = LibStub("LibSharedMedia-3.0")

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "피해량", tooltipText = "근접 및 기타(화염, 낙하, 등등...) 피해를 표시합니다."};
SCT.LOCALS.OPTION_EVENT2 = {name = "빗맞힘", tooltipText = "근접공격 빗맞힘 메시지 표시합니다."};
SCT.LOCALS.OPTION_EVENT3 = {name = "피함", tooltipText = "근접공격 피함 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT4 = {name = "막음", tooltipText = "근접공격 막음 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT5 = {name = "방어함", tooltipText = "근접공격 방어함, 부분 방어함 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT6 = {name = "주문 피해량", tooltipText = "주문에 의한 피해를 표시합니다."};
SCT.LOCALS.OPTION_EVENT7 = {name = "치유량", tooltipText = "주문에 의한 치유량을 표시합니다."};
SCT.LOCALS.OPTION_EVENT8 = {name = "주문 저항", tooltipText = "주문에 대한 저항 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT9 = {name = "디버프", tooltipText = "디버프에 걸렸을 때 표시합니다."};
SCT.LOCALS.OPTION_EVENT10 = {name = "흡수함", tooltipText = "피해를 흡수, 반사, 면역 했을 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT11 = {name = "생명력 낮음", tooltipText = "생명력이 낮은 상태일 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT12 = {name = "마나 낮음", tooltipText = "마나가 낮은 상태일 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT13 = {name = "기력/분노 생성", tooltipText = "물약, 아이템, 버프 등으로 인해 마나, 분노, 기력 등이 생성될 때 메시지를 표시합니다(주기적인 생성은 제외)."};
SCT.LOCALS.OPTION_EVENT14 = {name = "전투 상태", tooltipText = "전투중 상태에 들어가거나\n전투중 상태를 벗어날 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT15 = {name = "연계 포인트", tooltipText = "연계 포인트가 모일때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT16 = {name = "명예 점수", tooltipText = "명예 점수를 획득시 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT17 = {name = "버프 걸림", tooltipText = "버프에 걸렸을 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT18 = {name = "효과 사라짐", tooltipText = "버프가 사라질 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT19 = {name = "기술 피해량", tooltipText = "캐릭터의 직업 기술 피해량을 표시합니다(마무리 일격, 천벌의 망치, 살쾡이의 이빨 등등)."};
SCT.LOCALS.OPTION_EVENT20 = {name = "평판", tooltipText = "평판을 획득하거나 또는 평판이 감소될 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT21 = {name = "자신의 치유량", tooltipText = "다른 대상에게 치유시 치유량을 표시합니다."};
SCT.LOCALS.OPTION_EVENT22 = {name = "숙련도", tooltipText = "기술에 대한 숙련도가 증가했을 때 표시합니다."};
SCT.LOCALS.OPTION_EVENT23 = {name = "마무리공격", tooltipText = "대상에게 마지막 공격을 가해 죽였을 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT24 = {name = "중단", tooltipText = "주문 시전의 중단 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT25 = {name = "해제", tooltipText = "해제 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT26 = {name = "룬", tooltipText = "룬 준비완료 메시지를 표시합니다."};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "SCT 사용", tooltipText = "전투 메시지 확장 기능을 사용합니다."};
SCT.LOCALS.OPTION_CHECK2 = { name = "* 테두리 표시", tooltipText = "전투 메시지 좌우에 *를 표시합니다."};
SCT.LOCALS.OPTION_CHECK3 = { name = "치유한 사람", tooltipText = "당신에게 누가 어떤 주문으로 치유를 했는지 표시합니다."};
SCT.LOCALS.OPTION_CHECK4 = { name = "메시지 아래로", tooltipText = "전투 메시지가 위에서 아래 방향으로 스크롤 됩니다."};
SCT.LOCALS.OPTION_CHECK5 = { name = "치명타 고정", tooltipText = "치명타 및 극대화 메시지를 자신의 머리 위치에 고정시킵니다."};
SCT.LOCALS.OPTION_CHECK6 = { name = "피해 주문 속성", tooltipText = "피해 주문의 속성을 표시합니다."};
SCT.LOCALS.OPTION_CHECK7 = { name = "피해량 글꼴 변경", tooltipText = "피해량에 쓰이는 글꼴을 전투메시지 확장에서 사용중인 글꼴로 변경합니다.\n\n알림: 이 기능을 적용하려면 설정 후 반드시 재접속 해야합니다. UI 재실행으로는 작동하지 않습니다."};
SCT.LOCALS.OPTION_CHECK8 = { name = "모든 생성 표시", tooltipText = "전투창에 표시되지 않는 마나/기력/분노 생성도 모두 표시합니다.\n\n알림: 정규 생성 이벤트에 의존성을 가지고 작동하기 때문에 스팸성이 매우 강합니다. 그리고 드루이드가 변신 직후 다시 변신을 풀 때 종종 오작동 하는 경우가 있습니다."};
SCT.LOCALS.OPTION_CHECK10 = { name = "과도한 치유량", tooltipText = "자신 또는 대상에게 얼마나 과도한 치유를 하는지 표시합니다. '자신이 치유한 양' 설정에 의존성을 가지고 있습니다."};
SCT.LOCALS.OPTION_CHECK11 = { name = "소리 경고", tooltipText = "경고 알림할 때 소리를 사용합니다."};
SCT.LOCALS.OPTION_CHECK12 = { name = "주문 피해 색상", tooltipText = "주문 피해량을 속성에 따라 색상으로 표시합니다."};
SCT.LOCALS.OPTION_CHECK13 = { name = "사용자 이벤트 사용", tooltipText = "사용자 이벤트를 사용합니다. 사용하지 않으면 SCT의 메모리 점유율이 낮아집니다."};
SCT.LOCALS.OPTION_CHECK14 = { name = "주문/기술 이름", tooltipText = "대상에게 주문이나 기술로 피해를 입혔을 경우 주문/기술 이름을 표시합니다."};
SCT.LOCALS.OPTION_CHECK15 = { name = "플래시", tooltipText = "치명타 메시지에 플래시효과를 추가하여 표시합니다."};
SCT.LOCALS.OPTION_CHECK16 = { name = "감소/강타 표시", tooltipText = "공격에 감소량을 ~150~과 같이 강타를 ^150^과 같이 표시합니다."};
SCT.LOCALS.OPTION_CHECK17 = { name = "HOT 표시", tooltipText = "다른 마법에 의한 치유 시전시 초과시간을 표시합니다. (단, 선택하면 화면에 많은 메시지를 표시합니다.)"};
SCT.LOCALS.OPTION_CHECK18 = { name = "치유시 이름표 보기", tooltipText = "대상이 힐을 받을 수 있는 경우 이름표를 표시합니다.\n\n우호적인 대상이어야 하며, 이름표를 볼 수 있습니다. 그러나 정확하게 동작하지 않을 수도 있습니다.\n\n취소하려면 체크하지 않고 게임을 재시작해야 합니다."};
SCT.LOCALS.OPTION_CHECK19 = { name = "WoW 치유량 표시 끄기", tooltipText = "와우 기본 치유량 메시지를 표시하지 않습니다."};
SCT.LOCALS.OPTION_CHECK20 = { name = "주문 아이콘", tooltipText = "주문이나 기술 메시지에 아이콘을 표시합니다."};
SCT.LOCALS.OPTION_CHECK21 = { name = "아이콘 표시", tooltipText = "사용자 이벤트의 주문이나 기술 메시지에 아이콘을 표시합니다."};
SCT.LOCALS.OPTION_CHECK22 = { name = "치명타로 표시", tooltipText = "현재 이벤트 메시지를 치명타 메시지로 표시합니다."};
SCT.LOCALS.OPTION_CHECK23 = { name = "치명타", tooltipText = "이 이벤트는 치명타일 때만 표시합니다."};
SCT.LOCALS.OPTION_CHECK24 = { name = "부분 저항", tooltipText = "이 이벤트는 부분 저항시에만 표시합니다."};
SCT.LOCALS.OPTION_CHECK25 = { name = "부분 방어", tooltipText = "이 이벤트는 부분 방어일때만 표시합니다."};
SCT.LOCALS.OPTION_CHECK26 = { name = "부분 흡수", tooltipText = "이 이벤트는 부분 흡수일 때만 표시합니다."};
SCT.LOCALS.OPTION_CHECK27 = { name = "감소", tooltipText = "이 이벤트는 피해량이 감소할 때만 표시합니다."};
SCT.LOCALS.OPTION_CHECK28 = { name = "강타", tooltipText = "이 이벤트는 강타일 때만 표시합니다."};
SCT.LOCALS.OPTION_CHECK29 = { name = "자신의 디버프", tooltipText = "디버프를 걸었을 때, 플레이어의 디버프만 표시합니다(반드시 대상에게만 표시됩니다.)."};
SCT.LOCALS.OPTION_CHECK30 = { name = "숫자 짧게 표시", tooltipText = "1000 이상되는 양의 숫자를 짧게 표시합니다.\n1221 대신에 1.2k\n650199 대신에 650k\n3700321 대신에 3.7m"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="메시지 스크롤 속도조정", minText="빠름", maxText="느림", tooltipText = "메시지 스크롤 속도를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER2 = { name="글씨 크기", minText="작게", maxText="크게", tooltipText = "글자 크기를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER3 = { name="체력 %", minText="10%", maxText="90%", tooltipText = "체력이 몇 % 가 되면 경고 메시지를 출력할 지 조정합니다."};
SCT.LOCALS.OPTION_SLIDER4 = { name="마나 %",  minText="10%", maxText="90%", tooltipText = "마나가 몇 % 가 되면 경고 메시지를 출력할 지 조정합니다."};
SCT.LOCALS.OPTION_SLIDER5 = { name="글자 투명도", minText="0%", maxText="100%", tooltipText = "글자의 투명도를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER6 = { name="메시지 스크롤 거리조정", minText="작게", maxText="크게", tooltipText = "각 메시지가 갱신될 때 글자의 스크롤 범위를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER7 = { name="글자 X 좌표 위치", minText="-600", maxText="600", tooltipText = "글자의 표시 가로 위치를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER8 = { name="글자 Y 좌표 위치", minText="-400", maxText="400", tooltipText = "글자의 표시 세로 위치를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER9 = { name="메시지 X 좌표 위치", minText="-600", maxText="600", tooltipText = "메시지 표시 가로 위치를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER10 = { name="메시지 Y 좌표 위치", minText="-400", maxText="400", tooltipText = "메시지 표시 세로 위치를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER11 = { name="메시지 사라짐 속도", minText="빠름", maxText="느림", tooltipText = "메시지가 사라질 때 속도를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER12 = { name="메시지 크기", minText="작게", maxText="크게", tooltipText = "메시지의 크기를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER13 = { name="치유 필터링", minText="0", maxText="10000", tooltipText = "SCT 메시지로 캐릭터의 치유량 표시를 설정합니다. 토템이나 축복같은 작은 치유등 빈번한 치유량을 설정하는데 유용합니다."};
SCT.LOCALS.OPTION_SLIDER14 = { name="마나 필터링", minText="0", maxText="10000", tooltipText = "SCT로 마나 회복량 표시를 설정합니다. 토템이나 축복같은 작은 마나 회복등 빈번한 마나량을 체크하는데 유용합니다."};
SCT.LOCALS.OPTION_SLIDER15 = { name="HUD 간격", minText="0", maxText="200", tooltipText = "HUD 움직임에서의 왼쪽 오른쪽과의 거리를 설정합니다. 양쪽의 HUD 거리를 다르게 하여 메시지를 알아보기 쉽게 합니다."};
SCT.LOCALS.OPTION_SLIDER16 = { name="짧은 주문 길이", minText="1", maxText="30", tooltipText = "주문 이름을 전체를 표시하지 않고 짧게 표시합니다."};
SCT.LOCALS.OPTION_SLIDER17 = { name="공격력 필터링", minText="0", maxText="10000", tooltipText = "SCT 메시지로 표시할 최소 공격력을 설정합니다. 주기적인 공격력으로 피해 방어량, 작은 도트류를 필터링하는데 좋습니다."};
SCT.LOCALS.OPTION_SLIDER18 = { name="효과 갯수", minText="0", maxText="20", tooltipText = "버프 및 디버프의 갯수를 표시합니다. 0 은 모든 개수를 표시합니다."};

--Spell Color options
SCT.LOCALS.OPTION_COLOR1 = { name=SPELL_SCHOOL0_CAP, tooltipText = SPELL_SCHOOL0_CAP.." 주문에 대한 색상 변경"};
SCT.LOCALS.OPTION_COLOR2 = { name=SPELL_SCHOOL1_CAP, tooltipText = SPELL_SCHOOL1_CAP.." 주문에 대한 색상 변경"};
SCT.LOCALS.OPTION_COLOR3 = { name=SPELL_SCHOOL2_CAP, tooltipText = SPELL_SCHOOL2_CAP.." 주문에 대한 색상 변경"};
SCT.LOCALS.OPTION_COLOR4 = { name=SPELL_SCHOOL3_CAP, tooltipText = SPELL_SCHOOL3_CAP.." 주문에 대한 색상 변경"};
SCT.LOCALS.OPTION_COLOR5 = { name=SPELL_SCHOOL4_CAP, tooltipText = SPELL_SCHOOL4_CAP.." 주문에 대한 색상 변경"};
SCT.LOCALS.OPTION_COLOR6 = { name=SPELL_SCHOOL5_CAP, tooltipText = SPELL_SCHOOL5_CAP.." 주문에 대한 색상 변경"};
SCT.LOCALS.OPTION_COLOR7 = { name=SPELL_SCHOOL6_CAP, tooltipText = SPELL_SCHOOL6_CAP.." 주문에 대한 색상 변경"};
SCT.LOCALS.OPTION_COLOR8 = { name="이벤트 색상", tooltipText = "이 이벤트에 사용할 색상을 변경합니다."};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="전투 메시지 설정 "..SCT.version, tooltipText = "왼쪽 클릭 이동"};
SCT.LOCALS.OPTION_MISC2 = {name="닫기", tooltipText = "주문 색상 설정창을 닫습니다." };
SCT.LOCALS.OPTION_MISC3 = {name="변경", tooltipText = "주문 색상을 변경합니다." };
SCT.LOCALS.OPTION_MISC4 = {name="기타 설정"};
SCT.LOCALS.OPTION_MISC5 = {name="경고 설정"};
SCT.LOCALS.OPTION_MISC6 = {name="글자 움직임 설정"};
SCT.LOCALS.OPTION_MISC7 = {name="프로파일 선택"};
SCT.LOCALS.OPTION_MISC8 = {name="저장 & 닫기", tooltipText = "현재 모든 설정을 저장하고 설정창을 닫습니다."};
SCT.LOCALS.OPTION_MISC9 = {name="초기화", tooltipText = "-경고-\n\n정말로 전투메시지 확장의 설정을 초기화 하시겠습니까?"};
SCT.LOCALS.OPTION_MISC10 = {name="프로파일", tooltipText = "다른 캐릭터의 프로파일을 선택합니다."};
SCT.LOCALS.OPTION_MISC11 = {name="불러오기", tooltipText = "다른 캐릭터의 프로파일을 이 캐릭터의 프로파일로 불러옵니다."};
SCT.LOCALS.OPTION_MISC12 = {name="삭제", tooltipText = "캐릭터 프로파일을 삭제합니다."};
SCT.LOCALS.OPTION_MISC13 = {name="글자 설정" };
SCT.LOCALS.OPTION_MISC14 = {name="글자1"};
SCT.LOCALS.OPTION_MISC15 = {name="메시지"};
SCT.LOCALS.OPTION_MISC16 = {name="움직임"};
SCT.LOCALS.OPTION_MISC17 = {name="주문"};
SCT.LOCALS.OPTION_MISC18 = {name="글자"};
SCT.LOCALS.OPTION_MISC19 = {name="주문"};
SCT.LOCALS.OPTION_MISC20 = {name="글자2"};
SCT.LOCALS.OPTION_MISC21 = {name="이벤트"};
SCT.LOCALS.OPTION_MISC22 = {name="기본 프로파일", tooltipText = "기존의 프로파일 설정"};
SCT.LOCALS.OPTION_MISC23 = {name="최소 프로파일", tooltipText = "성능 향상을 위한 프로파일. 가장 기본적인 sct만을 표시하도록 설정된 프로파일 설정"};
SCT.LOCALS.OPTION_MISC24 = {name="분할 프로파일", tooltipText = "분할된 프로파일. 피해 데미지와 이벤트를 오른쪽에, 치유와 버프를 왼쪽에 표시하는 프로파일 설정"};
SCT.LOCALS.OPTION_MISC25 = {name="Grayhoof 프로파일", tooltipText = "제작자의 프로파일 설정"};
SCT.LOCALS.OPTION_MISC26 = {name="프로파일 선택", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="SCTD 프로파일", tooltipText = "SCTD 프로파일을 불러옵니다. SCTD를 설치했다면 피해 데미지는 오른쪽에 공격 데미지는 왼쪽에 표시합니다. 그리고 나머지는 상단에 표시합니다."};
SCT.LOCALS.OPTION_MISC28 = {name="테스트", tooltipText = "각 프레임 설정에 대한 테스트 메시지를 보냅니다."};
SCT.LOCALS.OPTION_MISC29 = {name="사용자 이벤트"};
SCT.LOCALS.OPTION_MISC30 = {name="이벤트 저장", tooltipText = "현재 사용자 이벤트 변경을 저장합니다."};
SCT.LOCALS.OPTION_MISC31 = {name="이벤트 삭제", tooltipText = "현재 사용자 이벤트를 삭제합니다.", warning="-경고-\n\n이 이벤트를 삭제하시겠습니까?"};
SCT.LOCALS.OPTION_MISC32 = {name="이벤트 추가", tooltipText = "사용자 이벤트를 추가합니다."};
SCT.LOCALS.OPTION_MISC33 = {name="이벤트 초기화", tooltipText = "모든 이벤트를 초기화 하여 sct_event_config.lua에 있는 것만 사용합니다.", warning="-경고-\n\n사용자 이벤트를 삭제하시겠습니까?"};
SCT.LOCALS.OPTION_MISC34 = {name="취소", tooltipText = "이벤트 변경 내용을 취소합니다."};
SCT.LOCALS.OPTION_MISC35 = {name="직업", tooltipText = "이 이벤트를 사용할 직업을 선택합니다.", open="<", close=">"};

--Selections
SCT.LOCALS.OPTION_SELECTION1 = { name="움직임 형태", tooltipText = "글자의 움직임 형태를 선택합니다.", table = {[1] = "세로 (보통)",[2] = "무지개",[3] = "가로",[4] = "아래로 꺾임", [5] = "위로 꺾임", [6] = "오른쪽 대각선", [7] = "HUD 곡선", [8] = "HUD 모서리"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="좌우 움직임 형태", tooltipText = "글자의 왼쪽 또는 오른쪽으로 이동하는 표시형태를 설정합니다.", table = {[1] = "교차",[2] = "피해량을 왼쪽에",[3] = "피해량을 오른쪽에", [4] = "모두 왼쪽", [5] = "모두 오른쪽"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="글꼴", tooltipText = "사용할 글꼴을 선택합니다.", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION4 = { name="글꼴 테두리", tooltipText = "글자의 윤곽선(테두리) 형태를 선택합니다.", table = {[1] = "없음",[2] = "얇게",[3] = "두껍게"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="메시지 글꼴", tooltipText = "메시지에 쓰일 글꼴을 선택합니다.", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION6 = { name="메시지 글꼴 테두리", tooltipText = "메시지의 테두리 형태를 선택합니다.", table = {[1] = "없음",[2] = "얇게",[3] = "두껍게"}};
SCT.LOCALS.OPTION_SELECTION7 = { name="글자 정렬", tooltipText = "글자 자체의 정렬을 설정합니다. 기본적으로 스크롤 방향 가운데로 설정되어 있습니다.", table = {[1] = "오른쪽",[2] = "가운데",[3] = "왼쪽", [4] = "HUD 가운데"}};
SCT.LOCALS.OPTION_SELECTION8 = { name="짧은 주문 형태", tooltipText = "주문이름을 짧게하는 방식", table = {[1] = "자르기",[2] = "간략화"}};
SCT.LOCALS.OPTION_SELECTION9 = { name="아이콘 위치", tooltipText = "메시지의 아이콘 위치를 선택합니다.", table = {[1] = "왼쪽",[2] = "오른쪽", [3] = "내부", [4] = "외부",}};

local eventtypes = {
  ["BUFF"] = "효과 획득",
  ["FADE"] = "효과 사라짐",
  ["MISS"] = "빚맞힘",
  ["HEAL"] = "치유량",
  ["DAMAGE"] = "공격력",
  ["DEATH"] = "죽음",
  ["INTERRUPT"] = "충단",
  ["POWER"] = "파워",
  ["SUMMON"] = "소환",
  ["DISPEL"] = "해제",
  ["CAST"] = "시전",
}

local flags = {
  ["SELF"] = "플레이어",
  ["TARGET"] = "대상",
  ["FOCUS"] = "주시대상",
  ["PET"] = "소환수",
  ["ENEMY"] = "적대세력",
  ["FRIEND"] = "우호세력",
  ["ANY"] = "모두",
}

local frames = {
  [SCT.FRAME1] = SCT.LOCALS.OPTION_MISC14.name,
  [SCT.FRAME2] = SCT.LOCALS.OPTION_MISC20.name,
  [SCT.MSG] = SCT.LOCALS.OPTION_MISC15.name,
}
if SCTD then
  frames[SCT.FRAME3] = "SCTD"
end

local misses = {
  ["ABSORB"] = ABSORB,
  ["DODGE"] = DODGE,
  ["RESIST"] = RESIST,
  ["PARRY"] = PARRY,
  ["MISS"] = MISS,
  ["BLOCK"] = BLOCK,
  ["REFLECT"] = REFLECT,
  ["DEFLECT"] = DEFLECT,
  ["IMMUNE"] = IMMUNE,
  ["EVADE"] = EVADE,
  ["ANY"] = "모두",
}

local power = {
  [SPELL_POWER_MANA] = MANA,
  [SPELL_POWER_RAGE] = RAGE,
  [SPELL_POWER_FOCUS] = FOCUS,
  [SPELL_POWER_ENERGY] = ENERGY,
  --[SPELL_POWER_HAPPINESS] = HAPPINESS_POINTS,
  [SPELL_POWER_RUNES] = RUNES,
  [SPELL_POWER_RUNIC_POWER] = RUNIC_POWER,
  [SPELL_POWER_SOUL_SHARDS] = SHARDS,
  [SPELL_POWER_ECLIPSE] = ECLIPSE,
  [SPELL_POWER_HOLY_POWER] = HOLY_POWER,
  --[SPELL_POWER_ALTERNATE_POWER] = UNKNOWN,
  --[SPELL_POWER_DARK_FORCE] = UNKNOWN,
  [SPELL_POWER_CHI] = CHI_POWER,
  [SPELL_POWER_SHADOW_ORBS] = SHADOW_ORBS,
  [SPELL_POWER_BURNING_EMBERS] = BURNING_EMBERS,
  [SPELL_POWER_DEMONIC_FURY] = DEMONIC_FURY,
  [0] = "모두",
}

--Custom Selections
SCT.LOCALS.OPTION_CUSTOMSELECTION1 = { name="이벤트 유형", tooltipText = "이벤트 유형을 선택합니다.", table = eventtypes};
SCT.LOCALS.OPTION_CUSTOMSELECTION2 = { name="대상", tooltipText = "누구에게 생긴 이벤트 인지 선택합니다.", table = flags};
SCT.LOCALS.OPTION_CUSTOMSELECTION3 = { name="제공자", tooltipText = "이벤트를 사용한 자를 선택합니다.", table = flags};
SCT.LOCALS.OPTION_CUSTOMSELECTION4 = { name="이벤트 프레임", tooltipText = "이 이벤트를 어느 프레임에 표시할 것인지 선택합니다.", table = frames};
SCT.LOCALS.OPTION_CUSTOMSELECTION5 = { name="빗맞힘 유형", tooltipText = "빗맞힘 유형을 선택합니다.", table = misses};
SCT.LOCALS.OPTION_CUSTOMSELECTION6 = { name="파워 유형", tooltipText = "파워 유형을 선택합니다.", table = power};

--EditBox options
SCT.LOCALS.OPTION_EDITBOX1 = { name="이름", tooltipText = "사용자 이벤트의 이름"};
SCT.LOCALS.OPTION_EDITBOX2 = { name="표시", tooltipText = "SCT에 이 이벤트를 표시합니다. *1 - *5를 사용하여 측정값:\n\n*1 - 주문 이름\n*2 - 제공자\n*3 - 대상자\n*4 - 값"};
SCT.LOCALS.OPTION_EDITBOX3 = { name="검색", tooltipText = "주문이나 기술을 검색합니다. 부분 단어를 입력하여 검색할 수 있습니다."};
SCT.LOCALS.OPTION_EDITBOX4 = { name="소리", tooltipText = "이 이벤트 표시시 소리로 알립니다."};
SCT.LOCALS.OPTION_EDITBOX5 = { name="Wave 소리", tooltipText = "이 이벤트에 소리 파일을 추가할 수 있습니다(예: Interface\\AddOns\\MyAddOn\\mysound.ogg or Sound\\Spells\\ShaysBell.ogg)."};
