local L = AceLibrary("AceLocale-2.2"):new("ShotAssist")
L:RegisterTranslations("enUS", function()
return {
	["lock"] = true,
	["Lock/Unlock the casting bar."] = true,
	["Test Spell"] = true,
	["Unlocked"] = true,
	["Locked"] = true,

	["texture"] = true,
	["Set the texture."] = true,

	["border"] = true,
	["Set the border for the bar."] = true,

	["width"] = true, 
	["Set the width of the casting bar."] = true,

	["height"] = true, 
	["Set the height of the casting bar."] = true,

	["autoHeight"] = true, 
	["Set the height of the auto shot bar."] = true,

	["delay"] = true, 
	["The acceptable amount of time to delay an autoshot."] = true,

	["icon"] = true, 
	["Display the icon of the next shot."] = true,

	["autoBar"] = true, 
	["Display the autoshot timer bar."] = true,

	["When should the bar change to the soon color."] = true,
	["When should the bar change to the now color."] = true,

	["font"] = true,
	["Set the font size of different elements."] = true,

	["name"] = true,
	["Set the font of different elements."] = true,

	["spell"] = true, 
	["Set the font size of the spellname."] = true,
	["time"] = true, 
	["Set the font size of the spell time."] = true,

	["color"] = true,
	["Set the color of the bar."] = true,
	["wait"] = true,
	["Set the color of the bar when there is no upcoming shot."] = true,
	["soon"] = true,
	["Set the color of the bar when you should be casting soon."] = true,
	["now"] = true,
	["Set the color of the bar when you should be casting."] = true,
	["move"] = true,
	["Set the color of the auto shot bar when you can move."] = true,
	["stop"] = true,
	["Set the color of the auto shot bar when you cannot move."] = true,
	["stopBackground"] = true,
	["Set the background color of the auto shot bar when you cannot move."] = true,
}
end)