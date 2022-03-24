local _, addonTable = ...;
-------------------------------------------
local fuFrame=Pig_Options_RF_TAB_10_UI
--=======================================
local gongnengName = "专业/副本CD";
--顶部菜单
Pig_OptionsUI.zhuanyeCD = CreateFrame("Button",nil,Pig_OptionsUI, "UIPanelButtonTemplate");  
Pig_OptionsUI.zhuanyeCD:SetSize(110,28);
Pig_OptionsUI.zhuanyeCD:SetPoint("TOPLEFT",Pig_OptionsUI,"TOPLEFT",580,-24);
Pig_OptionsUI.zhuanyeCD:SetText(gongnengName);
Pig_OptionsUI.zhuanyeCD:Disable();
Pig_OptionsUI.zhuanyeCD:SetMotionScriptsWhileDisabled(true)
Pig_OptionsUI.zhuanyeCD:SetScript("OnClick", function ()
	Pig_OptionsUI:Hide();
	zhuanyeCDUI:SetFrameLevel(20)
	zhuanyeCDUI:Show();
end);
Pig_OptionsUI.zhuanyeCD:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	if not self:IsEnabled() then
		GameTooltip:AddLine(gongnengName.."尚未启用，请在功能模块内启用")
	end
	GameTooltip:Show();
end);
Pig_OptionsUI.zhuanyeCD:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide()
end);
--/////专业技能/副本CD监控////////////////
local Pig_SkillID={}
local Pig_ItemID={}
local zhuanyeIcon={136249,136240,134071}--裁缝/炼金/珠宝加工
local _, _, _, tocversion = GetBuildInfo()
if tocversion>29999 then
	zhuanyejinengshuaxinshijian="TRADE_SKILL_LIST_UPDATE"
	Pig_SkillID={

	};
	Pig_ItemID={
		
	};
elseif tocversion>19999 then
	zhuanyejinengshuaxinshijian="TRADE_SKILL_UPDATE"
	Pig_SkillID={
		--裁缝
		{26751,zhuanyeIcon[1],"spell"},
		{31373,zhuanyeIcon[1],"spell"},
		{36686,zhuanyeIcon[1],"spell"},
		--炼金
		{32766,zhuanyeIcon[2],"spell"},
		{32765,zhuanyeIcon[2],"spell"},
		{29688,zhuanyeIcon[2],"spell"},
		{28566,zhuanyeIcon[2],"spell"},
		{28567,zhuanyeIcon[2],"spell"},
		{28568,zhuanyeIcon[2],"spell"},
		{28569,zhuanyeIcon[2],"spell"},
		{28580,zhuanyeIcon[2],"spell"},
		{28581,zhuanyeIcon[2],"spell"},
		{28582,zhuanyeIcon[2],"spell"},
		{28583,zhuanyeIcon[2],"spell"},
		{28584,zhuanyeIcon[2],"spell"},
		{28585,zhuanyeIcon[2],"spell"},
		--珠宝加工
		{47280,zhuanyeIcon[3],"spell"},
	};
	Pig_ItemID={
		--筛盐器
		{19566,132836,15846},
	};
else
	zhuanyejinengshuaxinshijian="TRADE_SKILL_UPDATE"
	Pig_SkillID={
		{18560,zhuanyeIcon[1],"spell"},{11480,zhuanyeIcon[2],"spell"},{11479,zhuanyeIcon[2],"spell"},{17187,zhuanyeIcon[2],"spell"},{17559,zhuanyeIcon[2],"spell"},{17560,zhuanyeIcon[2],"spell"},{17561,zhuanyeIcon[2],"spell"},
		{17562,zhuanyeIcon[2],"spell"},{17563,zhuanyeIcon[2],"spell"},{17564,zhuanyeIcon[2],"spell"},{17565,zhuanyeIcon[2],"spell"},{17566,zhuanyeIcon[2],"spell"},{25146,zhuanyeIcon[2],"spell"},
	};
	Pig_ItemID={
		{19566,132836,15846},{13399,133651,11020},{21935,135863,17716},{26265,134249,21540},
	};
end
--格式化时间
local function disp_time(time)
	local days = floor(time/86400)
	local hours = floor(mod(time, 86400)/3600)
	local minutes = math.ceil(mod(time,3600)/60)
	if time>86400 then
		return format("|c00FF0000%d天%d时%d分|r",days,hours,minutes)
	elseif time<86400 and time>3600 then
		return format("|c00FFA500%d时%d分|r",hours,minutes)
	elseif time<3600 and time>60 then
		return format("|c00FFFF40%d分|r",minutes)
	end
end
--获取人物CD数据
local function huoqu_Skill()
	local fullName, realmXXX = UnitFullName("player")
	local className, classFilename, classId = UnitClass("player");
	local rPerc, gPerc, bPerc, argbHex = GetClassColor(classFilename);
	local renwuxinxi={fullName,realmXXX,argbHex,"juese"};
	----
	local yixueSkill={};--
	for i=1,#Pig_SkillID do
		if IsPlayerSpell(Pig_SkillID[i][1]) then---学会
			local jinengxinxi = {Pig_SkillID[i][1],Pig_SkillID[i][2],Pig_SkillID[i][3]}
			table.insert(yixueSkill,jinengxinxi)
		end
	end
	for Bagid=0,4,1 do
		local numberOfSlots = GetContainerNumSlots(Bagid);
		for i=1,numberOfSlots,1 do
			for ii=1,#Pig_ItemID,1 do
				if GetContainerItemID(Bagid, i)==Pig_ItemID[ii][3] then
					local kaishi, duration, isEnabled = GetContainerItemCooldown(Bagid, i)
					local Itemxinxi={Pig_ItemID[ii][1],Pig_ItemID[ii][2],Pig_ItemID[ii][3]};
					table.insert(yixueSkill,Itemxinxi)
				end
			end
		end
	end
	-----
	yixueSkill.PID=nil
	for i=1,#PIG["SkillFBCD"]["SkillCD"],1 do
		if PIG["SkillFBCD"]["SkillCD"][i][1][1]..PIG["SkillFBCD"]["SkillCD"][i][1][2]==fullName..realmXXX then
			yixueSkill.PID=i
		end
	end
	if yixueSkill.PID then
		for x=1,#yixueSkill do
			for xx=1,#PIG["SkillFBCD"]["SkillCD"][yixueSkill.PID][2] do
				if yixueSkill[x][1]==PIG["SkillFBCD"]["SkillCD"][yixueSkill.PID][2][xx][1] then
					yixueSkill[x][4]=PIG["SkillFBCD"]["SkillCD"][yixueSkill.PID][2][xx][4]
					yixueSkill[x][5]=PIG["SkillFBCD"]["SkillCD"][yixueSkill.PID][2][xx][5]
				end
			end
		end
		PIG["SkillFBCD"]["SkillCD"][yixueSkill.PID][2]=yixueSkill
	else
		local info={renwuxinxi,yixueSkill};
		table.insert(PIG["SkillFBCD"]["SkillCD"],info)
	end
end
----更新滚动区域数据
local hang_Height,hang_NUM  = 19, 18;
local function gengxin_Skill(self)
	for x = 1, hang_NUM do
		_G["SK_list_kong_"..x]:SetWidth(18);
		_G["SK_list_Tex_"..x]:SetWidth(16);
    	_G["SK_list_name_"..x]:SetText();
    	_G["SK_list_time_"..x]:SetText();
    	_G["SK_list_Tex_"..x]:SetTexture();
		_G["SK_list_"..x]:SetScript("OnEnter", function ()
			GameTooltip:ClearLines();
		end);
    end
   	local ItemsSpell={};
   	for i=1,#PIG["SkillFBCD"]["SkillCD"],1 do
   		local renwu={"|c"..PIG["SkillFBCD"]["SkillCD"][i][1][3]..PIG["SkillFBCD"]["SkillCD"][i][1][1].."-"..PIG["SkillFBCD"]["SkillCD"][i][1][2].."|r",PIG["SkillFBCD"]["SkillCD"][i][1][4]}
   		table.insert(ItemsSpell,renwu)
   		for ii=1,#PIG["SkillFBCD"]["SkillCD"][i][2] do
			table.insert(ItemsSpell,PIG["SkillFBCD"]["SkillCD"][i][2][ii])
		end
   	end
   	local ItemsNum = #ItemsSpell;
	if ItemsNum>0 then
	    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
	    local offset = FauxScrollFrame_GetOffset(self);
	    if ItemsNum<hang_NUM then
	    	New_hang_NUM=ItemsNum;
	    else
	    	New_hang_NUM=hang_NUM;
	    end
	    for d = 1, New_hang_NUM do
			local dangqian = d+offset;
			if ItemsSpell[dangqian][2]=="juese" then
				_G["SK_list_kong_"..d]:SetWidth(0.2);
				_G["SK_list_Tex_"..d]:SetWidth(0.2);		
				_G["SK_list_name_"..d]:SetText(ItemsSpell[dangqian][1]);
				_G["SK_list_time_"..d]:SetText();
			else
				if ItemsSpell[dangqian][3]=="spell" then
					_G["SK_list_Tex_"..d]:SetTexture(ItemsSpell[dangqian][2]);
					local Name= GetSpellInfo(ItemsSpell[dangqian][1])
					_G["SK_list_name_"..d]:SetText(Name);
					_G["SK_list_"..d]:SetScript("OnEnter", function ()
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(_G["SK_list_"..d], "ANCHOR_CURSOR");
						GameTooltip:SetHyperlink("spell:"..ItemsSpell[dangqian][1])
					end);
					_G["SK_list_"..d]:SetScript("OnLeave", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
				else
					_G["SK_list_Tex_"..d]:SetTexture(ItemsSpell[dangqian][2]);
					local Name= GetItemInfo(ItemsSpell[dangqian][3])
					_G["SK_list_name_"..d]:SetText(Name);
					_G["SK_list_"..d]:SetScript("OnEnter", function ()
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(_G["SK_list_"..d], "ANCHOR_CURSOR");
						GameTooltip:SetHyperlink("item:"..ItemsSpell[dangqian][3])
					end);
					_G["SK_list_"..d]:SetScript("OnLeave", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
				end
				if ItemsSpell[dangqian][5] then
					if ItemsSpell[dangqian][5]==0 then
						_G["SK_list_time_"..d]:SetText("|cFF00FF00 已就绪！|r");
					else
						local sitng=ItemsSpell[dangqian][4]+ItemsSpell[dangqian][5]-GetTime();
						if sitng>0 then
							_G["SK_list_time_"..d]:SetText(" "..disp_time(sitng));
						else
							_G["SK_list_time_"..d]:SetText("|cFF00FF00 已就绪！|r");
						end
					end
				else
					_G["SK_list_time_"..d]:SetText("|cFFff0000 未知|r");
				end
			end
		end
	end
end
--
local function xianshitishi()
	if not InCombatLockdown() then
		local youlengquewancCD=false;
		for i=1,#PIG["SkillFBCD"]["SkillCD"],1 do
			if #PIG["SkillFBCD"]["SkillCD"][i][2]>0 then
				for ii=1,#PIG["SkillFBCD"]["SkillCD"][i][2],1 do
					if PIG["SkillFBCD"]["SkillCD"][i][2][ii][5] then
						if PIG["SkillFBCD"]["SkillCD"][i][2][ii][5]~=0 then
							local sitng=PIG["SkillFBCD"]["SkillCD"][i][2][ii][4]+PIG["SkillFBCD"]["SkillCD"][i][2][ii][5]-GetTime();
							if sitng<=0 then
								youlengquewancCD=true;
							end
						else
							youlengquewancCD=true;
						end
					end
				end
			end
		end
		if youlengquewancCD then 
			GameTimeFrame.Texture:SetAlpha(1); 
		else
			GameTimeFrame.Texture:SetAlpha(0);
		end
	end
	C_Timer.After(2,xianshitishi);
end
--===========================================================================
--副本CD监控
local function huoqu_Fuben()	---获取副本CD
	local fullName, realmXXX = UnitFullName("player")
	local className, classFilename, classId = UnitClass("player");
	local rPerc, gPerc, bPerc, argbHex = GetClassColor(classFilename);
	local renwuxinxi={fullName,realmXXX,argbHex,"juese"};
	local fubenCDinfo={};
	local numInstances = GetNumSavedInstances();
	if numInstances>0 then
		for id = 1, numInstances, 1 do				
			local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(id)
			table.insert(fubenCDinfo,{name,GetTime(),reset})
		end
	end
	fubenCDinfo.cunzaiYN = true
	for id=1,#PIG["SkillFBCD"]["FubenCD"],1 do
		if PIG["SkillFBCD"]["FubenCD"][id][1][1]..PIG["SkillFBCD"]["FubenCD"][id][1][2]==fullName..realmXXX then
			PIG["SkillFBCD"]["FubenCD"][id][2]=fubenCDinfo;
			fubenCDinfo.cunzaiYN = false
			break
		end
	end
	if fubenCDinfo.cunzaiYN then
		local info={renwuxinxi,fubenCDinfo};
		table.insert(PIG["SkillFBCD"]["FubenCD"],info)
	end
end
-------滚动
local function gengxin_Fuben(self)
	for id = 1, hang_NUM, 1 do
		_G["fubenCD_list_"..id]:SetWidth(14);	
		_G["fubenCD_list_"..id].TXT:SetText();
	end
   	local cdmulu={};
   	for i=1,#PIG["SkillFBCD"]["FubenCD"],1 do
   		local renwu={"|c"..PIG["SkillFBCD"]["FubenCD"][i][1][3]..PIG["SkillFBCD"]["FubenCD"][i][1][1].."-"..PIG["SkillFBCD"]["FubenCD"][i][1][2].."|r",PIG["SkillFBCD"]["FubenCD"][i][1][4]}
   		table.insert(cdmulu,renwu)
   		for ii=1,#PIG["SkillFBCD"]["FubenCD"][i][2] do
			table.insert(cdmulu,PIG["SkillFBCD"]["FubenCD"][i][2][ii])
		end
   	end
	local ItemsNum = #cdmulu;
	if ItemsNum>0 then
	    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
	    local offset = FauxScrollFrame_GetOffset(self);
	    if ItemsNum<hang_NUM then
	    	New_hang_NUM=ItemsNum;
	    else
	    	New_hang_NUM=hang_NUM;
	    end
	    for d = 1, New_hang_NUM do
			local dangqian = d+offset;
			if cdmulu[dangqian][2]=="juese" then
				_G["fubenCD_list_"..d]:SetWidth(0.2);
				_G["fubenCD_list_"..d].TXT:SetText(cdmulu[dangqian][1]);
			else
				local shengyu=cdmulu[dangqian][2]+cdmulu[dangqian][3]-GetTime();
				if shengyu>0 then
					local txt=cdmulu[dangqian][1].." "..disp_time(shengyu)
					_G["fubenCD_list_"..d].TXT:SetText(txt);
				else
					local txt=cdmulu[dangqian][1].."|cFF00FF00 新CD！|r";
					_G["fubenCD_list_"..d].TXT:SetText(txt);
				end
			end
		end
	end
end
--创建监控面板===================================================
local function Add_Skill_CD()
	if zhuanyeCDUI==nil then
		--显示框架
		local Width,Height = 595,440;
		local zhuanyeCD = CreateFrame("Frame", "zhuanyeCDUI", UIParent) ;
		zhuanyeCD:SetSize(Width,Height);
		zhuanyeCD:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
		zhuanyeCD:SetMovable(true)
		zhuanyeCD:EnableMouse(true)
		zhuanyeCD:SetClampedToScreen(true)
		zhuanyeCD:Hide()
		tinsert(UISpecialFrames,"zhuanyeCDUI");

		zhuanyeCD:RegisterForDrag("LeftButton")
		zhuanyeCD:SetScript("OnDragStart", zhuanyeCD.StartMoving)
		zhuanyeCD:SetScript("OnDragStop", zhuanyeCD.StopMovingOrSizing)
		zhuanyeCD.title = zhuanyeCD:CreateFontString();
		zhuanyeCD.title:SetPoint("TOP", zhuanyeCD, "TOP", 0, -3);
		zhuanyeCD.title:SetFontObject(GameFontNormalSmall);
		zhuanyeCD.title:SetText("专业技能/副本CD监控");
		zhuanyeCD.Close = CreateFrame("Button",nil,zhuanyeCD, "UIPanelCloseButton");  
		zhuanyeCD.Close:SetSize(32,32);
		zhuanyeCD.Close:SetPoint("TOPRIGHT",zhuanyeCD,"TOPRIGHT",2,5);

		zhuanyeCD.help = zhuanyeCD:CreateTexture(nil, "BORDER");
		zhuanyeCD.help:SetTexture("interface/gossipframe/activequesticon.blp");
		zhuanyeCD.help:ClearAllPoints();
		zhuanyeCD.help:SetPoint("TOPRIGHT",zhuanyeCD,"TOPRIGHT",-30,-3);

		zhuanyeCD.Texture_L = zhuanyeCD:CreateTexture(nil, "BORDER");
		zhuanyeCD.Texture_L:SetTexture("interface/worldmap/ui-worldmapsmall-left.blp");
		zhuanyeCD.Texture_L:ClearAllPoints();
		zhuanyeCD.Texture_L:SetPoint("TOPLEFT", 0, 0);
		zhuanyeCD.Texture_R = zhuanyeCD:CreateTexture(nil, "BORDER");
		zhuanyeCD.Texture_R:SetTexture("interface/worldmap/ui-worldmapsmall-right.blp");
		zhuanyeCD.Texture_R:ClearAllPoints();
		zhuanyeCD.Texture_R:SetPoint("TOPLEFT", zhuanyeCD.Texture_L, "TOPRIGHT", 0, 0);

		zhuanyeCD.Neirong = CreateFrame("Frame", nil, zhuanyeCD,"BackdropTemplate") ;
		zhuanyeCD.Neirong:SetSize(Width-14,386);
		zhuanyeCD.Neirong:SetBackdrop({ bgFile = "interface/characterframe/ui-party-background.blp"});
		zhuanyeCD.Neirong:SetBackdropColor(0, 0, 0, 0.8);
		zhuanyeCD.Neirong:SetPoint("TOP", zhuanyeCD, "TOP", 0, -22);

		zhuanyeCD.xian1 = zhuanyeCD.Neirong:CreateLine()
		zhuanyeCD.xian1:SetColorTexture(1,1,1,0.2)
		zhuanyeCD.xian1:SetThickness(1.2);
		zhuanyeCD.xian1:SetStartPoint("TOP",0,0)
		zhuanyeCD.xian1:SetEndPoint("BOTTOM",0,0)
		zhuanyeCD.xian2 = zhuanyeCD.Neirong:CreateLine()
		zhuanyeCD.xian2:SetColorTexture(1,1,1,0.3)
		zhuanyeCD.xian2:SetThickness(1.2);
		zhuanyeCD.xian2:SetStartPoint("TOPLEFT",0,-24)
		zhuanyeCD.xian2:SetEndPoint("TOPRIGHT",0,-24)
		-------------------
		zhuanyeCD.Neirong.titleL = zhuanyeCD.Neirong:CreateFontString();
		zhuanyeCD.Neirong.titleL:SetPoint("TOPLEFT", zhuanyeCD.Neirong, "TOPLEFT", 50, -4);
		zhuanyeCD.Neirong.titleL:SetFontObject(GameFontGreen);
		zhuanyeCD.Neirong.titleL:SetText("正在冷却中的专业技能");

		zhuanyeCD.Neirong.titleR = zhuanyeCD.Neirong:CreateFontString();
		zhuanyeCD.Neirong.titleR:SetPoint("TOPLEFT", zhuanyeCD.Neirong, "TOPLEFT", 350, -4);
		zhuanyeCD.Neirong.titleR:SetFontObject(GameFontGreen);
		zhuanyeCD.Neirong.titleR:SetText("正在冷却中的副本");
		--下方提示
		zhuanyeCD.tishi = zhuanyeCD:CreateFontString();
		zhuanyeCD.tishi:SetPoint("BOTTOM",zhuanyeCD,"BOTTOM",26,14);
		zhuanyeCD.tishi:SetFont(ChatFontNormal:GetFont(), 12,"OUTLINE")
		zhuanyeCD.tishi:SetText("\124cff00ff00第一次使用时请打开专业面板获取一次CD！\124r");
		zhuanyeCD.tishiTex = zhuanyeCD:CreateTexture(nil, "ARTWORK");
		zhuanyeCD.tishiTex:SetTexture("interface/common/help-i.blp");
		zhuanyeCD.tishiTex:SetPoint("RIGHT", zhuanyeCD.tishi, "LEFT", 0, 0);
		zhuanyeCD.tishiTex:SetSize(26,26);

		---专业CD列表
		zhuanyeCD.Neirong.SkillCD = CreateFrame("Frame", nil, zhuanyeCD.Neirong);
		zhuanyeCD.Neirong.SkillCD:SetSize((Width-34)/2,360);
		zhuanyeCD.Neirong.SkillCD:SetPoint("TOPLEFT", zhuanyeCD.Neirong, "TOPLEFT", 2, -28);
		------------------
		zhuanyeCD.Neirong.SkillCD.Scroll = CreateFrame("ScrollFrame",nil,zhuanyeCD.Neirong.SkillCD, "FauxScrollFrameTemplate");  
		zhuanyeCD.Neirong.SkillCD.Scroll:SetPoint("TOPLEFT",zhuanyeCD.Neirong.SkillCD,"TOPLEFT",0,2);
		zhuanyeCD.Neirong.SkillCD.Scroll:SetPoint("BOTTOMRIGHT",zhuanyeCD.Neirong.SkillCD,"BOTTOMRIGHT",-16,2);
		zhuanyeCD.Neirong.SkillCD.Scroll:SetScript("OnVerticalScroll", function(self, offset)
		    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxin_Skill)
		end)
		for id = 1, hang_NUM, 1 do
			local SK_list = CreateFrame("Frame", "SK_list_"..id, zhuanyeCD.Neirong.SkillCD.Scroll:GetParent());
			SK_list:SetSize(zhuanyeCD.Neirong.SkillCD:GetWidth()-18,hang_Height);
			if id==1 then
				SK_list:SetPoint("TOPLEFT", zhuanyeCD.Neirong.SkillCD.Scroll, "TOPLEFT", 0, -1);
			else
				SK_list:SetPoint("TOPLEFT", _G["SK_list_"..(id-1)], "BOTTOMLEFT", 0, -1);
			end
			local SK_list_kong = CreateFrame("Frame", "SK_list_kong_"..id, SK_list);
			SK_list_kong:SetSize(18,hang_Height);
			SK_list_kong:SetPoint("LEFT", SK_list, "LEFT", 0, 0);
			local SK_list_Tex = SK_list:CreateTexture("SK_list_Tex_"..id, "BORDER");
			SK_list_Tex:SetSize(16,16);
			SK_list_Tex:SetPoint("LEFT", SK_list_kong, "RIGHT", 0, 0);			
			local SK_list_name = SK_list:CreateFontString("SK_list_name_"..id);
			SK_list_name:SetPoint("LEFT", SK_list_Tex, "RIGHT", 0, 0);
			SK_list_name:SetFontObject(ChatFontNormal);
			local SK_list_time = SK_list:CreateFontString("SK_list_time_"..id);
			SK_list_time:SetPoint("LEFT", SK_list_name, "RIGHT", 0, 0);
			SK_list_time:SetFontObject(ChatFontNormal);
		end
		--小地图提示图标
		GameTimeFrame.Texture = GameTimeFrame:CreateTexture("GameTimeFrameCD1", "OVERLAY");
		GameTimeFrame.Texture:SetTexture("interface/common/help-i.blp");
		GameTimeFrame.Texture:SetSize(48,48);
		GameTimeFrame.Texture:SetPoint("CENTER",GameTimeFrame,"CENTER",0,0);
		GameTimeFrame.Texture:SetAlpha(0);
		C_Timer.After(4,xianshitishi);

		--副本CD列表===================================================
		zhuanyeCD.Neirong.fubenCD = CreateFrame("Frame", nil, zhuanyeCD.Neirong);
		zhuanyeCD.Neirong.fubenCD:SetSize((Width-34)/2,360);
		zhuanyeCD.Neirong.fubenCD:SetPoint("TOPRIGHT", zhuanyeCD.Neirong, "TOPRIGHT", -6, -28);
		------
		zhuanyeCD.Neirong.fubenCD.Scroll = CreateFrame("ScrollFrame",nil,zhuanyeCD.Neirong.fubenCD, "FauxScrollFrameTemplate");  
		zhuanyeCD.Neirong.fubenCD.Scroll:SetPoint("TOPLEFT",zhuanyeCD.Neirong.fubenCD,"TOPLEFT",0,2);
		zhuanyeCD.Neirong.fubenCD.Scroll:SetPoint("BOTTOMRIGHT",zhuanyeCD.Neirong.fubenCD,"BOTTOMRIGHT",-16,2);
		zhuanyeCD.Neirong.fubenCD.Scroll:SetScript("OnVerticalScroll", function(self, offset)
		    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxin_Fuben)
		end)
		for id = 1, hang_NUM, 1 do
			local fubenCD_list = CreateFrame("Frame", "fubenCD_list_"..id, zhuanyeCD.Neirong.fubenCD.Scroll:GetParent());
			fubenCD_list:SetSize(14,hang_Height);
			if id==1 then
				fubenCD_list:SetPoint("TOPLEFT", zhuanyeCD.Neirong.fubenCD.Scroll, "TOPLEFT", 0, 0);
			else
				fubenCD_list:SetPoint("TOPLEFT", _G["fubenCD_list_"..id-1], "BOTTOMLEFT", 0, -1);
			end
			fubenCD_list.TXT = fubenCD_list:CreateFontString();
			fubenCD_list.TXT:SetPoint("LEFT", fubenCD_list, "RIGHT", 0, 0);
			fubenCD_list.TXT:SetFontObject(ChatFontNormal);
		end
		--注册CD监测事件
		zhuanyeCDUI:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED","player");              
		zhuanyeCDUI:RegisterEvent("UPDATE_INSTANCE_INFO");
		zhuanyeCDUI:SetScript("OnEvent", function(self,event,arg1,_,arg3)
			if event=="UNIT_SPELLCAST_SUCCEEDED" then
				for s=1,#Pig_SkillID,1 do
					if arg3==Pig_SkillID[s][1] then
						for k=1,#PIG["SkillFBCD"]["SkillCD"],1 do
							local fullName, realmXXX = UnitFullName("player")
							if PIG["SkillFBCD"]["SkillCD"][k][1][1]..PIG["SkillFBCD"]["SkillCD"][k][1][2]==fullName..realmXXX then
								for kk=1,#PIG["SkillFBCD"]["SkillCD"][k][2],1 do
									if PIG["SkillFBCD"]["SkillCD"][k][2][kk][1]==arg3 then
										local function gengxinSPCD1()
											local start, duration = GetSpellCooldown(arg3);
											PIG["SkillFBCD"]["SkillCD"][k][2][kk][4] =start;
											PIG["SkillFBCD"]["SkillCD"][k][2][kk][5] =duration;
											gengxin_Skill(zhuanyeCD.Neirong.SkillCD.Scroll);
										end
										C_Timer.After(1, gengxinSPCD1);								
									end
								end
							end
						end		
					end
				end
				---
				for i=1,#Pig_ItemID,1 do
					if arg3==Pig_ItemID[i][1] then
						local fullName, realmXXX = UnitFullName("player")
						for k=1,#PIG["SkillFBCD"]["SkillCD"],1 do
							if PIG["SkillFBCD"]["SkillCD"][k][1][1]..PIG["SkillFBCD"]["SkillCD"][k][1][2]==fullName..realmXXX then
								for kk=1,#PIG["SkillFBCD"]["SkillCD"][k][2],1 do
									if PIG["SkillFBCD"]["SkillCD"][k][2][kk][1]==arg3 then
										local function gengxinSPCD3()
											for Bagid=0,4,1 do
												local numberOfSlots = GetContainerNumSlots(Bagid);
												for sol=1,numberOfSlots,1 do
													if GetContainerItemID(Bagid, sol)==Pig_ItemID[i][3] then
														local startTime, duration = GetContainerItemCooldown(Bagid, sol)
														PIG["SkillFBCD"]["SkillCD"][k][2][kk][4] =startTime;
														PIG["SkillFBCD"]["SkillCD"][k][2][kk][5] =duration;
														gengxin_Skill(zhuanyeCD.Neirong.SkillCD.Scroll);
													end
												end
											end
										end
										C_Timer.After(1, gengxinSPCD3);
									end
								end
							end
						end
					end
				end
			end
			if event=="UPDATE_INSTANCE_INFO" then
				huoqu_Fuben()
				gengxin_Fuben(zhuanyeCD.Neirong.fubenCD.Scroll);
			end
		end)
		---更新专业CD
		local function zhixingdakaigengxin()
			local fullName, realmXXX = UnitFullName("player")
			for x=1,#PIG["SkillFBCD"]["SkillCD"],1 do
				if PIG["SkillFBCD"]["SkillCD"][x][1][1]..PIG["SkillFBCD"]["SkillCD"][x][1][2]==fullName..realmXXX then
					for xx=1,#PIG["SkillFBCD"]["SkillCD"][x][2] do
						local chazhaoName= GetSpellInfo(PIG["SkillFBCD"]["SkillCD"][x][2][xx][1])
						for j=1,GetNumTradeSkills() do
							local Skillname= GetTradeSkillInfo(j);
							if Skillname==chazhaoName then
								local cd = GetTradeSkillCooldown(j);
								if cd then
									PIG["SkillFBCD"]["SkillCD"][x][2][xx][4]=GetTime()
									PIG["SkillFBCD"]["SkillCD"][x][2][xx][5]=cd
								else
									PIG["SkillFBCD"]["SkillCD"][x][2][xx][4]=0
									PIG["SkillFBCD"]["SkillCD"][x][2][xx][5]=0
								end
								break
							end
						end
					end
					break
				end
			end
		end
		local jiazaizhuanyeFrame = CreateFrame("FRAME")
		jiazaizhuanyeFrame:RegisterEvent(zhuanyejinengshuaxinshijian)
		jiazaizhuanyeFrame:SetScript("OnEvent", function(self, event, arg1)
			zhixingdakaigengxin()
		end)
		--点击后显示/隐藏
		zhuanyeCDUI:HookScript("OnShow", function ()
			RequestRaidInfo()
			huoqu_Skill()
			gengxin_Skill(zhuanyeCD.Neirong.SkillCD.Scroll);
		end)
		GameTimeFrame:HookScript("OnMouseDown", function ()
			if zhuanyeCDUI:IsShown() then
				zhuanyeCDUI:Hide();
			else
				zhuanyeCDUI:SetFrameLevel(20)
				zhuanyeCDUI:Show();
			end
		end)
	end
end

--////////////////////////////////////////////
--添加快捷打开按钮
local function ADD_SkillfubenCD_but()
	PIG["SkillFBCD"]=PIG["SkillFBCD"] or addonTable.Default["SkillFBCD"]
	if PIG["SkillFBCD"]["AddBut"]=="ON" then
		fuFrame_Skill_ADD_UI:SetChecked(true);
	end
	if PIG['Classes']['Assistant']=="ON" and PIG["SkillFBCD"]["Open"]=="ON" then
		fuFrame_Skill_ADD_UI:Enable();
	else
		fuFrame_Skill_ADD_UI:Disable();
	end
	if PIG['Classes']['Assistant']=="ON" and PIG["SkillFBCD"]["Open"]=="ON" and PIG["SkillFBCD"]["AddBut"]=="ON" then
		if SkillFuben_but_UI==nil then
			local aciWidth = ActionButton1:GetWidth()
			local Width,Height=aciWidth,aciWidth;
			local SkillFuben_but = CreateFrame("Button", "SkillFuben_but_UI", Classes_UI.nr);
			SkillFuben_but:SetNormalTexture("interface/icons/inv_misc_book_03.blp");
			SkillFuben_but:SetHighlightTexture(130718);
			SkillFuben_but:SetSize(Width-1,Height-1);
			local geshu = {Classes_UI.nr:GetChildren()};
			if #geshu==0 then
				SkillFuben_but:SetPoint("LEFT",Classes_UI.nr,"LEFT",0,0);
			else
				local Width=Width+2
				SkillFuben_but:SetPoint("LEFT",Classes_UI.nr,"LEFT",#geshu*Width-Width,0);
			end
			SkillFuben_but:RegisterForClicks("LeftButtonUp","RightButtonUp");

			SkillFuben_but:SetScript("OnEnter", function ()
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(SkillFuben_but, "ANCHOR_TOPLEFT",2,4);
				GameTooltip:AddLine("左击-|cff00FFFF打开"..gongnengName.."监控|r")
				GameTooltip:Show();
			end);
			SkillFuben_but:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			SkillFuben_but.Border = SkillFuben_but:CreateTexture(nil, "BORDER");
			SkillFuben_but.Border:SetTexture(130841);
			SkillFuben_but.Border:ClearAllPoints();
			SkillFuben_but.Border:SetPoint("TOPLEFT",SkillFuben_but,"TOPLEFT",-Width*0.38,Height*0.39);
			SkillFuben_but.Border:SetPoint("BOTTOMRIGHT",SkillFuben_but,"BOTTOMRIGHT",Width*0.4,-Height*0.4);

			SkillFuben_but.Down = SkillFuben_but:CreateTexture(nil, "OVERLAY");
			SkillFuben_but.Down:SetTexture(130839);
			SkillFuben_but.Down:SetAllPoints(SkillFuben_but)
			SkillFuben_but.Down:Hide();
			SkillFuben_but:SetScript("OnMouseDown", function (self)
				self.Down:Show();
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			SkillFuben_but:SetScript("OnMouseUp", function (self)
				self.Down:Hide();
			end);
			SkillFuben_but:SetScript("OnClick", function()
				if zhuanyeCDUI:IsShown() then
					zhuanyeCDUI:Hide();
				else
					zhuanyeCDUI:SetFrameLevel(20)
					zhuanyeCDUI:Show();
				end
			end);
		end
		addonTable.Classes_gengxinkuanduinfo()
	end
end
addonTable.ADD_SkillFubenCD_but=ADD_SkillfubenCD_but
--------
fuFrame.Skill_ADD = CreateFrame("CheckButton", "fuFrame_Skill_ADD_UI", fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Skill_ADD:SetSize(28,30);
fuFrame.Skill_ADD:SetHitRectInsets(0,-100,0,0);
fuFrame.Skill_ADD:SetMotionScriptsWhileDisabled(true) 
fuFrame.Skill_ADD:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-12);
fuFrame.Skill_ADD.Text:SetText("添加"..gongnengName.."监控到快捷按钮");
fuFrame.Skill_ADD.tooltip = "添加"..gongnengName.."监控到快捷按钮中，方便打开关闭。\n|cff00FF00注意：此功能需先打开快捷按钮功能|r";
fuFrame.Skill_ADD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["SkillFBCD"]["AddBut"]="ON"
		ADD_SkillfubenCD_but()
	else
		PIG["SkillFBCD"]["AddBut"]="OFF"
		Pig_Options_RLtishi_UI:Show();
	end
end);
-----------------
fuFrame.Skill_FB = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Skill_FB:SetSize(28,30);
fuFrame.Skill_FB:SetHitRectInsets(0,-100,0,0);
fuFrame.Skill_FB:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-12);
fuFrame.Skill_FB.Text:SetText(gongnengName.."监控");
fuFrame.Skill_FB.tooltip = "创建一个监控所有角色"..gongnengName.."界面！\r|cff00ff00点击小地图上的太阳月亮图标打开界面|r\r专业技能冷却完成后会在此图标上有提示！";
fuFrame.Skill_FB:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["SkillFBCD"]["Open"]="ON";
		Pig_OptionsUI.zhuanyeCD:Enable();
		fuFrame_Skill_ADD_UI:Enable()
		ADD_SkillfubenCD_but()
		Add_Skill_CD();
		huoqu_Skill()
		RequestRaidInfo()
	else
		PIG["SkillFBCD"]["Open"]="OFF";
		Pig_OptionsUI.zhuanyeCD:Disable();
		fuFrame_Skill_ADD_UI:Disable()
		Pig_Options_RLtishi_UI:Show()
	end
end);
--=============================================
addonTable.Assistant_Skill_FB = function()
	if PIG["SkillFBCD"]["Open"]=="ON" then
		fuFrame.Skill_FB:SetChecked(true);
		Pig_OptionsUI.zhuanyeCD:Enable();
		C_Timer.After(1, Add_Skill_CD)
		C_Timer.After(3, huoqu_Skill)
		C_Timer.After(6, huoqu_Skill)
		RequestRaidInfo()
	end
end