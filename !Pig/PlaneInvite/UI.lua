local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
local fuFrame=List_R_F_2_9
---------------------------------
local ADD_Frame=addonTable.ADD_Frame
local ADD_Biaoti=addonTable.ADD_Biaoti
local ADD_Modbutton=addonTable.ADD_Modbutton
local GnName,GnUI = "时空之门","PlaneInvite_UI";
local FrameLevel=40
local Options_PlaneInvite = ADD_Modbutton(GnName,GnUI,FrameLevel,4)
----
local SQPindao = {
	["pindao"]="寻求组队",["Leisure"]="请求活动信息",["Plane"]="请求位面信息",["Chedui"]="请求车队信息",
}
addonTable.CDWMinfo=SQPindao
local function guolvqingqiuMSG(self,event,arg1,...)
	--print(event,arg1)
	if arg1==SQPindao["Leisure"] then
		return true;
	elseif arg1==SQPindao["Plane"] then
    	return true;
    elseif arg1==SQPindao["Chedui"] then
    	return true;
	end
end
-------------
local function ADD_jindutiaoBUT(fuFrame,jindutiaoWW,butTXT,PointX,PointyY)
	local jieshoushuju = CreateFrame("Frame", nil, fuFrame);
	jieshoushuju:SetSize(jindutiaoWW+4,20);
	jieshoushuju:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",PointX,PointyY);
	jieshoushuju:Hide();
	jieshoushuju.jindu = jieshoushuju:CreateTexture(nil, "BORDER");
	jieshoushuju.jindu:SetTexture("interface/raidframe/raid-bar-hp-fill.blp");
	jieshoushuju.jindu:SetColorTexture(0.3, 0.7, 0.1, 1)
	jieshoushuju.jindu:SetSize(jindutiaoWW,16);
	jieshoushuju.jindu:SetPoint("LEFT",jieshoushuju,"LEFT",2,0);
	jieshoushuju.edg = CreateFrame("Frame", nil, jieshoushuju,"BackdropTemplate");
	jieshoushuju.edg:SetBackdrop( { edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 10,});
	jieshoushuju.edg:SetBackdropBorderColor(0, 1, 1, 0.9);
	jieshoushuju.edg:SetAllPoints(jieshoushuju)
	jieshoushuju.edg.t = jieshoushuju.edg:CreateFontString();
	jieshoushuju.edg.t:SetPoint("CENTER",jieshoushuju.edg,"CENTER",0,0);
	jieshoushuju.edg.t:SetFont(GameFontNormal:GetFont(), 12,"OUTLINE")
	jieshoushuju.edg.t:SetText("正在接收数据...");
	------
	local shuaxinChedui = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");  
	shuaxinChedui:SetSize(136,24);
	shuaxinChedui:SetPoint("TOPLEFT",jieshoushuju,"BOTTOMLEFT",0,0);
	shuaxinChedui.anTXT=butTXT
	shuaxinChedui:SetText(shuaxinChedui.anTXT);
	---
	shuaxinChedui.err = shuaxinChedui:CreateFontString();
	shuaxinChedui.err:SetPoint("BOTTOMLEFT",shuaxinChedui,"TOPLEFT",2,0);
	shuaxinChedui.err:SetFont(GameFontNormal:GetFont(), 15)
	shuaxinChedui.err:SetText("");
	shuaxinChedui.err:SetTextColor(1, 0.4, 0, 1);
	return jieshoushuju,shuaxinChedui
end
addonTable.ADD_jindutiaoBUT=ADD_jindutiaoBUT
--=============================================================
local function ADD_PlaneInviteFrame()
	if PlaneInvite_UI then return end
	--过滤频道发言过频提示
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL",guolvqingqiuMSG)
	---设置主面板------------------------------------------------
	local Width,Height=880,520;
	local PlaneInvite=ADD_Frame(GnUI,UIParent,Width,Height,"CENTER",UIParent,"CENTER",0,80,true,false,true,true,true,"BG2")
	--
	PlaneInvite.biaotititle = PlaneInvite:CreateFontString();
	PlaneInvite.biaotititle:SetPoint("TOP", PlaneInvite, "TOP", 0,-3);
	PlaneInvite.biaotititle:SetFontObject(GameFontNormal);
	PlaneInvite.biaotititle:SetText(GnName);
	---
	PlaneInvite.help = CreateFrame("Frame", nil, PlaneInvite);
	PlaneInvite.help:SetSize(20,20);
	PlaneInvite.help:SetPoint("TOPRIGHT", PlaneInvite, "TOPRIGHT", -34, -1);
	PlaneInvite.help.tex = PlaneInvite.help:CreateTexture(nil, "ARTWORK");
	PlaneInvite.help.tex:SetTexture("interface/friendsframe/reportspamicon.blp");
	PlaneInvite.help.tex:SetSize(26,26);
	PlaneInvite.help.tex:SetPoint("TOPLEFT",PlaneInvite.help,"TOPLEFT",1.4,-3);
	-----
	PlaneInvite.tline = PlaneInvite:CreateLine()
	PlaneInvite.tline:SetColorTexture(0.9,0.9,0.9,0.3)
	PlaneInvite.tline:SetThickness(1);
	PlaneInvite.tline:SetStartPoint("TOPLEFT",2,-50)
	PlaneInvite.tline:SetEndPoint("TOPRIGHT",-2.6,-50)
	--NR
	PlaneInvite.NR=ADD_Frame(nil,PlaneInvite,Width-9,Height-56,"BOTTOM",PlaneInvite,"BOTTOM",-0.6,4,false,true,false,false,false)
	--TAB
	local TabWidth,TabHeight = 110,26;
	local TabName = {"候车","车队","位面"};
	for id=1,#TabName do
		local Tablist = CreateFrame("Button","PlaneInviteTAB_"..id,PlaneInvite, "TruncatedButtonTemplate",id);
		Tablist:SetSize(TabWidth,TabHeight);
		if id==1 then
			Tablist:SetPoint("TOPLEFT", PlaneInvite, "BOTTOMLEFT", 30,2);
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
	--3.4.0-以后必须加入队伍查找器
	if tocversion<30000 then
		PlaneInvite.yijiaru=true
	elseif tocversion<40000 then
		local function gengxinbut1()
			if (C_LFGList.HasActiveEntryInfo()) then
				PlaneInvite.yijiaru=true
				PlaneInvite.jiaruchazhaoqi:SetText("离开队伍查找器");
			else
				PlaneInvite.yijiaru=false
				PlaneInvite.jiaruchazhaoqi:SetText("加入队伍查找器");
			end
			PlaneInvite.jiaruchazhaoqi:Enable()
			LFGListingFrame:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE");
		end
		PlaneInvite.jiaruchazhaoqi = CreateFrame("Button",nil,PlaneInvite, "UIPanelButtonTemplate");  
		PlaneInvite.jiaruchazhaoqi:SetSize(140,23);
		PlaneInvite.jiaruchazhaoqi:SetPoint("TOPLEFT",PlaneInvite,"TOPLEFT",10,-24);
		PlaneInvite.jiaruchazhaoqi:SetFrameLevel(PlaneInvite.jiaruchazhaoqi:GetFrameLevel()+2)
		PlaneInvite.jiaruchazhaoqi:HookScript("OnShow", function (self)
			gengxinbut1()
		end)

		PlaneInvite.jiaruchazhaoqi:SetScript("OnClick", function (self)
			self:Disable()
			LFGListingFrame:UnregisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE");
			if (C_LFGList.HasActiveEntryInfo()) then
				--LFGListingFrame.dirty = false;
				--PENDING_LISTING_UPDATE = true;
				LFGListingFrame:RemoveListing()
			else
				--LFGListingFrame.dirty = true;
				--PENDING_LISTING_UPDATE = true;
				C_LFGList.CreateListing({1064}, false);
			end
		end)
		PlaneInvite:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE");
		--PlaneInvite:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED");--搜索
		PlaneInvite:HookScript("OnEvent", function(self,event)
			C_Timer.After(0.6,gengxinbut1)
		end)
	else
		PlaneInvite.yijiaru=true
	end
	------------------------------
	addonTable.ADD_Leisure_Frame()
	addonTable.ADD_Chedui_Frame()
	addonTable.ADD_Plane_Frame()
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
	if self:GetChecked() then
		PIG['PlaneInvite']['Kaiqi']="ON";
		Options_PlaneInvite:Enable();
		ADD_PlaneInviteFrame()
	else
		PIG['PlaneInvite']['Kaiqi']="OFF";
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
	if PIG['PlaneInvite']['Kaiqi']=="ON" then
		OptionsModF_PlaneInvite:SetChecked(true);
		Options_PlaneInvite:Enable();
		ADD_PlaneInviteFrame()
	end
end