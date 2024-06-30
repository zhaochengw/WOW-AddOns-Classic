-- Version : German (by Endymion, StarDust, Sasmira, Gamefaq)
-- Last Update : 09/16/2005

if GetLocale() ~= "deDE" then return end

-- Static Messages
SCT.LOCALS.LowHP = "Wenig Gesundheit!"; -- Message to be displayed when HP is low
SCT.LOCALS.LowMana = "Wenig Mana!"; -- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*"; -- Icon to show self hits
SCT.LOCALS.Crushchar = "^";
SCT.LOCALS.Glancechar = "~";
SCT.LOCALS.Combat = "+Kampf"; -- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "-Kampf"; -- Message to be displayed when leaving combat
SCT.LOCALS.Ready = "bereit";			  		-- Message to be displayed when cooldown is finished
SCT.LOCALS.ComboPoint = "CP"; -- Message to be displayed when gaining a combo point
SCT.LOCALS.CPMaxMessage = "Beende es!"; -- Message to be displayed when you have max combo points
SCT.LOCALS.ExtraAttack = "Extra Attack!"; -- Message to be displayed when time to execute
SCT.LOCALS.KillingBlow = "Todessto\195\159!"; -- Message to be displayed when you kill something
SCT.LOCALS.Interrupted = "Unterbrochen!"; -- Message to be displayed when you are interrupted
SCT.LOCALS.Rampage = "Toben"; -- Message to be displayed when rampage is needed

--Option messages
SCT.LOCALS.STARTUP = "Scrolling Combat Text "..SCT.Version.." AddOn geladen. Gib /sctmenu f\195\188r Optionen ein.";
SCT.LOCALS.Option_Crit_Tip = "Dieses Ereignis immer als KRITISCH anzeigen lassen.";
SCT.LOCALS.Option_Msg_Tip = "Dieses Ereignis immer als NACHRICHT erscheinen lassen. Ignoriert KRITS.";
SCT.LOCALS.Frame1_Tip = "Dieses Ereignis immer im FENSTER 1 erscheinen lassen.";
SCT.LOCALS.Frame2_Tip = "Dieses Ereignis immer im FENSTER 2 erscheinen lassen";

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00SCT WARNUNG|r\n\nDeine gespeicherten Einstellungen sind von einer veralteten SCT Version. Wenn Du Fehler oder merkw\195\188rdiges Verhalten antriffst, setze bitte Deine Optionen mit der Zur\195\188cksetzentaste z\195\188rück oder tippe /sctreset ein";
SCT.LOCALS.Load_Error = "|cff00ff00Fehler beim Laden der SCT Optionen. Sie k\195\182nnten deaktiviert sein. |r Fehler: ";

--nouns
SCT.LOCALS.TARGET = "Ziel ";
SCT.LOCALS.PROFILE = "SCT Profil geladen: |cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "SCT Profil gel\195\182scht: |cff00ff00";
SCT.LOCALS.PROFILE_NEW = "Neues SCT Profil erstellt: |cff00ff00";
SCT.LOCALS.WARRIOR = "Krieger";
SCT.LOCALS.ROGUE = "Schurke";
SCT.LOCALS.HUNTER = "J\195\164ger";
SCT.LOCALS.MAGE = "Magier";
SCT.LOCALS.WARLOCK = "Hexenmeister";
SCT.LOCALS.DRUID = "Druide";
SCT.LOCALS.PRIEST = "Priester";
SCT.LOCALS.SHAMAN = "Schamane";
SCT.LOCALS.PALADIN = "Paladin";

--Useage
SCT.LOCALS.DISPLAY_USEAGE = "Benutzung: \n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'Nachricht' (f\195\188r wei\195\159en Text)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'Nachricht' red(0-10) green(0-10) blue(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Beispiel: /sctdisplay 'Heile Mich' 10 0 0\nDies stellt 'Heile Mich' in hellrot dar.\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Einige Farben: Rot = 10 0 0, Gr\195\188n = 0 10 0, Blau = 0 0 10,\nGelb = 10 10 0, Magenta = 10 0 10, Zyan = 0 10 10";

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
SCT.LOCALS.CB_SHORT_DESC = "von Grayhoof";
SCT.LOCALS.CB_LONG_DESC = "Klicken zum \195\150ffnen der SCT Optionen";
SCT.LOCALS.CB_ICON = "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"
