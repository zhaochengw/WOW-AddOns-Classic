local _, addonTable = ...;
local fuFrame=List_R_F_1_1
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
-------
local function jiaoyizengqiang_Open()
	local fujiF = TradeFrame
	if fujiF.zhiye then return end
	local www,hhh=28,28
	fujiF.zhiye = CreateFrame("Button", nil, fujiF);
	fujiF.zhiye:SetSize(www,hhh);
	fujiF.zhiye:SetPoint("TOP", fujiF, "TOP", 6, 18);
	fujiF.zhiye.Border = fujiF.zhiye:CreateTexture(nil, "BORDER");
	if tocversion>40000 then fujiF.zhiye:SetFrameLevel(555) end
	fujiF.zhiye.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
	fujiF.zhiye.Border:SetSize(www+24,hhh+24);
	fujiF.zhiye.Border:ClearAllPoints();
	fujiF.zhiye.Border:SetPoint("CENTER", 10, -12);
	fujiF.zhiye.Icon = fujiF.zhiye:CreateTexture(nil, "ARTWORK");
	fujiF.zhiye.Icon:SetSize(www-9,hhh-9);
	fujiF.zhiye.Icon:ClearAllPoints();
	fujiF.zhiye.Icon:SetPoint("CENTER");
	fujiF.zhiye.Icon:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
	fujiF.dengji = CreateFrame("Button", nil, fujiF);
	fujiF.dengji:SetSize(www+2,hhh);
	fujiF.dengji:SetPoint("TOP", fujiF, "TOP", 48, -34);
	if tocversion>40000 then fujiF.dengji:SetFrameLevel(555) end
	fujiF.dengji.Border = fujiF.dengji:CreateTexture(nil, "ARTWORK");
	fujiF.dengji.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
	fujiF.dengji.Border:SetSize(www+28,hhh+24);
	fujiF.dengji.Border:ClearAllPoints();
	if tocversion<40000 then
		fujiF.dengji.Border:SetPoint("CENTER", 11, -12);
	else
		fujiF.dengji.Border:SetPoint("CENTER", 10, -12);
	end
	fujiF.dengji.Text = fujiF.dengji:CreateFontString();
	fujiF.dengji.Text:SetPoint("CENTER", fujiF.dengji, "CENTER", 0, 0);
	fujiF.dengji.Text:SetFontObject(TextStatusBarText);
	hooksecurefunc("TradeFrame_OnShow", function(self)
		if(UnitExists("NPC"))then
			local IconCoord = CLASS_ICON_TCOORDS[select(2,UnitClass("NPC"))];
			fujiF.zhiye.Icon:SetTexCoord(unpack(IconCoord));--切出子区域
			local jibie = UnitLevel("NPC")
			fujiF.dengji.Text:SetText(jibie)
			if jibie<10 then
				fujiF.dengji.Text:SetTextColor(1, 0, 0);
			else
				fujiF.dengji.Text:SetTextColor(1, 0.82, 0);
			end
		end 
	end);
end
--==========================================================
fuFrame.jiaoyizengqiang = ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame.RP,"TOPLEFT",20,-50,"交易面板提示","在交易面板显示对方职业和等级")
fuFrame.jiaoyizengqiang:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.Interaction.jiaoyizengqiang=true;
		jiaoyizengqiang_Open();
	else
		PIG.Interaction.jiaoyizengqiang=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
--加载设置---------------
addonTable.Interaction_jiaoyizengqiang = function()
	if PIG.Interaction.jiaoyizengqiang then
		fuFrame.jiaoyizengqiang:SetChecked(true);
		jiaoyizengqiang_Open();
	end
end
