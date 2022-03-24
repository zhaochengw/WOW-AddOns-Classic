local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_10_UI
--===============================
local gongnengName = "售卖助手";
--打开菜单
Pig_OptionsUI.SellBuy = CreateFrame("Button",nil,Pig_OptionsUI, "UIPanelButtonTemplate");  
Pig_OptionsUI.SellBuy:SetSize(90,28);
Pig_OptionsUI.SellBuy:SetPoint("TOPLEFT",Pig_OptionsUI,"TOPLEFT",250,-24);
Pig_OptionsUI.SellBuy:SetText(gongnengName);
Pig_OptionsUI.SellBuy:Disable();
Pig_OptionsUI.SellBuy:SetMotionScriptsWhileDisabled(true)
Pig_OptionsUI.SellBuy:SetScript("OnClick", function ()
	SellBuy_UI:SetFrameLevel(40)
	SellBuy_UI:Show();
	Pig_OptionsUI:Hide();
end);
Pig_OptionsUI.SellBuy:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	if not self:IsEnabled() then
		GameTooltip:AddLine(gongnengName.."尚未启用，请在功能模块内启用")
	end
	GameTooltip:Show();
end);
Pig_OptionsUI.SellBuy:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide()
end);
------------------------------------------------
local Width,Height,biaotiH  = 300, 550, 34;
--父框架
local function SellBuy_ADD()
	if SellBuy_UI then return end
	local SellBuy = CreateFrame("Frame", "SellBuy_UI", UIParent)
	SellBuy:SetSize(Width, Height)
	SellBuy:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
	SellBuy:SetMovable(true)
	SellBuy:EnableMouse(true)
	SellBuy:SetClampedToScreen(true)
	SellBuy:Hide()
	tinsert(UISpecialFrames,"SellBuy_UI");
	--标题+拖拽按钮
	SellBuy.biaoti = CreateFrame("Frame", nil, SellBuy,"BackdropTemplate")
	SellBuy.biaoti:SetBackdrop({
	    bgFile = "interface/characterframe/ui-party-background.blp",
	    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		edgeSize = 16,insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
	SellBuy.biaoti:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
	SellBuy.biaoti:SetSize(120, biaotiH)
	SellBuy.biaoti:SetPoint("TOP", SellBuy, "TOP", 0, 0)
	SellBuy.biaoti:EnableMouse(true)
	SellBuy.biaoti:RegisterForDrag("LeftButton")
	SellBuy.biaoti:SetClampedToScreen(true)
	SellBuy.biaoti:SetScript("OnDragStart",function()
		SellBuy:StartMoving()
	end)
	SellBuy.biaoti:SetScript("OnDragStop",function()
		SellBuy:StopMovingOrSizing()
	end)
	SellBuy.biaoti_title = SellBuy.biaoti:CreateFontString();
	SellBuy.biaoti_title:SetPoint("TOP", SellBuy.biaoti, "TOP", 0, -10);
	SellBuy.biaoti_title:SetFontObject(GameFontNormal);
	SellBuy.biaoti_title:SetText("Pig"..gongnengName);
	--关闭按钮
	SellBuy.CloseF = CreateFrame("Frame", nil, SellBuy,"BackdropTemplate")
	SellBuy.CloseF:SetBackdrop({
	    bgFile = "interface/characterframe/ui-party-background.blp",
	    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		edgeSize = 16,insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
	SellBuy.CloseF:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
	SellBuy.CloseF:SetSize(28,28);
	SellBuy.CloseF:SetPoint("TOPRIGHT", SellBuy, "TOPRIGHT", -6, -6);
	SellBuy.Close = CreateFrame("Button",nil,SellBuy, "UIPanelCloseButton");  
	SellBuy.Close:SetSize(32,32);
	SellBuy.Close:SetPoint("CENTER", SellBuy.CloseF, "CENTER", 1, 0);
	--内容显示框架
	SellBuy.F = CreateFrame("Frame", nil, SellBuy,"BackdropTemplate");
	SellBuy.F:SetBackdrop({
	    bgFile = "interface/characterframe/ui-party-background.blp",
	    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		edgeSize = 16,insets = { left = 4, right = 4, top = 4, bottom = 4 }
	})
	SellBuy.F:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
	SellBuy.F:SetSize(Width,Height-biaotiH+6);
	SellBuy.F:SetPoint("TOP",SellBuy,"TOP",0,-biaotiH+6);
	-- ----
	local TabWidth,TabHeight = 30,70;
	local TabName = {"丢","卖","买"};
	for id=1,#TabName do
		SellBuy.F.Tablist = CreateFrame("Button","SpllBuy_Tab_"..id, SellBuy.F, "TruncatedButtonTemplate",id);
		SellBuy.F.Tablist:SetSize(TabWidth,TabHeight);
		if id==1 then
			SellBuy.F.Tablist:SetPoint("TOPRIGHT", SellBuy.F, "TOPLEFT", 0,-30);
		else
			SellBuy.F.Tablist:SetPoint("TOP", _G["SpllBuy_Tab_"..(id-1)], "BOTTOM", 0,-20);
		end
		SellBuy.F.Tablist.Tex = SellBuy.F.Tablist:CreateTexture(nil, "BORDER");
		SellBuy.F.Tablist.Tex:SetTexture("interface/helpframe/helpframetab-inactive.blp");
		SellBuy.F.Tablist.Tex:SetRotation(1.5707964, 0.5, 0.5)
		SellBuy.F.Tablist.Tex:SetPoint("CENTER", SellBuy.F.Tablist, "CENTER", 1,0);
		SellBuy.F.Tablist.title = SellBuy.F.Tablist:CreateFontString();
		SellBuy.F.Tablist.title:SetPoint("CENTER", SellBuy.F.Tablist, "CENTER", 6,0);
		SellBuy.F.Tablist.title:SetFontObject(GameFontNormalSmall);
		SellBuy.F.Tablist.title:SetText(TabName[id]);
		SellBuy.F.Tablist.highlight = SellBuy.F.Tablist:CreateTexture(nil, "BORDER");
		SellBuy.F.Tablist.highlight:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight.blp");
		SellBuy.F.Tablist.highlight:SetBlendMode("ADD")
		SellBuy.F.Tablist.highlight:SetPoint("CENTER", SellBuy.F.Tablist.title, "CENTER", 0,0);
		SellBuy.F.Tablist.highlight:SetSize(TabWidth-12,TabHeight+16);
		SellBuy.F.Tablist.highlight:Hide();
		SellBuy.F.Tablist:SetScript("OnEnter", function (self)
			if not _G["SpllBuy_TabFrame_"..self:GetID()]:IsShown() then
				_G["SpllBuy_Tab_"..self:GetID()].title:SetTextColor(1, 1, 1, 1);
				_G["SpllBuy_Tab_"..self:GetID()].highlight:Show();
			end
		end);
		SellBuy.F.Tablist:SetScript("OnLeave", function (self)
			if not _G["SpllBuy_TabFrame_"..self:GetID()]:IsShown() then
				_G["SpllBuy_Tab_"..self:GetID()].title:SetTextColor(1, 215/255, 0, 1);	
			end
			_G["SpllBuy_Tab_"..self:GetID()].highlight:Hide();
		end);
		SellBuy.F.Tablist:SetScript("OnMouseDown", function (self)
			if not _G["SpllBuy_TabFrame_"..self:GetID()]:IsShown() then
				self.title:SetPoint("RIGHT", self, "RIGHT", 1.5, -2);
			end
		end);
		SellBuy.F.Tablist:SetScript("OnMouseUp", function (self)
			if not _G["SpllBuy_TabFrame_"..self:GetID()]:IsShown() then
				self.title:SetPoint("RIGHT",self, "RIGHT", 0, 0);
			end
		end);
		SellBuy.F.TabFrame = CreateFrame("Frame", "SpllBuy_TabFrame_"..id,SellBuy.F);
		SellBuy.F.TabFrame:SetAllPoints(SellBuy.F)
		SellBuy.F.TabFrame:Hide();
		SellBuy.F.Tablist:SetScript("OnClick", function (self)
			for x=1,#TabName do
				_G["SpllBuy_Tab_"..x].Tex:SetTexture("interface/helpframe/helpframetab-inactive.blp");
				_G["SpllBuy_Tab_"..x].Tex:SetPoint("CENTER", _G["SpllBuy_Tab_"..x], "CENTER", 0,0);
				_G["SpllBuy_Tab_"..x].title:SetTextColor(1, 215/255, 0, 1);
				_G["SpllBuy_TabFrame_"..x]:Hide();
			end
			self.Tex:SetTexture("interface/helpframe/helpframetab-active.blp");
			self.Tex:SetPoint("CENTER", self, "CENTER", 4,0);
			self.title:SetTextColor(1, 1, 1, 1);
			_G["SpllBuy_TabFrame_"..self:GetID()]:Show();
			self.highlight:Hide();
		end);
	end
	---
	SpllBuy_TabFrame_1:Show()
	SpllBuy_Tab_1.Tex:SetTexture("interface/helpframe/helpframetab-active.blp");
	SpllBuy_Tab_1.Tex:SetPoint("CENTER", SpllBuy_Tab_1, "CENTER", 4,0);
	SpllBuy_Tab_1.title:SetTextColor(1, 1, 1, 1);
	addonTable.FastDiuqi()
	addonTable.SellPlus()
	addonTable.BuyPlus()
end
--===========================================================
--添加快捷打开按钮
local function ADD_AutoSellBuy_but()
	PIG["AutoSellBuy"]=PIG["AutoSellBuy"] or addonTable.Default["AutoSellBuy"]
	PIG["AutoSellBuy"]["Kaiqi"]=PIG["AutoSellBuy"]["Kaiqi"] or addonTable.Default["AutoSellBuy"]["Kaiqi"]
	PIG["AutoSellBuy"]["AddBut"]=PIG["AutoSellBuy"]["AddBut"] or addonTable.Default["AutoSellBuy"]["AddBut"]
	if PIG["AutoSellBuy"]["AddBut"]=="ON" then
		fuFrame.ADD:SetChecked(true);
	end
	if PIG['Classes']['Assistant']=="ON" and PIG["AutoSellBuy"]["Kaiqi"]=="ON" then
		fuFrame.ADD:Enable();
	else
		fuFrame.ADD:Disable();
	end
	if PIG['Classes']['Assistant']=="ON" and PIG["AutoSellBuy"]["Kaiqi"]=="ON" and PIG["AutoSellBuy"]["AddBut"]=="ON" then
		if AutoSellBuy_but==nil then
			local ActionWw = Classes_UI:GetHeight()
			local Width_x,Height_x=ActionWw,ActionWw;
			local AutoSellBuy_but = CreateFrame("Button", "AutoSellBuy_but", Classes_UI.nr);
			AutoSellBuy_but:SetNormalTexture(134409);
			AutoSellBuy_but:SetHighlightTexture(130718);
			AutoSellBuy_but:SetSize(Width_x-1,Height_x-1);
			local geshu = {Classes_UI.nr:GetChildren()};
			AutoSellBuy_but:SetPoint("LEFT",Classes_UI.nr,"LEFT",(#geshu-1)*(Width_x+2),0);
			AutoSellBuy_but:RegisterForClicks("LeftButtonUp","RightButtonUp");
			AutoSellBuy_but:SetScript("OnEnter", function ()
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(AutoSellBuy_but, "ANCHOR_TOPLEFT",2,4);
				GameTooltip:AddLine("左击-|cff00FFFF丢弃指定物品|r\n右击-|cff00FFFF打开"..gongnengName.."|r")
				GameTooltip:Show();
			end);
			AutoSellBuy_but:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			AutoSellBuy_but.Border = AutoSellBuy_but:CreateTexture(nil, "BORDER");
			AutoSellBuy_but.Border:SetTexture(130841);
			AutoSellBuy_but.Border:ClearAllPoints();
			AutoSellBuy_but.Border:SetPoint("TOPLEFT",AutoSellBuy_but,"TOPLEFT",-Width_x*0.38,Height_x*0.39);
			AutoSellBuy_but.Border:SetPoint("BOTTOMRIGHT",AutoSellBuy_but,"BOTTOMRIGHT",Width_x*0.4,-Height_x*0.4);

			AutoSellBuy_but.Height = AutoSellBuy_but:CreateTexture(nil, "OVERLAY");
			AutoSellBuy_but.Height:SetTexture(130724);
			AutoSellBuy_but.Height:SetBlendMode("ADD");
			AutoSellBuy_but.Height:SetAllPoints(AutoSellBuy_but)
			AutoSellBuy_but.Height:Hide()

			AutoSellBuy_but.Down = AutoSellBuy_but:CreateTexture(nil, "OVERLAY");
			AutoSellBuy_but.Down:SetTexture(130839);
			AutoSellBuy_but.Down:SetAllPoints(AutoSellBuy_but)
			AutoSellBuy_but.Down:Hide();
			AutoSellBuy_but:SetScript("OnMouseDown", function ()
				AutoSellBuy_but.Down:Show();
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			AutoSellBuy_but:SetScript("OnMouseUp", function ()
				AutoSellBuy_but.Down:Hide();
			end);
			AutoSellBuy_but:SetScript("OnClick", function(event, button)
				if button=="LeftButton" then
					addonTable.FastDiuqi_DelItem()
				else
					if SellBuy_UI:IsShown() then
						SellBuy_UI:Hide();
					else
						SellBuy_UI:SetFrameLevel(40)
						SellBuy_UI:Show();
					end
				end
			end);
		end
		addonTable.Classes_gengxinkuanduinfo()
	end	
end
addonTable.ADD_AutoSellBuy_but=ADD_AutoSellBuy_but
--=====================================================
fuFrame.BuySPELLXIAN = fuFrame:CreateLine()
fuFrame.BuySPELLXIAN:SetColorTexture(1,1,1,0.4)
fuFrame.BuySPELLXIAN:SetThickness(1);
fuFrame.BuySPELLXIAN:SetStartPoint("TOPLEFT",2,-50)
fuFrame.BuySPELLXIAN:SetEndPoint("TOPRIGHT",-2,-50)
--------
fuFrame.ADD = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.ADD:SetSize(30,30);
fuFrame.ADD:SetHitRectInsets(0,-100,0,0);
fuFrame.ADD:SetPoint("TOPLEFT",fuFrame.BuySPELLXIAN,"TOPLEFT",300,-11);
fuFrame.ADD.Text:SetText("添加"..gongnengName.."到快捷按钮");
fuFrame.ADD.tooltip = "添加一个按钮到快捷按钮方便打开关闭。\n|cff00FF00注意：此功能需先打开快捷按钮功能|r";
fuFrame.ADD:SetMotionScriptsWhileDisabled(true) 
fuFrame.ADD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["AutoSellBuy"]["AddBut"]="ON";
		ADD_AutoSellBuy_but()
	else
		Pig_Options_RLtishi_UI:Show()
		PIG["AutoSellBuy"]["AddBut"]="OFF";
	end
end);
fuFrame.Open = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Open:SetSize(30,30);
fuFrame.Open:SetHitRectInsets(0,-100,0,0);
fuFrame.Open:SetPoint("TOPLEFT",fuFrame.BuySPELLXIAN,"TOPLEFT",20,-11);
fuFrame.Open.Text:SetText(gongnengName);
fuFrame.Open.tooltip = "一键摧毁/自动卖出制定物品/自动购买指定物品";
fuFrame.Open:SetMotionScriptsWhileDisabled(true) 
fuFrame.Open:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["AutoSellBuy"]["Kaiqi"]="ON";
		SellBuy_ADD()
		fuFrame.ADD:Enable()
		Pig_OptionsUI.SellBuy:Enable();
		ADD_AutoSellBuy_but()
	else
		Pig_Options_RLtishi_UI:Show()
		fuFrame.ADD:Disable()
		Pig_OptionsUI.SellBuy:Disable();
		PIG["AutoSellBuy"]["Kaiqi"]="OFF";
	end
end);
---===========================================
addonTable.AutoSellBuy_SellBuy = function()
	PIG["AutoSellBuy"]=PIG["AutoSellBuy"] or addonTable.Default["AutoSellBuy"]
	PIG["AutoSellBuy"]["Kaiqi"]=PIG["AutoSellBuy"]["Kaiqi"] or addonTable.Default["AutoSellBuy"]["Kaiqi"]
	PIG["AutoSellBuy"]["AddBut"]=PIG["AutoSellBuy"]["AddBut"] or addonTable.Default["AutoSellBuy"]["AddBut"]
	if PIG["AutoSellBuy"]["Kaiqi"]=="ON" then
		SellBuy_ADD()
		fuFrame.Open:SetChecked(true);
		Pig_OptionsUI.SellBuy:Enable();
	end
end