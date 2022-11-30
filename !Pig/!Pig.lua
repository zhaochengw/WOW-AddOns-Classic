-------------<猪猪加油定制插件>---562314------------
--================================================
local addonName, addonTable = ...;
--=======ReloadUI重载命令注册为/RL=====
SLASH_RELOAD1 = '/rl'
SlashCmdList.RELOAD = ReloadUI
--------
SLASH_PIG1 = "/pig"
SLASH_PIG2 = "/Pig"
SLASH_PIG3 = "/PIG"
SlashCmdList["PIG"] = function()
	Pig_OptionsUI:Show();
end
--================================================
local AAAAA = CreateFrame("Frame")        
AAAAA:RegisterEvent("ADDON_LOADED")
AAAAA:SetScript("OnEvent",function(self, event, arg1)
	if arg1 == addonName then
		local feifaPlayers=addonTable.feifaPlayers
		local name= UnitName("player")
		for i=1,#feifaPlayers do
			if name==feifaPlayers[i] then
				local function tuichuPIGpindao()
					LeaveChannelByName("PIG")
				end
				C_Timer.After(2,tuichuPIGpindao)
				C_Timer.After(4,tuichuPIGpindao)
				C_Timer.After(6,tuichuPIGpindao)
				C_Timer.After(8,tuichuPIGpindao)
				C_Timer.After(10,tuichuPIGpindao)
				Pig_OptionsUI.RF:Hide()
				print("|cffFF0000"..arg1.."：非法玩家，插件已停止加载！|r");
				return
			end
		end
		addonTable.Config_Default()
		------------------
		addonTable.Map_MiniMap()
		addonTable.Map_WorldMap()
		addonTable.PigCVars()
		---
		addonTable.QuickButton()
		-- 
		addonTable.Interaction_FastLoot()
		addonTable.Interaction_AutoDown()
		addonTable.Interaction_AutoDialogue()
		addonTable.Interaction_RightPlus()
		addonTable.Interaction_jiaoyizengqiang()
		addonTable.Interaction_LinkPlus()
		-----------
		addonTable.ShowPlus_Tooltip()
		-----------
		addonTable.CombatPlus_ActionBar_Ranse()
		addonTable.CombatPlus_Biaoji()
		addonTable.CombatPlus_ActionBar_AutoFanye()
		addonTable.CombatPlus_BGtongbao()
		addonTable.CombatPlus_PetTishi()
		addonTable.CombatPlus_Zhuizong()
		addonTable.CombatPlus_Cailiao()
		addonTable.CombatPlus_BuffTime()
		addonTable.CombatPlus_TimeOpen()
		addonTable.CombatPlus_HPMPziyuan()
		-------
		addonTable.CombatCycle()
		-------
		addonTable.FramePlus_ExtFrame()
		addonTable.FramePlus_TalentFrame()
		addonTable.FramePlus_CharacterFrame()
		addonTable.FramePlus_yidongUI()
		-------
		addonTable.UnitFrame_PlayerFrame()
		addonTable.UnitFrame_TargetFrame()
		addonTable.UnitFrame_PartyMemberFrame()
		--------
		addonTable.ChatFrame_Set()
		------
		addonTable.PigUI_ActionBar()
		addonTable.PigUI_ChatFrame()
		----
		addonTable.BagBank()
		addonTable.AHPlus()
		-----
		addonTable.Pig_Action()
		-----
		addonTable.AutoSellBuy_Repair()
		addonTable.AutoSellBuy_SellBuy()
		--技能监控
		addonTable.Spell_CD_JK()
		--专业副本CD
		addonTable.Skill_FuBen()
		--时空之门
		addonTable.PlaneInvite()
		--开团助手
		addonTable.RaidRecord()
		--带本助手
		addonTable.daiben()
		--屏保
		addonTable.Pig_AFK()
		---
		addonTable.PIGRaidFrame()
		-----
		addonTable.QuickButtonUpdate()
		addonTable.Map_ShouNaBut()
		--
		addonTable.Sponsorship()
		addonTable.Rurutia()
		------------------------------
		PIG_print("载入成功 /pig或小地图按钮设置(|cffFF0000本插件完全免费,网络购物平台出售皆为骗子|r)");
    end  
end)