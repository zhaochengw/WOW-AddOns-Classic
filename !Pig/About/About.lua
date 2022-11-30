local _, addonTable = ...;

---------------------------------------------------
local fuFrame=List_R_F_1_14
local Pigtxt=addonTable.Pigtxt
------
fuFrame.top = fuFrame:CreateFontString();
fuFrame.top:SetPoint("TOP",fuFrame,"TOP",0,-14);
fuFrame.top:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.top:SetText(Pigtxt.BT);
fuFrame.line = fuFrame:CreateLine()
fuFrame.line:SetColorTexture(1,1,1,0.3)
fuFrame.line:SetThickness(1);
fuFrame.line:SetStartPoint("TOPLEFT",3,-50)
fuFrame.line:SetEndPoint("TOPRIGHT",-3,-50)
fuFrame.top1 = fuFrame:CreateFontString();
fuFrame.top1:SetPoint("TOP",fuFrame,"TOP",0,-68);
fuFrame.top1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.top1:SetText(Pigtxt.YY..Pigtxt.QQ);
--===========================================
fuFrame.fengexian = fuFrame:CreateLine()
fuFrame.fengexian:SetColorTexture(1,1,1,0.3)
fuFrame.fengexian:SetThickness(1);
fuFrame.fengexian:SetStartPoint("TOPLEFT",3,-100)
fuFrame.fengexian:SetEndPoint("TOPRIGHT",-3,-100)
fuFrame.mingxie = fuFrame:CreateFontString();
fuFrame.mingxie:SetPoint("TOP",fuFrame.fengexian,"BOTTOM",0,-8);
fuFrame.mingxie:SetFont(ChatFontNormal:GetFont(), 18, "OUTLINE");
fuFrame.mingxie:SetText("\124cffFFff00特别鸣谢:\124r");
fuFrame.mingxie1 = fuFrame:CreateFontString();
fuFrame.mingxie1:SetPoint("TOP",fuFrame.mingxie,"BOTTOM",0,-6);
fuFrame.mingxie1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.mingxie1:SetText("\124cff00ff00感谢以下玩家，提供测试/反馈/意见\124r");
---60
fuFrame.C60 = fuFrame:CreateFontString();
fuFrame.C60:SetPoint("TOP",fuFrame.mingxie1,"BOTTOM",0,-10);
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
"|cff00FFFF心灵迁徙|r [服务器:碧空之歌-部落]\n"..
"|cff00FFFF圣地法爷|r [服务器:碧空之歌-部落]\n"..
"|cff00FFFF哈老五|r [服务器:碧空之歌-部落]\n"..
"|cff00FFFF宁先生|r [服务器:哈霍兰-联盟]\n"..
"|cff00FFFF窟髅玩火|r [服务器:帕奇维克-部落]\n"
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
"|cff00FFFF心灵霜降|r [服务器:凤凰之神-部落]";
fuFrame.retail_P = fuFrame:CreateFontString();
fuFrame.retail_P:SetPoint("TOP",fuFrame.retail,"BOTTOM",0,-4);
fuFrame.retail_P:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.retail_P:SetText(fuFrame.PLAYERS_retail);