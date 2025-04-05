if GetLocale() ~= "zhTW" then
    return
end

local L = LibStub("AceLocale-3.0"):NewLocale("GSE", "zhTW")

-- Options translation
L["  The Alternative ClassID is "] = "其他的職業ID"
L[" Deleted Orphaned Macro "] = "刪除未被使用的巨集"
L[" from "] = "來自"
L[" is not available.  Unable to translate sequence "] = "無法使用。無法翻譯該序列"
L[" macros per Account.  You currently have "] = "帳號內巨集。你目前已有"
L[" macros per character.  You currently have "] = "角色內巨集。你目前已有"
L[" sent"] = "發送"
L[" was imported as a new macro."] = "導入為新的巨集。"
L[" was imported with the following errors."] = "導入時出現以下錯誤。"
--[[Translation missing --]]
L[" was imported."] = " was imported."
L[" was updated to new version."] = "已更新為新版本。"
--[[Translation missing --]]
L["%s macro may cause a 'RestrictedExecution.lua:431' error as it has %s actions when compiled.  This get interesting when you go past 255 actions.  You may need to simplify this macro."] = "%s macro may cause a 'RestrictedExecution.lua:431' error as it has %s actions when compiled.  This get interesting when you go past 255 actions.  You may need to simplify this macro."
--[[Translation missing --]]
L["%s/255 Characters Used"] = "%s/255 Characters Used"
--[[Translation missing --]]
L[", You will need to correct errors in this variable from another source."] = ", You will need to correct errors in this variable from another source."
--[[Translation missing --]]
L["/gse checkmacrosforerrors|r will loop through your macros and check for corrupt macro versions.  This will then show how to correct these issues."] = "/gse checkmacrosforerrors|r will loop through your macros and check for corrupt macro versions.  This will then show how to correct these issues."
--[[Translation missing --]]
L["/gse cleanorphans|r will loop through your macros and delete any left over GSE macros that no longer have a sequence to match them."] = "/gse cleanorphans|r will loop through your macros and delete any left over GSE macros that no longer have a sequence to match them."
--[[Translation missing --]]
L["/gse help|r to get started."] = "/gse help|r to get started."
--[[Translation missing --]]
L["/gse showspec|r will show your current Specialisation and the SPECID needed to tag any existing macros."] = "/gse showspec|r will show your current Specialisation and the SPECID needed to tag any existing macros."
--[[Translation missing --]]
L["/gse|r again."] = "/gse|r again."
--[[Translation missing --]]
L["/gse|r to get started."] = "/gse|r to get started."
--[[Translation missing --]]
L["/gse|r will list any macros available to your spec.  This will also add any macros available for your current spec to the macro interface."] = "/gse|r will list any macros available to your spec.  This will also add any macros available for your current spec to the macro interface."
L["|r.  You can also have a  maximum of "] = "|r. 同時你最多可以擁有"
L["<DEBUG> |r "] = "<DEBUG> |r "
L["<SEQUENCEDEBUG> |r "] = "<SEQUENCEDEBUG> |r "
--[[Translation missing --]]
L[ [=[A pause can be measured in either clicks or seconds.  It will either wait 5 clicks or 1.5 seconds.
If using seconds, you can also wait for the GCD by entering ~~GCD~~ into the box.]=] ] = ""
L["About"] = "關於"
L["About GSE"] = "關於 GSE"
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
L["Actions"] = "動作"
L["Add a Loop Block."] = "增加一個迴圈區塊。"
L["Add a Pause Block."] = "增加一個暫停區塊。"
L["Add Action"] = "增加動作"
L["Add an Action Block."] = "增加一個動作區塊。"
--[[Translation missing --]]
L["Add an If Block.  If Blocks allow you to shoose between blocks based on the result of a variable that returns a true or false value."] = "Add an If Block.  If Blocks allow you to shoose between blocks based on the result of a variable that returns a true or false value."
--[[Translation missing --]]
L["Add If"] = "Add If"
L["Add Loop"] = "增加迴圈"
L["Add Pause"] = "增加暫停"
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
L["Alt Keys."] = "Alt 鍵。"
--[[Translation missing --]]
L["Alwaus use the highest rank of spell available.  This is useful for levelling."] = "Alwaus use the highest rank of spell available.  This is useful for levelling."
--[[Translation missing --]]
L["Always use Max Rank"] = "Always use Max Rank"
L["Any Alt Key"] = "任意 Alt 鍵"
L["Any Control Key"] = "任意 Ctrl 鍵"
L["Any Shift Key"] = "任意 Shift 鍵"
L["Are you sure you want to delete %s?  This will delete the macro and all versions.  This action cannot be undone."] = "確定要刪除 %s？這將刪除該巨集和其所有版本。本操作將無法被撤銷。"
L["Arena"] = "競技場"
L["Arena setting changed to Default."] = "競技場設置更改為默認."
--[[Translation missing --]]
L["As GSE is updated, there may be left over macros that no longer relate to sequences.  This will check for these automatically on logout.  Alternatively this check can be run via /gse cleanorphans"] = "As GSE is updated, there may be left over macros that no longer relate to sequences.  This will check for these automatically on logout.  Alternatively this check can be run via /gse cleanorphans"
L["Author"] = "作者"
L["Author Colour"] = "作者顏色"
L["Automatically Create Macro Icon"] = "自動創建巨集圖標"
L["Blizzard Functions Colour"] = "暴雪功能顏色"
--[[Translation missing --]]
L["Block Path"] = "Block Path"
L["Block Type: %s"] = "區塊類型：%s"
--[[Translation missing --]]
L["Boolean Functions"] = "Boolean Functions"
--[[Translation missing --]]
L["Boolean Functions are GSE variables that return either a true or false value."] = "Boolean Functions are GSE variables that return either a true or false value."
--[[Translation missing --]]
L["Boolean not found.  There is a problem with %s not returning true or false."] = "Boolean not found.  There is a problem with %s not returning true or false."
--[[Translation missing --]]
L["Button State"] = "Button State"
L["By setting the default Icon for all macros to be the QuestionMark, the macro button on your toolbar will change every key hit."] = "通過設置巨集的圖標為問號, 使巨集在每次按下時變更圖標."
--[[Translation missing --]]
L["By setting this value the Sequence Editor will show every sequence for every class."] = "By setting this value the Sequence Editor will show every sequence for every class."
--[[Translation missing --]]
L["By setting this value the Sequence Editor will show every sequence for your class.  Turning this off will only show the class sequences for your current specialisation."] = "By setting this value the Sequence Editor will show every sequence for your class.  Turning this off will only show the class sequences for your current specialisation."
L["Cancel"] = "撤銷/取消"
--[[Translation missing --]]
L["Changes Left Side, Changes Right Side, Many Changes!!!! Handle It!"] = "Changes Left Side, Changes Right Side, Many Changes!!!! Handle It!"
--[[Translation missing --]]
L["Character"] = "Character"
--[[Translation missing --]]
L["Character Macros"] = "Character Macros"
--[[Translation missing --]]
L["Character Specific Options which override the normal account settings."] = "Character Specific Options which override the normal account settings."
--[[Translation missing --]]
L["Chat Link"] = "Chat Link"
--[[Translation missing --]]
L["Checks to see if you have a Heart of Azeroth equipped and if so will insert '/cast Heart Essence' into the macro.  If not your macro will skip this line."] = "Checks to see if you have a Heart of Azeroth equipped and if so will insert '/cast Heart Essence' into the macro.  If not your macro will skip this line."
L["Choose import action:"] = "選擇導入動作:"
L["Clear"] = "清除"
--[[Translation missing --]]
L["Clear Common Keybindings"] = "Clear Common Keybindings"
--[[Translation missing --]]
L["Clear Keybindings"] = "Clear Keybindings"
--[[Translation missing --]]
L["Clear Spell Cache"] = "Clear Spell Cache"
--[[Translation missing --]]
L["Clicks"] = "Clicks"
L["Close"] = "關閉"
L["Close to Maximum Macros.|r  You can have a maximum of "] = "接近最大巨集上限.|r 你最多可以有"
L["Close to Maximum Personal Macros.|r  You can have a maximum of "] = "接近最大角色巨集上限.|r 你最多可以有"
L["Colour"] = "顏色"
L["Colour and Accessibility Options"] = "顏色和輔助功能設置"
L["Combat"] = "戰鬥"
L["Command Colour"] = "命令顏色"
--[[Translation missing --]]
L["Common Solutions to game quirks that seem to affect some people."] = "Common Solutions to game quirks that seem to affect some people."
--[[Translation missing --]]
L["Compile"] = "Compile"
--[[Translation missing --]]
L["Compiled"] = "Compiled"
--[[Translation missing --]]
L["Compiled Macro"] = "Compiled Macro"
--[[Translation missing --]]
L["Compiled Template"] = "Compiled Template"
--[[Translation missing --]]
L["Compress"] = "Compress"
--[[Translation missing --]]
L["Compress Sequence from Forums"] = "Compress Sequence from Forums"
L["Conditionals Colour"] = "條件顏色"
L["Configuration"] = "表面配置"
L["Continue"] = "繼續"
L["Control Keys."] = "Ctrl鍵."
--[[Translation missing --]]
L["Convert"] = "Convert"
--[[Translation missing --]]
L["Convert this to a GSE3 Template"] = "Convert this to a GSE3 Template"
L["Copy this link and open it in a Browser."] = "複製此鏈接並在瀏覽器中打開它."
--[[Translation missing --]]
L["Copy this link and paste it into a chat window."] = "Copy this link and paste it into a chat window."
--[[Translation missing --]]
L["Create a new macro in the /macro interface and assign it an Icon. Then reopen this menu.  You cannot create a new macro here but after it has been created you can manage it."] = "Create a new macro in the /macro interface and assign it an Icon. Then reopen this menu.  You cannot create a new macro here but after it has been created you can manage it."
--[[Translation missing --]]
L["Create Human Readable Export"] = "Create Human Readable Export"
--[[Translation missing --]]
L["Create Human Readable Exports"] = "Create Human Readable Exports"
L["Create Icon"] = "創建圖標"
L["Create Macro"] = "創建巨集"
--[[Translation missing --]]
L["Current GCD"] = "Current GCD"
--[[Translation missing --]]
L["Current GCD: %s"] = "Current GCD: %s"
--[[Translation missing --]]
L["Current Value"] = "Current Value"
--[[Translation missing --]]
L["CVar Settings"] = "CVar Settings"
L["Debug"] = "調試"
L["Debug Mode Options"] = "調試模式設置"
L["Debug Output Options"] = "調試輸出設置"
--[[Translation missing --]]
L["Decompress"] = "Decompress"
--[[Translation missing --]]
L["Default Debugger Height"] = "Default Debugger Height"
--[[Translation missing --]]
L["Default Debugger Width"] = "Default Debugger Width"
--[[Translation missing --]]
L["Default Editor Height"] = "Default Editor Height"
--[[Translation missing --]]
L["Default Editor Width"] = "Default Editor Width"
L["Default Import Action"] = "默認導入動作"
--[[Translation missing --]]
L["Default Keybinding Height"] = "Default Keybinding Height"
--[[Translation missing --]]
L["Default Keybinding Width"] = "Default Keybinding Width"
--[[Translation missing --]]
L["Default Menu Height"] = "Default Menu Height"
--[[Translation missing --]]
L["Default Menu Width"] = "Default Menu Width"
L["Default Version"] = "默認版本"
L["Delete"] = "刪除"
--[[Translation missing --]]
L["Delete Block"] = "Delete Block"
L["Delete Icon"] = "刪除圖標"
--[[Translation missing --]]
L[ [=[Delete this Block from the sequence.  
WARNING: If this is a loop this will delete all the blocks inside the loop as well.]=] ] = ""
L["Delete this macro.  This is not able to be undone."] = "刪除此巨集。 這是無法取消的。"
--[[Translation missing --]]
L["Delete this variable from the sequence."] = "Delete this variable from the sequence."
--[[Translation missing --]]
L[ [=[Delete this verion of the macro.  This can be undone by closing this window and not saving the change.  
This is different to the Delete button below which will delete this entire macro.]=] ] = ""
--[[Translation missing --]]
L["Delete Variable"] = "Delete Variable"
L["Delete Version"] = "刪除版本"
L["Disable"] = "禁用"
--[[Translation missing --]]
L["Disable Block"] = "Disable Block"
--[[Translation missing --]]
L["Disable Editor"] = "Disable Editor"
--[[Translation missing --]]
L["Disable inbuilt LibActionButton"] = "Disable inbuilt LibActionButton"
L["Disable Sequence"] = "禁用序列"
--[[Translation missing --]]
L["Disable this block so that it is not executed. If this is a container block, like a loop, all the blocks within it will also be disabled."] = "Disable this block so that it is not executed. If this is a container block, like a loop, all the blocks within it will also be disabled."
L["Display debug messages in Chat Window"] = "在聊天窗口中顯示調試信息"
--[[Translation missing --]]
L["Do not compile this Sequence at startup."] = "Do not compile this Sequence at startup."
--[[Translation missing --]]
L["Don't Force"] = "Don't Force"
L["Drag this icon to your action bar to use this macro. You can change this icon in the /macro window."] = "將此圖標拖到操作欄以使用此巨集. 您可以在 /巨集 窗口中更改此圖標."
--[[Translation missing --]]
L["Dragonflight has changed how the /click command operates.  As a result all your macro stubs (found in /macro) have been updated to match the value of the CVar ActionButtonUseKeyDown.  This is a one off configuration change that needs to be done for each character.  You can change this configuration in GSE's Options."] = "Dragonflight has changed how the /click command operates.  As a result all your macro stubs (found in /macro) have been updated to match the value of the CVar ActionButtonUseKeyDown.  This is a one off configuration change that needs to be done for each character.  You can change this configuration in GSE's Options."
L["Dungeon"] = "地城版本"
--[[Translation missing --]]
L["Dungeon setting changed to Default."] = "Dungeon setting changed to Default."
--[[Translation missing --]]
L["Edit Spell Cache"] = "Edit Spell Cache"
--[[Translation missing --]]
L["Edit this macro directly in Lua. WARNING: This may render the macro unable to operate and can crash your Game Session."] = "Edit this macro directly in Lua. WARNING: This may render the macro unable to operate and can crash your Game Session."
L["Editor Colours"] = "編輯器顏色"
L["Emphasis Colour"] = "強調顏色"
L["Enable"] = "開啟"
L["Enable Debug for the following Modules"] = "開啟調試給以下模塊"
L["Enable Mod Debug Mode"] = "開啟模塊調試模式"
--[[Translation missing --]]
L["Enter the implementation link for this variable. Use '= true' or '= false' to test."] = "Enter the implementation link for this variable. Use '= true' or '= false' to test."
L["Error found in version %i of %s."] = "版本 %i 在序列 %s 中被發現錯誤."
--[[Translation missing --]]
L["Error processing Custom Pause Value.  You will need to recheck your macros."] = "Error processing Custom Pause Value.  You will need to recheck your macros."
--[[Translation missing --]]
L["Error: Destination path not found."] = "Error: Destination path not found."
--[[Translation missing --]]
L["Error: Source path not found."] = "Error: Source path not found."
--[[Translation missing --]]
L["Error: You cannot move a container to be a child within itself."] = "Error: You cannot move a container to be a child within itself."
--[[Translation missing --]]
L["Experimental Features"] = "Experimental Features"
L["Export"] = "導出"
L["Export a Sequence"] = "導出序列"
--[[Translation missing --]]
L["Export Macro Read Only"] = "Export Macro Read Only"
L["Export this Macro."] = "導出這個巨集"
--[[Translation missing --]]
L["Export Variable"] = "Export Variable"
L["Extra Macro Versions of %s has been added."] = "額外巨集版本 %s 已被添加."
--[[Translation missing --]]
L["Filter Sequence Selection"] = "Filter Sequence Selection"
L["Finished scanning for errors.  If no other messages then no errors were found."] = "完成錯誤掃描.如果沒有其他提示消息,則沒有發現錯誤."
--[[Translation missing --]]
L["Force CVar State"] = "Force CVar State"
L["General"] = "常規"
L["General Options"] = "常規設置"
--[[Translation missing --]]
L["Global"] = "Global"
--[[Translation missing --]]
L["Gnome Sequencer Enhanced"] = "Gnome Sequencer Enhanced"
--[[Translation missing --]]
L["Gnome Sequencer: Compress a Sequence String."] = "Gnome Sequencer: Compress a Sequence String."
L["Gnome Sequencer: Sequence Debugger. Monitor the Execution of your Macro"] = "Gnome Sequencer: 序列調試. 監視你的巨集的執行"
L["GnomeSequencer was originally written by semlar of wowinterface.com."] = "GnomeSequencer最初是由wowinterface.com的semlar編寫的."
L["GSE"] = "GSE"
--[[Translation missing --]]
L["GSE - %s's Macros"] = "GSE - %s's Macros"
--[[Translation missing --]]
L["GSE allows plugins to load Collections as plugins.  You can reload a collection by pressing the button below."] = "GSE allows plugins to load Collections as plugins.  You can reload a collection by pressing the button below."
--[[Translation missing --]]
L["GSE Discord"] = "GSE Discord"
L["GSE has a LibDataBroker (LDB) data feed.  List Other GSE Users and their version when in a group on the tooltip to this feed."] = "GSE有一個LibDataBroker（LDB）數據源. 當在提示這一組源時,列出其他GSE的用戶的版本."
L["GSE has a LibDataBroker (LDB) data feed.  Set this option to show queued Out of Combat events in the tooltip."] = "GSE有一個LibDataBroker（LDB）數據源.設置此選項可在提示中顯示序列中的戰鬥外事件."
L["GSE is a complete rewrite of that addon that allows you create a sequence of macros to be executed at the push of a button."] = "GSE是這個插件的完整的重寫.這允許你創建一個巨集的序列,在按下按鈕時執行."
--[[Translation missing --]]
L["GSE is out of date. You can download the newest version from https://www.curseforge.com/wow/addons/gse-gnome-sequencer-enhanced-advanced-macros."] = "GSE is out of date. You can download the newest version from https://www.curseforge.com/wow/addons/gse-gnome-sequencer-enhanced-advanced-macros."
--[[Translation missing --]]
L["GSE Macro Stubs have been reset to KeyDown configuration.  The /click command needs to be `/click TEMPLATENAME LeftButton t` (Note the 't' here is required along with the LeftButton.)"] = "GSE Macro Stubs have been reset to KeyDown configuration.  The /click command needs to be `/click TEMPLATENAME LeftButton t` (Note the 't' here is required along with the LeftButton.)"
--[[Translation missing --]]
L["GSE Macro Stubs have been reset to KeyUp configuration.  The /click command needs to be `/click TEMPLATENAME`"] = "GSE Macro Stubs have been reset to KeyUp configuration.  The /click command needs to be `/click TEMPLATENAME`"
--[[Translation missing --]]
L["GSE Plugins"] = "GSE Plugins"
--[[Translation missing --]]
L["GSE Raw Editor"] = "GSE Raw Editor"
--[[Translation missing --]]
L["GSE stores the base spell and asks WoW to use that ability.  WoW will then choose the current version of the spell.  This toggle switches between showing the Base Spell or the Current Spell."] = "GSE stores the base spell and asks WoW to use that ability.  WoW will then choose the current version of the spell.  This toggle switches between showing the Base Spell or the Current Spell."
L["GSE Users"] = "GSE 用戶"
L["GSE Version: %s"] = "GSE 版本: %s"
--[[Translation missing --]]
L[ [=[GSE was originally forked from GnomeSequencer written by semlar.  It was enhanced by TImothyLuke to include a lot of configuration and boilerplate functionality with a GUI added.  The enhancements pushed the limits of what the original code could handle and was rewritten from scratch into GSE.

GSE itself wouldn't be what it is without the efforts of the people who write sequences with it.  Check out https://discord.gg/gseunited for the things that make this mod work.  Special thanks to Lutechi for creating the original WowLazyMacros community.]=] ] = ""
--[[Translation missing --]]
L["GSE: Advanced Macro Compiler loaded.|r  Type "] = "GSE: Advanced Macro Compiler loaded.|r  Type "
--[[Translation missing --]]
L["GSE: Export"] = "GSE: Export"
--[[Translation missing --]]
L["GSE: Import a Macro String."] = "GSE: Import a Macro String."
L["GSE: Left Click to open the Sequence Editor"] = "GSE: 左鍵單擊以打開序列編輯器"
--[[Translation missing --]]
L["GSE: Main Menu"] = "GSE: Main Menu"
--[[Translation missing --]]
L["GSE: Middle Click to open the Keybinding Interface"] = "GSE: Middle Click to open the Keybinding Interface"
L["GSE: Middle Click to open the Transmission Interface"] = "GSE: 中鍵單擊以打開傳輸接口"
--[[Translation missing --]]
L["GSE: Record your rotation to a macro."] = "GSE: Record your rotation to a macro."
L["GSE: Right Click to open the Sequence Debugger"] = "GSE: 右鍵單擊以打開序列調試器"
--[[Translation missing --]]
L["GSE: Whats New in "] = "GSE: Whats New in "
--[[Translation missing --]]
L["GSE2 Retro interface loaded.  Type `%s/gse2 import%s` to import an old GSE2 string or `%s/gse2 edit%s` to mock up a new template using the GSE2 editor."] = "GSE2 Retro interface loaded.  Type `%s/gse2 import%s` to import an old GSE2 string or `%s/gse2 edit%s` to mock up a new template using the GSE2 editor."
L["Help Colour"] = "幫助顏色"
L["Help Information"] = "幫助信息"
L["Help Link"] = "幫助鏈接"
L["Heroic"] = "英雄難度"
--[[Translation missing --]]
L["Heroic setting changed to Default."] = "Heroic setting changed to Default."
L["Hide Login Message"] = "隱藏加載信息"
L["Hide Minimap Icon"] = "隱藏迷你地圖標"
L["Hide Minimap Icon for LibDataBroker (LDB) data text."] = "隱藏LibDataBroker（LDB）資料夾的迷你地圖圖標。"
L["Hides the message that GSE is loaded."] = "隱藏GSE加載的信息."
L["History"] = "歷史"
--[[Translation missing --]]
L["How many macro Clicks to pause for?"] = "How many macro Clicks to pause for?"
--[[Translation missing --]]
L["How many milliseconds to pause for?"] = "How many milliseconds to pause for?"
--[[Translation missing --]]
L["How many pixels high should Keybindings start at.  Defaults to 500"] = "How many pixels high should Keybindings start at.  Defaults to 500"
--[[Translation missing --]]
L["How many pixels high should the Debuger start at.  Defaults to 500"] = "How many pixels high should the Debuger start at.  Defaults to 500"
--[[Translation missing --]]
L["How many pixels high should the Editor start at.  Defaults to 700"] = "How many pixels high should the Editor start at.  Defaults to 700"
--[[Translation missing --]]
L["How many pixels high should the Menu start at.  Defaults to 500"] = "How many pixels high should the Menu start at.  Defaults to 500"
--[[Translation missing --]]
L["How many pixels wide should Keybinding start at.  Defaults to 700"] = "How many pixels wide should Keybinding start at.  Defaults to 700"
--[[Translation missing --]]
L["How many pixels wide should the Debugger start at.  Defaults to 700"] = "How many pixels wide should the Debugger start at.  Defaults to 700"
--[[Translation missing --]]
L["How many pixels wide should the Editor start at.  Defaults to 700"] = "How many pixels wide should the Editor start at.  Defaults to 700"
--[[Translation missing --]]
L["How many pixels wide should the Menu start at.  Defaults to 700"] = "How many pixels wide should the Menu start at.  Defaults to 700"
--[[Translation missing --]]
L["How many seconds to pause for?"] = "How many seconds to pause for?"
--[[Translation missing --]]
L["How many times does this action repeat"] = "How many times does this action repeat"
L["Icon Colour"] = "圖標顏色"
--[[Translation missing --]]
L["If Blocks require a variable that returns either true or false.  Create the variable first."] = "If Blocks require a variable that returns either true or false.  Create the variable first."
--[[Translation missing --]]
L["If Blocks Require a variable."] = "If Blocks Require a variable."
L["Ignore"] = "忽略"
--[[Translation missing --]]
L["Implementation Link"] = "Implementation Link"
L["Import"] = "導入"
L["Import Macro from Forums"] = "從論壇導入宏"
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
--[[Translation missing --]]
L["Interval"] = "Interval"
--[[Translation missing --]]
L["Invalid value entered into pause block. Needs to be 'GCD' or a Number."] = "Invalid value entered into pause block. Needs to be 'GCD' or a Number."
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
L["Language"] = "語言"
L["Language Colour"] = "語言顏色"
--[[Translation missing --]]
L["Last Updated"] = "Last Updated"
L["Left Alt Key"] = "左Alt鍵"
L["Left Control Key"] = "左Ctrl鍵"
L["Left Mouse Button"] = "鼠標左鍵"
L["Left Shift Key"] = "左Shift鍵"
--[[Translation missing --]]
L["LibActionButton is used by ConsolePort and Bartender.  Disabling this will use the standard version of this library."] = "LibActionButton is used by ConsolePort and Bartender.  Disabling this will use the standard version of this library."
L["Like a /castsequence macro, it cycles through a series of commands when the button is pushed. However, unlike castsequence, it uses macro text for the commands instead of spells, and it advances every time the button is pushed instead of stopping when it can't cast something."] = "像一個/castsequence 巨集, 它在按下按鈕時循環執行一系列命令. 然而, 與/castsequence 不同, 它嚴格使用巨集文本作為命令而不是根據法術狀態, 並且它每次按下按鈕時都會前進而不在它不能釋放時停止."
L["Load"] = "讀取"
L["Load Sequence"] = "讀取序列"
--[[Translation missing --]]
L["Local Function: "] = "Local Function: "
L["Local Macro"] = "本地巨集"
--[[Translation missing --]]
L["Macro"] = "Macro"
L["Macro Collection to Import."] = "巨集集合導入."
--[[Translation missing --]]
L["Macro Compile Error"] = "Macro Compile Error"
--[[Translation missing --]]
L["Macro found by the name %sPVP%s. Rename this macro to a different name to be able to use it.  WOW has a global object called PVP that is referenced instead of this macro."] = "Macro found by the name %sPVP%s. Rename this macro to a different name to be able to use it.  WOW has a global object called PVP that is referenced instead of this macro."
L["Macro found by the name %sWW%s. Rename this macro to a different name to be able to use it.  WOW has a hidden button called WW that is executed instead of this macro."] = "巨集被命名為 %sWW%s .重命名此巨集以能使用此巨集.魔獸世界有一個隱藏的名為\"WW\"的按鈕,使用此巨集實際上會點擊該按鈕而不是使用此巨集."
L["Macro Icon"] = "巨集圖標"
L["Macro Import Successful."] = "巨集導入成功."
--[[Translation missing --]]
L["Macro Name"] = "Macro Name"
--[[Translation missing --]]
L["Macro Name or Macro Commands"] = "Macro Name or Macro Commands"
--[[Translation missing --]]
L["Macro Template"] = "Macro Template"
L["Macro unable to be imported."] = "無法導入巨集."
L["Macro Version %d deleted."] = "巨集版本%d 已刪除."
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
L["Merge"] = "合併"
L["Middle Mouse Button"] = "鼠標中鍵"
--[[Translation missing --]]
L["Millisecond click settings"] = "Millisecond click settings"
--[[Translation missing --]]
L["Milliseconds"] = "Milliseconds"
--[[Translation missing --]]
L["Missing Variable "] = "Missing Variable "
--[[Translation missing --]]
L["modified in other window.  This view is now behind the current sequence."] = "modified in other window.  This view is now behind the current sequence."
L["Mouse Button 4"] = "鼠標鍵4"
L["Mouse Button 5"] = "鼠標鍵5"
L["Mouse Buttons."] = "鼠標鍵."
--[[Translation missing --]]
L["Move Down"] = "Move Down"
--[[Translation missing --]]
L["Move this block down one block."] = "Move this block down one block."
--[[Translation missing --]]
L["Move this block up one block."] = "Move this block up one block."
--[[Translation missing --]]
L["Move Up"] = "Move Up"
L["Moved %s to class %s."] = "移動 %s 到職業 %s ."
--[[Translation missing --]]
L["MS Click Rate"] = "MS Click Rate"
L["Mythic"] = "史詩難度"
--[[Translation missing --]]
L["Mythic setting changed to Default."] = "Mythic setting changed to Default."
L["Mythic+"] = "史詩難度+"
L["Mythic+ setting changed to Default."] = "史詩難度+設置更改為默認."
--[[Translation missing --]]
L["Name"] = "Name"
L["New"] = "新的"
--[[Translation missing --]]
L["New Actionbar Override"] = "New Actionbar Override"
--[[Translation missing --]]
L["New KeyBind"] = "New KeyBind"
L["New Sequence Name"] = "新序列名稱"
L["No"] = "否"
L["No changes were made to "] = "沒有改變被應用到"
L["No Help Information "] = "無幫助信息"
L["No Help Information Available"] = "沒有幫助信息可用"
L["Normal Colour"] = "通常顏色"
--[[Translation missing --]]
L["Not Yet Active"] = "Not Yet Active"
L["Notes and help on how this macro works.  What things to remember.  This information is shown in the sequence browser."] = "有關此巨集如何工作的註釋和幫助。 要記住什麼。 此信息顯示在序列瀏覽器中。"
--[[Translation missing --]]
L["OOC Queue Delay"] = "OOC Queue Delay"
--[[Translation missing --]]
L["Open %s in New Window"] = "Open %s in New Window"
L["Opens the GSE Options window"] = "打開GSE選項窗口"
L["Options"] = "設置"
L["Options have been reset to defaults."] = "設置已被重置為默認值."
L["Output"] = "導出"
--[[Translation missing --]]
L["Party"] = "Party"
--[[Translation missing --]]
L["Party setting changed to Default."] = "Party setting changed to Default."
L["Pause"] = "暫停"
--[[Translation missing --]]
L["Pause for the GCD."] = "Pause for the GCD."
L["Paused"] = "已暫停"
L["Paused - In Combat"] = "已暫停 - 在戰鬥中"
--[[Translation missing --]]
L["Pet"] = "Pet"
--[[Translation missing --]]
L["Pet Ability"] = "Pet Ability"
L["Picks a Custom Colour for emphasis."] = "拾取一個顏色給強調."
L["Picks a Custom Colour for the Author."] = "拾取一個顏色給作者."
L["Picks a Custom Colour for the Commands."] = "拾取一個顏色給命令."
L["Picks a Custom Colour for the Mod Names."] = "拾取一個顏色給MOD名稱."
L["Picks a Custom Colour to be used for braces and indents."] = "選擇要使用的自定義顏色給框架和縮進."
L["Picks a Custom Colour to be used for Icons."] = "選擇要使用的自定義顏色給圖標."
L["Picks a Custom Colour to be used for language descriptors"] = "選擇要使用的自定義顏色給語言描述"
L["Picks a Custom Colour to be used for macro conditionals eg [mod:shift]"] = "選擇要使用的自定義顏色給巨集按鍵條件,如:[mod:shift]"
L["Picks a Custom Colour to be used for Macro Keywords like /cast and /target"] = "選擇要使用的自定義顏色給巨集關鍵字,如: /cast 和 /target"
L["Picks a Custom Colour to be used for numbers."] = "選擇要使用的自定義顏色給數字."
L["Picks a Custom Colour to be used for Spells and Abilities."] = "選擇要使用的自定義顏色給法術和技能."
L["Picks a Custom Colour to be used for StepFunctions."] = "選擇要使用的自定義顏色給步驟方法."
L["Picks a Custom Colour to be used for strings."] = "選擇要使用的自定義顏色給字符串."
L["Picks a Custom Colour to be used for unknown terms."] = "選擇要使用的自定義顏色給未知術語."
L["Picks a Custom Colour to be used normally."] = "選擇要使用的自定義顏色給常用顏色."
L["Plugins"] = "插件"
--[[Translation missing --]]
L["Print Active Modifiers on Click"] = "Print Active Modifiers on Click"
L["Print to the chat window if the alt, shift, control modifiers as well as the button pressed on each macro keypress."] = "當巨集按鈕按下時,如果同時按下Alt,Shift,Ctrl鍵,則輸出至聊天窗口."
L["Priority List (1 12 123 1234)"] = "優先級列表 (1 12 123 1234)"
--[[Translation missing --]]
L["Processing Collection of %s Elements."] = "Processing Collection of %s Elements."
L["PVP"] = "PVP"
L["PVP setting changed to Default."] = "PVP設置更改為默認值."
L["Raid"] = "Raid"
--[[Translation missing --]]
L["Raid setting changed to Default."] = "Raid setting changed to Default."
L["Random - It will select .... a spell, any spell"] = "隨機 - 它將選擇......一個咒語，任何咒語"
--[[Translation missing --]]
L["Raw Edit"] = "Raw Edit"
L["Ready to Send"] = "準備發送"
L["Received Sequence "] = "接收序列"
L["Record"] = "記錄"
L["Record Macro"] = "記錄巨集"
L["Registered Addons"] = "註冊插件"
L["Rename New Macro"] = "重命名新巨集"
--[[Translation missing --]]
L["Repeat"] = "Repeat"
L["Replace"] = "替換"
--[[Translation missing --]]
L["Report an Issue"] = "Report an Issue"
--[[Translation missing --]]
L["Request Macro"] = "Request Macro"
--[[Translation missing --]]
L["Request that the user sends you a copy of this macro."] = "Request that the user sends you a copy of this macro."
--[[Translation missing --]]
L["Reset Sequences when out of combat"] = "Reset Sequences when out of combat"
L["Reset this macro when you exit combat."] = "退出戰鬥時重置此巨集."
L["Resets"] = "重置"
--[[Translation missing --]]
L["Resets sequences back to the initial state when out of combat."] = "Resets sequences back to the initial state when out of combat."
--[[Translation missing --]]
L["Restricted"] = "Restricted"
--[[Translation missing --]]
L["RESTRICTED: Macro specifics disabled by author."] = "RESTRICTED: Macro specifics disabled by author."
L["Resume"] = "恢復"
--[[Translation missing --]]
L["Returns your current Global Cooldown value accounting for your haste if that stat is present."] = "Returns your current Global Cooldown value accounting for your haste if that stat is present."
--[[Translation missing --]]
L["Reverse Priority (1 21 321 4321)"] = "Reverse Priority (1 21 321 4321)"
L["Right Alt Key"] = "右Alt鍵"
L["Right Control Key"] = "右Ctrl鍵"
L["Right Mouse Button"] = "鼠標右鍵"
L["Right Shift Key"] = "右Shift鍵"
L["Running"] = "運行"
L["Save"] = "保存"
--[[Translation missing --]]
L["Save pending for "] = "Save pending for "
L["Save the changes made to this macro"] = "保存對此巨集所做的更改"
--[[Translation missing --]]
L["Save the changes made to this variable."] = "Save the changes made to this variable."
--[[Translation missing --]]
L["Saved"] = "Saved"
--[[Translation missing --]]
L["Scenario"] = "Scenario"
--[[Translation missing --]]
L["Scenario setting changed to Default."] = "Scenario setting changed to Default."
--[[Translation missing --]]
L["Seconds"] = "Seconds"
--[[Translation missing --]]
L["Select a Sequence"] = "Select a Sequence"
--[[Translation missing --]]
L["Select Icon"] = "Select Icon"
L["Send"] = "發送"
L["Send this macro to another GSE player who is on the same server as you are."] = "將此巨集發送給與您在同一服務器上的另一個GSE播放器."
L["Send To"] = "發送至"
L["Sequence"] = "序列(巨集主體)"
L["Sequence Compare"] = "序列對比"
L["Sequence Debugger"] = "序列調試器"
L["Sequence Editor"] = "序列編輯器"
L["Sequence Name"] = "序列名稱"
L["Sequence Name %s is in Use. Please choose a different name."] = "序列名稱 %s 已被使用.請選擇一個不同的名稱."
--[[Translation missing --]]
L["Sequence Named %s was not specifically designed for this version of the game.  It may need adjustments."] = "Sequence Named %s was not specifically designed for this version of the game.  It may need adjustments."
--[[Translation missing --]]
L["Sequence Reset"] = "Sequence Reset"
--[[Translation missing --]]
L["Sequence to Compress."] = "Sequence to Compress."
--[[Translation missing --]]
L["Sequences"] = "Sequences"
L["Sequential (1 2 3 4)"] = "順序 (1 2 3 4)"
L["Set Default Icon QuestionMark"] = "設置默認圖標為問號"
--[[Translation missing --]]
L["Set Key to Bind"] = "Set Key to Bind"
L["Shift Keys."] = "Shift鍵."
--[[Translation missing --]]
L["Show All Sequences in Editor"] = "Show All Sequences in Editor"
--[[Translation missing --]]
L["Show Class Sequences in Editor"] = "Show Class Sequences in Editor"
--[[Translation missing --]]
L["Show Current Spells"] = "Show Current Spells"
--[[Translation missing --]]
L["Show Global Sequences in Editor"] = "Show Global Sequences in Editor"
L["Show GSE Users in LDB"] = "在LDB中顯示GSE用戶"
--[[Translation missing --]]
L["Show next time you login."] = "Show next time you login."
L["Show OOC Queue in LDB"] = "在LDB中顯示OOC隊列"
--[[Translation missing --]]
L["Show the compiled version of this macro."] = "Show the compiled version of this macro."
L["Source Language "] = "語言來源"
--[[Translation missing --]]
L["Specialisation"] = "Specialisation"
L["Specialisation / Class ID"] = "專精 / 職業 ID"
L["SpecID/ClassID Colour"] = "天賦ID/職業ID 顏色"
--[[Translation missing --]]
L["Spell"] = "Spell"
--[[Translation missing --]]
L["Spell Cache Editor"] = "Spell Cache Editor"
L["Spell Colour"] = "法術顏色"
--[[Translation missing --]]
L["Spell ID"] = "Spell ID"
--[[Translation missing --]]
L["Spell Name"] = "Spell Name"
--[[Translation missing --]]
L["State"] = "State"
L["Step Function"] = "步驟方法"
L["Step Functions"] = "步驟方式運轉"
L["Stop"] = "停止"
L["Store Debug Messages"] = "儲存調試消息"
L["Store output of debug messages in a Global Variable that can be referrenced by other mods."] = "將調試消息的輸出存儲在可由其他mod引用的全局變量中."
L["String Colour"] = "字符串顏色"
--[[Translation missing --]]
L["Support GSE"] = "Support GSE"
L["Supporters"] = "支持者"
--[[Translation missing --]]
L["Talent Loadout"] = "Talent Loadout"
L["Talents"] = "天賦"
L["Target language "] = "目標語言"
--[[Translation missing --]]
L["The author of this Macro."] = "The author of this Macro."
--[[Translation missing --]]
L["The author of this Variable."] = "The author of this Variable."
--[[Translation missing --]]
L[ [=[The block path shows the direct location of a block.  This can be edited to move a block to a different position quickly.  Each block is prefixed by its container.
EG 2.3 means that the block is the third block in a container at level 2.  You can move a block into a container block by specifying the parent block.  You need to press the Okay button to move the block.]=] ] = ""
L["The command "] = "命令"
--[[Translation missing --]]
L["The default sizes of each window."] = "The default sizes of each window."
--[[Translation missing --]]
L["The delay in seconds between Out of Combat Queue Polls.  The Out of Combat Queue saves changes and updates sequences.  When you hit save or change zones, these actions enter a queue which checks that first you are not in combat before proceeding to complete their task.  After checking the queue it goes to sleep for x seconds before rechecking what is in the queue."] = "The delay in seconds between Out of Combat Queue Polls.  The Out of Combat Queue saves changes and updates sequences.  When you hit save or change zones, these actions enter a queue which checks that first you are not in combat before proceeding to complete their task.  After checking the queue it goes to sleep for x seconds before rechecking what is in the queue."
L["The following people donate monthly via Patreon for the ongoing maintenance and development of GSE.  Their support is greatly appreciated."] = "以下人員每月通過Patreon捐贈GSE的持續維護和開發. 非常感謝他們的支持."
L["The GSE Out of Combat queue is %s"] = "GSE插件退出戰鬥序列於 %s"
L["The GUI has not been loaded.  Please activate this plugin amongst WoW's addons to use the GSE GUI."] = "GUI未被加載.請在WoW的插件管理中激活此插件以使用GSE GUI."
--[[Translation missing --]]
L["The GUI is corrupt.  Please ensure that your GSE install is complete."] = "The GUI is corrupt.  Please ensure that your GSE install is complete."
--[[Translation missing --]]
L["The GUI is missing.  Please ensure that your GSE install is complete."] = "The GUI is missing.  Please ensure that your GSE install is complete."
--[[Translation missing --]]
L["The GUI needs updating.  Please ensure that your GSE install is complete."] = "The GUI needs updating.  Please ensure that your GSE install is complete."
--[[Translation missing --]]
L["The milliseconds being used in key click delay."] = "The milliseconds being used in key click delay."
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
L["The version of this macro that will be used when you enter raids."] = "輸入團隊時將使用的此巨集的版本."
L["The version of this macro that will be used where no other version has been configured."] = "此巨集的版本將在最後配置其他版本的情況下使用。"
L["The version of this macro to use in Arenas.  If this is not specified, GSE will look for a PVP version before the default."] = "在Arenas中使用的此巨集的版本. 如果未指定.則GSE將在默認值之前查找PVP版本."
L["The version of this macro to use in heroic dungeons."] = "這個巨集的版本用於英雄地城."
L["The version of this macro to use in Mythic Dungeons."] = "這個巨集的版本在神話地城中使用."
L["The version of this macro to use in Mythic+ Dungeons."] = "這個巨集的版本在神話地城+中使用."
L["The version of this macro to use in normal dungeons."] = "這個巨集的版本在普通地城中使用。"
L["The version of this macro to use in PVP."] = "要在PVP中使用的此巨集的版本."
--[[Translation missing --]]
L["The version of this macro to use in Scenarios."] = "The version of this macro to use in Scenarios."
L["The version of this macro to use when in a party in the world."] = "在全世界中的隊伍中使用的這個巨集的版本。"
L["The version of this macro to use when in time walking dungeons."] = "這個巨集的版本在隨機地城時使用."
L["There are %i events in out of combat queue"] = "離開戰鬥的序列中有 %i 個事件"
L["There are no events in out of combat queue"] = "在離開戰鬥的序列中沒有事件"
--[[Translation missing --]]
L["There is an error in the sequence that needs to be corrected before it can be saved."] = "There is an error in the sequence that needs to be corrected before it can be saved."
--[[Translation missing --]]
L["There was an error processing "] = "There was an error processing "
--[[Translation missing --]]
L["These options combine to allow you to reset a sequence while it is running.  These options are Cumulative ie they add to each other.  Options Like LeftClick and RightClick won't work together very well."] = "These options combine to allow you to reset a sequence while it is running.  These options are Cumulative ie they add to each other.  Options Like LeftClick and RightClick won't work together very well."
L["This change will not come into effect until you save this macro."] = "此更改將不會生效,直到你保存此巨集."
--[[Translation missing --]]
L["This CVAR makes WoW use your abilities when you press the key not when you release it.  To use GSE in its native configuration this needs to be checked."] = "This CVAR makes WoW use your abilities when you press the key not when you release it.  To use GSE in its native configuration this needs to be checked."
--[[Translation missing --]]
L["This function will clear the spell cache and any mappings between individual spellIDs and spellnames.."] = "This function will clear the spell cache and any mappings between individual spellIDs and spellnames.."
--[[Translation missing --]]
L["This function will open a window enabling you to edit the spell cache and any mappings between individual spellIDs and spellnames.."] = "This function will open a window enabling you to edit the spell cache and any mappings between individual spellIDs and spellnames.."
--[[Translation missing --]]
L["This function will remove the SHIFT+N, ALT+N and CTRL+N keybindings for this character.  Useful if [mod:shift] etc conditions don't work in game."] = "This function will remove the SHIFT+N, ALT+N and CTRL+N keybindings for this character.  Useful if [mod:shift] etc conditions don't work in game."
L["This function will update macro stubs to support listening to the options below.  This is required to be completed 1 time per character."] = "此功能將更新巨集存根以支持下面的選項.每個角色都需要運行一次."
L["This is the only version of this macro.  Delete the entire macro to delete this version."] = "這是此巨集的唯一版本. 刪除整個巨集以刪除此版本."
--[[Translation missing --]]
L["This macro is not compatible with this version of the game and cannot be imported."] = "This macro is not compatible with this version of the game and cannot be imported."
--[[Translation missing --]]
L["This macro uses features that are not available in this version. You need to update GSE to %s in order to use this macro."] = "This macro uses features that are not available in this version. You need to update GSE to %s in order to use this macro."
L["This option dumps extra trace information to your chat window to help troubleshoot problems with the mod"] = "此選項將額外的跟踪信息轉儲到聊天窗口,以幫助解決模塊的問題"
--[[Translation missing --]]
L["This sequence is Read Only and unable to be edited."] = "This sequence is Read Only and unable to be edited."
L["This Sequence was exported from GSE %s."] = "該序列導出自GSE %s."
--[[Translation missing --]]
L["This setting forces the ActionButtonUseKeyDown setting one way or another.  It also reconfigures GSE's Macro Stubs to operate in the specified mode."] = "This setting forces the ActionButtonUseKeyDown setting one way or another.  It also reconfigures GSE's Macro Stubs to operate in the specified mode."
--[[Translation missing --]]
L["This shows the Global Sequences available as well as those for your class."] = "This shows the Global Sequences available as well as those for your class."
L["This version has been modified by TimothyLuke to make the power of GnomeSequencer avaialble to people who are not comfortable with lua programming."] = "這個版本已經被TimothyLuke修改,使GnomeSequencer的強大功能可以讓不習慣lua編程的人使用."
--[[Translation missing --]]
L["This version of GSE is incompatabile with this version of the game."] = "This version of GSE is incompatabile with this version of the game."
L["This will display debug messages for the "] = "這將顯示調試消息"
--[[Translation missing --]]
L["This will display debug messages for the GSE Ingame Transmission and transfer"] = "This will display debug messages for the GSE Ingame Transmission and transfer"
L["This will display debug messages in the Chat window."] = "這將在聊天窗口顯示調試消息."
L["Timewalking"] = "時光漫遊"
L["Timewalking setting changed to Default."] = "時光漫遊設置更改為默認."
L["Title Colour"] = "標題顏色"
L["To correct this either delete the version via the GSE Editor or enter the following command to delete this macro totally.  %s/run GSE.DeleteSequence (%i, %s)%s"] = "要糾正或刪除版本,可通過GSE編輯器刪除或輸入下面的命令來完全刪除該巨集. %s/run GSE.DeleteSequence (%i, %s)%s"
L["To get started "] = "獲取上手指南"
--[[Translation missing --]]
L["Toy"] = "Toy"
--[[Translation missing --]]
L["Troubleshooting"] = "Troubleshooting"
L["Two sequences with unknown sources found."] = "找到兩個未知來源的序列."
--[[Translation missing --]]
L["Unable to interpret sequence."] = "Unable to interpret sequence."
--[[Translation missing --]]
L["Unable to process content.  Fix table and try again."] = "Unable to process content.  Fix table and try again."
--[[Translation missing --]]
L["Unit Name"] = "Unit Name"
L["Unknown Colour"] = "未知顏色"
--[[Translation missing --]]
L["Unrecognised Import"] = "Unrecognised Import"
L["Update"] = "更新"
--[[Translation missing --]]
L["Update Talents"] = "Update Talents"
--[[Translation missing --]]
L["Update the stored talents to match the current chosen talents."] = "Update the stored talents to match the current chosen talents."
L["Updated Macro"] = "更新了巨集"
L["Use Global Account Macros"] = "使用帳號全部巨集"
L["Use WLM Export Sequence Format"] = "使用WLM導出序列格式"
--[[Translation missing --]]
L["Variable"] = "Variable"
--[[Translation missing --]]
L["Variable Menu"] = "Variable Menu"
--[[Translation missing --]]
L["Variables"] = "Variables"
--[[Translation missing --]]
L["Version"] = "Version"
--[[Translation missing --]]
L["WARNING ONLY"] = "WARNING ONLY"
--[[Translation missing --]]
L["was unable to be interpreted."] = "was unable to be interpreted."
--[[Translation missing --]]
L["was unable to be programmed.  This macro will not fire until errors in the macro are corrected."] = "was unable to be programmed.  This macro will not fire until errors in the macro are corrected."
--[[Translation missing --]]
L["WeakAuras was not found."] = "WeakAuras was not found."
L["Website or forum URL where a player can get more information or ask questions about this macro."] = "網站或論壇網址.玩家可以獲取更多信息或詢問有關此巨集的問題."
--[[Translation missing --]]
L["What are the preferred talents for this macro?"] = "What are the preferred talents for this macro?"
L["What class or spec is this macro for?  If it is for all classes choose Global."] = "這個巨集的分類或規格是什麼? 如果適用於所有選項，請選擇全部."
--[[Translation missing --]]
L["WhatsNew"] = [=[|cFFFFFFFFGS|r|cFF00FFFFE|r 3.2.18 updates the Actionbar Overrides for Bartender4 and ConsolePort.  This solves the issue of being in flight and not being able to use the GSE Sequence until you left combat.  ElvUI support for this will come in a later update.

|cffff6666Note|r: The paging function has to be turned off for druids and potentially rogues.  The issue is when Bartender4 pages, the bar is replaces with the contents of another hidden bar.  Even if I bind a button to that bar the "click" state is not transferred to the new bar.

The full detail on all of these changes is available on the GSE GitHub wiki - https://github.com/TimothyLuke/GSE-Advanced-Macro-Compiler/wiki
]=]
L["When creating a macro, if there is not a personal character macro space, create an account wide macro."] = "創建巨集時.如果沒有角色巨集空間.就創建帳號通用的巨集."
--[[Translation missing --]]
L["When exporting from GSE create a descriptive export for Discord/Discource forums."] = "When exporting from GSE create a descriptive export for Discord/Discource forums."
--[[Translation missing --]]
L["When GSE imports a sequence and it already exists locally and has local edits, what do you want the default action to be.  Merge - Add the new MacroVersions to the existing Sequence.  Replace - Replace the existing sequence with the new version. Ignore - ignore updates.  This default action will set the default on the Compare screen however if the GUI is not available this will be the action taken."] = "When GSE imports a sequence and it already exists locally and has local edits, what do you want the default action to be.  Merge - Add the new MacroVersions to the existing Sequence.  Replace - Replace the existing sequence with the new version. Ignore - ignore updates.  This default action will set the default on the Compare screen however if the GUI is not available this will be the action taken."
L["When loading or creating a sequence, if it is a global or the macro has an unknown specID automatically create the Macro Stub in Account Macros"] = "加載或創建序列時,如果它是全局巨集或巨集具有未知的天賦ID,則會自動在帳戶巨集中創建巨集存根"
L["When loading or creating a sequence, if it is a macro of the same class automatically create the Macro Stub"] = "當加載或創建序列時,如果它是同職業的巨集,則自動創建巨集存根"
--[[Translation missing --]]
L["Window Sizes"] = "Window Sizes"
L["Yes"] = "是"
L["You cannot delete the Default version of this macro.  Please choose another version to be the Default on the Configuration tab."] = "你不能刪除此巨集的默認版本. 請選擇另一個版本作為配置選項卡上的默認版本."
--[[Translation missing --]]
L["You cannot open a new Sequence Editor window while you are in combat.  Please exit combat and then try again."] = "You cannot open a new Sequence Editor window while you are in combat.  Please exit combat and then try again."
L["You need to reload the User Interface to complete this task.  Would you like to do this now?"] = "你需要重新加載用戶界面以完成此任務. 你現在想這樣做嗎?"
L["Your ClassID is "] = "你的 Class ID 是"
L["Your current Specialisation is "] = "你當前的專精是"


