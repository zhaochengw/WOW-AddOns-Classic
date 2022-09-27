--localization file for french/France
local Lang = LibStub("AceLocale-3.0"):NewLocale("Attune", "frFR");
if (not Lang) then
	return;
end


-- INTERFACE
Lang["Credits"] = "Un énorme MERCI à ma guilde |cffffd100<Divine Heresy>|r pour leur soutien et patience pendant les tests de l'addon, et merci à |cffffd100Bushido @ Pyrewood Village|r pour l'aide sur TBC!\n\nMerci beaucoup également aux traducteurs:\n  - Traduction allemande: |cffffd100Sumaya @ Razorfen DE|r\n  - Traduction russe: |cffffd100Guilde Greymarch @ Flamegor RU|r\n  - Traduction espagnole: |cffffd100Coyu @ Pyrewood Village EU|r\n  - Traduction chinoise (simp.): |cffffd100ly395842562|r et |cffffd100Icyblade|r\n  - Traditional chinoise (trad.): |cffffd100DayZ|r @ Ivus TW|r\n  - Traduction coréenne: |cffffd100Drix @ Azshara KR|r\n\n/Hug de la part Cixi/Gaya @ Remulos Horde"
Lang["Mini"] = "Mini"
Lang["Maxi"] = "Élargi"
Lang["Version"] = "Attune v##VERSION## par Cixi@Remulos"
Lang["Splash"] = "v##VERSION## par Cixi@Remulos. Tapez /attune pour commencer."
Lang["Survey"] = "Sondage"
Lang["Guild"] = "Guilde"
Lang["Party"] = "Groupe"
Lang["Raid"] = "Raid"
Lang["Run an attunement survey (for people with the addon)"] = "Effectuer un sondage (pour les joueurs ayant l'addon)"
Lang["Toggle between attunements and survey results"] = "Alterner entre les accès et les résultats du sondage" 
Lang["Close"] = "Fermer" 
Lang["Export"] = "Exporter"
Lang["My Data"] = "Mes données"
Lang["Last Survey"] = "Dernier Sondage"
Lang["Guild Data"] = "Ma Guilde"
Lang["All Data"] = "Tout"
Lang["Export your Attune data to the website"] = "Exporter vos données vers un site internet"
Lang["Copy the text below, then upload it to"] = "Copiez le texte, puis uploadez le sur"
Lang["Results"] = "Résultats"
Lang["Not in a guild"] = "Pas dans une guilde"
Lang["Click on a header to sort the results"] = "Cliquez sur un entête pour classer les résultats" 
Lang["Character"] = "Personnage"
Lang["Characters"] = "Personnages" 
Lang["Last survey results"] = "Derniers résultats"	
Lang["All FACTION results"] = "Tous les résultats ##FACTION##"
Lang["Guild members"] = "Membres de la guilde" 
Lang["All results"] = "Tous les résultats" 
Lang["Minimum level"] = "Niveau minimum" 
Lang["Click to navigate to that attunement"] = "Cliquez pour aller à cet accès"
Lang["Attunes"] = "Accès"
Lang["Guild members on this step"] = "Membres de la guilde à cette étape " --space at the end on purpose, as : takes a space before AND after in french
Lang["Attuned guild members"] = "Membres de la guilde ayant accès " --space at the end on purpose, as : takes a space before AND after in french
Lang["Attuned alts"] = "Autres personnages ayant accès " --space at the end on purpose, as : takes a space before AND after in french
Lang["Alts on this step"] = "Autres personnages à cette étape " --space at the end on purpose, as : takes a space before AND after in french
Lang["Settings"] = "Options" --Paramètres works too but Options is shorter
Lang["Survey Log"] = "Audit"
Lang["LeftClick"] = "Clic gauche :"
Lang["OpenAttune"] = " Ouvrir Attune"
Lang["RightClick"] = "Clic droit :"
Lang["OpenSettings"] = " Ouvrir les options"
Lang["Addon disabled"] = "Addon désactivé"
Lang["StartAutoGuildSurvey"] = "Envoi automatique d'un sondage de guilde discret"
Lang["SendingDataTo"] = "Envoi d'informations Attune à |cffffd100##NAME##|r"
Lang["NewVersionAvailable"] = "Une |cffffd100nouvelle version|r d'Attune est disponible, n'oubliez pas de le mettre à jour !"
Lang["CompletedStep"] = "Fin de l'étape ##TYPE## |cffe4e400##STEP##|r pour l'accès |cffe4e400##NAME##|r."
Lang["AttuneComplete"] = "Accès |cffe4e400##NAME##|r débloqué !"
Lang["AttuneCompleteGuild"] = "Accès ##NAME## débloqué !"
Lang["SendingSurveyWhat"] = "Envoi du sondage ##WHAT##"
Lang["SendingGuildSilentSurvey"] = "Envoi d'un sondage discret de guilde"
Lang["SendingYellSilentSurvey"] = "Envoi d'un sondage discret de proximité"
Lang["ReceivedDataFromName"] = "Infos reçues de |cffffd100##NAME##|r"
Lang["ExportingData"] = "Préparation des infos Attune pour ##COUNT## perso(s)"
Lang["ReceivedRequestFrom"] = "Sondage reçu de |cffffd100##FROM##|r"
Lang["Help1"] = "Cet addon vous permet de suivre et partager vos accès."
Lang["Help2"] = "Tapez |cfffff700/attune|r pour commencer."
Lang["Help3"] = "Pour voir la progression des votre guilde, cliquez sur |cfffff700Sondage|r pour récuperer les infos."
Lang["Help4"] = "Vous verrez alors la progression de chacun des membres de votre guilde ayant l'addon."
Lang["Help5"] = "Une fois que vous avez assez d'info, cliquez sur |cfffff700Exporter|r pour exporter la progression."
Lang["Help6"] = "Les données peuvent être publiées via |cfffff700https://warcraftratings.com/attune/upload|r"
Lang["Survey_DESC"] = "Effectuer un sondage sur les accès (pour les joueurs ayant l'addon)."
Lang["Export_DESC"] = "Exportez vos données Attune vers le site internet."
Lang["Toggle_DESC"] = "Alterne entre vos accès et les résultats des sondages."
--Lang["PreferredLocale_TEXT"] = "Langue favorite"
--Lang["PreferredLocale_DESC"] = "Sélectionne la langue dans laquelle vous souhaitez voir Attune. Requiert de recharger l'interface."
--v220
Lang["My Toons"] = "Mes personnages"
Lang["No Target"] = "Vous n'avez pas de cible"
Lang["No Response From"] = "Pas de réponse de ##PLAYER##"
Lang["Sync Request From"] = "Nouvelle requête Attune Sync de :\n\n##PLAYER##"
Lang["Could be slow"] = "Selon la quantité de données ques vous avez, cela peut prendre du temps"
Lang["Accept"] = "Accepter"
Lang["Reject"] = "Refuser"
Lang["Busy right now"] = "##PLAYER## est occupé, réessayez plus tard"
Lang["Sending Sync Request"] = "Requête Sync envoyée à ##PLAYER##"
Lang["Request accepted, sending data to "] = "Requête acceptée, envoi de données à ##PLAYER##"
Lang["Received request from"] = "Requête reçue de ##PLAYER##"
Lang["Request rejected"] = "Requête refusée"
Lang["Sync over"] = "Sync terminée, durée ##DURATION##"
Lang["Syncing Attune data with"] = "Synchronisation des données Attune avec ##PLAYER##"
Lang["Cannot sync while another sync is in progress"] = "Impossible, une synchronisation est déjà en cours"
Lang["Sync with target"] = "Synchronisation avec cible"
Lang["Show Profiles"] = "Voir Profils"
Lang["Show Progress"] = "Voir Progression"
Lang["Status"] = "Statut"
Lang["Role"] = "Rôle"
Lang["Last Surveyed"] = "Dernier sondage"
Lang['Seconds ago'] = "il y a ##DURATION##"
Lang["Main"] = "Principal"
Lang["Alt"] = "Secondaire"
Lang["Tank"] = "Tank"
Lang["Healer"] = "Healer"
Lang["Melee DPS"] = "Dps mêlée"
Lang["Ranged DPS"] = "Dps distance"
Lang["Bank"] = "Banque"
Lang["DelAlts_TEXT"] = "Supprimer les persos secondaires"
Lang["DelAlts_DESC"] = "Supprime toutes les données recueillie sur les personnages secondaires"
Lang["DelAlts_CONF"] = "Vraiment supprimer les données des personnages secondaires ?"
Lang["DelAlts_DONE"] = "Les données des personnages secondaires ont été supprimées."
Lang["DelUnspecified_TEXT"] = "Supprimer les persos sans-statut"
Lang["DelUnspecified_DESC"] = "Supprime toutes les données recueillie sur les personnages sans statut principal/secondaire"
Lang["DelUnspecified_CONF"] = "Vraiment supprimer les données des personnages sans-statut ?"
Lang["DelUnspecified_DONE"] = "Les données des personnages sans-statut ont été supprimées."
--v221
Lang["Open Raid Planner"] = "Planificateur de raid"
Lang["Unspecified"] = "Non specifié"
Lang["Empty"] = "Vide"
Lang["Guildies only"] = "Guilde uniquement"
Lang["Show Mains"] = "Persos principaux"
Lang["Show Unspecified"] = "Persos non-specifiés"
Lang["Show Alts"] = "Persos secondaires"
Lang["Show Unattuned"] = "Persos sans accès"
Lang["Raid spots"] = "##SIZE## places dans le raid"
Lang["Group Number"] = "Groupe ##NUMBER##"
Lang["Move to next group"] = "    Déplacer au groupe suivant" --ajouter des espaces pour décaler
Lang["Remove from raid"] = "Enlever du raid"
Lang["Select a raid and click on players to add them in"] = "Choisissez un raid puis cliquez sur un joueur pour l'y ajouter."
--v224
Lang["Enter a new name for this raid group"] = "Entrez un nom pour ce groupe de raid"
Lang["Save"] = "Sauvegarder"
--v226
Lang["Invite"] = "Inviter"
Lang["Send raid invites to all listed players?"] = "Inviter tous les joueurs listés a joindre le raid ?"
Lang["External link"] = "Lien vers une base de données en ligne"
--v243
Lang["Ogrila"] = "Ogri'la"
Lang["Ogri'la Quest Hub"] = "Centre de quêtes d'Ogri'la"
Lang["Ogrila_Desc"] = "Les citoyens éclairés d'Ogri'la ont élu domicile dans la partie Ouest des Tranchantes."
Lang["DelInactive_TEXT"] = "Supprimer les inactifs"
Lang["DelInactive_DESC"] = "Supprimer toutes les informations sur les joueurs marqués comme inactifs"
Lang["DelInactive_CONF"] = "Vraiment supprimer tous les inactifs ?"
Lang["DelInactive_DONE"] = "Tous les inactifs supprimés"
Lang["RAIDS"] = "RAIDS"
Lang["KEYS"] = "CLÉS"
Lang["MISC"] = "DIVERS"
Lang["HEROICS"] = "HÉROÏQUES"
--v244
Lang["Ally of the Netherwing"] = "Allié de l'Aile-du-néant"
Lang["Netherwing_Desc"] = "L'Aile-du-néant est une faction de dragons située en Outreterre."
--v247
Lang["Tirisfal Glades"] = "Clairières de Tirisfal"
Lang["Scholomance"] = "Scholomance"
--v248
Lang["Target"] = "Cible"
Lang["SendingSurveyTo"] = "Envoi d'un sondage discret à ##TO## "
--WOTLK
Lang["QUEST HUBS"] = "CENTRES DE QUETES"
Lang["PHASES"] = "PHASES"
Lang["Angrathar the Wrathgate"] = "Angrathar le portail du Courroux"
Lang["Unlock the Wrathgate events and the Battle for the Undercity"] = "Debloquez les evenements du portail du Courroux et la bataille pour Fossoyeuse"
Lang["Sons of Hodir"] = "Les Fils de Hodir"
Lang["Unlock the Sons of Hodir quest hub"] = "Debloquez le centre de quêtes des Fils de Hodir"
Lang["Knights of the Ebon Blade"] = "Chevaliers de la Lame d'ébène"
Lang["Unlock the Shadow Vault quest hub"] = "Debloquez le centre de quêtes des Chevaliers de la Lame d'ébène"
Lang["Goblin"] = "Gobelin"
Lang["Death Knight"] = "Chevalier de la mort"
Lang["Eye"] = "Œil"
Lang["Abomination"] = "Abomination"
Lang["Banshee"] = "Banshee"
Lang["Geist"] = "Geist"
Lang["Icecrown"] = "La Couronne de glace"
Lang["Dragonblight"] = "Désolation des dragons"
Lang["Borean Tundra"] = "Toundra Boréenne"
Lang["The Storm Peaks"] = "Les pics Foudroyés"
Lang["The Eye of Eternity"] = "L'Œil de l'éternité"
Lang["Sapphiron"] = "Saphiron"
Lang["One_Desc"] = "Un seul membre du groupe a besoin d'avoir son accès pour ouvrir l'instance."


-- OPTIONS
Lang["MinimapButton_TEXT"] = "Afficher le bouton de la mini-carte"
Lang["MinimapButton_DESC"] = "Ajoute un bouton sur la mini-carte pour accéder rapidement à l'addon ou à ses options."
Lang["AutoSurvey_TEXT"] = "Sonder automatiquement au démarrage"
Lang["AutoSurvey_DESC"] = "Lorsque vous vous connecterez, l'addon effectuera un sondage auprès de votre guilde."
Lang["ShowSurveyed_TEXT"] = "Indiquer quand vous avez été sondé"
Lang["ShowSurveyed_DESC"] =  "Affiche un message dans le chat lorsque vous recevrez (et repondrez) à une demande de sondage."
Lang["ShowResponses_TEXT"] = "Indiquer les réponses à vos sondages"
Lang["ShowResponses_DESC"] = "Affiche un message dans le chat pour chaque réponse à l'un de vos sondages."
Lang["ShowSetMessages_TEXT"] = "Annoncer les progrès"
Lang["ShowSetMessages_DESC"] = "Affiche un message dans le chat lorsque vous terminez une étape ou débloquez un accès."
Lang["AnnounceToGuild_TEXT"] = "Annoncer les accès à la guilde"
Lang["AnnounceToGuild_DESC"] = "Envoie un message au canal de guilde lorsqu'un accès est débloqué."
Lang["ShowOther_TEXT"] = "Afficher les autres messages de l'addon"
Lang["ShowOther_DESC"] = "Affiche le reste des messages génériques (écran de demarrage, envoi de sondage, mise a jour disponible, etc)."
Lang["ShowGuildies_TEXT"] = "Montrer les membres de la guilde à chaque étape                 Nombre max :"  --this has a gap for the editbox
Lang["ShowGuildies_DESC"] = "Dans l'info-bulle de chaque étape, affiche la liste des membres de la guilde qui en sont à ce stade. Ajustez le nombre maximal de noms à lister si besoin."
Lang["ShowAltsInstead_TEXT"] = "Remplacer la liste des membres par celle de vos personnages"
Lang["ShowAltsInstead_DESC"] = "Les info-bulles de chaque étape afficheront vos autres personnages à cette étape plutôt que les membres de votre guilde."
Lang["ClearAll_TEXT"] = "Supprimer TOUTES les données"
Lang["ClearAll_DESC"] = "Supprime toutes les données recueillies sur les autres personnages."
Lang["ClearAll_CONF"] = "Vraiment TOUT supprimer ?"
Lang["ClearAll_DONE"] = "Toutes les données ont été supprimées."
Lang["DelNonGuildies_TEXT"] = "Supprimer les extérieurs à la guilde"
Lang["DelNonGuildies_DESC"] = "Supprime toutes les données recueillies sur les personnages extérieurs à la guilde."
Lang["DelNonGuildies_CONF"] = "Vraiment supprimer les données des personnages extérieurs à la guilde ?"
Lang["DelNonGuildies_DONE"] = "Les données des personnages extérieurs à la guilde ont été supprimées."
Lang["DelUnder60_TEXT"] = "Supprimer les persos <60"
Lang["DelUnder60_DESC"] = "Supprime toutes les données recueillies sur les personnages en dessous du niveau 60."
Lang["DelUnder60_CONF"] = "Vraiment supprimer les données des personnages en dessous du niveau 60 ?"
Lang["DelUnder60_DONE"] = "Toutes les données des personnages en dessous du niveau 60 ont été supprimées."
Lang["DelUnder70_TEXT"] = "Supprimer les persos <70"
Lang["DelUnder70_DESC"] = "Supprime toutes les données recueillies sur les personnages en dessous du niveau 70."
Lang["DelUnder70_CONF"] = "Vraiment supprimer les données des personnages en dessous du niveau 70 ?"
Lang["DelUnder70_DONE"] = "Toutes les données des personnages en dessous du niveau 70 ont été supprimées."
--302
Lang["AnnounceAchieve_TEXT"] = "Annoncer les Hauts Faits à la guilde                                          Seuil:"
Lang["AnnounceAchieve_DESC"] = "Envoie un message au canal de guilde lorsqu'un Haut Fait est achevé."
Lang["AchieveCompleteGuild"] = "##LINK## achevé!" 
Lang["AchieveCompletePoints"] = "(##POINTS## points au total)" 
Lang["AchieveSurvey"] = "Voulez vous qu'|cFFFFD100Attune|r envoie un message au canal de guilde lorsque |cFFFFD100##WHO##|r acheve un Haut Fait?"
--306
Lang["showDeprecatedAttunes_TEXT"] = "Afficher les accès obsolète"
Lang["showDeprecatedAttunes_DESC"] = "Garder les accès obsolète (Onyxia 40, Naxxramas 40) dans la liste"	


-- TREEVIEW
Lang["World of Warcraft"] = "World of Warcraft"
Lang["The Burning Crusade"] = "La Croisade Ardente"
Lang["Molten Core"] = "Coeur du Magma"
Lang["Onyxia's Lair"] = "Repaire d'Onyxia"
Lang["Blackwing Lair"] = "Repaire de l'Aile Noire"
Lang["Naxxramas"] = "Naxxramas"
Lang["Scepter of the Shifting Sands"] = "Sceptre des Sables Changeants"
Lang["Shadow Labyrinth"] = "Labyrinthe des ombres"
Lang["The Shattered Halls"] = "Les Salles brisées" 
Lang["The Arcatraz"] = "L'Arcatraz"
Lang["The Black Morass"] = "Le Noir Marécage"
Lang["Thrallmar Heroics"] = "Héroïques de Thrallmar"
Lang["Honor Hold Heroics"] = "Héroïques du Bastion de l'Honneur"
Lang["Cenarion Expedition Heroics"] = "Héroïques de l'Expédition cénarienne"
Lang["Lower City Heroics"] = "Héroïques de la Ville basse"
Lang["Sha'tar Heroics"] = "Héroïques des Sha'tar"
Lang["Keepers of Time Heroics"] = "Héroïques des Gardiens du Temps"
Lang["Nightbane"] = "Plaie-de-nuit"
Lang["Karazhan"] = "Karazhan"
Lang["Serpentshrine Cavern"] = "Caverne du sanctuaire du Serpent"
Lang["The Eye"] = "Donjon de la Tempête"
Lang["Mount Hyjal"] = "Mont Hyjal"
Lang["Black Temple"] = "Temple Noir"
Lang["MC_Desc"] = "Tous les membres du raid doivent avoir débloquer leur accès pour entrer dans l'instance, sauf s'ils entrent via les Profondeurs de Rochenoire." 
Lang["Ony_Desc"] = "Tous les membres du raid doivent avoir l'Amulette Drakefeu dans leur inventaire pour entrer dans l'instance."
Lang["BWL_Desc"] = "Tous les membres du raid doivent avoir débloquer leur accès pour entrer dans l'instance, sauf s'ils entrent via le Pic Rochenoire." 
Lang["All_Desc"] = "Tous les membres du raid doivent avoir débloquer leur accès pour entrer dans l'instance."
Lang["AQ_Desc"] = "Une seule personne par royaume a besoin de compléter cette chaine afin d'ouvrir les portes d'Ahn'Qiraj."
Lang["OnlyOne_Desc"] = "Un seul membre du groupe a besoin d'avoir son accès pour ouvrir l'instance. Un voleur avec Crochetage à 350 peut aussi ouvrir la porte du donjon."
Lang["Heroic_Desc"] = "Tous les membres du groupe doivent avoir la réputation requise ainsi que la clé pour accéder à un donjon en mode héroïque."
Lang["NB_Desc"] = "Un seul membre du raid a besoin d'avoir l'Urne noircie pour invoquer Plaie-de-nuit."
Lang["BT_Desc"] = "Tous les membres du raid doivent avoir le Médaillon de Karabor pour entrer dans l'instance."
Lang["BM_Desc"] = "Tous les membres du groupe doivent compléter les quêtes pour entrer dans l'instance." 
--v250
Lang["Aqual Quintessence"] = "Quintessence aquatique"
Lang["MC2_Desc"] = "Utilisée pour invoquer Chambellan Executus. Tous les boss de Molten Core, à l'exception de Lucifron et Geddon, ont des runes au sol qui doivent être aspergées pour que Executus apparaisse." 
--v254
Lang["Magisters' Terrace Heroic"] = "Terrasse des Magistères Héroïque"
Lang["Magisters' Terrace"] = "Terrasse des Magistères"
Lang["MgT_Desc"] = "Tous les joueurs doivent terminer le donjon en mode normal pour pouvoir l'exécuter en mode héroïque."
Lang["Isle of Quel'Danas"] = "Île de Quel'Danas"
Lang["Wrath of the Lich King"] = "La Colère du Roi-Liche"


-- GENERIC
Lang["Reach level"] = "Atteindre niveau"
Lang["Attuned"] = "Accès débloqué"
Lang["Not attuned"] = "Accès verrouillé"
Lang["AttuneColors"] = "Bleu : Accès débloqué\nRouge : Accès verrouillé"
Lang["Minimum Level"] = "Ceci est le niveau minimum pour accéder aux quêtes."
Lang["NPC Not Found"] = "PNJ non trouvé"
Lang["Level"] = "Niveau"
Lang["Exalted with"] = "Exalté avec"
Lang["Revered with"] = "Révéré avec"
Lang["Honored with"] = "Honoré avec"
Lang["Friendly with"] = "Amical avec"
Lang["Neutral with"] = "Neutre avec"
Lang["Quest"] = "Quête"
Lang["Pick Up"] = "Prendre"
Lang["Turn In"] = "Rendre"
Lang["Kill"] = "Tuer"
Lang["Interact"] = "Interagir"
Lang["Item"] = "Objet"
Lang["Required level"] = "Niveau requis"
Lang["Requires level"] = "Requiert niveau"
Lang["Attunement or key"] = "Accès ou clé"
Lang["Reputation"] = "Réputation"
Lang["in"] = "dans"
Lang["Unknown Reputation"] = "Réputation inconnue"
Lang["Current progress"] = "Progression"
Lang["Completion"] = "Progression"
Lang["Quest information not found"] = "Détails de la quête non trouvés"
Lang["Information not found"] = "Information non trouvée"
Lang["Solo quest"] = "Quête solo"
Lang["Party quest"] = "Quête de groupe (##NB## joueurs)"
Lang["Raid quest"] = "Quête de raid (##NB## joueurs)"
Lang["HEROIC"] = "H"
Lang["Elite"] = "Élite"
Lang["Boss"] = "Boss"
Lang["Rare Elite"] = "Élite Rare"
Lang["Dragonkin"] = "Dragon"
Lang["Troll"] = "Troll"
Lang["Ogre"] = "Ogre"
Lang["Orc"] = "Orc"
Lang["Half-Orc"] = "Demi-Orc"
Lang["Dragonkin (in Blood Elf form)"] = "Dragon (sous forme d'Elfe de Sang)"
Lang["Human"] = "Humain"
Lang["Dwarf"] = "Nain"
Lang["Mechanical"] = "Mécanique"
Lang["Arakkoa"] = "Arakkoa"
Lang["Dragonkin (in Humanoid form)"] = "Dragon (sous forme Humaine)"
Lang["Ethereal"] = "Ethérien"
Lang["Blood Elf"] = "Elfe de Sang"
Lang["Elemental"] = "Elémentaire"
Lang["Shiny thingy"] = "Truc qui brille"
Lang["Naga"] = "Naga"
Lang["Demon"] = "Demon"
Lang["Gronn"] = "Gronn"
Lang["Undead (in Dragon form)"] = "Mort-vivant (sous forme de Dragon)"
Lang["Tauren"] = "Tauren"
Lang["Qiraji"] = "Qiraji"
Lang["Gnome"] = "Gnome"
Lang["Broken"] = "Roué"
Lang["Draenei"] = "Draeneï"
Lang["Undead"] = "Mort-vivant"
Lang["Gorilla"] = "Gorille"
Lang["Shark"] = "Requin"
Lang["Chimaera"] = "Chimère"
Lang["Wisp"] = "Feu follet"
Lang["Night-Elf"] = "Elfe de la nuit"


-- REP
Lang["Argent Dawn"] = "Aube d'argent"
Lang["Brood of Nozdormu"] = "Progéniture de Nozdormu"
Lang["Thrallmar"] = "Thrallmar"
Lang["Honor Hold"] = "Bastion de l'Honneur"
Lang["Cenarion Expedition"] = "Expédition cénarienne"
Lang["Lower City"] = "Ville basse"
Lang["The Sha'tar"] = "Les Sha'tar"
Lang["Keepers of Time"] = "Gardiens du Temps"
Lang["The Violet Eye"] = "L'Œil pourpre"
Lang["The Aldor"] = "L'Aldor"
Lang["The Scryers"] = "Les Clairvoyants"


-- LOCATIONS
Lang["Blackrock Mountain"] = "Rochenoire"
Lang["Blackrock Depths"] = "Profondeurs de Rochenoire"
Lang["Badlands"] = "Terres ingrates"
Lang["Lower Blackrock Spire"] = "Bas du Pic Rochenoire"
Lang["Upper Blackrock Spire"] = "Sommet du Pic Rochenoire"
Lang["Orgrimmar"] = "Orgrimmar"
Lang["Western Plaguelands"] = "Maleterres de l'ouest"
Lang["Desolace"] = "Désolace"
Lang["Dustwallow Marsh"] = "Marécage d'Âprefange"
Lang["Tanaris"] = "Tanaris"
Lang["Winterspring"] = "Berceau-de-l'Hiver"
Lang["Swamp of Sorrows"] = "Marais des Chagrins"
Lang["Wetlands"] = "Les Paluns"
Lang["Burning Steppes"] = "Steppes ardentes"
Lang["Redridge Mountains"] = "Les Carmines"
Lang["Stormwind City"] = "Hurlevent"
Lang["Eastern Plaguelands"] = "Maleterres de l'est"
Lang["Silithus"] = "Silithus"
Lang["The Temple of Atal'Hakkar"] = "Le Temple d'Atal'Hakkar"
Lang["Teldrassil"] = "Teldrassil"
Lang["Moonglade"] = "Reflet-de-Lune"
Lang["Hinterlands"] = "Hinterlands"
Lang["Ashenvale"] = "Orneval"
Lang["Feralas"] = "Féralas"
Lang["Duskwood"] = "Bois de la Pénombre"
Lang["Azshara"] = "Azshara"
Lang["Blasted Lands"] = "Terres foudroyées"
Lang["Undercity"] = "Fossoyeuse"
Lang["Silverpine Forest"] = "Forêt des Pins argentés"
Lang["Shadowmoon Valley"] = "Vallée d'Ombrelune"
Lang["Hellfire Peninsula"] = "Péninsule des Flammes infernales"
Lang["Sethekk Halls"] = "Les salles des Sethekk"
Lang["Caverns Of Time"] = "Grottes du temps"
Lang["Netherstorm"] = "Raz-de-Néant"
Lang["Shattrath City"] = "Shattrath"
Lang["The Mechanaar"] = "Le Méchanar"
Lang["The Botanica"] = "La Botanica"
Lang["Zangarmarsh"] = "Marécage de Zangar"
Lang["Terokkar Forest"] = "Forêt de Terokkar"
Lang["Deadwind Pass"] = "Défilé de Deuillevent"
Lang["Alterac Mountains"] = "Montagnes d'Alterac"
Lang["The Steamvault"] = "Le Caveau de la vapeur"
Lang["Slave Pens"] = "Les enclos aux esclaves"
Lang["Gruul's Lair"] = "Repaire de Gruul"
Lang["Magtheridon's Lair"] = "Le repaire de Magtheridon"
Lang["Zul'Aman"] = "Zul'Aman"
Lang["Sunwell Plateau"] = "Plateau du Puits de soleil"



-- ITEMS
Lang["Drakkisath's Brand"] = "Marque de Drakkisath"
Lang["Crystalline Tear"] = "Larme cristalline"
Lang["I_18412"] = "Fragment du Magma"			-- https://www.thegeekcrusade-serveur.com/db/?item=18412
Lang["I_12562"] = "Importants documents Rochenoire"			-- https://www.thegeekcrusade-serveur.com/db/?item=12562
Lang["I_16786"] = "Oeil de draconide noir"			-- https://www.thegeekcrusade-serveur.com/db/?item=16786
Lang["I_11446"] = "Une note chiffonnée"			-- https://www.thegeekcrusade-serveur.com/db/?item=11446
Lang["I_11465"] = "Informations égarées du maréchal Windsor"			-- https://www.thegeekcrusade-serveur.com/db/?item=11465
Lang["I_11464"] = "Informations égarées du maréchal Windsor"			-- https://www.thegeekcrusade-serveur.com/db/?item=11464
Lang["I_18987"] = "Instructions de Main-noire"			-- https://www.thegeekcrusade-serveur.com/db/?item=18987
Lang["I_20383"] = "Tête du seigneur des couvées Lanistaire"			-- https://www.thegeekcrusade-serveur.com/db/?item=20383
Lang["I_21138"] = "Fragment de sceptre rouge"			-- https://www.thegeekcrusade-serveur.com/db/?item=21138
Lang["I_21146"] = "Fragment de la corruption du Cauchemar"			-- https://www.thegeekcrusade-serveur.com/db/?item=21146
Lang["I_21147"] = "Fragment de la corruption du Cauchemar"			-- https://www.thegeekcrusade-serveur.com/db/?item=21147
Lang["I_21148"] = "Fragment de la corruption du Cauchemar"			-- https://www.thegeekcrusade-serveur.com/db/?item=21148
Lang["I_21149"] = "Fragment de la corruption du Cauchemar"			-- https://www.thegeekcrusade-serveur.com/db/?item=21149
Lang["I_21139"] = "Fragment de sceptre vert"			-- https://www.thegeekcrusade-serveur.com/db/?item=21139
Lang["I_21103"] = "Le draconique pour les nuls - Chapitre I"			-- https://www.thegeekcrusade-serveur.com/db/?item=21103
Lang["I_21104"] = "Le draconique pour les nuls - Chapitre II"			-- https://www.thegeekcrusade-serveur.com/db/?item=21104
Lang["I_21105"] = "Le draconique pour les nuls - Chapitre III"			-- https://www.thegeekcrusade-serveur.com/db/?item=21105
Lang["I_21106"] = "Le draconique pour les nuls - Chapitre IV"			-- https://www.thegeekcrusade-serveur.com/db/?item=21106
Lang["I_21107"] = "Le draconique pour les nuls - Chapitre V"			-- https://www.thegeekcrusade-serveur.com/db/?item=21107
Lang["I_21108"] = "Le draconique pour les nuls - Chapitre VI"			-- https://www.thegeekcrusade-serveur.com/db/?item=21108
Lang["I_21109"] = "Le draconique pour les nuls - Chapitre VII"			-- https://www.thegeekcrusade-serveur.com/db/?item=21109
Lang["I_21110"] = "Le draconique pour les nuls - Chapitre VIII"			-- https://www.thegeekcrusade-serveur.com/db/?item=21110
Lang["I_21111"] = "Le draconique pour les nuls : volume II"			-- https://www.thegeekcrusade-serveur.com/db/?item=21111
Lang["I_21027"] = "Carcasse de Lakmaeran"			-- https://www.thegeekcrusade-serveur.com/db/?item=21027
Lang["I_21024"] = "Filet de chimaerok"			-- https://www.thegeekcrusade-serveur.com/db/?item=21024
Lang["I_20951"] = "Lunettes de divination de Narain"			-- https://www.thegeekcrusade-serveur.com/db/?item=20951
Lang["I_21137"] = "Fragment de sceptre bleu"			-- https://www.thegeekcrusade-serveur.com/db/?item=21137
Lang["I_21175"] = "Le Sceptre des Sables changeants"			-- https://www.thegeekcrusade-serveur.com/db/?item=21175
Lang["I_31241"] = "Moule à clé préparé"			-- https://www.thegeekcrusade-serveur.com/db/?item=31241
Lang["I_31239"] = "Moule à clé préparé"			-- https://www.thegeekcrusade-serveur.com/db/?item=31239
Lang["I_27991"] = "Clé du labyrinthe des Ombres"			-- https://www.thegeekcrusade-serveur.com/db/?item=27991
Lang["I_31086"] = "Pièce inférieure de la clé d'Arcatraz"			-- https://www.thegeekcrusade-serveur.com/db/?item=31086
Lang["I_31085"] = "Pièce supérieure de la clé de l'Arcatraz"			-- https://www.thegeekcrusade-serveur.com/db/?item=31085
Lang["I_31084"] = "Clé de l'Arcatraz"			-- https://www.thegeekcrusade-serveur.com/db/?item=31084
Lang["I_30637"] = "Clé en flammes forgées"			-- https://www.thegeekcrusade-serveur.com/db/?item=30637
Lang["I_30622"] = "Clé en flammes forgées"			-- https://www.thegeekcrusade-serveur.com/db/?item=30622
Lang["I_30623"] = "Clé du réservoir"			-- https://www.thegeekcrusade-serveur.com/db/?item=30623
Lang["I_30633"] = "Clé auchenaï"			-- https://www.thegeekcrusade-serveur.com/db/?item=30633
Lang["I_30634"] = "Clé dimensionnelle"			-- https://www.thegeekcrusade-serveur.com/db/?item=30634
Lang["I_30635"] = "Clé du Temps"			-- https://www.thegeekcrusade-serveur.com/db/?item=30635
Lang["I_185686"] = "Clé en flammes forgées"			-- https://www.thegeekcrusade-serveur.com/db/?item=30637
Lang["I_185687"] = "Clé en flammes forgées"			-- https://www.thegeekcrusade-serveur.com/db/?item=30622
Lang["I_185690"] = "Clé du réservoir"			-- https://www.thegeekcrusade-serveur.com/db/?item=30623
Lang["I_185691"] = "Clé auchenaï"			-- https://www.thegeekcrusade-serveur.com/db/?item=30633
Lang["I_185692"] = "Clé dimensionnelle"			-- https://www.thegeekcrusade-serveur.com/db/?item=30634
Lang["I_185693"] = "Clé du Temps"			-- https://www.thegeekcrusade-serveur.com/db/?item=30635
Lang["I_24514"] = "Premier fragment de la clé"			-- https://www.thegeekcrusade-serveur.com/db/?item=24514
Lang["I_24487"] = "Deuxième fragment de la clé"			-- https://www.thegeekcrusade-serveur.com/db/?item=24487
Lang["I_24488"] = "Troisième fragment de la clé"			-- https://www.thegeekcrusade-serveur.com/db/?item=24488
Lang["I_24490"] = "La clé du maître"			-- https://www.thegeekcrusade-serveur.com/db/?item=24490
Lang["I_23933"] = "Journal de Medivh"			-- https://www.thegeekcrusade-serveur.com/db/?item=23933
Lang["I_25462"] = "Tome de la pénombre"			-- https://www.thegeekcrusade-serveur.com/db/?item=25462
Lang["I_25461"] = "Livre des noms oubliés"			-- https://www.thegeekcrusade-serveur.com/db/?item=25461
Lang["I_24140"] = "Urne noircie"			-- https://www.thegeekcrusade-serveur.com/db/?item=24140
Lang["I_31750"] = "Chevalière terrestre"			-- https://www.thegeekcrusade-serveur.com/db/?item=31750
Lang["I_31751"] = "Chevalière flamboyante"			-- https://www.thegeekcrusade-serveur.com/db/?item=31751
Lang["I_31716"] = "Hache inutilisée du bourreau"			-- https://www.thegeekcrusade-serveur.com/db/?item=31716
Lang["I_31721"] = "Trident de Kalithresh"			-- https://www.thegeekcrusade-serveur.com/db/?item=31721
Lang["I_31722"] = "Essence de Marmon"			-- https://www.thegeekcrusade-serveur.com/db/?item=31722
Lang["I_31704"] = "La clé de la Tempête"			-- https://www.thegeekcrusade-serveur.com/db/?item=31704
Lang["I_29905"] = "Reste de la fiole de Kael"			-- https://www.thegeekcrusade-serveur.com/db/?item=29905
Lang["I_29906"] = "Reste de la fiole de Vashj"			-- https://www.thegeekcrusade-serveur.com/db/?item=29906
Lang["I_31307"] = "Coeur de fureur"			-- https://www.thegeekcrusade-serveur.com/db/?item=31307
Lang["I_32649"] = "Médaillon de Karabor"			-- https://www.thegeekcrusade-serveur.com/db/?item=32649
--v247
Lang["Shrine of Thaurissan"] = "Sanctuaire de Thaurissan"
Lang["I_14610"] = "Le Scarabée d'Araj"
--v250
Lang["I_17332"] = "Main de Shazzrah"
Lang["I_17329"] = "Main de Lucifron"
Lang["I_17331"] = "Main de Gehennas"
Lang["I_17330"] = "Main de Sulfuron"
Lang["I_17333"] = "Quintessence aquatique"
--WOTLK
Lang["I_41556"] = "Métal couvert de scories"
Lang["I_44569"] = "Clé de l'iris de focalisation"
Lang["I_44582"] = "Clé de l'iris de focalisation"
Lang["I_44577"] = "Clé héroïque de l'iris de focalisation"
Lang["I_44581"] = "Clé héroïque de l'iris de focalisation"

Lang["I_"] = ""


-- QUESTS - Classic
Lang["Q1_7848"] = "Harmonisation avec le Cœur du Magma"	-- https://www.thegeekcrusade-serveur.com/db/?quest=7848
Lang["Q2_7848"] = "Aventurez-vous jusqu'au portail d'entrée du Cœur du Magma dans les Profondeurs de Rochenoire et récupérez un Fragment du Magma. Lorsque ce sera fait, retournez voir Lothos Ouvrefaille au mont Rochenoire."
Lang["Q1_4903"] = "Ordre du chef de guerre"	-- https://www.thegeekcrusade-serveur.com/db/?quest=4903
Lang["Q2_4903"] = "Tuer le généralissime Omokk, le maître de guerre Voone et le seigneur Wyrmthalak. Récupérer les Importants documents Rochenoire. Retourner voir le chef de guerre Sangredent à Kargath une fois la mission accomplie."
Lang["Q1_4941"] = "Sagesse d'Eitrigg"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4941
Lang["Q2_4941"] = "Parler à Eitrigg, à Orgrimmar. Après avoir discuté avec Eitrigg, demander conseil à Thrall.\n\nVous avez déjà vu Eitrigg dans les Appartements de Thrall."
Lang["Q1_4974"] = "Pour la Horde !"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4974
Lang["Q2_4974"] = "Aller au Pic Rochenoire et tuer le Chef de guerre, Rend Main-noire. Prendre sa tête et retourner à Orgrimmar."
Lang["Q1_6566"] = "Ce que le vent apporte"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6566
Lang["Q2_6566"] = "Écouter Thrall."
Lang["Q1_6567"] = "Le Champion de la Horde"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6567
Lang["Q2_6567"] = "Chercher Rexxar sur les chemins de Désolace."
Lang["Q1_6568"] = "Maîtresse en tromperie"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6568
Lang["Q2_6568"] = "Apporter la Lettre de Rokaro à Myranda la Mégère, dans les Maleterres de l’ouest."
Lang["Q1_6569"] = "Illusions d'Occulus"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6569
Lang["Q2_6569"] = "Aller au Pic Rochenoire et collecter 20 Yeux de draconide noir. Retourner voir Myranda la Mégère quand la tâche sera terminée."
Lang["Q1_6570"] = "Brandeguerre"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6570
Lang["Q2_6570"] = "Aller à la tourbière du Ver, dans le marécage d'Âprefange, et chercher la tanière de Brandeguerre. Une fois à l’intérieur, porter l’Amulette de subversion draconique, et parler à Brandeguerre."
Lang["Q1_6584"] = "L'épreuve des crânes, Chronalis"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6584
Lang["Q2_6584"] = "Chronalis, enfant de Nozdormu, garde les Grottes du temps, dans le Désert de Tanaris. Tuez-le et rapportez son crâne à Brandeguerre."
Lang["Q1_6582"] = "L'épreuve des crânes, Clairvoyant"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6582
Lang["Q2_6582"] = "Vous devez trouver Clairvoyant, le drake champion du Vol bleu, et le tuer. Arracher son crâne à son cadavre, et le rapporter à Brandeguerre."
Lang["Q1_6583"] = "L'épreuve des crânes, Somnus"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6583
Lang["Q2_6583"] = "Détruire le Champion drake du Vol vert, Somnus. Arracher son crâne à son cadavre, puis le rapporter à Brandeguerre."
Lang["Q1_6585"] = "L'épreuve des crânes, Axtroz"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6585
Lang["Q2_6585"] = "Aller à Grim Batol et traquer Axtroz, le Champion drake du Vol rouge. Le tuer et arracher son crâne, puis l’apporter à Brandeguerre."
Lang["Q1_6601"] = "Ascension..."			-- https://www.thegeekcrusade-serveur.com/db/?quest=6601
Lang["Q2_6601"] = "Il semble que la comédie soit finie. Vous savez que l’Amulette de subversion draconique, créée par Myranda la Mégère, ne fonctionnera pas à l’intérieur du pic Rochenoire. Peut-être devriez-vous trouver Rexxar et lui exposer votre fâcheuse situation. Montrez-lui l'Amulette drakefeu terne. Avec un peu de chance, il saura quoi faire."
Lang["Q1_6602"] = "Le sang du champion des dragons noirs"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6602
Lang["Q2_6602"] = "Aller au Pic Rochenoire, et tuer le général Drakkisath. Récupérer son sang et l'apporter à Rexxar."
Lang["Q1_4182"] = "La menace des draconiens"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4182
Lang["Q2_4182"] = "Tuer 15 Rejetons noirs, 10 Draconides noirs, 4 Wyrmides noirs et 1 Drake noir. Retrouver Helendis Ruissecorne une fois la tâche accomplie."
Lang["Q1_4183"] = "Les véritables maîtres"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4183
Lang["Q2_4183"] = "Voyager jusqu'à Comté-du-Lac et remettre la Lettre d'Helendis Ruissecorne au Magistrat Salomon."
Lang["Q1_4184"] = "Les véritables maîtres"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4184
Lang["Q2_4184"] = "Voyager jusqu'à Hurlevent et remettre la Demande d'aide de Salomon au généralissime Bolvar Fordragon.\n\nBolvar demeure dans le Donjon de Hurlevent."
Lang["Q1_4185"] = "Les véritables maîtres"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4185
Lang["Q2_4185"] = "Parler au généralissime Bolvar Fordragon après avoir parlé à dame Katrana Prestor."
Lang["Q1_4186"] = "Les véritables maîtres"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4186
Lang["Q2_4186"] = "Apporter le Décret de Bolvar au Magistrat Salomon à Comté-du-Lac."
Lang["Q1_4223"] = "Les véritables maîtres"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4223
Lang["Q2_4223"] = "Parler au maréchal Maxwell dans les Steppes ardentes."
Lang["Q1_4224"] = "Les véritables maîtres"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4224
Lang["Q2_4224"] = "Parlez à John le Loqueteux pour apprendre ce qu'il est advenu du maréchal Windsor puis retournez voir le maréchal Maxwell lorsque vous aurez accompli cette tâche.\n\nVous vous rappelez que le maréchal Maxwell vous a dit de le chercher dans une grotte au nord."
Lang["Q1_4241"] = "Maréchal Windsor"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4241
Lang["Q2_4241"] = "Partir pour le mont Rochenoire au nord-ouest et pénétrer dans les Profondeurs de Rochenoire. Découvrir ce qu'il est advenu du Maréchal Windsor.\n\nVous vous souvenez que John le Loqueteux a dit que Windsor avait été traîné en prison."
Lang["Q1_4242"] = "Espoir abandonné"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4242
Lang["Q2_4242"] = "Donner les mauvaises nouvelles au maréchal Maxwell."
Lang["Q1_4264"] = "Une note chiffonnée"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4264
Lang["Q2_4264"] = "Il se peut que vous ayez simplement buté sur quelque chose qui pourrait intéresser le maréchal Windsor au plus haut point. Il reste peut-être encore un peu d'espoir, après tout…"
Lang["Q1_4282"] = "Un espoir en lambeaux"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4282
Lang["Q2_4282"] = "Rapporter les Informations égarées du maréchal Windsor.\n\nLe maréchal Windsor pense qu'ils sont détenus par le seigneur golem Argelmach et par le général Forgehargne."
Lang["Q1_4322"] = "Évasion !"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4322
Lang["Q2_4322"] = "Aider le maréchal Windsor à récupérer son équipement et à libérer ses amis. Ensuite, retourner voir le maréchal Maxwell."
Lang["Q1_6402"] = "Le rendez-vous à Hurlevent"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6402
Lang["Q2_6402"] = "Voyagez jusqu'à Hurlevent et rendez-vous aux portes de la ville. Parlez à l'écuyer Rowe, afin qu'il informe le maréchal Windsor de votre arrivée."
Lang["Q1_6403"] = "La grande mascarade"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6403
Lang["Q2_6403"] = "Suivre Reginald Windsor dans Hurlevent. Le protéger contre toute menace !"
Lang["Q1_6501"] = "L'Œil de dragon"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6501
Lang["Q2_6501"] = "Vous devez écumer le monde pour pouvoir rétablir le pouvoir du Fragment de l'Oeil de dragon. La seule information dont vous disposez à propos de cette chose, c’est qu’elle existe."
Lang["Q1_6502"] = "Amulette drakefeu"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6502
Lang["Q2_6502"] = "Récupérer le Sang du Champion des dragons noirs sur le général Drakkisath. Il se trouve dans sa salle du trône, derrière les Halls d'Ascension, sur le Pic Rochenoire."
Lang["Q1_7761"] = "Les ordres de Main-noire"			-- https://www.thegeekcrusade-serveur.com/db/?quest=7761
Lang["Q2_7761"] = "Cet orc est stupide. Il semble que vous deviez trouver un moyen d’obtenir la Marque de Drakkisath pour accéder à l’Orbe de commandement.\n\nD’après la lettre, la Marque est gardée par le général Drakkisath. Vous devriez peut-être enquêter."
Lang["Q1_9121"] = "Naxxramas, la citadelle de l'effroi"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9121
Lang["Q2_9121"] = "L'archimage Angela Dosantos à la chapelle de l'Espoir de Lumière dans les Maleterres de l'est veut 5 Cristaux des arcanes, 2 Cristaux de nexus, 1 Orbe de piété et 60 pièces d'or. Vous devez aussi être <Honoré/Honorée> auprès de l'Aube d'argent."
Lang["Q1_9122"] = "Naxxramas, la citadelle de l'effroi"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9122
Lang["Q2_9122"] = "L'archimage Angela Dosantos à la chapelle de l'Espoir de Lumière dans les Maleterres de l'est veut 2 Cristaux des arcanes, 1 Cristal de nexus et 30 pièces d'or. Vous devez aussi être <Révéré/Révérée> auprès de l'Aube d'argent."
Lang["Q1_9123"] = "Naxxramas, la citadelle de l'effroi"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9123
Lang["Q2_9123"] = "L'archimage Angela Dosantos à la chapelle de l'Espoir de Lumière dans les Maleterres de l'est vous accordera gratuitement l'Occultation arcanique. Vous devez être <Exalté/Exaltée> auprès de l'Aube d'argent."
Lang["Q1_8286"] = "Ce que demain apportera"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8286
Lang["Q2_8286"] = "Rendez-vous dans les Grottes du temps en Tanaris et trouvez Anachronos, la progéniture de Nozdormu."
Lang["Q1_8288"] = "Il ne peut y en avoir qu'un"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8288
Lang["Q2_8288"] = "Rapportez la Tête du seigneur des couvées Lanistaire à Baristolth des Sables changeants, au Fort cénarien en Silithus."
Lang["Q1_8301"] = "Le Chemin des Justes"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8301
Lang["Q2_8301"] = "Récupérez 200 Fragments de carapaces de silithides et retournez voir Baristolth."
Lang["Q1_8303"] = "Anachronos"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8303
Lang["Q2_8303"] = "Chercher Anachronos dans les Grottes du temps à Tanaris."
Lang["Q1_8305"] = "Des souvenirs oubliés depuis longtemps"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8305
Lang["Q2_8305"] = "Trouvez la Larme cristalline, en Silithus, et contemplez ses profondeurs."
Lang["Q1_8519"] = "Un pion sur l'Echiquier éternel"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8519
Lang["Q2_8519"] = "Apprenez tout ce que vous pouvez au sujet du passé, puis parlez à Anachronos dans les Grottes du temps à Tanaris."
Lang["Q1_8555"] = "Le fardeau des Vols draconiques"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8555
Lang["Q2_8555"] = "Eranikus, Vaelastrasz, et Azuregos... Vous avez certainement entendu parler de ces dragons, mortel. Ce n’est pas une simple coïncidence si chacun d’eux a joué un grand rôle comme gardien de ce monde.\n\nMalheureusement, et ma propre naïveté en est en partie responsable, ces gardiens ont tous succombé à de terribles tragédies, si terribles qu’elles ont alimenté ma méfiance à l’égard de votre espèce.\n\nCherchez-les… Et préparez-vous au pire"
Lang["Q1_8730"] = "La corruption de Nefarius"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8730
Lang["Q2_8730"] = "Tuez Nefarian pour récupérer le Fragment de sceptre rouge. Rapportez le Fragment de sceptre rouge à Anachronos aux Grottes du temps en Tanaris. Vous avez 5 heures pour accomplir cette tâche."
Lang["Q1_8733"] = "Eranikus, le tyran du Rêve"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8733
Lang["Q2_8733"] = "Rendez-vous sur Teldrassil et trouvez l’agent de Malfurion à l’extérieur des remparts de Darnassus."
Lang["Q1_8734"] = "Tyrande et Remulos"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8734
Lang["Q2_8734"] = "Rendez-vous à Reflet-de-Lune et parlez au gardien Remulos."
Lang["Q1_8735"] = "La corruption du Cauchemar"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8735
Lang["Q2_8735"] = "Rendez-vous aux quatre portails qui ouvrent sur le Rêve d’Emeraude et récupérez un Fragment de la corruption du Cauchemar auprès de chacun d’eux. Lorsque vous aurez terminé, retournez voir le Gardien Remulos à Reflet-de-Lune."
Lang["Q1_8736"] = "Le Cauchemar se manifeste"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8736
Lang["Q2_8736"] = "Défendre Havrenuit d’Eranikus. Le Gardien Remulos ne doit pas mourir. Eranikus non plus. Défendez-vous. Attendez Tyrande."
Lang["Q1_8741"] = "Le retour du champion"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8741
Lang["Q2_8741"] = "Apporter le Fragment de sceptre vert à Anachronos dans les Grottes du Temps de Tanaris."
Lang["Q1_8575"] = "Le grand livre magique d'Azuregos"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8575
Lang["Q2_8575"] = "Apporter le Grand livre magique d'Azuregos à Narain Soothfancy, en Tanaris."
Lang["Q1_8576"] = "La traduction du grand livre"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8576
Lang["Q2_8576"] = "Tout d'abord nous devons comprendre ce qu'Azuregos a écrit dans son livre.\n\nIl vous a dit de faire une Bouée en arcanite dont voici les plans? Etrange que tout soit écrit en draconique. Je n'y comprends rien.\n\nPour que ca marche il va me falloir mes lunettes de divination, un poulet de 500 livres et le volume II de 'Le draconique pour les nuls'. Pas forcément dans cet ordre."
Lang["Q1_8597"] = "Le draconique pour les nuls"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8597
Lang["Q2_8597"] = "Retrouver le livre de Narain Divinambolesque, enfoui sur une île des mers du Sud."
Lang["Q1_8599"] = "Une chanson d'amour pour Narain"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8599
Lang["Q2_8599"] = "Transmettre la Lettre d’amour de Meredith à Narain Divinambolesque, en Tanaris."
Lang["Q1_8598"] = "rANçOn !"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8598
Lang["Q2_8598"] = "Ramener la Demande de rançon a Narain Divinambolesque, en Tanaris."
Lang["Q1_8606"] = "Un leurre !"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8606
Lang["Q2_8606"] = "Narain Divinambolesque, en Tanaris, veut que vous vous rendiez au Berceau-de-l’hiver et que vous posiez le Sac d'or à l’endroit indiqué par les voleurs de livres."
Lang["Q1_8620"] = "Le seul remède"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8620
Lang["Q2_8620"] = "Retrouver les 8 chapitres perdus du 'Draconique pour les nuls' et les combiner avec la Reliure magique, puis ramener l’exemplaire réparé du 'Draconique pour les nuls, volume II' à Narain Divinambolesque, en Tanaris."
Lang["Q1_8584"] = "On ne parle jamais de mon boulot"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8584
Lang["Q2_8584"] = "Narain Divinambolesque de Tanaris veut que vous parliez à Dirge Hachillico à Gadgetzan."
Lang["Q1_8585"] = "L'île de l'effroi !"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8585
Lang["Q2_8585"] = "Récupérer la Carcasse de Lakmaeran et 20 Filets de chimaerok pour Dirge Hachillico, en Tanaris."
Lang["Q1_8586"] = "Pyro-côtelettes de chimaerok à la Dirge"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8586
Lang["Q2_8586"] = "Dirge Hachillico, de Gadgetzan, veut que vous lui rameniez 20 doses de Carburant de fusée gobelin et 20 doses de Sel de Fonderoc."
Lang["Q1_8587"] = "Retour vers Narain"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8587
Lang["Q2_8587"] = "Remettre le Poulet de 500 livres à Narain Divinambolesque à Tanaris."
Lang["Q1_8577"] = "Stewvul, ex-M.A.P.V."			-- https://www.thegeekcrusade-serveur.com/db/?quest=8577
Lang["Q2_8577"] = "Narain Divinambolesque veut que vous retrouviez son ex-meilleur ami pour la vie (M.A.P.V.), Stewvul, et que vous repreniez les lunettes de divination que Stewvul lui a volé."
Lang["Q1_8578"] = "Des lunettes d'observation ? Aucun problème !"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8578
Lang["Q2_8578"] = "Retrouver les Lunettes de divination de Narain et les rapporter à Narain Divinambolesque en Tanaris."
Lang["Q1_8728"] = "La bonne nouvelle et la mauvaise nouvelle"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8728
Lang["Q2_8728"] = "Narain Divinambolesque, en Tanaris, veut que vous lui apportiez 20 Barres d’arcanite, 10 Minerais d’élémentium, 10 Diamants d’Azeorth et 10 Saphirs bleus"
Lang["Q1_8729"] = "Le courroux de Neptulon"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8729
Lang["Q2_8729"] = "Utilisez la Bouée d’arcanite au Maelström tourbillonnant dans la Baie des tempêtes en Azshara."
Lang["Q1_8742"] = "La puissance de Kalimdor"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8742
Lang["Q2_8742"] = "Devant moi se tient la personne qui va guider son peuple vers une nouvelle ère.\n\nL'Ancien Dieu tremble. Oh oui, il a peur de votre foi. Brisez la prophétie de C'Thun.\n\nIl sait que vous venez, champion - et avec vous toute la puissance de Kalimdor. Dites moi quand vous êtes prêt et je vous donnerai le Sceptre des Sables changeants."
Lang["Q1_8745"] = "Le trésor de l'Intemporel"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8745
Lang["Q2_8745"] = "Bienvenue, champion. Je suis Jonathan, gardien du gong sacré.\n\nL'Intemporel m'a donné le pouvoir de vous récompenser avec un objet de son trésor éternel. Qu'il vous aide dans votre lutte contre C'Thun."


-- QUESTS - TBC
Lang["Q1_10755"] = "L'entrée dans la citadelle"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10755
Lang["Q2_10755"] = "Apportez le Moule à clé préparé à Nazgrel, à Thrallmar dans la péninsule des Flammes infernales."
Lang["Q1_10756"] = "Le grand maître Rohok"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10756
Lang["Q2_10756"] = "Apportez le Moule à clé préparé à Rohok à Thrallmar."
Lang["Q1_10757"] = "La demande de Rohok"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10757
Lang["Q2_10757"] = "Apportez 4 Barres de gangrefer, 2 Poussières des arcanes et 4 Granules de feu à Rohok à Thrallmar dans la péninsule des Flammes infernales."
Lang["Q1_10758"] = "Plus chaud que l'enfer"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10758
Lang["Q2_10758"] = "Détruisez un Saccageur gangrené dans la péninsule des Flammes infernales et plongez le Moule à clé inachevé dans ce qu'il en reste. Apportez le Moule à clé carbonisé à Rohok à Thrallmar."
Lang["Q1_10754"] = "L'entrée dans la citadelle"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10754
Lang["Q2_10754"] = "Apportez le Moule à clé préparé au commandant de corps Danath au bastion de l'Honneur dans la péninsule des Flammes infernales."
Lang["Q1_10762"] = "Le grand maître Dumphry"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10762
Lang["Q2_10762"] = "Apportez le Moule à clé préparé à Dumphry au bastion de l'Honneur."
Lang["Q1_10763"] = "La demande de Dumphry"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10763
Lang["Q2_10763"] = "Apportez 4 Barres de gangrefer, 2 Poussières des arcanes et 4 Granules de feu à Dumphry au bastion de l'Honneur dans la péninsule des Flammes infernales."
Lang["Q1_10764"] = "Plus chaud que l'enfer"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10764
Lang["Q2_10764"] = "Détruisez un Saccageur gangrené dans la péninsule des Flammes infernales et plongez le Moule à clé inachevé dans ce qu'il en reste. Apportez le Moule à clé carbonisé à Dumphry au bastion de l'Honneur."
Lang["Q1_10279"] = "Dans le repaire du maîtrer"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10279
Lang["Q2_10279"] = "Parlez à Andormu dans les Grottes du temps."
Lang["Q1_10277"] = "Les Grottes du temps"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10277
Lang["Q2_10277"] = "Andormu vous demande de suivre la Protectrice du temps dans les Grottes du temps."
Lang["Q1_10282"] = "Hautebrande d'antan"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10282
Lang["Q2_10282"] = "Andormu des Grottes du temps vous demande de vous aventurer dans le Hautebrande d'antan et d'aller voir Erozion."
Lang["Q1_10283"] = "La diversion de Taretha"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10283
Lang["Q2_10283"] = "Rendez-vous au bastion de Fort-de-Durn et placez 5 charges incendiaires dans les tonneaux situés dans chacun des pavillons d'internement grâce au Paquet de bombes incendiaires qui vous a été donné par Erozion.\n\nParlez à Thrall dans les oubliettes du bastion de Fort-de-Durn une fois les Pavillons d'internement incendiés."
Lang["Q1_10284"] = "Évasion de Fort-de-Durn"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10284
Lang["Q2_10284"] = "Faites signe à Thrall lorsque vous serez <prêt/prête> à continuer. Suivez-le dans son évasion du bastion de Fort-de-Durn et aidez-le à libérer Taretha et à accomplir son destin.\n\nAllez parler à Erozion au Hautebrande d'antan si vous parvenez à accomplir cette tâche."
Lang["Q1_10285"] = "Retour vers Andormu"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10285
Lang["Q2_10285"] = "Retournez voir le jeune dragon, Andormu, aux Grottes du temps dans le désert de Tanaris."
Lang["Q1_10265"] = "La collection de cristaux du Consortium"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10265
Lang["Q2_10265"] = "Procurez-vous un artefact cristallin d'Arklon et rapportez-le au traqueur-du-Néant Khay'ji à la Zone 52 au Raz-de-Néant."
Lang["Q1_10262"] = "Un monceau d'éthériens"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10262
Lang["Q2_10262"] = "Collectez 10 Insignes de Zaxxis et et apportez-les au Traqueur-du-Néant Khay'ji dans la Zone 52 de Raz-de-Néant."
Lang["Q1_10205"] = "L'écumeur-dimensionnel Nesaad"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10205
Lang["Q2_10205"] = "Tuez l'Écumeur-dimensionnel Nesaad, puis retournez voir le traqueur-du-Néant Khay'ji dans la Zone 52 de Raz-de-Néant."
Lang["Q1_10266"] = "Demande d'assistance"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10266
Lang["Q2_10266"] = "Trouvez Gahruj et proposez-lui vos services. Il se trouve au comptoir des Terres-médianes dans l'Écodôme Terres-médianes au Raz-de-Néant."
Lang["Q1_10267"] = "Récupérer ce qui nous revient de droit"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10267
Lang["Q2_10267"] = "Récupérez 10 Boîtes d'équipement topographique et rapportez-les à Gahruj au comptoir des Terres-médianes dans l'Écodôme Terres-médianes au Raz-de-Néant."
Lang["Q1_10268"] = "Une audience avec le prince"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10268
Lang["Q2_10268"] = "Remettez l'Équipement topographique à l'image du prince-nexus Haramad à la Foudreflèche au Raz-de-Néant."
Lang["Q1_10269"] = "Point de triangulation numéro un"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10269
Lang["Q2_10269"] = "Utilisez l'Appareil de triangulation pour vous indiquer la direction du premier point de triangulation. Une fois que vous l'aurez trouvé, donnez-en l'emplacement au camelot Hazzin au poste de garde du Protectorat dans l'île de la manaforge Ultris au Raz-de-Néant."
Lang["Q1_10275"] = "Point de triangulation numéro deux"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10275
Lang["Q2_10275"] = "Utilisez l'Appareil de triangulation pour vous indiquer la direction du deuxième point de triangulation. Une fois que vous l'aurez trouvé, donnez-en l'emplacement au marchand des vents Tuluman au Point d'ancrage de Tuluman, juste de l'autre côté du pont vers l'île de la manaforge Ara au Raz-de-Néant."
Lang["Q1_10276"] = "Le triangle est triangulé"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10276
Lang["Q2_10276"] = "Récupérez le Cristal d'Ata'mal et rapportez-le à l'image du prince-nexus Haramad à la Foudreflèche au Raz-de-Néant."
Lang["Q1_10280"] = "Livraison spéciale à Shattrath"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10280
Lang["Q2_10280"] = "Apportez le cristal d'Ata'mal à A'dal sur la Terrasse de la Lumière à Shattrath."
Lang["Q1_10704"] = "Comment pénétrer dans l'Arcatraz"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10704
Lang["Q2_10704"] = "A'dal vous a <chargé/chargée> de récupérer les Pièces supérieures et inférieures de la clé de l'Arcatraz. Rapportez-les-lui et il s'en servira pour vous confectionner la Clé de l'Arcatraz."
Lang["Q1_9824"] = "Troubles arcaniques"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9824
Lang["Q2_9824"] = "Vous avez été <chargé/chargée> d'aller sur le satellite d'Arcatraz du donjon de la Tempête et de tuer le Messager Cieuriss. Revenez voir A'dal à la Terrasse de la Lumière de Shattrath quand ce sera fait."
Lang["Q1_9825"] = "L’agitation des sans-repos"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9825
Lang["Q2_9825"] = "Apportez 10 Essences fantomatiques à l’Archimage Alturus, à l’extérieur de Karazhan."
Lang["Q1_9826"] = "Un envoyé de Dalaran"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9826
Lang["Q2_9826"] = "Apportez le Rapport d’Alturus à l’Archimage Cédric, à la périphérie du Cratère de Dalaran."
Lang["Q1_9829"] = "Khadgar"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9829
Lang["Q2_9829"] = "Remettez le Rapport d’Alturus à Khadgar, à Shattrath dans la forêt de Terokkar."
Lang["Q1_9831"] = "L'entrée de Karazhan	"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9831
Lang["Q2_9831"] = "Khadgar veut que vous entriez dans le Labyrinthe des ombres d'Auchindoun pour récupérer le Premier fragment de la clé, dans le Récipient arcanique qui y est caché."
Lang["Q1_9832"] = "Le deuxième et le troisième fragments"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9832
Lang["Q2_9832"] = "Trouver le Deuxième fragment de la clé dans un récipient arcanique à l’intérieur du Réservoir de Glissecroc, et le Troisième fragment de la clé dans un récipient arcanique au Donjon de la tempête. Une fois que ce sera fait, revenir auprès de Khadgar à Shattrath."
Lang["Q1_9836"] = "Le toucher du maître"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9836
Lang["Q2_9836"] = "Rendez-vous aux Grottes du temps et persuadez Medivh d’accepter votre Clé de l’apprenti réparée."
Lang["Q1_9837"] = "Retour vers Khadgar"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9837
Lang["Q2_9837"] = "Retournez voir Khadgar à Shattrath, et montrez-lui à la Clé du maître."
Lang["Q1_9838"] = "L’Œil pourpre"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9838
Lang["Q2_9838"] = "Parlez à l'archimage Alturus à l'extérieur de Karazhan."
Lang["Q1_9630"] = "Le journal de Medivh"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9630
Lang["Q2_9630"] = "L’archimage Alturus, du défilé de Deuillevent, veut que vous entriez dans Karazhan et que vous parliez à Wravien."
Lang["Q1_9638"] = "En de bonnes mains"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9638
Lang["Q2_9638"] = "Parler avec Gradav dans la Bibliothèque du gardien, à Karazhan."
Lang["Q1_9639"] = "Kamsis"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9639
Lang["Q2_9639"] = "Parler avec Kamsis dans la Bibliothèque du gardien, à Karazhan."
Lang["Q1_9640"] = "L'ombre d'Aran"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9640
Lang["Q2_9640"] = "Obtenez le Journal de Medivh et retournez voir Kamsis dans la Bibliothèque du Gardien de Karazhan."
Lang["Q1_9645"] = "La terrasse du Maître"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9645
Lang["Q2_9645"] = "Allez sur la terrasse du Maître à Karazhan et lisez le Journal de Medivh. Retournez auprès de l'archimage Alturus avec le Journal de Medivh lorsque vous aurez accompli cette tâche."
Lang["Q1_9680"] = "Exhumer le passé"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9680
Lang["Q2_9680"] = "L'archimage Alturus veut que vous vous rendiez dans les montagnes au sud de Karazhan dans le défilé de Deuillevent et que vous y récupériez un Fragment d'os carbonisé."
Lang["Q1_9631"] = "L'aide d'une collègue"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9631
Lang["Q2_9631"] = "Remettez le Fragment d'os carbonisé à Kalynna Rougelatte, dans la Zone 52 de Raz-de-Néant."
Lang["Q1_9637"] = "La requête de Kalynna"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9637
Lang["Q2_9637"] = "Kalynna Rougelatte veut que vous récupériez le Tome du crépuscule sur le Grand démoniste Néanathème dans la citadelle des Flammes infernales, et le Livre des noms oubliés sur le Tisseur d'ombre Syth dans les salles des Sethekk à Auchindoun."
Lang["Q1_9644"] = "Plaie-de-nuit"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9644
Lang["Q2_9644"] = "Allez sur la Terrasse du Maître à Karazhan et utilisez l'Urne de Kalynna pour invoquer Plaie-de-nuit. Récupérez l'Essence arcanique voilée sur le cadavre de Plaie-de-nuit et rapportez-la à l'archimage Alturus."
Lang["Q1_10901|13431"] = "Le gourdin de Kar'desh"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10901|13431
Lang["Q2_10901|13431"] = "Skar’this l’Hérétique, dans les Enclos aux esclaves héroïques du Réservoir de Glissecroc, veut que vous lui apportiez la Chevalière terrestre et la Chevalière flamboyante."
Lang["Q1_10900"] = "La marque de Vashj"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10900
Lang["Q2_10900"] = ""
Lang["Q1_10681"] = "La main de Gul'dan"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10681
Lang["Q2_10681"] = "Parlez au soigneterre Torlok à l'Autel de la damnation dans la vallée d'Ombrelune."
Lang["Q1_10458"] = "Esprits de feu et de terre enragés"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10458
Lang["Q2_10458"] = "Le soigneterre Torlok à l'Autel de la damnation dans la vallée d'Ombrelune veut que vous utilisiez le Totem des esprits pour capturer 8 Âmes terrestres et 8 Âmes flamboyantes."
Lang["Q1_10480"] = "Esprits des eaux enragés"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10480
Lang["Q2_10480"] = "Le soigneterre Torlok à l'Autel de la damnation dans la vallée d'Ombrelune veut que vous utilisiez le Totem des esprits pour capturer 5 Âmes aquatiques."
Lang["Q1_10481"] = "Esprits des airs enragés"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10481
Lang["Q2_10481"] = "Le soigneterre Torlok à l'Autel de la damnation dans la vallée d'Ombrelune veut que vous utilisiez le Totem des esprits pour capturer 10 Âmes aériennes."
Lang["Q1_10513"] = "Oronok Cœur-fendu"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10513
Lang["Q2_10513"] = "Partez à la recherche d’Oronok Cœur-fendu sur la Saillie brisée, au nord de la Citerne de Glissentaille."
Lang["Q1_10514"] = "J'ai tenu bien des rôles…"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10514
Lang["Q2_10514"] = "Oronok Cœur-fendu, à la Ferme d'Oronok dans la vallée d'Ombrelune, veut que vous ramassiez 10 Tubercules d'Ombrelune dans les Plaines brisées.\n\nIl vous demande aussi de rapporter le Sifflet à sanglier d'Oronok lorsque vous aurez terminé."
Lang["Q1_10515"] = "Une leçon bien apprise"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10515
Lang["Q2_10515"] = "Oronok Cœur-fendu, à la Ferme d'Oronok dans la vallée d'Ombrelune, veut que vous détruisiez 10 Œufs d'écorcheurs voraces dans les Plaines brisées."
Lang["Q1_10519"] = "La Formule de damnation - vérité et histoire"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10519
Lang["Q2_10519"] = "Oronok Cœur-fendu à la ferme d'Oronok dans la vallée d'Ombrelune veut que vous écoutiez son histoire. Parlez à Oronok pour commencer à écouter son histoire."
Lang["Q1_10521"] = "Grom'tor, fils d'Oronok"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10521
Lang["Q2_10521"] = "Trouvez Grom'tor, fils d'Oronok à la Halte de Glissentaille dans la vallée d'Ombrelune."
Lang["Q1_10527"] = "Ar'tor, fils d'Oronok"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10527
Lang["Q2_10527"] = "Trouvez Ar'tor, fils d'Oronok à la Halte Illidari dans la vallée d'Ombrelune."
Lang["Q1_10546"] = "Borak, fils d'Oronok"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10546
Lang["Q2_10546"] = "Trouvez Borak, fils d'Oronok près de la Halte de l'éclipse dans la vallée d'Ombrelune."
Lang["Q1_10522"] = "La Formule de damnation - la charge de Grom'tor"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10522
Lang["Q2_10522"] = "Grom'tor, fils d'Oronok, de la Halte de Glissentaille dans la vallée d'Ombrelune, veut que vous récupériez le Premier fragment de la Formule de damnation."
Lang["Q1_10528"] = "Prisons de cristal démoniaque"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10528
Lang["Q2_10528"] = "Trouvez la Maîtresse de la douleur Gabrissa à la Halte Illidari et tuez-la, puis rapportez le cadavre d'Ar'tor, fils d'Oronok avec la Clé cristalline."
Lang["Q1_10547"] = "Des chardonomanes et des œufs"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10547
Lang["Q2_10547"] = "Borak, fils d'Oronok, sur le pont au nord de la Halte de l'éclipse, veut que vous trouviez un Œuf d'arakkoa pourri et que vous l'apportiez à Tobias le Goinfre-crasse à Shattrath, qui se trouve au nord-ouest de la forêt de Terokkar."
Lang["Q1_10523"] = "La Formule de damnation - Premier fragment retrouvé"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10523
Lang["Q2_10523"] = "Apportez le coffret de Grom'tor à Oronok Cœur-fendu à la Ferme d'Oronok dans la vallée d'Ombrelune."
Lang["Q1_10537"] = "Lohn'goron, arc du Cœur-fendu"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10537
Lang["Q2_10537"] = "L'Esprit d'Ar'tor à la Halte Illidari dans la vallée d'Ombrelune veut que vous repreniez Lohn'goron, arc du Cœur-fendu aux démons de la région."
Lang["Q1_10550"] = "Le fagot de chardons sanglants"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10550
Lang["Q2_10550"] = "Rapportez le Fagot de chardons sanglants à Borak, fils d'Oronok sur le pont près de la Halte de l'éclipse dans la vallée d'Ombrelune."
Lang["Q1_10540"] = "La Formule de damnation - la charge d'Ar'tor"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10540
Lang["Q2_10540"] = "L'Esprit d'Ar'tor à la Halte Illidari dans la vallée d'Ombrelune veut que vous récupériez le Second fragment de la formule de damnation sur Veneratus le Multiple."
Lang["Q1_10570"] = "Pour une poignée de chardons"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10570
Lang["Q2_10570"] = "Borak, fils d'Oronok, du pont qui se trouve près de la halte de l'Éclipse dans la vallée d'Ombrelune, vous demande de récupérer la Missive de Hurlorage."
Lang["Q1_10576"] = "Le bonneteau d'Ombrelune"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10576
Lang["Q2_10576"] = "Borak, fils d'Oronok, du pont qui se trouve près de la halte de l'Éclipse dans la vallée d'Ombrelune, vous demande de récupérer 6 pièces d'Armure éclipsion."
Lang["Q1_10577"] = "Ce qu'Illidan veut, Illidan l'obtient…"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10577
Lang["Q2_10577"] = "Borak, fils d'Oronok, du pont qui se trouve près de la halte de l'Éclipse dans la vallée d'Ombrelune, vous demande de remettre le message d'Illidan au grand commandant Ruusk à la halte de l'Éclipse."
Lang["Q1_10578"] = "La Formule de damnation - la charge de Borak"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10578
Lang["Q2_10578"] = "Borak, fils d'Oronok, du pont qui se trouve près de la halte de l'Éclipse dans la vallée d'Ombrelune, vous demande de prendre la Troisième partie de la formule de damnation à Ruul l'Assombrisseur."
Lang["Q1_10541"] = "La Formule de damnation - Second fragment retrouvé"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10541
Lang["Q2_10541"] = "Apportez le Coffret d'Ar'tor à Oronok Cœur-fendu à la Ferme d'Oronok dans la vallée d'Ombrelune."
Lang["Q1_10579"] = "La Formule de damnation - Troisième fragment retrouvé"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10579
Lang["Q2_10579"] = "Apportez le coffret de Borak à Oronok Cœur-fendu à la Ferme d'Oronok dans la vallée d'Ombrelune."
Lang["Q1_10588"] = "La Formule de damnation"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10588
Lang["Q2_10588"] = "Utilisez la Formule de damnation à l'Autel de la damnation pour invoquer Cyrukh le Seigneur du feu.\n\nDétruisez Cyrukh le Seigneur du feu puis parlez au Soigneterre Torlok, qui se trouve aussi à l'Autel de la damnation."
Lang["Q1_10883"] = "La clé de la Tempête"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10883
Lang["Q2_10883"] = "Parlez à A'dal à Shattrath."
Lang["Q1_10884"] = "L'épreuve des naaru : Miséricorde"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10884
Lang["Q2_10884"] = "A'dal de Shattrath vous demande de prendre la Hache inutilisée du bourreau dans les Salles Brisées de la citadelle des Flammes infernales.\n\nCette quête doit être accomplie en mode de difficulté du donjon Héroïque."
Lang["Q1_10885"] = "L'épreuve des naaru : Force"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10885
Lang["Q2_10885"] = "A'dal de Shattrath vous demande de récupérer le Trident de Kalithresh et l'Essence de Marmon.\n\nCette quête doit être accomplie en mode de difficulté du donjon Héroïque."
Lang["Q1_10886"] = "L'épreuve des naaru : Ténacité"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10886
Lang["Q2_10886"] = "A'dal de Shattrath vous demande de sauver Milhouse Tempête-de-mana de l'Arcatraz du donjon de la Tempête.\n\nCette quête doit être accomplie en mode de difficulté du donjon Héroïque."
Lang["Q1_10888|13430"] = "L'épreuve des naaru : Magtheridon"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10888|13430
Lang["Q2_10888|13430"] = "A'dal de Shattrath vous demande de tuer Magtheridon."
Lang["Q1_10680"] = "La main de Gul'dan"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10680
Lang["Q2_10680"] = "Parlez au soigneterre Torlok à l'Autel de la damnation dans la vallée d'Ombrelune."
Lang["Q1_10445|13432"] = "Les fioles d'éternité"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10445|13432
Lang["Q2_10445|13432"] = "Soridormi aux Grottes du temps vous demande de récupérer le Reste de la fiole de Vashj auprès de Dame Vashj au réservoir de Glissecroc et le Reste de la fiole de Kael auprès de Kael'thas Haut-soleil au donjon de la Tempête."
Lang["Q1_10568"] = "Tablettes de Baa'ri"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10568
Lang["Q2_10568"] = "L'anachorète Ceyla de l'Autel de Sha'tar veut que vous collectiez 12 Tablettes baa'ri sur le sol et sur les Ouvriers cendrelangue aux Ruines de Baa'ri.\n\nAccomplir des quêtes pour l'Aldor fera baisser votre réputation auprès des Clairvoyants."
Lang["Q1_10683"] = "Tablettes de Baa'ri"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10683
Lang["Q2_10683"] = "L'arcaniste Thelis du Sanctum des Étoiles veut que vous collectiez 12 Tablettes baa'ri aux Ruines de Baa'ri.\n\nAccomplir des quêtes pour les Clairvoyants fera baisser votre réputation auprès de l'Aldor."
Lang["Q1_10571"] = "Oronu l'Ancien"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10571
Lang["Q2_10571"] = "L'anachorète Ceyla de l'Autel de Sha'tar veut que vous vous procuriez les Ordres d'Akama sur Oronu l'Ancien aux Ruines de Baa'ri.\n\nAccomplir des quêtes pour l'Aldor fera baisser votre réputation auprès des Clairvoyants."
Lang["Q1_10684"] = "Oronu l'Ancien"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10684
Lang["Q2_10684"] = "L'arcaniste Thelis du Sanctum des Étoiles veut que vous preniez les Ordres d'Akama à Oronu l'Ancien aux Ruines de Baa'ri.\n\nAccomplir des quêtes pour les Clairvoyants fera baisser votre réputation auprès de l'Aldor."
Lang["Q1_10574"] = "Les corrupteurs cendrelangue"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10574
Lang["Q2_10574"] = "Procurez-vous les quatre fragments du médaillon sur Haalum, Eykenen, Lakaan et Uylaru et rapportez-les à l'anachorète Ceyla à l'Autel de Sha'tar dans la vallée d'Ombrelune.\n\nAccomplir des quêtes pour l'Aldor fera baisser votre réputation auprès des Clairvoyants."
Lang["Q1_10685"] = "Les corrupteurs cendrelangue"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10685
Lang["Q2_10685"] = "Procurez-vous les quatre fragments du médaillon sur Haalum, Eykenen, Lakaan et Uylaru et rapportez-les à l'arcaniste Thelis au Sanctum des Étoiles dans la vallée d'Ombrelune.\n\nAccomplir des quêtes pour les Clairvoyants fera baisser votre réputation auprès de l'Aldor."
Lang["Q1_10575"] = "La Cage de la gardienne"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10575
Lang["Q2_10575"] = "L'anachorète Ceyla veut que vous entriez dans la Cage de la gardienne, au sud des ruines de Baa'ri, et que vous interrogiez Sanoru pour apprendre où se trouve Akama.\n\nAccomplir des quêtes pour l'Aldor fera baisser votre réputation auprès des Clairvoyants."
Lang["Q1_10686"] = "La Cage de la gardienne"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10686
Lang["Q2_10686"] = "L'arcaniste Thelis veut que vous entriez dans la Cage de la gardienne, au sud des ruines de Baa'ri, et que vous interrogiez Sanoru pour apprendre où se trouve Akama.\n\nAccomplir des quêtes pour les Clairvoyants fera baisser votre réputation auprès de l'Aldor."
Lang["Q1_10622"] = "Preuve d'allégeance"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10622
Lang["Q2_10622"] = "Tuez Zandras à la Cage de la gardienne dans la vallée d'Ombrelune et retournez voir Sanoru."
Lang["Q1_10628"] = "Akama"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10628
Lang["Q2_10628"] = "Parler à Akama à l'intérieur de la chambre cachée de la Cage de la gardienne."
Lang["Q1_10705"] = "Le voyant Udalo"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10705
Lang["Q2_10705"] = "Trouvez le voyant Udalo à l'intérieur de l'Arcatraz dans le Donjon de la Tempête."
Lang["Q1_10706"] = "Un mystérieux présage"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10706
Lang["Q2_10706"] = "Retournez voir Akama à la Cage de la gardienne dans la vallée d'Ombrelune."
Lang["Q1_10707"] = "La terrasse ata'mal"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10707
Lang["Q2_10707"] = "Allez au sommet de la Terrasse Ata'mal dans la vallée d’Ombrelune, et procurez-vous le Cœur de fureur. Retournez voir Akama à la Cage de la gardienne dans la vallée d'Ombrelune quand vous aurez accompli cette tâche."
Lang["Q1_10708"] = "La promesse d'Akama"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10708
Lang["Q2_10708"] = "Apportez le Médaillon de Karabor à A'dal, à Shattrath."
Lang["Q1_10944"] = "Un secret compromis"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10944
Lang["Q2_10944"] = "Allez à la Cage de la gardienne dans la vallée d'Ombrelune et parlez avec Akama."
Lang["Q1_10946"] = "La ruse des Cendrelangues"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10946
Lang["Q2_10946"] = "Pénétrez dans le Donjon de la Tempête et tuez Al'ar en portant la Capuche de cendrelangue. Retournez voir Akama dans la vallée d'Ombrelune une fois que ce sera fait."
Lang["Q1_10947"] = "Un artefact du passé"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10947
Lang["Q2_10947"] = "Allez aux Grottes du temps en Tanaris, et rendez-vous à la Bataille du mont Hyjal. Quand vous y serez, triomphez de Rage Froidhiver et rapportez le Phylactère chronophasé à Akama dans la vallée d'Ombrelune."
Lang["Q1_10948"] = "L'âme otage"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10948
Lang["Q2_10948"] = "Rendez-vous à Shattrath pour soumettre la requête d'Akama à A'dal."
Lang["Q1_10949"] = "L'entrée dans le Temple Noir"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10949
Lang["Q2_10949"] = "Rendez-vous à l'entrée du Temple Noir dans la vallée d'Ombrelune et allez parler à Xi'ri."
Lang["Q1_10985|13429"] = "Une distraction pour Akama"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10985|13429
Lang["Q2_10985|13429"] = "Assurez-vous qu'Akama et Maiev pénètrent bien dans le Temple Noir de la Vallée d'Ombrelune une fois que les forces de Xi'ri auront fait diversion."
--v243
Lang["Q1_10984"] = "Parler avec l'ogre"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10984
Lang["Q2_10984"] = "Allez voir l'Ogre, Grok, dans le quartier de la Ville basse de Shattrath."
Lang["Q1_10983"] = "Mog'dorg le Ratatiné"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10983
Lang["Q2_10983"] = "Allez voir Mog'dorg le Ratatiné au sommet de l'une des tours qui se trouvent devant le Cercle de sang dans les Tranchantes."
Lang["Q1_10995"] = "Grulloc a deux crânes"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10995
Lang["Q2_10995"] = "Emparez-vous du Crâne de dragon de Grulloc et apportez-le à Mog'dorg le Ratatiné au sommet de la tour du Cercle de sang dans les Tranchantes."
Lang["Q1_10996"] = "Le coffre au trésor de Maggoc"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10996
Lang["Q2_10996"] = "Emparez-vous du Coffre au trésor de Maggoc et apportez-le à Mog'dorg le Ratatiné au sommet de la tour du Cercle de sang dans les Tranchantes."
Lang["Q1_10997"] = "L'étendard et la manière"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10997
Lang["Q2_10997"] = "Emparez-vous de l'Étendard de Skori et apportez-le à Mog'dorg le Ratatiné au sommet de la tour du Cercle de sang dans les Tranchantes."
Lang["Q1_10998"] = "Le tome de sa voix"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10998
Lang["Q2_10998"] = "Emparez-vous du Grimoire infâme de Vim'gol et apportez-le à Mog'dorg le Ratatiné, au sommet de la tour du Cercle de sang, dans les Tranchantes."
Lang["Q1_11000"] = "Face au Broyeur-d'âme"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11000
Lang["Q2_11000"] = "Récupérez l'Âme de Crânoc et remettez-la à Mog'dorg le Ratatiné au sommet de la tour au Cercle de sang dans les Tranchantes."
Lang["Q1_11022"] = "Parler à Mog'dorg"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11022
Lang["Q2_11022"] = "Allez parler à Mog'dorg le Ratatiné. Il se trouve au sommet de la tour située du côté est du Cercle de sang dans les Tranchantes."
Lang["Q1_11009"] = "Le paradis des ogres"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11009
Lang["Q2_11009"] = "Mog'dorg le Ratatiné vous demande d'aller parler à Chu'a'lor à Ogri'la dans les Tranchantes."
--v244
Lang["Q1_10804"] = "Un peu de gentillesse"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10804
Lang["Q2_10804"] = "Mordenai, aux champs de l'Aile-du-Néant, dans la vallée d'Ombrelune, veut que vous nourrissiez 8 Drakes Aile-du-Néant adultes."
Lang["Q1_10811"] = "Trouvez Neltharaku"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10811
Lang["Q2_10811"] = "Partez à la recherche de Neltharaku, le protecteur du Vol de l'Aile-du-Néant."
Lang["Q1_10814"] = "L'histoire de Neltharaku"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10814
Lang["Q2_10814"] = "Parlez à Neltharaku et écoutez son histoire."
Lang["Q1_10836"] = "Infiltrer la forteresse Gueule-de-dragon"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10836
Lang["Q2_10836"] = "Neltharaku, qui vole au-dessus des Champs de l'Aile-du-Néant dans la Vallée d'Ombrelune, veut que vous tuiez 15 Orcs Gueule-de-dragon."
Lang["Q1_10837"] = "Vers l'escarpement de l'Aile-du-Néant !"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10837
Lang["Q2_10837"] = "Neltharaku, qui vole au-dessus des champs de l'Aile-du-Néant dans la vallée d'Ombrelune, veut que vous ramassiez 12 cristaux vignéants à l'escarpement de l'Aile-du-Néant."
Lang["Q1_10854"] = "La force de Neltharaku"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10854
Lang["Q2_10854"] = "Neltharaku, qui vole au-dessus des champs de l'Aile-du-Néant dans la vallée d'Ombrelune, veut que vous libériez 5 Drakes de l'Aile-du-Néant asservis."
Lang["Q1_10858"] = "Karynaku"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10858
Lang["Q2_10858"] = "Trouvez Karynaku à la Forteresse Gueule-de-dragon."
Lang["Q1_10866"] = "Zuluhed le Fourbu"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10866
Lang["Q2_10866"] = "Tuez Zuluhed le Fourbu et récupérez la Clé de Zuluhed. Utilisez-la sur les Chaînes de Zuluhed pour libérer Karynaku."
Lang["Q1_10870"] = "Allié du vol du Néant"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10870
Lang["Q2_10870"] = "Permettez à Karynaku de vous ramener auprès de Mordenai dans les Champs de l'Aile-du-Néant."
--v247
Lang["Q1_3801"] = "Héritage Sombrefer"			-- https://www.thegeekcrusade-serveur.com/db/?quest=3801
Lang["Q2_3801"] = "Parler à Franclorn Forgewright si obtenir une clé de la Cité majeure vous intéresse."
Lang["Q1_3802"] = "Héritage Sombrefer"			-- https://www.thegeekcrusade-serveur.com/db/?quest=3802
Lang["Q2_3802"] = "Tuer Fineous Darkvire et récupérer le grand marteau, Souillefer. Apporter Souillefer au sanctuaire de Thaurissan et le placer sur la statue de Franclorn Forgewright."
Lang["Q1_5096"] = "Diversions écarlates"
Lang["Q2_5096"] = "Se rendre au camp de base de la Croisade écarlate situé entre le Champ de Felstone et les Larmes de Dalson et détruire leur tente d’état-major."
Lang["Q1_5098"] = "Tout au long des tours de guet"
Lang["Q2_5098"] = "À l’aide de la Torche-balise, marquer chaque tour à Andorhal ; il faut se tenir dans l’embrasure de la porte de la tour pour pouvoir la marquer."
Lang["Q1_838"] = "Scholomance"
Lang["Q2_838"] = "Parler au Pharmacien Dithers à la Barricade, dans les Maleterres de l'ouest."
Lang["Q1_964"] = "Fragments de squelette"
Lang["Q2_964"] = "Apporter 15 Fragments de squelette au Pharmacien Dithers à la Barricade, dans les Maleterres de l'ouest."
Lang["Q1_5514"] = "Moisissure rime avec…"
Lang["Q2_5514"] = "Apporter les Fragments de squelette imprégnés et 15 pièces d’or à Krinkle Goodsteel à Gadgetzan."
Lang["Q1_5802"] = "Forgée dans la Fournaise"
Lang["Q2_5802"] = "Prendre le moule de la Clé squelette et deux barres de thorium au sommet de la crête de la Fournaise dans le cratère d'Un'Goro. Se servir du moule de la Clé squelette pour forger la Clé squelette inachevée."
Lang["Q1_5804"] = "Le Scarabée d'Araj"
Lang["Q2_5804"] = "Vaincre Araj l'Invocateur et apporter le Scarabée d'Araj à l’apothicaire Dithers à la Barricade, dans les Maleterres de l’ouest."
Lang["Q1_5511"] = "La clé de Scholomance"
Lang["Q2_5511"] = "Eh bien voilà, la Clé squelette terminée. Je suis aussi certain que possible que cette clé vous permettra d'entrer dans les confins de Scholomance."
Lang["Q1_5092"] = "Nettoyer le passage"
Lang["Q2_5092"] = "Tuer 10 Ecorcheurs Squelettes et 10 Goules écumantes sur la Colline des chagrins."
Lang["Q1_5097"] = "Tout au long des tours de guet"
Lang["Q2_5097"] = "À l’aide de la Torche-balise, marquer chaque tour à Andorhal ; il faut se tenir dans l’embrasure de la porte de la tour pour pouvoir la marquer."
Lang["Q1_5533"] = "Scholomance"
Lang["Q2_5533"] = "Parler à l’alchimiste Arbington à la pointe du Noroît, dans les Maleterres de l’ouest."
Lang["Q1_5537"] = "Fragments de squelette"
Lang["Q2_5537"] = "Apporter 15 Fragments de squelette à l’alchimiste Arbington à la pointe du Noroît, dans les Maleterres de l’ouest."
Lang["Q1_5538"] = "Moisissure rime avec…"
Lang["Q2_5538"] = "Apporter les Fragments de squelette imprégnés et 15 pièces d’or à Krinkle Goodsteel à Gadgetzan."
Lang["Q1_5801"] = "Forgée dans la Fournaise"
Lang["Q2_5801"] = "Prendre le moule de la Clé squelette et deux barres de thorium au sommet de la crête de la Fournaise dans le cratère d'Un'Goro. Se servir du moule de la Clé squelette pour forger la Clé squelette inachevée."
Lang["Q1_5803"] = "Le Scarabée d'Araj"
Lang["Q2_5803"] = "Vaincre Araj l'Invocateur et apporter le Scarabée d'Araj à l’alchimiste Arbington à la pointe du Noroît, dans les Maleterres de l’ouest."
Lang["Q1_5505"] = "La clé de Scholomance"
Lang["Q2_5505"] = "Eh bien voilà, la Clé squelette terminée. Je suis aussi certain que possible que cette clé vous permettra d'entrer dans les confins de Scholomance."
--v250
Lang["Q1_6804"] = "Eau empoisonnée"
Lang["Q2_6804"] = "Utiliser l’Aspect de Neptulon sur les élémentaires empoisonnés des Maleterres de l’est. Apporter 12 Bracelets discordants et l’Aspect de Neptulon au duc Hydraxis, en Azshara."
Lang["Q1_6805"] = "Tempêtes"
Lang["Q2_6805"] = "Tuer 15 Tempétueux de poussière et 15 Grondeurs du désert, puis retourner voir le duc Hydraxis, en Azshara."
Lang["Q1_6821"] = "Oeil du Prophète ardent"
Lang["Q2_6821"] = "Apporter l’Oeil du Prophète ardent au duc Hydraxis, en Azshara."
Lang["Q1_6822"] = "Le Cœur du Magma"
Lang["Q2_6822"] = "Tuer 1 Seigneur du feu, 1 Géant de lave, 1 Chien antique du Magma et 1 Surgisseur de lave, puis retourner voir le duc Hydraxis, à Azshara."
Lang["Q1_6823"] = "Agent de Hydraxis"
Lang["Q2_6823"] = "Parvenir au niveau de réputation Honoré auprès des Hydraxiens, puis parler au duc Hydraxis, en Azshara."
Lang["Q1_6824"] = "Les mains de l'ennemi"
Lang["Q2_6824"] = "Apporter les Mains de Lucifron, de Sulfuron, de Gehennas et de Shazzrah au duc Hydraxis, en Azshara."
Lang["Q1_7486"] = "La récompense du héros"
Lang["Q2_7486"] = "Allez chercher votre récompense dans le Coffre d’Hydraxis."
--v254
Lang["Q1_11481"] = "Crise au Puits de soleil"
Lang["Q2_11481"] = "Adyen le Gardelumière, de l'Éminence de l'Aldor à Shattrath, veut que vous vous rendiez au Plateau du Puits de soleil pour parler à Larethor."
Lang["Q1_11488"] = "La terrasse des Magistères"
Lang["Q2_11488"] = "L'exarque Larethor, de la Zone de rassemblement du Soleil brisé, vous demande d'explorer la Terrasse des magistères à la recherche de Tyrith, un espion elfe de sang."
Lang["Q1_11490"] = "Clairvoyance pour les Clairvoyants"
Lang["Q2_11490"] = "Tyrith veut que vous utilisiez l'orbe sur le balcon de la Terrasse des Magistères."
Lang["Q1_11492"] = "L'increvable"
Lang["Q2_11492"] = "Kalecgos vous a demandé de vaincre Kael'thas sur la Terrasse des Magistères. Vous devrez ramasser la tête de Kael avant de faire votre rapport à Larethor à la Zone de rassemblement du Soleil brisé."


--WOTLK QUESTS
-- The ids are Q1_<QuestId> and Q2_<QuestId>
-- Q1 is just the title of the quest
-- Q2 is the description/synopsis, with some helpful comments in between \n\n|cff33ff99 and |r--WOTLK
Lang["Q1_12892"] = "Qu'est-ce qu'on se marre"
Lang["Q2_12892"] = "Détruisez l'Oculaire puis faites votre rapport au Baron Lesquille au Caveau des Ombres."
Lang["Q1_12887"] = "Qu'est-ce qu'on se marre"
Lang["Q2_12887"] = "Détruisez l'Oculaire puis faites votre rapport au Baron Lesquille au Caveau des Ombres."
Lang["Q1_12891"] = "J'ai une idée mais d'abord…"
Lang["Q2_12891"] = "Le Baron Lesquille, au Caveau des Ombres, vous a demandé de trouver un Bâtonnet de sectateur, un Crochet d'abomination, une Corde de Geist et 5 Essences du Fléau..\n\n|cff33ff99Ils sont sur les platformes autour du caveau.|r"
Lang["Q1_12893"] = "Libérez votre esprit"
Lang["Q2_12893"] = "Le Baron Lesquille, au Caveau des Ombres, vous demande d'utiliser le Bâtonnet souverain sur les cadavres de Vil, Dame Bois-de-nuit et Le Bondisseur."
Lang["Q1_12897"] = "S'il ne peut pas être détourné…"
Lang["Q2_12897"] = "Tuez le Général Plaie-de-lumière puis allez rapporter votre succès auprès de Koltira Tissemort à bord de la canonnière, le Marteau d'Orgrim."
Lang["Q1_12896"] = "S'il ne peut pas être détourné…"
Lang["Q2_12896"] = "Tuez le Général Plaie-de-lumière puis allez rapporter votre succès à Thassarian à bord de la canonnière Brise-ciel."
Lang["Q1_12899"] = "Le caveau des Ombres"
Lang["Q2_12899"] = "Présentez-vous au Baron Lesquille au Caveau des Ombres."
Lang["Q1_12898"] = "Le caveau des Ombres"
Lang["Q2_12898"] = "Présentez-vous au Baron Lesquille au Caveau des Ombres."
Lang["Q1_11978"] = "Il est temps de nous rejoindre"
Lang["Q2_11978"] = "L’Émissaire Sabot-brillant, du Camp de réfugiés de Ponevent dans la Désolation des dragons, veut que vous récupériez 10 Armes de la Horde."
Lang["Q1_11983"] = "Le serment de sang de la Horde"
Lang["Q2_11983"] = "Parlez aux taunkas du Camp de réfugiés de Ponevent et amenez 5 d’entre eux à prêter allégeance à la Horde."
Lang["Q1_12008"] = "Le Marteau d'Agmar"
Lang["Q2_12008"] = "Rendez-vous au Marteau d’Agmar, dans la Désolation des dragons, et parlez au Suzerain Agmar.\n\n|cff33ff99Il se trouve dans le fort à (38.1, 46.3).|r"
Lang["Q1_12034"] = "La victoire approche…"
Lang["Q2_12034"] = "SParlez au Sergent-chef Juktok au Marteau d’Agmar.\n\n|cff33ff99Au milieu du camp à (36.6, 46.6).|r"
Lang["Q1_12036"] = "Des profondeurs d'Azjol-Nérub"
Lang["Q2_12036"] = "Explorez la Fosse de Narjun puis retournez voir le Sergent-chef Juktok au Marteau d'Agmar pour lui faire part de vos découvertes.\n\n|cff33ff99L'entrée est a l'ouest du Marteau d'Agmar, à (26.2, 49.6). Descendez dans le trou pour completer la quête.|r"
Lang["Q1_12053"] = "La puissance de la Horde"
Lang["Q2_12053"] = "Le Sergent-chef Juktok au Marteau d'Agmar dans la Désolation des dragons veut que vous utilisiez l'Étendard de bataille chanteguerre au village de Brume-glace, et que vous le défendiez contre les attaques.\n\n|cff33ff99Vous pouvez planter l'Étendard vers (25.2, 24.8).|r"
Lang["Q1_12071"] = "Attaque aérienne !"
Lang["Q2_12071"] = "Parlez à Valnok Ragevent au Marteau d'Agmar."
Lang["Q1_12072"] = "Que les bêtes-chancreuses soient damnées !"
Lang["Q2_12072"] = "Utilisez le Lance-fusée de Valnok pour appeler un Chevaucheur de guerre kor'kron. Montez sur son dos et utilisez-le pour tuer 25 Bêtes-chancreuses anub'ar !\n\n|cff33ff99Il y en a quelques unes en dessous du village vers la cascade du bas, et bien plus près des grandes cascades en haut.|r"
Lang["Q1_12063"] = "La force de Brume-glace"
Lang["Q2_12063"] = "Trouvez Banthok Brume-glace au village de Brume-glace.\n\n|cff33ff99il est au niveau de l'eau, dans un petit enfoncement à (22.7, 41.6).|r"
Lang["Q1_12064"] = "Les chaînes des Anub'ar"
Lang["Q2_12064"] = "Banthok Brume-glace, du village de Brume-glace de la Désolation des dragons, veut que vous lui rapportiez le Fragment de la clé d’Anok’ra, le Fragment de la clé de Tivax et le Fragment de la clé de Sinok.\n\n|cff33ff99Ils sont dans les batiments. Tivax est à (26.7, 39.0), Sinok est à (24.3, 44.2) et Anok'ra est en dessou de Sinok à (24.9, 43.9).|r"
Lang["Q1_12069"] = "Le retour du grand chef"
Lang["Q2_12069"] = "Libérez le Grand chef Brume-glace à l’aide de la Clé de la prison anub’ar, puis aidez-le à vaincre le Roi-d’en-bas Anub’et’kan.\n\n|cff33ff99Le Grand chef est dans une cage magique, à (25.3, 40.9).|r"
Lang["Q1_12140"] = "Gloire à Roanauk !"
Lang["Q2_12140"] = "Allez trouver Roanauk Brume-glace au Marteau d'Agmar et initiez-le à son rôle de membre et de chef des forces de la Horde."
Lang["Q1_12189"] = "Une bande d'imbéciles !"
Lang["Q2_12189"] = "Voyager jusqu'à Vexevenin dans la Désolation des dragons et parler avec le Porte-peste en chef Mideton..\n\n|cff33ff99Il est dans le batiment, à (77.7, 62.8).|r"
Lang["Q1_12188"] = "La flétrissure des Réprouvés et vous : petit manuel de survie"
Lang["Q2_12188"] = "Le Porte-peste en chef Mideton, à Vexevenin dans la Désolation des dragons, veut que vous lui rapportiez 10 Résidus ectoplasmiques."
Lang["Q1_12200"] = "Les larmes de dragon émeraude"
Lang["Q2_12200"] = "Le Porte-peste en chef Mideton, à Vexevenin dans la Désolation des dragons, vous demande de collecter 8 Larmes de dragon émeraude.\n\n|cff33ff99Elles ressemblent à des gemmes vertes sur le sol vers (63.5, 71.9).|r"
Lang["Q1_12218"] = "Répandez la bonne nouvelle"
Lang["Q2_12218"] = "Le Porte-peste en chef Mideton, à Vexevenin dans la Désolation des dragons, veut que vous utilisiez la Bombe chancreuse de l'Épandeur de chancre réprouvé pour détruire 30 Morts efflanqués aux abords des Champs de la Charogne."
Lang["Q1_12221"] = "La flétrissure des Réprouvés"
Lang["Q2_12221"] = "Livrer la Flétrissure des Réprouvés au Docteur Sintar Maléfious au Marteau d'Agmar."
Lang["Q1_12224"] = "L'avant-garde kor'kronne !"
Lang["Q2_12224"] = "Présentez-vous à Saurcroc le jeune à l'Avant-garde kor'kronne.\n\n|cff33ff99Il se trouve à (40.7, 18.2).|r"
Lang["Q1_12496"] = "Une audience auprès de la reine dragon"
Lang["Q2_12496"] = "Trouvez Alexstrasza la Lieuse-de-vie au Temple du Repos du ver, à la Désolation des dragons.\n\n|cff33ff99Parlez à Tariolstrasz (57.9, 54.2) et demandez lui d'aller au sommet de la tour. Elle est là, sous forme humanoïde (59.8, 54.7).|r"
Lang["Q1_12497"] = "Galakrond et le Fléau"
Lang["Q2_12497"] = "Parlez à Torastrasza au Temple du Repos du ver de la Désolation des dragons."
Lang["Q1_12498"] = "Sur des ailes de rubis"
Lang["Q2_12498"] = "Détruisez 30 Charognards du désert et récupérez la faux d'Antiok. Retournez auprès d'Alexstrasza la Lieuse-de-vie au Temple du Repos du ver si vous parvenez à accomplir cette tâche.\n\n|cff33ff99Vous les trouverez au nord, vers (56.8, 33.3). N'oubliez pas la faux, à (54.6, 31.4).|r"
Lang["Q1_12500"] = "Retour à Angrathar"
Lang["Q2_12500"] = "Parlez à Saurcroc le Jeune à l'Avant-garde kor'kronne et rapportez-lui votre victoire contre le Fléau.\n\n|cff33ff99Profitez de la scene cinématique! :-)|r"
Lang["Q1_13242"] = "Les ténèbres s'agitent"
Lang["Q2_13242"] = "Récupérez l'Armure de bataille de Saurcroc sur le champ de bataille et rapportez-la au Haut seigneur Saurcroc au Bastion Chanteguerre dans la Toundra Boréenne."
Lang["Q1_13257"] = "Héraut de guerre"
Lang["Q2_13257"] = "Présentez-vous à Thrall à Fort Grommash à Orgrimmar.\n\n|cff33ff99Profitez du jeu de rôle :-)|r"
Lang["Q1_13266"] = "Une vie sans regrets"
Lang["Q2_13266"] = "Prenez le Portail vers Fossoyeuse situé à Fort Grommash et faites votre rapport à Vol'jin."
Lang["Q1_13267"] = "La bataille pour Fossoyeuse"
Lang["Q2_13267"] = "Aidez Thrall et Sylvanas à reprendre Fossoyeuse pour la Horde."
Lang["Q1_12235"] = "Naxxramas et la chute de Garde-Hiver"
Lang["Q2_12235"] = "Parlez au commandant des griffons Urik, au nid de griffons du Donjon de Garde-Hiver."
Lang["Q1_12237"] = "Le vol du défenseur de Garde-Hiver"
Lang["Q2_12237"] = "Sauvez 10 Villageois de Garde-Hiver sans défense, et retournez voir le Commandant des griffons Urik au Donjon de Garde-Hiver."
Lang["Q1_12251"] = "Retourner voir le haut-commandant"
Lang["Q2_12251"] = "Parlez au Haut-commandant Halford Verroctone, au Donjon de Garde-Hiver dans la Désolation des dragons."
Lang["Q1_12253"] = "Sauvés de la place du village"
Lang["Q2_12253"] = "Le Haut-commandant Halford Verroctone, au Donjon de Garde-Hiver, dans la Désolation des dragons, vous a demandé de sauver 6 Villageois de Garde-Hiver piégés."
Lang["Q1_12309"] = "Trouvez Durkon !"
Lang["Q2_12309"] = "Trouvez le Cavalier Durkon à la Crypte de Garde-Hiver, dans la Désolation des dragons.\n\n|cff33ff99Il est juste à l'exterieur de la crypte, à (79.0, 53.2).|r"
Lang["Q1_12311"] = "La crypte des nobles"
Lang["Q2_12311"] = "Le Cavalier Durkon, au Donjon de Garde-Hiver, veut que vous tuiez le Nécro-seigneur Amarion.\n\n|cff33ff99Il se trouve tout en bas de la crypte.|r"
Lang["Q1_12275"] = "Le démo-gnome"
Lang["Q2_12275"] = "Parler à l'Ingénieur de siège Quatreflash au Donjon de Garde-Hiver dans la Désolation des dragons.\n\n|cff33ff99Il est près du maître des griffons, à (77.8, 50.3).|r"
Lang["Q1_12276"] = "À la recherche de Subrepte"
Lang["Q2_12276"] = "Trouvez Subrepte le Démo-gnome dans la Mine de Garde-Hiver. Utilisez le Robot-chercheur de Quatreflash si vous avez besoin d'aide pour localiser la mine.\n\n|cff33ff99Le robot isest assez rapide, chevauchez si vous avez besoin de le suivre.\nEntrez dans la mine via l'entrée du bas et serrez a droite pour trouver le corps à (81.5, 42.2).|r"
Lang["Q1_12277"] = "Ne laissez rien au hasard"
Lang["Q2_12277"] = "Récupérez une Bombe de la mine de Garde-Hiver et utilisez-la pour faire sauter le Puits de mine supérieur de Garde-Hiver et le Puits de mine inférieur de Garde-Hiver. Retournez faire votre rapport à l'Ingénieur de siège Quatreflash au Donjon de Garde-Hiver dans la Désolation des dragons lorsque vous aurez terminé.\n\n|cff33ff99En venant du corps, prenez a droite pour trouver les explovifs à (80.7, 41.3).|r"
Lang["Q1_12325"] = "En territoire ennemi"
Lang["Q2_12325"] = "Parlez au Commandant des griffons Urik pour prendre un vol à destination du Poste de Thorson. Lorsque vous serez au Poste de Thorson dans la Désolation des dragons, présentez-vous au duc Auguste Marteau-des-ennemis.\n\n|cff33ff99Au lieu de parler au Commandant des griffons, utilisez plutôt un des griffons qui sont là.|r"
Lang["Q1_12312"] = "Les secrets du Fléau"
Lang["Q2_12312"] = "Remettez le Tome relié de chair au Cavalier Durkon, au Donjon de Garde-Hiver dans la Désolation des dragons."
Lang["Q1_12319"] = "Le mystère du tome"
Lang["Q2_12319"] = "Remettez le Tome relié de chair au haut-commandant Halford Verroctone, au Donjon de Garde-Hiver dans la Désolation des dragons."
Lang["Q1_12320"] = "Comprendre la langue des morts"
Lang["Q2_12320"] = "Remettez le Tome relié de chair à l’Inquisiteur Hallard, dans la prison du donjon de Garde-Hiver.\n\n|cff33ff99La prison est la grosse caserne en montant depuis Halford.\nDans la cour, prenez les escaliers qui descendent (derriere Gluth). Hallard est à (76.7, 47.4).|r"
Lang["Q1_12321"] = "Un sermon édifiant"
Lang["Q2_12321"] = "Attendez que l’Inquisiteur Hallard ait terminé son Sermon édifiant, puis retournez voir le Haut-commandant Halford Verroctone au Donjon de Garde-Hiver dans la Désolation des dragons avec les informations qui vous auront été communiquées."
Lang["Q1_12272"] = "Le minerai sanguinolent"
Lang["Q2_12272"] = "L'Ingénieur de siège Quatreflash, au Donjon de Garde-Hiver dans la Désolation des dragons, veut que vous alliez récupérer 10 échantillons de Minerai étrange dans la Mine de Garde-Hiver."
Lang["Q1_12281"] = "Étudier les machines de guerre du Fléau"
Lang["Q2_12281"] = "Livrez le Colis de Quatreflash au Haut-commandant Halford Verroctone au Donjon de Garde-Hiver."
Lang["Q1_12326"] = "Char à vapeur surprise"
Lang["Q2_12326"] = "Utilisez un Char à vapeur de l'Alliance pour détruire 6 Chariots à peste et déposer les Soldats d'élite de la 7e Légion au Mausolée de Garde-Hiver. Si vous réussissez, allez parler à Ambo Cash, à l'intérieur du Mausolée de Garde-Hiver, dans la Désolation des dragons.\n\n|cff33ff99Le Mausolée est à (85.9, 50.8), Ambo Cash attend à l'intérieur.|r"
Lang["Q1_12455"] = "Dispersées aux quatre vents"
Lang["Q2_12455"] = "Ambo Cash, du Mausolée de Garde-Hiver dans la Désolation des dragons, veut que vous récupériez 8 Caisses de munitions de Garde-Hiver.\n\n|cff33ff99Elles sont a l'extérieur du Mausolée, dispersées dans le champ.|r"
Lang["Q1_12457"] = "Votre amie, la mitrailleuse"
Lang["Q2_12457"] = "Ambo Cash, du Mausolée de Garde-Hiver dans la Désolation des dragons, veut que vous sauviez 8 Soldats blessés de la 7e Légion.\n\n|cff33ff99Les soldats apparaissent toujours au fond de la salle, assurez vous de l'arroser copieusement.|r"
Lang["Q1_12463"] = "Il faut trouver Barbapille !"
Lang["Q2_12463"] = "Ambo Cash, au Mausolée de Garde-Hiver dans la Désolation des dragons, vous a demandé de retrouver Barbapille.\n\n|cff33ff99Il est au fond de la salle, dans une cave sur le coté (84.2, 54.7).|r"
Lang["Q1_12465"] = "Le journal de Barbapille"
Lang["Q2_12465"] = "Récupérez les pages 4, 5, 6 et 7 du journal de Barbapille et donnez-les à Ambo Cash au Mausolée de Garde-Hiver dans la Désolation des dragons.\n\n|cff33ff99Suivez le tunnel de terre qui commence a Barbapille.|r"
Lang["Q1_12466"] = "À la poursuite de Foudreglace : le front de la 7e Légion"
Lang["Q2_12466"] = "Présentez-vous au Commandant de la Légion Tyralion au Front de la 7e Légion au centre de la Désolation des dragons.\n\n|cff33ff99le Front de la Légion se trouve à (64.7, 27.9)|r"
Lang["Q1_12467"] = "À la poursuite de Foudreglace : le phylactère de Thel'zan"
Lang["Q2_12467"] = "Reprenez le Phylactère de Thel'zan à Foudreglace et rapportez-le au Haut-commandant Halford Verroctone au Donjon de Garde-Hiver."
Lang["Q1_12472"] = "Finalité"
Lang["Q2_12472"] = "Apportez le Phylactère de Thel'zan au commandant de la Légion Yorik à l'intérieur du Mausolée de Garde-Hiver de la Désolation des dragons..\n\n|cff33ff99L'entrée du tunnel est juste à la sortie de la ville fortifiée, à (82.0, 50.7).|r"
Lang["Q1_12473"] = "Une fin et un début"
Lang["Q2_12473"] = "Vainquez Thel'zan le Portebrune et faites votre rapport au Haut-commandant Halford Verroctone au Donjon de Garde-Hiver dans la Désolation des dragons.\n\n|cff33ff99Si vous mourrez, attendez un peu; le PNJs finiront peut-être la quête pour vous.|r"
Lang["Q1_12474"] = "En route pour le bastion Fordragon !"
Lang["Q2_12474"] = "Rendez-vous au bastion Fordragon dans la Désolation des dragons et parlez au généralissime Bolvar Fordragon.\n\n|cff33ff99Il se trouve tout au sommet, à (37.8, 23.4).|r"
Lang["Q1_12495"] = "Une audience auprès de la reine dragon"
Lang["Q2_12495"] = "Trouvez Alexstrasza la Lieuse-de-vie au Temple du Repos du ver à la Désolation des dragons.\n\n|cff33ff99Parlez à Tariolstrasz (57.9, 54.2) et demandez lui d'aller au sommet de la tour. Elle est là, sous forme humanoïde (59.8, 54.7).|r"
Lang["Q1_12499"] = "Retour à Angrathar"
Lang["Q2_12499"] = "Parlez au Généralissime Bolvar Fordragon au Bastion Fordragon et rapportez-lui votre victoire contre le Fléau."
Lang["Q1_13347"] = "Renaître de ses cendres"
Lang["Q2_13347"] = "Récupérez le bouclier de Fordragon sur le champ de bataille à Angrathar, le Portail du Courroux, et rapportez-le au roi Varian Wrynn au Donjon de Hurlevent à Hurlevent."
Lang["Q1_13369"] = "Destin, contre votre volonté"
Lang["Q2_13369"] = "Aidez Dame Jaina Portvaillant à Orgrimmar. Parlez au Chef de guerre de la Horde, Thrall, à Orgrimmar sur le continent de Kalimdor."
Lang["Q1_13370"] = "Un coup royal"
Lang["Q2_13370"] = "Utilisez le portail de Fort Grommash pour retourner au Donjon de Hurlevent et porter le message de Thrall au Roi Varian Wrynn."
Lang["Q1_13371"] = "Le temps des meurtres"
Lang["Q2_13371"] = "Utilisez le portail vers Fossoyeuse créé dans le donjon de Hurlevent pour vous téléporter à Fossoyeuse. Présentez-vous à Broll Mantelours lorsque vous arriverez à destination."
Lang["Q1_13377"] = "La bataille pour Fossoyeuse"
Lang["Q2_13377"] = "Aidez le Roi Varian Wrynn et Dame Jaina Portvaillant à conduire le Grand apothicaire Putrescin devant la justice ! Retournez voir le Roi Varian Wrynn si vous réussissez."
--WOTLK Sons of Hodir
Lang["Q1_12843"] = "Elles ont pris nos hommes !"
Lang["Q2_12843"] = "Gretchen Pfutincelle vous demande d'aller à Sifreldar et de secourir 5 Prisonniers gobelins.\n\n|cff33ff99Allez au village à (41.4, 70.6), tuez des géants pour avoir les clés des cages disseminées dans le village.|r"
Lang["Q1_12846"] = "Le gobelin manquant"
Lang["Q2_12846"] = "Trouvez l'entrée de la Mine Lugubre au nord du Village Sifreldar et cherchez des indices sur l'endroit où se trouve Zeev Pfutincelle.\n\n|cff33ff99L'entrée de la mine est dans le village à (42.1, 69.5), pas en dessous. Si vous voyez des araignées, vous êtes dans la mauvaise :-).|r"
Lang["Q1_12841"] = "La proposition de la mégère"
Lang["Q2_12841"] = "Lok'lira la Mégère à l'intérieur de la Mine Lugubre vous a demandé de récupérer les Runes des Yrkvinn que détient la Surveillante Syra.\n\n|cff33ff99Syra se promêne dans les couloirs des cotés de la mine.|r"
Lang["Q1_12905"] = "Mildred la Cruelle"
Lang["Q2_12905"] = "Parlez à Mildred la Cruelle à la Mine Lugubre.\n\n|cff33ff99Mildred est sur la platforme quand vous continuez dans la mine.|r"
Lang["Q1_12906"] = "Discipline"
Lang["Q2_12906"] = "Mildred la Cruelle à la Mine Lugubre vous a demandé d'utiliser le Bâton de discipline sur 6 Vrykuls épuisés."
Lang["Q1_12907"] = "Faire des exemples"
Lang["Q2_12907"] = "Mildred la Cruelle à la Mine Lugubre vous a demandé de tuer Garhal.\n\n|cff33ff99il est avec deux autres, plus loin dans la Mine, à (45.4, 69.1). Les guardes vous aideront.|r"
Lang["Q1_12908"] = "La bravache et la prisonnière"
Lang["Q2_12908"] = "Apportez la Clé de Mildred à Lok'lira la Mégère à la Mine Lugubre."
Lang["Q1_12921"] = "Changer de décor"
Lang["Q2_12921"] = "Retrouvez Lok'lira la Mégère à Brunnhildar."
Lang["Q1_12969"] = "Il est à vous, ce gobelin ?"
Lang["Q2_12969"] = "Défiez Agnetta Tyrsdottar afin de sauver Zeev Pfutincelle. Retournez auprès de Lok'lira la Mégère à Brunnhildar une fois la tâche accomplie."
Lang["Q1_12970"] = "Le Hyldsmeet"
Lang["Q2_12970"] = "Écoutez la proposition de Lok'lira la Mégère.\n\n|cff33ff99Parlez just à la Mégère et cliquez les differents messages.|r"
Lang["Q1_12971"] = "Accepter tous les défis"
Lang["Q2_12971"] = "Lok'lira la Mégère à Brunnhildar vous a demandé de vaincre 6 Prétendantes victorieuses.\n\n|cff33ff99Parlez juste aux Prétendantes qui ne sont pas en train de se battre.|r"
Lang["Q1_12972"] = "Vous aurez besoin d'un ours"
Lang["Q2_12972"] = "Parlez à Brijana à l'extérieur de Brunnhildar.\n\n|cff33ff99Brijana est à (53.1, 65.7).|r"
Lang["Q1_12851"] = "La pro de l'ours"
Lang["Q2_12851"] = "Brijana à Brunnhildar vous a demandé de chevaucher Croc-de-glace et d'abattre 7 Worgs de givre et 15 Géants du givre dans la Vallée des Anciens hivers."
Lang["Q1_12856"] = "Brisons la glace"
Lang["Q2_12856"] = "Libérez 3 Proto-drakes captifs et sauvez 9 Prisonnières de Brunnhildar.\n\n|cff33ff99Volez jusque (64.3, 61.5) et sautez sur un Proto-drakes attaché au plafond. Vous pourrez alors 'tirer' sur les prisonnières congelées pour les liberer. Faites en 3 et retournez au village, et faites ça 3 fois pour avoir les 9.|r"
Lang["Q1_13063"] = "Digne de valeur"
Lang["Q2_13063"] = "Brijana veut que vous alliez à Brunnhildar pour parler avec Astrid Bjornrittar.\n\n|cff33ff99Astrid est dans une maison à (49.7, 71.8).|r"
Lang["Q1_12900"] = "Fabriquer un harnais"
Lang["Q2_12900"] = "Astrid Bjornrittar à Brunnhildar veut que vous rapportiez 3 Peaux de yéti crins-de-glace."
Lang["Q1_12983"] = "La dernière de son espèce"
Lang["Q2_12983"] = "Astrid Bjornrittar à Brunnhildar vous a demandé de sauver une Matriarche glacegueule à la Caverne de l'Hibernation.\n\n|cff33ff99L'entrée se trouver à (55.9, 64.3). Serrez a droite et vous trouverez la Matriarche facilement.|r"
Lang["Q1_12996"] = "Tour de chauffe"
Lang["Q2_12996"] = "Astrid Bjornrittar à Brunnhildar veut que vous utilisiez les Rênes de matriarche ours de guerre pour vaincre Kirgaraak.\n\n|cff33ff99Mutilez (4) sur cooldown, quand Charge est disponible faites le knockback (5) puis ensuite chargez (6). Si l'ours meurt essayez de finir Kirgaraak par vous même, ça comptera quand même pour la quête.|r"
Lang["Q1_12997"] = "Dans la fosse"
Lang["Q2_12997"] = "Astrid Bjornrittar à Brunnhildar veut que vous utilisiez les Rênes de matriarche ours de guerre dans la Fosse du croc et que vous battiez 6 Ours de guerre du Hyldsmeet."
Lang["Q1_13061"] = "Préparation pour la gloire"
Lang["Q2_13061"] = "Parlez à Lok'lira la Mégère à Brunnhildar."
Lang["Q1_13062"] = "Cadeau d'adieu de Lok'lira"
Lang["Q2_13062"] = "Parlez à Gretta la Médiatrice à Brunnhildar."
Lang["Q1_12886"] = "Le Drakkensryd"
Lang["Q2_12886"] = "Utilisez le Harpon hyldnir pour vaincre 10 Chevaucheuses de drake du Hyldsmeet au Temple des Tempêtes.\n\n|cff33ff99Utilisez le harpon pour sauter sur les autres drakes et tuer leur cavalières. Apres 10 tuées, utilisez le harpon sur une des petites lampes suspendues aux colonnes, ça vous mettra sur la platforme.|r"
Lang["Q1_13064"] = "Rivalité fraternelle"
Lang["Q2_13064"] = "Thorim veut que vous écoutiez son histoire."
Lang["Q1_12915"] = "Rentrer dans les bonnes grâces"
Lang["Q2_12915"] = "Thorim au Temple des Tempêtes vous a demandé de tuer Fjorn et 5 Géants de fer forge-foudre à l'Enclume de Fjorn, à l'est de Dun Niffelem.\n\n|cff33ff99Volez jusque la forge completement a l'est des Pics Foudroyés (76.9, 63.2), et rammassez un rocher par terre. Utilisez le charme de Thorim sur votre cible et des nains viendront vous aider.\nNotez, vous aurez besoin d'un nouveau rocher pour chaque cible (donc au moins 6).|r"
Lang["Q1_12922"] = "Le feu du raffineur"
Lang["Q2_12922"] = "Récupérez 10 Étincelles furieuses sur des Revenants vengeurs au Lac du Champ-gelé, puis utilisez l'enclume à l'Enclume de Fjorn."
Lang["Q1_12956"] = "Une faible lueur d'espoir"
Lang["Q2_12956"] = "Vous devez apporter le Minerai resplendissant raffiné à Thorim au Temple des tempêtes."
Lang["Q1_12924"] = "Forger une alliance"
Lang["Q2_12924"] = "Rendez-vous à Dun Niffelem et demandez au Roi Jokkum de permettre que l'Armure de Thorim soit reforgée. Après avoir terminé la tâche de Jokkum, allez parler à Njormeld à Dun Niffelem.\n\n|cff33ff99Le Roi se trouve au centre de Dun Niffelem, à (65.4, 60.1).\n\nPar contre cette quête sera eventuellement rendue à Njormeld (63.2, 63.3).|r"
Lang["Q1_13009"] = "Un nouveau départ"
Lang["Q2_13009"] = "Njormeld veut que vous apportiez l'Armure reforgée à Thorim au Temple des tempêtes."
Lang["Q1_13050"] = "Veranus"
Lang["Q2_13050"] = "TThorim, au Temple des tempêtes, veut que vous obteniez 5 Petits œufs de proto-drake sur les pics proches de Brunnhildar.\n\n|cff33ff99Il y a plusieurs nids dans les alentours, par exemple à (52.5, 73.4).|r"
Lang["Q1_13051"] = "Violation de territoire"	
Lang["Q2_13051"] = "Placez les Œufs de proto-dragon volés au sommet du Nid de la mère des couvées, puis retournez voir Thorim au Temple des tempêtes.\n\n|cff33ff99Le bon nid est à (38.7, 65.5). Posez les Œufs et attendez que Thorim apparisse sur Veranus.|r"
Lang["Q1_13010"] = "Krolmir, le marteau des tempêtes"
Lang["Q2_13010"] = "Thorim vous demande d'aller parler au Roi Jokkum à Dun Niffelem et de découvrir ce qu'il sait à propos de Krolmir.\n\n|cff33ff99Vous manquerez peut-être d'un peu de rep pour que le Roi ne vous reponde. Completez une des quêtes daily pour devenir Amis.|r"
Lang["Q1_12966"] = "Vous ne pourrez pas le rater"
Lang["Q2_12966"] = "Le Roi Jokkum, à Dun Niffelem, veut que vous rejoigniez Njormeld à l'Enclume de Fjorn."
Lang["Q1_12967"] = "Affronter les éléments"
Lang["Q2_12967"] = "Njormeld veut que vous accompagniez Snorri à l'Enclume de Fjorn et que vous l'aidiez à tuer 10 Revenants vengeurs."
Lang["Q1_12975"] = "In Memoriam"
Lang["Q2_12975"] = "Le Roi Jokkum à Dun Niffelem veut que vous récupériez 8 Fragments de cor à Chute-tonnerre.\n\n|cff33ff99Ce sont des morceaux gris dans la neige à (71.6, 48.9).|r"
Lang["Q1_12976"] = "Un monument à ceux qui sont tombés"
Lang["Q2_12976"] = "Le Roi Jokkum veut que vous apportiez les Fragments du Cor de Hodir à Njormeld à Dun Niffelem."
Lang["Q1_13011"] = "Eliminer Jorcuttar"
Lang["Q2_13011"] = "Le Roi Jokkum à Dun Niffelem vous demande de tuer Jorcuttar à la Caverne de l'hibernation.\n\n|cff33ff99Entrez dans la cave et serrez a droite. Vous pouvez appeler Jorcuttar à (54.8, 61.0). Il vous faudra peut-être vous y reprendre a plusieurs fois pour avoir la viande.|r"
Lang["Q1_13372"] = "La clé de l'iris de focalisation"
Lang["Q2_13372"] = "Livrez la Clé de l'iris de focalisation à Alexstrasza la Lieuse-de-vie au sommet du Temple du Repos du ver, dans la Désolation des dragons."
Lang["Q1_13375"] = "La clé héroïque de l'iris de focalisation"
Lang["Q2_13375"] = "Livrez la Clé héroïque de l'iris de focalisation à Alexstrasza la Lieuse-de-vie au sommet du Temple du Repos du ver, dans la Désolation des dragons."

--  \n\n|cff33ff99 |r
Lang["Q1_"] = ""
Lang["Q2_"] = ""




-- NPC
Lang["N1_9196"] = "Généralissime Omokk"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9196
Lang["N2_9196"] = "Omokk est le premier boss du Bas du Pic Rochenoire."
Lang["N1_9237"] = "Maître de guerre Voone"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9237
Lang["N2_9237"] = "Voone est un boss a l'intérieur du Bas du Pic Rochenoire."
Lang["N1_9568"] = "Seigneur Wyrmthalak"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9568
Lang["N2_9568"] = "Seigneur Wyrmthalak est le dernier boss du Bas du Pic Rochenoire."
Lang["N1_10429"] = "Chef de guerre Rend Main-noire"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10429
Lang["N2_10429"] = "Rend Main-noire est le 6ème boss au Sommet du Pic Rochenoire. Dal'rend, communément appelé Rend, est le chef de la Horde noire."
Lang["N1_10182"] = "Rexxar"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10182
Lang["N2_10182"] = "<Champion de la Horde>\n\nSe promène du sud des Serres-Rocheuses jusqu'au nord de Féralas."
Lang["N1_8197"] = "Chronalis"	-- https://www.thegeekcrusade-serveur.com/db/?npc=8197
Lang["N2_8197"] = "Chronalis du Vol de Bronze.\n\nSe trouve à l'entrée des Grottes du Temps."
Lang["N1_10664"] = "Clairvoyant"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10664
Lang["N2_10664"] = "Clairvoyant du Vol Bleu.\n\nSe trouve dans les profondeurs de la caverne de Mazthoril."
Lang["N1_12900"] = "Somnus"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12900
Lang["N2_12900"] = "Somnus du Vol Vert.\n\nSe trouve du coté Est du Temple Englouti."
Lang["N1_12899"] = "Axtroz"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12899
Lang["N2_12899"] = "Axtroz du Vol Rouge.\n\nSe trouve à Grim Batol, Les Paluns."
Lang["N1_10363"] = "Général Drakkisath"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10363
Lang["N2_10363"] = "Le Général Drakkisath est le dernier boss du Sommet du Pic Rochenoire."
Lang["N1_8983"] = "Seigneur golem Argelmach"	-- https://www.thegeekcrusade-serveur.com/db/?npc=8983
Lang["N2_8983"] = "Seigneur golem Argelmach est le 9ème boss des Profondeurs de Rochenoire."
Lang["N1_9033"] = "Général Forgehargne"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9033
Lang["N2_9033"] = "Le Général Forgehargne est le 7ème boss des Profondeurs de Rochenoire."
Lang["N1_17804"] = "Ecuyer Rowe"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17804
Lang["N2_17804"] = "L'écuyer se trouve aux portes de Hurlevent."
Lang["N1_10929"] = "Haleh"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10929
Lang["N2_10929"] = "Haleh est toute seule au somment de la caverne de Mazthoril, à l'exterieur.\nOn peut l'atteindre via la rune bleue sur le sol à l'intérieur de la caverne."
Lang["N1_9046"] = "Intendant du Bouclier balafré"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9046
Lang["N2_9046"] = "Il est en dehors de l'instance, dans une petite alcôve près de l'entrée balcon du Pic Rochenoire"
Lang["N1_15180"] = "Baristolth des Sables changeants"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15180
Lang["N2_15180"] = "Baristolth se trouve au Fort cénarien, près du Puits de lune (49.6,36.6)."
Lang["N1_12017"] = "Seigneur des couvées Lanistaire"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12017
Lang["N2_12017"] = "Le Seigneur des couvées Lanistaire est le 3ème boss du Repaire de l'Aile Noire."
Lang["N1_13020"] = "Vaelastrasz le Corrompu"	-- https://www.thegeekcrusade-serveur.com/db/?npc=13020
Lang["N2_13020"] = "Vaelastrasz le Corrumpu est le 2ème boss du Repaire de l'Aile Noire."
Lang["N1_11583"] = "Nefarian"	-- https://www.thegeekcrusade-serveur.com/db/?npc=11583
Lang["N2_11583"] = "Nefarian est le 8ème et dernier boss du Repaire de l'Aile Noire."
Lang["N1_15362"] = "Malfurion Hurlorage"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15362
Lang["N2_15362"] = "Malfurion peut être trouvé dans le Temple Englouti, et apparait quand on s'approche de l'Ombre d'Eranikus."
Lang["N1_15624"] = "Feu follet forestier"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15624
Lang["N2_15624"] = "Ce feu follet se trouve dans Teldrassil, près des portes de Darnassus (37.6,48.0)."
Lang["N1_15481"] = "Esprit d'Azuregos"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15481
Lang["N2_15481"] = "L'Esprit d'Azuregos se promène dans la partie sud d'Azshara (vers 58.8,82.2). Il aime bien discuter."
Lang["N1_11811"] = "Narain Divinambolesque"	-- https://www.thegeekcrusade-serveur.com/db/?npc=11811
Lang["N2_11811"] = "Se trouve dans une petite hutte juste au nord du Port Gentepression (65.2,18.4)."
Lang["N1_15526"] = "Meridith la Vierge de mer"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15526
Lang["N2_15526"] = "Elll se promène sous l'eau dans la zone avant la grande crevasse (vers 59.6,95.6). Une fois sa quête completée, retournez la voir pour recevoir un buff de nage rapide."
Lang["N1_15554"] = "Numéro Deux"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15554
Lang["N2_15554"] = "Numéro Deux peut être appelé au sud de Berceau-de-l'Hiver, à un endroit particulier (67.2,72.6). Il peut prendre un peu de temps à apparaître."
Lang["N1_15552"] = "Docteur Dwenfer"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15552
Lang["N2_15552"] = "Ce gnome se trouve dans une maison sur l'île d'Alcaz dans le Marécage d'Âprefange (77.8,17.6). Préparez-vous au choc !"
Lang["N1_10184"] = "Onyxia"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10184
Lang["N2_10184"] = "Quand elle n'est pas une Dame à Hurlevent, Onyxia reste dans son repaire, au sud du Marécage d'Âprefange."
Lang["N1_11502"] = "Ragnaros"	-- https://www.thegeekcrusade-serveur.com/db/?npc=11502
Lang["N2_11502"] = "Ragnaros, Le Seigneur du Feu, est le 10ème et dernier boss du Coeur du Magma."
Lang["N1_12803"] = "Seigneur Lakmaeran"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12803
Lang["N2_12803"] = "Se trouve sur l'île de l'Effroi (Féralas), juste un peu au nord de la zone aux chimères (29.8,72.6)."
Lang["N1_15571"] = "Crocs-de-la-mer"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15571
Lang["N2_15571"] = "duunnn dunnn... duuuunnnn duun... duuunnnnnnnn dun dun dun dun dun dun dun dun dun dun dunnnnnnnnnnn dunnnn dans Azshara (à 65.6,54.6)"
Lang["N1_22037"] = "Gorlunk le forgeron"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22037
Lang["N2_22037"] = "Il se trouve à la forge évidemment (67,36), du coté nord de l'entrée du Temple Noir"
Lang["N1_18733"] = "Saccageur gangrené"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18733
Lang["N2_18733"] = "Il a tendance à se promener du coté ouest de la Citadelle des Flammes infernales."
Lang["N1_18473"] = "Roi-serre Ikiss"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18473
Lang["N2_18473"] = "Le Roi-serre est le dernier boss des Salles des Sethekk dans Auchindoun"
Lang["N1_20142"] = "Régisseur du temps"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20142
Lang["N2_20142"] = "Dragon du Vol de Bronze, près du sablier dans les Grottes du Temps."
Lang["N1_20130"] = "Andormu"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20130
Lang["N2_20130"] = "Ressemble à un petit garçon, près du sablier dans les Grottes du Temps."
Lang["N1_18096"] = "Chasseur d'époques"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18096
Lang["N2_18096"] = "Dernier boss de Hautebrande d'antan (Grottes du Temps), apparaît dans Moulin-de-Tarren quand Thrall y arrive enfin."
Lang["N1_19880"] = "Traqueur-du-Néant Khay'ji"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19880
Lang["N2_19880"] = "Se trouve près de la forge de la zone 52 (32,64)."
Lang["N1_19641"] = "Ecumeur-dimensionnel Nesaad"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19641
Lang["N2_19641"] = "Il se trouve à (28,79). il a deux potes avec lui."
Lang["N1_18481"] = "A'dal"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18481
Lang["N2_18481"] = "A'dal est en plein milieu de Shattrath. Un grand truc jaune qui brille. Difficile de le rater."
Lang["N1_19220"] = "Pathaleon le Calculateur"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19220
Lang["N2_19220"] = "Pathaleon le Calculateur est le dernier boss du Méchanar."
Lang["N1_17977"] = "Brise-dimension"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17977
Lang["N2_17977"] = "Brise-dimension est le 5eme boss de la Botanica. C'est un grand elementaire arbre."
Lang["N1_17613"] = "Archimage Alturus"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17613
Lang["N2_17613"] = "L'Archimage Alturus se trouve juste devant l'entrée de Karazhan."
Lang["N1_18708"] = "Marmon"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18708
Lang["N2_18708"] = "Marmon est le dernier boss du Labyrinthe des ombres. C'est un grand élémentaire du son."
Lang["N1_17797"] = "Hydromancienne Thespia"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17797
Lang["N2_17797"] = "Thespia est le premier boss du Caveau de la vapeur dans le Réservoir de Glissecroc."
Lang["N1_20870"] = "Zereketh le Délié"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20870
Lang["N2_20870"] = "Zereketh est le premier boss de l'Arcatraz."
Lang["N1_15608"] = "Medivh"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15608
Lang["N2_15608"] = "Medivh est près de la Porte des Ténèbres, dans la partie sud du Noir Marécage."
Lang["N1_16524"] = "Ombre d'Aran"	-- https://www.thegeekcrusade-serveur.com/db/?npc=16524
Lang["N2_16524"] = "Le père un peu fou de Medivh, dans Karazhan"
Lang["N1_16807"] = "Grand démoniste Néanathème"	-- https://www.thegeekcrusade-serveur.com/db/?npc=16807
Lang["N2_16807"] = "Le Grand démoniste est un Gangr'orc, le premier boss des Salles brisées."
Lang["N1_18472"] = "Tisseur d'ombre Syth"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18472
Lang["N2_18472"] = "Syth est un Arakkoa, premier boss des Salles des Sethekk."
Lang["N1_22421"] = "Skar'this l'Hérétique"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22421
Lang["N2_22421"] = "Skar'this n'est présent que dans la version héroïque des Enclos aux esclaves. Il se trouve juste après le premier boss. Quand on saute dans une petite marre, il est à gauche à la sortie, dans une petite cage."
Lang["N1_19044"] = "Gruul le Tue-dragon"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19044
Lang["N2_19044"] = "Gruul est un énorme gronn, dernier boss du raid Repaire de Gruul dans les Tranchantes."
Lang["N1_17225"] = "Plaie-de-nuit"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17225
Lang["N2_17225"] = "Plaie-de-nuit est un boss optionel, invoquable dans Karazhan. Allez voir son accès pour plus de détails."
Lang["N1_21938"] = "Soigneterre Sabot-cagneux"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21938
Lang["N2_21938"] = "Sabot-cagneux est à l'intérieur du petit bâtiment, au point le plus haut du village Ombrelune (28.6,26.6)."
Lang["N1_21183"] = "Oronok Coeur-fendu"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21183
Lang["N2_21183"] = "Oronok Coeur-fendu est en haut d'une colline à un endroit appelé la Ferme d'Oronok (53.8,23.4), entre la Halte de Glissentaille et l'autel de Sha'tar."
Lang["N1_21291"] = "Grom'tor, fils d'Oronok"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21291
Lang["N2_21291"] = "Se trouve à la Halte de Glissentaille (44.6,23.6)."
Lang["N1_21292"] = "Ar'tor, fils d'Oronok"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21292
Lang["N2_21292"] = "Se trouve à la Halte Illidari (29.6,50.4), suspendu dans l'air par des rayons rouges."
Lang["N1_21293"] = "Borak, fils d'Oronok"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21293
Lang["N2_21293"] = "Juste au nord du Site d'éclipse (47.6,57.2)."
Lang["N1_18166"] = "Khadgar"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18166
Lang["N2_18166"] = "Se trouve au centre de Shattrath, juste à coté d'A'dal, le grand truc jaune brillant."
Lang["N1_16808"] = "Chef de guerre Kargath Lamepoing"	-- https://www.thegeekcrusade-serveur.com/db/?npc=16808
Lang["N2_16808"] = "Kargath Lamepoing est le dernier boss des Salles brisées. Alerte spoiler, il a des lames à la place des poings."
Lang["N1_17798"] = "Seigneur de guerre Kalithreshh"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17798
Lang["N2_17798"] = "Kalithresh est le 3eme et dernier boss du Caveau de la vapeur dans le Réservoir de Glissecroc."
Lang["N1_20912"] = "Messager Cieuriss"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20912
Lang["N2_20912"] = "Cieuriss est le 5eme et dernier boss de la bataille finale de l'Arcatraz."
Lang["N1_20977"] = "Milhouse Tempête-de-mana"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20977
Lang["N2_20977"] = "Millhouse est un mage gnome qui apparait pendant la bataille contre Cieuriss dans l'Arcratraz. Il se trouve dans une des cellules et rejoint le combat quand les monstres sont liberés."
Lang["N1_17257"] = "Magtheridon"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17257
Lang["N2_17257"] = "Magtheridon est retenu prisonnier sous la Citadelle des Flammes infernales, dans le raid appelé le Repaire de Magtheridon."
Lang["N1_21937"] = "Soigneterre Sophurus"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21937
Lang["N2_21937"] = "Sophurus se tient a l'exterieur de l'auberge du Bastion des Marteaux-hardis (36.4,56.8)."
Lang["N1_19935"] = "Soridormi"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19935
Lang["N2_19935"] = "Soridormi se promène autour du sablier dans les Grottes du Temps."
Lang["N1_19622"] = "Kael'thas Haut-soleil"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19622
Lang["N2_19622"] = "Kael'thas est le 4eme et dernier boss du raid appele L'OEil, dans le Donjon de la Tempête, à Raz-de-Néant."
Lang["N1_21212"] = "Dame Vashj"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21212
Lang["N2_21212"] = "Dame Vashj est la dernière boss du raid appelé la Caverne du Sanctuaire du Serpent, dans le Réservoir de Glissecroc."
Lang["N1_21402"] = "Anachorète Ceyla"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21402
Lang["N2_21402"] = "Ceyla est à l'Autel des Sha'tar (62.6,28.4)."
Lang["N1_21955"] = "Arcaniste Thelis"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21955
Lang["N2_21955"] = "Thelis est à l'intérieur du Sanctum des Étoiles (56.2,59.6)"
Lang["N1_21962"] = "Udalo"	-- https://www	.thegeekcrusade-serveur.com/db/?npc=21962
Lang["N2_21962"] = "Il est couché, mort, sur la petite rampe just avant le dernier boss dans l'Arcatraz."
Lang["N1_22006"] = "Seigneur de l'ombre Morteplainte"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22006
Lang["N2_22006"] = "Il est à dos de dragon, en haut de la tour nord du Temple Noir (71.6,35.6)"
Lang["N1_22820"] = "Voyant Olum"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22820
Lang["N2_22820"] = "Olum est à l'intérieur de la Caverne du sanctuaire du Serpent, juste derrière le Seigneur des fonds Karathress."
Lang["N1_21700"] = "Akama"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21700
Lang["N2_21700"] = "Akama se trouve à la Cage de la gardienne (58.0,48.2)."
Lang["N1_19514"] = "Al'ar"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19514
Lang["N2_19514"] = "Al'ar est le premier boss du raid L'OEil. C'est un grand oiseau de feu."
Lang["N1_17767"] = "Rage Froidhiver"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17767
Lang["N2_17767"] = "Rage Froidhiver est le premier boss du raid appelé Mont Hyjal."
Lang["N1_18528"] = "Xi'ri"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18528
Lang["N2_18528"] = "Xi'ri est à l'entrée du Temple Noir. C'est un grand truc bleu qui brille. On ne peut pas le rater non plus."
--v243
Lang["N1_22497"] = "V'eru"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22497
Lang["N2_22497"] = "V'eru est dans la même pièce qu'A'dal, mais il est bleu. Il est sur le palier supérieur."
--v244
Lang["N1_22113"] = "Mordenai"
Lang["N2_22113"] = "Un elfe de sang (alerte spoiler, en fait un dragon) qui parcourt les champs de l'Aile-du-néant juste à l'est du Sanctum des étoiles"
--v247
Lang["N1_8888"]  = "Franclorn Forgewright"
Lang["N2_8888"]  = "Un nain fantôme, debout sur sa propre tombe À L'EXTÉRIEUR du donjon, dans la structure suspendue au-dessus de la lave. Vous ne pouvez interagir avec lui que si vous êtes MORT."
Lang["N1_9056"]  = "Fineous Darkvire"
Lang["N2_9056"]  = "Il est À L'INTÉRIEUR du donjon et patrouille dans la carrière à l'extérieur de la chambre de Lord Incendius."
Lang["N1_10837"] = "Grand exécuteur Derrington"
Lang["N2_10837"] = "Il peut être trouvé au Rempart, près de la frontière de Tirisfal et des Maleterres de l'Ouest"
Lang["N1_10838"] = "Commandant Ashlam Valorfist"
Lang["N2_10838"] = "Il peut être trouvé au Chillwind Camp, juste au sud d'Andorhal dans les Maleterres de l'Ouest"
Lang["N1_1852"]  = "Araj l'Invocateur"
Lang["N2_1852"]  = "Le Lich, au coeur d'Andorhal"
--v250
Lang["N1_13278"]  = "Duc Hydraxis"
Lang["N2_13278"]  = "Un grand élémentaire d'eau sur une petite île lointaine d'Azshara (79.2,73.6)"
Lang["N1_12264"]  = "Shazzrah"
Lang["N2_12264"]  = "Shazzrah est le 5ème boss du Coeur du Magma."
Lang["N1_12118"]  = "Lucifron"
Lang["N2_12118"]  = "Lucifron est le 1er boss du Coeur du Magma."
Lang["N1_12259"]  = "Gehennas"
Lang["N2_12259"]  = "Gehennas est le 3ème boss du Coeur du Magma."
Lang["N1_12098"]  = "Messager Sulfuron"
Lang["N2_12098"]  = "Sulfuron, Messager de Ragnaros, est le 8ème boss du Coeur du Magma."




--WOTLK NPCs
--WOTLK QUESTS
-- The ids are N1_<NPCId> and N2_<NPCId>
-- N1 is just the name of the NPC
-- N2 is a helpful description
Lang["N1_29795"]  = "Koltira Tissemort"
Lang["N2_29795"]  = "Ne le cherchez pas sur le sol. Il est à bord de la canonnière le Marteau d'Orgrim, qui vole quelque part au dessus de la plaine entre Ymirheim et La Chute de Syndragosa."
Lang["N1_29799"]  = "Thassarian"
Lang["N2_29799"]  = "Ne le cherchez pas sur le sol. Il est à bord de la canonnière Brise-ciel, qui vole quelque part au dessus de la plaine entre Ymirheim et La Chute de Syndragosa."
Lang["N1_29804"]  = "Baron Lesquille"
Lang["N2_29804"]  = "Il est a l'extérieur, au sud de la tour, près de l'entrée (44, 24.6).\n\nUne fois les quêtes finies il se déplace à (42.8, 25.1)."
Lang["N1_29747"]  = "L'Oculaire"
Lang["N2_29747"]  = "Un gros Œil bleu (donc pas de Sauron) au somment du Caveau des Ombres (44.6, 21.6).\n\nZappez le juste 10 fois avec la Pétoire pandan'leil"
Lang["N1_29769"]  = "Vil"
Lang["N2_29769"]  = "Il se tient sur la platforme un peu au sud du Baron Lesquille (44.4, 26.9)."
Lang["N1_29770"]  = "Bois-de-nuit"
Lang["N2_29770"]  = "Elle est plus haut, sur une petite platforme a l'ouest du Baron Lesquille (41.9, 24.5)."
Lang["N1_29840"]  = "Le Bondisseur"
Lang["N2_29840"]  = "Il bondit tout autour de la platforme la plus-haute au dessus du Baron Lesquille (45.0, 23.8).\nIl peut être dur à reperer, utilisez '/tar Le Bond'"
Lang["N1_29851"]  = "Général Plaie-de-lumière"
Lang["N2_29851"]  = "Il arrive une fois que vous cliquez sur le tas d'armes dans le Caveau des Ombres. Les 3 que vous venez de tuer viennent vous aider pendant la bataille.\n\nVous pouvez entrer et sortir directement en volant (44.9, 20.0)."
Lang["N1_26181"]  = "Emissaire Sabot-brillant"
Lang["N2_26181"]  = "Fait un grand cercle dans la partie inferieure du camp de refugiés dans le Désolation des Dragons, à la frontiere de la Toundra Boréenne (13.9, 48.6)."
Lang["N1_26652"]  = "Grande-mère Brume-Glace"
Lang["N2_26652"]  = "Elle marche dans la cour du Marteau d'Agmar. Elle porte une armure bleue et et un bâton violet."
Lang["N1_26505"]  = "Docteur Sintar Maléfious"
Lang["N2_26505"]  = "Il est dans le coin Alchimie du Marteau D'Agmar (36.1, 48.8)."
Lang["N1_25257"]  = "Saurcroc le jeune"
Lang["N2_25257"]  = "Il est près du le portail du Courroux, dans le coin Nord-Ouest du Désolation des Dragons (40.7, 18.1).\n\nNe vous attachez pas trop à lui!"
Lang["N1_31333"]  = "Alexstrasza la Lieuse-de-vie"
Lang["N2_31333"]  = "Elle est maintenant dans sa forme de dragon, face au portail du Courroux. Elle est plutot grande, dure à rater (38.3, 19.2)."
Lang["N1_25256"]  = "Haut seigneur Saurcroc"
Lang["N2_25256"]  = "Saurcroc est le perso principal de Chuck Norris. Il est tout en bas du Bastion Chanteguerre, dans la Toundra Boréenne (41.4, 53.7)."
Lang["N1_27136"]  = "Haut-commandant Halford Verroctone"
Lang["N2_27136"]  = "Il est vers le haut de la forteresse de Garde-Hiver (78.5, 48.3)."
Lang["N1_27872"]  = "Généralissime Bolvar Fordragon"
Lang["N2_27872"]  = "Bolvar Fordragon, un vrai héro de l'Alliance, frappé d'un terrible destin.\n\nIl l'attend à (37.8, 23.4)."
Lang["N1_29611"]  = "Roi Varian Wrynn"
Lang["N2_29611"]  = "Il n'a pas l'air super content.."
Lang["N1_29473"]  = "Gretchen Pfutincelle"
Lang["N2_29473"]  = "Elle est dans l'auberge de K3 (41.2, 86.1)."
Lang["N1_15989"]  = "Saphiron"
Lang["N2_15989"]  = "Saphiron est un gigantesque dragon mort-vivant qui guarde le chemin des chambres de Kel'Thuzad à Naxxramas."

Lang["N1_"]  = ""
Lang["N2_"]  = ""



Lang["O_1"] = "Cliquez sur la Marque de Drakkisath pour compléter la quête.\nC'est le globe brillant qui se trouve juste drrière Drakkisath."
Lang["O_2"] = "C'est un minuscule point rouge brillant sur le sol\nen face des portes d'Ahn'Qiraj (28.7,89.2)."
--v247
Lang["O_3"] = "Le sanctuaire est situé au bout d'un couloir\nqui part du niveau supérieur de l'Anneau de la Loi."
Lang["O_189311"] = "|cFFFFFFFFTome relié de chair|r\n|cFF808080Cet objet permet de lancer une quête|r\n\nLe livre est sur le sol de la crypte,\nprès du Nécro-seigneur Amarion (78.3, 52.3).\n\nUne fois que vous l'avez, depechez vous de partir\ncar des enemis vont apparaitre."
Lang["Flesh-bound Tome"] = "Tome relié de chair"


-- à : \195\160    è : \195\168    ì : \195\172    ò : \195\178    ù : \195\185
-- á : \195\161    é : \195\169    í : \195\173    ó : \195\179    ú : \195\186
-- â : \195\162    ê : \195\170    î : \195\174    ô : \195\180    û : \195\187
-- ã : \195\163    ë : \195\171    ï : \195\175    õ : \195\181    ü : \195\188
-- ä : \195\164                    ñ : \195\177    ö : \195\182
-- æ : \195\166                                    ø : \195\184
-- ç : \195\167                                    œ : \197\147
-- Ä : \195\132   Ö : \195\150   Ü : \195\156    ß : \195\159
