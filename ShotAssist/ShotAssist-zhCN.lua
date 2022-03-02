local L = AceLibrary("AceLocale-2.2"):new("ShotAssist")
L:RegisterTranslations("zhCN", function()
return {
	["Lock/Unlock the casting bar."] = "锁定/解锁施法条",
	["Unlocked"] = "已解锁",
	["Locked"] = "已锁定",

	["Set the texture."] = "材质设定",

	["Set the border for the bar."] = "边框设定",

	["Set the width of the casting bar."] = "施法条宽度设定",

	["Set the height of the casting bar."] = "施法条高度设定",

	["Set the height of the auto shot bar."] = "自动射击条高度设定",

	["The acceptable amount of time to delay an autoshot."] = "设定自动射击延迟容忍度",

	["Display the icon of the next shot."] = "是否显示图标",

	["Display the autoshot timer bar."] = "是否显示自动射击条",
	["Set the color of the bar."] = "颜色设置",
	["When should the bar change to the soon color."] = "提前多久提示将要施法",
	["When should the bar change to the now color."] = "提前多久提示立即施法",

	["Set the font size of different elements."] = "修改字体",


	["Set the font size of the spellname."] = "修改法术字体",

	["Set the font size of the spell time."] = "修改法术时间字体",


	["Set the color of the bar when there is no upcoming shot."] = "修改无须施法时的颜色",

	["Set the color of the bar when you should be casting soon."] = "修改将要释放法术时的颜色",
	["Set the color of the bar when you should be casting."] = "修改立刻需要释放法术时的颜色",


}
end)