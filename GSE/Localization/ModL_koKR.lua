if GetLocale() ~= "koKR" then
    return
end

local L = LibStub("AceLocale-3.0"):NewLocale("GSE", "koKR")

-- Options translation
L["  The Alternative ClassID is "] = "  대체 직업ID는 "
L[" Deleted Orphaned Macro "] = "삭제된 고아 매크로"
--[[Translation missing --]]
L[" from "] = " from "
--[[Translation missing --]]
L[" is not available.  Unable to translate sequence "] = " is not available.  Unable to translate sequence "
--[[Translation missing --]]
L[" macros per Account.  You currently have "] = " macros per Account.  You currently have "
--[[Translation missing --]]
L[" macros per character.  You currently have "] = " macros per character.  You currently have "
--[[Translation missing --]]
L[" sent"] = " sent"
--[[Translation missing --]]
L[" was imported as a new macro."] = " was imported as a new macro."
--[[Translation missing --]]
L[" was imported with the following errors."] = " was imported with the following errors."
--[[Translation missing --]]
L[" was imported."] = " was imported."
L[" was updated to new version."] = "|1이;가; 새 버전으로 업데이트되었습니다."
--[[Translation missing --]]
L["%s macro may cause a 'RestrictedExecution.lua:431' error as it has %s actions when compiled.  This get interesting when you go past 255 actions.  You may need to simplify this macro."] = "%s macro may cause a 'RestrictedExecution.lua:431' error as it has %s actions when compiled.  This get interesting when you go past 255 actions.  You may need to simplify this macro."
--[[Translation missing --]]
L["%s/255 Characters Used"] = "%s/255 Characters Used"
--[[Translation missing --]]
L[", You will need to correct errors in this variable from another source."] = ", You will need to correct errors in this variable from another source."
L["/gse checkmacrosforerrors|r will loop through your macros and check for corrupt macro versions.  This will then show how to correct these issues."] = "/gse checkmacrosforerrors|r 매크로를 반복하고 손상된 매크로 버전을 확인합니다. 그러면 이러한 문제를 수정하는 방법이 표시됩니다."
L["/gse cleanorphans|r will loop through your macros and delete any left over GSE macros that no longer have a sequence to match them."] = "/gse cleanorphans|r 매크로를 반복하고 더 이상 일치하는 시퀀스가 없는 남은 GSE 매크로를 삭제합니다."
L["/gse help|r to get started."] = "/gse help|r를 입력하세요."
L["/gse showspec|r will show your current Specialisation and the SPECID needed to tag any existing macros."] = "/gse showspec|r 현재 전문화 및 기존 매크로에 태그를 지정하는 데 필요한 전문화ID가 표시됩니다."
--[[Translation missing --]]
L["/gse|r again."] = "/gse|r again."
--[[Translation missing --]]
L["/gse|r to get started."] = "/gse|r to get started."
L["/gse|r will list any macros available to your spec.  This will also add any macros available for your current spec to the macro interface."] = "/gse|r 전문화에 사용할 수 있는 모든 매크로를 나열합니다. 이렇게 하면 현재 전문화에 사용 가능한 모든 매크로도 매크로 인터페이스에 추가됩니다."
--[[Translation missing --]]
L["|r.  You can also have a  maximum of "] = "|r.  You can also have a  maximum of "
L["<DEBUG> |r "] = "<디버그> |r"
--[[Translation missing --]]
L["<SEQUENCEDEBUG> |r "] = "<SEQUENCEDEBUG> |r "
--[[Translation missing --]]
L[ [=[A pause can be measured in either clicks or seconds.  It will either wait 5 clicks or 1.5 seconds.
If using seconds, you can also wait for the GCD by entering ~~GCD~~ into the box.]=] ] = ""
L["About"] = "정보"
L["About GSE"] = "GSE 정보"
--[[Translation missing --]]
L["Account Macros"] = "Account Macros"
--[[Translation missing --]]
L["Action Type"] = "Action Type"
--[[Translation missing --]]
L["Actionbar Buttons"] = "Actionbar Buttons"
--[[Translation missing --]]
L["Actionbar Overrides"] = "Actionbar Overrides"
--[[Translation missing --]]
L["ActionButtonUseKeyDown"] = "ActionButtonUseKeyDown"
L["Actions"] = "행동"
L["Add a Loop Block."] = "Loop 블록을 추가합니다."
L["Add a Pause Block."] = "Pause 블록을 추가합니다."
L["Add Action"] = "Action 추가"
L["Add an Action Block."] = "Action 블록을 추가합니다."
L["Add an If Block.  If Blocks allow you to shoose between blocks based on the result of a variable that returns a true or false value."] = "If 블록을 추가합니다. If 블록을 사용하면 참 또는 거짓 값을 반환하는 변수의 결과를 기반으로 블록 중에서 선택할 수 있습니다."
L["Add If"] = "If 추가"
L["Add Loop"] = "Loop 추가"
L["Add Pause"] = "Pause 추가"
--[[Translation missing --]]
L["Add Special KeyBinding"] = "Add Special KeyBinding"
--[[Translation missing --]]
L["Add Talent Loadout"] = "Add Talent Loadout"
--[[Translation missing --]]
L["Addin Version %s contained versions for the following sequences:"] = "Addin Version %s contained versions for the following sequences:"
--[[Translation missing --]]
L["Advanced Export"] = "Advanced Export"
--[[Translation missing --]]
L["Advanced Macro Compiler loaded.|r  Type "] = "Advanced Macro Compiler loaded.|r  Type "
--[[Translation missing --]]
L["All Talent Loadouts"] = "All Talent Loadouts"
--[[Translation missing --]]
L["Allow Variable Editor"] = "Allow Variable Editor"
--[[Translation missing --]]
L["Already Known"] = "Already Known"
L["Alt Keys."] = "Alt 키"
--[[Translation missing --]]
L["Alwaus use the highest rank of spell available.  This is useful for levelling."] = "Alwaus use the highest rank of spell available.  This is useful for levelling."
--[[Translation missing --]]
L["Always use Max Rank"] = "Always use Max Rank"
L["Any Alt Key"] = "Alt 키"
L["Any Control Key"] = "Ctrl 키"
L["Any Shift Key"] = "Shift 키"
L["Are you sure you want to delete %s?  This will delete the macro and all versions.  This action cannot be undone."] = "%s|1을;를; 삭제할까요? 매크로 및 모든 버전이 삭제됩니다. 이는 취소할 수 없습니다."
L["Arena"] = "투기장"
L["Arena setting changed to Default."] = "투기장 설정이 기본값으로 변경되었습니다."
L["As GSE is updated, there may be left over macros that no longer relate to sequences.  This will check for these automatically on logout.  Alternatively this check can be run via /gse cleanorphans"] = "GSE가 업데이트되면 더 이상 시퀀스와 관련이 없는 매크로가 남아 있을 수 있습니다. 이를 접속 종료 시 자동으로 확인합니다. 또는 이 검사는 /gse cleanorphans를 통해 실행할 수 있습니다."
L["Author"] = "작성자"
L["Author Colour"] = "작성자 색상"
L["Automatically Create Macro Icon"] = "매크로 아이콘 자동 생성"
L["Blizzard Functions Colour"] = "블리자드 함수 색상"
L["Block Path"] = "블록 경로"
L["Block Type: %s"] = "블록 유형: %s"
L["Boolean Functions"] = "부울 함수"
L["Boolean Functions are GSE variables that return either a true or false value."] = "부울 함수는 참 또는 거짓 값을 반환하는 GSE 변수입니다."
L["Boolean not found.  There is a problem with %s not returning true or false."] = "부울을 찾을 수 없습니다. %s|1이;가; 참 또는 거짓을 반환하지 않는 문제가 있습니다."
--[[Translation missing --]]
L["Button State"] = "Button State"
L["By setting the default Icon for all macros to be the QuestionMark, the macro button on your toolbar will change every key hit."] = "모든 매크로의 기본 아이콘을 물음표로 설정하면 도구 모음의 매크로 버튼이 키 입력마다 변경됩니다."
--[[Translation missing --]]
L["By setting this value the Sequence Editor will show every sequence for every class."] = "By setting this value the Sequence Editor will show every sequence for every class."
--[[Translation missing --]]
L["By setting this value the Sequence Editor will show every sequence for your class.  Turning this off will only show the class sequences for your current specialisation."] = "By setting this value the Sequence Editor will show every sequence for your class.  Turning this off will only show the class sequences for your current specialisation."
L["Cancel"] = "취소"
--[[Translation missing --]]
L["Changes Left Side, Changes Right Side, Many Changes!!!! Handle It!"] = "Changes Left Side, Changes Right Side, Many Changes!!!! Handle It!"
L["Character"] = "캐릭터"
--[[Translation missing --]]
L["Character Macros"] = "Character Macros"
L["Character Specific Options which override the normal account settings."] = "일반 계정 설정을 무시하는 캐릭터별 옵션입니다."
--[[Translation missing --]]
L["Chat Link"] = "Chat Link"
L["Checks to see if you have a Heart of Azeroth equipped and if so will insert '/cast Heart Essence' into the macro.  If not your macro will skip this line."] = "아제로스의 심장이 장착되어 있는지 확인하고 있으면 매크로에 '/cast 심장의 정수'를 삽입합니다. 없으면 매크로는 이 줄을 건너뜁니다."
L["Choose import action:"] = "가져오기 동작 선택:"
L["Clear"] = "지우기"
L["Clear Common Keybindings"] = "공통 단축키 설정 지우기"
L["Clear Keybindings"] = "단축키 설정 지우기"
--[[Translation missing --]]
L["Clear Spell Cache"] = "Clear Spell Cache"
--[[Translation missing --]]
L["Clicks"] = "Clicks"
L["Close"] = "닫기"
--[[Translation missing --]]
L["Close to Maximum Macros.|r  You can have a maximum of "] = "Close to Maximum Macros.|r  You can have a maximum of "
--[[Translation missing --]]
L["Close to Maximum Personal Macros.|r  You can have a maximum of "] = "Close to Maximum Personal Macros.|r  You can have a maximum of "
L["Colour"] = "색상"
L["Colour and Accessibility Options"] = "색상 및 접근성 옵션"
L["Combat"] = "전투"
L["Command Colour"] = "명령어 색상"
L["Common Solutions to game quirks that seem to affect some people."] = "일부 사람들에게 영향을 미치는 것으로 보이는 게임 문제에 대한 흔한 해결책입니다."
L["Compile"] = "컴파일"
--[[Translation missing --]]
L["Compiled"] = "Compiled"
--[[Translation missing --]]
L["Compiled Macro"] = "Compiled Macro"
L["Compiled Template"] = "컴파일된 템플릿"
--[[Translation missing --]]
L["Compress"] = "Compress"
--[[Translation missing --]]
L["Compress Sequence from Forums"] = "Compress Sequence from Forums"
L["Conditionals Colour"] = "조건부 색상"
L["Configuration"] = "구성"
L["Continue"] = "계속"
L["Control Keys."] = "Ctrl 키"
--[[Translation missing --]]
L["Convert"] = "Convert"
--[[Translation missing --]]
L["Convert this to a GSE3 Template"] = "Convert this to a GSE3 Template"
L["Copy this link and open it in a Browser."] = "이 링크를 복사하고 브라우저에서 엽니다."
L["Copy this link and paste it into a chat window."] = "이 링크를 복사하여 대화창에 붙여넣습니다."
--[[Translation missing --]]
L["Create a new macro in the /macro interface and assign it an Icon. Then reopen this menu.  You cannot create a new macro here but after it has been created you can manage it."] = "Create a new macro in the /macro interface and assign it an Icon. Then reopen this menu.  You cannot create a new macro here but after it has been created you can manage it."
--[[Translation missing --]]
L["Create Human Readable Export"] = "Create Human Readable Export"
--[[Translation missing --]]
L["Create Human Readable Exports"] = "Create Human Readable Exports"
L["Create Icon"] = "아이콘 생성"
L["Create Macro"] = "매크로 생성"
L["Current GCD"] = "현재 글쿨"
L["Current GCD: %s"] = "현재 글쿨: %s"
--[[Translation missing --]]
L["Current Value"] = "Current Value"
L["CVar Settings"] = "CVar 설정"
L["Debug"] = "디버그"
L["Debug Mode Options"] = "디버그 모드 옵션"
L["Debug Output Options"] = "디버그 출력 옵션"
--[[Translation missing --]]
L["Decompress"] = "Decompress"
L["Default Debugger Height"] = "기본 디버거 높이"
L["Default Debugger Width"] = "기본 디버거 너비"
L["Default Editor Height"] = "기본 편집기 높이"
L["Default Editor Width"] = "기본 편집기 너비"
L["Default Import Action"] = "기본 가져오기 동작"
--[[Translation missing --]]
L["Default Keybinding Height"] = "Default Keybinding Height"
--[[Translation missing --]]
L["Default Keybinding Width"] = "Default Keybinding Width"
L["Default Menu Height"] = "기본 메뉴 높이"
L["Default Menu Width"] = "기본 메뉴 너비"
L["Default Version"] = "기본값 버전"
L["Delete"] = "삭제"
L["Delete Block"] = "블록 삭제"
L["Delete Icon"] = "아이콘 삭제"
--[[Translation missing --]]
L[ [=[Delete this Block from the sequence.  
WARNING: If this is a loop this will delete all the blocks inside the loop as well.]=] ] = ""
L["Delete this macro.  This is not able to be undone."] = "이 매크로를 삭제합니다. 이는 취소할 수 없습니다."
L["Delete this variable from the sequence."] = "시퀀스에서 이 변수를 삭제합니다."
--[[Translation missing --]]
L[ [=[Delete this verion of the macro.  This can be undone by closing this window and not saving the change.  
This is different to the Delete button below which will delete this entire macro.]=] ] = ""
L["Delete Variable"] = "변수 삭제"
L["Delete Version"] = "버전 삭제"
L["Disable"] = "사용 안 함"
L["Disable Block"] = "블록 사용 안 함"
L["Disable Editor"] = "편집기 사용 안 함"
--[[Translation missing --]]
L["Disable inbuilt LibActionButton"] = "Disable inbuilt LibActionButton"
L["Disable Sequence"] = "시퀀스 사용 안 함"
L["Disable this block so that it is not executed. If this is a container block, like a loop, all the blocks within it will also be disabled."] = "실행되지 않도록 이 블록을 끕니다. loop와 같은 컨테이너 블록인 경우 그 안의 모든 블록도 비활성화됩니다."
L["Display debug messages in Chat Window"] = "디버그 메시지 채팅창에 표시"
--[[Translation missing --]]
L["Do not compile this Sequence at startup."] = "Do not compile this Sequence at startup."
L["Don't Force"] = "강제 안 함"
L["Drag this icon to your action bar to use this macro. You can change this icon in the /macro window."] = "이 매크로를 사용하려면 행동 단축바에 이 아이콘을 끌어다 놓으세요. /macro 창에서 이 아이콘을 바꿀 수 있습니다."
L["Dragonflight has changed how the /click command operates.  As a result all your macro stubs (found in /macro) have been updated to match the value of the CVar ActionButtonUseKeyDown.  This is a one off configuration change that needs to be done for each character.  You can change this configuration in GSE's Options."] = "용군단은 /click 명령이 작동하는 방식을 변경했습니다. 그 결과 모든 매크로 스텁(/macro에 있음)이 CVar ActionButtonUseKeyDown의 값과 일치하도록 업데이트되었습니다. 이는 각 캐릭터에 대해 수행해야 하는 일회성 구성 변경입니다. GSE 옵션에서 이 구성을 바꿀 수 있습니다."
L["Dungeon"] = "던전"
L["Dungeon setting changed to Default."] = "던전 설정을 기본값으로 바꿉니다."
--[[Translation missing --]]
L["Edit Spell Cache"] = "Edit Spell Cache"
L["Edit this macro directly in Lua. WARNING: This may render the macro unable to operate and can crash your Game Session."] = "Lua에서 이 매크로를 직접 편집합니다. 경고: 이로 인해 매크로가 작동하지 않고 게임 세션이 중단될 수 있습니다."
L["Editor Colours"] = "편집기 색상"
L["Emphasis Colour"] = "강조 색상"
L["Enable"] = "사용"
L["Enable Debug for the following Modules"] = "다음 모듈에 대해 디버그 사용"
L["Enable Mod Debug Mode"] = "Mod 디버그 모드 사용"
--[[Translation missing --]]
L["Enter the implementation link for this variable. Use '= true' or '= false' to test."] = "Enter the implementation link for this variable. Use '= true' or '= false' to test."
--[[Translation missing --]]
L["Error found in version %i of %s."] = "Error found in version %i of %s."
L["Error processing Custom Pause Value.  You will need to recheck your macros."] = "사용자 정의 일시 중지 값을 처리하는 중에 오류가 발생했습니다. 매크로를 다시 확인해야 합니다."
--[[Translation missing --]]
L["Error: Destination path not found."] = "Error: Destination path not found."
--[[Translation missing --]]
L["Error: Source path not found."] = "Error: Source path not found."
--[[Translation missing --]]
L["Error: You cannot move a container to be a child within itself."] = "Error: You cannot move a container to be a child within itself."
--[[Translation missing --]]
L["Experimental Features"] = "Experimental Features"
L["Export"] = "내보내기"
L["Export a Sequence"] = "시퀀스 내보내기"
L["Export Macro Read Only"] = "매크로 읽기 전용 내보내기"
L["Export this Macro."] = "이 매크로를 내보냅니다."
--[[Translation missing --]]
L["Export Variable"] = "Export Variable"
--[[Translation missing --]]
L["Extra Macro Versions of %s has been added."] = "Extra Macro Versions of %s has been added."
--[[Translation missing --]]
L["Filter Sequence Selection"] = "Filter Sequence Selection"
L["Finished scanning for errors.  If no other messages then no errors were found."] = "오류 검사를 완료했습니다. 다른 메시지가 없으면 오류가 발견되지 않은 것입니다."
L["Force CVar State"] = "CVar 상태 강제"
L["General"] = "일반"
L["General Options"] = "일반 옵션"
L["Global"] = "공통"
--[[Translation missing --]]
L["Gnome Sequencer Enhanced"] = "Gnome Sequencer Enhanced"
L["Gnome Sequencer: Compress a Sequence String."] = "Gnome Sequencer: 시퀀스 문자열을 압축합니다."
L["Gnome Sequencer: Sequence Debugger. Monitor the Execution of your Macro"] = "Gnome Sequencer: 시퀀스 디버거. 매크로 실행 모니터링"
L["GnomeSequencer was originally written by semlar of wowinterface.com."] = "GnomeSequencer는 원래 wowinterface.com의 semlar가 작성했습니다."
L["GSE"] = "GSE"
--[[Translation missing --]]
L["GSE - %s's Macros"] = "GSE - %s's Macros"
--[[Translation missing --]]
L["GSE allows plugins to load Collections as plugins.  You can reload a collection by pressing the button below."] = "GSE allows plugins to load Collections as plugins.  You can reload a collection by pressing the button below."
--[[Translation missing --]]
L["GSE Discord"] = "GSE Discord"
L["GSE has a LibDataBroker (LDB) data feed.  List Other GSE Users and their version when in a group on the tooltip to this feed."] = "GSE에는 LibDataBroker (LDB) 데이터 피드가 있습니다. 그룹에 있는 경우 다른 GSE 사용자와 해당 버전을 이 피드의 툴팁에 나열합니다."
L["GSE has a LibDataBroker (LDB) data feed.  Set this option to show queued Out of Combat events in the tooltip."] = "GSE에는 LibDataBroker (LDB) 데이터 피드가 있습니다. 툴팁에 대기 중인 비전투 중 이벤트를 표시하려면 이 옵션을 설정하세요."
L["GSE is a complete rewrite of that addon that allows you create a sequence of macros to be executed at the push of a button."] = "GSE는 버튼을 누르면 실행되는 일련의 매크로를 생성할 수 있는 해당 애드온을 완전히 재작성한 것입니다."
L["GSE is out of date. You can download the newest version from https://www.curseforge.com/wow/addons/gse-gnome-sequencer-enhanced-advanced-macros."] = "GSE가 오래되었습니다. https://www.curseforge.com/wow/addons/gse-gnome-sequencer-enhanced-advanced-macros 에서 최신 버전을 다운로드할 수 있습니다."
L["GSE Macro Stubs have been reset to KeyDown configuration.  The /click command needs to be `/click TEMPLATENAME LeftButton t` (Note the 't' here is required along with the LeftButton.)"] = "GSE 매크로 스텁이 KeyDown 구성으로 재설정되었습니다. /click 명령은 `/click TEMPLATENAME LeftButton t`여야 합니다(여기서 't'는 LeftButton과 함께 필요합니다)."
L["GSE Macro Stubs have been reset to KeyUp configuration.  The /click command needs to be `/click TEMPLATENAME`"] = "GSE 매크로 스텁이 KeyUp 구성으로 재설정되었습니다. /click 명령은 `/click TEMPLATENAME`이어야 합니다."
L["GSE Plugins"] = "GSE 플러그인"
L["GSE Raw Editor"] = "GSE Raw 편집기"
L["GSE stores the base spell and asks WoW to use that ability.  WoW will then choose the current version of the spell.  This toggle switches between showing the Base Spell or the Current Spell."] = "GSE는 기본 주문을 저장하고 WoW에게 그 능력을 사용하도록 요청합니다. 그러면 WoW가 그 주문의 현재 버전을 선택합니다. 이 옵션은 기본 주문 또는 현재 주문 표시 사이를 전환합니다."
L["GSE Users"] = "GSE 사용자"
L["GSE Version: %s"] = "GSE 버전: %s"
--[[Translation missing --]]
L[ [=[GSE was originally forked from GnomeSequencer written by semlar.  It was enhanced by TImothyLuke to include a lot of configuration and boilerplate functionality with a GUI added.  The enhancements pushed the limits of what the original code could handle and was rewritten from scratch into GSE.

GSE itself wouldn't be what it is without the efforts of the people who write sequences with it.  Check out https://discord.gg/gseunited for the things that make this mod work.  Special thanks to Lutechi for creating the original WowLazyMacros community.]=] ] = ""
L["GSE: Advanced Macro Compiler loaded.|r  Type "] = "GSE: 고급 매크로 컴파일러를 불러왔습니다.|r 시작하려면 "
--[[Translation missing --]]
L["GSE: Export"] = "GSE: Export"
L["GSE: Import a Macro String."] = "GSE: 매크로 문자열을 가져옵니다."
L["GSE: Left Click to open the Sequence Editor"] = "GSE: 좌클릭으로 시퀀스 편집기 열기"
--[[Translation missing --]]
L["GSE: Main Menu"] = "GSE: Main Menu"
--[[Translation missing --]]
L["GSE: Middle Click to open the Keybinding Interface"] = "GSE: Middle Click to open the Keybinding Interface"
L["GSE: Middle Click to open the Transmission Interface"] = "GSE: 휠클릭으로 전송 인터페이스 열기"
--[[Translation missing --]]
L["GSE: Record your rotation to a macro."] = "GSE: Record your rotation to a macro."
L["GSE: Right Click to open the Sequence Debugger"] = "GSE: 우클릭으로 시퀀스 디버거 열기"
--[[Translation missing --]]
L["GSE: Whats New in "] = "GSE: Whats New in "
--[[Translation missing --]]
L["GSE2 Retro interface loaded.  Type `%s/gse2 import%s` to import an old GSE2 string or `%s/gse2 edit%s` to mock up a new template using the GSE2 editor."] = "GSE2 Retro interface loaded.  Type `%s/gse2 import%s` to import an old GSE2 string or `%s/gse2 edit%s` to mock up a new template using the GSE2 editor."
L["Help Colour"] = "도움말 색상"
L["Help Information"] = "도움말 정보"
L["Help Link"] = "도움말 링크"
L["Heroic"] = "영웅"
--[[Translation missing --]]
L["Heroic setting changed to Default."] = "Heroic setting changed to Default."
L["Hide Login Message"] = "접속 메시지 숨기기"
L["Hide Minimap Icon"] = "미니맵 아이콘 숨기기"
L["Hide Minimap Icon for LibDataBroker (LDB) data text."] = "LibDataBroker (LDB) 데이터 문자용 미니맵 아이콘을 숨깁니다."
L["Hides the message that GSE is loaded."] = "GSE를 불러왔다는 메시지를 숨깁니다."
L["History"] = "역사"
L["How many macro Clicks to pause for?"] = "일시 중지할 매크로 클릭 수는?"
L["How many milliseconds to pause for?"] = "몇 밀리초 동안 일시 중지할까요?"
--[[Translation missing --]]
L["How many pixels high should Keybindings start at.  Defaults to 500"] = "How many pixels high should Keybindings start at.  Defaults to 500"
--[[Translation missing --]]
L["How many pixels high should the Debuger start at.  Defaults to 500"] = "How many pixels high should the Debuger start at.  Defaults to 500"
L["How many pixels high should the Editor start at.  Defaults to 700"] = "편집기가 시작되어야 하는 픽셀 높이입니다. 기본값은 700입니다."
--[[Translation missing --]]
L["How many pixels high should the Menu start at.  Defaults to 500"] = "How many pixels high should the Menu start at.  Defaults to 500"
--[[Translation missing --]]
L["How many pixels wide should Keybinding start at.  Defaults to 700"] = "How many pixels wide should Keybinding start at.  Defaults to 700"
--[[Translation missing --]]
L["How many pixels wide should the Debugger start at.  Defaults to 700"] = "How many pixels wide should the Debugger start at.  Defaults to 700"
L["How many pixels wide should the Editor start at.  Defaults to 700"] = "편집기가 시작되어야 하는 픽셀 너비입니다. 기본값은 700입니다."
--[[Translation missing --]]
L["How many pixels wide should the Menu start at.  Defaults to 700"] = "How many pixels wide should the Menu start at.  Defaults to 700"
L["How many seconds to pause for?"] = "몇 초 동안 일시 중지할까요?"
--[[Translation missing --]]
L["How many times does this action repeat"] = "How many times does this action repeat"
L["Icon Colour"] = "아이콘 색상"
L["If Blocks require a variable that returns either true or false.  Create the variable first."] = "If 블록에는 참 또는 거짓을 반환하는 변수가 필요합니다. 변수를 먼저 만드세요."
L["If Blocks Require a variable."] = "If 블록에 변수가 필요합니다."
L["Ignore"] = "무시"
--[[Translation missing --]]
L["Implementation Link"] = "Implementation Link"
L["Import"] = "가져오기"
L["Import Macro from Forums"] = "포럼에서 매크로 가져오기"
--[[Translation missing --]]
L["Insert Gamepad KeyBind"] = "Insert Gamepad KeyBind"
--[[Translation missing --]]
L["Insert GSE Sequence"] = "Insert GSE Sequence"
--[[Translation missing --]]
L["Insert GSE Variable"] = "Insert GSE Variable"
--[[Translation missing --]]
L["Insert Mouse KeyBind"] = "Insert Mouse KeyBind"
--[[Translation missing --]]
L["Insert Spell"] = "Insert Spell"
--[[Translation missing --]]
L["Insert Test Case"] = "Insert Test Case"
L["Interval"] = "간격"
L["Invalid value entered into pause block. Needs to be 'GCD' or a Number."] = "Pause 블록에 잘못된 값을 입력했습니다. '글쿨' 또는 숫자여야 합니다."
--[[Translation missing --]]
L["Item"] = "Item"
--[[Translation missing --]]
L["Keybind"] = "Keybind"
--[[Translation missing --]]
L["Keybindings"] = "Keybindings"
--[[Translation missing --]]
L["KeyDown"] = "KeyDown"
--[[Translation missing --]]
L["KeyUp"] = "KeyUp"
L["Language"] = "언어"
L["Language Colour"] = "언어 색상"
--[[Translation missing --]]
L["Last Updated"] = "Last Updated"
L["Left Alt Key"] = "왼쪽 Alt 키"
L["Left Control Key"] = "왼쪽 Ctrl 키"
L["Left Mouse Button"] = "마우스 왼쪽 버튼"
L["Left Shift Key"] = "왼쪽 Shift 키"
--[[Translation missing --]]
L["LibActionButton is used by ConsolePort and Bartender.  Disabling this will use the standard version of this library."] = "LibActionButton is used by ConsolePort and Bartender.  Disabling this will use the standard version of this library."
L["Like a /castsequence macro, it cycles through a series of commands when the button is pushed. However, unlike castsequence, it uses macro text for the commands instead of spells, and it advances every time the button is pushed instead of stopping when it can't cast something."] = "/castsequence 매크로처럼 버튼을 눌렀을 때 일련의 명령을 순환합니다. 그러나 castsequence와 달리 주문 대신 명령에 매크로 텍스트를 사용하고 무언가를 시전할 수 없을 때 멈추지 않고 버튼을 누를 때마다 진행합니다."
L["Load"] = "불러오기"
L["Load Sequence"] = "시퀀스 불러오기"
--[[Translation missing --]]
L["Local Function: "] = "Local Function: "
--[[Translation missing --]]
L["Local Macro"] = "Local Macro"
--[[Translation missing --]]
L["Macro"] = "Macro"
L["Macro Collection to Import."] = "가져올 매크로 컬렉션입니다."
L["Macro Compile Error"] = "매크로 컴파일 오류"
--[[Translation missing --]]
L["Macro found by the name %sPVP%s. Rename this macro to a different name to be able to use it.  WOW has a global object called PVP that is referenced instead of this macro."] = "Macro found by the name %sPVP%s. Rename this macro to a different name to be able to use it.  WOW has a global object called PVP that is referenced instead of this macro."
--[[Translation missing --]]
L["Macro found by the name %sWW%s. Rename this macro to a different name to be able to use it.  WOW has a hidden button called WW that is executed instead of this macro."] = "Macro found by the name %sWW%s. Rename this macro to a different name to be able to use it.  WOW has a hidden button called WW that is executed instead of this macro."
L["Macro Icon"] = "매크로 아이콘"
L["Macro Import Successful."] = "매크로 가져오기에 성공했습니다."
--[[Translation missing --]]
L["Macro Name"] = "Macro Name"
--[[Translation missing --]]
L["Macro Name or Macro Commands"] = "Macro Name or Macro Commands"
--[[Translation missing --]]
L["Macro Template"] = "Macro Template"
L["Macro unable to be imported."] = "매크로를 가져올 수 없습니다."
L["Macro Version %d deleted."] = "매크로 버전 %d|1을;를; 삭제했습니다."
--[[Translation missing --]]
L["Macros"] = "Macros"
--[[Translation missing --]]
L["Manage Keybinds"] = "Manage Keybinds"
--[[Translation missing --]]
L["Manage Macro"] = "Manage Macro"
--[[Translation missing --]]
L["Manage Macro with GSE"] = "Manage Macro with GSE"
--[[Translation missing --]]
L["Manage Macros"] = "Manage Macros"
--[[Translation missing --]]
L["Manage Variables"] = "Manage Variables"
--[[Translation missing --]]
L["Measure"] = "Measure"
--[[Translation missing --]]
L["Merge"] = "Merge"
L["Middle Mouse Button"] = "마우스 가운데 버튼"
L["Millisecond click settings"] = "밀리초 클릭 설정"
--[[Translation missing --]]
L["Milliseconds"] = "Milliseconds"
--[[Translation missing --]]
L["Missing Variable "] = "Missing Variable "
--[[Translation missing --]]
L["modified in other window.  This view is now behind the current sequence."] = "modified in other window.  This view is now behind the current sequence."
L["Mouse Button 4"] = "4번 마우스 버튼"
L["Mouse Button 5"] = "5번 마우스 버튼"
L["Mouse Buttons."] = "마우스 버튼"
L["Move Down"] = "아래로 이동"
L["Move this block down one block."] = "이 블록을 한 블록 아래로 이동합니다."
L["Move this block up one block."] = "이 블록을 한 블록 위로 이동합니다."
L["Move Up"] = "위로 이동"
--[[Translation missing --]]
L["Moved %s to class %s."] = "Moved %s to class %s."
L["MS Click Rate"] = "밀리초 클릭률"
L["Mythic"] = "신화"
--[[Translation missing --]]
L["Mythic setting changed to Default."] = "Mythic setting changed to Default."
L["Mythic+"] = "쐐기"
--[[Translation missing --]]
L["Mythic+ setting changed to Default."] = "Mythic+ setting changed to Default."
L["Name"] = "이름"
L["New"] = "새로 만들기"
--[[Translation missing --]]
L["New Actionbar Override"] = "New Actionbar Override"
--[[Translation missing --]]
L["New KeyBind"] = "New KeyBind"
L["New Sequence Name"] = "새 시퀀스 이름"
L["No"] = "아니오"
--[[Translation missing --]]
L["No changes were made to "] = "No changes were made to "
L["No Help Information "] = "도움말 정보 없음"
L["No Help Information Available"] = "이용 가능한 도움말 정보 없음"
L["Normal Colour"] = "일반 색상"
--[[Translation missing --]]
L["Not Yet Active"] = "Not Yet Active"
L["Notes and help on how this macro works.  What things to remember.  This information is shown in the sequence browser."] = "이 매크로 작동 방식에 대한 참고 및 도움말입니다. 기억해야 할 것입니다. 이 정보는 시퀀스 브라우저에 표시됩니다."
--[[Translation missing --]]
L["OOC Queue Delay"] = "OOC Queue Delay"
--[[Translation missing --]]
L["Open %s in New Window"] = "Open %s in New Window"
L["Opens the GSE Options window"] = "GSE 옵션창을 엽니다."
L["Options"] = "옵션"
--[[Translation missing --]]
L["Options have been reset to defaults."] = "Options have been reset to defaults."
L["Output"] = "출력"
L["Party"] = "파티"
--[[Translation missing --]]
L["Party setting changed to Default."] = "Party setting changed to Default."
L["Pause"] = "일시 중지"
--[[Translation missing --]]
L["Pause for the GCD."] = "Pause for the GCD."
L["Paused"] = "일시 중지됨"
L["Paused - In Combat"] = "일시 중지됨 - 전투 중"
--[[Translation missing --]]
L["Pet"] = "Pet"
--[[Translation missing --]]
L["Pet Ability"] = "Pet Ability"
L["Picks a Custom Colour for emphasis."] = "강조용 사용자 정의 색상을 고릅니다."
L["Picks a Custom Colour for the Author."] = "작성자용 사용자 정의 색상을 고릅니다."
L["Picks a Custom Colour for the Commands."] = "명령어용 사용자 정의 색상을 고릅니다."
L["Picks a Custom Colour for the Mod Names."] = "모드 이름에 대한 사용자 정의 색상을 고릅니다."
L["Picks a Custom Colour to be used for braces and indents."] = "중괄호 및 들여쓰기에 사용할 사용자 정의 색상을 고릅니다."
L["Picks a Custom Colour to be used for Icons."] = "아이콘에 사용할 사용자 정의 색상을 고릅니다."
--[[Translation missing --]]
L["Picks a Custom Colour to be used for language descriptors"] = "Picks a Custom Colour to be used for language descriptors"
L["Picks a Custom Colour to be used for macro conditionals eg [mod:shift]"] = "매크로 조건부(예, [mod:shift])에 사용할 사용자 정의 색상을 고릅니다."
L["Picks a Custom Colour to be used for Macro Keywords like /cast and /target"] = "/cast 및 /target 같은 매크로 키워드에 사용할 사용자 정의 색상을 고릅니다."
L["Picks a Custom Colour to be used for numbers."] = "숫자에 사용할 사용자 정의 색상을 고릅니다."
L["Picks a Custom Colour to be used for Spells and Abilities."] = "주문 및 능력에 사용할 사용자 정의 색상을 고릅니다."
--[[Translation missing --]]
L["Picks a Custom Colour to be used for StepFunctions."] = "Picks a Custom Colour to be used for StepFunctions."
--[[Translation missing --]]
L["Picks a Custom Colour to be used for strings."] = "Picks a Custom Colour to be used for strings."
L["Picks a Custom Colour to be used for unknown terms."] = "알 수 없는 용어에 사용할 사용자 정의 색상을 고릅니다."
L["Picks a Custom Colour to be used normally."] = "평소에 사용할 사용자 정의 색상을 고릅니다."
L["Plugins"] = "플러그인"
--[[Translation missing --]]
L["Print Active Modifiers on Click"] = "Print Active Modifiers on Click"
L["Print to the chat window if the alt, shift, control modifiers as well as the button pressed on each macro keypress."] = "Alt, Shift, Ctrl 보조키뿐만 아니라 각 매크로 키를 누를 때 버튼을 누르면 채팅창에 출력합니다."
L["Priority List (1 12 123 1234)"] = "우선 순위 목록 (1 12 123 1234)"
--[[Translation missing --]]
L["Processing Collection of %s Elements."] = "Processing Collection of %s Elements."
L["PVP"] = "PVP"
--[[Translation missing --]]
L["PVP setting changed to Default."] = "PVP setting changed to Default."
L["Raid"] = "공격대"
--[[Translation missing --]]
L["Raid setting changed to Default."] = "Raid setting changed to Default."
L["Random - It will select .... a spell, any spell"] = "무작위 - 주문, 임의 주문을 선택합니다"
L["Raw Edit"] = "Raw 편집"
--[[Translation missing --]]
L["Ready to Send"] = "Ready to Send"
--[[Translation missing --]]
L["Received Sequence "] = "Received Sequence "
L["Record"] = "기록"
L["Record Macro"] = "매크로 기록"
L["Registered Addons"] = "등록된 애드온"
L["Rename New Macro"] = "새 매크로 이름 바꾸기"
--[[Translation missing --]]
L["Repeat"] = "Repeat"
--[[Translation missing --]]
L["Replace"] = "Replace"
--[[Translation missing --]]
L["Report an Issue"] = "Report an Issue"
--[[Translation missing --]]
L["Request Macro"] = "Request Macro"
--[[Translation missing --]]
L["Request that the user sends you a copy of this macro."] = "Request that the user sends you a copy of this macro."
--[[Translation missing --]]
L["Reset Sequences when out of combat"] = "Reset Sequences when out of combat"
L["Reset this macro when you exit combat."] = "전투를 종료할 때 이 매크로를 초기화합니다."
L["Resets"] = "초기화"
--[[Translation missing --]]
L["Resets sequences back to the initial state when out of combat."] = "Resets sequences back to the initial state when out of combat."
--[[Translation missing --]]
L["Restricted"] = "Restricted"
--[[Translation missing --]]
L["RESTRICTED: Macro specifics disabled by author."] = "RESTRICTED: Macro specifics disabled by author."
L["Resume"] = "재시작"
L["Returns your current Global Cooldown value accounting for your haste if that stat is present."] = "해당 능력치가 있는 경우 가속을 설명하는 현재 전역 재사용 대기시간 값을 반환합니다."
L["Reverse Priority (1 21 321 4321)"] = "역 우선 순위 (1 21 321 4321)"
L["Right Alt Key"] = "오른쪽 Alt 키"
L["Right Control Key"] = "오른쪽 Ctrl 키"
L["Right Mouse Button"] = "마우스 오른쪽 버튼"
L["Right Shift Key"] = "오른쪽 Shift 키"
L["Running"] = "실행 중"
L["Save"] = "저장"
--[[Translation missing --]]
L["Save pending for "] = "Save pending for "
L["Save the changes made to this macro"] = "이 매크로에 대한 변경 사항을 저장합니다."
--[[Translation missing --]]
L["Save the changes made to this variable."] = "Save the changes made to this variable."
--[[Translation missing --]]
L["Saved"] = "Saved"
L["Scenario"] = "시나리오"
--[[Translation missing --]]
L["Scenario setting changed to Default."] = "Scenario setting changed to Default."
--[[Translation missing --]]
L["Seconds"] = "Seconds"
--[[Translation missing --]]
L["Select a Sequence"] = "Select a Sequence"
--[[Translation missing --]]
L["Select Icon"] = "Select Icon"
L["Send"] = "보내기"
L["Send this macro to another GSE player who is on the same server as you are."] = "이 매크로를 같은 서버에 있는 다른 GSE 플레이어에게 보냅니다."
--[[Translation missing --]]
L["Send To"] = "Send To"
L["Sequence"] = "시퀀스"
L["Sequence Compare"] = "시퀀스 비교"
L["Sequence Debugger"] = "시퀀스 디버거"
L["Sequence Editor"] = "시퀀스 편집기"
L["Sequence Name"] = "시퀀스 이름"
--[[Translation missing --]]
L["Sequence Name %s is in Use. Please choose a different name."] = "Sequence Name %s is in Use. Please choose a different name."
L["Sequence Named %s was not specifically designed for this version of the game.  It may need adjustments."] = "이름이 %s인 시퀀스는 이 게임 버전을 위해 특별히 설계되지 않았습니다. 조정이 필요할 수 있습니다."
--[[Translation missing --]]
L["Sequence Reset"] = "Sequence Reset"
--[[Translation missing --]]
L["Sequence to Compress."] = "Sequence to Compress."
--[[Translation missing --]]
L["Sequences"] = "Sequences"
L["Sequential (1 2 3 4)"] = "순서대로 (1 2 3 4)"
L["Set Default Icon QuestionMark"] = "기본 아이콘 물음표로 설정"
--[[Translation missing --]]
L["Set Key to Bind"] = "Set Key to Bind"
L["Shift Keys."] = "Shift 키"
--[[Translation missing --]]
L["Show All Sequences in Editor"] = "Show All Sequences in Editor"
--[[Translation missing --]]
L["Show Class Sequences in Editor"] = "Show Class Sequences in Editor"
L["Show Current Spells"] = "현재 주문 표시"
--[[Translation missing --]]
L["Show Global Sequences in Editor"] = "Show Global Sequences in Editor"
L["Show GSE Users in LDB"] = "GSE 사용자 LDB에 표시"
--[[Translation missing --]]
L["Show next time you login."] = "Show next time you login."
L["Show OOC Queue in LDB"] = "비전투 중 대기열 LDB에 표시"
L["Show the compiled version of this macro."] = "이 매크로의 컴파일된 버전을 표시합니다."
--[[Translation missing --]]
L["Source Language "] = "Source Language "
--[[Translation missing --]]
L["Specialisation"] = "Specialisation"
L["Specialisation / Class ID"] = "전문화 / 직업 ID"
L["SpecID/ClassID Colour"] = "전문화ID/직업ID 색상"
--[[Translation missing --]]
L["Spell"] = "Spell"
--[[Translation missing --]]
L["Spell Cache Editor"] = "Spell Cache Editor"
L["Spell Colour"] = "주문 색상"
--[[Translation missing --]]
L["Spell ID"] = "Spell ID"
--[[Translation missing --]]
L["Spell Name"] = "Spell Name"
--[[Translation missing --]]
L["State"] = "State"
--[[Translation missing --]]
L["Step Function"] = "Step Function"
--[[Translation missing --]]
L["Step Functions"] = "Step Functions"
L["Stop"] = "중지"
L["Store Debug Messages"] = "디버그 메시지 저장"
L["Store output of debug messages in a Global Variable that can be referrenced by other mods."] = "디버그 메시지의 출력을 다른 모드(mod)에서 참조할 수 있는 전역 변수에 저장합니다."
L["String Colour"] = "문자열 색상"
L["Support GSE"] = "GSE 후원"
L["Supporters"] = "후원자"
--[[Translation missing --]]
L["Talent Loadout"] = "Talent Loadout"
L["Talents"] = "특성"
--[[Translation missing --]]
L["Target language "] = "Target language "
--[[Translation missing --]]
L["The author of this Macro."] = "The author of this Macro."
--[[Translation missing --]]
L["The author of this Variable."] = "The author of this Variable."
--[[Translation missing --]]
L[ [=[The block path shows the direct location of a block.  This can be edited to move a block to a different position quickly.  Each block is prefixed by its container.
EG 2.3 means that the block is the third block in a container at level 2.  You can move a block into a container block by specifying the parent block.  You need to press the Okay button to move the block.]=] ] = ""
L["The command "] = "명령어 "
L["The default sizes of each window."] = "각 창의 기본 크기입니다."
--[[Translation missing --]]
L["The delay in seconds between Out of Combat Queue Polls.  The Out of Combat Queue saves changes and updates sequences.  When you hit save or change zones, these actions enter a queue which checks that first you are not in combat before proceeding to complete their task.  After checking the queue it goes to sleep for x seconds before rechecking what is in the queue."] = "The delay in seconds between Out of Combat Queue Polls.  The Out of Combat Queue saves changes and updates sequences.  When you hit save or change zones, these actions enter a queue which checks that first you are not in combat before proceeding to complete their task.  After checking the queue it goes to sleep for x seconds before rechecking what is in the queue."
L["The following people donate monthly via Patreon for the ongoing maintenance and development of GSE.  Their support is greatly appreciated."] = "다음 분들은 GSE의 지속적인 유지 및 개발을 위해 Patreon을 통해 매달 기부하고 있습니다. 후원 대단히 감사합니다."
L["The GSE Out of Combat queue is %s"] = "GSE 비전투 중 대기열이 %s"
--[[Translation missing --]]
L["The GUI has not been loaded.  Please activate this plugin amongst WoW's addons to use the GSE GUI."] = "The GUI has not been loaded.  Please activate this plugin amongst WoW's addons to use the GSE GUI."
--[[Translation missing --]]
L["The GUI is corrupt.  Please ensure that your GSE install is complete."] = "The GUI is corrupt.  Please ensure that your GSE install is complete."
--[[Translation missing --]]
L["The GUI is missing.  Please ensure that your GSE install is complete."] = "The GUI is missing.  Please ensure that your GSE install is complete."
--[[Translation missing --]]
L["The GUI needs updating.  Please ensure that your GSE install is complete."] = "The GUI needs updating.  Please ensure that your GSE install is complete."
L["The milliseconds being used in key click delay."] = "키 클릭 지연에 사용되는 밀리초입니다."
--[[Translation missing --]]
L[ [=[The name of your macro.  This name has to be unique and can only be used for one object.
You can copy this entire macro by changing the name and choosing Save.]=] ] = ""
--[[Translation missing --]]
L[ [=[The step function determines how your macro executes.  Each time you click your macro GSE will go to the next line.  
The next line it chooses varies.  If Random then it will choose any line.  If Sequential it will go to the next line.  
If Priority it will try some spells more often than others.]=] ] = ""
--[[Translation missing --]]
L["The UI has been set to KeyDown configuration.  The /click command needs to be `/click TEMPLATENAME LeftButton t` (Note the 't' here is required along with the LeftButton.)  You will need to check your macros and adjust your click commands."] = "The UI has been set to KeyDown configuration.  The /click command needs to be `/click TEMPLATENAME LeftButton t` (Note the 't' here is required along with the LeftButton.)  You will need to check your macros and adjust your click commands."
--[[Translation missing --]]
L["The UI has been set to KeyUp configuration.  The /click command needs to be `/click TEMPLATENAME` You will need to check your macros and adjust your click commands."] = "The UI has been set to KeyUp configuration.  The /click command needs to be `/click TEMPLATENAME` You will need to check your macros and adjust your click commands."
L["The version of this macro that will be used when you enter raids."] = "공격대에 들어갈 때 사용될 이 매크로의 버전입니다."
L["The version of this macro that will be used where no other version has been configured."] = "다른 버전이 구성되지 않은 경우 사용될 이 매크로의 버전입니다."
L["The version of this macro to use in Arenas.  If this is not specified, GSE will look for a PVP version before the default."] = "투기장에서 사용할 이 매크로의 버전입니다. 지정하지 않으면 GSE는 기본값보다 PVP 버전을 찾습니다."
L["The version of this macro to use in heroic dungeons."] = "영웅 던전에서 사용할 이 매크로의 버전입니다."
L["The version of this macro to use in Mythic Dungeons."] = "신화 던전에서 사용할 이 매크로의 버전입니다."
L["The version of this macro to use in Mythic+ Dungeons."] = "쐐기 던전에서 사용할 이 매크로의 버전입니다."
L["The version of this macro to use in normal dungeons."] = "일반 던전에서 사용할 이 매크로의 버전입니다."
L["The version of this macro to use in PVP."] = "PVP에서 사용할 이 매크로의 버전입니다."
L["The version of this macro to use in Scenarios."] = "시나리오에서 사용할 이 매크로의 버전입니다."
L["The version of this macro to use when in a party in the world."] = "파티에 있을 때 사용할 이 매크로의 버전입니다."
L["The version of this macro to use when in time walking dungeons."] = "시간여행 던전에서 사용할 이 매크로의 버전입니다."
L["There are %i events in out of combat queue"] = "비전투 중 대기열에 이벤트가 %i개 있음"
L["There are no events in out of combat queue"] = "비전투 중 대기열에 이벤트가 없음"
--[[Translation missing --]]
L["There is an error in the sequence that needs to be corrected before it can be saved."] = "There is an error in the sequence that needs to be corrected before it can be saved."
--[[Translation missing --]]
L["There was an error processing "] = "There was an error processing "
--[[Translation missing --]]
L["These options combine to allow you to reset a sequence while it is running.  These options are Cumulative ie they add to each other.  Options Like LeftClick and RightClick won't work together very well."] = "These options combine to allow you to reset a sequence while it is running.  These options are Cumulative ie they add to each other.  Options Like LeftClick and RightClick won't work together very well."
L["This change will not come into effect until you save this macro."] = "이 변경 사항은 이 매크로를 저장할 때까지 적용되지 않습니다."
L["This CVAR makes WoW use your abilities when you press the key not when you release it.  To use GSE in its native configuration this needs to be checked."] = "이 CVAR는 WoW가 키를 놓을 때가 아니라 누를 때 능력을 사용하도록 합니다. 기본 구성에서 GSE를 사용하려면 이를 확인해야 합니다."
--[[Translation missing --]]
L["This function will clear the spell cache and any mappings between individual spellIDs and spellnames.."] = "This function will clear the spell cache and any mappings between individual spellIDs and spellnames.."
--[[Translation missing --]]
L["This function will open a window enabling you to edit the spell cache and any mappings between individual spellIDs and spellnames.."] = "This function will open a window enabling you to edit the spell cache and any mappings between individual spellIDs and spellnames.."
L["This function will remove the SHIFT+N, ALT+N and CTRL+N keybindings for this character.  Useful if [mod:shift] etc conditions don't work in game."] = "이 기능은 이 캐릭터에 대한 SHIFT+N, ALT+N 및 CTRL+N 단축키를 제거합니다. [mod:shift] 등의 조건이 게임에서 작동하지 않는 경우 유용합니다."
L["This function will update macro stubs to support listening to the options below.  This is required to be completed 1 time per character."] = "이 기능은 아래 옵션 수신을 지원하도록 매크로 스텁을 업데이트합니다. 이는 캐릭터당 1회 완료해야 합니다."
L["This is the only version of this macro.  Delete the entire macro to delete this version."] = "이것은 이 매크로의 유일한 버전입니다. 이 버전을 지우려면 전체 매크로를 삭제하세요."
--[[Translation missing --]]
L["This macro is not compatible with this version of the game and cannot be imported."] = "This macro is not compatible with this version of the game and cannot be imported."
--[[Translation missing --]]
L["This macro uses features that are not available in this version. You need to update GSE to %s in order to use this macro."] = "This macro uses features that are not available in this version. You need to update GSE to %s in order to use this macro."
L["This option dumps extra trace information to your chat window to help troubleshoot problems with the mod"] = "이 옵션은 mod 관련 문제를 해결하는 데 도움이 되도록 대화창에 추가 추적 정보를 출력(dump)합니다."
L["This sequence is Read Only and unable to be edited."] = "이 시퀀스는 읽기 전용이며 편집할 수 없습니다."
--[[Translation missing --]]
L["This Sequence was exported from GSE %s."] = "This Sequence was exported from GSE %s."
L["This setting forces the ActionButtonUseKeyDown setting one way or another.  It also reconfigures GSE's Macro Stubs to operate in the specified mode."] = "이 설정은 어떤 식으로든 ActionButtonUseKeyDown 설정을 강제합니다. 또한 지정된 모드에서 작동하도록 GSE의 매크로 스텁을 재구성합니다."
--[[Translation missing --]]
L["This shows the Global Sequences available as well as those for your class."] = "This shows the Global Sequences available as well as those for your class."
L["This version has been modified by TimothyLuke to make the power of GnomeSequencer avaialble to people who are not comfortable with lua programming."] = "이 버전은 Lua 프로그래밍에 익숙하지 않은 사람들이 GnomeSequencer의 기능을 사용할 수 있도록 TimothyLuke가 수정했습니다."
--[[Translation missing --]]
L["This version of GSE is incompatabile with this version of the game."] = "This version of GSE is incompatabile with this version of the game."
L["This will display debug messages for the "] = "디버그 메시지가 표시되는 모듈: "
--[[Translation missing --]]
L["This will display debug messages for the GSE Ingame Transmission and transfer"] = "This will display debug messages for the GSE Ingame Transmission and transfer"
L["This will display debug messages in the Chat window."] = "채팅창에 디버그 메시지를 출력합니다."
L["Timewalking"] = "시간여행"
--[[Translation missing --]]
L["Timewalking setting changed to Default."] = "Timewalking setting changed to Default."
L["Title Colour"] = "제목 색상"
--[[Translation missing --]]
L["To correct this either delete the version via the GSE Editor or enter the following command to delete this macro totally.  %s/run GSE.DeleteSequence (%i, %s)%s"] = "To correct this either delete the version via the GSE Editor or enter the following command to delete this macro totally.  %s/run GSE.DeleteSequence (%i, %s)%s"
L["To get started "] = "시작하려면 "
--[[Translation missing --]]
L["Toy"] = "Toy"
L["Troubleshooting"] = "문제 해결"
--[[Translation missing --]]
L["Two sequences with unknown sources found."] = "Two sequences with unknown sources found."
L["Unable to interpret sequence."] = "시퀀스를 해석할 수 없습니다."
--[[Translation missing --]]
L["Unable to process content.  Fix table and try again."] = "Unable to process content.  Fix table and try again."
--[[Translation missing --]]
L["Unit Name"] = "Unit Name"
L["Unknown Colour"] = "알 수 없음 색상"
--[[Translation missing --]]
L["Unrecognised Import"] = "Unrecognised Import"
L["Update"] = "업데이트"
L["Update Talents"] = "특성 업데이트"
L["Update the stored talents to match the current chosen talents."] = "현재 선택한 특성과 일치하도록 저장된 특성을 업데이트합니다."
--[[Translation missing --]]
L["Updated Macro"] = "Updated Macro"
L["Use Global Account Macros"] = "전역 계정 매크로 사용"
L["Use WLM Export Sequence Format"] = "WLM 내보내기 시퀀스 형식 사용"
--[[Translation missing --]]
L["Variable"] = "Variable"
--[[Translation missing --]]
L["Variable Menu"] = "Variable Menu"
L["Variables"] = "변수"
L["Version"] = "버전"
L["WARNING ONLY"] = "경고만"
--[[Translation missing --]]
L["was unable to be interpreted."] = "was unable to be interpreted."
--[[Translation missing --]]
L["was unable to be programmed.  This macro will not fire until errors in the macro are corrected."] = "was unable to be programmed.  This macro will not fire until errors in the macro are corrected."
L["WeakAuras was not found."] = "WeakAuras를 찾을 수 없습니다."
L["Website or forum URL where a player can get more information or ask questions about this macro."] = "플레이어가 이 매크로에 대해 더 많은 정보를 얻거나 질문할 수 있는 웹사이트 또는 포럼 URL입니다."
--[[Translation missing --]]
L["What are the preferred talents for this macro?"] = "What are the preferred talents for this macro?"
L["What class or spec is this macro for?  If it is for all classes choose Global."] = "이 매크로는 어떤 직업 또는 전문화용입니까? 모든 직업에 해당하는 경우 공통을 고르세요."
--[[Translation missing --]]
L["WhatsNew"] = [=[|cFFFFFFFFGS|r|cFF00FFFFE|r 3.2.18 updates the Actionbar Overrides for Bartender4 and ConsolePort.  This solves the issue of being in flight and not being able to use the GSE Sequence until you left combat.  ElvUI support for this will come in a later update.

|cffff6666Note|r: The paging function has to be turned off for druids and potentially rogues.  The issue is when Bartender4 pages, the bar is replaces with the contents of another hidden bar.  Even if I bind a button to that bar the "click" state is not transferred to the new bar.

The full detail on all of these changes is available on the GSE GitHub wiki - https://github.com/TimothyLuke/GSE-Advanced-Macro-Compiler/wiki
]=]
L["When creating a macro, if there is not a personal character macro space, create an account wide macro."] = "매크로를 만들 때 개인 캐릭터 매크로 공간이 없으면 계정 전체 매크로를 만듭니다."
--[[Translation missing --]]
L["When exporting from GSE create a descriptive export for Discord/Discource forums."] = "When exporting from GSE create a descriptive export for Discord/Discource forums."
--[[Translation missing --]]
L["When GSE imports a sequence and it already exists locally and has local edits, what do you want the default action to be.  Merge - Add the new MacroVersions to the existing Sequence.  Replace - Replace the existing sequence with the new version. Ignore - ignore updates.  This default action will set the default on the Compare screen however if the GUI is not available this will be the action taken."] = "When GSE imports a sequence and it already exists locally and has local edits, what do you want the default action to be.  Merge - Add the new MacroVersions to the existing Sequence.  Replace - Replace the existing sequence with the new version. Ignore - ignore updates.  This default action will set the default on the Compare screen however if the GUI is not available this will be the action taken."
L["When loading or creating a sequence, if it is a global or the macro has an unknown specID automatically create the Macro Stub in Account Macros"] = "시퀀스를 불러오거나 만들 때 Global이거나 매크로에 알 수 없는 전문화 ID가 있는 경우 자동으로 계정 매크로에 매크로 스텁을 생성합니다."
L["When loading or creating a sequence, if it is a macro of the same class automatically create the Macro Stub"] = "시퀀스를 불러오거나 만들 때 같은 직업의 매크로인 경우 자동으로 매크로 스텁을 생성합니다."
L["Window Sizes"] = "창 크기"
L["Yes"] = "예"
L["You cannot delete the Default version of this macro.  Please choose another version to be the Default on the Configuration tab."] = "이 매크로의 기본값 버전은 삭제할 수 없습니다. 구성 탭에서 다른 버전을 기본값으로 선택하세요."
--[[Translation missing --]]
L["You cannot open a new Sequence Editor window while you are in combat.  Please exit combat and then try again."] = "You cannot open a new Sequence Editor window while you are in combat.  Please exit combat and then try again."
L["You need to reload the User Interface to complete this task.  Would you like to do this now?"] = "이 작업을 완료하려면 사용자 인터페이스를 다시 불러와야 합니다. 지금 할까요?"
L["Your ClassID is "] = "직업ID는"
L["Your current Specialisation is "] = "현재 전문화는 "


