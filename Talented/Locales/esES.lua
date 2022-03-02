local L =  LibStub:GetLibrary("AceLocale-3.0"):NewLocale("Talented", "esES", false) or LibStub:GetLibrary("AceLocale-3.0"):NewLocale("Talented", "esMX", false)
if not L then return end

L["Talented - Talent Editor"] = "Talented - Editor de talentos"

L["Layout options"] = "Opciones de aspecto"
L["Icon offset"] = "Separación de iconos"
L["Distance between icons."] = "Distancia entre iconos."
L["Frame scale"] = "Escala de la ventana"
L["Overall scale of the Talented frame."] = "Escala total de la ventana de Talented."

L["Options"] = "Opciones"
L["General Options for Talented."] = "Opciones generales de Talented."
L["Always edit"] = "Editar siempre"
L["Always allow templates and the current build to be modified, instead of having to Unlock them first."] = "Permite que las plantillas y la build actual sean modificados directamente, en vez de tener que desbloquearlos primero."
L["Confirm Learning"] = "Confirmar aprendizaje"
L["Ask for user confirmation before learning any talent."] = "Pide confirmación al usuario antes de aprender algún talento."
L["Always try to learn talent"] = "Siempre intenta aprender talento"
L["Always call the underlying API when a user input is made, even when no talent should be learned from it."] = "Siempre llama al API subllacente con las acciones del usuario, incluso cuando no conlleve el aprendizaje de un talento."
L["Talent cap"] = "Límite de talentos"
L["Restrict templates to a maximum of %d points."] = "Restringe las plantillas a un máximo de %d puntos."
L["Level restriction"] = "Restricción de nivel"
L["Show the required level for the template, instead of the number of points."] = "Muestra el nivel requerido por la plantilla, en vez del número de puntos."
L["Load outdated data"] = true
L["Load Talented_Data, even if outdated."] = true
L["Hook Inspect UI"] = "Enlazar el interfaz de inspección"
L["Hook the Talent Inspection UI."] = "Enlaza el interfaz de inspección de talentos."
L["Output URL in Chat"] = "Muestra enlaces en el chat"
L["Directly outputs the URL in Chat instead of using a Dialog."] = "Muestra los enlaces directamente en el chat, en vez de usar una ventana."

L["Inspected Characters"] = "Personajes inspeccionados"
L["Edit template"] = "Editar plantilla"
L["Edit talents"] = "Editar talentos"
L["Toggle edition of the template."] = "Activa/desactiva la edición de la plantilla."
L["Toggle editing of talents."] = "Activa/desactiva la edición de talentos."

L["Templates"] = "Plantillas"
L["Actions"] = "Acciones"
L["You can edit the name of the template here. You must press the Enter key to save your changes."] = "Puedes editar el nombre de las plantillas aquí. Debes pulsar la tecla Enter para grabar los cambios."

L["Remove all talent points from this tree."] = "Elimina todos los puntos de talentos de este árbol."
L["%s (%d)"] = "%s (%d)"
L["Level %d"] = "Nivel %d"
L["%d/%d"] = "%d/%d"
--~ L["Right-click to unlearn"] = "Botón-dcho para desaprender"
L["Effective tooltip information not available"] = "No hay disponible tooltip con información útil"
L["You have %d talent |4point:points; left"] = "Tienes %d |4punto:puntos; de talento restantes"
L["Are you sure that you want to learn \"%s (%d/%d)\" ?"] = "¿ Seguro que quieres aprender \"%s (%d/%d)\" ?"

L["View the Current spec in the Talented frame."] = "Muestra la build actual en la ventana de Talented."
L["Switch to this Spec"] = "Cambiar a esta build"
L["View Pet Spec"] = "Mostrar la build de la mascota"

L["New Template"] = "Nueva plantilla"
L["Empty"] = "Vacío"

L["Apply template"] = "Aplicar plantilla"
L["Copy template"] = "Copiar plantilla"
L["Delete template"] = "Borrar plantilla"
L["Set as target"] = "Establece como objetivo"
L["Clear target"] = "Limpiar objetivo"

L["Sorry, I can't apply this template because you don't have enough talent points available (need %d)!"] = "¡ Lo siento, no puedo aplicar esta plantilla porque no tienes suficientes puntos de talento disponibles (hacen falta %s) !"
L["Sorry, I can't apply this template because it doesn't match your pet's class!"] = "¡ Lo siento, no puedo aplicar esta plantilla porque no coincide con la clase de tu mascota !"
L["Sorry, I can't apply this template because it doesn't match your class!"] = "¡ Lo siento, no puedo aplicar esta plantilla porque no coincide con tu clase !"
L["Nothing to do"] = "Nada que hacer"
L["Talented cannot perform the required action because it does not have the required talent data available for class %s."] = true
L["You must install the Talented_Data helper addon for this action to work."] = true
L["You must enable the Talented_Data helper addon for this action to work."] = true
L["If Talented_Data is out of date, you must update or you can allow it to load outdated data in the settings."] = true

L["Inspection of %s"] = "Inspección de %s"
L["Select %s"] = "Selecciona %s"
L["Copy of %s"] = "Copia de %s"
L["Target: %s"] = "Objetivo: %s"
L["Imported"] = "Importado"

L["Please wait while I set your talents..."] = "Por favor, espera mientras establezco tus talentos..."
L["The given template is not a valid one!"] = "¡ La plantilla especificada no es válida !"
L["Error while applying talents! Not enough talent points!"] = "¡ Error al aplicar talentos ! ¡ No hay suficientes puntos de talento !"
L["Error while applying talents! some of the request talents were not set!"] = "¡ Error al aplicar talentos ! ¡ Alguno de los talentos solicitados no se han establecido !"
L["Error! Talented window has been closed during template application. Please reapply later."] = "¡ Error ! La ventana de talentos se ha cerrado durante el establecimiento de una plantilla. Por favor, aplícala otra vez."
L["Talent application has been cancelled. %d talent points remaining."] = "El establecimiento de talemtos ha sido cancelado. Quedan %d puntos de talento"
L["Template applied successfully, %d talent points remaining."] = "Plantilla aplicada exitosamente. Quedan %d puntos de talento"
L["\"%s\" does not appear to be a valid URL!"] = "¡ \"%s\" no parece ser una URL válida !"
L["Warning - no action was taken, or we ran out of talent points."] = true --TODO: Localise!
L["Talented_Data is outdated. It was created for %q, but current build is %q. Please update."] = true
L["Loading outdated data. |cffff1010WARNING:|r Recent changes in talent trees might not be included in this data."] = true

L["Import template ..."] = "Importar plantilla..."
L["Enter the complete URL of a template from Blizzard talent calculator or wowhead."] = "Introduce la URL completa de una plantilla del calculador de talentos de Blizzard o WoWHead."

L["Export template"] = "Exportar plantilla"
L["Blizzard Talent Calculator"] = "Calculador de talentos de Blizzard"
L["Wowhead Talent Calculator"] = "Calculador de talentos de WoWHead"
L["Wowdb Talent Calculator"] = "Calculador de talentos de WoWDB"
L["MMO Champion Talent Calculator"] = "Calculador de talentos de MMO Champion"
L["http://www.wowarmory.com/talent-calc.xml?%s=%s&tal=%s"] = "http://eu.wowarmory.com/talent-calc.xml?%s=%s&tal=%s"
L["http://www.wowhead.com/talent-calc/%s/%s"] = "http://es.wowhead.com/talent-calc/%s/%s"
L["http://www.wowhead.com/petcalc#%s"] = "http://es.wowhead.com/petcalc#%s"
L["http://tbc.wowhead.com/talent-calc/%s/%s"] = "http://es.tbc.wowhead.com/talent-calc/%s/%s"
L["http://tbc.wowhead.com/petcalc#%s"] = "http://es.tbc.wowhead.com/petcalc#%s"
L["http://classic.wowhead.com/talent-calc/%s/%s"] = "http://es.classic.wowhead.com/talent-calc/%s/%s"
L["http://classic.wowhead.com/petcalc#%s"] = "http://es.classic.wowhead.com/petcalc#%s"
L["Send to ..."] = "Enviar a ..."
L["Enter the name of the character you want to send the template to."] = "Introduce el nombre del personaje al que quieres enviar la plantilla."
L["Do you want to add the template \"%s\" that %s sent you ?"] = "¿ Quieres añadir la plantilla \"%s\" que %s te ha enviado ?"

L["Options ..."] = "Opciones..."
L["Talented has detected an incompatible change in the talent information that requires an update to Talented. Talented will now Disable itself and reload the user interface so that you can use the default interface."] = "Talented ha detectado un cambio incompatible en la información de talentos que requiere una actualización de Talented. Talented se desactivará y cargará de nuevo la interfaz de usuario para que puedas usar el interfaz por defecto."
L["WARNING: Talented has detected that its talent data is outdated. Talented will work fine for your class for this session but may have issue with other classes. You should update Talented if you can."] = "CUIDADO: Talented ha detectado que sus datos de talentos están obsoletos. Talented funcionará bien para tu clase durante esta sesión, pero puedes tener problemas con otras clases. Deberías actualizar Talented si puedes."
L["View glyphs of alternate Spec"] = "Ver glifos de la build alternaitva"
L[" (alt)"] = true
L["The following templates are no longer valid and have been removed:"] = "Las siguientes plantillas ya no son válidas y han sido eliminadas:"
L["The following templates were converted from a previous version of the addon. Ensure that none are 'invalid' (below); retrieve the backup of your config file from the WTF folder if so."] = true


L["Lock frame"] = "Bloquear ventana"
L["Can not apply, unknown template \"%s\""] = "No es posible aplicar, plantilla desconocida: \"%s\""

L["Glyph frame policy on spec swap"] = "Política para la ventana de glifos al cambiar de build"
L["Select the way the glyph frame handle spec swaps."] = "Seleciona el modo en que la ventana de glifos gestiona el cambio de builds."
L["Keep the shown spec"] = "Mantener la build mostrada"
L["Swap the shown spec"] = "Cambiar la build mostrada"
L["Always show the active spec after a change"] = "Siempre muestra la build activa tras un cambio"

L["General options"] = "Opciones generales"
L["Glyph frame options"] = "Opciones de la ventana de glifos"
L["Display options"] = "Opciones de visualización"
L["Add bottom offset"] = "Añadir espaciado inferior"
L["Add some space below the talents to show the bottom information."] = "Añade algo de espacio bajo los talentos para mostrar la información inferior."
