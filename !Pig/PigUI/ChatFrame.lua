local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_6_UI
--=========================================================
--聊天窗口可以移动到屏幕边缘
local function ChatFrame_Bianju_Open()
	for i = 1, NUM_CHAT_WINDOWS do 
		_G["ChatFrame"..i]:SetClampRectInsets(-35, 0, 0, 0) --可拖动至紧贴屏幕边缘 
	end
end
---------------------
fuFrame.Bianju = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Bianju:SetSize(30,32);
fuFrame.Bianju:SetHitRectInsets(0,-120,0,0);
fuFrame.Bianju:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",10,-90);
fuFrame.Bianju.Text:SetText("移除聊天窗口的边距");
fuFrame.Bianju.tooltip = "移除聊天窗口的系统默认边距，使之可以移动到屏幕最边缘！";
fuFrame.Bianju:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ChatFrame']['Bianju']="ON";
		ChatFrame_Bianju_Open();
	else
		PIG['ChatFrame']['Bianju']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--=======================================
--1
fuFrame.kuang1F = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
fuFrame.kuang1F:SetBackdrop( {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 } 
});
fuFrame.kuang1F:SetBackdropColor(0, 0, 0, 0.6);
fuFrame.kuang1F:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
fuFrame.kuang1F:SetSize(fuFrame:GetWidth()-20, 94)
fuFrame.kuang1F:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 10, -128)
--========================================
local ChatFrame1_SetPoint_New = CreateFrame("Frame");
--动态设置主聊天窗口架宽度位置
local function ChatFrame_Width()
	fuFrame.ChatFrame_Point_Slider.Text:SetText(PIG['PigUI']['ChatFrame_Point_value']);
	fuFrame.ChatFrame_Point_Slider:SetValue(PIG['PigUI']['ChatFrame_Point_value']);
	if PIG['PigUI']['ChatFrame_Width']=="ON" then
		if PIG['PigUI']['ChatFrame_Point_value']<50 then
			for i = 1, NUM_CHAT_WINDOWS do 
				_G["ChatFrame"..i]:SetClampRectInsets(-35, 0, 0, 0) --可拖动至紧贴屏幕边缘 
			end
			fuFrame.Bianju:SetChecked(true);
		end
		ChatFrame1:ClearAllPoints();
		ChatFrame1:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",32,PIG['PigUI']['ChatFrame_Point_value']);
		ChatFrame1:SetPoint("BOTTOMRIGHT",MainMenuBar,"BOTTOMLEFT",-2,PIG['PigUI']['ChatFrame_Point_value']);
		ChatFrame1_SetPoint_New:RegisterEvent("UI_SCALE_CHANGED");
		ChatFrame1_SetPoint_New:RegisterEvent("UPDATE_FACTION");--声望改变时
		ChatFrame1_SetPoint_New:RegisterEvent("PLAYER_LEVEL_UP");--玩家升级时
	end
	if PIG['PigUI']['ChatFrame_Width']=="ON" then
		fuFrame.ChatFrame_Width:SetChecked(true);
		fuFrame.ChatFrame_Point_Slider:Enable()	
		fuFrame.ChatFrame_Point_Slider.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Point_Slider.High:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Point_Slider.Text:SetTextColor(1, 1, 1, 1);
	elseif PIG['PigUI']['ChatFrame_Width']=="OFF" then
		fuFrame.ChatFrame_Width:SetChecked(false);
		fuFrame.ChatFrame_Point_Slider:Disable();
		fuFrame.ChatFrame_Point_Slider.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Point_Slider.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Point_Slider.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
	end
end

fuFrame.ChatFrame_Width = CreateFrame("CheckButton", nil, fuFrame.kuang1F, "ChatConfigCheckButtonTemplate");
fuFrame.ChatFrame_Width:SetSize(30,32);
fuFrame.ChatFrame_Width:SetHitRectInsets(0,-180,0,0);
fuFrame.ChatFrame_Width:SetPoint("TOPLEFT",fuFrame.kuang1F,"TOPLEFT",10,-10);
fuFrame.ChatFrame_Width.Text:SetText("自动设置主聊天窗口宽度/位置");
fuFrame.ChatFrame_Width.tooltip = "根据动作条左边空间自动调整主聊天窗口的宽度与位置！";
fuFrame.ChatFrame_Width:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['ChatFrame_Width']="ON";	
	else
		PIG['PigUI']['ChatFrame_Width']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ChatFrame_Width()
end);
--=--=======================================
--自动设置主聊天窗口高度
local function ChatFrame_Height()
	fuFrame.ChatFrame_Height_Slider.Text:SetText(PIG['PigUI']['ChatFrame_Height_value']);
	fuFrame.ChatFrame_Height_Slider:SetValue(PIG['PigUI']['ChatFrame_Height_value']);
	if PIG['PigUI']['ChatFrame_Height']=="ON" then
		ChatFrame1:SetHeight(PIG['PigUI']['ChatFrame_Height_value']);
		ChatFrame1_SetPoint_New:RegisterEvent("UI_SCALE_CHANGED");
		ChatFrame1_SetPoint_New:RegisterEvent("UPDATE_FACTION");--声望改变时
		ChatFrame1_SetPoint_New:RegisterEvent("PLAYER_LEVEL_UP");--玩家升级时
	end
	if PIG['PigUI']['ChatFrame_Height']=="ON" then
		fuFrame.ChatFrame_Height:SetChecked(true);
		fuFrame.ChatFrame_Height_Slider:Enable()	
		fuFrame.ChatFrame_Height_Slider.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Height_Slider.High:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Height_Slider.Text:SetTextColor(1, 1, 1, 1);
	elseif PIG['PigUI']['ChatFrame_Height']=="OFF" then
		fuFrame.ChatFrame_Height:SetChecked(false);
		fuFrame.ChatFrame_Height_Slider:Disable();
		fuFrame.ChatFrame_Height_Slider.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Height_Slider.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Height_Slider.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
	end
end
--=--=======================================
--主聊天窗口位置
fuFrame.ChatFrame_Point = fuFrame.kuang1F:CreateFontString();
fuFrame.ChatFrame_Point:SetPoint("TOPLEFT",fuFrame.kuang1F,"TOPLEFT",280,-18);
fuFrame.ChatFrame_Point:SetFontObject(GameFontNormal);
fuFrame.ChatFrame_Point:SetTextColor(1, 1, 1, 1);
fuFrame.ChatFrame_Point:SetText('距屏幕底部距离:');
--------
fuFrame.ChatFrame_Point_Slider = CreateFrame("Slider", nil, fuFrame.kuang1F, "OptionsSliderTemplate")
fuFrame.ChatFrame_Point_Slider:SetWidth(140)
fuFrame.ChatFrame_Point_Slider:SetHeight(15)
fuFrame.ChatFrame_Point_Slider:SetPoint("LEFT",fuFrame.ChatFrame_Point,"RIGHT",6,0);
fuFrame.ChatFrame_Point_Slider:Show()
fuFrame.ChatFrame_Point_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.ChatFrame_Point_Slider:SetMinMaxValues(0, 500);
fuFrame.ChatFrame_Point_Slider:SetValueStep(1);
fuFrame.ChatFrame_Point_Slider:SetObeyStepOnDrag(true);
--fuFrame.ChatFrame_Point_Slider:SetValue(10);
fuFrame.ChatFrame_Point_Slider.Low:SetText('0');
fuFrame.ChatFrame_Point_Slider.High:SetText('500');
--fuFrame.ChatFrame_Point_Slider.Text:SetText('10');
--启用鼠标滚轮调整
fuFrame.ChatFrame_Point_Slider:EnableMouseWheel(true);
fuFrame.ChatFrame_Point_Slider:SetScript("OnMouseWheel", function(self, arg1)
	if fuFrame.ChatFrame_Point_Slider:IsEnabled() then
		local step = 1 * arg1
		local value = self:GetValue()
		if step > 0 then
			self:SetValue(min(value + step, 500))
		else
			self:SetValue(max(value + step, 0))
		end
	end
end)
fuFrame.ChatFrame_Point_Slider:SetScript('OnValueChanged', function(self)
	local valxxx = self:GetValue()
	PIG['PigUI']['ChatFrame_Point_value']=valxxx;
	ChatFrame_Width()
end)
--------
ChatFrame1_SetPoint_New:SetScript("OnEvent",function()
	if PIG['PigUI']['ChatFrame_Width']=="ON" then ChatFrame_Width() end
	if PIG['PigUI']['ChatFrame_Height']=="ON" then ChatFrame_Height() end
end)
-----------------------------------
fuFrame.ChatFrame_Height = CreateFrame("CheckButton", nil, fuFrame.kuang1F, "ChatConfigCheckButtonTemplate");
fuFrame.ChatFrame_Height:SetSize(30,32);
fuFrame.ChatFrame_Height:SetHitRectInsets(0,-100,0,0);
fuFrame.ChatFrame_Height:SetPoint("TOPLEFT",fuFrame.kuang1F,"TOPLEFT",10,-50);
fuFrame.ChatFrame_Height.Text:SetText("主聊天窗口高度:");
fuFrame.ChatFrame_Height.tooltip = "开启后自动设置主聊天窗口高度为设定值！";
fuFrame.ChatFrame_Height:SetScript("OnClick", function ()
	local Booleans=fuFrame.ChatFrame_Height:GetChecked();
	if Booleans then
		PIG['PigUI']['ChatFrame_Height']="ON";
	else
		PIG['PigUI']['ChatFrame_Height']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ChatFrame_Height()
end);
-----------------------------------
fuFrame.ChatFrame_Height_Slider = CreateFrame("Slider", nil, fuFrame.kuang1F, "OptionsSliderTemplate")
fuFrame.ChatFrame_Height_Slider:SetWidth(140)
fuFrame.ChatFrame_Height_Slider:SetHeight(15)
fuFrame.ChatFrame_Height_Slider:SetPoint("LEFT",fuFrame.ChatFrame_Height.Text,"RIGHT",6,0);
fuFrame.ChatFrame_Height_Slider:Show()
fuFrame.ChatFrame_Height_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.ChatFrame_Height_Slider:SetMinMaxValues(100, 500);
fuFrame.ChatFrame_Height_Slider:SetValueStep(1);
fuFrame.ChatFrame_Height_Slider:SetObeyStepOnDrag(true);
fuFrame.ChatFrame_Height_Slider:SetValue(120);
fuFrame.ChatFrame_Height_Slider.Low:SetText('100');
fuFrame.ChatFrame_Height_Slider.High:SetText('500');
fuFrame.ChatFrame_Height_Slider.Text:SetText('120');
--启用鼠标滚轮调整
fuFrame.ChatFrame_Height_Slider:EnableMouseWheel(true);
fuFrame.ChatFrame_Height_Slider:SetScript("OnMouseWheel", function(self, arg1)
	if fuFrame.ChatFrame_Height_Slider:IsEnabled() then
		local step = 1 * arg1
		local value = self:GetValue()
		if step > 0 then
			self:SetValue(min(value + step, 500))
		else
			self:SetValue(max(value + step, 100))
		end
	end
end)
fuFrame.ChatFrame_Height_Slider:SetScript('OnValueChanged', function(self)
	local valxxx = self:GetValue()
	PIG['PigUI']['ChatFrame_Height_value']=valxxx;
	ChatFrame_Height();
end)

--=======================================
--LOOT
fuFrame.fangkuang2F = CreateFrame("Frame", "fuFrame.fangkuang2F", fuFrame,"BackdropTemplate")
fuFrame.fangkuang2F:SetBackdrop( {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 } 
});
fuFrame.fangkuang2F:SetBackdropColor(0, 0, 0, 0.6);
fuFrame.fangkuang2F:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
fuFrame.fangkuang2F:SetSize(fuFrame:GetWidth()-20, 130)
fuFrame.fangkuang2F:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 10, -270)
--================================================
--FCF_ResetChatWindows();--恢复聊天设置为默认
--FCF_ResetChatWindows(); -- 重置聊天设置
--FCF_SetLocked(_G.ChatFrame1, 1) --锁定聊天窗口移动
--FCF_DockFrame(_G.ChatFrame2,3)  --设置窗口是否停靠参数2为停靠位置
--FCF_UnDockFrame(_G["ChatFrame"..NewWindow_ID]); --分离窗口
--FCF_NewChatWindow('拾取/其他')--用户手动创建新窗口
--FCF_OpenNewWindow('拾取/其他');--创建聊天窗口 
--FCF_SetWindowName(_G.ChatFrame2, "记录");
-------
-- StaticPopupDialogs["OFF_LOOTFRAME"] = {
-- 	text = "关闭后请在屏幕中间手动移除拾取聊天栏，确定关闭吗？",
-- 	button1 = "确定",
-- 	button2 = "取消",
-- 	OnAccept = function()
-- 		for id=1,NUM_CHAT_WINDOWS,1 do
-- 			local name, __ = GetChatWindowInfo(id);
-- 			if name=='拾取/其他' then
-- 				FCF_UnDockFrame(_G["ChatFrame"..id]); --分离窗口
-- 				_G["ChatFrame"..id]:ClearAllPoints();
-- 				_G["ChatFrame"..id]:SetPoint("CENTER",UIParent,"CENTER",0,0);
-- 				_G["ChatFrame"..id.."Tab"]:ClearAllPoints();
-- 				_G["ChatFrame"..id.."Tab"]:SetPoint('BOTTOMLEFT', _G["ChatFrame"..id.."Background"], 'TOPLEFT', 2, 0);
-- 				FCF_UpdateButtonSide(_G["ChatFrame"..id]);--刷新按钮位置
-- 				break
-- 			end
-- 		end
-- 		PIG['PigUI']['ChatFrame_Loot']="OFF";
-- 		fuFrame.Loot:SetChecked(false);
-- 		Pig_Options_RLtishi_UI:Show()
-- 	end,
-- 	timeout = 0,
-- 	whileDead = true,
-- 	hideOnEscape = true,
-- }
--动态设置拾取窗口宽度
local function ChatFame_LOOT_Width()
	if PIG['PigUI']['ChatFrame_Loot_Width']=="ON" then
		fuFrame.Loot_Width:SetChecked(true);
		fuFrame.Loot_Point_Slider:Enable()	
		fuFrame.Loot_Point_Slider.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.Loot_Point_Slider.High:SetTextColor(1, 1, 1, 1);
		fuFrame.Loot_Point_Slider.Text:SetTextColor(1, 1, 1, 1);
	elseif PIG['PigUI']['ChatFrame_Loot_Width']=="OFF" then
		fuFrame.Loot_Width:SetChecked(false);
		fuFrame.Loot_Point_Slider:Disable();
		fuFrame.Loot_Point_Slider.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.Loot_Point_Slider.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.Loot_Point_Slider.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
	end
	fuFrame.Loot_Point_Slider.Text:SetText(PIG['PigUI']['ChatFrame_Loot_Point_value']);
	fuFrame.Loot_Point_Slider:SetValue(PIG['PigUI']['ChatFrame_Loot_Point_value']);

	if PIG['PigUI']["ChatFrame_Loot"] == "ON" then
		fuFrame.Loot_Width:Enable()
		if PIG['PigUI']['ChatFrame_Loot_Width']=="ON" then
			if PIG['PigUI']['ChatFrame_Loot_Point_value']<50 then
				for i = 1, NUM_CHAT_WINDOWS do 
					_G["ChatFrame"..i]:SetClampRectInsets(-35, 0, 0, 0) --可拖动至紧贴屏幕边缘 
				end
				fuFrame.Bianju:SetChecked(true);
			end
			for id=1,NUM_CHAT_WINDOWS,1 do
				local name, __ = GetChatWindowInfo(id);
				if name=='拾取/其他' then
					FCF_UnDockFrame(_G["ChatFrame"..id]);
					_G["ChatFrame"..id]:ClearAllPoints();
					_G["ChatFrame"..id]:SetPoint("BOTTOMLEFT",MainMenuBar,"BOTTOMRIGHT",8,PIG['PigUI']['ChatFrame_Loot_Point_value']);
					_G["ChatFrame"..id]:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",-32,PIG['PigUI']['ChatFrame_Loot_Point_value']);
					_G["ChatFrame"..id.."Tab"]:ClearAllPoints();
					_G["ChatFrame"..id.."Tab"]:SetPoint('BOTTOMLEFT', _G["ChatFrame"..id.."Background"], 'TOPLEFT', 2, 0);
					FCF_UpdateButtonSide(_G["ChatFrame"..id]);--刷新按钮位置
					break
				end
			end
		end
	else
		fuFrame.Loot_Width:Disable()
	end
end

--自动设置拾取窗口高度
local function ChatFame_LOOT_Heigh()
	if PIG['PigUI']['ChatFrame_Loot_Height']=="ON" then
		fuFrame.Loot_Height:SetChecked(true);
	elseif PIG['PigUI']['ChatFrame_Loot_Height']=="OFF" then
		fuFrame.Loot_Height:SetChecked(false);
	end
	if PIG['PigUI']['ChatFrame_Loot']=="ON" then
		fuFrame.Loot_Height:Enable();
	elseif PIG['PigUI']['ChatFrame_Loot']=="OFF" then
		fuFrame.Loot_Height:Disable();
	end
	fuFrame.Loot_Height_Slider.Text:SetText(PIG['PigUI']['ChatFrame_Loot_Height_value']);
	fuFrame.Loot_Height_Slider:SetValue(PIG['PigUI']['ChatFrame_Loot_Height_value']);
	if PIG['PigUI']['ChatFrame_Loot_Height']=="ON" and PIG['PigUI']["ChatFrame_Loot"] == "ON" then
		fuFrame.Loot_Height_Slider:Enable();
		fuFrame.Loot_Height_Slider.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.Loot_Height_Slider.High:SetTextColor(1, 1, 1, 1);
		fuFrame.Loot_Height_Slider.Text:SetTextColor(1, 1, 1, 1);
		for id=1,NUM_CHAT_WINDOWS,1 do
			local name, __ = GetChatWindowInfo(id);
			if name=='拾取/其他' then
				_G["ChatFrame"..id]:SetHeight(PIG['PigUI']['ChatFrame_Loot_Height_value']);
				FCF_UpdateButtonSide(_G["ChatFrame"..id]);--刷新按钮位置
				break
			end
		end
	else
		fuFrame.Loot_Height_Slider:Disable();
		fuFrame.Loot_Height_Slider.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.Loot_Height_Slider.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.Loot_Height_Slider.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
	end
end
--重设窗口显示内容
local function chongshepindaoneirong()
	if PIG['PigUI']['xianshiNeirong']=="ON" then
		fuFrame.xianshiNeirong:SetChecked(true);
	elseif PIG['PigUI']['xianshiNeirong']=="OFF" then
		fuFrame.xianshiNeirong:SetChecked(false);
	end	
	if PIG['PigUI']['ChatFrame_Loot']=="ON" then
		fuFrame.xianshiNeirong:Enable();
	elseif PIG['PigUI']['ChatFrame_Loot']=="OFF" then
		fuFrame.xianshiNeirong:Disable();
	end
	--综合
	if PIG['PigUI']['ChatFrame_Loot']=="ON" and PIG['PigUI']['xianshiNeirong']=="ON" then
		local chatGroup1 = { 'SYSTEM', 'CHANNEL', 'SAY', 'EMOTE', 'YELL', 'WHISPER', 'PARTY', 'PARTY_LEADER', 'RAID', 'RAID_LEADER', 'RAID_WARNING', 'INSTANCE_CHAT', 'INSTANCE_CHAT_LEADER', 'GUILD', 'OFFICER', 'MONSTER_SAY', 'MONSTER_YELL', 'MONSTER_EMOTE', 'MONSTER_WHISPER', 'MONSTER_BOSS_EMOTE', 'MONSTER_BOSS_WHISPER', 'ERRORS', 'AFK', 'DND', 'IGNORED', 'BG_HORDE', 'BG_ALLIANCE', 'BG_NEUTRAL', 'ACHIEVEMENT', 'GUILD_ACHIEVEMENT', 'BN_WHISPER', 'BN_INLINE_TOAST_ALERT','TARGETICONS' }
		ChatFrame_RemoveAllMessageGroups(DEFAULT_CHAT_FRAME)
		for _, v in ipairs(chatGroup1) do
			ChatFrame_AddMessageGroup(DEFAULT_CHAT_FRAME, v)
		end
		--拾取窗口
		local chatGroup3 = { 'COMBAT_XP_GAIN', 'COMBAT_HONOR_GAIN', 'COMBAT_FACTION_CHANGE', 'SKILL', 'MONEY', 'LOOT', 'TRADESKILLS', 'OPENING', 'PET_INFO', 'COMBAT_MISC_INFO' }
		for id=1,NUM_CHAT_WINDOWS,1 do
			local name, __ = GetChatWindowInfo(id);
			if name=='拾取/其他' then
				ChatFrame_RemoveAllMessageGroups(_G["ChatFrame"..id])
				for _, v in ipairs(chatGroup3) do
					ChatFrame_AddMessageGroup(_G["ChatFrame"..id], v)
				end
				break
			end
		end
		for id=1,NUM_CHAT_WINDOWS,1 do
			local name, __ = GetChatWindowInfo(id);
			if name=='战斗记录' then
				FCF_SetWindowName(_G["ChatFrame"..id], "记录");
				break
			end
		end
	end
end
--创建拾取聊天窗口
local function ChatFame_LOOT()
	if GetScreenWidth()>1024 then
		if FCF_GetNumActiveChatFrames()<10 then
			local LOOT_FAME=true;
			if NUM_CHAT_WINDOWS~=nil then
				for id=1,NUM_CHAT_WINDOWS,1 do
					local name, __ = GetChatWindowInfo(id);
					if name=='拾取/其他' then
						LOOT_FAME=false;
						PIG['PigUI']["ChatFrame_Loot"] = "ON";
						print('|cff00FFFF!Pig:|r|cffFFff00创建失败,已存在拾取窗口。|r');
						break
					end
				end
			end
			if LOOT_FAME then
				FCF_OpenNewWindow('拾取/其他');
				PIG['PigUI']["ChatFrame_Loot"] = "ON";
			end
		else
			PIG['PigUI']['ChatFrame_Loot']="OFF";
			print('|cff00FFFF!Pig:|r|cffFFff00创建失败！系统允许做大聊天窗口数：10，当前：'..FCF_GetNumActiveChatFrames()..'。|r');
		end
	else
		PIG['PigUI']['ChatFrame_Loot']="OFF";
		print('|cff00FFFF!Pig:|r|cffFFff00创建失败！当前屏幕分辨率过小。|r');
	end
	ChatFame_LOOT_Width()
	ChatFame_LOOT_Heigh()
	chongshepindaoneirong()
end
-------------
fuFrame.Loot = CreateFrame("Button", nil, fuFrame, "UIPanelButtonTemplate");
fuFrame.Loot:SetSize(160,24);
fuFrame.Loot:SetPoint("BOTTOMLEFT",fuFrame.fangkuang2F,"TOPLEFT",0,4);
fuFrame.Loot:SetText("创建独立拾取窗口");
fuFrame.Loot:SetScript("OnClick", function ()
	ChatFame_LOOT()
end)
--提示
fuFrame.Loot_tishi = CreateFrame("Frame", nil, fuFrame);
fuFrame.Loot_tishi:SetSize(30,30);
fuFrame.Loot_tishi:SetPoint("LEFT",fuFrame.Loot,"RIGHT",0,0);
fuFrame.Loot_tishi.Texture = fuFrame.Loot_tishi:CreateTexture(nil, "BORDER");
fuFrame.Loot_tishi.Texture:SetTexture("interface/common/help-i.blp");
fuFrame.Loot_tishi.Texture:SetAllPoints(fuFrame.Loot_tishi)
fuFrame.Loot_tishi:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(fuFrame.Loot_tishi, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("\124cff00ff00下方选项在创建独立拾取窗口后方可启用。不需要独立拾取窗口时请手动移除。\124r")
	GameTooltip:Show();
end);
fuFrame.Loot_tishi:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
--=====================================================
fuFrame.Loot_Width = CreateFrame("CheckButton", nil, fuFrame.fangkuang2F, "ChatConfigCheckButtonTemplate");
fuFrame.Loot_Width:SetSize(30,32);
fuFrame.Loot_Width:SetHitRectInsets(0,-150,0,0);
fuFrame.Loot_Width:SetPoint("TOPLEFT",fuFrame.fangkuang2F,"TOPLEFT",10,-10);
fuFrame.Loot_Width.Text:SetText("自动设置拾取窗口宽度/位置");
fuFrame.Loot_Width.tooltip = "分离拾取窗口，并根据动作条右边空间自动设置拾取聊天窗口宽度与位置！";
fuFrame.Loot_Width:SetScript("OnClick", function ()
	if fuFrame.Loot_Width:GetChecked() then
		PIG['PigUI']['ChatFrame_Loot_Width']="ON";	
	else
		PIG['PigUI']['ChatFrame_Loot_Width']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ChatFame_LOOT_Width();
end);
--=======================================
fuFrame.Loot_Height = CreateFrame("CheckButton", nil, fuFrame.fangkuang2F, "ChatConfigCheckButtonTemplate");
fuFrame.Loot_Height:SetSize(30,32);
fuFrame.Loot_Height:SetHitRectInsets(0,-100,0,0);
fuFrame.Loot_Height:SetPoint("TOPLEFT",fuFrame.fangkuang2F,"TOPLEFT",10,-50);
fuFrame.Loot_Height.Text:SetText("拾取窗口高度:");
fuFrame.Loot_Height.tooltip = "启用后自动设置拾取窗口高度为设定值。";
fuFrame.Loot_Height:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['ChatFrame_Loot_Height']="ON";
	else
		PIG['PigUI']['ChatFrame_Loot_Height']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ChatFame_LOOT_Heigh()
end);

-----------------------------------
fuFrame.Loot_Height_Slider = CreateFrame("Slider", nil, fuFrame.fangkuang2F, "OptionsSliderTemplate")
fuFrame.Loot_Height_Slider:SetWidth(140)
fuFrame.Loot_Height_Slider:SetHeight(15)
fuFrame.Loot_Height_Slider:SetPoint("LEFT",fuFrame.Loot_Height.Text,"RIGHT",6,0);
fuFrame.Loot_Height_Slider:Show()
fuFrame.Loot_Height_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.Loot_Height_Slider:SetMinMaxValues(100, 500);
fuFrame.Loot_Height_Slider:SetValueStep(1);
fuFrame.Loot_Height_Slider:SetObeyStepOnDrag(true);
fuFrame.Loot_Height_Slider.Low:SetText('100');
fuFrame.Loot_Height_Slider.High:SetText('500');
--启用鼠标滚轮调整
fuFrame.Loot_Height_Slider:EnableMouseWheel(true);
fuFrame.Loot_Height_Slider:SetScript("OnMouseWheel", function(self, arg1)
	if fuFrame.Loot_Height_Slider:IsEnabled() then
		local step = 1 * arg1
		local value = self:GetValue()
		if step > 0 then
			self:SetValue(min(value + step, 500))
		else
			self:SetValue(max(value + step, 100))
		end
	end
end)
fuFrame.Loot_Height_Slider:SetScript('OnValueChanged', function(self)
	if fuFrame.Loot_Height:GetChecked() then
		local Hval = self:GetValue()
		PIG['PigUI']['ChatFrame_Loot_Height_value']=Hval;
		ChatFame_LOOT_Heigh()
	end
end)
--=--=======================================
--主聊天窗口位置
fuFrame.Loot_Point = fuFrame.fangkuang2F:CreateFontString();
fuFrame.Loot_Point:SetPoint("TOPLEFT",fuFrame.fangkuang2F,"TOPLEFT",280,-18);
fuFrame.Loot_Point:SetFontObject(GameFontNormal);
fuFrame.Loot_Point:SetTextColor(1, 1, 1, 1);
fuFrame.Loot_Point:SetText('距屏幕底部距离:');
--------
fuFrame.Loot_Point_Slider = CreateFrame("Slider", nil, fuFrame.fangkuang2F, "OptionsSliderTemplate")
fuFrame.Loot_Point_Slider:SetWidth(140)
fuFrame.Loot_Point_Slider:SetHeight(15)
fuFrame.Loot_Point_Slider:SetPoint("LEFT",fuFrame.Loot_Point,"RIGHT",6,0);
fuFrame.Loot_Point_Slider:Show()
fuFrame.Loot_Point_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.Loot_Point_Slider:SetMinMaxValues(0, 500);
fuFrame.Loot_Point_Slider:SetValueStep(1);
fuFrame.Loot_Point_Slider:SetObeyStepOnDrag(true);
--fuFrame.Loot_Point_Slider:SetValue(10);
fuFrame.Loot_Point_Slider.Low:SetText('0');
fuFrame.Loot_Point_Slider.High:SetText('500');
--fuFrame.Loot_Point_Slider.Text:SetText('10');
--启用鼠标滚轮调整
fuFrame.Loot_Point_Slider:EnableMouseWheel(true);
fuFrame.Loot_Point_Slider:SetScript("OnMouseWheel", function(self, arg1)
	if fuFrame.Loot_Point_Slider:IsEnabled() then
		local step = 1 * arg1
		local value = self:GetValue()
		if step > 0 then
			self:SetValue(min(value + step, 500))
		else
			self:SetValue(max(value + step, 0))
		end
	end
end)
fuFrame.Loot_Point_Slider:SetScript('OnValueChanged', function(self)
	local valxxxx= self:GetValue()
	PIG['PigUI']['ChatFrame_Loot_Point_value']=valxxxx;
	ChatFame_LOOT_Width()
end)
--============================================================
fuFrame.xianshiNeirong = CreateFrame("CheckButton", nil, fuFrame.fangkuang2F, "ChatConfigCheckButtonTemplate");
fuFrame.xianshiNeirong:SetSize(30,32);
fuFrame.xianshiNeirong:SetHitRectInsets(0,-120,0,0);
fuFrame.xianshiNeirong:SetPoint("TOPLEFT",fuFrame.fangkuang2F,"TOPLEFT",10,-90);
fuFrame.xianshiNeirong.Text:SetText("重设窗口显示内容");
fuFrame.xianshiNeirong.tooltip = "启用独立拾取窗口后，建议打开此选项。\n重新设置窗口显示内容，综合频道将取消经验荣誉以及拾取信息的显示，拾取窗口添加拾取/经验/荣誉等的显示！\n修改战斗记录为记录以便缩短标签页长度。";
fuFrame.xianshiNeirong:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['xianshiNeirong']="ON";
	else
		PIG['PigUI']['xianshiNeirong']="OFF";
	end
	chongshepindaoneirong();
end);

---=======================================================
local function ChatFrame_LOOT_YN()
	if NUM_CHAT_WINDOWS~=nil then
		for id=1,NUM_CHAT_WINDOWS,1 do
			local name, __ = GetChatWindowInfo(id);
			if name=='拾取/其他' then
				--print(name)
				PIG['PigUI']["ChatFrame_Loot"] = "ON";
				break
			end
		end
	end
end
addonTable.PigUI_ChatFrame = function()
	if PIG['ChatFrame']['Bianju']=="ON" then
		fuFrame.Bianju:SetChecked(true);
		ChatFrame_Bianju_Open();
	end
	C_Timer.After(1, ChatFrame_Width);
	C_Timer.After(1, ChatFrame_Height);
	C_Timer.After(1, ChatFrame_LOOT_YN);
	C_Timer.After(1.6, ChatFame_LOOT_Width);
	C_Timer.After(1.6, ChatFame_LOOT_Heigh);
	C_Timer.After(1.2, chongshepindaoneirong);
end
----------------------------------------
---重置聊天设置
fuFrame.ReChatF = CreateFrame("Button", nil, fuFrame, "UIPanelButtonTemplate");
fuFrame.ReChatF:SetSize(180,28);
fuFrame.ReChatF:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",10,-404);
fuFrame.ReChatF:SetText("恢复系统默认聊天设置");
fuFrame.ReChatF:SetScript("OnClick", function ()
	FCF_ResetChatWindows();
	PIG['PigUI']["ChatFrame_Loot"] = "OFF";
end)