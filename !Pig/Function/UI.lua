local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
-------------
--创建框架
local function ADD_Frame(UIName,fuFrame,Width,Height,PointZi,Point,PointFu,PointX,PointY,EnableMouse,Show,Movable,ToScreen,ESCOFF,Backdrop)
	local frame = CreateFrame("Frame", UIName, fuFrame,"BackdropTemplate");
	frame:SetSize(Width,Height);
	frame:SetPoint(PointZi,Point,PointFu,PointX,PointY);
	frame:EnableMouse(EnableMouse)
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
		frame:Hide()
		tinsert(UISpecialFrames,UIName);
	else
		frame:SetShown(Show)
	end
	if Backdrop=="BG1" then--常规白边框透明底
		frame:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = false, tileSize = 0, edgeSize = 18, 
			insets = { left = 4, right = 4, top = 4, bottom = 4 } });
		frame:SetBackdropBorderColor(1, 1, 1, 0.4);
	elseif Backdrop=="BG2" then
		frame.BG = frame:CreateTexture(nil, "BACKGROUND");
		frame.BG:SetTexture("interface/framegeneral/ui-background-rock.blp");
		frame.BG:SetPoint("TOPLEFT", frame, "TOPLEFT",2, -23);
		frame.BG:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",-3, 3);
		frame.biaotiBG = frame:CreateTexture(nil, "BACKGROUND");
		frame.biaotiBG:SetTexture(374157);
		frame.biaotiBG:SetTexCoord(0.00,0.29,0.00,0.42,3.70,0.29,3.70,0.42);
		frame.biaotiBG:SetPoint("TOPLEFT", frame, "TOPLEFT",2, -2);
		frame.biaotiBG:SetPoint("TOPRIGHT", frame, "TOPRIGHT",-24, -1);
		frame.biaotiBG:SetHeight(22);

		frame.TOPLEFT = frame:CreateTexture(nil, "BORDER");
		frame.TOPLEFT:SetTexture(374156);
		frame.TOPLEFT:SetPoint("TOPLEFT", frame, "TOPLEFT",-6, 1);
		frame.TOPLEFT:SetTexCoord(0.6328125,0.28125,0.6328125,0.53125,0.8828125,0.28125,0.8828125,0.53125);
		frame.TOPLEFT:SetSize(33,34);
		frame.TOPRIGHT = frame:CreateTexture(nil, "BORDER");
		frame.TOPRIGHT:SetTexture(374156);
		frame.TOPRIGHT:SetPoint("TOPRIGHT", frame, "TOPRIGHT",0, 1);
		frame.TOPRIGHT:SetTexCoord(0.6328125,0.0078125,0.6328125,0.265625,0.890625,0.0078125,0.890625,0.265625);
		frame.TOPRIGHT:SetSize(33,35);
		frame.BOTTOMLEFT = frame:CreateTexture(nil, "BORDER");
		frame.BOTTOMLEFT:SetTexture(374156);
		frame.BOTTOMLEFT:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT",-6, -5);
		frame.BOTTOMLEFT:SetTexCoord(0.0078125,0.6328125,0.0078125,0.7421875,0.1171875,0.6328125,0.1171875,0.7421875);
		frame.BOTTOMLEFT:SetSize(14,14);
		frame.BOTTOMRIGHT = frame:CreateTexture(nil, "BORDER");
		frame.BOTTOMRIGHT:SetTexture(374156);
		frame.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",0, -5);
		frame.BOTTOMRIGHT:SetTexCoord(0.1328125,0.8984375,0.1328125,0.984375,0.21875,0.8984375,0.21875,0.984375);
		frame.BOTTOMRIGHT:SetSize(11,11);
		frame.TOP = frame:CreateTexture(nil, "BORDER");
		frame.TOP:SetTexture(374157);
		frame.TOP:SetTexCoord(0,0.4375,0,0.65625,1,0.4375,1,0.65625);
		frame.TOP:SetPoint("TOPLEFT", frame.TOPLEFT, "TOPRIGHT",0, 0)
		frame.TOP:SetPoint("TOPRIGHT", frame.TOPRIGHT, "TOPLEFT",0, 0);
		frame.TOP:SetHeight(29);
		frame.LEFT = frame:CreateTexture(nil, "BORDER");
		frame.LEFT:SetTexture(374153);
		frame.LEFT:SetTexCoord(0.36,0.00,0.36,2.29,0.61,0.00,0.61,2.29);
		frame.LEFT:SetPoint("TOPLEFT", frame.TOPLEFT, "BOTTOMLEFT",0, 0);
		frame.LEFT:SetPoint("BOTTOMLEFT", frame.BOTTOMLEFT, "TOPLEFT",0, 0);
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
		frame.Close = CreateFrame("Button",nil,frame, "UIPanelCloseButton");  
		frame.Close:SetSize(32,32);
		frame.Close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 4.8, 5);
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
	elseif Backdrop=="BG4" then--直角无边框
		frame:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 0, 
			edgeSize = 6,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
		frame:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
	elseif Backdrop=="BG5" then--加粗边框
		frame:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
	    	edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",tile = true,tileSize = 32,
	   		edgeSize = 32,insets = { left = 8, right = 8, top = 8, bottom = 8 }})
	elseif Backdrop=="BG6" then--白边暴雪底色
		frame:SetBackdrop({bgFile = "interface/raidframe/ui-raidframe-groupbg.blp", 
			edgeFile = "interface/glues/common/textpanel-border.blp", tile = false, tileSize = 0, 
			edgeSize = 20,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
	elseif Backdrop=="BG7" then--粗边框黑底
		frame:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp",
			edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",edgeSize = 16,
			insets = { left = 2, right = 2, top = 2, bottom = 2 }})
		frame:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
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
--角色装备界面
local function ADD_CharacterFrame(self,uiname,uiWidth)	
	self.Portrait_BG = self:CreateTexture(nil, "BORDER");
	self.Portrait_BG:SetTexture("interface/buttons/iconborder-glowring.blp");
	self.Portrait_BG:SetSize(57,57);
	self.Portrait_BG:SetPoint("TOPLEFT",self,"TOPLEFT",11,-7.8);
	self.Portrait_BG:SetDrawLayer("BORDER", -2)
	self.Portrait_BGmask = self:CreateMaskTexture()
	self.Portrait_BGmask:SetAllPoints(self.Portrait_BG)
	self.Portrait_BGmask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	self.Portrait_BG:AddMaskTexture(self.Portrait_BGmask)
	self.Portrait_TEX = self:CreateTexture(nil, "BORDER");
	self.Portrait_TEX:SetTexture(130899)
	self.Portrait_TEX:SetDrawLayer("BORDER", -1)
	self.Portrait_TEX:SetAllPoints(self.Portrait_BG)
	self.TOPLEFT = self:CreateTexture(nil, "BORDER");
	self.TOPLEFT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-l1.blp");
	self.TOPLEFT:SetPoint("TOPLEFT", self, "TOPLEFT",0, 0);
	self.TOPRIGHT = self:CreateTexture(nil, "BORDER");
	self.TOPRIGHT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-r1.blp");
	self.TOPRIGHT:SetPoint("TOPLEFT", self.TOPLEFT, "TOPRIGHT",0, 0);
	self.BOTTOMLEFT = self:CreateTexture(nil, "BORDER");
	self.BOTTOMLEFT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-bottomleft.blp");
	self.BOTTOMLEFT:SetPoint("TOPLEFT", self.TOPLEFT, "BOTTOMLEFT",0, 0);
	self.BOTTOMRIGHT = self:CreateTexture(nil, "BORDER");
	self.BOTTOMRIGHT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-bottomright.blp");
	self.BOTTOMRIGHT:SetPoint("TOPLEFT", self.BOTTOMLEFT, "TOPRIGHT",0, 0);

	self.biaoti = CreateFrame("Frame", nil, self)
	self.biaoti:SetPoint("TOPLEFT", self, "TOPLEFT",72, -14);
	self.biaoti:SetPoint("TOPRIGHT", self, "TOPRIGHT",-36, -1);
	self.biaoti:SetHeight(20);
	self.biaoti:EnableMouse(true)
	self.biaoti:RegisterForDrag("LeftButton")
	self.biaoti:SetScript("OnDragStart",function()
	    self:StartMoving();
	    self:SetUserPlaced(false)
	end)
	self.biaoti:SetScript("OnDragStop",function()
	    self:StopMovingOrSizing()
	    self:SetUserPlaced(false)
	end)
	self.biaoti.t = self:CreateFontString();
	self.biaoti.t:SetPoint("CENTER", self.biaoti, "CENTER", 2, -1);
	self.biaoti.t:SetFontObject(GameFontNormal);
	self.biaoti.t:SetTextColor(1, 1, 1, 1);

	self.biaoti.t1 = self:CreateFontString();
	self.biaoti.t1:SetPoint("CENTER", self.biaoti, "CENTER", 2, -30);
	self.biaoti.t1:SetFontObject(GameFontNormal);

	self.Close = CreateFrame("Button",nil,self, "UIPanelCloseButton");
	if tocversion<100000 then
		self.Close:SetSize(32,32);
		self.Close:SetPoint("TOPRIGHT",self,"TOPRIGHT",-3.2,-8.6);
	else
		self.Close:SetSize(24,24);
		self.Close:SetPoint("TOPRIGHT",self,"TOPRIGHT",-8,-14);
	end
	local zhuangbeishunxuID = {1,2,3,15,5,4,19,9,10,6,7,8,11,12,13,14,16,17,18}
	for i=1,#zhuangbeishunxuID do
		self.item = CreateFrame("Button", uiname.."_wupin_item_"..zhuangbeishunxuID[i], self, "SecureActionButtonTemplate");
		self.item:SetHighlightTexture(130718);
		self.item:SetSize(uiWidth*0.105,uiWidth*0.105);
		if i<17 then
			if i==1 then
				self.item:SetPoint("TOPLEFT",self,"TOPLEFT",20,-74);
			elseif i==9 then
				self.item:SetPoint("TOPLEFT",self,"TOPLEFT",305,-74);
			else
				self.item:SetPoint("TOP", _G[uiname.."_wupin_item_"..(zhuangbeishunxuID[i-1])], "BOTTOM", 0, -3);
			end
		else
			if i==17 then
				self.item:SetPoint("TOPLEFT",self,"TOPLEFT",121,-385);
			else
				self.item:SetPoint("LEFT", _G[uiname.."_wupin_item_"..(zhuangbeishunxuID[i-1])], "RIGHT", 4, 0);
			end
		end
		self.item.LV = self.item:CreateFontString();
		self.item.LV:SetPoint("TOPRIGHT", self.item, "TOPRIGHT", 0,-1);
		self.item.LV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	end
	local zhuangbeizhanshiID = {1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18}
	local buweiName = {HEADSLOT,NECKSLOT,SHOULDERSLOT,CHESTSLOT,WAISTSLOT,LEGSSLOT,FEETSLOT,WRISTSLOT,HANDSSLOT,FINGER0SLOT,FINGER1SLOT,TRINKET0SLOT,TRINKET1SLOT,BACKSLOT,MAINHANDSLOT,SECONDARYHANDSLOT,RANGEDSLOT}
	for i=1,#zhuangbeizhanshiID do
		local zbBuwei = CreateFrame("Frame", uiname.."_zbBuwei_"..zhuangbeizhanshiID[i], self,"BackdropTemplate");
		zbBuwei:SetSize(40,17);
		if i==1 then
			zbBuwei:SetPoint("TOPLEFT",self,"TOPLEFT",60,-80);
		else
			zbBuwei:SetPoint("TOPLEFT",_G[uiname.."_zbBuwei_"..(zhuangbeizhanshiID[i-1])],"BOTTOMLEFT",0,0);
		end
		zbBuwei.itembuwei = zbBuwei:CreateFontString();
		zbBuwei.itembuwei:SetPoint("RIGHT",zbBuwei,"RIGHT",0,0);
		zbBuwei.itembuwei:SetFontObject(GameFontNormal);
		zbBuwei.itembuwei:SetText(buweiName[i])
		zbBuwei.itemlink = zbBuwei:CreateFontString();
		zbBuwei.itemlink:SetPoint("LEFT",zbBuwei.itembuwei,"RIGHT",0,0);
		zbBuwei.itemlink:SetFontObject(GameFontNormal);
	end
end
addonTable.ADD_CharacterFrame=ADD_CharacterFrame
local function ADD_BagBankBGtex(self,texname)
	self.Bg = self:CreateTexture(texname.."Bg", "BACKGROUND");
	self.Bg:SetTexture("interface/framegeneral/ui-background-rock.blp");
	self.Bg:SetPoint("TOPLEFT", self, "TOPLEFT",14, -13);
	self.Bg:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -3, 5);
	self.Bg:SetDrawLayer("BACKGROUND", -1)
	self.topbg = self:CreateTexture(texname.."topbg", "BACKGROUND");
	self.topbg:SetTexture(374157);
	self.topbg:SetPoint("TOPLEFT", self, "TOPLEFT",68, -13);
	self.topbg:SetPoint("TOPRIGHT", self, "TOPRIGHT",-24, -13);
	self.topbg:SetTexCoord(0,0.2890625,0,0.421875,1.359809994697571,0.2890625,1.359809994697571,0.421875);
	self.topbg:SetHeight(20);
	self.TOPLEFT = self:CreateTexture(texname.."TOPLEFT", "BORDER");
	self.TOPLEFT:SetTexture("interface/framegeneral/ui-frame.blp");
	self.TOPLEFT:SetPoint("TOPLEFT", self, "TOPLEFT",0, 0);
	self.TOPLEFT:SetTexCoord(0.0078125,0.0078125,0.0078125,0.6171875,0.6171875,0.0078125,0.6171875,0.6171875);
	self.TOPLEFT:SetSize(78,78);
	self.TOPRIGHT = self:CreateTexture(texname.."TOPRIGHT", "BORDER");
	self.TOPRIGHT:SetTexture(374156);
	self.TOPRIGHT:SetPoint("TOPRIGHT", self, "TOPRIGHT",0, -10);
	self.TOPRIGHT:SetTexCoord(0.6328125,0.0078125,0.6328125,0.265625,0.890625,0.0078125,0.890625,0.265625);
	self.TOPRIGHT:SetSize(33,33);
	self.TOP = self:CreateTexture(texname.."TOP", "BORDER");
	self.TOP:SetTexture(374157);
	self.TOP:SetPoint("TOPLEFT", self.TOPLEFT, "TOPRIGHT",0, -10);
	self.TOP:SetPoint("BOTTOMRIGHT", self.TOPRIGHT, "BOTTOMLEFT", 0, 4);
	self.TOP:SetTexCoord(0,0.4375,0,0.65625,1.08637285232544,0.4375,1.08637285232544,0.65625);
	self.BOTTOMLEFT = self:CreateTexture(texname.."BOTTOMLEFT", "BORDER");
	self.BOTTOMLEFT:SetTexture(374156);
	self.BOTTOMLEFT:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT",8, 0);
	self.BOTTOMLEFT:SetTexCoord(0.0078125,0.6328125,0.0078125,0.7421875,0.1171875,0.6328125,0.1171875,0.7421875);
	self.BOTTOMLEFT:SetSize(14,14);

	self.BOTTOMRIGHT = self:CreateTexture(texname.."BOTTOMRIGHT", "BORDER");
	self.BOTTOMRIGHT:SetTexture(374156);
	self.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT",0, 0);
	self.BOTTOMRIGHT:SetTexCoord(0.1328125,0.8984375,0.1328125,0.984375,0.21875,0.8984375,0.21875,0.984375);
	self.BOTTOMRIGHT:SetSize(11,11);

	self.LEFT = self:CreateTexture(texname.."LEFT", "BORDER");
	self.LEFT:SetTexture(374153);
	self.LEFT:SetTexCoord(0.359375,0,0.359375,1.42187488079071,0.609375,0,0.609375,1.42187488079071);
	self.LEFT:SetPoint("TOPLEFT", self.TOPLEFT, "BOTTOMLEFT",8, 0);
	self.LEFT:SetPoint("BOTTOMLEFT", self.BOTTOMLEFT, "TOPLEFT", 0, 0);
	self.LEFT:SetWidth(16);

	self.RIGHT = self:CreateTexture(texname.."RIGHT", "BORDER");
	self.RIGHT:SetTexture(374153);
	self.RIGHT:SetTexCoord(0.171875,0,0.171875,1.5703125,0.328125,0,0.328125,1.5703125);
	self.RIGHT:SetPoint("TOPRIGHT", self.TOPRIGHT, "BOTTOMRIGHT",0.8, 0);
	self.RIGHT:SetPoint("BOTTOMRIGHT", self.BOTTOMRIGHT, "TOPRIGHT", 0, 0);
	self.RIGHT:SetWidth(10);

	self.BOTTOM = self:CreateTexture(texname.."BOTTOM", "BORDER");
	self.BOTTOM:SetTexture(374157);
	self.BOTTOM:SetTexCoord(0,0.203125,0,0.2734375,1.425781607627869,0.203125,1.425781607627869,0.2734375);
	self.BOTTOM:SetPoint("BOTTOMLEFT", self.BOTTOMLEFT, "BOTTOMRIGHT",0, -0);
	self.BOTTOM:SetPoint("BOTTOMRIGHT", self.BOTTOMRIGHT, "BOTTOMLEFT", 0, 0);
	self.BOTTOM:SetHeight(9);
	local Mkuandu,Mgaodu = 8,22
	self.MoneyFrame_R = self:CreateTexture(texname.."MoneyFrame_R", "BORDER");
	self.MoneyFrame_R:SetTexture("interface/common/moneyframe.blp");
	self.MoneyFrame_R:SetTexCoord(0,0.05,0,0.31);
	self.MoneyFrame_R:SetSize(Mkuandu,Mgaodu);
	self.MoneyFrame_R:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -8, 7)
	self.MoneyFrame_l = self:CreateTexture(texname.."MoneyFrame_L", "BORDER");
	self.MoneyFrame_l:SetTexture("interface/common/moneyframe.blp");
	self.MoneyFrame_l:SetTexCoord(0.95,1,0,0.31);
	self.MoneyFrame_l:SetSize(Mkuandu,Mgaodu);
	self.MoneyFrame_l:SetPoint("RIGHT", self.MoneyFrame_R, "LEFT", -160, 0)
	self.MoneyFrame_C = self:CreateTexture(texname.."MoneyFrame_C", "BORDER");
	self.MoneyFrame_C:SetTexture("interface/common/moneyframe.blp");
	self.MoneyFrame_C:SetTexCoord(0.1,0.9,0.314,0.621);
	self.MoneyFrame_C:SetPoint("TOPLEFT", self.MoneyFrame_l, "TOPRIGHT", 0, 0)
	self.MoneyFrame_C:SetPoint("BOTTOMRIGHT", self.MoneyFrame_R, "BOTTOMLEFT", 0, 0)

	self:SetMovable(true)
	self:SetUserPlaced(false)
	self:SetClampedToScreen(true)
	self.biaoti = CreateFrame("Frame", nil, self)
	self.biaoti:SetPoint("TOPLEFT", self, "TOPLEFT",68, -13);
	self.biaoti:SetPoint("TOPRIGHT", self, "TOPRIGHT",-24, -13);
	self.biaoti:SetHeight(20);
	self.biaoti:EnableMouse(true)
	self.biaoti:RegisterForDrag("LeftButton")
	self.biaoti:SetScript("OnDragStart",function()
	    self:StartMoving();
	    self:SetUserPlaced(false)
	end)
	self.biaoti:SetScript("OnDragStop",function()
	    self:StopMovingOrSizing()
	    self:SetUserPlaced(false)
	end)
end
addonTable.ADD_BagBankBGtex=ADD_BagBankBGtex
--创建按钮
local function ADD_Button(GnName,UIName,fuFrame,Width,Height,Point,fuPoint,rPoint,PointX,PointY)
	local frame = CreateFrame("Button", UIName, fuFrame, "UIPanelButtonTemplate");  
	frame:SetSize(Width,Height);
	frame:SetPoint(Point,fuPoint,rPoint,PointX,PointY);
	frame:SetText(GnName);
	return frame
end
addonTable.ADD_Button=ADD_Button
local function ADD_ButtonMima(GnName,UIName,fuFrame,Width,Height,Point,fuPoint,rPoint,PointX,PointY,id)
	local frame = CreateFrame("Button", UIName, fuFrame, "UIPanelSquareButton",id);  
	frame:SetSize(Width,Height);
	frame:SetPoint(Point,fuPoint,rPoint,PointX,PointY);
	return frame
end
addonTable.ADD_ButtonMima=ADD_ButtonMima
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
--local ADD_Checkbutton=addonTable.ADD_Checkbutton
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