if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then
	return
end
local L

--------------------------
-- La guardia de piedra --
--------------------------
L = DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "¡%s en breve!", -- prepare survival ablility or move boss. need more specific message.
	specWarnBreakJasperChains	= "¡Rompe las cadenas de jaspe!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "Mostrar aviso especial antes de Sobrecarga", -- need to change this, i can not translate this with good grammer. please help.
	specWarnBreakJasperChains	= "Mostrar aviso especial cuando sea seguro romper $spell:130395",
	InfoFrame					= "Mostrar marco de información con la energía de los jefes, petrificación de los jugadores y qué jefe está lanzando la petrificación"
})

L:SetMiscLocalization({
	Overload	= "¡%s se empieza a sobrecargar!"
})

------------------------
-- Feng el Detestable --
------------------------
L = DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase			= "Fase %d",
	specWarnBarrierNow	= "¡Usa Barrera anuladora ahora!"
})

L:SetOptionLocalization({
	WarnPhase			= "Anunciar cambios de fase",
	specWarnBarrierNow	= "Mostrar aviso especial cuando debas usar $spell:115817 (buscador de bandas)",
	RangeFrame	= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("6") .. " durante la fase Arcana",
	SetIconOnWS	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(116784),
	SetIconOnAR	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(116417)
})

L:SetMiscLocalization({
	Fire	= "¡Oh, exaltado! ¡Soy tu herramienta para desgarrar la carne de los huesos!",
	Arcane	= "¡Oh, sabio eterno! ¡Transmíteme tu sapiencia Arcana!",
	Nature	= "¡Oh, gran espíritu! ¡Otórgame el poder de la tierra!",--I did not log this one, text is probably not right
	Shadow	= "¡Almas de campeones antiguos! ¡Concededme vuestro escudo!"
})

--------------
-- Gara'jal --
--------------
L = DBM:GetModLocalization(682)

L:SetOptionLocalization({
	SetIconOnVoodoo	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(122151)
})

L:SetMiscLocalization({
	Pull	= "¡Ya es hora de morir!"
})

------------------------
-- Los Reyes Espíritu --
------------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon	= "Escudo de la oscuridad en %d s"
})

L:SetTimerLocalization({
	timerUSRevive		= "Sombra imperecedera se reforma",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon		= "Mostrar aviso previo con cuenta atrás de 5 s para $spell:117697",
	timerUSRevive		= "Mostrar temporizador para cuando $spell:117506 se reforme",
	timerRainOfArrowsCD = DBM_CORE_L.AUTO_TIMER_OPTIONS.cd:format(118122),
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("8")
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "¡La plataforma desaparecerá en 6 s!"
})

L:SetTimerLocalization({
	timerDespawnFloor	= "La plataforma desaparece"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "Mostrar aviso especial antes de que desaparezca la plataforma",
	timerDespawnFloor		= "Mostrar temporizador para la desaparición de la plataforma",
	SetIconOnDestabilized	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(132222)
})

----------------------------
-- Voluntad del Emperador --
----------------------------
L = DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Mostrar marco de información de jugadores afectados por $spell:116525",
	CountOutCombo	= "Contar lanzamientos de $journal:5673",
	ArrowOnCombo	= "Mostrar flecha durante $journal:5673 (asumiendo que el jefe tiene al tanque delante y el resto de la banda a sus espaldas)"
})

L:SetMiscLocalization({
	Pull		= "¡La máquina vuelve a la vida! ¡Baja el nivel inferior!",--Emote
	Rage		= "La ira del Emperador resuena por las colinas.",--Yell
	Strength	= "¡La fuerza del Emperador aparece en la habitación!",--Emote
	Courage		= "¡El coraje del Emperador aparece en la habitación!",--Emote
	Boss		= "¡Aparecen dos construcciones titánicas en las enormes habitaciones!"--Emote
})

----------------------------
-- Visir imperial Zor'lok --
----------------------------
L = DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnEcho			= "Ha aparecido un eco",
	warnEchoDown		= "Eco abatido",
	specwarnAttenuation	= "%s en %s (%s)",
	specwarnPlatform	= "Cambio de plataforma"
})

L:SetOptionLocalization({
	warnEcho			= "Anunciar cuando aparezca un eco",
	warnEchoDown		= "Anunciar cuando se derrote a un eco",
	specwarnAttenuation	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format(127834),
	specwarnPlatform	= "Mostrar aviso especial cuando el jefe cambie de plataforma",
	ArrowOnAttenuation	= "Mostrar flecha durante $spell:127834 para indicar la dirección en que moverse",
	MindControlIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(122740)
})

L:SetMiscLocalization({
	Platform	= "¡El visir imperial Zor'lok vuela hacia una de las plataformas!",
	Defeat		= "No sucumbiremos ante la desesperación del vacío oscuro. Si Ella desea que perezcamos, así lo haremos."
})

------------
-- Ta'yak --
------------
L = DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= DBM_CORE_L.AUTO_ARROW_OPTION_TEXT:format(122949),
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(10, 123175)
})

-------------
-- Garalon --
-------------
L = DBM:GetModLocalization(713)

L:SetWarningLocalization({
	warnCrush		= "%s",
	specwarnUnder	= "¡Sal del círculo púrpura!"
})

L:SetOptionLocalization({
	warnCrush		= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(122774),
	specwarnUnder	= "Mostrar aviso especial cuando estés debajo del jefe",
	PheromonesIcon	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(122835)
})

L:SetMiscLocalization({
	UnderHim	= "debajo de sí",
	Phase2		= "¡La enorme coraza de Garalon empieza a agrietarse y romperse!"
})

--------------------------------
-- Señor del viento Mel'jarak --
--------------------------------
L = DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(121885),
	specWarnReinforcements	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format("ej6554")
})

------------------------------
-- Formador de ámbar Un'sok --
------------------------------
L = DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s en >%s< (%d)",--Localized because i like class colors on warning and shoving a number into targetname broke it using the generic.
	warnReshapeLifeTutor		= "1: Interrumpir/perjuicio al objetivo (úsalo en el jefe para acumular el perjuicio), 2: Interrumpir tu propia Deflagración de ámbar, 3: Restaurar voluntad cuando te quede poca (úsalo principalmente en la fase 3), 4: Salir del vehículo (solo en las dos primeras fases)",
	warnAmberExplosion			= ">%s< está lanzando %s",
	warnAmberExplosionAM		= "La Monstruosidad de ámbar está lanzando Deflagración de ámbar - ¡interrumpe ahora!",--personal warning.
	warnInterruptsAvailable		= "Interrupciones disponibles para %s: >%s<",
	warnWillPower				= "Voluntad restante: %s",
	specwarnWillPower			= "Voluntad baja - ¡sal del vehículo o consume un charco!",
	specwarnAmberExplosionYou	= "¡Interrumpe tu propia %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s - ¡interrumpe a la %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s - ¡interrumpe al %s!"--Mutated Construct
})

L:SetTimerLocalization({
	timerDestabalize		= "Desestabilizar (%2$d) : %1$s",
	timerAmberExplosionAMCD	= "Deflagración (Monstruosidad) TdR"
})

L:SetOptionLocalization({
	warnReshapeLife				= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.target:format(122784),
	warnReshapeLifeTutor		= "Mostrar explicación de facultades del Ensamblaje mutado",
	warnAmberExplosion			= "Mostrar aviso (y quién lo lanza) cuando $spell:122398 se esté lanzando",
	warnAmberExplosionAM		= "Mostrar aviso personal cuando la Monstruosidad de ámbar lance $spell:122398 (para interrumpirla)",
	warnInterruptsAvailable		= "Anunciar jugadores mutados con Golpe de ámbar disponible para interrumpir $spell:122402",
	warnWillPower				= "Anunciar voluntad restante cuando quede 80, 50, 30, 10, ó 4.",
	specwarnWillPower			= "Mostrar aviso especial cuando a tu ensamblaje le quede poca voluntad",
	specwarnAmberExplosionYou	= "Mostrar aviso especial para interrumpir tu propia $spell:122398",
	specwarnAmberExplosionAM	= "Mostrar aviso especial para interrumpir la $spell:122402 de la Monstruosidad de ámbar",
	specwarnAmberExplosionOther	= "Mostrar aviso especial para interrumpir la $spell:122398 de los Ensamblajes mutados descontrolados",
	timerDestabalize			= DBM_CORE_L.AUTO_TIMER_OPTIONS.target:format(123059),
	timerAmberExplosionAMCD		= "Mostrar temporizador para la siguiente $spell:122402 de la Monstruosidad de ámbar",
	InfoFrame					= "Mostrar marco de información de la voluntad de los jugadores"
})

L:SetMiscLocalization({
	WillPower	= "Voluntad"
})

-------------------------------
-- Gran emperatriz Shek'zeer --
-------------------------------
L = DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap	= "Trampa de ámbar: %d/5 resinas"
})

L:SetOptionLocalization({
	warnAmberTrap		= "Mostrar aviso (con progreso) cuando se esté creando una $spell:125826",
	InfoFrame			= "Mostrar marco de información de jugadores afectados por $spell:125390",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(5, 123735),
	StickyResinIcons	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(124097),
	HeartOfFearIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(123845)
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Fijar",
	YellPhase3		= "¡Se acabaron las excusas, Emperatriz! ¡Acaba con estos despreciables o te mataré yo mismo!"
})

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name	= "Enemigos menores"
})

---------------------------------
-- Protectores de la Eternidad --
---------------------------------
L = DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "Interceptar esbirros: Grupo %s",
	specWarnYourGroup	= "Le toca a tu grupo - ¡intercepta a los esbirros!"
})

L:SetOptionLocalization({
	warnGroupOrder		= "Anunciar rotación de grupos para $spell:118191 (por ahora solo para 25 jugadores con la estrategia de 5, 2, 2, 2)",
	specWarnYourGroup	= "Mostrar aviso especial cuando a tu grupo le toque interceptar $spell:118191 (25 jugadores)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(8, 111850) .. " (muestra a todos los jugadores si tienes el perjuicio, o solo a los jugadores con el perjuicio si no estás afectado)",
	SetIconOnPrison		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(117436)
})

-------------
-- Tsulong --
-------------
L = DBM:GetModLocalization(742)

L:SetOptionLocalization({
	warnLightOfDay	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.target:format(123716)
})

L:SetMiscLocalization{
	Victory	= "Gracias, forasteros. Me habéis liberado."
}

-------------
-- Lei Shi --
-------------
L = DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver	= "%s ha terminado"
})

L:SetTimerLocalization({
	timerSpecialCD	= "Facultad especial (%d) TdR"
})

L:SetOptionLocalization({
	warnHideOver	= "Mostrar aviso cuando termine $spell:123244",
	timerSpecialCD	= "Mostrar temporizador para el tiempo de reutilización de las facultades especiales",
	RangeFrame		= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(3, 123121) .. " (muestra a todos durante Ocultar, y solo a los tanques el resto del tiempo)"
})

L:SetMiscLocalization{
	Victory	= "Yo... ah... ¿eh? ¿Yo he...? ¿Era yo...? Todo... estaba... turbio."--wtb alternate and less crappy victory event.
}

-------------------
-- Sha del miedo --
-------------------
L = DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveForward					= "Ve adelante",
	MoveRight					= "Ve a la derecha",
	MoveBack					= "Ve a tu posición anterior",
	specWarnBreathOfFearSoon	= "Aliento de miedo en breve - ¡ve al muro!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD	= "Siguiente habilidad especial",
	timerSpoHudCD			= "Terror / Aspersor TdR",
	timerSpoStrCD			= "Aspersor / Golpe TdR",
	timerHudStrCD			= "Terror / Golpe TdR"
})

L:SetOptionLocalization({
	warnThrash					= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(131996),
	warnBreathOnPlatform		= "Mostrar aviso para $spell:119414 al estar en los santuarios (no recomendable salvo que seas el líder de la banda)",
	specWarnBreathOfFearSoon	= "Mostrar aviso especial previo para $spell:119414 si no estás afectado por el beneficio de $spell:117964",
	specWarnMovement			= "Mostrar aviso especial para esquivar durante $spell:120047",
	timerSpecialAbility			= "Mostrar temporizador para la siguiente habilidad especial",
	RangeFrame					= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(2, 119519),
	SetIconOnHuddle				= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(120629)
})

--------------------------
-- Jin'rokh el Rompedor --
--------------------------
L = DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "%s en breve - ¡sal de Agua conductiva!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "Mostrar aviso especial para salir de $spell:138470 (avisa antes de $spell:137313 o cuando el perjuicio de $spell:138732 esté a punto de expirar)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("8/4")
})

----------------
-- Horridonte --
----------------
L = DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "Orbe de control en el suelo",
	specWarnOrbofControl	= "¡Orbe de control en el suelo!"
})

L:SetTimerLocalization({
	timerDoor	= "Siguiente puerta tribal",
	timerAdds	= "Siguiente %s"
})

L:SetOptionLocalization({
	warnAdds				= "Anunciar cuando aparezcan esbirros",
	warnOrbofControl		= "Anunciar cuando un $journal:7092 cae al suelo",
	specWarnOrbofControl	= "Mostrar aviso especial cuando un $journal:7092 cae al suelo",
	timerDoor				= "Mostrar temporizador para la apertura de la siguiente puerta tribal",
	timerAdds				= "Mostrar temporizador para los siguientes esbirros",
	SetIconOnAdds			= "Poner iconos en los esbirros de las gradas",
	RangeFrame				= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(5, 136480),
	SetIconOnCharge			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136769)
})

L:SetMiscLocalization({
	newForces		= "salen en tropel desde",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "fija la vista"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

-------------------------
-- Consejo de Ancianos --
-------------------------
L = DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed	= "%s en %s - ¡cambia de objetivo!"
})

L:SetOptionLocalization({
	warnPossessed		= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	specWarnPossessed	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.switch:format(136442),
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format(5),
	AnnounceCooldowns	= "Anunciar (con contador, hasta 3) los lanzamientos de $spell:137166 para el uso de facultades potentes de sanación",
	SetIconOnBitingCold	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136992),
	SetIconOnFrostBite	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136922)
})

------------
-- Tortos --
------------
L = DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s usado por >%s< (%d restantes)",
	specWarnCrystalShell	= "Obtén %s"
})

L:SetOptionLocalization({
	warnKickShell			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(134031),
	specWarnCrystalShell	= "Mostrar aviso especial cuando no tengas el perjuicio de $spell:137633 y estés por encima del 90% de salud",
	InfoFrame				= "Mostrar marco de información de jugadores no afectados por $spell:137633",
	ClearIconOnTurtles		= "Quitar iconos de $journal:7129 cuando les afecte $spell:133971",
	AnnounceCooldowns		= "Anunciar $spell:134920 (con contador) para el uso de facultades potentes de sanación"
})

L:SetMiscLocalization({
	WrongDebuff	= "Sin %s"
})

-------------
-- Megaera --
-------------
L = DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD	= "Siguiente aliento"
})

L:SetOptionLocalization({
	timerBreaths			= "Mostrar temporizador para el siguiente aliento",
	SetIconOnCinders		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(139822),
	SetIconOnTorrentofIce	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(139889),
	AnnounceCooldowns		= "Anunciar Desenfreno (con contador) para el uso de facultades potentes de sanación",
	Never					= "Nunca",
	Every					= "Todos (consecutivo)",
	EveryTwo				= "Cada 2",
	EveryThree				= "Cada 3",
	EveryTwoExcludeDiff		= "Cada 2 (exceptuando Difusión)",
	EveryThreeExcludeDiff	= "Cada 3 (exceptuando Difusión)"
})

L:SetMiscLocalization({
	rampageEnds	= "La ira de Megaera amaina."
})

------------
-- Ji Kun --
------------
L = DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock			= "%s - %s %s",
	specWarnFlock		= "%s - %s %s",
	specWarnBigBird		= "Guardián del nido (%s)",
	specWarnBigBirdSoon	= "Guardián del nido (%s) en breve"
})

L:SetTimerLocalization({
	timerFlockCD	= "Nido (%d): %s"
})

L:SetOptionLocalization({
	warnFlock			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.count:format("ej7348"),
	specWarnFlock		= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.switch:format("ej7348"),
	specWarnBigBird		= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.switch:format("ej7827"),
	specWarnBigBirdSoon	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.soon:format("ej7827"),
	timerFlockCD		= DBM_CORE_L.AUTO_TIMER_OPTIONS.nextcount:format("ej7348"),
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(10, 138923),
	ShowNestArrows		= "Mostrar flecha para nidos activos",
	Never				= "Nunca",
	Northeast			= "Azul - Noreste superior e inferior",
	Southeast			= "Verde - Sudeste superior e inferior",
	Southwest			= "Púrpura/Rojo - Sudoeste superior e inferior (25) o medio superior (10)",
	West				= "Rojo - Oeste inferior y medio superior (25)",
	Northwest			= "Amarillo - Noroeste superior e inferior (25)",
	Guardians			= "Nidos con guardianes del nido"
})

L:SetMiscLocalization({
	eggsHatch		= "empiezan a abrirse!",
	Upper			= "Arriba",
	Lower			= "Abajo",
	UpperAndLower	= "Arriba y abajo",
	TrippleD		= "Triple (dos abajo)",
	TrippleU		= "Triple (dos arriba)",
	NorthEast		= "|cff0000ffNoreste|r",--Blue
	SouthEast		= "|cFF088A08Sudeste|r",--Green
	SouthWest		= "|cFF9932CDSudoeste|r",--Purple
	West			= "|cffff0000Oeste|r",--Red
	NorthWest		= "|cffffff00Noroeste|r",--Yellow
	Middle10		= "|cFF9932CDMedio|r",--Purple (Middle is upper southwest on 10 man/LFR)
	Middle25		= "|cffff0000Medio|r",--Red (Middle is upper west on 25 man)
	ArrowUpper		= " |TInterface\\Icons\\misc_arrowlup:12:12|t ",
	ArrowLower		= " |TInterface\\Icons\\misc_arrowdown:12:12|t "
})

------------------------
-- Durumu el Olvidado --
------------------------
L = DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "Luz - |cffff0000Roja|r : >%s<, |cff0000ffAzul|r : >%s<",
	warnBeamHeroic				= "Luz - |cffff0000Roja|r : >%s<, |cff0000ffAzul|r : >%s<, |cffffff00Amarilla|r : >%s<",
	warnAddsLeft				= "Nieblas restantes: %d",
	specWarnBlueBeam			= "Luz azul en ti - ¡no te muevas!",
	specWarnFogRevealed			= "¡%s revelada!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam					= "Anunciar objetivos de los haces de luz",
	warnAddsLeft				= "Anunciar el número de nieblas restantes",
	specWarnFogRevealed			= "Mostrar aviso especial cuando se revele una niebla",
	specWarnBlueBeam			= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format(139202),
	specWarnDisintegrationBeam	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format("ej6882"),
	ArrowOnBeam					= "Mostrar flecha durante $journal:6882 para indicar la dirección en que moverse",
	SetIconRays					= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format("ej6891"),
	SetIconLifeDrain			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(133795),
	SetIconOnParasite			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(133597),
	InfoFrame					= "Mostrar marco de información para las acumulaciones de $spell:133795",
	SetParticle					= "Cambiar automáticamente la opción gráfica de densidad de partículas a bajo al iniciar el encuentro (se restaurará al terminar el encuentro)"
})

L:SetMiscLocalization({
	LifeYell	= "Drenaje de vida en %s (%d)"
})

----------------
-- Primordius --
----------------
L = DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount	= "Mutaciones: %d/5 buenas, %d malas"
})

L:SetOptionLocalization({
	warnDebuffCount		= "Mostrar aviso (con contador) de perjuicios de mutación al absorber charcos",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("5/3"),
	SetIconOnBigOoze	= "Poner icono en $journal:6969"
})

-------------------
-- Animus oscuro --
-------------------
L = DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s< y >%s< intercambiados"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "Anunciar objetivos intercambiados por $spell:138618",
	SetIconOnFont		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(138707)
})

L:SetMiscLocalization({
	Pull	= "¡El orbe explota!"
})

------------------
-- Qon el Tenaz --
------------------
L = DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: escudado en %s / %s"
})

L:SetOptionLocalization({
	warnDeadZone			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(137229),
	SetIconOnLightningStorm	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136192),
	RangeFrame				= "Mostrar marco de distancia (10 m) dinámico (se mostrará si hay demasiados jugadores demasiado juntos)",
	InfoFrame				= "Mostrar marco de información de jugadores afectados por el perjuicio de $spell:136193"
})

-----------------------
-- Consortes Gemelas --
-----------------------
L = DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight	= "Fase de la noche",
	warnDay		= "Fase del día",
	warnDusk	= "Fase del ocaso"
})

L:SetTimerLocalization({
	timerDayCD	= "Siguiente fase del día",
	timerDuskCD	= "Siguiente fase del ocaso"
})

L:SetOptionLocalization({
	warnNight	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format("ej7641"),
	warnDay		= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format("ej7645"),
	warnDusk	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format("ej7633"),
	timerDayCD	= DBM_CORE_L.AUTO_TIMER_OPTIONS.next:format("ej7645"),
	timerDuskCD	= DBM_CORE_L.AUTO_TIMER_OPTIONS.next:format("ej7633"),
	RangeFrame	= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format(5)
})

L:SetMiscLocalization({
	DuskPhase	= "¡Lu'lin! ¡Préstame tu fuerza!"
})

--------------
-- Lei Shen --
--------------
L = DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "Intermedio en breve",
	warnDiffusionChainSpread	= "%s salta a >%s<"
})

L:SetTimerLocalization({
	timerConduitCD	= "Primera facultad de conducto TdR"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "Mostrar aviso especial previo para los intermedios",
	warnDiffusionChainSpread	= "Anunciar objetivos de los saltos de $spell:135991",
	timerConduitCD				= "Mostrar temporizador para el tiempo de reutilización de la primera facultad de conducto",
	RangeFrame					= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("8/6"),--For two different spells
	StaticShockArrow			= "Mostrar flecha cuando un jugador esté afectado por $spell:135695",
	OverchargeArrow				= "Mostrar flecha cuando un jugador esté afectado por $spell:136295",
	SetIconOnOvercharge			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136295),
	SetIconOnStaticShock		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(135695)
})

L:SetMiscLocalization({
	StaticYell	= "Choque estático en %s (%d)"
})

------------
-- Ra Den --
------------
L = DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnUnstablVitaJump	= "¡Vita inestable salta a ti!"
})

L:SetOptionLocalization({
	specWarnUnstablVitaJump	= "Mostrar aviso especial cuando $spell:138297 salta a ti"
})

L:SetMiscLocalization({
	Defeat	= "¡Esperad!"
})

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name	= "Enemigos menores"
})

L:SetOptionLocalization({
	RangeFrame	= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format(10)--For 3 different spells
})

---------------
-- Immerseus --
---------------
L = DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory	= "¡Ah, lo habéis logrado! Las aguas vuelven a ser puras."
})

----------------------------
-- Los protectores caídos --
----------------------------
L = DBM:GetModLocalization(849)

L:SetWarningLocalization({
	specWarnCalamity	= "%s",
	specWarnMeasures	= "¡Medidas desesperadas (%s) en breve!"
})

--------------
-- Norushen --
--------------
L = DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime	= "Muy bien, crearé un campo para mantener aislada vuestra corrupción."
})

---------------------
-- Sha del orgullo --
---------------------
L = DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "Poner icono en Fragmento corrupto"
})

--------------
-- Galakras --
--------------
L = DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen	= "Torre abierta",
	warnTowerGrunt	= "Bruto Faucedraco"
})

L:SetTimerLocalization({
	timerTowerCD		= "Siguiente torre",
	timerTowerGruntCD	= "Siguiente Bruto Faucedraco"
})

L:SetOptionLocalization({
	warnTowerOpen		= "Anunciar cuando se abra una torre",
	warnTowerGrunt		= "Anunciar cuando aparezca un Bruto Faucedraco",
	timerTowerCD		= "Mostrar temporizador para la siguiente apertura de torre",
	timerTowerGruntCD	= "Mostrar temporizador para el siguiente Bruto Faucedraco"
})

L:SetMiscLocalization({
	wasteOfTime		= "¡Bien hecho! ¡Grupos de desembarco, formad! ¡Infantería, al frente!",--Alliance Version
	wasteOfTime2	= "Bien hecho. La primera brigada ha desembarcado.",--Horde Version
	Pull			= "Clan Faucedraco, ¡recuperad los muelles y empujadlos al mar! ¡Por Grito Infernal! ¡Por la Horda auténtica!",
	newForces1		= "¡Ya vienen!",--Jaina's line, alliance
	newForces1H		= "Derribadla pronto para que pueda asfixiarla con mis propias manos.",--Sylva's line, horde
	newForces2		= "¡Faucedraco, avanzad!",
	newForces3		= "¡Por Grito Infernal!",
	newForces4		= "¡Siguiente escuadrón, adelante!",
	tower			= "¡La puerta de la torre"--The door barring the South/North Tower has been breached!
})

-------------------------------
-- Chamanes oscuros Kor'kron --
-------------------------------
L = DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell	= "Prisión de hierro expira en %s (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L = DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon	= "Actitud defensiva en %d s"
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.prewarn:format(143593)
})

L:SetMiscLocalization({
	newForces1	= "¡Guerreros, paso ligero!",
	newForces2	= "¡Defended la puerta!",
	newForces3	= "¡Reunid a las tropas!",
	newForces4	= "¡Kor'kron, conmigo!",
	newForces5	= "¡Siguiente escuadrón, al frente!",
	allForces	= "Atención, Korkron: ¡matadlos!",
	nextAdds	= "Siguientes refuerzos: "
})

-----------------------
-- Botín de Pandaria --
-----------------------
L = DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime	= "¿Estamos grabando? ¿Sí? Vale. Iniciando módulo de control goblin-titán. Atrás.",
	Module1		= "El módulo 1 está listo para el reinicio del sistema.",
	Victory		= "El módulo 2 está listo para el reinicio del sistema."
})

-------------------------
-- Thok el Sanguinario --
-------------------------
L = DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Mostrar marco de distancia (10 m) dinámico (se mostrará al estar en el umbral de alcance de $spell:143442)"
})

--------------------------
-- Asediador Mechanegra --
--------------------------
L = DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "La cadena de montaje empieza a sacar armas sin terminar.",
	newShredder	= "¡Una trituradora automática se acerca!"
})

----------------------------
-- Dechados de los Klaxxi --
----------------------------
L = DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable	= "Eres vulnerable a %s - ¡esquiva!",
	specWarnMoreParasites		= "Necesitas más parásitos - ¡no uses mitigaciones activas!"
})

L:SetOptionLocalization({
	warnToxicCatalyst			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format("ej8036"),
	specWarnActivatedVulnerable	= "Mostrar aviso especial cuando seas vulnerable a un dechado",
	specWarnMoreParasites		= "Mostrar aviso especial cuando necesites más parásitos",
	yellToxicCatalyst			= DBM_CORE_L.AUTO_YELL_OPTION_TEXT.yell:format("ej8036")
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one				= "Uno",
	two				= "Dos",
	three			= "Tres",
	four			= "Cuatro",
	five			= "Cinco",
	hisekFlavor		= "¿Te gusta el silencio, Hisek?",--http://ptr.wowhead.com/quest=31510
	KilrukFlavor	= "Otro días más de matar al enjambre.",--http://ptr.wowhead.com/quest=31109
	XarilFlavor		= "Ya no verás más que cielos oscuros.",--http://ptr.wowhead.com/quest=31216
	KaztikFlavor	= "Reducido a meras golosinas de kunchong.",--http://ptr.wowhead.com/quest=31024
	KaztikFlavor2	= "Un mántide menos; solo quedan ciento noventa y nueve.",--http://ptr.wowhead.com/quest=31808
	KorvenFlavor	= "El fin de un imperio ancestral.",--http://ptr.wowhead.com/quest=31232
	KorvenFlavor2	= "Toma tus tablillas de Gurthani y métetelas por donde te quepan.",--http://ptr.wowhead.com/quest=31232
	IyyokukFlavor	= "He visto una oportunidad y la he explotado.",--Does not have quests, http://ptr.wowhead.com/npc=65305
	KarozFlavor		= "¡No volverás a saltar!",---Does not have quests, http://ptr.wowhead.com/npc=65303
	SkeerFlavor		= "¡Una delicia sangrienta!",--http://ptr.wowhead.com/quest=31178
	RikkalFlavor	= "Recogida de espécimen completada."--http://ptr.wowhead.com/quest=31508
})

----------------------------
-- Garrosh Grito Infernal --
----------------------------
L = DBM:GetModLocalization(869)

L:SetTimerLocalization({
	timerRoleplay	= "Diálogo"
})

L:SetOptionLocalization({
	timerRoleplay		= "Mostrar temporizador para el diálogo entre Garrosh y Thrall",
	RangeFrame			= "Mostrar marco de distancia (8 m) dinámico (se mostrará al estar en el umbral de alcance de $spell:147126)",
	InfoFrame			= "Mostrar marco de información de jugadores sin reducción de daño durante el intermedio"
})

L:SetMiscLocalization({
	wasteOfTime		= "No es demasiado tarde, Garrosh. Renuncia al cargo de Jefe de Guerra. Esto puede acabar ahora, sin más sangre.",
	NoReduce		= "Sin reducción de daño",
	phase3End		= "¿Creéis que habéis ganado?"
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name	= "Enemigos menores"
})
