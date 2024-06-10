local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "frFR");
if (not L) then
	return;
end

--Rend buff aura name.
L["Warchief's Blessing"] = "Bénédiction du chef de guerre";
--Onyxia and Nefarian buff aura name.
L["Rallying Cry of the Dragonslayer"] = "Cri de ralliement du tueur de dragon";
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = "Sérénade de fleur-de-chant";
L["Songflower"] = "Fleur-de-chant";
--Spirit of Zandalar.
L["Spirit of Zandalar"] = "Esprit des Zandalar";
L["Flask of Supreme Power"] = "Flacon de pouvoir suprême";
L["Flask of the Titans"] = "Flacon des Titans";
L["Flask of Distilled Wisdom"] = "Flacon de sagesse distillée";
L["Flask of Chromatic Resistance"] = "Flacon de résistance chromatique";
--3 of the flasks spells seem to be named differently than the flask item, but titan is exact same name as the flask item.
L["Supreme Power"] = "Pouvoir suprême";
L["Distilled Wisdom"] = "Sagesse distillée";
L["Chromatic Resistance"] = "Résistance chromatique";
L["Sap"] = "Assommer";
L["Fire Festival Fortitude"] = "Robustesse de la fête du feu";
L["Fire Festival Fury"] = "Fureur de la fête du feu";
L["Ribbon Dance"] = "Danse des rubans";
L["Traces of Silithyst"] = "Traces de silithyste";
L["Slip'kik's Savvy"] = "Jugeote de Slip'kik";
L["Fengus' Ferocity"] = "Férocité de Fengus";
L["Mol'dar's Moxie"] = "Détermination de Mol'dar";
L["Boon of Blackfathom"] = "Bienfait de Brassenoire";
L["Ashenvale Rallying Cry"] = "Cri de ralliement d’Ashenvale";
L["Spark of Inspiration"] = "Étincelle d’inspiration"; --Phase 2 SoD world buff.

--Horde Orgrimmar Rend buff NPC.
L["Thrall"] = "Thrall";
--Horde The Barrens Rend buff NPC.
L["Herald of Thrall"] = "Héraut de Thrall";
--Horde rend buff NPC first yell string (part of his first yell msg before before buff).
L["Rend Blackhand, has fallen"] = "Le faux chef Rend Blackhand est tombé";
--Horde rend buff NPC second yell string (part of his second yell msg before before buff).
L["Be bathed in my power"] = "Que ma puissance vous baigne";

--Horde Onyxia buff NPC.
L["Overlord Runthak"] = "Seigneur Runthak";
--Horde Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["Onyxia, has been slain"] = "Peuple de la Horde, citoyens d'Orgrimmar";
--Horde Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Be lifted by the rallying cry"] = "Soyez témoins de la puissance de votre Chef de guerre";

--Horde Nefarian buff NPC.
L["High Overlord Saurfang"] = "Haut seigneur Saurfang";
--Horde Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["NEFARIAN IS SLAIN"] = "NEFARIAN A ÉTÉ TUÉ";
--Horde Nefarian buff NPC second yell string (part of his second yell msg before before buff).
--L["Revel in his rallying cry"] = "";

---========---
---Alliance---
---========---

--Alliance Onyxia buff NPC.
L["Major Mattingly"] = "Major Mattingly";
--Alliance Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["history has been made"] = "Citoyens et alliés de Stormwind, ce jour est historique";
--Alliance Onyxia buff NPC second yell string (part of his second yell msg before before buff).
L["Onyxia, hangs from the arches"] = "La terrible Onyxia est accrochée";


--Alliance Nefarian buff NPC.
L["Grand maréchal Afrasiabi"] = "Grand maréchal Afrasiabi";
L["Field Marshal Stonebridge"] = "Grand maréchal Pont-de-Pierre";
--Alliance Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["the Lord of Blackrock is slain"] = "le seigneur du clan Blackrock";
--Alliance Nefarian buff NPC second yell string (part of his second yell msg before before buff).
L["Revel in the rallying cry"] = "Ralliez-vous autour de votre champion";

---===========----
---NPC's killed---
---============---

L["onyxiaNpcKilledHorde"] = "Seigneur Runthak a été tué (PNJ Onyxia buff).";
L["onyxiaNpcKilledAlliance"] = "Major Mattingly a été tué (PNJ Onyxia buff).";
L["nefarianNpcKilledHorde"] = "Haut seigneur Saurfang a été tué (PNJ Nefarian buff).";
L["nefarianNpcKilledAlliance"] = "Grand maréchal Afrasiabi a été tué (PNJ Nefarian buff).";
L["onyxiaNpcKilledHordeWithTimer"] = "Le PNJ d'Onyxia (Runthak) a été tué il y a %s, pas de buff enregistré depuis";
L["nefarianNpcKilledHordeWithTimer"] = "Le PNJ de Nefarian (Saurfang) a été tué il y a %s, pas de buff enregistré depuis";
L["onyxiaNpcKilledAllianceWithTimer"] = "Le PNJ d'Onyxia (Mattingly) a été tué il y a %s, pas de buff enregistré depuis";
L["nefarianNpcKilledAllianceWithTimer"] = "Le PNJ de Nefarian (Afrasiabi) a été tué il y a %s, pas de buff enregistré depuis";
L["anyNpcKilledWithTimer"] = "Le PNJ a été tué il y a %s";

---==============---
---Darkmoon Faire---
---==============---

L["Darkmoon Faire"] = "Foire de Sombrelune";
L["Sayge's Dark Fortune of Agility"] = "Sombre prédiction d'Agilité de Sayge";
L["Sayge's Dark Fortune of Intelligence"] = "Sombre prédiction d'Intelligence de Sayge";
L["Sayge's Dark Fortune of Spirit"] = "Sombre prédiction d'Esprit de Sayge";
L["Sayge's Dark Fortune of Stamina"] = "Sombre prédiction d'Endurance de Sayge";
L["Sayge's Dark Fortune of Strength"] = "Sombre prédiction de Force de Sayge";
L["Sayge's Dark Fortune of Armor"] = "Sombre prédiction d'Armure de Sayge";
L["Sayge's Dark Fortune of Resistance"] = "Sombre prédiction de résistance de Sayge";
L["Sayge's Dark Fortune of Damage"] = "Sombre prédiction de dégâts de Sayge";
L["dmfBuffCooldownMsg"] = "Temps de recharge du buff Sombrelune : %s";
L["dmfBuffCooldownMsg2"] = "Temps de recharge du buff Sombrelune : %s";
L["dmfBuffCooldownMsg3"] = "Les temps de recharge du buff sombrelune se reinitialize pendant la maintenance du mercredi."; --/wb frame 2nd msg.
L["dmfBuffReady"] = "Votre buff de la Foire de Sombrelune a été réinitialisé.";
L["dmfBuffReset"] = "Votre buff Foire de Sombrelune est de nouveau disponible.";
L["dmfBuffDropped"] = "Buff Foire de Sombrelune %s reçue. Pour suivre les temps de recharge de 5 heures tapez /dmf";
L["dmfSpawns"] = "La Foire de Sombrelune va apparaître dans %s (%s)";
L["dmfEnds"] = "La Foire de Sombrelune est actuellement présente, elle finie dans %s (%s)";
L["mulgore"] = "Mulgore";
L["elwynnForest"] = "Forêt d'Elwynn";

---==============---
---Output Strings---
---==============---

L["rend"] = "Rend"; --Rend Blackhand
L["onyxia"] = "Onyxia"; --Onyxia
L["nefarian"] = "Nefarian"; --Nefarian
L["dmf"] = "Foire de Sombrelune"; --Darkmoon Faire
--L["noTimer"] = "Pas de minuteur"; --No timer (used only in map timer frames)
L["noTimer"] = "--"; --No timer (used only in map timer frames)
L["noCurrentTimer"] = "Actuellement pas de minuteur"; --No current timer
L["noActiveTimers"] = "Pas de minuteur actif";	--No active timers
L["newBuffCanBeDropped"] = "Un nouveau buff %s peut être activé";
L["buffResetsIn"] = "%s va réinitialiser dans %s";
L["rendFirstYellMsg"] = "Rend va être posé dans 6 secondes.";
L["onyxiaFirstYellMsg"] = "Onyxia va être posé dans 14 secondes.";
L["nefarianFirstYellMsg"] = "Nefarian va être posé dans 15 secondes.";
L["rendBuffDropped"] = "Bénédiction du chef de guerre (Rend) a été posé.";
L["onyxiaBuffDropped"] = "Cri de ralliement du tueur de dragon (Onyxia) a été posé.";
L["nefarianBuffDropped"] = "Cri de ralliement du tueur de dragon (Nefarian) a été posé.";
L["newSongflowerReceived"] = "Nouveau minuteur Songflower reçu"; --New songflower timer received
L["songflowerPicked"] = "Songflower prise à %s, prochain spawn dans 25mins."; -- Guild msg when songflower picked.
L["North Felpaw Village"] = "Village Mort-Bois nord"; --Felwood map subzones (flower1).
L["West Felpaw Village"] = "Village Mort-Bois ouest"; --Felwood map subzones (flower2).
L["North of Irontree Woods"] = "Nord des bois d'Arbrefer"; --Felwood map subzones (flower3).
L["Talonbranch Glade"] = "Clairière de Griffebranche"; --Felwood map subzones (flower4).
L["Shatter Scar Vale"] = "Val Grêlé"; --Felwood map subzones (flower5).
L["Bloodvenom Post"] = "Poste de la Vénéneuse"; --Felwood map subzones (flower6).
L["East of Jaedenar"] = "Est de Jaedenar"; --Felwood map subzones (flower7).
L["North of Emerald Sanctuary"] = "Nord du Sanctuaire d'émeraude"; --Felwood map subzones (flower8).
L["West of Emerald Sanctuary"] = "Ouest du Sanctuaire d'émeraude"; --Felwood map subzones (flower9).
L["South of Emerald Sanctuary"] = "Sud du Sanctuaire d'émeraude"; --Felwood map subzones (flower10).
L["second"] = "seconde"; --Second (singular).
L["seconds"] = "secondes"; --Seconds (plural).
L["minute"] = "minute"; --Minute (singular).
L["minutes"] = "minutes"; --Minutes (plural).
L["hour"] = "heure"; --Hour (singular).
L["hours"] = "heures"; --Hours (plural).
L["day"] = "jour"; --Day (singular).
L["days"] = "jours"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "j"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Commencera dans %s"; --"Starts in 1hour".
L["endsIn"] = "Finira dans %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Votre add-on Nova World Buffs n'est plus à jour, mettez le à jour sur https://www.curseforge.com/wow/addons/nova-world-buffs ou via l'app twitch";
L["Your Current World Buffs"] = "Vos buffs mondiaux actuels";
L["Options"] = "Options";

--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "Commencez le rituel"
L["The Blood God"] = "Le Dieu sanglant"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
L["slayer of Hakkar"] = "vainqueur d’Hakkar";

L["Spirit of Zandalar"] = "Esprit des Zandalar";
L["Molthor"] = "Molthor";
L["Zandalarian Emissary"] = "Emissaire zandalarien";
L["Whipper Root Tuber"] = "Tubercule de navetille";
L["Night Dragon's Breath"] = "Souffle de dragon nocturne";
L["Resist Fire"] = "Résistance au Feu"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "Bénédiction de Brassenoire";

L["zan"] = "Zandalar";
L["zanFirstYellMsg"] = "Zandalar va être posé dans %s secondes.";
L["zanBuffDropped"] = "Esprit des Zandalar (Hakkar) a été posé.";
L["singleSongflowerMsg"] = "La Songflower prise à %s va apparaître dans %s.";
L["spawn"] = "spawn"; --Used in Felwood map marker tooltip (03:46pm spawn).
L["Irontree Woods"] = "Bois d'Arbrefer";
L["West of Irontree Woods"] = "l'ouest du bois d'Arbrefer";
L["Bloodvenom Falls"] = "Chutes de la Vénéneuse";
L["Jaedenar"] = "Jaedenar";
L["North-West of Irontree Woods"] = "le nord du bois d'Arbrefer";
L["South of Irontree Woods"] = "le sud du bois d'Arbrefer";

L["worldMapBuffsMsg"] = "Tapez /buffs pour voir tous les\nbénéfices mondiaux actuels de vos personnages.";
L["cityMapLayerMsgHorde"] = "Actuellement à %s\nVisez un PNJ\npour mettre à jour votre couche après un changement de zone.|r";
L["cityMapLayerMsgAlliance"] = "Actuellement à %s\nVisez n'importe quel PNJ\npour mettre à jour votre couche après un changement de zone.|r";
L["noLayerYetHorde"] = "Visez n'importe quel PNJ\npour trouver votre couche actuelle.";
L["noLayerYetAlliance"] = "Visez n'importe quel PNJ\npour trouver votre couche actuelle.";
L["Reset Data"] = "Réinitialiser"; --A button to Reset buffs window data.


L["layerFrameMsgOne"] = "Les anciennes couches seront visibles quelques heures après le redémarrage du serveur."; --Msg at bottom of layer timers frame.
L["layerFrameMsgTwo"] = "Les couches disparaitront apres 8 heures d'inactivité."; --Msg at bottom of layer timers frame.
L["You are currently on"] = "Vous êtes sur le"; --You are currently on [Layer 2]


-------------
---Config---
-------------
--There are 2 types of strings here, the names end in Title or Desc L["exampleTitle"] and L["exampleDesc"].
--Title must not be any longer than 21 characters (maybe less for chinese characters because they are larger).
--Desc can be any length.

---Description at the top---
L["mainTextDesc"] = "Tapez /wb pour afficher les minuteries.\nTapez /wb <canal> pour afficher les minuteries du canal spécifié.\nFaites défiler vers le bas pour voir plus d'options.";


---Show Buffs Button
L["showBuffsTitle"] = "Buffs actuels";
L["showBuffsDesc"] = "Affiche vos buffs mondiaux actuels pour tous vos personnages ; cela peut également être ouvert en tapant /buffs ou en cliquant sur le préfixe [WorldBuffs] dans la discussion.";

---General Options---
L["generalHeaderDesc"] = "Options générales";

L["showWorldMapMarkersTitle"] = "Marqueurs de la cité";
L["showWorldMapMarkersDesc"] = "Affiche des icônes de minuterie sur la carte du monde d'Orgrimmar/Stormwind ?";

L["receiveGuildDataOnlyTitle"] = "Données de guilde";
L["receiveGuildDataOnlyDesc"] = "Cela vous empêchera de recevoir des données de minuterie de quiconque en dehors de la guilde. Activez ceci uniquement si vous pensez que quelqu'un falsifie délibérément des données de minuterie incorrectes, car cela réduira la précision de vos minuteries en ayant moins de personnes à partir desquelles extraire des données. Il sera particulièrement difficile d'obtenir des minuteries des fleurs-de-chant car elles sont très courtes. Chaque personne dans la guilde doit avoir ceci activé pour que cela fonctionne.";

L["chatColorTitle"] = "Couleur du message de discussion";
L["chatColorDesc"] = "De quelle couleur doit être le message de minuterie dans la discussion ?";

L["middleColorTitle"] = "Couleur du milieu de l'écran";
L["middleColorDesc"] = "De quelle couleur doit être le message de style d'alerte de raid au milieu de l'écran ?";

L["resetColorsTitle"] = "Réinitialiser les couleurs";
L["resetColorsDesc"] = "Réinitialise les couleurs aux valeurs par défaut.";

L["showTimeStampTitle"] = "Horodatage";
L["showTimeStampDesc"] = "Affiche un horodatage (13:23) à côté du message de minuterie ?";

L["timeStampFormatTitle"] = "Format d'horodatage";
L["timeStampFormatDesc"] = "Définit le format d'horodatage à utiliser, 12 heures (1:23 p.m.) ou 24 heures (13:23).";

L["timeStampZoneTitle"] = "Heure locale / Heure du royaume";
L["timeStampZoneDesc"] = "Utilise l'heure locale ou l'heure du royaume pour les horodatages ?";

L["colorizePrefixLinksTitle"] = "Lien coloré";
L["colorizePrefixLinksDesc"] = "Colore le préfixe [WorldBuffs] dans tous les canaux de discussion ? Ceci est le préfixe dans la discussion sur lequel vous pouvez cliquer pour afficher les buffs mondiaux actuels de tous vos personnages.";

L["showAllAltsTitle"] = "Afficher tous les alts";
L["showAllAltsDesc"] = "Affiche tous les alts dans la fenêtre /buffs même s'ils n'ont pas un buff actif ?";

L["minimapButtonTitle"] = "Bouton de la minicarte";
L["minimapButtonDesc"] = "Affiche le bouton NWB sur la minicarte ?";


---Logon Messages---
L["logonHeaderDesc"] = "Messages à la connexion";

L["logonPrintTitle"] = "Minuteries";
L["logonPrintDesc"] = "Affiche les minuteries dans la fenêtre de discussion lorsque vous vous connectez ; vous pouvez désactiver tous les messages de connexion avec ce paramètre.";

L["logonRendTitle"] = "Rend";
L["logonRendDesc"] = "Affiche la minuterie de Rend dans la fenêtre de discussion lorsque vous vous connectez.";

L["logonOnyTitle"] = "Onyxia";
L["logonOnyDesc"] = "Affiche la minuterie d'Onyxia dans la fenêtre de discussion lorsque vous vous connectez.";

L["logonNefTitle"] = "Nefarian";
L["logonNefDesc"] = "Affiche la minuterie de Nefarian dans la fenêtre de discussion lorsque vous vous connectez.";

L["logonDmfSpawnTitle"] = "Apparition de la foire";
L["logonDmfSpawnDesc"] = "Affiche le temps d'apparition de la Foire de Sombrelune ; cela ne s'affichera que lorsqu'il restera moins de 6 heures avant l'apparition ou la disparition.";

L["logonDmfBuffCooldownTitle"] = "Recharge de la foire";
L["logonDmfBuffCooldownDesc"] = "Affiche le temps de recharge de 4 heures de le buff de la Foire de Sombrelune, cela ne s'affichera que lorsque vous aurez un temps de recharge actif et lorsque la Foire de Sombrelune sera active.";


---Chat Window Timer Warnings---
L["chatWarningHeaderDesc"] = "Annonces de minuterie dans la fenêtre de discussion";

L["chat30Title"] = "30 Minutes";
L["chat30Desc"] = "Affiche un message dans la discussion lorsqu'il reste 30 minutes.";

L["chat15Title"] = "15 Minutes";
L["chat15Desc"] = "Affiche un message dans la discussion lorsqu'il reste 15 minutes.";

L["chat10Title"] = "10 Minutes";
L["chat10Desc"] = "Affiche un message dans la discussion lorsqu'il reste 10 minutes.";

L["chat5Title"] = "5 Minutes";
L["chat5Desc"] = "Affiche un message dans la discussion lorsqu'il reste 5 minutes.";

L["chat1Title"] = "1 Minute";
L["chat1Desc"] = "Affiche un message dans la discussion lorsqu'il reste 1 minute.";

L["chatResetTitle"] = "Buff réinitialisé";
L["chatResetDesc"] = "Affiche un message dans la discussion lorsqu'un buff est réinitialisé";

L["chatZanTitle"] = "Buff Zandalar";
L["chatZanDesc"] = "Affiche un message dans la discussion 30 secondes avant le début du buff Zandalar lorsque le PNJ commence à crier.";

---Middle Of The Screen Timer Warnings---
L["middleWarningHeaderDesc"] = "Annonces de minuterie au milieu de l'écran";

L["middle30Title"] = "30 Minutes";
L["middle30Desc"] = "Affiche un message de style d'alerte de raid au milieu de l'écran lorsqu'il reste 30 minutes.";

L["middle15Title"] = "15 Minutes";
L["middle15Desc"] = "Affiche un message de style d'alerte de raid au milieu de l'écran lorsqu'il reste 15 minutes.";

L["middle10Title"] = "10 Minutes";
L["middle10Desc"] = "Affiche un message de style d'alerte de raid au milieu de l'écran lorsqu'il reste 10 minutes.";

L["middle5Title"] = "5 Minutes";
L["middle5Desc"] = "Affiche un message de style d'alerte de raid au milieu de l'écran lorsqu'il reste 5 minutes.";

L["middle1Title"] = "1 Minute";
L["middle1Desc"] = "Affiche un message de style d'alerte de raid au milieu de l'écran lorsqu'il reste 1 minute.";

L["middleResetTitle"] = "Buff réinitialisé";
L["middleResetDesc"] = "Affiche un message de style d'alerte de raid au milieu de l'écran lorsqu'un buff est réinitialisé";

L["middleBuffWarningTitle"] = "Annonce de buff";
L["middleBuffWarningDesc"] = "Affiche un message de style d'alerte de raid au milieu de l'écran lorsque quelqu'un remet la tête et que le PNJ crie quelques secondes avant le début du buff.";

L["middleHideCombatTitle"] = "Cacher en combat";
L["middleHideCombatDesc"] = "Cache les annonces au milieu de l'écran pendant le combat ?";

L["middleHideRaidTitle"] = "Cacher en raid";
L["middleHideRaidDesc"] = "Cache les annonces au milieu de l'écran en raid ? (Ne se cache pas dans les donjons)";


---Guild Messages---
L["guildWarningHeaderDesc"] = "Messages de guilde";

L["guild10Title"] = "10 Minutes";
L["guild10Desc"] = "Envoie un message dans le canal de la guilde lorsqu'il reste 10 minutes.";

L["guild1Title"] = "1 Minute";
L["guild1Desc"] = "Envoie un message dans le canal de la guilde lorsqu'il reste 1 minute.";

L["guildNpcDialogueTitle"] = "Dialogue avec PNJ";
L["guildNpcDialogueDesc"] = "Envoie un message à la guilde lorsque quelqu'un remet une tête et que le PNJ crie d'abord et que vous avez encore le temps de vous reconnecter si vous êtes rapide.";

L["guildBuffDroppedTitle"] = "Nouveau buff";
L["guildBuffDroppedDesc"] = "Envoie un message à la guilde lorsque qu'un nouveau buff est commencé. Ce message est envoyé après que le PNJ ait fini de crier et que vous obtenez le buff réel quelques secondes plus tard. (6 secondes après le premier cri pour Rend, 14 secondes pour Onyxia, 15 secondes pour Nefarian)";

L["guildZanDialogueTitle"] = "Buff Zandalar";
L["guildZanDialogueDesc"] = "Envoie un message à la guilde lorsque le buff Esprit de Zandalar est sur le point de commencer. (Si vous ne voulez aucun message de guilde pour ce buff, alors tous dans la guilde doivent le désactiver).";

L["guildNpcKilledTitle"] = "PNJ tué";
L["guildNpcKilledDesc"] = "Envoie un message à la guilde lorsque l'un des PNJ a été tué à Orgrimmar ou Stormwind? (réinitialisation de contrôle mental).";

L["guildCommandTitle"] = "Commandes";
L["guildCommandDesc"] = "Répond-il avec des informations de minuterie aux commandes !wb et !dmf dans la discussion de guilde? Vous devriez probablement laisser cela activé pour aider votre guilde, si vous voulez vraiment désactiver tous les messages de guilde et laisser seulement cette commande, alors décochez tout le reste dans la section de la guilde et ne cochez pas Activer tous les messages de la guilde en haut.";

L["disableAllGuildMsgsTitle"] = "Désactiver tout";
L["disableAllGuildMsgsDesc"] = "Désactive tous les messages de guilde, y compris les minuteries et les notifications de drop de buff? Note: Vous pouvez désactiver tous les messages un par un ci-dessus et laisser simplement certaines choses activées pour aider votre guilde si vous préférez.";


---Songflowers---
L["songflowersHeaderDesc"] = "Fleurs-de-chant";

L["guildSongflowerTitle"] = "Guilde";
L["guildSongflowerDesc"] = "Informez votre discussion de guilde lorsque vous avez collecté une fleur-de-chant ?";

L["mySongflowerOnlyTitle"] = "Collecter";
L["mySongflowerOnlyDesc"] = "Enregistre un nouveau minuteur uniquement lorsque je collecte une fleur-de-chant et non lorsque d'autres en collectent devant moi ? Cette option est là au cas où vous auriez des problèmes avec de faux minuteurs définis par d'autres joueurs. Actuellement, il n'y a aucun moyen de savoir si le buff d'un autre joueur est nouveau, donc un minuteur peut être activé dans de rares occasions si le jeu charge le buff de la fleur-de-chant chez une autre personne lorsqu'elle se connecte devant vous près d'une fleur-de-chant.";

L["syncFlowersAllTitle"] = "Synchroniser";
L["syncFlowersAllDesc"] = "Activez ceci pour remplacer la configuration de données de guilde unique en haut de cette configuration afin de pouvoir partager des données de fleur-de-chant en dehors de la guilde mais conserver uniquement les données de la guilde sur le buff mondial.";

L["showNewFlowerTitle"] = "Nouvelles fleurs-de-chant";
L["showNewFlowerDesc"] = "Cela vous montrera dans la fenêtre de discussion lorsqu'un nouveau minuteur de fleur-de-chant d'un autre joueur qui n'est pas dans votre guilde est trouvé (les messages de guilde sont déjà affichés dans la discussion de guilde lorsqu'une fleur est collectée).";

L["showSongflowerWorldmapMarkersTitle"] = "Fleur-de-chant sur la carte du monde";
L["showSongflowerWorldmapMarkersDesc"] = "Affiche des icônes de fleur-de-chant sur la carte du monde ?";

L["showSongflowerMinimapMarkersTitle"] = "Fleur-de-chant sur la minicarte";
L["showSongflowerMinimapMarkersDesc"] = "Affiche des icônes de fleur-de-chant sur la minicarte ?";

L["showTuberWorldmapMarkersTitle"] = "Tubercule sur la carte du monde";
L["showTuberWorldmapMarkersDesc"] = "Affiche des icônes de tubercule sur la carte du monde ?";

L["showTuberMinimapMarkersTitle"] = "Tubercule sur la minicarte";
L["showTuberMinimapMarkersDesc"] = "Affiche des icônes de tubercule sur la minicarte ?";

L["showDragonWorldmapMarkersTitle"] = "Souffle de dragon sur la carte du monde";
L["showDragonWorldmapMarkersDesc"] = "Affiche des icônes de souffle de dragon nocturne sur la carte du monde ?";

L["showDragonMinimapMarkersTitle"] = "Souffle de dragon sur la minicarte";
L["showDragonMinimapMarkersDesc"] = "Affiche des icônes de souffle de dragon nocturne sur la minicarte ?";

L["showExpiredTimersTitle"] = "Expiré";
L["showExpiredTimersDesc"] = "Affiche les minuteurs expirés à Gangrebois ? Ils seront affichés en texte rouge pour indiquer depuis combien de temps le minuteur a expiré, le délai par défaut est de 5 minutes (on dit que les fleurs-de-chant restent nettes pendant 5 minutes après leur apparition).";

L["expiredTimersDurationTitle"] = "Durée";
L["expiredTimersDurationDesc"] = "Combien de temps devraient durer les minuteurs de Gangrebois après leur expiration sur la carte du monde ?";


---Darkmoon Faire---
L["dmfHeaderDesc"] = "Foire de Sombrelune";

L["dmfTextDesc"] = "Le temps de recharge de le buff des dégâts de la Foire de Sombrelune sera également affiché sur l'icône de la carte de la Foire de Sombrelune lorsque vous survolerez celle-ci, si vous avez un temps de recharge et que la Foire est actuellement active.";

L["showDmfWbTitle"] = "Afficher avec /wb";
L["showDmfWbDesc"] = "Affiche le minuteur d'apparition de la Foire de Sombrelune avec la commande /wb ?";

L["showDmfBuffWbTitle"] = "Recharge /wb";
L["showDmfBuffWbDesc"] = "Affiche le minuteur de recharge de le buff de la Foire de Sombrelune avec la commande /wb ? Ne s'affiche que lorsque vous êtes en recharge active et que la Foire est actuellement active.";

L["showDmfMapTitle"] = "Marqueur de carte";
L["showDmfMapDesc"] = "Affiche le marqueur de carte de la Foire avec minuteur d'apparition et informations de recharge des buffs sur les cartes de Mulgore et de la forêt d'Elwynn (ce qui suit). Vous pouvez également écrire /dmf map pour ouvrir la carte vers ce marqueur.";


---Guild Chat Filter---
L["guildChatFilterHeaderDesc"] = "Filtre de discussion de guilde";

L["guildChatFilterTextDesc"] = "Cela bloquera tout message de guilde provenant de cet add-on que vous choisissez de ne pas voir. Cela empêchera que vous voyiez vos propres messages et ceux d'autres utilisateurs de l'add-on dans la discussion de guilde.";

L["filterYellsTitle"] = "Annonce";
L["filterYellsDesc"] = "Filtre le message lorsque qu'un buff est sur le point de disparaître dans quelques secondes (Onyxia va disparaître dans 14 secondes).";

L["filterDropsTitle"] = "Buff disparu";
L["filterDropsDesc"] = "Filtre le message lorsqu'un buff a disparu (L'appel du tueur de dragons (Onyxia) a disparu).";

L["filterTimersTitle"] = "Minuteur";
L["filterTimersDesc"] = "Filtre les messages du minuteur (Onyxia se réinitialise dans 1 minute).";

L["filterCommandTitle"] = "Commande !wb";
L["filterCommandDesc"] = "Filtre !wb et !dmf dans la discussion de guilde lorsque les joueurs les utilisent.";

L["filterCommandResponseTitle"] = "Réponse !wb";
L["filterCommandResponseDesc"] = "Filtre le message de réponse avec les minuteurs que cet add-on génère lors de l'utilisation de !wb ou !dmf.";

L["filterSongflowersTitle"] = "Fleur-de-chant";
L["filterSongflowersDesc"] = "Filtre le message lorsque vous collectez une fleur-de-chant.";

L["filterNpcKilledTitle"] = "PNJ tué";
L["filterNpcKilledDesc"] = "Filtre le message lorsque vous remettez un objet à un PNJ dans votre ville.";


---Sounds---
L["soundsHeaderDesc"] = "Sons";

L["soundsTextDesc"] = "Définissez le son sur \"Aucun\" pour le désactiver.";

L["disableAllSoundsTitle"] = "Désactiver tous les sons";
L["disableAllSoundsDesc"] = "Désactive tous les sons de cet add-on.";

L["extraSoundOptionsTitle"] = "Options supplémentaires de son";
L["extraSoundOptionsDesc"] = "Activez ceci pour afficher tous les sons de tous vos add-ons en même temps dans les listes déroulantes ici.";

L["soundOnlyInCityTitle"] = "Seulement en ville";
L["soundOnlyInCityDesc"] = "Ne joue que des sons de buff lorsque vous êtes dans la principale ville où les buffs tombent (Vendetta inclus pour le buff de Zandalar).";

L["soundsDisableInInstancesTitle"] = "Instances";
L["soundsDisableInInstancesDesc"] = "Désactive les sons lorsque vous êtes dans des raids ou des instances.";

L["soundsFirstYellTitle"] = "Buff entrant";
L["soundsFirstYellDesc"] = "Joue un son lorsque la tête est livrée et que vous avez quelques secondes avant que le buff ne commence (premier cri du PNJ).";

L["soundsOneMinuteTitle"] = "Annonce d'une minute";
L["soundsOneMinuteDesc"] = "Joue un son lors de l'annonce de la minute restante dans le minuteur.";

L["soundsRendDropTitle"] = "Buff de Rend";
L["soundsRendDropDesc"] = "Son à jouer pour Rend lorsque vous obtenez le buff.";

L["soundsOnyDropTitle"] = "Buff d'Onyxia";
L["soundsOnyDropDesc"] = "Son à jouer pour Onyxia lorsque vous obtenez le buff.";

L["soundsNefDropTitle"] = "Buff de Nefarian";
L["soundsNefDropDesc"] = "Son à jouer pour Nefarian lorsque vous obtenez le buff.";

L["soundsZanDropTitle"] = "Buff de Zandalar";
L["soundsZanDropDesc"] = "Son à jouer pour Zandalar lorsque vous obtenez le buff.";


---Flash When Minimized---
L["flashHeaderDesc"] = "Clignoter lorsqu'il est réduit";

L["flashOneMinTitle"] = "Une minute";
L["flashOneMinDesc"] = "Fait clignoter le client WoW lorsque vous l'avez réduit et qu'il reste 1 minute dans le minuteur.";

L["flashFirstYellTitle"] = "Cri du PNJ";
L["flashFirstYellDesc"] = "Fait clignoter le client WoW lorsque vous l'avez réduit et que le PNJ crie quelques secondes avant que le buff ne tombe.";

L["flashFirstYellZanTitle"] = "Zandalar";
L["flashFirstYellZanDesc"] = "Fait clignoter le client WoW lorsque vous l'avez réduit et que le buff de Zandalar est sur le point de tomber.";


---Faction/realm specific options---

L["allianceEnableRendTitle"] = "Rend pour l'Alliance";
L["allianceEnableRendDesc"] = "Activez ceci pour suivre Rend en tant qu'Alliance, afin que les guildes ayant le contrôle mental puissent bénéficier de Rend. Si vous utilisez cela, alors tout le monde dans la guilde avec l'add-on devrait l'activer ou les messages de discussion de guilde pourraient ne pas fonctionner correctement (les messages de minuterie personnelle continueront de fonctionner).";

L["minimapLayerFrameTitle"] = "Couche sur la minicarte";
L["minimapLayerFrameDesc"] = "Affiche le cadre sur la minicarte avec votre couche actuelle ?";

L["minimapLayerFrameResetTitle"] = "Réinitialiser la minicarte";
L["minimapLayerFrameResetDesc"] = "Réinitialise le cadre de la couche de la minicarte à sa position par défaut (maintenez la touche Maj enfoncée pour déplacer le cadre de la minicarte).";


---Dispels---
L["dispelsHeaderDesc"] = "Dissipations";

L["dispelsMineTitle"] = "Mes buffs";
L["dispelsMineDesc"] = "Affiche dans la discussion lorsque mes buffs sont dissipés ? Cela montre qui vous a dissipé et quel buff.";

L["dispelsMineWBOnlyTitle"] = "Buff mondial";
L["dispelsMineWBOnlyDesc"] = "Affiche uniquement que mes buffs mondiaux sont dissipés et aucun autre type de buff.";

L["soundsDispelsMineTitle"] = "Son";
L["soundsDispelsMineDesc"] = "Quel son jouer lorsque mes buffs sont dissipés.";

L["dispelsAllTitle"] = "Buffs des autres";
L["dispelsAllDesc"] = "Affiche dans la discussion les buffs de tous ceux qui sont dissipés autour de moi ? Cela montre qui a dissipé quelqu'un près de vous et quel buff.";

L["dispelsAllWBOnlyTitle"] = "Buff mondial des autres";
L["dispelsAllWBOnlyDesc"] = "Affiche uniquement les buffs mondiaux lorsque tous les autres sont dissipés et aucun autre type de buff.";

L["soundsDispelsAllTitle"] = "Son pour les autres joueurs";
L["soundsDispelsAllDesc"] = "Quel son jouer pour les buffs dissipés des autres joueurs.";

L["middleHideBattlegroundsTitle"] = "Champs de bataille";
L["middleHideBattlegroundsDesc"] = "Cache les annonces au milieu de l'écran dans les champs de bataille ?";

L["soundsDisableInBattlegroundsTitle"] = "Champs de bataille";
L["soundsDisableInBattlegroundsDesc"] = "Désactive les sons lorsque vous êtes dans les champs de bataille.";


L["autoBuffsHeaderDesc"] = "Sélection automatique";

L["autoDmfBuffTitle"] = "Sélectionner le buff";
L["autoDmfBuffDesc"] = "Voulez-vous que cet add-on sélectionne automatiquement un buff de la Foire de Sombrelune lorsque vous parlez au PNJ Sayge ? Assurez-vous également de choisir quel buff vous voulez.";

L["autoDmfBuffTypeTitle"] = "Quel buff";
L["autoDmfBuffTypeDesc"] = "Quel buff de la Foire de Sombrelune voulez-vous que cet add-on sélectionne automatiquement lorsque vous parlez à Sayge ?";

L["autoDireMaulBuffTitle"] = "Hache-tripes";
L["autoDireMaulBuffDesc"] = "Voulez-vous que cet add-on obtienne automatiquement des buffs des PNJ dans Hache-tripes lorsque vous leur parlez ? (Il obtient également le buff du Roi).";

L["autoBwlPortalTitle"] = "Portail de BWL";
L["autoBwlPortalDesc"] = "Voulez-vous que cet add-on utilise automatiquement le portail du Repaire de l'Aile noire lorsque vous cliquez sur l'orbe ?";

L["showBuffStatsTitle"] = "Statistiques";
L["showBuffStatsDesc"] = "Affiche combien de fois vous avez obtenu chaque buff dans la fenêtre /buffs ? Les buffs d'Ony/Nef/Rend/Zand ont été enregistrés depuis l'installation de la fenêtre des buffs, mais le reste des buffs ont commencé à être enregistrés maintenant dans la version 1.65.";

L["buffResetButtonTooltip"] = "Cela réinitialisera tous les buffs.\nLes données du comptage des buffs ne seront pas réinitialisées.";
 --Reset button tooltip for the /buffs frame.
L["time"] = "(%s fois)"; --Singular - This shows how many timers you got a buff. Example: (1 time)
L["times"] = "(%s fois)"; --Plural - This shows how many timers you got a buff. Example: (5 times)
L["flowerWarning"] = "Cantaflor a été cueilli dans un royaume avec des minuteries de Cantaflor en couches activées, mais vous n'avez pointé aucun PNJ depuis votre arrivée à Bosquet des Chants Éternels, donc aucune minuterie n'a pu être enregistrée.";

L["mmColorTitle"] = "Couleur de la couche sur la minicarte";
L["mmColorDesc"] = "Quelle couleur doit avoir le texte de la couche sur la minicarte ? (Couche 1)";

L["layerHasBeenDisabled"] = "La couche %s a été désactivée. Cette couche est toujours dans la base de données mais sera ignorée jusqu'à ce qu'elle soit réactivée ou qu'elle soit à nouveau détectée comme valide.";
L["layerHasBeenEnabled"] = "La couche %s a été activée. Elle est désormais incluse dans les calculs de couches et de minuteries.";
L["layerDoesNotExist"] = "L'ID de la couche %s n'existe pas dans la base de données.";
L["enableLayerButton"] = "Activer";
L["disableLayerButton"] = "Désactiver";
L["enableLayerButtonTooltip"] = "Cliquez pour réactiver cette couche. Elle sera réintégrée dans les minuteries et les calculs de couches.";
L["disableLayerButtonTooltip"] = "Cliquez pour désactiver cette couche. L'add-on l'ignorera et la supprimera plus tard après un redémarrage du serveur.";

L["minimapLayerHoverTitle"] = "Survol de la couche sur la minicarte";
L["minimapLayerHoverDesc"] = "Affiche uniquement le cadre numérique de la couche sur la minicarte lorsque vous survolez la minicarte avec votre souris.";

L["Blackrock Mountain"] = "Mont Blackrock";

L["soundsNpcKilledTitle"] = "PNJ tué";
L["soundsNpcKilledDesc"] = "Son joué lorsqu'un PNJ donnant un buff est tué pour réinitialiser une minuterie.";

L["autoDmfBuffCharsText"] = "Configuration des buffs pour chaque personnage :";

L["middleNpcKilledTitle"] = "PNJ tué";
L["middleNpcKilledDesc"] = "Affiche un message de style d'alerte de raid au milieu de l'écran lorsqu'un PNJ est tué pour réinitialiser le buff.";

L["chatNpcKilledTitle"] = "PNJ tué";
L["chatNpcKilledDesc"] = "Affiche un message dans la discussion lorsqu'un PNJ est tué pour réinitialiser le buff.";


L["onyxiaNpcRespawnHorde"] = "Le PNJ d'Onyxia (Runthak) réapparaîtra à un moment aléatoire dans les 2 prochaines minutes.";
L["nefarianNpcRespawnHorde"] = "Le PNJ de Nefarian (Colmillosauro) réapparaîtra à un moment aléatoire dans les 2 prochaines minutes.";
L["onyxiaNpcRespawnAlliance"] = "Le PNJ d'Onyxia (Mattingly) réapparaîtra à un moment aléatoire dans les 2 prochaines minutes.";
L["nefarianNpcRespawnAlliance"] = "Le PNJ de Nefarian (Afrasiabi) réapparaîtra à un moment aléatoire dans les 2 prochaines minutes.";

L["onyxiaNpcKilledHordeWithTimer2"] = "Le PNJ d'Onyxia (Runthak) a été tué il y a %s, réapparition dans %s.";
L["nefarianNpcKilledHordeWithTimer2"] = "Le PNJ de Nefarian (Saurfang) a été tué il y a %s, réapparition dans %s.";
L["onyxiaNpcKilledAllianceWithTimer2"] = "Le PNJ d'Onyxia (Mattingly) a été tué il y a %s, réapparition dans %s.";
L["nefarianNpcKilledAllianceWithTimer2"] = "Le PNJ de Nefarian (Afrasiabi) a été tué il y a %s, réapparition dans %s.";

L["flashNpcKilledTitle"] = "Clignoter";
L["flashNpcKilledDesc"] = "Est-ce que le client WoW clignote lorsqu'un PNJ conférant un buff est tué ?";

L["trimDataHeaderDesc"] = "Nettoyer les données";

L["trimDataBelowLevelTitle"] = "Niveau maximal à supprimer";
L["trimDataBelowLevelDesc"] = "Sélectionnez le niveau maximal des personnages à supprimer de la base de données ; tous les personnages de ce niveau et inférieurs seront supprimés.";

L["trimDataBelowLevelButtonTitle"] = "Supprimer les personnages";
L["trimDataBelowLevelButtonDesc"] = "Cliquez sur ce bouton pour supprimer tous les personnages avec le niveau sélectionné et inférieur de cette base de données additionnelle. Note : Cela supprime définitivement les données de comptage des buffs.";

L["trimDataTextDesc"] = "Supprimer plusieurs personnages de la base de données des buffs :";
L["trimDataText2Desc"] = "Supprimer un personnage de la base de données des buffs :";

L["trimDataCharInputTitle"] = "Supprimer une entrée de personnage";
L["trimDataCharInputDesc"] = "Saisissez ici un personnage à supprimer, formaté comme Nom-Royaume (en distinguant majuscules et minuscules). Note : Cela supprime définitivement les données de comptage des buffs.";

L["trimDataBelowLevelButtonConfirm"] = "Êtes-vous sûr de vouloir supprimer tous les personnages en dessous du niveau %s de la base de données ?";
L["trimDataCharInputConfirm"] = "Êtes-vous sûr de vouloir supprimer ce personnage %s de la base de données ?";

L["trimDataMsg1"] = "Les enregistrements des buffs ont été réinitialisés.";
L["trimDataMsg2"] = "Suppression de tous les personnages en dessous du niveau %s.";
L["trimDataMsg3"] = "Supprimé : %s.";
L["trimDataMsg4"] = "Terminé, aucun personnage trouvé.";
L["trimDataMsg5"] = "Terminé, %s personnages ont été supprimés.";
L["trimDataMsg6"] = "Entrez un nom de personnage valide à supprimer de la base de données.";
L["trimDataMsg7"] = "Le nom de ce personnage %s ne comprend pas de royaume, entrez Nom-Royaume.";
L["trimDataMsg8"] = "Erreur lors de la suppression de %s de la base de données, personnage non trouvé (le nom est sensible à la casse).";
L["trimDataMsg9"] = "%s a été supprimé de la base de données.";

L["serverTime"] = "heure du royaume";
L["serverTimeShort"] = "hr";

L["showUnbuffedAltsTitle"] = "Alts non buffés";
L["showUnbuffedAltsDesc"] = "Affiche les alts non buffés dans la fenêtre des buffs ? Cela vous permet de voir quels personnages n'ont pas des buffs si vous le souhaitez.";

L["timerWindowWidthTitle"] = "Largeur de la fenêtre de minuterie";
L["timerWindowWidthDesc"] = "Quelle doit être la largeur de la fenêtre de minuterie ?";

L["timerWindowHeightTitle"] = "Hauteur de la fenêtre de minuterie";
L["timerWindowHeightDesc"] = "Quelle doit être la hauteur de la fenêtre de minuterie ?";

L["buffWindowWidthTitle"] = "Largeur de la fenêtre des buffs";
L["buffWindowWidthDesc"] = "Quelle doit être la largeur de la fenêtre des buffs ?";

L["buffWindowHeightTitle"] = "Hauteur de la fenêtre des buffs";
L["buffWindowHeightDesc"] = "Quelle doit être la hauteur de la fenêtre des buffs ?";

L["dmfSettingsListTitle"] = "Liste des buffs";
L["dmfSettingsListDesc"] = "Cliquez ici pour afficher une liste de vos paramètres de type des buffs de la Foire de Sombrelune pour vos alts.";

L["ignoreKillDataTitle"] = "Ignorer les données de PNJ";
L["ignoreKillDataDesc"] = "Ignore toutes les données de PNJ tués afin qu'elles ne soient pas enregistrées.";

L["noOverwriteTitle"] = "Ne pas écraser";
L["noOverwriteDesc"] = "Vous pouvez activer ceci pour que, si vous avez déjà une minuterie valide en cours d'exécution, vous ignorez toutes nouvelles données pour cette minuterie jusqu'à ce qu'elle se termine.";

L["layerMsg1"] = "Vous êtes sur un royaume avec des couches.";
L["layerMsg2"] = "Cliquez ici pour voir les minuteries actuelles.";
L["layerMsg3"] = "Pointez un PNJ pour voir votre couche actuelle.";
L["layerMsg4"] = "Pointez sur n'importe quel PNJ à %s pour voir votre couche actuelle."; --Target any NPC in Orgrimmar to see your current layer.

--NOTE: Darkmoon Faire buff type is now a character specific setting, changing buff type will only change it for this character.
L["note"] = "NOTE :";
L["dmfConfigWarning"] = "Le type de buff de la Foire de Sombrelune est maintenant une configuration spécifique au personnage ; modifier le type de buff ne le changera que pour ce personnage.";

---New---

L["onyNpcMoving"] = "Le PNJ d'Onyxia a commencé à bouger !";
L["nefNpcMoving"] = "Le PNJ de Nefarian a commencé à bouger !";

L["buffHelpersHeaderDesc"] = "Aides aux buffs pour les serveurs JcJ";

L["buffHelpersTextDesc"] = "Aides aux buffs pour les serveurs JcJ (activées si vous obtenez un buff et effectuez l'une de ces actions dans les secondes suivant l'obtention du buff ; vous pouvez ajuster les secondes ci-dessous).";
L["buffHelpersTextDesc2"] = "\nBuff de Zandalar";
L["buffHelpersTextDesc3"] = "Buff de la Foire de Sombrelune";
L["buffHelpersTextDesc4"] = "Entrez une macro de champ de bataille (vous devez appuyer deux fois dessus pour que cela fonctionne, donc spammez simplement ; cela annulera la file d'attente si vous n'avez pas déjà de fenêtre contextuelle, alors faites attention de ne pas l'appuyer avant).\n|cFF9CD6DE/click DropDownList1Button2\n/click MiniMapBattlefieldFrame RightButton";

L["takeTaxiZGTitle"] = "Vol automatique";
L["takeTaxiZGDesc"] = "Prenez automatiquement un vol depuis le Port de Hurlevent dès qu'un buff tombe, vous pouvez parler au PNJ de vol après la chute ou l'avoir déjà ouvert quand il tombe, cela fonctionnera dans les deux sens. |cFF00C800(Vous pouvez obtenir le buff en fantôme, je vous suggère donc de rester en fantôme jusqu'à ce que le buff expire puis de cliquer et de parler au PNJ de vol pour voler automatiquement)";

L["takeTaxiNodeTitle"] = "Destination";
L["takeTaxiNodeDesc"] = "Si l'option de vol automatique est activée, où souhaitez-vous voler ?";
			
L["dmfVanishSummonTitle"] = "Invocation après Disparition";
L["dmfVanishSummonDesc"] = "Voleurs : Acceptez-vous automatiquement l'invitation dès que vous vous évanouissez après avoir obtenu le buff de la Foire de Sombrelune ?";

L["dmfFeignSummonTitle"] = "Invocation après Feindre la mort";
L["dmfFeignSummonDesc"] = "Chasseurs : Acceptez-vous automatiquement l'invitation dès que vous feignez la mort après avoir obtenu le buff de la Foire de Sombrelune ?";
			
L["dmfCombatSummonTitle"] = "Invocation après Sortie de combat";
L["dmfCombatSummonDesc"] = "Acceptez-vous automatiquement l'invitation dès que vous sortez du combat après avoir obtenu le buff de la Foire de Sombrelune ?";
			
L["dmfLeaveBGTitle"] = "Quitter automatiquement le champ de bataille";
L["dmfLeaveBGDesc"] = "Quittez-vous automatiquement votre champ de bataille en entrant dans des zones après avoir obtenu le buff de la Foire de Sombrelune ?";

L["dmfGotBuffSummonTitle"] = "Invocation avec la Foire";
L["dmfGotBuffSummonDesc"] = "Acceptez-vous automatiquement toute invitation en attente lorsque vous obtenez le buff de la Foire de Sombrelune.";

L["zgGotBuffSummonTitle"] = "Invocation avec ZG";
L["zgGotBuffSummonDesc"] = "Acceptez-vous automatiquement toute invitation en attente lorsque vous obtenez le buff de Zandalar.";

L["buffHelperDelayTitle"] = "Combien de secondes les aides sont-elles activées ?";
L["buffHelperDelayDesc"] = "Pendant combien de secondes après avoir obtenu un buff ces aides devraient-elles fonctionner ? Cela vous permet de laisser les options activées et elles ne fonctionneront qu'immédiatement après avoir obtenu un buff.";

L["showNaxxWorldmapMarkersTitle"] = "Carte de Naxxramas";
L["showNaxxWorldmapMarkersDesc"] = "Affiche le marqueur de Naxxramas sur la carte du monde ?";

L["showNaxxMinimapMarkersTitle"] = "Minicarte de Naxxramas";
L["showNaxxMinimapMarkersDesc"] = "Affiche le marqueur de Naxxramas sur la minicarte ? Cela vous montrera également la direction de retour à Naxx lorsque vous êtes un fantôme et que vous mourez dans l'instance.";

L["bigWigsSupportTitle"] = "Support de BigWigs";
L["bigWigsSupportDesc"] = "Lance une barre de temporisation pour obtenir des buffs si BigWigs est installé ? Le même type de barre de temporisation que DBM.";

L["soundsNpcWalkingTitle"] = "PNJ en marche";
L["soundsNpcWalkingDesc"] = "Joue un son lorsque le PNJ d'un buff commence à marcher à Orgrimmar ?";

L["buffHelpersTextDesc4"] = "Buff de Fleur-de-chant";
L["songflowerGotBuffSummonTitle"] = "Invocation de Fleur-de-chant";
L["songflowerGotBuffSummonDesc"] = "Acceptez-vous automatiquement toute invitation en attente lorsque vous obtenez un buff de fleur-de-chant.";

L["buffHelpersTextDesc5"] = "Buff de Ony/Rend";
L["cityGotBuffSummonTitle"] = "Invocation de Ony/Rend";
L["cityGotBuffSummonDesc"] = "Acceptez-vous automatiquement toute invitation en attente lorsque vous obtenez un buff de Ony/Nef/Rend.";

L["heraldFoundCrossroads"] = "Héraut trouvé ! Le buff de Rend à La Croisée va poser dans 20 secondes.";

L["guildNpcWalkingTitle"] = "PNJ en marche";
L["guildNpcWalkingDesc"] = "Envoie un message à la guilde et joue un son lorsque vous activez ou recevez une alerte de déplacement de PNJ ? (Ouvre la fenêtre de discussion avec les PNJ d'Ony/Nef à Orgrimmar et attendez que quelqu'un remette la tête pour activer cette alerte précoce).";

L["buffHelpersTextDesc6"] = "Fenêtre d'aide de la Foire de Sombrelune";
L["dmfFrameTitle"] = "Aide de la foire";
L["dmfFrameDesc"] = "Une fenêtre qui apparaît lorsque vous approchez de Sayge à la Foire en tant que fantôme sur les serveurs JcJ pour aider avec les fonctions bloquées de Blizzard.";


L["Sheen of Zanza"] = "Brillance de Zanza";
L["Spirit of Zanza"] = "Esprit de Zanza";
L["Swiftness of Zanza"] = "Rapidité de Zanza";

L["Mind Control"] = "Contrôle mental";
L["Gnomish Mind Control Cap"] = "Coiffe de contrôle mental gnome";


L["tbcHeaderText"] = "Options de l'extension";
L["tbcNoteText"] = "Note : Tous les messages du canal de guilde sont également désactivés sur les royaumes TBC.";

L["disableSoundsAboveMaxBuffLevelTitle"] = "Désactiver les sons pour les niveaux supérieurs à 64+";
L["disableSoundsAboveMaxBuffLevelDesc"] = "Désactive les sons liés aux buffs mondiaux pour les personnages de niveau 63 et plus sur les royaumes TBC ?";

L["disableSoundsAllLevelsTitle"] = "Désactiver tous les sons pour tous les niveaux";
L["disableSoundsAllLevelsDesc"] = "Désactive les sons liés aux buffs mondiaux pour tous les personnages sur les royaumes TBC ?";

L["disableMiddleAboveMaxBuffLevelTitle"] = "Désactiver les messages au milieu de l'écran pour 64+";
L["disableMiddleAboveMaxBuffLevelDesc"] = "Désactive les messages liés aux buffs mondiaux au milieu de l'écran pour les personnages de niveau 63 et plus sur les royaumes TBC ?";

L["disableMiddleAllLevelsTitle"] = "Désactiver les messages au milieu de l'écran pour tous les niveaux";
L["disableMiddleAllLevelsDesc"] = "Désactive les messages liés aux buffs mondiaux au milieu de l'écran pour tous les personnages sur les royaumes TBC ?";

L["disableChatAboveMaxBuffLevelTitle"] = "Désactiver les messages du chat pour 64+";
L["disableChatAboveMaxBuffLevelDesc"] = "Désactive les messages liés aux minuteries des buffs mondiaux dans la fenêtre de chat pour les personnages de niveau 63 et plus sur les royaumes TBC ?";

L["disableChatAllLevelsTitle"] = "Désactiver les messages du chat pour tous les niveaux";
L["disableChatAllLevelsDesc"] = "Désactive les messages liés aux minuteries des buffs mondiaux dans la fenêtre de chat pour tous les personnages sur les royaumes TBC ?";

L["disableFlashAboveMaxBuffLevelTitle"] = "Désactiver le clignotement en mode réduit pour 64+";
L["disableFlashAboveMaxBuffLevelDesc"] = "Désactive le clignotement du client WoW lorsqu'il est réduit pour les événements des buffs mondiaux pour les personnages de niveau 63 et plus sur les royaumes TBC ?";

L["disableFlashAllLevelsTitle"] = "Désactiver le clignotement en mode réduit pour tous les niveaux";
L["disableFlashAllLevelsDesc"] = "Désactive le clignotement du client WoW lorsqu'il est réduit pour les événements des buffs mondiaux pour tous les personnages sur les royaumes TBC ?";

L["disableLogonAboveMaxBuffLevelTitle"] = "Désactiver les minuteries de connexion pour 64+";
L["disableLogonAboveMaxBuffLevelDesc"] = "Désactive les minuteries dans la discussion lors de la connexion pour les personnages de niveau 63 et plus sur les royaumes TBC ?";

L["disableLogonAllLevelsTitle"] = "Désactiver les minuteries de connexion pour tous les niveaux";
L["disableLogonAllLevelsDesc"] = "Désactive les minuteries dans la discussion lors de la connexion pour tous les personnages sur les royaumes TBC ?";


L["Flask of Fortification"] = "Flacon de fortifiant";
L["Flask of Pure Death"] = "Flacon de pure mort";
L["Flask of Relentless Assault"] = "Flacon d'attaque implacable";
L["Flask of Blinding Light"] = "Flacon de lumière aveuglante";
L["Flask of Mighty Restoration"] = "Flacon de puissante restauration";
L["Flask of Chromatic Wonder"] = "Flacon de merveille chromatique";
L["Fortification of Shattrath"] = "Fortifiant de Shattrath";
L["Pure Death of Shattrath"] = "Pure mort de Shattrath";
L["Relentless Assault of Shattrath"] = "Attaque implacable de Shattrath";
L["Blinding Light of Shattrath"] = "Lumière aveuglante de Shattrath";
L["Mighty Restoration of Shattrath"] = "Puissante restauration de Shattrath";
L["Supreme Power of Shattrath"] = "Pouvoir suprême de Shattrath";
L["Unstable Flask of the Beast"] = "Flacon instable de la bête";
L["Unstable Flask of the Sorcerer"] = "Flacon instable du sorcier";
L["Unstable Flask of the Bandit"] = "Flacon instable du bandit";
L["Unstable Flask of the Elder"] = "Flacon instable de l'ancien";
L["Unstable Flask of the Physician"] = "Flacon instable du médecin";
L["Unstable Flask of the Soldier"] = "Flacon instable du soldat";

L["Chronoboon Displacer"] = "Déplaceur de chronochance";

L["Silithyst"] = "Silithyste";

L["Gold"] = "Or";
L["level"] = "Niveau";
L["realmGold"] = "Or du royaume pour";
L["total"] = "Total";
L["guild"] = "Guilde";
L["bagSlots"] = "Emplacements de sac";
L["durability"] = "Durabilité";
L["items"] = "Objets";
L["ammunition"] = "Munitions";
L["attunements"] = "Harmonisations";
L["currentRaidLockouts"] = "Verrouillages de raid actuels";
L["none"] = "Aucun.";

L["dmfDamagePercent"] = "Ce nouveau bonus de la Foire de Sombrelune a %s%% de dégâts.";
L["dmfDamagePercentTooltip"] = "NWB a détecté ceci comme %s dégâts.";

L["guildLTitle"] = "Couches de guilde";
L["guildLDesc"] = "Partagez-vous dans quelle couche vous êtes avec votre guilde ? Vous pouvez voir la liste des couches de votre guilde avec /wb guild";

L["terokkarTimer"] = "Terokkar";
L["terokkarWarning"] = "Les tours de la forêt de Terokkar seront réinitialisées dans %s";

L["wintergraspTimer"] = "Joug-d'hiver";
L["wintergraspWarning"] = "Joug-d'hiver débutera dans %s";


L["Nazgrel"] = "Nazgrel";
--L["Hellfire Citadel is ours"] = "Hellfire Citadel is ours";
--L["The time for us to rise"] = "The time for us to rise";
L["Force Commander Danath Trollbane"] = "Commandant de corps Danath Trollemort ";
--L["The feast of corruption is no more"] = "The feast of corruption is no more";
--L["Hear me brothers"] = "Hear me brothers";

L["terokkarChat10Title"] = "Terokkar 10 Minutes";
L["terokkarChat10Desc"] = "Affiche un message dans la discussion lorsqu'il reste 10 minutes aux tours spirituelles de Terokkar.";

L["terokkarMiddle10Title"] = "Terokkar 10 Minutes";
L["terokkarMiddle10Desc"] = "Affiche un message de style d'alerte de raid au milieu de l'écran lorsqu'il reste 10 minutes aux tours spirituelles de Terokkar.";

L["showShatWorldmapMarkersTitle"] = "Marqueurs de Quotidiens sur la carte du monde";
L["showShatWorldmapMarkersDesc"] = "Affiche les marqueurs des quotidiens de donjons sur la carte du monde de la ville capitale.";

L["disableBuffTimersMaxBuffLevelTitle"] = "Désactiver les minuteurs des buffs du minicarte 64+";
L["disableBuffTimersMaxBuffLevelDesc"] = "Cache les minuteurs des buffs mondiaux lorsque vous survolez l'icône de la mini-carte pour les personnages de niveau 64+. Vous ne verrez que les minuteurs et les quotidiens de la tour Terokkar, etc.";

L["hideMinimapBuffTimersTitle"] = "Désactiver les minuteurs des buffs du minicarte pour tous les niveaux";
L["hideMinimapBuffTimersDesc"] = "Cache les minuteurs des buffs mondiaux lorsque vous survolez l'icône de la mini-carte pour tous les personnages. Vous ne verrez que les minuteurs et les quotidiens de la tour Terokkar, etc.";

L["guildTerok10Title"] = "Guilde Terokkar/Joug-d'hiver 10 Minutes";
L["guildTerok10Desc"] = "Envoie un message dans la discussion de la guilde lorsqu'il reste 10 minutes aux tours de Terokkar s'il s'agit de TBC ou à la Conquête de l'hiver s'il s'agit de WoTLK.";

L["showShatWorldmapMarkersTerokTitle"] = "Marqueurs de Tours/Joug-d'hiver";
L["showShatWorldmapMarkersTerokDesc"] = "Affiche les marqueurs de la tour Terokkar ou du Joug-d'hiver sur la carte de la ville capitale.";

L["Completed PvP dailies"] = "Quotidiens JcJ terminés";
L["Hellfire Towers"] = "Tours des Flammes infernales";
L["Terokkar Towers"] = "Tours de Terokkar";
L["Nagrand Halaa"] = "Nagrand Halaa";

L["wintergraspChat10Title"] = "Joug-d'hiver 10 Minutes";
L["wintergraspChat10Desc"] = "Affiche un message dans la discussion lorsqu'il reste 10 minutes aux tours spirituelles du Joug-d'hiver.";

L["wintergraspMiddle10Title"] = "Joug-d'hiver 10 Minutes";
L["wintergraspMiddle10Desc"] = "Affiche un message de style d'alerte de raid au milieu de l'écran lorsqu'il reste 10 minutes aux tours spirituelles du Joug-d'hiver.";


--L["ashenvaleHordeVictoryMsg"] = "¡La sacerdotisa de la luna de la Alianza ha sido asesinada!";
--L["ashenvaleAllianceVictoryMsg"] = "¡El clarividente de la Horda ha sido asesinado!";

--L["ashenvaleWarning"] = "Los preparativos d'Ashenvale están casi terminados. ¡La Batalla por Ashenvale comenzará pronto! (Alianza %s%%) (Horda %s%%)."; --Any localization of this string must match the same format with brackets etc.

L["Boon of Blackfathom"] = "Bienfait de Brassenoire";
L["Ashenvale Rallying Cry"] = "Cri de ralliement d’Ashenvale";

L["sodHeaderText"] = "Options de la Saison de la découverte";

L["disableOnlyNefRendBelowMaxLevelTitle"] = "Désactiver Ony/Nef/Rend";
L["disableOnlyNefRendBelowMaxLevelDesc"] = "Cache Ony/Nef/Rend qui s'affiche sur la carte de la capitale et dans l'infobulle de l'icône de la minicarte en dessous d'un certain niveau ? (Fait en sorte que l'icône de la minicarte affiche uniquement les couches et non les minuteurs de buff)";

L["disableOnlyNefRendBelowMaxLevelNumTitle"] = "Niveau minimum Ony/Nef/Rend";
L["disableOnlyNefRendBelowMaxLevelNumDesc"] = "En dessous de quel niveau devrions-nous cacher les icônes Ony/Nef/Rend de la carte de la capitale et de l'infobulle du bouton de la minicarte ?";

L["soundsBlackfathomBoonTitle"] = "Son des buffs";
L["soundsBlackfathomBoonDesc"] = "Reproduit-il un son lorsqu'un buff de la saison de la découverte est obtenu ?";

L["soundsAshenvaleStartsSoonTitle"] = "Son du début de l'événement";
L["soundsAshenvaleStartsSoonDesc"] = "Reproduit-il un son lorsqu'un événement de la saison de la découverte est sur le point de commencer ?";

L["blackfathomBoomBuffDropped"] = "Le buff de la Faveur de Profondeurs de Brassenoire est tombé.";

L["showAshenvaleOverlayTitle"] = "Superposition";
L["showAshenvaleOverlayDesc"] = "Affiche une superposition de minuteurs mobiles dans votre IU en permanence ?";

L["lockAshenvaleOverlayTitle"] = "Verrouiller";
L["lockAshenvaleOverlayDesc"] = "Verrouille la superposition de minuteurs pour ignorer le passage de la souris.";

L["ashenvaleOverlayScaleTitle"] = "Échelle de la superposition";
L["ashenvaleOverlayScaleDesc"] = "Définit la taille de la superposition de minuteurs.";

L["ashenvaleOverlayText"] = "|cFFFFFF00-Superposition pour afficher toujours les minuteurs dans votre IU-";
L["layersNoteText"] = "|cFFFF6900Note sur les couches:|r |cFF9CD6DENWB a une limite de suivi de 10 couches maximum, ceci est pour que la taille des données ne soit pas trop grande pour être facilement partagée entre les joueurs. Sur la plupart des royaumes de la Saison avec une grande population en ce moment, il y a plus de 10 couches, donc si vous ne voyez pas sur quelle couche vous êtes, c'est parce que vous n'êtes pas dans l'une des 10 couches enregistrées. Il est probable que cela redescende en dessous de 10 une fois que l'enthousiasme pour le lancement se sera un peu estompé, mais d'ici là, cela peut ne pas être fiable, désolé.|r";

L["Mouseover char names for extra info"] = "Survolez les noms des personnages pour plus d'informations.";
L["Show Stats"] = "Statistiques"; --Can't be any longer than this.
L["Event Running"] = "Événement en cours";

L["Left-Click"] = "Clic Gauche";
L["Right-Click"] = "Clic Droit";
L["Shift Left-Click"] = "Maj Clic Gauche";
L["Shift Right-Click"] = "Maj Clic Droit";
L["Control Left-Click"] = "Ctrl Clic Gauche";


--Try keep these roughly the same length or shorter.
L["Guild Layers"] = "Guilde";
L["Timers"] = "Minuteries";
L["Buffs"] = "Buffs";
L["Felwood Map"] = "Carte de Gangrebois";
L["Config"] = "Options";
L["Resources"] = "Ressources";
L["Layer"] = "Couche";
L["Layer Map"] = "Carte des couches";
L["Rend Log"] = "Journal de Rend";
L["Timer Log"] = "Journal des minuteries";
L["Copy/Paste"] = "Copier/Coller";
L["Ashenvale PvP Event Resources"] = "Progrès d'Ashenvale";
L["All other alts using default"] = "Tous les autres utilisant la configuration par défaut";
L["Chronoboon CD"] = "Recharge Chronochance"; --Chronoboon cooldown.
L["All"] = "Tout"; --This has to be small to fit.
L["Old Data"] = "Anciennes données";
L["Ashenvale data is old"] = "Les données d'Ashenvale sont obsolètes.";
L["Ashenvale"] = "Ashenvale";
L["Ashenvale Towers"] = "Tours d'Ashenvale";
L["Warning"] = "Attention";
L["Refresh"] = "Actualiser";
L["PvP enabled"] = "JcJ activé";
L["Hold Shift to drag"] = "Maintenez Maj pour déplacer";
L["Hold to drag"] = "Maintenez pour déplacer";

L["Can't find current layer or no timers active for this layer."] = "Impossible de trouver la couche actuelle ou aucun chronomètre actif pour cette couche.";
L["No guild members online sharing layer data found."] = "Aucun membre de guilde en ligne ne partage de données de couche.";

--New.

L["ashenvaleOverlayFontTitle"] = "Police de la superposition";
L["ashenvaleOverlayFontDesc"] = "Quelle police utiliser pour les superpositions d'écran.";

L["minimapLayerFontTitle"] = "Police de la couche de la minicarte";
L["minimapLayerFontDesc"] = "Quelle police utiliser pour le texte de la couche de la minicarte.";

L["minimapLayerFontSizeTitle"] = "Taille du texte de la couche de la minicarte";
L["minimapLayerFontSizeDesc"] = "Quelle taille de police utiliser pour le texte de la couche de la minicarte.";

L["zone"] = "zone";
L["zones mapped"] = "zones cartographiées";
L["Layer Mapping for"] = "Cartographie des couches pour";
L["formatForDiscord"] = "Formater le texte pour le coller dans Discord ? (Ajouter des couleurs, etc.)";
L["Copy Frame"] = "Copier le cadre";
L["Show how many times you got each buff."] = "Affiche combien de fois vous avez obtenu chaque buff.";
L["Show all alts that have buff stats? (stats must be enabled)."] = "Affiche tous les personnages alternatifs qui ont des statistiques de buff ? (les stats doivent être activées).";
L["No timer logs found."] = "Aucun journal de minuterie trouvé.";
L["Merge Layers"] = "Fusionner les couches";
L["mergeLayersTooltip"] = "Si plusieurs couches ont la même minuterie, ils seront fusionnés en [Tous les couches] au lieu d'être affichés séparément.";
L["Ready"] = "Prêt";
L["Chronoboon"] = "Chronochance";
L["Local Time"] = "Heure locale";
L["Server Time"] = "Heure du royaume";
L["12 hour"] = "12 heures";
L["24 hour"] = "24 heures";
L["Alliance"] = "Alliance";
L["Horde"] = "Horde";
L["No Layer"] = "Pas de couche";
L["No data yet."] = "Pas encore de données.";
L["Ashenvale Resources"] = "Ressources d'Ashenvale";
L["No character specific buffs set yet."] = "Aucun buff spécifique au personnage n'a encore été défini.";
L["All characters are using default"] = "Tous les personnages utilisent les paramètres par défaut";
L["Orgrimmar"] = "Orgrimmar";
L["Stormwind"] = "Stormwind";
L["Dalaran"] = "Dalaran";
L["left"] = "restants";
L["remaining"] = "restants";

L["Online"] = "En ligne";
L["Offline"] = "Hors ligne";
L["Rested"] = "Reposé";
L["Not Rested"] = "Non reposé";
L["No zones mapped for this layer yet."] = "Aucune zone n'a encore été cartographiée pour ce couche.";
L["Cooldown"] = "Temps de recharge";
L["dmfLogonBuffResetMsg"] = "Ces personnages ont été déconnectés pendant plus de 8 heures dans une zone de repos et le temps de recharge du buff de la Foire de Sombrelune a été réinitialisé";
L["dmfOfflineStatusTooltip"] = "Temps de recharge de la Foire de Sombrelune de plus de 8 heures hors ligne dans une zone de repos";
L["chronoboonReleased"] = "Le Déplaceur de chronochance surchargé a restauré le buff de la Foire de Sombrelune. Un nouveau temps de recharge de 4 heures a commencé.";


L["Stranglethorn"] = "Strangleronce"; -- Version plus courte d'une seule mot de Stranglethorn Vale pour mieux s'adapter.
L["ashenvaleEventRunning"] = "La bataille d'Ashenvale est en cours : %s";
L["ashenvaleEventStartsIn"] = "La bataille d'Ashenvale commencera dans %s";
L["ashenvaleStartSoon"] = "La bataille d'Ashenvale commencera dans %s"; -- Message de discussion de guilde.
L["stranglethornEventRunning"] = "La lune de sang est en cours : %s";
L["stranglethornEventStartsIn"] = "La lune de sang commencera dans %s";
L["stranglethornStartSoon"] = "La lune de sang commencera dans %s"; -- Message de discussion de guilde.
L["Spark of Inspiration"] = "Étincelle d’inspiration"; -- Buff mondial de la phase 2 de SoD.
L["specificBuffDropped"] = "Le buff %s a été posé.";
L["3 day raid reset"] = "Réinitialisation du raid de 3 jours";
L["Darkmoon Faire is up"] = "La Foire de Sombrelune est active";
L["dmfAbbreviation"] = "Foire";
L["Ashenvale PvP Event"] = "La bataille d'Ashenvale";
L["Stranglethorn PvP Event"] = "La lune de sang";

L["overlayShowArtTitle"] = "L'art en superposition";
L["overlayShowArtDesc"] = "Affiche l'art en superposition ?";

L["overlayShowAshenvaleTitle"] = "Ashenvale";
L["overlayShowAshenvaleDesc"] = "Affiche le minutage d'Ashenvale en superposition ?";

L["overlayShowStranglethornTitle"] = "Strangleronce";
L["overlayShowStranglethornDesc"] = "Affiche le minutage de Strangleronce en superposition ?";

L["sodMiddleScreenWarningTitle"] = "Avertissements au milieu de l'écran";
L["sodMiddleScreenWarningDesc"] = "Affiche un avertissement de 15/30 minutes au milieu de l'écran pour les événements JcJ ?";

L["stvBossMarkerTooltip"] = "Marqueur de boss NWB (expérimental)";
L["Boss"] = "Boss"; -- Si trop long, abrégez, ce texte se trouve sous un marqueur de carte.
L["stvBossSpotted"] = "Boss Loa repéré ! Regardez la carte pour l'emplacement.";
L["Total coins this event"] = "Total de pièces dans cet événement"; -- Gardez-le court, il est imprimé dans le chat lorsque vous remettez les pièces.
L["Last seen"] = "Dernière vue";
L["layersNoGuild"] = "Vous n'avez pas de guilde, cette commande affiche uniquement les membres de la guilde.";

L["Fervor of the Temple Explorer"] = "Ferveur de l’explorateur du temple";
L["No guild"] = "Pas de guilde";

L["Temple of Atal'Hakkar"] = "temple d’Atal’Hakkar";