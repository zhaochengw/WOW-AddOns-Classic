local _, MySlot = ...

local L = setmetatable({}, {
    __index = function(table, key)
        if key then
            table[key] = tostring(key)
        end
        return tostring(key)
    end,
})


MySlot.L = L

--
-- Use http://www.wowace.com/addons/myslot/localization/ to translate thanks
-- 
local locale = GetLocale()

if locale == 'enUs' then
L["[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"] = true
L["[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"] = true
L["[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"] = true
L["All slots were restored"] = true
L["Are you SURE to delete '%s'?"] = true
L["Are you SURE to import ?"] = true
L["Bad importing text [CRC32]"] = true
L["Bad importing text [TEXT]"] = true
L["Clear Action before applying"] = true
L["Clear Binding before applying"] = true
L["Clear Macro before applying"] = true
L["Close"] = true
L["DANGEROUS"] = true
L["Export"] = true
L["Feedback"] = true
L["Force Import"] = true
L["Ignore Import/Export Action"] = true
L["Ignore Import/Export Key Binding"] = true
L["Ignore Import/Export Macro"] = true
L["Ignore unattained pet[id=%s], %s"] = true
L["Ignore unlearned skill [id=%s], %s"] = true
L["Import"] = true
L["Import is not allowed when you are in combat"] = true
L["Importing text [ver:%s] is not compatible with current version"] = true
L["Macro %s was ignored, check if there is enough space to create"] = true
L["Minimap Icon"] = true
L["Myslot"] = true
L["Name of exported text"] = true
L["Open Myslot"] = true
L["Please type %s to confirm"] = true
L["Remove all Key Bindings"] = true
L["Remove all Macros"] = true
L["Remove everything in ActionBar"] = true
L["Rename"] = true
L["Skip bad CRC32"] = true
L["Skip CRC32, version and any other validation before importing. May cause unknown behavior"] = true
L["Skip unsupported version"] = true
L["Time"] = true
L["TOC_NOTES"] = "Myslot is for transferring settings between accounts. Feedback farmer1992@gmail.com"
L["Try force importing"] = true
L["Unsaved"] = true
L["Use random mount instead of an unattained mount"] = true

elseif locale == 'deDE' then
--[[Translation missing --]]
--[[ L["[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"] = "[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["All slots were restored"] = "All slots were restored"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to delete '%s'?"] = "Are you SURE to delete '%s'?"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to import ?"] = "Are you SURE to import ?"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [CRC32]"] = "Bad importing text [CRC32]"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [TEXT]"] = "Bad importing text [TEXT]"--]] 
--[[Translation missing --]]
--[[ L["Clear Action before applying"] = "Clear Action before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Binding before applying"] = "Clear Binding before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Macro before applying"] = "Clear Macro before applying"--]] 
--[[Translation missing --]]
--[[ L["Close"] = "Close"--]] 
--[[Translation missing --]]
--[[ L["DANGEROUS"] = "DANGEROUS"--]] 
--[[Translation missing --]]
--[[ L["Export"] = "Export"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Force Import"] = "Force Import"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Action"] = "Ignore Import/Export Action"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Key Binding"] = "Ignore Import/Export Key Binding"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Macro"] = "Ignore Import/Export Macro"--]] 
--[[Translation missing --]]
--[[ L["Ignore unattained pet[id=%s], %s"] = "Ignore unattained pet[id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Ignore unlearned skill [id=%s], %s"] = "Ignore unlearned skill [id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Import"] = "Import"--]] 
--[[Translation missing --]]
--[[ L["Import is not allowed when you are in combat"] = "Import is not allowed when you are in combat"--]] 
--[[Translation missing --]]
--[[ L["Importing text [ver:%s] is not compatible with current version"] = "Importing text [ver:%s] is not compatible with current version"--]] 
--[[Translation missing --]]
--[[ L["Macro %s was ignored, check if there is enough space to create"] = "Macro %s was ignored, check if there is enough space to create"--]] 
--[[Translation missing --]]
--[[ L["Minimap Icon"] = "Minimap Icon"--]] 
--[[Translation missing --]]
--[[ L["Myslot"] = "Myslot"--]] 
--[[Translation missing --]]
--[[ L["Name of exported text"] = "Name of exported text"--]] 
--[[Translation missing --]]
--[[ L["Open Myslot"] = "Open Myslot"--]] 
--[[Translation missing --]]
--[[ L["Please type %s to confirm"] = "Please type %s to confirm"--]] 
--[[Translation missing --]]
--[[ L["Remove all Key Bindings"] = "Remove all Key Bindings"--]] 
--[[Translation missing --]]
--[[ L["Remove all Macros"] = "Remove all Macros"--]] 
--[[Translation missing --]]
--[[ L["Remove everything in ActionBar"] = "Remove everything in ActionBar"--]] 
--[[Translation missing --]]
--[[ L["Rename"] = "Rename"--]] 
--[[Translation missing --]]
--[[ L["Skip bad CRC32"] = "Skip bad CRC32"--]] 
--[[Translation missing --]]
--[[ L["Skip CRC32, version and any other validation before importing. May cause unknown behavior"] = "Skip CRC32, version and any other validation before importing. May cause unknown behavior"--]] 
--[[Translation missing --]]
--[[ L["Skip unsupported version"] = "Skip unsupported version"--]] 
--[[Translation missing --]]
--[[ L["Time"] = "Time"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Myslot is for transferring settings between accounts. Feedback farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Try force importing"] = "Try force importing"--]] 
--[[Translation missing --]]
--[[ L["Unsaved"] = "Unsaved"--]] 
--[[Translation missing --]]
--[[ L["Use random mount instead of an unattained mount"] = "Use random mount instead of an unattained mount"--]] 

elseif locale == 'esES' then
--[[Translation missing --]]
--[[ L["[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"] = "[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"--]] 
L["All slots were restored"] = "Se han restaurado todos los huecos"
--[[Translation missing --]]
--[[ L["Are you SURE to delete '%s'?"] = "Are you SURE to delete '%s'?"--]] 
L["Are you SURE to import ?"] = "??Seguro que quieres importarlo?"
L["Bad importing text [CRC32]"] = "Texto de importaci??n incorrecto [CRC32]"
L["Bad importing text [TEXT]"] = "Texto de importaci??n incorrecto [TEXT]"
--[[Translation missing --]]
--[[ L["Clear Action before applying"] = "Clear Action before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Binding before applying"] = "Clear Binding before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Macro before applying"] = "Clear Macro before applying"--]] 
L["Close"] = "Cerrar"
L["DANGEROUS"] = "PELIGROSO"
L["Export"] = "Exportar"
L["Feedback"] = "Comentarios"
L["Force Import"] = "Importaci??n forzosa"
L["Ignore Import/Export Action"] = "Ignorar las barras de acci??n en la importaci??n/exportaci??n"
L["Ignore Import/Export Key Binding"] = "Ignorar los atajos de teclado en la importaci??n/exportaci??n"
L["Ignore Import/Export Macro"] = "Ignorar las macros en la importaci??n/exportaci??n"
L["Ignore unattained pet[id=%s], %s"] = [=[Ignora la mascota no obtenida [id=%s], %s

]=]
L["Ignore unlearned skill [id=%s], %s"] = "Ignora la facultad no obtenida [id=%s], %s"
L["Import"] = "Importar"
L["Import is not allowed when you are in combat"] = "No se puede importar mientras est??s en combate"
L["Importing text [ver:%s] is not compatible with current version"] = "El texto de importaci??n [ver:%s] no es compatible con la versi??n actual"
L["Macro %s was ignored, check if there is enough space to create"] = "La macro %s se ha ignorado, comprueba si tienes suficiente espacio para crearla"
--[[Translation missing --]]
--[[ L["Minimap Icon"] = "Minimap Icon"--]] 
L["Myslot"] = "Myslot"
L["Name of exported text"] = "Nombre del texto exportado"
L["Open Myslot"] = "Abrir Myslot"
L["Please type %s to confirm"] = "Escribe %s para confirmar"
L["Remove all Key Bindings"] = "Borrar todos los atajos de teclado"
L["Remove all Macros"] = "Borrar todas las macros"
L["Remove everything in ActionBar"] = "Borrar todo sobre las barras de acci??n"
L["Rename"] = "Renombrar"
L["Skip bad CRC32"] = "Se salta CRC32 maligno"
L["Skip CRC32, version and any other validation before importing. May cause unknown behavior"] = "Se salta CRC32, versi??n y cualquier otra validaci??n antes de importar. Puede provocar comportamientos indeseados"
L["Skip unsupported version"] = "Se salta la validaci??n de versi??n no soportada"
L["Time"] = "Hora"
L["TOC_NOTES"] = "Myslot sirve para transferir opciones entre distintas cuentas. Comentarios a farmer1992@gmail.com"
L["Try force importing"] = "Intentar importaci??n forzosa"
L["Unsaved"] = "No est?? guardado"
L["Use random mount instead of an unattained mount"] = "Usa una montura aleatoria en vez de una no disponible"

elseif locale == 'esMX' then
--[[Translation missing --]]
--[[ L["[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"] = "[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["All slots were restored"] = "All slots were restored"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to delete '%s'?"] = "Are you SURE to delete '%s'?"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to import ?"] = "Are you SURE to import ?"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [CRC32]"] = "Bad importing text [CRC32]"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [TEXT]"] = "Bad importing text [TEXT]"--]] 
--[[Translation missing --]]
--[[ L["Clear Action before applying"] = "Clear Action before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Binding before applying"] = "Clear Binding before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Macro before applying"] = "Clear Macro before applying"--]] 
--[[Translation missing --]]
--[[ L["Close"] = "Close"--]] 
--[[Translation missing --]]
--[[ L["DANGEROUS"] = "DANGEROUS"--]] 
--[[Translation missing --]]
--[[ L["Export"] = "Export"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Force Import"] = "Force Import"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Action"] = "Ignore Import/Export Action"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Key Binding"] = "Ignore Import/Export Key Binding"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Macro"] = "Ignore Import/Export Macro"--]] 
--[[Translation missing --]]
--[[ L["Ignore unattained pet[id=%s], %s"] = "Ignore unattained pet[id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Ignore unlearned skill [id=%s], %s"] = "Ignore unlearned skill [id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Import"] = "Import"--]] 
--[[Translation missing --]]
--[[ L["Import is not allowed when you are in combat"] = "Import is not allowed when you are in combat"--]] 
--[[Translation missing --]]
--[[ L["Importing text [ver:%s] is not compatible with current version"] = "Importing text [ver:%s] is not compatible with current version"--]] 
--[[Translation missing --]]
--[[ L["Macro %s was ignored, check if there is enough space to create"] = "Macro %s was ignored, check if there is enough space to create"--]] 
--[[Translation missing --]]
--[[ L["Minimap Icon"] = "Minimap Icon"--]] 
--[[Translation missing --]]
--[[ L["Myslot"] = "Myslot"--]] 
--[[Translation missing --]]
--[[ L["Name of exported text"] = "Name of exported text"--]] 
--[[Translation missing --]]
--[[ L["Open Myslot"] = "Open Myslot"--]] 
--[[Translation missing --]]
--[[ L["Please type %s to confirm"] = "Please type %s to confirm"--]] 
--[[Translation missing --]]
--[[ L["Remove all Key Bindings"] = "Remove all Key Bindings"--]] 
--[[Translation missing --]]
--[[ L["Remove all Macros"] = "Remove all Macros"--]] 
--[[Translation missing --]]
--[[ L["Remove everything in ActionBar"] = "Remove everything in ActionBar"--]] 
--[[Translation missing --]]
--[[ L["Rename"] = "Rename"--]] 
--[[Translation missing --]]
--[[ L["Skip bad CRC32"] = "Skip bad CRC32"--]] 
--[[Translation missing --]]
--[[ L["Skip CRC32, version and any other validation before importing. May cause unknown behavior"] = "Skip CRC32, version and any other validation before importing. May cause unknown behavior"--]] 
--[[Translation missing --]]
--[[ L["Skip unsupported version"] = "Skip unsupported version"--]] 
--[[Translation missing --]]
--[[ L["Time"] = "Time"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Myslot is for transferring settings between accounts. Feedback farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Try force importing"] = "Try force importing"--]] 
--[[Translation missing --]]
--[[ L["Unsaved"] = "Unsaved"--]] 
--[[Translation missing --]]
--[[ L["Use random mount instead of an unattained mount"] = "Use random mount instead of an unattained mount"--]] 

elseif locale == 'frFR' then
--[[Translation missing --]]
--[[ L["[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"] = "[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["All slots were restored"] = "All slots were restored"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to delete '%s'?"] = "Are you SURE to delete '%s'?"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to import ?"] = "Are you SURE to import ?"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [CRC32]"] = "Bad importing text [CRC32]"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [TEXT]"] = "Bad importing text [TEXT]"--]] 
--[[Translation missing --]]
--[[ L["Clear Action before applying"] = "Clear Action before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Binding before applying"] = "Clear Binding before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Macro before applying"] = "Clear Macro before applying"--]] 
--[[Translation missing --]]
--[[ L["Close"] = "Close"--]] 
--[[Translation missing --]]
--[[ L["DANGEROUS"] = "DANGEROUS"--]] 
--[[Translation missing --]]
--[[ L["Export"] = "Export"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Force Import"] = "Force Import"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Action"] = "Ignore Import/Export Action"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Key Binding"] = "Ignore Import/Export Key Binding"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Macro"] = "Ignore Import/Export Macro"--]] 
--[[Translation missing --]]
--[[ L["Ignore unattained pet[id=%s], %s"] = "Ignore unattained pet[id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Ignore unlearned skill [id=%s], %s"] = "Ignore unlearned skill [id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Import"] = "Import"--]] 
--[[Translation missing --]]
--[[ L["Import is not allowed when you are in combat"] = "Import is not allowed when you are in combat"--]] 
--[[Translation missing --]]
--[[ L["Importing text [ver:%s] is not compatible with current version"] = "Importing text [ver:%s] is not compatible with current version"--]] 
--[[Translation missing --]]
--[[ L["Macro %s was ignored, check if there is enough space to create"] = "Macro %s was ignored, check if there is enough space to create"--]] 
--[[Translation missing --]]
--[[ L["Minimap Icon"] = "Minimap Icon"--]] 
--[[Translation missing --]]
--[[ L["Myslot"] = "Myslot"--]] 
--[[Translation missing --]]
--[[ L["Name of exported text"] = "Name of exported text"--]] 
--[[Translation missing --]]
--[[ L["Open Myslot"] = "Open Myslot"--]] 
--[[Translation missing --]]
--[[ L["Please type %s to confirm"] = "Please type %s to confirm"--]] 
--[[Translation missing --]]
--[[ L["Remove all Key Bindings"] = "Remove all Key Bindings"--]] 
--[[Translation missing --]]
--[[ L["Remove all Macros"] = "Remove all Macros"--]] 
--[[Translation missing --]]
--[[ L["Remove everything in ActionBar"] = "Remove everything in ActionBar"--]] 
--[[Translation missing --]]
--[[ L["Rename"] = "Rename"--]] 
--[[Translation missing --]]
--[[ L["Skip bad CRC32"] = "Skip bad CRC32"--]] 
--[[Translation missing --]]
--[[ L["Skip CRC32, version and any other validation before importing. May cause unknown behavior"] = "Skip CRC32, version and any other validation before importing. May cause unknown behavior"--]] 
--[[Translation missing --]]
--[[ L["Skip unsupported version"] = "Skip unsupported version"--]] 
--[[Translation missing --]]
--[[ L["Time"] = "Time"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Myslot is for transferring settings between accounts. Feedback farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Try force importing"] = "Try force importing"--]] 
--[[Translation missing --]]
--[[ L["Unsaved"] = "Unsaved"--]] 
--[[Translation missing --]]
--[[ L["Use random mount instead of an unattained mount"] = "Use random mount instead of an unattained mount"--]] 

elseif locale == 'itIT' then
--[[Translation missing --]]
--[[ L["[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"] = "[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["All slots were restored"] = "All slots were restored"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to delete '%s'?"] = "Are you SURE to delete '%s'?"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to import ?"] = "Are you SURE to import ?"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [CRC32]"] = "Bad importing text [CRC32]"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [TEXT]"] = "Bad importing text [TEXT]"--]] 
--[[Translation missing --]]
--[[ L["Clear Action before applying"] = "Clear Action before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Binding before applying"] = "Clear Binding before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Macro before applying"] = "Clear Macro before applying"--]] 
--[[Translation missing --]]
--[[ L["Close"] = "Close"--]] 
--[[Translation missing --]]
--[[ L["DANGEROUS"] = "DANGEROUS"--]] 
--[[Translation missing --]]
--[[ L["Export"] = "Export"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Force Import"] = "Force Import"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Action"] = "Ignore Import/Export Action"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Key Binding"] = "Ignore Import/Export Key Binding"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Macro"] = "Ignore Import/Export Macro"--]] 
--[[Translation missing --]]
--[[ L["Ignore unattained pet[id=%s], %s"] = "Ignore unattained pet[id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Ignore unlearned skill [id=%s], %s"] = "Ignore unlearned skill [id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Import"] = "Import"--]] 
--[[Translation missing --]]
--[[ L["Import is not allowed when you are in combat"] = "Import is not allowed when you are in combat"--]] 
--[[Translation missing --]]
--[[ L["Importing text [ver:%s] is not compatible with current version"] = "Importing text [ver:%s] is not compatible with current version"--]] 
--[[Translation missing --]]
--[[ L["Macro %s was ignored, check if there is enough space to create"] = "Macro %s was ignored, check if there is enough space to create"--]] 
--[[Translation missing --]]
--[[ L["Minimap Icon"] = "Minimap Icon"--]] 
--[[Translation missing --]]
--[[ L["Myslot"] = "Myslot"--]] 
--[[Translation missing --]]
--[[ L["Name of exported text"] = "Name of exported text"--]] 
--[[Translation missing --]]
--[[ L["Open Myslot"] = "Open Myslot"--]] 
--[[Translation missing --]]
--[[ L["Please type %s to confirm"] = "Please type %s to confirm"--]] 
--[[Translation missing --]]
--[[ L["Remove all Key Bindings"] = "Remove all Key Bindings"--]] 
--[[Translation missing --]]
--[[ L["Remove all Macros"] = "Remove all Macros"--]] 
--[[Translation missing --]]
--[[ L["Remove everything in ActionBar"] = "Remove everything in ActionBar"--]] 
--[[Translation missing --]]
--[[ L["Rename"] = "Rename"--]] 
--[[Translation missing --]]
--[[ L["Skip bad CRC32"] = "Skip bad CRC32"--]] 
--[[Translation missing --]]
--[[ L["Skip CRC32, version and any other validation before importing. May cause unknown behavior"] = "Skip CRC32, version and any other validation before importing. May cause unknown behavior"--]] 
--[[Translation missing --]]
--[[ L["Skip unsupported version"] = "Skip unsupported version"--]] 
--[[Translation missing --]]
--[[ L["Time"] = "Time"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Myslot is for transferring settings between accounts. Feedback farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Try force importing"] = "Try force importing"--]] 
--[[Translation missing --]]
--[[ L["Unsaved"] = "Unsaved"--]] 
--[[Translation missing --]]
--[[ L["Use random mount instead of an unattained mount"] = "Use random mount instead of an unattained mount"--]] 

elseif locale == 'koKR' then
--[[Translation missing --]]
--[[ L["[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"] = "[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["All slots were restored"] = "All slots were restored"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to delete '%s'?"] = "Are you SURE to delete '%s'?"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to import ?"] = "Are you SURE to import ?"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [CRC32]"] = "Bad importing text [CRC32]"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [TEXT]"] = "Bad importing text [TEXT]"--]] 
--[[Translation missing --]]
--[[ L["Clear Action before applying"] = "Clear Action before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Binding before applying"] = "Clear Binding before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Macro before applying"] = "Clear Macro before applying"--]] 
--[[Translation missing --]]
--[[ L["Close"] = "Close"--]] 
--[[Translation missing --]]
--[[ L["DANGEROUS"] = "DANGEROUS"--]] 
--[[Translation missing --]]
--[[ L["Export"] = "Export"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Force Import"] = "Force Import"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Action"] = "Ignore Import/Export Action"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Key Binding"] = "Ignore Import/Export Key Binding"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Macro"] = "Ignore Import/Export Macro"--]] 
--[[Translation missing --]]
--[[ L["Ignore unattained pet[id=%s], %s"] = "Ignore unattained pet[id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Ignore unlearned skill [id=%s], %s"] = "Ignore unlearned skill [id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Import"] = "Import"--]] 
--[[Translation missing --]]
--[[ L["Import is not allowed when you are in combat"] = "Import is not allowed when you are in combat"--]] 
--[[Translation missing --]]
--[[ L["Importing text [ver:%s] is not compatible with current version"] = "Importing text [ver:%s] is not compatible with current version"--]] 
--[[Translation missing --]]
--[[ L["Macro %s was ignored, check if there is enough space to create"] = "Macro %s was ignored, check if there is enough space to create"--]] 
--[[Translation missing --]]
--[[ L["Minimap Icon"] = "Minimap Icon"--]] 
--[[Translation missing --]]
--[[ L["Myslot"] = "Myslot"--]] 
--[[Translation missing --]]
--[[ L["Name of exported text"] = "Name of exported text"--]] 
--[[Translation missing --]]
--[[ L["Open Myslot"] = "Open Myslot"--]] 
--[[Translation missing --]]
--[[ L["Please type %s to confirm"] = "Please type %s to confirm"--]] 
--[[Translation missing --]]
--[[ L["Remove all Key Bindings"] = "Remove all Key Bindings"--]] 
--[[Translation missing --]]
--[[ L["Remove all Macros"] = "Remove all Macros"--]] 
--[[Translation missing --]]
--[[ L["Remove everything in ActionBar"] = "Remove everything in ActionBar"--]] 
--[[Translation missing --]]
--[[ L["Rename"] = "Rename"--]] 
--[[Translation missing --]]
--[[ L["Skip bad CRC32"] = "Skip bad CRC32"--]] 
--[[Translation missing --]]
--[[ L["Skip CRC32, version and any other validation before importing. May cause unknown behavior"] = "Skip CRC32, version and any other validation before importing. May cause unknown behavior"--]] 
--[[Translation missing --]]
--[[ L["Skip unsupported version"] = "Skip unsupported version"--]] 
--[[Translation missing --]]
--[[ L["Time"] = "Time"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Myslot is for transferring settings between accounts. Feedback farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Try force importing"] = "Try force importing"--]] 
--[[Translation missing --]]
--[[ L["Unsaved"] = "Unsaved"--]] 
--[[Translation missing --]]
--[[ L["Use random mount instead of an unattained mount"] = "Use random mount instead of an unattained mount"--]] 

elseif locale == 'ptBR' then
--[[Translation missing --]]
--[[ L["[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"] = "[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["All slots were restored"] = "All slots were restored"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to delete '%s'?"] = "Are you SURE to delete '%s'?"--]] 
--[[Translation missing --]]
--[[ L["Are you SURE to import ?"] = "Are you SURE to import ?"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [CRC32]"] = "Bad importing text [CRC32]"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [TEXT]"] = "Bad importing text [TEXT]"--]] 
--[[Translation missing --]]
--[[ L["Clear Action before applying"] = "Clear Action before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Binding before applying"] = "Clear Binding before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Macro before applying"] = "Clear Macro before applying"--]] 
--[[Translation missing --]]
--[[ L["Close"] = "Close"--]] 
--[[Translation missing --]]
--[[ L["DANGEROUS"] = "DANGEROUS"--]] 
--[[Translation missing --]]
--[[ L["Export"] = "Export"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Force Import"] = "Force Import"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Action"] = "Ignore Import/Export Action"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Key Binding"] = "Ignore Import/Export Key Binding"--]] 
--[[Translation missing --]]
--[[ L["Ignore Import/Export Macro"] = "Ignore Import/Export Macro"--]] 
--[[Translation missing --]]
--[[ L["Ignore unattained pet[id=%s], %s"] = "Ignore unattained pet[id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Ignore unlearned skill [id=%s], %s"] = "Ignore unlearned skill [id=%s], %s"--]] 
--[[Translation missing --]]
--[[ L["Import"] = "Import"--]] 
--[[Translation missing --]]
--[[ L["Import is not allowed when you are in combat"] = "Import is not allowed when you are in combat"--]] 
--[[Translation missing --]]
--[[ L["Importing text [ver:%s] is not compatible with current version"] = "Importing text [ver:%s] is not compatible with current version"--]] 
--[[Translation missing --]]
--[[ L["Macro %s was ignored, check if there is enough space to create"] = "Macro %s was ignored, check if there is enough space to create"--]] 
--[[Translation missing --]]
--[[ L["Minimap Icon"] = "Minimap Icon"--]] 
--[[Translation missing --]]
--[[ L["Myslot"] = "Myslot"--]] 
--[[Translation missing --]]
--[[ L["Name of exported text"] = "Name of exported text"--]] 
--[[Translation missing --]]
--[[ L["Open Myslot"] = "Open Myslot"--]] 
--[[Translation missing --]]
--[[ L["Please type %s to confirm"] = "Please type %s to confirm"--]] 
--[[Translation missing --]]
--[[ L["Remove all Key Bindings"] = "Remove all Key Bindings"--]] 
--[[Translation missing --]]
--[[ L["Remove all Macros"] = "Remove all Macros"--]] 
--[[Translation missing --]]
--[[ L["Remove everything in ActionBar"] = "Remove everything in ActionBar"--]] 
--[[Translation missing --]]
--[[ L["Rename"] = "Rename"--]] 
--[[Translation missing --]]
--[[ L["Skip bad CRC32"] = "Skip bad CRC32"--]] 
--[[Translation missing --]]
--[[ L["Skip CRC32, version and any other validation before importing. May cause unknown behavior"] = "Skip CRC32, version and any other validation before importing. May cause unknown behavior"--]] 
--[[Translation missing --]]
--[[ L["Skip unsupported version"] = "Skip unsupported version"--]] 
--[[Translation missing --]]
--[[ L["Time"] = "Time"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Myslot is for transferring settings between accounts. Feedback farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Try force importing"] = "Try force importing"--]] 
--[[Translation missing --]]
--[[ L["Unsaved"] = "Unsaved"--]] 
--[[Translation missing --]]
--[[ L["Use random mount instead of an unattained mount"] = "Use random mount instead of an unattained mount"--]] 

elseif locale == 'ruRU' then
--[[Translation missing --]]
--[[ L["[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"] = "[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"--]] 
--[[Translation missing --]]
--[[ L["[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"] = "[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"--]] 
L["All slots were restored"] = "?????? ?????????? ??????????????????????????"
L["Are you SURE to delete '%s'?"] = "???? ??????????????, ?????? ???????????? ?????????????? \"%s\"?"
L["Are you SURE to import ?"] = "???? ??????????????, ?????? ???????????? ???????????????????????????"
--[[Translation missing --]]
--[[ L["Bad importing text [CRC32]"] = "Bad importing text [CRC32]"--]] 
--[[Translation missing --]]
--[[ L["Bad importing text [TEXT]"] = "Bad importing text [TEXT]"--]] 
L["Clear Action before applying"] = "???????????????? ???????????? ???????????????? ?????????? ??????????????????????"
L["Clear Binding before applying"] = "???????????????? ???????????????? ???????????? ?????????? ??????????????????????"
L["Clear Macro before applying"] = "???????????????? ?????????????? ?????????? ??????????????????????"
L["Close"] = "??????????????"
L["DANGEROUS"] = "???????????? "
L["Export"] = "??????????????"
L["Feedback"] = "???????????????? ??????????"
L["Force Import"] = "?????????????????????????? ??????????????????????????"
L["Ignore Import/Export Action"] = "???????????????????????? ????????????/?????????????? ???????????? ????????????????"
L["Ignore Import/Export Key Binding"] = "???????????????????????? ????????????/?????????????? ???????????????? ????????????"
L["Ignore Import/Export Macro"] = "???????????????????????? ????????????/?????????????? ????????????????"
--[[Translation missing --]]
--[[ L["Ignore unattained pet[id=%s], %s"] = "Ignore unattained pet[id=%s], %s"--]] 
L["Ignore unlearned skill [id=%s], %s"] = "???????????????????????? ?????????????????????? ???????????? [id=%s], %s"
L["Import"] = "????????????"
--[[Translation missing --]]
--[[ L["Import is not allowed when you are in combat"] = "Import is not allowed when you are in combat"--]] 
--[[Translation missing --]]
--[[ L["Importing text [ver:%s] is not compatible with current version"] = "Importing text [ver:%s] is not compatible with current version"--]] 
--[[Translation missing --]]
--[[ L["Macro %s was ignored, check if there is enough space to create"] = "Macro %s was ignored, check if there is enough space to create"--]] 
L["Minimap Icon"] = "???????????? ?? ????????-??????????"
--[[Translation missing --]]
--[[ L["Myslot"] = "Myslot"--]] 
--[[Translation missing --]]
--[[ L["Name of exported text"] = "Name of exported text"--]] 
L["Open Myslot"] = "?????????????? Myslot"
--[[Translation missing --]]
--[[ L["Please type %s to confirm"] = "Please type %s to confirm"--]] 
L["Remove all Key Bindings"] = "?????????????? ?????? ???????????????? ????????????"
L["Remove all Macros"] = "?????????????? ?????? ??????????????"
L["Remove everything in ActionBar"] = "?????????????? ?????? ?? ???????????? ????????????????"
L["Rename"] = "??????????????????????????"
--[[Translation missing --]]
--[[ L["Skip bad CRC32"] = "Skip bad CRC32"--]] 
--[[Translation missing --]]
--[[ L["Skip CRC32, version and any other validation before importing. May cause unknown behavior"] = "Skip CRC32, version and any other validation before importing. May cause unknown behavior"--]] 
L["Skip unsupported version"] = "???????????????????? ???????????????????????????????? ????????????"
L["Time"] = "??????????"
L["TOC_NOTES"] = "Myslot ???????????????????????? ?????? ???????????????? ???????????????? ?????????? ????????????????????. ???????????????? ?????????? farmer1992@gmail.com"
--[[Translation missing --]]
--[[ L["Try force importing"] = "Try force importing"--]] 
L["Unsaved"] = "???? ??????????????????"
--[[Translation missing --]]
--[[ L["Use random mount instead of an unattained mount"] = "Use random mount instead of an unattained mount"--]] 

elseif locale == 'zhCN' then
L["[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"] = "[WARN] ?????????????????? DEBUG INFO = [S=%s T=%s I=%s] ???????????????????????? DEBUG INFO ???????????? %s"
L["[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"] = "[WARN] ?????????????????????????????? [ %s ]?????????????????? %s"
L["[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"] = "[WARN] ?????????????????????????????? [ %s ]?????????????????? %s"
L["All slots were restored"] = "?????????????????????????????????????????????"
L["Are you SURE to delete '%s'?"] = "??????????????? '%s'"
L["Are you SURE to import ?"] = "??????????????????????"
L["Bad importing text [CRC32]"] = "??????????????????????????? [CRC32] ???????????????????????????"
L["Bad importing text [TEXT]"] = "??????????????????????????? [TEXT]"
L["Clear Action before applying"] = "???????????????????????????"
L["Clear Binding before applying"] = "????????????????????????"
L["Clear Macro before applying"] = "??????????????????"
L["Close"] = "??????"
L["DANGEROUS"] = "????????????"
L["Export"] = "??????"
L["Feedback"] = "??????/??????"
L["Force Import"] = "????????????"
L["Ignore Import/Export Action"] = "??????/???????????????????????????"
L["Ignore Import/Export Key Binding"] = "??????/????????????????????????"
L["Ignore Import/Export Macro"] = "??????/??????????????????"
L["Ignore unattained pet[id=%s], %s"] = "??????????????????????????????[id=%s]???%s"
L["Ignore unlearned skill [id=%s], %s"] = "?????????????????????[id=%s]???%s"
L["Import"] = "??????"
L["Import is not allowed when you are in combat"] = "???????????????????????????????????????"
L["Importing text [ver:%s] is not compatible with current version"] = "???????????? [ver:%s] ?????????????????????"
L["Macro %s was ignored, check if there is enough space to create"] = "??? [ %s ] ??????????????????????????????????????????????????????"
L["Minimap Icon"] = "???????????????"
L["Myslot"] = "Myslot"
L["Name of exported text"] = "?????????????????????"
L["Open Myslot"] = "?????? Myslot"
L["Please type %s to confirm"] = "????????? %s ???????????????"
L["Remove all Key Bindings"] = "?????????????????????"
L["Remove all Macros"] = "???????????????"
L["Remove everything in ActionBar"] = "????????????????????????"
L["Rename"] = "?????????"
L["Skip bad CRC32"] = "??????CRC32??????"
L["Skip CRC32, version and any other validation before importing. May cause unknown behavior"] = "??????CRC32?????????????????????????????????????????????"
L["Skip unsupported version"] = "????????????????????????"
L["Time"] = "??????"
L["TOC_NOTES"] = "Myslot??????????????????????????????????????????????????????farmer1992@gmail.com"
L["Try force importing"] = "??????????????????"
L["Unsaved"] = "?????????"
L["Use random mount instead of an unattained mount"] = "?????????????????????????????????????????????"

elseif locale == 'zhTW' then
L["[WARN] Ignore slot due to an unknown error DEBUG INFO = [S=%s T=%s I=%s] Please send Importing Text and DEBUG INFO to %s"] = "[WARN] ????????????????????????DEBUG INFO = [S=%s T=%s I=%s] ????????????????????????DEBUG INFO???????????? %s???"
L["[WARN] Ignore unsupported Key Binding [ %s ] , contact %s please"] = "[WARN] ?????????????????????????????????K = [ %s ] ?????????????????? %s"
L["[WARN] Ignore unsupported Slot Type [ %s ] , contact %s please"] = "[WARN] ?????????????????????????????????K = [ %s ] ?????????????????? %s"
L["All slots were restored"] = "????????????????????????????????????"
--[[Translation missing --]]
--[[ L["Are you SURE to delete '%s'?"] = "Are you SURE to delete '%s'?"--]] 
L["Are you SURE to import ?"] = "??????????????????????"
L["Bad importing text [CRC32]"] = "?????????????????????[CRC32]"
L["Bad importing text [TEXT]"] = "?????????????????????[TEXT]"
--[[Translation missing --]]
--[[ L["Clear Action before applying"] = "Clear Action before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Binding before applying"] = "Clear Binding before applying"--]] 
--[[Translation missing --]]
--[[ L["Clear Macro before applying"] = "Clear Macro before applying"--]] 
L["Close"] = "??????"
L["DANGEROUS"] = "??????"
L["Export"] = "??????"
L["Feedback"] = "??????"
L["Force Import"] = "????????????"
L["Ignore Import/Export Action"] = "????????????/????????????"
L["Ignore Import/Export Key Binding"] = "????????????/??????????????????"
L["Ignore Import/Export Macro"] = "????????????/????????????"
L["Ignore unattained pet[id=%s], %s"] = "????????????????????? [id=%s]???%s"
L["Ignore unlearned skill [id=%s], %s"] = "????????????????????? [id=%s], %s"
L["Import"] = "??????"
L["Import is not allowed when you are in combat"] = "??????????????????????????????????????????"
L["Importing text [ver:%s] is not compatible with current version"] = "????????????????????????????????????????????????(??????????????????%s)"
L["Macro %s was ignored, check if there is enough space to create"] = "???????????? [%s] ???????????????????????????????????????????????????"
--[[Translation missing --]]
--[[ L["Minimap Icon"] = "Minimap Icon"--]] 
L["Myslot"] = "Myslot "
L["Name of exported text"] = "???????????????"
L["Open Myslot"] = "??????Myslot"
L["Please type %s to confirm"] = "????????? %s ???????????????"
L["Remove all Key Bindings"] = "????????????????????????"
L["Remove all Macros"] = "??????????????????"
L["Remove everything in ActionBar"] = "?????????????????????"
L["Rename"] = "????????????"
L["Skip bad CRC32"] = "??????CRC32??????"
L["Skip CRC32, version and any other validation before importing. May cause unknown behavior"] = "??????????????????CRC32, ???????????????. ?????????????????????????????????"
L["Skip unsupported version"] = "????????????????????????"
L["Time"] = "??????"
L["TOC_NOTES"] = "Myslot????????????????????????????????????????????????????????????farmer1992@gmail.com"
L["Try force importing"] = "??????????????????"
L["Unsaved"] = "?????????"
L["Use random mount instead of an unattained mount"] = "?????????????????????????????????????????????"

end

