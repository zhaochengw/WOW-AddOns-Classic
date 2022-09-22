local addonName, addonTable = ...;
local hangH = 22
local gsub = _G.string.gsub 
local find = _G.string.find
local sub = _G.string.sub 
local upper = _G.string.upper 
--========================================================
local function fengeguanjianzi(str,delimiter)
    local dLen = string.len(delimiter)
    local newDeli = ''
    for i=1,dLen,1 do
        newDeli = newDeli .. "["..delimiter:sub(i,i).."]"
    end
    local locaStart,locaEnd = str:find(newDeli)
    local arr = {}
    local n = 1
    while locaStart ~= nil
    do
        if locaStart>0 then
            arr[n] = str:sub(1,locaStart-1)
            n = n + 1
        end
        str = str:sub(locaEnd+1,string.len(str))
        locaStart,locaEnd = str:find(newDeli)
    end
    if str ~= nil and str ~= "" and str ~= " " then
        arr[n] = str
    end
    return arr
end

local function shuaxintiquguanjianzi()
	local dangqianwanjianame = GetUnitName("player", true)
	pingbilist={}
	for x=1,#PIG['ChatFrame']['Blacklist'][dangqianwanjianame] do
		pingbilist_ziji={}
		for xx=1,#PIG['ChatFrame']['Blacklist'][dangqianwanjianame][x] do
			local tihuanteshuzifu=PIG['ChatFrame']['Blacklist'][dangqianwanjianame][x][xx]
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%^","%%^");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%$","%%$");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%%","%%%");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%*","%%*");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%+","%%+");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%-","%%-");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%.","%%.");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%?","%%?");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%(","%%(");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%)","%%)");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%[","%%[");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%]","%%]");
			local tihuanteshuzifu=tihuanteshuzifu:upper()--转换大小写
			table.insert(pingbilist_ziji, tihuanteshuzifu);
		end
		table.insert(pingbilist, pingbilist_ziji);
	end

	tiquzijielist={}
	for x=1,#PIG['ChatFrame']['Keyword'][dangqianwanjianame] do
		tiquzijielist_ziji={}
		for xx=1,#PIG['ChatFrame']['Keyword'][dangqianwanjianame][x] do
			local tihuanteshuzifu=PIG['ChatFrame']['Keyword'][dangqianwanjianame][x][xx]
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%^","%%^");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%$","%%$");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%%","%%%");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%*","%%*");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%+","%%+");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%-","%%-");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%.","%%.");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%?","%%?");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%(","%%(");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%)","%%)");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%[","%%[");
			local tihuanteshuzifu=tihuanteshuzifu:gsub("%]","%%]");
			local tihuanteshuzifu=tihuanteshuzifu:upper()--转换大小写
			table.insert(tiquzijielist_ziji, tihuanteshuzifu);
		end
		table.insert(tiquzijielist, tiquzijielist_ziji);
	end
end
--------------------
local function ADD_guanjianzi_open()
	PIG['ChatFrame']['fanyejianR']=PIG['ChatFrame']['fanyejianR'] or addonTable.Default['ChatFrame']['fanyejianR']
	PIG['ChatFrame']['gaoduH']=PIG['ChatFrame']['gaoduH'] or addonTable.Default['ChatFrame']['gaoduH']
	PIG['ChatFrame']['toumingdu']=PIG['ChatFrame']['toumingdu'] or addonTable.Default['ChatFrame']['toumingdu']
	PIG['ChatFrame']['guolvzishen']=PIG['ChatFrame']['guolvzishen'] or addonTable.Default['ChatFrame']['guolvzishen']
	PIG['ChatFrame']['FFShow']=PIG['ChatFrame']['FFShow'] or addonTable.Default['ChatFrame']['FFShow']
	PIG['ChatFrame']['Keyword']=PIG['ChatFrame']['Keyword'] or addonTable.Default['ChatFrame']['Keyword']
	PIG['ChatFrame']['Blacklist']=PIG['ChatFrame']['Blacklist'] or addonTable.Default['ChatFrame']['Blacklist']
	PIG_Per['ChatFrame']=PIG_Per['ChatFrame'] or addonTable.Default_Per['ChatFrame']

	local dangqianwanjianame = GetUnitName("player", true)
	if not PIG['ChatFrame']['Keyword'][dangqianwanjianame] then PIG['ChatFrame']['Keyword'][dangqianwanjianame]={} end
	if not PIG['ChatFrame']['Blacklist'][dangqianwanjianame] then PIG['ChatFrame']['Blacklist'][dangqianwanjianame]={} end

	shuaxintiquguanjianzi()
	local Width,Height,jiangejuli = 24,24,0;
	local fuFrame=QuickChatFFF_UI
	fuFrame.biankuang="UIMenuButtonStretchTemplate"
	if PIG['ChatFrame']['wubiankuang']=="ON" then
		fuFrame.biankuang="TruncatedButtonTemplate"
	end
	local guanjianzi = CreateFrame("Button","guanjianzi_UI",fuFrame, fuFrame.biankuang); 
	guanjianzi:SetSize(Width,Height);
	guanjianzi:SetPoint("LEFT",QuickChatFFF_UI.ChatJilu,"RIGHT",0,0);
	guanjianzi.Tex = guanjianzi:CreateTexture();
	guanjianzi.Tex:SetTexture("interface/common/voicechat-on.blp");
	guanjianzi.Tex:SetSize(Width+2,Height-4);
	guanjianzi.Tex:SetPoint("CENTER", -7.5, 0);
	guanjianzi:SetScript("OnMouseDown",  function(self)
		self.Tex:SetPoint("CENTER", -6, -1.5);
	end)
	guanjianzi:SetScript("OnMouseUp",  function(self)
		self.Tex:SetPoint("CENTER", -7.5, 0);
	end)
	----
	guanjianzi.F = CreateFrame("ScrollingMessageFrame", "ChatFrame99", guanjianzi, "BackdropTemplate,ChatFrameTemplate")
	guanjianzi.F:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",} );
	guanjianzi.F:SetHeight(200);
	guanjianzi.F:SetFrameStrata("BACKGROUND")
	guanjianzi.F:EnableMouse(false)
	guanjianzi.F:UnregisterAllEvents()
	--guanjianzi.F:Clear() -- 清除框架中的消息 
	--guanjianzi.F:SetFadeDuration(seconds)--设置淡入淡出持续时间 
	--guanjianzi.F:SetTimeVisible(seconds)--设置消息显示时间
	--guanjianzi.F:SetFading(false)淡入淡出
	--guanjianzi.F:SetMaxLines(999) --设置可显示最大行数
	--guanjianzi.F:SetInsertMode(TOP or BOTTOM) --设置新消息的插入位置
	--guanjianzi.F:SetToplevel(true)--单击子项时框架是否应自行升起
   	--guanjianzi.F:EnableMouseWheel(false)-- 禁用鼠标滚动
	guanjianzi.F:SetHyperlinksEnabled(true)--可点击

	if PIG['ChatFrame']['QuickChat_maodian']==1 then
		guanjianzi.F:SetPoint("BOTTOMLEFT",DEFAULT_CHAT_FRAME,"TOPLEFT",-2,56);
		guanjianzi.F:SetPoint("BOTTOMRIGHT",DEFAULT_CHAT_FRAME,"TOPRIGHT",0,56);
	elseif PIG['ChatFrame']['QuickChat_maodian']==2 then
		guanjianzi.F:SetPoint("BOTTOMLEFT",DEFAULT_CHAT_FRAME,"TOPLEFT",-2,28);
		guanjianzi.F:SetPoint("BOTTOMRIGHT",DEFAULT_CHAT_FRAME,"TOPRIGHT",0,28);
	end
	if PIG['ChatFrame']['FFShow']~="ON" then
		guanjianzi.F:Hide();
	end
	guanjianzi.F:SetScript("OnMouseWheel", function(self, delta)
		if delta == 1 then
			guanjianzi.F:ScrollUp()
			guanjianzi.F.ScrollToBottomButton.hilight:Show();
		elseif delta == -1 then
			guanjianzi.F:ScrollDown()
			if guanjianzi.F:GetScrollOffset()==0 then
				guanjianzi.F.ScrollToBottomButton.hilight:Hide();
			end
		end
	end)
	guanjianzi.F.Center:SetPoint("TOPLEFT",guanjianzi.F,"TOPLEFT",-2,2);
	guanjianzi.F.Center:SetPoint("BOTTOMRIGHT",guanjianzi.F,"BOTTOMRIGHT",2,-2);
	---提醒
	guanjianzi.youNEWxiaoxinlai=false;
	local function guanjianziMGStishi()
		if guanjianzi.Tex:IsShown() then
			guanjianzi.Tex:Hide()
		else
			guanjianzi.Tex:Show()
		end
		if guanjianzi.youNEWxiaoxinlai then
			C_Timer.After(0.8,guanjianziMGStishi)
		else
			guanjianzi.Tex:Show()
		end
	end
	---翻页按钮=======================
	local anniudaxiaoF = 30
	guanjianzi.F.ScrollToBottomButton = CreateFrame("Button",nil,guanjianzi.F, "TruncatedButtonTemplate");
	guanjianzi.F.ScrollToBottomButton:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
	guanjianzi.F.ScrollToBottomButton:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	guanjianzi.F.ScrollToBottomButton:SetPushedTexture("interface/chatframe/ui-chaticon-scrollend-down.blp")
	guanjianzi.F.ScrollToBottomButton:SetSize(anniudaxiaoF,anniudaxiaoF);
	guanjianzi.F.ScrollToBottomButton:SetPoint("TOPRIGHT",guanjianzi.F,"TOPLEFT",-2,-60);
	guanjianzi.F.ScrollToBottomButton.hilight = guanjianzi.F.ScrollToBottomButton:CreateTexture(nil,"OVERLAY");
	guanjianzi.F.ScrollToBottomButton.hilight:SetTexture("interface/chatframe/ui-chaticon-blinkhilight.blp");
	guanjianzi.F.ScrollToBottomButton.hilight:SetSize(anniudaxiaoF,anniudaxiaoF);
	guanjianzi.F.ScrollToBottomButton.hilight:SetPoint("CENTER", 0, 0);
	guanjianzi.F.ScrollToBottomButton.hilight:Hide();

	-- guanjianzi.F.down = CreateFrame("Button",nil,guanjianzi.F, "TruncatedButtonTemplate");
	-- guanjianzi.F.down:SetNormalTexture("interface/chatframe/ui-chaticon-scrolldown-up.blp")
	-- guanjianzi.F.down:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	-- guanjianzi.F.down:SetPushedTexture("interface/chatframe/ui-chaticon-scrolldown-down.blp")
	-- guanjianzi.F.down:SetSize(anniudaxiaoF,anniudaxiaoF);
	-- guanjianzi.F.down:SetPoint("BOTTOM",guanjianzi.F.ScrollToBottomButton,"TOP",0,0);
	-- guanjianzi.F.up = CreateFrame("Button",nil,guanjianzi.F, "TruncatedButtonTemplate");
	-- guanjianzi.F.up:SetNormalTexture("interface/chatframe/ui-chaticon-scrollup-up.blp")
	-- guanjianzi.F.up:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	-- guanjianzi.F.up:SetPushedTexture("interface/chatframe/ui-chaticon-scrollup-down.blp")
	-- guanjianzi.F.up:SetSize(anniudaxiaoF,anniudaxiaoF);
	-- guanjianzi.F.up:SetPoint("BOTTOM",guanjianzi.F.down,"TOP",0,0);
	---------
	guanjianzi.F.ScrollToBottomButton:SetScript("OnClick", function (self)
		guanjianzi.F:ScrollToBottom()
		guanjianzi.F.ScrollToBottomButton.hilight:Hide();
	end);
	-- guanjianzi.F.up:SetScript("OnClick", function (self)
	-- 	guanjianzi.F:ScrollUp()
	-- 	guanjianzi.F.ScrollToBottomButton.hilight:Show();
	-- end);
	-- guanjianzi.F.down:SetScript("OnClick", function (self)
	-- 	guanjianzi.F:ScrollDown()
	-- 	if guanjianzi.F:GetScrollOffset()==0 then
	-- 		guanjianzi.F.ScrollToBottomButton.hilight:Hide();
	-- 	end
	-- end);

	guanjianzi:SetScript("OnClick", function(self)
		if self.F:IsShown() then
			self.F:Hide()
			PIG['ChatFrame']['FFShow']="OFF"
		else
			self.F:Show()
			PIG['ChatFrame']['FFShow']="ON"
			guanjianzi.youNEWxiaoxinlai=false;
		end
	end);

	--设置=====================================
	guanjianzi.F.shezhi = CreateFrame("Button",nil,guanjianzi.F, "TruncatedButtonTemplate");
	guanjianzi.F.shezhi:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	guanjianzi.F.shezhi:SetSize(hangH,hangH);
	guanjianzi.F.shezhi:SetPoint("BOTTOM",guanjianzi.F.ScrollToBottomButton,"TOP",0,6);
	guanjianzi.F.shezhi.Tex = guanjianzi.F.shezhi:CreateTexture(nil, "BORDER");
	guanjianzi.F.shezhi.Tex:SetTexture("interface/gossipframe/bindergossipicon.blp");
	guanjianzi.F.shezhi.Tex:SetPoint("CENTER");
	guanjianzi.F.shezhi.Tex:SetSize(hangH-4,hangH-4);
	guanjianzi.F.shezhi:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.2,-1.2);
	end);
	guanjianzi.F.shezhi:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	guanjianzi.F.shezhi:SetScript("OnClick", function (self)
		if guanjianzi.F.shezhi.F:IsShown() then
			guanjianzi.F.shezhi.F:Hide()
		else
			guanjianzi.F.shezhi.F:Show()
		end
	end);
	local shezhiW ,shezhiH=260,220
	guanjianzi.F.shezhi.F = CreateFrame("Frame", nil, guanjianzi.F.shezhi,"BackdropTemplate");
	guanjianzi.F.shezhi.F:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 4,} );
	guanjianzi.F.shezhi.F:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
	guanjianzi.F.shezhi.F:SetSize(shezhiW,shezhiH);
	guanjianzi.F.shezhi.F:SetPoint("BOTTOMLEFT",guanjianzi.F,"BOTTOMRIGHT",30,0);
	guanjianzi.F.shezhi.F:Hide()
	guanjianzi.F.shezhi.F:SetFrameStrata("LOW")
	guanjianzi.F.shezhi.F.COS = CreateFrame("Button",nil,guanjianzi.F.shezhi.F,"UIPanelCloseButton");
	guanjianzi.F.shezhi.F.COS:SetSize(28,28);
	guanjianzi.F.shezhi.F.COS:SetPoint("TOPRIGHT",guanjianzi.F.shezhi.F,"TOPRIGHT",0,0);

	guanjianzi.F.shezhi:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.5,-1.5);
	end);
	guanjianzi.F.shezhi:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	guanjianzi.F.shezhi:SetScript("OnClick", function (self)
		guanjianzi.F.guanjianzi.F:Hide()
		if guanjianzi.F.shezhi.F:IsShown() then
			guanjianzi.F.shezhi.F:Hide()
		else
			guanjianzi.F.shezhi.F:Show()
		end
	end);
	--高度
	guanjianzi.F.shezhi.F.GaoduH = guanjianzi.F.shezhi.F:CreateFontString();
	guanjianzi.F.shezhi.F.GaoduH:SetPoint("TOPLEFT",guanjianzi.F.shezhi.F,"TOPLEFT",20,-20);
	guanjianzi.F.shezhi.F.GaoduH:SetFontObject(GameFontNormal);
	guanjianzi.F.shezhi.F.GaoduH:SetText("高度：");
	guanjianzi.F.shezhi.F.GaoduHSlider = CreateFrame("Slider", nil, guanjianzi.F.shezhi.F, "OptionsSliderTemplate")
	guanjianzi.F.shezhi.F.GaoduHSlider:SetSize(120,14);
	guanjianzi.F.shezhi.F.GaoduHSlider:SetPoint("LEFT",guanjianzi.F.shezhi.F.GaoduH,"RIGHT",10,0);
	guanjianzi.F.shezhi.F.GaoduHSlider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
	guanjianzi.F.shezhi.F.GaoduHSlider.Low:SetText('100');
	guanjianzi.F.shezhi.F.GaoduHSlider.High:SetText('500');
	guanjianzi.F.shezhi.F.GaoduHSlider:SetMinMaxValues(100, 500);
	guanjianzi.F.shezhi.F.GaoduHSlider:SetValueStep(1);
	guanjianzi.F.shezhi.F.GaoduHSlider:SetObeyStepOnDrag(true);
	guanjianzi.F.shezhi.F.GaoduHSlider:EnableMouseWheel(true);--接受滚轮输入
	guanjianzi.F.shezhi.F.GaoduHSlider:SetScript("OnMouseWheel", function(self, arg1)
		if self:IsEnabled() then
			local step = 1 * arg1
			local value = self:GetValue()
			if step > 0 then
				self:SetValue(min(value + step, 500))
			else
				self:SetValue(max(value + step, 100))
			end
		end
	end)
	guanjianzi.F.shezhi.F.GaoduHSlider:SetScript('OnValueChanged', function(self)
		local val = self:GetValue()
		self.Text:SetText(val);
		guanjianzi.F:SetHeight(val)
		PIG['ChatFrame']['gaoduH']=val
	end)
	guanjianzi.F.shezhi.F.GaoduHSlider.Text:SetText(PIG['ChatFrame']['gaoduH']);
	guanjianzi.F.shezhi.F.GaoduHSlider:SetValue(PIG['ChatFrame']['gaoduH']);

	guanjianzi.F.shezhi.F.toumingdu = guanjianzi.F.shezhi.F:CreateFontString();
	guanjianzi.F.shezhi.F.toumingdu:SetPoint("TOPLEFT",guanjianzi.F.shezhi.F,"TOPLEFT",20,-70);
	guanjianzi.F.shezhi.F.toumingdu:SetFontObject(GameFontNormal);
	guanjianzi.F.shezhi.F.toumingdu:SetText("透明度：");
	guanjianzi.F.shezhi.F.toumingduSlider = CreateFrame("Slider", nil, guanjianzi.F.shezhi.F, "OptionsSliderTemplate")
	guanjianzi.F.shezhi.F.toumingduSlider:SetSize(120,14);
	guanjianzi.F.shezhi.F.toumingduSlider:SetPoint("LEFT",guanjianzi.F.shezhi.F.toumingdu,"RIGHT",10,0);
	guanjianzi.F.shezhi.F.toumingduSlider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
	guanjianzi.F.shezhi.F.toumingduSlider.Low:SetText('0');
	guanjianzi.F.shezhi.F.toumingduSlider.High:SetText('1');
	guanjianzi.F.shezhi.F.toumingduSlider:SetMinMaxValues(0, 1);
	guanjianzi.F.shezhi.F.toumingduSlider:SetValueStep(0.1);
	guanjianzi.F.shezhi.F.toumingduSlider:SetObeyStepOnDrag(true);
	guanjianzi.F.shezhi.F.toumingduSlider:EnableMouseWheel(true);--接受滚轮输入
	guanjianzi.F.shezhi.F.toumingduSlider:SetScript("OnMouseWheel", function(self, arg1)
		if self:IsEnabled() then
			local step = 0.1 * arg1
			local value = self:GetValue()
			if step > 0 then
				self:SetValue(min(value + step, 1))
			else
				self:SetValue(max(value + step, 0))
			end
		end
	end)
	guanjianzi.F.shezhi.F.toumingduSlider:SetScript('OnValueChanged', function(self)
		local val = self:GetValue()
		guanjianzi.F:SetBackdropColor(0, 0, 0, val);
		--guanjianzi.F:SetBackdropBorderColor(1, 1, 1, val);
		self.Text:SetText((floor(val*10+0.5))/10);
		PIG['ChatFrame']['toumingdu']=val
	end)
	guanjianzi.F.shezhi.F.toumingduSlider.Text:SetText(PIG['ChatFrame']['toumingdu']);
	guanjianzi.F.shezhi.F.toumingduSlider:SetValue(PIG['ChatFrame']['toumingdu']);

	--选项
	local XXX,YYY = 26,28
	guanjianzi.F.shezhi.F.fanyejian = CreateFrame("CheckButton", nil, guanjianzi.F.shezhi.F, "ChatConfigCheckButtonTemplate");
	guanjianzi.F.shezhi.F.fanyejian:SetSize(XXX,YYY);
	guanjianzi.F.shezhi.F.fanyejian:SetHitRectInsets(0,-100,0,0);
	guanjianzi.F.shezhi.F.fanyejian:SetPoint("TOPLEFT",guanjianzi.F.shezhi.F,"TOPLEFT",10,-100);
	guanjianzi.F.shezhi.F.fanyejian.Text:SetText("菜单显示在右侧");
	guanjianzi.F.shezhi.F.fanyejian.tooltip = "菜单显示在右侧";
	guanjianzi.F.shezhi.F.fanyejian:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['ChatFrame']['fanyejianR']="ON"
			guanjianzi.F.ScrollToBottomButton:ClearAllPoints();
			guanjianzi.F.ScrollToBottomButton:SetPoint("TOPLEFT",guanjianzi.F,"TOPRIGHT",2,-60);
		else
			PIG['ChatFrame']['fanyejianR']="OFF"
			guanjianzi.F.ScrollToBottomButton:ClearAllPoints();
			guanjianzi.F.ScrollToBottomButton:SetPoint("TOPRIGHT",guanjianzi.F,"TOPLEFT",-2,-60);
		end
	end);
	if PIG['ChatFrame']['fanyejianR']=="ON" then
		guanjianzi.F.shezhi.F.fanyejian:SetChecked(true)
		guanjianzi.F.ScrollToBottomButton:ClearAllPoints();
		guanjianzi.F.ScrollToBottomButton:SetPoint("TOPLEFT",guanjianzi.F,"TOPRIGHT",2,-60);
	end

	guanjianzi.F.shezhi.F.guolvzishen = CreateFrame("CheckButton", nil, guanjianzi.F.shezhi.F, "ChatConfigCheckButtonTemplate");
	guanjianzi.F.shezhi.F.guolvzishen:SetSize(XXX,YYY);
	guanjianzi.F.shezhi.F.guolvzishen:SetHitRectInsets(0,-100,0,0);
	guanjianzi.F.shezhi.F.guolvzishen:SetPoint("TOPLEFT",guanjianzi.F.shezhi.F,"TOPLEFT",10,-130);
	guanjianzi.F.shezhi.F.guolvzishen.Text:SetText("不显示自身发言");
	guanjianzi.F.shezhi.F.guolvzishen.tooltip = "不显示自身发言";
	guanjianzi.F.shezhi.F.guolvzishen:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['ChatFrame']['guolvzishen']="ON"
		else
			PIG['ChatFrame']['guolvzishen']="OFF"
		end
	end);
	if PIG['ChatFrame']['guolvzishen']=="ON" then
		guanjianzi.F.shezhi.F.guolvzishen:SetChecked(true)
	end
	--
	guanjianzi.F.shezhi.F.xitongjihuoB = CreateFrame("CheckButton", nil, guanjianzi.F.shezhi.F, "ChatConfigCheckButtonTemplate");
	guanjianzi.F.shezhi.F.xitongjihuoB:SetSize(XXX,YYY);
	guanjianzi.F.shezhi.F.xitongjihuoB:SetHitRectInsets(0,-100,0,0);
	guanjianzi.F.shezhi.F.xitongjihuoB:SetPoint("TOPLEFT",guanjianzi.F.shezhi.F,"TOPLEFT",10,-160);
	guanjianzi.F.shezhi.F.xitongjihuoB.Text:SetText("启用系统聊天黑名单");
	guanjianzi.F.shezhi.F.xitongjihuoB.tooltip = "开起后黑名单也会对系统聊天栏生效，否则只对提取聊天栏生效";
	guanjianzi.F.shezhi.F.xitongjihuoB:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['ChatFrame']['xitongjihuoB']="ON"
		else
			PIG['ChatFrame']['xitongjihuoB']="OFF"
		end
	end);
	if PIG['ChatFrame']['xitongjihuoB']=="ON" then
		guanjianzi.F.shezhi.F.xitongjihuoB:SetChecked(true)
	end
	--
	guanjianzi.F.shezhi.F.guolvchongfu = CreateFrame("CheckButton", nil, guanjianzi.F.shezhi.F, "ChatConfigCheckButtonTemplate");
	guanjianzi.F.shezhi.F.guolvchongfu:SetSize(XXX,YYY);
	guanjianzi.F.shezhi.F.guolvchongfu:SetHitRectInsets(0,-100,0,0);
	guanjianzi.F.shezhi.F.guolvchongfu:SetPoint("TOPLEFT",guanjianzi.F.shezhi.F,"TOPLEFT",10,-190);
	guanjianzi.F.shezhi.F.guolvchongfu.Text:SetText("过滤重复发言");
	guanjianzi.F.shezhi.F.guolvchongfu.tooltip = "过滤1分钟之内的重复发言(此功能也会对系统聊天栏生效)";
	guanjianzi.F.shezhi.F.guolvchongfu:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['ChatFrame']['guolvchongfu']="ON"
		else
			PIG['ChatFrame']['guolvchongfu']="OFF"
		end
	end);
	if PIG['ChatFrame']['guolvchongfu']=="ON" then
		guanjianzi.F.shezhi.F.guolvchongfu:SetChecked(true)
	end
	--编辑关键字/黑名单================================
	guanjianzi.F.guanjianzi = CreateFrame("Button",nil,guanjianzi.F, "TruncatedButtonTemplate");
	guanjianzi.F.guanjianzi:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	guanjianzi.F.guanjianzi:SetSize(hangH,hangH);
	guanjianzi.F.guanjianzi:SetPoint("BOTTOM",guanjianzi.F.shezhi,"TOP",0,6);
	guanjianzi.F.guanjianzi.Tex = guanjianzi.F.guanjianzi:CreateTexture(nil, "BORDER");
	guanjianzi.F.guanjianzi.Tex:SetTexture("interface/buttons/ui-guildbutton-publicnote-up.blp");
	guanjianzi.F.guanjianzi.Tex:SetPoint("CENTER");
	guanjianzi.F.guanjianzi.Tex:SetSize(hangH-4,hangH-4);
	guanjianzi.F.guanjianzi:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.2,-1.2);
	end);
	guanjianzi.F.guanjianzi:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);

	local GJZW ,GJZH=400,280
	guanjianzi.F.guanjianzi.F = CreateFrame("Frame", nil, guanjianzi.F.guanjianzi,"BackdropTemplate");
	guanjianzi.F.guanjianzi.F:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 4} );
	guanjianzi.F.guanjianzi.F:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
	guanjianzi.F.guanjianzi.F:SetSize(GJZW ,GJZH);
	guanjianzi.F.guanjianzi.F:SetPoint("BOTTOMLEFT",guanjianzi.F,"BOTTOMRIGHT",30,0);
	guanjianzi.F.guanjianzi.F:Hide()
	guanjianzi.F.guanjianzi.F:SetFrameStrata("LOW")
	guanjianzi.F.guanjianzi.F.COS = CreateFrame("Button",nil,guanjianzi.F.guanjianzi.F,"UIPanelCloseButton");
	guanjianzi.F.guanjianzi.F.COS:SetSize(26,26);
	guanjianzi.F.guanjianzi.F.COS:SetPoint("TOPRIGHT",guanjianzi.F.guanjianzi.F,"TOPRIGHT",4,3);

	guanjianzi.F.guanjianzi.F.line = guanjianzi.F.guanjianzi.F:CreateLine()
	guanjianzi.F.guanjianzi.F.line:SetColorTexture(0.6,0.6,0.6,0.3)
	guanjianzi.F.guanjianzi.F.line:SetThickness(1);
	guanjianzi.F.guanjianzi.F.line:SetStartPoint("TOPLEFT",1,-18)
	guanjianzi.F.guanjianzi.F.line:SetEndPoint("TOPRIGHT",-1,-18)

	guanjianzi.F.guanjianzi.F.line1 = guanjianzi.F.guanjianzi.F:CreateLine()
	guanjianzi.F.guanjianzi.F.line1:SetColorTexture(0.6,0.6,0.6,0.3)
	guanjianzi.F.guanjianzi.F.line1:SetThickness(1);
	guanjianzi.F.guanjianzi.F.line1:SetStartPoint("TOP",0,-1)
	guanjianzi.F.guanjianzi.F.line1:SetEndPoint("BOTTOM",0,1)
	--关键字
	guanjianzi.F.guanjianzi.F.T = guanjianzi.F.guanjianzi.F:CreateFontString();
	guanjianzi.F.guanjianzi.F.T:SetPoint("TOPLEFT",guanjianzi.F.guanjianzi.F,"TOPLEFT",8,-1);
	guanjianzi.F.guanjianzi.F.T:SetFontObject(GameFontNormal);
	guanjianzi.F.guanjianzi.F.T:SetText("\124cff00ff00提取关键字\124r");
	local jueseListLL = PIG['ChatFrame']['Keyword'];
	guanjianzi.F.guanjianzi.F.daoru = CreateFrame("FRAME", nil, guanjianzi.F.guanjianzi.F, "UIDropDownMenuTemplate")
	guanjianzi.F.guanjianzi.F.daoru:SetPoint("LEFT",guanjianzi.F.guanjianzi.F.T,"RIGHT",-20,-3)
	UIDropDownMenu_SetWidth(guanjianzi.F.guanjianzi.F.daoru, 100)
	UIDropDownMenu_SetText(guanjianzi.F.guanjianzi.F.daoru, "其他角色")
	guanjianzi.F.guanjianzi.F.daoru:SetScale(0.8);
	guanjianzi.F.guanjianzi.F.daoru.Left:Hide();
	guanjianzi.F.guanjianzi.F.daoru.Middle:Hide();
	guanjianzi.F.guanjianzi.F.daoru.Right:Hide();
	local function listjiazai(self)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		for k,v in pairs(jueseListLL) do
			if k~=dangqianwanjianame then
				info.text, info.arg1 = "导入["..k.."]("..#v..")", k
				info.notCheckable = true;
				UIDropDownMenu_AddButton(info)
			end
		end	
	end
	UIDropDownMenu_Initialize(guanjianzi.F.guanjianzi.F.daoru, listjiazai)

	guanjianzi.F.guanjianzi.F.EW = CreateFrame('EditBox', nil, guanjianzi.F.guanjianzi.F,"BackdropTemplate");
	guanjianzi.F.guanjianzi.F.EW:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -5,right = -6,top = 0,bottom = -13}})
	guanjianzi.F.guanjianzi.F.EW:SetSize(GJZW/2-46,hangH);
	guanjianzi.F.guanjianzi.F.EW:SetPoint("TOPLEFT", guanjianzi.F.guanjianzi.F.line, "BOTTOMLEFT", 10,-2);
	guanjianzi.F.guanjianzi.F.EW:SetFontObject(ChatFontNormal);
	guanjianzi.F.guanjianzi.F.EW:SetMaxLetters(30);
	guanjianzi.F.guanjianzi.F.EW:SetAutoFocus(false);
	guanjianzi.F.guanjianzi.F.EW.tishi = guanjianzi.F.guanjianzi.F:CreateFontString();
	guanjianzi.F.guanjianzi.F.EW.tishi:SetPoint("LEFT",guanjianzi.F.guanjianzi.F.EW,"LEFT",6,-0);
	guanjianzi.F.guanjianzi.F.EW.tishi:SetFontObject(GameFontNormal);
	guanjianzi.F.guanjianzi.F.EW.tishi:SetText("输入关键字(用,分隔)");
	guanjianzi.F.guanjianzi.F.EW.tishi:SetTextColor(0.8, 0.8, 0.8, 0.8);
	guanjianzi.F.guanjianzi.F.EW:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
	end);
	guanjianzi.F.guanjianzi.F.EW:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus()
	end);
	guanjianzi.F.guanjianzi.F.EW:SetScript("OnEditFocusGained", function(self)
		self.tishi:Hide()
		self.YES:Show();
	end);

	guanjianzi.F.guanjianzi.F.EW.YES = CreateFrame("Button",nil,guanjianzi.F.guanjianzi.F.EW, "UIPanelButtonTemplate");
	guanjianzi.F.guanjianzi.F.EW.YES:SetSize(hangH+6,hangH-2);
	guanjianzi.F.guanjianzi.F.EW.YES:SetPoint("LEFT",guanjianzi.F.guanjianzi.F.EW,"RIGHT",6,0);
	guanjianzi.F.guanjianzi.F.EW.YES:SetText("确定");
	guanjianzi.F.guanjianzi.F.EW.YES:Hide();
	local buttonFont=guanjianzi.F.guanjianzi.F.EW.YES:GetFontString()
	buttonFont:SetFont(ChatFontNormal:GetFont(), 9);

	local function SAVE_guanjianzi(value)
		local value = value:gsub(" ", "")
		if value=="" then return end
		local value = value:gsub("，", ",")
		local guanjianzilist = fengeguanjianzi(value, ",")
		table.insert(PIG['ChatFrame']['Keyword'][dangqianwanjianame],guanjianzilist)
		shuaxintiquguanjianzi()
	end
	guanjianzi.F.guanjianzi.F.EW.YES:SetScript("OnClick", function(self, button)
		local ParentF = self:GetParent();
		ParentF:ClearFocus()
	end)
	---显示列表
	local hang_NUM = 8
	local function gengxin_hang(self)
		for id = 1, hang_NUM, 1 do	
			_G["Bmd_List_"..id].txt:SetText();
			_G["Bmd_List_"..id].del:Hide();
		end
		local ItemsNum = #PIG['ChatFrame']['Keyword'][dangqianwanjianame];
		if ItemsNum>0 then
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hangH);
		    local offset = FauxScrollFrame_GetOffset(self);
			for id = 1, hang_NUM do
				local dangqian = id+offset;
				if PIG['ChatFrame']['Keyword'][dangqianwanjianame][dangqian] then
					_G["Bmd_List_"..id].del:Show();
					_G["Bmd_List_"..id].del:SetID(dangqian);
					local guanjianzineironglianji = ""
					for xx=1,#PIG['ChatFrame']['Keyword'][dangqianwanjianame][dangqian] do
						if PIG['ChatFrame']['Keyword'][dangqianwanjianame][dangqian][xx] then
							if xx==#PIG['ChatFrame']['Keyword'][dangqianwanjianame][dangqian] then
								guanjianzineironglianji=guanjianzineironglianji..PIG['ChatFrame']['Keyword'][dangqianwanjianame][dangqian][xx]
							else
								guanjianzineironglianji=guanjianzineironglianji..PIG['ChatFrame']['Keyword'][dangqianwanjianame][dangqian][xx]..","
							end
						end
					end
					_G["Bmd_List_"..id].txt:SetText(guanjianzineironglianji);
				end
			end
		end
	end
	function guanjianzi.F.guanjianzi.F.daoru:SetValue(newValue)
		PIG['ChatFrame']['Keyword'][dangqianwanjianame] = PIG['ChatFrame']['Keyword'][newValue];
		gengxin_hang(guanjianzi.F.guanjianzi.F.WList.Scroll)
		CloseDropDownMenus()
	end
	guanjianzi.F.guanjianzi.F.WList = CreateFrame("Frame", nil, guanjianzi.F.guanjianzi.F);
	guanjianzi.F.guanjianzi.F.WList:SetSize(GJZW/2-6,hangH*8+10);
	guanjianzi.F.guanjianzi.F.WList:SetPoint("TOPLEFT", guanjianzi.F.guanjianzi.F, "TOPLEFT", 2, -48);
	guanjianzi.F.guanjianzi.F.WList.Scroll = CreateFrame("ScrollFrame",nil,guanjianzi.F.guanjianzi.F.WList, "FauxScrollFrameTemplate");  
	guanjianzi.F.guanjianzi.F.WList.Scroll:SetPoint("TOPLEFT",guanjianzi.F.guanjianzi.F.WList,"TOPLEFT",0,0);
	guanjianzi.F.guanjianzi.F.WList.Scroll:SetPoint("BOTTOMRIGHT",guanjianzi.F.guanjianzi.F.WList,"BOTTOMRIGHT",-18,0);
	guanjianzi.F.guanjianzi.F.WList.Scroll.ScrollBar:SetScale(0.8);
	guanjianzi.F.guanjianzi.F.WList.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hangH, gengxin_hang)
	end)
	for id = 1, hang_NUM, 1 do
		local Bmd_List = CreateFrame("Frame", "Bmd_List_"..id, guanjianzi.F.guanjianzi.F.WList.Scroll:GetParent());
		Bmd_List:SetSize(guanjianzi.F.guanjianzi.F.WList:GetWidth()-18,hangH);
		if id==1 then
			Bmd_List:SetPoint("TOPLEFT", guanjianzi.F.guanjianzi.F.WList.Scroll, "TOPLEFT", 0, -1);
		else
			Bmd_List:SetPoint("TOPLEFT", _G["Bmd_List_"..(id-1)], "BOTTOMLEFT", 0, -1);
		end	
		Bmd_List.del = CreateFrame("Button",nil, Bmd_List, "TruncatedButtonTemplate");
		Bmd_List.del:SetSize(hangH-4,hangH-4);
		Bmd_List.del:SetPoint("LEFT", Bmd_List, "LEFT", 0,0);
		Bmd_List.del.Tex = Bmd_List.del:CreateTexture(nil, "BORDER");
		Bmd_List.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		Bmd_List.del.Tex:SetPoint("CENTER",0,-1);
		Bmd_List.del.Tex:SetSize(hangH-10,hangH-10);
		Bmd_List.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1,-2);
		end);
		Bmd_List.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER",0,-1);
		end);
		Bmd_List.del:SetScript("OnClick", function (self)
			table.remove(PIG['ChatFrame']['Keyword'][dangqianwanjianame], self:GetID());
			shuaxintiquguanjianzi()
			gengxin_hang(guanjianzi.F.guanjianzi.F.WList.Scroll)
		end);	
		Bmd_List.txt = Bmd_List:CreateFontString();
		Bmd_List.txt:SetPoint("LEFT", Bmd_List.del, "RIGHT", 0, 0);
		Bmd_List.txt:SetFontObject(ChatFontNormal);
		Bmd_List.txt:SetTextColor(0.7, 0.7, 0.7, 1);
	end
	guanjianzi.F.guanjianzi.F.EW:SetScript("OnEditFocusLost", function(self)
		local guanjianV = self:GetText();
		SAVE_guanjianzi(guanjianV)
		gengxin_hang(guanjianzi.F.guanjianzi.F.WList.Scroll)
		self.tishi:Show()
		self.YES:Hide();
		self:SetText("");
	end);

	--黑名单
	guanjianzi.F.guanjianzi.F.T1 = guanjianzi.F.guanjianzi.F:CreateFontString();
	guanjianzi.F.guanjianzi.F.T1:SetPoint("TOPLEFT",guanjianzi.F.guanjianzi.F.line1,"TOPLEFT",6,-1);
	guanjianzi.F.guanjianzi.F.T1:SetFontObject(GameFontNormal);
	guanjianzi.F.guanjianzi.F.T1:SetText("\124cffFFff00过滤黑名单\124r");
	local jueseListxx = PIG['ChatFrame']['Blacklist'];
	guanjianzi.F.guanjianzi.F.daoru_B = CreateFrame("FRAME", nil, guanjianzi.F.guanjianzi.F, "UIDropDownMenuTemplate")
	guanjianzi.F.guanjianzi.F.daoru_B:SetPoint("LEFT",guanjianzi.F.guanjianzi.F.T1,"RIGHT",-20,-3)
	UIDropDownMenu_SetWidth(guanjianzi.F.guanjianzi.F.daoru_B, 100)
	UIDropDownMenu_SetText(guanjianzi.F.guanjianzi.F.daoru_B, "其他角色")
	guanjianzi.F.guanjianzi.F.daoru_B:SetScale(0.8);
	guanjianzi.F.guanjianzi.F.daoru_B.Left:Hide();
	guanjianzi.F.guanjianzi.F.daoru_B.Middle:Hide();
	guanjianzi.F.guanjianzi.F.daoru_B.Right:Hide();
	local function listjiazai(self)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		for k,v in pairs(jueseListxx) do
			if k~=dangqianwanjianame then
				info.text, info.arg1 = "导入["..k.."]("..#v..")", k
				info.notCheckable = true;
				UIDropDownMenu_AddButton(info)
			end
		end	
	end
	UIDropDownMenu_Initialize(guanjianzi.F.guanjianzi.F.daoru_B, listjiazai)

	guanjianzi.F.guanjianzi.F.EB = CreateFrame('EditBox', nil, guanjianzi.F.guanjianzi.F,"BackdropTemplate");
	guanjianzi.F.guanjianzi.F.EB:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -5,right = -6,top = 0,bottom = -13}})
	guanjianzi.F.guanjianzi.F.EB:SetSize(GJZW/2-46,hangH);
	guanjianzi.F.guanjianzi.F.EB:SetPoint("TOPLEFT", guanjianzi.F.guanjianzi.F.line, "BOTTOMLEFT", GJZW/2+10,-2);
	guanjianzi.F.guanjianzi.F.EB:SetFontObject(ChatFontNormal);
	guanjianzi.F.guanjianzi.F.EB:SetMaxLetters(30);
	guanjianzi.F.guanjianzi.F.EB:SetAutoFocus(false);
	guanjianzi.F.guanjianzi.F.EB.tishi = guanjianzi.F.guanjianzi.F:CreateFontString();
	guanjianzi.F.guanjianzi.F.EB.tishi:SetPoint("LEFT",guanjianzi.F.guanjianzi.F.EB,"LEFT",6,-0);
	guanjianzi.F.guanjianzi.F.EB.tishi:SetFontObject(GameFontNormal);
	guanjianzi.F.guanjianzi.F.EB.tishi:SetText("输入关键字(用,分隔)");
	guanjianzi.F.guanjianzi.F.EB.tishi:SetTextColor(0.8, 0.8, 0.8, 0.8);
	guanjianzi.F.guanjianzi.F.EB:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
	end);
	guanjianzi.F.guanjianzi.F.EB:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus()
	end);
	guanjianzi.F.guanjianzi.F.EB:SetScript("OnEditFocusGained", function(self)
		self.tishi:Hide()
		self.YES:Show();
	end);

	guanjianzi.F.guanjianzi.F.EB.YES = CreateFrame("Button",nil,guanjianzi.F.guanjianzi.F.EB, "UIPanelButtonTemplate");
	guanjianzi.F.guanjianzi.F.EB.YES:SetSize(hangH+6,hangH-2);
	guanjianzi.F.guanjianzi.F.EB.YES:SetPoint("LEFT",guanjianzi.F.guanjianzi.F.EB,"RIGHT",6,0);
	guanjianzi.F.guanjianzi.F.EB.YES:SetText("确定");
	guanjianzi.F.guanjianzi.F.EB.YES:Hide();
	local buttonFont=guanjianzi.F.guanjianzi.F.EB.YES:GetFontString()
	buttonFont:SetFont(ChatFontNormal:GetFont(), 9);

	local function SAVE_guanjianzi_B(value)
		local value = value:gsub(" ", "")
		if value=="" then return end
		local value = value:gsub("，", ",")
		local guanjianzilist = fengeguanjianzi(value, ",")
		table.insert(PIG['ChatFrame']['Blacklist'][dangqianwanjianame],guanjianzilist)
		shuaxintiquguanjianzi()
	end
	guanjianzi.F.guanjianzi.F.EB.YES:SetScript("OnClick", function(self, button)
		local ParentF = self:GetParent();
		ParentF:ClearFocus()
	end)
	---显示列表
	local function gengxin_hang_B(self)
		for id = 1, hang_NUM, 1 do	
			_G["Blk_List_"..id].txt:SetText();
			_G["Blk_List_"..id].del:Hide();
		end
		local ItemsNum = #PIG['ChatFrame']['Blacklist'][dangqianwanjianame];
		if ItemsNum>0 then
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hangH);
		    local offset = FauxScrollFrame_GetOffset(self);
			for id = 1, hang_NUM do
				local dangqian = id+offset;
				if PIG['ChatFrame']['Blacklist'][dangqianwanjianame][dangqian] then
					_G["Blk_List_"..id].del:Show();
					_G["Blk_List_"..id].del:SetID(dangqian);
					local guanjianzineironglianji = ""
					for xx=1,#PIG['ChatFrame']['Blacklist'][dangqianwanjianame][dangqian] do
						if PIG['ChatFrame']['Blacklist'][dangqianwanjianame][dangqian][xx] then
							if xx==#PIG['ChatFrame']['Blacklist'][dangqianwanjianame][dangqian] then
								guanjianzineironglianji=guanjianzineironglianji..PIG['ChatFrame']['Blacklist'][dangqianwanjianame][dangqian][xx]
							else
								guanjianzineironglianji=guanjianzineironglianji..PIG['ChatFrame']['Blacklist'][dangqianwanjianame][dangqian][xx]..","
							end
						end
					end
					_G["Blk_List_"..id].txt:SetText(guanjianzineironglianji);
				end
			end
		end
	end
	function guanjianzi.F.guanjianzi.F.daoru_B:SetValue(newValue)
		PIG['ChatFrame']['Blacklist'][dangqianwanjianame] = PIG['ChatFrame']['Blacklist'][newValue];
		gengxin_hang_B(guanjianzi.F.guanjianzi.F.BList.Scroll)
		CloseDropDownMenus()
	end
	guanjianzi.F.guanjianzi.F.BList = CreateFrame("Frame", nil, guanjianzi.F.guanjianzi.F);
	guanjianzi.F.guanjianzi.F.BList:SetSize(GJZW/2-6,hangH*8+10);
	guanjianzi.F.guanjianzi.F.BList:SetPoint("TOPLEFT", guanjianzi.F.guanjianzi.F, "TOPLEFT", GJZW/2+2, -48);
	guanjianzi.F.guanjianzi.F.BList.Scroll = CreateFrame("ScrollFrame",nil,guanjianzi.F.guanjianzi.F.BList, "FauxScrollFrameTemplate");  
	guanjianzi.F.guanjianzi.F.BList.Scroll:SetPoint("TOPLEFT",guanjianzi.F.guanjianzi.F.BList,"TOPLEFT",0,0);
	guanjianzi.F.guanjianzi.F.BList.Scroll:SetPoint("BOTTOMRIGHT",guanjianzi.F.guanjianzi.F.BList,"BOTTOMRIGHT",-18,0);
	guanjianzi.F.guanjianzi.F.BList.Scroll.ScrollBar:SetScale(0.8);
	guanjianzi.F.guanjianzi.F.BList.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hangH, gengxin_hang_B)
	end)
	for id = 1, hang_NUM, 1 do
		local Blk_List = CreateFrame("Frame", "Blk_List_"..id, guanjianzi.F.guanjianzi.F.BList.Scroll:GetParent());
		Blk_List:SetSize(guanjianzi.F.guanjianzi.F.BList:GetWidth()-18,hangH);
		if id==1 then
			Blk_List:SetPoint("TOPLEFT", guanjianzi.F.guanjianzi.F.BList.Scroll, "TOPLEFT", 0, -1);
		else
			Blk_List:SetPoint("TOPLEFT", _G["Blk_List_"..(id-1)], "BOTTOMLEFT", 0, -1);
		end	
		Blk_List.del = CreateFrame("Button",nil, Blk_List, "TruncatedButtonTemplate");
		Blk_List.del:SetSize(hangH-4,hangH-4);
		Blk_List.del:SetPoint("LEFT", Blk_List, "LEFT", 0,0);
		Blk_List.del.Tex = Blk_List.del:CreateTexture(nil, "BORDER");
		Blk_List.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		Blk_List.del.Tex:SetPoint("CENTER",0,-1);
		Blk_List.del.Tex:SetSize(hangH-10,hangH-10);
		Blk_List.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1,-2);
		end);
		Blk_List.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER",0,-1);
		end);
		Blk_List.del:SetScript("OnClick", function (self)
			table.remove(PIG['ChatFrame']['Blacklist'][dangqianwanjianame], self:GetID());
			shuaxintiquguanjianzi()
			gengxin_hang_B(guanjianzi.F.guanjianzi.F.BList.Scroll)
		end);	
		Blk_List.txt = Blk_List:CreateFontString();
		Blk_List.txt:SetPoint("LEFT", Blk_List.del, "RIGHT", 0, 0);
		Blk_List.txt:SetFontObject(ChatFontNormal);
		Blk_List.txt:SetTextColor(0.7, 0.7, 0.7, 1);
	end

	guanjianzi.F.guanjianzi.F.EB:SetScript("OnEditFocusLost", function(self)
		local guanjianV = self:GetText();
		SAVE_guanjianzi_B(guanjianV)
		gengxin_hang_B(guanjianzi.F.guanjianzi.F.BList.Scroll)
		self.tishi:Show()
		self.YES:Hide();
		self:SetText("");
	end);

	---打开关键字编辑UI
	guanjianzi.F.guanjianzi:RegisterForClicks("LeftButtonUp","RightButtonUp")
	guanjianzi.F.guanjianzi:SetScript("OnClick", function (self,button)
		if button=="LeftButton" then
			guanjianzi.F.shezhi.F:Hide()
			if guanjianzi.F.guanjianzi.F:IsShown() then
				guanjianzi.F.guanjianzi.F:Hide()
			else
				guanjianzi.F.guanjianzi.F:Show()
				gengxin_hang(guanjianzi.F.guanjianzi.F.WList.Scroll)
				gengxin_hang_B(guanjianzi.F.guanjianzi.F.BList.Scroll)
			end
		else
			ChatFrame99:Clear()
		end
	end);
	---=================================
	guanjianzi.F.guanjianzi.F.lineW = guanjianzi.F.guanjianzi.F:CreateLine()
	guanjianzi.F.guanjianzi.F.lineW:SetColorTexture(0.6,0.6,0.6,0.3)
	guanjianzi.F.guanjianzi.F.lineW:SetThickness(1);
	guanjianzi.F.guanjianzi.F.lineW:SetStartPoint("TOPLEFT",1,-236)
	guanjianzi.F.guanjianzi.F.lineW:SetEndPoint("TOPRIGHT",-1,-236)
	--关键字例子
	guanjianzi.F.guanjianzi.F.shili = guanjianzi.F.guanjianzi.F:CreateFontString();
	guanjianzi.F.guanjianzi.F.shili:SetPoint("TOPLEFT",guanjianzi.F.guanjianzi.F.lineW,"BOTTOMLEFT",4,-2);
	guanjianzi.F.guanjianzi.F.shili:SetFont(ChatFontNormal:GetFont(), 13,"OUTLINE")
	guanjianzi.F.guanjianzi.F.shili:SetWidth(GJZW/2-6);
	guanjianzi.F.guanjianzi.F.shili:SetJustifyH("LEFT");
	guanjianzi.F.guanjianzi.F.shili:SetText("|cff00FF00附魔：提取包含附魔的内容\n收,氪金：提取同时包含收和氪金的内容|r");
	guanjianzi.F.guanjianzi.F.shili = guanjianzi.F.guanjianzi.F:CreateFontString();
	guanjianzi.F.guanjianzi.F.shili:SetPoint("TOPLEFT",guanjianzi.F.guanjianzi.F.lineW,"BOTTOMLEFT",GJZW/2+4,-2);
	guanjianzi.F.guanjianzi.F.shili:SetFont(ChatFontNormal:GetFont(), 13,"OUTLINE")
	guanjianzi.F.guanjianzi.F.shili:SetWidth(GJZW/2-6);
	guanjianzi.F.guanjianzi.F.shili:SetJustifyH("LEFT");
	guanjianzi.F.guanjianzi.F.shili:SetText("|cffFFFF00AA：屏蔽包含AA的内容\n带,刷：屏蔽同时包含带和刷的内容|r");
	--==提取关键字=====================================================
	local QuickChat_biaoqingName=addonTable.QuickChat_biaoqingName
	local biaoqingTXT={}
	for i=1,#QuickChat_biaoqingName do
		local newvalueXxX = QuickChat_biaoqingName[i][2]:gsub("%-", "%%-");
		table.insert(biaoqingTXT,newvalueXxX)
	end
	----------
	local chongfufayanduibi={}--过滤重复发言临时
	PIG['ChatFrame']['xxxxxx']={}
	-- for i = 1, NUM_CHAT_WINDOWS do
	-- 	if ( i ~= 2 ) then
			--local chatID = _G["ChatFrame"..i]
			local chatID = ChatFrame1
			local msninfo = chatID.AddMessage
			local zijiname = GetUnitName("player", true)
			chatID.AddMessage = function(frame, text, ...)
				--table.insert(PIG['ChatFrame']['xxxxxx'],text);
				local cunzaigongongpindao=text:find("|Hchannel:channel:", 1)
				if cunzaigongongpindao then	
					local qishiweizhi,jieshuweizhi=text:find("]|h： ", 1)

					if jieshuweizhi then
						local newTextxxx=text:sub(1,qishiweizhi)
						local zijifayan=newTextxxx:find(zijiname, 1)
						if zijifayan and PIG['ChatFrame']['guolvzishen']=="ON" then
							return msninfo(frame, text, ...)
						end
						local newText=text:sub(jieshuweizhi, -1)
						--
						local newvaluefff =newText
						for i=1,#biaoqingTXT do
							newvaluefff = newvaluefff:gsub("|T"..biaoqingTXT[i]..":"..(PIG['ChatFrame']['FontSize_value']+2).."|t", "");
						end
						local newText=newvaluefff
						---
						local newText=newText:gsub("|Hitem:","");
						local newText=newText:gsub("|Hspell:","");
						local newText=newText:gsub("|Hquestie:(%d+):Player%-(%d+)%-(%w+)|h","");
						local newText=newText:gsub("|Hquest:","");
						local newText=newText:gsub("|h","");
						local newText=newText:gsub("|r","");
						local newText=newText:gsub("|cff%w%w%w%w%w%w","");
						local newText=newText:gsub(" ","");
						local newText=newText:upper()--转换大小写
						--print(newText)
						if not zijifayan and PIG['ChatFrame']['guolvchongfu']=="ON" then			
								local duibiText=newText
								local duibiText=duibiText:gsub("%p","");
								local duibiText=duibiText:gsub("，","");
								local duibiText=duibiText:gsub("。","");
								local duibiText=duibiText:gsub("！","");
								local duibiText=duibiText:gsub("：","");
								local duibiText=duibiText:gsub("；","");
								local duibiText=duibiText:gsub("“","");
								local duibiText=duibiText:gsub("”","");
								local duibiText=duibiText:gsub("‘","");
								local duibiText=duibiText:gsub("’","");
								local duibiText=duibiText:gsub("~","");
								local duibiText=duibiText:gsub("%s","");
								for i=#chongfufayanduibi,1,-1 do
									if (GetServerTime()-chongfufayanduibi[i][1])>60 then
										table.remove(chongfufayanduibi,i)
									end
								end
								for i=1,#chongfufayanduibi do
									if chongfufayanduibi[i][2]==duibiText then
										return false
									end
								end
								table.insert(chongfufayanduibi,{GetServerTime(),duibiText})
						end
						--屏蔽
						if #pingbilist>0 then
							guanjianzi.allCUNZAI_BLK = false;
							for x=1,#pingbilist do
								guanjianzi.allCUNZAI_BLK_C = true;
								for xx=1,#pingbilist[x] do
									local cunzaiguanjianzi=newText:find(pingbilist[x][xx], 1)
									if not cunzaiguanjianzi then
										guanjianzi.allCUNZAI_BLK_C = false
										break
									end
								end
								if guanjianzi.allCUNZAI_BLK_C then
									guanjianzi.allCUNZAI_BLK = true;
									break
								end
							end
							if guanjianzi.allCUNZAI_BLK then
								if PIG['ChatFrame']['xitongjihuoB']=="ON" then
									return false
								else
									return msninfo(frame, text, ...)
								end
							end
						end
						--提取
						if #tiquzijielist>0 then
							for x=1,#tiquzijielist do
								guanjianzi.ALLcunzai=true;	
								for xx=1,#tiquzijielist[x] do
									local cunzaiguanjianzi=newText:find(tiquzijielist[x][xx], 1)
									if not cunzaiguanjianzi then
										guanjianzi.ALLcunzai = false
										break
									end
								end
								if guanjianzi.ALLcunzai then						
									local text=text:gsub("寻求组队","组");
									local text=text:gsub("大脚世界频道","世");
									guanjianzi.F:AddMessage(text, ...);
									--guanjianzi.F:Show()
									guanjianziMGStishi()
									break
								end
							end
						end
						return msninfo(frame, text, ...)
					end
				else
					return msninfo(frame, text, ...)
				end
			end
	-- 	end
	-- end
end
---=================================================================
addonTable.ADD_guanjianzi_open = ADD_guanjianzi_open