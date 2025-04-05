if GetLocale() ~= "frFR" then
    return
end

local L = LibStub("AceLocale-3.0"):NewLocale("GSE", "frFR")

-- Options translation
L["  The Alternative ClassID is "] = " La ClassID alternative est "
L[" Deleted Orphaned Macro "] = "Macro orpheline supprimée"
L[" from "] = "de"
L[" is not available.  Unable to translate sequence "] = "n'est pas disponible. Impossible de traduire la macro"
L[" macros per Account.  You currently have "] = "macros par compte. Vous en avez actuellement"
L[" macros per character.  You currently have "] = "macros par personnage. Vous en avez actuellement"
L[" sent"] = "envoyé"
L[" was imported as a new macro."] = "a été importé comme une nouvelle macro."
L[" was imported with the following errors."] = "a été importé avec les erreurs suivantes."
--[[Translation missing --]]
L[" was imported."] = " was imported."
L[" was updated to new version."] = " a été mis à jour sous une nouvelle version."
L["%s macro may cause a 'RestrictedExecution.lua:431' error as it has %s actions when compiled.  This get interesting when you go past 255 actions.  You may need to simplify this macro."] = "La macro %s peut provoquer une erreur 'RestrictedExecution.lua:431' car elle contient des actions %s lors de la compilation. Cela devient intéressant lorsque vous dépassez 255 actions. Vous devrez peut-être simplifier cette macro."
--[[Translation missing --]]
L["%s/255 Characters Used"] = "%s/255 Characters Used"
--[[Translation missing --]]
L[", You will need to correct errors in this variable from another source."] = ", You will need to correct errors in this variable from another source."
L["/gse checkmacrosforerrors|r will loop through your macros and check for corrupt macro versions.  This will then show how to correct these issues."] = "/gse checkmacrosforerrors|r parcourra vos macros et vérifiera les versions de macro corrompues. Cela vous montrera ensuite comment corriger ces problèmes."
L["/gse cleanorphans|r will loop through your macros and delete any left over GSE macros that no longer have a sequence to match them."] = "/gse cleanorphans|r parcourra vos macros et supprimera toutes les macros GSE restantes qui n'ont plus de séquence qui leur corresponde."
L["/gse help|r to get started."] = "Tapez /gse help|r pour commencer."
L["/gse showspec|r will show your current Specialisation and the SPECID needed to tag any existing macros."] = "/gse showspec|r affichera votre spécialisation actuelle et le SPECID nécessaire pour taguer toutes les macros existantes."
--[[Translation missing --]]
L["/gse|r again."] = "/gse|r again."
L["/gse|r to get started."] = "Tapez gse|r pour commencer."
L["/gse|r will list any macros available to your spec.  This will also add any macros available for your current spec to the macro interface."] = "/gse|r listera toutes les macros disponibles pour votre spécification. Cela ajoutera également toutes les macros disponibles pour votre spécification actuelle à l'interface des macros."
L["|r.  You can also have a  maximum of "] = "|r. Vous pouvez également avoir un maximum de "
L["<DEBUG> |r "] = "<DEBUG> |r"
L["<SEQUENCEDEBUG> |r "] = "<SEQUENCEDEBUG> |r"
--[[Translation missing --]]
L[ [=[A pause can be measured in either clicks or seconds.  It will either wait 5 clicks or 1.5 seconds.
If using seconds, you can also wait for the GCD by entering ~~GCD~~ into the box.]=] ] = ""
L["About"] = "A propos "
L["About GSE"] = "A propos de GSE"
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
L["Actions"] = "Actions"
L["Add a Loop Block."] = "Ajoute un bloc pour la boucle."
L["Add a Pause Block."] = "Ajoute un bloc pour la pause."
L["Add Action"] = "Ajouter une action"
L["Add an Action Block."] = "Ajoute un bloc pour l'action."
L["Add an If Block.  If Blocks allow you to shoose between blocks based on the result of a variable that returns a true or false value."] = "Ajoute un bloc Si. Les blocs Si vous permettent de choisir entre différents blocs en fonction du résultat d'une variable qui renvoie une valeur vraie ou fausse."
L["Add If"] = "Ajouter un bloc Si"
L["Add Loop"] = "Ajouter une boucle"
L["Add Pause"] = "Ajouter une pause"
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
L["Alt Keys."] = "Touches Alt"
--[[Translation missing --]]
L["Alwaus use the highest rank of spell available.  This is useful for levelling."] = "Alwaus use the highest rank of spell available.  This is useful for levelling."
--[[Translation missing --]]
L["Always use Max Rank"] = "Always use Max Rank"
L["Any Alt Key"] = "Touche Alt gauche ou droite"
L["Any Control Key"] = "Touche Ctrl gauche ou droite"
L["Any Shift Key"] = "Touche Maj gauche ou droite"
L["Are you sure you want to delete %s?  This will delete the macro and all versions.  This action cannot be undone."] = "Etes-vous sûr de vouloir supprimer %s ? La macro et toutes ses versions seront supprimées. Cette action ne peut pas être annulée."
L["Arena"] = "Arène"
L["Arena setting changed to Default."] = "Les paramètres des Arènes ont été définis comme ceux par défaut."
L["As GSE is updated, there may be left over macros that no longer relate to sequences.  This will check for these automatically on logout.  Alternatively this check can be run via /gse cleanorphans"] = "Au fur et à mesure que GSE est mis à jour, il peut rester des macros qui ne sont plus liées aux séquences. Ceci les vérifiera automatiquement à la déconnexion. Sinon, cette vérification peut être exécutée via /gse cleanorphans"
L["Author"] = "Auteur"
L["Author Colour"] = "Couleur de l'auteur"
L["Automatically Create Macro Icon"] = "Créer automatiquement l'icône de la macro"
L["Blizzard Functions Colour"] = "Couleur des fonctionnalités Blizzard"
--[[Translation missing --]]
L["Block Path"] = "Block Path"
L["Block Type: %s"] = "Type de bloc : %s"
L["Boolean Functions"] = "Fonctions booléennes"
L["Boolean Functions are GSE variables that return either a true or false value."] = "Les fonctions booléennes sont des variables GSE qui renvoient une valeur vraie ou fausse."
L["Boolean not found.  There is a problem with %s not returning true or false."] = "Booléen introuvable. Il y a un problème avec %s qui ne renvoie pas vrai ou faux."
--[[Translation missing --]]
L["Button State"] = "Button State"
L["By setting the default Icon for all macros to be the QuestionMark, the macro button on your toolbar will change every key hit."] = [=[Cette option ajoutera l'icône par défaut (le point d'interrogation) à toutes vos macros. Ainsi, le bouton de votre macro (sur votre barre d'outils) changera à chaque frappe de touche en affichant l'îcone de chaque sort.
]=]
--[[Translation missing --]]
L["By setting this value the Sequence Editor will show every sequence for every class."] = "By setting this value the Sequence Editor will show every sequence for every class."
--[[Translation missing --]]
L["By setting this value the Sequence Editor will show every sequence for your class.  Turning this off will only show the class sequences for your current specialisation."] = "By setting this value the Sequence Editor will show every sequence for your class.  Turning this off will only show the class sequences for your current specialisation."
L["Cancel"] = "Annuler"
--[[Translation missing --]]
L["Changes Left Side, Changes Right Side, Many Changes!!!! Handle It!"] = "Changes Left Side, Changes Right Side, Many Changes!!!! Handle It!"
L["Character"] = "Personnage"
--[[Translation missing --]]
L["Character Macros"] = "Character Macros"
L["Character Specific Options which override the normal account settings."] = "Options spécifiques aux personnages qui remplacent les paramètres normaux du compte."
--[[Translation missing --]]
L["Chat Link"] = "Chat Link"
L["Checks to see if you have a Heart of Azeroth equipped and if so will insert '/cast Heart Essence' into the macro.  If not your macro will skip this line."] = "Vérifie si vous êtes équipé d'un Cœur d'Azeroth et si c'est le cas, insère '/cast Heart Essence' dans la macro. Sinon, votre macro sautera cette ligne."
L["Choose import action:"] = "Choisissez comment importer :"
L["Clear"] = "Effacer"
L["Clear Common Keybindings"] = "Effacer les raccourcis clavier principaux"
L["Clear Keybindings"] = "Effacer les raccourcis clavier"
--[[Translation missing --]]
L["Clear Spell Cache"] = "Clear Spell Cache"
L["Clicks"] = "Clics"
L["Close"] = "Fermer"
L["Close to Maximum Macros.|r  You can have a maximum of "] = "Nombre de macros presque atteint.|r Vous pouvez avoir un maximum de"
L["Close to Maximum Personal Macros.|r  You can have a maximum of "] = "Nombre de macros pour ce perso presque atteint.|r Vous pouvez avoir un maximum de"
L["Colour"] = "Couleur"
L["Colour and Accessibility Options"] = "Couleur et options d'accessibilité"
L["Combat"] = "Combat"
L["Command Colour"] = "Couleur des commandes"
--[[Translation missing --]]
L["Common Solutions to game quirks that seem to affect some people."] = "Common Solutions to game quirks that seem to affect some people."
L["Compile"] = "Compiler"
L["Compiled"] = "Compilé"
--[[Translation missing --]]
L["Compiled Macro"] = "Compiled Macro"
L["Compiled Template"] = "Version compilée"
L["Compress"] = "Compresser"
L["Compress Sequence from Forums"] = "Compresser les macros provenant de forums"
L["Conditionals Colour"] = "Couleur des conditions"
L["Configuration"] = "Configuration"
L["Continue"] = "Continuer"
L["Control Keys."] = "Touches Ctrl"
--[[Translation missing --]]
L["Convert"] = "Convert"
--[[Translation missing --]]
L["Convert this to a GSE3 Template"] = "Convert this to a GSE3 Template"
L["Copy this link and open it in a Browser."] = "Copiez ce lien et ouvrez-le dans un navigateur."
L["Copy this link and paste it into a chat window."] = "Copiez ce lien et collez-le dans une fenêtre de discussion."
--[[Translation missing --]]
L["Create a new macro in the /macro interface and assign it an Icon. Then reopen this menu.  You cannot create a new macro here but after it has been created you can manage it."] = "Create a new macro in the /macro interface and assign it an Icon. Then reopen this menu.  You cannot create a new macro here but after it has been created you can manage it."
--[[Translation missing --]]
L["Create Human Readable Export"] = "Create Human Readable Export"
--[[Translation missing --]]
L["Create Human Readable Exports"] = "Create Human Readable Exports"
L["Create Icon"] = "Créer l'icône"
L["Create Macro"] = "Créer la macro"
L["Current GCD"] = "CGD actuel"
L["Current GCD: %s"] = "GCD actuel : %s"
--[[Translation missing --]]
L["Current Value"] = "Current Value"
--[[Translation missing --]]
L["CVar Settings"] = "CVar Settings"
L["Debug"] = "Débogage"
L["Debug Mode Options"] = "Options du mode de débogage"
L["Debug Output Options"] = "Options de sortie de débogage"
L["Decompress"] = "Décompresser"
L["Default Debugger Height"] = "Hauteur par défaut du débogueur"
L["Default Debugger Width"] = "Largeur par défaut du débogueur"
L["Default Editor Height"] = "Hauteur par défaut de l'éditeur"
L["Default Editor Width"] = "Largeur par défaut de l'éditeur"
L["Default Import Action"] = "Action d'importation par défaut"
--[[Translation missing --]]
L["Default Keybinding Height"] = "Default Keybinding Height"
--[[Translation missing --]]
L["Default Keybinding Width"] = "Default Keybinding Width"
L["Default Menu Height"] = "Hauteur par défaut de la liste"
L["Default Menu Width"] = "Largeur par défaut de la liste"
L["Default Version"] = "Version par défaut"
L["Delete"] = "Supprimer"
L["Delete Block"] = "Supprimer le bloc"
L["Delete Icon"] = "Supprimer l'icône"
--[[Translation missing --]]
L[ [=[Delete this Block from the sequence.  
WARNING: If this is a loop this will delete all the blocks inside the loop as well.]=] ] = ""
L["Delete this macro.  This is not able to be undone."] = "Supprimer cette macro. Cette action est irréversible."
L["Delete this variable from the sequence."] = "Supprime cette variable de la macro."
--[[Translation missing --]]
L[ [=[Delete this verion of the macro.  This can be undone by closing this window and not saving the change.  
This is different to the Delete button below which will delete this entire macro.]=] ] = ""
L["Delete Variable"] = "Supprimer la variable"
L["Delete Version"] = "Supprimer cette version"
L["Disable"] = "Désactiver"
L["Disable Block"] = "Désactiver ce bloc"
L["Disable Editor"] = "Désactiver l'éditeur"
--[[Translation missing --]]
L["Disable inbuilt LibActionButton"] = "Disable inbuilt LibActionButton"
L["Disable Sequence"] = "Désactiver la macro"
L["Disable this block so that it is not executed. If this is a container block, like a loop, all the blocks within it will also be disabled."] = "Désactiver ce bloc pour qu'il ne soit pas exécuté. S'il s'agit d'un bloc conteneur, comme une boucle, tous les blocs qu'il contient seront également désactivés."
L["Display debug messages in Chat Window"] = "Afficher les messages de débogage dans la fenêtre de discussion"
--[[Translation missing --]]
L["Do not compile this Sequence at startup."] = "Do not compile this Sequence at startup."
--[[Translation missing --]]
L["Don't Force"] = "Don't Force"
L["Drag this icon to your action bar to use this macro. You can change this icon in the /macro window."] = "Faites glisser cette icône sur votre barre d'action pour utiliser cette macro. Vous pouvez changer l'icône dans la fenêtre /macro."
--[[Translation missing --]]
L["Dragonflight has changed how the /click command operates.  As a result all your macro stubs (found in /macro) have been updated to match the value of the CVar ActionButtonUseKeyDown.  This is a one off configuration change that needs to be done for each character.  You can change this configuration in GSE's Options."] = "Dragonflight has changed how the /click command operates.  As a result all your macro stubs (found in /macro) have been updated to match the value of the CVar ActionButtonUseKeyDown.  This is a one off configuration change that needs to be done for each character.  You can change this configuration in GSE's Options."
L["Dungeon"] = "Donjon"
L["Dungeon setting changed to Default."] = "Les paramètres des Donjons ont été définis comme ceux par défaut."
--[[Translation missing --]]
L["Edit Spell Cache"] = "Edit Spell Cache"
L["Edit this macro directly in Lua. WARNING: This may render the macro unable to operate and can crash your Game Session."] = "Modifiez cette macro directement en language Lua. AVERTISSEMENT : cela peut rendre la macro incapable de fonctionner et faire planter votre session de jeu."
L["Editor Colours"] = "Couleurs de l'éditeur"
L["Emphasis Colour"] = "Couleur d'emphase"
L["Enable"] = "Activer"
L["Enable Debug for the following Modules"] = "Activer le débogage pour les modules suivants"
L["Enable Mod Debug Mode"] = "Activer le mode de débogage"
--[[Translation missing --]]
L["Enter the implementation link for this variable. Use '= true' or '= false' to test."] = "Enter the implementation link for this variable. Use '= true' or '= false' to test."
L["Error found in version %i of %s."] = "Erreur trouvée dans la version %i de %s."
L["Error processing Custom Pause Value.  You will need to recheck your macros."] = "Erreur lors du traitement de la pause personnalisée. Vous devrez revérifier vos macros."
--[[Translation missing --]]
L["Error: Destination path not found."] = "Error: Destination path not found."
--[[Translation missing --]]
L["Error: Source path not found."] = "Error: Source path not found."
--[[Translation missing --]]
L["Error: You cannot move a container to be a child within itself."] = "Error: You cannot move a container to be a child within itself."
--[[Translation missing --]]
L["Experimental Features"] = "Experimental Features"
L["Export"] = "Exporter"
L["Export a Sequence"] = "Exporter une macro"
L["Export Macro Read Only"] = "Exporter la macro en lecture seule"
L["Export this Macro."] = "Exporter cette macro."
--[[Translation missing --]]
L["Export Variable"] = "Export Variable"
L["Extra Macro Versions of %s has been added."] = "Des versions de macro supplémentaires de %s ont été ajoutées."
--[[Translation missing --]]
L["Filter Sequence Selection"] = "Filter Sequence Selection"
L["Finished scanning for errors.  If no other messages then no errors were found."] = "Recherche d'erreurs terminée. S'il n'y a pas d'autres messages, alors aucune erreur n'a été trouvée. "
--[[Translation missing --]]
L["Force CVar State"] = "Force CVar State"
L["General"] = "Général"
L["General Options"] = "Options générales"
L["Global"] = "Global"
--[[Translation missing --]]
L["Gnome Sequencer Enhanced"] = "Gnome Sequencer Enhanced"
L["Gnome Sequencer: Compress a Sequence String."] = "Gnome Sequencer : Compression d'une partie de macro"
L["Gnome Sequencer: Sequence Debugger. Monitor the Execution of your Macro"] = "Gnome Sequencer: Débogueur de Macro. Permet de suivre l'exécution de votre macro."
L["GnomeSequencer was originally written by semlar of wowinterface.com."] = "GnomeSequencer a été initialement écrit par semlar de wowinterface.com."
L["GSE"] = "GSE"
L["GSE - %s's Macros"] = "GSE - Macros de %s"
--[[Translation missing --]]
L["GSE allows plugins to load Collections as plugins.  You can reload a collection by pressing the button below."] = "GSE allows plugins to load Collections as plugins.  You can reload a collection by pressing the button below."
--[[Translation missing --]]
L["GSE Discord"] = "GSE Discord"
L["GSE has a LibDataBroker (LDB) data feed.  List Other GSE Users and their version when in a group on the tooltip to this feed."] = "GSE dispose d'un flux de données LibDataBroker (LDB). Cochez cette case pour afficher dans l'info-bulle les autres utilisateurs de GSE ainsi que leur version de GSE lorsqu'ils sont dans un groupe."
L["GSE has a LibDataBroker (LDB) data feed.  Set this option to show queued Out of Combat events in the tooltip."] = "GSE dispose d'un flux de données LibDataBroker (LDB). Cochez cette case pour afficher les événements hors combat en file d'attente dans l'info-bulle."
L["GSE is a complete rewrite of that addon that allows you create a sequence of macros to be executed at the push of a button."] = "GSE est basé sur cet addon mais a été complètement réécrit pour vous permettre de créer une suite de macros à exécuter en appuyant successivement sur un bouton."
L["GSE is out of date. You can download the newest version from https://www.curseforge.com/wow/addons/gse-gnome-sequencer-enhanced-advanced-macros."] = "GSE est obsolète. Vous pouvez télécharger la dernière version sur https://www.curseforge.com/wow/addons/gse-gnome-sequencer-enhanced-advanced-macros ."
--[[Translation missing --]]
L["GSE Macro Stubs have been reset to KeyDown configuration.  The /click command needs to be `/click TEMPLATENAME LeftButton t` (Note the 't' here is required along with the LeftButton.)"] = "GSE Macro Stubs have been reset to KeyDown configuration.  The /click command needs to be `/click TEMPLATENAME LeftButton t` (Note the 't' here is required along with the LeftButton.)"
--[[Translation missing --]]
L["GSE Macro Stubs have been reset to KeyUp configuration.  The /click command needs to be `/click TEMPLATENAME`"] = "GSE Macro Stubs have been reset to KeyUp configuration.  The /click command needs to be `/click TEMPLATENAME`"
L["GSE Plugins"] = "Plugins GSE"
L["GSE Raw Editor"] = "GSE Editeur brut"
L["GSE stores the base spell and asks WoW to use that ability.  WoW will then choose the current version of the spell.  This toggle switches between showing the Base Spell or the Current Spell."] = "GSE stocke le sort de base et demande à WoW d'utiliser cette compétence. WoW choisira alors la version actuelle du sort. Cela permet de basculer entre l'affichage du sort de base ou du sort actuel."
L["GSE Users"] = "Utilisateurs GSE"
L["GSE Version: %s"] = "La version de GSE est la %s"
--[[Translation missing --]]
L[ [=[GSE was originally forked from GnomeSequencer written by semlar.  It was enhanced by TImothyLuke to include a lot of configuration and boilerplate functionality with a GUI added.  The enhancements pushed the limits of what the original code could handle and was rewritten from scratch into GSE.

GSE itself wouldn't be what it is without the efforts of the people who write sequences with it.  Check out https://discord.gg/gseunited for the things that make this mod work.  Special thanks to Lutechi for creating the original WowLazyMacros community.]=] ] = ""
L["GSE: Advanced Macro Compiler loaded.|r  Type "] = "GSE: Advanced Macro Compiler chargé.|r Type"
--[[Translation missing --]]
L["GSE: Export"] = "GSE: Export"
L["GSE: Import a Macro String."] = "GSE : Importation d'une macro (ou d'une partie de celle-ci)"
L["GSE: Left Click to open the Sequence Editor"] = "GSE : Clic gauche pour ouvrir l'Editeur de Macro"
--[[Translation missing --]]
L["GSE: Main Menu"] = "GSE: Main Menu"
--[[Translation missing --]]
L["GSE: Middle Click to open the Keybinding Interface"] = "GSE: Middle Click to open the Keybinding Interface"
L["GSE: Middle Click to open the Transmission Interface"] = "GSE : Clic central de la souris pour ouvrir l'interface de transmission"
--[[Translation missing --]]
L["GSE: Record your rotation to a macro."] = "GSE: Record your rotation to a macro."
L["GSE: Right Click to open the Sequence Debugger"] = "GSE : Clic droit pour ouvrir le Débogueur de Macro"
--[[Translation missing --]]
L["GSE: Whats New in "] = "GSE: Whats New in "
--[[Translation missing --]]
L["GSE2 Retro interface loaded.  Type `%s/gse2 import%s` to import an old GSE2 string or `%s/gse2 edit%s` to mock up a new template using the GSE2 editor."] = "GSE2 Retro interface loaded.  Type `%s/gse2 import%s` to import an old GSE2 string or `%s/gse2 edit%s` to mock up a new template using the GSE2 editor."
L["Help Colour"] = "Couleur pour l'aide"
L["Help Information"] = "Informations"
L["Help Link"] = "Lien"
L["Heroic"] = "Héroïque"
L["Heroic setting changed to Default."] = "Les paramètres des Héroïques ont été définis comme ceux par défaut."
L["Hide Login Message"] = "Masquer le message de connexion"
L["Hide Minimap Icon"] = "Masquer l'icône de la minicarte"
L["Hide Minimap Icon for LibDataBroker (LDB) data text."] = "Cochez cette case pour masquer l'icône de la minicarte."
L["Hides the message that GSE is loaded."] = "Masque le message indiquant que GSE est chargé."
L["History"] = "Historique"
L["How many macro Clicks to pause for?"] = "Pendant combien de \"clics\" faire la pause ?"
L["How many milliseconds to pause for?"] = "Combien de millisecondes faut-il faire une pause ?"
--[[Translation missing --]]
L["How many pixels high should Keybindings start at.  Defaults to 500"] = "How many pixels high should Keybindings start at.  Defaults to 500"
L["How many pixels high should the Debuger start at.  Defaults to 500"] = "A quelle dimension (hauteur) le débogueur doit-il démarrer. Par défaut à 500 pixels."
L["How many pixels high should the Editor start at.  Defaults to 700"] = "Hauteur minimale pour l'éditeur. La valeur par défaut est 700 pixels. "
L["How many pixels high should the Menu start at.  Defaults to 500"] = "A quelle dimension (hauteur) la liste doit-elle démarrer. Par défaut à 500 pixels."
--[[Translation missing --]]
L["How many pixels wide should Keybinding start at.  Defaults to 700"] = "How many pixels wide should Keybinding start at.  Defaults to 700"
L["How many pixels wide should the Debugger start at.  Defaults to 700"] = "A quelle dimension (largeur) le débogueur doit-il démarrer. Par défaut à 700 pixels."
L["How many pixels wide should the Editor start at.  Defaults to 700"] = "Largeur minimale pour l'éditeur. La valeur par défaut est 700 pixels. "
L["How many pixels wide should the Menu start at.  Defaults to 700"] = "A quelle dimension (largeur) la liste doit-elle démarrer. Par défaut à 700 pixels."
L["How many seconds to pause for?"] = "Pendant combien de secondes faire la pause ?"
L["How many times does this action repeat"] = "Combien de fois cette action doit se répéter"
L["Icon Colour"] = "Couleur de l'icône"
L["If Blocks require a variable that returns either true or false.  Create the variable first."] = "Les blocs Si nécessitent une variable qui renvoie vrai ou faux. Créez d'abord la variable."
L["If Blocks Require a variable."] = "Les blocs 'SI' requièrent une variable."
L["Ignore"] = "Ignorer"
--[[Translation missing --]]
L["Implementation Link"] = "Implementation Link"
L["Import"] = "Importer"
L["Import Macro from Forums"] = "Importer une macro à partir de forums."
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
L["Interval"] = "Intervalle"
L["Invalid value entered into pause block. Needs to be 'GCD' or a Number."] = "Une valeur invalide a été entrée dans le bloc de pause. Ce doit être \"GCD\" ou un nombre."
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
L["Language"] = "Langue"
L["Language Colour"] = "Couleur de langue"
--[[Translation missing --]]
L["Last Updated"] = "Last Updated"
L["Left Alt Key"] = "Touche Alt gauche"
L["Left Control Key"] = "Touche Ctrl gauche"
L["Left Mouse Button"] = "Bouton gauche de la souris"
L["Left Shift Key"] = "Touche Maj gauche"
--[[Translation missing --]]
L["LibActionButton is used by ConsolePort and Bartender.  Disabling this will use the standard version of this library."] = "LibActionButton is used by ConsolePort and Bartender.  Disabling this will use the standard version of this library."
L["Like a /castsequence macro, it cycles through a series of commands when the button is pushed. However, unlike castsequence, it uses macro text for the commands instead of spells, and it advances every time the button is pushed instead of stopping when it can't cast something."] = "Comme une macro /castsequence, il parcourt une série de commandes lorsque le bouton est enfoncé. Cependant, contrairement à castsequence, il utilise du texte de macro pour les commandes au lieu de sorts, et avance à chaque fois que le bouton est enfoncé au lieu de s'arrêter lorsqu'il ne peut pas lancer quelque chose."
L["Load"] = "Charger"
L["Load Sequence"] = "Charger la macro"
L["Local Function: "] = "Fonction locale :"
L["Local Macro"] = "Macro locale"
--[[Translation missing --]]
L["Macro"] = "Macro"
L["Macro Collection to Import."] = "Collection de macros à importer."
L["Macro Compile Error"] = "Erreur de compilation de la macro."
L["Macro found by the name %sPVP%s. Rename this macro to a different name to be able to use it.  WOW has a global object called PVP that is referenced instead of this macro."] = "Macro trouvée sous le nom %sPVP%s. Renommez cette macro sous un autre nom pour pouvoir l'utiliser. WOW a un objet global appelé PVP qui est référencé à la place de cette macro."
L["Macro found by the name %sWW%s. Rename this macro to a different name to be able to use it.  WOW has a hidden button called WW that is executed instead of this macro."] = "Macro trouvée sous le nom %sWW%s. Renommez cette macro sous un autre nom pour pouvoir l'utiliser. WOW a un bouton caché appelé WW qui est exécuté à la place de cette macro."
L["Macro Icon"] = "Icône de la macro"
L["Macro Import Successful."] = "Importation de macro réussie."
--[[Translation missing --]]
L["Macro Name"] = "Macro Name"
--[[Translation missing --]]
L["Macro Name or Macro Commands"] = "Macro Name or Macro Commands"
--[[Translation missing --]]
L["Macro Template"] = "Macro Template"
L["Macro unable to be imported."] = "Macro impossible à importer."
L["Macro Version %d deleted."] = "La version %d a été supprimée."
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
L["Measure"] = "Mesurer"
L["Merge"] = "Fusionner"
L["Middle Mouse Button"] = "Bouton central de la souris"
L["Millisecond click settings"] = "Paramètres des clics (en millisecondes)"
L["Milliseconds"] = "Millisecondes"
--[[Translation missing --]]
L["Missing Variable "] = "Missing Variable "
--[[Translation missing --]]
L["modified in other window.  This view is now behind the current sequence."] = "modified in other window.  This view is now behind the current sequence."
L["Mouse Button 4"] = "Bouton de la souris 4"
L["Mouse Button 5"] = "Bouton de la souris 5"
L["Mouse Buttons."] = "Buttons de la souris"
L["Move Down"] = "Descendre"
L["Move this block down one block."] = "Descend ce bloc d'un cran (un bloc en dessous)."
L["Move this block up one block."] = "Monte ce bloc d'un cran (un bloc au dessus)."
L["Move Up"] = "Monter"
L["Moved %s to class %s."] = "%s a été déplacé vers la classe %s."
L["MS Click Rate"] = "Vitesse des clics en millisecondes (ms)"
L["Mythic"] = "Mythique"
L["Mythic setting changed to Default."] = "Les paramètres des Mythiques ont été définis comme ceux par défaut."
L["Mythic+"] = "Mythique+"
L["Mythic+ setting changed to Default."] = "Les paramètres des Mythiques+ ont été définis comme ceux par défaut."
L["Name"] = "Nom"
L["New"] = "Nouveau"
--[[Translation missing --]]
L["New Actionbar Override"] = "New Actionbar Override"
--[[Translation missing --]]
L["New KeyBind"] = "New KeyBind"
L["New Sequence Name"] = "Nouveau nom de macro"
L["No"] = "Non"
L["No changes were made to "] = "Aucune modification n'a été apportée à"
L["No Help Information "] = "Aucune information"
L["No Help Information Available"] = "Aucune information disponible"
L["Normal Colour"] = "Couleur normale"
--[[Translation missing --]]
L["Not Yet Active"] = "Not Yet Active"
L["Notes and help on how this macro works.  What things to remember.  This information is shown in the sequence browser."] = "Notes et informations sur le fonctionnement de cette macro. Celles-ci sont affichées dans la liste des macros."
--[[Translation missing --]]
L["OOC Queue Delay"] = "OOC Queue Delay"
--[[Translation missing --]]
L["Open %s in New Window"] = "Open %s in New Window"
L["Opens the GSE Options window"] = "Ouvre les options de GSE."
L["Options"] = "Options"
L["Options have been reset to defaults."] = "Les options ont été réinitialisées à leurs valeurs par défaut."
L["Output"] = "Sortie"
L["Party"] = "Groupe"
L["Party setting changed to Default."] = "Les paramètres des Groupes ont été définis comme ceux par défaut."
L["Pause"] = "Pause"
L["Pause for the GCD."] = "Durée de la pause pour le GCD."
L["Paused"] = "En pause"
L["Paused - In Combat"] = "En pause - En combat"
--[[Translation missing --]]
L["Pet"] = "Pet"
--[[Translation missing --]]
L["Pet Ability"] = "Pet Ability"
L["Picks a Custom Colour for emphasis."] = "Choisit une couleur personnalisée pour l'emphase."
L["Picks a Custom Colour for the Author."] = "Choisit une couleur personnalisée pour l'auteur."
L["Picks a Custom Colour for the Commands."] = "Choisit une couleur personnalisée pour les commandes."
L["Picks a Custom Colour for the Mod Names."] = "Choisit une couleur personnalisée pour les noms de modificateurs."
L["Picks a Custom Colour to be used for braces and indents."] = "Sélectionne une couleur personnalisée à utiliser pour les accolades et les tabulations."
L["Picks a Custom Colour to be used for Icons."] = "Choisit une couleur personnalisée à utiliser pour les icônes."
L["Picks a Custom Colour to be used for language descriptors"] = "Choisit une couleur personnalisée à utiliser pour les descripteurs de langue."
L["Picks a Custom Colour to be used for macro conditionals eg [mod:shift]"] = "Choisit une couleur personnalisée à utiliser pour les conditions, par exemple [mod:shift]."
L["Picks a Custom Colour to be used for Macro Keywords like /cast and /target"] = "Choisit une couleur personnalisée à utiliser pour les commandes comme /cast et /target . "
L["Picks a Custom Colour to be used for numbers."] = "Choisit une couleur personnalisée à utiliser pour les nombres."
L["Picks a Custom Colour to be used for Spells and Abilities."] = "Choisit une couleur personnalisée à utiliser pour les sorts et les compétences."
L["Picks a Custom Colour to be used for StepFunctions."] = "Choisit une couleur personnalisée à utiliser pour StepFunction (TypeDeBoucle)."
L["Picks a Custom Colour to be used for strings."] = "Choisit une couleur personnalisée à utiliser pour les chaînes."
L["Picks a Custom Colour to be used for unknown terms."] = "Choisit une couleur personnalisée à utiliser pour les termes inconnus."
L["Picks a Custom Colour to be used normally."] = "Choisit une couleur personnalisée à utiliser pour les lignes normales."
L["Plugins"] = "Plugins"
--[[Translation missing --]]
L["Print Active Modifiers on Click"] = "Print Active Modifiers on Click"
L["Print to the chat window if the alt, shift, control modifiers as well as the button pressed on each macro keypress."] = "Indique, dans la fenêtre de discussion, si le raccourci clavier associé à la macro a été activé et affiche si les touches Alt, Maj, Ctrl ont été utilisées."
L["Priority List (1 12 123 1234)"] = "Priorité (1 12 123 1234)"
--[[Translation missing --]]
L["Processing Collection of %s Elements."] = "Processing Collection of %s Elements."
L["PVP"] = "PVP"
L["PVP setting changed to Default."] = "Les paramètres pour le PVP ont été définis comme ceux par défaut."
L["Raid"] = "Raid"
L["Raid setting changed to Default."] = "Les paramètres des Raids ont été définis comme ceux par défaut."
L["Random - It will select .... a spell, any spell"] = "Aléatoire - Lance un sort au hasard"
L["Raw Edit"] = "Edition brute"
L["Ready to Send"] = "Prêt à envoyer"
L["Received Sequence "] = "Macro reçue"
L["Record"] = "Enregistrer"
L["Record Macro"] = "Enregistrer une macro"
L["Registered Addons"] = "Plugins activés"
L["Rename New Macro"] = "Renommer la nouvelle macro"
L["Repeat"] = "Répéter"
L["Replace"] = "Remplacer"
--[[Translation missing --]]
L["Report an Issue"] = "Report an Issue"
L["Request Macro"] = "Demander une macro"
L["Request that the user sends you a copy of this macro."] = "Demander à l'utilisateur de vous envoyer une copie de cette macro."
--[[Translation missing --]]
L["Reset Sequences when out of combat"] = "Reset Sequences when out of combat"
L["Reset this macro when you exit combat."] = "Réinitialiser la macro à la fin du combat."
L["Resets"] = "Réinitialiser"
--[[Translation missing --]]
L["Resets sequences back to the initial state when out of combat."] = "Resets sequences back to the initial state when out of combat."
L["Restricted"] = "Limité"
L["RESTRICTED: Macro specifics disabled by author."] = "LIMITÉ : les spécificités des macros ont été désactivées par l'auteur."
L["Resume"] = "Reprendre"
L["Returns your current Global Cooldown value accounting for your haste if that stat is present."] = "Renvoie la valeur de votre GCD en tenant compte de votre hâte si cette statistique est présente."
L["Reverse Priority (1 21 321 4321)"] = "Priorité inversée (1 21 321 4321)"
L["Right Alt Key"] = "Touche Alt droite"
L["Right Control Key"] = "Touche Ctrl droite"
L["Right Mouse Button"] = "Bouton droit de la souris"
L["Right Shift Key"] = "Touche Maj droite"
L["Running"] = "En cours d'exécution"
L["Save"] = "Sauvegarder"
--[[Translation missing --]]
L["Save pending for "] = "Save pending for "
L["Save the changes made to this macro"] = "Enregistrer les modifications apportées à cette macro."
--[[Translation missing --]]
L["Save the changes made to this variable."] = "Save the changes made to this variable."
--[[Translation missing --]]
L["Saved"] = "Saved"
L["Scenario"] = "Scénario"
L["Scenario setting changed to Default."] = "Les paramètres des Scénarios ont été définis comme ceux par défaut."
L["Seconds"] = "Secondes"
L["Select a Sequence"] = "Sélectionnez une macro"
--[[Translation missing --]]
L["Select Icon"] = "Select Icon"
L["Send"] = "Envoyer"
L["Send this macro to another GSE player who is on the same server as you are."] = "Envoyez cette macro à un autre utilisateur de GSE (à un autre joueur) qui se trouve sur le même serveur que vous."
L["Send To"] = "Envoyer à "
L["Sequence"] = "Séquence"
L["Sequence Compare"] = "Comparaison de macros"
L["Sequence Debugger"] = "Débogueur de macro"
L["Sequence Editor"] = "Editeur de Macro"
L["Sequence Name"] = "Nom de la macro"
L["Sequence Name %s is in Use. Please choose a different name."] = "La macro nommée %s est en cours d'utilisation. Veuillez choisir un autre nom."
L["Sequence Named %s was not specifically designed for this version of the game.  It may need adjustments."] = "La séquence nommée %s n'a pas été spécialement conçue pour cette version du jeu. Des ajustements peuvent être nécessaires."
--[[Translation missing --]]
L["Sequence Reset"] = "Sequence Reset"
L["Sequence to Compress."] = "Macro à compresser."
--[[Translation missing --]]
L["Sequences"] = "Sequences"
L["Sequential (1 2 3 4)"] = "Séquentiel (1 2 3 4)"
L["Set Default Icon QuestionMark"] = "Définir l'icône par défaut (point d'interrogation)"
--[[Translation missing --]]
L["Set Key to Bind"] = "Set Key to Bind"
L["Shift Keys."] = "Touches Maj"
--[[Translation missing --]]
L["Show All Sequences in Editor"] = "Show All Sequences in Editor"
--[[Translation missing --]]
L["Show Class Sequences in Editor"] = "Show Class Sequences in Editor"
L["Show Current Spells"] = "Montrer les sorts actuels"
--[[Translation missing --]]
L["Show Global Sequences in Editor"] = "Show Global Sequences in Editor"
L["Show GSE Users in LDB"] = "Afficher les utilisateurs de GSE dans le LDB"
--[[Translation missing --]]
L["Show next time you login."] = "Show next time you login."
L["Show OOC Queue in LDB"] = "Afficher la file d'attente OOC (Hors Combat) dans le LDB (LibDataBroker)"
L["Show the compiled version of this macro."] = "Affiche la version compilée de cette macro."
L["Source Language "] = "Langue source"
--[[Translation missing --]]
L["Specialisation"] = "Specialisation"
L["Specialisation / Class ID"] = "Spécialisation / Class ID"
L["SpecID/ClassID Colour"] = "Couleur des SpecID/ClassID"
--[[Translation missing --]]
L["Spell"] = "Spell"
--[[Translation missing --]]
L["Spell Cache Editor"] = "Spell Cache Editor"
L["Spell Colour"] = "Couleur des sorts"
--[[Translation missing --]]
L["Spell ID"] = "Spell ID"
--[[Translation missing --]]
L["Spell Name"] = "Spell Name"
--[[Translation missing --]]
L["State"] = "State"
L["Step Function"] = "Type de boucle"
L["Step Functions"] = "Types de boucle"
L["Stop"] = "Arrêter"
L["Store Debug Messages"] = "Stocker les messages de débogage"
L["Store output of debug messages in a Global Variable that can be referrenced by other mods."] = "Stocke la sortie des messages de débogage dans une variable globale qui peut être référencée par d'autres addons."
L["String Colour"] = "Couleur de la chaîne"
L["Support GSE"] = "Soutenir GSE"
L["Supporters"] = "Soutiens"
--[[Translation missing --]]
L["Talent Loadout"] = "Talent Loadout"
L["Talents"] = "Talents"
L["Target language "] = "Langue cible"
--[[Translation missing --]]
L["The author of this Macro."] = "The author of this Macro."
--[[Translation missing --]]
L["The author of this Variable."] = "The author of this Variable."
--[[Translation missing --]]
L[ [=[The block path shows the direct location of a block.  This can be edited to move a block to a different position quickly.  Each block is prefixed by its container.
EG 2.3 means that the block is the third block in a container at level 2.  You can move a block into a container block by specifying the parent block.  You need to press the Okay button to move the block.]=] ] = ""
L["The command "] = "La commande"
L["The default sizes of each window."] = "La taille par défaut de chaque fenêtre."
--[[Translation missing --]]
L["The delay in seconds between Out of Combat Queue Polls.  The Out of Combat Queue saves changes and updates sequences.  When you hit save or change zones, these actions enter a queue which checks that first you are not in combat before proceeding to complete their task.  After checking the queue it goes to sleep for x seconds before rechecking what is in the queue."] = "The delay in seconds between Out of Combat Queue Polls.  The Out of Combat Queue saves changes and updates sequences.  When you hit save or change zones, these actions enter a queue which checks that first you are not in combat before proceeding to complete their task.  After checking the queue it goes to sleep for x seconds before rechecking what is in the queue."
L["The following people donate monthly via Patreon for the ongoing maintenance and development of GSE.  Their support is greatly appreciated."] = "Les personnes suivantes participent au développement de GSE en faisant un don mensuel sur Patreon. Leur soutien est grandement apprécié."
L["The GSE Out of Combat queue is %s"] = "La file d'attente \"hors combat\" de GSE est %s"
L["The GUI has not been loaded.  Please activate this plugin amongst WoW's addons to use the GSE GUI."] = "L'interface graphique n'a pas été chargée. Veuillez activer ce plugin parmi les addons de WoW pour utiliser l'interface graphique GSE."
--[[Translation missing --]]
L["The GUI is corrupt.  Please ensure that your GSE install is complete."] = "The GUI is corrupt.  Please ensure that your GSE install is complete."
--[[Translation missing --]]
L["The GUI is missing.  Please ensure that your GSE install is complete."] = "The GUI is missing.  Please ensure that your GSE install is complete."
--[[Translation missing --]]
L["The GUI needs updating.  Please ensure that your GSE install is complete."] = "The GUI needs updating.  Please ensure that your GSE install is complete."
L["The milliseconds being used in key click delay."] = "Valeur en millisecondes utilisée pour la fréquence des clics."
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
L["The version of this macro that will be used when you enter raids."] = "La version de cette macro qui sera utilisée lorsque vous ferez des raids."
L["The version of this macro that will be used where no other version has been configured."] = "La version de cette macro qui sera utilisée si aucune autre version n'a été configurée."
L["The version of this macro to use in Arenas.  If this is not specified, GSE will look for a PVP version before the default."] = "La version de cette macro à utiliser dans les arènes. Si rien n'est spécifié, GSE recherchera une version PVP avant la version par défaut."
L["The version of this macro to use in heroic dungeons."] = "La version de cette macro à utiliser dans les donjons héroïques."
L["The version of this macro to use in Mythic Dungeons."] = "La version de cette macro à utiliser dans les donjons mythiques."
L["The version of this macro to use in Mythic+ Dungeons."] = "La version de cette macro à utiliser dans les donjons mythiques +."
L["The version of this macro to use in normal dungeons."] = "La version de cette macro à utiliser dans les donjons mode normal."
L["The version of this macro to use in PVP."] = "La version de cette macro à utiliser en PVP."
L["The version of this macro to use in Scenarios."] = "La version de cette macro à utiliser dans les scénarios."
L["The version of this macro to use when in a party in the world."] = "La version de cette macro à utiliser en groupe partout ailleurs."
L["The version of this macro to use when in time walking dungeons."] = "La version de cette macro à utiliser dans les donjons des Marcheurs du Temps."
L["There are %i events in out of combat queue"] = "Il y a %i événements dans la file d'attente \"hors combat\""
L["There are no events in out of combat queue"] = "Il n'y a pas d'événements dans la file d'attente \"hors combat\""
--[[Translation missing --]]
L["There is an error in the sequence that needs to be corrected before it can be saved."] = "There is an error in the sequence that needs to be corrected before it can be saved."
--[[Translation missing --]]
L["There was an error processing "] = "There was an error processing "
--[[Translation missing --]]
L["These options combine to allow you to reset a sequence while it is running.  These options are Cumulative ie they add to each other.  Options Like LeftClick and RightClick won't work together very well."] = "These options combine to allow you to reset a sequence while it is running.  These options are Cumulative ie they add to each other.  Options Like LeftClick and RightClick won't work together very well."
L["This change will not come into effect until you save this macro."] = "Cette modification n'entrera en vigueur que lorsque vous enregistrerez cette macro. "
--[[Translation missing --]]
L["This CVAR makes WoW use your abilities when you press the key not when you release it.  To use GSE in its native configuration this needs to be checked."] = "This CVAR makes WoW use your abilities when you press the key not when you release it.  To use GSE in its native configuration this needs to be checked."
--[[Translation missing --]]
L["This function will clear the spell cache and any mappings between individual spellIDs and spellnames.."] = "This function will clear the spell cache and any mappings between individual spellIDs and spellnames.."
--[[Translation missing --]]
L["This function will open a window enabling you to edit the spell cache and any mappings between individual spellIDs and spellnames.."] = "This function will open a window enabling you to edit the spell cache and any mappings between individual spellIDs and spellnames.."
L["This function will remove the SHIFT+N, ALT+N and CTRL+N keybindings for this character.  Useful if [mod:shift] etc conditions don't work in game."] = "Cette fonction supprime les raccourcis clavier MAJ+N, ALT+N et CTRL+N pour ce perso. Utile si les conditions [mod:shift] etc ne fonctionnent pas dans le jeu. "
L["This function will update macro stubs to support listening to the options below.  This is required to be completed 1 time per character."] = "Cette fonction met à jour les emplacements de macro pour prendre en charge les options ci-dessous. Ceci doit être complété 1 fois par personnage."
L["This is the only version of this macro.  Delete the entire macro to delete this version."] = "C'est la seule version de cette macro. Supprimez complètement la macro pour supprimer cette version. "
--[[Translation missing --]]
L["This macro is not compatible with this version of the game and cannot be imported."] = "This macro is not compatible with this version of the game and cannot be imported."
L["This macro uses features that are not available in this version. You need to update GSE to %s in order to use this macro."] = "Cette macro utilise des fonctionnalités qui ne sont pas disponibles dans cette version. Vous devez mettre à jour GSE vers %s afin d'utiliser cette macro."
L["This option dumps extra trace information to your chat window to help troubleshoot problems with the mod"] = "Cette option affiche des informations supplémentaires dans la fenêtre de discussion pour vous aider à résoudre les problèmes avec l'addon."
L["This sequence is Read Only and unable to be edited."] = "Cette macro est en lecture seule et ne peut pas être modifiée."
L["This Sequence was exported from GSE %s."] = "Cette macro a été exportée depuis GSE %s."
--[[Translation missing --]]
L["This setting forces the ActionButtonUseKeyDown setting one way or another.  It also reconfigures GSE's Macro Stubs to operate in the specified mode."] = "This setting forces the ActionButtonUseKeyDown setting one way or another.  It also reconfigures GSE's Macro Stubs to operate in the specified mode."
--[[Translation missing --]]
L["This shows the Global Sequences available as well as those for your class."] = "This shows the Global Sequences available as well as those for your class."
L["This version has been modified by TimothyLuke to make the power of GnomeSequencer avaialble to people who are not comfortable with lua programming."] = [=[GnomeSequencer a été modifié par TimothyLuke pour permettre à tous ceux qui ne sont pas à l'aise avec la programmation lua de créer des macros. 
]=]
--[[Translation missing --]]
L["This version of GSE is incompatabile with this version of the game."] = "This version of GSE is incompatabile with this version of the game."
L["This will display debug messages for the "] = "Ceci affichera des messages de débogage pour le "
L["This will display debug messages for the GSE Ingame Transmission and transfer"] = [=[Ceci affichera les messages de débogage pour la transmission et le transfert GSE
]=]
L["This will display debug messages in the Chat window."] = "Ceci affichera les messages de débogage dans la fenêtre de discussion."
L["Timewalking"] = "Marcheurs Du Temps"
L["Timewalking setting changed to Default."] = "Le paramètre Marcheurs Du Temps a été changé comme valeur par défaut."
L["Title Colour"] = "Couleur du titre"
L["To correct this either delete the version via the GSE Editor or enter the following command to delete this macro totally.  %s/run GSE.DeleteSequence (%i, %s)%s"] = "Pour corriger cela, supprimez la version via l'Editeur de Macro de GSE ou entrez la commande suivante pour supprimer totalement cette macro. %s/run GSE.DeleteSequence (%i, %s)%s"
L["To get started "] = "Pour commencer"
--[[Translation missing --]]
L["Toy"] = "Toy"
--[[Translation missing --]]
L["Troubleshooting"] = "Troubleshooting"
L["Two sequences with unknown sources found."] = "Deux macros avec des sources inconnues ont été trouvées."
L["Unable to interpret sequence."] = "Impossible de déchiffrer la macro."
L["Unable to process content.  Fix table and try again."] = "Impossible de traiter le contenu. Corrigez le tableau et réessayez."
--[[Translation missing --]]
L["Unit Name"] = "Unit Name"
L["Unknown Colour"] = "Couleur inconnue"
--[[Translation missing --]]
L["Unrecognised Import"] = "Unrecognised Import"
L["Update"] = "Mettre à jour"
--[[Translation missing --]]
L["Update Talents"] = "Update Talents"
--[[Translation missing --]]
L["Update the stored talents to match the current chosen talents."] = "Update the stored talents to match the current chosen talents."
L["Updated Macro"] = "Macro mise à jour"
L["Use Global Account Macros"] = "Utiliser les macros globales du compte"
L["Use WLM Export Sequence Format"] = "Exporter la macro au format WLM"
--[[Translation missing --]]
L["Variable"] = "Variable"
--[[Translation missing --]]
L["Variable Menu"] = "Variable Menu"
L["Variables"] = "Variables"
L["Version"] = "Version"
L["WARNING ONLY"] = "AVERTISSEMENT"
--[[Translation missing --]]
L["was unable to be interpreted."] = "was unable to be interpreted."
L["was unable to be programmed.  This macro will not fire until errors in the macro are corrected."] = "n'a pas pu être programmé. Cette macro ne se déclenchera pas tant que les erreurs de la macro ne seront pas corrigées."
L["WeakAuras was not found."] = "WeakAuras n'a pas été trouvé."
L["Website or forum URL where a player can get more information or ask questions about this macro."] = "Site web ou forum où un joueur pourra obtenir plus d'informations sur cette macro ou poser des questions sur son fonctionnement."
--[[Translation missing --]]
L["What are the preferred talents for this macro?"] = "What are the preferred talents for this macro?"
L["What class or spec is this macro for?  If it is for all classes choose Global."] = "A quelle classe ou spécification cette macro est-elle destinée ? Si c'est pour toutes les classes, choisissez Global."
--[[Translation missing --]]
L["WhatsNew"] = [=[|cFFFFFFFFGS|r|cFF00FFFFE|r 3.2.18 updates the Actionbar Overrides for Bartender4 and ConsolePort.  This solves the issue of being in flight and not being able to use the GSE Sequence until you left combat.  ElvUI support for this will come in a later update.

|cffff6666Note|r: The paging function has to be turned off for druids and potentially rogues.  The issue is when Bartender4 pages, the bar is replaces with the contents of another hidden bar.  Even if I bind a button to that bar the "click" state is not transferred to the new bar.

The full detail on all of these changes is available on the GSE GitHub wiki - https://github.com/TimothyLuke/GSE-Advanced-Macro-Compiler/wiki
]=]
L["When creating a macro, if there is not a personal character macro space, create an account wide macro."] = "Lors de la création d'une macro, s'il n'y a plus d'espace disponible dans les macros du personnage, mettre la macro dans les macros globales du compte."
--[[Translation missing --]]
L["When exporting from GSE create a descriptive export for Discord/Discource forums."] = "When exporting from GSE create a descriptive export for Discord/Discource forums."
--[[Translation missing --]]
L["When GSE imports a sequence and it already exists locally and has local edits, what do you want the default action to be.  Merge - Add the new MacroVersions to the existing Sequence.  Replace - Replace the existing sequence with the new version. Ignore - ignore updates.  This default action will set the default on the Compare screen however if the GUI is not available this will be the action taken."] = "When GSE imports a sequence and it already exists locally and has local edits, what do you want the default action to be.  Merge - Add the new MacroVersions to the existing Sequence.  Replace - Replace the existing sequence with the new version. Ignore - ignore updates.  This default action will set the default on the Compare screen however if the GUI is not available this will be the action taken."
L["When loading or creating a sequence, if it is a global or the macro has an unknown specID automatically create the Macro Stub in Account Macros"] = "Lors du chargement ou lors de la création d'une macro, s'il s'agit d'une macro globale ou si la macro a un specID inconnu, créer automatiquement l'emplacement de macro dans les macros du compte."
L["When loading or creating a sequence, if it is a macro of the same class automatically create the Macro Stub"] = "Lors du chargement ou de la création d'une macro, s'il s'agit d'une macro de la même classe, créer automatiquement l'emplacement de macro."
L["Window Sizes"] = "Taille des fenêtres"
L["Yes"] = "Oui"
L["You cannot delete the Default version of this macro.  Please choose another version to be the Default on the Configuration tab."] = "Vous ne pouvez pas supprimer la version par Défaut de cette macro. SVP, choisissez une autre version pour être celle par Défaut dans l'onglet de Configuration."
--[[Translation missing --]]
L["You cannot open a new Sequence Editor window while you are in combat.  Please exit combat and then try again."] = "You cannot open a new Sequence Editor window while you are in combat.  Please exit combat and then try again."
L["You need to reload the User Interface to complete this task.  Would you like to do this now?"] = "Vous devez relancer l'interface du jeu pour finir cette tâche. Voulez-vous le faire maintenant ?"
L["Your ClassID is "] = "Votre ClassID est"
L["Your current Specialisation is "] = "Votre spécialisation actuelle est"


