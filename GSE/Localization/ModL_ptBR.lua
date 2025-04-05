if GetLocale() ~= "ptBR" then
    return
end

local L = LibStub("AceLocale-3.0"):NewLocale("GSE", "ptBR")

-- Options translation
L["  The Alternative ClassID is "] = "A ClassID alternativa é "
L[" Deleted Orphaned Macro "] = "Macro Órfã Apagada"
L[" from "] = "de"
L[" is not available.  Unable to translate sequence "] = "não está disponível. Incapaz de traduzir a sequência"
L[" macros per Account.  You currently have "] = "macros por Conta. Você tem atualmente "
L[" macros per character.  You currently have "] = "macros por personagem. Você tem atualmente "
L[" sent"] = "enviado"
L[" was imported as a new macro."] = "foi importada como uma nova macro."
L[" was imported with the following errors."] = "foi importada com os seguintes erros."
L[" was imported."] = "Importado."
L[" was updated to new version."] = "foi atualizada para uma nova versão."
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
L["|r.  You can also have a  maximum of "] = "|r. Você também pode ter no máximo "
L["<DEBUG> |r "] = "<DEPURAÇÃO> |r "
L["<SEQUENCEDEBUG> |r "] = "<DEPURAÇÃODASEQUÊNCIA> |r "
--[[Translation missing --]]
L[ [=[A pause can be measured in either clicks or seconds.  It will either wait 5 clicks or 1.5 seconds.
If using seconds, you can also wait for the GCD by entering ~~GCD~~ into the box.]=] ] = ""
L["About"] = "Sobre"
L["About GSE"] = "Sobre o GSE"
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
L["Actions"] = "Ações"
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
L["Alt Keys."] = "Teclas Alt."
--[[Translation missing --]]
L["Alwaus use the highest rank of spell available.  This is useful for levelling."] = "Alwaus use the highest rank of spell available.  This is useful for levelling."
--[[Translation missing --]]
L["Always use Max Rank"] = "Always use Max Rank"
L["Any Alt Key"] = "Qualquer Tecla Alt"
L["Any Control Key"] = "Qualquer Tecla Ctrl"
L["Any Shift Key"] = "Qualquer Tecla Shift"
L["Are you sure you want to delete %s?  This will delete the macro and all versions.  This action cannot be undone."] = "Tem certeza de que deseja excluir %s? Isto excluirá a macro e todas as versões. Esta ação não poderá ser desfeita."
L["Arena"] = "Arena"
L["Arena setting changed to Default."] = "Configuração de Arena alterada para o Padrão."
--[[Translation missing --]]
L["As GSE is updated, there may be left over macros that no longer relate to sequences.  This will check for these automatically on logout.  Alternatively this check can be run via /gse cleanorphans"] = "As GSE is updated, there may be left over macros that no longer relate to sequences.  This will check for these automatically on logout.  Alternatively this check can be run via /gse cleanorphans"
L["Author"] = "Autor"
L["Author Colour"] = "Cor do Autor"
L["Automatically Create Macro Icon"] = "Criar Ícone de Macro Automaticamente"
L["Blizzard Functions Colour"] = "Funções de Cores da Blizzard"
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
L["By setting the default Icon for all macros to be the QuestionMark, the macro button on your toolbar will change every key hit."] = "Ao definir o ícone padrão para todas as macros como o Ponto de Interrogação, o botão da macro na barra de ferramentas irá mudar a cada aperto da tecla."
--[[Translation missing --]]
L["By setting this value the Sequence Editor will show every sequence for every class."] = "By setting this value the Sequence Editor will show every sequence for every class."
--[[Translation missing --]]
L["By setting this value the Sequence Editor will show every sequence for your class.  Turning this off will only show the class sequences for your current specialisation."] = "By setting this value the Sequence Editor will show every sequence for your class.  Turning this off will only show the class sequences for your current specialisation."
L["Cancel"] = "Cancelar"
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
L["Choose import action:"] = "Escolha a ação de importação:"
L["Clear"] = "Limpar"
L["Clear Common Keybindings"] = "Limpar Teclas de Atalho Comuns"
L["Clear Keybindings"] = "Limpar Teclas de Atalho"
--[[Translation missing --]]
L["Clear Spell Cache"] = "Clear Spell Cache"
--[[Translation missing --]]
L["Clicks"] = "Clicks"
L["Close"] = "Fechar"
L["Close to Maximum Macros.|r  You can have a maximum of "] = "Perto da Quantidade Máxima de Macros.|r Você pode ter no máximo "
L["Close to Maximum Personal Macros.|r  You can have a maximum of "] = "Perto da Quantidade Máxima de Macros Pessoais.|r Você pode ter no máximo "
L["Colour"] = "Cores"
L["Colour and Accessibility Options"] = "Opções de Cor e Acessibilidade"
L["Combat"] = "Combate"
L["Command Colour"] = "Cor dos Comandos"
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
L["Compress"] = "Comprimir"
L["Compress Sequence from Forums"] = "Comprimir Sequências de Fóruns"
L["Conditionals Colour"] = "Cor das Condicionais"
L["Configuration"] = "Configuração"
L["Continue"] = "Continuar"
L["Control Keys."] = "Teclas Ctrl."
--[[Translation missing --]]
L["Convert"] = "Convert"
--[[Translation missing --]]
L["Convert this to a GSE3 Template"] = "Convert this to a GSE3 Template"
L["Copy this link and open it in a Browser."] = "Copie este link e abra em um Navegador."
--[[Translation missing --]]
L["Copy this link and paste it into a chat window."] = "Copy this link and paste it into a chat window."
--[[Translation missing --]]
L["Create a new macro in the /macro interface and assign it an Icon. Then reopen this menu.  You cannot create a new macro here but after it has been created you can manage it."] = "Create a new macro in the /macro interface and assign it an Icon. Then reopen this menu.  You cannot create a new macro here but after it has been created you can manage it."
--[[Translation missing --]]
L["Create Human Readable Export"] = "Create Human Readable Export"
--[[Translation missing --]]
L["Create Human Readable Exports"] = "Create Human Readable Exports"
L["Create Icon"] = "Criar Ícone"
L["Create Macro"] = "Criar Macro"
--[[Translation missing --]]
L["Current GCD"] = "Current GCD"
--[[Translation missing --]]
L["Current GCD: %s"] = "Current GCD: %s"
--[[Translation missing --]]
L["Current Value"] = "Current Value"
--[[Translation missing --]]
L["CVar Settings"] = "CVar Settings"
L["Debug"] = "Depurar"
L["Debug Mode Options"] = "Opções do Modo de Depuração"
L["Debug Output Options"] = "Opções de Saída da Depuração"
L["Decompress"] = "Descomprimir"
--[[Translation missing --]]
L["Default Debugger Height"] = "Default Debugger Height"
--[[Translation missing --]]
L["Default Debugger Width"] = "Default Debugger Width"
--[[Translation missing --]]
L["Default Editor Height"] = "Default Editor Height"
--[[Translation missing --]]
L["Default Editor Width"] = "Default Editor Width"
L["Default Import Action"] = "Ação Padrão de Importação"
--[[Translation missing --]]
L["Default Keybinding Height"] = "Default Keybinding Height"
--[[Translation missing --]]
L["Default Keybinding Width"] = "Default Keybinding Width"
--[[Translation missing --]]
L["Default Menu Height"] = "Default Menu Height"
--[[Translation missing --]]
L["Default Menu Width"] = "Default Menu Width"
L["Default Version"] = "Versão Padrão"
L["Delete"] = "Apagar"
--[[Translation missing --]]
L["Delete Block"] = "Delete Block"
L["Delete Icon"] = "Apagar Ícone"
--[[Translation missing --]]
L[ [=[Delete this Block from the sequence.  
WARNING: If this is a loop this will delete all the blocks inside the loop as well.]=] ] = ""
L["Delete this macro.  This is not able to be undone."] = "Apagar esta macro. Isto não pode ser desfeito."
--[[Translation missing --]]
L["Delete this variable from the sequence."] = "Delete this variable from the sequence."
--[[Translation missing --]]
L[ [=[Delete this verion of the macro.  This can be undone by closing this window and not saving the change.  
This is different to the Delete button below which will delete this entire macro.]=] ] = ""
--[[Translation missing --]]
L["Delete Variable"] = "Delete Variable"
L["Delete Version"] = "Apagar Versão"
L["Disable"] = "Desabilitar"
--[[Translation missing --]]
L["Disable Block"] = "Disable Block"
L["Disable Editor"] = "Desabilitar Editor"
--[[Translation missing --]]
L["Disable inbuilt LibActionButton"] = "Disable inbuilt LibActionButton"
L["Disable Sequence"] = "Desabilitar Sequência"
--[[Translation missing --]]
L["Disable this block so that it is not executed. If this is a container block, like a loop, all the blocks within it will also be disabled."] = "Disable this block so that it is not executed. If this is a container block, like a loop, all the blocks within it will also be disabled."
L["Display debug messages in Chat Window"] = "Mostrar mensagens de depuração na Janela do Chat"
--[[Translation missing --]]
L["Do not compile this Sequence at startup."] = "Do not compile this Sequence at startup."
--[[Translation missing --]]
L["Don't Force"] = "Don't Force"
L["Drag this icon to your action bar to use this macro. You can change this icon in the /macro window."] = "Arraste este ícone para sua barra de ações para usar esta macro. Você pode alterar este ícone na janela /macro."
--[[Translation missing --]]
L["Dragonflight has changed how the /click command operates.  As a result all your macro stubs (found in /macro) have been updated to match the value of the CVar ActionButtonUseKeyDown.  This is a one off configuration change that needs to be done for each character.  You can change this configuration in GSE's Options."] = "Dragonflight has changed how the /click command operates.  As a result all your macro stubs (found in /macro) have been updated to match the value of the CVar ActionButtonUseKeyDown.  This is a one off configuration change that needs to be done for each character.  You can change this configuration in GSE's Options."
L["Dungeon"] = "Masmorra"
L["Dungeon setting changed to Default."] = "Configuração de Masmorra alterada para o Padrão."
--[[Translation missing --]]
L["Edit Spell Cache"] = "Edit Spell Cache"
--[[Translation missing --]]
L["Edit this macro directly in Lua. WARNING: This may render the macro unable to operate and can crash your Game Session."] = "Edit this macro directly in Lua. WARNING: This may render the macro unable to operate and can crash your Game Session."
L["Editor Colours"] = "Editor de Cores"
L["Emphasis Colour"] = "Cor da Ênfase"
L["Enable"] = "Habilitar"
L["Enable Debug for the following Modules"] = "Habilitar Depuração para os seguintes Módulos"
L["Enable Mod Debug Mode"] = "Habilitar Modo de Depuração de Mod"
--[[Translation missing --]]
L["Enter the implementation link for this variable. Use '= true' or '= false' to test."] = "Enter the implementation link for this variable. Use '= true' or '= false' to test."
L["Error found in version %i of %s."] = "Erro encontrado na versão %i de %s."
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
L["Export"] = "Exportar"
L["Export a Sequence"] = "Exportar a Sequência"
L["Export Macro Read Only"] = "Exportar Macro Como Somente Leitura"
L["Export this Macro."] = "Exportar esta Macro."
--[[Translation missing --]]
L["Export Variable"] = "Export Variable"
L["Extra Macro Versions of %s has been added."] = "Versões Extra da Macro %s foram adicionadas."
--[[Translation missing --]]
L["Filter Sequence Selection"] = "Filter Sequence Selection"
L["Finished scanning for errors.  If no other messages then no errors were found."] = "Verificação de erros concluída. Se não houver outras mensagens, então nenhum erro foi encontrado."
--[[Translation missing --]]
L["Force CVar State"] = "Force CVar State"
L["General"] = "Geral"
L["General Options"] = "Opções Gerais"
--[[Translation missing --]]
L["Global"] = "Global"
--[[Translation missing --]]
L["Gnome Sequencer Enhanced"] = "Gnome Sequencer Enhanced"
L["Gnome Sequencer: Compress a Sequence String."] = "Gnome Sequencer: Comprime Códigos de Sequência."
L["Gnome Sequencer: Sequence Debugger. Monitor the Execution of your Macro"] = "Gnome Sequencer: Depurador de Sequência. Monitora a Execução da sua Macro"
L["GnomeSequencer was originally written by semlar of wowinterface.com."] = "O GnomeSequencer foi escrito originalmente por semlar do wowinterface.com."
L["GSE"] = "GSE"
--[[Translation missing --]]
L["GSE - %s's Macros"] = "GSE - %s's Macros"
--[[Translation missing --]]
L["GSE allows plugins to load Collections as plugins.  You can reload a collection by pressing the button below."] = "GSE allows plugins to load Collections as plugins.  You can reload a collection by pressing the button below."
--[[Translation missing --]]
L["GSE Discord"] = "GSE Discord"
L["GSE has a LibDataBroker (LDB) data feed.  List Other GSE Users and their version when in a group on the tooltip to this feed."] = "O GSE possui um feed de dados LibDataBroker (LDB). Lista outros usuários do GSE e sua versão, quando em um grupo, na tooltip para este feed."
L["GSE has a LibDataBroker (LDB) data feed.  Set this option to show queued Out of Combat events in the tooltip."] = "O GSE possui um feed de dados LibDataBroker (LDB). Defina esta opção para mostrar a fila de eventos Fora de Combate na tooltip."
L["GSE is a complete rewrite of that addon that allows you create a sequence of macros to be executed at the push of a button."] = "O GSE é uma reescrita completa do addon que permite criar uma sequência de macros a serem executadas com o pressionar de um botão."
L["GSE is out of date. You can download the newest version from https://www.curseforge.com/wow/addons/gse-gnome-sequencer-enhanced-advanced-macros."] = "Seu GSE está desatualizado. Você pode baixar a versão mais recente em https://www.curseforge.com/wow/addons/gse-gnome-sequencer-enhanced-advanced-macros"
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
L["GSE Users"] = "Usuários GSE"
L["GSE Version: %s"] = "Versão do GSE: %s"
--[[Translation missing --]]
L[ [=[GSE was originally forked from GnomeSequencer written by semlar.  It was enhanced by TImothyLuke to include a lot of configuration and boilerplate functionality with a GUI added.  The enhancements pushed the limits of what the original code could handle and was rewritten from scratch into GSE.

GSE itself wouldn't be what it is without the efforts of the people who write sequences with it.  Check out https://discord.gg/gseunited for the things that make this mod work.  Special thanks to Lutechi for creating the original WowLazyMacros community.]=] ] = ""
--[[Translation missing --]]
L["GSE: Advanced Macro Compiler loaded.|r  Type "] = "GSE: Advanced Macro Compiler loaded.|r  Type "
--[[Translation missing --]]
L["GSE: Export"] = "GSE: Export"
L["GSE: Import a Macro String."] = "GSE: Importando um Código de Macro."
L["GSE: Left Click to open the Sequence Editor"] = "GSE: Clique para abrir o Editor de Sequências"
--[[Translation missing --]]
L["GSE: Main Menu"] = "GSE: Main Menu"
--[[Translation missing --]]
L["GSE: Middle Click to open the Keybinding Interface"] = "GSE: Middle Click to open the Keybinding Interface"
L["GSE: Middle Click to open the Transmission Interface"] = "GSE: Clique com o Botão do Meio do Mouse para abrir a Interface de Transmissão"
--[[Translation missing --]]
L["GSE: Record your rotation to a macro."] = "GSE: Record your rotation to a macro."
L["GSE: Right Click to open the Sequence Debugger"] = "GSE: Clique com o Botão Direito do Mouse para abrir o Depurador de Sequências"
--[[Translation missing --]]
L["GSE: Whats New in "] = "GSE: Whats New in "
--[[Translation missing --]]
L["GSE2 Retro interface loaded.  Type `%s/gse2 import%s` to import an old GSE2 string or `%s/gse2 edit%s` to mock up a new template using the GSE2 editor."] = "GSE2 Retro interface loaded.  Type `%s/gse2 import%s` to import an old GSE2 string or `%s/gse2 edit%s` to mock up a new template using the GSE2 editor."
L["Help Colour"] = "Cor da Ajuda"
L["Help Information"] = "Informações de Ajuda"
L["Help Link"] = "Link de Ajuda"
L["Heroic"] = "Heroico"
L["Heroic setting changed to Default."] = "Configuração de Heroicos alterada para o Padrão."
L["Hide Login Message"] = "Esconder Mensagem de Entrada"
L["Hide Minimap Icon"] = "Esconder o Botão do Minimapa"
L["Hide Minimap Icon for LibDataBroker (LDB) data text."] = "Esconder o Ícone de Minimapa para o texto de dados do LibDataBroker (LDB)"
L["Hides the message that GSE is loaded."] = "Esconde a mensagem de GSE carregado."
L["History"] = "Histórico"
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
L["Icon Colour"] = "Cor do Ícone"
--[[Translation missing --]]
L["If Blocks require a variable that returns either true or false.  Create the variable first."] = "If Blocks require a variable that returns either true or false.  Create the variable first."
--[[Translation missing --]]
L["If Blocks Require a variable."] = "If Blocks Require a variable."
L["Ignore"] = "Ignorar"
--[[Translation missing --]]
L["Implementation Link"] = "Implementation Link"
L["Import"] = "Importar"
L["Import Macro from Forums"] = "Importar Macros dos Fóruns"
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
L["Language"] = "Idioma"
L["Language Colour"] = "Cor do Idioma"
--[[Translation missing --]]
L["Last Updated"] = "Last Updated"
L["Left Alt Key"] = "Tecla Alt Esquerda"
L["Left Control Key"] = "Tecla Ctrl Esquerda"
L["Left Mouse Button"] = "Botão Esquerdo do Mouse"
L["Left Shift Key"] = "Tecla Shift Esquerda"
--[[Translation missing --]]
L["LibActionButton is used by ConsolePort and Bartender.  Disabling this will use the standard version of this library."] = "LibActionButton is used by ConsolePort and Bartender.  Disabling this will use the standard version of this library."
L["Like a /castsequence macro, it cycles through a series of commands when the button is pushed. However, unlike castsequence, it uses macro text for the commands instead of spells, and it advances every time the button is pushed instead of stopping when it can't cast something."] = "Como uma macro /castsequence, ele percorre uma série de comandos quando o botão é pressionado. No entanto, diferentemente da castsequence, ele usa o texto da macro para os comandos, em vez de feitiços, e avança toda vez que o botão é pressionado em vez de parar quando não é possível executar algo."
L["Load"] = "Carregar"
L["Load Sequence"] = "Carregar Sequência"
--[[Translation missing --]]
L["Local Function: "] = "Local Function: "
L["Local Macro"] = "Macro Local"
--[[Translation missing --]]
L["Macro"] = "Macro"
L["Macro Collection to Import."] = "Coleção de Macro para Importar."
--[[Translation missing --]]
L["Macro Compile Error"] = "Macro Compile Error"
L["Macro found by the name %sPVP%s. Rename this macro to a different name to be able to use it.  WOW has a global object called PVP that is referenced instead of this macro."] = "Macro encontrada pelo nome%sPVP%s. Renomeie essa macro para um nome diferente para poder usá-la. O WOW possui um objeto global chamado PVP que é referenciado em vez dessa macro."
L["Macro found by the name %sWW%s. Rename this macro to a different name to be able to use it.  WOW has a hidden button called WW that is executed instead of this macro."] = "Macro encontrada pelo nome%sWW%s. Renomeie essa macro para um nome diferente para poder usá-la. O WOW possui um botão escondido chamado WW que é executado em vez dessa macro."
L["Macro Icon"] = "Ícone da Macro"
L["Macro Import Successful."] = "Importação de Macro com Sucesso."
--[[Translation missing --]]
L["Macro Name"] = "Macro Name"
--[[Translation missing --]]
L["Macro Name or Macro Commands"] = "Macro Name or Macro Commands"
--[[Translation missing --]]
L["Macro Template"] = "Macro Template"
L["Macro unable to be imported."] = "Não foi possível importar a macro."
L["Macro Version %d deleted."] = "Versão %d da Macro apagada."
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
L["Merge"] = "Fundir"
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
L["Mythic"] = "Mítico"
--[[Translation missing --]]
L["Mythic setting changed to Default."] = "Mythic setting changed to Default."
--[[Translation missing --]]
L["Mythic+"] = "Mythic+"
--[[Translation missing --]]
L["Mythic+ setting changed to Default."] = "Mythic+ setting changed to Default."
--[[Translation missing --]]
L["Name"] = "Name"
L["New"] = "Novo"
--[[Translation missing --]]
L["New Actionbar Override"] = "New Actionbar Override"
--[[Translation missing --]]
L["New KeyBind"] = "New KeyBind"
L["New Sequence Name"] = "Novo Nome de Sequência"
L["No"] = "Não"
--[[Translation missing --]]
L["No changes were made to "] = "No changes were made to "
L["No Help Information "] = "Sem Informações de Ajuda"
L["No Help Information Available"] = "Sem Informações de Ajuda Disponíveis"
L["Normal Colour"] = "Cor Normal"
--[[Translation missing --]]
L["Not Yet Active"] = "Not Yet Active"
L["Notes and help on how this macro works.  What things to remember.  This information is shown in the sequence browser."] = "Notas e ajuda para o funcionamento desta macro. Coisas para lembrar. Esta informação é mostrada no navegador de sequências."
--[[Translation missing --]]
L["OOC Queue Delay"] = "OOC Queue Delay"
--[[Translation missing --]]
L["Open %s in New Window"] = "Open %s in New Window"
--[[Translation missing --]]
L["Opens the GSE Options window"] = "Opens the GSE Options window"
L["Options"] = "Opções"
--[[Translation missing --]]
L["Options have been reset to defaults."] = "Options have been reset to defaults."
L["Output"] = "Saída"
--[[Translation missing --]]
L["Party"] = "Party"
--[[Translation missing --]]
L["Party setting changed to Default."] = "Party setting changed to Default."
L["Pause"] = "Pausa"
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
L["Picks a Custom Colour for emphasis."] = "Escolha uma Cor Personalizada para ênfases."
L["Picks a Custom Colour for the Author."] = "Escolha uma Cor Personalizada para o Autor."
L["Picks a Custom Colour for the Commands."] = "Escolha uma Cor Personalizada para os Comandos"
L["Picks a Custom Colour for the Mod Names."] = "Escolha uma Cor Personalizada para os Nomes de Mods"
L["Picks a Custom Colour to be used for braces and indents."] = "Escolha uma Cor Personalizada para ser usada por chaves e recuos."
L["Picks a Custom Colour to be used for Icons."] = "Escolha uma Cor Personalizada para ser usada por ícones."
L["Picks a Custom Colour to be used for language descriptors"] = "Escolha uma Cor Personalizada para ser usada por descritores de linguagens."
L["Picks a Custom Colour to be used for macro conditionals eg [mod:shift]"] = "Escolha uma Cor Personalizada para ser usada por condicionais de macros, por ex. [mod:shift]"
L["Picks a Custom Colour to be used for Macro Keywords like /cast and /target"] = "Escolha uma Cor Personalizada para ser usada por Palavras-chave de Macros, como /cast e /target"
L["Picks a Custom Colour to be used for numbers."] = "Escolha uma Cor Personalizada para ser usada por números."
L["Picks a Custom Colour to be used for Spells and Abilities."] = "Escolha uma Cor Personalizada para ser usada por Feitiços e Habilidades."
L["Picks a Custom Colour to be used for StepFunctions."] = "Escolha uma Cor Personalizada para ser usada por Funções de Etapa."
L["Picks a Custom Colour to be used for strings."] = "Escolha uma Cor Personalizada para ser usada por códigos."
L["Picks a Custom Colour to be used for unknown terms."] = "Escolha uma Cor Personalizada para uso em termos desconhecidos."
L["Picks a Custom Colour to be used normally."] = "Escolha uma Cor Personalizada para ser usada normalmente."
--[[Translation missing --]]
L["Plugins"] = "Plugins"
--[[Translation missing --]]
L["Print Active Modifiers on Click"] = "Print Active Modifiers on Click"
--[[Translation missing --]]
L["Print to the chat window if the alt, shift, control modifiers as well as the button pressed on each macro keypress."] = "Print to the chat window if the alt, shift, control modifiers as well as the button pressed on each macro keypress."
L["Priority List (1 12 123 1234)"] = "Lista de Prioridade (1 12 123 1234)"
--[[Translation missing --]]
L["Processing Collection of %s Elements."] = "Processing Collection of %s Elements."
--[[Translation missing --]]
L["PVP"] = "PVP"
--[[Translation missing --]]
L["PVP setting changed to Default."] = "PVP setting changed to Default."
L["Raid"] = "Raide"
--[[Translation missing --]]
L["Raid setting changed to Default."] = "Raid setting changed to Default."
L["Random - It will select .... a spell, any spell"] = "Aleatória - irá escolher .... um feitiço, qualquer feitiço"
--[[Translation missing --]]
L["Raw Edit"] = "Raw Edit"
--[[Translation missing --]]
L["Ready to Send"] = "Ready to Send"
L["Received Sequence "] = "Sequência Recebida"
L["Record"] = "Gravada"
L["Record Macro"] = "Macro Gravada"
L["Registered Addons"] = "Addons Registrados"
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
L["Resets"] = "Reiniciar"
--[[Translation missing --]]
L["Resets sequences back to the initial state when out of combat."] = "Resets sequences back to the initial state when out of combat."
--[[Translation missing --]]
L["Restricted"] = "Restricted"
--[[Translation missing --]]
L["RESTRICTED: Macro specifics disabled by author."] = "RESTRICTED: Macro specifics disabled by author."
L["Resume"] = "Resumo"
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
L["Save"] = "Salvar"
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
L["Send"] = "Enviar"
--[[Translation missing --]]
L["Send this macro to another GSE player who is on the same server as you are."] = "Send this macro to another GSE player who is on the same server as you are."
L["Send To"] = "Enviar Para"
L["Sequence"] = "Sequência"
L["Sequence Compare"] = "Comparador de Sequências"
L["Sequence Debugger"] = "Depurador de Sequências"
L["Sequence Editor"] = "Editor de Sequências"
L["Sequence Name"] = "Nome da Sequência"
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
L["Sequential (1 2 3 4)"] = "Sequencial (1 2 3 4)"
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
--[[Translation missing --]]
L["Source Language "] = "Source Language "
--[[Translation missing --]]
L["Specialisation"] = "Specialisation"
--[[Translation missing --]]
L["Specialisation / Class ID"] = "Specialisation / Class ID"
L["SpecID/ClassID Colour"] = "Cor do SpecID/ClassID"
--[[Translation missing --]]
L["Spell"] = "Spell"
--[[Translation missing --]]
L["Spell Cache Editor"] = "Spell Cache Editor"
L["Spell Colour"] = "Cor do Feitiço"
--[[Translation missing --]]
L["Spell ID"] = "Spell ID"
--[[Translation missing --]]
L["Spell Name"] = "Spell Name"
--[[Translation missing --]]
L["State"] = "State"
L["Step Function"] = "Função de Etapa"
L["Step Functions"] = "Funções de Etapa"
L["Stop"] = "Parar"
--[[Translation missing --]]
L["Store Debug Messages"] = "Store Debug Messages"
--[[Translation missing --]]
L["Store output of debug messages in a Global Variable that can be referrenced by other mods."] = "Store output of debug messages in a Global Variable that can be referrenced by other mods."
L["String Colour"] = "Cor do Código"
--[[Translation missing --]]
L["Support GSE"] = "Support GSE"
--[[Translation missing --]]
L["Supporters"] = "Supporters"
--[[Translation missing --]]
L["Talent Loadout"] = "Talent Loadout"
L["Talents"] = "Talentos"
L["Target language "] = "Linguagem do Alvo"
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
L["Title Colour"] = "Cor do Título"
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
L["Unknown Colour"] = "Cor de Desconhecido"
--[[Translation missing --]]
L["Unrecognised Import"] = "Unrecognised Import"
--[[Translation missing --]]
L["Update"] = "Update"
--[[Translation missing --]]
L["Update Talents"] = "Update Talents"
--[[Translation missing --]]
L["Update the stored talents to match the current chosen talents."] = "Update the stored talents to match the current chosen talents."
--[[Translation missing --]]
L["Updated Macro"] = "Updated Macro"
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
L["When loading or creating a sequence, if it is a global or the macro has an unknown specID automatically create the Macro Stub in Account Macros"] = "Ao carregar ou criar uma sequência, se ela for global ou a macro tiver um specID desconhecido, cria automaticamente o Esboço da Macro nas Macros da Conta"
--[[Translation missing --]]
L["When loading or creating a sequence, if it is a macro of the same class automatically create the Macro Stub"] = "When loading or creating a sequence, if it is a macro of the same class automatically create the Macro Stub"
--[[Translation missing --]]
L["Window Sizes"] = "Window Sizes"
L["Yes"] = "Sim"
L["You cannot delete the Default version of this macro.  Please choose another version to be the Default on the Configuration tab."] = "Você não pode apagar a versão Padrão desta macro. Por favor escolha outra versão para ser a versão Padrão na aba Configuração."
--[[Translation missing --]]
L["You cannot open a new Sequence Editor window while you are in combat.  Please exit combat and then try again."] = "You cannot open a new Sequence Editor window while you are in combat.  Please exit combat and then try again."
--[[Translation missing --]]
L["You need to reload the User Interface to complete this task.  Would you like to do this now?"] = "You need to reload the User Interface to complete this task.  Would you like to do this now?"
--[[Translation missing --]]
L["Your ClassID is "] = "Your ClassID is "
--[[Translation missing --]]
L["Your current Specialisation is "] = "Your current Specialisation is "


