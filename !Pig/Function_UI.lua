local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
-------------
--创建框架
local function ADD_Frame(UIName,fuFrame,Width,Height,PointZi,Point,PointFu,PointX,PointY,EnableMouse,Show,Movable,ToScreen,ESCOFF,Backdrop)
	local frame = CreateFrame("Frame", UIName, fuFrame,"BackdropTemplate");
	frame:SetSize(Width,Height);
	frame:SetPoint(PointZi,Point,PointFu,PointX,PointY);
	frame:EnableMouse(EnableMouse)
	frame:SetShown(Show)
	if Movable then
		frame:SetMovable(true)
		frame:RegisterForDrag("LeftButton")
		frame:SetScript("OnDragStart",function(self)
			self:StartMoving()
		end)
		frame:SetScript("OnDragStop",function(self)
			self:StopMovingOrSizing()
		end)
		frame:SetClampedToScreen(ToScreen)
	end
	if ESCOFF then
		tinsert(UISpecialFrames,UIName);
	end
	if Backdrop=="BG1" then
		frame:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = false, tileSize = 0, edgeSize = 18, 
			insets = { left = 4, right = 4, top = 4, bottom = 4 } });
		frame:SetBackdropColor(0, 0, 0, 0.6);
		frame:SetBackdropBorderColor(1, 1, 1, 0.8);
	elseif Backdrop=="BG2" then
		frame.BG = frame:CreateTexture(nil, "BACKGROUND");
		frame.BG:SetTexture("interface/framegeneral/ui-background-rock.blp");
		frame.BG:SetPoint("TOPLEFT", frame, "TOPLEFT",3, -23);
		frame.BG:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",-3, 3);
		frame.biaotiBG = frame:CreateTexture(nil, "BACKGROUND");
		frame.biaotiBG:SetTexture(374157);
		frame.biaotiBG:SetTexCoord(0.00,0.29,0.00,0.42,3.70,0.29,3.70,0.42);
		frame.biaotiBG:SetPoint("TOPLEFT", frame, "TOPLEFT",2, -2);
		frame.biaotiBG:SetPoint("TOPRIGHT", frame, "TOPRIGHT",-24, -1);
		frame.biaotiBG:SetHeight(22);

		frame.TOPLEFT = frame:CreateTexture(nil, "BORDER");
		frame.TOPLEFT:SetTexture(374156);
		frame.TOPLEFT:SetPoint("TOPLEFT", frame, "TOPLEFT",-6, 2);
		frame.TOPLEFT:SetTexCoord(0.63,0.28,0.63,0.53,0.88,0.28,0.88,0.53);
		frame.TOPLEFT:SetSize(33,33);
		frame.TOPRIGHT = frame:CreateTexture(nil, "BORDER");
		frame.TOPRIGHT:SetTexture(374156);
		frame.TOPRIGHT:SetPoint("TOPRIGHT", frame, "TOPRIGHT",0, 2);
		frame.TOPRIGHT:SetTexCoord(0.63,0.01,0.63,0.27,0.89,0.01,0.89,0.27);
		frame.TOPRIGHT:SetSize(33,35);
		frame.BOTTOMLEFT = frame:CreateTexture(nil, "BORDER");
		frame.BOTTOMLEFT:SetTexture(374156);
		frame.BOTTOMLEFT:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT",-4.8, -4);
		frame.BOTTOMLEFT:SetTexCoord(0.01,0.63,0.01,0.74,0.12,0.63,0.12,0.74);
		frame.BOTTOMLEFT:SetSize(14,14);
		frame.BOTTOMRIGHT = frame:CreateTexture(nil, "BORDER");
		frame.BOTTOMRIGHT:SetTexture(374156);
		frame.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",0, -4);
		frame.BOTTOMRIGHT:SetTexCoord(0.13,0.90,0.13,0.98,0.22,0.90,0.22,0.98);
		frame.BOTTOMRIGHT:SetSize(11,11);
		frame.TOP = frame:CreateTexture(nil, "BORDER");
		frame.TOP:SetTexture(374157);
		frame.TOP:SetTexCoord(0.00,0.44,0.00,0.66,3.57,0.44,3.57,0.66);
		frame.TOP:SetPoint("TOPLEFT", frame.TOPLEFT, "TOPRIGHT",0, 0)
		frame.TOP:SetPoint("TOPRIGHT", frame.TOPRIGHT, "TOPLEFT",0, 0);
		frame.TOP:SetHeight(29.6);
		frame.LEFT = frame:CreateTexture(nil, "BORDER");
		frame.LEFT:SetTexture(374153);
		frame.LEFT:SetTexCoord(0.36,0.00,0.36,2.29,0.61,0.00,0.61,2.29);
		frame.LEFT:SetPoint("TOPLEFT", frame.TOPLEFT, "BOTTOMLEFT",1, 0);
		frame.LEFT:SetPoint("BOTTOMLEFT", frame.BOTTOMLEFT, "TOPLEFT",1, 0);
		frame.LEFT:SetWidth(16);
		frame.RIGHT = frame:CreateTexture(nil, "BORDER");
		frame.RIGHT:SetTexture(374153);
		frame.RIGHT:SetTexCoord(0.17,0.00,0.17,2.3,0.33,0.00,0.33,2.30);
		frame.RIGHT:SetPoint("TOPRIGHT", frame.TOPRIGHT, "BOTTOMRIGHT",1, 0);
		frame.RIGHT:SetPoint("BOTTOMRIGHT", frame.BOTTOMRIGHT, "TOPRIGHT",0, 0);
		frame.RIGHT:SetWidth(10);
		frame.BOTTOM = frame:CreateTexture(nil, "BORDER");
		frame.BOTTOM:SetTexture(374157);
		frame.BOTTOM:SetTexCoord(0.00,0.20,0.00,0.27,3.73,0.20,3.73,0.27);
		frame.BOTTOM:SetPoint("BOTTOMLEFT", frame.BOTTOMLEFT, "BOTTOMRIGHT",0,0)
		frame.BOTTOM:SetPoint("BOTTOMRIGHT", frame.BOTTOMRIGHT, "BOTTOMLEFT",0,0);
		frame.BOTTOM:SetHeight(10);
	elseif Backdrop=="BG3" then
		frame.BG = frame:CreateTexture(nil, "BACKGROUND");
		frame.BG:SetTexture("interface/raidframe/ui-raidframe-groupbg.blp");
		frame.BG:SetPoint("TOPLEFT", frame, "TOPLEFT",0, 0);
		frame.BG:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",0, 0);

		frame.TOPLEFT = frame:CreateTexture(nil, "BORDER");
		frame.TOPLEFT:SetTexture(374156);
		frame.TOPLEFT:SetPoint("TOPLEFT", frame, "TOPLEFT",0, 0);
		frame.TOPLEFT:SetTexCoord(0.6328125,0.546875,0.6328125,0.59375,0.6796875,0.546875,0.6796875,0.59375);
		frame.TOPLEFT:SetSize(6,6);
		frame.TOPRIGHT = frame:CreateTexture(nil, "BORDER");
		frame.TOPRIGHT:SetTexture(374156);
		frame.TOPRIGHT:SetPoint("TOPRIGHT", frame, "TOPRIGHT",0, 0);
		frame.TOPRIGHT:SetTexCoord(0.90625,0.21875,0.90625,0.265625,0.953125,0.21875,0.953125,0.265625);
		frame.TOPRIGHT:SetSize(6,6);
		frame.BOTTOMLEFT = frame:CreateTexture(nil, "BORDER");
		frame.BOTTOMLEFT:SetTexture(374156);
		frame.BOTTOMLEFT:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT",0, -1);
		frame.BOTTOMLEFT:SetTexCoord(0.6953125,0.546875,0.6953125,0.59375,0.7421875,0.546875,0.7421875,0.59375);
		frame.BOTTOMLEFT:SetSize(6,6);
		frame.BOTTOMRIGHT = frame:CreateTexture(nil, "BORDER");
		frame.BOTTOMRIGHT:SetTexture(374156);
		frame.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",0, -1);
		frame.BOTTOMRIGHT:SetTexCoord(0.7578125,0.546875,0.7578125,0.59375,0.8046875,0.546875,0.8046875,0.59375);
		frame.BOTTOMRIGHT:SetSize(6,6);
		frame.TOP = frame:CreateTexture(nil, "BORDER");
		frame.TOP:SetTexture(374157);
		frame.TOP:SetTexCoord(0,0.0859375,0,0.109375,1,0.0859375,1,0.109375);
		frame.TOP:SetPoint("TOPLEFT", frame.TOPLEFT, "TOPRIGHT",0, 0)
		frame.TOP:SetPoint("TOPRIGHT", frame.TOPRIGHT, "TOPLEFT",0, 0);
		frame.TOP:SetHeight(3);
		frame.LEFT = frame:CreateTexture(nil, "BORDER");
		frame.LEFT:SetTexture(374153);
		frame.LEFT:SetTexCoord(0.09375,0,0.09375,1,0.140625,0,0.140625,1);
		frame.LEFT:SetPoint("TOPLEFT", frame.TOPLEFT, "BOTTOMLEFT",0, 0);
		frame.LEFT:SetPoint("BOTTOMLEFT", frame.BOTTOMLEFT, "TOPLEFT",0, 0);
		frame.LEFT:SetWidth(3);
		frame.RIGHT = frame:CreateTexture(nil, "BORDER");
		frame.RIGHT:SetTexture(374153);
		frame.RIGHT:SetTexCoord(0.015625,0,0.015625,1,0.0625,0,0.0625,1);
		frame.RIGHT:SetPoint("TOPRIGHT", frame.TOPRIGHT, "BOTTOMRIGHT",1, 0);
		frame.RIGHT:SetPoint("BOTTOMRIGHT", frame.BOTTOMRIGHT, "TOPRIGHT",0, 0);
		frame.RIGHT:SetWidth(3);
		frame.BOTTOM = frame:CreateTexture(nil, "BORDER");
		frame.BOTTOM:SetTexture(374157);
		frame.BOTTOM:SetTexCoord(0,0.0078125,0,0.03125,1,0.0078125,1,0.03125);
		frame.BOTTOM:SetPoint("BOTTOMLEFT", frame.BOTTOMLEFT, "BOTTOMRIGHT",0,0)
		frame.BOTTOM:SetPoint("BOTTOMRIGHT", frame.BOTTOMRIGHT, "BOTTOMLEFT",0,0);
		frame.BOTTOM:SetHeight(3);
	end
	return frame
end
addonTable.ADD_Frame=ADD_Frame
local function ADD_Biaoti(self)
	self.TexC = self:CreateTexture(nil, "BORDER");
	self.TexC:SetTexture("interface/friendsframe/whoframe-columntabs.blp");
	self.TexC:SetTexCoord(0.08,0.00,0.08,0.59,0.91,0.00,0.91,0.59);
	self.TexC:SetPoint("TOPLEFT",self,"TOPLEFT",5,0);
	self.TexC:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",-5,0);
	self.TexL = self:CreateTexture(nil, "BORDER");
	self.TexL:SetTexture("interface/friendsframe/whoframe-columntabs.blp");
	self.TexL:SetTexCoord(0.00,0.00,0.00,0.59,0.08,0.00,0.08,0.59);
	self.TexL:SetPoint("TOPRIGHT",self.TexC,"TOPLEFT",0,0);
	self.TexL:SetPoint("BOTTOMRIGHT",self.TexC,"BOTTOMLEFT",0,0);
	self.TexL:SetWidth(5)
	self.TexR = self:CreateTexture(nil, "BORDER");
	self.TexR:SetTexture("interface/friendsframe/whoframe-columntabs.blp");
	self.TexR:SetTexCoord(0.91,0.00,0.91,0.59,0.97,0.00,0.97,0.59);
	self.TexR:SetPoint("TOPLEFT",self.TexC,"TOPRIGHT",0,0);
	self.TexR:SetPoint("BOTTOMLEFT",self.TexC,"BOTTOMRIGHT",0,0);
	self.TexR:SetWidth(5)
end
addonTable.ADD_Biaoti=ADD_Biaoti
--创建按钮
local function ADD_Button(GnName,UIName,fuFrame,Width,Height,Point,PointX,PointY)
	local frame = CreateFrame("Button", UIName, fuFrame, "UIPanelButtonTemplate");  
	frame:SetSize(Width,Height);
	frame:SetPoint("TOPLEFT",Point,"TOPLEFT",PointX,PointY);
	frame:SetText(GnName);
	return frame
end
addonTable.ADD_Button=ADD_Button
--创建选择按钮
local function ADD_Checkbutton(frameName,fuFrame,fanwei,Point,fuPoint,rPoint,PointX,PointY,GnName,Tooltip)
	local frame = CreateFrame("CheckButton", frameName, fuFrame, "ChatConfigCheckButtonTemplate");
	frame:SetSize(30,30);
	frame:SetHitRectInsets(0,fanwei,0,0);
	frame:SetPoint(Point,fuPoint,rPoint,PointX,PointY);
	frame.Text:SetText(GnName);
	frame.tooltip = Tooltip
	return frame
end
addonTable.ADD_Checkbutton=ADD_Checkbutton
--创建功能开启按钮
local function ADD_ModCheckbutton(GnName,Tooltip,fuFrame,Cfanwei,ID)
	local frame = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
	frame:SetSize(30,30);
	frame:SetHitRectInsets(0,Cfanwei,0,0);
	frame:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20, -20);

	frame.Text:SetText("启用"..GnName);
	frame.tooltip = Tooltip
	frame.ADD = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
	frame.ADD:SetSize(30,30);
	frame.ADD:SetHitRectInsets(0,-100,0,0);
	frame.ADD:SetMotionScriptsWhileDisabled(true) 
	frame.ADD:SetPoint("LEFT",frame,"RIGHT",200,0);
	frame.ADD.Text:SetText("添加<"..GnName..">到快捷按钮栏");
	frame.ADD.tooltip = "添加<"..GnName..">到快捷按钮栏，以便快速打开。\n|cff00FF00注意：此功能需先打开快捷按钮栏功能|r";
	return frame
end
addonTable.ADD_ModCheckbutton=ADD_ModCheckbutton
--创建功能设置界面顶部按钮
local function ADD_Modbutton(GnName,GnUI,FrameLevel,ID)
	local frame= CreateFrame("Button",nil,Pig_OptionsUI, "UIPanelButtonTemplate");  
	frame:SetSize(88,28);
	frame:SetPoint("TOPLEFT",Pig_OptionsUI,"TOPLEFT",190+(100*(ID-1)),-24);
	frame:SetText(GnName);
	frame:Disable();
	frame:SetMotionScriptsWhileDisabled(true)
	frame:SetScript("OnClick", function ()
		if _G[GnUI]:IsShown() then
			_G[GnUI]:Hide();
		else
			_G[GnUI]:SetFrameLevel(FrameLevel)
			_G[GnUI]:Show();
			Pig_OptionsUI:Hide();
		end
	end);
	frame:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		if not self:IsEnabled() then
			GameTooltip:AddLine(GnName.."尚未启用，请在功能内启用")
			LF_TAB_2.TexTishi:Show()
		end
		GameTooltip:Show();
	end);
	frame:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide()
		LF_TAB_2.TexTishi:Hide()
	end);
	return frame
end
addonTable.ADD_Modbutton=ADD_Modbutton
--新建快捷按钮栏按钮
local function ADD_QuickButton(QkBut,Tooltip,Icon,Template)
	Template=Template or "SecureHandlerClickTemplate"
	local fuFrame = QuickButtonUI.nr
	local butW = fuFrame:GetHeight()
	local butFrame = CreateFrame("Button", QkBut, fuFrame,Template);
	butFrame:SetNormalTexture(Icon)
	butFrame:SetHighlightTexture(130718);
	butFrame:SetSize(butW-2,butW-2);
	butFrame:RegisterForClicks("LeftButtonUp","RightButtonUp");
	local Children = {fuFrame:GetChildren()};
	local geshu = #Children;
	butFrame:SetPoint("LEFT",fuFrame,"LEFT",(geshu-1)*(butW),0);
	butFrame:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",2,4);
		GameTooltip:AddLine(Tooltip)
		GameTooltip:Show();
	end);
	butFrame:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	butFrame.Down = butFrame:CreateTexture(nil, "OVERLAY");
	butFrame.Down:SetTexture(130839);
	butFrame.Down:SetAllPoints(butFrame)
	butFrame.Down:Hide();
	butFrame:SetScript("OnMouseDown", function (self)
		self.Down:Show();
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	butFrame:SetScript("OnMouseUp", function (self)
		self.Down:Hide();
	end);
	local NewWidth = butW*geshu;
	fuFrame:SetWidth(NewWidth);
	QuickButtonUI:SetWidth(NewWidth+12);
	QuickButtonUI:Show();
	return butFrame
end
addonTable.ADD_QuickButton=ADD_QuickButton