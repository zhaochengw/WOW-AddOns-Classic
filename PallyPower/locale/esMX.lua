local L = LibStub("AceLocale-3.0"):NewLocale("PallyPower", "esMX", false, false)
if not L then return end
L["ALTMENU_LINE1"] = "puede ser asignado"
L["ALTMENU_LINE2"] = "una bendición normal de:"
L["AURA"] = "Botón Aura"
L["AURA_DESC"] = "[|cffffd200Activar|r / |cffffd200Desactivar|r] El botón Aura o seleccione el Aura que desea rastrear."
L["AURABTN"] = "Botón Aura"
L["AURABTN_DESC"] = "[Activar / Desactivar] El botón Aura"
L["AURATRACKER"] = "Rastreador de Aura"
L["AURATRACKER_DESC"] = "Seleccione el Aura que desea rastrear"
L["AUTO"] = "Botón Auto Buff"
L["AUTO_DESC"] = "[|cffffd200Enable|r / |cffffd200Disable|r] El botón Auto Buff o [|cffffd200Enable|r / |cffffd200Disable|r] Espera a los jugadores."
L["AUTOASSIGN"] = "Auto-Asignar"
L["AUTOASSIGN_DESC"] = [=[Asignar automáticamente todas las bendiciones basadas en
la cantidad de paladines disponibles
y sus bendiciones disponibles.

|cffffffff [Shift-clic izquierdo]|r Usar campo de batalla
plantilla de asignación en lugar de Banda
plantilla de asignación.]=]
L["AUTOBTN"] = "Botón Auto Buff"
L["AUTOBTN_DESC"] = "[Activar / Desactivar] El botón Auto Buff"
L["AUTOKEY1"] = "Clave de bendición normal automática"
L["AUTOKEY1_DESC"] = "Enlace de teclas para el pulido automático de bendiciones normales."
L["AUTOKEY2"] = "Clave de bendición mayor automática"
L["AUTOKEY2_DESC"] = "Enlace de teclas para el pulido automático de mayores bendiciones."
L["BAP"] = "Escala de asignaciones de bendición"
L["BAP_DESC"] = "Esto le permite ajustar el tamaño general del Panel de Asignaciones de Bendición"
L["BRPT"] = "Informe de bendiciones"
L["BRPT_DESC"] = "Informar todas las bendiciones asignaciones a la canal de Banda o Grupo."
L["BSC"] = "Escala de botones de PallyPower"
L["BSC_DESC"] = "Esto le permite ajustar el tamaño general de los botones de PallyPower"
L["BUFFDURATION"] = "Duración del beneficio"
L["BUFFDURATION_DESC"] = "Si esta opción está desactivada, los botones de Clase y Jugador ignorarán la duración de los beneficios permitiendo que se vuelva a aplicar un beneficio a voluntad. Esto es especialmente útil para los Paladines de Protección cuando envían Bendiciones Mayores para generar más amenaza."
L["BUTTONS"] = "Botones"
L["BUTTONS_DESC"] = "Cambiar la configuración del botón"
L["CANCEL"] = "Cancelar"
L["CLASSBTN"] = "Botones de clase"
L["CLASSBTN_DESC"] = "Si esta opción está deshabilitada, también deshabilitará los Botones del jugador y solo podrá pulir usando el botón Auto Buff."
L["CPBTNS"] = "Botones de clase y jugador"
L["CPBTNS_DESC"] = "[|cffffd200Enable|r / |cffffd200Disable|r] El jugador (s) o los botones de clase."
L["DISPEDGES"] = "Fronteras"
L["DISPEDGES_DESC"] = "Cambiar los bordes del botón"
L["DRAG"] = "Arrastre el botón de la manija"
L["DRAG_DESC"] = "[|cffffd200Activar|r / |cffffd200Desactivar|r] El botón de arrastre de la manija."
L["DRAGHANDLE"] = [=[|cffffffff [clic izquierdo]|r |cffff0000Lock|r / |cff00ff00Unlock|r PallyPower
|cffffffff [Hacer clic con el botón izquierdo]|r Mover PallyPower
|cffffffff [clic derecho]|r Abrir asignaciones de bendición
|cffffffff [Shift-Click-derecho]|r Abrir Opciones]=]
L["DRAGHANDLE_ENABLED"] = "Arrastrar asa"
L["DRAGHANDLE_ENABLED_DESC"] = "[Activar / Desactivar] El controlador de arrastre"
L["ENABLEPP"] = "Habilitar PallyPower"
L["ENABLEPP_DESC"] = "[Activar / Desactivar] PallyPower"
L["FREEASSIGN"] = "Asignación gratuita"
L["FREEASSIGN_DESC"] = "Permitir que otros cambien su bendiciones sin ser Asistente o Líder de Banda."
L["FULLY_BUFFED"] = "Completamente pulido"
L["HORLEFTDOWN"] = "Horizontal izquierda | Abajo"
L["HORLEFTUP"] = "Horizontal izquierda | Arriba"
L["HORRIGHTDOWN"] = "Horizontal derecha | Abajo"
L["HORRIGHTUP"] = "Horizontal derecha | Arriba"
L["LAYOUT"] = "Botón Buff | Diseño del botón del jugador"
L["LAYOUT_DESC"] = [=[Vertical [Izquierda / Derecha]
Horizontal [Arriba / Abajo]]=]
L["MAINASSISTANT"] = "Asistente principal de Auto-Buff"
L["MAINASSISTANT_DESC"] = "Si habilita esta opción, PallyPower sobrescribirá automáticamente una Bendición Mayor con una Bendición Normal en los jugadores marcados con el rol |cffffd200Main Assistant|r en el Panel de Incursión de Blizzard. Esto es útil para evitar bendecir el |cffffd200Main Assistant|r papel con una mayor bendición de salvación ."
L["MAINASSISTANTGBUFFDP"] = "Anular druidas / paladines ..."
L["MAINASSISTANTGBUFFDP_DESC"] = "Seleccione la asignación de Bendición Mayor que desea sobrescribir en el Tanque Principal: Druidas / Paladines."
L["MAINASSISTANTGBUFFW"] = "Anular Guerreros ..."
L["MAINASSISTANTGBUFFW_DESC"] = "Seleccione la asignación de Bendición Mayor que desea sobrescribir en el Tanque Principal: Guerreros."
L["MAINASSISTANTNBUFFDP"] = "... con Normal ..."
L["MAINASSISTANTNBUFFDP_DESC"] = "Seleccione la Bendición Normal que desea utilizar para sobrescribir el Tanque Principal: Druidas / Paladines."
L["MAINASSISTANTNBUFFW"] = "... con Normal ..."
L["MAINASSISTANTNBUFFW_DESC"] = "Seleccione la Bendición Normal que desea usar para sobrescribir el Tanque Principal: Guerreros."
L["MAINROLES"] = "Tanque principal / Roles de asistencia principal"
L["MAINROLES_DESC"] = [=[Estas opciones se pueden usar para asignar automáticamente Bendiciones Normales alternativas para cualquier Bendición Mayor asignada a Guerreros, Druidas o Paladines |cffff0000only|r.

Normalmente, los roles de Tanque principal y Asistencia principal se han utilizado para identificar los Tanques principales y los Off-Tanks (Asistencia principal), sin embargo, algunos gremios asignan el rol de Tanque principal a los Tanques principales y a los Off-Tanks y asignan el rol de Asistencia principal a los Sanadores.

Al tener una configuración separada para ambos roles, permitirá a los líderes de clase de paladín o líderes de banda eliminar, por ejemplo, Mayor bendición de salvación de las clases de Tanking o si los sanadores de druida o paladín están marcados con el rol de asistencia principal, podrían configurarse para obtener Bendición Normal de Sabiduría vs Bendición Mayor de Poder que permitiría asignar Mayor Bendición de Poder para Druidas y Paladines con especificación DPS y Bendición Normal de Sabiduría para Sanar Druidas y Paladines con especificación.
]=]
L["MAINTANKGBUFFDP"] = "Anular druidas / paladines ..."
L["MAINTANKGBUFFDP_DESC"] = "Seleccione la asignación de Bendición Mayor que desea sobreescribir en el Tanque Principal: Druidas / Paladines."
L["MAINTANKGBUFFW"] = "Anular Guerreros ..."
L["MAINTANKGBUFFW_DESC"] = "Seleccione la asignación de Bendición Mayor que desea sobrescribir en el Tanque Principal: Guerreros."
L["MAINTANKNBUFFDP"] = "... con Normal ..."
L["MAINTANKNBUFFDP_DESC"] = "Seleccione la Bendición Normal que desea usar para sobrescribir el Tanque Principal: Druidas / Paladines."
L["MAINTANKNBUFFW"] = "... con Normal ..."
L["MAINTANKNBUFFW_DESC"] = "Seleccione la Bendición Normal que desea usar para sobreescribir el Tanque Principal: Guerreros."
L["MINIMAPICON"] = [=[|cffffffff [Clic izquierdo]|r Abrir asignaciones de bendición
|cffffffff [clic derecho]|r Abrir opciones]=]
L["NONE"] = "Ninguno"
L["NONE_BUFFED"] = "Ninguno pulido"
L["OPTIONS"] = "Opciones"
L["OPTIONS_DESC"] = [=[Abre el PallyPower
panel de opciones de complementos.]=]
L["PARTIALLY_BUFFED"] = "Parcialmente pulido"
L["PLAYERBTNS"] = "Botones de jugador"
L["PLAYERBTNS_DESC"] = "Si esta opción está desactivada, ya no verás los botones emergentes que muestran jugadores individuales y no podrás volver a aplicar Bendiciones normales mientras estás en combate."
L["PP_CLEAR"] = "Borrar"
L["PP_CLEAR_DESC"] = [=[Borra todas las bendiciones
asignaciones para sí mismo,
Party y Raid Paladins.]=]
L["PP_COLOR"] = "Cambiar los colores de estado de los botones de mejora"
L["PP_LOOKS"] = "Cambiar la apariencia de PallyPower"
L["PP_MAIN"] = "Configuración principal de PallyPower"
L["PP_NAME"] = "PallyPower Classic"
L["PP_RAS1"] = "--- Asignaciones de paladín ---"
L["PP_RAS2"] = "--- Fin de asignaciones ---"
L["PP_RAS3"] = "ADVERTENCIA: Hay más de 5 paladines en una redada."
L["PP_RAS4"] = "¡Tanques, apaguen manualmente Bendición de salvación!"
L["PP_REFRESH"] = "Actualizar"
L["PP_REFRESH_DESC"] = [=[Actualiza todas las bendiciones
tareas, talentos y
Símbolo de reyes entre sí,
Party y Raid Paladins.]=]
L["PP_RESET"] = "Por si acaso te equivocas"
L["PPMAINTANK"] = "Depósito principal auto-pulido"
L["PPMAINTANK_DESC"] = "Si habilita esta opción, PallyPower sobrescribirá automáticamente una Bendición Mayor con una Bendición Normal en los jugadores marcados con el rol |cffffd200Main Tank|r en el Panel de Incursión de Blizzard. Esto es útil para evitar bendecir el |cffffd200Main Tank|r papel con una mayor bendición de salvación ."
L["RAID"] = "Banda"
L["RAID_DESC"] = "Opciones de banda"
L["REPORTCHANNEL"] = "Canal de informes de bendiciones"
L["REPORTCHANNEL_DESC"] = [=[Establezca la ventana deseada para transmitir el Informe Bliessings a:

|cffffd200 [Ninguno]|r Selecciona el canal en función de la composición del grupo. (Grupo / Banda)

|cffffd200 [Lista de canales]|r Una lista de canales autocompletada basada en los canales a los que se ha unido el reproductor. Los canales predeterminados como Comercio, General, etc. se filtran automáticamente de la lista.

|cffffff00Nota: Si cambia su orden de canal, deberá volver a cargar su IU y verificar que se está transmitiendo al canal correcto.|r]=]
L["RESET"] = "Restablecer marcos"
L["RESET_DESC"] = "Restablecer todos los marcos de PallyPower de nuevo al centro"
L["RESIZEGRIP"] = [=[Hacer clic con el botón izquierdo para mantener el tamaño
El botón derecho restablece el tamaño predeterminado]=]
L["RFM"] = "Furia justiciera"
L["RFM_DESC"] = "[Activar / Desactivar] Furia recta"
L["SALVCOMBAT"] = "Salv en combate"
L["SALVCOMBAT_DESC"] = [=[Si habilita esta opción, podrá pulir Guerreros, Druidas y Paladines con Mayor Bendición de Salvación durante el combate.

|cffffff00Nota: Esta configuración SOLO se aplica a los grupos de banda porque en nuestra cultura actual, muchos tanques usan scripts / complementos para cancelar las mejoras que solo se pueden hacer mientras no están en combate. Esta opción es básicamente una seguridad para evitar pulir accidentalmente un tanque con salvación durante el combate.|r]=]
L["SEAL"] = "Botón de sellado"
L["SEAL_DESC"] = "[|cffffd200Enable|r / |cffffd200Disable|r] El botón Sello, Activar / Desactivar Furia recta o selecciona el Sello que deseas rastrear."
L["SEALBTN"] = "Botón de sellado"
L["SEALBTN_DESC"] = "[Activar / Desactivar] El botón Aura"
L["SEALTRACKER"] = "Rastreador de Sellos"
L["SEALTRACKER_DESC"] = "Seleccione el sello que desea rastrear"
L["SETTINGS"] = "Configuración"
L["SETTINGS_DESC"] = "Cambiar la configuración global"
L["SETTINGSBUFF"] = "Qué mejorar con PallyPower"
L["SHOWMINIMAPICON"] = "Mostrar icono de minimapa"
L["SHOWMINIMAPICON_DESC"] = "[Mostrar / Ocultar] icono de minimapa"
L["SHOWPETS"] = "Mostrar mascotas"
L["SHOWPETS_DESC"] = [=[Si habilita esta opción, las mascotas aparecerán en su propia clase.

|cffffff00Nota: Debido a la forma en que funcionan las Bendiciones Mayores y la forma en que se clasifican las mascotas, las mascotas deberán ser pulidas por separado. Además, los Imp Warlock se ocultarán automáticamente a menos que el Cambio de fase esté desactivado. |r]=]
L["SHOWTIPS"] = "Mostrar información sobre herramientas"
L["SHOWTIPS_DESC"] = "[Mostrar / Ocultar] La información sobre herramientas de PallyPower"
L["SKIN"] = "Texturas de fondo"
L["SKIN_DESC"] = "Cambiar las texturas de fondo del botón"
L["SMARTBUFF"] = "Smart Buffs"
L["SMARTBUFF_DESC"] = "Si habilita esta opción, no se le permitirá asignar Bendición de Sabiduría a Guerreros o Pícaros y Bendición de Poder a Magos, Brujos y Cazadores."
L["USEPARTY"] = "Uso en grupo"
L["USEPARTY_DESC"] = "[Activar / Desactivar] PallyPower en grupo"
L["USESOLO"] = "Usar cuando solo"
L["USESOLO_DESC"] = "[Activar / Desactivar] PallyPower mientras está Solo"
L["VERDOWNLEFT"] = "Vertical hacia abajo | Izquierda"
L["VERDOWNRIGHT"] = "Vertical hacia abajo | Derecha"
L["VERUPLEFT"] = "Vertical arriba | izquierda"
L["VERUPRIGHT"] = "Vertical Arriba | Derecha"
L["WAIT"] = "Esperar jugadores"
L["WAIT_DESC"] = "Si esta opción está habilitada, el botón Auto Buff y los botones Class Buff no mejorarán automáticamente una Bendición Mayor si los destinatarios no están dentro del rango de Paladins (100yds). Esta verificación de rango excluye Ausente, muerto y jugadores sin conexión."

