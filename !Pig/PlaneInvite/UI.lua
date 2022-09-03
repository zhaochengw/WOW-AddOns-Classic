local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
local fuFrame=List_R_F_2_9
---------------------------------
local ADD_Frame=addonTable.ADD_Frame
local ADD_Modbutton=addonTable.ADD_Modbutton
local GnName,GnUI = "时空之门","PlaneInvite_UI";
local FrameLevel=40
local Options_PlaneInvite = ADD_Modbutton(GnName,GnUI,FrameLevel,4)
--=============================================================
local SQPindao = {"寻求组队","请求位面信息","请求车队信息"}
addonTable.CDWMinfo=SQPindao
local function ADD_PlaneInviteFrame()
	if PlaneInvite_UI then return end
	---设置主面板------------------------------------------------
	local Width,Height=880,520;
	local PlaneInvite=ADD_Frame(GnUI,UIParent,Width,Height,"CENTER",UIParent,"CENTER",0,80,true,true,true,true,true)

	PlaneInvite.yidong = CreateFrame("Frame", nil, PlaneInvite);
	PlaneInvite.yidong:SetSize(200,24);
	PlaneInvite.yidong:SetPoint("TOP", PlaneInvite, "TOP", 0, 0);
	PlaneInvite.yidong:EnableMouse(true)
	PlaneInvite.yidong:RegisterForDrag("LeftButton")
	PlaneInvite.yidong:SetScript("OnDragStart",function()
		PlaneInvite:StartMoving()
	end)
	PlaneInvite.yidong:SetScript("OnDragStop",function()
		PlaneInvite:StopMovingOrSizing()
	end)
	PlaneInvite.yidong.text0 = PlaneInvite.yidong:CreateFontString();
	PlaneInvite.yidong.text0:SetPoint("CENTER", PlaneInvite.yidong, "CENTER", 0,0);
	PlaneInvite.yidong.text0:SetFontObject(GameFontNormal);
	PlaneInvite.yidong.text0:SetText(GnName);
	PlaneInvite.Close = CreateFrame("Button",nil,PlaneInvite, "UIPanelCloseButton");  
	PlaneInvite.Close:SetSize(32,32);
	PlaneInvite.Close:SetPoint("TOPRIGHT", PlaneInvite, "TOPRIGHT", 5, 4);
	PlaneInvite.TOP1 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.TOP1:SetTexture("interface/worldmap/ui-worldmap-top1.blp");
	PlaneInvite.TOP1:SetSize(Width/4,Height/2);
	PlaneInvite.TOP1:SetPoint("TOPLEFT",PlaneInvite,"TOPLEFT",0,0);
	PlaneInvite.TOP2 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.TOP2:SetTexture("interface/worldmap/ui-worldmap-top2.blp");
	PlaneInvite.TOP2:SetSize(Width/4,Height/2);
	PlaneInvite.TOP2:SetPoint("TOPLEFT",PlaneInvite.TOP1,"TOPRIGHT",0,0);
	PlaneInvite.TOP3 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.TOP3:SetTexture("interface/worldmap/ui-worldmap-top3.blp");
	PlaneInvite.TOP3:SetSize(Width/4,Height/2);
	PlaneInvite.TOP3:SetPoint("TOPLEFT",PlaneInvite.TOP2,"TOPRIGHT",0,0);
	PlaneInvite.TOP4 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.TOP4:SetTexture("interface/worldmap/ui-worldmap-top4.blp");
	PlaneInvite.TOP4:SetSize(Width/4,Height/2);
	PlaneInvite.TOP4:SetPoint("TOPLEFT",PlaneInvite.TOP3,"TOPRIGHT",0,0);
	---
	PlaneInvite.BOTTOM1 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.BOTTOM1:SetTexture("interface/worldmap/ui-worldmap-bottom1.blp");
	PlaneInvite.BOTTOM1:SetSize(Width/4,Height/2);
	PlaneInvite.BOTTOM1:SetPoint("TOPLEFT",PlaneInvite.TOP1,"BOTTOMLEFT",0,0);
	PlaneInvite.BOTTOM2 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.BOTTOM2:SetTexture("interface/worldmap/ui-worldmap-bottom2.blp");
	PlaneInvite.BOTTOM2:SetSize(Width/4,Height/2);
	PlaneInvite.BOTTOM2:SetPoint("TOPLEFT",PlaneInvite.BOTTOM1,"TOPRIGHT",0,0);
	PlaneInvite.BOTTOM3 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.BOTTOM3:SetTexture("interface/worldmap/ui-worldmap-bottom3.blp");
	PlaneInvite.BOTTOM3:SetSize(Width/4,Height/2);
	PlaneInvite.BOTTOM3:SetPoint("TOPLEFT",PlaneInvite.BOTTOM2,"TOPRIGHT",0,0);
	PlaneInvite.BOTTOM4 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.BOTTOM4:SetTexture("interface/worldmap/ui-worldmap-bottom4.blp");
	PlaneInvite.BOTTOM4:SetSize(Width/4,Height/2);
	PlaneInvite.BOTTOM4:SetPoint("TOPLEFT",PlaneInvite.BOTTOM3,"TOPRIGHT",0,0);
	----------
	PlaneInvite.NR = CreateFrame("Frame", nil, PlaneInvite,"BackdropTemplate");
	PlaneInvite.NR:SetBackdrop({bgFile = "interface/raidframe/ui-raidframe-groupbg.blp",tile = false,tileSize = 0});
	PlaneInvite.NR:SetSize(Width-8,Height-69);
	PlaneInvite.NR:SetPoint("TOP",PlaneInvite,"TOP",0,-66);
	--TAB
	local TabWidth,TabHeight = 110,26;
	--local TabName = {"位面","车队","乘客"};
	local TabName = {"位面","车队"};
	for id=1,#TabName do
		local Tablist = CreateFrame("Button","PlaneInviteTAB_"..id,PlaneInvite, "TruncatedButtonTemplate",id);
		Tablist:SetSize(TabWidth,TabHeight);
		if id==1 then
			Tablist:SetPoint("TOPLEFT", PlaneInvite, "BOTTOMLEFT", 30,3);
		else
			Tablist:SetPoint("LEFT", _G["PlaneInviteTAB_"..(id-1)], "RIGHT", 20,0);
		end
		Tablist.Tex = Tablist:CreateTexture(nil, "BORDER");
		Tablist.Tex:SetTexture("interface/paperdollinfoframe/ui-character-inactivetab.blp");
		Tablist.Tex:SetPoint("TOP", Tablist, "TOP", 0,0);
		Tablist.title = Tablist:CreateFontString();
		Tablist.title:SetPoint("TOP", Tablist, "TOP", 0,-5);
		Tablist.title:SetFontObject(GameFontNormalSmall);
		Tablist.title:SetText(TabName[id]);
		Tablist.highlight = Tablist:CreateTexture(nil, "BORDER");
		Tablist.highlight:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight.blp");
		Tablist.highlight:SetBlendMode("ADD")
		Tablist.highlight:SetPoint("CENTER", Tablist.title, "CENTER", 0,0);
		Tablist.highlight:SetSize(TabWidth-12,TabHeight+4);
		Tablist.highlight:Hide();
		Tablist:SetScript("OnEnter", function (self)
			if not _G["PlaneInviteFrame_"..self:GetID()]:IsShown() then
				self.title:SetTextColor(1, 1, 1, 1);
				self.highlight:Show();
			end
		end);
		Tablist:SetScript("OnLeave", function (self)
			if not _G["PlaneInviteFrame_"..self:GetID()]:IsShown() then
				self.title:SetTextColor(1, 215/255, 0, 1);
			end
			self.highlight:Hide();
		end);
		Tablist:HookScript("OnMouseDown", function (self)
			if not _G["PlaneInviteFrame_"..self:GetID()]:IsShown() then
				self.title:SetPoint("CENTER", self, "CENTER", 2, -2);
			end
		end);
		Tablist:HookScript("OnMouseUp", function (self)
			if not _G["PlaneInviteFrame_"..self:GetID()]:IsShown() then
				self.title:SetPoint("CENTER", self, "CENTER", 0, 0);
			end
		end);
		local PlaneInviteFrame = CreateFrame("Frame", "PlaneInviteFrame_"..id,PlaneInvite.NR);
		PlaneInviteFrame:SetAllPoints(PlaneInvite.NR)
		PlaneInviteFrame:Hide();
		---------
		Tablist:SetScript("OnClick", function (self)
			for x=1,#TabName do
				_G["PlaneInviteTAB_"..x].Tex:SetTexture("interface/paperdollinfoframe/ui-character-inactivetab.blp");
				_G["PlaneInviteTAB_"..x].Tex:SetPoint("TOP", _G["PlaneInviteTAB_"..x], "TOP", 0,0);
				_G["PlaneInviteTAB_"..x].title:SetTextColor(1, 215/255, 0, 1);
				_G["PlaneInviteFrame_"..x]:Hide();
			end
			self.Tex:SetTexture("interface/paperdollinfoframe/ui-character-activetab.blp");
			self.Tex:SetPoint("TOP", self, "TOP", 0,2);
			self.title:SetTextColor(1, 1, 1, 1);
			self.highlight:Hide();
			_G["PlaneInviteFrame_"..self:GetID()]:Show();
		end);
		---
		if id==1 then
			_G["PlaneInviteTAB_"..id].Tex:SetTexture("interface/paperdollinfoframe/ui-character-activetab.blp");
			_G["PlaneInviteTAB_"..id].Tex:SetPoint("TOP", _G["PlaneInviteTAB_"..id], "TOP", 0,2);
			_G["PlaneInviteTAB_"..id].title:SetTextColor(1, 1, 1, 1);
			_G["PlaneInviteFrame_"..id]:Show();
		end
	end
	--过滤频道发言过频提示
	local function guolvqingqiuMSG(self,event,arg1,...)
		--print(event,arg1)
		if arg1==SQPindao[2] then
			return true;
		elseif arg1==SQPindao[3] then
	    	return true;
		end
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL",guolvqingqiuMSG)
	--3.4.0-以后必须加入队伍查找器
	if tocversion<30000 then
		PlaneInvite.yijiaru=true
	elseif tocversion<40000 then
		local function gengxinbut2()
			if PlaneInvite.yijiaru then
				huoquchedui_UI:Enable()
				huiquweimian_UI:Enable()
			else
				huoquchedui_UI:Disable()
				huiquweimian_UI:Disable()
			end
		end
		local function gengxinbut1()
			if (C_LFGList.HasActiveEntryInfo()) then
				PlaneInvite.yijiaru=true
				PlaneInvite.jiaruchazhaoqi:SetText("离开队伍查找器");
			else
				PlaneInvite.yijiaru=false
				PlaneInvite.jiaruchazhaoqi:SetText("加入队伍查找器");
			end
		end
		local function gengxinbut3()
			gengxinbut1()
			gengxinbut2()
		end
		PlaneInvite.jiaruchazhaoqi = CreateFrame("Button",nil,PlaneInvite, "UIPanelButtonTemplate");  
		PlaneInvite.jiaruchazhaoqi:SetSize(140,20);
		PlaneInvite.jiaruchazhaoqi:SetPoint("TOPLEFT",PlaneInvite,"TOPLEFT",250,-2);
		PlaneInvite.jiaruchazhaoqi:SetFrameLevel(PlaneInvite.jiaruchazhaoqi:GetFrameLevel()+2)
		PlaneInvite.jiaruchazhaoqi:HookScript("OnShow", function (self)
			gengxinbut3()
		end)
		PlaneInvite.jiaruchazhaoqi:SetScript("OnClick", function (self)
			if self:GetText()=="加入队伍查找器" then
				LFGListingFrame.dirty = true;
				LFGListingFrame.activities={["1064"]=true}
				LFGListingFrame:CreateOrUpdateListing()
			elseif self:GetText()=="离开队伍查找器" then
				LFGListingFrame.dirty = false;
				LFGListingFrame:RemoveListing()
			end
			C_Timer.After(0.3,gengxinbut3)
		end)

		PlaneInvite:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED");
		PlaneInvite:HookScript("OnEvent", function(self,event)
			C_Timer.After(0.5,gengxinbut3)
		end)
	else
		PlaneInvite.yijiaru=true
	end
	------------------------------------
	addonTable.ADD_Plane_Frame()
	addonTable.ADD_Chedui_Frame()
end
--================================
local ADD_ModCheckbutton =addonTable.ADD_ModCheckbutton
local Tooltip = "开启后可以查看车队，位面信息"
local Cfanwei,xulieID = -80, 3
local OptionsModF_PlaneInvite = ADD_ModCheckbutton(GnName,Tooltip,fuFrame,Cfanwei,xulieID)
---
local ADD_QuickButton=addonTable.ADD_QuickButton
local function ADD_QuickButton_PlaneInvite()
	local ckbut = OptionsModF_PlaneInvite.ADD
	if PIG["PlaneInvite"]["AddBut"]=="ON" then
		ckbut:SetChecked(true);
	end
	if PIG['QuickButton']['Open'] and PIG["PlaneInvite"]["Kaiqi"]=="ON" then
		ckbut:Enable();
	else
		ckbut:Disable();
	end
	if PIG['QuickButton']['Open'] and PIG["PlaneInvite"]["Kaiqi"]=="ON" and PIG["PlaneInvite"]["AddBut"]=="ON" then
		local QkBut = "QkBut_PlaneInvite"
		if _G[QkBut] then return end
		local Icon=132327
		local Tooltip = "点击-|cff00FFFF打开"..GnName.."|r"
		local QkBut=ADD_QuickButton(QkBut,Tooltip,Icon)
		QkBut:SetScript("OnClick", function(self,button)
			if _G[GnUI]:IsShown() then
				_G[GnUI]:Hide();
			else
				_G[GnUI]:SetFrameLevel(FrameLevel)
				_G[GnUI]:Show();
			end
		end);
	end
end
addonTable.ADD_QuickButton_PlaneInvite=ADD_QuickButton_PlaneInvite
---
OptionsModF_PlaneInvite:SetScript("OnClick", function (self)
	local offtiem = PIG['PlaneInvite']['offtime'] or 0
	local shengyu = GetServerTime()-offtiem
	if shengyu<86400 then
		local chazhi = 86400-shengyu
		local hours = floor(mod(chazhi, 86400)/3600)
		local minutes = math.ceil(mod(chazhi,3600)/60)
		print("|cff00FFFF!Pig:|r|cffFFFF00时空之门正在修复(剩余"..hours.."时"..minutes.."分)！|r")
		self:SetChecked(false)
		return 
	end
	if self:GetChecked() then
		PIG['PlaneInvite']['Kaiqi']="ON";
		Options_PlaneInvite:Enable();
		ADD_PlaneInviteFrame()
	else
		PIG['PlaneInvite']['Kaiqi']="OFF";
		PIG['PlaneInvite']['offtime']=GetServerTime();
		Options_PlaneInvite:Disable();
		Pig_Options_RLtishi_UI:Show()
	end
	ADD_QuickButton_PlaneInvite()
end);
OptionsModF_PlaneInvite.ADD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PlaneInvite']["AddBut"]="ON"
		ADD_QuickButton_PlaneInvite()
	else
		PIG['PlaneInvite']["AddBut"]="OFF"
		Pig_Options_RLtishi_UI:Show();
	end
end);
--------------------------------------------
addonTable.PlaneInvite = function()
	PIG['PlaneInvite']=PIG['PlaneInvite'] or addonTable.Default['PlaneInvite']
	PIG['PlaneInvite']['Kaiqi']=PIG['PlaneInvite']['Kaiqi'] or addonTable.Default['PlaneInvite']['Kaiqi']
	if PIG['PlaneInvite']['Kaiqi']=="ON" then
		OptionsModF_PlaneInvite:SetChecked(true);
		Options_PlaneInvite:Enable();
		ADD_PlaneInviteFrame()
	end
end