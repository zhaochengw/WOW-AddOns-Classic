local _, addonTable = ...;
local fuFrame=List_R_F_2_7
local _, _, _, tocversion = GetBuildInfo()
--===============================
local ADD_Frame=addonTable.ADD_Frame
local Create = addonTable.Create
local PIGModbutton=Create.PIGModbutton
local ADD_Checkbutton=addonTable.ADD_Checkbutton

local GnName,GnUI = "售卖助手","SellBuy_UI";
local FrameLevel=20
addonTable.SellBuyFrameLevel=FrameLevel
local Options_SellBuy = PIGModbutton(GnName,GnUI,FrameLevel,2)
------------------------------------------------
local Width,Height,biaotiH  = 300, 550, 34;
local TabWidth,TabHeight = 30,70;
local TabName = {"丢","卖","买","开","存","取"};
--父框架
local function SellBuy_ADD()
	if _G[GnUI] then return end
	local SellBuy=ADD_Frame(GnUI,UIParent,Width, Height,"CENTER",UIParent,"CENTER",0,100,true,false,false,true,true)
	SellBuy:SetMovable(true)
	--标题+拖拽按钮
	SellBuy.biaoti=ADD_Frame(nil,SellBuy,120, biaotiH,"TOP", SellBuy, "TOP", 0, 0,true,true,false,true,false,"BG7")
	SellBuy.biaoti:RegisterForDrag("LeftButton")
	SellBuy.biaoti:SetScript("OnDragStart",function()
		SellBuy:StartMoving()
	end)
	SellBuy.biaoti:SetScript("OnDragStop",function()
		SellBuy:StopMovingOrSizing()
	end)
	SellBuy.biaoti.title = SellBuy.biaoti:CreateFontString();
	SellBuy.biaoti.title:SetPoint("TOP", SellBuy.biaoti, "TOP", 0, -10);
	SellBuy.biaoti.title:SetFontObject(GameFontNormal);
	SellBuy.biaoti.title:SetText("Pig"..GnName);
	--关闭按钮
	SellBuy.CloseF=ADD_Frame(nil,SellBuy,28,28,"TOPRIGHT", SellBuy, "TOPRIGHT", -6, -6,false,true,false,false,false,"BG7") 
	SellBuy.CloseF.Close = CreateFrame("Button",nil, SellBuy.CloseF);
	SellBuy.CloseF.Close:SetSize(26,26);
	SellBuy.CloseF.Close:SetPoint("CENTER", 0,0);
	SellBuy.CloseF.Close.Tex = SellBuy.CloseF.Close:CreateTexture();
	SellBuy.CloseF.Close.Tex:SetTexture("interface/common/voicechat-muted.blp");
	SellBuy.CloseF.Close.Tex:SetPoint("CENTER");
	SellBuy.CloseF.Close.Tex:SetSize(14,14);
	SellBuy.CloseF.Close:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",1.5,-1.5);
	end);
	SellBuy.CloseF.Close:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	SellBuy.CloseF.Close:SetScript("OnClick", function (self)
		SellBuy:Hide()
	end);
	--内容显示框架
	SellBuy.F=ADD_Frame(nil,SellBuy,Width,Height-biaotiH+6,"TOP",SellBuy,"TOP",0,-biaotiH+6,false,true,false,false,false,"BG7")
	-- ----
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
		PIGRotation(SellBuy.F.Tablist.Tex, 90);
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
local function Showlistshuzi(num)
	_G[GnUI]:SetFrameLevel(FrameLevel)
	_G[GnUI]:Show();
	for x=1,#TabName do
		_G["SpllBuy_Tab_"..x].Tex:SetTexture("interface/helpframe/helpframetab-inactive.blp");
		_G["SpllBuy_Tab_"..x].Tex:SetPoint("CENTER", _G["SpllBuy_Tab_"..x], "CENTER", 0,0);
		_G["SpllBuy_Tab_"..x].title:SetTextColor(1, 215/255, 0, 1);
		_G["SpllBuy_TabFrame_"..x]:Hide();
	end
	_G["SpllBuy_Tab_"..num].Tex:SetTexture("interface/helpframe/helpframetab-active.blp");
	_G["SpllBuy_Tab_"..num].Tex:SetPoint("CENTER", _G["SpllBuy_Tab_"..num], "CENTER", 5,0);
	_G["SpllBuy_Tab_"..num].title:SetTextColor(1, 1, 1, 1);
	_G["SpllBuy_TabFrame_".._G["SpllBuy_Tab_"..num]:GetID()]:Show();
	_G["SpllBuy_Tab_"..num].highlight:Hide();
end
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
				Pig_DelItem()
			else
				if _G[GnUI]:IsShown() then
					_G[GnUI]:Hide();
				else
					Showlistshuzi(1)
				end
			end
		end);
		local Open_Item=addonTable.Open_Item
		local QkBut_Open = "QkBut_AutoSellBuy_Open"
		local Icon=136058
		local Tooltip = "左击-|cff00FFFF打开指定物品|r\n右击-|cff00FFFF打开"..GnName.."|r"
		local QkBut_Open=ADD_QuickButton(QkBut_Open,Tooltip,Icon,"SecureActionButtonTemplate")
		QkBut_Open.Height = QkBut_Open:CreateTexture(nil, "OVERLAY");
		QkBut_Open.Height:SetTexture(130724);
		QkBut_Open.Height:SetBlendMode("ADD");
		QkBut_Open.Height:SetAllPoints(QkBut_Open)
		QkBut_Open.Height:Hide()
		QkBut_Open:SetAttribute("type", "item")
		QkBut_Open:SetScript("PreClick",  function (self,button)
			if button=="LeftButton" then
				Open_Item(self)
			end
		end);
		QkBut_Open:HookScript("OnClick", function(self,button)
			if button=="LeftButton" then
			else
				if _G[GnUI]:IsShown() then
					_G[GnUI]:Hide();
				else
					Showlistshuzi(4)
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
	if PIG["AutoSellBuy"]["Kaiqi"]=="ON" then
		OptionsModF_AutoSellBuy:SetChecked(true);
		Options_SellBuy:Enable();
		SellBuy_ADD()
		addonTable.FastDiuqi()
		addonTable.SellPlus()
		addonTable.BuyPlus()
		addonTable.FastOpen()
	end
end