local L = LibStub("AceLocale-3.0"):NewLocale("CopyAnything", "esES") or LibStub("AceLocale-3.0"):NewLocale("CopyAnything", "esMX")
if not L then return end

L["copyAnything"] = "Copia Cualquier Cosa"
--[[Translation missing --]]
--[[ L["copyFrame"] = "Copy Frame"--]] 
--[[Translation missing --]]
--[[ L["fastCopy"] = "Fast Copy"--]] 
--[[Translation missing --]]
--[[ L["fastCopyDesc"] = "Automatically hide the copy frame after CTRL+C is pressed."--]] 
L["fontStrings"] = "FontStrings"
L["general"] = "General"
L["invalidSearchType"] = "Tipo de búsqueda inválido '%s'. Revisa opciones."
L["mouseFocus"] = "Foco de Ratón"
L["noTextFound"] = "No texto encontrado."
L["parentFrames"] = "Cercos Matrizes"
L["profiles"] = "Perfiles"
L["searchType"] = "Tipo de Búsqueda"
L["searchTypeDesc"] = "Método que usa para buscar texto debajo del cursor."
L["searchTypeDescExtended"] = [=[FontStrings (Valor por Defecto) - Busca FontStrings individuales debajo del cursor.
Cercos Matrizes - Busca cercos más altos debajo del cursor, y copia todo el texto de sus hijos.
Foco de Ratón - Copia texto del cerco del foco del ratón. Solo trabaja en cercos que están registrado por eventos del ratón.]=]
L["show"] = "Mostra"
L["tooManyFontStrings"] = "Más que %d FontStrings estuvieron encontrado. La copia estuvo cancelado para prevenir el juego de colgarse por demasiado tiempo."

