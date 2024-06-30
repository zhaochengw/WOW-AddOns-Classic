if GetLocale() ~= "zhTW" then return end

DEX_Version = "|r|cffff8800DamageEx|r 增強傷害顯示器   輸入/dex查看選項";

DEX_FontList = {
	"Fonts\\ARKai_C.TTF",
	"Interface\\AddOns\\DamageEx\\dx2.TTF",
	"Interface\\AddOns\\DamageEx\\dx3.TTF",
}
--6 7 8行 字体文件名称修改 18行修改设置界面插件表述.Fixed by 黑山老鬼/部落大人2022.9.19
--6 7 8行 字体文件修改.18行修改设置界面插件表述.Fixed by 黑山老鬼/部落大人2024.6.28
DEX_TXT_CRUSH = "碾壓!"
DEX_TXT_DISPELLED = "驅散! "
DEX_TXT_STOLEN = "偷取! "
DEX_TXT_REFLECT = " 反彈! "
DEX_TXT_CRIT = "暴擊! ";
DEX_TXT_INTERUPT = "打斷! ";
DEX_MAIN_OPTION = "DamageEx-For CWLK-3.43 部落大人";
DEX_BUTTON_RESET_TIP = "恢復預設值";
DEX_PREVIEW_LABEL = "拖動我改*變*文字位置";

DEXColorMode_T = "顏色模式"
DEXOptionsDropDown = {"單色","雙色","漸變色"};

DEXOptionsFrameCheckButtons = {
	["DEX_Enable"] = { title = "開啟", tooltipText = "開啟攻擊傷害顯示器"},
	["DEX_ShowWithMess"] = { title = "以戰鬥訊息方式顯示", tooltipText = "以戰鬥訊息方式顯示所有傷害資訊"},
	["DEX_ShowSpellName"] = { title = "顯示技能名", tooltipText = "在傷害數值邊顯示造成此次傷害的技能名"},
	["DEX_ShowNameOnCrit"] = { title = "當暴擊才顯示", tooltipText = "只有在致命一擊時才顯示技能名"},
	["DEX_ShowNameOnMiss"] = { title = "當未擊中等才顯示", tooltipText = "只有在技能未擊中，被抵抗等才顯示技能名"},
	["DEX_ShowInterruptCrit"] = { title = "暴擊方式顯示中斷", tooltipText = "暴擊方式顯示中斷"},
	["DEX_ShowCurrentOnly"] = { title = "只顯示選中目標傷害", tooltipText = "只顯示當前選中目標的傷害和治療,非當前選中目標則不顯示"},
	["DEX_ShowDamagePeriodic"] = { title = "顯示持續傷害", tooltipText = "顯示持續攻擊的傷害"},
	["DEX_ShowDamageShield"] = { title = "顯示反彈傷害", tooltipText = "顯示你對敵人傷害的反射量"},
	["DEX_ShowDamageHealth"] = { title = "顯示治療量", tooltipText = "顯示對目標的實際治療量和過量治療"},
	["DEX_ShowDamagePet"] = { title = "顯示寵物傷害", tooltipText = "顯示寵物對目標的傷害，含圖騰"},
	["DEX_ShowBlockNumber"] = { title = "顯示被格檔的傷害", tooltipText = "以xxx-xx方式顯示對目標的傷害被格檔、抵抗的數值"},
	["DEX_ShowDamageWoW"] = { title = "顯示系統默認傷害", tooltipText = "顯示系統原有的傷害"},
	["DEX_ShowOwnHealth"] = { title = "顯示自身治療", tooltipText = "當目標為自己的時候也顯示治療量"},
	["DEX_UniteSpell"] = { title = "合併多次同技能傷害", tooltipText = "如風怒武器,毀傷等瞬間對同一目標造成多次傷害的技能將被合併為一個傷害顯示"},
	["DEX_NumberFormat"] = { title = "顯示數字分隔符", tooltipText = "是否顯示千分位傷害數字分隔符"},
	["DEX_ShowSpellIcon"] = { title = "顯示技能圖標", tooltipText = "是否顯示技能圖標，選中則替換顯示技能名稱"},		
	["DEX_ShowInterrupt"] = { title = "是否顯示中斷", tooltipText = "是否顯示中斷提示"},	
	["DEX_ShowOverHeal"] = { title = "是否顯示過量治療", tooltipText = "是否顯示過量治療，關閉則不顯示"},				
}
--31 37 39 42行 菜单选项字数修改 Edited by 黑山老鬼/部落大人2022.9.19
--49行 文字字形表述修改回原来的字形1 字形3.Fixed by 黑山老鬼/部落大人2024.6.28
DEXOptionsFrameSliders = {
	["DEX_Font"] = {  title = "字型 ", minText="字型1", maxText="字型3", tooltipText = "設置文字字型"},
	["DEX_FontSize"] = {  title = "文字大小 ", minText="小", maxText="大", tooltipText = "設置文字的大小"},
	["DEX_OutLine"] = {  title = "字型描邊 ", minText="無", maxText="粗", tooltipText = "設置文字的描邊效果"},
	["DEX_Speed"] = {  title = "文字移動速度 ", minText="慢", maxText="快", tooltipText = "設置文字的移動速度"},
	["DEX_LOGLINE"] = {  title = "訊息最大條目 ", minText="5條", maxText="20條", tooltipText = "設置訊息最大顯示條目數"},
	["DEX_LOGTIME"] = {  title = "訊息停留時間 ", minText="5秒", maxText="1分鐘", tooltipText = "設置訊息文字停留時間"},
}
--48行 文字字形表述修改 Edited by 黑山老鬼/部落大人2022.9.19
DEXOptionsColorPickerEx = {
	["DEX_ColorNormal"] = { title = "物理傷害顏色"},
	["DEX_ColorSkill"] = { title = "技能傷害顏色"},
	["DEX_ColorPeriodic"] = { title = "持續傷害顏色"},
	["DEX_ColorHealth"] = { title = "治療顏色"},
	["DEX_ColorPet"] = { title = "寵物傷害顏色"},
	["DEX_ColorSpec"] = { title = "中斷,驅散等顏色"},
	["DEX_ColorMana"] = { title = "法力傷害顏色"},
}
