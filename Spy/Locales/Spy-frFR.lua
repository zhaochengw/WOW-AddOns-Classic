local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "frFR")
if not L then return end
-- TOC Note: "Détecte et vous avertit de la présence de joueurs ennemis à proximité."

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Version"
L["Spy Option"] = "Spy"
L["Profiles"] = "Profils"

-- About
L["About"] = "Info"
L["SpyDescription1"] = [[
SPY est un addon qui vous avertit de la présence de joueurs ennemis à proximité. Ce sont quelques-unes des principales caractéristiques.

]]

L["SpyDescription2"] = [[
|cffffd000 Liste des ennemis à proximité |cffffffff
Affiche les joueurs ennemis qui ont été détectés à proximité. Les joueurs sont retirés de la liste s'ils n'ont pas été détectés après un certain temps.

|cffffd000 Liste des dernières heures |cffffffff
Affiche tous les ennemis qui ont été détectés au cours de la dernière heure.

|cffffd000 Liste des joueurs à ignorer |cffffffff
Les joueurs qui sont ajoutés à la liste d'ignorés ne seront pas signalés par Spy. Vous pouvez ajouter et supprimer des joueurs de cette liste en utilisant le menu déroulant du bouton ou en maintenant la touche Ctrl enfoncée tout en cliquant sur le bouton.

|cffffd000 Liste des Tuer à vue |cffffffff
Les joueurs de votre liste \"Tuer à vue\" déclenchent une alarme lorsqu'ils sont détectés. Vous pouvez ajouter et supprimer des joueurs de cette liste en utilisant le menu déroulant du bouton ou en maintenant la touche Maj enfoncée tout en cliquant sur le bouton. Le menu déroulant peut également être utilisé pour définir les raisons pour lesquelles vous avez ajouté quelqu'un à la liste "Tuer à vue". Si vous voulez entrer un raison spécifique qui n'est pas dans la liste, utilisez le bouton "Entrez votre propre raison ..." dans la liste "Autre".

]]

L["SpyDescription3"] = [[
|cffffd000 Statistics Window |cffffffff
The Statistics Window contains a list of all enemy encounters which can be sorted by name, level, guild, wins, losses and the last time an enemy was detected. It also provides the ability to search for a specific enemy by name or guild and has filters to show only enemies that are marked as Kill on Sight, with a Win/Loss or entered Reasons. 

|cffffd000 Kill On Sight Button |cffffffff
If enabled, this button will be located on the enemy players target frame. Clicking on this button will add/remove the enemy target to/from the Kill On Sight list. Right clicking on the button will allow you to enter Kill on Sight reasons.

|cffffd000 Auteur:|cffffffff Slipjack
]]

-- General Settings
L["GeneralSettings"] = "Configuration générale"
L["GeneralSettingsDescription"] = [[
Options lorsque Spy est activé ou désactivé.
]] 
L["EnableSpy"] = "Activer Spy"
L["EnableSpyDescription"] = "Active ou désactive Spy."
L["EnabledInBattlegrounds"] = "Activer Spy en champs de bataille"
L["EnabledInBattlegroundsDescription"] = "Active ou désactive Spy lorsque vous êtes sur un champ de bataille."
L["EnabledInArenas"] = "Activer Spy en arènes"
L["EnabledInArenasDescription"] = "Active ou désactive Spy lorsque vous êtes dans une arène."
L["EnabledInWintergrasp"] = "Activer Spy en zone de combat mondiale"
L["EnabledInWintergraspDescription"] = "Active ou désactive Spy lorsque vous êtes dans des zones de combat mondial comme le Joug-d’Hiver en Northrend."
L["DisableWhenPVPUnflagged"] = "Désactiver Spy lorsque le mode JcJ est désactiver"
L["DisableWhenPVPUnflaggedDescription"] = "Active ou désactive Spy en fonction de votre statut JcJ."
L["DisabledInZones"] = "Désactivez Spy lorsque vous vous trouvez dans ces emplacements"
L["DisabledInZonesDescription"]	= "Sélectionnez les emplacements où Spy sera désactivé"
L["Booty Bay"] = "Baie-du-Butin"
L["Everlook"] = "Long-Guet"						
L["Gadgetzan"] = "Gadgetzan"
L["Ratchet"] = "Cabestan"
L["The Salty Sailor Tavern"] = "La taverne du Loup de mer"
L["Shattrath City"] = "Shattrath"
L["Area 52"] = "Zone 52"
L["Dalaran"] = "Dalaran"
L["Dalaran (Northrend)"] = "Dalaran (Norfendre)"
L["Bogpaddle"] = "Brasse-Tourbe"
L["The Vindicaar"] = "Le Vindicaar"
L["Krasus' Landing"] = "Aire de Krasus"
L["The Violet Gate"] = "La porte Pourpre"
L["Magni's Encampment"] = "Campement de Magni"
L["Silithus"] = "Silithus"
L["Chamber of Heart"] = "Chambre du Cœur"
L["Hall of Ancient Paths"] = "Hall des Voies antiques"
L["Sanctum of the Sages"] = "Sanctum des Sages"
L["Rustbolt"] = "Mécarouille"
L["Oribos"] = "Oribos"
L["Valdrakken"] = "Valdrakken"

-- Display
L["DisplayOptions"] = "Affichage"
L["DisplayOptionsDescription"] = [[
Options pour la fenêtre Spy et les infobulles.
]]
L["ShowOnDetection"] = "Afficher Spy lorsque des joueurs ennemis sont détectés"
L["ShowOnDetectionDescription"] = "Choisir cette option pour afficher la fenêtre SPY et la liste des ennemis proches si SPY est masqué lorsque des joueurs ennemis sont détectés."
L["HideSpy"] = "Cacher SPY quand aucun ennemi est détecté"
L["HideSpyDescription"] = "Choisir cette option pour masquer SPY lorsque la liste des ennemis proches s'affiche et qu'elle devient vide. SPY ne sera pas caché si vous effacez la liste manuellement."
L["ShowOnlyPvPFlagged"] = "Afficher uniquement les joueurs ennemis marqués pour le JcJ."
L["ShowOnlyPvPFlaggedDescription"] = "Choisir cette option pour n'afficher que les joueurs ennemis qui ont activé le mode JcJ dans la liste des joueurs à proximité."
L["ShowKoSButton"] = "Afficher le bouton TaV dans le cadre cible ennemi"
L["ShowKoSButtonDescription"] = "Choisir ce paramètre pour afficher le bouton TaV sur le cadre cible du joueur ennemi."
L["Alpha"] = "Transparence"
L["AlphaDescription"] = "Définissez la transparence de la fenêtre Spy."
L["AlphaBG"] = "Transparence sur les champs de bataille"
L["AlphaBGDescription"] = "Définissez la transparence de la fenêtre Spy sur les champs de bataille."
L["LockSpy"] = "Verrouillez la fenêtre SPY"
L["LockSpyDescription"] = "Verrouille la fenêtre Spy pour qu'elle ne bouge pas."
L["ClampToScreen"] = "Garder à l'écran"
L["ClampToScreenDescription"] = "Contrôle si la fenêtre Spy peut être déplacée hors écran."
L["InvertSpy"] = "Inverser la fenêtre Spy"
L["InvertSpyDescription"] = "Renverse la fenêtre Spy"
L["Reload"] = "Reload UI"
L["ReloadDescription"] = "Requis lors du changement de la fenêtre SPY."
L["ResizeSpy"] = "Redimensionner la fenêtre Spy automatiquement"
L["ResizeSpyDescription"] = "Choisir cette option pour redimensionner automatiquement la fenêtre Spy au fur et à mesure que les joueurs ennemis sont ajoutés et supprimés."
L["ResizeSpyLimit"] = "Limite de liste"
L["ResizeSpyLimitDescription"] = "Limite le nombre de joueurs ennemis affichés dans la fenêtre Spy."
L["DisplayTooltipNearSpyWindow"] = "Afficher la bulle d'aide près de la fenêtre Spy"
L["DisplayTooltipNearSpyWindowDescription"] = "Choisir cette option pour afficher des infobulles près de la fenêtre Spy."
L["SelectTooltipAnchor"] = "Point d'ancrage de l'infobulle"
L["SelectTooltipAnchorDescription"] = "Sélectionnez le point d'ancrage de l'infobulle si l'option ci-dessus a été cochée."
L["ANCHOR_CURSOR"] = "Curseur"
L["ANCHOR_TOP"] = "Haut"
L["ANCHOR_BOTTOM"] = "Sous"
L["ANCHOR_LEFT"] = "Gauche"			
L["ANCHOR_RIGHT"] = "Droite"
L["TooltipDisplayWinLoss"] = "Afficher les statistiques de Victoire/Défaite dans l'info-bulle"
L["TooltipDisplayWinLossDescription"] = "Choisir cette option pour afficher les statistiques des Victoire/Défaite d'un joueur dans la bulle d'aide du joueur."
L["TooltipDisplayKOSReason"] = "Afficher les raisons de \"tuer à vue\" dans l'info-bulle"
L["TooltipDisplayKOSReasonDescription"] = "Réglez-le pour afficher les raisons de tuer à vue d'un joueur dans l'info-bulle du joueur."
L["TooltipDisplayLastSeen"] = "Afficher le détail des derniers vus dans l'infobulle"
L["TooltipDisplayLastSeenDescription"] = "Choisir cette option pour afficher la dernière heure et la dernière position connues d'un joueur dans l'info-bulle du joueur."
L["DisplayListData"] = "Sélectionnez les données ennemies à afficher"
L["Name"] = "Nom"
L["Class"] = "Classe"
L["Rank"] = "Rang"
L["SelectFont"] = "Choisir une police"
L["SelectFontDescription"] = "Sélectionnez une police pour la fenêtre SPY."
L["RowHeight"] = "Sélectionner la hauteur de ligne"
L["RowHeightDescription"] = "Sélectionnez la hauteur de ligne pour la fenêtre Spy."
L["Texture"] = "Texture"
L["TextureDescription"] = "Sélectionner une texture pour la fenêtre d'espionnage"

-- Alerts
L["AlertOptions"] = "Alertes"
L["AlertOptionsDescription"] = [[
Options d'alertes, d'annonces et d'avertissements lorsque des joueurs ennemis sont détectés.
]]
L["SoundChannel"] = "Sélectionner le canal sonore"
L["Master"] = "Global"
L["SFX"] = "Effets"
L["Music"] = "Musique"
L["Ambience"] = "Ambiance"
L["Announce"] = "Envoyer les annonces à:"
L["None"] = "Aucun"
L["NoneDescription"] = "Ne pas annoncer lorsque des joueurs ennemis sont détectés."
L["Self"] = "Soi"
L["SelfDescription"] = "Annoncer à vous même lorsqu'un joueur ennemi est détecté."
L["Party"] = "Groupe"
L["PartyDescription"] = "Annoncez à votre groupe lorsque des joueurs ennemis sont détectés."
L["Guild"] = "Guilde"
L["GuildDescription"] = "Annoncez votre guilde lorsque des joueurs ennemis sont détectés."
L["Raid"] = "Raid"
L["RaidDescription"] = "Annoncez votre raid lorsque des joueurs ennemis sont détectés."
L["LocalDefense"] = "Défense locale"
L["LocalDefenseDescription"] = "Annoncer sur le canal de défense locale lorsqu'un joueur ennemi est détecté"
L["OnlyAnnounceKoS"] = "annoncer uniquement les ennemis figurant sur la liste des tuer à vue"
L["OnlyAnnounceKoSDescription"] = "Choisissez cette option pour annoncer uniquement les joueurs ennemis présents dans votre liste Tuer à vue."
L["WarnOnStealth"] = "Avertir si une furtivité est détectée"
L["WarnOnStealthDescription"] = "Choisissez cette option pour afficher un avertissement et déclencher une alerte lorsqu'un joueur ennemi active la furtivité."
L["WarnOnKOS"] = "Avertissement en cas de détection Tuer à vue"
L["WarnOnKOSDescription"] = "Choisissez cette option pour afficher un avertissement et déclencher une alerte lorsqu'un joueur ennemi de la même guilde qu'un ennemi dans votre liste de Tuer à vue est détecté."
L["WarnOnKOSGuild"] = "Avertissement en cas de détection d'une guilde Tuer à vue"
L["WarnOnKOSGuildDescription"] = "Choisissez cette option pour afficher un avertissement et déclencher une alerte lorsqu'un joueur ennemi de votre liste Tuer à vue est détecté."
L["WarnOnRace"] = "Avertissement en cas de détection de race"
L["WarnOnRaceDescription"] = "Choisir cette option pour déclencher une alerte lorsque la race sélectionnée est détectée."
L["SelectWarnRace"] = "Sélectionnez la race à détecter"
L["SelectWarnRaceDescription"] = "Sélectionnez une race pour l'alerte audio."
L["WarnRaceNote"] = "Note: Vous devez cibler un ennemi au moins une fois pour que sa race puisse être ajoutée à la base de données. Lors de la détection suivante, une alerte retentit. Cela ne fonctionne pas de la même façon que de détecter les ennemis proches au combat."
L["DisplayWarningsInErrorsFrame"] = "Afficher les avertissements dans le cadre d'erreurs"
L["DisplayWarningsInErrorsFrameDescription"] = "Choisir cette option pour utiliser le cadre d'erreurs afin d'afficher les avertissements au lieu d'utiliser les cadres contextuels graphiques."
L["DisplayWarnings"] = "Sélectionner l'emplacement du message d'avertissement"
L["Default"] = "défaut"
L["ErrorFrame"] = "Trame d'erreur"
L["Moveable"] = "mobile"
L["EnableSound"] = "Activer les alertes audio"
L["EnableSoundDescription"] = "Choisissez cette option pour activer les alertes audio lorsque des joueurs ennemis sont détectés. Différentes alertes sonneront si un joueur ennemi utilise la furtivité ou si un joueur ennemi est sur votre liste Tuer à vue."
L["OnlySoundKoS"] = "Seules les alertes sonores pour la détection tuer à vue"
L["OnlySoundKoSDescription"] = "Choisissez cette option pour entendre les alertes audio uniquement lorsque les joueurs de la liste Tuer à vue sont détectés."
L["StopAlertsOnTaxi"] = "Désactiver les alertes lors de l'utilisation d'une trajectoire de vol"
L["StopAlertsOnTaxiDescription"] = "Arrêtez tous les nouveaux avertissements et avertissements lorsque vous utilisez une trajectoire de vol."

-- Nearby List
L["ListOptions"] = "Liste à proximité"
L["ListOptionsDescription"] = [[
Options sur la façon dont les joueurs ennemis sont ajoutés et supprimés.
]]
L["RemoveUndetected"] = "Supprimez les joueurs ennemis de la liste des joueurs à proximité après:"
L["1Min"] = "1 minute"
L["1MinDescription"] = "Retirez un joueur ennemi qui n'a pas été détecté depuis plus d'une minute."
L["2Min"] = "2 minutes"
L["2MinDescription"] = "Retirez un joueur ennemi qui n'a pas été détecté depuis plus de 2 minutes."
L["5Min"] = "5 minutes"
L["5MinDescription"] = "Retirez un joueur ennemi qui n'a pas été détecté depuis plus de 5 minutes."
L["10Min"] = "10 minutes"
L["10MinDescription"] = "Retirez un joueur ennemi qui n'a pas été détecté depuis plus de 10 minutes."
L["15Min"] = "15 minutes"
L["15MinDescription"] = "Retirez un joueur ennemi qui n'a pas été détecté depuis plus de 15 minutes."
L["Never"] = "Ne jamais enlevé"
L["NeverDescription"] = "Ne jamais retirer les joueurs ennemis. La liste des ennemis proche peut être effacée manuellement."
L["ShowNearbyList"] = "Passez à la liste des ennemis proches lors de la détection d'un joueur ennemi"
L["ShowNearbyListDescription"] = "Choisir cette option pour afficher la liste Proche si elle n'est pas déjà visible lorsque des joueurs ennemis sont détectés."
L["PrioritiseKoS"] = "Prioriser les joueurs ennemis Tuer à vue dans la liste des joueurs à proximité"
L["PrioritiseKoSDescription"] = "Choisissez cette option pour toujours afficher les joueurs ennemis Tuer à vue en premier dans la liste des ennemis proches."

-- Map
L["MapOptions"] = "Carte"
L["MapOptionsDescription"] = [[
Options pour la carte du monde et la mini-carte, y compris les icônes et les info-bulles.
]]
L["MinimapDetection"] = "Activer la détection sur la minimap"
L["MinimapDetectionDescription"] = "Faire glisser le curseur sur les joueurs ennemis connus détectés sur la minimap les ajoutera à la liste des joueurs les plus proches."
L["MinimapNote"] = "          Note: Ne fonctionne que pour les joueurs qui peuvent traquer les humanoïdes."
L["MinimapDetails"] = "Affiché le niveau/class dans l’infobulle"
L["MinimapDetailsDescription"] = "Choisir cette option pour mettre à jour les infobulles de la carte de sorte que les détails de niveau/classe soient affichés à côté du nom des ennemis."
L["DisplayOnMap"] = "Afficher les icônes sur la carte"
L["DisplayOnMapDescription"] = "Affichez les icônes de la carte pour localiser les autres utilisateurs Spy de votre groupe / raid / guilde lorsqu'ils détectent des ennemis."
L["SwitchToZone"] = "Passer à la carte de zone actuelle lors de la détection d'un ennemi"
L["SwitchToZoneDescription"] = "Change l'affichage de la carte vers la zone actuelle lors de la détection d’ennemis."
L["MapDisplayLimit"] = "Limiter l'affichage des icônes de la carte à:"
L["LimitNone"] = "Partout"
L["LimitNoneDescription"] = "Affiche tous les ennemis détectés sur la carte, quel que soit votre emplacement actuel."
L["LimitSameZone"] = "Même zone"
L["LimitSameZoneDescription"] = "N'affiche que les ennemis détectés dans la carte si vous êtes dans la même zone."
L["LimitSameContinent"] = "Même continent"
L["LimitSameContinentDescription"] = "N'affiche que les ennemis détectés dans la carte si vous êtes sur le même continent."

-- Data Management
L["DataOptions"] = "Gestion des données"
L["DataOptionsDescription"] = [[

Options sur la façon dont Spy maintient et recueille les données.
]]
L["PurgeData"] = "Purger les données des joueurs ennemis non détectés après:"
L["OneDay"] = "1 jour"
L["OneDayDescription"] = "Purger les données des joueurs ennemis qui n'ont pas été détectés pendant 1 jour."
L["FiveDays"] = "5 jours"
L["FiveDaysDescription"] = "Purgez les données des joueurs ennemis qui n'ont pas été détectés depuis 5 jours.."
L["TenDays"] = "10 jours"
L["TenDaysDescription"] = "Purger les données des joueurs ennemis qui n'ont pas été détectés pendant 10 jours."
L["ThirtyDays"] = "30 jours"
L["ThirtyDaysDescription"] = "Purger les données des joueurs ennemis qui n'ont pas été détectés pendant 30 jours."
L["SixtyDays"] = "60 jours"
L["SixtyDaysDescription"] = "Purgez les données des joueurs ennemis qui n'ont pas été détectés depuis 60 jours."
L["NinetyDays"] = "90 jours"
L["NinetyDaysDescription"] = "Purgez les données des joueurs ennemis qui n'ont pas été détectés depuis 90 jours."
L["PurgeKoS"] = "Purger les joueurs de la Tuer à vue en fonction du temps de non détection."
L["PurgeKoSDescription"] = "Choisir cette option pour purger les joueurs Tuer à vue qui n'ont pas été détectés en fonction des paramètres de temps pour les joueurs non détectés."
L["PurgeWinLossData"] = "Purgez les données de Victoire/Défaite en fonction du temps non détection."
L["PurgeWinLossDataDescription"] = "Choisir cette option pour purger les données de Victoire/Défaite de vos rencontres ennemies en fonction des paramètres de temps pour les joueurs non détectés."
L["ShareData"] = "Partager des données avec d'autres utilisateurs de Spy"
L["ShareDataDescription"] = "Choisissez cette option pour partager les détails de vos rencontres avec des joueurs ennemis avec d'autres utilisateurs Spy de votre groupe, de votre raid et de votre guilde."
L["UseData"] = "Utiliser les données d'autres utilisateurs de Spy"
L["UseDataDescription"] = "Choisir cette option pour utiliser les données collectées par d'autres utilisateurs de Spy dans votre groupe, raid et guilde."
L["ShareKOSBetweenCharacters"] = "Partagez des joueurs Tuer à vue entre vos personnages"
L["ShareKOSBetweenCharactersDescription"] = "Choisir cette option pour partager les joueurs présent dans votre liste des Tuer à vue avec les autres personnages que vous jouez sur le même serveur et la même faction."

-- Commands
L["SlashCommand"] = "Commande Slash"
L["SpySlashDescription"] = "Ces boutons exécutent les mêmes fonctions que celles de la commande /spy"
L["Enable"] = "Activer"
L["EnableDescription"] = "Active Spy et affiche la fenêtre principale."
L["Show"] = "Afficher"
L["ShowDescription"] = "SAffichez la fenêtre Spy."
L["Hide"] = "Cacher"
L["HideDescription"] = "Masque la fenêtre principale."
L["Reset"] = "Réinitialiser"
L["ResetDescription"] = "Réinitialise la position et l'apparence de la fenêtre principale."
L["ClearSlash"] = "Effacer"
L["ClearSlashDescription"] = "Effacer la liste des joueurs qui ont été détecté"
L["Config"] = "Config"
L["ConfigDescription"] = "Ouvre la fenêtre de configuration de Spy"
L["KOS"] = "TAV"
L["KOSDescription"] = "Ajouter / retirer un joueur à / de la liste Tuer à vue"
L["InvalidInput"] = "Saisie invalide"
L["Ignore"] = "Ignore"
L["IgnoreDescription"] = "Ajouter/retirer un joueur à/de la liste ingnore."
L["Test"] = "Test"
L["TestDescription"] = "Affiche un avertissement afin que vous puissiez le repositionner."

-- Lists
L["Nearby"] = "Proche"
L["LastHour"] = "Dernière heure"
L["Ignore"] = "Ignorer"
L["KillOnSight"] = "Tuer à vue"

--Stats
L["Won"] = "Victoire"
L["Lost"] = "Défaite"
L["Time"] = "Temps"	
L["List"] = "Liste"
L["Filter"] = "Filtrer"
L["Show Only"] = "Afficher seulement"
L["Realm"] = "Royaume"
L["KOS"] = "TAV"
L["Won/Lost"] = "Victoire/Défaite"
L["Reason"] = "Raison"	 
L["HonorKills"] = "l'honneur tue"
L["PvPDeaths"] = "JcJ Morts"

-- Output Messages
L["VersionCheck"] = "|cffc41e3aAttention! La mauvaise version de Spy est installée. Cette version est pour Wrath of the Lich King - Classic."
L["SpyEnabled"] = "|cff9933ffAddon SPY activé"
L["SpyDisabled"] = "|cff9933ffAddon SPY désactivé. Taper |cffffffff/spy show|cff9933ff pour l'activer"
L["UpgradeAvailable"] = "|cff9933ffUne nouvelle version de Spy est disponible. Elle peut être téléchargée à partir de:\n|cffffffffhttps://www.curseforge.com/wow/addons/spy-wotlk"
L["AlertStealthTitle"] = "Joueur furtif détecté!"
L["AlertKOSTitle"] = "Joueur Tuer à vue détecté!"
L["AlertKOSGuildTitle"] = "Guilde Tuer à vue détecté!"
L["AlertTitle_kosaway"] = "Joueur Tuer à vue détecté par "
L["AlertTitle_kosguildaway"] = "Guilde Tuer à vue détecté par: "
L["StealthWarning"] = "|cff9933ffJoueur furtif détecté: |cffffffff"
L["KOSWarning"] = "|cffff0000Guilde Tuer à vue détecté par: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Guilde Tuer à vue détecté: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff[Spy] "
L["PlayerDetectedColored"] = "Joueur détecté: |cffffffff"
L["PlayersDetectedColored"] = "Joueurs détectés: |cffffffff"
L["KillOnSightDetectedColored"] = "Joueur Tuer à vue détecté: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Joueur ajouté à la liste Ignore: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Suppression du joueur de la liste Ignore: |cffffffff"
L["PlayerAddedToKOSColored"] = "Joueur ajouté à la liste Tuer à vue: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Suppression du joueur de la liste Tuer à vue: |cffffffff"
L["PlayerDetected"] = "[Spy] Joueur détecté: "
L["KillOnSightDetected"] = "[Spy] Joueur Tuer à vue détecté: "
L["Level"] = "Niveau"
L["LastSeen"] = "vue dernière fois il y a"
L["LessThanOneMinuteAgo"] = "il y a moins d'une minute"
L["MinutesAgo"] = "minutes"
L["HoursAgo"] = "heures"
L["DaysAgo"] = "jours"
L["Close"] = "Fermer"
L["CloseDescription"] = "|cffffffffMasque la fenêtre Espion, elle réapparaîtra lorsque le prochain joueur ennemi sera détecté."
L["Left/Right"] = "Gauche/Droite"
L["Left/RightDescription"] = "|cffffffffNavigue entre les listes A proximité, Dernière heure, Ignore et Tuer à vue"
L["Clear"] = "Effacer"
L["ClearDescription"] = "|cffffffffEfface la liste des joueurs qui ont été détectés. Control-Click activera ou désactivera Spy. Shift-Click activera ou désactivera tous les sons."
L["SoundEnabled"] = "Alertes audio activées"
L["SoundDisabled"] = "Alertes audio désactivées"
L["NearbyCount"] = "comte à proximité"
L["NearbyCountDescription"] = "|cffffffffNombre d’ennemis à proximité"
L["Statistics"] = "Statistiques"
L["StatsDescription"] = "|cffffffffAffiche une liste des joueurs ennemis rencontrés, les statistiques de Victoire/Défaite et l'endroit où ils ont été vus pour la dernière fois."
L["AddToIgnoreList"] = "Ajouter à votre liste ignore"
L["AddToKOSList"] = "Ajouter à la liste Tuer à vue"
L["RemoveFromIgnoreList"] = "Retirer de la liste Ignorer"
L["RemoveFromKOSList"] = "Retirer de la liste Tuer à vue"
L["RemoveFromStatsList"] = "Retirer de la liste des statistiques"   
L["AnnounceDropDownMenu"] = "Annoncer"
L["KOSReasonDropDownMenu"] = "Saisir une raison pour Tuer à vue"
L["PartyDropDownMenu"] = "Groupe"
L["RaidDropDownMenu"] = "Raid"
L["GuildDropDownMenu"] = "Guilde"
L["LocalDefenseDropDownMenu"] = "Défense locale"
L["Player"] = " (Joueur)"
L["KOSReason"] = "Tuer à Vue"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Saisir votre propre raison..."
L["KOSReasonClear"] = "Effacer la raison"
L["StatsWins"] = "|cff40ff00Victoires: "
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070ddDéfaites: "
L["Located"] = "localisé:"
L["Yards"] = "mètres"
L["LocalDefenseChannelName"] = "Défenselocale"

Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Commencé le combat";
		["content"] = {
			"M'a attaqué sans raison",
			"M'a attaqué au donneur de quête", 
			"M'a attaqué pendant que je combattais des PNJ",
			"M'a attaqué alors que j'étais proche d'une instance",
			"M'a attaqué alors que je suis AFK",
			"M'a attaqué pendant que j'étais monté",
			"M'a attaqué lorsque j'étais bas en vie/mana",
		};
	},
	[2] = {
		["title"] = "Style de combat";
		["content"] = {
			"Me tendre une embuscade",
			"M'attaque toujours à vue",
			"M'a tué avec un caractère de haut niveau",
			"Ganked moi avec un groupe d'ennemis",
			"N'attaquez pas sans renforts",
			"Appelle toujours à l'aide",
			"Utilise trop de contrôle (stun, fear ...)",
		};
	},
	[3] = {
		["title"] = "Camper";
		["content"] = {
			"Le joueur me campe",
			"campé mon autre caractère",
			"Caractère de niveau inférieur campés",
			"Camping furtif",
			"Membres de guilde campés",
			"Camping sur un PNJ/objectif",
			"Camping dans une ville/lieu",
		};
	},
	[4] = {
		["title"] = "Quête";
		["content"] = {
			"M'a attaqué alors que j'étais en quête",
			"M'a attaqué après l'avoir aidé pour une quête",
			"Interférer avec un objectif de quête",
			"Commencé une quête que je voulais faire",
			"Tué les PNJ de ma faction",
			"Tue les PNJ de quête",
		};
	},
	[5] = {
		["title"] = "A volé des ressources";
		["content"] = {
			"Rassemblé les herbes que je voulais",
			"Rassemblé le minéral que je voulais",
			"Rassemblé les ressources que je voulais",
			"Il m'a tué et m'a volé ma cible ou un PNJ rare",
			"A dépecé mes mobs",
			"A pris des articles de mes mobs",
			"Pêché dans ma piscine",
		};
	},
	[6] = {
		["title"] = "Autre";
		["content"] = {
			"Flaggé JcJ",
			"M'a poussé d'une falaise",
			"Utilise des objets d'ingénierie",
			"Parvient toujours à s'échapper",
			"Utilise des objets et des compétences pour s'échapper",
			"Exploite la mécanique du jeu",
			"Saisir votre propre raison...",
		};
	},
}

StaticPopupDialogs["Spy_SetKOSReasonOther"] = {
	preferredIndex=STATICPOPUPS_NUMDIALOGS,  -- http://forums.wowace.com/showthread.php?p=320956
	text = "Entrez une raison pour tuer à vue pour %s:",
	button1 = "Saisir",
	button2 = "Annuler",
	timeout = 120,
	hasEditBox = 1,
	editBoxWidth = 260,	
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
    OnAccept = function(self)
		local reason = self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Saisir votre propre raison...", reason)
	end,
};

-- Class descriptions
L["UNKNOWN"] = "Inconnu"
L["DRUID"] = "Druide"
L["HUNTER"] = "Chasseur"
L["MAGE"] = "Mage"
L["PALADIN"] = "Paladin"
L["PRIEST"] = "Prêtre"
L["ROGUE"] = "Voleur"
L["SHAMAN"] = "Chaman"
L["WARLOCK"] = "Démoniste"
L["WARRIOR"] = "Guerrier"
L["DEATHKNIGHt"] =" Chevalier de la mort "
L["MONK"] = "Moine"
L["DEMONHUNTER"] = "Chasseur de démons"
L["EVOKER"] = "Évocateur"

--++ Race descriptions
L["Human"] = "Humain"
L["Orc"] = "Orc"
L["Dwarf"] = "Nain"
L["Tauren"] = "Tauren"
L["Troll"] = "Troll"
L["Night Elf"] = "Elfe de la nuit"
L["Undead"] = "Mort-vivant"
L["Gnome"] = "Gnome"
L["Blood Elf"] = "Elfe de sang"
L["Draenei"] = "Draeneï"
L["Goblin"] = "Gobelin"
L["Worgen"] = "Worgen"
L["Pandaren"] = "Pandaren"
L["Highmountain Tauren"] = "Tauren de Haut-Roc"
L["Lightforged Draenei"] = "Draeneï sancteforge"
L["Nightborne"] = "Sacrenuit"
L["Void Elf"] = "Elfe du Vide"
L["Dark Iron Dwarf"] = "Nain sombrefer"
L["Mag'har Orc"] = "Orc mag’har"
L["Kul Tiran"] = "Kultirassien"
L["Zandalari Troll"] = "Troll zandalari"
L["Mechagnome"] = "Mécagnome"
L["Vulpera"] = "Vulpérin"
L["Dracthyr"] = "Dracthyr"
 
-- Capacités stealth
L["Stealth"] = "Camouflage"
L["Prowl"] = "Rôder"
 
--++ Minimap color codes
L["MinimapGuildText"] = "|cffffffff"
L["MinimapClassTextUNKNOWN"] = "|cff191919"
L["MinimapClassTextDRUID"] = "|cffff7c0a"
L["MinimapClassTextHUNTER"] = "|cffaad372"
L["MinimapClassTextMAGE"] = "|cff68ccef"
L["MinimapClassTextPALADIN"] = "|cfff48cba"
L["MinimapClassTextPRIEST"] = "|cffffffff"
L["MinimapClassTextROGUE"] = "|cfffff468"
L["MinimapClassTextSHAMAN"] = "|cff2359ff"
L["MinimapClassTextWARLOCK"] = "|cff9382c9"
L["MinimapClassTextWARRIOR"] = "|cffc69b6d"
L["MinimapClassTextDEATHKNIGHT"] = "|cffc41e3a"
L["MinimapClassTextMONK"] = "|cff00ff96"
L["MinimapClassTextDEMONHUNTER"] = "|cffa330c9"
L["MinimapClassTextEVOKER"] = "|cff33937f"

Spy_IgnoreList = {

};
 
