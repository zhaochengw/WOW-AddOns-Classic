-- SCT localization information
-- French Locale
-- Initial translation by Juki <Unskilled>
-- Translation by Sasmira
-- Date 04/03/2006

if GetLocale() ~= "frFR" then return end

-- Static Messages
SCT.LOCALS.LowHP= "Vie Faible !"; -- Message to be displayed when HP is low
SCT.LOCALS.LowMana= "Mana Faible !"; -- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*"; -- Icon to show self hits
SCT.LOCALS.Crushchar = "^";
SCT.LOCALS.Glancechar = "~";
SCT.LOCALS.Combat = "+ Combat"; -- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "- Combat"; -- Message to be displayed when leaving combat
SCT.LOCALS.ComboPoint = "Points de Combo "; -- Message to be displayed when gaining a combo point
SCT.LOCALS.CPMaxMessage = " ... A Mooort !!!"; -- Message to be displayed when you have max combo points
SCT.LOCALS.ExtraAttack = "Extra Attack!"; -- Message to be displayed when time to execute
SCT.LOCALS.KillingBlow = "Coup de gr\195\162ce !"; -- Message to be displayed when you kill something
SCT.LOCALS.Interrupted = "Interrompu !"; -- Message to be displayed when you are interrupted
SCT.LOCALS.Rampage = "Saccager"; -- Message to be displayed when rampage is needed

--startup messages
SCT.LOCALS.STARTUP = "Scrolling Combat Text "..SCT.Version.." charg\195\169. Tapez /sctmenu pour les options.";
SCT.LOCALS.Option_Crit_Tip = "Mettre cet \195\169v\195\168nement toujours apparent lors d\'un CRITIQUE.";
SCT.LOCALS.Option_Msg_Tip = "Mettre cet \195\169v\195\168nement toujours apparent lors d\'un MESSAGE. Surpasse les Critiques.";
SCT.LOCALS.Frame1_Tip = "Afficher cet \195\169v\195\170nement avec le style d\'animation 1.";
SCT.LOCALS.Frame2_Tip = "Afficher cet \195\169v\195\170nement avec le style d\'animation 2";

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00SCT AVERTISSANT|r\n\n vos variables sauv\195\169 es sont d\'une version p\195\169rim\195\169e de SCT. Si vous rencontrez des erreurs ou le comportement \195\169trange, REMETTEZ \195\160 Z\195\169ro svp vos options \195\160 l\'aide du bouton de remise ou par /sctreset de dactylographie";
SCT.LOCALS.Load_Error = "|cff00ff00Erreur en chargeant SCT Options. Il est peut-\195\170tre d\195\169sactiv\195\169.|r";

--nouns
SCT.LOCALS.TARGET = "La cible";
SCT.LOCALS.PROFILE = "SCT Profil charg\195\169: |cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "SCT Profil supprim\195\169: |cff00ff00";
SCT.LOCALS.PROFILE_NEW = "SCT Nouveau Profil Cr\195\169e: |cff00ff00";
SCT.LOCALS.WARRIOR = "Guerrier";
SCT.LOCALS.ROGUE = "Voleur";
SCT.LOCALS.HUNTER = "Chasseur";
SCT.LOCALS.MAGE = "Mage";
SCT.LOCALS.WARLOCK = "D\195\169moniste";
SCT.LOCALS.SHAMAN = "Chaman";
SCT.LOCALS.PALADIN = "Paladin";
SCT.LOCALS.DRUID = "Druide";
SCT.LOCALS.PRIEST = "Pr\195\170tre";

--Useage
SCT.LOCALS.DISPLAY_USEAGE = "Utilisation : \n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'message' (pour du texte blanc)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'message' rouge(0-10) vert(0-10) bleu(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Exemple : /sctdisplay 'Soignez Moi' 10 0 0\nCela affichera 'Soignez Moi' en rouge vif\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Quelques Couleurs : rouge = 10 0 0, vert = 0 10 0, bleu = 0 0 10,\njaune = 10 10 0, violet = 10 0 10, cyan = 0 10 10";
	
--Fonts
SCT.LOCALS.FONTS = { 
	[1] = { name="Friz Quadrata TT", path="Fonts\\FRIZQT__.TTF"},
	[2] = { name="SCT TwCenMT", path="Interface\\Addons\\sct\\fonts\\Tw_Cen_MT_Bold.TTF"},
	[3] = { name="SCT Adventure", path="Interface\\Addons\\sct\\fonts\\Adventure.ttf"},
	[4] = { name="SCT Enigma", path="Interface\\Addons\\sct\\fonts\\Enigma__2.TTF"},
	[5] = { name="SCT Emblem", path="Interface\\Addons\\sct\\fonts\\Emblem.ttf"},
	[6] = { name="SCT Diablo", path="Interface\\Addons\\sct\\fonts\\Avqest.ttf"},
}

-- Cosmos button
SCT.LOCALS.CB_NAME = "Scrolling Combat Text".." "..SCT.Version;
SCT.LOCALS.CB_SHORT_DESC = "Par Grayhoof";
SCT.LOCALS.CB_LONG_DESC = "Affiche les messages de combat au dessus du personnage";
SCT.LOCALS.CB_ICON = "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"
