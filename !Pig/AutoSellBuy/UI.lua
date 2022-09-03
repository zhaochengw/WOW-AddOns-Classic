local _, addonTable = ...;
local fuFrame=List_R_F_2_7
--===============================
local ADD_Frame=addonTable.ADD_Frame
local ADD_Modbutton=addonTable.ADD_Modbutton
local GnName,GnUI = "售卖助手","SellBuy_UI";
local FrameLevel=20
addonTable.SellBuyFrameLevel=FrameLevel
local Options_SellBuy = ADD_Modbutton(GnName,GnUI,FrameLevel,2)
------------------------------------------------
local Width,Height,biaotiH  = 300, 550, 34;
--父框架
local function SellBuy_ADD()
	if _G[GnUI] then return end
	local SellBuy=ADD_Frame(GnUI,UIParent,Width, Height,"CENTER",UIParent,"CENTER",0,100,true,true,true,true,true)
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
	SellBuy.biaoti_title:SetText("Pig"..GnName);
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
	SellBuy.Close:SetSize(30,30);
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
	local TabName = {"丢","卖","买","开","存","取"};
	for id=1,#TabName do
		SellBuy.F.Tablist = CreateFrame("Button","SpllBuy_Tab_"..id, SellBuy.F, "TruncatedButtonTemplate",id);
		SellBuy.F.Tablist:SetSize(TabWidth,TabHeight);
		if id==1 then
			SellBuy.F.Tablist:SetPoint("TOPRIGHT", SellBuy.F, "TOPLEFT", 0,-20);
		else
			SellBuy.F.Tablist:SetPoint("TOP", _G["SpllBuy_Tab_"..(id-1)], "BOTTOM", 0,-10);
		end
		SellBuy.F.Tablist.Tex = SellBuy.F.Tablist:CreateTexture(nil, "BORDER");
		SellBuy.F.Tablist.Tex:SetTexture("interface/helpframe/helpframetab-inactive.blp");
		SellBuy.F.Tablist.Tex:SetRotation(1.5707964, 0.5, 0.5)
		SellBuy.F.Tablist.Tex:SetPoint("CENTER", SellBuy.F.Tablist, "CENTER", 0,0);
		SellBuy.F.Tablist.title = SellBuy.F.Tablist:CreateFontString();
		SellBuy.F.Tablist.title:SetPoint("CENTER", SellBuy.F.Tablist, "CENTER", 8,0);
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
			self.Tex:SetPoint("CENTER", self, "CENTER", 5,0);
			self.title:SetTextColor(1, 1, 1, 1);
			_G["SpllBuy_TabFrame_"..self:GetID()]:Show();
			self.highlight:Hide();
		end);
		if id==1 then
			SellBuy.F.TabFrame:Show()
			SellBuy.F.Tablist.Tex:SetTexture("interface/helpframe/helpframetab-active.blp");
			SellBuy.F.Tablist.Tex:SetPoint("CENTER", SellBuy.F.Tablist, "CENTER", 5,0);
			SellBuy.F.Tablist.title:SetTextColor(1, 1, 1, 1);
		end
	end
end
--=====================================================
local ADD_ModCheckbutton =addonTable.ADD_ModCheckbutton
local Tooltip = "一键摧毁/自动卖出/自动购买/自动开箱盒蚌";
local Cfanwei,xulieID = -80, 1
local OptionsModF_AutoSellBuy = ADD_ModCheckbutton(GnName,Tooltip,fuFrame,Cfanwei,xulieID)
--添加快捷打开按钮
local ADD_QuickButton=addonTable.ADD_QuickButton
local function ADD_QuickButton_AutoSellBuy()
	local ckbut = OptionsModF_AutoSellBuy.ADD
	if PIG["AutoSellBuy"]["AddBut"]=="ON" then
		ckbut:SetChecked(true);
	end
	if PIG['QuickButton']['Open'] and PIG["AutoSellBuy"]["Kaiqi"]=="ON" then
		ckbut:Enable();
	else
		ckbut:Disable();
	end
	if PIG['QuickButton']['Open'] and PIG["AutoSellBuy"]["Kaiqi"]=="ON" and PIG["AutoSellBuy"]["AddBut"]=="ON" then
		local QkBut = "QkBut_AutoSellBuy"
		if _G[QkBut] then return end
		local Icon=134409
		local Tooltip = "左击-|cff00FFFF丢弃指定物品|r\n右击-|cff00FFFF打开"..GnName.."|r"
		local QkBut=ADD_QuickButton(QkBut,Tooltip,Icon)
		QkBut.Height = QkBut:CreateTexture(nil, "OVERLAY");
		QkBut.Height:SetTexture(130724);
		QkBut.Height:SetBlendMode("ADD");
		QkBut.Height:SetAllPoints(QkBut)
		QkBut.Height:Hide()
		QkBut:SetScript("OnClick", function(self,button)
			if button=="LeftButton" then
				addonTable.FastDiuqi_DelItem()
			else
				if _G[GnUI]:IsShown() then
					_G[GnUI]:Hide();
				else
					_G[GnUI]:SetFrameLevel(FrameLevel)
					_G[GnUI]:Show();
				end
			end
		end);
	end
end
addonTable.ADD_QuickButton_AutoSellBuy=ADD_QuickButton_AutoSellBuy
---
OptionsModF_AutoSellBuy:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["AutoSellBuy"]["Kaiqi"]="ON";
		Options_SellBuy:Enable();
		SellBuy_ADD()
		addonTable.FastDiuqi()
		addonTable.SellPlus()
		addonTable.BuyPlus()
		addonTable.Open_ADD()
	else
		Pig_Options_RLtishi_UI:Show()
		Options_SellBuy:Disable();
		PIG["AutoSellBuy"]["Kaiqi"]="OFF";
	end
	ADD_QuickButton_AutoSellBuy()
end);
OptionsModF_AutoSellBuy.ADD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["AutoSellBuy"]["AddBut"]="ON";
		ADD_QuickButton_AutoSellBuy()
	else
		Pig_Options_RLtishi_UI:Show()
		PIG["AutoSellBuy"]["AddBut"]="OFF";
	end
end);
---===========================================
addonTable.AutoSellBuy_SellBuy = function()
	PIG["AutoSellBuy"]=PIG["AutoSellBuy"] or addonTable.Default["AutoSellBuy"]
	PIG["AutoSellBuy"]["Kaiqi"]=PIG["AutoSellBuy"]["Kaiqi"] or addonTable.Default["AutoSellBuy"]["Kaiqi"]
	PIG["AutoSellBuy"]["AddBut"]=PIG["AutoSellBuy"]["AddBut"] or addonTable.Default["AutoSellBuy"]["AddBut"]
	if PIG["AutoSellBuy"]["Kaiqi"]=="ON" then
		OptionsModF_AutoSellBuy:SetChecked(true);
		Options_SellBuy:Enable();
		SellBuy_ADD()
		addonTable.FastDiuqi()
		addonTable.SellPlus()
		addonTable.BuyPlus()
		addonTable.Open_ADD()
	end
end