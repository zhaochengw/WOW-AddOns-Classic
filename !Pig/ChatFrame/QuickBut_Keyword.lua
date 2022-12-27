local addonName, addonTable = ...;
local hangH = 22
local gsub = _G.string.gsub 
local find = _G.string.find
local sub = _G.string.sub 
local upper = _G.string.upper
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local Create=addonTable.Create
local PIGDownMenu=Create.PIGDownMenu
--===============================
local function fengeguanjianzi(str,delimiter)
    local dLen = string.len(delimiter)
    local newDeli = ""
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
	for x=1,#PIG["ChatFrame"]["Blacklist"][dangqianwanjianame] do
		pingbilist_ziji={}
		for xx=1,#PIG["ChatFrame"]["Blacklist"][dangqianwanjianame][x] do
			local tihuanteshuzifu=PIG["ChatFrame"]["Blacklist"][dangqianwanjianame][x][xx]
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
	for x=1,#PIG["ChatFrame"]["Keyword"][dangqianwanjianame] do
		tiquzijielist_ziji={}
		for xx=1,#PIG["ChatFrame"]["Keyword"][dangqianwanjianame][x] do
			local tihuanteshuzifu=PIG["ChatFrame"]["Keyword"][dangqianwanjianame][x][xx]
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
local function ADD_QuickBut_Keyword()
	local dangqianwanjianame = GetUnitName("player", true)
	if not PIG["ChatFrame"]["Keyword"][dangqianwanjianame] then PIG["ChatFrame"]["Keyword"][dangqianwanjianame]={} end
	if not PIG["ChatFrame"]["Blacklist"][dangqianwanjianame] then PIG["ChatFrame"]["Blacklist"][dangqianwanjianame]={} end
	shuaxintiquguanjianzi()
	local fuFrame=QuickChatFFF_UI
	local Width,Height,jiangejuli = 24,24,0;
	local ziframe = {fuFrame:GetChildren()}
	if PIG["ChatFrame"]["QuickChat_style"]==1 then
		fuFrame.Keyword = CreateFrame("Button",nil,fuFrame, "TruncatedButtonTemplate"); 
	elseif PIG["ChatFrame"]["QuickChat_style"]==2 then
		fuFrame.Keyword = CreateFrame("Button",nil,fuFrame, "UIMenuButtonStretchTemplate"); 
	end
	fuFrame.Keyword:SetSize(Width,Height);
	fuFrame.Keyword:SetPoint("LEFT",fuFrame,"LEFT",#ziframe*Width,0);
	fuFrame.Keyword.Tex = fuFrame.Keyword:CreateTexture();
	fuFrame.Keyword.Tex:SetTexture("interface/common/voicechat-on.blp");
	fuFrame.Keyword.Tex:SetSize(Width+2,Height-4);
	fuFrame.Keyword.Tex:SetPoint("CENTER", -7.5, 0);
	fuFrame.Keyword:SetScript("OnMouseDown",  function(self)
		self.Tex:SetPoint("CENTER", -6, -1.5);
	end)
	fuFrame.Keyword:SetScript("OnMouseUp",  function(self)
		self.Tex:SetPoint("CENTER", -7.5, 0);
	end)
	fuFrame.Keyword:SetScript("OnEnter", function (self)	
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:SetText("|cffFFFF00关键字提取|r");
		GameTooltip:Show();
		GameTooltip:FadeOut()
	end);
	fuFrame.Keyword:SetScript("OnLeave", function (self)
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	----
	fuFrame.Keyword.F = CreateFrame("ScrollingMessageFrame", "ChatFrame99", fuFrame.Keyword, "BackdropTemplate,ChatFrameTemplate")
	fuFrame.Keyword.F:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",} );
	fuFrame.Keyword.F:SetHeight(200);
	fuFrame.Keyword.F:SetFrameStrata("BACKGROUND")
	fuFrame.Keyword.F:EnableMouse(false)
	fuFrame.Keyword.F:UnregisterAllEvents()
	--fuFrame.Keyword.F:Clear() -- 清除框架中的消息 
	--fuFrame.Keyword.F:SetFadeDuration(seconds)--设置淡入淡出持续时间 
	--fuFrame.Keyword.F:SetTimeVisible(seconds)--设置消息显示时间
	--fuFrame.Keyword.F:SetFading(false)淡入淡出
	--fuFrame.Keyword.F:SetMaxLines(999) --设置可显示最大行数
	--fuFrame.Keyword.F:SetInsertMode(TOP or BOTTOM) --设置新消息的插入位置
	--fuFrame.Keyword.F:SetToplevel(true)--单击子项时框架是否应自行升起
   	--fuFrame.Keyword.F:EnableMouseWheel(false)-- 禁用鼠标滚动
	fuFrame.Keyword.F:SetHyperlinksEnabled(true)--可点击

	if PIG["ChatFrame"]["QuickChat_maodian"]==1 then
		fuFrame.Keyword.F:SetPoint("BOTTOMLEFT",DEFAULT_CHAT_FRAME,"TOPLEFT",-2,56);
		fuFrame.Keyword.F:SetPoint("BOTTOMRIGHT",DEFAULT_CHAT_FRAME,"TOPRIGHT",0,56);
	elseif PIG["ChatFrame"]["QuickChat_maodian"]==2 then
		fuFrame.Keyword.F:SetPoint("BOTTOMLEFT",DEFAULT_CHAT_FRAME,"TOPLEFT",-2,28);
		fuFrame.Keyword.F:SetPoint("BOTTOMRIGHT",DEFAULT_CHAT_FRAME,"TOPRIGHT",0,28);
	end
	if PIG["ChatFrame"]["FFShow"]=="ON" then
		fuFrame.Keyword.F:Show();
	else
		fuFrame.Keyword.F:Hide();
	end
	fuFrame.Keyword.F:HookScript("OnShow", function(self)
		PIG["ChatFrame"]["FFShow"]="ON"
		fuFrame.Keyword.youNEWxiaoxinlai=false;
	end);
	fuFrame.Keyword.F:HookScript("OnHide", function(self)
		PIG["ChatFrame"]["FFShow"]="OFF"
	end);
	fuFrame.Keyword.F:SetScript("OnMouseWheel", function(self, delta)
		if delta == 1 then
			fuFrame.Keyword.F:ScrollUp()
			fuFrame.Keyword.F.ScrollToBottomButton.hilight:Show();
		elseif delta == -1 then
			fuFrame.Keyword.F:ScrollDown()
			if fuFrame.Keyword.F:GetScrollOffset()==0 then
				fuFrame.Keyword.F.ScrollToBottomButton.hilight:Hide();
			end
		end
	end)
	fuFrame.Keyword.F.Center:SetPoint("TOPLEFT",fuFrame.Keyword.F,"TOPLEFT",-2,2);
	fuFrame.Keyword.F.Center:SetPoint("BOTTOMRIGHT",fuFrame.Keyword.F,"BOTTOMRIGHT",2,-2);
	---提醒
	fuFrame.Keyword.youNEWxiaoxinlai=false;
	local function guanjianziMGStishi()
		if fuFrame.Keyword.Tex:IsShown() then
			fuFrame.Keyword.Tex:Hide()
		else
			fuFrame.Keyword.Tex:Show()
		end
		if fuFrame.Keyword.youNEWxiaoxinlai then
			C_Timer.After(0.8,guanjianziMGStishi)
		else
			fuFrame.Keyword.Tex:Show()
		end
	end
	---翻页按钮=======================
	local anniudaxiaoF = 30
	fuFrame.Keyword.F.ScrollToBottomButton = CreateFrame("Button",nil,fuFrame.Keyword.F, "TruncatedButtonTemplate");
	fuFrame.Keyword.F.ScrollToBottomButton:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
	fuFrame.Keyword.F.ScrollToBottomButton:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	fuFrame.Keyword.F.ScrollToBottomButton:SetPushedTexture("interface/chatframe/ui-chaticon-scrollend-down.blp")
	fuFrame.Keyword.F.ScrollToBottomButton:SetSize(anniudaxiaoF,anniudaxiaoF);
	fuFrame.Keyword.F.ScrollToBottomButton:SetPoint("TOPRIGHT",fuFrame.Keyword.F,"TOPLEFT",-2,-60);
	fuFrame.Keyword.F.ScrollToBottomButton.hilight = fuFrame.Keyword.F.ScrollToBottomButton:CreateTexture(nil,"OVERLAY");
	fuFrame.Keyword.F.ScrollToBottomButton.hilight:SetTexture("interface/chatframe/ui-chaticon-blinkhilight.blp");
	fuFrame.Keyword.F.ScrollToBottomButton.hilight:SetSize(anniudaxiaoF,anniudaxiaoF);
	fuFrame.Keyword.F.ScrollToBottomButton.hilight:SetPoint("CENTER", 0, 0);
	fuFrame.Keyword.F.ScrollToBottomButton.hilight:Hide();

	-- fuFrame.Keyword.F.down = CreateFrame("Button",nil,fuFrame.Keyword.F, "TruncatedButtonTemplate");
	-- fuFrame.Keyword.F.down:SetNormalTexture("interface/chatframe/ui-chaticon-scrolldown-up.blp")
	-- fuFrame.Keyword.F.down:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	-- fuFrame.Keyword.F.down:SetPushedTexture("interface/chatframe/ui-chaticon-scrolldown-down.blp")
	-- fuFrame.Keyword.F.down:SetSize(anniudaxiaoF,anniudaxiaoF);
	-- fuFrame.Keyword.F.down:SetPoint("BOTTOM",fuFrame.Keyword.F.ScrollToBottomButton,"TOP",0,0);
	-- fuFrame.Keyword.F.up = CreateFrame("Button",nil,fuFrame.Keyword.F, "TruncatedButtonTemplate");
	-- fuFrame.Keyword.F.up:SetNormalTexture("interface/chatframe/ui-chaticon-scrollup-up.blp")
	-- fuFrame.Keyword.F.up:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	-- fuFrame.Keyword.F.up:SetPushedTexture("interface/chatframe/ui-chaticon-scrollup-down.blp")
	-- fuFrame.Keyword.F.up:SetSize(anniudaxiaoF,anniudaxiaoF);
	-- fuFrame.Keyword.F.up:SetPoint("BOTTOM",fuFrame.Keyword.F.down,"TOP",0,0);
	---------
	fuFrame.Keyword.F.ScrollToBottomButton:SetScript("OnClick", function (self)
		fuFrame.Keyword.F:ScrollToBottom()
		fuFrame.Keyword.F.ScrollToBottomButton.hilight:Hide();
	end);
	-- fuFrame.Keyword.F.up:SetScript("OnClick", function (self)
	-- 	fuFrame.Keyword.F:ScrollUp()
	-- 	fuFrame.Keyword.F.ScrollToBottomButton.hilight:Show();
	-- end);
	-- fuFrame.Keyword.F.down:SetScript("OnClick", function (self)
	-- 	fuFrame.Keyword.F:ScrollDown()
	-- 	if fuFrame.Keyword.F:GetScrollOffset()==0 then
	-- 		fuFrame.Keyword.F.ScrollToBottomButton.hilight:Hide();
	-- 	end
	-- end);
	fuFrame.Keyword:SetScript("OnClick", function(self)
		if self.F:IsShown() then
			self.F:Hide()
		else
			self.F:Show()
		end
	end);

	--设置=====================================
	fuFrame.Keyword.F.shezhi = CreateFrame("Button",nil,fuFrame.Keyword.F, "TruncatedButtonTemplate");
	fuFrame.Keyword.F.shezhi:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	fuFrame.Keyword.F.shezhi:SetSize(hangH,hangH);
	fuFrame.Keyword.F.shezhi:SetPoint("BOTTOM",fuFrame.Keyword.F.ScrollToBottomButton,"TOP",0,6);
	fuFrame.Keyword.F.shezhi.Tex = fuFrame.Keyword.F.shezhi:CreateTexture(nil, "BORDER");
	fuFrame.Keyword.F.shezhi.Tex:SetTexture("interface/gossipframe/bindergossipicon.blp");
	fuFrame.Keyword.F.shezhi.Tex:SetPoint("CENTER");
	fuFrame.Keyword.F.shezhi.Tex:SetSize(hangH-4,hangH-4);
	fuFrame.Keyword.F.shezhi:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.2,-1.2);
	end);
	fuFrame.Keyword.F.shezhi:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	fuFrame.Keyword.F.shezhi:SetScript("OnClick", function (self)
		if fuFrame.Keyword.F.shezhi.F:IsShown() then
			fuFrame.Keyword.F.shezhi.F:Hide()
		else
			fuFrame.Keyword.F.shezhi.F:Show()
		end
	end);
	local shezhiW ,shezhiH=260,220
	fuFrame.Keyword.F.shezhi.F = CreateFrame("Frame", nil, fuFrame.Keyword.F.shezhi,"BackdropTemplate");
	fuFrame.Keyword.F.shezhi.F:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 4,} );
	fuFrame.Keyword.F.shezhi.F:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
	fuFrame.Keyword.F.shezhi.F:SetSize(shezhiW,shezhiH);
	fuFrame.Keyword.F.shezhi.F:SetPoint("BOTTOMLEFT",fuFrame.Keyword.F,"BOTTOMRIGHT",30,0);
	fuFrame.Keyword.F.shezhi.F:Hide()
	fuFrame.Keyword.F.shezhi.F:SetFrameStrata("LOW")
	fuFrame.Keyword.F.shezhi.F.COS = CreateFrame("Button",nil,fuFrame.Keyword.F.shezhi.F,"UIPanelCloseButton");
	fuFrame.Keyword.F.shezhi.F.COS:SetSize(28,28);
	fuFrame.Keyword.F.shezhi.F.COS:SetPoint("TOPRIGHT",fuFrame.Keyword.F.shezhi.F,"TOPRIGHT",0,0);

	fuFrame.Keyword.F.shezhi:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.5,-1.5);
	end);
	fuFrame.Keyword.F.shezhi:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	fuFrame.Keyword.F.shezhi:SetScript("OnClick", function (self)
		fuFrame.Keyword.F.Keyword.F:Hide()
		if fuFrame.Keyword.F.shezhi.F:IsShown() then
			fuFrame.Keyword.F.shezhi.F:Hide()
		else
			fuFrame.Keyword.F.shezhi.F:Show()
		end
	end);
	--高度
	fuFrame.Keyword.F.shezhi.F.GaoduH = fuFrame.Keyword.F.shezhi.F:CreateFontString();
	fuFrame.Keyword.F.shezhi.F.GaoduH:SetPoint("TOPLEFT",fuFrame.Keyword.F.shezhi.F,"TOPLEFT",20,-20);
	fuFrame.Keyword.F.shezhi.F.GaoduH:SetFontObject(GameFontNormal);
	fuFrame.Keyword.F.shezhi.F.GaoduH:SetText("高度：");
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider = CreateFrame("Slider", nil, fuFrame.Keyword.F.shezhi.F, "OptionsSliderTemplate")
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider:SetSize(120,14);
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider:SetPoint("LEFT",fuFrame.Keyword.F.shezhi.F.GaoduH,"RIGHT",10,0);
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider.tooltipText = "拖动滑块或者用鼠标滚轮调整数值";
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider.Low:SetText("100");
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider.High:SetText("500");
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider:SetMinMaxValues(100, 500);
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider:SetValueStep(1);
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider:SetObeyStepOnDrag(true);
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider:EnableMouseWheel(true);--接受滚轮输入
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider:SetScript("OnMouseWheel", function(self, arg1)
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
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider:SetScript("OnValueChanged", function(self)
		local val = self:GetValue()
		self.Text:SetText(val);
		fuFrame.Keyword.F:SetHeight(val)
		PIG["ChatFrame"]["gaoduH"]=val
	end)
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider.Text:SetText(PIG["ChatFrame"]["gaoduH"]);
	fuFrame.Keyword.F.shezhi.F.GaoduHSlider:SetValue(PIG["ChatFrame"]["gaoduH"]);

	fuFrame.Keyword.F.shezhi.F.toumingdu = fuFrame.Keyword.F.shezhi.F:CreateFontString();
	fuFrame.Keyword.F.shezhi.F.toumingdu:SetPoint("TOPLEFT",fuFrame.Keyword.F.shezhi.F,"TOPLEFT",20,-70);
	fuFrame.Keyword.F.shezhi.F.toumingdu:SetFontObject(GameFontNormal);
	fuFrame.Keyword.F.shezhi.F.toumingdu:SetText("透明度：");
	fuFrame.Keyword.F.shezhi.F.toumingduSlider = CreateFrame("Slider", nil, fuFrame.Keyword.F.shezhi.F, "OptionsSliderTemplate")
	fuFrame.Keyword.F.shezhi.F.toumingduSlider:SetSize(120,14);
	fuFrame.Keyword.F.shezhi.F.toumingduSlider:SetPoint("LEFT",fuFrame.Keyword.F.shezhi.F.toumingdu,"RIGHT",10,0);
	fuFrame.Keyword.F.shezhi.F.toumingduSlider.tooltipText = "拖动滑块或者用鼠标滚轮调整数值";
	fuFrame.Keyword.F.shezhi.F.toumingduSlider.Low:SetText("0");
	fuFrame.Keyword.F.shezhi.F.toumingduSlider.High:SetText("1");
	fuFrame.Keyword.F.shezhi.F.toumingduSlider:SetMinMaxValues(0, 1);
	fuFrame.Keyword.F.shezhi.F.toumingduSlider:SetValueStep(0.1);
	fuFrame.Keyword.F.shezhi.F.toumingduSlider:SetObeyStepOnDrag(true);
	fuFrame.Keyword.F.shezhi.F.toumingduSlider:EnableMouseWheel(true);--接受滚轮输入
	fuFrame.Keyword.F.shezhi.F.toumingduSlider:SetScript("OnMouseWheel", function(self, arg1)
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
	fuFrame.Keyword.F.shezhi.F.toumingduSlider:SetScript("OnValueChanged", function(self)
		local val = self:GetValue()
		fuFrame.Keyword.F:SetBackdropColor(0, 0, 0, val);
		--fuFrame.Keyword.F:SetBackdropBorderColor(1, 1, 1, val);
		self.Text:SetText((floor(val*10+0.5))/10);
		PIG["ChatFrame"]["toumingdu"]=val
	end)
	fuFrame.Keyword.F.shezhi.F.toumingduSlider.Text:SetText(PIG["ChatFrame"]["toumingdu"]);
	fuFrame.Keyword.F.shezhi.F.toumingduSlider:SetValue(PIG["ChatFrame"]["toumingdu"]);

	--选项
	local XXX,YYY = 26,28
	fuFrame.Keyword.F.shezhi.F.fanyejian = ADD_Checkbutton(nil,fuFrame.Keyword.F.shezhi.F,-100,"TOPLEFT",fuFrame.Keyword.F.shezhi.F,"TOPLEFT",10,-100,"菜单显示在右侧","菜单显示在右侧")
	fuFrame.Keyword.F.shezhi.F.fanyejian:SetSize(XXX,YYY);
	fuFrame.Keyword.F.shezhi.F.fanyejian:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["ChatFrame"]["fanyejianR"]="ON"
			fuFrame.Keyword.F.ScrollToBottomButton:ClearAllPoints();
			fuFrame.Keyword.F.ScrollToBottomButton:SetPoint("TOPLEFT",fuFrame.Keyword.F,"TOPRIGHT",2,-60);
		else
			PIG["ChatFrame"]["fanyejianR"]="OFF"
			fuFrame.Keyword.F.ScrollToBottomButton:ClearAllPoints();
			fuFrame.Keyword.F.ScrollToBottomButton:SetPoint("TOPRIGHT",fuFrame.Keyword.F,"TOPLEFT",-2,-60);
		end
	end);
	if PIG["ChatFrame"]["fanyejianR"]=="ON" then
		fuFrame.Keyword.F.shezhi.F.fanyejian:SetChecked(true)
		fuFrame.Keyword.F.ScrollToBottomButton:ClearAllPoints();
		fuFrame.Keyword.F.ScrollToBottomButton:SetPoint("TOPLEFT",fuFrame.Keyword.F,"TOPRIGHT",2,-60);
	end

	fuFrame.Keyword.F.shezhi.F.guolvzishen = ADD_Checkbutton(nil,fuFrame.Keyword.F.shezhi.F,-100,"TOPLEFT",fuFrame.Keyword.F.shezhi.F,"TOPLEFT",10,-130,"不显示自身发言","不显示自身发言")
	fuFrame.Keyword.F.shezhi.F.guolvzishen:SetSize(XXX,YYY);
	fuFrame.Keyword.F.shezhi.F.guolvzishen:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["ChatFrame"]["guolvzishen"]="ON"
		else
			PIG["ChatFrame"]["guolvzishen"]="OFF"
		end
	end);
	if PIG["ChatFrame"]["guolvzishen"]=="ON" then
		fuFrame.Keyword.F.shezhi.F.guolvzishen:SetChecked(true)
	end
	--
	fuFrame.Keyword.F.shezhi.F.xitongjihuoB = ADD_Checkbutton(nil,fuFrame.Keyword.F.shezhi.F,-100,"TOPLEFT",fuFrame.Keyword.F.shezhi.F,"TOPLEFT",10,-160,"启用系统聊天黑名单","开起后黑名单也会对系统聊天栏生效，否则只对提取聊天栏生效")
	fuFrame.Keyword.F.shezhi.F.xitongjihuoB:SetSize(XXX,YYY);
	fuFrame.Keyword.F.shezhi.F.xitongjihuoB:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["ChatFrame"]["xitongjihuoB"]="ON"
		else
			PIG["ChatFrame"]["xitongjihuoB"]="OFF"
		end
	end);
	if PIG["ChatFrame"]["xitongjihuoB"]=="ON" then
		fuFrame.Keyword.F.shezhi.F.xitongjihuoB:SetChecked(true)
	end
	--
	fuFrame.Keyword.F.shezhi.F.guolvchongfu = ADD_Checkbutton(nil,fuFrame.Keyword.F.shezhi.F,-100,"TOPLEFT",fuFrame.Keyword.F.shezhi.F,"TOPLEFT",10,-190,"过滤重复发言","过滤1分钟之内的重复发言(此功能也会对系统聊天栏生效)")
	fuFrame.Keyword.F.shezhi.F.guolvchongfu:SetSize(XXX,YYY);
	fuFrame.Keyword.F.shezhi.F.guolvchongfu:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["ChatFrame"]["guolvchongfu"]="ON"
		else
			PIG["ChatFrame"]["guolvchongfu"]="OFF"
		end
	end);
	if PIG["ChatFrame"]["guolvchongfu"]=="ON" then
		fuFrame.Keyword.F.shezhi.F.guolvchongfu:SetChecked(true)
	end
	--编辑关键字/黑名单================================
	fuFrame.Keyword.F.Keyword = CreateFrame("Button",nil,fuFrame.Keyword.F, "TruncatedButtonTemplate");
	fuFrame.Keyword.F.Keyword:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	fuFrame.Keyword.F.Keyword:SetSize(hangH,hangH);
	fuFrame.Keyword.F.Keyword:SetPoint("BOTTOM",fuFrame.Keyword.F.shezhi,"TOP",0,6);
	fuFrame.Keyword.F.Keyword.Tex = fuFrame.Keyword.F.Keyword:CreateTexture(nil, "BORDER");
	fuFrame.Keyword.F.Keyword.Tex:SetTexture("interface/buttons/ui-guildbutton-publicnote-up.blp");
	fuFrame.Keyword.F.Keyword.Tex:SetPoint("CENTER");
	fuFrame.Keyword.F.Keyword.Tex:SetSize(hangH-4,hangH-4);
	fuFrame.Keyword.F.Keyword:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.2,-1.2);
	end);
	fuFrame.Keyword.F.Keyword:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);

	local GJZW ,GJZH=400,300
	fuFrame.Keyword.F.Keyword.F = CreateFrame("Frame", nil, fuFrame.Keyword.F.Keyword,"BackdropTemplate");
	fuFrame.Keyword.F.Keyword.F:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 4} );
	fuFrame.Keyword.F.Keyword.F:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
	fuFrame.Keyword.F.Keyword.F:SetSize(GJZW ,GJZH);
	fuFrame.Keyword.F.Keyword.F:SetPoint("BOTTOMLEFT",fuFrame.Keyword.F,"BOTTOMRIGHT",30,0);
	fuFrame.Keyword.F.Keyword.F:Hide()
	fuFrame.Keyword.F.Keyword.F:SetFrameStrata("LOW")
	fuFrame.Keyword.F.Keyword.F.COS = CreateFrame("Button",nil,fuFrame.Keyword.F.Keyword.F,"UIPanelCloseButton");
	fuFrame.Keyword.F.Keyword.F.COS:SetSize(26,26);
	fuFrame.Keyword.F.Keyword.F.COS:SetPoint("TOPRIGHT",fuFrame.Keyword.F.Keyword.F,"TOPRIGHT",4,3);

	fuFrame.Keyword.F.Keyword.F.line = fuFrame.Keyword.F.Keyword.F:CreateLine()
	fuFrame.Keyword.F.Keyword.F.line:SetColorTexture(0.6,0.6,0.6,0.3)
	fuFrame.Keyword.F.Keyword.F.line:SetThickness(1);
	fuFrame.Keyword.F.Keyword.F.line:SetStartPoint("TOPLEFT",1,-22)
	fuFrame.Keyword.F.Keyword.F.line:SetEndPoint("TOPRIGHT",-1,-22)

	fuFrame.Keyword.F.Keyword.F.line1 = fuFrame.Keyword.F.Keyword.F:CreateLine()
	fuFrame.Keyword.F.Keyword.F.line1:SetColorTexture(0.6,0.6,0.6,0.3)
	fuFrame.Keyword.F.Keyword.F.line1:SetThickness(1);
	fuFrame.Keyword.F.Keyword.F.line1:SetStartPoint("TOP",0,-1)
	fuFrame.Keyword.F.Keyword.F.line1:SetEndPoint("BOTTOM",0,1)
	--关键字
	fuFrame.Keyword.F.Keyword.F.T = fuFrame.Keyword.F.Keyword.F:CreateFontString();
	fuFrame.Keyword.F.Keyword.F.T:SetPoint("TOPLEFT",fuFrame.Keyword.F.Keyword.F,"TOPLEFT",8,-4);
	fuFrame.Keyword.F.Keyword.F.T:SetFontObject(GameFontNormal);
	fuFrame.Keyword.F.Keyword.F.T:SetText("\124cff00ff00提取关键字\124r");
	fuFrame.Keyword.F.Keyword.F.daoru=PIGDownMenu(nil,{70,24},fuFrame.Keyword.F.Keyword.F,{"LEFT",fuFrame.Keyword.F.Keyword.F.T,"RIGHT", 4,0})
	fuFrame.Keyword.F.Keyword.F.daoru:SetScale(0.8)
	fuFrame.Keyword.F.Keyword.F.daoru:PIGDownMenu_SetText("导入")
	function fuFrame.Keyword.F.Keyword.F.daoru:PIGDownMenu_Update_But(self)
		local jueseListLL = PIG["ChatFrame"]["Keyword"];
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for k,v in pairs(jueseListLL) do
			if k~=dangqianwanjianame then
				info.text, info.arg1 = "导入["..k.."]("..#v..")", k
				info.notCheckable = true;
				fuFrame.Keyword.F.Keyword.F.daoru:PIGDownMenu_AddButton(info)
			end
		end
	end

	fuFrame.Keyword.F.Keyword.F.EW = CreateFrame("EditBox", nil, fuFrame.Keyword.F.Keyword.F,"InputBoxInstructionsTemplate");
	fuFrame.Keyword.F.Keyword.F.EW:SetSize(GJZW/2-46,hangH);
	fuFrame.Keyword.F.Keyword.F.EW:SetPoint("TOPLEFT", fuFrame.Keyword.F.Keyword.F.line, "BOTTOMLEFT", 10,-2);
	fuFrame.Keyword.F.Keyword.F.EW:SetFontObject(ChatFontNormal);
	fuFrame.Keyword.F.Keyword.F.EW:SetMaxLetters(30);
	fuFrame.Keyword.F.Keyword.F.EW:SetAutoFocus(false);
	fuFrame.Keyword.F.Keyword.F.EW.tishi = fuFrame.Keyword.F.Keyword.F:CreateFontString();
	fuFrame.Keyword.F.Keyword.F.EW.tishi:SetPoint("LEFT",fuFrame.Keyword.F.Keyword.F.EW,"LEFT",6,0);
	fuFrame.Keyword.F.Keyword.F.EW.tishi:SetFont(ChatFontNormal:GetFont(), 12,"OUTLINE")
	fuFrame.Keyword.F.Keyword.F.EW.tishi:SetText("输入关键字(用,分隔)");
	fuFrame.Keyword.F.Keyword.F.EW.tishi:SetTextColor(0.8, 0.8, 0.8, 0.8);
	fuFrame.Keyword.F.Keyword.F.EW:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
	end);
	fuFrame.Keyword.F.Keyword.F.EW:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus()
	end);
	fuFrame.Keyword.F.Keyword.F.EW:SetScript("OnEditFocusGained", function(self)
		self.tishi:Hide()
		self.YES:Show();
	end);

	fuFrame.Keyword.F.Keyword.F.EW.YES = CreateFrame("Button",nil,fuFrame.Keyword.F.Keyword.F.EW, "UIPanelButtonTemplate");
	fuFrame.Keyword.F.Keyword.F.EW.YES:SetSize(hangH+6,hangH-2);
	fuFrame.Keyword.F.Keyword.F.EW.YES:SetPoint("LEFT",fuFrame.Keyword.F.Keyword.F.EW,"RIGHT",6,0);
	fuFrame.Keyword.F.Keyword.F.EW.YES:SetText("确定");
	fuFrame.Keyword.F.Keyword.F.EW.YES:Hide();
	local buttonFont=fuFrame.Keyword.F.Keyword.F.EW.YES:GetFontString()
	buttonFont:SetFont(ChatFontNormal:GetFont(), 9);

	local function SAVE_guanjianzi(value)
		local value = value:gsub(" ", "")
		if value=="" then return end
		local value = value:gsub("，", ",")
		local guanjianzilist = fengeguanjianzi(value, ",")
		table.insert(PIG["ChatFrame"]["Keyword"][dangqianwanjianame],guanjianzilist)
		shuaxintiquguanjianzi()
	end
	fuFrame.Keyword.F.Keyword.F.EW.YES:SetScript("OnClick", function(self, button)
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
		local ItemsNum = #PIG["ChatFrame"]["Keyword"][dangqianwanjianame];
		if ItemsNum>0 then
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hangH);
		    local offset = FauxScrollFrame_GetOffset(self);
			for id = 1, hang_NUM do
				local dangqian = id+offset;
				if PIG["ChatFrame"]["Keyword"][dangqianwanjianame][dangqian] then
					_G["Bmd_List_"..id].del:Show();
					_G["Bmd_List_"..id].del:SetID(dangqian);
					local guanjianzineironglianji = ""
					for xx=1,#PIG["ChatFrame"]["Keyword"][dangqianwanjianame][dangqian] do
						if PIG["ChatFrame"]["Keyword"][dangqianwanjianame][dangqian][xx] then
							if xx==#PIG["ChatFrame"]["Keyword"][dangqianwanjianame][dangqian] then
								guanjianzineironglianji=guanjianzineironglianji..PIG["ChatFrame"]["Keyword"][dangqianwanjianame][dangqian][xx]
							else
								guanjianzineironglianji=guanjianzineironglianji..PIG["ChatFrame"]["Keyword"][dangqianwanjianame][dangqian][xx]..","
							end
						end
					end
					_G["Bmd_List_"..id].txt:SetText(guanjianzineironglianji);
				end
			end
		end
	end
	function fuFrame.Keyword.F.Keyword.F.daoru:PIGDownMenu_SetValue(value,arg1,arg2)	
		PIG["ChatFrame"]["Keyword"][dangqianwanjianame] = PIG["ChatFrame"]["Keyword"][arg1];
		gengxin_hang(fuFrame.Keyword.F.Keyword.F.WList.Scroll)
		PIGCloseDropDownMenus()
	end
	fuFrame.Keyword.F.Keyword.F.WList = CreateFrame("Frame", nil, fuFrame.Keyword.F.Keyword.F);
	fuFrame.Keyword.F.Keyword.F.WList:SetSize(GJZW/2-6,hangH*8+10);
	fuFrame.Keyword.F.Keyword.F.WList:SetPoint("TOPLEFT", fuFrame.Keyword.F.Keyword.F, "TOPLEFT", 2, -48);
	fuFrame.Keyword.F.Keyword.F.WList.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.Keyword.F.Keyword.F.WList, "FauxScrollFrameTemplate");  
	fuFrame.Keyword.F.Keyword.F.WList.Scroll:SetPoint("TOPLEFT",fuFrame.Keyword.F.Keyword.F.WList,"TOPLEFT",0,0);
	fuFrame.Keyword.F.Keyword.F.WList.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.Keyword.F.Keyword.F.WList,"BOTTOMRIGHT",-18,0);
	fuFrame.Keyword.F.Keyword.F.WList.Scroll.ScrollBar:SetScale(0.8);
	fuFrame.Keyword.F.Keyword.F.WList.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hangH, gengxin_hang)
	end)
	for id = 1, hang_NUM, 1 do
		local Bmd_List = CreateFrame("Frame", "Bmd_List_"..id, fuFrame.Keyword.F.Keyword.F.WList.Scroll:GetParent());
		Bmd_List:SetSize(fuFrame.Keyword.F.Keyword.F.WList:GetWidth()-18,hangH);
		if id==1 then
			Bmd_List:SetPoint("TOPLEFT", fuFrame.Keyword.F.Keyword.F.WList.Scroll, "TOPLEFT", 0, -1);
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
			table.remove(PIG["ChatFrame"]["Keyword"][dangqianwanjianame], self:GetID());
			shuaxintiquguanjianzi()
			gengxin_hang(fuFrame.Keyword.F.Keyword.F.WList.Scroll)
		end);	
		Bmd_List.txt = Bmd_List:CreateFontString();
		Bmd_List.txt:SetPoint("LEFT", Bmd_List.del, "RIGHT", 0, 0);
		Bmd_List.txt:SetFontObject(ChatFontNormal);
		Bmd_List.txt:SetTextColor(0.7, 0.7, 0.7, 1);
	end
	fuFrame.Keyword.F.Keyword.F.EW:SetScript("OnEditFocusLost", function(self)
		local guanjianV = self:GetText();
		SAVE_guanjianzi(guanjianV)
		gengxin_hang(fuFrame.Keyword.F.Keyword.F.WList.Scroll)
		self.tishi:Show()
		self.YES:Hide();
		self:SetText("");
	end);

	--黑名单
	fuFrame.Keyword.F.Keyword.F.T1 = fuFrame.Keyword.F.Keyword.F:CreateFontString();
	fuFrame.Keyword.F.Keyword.F.T1:SetPoint("TOPLEFT",fuFrame.Keyword.F.Keyword.F,"TOPLEFT",208,-4);
	fuFrame.Keyword.F.Keyword.F.T1:SetFontObject(GameFontNormal);
	fuFrame.Keyword.F.Keyword.F.T1:SetText("\124cffFFff00过滤黑名单\124r");
	fuFrame.Keyword.F.Keyword.F.daoru_B=PIGDownMenu(nil,{70,24},fuFrame.Keyword.F.Keyword.F,{"LEFT",fuFrame.Keyword.F.Keyword.F.T1,"RIGHT", 4,0})
	fuFrame.Keyword.F.Keyword.F.daoru_B:SetScale(0.8)
	fuFrame.Keyword.F.Keyword.F.daoru_B:PIGDownMenu_SetText("导入")
	function fuFrame.Keyword.F.Keyword.F.daoru_B:PIGDownMenu_Update_But(self)
		local jueseListxx = PIG["ChatFrame"]["Blacklist"];
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for k,v in pairs(jueseListxx) do
			if k~=dangqianwanjianame then
				info.text, info.arg1 = "导入["..k.."]("..#v..")", k
				info.notCheckable = true;
				fuFrame.Keyword.F.Keyword.F.daoru_B:PIGDownMenu_AddButton(info)
			end
		end
	end

	fuFrame.Keyword.F.Keyword.F.EB = CreateFrame("EditBox", nil, fuFrame.Keyword.F.Keyword.F,"InputBoxInstructionsTemplate");
	fuFrame.Keyword.F.Keyword.F.EB:SetSize(GJZW/2-46,hangH);
	fuFrame.Keyword.F.Keyword.F.EB:SetPoint("TOPLEFT", fuFrame.Keyword.F.Keyword.F.line, "BOTTOMLEFT", GJZW/2+10,-2);
	fuFrame.Keyword.F.Keyword.F.EB:SetFontObject(ChatFontNormal);
	fuFrame.Keyword.F.Keyword.F.EB:SetMaxLetters(30);
	fuFrame.Keyword.F.Keyword.F.EB:SetAutoFocus(false);
	fuFrame.Keyword.F.Keyword.F.EB.tishi = fuFrame.Keyword.F.Keyword.F:CreateFontString();
	fuFrame.Keyword.F.Keyword.F.EB.tishi:SetPoint("LEFT",fuFrame.Keyword.F.Keyword.F.EB,"LEFT",6,0);
	fuFrame.Keyword.F.Keyword.F.EB.tishi:SetFont(ChatFontNormal:GetFont(), 12,"OUTLINE")
	fuFrame.Keyword.F.Keyword.F.EB.tishi:SetText("输入关键字(用,分隔)");
	fuFrame.Keyword.F.Keyword.F.EB.tishi:SetTextColor(0.8, 0.8, 0.8, 0.8);
	fuFrame.Keyword.F.Keyword.F.EB:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
	end);
	fuFrame.Keyword.F.Keyword.F.EB:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus()
	end);
	fuFrame.Keyword.F.Keyword.F.EB:SetScript("OnEditFocusGained", function(self)
		self.tishi:Hide()
		self.YES:Show();
	end);

	fuFrame.Keyword.F.Keyword.F.EB.YES = CreateFrame("Button",nil,fuFrame.Keyword.F.Keyword.F.EB, "UIPanelButtonTemplate");
	fuFrame.Keyword.F.Keyword.F.EB.YES:SetSize(hangH+6,hangH-2);
	fuFrame.Keyword.F.Keyword.F.EB.YES:SetPoint("LEFT",fuFrame.Keyword.F.Keyword.F.EB,"RIGHT",6,0);
	fuFrame.Keyword.F.Keyword.F.EB.YES:SetText("确定");
	fuFrame.Keyword.F.Keyword.F.EB.YES:Hide();
	local buttonFont=fuFrame.Keyword.F.Keyword.F.EB.YES:GetFontString()
	buttonFont:SetFont(ChatFontNormal:GetFont(), 9);

	local function SAVE_guanjianzi_B(value)
		local value = value:gsub(" ", "")
		if value=="" then return end
		local value = value:gsub("，", ",")
		local guanjianzilist = fengeguanjianzi(value, ",")
		table.insert(PIG["ChatFrame"]["Blacklist"][dangqianwanjianame],guanjianzilist)
		shuaxintiquguanjianzi()
	end
	fuFrame.Keyword.F.Keyword.F.EB.YES:SetScript("OnClick", function(self, button)
		local ParentF = self:GetParent();
		ParentF:ClearFocus()
	end)
	---显示列表
	local function gengxin_hang_B(self)
		for id = 1, hang_NUM, 1 do	
			_G["Blk_List_"..id].txt:SetText();
			_G["Blk_List_"..id].del:Hide();
		end
		local ItemsNum = #PIG["ChatFrame"]["Blacklist"][dangqianwanjianame];
		if ItemsNum>0 then
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hangH);
		    local offset = FauxScrollFrame_GetOffset(self);
			for id = 1, hang_NUM do
				local dangqian = id+offset;
				if PIG["ChatFrame"]["Blacklist"][dangqianwanjianame][dangqian] then
					_G["Blk_List_"..id].del:Show();
					_G["Blk_List_"..id].del:SetID(dangqian);
					local guanjianzineironglianji = ""
					for xx=1,#PIG["ChatFrame"]["Blacklist"][dangqianwanjianame][dangqian] do
						if PIG["ChatFrame"]["Blacklist"][dangqianwanjianame][dangqian][xx] then
							if xx==#PIG["ChatFrame"]["Blacklist"][dangqianwanjianame][dangqian] then
								guanjianzineironglianji=guanjianzineironglianji..PIG["ChatFrame"]["Blacklist"][dangqianwanjianame][dangqian][xx]
							else
								guanjianzineironglianji=guanjianzineironglianji..PIG["ChatFrame"]["Blacklist"][dangqianwanjianame][dangqian][xx]..","
							end
						end
					end
					_G["Blk_List_"..id].txt:SetText(guanjianzineironglianji);
				end
			end
		end
	end
	function fuFrame.Keyword.F.Keyword.F.daoru_B:PIGDownMenu_SetValue(value,arg1,arg2)	
		PIG["ChatFrame"]["Blacklist"][dangqianwanjianame] = PIG["ChatFrame"]["Blacklist"][arg1];
		gengxin_hang_B(fuFrame.Keyword.F.Keyword.F.BList.Scroll)
		PIGCloseDropDownMenus()
	end
	---
	fuFrame.Keyword.F.Keyword.F.BList = CreateFrame("Frame", nil, fuFrame.Keyword.F.Keyword.F);
	fuFrame.Keyword.F.Keyword.F.BList:SetSize(GJZW/2-6,hangH*8+10);
	fuFrame.Keyword.F.Keyword.F.BList:SetPoint("TOPLEFT", fuFrame.Keyword.F.Keyword.F, "TOPLEFT", GJZW/2+2, -48);
	fuFrame.Keyword.F.Keyword.F.BList.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.Keyword.F.Keyword.F.BList, "FauxScrollFrameTemplate");  
	fuFrame.Keyword.F.Keyword.F.BList.Scroll:SetPoint("TOPLEFT",fuFrame.Keyword.F.Keyword.F.BList,"TOPLEFT",0,0);
	fuFrame.Keyword.F.Keyword.F.BList.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.Keyword.F.Keyword.F.BList,"BOTTOMRIGHT",-18,0);
	fuFrame.Keyword.F.Keyword.F.BList.Scroll.ScrollBar:SetScale(0.8);
	fuFrame.Keyword.F.Keyword.F.BList.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hangH, gengxin_hang_B)
	end)
	for id = 1, hang_NUM, 1 do
		local Blk_List = CreateFrame("Frame", "Blk_List_"..id, fuFrame.Keyword.F.Keyword.F.BList.Scroll:GetParent());
		Blk_List:SetSize(fuFrame.Keyword.F.Keyword.F.BList:GetWidth()-18,hangH);
		if id==1 then
			Blk_List:SetPoint("TOPLEFT", fuFrame.Keyword.F.Keyword.F.BList.Scroll, "TOPLEFT", 0, -1);
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
			table.remove(PIG["ChatFrame"]["Blacklist"][dangqianwanjianame], self:GetID());
			shuaxintiquguanjianzi()
			gengxin_hang_B(fuFrame.Keyword.F.Keyword.F.BList.Scroll)
		end);	
		Blk_List.txt = Blk_List:CreateFontString();
		Blk_List.txt:SetPoint("LEFT", Blk_List.del, "RIGHT", 0, 0);
		Blk_List.txt:SetFontObject(ChatFontNormal);
		Blk_List.txt:SetTextColor(0.7, 0.7, 0.7, 1);
	end

	fuFrame.Keyword.F.Keyword.F.EB:SetScript("OnEditFocusLost", function(self)
		local guanjianV = self:GetText();
		SAVE_guanjianzi_B(guanjianV)
		gengxin_hang_B(fuFrame.Keyword.F.Keyword.F.BList.Scroll)
		self.tishi:Show()
		self.YES:Hide();
		self:SetText("");
	end);

	---打开关键字编辑UI
	fuFrame.Keyword.F.Keyword:RegisterForClicks("LeftButtonUp","RightButtonUp")
	fuFrame.Keyword.F.Keyword:SetScript("OnClick", function (self,button)
		if button=="LeftButton" then
			fuFrame.Keyword.F.shezhi.F:Hide()
			if fuFrame.Keyword.F.Keyword.F:IsShown() then
				fuFrame.Keyword.F.Keyword.F:Hide()
			else
				fuFrame.Keyword.F.Keyword.F:Show()
				gengxin_hang(fuFrame.Keyword.F.Keyword.F.WList.Scroll)
				gengxin_hang_B(fuFrame.Keyword.F.Keyword.F.BList.Scroll)
			end
		else
			ChatFrame99:Clear()
		end
	end);
	---=================================
	fuFrame.Keyword.F.Keyword.F.lineW = fuFrame.Keyword.F.Keyword.F:CreateLine()
	fuFrame.Keyword.F.Keyword.F.lineW:SetColorTexture(0.6,0.6,0.6,0.3)
	fuFrame.Keyword.F.Keyword.F.lineW:SetThickness(1);
	fuFrame.Keyword.F.Keyword.F.lineW:SetStartPoint("TOPLEFT",1,-254)
	fuFrame.Keyword.F.Keyword.F.lineW:SetEndPoint("TOPRIGHT",-1,-254)
	--关键字例子
	fuFrame.Keyword.F.Keyword.F.shili = fuFrame.Keyword.F.Keyword.F:CreateFontString();
	fuFrame.Keyword.F.Keyword.F.shili:SetPoint("TOPLEFT",fuFrame.Keyword.F.Keyword.F.lineW,"BOTTOMLEFT",4,-2);
	fuFrame.Keyword.F.Keyword.F.shili:SetFont(ChatFontNormal:GetFont(), 13,"OUTLINE")
	fuFrame.Keyword.F.Keyword.F.shili:SetWidth(GJZW/2-6);
	fuFrame.Keyword.F.Keyword.F.shili:SetJustifyH("LEFT");
	fuFrame.Keyword.F.Keyword.F.shili:SetText("|cff00FF00附魔：提取包含附魔的内容\n收,氪金：提取同时包含收和氪金的内容|r");
	fuFrame.Keyword.F.Keyword.F.shili = fuFrame.Keyword.F.Keyword.F:CreateFontString();
	fuFrame.Keyword.F.Keyword.F.shili:SetPoint("TOPLEFT",fuFrame.Keyword.F.Keyword.F.lineW,"BOTTOMLEFT",GJZW/2+4,-2);
	fuFrame.Keyword.F.Keyword.F.shili:SetFont(ChatFontNormal:GetFont(), 13,"OUTLINE")
	fuFrame.Keyword.F.Keyword.F.shili:SetWidth(GJZW/2-6);
	fuFrame.Keyword.F.Keyword.F.shili:SetJustifyH("LEFT");
	fuFrame.Keyword.F.Keyword.F.shili:SetText("|cffFFFF00AA：屏蔽包含AA的内容\n带,刷：屏蔽同时包含带和刷的内容|r");
	--==提取关键字=====================================================
	local QuickChat_biaoqingName=addonTable.QuickChat_biaoqingName
	local biaoqingTXT={}
	for i=1,#QuickChat_biaoqingName do
		local newvalueXxX = QuickChat_biaoqingName[i][2]:gsub("%-", "%%-");
		table.insert(biaoqingTXT,newvalueXxX)
	end
	----------
	local chongfufayanduibi={}--过滤重复发言临时
	PIG["ChatFrame"]["xxxxxx"]={}
	-- for i = 1, NUM_CHAT_WINDOWS do
	-- 	if ( i ~= 2 ) then
			--local chatID = _G["ChatFrame"..i]
			local chatID = ChatFrame1
			local msninfo = chatID.AddMessage
			local zijiname = GetUnitName("player", true)
			chatID.AddMessage = function(frame, text, ...)
				--table.insert(PIG["ChatFrame"]["xxxxxx"],text);
				local cunzaigongongpindao=text:find("|Hchannel:channel:", 1)
				if cunzaigongongpindao then	
					local qishiweizhi,jieshuweizhi=text:find("]|h： ", 1)

					if jieshuweizhi then
						local newTextxxx=text:sub(1,qishiweizhi)
						local zijifayan=newTextxxx:find(zijiname, 1)
						if zijifayan and PIG["ChatFrame"]["guolvzishen"]=="ON" then
							return msninfo(frame, text, ...)
						end
						local newText=text:sub(jieshuweizhi, -1)
						--
						local newvaluefff =newText
						for i=1,#biaoqingTXT do
							newvaluefff = newvaluefff:gsub("|T"..biaoqingTXT[i]..":"..(PIG["ChatFrame"]["FontSize_value"]+2).."|t", "");
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
						if not zijifayan and PIG["ChatFrame"]["guolvchongfu"]=="ON" then			
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
							fuFrame.Keyword.allCUNZAI_BLK = false;
							for x=1,#pingbilist do
								fuFrame.Keyword.allCUNZAI_BLK_C = true;
								for xx=1,#pingbilist[x] do
									local cunzaiguanjianzi=newText:find(pingbilist[x][xx], 1)
									if not cunzaiguanjianzi then
										fuFrame.Keyword.allCUNZAI_BLK_C = false
										break
									end
								end
								if fuFrame.Keyword.allCUNZAI_BLK_C then
									fuFrame.Keyword.allCUNZAI_BLK = true;
									break
								end
							end
							if fuFrame.Keyword.allCUNZAI_BLK then
								if PIG["ChatFrame"]["xitongjihuoB"]=="ON" then
									return false
								else
									return msninfo(frame, text, ...)
								end
							end
						end
						--提取
						if #tiquzijielist>0 then
							for x=1,#tiquzijielist do
								fuFrame.Keyword.ALLcunzai=true;	
								for xx=1,#tiquzijielist[x] do
									local cunzaiguanjianzi=newText:find(tiquzijielist[x][xx], 1)
									if not cunzaiguanjianzi then
										fuFrame.Keyword.ALLcunzai = false
										break
									end
								end
								if fuFrame.Keyword.ALLcunzai then						
									local text=text:gsub("寻求组队","组");
									local text=text:gsub("大脚世界频道","世");
									fuFrame.Keyword.F:AddMessage(text, ...);
									--fuFrame.Keyword.F:Show()
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
addonTable.ADD_QuickBut_Keyword = ADD_QuickBut_Keyword