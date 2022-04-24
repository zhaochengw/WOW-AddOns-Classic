local L = LibStub("AceLocale-3.0"):NewLocale("PallyPower", "frFR", false, false)
if not L then return end 
L["ALTMENU_LINE1"] = "peut être attribué"
L["ALTMENU_LINE2"] = "une bénédiction normale de:"
L["AURA"] = "Bouton Aura"
L["AURA_DESC"] = "[|cffffd200Enable|r / |cffffd200Disable|r] Le bouton Aura ou sélectionnez l'aura que vous souhaitez utiliser."
L["AURABTN"] = "Bouton Aura"
L["AURABTN_DESC"] = "[Activer / désactiver] le bouton Aura"
L["AURATRACKER"] = "Aura Tracker"
L["AURATRACKER_DESC"] = "Sélectionnez l'aura que vous souhaitez utiliser"
L["AUTO"] = "Bouton de buff automatique"
L["AUTO_DESC"] = "[|cffffd200Enable|r / |cffffd200Disable|r] Le bouton de buff automatique ou [|cffffd200Enable|r / |cffffd200Disable|r] Attendre les joueurs."
L["AUTOASSIGN"] = "Auto-Assign"
L["AUTOASSIGN_DESC"] = [=[Attribuer automatiquement toutes les bénédictions en fonction du nombre de paladins disponibles et leurs bénédictions disponibles.

|cffffffff [Maj-clic gauche]|r Utiliser la logique pour les champs de bataille au lieu de la logique de raid]=]
L["AUTOBTN"] = "Bouton de buff automatique"
L["AUTOBTN_DESC"] = "[Activer / désactiver] le bouton de buff automatique"
L["AUTOKEY1"] = "Raccourci de bénédiction normale automatique"
L["AUTOKEY1_DESC"] = "Raccourci clavier pour le buff automatique des bénédictions normales."
L["AUTOKEY2"] = "Raccourci de bénédiction supérieure automatique"
L["AUTOKEY2_DESC"] = "Raccourci clavier pour le buff automatique des bénédictions supérieures"
L["BAP"] = "Échelle de la fenêtre d'affectation"
L["BAP_DESC"] = "Cela vous permet d'ajuster la taille globale du panneau des affectations de bénédiction"
L["BRPT"] = "Rapport"
L["BRPT_DESC"] = "Envoyer un rapport des attributions actuelle en canal groupe ou raid. "
L["BSC"] = "Echelle des boutons PallyPower"
L["BSC_DESC"] = "Cela vous permet d'ajuster la taille globale des boutons PallyPower"
L["BUFFDURATION"] = "Durée du buff"
L["BUFFDURATION_DESC"] = "Si cette option est désactivée, les boutons Classe et Joueur ignoreront la durée des buffs permettant de réappliquer un buff à volonté. Ceci est particulièrement utile pour les paladins protection lorsqu'ils spamment des bénédictions supérieures pour générer plus de menace."
L["BUTTONS"] = "Boutons"
L["BUTTONS_DESC"] = "Modifier les paramètres des boutons"
L["CANCEL"] = "Annuler"
L["CLASSBTN"] = "Boutons de classe"
L["CLASSBTN_DESC"] = "Si cette option est désactivée, elle désactivera également les boutons individuel des joueurs et vous ne pourrez buff que via le bouton Auto Buff."
L["CPBTNS"] = "Boutons de classe et de joueur"
L["CPBTNS_DESC"] = "[|cffffd200Enable|r / |cffffd200Disable|r] Le ou les boutons joueurs ou de classe."
L["DISPEDGES"] = "Bordures"
L["DISPEDGES_DESC"] = "Changer les bordures des boutons"
L["DRAG"] = "Bouton de déplacement"
L["DRAG_DESC"] = "[|cffffd200Enable|r / |cffffd200Disable|r] Le bouton de déplacement."
L["DRAGHANDLE"] = [=[|cffffffff [clic gauche]|r |cffff0000Lock|r / |cff00ff00Unlock|r PallyPower
|cffffffff [Clic gauche]|r Déplacer PallyPower
|cffffffff [Clic droit]|r Ouvrir les affectations de bénédiction
|cffffffff [Maj + clic droit]|r Ouvrir les options]=]
L["DRAGHANDLE_ENABLED"] = "Poignée de glissement"
L["DRAGHANDLE_ENABLED_DESC"] = "[Activer / désactiver] la poignée de déplacement"
L["ENABLEPP"] = "Activer PallyPower"
L["ENABLEPP_DESC"] = "[Activer / désactiver] PallyPower"
L["FREEASSIGN"] = "Affectation libre"
L["FREEASSIGN_DESC"] = "Autorisez les autres à modifier vos bénédictions sans être RL ou raid assist"
L["FULLY_BUFFED"] = "Entièrement buffé"
L["HORLEFTDOWN"] = "Horizontal gauche | bas"
L["HORLEFTUP"] = "Horizontal gauche | Haut"
L["HORRIGHTDOWN"] = "Horizontal Droite | Bas"
L["HORRIGHTUP"] = "Horizontal Droite | Haut"
L["LAYOUT"] = "Bouton Buff | Disposition des boutons des joueurs"
L["LAYOUT_DESC"] = [=[Vertical [Gauche / Droite]
Horizontal [Haut / Bas]]=]
L["MAINASSISTANT"] = "Buff automatique des assist raid"
L["MAINASSISTANT_DESC"] = "Si vous activez cette option, PallyPower écrasera automatiquement une Bénédiction supérieure avec une Bénédiction normale sur les joueurs marqués avec le rôle |cffffd200Main Assistant|r dans le panneau Blizzard Raid. Ceci est utile pour éviter de bénir les |cffffd200Main Assist|r rôle avec une bénédiction de salut supérieure"
L["MAINASSISTANTGBUFFDP"] = "Surcharger pour les druides / paladins ..."
L["MAINASSISTANTGBUFFDP_DESC"] = "Sélectionnez la bénédiction supérieure que vous souhaitez remplacer sur les tanks druides / paladins."
L["MAINASSISTANTGBUFFW"] = "Surcharger pour les guerriers"
L["MAINASSISTANTGBUFFW_DESC"] = "Sélectionnez la bénédiction supérieure que vous souhaitez surcharger sur les guerriers tank."
L["MAINASSISTANTNBUFFDP"] = "... avec Normal ..."
L["MAINASSISTANTNBUFFDP_DESC"] = "Sélectionnez la bénédiction normale que vous souhaitez utiliser pour remplacer celle des tanks druides / paladins."
L["MAINASSISTANTNBUFFW"] = "... avec Normal ..."
L["MAINASSISTANTNBUFFW_DESC"] = "Sélectionnez la bénédiction normale que vous souhaitez utiliser pour remplacer celles des guerriers tank."
L["MAINROLES"] = "Roles Tank et Main Assist"
L["MAINROLES_DESC"] = [=[Ces options peuvent être utilisées pour attribuer automatiquement des bénédictions normales alternatives à toute bénédiction supérieure attribuée aux guerriers, aux druides ou aux paladins |cffff0000only|r.

Normalement, les rôles de réservoir principal et d'assistance principale ont été utilisés pour identifier les réservoirs principaux et les réservoirs auxiliaires (aide principale), cependant, certaines guildes attribuent le rôle de réservoir principal aux réservoirs principaux et hors réservoir et attribuent le rôle d'assistance principale aux guérisseurs.

En ayant un paramètre séparé pour les deux rôles, cela permettra aux chefs de classe Paladin ou aux chefs de raid de supprimer, par exemple, une plus grande bénédiction de salut des classes de tanking ou si les druides ou les guérisseurs Paladin sont marqués avec le rôle d'assistance principale qu'ils pourraient être configurés pour obtenir Bénédiction de sagesse normale vs Bénédiction de puissance supérieure qui permettrait d'attribuer une bénédiction de puissance supérieure aux druides et paladins spécifiés par DPS et une bénédiction de sagesse normale à la guérison des druides et paladins spécifiés.
]=]
L["MAINTANKGBUFFDP"] = "Surcharger pour les druides / paladins ..."
L["MAINTANKGBUFFDP_DESC"] = "Sélectionnez la bénédiction supérieure que vous souhaitez remplacer sur les tanks druides / paladins."
L["MAINTANKGBUFFW"] = "Surcharger les guerriers..."
L["MAINTANKGBUFFW_DESC"] = "Sélectionnez la bénédiction supérieure que vous souhaitez remplacer sur les guerriers tanks"
L["MAINTANKNBUFFDP"] = "... avec Normal ..."
L["MAINTANKNBUFFDP_DESC"] = "Sélectionnez la bénédiction normale que vous souhaitez utiliser pour remplacer celles des tanks druides / paladins."
L["MAINTANKNBUFFW"] = "... avec Normal ..."
L["MAINTANKNBUFFW_DESC"] = "Sélectionnez la bénédiction normale que vous souhaitez utiliser pour remplacercelles des guerriers tanks."
L["MINIMAPICON"] = [=[|cffffffff [clic gauche]|r Ouvrir les affectations de bénédiction
|cffffffff [Clic droit]|r Ouvrir les options]=]
L["NONE"] = "Aucun"
L["NONE_BUFFED"] = "Aucun buffé"
L["OPTIONS"] = "Options"
L["OPTIONS_DESC"] = "Ouvre le panneau d'options PallyPower"
L["PARTIALLY_BUFFED"] = "Partiellement buffé"
L["PLAYERBTNS"] = "Boutons de joueur"
L["PLAYERBTNS_DESC"] = "Si cette option est désactivée, vous ne verrez plus les boutons contextuels montrant les joueurs individuels et vous ne pourrez pas réappliquer les bénédictions normales pendant le combat."
L["PP_CLEAR"] = "Clear"
L["PP_CLEAR_DESC"] = "Efface toutes les affectations"
L["PP_COLOR"] = "Changer les couleurs d'état des boutons de buff"
L["PP_LOOKS"] = "Changer l'apparence de PallyPower"
L["PP_MAIN"] = "Paramètres principaux de PallyPower"
L["PP_NAME"] = "PallyPower Classic"
L["PP_RAS1"] = "--- Affectations des paladin ---"
L["PP_RAS2"] = "--- Fin des affectations ---"
L["PP_RAS3"] = "AVERTISSEMENT: il y a plus de 5 paladins en raid."
L["PP_RAS4"] = "Tanks, retirez manuellement Bénédiction du salut!"
L["PP_REFRESH"] = "Actualiser"
L["PP_REFRESH_DESC"] = "Actualise toutes les affectations, talents et nombre de symbole pour tout les paladins"
L["PP_RESET"] = "Juste au cas où vous vous tromperiez"
L["PPMAINTANK"] = "Auto-Buff des tanks"
L["PPMAINTANK_DESC"] = "Si vous activez cette option, PallyPower écrasera automatiquement une Bénédiction supérieure avec une Bénédiction normale sur les joueurs marqués avec le rôle |cffffd200Main Tank|r dans le panneau Blizzard Raid. Ceci est utile pour éviter de bénir le |cffffd200Main Tank|r rôle avec une bénédiction de salut supérieure. "
L["RAID"] = "Raid"
L["RAID_DESC"] = "Options de raid uniquement"
L["REPORTCHANNEL"] = "Canal de rapports des bénédictions"
L["REPORTCHANNEL_DESC"] = [=[Définissez le canal souhaité pour diffuser le rapport Bliessings sur:

|cffffd200 [Aucun]|r Sélectionne le canal en fonction de la composition du groupe. (Groupe / Raid)

|cffffd200 [Liste des chaînes]|r Une liste de canaux remplie automatiquement en fonction des canaux auxquelles le joueur appartient. Les canaux par défaut tels que Trade, General, etc. sont automatiquement filtrés de la liste.

|cffffff00Remarque: si vous modifiez l'ordre des canaux, vous devrez recharger votre interface utilisateur et vérifier qu'elle diffuse sur le canal appropriée.|r]=]
L["RESET"] = "Reset Frames"
L["RESET_DESC"] = "Réinitialiser la position de toutes les fenêtre pallypower au centre de l’écran"
L["RESIZEGRIP"] = [=[Clic gauche pour redimensionner
Le clic droit réinitialise la taille par défaut]=]
L["RFM"] = "Fureur vertueuse"
L["RFM_DESC"] = "[Activer / désactiver] Fureur vertueuse"
L["SALVCOMBAT"] = "Bénédiction de salut pendant le combat"
L["SALVCOMBAT_DESC"] = [=[Si vous activez cette option, vous pourrez buff les guerriers, les druides et les paladins avec une bénédiction de salut supérieure pendant le combat.

|cffffff00Remarque: ce paramètre s'applique UNIQUEMENT aux groupes de raid car dans notre culture actuelle, de nombreux tanks utilisent des scripts / addons pour annuler les buffs qui ne peuvent être effectués qu'en dehors du combat. Cette option est fondamentalement une sécurité pour éviter de buff accidentellement un tank avec salut pendant le combat.|r]=]
L["SEAL"] = "Bouton de sceau"
L["SEAL_DESC"] = "[|cffffd200Enable|r / |cffffd200Disable|r] Le bouton sceau, Activer / Désactiver Fureur vertueuse ou sélectionnez le sceau que vous souhaitez suivre."
L["SEALBTN"] = "Bouton sceau"
L["SEALBTN_DESC"] = "[Activer / désactiver] le bouton sceau"
L["SEALTRACKER"] = "Suivi du sceau"
L["SEALTRACKER_DESC"] = "Sélectionnez le sceau que vous souhaitez suivre"
L["SETTINGS"] = "Paramètres"
L["SETTINGS_DESC"] = "Modifier les paramètres globaux"
L["SETTINGSBUFF"] = "Que buff avec PallyPower"
L["SHOWMINIMAPICON"] = "Afficher l'icône de la mini-carte"
L["SHOWMINIMAPICON_DESC"] = "[Afficher / Masquer] Icône de minicarte"
L["SHOWPETS"] = "Montrer les familiers"
L["SHOWPETS_DESC"] = [=[Si vous activez cette option, les animaux de compagnie apparaîtront dans leur propre classe.

|cffffff00Remarque: en raison de la manière dont les Bénédictions supérieures fonctionnent et de la façon dont les animaux domestiques sont classés, les animaux domestiques doivent être buff séparément. De plus, les diablotins démo seront masqué automatiquement à moins que le déphasage ne soit désactivé.|r]=]
L["SHOWTIPS"] = "Afficher les info-bulles"
L["SHOWTIPS_DESC"] = "[Afficher / Masquer] Les info-bulles PallyPower"
L["SKIN"] = "Textures d'arrière-plan"
L["SKIN_DESC"] = "Modifier les textures d'arrière-plan des boutons"
L["SMARTBUFF"] = "Smart Buffs"
L["SMARTBUFF_DESC"] = "Si vous activez cette option, vous ne serez pas autorisé à attribuer Bénédiction de sagesse aux guerriers ou voleurs et Bénédiction de puissance aux mages, sorciers et chasseurs."
L["USEPARTY"] = "Utiliser en groupe"
L["USEPARTY_DESC"] = "[Activer / désactiver] PallyPower en groupe"
L["USESOLO"] = "Utiliser en solo"
L["USESOLO_DESC"] = "[Activer / désactiver] PallyPower en solo"
L["VERDOWNLEFT"] = "Vertical bas | Gauche"
L["VERDOWNRIGHT"] = "Vertical Down | Right"
L["VERUPLEFT"] = "Vertical Haut | Gauche"
L["VERUPRIGHT"] = "Vertical Up | Right"
L["WAIT"] = "Attendre les joueurs"
L["WAIT_DESC"] = "Si cette option est activée, le bouton de buff automatique et les boutons de buff de classe ne buffent pas automatiquement une plus grande bénédiction si les destinataires ne sont pas dans la plage des paladins (100yds). Cette vérification de plage exclut AFK, Dead et les joueurs hors ligne. "

