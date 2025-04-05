if GetLocale() ~= "itIT" then
    return
end

local L = LibStub("AceLocale-3.0"):NewLocale("GSE", "itIT")

-- Options translation
--[[Translation missing --]]
L["  The Alternative ClassID is "] = "  The Alternative ClassID is "
--[[Translation missing --]]
L[" Deleted Orphaned Macro "] = " Deleted Orphaned Macro "
L[" from "] = "da"
--[[Translation missing --]]
L[" is not available.  Unable to translate sequence "] = " is not available.  Unable to translate sequence "
L[" macros per Account.  You currently have "] = "macro per Account. In questo momento hai"
L[" macros per character.  You currently have "] = "macro per personaggio. In questo momento hai"
L[" sent"] = "inviato"
L[" was imported as a new macro."] = "è stata importata come una nuova macro."
--[[Translation missing --]]
L[" was imported with the following errors."] = " was imported with the following errors."
--[[Translation missing --]]
L[" was imported."] = " was imported."
--[[Translation missing --]]
L[" was updated to new version."] = " was updated to new version."
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
--[[Translation missing --]]
L["|r.  You can also have a  maximum of "] = "|r.  You can also have a  maximum of "
--[[Translation missing --]]
L["<DEBUG> |r "] = "<DEBUG> |r "
--[[Translation missing --]]
L["<SEQUENCEDEBUG> |r "] = "<SEQUENCEDEBUG> |r "
--[[Translation missing --]]
L[ [=[A pause can be measured in either clicks or seconds.  It will either wait 5 clicks or 1.5 seconds.
If using seconds, you can also wait for the GCD by entering ~~GCD~~ into the box.]=] ] = ""
--[[Translation missing --]]
L["About"] = "About"
--[[Translation missing --]]
L["About GSE"] = "About GSE"
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
--[[Translation missing --]]
L["Actions"] = "Actions"
--[[Translation missing --]]
L["Add a Loop Block."] = "Add a Loop Block."
--[[Translation missing --]]
L["Add a Pause Block."] = "Add a Pause Block."
--[[Translation missing --]]
L["Add Action"] = "Add Action"
--[[Translation missing --]]
L["Add an Action Block."] = "Add an Action Block."
--[[Translation missing --]]
L["Add an If Block.  If Blocks allow you to shoose between blocks based on the result of a variable that returns a true or false value."] = "Add an If Block.  If Blocks allow you to shoose between blocks based on the result of a variable that returns a true or false value."
--[[Translation missing --]]
L["Add If"] = "Add If"
--[[Translation missing --]]
L["Add Loop"] = "Add Loop"
--[[Translation missing --]]
L["Add Pause"] = "Add Pause"
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
L["Alt Keys."] = "Tasto ALT"
--[[Translation missing --]]
L["Alwaus use the highest rank of spell available.  This is useful for levelling."] = "Alwaus use the highest rank of spell available.  This is useful for levelling."
--[[Translation missing --]]
L["Always use Max Rank"] = "Always use Max Rank"
L["Any Alt Key"] = "Qualsiasi tasto ALT"
L["Any Control Key"] = "Qualsiasi tasto Control"
L["Any Shift Key"] = "Qualsiasi tasto Shift"
--[[Translation missing --]]
L["Are you sure you want to delete %s?  This will delete the macro and all versions.  This action cannot be undone."] = "Are you sure you want to delete %s?  This will delete the macro and all versions.  This action cannot be undone."
L["Arena"] = "Arena"
--[[Translation missing --]]
L["Arena setting changed to Default."] = "Arena setting changed to Default."
--[[Translation missing --]]
L["As GSE is updated, there may be left over macros that no longer relate to sequences.  This will check for these automatically on logout.  Alternatively this check can be run via /gse cleanorphans"] = "As GSE is updated, there may be left over macros that no longer relate to sequences.  This will check for these automatically on logout.  Alternatively this check can be run via /gse cleanorphans"
L["Author"] = "Autore"
--[[Translation missing --]]
L["Author Colour"] = "Author Colour"
--[[Translation missing --]]
L["Automatically Create Macro Icon"] = "Automatically Create Macro Icon"
--[[Translation missing --]]
L["Blizzard Functions Colour"] = "Blizzard Functions Colour"
--[[Translation missing --]]
L["Block Path"] = "Block Path"
--[[Translation missing --]]
L["Block Type: %s"] = "Block Type: %s"
--[[Translation missing --]]
L["Boolean Functions"] = "Boolean Functions"
--[[Translation missing --]]
L["Boolean Functions are GSE variables that return either a true or false value."] = "Boolean Functions are GSE variables that return either a true or false value."
--[[Translation missing --]]
L["Boolean not found.  There is a problem with %s not returning true or false."] = "Boolean not found.  There is a problem with %s not returning true or false."
--[[Translation missing --]]
L["Button State"] = "Button State"
--[[Translation missing --]]
L["By setting the default Icon for all macros to be the QuestionMark, the macro button on your toolbar will change every key hit."] = "By setting the default Icon for all macros to be the QuestionMark, the macro button on your toolbar will change every key hit."
--[[Translation missing --]]
L["By setting this value the Sequence Editor will show every sequence for every class."] = "By setting this value the Sequence Editor will show every sequence for every class."
--[[Translation missing --]]
L["By setting this value the Sequence Editor will show every sequence for your class.  Turning this off will only show the class sequences for your current specialisation."] = "By setting this value the Sequence Editor will show every sequence for your class.  Turning this off will only show the class sequences for your current specialisation."
--[[Translation missing --]]
L["Cancel"] = "Cancel"
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
L["Choose import action:"] = "Scegliere azione da importare:"
--[[Translation missing --]]
L["Clear"] = "Clear"
--[[Translation missing --]]
L["Clear Common Keybindings"] = "Clear Common Keybindings"
--[[Translation missing --]]
L["Clear Keybindings"] = "Clear Keybindings"
--[[Translation missing --]]
L["Clear Spell Cache"] = "Clear Spell Cache"
--[[Translation missing --]]
L["Clicks"] = "Clicks"
L["Close"] = "Chiudi"
--[[Translation missing --]]
L["Close to Maximum Macros.|r  You can have a maximum of "] = "Close to Maximum Macros.|r  You can have a maximum of "
--[[Translation missing --]]
L["Close to Maximum Personal Macros.|r  You can have a maximum of "] = "Close to Maximum Personal Macros.|r  You can have a maximum of "
L["Colour"] = "Colore"
L["Colour and Accessibility Options"] = "Colore e Opzioni di Accessibilità"
--[[Translation missing --]]
L["Combat"] = "Combat"
L["Command Colour"] = "Colori di Comando"
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
--[[Translation missing --]]
L["Conditionals Colour"] = "Conditionals Colour"
--[[Translation missing --]]
L["Configuration"] = "Configuration"
L["Continue"] = "Continua"
--[[Translation missing --]]
L["Control Keys."] = "Control Keys."
--[[Translation missing --]]
L["Convert"] = "Convert"
--[[Translation missing --]]
L["Convert this to a GSE3 Template"] = "Convert this to a GSE3 Template"
--[[Translation missing --]]
L["Copy this link and open it in a Browser."] = "Copy this link and open it in a Browser."
--[[Translation missing --]]
L["Copy this link and paste it into a chat window."] = "Copy this link and paste it into a chat window."
--[[Translation missing --]]
L["Create a new macro in the /macro interface and assign it an Icon. Then reopen this menu.  You cannot create a new macro here but after it has been created you can manage it."] = "Create a new macro in the /macro interface and assign it an Icon. Then reopen this menu.  You cannot create a new macro here but after it has been created you can manage it."
--[[Translation missing --]]
L["Create Human Readable Export"] = "Create Human Readable Export"
--[[Translation missing --]]
L["Create Human Readable Exports"] = "Create Human Readable Exports"
L["Create Icon"] = "Creare Icona"
L["Create Macro"] = "Creare Macro"
--[[Translation missing --]]
L["Current GCD"] = "Current GCD"
--[[Translation missing --]]
L["Current GCD: %s"] = "Current GCD: %s"
--[[Translation missing --]]
L["Current Value"] = "Current Value"
--[[Translation missing --]]
L["CVar Settings"] = "CVar Settings"
L["Debug"] = "Debug"
--[[Translation missing --]]
L["Debug Mode Options"] = "Debug Mode Options"
--[[Translation missing --]]
L["Debug Output Options"] = "Debug Output Options"
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
--[[Translation missing --]]
L["Default Import Action"] = "Default Import Action"
--[[Translation missing --]]
L["Default Keybinding Height"] = "Default Keybinding Height"
--[[Translation missing --]]
L["Default Keybinding Width"] = "Default Keybinding Width"
--[[Translation missing --]]
L["Default Menu Height"] = "Default Menu Height"
--[[Translation missing --]]
L["Default Menu Width"] = "Default Menu Width"
--[[Translation missing --]]
L["Default Version"] = "Default Version"
L["Delete"] = "Cancellare"
--[[Translation missing --]]
L["Delete Block"] = "Delete Block"
L["Delete Icon"] = "Cancellare Icona"
--[[Translation missing --]]
L[ [=[Delete this Block from the sequence.  
WARNING: If this is a loop this will delete all the blocks inside the loop as well.]=] ] = ""
--[[Translation missing --]]
L["Delete this macro.  This is not able to be undone."] = "Delete this macro.  This is not able to be undone."
--[[Translation missing --]]
L["Delete this variable from the sequence."] = "Delete this variable from the sequence."
--[[Translation missing --]]
L[ [=[Delete this verion of the macro.  This can be undone by closing this window and not saving the change.  
This is different to the Delete button below which will delete this entire macro.]=] ] = ""
--[[Translation missing --]]
L["Delete Variable"] = "Delete Variable"
--[[Translation missing --]]
L["Delete Version"] = "Delete Version"
L["Disable"] = "Disabilitare"
--[[Translation missing --]]
L["Disable Block"] = "Disable Block"
--[[Translation missing --]]
L["Disable Editor"] = "Disable Editor"
--[[Translation missing --]]
L["Disable inbuilt LibActionButton"] = "Disable inbuilt LibActionButton"
L["Disable Sequence"] = "Disabilitare Sequenza"
--[[Translation missing --]]
L["Disable this block so that it is not executed. If this is a container block, like a loop, all the blocks within it will also be disabled."] = "Disable this block so that it is not executed. If this is a container block, like a loop, all the blocks within it will also be disabled."
--[[Translation missing --]]
L["Display debug messages in Chat Window"] = "Display debug messages in Chat Window"
--[[Translation missing --]]
L["Do not compile this Sequence at startup."] = "Do not compile this Sequence at startup."
--[[Translation missing --]]
L["Don't Force"] = "Don't Force"
--[[Translation missing --]]
L["Drag this icon to your action bar to use this macro. You can change this icon in the /macro window."] = "Drag this icon to your action bar to use this macro. You can change this icon in the /macro window."
--[[Translation missing --]]
L["Dragonflight has changed how the /click command operates.  As a result all your macro stubs (found in /macro) have been updated to match the value of the CVar ActionButtonUseKeyDown.  This is a one off configuration change that needs to be done for each character.  You can change this configuration in GSE's Options."] = "Dragonflight has changed how the /click command operates.  As a result all your macro stubs (found in /macro) have been updated to match the value of the CVar ActionButtonUseKeyDown.  This is a one off configuration change that needs to be done for each character.  You can change this configuration in GSE's Options."
L["Dungeon"] = "Spedizione"
--[[Translation missing --]]
L["Dungeon setting changed to Default."] = "Dungeon setting changed to Default."
--[[Translation missing --]]
L["Edit Spell Cache"] = "Edit Spell Cache"
--[[Translation missing --]]
L["Edit this macro directly in Lua. WARNING: This may render the macro unable to operate and can crash your Game Session."] = "Edit this macro directly in Lua. WARNING: This may render the macro unable to operate and can crash your Game Session."
L["Editor Colours"] = "Editor di Colori"
--[[Translation missing --]]
L["Emphasis Colour"] = "Emphasis Colour"
L["Enable"] = "Abilitato"
--[[Translation missing --]]
L["Enable Debug for the following Modules"] = "Enable Debug for the following Modules"
--[[Translation missing --]]
L["Enable Mod Debug Mode"] = "Enable Mod Debug Mode"
--[[Translation missing --]]
L["Enter the implementation link for this variable. Use '= true' or '= false' to test."] = "Enter the implementation link for this variable. Use '= true' or '= false' to test."
--[[Translation missing --]]
L["Error found in version %i of %s."] = "Error found in version %i of %s."
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
L["Export"] = "Esportare"
--[[Translation missing --]]
L["Export a Sequence"] = "Export a Sequence"
--[[Translation missing --]]
L["Export Macro Read Only"] = "Export Macro Read Only"
--[[Translation missing --]]
L["Export this Macro."] = "Export this Macro."
--[[Translation missing --]]
L["Export Variable"] = "Export Variable"
--[[Translation missing --]]
L["Extra Macro Versions of %s has been added."] = "Extra Macro Versions of %s has been added."
--[[Translation missing --]]
L["Filter Sequence Selection"] = "Filter Sequence Selection"
--[[Translation missing --]]
L["Finished scanning for errors.  If no other messages then no errors were found."] = "Finished scanning for errors.  If no other messages then no errors were found."
--[[Translation missing --]]
L["Force CVar State"] = "Force CVar State"
L["General"] = "Generale"
L["General Options"] = "Opzioni Generali"
--[[Translation missing --]]
L["Global"] = "Global"
--[[Translation missing --]]
L["Gnome Sequencer Enhanced"] = "Gnome Sequencer Enhanced"
--[[Translation missing --]]
L["Gnome Sequencer: Compress a Sequence String."] = "Gnome Sequencer: Compress a Sequence String."
--[[Translation missing --]]
L["Gnome Sequencer: Sequence Debugger. Monitor the Execution of your Macro"] = "Gnome Sequencer: Sequence Debugger. Monitor the Execution of your Macro"
--[[Translation missing --]]
L["GnomeSequencer was originally written by semlar of wowinterface.com."] = "GnomeSequencer was originally written by semlar of wowinterface.com."
--[[Translation missing --]]
L["GSE"] = "GSE"
--[[Translation missing --]]
L["GSE - %s's Macros"] = "GSE - %s's Macros"
--[[Translation missing --]]
L["GSE allows plugins to load Collections as plugins.  You can reload a collection by pressing the button below."] = "GSE allows plugins to load Collections as plugins.  You can reload a collection by pressing the button below."
--[[Translation missing --]]
L["GSE Discord"] = "GSE Discord"
--[[Translation missing --]]
L["GSE has a LibDataBroker (LDB) data feed.  List Other GSE Users and their version when in a group on the tooltip to this feed."] = "GSE has a LibDataBroker (LDB) data feed.  List Other GSE Users and their version when in a group on the tooltip to this feed."
--[[Translation missing --]]
L["GSE has a LibDataBroker (LDB) data feed.  Set this option to show queued Out of Combat events in the tooltip."] = "GSE has a LibDataBroker (LDB) data feed.  Set this option to show queued Out of Combat events in the tooltip."
--[[Translation missing --]]
L["GSE is a complete rewrite of that addon that allows you create a sequence of macros to be executed at the push of a button."] = "GSE is a complete rewrite of that addon that allows you create a sequence of macros to be executed at the push of a button."
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
--[[Translation missing --]]
L["GSE Users"] = "GSE Users"
--[[Translation missing --]]
L["GSE Version: %s"] = "GSE Version: %s"
--[[Translation missing --]]
L[ [=[GSE was originally forked from GnomeSequencer written by semlar.  It was enhanced by TImothyLuke to include a lot of configuration and boilerplate functionality with a GUI added.  The enhancements pushed the limits of what the original code could handle and was rewritten from scratch into GSE.

GSE itself wouldn't be what it is without the efforts of the people who write sequences with it.  Check out https://discord.gg/gseunited for the things that make this mod work.  Special thanks to Lutechi for creating the original WowLazyMacros community.]=] ] = ""
--[[Translation missing --]]
L["GSE: Advanced Macro Compiler loaded.|r  Type "] = "GSE: Advanced Macro Compiler loaded.|r  Type "
--[[Translation missing --]]
L["GSE: Export"] = "GSE: Export"
--[[Translation missing --]]
L["GSE: Import a Macro String."] = "GSE: Import a Macro String."
--[[Translation missing --]]
L["GSE: Left Click to open the Sequence Editor"] = "GSE: Left Click to open the Sequence Editor"
--[[Translation missing --]]
L["GSE: Main Menu"] = "GSE: Main Menu"
--[[Translation missing --]]
L["GSE: Middle Click to open the Keybinding Interface"] = "GSE: Middle Click to open the Keybinding Interface"
--[[Translation missing --]]
L["GSE: Middle Click to open the Transmission Interface"] = "GSE: Middle Click to open the Transmission Interface"
--[[Translation missing --]]
L["GSE: Record your rotation to a macro."] = "GSE: Record your rotation to a macro."
--[[Translation missing --]]
L["GSE: Right Click to open the Sequence Debugger"] = "GSE: Right Click to open the Sequence Debugger"
--[[Translation missing --]]
L["GSE: Whats New in "] = "GSE: Whats New in "
--[[Translation missing --]]
L["GSE2 Retro interface loaded.  Type `%s/gse2 import%s` to import an old GSE2 string or `%s/gse2 edit%s` to mock up a new template using the GSE2 editor."] = "GSE2 Retro interface loaded.  Type `%s/gse2 import%s` to import an old GSE2 string or `%s/gse2 edit%s` to mock up a new template using the GSE2 editor."
--[[Translation missing --]]
L["Help Colour"] = "Help Colour"
L["Help Information"] = "Informazioni Utili"
--[[Translation missing --]]
L["Help Link"] = "Help Link"
--[[Translation missing --]]
L["Heroic"] = "Heroic"
--[[Translation missing --]]
L["Heroic setting changed to Default."] = "Heroic setting changed to Default."
--[[Translation missing --]]
L["Hide Login Message"] = "Hide Login Message"
--[[Translation missing --]]
L["Hide Minimap Icon"] = "Hide Minimap Icon"
--[[Translation missing --]]
L["Hide Minimap Icon for LibDataBroker (LDB) data text."] = "Hide Minimap Icon for LibDataBroker (LDB) data text."
--[[Translation missing --]]
L["Hides the message that GSE is loaded."] = "Hides the message that GSE is loaded."
--[[Translation missing --]]
L["History"] = "History"
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
--[[Translation missing --]]
L["Icon Colour"] = "Icon Colour"
--[[Translation missing --]]
L["If Blocks require a variable that returns either true or false.  Create the variable first."] = "If Blocks require a variable that returns either true or false.  Create the variable first."
--[[Translation missing --]]
L["If Blocks Require a variable."] = "If Blocks Require a variable."
L["Ignore"] = "Ignorare"
--[[Translation missing --]]
L["Implementation Link"] = "Implementation Link"
L["Import"] = "Importare"
L["Import Macro from Forums"] = "Importa Macro da Forums"
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
--[[Translation missing --]]
L["Language"] = "Language"
--[[Translation missing --]]
L["Language Colour"] = "Language Colour"
--[[Translation missing --]]
L["Last Updated"] = "Last Updated"
L["Left Alt Key"] = "tasto ALT Sinistro"
L["Left Control Key"] = "Tasto Control Sinistro"
L["Left Mouse Button"] = "Tasto Sinistro Mouse"
--[[Translation missing --]]
L["Left Shift Key"] = "Left Shift Key"
--[[Translation missing --]]
L["LibActionButton is used by ConsolePort and Bartender.  Disabling this will use the standard version of this library."] = "LibActionButton is used by ConsolePort and Bartender.  Disabling this will use the standard version of this library."
--[[Translation missing --]]
L["Like a /castsequence macro, it cycles through a series of commands when the button is pushed. However, unlike castsequence, it uses macro text for the commands instead of spells, and it advances every time the button is pushed instead of stopping when it can't cast something."] = "Like a /castsequence macro, it cycles through a series of commands when the button is pushed. However, unlike castsequence, it uses macro text for the commands instead of spells, and it advances every time the button is pushed instead of stopping when it can't cast something."
L["Load"] = "Caricare"
--[[Translation missing --]]
L["Load Sequence"] = "Load Sequence"
--[[Translation missing --]]
L["Local Function: "] = "Local Function: "
L["Local Macro"] = "Macro Locale"
--[[Translation missing --]]
L["Macro"] = "Macro"
--[[Translation missing --]]
L["Macro Collection to Import."] = "Macro Collection to Import."
--[[Translation missing --]]
L["Macro Compile Error"] = "Macro Compile Error"
--[[Translation missing --]]
L["Macro found by the name %sPVP%s. Rename this macro to a different name to be able to use it.  WOW has a global object called PVP that is referenced instead of this macro."] = "Macro found by the name %sPVP%s. Rename this macro to a different name to be able to use it.  WOW has a global object called PVP that is referenced instead of this macro."
--[[Translation missing --]]
L["Macro found by the name %sWW%s. Rename this macro to a different name to be able to use it.  WOW has a hidden button called WW that is executed instead of this macro."] = "Macro found by the name %sWW%s. Rename this macro to a different name to be able to use it.  WOW has a hidden button called WW that is executed instead of this macro."
--[[Translation missing --]]
L["Macro Icon"] = "Macro Icon"
--[[Translation missing --]]
L["Macro Import Successful."] = "Macro Import Successful."
--[[Translation missing --]]
L["Macro Name"] = "Macro Name"
--[[Translation missing --]]
L["Macro Name or Macro Commands"] = "Macro Name or Macro Commands"
--[[Translation missing --]]
L["Macro Template"] = "Macro Template"
--[[Translation missing --]]
L["Macro unable to be imported."] = "Macro unable to be imported."
--[[Translation missing --]]
L["Macro Version %d deleted."] = "Macro Version %d deleted."
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
--[[Translation missing --]]
L["Middle Mouse Button"] = "Middle Mouse Button"
--[[Translation missing --]]
L["Millisecond click settings"] = "Millisecond click settings"
--[[Translation missing --]]
L["Milliseconds"] = "Milliseconds"
--[[Translation missing --]]
L["Missing Variable "] = "Missing Variable "
--[[Translation missing --]]
L["modified in other window.  This view is now behind the current sequence."] = "modified in other window.  This view is now behind the current sequence."
--[[Translation missing --]]
L["Mouse Button 4"] = "Mouse Button 4"
--[[Translation missing --]]
L["Mouse Button 5"] = "Mouse Button 5"
--[[Translation missing --]]
L["Mouse Buttons."] = "Mouse Buttons."
--[[Translation missing --]]
L["Move Down"] = "Move Down"
--[[Translation missing --]]
L["Move this block down one block."] = "Move this block down one block."
--[[Translation missing --]]
L["Move this block up one block."] = "Move this block up one block."
--[[Translation missing --]]
L["Move Up"] = "Move Up"
--[[Translation missing --]]
L["Moved %s to class %s."] = "Moved %s to class %s."
--[[Translation missing --]]
L["MS Click Rate"] = "MS Click Rate"
--[[Translation missing --]]
L["Mythic"] = "Mythic"
--[[Translation missing --]]
L["Mythic setting changed to Default."] = "Mythic setting changed to Default."
--[[Translation missing --]]
L["Mythic+"] = "Mythic+"
--[[Translation missing --]]
L["Mythic+ setting changed to Default."] = "Mythic+ setting changed to Default."
--[[Translation missing --]]
L["Name"] = "Name"
--[[Translation missing --]]
L["New"] = "New"
--[[Translation missing --]]
L["New Actionbar Override"] = "New Actionbar Override"
--[[Translation missing --]]
L["New KeyBind"] = "New KeyBind"
--[[Translation missing --]]
L["New Sequence Name"] = "New Sequence Name"
--[[Translation missing --]]
L["No"] = "No"
--[[Translation missing --]]
L["No changes were made to "] = "No changes were made to "
--[[Translation missing --]]
L["No Help Information "] = "No Help Information "
--[[Translation missing --]]
L["No Help Information Available"] = "No Help Information Available"
--[[Translation missing --]]
L["Normal Colour"] = "Normal Colour"
--[[Translation missing --]]
L["Not Yet Active"] = "Not Yet Active"
--[[Translation missing --]]
L["Notes and help on how this macro works.  What things to remember.  This information is shown in the sequence browser."] = "Notes and help on how this macro works.  What things to remember.  This information is shown in the sequence browser."
--[[Translation missing --]]
L["OOC Queue Delay"] = "OOC Queue Delay"
--[[Translation missing --]]
L["Open %s in New Window"] = "Open %s in New Window"
--[[Translation missing --]]
L["Opens the GSE Options window"] = "Opens the GSE Options window"
--[[Translation missing --]]
L["Options"] = "Options"
--[[Translation missing --]]
L["Options have been reset to defaults."] = "Options have been reset to defaults."
--[[Translation missing --]]
L["Output"] = "Output"
--[[Translation missing --]]
L["Party"] = "Party"
--[[Translation missing --]]
L["Party setting changed to Default."] = "Party setting changed to Default."
--[[Translation missing --]]
L["Pause"] = "Pause"
--[[Translation missing --]]
L["Pause for the GCD."] = "Pause for the GCD."
--[[Translation missing --]]
L["Paused"] = "Paused"
--[[Translation missing --]]
L["Paused - In Combat"] = "Paused - In Combat"
--[[Translation missing --]]
L["Pet"] = "Pet"
--[[Translation missing --]]
L["Pet Ability"] = "Pet Ability"
--[[Translation missing --]]
L["Picks a Custom Colour for emphasis."] = "Picks a Custom Colour for emphasis."
--[[Translation missing --]]
L["Picks a Custom Colour for the Author."] = "Picks a Custom Colour for the Author."
--[[Translation missing --]]
L["Picks a Custom Colour for the Commands."] = "Picks a Custom Colour for the Commands."
--[[Translation missing --]]
L["Picks a Custom Colour for the Mod Names."] = "Picks a Custom Colour for the Mod Names."
--[[Translation missing --]]
L["Picks a Custom Colour to be used for braces and indents."] = "Picks a Custom Colour to be used for braces and indents."
--[[Translation missing --]]
L["Picks a Custom Colour to be used for Icons."] = "Picks a Custom Colour to be used for Icons."
--[[Translation missing --]]
L["Picks a Custom Colour to be used for language descriptors"] = "Picks a Custom Colour to be used for language descriptors"
--[[Translation missing --]]
L["Picks a Custom Colour to be used for macro conditionals eg [mod:shift]"] = "Picks a Custom Colour to be used for macro conditionals eg [mod:shift]"
--[[Translation missing --]]
L["Picks a Custom Colour to be used for Macro Keywords like /cast and /target"] = "Picks a Custom Colour to be used for Macro Keywords like /cast and /target"
--[[Translation missing --]]
L["Picks a Custom Colour to be used for numbers."] = "Picks a Custom Colour to be used for numbers."
--[[Translation missing --]]
L["Picks a Custom Colour to be used for Spells and Abilities."] = "Picks a Custom Colour to be used for Spells and Abilities."
--[[Translation missing --]]
L["Picks a Custom Colour to be used for StepFunctions."] = "Picks a Custom Colour to be used for StepFunctions."
--[[Translation missing --]]
L["Picks a Custom Colour to be used for strings."] = "Picks a Custom Colour to be used for strings."
--[[Translation missing --]]
L["Picks a Custom Colour to be used for unknown terms."] = "Picks a Custom Colour to be used for unknown terms."
--[[Translation missing --]]
L["Picks a Custom Colour to be used normally."] = "Picks a Custom Colour to be used normally."
--[[Translation missing --]]
L["Plugins"] = "Plugins"
--[[Translation missing --]]
L["Print Active Modifiers on Click"] = "Print Active Modifiers on Click"
--[[Translation missing --]]
L["Print to the chat window if the alt, shift, control modifiers as well as the button pressed on each macro keypress."] = "Print to the chat window if the alt, shift, control modifiers as well as the button pressed on each macro keypress."
--[[Translation missing --]]
L["Priority List (1 12 123 1234)"] = "Priority List (1 12 123 1234)"
--[[Translation missing --]]
L["Processing Collection of %s Elements."] = "Processing Collection of %s Elements."
--[[Translation missing --]]
L["PVP"] = "PVP"
--[[Translation missing --]]
L["PVP setting changed to Default."] = "PVP setting changed to Default."
L["Raid"] = "Incursione"
--[[Translation missing --]]
L["Raid setting changed to Default."] = "Raid setting changed to Default."
--[[Translation missing --]]
L["Random - It will select .... a spell, any spell"] = "Random - It will select .... a spell, any spell"
--[[Translation missing --]]
L["Raw Edit"] = "Raw Edit"
L["Ready to Send"] = "Pronto per l'invio"
--[[Translation missing --]]
L["Received Sequence "] = "Received Sequence "
L["Record"] = "Registra"
--[[Translation missing --]]
L["Record Macro"] = "Record Macro"
--[[Translation missing --]]
L["Registered Addons"] = "Registered Addons"
--[[Translation missing --]]
L["Rename New Macro"] = "Rename New Macro"
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
--[[Translation missing --]]
L["Reset this macro when you exit combat."] = "Reset this macro when you exit combat."
--[[Translation missing --]]
L["Resets"] = "Resets"
--[[Translation missing --]]
L["Resets sequences back to the initial state when out of combat."] = "Resets sequences back to the initial state when out of combat."
--[[Translation missing --]]
L["Restricted"] = "Restricted"
--[[Translation missing --]]
L["RESTRICTED: Macro specifics disabled by author."] = "RESTRICTED: Macro specifics disabled by author."
--[[Translation missing --]]
L["Resume"] = "Resume"
--[[Translation missing --]]
L["Returns your current Global Cooldown value accounting for your haste if that stat is present."] = "Returns your current Global Cooldown value accounting for your haste if that stat is present."
--[[Translation missing --]]
L["Reverse Priority (1 21 321 4321)"] = "Reverse Priority (1 21 321 4321)"
--[[Translation missing --]]
L["Right Alt Key"] = "Right Alt Key"
--[[Translation missing --]]
L["Right Control Key"] = "Right Control Key"
--[[Translation missing --]]
L["Right Mouse Button"] = "Right Mouse Button"
--[[Translation missing --]]
L["Right Shift Key"] = "Right Shift Key"
--[[Translation missing --]]
L["Running"] = "Running"
L["Save"] = "Salva"
--[[Translation missing --]]
L["Save pending for "] = "Save pending for "
--[[Translation missing --]]
L["Save the changes made to this macro"] = "Save the changes made to this macro"
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
L["Send"] = "Inviare"
--[[Translation missing --]]
L["Send this macro to another GSE player who is on the same server as you are."] = "Send this macro to another GSE player who is on the same server as you are."
L["Send To"] = "Invia a"
--[[Translation missing --]]
L["Sequence"] = "Sequence"
--[[Translation missing --]]
L["Sequence Compare"] = "Sequence Compare"
--[[Translation missing --]]
L["Sequence Debugger"] = "Sequence Debugger"
--[[Translation missing --]]
L["Sequence Editor"] = "Sequence Editor"
L["Sequence Name"] = "Nome Sequenza"
--[[Translation missing --]]
L["Sequence Name %s is in Use. Please choose a different name."] = "Sequence Name %s is in Use. Please choose a different name."
--[[Translation missing --]]
L["Sequence Named %s was not specifically designed for this version of the game.  It may need adjustments."] = "Sequence Named %s was not specifically designed for this version of the game.  It may need adjustments."
--[[Translation missing --]]
L["Sequence Reset"] = "Sequence Reset"
--[[Translation missing --]]
L["Sequence to Compress."] = "Sequence to Compress."
--[[Translation missing --]]
L["Sequences"] = "Sequences"
--[[Translation missing --]]
L["Sequential (1 2 3 4)"] = "Sequential (1 2 3 4)"
--[[Translation missing --]]
L["Set Default Icon QuestionMark"] = "Set Default Icon QuestionMark"
--[[Translation missing --]]
L["Set Key to Bind"] = "Set Key to Bind"
--[[Translation missing --]]
L["Shift Keys."] = "Shift Keys."
--[[Translation missing --]]
L["Show All Sequences in Editor"] = "Show All Sequences in Editor"
--[[Translation missing --]]
L["Show Class Sequences in Editor"] = "Show Class Sequences in Editor"
--[[Translation missing --]]
L["Show Current Spells"] = "Show Current Spells"
--[[Translation missing --]]
L["Show Global Sequences in Editor"] = "Show Global Sequences in Editor"
--[[Translation missing --]]
L["Show GSE Users in LDB"] = "Show GSE Users in LDB"
--[[Translation missing --]]
L["Show next time you login."] = "Show next time you login."
--[[Translation missing --]]
L["Show OOC Queue in LDB"] = "Show OOC Queue in LDB"
--[[Translation missing --]]
L["Show the compiled version of this macro."] = "Show the compiled version of this macro."
L["Source Language "] = "Linguaggio Sorgente"
--[[Translation missing --]]
L["Specialisation"] = "Specialisation"
--[[Translation missing --]]
L["Specialisation / Class ID"] = "Specialisation / Class ID"
--[[Translation missing --]]
L["SpecID/ClassID Colour"] = "SpecID/ClassID Colour"
--[[Translation missing --]]
L["Spell"] = "Spell"
--[[Translation missing --]]
L["Spell Cache Editor"] = "Spell Cache Editor"
L["Spell Colour"] = "Colore incantesimo"
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
L["Stop"] = "Stop"
--[[Translation missing --]]
L["Store Debug Messages"] = "Store Debug Messages"
--[[Translation missing --]]
L["Store output of debug messages in a Global Variable that can be referrenced by other mods."] = "Store output of debug messages in a Global Variable that can be referrenced by other mods."
--[[Translation missing --]]
L["String Colour"] = "String Colour"
--[[Translation missing --]]
L["Support GSE"] = "Support GSE"
--[[Translation missing --]]
L["Supporters"] = "Supporters"
--[[Translation missing --]]
L["Talent Loadout"] = "Talent Loadout"
L["Talents"] = "Talenti"
--[[Translation missing --]]
L["Target language "] = "Target language "
--[[Translation missing --]]
L["The author of this Macro."] = "The author of this Macro."
--[[Translation missing --]]
L["The author of this Variable."] = "The author of this Variable."
--[[Translation missing --]]
L[ [=[The block path shows the direct location of a block.  This can be edited to move a block to a different position quickly.  Each block is prefixed by its container.
EG 2.3 means that the block is the third block in a container at level 2.  You can move a block into a container block by specifying the parent block.  You need to press the Okay button to move the block.]=] ] = ""
--[[Translation missing --]]
L["The command "] = "The command "
--[[Translation missing --]]
L["The default sizes of each window."] = "The default sizes of each window."
--[[Translation missing --]]
L["The delay in seconds between Out of Combat Queue Polls.  The Out of Combat Queue saves changes and updates sequences.  When you hit save or change zones, these actions enter a queue which checks that first you are not in combat before proceeding to complete their task.  After checking the queue it goes to sleep for x seconds before rechecking what is in the queue."] = "The delay in seconds between Out of Combat Queue Polls.  The Out of Combat Queue saves changes and updates sequences.  When you hit save or change zones, these actions enter a queue which checks that first you are not in combat before proceeding to complete their task.  After checking the queue it goes to sleep for x seconds before rechecking what is in the queue."
--[[Translation missing --]]
L["The following people donate monthly via Patreon for the ongoing maintenance and development of GSE.  Their support is greatly appreciated."] = "The following people donate monthly via Patreon for the ongoing maintenance and development of GSE.  Their support is greatly appreciated."
--[[Translation missing --]]
L["The GSE Out of Combat queue is %s"] = "The GSE Out of Combat queue is %s"
--[[Translation missing --]]
L["The GUI has not been loaded.  Please activate this plugin amongst WoW's addons to use the GSE GUI."] = "The GUI has not been loaded.  Please activate this plugin amongst WoW's addons to use the GSE GUI."
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
--[[Translation missing --]]
L["The version of this macro that will be used when you enter raids."] = "The version of this macro that will be used when you enter raids."
--[[Translation missing --]]
L["The version of this macro that will be used where no other version has been configured."] = "The version of this macro that will be used where no other version has been configured."
--[[Translation missing --]]
L["The version of this macro to use in Arenas.  If this is not specified, GSE will look for a PVP version before the default."] = "The version of this macro to use in Arenas.  If this is not specified, GSE will look for a PVP version before the default."
--[[Translation missing --]]
L["The version of this macro to use in heroic dungeons."] = "The version of this macro to use in heroic dungeons."
--[[Translation missing --]]
L["The version of this macro to use in Mythic Dungeons."] = "The version of this macro to use in Mythic Dungeons."
--[[Translation missing --]]
L["The version of this macro to use in Mythic+ Dungeons."] = "The version of this macro to use in Mythic+ Dungeons."
--[[Translation missing --]]
L["The version of this macro to use in normal dungeons."] = "The version of this macro to use in normal dungeons."
--[[Translation missing --]]
L["The version of this macro to use in PVP."] = "The version of this macro to use in PVP."
--[[Translation missing --]]
L["The version of this macro to use in Scenarios."] = "The version of this macro to use in Scenarios."
--[[Translation missing --]]
L["The version of this macro to use when in a party in the world."] = "The version of this macro to use when in a party in the world."
--[[Translation missing --]]
L["The version of this macro to use when in time walking dungeons."] = "The version of this macro to use when in time walking dungeons."
--[[Translation missing --]]
L["There are %i events in out of combat queue"] = "There are %i events in out of combat queue"
--[[Translation missing --]]
L["There are no events in out of combat queue"] = "There are no events in out of combat queue"
--[[Translation missing --]]
L["There is an error in the sequence that needs to be corrected before it can be saved."] = "There is an error in the sequence that needs to be corrected before it can be saved."
--[[Translation missing --]]
L["There was an error processing "] = "There was an error processing "
--[[Translation missing --]]
L["These options combine to allow you to reset a sequence while it is running.  These options are Cumulative ie they add to each other.  Options Like LeftClick and RightClick won't work together very well."] = "These options combine to allow you to reset a sequence while it is running.  These options are Cumulative ie they add to each other.  Options Like LeftClick and RightClick won't work together very well."
--[[Translation missing --]]
L["This change will not come into effect until you save this macro."] = "This change will not come into effect until you save this macro."
--[[Translation missing --]]
L["This CVAR makes WoW use your abilities when you press the key not when you release it.  To use GSE in its native configuration this needs to be checked."] = "This CVAR makes WoW use your abilities when you press the key not when you release it.  To use GSE in its native configuration this needs to be checked."
--[[Translation missing --]]
L["This function will clear the spell cache and any mappings between individual spellIDs and spellnames.."] = "This function will clear the spell cache and any mappings between individual spellIDs and spellnames.."
--[[Translation missing --]]
L["This function will open a window enabling you to edit the spell cache and any mappings between individual spellIDs and spellnames.."] = "This function will open a window enabling you to edit the spell cache and any mappings between individual spellIDs and spellnames.."
--[[Translation missing --]]
L["This function will remove the SHIFT+N, ALT+N and CTRL+N keybindings for this character.  Useful if [mod:shift] etc conditions don't work in game."] = "This function will remove the SHIFT+N, ALT+N and CTRL+N keybindings for this character.  Useful if [mod:shift] etc conditions don't work in game."
--[[Translation missing --]]
L["This function will update macro stubs to support listening to the options below.  This is required to be completed 1 time per character."] = "This function will update macro stubs to support listening to the options below.  This is required to be completed 1 time per character."
--[[Translation missing --]]
L["This is the only version of this macro.  Delete the entire macro to delete this version."] = "This is the only version of this macro.  Delete the entire macro to delete this version."
--[[Translation missing --]]
L["This macro is not compatible with this version of the game and cannot be imported."] = "This macro is not compatible with this version of the game and cannot be imported."
--[[Translation missing --]]
L["This macro uses features that are not available in this version. You need to update GSE to %s in order to use this macro."] = "This macro uses features that are not available in this version. You need to update GSE to %s in order to use this macro."
--[[Translation missing --]]
L["This option dumps extra trace information to your chat window to help troubleshoot problems with the mod"] = "This option dumps extra trace information to your chat window to help troubleshoot problems with the mod"
--[[Translation missing --]]
L["This sequence is Read Only and unable to be edited."] = "This sequence is Read Only and unable to be edited."
--[[Translation missing --]]
L["This Sequence was exported from GSE %s."] = "This Sequence was exported from GSE %s."
--[[Translation missing --]]
L["This setting forces the ActionButtonUseKeyDown setting one way or another.  It also reconfigures GSE's Macro Stubs to operate in the specified mode."] = "This setting forces the ActionButtonUseKeyDown setting one way or another.  It also reconfigures GSE's Macro Stubs to operate in the specified mode."
--[[Translation missing --]]
L["This shows the Global Sequences available as well as those for your class."] = "This shows the Global Sequences available as well as those for your class."
--[[Translation missing --]]
L["This version has been modified by TimothyLuke to make the power of GnomeSequencer avaialble to people who are not comfortable with lua programming."] = "This version has been modified by TimothyLuke to make the power of GnomeSequencer avaialble to people who are not comfortable with lua programming."
--[[Translation missing --]]
L["This version of GSE is incompatabile with this version of the game."] = "This version of GSE is incompatabile with this version of the game."
--[[Translation missing --]]
L["This will display debug messages for the "] = "This will display debug messages for the "
--[[Translation missing --]]
L["This will display debug messages for the GSE Ingame Transmission and transfer"] = "This will display debug messages for the GSE Ingame Transmission and transfer"
--[[Translation missing --]]
L["This will display debug messages in the Chat window."] = "This will display debug messages in the Chat window."
--[[Translation missing --]]
L["Timewalking"] = "Timewalking"
--[[Translation missing --]]
L["Timewalking setting changed to Default."] = "Timewalking setting changed to Default."
--[[Translation missing --]]
L["Title Colour"] = "Title Colour"
--[[Translation missing --]]
L["To correct this either delete the version via the GSE Editor or enter the following command to delete this macro totally.  %s/run GSE.DeleteSequence (%i, %s)%s"] = "To correct this either delete the version via the GSE Editor or enter the following command to delete this macro totally.  %s/run GSE.DeleteSequence (%i, %s)%s"
--[[Translation missing --]]
L["To get started "] = "To get started "
--[[Translation missing --]]
L["Toy"] = "Toy"
--[[Translation missing --]]
L["Troubleshooting"] = "Troubleshooting"
--[[Translation missing --]]
L["Two sequences with unknown sources found."] = "Two sequences with unknown sources found."
--[[Translation missing --]]
L["Unable to interpret sequence."] = "Unable to interpret sequence."
--[[Translation missing --]]
L["Unable to process content.  Fix table and try again."] = "Unable to process content.  Fix table and try again."
--[[Translation missing --]]
L["Unit Name"] = "Unit Name"
L["Unknown Colour"] = "Colore sconosciuto"
--[[Translation missing --]]
L["Unrecognised Import"] = "Unrecognised Import"
L["Update"] = "Aggiorna"
--[[Translation missing --]]
L["Update Talents"] = "Update Talents"
--[[Translation missing --]]
L["Update the stored talents to match the current chosen talents."] = "Update the stored talents to match the current chosen talents."
L["Updated Macro"] = "Macro Aggiornata"
--[[Translation missing --]]
L["Use Global Account Macros"] = "Use Global Account Macros"
--[[Translation missing --]]
L["Use WLM Export Sequence Format"] = "Use WLM Export Sequence Format"
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
--[[Translation missing --]]
L["Website or forum URL where a player can get more information or ask questions about this macro."] = "Website or forum URL where a player can get more information or ask questions about this macro."
--[[Translation missing --]]
L["What are the preferred talents for this macro?"] = "What are the preferred talents for this macro?"
--[[Translation missing --]]
L["What class or spec is this macro for?  If it is for all classes choose Global."] = "What class or spec is this macro for?  If it is for all classes choose Global."
--[[Translation missing --]]
L["WhatsNew"] = [=[|cFFFFFFFFGS|r|cFF00FFFFE|r 3.2.18 updates the Actionbar Overrides for Bartender4 and ConsolePort.  This solves the issue of being in flight and not being able to use the GSE Sequence until you left combat.  ElvUI support for this will come in a later update.

|cffff6666Note|r: The paging function has to be turned off for druids and potentially rogues.  The issue is when Bartender4 pages, the bar is replaces with the contents of another hidden bar.  Even if I bind a button to that bar the "click" state is not transferred to the new bar.

The full detail on all of these changes is available on the GSE GitHub wiki - https://github.com/TimothyLuke/GSE-Advanced-Macro-Compiler/wiki
]=]
--[[Translation missing --]]
L["When creating a macro, if there is not a personal character macro space, create an account wide macro."] = "When creating a macro, if there is not a personal character macro space, create an account wide macro."
--[[Translation missing --]]
L["When exporting from GSE create a descriptive export for Discord/Discource forums."] = "When exporting from GSE create a descriptive export for Discord/Discource forums."
--[[Translation missing --]]
L["When GSE imports a sequence and it already exists locally and has local edits, what do you want the default action to be.  Merge - Add the new MacroVersions to the existing Sequence.  Replace - Replace the existing sequence with the new version. Ignore - ignore updates.  This default action will set the default on the Compare screen however if the GUI is not available this will be the action taken."] = "When GSE imports a sequence and it already exists locally and has local edits, what do you want the default action to be.  Merge - Add the new MacroVersions to the existing Sequence.  Replace - Replace the existing sequence with the new version. Ignore - ignore updates.  This default action will set the default on the Compare screen however if the GUI is not available this will be the action taken."
--[[Translation missing --]]
L["When loading or creating a sequence, if it is a global or the macro has an unknown specID automatically create the Macro Stub in Account Macros"] = "When loading or creating a sequence, if it is a global or the macro has an unknown specID automatically create the Macro Stub in Account Macros"
--[[Translation missing --]]
L["When loading or creating a sequence, if it is a macro of the same class automatically create the Macro Stub"] = "When loading or creating a sequence, if it is a macro of the same class automatically create the Macro Stub"
--[[Translation missing --]]
L["Window Sizes"] = "Window Sizes"
L["Yes"] = "Si"
--[[Translation missing --]]
L["You cannot delete the Default version of this macro.  Please choose another version to be the Default on the Configuration tab."] = "You cannot delete the Default version of this macro.  Please choose another version to be the Default on the Configuration tab."
--[[Translation missing --]]
L["You cannot open a new Sequence Editor window while you are in combat.  Please exit combat and then try again."] = "You cannot open a new Sequence Editor window while you are in combat.  Please exit combat and then try again."
L["You need to reload the User Interface to complete this task.  Would you like to do this now?"] = "Hai bisogno di ricaricare l'interfaccia utente per completare l'operazione. Desideri farlo ora ?"
--[[Translation missing --]]
L["Your ClassID is "] = "Your ClassID is "
L["Your current Specialisation is "] = "Tua Specializzazione corrente è"


