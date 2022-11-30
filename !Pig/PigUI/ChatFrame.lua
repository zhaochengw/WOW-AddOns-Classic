local _, addonTable = ...;
local fuFrame=List_R_F_1_6
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--=========================================================
fuFrame.kuang1F = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
fuFrame.kuang1F:SetBackdrop( {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 } 
});
fuFrame.kuang1F:SetBackdropColor(0, 0, 0, 0.6);
fuFrame.kuang1F:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
fuFrame.kuang1F:SetSize(fuFrame:GetWidth()-20, 94)
fuFrame.kuang1F:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 10, -158)
fuFrame.kuang1F.BIAOTI = fuFrame.kuang1F:CreateFontString();
fuFrame.kuang1F.BIAOTI:SetPoint("BOTTOMLEFT", fuFrame.kuang1F, "TOPLEFT", 6, 0);
fuFrame.kuang1F.BIAOTI:SetFontObject(GameFontNormal);
fuFrame.kuang1F.BIAOTI:SetText('主聊天窗口');
--========================================
--设置主聊天宽度
local function ChatFrame_Width()
	fuFrame.ChatFrame_Width_Slider.Text:SetText(PIG['PigUI']['ChatFrame_Width_value']);
	fuFrame.ChatFrame_Width_Slider:SetValue(PIG['PigUI']['ChatFrame_Width_value']);
	if PIG['PigUI']['ChatFrame_Width']=="ON" then
		ChatFrame1:SetWidth(PIG['PigUI']['ChatFrame_Width_value']);
		fuFrame.ChatFrame_Width:SetChecked(true);
		fuFrame.ChatFrame_Width_Slider:Enable()	
		fuFrame.ChatFrame_Width_Slider.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Width_Slider.High:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Width_Slider.Text:SetTextColor(1, 1, 1, 1);
	elseif PIG['PigUI']['ChatFrame_Width']=="OFF" then
		fuFrame.ChatFrame_Width:SetChecked(false);
		fuFrame.ChatFrame_Width_Slider:Disable();
		fuFrame.ChatFrame_Width_Slider.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Width_Slider.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Width_Slider.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
	end
end
fuFrame.ChatFrame_Width = ADD_Checkbutton(nil,fuFrame,-40,"TOPLEFT",fuFrame.kuang1F,"TOPLEFT",10,-10,"设置宽度","设置主聊天窗口的宽度！")
fuFrame.ChatFrame_Width:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['ChatFrame_Width']="ON";	
	else
		PIG['PigUI']['ChatFrame_Width']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ChatFrame_Width()
end);
local minw,maxw = 150,800
fuFrame.ChatFrame_Width_Slider = CreateFrame("Slider", nil, fuFrame.kuang1F, "OptionsSliderTemplate")
fuFrame.ChatFrame_Width_Slider:SetWidth(140)
fuFrame.ChatFrame_Width_Slider:SetHeight(15)
fuFrame.ChatFrame_Width_Slider:SetPoint("LEFT",fuFrame.ChatFrame_Width.Text,"RIGHT",6,0);
fuFrame.ChatFrame_Width_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.ChatFrame_Width_Slider:SetMinMaxValues(minw, maxw);
fuFrame.ChatFrame_Width_Slider:SetValueStep(1);
fuFrame.ChatFrame_Width_Slider:SetObeyStepOnDrag(true);
fuFrame.ChatFrame_Width_Slider.Low:SetText(minw);
fuFrame.ChatFrame_Width_Slider.High:SetText(maxw);
--启用鼠标滚轮调整
fuFrame.ChatFrame_Width_Slider:EnableMouseWheel(true);
fuFrame.ChatFrame_Width_Slider:SetScript("OnMouseWheel", function(self, arg1)
	if fuFrame.ChatFrame_Width_Slider:IsEnabled() then
		local sliderMin, sliderMax = self:GetMinMaxValues()
		local value = self:GetValue()
		if arg1 > 0 then
			self:SetValue(min(value + arg1, sliderMax))
		else
			self:SetValue(max(value + arg1, sliderMin))
		end
	end
end)
fuFrame.ChatFrame_Width_Slider:SetScript('OnValueChanged', function(self)
	local valxxx = self:GetValue()
	PIG['PigUI']['ChatFrame_Width_value']=valxxx;
	ChatFrame_Width()
end)
-----------------------------------
--设置主聊天窗口高度
local function ChatFrame_Height()
	fuFrame.ChatFrame_Height_Slider.Text:SetText(PIG['PigUI']['ChatFrame_Height_value']);
	fuFrame.ChatFrame_Height_Slider:SetValue(PIG['PigUI']['ChatFrame_Height_value']);
	if PIG['PigUI']['ChatFrame_Height']=="ON" then
		ChatFrame1:SetHeight(PIG['PigUI']['ChatFrame_Height_value']);
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
fuFrame.ChatFrame_Height = ADD_Checkbutton(nil,fuFrame,-40,"TOPLEFT",fuFrame.kuang1F,"TOPLEFT",280,-10,"设置高度","设置主聊天窗口高度！")
fuFrame.ChatFrame_Height:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['ChatFrame_Height']="ON";
	else
		PIG['PigUI']['ChatFrame_Height']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ChatFrame_Height()
end);
-----------------------------------
local minh,maxh = 120,500
fuFrame.ChatFrame_Height_Slider = CreateFrame("Slider", nil, fuFrame.kuang1F, "OptionsSliderTemplate")
fuFrame.ChatFrame_Height_Slider:SetWidth(140)
fuFrame.ChatFrame_Height_Slider:SetHeight(15)
fuFrame.ChatFrame_Height_Slider:SetPoint("LEFT",fuFrame.ChatFrame_Height.Text,"RIGHT",6,0);
fuFrame.ChatFrame_Height_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.ChatFrame_Height_Slider:SetMinMaxValues(minh, maxh);
fuFrame.ChatFrame_Height_Slider:SetValueStep(1);
fuFrame.ChatFrame_Height_Slider:SetObeyStepOnDrag(true);
fuFrame.ChatFrame_Height_Slider.Low:SetText(minh);
fuFrame.ChatFrame_Height_Slider.High:SetText(maxh);
fuFrame.ChatFrame_Height_Slider:EnableMouseWheel(true);
fuFrame.ChatFrame_Height_Slider:SetScript("OnMouseWheel", function(self, arg1)
	if fuFrame.ChatFrame_Height_Slider:IsEnabled() then
		local sliderMin, sliderMax = self:GetMinMaxValues()
		local value = self:GetValue()
		if arg1 > 0 then
			self:SetValue(min(value + arg1, sliderMax))
		else
			self:SetValue(max(value + arg1, sliderMin))
		end
	end
end)
fuFrame.ChatFrame_Height_Slider:SetScript('OnValueChanged', function(self)
	local valxxx = self:GetValue()
	PIG['PigUI']['ChatFrame_Height_value']=valxxx;
	ChatFrame_Height();
end)
--主聊天窗口X位置======================================
local function ChatFrame_Point_SetPoint()
	if fuFrame.ChatFrame_Point:GetChecked() then
		local XXX = PIG['PigUI']['ChatFrame_Point_X']
		local YYY = PIG['PigUI']['ChatFrame_Point_Y']
		if YYY<50 then
			for i = 1, NUM_CHAT_WINDOWS do 
				_G["ChatFrame"..i]:SetClampRectInsets(-35, 0, 0, 0) --可拖动至紧贴屏幕边缘 
			end
		end
		ChatFrame1:ClearAllPoints();
		ChatFrame1:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",XXX,YYY);
	end
end
local function ChatFrame_Point_X()
	local XXX = PIG['PigUI']['ChatFrame_Point_X']
	local YYY = PIG['PigUI']['ChatFrame_Point_Y']
	fuFrame.ChatFrame_Point_Slider_X.Text:SetText("X:"..XXX);
	fuFrame.ChatFrame_Point_Slider_X:SetValue(XXX);
	fuFrame.ChatFrame_Point_Slider_Y.Text:SetText("Y:"..YYY);
	fuFrame.ChatFrame_Point_Slider_Y:SetValue(YYY);
	if PIG['PigUI']['ChatFrame_Point']=="ON" then	
		fuFrame.ChatFrame_Point:SetChecked(true);
		fuFrame.ChatFrame_Point_Slider_X:Enable()	
		fuFrame.ChatFrame_Point_Slider_X.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Point_Slider_X.High:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Point_Slider_X.Text:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Point_Slider_Y:Enable()	
		fuFrame.ChatFrame_Point_Slider_Y.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Point_Slider_Y.High:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Point_Slider_Y.Text:SetTextColor(1, 1, 1, 1);
		ChatFrame_Point_SetPoint()
		C_Timer.After(2, ChatFrame_Point_SetPoint)
		C_Timer.After(4, ChatFrame_Point_SetPoint)
		C_Timer.After(6, ChatFrame_Point_SetPoint)
		C_Timer.After(8, ChatFrame_Point_SetPoint)
		C_Timer.After(10, ChatFrame_Point_SetPoint)
		C_Timer.After(12, ChatFrame_Point_SetPoint)
	elseif PIG['PigUI']['ChatFrame_Point']=="OFF" then
		fuFrame.ChatFrame_Point:SetChecked(false);
		fuFrame.ChatFrame_Point_Slider_X:Disable();
		fuFrame.ChatFrame_Point_Slider_X.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Point_Slider_X.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Point_Slider_X.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Point_Slider_Y:Disable();
		fuFrame.ChatFrame_Point_Slider_Y.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Point_Slider_Y.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Point_Slider_Y.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
	end
end
fuFrame.ChatFrame_Point = ADD_Checkbutton(nil,fuFrame,-40,"TOPLEFT",fuFrame.kuang1F,"TOPLEFT",10,-56,"设置位置","设置主聊天窗口位置")
fuFrame.ChatFrame_Point:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['ChatFrame_Point']="ON";
	else
		PIG['PigUI']['ChatFrame_Point']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ChatFrame_Point_X()
end);
local minX,maxX = 35,500
fuFrame.ChatFrame_Point_Slider_X = CreateFrame("Slider", nil, fuFrame.kuang1F, "OptionsSliderTemplate")
fuFrame.ChatFrame_Point_Slider_X:SetWidth(140)
fuFrame.ChatFrame_Point_Slider_X:SetHeight(15)
fuFrame.ChatFrame_Point_Slider_X:SetPoint("LEFT",fuFrame.ChatFrame_Point.Text,"RIGHT",8,0);
fuFrame.ChatFrame_Point_Slider_X.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.ChatFrame_Point_Slider_X:SetMinMaxValues(minX, maxX);
fuFrame.ChatFrame_Point_Slider_X:SetValueStep(1);
fuFrame.ChatFrame_Point_Slider_X:SetObeyStepOnDrag(true);
fuFrame.ChatFrame_Point_Slider_X.Low:SetText(minX);
fuFrame.ChatFrame_Point_Slider_X.High:SetText(maxX);
fuFrame.ChatFrame_Point_Slider_X:EnableMouseWheel(true);
fuFrame.ChatFrame_Point_Slider_X:SetScript("OnMouseWheel", function(self, arg1)
	if self:IsEnabled() then
		local sliderMin, sliderMax = self:GetMinMaxValues()
		local value = self:GetValue()
		if arg1 > 0 then
			self:SetValue(min(value + arg1, sliderMax))
		else
			self:SetValue(max(value + arg1, sliderMin))
		end
	end
end)
fuFrame.ChatFrame_Point_Slider_X:SetScript('OnValueChanged', function(self)
	local valxxx = self:GetValue()
	PIG['PigUI']['ChatFrame_Point_X']=valxxx;
	ChatFrame_Point_SetPoint()
end)
local minY,maxY = 0,500
fuFrame.ChatFrame_Point_Slider_Y = CreateFrame("Slider", nil, fuFrame.kuang1F, "OptionsSliderTemplate")
fuFrame.ChatFrame_Point_Slider_Y:SetWidth(140)
fuFrame.ChatFrame_Point_Slider_Y:SetHeight(15)
fuFrame.ChatFrame_Point_Slider_Y:SetPoint("LEFT",fuFrame.ChatFrame_Point_Slider_X,"RIGHT",48,0);
fuFrame.ChatFrame_Point_Slider_Y.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.ChatFrame_Point_Slider_Y:SetMinMaxValues(minY, maxY);
fuFrame.ChatFrame_Point_Slider_Y:SetValueStep(1);
fuFrame.ChatFrame_Point_Slider_Y:SetObeyStepOnDrag(true);
fuFrame.ChatFrame_Point_Slider_Y.Low:SetText(minY);
fuFrame.ChatFrame_Point_Slider_Y.High:SetText(maxY);
fuFrame.ChatFrame_Point_Slider_Y:EnableMouseWheel(true);
fuFrame.ChatFrame_Point_Slider_Y:SetScript("OnMouseWheel", function(self, arg1)
	if self:IsEnabled() then
		local sliderMin, sliderMax = self:GetMinMaxValues()
		local value = self:GetValue()
		if arg1 > 0 then
			self:SetValue(min(value + arg1, sliderMax))
		else
			self:SetValue(max(value + arg1, sliderMin))
		end
	end
end)
fuFrame.ChatFrame_Point_Slider_Y:SetScript('OnValueChanged', function(self)
	local valxxx = self:GetValue()
	PIG['PigUI']['ChatFrame_Point_Y']=valxxx;
	ChatFrame_Point_X()
end)
--LOOT=======================================
fuFrame.fangkuang2F = CreateFrame("Frame", "fuFrame.fangkuang2F", fuFrame,"BackdropTemplate")
fuFrame.fangkuang2F:SetBackdrop( {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 } 
});
fuFrame.fangkuang2F:SetBackdropColor(0, 0, 0, 0.6);
fuFrame.fangkuang2F:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
fuFrame.fangkuang2F:SetSize(fuFrame:GetWidth()-20, 134)
fuFrame.fangkuang2F:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 10, -296)
--================================================
--FCF_ResetChatWindows();--恢复聊天设置为默认
--FCF_ResetChatWindows(); -- 重置聊天设置
--FCF_SetLocked(_G.ChatFrame1, 1) --锁定聊天窗口移动
--FCF_DockFrame(_G.ChatFrame2,3)  --设置窗口是否停靠参数2为停靠位置
--FCF_UnDockFrame(_G["ChatFrame"..NewWindow_ID]); --分离窗口
--FCF_NewChatWindow('拾取/其他')--用户手动创建新窗口
--FCF_OpenNewWindow('拾取/其他');--创建聊天窗口 
--FCF_SetWindowName(_G.ChatFrame2, "记录");
--FCF_UpdateButtonSide(_G["ChatFrame"..id]);--刷新按钮位置
--设置拾取窗口宽度------------------------
local function ChatFame_LOOT_Width()
	fuFrame.ChatFrame_Loot_Slider_Width.Text:SetText(PIG['PigUI']['ChatFrame_Loot_Width_value']);
	fuFrame.ChatFrame_Loot_Slider_Width:SetValue(PIG['PigUI']['ChatFrame_Loot_Width_value']);
	if PIG['PigUI']['ChatFrame_Loot_Width']=="ON" then
		fuFrame.Loot_Width:SetChecked(true);
		fuFrame.ChatFrame_Loot_Slider_Width:Enable()	
		fuFrame.ChatFrame_Loot_Slider_Width.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Loot_Slider_Width.High:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_Loot_Slider_Width.Text:SetTextColor(1, 1, 1, 1);
	elseif PIG['PigUI']['ChatFrame_Loot_Width']=="OFF" then
		fuFrame.Loot_Width:SetChecked(false);
		fuFrame.ChatFrame_Loot_Slider_Width:Disable();
		fuFrame.ChatFrame_Loot_Slider_Width.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Loot_Slider_Width.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_Loot_Slider_Width.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
	end
	if PIG['PigUI']["ChatFrame_Loot"] == "ON" then
		fuFrame.Loot_Width:Enable()
		if PIG['PigUI']['ChatFrame_Loot_Width']=="ON" then
			if PIG['PigUI']['ChatFrame_Loot_Width_value']<50 then
				for i = 1, NUM_CHAT_WINDOWS do 
					_G["ChatFrame"..i]:SetClampRectInsets(-35, 0, 0, 0) --可拖动至紧贴屏幕边缘 
				end
			end
			for id=1,NUM_CHAT_WINDOWS,1 do
				local name, __ = GetChatWindowInfo(id);
				if name=='拾取/其他' then
					FCF_UnDockFrame(_G["ChatFrame"..id]);
					_G["ChatFrame"..id]:SetWidth(PIG['PigUI']['ChatFrame_Loot_Width_value']);
					FCF_UpdateButtonSide(_G["ChatFrame"..id]);
					break
				end
			end
		end
	else
		fuFrame.Loot_Width:Disable()
	end
end
fuFrame.Loot_Width = ADD_Checkbutton(nil,fuFrame,-40,"TOPLEFT",fuFrame.fangkuang2F,"TOPLEFT",10,-10,"设置宽度","设置拾取聊天窗口宽度！")
fuFrame.Loot_Width:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['ChatFrame_Loot_Width']="ON";	
	else
		PIG['PigUI']['ChatFrame_Loot_Width']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ChatFame_LOOT_Width();
end);
local minLootW,maxLootW = 150,800
fuFrame.ChatFrame_Loot_Slider_Width = CreateFrame("Slider", nil, fuFrame.Loot_Width, "OptionsSliderTemplate")
fuFrame.ChatFrame_Loot_Slider_Width:SetWidth(140)
fuFrame.ChatFrame_Loot_Slider_Width:SetHeight(15)
fuFrame.ChatFrame_Loot_Slider_Width:SetPoint("LEFT",fuFrame.Loot_Width.Text,"RIGHT",8,0);
fuFrame.ChatFrame_Loot_Slider_Width.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.ChatFrame_Loot_Slider_Width:SetMinMaxValues(minLootW, maxLootW);
fuFrame.ChatFrame_Loot_Slider_Width:SetValueStep(1);
fuFrame.ChatFrame_Loot_Slider_Width:SetObeyStepOnDrag(true);
fuFrame.ChatFrame_Loot_Slider_Width.Low:SetText(minLootW);
fuFrame.ChatFrame_Loot_Slider_Width.High:SetText(maxLootW);
fuFrame.ChatFrame_Loot_Slider_Width:EnableMouseWheel(true);
fuFrame.ChatFrame_Loot_Slider_Width:SetScript("OnMouseWheel", function(self, arg1)
	if self:IsEnabled() then
		local sliderMin, sliderMax = self:GetMinMaxValues()
		local value = self:GetValue()
		if arg1 > 0 then
			self:SetValue(min(value + arg1, sliderMax))
		else
			self:SetValue(max(value + arg1, sliderMin))
		end
	end
end)
fuFrame.ChatFrame_Loot_Slider_Width:SetScript('OnValueChanged', function(self)
	local valxxx = self:GetValue()
	PIG['PigUI']['ChatFrame_Loot_Width_value']=valxxx;
	ChatFame_LOOT_Width()
end)

--自动设置拾取窗口高度----------
local function ChatFame_LOOT_Heigh()
	fuFrame.Loot_Height_Slider.Text:SetText(PIG['PigUI']['ChatFrame_Loot_Height_value']);
	fuFrame.Loot_Height_Slider:SetValue(PIG['PigUI']['ChatFrame_Loot_Height_value']);
	if PIG['PigUI']['ChatFrame_Loot_Height']=="ON" then
		fuFrame.Loot_Height:SetChecked(true);
		fuFrame.Loot_Height_Slider:Enable();
		fuFrame.Loot_Height_Slider.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.Loot_Height_Slider.High:SetTextColor(1, 1, 1, 1);
		fuFrame.Loot_Height_Slider.Text:SetTextColor(1, 1, 1, 1);
	elseif PIG['PigUI']['ChatFrame_Loot_Height']=="OFF" then
		fuFrame.Loot_Height:SetChecked(false);
			fuFrame.Loot_Height_Slider:Disable();
		fuFrame.Loot_Height_Slider.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.Loot_Height_Slider.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.Loot_Height_Slider.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
	end
	if PIG['PigUI']['ChatFrame_Loot']=="ON" then
		fuFrame.Loot_Height:Enable();
		if PIG['PigUI']['ChatFrame_Loot_Height']=="ON" then
			for id=1,NUM_CHAT_WINDOWS,1 do
				local name, __ = GetChatWindowInfo(id);
				if name=='拾取/其他' then
					FCF_UnDockFrame(_G["ChatFrame"..id]);
					_G["ChatFrame"..id]:SetHeight(PIG['PigUI']['ChatFrame_Loot_Height_value']);
					FCF_UpdateButtonSide(_G["ChatFrame"..id]);
					break
				end
			end
		end
	else
		fuFrame.Loot_Height:Disable();
	end
end
fuFrame.Loot_Height = ADD_Checkbutton(nil,fuFrame,-40,"TOPLEFT",fuFrame.fangkuang2F,"TOPLEFT",280,-10,"窗口高度:","设置拾取窗口高度为设定值。")
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
local minLootH,maxLootH = 120,500
fuFrame.Loot_Height_Slider = CreateFrame("Slider", nil, fuFrame.fangkuang2F, "OptionsSliderTemplate")
fuFrame.Loot_Height_Slider:SetWidth(140)
fuFrame.Loot_Height_Slider:SetHeight(15)
fuFrame.Loot_Height_Slider:SetPoint("LEFT",fuFrame.Loot_Height.Text,"RIGHT",6,0);
fuFrame.Loot_Height_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.Loot_Height_Slider:SetMinMaxValues(minLootH, maxLootH);
fuFrame.Loot_Height_Slider:SetValueStep(1);
fuFrame.Loot_Height_Slider:SetObeyStepOnDrag(true);
fuFrame.Loot_Height_Slider.Low:SetText(minLootH);
fuFrame.Loot_Height_Slider.High:SetText(maxLootH);
fuFrame.Loot_Height_Slider:EnableMouseWheel(true);
fuFrame.Loot_Height_Slider:SetScript("OnMouseWheel", function(self, arg1)
	if self:IsEnabled() then
		local sliderMin, sliderMax = self:GetMinMaxValues()
		local value = self:GetValue()
		if arg1 > 0 then
			self:SetValue(min(value + arg1, sliderMax))
		else
			self:SetValue(max(value + arg1, sliderMin))
		end
	end
end)
fuFrame.Loot_Height_Slider:SetScript('OnValueChanged', function(self)
	local Hval = self:GetValue()
	PIG['PigUI']['ChatFrame_Loot_Height_value']=Hval;
	ChatFame_LOOT_Heigh()
end)

-- --拾取窗口位置
local function ChatFame_LOOT_Point_X()
	fuFrame.ChatFrame_LOOT_Point_Slider_X.Text:SetText("X:"..PIG['PigUI']['ChatFrame_Loot_Point_X']);
	fuFrame.ChatFrame_LOOT_Point_Slider_X:SetValue(PIG['PigUI']['ChatFrame_Loot_Point_X']);
	fuFrame.ChatFrame_LOOT_Point_Slider_Y.Text:SetText("Y:"..PIG['PigUI']['ChatFrame_Loot_Point_Y']);
	fuFrame.ChatFrame_LOOT_Point_Slider_Y:SetValue(PIG['PigUI']['ChatFrame_Loot_Point_Y']);
	if PIG['PigUI']['ChatFrame_Loot_Point']=="ON" then
		fuFrame.ChatFrame_LOOT_Point:SetChecked(true);
		fuFrame.ChatFrame_LOOT_Point_Slider_X:Enable()	
		fuFrame.ChatFrame_LOOT_Point_Slider_X.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_LOOT_Point_Slider_X.High:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_LOOT_Point_Slider_X.Text:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_LOOT_Point_Slider_Y:Enable()	
		fuFrame.ChatFrame_LOOT_Point_Slider_Y.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_LOOT_Point_Slider_Y.High:SetTextColor(1, 1, 1, 1);
		fuFrame.ChatFrame_LOOT_Point_Slider_Y.Text:SetTextColor(1, 1, 1, 1);
	elseif PIG['PigUI']['ChatFrame_Loot_Point']=="OFF" then
		fuFrame.ChatFrame_LOOT_Point:SetChecked(false);
		fuFrame.ChatFrame_LOOT_Point_Slider_X:Disable();
		fuFrame.ChatFrame_LOOT_Point_Slider_X.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_LOOT_Point_Slider_X.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_LOOT_Point_Slider_X.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_LOOT_Point_Slider_Y:Disable();
		fuFrame.ChatFrame_LOOT_Point_Slider_Y.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_LOOT_Point_Slider_Y.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ChatFrame_LOOT_Point_Slider_Y.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
	end
	if PIG['PigUI']['ChatFrame_Loot']=="ON" then
		fuFrame.ChatFrame_LOOT_Point:Enable();
		if PIG['PigUI']['ChatFrame_Loot_Point']=="ON" then
			for id=1,NUM_CHAT_WINDOWS,1 do
				local name, __ = GetChatWindowInfo(id);
				if name=='拾取/其他' then
					if PIG['PigUI']['ChatFrame_Loot_Point_Y']<50 then
						for i = 1, NUM_CHAT_WINDOWS do 
							_G["ChatFrame"..i]:SetClampRectInsets(-35, 0, 0, 0) --可拖动至紧贴屏幕边缘 
						end
					end
					FCF_UnDockFrame(_G["ChatFrame"..id]);
					_G["ChatFrame"..id]:ClearAllPoints();
					_G["ChatFrame"..id]:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",-PIG['PigUI']['ChatFrame_Loot_Point_X'],PIG['PigUI']['ChatFrame_Loot_Point_Y']);
					_G["ChatFrame"..id.."Tab"]:ClearAllPoints();
					_G["ChatFrame"..id.."Tab"]:SetPoint('BOTTOMLEFT', _G["ChatFrame"..id.."Background"], 'TOPLEFT', 2, 0);
					FCF_UpdateButtonSide(_G["ChatFrame"..id]);--刷新按钮位置
				end
			end
		end
	else
		fuFrame.ChatFrame_LOOT_Point:Disable();
	end
end
fuFrame.ChatFrame_LOOT_Point = ADD_Checkbutton(nil,fuFrame,-40,"TOPLEFT",fuFrame.fangkuang2F,"TOPLEFT",10,-56,"设置位置","设置主聊天窗口位置")
fuFrame.ChatFrame_LOOT_Point:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['ChatFrame_Loot_Point']="ON";
	else
		PIG['PigUI']['ChatFrame_Loot_Point']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ChatFame_LOOT_Point_X()
end);
local minX,maxX = 26,500
fuFrame.ChatFrame_LOOT_Point_Slider_X = CreateFrame("Slider", nil, fuFrame.fangkuang2F, "OptionsSliderTemplate")
fuFrame.ChatFrame_LOOT_Point_Slider_X:SetWidth(140)
fuFrame.ChatFrame_LOOT_Point_Slider_X:SetHeight(15)
fuFrame.ChatFrame_LOOT_Point_Slider_X:SetPoint("LEFT",fuFrame.ChatFrame_LOOT_Point.Text,"RIGHT",8,0);
fuFrame.ChatFrame_LOOT_Point_Slider_X.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.ChatFrame_LOOT_Point_Slider_X:SetMinMaxValues(minX, maxX);
fuFrame.ChatFrame_LOOT_Point_Slider_X:SetValueStep(1);
fuFrame.ChatFrame_LOOT_Point_Slider_X:SetObeyStepOnDrag(true);
fuFrame.ChatFrame_LOOT_Point_Slider_X.Low:SetText(minX);
fuFrame.ChatFrame_LOOT_Point_Slider_X.High:SetText(maxX);
fuFrame.ChatFrame_LOOT_Point_Slider_X:EnableMouseWheel(true);
fuFrame.ChatFrame_LOOT_Point_Slider_X:SetScript("OnMouseWheel", function(self, arg1)
		local sliderMin, sliderMax = self:GetMinMaxValues()
		local value = self:GetValue()
		if arg1 > 0 then
			self:SetValue(min(value + arg1, sliderMax))
		else
			self:SetValue(max(value + arg1, sliderMin))
		end
end)
fuFrame.ChatFrame_LOOT_Point_Slider_X:SetScript('OnValueChanged', function(self)
	local valxxx = self:GetValue()
	PIG['PigUI']['ChatFrame_Loot_Point_X']=valxxx;
	ChatFame_LOOT_Point_X()
end)
local minlootY,maxlootY = 8,500
fuFrame.ChatFrame_LOOT_Point_Slider_Y = CreateFrame("Slider", nil, fuFrame.fangkuang2F, "OptionsSliderTemplate")
fuFrame.ChatFrame_LOOT_Point_Slider_Y:SetWidth(140)
fuFrame.ChatFrame_LOOT_Point_Slider_Y:SetHeight(15)
fuFrame.ChatFrame_LOOT_Point_Slider_Y:SetPoint("LEFT",fuFrame.ChatFrame_LOOT_Point_Slider_X,"RIGHT",48,0);
fuFrame.ChatFrame_LOOT_Point_Slider_Y.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.ChatFrame_LOOT_Point_Slider_Y:SetMinMaxValues(minlootY, maxlootY);
fuFrame.ChatFrame_LOOT_Point_Slider_Y:SetValueStep(1);
fuFrame.ChatFrame_LOOT_Point_Slider_Y:SetObeyStepOnDrag(true);
fuFrame.ChatFrame_LOOT_Point_Slider_Y.Low:SetText(minlootY);
fuFrame.ChatFrame_LOOT_Point_Slider_Y.High:SetText(maxlootY);
fuFrame.ChatFrame_LOOT_Point_Slider_Y:EnableMouseWheel(true);
fuFrame.ChatFrame_LOOT_Point_Slider_Y:SetScript("OnMouseWheel", function(self, arg1)
		local sliderMin, sliderMax = self:GetMinMaxValues()
		local value = self:GetValue()
		if arg1 > 0 then
			self:SetValue(min(value + arg1, sliderMax))
		else
			self:SetValue(max(value + arg1, sliderMin))
		end
end)
fuFrame.ChatFrame_LOOT_Point_Slider_Y:SetScript('OnValueChanged', function(self)
	local valxxx = self:GetValue()
	PIG['PigUI']['ChatFrame_Loot_Point_Y']=valxxx;
	ChatFame_LOOT_Point_X()
end)

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
fuFrame.xianshiNeirong = ADD_Checkbutton(nil,fuFrame,-120,"TOPLEFT",fuFrame.fangkuang2F,"TOPLEFT",10,-96,"重设窗口显示内容","启用独立拾取窗口后，建议打开此选项。\n重新设置窗口显示内容，综合频道将取消经验荣誉以及拾取信息的显示，拾取窗口添加拾取/经验/荣誉等的显示！\n修改战斗记录为记录以便缩短标签页长度。")
fuFrame.xianshiNeirong:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['xianshiNeirong']="ON";
	else
		PIG['PigUI']['xianshiNeirong']="OFF";
	end
	chongshepindaoneirong();
end);
--创建拾取聊天窗口
local function ChatFame_LOOT_ADD()
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
	ChatFame_LOOT_Point_X()
	chongshepindaoneirong()
end
-------------
fuFrame.Loot = CreateFrame("Button", nil, fuFrame, "UIPanelButtonTemplate");
fuFrame.Loot:SetSize(160,24);
fuFrame.Loot:SetPoint("BOTTOMLEFT",fuFrame.fangkuang2F,"TOPLEFT",0,4);
fuFrame.Loot:SetText("创建独立拾取窗口");
fuFrame.Loot:SetScript("OnClick", function ()
	ChatFame_LOOT_ADD()
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
---重置聊天设置
fuFrame.ReChatF = CreateFrame("Button", nil, fuFrame, "UIPanelButtonTemplate");
fuFrame.ReChatF:SetSize(180,24);
fuFrame.ReChatF:SetPoint("BOTTOMRIGHT",fuFrame.fangkuang2F,"TOPRIGHT",0,4);
fuFrame.ReChatF:SetText("恢复系统默认聊天设置");
fuFrame.ReChatF:SetScript("OnClick", function ()
	FCF_ResetChatWindows();
	PIG['PigUI']["ChatFrame_Loot"] = "OFF";
end)
---=======================================================
local function ChatFrame_LOOT_YN()
	PIG['PigUI']["ChatFrame_Loot"] = "OFF";
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
	C_Timer.After(1, ChatFrame_Width);
	C_Timer.After(1, ChatFrame_Height);
	C_Timer.After(1, ChatFrame_Point_X)
	C_Timer.After(1, ChatFrame_LOOT_YN);
	C_Timer.After(1.6, ChatFame_LOOT_Width);
	C_Timer.After(1.6, ChatFame_LOOT_Heigh);
	C_Timer.After(1.6, ChatFame_LOOT_Point_X)
	C_Timer.After(1.8, chongshepindaoneirong);
end