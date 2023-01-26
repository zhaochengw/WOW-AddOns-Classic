--localization file for Spanish
local Lang = LibStub("AceLocale-3.0"):NewLocale("Attune", "esES")
if (not Lang) then
	return;
end


-- INTERFACE
Lang["Credits"] = "Muchas gracias a mi hermandad |cffffd100<Divine Heresy>|r por su apoyo y comprensión mientras probaba el addon y mi agradecimiento a |cffffd100RoadBlock|r y |cffffd100Bushido|r por la ayuda!\n\n También, muchas, muchas, gracias a los traductores :\n  - Traducción Alemana: |cffffd100Sumaya @ Razorfen DE|r\n  - Traducción Rusa: |cffffd100Greymarch Guild @ Flamegor RU|r\n  - Traducción Española: |cffffd100Coyu @ Pyrewood Village EU|r\n  - Traducción China (simp.): |cffffd100ly395842562|r y |cffffd100Icyblade|r\n  - Traducción China (trad.): |cffffd100DayZ|r @ Ivus TW|r\n  - Traducción coreana: |cffffd100Drix @ Azshara KR|r\n\n/Hug de Cixi/Gaya @ Remulos Horde"
Lang["Mini"] = "Mini"
Lang["Maxi"] = "Maxi"
Lang["Version"] = "Attune v##VERSION## de Cixi@Remulos"
Lang["Splash"] = "v##VERSION## de Cixi@Remulos. Escribe /attune para empezar."
Lang["Survey"] = "Sondear"
Lang["Guild"] = "Hermandad"
Lang["Party"] = "Grupo"
Lang["Raid"] = "Banda"
Lang["Run an attunement survey (for people with the addon)"] = "Ejecutar un sondeo de armonización (para personas con el addon)"
Lang["Toggle between attunements and survey results"] = "Cambia entre los resultados de las armonizaciones y los sondeos" 
Lang["Close"] = "Cerrar" 
Lang["Export"] = "Exportar"
Lang["My Data"] = "Mis datos"
Lang["Last Survey"] = "Último sondeo"
Lang["Guild Data"] = "Datos Hermandad"
Lang["All Data"] = "Datos Totales"
Lang["Export your Attune data to the website"] = "Exportar los datos de Attune a la web"
Lang["Copy the text below, then upload it to"] = "Copia el texto de abajo y súbelo a"
Lang["Results"] = "Resultados"
Lang["Not in a guild"] = "Hermandad no encontrada"
Lang["Click on a header to sort the results"] = "Clicka en el encabezado para ordenar resultados" 
Lang["Character"] = "Personaje" 
Lang["Characters"] = "Personajes"
Lang["Last survey results"] = "Resultados último sondeo"	
Lang["All FACTION results"] = "Resultados Totales ##FACTION## "
Lang["Guild members"] = "Miembros de la hermandad" 
Lang["All results"] = "Resultados Totales" 
Lang["Minimum level"] = "Nivel Mínimo" 
Lang["Click to navigate to that attunement"] = "Click para navegar por la armonización"
Lang["Attunes"] = "Lista"
Lang["Guild members on this step"] = "Miembros de la hermandad en esta fase"
Lang["Attuned guild members"] = "Miembros de la hermandad armonizados"
Lang["Attuned alts"] = "Alters armonizados"
Lang["Alts on this step"] = "Alters en esta fase"
Lang["Settings"] = "Opciones"
Lang["Survey Log"] = "Log de sondeos"
Lang["LeftClick"] = "Click Izquierdo"
Lang["OpenAttune"] = "Abrir Attune"
Lang["RightClick"] = "Click Derecho"
Lang["OpenSettings"] = "Abrir Opciones"
Lang["Addon disabled"] = "Desactivar Addon"
Lang["StartAutoGuildSurvey"] = "Enviando sondeo automático oculto a canal Hermandad"
Lang["SendingDataTo"] = "Enviando datos de Attune a |cffffd100##NAME##|r"
Lang["NewVersionAvailable"] = "Una |cffffd100new version|r of Attune está disponible, asegúrate de actualizar!"
Lang["CompletedStep"] = "Completado ##TYPE## |cffe4e400##STEP##|r para la armonización de |cffe4e400##NAME##|r."
Lang["AttuneComplete"] = "¡Armonización |cffe4e400##NAME##|r completada!"
Lang["AttuneCompleteGuild"] = "¡##NAME## ha completado una Amornización!"
Lang["SendingSurveyWhat"] = "Enviando sondeo ##WHAT##"
Lang["SendingGuildSilentSurvey"] = "Enviando sondeo oculto a canal Hermandad"
Lang["SendingYellSilentSurvey"] = "Enviando sondeo oculto a canal Grito"
Lang["ReceivedDataFromName"] = "Recibiendo datos de |cffffd100##NAME##|r"
Lang["ExportingData"] = "Exportando datos de Attune para ##COUNT## personaje(s)"
Lang["ReceivedRequestFrom"] = "Recibida solicitud de sondeo de |cffffd100##FROM##|r"
Lang["Help1"] = "Este addon permite examinar y exportar tus progresos con las armonizaciones"
Lang["Help2"] = "Ejecuta |cfffff700/attune|r para empezar."
Lang["Help3"] = "Para sondear el progeso de tu hermandad, clicka en |cfffff700sondeo|r para recabar información."
Lang["Help4"] = "Recibirás los datos de todos los miembros de la hermandad con el addon instalado."
Lang["Help5"] = "Una vez tenga la suficiente información, clicka en |cfffff700exportar|r para exportar el progreso de la hermandad"
Lang["Help6"] = "Los datos pueden ser subidos a |cfffff700https://warcraftratings.com/attune/upload|r"
Lang["Survey_DESC"] = "Ejecutar un sondeo de Armonización (para personas con el addon)"
Lang["Export_DESC"] = "Exporta tus datos de Attune a la web"
Lang["Toggle_DESC"] = "Cambia entre los resultados de las armonizaciones y sondeos"
--Lang["PreferredLocale_TEXT"] = "Idiomas preferidos"
--Lang["PreferredLocale_DESC"] = "Selecciona el idioma en que deseas ver Attune. Recarga la interfaz para que los cambios surtan efecto."
--v220
Lang["My Toons"] = "Mis personajes"
Lang["No Target"] = "No tienes ningún objetivo"
Lang["No Response From"] = "No hay respuesta de ##PLAYER##"
Lang["Sync Request From"] = "Nueva solucitud de Attune Sync de:\n\n##PLAYER##"
Lang["Could be slow"] = "Dependiendo del volumen de datos, esto puede ser un proceso largo"
Lang["Accept"] = "Aceptar"
Lang["Reject"] = "Rechazar"
Lang["Busy right now"] = "##PLAYER## está ocupado ahora mismo, prueba más tarde"
Lang["Sending Sync Request"] = "Enviando solicitud de Sync a ##PLAYER##"
Lang["Request accepted, sending data to "] = "Solicitud aceptada, enviado datos a ##PLAYER##"
Lang["Received request from"] = "Solicitud recibida de ##PLAYER##"
Lang["Request rejected"] = "Petición rechazada"
Lang["Sync over"] = "Sync finalizada, tiempo ##DURATION##"
Lang["Syncing Attune data with"] = "Sincronizando datos de Attune con ##PLAYER##"
Lang["Cannot sync while another sync is in progress"] = "No se puede sincronizar mientras este activa otra sincronización"
Lang["Sync with target"] = "Sincronizado con el objetivo"
Lang["Show Profiles"] = "Mostrar Perfiles"
Lang["Show Progress"] = "Mostrar Progreso"
Lang["Status"] = "Estatus"
Lang["Role"] = "Rol"
Lang["Last Surveyed"] = "Último Sondeado"
Lang['Seconds ago'] = "Hace ##DURATION##"
Lang["Main"] = "Principal"
Lang["Alt"] = "Alter"
Lang["Tank"] = "Tank"
Lang["Healer"] = "Sanador"
Lang["Melee DPS"] = "Melee DPS"
Lang["Ranged DPS"] = "Rango DPS"
Lang["Bank"] = "Banco"
Lang["DelAlts_TEXT"] = "Eliminar todos los PJs Alters"
Lang["DelAlts_DESC"] = "Eliminar toda info sobre jugadores marcados como Alters"
Lang["DelAlts_CONF"] = "¿Quieres realmente eliminar todos los Alters?"
Lang["DelAlts_DONE"] = "Todos los Alters eliminados"
Lang["DelUnspecified_TEXT"] = "Eliminar PJs sin estatus asignado"
Lang["DelUnspecified_DESC"] = "Eliminar toda info sobre jugadores sin estatus Principal/Alter asginado"
Lang["DelUnspecified_CONF"] = "¿Quieres realmente eliminar todos los personajes sin estatus asignado?"
Lang["DelUnspecified_DONE"] = "Todos los personajes sin estatus Principal/Alter asginado eliminados"
--v221
Lang["Open Raid Planner"] = "Abrir Planificador de banda"
Lang["Unspecified"] = "No asignado"
Lang["Empty"] = "Vacío"
Lang["Guildies only"] = "Mostrar solo miembros de la hermandad"
Lang["Show Mains"] = "Mostrar Principales"
Lang["Show Unspecified"] = "Mostrar No asignado"
Lang["Show Alts"] = "Mostrar Alters"
Lang["Show Unattuned"] = "Mostrar Desarmonizados"
Lang["Raid spots"] = "##SIZE## Raid spots"
Lang["Group Number"] = "Grupo ##NUMBER##"
Lang["Move to next group"] = "    Mover al próximo grupo"
Lang["Remove from raid"] = "  Eliminar de la banda"
Lang["Select a raid and click on players to add them in"] = "Selecciona una banda y clicka sobre los personajes para añadirlos"
--v224
Lang["Enter a new name for this raid group"] = "Introduce un nuevo nombre para esta banda."
Lang["Save"] = "Info Banda"
--v226
Lang["Invite"] = "Invitar"
Lang["Send raid invites to all listed players?"] = "¿Enviar invitaciones de incursión a todos los jugadores listados?"
Lang["External link"] = "Enlace a una base de datos en línea"
--v243
Lang["Ogrila"] = "Ogri'la"
Lang["Ogri'la Quest Hub"] = "Centro de misiones de Ogri'la"
Lang["Ogrila_Desc"] = "Los iluminados habitantes de Ogri'la han creado su hogar en las Montañas Filospada occidentales."
Lang["DelInactive_TEXT"] = "Eliminar inactivos"
Lang["DelInactive_DESC"] = "Eliminar toda la información sobre los jugadores marcados como Inactivos"
Lang["DelInactive_CONF"] = "¿Eliminar realmente todos los inactivos?"
Lang["DelInactive_DONE"] = "Todos los inactivos eliminados"
Lang["RAIDS"] = "BANDAS"
Lang["KEYS"] = "TECLAS"
Lang["MISC"] = "MISC"
Lang["HEROICS"] = "HEROICAS"
--v244
Lang["Ally of the Netherwing"] = "Aliado del Ala Abisal"
Lang["Netherwing_Desc"] = "El Ala Abisal es una facción de dragones ubicada en Terrallende."
--v247
Lang["Tirisfal Glades"] = "Claros de Tirisfal"
Lang["Scholomance"] = "Scholomance"
--v248
Lang["Target"] = "Objetivo"
Lang["SendingSurveyTo"] = "Enviando encuesta a ##TO## "


-- OPTIONS
Lang["MinimapButton_TEXT"] = "Mostrar el icono en el Minimap"
Lang["MinimapButton_DESC"] = "Mostrar un botón de acceso rápido en el Minimapa a la interfaz u opciones."
Lang["AutoSurvey_TEXT"] = "Ejecutar sondeo automático de la hermandad al conectar"
Lang["AutoSurvey_DESC"] = "Siempre que conectes al juego, el addon realizará un sondeo a la hermandad."
Lang["ShowSurveyed_TEXT"] = "Mostrar mensaje si he sido sondeado"
Lang["ShowSurveyed_DESC"] =  "Mostrar mensaje cuando recibes (y contestas) a una solicitud de sondeo."
Lang["ShowResponses_TEXT"] = "Mostrar respuestas cuando hago un sondeo"
Lang["ShowResponses_DESC"] = "Mostrar un mensaje en el chat para cada sondeo contestado."
Lang["ShowSetMessages_TEXT"] = "Mostrar mensaje al completar fase"
Lang["ShowSetMessages_DESC"] = "Mostrar un mensaje de chat cuando una fase o la armonización sea completada."
Lang["AnnounceToGuild_TEXT"] = "Anunciar finalización en chat de hermandad"
Lang["AnnounceToGuild_DESC"] = "Enviar un mensaje al chat de hermandad cuando una armonización sea finalizada."
Lang["ShowOther_TEXT"] = "Mostrar otros mensajes del chat"
Lang["ShowOther_DESC"] = "Muestra todos los demás mensajes de chat genéricos (envío de sondeo, actualización disponible, etc)."
Lang["ShowGuildies_TEXT"] = "Mostrar lista de miembros en cada fase de la Armonización.               Max PJs"  --this has a gap for the editbox
Lang["ShowGuildies_DESC"] = "Mostrar en el texto de ayuda de cada fase los miembros de la hermandad que se encuentran actualmente en ella.\nAjustar el max de miembros de hermandad a listar en cada fase si es necesario."
Lang["ShowAltsInstead_TEXT"] = "Muestra lista de alters en vez de miembros de la hermandad"
Lang["ShowAltsInstead_DESC"] = "Los textos de ayuda se mostrarán para tus alters que están actualmente en esa fase de la Armonización en vez de los miembros de la hermandad."
Lang["ClearAll_TEXT"] = "Eliminar TODOS los resultados"
Lang["ClearAll_DESC"] = "Eliminar toda la información almanceda sobre otros jugadores."
Lang["ClearAll_CONF"] = "¿Quieres realmente eliminar TODOS los resultados?"
Lang["ClearAll_DONE"] = "TODOS los resultados eliminados."
Lang["DelNonGuildies_TEXT"] = "Eliminar PJs de fuera de la hermandad"
Lang["DelNonGuildies_DESC"] = "Eliminar información sobre jugadores de fuera de tu hermandad."
Lang["DelNonGuildies_CONF"] = "¿Quieres eliminar realmente todos los jugadores fuera de la hermandad?"
Lang["DelNonGuildies_DONE"] = "Todos los resultados fuera de tu hermandad eliminados."
Lang["DelUnder60_TEXT"] = "Eliminar PJs por debajo de nivel 60"
Lang["DelUnder60_DESC"] = "Eliminar toda la información sobre personajes por debajo del nivel 60."
Lang["DelUnder60_CONF"] = "¿Quieres realmente eliminar TODOS los personajes por debajo de 60?"
Lang["DelUnder60_DONE"] = "Todos los resultados por debajo 60 eliminados."
Lang["DelUnder70_TEXT"] = "Eliminar PJs por debajo de nivel 70"
Lang["DelUnder70_DESC"] = "Eliminar toda la información sobre Pjs por debajo de nivel 70."
Lang["DelUnder70_CONF"] = "¿Quieres realmente eliminar TODOS los personajes por debajo de 70?"
Lang["DelUnder70_DONE"] = "Todos los resultados por debajo de nivel 70 eliminados."
--302
Lang["AnnounceAchieve_TEXT"] = "Anunciar logros en el chat del gremio                                    Límite:"
Lang["AnnounceAchieve_DESC"] = "Envía un mensaje de hermandad cuando obtengas un logro."
Lang["AchieveCompleteGuild"] = "##LINK## completada! " 
Lang["AchieveCompletePoints"] = "(##POINTS## puntos totales)" 
Lang["AchieveSurvey"] = "¿Te gustaría |cFFFFD100Attune|r anunciar los logros de |cFFFFD100##WHO##|r en el chat del gremio?"
--306
Lang["showDeprecatedAttunes_TEXT"] = "Mostrar armonización en desuso"
Lang["showDeprecatedAttunes_DESC"] = "Mantenga las armonización más antiguas (Onyxia 40, Naxxramas 40) visibles en la lista"
					

-- TREEVIEW
Lang["World of Warcraft"] = "World of Warcraft"
Lang["The Burning Crusade"] = "The Burning Crusade"
Lang["Molten Core"] = "Núcleo de Magma"
Lang["Onyxia's Lair"] = "Guarida de Onyxia"
Lang["Blackwing Lair"] = "Guarida de Alanegra"
Lang["Naxxramas"] = "Naxxramas"
Lang["Scepter of the Shifting Sands"] = "Cetro del Mar de Dunas"
Lang["Shadow Labyrinth"] = "Laberinto de las Sombras"
Lang["The Shattered Halls"] = "Las Salas Arrasadas"
Lang["The Arcatraz"] = "El Arcatraz"
Lang["The Black Morass"] = "La Ciénaga Negra"
Lang["Thrallmar Heroics"] = "Thrallmar Heroicas"
Lang["Honor Hold Heroics"] = "Bastión del Honor Heroicas"
Lang["Cenarion Expedition Heroics"] = "Expedición Cenarion Heroicas"
Lang["Lower City Heroics"] = "Bajo Arrabal Heroicas"
Lang["Sha'tar Heroics"] = "Sha'tar Heroicas"
Lang["Keepers of Time Heroics"] = "Guardianes del Tiempo Heroicas"
Lang["Nightbane"] = "Nocturno"
Lang["Karazhan"] = "Karazhan"
Lang["Serpentshrine Cavern"] = "Caverna Santuario Serpiente"
Lang["The Eye"] = "El Ojo"
Lang["Mount Hyjal"] = "Monte Hyjal"
Lang["Black Temple"] = "Templo Oscuro"
Lang["MC_Desc"] = "Todos los miembros de la banda necesitan estar Armonizados para poder acceder la instancia de banda, excepto si entran vía BRD." 
Lang["Ony_Desc"] = "Todos los miembros de la banda necesitan tener el Amuleto Pirodraco en sus bolsas, para poder acceder la instancia de banda."
Lang["BWL_Desc"] = "Todos los miembros de la banda necesitan estar Armonizados para poder acceder la instancia de banda, excepto si entran vía UBRS."
Lang["All_Desc"] = "Todos los miembros de la banda necesitan estar Armonizados para poder acceder la instancia de banda."
Lang["AQ_Desc"] = "Solo una persona por reino necesita completar la misión para poder abrir las puertas de Ahn'Qiraj."
Lang["OnlyOne_Desc"] = "Solo una persona del grupo necesita tener la llave. Un pícaro con una habitalidad de 350 Forzar cerradura también puede abrirla."
Lang["Heroic_Desc"] = "Todos los miembro de la banda tiene que tener la reputación y llave para poder entrar en el Modo Heroico."
Lang["NB_Desc"] = "Solo un miembro de la banda debe tener la Urna ennegrecida para poder invocar a Nocturno."
Lang["BT_Desc"] = "Todos los miembros de la banda deben tener el Medallón de Karabor para entrar en la instancia de banda."
Lang["BM_Desc"] = "Todos los miembros del grupo deben completar la cadena de misiones para poder acceder a la instancia." 
--v250
Lang["Aqual Quintessence"] = "Quintaesencia de agua"
Lang["MC2_Desc"] = "Se utiliza para convocar a Mayordomo Executus. Todos los jefes de Molten Core, excepto Lucifron y Geddon, tienen runas en el suelo que deben rociarse para que aparezca Executus." 
--v254
Lang["Magisters' Terrace Heroic"] = "Bancal del Magister Heroica"
Lang["Magisters' Terrace"] = "Bancal del Magister"
Lang["MgT_Desc"] = "Todos los jugadores deben completar la mazmorra en modo normal para poder ejecutarla en modo heroico."
Lang["Isle of Quel'Danas"] = "Isla de Quel'Danas"


-- GENERIC
Lang["Reach level"] = "Alcanza nivel"
Lang["Attuned"] = "Armonizado"
Lang["Not attuned"] = "No Armonizado"
Lang["AttuneColors"] = "Azul: Armonizado\nRojo:  No Armonizado"
Lang["Minimum Level"] = "Éste es el nivel mínimo requerido para acceder a las misiones."
Lang["NPC Not Found"] = "Información sobre el NPC no encontrada"
Lang["Level"] = "Nivel"
Lang["Exalted with"] = "Exaltado con"
Lang["Revered with"] = "Reverenciado con"
Lang["Honored with"] = "Honorable con"
Lang["Friendly with"] = "Amistoso con"
Lang["Neutral with"] = "Neutral con"
Lang["Quest"] = "Misión"
Lang["Pick Up"] = "Recoger"
Lang["Turn In"] = "Entregar"
Lang["Kill"] = "Matar"
Lang["Interact"] = "Interactuar"
Lang["Item"] = "Objeto"
Lang["Required level"] = "Nivel requerido"
Lang["Requires level"] = "Nivel requerido"
Lang["Attunement or key"] = "Armonización o llave"
Lang["Reputation"] = "Reputación"
Lang["in"] = "en"
Lang["Unknown Reputation"] = "Reputación desconocida"
Lang["Current progress"] = "Progreso actual"
Lang["Completion"] = "Completado"
Lang["Quest information not found"] = "Información de la misión no encontrada"
Lang["Information not found"] = "Información no encontrada"
Lang["Solo quest"] = "Misión en solitario"
Lang["Party quest"] = "Misión de grupo (##NB##-man)"
Lang["Raid quest"] = "Misión de banda (##NB##-man)"
Lang["HEROIC"] = "HC"
Lang["Elite"] = "Élite"
Lang["Boss"] = "Boss"
Lang["Rare Elite"] = "Élite raro"
Lang["Dragonkin"] = "Dragonante"
Lang["Troll"] = "Trol"
Lang["Ogre"] = "Ogro"
Lang["Orc"] = "Orco"
Lang["Half-Orc"] = "Medio-Orco"
Lang["Dragonkin (in Blood Elf form)"] = "Dragonante (en forma de Elfo de la Noche)"
Lang["Human"] = "Humano"
Lang["Dwarf"] = "Enano"
Lang["Mechanical"] = "Mecánico"
Lang["Arakkoa"] = "Arakkoa"
Lang["Dragonkin (in Humanoid form)"] = "Dragonante (en forma de Humanoide)"
Lang["Ethereal"] = "Etéreo"
Lang["Blood Elf"] = "Elfo de Sangre"
Lang["Elemental"] = "Elemental"
Lang["Shiny thingy"] = "Objeto brillante"
Lang["Naga"] = "Naga"
Lang["Demon"] = "Demonio"
Lang["Gronn"] = "Gigante"
Lang["Undead (in Dragon form)"] = "No-muerto (en forma de Dragón)"
Lang["Tauren"] = "Tauren"
Lang["Qiraji"] = "Qiraji"
Lang["Gnome"] = "Gnomo"
Lang["Broken"] = "Tábido"
Lang["Draenei"] = "Draenei"
Lang["Undead"] = "No-muerto"
Lang["Gorilla"] = "Gorilla"
Lang["Shark"] = "Tiburón"
Lang["Chimaera"] = "Quimera"
Lang["Wisp"] = "Fuego fatuo"
Lang["Night-Elf"] = "Elfo de la Noche"


-- REP
Lang["Argent Dawn"] = "El Alba Argenta"
Lang["Brood of Nozdormu"] = "Linaje de Nozdormu"
Lang["Thrallmar"] = "Thrallmar"
Lang["Honor Hold"] = "Bastión del Honor"
Lang["Cenarion Expedition"] = "Expedición Cenarion"
Lang["Lower City"] = "Bajo Arrabal"
Lang["The Sha'tar"] = "Los Sha'tar"
Lang["Keepers of Time"] = "Vigilantes del tiempo"
Lang["The Violet Eye"] = "El Ojo Violeta"
Lang["The Aldor"] = "Los Aldor"
Lang["The Scryers"] = "Los Arúspices"


-- LOCATIONS
Lang["Blackrock Mountain"] = "Montaña Roca Negra"
Lang["Blackrock Depths"] = "Profundidades Roca Negra"
Lang["Badlands"] = "Tierras Inhóspitas"
Lang["Lower Blackrock Spire"] = "Cumbre Roca Negra Inferior"
Lang["Upper Blackrock Spire"] = "Cumbre Roca Negra Superior"
Lang["Orgrimmar"] = "Orgrimmar"
Lang["Western Plaguelands"] = "Tierras de la peste Oeste"
Lang["Desolace"] = "Desolace"
Lang["Dustwallow Marsh"] = "Marjal Revolcafango"
Lang["Tanaris"] = "Tanaris"
Lang["Winterspring"] = "Cuna de Invierno"
Lang["Swamp of Sorrows"] = "Pantano de las Penas"
Lang["Wetlands"] = "Los Humedales"
Lang["Burning Steppes"] = "Estepas Ardiantes"
Lang["Redridge Mountains"] = "Montañas Crestagrana"
Lang["Stormwind City"] = "Ciudad de Ventormenta"
Lang["Eastern Plaguelands"] = "Tierras de la peste Este"
Lang["Silithus"] = "Silithus"
Lang["The Temple of Atal'Hakkar"] = "El Templo de Atal'Hakkar"
Lang["Teldrassil"] = "Teldrassil"
Lang["Moonglade"] = "Claro de la Luna"
Lang["Hinterlands"] = "Tierras del Interior"
Lang["Ashenvale"] = "Vallefresno"
Lang["Feralas"] = "Feralas"
Lang["Duskwood"] = "Bosque del Ocaso"
Lang["Azshara"] = "Azshara"
Lang["Blasted Lands"] = "Tierras Devastadas"
Lang["Undercity"] = "Entrañas"
Lang["Silverpine Forest"] = "Bosque de Argénteos"
Lang["Shadowmoon Valley"] = "Valle Sombraluna"
Lang["Hellfire Peninsula"] = "Península del Fuego infernal"
Lang["Sethekk Halls"] = "Salas Sethekk"
Lang["Caverns Of Time"] = "Cavernas del Tiempo"
Lang["Netherstorm"] = "Tormenta Abisal"
Lang["Shattrath City"] = "Ciudad de Shattrath City"
Lang["The Mechanaar"] = "El Mechanar"
Lang["The Botanica"] = "El Invernáculo"
Lang["Zangarmarsh"] = "Marisma de Zangar"
Lang["Terokkar Forest"] = "Bosque de Terokkar"
Lang["Deadwind Pass"] = "Paso de la Muerte"
Lang["Alterac Mountains"] = "Montañas de Alterac"
Lang["The Steamvault"] = "La Cámara de Vapor"
Lang["Slave Pens"] = "Recinto de los Esclavos"
Lang["Gruul's Lair"] = "Guarida de Gruul"
Lang["Magtheridon's Lair"] = "Guarida de Magtheridon"
Lang["Zul'Aman"] = "Zul'Aman"
Lang["Sunwell Plateau"] = "Meseta de la Fuente del Sol"



-- ITEMS
Lang["Drakkisath's Brand"] = "La marca de Drakkisath"			-- https://es.tbc.wowhead.com/object=179880
Lang["Crystalline Tear"] = "Lágrima cristalina"			-- https://es.tbc.wowhead.com/object=180633
Lang["I_18412"] = "Trozo del Núcleo"			-- https://es.tbc.wowhead.com/item=18412
Lang["I_12562"] = "Importantes documentos de Roca Negra"			-- https://es.tbc.wowhead.com/item=12562
Lang["I_16786"] = "Ojo de dragauro negro"			-- https://es.tbc.wowhead.com/item=16786
Lang["I_11446"] = "Una nota arrugada"			-- https://es.tbc.wowhead.com/item=11446
Lang["I_11465"] = "Información perdida del mariscal Windsor"			-- https://es.tbc.wowhead.com/item=11465
Lang["I_11464"] = "Información perdida del mariscal Windsor"			-- https://es.tbc.wowhead.com/item=11464
Lang["I_18987"] = "Orden de Puño Negro"			-- https://es.tbc.wowhead.com/item=18987
Lang["I_20383"] = "Cabeza de Señor de linaje Capazote"			-- https://es.tbc.wowhead.com/item=20383
Lang["I_21138"] = "Fragmento de cetro rojo"			-- https://es.tbc.wowhead.com/item=21138
Lang["I_21146"] = "Fragmento de Corrupción de Pesadilla"			-- https://es.tbc.wowhead.com/item=21146
Lang["I_21147"] = "Fragmento de Corrupción de Pesadilla"			-- https://es.tbc.wowhead.com/item=21147
Lang["I_21148"] = "Fragmento de Corrupción de Pesadilla"			-- https://es.tbc.wowhead.com/item=21148
Lang["I_21149"] = "Fragmento de Corrupción de Pesadilla"			-- https://es.tbc.wowhead.com/item=21149
Lang["I_21139"] = "Fragmento de cetro verde"			-- https://es.tbc.wowhead.com/item=21139
Lang["I_21103"] = "Dracónico para torpes - Capítulo I"			-- https://es.tbc.wowhead.com/item=21103
Lang["I_21104"] = "Dracónico para torpes - Capítulo II"			-- https://es.tbc.wowhead.com/item=21104
Lang["I_21105"] = "Dracónico para torpes - Capítulo III"			-- https://es.tbc.wowhead.com/item=21105
Lang["I_21106"] = "Dracónico para torpes - Capítulo IV"			-- https://es.tbc.wowhead.com/item=21106
Lang["I_21107"] = "Dracónico para torpes - Capítulo V"			-- https://es.tbc.wowhead.com/item=21107
Lang["I_21108"] = "Dracónico para torpes - Capítulo VI"			-- https://es.tbc.wowhead.com/item=21108
Lang["I_21109"] = "Dracónico para torpes - Capítulo VII"			-- https://es.tbc.wowhead.com/item=21109
Lang["I_21110"] = "Dracónico para torpes - Capítulo VIII"			-- https://es.tbc.wowhead.com/item=21110
Lang["I_21111"] = "Dracónico para torpes: Volume II"			-- https://es.tbc.wowhead.com/item=21111
Lang["I_21027"] = "Cadáver de Lakmaeran"			-- https://es.tbc.wowhead.com/item=21027
Lang["I_21024"] = "Solomillo de quimerok"			-- https://es.tbc.wowhead.com/item=21024
Lang["I_20951"] = "Gafas de visión de Narain"			-- https://es.tbc.wowhead.com/item=20951
Lang["I_21137"] = "Fragmento de cetro azul"			-- https://es.tbc.wowhead.com/item=21137
Lang["I_21175"] = "El cetro del Mar de Dunas"			-- https://es.tbc.wowhead.com/item=21175
Lang["I_31241"] = "Molde de llave preparado"			-- https://es.tbc.wowhead.com/item=31241
Lang["I_31239"] = "Molde de llave preparado"			-- https://es.tbc.wowhead.com/item=31239
Lang["I_27991"] = "Llave del Laberinto de las Sombras"			-- https://es.tbc.wowhead.com/item=27991
Lang["I_31086"] = "Fragmento inferior de la llave de Arcatraz"			-- https://es.tbc.wowhead.com/item=31086
Lang["I_31085"] = "Fragmento superior de la llave de Arcatraz"			-- https://es.tbc.wowhead.com/item=31085
Lang["I_31084"] = "Llave de El Arcatraz"			-- https://es.tbc.wowhead.com/item=31084
Lang["I_30637"] = "Llave de Forjallamas"			-- https://es.tbc.wowhead.com/item=30637
Lang["I_30622"] = "Llave de Forjallamas"			-- https://es.tbc.wowhead.com/item=30622
Lang["I_30623"] = "Llave de depósito"			-- https://es.tbc.wowhead.com/item=30623
Lang["I_30633"] = "Llave Auchenai"			-- https://es.tbc.wowhead.com/item=30633
Lang["I_30634"] = "Llave forjada de distorsión"			-- https://es.tbc.wowhead.com/item=30634
Lang["I_30635"] = "Llave del tiempo"			-- https://es.tbc.wowhead.com/item=30635
Lang["I_185686"] = "Llave de Forjallamas"			-- https://es.tbc.wowhead.com/item=30637
Lang["I_185687"] = "Llave de Forjallamas"			-- https://es.tbc.wowhead.com/item=30622
Lang["I_185690"] = "Llave de depósito"			-- https://es.tbc.wowhead.com/item=30623
Lang["I_185691"] = "Llave Auchenai"			-- https://es.tbc.wowhead.com/item=30633
Lang["I_185692"] = "Llave forjada de distorsión"			-- https://es.tbc.wowhead.com/item=30634
Lang["I_185693"] = "Llave del tiempo"			-- https://es.tbc.wowhead.com/item=30635
Lang["I_24514"] = "Primer trozo de la llave"			-- https://es.tbc.wowhead.com/item=24514
Lang["I_24487"] = "Segundo trozo de la llave"			-- https://es.tbc.wowhead.com/item=24487
Lang["I_24488"] = "Tercer trozo de la llave"			-- https://es.tbc.wowhead.com/item=24488
Lang["I_24490"] = "La llave del maestro"			-- https://es.tbc.wowhead.com/item=24490
Lang["I_23933"] = "Diario de Medivh"			-- https://es.tbc.wowhead.com/item=23933
Lang["I_25462"] = "Escrito del Ocaso"			-- https://es.tbc.wowhead.com/item=25462
Lang["I_25461"] = "Libro de los Nombres Olvidados"			-- https://es.tbc.wowhead.com/item=25461
Lang["I_24140"] = "Urna ennegrecida"			-- https://es.tbc.wowhead.com/item=24140
Lang["I_31750"] = "Sello terráneo"			-- https://es.tbc.wowhead.com/item=31750
Lang["I_31751"] = "Sello llameante"			-- https://es.tbc.wowhead.com/item=31751
Lang["I_31716"] = "Hacha del Verdugo sin usar"			-- https://es.tbc.wowhead.com/item=31716
Lang["I_31721"] = "Tridente de Kalithresh"			-- https://es.tbc.wowhead.com/item=31721
Lang["I_31722"] = "Esencia de Murmur"			-- https://es.tbc.wowhead.com/item=31722
Lang["I_31704"] = "Llave de la tempestad"			-- https://es.tbc.wowhead.com/item=31704
Lang["I_29905"] = "Restos del vial de Kael"			-- https://es.tbc.wowhead.com/item=29905
Lang["I_29906"] = "Restos del vial de Vashj"			-- https://es.tbc.wowhead.com/item=29906
Lang["I_31307"] = "Corazón de furia"			-- https://es.tbc.wowhead.com/item=31307
Lang["I_32649"] = "Medallón de Karabor"			-- https://es.tbc.wowhead.com/item=32649
--v247
Lang["Shrine of Thaurissan"] = "Santuario de Thaurissan"
Lang["I_14610"] = "El escarabajo de Araj"
--v250
Lang["I_17332"] = "Mano de Shazzrah"
Lang["I_17329"] = "Mano de Lucifron"
Lang["I_17331"] = "Mano de Gehennas"
Lang["I_17330"] = "Mano de Sulfuron"
Lang["I_17333"] = "Quintaesencia de agua"


-- QUESTS - Classic
Lang["Q1_7848"] = "Armonización con el Núcleo"			-- https://es.tbc.wowhead.com/quest=7848
Lang["Q2_7848"] = "Entra en el Núcleo de Magma de las Profundidades de Roca Negra y recoge un fragmento de núcleo. LLévaselo a Lothos Levantagrietas a la Montaña Roca Negra."
Lang["Q1_4903"] = "La orden del Señor de la Guerra"			-- https://es.tbc.wowhead.com/quest=4903
Lang["Q2_4903"] = "Mata al Alto señor Omokk, al maestro de guerra Voone y al Señor Supremo Vermiothalak. Recupera importantes documentos Roca Negra. Vuelve junto al señor de la guerra Dientegore en Kargath cuando hayas cumplido la misión."
Lang["Q1_4941"] = "La sabiduría de Eitrigg"			-- https://es.tbc.wowhead.com/quest=4941
Lang["Q2_4941"] = "Habla con Eitrigg en Orgrimmar. Cuando hayas tratado unos asuntos con Eitrigg, busca el consejo de Thrall.\n\nRecuerdas haber visto a Eitrigg en la Cámara de Thrall."
Lang["Q1_4974"] = "¡Por la Horda!"			-- https://es.tbc.wowhead.com/quest=4974
Lang["Q2_4974"] = "Ve a Cumbre de Roca Negra para matar al Jefe de Guerra Rend Puño Negro. Llévale su cabeza a Orgrimmar."
Lang["Q1_6566"] = "Lo que trae el viento"			-- https://es.tbc.wowhead.com/quest=6566
Lang["Q2_6566"] = "Escucha a Thrall."
Lang["Q1_6567"] = "El Campeón de la Horda"			-- https://es.tbc.wowhead.com/quest=6567
Lang["Q2_6567"] = "Busca a Rexxar. El Jefe de Guerra ha dicho que estará en Desolace, entre Sierra Espolón y Feralas."
Lang["Q1_6568"] = "El testamento de Rexxar"			-- https://es.tbc.wowhead.com/quest=6568
Lang["Q2_6568"] = "Entrega el testamento de Rexxar a Myranda la Fada. Está en las Tierras de la Peste del Oeste."
Lang["Q1_6569"] = "Ilusiones oculares"			-- https://es.tbc.wowhead.com/quest=6569
Lang["Q2_6569"] = "Viaja a la Cumbre de Roca Negra y recoge 20 ojos de dragauro negro. Cuando hayas terminado tu tarea regresa con Myranda la Fada."
Lang["Q1_6570"] = "Brasaliza"			-- https://es.tbc.wowhead.com/quest=6570
Lang["Q2_6570"] = "Viaja a la Ciénaga de Fuego del Marjal Revolcafango y busca el Cubil de Brasaliza. Cuando estés dentro ponte el Amuleto de Subversión Dracónica y habla con Brasaliza."
Lang["Q1_6584"] = "La prueba de las calaveras, Chronalis"			-- https://es.tbc.wowhead.com/quest=6584
Lang["Q2_6584"] = "Chronalis, hijo de Nozdormu, custodia las Cavernas del Tiempo en el Desierto de Tanaris. Destrúyelo y lleva su calavera a Brasaliza."
Lang["Q1_6582"] = "La prueba de las calaveras, Arúspice"			-- https://es.tbc.wowhead.com/quest=6582
Lang["Q2_6582"] = "Debes encontrar a Arúspice, el campeón draco del Vuelo Azul y matarlo. Separa su calavera de su cuerpo y llévasela a Brasaliza. \n\nSabes que puedes encontrar a Arúspice en Cuna del Invierno."
Lang["Q1_6583"] = "La prueba de las calaveras, Somnus"			-- https://es.tbc.wowhead.com/quest=6583
Lang["Q2_6583"] = "Destruye al campeón draco del Vuelo Verde, Somnus. Lleva su calavera a Brasaliza."
Lang["Q1_6585"] = "La prueba de las calaveras, Axtroz"			-- https://es.tbc.wowhead.com/quest=6585
Lang["Q2_6585"] = "Viaja a Grim Batol y encuentra a Axtroz, el campeón draco del Vuelo Rojo. Destrúyelo y hazte con su calavera. Llévasela a Brasaliza."
Lang["Q1_6601"] = "El ascenso"			-- https://es.tbc.wowhead.com/quest=6601
Lang["Q2_6601"] = "Diría que se acabaron las charadas. Ya sabes que el Amuleto de Subversión Dracónica que Myranda la Fada creó para ti no funcionará en el interior de la Cumbre de Roca Negra. Quizás deberías buscar a Rexxar y explicarle el apuro en el que te encuentras. Enséñale el amuleto pirodraco apagado. Con un poco de suerte, él sabrá que hay que hacer ahora."
Lang["Q1_6602"] = "La sangre de dragón negro campeón"			-- https://es.tbc.wowhead.com/quest=6602
Lang["Q2_6602"] = "Viaja a la Cumbre de Roca Negra y mata al general Drakkisath. Recoge su sangre y llévasela a Rexxar."
Lang["Q1_4182"] = "La amenaza de los dragonantes"			-- https://es.tbc.wowhead.com/quest=4182
Lang["Q2_4182"] = "Mata 15 cachorrillos negros, 10 dragauros negros, 4 vermis negros y 1 draco negro. Vuelve junto a Helendis Rivacuerno cuando hayas acabado la tarea."
Lang["Q1_4183"] = "Los verdaderos maestros"			-- https://es.tbc.wowhead.com/quest=4183
Lang["Q2_4183"] = "Viaja a Villa del Lago y entrégale la carta de Helendis Rivacuerno al magistrado Salomón."
Lang["Q1_4184"] = "Los verdaderos maestros"			-- https://es.tbc.wowhead.com/quest=4184
Lang["Q2_4184"] = "Ve a Ventormenta para entregar la petición de ayuda de Solomon al Gran Señor Bolvar Fordragon.\n\nVive en el Castillo de Ventormenta."
Lang["Q1_4185"] = "Los verdaderos maestros"			-- https://es.tbc.wowhead.com/quest=4185
Lang["Q2_4185"] = "Habla con el Alto Señor Bolvar Fordragon después de hablar con Lady Katrana Prestor."
Lang["Q1_4186"] = "Los verdaderos maestros"			-- https://es.tbc.wowhead.com/quest=4186
Lang["Q2_4186"] = "Lleva el decreto de Bolvar al magistrado Salomón en la Villa del Lago."
Lang["Q1_4223"] = "Los verdaderos maestros"			-- https://es.tbc.wowhead.com/quest=4223
Lang["Q2_4223"] = "Habla con el alguacil Maxwell en Las Estepas Ardientes."
Lang["Q1_4224"] = "Los verdaderos maestros"			-- https://es.tbc.wowhead.com/quest=4224
Lang["Q2_4224"] = "Habla con John Andrajoso para averiguar el destino del alguacil Windsor y vuelve junto al alguacil Maxwell cuando hayas completado la tarea.\n\nRecuerdas que el alguacil Maxwell comentó algo sobre buscarlo en una cueva hacia el norte."
Lang["Q1_4241"] = "El alguacil Windsor"			-- https://es.tbc.wowhead.com/quest=4241
Lang["Q2_4241"] = "Viaja a la Montaña Roca Negra al noroeste y adéntrate en las Profundidades de Roca Negra. Averigua qué le ha ocurrido al alguacil Windsor.\n\nRecuerdas que John Andrajoso había comentado que se habían llevado a una cárcel a Windsor."
Lang["Q1_4242"] = "Esperanza perdida"			-- https://es.tbc.wowhead.com/quest=4242
Lang["Q2_4242"] = "Dale las malas noticias a alguacil Maxwell."
Lang["Q1_4264"] = "Una nota arrugada"			-- https://es.tbc.wowhead.com/quest=4264
Lang["Q2_4264"] = "Puede que acabes de toparte con algo que le interesaría ver al alguacil Windsor. Puede que haya esperanza, después de todo."
Lang["Q1_4282"] = "Una esperanza hecha trizas"			-- https://es.tbc.wowhead.com/quest=4282
Lang["Q2_4282"] = "Devuélvele al alguacil Windsor la información perdida.\n\nEl alguacil Windsor cree que la información está siendo retenida en manos del Señor Gólem Argelmach y del general Forjira."
Lang["Q1_4322"] = "La fuga de la prisión"			-- https://es.tbc.wowhead.com/quest=4322
Lang["Q2_4322"] = "Ayuda al alguacil Windsor a recuperar su equipo y a liberar a sus amigos. Vuelve junto al alguacil Maxwell si lo consigues."
Lang["Q1_6402"] = "Tienes un cita en Ventormenta"			-- https://es.tbc.wowhead.com/quest=6402
Lang["Q2_6402"] = "Viaja hasta Ventormenta y aventúrate tras las puertas de la ciudad. Habla con el escudero Rowe para que haga saber al alguacil Windsor sobre tu llegada."
Lang["Q1_6403"] = "La gran farsa"			-- https://es.tbc.wowhead.com/quest=6403
Lang["Q2_6403"] = "Sigue a Reginald Windsor por Ventormenta. ¡Protégele del peligro!"
Lang["Q1_6501"] = "El Ojo del dragón"			-- https://es.tbc.wowhead.com/quest=6501
Lang["Q2_6501"] = "Debes buscar por todo el mundo y encontrar un ser capaz de restaurar el poder del fragmento del Ojo del dragón. La única información que tienes sobre dicho ser, es que existe."
Lang["Q1_6502"] = "Amuleto Pirodraco"			-- https://es.tbc.wowhead.com/quest=6502
Lang["Q2_6502"] = "Tienes que recuperar la sangre de dragón negro campeón, la tiene el general Drakkisath. Puedes encontrar a Drakkisath en su sala del trono, tras las Salas de la Ascensión, en la Cumbre de Roca Negra."
Lang["Q1_7761"] = "La orden de Puño Negro"			-- https://es.tbc.wowhead.com/quest=7761
Lang["Q2_7761"] = "¡Será estúpido ese orco! Al parecer, tienes que encontrar esta señal y ganar la marca de Drakkisath para poder acceder al orbe de orden.\n\nSegún la carta, el general Drakkisath guarda la señal. Quizás deberías investigarlo."
Lang["Q1_9121"] = "La ciudadela del terror: Naxxramas"			-- https://es.tbc.wowhead.com/quest=9121
Lang["Q2_9121"] = "La archimaga Angela Dosantos de la Capilla de la Esperanza de la Luz, en las Tierras de la Peste del Este, quiere 5 cristales arcanos, 2 cristales Nexus, 1 cristal de rectitud y 60 piezas de oro. También debes ser Honorable con el Alba Argenta."
Lang["Q1_9122"] = "La ciudadela del terror: Naxxramas"			-- https://es.tbc.wowhead.com/quest=9122
Lang["Q2_9122"] = "La archimaga Angela Dosantos de la Capilla de la Esperanza de la Luz, en las Tierras de la Peste del Este, quiere 2 cristales arcanos, 1 cristal Nexus y 30 piezas de oro. También tdebes ser Reverenciado con el Alba Argenta."
Lang["Q1_9123"] = "La ciudadela del terror: Naxxramas"			-- https://es.tbc.wowhead.com/quest=9123
Lang["Q2_9123"] = "La archimaga Angela Dosantos de la Capilla de la Esperanza de la Luz, en las Tierras de la Peste del Este, se ofrece a costear tu capa arcana. También debes ser Exaltado con el Alba Argenta. "
Lang["Q1_8286"] = "Lo que nos depara el futuro"			-- https://es.tbc.wowhead.com/quest=8286
Lang["Q2_8286"] = "Ve a las Cavernas del Tiempo y encuentra a Anacronos, del Linaje de Nozdormu."
Lang["Q1_8288"] = "Solo uno puede alzarse"			-- https://es.tbc.wowhead.com/quest=8288
Lang["Q2_8288"] = "Lleva la cabeza del Señor de prole Capazote a Baristolth del Mar de Dunas al Fuerte Cenarion en Silithus."
Lang["Q1_8301"] = "El buen camino"			-- https://es.tbc.wowhead.com/quest=8301
Lang["Q2_8301"] = "Lleva 200 fragmentos de caparazón de silítido a Baristolth."
Lang["Q1_8303"] = "Anachronos"			-- https://es.tbc.wowhead.com/quest=8303
Lang["Q2_8303"] = "Busca a Anacronos en las Cavernas del Tiempo de Tanaris."
Lang["Q1_8305"] = "Recuerdos olvidados"			-- https://es.tbc.wowhead.com/quest=8305
Lang["Q2_8305"] = "Encuentra la lágrima cristalina en Silithus y mira en sus profundidades."
Lang["Q1_8519"] = "Un peón en el ajedrez de la vida"			-- https://es.tbc.wowhead.com/quest=8519
Lang["Q2_8519"] = "Aprende todo lo que puedas del pasado y habla con Anacronos en las Cavernas del Tiempo de Tanaris."
Lang["Q1_8555"] = "Encomienda a los Vuelos"			-- https://es.tbc.wowhead.com/quest=8555
Lang["Q2_8555"] = "Eranikus, Vaelastrasz, and Azuregos... No doubt you know of these dragons, mortal. It is no coincidence, then, that they have played such influential roles as watchers of our world.\n\nUnfortunately (and my own naivety is partially to blame) whether by agents of the Old Gods or betrayal by those that would call them friend, each guardian has fallen to tragedy. The extent of which has fueled my own distrust towards your kind.\n\nSeek them out... And prepare yourself for the worst."
Lang["Q1_8730"] = "La corrupción de Nefarius"			-- https://es.tbc.wowhead.com/quest=8730
Lang["Q2_8730"] = "Mata a Nefarian y recupera del fragmento de cetro rojo. Llévaselo a Anacronos a las Cavernas del Tiempo, en Tanaris. Tienes 5 horas para completar esta tarea."
Lang["Q1_8733"] = "Eranikus, el Tirano del Sueño"			-- https://es.tbc.wowhead.com/quest=8733
Lang["Q2_8733"] = "Viaja al continente de Teldrassil y busca al agente de Malfurión. Lo encontrarás a lo largo de los muros de Darnassus."
Lang["Q1_8734"] = "Tyrande y Rémulos"			-- https://es.tbc.wowhead.com/quest=8734
Lang["Q2_8734"] = "Ve a Claro de la Luna y habla con el guardián Remulos."
Lang["Q1_8735"] = "Corrupción de Pesadilla"			-- https://es.tbc.wowhead.com/quest=8735
Lang["Q2_8735"] = "Ve a los 4 Portales del Sueño Esmeralda de Azeroth y recoge un fragmento de la corrupción de la Pesadilla en cada uno. Habla otra vez con el guardián Remulos en Claro de la Luna cuando hayas completado la tarea."
Lang["Q1_8736"] = "La Pesadilla se manifiesta"			-- https://es.tbc.wowhead.com/quest=8736
Lang["Q2_8736"] = "Defiende Amparo de la Noche de Eranikus. No dejes morir al guardián Remulos. No mates a Eranikus. Defiéndete. Espera a Tyrande."
Lang["Q1_8741"] = "El regreso del campeón"			-- https://es.tbc.wowhead.com/quest=8741
Lang["Q2_8741"] = "Lleva el fragmento de cetro verde a Anacronos a las Cavernas del Tiempo, en Tanaris. "
Lang["Q1_8575"] = "El libro de contabilidad mágico de Azuregos"			-- https://es.tbc.wowhead.com/quest=8575
Lang["Q2_8575"] = "Entrega el libro de contabilidad mágico de Azuregos a Narain Sabelotodo de Tanaris."
Lang["Q1_8576"] = "La traducción del libro de contabilidad"			-- https://es.tbc.wowhead.com/quest=8576
Lang["Q2_8576"] = "¡Lo primero es lo primero! Necesitamos averiguar qué escribió Azuregos en este libro de cuentas.\n\n¿Dices que te ha dicho que hagas una boya de arcanita y que este es el esquema? Es extraño que escribiera esto en dracónico. Esa vieja cabra sabe que no puedo leer estas tonterías.\n\nSi esto va a funcionar, voy a necesitar mis anteojos de adivinación, un pollo de quinientas libras y el volumen II de 'Dracónico para torpes'. No necesariamente en ese orden."
Lang["Q1_8597"] = "Dracónico para torpes"			-- https://es.tbc.wowhead.com/quest=8597
Lang["Q2_8597"] = "Encuentra el libro de Narain Sabelotodo. Está enterrado en una isla de los Mares del Sur."
Lang["Q1_8599"] = "Una canción de amor para Narain"			-- https://es.tbc.wowhead.com/quest=8599
Lang["Q2_8599"] = "Lleva la carta de amor de Meridith a Narain Sabelotodo a Tanaris."
Lang["Q1_8598"] = "ReScaTe"			-- https://es.tbc.wowhead.com/quest=8598
Lang["Q2_8598"] = "Lleva la carta del rescate a Narain Sabelotodo a Tanaris."
Lang["Q1_8606"] = "Señuelo"			-- https://es.tbc.wowhead.com/quest=8606
Lang["Q2_8606"] = "Narain Sabelotodo de Tanaris quiere que viajes a Cuna del Invierno y coloques la bolsa de oro en el punto de entrega indicado por los secuestralibros."
Lang["Q1_8620"] = "La única receta"			-- https://es.tbc.wowhead.com/quest=8620
Lang["Q2_8620"] = "Recupera los 8 capítulos perdidos de Dracónico para torpes, únelos con la cubierta mágica y devuelve el libro completo Dracónico para torpes: Volumen II a Narain Sabelotodo de Tanaris."
Lang["Q1_8584"] = "¡Nunca me preguntes por mi negocio!"			-- https://es.tbc.wowhead.com/quest=8584
Lang["Q2_8584"] = "Narain Sabelotodo de Tanaris quiere que hables con Dirge Hojágil de Gadgetzan."
Lang["Q1_8585"] = "La Isla del Terror"			-- https://es.tbc.wowhead.com/quest=8585
Lang["Q2_8585"] = "Lleva el cadáver de Lakmaeran y 20 costillitas tiernas de quimerok a Dirge Hojágil a Tanaris."
Lang["Q1_8586"] = "Pinchos quimerok potentes de Dirge"			-- https://es.tbc.wowhead.com/quest=8586
Lang["Q2_8586"] = "Dirge Hojágil de Gadgetzan quiere que le lleves 20 unidades de combustible de cohete goblin y 20 de sal de roca."
Lang["Q1_8587"] = "Vuelve con Narain"			-- https://es.tbc.wowhead.com/quest=8587
Lang["Q2_8587"] = "Entrega el pollo de 200 kilos a Narain Sabelotodo de Tanaris."
Lang["Q1_8577"] = "Stewvul, ex mejor amigo"			-- https://es.tbc.wowhead.com/quest=8577
Lang["Q2_8577"] = "Narain Sabelotodo quiere que encuentres a su ex mejor amigo de toda la vida, Guisón, y que recuperes las gafas que le robó."
Lang["Q1_8578"] = "¿Unas gafas? ¡Sin problemas!"			-- https://es.tbc.wowhead.com/quest=8578
Lang["Q2_8578"] = "Encuentra las gafas de Narain y llévaselas a Tanaris. "
Lang["Q1_8728"] = "Buenas y malas noticias"			-- https://es.tbc.wowhead.com/quest=8728
Lang["Q2_8728"] = "Narain Sabelotodo de Tanaris quiere que le lleves 20 lingotes de arcanita, 10 menas de elementium, 10 diamantes de Azeroth y 10 zafiros azules."
Lang["Q1_8729"] = "La cólera de Neptulon"			-- https://es.tbc.wowhead.com/quest=8729
Lang["Q2_8729"] = "Utiliza la boya de arcanita en el maelstrom espiral de la Bahía de la Tempestad de Azshara."
Lang["Q1_8742"] = "El poder de Kalimdor"			-- https://es.tbc.wowhead.com/quest=8742
Lang["Q2_8742"] = "Han pasado mil años y, tal como estaba destinado, uno está frente a mí. Uno que guiará a su pueblo a una nueva era.\n\nEl Dios antiguo tiembla. Oh, sí, teme tu fe. Rompe la profecía de C'Thun.\n\nSabe que vienes, campeón, y contigo viene el poder de Kalimdor. Sólo tienes que avisarme cuando estés preparado y te concederé el Cetro del Mar de Dunas."
Lang["Q1_8745"] = "El tesoro del Atemporal"			-- https://es.tbc.wowhead.com/quest=8745
Lang["Q2_8745"] = "Saludos, campeón. Soy Jonathan, guardián del gong sagrado y vigilante eterno del Vuelo de Bronce.\n\nHe recibido el poder del propio Atemporal para otorgarte un objeto de tu elección de su tesoro atemporal. Que te ayude en tus guerras contra C'Thun."


-- QUESTS - TBC
Lang["Q1_10755"] = "Entrada a la Ciudadela"			-- https://es.tbc.wowhead.com/quest=10755
Lang["Q2_10755"] = "Lleva el molde de llave preparado a Nazgrel a Thrallmar en la Península del Fuego Infernal."
Lang["Q1_10756"] = "Gran maestro Rohok"			-- https://es.tbc.wowhead.com/quest=10756
Lang["Q2_10756"] = "Lleva el molde de llave preparado a Rohok a Thrallmar, en la Península del Fuego Infernal."
Lang["Q1_10757"] = "La petición de Rohok"			-- https://es.tbc.wowhead.com/quest=10757
Lang["Q2_10757"] = "Trae 4 Barras de hierro vil, 2 Polvo Arcano and 4 Motas de fuego a Rohok en Thrallmar, Península del Fuego Infernal."
Lang["Q1_10758"] = "Más caliente que el infierno"			-- https://es.tbc.wowhead.com/quest=10758
Lang["Q2_10758"] = "Destruye un atracador vil en la Península del Fuego Infernal e introduce el molde de llave sin templar en sus entrañas. Lleva el molde de llave carbonizado a Rohok en Thrallmar."
Lang["Q1_10754"] = "Entrada a la Ciudadela"			-- https://es.tbc.wowhead.com/quest=10754
Lang["Q2_10754"] = "Lleva el molde de llave preparado al comandante en jefe Danath al Bastión del Honor en la Península del Fuego Infernal."
Lang["Q1_10762"] = "Gran Maestro Dumphry"			-- https://es.tbc.wowhead.com/quest=10762
Lang["Q2_10762"] = "Lleva el molde de llave primordial a Dumphry, al Bastión del Honor."
Lang["Q1_10763"] = "La petición de Dumphry"			-- https://es.tbc.wowhead.com/quest=10763
Lang["Q2_10763"] = "Lleva cuatro barras de hierro vil, dos polvos Arcanos y cuatro motas de fuego a Dumphry, al Bastión del Honor, de la Península del Fuego Infernal. "
Lang["Q1_10764"] = "Más caliente que el infierno"			-- https://es.tbc.wowhead.com/quest=10764
Lang["Q2_10764"] = "Destruye un atracador vil en la Península del Fuego Infernal y sumerge el molde de llave sin templar en sus restos. Lleva el molde de llave carbonizado a Dumphry, al Bastión del Honor."
Lang["Q1_10279"] = "La caverna del maestro"			-- https://es.tbc.wowhead.com/quest=10279
Lang["Q2_10279"] = "Habla con Andormu en las Cavernas del Tiempo."
Lang["Q1_10277"] = "Las Cavernas del Tiempo"			-- https://es.tbc.wowhead.com/quest=10277
Lang["Q2_10277"] = "Andormu de las Cavernas del Tiempo quiere que sigas a la custodia del Tiempo."
Lang["Q1_10282"] = "Antigua Trabalomas"			-- https://es.tbc.wowhead.com/quest=10282
Lang["Q2_10282"] = "Andormu de las Cavernas del Tiempo quiere que vayas a la Antigua Trabalomas para hablar con Erozion."
Lang["Q1_10283"] = "La maniobra de Taretha"			-- https://es.tbc.wowhead.com/quest=10283
Lang["Q2_10283"] = "Ve al Castillo de Durnholde y coloca 5 cargas incendiarias del paquete de bombas incendiarias que te dio Erozion en los barriles que hay en cada pabellón de internamiento."
Lang["Q1_10284"] = "Huida de Durnholde"			-- https://es.tbc.wowhead.com/quest=10284
Lang["Q2_10284"] = "Cuando estés para proceder, díselo a Thrall. Sigue a Thrall al exterior del Castillo de Durnholde y ayúdale a liberar a Taretha y así cumplir su destino."
Lang["Q1_10285"] = "Regresa junto a Andormu"			-- https://es.tbc.wowhead.com/quest=10285
Lang["Q2_10285"] = "Regresa junto al niño, Andormu, en las Cavernas del Tiempo, en el Desierto de Tanaris."
Lang["Q1_10265"] = "Colección de cristales de El Consorcio"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10265
Lang["Q2_10265"] = "Consigue un artefacto de cristal de Arklon y llévaselo al acechador abisal Khay'ji al Área 52 en Tormenta Abisal."
Lang["Q1_10262"] = "Un montón de etéreos"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10262
Lang["Q2_10262"] = "Recoge 10 insignias de Zaxxis y llévaselas al acechador abisal Khay'ji al Área 52 en Tormenta Abisal."
Lang["Q1_10205"] = "Asaltante de distorsión Nesaad"			-- https://es.tbc.wowhead.com/quest=10205
Lang["Q2_10205"] = "Mata al asaltante de distorsión Nesaad y ve a ver al acechador abisal Khay'ji al Área 52 en Tormenta Abisal."
Lang["Q1_10266"] = "Petición de ayuda"			-- https://es.tbc.wowhead.com/quest=10266
Lang["Q2_10266"] = "Busca a Gahruj y ofrécele tus servicios. Se encuentra en el Puesto de la Tierra Media, en el Ecodomo de la Tierra Media de Tormenta Abisal."
Lang["Q1_10267"] = "Legítima recuperación"			-- https://es.tbc.wowhead.com/quest=10267
Lang["Q2_10267"] = "Coge 10 cajas de equipo de análisis y llévaselas a Gahruj al Puesto de la Tierra Media, en el Ecodomo de la Tierra Media, en Tormenta Abisal."
Lang["Q1_10268"] = "Una audiencia con el príncipe"			-- https://es.tbc.wowhead.com/quest=10268
Lang["Q2_10268"] = "Entrega el equipo de análisis a la Imagen del príncipe-nexo Haramad en Flecha de la Tormenta, en Tormenta Abisal."
Lang["Q1_10269"] = "Punto de triangulación uno"			-- https://es.tbc.wowhead.com/quest=10269
Lang["Q2_10269"] = "Usa el aparato de triangulación para localizar el primer punto de triangulación. Informa de su ubicación al tratante Hazzin en la Avanzada del Protectorado en la isla de la Forja de Maná Ultris en Tormenta Abisal."
Lang["Q1_10275"] = "Punto de triangulación dos"			-- https://es.tbc.wowhead.com/quest=10275
Lang["Q2_10275"] = "Usa el aparato de triangulación para localizar el segundo punto de triangulación. Informa al comerciante de viento Tuluman en Alto de Tuluman, justo al cruzar el puente de la isla de Forja de Maná Ara en Tormenta Abisal."
Lang["Q1_10276"] = "Triángulo completo"			-- https://es.tbc.wowhead.com/quest=10276
Lang["Q2_10276"] = "Recupera el cristal de Ata'mal y dáselo a la imagen del príncipe-nexo Haramad en Flecha de la Tormenta, en Tormenta Abisal."
Lang["Q1_10280"] = "Una entrega especial a la Ciudad de Shattrath"			-- https://es.tbc.wowhead.com/quest=10280
Lang["Q2_10280"] = "Entrega el cristal de Ata'mal a A'dal en el Bancal de la Luz en la Ciudad de Shattrath."
Lang["Q1_10704"] = "Cómo infiltrarse en El Arcatraz"			-- https://es.tbc.wowhead.com/quest=10704
Lang["Q2_10704"] = "A'dal te ha encargado que recuperes los fragmentos inferior y superior de la llave de Arcatraz. Devuélveselos y con ellos recreará la llave de El Arcatraz para ti."
Lang["Q1_9824"] = "Alteraciones arcanas"			-- https://es.tbc.wowhead.com/quest=9824
Lang["Q2_9824"] = "Utiliza el cristal de visión violeta cerca de fuentes subterráneas de agua en El Sótano del Maestro y vuelve a ver al archimago Alturus en las afueras de Karazhan."
Lang["Q1_9825"] = "Actividad incansable"			-- https://es.tbc.wowhead.com/quest=9825
Lang["Q2_9825"] = "Lleva 10 esencias fantasmales al archimago Alturus en las afueras de Karazhan."
Lang["Q1_9826"] = "Contacto de Dalaran"			-- https://es.tbc.wowhead.com/quest=9826
Lang["Q2_9826"] = "Lleva el informe de Alturus al archimago Cedric en la afueras del Cráter de Dalaran."
Lang["Q1_9829"] = "Khadgar"			-- https://es.tbc.wowhead.com/quest=9829
Lang["Q2_9829"] = "Lleva el informe de Alturus a Khadgar en la Ciudad de Shattrath, en el Bosque de Terokkar."
Lang["Q1_9831"] = "La entrada a Karazhan"			-- https://es.tbc.wowhead.com/quest=9831
Lang["Q2_9831"] = "Khadgar quiere que entres en el Laberinto de las Sombras en Auchindoun y recuperes el primer trozo de la llave de un contenedor arcano que está escondido allí."
Lang["Q1_9832"] = "El segundo y tercer trozo"			-- https://es.tbc.wowhead.com/quest=9832
Lang["Q2_9832"] = "Consigue el segundo trozo de la llave, que está en un contenedor arcano en la Reserva Colmillo Torcido, y el tercer trozo de la llave, que está en otro contenedor arcano en El Castillo de la Tempestad. Vuelve a ver a Khadgar en la Ciudad de Shattrath cuando lo hayas hecho."
Lang["Q1_9836"] = "El toque del maestro"			-- https://es.tbc.wowhead.com/quest=9836
Lang["Q2_9836"] = "Ve a las Cavernas del Tiempo y convence a Medivh para que active tu llave de aprendiz restaurada."
Lang["Q1_9837"] = "Regresa junto a Khadgar"			-- https://es.tbc.wowhead.com/quest=9837
Lang["Q2_9837"] = "Vuelve a ver a Khadgar en la Ciudad de Shattrath y enséñale la llave del maestro."
Lang["Q1_9838"] = "El Ojo Violeta"			-- https://es.tbc.wowhead.com/quest=9838
Lang["Q2_9838"] = "Habla con el Archimago Alturus fuera de Karazhan."
Lang["Q1_9630"] = "El diario de Medivh"			-- https://es.tbc.wowhead.com/quest=9630
Lang["Q2_9630"] = "El archimago Alturus, del Paso de la Muerte, quiere que vayas a Karazhan y hables con Wravien."
Lang["Q1_9638"] = "En buenas manos"			-- https://es.tbc.wowhead.com/quest=9638
Lang["Q2_9638"] = "Habla con Gradav en la Biblioteca del Guardián, en Karazhan."
Lang["Q1_9639"] = "Kamsis"			-- https://es.tbc.wowhead.com/quest=9639
Lang["Q2_9639"] = "Habla con Kamsis en la Biblioteca del Guardián, en Karazhan."
Lang["Q1_9640"] = "La sombra de Aran"			-- https://es.tbc.wowhead.com/quest=9640
Lang["Q2_9640"] = "Consigue el diario de Medivh y vuelve junto a Kamsis en la Biblioteca del Guardián, en Karazhan."
Lang["Q1_9645"] = "El Bancal del Maestro"			-- https://es.tbc.wowhead.com/quest=9645
Lang["Q2_9645"] = "Ve a El Bancal del Maestro en Karazhan y lee el diario de Medivh."
Lang["Q1_9680"] = "Resucitar el pasado"			-- https://es.tbc.wowhead.com/quest=9680
Lang["Q2_9680"] = "El archimago Alturus quiere que vayas a las montañas al sur de Karazhan en el Paso de la Muerte y consigas un trozo de hueso carbonizado."
Lang["Q1_9631"] = "La ayuda de una compañera"			-- https://es.tbc.wowhead.com/quest=9631
Lang["Q2_9631"] = "Lleva el trozo de hueso carbonizado a Kalynna Lathrojo en el Área 52 en Tormenta Abisal."
Lang["Q1_9637"] = "La petición de Kalynna"			-- https://es.tbc.wowhead.com/quest=9637
Lang["Q2_9637"] = "Kalynna Lathrojo quiere recuperar el Escrito del Ocaso del brujo supremo Malbisal en Las Salas Arrasadas de la Ciudadela del Fuego Infernal y el Libro de los Nombres Olvidados de Tejeoscuro Syth en las Salas Sethekk de Auchindoun."
Lang["Q1_9644"] = "Nocturno"			-- https://es.tbc.wowhead.com/quest=9644
Lang["Q2_9644"] = "Ve a El Bancal del Maestro en Karazhan y usa la urna ennegrecida para invocar a Nocturno. Recupera la esencia arcana intangible del cadáver de Nocturno y llévasela al archimago Alturus."
Lang["Q1_10901|13431"] = "La cayada de Kar'desh"			-- https://es.tbc.wowhead.com/quest=10901|13431
Lang["Q2_10901|13431"] = "Skar'this el Herético, en El Reciento de los Esclavos heroico, en la Reserva Colmillo Torcido, quiere que le lleves el sello terráneo y el sello llameante."
Lang["Q1_10900"] = "La marca de Vashj"			-- https://es.tbc.wowhead.com/quest=10900
Lang["Q2_10900"] = ""
Lang["Q1_10681"] = "La Mano de Gul'dan"			-- https://es.tbc.wowhead.com/quest=10681
Lang["Q2_10681"] = "Habla con el ensalmador de la tierra Torlok en El Altar de Condenación del Valle Sombraluna."
Lang["Q1_10458"] = "Espíritus de fuego y tierra iracundos"			-- https://es.tbc.wowhead.com/quest=10458
Lang["Q2_10458"] = "El ensalmador de la tierra Torlok en El Altar de Condenación, en el Valle Sombraluna, quiere que utilices el tótem de espíritus para capturar 8 almas de terráneos y 8 almas de ígneos."
Lang["Q1_10480"] = "Espíritus de agua iracundos"			-- https://es.tbc.wowhead.com/quest=10480
Lang["Q2_10480"] = "El ensalmador de la tierra Torlok de El Altar de Condenación, en el Valle Sombraluna, quiere que uses el tótem de espíritus para capturar 5 almas acuáticas."
Lang["Q1_10481"] = "Espíritus de aire iracundos"			-- https://es.tbc.wowhead.com/quest=10481
Lang["Q2_10481"] = "El ensalmador de la tierra Torlok de El Altar de Condenación, en el Valle Sombraluna, quiere que uses el tótem de espíritus para capturar 10 almas aéreas."
Lang["Q1_10513"] = "Oronok Corazón Roto"			-- https://es.tbc.wowhead.com/quest=10513
Lang["Q2_10513"] = "Busca a Oronok Corazón Roto en la Barrera Arrasada – al norte de la Cisterna Cicatriz Espiral."
Lang["Q1_10514"] = "Yo era muchas cosas..."			-- https://es.tbc.wowhead.com/quest=10514
Lang["Q2_10514"] = "Oronok Corazón Roto, de la Granja de Oronok, en el Valle Sombraluna, quiere que recuperes diez tubérculos de Sombraluna de las Llanuras Devastadas."
Lang["Q1_10515"] = "Una lección aprendida"			-- https://es.tbc.wowhead.com/quest=10515
Lang["Q2_10515"] = "Oronok Corazón Roto, de la Granja de Oronok, en el Valle Sombraluna, quiere que destruyas diez huevos de despellejador voraz de las Llanuras Devastadas."
Lang["Q1_10519"] = "La Clave de Condenación: historia y verdad"			-- https://es.tbc.wowhead.com/quest=10519
Lang["Q2_10519"] = "Oronok Corazón Roto, en la Granja de Oronok del Valle Sombraluna, quiere que escuches su relato. Habla con Oronok para comenzar a escuchar su relato."
Lang["Q1_10521"] = "Grom'tor, hijo de Oronok"			-- https://es.tbc.wowhead.com/quest=10521
Lang["Q2_10521"] = "Encuentra a Grom'tor, hijo de Oronok, en el Alto Cicatriz Espiral del Valle Sombraluna."
Lang["Q1_10527"] = "Ar'tor, hijo de Oronok"			-- https://es.tbc.wowhead.com/quest=10527
Lang["Q2_10527"] = "Encuentra a Ar'tor, hijo de Oronok, en el Alto Illidari del Valle Sombraluna."
Lang["Q1_10546"] = "Borak, hijo de Oronok"			-- https://es.tbc.wowhead.com/quest=10546
Lang["Q2_10546"] = "Encuentra a Borak, hijo de Oronok, cerca de Punta Eclipse, en el Valle Sombraluna."
Lang["Q1_10522"] = "La Clave de Condenación: La carga de Grom'tor"			-- https://es.tbc.wowhead.com/quest=10522
Lang["Q2_10522"] = "Grom'tor, hijo de Oronok, en el Alto Cicatriz Espiral del Valle Sombraluna, quiere que recuperes el primer fragmento de la Clave de Condenación."
Lang["Q1_10528"] = "Cárceles de cristal demoníacas"			-- https://es.tbc.wowhead.com/quest=10528
Lang["Q2_10528"] = "Busca a la maestra del dolor Gabrissa en el Alto Illidari, mátala y vuelve junto al cadáver de Ar'tor, hijo de Oronok, con la llave cristalina."
Lang["Q1_10547"] = "Sobre cabezacardos y huevos..."			-- https://es.tbc.wowhead.com/quest=10547
Lang["Q2_10547"] = "Borak, hijo de Oronok en el puente al norte de Punta Eclipse, quiere que encuentres un huevo de arakkoa podrido y se lo lleves a Tobias el Comeporquería en la Ciudad de Shattrath, al noroeste del Bosque de Terokkar."
Lang["Q1_10523"] = "La Clave de Condenación - Primer trozo recuperado"			-- https://es.tbc.wowhead.com/quest=10523
Lang["Q2_10523"] = "Lleva la caja fuerte de Grom'tor a Oronok Corazón Roto en la Granja de Oronok, en el Valle Sombraluna."
Lang["Q1_10537"] = "Lohn'goron, arco del corazón roto"			-- https://es.tbc.wowhead.com/quest=10537
Lang["Q2_10537"] = "El espíritu de Ar'tor en el Alto Illidari, en el Valle Sombraluna, quiere que recuperes Lohn'goron, arco del corazón roto. Lo tiene un demonio de la zona."
Lang["Q1_10550"] = "El fardo de cardos de sangre"			-- https://es.tbc.wowhead.com/quest=10550
Lang["Q2_10550"] = "Llévale el fardo de cardos de sangre a Borak, hijo de Oronok, en el puente próximo a la Punta Eclipse en el Valle Sombraluna."
Lang["Q1_10540"] = "La Clave de Condenación. La carga de Ar'tor"			-- https://es.tbc.wowhead.com/quest=10540
Lang["Q2_10540"] = "El espíritu de Ar'tor en el Alto Illidari, en el Valle Sombraluna, quiere que consigas el segundo trozo de la Clave de Condenación que tiene Veneratus el Múltiple."
Lang["Q1_10570"] = "Perder la cabeza... por unos cardos"			-- https://es.tbc.wowhead.com/quest=10570
Lang["Q2_10570"] = "Borak, hijo de Oronok, en el puente próximo a la Punta Eclipse en el Valle Sombraluna, quiere que recuperes la misiva de Tempestira."
Lang["Q1_10576"] = "Revuelo en Sombraluna"			-- https://es.tbc.wowhead.com/quest=10576
Lang["Q2_10576"] = "Borak, hijo de Oronok, en el puente próximo a la Punta Eclipse en el Valle Sombraluna, quiere que recuperes 6 piezas de armadura eclipsion"
Lang["Q1_10577"] = "Lo que Illidan quiere, lo consigue..."			-- https://es.tbc.wowhead.com/quest=10577
Lang["Q2_10577"] = "Borak, hijo de Oronok, en el puente próximo a la Punta Eclipse en el Valle Sombraluna, quiere que entregues el mensaje de Illidan al Gran Comandante Ruusk de Punta Eclipse."
Lang["Q1_10578"] = "La Clave de Condenación: La carga de Borak"			-- https://es.tbc.wowhead.com/quest=10578
Lang["Q2_10578"] = "Borak, hijo de Oronok, en el puente próximo a la Punta Eclipse en el Valle Sombraluna, quiere que recuperes la tercera parte de la Clave de Condenación de Ruul el Ensombrecedor."
Lang["Q1_10541"] = "La Clave de Condenación. Segundo trozo recuperado"			-- https://es.tbc.wowhead.com/quest=10541
Lang["Q2_10541"] = "Lleva la caja fuerte de Ar'tor a Oronok Corazón Roto en la Granja de Oronok, en el Valle Sombraluna."
Lang["Q1_10579"] = "La Clave de Condenación: Tercer trozo recuperado"			-- https://es.tbc.wowhead.com/quest=10579
Lang["Q2_10579"] = "Lleva la caja fuerte de Borak a Oronok Corazón Roto en la Granja de Oronok, en el Valle Sombraluna. "
Lang["Q1_10588"] = "La Clave de Condenación"			-- https://es.tbc.wowhead.com/quest=10588
Lang["Q2_10588"] = "Usa la Clave de Condenación en El Altar de Condenación para invocar a Cyrukh el señor del Fuego.\n\nDestruye a Cyrukh el señor del Fuego y habla con el ensalmador de la tierra Torlok, que también se encuentra en El Altar de Condenación."
Lang["Q1_10883"] = "La llave de la tempestad"			-- https://es.tbc.wowhead.com/quest=10883
Lang["Q2_10883"] = "Habla con A'dal en la Ciudad de Shattrath."
Lang["Q1_10884"] = "Prueba de los naaru: piedad"			-- https://es.tbc.wowhead.com/quest=10884
Lang["Q2_10884"] = "A'dal de la Ciudad de Shattrath quiere que recuperes el hacha del verdugo sin usar en Las Salas Arrasadas de la Ciudadela del Fuego Infernal."
Lang["Q1_10885"] = "Prueba de los naaru: fuerza"			-- https://es.tbc.wowhead.com/quest=10885
Lang["Q2_10885"] = "A'dal de la Ciudad de Shattrath quiere que recuperes el tridente de Kalithresh y la esencia de Murmullo.\n\nEsta misión debe completarse en dificultad de mazmorra heroica."
Lang["Q1_10886"] = "Prueba de los naaru: tenacidad"			-- https://es.tbc.wowhead.com/quest=10886
Lang["Q2_10886"] = "A'dal, de la Ciudad de Shattrath, quiere que rescates a Molino Tormenta de Maná del Arcatraz de El Castillo de la Tempestad."
Lang["Q1_10888|13430"] = "Prueba de los naaru: Magtheridon"			-- https://es.tbc.wowhead.com/quest=10888|13430
Lang["Q2_10888|13430"] = "A'dal en la Ciudad de Shattrath quiere que mates a Magtheridon."
Lang["Q1_10680"] = "La Mano de Gul'dan"			-- https://es.tbc.wowhead.com/quest=10680
Lang["Q2_10680"] = "Habla con el ensalmador de la tierra Torlok en El Altar de Condenación del Valle Sombraluna."
Lang["Q1_10445|13432"] = "Los viales de la eternidad"			-- https://es.tbc.wowhead.com/quest=10445|13432
Lang["Q2_10445|13432"] = "Soridormi de las Cavernas del Tiempo quiere que recuperes los restos del vial de Vashj de lady Vashj en la Reserva Colmillo Torcido, y los restos del vial de Kael de Kael'thas Caminante del Sol, en El Castillo de la Tempestad."
Lang["Q1_10568"] = "Las tablillas de Baa'ri"			-- https://es.tbc.wowhead.com/quest=10568
Lang["Q2_10568"] = "La anacoreta Ceyla del Altar de Sha'tar quiere que recojas 12 tablillas Baa'ri del suelo y de los trabajadores Lengua de Ceniza en las Ruinas de Baa'ri.\n\nCompletar misiones para los Aldor hará que disminuya tu nivel de reputación con los Arúspices."
Lang["Q1_10683"] = "Las tablillas de Baa'ri"			-- https://es.tbc.wowhead.com/quest=10683
Lang["Q2_10683"] = "El arcanista Thelis del Sagrario de las Estrellas quiere que consigas 12 tablillas Baa'ri en las Ruinas de Baa'ri.\n\nCompletar misiones para los Arúspices hará que tu nivel de reputación entre los Aldor descienda."
Lang["Q1_10571"] = "Oronu the Elder"			-- https://es.tbc.wowhead.com/quest=10571
Lang["Q2_10571"] = "Anchorite Ceyla at the Altar of Sha'tar wants you to obtain the Orders from Akama from Oronu the Elder at the Ruins of Baa'ri.\n\nCompletar misiones para los Aldor hará que disminuya tu nivel de reputación con los Arúspices."
Lang["Q1_10684"] = "Oronu el Anciano"			-- https://es.tbc.wowhead.com/quest=10684
Lang["Q2_10684"] = "El arcanista Thelis del Sagrario de las Estrellas quiere que consigas las órdenes de Akama de Oronu el Anciano en las Ruinas de Baa'ri.\n\nCompletar misiones para los Arúspices hará que tu nivel de reputación entre los Aldor descienda."
Lang["Q1_10574"] = "Los corruptores Lengua de Ceniza"			-- https://es.tbc.wowhead.com/quest=10574
Lang["Q2_10574"] = "Recupera los 4 trozos de los medallones de Haalum, Eykenen, Lakaan y Uylaru, y regresa junto a la anacoreta Ceyla del Altar de Sha'tar, en el Valle Sombraluna.\n\nCompletar misiones para los Aldor hará que disminuya tu nivel de reputación con los Arúspices."
Lang["Q1_10685"] = "Los corruptores Lengua de Ceniza"			-- https://es.tbc.wowhead.com/quest=10685
Lang["Q2_10685"] = "Recupera los 4 trozos de los medallones de Haalum, Eykenen, Lakaan y Uylaru, regresa junto al arcanista Thelis del Sagrario de las Estrellas, en el Valle Sombraluna.\n\nA medida que completas misiones para los Arúspices disminuye tu nivel de reputación con los Aldor. "
Lang["Q1_10575"] = "The Warden's Cage"			-- https://es.tbc.wowhead.com/quest=10575
Lang["Q2_10575"] = "La anacoreta Ceyla quiere que entres en la Jaula de la Guardiana, al sur de las Ruinas de Baa'ri, e interrogues a Sanoru sobre el paradero de Akama.\n\nCompletar misiones para los Aldor hará que disminuya tu nivel de reputación con los Arúspices."
Lang["Q1_10686"] = "La Jaula de la Guardiana"			-- https://es.tbc.wowhead.com/quest=10686
Lang["Q2_10686"] = "La Anacoreta Ceyla quiere que entres en la Jaula de la Guardiana, al sur de las Ruinas de Baa'ri, e interrogues a Sanoru sobre el paradero de Akama.\n\nCompletar misiones para los Arúspices hará que tu nivel de reputación entre los Aldor descienda."
Lang["Q1_10622"] = "Prueba de lealtad"			-- https://es.tbc.wowhead.com/quest=10622
Lang["Q2_10622"] = "Mata a Zandras en la Jaula de la Guardiana, en el Valle Sombraluna y vuelve a ver a Sanoru."
Lang["Q1_10628"] = "Akama"			-- https://es.tbc.wowhead.com/quest=10628
Lang["Q2_10628"] = "Habla con Akama en la cámara oculta, en la Jaula de la Guardiana."
Lang["Q1_10705"] = "El vidente Udalo"			-- https://es.tbc.wowhead.com/quest=10705
Lang["Q2_10705"] = "Encuentra al vidente Udalo en el interior de El Arcatraz, en El Castillo de la Tempestad."
Lang["Q1_10706"] = "Un misterioso portento"			-- https://es.tbc.wowhead.com/quest=10706
Lang["Q2_10706"] = "Regresa junto a Akama en la Jaula de la Guardiana, en el Valle Sombraluna. "
Lang["Q1_10707"] = "El bancal de Ata'mal"			-- https://es.tbc.wowhead.com/quest=10707
Lang["Q2_10707"] = "Sube a lo más alto del Bancal de Ata'mal en el Valle Sombraluna y consigue el corazón de furia. Regresa junto a Akama, en la Jaula de la Guardiana en el Valle Sombraluna, cuando completes la misión."
Lang["Q1_10708"] = "La promesa de Akama"			-- https://es.tbc.wowhead.com/quest=10708
Lang["Q2_10708"] = "Llévale el medallón de Karabor a A'dal en la Ciudad de Shattrath."
Lang["Q1_10944"] = "El secreto en peligro"			-- https://es.tbc.wowhead.com/quest=10944
Lang["Q2_10944"] = "Viaja hasta la Jaula de la Guardiana del Valle Sombraluna y habla con Akama."
Lang["Q1_10946"] = "Artimaña de los Lengua de Ceniza"			-- https://es.tbc.wowhead.com/quest=10946
Lang["Q2_10946"] = "Viaja hasta El Castillo de la Tempestad y mata a Al'ar con la capucha de Lengua de Ceniza puesta. Vuelve junto a Akama en el Valle Sombraluna cuando hayas terminado."
Lang["Q1_10947"] = "Un artefacto del pasado"			-- https://es.tbc.wowhead.com/quest=10947
Lang["Q2_10947"] = "Ve a las Cavernas del Tiempo en Tanaris y consigue entrar en la Batalla del Monte Hyjal. Una vez dentro, vence a Ira Fríoinvierno y llévale la filacteria de fase temporal a Akama en el Valle Sombraluna."
Lang["Q1_10948"] = "El alma rehén"			-- https://es.tbc.wowhead.com/quest=10948
Lang["Q2_10948"] = "Viaja hasta la Ciudad de Shattrath y háblale a A'dal de lo que pide Akama."
Lang["Q1_10949"] = "La entrada a El Templo Oscuro"			-- https://es.tbc.wowhead.com/quest=10949
Lang["Q2_10949"] = "Viaja hasta la entrada del Templo Oscuro en el Valle Sombraluna y habla con Xi'ri."
Lang["Q1_10985|13429"] = "Una distracción para Akama"			-- https://es.tbc.wowhead.com/quest=10985|13429
Lang["Q2_10985|13429"] = "Asegúrate de que Akama y Maiev entran en El Templo Oscuro, en el Valle Sombraluna, cuando las fuerzas de Xi'ri creen una distracción."
--v243
Lang["Q1_10984"] = "Habla con el ogro"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10984
Lang["Q2_10984"] = "Habla con Grok, el ogro, en el Bajo Arrabal de la Ciudad de Shattrath."
Lang["Q1_10983"] = "Mog'dorg el Marchito"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10983
Lang["Q2_10983"] = "Visita a Mog'dorg el Marchito en lo alto de una de las torres que hay justo fuera del Anillo de Sangre en las Montañas Filospada."
Lang["Q1_10995"] = "Grulloc tiene dos calaveras"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10995
Lang["Q2_10995"] = "Consigue la calavera de dragón de Grulloc y llévasela a Mog'dorg el Marchito, que se encuentra en lo alto de la torre del Anillo de Sangre en las Montañas Filospada."
Lang["Q1_10996"] = "Cofre del tesoro de Maggoc"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10996
Lang["Q2_10996"] = "Consigue el cofre del tesoro de Maggoc y llévaselo a Mog'dorg el Marchito, que se encuentra en lo alto de la torre del Anillo de Sangre de las Montañas Filospada."
Lang["Q1_10997"] = "Incluso los gronn tienen confalones"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10997
Lang["Q2_10997"] = "Consigue el confalón de Slaag y llévaselo a Mog'dorg el Marchito, que se encuentra en lo alto de la torre del Anillo de Sangre en las Montañas Filospada."
Lang["Q1_10998"] = "Un asunto grimoso"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10998
Lang["Q2_10998"] = "Debes conseguir el grimorio de Vim'gol el Vil. Llévaselo a Mog'dorg el Marchito, que se encuentra en lo alto de la torre del Anillo de Sangre, en las Montañas Filospada."
Lang["Q1_11000"] = "Dentro del Moledor de Almas"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11000
Lang["Q2_11000"] = "Recupera el alma de Skulloc y llévasela a Mog'dorg el Marchito, que se encuentra en lo alto de la torre del Anillo de Sangre en las Montañas Filospada."
Lang["Q1_11022"] = "Habla con Mog'dorg"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11022
Lang["Q2_11022"] = "Habla con Mog'dorg el Marchito. Se encuentra en lo alto de la torre al este del Anillo de Sangre, en las Montañas Filospada."
Lang["Q1_11009"] = "El cielo de los Ogros"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11009
Lang["Q2_11009"] = "Mog'dorg el Marchito te ha pedido que hables con Chu'a'lor en Ogri'la, en las Montañas Filospada."
--v244
Lang["Q1_10804"] = "Bondad"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10804
Lang["Q2_10804"] = "Mordenai, de los Campos del Ala Abisal, en el Valle Sombraluna, quiere que alimentes a ocho dracos Ala Abisal maduros."
Lang["Q1_10811"] = "Buscar a Neltharaku"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10811
Lang["Q2_10811"] = "Busca a Nelthakaru, patrón de los dracos Ala Abisal."
Lang["Q1_10814"] = "La historia de Neltharaku"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10814
Lang["Q2_10814"] = "Habla con Neltharaku y escucha su historia."
Lang["Q1_10836"] = "Infiltrarse en la Fortaleza Faucedraco"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10836
Lang["Q2_10836"] = "Neltharaku, que sobrevuela los Campos del Ala Abisal en el Valle Sombraluna, quiere que mates a quince orcos Faucedraco."
Lang["Q1_10837"] = "¡Al Arrecife del Ala Abisal!"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10837
Lang["Q2_10837"] = "Neltharaku, que sobrevuela los Campos del Ala Abisal en el Valle Sombraluna, quiere que recojas doce cristales de vid abisal del Arrecife del Ala Abisal."
Lang["Q1_10854"] = "La fuerza de Neltharaku"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10854
Lang["Q2_10854"] = "Neltharaku, que sobrevuela los Campos del Ala Abisal, en el Valle Sombraluna, quiere que liberes a 5 dracos Ala Abisal esclavizados."
Lang["Q1_10858"] = "Karynaku"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10858
Lang["Q2_10858"] = "Busca a Karynaku en la Fortaleza Faucedraco."
Lang["Q1_10866"] = "Zuluhed el Demente"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10866
Lang["Q2_10866"] = "Mata a Zuluhed el Demente y consigue la llave de Zuluhed. Utiliza la llave de Zuluhed en las cadenas de Zuluhed para liberar a Karynaku."
Lang["Q1_10870"] = "Aliado del Ala Abisal"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10870
Lang["Q2_10870"] = "Que Karynaku te devuelva a Mordenai en los Campos del Ala Abisal."
--v247
Lang["Q1_3801"] = "El legado de los Hierro Negro"			-- https://www.thegeekcrusade-serveur.com/db/?quest=3801
Lang["Q2_3801"] = "Habla con Franclorn Forjafina si te interesa obtener una llave de la ciudad."
Lang["Q1_3802"] = "El legado de los Hierro Negro"			-- https://www.thegeekcrusade-serveur.com/db/?quest=3802
Lang["Q2_3802"] = "Mata a Finoso Virunegro y recupera el gran martillo, Ferrovil. Lleva a Ferrovil al Santuario de Thaurissan y coloca el martillo en la estatua de Franclorn Forjafina."
Lang["Q1_5096"] = "Desvío Escarlata"
Lang["Q2_5096"] = "Adéntrate en el campamento base de la Cruzada Escarlata entre el Campo de Piedra Mácula y el Llanto de Dalson y destruye su tienda de mando."
Lang["Q1_5098"] = "Todas las torres"
Lang["Q2_5098"] = "Con la Antorcha de aviso, marca las torres de Andorhal. Tendrás que estar en la entrada de la torre para poder marcarla."
Lang["Q1_838"] = "Scholomance"
Lang["Q2_838"] = "Habla con el boticario Dithers en el Baluarte, en las Tierras de la Peste del Oeste."
Lang["Q1_964"] = "Fragmentos esqueléticos"
Lang["Q2_964"] = "Lleva 15 fragmentos esqueléticos al boticario Dithers en El Baluarte, en las Tierras de la Peste del Oeste."
Lang["Q1_5514"] = "Molde rima con... ¿oro?"
Lang["Q2_5514"] = "Lleva los Fragmentos esqueléticos imbuidos y 15 piezas de oro a Krinkle Buenacero en Gadgetzan."
Lang["Q1_5802"] = "La forja del Penacho en Llamas"
Lang["Q2_5802"] = "Lleva el molde para llave esqueleto y 2 barras de torio a la cima de la Cresta del Penacho en Llamas en el Cráter de Un'Goro. Utiliza el molde para llave esqueleto en el lago de lava para forjar la llave esqueleto incompleta."
Lang["Q1_5804"] = "El escarabajo de Araj"
Lang["Q2_5804"] = "Destruye a Araj el Invocador y lleva el Escarabeo de Araj al boticario Dithers en El Baluarte, en las Tierras de la Peste del Oeste."
Lang["Q1_5511"] = "La llave de Scholomance"
Lang["Q2_5511"] = "Bien, aquí estás, Y has completado la llave esqueleto. No tengo dudas de que esta llave te permitirá acceder a los confines de Scholomance."
Lang["Q1_5092"] = "Despejando el camino"
Lang["Q2_5092"] = "Mata 10 despellejadores esqueléticos y 10 necrófagos esclavizantes en la Colina de las Penas."
Lang["Q1_5097"] = "Todas las torres"
Lang["Q2_5097"] = "Con la Antorcha de aviso, marca las torres de Andorhal. Tendrás que estar en la entrada de la torre para poder marcarla."
Lang["Q1_5533"] = "Scholomance"
Lang["Q2_5533"] = "Habla con el alquimista Arbington en el Alto del Orvallo, en las Tierras de la Peste del Oeste."
Lang["Q1_5537"] = "Fragmentos esqueléticos"
Lang["Q2_5537"] = "Lleva 15 fragmentos esqueléticos al alquimista Arbington, en el Alto del Orvallo, en las Tierras de la Peste del Oeste."
Lang["Q1_5538"] = "Molde rima con... ¿oro?"
Lang["Q2_5538"] = "Lleva los Fragmentos esqueléticos imbuidos y 15 piezas de oro a Krinkle Buenacero en Gadgetzan."
Lang["Q1_5801"] = "La forja del Penacho en Llamas"
Lang["Q2_5801"] = "Lleva el molde para llave esqueleto y 2 barras de torio a la cima de la Cresta del Penacho en Llamas en el Cráter de Un'Goro. Utiliza el molde para llave esqueleto en el lago de lava para forjar la llave esqueleto incompleta."
Lang["Q1_5803"] = "El escarabajo de Araj"
Lang["Q2_5803"] = "Destruye a Araj el Invocador y lleva el Escarabeo de Araj al alquimista Arbington en el Alto del Orvallo, en las Tierras de la Peste del Oeste."
Lang["Q1_5505"] = "La llave de Scholomance"
Lang["Q2_5505"] = "Bien, aquí estás, Y has completado la llave esqueleto. No tengo dudas de que esta llave te permitirá acceder a los confines de Scholomance."
--v250
Lang["Q1_6804"] = "Agua envenenada"
Lang["Q2_6804"] = "Aplica el aspecto de Neptulon a los elementales infectados de las Tierras de la Peste del Este. Lleva 12 de sus brazales de vínculo y el aspecto de Neptulon al duque Hydraxis a Azshara."
Lang["Q1_6805"] = "Sirocosos y reptarenas"
Lang["Q2_6805"] = "Mata a 15 sirocosos y 15 reptarenas y ve a hablar con el duque Hydraxis en Azshara."
Lang["Q1_6821"] = "Ojo de brasadivino"
Lang["Q2_6821"] = "Lleva el ojo del Piroguardián brasadivino al duque Hydraxis a Azshara."
Lang["Q1_6822"] = "El Núcleo de Magma"
Lang["Q2_6822"] = "Mata a 1 Señor del Fuego, 1 gigante fundido, 1 canino del Núcleo y 1 marea de lava y ve a ver al duque Hydraxis a Azshara."
Lang["Q1_6823"] = "Agente de Hydraxis"
Lang["Q2_6823"] = "Consigue una mención de honor de los Señores del Agua y habla con el duque Hydraxis en Azshara."
Lang["Q1_6824"] = "Las manos de los enemigos"
Lang["Q2_6824"] = "Lleva las manos de Lucifron, Sulfuron, Gehennas y Shazzrah al duque Hydraxis a Azshara."
Lang["Q1_7486"] = "Una recompensa de héroe"
Lang["Q2_7486"] = "Recoge tu recompensa en el arca de Hydraxis."
--v254
Lang["Q1_11481"] = "Crisis en La Fuente del Sol"
Lang["Q2_11481"] = "Adyen el Celador de la Luz del Alto Aldor, en la Ciudad de Shattrath, te ha pedido que viajes hasta la Meseta de La Fuente del Sol para hablar con Larethor."
Lang["Q1_11488"] = "El Bancal del Magister"
Lang["Q2_11488"] = "El exarca Larethor de la Zona de escala de Sol Devastado quiere que registres el Bancal del Magister y encuentres a Tyrith, un espía elfo de sangre."
Lang["Q1_11490"] = "El cristal del Arúspice"
Lang["Q2_11490"] = "Tyrith quiere que uses el orbe en el balcón del Bancal del Magister."
Lang["Q1_11492"] = "Duro de matar"
Lang["Q2_11492"] = "Kalecgos te ha pedido que derrotes a Kael'thas en el Bancal del Magister. Coge la cabeza de Kael y preséntate ante Larethor en la Zona de escala de Sol Devastado."


-- NPC
Lang["N1_9196"] = "Alto Señor Omokk"	-- https://es.tbc.wowhead.com/npc=9196
Lang["N2_9196"] = "Alto Señor Omokk es el primer jefe en Cumbre Roca Negra inferior."
Lang["N1_9237"] = "Maestro de guerra Voone"	-- https://es.tbc.wowhead.com/npc=9237
Lang["N2_9237"] = "Maestro de guerra Voone es un mini-jefe en Cumbre Roca Negra inferior."
Lang["N1_9568"] = "Señor Supremo Vermiothalak"	-- https://es.tbc.wowhead.com/npc=9568
Lang["N2_9568"] = "Señor Supremo Vermiothalak es el último jefe en Cumbre Roca Negra inferior."
Lang["N1_10429"] = "Jefe de Guerra Rend Puño Negro"	-- https://es.tbc.wowhead.com/npc=10429
Lang["N2_10429"] = "Jefe de Guerra Rend Puño Negro es el sexto jefe en Cumbre Roca Negra superior. Dal'rend, comúnmente conocido como Rend, era el gobernante de la Horda Oscura y la mayor amenaza para Thrall."
Lang["N1_10182"] = "Rexxar"	-- https://es.tbc.wowhead.com/npc=10182
Lang["N2_10182"] = "<Campeón de la Horda>\n\nCamina desde el sur de Sierra Espolón, camino abajo hasta el norte de Feralas."
Lang["N1_8197"] = "Chronalis"	-- https://es.tbc.wowhead.com/npc=8197
Lang["N2_8197"] = "Chronalis del Vuelo de Bronze.\n\nSe encuentra en la entrada de las Cavernas del Tiempo."
Lang["N1_10664"] = "Arúspice"	-- https://es.tbc.wowhead.com/npc=10664
Lang["N2_10664"] = "Arúspice del Vuelo Azul.\n\nSe encuentra en la parte baja de la cueva de Mazthoril."
Lang["N1_12900"] = "Somnus"	-- https://es.tbc.wowhead.com/npc=12900
Lang["N2_12900"] = "Somnus  del Vuelo Verde.\n\nSe encuentra la parte este del Tempo Submergido."
Lang["N1_12899"] = "Axtroz"	-- https://es.tbc.wowhead.com/npc=12899
Lang["N2_12899"] = "Axtroz del Vuelo Rojo.\n\nSe encuentra en Grim Batol, Los Humedales."
Lang["N1_10363"] = "General Drakkisath"	-- https://es.tbc.wowhead.com/npc=10363
Lang["N2_10363"] = "General Drakkisath es el último jefe de Cumbre Roca Negra superior."
Lang["N1_8983"] = "Señor Gólem Argelmach"	-- https://es.tbc.wowhead.com/npc=8983
Lang["N2_8983"] = "Señor Gólem Argelmach es el noveno jefe en Profundidades Roca Negra."
Lang["N1_9033"] = "General Forjainquina"	-- https://es.tbc.wowhead.com/npc=9033
Lang["N2_9033"] = "General Forjainquina es el septimo jefe en Profundidades Roca Negra."
Lang["N1_17804"] = "Escudero Rowe"	-- https://es.tbc.wowhead.com/npc=17804
Lang["N2_17804"] = "Se encuentra en la puerta de Ventormenta."
Lang["N1_10929"] = "Haleh"	-- https://es.tbc.wowhead.com/npc=10929
Lang["N2_10929"] = "Se encuentra en lo alto de la cueva Mazthoril, fuera.\nSe llega a traves de una runa azul en el suelo del interior de la cueva."
Lang["N1_9046"] = "Intendente del Escudo del Estigma"	-- https://es.tbc.wowhead.com/npc=9046
Lang["N2_9046"] = "Se encuentra fuera la instancia, en un pequeño recordo cerca del balcón en la entra Cumbre Roca Negra superior."
Lang["N1_15180"] = "Baristolth del Mar de Dunas"	-- https://es.tbc.wowhead.com/npc=15180
Lang["N2_15180"] = "Baristolth del Mar de Dunas se encuentra en el Fuerte Cenarion de Silithus (49.6,36.6)."
Lang["N1_12017"] = "Señor de linaje Capazote"	-- https://es.tbc.wowhead.com/npc=12017
Lang["N2_12017"] = "Señor de linaje Capazote es el tercer jefe de Guarida de Alanegra."
Lang["N1_13020"] = "Vaelastrasz el Corrupto"	-- https://es.tbc.wowhead.com/npc=13020
Lang["N2_13020"] = "Vaelastrasz el Corrupto es el segundo jefe de Guarida de Alanegra."
Lang["N1_11583"] = "Nefarian"	-- https://es.tbc.wowhead.com/npc=11583
Lang["N2_11583"] = "Nefarian es el octavo y jefe final de Guarida de Alanegra."
Lang["N1_15362"] = "Malfurion Tempestira"	-- https://es.tbc.wowhead.com/npc=15362
Lang["N2_15362"] = "Se encuentra en el Templo de Atal'Hakkar, aparece una vez te acercas a la Sombra de Eranikus."
Lang["N1_15624"] = "Fuego fatuo del bosque"	-- https://es.tbc.wowhead.com/npc=15624
Lang["N2_15624"] = "El Fuego fatuo se encuentra en Teldrassil, no muy lejos de las puertas de Darnassus, at (37.6,48.0)."
Lang["N1_15481"] = "Espíritu de Azuregos"	-- https://es.tbc.wowhead.com/npc=15481
Lang["N2_15481"] = "El espíritu de Azuregos deambula por la part sud de Azshara, alrededor (58.8,82.2). Le gusta hablar ^^."
Lang["N1_11811"] = "Narain Sabelotodo"	-- https://es.tbc.wowhead.com/npc=11811
Lang["N2_11811"] = "Localizado en una pequeña tienda al norte del Puerto Bonvapor. (65.2,18.4)."
Lang["N1_15526"] = "Meridith la Sirenita"	-- https://es.tbc.wowhead.com/npc=15526
Lang["N2_15526"] = "Patrulla por la parte submarina antes de la gran barrera, por (59.6,95.6). Una vez completada la misión vuelve a ella, te dará un bonus de movimineto para nadar."
Lang["N1_15554"] = "Número dos"	-- https://es.tbc.wowhead.com/npc=15554
Lang["N2_15554"] = "Número dos es invocado en Cuna de Inverno, lugar concreto (67.2,72.6). Puede tardar bastante tiempo en reaparecer."
Lang["N1_15552"] = "Doctor Weavil"	-- https://es.tbc.wowhead.com/npc=15552
Lang["N2_15552"] = "Este gnomo endemoniado se encuentra en la Isla de Alcaz en Marjal Revolcafango (77.8,17.6). Es espectacular!"
Lang["N1_10184"] = "Onyxia"	-- https://es.tbc.wowhead.com/npc=10184
Lang["N2_10184"] = "Cuando no es una dama en Ventormenta, Onyxia reside en su guarida al sur del Marjal Revolcafanjo."
Lang["N1_11502"] = "Ragnaros"	-- https://es.tbc.wowhead.com/npc=11502
Lang["N2_11502"] = "Ragnaros, el Señor del fuego, el décimo y último jefe de Núcleo de Magma. ¡Que el fuego te purifique!"
Lang["N1_12803"] = "Lord Lakmaeran"	-- https://es.tbc.wowhead.com/npc=12803
Lang["N2_12803"] = "Se encuentra en la Isla del Terror de Feralas, Un poco al norte de la entrada de la Quimera (29.8,72.6)."
Lang["N1_15571"] = "Fauces"	-- https://es.tbc.wowhead.com/npc=15571
Lang["N2_15571"] = "duunnn dunnn... duuuunnnn duun... duuunnnnnnnn dun dun dun dun dun dun dun dun dun dun dunnnnnnnnnnn dunnnn en Azshara (65.6,54.6)"
Lang["N1_22037"] = "Herrero Gorlunk"	-- https://es.tbc.wowhead.com/npc=22037
Lang["N2_22037"] = "Localizado en una forja, obivamente (67,36), en la parte norte del complejo del Templo Oscuro."
Lang["N1_18733"] = "Atracador vil"	-- https://es.tbc.wowhead.com/npc=18733
Lang["N2_18733"] = "Suele merodear por la parte oeste de la Península del Fuego Infernal."
Lang["N1_18473"] = "Rey Garra Ikiss"	-- https://es.tbc.wowhead.com/npc=18473
Lang["N2_18473"] = "Rey Garra Ikiss es el último jefe de las Salas Sethekk en Auchindoun"
Lang["N1_20142"] = "Administrador del Tiempo"	-- https://es.tbc.wowhead.com/npc=20142
Lang["N2_20142"] = "Dragón del vuelo de bronze, cerca del reloj de arena en las Carvernas del Tiempo."
Lang["N1_20130"] = "Andormu"	-- https://es.tbc.wowhead.com/npc=20130
Lang["N2_20130"] = "Parece un niño pequeño, cerca del reloj de arena en las Carvernas del Tiempo."
Lang["N1_18096"] = "Cazador de eras"	-- https://es.tbc.wowhead.com/npc=18096
Lang["N2_18096"] = "El úlitmo jefe de las Cavernas del Tiempo: Viejas Laderas de Trabalomas, aparece en el Molino Tarren cuando Thrall llega allí."
Lang["N1_19880"] = "Acechador abisal Khay'ji"	-- https://es.tbc.wowhead.com/npc=19880
Lang["N2_19880"] = "Se encuentra cerca de la forja de Area 52 (32,64)"
Lang["N1_19641"] = "Asaltante de distorsión Nesaad"	-- https://es.tbc.wowhead.com/npc=19641
Lang["N2_19641"] = "Localizado en (28,79). Lleva dos 2 adds con él."
Lang["N1_18481"] = "A'dal"	-- https://es.tbc.wowhead.com/npc=18481
Lang["N2_18481"] = "A'dal se encuentra en el centro de la ciudad de Shattrath. La cosa esa grande brillante amarilla. No puedes no verlo, en serio."
Lang["N1_19220"] = "Pathaleon el Calculador"	-- https://es.tbc.wowhead.com/npc=19220
Lang["N2_19220"] = "Pathaleon el Calculador es el jefe final de El Mechanar."
Lang["N1_17977"] = "Disidente de distorsión"	-- https://es.tbc.wowhead.com/npc=17977
Lang["N2_17977"] = "Disidente de distorsión es el quinto jefe de El Ivernáculo. Es un gran arbol elemental."
Lang["N1_17613"] = "Archimago Alturus"	-- https://es.tbc.wowhead.com/npc=17613
Lang["N2_17613"] = "Se encuentra en frente la entrada de Karazhan."
Lang["N1_18708"] = "Murmur"	-- https://es.tbc.wowhead.com/npc=18708
Lang["N2_18708"] = "Murmur es el jefe final de Laberinto de Sombras. Es un gran elemental de aire."
Lang["N1_17797"] = "Hidromántica Thespia"	-- https://es.tbc.wowhead.com/npc=17797
Lang["N2_17797"] = "Hidromántica Thespia es el primer jefe en Las Camaras de Vapor en la Reserva Colmillo Torcido."
Lang["N1_20870"] = "Zereketh el Desatado"	-- https://es.tbc.wowhead.com/npc=20870
Lang["N2_20870"] = "Zereketh el Desatado es el primer jefe de El Arcatraz."
Lang["N1_15608"] = "Medhivh"	-- https://es.tbc.wowhead.com/npc=15608
Lang["N2_15608"] = "Medivh está cerca del portal, en la parte sud de La Ciénaga Negra."
Lang["N1_16524"] = "Sombra de Aran"	-- https://es.tbc.wowhead.com/npc=16524
Lang["N2_16524"] = "El padre loco de Medhivh, en Karazhan"
Lang["N1_16807"] = "Brujo supremo Malbisal"	-- https://es.tbc.wowhead.com/npc=16807
Lang["N2_16807"] = "Brujo supremo Malbisal es un orco vil brujo y el primer jefe Las Salas Arrasadas."
Lang["N1_18472"] = "Tejeoscuro Syth"	-- https://es.tbc.wowhead.com/npc=18472
Lang["N2_18472"] = "Tejeoscuro Syth es el primer jefe en las Salas Sethekk."
Lang["N1_22421"] = "Skar'this el Herético"	-- https://es.tbc.wowhead.com/npc=22421
Lang["N2_22421"] = "Skar'this solo está disponible en modo HEROICO de Recinto de Esclavos. Se encuentra muy cerca después del primer jefe. Cuando saltes abajo, a la piscina, sal y está a mano izquierda en una jaula."
Lang["N1_19044"] = "Gruul el Asesino de Dragones"	-- https://es.tbc.wowhead.com/npc=19044
Lang["N2_19044"] = "Gruul el Asesino de Dragones es el jefe final de la instancia de banda la Guarida de Gruul en las Montañas Filoespada."
Lang["N1_17225"] = "Nocturno"	-- https://es.tbc.wowhead.com/npc=17225
Lang["N2_17225"] = "Nocturno es un jefe opcional tipo dragón invocable en Karazhan. Echa un vistazo a tu armoninzación para más info."
Lang["N1_21938"] = "Ensalmador de la tierra Pezuña de Astilla"	-- https://es.tbc.wowhead.com/npc=21938
Lang["N2_21938"] = "Ensalmador de la tierra Pezuña de Astilla se encuentra en un pequeño edificio en lo alto de la Aldea Sombraluna (28.6,26.6)."
Lang["N1_21183"] = "Oronok Corazón Roto"	-- https://es.tbc.wowhead.com/npc=21183
Lang["N2_21183"] = "Oronok Corazón Roto se encuentra en lo alto de la colina llamada Granja de Oronok (53.8,23.4), entre el Alto Cicatriz Espiral y el Altar de Sha'tar."
Lang["N1_21291"] = "Grom'tor, hijo de Oronok"	-- https://es.tbc.wowhead.com/npc=21291
Lang["N2_21291"] = "Se encuentra en el Alto Cicatriz Esprial (44.6,23.6)."
Lang["N1_21292"] = "Ar'tor, hijo de Oronok"	-- https://es.tbc.wowhead.com/npc=21292
Lang["N2_21292"] = "Se encuentra en el Alto Illidari (29.6,50.4), suspendido en el aire por rayos de luz rojos."
Lang["N1_21293"] = "Borak, hijo de Oronok"	-- https://es.tbc.wowhead.com/npc=21293
Lang["N2_21293"] = "Se encuentra al norte de la Punta Eclipse (47.6,57.2)."
Lang["N1_18166"] = "Khadgar"	-- https://es.tbc.wowhead.com/npc=18166
Lang["N2_18166"] = "Se encuentra en el centro de la ciudad de Shattrath, justo al lado de A'dal, la cosa esa grande brillante amarilla."
Lang["N1_16808"] = "Jefe de Guerra Kargath Garrafilada"	-- https://es.tbc.wowhead.com/npc=16808
Lang["N2_16808"] = "Jefe de Guerra Kargath Garrafilada es el jefe final de Las Salas Arrasadas. Spoiler, tiene espadas por puños."
Lang["N1_17798"] = "Señor de la Guerra Kalithresh"	-- https://es.tbc.wowhead.com/npc=17798
Lang["N2_17798"] = "Señor de la Guerra Kalithresh es el tercer y último jefe de Las Camaras de Vapor en la Reserva Colmillo Torcido."
Lang["N1_20912"] = "Presagista Cieloriss"	-- https://es.tbc.wowhead.com/npc=20912
Lang["N2_20912"] = "Presagista Cieloriss es el quinto y jefe final, después de varias oleadas, en El Arcatraz."
Lang["N1_20977"] = "Molino Tormenta de maná"	-- https://es.tbc.wowhead.com/npc=20977
Lang["N2_20977"] = "Molino Tormenta de maná es un gnomo que se encuentra en la batalla contra el Presagista Cieloriss en Arcatraz. Te ayudara atacando a las demás criaturas que aparezcan de celdas."
Lang["N1_17257"] = "Magtheridon"	-- https://es.tbc.wowhead.com/npc=17257
Lang["N2_17257"] = "Magtheridon se encuentra prisionero debajo de la Ciudadela del Fuego Infernal, en la instancia de banda La Guarida de Magtheridon."
Lang["N1_21937"] = "Ensalmador de la tierra Sophurus"	-- https://es.tbc.wowhead.com/npc=21937
Lang["N2_21937"] = "Ensalmador de la tierra Sophurus se encuentra fuera de la posada en Fortaleza Martillo Salvaje (36.4,56.8)."
Lang["N1_19935"] = "Soridormi"	-- https://es.tbc.wowhead.com/npc=19935
Lang["N2_19935"] = "Soridormi deambula por la sala del gran reloj de arena dentro de las Cavernas del Tiempo."
Lang["N1_19622"] = "Kael'thas Caminante del Sol "	-- https://es.tbc.wowhead.com/npc=19622
Lang["N2_19622"] = "Kael'thas Caminante del Sol es el cuarto y jefe final de la instancia de banda El Ojo."
Lang["N1_21212"] = "Lady Vashj"	-- https://es.tbc.wowhead.com/npc=21212
Lang["N2_21212"] = "Lady Vashj es el encuentro final de la instancia de banda de Caverna Santuario Serpiente en la Reserva Colmillo Torcido."
Lang["N1_21402"] = "Anacoreta Ceyla"	-- https://es.tbc.wowhead.com/npc=21402
Lang["N2_21402"] = "Anacoreta Ceyla se encuentra en el Altar de Shatar (62.6,28.4)."
Lang["N1_21955"] = "Arcanista Thelis"	-- https://es.tbc.wowhead.com/npc=21955
Lang["N2_21955"] = "Arcanista Thelis se encuentra dentro del Sagrario de las Estrellas (56.2,59.6)"
Lang["N1_21962"] = "Udalo"	-- https://es.tbc.wowhead.com/npc=21962
Lang["N2_21962"] = "Yace muerto en la pequeña rampa antes del último jefe de El Arcatraz."
Lang["N1_22006"] = "Señor de las Sombras Alaullido"	-- https://es.tbc.wowhead.com/npc=22006
Lang["N2_22006"] = "Está montando un dragón en la torre norte del Templo Oscuro. (71.6,35.6) "
Lang["N1_22820"] = "Vidente Olum"	-- https://es.tbc.wowhead.com/npc=22820
Lang["N2_22820"] = "Vidente Olum se encuentra localizado en Caverna Santuario Serpiente, detras del Señor de las profundidades Karathress."
Lang["N1_21700"] = "Akama"	-- https://es.tbc.wowhead.com/npc=21700
Lang["N2_21700"] = "Akama se encuentra localizado en la Jaula de la Guardiana (58.0,48.2)."
Lang["N1_19514"] = "Al'ar"	-- https://es.tbc.wowhead.com/npc=19514
Lang["N2_19514"] = "Al'ar es el primer jefe de la instancia de El Ojo. Es un tipo de gran pajaro llameante."
Lang["N1_17767"] = "Ira Fríoinvierno"	-- https://es.tbc.wowhead.com/npc=17767
Lang["N2_17767"] = "Ira Fríoinvierno es el primer jefe de la instancia de Banda Monte Hyjal."
Lang["N1_18528"] = "Xi'ri"	-- https://es.tbc.wowhead.com/npc=18528
Lang["N2_18528"] = "Xi'ri se encuentra localizado en la entrada del Templo Oscuro. La cosa esa grande brillante azul. No puedes no verlo, en serio."
--v243
Lang["N1_22497"] = "V'eru"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22497
Lang["N2_22497"] = "V'eru está en la misma habitación que A'dal, pero es azul. Está en el rellano superior."
--v244
Lang["N1_22113"] = "Mordenai"
Lang["N2_22113"] = "Un elfo de sangre (alerta de spoiler, en realidad un dragón) que camina por los campos del Ala Abisal, al este del Sagrario de las Estrellas"
--v247
Lang["N1_8888"]  = "Franclorn Forjador"
Lang["N2_8888"]  = "Un enano fantasma, de pie sobre su propia tumba FUERA de la mazmorra, en la estructura suspendida sobre la lava. Solo puedes interactuar con él si estás MUERTO."
Lang["N1_9056"]  = "Finoso Virunegro"
Lang["N2_9056"]  = "Está DENTRO de la mazmorra y patrulla el área de la cantera fuera de la cámara de Lord Incendius."
Lang["N1_10837"] = "Sumo Ejecutor Derrington"
Lang["N2_10837"] = "Se le puede encontrar en el Baluarte, cerca de la frontera de Tirisfal y las Tierras de la Peste del Oeste."
Lang["N1_10838"] = "Comandante Ashlam Puñovalor"
Lang["N2_10838"] = "Se le puede encontrar en el Campamento Viento Gélido, al sur de Andorhal en las Tierras de la Peste del Oeste."
Lang["N1_1852"]  = "Araj el Invocador"
Lang["N2_1852"]  = "El Lich, en medio de Andorhal"
--v250
Lang["N1_13278"]  = "Duque Hydraxis"
Lang["N2_13278"]  = "Un elemental de agua grande en una pequeña isla lejana en Azshara (79.2,73.6)"
Lang["N1_12264"]  = "Shazzrah"
Lang["N2_12264"]  = "Shazzrah es el quinto jefe de Núcleo de Magma."
Lang["N1_12118"]  = "Lucifron"
Lang["N2_12118"]  = "Lucifron es el primer jefe de Núcleo de Magma."
Lang["N1_12259"]  = "Gehennas"
Lang["N2_12259"]  = "Gehennas es el tercer jefe de Núcleo de Magma."
Lang["N1_12098"]  = "Sulfuron Presagista"
Lang["N2_12098"]  = "Sulfuron Presagista, heraldo de Ragnaros, es el octavo jefe de Núcleo de Magma."


Lang["O_1"] = "Clicka en La marca de Drakkisath para completar la misión.\nLa orbe brillante detras del General Drakkisath."
Lang["O_2"] = "Es un pequeño punto rojo en el suelo\nen frente las puertas de Ahn'Qiraj (28.7,89.2)."
--v247
Lang["O_3"] = "El santuario está ubicado al final de un corredor\nque comienza en el nivel superior del Anillo de la Ley."

