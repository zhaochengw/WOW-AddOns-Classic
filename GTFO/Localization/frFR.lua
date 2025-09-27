--------------------------------------------------------------------------
-- frFR.lua 
--------------------------------------------------------------------------
--[[
GTFO French Localization
Translator: Blubibulga, TrAsHeR, Dabeuliou
]]--

if (GetLocale() == "frFR") then
	local L = GTFOLocal;
	L.Active_Off = "Addon suspendu";
	L.Active_On = "Addon actif";
	L.AlertType_Fail = "Échec";
	L.AlertType_FriendlyFire = "Dégâts aux alliés";
	L.AlertType_High = "Haut";
	L.AlertType_Low = "Bas";
	L.ClosePopup_Message = "Vous pouvez configurer vos paramètres de GTFO plus tard en tapant : %s";
	L.Group_None = "Aucun";
	L.Group_NotInGroup = "Vous n'êtes pas dans un groupe ou un raid.";
	L.Group_PartyMembers = "%d des %d membres du groupe utilisent cet addon.";
	L.Group_RaidMembers = "%d des %d membres du raid utilisent cet addon.";
	L.Help_Intro = "v%s (|cFFFFFFFFListe de commande|r)";
	L.Help_Options = "Options d'affichages";
	L.Help_Suspend = "Suspendre/Activer l'addon";
	L.Help_Suspended = "L'addon est actuellement suspendu.";
	L.Help_TestFail = "Jouer un test sonore (alerte d'échec)";
	L.Help_TestFriendlyFire = "Jouer un test sonore (dégâts aux alliés)";
	L.Help_TestHigh = "Jouer un test sonore (dommage élevé)";
	L.Help_TestLow = "Jouer un test sonore (dommage faible)";
	L.Help_Version = "Afficher les autres attaquants exécutant cet addon";
	L.Loading_Loaded = "v%s chargé.";
	L.Loading_LoadedSuspended = "v%s chargé. (|cFFFF1111Suspendu|r)";
	L.Loading_LoadedWithPowerAuras = "v%s chargé avec Power Auras.";
	L.Loading_NewDatabase = "v%s: Nouvelle version de base de données détectée, réinitialiser les paramètres par défaut.";
	L.Loading_OutOfDate = "v%s est maintenant disponible en téléchargement !  |cFFFFFFFFVeuillez mettre à jour.|r";
	L.LoadingPopup_Message = "Vos paramètres de GTFO ont été réinitialisées par défaut.  Vous voulez configurer vos paramètres maintenant ?";
	L.Loading_PowerAurasOutOfDate = "Votre version de |cFFFFFFFFPower Auras Classic|r est obsolète !  GTFO & l'intégration de Power Auras n'a pas pu être chargée.";
	L.Recount_Environmental = "Environnemental";
	L.Recount_Name = "Alertes GTFO";
	L.Skada_AlertList = "Types d'Alertes GTFO";
	L.Skada_Category = "Alertes";
	L.Skada_SpellList = "Sorts GTFO";
	L.TestSound_Fail = "Test sonore (alerte d'échec) joué.";
	L.TestSound_FailMuted = "Test sonore (alerte d'échec) joué. [|cFFFF4444MUET|r]";
	L.TestSound_FriendlyFire = "Test sonore (dégâts aux alliés) joué.";
	L.TestSound_FriendlyFireMuted = "Test sonore (dégâts aux alliés) joué. [|cFFFF4444MUET|r]";
	L.TestSound_High = "Test sonore (dommage élevé) joué.";
	L.TestSound_HighMuted = "Test sonore (dommage élevé) joué. [|cFFFF4444MUET|r]";
	L.TestSound_Low = "Test sonore (dommage faible) joué.";
	L.TestSound_LowMuted = "Test sonore (dommage faible) joué. [|cFFFF4444MUET|r]";
	L.UI_Enabled = "Activé";
	L.UI_EnabledDescription = "Activer l'addon GTFO.";
	L.UI_Fail = "Sons d'alertes d'échecs";
	L.UI_FailDescription = "Activer les sons d'alertes GTFO lorsque vous êtes SUPPOSÉ allez plus loin -- j'espère que vous apprendrez pour la prochaine fois !";
	L.UI_FriendlyFire = "Sons de dégâts aux alliés";
	L.UI_FriendlyFireDescription = "Activer les sons d'alerte de GTFO lorsque vos coéquipiers marchent dans des explosions -- un de vos meilleurs déplacement !";
	L.UI_HighDamage = "Sons de Raid/Haut Dommage";
	L.UI_HighDamageDescription = "Activer les sons du buzzer de GTFO pour les environnements dangereux que vous devez éviter d'immédiatement.";
	L.UI_LowDamage = "Sons de JcJ/Environnement/Faible Dommage";
	L.UI_LowDamageDescription = "Activer les sons de crétins de GTFO -- utiliser votre discrétion ou non pour bouger de ces environnements de dommages faible";
	L.UI_SoundChannel = "Canal de son";
	L.UI_SoundChannelDescription = "Il s'agit du canal de volume que GTFO assignera à ses alertes.";
	L.UI_SpecialAlerts = "Alertes Spéciales";
	L.UI_SpecialAlertsHeader = "Activer les Alertes Spéciales";
	L.UI_Test = "Test";
	L.UI_TestDescription = "Tester le son.";
	L.UI_TestMode = "Mode Expérimental/Bêta";
	L.UI_TestModeDescription = "Activer les alertes non testées/non vérifiées (Beta/PTR)";
	L.UI_TestModeDescription2 = "Veuillez signaler tout problème à |cFF44FFFF%s@%s.%s|r";
	L.UI_Trivial = "Alertes de contenu futiles";
	L.UI_TrivialDescription = "Activer les alertes pour les rencontres de bas niveau qui seraient autrement jugées futiles pour le niveau actuel du votre personnage.";
	L.UI_TrivialDescription2 = "Réglez le curseur au montant minimum de % de dégâts de PV prises pour les alertes non considérées comme futiles.";
	L.UI_TrivialSlider = "% minimum de PV";
	L.UI_Unmute = "Jouer les sons lorsque mis en sourdine";
	L.UI_UnmuteDescription = "Si vous avez le son principal mis en sourdine, GTFO activera temporairement le son brièvement pour jouer les sons de GTFO.";
	L.UI_UnmuteDescription2 = "Cela exige que le curseur du volume principal soit supérieur à 0 %.";
	L.UI_Volume = "Volume GTFO";
	L.UI_VolumeDescription = "Définissez le volume de la lecture des sons.";
	L.UI_VolumeLoud = "4 : Fort";
	L.UI_VolumeLouder = "5 : Fort";
	L.UI_VolumeMax = "Max";
	L.UI_VolumeMin = "Min";
	L.UI_VolumeNormal = "3 : Normal (Recommandé)";
	L.UI_VolumeQuiet = "1 : Calme";
	L.UI_VolumeSoft = "2 : Doux";
	L.Version_Off = "Rappels de mise à jour de version désactivés";
	L.Version_On = "Rappels de mise à jour de version activés";
end
