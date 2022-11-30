local _, addonTable = ...;
local fuFrame=List_R_F_1_5
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--================================================
fuFrame.juesexinxikz1 = fuFrame:CreateLine()
fuFrame.juesexinxikz1:SetColorTexture(1,1,1,0.4)
fuFrame.juesexinxikz1:SetThickness(1);
fuFrame.juesexinxikz1:SetStartPoint("TOPLEFT",3,-290)
fuFrame.juesexinxikz1:SetEndPoint("TOPRIGHT",-330,-290)
fuFrame.juesexinxikz2 = fuFrame:CreateLine()
fuFrame.juesexinxikz2:SetColorTexture(1,1,1,0.4)
fuFrame.juesexinxikz2:SetThickness(1);
fuFrame.juesexinxikz2:SetStartPoint("TOPLEFT",330,-290)
fuFrame.juesexinxikz2:SetEndPoint("TOPRIGHT",-2,-290)
fuFrame.juesexinxikz3 = fuFrame:CreateFontString();
fuFrame.juesexinxikz3:SetPoint("LEFT", fuFrame.juesexinxikz1, "RIGHT", 0, 0);
fuFrame.juesexinxikz3:SetPoint("RIGHT", fuFrame.juesexinxikz2, "LEFT", 0, 0);
fuFrame.juesexinxikz3:SetFontObject(GameFontNormal);
fuFrame.juesexinxikz3:SetText("角色面板");
local kuandu,gaoduh,pianyiX,pianyiY = 160,420,-31, -15
local function Frame_Mingzhong_Open()
	if PaperDollFrame.MingZhong then return end
	--命中说明-物理
	PaperDollFrame.MingZhong = CreateFrame("Button",nil,PaperDollFrame, "UIPanelInfoButton");  
	PaperDollFrame.MingZhong:SetSize(16,16);
	PaperDollFrame.MingZhong:SetPoint("RIGHT", PaperDollFrame, "RIGHT", -90, 0);
	PaperDollFrame.MingZhong:SetFrameLevel(6)
	PaperDollFrame.MingZhong.texture:SetPoint("BOTTOMRIGHT", PaperDollFrame.MingZhong, "BOTTOMRIGHT", 0, 0);
	PaperDollFrame.MingZhong.Wl = CreateFrame("Frame", nil, PaperDollFrame.MingZhong,"BackdropTemplate");
	PaperDollFrame.MingZhong.Wl:SetBackdrop({
		bgFile = "interface/characterframe/ui-party-background.blp", tile = true, tileSize = 0,
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8, 
	});
	PaperDollFrame.MingZhong.Wl:SetBackdropColor(0, 0, 0, 1);
	PaperDollFrame.MingZhong.Wl:SetBackdropBorderColor(0, 0, 0, 0.8);
	PaperDollFrame.MingZhong.Wl:SetSize(200,gaoduh)
	PaperDollFrame.MingZhong.Wl:SetPoint("TOPLEFT", PaperDollFrame, "TOPRIGHT",pianyiX,pianyiY);
	PaperDollFrame.MingZhong.Wl:Hide()

	PaperDollFrame.MingZhong.Wl.title1 = PaperDollFrame.MingZhong.Wl:CreateFontString();
	PaperDollFrame.MingZhong.Wl.title1:SetPoint("TOPLEFT", PaperDollFrame.MingZhong.Wl, "TOPLEFT", 4, -6);
	PaperDollFrame.MingZhong.Wl.title1:SetFontObject(GameFontNormal);
	PaperDollFrame.MingZhong.Wl.title1:SetText("关于物理命中")
	PaperDollFrame.MingZhong.Wl.title2 = PaperDollFrame.MingZhong.Wl:CreateFontString();
	PaperDollFrame.MingZhong.Wl.title2:SetPoint("TOPLEFT", PaperDollFrame.MingZhong.Wl.title1, "BOTTOMLEFT", 0, 0);
	PaperDollFrame.MingZhong.Wl.title2:SetFont(ChatFontNormal:GetFont(), 13)
	PaperDollFrame.MingZhong.Wl.title2:SetWidth(192);
	PaperDollFrame.MingZhong.Wl.title2:SetJustifyH("LEFT");
	if tocversion<20000 then
		PaperDollFrame.MingZhong.Wl.title2:SetText(
		"同级:基础命中率95%(5%)\n高1级:基础命中率94.5%(6%)\n高2级:基础命中率94%(6%)\n高3级:基础命中率92%(8%)\n"..
		"双持惩罚:基础命中率-19%\n\n"..
		"|cffFFD700例外情况：|r\n"..
		"|cffFF8C00当<目标的防御等级>减去<玩家武器技能>大于10,装备或天赋上所提供的命中会被无视1%。这将导致在对抗骷髅BOSS时需要额外1%的命中，即需要9%的命中而不是8%.|r\n"..
		"武器技能和防御等级计算公式当前级别*5；60级角色对抗骷髅BOSS情况:5*63-5*60>10\n\n"..
		"|cffFFD700种族武器专精：|r\n"..
		"人类的剑/双手剑/锤/双手锤与兽人的斧/双手斧武器技能提高5点，会产生效果："..
		"会使武器技能和BOSS防御等级差值不大于10，不需要额外1%命中，再加上5点武器技能本身提供的1%命中，此时你将只需要6%命中即可。但武器技能的作用还不止于此，也会大量降低你的普攻偏斜。")
	elseif tocversion<30000 then
		PaperDollFrame.MingZhong.Wl.title2:SetText(
		"同级:基础命中率95%(5%)\n高1级:基础命中率93.8%(7%)\n高2级:基础命中率92.8%(8%)\n高3级:基础命中率91.4%(9%)\n"..
		"双持惩罚:基础命中率减去19%\n"..
		"|cffFFD700命中等级：|r\n"..
		"|cffFF8C00TBC1%命中≈15.8命中等级。|r\n"..
		"9%命中：9*15.8≈143命中等级\n"..
		"双持职业\n需要28*15.8≈443点命中等级\n"..
		"|cffFFD700职业差异：|r\n"..
		"猎人，武器战以及猫德这些DPS职业都只需要9%的命中，就可以保证技能和平A全部命中\n"..
		"盗贼/狂暴战/增强萨,天赋自带5%/5%/6%的命中，双持的时候需要23%/23%/22%的命中\n"..
		"不过狂暴战/增强萨达到9%命中之后，暴击收益更高，只需堆到9%保证技能命中后尽量堆暴击，盗贼因为天赋回能尽量堆满命中\n"..
		"坦克:达到9%技能全命中后优先考虑生存属性")
	elseif tocversion<40000 then
		PaperDollFrame.MingZhong.Wl.title2:SetText(
		"同级:基础命中率95%(5%)\n高1级:基础命中率93.8%(7%)\n高2级:基础命中率92.8%(8%)\n高3级:基础命中率91.4%(9%)\n"..
		"双持惩罚:基础命中率减去19%\n"..
		"|cffFFD700命中等级：|r\n"..
		"|cffFF8C00WLK1%命中≈32.8命中等级。|r\n"..
		"9%命中：9*32.8≈296命中等级\n"..
		"双持职业\n需要28*32.8≈919点命中等级\n"..
		"|cffFFD700职业差异：|r\n"..
		"猎人，武器战以及猫德这些DPS职业都只需要9%的命中，就可以保证技能和平A全部命中\n"..
		"盗贼/狂暴战/增强萨,天赋自带5%/5%/6%的命中，双持的时候需要23%/23%/22%的命中\n"..
		"不过狂暴战/增强萨达到9%命中之后，暴击收益更高，只需堆到9%保证技能命中后尽量堆暴击，盗贼因为天赋回能尽量堆满命中\n"..
		"坦克:达到9%技能全命中后优先考虑生存属性")
	end
	PaperDollFrame.MingZhong.Wl.title3 = PaperDollFrame.MingZhong.Wl:CreateFontString();
	PaperDollFrame.MingZhong.Wl.title3:SetPoint("TOPLEFT", PaperDollFrame.MingZhong.Wl.title2, "BOTTOMLEFT", 0, -6);
	PaperDollFrame.MingZhong.Wl.title3:SetFont(ChatFontNormal:GetFont(), 13)
	PaperDollFrame.MingZhong.Wl.title3:SetText("|cff00ff00骷髅BOSS默认高玩家3级|r")

	--命中说明-法术
	PaperDollFrame.MingZhong.Fs = CreateFrame("Frame", nil,PaperDollFrame.MingZhong,"BackdropTemplate");
	PaperDollFrame.MingZhong.Fs:SetBackdrop({
		bgFile = "interface/characterframe/ui-party-background.blp", tile = true, tileSize = 0,
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8, 
	});
	PaperDollFrame.MingZhong.Fs:SetBackdropColor(0, 0, 0, 1);
	PaperDollFrame.MingZhong.Fs:SetBackdropBorderColor(0, 0, 0, 0.8);
	PaperDollFrame.MingZhong.Fs:SetSize(170,gaoduh);
	PaperDollFrame.MingZhong.Fs:SetPoint("TOPLEFT", PaperDollFrame.MingZhong.Wl, "TOPRIGHT", 2,0);
	PaperDollFrame.MingZhong.Fs:Hide()

	PaperDollFrame.MingZhong.Fs.title1 = PaperDollFrame.MingZhong.Fs:CreateFontString();
	PaperDollFrame.MingZhong.Fs.title1:SetPoint("TOPLEFT", PaperDollFrame.MingZhong.Fs, "TOPLEFT", 6, -6);
	PaperDollFrame.MingZhong.Fs.title1:SetFontObject(GameFontNormal);
	PaperDollFrame.MingZhong.Fs.title1:SetText("关于法系命中（抵抗）")
	PaperDollFrame.MingZhong.Fs.title10 = PaperDollFrame.MingZhong.Fs:CreateFontString();
	PaperDollFrame.MingZhong.Fs.title10:SetPoint("TOPLEFT", PaperDollFrame.MingZhong.Fs.title1, "BOTTOMLEFT", 0, -4);
	PaperDollFrame.MingZhong.Fs.title10:SetFont(ChatFontNormal:GetFont(), 13)
	PaperDollFrame.MingZhong.Fs.title10:SetJustifyH("LEFT");
	if tocversion<20000 then
		PaperDollFrame.MingZhong.Fs.title10:SetText(
		"|cffFF8C00注意:法术命中上限是99%|r\n同级:基础命中率96%(3%)\n高1级:基础命中率95%(4%)\n高2级:基础命中率94%(5%)\n"..
		"高3级:基础命中率83%(16%)\n")
	elseif tocversion<30000 then
		PaperDollFrame.MingZhong.Fs.title10:SetText(
		"|cffFF8C00注意:法术命中上限是99%|r\n同级:基础命中率96%(3%)\n高1级:基础命中率95%(4%)\n高2级:基础命中率94%(5%)\n"..
		"高3级:基础命中率83%(16%)\n"..
		"TBC法系命中率\n1%≈12.6法系命中等级")
	elseif tocversion<40000 then
		PaperDollFrame.MingZhong.Fs.title10:SetText(
		"|cffFF8C00注意:法术命中上限是99%|r\n同级:基础命中率96%(3%)\n高1级:基础命中率95%(4%)\n高2级:基础命中率94%(5%)\n"..
		"高3级:基础命中率83%(16%)\n"..
		"WLK法系命中率\n1%≈26.2法系命中等级")
	end

	PaperDollFrame.MingZhong.Fs.title3 = PaperDollFrame.MingZhong.Fs:CreateFontString();
	PaperDollFrame.MingZhong.Fs.title3:SetPoint("TOPLEFT", PaperDollFrame.MingZhong.Fs.title10, "BOTTOMLEFT", 0, -10);
	PaperDollFrame.MingZhong.Fs.title3:SetFont(ChatFontNormal:GetFont(), 13)
	PaperDollFrame.MingZhong.Fs.title3:SetText("|cff00ff00骷髅BOSS默认高玩家3级|r")

	PaperDollFrame.MingZhong:SetScript("OnEnter", function() PaperDollFrame.MingZhong.Wl:Show() PaperDollFrame.MingZhong.Fs:Show() end );
	PaperDollFrame.MingZhong:SetScript("OnLeave", function() PaperDollFrame.MingZhong.Wl:Hide() PaperDollFrame.MingZhong.Fs:Hide() end );

	--修理费用
	PaperDollFrame.xiuli = CreateFrame("Frame",nil,PaperDollFrame);  
	PaperDollFrame.xiuli:SetSize(110,20);
	PaperDollFrame.xiuli:SetPoint("LEFT", PaperDollFrame, "LEFT", 66, 0);
	PaperDollFrame.xiuli:SetFrameLevel(6)
	PaperDollFrame.xiuli.ICON = PaperDollFrame:CreateTexture(nil, "OVERLAY");
	PaperDollFrame.xiuli.ICON:SetTexture("interface/minimap/tracking/repair.blp");
	PaperDollFrame.xiuli.ICON:SetSize(20,20);
	PaperDollFrame.xiuli.ICON:SetPoint("LEFT", PaperDollFrame.xiuli, "LEFT", 0, 0);
	PaperDollFrame.xiuli.G = PaperDollFrame:CreateFontString();
	PaperDollFrame.xiuli.G:SetPoint("LEFT", PaperDollFrame.xiuli.ICON, "RIGHT", 0, 0);
	PaperDollFrame.xiuli.G:SetFont(ChatFontNormal:GetFont(), 13);
	local PIGtooltip = CreateFrame("GameTooltip")
	PIGtooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
	local naijiubuweiID = {1,3,5,6,7,8,9,10,16,17,18}
	PaperDollFrame:HookScript("OnShow",function (self,event)
		PaperDollFrame.repaircost=0
		for id=1,#naijiubuweiID do
			local hasItem,_,cost = PIGtooltip:SetInventoryItem("player", naijiubuweiID[id])
			PaperDollFrame.repaircost=PaperDollFrame.repaircost+cost
		end
		PaperDollFrame.xiuli.G:SetText(GetCoinTextureString(PaperDollFrame.repaircost))
	end)
end
------
fuFrame.Juese = ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",20,-20,"显示修理费/命中说明","角色面板显示修理费用/命中说明")
fuFrame.Juese:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["FramePlus"]["CharacterFrame_Juese"]="ON";
		Frame_Mingzhong_Open()
	else
		PIG["FramePlus"]["CharacterFrame_Juese"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
-------耐久/装等/染色-----------------------
local zhuangbeixilieID={
	{0,"Ammo",false},{1,"Head",true},{2,"Neck",false},{3,"Shoulder",true},{4,"Shirt",false},{5,"Chest",true},
	{6,"Waist",true},{7,"Legs",true},{8,"Feet",true},{9,"Wrist",true},{10,"Hands",true},{11,"Finger0",false},
	{12,"Finger1",false},{13,"Trinket0",false},{14,"Trinket1",false},{15,"Back",false},{16,"MainHand",true},
	{17,"SecondaryHand",true},{18,"Ranged",true},{19,"Tabard",false},
}
local pingzhiColor = addonTable.QualityColor
local XWidth, XHeight =CharacterHeadSlot:GetWidth(),CharacterHeadSlot:GetHeight()
local function Update_LV(framef,unit,ZBID)
	if not framef then return end
	framef.ZLV:SetText("");
	local itemLink = GetInventoryItemLink(unit, ZBID)
	if itemLink then
		local quality = GetInventoryItemQuality(unit, ZBID)
		if quality then
			local effectiveILvl = GetDetailedItemLevelInfo(itemLink)
			framef.ZLV:SetText(effectiveILvl);
			framef.ZLV:SetTextColor(pingzhiColor[quality][1],pingzhiColor[quality][2],pingzhiColor[quality][3], 1);
		end
	end
end
local function Update_ranse(framef,unit,ZBID)
	if not framef then return end
	framef.ranse:Hide()
	local quality = GetInventoryItemQuality(unit, ZBID)
    if quality and quality>1 then
        local r, g, b = GetItemQualityColor(quality);
        framef.ranse:SetVertexColor(r, g, b);
	    if zhuangbeixilieID[inv]==0 then
		   	if not HasWandEquipped() then
				framef.ranse:Show()
			end
		else
			framef.ranse:Show()
		end
	end
end
--观察对象
local function Inspect_UpdateV()
	for inv = 2, #zhuangbeixilieID do
		if zhuangbeixilieID[inv][1]~=0 and zhuangbeixilieID[inv][1]~=4 and zhuangbeixilieID[inv][1]~=19 then
			local framef=_G["Inspect"..zhuangbeixilieID[inv][2].."Slot"]
			if PIG["FramePlus"]["CharacterFrame_LV"]=="ON" then
				Update_LV(framef,"target", zhuangbeixilieID[inv][1])
			end
			if PIG["FramePlus"]["CharacterFrame_ranse"]=="ON" then
				Update_ranse(framef,"target", zhuangbeixilieID[inv][1])
			end
		end
	end
end
local function ADD_Inspect()
	if IsAddOnLoaded("Blizzard_InspectUI") then
		if PIG["FramePlus"]["CharacterFrame_LV"]=="ON" then		
			for inv = 2, #zhuangbeixilieID do
				local framef=_G["Inspect"..zhuangbeixilieID[inv][2].."Slot"]
				if not framef.ZLV then
					framef.ZLV = framef:CreateFontString();
					framef.ZLV:SetPoint("TOPRIGHT", framef, "TOPRIGHT", -1, -1);
					framef.ZLV:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
					framef.ZLV:SetDrawLayer("OVERLAY", 7)
				end
			end
		end
		if PIG["FramePlus"]["CharacterFrame_ranse"]=="ON" then
			for inv = 2, #zhuangbeixilieID do
				local framef=_G["Inspect"..zhuangbeixilieID[inv][2].."Slot"]
				if not framef.ranse then
				    framef.ranse = framef:CreateTexture(nil, "OVERLAY");
				    framef.ranse:SetTexture("Interface/Buttons/UI-ActionButton-Border");
				    framef.ranse:SetBlendMode("ADD");
				    framef.ranse:SetSize(XWidth*1.8, XHeight*1.8);
				    framef.ranse:SetPoint("CENTER", framef, "CENTER", 0, 0);
				    framef.ranse:Hide()
				end
			end
		end
	else	
		PaperDollFrame:RegisterEvent("ADDON_LOADED")
	end
	PaperDollFrame:RegisterEvent("INSPECT_READY")
end 
---
local function Update_dataV()
	if PIG["FramePlus"]["CharacterFrame_naijiu"]=="ON" then
		for inv = 1, #zhuangbeixilieID do
			if zhuangbeixilieID[inv][3] then
				local Frameu=_G["Character"..zhuangbeixilieID[inv][2].."Slot"].naijiuV
				Frameu:SetText("");
				local current, maximum = GetInventoryItemDurability(zhuangbeixilieID[inv][1]);
				if maximum then
					local naijiubaifenbi=floor(current/maximum*100);
					Frameu:SetText(naijiubaifenbi.."%");
					if naijiubaifenbi>79 then
						Frameu:SetTextColor(0,1,0, 1);
					elseif  naijiubaifenbi>59 then
						Frameu:SetTextColor(1,215/255,0, 1);
					elseif  naijiubaifenbi>39 then
						Frameu:SetTextColor(1,140/255,0, 1);
					elseif  naijiubaifenbi>19 then
						Frameu:SetTextColor(1,69/255,0, 1);
					else
						Frameu:SetTextColor(1,0,0, 1);
					end
				end
			end
		end
	end
	if PIG["FramePlus"]["CharacterFrame_LV"]=="ON" then
		for inv = 1, #zhuangbeixilieID do
			if zhuangbeixilieID[inv][1]~=0 and zhuangbeixilieID[inv][1]~=4 and zhuangbeixilieID[inv][1]~=19 then
				local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
				Update_LV(framef,"player", zhuangbeixilieID[inv][1])
			end
		end
	end
	if PIG["FramePlus"]["CharacterFrame_ranse"]=="ON" then
		for inv = 1, #zhuangbeixilieID do
			local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
			Update_ranse(framef,"player", zhuangbeixilieID[inv][1])
		end
	end

end
local function ADD_gongnengframe()
	if PIG["FramePlus"]["CharacterFrame_naijiu"]=="ON" then
		for inv = 1, #zhuangbeixilieID do
			local Frameu=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
			if not Frameu.naijiuV then
				Frameu.naijiuV = Frameu:CreateFontString();
				Frameu.naijiuV:SetPoint("BOTTOMLEFT", Frameu, "BOTTOMLEFT", 1, 1);
				Frameu.naijiuV:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
				Frameu.naijiuV:SetDrawLayer("OVERLAY", 7)
			end
		end
	end
	if PIG["FramePlus"]["CharacterFrame_LV"]=="ON" then
		for inv = 1, #zhuangbeixilieID do
			local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
			if not framef.ZLV then
				framef.ZLV = framef:CreateFontString();
				framef.ZLV:SetPoint("TOPRIGHT", framef, "TOPRIGHT", -1, -1);
				framef.ZLV:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
				framef.ZLV:SetDrawLayer("OVERLAY", 7)
			end
		end
	end
	if PIG["FramePlus"]["CharacterFrame_ranse"]=="ON" then
		for inv = 1, #zhuangbeixilieID do
			local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
			if not framef.ranse then
			    framef.ranse = framef:CreateTexture(nil, "OVERLAY");
			    framef.ranse:SetTexture("Interface/Buttons/UI-ActionButton-Border");
			    framef.ranse:SetBlendMode("ADD");
			    if zhuangbeixilieID[inv][1]==0 then
			    	framef.ranse:SetSize(XWidth*1.4, XHeight*1.4);
			    else
			    	framef.ranse:SetSize(XWidth*1.8, XHeight*1.8);
			    end
			    framef.ranse:SetPoint("CENTER", framef, "CENTER", 0, 0);
			    framef.ranse:Hide()
			end
		end
	end
	PaperDollFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	PaperDollFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
	if PIG["FramePlus"]["CharacterFrame_LV"]=="ON" or PIG["FramePlus"]["CharacterFrame_ranse"]=="ON" then
		ADD_Inspect() 
	end
	PaperDollFrame:HookScript("OnShow",function ()
		Update_dataV()
	end)
	PaperDollFrame:HookScript("OnEvent", function(self,event,arg1)
		if event=="ADDON_LOADED" and arg1=="Blizzard_InspectUI" then
			if PIG["FramePlus"]["CharacterFrame_LV"]=="ON" or PIG["FramePlus"]["CharacterFrame_ranse"]=="ON" then
				ADD_Inspect()  
			end
		end
		if event=="INSPECT_READY" then
			if PIG["FramePlus"]["CharacterFrame_LV"]=="ON" or PIG["FramePlus"]["CharacterFrame_ranse"]=="ON" then 
				C_Timer.After(0.4,Inspect_UpdateV)
			end
		end
		if event=="PLAYER_EQUIPMENT_CHANGED" or event=="UNIT_INVENTORY_CHANGED" then
			if PaperDollFrame:IsVisible() then
				Update_dataV()
			end
		end
	end);
end
fuFrame.naijiuzhi = ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",300,-20,"显示装备耐久","角色面板显示装备耐久剩余值")
fuFrame.naijiuzhi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["FramePlus"]["CharacterFrame_naijiu"]="ON";
		ADD_gongnengframe()
	else
		PIG["FramePlus"]["CharacterFrame_naijiu"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.zhuangbeiLV = ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",20,-60,"显示装等","显示装备等级，背包银行物品需要显示装等请在背包内设置")
fuFrame.zhuangbeiLV:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["FramePlus"]["CharacterFrame_LV"]="ON";
		ADD_gongnengframe()
	else
		PIG["FramePlus"]["CharacterFrame_LV"]="OFF";
		Pig_Options_RLtishi_UI:Show();
	end
end);
fuFrame.pinzhiranse = ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",300,-60,"根据品质染色边框","根据品质染色边框")
fuFrame.pinzhiranse:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["FramePlus"]["CharacterFrame_ranse"]="ON";
		ADD_gongnengframe()
	else
		PIG["FramePlus"]["CharacterFrame_ranse"]="OFF";
		Pig_Options_RLtishi_UI:Show();
	end
end);
-------------------
local zhuangbeizhanshiID = {1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18}
local buweiName = {HEADSLOT,NECKSLOT,SHOULDERSLOT,CHESTSLOT,WAISTSLOT,LEGSSLOT,FEETSLOT,WRISTSLOT,HANDSSLOT,FINGER0SLOT,FINGER1SLOT,TRINKET0SLOT,TRINKET1SLOT,BACKSLOT,MAINHANDSLOT,SECONDARYHANDSLOT,RANGEDSLOT}
local function add_zhuangbeList()
	if PaperDollFrame.ZBLsit then return end
	PaperDollFrame.ZBLsit = CreateFrame("Frame", nil, PaperDollFrame,"BackdropTemplate");
	PaperDollFrame.ZBLsit:SetBackdrop({
		bgFile = "interface/characterframe/ui-party-background.blp", tile = true, tileSize = 0,
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8, 
	});
	PaperDollFrame.ZBLsit:SetBackdropColor(0, 0, 0, 0.8);
	PaperDollFrame.ZBLsit:SetBackdropBorderColor(0, 0, 0, 0.8);
	PaperDollFrame.ZBLsit:SetSize(kuandu,gaoduh);
	PaperDollFrame.ZBLsit:SetPoint("TOPLEFT", PaperDollFrame, "TOPRIGHT",pianyiX,pianyiY);
	if PaperDollFrame.shuxing then
		PaperDollFrame.shuxing:SetPoint("TOPLEFT", PaperDollFrame.ZBLsit, "TOPRIGHT", 1, 0);
	end
	if GearManagerDialog then
		GearManagerDialog:SetFrameLevel(10)
	end
	-- 
	PaperDollFrame.ZBLsit.pingjunLV = PaperDollFrame.ZBLsit:CreateFontString();
	PaperDollFrame.ZBLsit.pingjunLV:SetPoint("TOPLEFT",PaperDollFrame.ZBLsit,"TOPLEFT",8,-8);
	PaperDollFrame.ZBLsit.pingjunLV:SetFont(GameFontNormal:GetFont(), 15)
	PaperDollFrame.ZBLsit.pingjunLV:SetTextColor(1,215/255,0, 0.9);
	PaperDollFrame.ZBLsit.pingjunLV:SetText("平均装等:")
	PaperDollFrame.ZBLsit.pingjunLV_V = PaperDollFrame.ZBLsit:CreateFontString();
	PaperDollFrame.ZBLsit.pingjunLV_V:SetPoint("LEFT",PaperDollFrame.ZBLsit.pingjunLV,"RIGHT",4,0);
	PaperDollFrame.ZBLsit.pingjunLV_V:SetFont(ChatFontNormal:GetFont(), 15)

	local function jisuanzongzhuangdeng(data)
		local zongjizhuangdengall = 0
		local zhuangbeishu=#data
		for i=1,zhuangbeishu do
			zongjizhuangdengall=zongjizhuangdengall+data[i]
		end
		return zongjizhuangdengall/zhuangbeishu
	end
	local function Update_zhuangbeiList(guancha)
		if guancha then
				local newmaxWWWW = kuandu
				local zhuangdenginfo = {}
				for i = 1, #zhuangbeizhanshiID do
					local itemLink=GetInventoryItemLink("target", zhuangbeizhanshiID[i])
					if itemLink then
						_G["CZBLsitInspect"..zhuangbeizhanshiID[i]].itemlink:SetText(itemLink)
						local effectiveILvl = GetDetailedItemLevelInfo(itemLink)
						table.insert(zhuangdenginfo,effectiveILvl)
						local width = _G["CZBLsitInspect"..zhuangbeizhanshiID[i]].itemlink:GetStringWidth()+44
						if width>newmaxWWWW then
							newmaxWWWW = width
						end	
					else
						_G["CZBLsitInspect"..zhuangbeizhanshiID[i]].itemlink:SetText("|cff555555无|r")
					end
				end
				local pingjunLvl = jisuanzongzhuangdeng(zhuangdenginfo)
				local pingjunLvl = floor(pingjunLvl*10+5)/10
				InspectPaperDollFrame.ZBLsit.pingjunLV_V:SetText(pingjunLvl)
				InspectPaperDollFrame.ZBLsit:SetWidth(newmaxWWWW)
		else
			if PaperDollFrame:IsVisible() then
				local newmaxWWWW = kuandu
				local zhuangdenginfo = {}
				for i = 1, #zhuangbeizhanshiID do
					local itemLink=GetInventoryItemLink("player", zhuangbeizhanshiID[i])
					if itemLink then
						_G["CZBLsit"..zhuangbeizhanshiID[i]].itemlink:SetText(itemLink)
						local effectiveILvl = GetDetailedItemLevelInfo(itemLink)
						table.insert(zhuangdenginfo,effectiveILvl)
						local width = _G["CZBLsit"..zhuangbeizhanshiID[i]].itemlink:GetStringWidth()+44
						if width>newmaxWWWW then
							newmaxWWWW = width
						end	
					else
						_G["CZBLsit"..zhuangbeizhanshiID[i]].itemlink:SetText("|cff555555无|r")
					end
				end
				local pingjunLvl = jisuanzongzhuangdeng(zhuangdenginfo)
				local pingjunLvl = floor(pingjunLvl*10+5)/10
				PaperDollFrame.ZBLsit.pingjunLV_V:SetText(pingjunLvl)
				PaperDollFrame.ZBLsit:SetWidth(newmaxWWWW)
			end
		end
	end
	
	for i=1,#zhuangbeizhanshiID do
		local clsit = CreateFrame("Frame", "CZBLsit"..zhuangbeizhanshiID[i], PaperDollFrame.ZBLsit);
		clsit:SetSize(2,17);
		if i==1 then
			clsit:SetPoint("TOPLEFT",PaperDollFrame.ZBLsit,"TOPLEFT",32,-26);
		else
			clsit:SetPoint("TOPLEFT",_G["CZBLsit"..(zhuangbeizhanshiID[i-1])],"BOTTOMLEFT",0,0);
		end
		clsit.itembuwei = clsit:CreateFontString();
		clsit.itembuwei:SetPoint("RIGHT",clsit,"LEFT",0,0);
		clsit.itembuwei:SetFont(ChatFontNormal:GetFont(), 13)
		clsit.itembuwei:SetTextColor(0, 1, 1,0.9);
		clsit.itembuwei:SetText(buweiName[i])
		clsit.itemlink = clsit:CreateFontString();
		clsit.itemlink:SetPoint("LEFT",clsit,"RIGHT",0,0);
		clsit.itemlink:SetFont(ChatFontNormal:GetFont(), 13,"OUTLINE")
	end
	PaperDollFrame.ZBLsit.Taozhuang = PaperDollFrame.ZBLsit:CreateFontString();
	PaperDollFrame.ZBLsit.Taozhuang:SetPoint("TOPLEFT",_G["CZBLsit"..zhuangbeizhanshiID[#zhuangbeizhanshiID]].itembuwei,"BOTTOMLEFT",0,-10);
	PaperDollFrame.ZBLsit.Taozhuang:SetFont(ChatFontNormal:GetFont(), 13)
	PaperDollFrame.ZBLsit.Taozhuang:SetTextColor(0, 1, 1, 0.9);
	PaperDollFrame.ZBLsit.Taozhuang:SetText("套装：")
	Update_zhuangbeiList()
	PaperDollFrame:HookScript("OnShow",function ()
		Update_zhuangbeiList()
	end)
		-----------
	local function ADD_Inspectlist()
		InspectPaperDollFrame.ZBLsit = CreateFrame("Frame", nil, InspectPaperDollFrame,"BackdropTemplate");
		InspectPaperDollFrame.ZBLsit:SetBackdrop({
			bgFile = "interface/characterframe/ui-party-background.blp", tile = true, tileSize = 0,
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8, 
		});
		InspectPaperDollFrame.ZBLsit:SetBackdropColor(0, 0, 0, 0.8);
		InspectPaperDollFrame.ZBLsit:SetBackdropBorderColor(0, 0, 0, 0.8);
		InspectPaperDollFrame.ZBLsit:SetSize(kuandu,gaoduh);
		InspectPaperDollFrame.ZBLsit:SetPoint("TOPLEFT", InspectPaperDollFrame, "TOPRIGHT",pianyiX,pianyiY);
		-- 
		InspectPaperDollFrame.ZBLsit.pingjunLV = InspectPaperDollFrame.ZBLsit:CreateFontString();
		InspectPaperDollFrame.ZBLsit.pingjunLV:SetPoint("TOPLEFT",InspectPaperDollFrame.ZBLsit,"TOPLEFT",8,-8);
		InspectPaperDollFrame.ZBLsit.pingjunLV:SetFont(GameFontNormal:GetFont(), 15)
		InspectPaperDollFrame.ZBLsit.pingjunLV:SetTextColor(1,215/255,0, 0.9);
		InspectPaperDollFrame.ZBLsit.pingjunLV:SetText("平均装等:")
		InspectPaperDollFrame.ZBLsit.pingjunLV_V = InspectPaperDollFrame.ZBLsit:CreateFontString();
		InspectPaperDollFrame.ZBLsit.pingjunLV_V:SetPoint("LEFT",InspectPaperDollFrame.ZBLsit.pingjunLV,"RIGHT",4,0);
		InspectPaperDollFrame.ZBLsit.pingjunLV_V:SetFont(ChatFontNormal:GetFont(), 15)
		for i=1,#zhuangbeizhanshiID do
			local clsit = CreateFrame("Frame", "CZBLsitInspect"..zhuangbeizhanshiID[i], InspectPaperDollFrame.ZBLsit);
			clsit:SetSize(2,17);
			if i==1 then
				clsit:SetPoint("TOPLEFT",InspectPaperDollFrame.ZBLsit,"TOPLEFT",32,-26);
			else
				clsit:SetPoint("TOPLEFT",_G["CZBLsitInspect"..(zhuangbeizhanshiID[i-1])],"BOTTOMLEFT",0,0);
			end
			clsit.itembuwei = clsit:CreateFontString();
			clsit.itembuwei:SetPoint("RIGHT",clsit,"LEFT",0,0);
			clsit.itembuwei:SetFont(ChatFontNormal:GetFont(), 13)
			clsit.itembuwei:SetTextColor(0, 1, 1,0.9);
			clsit.itembuwei:SetText(buweiName[i])
			clsit.itemlink = clsit:CreateFontString();
			clsit.itemlink:SetPoint("LEFT",clsit,"RIGHT",0,0);
			clsit.itemlink:SetFont(ChatFontNormal:GetFont(), 13,"OUTLINE")
		end
		InspectPaperDollFrame.ZBLsit.Taozhuang = InspectPaperDollFrame.ZBLsit:CreateFontString();
		InspectPaperDollFrame.ZBLsit.Taozhuang:SetPoint("TOPLEFT",_G["CZBLsitInspect"..zhuangbeizhanshiID[#zhuangbeizhanshiID]].itembuwei,"BOTTOMLEFT",0,-10);
		InspectPaperDollFrame.ZBLsit.Taozhuang:SetFont(ChatFontNormal:GetFont(), 13)
		InspectPaperDollFrame.ZBLsit.Taozhuang:SetTextColor(0, 1, 1, 0.9);
		InspectPaperDollFrame.ZBLsit.Taozhuang:SetText("套装：")
	end
	if IsAddOnLoaded("Blizzard_InspectUI") then
		ADD_Inspectlist()
	end
	---
	PaperDollFrame:RegisterEvent("ADDON_LOADED")
	PaperDollFrame:RegisterEvent("INSPECT_READY")
	PaperDollFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	PaperDollFrame:HookScript("OnEvent",function (self,event,arg1)
		if event=="ADDON_LOADED" and arg1=="Blizzard_InspectUI" then
			ADD_Inspectlist()
		end
		if event=="INSPECT_READY" then
			C_Timer.After(0.4,function() Update_zhuangbeiList("INSPECT") end)
		end
		if event=="PLAYER_EQUIPMENT_CHANGED" then
			Update_zhuangbeiList()
		end
	end)
end
fuFrame.zhuangbeiList = ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",20,-100,"显示装备列表","在角色界面右侧显示装备列表")
fuFrame.zhuangbeiList:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["FramePlus"]["CharacterFrame_zhuangbeList"]="ON";
		add_zhuangbeList()
	else
		PIG["FramePlus"]["CharacterFrame_zhuangbeList"]="OFF";
		Pig_Options_RLtishi_UI:Show();
	end
end);
---人物C界面右边显示属性
local function ADD_FontString(fuji,Text,Font,zihao,Point,Color)
	local faxx = fuji:CreateFontString();
	faxx:SetPoint(Point[1], Point[2], Point[3], Point[4], Point[5]);
	faxx:SetFont(Font:GetFont(), zihao)
	faxx:SetTextColor(Color[1],Color[2],Color[3], 0.9);
	faxx:SetText(Text);
	return faxx
end
local function shuxing_Open()
	UIPanelWindows["CharacterFrame"].width = 504
	PaperDollFrame.shuxing = CreateFrame("Frame", "shuxingUI", PaperDollFrame,"BackdropTemplate");
	PaperDollFrame.shuxing:SetBackdrop({
		bgFile = "interface/characterframe/ui-party-background.blp", tile = true, tileSize = 0,
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8, 
	});
	PaperDollFrame.shuxing:SetBackdropColor(0, 0, 0, 0.8);
	PaperDollFrame.shuxing:SetBackdropBorderColor(0, 0, 0, 0.8);
	PaperDollFrame.shuxing:SetSize(150,gaoduh)
	if PaperDollFrame.ZBLsit then
		PaperDollFrame.shuxing:SetPoint("TOPLEFT", PaperDollFrame.ZBLsit, "TOPRIGHT", 1, 0);
	else
		PaperDollFrame.shuxing:SetPoint("TOPLEFT", PaperDollFrame, "TOPRIGHT",pianyiX,pianyiY);	
	end
	---近战---------------------
	local fuji = PaperDollFrame.shuxing
	fuji.ad=ADD_FontString(fuji,"近战属性",GameFontNormal,15,{"TOPLEFT",fuji,"TOPLEFT",4,-8},{1,215/255,0})
	fuji.ad1=ADD_FontString(fuji,"近战命中率:",ChatFontNormal,12,{"TOPLEFT",fuji.ad,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.ad1V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.ad1,"RIGHT",2,0},{1,1,1})
	fuji.ad2=ADD_FontString(fuji,"近战暴击率:",ChatFontNormal,12,{"TOPLEFT",fuji.ad1,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.ad2V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.ad2,"RIGHT",2,0},{1,1,1})
	---远程---------------------
	fuji.adyc=ADD_FontString(fuji,"远程属性",GameFontNormal,15,{"TOPLEFT",fuji.ad2,"BOTTOMLEFT",0,-8},{1,215/255})
	fuji.adyc1=ADD_FontString(fuji,"远程命中率:",ChatFontNormal,12,{"TOPLEFT",fuji.adyc,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.adyc1V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.adyc1,"RIGHT",2,0},{1,1,1})
	fuji.adyc2=ADD_FontString(fuji,"远程暴击率:",ChatFontNormal,12,{"TOPLEFT",fuji.adyc1,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.adyc2V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.adyc2,"RIGHT",2,0},{1,1,1})
	---法系------------------
	fuji.ap=ADD_FontString(fuji,"法系属性",GameFontNormal,15,{"TOPLEFT",fuji.adyc2,"BOTTOMLEFT",0,-8},{1,215/255})
	fuji.ap1=ADD_FontString(fuji,"法术命中率:",ChatFontNormal,12,{"TOPLEFT",fuji.ap,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.ap1V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.ap1,"RIGHT",2,0},{1,1,1})
	fuji.ap2=ADD_FontString(fuji,"法系暴击率:",ChatFontNormal,12,{"TOPLEFT",fuji.ap1,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.ap2V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.ap2,"RIGHT",2,0},{1,1,1})
	fuji.ap3=ADD_FontString(fuji,"5秒回蓝(脱战):",ChatFontNormal,12,{"TOPLEFT",fuji.ap2,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.ap3V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.ap3,"RIGHT",2,0},{1,1,1})
	fuji.ap4=ADD_FontString(fuji,"5秒回蓝(战斗):",ChatFontNormal,12,{"TOPLEFT",fuji.ap3,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.ap4V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.ap4,"RIGHT",2,0},{1,1,1})
	---伤害加成------------------
	fuji.jc=ADD_FontString(fuji,"伤害加成",GameFontNormal,15,{"TOPLEFT",fuji.ap4,"BOTTOMLEFT",0,-8},{1,215/255})
	fuji.jc1=ADD_FontString(fuji,"物伤加成:",ChatFontNormal,12,{"TOPLEFT",fuji.jc,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.jc1V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.jc1,"RIGHT",2,0},{1,1,1})
	fuji.jc2=ADD_FontString(fuji,"治疗加成:",ChatFontNormal,12,{"TOPLEFT",fuji.jc1,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.jc2V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.jc2,"RIGHT",2,0},{1,1,1})
	fuji.jc3=ADD_FontString(fuji,"法伤加成(冰霜):",ChatFontNormal,12,{"TOPLEFT",fuji.jc2,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.jc3V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.jc3,"RIGHT",2,0},{1,1,1})
	fuji.jc4=ADD_FontString(fuji,"法伤加成(火焰):",ChatFontNormal,12,{"TOPLEFT",fuji.jc3,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.jc4V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.jc4,"RIGHT",2,0},{1,1,1})
	fuji.jc5=ADD_FontString(fuji,"法伤加成(奥术):",ChatFontNormal,12,{"TOPLEFT",fuji.jc4,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.jc5V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.jc5,"RIGHT",2,0},{1,1,1})
	fuji.jc6=ADD_FontString(fuji,"法伤加成(暗影):",ChatFontNormal,12,{"TOPLEFT",fuji.jc5,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.jc6V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.jc6,"RIGHT",2,0},{1,1,1})
	fuji.jc7=ADD_FontString(fuji,"法伤加成(自然):",ChatFontNormal,12,{"TOPLEFT",fuji.jc6,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.jc7V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.jc7,"RIGHT",2,0},{1,1,1})
	fuji.jc8=ADD_FontString(fuji,"法伤加成(神圣):",ChatFontNormal,12,{"TOPLEFT",fuji.jc7,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.jc8V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.jc8,"RIGHT",2,0},{1,1,1})
	---防御---------------------
	fuji.fy=ADD_FontString(fuji,"防御属性",GameFontNormal,15,{"TOPLEFT",fuji.jc8,"BOTTOMLEFT",0,-8},{1,215/255})
	fuji.fy1=ADD_FontString(fuji,"闪避几率:",ChatFontNormal,12,{"TOPLEFT",fuji.fy,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.fy1V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.fy1,"RIGHT",2,0},{1,1,1})
	fuji.fy2=ADD_FontString(fuji,"招架几率:",ChatFontNormal,12,{"TOPLEFT",fuji.fy1,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.fy2V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.fy2,"RIGHT",2,0},{1,1,1})
	fuji.fy3=ADD_FontString(fuji,"格挡几率:",ChatFontNormal,12,{"TOPLEFT",fuji.fy2,"BOTTOMLEFT",0,-2},{0,1,1})
	fuji.fy3V=ADD_FontString(fuji,"",ChatFontNormal,12,{"LEFT",fuji.fy3,"RIGHT",2,0},{1,1,1})
	--
	fuji.shuoming=ADD_FontString(fuji,"命中统计不包含天赋加成",ChatFontNormal,12,{"TOPLEFT",fuji.fy3,"BOTTOMLEFT",0,-12},{1, 1, 0})
	-----------
	local function Round(num)    
	    local mult = 10^(2);
	    return math.floor(num * mult + 0.5) / mult;
	end
	local function PaperDollFrameUP()
		if PaperDollFrame:IsVisible() then
			fuji.ad1V:SetText(GetHitModifier().."%")
			fuji.ad2V:SetText(Round(GetCritChance()).."%")
			fuji.adyc1V:SetText(GetHitModifier().."%")
			fuji.adyc2V:SetText(Round(GetRangedCritChance()).."%")
			fuji.ap1V:SetText(GetSpellHitModifier().."%")
			fuji.ap2V:SetText(Round(GetSpellCritChance(1)).."%")
			local base, casting = GetManaRegen()--精神2秒回蓝
			fuji.ap3V:SetText(Round(base*5))
			fuji.ap4V:SetText(Round(casting*5))
			--
			fuji.jc1V:SetText(GetSpellBonusDamage(1))
			fuji.jc2V:SetText(GetSpellBonusHealing())
			fuji.jc3V:SetText(GetSpellBonusDamage(5))
			fuji.jc4V:SetText(GetSpellBonusDamage(3))
			fuji.jc5V:SetText(GetSpellBonusDamage(7))
			fuji.jc6V:SetText(GetSpellBonusDamage(6))
			fuji.jc7V:SetText(GetSpellBonusDamage(4))
			fuji.jc8V:SetText(GetSpellBonusDamage(2))
			---
			fuji.fy1V:SetText(Round(GetDodgeChance()).."%")
			fuji.fy2V:SetText(Round(GetBlockChance()).."%")
			fuji.fy3V:SetText(Round(GetParryChance()).."%")
		end
	end;
	PaperDollFrameUP()
	PaperDollFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	PaperDollFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	PaperDollFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");--更换装备
	PaperDollFrame:RegisterEvent("UNIT_RANGEDDAMAGE");--当单位的远程伤害改变时触发。
	PaperDollFrame:RegisterEvent("UNIT_RANGED_ATTACK_POWER");--当单位的远程攻击力改变时触发。
	PaperDollFrame:RegisterEvent("UNIT_RESISTANCES");--当单位的抗性改变时触发。
	PaperDollFrame:RegisterEvent("UNIT_AURA");--获得BUFF时
	PaperDollFrame:RegisterEvent("UNIT_DISPLAYPOWER");--当单位的魔法类型改变时触发，例如德鲁伊变形
	PaperDollFrame:RegisterEvent("CHARACTER_POINTS_CHANGED");--分配天赋点触发
	PaperDollFrame:RegisterEvent("LEARNED_SPELL_IN_TAB");--学习新法术触发
	PaperDollFrame:HookScript("OnEvent", PaperDollFrameUP);--由注册事件触发
	PaperDollFrame:HookScript("OnShow", PaperDollFrameUP);--框架显示时触发
end
fuFrame.shuxing = ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",300,-100,"显示人物属性(60)","角色面板显示人物属性")
if tocversion>19999 then fuFrame.shuxing:Disable() fuFrame.shuxing.Text:SetTextColor(0.4, 0.4, 0.4, 1) end
fuFrame.shuxing:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["FramePlus"]["CharacterFrame_shuxing"]="ON";
		shuxing_Open()
	else
		PIG["FramePlus"]["CharacterFrame_shuxing"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
-----------------
fuFrame:HookScript("OnShow", function()
	if PIG["FramePlus"]["CharacterFrame_Juese"]=="ON" then
		fuFrame.Juese:SetChecked(true);
	end
	if PIG["FramePlus"]["CharacterFrame_zhuangbeList"]=="ON" then
		fuFrame.zhuangbeiList:SetChecked(true);
	end
	if PIG["FramePlus"]["CharacterFrame_shuxing"]=="ON" then
		fuFrame.shuxing:SetChecked(true);
	end
	if PIG["FramePlus"]["CharacterFrame_naijiu"]=="ON" then
		fuFrame.naijiuzhi:SetChecked(true);
	end
	if PIG["FramePlus"]["CharacterFrame_LV"]=="ON" then
		fuFrame.zhuangbeiLV:SetChecked(true);
	end
	if PIG["FramePlus"]["CharacterFrame_ranse"]=="ON" then
		fuFrame.pinzhiranse:SetChecked(true);
	end
end)
--=====================================
addonTable.FramePlus_CharacterFrame = function()
	if PIG["FramePlus"]["CharacterFrame_Juese"]=="ON" then
		Frame_Mingzhong_Open()
	end
	if PIG["FramePlus"]["CharacterFrame_zhuangbeList"]=="ON" then
		add_zhuangbeList()
	end
	if PIG["FramePlus"]["CharacterFrame_shuxing"]=="ON" then
		if fuFrame.shuxing:IsEnabled() then
			shuxing_Open()
		end
	end
	if PIG["FramePlus"]["CharacterFrame_naijiu"]=="ON" or PIG["FramePlus"]["CharacterFrame_LV"]=="ON" or PIG["FramePlus"]["CharacterFrame_ranse"]=="ON" then
		ADD_gongnengframe()
	end
end