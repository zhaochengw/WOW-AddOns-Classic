-- SCT localization information
-- French Locale
-- Initial translation by Juki <Unskilled>
-- Translation by Sasmira
-- Update by Culhag
-- Date 23/12/2006

if GetLocale() ~= "frFR" then return end

local media = LibStub("LibSharedMedia-3.0")

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "D\195\169g\195\162ts", tooltipText = "Activer/D\195\169sactiver les d\195\169g\195\162ts de m\195\169l\195\169e et divers (feu, chute, etc...)."};
SCT.LOCALS.OPTION_EVENT2 = {name = "Rat\195\169s", tooltipText = "Activer/D\195\169sactiver les coups rat\195\169s"};
SCT.LOCALS.OPTION_EVENT3 = {name = "D\195\169vi\195\169s", tooltipText = "Activer/D\195\169sactiver les coups d\195\169vi\195\169s"};
SCT.LOCALS.OPTION_EVENT4 = {name = "Parades", tooltipText = "Activer/D\195\169sactiver les coups par\195\169s"};
SCT.LOCALS.OPTION_EVENT5 = {name = "Bloqu\195\169s", tooltipText = "Activer/D\195\169sactiver les coups bloqu\195\169s"};
SCT.LOCALS.OPTION_EVENT6 = {name = "D\195\169g\195\162ts Sorts", tooltipText = "Activer/D\195\169sactiver les d\195\169g\195\162ts de sorts"};
SCT.LOCALS.OPTION_EVENT7 = {name = "Sorts Soins", tooltipText = "Activer/D\195\169sactiver les sorts de soins"};
SCT.LOCALS.OPTION_EVENT8 = {name = "Sorts R\195\169sist\195\169s", tooltipText = "Activer/D\195\169sactiver les sorts r\195\169sist\195\169s"};
SCT.LOCALS.OPTION_EVENT9 = {name = "D\195\169buffs", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous \195\170tes debuffs"};
SCT.LOCALS.OPTION_EVENT10 = {name = "Absorb\195\169s", tooltipText = "Activer/D\195\169sactiver les d\195\169g\195\162ts absorb\195\169s"};
SCT.LOCALS.OPTION_EVENT11 = {name = "Vie Faible", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque votre vie est faible"};
SCT.LOCALS.OPTION_EVENT12 = {name = "Mana Faible", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque votre mana est faible"};
SCT.LOCALS.OPTION_EVENT13 = {name = "Gains d\'Energie", tooltipText = "Activer/D\195\169sactiver l\'affichage des gains de Mana, Rage, Energie\ndes potions, obejts, buffs, etc...(pas des r\195\169g\195\169ration naturelle)"};
SCT.LOCALS.OPTION_EVENT14 = {name = "Mode Combat", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous rentrez ou sortez d\'un combat"};
SCT.LOCALS.OPTION_EVENT15 = {name = "Points de Combo", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous gagnez des points de combo"};
SCT.LOCALS.OPTION_EVENT16 = {name = "Points d\'Honneur", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous gagnez des points d\'Honneur"};
SCT.LOCALS.OPTION_EVENT17 = {name = "Buffs", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous \195\170tes buffs"};
SCT.LOCALS.OPTION_EVENT18 = {name = "Fin des Buffs", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque les buffs se dissipent"};
SCT.LOCALS.OPTION_EVENT19 = {name = "Ex\195\169cution/Courroux", tooltipText = "Activer/D\195\169sactiver l\'affichage de l\'alerte pour Ex\195\169cution et Marteau de Courroux (Guerrier/Paladin Seulement)"};
SCT.LOCALS.OPTION_EVENT20 = {name = "R\195\169putation", tooltipText = "Activer/D\195\169sactiver l\'affichage du Gain ou de la perte de R\195\169putation"};
SCT.LOCALS.OPTION_EVENT21 = {name = "Vos Soins", tooltipText = "Activer/D\195\169sactiver l\'affichage des soins que vous faites aux les autres"};
SCT.LOCALS.OPTION_EVENT22 = {name = "Comp\195\169tences", tooltipText = "Activer/D\195\169sactiver l\'affichage du Gain de points de Comp\195\169tences"};
SCT.LOCALS.OPTION_EVENT23 = {name = "Coups de gr\195\162ce", tooltipText = "Activer/D\195\169sactiver l\'affichage quand vous portez le coup de gr\195\162ce \195\160 un ennemi"};
SCT.LOCALS.OPTION_EVENT24 = {name = "Interruptions", tooltipText = "Activer/D\195\169sactiver l\'affichage quand vous \195\170tes interrompus"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "Scrolling Combat Text", tooltipText = "Activer/D\195\169sactiver Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK2 = { name = "Mode Combat", tooltipText = "Activer/D\195\169sactiver l\'affichage de * autour de tous les Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK3 = { name = "Voir Soigneurs", tooltipText = "Activer/D\195\169sactiver l\'affichage de qui ou par quoi vous \195\170tes soign\195\169s."};
SCT.LOCALS.OPTION_CHECK4 = { name = "Affichage vers le Bas", tooltipText = "Activer/D\195\169sactiver le d\195\169roulement du texte vers le bas"};
SCT.LOCALS.OPTION_CHECK5 = { name = "Critiques", tooltipText = "Activer/D\195\169sactiver les coups/soins critiques au dessus de votre t\195\170te"};
SCT.LOCALS.OPTION_CHECK6 = { name = "Type de Sorts", tooltipText = "Activer/D\195\169sactiver l\'affichage du type de dommage caus\195\169 par les Sorts"};
SCT.LOCALS.OPTION_CHECK7 = { name = "Valider Font: Dommage", tooltipText = "Activer/D\195\169sactiver le changement de la Font sur les dommages dans le jeu par rapport \195\160 la Font us\195\169e par SCT.\n\nIMPORTANT: VOUS DEVEZ VOUS DECONNECTER ET VOUS RECONNECTER POUR QUE CELA PRENNE EFFET. RELANCER L\'INTERFACE NE FONCTIONNE PAS"};
SCT.LOCALS.OPTION_CHECK8 = { name = "Montrer tous les gains d\'\195\169nergie", tooltipText = "Activer/D\195\169sactiver l\'affichage de tous les gains d\'\195\169nergie, pas seulement ceux du chat log\n\nNOTE: l\'\195\169v\195\170nement Gains d\'Energie doit \195\169tre activ\195\169, cela g\195\169n\195\168re BEAUCOUP DE SPAM, et se comporte parfois bizarrement pour les Druides quand ils reviennent en forme de caster."};
SCT.LOCALS.OPTION_CHECK10 = { name = "Montrer l\'overheal", tooltipText = "Activer/D\195\169sactiver l\'affichage de l\'overheal sur vos sorts de soin. N\195\69cessite l\'affichage de 'Vos Soins'."};
SCT.LOCALS.OPTION_CHECK11 = { name = "Alerte sonore", tooltipText = "Activer/D\195\169sactiver le son jou\195\169 pour les alertes."};
SCT.LOCALS.OPTION_CHECK12 = { name = "D\195\169g\195\162ts magiques en couleur", tooltipText = "Activer/D\195\169sactiver l\'affichage des d\195\169g\195\162ts magiques en couleur selon l\'\195\169cole du sort."};
SCT.LOCALS.OPTION_CHECK13 = { name = "Activer les Custom Events", tooltipText = "Activer/D\195\169sactiver l'utilisation des custom events. D\195\169sactiv\195\169, SCT utilise beacoup moins de m\195\169moire."};
SCT.LOCALS.OPTION_CHECK14 = { name = "Spell/Skill Name", tooltipText = "Enables or Disables showing the name of the Spell or Skill that damaged you"};
SCT.LOCALS.OPTION_CHECK15 = { name = "Flash", tooltipText = "Fait 'Flasher' les critiques persistants."};
SCT.LOCALS.OPTION_CHECK16 = { name = "Erafle/D\195\169vastateur", tooltipText = "Activer/D\195\169sactiver l\'affichage des \195\169rafle ~150~ et des coups d\195\169vastateurs ^150^"};
SCT.LOCALS.OPTION_CHECK17 = { name = "Montrer vos HoT", tooltipText = "Activer/D\195\169sactiver l\'affichage de vos soins sur la durée sur les autres. Note: cela peut g\195\169n\195\169rer beaucoup de spam si vous en utilisez beaucoup."};
SCT.LOCALS.OPTION_CHECK18 = { name = "Show Heals at Nameplates", tooltipText = "Enables or Disables attempting to show your heals over the nameplate of the person(s) you heal.\n\nFriendly nameplates must be on, you must be able to see the nameplate, and it will not work 100% of the time. If it does not work, heals appear in the normal configured position.\n\nDisabling can require a reloadUI to take effect."};
SCT.LOCALS.OPTION_CHECK19 = { name = "Disable WoW Healing", tooltipText = "Enables or Disables showing the built in healing text, added in patch 2.1."};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="Vitesse du Texte", minText="Rapide", maxText="Lent", tooltipText = "Contr\195\180le la vitesse d\'animation du texte d\195\169roulant"};
SCT.LOCALS.OPTION_SLIDER2 = { name="Taille Texte", minText="Petit", maxText="Grand", tooltipText = "Contr\195\180le la taille du texte d\195\169roulant"};
SCT.LOCALS.OPTION_SLIDER3 = { name="PV %", minText="10%", maxText="90%", tooltipText = "Contr\195\180le le % de vie n\195\169cessaire pour donner un avertissement"};
SCT.LOCALS.OPTION_SLIDER4 = { name="Mana %", minText="10%", maxText="90%", tooltipText = "Contr\195\180le le % de mana n\195\169cessaire pour donner un avertissement"};
SCT.LOCALS.OPTION_SLIDER5 = { name="Transparence", minText="0%", maxText="100%", tooltipText = "Contr\195\180le la transparence du texte"};
SCT.LOCALS.OPTION_SLIDER6 = { name="Distance du Texte", minText="Petite", maxText="Grande", tooltipText = "Contr\195\180le la distance de d\195\169placement du texte"};
SCT.LOCALS.OPTION_SLIDER7 = { name="Centrer position X ", minText="-600", maxText="600", tooltipText = "Contr\195\180le la position du texte au centre"};
SCT.LOCALS.OPTION_SLIDER8 = { name="Centrer position Y ", minText="-400", maxText="400", tooltipText = "Contr\195\180le la position du texte au centre"};
SCT.LOCALS.OPTION_SLIDER9 = { name="Centrer Position X ", minText="-600", maxText="600", tooltipText = "Contr\195\180le la position du message au centre"};
SCT.LOCALS.OPTION_SLIDER10 = { name="Centrer Position Y ", minText="-400", maxText="400", tooltipText = "Contr\195\180le la position du message au centre"};
SCT.LOCALS.OPTION_SLIDER11 = { name="Temps d\'affichage: ", minText="Rapide", maxText="Lent", tooltipText = "Contr\195\180le le temps d\'affichage des messages"};
SCT.LOCALS.OPTION_SLIDER12 = { name="Taille: ", minText="Petite", maxText="Grande", tooltipText = "Contr\195\180le la taille des messages"};
SCT.LOCALS.OPTION_SLIDER13 = { name="Filtre Soins", minText="0", maxText="500", tooltipText = "Contr\195\180le le soin minimum que vous devez recevoir pour qu\'il apparaisse dans SCT. Utile pour cacher des petits soins fr\195\169quents comme les totems, b\195\169n\195\169dictions, etc..."};
SCT.LOCALS.OPTION_SLIDER14 = { name="Filtre Mana", minText="0", maxText="500", tooltipText = "Contr\195\180le le gain de mana minimum n\195\169cessaire pour qu\'il apparaisse dans SCT. Utile pour cacher des petits gains fr\195\169quents comme les totems, b\195\169n\195\169dictions, etc..."};
SCT.LOCALS.OPTION_SLIDER15 = { name="Distance au HUD", minText="0", maxText="200", tooltipText = "Contr\195\180le la distance au centre pou l\'animation HUD. Utile quand on veut garder les choses centr\195\169es mais ajuster la distance au centre"};
SCT.LOCALS.OPTION_SLIDER16 = { name="Shorten Spell Size", minText="1", maxText="30", tooltipText = "Spell names over this length will be shortend using the selected shorten type."};

--Spell Color options]
SCT.LOCALS.OPTION_COLOR1 = { name=SPELL_SCHOOL0_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL0_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR2 = { name=SPELL_SCHOOL1_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL1_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR3 = { name=SPELL_SCHOOL2_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL2_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR4 = { name=SPELL_SCHOOL3_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL3_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR5 = { name=SPELL_SCHOOL4_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL4_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR6 = { name=SPELL_SCHOOL5_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL5_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR7 = { name=SPELL_SCHOOL6_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL6_CAP.." spells"};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="Options SCT "..SCT.Version};
SCT.LOCALS.OPTION_MISC2 = {name="Close", tooltipText = "Close Spell Colors" };
SCT.LOCALS.OPTION_MISC3 = {name="Edit", tooltipText = "Edit Spell Colors" };
SCT.LOCALS.OPTION_MISC4 = {name="Options: Divers"};
SCT.LOCALS.OPTION_MISC5 = {name="Options: Alerte"};
SCT.LOCALS.OPTION_MISC6 = {name="Options: Animation"};
SCT.LOCALS.OPTION_MISC7 = {name="S\195\169lection: Profil"};
SCT.LOCALS.OPTION_MISC8 = {name="Sauver & Fermer", tooltipText = "Sauvegarde la configuration en cours et ferme les options"};
SCT.LOCALS.OPTION_MISC9 = {name="R.\195\160.Z.", tooltipText = "-ATTENTION-\n\nEtes vous certain de vouloir remettre SCT par d\195\169faut ?"};
SCT.LOCALS.OPTION_MISC10 = {name="S\195\169lection", tooltipText = "S\195\169lectionner le profil d\'un autre personnage"};
SCT.LOCALS.OPTION_MISC11 = {name="Lancer", tooltipText = "Lancer le profil d\'un autre personnage pour ce personne"};
SCT.LOCALS.OPTION_MISC12 = {name="Suppr.", tooltipText = "Supprimer le profil du personnage"};
SCT.LOCALS.OPTION_MISC13 = {name="Text Options" };
SCT.LOCALS.OPTION_MISC14 = {name="Frame 1"};
SCT.LOCALS.OPTION_MISC15 = {name="Messages"};
SCT.LOCALS.OPTION_MISC16 = {name="Animation"};
SCT.LOCALS.OPTION_MISC17 = {name="Spell Options"};
SCT.LOCALS.OPTION_MISC18 = {name="Frames"};
SCT.LOCALS.OPTION_MISC19 = {name="Spells"};
SCT.LOCALS.OPTION_MISC20 = {name="Frame 2"};
SCT.LOCALS.OPTION_MISC21 = {name="Events"};
SCT.LOCALS.OPTION_MISC22 = {name="Profil Classique", tooltipText = "Charge le Profil Classique. Configure SCT de façon tr\195\169s proche de ce qu\'il faisait avant."};
SCT.LOCALS.OPTION_MISC23 = {name="Profil Performance", tooltipText = "Carge le Profil Performance. Choisis des options pour avoir les meilleures performances avec SCT."};
SCT.LOCALS.OPTION_MISC24 = {name="Profil S\195\169par\195\169", tooltipText = "Charge le Profil S\195\169par\195\169. Fait apparaitre les d\195\169g\195\162ts et \195\169v\195\170nements reçus sur la droite, et les soins et buffs reçus sur la gauche."};
SCT.LOCALS.OPTION_MISC25 = {name="Profil de Grayhoof", tooltipText = "Charge le Profil de Grayhoof. Configure SCT de la m\195\170me facon que celui de Grayhoof."};
SCT.LOCALS.OPTION_MISC26 = {name="Profils int\195\169gr\195\169s", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="Profil SCTD S\195\169par\195\169", tooltipText = "Charge le Profil SCTD S\195\169par\195\169. Si SCTD est install\195\169, fait apparaitre les \195\169v\195\170nements arrivant \195\160 droite, ceux qui sortent \195\160 gauche, les divers en haut."};
SCT.LOCALS.OPTION_MISC28 = {name="Test", tooltipText = "Create Test event for each frame"};

--Animation Types
SCT.LOCALS.OPTION_SELECTION1 = { name="Type d\'Animation", tooltipText = "Le type d\'animation que vous voulez utiliser", table = {[1] = "Vertical (Normal)",[2] = "Rainbow",[3] = "Horizontal",[4] = "Angled Down", [5] = "Angled Up", [6] = "Sprinkler", [7] = "HUD Curved", [8] = "HUD Angled"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="Style de C\195\180t\195\169", tooltipText = "Choix du C\195\180t\195\169 ou vous voulez afficher le d\195\169rouler le texte", table = {[1] = "Alterne",[2] = "D\195\169g\195\162ts \195\160 gauche",[3] = "D\195\169g\195\162ts \195\160 droite"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="Police", tooltipText = "Choix de la police que vous voulez utiliser", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION4 = { name="Contour de la police", tooltipText = "Choix du contour de police que vous voulez utiliser", table = {[1] = "Aucun",[2] = "L\195\169ger",[3] = "Fort"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="Police Message", tooltipText = "Choix de la police Message que vous voulez utiliser", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION6 = { name="Contour de la police Message", tooltipText = "Choix du contour de police Message que vous voulez utiliser", table = {[1] = "Aucun",[2] = "L\195\169ger",[3] = "Fort"}};
SCT.LOCALS.OPTION_SELECTION7 = { name="Alignement du texte", tooltipText = "Comment le texte est align\195\169. Surtout utile pour les animations verticales ou HUD. L\'alignement HUD alignera le texte de gauche \195\160 droite et celui de droite \195\160 gauche.", table = {[1] = "Gauche",[2] = "Centre",[3] = "Droite", [4] = "Centrage HUD"}};
SCT.LOCALS.OPTION_SELECTION8 = { name="Shorten Spell Type", tooltipText = "How to shorten spell names.", table = {[1] = "Truncate",[2] = "Abbreviate"}};
