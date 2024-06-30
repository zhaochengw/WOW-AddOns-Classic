-- SCT localization information
-- Spanish Locale
-- Translation by JSR1976  / fixed and updated by shiftos

if GetLocale() ~= "esES" then return end

local media = LibStub("LibSharedMedia-3.0")

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "Da\195\177o", tooltipText = "Muestra el da\195\177o cuerpo a cuerpo y otros tipos de da\195\177o (fuego, ca\195\173da, etc...)"};
SCT.LOCALS.OPTION_EVENT2 = {name = "Fallos", tooltipText = "Muestra los fallos de cuerpo a cuerpo"};
SCT.LOCALS.OPTION_EVENT3 = {name = "Esquivas", tooltipText = "Muestra los golpes esquivados en combate cuerpo a cuerpo"};
SCT.LOCALS.OPTION_EVENT4 = {name = "Paradas", tooltipText = "Muestra las paradas en combate cuerpo a cuerpo"};
SCT.LOCALS.OPTION_EVENT5 = {name = "Bloqueos", tooltipText = "Muestra los bloqueos en combate cuerpo o cuerpo y los bloqueos parciales"};
SCT.LOCALS.OPTION_EVENT6 = {name = "Da\195\177o de Hechizos", tooltipText = "Muestra el da\195\177o de hechizos"};
SCT.LOCALS.OPTION_EVENT7 = {name = "Hechizos de Curaci\195\179n", tooltipText = "Muestra los hechizos de curaci\195\179n"};
SCT.LOCALS.OPTION_EVENT8 = {name = "Resistencia a Hechizos", tooltipText = "Muestra la Resistencia a hechizos"};
SCT.LOCALS.OPTION_EVENT9 = {name = "Debuffs", tooltipText = "Muestra los debuffs"};
SCT.LOCALS.OPTION_EVENT10 = {name = "Absorber/Otros", tooltipText = "Muestra el da\195\177o absorvido, reflejado, inmune, etc"};
SCT.LOCALS.OPTION_EVENT11 = {name = "Salud Baja", tooltipText = "Muestra un aviso cuando tienes poca salud"};
SCT.LOCALS.OPTION_EVENT12 = {name = "Man\195\161 Bajo", tooltipText = "Muestra un aviso cuando tienes poco man\195\161"};
SCT.LOCALS.OPTION_EVENT13 = {name = "Poder Ganado", tooltipText = "Muestra tus ganancias de man\195\161, furia o energ\195\173a de pociones, objetos, buffs, etc...(No la regeneraci\195\179n normal)"};
SCT.LOCALS.OPTION_EVENT14 = {name = "Estado de Combate", tooltipText = "Muestra un aviso cuando entras o sales de un combate"};
SCT.LOCALS.OPTION_EVENT15 = {name = "Puntos de Combo", tooltipText = "Muestra tus puntos de combo"};
SCT.LOCALS.OPTION_EVENT16 = {name = "Honor Ganado", tooltipText = "Muestra tus Puntos de contribuci\195\179n de Honor"};
SCT.LOCALS.OPTION_EVENT17 = {name = "Buffs", tooltipText = "Muestra tus buffs"};
SCT.LOCALS.OPTION_EVENT18 = {name = "Buff Desvanecido", tooltipText = "Muestra un aviso cuando pierdes buffs"};
SCT.LOCALS.OPTION_EVENT19 = {name = "Habilidades Activas", tooltipText = "Muestra una alerta cuando se activa una habilidad (Ejecutar, Mongoose Bite, Hammer of Wrath, etc)"};
SCT.LOCALS.OPTION_EVENT20 = {name = "Reputaci\195\179n", tooltipText = "Muestra un aviso cuando ganas o pierdes reputaci\195\179n"};
SCT.LOCALS.OPTION_EVENT21 = {name = "Tus Curaciones", tooltipText = "Muestra cu\195\161nto curas a otros"};
SCT.LOCALS.OPTION_EVENT22 = {name = "Habilidades", tooltipText = "Muestra un aviso cuando ganas puntos de Habilidad"};
SCT.LOCALS.OPTION_EVENT23 = {name = "Golpes Mortales", tooltipText = "Muestra un aviso cuando realizas un golpe mortal"};
SCT.LOCALS.OPTION_EVENT24 = {name = "Interrupciones", tooltipText = "Muestra un aviso cuando eres interrumpido"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "Activar SCT", tooltipText = "Determina si se activa Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK2 = { name = "Marca de Texto de Combate", tooltipText = "Detemina si se coloca un * alrededor de los mensajes en pantalla"};
SCT.LOCALS.OPTION_CHECK3 = { name = "Mostrar Sanadores", tooltipText = "Muestra qui\195\169n o qu\195\169 te cura"};
SCT.LOCALS.OPTION_CHECK4 = { name = "Desplazar el Texto hacia Abajo", tooltipText = "Determina si el texto se desplaza hacia abajo"};
SCT.LOCALS.OPTION_CHECK5 = { name = "Cr\195\173ticos Pegajosos", tooltipText = "Muestra tus golpes o curaciones cr\195\173ticas sobre tu cabeza"};
SCT.LOCALS.OPTION_CHECK6 = { name = "Tipo de Da\195\177o de Hechizo", tooltipText = "Muestra el tipo de da\195\177o de hechizo"};
SCT.LOCALS.OPTION_CHECK7 = { name = "Aplicar Fuente a Da\195\177o", tooltipText = "Determina si se cambia la fuente de da\195\177o del juego para que sea igual que la fuente usada para el Texto de SCT\n\nIMPORTANTE: DEBES DESCONECTARTE Y VOLVER A ENTRAR PARA QUE ESTO TENGA EFECTO. RECARGAR LA INTERFAZ NO FUNCIONAR\195\129"};
SCT.LOCALS.OPTION_CHECK8 = { name = "Mostrar todas las Ganancias de Poder", tooltipText = "Muestra todas las ganancias de poder, no solo aquellas que aparecen en el registro de chat\n\nNOTA: Esto depende de si el evento Poder Ganado est\195\161 activo, ESPAMEA MUCHO, y a veces puede actuar de forma extra\195\177a para Druidas justo tras cambiar de forma de vuelta a la forma de lanzador de hechizos."};
SCT.LOCALS.OPTION_CHECK10 = { name = "Mostrar Sobrecuraci\195\179n", tooltipText = "Muestra cu\195\161nto de m\195\161s se ha curado tanto a t\195\173 como a tus objetivos. Depende de que 'Tus Curaciones' est\195\169 activo"};
SCT.LOCALS.OPTION_CHECK11 = { name = "Sonidos de Alerta", tooltipText = "Determina si se reproducen sonidos para tus avisos"};
SCT.LOCALS.OPTION_CHECK12 = { name = "Colores de Hechizo", tooltipText = "Muestra el da\195\177o de hechizos en colores dependiendo de la clase del hechizo"};
SCT.LOCALS.OPTION_CHECK13 = { name = "Activar Eventos Personalizados", tooltipText = "Determina si se usan eventos personalizados. Cuando est\195\161 desactivado, SCT usa mucha menos memoria"};
SCT.LOCALS.OPTION_CHECK14 = { name = "Spell/Skill Name", tooltipText = "Enables or Disables showing the name of the Spell or Skill that damaged you"};
SCT.LOCALS.OPTION_CHECK15 = { name = "Destello", tooltipText = "Hace que los cr\195\173ticos pegajosos 'Destelleen' en la pantalla."};
SCT.LOCALS.OPTION_CHECK16 = { name = "Glancing/Crushing", tooltipText = "Muestra los golpes de Glancing ~150~ y Crushing ^150^"};
SCT.LOCALS.OPTION_CHECK17 = { name = "Mostrar tus HoTs", tooltipText = "Muestra tus hechizos de curaci\195\179n sobre tiempo en otros. Nota: esto puede causar mucho spam si lanzas muchos de ellos"};
SCT.LOCALS.OPTION_CHECK18 = { name = "Show Heals at Nameplates", tooltipText = "Enables or Disables attempting to show your heals over the nameplate of the person(s) you heal.\n\nFriendly nameplates must be on, you must be able to see the nameplate, and it will not work 100% of the time. If it does not work, heals appear in the normal configured position.\n\nDisabling can require a reloadUI to take effect."};
SCT.LOCALS.OPTION_CHECK19 = { name = "Disable WoW Healing", tooltipText = "Enables or Disables showing the built in healing text, added in patch 2.1."};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="Velocidad de la Animaci\195\179n del Texto", minText="Lenta", maxText="R\195\161pida", tooltipText = "Controla la velocidad a la que el texto se desplaza verticalmente"};
SCT.LOCALS.OPTION_SLIDER2 = { name="Tama\195\177o del Texto", minText="Peque\195\177o", maxText="Grande", tooltipText = "Controla el tama\195\177o del texto"};
SCT.LOCALS.OPTION_SLIDER3 = { name="Porcentaje de Salud", minText="10%", maxText="90%", tooltipText = "Controla el porcentaje de salud necesario para mostrar un aviso"};
SCT.LOCALS.OPTION_SLIDER4 = { name="Porcentaje de Man\195\161",  minText="10%", maxText="90%", tooltipText = "Controla el porcentaje de man\195\161 necesario para mostrar un aviso"};
SCT.LOCALS.OPTION_SLIDER5 = { name="Opacidad del Texto", minText="0%", maxText="100%", tooltipText = "Controla la opacidad del texto"};
SCT.LOCALS.OPTION_SLIDER6 = { name="Distancia de Movimiento del Texto", minText="Peque\195\177a", maxText="Grande", tooltipText = "Controla la distancia de movimiento del texto entre cada actualizaci\195\179n"};
SCT.LOCALS.OPTION_SLIDER7 = { name="Posici\195\179n Horizontal del Centro del Texto", minText="-600", maxText="600", tooltipText = "Controla la posici\195\179n del centro del texto"};
SCT.LOCALS.OPTION_SLIDER8 = { name="Posici\195\179n Vertical del Centro del Texto", minText="-400", maxText="400", tooltipText = "Controla la posici\195\179n del centro del texto"};
SCT.LOCALS.OPTION_SLIDER9 = { name="Posici\195\179n Horizontal del Centro del Mensaje", minText="-600", maxText="600", tooltipText = "Controla la posici\195\179n del centro del mensaje"};
SCT.LOCALS.OPTION_SLIDER10 = { name="Posici\195\179n Vertical del Centro del Mensaje", minText="-400", maxText="400", tooltipText = "ontrola la posici\195\179n del centro del mensaje"};
SCT.LOCALS.OPTION_SLIDER11 = { name="Velocidad de Desvanecimiento del Mensaje", minText="R\195\161pida", maxText="Lenta", tooltipText = "Controla la velocidad a la que los mensajes se desvanecen"};
SCT.LOCALS.OPTION_SLIDER12 = { name="Tama\195\177o del Mensaje", minText="Peque\195\177o", maxText="Grande", tooltipText = "Controla el tama\195\177o del texto del mensaje"};
SCT.LOCALS.OPTION_SLIDER13 = { name="Filtro de Curaci\195\179n", minText="0", maxText="500", tooltipText = "Controla la cantidad de curaci\195\179n m\195\173nima necesaria para que aparezca en SCT. Esto va bien para filtrar curaciones peque\195\177as frecuentes como Totems, Bendiciones, etc..."};
SCT.LOCALS.OPTION_SLIDER14 = { name="Filtro de Man\195\161", minText="0", maxText="500", tooltipText = "Controla la cantidad de curaci\195\179n m\195\173nima necesaria para que aparezca en SCT. Esto va bien para filtrar curaciones peque\195\177as frecuentes como Totems, Bendiciones, etc..."};
SCT.LOCALS.OPTION_SLIDER15 = { name="Distnacia de Separaci\195\179n del HUD", minText="0", maxText="200", tooltipText = "Controla la distancia desde el centro para la animaci\195\179n de HUD. \195\154til cuando quieres mantener todo centrado pero ajustado a una distancia del centro"};
SCT.LOCALS.OPTION_SLIDER16 = { name="Shorten Spell Size", minText="1", maxText="30", tooltipText = "Spell names over this length will be shortend using the selected shorten type."};

--Spell Color options]
SCT.LOCALS.OPTION_COLOR1 = { name=SPELL_SCHOOL0_CAP, tooltipText = "Controla el color para "..SPELL_SCHOOL0_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR2 = { name=SPELL_SCHOOL1_CAP, tooltipText = "Controla el color para "..SPELL_SCHOOL1_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR3 = { name=SPELL_SCHOOL2_CAP, tooltipText = "Controla el color para "..SPELL_SCHOOL2_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR4 = { name=SPELL_SCHOOL3_CAP, tooltipText = "Controla el color para "..SPELL_SCHOOL3_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR5 = { name=SPELL_SCHOOL4_CAP, tooltipText = "Controla el color para "..SPELL_SCHOOL4_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR6 = { name=SPELL_SCHOOL5_CAP, tooltipText = "Controla el color para "..SPELL_SCHOOL5_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR7 = { name=SPELL_SCHOOL6_CAP, tooltipText = "Controla el color para "..SPELL_SCHOOL6_CAP.." spells"};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="Opciones de SCT "..SCT.Version, tooltipText = "Clic para Arrastrar"};
SCT.LOCALS.OPTION_MISC2 = {name="Cerrar", tooltipText = "Cierra los Colores de Hechizo" };
SCT.LOCALS.OPTION_MISC3 = {name="Editar", tooltipText = "Edita los Colores de Hechizo" };
SCT.LOCALS.OPTION_MISC4 = {name="Otras Opciones"};
SCT.LOCALS.OPTION_MISC5 = {name="Opciones de Aviso"};
SCT.LOCALS.OPTION_MISC6 = {name="Opciones de Animaci\195\179n"};
SCT.LOCALS.OPTION_MISC7 = {name="Elige un Perfil de Jugador"};
SCT.LOCALS.OPTION_MISC8 = {name="Guardar y Cerrar", tooltipText = "Guarda tus ajustes actuales y cierra las opciones"};
SCT.LOCALS.OPTION_MISC9 = {name="Reestablecer", tooltipText = "-Aviso-\n\n\194\191Est\195\161s seguro de querer reestablecer las opciones por defecto de SCT?"};
SCT.LOCALS.OPTION_MISC10 = {name="Perfiles", tooltipText = "Elige otro perfil de personaje"};
SCT.LOCALS.OPTION_MISC11 = {name="Cargar", tooltipText = "Carga el perfil de otros personajes en \195\169ste"};
SCT.LOCALS.OPTION_MISC12 = {name="Delete", tooltipText = "Delete a characters profile"};
SCT.LOCALS.OPTION_MISC13 = {name="Text Options" };
SCT.LOCALS.OPTION_MISC14 = {name="Marco 1"};
SCT.LOCALS.OPTION_MISC15 = {name="Mensajes"};
SCT.LOCALS.OPTION_MISC16 = {name="Animaci\195\179n"};
SCT.LOCALS.OPTION_MISC17 = {name="Opciones de Hechizo"};
SCT.LOCALS.OPTION_MISC18 = {name="Marcos"};
SCT.LOCALS.OPTION_MISC19 = {name="Hechizos"};
SCT.LOCALS.OPTION_MISC20 = {name="Marco 2"};
SCT.LOCALS.OPTION_MISC21 = {name="Eventos"};
SCT.LOCALS.OPTION_MISC22 = {name="Perfil Cl\195\161sico", tooltipText = "Carga el perfil Cl\195\161sico. Hace que SCT act\195\186e de forma muy similar a como es usado por defecto"};
SCT.LOCALS.OPTION_MISC23 = {name="Perfil de Rendimiento", tooltipText = "Carga el perfil de Rendimiento. Selecciona todos los ajustes necesarios para conseguir el mejor rendimiento de SCT"};
SCT.LOCALS.OPTION_MISC24 = {name="Perfil Dividido", tooltipText = "Carga el perfil Dividido. Hace que los mensajes de da\195\177o recibido y los eventos aparezcan en la parte derecha, y las curaciones recibidas y buffs en la parte izquierda."};
SCT.LOCALS.OPTION_MISC25 = {name="Perfil Grayhoof", tooltipText = "Carga el perfil de Grayhoof. Hace que SCT act\195\186e con los ajustes que usa Grayhoof (el autor del accesorio)."};
SCT.LOCALS.OPTION_MISC26 = {name="Perfiles Integrados", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="Perfil SCTD Dividido", tooltipText = "Carga el perfil SCTD Dividido. Si tienes SCTD instalado hace que los eventos recibidos aparezcan en la derecha, los salientes en la izquierda, y los dem\195\161s arriba."};
SCT.LOCALS.OPTION_MISC28 = {name="Test", tooltipText = "Create Test event for each frame"};

--Animation Types
SCT.LOCALS.OPTION_SELECTION1 = { name="Tipo de Animaci\195\179n", tooltipText = "Qu\195\169 tipo de animaci\195\179n usar", table = {[1] = "Vertical (Normal)",[2] = "Arco Iris",[3] = "Horizontal",[4] = "En \195\161ngulo hacia abajo", [5] = "En \195\161ngulo hacia arriba", [6] = "Rociador", [7] = "Curvado en HUD", [8] = "En \195\161ngulo en HUD"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="Estilo Lateral", tooltipText = "Como se debe mostrar el desplazamiento lateral de texto", table = {[1] = "Alternando",[2] = "Da\195\177o Izquierda",[3] = "Da\195\177o Derecha", [4] = "Todo a la Izquierda", [5] = "Todo a la Derecha"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="Fuente", tooltipText = "Qu\195\169 fuente usar", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION4 = { name="Borde de la Fuente", tooltipText = "Qu\195\169 borde usar para las fuentes", table = {[1] = "Ninguno",[2] = "Fino",[3] = "Grueso"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="Fuente de los Mensajes", tooltipText = "Qu\195\169 fuente usar para los mensajes", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION6 = { name="Borde de la Fuente de los Mensajes", tooltipText = "Qu\195\169 borde usar para las fuentes de los mensajes", table = {[1] = "Ninguno",[2] = "Fino",[3] = "Grueso"}};
SCT.LOCALS.OPTION_SELECTION7 = { name="Alineamiento de Texto", tooltipText = "C\195\179mo se alinea el texto. Es m\195\161s \195\186til para animaciones verticales o de HUD. El alineamiento de HUD har\195\161 que la parte izquierda se alinee a la derecha y la parte derecha se alinee a la izquierda", table = {[1] = "Izquierda",[2] = "Centro",[3] = "Derecha", [4] = "Centrado en HUD"}};
SCT.LOCALS.OPTION_SELECTION8 = { name="Shorten Spell Type", tooltipText = "How to shorten spell names.", table = {[1] = "Truncate",[2] = "Abbreviate"}};
