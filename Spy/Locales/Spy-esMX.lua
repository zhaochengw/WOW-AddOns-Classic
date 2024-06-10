local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "esMX")
if not L then return end
-- TOC Note: Detecta y te alerta sobre la presencia de jugadores enemigos cercanos.

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Versión"
L["Spy Option"] = "Spy"
L["Profiles"] = "Perfiles"

-- About
L["About"] = "Sobre"
L["SpyDescription1"] = [[
Spy es un addon que te alertará sobre la presencia de jugadores enemigos cercanos. Estas son algunas de las características principales.

]]

L["SpyDescription2"] = [[
|cffffd000Lista de cercanos|cffffffff
Muestra jugadores enemigos que han sido detectados cerca. Los jugadores son eliminados de la lista si no han sido detectados después de un período de tiempo.

|cffffd000Lista de la última hora|cffffffff
Muestra todos los enemigos que han sido detectados en la última hora.

|cffffd000Lista de ignorados|cffffffff
Los jugadores que se añaden a la lista de ignorados no serán reportados por Spy. Puedes añadir y eliminar jugadores a esta lista utilizando el menú desplegable del botón o manteniendo presionada la tecla Control mientras haces clic en el botón.

|cffffd000Lista de matar a la vista|cffffffff
Los jugadores en tu lista de matar a la vista provocan una alarma cuando son detectados. Puedes añadir y eliminar jugadores a esta lista utilizando el menú desplegable del botón o manteniendo presionada la tecla Mayús mientras haces clic en el botón. El menú desplegable también se puede utilizar para establecer las razones por las que has añadido a alguien a la lista de matar a la vista. Si quieres introducir una razón específica que no esté en la lista, entonces utiliza "Introduce tu propia razón..." en la lista Otros.

]]

L["SpyDescription3"] = [[
|cffffd000Ventana de estadísticas|cffffffff
La ventana de estadísticas contiene una lista de todos los encuentros con enemigos que pueden ordenarse por nombre, nivel, hermandad, victorias, derrotas y la última vez que se detectó a un enemigo. También proporciona la capacidad de buscar un enemigo específico por nombre o hermandad y tiene filtros para mostrar solo enemigos marcados como matar a la vista, con una relación victorias/derrotas o razones introducidas.

|cffffd000Botón de matar a la vista|cffffffff
Si está activado, este botón estará ubicado en el marco del objetivo de los jugadores enemigos. Al hacer clic en este botón, se añadirá/eliminará el objetivo enemigo de la lista de matar a la vista. Al hacer clic derecho en el botón, podrás introducir razones para matar a la vista.

|cffffd000Autor:|cffffffff Slipjack
]]

-- General Settings
L["GeneralSettings"] = "Configuración general"
L["GeneralSettingsDescription"] = [[
Opciones cuando Spy está activado o desactivado.
]]
L["EnableSpy"] = "Activar Spy"
L["EnableSpyDescription"] = "Activa o desactiva Spy."
L["EnabledInBattlegrounds"] = "Activar Spy en campos de batalla"
L["EnabledInBattlegroundsDescription"] = "Activa o desactiva Spy cuando estás en un campo de batalla."
L["EnabledInArenas"] = "Activar Spy en arenas"
L["EnabledInArenasDescription"] = "Activa o desactiva Spy cuando estás en una arena."
L["EnabledInWintergrasp"] = "Activar Spy en zonas de combate mundial"
L["EnabledInWintergraspDescription"] = "Activa o desactiva Spy cuando estás en zonas de combate mundial como Lago Conquista de Invierno en Rasganorte."
L["DisableWhenPVPUnflagged"] = "Desactivar Spy cuando no estás marcado para JcJ"
L["DisableWhenPVPUnflaggedDescription"] = "Activa o desactiva Spy dependiendo de tu estado de JcJ."
L["DisabledInZones"] = "Desactivar Spy mientras estás en estas ubicaciones"
L["DisabledInZonesDescription"] = "Selecciona ubicaciones donde Spy estará desactivado."
L["Booty Bay"] = "Bahía del Botín"
L["Everlook"] = "Vista Eterna"						
L["Gadgetzan"] = "Gadgetzan"
L["Ratchet"] = "Trinquete"
L["The Salty Sailor Tavern"] = "Taberna del Grumete Frito"
L["Shattrath City"] = "Ciudad de Shattrath"
L["Area 52"] = "Area 52"
L["Dalaran"] = "Dalaran"
L["Dalaran (Northrend)"] = "Dalaran (Rasganorte)"
L["Bogpaddle"] = "Chapaleos"
L["The Vindicaar"] = "El Vindicaar"
L["Krasus' Landing"] = "Alto de Krasus"
L["The Violet Gate"] = "La Puerta Violeta"
L["Magni's Encampment"] = "Campamento de Magni"
L["Silithus"] = "Silithus"
L["Chamber of Heart"] = "Cámara del Corazón"
L["Hall of Ancient Paths"] = "Cámara de Sendas Ancestrales"
L["Sanctum of the Sages"] = "Santuario de los Sabios"
L["Rustbolt"] = "Pernoóxido"
L["Oribos"] = "Oribos"
L["Valdrakken"] = "Valdrakken"

-- Display
L["DisplayOptions"] = "Visualización"
L["DisplayOptionsDescription"] = [[
Opciones para la ventana de Spy y tooltips.
]]
L["ShowOnDetection"] = "Mostrar Spy cuando se detectan jugadores enemigos"
L["ShowOnDetectionDescription"] = "Establece esto para mostrar la ventana de Spy y la lista de cercanos si Spy está oculto cuando se detectan jugadores enemigos."
L["HideSpy"] = "Ocultar Spy cuando no se detectan jugadores enemigos"
L["HideSpyDescription"] = "Establece esto para ocultar Spy cuando se muestra la lista de cercanos y esta queda vacía. Spy no se ocultará si limpias la lista manualmente."
L["ShowOnlyPvPFlagged"] = "Mostrar solo jugadores enemigos marcados para JcJ"
L["ShowOnlyPvPFlaggedDescription"] = "Establece esto para mostrar solo jugadores enemigos marcados para JcJ en la lista de Cerca."
L["ShowKoSButton"] = "Mostrar botón MaV en el marco de objetivo del enemigo"
L["ShowKoSButtonDescription"] = "Establece esto para mostrar el botón MaV (matar a la vista) en el marco de objetivo del jugador enemigo."
L["Alpha"] = "Transparencia"
L["AlphaDescription"] = "Establece la transparencia de la ventana de Spy."
L["AlphaBG"] = "Transparencia en campos de batalla"
L["AlphaBGDescription"] = "Establece la transparencia de la ventana de Spy en campos de batalla."
L["LockSpy"] = "Bloquear la ventana"
L["LockSpyDescription"] = "Bloquea la ventana de Spy para que no se mueva."
L["ClampToScreen"] = "Limitar la pantalla"
L["ClampToScreenDescription"] = "Controla si la ventana de Spy se puede arrastrar fuera de la pantalla."
L["InvertSpy"] = "Invertir la ventana"
L["InvertSpyDescription"] = "Voltea la ventana de Spy boca abajo."
L["Reload"] = "Recargar IU"
L["ReloadDescription"] = "Necesario al cambiar la ventana de Spy."
L["ResizeSpy"] = "Redimensionar la ventana de Spy automáticamente"
L["ResizeSpyDescription"] = "Establece esto para redimensionar automáticamente la ventana de Spy a medida que se agregan y eliminan jugadores enemigos."
L["ResizeSpyLimit"] = "Límite de lista"
L["ResizeSpyLimitDescription"] = "Limita el número de jugadores enemigos mostrados en la ventana de Spy."
L["DisplayTooltipNearSpyWindow"] = "Mostrar tooltips cerca de la ventana de Spy"
L["DisplayTooltipNearSpyWindowDescription"] = "Establece esto para mostrar tooltips cerca de la ventana de Spy."
L["SelectTooltipAnchor"] = "Punto de anclaje del tooltip"
L["SelectTooltipAnchorDescription"] = "Selecciona el punto de anclaje para el tooltip si la opción anterior ha sido marcada"
L["ANCHOR_CURSOR"] = "Cursor"
L["ANCHOR_TOP"] = "Arriba"
L["ANCHOR_BOTTOM"] = "Abajo"
L["ANCHOR_LEFT"] = "Izquierda"			
L["ANCHOR_RIGHT"] = "Derecha"
L["TooltipDisplayWinLoss"] = "Mostrar estadísticas de victorias/derrotas en el tooltip"
L["TooltipDisplayWinLossDescription"] = "Establece esto para mostrar las estadísticas de victorias/derrotas de un jugador en el tooltip del jugador."
L["TooltipDisplayKOSReason"] = "Mostrar razones de matar a la vista en el tooltip"
L["TooltipDisplayKOSReasonDescription"] = "Establece esto para mostrar las razones de matar a la vista de un jugador en el tooltip del jugador."
L["TooltipDisplayLastSeen"] = "Mostrar detalles del último avistamiento en el tooltip"
L["TooltipDisplayLastSeenDescription"] = "Establece esto para mostrar la última hora y ubicación conocidas de un jugador en el tooltip del jugador."
L["DisplayListData"] = "Seleccionar datos para mostrar"
L["Name"] = "Nombre"
L["Class"] = "Clase"
L["Rank"] = "Rango"
L["SelectFont"] = "Seleccionar fuente"
L["SelectFontDescription"] = "Selecciona una fuente para la ventana de Spy."
L["RowHeight"] = "Seleccionar la altura de fila"
L["RowHeightDescription"] = "Selecciona la altura de fila para la ventana de Spy."
L["Texture"] = "Textura"
L["TextureDescription"] = "Selecciona una textura para la ventana de Spy"

-- Alerts
L["AlertOptions"] = "Alertas"
L["AlertOptionsDescription"] = [[
Opciones para alertas, anuncios y advertencias cuando se detectan jugadores enemigos.
]]
L["SoundChannel"] = "Seleccionar canal de sonido"
L["Master"] = "Principal"
L["SFX"] = "Efectos de sonido"
L["Music"] = "Música"
L["Ambience"] = "Ambiente"
L["Announce"] = "Enviar anuncios a:"
L["None"] = "Ninguno"
L["NoneDescription"] = "No anuncia cuando se detectan jugadores enemigos."
L["Self"] = "Personal"
L["SelfDescription"] = "Anuncia para ti mismo cuando se detectan jugadores enemigos."
L["Party"] = "Grupo"
L["PartyDescription"] = "Anuncia a tu grupo cuando se detectan jugadores enemigos."
L["Guild"] = "Hermandad"
L["GuildDescription"] = "Anuncia a tu hermandad cuando se detectan jugadores enemigos."
L["Raid"] = "Banda"
L["RaidDescription"] = "Anuncia a tu banda cuando se detectan jugadores enemigos."
L["LocalDefense"] = "Defensa Local"
L["LocalDefenseDescription"] = "Anuncia al canal de Defensa Local cuando se detectan jugadores enemigos."
L["OnlyAnnounceKoS"] = "Solo anunciar jugadores enemigos marcados para matar a la vista"
L["OnlyAnnounceKoSDescription"] = "Establece esto para solo anunciar jugadores enemigos que estén en tu lista de matar a la vista."
L["WarnOnStealth"] = "Advertir al detectar sigilo"
L["WarnOnStealthDescription"] = "Establece esto para mostrar una advertencia y sonar una alerta cuando un jugador enemigo entra en sigilo."
L["WarnOnKOS"] = "Advertir al detectar matar a la vista"
L["WarnOnKOSDescription"] = "Establece esto para mostrar una advertencia y sonar una alerta cuando se detecta un jugador enemigo en tu lista de matar a la vista."
L["WarnOnKOSGuild"] = "Advertir al detectar hermandad matar a la vista"
L["WarnOnKOSGuildDescription"] = "Establece esto para mostrar una advertencia y sonar una alerta cuando se detecta un jugador enemigo en la misma hermandad que alguien en tu lista de matar a la vista."
L["WarnOnRace"] = "Advertir al detectar raza"
L["WarnOnRaceDescription"] = "Establece esto para sonar una alerta cuando se detecta la raza seleccionada."
L["SelectWarnRace"] = "Seleccionar raza para detectar"
L["SelectWarnRaceDescription"] = "Selecciona una raza para la alerta de audio."
L["WarnRaceNote"] = "Nota: Debes apuntar al menos una vez a un enemigo para que su raza se añada a la base de datos. En la próxima detección sonará una alerta. Esto no funciona de la misma manera que detectar enemigos cercanos en combate."
L["DisplayWarningsInErrorsFrame"] = "Mostrar advertencias en el marco de errores"
L["DisplayWarningsInErrorsFrameDescription"] = "Establece esto para usar el marco de errores para mostrar advertencias en lugar de usar los marcos emergentes gráficos."
L["DisplayWarnings"] = "Seleccionar ubicación del mensaje de advertencia"
L["Default"] = "Predeterminado"
L["ErrorFrame"] = "Marco de error"
L["Moveable"] = "Movible"
L["EnableSound"] = "Activar alertas de audio"
L["EnableSoundDescription"] = "Establece esto para activar alertas de audio cuando se detectan jugadores enemigos. Diferentes alertas suenan si un jugador enemigo entra en sigilo o si un jugador enemigo está en tu lista de matar a la vista."
L["OnlySoundKoS"] = "Solo sonar alertas de audio para la detección de matar a la vista"
L["OnlySoundKoSDescription"] = "Establece esto para solo reproducir alertas de audio cuando se detectan jugadores enemigos en la lista de matar a la vista."
L["StopAlertsOnTaxi"] = "Desactivar alertas mientras estás en un camino de vuelo"
L["StopAlertsOnTaxiDescription"] = "Detiene todas las nuevas alertas y advertencias mientras estás en un camino de vuelo."

-- Nearby List
L["ListOptions"] = "Lista de cercanos"
L["ListOptionsDescription"] = [[
Opciones sobre cómo se añaden y eliminan jugadores enemigos.
]]
L["RemoveUndetected"] = "Eliminar jugadores enemigos de la lista de cercanos después de:"
L["1Min"] = "1 minuto"
L["1MinDescription"] = "Elimina un jugador enemigo que no ha sido detectado durante más de 1 minuto."
L["2Min"] = "2 minutos"
L["2MinDescription"] = "Elimina un jugador enemigo que no ha sido detectado durante más de 2 minutos."
L["5Min"] = "5 minutos"
L["5MinDescription"] = "Elimina un jugador enemigo que no ha sido detectado durante más de 5 minutos."
L["10Min"] = "10 minutos"
L["10MinDescription"] = "Elimina un jugador enemigo que no ha sido detectado durante más de 10 minutos."
L["15Min"] = "15 minutos"
L["15MinDescription"] = "Elimina un jugador enemigo que no ha sido detectado durante más de 15 minutos."
L["Never"] = "Nunca eliminar"
L["NeverDescription"] = "Nunca elimina jugadores enemigos. La lista de cercanos aún se puede limpiar manualmente."
L["ShowNearbyList"] = "Cambiar a la lista de cercanos al detectar jugadores enemigos"
L["ShowNearbyListDescription"] = "Establece esto para mostrar la lista de cercanos si no está visible cuando se detectan jugadores enemigos."
L["PrioritiseKoS"] = "Priorizar jugadores enemigos de matar a la vista en la lista de cercanos"
L["PrioritiseKoSDescription"] = "Establece esto para mostrar siempre primero los jugadores enemigos de matar a la vista en la lista de cercanos."

-- Map
L["MapOptions"] = "Mapa"
L["MapOptionsDescription"] = [[
Opciones para el mapa del mundo y el minimapa, incluidos iconos y tooltips.
]]
L["MinimapDetection"] = "Activar detección en el minimapa"
L["MinimapDetectionDescription"] = "Al pasar el cursor sobre jugadores enemigos conocidos detectados en el minimapa, se agregarán a la lista de cercanos."
L["MinimapNote"] = "          Nota: Solo funciona para jugadores que pueden rastrear humanoides."
L["MinimapDetails"] = "Mostrar detalles de nivel/clase en los tooltips"
L["MinimapDetailsDescription"] = "Establece esto para actualizar los tooltips del mapa para que se muestren detalles de nivel/clase junto a los nombres de los enemigos."
L["DisplayOnMap"] = "Mostrar iconos en el mapa"
L["DisplayOnMapDescription"] = "Muestra iconos en el mapa para la ubicación de otros usuarios de Spy en tu grupo, banda y hermandad cuando detectan enemigos."
L["SwitchToZone"] = "Cambiar al mapa de la zona actual al detectar enemigos"
L["SwitchToZoneDescription"] = "Cambia el mapa al mapa de la zona actual del jugador cuando se detectan enemigos."
L["MapDisplayLimit"] = "Limitar iconos del mapa mostrados a:"
L["LimitNone"] = "En todas partes"
L["LimitNoneDescription"] = "Muestra todos los enemigos detectados en el mapa sin importar tu ubicación actual."
L["LimitSameZone"] = "Misma zona"
L["LimitSameZoneDescription"] = "Solo muestra enemigos detectados en el mapa si estás en la misma zona."
L["LimitSameContinent"] = "Mismo continente"
L["LimitSameContinentDescription"] = "Solo muestra enemigos detectados en el mapa si estás en el mismo continente."

-- Data Management
L["DataOptions"] = "Gestión de datos"
L["DataOptionsDescription"] = [[

Opciones sobre cómo Spy mantiene y recopila datos.
]]
L["PurgeData"] = "Eliminar datos de jugadores enemigos no detectados después de:"
L["OneDay"] = "1 día"
L["OneDayDescription"] = "Elimina datos de jugadores enemigos que no han sido detectados durante 1 día."
L["FiveDays"] = "5 días"
L["FiveDaysDescription"] = "Elimina datos de jugadores enemigos que no han sido detectados durante 5 días."
L["TenDays"] = "10 días"
L["TenDaysDescription"] = "Elimina datos de jugadores enemigos que no han sido detectados durante 10 días."
L["ThirtyDays"] = "30 días"
L["ThirtyDaysDescription"] = "Elimina datos de jugadores enemigos que no han sido detectados durante 30 días."
L["SixtyDays"] = "60 días"
L["SixtyDaysDescription"] = "Elimina datos de jugadores enemigos que no han sido detectados durante 60 días."
L["NinetyDays"] = "90 días"
L["NinetyDaysDescription"] = "Elimina datos de jugadores enemigos que no han sido detectados durante 90 días."
L["PurgeKoS"] = "Eliminar jugadores de matar a la vista basados en el tiempo no detectado."
L["PurgeKoSDescription"] = "Establece esto para eliminar jugadores de matar a la vista que no han sido detectados según la configuración de tiempo para jugadores no detectados."
L["PurgeWinLossData"] = "Eliminar datos de victorias/derrotas basados en el tiempo no detectado."
L["PurgeWinLossDataDescription"] = "Establece esto para eliminar los datos de victorias/derrotas de tus encuentros con enemigos según la configuración de tiempo para jugadores no detectados."
L["ShareData"] = "Compartir datos con otros usuarios de Spy"
L["ShareDataDescription"] = "Establece esto para compartir los detalles de tus encuentros con jugadores enemigos con otros usuarios de Spy en tu grupo, banda y hermandad."
L["UseData"] = "Usar datos de otros usuarios de Spy"
L["UseDataDescription"] = "Establece esto para usar los datos recopilados por otros usuarios de Spy en tu grupo, banda y hermandad."
L["ShareKOSBetweenCharacters"] = "Compartir jugadores de matar a la vista entre tus personajes"
L["ShareKOSBetweenCharactersDescription"] = "Establece esto para compartir los jugadores que marques como matar a la vista entre otros personajes que juegues en el mismo servidor y facción."

-- Commands
L["SlashCommand"] = "Comando de barra diagonal"
L["SpySlashDescription"] = "Estos botones ejecutan las mismas funciones que las del comando de barra diagonal /spy."
L["Enable"] = "Activar"
L["EnableDescription"] = "Activa Spy y muestra la ventana principal."
L["Show"] = "Mostrar"
L["ShowDescription"] = "Muestra la ventana principal."
L["Hide"] = "Ocultar"
L["HideDescription"] = "Oculta la ventana principal."
L["Reset"] = "Restablecer"
L["ResetDescription"] = "Restablece la posición y apariencia de la ventana principal."
L["ClearSlash"] = "Limpiar"
L["ClearSlashDescription"] = "Borra la lista de jugadores que han sido detectados."
L["Config"] = "Configurar"
L["ConfigDescription"] = "Abre la ventana de configuración de Addons de la interfaz para Spy."
L["KOS"] = "MaV"
L["KOSDescription"] = "Añade/elimina un jugador de la lista de matar a la vista."
L["InvalidInput"] = "Entrada no válida"
L["Ignore"] = "Ignorados"
L["IgnoreDescription"] = "Añade/elimina un jugador de la lista de Ignorados."
L["Test"] = "Prueba"
L["TestDescription"] = "Muestra una advertencia para que pueda reposicionarla."

-- Lists
L["Nearby"] = "Cercanos"
L["LastHour"] = "Última hora"
L["Ignore"] = "Ignorados"
L["KillOnSight"] = "Matar a la Vista"

--Stats
L["Won"] = "Ganado"
L["Lost"] = "Perdido"
L["Time"] = "Tiempo"
L["List"] = "Lista"
L["Filter"] = "Filtro"
L["Show Only"] = "Mostrar solo"
L["Realm"] = "Reino"
L["KOS"] = "MaV"
L["Won/Lost"] = "Ganado/Perdido"
L["Reason"] = "Razón"
L["HonorKills"] = "Muertes con honor"
L["PvPDeaths"] = "Muertes de JcJ"

-- Output Messages
L["VersionCheck"] = "|cffc41e3a¡Advertencia! La versión incorrecta de Spy está instalada. Esta versión es para Wrath of the Lich King - Classic."
L["SpyEnabled"] = "|cff9933ffAddon Spy activado."
L["SpyDisabled"] = "|cff9933ffAddon Spy desactivado. Escribe |cffffffff/spy show|cff9933ff para activarlo."
L["UpgradeAvailable"] = "|cff9933ffHay disponible una nueva versión de Spy. Puede descargarse desde:\n|cffffffffhttps://www.curseforge.com/wow/addons/spy-wotlk"
L["AlertStealthTitle"] = "¡Jugador en sigilo detectado!"
L["AlertKOSTitle"] = "¡Jugador en la lista de matar a la vista detectado!"
L["AlertKOSGuildTitle"] = "¡Guild de jugador en la lista de matar a la vista detectado!"
L["AlertTitle_kosaway"] = "Jugador en la lista de matar a la vista localizado por "
L["AlertTitle_kosguildaway"] = "Guild de jugador en la lista de matar a la vista localizado por "
L["StealthWarning"] = "|cff9933ffJugador en sigilo detectado: |cffffffff"
L["KOSWarning"] = "|cffff0000Jugador en la lista de matar a la vista detectado: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Guild de jugador en la lista de matar a la vista detectado: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff[Spy] "
L["PlayerDetectedColored"] = "Jugador detectado: |cffffffff"
L["PlayersDetectedColored"] = "Jugadores detectados: |cffffffff"
L["KillOnSightDetectedColored"] = "Jugador en la lista de matar a la vista detectado: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Jugador añadido a la lista de Ignorados: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Jugador eliminado de la lista de Ignorados: |cffffffff"
L["PlayerAddedToKOSColored"] = "Jugador añadido a la lista de matar a la vista: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Jugador eliminado de la lista de matar a la vista: |cffffffff"
L["PlayerDetected"] = "[Spy] Jugador detectado: "
L["KillOnSightDetected"] = "[Spy] Jugador en la lista de matar a la vista detectado: "
L["Level"] = "Nivel"
L["LastSeen"] = "Última vez visto"
L["LessThanOneMinuteAgo"] = "hace menos de un minuto"
L["MinutesAgo"] = "minutos atrás"
L["HoursAgo"] = "horas atrás"
L["DaysAgo"] = "días atrás"
L["Close"] = "Cerrar"
L["CloseDescription"] = "|cffffffffOculta la ventana de Spy. Por defecto, se mostrará de nuevo cuando se detecte al próximo jugador enemigo."
L["Left/Right"] = "Izquierda/Derecha"
L["Left/RightDescription"] = "|cffffffffNavega entre las listas de cercanos, última hora, ignorados y matar a la vista."
L["Clear"] = "Limpiar"
L["ClearDescription"] = "|cffffffffLimpia la lista de jugadores detectados. CTRL+Clic activará/desactivará Spy. Mayús+Clic activará/desactivará todos los sonidos."
L["SoundEnabled"] = "Alertas de audio activadas"
L["SoundDisabled"] = "Alertas de audio desactivadas"
L["NearbyCount"] = "Cantidad de cercanos"
L["NearbyCountDescription"] = "|cffffffffCantidad de jugadores cercanos."
L["Statistics"] = "Estadísticas"
L["StatsDescription"] = "|cffffffffMuestra una lista de encuentros con jugadores enemigos, registros de victorias/derrotas y dónde fueron vistos por última vez."
L["AddToIgnoreList"] = "Añadir a lista de Ignorar"
L["AddToKOSList"] = "Añadir a lista de matar a la vista"
L["RemoveFromIgnoreList"] = "Eliminar de lista de Ignorar"
L["RemoveFromKOSList"] = "Eliminar de lista de matar a la vista"
L["RemoveFromStatsList"] = "Eliminar de la lista de estadísticas"   
L["AnnounceDropDownMenu"] = "Anunciar"
L["KOSReasonDropDownMenu"] = "Establecer razón de matar a la vista"
L["PartyDropDownMenu"] = "Grupo"
L["RaidDropDownMenu"] = "Banda"
L["GuildDropDownMenu"] = "Hermandad"
L["LocalDefenseDropDownMenu"] = "Defensa Local"
L["Player"] = " (Jugador)"
L["KOSReason"] = "matar a la vista"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Introduce tu propia razón..."
L["KOSReasonClear"] = "Borrar razón"
L["StatsWins"] = "|cff40ff00Victorias: "
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070ddDerrotas: "
L["Located"] = "localizado:"
L["Yards"] = "metros"
L["LocalDefenseChannelName"] = "DefensaLocal"

Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Combate iniciado";
		["content"] = {
			"Atacó sin razón alguna",
			"Atacó cerca de un PNJ de misión",
			"Atacó mientras estaba luchando contra PNJs",
			"Atacó mientras estaba cerca de una instancia",
			"Atacó mientras estaba ausente",
			"Atacó mientras estaba montado/volando",
			"Atacó mientras tenía poca salud/mana",
		};
	},
	[2] = {
		["title"] = "Estilo de combate";
		["content"] = {
			"Me emboscó",
			"Siempre me ataca a la vista",
			"Me mató con un personaje de nivel superior",
			"Me aplastó con un grupo de enemigos",
			"No ataca sin respaldo",
			"Siempre pide ayuda",
			"Usa demasiado control de masas",
		};
	},
	[3] = {
		["title"] = "Acampar";
		["content"] = {
			"Me acampó",
			"Acampó a un alterno",
			"Acampó a jugadores de nivel bajo",
			"Acampó en sigilo",
			"Acampó a miembros de la hermandad",
			"Acampó PNJs/objetivos del juego",
			"Acampó una ciudad/sitio",
		};
	},
	[4] = {
		["title"] = "Misiones";
		["content"] = {
			"Me atacó mientras estaba haciendo misiones",
			"Me atacó después de que ayudé con una misión",
			"Interfirió con un objetivo de misión",
			"Comenzó una misión que quería hacer",
			"Mató a los PNJs de mi facción",
			"Mató a un PNJ de misión",
		};
	},
	[5] = {
		["title"] = "Robo de recursos";
		["content"] = {
			"Recolectó hierbas que quería",
			"Recolectó minerales que quería",
			"Recolectó recursos que quería",
			"Me mató y robó mi objetivo/PNJ raro",
			"Desolló mis presas",
			"Despojó mis presas",
			"Pescó en mi poza",
		};
	},
	[6] = {
		["title"] = "Otros";
		["content"] = {
			"Marcado para JcJ",
			"Me empujó por un precipicio",
			"Usa trucos de ingeniería",
			"Siempre logra escapar",
			"Usa objetos y habilidades para escapar",
			"Explota las mecánicas del juego",
			"Introduce tu propia razón...",
		};
	},
}

StaticPopupDialogs["Spy_SetKOSReasonOther"] = {
	preferredIndex=STATICPOPUPS_NUMDIALOGS,  -- http://forums.wowace.com/showthread.php?p=320956
	text = "Introduce la razón de matar a la vista para %s:",
	button1 = "Establecer",
	button2 = "Cancelar",
	timeout = 120,
	hasEditBox = 1,
	editBoxWidth = 260,	
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
   	OnAccept = function(self)
		local reason = self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Introduce tu propia razón...", reason)
	end,
};

-- Class descriptions
L["UNKNOWN"] = "Desconocido"
L["DRUID"] = "Druida"
L["HUNTER"] = "Cazador"
L["MAGE"] = "Mago"
L["PALADIN"] = "Paladín"
L["PRIEST"] = "Sacerdote"
L["ROGUE"] = "Pícaro"
L["SHAMAN"] = "Chamán"
L["WARLOCK"] = "Brujo"
L["WARRIOR"] = "Guerrero"
L["DEATHKNIGHT"] = "Caballero de la muerte"
L["MONK"] = "Monje"
L["DEMONHUNTER"] = "Cazador de demonios"
L["EVOKER"] = "Evocador"

-- Race descriptions
L["Human"] = "Humano"
L["Orc"] = "Orco"
L["Dwarf"] = "Enano"
L["Tauren"] = "Tauren"
L["Troll"] = "Trol"
L["Night Elf"] = "Elfo de la noche"
L["Undead"] = "No-muerto"
L["Gnome"] = "Gnomo"
L["Blood Elf"] = "Elfo de sangre"
L["Draenei"] = "Draenei"
L["Goblin"] = "Goblin"
L["Worgen"] = "Huargen"
L["Pandaren"] = "Pandaren"
L["Highmountain Tauren"] = "Tauren Monte Alto"
L["Lightforged Draenei"] = "Draenei forjado por la Luz"
L["Nightborne"] = "Nocheterna"
L["Void Elf"] = "Elfo del Vacío"
L["Dark Iron Dwarf"] = "Enano Hierro Negro"
L["Mag'har Orc"] = "Orco Mag'har"
L["Kul Tiran"] = "Ciudadano de Kul Tiras"
L["Zandalari Troll"] = "Trol Zandalari"
L["Mechagnome"] = "Mecagnomo"
L["Vulpera"] = "Vulpera"
L["Dracthyr"] = "Dracthyr"
 
-- Stealth abilities
L["Stealth"] = "Sigilo"
L["Prowl"] = "Acechar"
 
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

};