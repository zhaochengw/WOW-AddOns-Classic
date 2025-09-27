--------------------------------------------------------------------------
-- ptBR.lua 
--------------------------------------------------------------------------
--[[
GTFO Brazilian Portuguese Localization
Translator: Phalk, Omukeka
]]--

if (GetLocale() == "ptBR") then
	local L = GTFOLocal;
	L.Active_Off = "Addon suspenso";
	L.Active_On = "Addon retomado";
	L.AlertType_Fail = "Falha";
	L.AlertType_FriendlyFire = "Fogo Amigo";
	L.AlertType_High = "Alto";
	L.AlertType_Low = "Baixo";
	L.ClosePopup_Message = "Você pode configurar seu GTFO depois digitando: %s";
	L.Group_None = "Nenhum";
	L.Group_NotInGroup = "Você não está em um grupo ou raide.";
	L.Group_PartyMembers = "%d de %d membros do grupo usam esse addon.";
	L.Group_RaidMembers = "%d de %d membros da raide usam este addon.";
	L.Help_Intro = "v%s (|cFFFFFFFFLista de Comandos|r)";
	L.Help_Options = "Mostrar Opções";
	L.Help_Suspend = "Suspender/Retomar addon";
	L.Help_Suspended = "O addon está atualmente suspenso.";
	L.Help_TestFail = "Testar um som (alerta de falha)";
	L.Help_TestFriendlyFire = "Tocar um som de teste (fogo amigo)";
	L.Help_TestHigh = "Tocar um som de teste (dano alto)";
	L.Help_TestLow = "Tocar um som de teste (dano baixo)";
	L.Help_Version = "Mostrar outros membros da raide usando este addon";
	L.LoadingPopup_Message = "Suas configurações para o GTFO foram redefinidas ao padrão. Você quer reconfigurar agora?";
	L.Loading_Loaded = "v%s carregado.";
	L.Loading_LoadedSuspended = "v%s carregado. (|cFFFF1111Suspenso|r)";
	L.Loading_LoadedWithPowerAuras = "v%s carregado junto do Power Auras.";
	L.Loading_NewDatabase = "v%s: Novo banco de dados detectado, redefinindo aos padrões.";
	L.Loading_OutOfDate = "v%s está disponível para download! |cFFFFFFFFAtualize por favor.|r";
	L.Loading_PowerAurasOutOfDate = "A versão do seu |cFFFFFFFFPower Auras Classic|r está desatualizada! A integração do GTFO e Power Auras não pôde ser carregada.";
	L.Recount_Environmental = "Ambientais";
	L.Recount_Name = "Alertas do GTFO";
	L.Skada_AlertList = "Tipos de Alerta do GTFO";
	L.Skada_Category = "Alertas";
	L.Skada_SpellList = "Magias do GTFO";
	L.TestSound_Fail = "Reproduzindo teste de som (alerta de falha).";
	L.TestSound_FailMuted = "Reproduzindo teste de som (alerta de falha). [|cFFFF4444MUDO|r]";
	L.TestSound_FriendlyFire = "Som de teste (fogo amigo) sendo tocado.";
	L.TestSound_FriendlyFireMuted = "Som de teste (fogo amigo) sendo tocado. [|cFFFF4444MUDO|r]";
	L.TestSound_High = "Reproduzindo teste de som (dano alto).";
	L.TestSound_HighMuted = "Reproduzindo teste de som (dano alto). [|cFFFF4444MUDO|r]";
	L.TestSound_Low = "Reproduzindo teste de som (dano baixo).";
	L.TestSound_LowMuted = "Reproduzindo teste de som (dano baixo). [|cFFFF4444MUDO|r]";
	L.UI_Enabled = "Habilitado";
	L.UI_EnabledDescription = "Habilitar o addon GTFO.";
	L.UI_Fail = "Sons de Alerta para Falhas";
	L.UI_FailDescription = "Habilitar os sons de alerta do GTFO para quando você tiver que se mover -- talvez da próxima vez você aprenda!";
	L.UI_FriendlyFire = "Sons para Fogo Amigo";
	L.UI_FriendlyFireDescription = "Ativar os alertas do GTFO para quando amigos estiverem explodindo -- é melhor um de vocês se mover!";
	L.UI_HighDamage = "Sons para Dano Alto/Raide";
	L.UI_HighDamageDescription = "Ativar os sons de corneta do GTFO para ambientes perigosos em que você deva se mover imediatamente.";
	L.UI_LowDamage = "Sons para JcJ/Ambiente/Dano Baixo.";
	L.UI_LowDamageDescription = "Ativar os bipes do GTFO -- use sua discrição para se mover ou não destas situações de dano baixo";
	L.UI_Test = "Teste";
	L.UI_TestDescription = "Testar o som.";
	L.UI_TestMode = "Modo Beta/Experimental";
	L.UI_TestModeDescription = "Testar alertas não verificados/não testados (Beta/PTR)";
	L.UI_TestModeDescription2 = "Por favor reporte qualquer problema para |cFF44FFFF%s@%s.%s|r";
	L.UI_Trivial = "Alertas para conteúdos triviais";
	L.UI_TrivialDescription = "Ativar alertas para encontros de baixo nível que seriam considerados triviais para o level atual do seu personagem.";
	L.UI_Unmute = "Tocar sons quando mudo";
	L.UI_UnmuteDescription = "Se você tiver o controle de som mestre mudo, o GTFO irá momentaneamente ligá-lo para tocar os sons do GTFO.";
	L.UI_Volume = "Volume do GTFO";
	L.UI_VolumeDescription = "Definir o volume dos sons tocados.";
	L.UI_VolumeLoud = "4: Alto";
	L.UI_VolumeLouder = "5: Alto";
	L.UI_VolumeMax = "Max";
	L.UI_VolumeMin = "Min";
	L.UI_VolumeNormal = "3: Normal (Recomendado)";
	L.UI_VolumeQuiet = "1: Silêncio";
	L.UI_VolumeSoft = "2: Suave";
	-- 4.12
	L.UI_SpecialAlerts = "Alertas Especiais";
	L.UI_SpecialAlertsHeader = "Ativar Alertas";	
	-- 4.12.3
	L.Version_On = "Aviso de atualização";
	L.Version_Off = "Aviso de atualização";
	-- 4.19.1
	L.UI_TrivialSlider = "Minimum % of HP";
	L.UI_TrivialDescription2 = "Set the slider to the minimum % amount of HP damage taken for alerts to not be considered trivial.";
	-- 4.32
	L.UI_UnmuteDescription2 = "This requires the master volume slider to be higher than 0% and will override the sound channel option.";
	L.UI_SoundChannel = "Sound Channel";
	L.UI_SoundChannelDescription = "This is the volume channel that GTFO alert sounds will attach themselves to.";
	L.UI_SoundChannel_Master = "Master";
	L.UI_SoundChannel_SFX = "Sound Effects";
	L.UI_SoundChannel_Ambience = "Ambience";
	L.UI_SoundChannel_Music = "Music";
	L.UI_SoundChannel_Dialog = "Dialog";
end
