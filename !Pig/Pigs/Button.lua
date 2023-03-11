local addonName, addonTable = ...;
local Create = addonTable.Create
-------------------
local Backdropinfo={bgFile = "interface/chatframe/chatframebackground.blp",
	edgeFile = "Interface/AddOns/!Pig/Pigs/Pig_Border.blp", edgeSize = 6,}
local BGC={0.1, 0.1, 0.1, 0.8}
local function Backdropset(self)
	self:SetBackdrop(Backdropinfo)
	self:SetBackdropColor(BGC[1],BGC[2],BGC[3],BGC[4]);
	self:SetBackdropBorderColor(0, 0, 0, 1);
end
function Create.PIGButton(Text,UIName,fuF,WH,Point)
	local But = CreateFrame("Button", UIName, fuF,"BackdropTemplate");
	Backdropset(But)
	But:SetSize(WH[1],WH[2]);
	if Point then
		But:SetPoint(Point[1],Point[2],Point[3],Point[4],Point[5]);
	end
	hooksecurefunc(But, "Enable", function(self)
		self.Text:SetTextColor(1, 0.843, 0, 1);
	end)
	hooksecurefunc(But, "Disable", function(self)
		self.Text:SetTextColor(0.5, 0.5, 0.5, 1);
	end)
	But:HookScript("OnEnter", function(self)
		if self:IsEnabled() then
			self:SetBackdropBorderColor(0,0.8,1, 0.9);
		end
	end);
	But:HookScript("OnLeave", function(self)
		if self:IsEnabled() then
			self:SetBackdropBorderColor(0, 0, 0, 1);
		end
	end);
	But:HookScript("OnMouseDown", function(self)
		if self:IsEnabled() then
			self.Text:SetPoint("CENTER", 1.5, -1.5);
		end
	end);
	But:HookScript("OnMouseUp", function(self)
		if self:IsEnabled() then
			self.Text:SetPoint("CENTER", 0, 0);
		end
	end);
	But:HookScript("PostClick", function (self)
		PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
	end)
	But.Text = But:CreateFontString();
	But.Text:SetPoint("CENTER", 0, 0);
	But.Text:SetFontObject(ChatFontNormal)
	But.Text:SetTextColor(1, 0.843, 0, 1);
	function But:SetText(TextN)
		self.Text:SetText(TextN);
	end
	function But:GetText()
		return self.Text:GetText();
	end
	But:SetText(Text)
	return But
end
--创建功能设置界面顶部按钮
function Create.PIGModbutton(GnName,GnUI,FrameLevel,ID)
	local frame = Create.PIGButton(GnName,nil,Pig_OptionsUI.R.F,{88,24},{"TOPLEFT",Pig_OptionsUI.R.F,"TOPLEFT",0+(100*(ID-1)),30})
	frame:Disable();
	frame:SetMotionScriptsWhileDisabled(true)
	frame:SetScript("OnClick", function ()
		PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
		if _G[GnUI]:IsShown() then
			_G[GnUI]:Hide();
		else
			_G[GnUI]:SetFrameLevel(FrameLevel)
			_G[GnUI]:Show();
			Pig_OptionsUI:Hide();
		end
	end);
	frame:HookScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		if not self:IsEnabled() then
			GameTooltip:AddLine(GnName.."尚未启用，请在功能内启用")
			LF_TAB_2.TexTishi:Show()
		end
		GameTooltip:Show();
	end);
	frame:HookScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide()
		LF_TAB_2.TexTishi:Hide()
	end);
	return frame
end
function Create.PIGTabBut(Text,UIName,fuF,WH,Point,id)
	local But = CreateFrame("Button", UIName, fuF,"BackdropTemplate",id)
	But.Show=false;
	Backdropset(But)
	if WH then But:SetSize(WH[1],WH[2]) end
	if Point then
		But:SetPoint(Point[1],Point[2],Point[3],Point[4],Point[5])
	end
	hooksecurefunc(But, "Enable", function(self)
		self.Text:SetTextColor(1, 0.843, 0, 1)
	end)
	hooksecurefunc(But, "Disable", function(self)
		self.Text:SetTextColor(0.5, 0.5, 0.5, 1)
	end)
	But:HookScript("OnEnter", function(self)
		if self:IsEnabled() and not self.Show then
			self:SetBackdropBorderColor(0,0.8,1, 1)
		end
	end);
	But:HookScript("OnLeave", function(self)
		if self:IsEnabled() and not self.Show then
			self:SetBackdropBorderColor(0, 0, 0, 1)
		end
	end);
	But:HookScript("OnMouseDown", function(self)
		if self:IsEnabled() and not self.Show then
			self.Text:SetPoint("CENTER", 1.5, -1.5)
		end
	end);
	But:HookScript("OnMouseUp", function(self)
		if self:IsEnabled() and not self.Show then
			self.Text:SetPoint("CENTER", 0, 0)
		end
	end);
	But.Text = But:CreateFontString()
	But.Text:SetPoint("CENTER", 0, 0)
	But.Text:SetFontObject(ChatFontNormal)
	But.Text:SetTextColor(1, 0.843, 0, 1)
	But.Text:SetText(Text);
	function But:Selected()
		PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB);
		self.Show=true;
		self.Text:SetTextColor(1, 1, 1, 1)
		--self:SetBackdropColor(0.3098,0.262745,0.0353, 1)
		self:SetBackdropColor(0.32,0.1647,0.0353, 1)
		self:SetBackdropBorderColor(1, 1, 0, 1)	
	end
	function But:NotSelected()
		self.Show=false
		self.Text:SetTextColor(1, 0.843, 0, 1)
		self:SetBackdropColor(BGC[1],BGC[2],BGC[3],BGC[4])
		self:SetBackdropBorderColor(0, 0, 0, 1)
	end
	return But
end