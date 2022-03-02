local _, addonTable = ...;

---------------------------------------------------
local fuFrame=Pig_Options_RF_TAB_15_UI
fuFrame.PigAbout=addonTable.QQqun
------
fuFrame.title = fuFrame:CreateFontString();
fuFrame.title:SetPoint("TOP",fuFrame,"TOP",0,-34);
fuFrame.title:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.title:SetText("玩家交流\124cff00ff00YY频道113213\124r, 插件问题反馈:"..fuFrame.PigAbout);

fuFrame.line = fuFrame:CreateLine()
fuFrame.line:SetColorTexture(1,1,1,0.3)
fuFrame.line:SetThickness(1);
fuFrame.line:SetStartPoint("TOPLEFT",3,-80)
fuFrame.line:SetEndPoint("TOPRIGHT",-3,-80)
--===========================================
fuFrame.title1 = fuFrame:CreateFontString();
fuFrame.title1:SetPoint("TOP",fuFrame.line,"BOTTOM",0,-8);
fuFrame.title1:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
fuFrame.title1:SetText("\124cff00ff00特别鸣谢:\124r");
---60
fuFrame.C60 = fuFrame:CreateFontString();
fuFrame.C60:SetPoint("TOP",fuFrame.title1,"BOTTOM",0,-10);
fuFrame.C60:SetFontObject(GameFontNormal);
fuFrame.C60:SetText("经典旧世(60):");
PLAYERS_C60=
"|cff00FFFF剑与远征|r [服务器:艾隆纳亚-联盟]\n"..
"|cff00FFFF强悍的恋恋鱼|r [服务器:辛洛斯-联盟]";
fuFrame.C60_P = fuFrame:CreateFontString();
fuFrame.C60_P:SetPoint("TOP",fuFrame.C60,"BOTTOM",0,-4);
fuFrame.C60_P:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.C60_P:SetText(PLAYERS_C60);

--70
fuFrame.C70 = fuFrame:CreateFontString();
fuFrame.C70:SetPoint("TOP",fuFrame.C60_P,"BOTTOM",0,-10);
fuFrame.C70:SetFontObject(GameFontNormal);
fuFrame.C70:SetText("燃烧的远征(70):");
fuFrame.PLAYERS_C70=
"|cff00FFFF猪猪加油|r [服务器:碧空之歌-部落]\n"..
"|cff00FFFF心灵迁徙|r [服务器:碧空之歌-部落]\n"..
"|cff00FFFF圣地法爷|r [服务器:碧空之歌-部落]\n"..
"|cff00FFFF哈老五|r [服务器:碧空之歌-部落]\n"..
"|cff00FFFF宁先生|r [服务器:哈霍兰-联盟]\n"
fuFrame.C70_P = fuFrame:CreateFontString();
fuFrame.C70_P:SetPoint("TOP",fuFrame.C70,"BOTTOM",0,-4);
fuFrame.C70_P:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.C70_P:SetText(fuFrame.PLAYERS_C70);


---正式服
fuFrame.retail = fuFrame:CreateFontString();
fuFrame.retail:SetPoint("TOP",fuFrame.C70_P,"BOTTOM",0,-10);
fuFrame.retail:SetFontObject(GameFontNormal);
fuFrame.retail:SetText("正式服");
fuFrame.PLAYERS_retail=
"|cff00FFFF猪猪加油|r [服务器:火烟之谷-部落]";
fuFrame.retail_P = fuFrame:CreateFontString();
fuFrame.retail_P:SetPoint("TOP",fuFrame.retail,"BOTTOM",0,-4);
fuFrame.retail_P:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.retail_P:SetText(fuFrame.PLAYERS_retail);
----------
fuFrame.XIEXIE = fuFrame:CreateFontString();
fuFrame.XIEXIE:SetPoint("BOTTOM",fuFrame,"BOTTOM",0,6);
fuFrame.XIEXIE:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.XIEXIE:SetText("\124cff00ff00感谢以上玩家，提供反馈以及意见\124r");

----------------------------------2431
fuFrame.Pigbut1 = CreateFrame("Button",nil,fuFrame, "UIPanelSquareButton");  
fuFrame.Pigbut1:SetSize(14,14);
fuFrame.Pigbut1:SetPoint("TOPLEFT",fuFrame.line,"TOPLEFT",2,-2);
fuFrame.Pigbut1:SetScript("OnClick", function ()
	if not PIG["RaidRecord"]["Invite"]["jihuo"] then PIG["RaidRecord"]["Invite"]["jihuo"]={nil,nil,nil,nil} end
	if PIG["RaidRecord"]["Invite"]["jihuo"][2]==true and PIG["RaidRecord"]["Invite"]["jihuo"][4]==true and PIG["RaidRecord"]["Invite"]["jihuo"][3]==true then
		PIG["RaidRecord"]["Invite"]["jihuo"][1]=true
	else
		PIG["RaidRecord"]["Invite"]["jihuo"][1]=nil
		PIG["RaidRecord"]["Invite"]["jihuo"][3]=nil
		PIG["RaidRecord"]["Invite"]["jihuo"][4]=nil
		PIG["RaidRecord"]["Invite"]["jihuo"][2]=nil
	end
end);
fuFrame.Pigbut2 = CreateFrame("Button",nil,fuFrame, "UIPanelSquareButton");  
fuFrame.Pigbut2:SetSize(14,14);
fuFrame.Pigbut2:SetPoint("TOPRIGHT",fuFrame.line,"TOPRIGHT",-2,-2);
fuFrame.Pigbut2:SetScript("OnClick", function ()
	if not PIG["RaidRecord"]["Invite"]["jihuo"] then PIG["RaidRecord"]["Invite"]["jihuo"]={nil,nil,nil,nil} end
	PIG["RaidRecord"]["Invite"]["jihuo"][1]=nil
	PIG["RaidRecord"]["Invite"]["jihuo"][3]=nil
	PIG["RaidRecord"]["Invite"]["jihuo"][4]=nil
	PIG["RaidRecord"]["Invite"]["jihuo"][2]=true
end);
fuFrame.Pigbut3 = CreateFrame("Button",nil,fuFrame, "UIPanelSquareButton");  
fuFrame.Pigbut3:SetSize(14,14);
fuFrame.Pigbut3:SetPoint("BOTTOMLEFT",fuFrame,"BOTTOMLEFT",2,2);
fuFrame.Pigbut3:SetScript("OnClick", function ()
	if not PIG["RaidRecord"]["Invite"]["jihuo"] then PIG["RaidRecord"]["Invite"]["jihuo"]={nil,nil,nil,nil} end
	if PIG["RaidRecord"]["Invite"]["jihuo"][2]==true and PIG["RaidRecord"]["Invite"]["jihuo"][4]==true then
		PIG["RaidRecord"]["Invite"]["jihuo"][3]=true
	else
		PIG["RaidRecord"]["Invite"]["jihuo"][1]=nil
		PIG["RaidRecord"]["Invite"]["jihuo"][3]=nil
		PIG["RaidRecord"]["Invite"]["jihuo"][4]=nil
		PIG["RaidRecord"]["Invite"]["jihuo"][2]=nil
	end
end);
fuFrame.Pigbut4 = CreateFrame("Button",nil,fuFrame, "UIPanelSquareButton");  
fuFrame.Pigbut4:SetSize(14,14);
fuFrame.Pigbut4:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",-2,2);
fuFrame.Pigbut4:SetScript("OnClick", function ()
	if not PIG["RaidRecord"]["Invite"]["jihuo"] then PIG["RaidRecord"]["Invite"]["jihuo"]={nil,nil,nil,nil} end
	if PIG["RaidRecord"]["Invite"]["jihuo"][2]==true then
		PIG["RaidRecord"]["Invite"]["jihuo"][4]=true
	else
		PIG["RaidRecord"]["Invite"]["jihuo"][1]=nil
		PIG["RaidRecord"]["Invite"]["jihuo"][3]=nil
		PIG["RaidRecord"]["Invite"]["jihuo"][4]=nil
		PIG["RaidRecord"]["Invite"]["jihuo"][2]=nil
	end
end);