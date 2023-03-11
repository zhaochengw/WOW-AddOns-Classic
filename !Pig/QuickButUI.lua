local addonName, addonTable = ...;
local gsub = _G.string.gsub
local _, _, _, tocversion = GetBuildInfo()
-------
local fuFrame = List_R_F_1_7
local Create = addonTable.Create
local PIGFrame=Create.PIGFrame
local ADD_Checkbutton=addonTable.ADD_Checkbutton

--快捷按钮栏======================
local ActionW = ActionButton1:GetWidth()
local WowHeight=GetScreenHeight()/2;
local QuickButton = CreateFrame("Frame", "QuickButtonUI", UIParent);
QuickButton:SetSize(ActionW*10+12,ActionW);
QuickButton:SetPoint("BOTTOM",UIParent,"BOTTOM",200,200)
QuickButton:SetMovable(true)
QuickButton:SetClampedToScreen(true)
QuickButton:Hide()
QuickButton.yidong=PIGFrame(QuickButton,{14,ActionW},{"LEFT", QuickButton, "LEFT", 0, 0})
QuickButton.yidong:PIGSetBackdrop(0.6,1)
QuickButton.yidong:PIGSetMovable(QuickButton)
QuickButton.yidong:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("|cff00FFff左键拖动，右键设置|r")
	GameTooltip:Show();
end);
QuickButton.yidong:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
QuickButton.yidong.hit = QuickButton.yidong:CreateTexture(nil, "HIGHLIGHT");
QuickButton.yidong.hit:SetTexture("Interface/Buttons/ButtonHilight-Square");
QuickButton.yidong.hit:SetAllPoints(QuickButton.yidong)
QuickButton.yidong.hit:SetBlendMode("ADD")
QuickButton.yidong.set=PIGFrame(QuickButton.yidong,{150,150},{"CENTER", UIParent, "CENTER", 0, 0})
QuickButton.yidong.set:PIGSetBackdrop(0.6,1)
QuickButton.yidong.set:PIGClose(24,24,QuickButton.yidong.set)
QuickButton.yidong.set:Hide()
QuickButton.yidong.set:SetIgnoreParentScale(true)
QuickButton.yidong.set.suoding=ADD_Checkbutton(nil,QuickButton.yidong.set,-60,"TOPLEFT",QuickButton.yidong.set,"TOPLEFT",10,-10,"锁定位置","锁定快捷按钮位置，并隐藏拖拽图标")
QuickButton.yidong.set.suoding:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['QuickButton']['suoding']=true;
		QuickButton.yidong.title:SetText("锁\n定")
		QuickButtonUI.yidong:RegisterForDrag(nil)
	else
		PIG['QuickButton']['suoding']=false;
		QuickButton.yidong.title:SetText("拖\n动")
		QuickButtonUI.yidong:RegisterForDrag("LeftButton")
	end
end);
--
-------
QuickButton.yidong.set.suofangdaxiao = QuickButton.yidong.set:CreateFontString();
QuickButton.yidong.set.suofangdaxiao:SetPoint("TOPLEFT",QuickButton.yidong.set.suoding,"TOPLEFT",10,-40);
QuickButton.yidong.set.suofangdaxiao:SetFontObject(GameFontNormal);
QuickButton.yidong.set.suofangdaxiao:SetText('缩放比例:');
local suofangmin,suofangmax,S_step = 0.6,1.4,0.1
QuickButton.yidong.set.suofangdaxiao_Slider = CreateFrame("Slider", nil, QuickButton.yidong.set, "OptionsSliderTemplate")
QuickButton.yidong.set.suofangdaxiao_Slider:SetWidth(100)
QuickButton.yidong.set.suofangdaxiao_Slider:SetHeight(15)
QuickButton.yidong.set.suofangdaxiao_Slider:SetPoint("TOPLEFT",QuickButton.yidong.set.suofangdaxiao,"BOTTOMLEFT",0,-20);
QuickButton.yidong.set.suofangdaxiao_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
QuickButton.yidong.set.suofangdaxiao_Slider:SetMinMaxValues(suofangmin,suofangmax);
QuickButton.yidong.set.suofangdaxiao_Slider:SetValueStep(S_step);
QuickButton.yidong.set.suofangdaxiao_Slider:SetObeyStepOnDrag(true);
QuickButton.yidong.set.suofangdaxiao_Slider.Low:SetText(suofangmin);
QuickButton.yidong.set.suofangdaxiao_Slider.High:SetText(suofangmax);
QuickButton.yidong.set.suofangdaxiao_Slider:EnableMouseWheel(true);
QuickButton.yidong.set.suofangdaxiao_Slider:SetScript("OnMouseWheel", function(self, arg1)
	local sliderMin, sliderMax = self:GetMinMaxValues()
	local value = self:GetValue()
	local step = S_step * arg1
	if step > 0 then
		self:SetValue(min(value + step, sliderMax))
	else
		self:SetValue(max(value + step, sliderMin))
	end
end)
QuickButton.yidong.set.suofangdaxiao_Slider:SetScript('OnValueChanged', function(self)
	local Hval = self:GetValue()+0.05
	local Hval = Hval*10
	local Hval = floor(Hval)*0.1
	self.Text:SetText(Hval);
	PIG['QuickButton']['bili']=Hval;
	QuickButtonUI:SetScale(Hval);
end)
--
QuickButton.yidong.set.suoding:HookScript("OnShow", function (self)
	if PIG['QuickButton']['suoding'] then
		QuickButton.yidong.set.suoding:SetChecked(true);
	end
end);
QuickButton.yidong:SetScript("OnMouseUp", function(self,Button)
	if Button=="RightButton" then
		if self.set:IsShown() then
			self.set:Hide()
		else
			self.set:Show()
		end
	end
end)
QuickButton.yidong.title = QuickButton.yidong:CreateFontString();
QuickButton.yidong.title:SetAllPoints(QuickButton.yidong)
QuickButton.yidong.title:SetFont(ChatFontNormal:GetFont(), 10)
QuickButton.yidong.title:SetTextColor(0.8, 0.8, 0.8, 0.8)
QuickButton.yidong.title:SetText("拖\n动")
QuickButton.nr=PIGFrame(QuickButton,{ActionW*10,ActionW},{"LEFT",QuickButton.yidong,"RIGHT",0.8,0})
QuickButton.nr:PIGSetBackdrop(0.6,1)

--设置面板=========================
local function QuickButtonUpdate()
	addonTable.ADD_QuickButton_QuickFollow()
	addonTable.ADD_QuickButton_Lushi()
	addonTable.ADD_QuickButton_Spell()
	addonTable.ADD_QuickButton_AutoEquip()
	addonTable.ADD_QuickButton_AutoSellBuy()
	addonTable.ADD_QuickButton_SkillfubenCD()
	addonTable.ADD_QuickButton_SpellJK()
	addonTable.ADD_QuickButton_PlaneInvite()
	addonTable.ADD_QuickButton_RaidRecord()
	addonTable.ADD_QuickButton_daiben()
	addonTable.ADD_QuickButton_AFK()
end
addonTable.QuickButtonUpdate = QuickButtonUpdate
---------

fuFrame.QuickButtonOpen=ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"快捷按钮栏","在屏幕上创建一条快捷按钮栏，以便快捷使用某些功能。\n你可以自定义需要显示的按钮")
fuFrame.QuickButtonOpen:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['QuickButton']['Open']=true;
		QuickButtonUI:Show()
	else
		PIG['QuickButton']['Open']=false;
		QuickButtonUI:Hide()
	end
	QuickButtonUpdate()
end);
---重置位置
fuFrame.QuickButtonOpen.CZPoint = CreateFrame("Button",nil,fuFrame.QuickButtonOpen);
fuFrame.QuickButtonOpen.CZPoint:SetSize(22,22);
fuFrame.QuickButtonOpen.CZPoint:SetPoint("LEFT",fuFrame.QuickButtonOpen.Text,"RIGHT",16,-1);
fuFrame.QuickButtonOpen.CZPoint.highlight = fuFrame.QuickButtonOpen.CZPoint:CreateTexture(nil, "HIGHLIGHT");
fuFrame.QuickButtonOpen.CZPoint.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
fuFrame.QuickButtonOpen.CZPoint.highlight:SetBlendMode("ADD")
fuFrame.QuickButtonOpen.CZPoint.highlight:SetPoint("CENTER", fuFrame.QuickButtonOpen.CZPoint, "CENTER", 0,0);
fuFrame.QuickButtonOpen.CZPoint.highlight:SetSize(30,30);
fuFrame.QuickButtonOpen.CZPoint.Normal = fuFrame.QuickButtonOpen.CZPoint:CreateTexture(nil, "BORDER");
fuFrame.QuickButtonOpen.CZPoint.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
fuFrame.QuickButtonOpen.CZPoint.Normal:SetBlendMode("ADD")
fuFrame.QuickButtonOpen.CZPoint.Normal:SetPoint("CENTER", fuFrame.QuickButtonOpen.CZPoint, "CENTER", 0,0);
fuFrame.QuickButtonOpen.CZPoint.Normal:SetSize(18,18);
fuFrame.QuickButtonOpen.CZPoint:HookScript("OnMouseDown", function (self)
	self.Normal:SetPoint("CENTER", fuFrame.QuickButtonOpen.CZPoint, "CENTER", -1.5,-1.5);
end);
fuFrame.QuickButtonOpen.CZPoint:HookScript("OnMouseUp", function (self)
	self.Normal:SetPoint("CENTER", fuFrame.QuickButtonOpen.CZPoint, "CENTER", 0,0);
end);
fuFrame.QuickButtonOpen.CZPoint:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(fuFrame.QuickButtonOpen.CZPoint, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("\124cff00ff00重置快捷按钮的位置\124r")
	GameTooltip:Show();
end);
fuFrame.QuickButtonOpen.CZPoint:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
local function CZweizhiQK()
	if tocversion<100000 then
		QuickButtonUI:SetPoint(PIG['QuickButton']['Point'][1],UIParent,PIG['QuickButton']['Point'][2],PIG['QuickButton']['Point'][3],PIG['QuickButton']['Point'][4]);
	else
		QuickButtonUI:SetPoint(PIG['QuickButton']['Point'][1],UIParent,PIG['QuickButton']['Point'][2],PIG['QuickButton']['Point'][3]-200,PIG['QuickButton']['Point'][4]+90);
	end
end
fuFrame.QuickButtonOpen.CZPoint:SetScript("OnClick", function ()
	QuickButtonUI:ClearAllPoints();
	PIG['QuickButton']['Point']=addonTable.Default['QuickButton']['Point'];
	CZweizhiQK()
end)
-------
addonTable.QuickButton = function()
	--CZweizhiQK()
	QuickButton.yidong.set.suofangdaxiao_Slider:SetValue(PIG['QuickButton']['bili']);
	if PIG['QuickButton']['Open'] then
		fuFrame.QuickButtonOpen:SetChecked(true);
		if PIG['QuickButton']['suoding'] then
			QuickButtonUI.yidong.title:SetText("锁\n定")
			QuickButtonUI.yidong:RegisterForDrag("")
		end
	end
end