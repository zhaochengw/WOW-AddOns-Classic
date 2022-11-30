local _, addonTable = ...;
local fuFrame=List_R_F_1_4
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--==============================================================================
--///队友头像框架增强//////////////////////////////
local UFP_MAX_PARTY_BUFFS = 16;
local UFP_MAX_PARTY_DEBUFFS = 8;
local UFP_MAX_PARTY_PET_DEBUFFS = 4;
----------------
--队友血量
local function Update_HP(self,arg1)
	local mubiaoHmax = UnitHealthMax(arg1)
	if mubiaoHmax>0 then
		local mubiaoH = UnitHealth(arg1)
		self.title:SetText(mubiaoH..'/'..mubiaoHmax);
	else
		self.title:SetText('?/?');
	end
end
--队友等级
local function Update_Level(self,arg1)
	local LevelLL=UnitLevel(arg1)
    if LevelLL then
    	if LevelLL >= 1 then
			self.title:SetText(LevelLL);
		else
			self.title:SetText("?");
		end
	end
end
----队友目标
local function Update_duiyoumubiao(self,arg1)
	local PartymubiaiT=arg1.."target"
	local partytargetname = GetUnitName(PartymubiaiT, true)
	if partytargetname then 
		local diduiORyoushan = UnitIsEnemy(PartymubiaiT,"player")
		local duiyoumubiaobaifenbi = math.floor((UnitHealth(PartymubiaiT)/UnitHealthMax(PartymubiaiT))*100);
		if diduiORyoushan then
			self.title:SetTextColor(1, 0, 0);
		else
			self.title:SetTextColor(0, 1, 0);
		end	
		if UnitIsDead(PartymubiaiT) then
			self.title:SetText(partytargetname.."(死亡)");
		else
			self.title:SetText(partytargetname.."("..duiyoumubiaobaifenbi.."%)");
		end
	else
		self.title:SetText();
	end
end
--显示BUFF
local function Update_BUFF(id,arg1)
	for j = 1, UFP_MAX_PARTY_BUFFS, 1 do
		local BUFFalphap = 0;
		local _, icon = UnitBuff(arg1, j);
		if icon then
			_G["Party"..id.."Buff"..j].Icon:SetTexture(icon);
			BUFFalphap = 1;
		end
		_G["Party"..id.."Buff"..j].Icon:SetAlpha(BUFFalphap);
	end
end
----创建扩展信息框架
local function DuiyouFrame_Open()
	if PartyMemberFrame1.zhiye then return end
	for id = 1, MAX_PARTY_MEMBERS, 1 do
		local Party=_G["PartyMemberFrame"..id]
		----队友职业图标
		Party.zhiye = CreateFrame("Button", nil, Party);
		Party.zhiye:SetFrameLevel(5)
		Party.zhiye:SetSize(28,28);
		Party.zhiye:SetPoint("BOTTOMLEFT", Party, "TOPLEFT", 22, -18);
		Party.zhiye:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight");

		Party.zhiye.Border = Party.zhiye:CreateTexture(nil, "OVERLAY");
		Party.zhiye.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
		Party.zhiye.Border:SetSize(46,46);
		Party.zhiye.Border:SetPoint("CENTER", Party.zhiye, "CENTER", 10, -10);

		Party.zhiye.Icon = Party.zhiye:CreateTexture();
		Party.zhiye.Icon:SetSize(17,17);
		Party.zhiye.Icon:SetPoint("CENTER");

		--队友职业图标点击功能：左交易/右观察
		Party.zhiye:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		Party.zhiye:SetScript("OnClick", function (self, button)
			local wanjiaID =self:GetParent().unit
			if UnitIsConnected(wanjiaID) then--玩家未离线
				local inRange1 = CheckInteractDistance(wanjiaID, 1);
				if button=="LeftButton" and not UnitIsDead(wanjiaID) then
					InspectUnit(wanjiaID);
				elseif button=="RightButton" and inRange1 then		
					InitiateTrade(wanjiaID);         
				end
			end	
		end);
		--队友等级
		Party.Level = CreateFrame("Frame", nil, Party);
		Party.Level:SetSize(20,18);
		Party.Level:SetPoint("TOPRIGHT", Party, "BOTTOMLEFT", 14, 11);
	    Party.Level.title = Party.Level:CreateFontString();
	    Party.Level.title:SetPoint("TOPRIGHT", Party.Level, "TOPRIGHT", 0, 0);
	    Party.Level.title:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
	    Party.Level.title:SetTextColor(1, 0.82, 0);
	    Party.Level:RegisterUnitEvent("UNIT_LEVEL", "party"..id);
	    Party.Level:HookScript("OnEvent", function(self,event,arg1)
			if not IsInRaid() then Update_Level(self,arg1) end
		end)
	    ---队友血量扩展显示框架
		Party.HP = CreateFrame("Frame", nil, Party,"BackdropTemplate");
		Party.HP:SetSize(90,22);
		Party.HP:SetBackdrop({ bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 10, 
		insets = { left = 2, right = 2, top = 2, bottom = 2 }});
		Party.HP:SetBackdropColor(0, 0, 0, 0.6);
		Party.HP:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.9);
		Party.HP:SetPoint("TOPLEFT", Party, "TOPRIGHT", -11, -10);
		Party.HP.title = Party.HP:CreateFontString();
		Party.HP.title:SetPoint("CENTER", Party.HP, "CENTER", 0, 0);
		Party.HP.title:SetFont(GameFontNormal:GetFont(), 13.6,"OUTLINE")
		Party.HP.title:SetTextColor(0,1,0,1);
		Party.HP:RegisterUnitEvent("UNIT_HEALTH", "party"..id);--HP改变时
		Party.HP:RegisterUnitEvent("UNIT_MAXHEALTH", "party"..id);--最大HP改变时
		Party.HP:HookScript("OnEvent", function(self,event,arg1)
			if not IsInRaid() then Update_HP(self,arg1) end
		end)
		--位面图标移位
		_G["PartyMemberFrame"..id.."NotPresentIcon"]:ClearAllPoints()
		_G["PartyMemberFrame"..id.."NotPresentIcon"]:SetPoint("LEFT",Party.HP,"RIGHT",0,0);
		--队友buff常驻显示
		for j = 1, UFP_MAX_PARTY_BUFFS, 1 do  --BUFF
			Party.buff = CreateFrame("Button", "Party"..id.."Buff"..j, Party);
			Party.buff:SetSize(15,15);
			if j == 1 then
	            Party.buff:SetPoint("TOPLEFT", Party, "TOPLEFT", 48, -32);
	            Party.buff:RegisterUnitEvent("UNIT_AURA","party"..id);--获得BUFF时
	            Party.buff:HookScript("OnEvent", function(self,event,arg1)
					if not IsInRaid() then Update_BUFF(id,arg1) end
				end)
	        else
	            Party.buff:SetPoint("LEFT", _G["Party"..id.."Buff"..(j-1)], "RIGHT", 2, 0);
	        end
			Party.buff.Icon = Party.buff:CreateTexture(nil, "ARTWORK");
	        Party.buff.Icon:SetAllPoints(Party.buff)
			
			Party.buff:EnableMouse(true);
	        Party.buff:SetScript("OnEnter",function(self)
	        	GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	            GameTooltip:SetUnitBuff(Party.unit, j);
	        end)
	        Party.buff:SetScript("OnLeave",function()
	            GameTooltip:Hide();
	        end)
	    end
	    --改动系统DEBUFF位置
		_G["PartyMemberFrame"..id.."Debuff1"]:ClearAllPoints();
		_G["PartyMemberFrame"..id.."Debuff1"]:SetPoint("TOPRIGHT", _G["PartyMemberFrame"..id], "TOPRIGHT", 50, 8);

	    --队友目标
		Party.mubiao = CreateFrame("Button", nil, Party, "SecureActionButtonTemplate")
		Party.mubiao:SetSize(100,22);
		Party.mubiao:SetPoint("LEFT", Party.HP, "RIGHT", 4, -0);
		Party.mubiao:RegisterForClicks("AnyUp")
		Party.mubiao:RegisterForDrag("LeftButton")
		Party.mubiao:SetAttribute("*type1", "target")
		Party.mubiao:SetAttribute("unit", "Party"..id.."target")
	    Party.mubiao.title = Party.mubiao:CreateFontString();
	    Party.mubiao.title:SetPoint("LEFT", Party.mubiao, "LEFT", 0, 0);
	    Party.mubiao.title:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
	    Party.mubiao.title:SetTextColor(1, 0.82, 0);
	    Party.mubiao:RegisterUnitEvent("UNIT_TARGET","party"..id);
	    Party.mubiao:HookScript("OnEvent", function(self,event,arg1)
			if not IsInRaid() then Update_duiyoumubiao(self,arg1) end
		end)
	end
	--隐藏系统自带队友buff鼠标提示
	hooksecurefunc("PartyMemberBuffTooltip_Update", function(self)
	    PartyMemberBuffTooltip:Hide();
	end)
	---
	local function Update_Level_ALL(id)
		local Party=_G["PartyMemberFrame"..id].Level
		Update_Level(Party,"party"..id)
	
	end
	local function Update_HP_ALL(id)
		local Party=_G["PartyMemberFrame"..id].HP
		Update_HP(Party,"party"..id)
	end
    local function Update_duiyoumubiao_ALL(id)
		local Party=_G["PartyMemberFrame"..id].mubiao
		Update_duiyoumubiao(Party,"party"..id)
    end
	local function Update_BUFF_ALL(id)
		Update_BUFF(id,"party"..id)
	end
    --===============================
    --更新队友职业图标
	local function Update_zhiye(id)
        local _,class = UnitClass("Party"..id)
		if class then
			_G["PartyMemberFrame"..id].zhiye.Icon:SetTexture("Interface/GLUES/CHARACTERCREATE/UI-CHARACTERCREATE-CLASSES")
			local coords = CLASS_ICON_TCOORDS[class];
			_G["PartyMemberFrame"..id].zhiye.Icon:SetTexCoord(unpack(coords));
		end
	end
	----------------
	local function yanchizhixingsuoyou()
		if not IsInRaid() then
			local numSubgroupMembers = GetNumSubgroupMembers()
			for id = 1, numSubgroupMembers, 1 do
				Update_zhiye(id)
				Update_Level_ALL(id)
				Update_HP_ALL(id)
				Update_duiyoumubiao_ALL(id)
				Update_BUFF_ALL(id)
			end
		end
	end
	C_Timer.After(1,yanchizhixingsuoyou)
	C_Timer.After(2,yanchizhixingsuoyou)
	local function HideHPMPTT()
		for id=1,MAX_PARTY_MEMBERS do
			local partyF = _G["PartyMemberFrame"..id]
			if not partyF then C_Timer.After(3,HideHPMPTT) return end
			_G["PartyMemberFrame"..id.."HealthBarText"]:SetAlpha(0.1);
			_G["PartyMemberFrame"..id.."ManaBarText"]:SetAlpha(0.1);
			local function xianHPMP() 
				_G["PartyMemberFrame"..id.."HealthBarText"]:SetAlpha(1);_G["PartyMemberFrame"..id.."ManaBarText"]:SetAlpha(1);
				
			end
			local function yinHPMP()
				_G["PartyMemberFrame"..id.."HealthBarText"]:SetAlpha(0.1);_G["PartyMemberFrame"..id.."ManaBarText"]:SetAlpha(0.1);
			end
			_G["PartyMemberFrame"..id.."HealthBar"]:HookScript("OnEnter",xianHPMP);
			_G["PartyMemberFrame"..id.."ManaBar"]:HookScript("OnEnter", xianHPMP)
			_G["PartyMemberFrame"..id.."HealthBar"]:HookScript("OnLeave", yinHPMP)
			_G["PartyMemberFrame"..id.."ManaBar"]:HookScript("OnLeave", yinHPMP)
		end
	end
	if tocversion>50000 then C_Timer.After(3,HideHPMPTT) end
	------------------
	local duiyouFrameReg = CreateFrame("Frame");
	duiyouFrameReg:RegisterEvent("GROUP_ROSTER_UPDATE");--团队成员更新
	duiyouFrameReg:SetScript("OnEvent", function(self,event,arg1,...)
		if not IsInRaid() then 
			if event=="GROUP_ROSTER_UPDATE" then
				yanchizhixingsuoyou()
				C_Timer.After(2,yanchizhixingsuoyou)
			end
		end
	end);
end
---
fuFrame.DuiyouLINE = fuFrame:CreateLine()
fuFrame.DuiyouLINE:SetColorTexture(1,1,1,0.2)
fuFrame.DuiyouLINE:SetThickness(1);
fuFrame.DuiyouLINE:SetStartPoint("TOPLEFT",2,-300)
fuFrame.DuiyouLINE:SetEndPoint("TOPRIGHT",-2,-300)
-----
local Duiyoutooltip = "增强队友头像，显示额外血量框架，常驻显示队友BUFF，显示队友目标等！\r|cff00FFFF小提示：|r\r队友职业图标可以点击，左击观察/右击交易。"
fuFrame.Duiyou=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.DuiyouLINE,"TOPLEFT",20,-20,"队友头像增强",Duiyoutooltip)
fuFrame.Duiyou:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.UnitFrame.PartyMemberFrame.Plus=true;
		DuiyouFrame_Open();
	else
		PIG.UnitFrame.PartyMemberFrame.Plus=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
-----
fuFrame:HookScript("OnShow", function (self)
	if PIG.UnitFrame.PartyMemberFrame.Plus then
		fuFrame.Duiyou:SetChecked(true);
	end
end);
--=====================================
addonTable.UnitFrame_PartyMemberFrame = function()
	if PIG.UnitFrame.PartyMemberFrame.Plus then
		DuiyouFrame_Open();
	end
end