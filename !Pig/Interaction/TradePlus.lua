local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_1_UI
-------

local function jiaoyizengqiang_Open()
	if jiaoyi_zhiye_UI==nil then
		local jiaoyi_zhiye = CreateFrame("Button", "jiaoyi_zhiye_UI", TradeFrame);
		jiaoyi_zhiye:SetSize(32,32);
		jiaoyi_zhiye:SetPoint("TOP", TradeFrame, "TOP", 48, 20);
		jiaoyi_zhiye.Border = jiaoyi_zhiye:CreateTexture(nil, "BORDER");
		jiaoyi_zhiye.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
		jiaoyi_zhiye.Border:SetSize(54,54);
		jiaoyi_zhiye.Border:ClearAllPoints();
		jiaoyi_zhiye.Border:SetPoint("CENTER", 11, -12);
		jiaoyi_zhiye.Icon = jiaoyi_zhiye:CreateTexture("jiaoyi_zhiyeIcon_UI", "ARTWORK");
		jiaoyi_zhiye.Icon:SetSize(20,20);
		jiaoyi_zhiye.Icon:ClearAllPoints();
		jiaoyi_zhiye.Icon:SetPoint("CENTER");
		jiaoyi_zhiye.Icon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
		local jiaoyi_dengji = CreateFrame("Button", "jiaoyi_dengji_UI", TradeFrame);
		jiaoyi_dengji:SetSize(32,32);
		jiaoyi_dengji:SetPoint("TOP", TradeFrame, "TOP", 4, -34);
		jiaoyi_dengji.Border1 = jiaoyi_dengji:CreateTexture(nil, "BORDER");
		jiaoyi_dengji.Border1:SetTexture("interface/characterframe/ui-party-background.blp");
		jiaoyi_dengji.Border1:SetSize(24,24);
		jiaoyi_dengji.Border1:ClearAllPoints();
		jiaoyi_dengji.Border1:SetPoint("CENTER", 0, -0);
		jiaoyi_dengji.Border = jiaoyi_dengji:CreateTexture(nil, "ARTWORK");
		jiaoyi_dengji.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
		jiaoyi_dengji.Border:SetSize(54,54);
		jiaoyi_dengji.Border:ClearAllPoints();
		jiaoyi_dengji.Border:SetPoint("CENTER", 11, -12);
		jiaoyi_dengji.Text = jiaoyi_dengji:CreateFontString();
		jiaoyi_dengji.Text:SetPoint("CENTER", jiaoyi_dengji, "CENTER", 0, 0);
		jiaoyi_dengji.Text:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
		jiaoyi_dengji.Text:SetTextColor(1, 0.82, 0);
		hooksecurefunc("TradeFrame_OnShow", function(self)
			if(UnitExists("NPC"))then
				OpenAllBags()
				local IconCoord = CLASS_ICON_TCOORDS[select(2,UnitClass("NPC"))];
				jiaoyi_zhiye.Icon:SetTexCoord(unpack(IconCoord));--切出子区域
				local jibie = UnitLevel("NPC")
				jiaoyi_dengji.Text:SetText(jibie)
				if jibie<10 then
					jiaoyi_dengji.Text:SetTextColor(1, 0, 0);
				else
					jiaoyi_dengji.Text:SetTextColor(1, 0.82, 0);
				end
			end 
		end);
	end
end
--==========================================================
fuFrame.jiaoyizengqiang = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.jiaoyizengqiang:SetSize(30,32);
fuFrame.jiaoyizengqiang:SetHitRectInsets(0,-100,0,0);
fuFrame.jiaoyizengqiang:SetPoint("TOPLEFT",fuFrame.RP,"TOPLEFT",20,-50);
fuFrame.jiaoyizengqiang.Text:SetText("交易面板提示");
fuFrame.jiaoyizengqiang.tooltip = "在交易面板显示对方职业和等级！";
fuFrame.jiaoyizengqiang:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['jiaoyizengqiang']="ON";
		jiaoyizengqiang_Open();
	else
		PIG['FramePlus']['jiaoyizengqiang']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--加载设置---------------
addonTable.Interaction_jiaoyizengqiang = function()
	if PIG['FramePlus']['jiaoyizengqiang']=="ON" then
		fuFrame.jiaoyizengqiang:SetChecked(true);
		jiaoyizengqiang_Open();
	end
end
