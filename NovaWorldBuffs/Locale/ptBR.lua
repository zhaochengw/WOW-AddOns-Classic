local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "ptBR");
if (not L) then
	return;
end

--Spanish translations by Cruzluz.

--Rend buff aura name.
L["Warchief's Blessing"] = "Bênção do Chefe Guerreiro";
--Onyxia and Nefarian buff aura name.
L["Rallying Cry of the Dragonslayer"] = "Brado Empolgante do Mata-dragões";
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = "Serenata Flor da Canção";
L["Songflower"] = "Flor da Canção";

L["Flask of Supreme Power"] = "Frasco de Poder Supremo";
L["Flask of the Titans"] = "Frasco dos Titãs";
L["Flask of Distilled Wisdom"] = "Frasco de Sabedoria Destilada";
L["Flask of Chromatic Resistance"] = "Frasco de Resistência Cromática";
--3 of the flasks spells seem to be named differently than the flask item, but titan is exact same name as the flask item.
L["Supreme Power"] = "Poder Supremo";
L["Distilled Wisdom"] = "Sabedoria Destilada";
L["Chromatic Resistance"] = "Resistência Cromática";
L["Sap"] = "Aturdir";
L["Fire Festival Fortitude"] = "Fortitude do Festival do Fogo";
L["Fire Festival Fury"] = "Fúria do Festival do Fogo";
L["Ribbon Dance"] = "Dança da Fita";
L["Traces of Silithyst"] = "Traços de Silitista";
L["Slip'kik's Savvy"] = "Malandragem do Kishutt";
L["Fengus' Ferocity"] = "Ferocidade de Fengus";
L["Mol'dar's Moxie"] = "Valentia do Mol'dar";

---=====---
---Horde---
---=====---

--Horde Orgrimmar Rend buff NPC.
L["Thrall"] = "Thrall";
--Horde The Barrens Rend buff NPC.
L["Herald of Thrall"] = "Arauto de Thrall";
--Horde rend buff NPC first yell string (part of his first yell msg before before buff).
L["Rend Blackhand, has fallen"] = "O falso Chefe Guerreiro, Laceral Mão Negra, caiu!";
--Horde rend buff NPC second yell string (part of his second yell msg before before buff).
--L["Be bathed in my power"] = "";

--Horde Onyxia buff NPC.
L["Overlord Runthak"] = "Lorde Supremo Runthak";
--Horde Onyxia buff NPC first yell string (part of his first yell msg before before buff).
--L["Onyxia, has been slain"] = "";
--Horde Onyxia buff NPC second yell string (part of his second yell msg before before buff).
--L["Be lifted by the rallying cry"] = "";

--Horde Nefarian buff NPC.
L["High Overlord Saurfang"] = "Lorde Supremo Saurfang";
--Horde Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["NEFARIAN IS SLAIN"] = "NEFARIAN ESTÁ MORTO!";
--Horde Nefarian buff NPC second yell string (part of his second yell msg before before buff).
--L["Revel in his rallying cry"] = "";

---========---
---Alliance---
---========---

--Alliance Onyxia buff NPC.
L["Major Mattingly"] = "Major Valadão";
--Alliance Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["history has been made"] = "fez-se história";
--Alliance Onyxia buff NPC second yell string (part of his second yell msg before before buff).
--L["Onyxia, hangs from the arches"] = "";


--Alliance Nefarian buff NPC.
L["Field Marshal Afrasiabi"] = "Marechal-de-campo Afrasiabi";
L["Field Marshal Stonebridge"] = "Marechal-de-campo Pontepedra";
--Alliance Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["the Lord of Blackrock is slain"] = "o Senhor da Rocha Negra foi derrubado";
--Alliance Nefarian buff NPC second yell string (part of his second yell msg before before buff).
--L["Revel in the rallying cry"] = "";

---===========----
---NPC's killed---
---============---
L["onyxiaNpcKilledHorde"] = "Lorde Supremo Runthak acabou de ser morto (NPC de bônus da Onyxia).";
L["onyxiaNpcKilledAlliance"] = "Major Valadão acabou de ser morto (NPC de bônus da Onyxia).";
L["nefarianNpcKilledHorde"] = "Lorde Supremo Saurfang acabou de ser morto (NPC de bônus do Nefarian).";
L["nefarianNpcKilledAlliance"] = "Marechal-de-campo Afrasiabi acabou de ser morto (NPC de bônus do Nefarian).";
L["onyxiaNpcKilledHordeWithTimer"] = "O NPC de Onyxia (Runthak) foi morto há %s e nenhum bônus foi registrado desde então.";
L["nefarianNpcKilledHordeWithTimer"] = "O NPC de Nefarian (Saurfang) foi morto há %s e nenhum bônus foi registrado desde então.";
L["onyxiaNpcKilledAllianceWithTimer"] = "O NPC de Onyxia (Valadão) foi morto há %s e nenhum bônus foi registrado desde então.";
L["nefarianNpcKilledAllianceWithTimer"] = "O NPC de Nefarian (Afrasiabi) foi morto há %s e nenhum bônus foi registrado desde então.";
L["anyNpcKilledWithTimer"] = "NPC foi morto há %s"; --Map timers tooltip msg.


---==============---
---Darkmoon Faire---
---==============---

L["Darkmoon Faire"] = "Feira de Negraluna";
L["Sayge's Dark Fortune of Agility"] = "Previsão Sombria de Agilidade do Malaby";
L["Sayge's Dark Fortune of Intelligence"] = "Previsão Sombria do Malaby de Inteligência";
L["Sayge's Dark Fortune of Spirit"] = "Previsão Sombria do Malaby de Espírito";
L["Sayge's Dark Fortune of Stamina"] = "Previsão Sombria do Malaby de Vigor";
L["Sayge's Dark Fortune of Strength"] = "Previsão Sombria do Malaby de Força";
L["Sayge's Dark Fortune of Armor"] = "Previsão Sombria do Malaby de Armadura";
L["Sayge's Dark Fortune of Resistance"] = "Previsão Sombria do Malaby de Resistência";
L["Sayge's Dark Fortune of Damage"] = "Previsão Sombria do Malaby de Dano";
L["dmfBuffCooldownMsg"] = "Você tem %s restante no tempo de recarga do bônus da Feira de Negraluna.";
L["dmfBuffCooldownMsg2"] = "Você tem %s restante no tempo de recarga do bônus da Feira de Negraluna."; --/wb frame.
L["dmfBuffCooldownMsg3"] = "O tempo de recarga do bônus da Feira de Negraluna também é reiniciado com o reinício semanal do servidor."; --/wb frame 2nd msg.
L["dmfBuffReady"] = "Seu bônus da Feira de Negraluna está fora do tempo de recarga."; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffReset"] = "O tempo de recarga do seu bônus da Feira de Negraluna foi redefinido."; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffDropped"] = "O bônus %s da Feira de Negraluna foi recebido. Para acompanhar o tempo de recarga de 4 horas dentro do jogo para este bônus, digite /buffs.";
L["dmfSpawns"] = "A Feira de Negraluna aparecerá em %s (%s)";
L["dmfEnds"] = "A Feira de Negraluna terminará em %s (%s)";
L["mulgore"] = "Mulgore";
L["elwynnForest"] = "Floresta de Elwynn";


---==============---
---Output Strings---
---==============---

L["rend"] = "Laceral"; --Rend Blackhand
L["onyxia"] = "Onyxia"; --Onyxia
L["nefarian"] = "Nefarian"; --Nefarian
L["dmf"] = "Feira de Negraluna"; --Darkmoon Faire
L["noTimer"] = "Sem temporizador"; --No timer
L["noCurrentTimer"] = "Não há temporizador atual"; --No current timer
L["noActiveTimers"] = "Sem temporizadores ativos"; --No active timers
L["newBuffCanBeDropped"] = "Agora é possível obter um novo bônus de %s";
L["buffResetsIn"] = "%s será redefinido em %s";
L["rendFirstYellMsg"] = "Laceral cairá em 6 segundos.";
L["onyxiaFirstYellMsg"] = "Onyxia cairá em 14 segundos.";
L["nefarianFirstYellMsg"] = "Nefarian cairá em 15 segundos.";
L["rendBuffDropped"] = "Bênção do Chefe Guerreiro (Laceral) foi recebida.";
L["onyxiaBuffDropped"] = "Brado Empolgante do Mata-dragões (Onyxia) foi recebido.";
L["nefarianBuffDropped"] = "Brado Empolgante do Mata-dragões (Nefarian) foi recebido.";
L["newSongflowerReceived"] = "Um novo temporizador de Flor da Canção foi recebido."; --New songflower timer received
L["songflowerPicked"] = "Flor da Canção foi coletado em %s, a próxima aparição será em 25 minutos."; -- Guild msg when songflower picked.
L["North Felpaw Village"] = "Ao norte da Aldeia Patavil";
L["West Felpaw Village"] = "Ao oeste da Aldeia Patavil";
L["North of Irontree Woods"] = "Ao norte da Floresta Ferrárbol";
L["Talonbranch Glade"] = "Clareira da Galhaça";
L["Shatter Scar Vale"] = "Vale das Escaras Pungentes";
L["Bloodvenom Post"] = "Posto Peçonha";
L["East of Jaedenar"] = "Ao leste de Jaedenar";
L["North of Emerald Sanctuary"] = "Ao norte do Santuário Esmeralda";
L["West of Emerald Sanctuary"] = "Ao oeste do Santuário Esmeralda";
L["South of Emerald Sanctuary"] = "Ao sul do Santuário Esmeralda";
L["second"] = "segundo"; --Second (singular).
L["seconds"] = "segundos"; --Seconds (plural).
L["minute"] = "minuto"; --Minute (singular).
L["minutes"] = "minutos"; --Minutes (plural).
L["hour"] = "hora"; --Hour (singular).
L["hours"] = "horas"; --Hours (plural).
L["day"] = "dia"; --Day (singular).
L["days"] = "dias"; --Days (plural).
L["secondMedium"] = "seg"; --Second (singular).
L["secondsMedium"] = "seg"; --Seconds (plural).
L["minuteMedium"] = "min"; --Minute (singular).
L["minutesMedium"] = "min"; --Minutes (plural).
L["hourMedium"] = "hora"; --Hour (singular).
L["hoursMedium"] = "horas"; --Hours (plural).
L["dayMedium"] = "dia"; --Day (singular).
L["daysMedium"] = "dias"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "d"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Começará em %s"; --"Starts in 1hour".
L["endsIn"] = "Terminará em %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "O Nova World Buffs está desatualizado, atualize em https://www.curseforge.com/wow/addons/nova-world-buffs";
L["Your Current World Buffs"] = "Seus bônus mundiais atuais";
L["Options"] = "Opções";


--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "Iniciem o ritual"
L["The Blood God"] = "O Deus Sanguinário"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
--L["slayer of Hakkar"] = "slayer of Hakkar";

L["Spirit of Zandalar"] = "Espírito de Zandalar";
L["Molthor"] = "Molthor";
L["Zandalarian Emissary"] = "Emissário Zandalariano";
L["Whipper Root Tuber"] = "Tubérculo de Raiz-açoite";
L["Night Dragon's Breath"] = "Sopro de Dragão Noturno";
L["Resist Fire"] = "Resistir ao Fogo"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "Bênção das Profundezas Negras";

L["zan"] = "Zandalar";
L["zanFirstYellMsg"] = "Zandalar cairá em %s segundos.";
L["zanBuffDropped"] = "Espírito de Zandalar (Hakkar) foi recebido.";
L["singleSongflowerMsg"] = "Flor da Canção em %s aparecerá em %s.";  -- Songflower at Bloodvenom Post spawns at 1pm.
L["spawn"] = "Aparição"; --Used in Felwood map marker tooltip (03:46pm spawn).
L["Irontree Woods"] = "Floresta Ferrárbol";
L["West of Irontree Woods"] = "Ao oeste da Floresta Ferrárbol";
L["Bloodvenom Falls"] = "Salto da Peçonha";

L["Jaedenar"] = "Jaedenar";
L["North-West of Irontree Woods"] = "Al noroeste del Bosque de Troncoferro";
L["South of Irontree Woods"] = "Al sur del Bosque de Troncoferro";

L["worldMapBuffsMsg"] = "Digite /buffs para ver todos os\nbônus de mundo atuais dos seus personagens.";
L["cityMapLayerMsgHorde"] = "Atualmente em %s\nAponte para um NPC\npara atualizar sua camada após mudar de zona.|r";
L["cityMapLayerMsgAlliance"] = "Atualmente em %s\nAponte para qualquer NPC\npara atualizar sua camada após mudar de zona.|r";
L["noLayerYetHorde"] = "Aponte para qualquer NPC\npara encontrar sua camada atual.";
L["noLayerYetAlliance"] = "Aponte para qualquer NPC\npara encontrar sua camada atual.";
L["Reset Data"] = "Redefinir Dados"; --A button to Reset buffs window data.


L["layerFrameMsgOne"] = "As camadas antigas persistirão por algumas horas após o reinício do servidor."; --Msg at bottom of layer timers frame.
L["layerFrameMsgTwo"] = "As camadas desaparecerão aqui após 6 horas sem temporizadores."; --Msg at bottom of layer timers frame.
L["You are currently on"] = "Atualmente você está em"; --You are currently on [Layer 2]


-------------
---Config---
-------------
--There are 2 types of strings here, the names end in Title or Desc L["exampleTitle"] and L["exampleDesc"].
--Title must not be any longer than 21 characters (maybe less for chinese characters because they are larger).
--Desc can be any length.

---Description at the top---
L["mainTextDesc"] = "Digite /wb para mostrar os temporizadores.\nDigite /wb <canal> para mostrar os temporizadores do canal especificado.\nRole para baixo para ver mais opções.";


---Show Buffs Button
L["showBuffsTitle"] = "Bônus atuais";
L["showBuffsDesc"] = "Mostra os seus bônus de mundo atuais para todos os seus personagens; isso também pode ser aberto digitando /buffs ou clicando no prefixo [WorldBuffs] no bate-papo.";


---General Options---
L["generalHeaderDesc"] = "Opções gerais";

L["showWorldMapMarkersTitle"] = "Marcadores do mapa";
L["showWorldMapMarkersDesc"] = "Mostra ícones de temporizador no mapa-múndi de Orgrimmar/Ventobravo?";

L["receiveGuildDataOnlyTitle"] = "Dados da guilda";
L["receiveGuildDataOnlyDesc"] = "Isso fará com que você só receba dados de temporizador de membros da sua guilda. Ativa isso apenas se você suspeitar que alguém está fornecendo intencionalmente dados de temporizador incorretos, pois reduzirá a precisão dos seus temporizadores ao ter menos pessoas de quem extrair dados. Será especialmente difícil obter temporizadores de Flor da Canção porque são muito curtos. Cada pessoa na guilda precisa ter isso ativado para funcionar.";

L["chatColorTitle"] = "Cor do bate-papo";
L["chatColorDesc"] = "De que cor deve ser a mensagem do temporizador no bate-papo?";

L["middleColorTitle"] = "Cor do meio da tela";
L["middleColorDesc"] = "De que cor deve ser a mensagem de aviso do meio da tela?";

L["resetColorsTitle"] = "Redefinir cores";
L["resetColorsDesc"] = "Redefine as cores para os valores padrão.";

L["showTimeStampTitle"] = "Carimbo de tempo";
L["showTimeStampDesc"] = "Mostra um carimbo de tempo (1:23 p.m.) ao lado da mensagem do temporizador?";

L["timeStampFormatTitle"] = "Formato do carimbo de tempo";
L["timeStampFormatDesc"] = "Define qual formato de carimbo de tempo usar, 12 horas (1:23 p.m.) ou 24 horas (13:23).";

L["timeStampZoneTitle"] = "Horário local / Hora do reino";
L["timeStampZoneDesc"] = "Usa horário local ou horário do reino para os carimbos de tempo?";

L["colorizePrefixLinksTitle"] = "Link colorido";
L["colorizePrefixLinksDesc"] = "Colore o prefixo [WorldBuffs] em todos os canais de bate-papo? Este é o prefixo no bate-papo no qual você pode clicar para mostrar a todos os seus personagens os bônus mundiais atuais.";

L["showAllAltsTitle"] = "Mostrar todos os alts";
L["showAllAltsDesc"] = "Mostra todos os alts na janela mesmo se eles não tiverem um bônus ativo?";

L["minimapButtonTitle"] = "Botão do minimapa";
L["minimapButtonDesc"] = "Mostra o botão NWB no minimapa?";

---Logon Messages---
L["logonHeaderDesc"] = "Mensagens de conexão";

L["logonPrintTitle"] = "Temporizadores";
L["logonPrintDesc"] = "Mostra temporizadores na janela de bate-papo quando você se conectar; você pode desativar todas as mensagens de logon com essa configuração.";

L["logonRendTitle"] = "Laceral";
L["logonRendDesc"] = "Mostra o temporizador de Laceral na janela de bate-papo quando você se conectar.";

L["logonOnyTitle"] = "Onyxia";
L["logonOnyDesc"] = "Mostra o temporizador de Onyxia na janela de bate-papo quando você se conectar.";

L["logonNefTitle"] = "Nefarian";
L["logonNefDesc"] = "Mostra o temporizador de Nefarian na janela de bate-papo quando você se conectar.";

L["logonDmfSpawnTitle"] = "Aparição da feira";
L["logonDmfSpawnDesc"] = "Mostra o tempo de aparecimento da Feira de Negraluna; isso só será mostrado quando faltar menos de 6 horas para aparecer ou desaparecer.";

L["logonDmfBuffCooldownTitle"] = "Recarga da feira";
L["logonDmfBuffCooldownDesc"] = "Mostra o tempo de recarga de 4 horas do bônus da Feira de Negraluna, isso só será mostrado quando você tiver um tempo de recarga ativo e quando a Feira de Negraluna estiver ativa."; 


---Chat Window Timer Warnings---
L["chatWarningHeaderDesc"] = "Anúncios do temporizador na janela de bate-papo";

L["chat30Title"] = "30 minutos";
L["chat30Desc"] = "Imprime uma mensagem no bate-papo quando faltar 30 minutos.";

L["chat15Title"] = "15 minutos";
L["chat15Desc"] = "Imprime uma mensagem no bate-papo quando faltar 15 minutos.";

L["chat10Title"] = "10 minutos";
L["chat10Desc"] = "Imprime uma mensagem no bate-papo quando faltar 10 minutos.";

L["chat5Title"] = "5 minutos";
L["chat5Desc"] = "Imprime uma mensagem no bate-papo quando faltar 5 minutos.";

L["chat1Title"] = "1 minuto";
L["chat1Desc"] = "Imprime uma mensagem no bate-papo quando faltar 1 minuto.";

L["chatResetTitle"] = "Bônus restabelecido";
L["chatResetDesc"] = "Imprime uma mensagem no bate-papo quando um bônus for restabelecido.";

L["chatZanTitle"] = "Bônus Zandalar";
L["chatZanDesc"] = "Imprime uma mensagem no bate-papo 30 segundos antes do início do bônus de Zandalar quando o NPC começar a gritar.";


---Middle Of The Screen Timer Warnings---
L["middleWarningHeaderDesc"] = "Anúncios do temporizador no meio da tela";

L["middle30Title"] = "30 minutos";
L["middle30Desc"] = "Mostra uma mensagem de estilo de aviso de raide no meio da tela quando faltar 30 minutos.";

L["middle15Title"] = "15 minutos";
L["middle15Desc"] = "Mostra uma mensagem de estilo de aviso de raide no meio da tela quando faltar 15 minutos.";

L["middle10Title"] = "10 minutos";
L["middle10Desc"] = "Mostra uma mensagem de estilo de aviso de raide no meio da tela quando faltar 10 minutos.";

L["middle5Title"] = "5 minutos";
L["middle5Desc"] = "Mostra uma mensagem de estilo de aviso de raide no meio da tela quando faltar 5 minutos.";

L["middle1Title"] = "1 minuto";
L["middle1Desc"] = "Mostra uma mensagem de estilo de aviso de raide no meio da tela quando faltar 1 minuto.";

L["middleResetTitle"] = "Bônus restabelecido";
L["middleResetDesc"] = "Mostra uma mensagem de estilo de aviso de raide no meio da tela quando um bônus for restabelecido.";

L["middleBuffWarningTitle"] = "Anúncio de bônus";
L["middleBuffWarningDesc"] = "Mostra uma mensagem de estilo de aviso de raide no meio da tela quando alguém entregar a cabeça e o NPC gritar alguns segundos antes do início do bônus.";

L["middleHideCombatTitle"] = "Ocultar em combate";
L["middleHideCombatDesc"] = "Oculta os anúncios no meio da tela durante o combate?";

L["middleHideRaidTitle"] = "Ocultar em raide";
L["middleHideRaidDesc"] = "Oculta os anúncios no meio da tela em raides? (Não se oculta em masmorras)";

---Guild Messages---
L["guildWarningHeaderDesc"] = "Mensagens da guilda";

L["guild10Title"] = "10 minutos";
L["guild10Desc"] = "Envia uma mensagem no bate-papo da guilda quando faltar 10 minutos.";

L["guild1Title"] = "1 minuto";
L["guild1Desc"] = "Envia uma mensagem no bate-papo da guilda quando faltar 1 minuto.";

L["guildNpcDialogueTitle"] = "Diálogo iniciado";
L["guildNpcDialogueDesc"] = "Envia uma mensagem para a guilda quando alguém entregar uma cabeça e o NPC gritar primeiro e ainda tiver tempo para fazer login rápido?";

L["guildBuffDroppedTitle"] = "Novo bônus";
L["guildBuffDroppedDesc"] = "Envia uma mensagem para a guilda quando um novo bônus for iniciado? Esta mensagem é enviada depois que o NPC termina de gritar e você obtém o bônus real alguns segundos depois. (6 segundos após o primeiro grito para Laceral, 14 segundos para Onyxia, 15 segundos para Nefarian)";

L["guildZanDialogueTitle"] = "Bônus Zandalar";
L["guildZanDialogueDesc"] = "Envia uma mensagem para a guilda quando o bônus do Espírito de Zandalar estiver prestes a começar? (Se você não quiser nenhuma mensagem de guilda para este bônus, então todos na guilda devem desativá-lo).";

L["guildNpcKilledTitle"] = "NPC morto";
L["guildNpcKilledDesc"] = "Envia uma mensagem para a guilda quando um dos NPCs é morto em Orgrimmar ou Ventobravo? (redefinição do controle mental).";

L["guildCommandTitle"] = "Comandos";
L["guildCommandDesc"] = "Responde com informações do temporizador aos comandos !wb e !dmf no bate-papo da guilda? Provavelmente, você deveria deixar isso ativado para ajudar sua guilda, se você realmente quiser desativar todas as mensagens da guilda e deixar apenas este comando, então desmarque tudo o mais na seção da guilda e não marque Ativar todas as mensagens da guilda na parte superior.";

L["disableAllGuildMsgsTitle"] = "Desativar";
L["disableAllGuildMsgsDesc"] = "Desativa todas as mensagens da guilda, incluindo temporizadores e quando os bônus caem? Nota: Você pode desativar todas as mensagens uma por uma acima e simplesmente deixar certas coisas ativadas para ajudar sua guilda, se preferir.";


---Songflowers---
L["songflowersHeaderDesc"] = "Flor da Canção";

L["guildSongflowerTitle"] = "Guilda";
L["guildSongflowerDesc"] = "Informe sua guilda quando você coletar uma Flor da Canção?";

L["mySongflowerOnlyTitle"] = "Coletar";
L["mySongflowerOnlyDesc"] = "Grava um novo temporizador apenas quando eu coletar uma Flor da Canção e não quando outros coletarem na minha frente? Esta opção está aqui caso você tenha problemas com temporizadores falsos configurados por outros jogadores. Atualmente, não há como saber se o bônus de outro jogador é novo, então um temporizador pode ser ativado em raras ocasiões se o jogo carregar o bônus da Flor da Canção em outra pessoa quando você fizer login na frente deles junto com uma Flor da Canção.";

L["syncFlowersAllTitle"] = "Sincronizar";
L["syncFlowersAllDesc"] = "Ativa isso para substituir a configuração de dados apenas de guilda na parte superior desta configuração, para que você possa compartilhar dados de Flor da Canção fora da guilda, mas manter apenas os dados da guilda para bônus mundiais.";

L["showNewFlowerTitle"] = "Novas flores";
L["showNewFlowerDesc"] = "Isso mostrará no bate-papo quando um novo temporizador de Flor da Canção for encontrado por outro jogador que não está em sua guilda (as mensagens de guilda já são mostradas no bate-papo da guilda quando uma Flor da Canção é coletada).";

L["showSongflowerWorldmapMarkersTitle"] = "Mapa de Flor da Canção";
L["showSongflowerWorldmapMarkersDesc"] = "Mostra ícones de Flor da Canção no mapa-múndi?";

L["showSongflowerMinimapMarkersTitle"] = "Minimapa de Flor da Canção";
L["showSongflowerMinimapMarkersDesc"] = "Mostra ícones de Flor da Canção no minimapa?";

L["showTuberWorldmapMarkersTitle"] = "Mapa de Tubérculo";
L["showTuberWorldmapMarkersDesc"] = "Mostra ícones de Tubérculo no mapa-múndi?";

L["showTuberMinimapMarkersTitle"] = "Minimapa de Tubérculo";
L["showTuberMinimapMarkersDesc"] = "Mostra ícones de Tubérculo no minimapa?";

L["showDragonWorldmapMarkersTitle"] = "Mapa de Sopro de Dragão";
L["showDragonWorldmapMarkersDesc"] = "Mostra ícones de Sopro de Dragão Noturno no mapa-múndi?";

L["showDragonMinimapMarkersTitle"] = "Minimapa de Sopro de Dragão";
L["showDragonMinimapMarkersDesc"] = "Mostra ícones de Sopro de Dragão Noturno no minimapa?";

L["showExpiredTimersTitle"] = "Expirado";
L["showExpiredTimersDesc"] = "Mostra temporizadores expirados em Selva Maleva? Eles serão exibidos em texto vermelho indicando quanto tempo o temporizador está expirado. O tempo padrão é de 5 minutos (algumas pessoas dizem que as Flor da Canção permanecem limpas por 5 minutos após a aparição?).";

L["expiredTimersDurationTitle"] = "Duração";
L["expiredTimersDurationDesc"] = "Por quanto tempo os temporizadores de Selva Maleva devem ser mostrados após expirarem no mapa-múndi?";


---Darkmoon Faire---
L["dmfHeaderDesc"] = "Feira de Negaluna";

L["dmfTextDesc"] = "O tempo de recarga do bônus de dano da Feira de Negaluna também será exibido no ícone do mapa da Feira de Negaluna quando você passar o mouse sobre ele, se você tiver um tempo de recarga e a Feira estiver atualmente ativa.";

L["showDmfWbTitle"] = "Mostrar Feira com /wb";
L["showDmfWbDesc"] = "Mostra o temporizador de aparência da Feira de Negaluna junto com o comando /wb?";

L["showDmfBuffWbTitle"] = "Recarga /wb";
L["showDmfBuffWbDesc"] = "Mostra o temporizador de recarga do bônus da Feira de Negaluna junto com o comando /wb? Apenas é mostrado quando você está em recarga ativa e a Feira está atualmente ativa.";

L["showDmfMapTitle"] = "Marcador do mapa";
L["showDmfMapDesc"] = "Mostra o marcador do mapa da Feira com temporizador de aparência e informações de recarga de bônus nos mapas de Mulgore e Floresta de Elwynn (o que vem a seguir). Você também pode digitar /dmf map para abrir o mapa para este marcador.";


---Guild Chat Filter---
L["guildChatFilterHeaderDesc"] = "Filtro do bate-papo da guilda";

L["guildChatFilterTextDesc"] = "Isso bloqueará qualquer mensagem da guilda deste addon que você escolher para que não as veja. Isso evitará que você veja suas próprias mensagens e as mensagens de outros usuários do addon no bate-papo da guilda.";

L["filterYellsTitle"] = "Anúncio";
L["filterYellsDesc"] = "Filtra a mensagem quando um bônus está prestes a cair em alguns segundos (Onyxia cairá em 14 segundos).";

L["filterDropsTitle"] = "Bônus caiu";
L["filterDropsDesc"] = "Filtra a mensagem quando um bônus é obtido (Brado Empolgante do Mata-dragões (Onyxia) caiu).";

L["filterTimersTitle"] = "Temporizador";
L["filterTimersDesc"] = "Filtra mensagens do temporizador (Onyxia se reinicia em 1 minuto).";

L["filterCommandTitle"] = "Comando !wb";
L["filterCommandDesc"] = "Filtra !wb e !dmf no bate-papo da guilda quando os jogadores escrevem.";

L["filterCommandResponseTitle"] = "Resposta !wb";
L["filterCommandResponseDesc"] = "Filtra a mensagem de resposta com temporizadores que este addon faz quando !wb ou !dmf é usado.";

L["filterSongflowersTitle"] = "Flor da Canção";
L["filterSongflowersDesc"] = "Filtra a mensagem quando uma Flor da Canção é coletada.";

L["filterNpcKilledTitle"] = "NPC morto";
L["filterNpcKilledDesc"] = "Filtra a mensagem quando um NPC é morto em sua cidade.";


---Sounds---
L["soundsHeaderDesc"] = "Sons";

L["soundsTextDesc"] = "Defina o som como \"Nenhum\" para desativá-lo.";

L["disableAllSoundsTitle"] = "Desativar os sons";
L["disableAllSoundsDesc"] = "Desativa todos os sons deste addon.";

L["extraSoundOptionsTitle"] = "Opções de som";
L["extraSoundOptionsDesc"] = "Ativa isso para mostrar todos os sons de todos os seus addons de uma vez nas listas suspensas aqui.";

L["soundOnlyInCityTitle"] = "Apenas na cidade";
L["soundOnlyInCityDesc"] = "Reproduz sons de bônus apenas quando estiver na cidade principal onde os bônus caem (Ravenholdt incluído para o bônus de Zandalar).";

L["soundsDisableInInstancesTitle"] = "Masmorras";
L["soundsDisableInInstancesDesc"] = "Desativa os sons enquanto estiver em raides ou masmorras.";

L["soundsFirstYellTitle"] = "Bônus chegando";
L["soundsFirstYellDesc"] = "Toca quando a cabeça é entregue e você tem alguns segundos antes que o bônus comece (primeiro grito do NPC).";

L["soundsOneMinuteTitle"] = "Anúncio de um minuto";
L["soundsOneMinuteDesc"] = "Um som será reproduzido durante o anúncio do temporizador restante de 1 minuto.";

L["soundsRendDropTitle"] = "Bônus de Laceral";
L["soundsRendDropDesc"] = "Som a ser reproduzido para Laceral quando você obtém o bônus.";

L["soundsOnyDropTitle"] = "Bônus de Onyxia";
L["soundsOnyDropDesc"] = "Som a ser reproduzido para Onyxia quando você obtém o bônus.";

L["soundsNefDropTitle"] = "Bônus de Nefarian";
L["soundsNefDropDesc"] = "Som a ser reproduzido para Nefarian quando você obtém o bônus.";

L["soundsZanDropTitle"] = "Bônus de Zandalar";
L["soundsZanDropDesc"] = "Som a ser reproduzido para Zandalar quando você obtém o bônus.";


---Flash When Minimized---
L["flashHeaderDesc"] = "Piscar quando minimizado";

L["flashOneMinTitle"] = "Um minuto";
L["flashOneMinDesc"] = "Pisca o cliente do WoW quando está minimizado e resta 1 minuto no temporizador?";

L["flashFirstYellTitle"] = "Grito do NPC";
L["flashFirstYellDesc"] = "Pisca o cliente do WoW quando está minimizado e o NPC grita alguns segundos antes de cair o bônus?";

L["flashFirstYellZanTitle"] = "Zandalar";
L["flashFirstYellZanDesc"] = "Pisca o cliente do WoW quando está minimizado e o bônus de Zandalar está prestes a cair?";

---Faction/realm specific options---

L["allianceEnableRendTitle"] = "Laceral para Aliança";
L["allianceEnableRendDesc"] = "Ativa isso para rastrear o Laceral como Aliança, para que as guildas com controle mental obtenham um bônus de Laceral. Se você usar isso, então todos na guilda com o addon devem ativá-lo ou as mensagens de bate-papo da guilda podem não funcionar corretamente (as mensagens do temporizador pessoal ainda funcionarão).";

L["minimapLayerFrameTitle"] = "Camada no minimapa";
L["minimapLayerFrameDesc"] = "Mostra o quadro no minimapa com sua camada atual?";

L["minimapLayerFrameResetTitle"] = "Redefinir minimapa";
L["minimapLayerFrameResetDesc"] = "Redefine o quadro da camada do minimapa para a posição padrão (mantenha pressionada a tecla Shift para arrastar o quadro do minimapa).";


---Dispels---
L["dispelsHeaderDesc"] = "Dissipações";

L["dispelsMineTitle"] = "Meus bônus";
L["dispelsMineDesc"] = "Mostra no bate-papo quando meus bônus estão sendo dissipados? Isso mostra quem dissipou você e qual bônus.";

L["dispelsMineWBOnlyTitle"] = "Apenas bônus mundial";
L["dispelsMineWBOnlyDesc"] = "Mostra apenas que meus bônus mundiais estão sendo dissipados e nenhum outro tipo de bônus.";

L["soundsDispelsMineTitle"] = "Som";
L["soundsDispelsMineDesc"] = "Qual som reproduzir quando meus bônus são dissipados.";

L["dispelsAllTitle"] = "Bônus de outros";
L["dispelsAllDesc"] = "Mostra no bate-papo os bônus de todos que estão sendo dissipados ao seu redor? Isso mostra quem dissipou alguém próximo a você e qual bônus.";

L["dispelsAllWBOnlyTitle"] = "Bônus mundial de outros";
L["dispelsAllWBOnlyDesc"] = "Mostra apenas os bônus mundiais quando os de outros são dissipados e nenhum outro tipo de bônus.";

L["soundsDispelsAllTitle"] = "Som para outros jogadores";
L["soundsDispelsAllDesc"] = "Qual som reproduzir quando os bônus de outros jogadores são dissipados.";

L["middleHideBattlegroundsTitle"] = "Campo de batalha";
L["middleHideBattlegroundsDesc"] = "Oculta os anúncios no meio da tela em Campos de batalha?";

L["soundsDisableInBattlegroundsTitle"] = "Campos de batalha";
L["soundsDisableInBattlegroundsDesc"] = "Desativa os sons enquanto você está em Campos de batalha.";


L["autoBuffsHeaderDesc"] = "Seleção automática";

L["autoDmfBuffTitle"] = "Selecionar bônus";
L["autoDmfBuffDesc"] = "Quer que este addon selecione automaticamente um bônus da Feira de Negraluna quando você falar com o NPC Malaby? Certifique-se de escolher também qual bônus você quer.";

L["autoDmfBuffTypeTitle"] = "Qual bônus";
L["autoDmfBuffTypeDesc"] = "Qual bônus da Feira de Negraluna você quer que este addon selecione automaticamente quando falar com Malaby?";

L["autoDireMaulBuffTitle"] = "A matança";
L["autoDireMaulBuffDesc"] = "Quer que este addon obtenha automaticamente bônus dos NPCs em a matança quando você falar com eles? (Também obtém o bônus do Rei).";

L["autoBwlPortalTitle"] = "Portal de Covil Asa Negra";
L["autoBwlPortalDesc"] = "Quer que este addon use automaticamente o portal de Covil Asa Negra quando você clicar na esfera?";

L["showBuffStatsTitle"] = "Estatísticas";
L["showBuffStatsDesc"] = "Mostra quantas vezes você obteve cada bônus no quadro /buffs? Os bônus de Ony/Nef/Laceral/Zand têm sido registrados desde a instalação do quadro de bônus, mas o resto dos bônus só começaram a ser registrados agora na versão 1.65.";

L["buffResetButtonTooltip"] = "Isso redefinirá todos os bônus.\nOs dados de contagem de bônus não serão redefinidos."; --Reset button tooltip for the /buffs frame.
L["time"] = "(%s vez)"; --Singular - This shows how many timers you got a buff. Example: (1 time)
L["times"] = "(%s vezes)"; --Plural - This shows how many timers you got a buff. Example: (5 times)
L["flowerWarning"] = "Flor da Canção foi coletada em um reino com temporizadores de Flor da Canção em camadas ativadas, mas você não marcou nenhum NPC desde que chegou em Selva Maleva, então nenhum temporizador pôde ser registrado.";

L["mmColorTitle"] = "Cor da camada no minimapa";
L["mmColorDesc"] = "Qual cor deve ser o texto da camada no minimapa? (Camada 1)";

L["layerHasBeenDisabled"] = "A camada %s foi desativada. Esta camada ainda está no banco de dados, mas será ignorada até que seja reativada ou detectada como válida novamente.";
L["layerHasBeenEnabled"] = "A camada %s foi ativada. Agora está de volta aos cálculos de camadas e temporizadores.";
L["layerDoesNotExist"] = "O ID da camada %s não existe no banco de dados.";
L["enableLayerButton"] = "Ativar camada";
L["disableLayerButton"] = "Desativar camada";
L["enableLayerButtonTooltip"] = "Clique para reativar esta camada. Ela será incluída novamente nos cálculos de temporizadores e camadas.";
L["disableLayerButtonTooltip"] = "Clique para desativar a camada antiga após reiniciar o servidor. O addon a ignorará e a removerá posteriormente.";

L["minimapLayerHoverTitle"] = "Passar o mouse";
L["minimapLayerHoverDesc"] = "Mostra apenas o número da camada no minimapa ao passar o mouse sobre ele?";

L["Blackrock Mountain"] = "Montanha Rocha Negra";

L["soundsNpcKilledTitle"] = "NPC morto";
L["soundsNpcKilledDesc"] = "Som reproduzido quando um NPC que concede um bônus é morto para reiniciar um temporizador.";

L["autoDmfBuffCharsText"] = "Configurações de bônus para cada personagem:";

L["middleNpcKilledTitle"] = "NPC morto";
L["middleNpcKilledDesc"] = "Mostra uma mensagem de aviso no meio da tela quando um NPC é morto para reiniciar o bônus.";

L["chatNpcKilledTitle"] = "NPC morto";
L["chatNpcKilledDesc"] = "Mostra uma mensagem no chat quando um NPC é morto para reiniciar o bônus.";

L["onyxiaNpcRespawnHorde"] = "O NPC da Onyxia (Runthak) reaparecerá em um momento aleatório dentro dos próximos 2 minutos.";
L["nefarianNpcRespawnHorde"] = "O NPC do Nefarian (Saurfang) reaparecerá em um momento aleatório dentro dos próximos 2 minutos.";
L["onyxiaNpcRespawnAlliance"] = "O NPC da Onyxia (Valadão) reaparecerá em um momento aleatório dentro dos próximos 2 minutos.";
L["nefarianNpcRespawnAlliance"] = "O NPC do Nefarian (Afrasiabi) reaparecerá em um momento aleatório dentro dos próximos 2 minutos.";

L["onyxiaNpcKilledHordeWithTimer2"] = "O NPC da Onyxia (Runthak) foi morto há %s, reaparecerá em %s.";
L["nefarianNpcKilledHordeWithTimer2"] = "O NPC do Nefarian (Saurfang) foi morto há %s, reaparecerá em %s.";
L["onyxiaNpcKilledAllianceWithTimer2"] = "O NPC da Onyxia (Valadão) foi morto há %s, reaparecerá em %s.";
L["nefarianNpcKilledAllianceWithTimer2"] = "O NPC do Nefarian (Afrasiabi) foi morto há %s, reaparecerá em %s.";

L["flashNpcKilledTitle"] = "Piscar";
L["flashNpcKilledDesc"] = "Deve o cliente WoW piscar quando um NPC que concede um bônus é morto?";

L["trimDataHeaderDesc"] = "Limpeza de dados";

L["trimDataBelowLevelTitle"] = "Nível máximo para remoção";
L["trimDataBelowLevelDesc"] = "Selecione o nível máximo de personagens para remover do banco de dados; todos os personagens deste nível e abaixo serão removidos.";

L["trimDataBelowLevelButtonTitle"] = "Remover Personagens";
L["trimDataBelowLevelButtonDesc"] = "Clique neste botão para remover todos os personagens com o nível selecionado e abaixo deste banco de dados adicional. Nota: Isso remove os dados de contagem de bônus permanentemente.";

L["trimDataTextDesc"] = "Remover vários personagens do banco de dados de bônus:";
L["trimDataText2Desc"] = "Remover um personagem do banco de dados de bônus:";

L["trimDataCharInputTitle"] = "Remover um Personagem por Entrada";
L["trimDataCharInputDesc"] = "Digite aqui um personagem para remover, no formato Nome-Reino (distingue maiúsculas de minúsculas). Nota: Isso remove os dados de contagem de bônus permanentemente.";

L["trimDataBelowLevelButtonConfirm"] = "Tem certeza de que deseja remover todos os personagens abaixo do nível %s do banco de dados?";
L["trimDataCharInputConfirm"] = "Tem certeza de que deseja remover este personagem %s do banco de dados?";

L["trimDataMsg1"] = "Os registros de bônus foram redefinidos."
L["trimDataMsg2"] = "Removendo todos os personagens abaixo do nível %s.";
L["trimDataMsg3"] = "Removidos: %s.";
L["trimDataMsg4"] = "Concluído, nenhum personagem encontrado.";
L["trimDataMsg5"] = "Concluído, %s personagens removidos.";
L["trimDataMsg6"] = "Digite um nome de personagem válido para remover do banco de dados.";
L["trimDataMsg7"] = "O nome deste personagem %s não inclui um reino, digite Nome-Reino.";
L["trimDataMsg8"] = "Erro ao remover %s do banco de dados, personagem não encontrado (o nome diferencia maiúsculas de minúsculas).";
L["trimDataMsg9"] = "%s removido do banco de dados.";

L["serverTime"] = "hora do reino";
L["serverTimeShort"] = "hs";

L["showUnbuffedAltsTitle"] = "Alts sem bônus";
L["showUnbuffedAltsDesc"] = "Mostra alts sem bônus na janela de bônus? Isso permite que você veja quais personagens não têm bônus, se desejar.";

L["timerWindowWidthTitle"] = "Largura da janela do temporizador";
L["timerWindowWidthDesc"] = "Quão larga deve ser a janela do temporizador?";

L["timerWindowHeightTitle"] = "Altura da janela do temporizador";
L["timerWindowHeightDesc"] = "Quão alta deve ser a janela do temporizador?";

L["buffWindowWidthTitle"] = "Largura da janela de bônus";
L["buffWindowWidthDesc"] = "Quão larga deve ser a janela de bônus?";

L["buffWindowHeightTitle"] = "Altura da janela de bônus";
L["buffWindowHeightDesc"] = "Quão alta deve ser a janela de bônus?";

L["dmfSettingsListTitle"] = "Lista de bônus";
L["dmfSettingsListDesc"] = "Clique aqui para mostrar uma lista das suas configurações de tipo de bônus da Feira de Negraluna de seus alts.";

L["ignoreKillDataTitle"] = "Ignorar dados de NPC";
L["ignoreKillDataDesc"] = "Ignora quaisquer dados de NPC mortos para que não sejam registrados.";

L["noOverwriteTitle"] = "Não sobrescrever";
L["noOverwriteDesc"] = "Você pode ativar isso para, se já tiver um temporizador válido em execução, ignorar quaisquer novos dados para esse temporizador até que ele termine.";

L["layerMsg1"] = "Você está em um reino com camadas.";
L["layerMsg2"] = "Clique aqui para ver os temporizadores atuais.";
L["layerMsg3"] = "Aponte para qualquer NPC para ver sua camada atual.";
L["layerMsg4"] = "Aponte para qualquer NPC em %s para ver sua camada atual."; --Target any NPC in Orgrimmar to see your current layer.

--NOTE: Darkmoon Faire buff type is now a character specific setting, changing buff type will only change it for this character.
L["note"] = "NOTA:";
L["dmfConfigWarning"] = "O tipo de bônus da Feira de Negraluna agora é uma configuração específica do personagem; alterar o tipo de bônus apenas o modificará para este personagem."

---New---

L["onyNpcMoving"] = "¡El NPC de Onyxia ha comenzado a moverse!";
L["nefNpcMoving"] = "¡El NPC de Nefarian ha comenzado a moverse!";

L["buffHelpersHeaderDesc"] = "Asistentes de bônus para servidores JxJ";

L["buffHelpersTextDesc"] = "Asistentes de bônus para servidores JxJ (ativados se você obtiver um bônus e realizar uma dessas ações dentro dos segundos estabelecidos após obter o bônus; você pode ajustar os segundos abaixo).";
L["buffHelpersTextDesc2"] = "\nBônus de Zandalar";
L["buffHelpersTextDesc3"] = "Bônus da Feira de Negraluna";
L["buffHelpersTextDesc4"] = "Insira a macro do campo de batalha (você deve pressionar isso duas vezes para funcionar, então apenas envie spam; isso removerá a fila se você ainda não tiver uma janela pop-up, então tenha cuidado para não pressionar antes).\n|cFF9CD6DE/click DropDownList1Button2\n/click MiniMapBatlefieldFrame RightButton";

L["takeTaxiZGTitle"] = "Voo automático";
L["takeTaxiZGDesc"] = "Pega automaticamente um voo de Angra do Butim assim que um bônus cair, você pode falar com o NPC de voo após a queda ou já ter a janela aberta quando cair, funcionará em ambos os casos. |cFF00C800(Você pode obter o bônus como fantasma, então sugiro ficar como fantasma até que o bônus expire e depois falar com o NPC de voo para voar automaticamente)";

L["takeTaxiNodeTitle"] = "Destino";
L["takeTaxiNodeDesc"] = "Se você tiver a opção de voo automático ativada, para onde você deseja voar?";
			
L["dmfVanishSummonTitle"] = "Convocação ao Sumir";
L["dmfVanishSummonDesc"] = "Ladinos: Você aceita automaticamente a convocação assim que desvanecer depois de obter o bônus da Feira de Negraluna?";

L["dmfFeignSummonTitle"] = "Convocação ao Fingir de Morto";
L["dmfFeignSummonDesc"] = "Caçadores: Você aceita automaticamente a convocação assim que fingir de morto depois de obter o bônus da Feira de Negraluna?";

L["dmfCombatSummonTitle"] = "Convocação ao sair de combate";
L["dmfCombatSummonDesc"] = "Você aceita automaticamente a convocação assim que sair de combate depois de obter o bônus da Feira de Negraluna?";

L["dmfLeaveBGTitle"] = "Sair automáticamente do campo de batalha";
L["dmfLeaveBGDesc"] = "Você sai automaticamente do campo de batalha ao entrar em áreas depois de obter o bônus da Feira de Negraluna?";

L["dmfGotBuffSummonTitle"] = "Convocação ao obter bônus";
L["dmfGotBuffSummonDesc"] = "Aceita automaticamente qualquer convocação pendente ao obter o bônus da Feira de Negraluna.";

L["zgGotBuffSummonTitle"] = "Convocação com ZG";
L["zgGotBuffSummonDesc"] = "Aceita automaticamente qualquer convocação pendente ao obter o bônus de Zandalar.";

L["buffHelperDelayTitle"] = "Quantos segundos os ajudantes estão ativados?";
L["buffHelperDelayDesc"] = "Por quantos segundos após obter um bônus esses ajudantes devem funcionar? Isso é para que você possa deixar as opções ativadas e elas só funcionarão imediatamente após obter um bônus.";

L["showNaxxWorldmapMarkersTitle"] = "Naxxramas no mapa";
L["showNaxxWorldmapMarkersDesc"] = "Mostra os marcadores do Naxxramas no mapa-múndi?";

L["showNaxxMinimapMarkersTitle"] = "Naxxramas no minimapa";
L["showNaxxMinimapMarkersDesc"] = "Mostra os marcadores do Naxxramas no minimapa? Isso também mostrará a direção de volta para o Naxxramas quando você estiver como fantasma e morrer dentro da instância.";

L["bigWigsSupportTitle"] = "Suporte BigWigs";
L["bigWigsSupportDesc"] = "Inicia uma barra de temporizador para obter bônus se o BigWigs estiver instalado? O mesmo tipo de barra de temporizador que o DBM faz.";

L["soundsNpcWalkingTitle"] = "NPC em movimento";
L["soundsNpcWalkingDesc"] = "Reproduz um som quando um NPC de bônus começa a caminhar em Orgrimmar?";

L["buffHelpersTextDesc4"] = "Bônus da Flor da Canção";
L["songflowerGotBuffSummonTitle"] = "Convocação da Flor da Canção";
L["songflowerGotBuffSummonDesc"] = "Aceita automaticamente qualquer convocação pendente quando você obtém um bônus da Flor da Canção.";

L["buffHelpersTextDesc5"] = "Bônus de Ony/Laceral";
L["cityGotBuffSummonTitle"] = "Convocação de Ony/Laceral";
L["cityGotBuffSummonDesc"] = "Aceita automaticamente qualquer convocação pendente quando você obtém um bônus de Onyxia/Nefarian/Laceral.";

L["heraldFoundCrossroads"] = "Arauto encontrado! Bônus de Laceral em A Encruzilhada cairá em 20 segundos.";
L["heraldFoundTimerMsg"] = "Bônus de Laceral em A Encruzilhada" --DBM/Bigwigs timer bar text.

L["guildNpcWalkingTitle"] = "NPC em movimento";
L["guildNpcWalkingDesc"] = "Envia uma mensagem para a guilda e reproduz um som quando você ativa ou recebe um alerta de movimento de NPC? (Abra o diálogo de chat com os NPCs de Onyxia/Nefarian em Orgrimmar e espere alguém entregar a cabeça para ativar este alerta antecipado).";

L["buffHelpersTextDesc6"] = "Janela de ajuda da Feira de Negraluna";
L["dmfFrameTitle"] = "Ajuda da Feira";
L["dmfFrameDesc"] = "Uma janela que aparece quando você se aproxima de Malaby na Feira enquanto está como fantasma em servidores JxJ para auxiliar com as funções emperradas da Blizzard.";

L["Sheen of Zanza"] = "Reflexo de Zanza";
L["Spirit of Zanza"] = "Espírito de Zanza";
L["Swiftness of Zanza"] = "Rapidez de Zanza";

L["Mind Control"] = "Controle Mental";
L["Gnomish Mind Control Cap"] = "Casquete Gnômico de Controle Mental";


L["tbcHeaderText"] = "Opções de Expansão";
L["tbcNoteText"] = "Nota: Todas as mensagens de bate-papo da guilda também estão desativadas nos reinos TBC.";

L["disableSoundsAboveMaxBuffLevelTitle"] = "Desativar sons acima do nível 64+";
L["disableSoundsAboveMaxBuffLevelDesc"] = "Desativa os sons relacionados aos bônus do mundo para personagens acima do nível 63 nos reinos TBC?";

L["disableSoundsAllLevelsTitle"] = "Desativar sons de todos os níveis";
L["disableSoundsAllLevelsDesc"] = "Desativa os sons relacionados aos bônus do mundo para personagens de todos os níveis nos reinos TBC.";

L["disableMiddleAboveMaxBuffLevelTitle"] = "Desativar mensagens no meio da tela 64+";
L["disableMiddleAboveMaxBuffLevelDesc"] = "Desativa as mensagens relacionadas aos bônus do mundo no meio da tela para personagens acima do nível 63 nos reinos TBC?";

L["disableMiddleAllLevelsTitle"] = "Desativar mensagens no meio da tela todos os níveis";
L["disableMiddleAllLevelsDesc"] = "Desativa as mensagens relacionadas aos bônus do mundo no meio da tela para personagens de todos os níveis nos reinos TBC.";

L["disableChatAboveMaxBuffLevelTitle"] = "Desativar mensagens na janela de bate-papo 64+";
L["disableChatAboveMaxBuffLevelDesc"] = "Desativa as mensagens relacionadas ao temporizador de bônus do mundo na janela de bate-papo para personagens acima do nível 63 nos reinos TBC?";

L["disableChatAllLevelsTitle"] = "Desativar mensagens na janela de bate-papo todos os níveis";
L["disableChatAllLevelsDesc"] = "Desativa as mensagens relacionadas ao temporizador de bônus do mundo na janela de bate-papo para personagens de todos os níveis nos reinos TBC.";

L["disableFlashAboveMaxBuffLevelTitle"] = "Desativar pisca do cliente minimizado 64+";
L["disableFlashAboveMaxBuffLevelDesc"] = "Desativa o pisca do cliente wow enquanto está minimizado para eventos de bônus do mundo para personagens acima do nível 63 nos reinos TBC?";

L["disableFlashAllLevelsTitle"] = "Desativar pisca do cliente minimizado todos os níveis";
L["disableFlashAllLevelsDesc"] = "Desativa o pisca do cliente wow enquanto está minimizado para eventos de bônus do mundo para personagens de todos os níveis nos reinos TBC.";

L["disableLogonAboveMaxBuffLevelTitle"] = "Desativar temporizadores de logon 64+";
L["disableLogonAboveMaxBuffLevelDesc"] = "Desativa os temporizadores no bate-papo ao se conectar para personagens acima do nível 63 nos reinos TBC?";

L["disableLogonAllLevelsTitle"] = "Desativar temporizadores de logon todos os níveis";
L["disableLogonAllLevelsDesc"] = "Desativa os temporizadores no bate-papo ao se conectar para personagens de todos os níveis nos reinos TBC.";

L["Flask of Fortification"] = "Frasco de Fortificação";
L["Flask of Pure Death"] = "Frasco de Pura Morte";
L["Flask of Relentless Assault"] = "Frasco do Ataque Implacável";
L["Flask of Blinding Light"] = "Frasco de Luz Cegante";
L["Flask of Mighty Restoration"] = "Frasco de Restauração Potente";
L["Flask of Chromatic Wonder"] = "Frasco de Maravilha Cromática";
L["Fortification of Shattrath"] = "Fortificação de Shattrath";
L["Pure Death of Shattrath"] = "Pura Morte de Shattrath";
L["Relentless Assault of Shattrath"] = "Ataque Implacável de Shattrath";
L["Blinding Light of Shattrath"] = "Luz Cegante de Shattrath";
L["Mighty Restoration of Shattrath"] = "Restauração Potente de Shattrath";
L["Supreme Power of Shattrath"] = "Poder Supremo de Shattrath";
L["Unstable Flask of the Beast"] = "Frasco Instável da Fera";
L["Unstable Flask of the Sorcerer"] = "Frasco Instável do Feiticeiro";
L["Unstable Flask of the Bandit"] = "Frasco Instável do Bandido";
L["Unstable Flask of the Elder"] = "Frasco Instável do Ancião";
L["Unstable Flask of the Physician"] = "Frasco Instável do Médico";
L["Unstable Flask of the Soldier"] = "Frasco Instável do Soldado";

L["Chronoboon Displacer"] = "Deslocador Dádiva do Tempo";

L["Silithyst"] = "Silitista";

L["Gold"] = "Ouro";
L["level"] = "Nível";
L["realmGold"] = "Ouro do reino para";
L["total"] = "Total";
L["guild"] = "Guilda";
L["bagSlots"] = "Espaços da bolsa";
L["durability"] = "Durabilidade";
L["items"] = "Itens";
L["ammunition"] = "Munição";
L["attunements"] = "Harmonizações";
L["currentRaidLockouts"] = "Bloqueios de raide atuais";
L["none"] = "Nenhum";

L["dmfDamagePercent"] = "Este novo bônus da Feira de Negraluna tem %s%% de dano.";
L["dmfDamagePercentTooltip"] = "NWB detectou isso como %s de dano.";

L["guildLTitle"] = "Camadas da guilda";
L["guildLDesc"] = "Compartilha em que camada você está com sua guilda? Você pode ver a lista de camadas da sua guilda com /wb guild";

L["terokkarTimer"] = "Terokkar";
L["terokkarWarning"] = "As torres da Floresta de Terokkar serão reiniciadas em %s";

L["wintergraspTimer"] = "Invérnia";
L["wintergraspWarning"] = "Invérnia começará em %s";


L["Nazgrel"] = "Nazgrel";
--L["Hellfire Citadel is ours"] = "Hellfire Citadel is ours";
--L["The time for us to rise"] = "The time for us to rise";
L["Force Commander Danath Trollbane"] = "Comandante-chefe Danath Matatroll";
--L["The feast of corruption is no more"] = "The feast of corruption is no more";
--L["Hear me brothers"] = "Hear me brothers";

L["terokkarChat10Title"] = "Terokkar 10 Minutos";
L["terokkarChat10Desc"] = "Imprime uma mensagem no bate-papo quando restarem 10 minutos nas torres espirituais de Terokkar.";

L["terokkarMiddle10Title"] = "Terokkar 10 Minutos";
L["terokkarMiddle10Desc"] = "Mostra uma mensagem de estilo de aviso de banda no meio da tela quando restarem 10 minutos nas torres espirituais de Terokkar.";

L["showShatWorldmapMarkersTitle"] = "Marcadores de Diário de Shattrath";
L["showShatWorldmapMarkersDesc"] = "Mostra marcadores de diário de masmorra no mapa-múndi da cidade capital?";

L["disableBuffTimersMaxBuffLevelTitle"] = "Desativar Temporizadores de Bônus do Minimapa para Níveis 64+";
L["disableBuffTimersMaxBuffLevelDesc"] = "Oculta os temporizadores de bônus mundiais ao passar o cursor sobre o ícone do minimapa para personagens de nível 64+? Você só verá os temporizadores e diários da torre Terokkar, etc.";

L["hideMinimapBuffTimersTitle"] = "Desativar Temporizadores de Bônus do Minimapa para Todos os Níveis";
L["hideMinimapBuffTimersDesc"] = "Oculta os temporizadores de bônus mundiais ao passar o cursor sobre o ícone do minimapa para personagens de todos os níveis? Você só verá os temporizadores e diários da torre Terokkar, etc.";


L["guildTerok10Title"] = "Guilda Terokkar/Invérnia 10 Minutos";
L["guildTerok10Desc"] = "Envia uma mensagem no bate-papo da guilda quando restarem 10 minutos nas torres de Terokkar se for TBC ou na Conquista do Inverno se for WoTLK.";


L["guildTerok10Title"] = "Hermandad Terokkar/Invérnia 10 Minutos";
L["guildTerok10Desc"] = "Envia uma mensagem no bate-papo da hermandade quando restarem 10 minutos nas torres de Terokkar se for TBC ou na Conquista do Inverno se for WoTLK.";

L["showShatWorldmapMarkersTerokTitle"] = "Mapa Torres/Invérnia";
L["showShatWorldmapMarkersTerokDesc"] = "Mostra a torre Terokkar ou os marcadores da Invérnia no mapa da cidade capital?";

L["Completed PvP dailies"] = "Diaras de JxJ completadas";
L["Hellfire Towers"] = "Torres de Fogo Infernal";
L["Terokkar Towers"] = "Torres de Terokkar";
L["Nagrand Halaa"] = "Nagrand Halaa";

L["wintergraspChat10Title"] = "Invérnia 10 Minutos";
L["wintergraspChat10Desc"] = "Imprime uma mensagem no bate-papo quando restarem 10 minutos nas torres espirituais da Invérnia.";

L["wintergraspMiddle10Title"] = "Invérnia 10 Minutos";
L["wintergraspMiddle10Desc"] = "Imprime uma mensagem de estilo de aviso de banda no meio da tela quando restarem 10 minutos nas torres espirituais da Invérnia.";

--L["ashenvaleHordeVictoryMsg"] = "¡La sacerdotisa de la luna de la Alianza ha sido asesinada!";
--L["ashenvaleAllianceVictoryMsg"] = "¡El clarividente de la Horda ha sido asesinado!";

--L["ashenvaleWarning"] = "Los preparativos de Vale Gris están casi terminados. ¡La Batalla por Vale Gris comenzará pronto! (Alianza %s%%) (Horda %s%%)."; --Any localization of this string must match the same format with brackets etc.

L["Boon of Blackfathom"] = "Bênção das Profundezas Negras";
L["Ashenvale Rallying Cry"] = "Brado de Convocação do Vale Gris";

L["sodHeaderText"] = "Opções da Temporada de Descobrimento";

L["disableOnlyNefRendBelowMaxLevelTitle"] = "Desativar Ony/Nef/Laceral";
L["disableOnlyNefRendBelowMaxLevelDesc"] = "Desativa a exibição de Ony/Nef/Laceral no mapa da capital e na dica de ferramenta do ícone do minimapa abaixo de um certo nível? (Faz com que o ícone do minimapa mostre apenas camadas e não os temporizadores de bônus)";

L["disableOnlyNefRendBelowMaxLevelNumTitle"] = "Nível mínimo de Ony/Nef/Laceral";
L["disableOnlyNefRendBelowMaxLevelNumDesc"] = "Abaixo de que nível devemos ocultar os ícones Ony/Nef/Laceral do mapa da capital e da dica de ferramenta do botão do minimapa?";

L["soundsBlackfathomBoonTitle"] = "Som de bônus";
L["soundsBlackfathomBoonDesc"] = "Reproduz um som quando um bônus da Temporada de Descobrimento é obtido?";

L["soundsAshenvaleStartsSoonTitle"] = "Som de início do evento";
L["soundsAshenvaleStartsSoonDesc"] = "Reproduz um som quando um evento da Temporada de Descobrimento está prestes a começar?";

L["blackfathomBoomBuffDropped"] = "O bônus de Bênção das Profundezas Negras foi derrubado.";

L["showAshenvaleOverlayTitle"] = "Sobreposição";
L["showAshenvaleOverlayDesc"] = "Mostra uma sobreposição de temporizadores móvel permanentemente na sua interface de usuário?";

L["lockAshenvaleOverlayTitle"] = "Travar";
L["lockAshenvaleOverlayDesc"] = "Trava a sobreposição de temporizadores para ignorar o movimento do mouse.";

L["ashenvaleOverlayScaleTitle"] = "Escala da sobreposição";
L["ashenvaleOverlayScaleDesc"] = "Define o tamanho da sobreposição de temporizadores.";

L["ashenvaleOverlayText"] = "|cFFFFFF00-Sobreposição para sempre mostrar os temporizadores na sua interface de usuário-";
L["layersNoteText"] = "|cFFFF6900Nota sobre camadas:|r |cFF9CD6DENWB tem um limite de rastreamento de no máximo 10 camadas, isso é para que o tamanho dos dados não seja muito grande para ser compartilhado facilmente entre os jogadores. Na maioria dos reinos da Temporada com uma grande população neste momento, existem mais de 10 camadas, então se não estiver mostrando em qual camada você está, então a razão é porque você não está em uma das 10 camadas registradas. É provável que volte abaixo de 10 assim que o entusiasmo pelo lançamento diminuir um pouco, mas até lá pode não ser confiável, desculpe.|r";

L["Mouseover char names for extra info"] = "Passar o mouse sobre nomes para mais informações";
L["Show Stats"] = "Estatísticas"; --Can't be any longer than this.
L["Event Running"] = "Evento em Andamento";

L["Left-Click"] = "Clique Esq.";
L["Right-Click"] = "Clique Dir.";
L["Shift Left-Click"] = "Shift + Clique Esq.";
L["Shift Right-Click"] = "Shift + Clique Dir.";
L["Control Left-Click"] = "Ctrl + Clique Esq.";


--Try keep these roughly the same length or shorter.
L["Guild Layers"] = "Guilda";
L["Timers"] = "Temporizadores";
L["Buffs"] = "Bônus";
L["Felwood Map"] = "Mapa de Selva Maleva";
L["Config"] = "Opções";
L["Resources"] = "Recursos";
L["Layer"] = "Camada";
L["Layer Map"] = "Mapa de Camada";
L["Rend Log"] = "Laceral";
L["Timer Log"] = "Registro de Temporizadores";
L["Copy/Paste"] = "Copiar/Colar";
L["Ashenvale PvP Event Resources"] = "Progresso de Vale Gris";
L["All other alts using default"] = "Todos os outros personagens alternativos usando o padrão";
L["Chronoboon CD"] = "Recarga do Deslocador Dádiva do Tempo"; --Chronoboon cooldown.
L["All"] = "Todo"; --This has to be small to fit.
L["Old Data"] = "Dados desatualizados";
L["Ashenvale data is old"] = "Os dados de Vale Gris estão desatualizados.";
L["Ashenvale"] = "Vale Gris";
L["Ashenvale Towers"] = "Torres de Vale Gris";
L["Warning"] = "Aviso";
L["Refresh"] = "Atualizar";
L["PvP enabled"] = "JxJ ativado";
L["Hold Shift to drag"] = "Mantenha Shift pressionado para arrastar";
L["Hold to drag"] = "Mantenha pressionado para arrastar";

L["Can't find current layer or no timers active for this layer."] = "Não é possível encontrar a camada atual ou não há cronômetros ativos para esta camada.";
L["No guild members online sharing layer data found."] = "Não foram encontrados membros da guilda conectados compartilhando dados de camada.";

--New.

L["ashenvaleOverlayFontTitle"] = "Fonte da sobreposição";
L["ashenvaleOverlayFontDesc"] = "Qual fonte usar para sobreposições de tela.";

L["minimapLayerFontTitle"] = "Fonte da camada do minimapa";
L["minimapLayerFontDesc"] = "Qual fonte usar para o texto da camada do minimapa.";

L["minimapLayerFontSizeTitle"] = "Tamanho da fonte da camada do minimapa";
L["minimapLayerFontSizeDesc"] = "Qual tamanho de fonte usar para o texto da camada do minimapa.";

L["zone"] = "zona";
L["zones mapped"] = "Zonas mapeadas";
L["Layer Mapping for"] = "Mapeamento de camadas para";
L["formatForDiscord"] = "Formata o texto para colar no Discord? (Adiciona cores, etc.)";
L["Copy Frame"] = "Copiar quadro";
L["Show how many times you got each buff."] = "Mostra quantas vezes você recebeu cada bônus.";
L["Show all alts that have buff stats? (stats must be enabled)."] = "Mostra todos os alts que têm estatísticas de bônus? (as estatísticas devem estar ativadas).";
L["No timer logs found."] = "Nenhum registro de temporizador encontrado.";
L["Merge Layers"] = "Mesclar camadas";
L["mergeLayersTooltip"] = "Se várias camadas têm o mesmo temporizador, elas serão mescladas em [Todas as camadas] em vez de serem mostradas separadamente.";
L["Ready"] = "Pronto";
L["Chronoboon"] = "Deslocador Dádiva do Tempo";
L["Local Time"] = "Horário local";
L["Server Time"] = "Hora do reino";
L["12 hour"] = "12 horas";
L["24 hour"] = "24 horas";
L["Alliance"] = "Aliança";
L["Horde"] = "Horda";
L["No Layer"] = "Sem camada";
L["No data yet."] = "Ainda não há dados.";
L["Ashenvale Resources"] = "Progresso de Vale Gris";
L["No character specific buffs set yet."] = "Ainda não foram definidos bônus específicos do personagem.";
L["All characters are using default"] = "Todos os personagens estão usando as configurações padrão";
L["Orgrimmar"] = "Orgrimmar";
L["Stormwind"] = "Ventobravo";
L["Dalaran"] = "Dalaran";
L["left"] = "restantes";
L["remaining"] = "restantes";

L["Online"] = "Conectado";
L["Offline"] = "Desconectado";
L["Rested"] = "Descansado";
L["Not Rested"] = "Não Descansado";
L["No zones mapped for this layer yet."] = "Ainda não há zonas mapeadas para esta camada.";
L["Cooldown"] = "Tempo de Recarga";
L["dmfLogonBuffResetMsg"] = "Esses personagens estiveram desconectados por mais de 8 horas em uma área descansada e o tempo de recarga do bônus da Feira de Negraluna foi reiniciado.";
L["dmfOfflineStatusTooltip"] = "Tempo de recarga do Feira mais de 8 horas descontectados em estado de área de descanso";
L["chronoboonReleased"] = "O Deslocador Dádiva do Tempo Supercarregado restaurou o bônus do Feira de Negraluna. Um novo tempo de recarga de 4 horas começou.";

L["Stranglethorn"] = "Espinhaço"; --One word shorter version of Strangethorn Vale to fit better.
L["ashenvaleEventRunning"] = "A Batalha pelo Vale Gris está em progresso: %s";
L["ashenvaleEventStartsIn"] = "A Batalha pelo Vale Gris começará em %s";
L["ashenvaleStartSoon"] = "A Batalha pelo Vale Gris começará em %s"; -- Guild chat msg.
L["stranglethornEventRunning"] = "A Lua Sangrenta está em progresso: %s";
L["stranglethornEventStartsIn"] = "A Lua Sangrenta começará em %s";
L["stranglethornStartSoon"] = "A Lua Sangrenta começará em %s"; -- Guild chat msg.
L["Spark of Inspiration"] = "Centelha da Inspiração"; --Phase 2 SoD world buff.
L["specificBuffDropped"] = "O bônus de %s caiu.";
L["3 day raid reset"] = "Reinício do raide de 3 dias.";
L["Darkmoon Faire is up"] = "A Feira de Negraluna está disponível";
L["dmfAbbreviation"] = "Feira";
L["Ashenvale PvP Event"] = "A Batalha pelo Vale Gris";
L["Stranglethorn PvP Event"] = "A Lua Sangrenta";

L["overlayShowArtTitle"] = "Sobreposição de arte";
L["overlayShowArtDesc"] = "Mostra a sobreposição de arte?";

L["overlayShowAshenvaleTitle"] = "Vale Gris";
L["overlayShowAshenvaleDesc"] = "Mostra a sobreposição do temporizador de Vale Gris?";

L["overlayShowStranglethornTitle"] = "Selva do Espinhaço";
L["overlayShowStranglethornDesc"] = "Mostra a sobreposição do temporizador de Selva do Espinhaço?";

L["sodMiddleScreenWarningTitle"] = "Anúncios no meio da tela";
L["sodMiddleScreenWarningDesc"] = "Mostra aviso de 15/30 minutos no meio da tela para eventos JxJ?";

L["stvBossMarkerTooltip"] = "Marcador de chefe NWB (experimental)";
L["Boss"] = "Chefe"; --Abbreviate if too long, this text sits below a map marker.
L["stvBossSpotted"] = "Chefe Loa avistado! Veja o mapa para a localização.";
L["Total coins this event"] = "Total de moedas ganhas neste evento"; --Keep it short, it prints to chat when you hand in coins.
L["Last seen"] = "Última vez visto";
L["World Events"] = "Eventos mundiais";
L["layersNoGuild"] = "Você não tem uma guilda, este comando mostra apenas membros da guilda.";

L["Fervor of the Temple Explorer"] = "Fervor do Explorador do Templo";
L["No guild"] = "Sem guilda";

L["Temple of Atal'Hakkar"] = "Templo de Atal'hakkar";