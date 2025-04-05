-- SCT localization information
-- Spanish Locale
-- Translation by JSR1976 / fixed and updated by shiftos

if GetLocale() ~= "esES" then return end

-- Static Messages
SCT.LOCALS.LowHP= "\194\161Salud Baja!";					-- Message to be displayed when HP is low
SCT.LOCALS.LowMana= "\194\161Man\195\161 Bajo!";					-- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*";								-- Icon to show self hits
SCT.LOCALS.Crushchar = "^";
SCT.LOCALS.Glancechar = "~";
SCT.LOCALS.Combat = "+Combate";						-- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "-Combate";					-- Message to be displayed when leaving combat
SCT.LOCALS.ComboPoint = "PdC";			  		-- Message to be displayed when gaining a combo point
SCT.LOCALS.CPMaxMessage = "\194\161M\195\161talo!"; -- Message to be displayed when you have max combo points
SCT.LOCALS.ExtraAttack = "\194\161Ataque Extra!"; -- Message to be displayed when time to execute
SCT.LOCALS.KillingBlow = "\194\161Golpe Mortal!"; -- Message to be displayed when you kill something
SCT.LOCALS.Interrupted = "\194\161Interrumpido!"; -- Message to be displayed when you are interrupted
SCT.LOCALS.Rampage = "Rampage"; -- Message to be displayed when rampage is needed

--Option messages
SCT.LOCALS.STARTUP = "Scrolling Combat Text "..SCT.Version.." Accesorio cargado. Escribe /sct para opciones.";
SCT.LOCALS.Option_Crit_Tip = "Hace aparecer este evento siempre como CR\195\141TICO.";
SCT.LOCALS.Option_Msg_Tip = "Hace aparecer este evento como un MENSAJE. Invalida Cr\195\173ticos.";
SCT.LOCALS.Frame1_Tip = "Hace aparecer este evento siempre en MARCO DE ANIMACI\195\147N 1";
SCT.LOCALS.Frame2_Tip = "Hace aparecer este evento siempre en MARCO DE ANIMACI\195\147N 2";

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00SCT AVISO|r\n\nTus variables guardadas son de una versi\195\179n anticuada de SCT. Si encuentras errores o un comportamiento extra\195\177o, por favor REESTABLECE tus opciones usando el bot\195\179n de reestablecer o escribiendo /sctreset";
SCT.LOCALS.Load_Error = "|cff00ff00Error al Cargar las SCT Options. Puede que est\195\169 desactivado.|r";

--nouns
SCT.LOCALS.TARGET = "Objetivo ";
SCT.LOCALS.PROFILE = "Perfil de SCT Cargado: |cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "Perfil de SCT Borrado: |cff00ff00";
SCT.LOCALS.PROFILE_NEW = "Nuevo Perfil de SCT Creado: |cff00ff00";
SCT.LOCALS.WARRIOR = "Guerrero";
SCT.LOCALS.ROGUE = "P\195\173caro";
SCT.LOCALS.HUNTER = "Cazador";
SCT.LOCALS.MAGE = "Mago";
SCT.LOCALS.WARLOCK = "Brujo";
SCT.LOCALS.DRUID = "Druida";
SCT.LOCALS.PRIEST = "Sacerdote";
SCT.LOCALS.SHAMAN = "Cham\195\161n";
SCT.LOCALS.PALADIN = "Palad\195\173n";

--Useage
SCT.LOCALS.DISPLAY_USEAGE = "Uso: \n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'mensaje' (para el texto en blanco)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'mensaje' rojo(0-10) verde(0-10) azul(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Ejemplo: /sctdisplay 'C\195\186rame' 10 0 0\nEsto mostrar\195\161 'C\195\186rame' en rojo brillante\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Algunos Colores: rojo = 10 0 0, verde = 0 10 0, blue = 0 0 10,\namarillo = 10 10 0, magenta = 10 0 10, ci\195\161n = 0 10 10";

--Fonts
SCT.LOCALS.FONTS = { 
	[1] = { name="Friz Quadrata TT", path="Fonts\\FRIZQT__.TTF"},
	[2] = { name="SCT TwCenMT", path="Interface\\Addons\\sct\\fonts\\Tw_Cen_MT_Bold.TTF"},
	[3] = { name="SCT Adventure", path="Interface\\Addons\\sct\\fonts\\Adventure.ttf"},
	[4] = { name="SCT Enigma", path="Interface\\Addons\\sct\\fonts\\Enigma__2.TTF"},
	[5] = { name="SCT Emblem", path="Interface\\Addons\\sct\\fonts\\Emblem.ttf"},
	[6] = { name="SCT Diablo", path="Interface\\Addons\\sct\\fonts\\Avqest.ttf"},
}

-- Cosmos button
SCT.LOCALS.CB_NAME			= "Scrolling Combat Text".." "..SCT.Version;
SCT.LOCALS.CB_SHORT_DESC	= "por Grayhoof";
SCT.LOCALS.CB_LONG_DESC	= "Hace aparecer en pantalla \195\186tiles mensajes sobre tu cabeza - \194\161pru\195\169balo!";
SCT.LOCALS.CB_ICON			= "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"
