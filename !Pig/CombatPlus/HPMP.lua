local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
local fuFrame=List_R_F_1_3
local ADD_Checkbutton=addonTable.ADD_Checkbutton
---------------------------------
local www,hhh,bianju = 100,16,2
local RuneW=www/6
local RuneWBut,jianjuRUn,kuozhanbili=RuneW-4,4,6
local function ADD_HPMPtiao()
	if HPMPtiao_UI then return end
	local HPMPtiao = CreateFrame("Button", "HPMPtiao_UI", UIParent, "SecureUnitButtonTemplate")
	HPMPtiao:SetSize(www,hhh);
	HPMPtiao:SetPoint("CENTER", UIParent, "CENTER", 0, -80);
	HPMPtiao:SetScript("OnEvent", function (self,event)
		if event=="PLAYER_REGEN_DISABLED" then
			self:Show()
		end
		if event=="PLAYER_REGEN_ENABLED" then
			self:Hide()
		end
	end)
	HPMPtiao:EnableMouse(false)

	HPMPtiao.HP = CreateFrame("StatusBar", nil, HPMPtiao);
	HPMPtiao.HP:SetStatusBarTexture("interface/targetingframe/ui-statusbar.blp")
	HPMPtiao.HP:SetStatusBarColor(0, 1, 0 ,1);
	HPMPtiao.HP:SetSize(www,hhh/2);
	HPMPtiao.HP:SetPoint("TOP",HPMPtiao,"TOP",0,0);

	HPMPtiao.HP.bg = HPMPtiao.HP:CreateTexture(nil, "BACKGROUND");
	HPMPtiao.HP.bg:SetTexture("interface/characterframe/ui-party-background.blp");
	HPMPtiao.HP.bg:SetSize(www+bianju,hhh/2+bianju);
	HPMPtiao.HP.bg:SetPoint("CENTER",HPMPtiao.HP,"CENTER",0,0);
	HPMPtiao.HP.V = HPMPtiao.HP:CreateFontString();
	HPMPtiao.HP.V:SetPoint("CENTER",HPMPtiao.HP,"CENTER",0,0);
	HPMPtiao.HP.V:SetFont(GameFontNormal:GetFont(), 9,"OUTLINE")
	HPMPtiao.HP.V:Hide()

	HPMPtiao.MP = CreateFrame("StatusBar", nil, HPMPtiao);
	HPMPtiao.MP:SetStatusBarTexture("interface/targetingframe/ui-statusbar.blp")
	HPMPtiao.MP:SetStatusBarColor(0, 0, 1 ,1);
	HPMPtiao.MP:SetSize(www,hhh/2);
	HPMPtiao.MP:SetPoint("TOP",HPMPtiao.HP,"BOTTOM",0,-bianju/2);

	HPMPtiao.MP.bg = HPMPtiao.MP:CreateTexture(nil, "BACKGROUND");
	HPMPtiao.MP.bg:SetTexture("interface/characterframe/ui-party-background.blp");
	HPMPtiao.MP.bg:SetSize(www+bianju,hhh/2+bianju);
	HPMPtiao.MP.bg:SetPoint("CENTER",HPMPtiao.MP,"CENTER",0,0);
	HPMPtiao.MP.V = HPMPtiao.MP:CreateFontString();
	HPMPtiao.MP.V:SetPoint("CENTER",HPMPtiao.MP,"CENTER",0,0);
	HPMPtiao.MP.V:SetFont(GameFontNormal:GetFont(), 9,"OUTLINE")
	HPMPtiao.MP.V:Hide()

	local _, classId = UnitClassBase("player");
	--职业编号1战士/2圣骑士/3猎人/4盗贼/5牧师/6死亡骑士/7萨满祭司/8法师/9术士/10武僧/11德鲁伊/12恶魔猎手
	if classId==6 then--死亡骑士
		-- RuneFrame:SetScale(1.8);
		-- RuneFrame:SetPoint("TOP",PlayerFrame,"BOTTOM",200,-100);
		
		local RUNETYPE_BLOOD = 1;
		local RUNETYPE_FROST = 2;
		local RUNETYPE_UNHOLY = 3;
		local RUNETYPE_DEATH = 4;
		local iconTextures = {};
		iconTextures[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood";
		iconTextures[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost";
		iconTextures[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Unholy";
		iconTextures[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death";
		local runeColors = {
			[RUNETYPE_BLOOD] = {1, 0, 0},
			[RUNETYPE_FROST] = {0, 1, 1},
			[RUNETYPE_UNHOLY] = {0, 0.5, 0},
			[RUNETYPE_DEATH] = {0.8, 0.1, 1},
		}
		HPMPtiao.RuneFrame = CreateFrame("Frame", nil, HPMPtiao)
		HPMPtiao.RuneFrame:SetSize(www,RuneW);
		HPMPtiao.RuneFrame:SetPoint("TOP",HPMPtiao,"BOTTOM",0,-2);

		HPMPtiao.RuneFrame.runes = {};
		local function RuneButton_OnUpdate(self, elapsed, ...)
			local cooldown = _G[self:GetName().."Cooldown"];
			local index = self:GetID();
			local start, duration, runeReady = GetRuneCooldown(index);
			local displayCooldown = (runeReady and 0) or 1;
			if ( displayCooldown and start and start > 0 and duration and duration > 0) then
				CooldownFrame_Set(cooldown, start, duration, displayCooldown, true);
				cooldown:SetUseCircularEdge(true)
			end;
			if ( runeReady ) then
				self:SetScript("OnUpdate", nil);	
			end
		end
		local function RuneButton_ShineFadeOut(self)
			self.shining=false;
			UIFrameFadeOut(self, 0.5);
		end
		local function RuneButton_ShineFadeIn(self)
			if self.shining then
				return
			end
			local fadeInfo={
			mode = "IN",
			timeToFade = 0.5,
			finishedFunc = RuneButton_ShineFadeOut,
			finishedArg1 = self,
			}
			self.shining=true;
			UIFrameFade(self, fadeInfo);
		end
		local function RuneButton_Update(self, rune, dontFlash)
			rune = rune or self:GetID();
			local runeType = GetRuneType(rune);
			if ( (not dontFlash) and (runeType) and (runeType ~= self.rune.runeType)) then 
				self.shine:SetVertexColor(unpack(runeColors[runeType]));
				RuneButton_ShineFadeIn(self.shine)
			end
			if (runeType) then
				self.rune:SetTexture(iconTextures[runeType]);
				self.rune:Show();
				self.rune.runeType = runeType;
				self.tooltipText = _G["COMBAT_TEXT_RUNE_"..runeMapping[runeType]];
			else
				self.rune:Hide();
				self.tooltipText = nil;
			end
		end
		local function RuneFrame_AddRune (runeFrame, rune)
			tinsert(runeFrame.runes, rune);
		end
		
		for i=1,6 do
			local PigRune = CreateFrame("Frame", "PIG_Rune"..i, HPMPtiao.RuneFrame, "RuneButtonIndividualTemplate",i)
			if i==1 then
				PigRune:SetPoint("LEFT",HPMPtiao.RuneFrame,"LEFT",jianjuRUn/2,0);
			elseif i==3 then
			elseif i==5 then
				PigRune:SetPoint("LEFT",_G["PIG_Rune"..(i-3)],"RIGHT",jianjuRUn,0);
			else
				PigRune:SetPoint("LEFT",_G["PIG_Rune"..(i-1)],"RIGHT",jianjuRUn,0);
			end
			PigRune:SetSize(RuneWBut,RuneWBut);
			_G["PIG_Rune"..i.."Border"]:SetSize(RuneWBut+kuozhanbili,RuneWBut+kuozhanbili);
			_G["PIG_Rune"..i.."Rune"]:SetSize(RuneWBut+kuozhanbili,RuneWBut+kuozhanbili);
			PigRune:SetFrameStrata("LOW")
			PigRune:EnableMouse(false)

			PigRune:SetScript("OnEnter", nil);
			PigRune:SetScript("OnLeave", nil);
			PigRune:RegisterEvent("PLAYER_ENTERING_WORLD");
			PigRune:SetScript("OnEvent", function(self, event)
				RuneFrame_AddRune(HPMPtiao.RuneFrame, self);
				self.rune = _G[self:GetName().."Rune"];
				self.fill = _G[self:GetName().."Fill"];
				self.shine = _G[self:GetName().."ShineTexture"];
				RuneButton_Update(self);
			end)
		end
		PIG_Rune3:SetPoint("LEFT",PIG_Rune6,"RIGHT",jianjuRUn,0);
		--
		HPMPtiao.RuneFrame:RegisterEvent("RUNE_POWER_UPDATE");
		HPMPtiao.RuneFrame:RegisterEvent("RUNE_TYPE_UPDATE");
		HPMPtiao.RuneFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
		HPMPtiao.RuneFrame:SetScript("OnEvent", function(self, event, ...)
			if ( event == "PLAYER_ENTERING_WORLD" ) then
				for rune in next, self.runes do
					RuneButton_Update(self.runes[rune], rune, true);
				end		
			elseif ( event == "RUNE_POWER_UPDATE" ) then		
				local rune, usable= ...;
				if ( not usable and rune and self.runes[rune] ) then
					self.runes[rune]:SetScript("OnUpdate", RuneButton_OnUpdate);
				elseif ( usable and rune and self.runes[rune] ) then
					self.runes[rune].shine:SetVertexColor(1, 1, 1);
					RuneButton_ShineFadeIn(self.runes[rune].shine)
					self:SetScript("OnUpdate", nil);
				end
			elseif ( event == "RUNE_TYPE_UPDATE" ) then		
				local rune = ...;
				if ( rune ) then
					RuneButton_Update(self.runes[rune], rune);
				end
			end
		end);
	end
	local function gengxinjindu_HP()
		local HP = UnitHealth("player")
		local HPMAX = UnitHealthMax("player")
		HPMPtiao.HP:SetValue(HP);
		HPMPtiao.HP:SetMinMaxValues(0, HPMAX) 
		HPMPtiao.HP.V:SetText(HP.."/"..HPMAX);
	end
	C_Timer.After(0.4,gengxinjindu_HP)
	HPMPtiao.HP:RegisterUnitEvent("UNIT_HEALTH_FREQUENT","player");
	HPMPtiao.HP:RegisterUnitEvent("UNIT_MAXHEALTH","player");
	HPMPtiao.HP:SetScript("OnEvent", function (self,event)
		gengxinjindu_HP()
	end)

	local function gengxinjindu_MP()
		local MP = UnitPower("player")
		local MPMAX = UnitPowerMax("player")
		HPMPtiao.MP:SetValue(MP);
		HPMPtiao.MP:SetMinMaxValues(0, MPMAX)
		local powerType = UnitPowerType("player")
		local info = PowerBarColor[powerType]
		HPMPtiao.MP:SetStatusBarColor(info.r, info.g, info.b ,1)
		HPMPtiao.MP.V:SetText(MP.."/"..MPMAX);
	end
	C_Timer.After(0.4,gengxinjindu_MP)
	HPMPtiao.MP:RegisterUnitEvent("UNIT_DISPLAYPOWER", "player");
	HPMPtiao.MP:RegisterUnitEvent("UNIT_POWER_FREQUENT","player");
	HPMPtiao.MP:RegisterUnitEvent("UNIT_MAXPOWER","player");
	HPMPtiao.MP:SetScript("OnEvent", function (self,event,arg1,arg2)
		if event=="UNIT_DISPLAYPOWER" then
			C_Timer.After(0.1,gengxinjindu_MP)
			C_Timer.After(0.3,gengxinjindu_MP)
		else
			gengxinjindu_MP()
		end
	end)
end
------------
fuFrame.zituanLINE = fuFrame:CreateLine()
fuFrame.zituanLINE:SetColorTexture(1,1,1,0.2)
fuFrame.zituanLINE:SetThickness(1);
fuFrame.zituanLINE:SetStartPoint("TOPLEFT",2,-240)
fuFrame.zituanLINE:SetEndPoint("TOPRIGHT",-2,-240)
---
fuFrame.ziyuantiao = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",20,-250,"显示角色资源条","在人物附近显示一个血量资源条")
if tocversion>39999 then fuFrame.ziyuantiao:Disable() fuFrame.ziyuantiao.Text:SetTextColor(0.4, 0.4, 0.4, 1); end
fuFrame.ziyuantiao:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['CombatPlus']['ziyuantiao']=true;
		fuFrame.zhandouwaiHide:Enable()
		ADD_HPMPtiao();
		fuFrame.suofang:Enable()
		fuFrame.suofang:SetValue(PIG['CombatPlus']['suofangbili']*10);
		fuFrame.Xweizhi:Enable()
		fuFrame.Xweizhi:SetValue(PIG['CombatPlus']['Xpianyi']);
		fuFrame.Yweizhi:Enable()
		fuFrame.Yweizhi:SetValue(PIG['CombatPlus']['Ypianyi']);
		fuFrame.hpmpPoint:Show()
		fuFrame.xianshishuzhi:Enable()
		if PIG['CombatPlus']['Showshuzhi'] then
			HPMPtiao_UI.HP.V:Show()
			HPMPtiao_UI.MP.V:Show()
		end
	else
		PIG['CombatPlus']['ziyuantiao']=false;
		fuFrame.zhandouwaiHide:Disable()
		fuFrame.suofang:Disable()
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.zhandouwaiHide = ADD_Checkbutton(nil,fuFrame,-80,"LEFT",fuFrame.ziyuantiao,"RIGHT",180,0,"脱战后隐藏","脱战后隐藏血量资源条")
fuFrame.zhandouwaiHide:Disable()
fuFrame.zhandouwaiHide:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['CombatPlus']['zhandouHide']=true;
		HPMPtiao_UI:Hide()
		HPMPtiao_UI:RegisterEvent("PLAYER_REGEN_DISABLED");
		HPMPtiao_UI:RegisterEvent("PLAYER_REGEN_ENABLED");
	else
		PIG['CombatPlus']['zhandouHide']=false;
		HPMPtiao_UI:Show()
		HPMPtiao_UI:UnregisterEvent("PLAYER_REGEN_DISABLED");
		HPMPtiao_UI:UnregisterEvent("PLAYER_REGEN_ENABLED");
	end
end);
fuFrame.xianshishuzhi = ADD_Checkbutton(nil,fuFrame,-80,"LEFT",fuFrame.zhandouwaiHide,"RIGHT",160,0,"显示数值","显示数值")
fuFrame.xianshishuzhi:Disable()
fuFrame.xianshishuzhi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['CombatPlus']['Showshuzhi']=true
		HPMPtiao_UI.HP.V:Show()
		HPMPtiao_UI.MP.V:Show()
	else
		PIG['CombatPlus']['Showshuzhi']=false
		HPMPtiao_UI.HP.V:Hide()
		HPMPtiao_UI.MP.V:Hide()
	end
end);
--缩放
local S_min,S_max = 6,30
fuFrame.suofangT = fuFrame:CreateFontString();
fuFrame.suofangT:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-300);
fuFrame.suofangT:SetFontObject(GameFontNormal);
fuFrame.suofangT:SetText('缩放');
fuFrame.suofang = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.suofang:SetSize(100,16);
fuFrame.suofang:SetPoint("LEFT",fuFrame.suofangT,"RIGHT",10,0);
fuFrame.suofang.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.suofang.Low:SetText(S_min/10);
fuFrame.suofang.High:SetText(S_max/10);
fuFrame.suofang:SetMinMaxValues(S_min, S_max);
fuFrame.suofang:SetValueStep(1);
fuFrame.suofang:SetObeyStepOnDrag(true);
fuFrame.suofang:EnableMouseWheel(true);
fuFrame.suofang:Disable()
fuFrame.suofang:SetScript("OnMouseWheel", function(self, arg1)
	local sliderMin, sliderMax = self:GetMinMaxValues()
	local value = self:GetValue()
	if arg1 > 0 then
		self:SetValue(min(value + arg1, sliderMax))
	else
		self:SetValue(max(value + arg1, sliderMin))
	end
end)
fuFrame.suofang:SetScript('OnValueChanged', function(self)
	local vallll = self:GetValue()
	local val = vallll/10
	PIG['CombatPlus']['suofangbili']=val
	fuFrame.suofang.Text:SetText(val);
	local NEWwww,NEWhhh=www*val,hhh*val
	HPMPtiao_UI:SetSize(NEWwww,NEWhhh);
	HPMPtiao_UI.HP:SetSize(NEWwww,NEWhhh/2);
	HPMPtiao_UI.HP.bg:SetSize(NEWwww+bianju,NEWhhh/2+bianju);
	HPMPtiao_UI.MP:SetSize(NEWwww,NEWhhh/2);
	HPMPtiao_UI.MP.bg:SetSize(NEWwww+bianju,NEWhhh/2+bianju);
	--HPMPtiao_UI.HP.V:SetFont(GameFontNormal:GetFont(), zihaoV[vallll],"OUTLINE")
	--HPMPtiao_UI.MP.V:SetFont(GameFontNormal:GetFont(), zihaoV[vallll],"OUTLINE")
	HPMPtiao_UI.HP.V:SetFont(GameFontNormal:GetFont(), vallll-2,"OUTLINE")
	HPMPtiao_UI.MP.V:SetFont(GameFontNormal:GetFont(), vallll-2,"OUTLINE")
	--dk
	if HPMPtiao_UI.RuneFrame then
		HPMPtiao_UI.RuneFrame:SetScale(val);
	end
end)
--X位置
local WowWidth=floor(GetScreenWidth());
local X_min,X_max = -WowWidth,WowWidth
fuFrame.XweizhiT = fuFrame:CreateFontString();
fuFrame.XweizhiT:SetPoint("LEFT",fuFrame.suofang,"RIGHT",40,0);
fuFrame.XweizhiT:SetFontObject(GameFontNormal);
fuFrame.XweizhiT:SetText('位置');
fuFrame.Xweizhi = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.Xweizhi:SetSize(120,16);
fuFrame.Xweizhi:SetPoint("LEFT",fuFrame.XweizhiT,"RIGHT",10,0);
fuFrame.Xweizhi.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.Xweizhi.Low:SetText(X_min);
fuFrame.Xweizhi.High:SetText(X_max);
fuFrame.Xweizhi:SetMinMaxValues(X_min, X_max);
fuFrame.Xweizhi:SetValueStep(1);
fuFrame.Xweizhi:SetObeyStepOnDrag(true);
fuFrame.Xweizhi:EnableMouseWheel(true);
fuFrame.Xweizhi:Disable()
fuFrame.Xweizhi:SetScript("OnMouseWheel", function(self, arg1)
	local sliderMin, sliderMax = self:GetMinMaxValues()
	local value = self:GetValue()
	if arg1 > 0 then
		self:SetValue(min(value + arg1, sliderMax))
	else
		self:SetValue(max(value + arg1, sliderMin))
	end
end)
fuFrame.Xweizhi:SetScript('OnValueChanged', function(self)
	local val = self:GetValue()
	PIG['CombatPlus']['Xpianyi']=val
	fuFrame.Xweizhi.Text:SetText("|cffFFD700X偏移|r"..val);
	HPMPtiao_UI:ClearAllPoints();
	HPMPtiao_UI:SetPoint("CENTER", UIParent, "CENTER", val, -80+PIG['CombatPlus']['Ypianyi']);
end)
--Y位置
local WowHeight=floor(GetScreenHeight());
local Y_min,Y_max = -WowHeight,WowHeight
fuFrame.Yweizhi = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.Yweizhi:SetSize(120,16);
fuFrame.Yweizhi:SetPoint("LEFT",fuFrame.Xweizhi,"RIGHT",40,0);
fuFrame.Yweizhi.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.Yweizhi.Low:SetText(Y_min);
fuFrame.Yweizhi.High:SetText(Y_max);
fuFrame.Yweizhi:SetMinMaxValues(Y_min, Y_max);
fuFrame.Yweizhi:SetValueStep(1);
fuFrame.Yweizhi:SetObeyStepOnDrag(true);
fuFrame.Yweizhi:EnableMouseWheel(true);
fuFrame.Yweizhi:Disable()
fuFrame.Yweizhi:SetScript("OnMouseWheel", function(self, arg1)
	local sliderMin, sliderMax = self:GetMinMaxValues()
	local value = self:GetValue()
	if arg1 > 0 then
		self:SetValue(min(value + arg1, sliderMax))
	else
		self:SetValue(max(value + arg1, sliderMin))
	end
end)
fuFrame.Yweizhi:SetScript('OnValueChanged', function(self)
	local val = self:GetValue()
	PIG['CombatPlus']['Ypianyi']=val
	fuFrame.Yweizhi.Text:SetText("|cffFFD700Y偏移|r"..val);
	HPMPtiao_UI:ClearAllPoints();
	HPMPtiao_UI:SetPoint("CENTER", UIParent, "CENTER", PIG['CombatPlus']['Xpianyi'], -80+val);
end)
---重置位置
fuFrame.hpmpPoint = CreateFrame("Button",nil,fuFrame);
fuFrame.hpmpPoint:SetSize(22,22);
fuFrame.hpmpPoint:SetPoint("LEFT",fuFrame.Yweizhi,"RIGHT",24,-1);
fuFrame.hpmpPoint:Hide()
fuFrame.hpmpPoint.highlight = fuFrame.hpmpPoint:CreateTexture(nil, "HIGHLIGHT");
fuFrame.hpmpPoint.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
fuFrame.hpmpPoint.highlight:SetBlendMode("ADD")
fuFrame.hpmpPoint.highlight:SetPoint("CENTER", fuFrame.hpmpPoint, "CENTER", 0,0);
fuFrame.hpmpPoint.highlight:SetSize(30,30);
fuFrame.hpmpPoint.Normal = fuFrame.hpmpPoint:CreateTexture(nil, "BORDER");
fuFrame.hpmpPoint.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
fuFrame.hpmpPoint.Normal:SetBlendMode("ADD")
fuFrame.hpmpPoint.Normal:SetPoint("CENTER", fuFrame.hpmpPoint, "CENTER", 0,0);
fuFrame.hpmpPoint.Normal:SetSize(18,18);
fuFrame.hpmpPoint:HookScript("OnMouseDown", function (self)
	fuFrame.hpmpPoint.Normal:SetPoint("CENTER", fuFrame.hpmpPoint, "CENTER", -1.5,-1.5);
end);
fuFrame.hpmpPoint:HookScript("OnMouseUp", function (self)
	fuFrame.hpmpPoint.Normal:SetPoint("CENTER", fuFrame.hpmpPoint, "CENTER", 0,0);
end);
fuFrame.hpmpPoint:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("\124cff00ff00重置资源条的位置\124r")
	GameTooltip:Show();
end);
fuFrame.hpmpPoint:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
fuFrame.hpmpPoint:SetScript("OnClick", function ()
	HPMPtiao_UI:ClearAllPoints();
	HPMPtiao_UI:SetPoint("CENTER", UIParent, "CENTER", 0, -80);
	PIG['CombatPlus']['Xpianyi']=0
	PIG['CombatPlus']['Ypianyi']=0
	fuFrame.Xweizhi:SetValue(0);
	fuFrame.Yweizhi:SetValue(0);
end)
--=====================================
addonTable.CombatPlus_HPMPziyuan = function()
	if PIG['CombatPlus']['ziyuantiao'] then
		fuFrame.ziyuantiao:SetChecked(true);
		if fuFrame.ziyuantiao:IsEnabled() then
			ADD_HPMPtiao()
			fuFrame.zhandouwaiHide:Enable()
			if PIG['CombatPlus']['zhandouHide'] then
				if not InCombatLockdown() then
					HPMPtiao_UI:Hide()
				end
				HPMPtiao_UI:RegisterEvent("PLAYER_REGEN_DISABLED");
				HPMPtiao_UI:RegisterEvent("PLAYER_REGEN_ENABLED");
			end
			fuFrame.suofang:Enable()
			fuFrame.suofang:SetValue(PIG['CombatPlus']['suofangbili']*10);
			fuFrame.Xweizhi:Enable()
			fuFrame.Xweizhi:SetValue(PIG['CombatPlus']['Xpianyi']);
			fuFrame.Yweizhi:Enable()
			fuFrame.Yweizhi:SetValue(PIG['CombatPlus']['Ypianyi']);
			fuFrame.hpmpPoint:Show()
			fuFrame.xianshishuzhi:Enable()
			if PIG['CombatPlus']['Showshuzhi'] then
				HPMPtiao_UI.HP.V:Show()
				HPMPtiao_UI.MP.V:Show()
			end
		end
	end
	if PIG['CombatPlus']['zhandouHide'] then
		fuFrame.zhandouwaiHide:SetChecked(true);
	end
	if PIG['CombatPlus']['Showshuzhi'] then
		fuFrame.xianshishuzhi:SetChecked(true);
	end
end