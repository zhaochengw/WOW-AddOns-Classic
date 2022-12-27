local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "ptBR")
if not L then return end
-- TOC Note: Detecta e alerta você da presença de jogadores inimigos.

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Versão"
L["Spy Option"] = "Spy"
L["Profiles"] = "Perfis"

-- About
L["About"] = "Info"
L["SpyDescription1"] = [[
Spy é um addon que vai alerta-lo da presença de jogadores inimigos nas proximidades. Estas são algumas das principais características.

]]

L["SpyDescription2"] = [[
|cffffd000 Lista de Proximidades |cffffffff
A lista de Proximidades mostra qualquer inimigo detectado nas proximidades. Jogadores são removidos da lista se não forem mais detectados após um certo período de tempo.

|cffffd000 Lista da Última Hora |cffffffff
Exibe todos os inimigos detectados em uma hora.

|cffffd000 Lista de Ignorados |cffffffff
Jogadores que são adicionados à lista de Ignorados não serão reportados pelo Spy. Você pode adicionar ou remover jogadores dessa lista usando o menu de contexto ou segurando Ctrl enquanto clicando no botão.

|cffffd000 Lista Negra |cffffffff
Jogadores que são adicionados à Lista Negra são reportados pelo Spy através de um alarme sonoro.  Você pode adicionar ou remover jogadores dessa lista usando o menu de contexto ou segurando Shift enquanto clica no botão. O menu de contexto também permite que você justifique as razões que o levou a colocar determinada pessoa na Lista Negra. Se quiser colocar uma motivo especifico que não tenha na lista, em seguida, use "Digite seu próprio motivo..." em Outra lista.

]]

L["SpyDescription3"] = [[
|cffffd000 Statistics Window |cffffffff
The Statistics Window contains a list of all enemy encounters which can be sorted by name, level, guild, wins, losses and the last time an enemy was detected. It also provides the ability to search for a specific enemy by name or guild and has filters to show only enemies that are marked as Kill on Sight, with a Win/Loss or entered Reasons. 

|cffffd000 Kill On Sight Button |cffffffff
If enabled, this button will be located on the enemy players target frame. Clicking on this button will add/remove the enemy target to/from the Kill On Sight list. Right clicking on the button will allow you to enter Kill on Sight reasons.

|cffffd000 Autor:|cffffffff Slipjack|cffffffff
]]

-- General Settings
L["GeneralSettings"] = "Configurações Gerais"
L["GeneralSettingsDescription"] = [[
Opções para quando o Spy está ativado ou desativado.
]]
L["EnableSpy"] = "Ativar Spy"
L["EnableSpyDescription"] = "Ativa ou desativa o Spy."
L["EnabledInBattlegrounds"] = "Ativar Spy em CB"
L["EnabledInBattlegroundsDescription"] = "Ativa ou desativa o Spy em Campos de Batalha."
L["EnabledInArenas"] = "Ativar Spy em Arenas"
L["EnabledInArenasDescription"] = "Ativa ou desativa o Spy em Arenas."
L["EnabledInWintergrasp"] = "Ativar Spy em Zonas de Combate"
L["EnabledInWintergraspDescription"] = "Ativa ou desativa o Spy em locais como Invérnia."
L["DisableWhenPVPUnflagged"] = "Desativar Spy quando JxJ estiver desativado"
L["DisableWhenPVPUnflaggedDescription"] = "Ativa ou desativa o Spy dependendo se o seu status de JxJ estiver ativado ou desativado."
L["DisabledInZones"] = "Desative o Spy enquanto estiver nesses locais"
L["DisabledInZonesDescription"]	= "Selecione locais onde o Spy será desativado"
L["Booty Bay"] = "Angra do Butim"
L["Everlook"] = "Visteterna"						
L["Gadgetzan"] = "Geringontzan"
L["Ratchet"] = "Vila Catraca"
L["The Salty Sailor Tavern"] = "Taberna do Lobo do Mar"
L["Shattrath City"] = "Shattrath"
L["Area 52"] = "Área 52"
L["Dalaran"] = "Dalaran"
L["Dalaran (Northrend)"] = "Dalaran (Nortúndria)"
L["Bogpaddle"] = "Brejo do Goblin"
L["The Vindicaar"] = "A Vindicaar"
L["Krasus' Landing"] = "Plataforma de Krasus"
L["The Violet Gate"] = "Portão Violeta"
L["Magni's Encampment"] = "Acampamento de Magni"
L["Silithus"] = "Silithus"
L["Chamber of Heart"] = "Câmara do Coração"
L["Hall of Ancient Paths"] = "Salão dos Antigos Caminhos"
L["Sanctum of the Sages"] = "Sacrário dos Sábios"
L["Rustbolt"] = "Ferrúgia"
L["Oribos"] = "Oribos"
L["Valdrakken"] = "Valdrakken"

-- Display
L["DisplayOptions"] = "Exibição"
L["DisplayOptionsDescription"] = [[
Opções para a janela Spy e dicas de ferramentas.
]]
L["ShowOnDetection"] = "Mostrar Spy quando um inimigo for detectado"
L["ShowOnDetectionDescription"] = "Marque isso para que o Spy mostre a lista de Proximidades quando um inimigo for detectado."
L["HideSpy"] = "Esconder Spy quando nenhum inimigo for detectado"
L["HideSpyDescription"] = "Marque isso para que o Spy seja escondido quando a lista de Proximidades estiver sendo mostrada e ficar vazia. Spy não será escondido se você limpar a lista manualmente."
L["ShowOnlyPvPFlagged"] = "Mostrar apenas jogadores inimigos sinalizados para JxJ"
L["ShowOnlyPvPFlaggedDescription"] = "Defina isto para mostrar apenas jogadores inimigos marcados para JxJ na lista Proximidades.."
L["ShowKoSButton"] = "Mostrar o botão da lista negra no quadro alvo inimigo"
L["ShowKoSButtonDescription"] = "Defina isso para mostrar o botão da lista negra no quadro alvo do jogador inimigo."
L["Alpha"] = "Transparência"
L["AlphaDescription"] = "Defina a transparência da janela Spy."
L["AlphaBG"] = "Transparência em CB"
L["AlphaBGDescription"] = "Defina a transparência da janela Spy nos Campos de Batalha."
L["LockSpy"] = "Travar a janela do Spy"
L["LockSpyDescription"] = "Trava a janela para que ela não possa ser movida."
L["ClampToScreen"] = "Limitar na Tela"
L["ClampToScreenDescription"] = "Controla quando a janela do Spy pode ser arrastada para fora da tela."
L["InvertSpy"] = "Inverter a janela de Spy"
L["InvertSpyDescription"] = "Inverte a janela de Spy de cabeça para baixo."
L["Reload"] = "Recarregar UI"
L["ReloadDescription"] = "Necessário ao alterar a janela do Spy."
L["ResizeSpy"] = "Redimensionar janela do Spy automaticamente"
L["ResizeSpyDescription"] = "Marque isso para que a janela do Spy seja redimensionada a medida que novos jogadores são adicionados ou removidos."
L["ResizeSpyLimit"] = "Limite de lista"
L["ResizeSpyLimitDescription"] = "Limite o número de jogadores inimigos mostrados na janela do Spy."
L["DisplayTooltipNearSpyWindow"] = "Exibir dica de ferramenta perto da janela do Spy"
L["DisplayTooltipNearSpyWindowDescription"] = "Defina isso para exibir dicas de ferramentas perto da janela do Spy."
L["SelectTooltipAnchor"] = "Ponto de ancoragem da dica de ferramenta"
L["SelectTooltipAnchorDescription"] = "Selecione o ponto de ancoragem para a dica de ferramenta se a opção acima tiver sido marcada."
L["ANCHOR_CURSOR"] = "Cursor"
L["ANCHOR_TOP"] = "Acima"
L["ANCHOR_BOTTOM"] = "Debaixo"
L["ANCHOR_LEFT"] = "Esquerda"			
L["ANCHOR_RIGHT"] = "Direita"
L["TooltipDisplayWinLoss"] = "Mostar estastica de Vitória/Derrota nas dicas"
L["TooltipDisplayWinLossDescription"] = "Marque isso para que seja mostrado na dicas do jogador, as estasticas de Vitória/Derrota daquele um jogador."
L["TooltipDisplayKOSReason"] = "Mostrar motivos da Lista Negra nas dicas"
L["TooltipDisplayKOSReasonDescription"] = "Marque isso para que seja mostrado na dicas do jogador os motivos da Lista Negra daquele jogador."
L["TooltipDisplayLastSeen"] = "Mostrar detalhes da ultima vez visto nas dicas"
L["TooltipDisplayLastSeenDescription"] = "Marque isso para que seja mostrado nas dicas de jogador o ultimo local e hora em que aquele jogador foi visto."
L["DisplayListData"] = "Selecione os dados do inimigo para exibir"
L["Name"] = "Nome"
L["Class"] = "Classe"
L["Rank"] = "Posto"
L["SelectFont"] = "Selekt e Font"
L["SelectFontDescription"] = "Selecione um tipo de letra para a janela Spy."
L["RowHeight"] = "Selecione a altura da linha"
L["RowHeightDescription"] = "Selecione a altura da linha para a janela Spy."
L["Texture"] = "Textura"
L["TextureDescription"] = "Selecione a textura da janela Spy"

-- Alerts
L["AlertOptions"] = "Alertas"
L["AlertOptionsDescription"] = [[
Opções para alertas, anúncios e avisos quando jogadores inimigos são detectados.
]]
L["SoundChannel"] = "Selecionar canal de som"
L["Master"] = "Geral"
L["SFX"] = "Efeitos sonoros"
L["Music"] = "Musica"
L["Ambience"] = "Ambiência"
L["Announce"] = "Anunciar Para:"
L["None"] = "Ninguem"
L["NoneDescription"] = "Não anunciar quando jogadores inimigos forem detectados."
L["Self"] = "Você"
L["SelfDescription"] = "Anunciar para si mesmo quando jogadores inimigos forem detectados"
L["Party"] = "Grupo"
L["PartyDescription"] = "Anunciar para o grupo quando jogadores inimigos forem detectados."
L["Guild"] = "Guilda"
L["GuildDescription"] = "Anunciar para a guilda quando jogadores inimigos forem detectados."
L["Raid"] = "Raide"
L["RaidDescription"] = "Anunciar para a raide quando jogadores inimigos forem detectados."
L["LocalDefense"] = "Defesa Local"
L["LocalDefenseDescription"] = "Anunciar para a Defesa Local quando jogadores inimigos forem detectados."
L["OnlyAnnounceKoS"] = "Anunciar inimigos da Lista Negra"
L["OnlyAnnounceKoSDescription"] = "Marque isso para anunciar apenas inimigos que estejam na Lista Negra."
L["WarnOnStealth"] = "Alertar ao detectar invisibilidade"
L["WarnOnStealthDescription"] = "Marque isso para alertar com texto e som quando um inimigo ficar invisivel."
L["WarnOnKOS"] = "Alertar ao detectar inimigos da Lista Negra"
L["WarnOnKOSDescription"] = "Marque isso para alertar com texto e som quando um inimigo da Lista Negra for detectado."
L["WarnOnKOSGuild"] = "Alertar ao detectar Guildie de Lista Negra"
L["WarnOnKOSGuildDescription"] = "Marque isso para alertar com texto e som quando for detectado um integrante da guilda de alguem que esteja na Lista Negra."
L["WarnOnRace"] = "Avisar após a detecção raça"
L["WarnOnRaceDescription"] = "Defina esta opção para soar um alerta quando a raça selecionada é detectado."
L["SelectWarnRace"] = "Selecione Raça para a detecção"
L["SelectWarnRaceDescription"] = "Selecione uma raça para alerta de áudio."
L["WarnRaceNote"] = "Nota: Você deve atingir o inimigo, pelo menos uma vez para que sua raça pode ser adicionado ao banco de dados. Na próxima detecção um alerta será emitido. Isso não funciona o mesmo que detectar os inimigos próximos em combate."
L["DisplayWarningsInErrorsFrame"] = "Mostrar alertas no campo de erros"
L["DisplayWarningsInErrorsFrameDescription"] = "Marque isso para usar o campo de erros para mostrar alertas ao invés de usar os popups graficos."
L["DisplayWarnings"] = "Selecione o local da mensagem de avisos"
L["Default"] = "padrão"
L["ErrorFrame"] = "Quadro de erro"
L["Moveable"] = "móvel"
L["EnableSound"] = "Ativar alertas sonoros"
L["EnableSoundDescription"] = "marque isso para ativar alertas sonoros quando um inimigo for detectado. Os sons são diferentes para Lista Negra e inimigos que ficam invisiveis."
L["OnlySoundKoS"] = "Somente alertas sonoros de áudio para a lista Negra"
L["OnlySoundKoSDescription"] = "Defina esta opção para reproduzir apenas alertas de áudio quando forem detectados jogadores inimigos na lista Negra."
L["StopAlertsOnTaxi"] = "Desativar alertas enquanto estiver em uma rota de vôo"
L["StopAlertsOnTaxiDescription"] = "Interrompa todos os novos alertas e avisos enquanto estiver em uma rota de vôo."

-- Nearby List
L["ListOptions"] = "Lista de Proximidades"
L["ListOptionsDescription"] = [[
Você pode configurar como o Spy adiciona e remove inimigos da lista de Proximidades.
]]
L["RemoveUndetected"] = "Remover jogadores não detectados da lista de Proximidades após:"
L["1Min"] = "1 minuto"
L["1MinDescription"] = "Remove jogadores que não forem mais detectados após 1 minuto."
L["2Min"] = "2 minutos"
L["2MinDescription"] = "Remove jogadores que não forem mais detectados após 2 minutos."
L["5Min"] = "5 minutos"
L["5MinDescription"] = "Remove jogadores que não forem mais detectados após 5 minutos."
L["10Min"] = "10 minutos"
L["10MinDescription"] = "Remove jogadores que não forem mais detectados após 10 minutos."
L["15Min"] = "15 minutos"
L["15MinDescription"] = "Remove jogadores que não forem mais detectados após 15 minutos."
L["Never"] = "Nunca Remover"
L["NeverDescription"] = "Nunca remover jogadores inimigos. A lista de Proximidades ainda pode ser limpa manualmente."
L["ShowNearbyList"] = "Trocar para a lista de Proximidades ao detectar jogador inimigo"
L["ShowNearbyListDescription"] = "Marque isso para que ao detectar jogadores inimigos, seja mostrada a lista de Proximidades se já não estiver sendo mostrada."
L["PrioritiseKoS"] = "Piorizar inimigos da Lista Negra na lista de Proximidades"
L["PrioritiseKoSDescription"] = "Marque isso para sempre motrar primeiro inimigos da Lista Negra na lista de Proximidades."

-- Map
L["MapOptions"] = "Mapa"
L["MapOptionsDescription"] = [[
Opções para mapa-múndi e minimapa, incluindo ícones e dicas de ferramentas.
]]
L["MinimapDetection"] = "Ativar detecção de minimapa"
L["MinimapDetectionDescription"] = "Rolar o cursor sobre jogadores inimigos conhecidos detectados no minimapa os adicionará à lista de Proximidades."
L["MinimapNote"] = "          Nota: Funciona apenas para jogadores que podem rastrear humanoides."
L["MinimapDetails"] = "Mostrar detalhes de level/classe nas dicas"
L["MinimapDetailsDescription"] = "Marque isso para atualizar as dicas do mapa para que o level e a classe sejam mostrados juntamente com o nome dos inimigos."
L["DisplayOnMap"] = "Exibir ícones no mapa"
L["DisplayOnMapDescription"] = "Exiba ícones de mapa para a localização de outros usuários do SPY em seu grupo, invasão e guilda quando detectar inimigos."
L["SwitchToZone"] = "Mudar para o mapa actual zona de detecção de inimigo"
L["SwitchToZoneDescription"] = "Mude o mapa para o mapa da zona atual do jogador quando inimigos forem detectados."
L["MapDisplayLimit"] = "Limitar icones mostrados no mapa para:"
L["LimitNone"] = "Todos os lugares"
L["LimitNoneDescription"] = "Mostrar no mapa todos os inimigos detectados independente da sua atual localização."
L["LimitSameZone"] = "Mesma Zona"
L["LimitSameZoneDescription"] = "Mostrar no mapa somente inimigos que estejam na mesma zona que você."
L["LimitSameContinent"] = "Mesmo Continente"
L["LimitSameContinentDescription"] = "Mostrar no mapa somente inimigos que estejam no mesmo continente que você."

-- Data Management
L["DataOptions"] = "Gerenciamento de Dados"
L["DataOptionsDescription"] = [[

Opções sobre como o Spy mantém e reúne dados.
]]
L["PurgeData"] = "Limpar dados de inimigos não detectados após:"
L["OneDay"] = "1 dia"
L["OneDayDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 1 dia."
L["FiveDays"] = "5 dias"
L["FiveDaysDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 5 dias dias."
L["TenDays"] = "10 dias"
L["TenDaysDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 10 dias."
L["ThirtyDays"] = "30 dias"
L["ThirtyDaysDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 30 dias."
L["SixtyDays"] = "60 dias"
L["SixtyDaysDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 60 dias."
L["NinetyDays"] = "90 dias"
L["NinetyDaysDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 90 dis."
L["PurgeKoS"] = "Purgar jogadores Lista Negra com base no tempo sem ser detectado."
L["PurgeKoSDescription"] = "Defina esta opção para purgar os jogadores da Lista Negra que foram não detectados com base nas configurações de tempo para os jogadores não detectados."
L["PurgeWinLossDate"] = "Eliminar dados win / perda com base no tempo sem ser detectado."
L["PurgeWinLossDateDescription"] = "Defina esta opção para limpar os dados win / perda de seu inimigo encontros com base nas configurações de tempo para os jogadores não detectados."
L["ShareData"] = "Compartilhar dados com outros usuários do Spy"
L["ShareDataDescription"] = "Marque isso para compartilhar os dados dos inimigos encontrados com outros usuários do Spy em seu grupo, raide e guilda."
L["UseData"] = "Usar dados de outros usuários do Spy"
L["UseDataDescription"] = "Marque isso para usar dados coletados por outros usuários do Spy em seu grupo, raide e guilda."
L["ShareKOSBetweenCharacters"] = "Compartilhar Lista Negra entre todos os seus personagens"
L["ShareKOSBetweenCharactersDescription"] = "Marque isso para que a Lista Negra seja compartilhada entre todos os seus personagens do mesmo reino e facção."

-- Commands
L["SlashCommand"] = "Slash Command"
L["SpySlashDescription"] = "Esses botões executam as mesmas funções que aquelas vistas no slash command /spy"
L["Enable"] = "Enable"
L["EnableDescription"] = "Permite que o Spy e mostra a janela principal."
L["Show"] = "Mostrar"
L["ShowDescription"] = "Mostra a janela principal."
L["Hide"] = "Esconder "
L["HideDescription"] = "Oculta a janela principal."
L["Reset"] = "Reset"
L["ResetDescription"] = "Reseta a posição e aparencia da janela principal."
L["ClearSlash"] = "Limpar"
L["ClearSlashDescription"] = "Limpa a lista de inimigos detectados."
L["Config"] = "Config"
L["ConfigDescription"] = "Abre a janela de configuração do Spy."
L["KOS"] = "Lista Negra"
L["KOSDescription"] = "Adicionar/remover jogadores na Lista Negra."
L["InvalidInput"] = "Entrada Inválida"
L["Ignore"] = "Ignore"
L["IgnoreDescription"] = "Adicionar/remover um jogador de/para a lista de ignorados."
L["Test"] = "Test"
L["TestDescription"] = "Exibe um aviso para que você possa reposicioná-lo."

-- Lists
L["Nearby"] = "Proximidades"
L["LastHour"] = "Ultima Hora"
L["Ignore"] = "Ignorados"
L["KillOnSight"] = "Lista Negra"

--Stats
L["Won"] = "Ganhou"
L["Lost"] = "Perdeu"
L["Time"] = "Tempo"	
L["List"] = "Lista"	
L["Filter"] = "Filtro"
L["Show Only"] = "Spenas Mostrar"
L["Realm"] = "Reino"
L["KOS"] = "Lista Negra"
L["Won/Lost"] = "Ganhou/Perdeu"
L["Reason"] = "Motivo"
L["HonorKills"] = "Honra Mata"
L["PvPDeaths"] = "Mortes JxJ"	

-- Output Messages
L["VersionCheck"] = "|cffc41e3a Atenção! A versão errada do Spy está instalada. Esta versão é para Wrath of the Lich King - Classic."
L["SpyEnabled"] = "|cff9933ffSpy addon ativado."
L["SpyDisabled"] = "|cff9933ffSpy addon desativado. Digite |cffffffff/spy show|cff9933ff para ativar."
L["UpgradeAvailable"] = "|cff9933ffA nova versão do Spy está disponivel. Baixe-o em:\n|cffffffffhttps://www.curseforge.com/wow/addons/spy-wotlk"
L["AlertStealthTitle"] = "Jogador invisivel detectado!"
L["AlertKOSTitle"] = "Jogador na Lista Negra detectado!"
L["AlertKOSGuildTitle"] = "Guildie de Lista Negra detectado!"
L["AlertTitle_kosaway"] = "Jogador na Lista Negra localizado por "
L["AlertTitle_kosguildaway"] = "Guildie de Lista Negra localizado por "
L["StealthWarning"] = "|cff9933ffJogador invisivel detectado: |cffffffff"
L["KOSWarning"] = "|cffff0000Jogador na Lista Negra detectado: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Guildie de Lista Negra detectado: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff[Spy] "
L["PlayerDetectedColored"] = "Jogador detectado: |cffffffff"
L["PlayersDetectedColored"] = "Jogadores detectados: |cffffffff"
L["KillOnSightDetectedColored"] = "Jogador na Lista Negra detectado: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Jogador adicionado à lista de Ignorados: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Jogador removido da lista de Ignorados: |cffffffff"
L["PlayerAddedToKOSColored"] = "Jogador adicionado à Lista Negra: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Jogador removido da Lista Negra: |cffffffff"
L["PlayerDetected"] = "[Spy] Jogador Detectado: "
L["KillOnSightDetected"] = "[Spy] Jogador na Lista Negra detectado: "
L["Level"] = "Level"
L["LastSeen"] = "Visto há"
L["LessThanOneMinuteAgo"] = "menos de um minuto"
L["MinutesAgo"] = "minutos atrás"
L["HoursAgo"] = "hóras atrás"
L["DaysAgo"] = "dias atrás"
L["Close"] = "Fechar"
L["CloseDescription"] = "|cffffffffEsconde a janela do Spy. Por defeito ela irá ser mostrada novamante quando um jogador inimigo for detectado."
L["Left/Right"] = "Direita/Esquerda"
L["Left/RightDescription"] = "|cffffffffNavega entre as listas de Proximidades, Ultima Hora, Ignorados e Lista Negra."
L["Clear"] = "Limpar"
L["ClearDescription"] = "|cffffffffLimpa a lista de inimigos detectados. Ctrl e click Inicia / Para  o Spy. Shift e Click liga / desliga todo o som."
L["SoundEnabled"] = "Alertas de áudio ativados"
L["SoundDisabled"] = "Alertas de áudio desativados"
L["NearbyCount"] = "Contador de Inimigos"
L["NearbyCountDescription"] = "|cffffffffContatdor de inimigos nas proximidades."
L["Statistics"] = "Estatística"
L["StatsDescription"] = "|cffffffffMostra uma lista de jogadores inimigos encontrados, registros de vitória / perda e onde eles foram vistos pela última vez"
L["AddToIgnoreList"] = "Adicionar à lista de Ignorados"
L["AddToKOSList"] = "Adicionar à Lista Negra"
L["RemoveFromIgnoreList"] = "Remover da lista de Ignorados"
L["RemoveFromKOSList"] = "Remover da Lista Negra"
L["RemoveFromStatsList"] = "Remover da Lista de Estatísticas"   --++
L["AnnounceDropDownMenu"] = "Anunciar"
L["KOSReasonDropDownMenu"] = "Determinar motivo de estar na Lista Negra"
L["PartyDropDownMenu"] = "Grupo"
L["RaidDropDownMenu"] = "Raide"
L["GuildDropDownMenu"] = "Guilda"
L["LocalDefenseDropDownMenu"] = "Defesa Local"
L["Player"] = " (Jogador)"
L["KOSReason"] = "Lista Negra"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Digite seu próprio motivo..."
L["KOSReasonClear"] = "Limpar motivo"
L["StatsWins"] = "|cff40ff00Vitórias: "
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070ddDerrotas: "
L["Located"] = "localizado:"
L["Yards"] = "jardas"
L["LocalDefenseChannelName"] = "DefesaLocal"

Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Iniciou combate";
		["content"] = {
			"Me atacou sem motivos",
			"Me atacou no recrutador", --++
			"Me atacou enquanto eu lutava com NPCs",
			"Me atacou enquanto eu estava perto de uma masmorra",
			"Me atacou quando eu estava LDT",
			"Me atacou enquanto eu estava montado/voando",
			"Me atacou enquanto eu tinha pouca vida/mana",
		};
	},
	[2] = {
		["title"] = "Estilo de Combate";
		["content"] = {
			"Me emboscou",
			"Ataca sempre que me vê",
			"Me matou com um personagem de nível superior", 
			"Me massacrou junto de vários inimigos",
			"Só ataca em bando",
			"Sempre pede ajuda",
			"Usa muito controle de multidão",
		};
	},
	[3] = {
		["title"] = "Campando";
		["content"] = {
			"Me campou",
			"Campou meu alt",
			"Campou low levels",
			"Campou ficando invisivel",
			"Campou membros da guilda",
			"Campou NPCs/Objetivos",
			"Campou Cidade/Local",
		};
	},
	[4] = {
		["title"] = "Quests";
		["content"] = {
			"Me atacou enquanto eu fazia quests",
			"Me atacou depois que eu ajudei ele com uma quest",
			"Interferiu com os objetivos da quest",
			"Iniciou uma quest que eu queria fazer",
			"Matou NPCs da minha facção",
			"Matou um NPC de quest",
		};
	},
	[5] = {
		["title"] = "Ladrão de recursos";
		["content"] = {
			"Colheu erva que eu queria",
			"Minerou minério que eu queria",
			"Pegou recursos que eu queria",
			"Me matou e roubou meu alvo/raro NPC",
			"Esfolou mobs que eu matei",
			"Resgatou os mobs que eu matei",
			"Pescou na minha lagoa",
		};
	},
	[6] = {
		["title"] = "Outros";
		["content"] = {
			"Ta com o JxJ ativado",
			"Me empurrou de um penhasco",
			"Usa truques de egenharia",
			"Sempre consegue escapar",
			"Usa itens e skills pra fugir",
 			"Burla as mecanicas do jogo",
			"Digite seu próprio motivo...",
		};
	},
}

StaticPopupDialogs["Spy_SetKOSReasonOther"] = {
	preferredIndex=STATICPOPUPS_NUMDIALOGS,  -- http://forums.wowace.com/showthread.php?p=320956
	text = "Motivos para colocar %s na Lista Negra:",
	button1 = "Pronto",
	button2 = "Cancelar",
	timeout = 20,
	hasEditBox = 1,
	editBoxWidth = 260,		
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
    OnAccept = function(self)
		local reason = self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Digite seu próprio motivo...", reason)
	end,
};

-- Class descriptions
L["UNKNOWN"] = "Desconhecido"
L["DRUID"] = "Druida"
L["HUNTER"] = "Caçador"
L["MAGE"] = "Mago"
L["PALADIN"] = "Paladino"
L["PRIEST"] = "Sacerdote"
L["ROGUE"] = "Ladino"
L["SHAMAN"] = "Xamã"
L["WARLOCK"] = "Bruxo"
L["WARRIOR"] = "Guerreiro"
L["DEATHKNIGHT"] = "Cavaleiro da Morte"
L["MONK"] = "Monge"
L["DEMONHUNTER"] = "Caçador de Demonios"
L["EVOKER"] = "Conjurante"

--++ Race descriptions
L["Human"] = "Humano"
L["Orc"] = "Orc"
L["Dwarf"] = "Anão"
L["Tauren"] = "Tauren"
L["Troll"] = "Troll"
L["Night Elf"] = "Elfo Noturno"
L["Undead"] = "Morto-vivo"
L["Gnome"] = "Gnomo"
L["Blood Elf"] = "Elfo Sangrento"
L["Draenei"] = "Draenei"
L["Goblin"] = "Goblin"
L["Worgen"] = "Worgen"
L["Pandaren"] = "Pandaren"
L["Highmountain Tauren"] = "Tauren Altamontês"
L["Lightforged Draenei"] = "Draenei Forjado a Luz"
L["Nightborne"] = "Filho da Noite"
L["Void Elf"] = "Void Elf"	
L["Dark Iron Dwarf"] = "Anão Ferro Negro"
L["Mag'har Orc"] = "Orc Mag'har"
L["Kul Tiran"] = "Kultireno"
L["Zandalari Troll"] = "Troll Zandalari"
L["Mechagnome"] = "Gnomecânico"
L["Vulpera"] = "Vulpera"
L["Dracthyr"] = "Dracthyr"

-- Stealth abilities
L["Stealth"] = "Furtividade"
L["Prowl"] = "Espreitar"

-- Minimap color codes
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
	["Caixa de Correio"]=true, ["Retalhomestre 1.0"]=true, ["Sucatomático 1000"]=true,
	["Boat to Stormwind City"]=true, ["Boat to Boralus Harbor, Tiragarde Sound"]=true,
	["Baú do Tesouro"]=true, ["Baú do Tesouro Pequeno"]=true,
	["Mordida-de-akunda"]=true, ["Erva-ancorina"]=true, ["Broto-do-rio"]=true,    
	["Talo-marinho"]=true, ["Pólen de Sirena"]=true, ["Musgo-estrela"]=true,   
	["Beijo-do-inverno"]=true,	["War Headquarters (PvP)"]=true,
	["Assassino da Aliança"]=true, ["Assassino da Horda"]=true,	
	["Chapéu de Pássaro Místico"]=true, ["Primo Mãomole"]=true,		
	["Azerita para a Aliança"]=true, ["Azerita para a Horda"]=true,	
};