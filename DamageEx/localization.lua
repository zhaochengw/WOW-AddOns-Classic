DEX_Version = "|r|cffff8800DamageEx|r Damage displayer   Type /dex for options";

DEX_FontList = {
	"Fonts\\ARIALN.TTF",
	"Fonts\\FRIZQT__.ttf",
	"Fonts\\SKURRI.ttf",
	"Fonts\\Fight.TTF",
}

DEX_TXT_CRUSH = "Crush!"
DEX_TXT_DISPELLED = "Dispel! "
DEX_TXT_STOLEN = "Steal! "
DEX_TXT_REFLECT = " Reflect! "
DEX_TXT_CRIT = "Crit! ";
DEX_TXT_INTERUPT = "Interrupt! ";
DEX_MAIN_OPTION = "DamageEx";
DEX_BUTTON_RESET_TIP = "Restore defaults";
DEX_PREVIEW_LABEL = "Drag me to *change* text position";

DEXColorMode_T = "Color mode"
DEXOptionsDropDown = {"Monochrome","Double","Gradient"};

DEXOptionsFrameCheckButtons = {
	["DEX_Enable"] = { title = "Enable", tooltipText = "Enable damage displaying"},
	["DEX_ShowWithMess"] = { title = "As combat log", tooltipText = "Display damage texts as combat log"},
	["DEX_ShowSpellName"] = { title = "Spell names", tooltipText = "Display spell names next to damage texts"},
	["DEX_ShowNameOnCrit"] = { title = "Crits only", tooltipText = "Display spell names only for critical hits"},
	["DEX_ShowNameOnMiss"] = { title = "Missed only", tooltipText = "Display spell names only for missed hits"},
	["DEX_ShowInterruptCrit"] = { title = "Interrupts as crits", tooltipText = "Display interrupts in the crits way"},
	["DEX_ShowCurrentOnly"] = { title = "Target only", tooltipText = "Only display damage texts for current target"},
	["DEX_ShowDamagePeriodic"] = { title = "DOT", tooltipText = "Display DOT"},
	["DEX_ShowDamageShield"] = { title = "Reflect", tooltipText = "Display reflected damages"},
	["DEX_ShowDamageHealth"] = { title = "Healing", tooltipText = "Display healing texts"},
	["DEX_ShowDamagePet"] = { title = "Pet", tooltipText = "Display damages from your pets"},
	["DEX_ShowBlockNumber"] = { title = "Blocked", tooltipText = "Display blocked/resisted damages"},
	["DEX_ShowDamageWoW"] = { title = "Enable system combat texts", tooltipText = "Enable system default floating combat texts"},
	["DEX_ShowOwnHealth"] = { title = "Self healing", tooltipText = "Display healings apply to yourself"},
	["DEX_UniteSpell"] = { title = "Combine damages", tooltipText = "Combine simutaneous damages against same target"},
	["DEX_NumberFormat"] = { title = "Display digit separator", tooltipText = "Display the number of sub digital separation"},	
	["DEX_ShowSpellIcon"] = { title = "Show Spell Icon", tooltipText = "Display Spell Icon,Choosen to replace the spell name"},
	["DEX_ShowInterrupt"] = { title = "Show Interrupt", tooltipText = "Display Interrupt texts"},	
	["DEX_ShowOverHeal"] = { title = "Show Overheal", tooltipText = "Display Overhealing apply to all target"},		
}

DEXOptionsFrameSliders = {
	["DEX_Font"] = {  title = "Font ", minText="Font1", maxText="Font4", tooltipText = "Reset font"},
	["DEX_FontSize"] = {  title = "Font size ", minText="Small", maxText="Large", tooltipText = "Config font size"},
	["DEX_OutLine"] = {  title = "Font outline ", minText="None", maxText="Thick", tooltipText = "Config font outline"},
	["DEX_Speed"] = {  title = "Text floating speed ", minText="Slow", maxText="Fast", tooltipText = "Config text floating speed"},
	["DEX_LOGLINE"] = {  title = "Max lines ", minText="5", maxText="20", tooltipText = "Config max text lines"},
	["DEX_LOGTIME"] = {  title = "Fade duration (sec) ", minText="5", maxText="60", tooltipText = "Config line fade duration"},
}

DEXOptionsColorPickerEx = {
	["DEX_ColorNormal"] = { title = "Physical color"},
	["DEX_ColorSkill"] = { title = "Spell color"},
	["DEX_ColorPeriodic"] = { title = "DOT color"},
	["DEX_ColorHealth"] = { title = "Healing color"},
	["DEX_ColorPet"] = { title = "Pet color"},
	["DEX_ColorSpec"] = { title = "Interrupt/dispel color"},
	["DEX_ColorMana"] = { title = "Mana burn color"},
}
