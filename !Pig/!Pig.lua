-------------<猪猪加油定制插件>---------------
--反和谐：打开 魔兽根目录\_classic_\WTF\config.wtf加一句命令：SET overrideArchive "0"
--================================================
local addonName, addonTable = ...;
--------------------------------------------
local function Config_Default()
	PIG = PIG or addonTable.Default;
	PIG_Per = PIG_Per or addonTable.Default_Per;
end
---------------------------------------------
local Delerror=addonTable.Delerror
local Other_MinimapB=addonTable.Other_MinimapB;
local Panel_MinimapB=addonTable.Panel_MinimapB;
-----
local PigCVars=addonTable.PigCVars;
-----
local Interaction_FastLoot=addonTable.Interaction_FastLoot;
local Interaction_AutoDown=addonTable.Interaction_AutoDown;
local Interaction_AutoDialogue=addonTable.Interaction_AutoDialogue;
local Interaction_RightPlus=addonTable.Interaction_RightPlus;
local Interaction_jiaoyizengqiang=addonTable.Interaction_jiaoyizengqiang;
local Interaction_LinkPlus=addonTable.Interaction_LinkPlus
-----
local ShowPlus=addonTable.ShowPlus;
----
local CombatPlus_ActionBar_Ranse=addonTable.CombatPlus_ActionBar_Ranse
local CombatPlus_ActionBar_AutoFanye=addonTable.CombatPlus_ActionBar_AutoFanye;
local CombatPlus_BGtongbao=addonTable.CombatPlus_BGtongbao;
local CombatPlus_PetTishi=addonTable.CombatPlus_PetTishi;
local CombatPlus_Zhuizong=addonTable.CombatPlus_Zhuizong
local CombatPlus_Cailiao=addonTable.CombatPlus_Cailiao;
local CombatPlus_BuffTime=addonTable.CombatPlus_BuffTime;
local CombatPlus_TimeOpen=addonTable.CombatPlus_TimeOpen
-------
local FramePlus_ExtFrame=addonTable.FramePlus_ExtFrame;
local FramePlus_CharacterFrame=addonTable.FramePlus_CharacterFrame;
local FramePlus_yidongUI=addonTable.FramePlus_yidongUI;
-------
local UnitFrame_PlayerFrame=addonTable.UnitFrame_PlayerFrame;
local UnitFrame_TargetFrame=addonTable.UnitFrame_TargetFrame;
local UnitFrame_PartyMemberFrame=addonTable.UnitFrame_PartyMemberFrame;
---------------
local ChatFrame_QuickChat=addonTable.ChatFrame_QuickChat;
local ChatFrame_Qita=addonTable.ChatFrame_Qita;
-------------
local PigUI_ActionBar=addonTable.PigUI_ActionBar;
local PigUI_ChatFrame=addonTable.PigUI_ChatFrame;
----
local BagBank=addonTable.BagBank
-----
local Pig_Action=addonTable.Pig_Action;
-----
local Classes_Assistant=addonTable.Classes_Assistant;
-----
local AutoSellBuy_Repair=addonTable.AutoSellBuy_Repair;
local AutoSellBuy_SellBuy=addonTable.AutoSellBuy_SellBuy;
-----
local Assistant_Skill_FB=addonTable.Assistant_Skill_FB;
-----带本助手
local FarmRecord=addonTable.FarmRecord;
-----副本助手
local RaidRecord=addonTable.RaidRecord;
-----技能监控
local Spell_CD_JK=addonTable.Spell_CD_JK;
-----时空之门
local PlaneInvite=addonTable.PlaneInvite
-----团队框架
local PIGRaidFrame=addonTable.PIGRaidFrame
--================================================
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
local feifaPlayers=addonTable.feifaPlayers
--================================================
local AAAAA = CreateFrame("Frame")        
AAAAA:RegisterEvent("ADDON_LOADED")
AAAAA:SetScript("OnEvent",function(self, event, arg1)
	local pigyizairu=false;
	if pigyizairu then Other_ShounaB(); end
	if arg1 == addonName then
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
		pigyizairu=true;
		Config_Default();--载入配置
		Delerror()--删除错误
		------------------
		Other_MinimapB();
		Panel_MinimapB();
		PigCVars();
		-------------
		Interaction_FastLoot();
		Interaction_AutoDown();
		Interaction_AutoDialogue();
		Interaction_RightPlus();
		Interaction_jiaoyizengqiang();
		Interaction_LinkPlus();
		-----------
		ShowPlus();
		-----------
		CombatPlus_ActionBar_Ranse();
		CombatPlus_ActionBar_AutoFanye();
		CombatPlus_BGtongbao();
		CombatPlus_PetTishi();
		CombatPlus_Zhuizong();
		CombatPlus_Cailiao();
		CombatPlus_BuffTime();
		CombatPlus_TimeOpen();
		-------
		FramePlus_ExtFrame();
		FramePlus_CharacterFrame();
		FramePlus_yidongUI();
		-------
		UnitFrame_PlayerFrame();
		UnitFrame_TargetFrame();
		UnitFrame_PartyMemberFrame();
		--------
		ChatFrame_QuickChat();
		ChatFrame_Qita();
		-------------
		PigUI_ActionBar();
		PigUI_ChatFrame();
		---
		BagBank();
		-----
		Pig_Action();
		-----
		Classes_Assistant();
		-----
		AutoSellBuy_Repair();
		AutoSellBuy_SellBuy();
		-----
		Assistant_Skill_FB();
		-----带本助手
		FarmRecord();
		-----副本助手
		RaidRecord();
		-----技能监控
		Spell_CD_JK();
		-----时空之门
		PlaneInvite();
		---
		PIGRaidFrame()
		------------------------------
   		print("|cff00FFFF"..arg1.."载入成功，/pig或小地图按钮设置|r|cffFF0000(本插件完全免费,网络购物平台出售皆为骗子)。|r");
    end  
end)