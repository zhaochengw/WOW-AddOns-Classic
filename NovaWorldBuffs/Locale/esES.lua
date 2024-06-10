local L = LibStub("AceLocale-3.0"):NewLocale("NovaWorldBuffs", "esES");
if (not L) then
	return;
end

--Spanish translations by Cruzluz.

local type;
if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
    type = "classic";
elseif (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) then
    type = "wrath";
elseif (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) then
    type = "tbc";
end

--Some esES strings were changed by Blizzard between classic and tbc.
if (type == "classic") then
    L["Rallying Cry of the Dragonslayer"] = "Recobrar el llanto del cazadragones";
	L["Warchief's Blessing"] = "Bendición de Jefe de Guerra";
	L["Overlord Runthak"] = "Señor Supremo Runthak";
	L["rend"] = "Desgarro"
	L["rendFirstYellMsg"] = "Desgarro caerá en 6 segundos.";
	L["rendBuffDropped"] = "Bendición de Jefe de Guerra (Desgarro) se ha caído."
	L["onyxiaBuffDropped"] = "Recobrar el llanto del cazadragones (Onyxia) se ha caído.";
	L["nefarianBuffDropped"] = "Recobrar el llanto del cazadragones (Nefarian) se ha caído.";
	L["soundsRendDropTitle"] = "Beneficio de Desgarro";
	L["soundsRendDropDesc"] = "Sonido para reproducir para Desgarro cuando obtienes el beneficio.";
	L["logonRendTitle"] = "Desgarro";
	L["logonRendDesc"] = "Muestra el temporizador de Desgarro en la ventana de chat cuando te conectas.";
	L["guildBuffDroppedDesc"] = "¿Envía un mensaje a la hermandad cuando se haya empezado un nuevo beneficio? Este mensaje se envía después de que el PNJ termina de gritar y obtienes el beneficio real unos segundos después. (6 segundos después del primer grito para Desgarro, 14 segundos para Onyxia, 15 segundos para Nefarian)";
	L["allianceEnableRendTitle"] = "Desgarro para Alianza";
	L["allianceEnableRendDesc"] = "Activa esto para realizar un seguimiento de Desgarro como Alianza, para que las hermandades que tienen control mental obtengan un beneficio de Desgarro. Si usas esto, entonces todos en la hermandad con el addon deberían activarlo o los mensajes de chat de la hermandad podrían no funcionar correctamente (los mensajes del temporizador personal seguirán funcionando).";
	L["showBuffStatsDesc"] = "¿Muestra cuántas veces has obtenido cada beneficio en el marco /buffs? Los beneficios de Ony/Nef/Desgarro/Zand se han estado grabando desde que se instaló el marco de beneficios, pero el resto de los beneficios solo comenzaron a grabar ahora en la versión 1.65.";
	L["cityGotBuffSummonTitle"] = "Invocación Ony/Desgarro";
	L["cityGotBuffSummonDesc"] = "Acepta automáticamente cualquier invocación pendiente cuando obtienes un beneficio de Ony/Nef/Desgarro.";
	L["heraldFoundCrossroads"] = "¡Heraldo encontrado! Beneficio de Desgarro en El Cruce caerá en 20 segundos.";
	L["heraldFoundTimerMsg"] = "Beneficio de Desgarro en El Cruce"; --DBM/Bigwigs timer bar text.
	L["disableOnlyNefRendBelowMaxLevelTitle"] = "Desactivar Ony/Nef/Desgarro";
	L["disableOnlyNefRendBelowMaxLevelDesc"] = "¿Desactiva Ony/Nef/Desgarro que se muestra en el mapa de la ciudad capital y en el tooltip del icono del minimapa por debajo de cierto nivel? (Hace que el icono del minimapa solo muestra capas y no los temporizadores de beneficio)";
	L["disableOnlyNefRendBelowMaxLevelNumTitle"] = "Ony/Nef/Desgarro nivel mínimo";
	L["disableOnlyNefRendBelowMaxLevelNumDesc"] = "¿Debajo de qué nivel deberíamos ocultar los iconos Ony/Nef/Desgarro del mapa de la ciudad y el tooltip del botón del minimapa?";
	L["Rend Log"] = "Desgarro";
else
    L["Rallying Cry of the Dragonslayer"] = "Berrido de convocación del matadragones"
	L["Warchief's Blessing"] = "Bendición del Jefe de Guerra";
	L["Overlord Runthak"] = "Señor supremo Runthak";
	L["rend"] = "Rend"
	L["rendFirstYellMsg"] = "Rend caerá en 6 segundos.";
	L["rendBuffDropped"] = "Bendición del Jefe de Guerra (Rend) se ha caído."
	L["onyxiaBuffDropped"] = "Berrido de convocación del matadragones (Onyxia) se ha caído.";
	L["nefarianBuffDropped"] = "Berrido de convocación del matadragones (Nefarian) se ha caído.";
	L["soundsRendDropTitle"] = "Beneficio de Rend";
	L["soundsRendDropDesc"] = "Sonido para reproducir para Rend cuando obtienes el beneficio.";
	L["logonRendTitle"] = "Rend";
	L["logonRendDesc"] = "Muestra el temporizador de Rend en la ventana de chat cuando te conectas.";
	L["guildBuffDroppedDesc"] = "¿Envía un mensaje a la hermandad cuando se haya empezado un nuevo beneficio? Este mensaje se envía después de que el PNJ termina de gritar y obtienes el beneficio real unos segundos después. (6 segundos después del primer grito para Rend, 14 segundos para Onyxia, 15 segundos para Nefarian)";
	L["allianceEnableRendTitle"] = "Rend para Alianza";
	L["allianceEnableRendDesc"] = "Activa esto para realizar un seguimiento de Rend como Alianza, para que las hermandades que tienen control mental obtengan un beneficio de Rend. Si usas esto, entonces todos en la hermandad con el addon deberían activarlo o los mensajes de chat de la hermandad podrían no funcionar correctamente (los mensajes del temporizador personal seguirán funcionando).";
	L["showBuffStatsDesc"] = "¿Muestra cuántas veces has obtenido cada beneficio en el marco /buffs? Los beneficios de Ony/Nef/Rend/Zand se han estado grabando desde que se instaló el marco de beneficios, pero el resto de los beneficios solo comenzaron a grabar ahora en la versión 1.65.";
	L["buffHelpersTextDesc5"] = "Beneficio de Ony/Rend";
	L["cityGotBuffSummonTitle"] = "Invocación Ony/Rend";
	L["cityGotBuffSummonDesc"] = "Acepta automáticamente cualquier invocación pendiente cuando obtienes un beneficio de Ony/Nef/Rend.";
	L["heraldFoundCrossroads"] = "¡Heraldo encontrado! Beneficio de Rend en El Cruce caerá en 20 segundos.";
	L["heraldFoundTimerMsg"] = "Beneficio de Rend en El Cruce"; --DBM/Bigwigs timer bar text.
	L["disableOnlyNefRendBelowMaxLevelTitle"] = "Desactivar Ony/Nef/Rend";
	L["disableOnlyNefRendBelowMaxLevelDesc"] = "¿Desactiva Ony/Nef/Rend que se muestra en el mapa de la ciudad capital y en el tooltip del icono del minimapa por debajo de cierto nivel? (Hace que el icono del minimapa solo muestra capas y no los temporizadores de beneficio)";
	L["disableOnlyNefRendBelowMaxLevelNumTitle"] = "Ony/Nef/Rend nivel mínimo";
	L["disableOnlyNefRendBelowMaxLevelNumDesc"] = "¿Debajo de qué nivel deberíamos ocultar los iconos Ony/Nef/Rend del mapa de la ciudad y el tooltip del botón del minimapa?";
	L["Rend Log"] = "Rend";
end

--Rend buff aura name.
--L["Warchief's Blessing"] = "Bendición de Jefe de Guerra";
--Onyxia and Nefarian buff aura name.
--L["Rallying Cry of the Dragonslayer"] = "Recobrar el llanto del cazadragones";
--Songflower buff aura name from felwood.
L["Songflower Serenade"] = "Serenata Cantaflor";
L["Songflower"] = "Cantaflor";

L["Flask of Supreme Power"] = "Frasco de poder supremo";
L["Flask of the Titans"] = "Frasco de los titanes";
L["Flask of Distilled Wisdom"] = "Frasco de sabiduría destilada";
L["Flask of Chromatic Resistance"] = "Frasco de resistencia cromática";
--3 of the flasks spells seem to be named differently than the flask item, but titan is exact same name as the flask item.
L["Supreme Power"] = "Poder supremo";
L["Distilled Wisdom"] = "Sabiduría destilada";
L["Chromatic Resistance"] = "Resistencia cromática";
L["Sap"] = "Zapar";
L["Fire Festival Fortitude"] = "Entereza del Festival de Fuego";
L["Fire Festival Fury"] = "Furia del Festival de Fuego";
L["Ribbon Dance"] = "Danza de las cintas";
L["Traces of Silithyst"] = "Rastros de silitista";
L["Slip'kik's Savvy"] = "Sentido común de Slip'kik";
L["Fengus' Ferocity"] = "Ferocidad de Fengus";
L["Mol'dar's Moxie"] = "Asertividad Mol'dar";

---=====---
---Horde---
---=====---

--Horde Orgrimmar Rend buff NPC.
L["Thrall"] = "Thrall";
--Horde The Barrens Rend buff NPC.
L["Herald of Thrall"] = "Heraldo de Thrall";
--Horde rend buff NPC first yell string (part of his first yell msg before before buff).
--L["Rend Blackhand, has fallen"] = "¡El falso Jefe de Guerra Rend Puño Negro se ha caído!";
--Horde rend buff NPC second yell string (part of his second yell msg before before buff).
--L["Be bathed in my power"] = "";

--Horde Onyxia buff NPC.
--L["Overlord Runthak"] = "Señor Supremo Runthak";
--Horde Onyxia buff NPC first yell string (part of his first yell msg before before buff).
--L["Onyxia, has been slain"] = "";
--Horde Onyxia buff NPC second yell string (part of his second yell msg before before buff).
--L["Be lifted by the rallying cry"] = "";

--Horde Nefarian buff NPC.
L["High Overlord Saurfang"] = "Alto señor supremo Colmillosauro";
--Horde Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["NEFARIAN IS SLAIN"] = "¡NEFARIAN HA SIDO ASESINADO!";
--Horde Nefarian buff NPC second yell string (part of his second yell msg before before buff).
--L["Revel in his rallying cry"] = "";

---========---
---Alliance---
---========---

--Alliance Onyxia buff NPC.
L["Major Mattingly"] = "Mayor Mattingly";
--Alliance Onyxia buff NPC first yell string (part of his first yell msg before before buff).
L["history has been made"] = "hemos hecho historia";
--Alliance Onyxia buff NPC second yell string (part of his second yell msg before before buff).
--L["Onyxia, hangs from the arches"] = "";


--Alliance Nefarian buff NPC.
L["Field Marshal Afrasiabi"] = "Alguacil de campo Afrasiabi";
L["Field Marshal Stonebridge"] = "Mariscal de campo Petraponte";
--Alliance Nefarian buff NPC first yell string (part of his first yell msg before before buff).
L["the Lord of Blackrock is slain"] = "el Señor de Roca Negra está muerto";
--Alliance Nefarian buff NPC second yell string (part of his second yell msg before before buff).
--L["Revel in the rallying cry"] = "";

---===========----
---NPC's killed---
---============---

L["onyxiaNpcKilledHorde"] = "Señor Supremo Runthak acaba de ser asesinado (PNJ de beneficio de Onyxia).";
L["onyxiaNpcKilledAlliance"] = "Mayor Mattingly acaba de ser asesinado (PNJ de beneficio de Onyxia).";
L["nefarianNpcKilledHorde"] = "Alto señor supremo Colmillosauro acaba de ser asesinado (PNJ de beneficio de Nefarian).";
L["nefarianNpcKilledAlliance"] = "Alguacil de campo Afrasiabi acaba de ser asesinado (PNJ de beneficio de Nefarian).";
L["onyxiaNpcKilledHordeWithTimer"] = "El PNJ de Onyxia (Runthak) fue asesinado hace %s y no se ha registrado ningún beneficio desde entonces.";
L["nefarianNpcKilledHordeWithTimer"] = "El PNJ de Nefarian (Colmillosauro) fue asesinado hace %s y no se ha registrado ningún beneficio desde entonces.";
L["onyxiaNpcKilledAllianceWithTimer"] = "El PNJ de Onyxia (Mattingly) fue asesinado hace %s y no se ha registrado ningún beneficio desde entonces.";
L["nefarianNpcKilledAllianceWithTimer"] = "El PNJ de Nefarian (Afrasiabi) fue asesinado hace %s y no se ha registrado ningún beneficio desde entonces.";
L["anyNpcKilledWithTimer"] = "PNJ fue asesinado hace %s"; --Map timers tooltip msg.


---==============---
---Darkmoon Faire---
---==============---

L["Darkmoon Faire"] = "Feria de la Luna Negra";
L["Sayge's Dark Fortune of Agility"] = "Agilidad de fortuna de las Sombras de Sayge";
L["Sayge's Dark Fortune of Intelligence"] = "Inteligencia de fortuna de las Sombras de Sayge";
L["Sayge's Dark Fortune of Spirit"] = "Espíritu de fortuna de las Sombras de Sayge";
L["Sayge's Dark Fortune of Stamina"] = "Aguante de fortuna de las Sombras de Sayge";
L["Sayge's Dark Fortune of Strength"] = "Fuerza de fortuna de las Sombras de Sayge";
L["Sayge's Dark Fortune of Armor"] = "Armadura de fortuna de las Sombras de Sayge";
L["Sayge's Dark Fortune of Resistance"] = "Resistencia de fortuna de las Sombras de Sayge";
L["Sayge's Dark Fortune of Damage"] = "Daño de fortuna de las Sombras de Sayge";
L["dmfBuffCooldownMsg"] = "A tu tiempo de reutilización del beneficio de la Feria de la Luna Negra le quedan %s";
L["dmfBuffCooldownMsg2"] = "A tu tiempo de reutilización del beneficio de la Feria de la Luna Negra le queda %s"; --/wb frame.
L["dmfBuffCooldownMsg3"] = "El tiempo de reutilización del beneficio de la Feria de la Luna Negra también se reinicia con el reinicio semanal del servidor."; --/wb frame 2nd msg.
L["dmfBuffReady"] = "Tu beneficio de la Feria de la Luna Negra está fuera de tiempo de reutilización."; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffReset"] = "El tiempo de reutilización de tu beneficio de la Feria de la Luna Negra se ha reiniciado."; --These 2 buff msgs are slightly different for a reason.
L["dmfBuffDropped"] = "El beneficio %s de la Feria de la Luna Negra recibido, para realizar un seguimiento del tiempo de reutilización de 4 horas dentro del juego para este beneficio escribe /buffs";
L["dmfSpawns"] = "Feria de la Luna Negra aparecerá en %s (%s)";
L["dmfEnds"] = "Feria de la Luna Negra terminará en %s (%s)";
L["mulgore"] = "Mulgore";
L["elwynnForest"] = "Bosque de Elwynn";

---==============---
---Output Strings---
---==============---

--L["rend"] = "Rend"; --Rend Blackhand
L["onyxia"] = "Onyxia"; --Onyxia
L["nefarian"] = "Nefarian"; --Nefarian
L["dmf"] = "Feria de la Luna Negra"; --Darkmoon Faire
L["noTimer"] = "Sin temporizador"; --No timer
L["noCurrentTimer"] = "Sin temporizador actual"; --No current timer
L["noActiveTimers"] = "Sin temporizador actual"; --No active timers
L["newBuffCanBeDropped"] = "Ahora se puede obtener un nuevo beneficio de %s";
L["buffResetsIn"] = "%s reiniciará en %s";
--L["rendFirstYellMsg"] = "Rend caerá en 6 segundos.";
L["onyxiaFirstYellMsg"] = "Onyxia caerá en 14 segundos.";
L["nefarianFirstYellMsg"] = "Nefarian caerá en 15 segundos.";
--L["rendBuffDropped"] = "Bendición del Jefe de Guerra (Rend) se ha caído.";
--L["onyxiaBuffDropped"] = "Berrido de convocación del matadragones (Onyxia) se ha caído.";
--L["nefarianBuffDropped"] = "Berrido de convocación del matadragones (Nefarian) se ha caído.";
L["newSongflowerReceived"] = "Se recibió un nuevo temporizador de Cantaflor."; --New songflower timer received
L["songflowerPicked"] = "Cantaflor se recogió en %s, la próxima aparición será en 25 minutos."; -- Guild msg when songflower picked.
L["North Felpaw Village"] = "Al norte del Poblado Zarpavil";
L["West Felpaw Village"] = "Al oeste del Poblado Zarpavil";
L["North of Irontree Woods"] = "Al norte del Bosque de Troncoferro";
L["Talonbranch Glade"] = "Claro Ramaespolón";
L["Shatter Scar Vale"] = "Cañada Gran Cicatriz";
L["Bloodvenom Post"] = "Puesto del Veneno";
L["East of Jaedenar"] = "Al este de Jaedenar";
L["North of Emerald Sanctuary"] = "Al norte del Santuario Esmeralda";
L["West of Emerald Sanctuary"] = "Al oeste del Santuario Esmeralda";
L["South of Emerald Sanctuary"] = "Al sur del Santuario Esmeralda";
L["second"] = "segundo"; --Second (singular).
L["seconds"] = "segundos"; --Seconds (plural).
L["minute"] = "minuto"; --Minute (singular).
L["minutes"] = "minutos"; --Minutes (plural).
L["hour"] = "hora"; --Hour (singular).
L["hours"] = "horas"; --Hours (plural).
L["day"] = "día"; --Day (singular).
L["days"] = "días"; --Days (plural).
L["secondMedium"] = "seg"; --Second (singular).
L["secondsMedium"] = "seg"; --Seconds (plural).
L["minuteMedium"] = "min"; --Minute (singular).
L["minutesMedium"] = "min"; --Minutes (plural).
L["hourMedium"] = "hora"; --Hour (singular).
L["hoursMedium"] = "horas"; --Hours (plural).
L["dayMedium"] = "día"; --Day (singular).
L["daysMedium"] = "días"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "d"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Comenzará en %s"; --"Starts in 1hour".
L["endsIn"] = "Terminará en %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova World Buffs está desactualizado, actualícelo en https://www.curseforge.com/wow/addons/nova-world-buffs";
L["Your Current World Buffs"] = "Beneficios de mundo actuales";
L["Options"] = "Opciones";

--Spirit of Zandalar buff NPC first yell string (part of his first yell msg before before buff).
L["Begin the ritual"] = "Comiencen el ritual"
L["The Blood God"] = "El Dios de la Sangre"; --First Booty bay yell from Zandalarian Emissary.
--Spirit of Zandalar buff NPC second yell string (part of his second yell msg before before buff).
--L["slayer of Hakkar"] = "slayer of Hakkar";

L["Spirit of Zandalar"] = "Espíritu de Zandalar";
L["Molthor"] = "Molthor";
L["Zandalarian Emissary"] = "Emisario Zandalar";
L["Whipper Root Tuber"] = "Tubérculo de blancoria";
L["Night Dragon's Breath"] = "Aliento de Dragón nocturno";
L["Resist Fire"] = "Resistir al Fuego"; -- LBRS fire resist buff.
L["Blessing of Blackfathom"] = "Bendición de Brazanegra";

L["zan"] = "Zandalar";
L["zanFirstYellMsg"] = "Zandalar realizará en %s segundos.";
L["zanBuffDropped"] = "Espíritu de Zandalar (Hakkar) ha realizado.";
L["singleSongflowerMsg"] = "Cantaflor en %s aparecerá en %s."; -- Songflower at Bloodvenom Post spawns at 1pm.
L["spawn"] = "Aparición"; --Used in Felwood map marker tooltip (03:46pm spawn).
L["Irontree Woods"] = "Bosque de Troncoferro";
L["West of Irontree Woods"] = "Al oeste del Bosque de Troncoferro";
L["Bloodvenom Falls"] = "Cascadas del Veneno";
L["Jaedenar"] = "Jaedenar";
L["North-West of Irontree Woods"] = "Al noroeste del Bosque de Troncoferro";
L["South of Irontree Woods"] = "Al sur del Bosque de Troncoferro";

L["worldMapBuffsMsg"] = "Escribe /buffs para ver todos los\nbeneficios de mundo actuales de tus personajes.";
L["cityMapLayerMsgHorde"] = "Actualmente en %s\nApunta a un PNJ\npara actualizar tu capa después de cambiar de zona.|r";
L["cityMapLayerMsgAlliance"] = "Actualmente en %s\nApunta a cualquier PNJ\npara actualizar tu capa después de cambiar de zona.|r";
L["noLayerYetHorde"] = "Apunta a cualquier NPC\npara encontrar tu capa actual.";
L["noLayerYetAlliance"] = "Apunta a cualquier NPC\npara encontrar tu capa actual.";
L["Reset Data"] = "Restablecer"; --A button to Reset buffs window data.


L["layerFrameMsgOne"] = "Las capas antiguas persistirán unas horas después de reiniciar el servidor."; --Msg at bottom of layer timers frame.
L["layerFrameMsgTwo"] = "Las capas se desaparecerán aquí después de 6 horas sin temporizadores."; --Msg at bottom of layer timers frame.
L["You are currently on"] = "Actualmente estás en"; --You are currently on [Layer 2]


-------------
---Config---
-------------
--There are 2 types of strings here, the names end in Title or Desc L["exampleTitle"] and L["exampleDesc"].
--Title must not be any longer than 21 characters (maybe less for chinese characters because they are larger).
--Desc can be any length.

---Description at the top---
L["mainTextDesc"] = "Escribe /wb para mostrarte los temporizadores.\nEscribe /wb <canal> para mostrar los temporizadores del canal especificado.\nDesplácese hacia abajo para ver más opciones.";

---Show Buffs Button
L["showBuffsTitle"] = "Beneficios actuales";
L["showBuffsDesc"] = "Muestra tus beneficios de mundo actuales para todos tus personajes; esto también se puede abrir escribiendo /buffs o haciendo clic en el prefijo [WorldBuffs] en el chat.";

---General Options---
L["generalHeaderDesc"] = "Opciones generales";

L["showWorldMapMarkersTitle"] = "Temporizadores de mapa de ciudad";
L["showWorldMapMarkersDesc"] = "¿Muestra iconos de temporizador en el mapa del mundo de Orgrimmar/Ventormenta?";

L["receiveGuildDataOnlyTitle"] = "Datos de hermandad";
L["receiveGuildDataOnlyDesc"] = "Esto hará que no obtengas datos del temporizador de nadie fuera de la hermandad. Sólo debes activar esto si crees que alguien está falsificando datos incorrectos del temporizador a propósito porque reducirá la precisión de tus temporizadores al tener menos personas de quienes extraer datos. Será especialmente difícil conseguir temporizadores de cantaflores porque son muy cortos. Cada persona en la hermandad necesita que esto esté activado para que funcione.";

L["chatColorTitle"] = "Color de mensaje de chat";
L["chatColorDesc"] = "¿De qué color debe ser el mensaje del temporizador en el chat?";

L["middleColorTitle"] = "Color de pantalla media";
L["middleColorDesc"] = "¿De qué color debería ser el mensaje de estilo de aviso de banda en el medio de la pantalla?";

L["resetColorsTitle"] = "Restablecer colores";
L["resetColorsDesc"] = "Restablece los colores a los valores predeterminados.";

L["showTimeStampTitle"] = "Marca de tiempo";
L["showTimeStampDesc"] = "¿Muestra una marca de tiempo (1:23 p.m.) al lado del mensaje del temporizador?";

L["timeStampFormatTitle"] = "Formato de marca de tiempo";
L["timeStampFormatDesc"] = "Establece qué formato de marca de tiempo usar, 12 horas (1:23 p.m.) o 24 horas (13:23).";

L["timeStampZoneTitle"] = "Hora local / Hora del reino";
L["timeStampZoneDesc"] = "¿Usa la hora local o la hora del reino para las marcas de tiempo?";

L["colorizePrefixLinksTitle"] = "Enlace coloreado";
L["colorizePrefixLinksDesc"] = "¿Colorea el prefijo [WorldBuffs] en todos los canales de chat? Este es el prefijo en el chat en el que puedes hacer clic para mostrar a todos tus personajes los beneficios de mundo actuales.";

L["showAllAltsTitle"] = "Mostrar todos alts";
L["showAllAltsDesc"] = "¿Muestra todos los alts en la ventana /buffs incluso si no tienen un beneficio activo?";

L["minimapButtonTitle"] = "Botón de minimapa";
L["minimapButtonDesc"] = "¿Muestra el botón NWB en el minimapa?";

---Logon Messages---
L["logonHeaderDesc"] = "Mensajes al conectarse";

L["logonPrintTitle"] = "Temporizadores";
L["logonPrintDesc"] = "Muestra temporizadores en la ventana de chat cuando te conectas; puedes desactivar todos los mensajes de inicio de sesión con esta configuración.";

--L["logonRendTitle"] = "Rend";
--L["logonRendDesc"] = "Muestra el temporizador de Rend en la ventana de chat cuando te conectas.";

L["logonOnyTitle"] = "Onyxia";
L["logonOnyDesc"] = "Muestra el temporizador de Onyxia en la ventana de chat cuando te conectas.";

L["logonNefTitle"] = "Nefarian";
L["logonNefDesc"] = "Muestra el temporizador de Nefarian en la ventana de chat cuando te conectas.";

L["logonDmfSpawnTitle"] = "Aparición de Feria";
L["logonDmfSpawnDesc"] = "Muestra el tiempo de aparición de la Feria de la Luna Negra; esto solo se mostrará cuando queden menos de 6 horas para que aparezca o desaparezca.";

L["logonDmfBuffCooldownTitle"] = "Reutilización de Feria";
L["logonDmfBuffCooldownDesc"] = "Muestra el tiempo de reutilización de 4 horas del beneficio de la Feria de la Luna Negra, esto solo se mostrará cuando tengas un tiempo de reutilización activo y cuando la Feria de la Luna Negra esté activa.";

---Chat Window Timer Warnings---
L["chatWarningHeaderDesc"] = "Anuncios del temporizador en la ventana de chat";

L["chat30Title"] = "30 Minutos";
L["chat30Desc"] = "Imprime un mensaje en el chat cuando queden 30 minutos.";

L["chat15Title"] = "15 Minutos";
L["chat15Desc"] = "Imprime un mensaje en el chat cuando queden 15 minutos.";

L["chat10Title"] = "10 Minutos";
L["chat10Desc"] = "Imprime un mensaje en el chat cuando queden 10 minutos.";

L["chat5Title"] = "5 Minutos";
L["chat5Desc"] = "Imprime un mensaje en el chat cuando queden 5 minutos.";

L["chat1Title"] = "1 Minuto";
L["chat1Desc"] = "Imprime un mensaje en el chat cuando quede 1 minuto.";

L["chatResetTitle"] = "Beneficio restablecido";
L["chatResetDesc"] = "Imprime un mensaje en el chat cuando se restablece un beneficio";

L["chatZanTitle"] = "Beneficio Zandalar";
L["chatZanDesc"] = "Imprime un mensaje en el chat 30 segundos antes de que empieza el beneficio de Zandalar cuando el PNJ comience a gritar.";

---Middle Of The Screen Timer Warnings---
L["middleWarningHeaderDesc"] = "Anuncios del temporizador en el medio de la pantalla";

L["middle30Title"] = "30 Minutos";
L["middle30Desc"] = "Muestra un mensaje de estilo de aviso de banda en el medio de la pantalla cuando queden 30 minutos.";

L["middle15Title"] = "15 Minutos";
L["middle15Desc"] = "Muestra un mensaje de estilo de aviso de banda en el medio de la pantalla cuando queden 15 minutos.";

L["middle10Title"] = "10 Minutos";
L["middle10Desc"] = "Muestra un mensaje de estilo de aviso de banda en el medio de la pantalla cuando queden 10 minutos.";

L["middle5Title"] = "5 Minutos";
L["middle5Desc"] = "Muestra un mensaje de estilo de aviso de banda en el medio de la pantalla cuando queden 5 minutos.";

L["middle1Title"] = "1 Minuto";
L["middle1Desc"] = "Muestra un mensaje de estilo de aviso de banda en el medio de la pantalla cuando quede 1 minuto.";

L["middleResetTitle"] = "Beneficio restablecido";
L["middleResetDesc"] = "Muestra un mensaje de estilo de aviso de banda en el medio de la pantalla se restablece un beneficio";

L["middleBuffWarningTitle"] = "Anuncio de beneficio";
L["middleBuffWarningDesc"] = "Muestra un mensaje de estilo de aviso de banda en el medio de la pantalla cuando alguien entregue la cabeza y el PNJ grita unos segundos antes de que empieza el beneficio.";

L["middleHideCombatTitle"] = "Ocultar en combate";
L["middleHideCombatDesc"] = "¿Oculta los anuncios en medio de la pantalla en combate?";

L["middleHideRaidTitle"] = "Ocultar en banda";
L["middleHideRaidDesc"] = "¿Oculta los anuncios en el medio de la pantalla en bandas? (No se oculta en calabozos)";

---Guild Messages---
L["guildWarningHeaderDesc"] = "Mensajes de hermandad";

L["guild10Title"] = "10 Minutos";
L["guild10Desc"] = "Envía un mensaje al chat de hermandad cuando queden 10 minutos.";

L["guild1Title"] = "1 Minuto";
L["guild1Desc"] = "Envía un mensaje al chat de hermandad cuando queden 1 minuto.";

L["guildNpcDialogueTitle"] = "Diálogo iniciado";
L["guildNpcDialogueDesc"] = "¿Envía un mensaje a la hermandad cuando alguien entregue una cabeza y el PNJ grite primero y todavía tienes tiempo para volver a iniciar sesión si eres rápido?";

L["guildBuffDroppedTitle"] = "Nuevo beneficio";
--L["guildBuffDroppedDesc"] = "¿Envía un mensaje a la hermandad cuando se haya empezado un nuevo beneficio? Este mensaje se envía después de que el PNJ termina de gritar y obtienes el beneficio real unos segundos después. (6 segundos después del primer grito para Rend, 14 segundos para Onyxia, 15 segundos para Nefarian)";

L["guildZanDialogueTitle"] = "Beneficio Zandalar";
L["guildZanDialogueDesc"] = "¿Envía un mensaje a la hermandad cuando el beneficio del Espíritu de Zandalar esté a punto de empezar? (Si no quieres ningún mensaje de hermandad para este beneficio, entonces todos en la hermandad deben desactivarlo).";

L["guildNpcKilledTitle"] = "PNJ matado";
L["guildNpcKilledDesc"] = "¿Envía un mensaje a la hermandad cuando uno de los PNJs fueron asesinado en Orgrimmar o Ventormenta? (reinicio del control mental).";

L["guildCommandTitle"] = "Comandos";
L["guildCommandDesc"] = "¿Responde con información del temporizador a los comandos !wb y !dmf en el chat de la hermandad? Probablemente deberías dejar esto activado para ayudar a tu hermandad, si realmente quieres desactivar todos los mensajes de la hermandad y dejar solo este comando, entonces desmarca todo lo demás en la sección de la hermandad y no marques Actviar todos los mensajes de la hermandad en la parte superior.";

L["disableAllGuildMsgsTitle"] = "Desactivar";
L["disableAllGuildMsgsDesc"] = "¿Desactiva todos los mensajes de la hermandad, incluidos los temporizadores y cuándo caen los beneficios? Nota: Puedes desactivar todos los mensajes uno por uno arriba y simplemente dejar ciertas cosas activadas para ayudar a tu hermandad si así lo prefieres.";

---Songflowers---
L["songflowersHeaderDesc"] = "Cantaflores";

L["guildSongflowerTitle"] = "Hermandad";
L["guildSongflowerDesc"] = "¿Cuéntale a tu chat de hermandad cuando hayas recogido una cantaflor?";

L["mySongflowerOnlyTitle"] = "Recoger";
L["mySongflowerOnlyDesc"] = "¿Graba un nuevo temporizador solo cuando recojo una cantaflora y no cuando otros recogen frente a mí? Esta opción está aquí en caso de que tengas problemas con temporizadores falsos configurados por otros jugadores. Actualmente no hay forma de saber si el beneficio de otro jugador es nuevo, por lo que se puede activar un temporizador en raras ocasiones si el juego carga el beneficio de cantaflora en otra persona cuando inicia sesión frente a ti junto a una cantaflora.";

L["syncFlowersAllTitle"] = "Sincronizar";
L["syncFlowersAllDesc"] = "Activa esto para anular la configuración de datos de sola hermandad en la parte superior de esta configuración para que puedas compartir datos de cantaflor fuera de la hermandad pero mantener solo los datos de la hermandad de beneficio de mundo.";

L["showNewFlowerTitle"] = "Nuevas cantaflores";
L["showNewFlowerDesc"] = "Esto te mostrará en la ventana de chat cuando se encuentre un nuevo temporizador de flores de otro jugador que no esté en tu hermandad (los mensajes de la hermandad ya se muestran en el chat de la hermandad cuando se recoge una flor).";

L["showSongflowerWorldmapMarkersTitle"] = "Cantaflor mapa";
L["showSongflowerWorldmapMarkersDesc"] = "¿Muestra iconos de cantaflores en el mapa del mundo?";

L["showSongflowerMinimapMarkersTitle"] = "Cantaflor minimapa";
L["showSongflowerMinimapMarkersDesc"] = "¿Muestra iconos de cantaflores en el minimapa?";

L["showTuberWorldmapMarkersTitle"] = "Tubérculo mapa";
L["showTuberWorldmapMarkersDesc"] = "¿Muestra iconos de tubérculos en el mapa del mundo?";

L["showTuberMinimapMarkersTitle"] = "Tubérculo minimapa";
L["showTuberMinimapMarkersDesc"] = "¿Muestra iconos de tubérculos en el minimapa?";

L["showDragonWorldmapMarkersTitle"] = "Aliento mapa";
L["showDragonWorldmapMarkersDesc"] = "¿Muestra iconos de aliento de dragón nocturno en el mapa del mundo?";

L["showDragonMinimapMarkersTitle"] = "Aliento minimapa";
L["showDragonMinimapMarkersDesc"] = "¿Muestra iconos de aliento de dragón nocturno en el minimapa?";

L["showExpiredTimersTitle"] = "Caducado";
L["showExpiredTimersDesc"] = "¿Muestra temporizadores caducados en Frondavil? Se mostrarán en texto rojo cuánto tiempo hace que expiró un temporizador, el tiempo predeterminado es 5 minutos (¿la gente dice que las cantaflores permanecen limpias durante 5 minutos después de la aparicíon?).";

L["expiredTimersDurationTitle"] = "Duración";
L["expiredTimersDurationDesc"] = "¿Cuánto tiempo deberían mostrar los temporizadores de Frondavil después de expirar en el mapa del mundo?";

---Darkmoon Faire---
L["dmfHeaderDesc"] = "Feria de la Luna Negra";

L["dmfTextDesc"] = "El tiempo de reutilización del beneficio de daño de la Feria de la Luna Negra también se mostrará en el icono del mapa de la Feria de la Luna Negra cuando lo coloques sobre él, si tienes un tiempo de reutilización y la Feria está actualmente activo.";

L["showDmfWbTitle"] = "Mostrar Feria con /wb";
L["showDmfWbDesc"] = "¿Muestra el temporizador de aparición de la Feria de la Luna Negra junto con el comando /wb?";

L["showDmfBuffWbTitle"] = "Reutilización /wb";
L["showDmfBuffWbDesc"] = "¿Muestra el temporizador de reutilización del beneficio de la Feria de la Luna Negra junto con el comando /wb? Solo se muestra cuando estás en un tiempo de reutilización activo y la Feria está actualmente activo.";

L["showDmfMapTitle"] = "Marcador del mapa";
L["showDmfMapDesc"] = "Muestra el marcador de mapa de la Feria con temporizador de aparición e información de tiempo de reutilización de beneficios en los mapas de Mulgore y Bosque de Elwynn (lo que ocurra a continuación). También puedes escribir /dmf map para abrir el mapa hacia este marcador.";

---Guild Chat Filter---
L["guildChatFilterHeaderDesc"] = "Filtro del chat de hermandad";

L["guildChatFilterTextDesc"] = "Esto bloqueará cualquier mensaje de la hermandad de este addon que elijas para que no los veas. Evitará que veas tus propios mensajes y los mensajes de otros usuarios del addon en el chat de la hermandad.";

L["filterYellsTitle"] = "Anuncio";
L["filterYellsDesc"] = "Filtra el mensaje cuando un beneficio esté a punto de caer en unos segundos (Onyxia caerá en 14 segundos).";

L["filterDropsTitle"] = "Beneficio caído";
L["filterDropsDesc"] = "Filtra el mensaje cuando se ha caído un beneficio (Se ha caído el Berrido de convocación del matadragones (Onyxia)).";

L["filterTimersTitle"] = "Temporizador";
L["filterTimersDesc"] = "Filtra mensajes del temporizador (Onyxia se reinicia en 1 minuto).";

L["filterCommandTitle"] = "Comando !wb";
L["filterCommandDesc"] = "Filtra !wb y !dmf en el chat del gremio cuando los jugadores escriben.";

L["filterCommandResponseTitle"] = "Repuesta !wb";
L["filterCommandResponseDesc"] = "Filtra el mensaje de respuesta con temporizadores que hace este addon cuando se usa !wb o !dmf.";

L["filterSongflowersTitle"] = "Cantaflores";
L["filterSongflowersDesc"] = "Filtra el mensaje cuando se recoge una cantaflor.";

L["filterNpcKilledTitle"] = "PNJ matado";
L["filterNpcKilledDesc"] = "Filtra el mensaje cuando se le entrega a un PNJ en tu ciudad.";

---Sounds---
L["soundsHeaderDesc"] = "Sonidos";

L["soundsTextDesc"] = "Establece el sonido en \"Ninguno\" para desactivarlo.";

L["disableAllSoundsTitle"] = "Desactivar sonidos";
L["disableAllSoundsDesc"] = "Desactiva todos los sonidos de este addon.";

L["extraSoundOptionsTitle"] = "Opciones adicionales";
L["extraSoundOptionsDesc"] = "Activa esto para mostrar todos los sonidos de todos tus addons a la vez en las listas desplegables aquí.";

L["soundOnlyInCityTitle"] = "Sólo en ciudad";
L["soundOnlyInCityDesc"] = "Sólo reproduce sonidos de beneficio cuando estés en la ciudad principal donde caen los beneficios (Vega de Tuercespina incluido para el beneficio de Zandalar).";

L["soundsDisableInInstancesTitle"] = "Estancias";
L["soundsDisableInInstancesDesc"] = "Desactiva sonidos mientras estás en bandas o estancias.";

L["soundsFirstYellTitle"] = "Beneficio entrante";
L["soundsFirstYellDesc"] = "Suena cuando se entrega la cabeza y tienes unos segundos antes de que empieza el beneficio (primer grito de PNJ).";

L["soundsOneMinuteTitle"] = "Anuncio de un minuto";
L["soundsOneMinuteDesc"] = "Se reproducirá un sonido durante el anuncio del temporizador restantes de 1 minuto.";

--L["soundsRendDropTitle"] = "Beneficio de Rend";
--L["soundsRendDropDesc"] = "Sonido para reproducir para Rend cuando obtienes el beneficio.";

L["soundsOnyDropTitle"] = "Beneficio de Onyxia";
L["soundsOnyDropDesc"] = "Sonido para reproducir para Onyxia cuando obtienes el beneficio.";

L["soundsNefDropTitle"] = "Beneficio de Nefarian";
L["soundsNefDropDesc"] = "Sonido para reproducir para Nefarian cuando obtienes el beneficio.";

L["soundsZanDropTitle"] = "Beneficio de Zandalar";
L["soundsZanDropDesc"] = "Sonido para reproducir para Zandalar cuando obtienes el beneficio.";

---Flash When Minimized---
L["flashHeaderDesc"] = "Destellar cuando está minimizado";

L["flashOneMinTitle"] = "Un minuto";
L["flashOneMinDesc"] = "¿Destella el cliente wow cuando lo tienes minimizado y queda 1 minuto en el temporizador?";

L["flashFirstYellTitle"] = "Grito de PNJ";
L["flashFirstYellDesc"] = "¿Destella el cliente wow cuando lo tienes minimizado y el PNJ grita unos segundos antes de que caiga el beneficio?";

L["flashFirstYellZanTitle"] = "Zandalar";
L["flashFirstYellZanDesc"] = "¿Destella el cliente wow cuando lo tienes minimizado y el beneficio de Zandalar está a punto de caer?";

---Faction/realm specific options---

--L["allianceEnableRendTitle"] = "Rend para Alianza";
--L["allianceEnableRendDesc"] = "Activa esto para realizar un seguimiento del Rend como Alianza, para que las hermandades que tienen control mental obtengan un beneficio de Rend. Si usas esto, entonces todos en la hermandad con el addon deberían activarlo o los mensajes de chat de la hermandad podrían no funcionar correctamente (los mensajes del temporizador personal seguirán funcionando).";

L["minimapLayerFrameTitle"] = "Capa en minimapa";
L["minimapLayerFrameDesc"] = "¿Muestra el marco en el minimapa con tu capa actual?";

L["minimapLayerFrameResetTitle"] = "Restablecer minimapa";
L["minimapLayerFrameResetDesc"] = "Restablece el marco de la capa del minimapa a la posición predeterminada (mantenga presionada la tecla Mayús para arrastrar el marco del minimapa).";

---Dispels---
L["dispelsHeaderDesc"] = "Disipaciones";

L["dispelsMineTitle"] = "Mis beneficios";
L["dispelsMineDesc"] = "¿Muestra en el chat que mis beneficios se están disipando? Esto muestra quién te disipó y qué beneficio.";

L["dispelsMineWBOnlyTitle"] = "Beneficio de mundo";
L["dispelsMineWBOnlyDesc"] = "Solo muestra que mis beneficios de mundo se disipan y ningún otro tipo de beneficio.";

L["soundsDispelsMineTitle"] = "Sonido";
L["soundsDispelsMineDesc"] = "Qué sonido reproducir para que mis beneficios se disipen.";

L["dispelsAllTitle"] = "Beneficios de otros";
L["dispelsAllDesc"] = "¿Muestra en el chat los beneficios de todos los que se disipan a mi alrededor? Esto muestra quién disipó a alguien cercano a ti y qué beneficio.";

L["dispelsAllWBOnlyTitle"] = "Beneficio de mundo de otros";
L["dispelsAllWBOnlyDesc"] = "Solo muestra los beneficios de mundo cuando todos los demás se disipan y ningún otro tipo de beneficio.";

L["soundsDispelsAllTitle"] = "Sonido para otros jugadores";
L["soundsDispelsAllDesc"] = "Qué sonido reproducir para los beneficios de otros jugadores disipados.";

L["middleHideBattlegroundsTitle"] = "Campo de batalla";
L["middleHideBattlegroundsDesc"] = "¿Oculta los anuncios en el medio de la pantalla en Campos de Batalla?";

L["soundsDisableInBattlegroundsTitle"] = "Campos de batalla";
L["soundsDisableInBattlegroundsDesc"] = "Desactiva los sonidos mientras estás en Campos de Batalla.";


L["autoBuffsHeaderDesc"] = "Seleccionar automáticamente";

L["autoDmfBuffTitle"] = "Seleccionar beneficio";
L["autoDmfBuffDesc"] = "¿Quieres que este addon seleccione automáticamente un beneficio de la Feria de la Luna Negra cuando hables con el PNJ Sayge? Asegúrate de elegir qué beneficio quieres también.";

L["autoDmfBuffTypeTitle"] = "Qué beneficio";
L["autoDmfBuffTypeDesc"] = "¿Qué beneficio de la Feria de la Luna Negra quieres que este addon seleccione automáticamente cuando hablas con Sayge?";

L["autoDireMaulBuffTitle"] = "La Masacre";
L["autoDireMaulBuffDesc"] = "¿Quieres que este addon obtenga automáticamente beneficios de los PNJs en La Masacre cuando hablas con ellos? (También obtiene el beneficio del Rey).";

L["autoBwlPortalTitle"] = "Portal de Alanegra";
L["autoBwlPortalDesc"] = "¿Quieres que este addon utilice automáticamente el portal de Guarida Alanegra cuando haces clic en el orbe?";

L["showBuffStatsTitle"] = "Estadísticas";
--L["showBuffStatsDesc"] = "¿Muestra cuántas veces has obtenido cada beneficio en el marco /buffs? Los beneficios de Ony/Nef/Rend/Zand se han estado grabando desde que se instaló el marco de beneficios, pero el resto de los beneficios solo comenzaron a grabar ahora en la versión 1.65.";

L["buffResetButtonTooltip"] = "Esto restablecerá todos los beneficios.\nLos datos del recuento de beneficios no se restablecerán."; --Reset button tooltip for the /buffs frame.
L["time"] = "(%s vez)"; --Singular - This shows how many timers you got a buff. Example: (1 time)
L["times"] = "(%s veces)"; --Plural - This shows how many timers you got a buff. Example: (5 times)
L["flowerWarning"] = "Cantaflor recogió en un reino con temporizadores de cantaflor en capas activados, pero no has apuntado a ningún PNJ desde que llegaste a Frondavil, por lo que no se pudo grabar ningún temporizador.";

L["mmColorTitle"] = "Color de capa de minimapa";
L["mmColorDesc"] = "¿De qué color debe ser el texto de la capa del minimapa? (Capa 1)";

L["layerHasBeenDisabled"] = "Desactivó capa %s, esta capa todavía está en la base de datos pero será ignorada hasta que la actives nuevamente o se detecte nuevamente como válida.";
L["layerHasBeenEnabled"] = "Activó capa %s, esto ahora está de nuevo en los cálculos de capas y temporizadores.";
L["layerDoesNotExist"] = "La ID de la capa %s no existe en la base de datos.";
L["enableLayerButton"] = "Activar capa";
L["disableLayerButton"] = "Desactivar capa";
L["enableLayerButtonTooltip"] = "Haz clic para volver a activar esta capa,\nSe volverá a poner en el temporizador y en los cálculos de capas.";
L["disableLayerButtonTooltip"] = "Haz clic para desactivar la capa antigua tras reiniciar el servidor.\nEl addon lo ignorará y lo eliminará más tarde.";

L["minimapLayerHoverTitle"] = "Pasar el ratón";
L["minimapLayerHoverDesc"] = "¿Muestra sólo el marco numérico de la capa del minimapa cuando pasas el ratón sobre el minimapa?";

L["Blackrock Mountain"] = "Montaña Roca Negra";

L["soundsNpcKilledTitle"] = "PNJ matado";
L["soundsNpcKilledDesc"] = "Sonido que se reproducirá cuando se mate a un PNJ que ortorga un beneficio para restablecer un temporizador.";

L["autoDmfBuffCharsText"] = "Configuración de beneficios para cada personaje:";

L["middleNpcKilledTitle"] = "PNJ matado";
L["middleNpcKilledDesc"] = "Muestra un mensaje de estilo de aviso de banda en el medio de la pantalla cuando un PNJ muere para restablecer el beneficio.";

L["chatNpcKilledTitle"] = "PNJ matado";
L["chatNpcKilledDesc"] = "Muestra un mensaje en chat cuando un PNJ muere para restablecer el beneficio.";

L["onyxiaNpcRespawnHorde"] = "PNJ de Onyxia (Runthak) reaparecerá en un momento aleatorio dentro de los próximos 2 minutos.";
L["nefarianNpcRespawnHorde"] = "PNJ de Nefarian (Colmillosauro) reaparecerá en un momento aleatorio dentro de los próximos 2 minutos.";
L["onyxiaNpcRespawnAlliance"] = "PNJ de Onyxia (Mattingly) reaparecerá en un momento aleatorio dentro de los próximos 2 minutos.";
L["nefarianNpcRespawnAlliance"] = "PNJ de Nefarian (Afrasiabi) reaparecerá en un momento aleatorio dentro de los próximos 2 minutos.";

L["onyxiaNpcKilledHordeWithTimer2"] = "El PNJ de Onyxia (Runthak) fue asesinado hace %s, reaparecerá en %s.";
L["nefarianNpcKilledHordeWithTimer2"] = "El PNJ de Nefarian (Colmillosauro) fue asesinado hace %s, reaparecerá en %s.";
L["onyxiaNpcKilledAllianceWithTimer2"] = "El PNJ de Onyxia (Mattingly) fue asesinado hace %s, reaparecerá en %s.";
L["nefarianNpcKilledAllianceWithTimer2"] = "El PNJ de Nefarian (Afrasiabi) fue asesinado hace %s, reaparecerá en %s.";

L["flashNpcKilledTitle"] = "Destello";
L["flashNpcKilledDesc"] = "¿Destella el cliente wow cuando se mata a un PNJ que ortorga un beneficio?";

L["trimDataHeaderDesc"] = "Limpio de datos";

L["trimDataBelowLevelTitle"] = "Nivel máximo para eliminar";
L["trimDataBelowLevelDesc"] = "Selecciona el nivel máximo de personajes para eliminar de la base de datos; se eliminarán todos los personajes de este nivel y los inferiores.";

L["trimDataBelowLevelButtonTitle"] = "Eliminar personajes";
L["trimDataBelowLevelButtonDesc"] = "Haz clic en este botón para eliminar todos los personajes con el nivel seleccionado e inferior de esta base de datos adicional. Nota: Esto elimina los datos del recuento de beneficios de forma permanente.";

L["trimDataTextDesc"] = "Eliminar varios personajes de la base de datos de beneficios:";
L["trimDataText2Desc"] = "Eliminar un personaje de la base de datos de beneficios:";

L["trimDataCharInputTitle"] = "Eliminar un personaje entrada";
L["trimDataCharInputDesc"] = "Escribe aquí un personaje para eliminar, formatee como Nombre-Reino (distingue entre mayúsculas y minúsculas). Nota: Esto elimina los datos del recuento de beneficios de forma permanente.";

L["trimDataBelowLevelButtonConfirm"] = "¿Estás seguro de que deseas eliminar todos los personajes por debajo del nivel %s de la base de datos?";
L["trimDataCharInputConfirm"] = "¿Estás seguro de que deseas eliminar este personaje %s de la base de datos?";

L["trimDataMsg1"] = "Se han restablecido los registros de beneficios."
L["trimDataMsg2"] = "Eliminando todos los personajes por debajo del nivel %s.";
L["trimDataMsg3"] = "Eliminados: %s.";
L["trimDataMsg4"] = "Hecho, no se encontraron personajes.";
L["trimDataMsg5"] = "Hecho, se eliminó %s personajes.";
L["trimDataMsg6"] = "Entra un nombre de personaje válido para eliminar de la base de datos.";
L["trimDataMsg7"] = "El nombre de este personaje %s no incluye un reino, entra Nombre-Reino.";
L["trimDataMsg8"] = "Error al eliminar %s de la base de datos, personaje no encontrado (el nombre distingue entre mayúsculas y minúsculas).";
L["trimDataMsg9"] = "Eliminó %s de la base de datos.";

L["serverTime"] = "hora del reino";
L["serverTimeShort"] = "st";

L["showUnbuffedAltsTitle"] = "Alts sin beneficios";
L["showUnbuffedAltsDesc"] = "¿Muestra alts sin beneficios en la ventana de beneficios? Esto es para que puedas ver qué personajes no tienen beneficios si lo deseas.";

L["timerWindowWidthTitle"] = "Anchura de la ventana del temporizador";
L["timerWindowWidthDesc"] = "¿Qué tan amplia debe ser la ventana del temporizador?";

L["timerWindowHeightTitle"] = "Altura de la ventana del temporizador";
L["timerWindowHeightDesc"] = "¿Qué tan alta debe ser la ventana del temporizador?";

L["buffWindowWidthTitle"] = "Anchura de la ventana de beneficio";
L["buffWindowWidthDesc"] = "¿Qué tan amplia debe ser la ventana de beneficio?";

L["buffWindowHeightTitle"] = "Altura de la ventana de beneficio";
L["buffWindowHeightDesc"] = "¿Qué tan alta debe ser la ventana de beneficio?";

L["dmfSettingsListTitle"] = "Lista de beneficios";
L["dmfSettingsListDesc"] = "Haz clic aquí para mostrar una lista de tus configuraciones de tipo de beneficio de la Feria de la Luna Negra de tus alts.";

L["ignoreKillDataTitle"] = "Ignorar datos de PNJ";
L["ignoreKillDataDesc"] = "Ignora cualquier dato de PNJ asesinado para que no se registren.";
			
L["noOverwriteTitle"] = "No sobrescribir";
L["noOverwriteDesc"] = "Puedes activar esto para que, si ya tienes un temporizador válido en ejecución, ignoras cualquier dato nuevo para ese temporizador hasta que finalice.";

L["layerMsg1"] = "Estás en un reino con capas.";
L["layerMsg2"] = "Haz clic aquí para ver los temporizadores actuales.";
L["layerMsg3"] = "Apunta a cualquier PNJ para ver tu capa actual.";
L["layerMsg4"] = "Apunta a cualquier PNJ en %s para ver tu capa actual."; --Target any NPC in Orgrimmar to see your current layer.

--NOTE: Darkmoon Faire buff type is now a character specific setting, changing buff type will only change it for this character.
L["note"] = "NOTA:";
L["dmfConfigWarning"] = "El tipo de beneficio de la Feria de la Luna Negra ahora es una configuración específica del personaje; cambiar el tipo de beneficio sólo lo cambiará para este personaje.";

---New---

L["onyNpcMoving"] = "¡El PNJ de Onyxia ha comenzado a caminar!";
L["nefNpcMoving"] = "¡El PNJ de Nefarian ha comenzado a caminar!";

L["buffHelpersHeaderDesc"] = "Ayudantes de beneficio para servidores JcJ";

L["buffHelpersTextDesc"] = "Ayudantes de beneficio para servidores JcJ (se activarán si obtienes un beneficio y realizas una de estas acciones dentro de los segundos establecidos después de obtener el beneficio; puedes ajustar los segundos a continuación).";
L["buffHelpersTextDesc2"] = "\nBeneficio de Zandalar";
L["buffHelpersTextDesc3"] = "Beneficio de la Feria de la Luna Negra";
L["buffHelpersTextDesc4"] = "Ingresa macro de campo de batalla (debes presionar esto dos veces para que funcione, así que simplemente envía spam; esto eliminará la cola si aún no tienes una ventana emergente, así que ten cuidado de no presionarlo antes).\n|cFF9CD6DE/click DropDownList1Button2\n/click MiniMapBatlefieldFrame RightButton";

L["takeTaxiZGTitle"] = "Vuelo automático";
L["takeTaxiZGDesc"] = "Toma automáticamente una ruta de vuelo desde Bahía del Botín tan pronto como caiga un beneficio, puedes hablar con el PNJ de vuelo después de la caída o tenerlo ya abierto cuando caiga, funcionará en ambos sentidos. |cFF00C800(Puedes obtener el beneficio en fantasma, por lo que te sugiero sentarte en fantasma hasta que el beneficio disminuya y luego presionar y hablar con el PNJ de vuelo para volar automáticamente)";

L["takeTaxiNodeTitle"] = "Destino";
L["takeTaxiNodeDesc"] = "Si tienes activada la opción de ruta de vuelo automática, ¿adónde quieres volar?";
			
L["dmfVanishSummonTitle"] = "Invocación al Esfumar";
L["dmfVanishSummonDesc"] = "Pícaros: ¿Aceptas automáticamente la invocación tan pronto como esfumas después de obtener el beneficio de Feria de la Luna Negra?";

L["dmfFeignSummonTitle"] = "Invocación al Fingir muerte";
L["dmfFeignSummonDesc"] = "Cazadores: ¿Aceptas automáticamente la invocación tan pronto como finges muerte después de obtener el beneficio de Feria de la Luna Negra?";
			
L["dmfCombatSummonTitle"] = "Invocación al salir combate";
L["dmfCombatSummonDesc"] = "¿Aceptas automáticamente la invocación tan pronto como sales combate después de obtener el beneficio de Feria de la Luna Negra?";
			
L["dmfLeaveBGTitle"] = "Salir automáticamente del campo de batalla";
L["dmfLeaveBGDesc"] = "¿Sales automáticamente de tu campo de batalla al entrar en zonas después de obtener el beneficio de Feria de la Luna Negra?";

L["dmfGotBuffSummonTitle"] = "Invocación con Feria";
L["dmfGotBuffSummonDesc"] = "Acepta automáticamente cualquier invocación pendiente cuando obtienes el beneficio de la Feria de la Luna Negra.";

L["zgGotBuffSummonTitle"] = "Invocación con ZG";
L["zgGotBuffSummonDesc"] = "Acepta automáticamente cualquier invocación pendiente cuando obtienes el beneficio de Zandalar.";

L["buffHelperDelayTitle"] = "¿Cuántos segundos están activados los ayudantes?";
L["buffHelperDelayDesc"] = "¿Durante cuántos segundos después de obtener un beneficio deberían trabajar estos ayudantes? Esto es para que puedes dejar las opciones activadas y sólo funcionarán inmediatamente después de obtener un beneficio.";

L["showNaxxWorldmapMarkersTitle"] = "Naxxramas mapa";
L["showNaxxWorldmapMarkersDesc"] = "¿Muestra el marcador de Naxxramas en el mapa del mundo?";

L["showNaxxMinimapMarkersTitle"] = "Naxxramas minimapa";
L["showNaxxMinimapMarkersDesc"] = "¿Muestra el marcador de Naxxramas en el minimapa? Esto también te mostrará la dirección de regreso a naxx cuando eres un fantasma y mueres dentro de la estancia.";

L["bigWigsSupportTitle"] = "Compatibilidad BW";
L["bigWigsSupportDesc"] = "¿Inicia una barra de temporizador para obtener beneficios si BigWigs está instalado? El mismo tipo de barra de temporizador que hace DBM.";

L["soundsNpcWalkingTitle"] = "PNJ caminando";
L["soundsNpcWalkingDesc"] = "¿Suena cuando un PNJ de beneficio comienza a caminar en Orgrimmar?";

L["buffHelpersTextDesc4"] = "Beneficio de Cantaflor";
L["songflowerGotBuffSummonTitle"] = "Invocación cantaflor";
L["songflowerGotBuffSummonDesc"] = "Acepta automáticamente cualquier invocación pendiente cuando obtienes un beneficio de cantaflor.";

--L["buffHelpersTextDesc5"] = "Beneficio de Ony/Rend";
--L["cityGotBuffSummonTitle"] = "Invocación Ony/Rend";
--L["cityGotBuffSummonDesc"] = "Acepta automáticamente cualquier invocación pendiente cuando obtienes un beneficio de Ony/Nef/Rend.";

--L["heraldFoundCrossroads"] = "¡Heraldo encontrado! Beneficio de Rend en El Cruce caerá en 20 segundos.";
--L["heraldFoundTimerMsg"] = "Beneficio de Rend en El Cruce"; --DBM/Bigwigs timer bar text.

L["guildNpcWalkingTitle"] = "PNJ caminando";
L["guildNpcWalkingDesc"] = "¿Envia un mensaje a la hermandad y reproduce un sonido cuando activas o recibes una alerta de caminata de NPJ? (Abre el diálogo de chat con los PNJs de Ony/Nef en Orgrimmar y espera a que alguien entregue la cabeza para activar esta alerta temprana).";

L["buffHelpersTextDesc6"] = "Ventana de ayuda de la Feria de la Luna Negra";
L["dmfFrameTitle"] = "Ayuda de Feria";
L["dmfFrameDesc"] = "Una ventana que aparece cuando te acercas a Sayge en Feria mientras eres un fantasma en los servidores JcJ ayuda con las funciones atascadas de Blizzard.";

L["Sheen of Zanza"] = "Brillo de Zanza";
L["Spirit of Zanza"] = "Espíritu de Zanza";
L["Swiftness of Zanza"] = "Rapidez de Zanza";

L["Mind Control"] = "Control mental";
L["Gnomish Mind Control Cap"] = "Gorra de control mental gnoma";


L["tbcHeaderText"] = "Opciones de expansión";
L["tbcNoteText"] = "Nota: Todos los mensajes del chat de la hermandad también están desactivados en los reinos TBC.";

L["disableSoundsAboveMaxBuffLevelTitle"] = "Desactivar sonidos superiores al nivel 64+";
L["disableSoundsAboveMaxBuffLevelDesc"] = "¿Desactivar los sonidos relacionados con los beneficios de mundo para personajes superiores al nivel 63 en reinos TBC?";

L["disableSoundsAllLevelsTitle"] = "Desactivar sonidos de todos los niveles";
L["disableSoundsAllLevelsDesc"] = "Desactiva los sonidos relacionados con los beneficios de mundo para personajes de todos los niveles en los reinos TBC.";

L["disableMiddleAboveMaxBuffLevelTitle"] = "Desactivar mensajes en la pantalla central 64+";
L["disableMiddleAboveMaxBuffLevelDesc"] = "¿Desactiva mensajes relacionados con beneficios de mundo en el medio de la pantalla para personajes por encima del nivel 63 en reinos TBC?";

L["disableMiddleAllLevelsTitle"] = "Desactivar mensajes en la pantalla central todos los niveles";
L["disableMiddleAllLevelsDesc"] = "Desactiva los mensajes relacionados con los beneficios de mundo en el medio de la pantalla para personajes de todos los niveles en los reinos TBC.";

L["disableChatAboveMaxBuffLevelTitle"] = "Desactivar mensajes de la ventana de chat 64+";
L["disableChatAboveMaxBuffLevelDesc"] = "¿Desactiva los mensajes relacionados con el temporizador de beneficio de mundo en la ventana de chat para personajes por encima del nivel 63 en reinos TBC?"

L["disableChatAllLevelsTitle"] = "Desactivar mensajes de la ventana de chat todos los niveles";
L["disableChatAllLevelsDesc"] = "Desactiva los mensajes relacionados con el temporizador de beneficio de mundo en la ventana de chat para personajes de todos los niveles en los reinos TBC.";

L["disableFlashAboveMaxBuffLevelTitle"] = "Desactivar destello del cliente minimizado 64+";
L["disableFlashAboveMaxBuffLevelDesc"] = "¿Desactiva el destello del cliente wow mientras está minimizado para eventos de beneficio de mundo para personajes por encima del nivel 63 en reinos TBC?";

L["disableFlashAllLevelsTitle"] = "Desactivar destello del cliente minimizado todos los niveles";
L["disableFlashAllLevelsDesc"] = "Desactiva el destello del cliente wow mientras está minimizado para eventos de beneficio de mundo para personajes de todos los niveles en reinos TBC.";

L["disableLogonAboveMaxBuffLevelTitle"] = "Desactivar temporizadores de inicio de sesión 64+";
L["disableLogonAboveMaxBuffLevelDesc"] = "¿Desactiva los temporizadores en el chat cuando te conectas para personajes superiores al nivel 63 en reinos TBC?";

L["disableLogonAllLevelsTitle"] = "Desactivar temporizadores de inicio de sesión todos los niveles";
L["disableLogonAllLevelsDesc"] = "Desactiva los temporizadores en el chat cuando te conectas para personajes de todos los niveles en los reinos TBC.";

L["Flask of Fortification"] = "Frasco de fortificación";
L["Flask of Pure Death"] = "Frasco de muerte pura";
L["Flask of Relentless Assault"] = "Frasco de asalto incansable";
L["Flask of Blinding Light"] = "Frasco de Luz cegadora";
L["Flask of Mighty Restoration"] = "Frasco de restauración poderosa";
L["Flask of Chromatic Wonder"] = "Frasco de Maravilla cromática";
L["Fortification of Shattrath"] = "Fortificación de Shattrath";
L["Pure Death of Shattrath"] = "Muerte pura de Shattrath";
L["Relentless Assault of Shattrath"] = "Asalto despiadado de Shattrath";
L["Blinding Light of Shattrath"] = "Luz cegadora de Shattrath";
L["Mighty Restoration of Shattrath"] = "Restauración poderosa de Shattrath";
L["Supreme Power of Shattrath"] = "Poder supremo de Shattrath";
L["Unstable Flask of the Beast"] = "Frasco inestable de la bestia";
L["Unstable Flask of the Sorcerer"] = "Frasco inestable del hechicero";
L["Unstable Flask of the Bandit"] = "Frasco inestable del bandido";
L["Unstable Flask of the Elder"] = "Frasco inestable del anciano";
L["Unstable Flask of the Physician"] = "Frasco inestable del médico";
L["Unstable Flask of the Soldier"] = "Frasco inestable del soldado";

L["Chronoboon Displacer"] = "Reubicador cronológico";

L["Silithyst"] = "Silitista";

L["Gold"] = "Oro";
L["level"] = "Nivel";
L["realmGold"] = "Oro del reino para";
L["total"] = "Total";
L["guild"] = "Hermandad";
L["bagSlots"] = "Casillas de bolsa";
L["durability"] = "Durabilidad";
L["items"] = "Objetos";
L["ammunition"] = "Munición";
L["attunements"] = "Armonizaciones";
L["currentRaidLockouts"] = "Bloqueos de banda actuales";
L["none"] = "Ninguno.";

L["dmfDamagePercent"] = "Este nuevo beneficio de la Feria de la Luna Negra tiene %s%% de daño.";
L["dmfDamagePercentTooltip"] = "NWB detectó esto como %s daño.";

L["guildLTitle"] = "Capas de hermandad";
L["guildLDesc"] = "¿Comparte en qué capa estás con tu hermandad? Puedes ver la lista de capas de tu hermandad con /wb guild";

L["terokkarTimer"] = "Terokkar";
L["terokkarWarning"] = "Las torres del bosque de Terokkar se reiniciará en %s";

L["wintergraspTimer"] = "Conquista del Invierno";
L["wintergraspWarning"] = "Conquista del Invierno comenzará en %s";

L["Nazgrel"] = "Nazgrel";
--L["Hellfire Citadel is ours"] = "Hellfire Citadel is ours";
--L["The time for us to rise"] = "The time for us to rise";
L["Force Commander Danath Trollbane"] = "Comandante en Jefe Danath Aterratrols";
--L["The feast of corruption is no more"] = "The feast of corruption is no more";
--L["Hear me brothers"] = "Hear me brothers";

L["terokkarChat10Title"] = "Terokkar 10 Minutos";
L["terokkarChat10Desc"] = "Imprime un mensaje en el chat cuando queden 10 minutos en las torres espirituales de Terokkar.";

L["terokkarMiddle10Title"] = "Terokkar 10 Minutos";
L["terokkarMiddle10Desc"] = "Muestra un mensaje de estilo de aviso de banda en el medio de la pantalla cuando quedan 10 minutos en las torres espirituales de Terokkar.";

L["showShatWorldmapMarkersTitle"] = "Mapa de diarios";
L["showShatWorldmapMarkersDesc"] = "¿Muestra marcadores diarios de calabozos en el mapa del mundo de la ciudad capital?";

L["disableBuffTimersMaxBuffLevelTitle"] = "Desactivar los temporizadores de beneficio del minimapa 64+";
L["disableBuffTimersMaxBuffLevelDesc"] = "¿Oculta los temporizadores de beneficio de mundo cuando pasas el cursor sobre el icono del minimapa para personajes de nivel 64+? Solo verás los temporizadores y diarios de la torre Terokkar, etc.";

L["hideMinimapBuffTimersTitle"] = "Desactivar los temporizadores de beneficio del minimapa todos los niveles";
L["hideMinimapBuffTimersDesc"] = "¿Oculta los temporizadores de beneficio del mundo cuando pasas el cursor sobre el icono del minimapa para personajes de todos los niveles? Solo verás los temporizadores y diarios de la torre Terokkar, etc.";

L["guildTerok10Title"] = "Hermandad Terokkar/CI 10 Minutos";
L["guildTerok10Desc"] = "Envía un mensaje al chat de la hermandad cuando quedan 10 minutos en las torres de Terokkar si es TBC o en Conquista del Invierno si es WoTLK.";

L["showShatWorldmapMarkersTerokTitle"] = "Mapa Torres/Conquista del Invierno";
L["showShatWorldmapMarkersTerokDesc"] = "¿Muestra la torre Terokkar o los marcadores de Conquista del Invierno en el mapa de la ciudad capital?";

L["Completed PvP dailies"] = "Diaras de JcJ completadas";
L["Hellfire Towers"] = "Torres de Fuego Infernal";
L["Terokkar Towers"] = "Torres de Terokkar";
L["Nagrand Halaa"] = "Nagrand Halaa";

L["wintergraspChat10Title"] = "Conquista del Invierno 10 Minutos";
L["wintergraspChat10Desc"] = "Imprime un mensaje en el chat cuando queden 10 minutos en las torres espirituales de Conquista del Invierno.";

L["wintergraspMiddle10Title"] = "Conquista del Invierno 10 Minutos";
L["wintergraspMiddle10Desc"] = "Muestra un mensaje de estilo de aviso de banda en el medio de la pantalla cuando quedan 10 minutos en las torres espirituales de Conquista del Invierno.";

L["ashenvaleHordeVictoryMsg"] = "¡La sacerdotisa de la luna de la Alianza ha sido asesinada!";
L["ashenvaleAllianceVictoryMsg"] = "¡El clarividente de la Horda ha sido asesinado!";

L["ashenvaleWarning"] = "Los preparativos en Vallefresno están casi completos. ¡La batalla por Vallefresno comenzará pronto! (Alianza %s%%) (Horda %s%%)."; --Any localization of this string must match the same format with brackets etc.

L["Boon of Blackfathom"] = "Bendición Brazanegra";
L["Ashenvale Rallying Cry"] = "Berrido de convocación de Vallefresno";

L["sodHeaderText"] = "Opciones de Temporada de descubrimiento";

--L["disableOnlyNefRendBelowMaxLevelTitle"] = "Desactivar Ony/Nef/Rend";
--L["disableOnlyNefRendBelowMaxLevelDesc"] = "¿Desactiva Ony/Nef/Rend que se muestra en el mapa de la ciudad capital y en el tooltip del icono del minimapa por debajo de cierto nivel? (Hace que el icono del minimapa solo muestra capas y no los temporizadores de beneficio)";

--L["disableOnlyNefRendBelowMaxLevelNumTitle"] = "Ony/Nef/Rend nivel mínimo";
--L["disableOnlyNefRendBelowMaxLevelNumDesc"] = "¿Debajo de qué nivel deberíamos ocultar los iconos Ony/Nef/Rend del mapa de la ciudad y el tooltip del botón del minimapa?";

L["soundsBlackfathomBoonTitle"] = "Sonido de beneficios";
L["soundsBlackfathomBoonDesc"] = "¿Reproduce un sonido cuando se obtiene un beneficio de temporada de descubrimiento?";

L["soundsAshenvaleStartsSoonTitle"] = "Sonido de inicio de evento";
L["soundsAshenvaleStartsSoonDesc"] = "¿Reproduce un sonido cuando un evento de temporada de descubrimiento está a punto de comenzar?";

L["blackfathomBoomBuffDropped"] = "El beneficio de Bendición Brazanegra se ha caído.";

L["showAshenvaleOverlayTitle"] = "Superposición";
L["showAshenvaleOverlayDesc"] = "¿Muestra una superposición de temporizadores móvil en tu IU de forma permanente?";

L["lockAshenvaleOverlayTitle"] = "Bloquear";
L["lockAshenvaleOverlayDesc"] = "Bloquea la superposición de temporizadores para que ignore el paso del ratón.";

L["ashenvaleOverlayScaleTitle"] = "Escala de la superposición";
L["ashenvaleOverlayScaleDesc"] = "Establece el tamaño de la superposición de temporizadores.";

L["ashenvaleOverlayText"] = "|cFFFFFF00-Superposición para mostrar siempre los temporizadores en tu interfaz de usuario-";
L["layersNoteText"] = "|cFFFF6900Nota sobre capas:|r |cFF9CD6DENWB tiene un límite de seguimiento de 10 capas como máximo, esto es para que el tamaño de los datos no sea demasiado grande para compartirlo fácilmente entre los jugadores. En la mayoría de los reinos Temporada con una gran población en este momento hay más de 10 capas, por lo que si no muestra en qué capa estás, entonces la razón es porque no estás en una de las 10 capas registradas. Es probable que vuelva a bajar por debajo de 10 una vez que el entusiasmo por el lanzamiento se desvanezca un poco, pero hasta entonces puede que no sea confiable, lo siento.|r";

L["Mouseover char names for extra info"] = "Pasar el ratón sobre nombres de personajes para más info.";
L["Show Stats"] = "Estadísticas"; --Can't be any longer than this.
L["Event Running"] = "En progreso";

L["Left-Click"] = "Clic Izq.";
L["Right-Click"] = "Clic Der.";
L["Shift Left-Click"] = "Mayús Clic Izq.";
L["Shift Right-Click"] = "Mayús Clic Der.";
L["Control Left-Click"] = "Control Clic Izq.";

--Try keep these roughly the same length or shorter.
L["Guild Layers"] = "Hermandad";
L["Timers"] = "Temporizadores";
L["Buffs"] = "Beneficios";
L["Felwood Map"] = "Mapa de Frondavil";
L["Config"] = "Opciones";
L["Resources"] = "Progreso";
L["Layer"] = "Capa";
L["Layer Map"] = "Mapa de capa";
--L["Rend Log"] = "Rend";
L["Timer Log"] = "Temporizadores";
L["Copy/Paste"] = "Copiar/Pegar";
L["Ashenvale PvP Event Resources"] = "Progreso de Vallefresno";
L["All other alts using default"] = "Todos los demás usando la configuración predeterminada";
L["Chronoboon CD"] = "TdR Reubicador cronológico"; --Chronoboon cooldown.
L["All"] = "Todo"; --This has to be small to fit.
L["Old Data"] = "Datos desactualizados";
L["Ashenvale data is old"] = "Los datos de Vallefresno están desactualizados.";
L["Ashenvale"] = "Vallefresno";
L["Ashenvale Towers"] = "Torres de Vallefresno";
L["Warning"] = "Aviso";
L["Refresh"] = "Actualizar";
L["PvP enabled"] = "JcJ activo";
L["Hold Shift to drag"] = "Mantén mayús para arrastrar";
L["Hold to drag"] = "Mantén presionado para arrastrar";

L["Can't find current layer or no timers active for this layer."] = "No se puede encontrar la capa actual o no hay temporizadores activos para esta capa.";
L["No guild members online sharing layer data found."] = "No se encontraron miembros de la hermandad en línea compartiendo datos de capa.";

--New.

L["ashenvaleOverlayFontTitle"] = "Fuente de la superposición";
L["ashenvaleOverlayFontDesc"] = "Qué fuente usar para pantallas superpuestas.";

L["minimapLayerFontTitle"] = "Fuente de capa de minimapa";
L["minimapLayerFontDesc"] = "Qué fuente usar para el texto de la capa del minimapa.";

L["minimapLayerFontSizeTitle"] = "Tamaño de texto de capa del minimapa";
L["minimapLayerFontSizeDesc"] = "Qué tamaño de fuente usar para el texto de la capa del minimapa.";

L["zone"] = "zona";
L["zones mapped"] = "Zonas mapeadas";
L["Layer Mapping for"] = "Mapeo de capas para";
L["formatForDiscord"] = "¿Formatea el texto para pegarlo en discordia? (Agrega colores, etc.)";
L["Copy Frame"] = "Copiar marco";
L["Show how many times you got each buff."] = "Muestra cuántas veces obtuviste cada beneficio.";
L["Show all alts that have buff stats? (stats must be enabled)."] = "¿Muestra todos los alts que tienen estadísticas de beneficio? (las estadísticas deben estar activadas).";
L["No timer logs found."] = "No se encontraron registros del temporizador.";
L["Merge Layers"] = "Juntar capas";
L["mergeLayersTooltip"] = "Si varias capas tienen el mismo temporizador, se juntarán en [Todas las capas] en lugar de mostrarlas por separado.";
L["Ready"] = "Listo";
L["Chronoboon"] = "Reubicador cronológico";
L["Local Time"] = "Hora local";
L["Server Time"] = "Hora del reino";
L["12 hour"] = "12 horas";
L["24 hour"] = "24 horas";
L["Alliance"] = "Alianza";
L["Horde"] = "Horda";
L["No Layer"] = "Sin capa";
L["No data yet."] = "Aún no hay datos.";
L["Ashenvale Resources"] = "Progreso de Vallefresno";
L["No character specific buffs set yet."] = "Aún no se han establecido beneficios específicos para personajes.";
L["All characters are using default"] = "Todos los personajes usando la configuración predeterminada";
L["Orgrimmar"] = "Orgrimmar";
L["Stormwind"] = "Ventormenta";
L["Dalaran"] = "Dalaran";
L["left"] = "restantes";
L["remaining"] = "restantes";

L["Online"] = "Conectado";
L["Offline"] = "Desconectado";
L["Rested"] = "Descansado";
L["Not Rested"] = "No Descansado";
L["No zones mapped for this layer yet."] = "Aún no hay zonas mapeadas para esta capa.";
L["Cooldown"] = "Reutilización";
L["dmfLogonBuffResetMsg"] = "Estos personajes estuvieron desconectados más de 8 horas en un área descansada y el tiempo de reutilización del beneficio de la Feria de la Luna Negra se reinició";
L["dmfOfflineStatusTooltip"] = "Reutilización de Feria más de 8 horas sin conexión en estado de área de descanso";
L["chronoboonReleased"] = "Reubicador cronológico sobrecargado ha restablecido el beneficio de la Feria de la Luna Negra. Ha comenzado un nuevo tiempo de reutilización de 4 horas.";

L["Stranglethorn"] = "Tuercespina"; --One word shorter version of Strangethorn Vale to fit better.
L["ashenvaleEventRunning"] = "La batalla por Vallefresno está en progreso: %s";
L["ashenvaleEventStartsIn"] = "La batalla por Vallefresno comenzará en %s";
L["ashenvaleStartSoon"] = "La batalla por Vallefresno comenzará en %s"; -- Guild chat msg.
L["stranglethornEventRunning"] = "La Luna Sangrienta está en progreso: %s";
L["stranglethornEventStartsIn"] = "La Luna Sangrienta comenzará en %s";
L["stranglethornStartSoon"] = "La Luna Sangrienta comenzará en %s"; -- Guild chat msg.
L["Spark of Inspiration"] = "Chispa de inspiración"; --Phase 2 SoD world buff.
L["specificBuffDropped"] = "El beneficio de %s se ha caído.";
L["3 day raid reset"] = "Reinicio de la banda de 3 días";
L["Darkmoon Faire is up"] = "La Feria de la Luna Negra está disponible";
L["dmfAbbreviation"] = "Feria";
L["Ashenvale PvP Event"] = "La batalla por Vallefresno";
L["Stranglethorn PvP Event"] = "La Luna Sangrienta";

L["overlayShowArtTitle"] = "Superposición de arte";
L["overlayShowArtDesc"] = "¿Muestra superposición de arte?";

L["overlayShowAshenvaleTitle"] = "Superposición de Vallefresno";
L["overlayShowAshenvaleDesc"] = "¿Muestra la superposición del temporizador de Vallefresno?";

L["overlayShowStranglethornTitle"] = "Superposición de Tuercespina";
L["overlayShowStranglethornDesc"] = "¿Muestra la superposición del temporizador de Tuercespina?";

L["sodMiddleScreenWarningTitle"] = "Anuncios en el medio de pantalla";
L["sodMiddleScreenWarningDesc"] = "¿Muestra anuncio de 15/30 minutos en el medio de la pantalla para eventos de JcJ?";

L["stvBossMarkerTooltip"] = "Marcador de jefe NWB (experimental)";
L["Boss"] = "Jefe"; --Abbreviate if too long, this text sits below a map marker.
L["stvBossSpotted"] = "¡Jefe Loa avistado! Mira el mapa para la ubicación.";
L["Total coins this event"] = "Moneda total en este evento"; --Keep it short, it prints to chat when you hand in coins.
L["Last seen"] = "Última vez visto";
L["World Events"] = "Eventos mundiales";
L["layersNoGuild"] = "No tienes hermandad, este comando muestra solo miembros de la hermandad.";

L["Fervor of the Temple Explorer"] = "Fervor del expedicionario del templo";
L["No guild"] = "Sin hermandad";

L["Temple of Atal'Hakkar"] = "Templo de Atal'Hakkar";