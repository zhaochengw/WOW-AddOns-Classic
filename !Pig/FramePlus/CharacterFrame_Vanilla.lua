local _, addonTable = ...;
local fuFrame=List_R_F_1_5
local _, _, _, tocversion = GetBuildInfo()
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
local function shuxingFrame_Open()
	if shuxing_HELP1_UI then return end
	--命中说明-物理
	local mingzhongHELP = CreateFrame("Button","mingzhongHELP_UI",PaperDollItemsFrame, "UIPanelInfoButton");  
	mingzhongHELP:SetSize(16,16);
	mingzhongHELP:SetPoint("RIGHT", PaperDollItemsFrame, "RIGHT", -90, 0);
	mingzhongHELP:SetFrameLevel(6)
	mingzhongHELP.texture:SetPoint("BOTTOMRIGHT", mingzhongHELP, "BOTTOMRIGHT", 0, 0);
	mingzhongHELP.Wl = CreateFrame("Frame", nil, mingzhongHELP,"BackdropTemplate");
	mingzhongHELP.Wl:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 0, edgeSize = 16, 
	insets = { left = 3, right = 3, top = 3, bottom = 3 }});
	mingzhongHELP.Wl:SetBackdropBorderColor(0.6, 0.6, 0.6, 1);
	mingzhongHELP.Wl:SetPoint("TOPLEFT", PaperDollItemsFrame, "TOPRIGHT", -30, -13);
	mingzhongHELP.Wl:SetPoint("BOTTOMRIGHT", PaperDollItemsFrame, "BOTTOMRIGHT", 222, 75);
	mingzhongHELP.Wl:Hide()

	mingzhongHELP.Wl.title1 = mingzhongHELP.Wl:CreateFontString();
	mingzhongHELP.Wl.title1:SetPoint("TOPLEFT", mingzhongHELP.Wl, "TOPLEFT", 6, -6);
	mingzhongHELP.Wl.title1:SetFontObject(GameFontNormal);
	mingzhongHELP.Wl.title1:SetText('关于物理命中')
	mingzhongHELP.Wl.title2 = mingzhongHELP.Wl:CreateFontString();
	mingzhongHELP.Wl.title2:SetPoint("TOPLEFT", mingzhongHELP.Wl.title1, "BOTTOMLEFT", 0, 0);
	mingzhongHELP.Wl.title2:SetFontObject(CombatLogFont);
	mingzhongHELP.Wl.title2:SetWidth(240);
	if tocversion<20000 then
		mingzhongHELP.Wl.title2:SetText(
		'同级:基础命中率95%(5%)\r高1级:基础命中率94.5%(6%)\r高2级:基础命中率94%(6%)\r高3级:基础命中率92%(8%)\r'..
		'双持惩罚:基础命中率-19%\r'..
		'|cffFFD700例外情况：|r\r'..
		'|cffFF8C00当<目标的防御等级>减去<玩家武器技能>大于10,装备或天赋上所提供的命中会被无视1%。这将导致在对抗骷髅BOSS时需要额外1%的命中，即需要9%的命中而不是8%.|r\r'..
		'武器技能和防御等级计算公式当前级别*5；60级角色对抗骷髅BOSS情况:5*63-5*60>10\r'..
		'|cffFFD700种族武器专精：|r\r'..
		'人类的剑/双手剑/锤/双手锤与兽人的斧/双手斧武器技能提高5点，会产生效果：'..
		'会使武器技能和BOSS防御等级差值不大于10，不需要额外1%命中，再加上5点武器技能本身提供的1%命中，此时你将只需要6%命中即可。但武器技能的作用还不止于此，也会大量降低你的普攻偏斜。')
	elseif tocversion<30000 then
		mingzhongHELP.Wl.title2:SetText(
		'同级:基础命中率95%(5%)\r高1级:基础命中率93.8%(7%)\r高2级:基础命中率92.8%(8%)\r高3级:基础命中率91.4%(9%)\r'..
		'双持惩罚:基础命中率减去19%\r'..
		'|cffFFD700命中等级：|r\r'..
		'|cffFF8C00TBC1%命中≈15.8命中等级。|r\r'..
		'9%命中：9*15.8≈143命中等级\r'..
		'双持职业\n需要28*15.8≈443点命中等级\r'..
		'|cffFFD700职业差异：|r\r'..
		'猎人，武器战以及猫德这些DPS职业都只需要9%的命中，就可以保证技能和平A全部命中\n'..
		'盗贼/狂暴战/增强萨,天赋自带5%/5%/6%的命中，双持的时候需要23%/23%/22%的命中\n'..
		"不过狂暴战/增强萨达到9%命中之后，暴击收益更高，只需堆到9%保证技能命中后尽量堆暴击，盗贼因为天赋回能尽量堆满命中\n"..
		"坦克:达到9%技能全命中后优先考虑生存属性")
	elseif tocversion<40000 then
		mingzhongHELP.Wl.title2:SetText(
		'同级:基础命中率95%(5%)\r高1级:基础命中率93.8%(7%)\r高2级:基础命中率92.8%(8%)\r高3级:基础命中率91.4%(9%)\r'..
		'双持惩罚:基础命中率减去19%\r'..
		'|cffFFD700命中等级：|r\r'..
		'|cffFF8C00WLK1%命中≈32.8命中等级。|r\r'..
		'9%命中：9*32.8≈296命中等级\r'..
		'双持职业\n需要28*32.8≈919点命中等级\r'..
		'|cffFFD700职业差异：|r\r'..
		'猎人，武器战以及猫德这些DPS职业都只需要9%的命中，就可以保证技能和平A全部命中\n'..
		'盗贼/狂暴战/增强萨,天赋自带5%/5%/6%的命中，双持的时候需要23%/23%/22%的命中\n'..
		"不过狂暴战/增强萨达到9%命中之后，暴击收益更高，只需堆到9%保证技能命中后尽量堆暴击，盗贼因为天赋回能尽量堆满命中\n"..
		"坦克:达到9%技能全命中后优先考虑生存属性")
	end
	mingzhongHELP.Wl.title3 = mingzhongHELP.Wl:CreateFontString();
	mingzhongHELP.Wl.title3:SetPoint("TOPLEFT", mingzhongHELP.Wl.title2, "BOTTOMLEFT", 0, -6);
	mingzhongHELP.Wl.title3:SetFontObject(CombatLogFont);
	mingzhongHELP.Wl.title3:SetText('|cff00ff00骷髅BOSS默认高玩家3级|r')

	--命中说明-法术
	mingzhongHELP.Fs = CreateFrame("Frame", nil,mingzhongHELP,"BackdropTemplate");
	mingzhongHELP.Fs:SetSize(250,424);
	mingzhongHELP.Fs:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 0, edgeSize = 16, 
	insets = { left = 3, right = 3, top = 3, bottom = 3 }});
	mingzhongHELP.Fs:SetBackdropBorderColor(0.6, 0.6, 0.6, 1);
	mingzhongHELP.Fs:SetPoint("TOPLEFT", mingzhongHELP.Wl, "TOPRIGHT", 0, -0);
	mingzhongHELP.Fs:SetPoint("BOTTOMRIGHT", mingzhongHELP.Wl, "BOTTOMRIGHT", 200, 0);
	mingzhongHELP.Fs:Hide()

	mingzhongHELP.Fs.title1 = mingzhongHELP.Fs:CreateFontString();--
	mingzhongHELP.Fs.title1:SetPoint("TOPLEFT", mingzhongHELP.Fs, "TOPLEFT", 6, -6);
	mingzhongHELP.Fs.title1:SetFontObject(GameFontNormal);
	mingzhongHELP.Fs.title1:SetText('关于法系命中（抵抗）')
	mingzhongHELP.Fs.title10 = mingzhongHELP.Fs:CreateFontString();--
	mingzhongHELP.Fs.title10:SetPoint("TOPLEFT", mingzhongHELP.Fs.title1, "BOTTOMLEFT", 0, 0);
	mingzhongHELP.Fs.title10:SetFontObject(CombatLogFont);
	if tocversion<20000 then
		mingzhongHELP.Fs.title10:SetText(
		'|cffFF8C00注意:法术命中上限是99%|r\r同级:基础命中率96%(3%)\r高1级:基础命中率95%(4%)\r高2级:基础命中率94%(5%)\r'..
		'高3级:基础命中率83%(16%)\r')
	elseif tocversion<30000 then
		mingzhongHELP.Fs.title10:SetText(
		'|cffFF8C00注意:法术命中上限是99%|r\r同级:基础命中率96%(3%)\r高1级:基础命中率95%(4%)\r高2级:基础命中率94%(5%)\r'..
		'高3级:基础命中率83%(16%)\r'..
		'TBC法系命中率\r1%≈12.6法系命中等级')
	elseif tocversion<40000 then
		mingzhongHELP.Fs.title10:SetText(
		'|cffFF8C00注意:法术命中上限是99%|r\r同级:基础命中率96%(3%)\r高1级:基础命中率95%(4%)\r高2级:基础命中率94%(5%)\r'..
		'高3级:基础命中率83%(16%)\r'..
		'WLK法系命中率\r1%≈26.2法系命中等级')
	end

	mingzhongHELP.Fs.title3 = mingzhongHELP.Fs:CreateFontString();--
	mingzhongHELP.Fs.title3:SetPoint("TOPLEFT", mingzhongHELP.Fs.title10, "BOTTOMLEFT", 0, -6);
	mingzhongHELP.Fs.title3:SetFontObject(CombatLogFont);
	mingzhongHELP.Fs.title3:SetText('|cff00ff00骷髅BOSS默认高玩家3级|r')

	mingzhongHELP:SetScript("OnEnter", function() mingzhongHELP.Wl:Show() mingzhongHELP.Fs:Show() end );
	mingzhongHELP:SetScript("OnLeave", function() mingzhongHELP.Wl:Hide() mingzhongHELP.Fs:Hide() end );

	--修理费用
	PaperDollItemsFrame.xiuli = CreateFrame("Frame",nil,PaperDollItemsFrame);  
	PaperDollItemsFrame.xiuli:SetSize(110,20);
	PaperDollItemsFrame.xiuli:SetPoint("LEFT", PaperDollItemsFrame, "LEFT", 66, 0);
	PaperDollItemsFrame.xiuli:SetFrameLevel(6)
	PaperDollItemsFrame.xiuli.ICON = PaperDollItemsFrame:CreateTexture(nil, "OVERLAY");
	PaperDollItemsFrame.xiuli.ICON:SetTexture("interface/minimap/tracking/repair.blp");
	PaperDollItemsFrame.xiuli.ICON:SetSize(20,20);
	PaperDollItemsFrame.xiuli.ICON:SetPoint("LEFT", PaperDollItemsFrame.xiuli, "LEFT", 0, 0);
	PaperDollItemsFrame.xiuli.G = PaperDollItemsFrame:CreateFontString();
	PaperDollItemsFrame.xiuli.G:SetPoint("LEFT", PaperDollItemsFrame.xiuli.ICON, "RIGHT", 0, 0);
	PaperDollItemsFrame.xiuli.G:SetFont(ChatFontNormal:GetFont(), 13);
	local PIGtooltip = CreateFrame("GameTooltip")
	PIGtooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
	local naijiubuweiID = {1,3,5,6,7,8,9,10,16,17,18}
	PaperDollItemsFrame:HookScript("OnShow",function (self,event)
		PaperDollItemsFrame.repaircost=0
		for id=1,#naijiubuweiID do
			local hasItem,_,cost = PIGtooltip:SetInventoryItem("player", naijiubuweiID[id])
			PaperDollItemsFrame.repaircost=PaperDollItemsFrame.repaircost+cost
		end
		PaperDollItemsFrame.xiuli.G:SetText(GetCoinTextureString(PaperDollItemsFrame.repaircost))
	end)
	------
	if tocversion<20000 then
		---人物C界面右边显示属性
		UIPanelWindows["CharacterFrame"] = {area = "override", pushable = 0, xoffset = -16, yoffset = 12, bottomClampOverride = 140 + 12, width = 510, height = 487, whileDead = 1}
		CharacterFrame.shuxing = CreateFrame("Frame", "shuxingUI", CharacterFrame,"BackdropTemplate");
		CharacterFrame.shuxing:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
		tile = true, tileSize = 0, edgeSize = 16, 
		insets = { left = 3, right = 3, top = 3, bottom = 3 }});
		CharacterFrame.shuxing:SetBackdropBorderColor(0.6, 0.6, 0.6, 1);
		CharacterFrame.shuxing:SetPoint("TOPLEFT", CharacterFrame, "TOPRIGHT", -33, -13);
		CharacterFrame.shuxing:SetPoint("BOTTOMRIGHT", CharacterFrame, "BOTTOMRIGHT", 150, 75);
		---------------------近战---------------------
		CharacterFrame.shuxing.title0 = CharacterFrame.shuxing:CreateFontString();--
		CharacterFrame.shuxing.title0:SetPoint("TOPLEFT", CharacterFrame.shuxing, "TOPLEFT", 10, -6);
		CharacterFrame.shuxing.title0:SetFontObject(GameFontNormal);
		CharacterFrame.shuxing.title0:SetText('近战属性');
		CharacterFrame.shuxing.title00 = CharacterFrame.shuxing:CreateFontString();--
		CharacterFrame.shuxing.title00:SetPoint("TOPLEFT", CharacterFrame.shuxing.title0, "BOTTOMLEFT", 0, 0);
		CharacterFrame.shuxing.title00:SetFontObject(CombatLogFont);
		---------------------远程---------------------
		CharacterFrame.shuxing.title1 = CharacterFrame.shuxing:CreateFontString();--
		CharacterFrame.shuxing.title1:SetPoint("TOPLEFT", CharacterFrame.shuxing.title00, "BOTTOMLEFT", 0, -6);
		CharacterFrame.shuxing.title1:SetFontObject(GameFontNormal);
		CharacterFrame.shuxing.title1:SetText('远程属性');
		CharacterFrame.shuxing.title10 = CharacterFrame.shuxing:CreateFontString();--
		CharacterFrame.shuxing.title10:SetPoint("TOPLEFT", CharacterFrame.shuxing.title1, "BOTTOMLEFT", 0, 0);
		CharacterFrame.shuxing.title10:SetFontObject(CombatLogFont);
		---------------------法系------------------
		CharacterFrame.shuxing.title2 = CharacterFrame.shuxing:CreateFontString();
		CharacterFrame.shuxing.title2:SetPoint("TOPLEFT", CharacterFrame.shuxing.title10, "BOTTOMLEFT", 0, -6);
		CharacterFrame.shuxing.title2:SetFontObject(GameFontNormal);
		CharacterFrame.shuxing.title2:SetText('法系属性');
		CharacterFrame.shuxing.title20 = CharacterFrame.shuxing:CreateFontString();
		CharacterFrame.shuxing.title20:SetPoint("TOPLEFT", CharacterFrame.shuxing.title2, "BOTTOMLEFT", 0, 0);
		CharacterFrame.shuxing.title20:SetFontObject(CombatLogFont);
		---------------------伤害加成------------------
		CharacterFrame.shuxing.title3 = CharacterFrame.shuxing:CreateFontString();
		CharacterFrame.shuxing.title3:SetPoint("TOPLEFT", CharacterFrame.shuxing.title20, "BOTTOMLEFT", 0, -6);
		CharacterFrame.shuxing.title3:SetFontObject(GameFontNormal);
		CharacterFrame.shuxing.title3:SetText('伤害加成');
		CharacterFrame.shuxing.title30 = CharacterFrame.shuxing:CreateFontString();
		CharacterFrame.shuxing.title30:SetPoint("TOPLEFT", CharacterFrame.shuxing.title3, "BOTTOMLEFT", 0, 0);
		CharacterFrame.shuxing.title30:SetFontObject(CombatLogFont);
		---------------------防御---------------------
		CharacterFrame.shuxing.title4 = CharacterFrame.shuxing:CreateFontString();--
		CharacterFrame.shuxing.title4:SetPoint("TOPLEFT", CharacterFrame.shuxing.title30, "BOTTOMLEFT", 0, -8);
		CharacterFrame.shuxing.title4:SetFontObject(GameFontNormal);
		CharacterFrame.shuxing.title4:SetText('防御属性');
		CharacterFrame.shuxing.title40 = CharacterFrame.shuxing:CreateFontString();--
		CharacterFrame.shuxing.title40:SetPoint("TOPLEFT", CharacterFrame.shuxing.title4, "BOTTOMLEFT", 0, 0);
		CharacterFrame.shuxing.title40:SetFontObject(CombatLogFont);
		---
		CharacterFrame.shuxing.title99 = CharacterFrame.shuxing:CreateFontString();--
		CharacterFrame.shuxing.title99:SetPoint("BOTTOMLEFT", CharacterFrame.shuxing, "BOTTOMLEFT", 10, 6);
		CharacterFrame.shuxing.title99:SetFont(GameFontNormal:GetFont(), 13,"OUTLINE")
		CharacterFrame.shuxing.title99:SetTextColor(1, 1, 0, 1);
		CharacterFrame.shuxing.title99:SetText("命中统计不包含天赋加成");
		---------注册事件*---------
		local function Round(num)    
		    mult = 10^(2);
		    return math.floor(num * mult + 0.5) / mult;
		end
		local function CharacterFrameUP()
			if CharacterFrame:IsVisible() then
				CharacterFrame.shuxing.title00:SetText('近战命中率：'..GetHitModifier()..'%\r近战暴击率：'..Round(GetCritChance())..'%');
				CharacterFrame.shuxing.title10:SetText('远程命中率：'..GetHitModifier()..'%\r远程暴击率：'..Round(GetRangedCritChance())..'%');
				base, casting = GetManaRegen()--精神2秒回蓝
				CharacterFrame.shuxing.title20:SetText('法术命中率：'..GetSpellHitModifier()..'\r法术暴击率：'..Round(GetSpellCritChance(1))..'%'
				..'\r精神2回(脱战)：'..Round(base*2)..'\r精神2回(战斗)：'..Round(casting*2));
				CharacterFrame.shuxing.title30:SetText('物伤加成：'..GetSpellBonusDamage(1)..'\r治疗加成：'..GetSpellBonusHealing()
				..'\r法伤加成(冰霜)：'..GetSpellBonusDamage(5)..'\r法伤加成(火焰)：'..GetSpellBonusDamage(3)..'\r法伤加成(奥术)：'..GetSpellBonusDamage(7)
				..'\r法伤加成(暗影)：'..GetSpellBonusDamage(6)..'\r法伤加成(神圣)：'..GetSpellBonusDamage(2)
				..'\r法伤加成(自然)：'..GetSpellBonusDamage(4));
				CharacterFrame.shuxing.title40:SetText('闪避几率：'..Round(GetDodgeChance())..'%\r招架几率：'..Round(GetBlockChance())
				..'%\r格挡几率：'..Round(GetParryChance())..'%');
			end
		end;
		CharacterFrame:RegisterEvent("PLAYER_ENTERING_WORLD");--当玩家进入世界，进入/离开实例或在墓地重生时触发
		CharacterFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");--更换装备
		CharacterFrame:RegisterEvent("UNIT_RANGEDDAMAGE");--当单位的远程伤害改变时触发。
		CharacterFrame:RegisterEvent("UNIT_RANGED_ATTACK_POWER");--当单位的远程攻击力改变时触发。
		CharacterFrame:RegisterEvent("UNIT_RESISTANCES");--当单位的抗性改变时触发。
		CharacterFrame:RegisterEvent("UNIT_AURA");--获得BUFF时
		CharacterFrame:RegisterEvent("UNIT_DISPLAYPOWER");--当单位的魔法类型改变时触发，例如德鲁伊变形
		CharacterFrame:RegisterEvent("CHARACTER_POINTS_CHANGED");--分配天赋点触发
		CharacterFrame:RegisterEvent("LEARNED_SPELL_IN_TAB");--学习新法术触发
		CharacterFrame:HookScript("OnEvent", CharacterFrameUP);--由注册事件触发
		CharacterFrame:HookScript("OnShow", CharacterFrameUP);--框架显示时触发
	end
end
------
fuFrame.Juese = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Juese:SetSize(30,32);
fuFrame.Juese:SetPoint("TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",20,-20);
fuFrame.Juese.Text:SetText("显示修理费/命中说明人物属性(60)");
fuFrame.Juese.tooltip = "角色面板显示修理费用/命中说明/60版本会显示人物属性";
fuFrame.Juese:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['CharacterFrame_Juese']="ON";
		shuxingFrame_Open()
	else
		PIG['FramePlus']['CharacterFrame_Juese']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
---耐久=====================================================
local zhuangbeixilieID={
	{0,"Ammo",false},{1,"Head",true},{2,"Neck",false},{3,"Shoulder",true},{4,"Shirt",false},{5,"Chest",true},
	{6,"Waist",true},{7,"Legs",true},{8,"Feet",true},{9,"Wrist",true},{10,"Hands",true},{11,"Finger0",false},
	{12,"Finger1",false},{13,"Trinket0",false},{14,"Trinket1",false},{15,"Back",false},{16,"MainHand",true},
	{17,"SecondaryHand",true},{18,"Ranged",true},{19,"Tabard",false},
}
-----------------------
local function Update_naijiuV()
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
local function ADD_naijiuV()
	for inv = 1, #zhuangbeixilieID do
		local Frameu=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
		if not Frameu.naijiuV then
			Frameu.naijiuV = Frameu:CreateFontString();
			Frameu.naijiuV:SetPoint("BOTTOMLEFT", Frameu, "BOTTOMLEFT", 1, 1);
			Frameu.naijiuV:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
			Frameu.naijiuV:SetDrawLayer("OVERLAY", 7)
		end
	end
	Update_naijiuV()
	PaperDollItemsFrame:HookScript("OnShow",function (self,event)
		Update_naijiuV()
	end)
end
-----------------------
fuFrame.naijiuzhi = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.naijiuzhi:SetSize(30,32);
fuFrame.naijiuzhi:SetPoint("TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",300,-20);
fuFrame.naijiuzhi.Text:SetText("显示装备耐久");
fuFrame.naijiuzhi.tooltip = "角色面板显示装备耐久剩余值";
fuFrame.naijiuzhi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']["CharacterFrame_naijiu"]="ON";
		ADD_naijiuV()
	else
		PIG['FramePlus']["CharacterFrame_naijiu"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--显示装备等级========================================
local pingzhiColor = {
	[0]={157/255,157/255,157/255},
	[1]={1, 1, 1},
	[2]={30/255, 1, 0},
	[3]={0,112/255,221/255},
	[4]={163/255,53/255,238/255},
	[5]={1,128/255,0},
	[6]={230/255,204/255,128/255},
	[7]={0,204/255,1},
}
--自身装备LV---------------------
local function shuaxin_LV(framef,unit, ZBID)
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
local function Update_LV()
	for inv = 1, #zhuangbeixilieID do
		if zhuangbeixilieID[inv][1]~=0 and zhuangbeixilieID[inv][1]~=4 and zhuangbeixilieID[inv][1]~=19 then
			local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
			shuaxin_LV(framef,"player", zhuangbeixilieID[inv][1])
		end
	end
end
local function ADD_LVT()
	--装备栏
	for inv = 1, #zhuangbeixilieID do
		local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
		if framef.ZLV then return end
		framef.ZLV = framef:CreateFontString();
		framef.ZLV:SetPoint("TOPRIGHT", framef, "TOPRIGHT", -1, -1);
		framef.ZLV:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
		framef.ZLV:SetDrawLayer("OVERLAY", 7)
	end
	Update_LV()
	PaperDollItemsFrame:HookScript("OnShow", function()
		Update_LV();
	end)
end

--观察对象装备LV
local function Inspect_LV()
	for inv = 2, #zhuangbeixilieID do
		if zhuangbeixilieID[inv][1]~=0 and zhuangbeixilieID[inv][1]~=4 and zhuangbeixilieID[inv][1]~=19 then
			local framef=_G["Inspect"..zhuangbeixilieID[inv][2].."Slot"]
			shuaxin_LV(framef,"target", zhuangbeixilieID[inv][1])
		end
	end
end
local function ADD_guancha()
	for inv = 2, #zhuangbeixilieID do
		local framef=_G["Inspect"..zhuangbeixilieID[inv][2].."Slot"]
		if framef.ZLV then return end
		framef.ZLV = framef:CreateFontString();
		framef.ZLV:SetPoint("TOPRIGHT", framef, "TOPRIGHT", -1, -1);
		framef.ZLV:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
		framef.ZLV:SetDrawLayer("OVERLAY", 7)
	end
	PaperDollFrame:UnregisterEvent("ADDON_LOADED");
	C_Timer.After(0.4,Inspect_LV)
	C_Timer.After(0.8,Inspect_LV)
end   

------------
fuFrame.zhuangbeiLV = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.zhuangbeiLV:SetSize(30,32);
fuFrame.zhuangbeiLV:SetHitRectInsets(0,-100,0,0);
fuFrame.zhuangbeiLV:SetPoint("TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",20,-60);
fuFrame.zhuangbeiLV.Text:SetText("显示装等");
fuFrame.zhuangbeiLV.tooltip = "显示装备等级，背包银行物品需要显示装等请在背包内设置！";
fuFrame.zhuangbeiLV:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ShowPlus']['zhuangbeiLV']="ON";
		ADD_LVT()
		PaperDollFrame:RegisterEvent("INSPECT_READY");
		PaperDollFrame:RegisterEvent("ADDON_LOADED")
	else
		PIG['ShowPlus']['zhuangbeiLV']="OFF";
		PaperDollFrame:UnregisterEvent("INSPECT_READY");
		PaperDollFrame:UnregisterEvent("ADDON_LOADED");
		Pig_Options_RLtishi_UI:Show();
	end
end);
--根据品质染色=========================================
local XWidth, XHeight =CharacterHeadSlot:GetWidth(),CharacterHeadSlot:GetHeight()
--自身染色
local function shuaxin_ranse(framef,unit,ZBID)
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
local function Update_ranseV()
	for inv = 1, #zhuangbeixilieID do
		local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
		shuaxin_ranse(framef,"player",zhuangbeixilieID[inv][1])
	end
end
local function add_ranseUI()
	for inv = 1, #zhuangbeixilieID do
		local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
		if framef.ranse then return end
	    framef.ranse = framef:CreateTexture(nil, 'OVERLAY');
	    framef.ranse:SetTexture("Interface/Buttons/UI-ActionButton-Border");
	    framef.ranse:SetBlendMode('ADD');
	    if zhuangbeixilieID[inv][1]==0 then
	    	framef.ranse:SetSize(XWidth*1.4, XHeight*1.4);
	    else
	    	framef.ranse:SetSize(XWidth*1.8, XHeight*1.8);
	    end
	    framef.ranse:SetPoint('CENTER', framef, 'CENTER', 0, 0);
	    framef.ranse:Hide()
	end
	Update_ranseV()
	PaperDollItemsFrame:HookScript("OnShow",function (self,event)
		Update_ranseV()
	end)
end
---观察染色
local function shuaxin_guancha()
	for inv = 2, #zhuangbeixilieID do
		local framef=_G["Inspect"..zhuangbeixilieID[inv][2].."Slot"]
		shuaxin_ranse(framef,"target",zhuangbeixilieID[inv][1])
    end
end
local function ADD_guancha_ranse()
	for inv = 2, #zhuangbeixilieID do
		local framef=_G["Inspect"..zhuangbeixilieID[inv][2].."Slot"]
		if framef.ranse then return end
	    framef.ranse = framef:CreateTexture(nil, 'OVERLAY');
	    framef.ranse:SetTexture("Interface/Buttons/UI-ActionButton-Border");
	    framef.ranse:SetBlendMode('ADD');
	    framef.ranse:SetSize(XWidth*1.8, XHeight*1.8);
	    framef.ranse:SetPoint('CENTER', framef, 'CENTER', 0, 0);
	    framef.ranse:Hide()
	end
	PaperDollFrame:UnregisterEvent("ADDON_LOADED");
	C_Timer.After(0.4,shuaxin_guancha)
	C_Timer.After(0.8,shuaxin_guancha)
end 
------------------
fuFrame.pinzhiranse = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.pinzhiranse:SetSize(30,32);
fuFrame.pinzhiranse:SetHitRectInsets(0,-100,0,0);
fuFrame.pinzhiranse:SetPoint("TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",300,-60);
fuFrame.pinzhiranse.Text:SetText("根据品质染色边框");
fuFrame.pinzhiranse.tooltip = "根据品质染色边框";
fuFrame.pinzhiranse:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['CharacterFrame_ranse']="ON";
		add_ranseUI()
		PaperDollFrame:RegisterEvent("INSPECT_READY");
		PaperDollFrame:RegisterEvent("ADDON_LOADED")
	else
		PIG['FramePlus']['CharacterFrame_ranse']="OFF";
		PaperDollFrame:UnregisterEvent("INSPECT_READY");
		PaperDollFrame:UnregisterEvent("ADDON_LOADED");
		Pig_Options_RLtishi_UI:Show();
	end
end);
--------------------
PaperDollFrame:HookScript("OnEvent", function(self,event,arg1)
	if event=="ADDON_LOADED" and arg1=="Blizzard_InspectUI" then
		if PIG['ShowPlus']['zhuangbeiLV']=="ON" then ADD_guancha()  end
		if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then ADD_guancha_ranse() end
	end
	if event=="INSPECT_READY" then
		if PIG['ShowPlus']['zhuangbeiLV']=="ON" then 
			C_Timer.After(0.4,Inspect_LV)
		end
		if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then
			C_Timer.After(0.4,shuaxin_guancha)
		end
	end

	if event=="UNIT_MODEL_CHANGED" then
		if PaperDollItemsFrame:IsVisible() then
			if PIG['FramePlus']["CharacterFrame_naijiu"]=="ON" then Update_naijiuV() end
			if PIG['ShowPlus']['zhuangbeiLV']=="ON" then Update_LV() end
			if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then Update_ranseV() end
		end
	end
end);
--=====================================
addonTable.FramePlus_CharacterFrame = function()
	if PIG['FramePlus']['CharacterFrame_Juese']=="ON" then
		fuFrame.Juese:SetChecked(true);
		shuxingFrame_Open()
	end
	if PIG['FramePlus']["CharacterFrame_naijiu"]=="ON" then
		fuFrame.naijiuzhi:SetChecked(true);
		ADD_naijiuV()
		PaperDollFrame:RegisterEvent("UNIT_MODEL_CHANGED");
	end

	PIG["ShowPlus"] = PIG["ShowPlus"] or addonTable.Default["ShowPlus"]
	PIG['ShowPlus']['zhuangbeiLV']=PIG['ShowPlus']['zhuangbeiLV'] or addonTable.Default['ShowPlus']['zhuangbeiLV']
	if PIG['ShowPlus']['zhuangbeiLV']=="ON" then
		fuFrame.zhuangbeiLV:SetChecked(true);
		ADD_LVT()
		PaperDollFrame:RegisterEvent("INSPECT_READY");
		PaperDollFrame:RegisterEvent("ADDON_LOADED")
	end
	if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then
		fuFrame.pinzhiranse:SetChecked(true);
		add_ranseUI()
		PaperDollFrame:RegisterEvent("INSPECT_READY");
		PaperDollFrame:RegisterEvent("ADDON_LOADED")
	end
end