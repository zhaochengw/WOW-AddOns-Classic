if GetLocale() ~= "zhCN" then return end

DEX_Version = "|r|cffff8800DamageEx|r 增强伤害显示器   输入/dex查看选项";

DEX_FontList = {
	"Fonts\\ARHei.TTF",
	"Fonts\\FRIZQT__.TTF",
	"Fonts\\ARKai_T.TTF",
	"Fonts\\Fight.TTF",
}

DEX_TXT_CRUSH = "碾压!"
DEX_TXT_DISPELLED = "驱散! "
DEX_TXT_STOLEN = "偷取! "
DEX_TXT_REFLECT = " 反弹! "
DEX_TXT_CRIT = "暴击! ";
DEX_TXT_INTERUPT = "打断! ";
DEX_MAIN_OPTION = "DamageEx";
DEX_BUTTON_RESET_TIP = "恢复预设值";
DEX_PREVIEW_LABEL = "拖动我改*变*文字位置";

DEXColorMode_T = "颜色模式"
DEXOptionsDropDown = {"单色","双色","渐变色"};

DEXOptionsFrameCheckButtons = {
	["DEX_Enable"] = { title = "启用", tooltipText = "启用攻击伤害显示器"},
	["DEX_ShowWithMess"] = { title = "以战斗讯息方式显示", tooltipText = "以战斗讯息方式显示所有伤害资讯"},
	["DEX_ShowSpellName"] = { title = "显示技能名", tooltipText = "在伤害数值边显示造成此次伤害的技能名"},
	["DEX_ShowNameOnCrit"] = { title = "当暴击才显示", tooltipText = "只有在致命一击时才显示技能名"},
	["DEX_ShowNameOnMiss"] = { title = "当未击中时才显示", tooltipText = "只有在技能未击中、被抵抗等才显示技能名"},
	["DEX_ShowInterruptCrit"] = { title = "暴击方式显示打断", tooltipText = "暴击方式显示打断"},
	["DEX_ShowCurrentOnly"] = { title = "只显示当前选中目标的数值", tooltipText = "只显示当前选中目标的伤害和治疗，非当前选中目标则不显示"},
	["DEX_ShowDamagePeriodic"] = { title = "显示持续伤害", tooltipText = "显示持续攻击的伤害"},
	["DEX_ShowDamageShield"] = { title = "显示反弹伤害", tooltipText = "显示你对敌人伤害的反弹量"},
	["DEX_ShowDamageHealth"] = { title = "显示治疗量", tooltipText = "显示对目标的实际治疗和过量治疗"},
	["DEX_ShowDamagePet"] = { title = "显示宠物伤害", tooltipText = "显示宠物对目标的伤害，含图腾"},
	["DEX_ShowBlockNumber"] = { title = "显示被格挡的伤害", tooltipText = "以xxx-xx方式显示对目标的伤害被格挡、抵抗等的数值"},
	["DEX_ShowDamageWoW"] = { title = "显示系统默认伤害", tooltipText = "显示系统原有的伤害"},
	["DEX_ShowOwnHealth"] = { title = "显示自身治疗", tooltipText = "等目标为自己时也显示治疗量"},
	["DEX_UniteSpell"] = { title = "合并瞬间的多次同技能伤害", tooltipText = "如风怒武器、毁伤等瞬间对同一目标造成多次伤害的技能将被合并为一个伤害显示"},
	--["DEX_NumberFormat"] = { title = "显示数字分隔符", tooltipText = "是否显示千分位伤害数字分隔符"},	
	["DEX_NumberFormat"] = { title = "缩短数字长度", tooltipText = "是否将超过1万/亿的数字以万/亿为单位显示"},	
	["DEX_ShowSpellIcon"] = { title = "显示技能图标", tooltipText = "是否显示技能图标，选中则替换显示技能名称"},
	["DEX_ShowInterrupt"] = { title = "是否显示中断", tooltipText = "是否显示中断提示"},	
	["DEX_ShowOverHeal"] = { title = "是否显示过量治疗", tooltipText = "是否显示过量治疗，关闭则不提示"},		
}

DEXOptionsFrameSliders = {
	["DEX_Font"] = {  title = "字型 ", minText="字型1", maxText="字型4", tooltipText = "设置文字字型"},
	["DEX_FontSize"] = {  title = "文字大小 ", minText="小", maxText="大", tooltipText = "设置文字的大小"},
	["DEX_OutLine"] = {  title = "字型描边 ", minText="无", maxText="粗", tooltipText = "设置文字的描边效果"},
	["DEX_Speed"] = {  title = "文字移动速度 ", minText="慢", maxText="快", tooltipText = "设置文字的移动速度"},
	["DEX_LOGLINE"] = {  title = "讯息最大条目 ", minText="5", maxText="20", tooltipText = "设置讯息最大显示条目数"},
	["DEX_LOGTIME"] = {  title = "讯息停留时间 ", minText="5秒", maxText="1分钟", tooltipText = "设置讯息文字停留时间"},
}

DEXOptionsColorPickerEx = {
	["DEX_ColorNormal"] = { title = "物理伤害颜色"},
	["DEX_ColorSkill"] = { title = "技能伤害颜色"},
	["DEX_ColorPeriodic"] = { title = "持续伤害颜色"},
	["DEX_ColorHealth"] = { title = "治疗颜色"},
	["DEX_ColorPet"] = { title = "宠物伤害颜色"},
	["DEX_ColorSpec"] = { title = "打断、驱散等颜色"},
	["DEX_ColorMana"] = { title = "法力伤害颜色"},
}
