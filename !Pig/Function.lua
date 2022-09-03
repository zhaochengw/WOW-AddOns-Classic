local addonName, addonTable = ...;
-------------
function table.removekey(table, key)
    local element = table[key]
    table[key] = nil
    return element
end
--创建框架
local function ADD_Frame(UIName,fuFrame,Width,Height,PointZi,Point,PointFu,PointX,PointY,EnableMouse,Movable,SetClampedToScreen,Hide,ESCOFF)
	local frame = CreateFrame("Frame", UIName, fuFrame,"BackdropTemplate");
	frame:SetSize(Width,Height);
	frame:SetPoint(PointZi,Point,PointFu,PointX,PointY);
	if EnableMouse then frame:EnableMouse(true) end
	if Movable then frame:SetMovable(true) end
	if SetClampedToScreen then frame:SetClampedToScreen(true) end
	if Hide then frame:Hide() end
	if ESCOFF then
		tinsert(UISpecialFrames,UIName);
	end
	return frame
end
addonTable.ADD_Frame=ADD_Frame
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
local function ADD_Checkbutton(GnName,Tooltip,fuFrame,Cfanwei,Point,PointX,PointY,frameName)
	local frame = CreateFrame("CheckButton", frameName, fuFrame, "ChatConfigCheckButtonTemplate");
	frame:SetSize(30,30);
	frame:SetHitRectInsets(0,Cfanwei,0,0);
	frame:SetPoint("TOPLEFT",Point,"TOPLEFT",PointX,PointY);
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