--[[
    This file is part of Decursive.

    Decursive (v 2.7.8.12) add-on for World of Warcraft UI
    Copyright (C) 2006-2019 John Wellesz (Decursive AT 2072productions.com) ( http://www.2072productions.com/to/decursive.php )

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Decursive.  If not, see <https://www.gnu.org/licenses/>.


    Decursive is inspired from the original "Decursive v1.9.4" by Patrick Bohnet (Quu).
    The original "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY.

    This file was last updated on 2019-11-18T13:42:00Z
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- French localization
-------------------------------------------------------------------------------

--[=[
--                      YOUR ATTENTION PLEASE
--
--         !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--      ################################################################
--      #  http://wow.curseforge.com/projects/decursive/localization/  #
--      ################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

local addonName, T = ...;
-- big ugly scary fatal error message display function {{{
if not T._FatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    preferredIndex = 3,
    }; -- }}}
T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["enUS.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end
T._LoadedFiles["frFR.lua"] = false;

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "frFR");

if not L then
    T._LoadedFiles["frFR.lua"] = "2.7.8.12";
    return;
end

L["ABOLISH_CHECK"] = "Voir si \"Abolir\" sur la cible avant de gu??rir"
L["ABOUT_AUTHOREMAIL"] = "CONTACTER L'AUTEUR"
L["ABOUT_CREDITS"] = "REMERCIEMENTS"
L["ABOUT_LICENSE"] = "LICENCE"
L["ABOUT_NOTES"] = "Affichage et gu??rison des affections avec un syst??me ??volu?? de filtrage et de priorit??."
L["ABOUT_OFFICIALWEBSITE"] = "SITE OFFICIEL"
L["ABOUT_SHAREDLIBS"] = "LIBRAIRIES PARTAG??ES"
L["ABSENT"] = "Absente (%s)"
L["AFFLICTEDBY"] = "Affect?? par %s"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "Nombre d'affect??s ?? afficher : "
L["ANCHOR"] = "Ancre du texte"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Afficher ou masquer les micro-portraits"
L["BINDING_NAME_DCRPRADD"] = "Ajouter la cible ?? la liste de priorit??s"
L["BINDING_NAME_DCRPRCLEAR"] = "Effacer la liste de priorit??s"
L["BINDING_NAME_DCRPRLIST"] = "Afficher la liste de priorit??s"
L["BINDING_NAME_DCRPRSHOW"] = "Afficher ou Cacher la liste de priorit??s"
L["BINDING_NAME_DCRSHOW"] = [=[Afficher ou Cacher la barre Decursive
(Ancre de la liste des affect??s)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "Affiche le panneau des options"
L["BINDING_NAME_DCRSKADD"] = "Ajouter la cible ?? la liste des exceptions"
L["BINDING_NAME_DCRSKCLEAR"] = "Effacer la liste des exceptions"
L["BINDING_NAME_DCRSKLIST"] = "Afficher la liste des exceptions"
L["BINDING_NAME_DCRSKSHOW"] = "Afficher ou Cacher la liste des exceptions"
L["BLACK_LENGTH"] = "D??lais (Secs) sur la *blacklist* : "
L["BLACKLISTED"] = "Sur liste noire"
L["CHARM"] = "Possession"
L["CLASS_HUNTER"] = "Chasseur"
L["CLEAR_PRIO"] = "E"
L["CLEAR_SKIP"] = "E"
L["COLORALERT"] = "R??gle la couleur d'alerte quand un '%s' est requis."
L["COLORCHRONOS"] = "Compteur central"
L["COLORCHRONOS_DESC"] = "R??gle la couleur du compteur au centre de chaque micro-portrait"
L["COLORSTATUS"] = "R??gle la couleur du statut '%s'."
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "Contr??ler et gu??rir les familiers"
L["CURSE"] = "Mal??diction"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33Merci d'envoyer par email le contenu de cette fen??tre ?? <%s>|r
|cFF009999(Faire CTRL+A pour tout s??lectionner et CTRL+C pour le copier dans votre "presse papier")|r
D??tes ??galement dans votre rapport si vous avez remarqu?? un comportement ??trange de %s.
]=]
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Rapport de debuggage de Decursive|r ****"
L["DECURSIVE_DEBUG_REPORT_BUT_NEW_VERSION"] = [=[|cFF11FF33Decursive s'est plant?? ! Mais n'ayez crainte ! Une NOUVELLE version de Decursive a ??t?? d??tect??e (%s). Il suffit simplement de vous mettre ?? jour. Aller sur Curse.com et chercher 'Decursive' ou utilisez le client de Curse.com, Il mettra ?? jour tous vos add-ons pr??f??r??s automatiquement.|r
|cFFFF1133Ne perdez donc pas votre temps en rapportant ce probl??me, ce bug ?? probablement d??j?? ??t?? corrig??. Mettez simplement Decursive ?? jour pour vous d??barrasser de ce probl??me. !|r
|cFF11FF33Merci d'avoir lu ce message !|r]=]
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[Un rapport de debuggage est disponible !
Taper |cFFFF0000/DCRREPORT|r pour le voir.]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "Rapport de debuggage disponible !"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "Affiche un rapport de debuggage que l'auteur doit voir..."
L["DEFAULT_MACROKEY"] = "NONE"
L["DEV_VERSION_ALERT"] = [=[Vous  utilisez une version de d??veloppement de Decursive.

Si vous ne voulez pas participer au test des nouvelles fonctionnalit??s/corrections, recevoir des rapports de d??buggage pendant le jeu, rapporter les probl??mes ?? l'auteur alors N'UTILISEZ PAS CETTE VERSION et t??l??charger la derni??re version STABLE sur curse.com ou wowace.com.

Ce message ne sera affich?? qu'une seule fois par version.

]=]
L["DEV_VERSION_EXPIRED"] = [=[Cette version de d??veloppement de Decursive a expir??.
Vous devriez t??l??charger la derni??re version de d??veloppement ou retourner ?? la version stable courante disponible sur CURSE.COM ou WOWACE.COM]=]
L["DEWDROPISGONE"] = "Il n'y a pas d'??quivalent ?? DewDrop pour Ace3. Faire Alt-clique-droit pour ouvrir le panneau des options."
L["DISABLEWARNING"] = [=[Decursive a ??t?? d??sactiv?? !
Pour le r??activer, tapper |cFFFFAA44/DCR ENABLE|r]=]
L["DISEASE"] = "Maladie"
L["DONOT_BL_PRIO"] = "Ne pas *blacklister* les gens prioritaires"
L["DONT_SHOOT_THE_MESSENGER"] = "Decursive ne fait que rapporter le probl??me. Alors, ne tirez pas sur le messager et adressez le vrai probl??me."
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r sur %s |cFFAA0000??chou?? !|r
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "Focalise l'unit??"
L["FUBARMENU"] = "Menu de Fubar"
L["FUBARMENU_DESC"] = "R??gles les options relatives ?? l'ic??ne de FuBar"
L["GLOR1"] = "?? la m??moire de Glorfindal"
L["GLOR2"] = "Decursive est d??di?? ?? la m??moire de Bertrand qui nous a quitt?? bien trop t??t. On se souviendra toujours de lui."
L["GLOR3"] = [=[En souvenir de Bertrand Sense
1969 - 2007]=]
L["GLOR4"] = [=[L'amiti?? et l'affection peuvent prendre naissance n'importe o??, ceux qui ont rencontr?? Glorfindal dans World Of Warcraft ont connu un homme engag?? et un leader charismatique.

Il ??tait dans la vie comme dans le jeux, d??sint??ress??, g??n??reux, d??vou?? envers les siens et surtout un homme passionn??.

Il nous a quitt?? ?? l'??ge de 38 ans laissant derri??re lui pas seulement des joueurs anonymes dans un monde virtuel, mais un groupe de v??ritables amis ?? qui il manquera ??ternellement.]=]
L["GLOR5"] = "On ne l'oubliera jamais..."
L["HANDLEHELP"] = "D??placer tous les micro-portraits"
L["HIDE_MAIN"] = "Cacher la fen??tre \"Decursive\""
L["HIDESHOW_BUTTONS"] = "Cacher/Afficher les boutons et Verrouiller/D??verrouiller la barre \"Decursive\""
L["HLP_LEFTCLICK"] = "Clic Gauche"
L["HLP_LL_ONCLICK_TEXT"] = [=[Cette liste n'est pas cliquable. Merci de lire la documentation pour apprendre ?? utiliser cet add-on. Cherchez 'Decursive' sur WoWAce.com
(Pour bouger cette liste, bougez la barre de Decursive, /dcrshow et alt-clic-gauche pour d??placer)]=]
L["HLP_MIDDLECLICK"] = "Clic Milieu"
L["HLP_MOUSE4"] = "Souris 4"
L["HLP_MOUSE5"] = "Souris 5"
L["HLP_NOTHINGTOCURE"] = "Il n'y a rien ?? gu??rir !"
L["HLP_RIGHTCLICK"] = "Clic Droit"
L["HLP_USEXBUTTONTOCURE"] = "Utilisez \"%s\" pour gu??rir cette affection !"
L["HLP_WRONGMBUTTON"] = "Mauvais clique !"
L["IGNORE_STEALTH"] = "Ignorer les unit??s camoufl??es"
L["IS_HERE_MSG"] = "Decursive est initialis??, n'oubliez pas de contr??ler les options disponibles (/decursive)"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[CTRL]|r Click : Efface ce joueur
Click |cFF33AA33GAUCHE|r : Monte ce joueur
Click |cFF33AA33DROIT|r: Descend ce joueur
|cFF33AA33[MAJ]|r Click |cFF33AA33GAUCHE|r : Met ce joueur en haut
|cFF33AA33[MAJ]|r Click |cFF33AA33DROIT|r : Met ce joueur en bas]=]
L["MACROKEYALREADYMAPPED"] = [=[ATTENTION: La touche affect??e ?? la macro de Decursive [%s] ??tait affect??e ?? l'action '%s'.
Decursive restaurera l'action originale si vous affectez une autre touche ?? la macro.]=]
L["MACROKEYMAPPINGFAILED"] = "La touche [%s] n'a pas pu ??tre affect??e ?? la macro de Decursive"
L["MACROKEYMAPPINGSUCCESS"] = "La touche [%s] a ??t?? correctement affect??e ?? la macro de Decursive."
L["MACROKEYNOTMAPPED"] = "Aucune touche n'est affect??e ?? la macro de Decursive, reportez-vous aux options concernant la macro !"
L["MAGIC"] = "Magie"
L["MAGICCHARMED"] = "Contr??le magique"
L["MISSINGUNIT"] = "Unit?? absente"
L["NEW_VERSION_ALERT"] = [=[Une nouvelle version de Decursive a ??t?? d??tect??e: |cFFEE7722%q|r sortie le |cFFEE7722%s|r!


Allez sur |cFFFF0000WoWAce.com|r pour l'obtenir !
--------]=]
L["NORMAL"] = "Normal"
L["NOSPELL"] = "Aucun sort disponible"
L["NOTICE_FRAME_TEMPLATE"] = [=[|cFFFF0000Decursive - Information|r

%s]=]
L["OPT_ABOLISHCHECK_DESC"] = "D??finit si les unit??s avec un sort 'Abolir' actif sont affich??es et soign??es"
L["OPT_ABOUT"] = "?? propos"
L["OPT_ADD_A_CUSTOM_SPELL"] = "Ajouter un sort / objet personnalis??"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "Glissez-d??posez un sort ou un objet utilisable ici. Vous pouvez aussi directement taper son nom, son identifiant num??rique ou utiliser MAJ+Clique."
L["OPT_ADDDEBUFF"] = "Ajouter une affection"
L["OPT_ADDDEBUFF_DESC"] = "Ajoute une nouvelle affection ?? cette liste"
L["OPT_ADDDEBUFF_USAGE"] = "<Spell ID de l'affection> (Vous pouvez trouver cet ID dans les URLs du site WoWHead.com)"
L["OPT_ADDDEBUFFFHIST"] = "Ajouter une affection r??cemment gu??rie"
L["OPT_ADDDEBUFFFHIST_DESC"] = "Ajouter une affection depuis l'historique des affections que vous avez r??cemment gu??rie."
L["OPT_ADVDISP"] = "Options avanc??es"
L["OPT_ADVDISP_DESC"] = "Permet de r??gler la transparence de la bordure et du centre s??par??ment, permet de r??gler l'espace entre les micro-portraits"
L["OPT_AFFLICTEDBYSKIPPED"] = "%s affect??(e) par %s sera ignor??"
L["OPT_ALLOWMACROEDIT"] = "Autoriser l'??dition de la macro"
L["OPT_ALLOWMACROEDIT_DESC"] = "Activer cette option emp??che Decursive de mettre ?? jour sa macro, vous permettant de la modifier."
L["OPT_ALWAYSIGNORE"] = "Ignorer aussi hors combat"
L["OPT_ALWAYSIGNORE_DESC"] = "Si coch??e, cette affection sera aussi ignor??e en dehors des combats"
L["OPT_AMOUNT_AFFLIC_DESC"] = "D??finit le nombre max d'affect??s affich??s dans la liste des affect??s."
L["OPT_ANCHOR_DESC"] = "Montre l'ancre de la fen??tre de discussion sp??ciale"
L["OPT_AUTOHIDEMFS"] = "Masquer les MUFs quand :"
L["OPT_AUTOHIDEMFS_DESC"] = "Choisissez quand la fen??tre des micro-portraits doit ??tre masqu??e automatiquement."
L["OPT_BLACKLENTGH_DESC"] = "D??finit combien de temps quelqu'un reste sur liste noire"
L["OPT_BORDERTRANSP"] = "Transparence de la bordure"
L["OPT_BORDERTRANSP_DESC"] = "R??gle la transparence de la bordure"
L["OPT_CENTERTEXT"] = "Compteur central :"
L["OPT_CENTERTEXT_DESC"] = [=[Affiche des informations concernant l'affliction la plus importante (selon vos priorit??s) au centre de chaque micro-portrait.

Soit:
- Le temps restant avant l'expiration naturelle
- Le temps ??coul?? depuis l'infection
- Le nombre d'applications]=]
L["OPT_CENTERTEXT_DISABLED"] = "D??sactiv??"
L["OPT_CENTERTEXT_ELAPSED"] = "Temps ??coul??"
L["OPT_CENTERTEXT_STACKS"] = "Nombre d'applications"
L["OPT_CENTERTEXT_TIMELEFT"] = "Temps restant"
L["OPT_CENTERTRANSP"] = "Transparence du centre"
L["OPT_CENTERTRANSP_DESC"] = "R??gle la transparence du centre"
L["OPT_CHARMEDCHECK_DESC"] = "Si coch??e, vous pourrez voir et gu??rir les unit??s poss??d??es"
L["OPT_CHATFRAME_DESC"] = "Les messages de Decursive seront affich??s dans la fen??tre de discussion par d??faut"
L["OPT_CHECKOTHERPLAYERS"] = "V??rifier les autres joueurs"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "Affiche la version de Decursive utilis??e par les joueurs de votre groupe ou de votre guilde (Ne fonctionne qu'?? partir de la version 2.4.6 de Decursive)."
L["OPT_CMD_DISBLED"] = "D??sactiv??"
L["OPT_CMD_ENABLED"] = "Activ??"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "Cr??er une affection virtuelle de test"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "Permet de voir ce qu'il se passe lorsqu'une affection est d??tect??e"
L["OPT_CURE_PRIORITY_NUM"] = "Priorit?? #%d"
L["OPT_CUREPETS_DESC"] = "Les familiers seront affich??s et gu??ris"
L["OPT_CURINGOPTIONS"] = "Options de gu??rison"
L["OPT_CURINGOPTIONS_DESC"] = "D??finit les diff??rents aspects du processus de gu??rison (Types d'affections, et priorit??s)"
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[S??lectionnez les types d'affection que vous souhaitez gu??rir. Les types non s??lectionn??s seront compl??tement ignor??s par Decursive.

Les chiffres en vert indiquent la priorit?? du type d'affections. Cette priorit?? affecte plusieurs aspects de Decursive :

- Quelle affection Decursive vous montre en premier lorsqu'un joueur souffre de plusieurs types affections.

- Quelle sera la couleur du micro-portrait et donc sur quel bouton de la souris vous devrez cliquer pour gu??rir ce type d'affections (clique gauche pour le premier sort, clique droit pour le second, etc...).

(Pour changer l'ordre, d??-s??lectionnez tous les types et cochez-les dans l'ordre souhait??)]=]
L["OPT_CURINGORDEROPTIONS"] = "Types d'affections et priorit??s"
L["OPT_CURSECHECK_DESC"] = "Si coch??e, vous pourrez voir et gu??rir les unit??s maudites"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING"] = "Autoriser la modification de la macro interne pour le sort ci-dessus"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING_DESC"] = [=[Cochez cela si vous voulez modifier la macro interne que Decursive utilisera pour le sort personnalis?? que vous ??tes en train d'ajouter.

Note: En cochant cela vous pourrez modifier les sorts g??r??s par Decursive.

Si un sort est d??j?? list??, il faudra d'abord le retirer pour activer cette option.

(---Seulement pour les utilisateurs avanc??s---)]=]
L["OPT_CUSTOM_SPELL_CURE_TYPES"] = "Types d'afflictions"
L["OPT_CUSTOM_SPELL_IS_DEFAULT"] = "Ce sort fait partie de la configuration automatique de Decursive. Si le sort ne fonctionne plus correctement, vous pouvez l'effacer pour retrouver le comportement par d??faut de Decursive."
L["OPT_CUSTOM_SPELL_ISPET"] = "Capacit?? de familier"
L["OPT_CUSTOM_SPELL_ISPET_DESC"] = "Cocher cette option si c'est une capacit?? appartenant ?? l'un de vos familiers afin que Decursive puisse la d??tecter et l'utiliser correctement."
L["OPT_CUSTOM_SPELL_MACRO_MISSING_NOMINAL_SPELL"] = "Attention: le sort %q n???appara??t pas dans votre macro, les informations de cooldown et de port??e ne correspondront pas... "
L["OPT_CUSTOM_SPELL_MACRO_MISSING_UNITID_KEYWORD"] = "Le mot-cl?? UNITID est manquant."
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "Texte de la macro :"
L["OPT_CUSTOM_SPELL_MACRO_TEXT_DESC"] = [=[Modifiez le texte original de la macro.
|cFFFF0000Seulement 2 restrictions:|r

- Vous devez sp??cifier la cible en utilisant le mot-cl?? UNITID qui sera automatiquement remplac?? par l'identifiant d'unit?? de chaque micro-portrait.

- Quel que soit le sort utilis?? dans la macro, Decursive utilisera le nom originel indiqu?? ?? gauche pour r??cup??rer et afficher les informations de port??e et de cooldown.
(Gardez cela ?? l'esprit si vous comptez utiliser diff??rents sorts avec des conditions)]=]
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "Votre macro est trop longue, vous devez enlever %d caract??res."
L["OPT_CUSTOM_SPELL_PRIORITY"] = "Priorit?? du sort"
L["OPT_CUSTOM_SPELL_PRIORITY_DESC"] = [=[Quand plusieurs sorts peuvent gu??rir les m??mes types d'afflictions, ceux ayant la priorit?? la plus ??lev??e seront pr??f??r??s.

Notez que les sorts par d??faut g??r??s par Decursive ont une priorit?? allant de 0 ?? 9.

Ainsi, si vous donnez une priorit?? n??gative ?? l'un de vos sort, il ne sera choisi que si le sort par d??faut n'est pas disponible.]=]
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "indisponible"
L["OPT_CUSTOM_SPELL_UNIT_FILTER"] = "Filtrage"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_DESC"] = "S??lectionnez les unit??s qui peuvent b??n??ficier de cette technique"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONE"] = "Toutes les unit??s"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONPLAYER"] = "Les autres seulement"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_PLAYER"] = "Seulement sois-m??me"
L["OPT_CUSTOMSPELLS"] = "Sorts / objets personnalis??s"
L["OPT_CUSTOMSPELLS_DESC"] = [=[Ici vous pouvez ajouter des sorts pour ??tendre la configuration automatique de Decursive.
Vos sorts personnalis??s auront toujours une priorit?? plus ??lev??e et remplaceront syst??matiquement les sorts par d??faut (si et seulement si votre personnage peut utiliser ces sorts)]=]
L["OPT_CUSTOMSPELLS_EFFECTIVE_ASSIGNMENTS"] = "Assignations effectives des sorts :"
L["OPT_DEBCHECKEDBYDEF"] = [=[

Coch??e par d??faut]=]
L["OPT_DEBUFFENTRY_DESC"] = "S??lectionnez quelle classe doit ??tre ignor??e pour cette affection"
L["OPT_DEBUFFFILTER"] = "Filtrage des affections"
L["OPT_DEBUFFFILTER_DESC"] = "S??lectionner les affections ?? filtrer par nom et par classe pendant les combat"
L["OPT_DELETE_A_CUSTOM_SPELL"] = "Supprimer"
L["OPT_DISABLEABOLISH"] = "Ne pas utiliser les sorts 'Abolir'"
L["OPT_DISABLEABOLISH_DESC"] = "Si activ??e, Decursive pr??f??rera 'Gu??rison des maladies' et 'Gu??rison du poison' ?? la place de leur ??quivalent en 'Abolir'"
L["OPT_DISABLEMACROCREATION"] = "Ne pas cr??er de macro"
L["OPT_DISABLEMACROCREATION_DESC"] = "La macro de Decursive ne sera plus cr????e ni mis ?? jour."
L["OPT_DISEASECHECK_DESC"] = "Si coch??e, vous pourrez voir et gu??rir les unit??s malade"
L["OPT_DISPLAYOPTIONS"] = "Options d'affichage"
L["OPT_DONOTBLPRIO_DESC"] = "Les unit??s prioritaires ne seront pas blacklist??es"
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "Activer"
L["OPT_ENABLE_LIVELIST"] = "Activer la liste des afflig??s"
L["OPT_ENABLE_LIVELIST_DESC"] = [=[Affiche une liste des gens afflig??s.

vous pouvez d??placer cette liste en d??pla??ant la barre de Decursive (tapper /DCRSHOW pour afficher cette barre)]=]
L["OPT_ENABLEDEBUG"] = "Debug"
L["OPT_ENABLEDEBUG_DESC"] = "Activer les informations de debuggage"
L["OPT_ENABLEDECURSIVE"] = "Activer Decursive"
L["OPT_FILTERED_DEBUFF_RENAMED"] = "L'affection filtr??e \"%s\" a automatiquement ??t?? renomm?? par \"%s\" pour le Spell ID %d"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "%q sera ignor?? sur les classes sp??cifi??es pendant que vous ??tes en combat."
L["OPT_GENERAL"] = "Options g??n??rales"
L["OPT_GROWDIRECTION"] = "Inverser l'affichage des micro-portraits"
L["OPT_GROWDIRECTION_DESC"] = "Les micro-portraits seront affich??s de bas en haut"
L["OPT_HIDEMFS_GROUP"] = "en solo ou en groupe"
L["OPT_HIDEMFS_GROUP_DESC"] = "Masque la fen??tre lorsque vous n'??tes pas dans un groupe de raid."
L["OPT_HIDEMFS_NEVER"] = "Ne jamais masquer"
L["OPT_HIDEMFS_NEVER_DESC"] = "Ne jamais masquer la fen??tre automatiquement."
L["OPT_HIDEMFS_SOLO"] = "en solo"
L["OPT_HIDEMFS_SOLO_DESC"] = "Masque la fen??tre lorsque vous jouez en solo."
L["OPT_HIDEMUFSHANDLE"] = "Chacher la poign??e des Micro-Portraits"
L["OPT_HIDEMUFSHANDLE_DESC"] = [=[Cache la poign??e des Micro-Portraits et d??sactive la possibilit?? de les bouger.
Utilisez la m??me commande pour la retrouver.]=]
L["OPT_IGNORESTEALTHED_DESC"] = "Les unit??s camoufl??es seront ignor??es"
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "Le sort est d??j?? dans la liste !"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive g??re d??j?? ce sort. MAJ-cliquez sur le sort ou tapez son ID pour ajouter un rang sp??cial."
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "ID de sort invalide !"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "Ce sort ne se trouve pas dans votre grimoire !"
L["OPT_ISNOTVALID_SPELLID"] = "n'est pas un Spell ID valide"
L["OPT_LIVELIST"] = "Liste des afflig??s"
L["OPT_LIVELIST_DESC"] = [=[Ce sont les options concernant la liste des afflig??s affich??e en dessous de la barre "Decursive".

Pour d??placer cette liste il faut bouger cette barre. Certains des r??glages ci-dessous ne sont accessibles que lorsque cette barre est affich??e. Vous pouvez l'afficher en tapant |cff20CC20/DCRSHOW|r dans votre fen??tre de discussion.

Une fois que vous avez r??gl?? la position, l'??chelle et la transparence vous pouvez cacher cette barre sans probl??me en tapant  |cff20CC20/DCRHIDE|r.]=]
L["OPT_LLALPHA"] = "Transparence"
L["OPT_LLALPHA_DESC"] = [=[D??finit la transparence de la barre principale de Decursive et de la liste des afflig??s
(la barre principale doit ??tre affich??e)]=]
L["OPT_LLSCALE"] = "??chelle de la liste des affect??s"
L["OPT_LLSCALE_DESC"] = [=[D??finit la taille de la barre principale de Decursive et de la liste des affect??s
(la barre principale doit ??tre affich??e)]=]
L["OPT_LVONLYINRANGE"] = "Unit??s ?? port??e seulement"
L["OPT_LVONLYINRANGE_DESC"] = "Si cette option est activ??e, uniquement les unit??s ?? port??e de sorts seront affich??es dans la liste"
L["OPT_MACROBIND"] = "D??finit la touche li??e ?? la macro"
L["OPT_MACROBIND_DESC"] = [=[D??finit la touche ?? partir de laquelle la macro 'Decursive' sera appel??e.

Appuyer sur la touche puis sur 'Entr??e' pour sauvegarder la nouvelle affectation.]=]
L["OPT_MACROOPTIONS"] = "Options de la macro"
L["OPT_MACROOPTIONS_DESC"] = "D??finit le comportement de la macro 'mouseover' cr????e par Decursive"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "Si coch??e, vous pourrez voir et gu??rir les unit??s contr??l??es par magie"
L["OPT_MAGICCHECK_DESC"] = "Si coch??e, vous pourrez voir et gu??rir les unit??s affect??es par la magie"
L["OPT_MAXMFS"] = "Nombre maximum d'unit??s affich??es"
L["OPT_MAXMFS_DESC"] = "D??finit le nombre maximum de micro-portraits ?? afficher"
L["OPT_MESSAGES"] = "Messages"
L["OPT_MESSAGES_DESC"] = "Options sur les messages affich??s"
L["OPT_MFALPHA"] = "Transparence"
L["OPT_MFALPHA_DESC"] = "D??finit la transparence des micro-portraits, lorsque l'unit?? n'est pas affect??e."
L["OPT_MFPERFOPT"] = "Options de performance"
L["OPT_MFREFRESHRATE"] = "Taux de rafra??chissement"
L["OPT_MFREFRESHRATE_DESC"] = "P??riode de rafra??chissement (1 ou plusieurs micro-portraits peuvent ??tre rafra??chis en m??me temps)"
L["OPT_MFREFRESHSPEED"] = "Rapidit?? de rafra??chissement"
L["OPT_MFREFRESHSPEED_DESC"] = "Nombre de micro-portraits ?? rafra??chir ?? chaque passage"
L["OPT_MFSCALE"] = "??chelle des micro-portraits"
L["OPT_MFSCALE_DESC"] = "D??finit la taille des micro-portraits"
L["OPT_MFSETTINGS"] = "Options des micro-portraits"
L["OPT_MFSETTINGS_DESC"] = "R??gle divers options d'affichage des micro-portraits et des priorit??s de gu??rison"
L["OPT_MUFFOCUSBUTTON"] = "Bouton de focalisation"
L["OPT_MUFHANDLE_HINT"] = "Pour d??placer les micro-portraits : ALT-cliquez sur la poign??e invisible situ??e au dessus du premier micro-portrait."
L["OPT_MUFMOUSEBUTTONS"] = "Boutons de la souris"
L["OPT_MUFMOUSEBUTTONS_DESC"] = [=[Ici vous pouvez changer le bouton de la souris correspondant ?? chacune des actions possibles sur les micro-portraits (gu??rison, ciblage et focalisation).

?? chacune des diff??rentes priorit??s correspond un certain type d'affection, comme indiqu?? dans le panneau "|cFFFF5533Options de gu??rison|r".

Les sorts utilis??s pour chaque type d'affection sont r??gl??s automatiquement, vous pouvez changer ces sorts dans le panneau '|cFF00DDDDSorts personnalis??s|r'.]=]
L["OPT_MUFSCOLORS"] = "Couleurs"
L["OPT_MUFSCOLORS_DESC"] = [=[Options pour changer la couleur de chaque priorit?? de gu??rison et des diff??rents statuts des micro-portraits.

?? chacune des diff??rentes priorit??s correspond un certain type d'affection, comme indiqu?? dans le panneau "|cFFFF5533Options de gu??rison|r".]=]
L["OPT_MUFSVERTICALDISPLAY"] = "Affichage vertical"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "La fen??tre des micro-portraits s'agrandira verticalement"
L["OPT_MUFTARGETBUTTON"] = "Bouton de ciblage"
L["OPT_NEWVERSIONBUGMENOT"] = "Alertes de mise ?? jour"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "Si une nouvelle version de Decursive est d??tect??e, une alerte sera affich??e une fois tous les sept jours."
L["OPT_NOKEYWARN"] = "Avertir si aucune touche"
L["OPT_NOKEYWARN_DESC"] = "Affiche un avertissement si aucune touche n'est affect??e ?? la macro."
L["OPT_NOSTARTMESSAGES"] = "D??sactiver les messages de bienvenue"
L["OPT_NOSTARTMESSAGES_DESC"] = "Enl??ve les deux messages que Decursive ??crit dans le chat ?? chaque connexion."
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "Ces options sont d??sactiv??es lorsque vous combattez."
L["OPT_PERFOPTIONWARNING"] = "ATTENTION : Ne changez pas ces r??glages sauf si vous savez parfaitement ce que vous faites. Ces r??glages peuvent affecter grandement les performances du jeux. La plus part des utilisateurs devrait utiliser les valeurs par d??faut de 0,1 et 10."
L["OPT_PLAYSOUND_DESC"] = "Joue un son si quelqu'un est affect??."
L["OPT_POISONCHECK_DESC"] = "Si coch??e, vous pourrez voir et gu??rir les unit??s empoisonn??es"
L["OPT_PRINT_CUSTOM_DESC"] = "Les messages de Decursive seront affich??s dans une fen??tre de discussion sp??ciale"
L["OPT_PRINT_ERRORS_DESC"] = "Les erreurs seront affich??es"
L["OPT_PROFILERESET"] = "Remise ?? z??ro du profil..."
L["OPT_RANDOMORDER_DESC"] = "Les unit??s seront affich??es et gu??ries au hasard (non recommand??)"
L["OPT_READDDEFAULTSD"] = "R??-ajouter les affections par d??faut"
L["OPT_READDDEFAULTSD_DESC1"] = [=[Ajoute les affections de Decursive manquant ?? cette liste
Votre configuration ne sera pas chang??e]=]
L["OPT_READDDEFAULTSD_DESC2"] = "Toutes les affections par d??faut de Decursive sont dans cette liste"
L["OPT_REMOVESKDEBCONF"] = [=[??tes-vous s??r de vouloir enlever 
 '%s' 
de la liste des exceptions ?]=]
L["OPT_REMOVETHISDEBUFF"] = "Enlever cette affection"
L["OPT_REMOVETHISDEBUFF_DESC"] = "Supprime '%s' de la liste d'exception"
L["OPT_RESETDEBUFF"] = "Remettre ?? z??ro cette affection"
L["OPT_RESETDTDCRDEFAULT"] = "Met '%s' aux valeurs par d??faut de Decursive"
L["OPT_RESETMUFMOUSEBUTTONS"] = "R??initialiser"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "R??initialise les affectations des boutons de la souris aux valeurs par d??faut."
L["OPT_RESETOPTIONS"] = "Remet les options par d??faut"
L["OPT_RESETOPTIONS_DESC"] = "Met les options du profil courant aux valeurs par d??faut"
L["OPT_RESTPROFILECONF"] = [=[??tes-vous s??r de vouloir remettre votre profil
 '(%s) %s'
 aux valeurs par d??faut ?]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "La liste des affect??s se remplit de bas en haut"
L["OPT_SCANLENGTH_DESC"] = "D??finit le temps entre chaque scan"
L["OPT_SETAFFTYPECOLOR_DESC"] = [=[Change la couleur des afflictions de type "%s"

(Appara??t principalement dans les infobulles des MUFs et dans la Live list)]=]
L["OPT_SHOW_STEALTH_STATUS"] = "Montrer le camouflage"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "Lorsqu'un joueur est camoufl??, son micro-portrait prendra une couleur sp??ciale."
L["OPT_SHOWBORDER"] = "Afficher la bordure color??e des classes"
L["OPT_SHOWBORDER_DESC"] = "Une bordure color??e repr??sentant la classe de l'unit?? est affich??e autour des micro-portraits"
L["OPT_SHOWHELP"] = "Affiche l'aide"
L["OPT_SHOWHELP_DESC"] = "Affiche une bulle d'aide lorsque la souris passe au-dessus d'un micro-portrait"
L["OPT_SHOWMFS"] = "Affiche la fen??tre de micro-portraits"
L["OPT_SHOWMFS_DESC"] = "Cette option doit ??tre activ??e, si vous voulez gu??rir en cliquant avec la souris"
L["OPT_SHOWMINIMAPICON"] = "Ic??ne Minicarte"
L["OPT_SHOWMINIMAPICON_DESC"] = "Active/D??sactive l'ic??ne de la minicarte"
L["OPT_SHOWTOOLTIP_DESC"] = "Affiche une bulle d'informations d??taill??es ?? propos des affections sur les micro-portraits et dans la liste des affect??s."
L["OPT_SPELL_DESCRIPTION_LOADING"] = "Chargement de la description en cours... revenez plus tard."
L["OPT_SPELL_DESCRIPTION_UNAVAILABLE"] = "La description n'est pas disponible"
L["OPT_SPELLID_MISSING_READD"] = "Vous devez r??-ajouter cette affection en utilisant son Spell ID pour avoir une description au lieu de ce message."
L["OPT_STICKTORIGHT"] = "Aligner la fen??tre ?? droite"
L["OPT_STICKTORIGHT_DESC"] = "La fen??tre des micro-portrait se d??veloppera de la droite vers la gauche, la poign??e sera d??plac??e automatiquement."
L["OPT_TESTLAYOUT"] = "Tester la disposition"
L["OPT_TESTLAYOUT_DESC"] = [=[Cr???? des unit??s virtuelles permettant de tester leur disposition.
(Attendre quelques secondes apr??s avoir cliqu??)]=]
L["OPT_TESTLAYOUTUNUM"] = "Nombre d'unit??"
L["OPT_TESTLAYOUTUNUM_DESC"] = "R??gle le nombre d'unit?? virtuelles ?? cr??er."
L["OPT_TIE_LIVELIST_DESC"] = "L'affichage de la liste des affect??s est li?? ?? celui de la barre \"Decursive\""
L["OPT_TIECENTERANDBORDER"] = "Lier le centre et la bordure"
L["OPT_TIECENTERANDBORDER_OPT"] = "Quand activ??e, la transparence de la bordure vaut la moiti?? de celle du centre"
L["OPT_TIEXYSPACING"] = "Lier l'espacement horizontale et verticale"
L["OPT_TIEXYSPACING_DESC"] = "L'espacement horizontale et verticale entre les micro-portraits sont identiques"
L["OPT_UNITPERLINES"] = "Nombre d'unit??s par rang??e"
L["OPT_UNITPERLINES_DESC"] = "D??finit le nombre maximum de micro-portraits ?? afficher par rang??e"
L["OPT_USERDEBUFF"] = "Cette affection ne fait pas partie de la liste des affections par d??faut de Decursive"
L["OPT_XSPACING"] = "Espacement horizontal"
L["OPT_XSPACING_DESC"] = "R??gle l'espacement horizontal entre les micro-portraits"
L["OPT_YSPACING"] = "Espacement vertical"
L["OPT_YSPACING_DESC"] = "R??gle l'espacement vertical entre les micro-portraits"
L["OPTION_MENU"] = "Menu options"
L["PLAY_SOUND"] = "Jouer un son quand il y a quelqu'un ?? gu??rir"
L["POISON"] = "Poison"
L["POPULATE"] = "R"
L["POPULATE_LIST"] = "Remplir rapidement la liste"
L["PRINT_CHATFRAME"] = "Afficher les messages dans le canal par d??faut"
L["PRINT_CUSTOM"] = "Afficher les messages dans la fen??tre"
L["PRINT_ERRORS"] = "Afficher les messages d'erreurs"
L["PRIORITY_LIST"] = "Liste des priorit??s"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "Gu??rir al??atoirement"
L["REVERSE_LIVELIST"] = "Inverser l'affichage de la liste"
L["SCAN_LENGTH"] = "D??lai (secs) entre les scans : "
L["SHIFT"] = "Maj"
L["SHOW_MSG"] = "Pour afficher la fen??tre \"Decursive\", tapez /dcrshow."
L["SHOW_TOOLTIP"] = "Afficher les infos-bulles sur les unit??s affect??es"
L["SKIP_LIST_STR"] = "Liste des exceptions"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "%s trouv?? !"
L["STEALTHED"] = "Camoufl??e"
L["STR_CLOSE"] = "Fermer"
L["STR_DCR_PRIO"] = "Liste de priorit??s"
L["STR_DCR_SKIP"] = "Liste des exceptions"
L["STR_GROUP"] = "Groupe "
L["STR_OPTIONS"] = "Options de Decursive"
L["STR_OTHER"] = "Autre"
L["STR_POP"] = "Remplir la liste"
L["STR_QUICK_POP"] = "Remplir rapidement"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r sur %s |cFF00AA00r??ussi !|r"
L["TARGETUNIT"] = "Cible l'unit??"
L["TIE_LIVELIST"] = "Lier la visibilit?? de la liste ?? \"Decursive\""
L["TOC_VERSION_EXPIRED"] = [=[Votre version de Decursive est p??rim??e. Cette version de Decursive est plus ancienne que la version de World of Warcraft que vous utilisez.
Vous devez mettre ?? jour Decursive pour corriger d'??ventuelles incompatibilit??s ou erreurs.

Allez sur curse.com et cherchez "Decursive" ou utilisez le client de Curse.com pour mettre tous vos add-ons ?? jour.

Cette note sera affich??e de nouveau dans deux jours.]=]
L["TOO_MANY_ERRORS_ALERT"] = [=[Il y a trop d'erreurs Lua dans votre interface utilisateur (%d erreurs). Votre exp??rience de jeu peut ??tre d??grad??e. D??sactivez ou mettez ?? jour les add-ons en erreur pour stopper ce message.
Vous devriez activer les rapports d'erreur Lua (/console scriptErrors 1).]=]
L["TOOFAR"] = "Hors de port??e"
L["UNITSTATUS"] = "Statut de l'unit?? : "
L["UNSTABLERELEASE"] = "Version instable"



T._LoadedFiles["frFR.lua"] = "2.7.8.12";
