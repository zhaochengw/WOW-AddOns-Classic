local addonName, addonTable = ...;
-----------------------
local ListName,List1Width,ButHeight="PIGDownList",300,16
local listshumu = 30
function PIGCloseDropDownMenus(level)
	if ( not level ) then
		level = 1;
	end
	for i=level, UIDROPDOWNMENU_MAXLEVELS do
		_G[ListName..i]:Hide();
	end
end
local function PIGDownMenu_StartCounting(frame)
	if ( frame.parent ) then
		PIGDownMenu_StartCounting(frame.parent);
	else
		frame.showTimer = UIDROPDOWNMENU_SHOW_TIME;
		frame.isCounting = 1;
	end
end
local function PIGDownMenu_StopCounting(frame)
	if ( frame.parent ) then
		PIGDownMenu_StopCounting(frame.parent);
	else
		frame.isCounting = nil;
	end
end

local function PIGDownMenu_OnUpdate(self, elapsed)
	if ( not self.showTimer or not self.isCounting ) then
		return;
	elseif ( self.showTimer < 0 ) then
		self:Hide()
		self.showTimer = nil;
		self.isCounting = nil;
	else
		self.showTimer = self.showTimer - elapsed;
	end
end
----
for i=1,UIDROPDOWNMENU_MAXLEVELS do
	local PIGDownList = CreateFrame("Button", ListName..i, UIParent,"BackdropTemplate",i);
	PIGDownList:SetBackdrop(
		{bgFile = "interface/characterframe/ui-party-background.blp",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
		edgeSize = 10,insets = { left = 1.8, right = 1.8, top = 1.8, bottom = 1.8 }
	});
	PIGDownList:SetBackdropBorderColor(0, 1, 1, 0.8);
	PIGDownList:Hide()
	PIGDownList:SetClampedToScreen(true)
	PIGDownList:SetFrameStrata("FULLSCREEN_DIALOG")
	PIGDownList:HookScript("OnEnter", function (self)
		PIGDownMenu_StopCounting(self)
	end)
	PIGDownList:HookScript("OnLeave", function (self)
		PIGDownMenu_StartCounting(self)
	end)
	PIGDownList:HookScript("OnUpdate", function(self, elapsed)
		PIGDownMenu_OnUpdate(self, elapsed)
	end)
	if i == 1 then
		PIGDownList:HookScript("OnHide", function(self)
			for i=2,UIDROPDOWNMENU_MAXLEVELS do
				_G["PIGDownList"..i]:Hide()
			end
		end)		
	end
	for ii=1,listshumu do
		local CheckBut = CreateFrame("CheckButton", "PIGDownList"..i.."But"..ii, PIGDownList);
		CheckBut:SetHeight(ButHeight);
		if ii==1 then
			CheckBut:SetPoint("TOPLEFT","PIGDownList"..i,"TOPLEFT",4,-4);
			CheckBut:SetPoint("TOPRIGHT","PIGDownList"..i,"TOPRIGHT",-4,-4);
		else
			CheckBut:SetPoint("TOPLEFT","PIGDownList"..i.."But"..(ii-1),"BOTTOMLEFT",0,0);
			CheckBut:SetPoint("TOPRIGHT","PIGDownList"..i.."But"..(ii-1),"BOTTOMRIGHT",0,0);
		end
		CheckBut:Hide()
		CheckBut:SetFrameStrata("FULLSCREEN_DIALOG")

		CheckBut.Highlight = CheckBut:CreateTexture(nil, "HIGHLIGHT");
		CheckBut.Highlight:SetTexture("Interface/QuestFrame/UI-QuestTitleHighlight");
		CheckBut.Highlight:SetBlendMode("ADD")
		CheckBut.Highlight:SetAllPoints(CheckBut)

		CheckBut.Check = CheckBut:CreateTexture(nil, "BORDER");
		CheckBut.Check:SetTexture("Interface/Common/UI-DropDownRadioChecks");
		CheckBut.Check:SetSize(ButHeight,ButHeight);
		CheckBut.Check:SetPoint("LEFT", 0, 0);
		CheckBut.Check:Hide();
		CheckBut.UnCheck = CheckBut:CreateTexture(nil, "BORDER");
		CheckBut.UnCheck:SetTexture("Interface/Common/UI-DropDownRadioChecks");
		CheckBut.UnCheck:SetSize(ButHeight,ButHeight);
		CheckBut.UnCheck:SetPoint("LEFT", 0, 0);

		CheckBut.ExpandArrow = CheckBut:CreateTexture(nil, "BORDER");
		CheckBut.ExpandArrow:SetSize(ButHeight,ButHeight);
		CheckBut.ExpandArrow:SetPoint("RIGHT", 0, 0);
		CheckBut.ExpandArrow:Hide();

		CheckBut.Text = CheckBut:CreateFontString();
		CheckBut.Text:SetPoint("LEFT", 18, 0);
		CheckBut.Text:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
		CheckBut:HookScript("OnMouseDown", function (self)
			local fujilist = self:GetParent()
			local xialaMenu = fujilist.dropdown
			if xialaMenu.EasyMenu=="DJEasyMenu" or self.notCheckable then
				self.Text:SetPoint("LEFT", 5, -1);
			else
				self.Text:SetPoint("LEFT", 19, -1);
			end
		end);
		CheckBut:HookScript("OnMouseUp", function (self)
			local fujilist = self:GetParent()
			local xialaMenu = fujilist.dropdown
			if xialaMenu.EasyMenu=="DJEasyMenu" or self.notCheckable then
				self.Text:SetPoint("LEFT", 4, 0);
			else
				self.Text:SetPoint("LEFT", 18, 0);
			end
		end);
		CheckBut:HookScript("OnEnter", function (self)
			local fujilist = self:GetParent()
			PIGDownMenu_StopCounting(fujilist)
			if self.hasArrow then
				local newi = i+1
				local ListFff = _G["PIGDownList"..newi]
				ListFff.maxWidth = 0;
				ListFff.numButtons = 0;
				ListFff:SetPoint("TOPLEFT",self, "TOPRIGHT", 2,6);
				for ii=1,listshumu do
					_G["PIGDownList"..newi.."But"..ii]:Hide()
				end
				local xialaMenu = fujilist.dropdown
				xialaMenu:PIGDownMenu_Update_But(xialaMenu,newi,self.menuList)
				ListFff:Show()	
			end
		end)
		CheckBut:HookScript("OnLeave", function (self)
			PIGDownMenu_StartCounting(self:GetParent())
		end)
		CheckBut:HookScript("OnClick", function (self)
			if self.isNotRadio then
				local xchecked = self:GetChecked()
				self.checked = xchecked
			else
				for v=1,listshumu do
					local FrameX = _G["PIGDownList"..i.."But"..v]
					FrameX:SetChecked(false)
				end
				self:SetChecked(true);
			end
			self.func(self.value,self.value,self.arg1,self.arg2,self.checked)
		end);
	end
end
--------------
local function PIGDownMenu(gnName,SizeWH,fuFrame,Point,EasyMenu)
	local DownMenu = CreateFrame("Frame", gnName, fuFrame,"BackdropTemplate");
	DownMenu.EasyMenu=EasyMenu
	if EasyMenu=="EasyMenu" or EasyMenu=="DJEasyMenu" then	
		DownMenu:SetAllPoints(fuFrame)
		DownMenu.Button = CreateFrame("Button",nil,DownMenu, "TruncatedButtonTemplate");
		DownMenu.Button:SetAllPoints(DownMenu)
	else
		local Width,Height=SizeWH[1],SizeWH[2]
		local Height=Height or 24
		DownMenu:SetBackdrop(
			{bgFile = "interface/characterframe/ui-party-background.blp",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
			edgeSize = 10,insets = { left = 1.8, right = 1.8, top = 1.8, bottom = 1.8 }
		});
		DownMenu:SetBackdropBorderColor(0, 1, 1, 0.8);

		DownMenu:SetSize(Width,Height);
		DownMenu:SetPoint(Point[1],Point[2],Point[3],Point[4],Point[5]);
		DownMenu:HookScript("OnHide", function(self)
			PIGCloseDropDownMenus()
		end)
		DownMenu.Button = CreateFrame("Button",nil,DownMenu, "TruncatedButtonTemplate");
		DownMenu.Button:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Up")
		DownMenu.Button:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Down")
		DownMenu.Button:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Disabled")
		DownMenu.Button:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight");
		DownMenu.Button:SetSize(Height+3,Height+3);
		DownMenu.Button:SetPoint("RIGHT",DownMenu,"RIGHT",2,0);

		DownMenu.Text = DownMenu:CreateFontString();
		DownMenu.Text:SetWidth(Width-(Height+3));
		DownMenu.Text:SetPoint("RIGHT", DownMenu.Button, "LEFT", 2, 0);
		DownMenu.Text:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
		DownMenu.Text:SetJustifyH("RIGHT");
	end
	DownMenu.Button:RegisterForClicks("LeftButtonUp","RightButtonUp");
	local function zhixing_Show(fujiFrame)
		local xialaMenu = PIGDownList1.dropdown
		if PIGDownList1:IsShown() and xialaMenu==fujiFrame then
			PIGDownList1:Hide()
		else
			for g=1,UIDROPDOWNMENU_MAXLEVELS do
				_G["PIGDownList"..g]:Hide()
				for gg=1,listshumu do
					_G["PIGDownList"..g.."But"..gg]:Hide()
				end
			end
			PIGDownList1.showTimer = UIDROPDOWNMENU_SHOW_TIME;
			PIGDownList1.isCounting = 1;
			PIGDownList1.maxWidth = 0;
			PIGDownList1.numButtons = 0;
			PIGDownList1:ClearAllPoints();
			if fujiFrame.EasyMenu=="EasyMenu" or fujiFrame.EasyMenu=="DJEasyMenu" then
				PIGDownList1:SetPoint(Point[1],Point[2],Point[3],Point[4],Point[5]);
			else
				PIGDownList1:SetPoint("TOPLEFT",fujiFrame, "BOTTOMLEFT", 0,0);
			end
			fujiFrame:PIGDownMenu_Update_But(fujiFrame)
			PIGDownList1:Show()
		end
	end
	DownMenu.Button:HookScript("OnClick", function(self, button)
		local fujiFrame = self:GetParent()
		if button=="LeftButton" then
			if fujiFrame.EasyMenu~="DJEasyMenu" then
				zhixing_Show(fujiFrame)
			end
		else
			if fujiFrame.EasyMenu=="DJEasyMenu" then
				zhixing_Show(fujiFrame)
			end
		end
	end)
	function DownMenu:PIGDownMenu_SetText(Text)
		self.Text:SetText(Text)
	end
	function DownMenu:PIGDownMenu_GetText()	
		return self.Text:GetText()
	end
	function DownMenu:PIGDownMenu_GetValue()	
		return self.value
	end
	function DownMenu:PIGDownMenu_AddButton(info, level)
		if ( not level ) then
			level = 1;
		end
		local listFrame = _G["PIGDownList"..level];
		listFrame.dropdown = self;
		if level > 1 then
			listFrame.parent = _G["PIGDownList"..level-1]
		end
		local index = listFrame and (listFrame.numButtons + 1) or 1;
		listFrame.numButtons = index;
		local CheckBut=_G["PIGDownList"..level.."But"..index];
		CheckBut:Show()
		CheckBut.Text:SetText(info.text)
		CheckBut.value=info.text
		CheckBut.arg1=info.arg1
		CheckBut.arg2=info.arg2
		CheckBut.notCheckable=info.notCheckable
		CheckBut.func=info.func or function() end
		CheckBut:SetChecked(info.checked);
		if self.EasyMenu=="DJEasyMenu" or info.notCheckable then
			CheckBut.Check:Hide();
			CheckBut.UnCheck:Hide();
			CheckBut.Text:SetPoint("LEFT", 4, 0);
		else
			CheckBut.Text:SetPoint("LEFT", 18, 0);
			if info.checked then
				CheckBut.Check:Show();
				CheckBut.UnCheck:Hide();
			else
				CheckBut.Check:Hide();
				CheckBut.UnCheck:Show();
			end
		end

		CheckBut.isNotRadio=info.isNotRadio
		if info.isNotRadio then
			CheckBut.Check:SetTexCoord(0.0, 0.5, 0.0, 0.5);
			CheckBut.UnCheck:SetTexCoord(0.5, 1.0, 0.0, 0.5);
		else
			CheckBut.Check:SetTexCoord(0.0, 0.5, 0.5, 1.0);
			CheckBut.UnCheck:SetTexCoord(0.5, 1.0, 0.5, 1.0);
		end
		CheckBut.hasArrow=info.hasArrow
		if self.EasyMenu=="EasyMenu" then
			CheckBut.icon=info.icon
			CheckBut.ExpandArrow:SetTexture(info.icon);
			CheckBut.ExpandArrow:Show();
		else
			CheckBut.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow");
			if info.hasArrow then
				CheckBut.menuList=info.menuList
				CheckBut.ExpandArrow:Show();
			else
				CheckBut.ExpandArrow:Hide();
			end
		end

		local width = CheckBut.Text:GetStringWidth()
		if width>listFrame.maxWidth then
			listFrame.maxWidth=width
		end
		listFrame:SetWidth(listFrame.maxWidth+ButHeight+26)
		listFrame:SetHeight(index *ButHeight+10)
	end
	return DownMenu
end
addonTable.PIGDownMenu=PIGDownMenu