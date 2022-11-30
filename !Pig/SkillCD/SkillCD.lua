local _, addonTable = ...;
-------------------------------------------
local fuFrame=List_R_F_2_8
local _, _, _, tocversion = GetBuildInfo()
--=======================================
local ADD_Frame=addonTable.ADD_Frame
local ADD_Modbutton=addonTable.ADD_Modbutton
local GnName,GnUI = "专业CD","zhuanyeCDUI";
local FrameLevel=10
local Options_zhuanyeCD = ADD_Modbutton(GnName,GnUI,FrameLevel,3)
--/////专业技能/副本CD监控////////////////
local Pig_SkillID={}
local Pig_ItemID={}
local zhuanyeIcon={136249,136240,134071,237171}--裁缝/炼金/珠宝加工/铭文
if tocversion<20000 then
	zhuanyejinengshuaxinshijian="TRADE_SKILL_UPDATE"
	Pig_SkillID={
		{18560,zhuanyeIcon[1],"spell"},{11480,zhuanyeIcon[2],"spell"},{11479,zhuanyeIcon[2],"spell"},{17187,zhuanyeIcon[2],"spell"},{17559,zhuanyeIcon[2],"spell"},{17560,zhuanyeIcon[2],"spell"},{17561,zhuanyeIcon[2],"spell"},
		{17562,zhuanyeIcon[2],"spell"},{17563,zhuanyeIcon[2],"spell"},{17564,zhuanyeIcon[2],"spell"},{17565,zhuanyeIcon[2],"spell"},{17566,zhuanyeIcon[2],"spell"},{25146,zhuanyeIcon[2],"spell"},
	};
	Pig_ItemID={
		{19566,132836,15846},{13399,133651,11020},{21935,135863,17716},{26265,134249,21540},
	};
elseif tocversion<30000 then
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
elseif tocversion<40000 then
	zhuanyejinengshuaxinshijian="TRADE_SKILL_UPDATE"
	Pig_SkillID={
		--裁缝

		--炼金
		{60893,zhuanyeIcon[2],"spell"},
		--珠宝加工
		{47280,zhuanyeIcon[3],"spell"},
		{62242,zhuanyeIcon[3],"spell"},
		--铭文
		{61177,zhuanyeIcon[4],"spell"},
	};
	Pig_ItemID={
		--筛盐器
		{19566,132836,15846},
	};
else
	zhuanyejinengshuaxinshijian="TRADE_SKILL_LIST_UPDATE"
	Pig_SkillID={

	};
	Pig_ItemID={
		
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
--获取当前所学专业数据
local function huoqu_Skill()
	local fullName, realmXXX = UnitFullName("player")
	local className, classFilename, classId = UnitClass("player");
	local rPerc, gPerc, bPerc, argbHex = GetClassColor(classFilename);
	local renwuxinxi={fullName,realmXXX,{rPerc, gPerc, bPerc},"juese"};
	----
	local yixueSkill={};
	for i=1,#Pig_SkillID do
		if IsPlayerSpell(Pig_SkillID[i][1]) then---学会
			local jinengxinxi = {Pig_SkillID[i][1],Pig_SkillID[i][2],Pig_SkillID[i][3]}
			table.insert(yixueSkill,jinengxinxi)
		end
	end
	if tocversion<100000 then
		for Bagid=0,4,1 do
			local numberOfSlots = GetContainerNumSlots(Bagid);
			for i=1,numberOfSlots,1 do
				for ii=1,#Pig_ItemID,1 do
					if GetContainerItemID(Bagid, i)==Pig_ItemID[ii][3] then--有物品
						local Itemxinxi={Pig_ItemID[ii][1],Pig_ItemID[ii][2],Pig_ItemID[ii][3]};
						table.insert(yixueSkill,Itemxinxi)
					end
				end
			end
		end
	else
		for Bagid=0,4,1 do
			local numberOfSlots = C_Container.GetContainerNumSlots(Bagid);
			for i=1,numberOfSlots,1 do
				for ii=1,#Pig_ItemID,1 do
					if C_Container.GetContainerItemID(Bagid, i)==Pig_ItemID[ii][3] then--有物品
						local Itemxinxi={Pig_ItemID[ii][1],Pig_ItemID[ii][2],Pig_ItemID[ii][3]};
						table.insert(yixueSkill,Itemxinxi)
					end
				end
			end
		end
	end
	-----
	local shujuyaun = PIG["SkillFBCD"]["SkillCD"]
	for i=1,#shujuyaun,1 do
		if shujuyaun[i][1][1]..shujuyaun[i][1][2]==fullName..realmXXX then
			return
		end
	end
	local Skillinfo={renwuxinxi,yixueSkill};
	table.insert(shujuyaun,Skillinfo)
end
----
local hang_Height,hang_NUM  = 20, 18;
local function gengxin_Skill(self)
	for x = 1, hang_NUM do
		_G["SK_list_"..x]:Hide();
		_G["SK_list_"..x].del:Hide();
		_G["SK_list_"..x].kong:SetWidth(18);
		_G["SK_list_"..x].Tex:SetWidth(16);
		_G["SK_list_"..x].Tex:SetTexture();
    	_G["SK_list_"..x].name:SetText();
    	_G["SK_list_"..x].time:SetText();
    end
   	local ItemsSpell={};
   	local shujuyaun = PIG["SkillFBCD"]["SkillCD"]
   	for i=1,#shujuyaun,1 do
   		local renwu={shujuyaun[i][1][1].."-"..shujuyaun[i][1][2],shujuyaun[i][1][4],shujuyaun[i][1][3]}
   		table.insert(ItemsSpell,renwu)
   		for ii=1,#shujuyaun[i][2] do
			table.insert(ItemsSpell,shujuyaun[i][2][ii])
		end
   	end
   	local ItemsNum = #ItemsSpell;
	if ItemsNum>0 then
	    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
	    local offset = FauxScrollFrame_GetOffset(self);
	    for x = 1, hang_NUM do
			local dangqian = x+offset;
			if ItemsSpell[dangqian] then
				_G["SK_list_"..x]:Show();
				if ItemsSpell[dangqian][2]=="juese" then
					_G["SK_list_"..x].del:Show();
					_G["SK_list_"..x].del:SetID(dangqian);
					_G["SK_list_"..x].kong:SetWidth(0.2);
					_G["SK_list_"..x].Tex:SetWidth(0.2);		
					_G["SK_list_"..x].name:SetText(ItemsSpell[dangqian][1]);
					_G["SK_list_"..x].name:SetTextColor(ItemsSpell[dangqian][3][1], ItemsSpell[dangqian][3][2], ItemsSpell[dangqian][3][3], 1);
					_G["SK_list_"..x].time:SetText();
				else
					if ItemsSpell[dangqian][3]=="spell" then
						_G["SK_list_"..x].Tex:SetTexture(ItemsSpell[dangqian][2]);
						local Name= GetSpellInfo(ItemsSpell[dangqian][1])
						_G["SK_list_"..x].name:SetText(Name);
						_G["SK_list_"..x]:SetScript("OnEnter", function (self)
							GameTooltip:ClearLines();
							GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
							GameTooltip:SetHyperlink("spell:"..ItemsSpell[dangqian][1])
						end);
						_G["SK_list_"..x]:SetScript("OnLeave", function ()
							GameTooltip:ClearLines();
							GameTooltip:Hide() 
						end);
					else
						_G["SK_list_"..x].Tex:SetTexture(ItemsSpell[dangqian][2]);
						local Name= GetItemInfo(ItemsSpell[dangqian][3])
						_G["SK_list_"..x].name:SetText(Name);
						_G["SK_list_"..x]:SetScript("OnEnter", function (self)
							GameTooltip:ClearLines();
							GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
							GameTooltip:SetHyperlink("item:"..ItemsSpell[dangqian][3])
						end);
						_G["SK_list_"..x]:SetScript("OnLeave", function ()
							GameTooltip:ClearLines();
							GameTooltip:Hide() 
						end);
					end
					if ItemsSpell[dangqian][5] then
						if ItemsSpell[dangqian][5]==0 then
							_G["SK_list_"..x].time:SetText("|cFF00FF00 已就绪！|r");
						else
							local sitng=ItemsSpell[dangqian][4]+ItemsSpell[dangqian][5]-GetTime();
							if sitng>0 then
								_G["SK_list_"..x].time:SetText(" "..xisp_time(sitng));
							else
								_G["SK_list_"..x].time:SetText("|cFF00FF00 已就绪！|r");
							end
						end
					else
						_G["SK_list_"..x].time:SetText("|cFFff0000 未知|r");
					end
				end
			end
		end
	end
end
--===========================================================================
--获取副本CD
local function huoqu_Fuben()---
	local fullName= UnitName("player")
	local realmXXX = GetRealmName()
	local className, classFilename, classId = UnitClass("player");
	local rPerc, gPerc, bPerc, argbHex = GetClassColor(classFilename);
	local renwuxinxi={fullName,realmXXX,{rPerc, gPerc, bPerc},"juese"};
	local fubenCDinfo={};
	local numInstances = GetNumSavedInstances();
	if numInstances>0 then
		for id = 1, numInstances, 1 do				
			local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(id)
			table.insert(fubenCDinfo,{name,GetTime(),reset})
		end
	end
	fubenCDinfo.cunzaiYN = true
	local shujuyaun = PIG["SkillFBCD"]["FubenCD"]
	for id=1,#shujuyaun,1 do
		if shujuyaun[id][1][1]..shujuyaun[id][1][2]==fullName..realmXXX then
			shujuyaun[id][2]=fubenCDinfo;
			fubenCDinfo.cunzaiYN = false
			break
		end
	end
	if fubenCDinfo.cunzaiYN then
		local info={renwuxinxi,fubenCDinfo};
		table.insert(shujuyaun,info)
	end
end
----
local function gengxin_Fuben(self)
	for id = 1, hang_NUM, 1 do
		_G["fubenCD_list_"..id]:Hide();
		_G["fubenCD_list_"..id].kong:SetWidth(14);
		_G["fubenCD_list_"..id].del:Hide();	
		_G["fubenCD_list_"..id].name:SetText();
	end
   	local cdmulu={};
   	local shujuyaun = PIG["SkillFBCD"]["FubenCD"]
   	for i=1,#shujuyaun,1 do
   		local renwu={shujuyaun[i][1][1].."-"..shujuyaun[i][1][2],shujuyaun[i][1][4],shujuyaun[i][1][3]}
   		table.insert(cdmulu,renwu)
   		for ii=1,#shujuyaun[i][2] do
			table.insert(cdmulu,shujuyaun[i][2][ii])
		end
   	end
	local ItemsNum = #cdmulu;
	if ItemsNum>0 then
	    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
	    local offset = FauxScrollFrame_GetOffset(self);
	    for id = 1, hang_NUM do
			local dangqian = id+offset;
			if cdmulu[dangqian] then
				_G["fubenCD_list_"..id]:Show();
				if cdmulu[dangqian][2]=="juese" then
					_G["fubenCD_list_"..id].del:Show();
					_G["fubenCD_list_"..id].kong:SetWidth(0.2);
					_G["fubenCD_list_"..id].name:SetText(cdmulu[dangqian][1]);
					_G["fubenCD_list_"..id].name:SetTextColor(cdmulu[dangqian][3][1], cdmulu[dangqian][3][2], cdmulu[dangqian][3][3], 1);
				else
					local shengyu=cdmulu[dangqian][2]+cdmulu[dangqian][3]-GetTime();
					if shengyu>0 then
						local txt=cdmulu[dangqian][1].." "..disp_time(shengyu)
						_G["fubenCD_list_"..id].name:SetText(txt);
					else
						local txt=cdmulu[dangqian][1].."|cFF00FF00 新CD！|r";
						_G["fubenCD_list_"..id].name:SetText(txt);
					end
				end
			end
		end
	end
end
--创建监控面板===================================================
local function Add_Skill_CD()
	if zhuanyeCDUI then return end
	--显示框架
	local Width,Height = 650,460;
	local zhuanyeCD=ADD_Frame(GnUI,UIParent,Width,Height,"CENTER",UIParent,"CENTER",0,60,true,false,true,true,true,"BG2")
	
	zhuanyeCD.title = zhuanyeCD:CreateFontString();
	zhuanyeCD.title:SetPoint("TOP", zhuanyeCD, "TOP", 0, -3);
	zhuanyeCD.title:SetFontObject(GameFontNormalSmall);
	zhuanyeCD.title:SetText("专业技能/副本CD监控");
	---重置配置
	zhuanyeCD.chongzhizhushouBUT = CreateFrame("Button",nil,zhuanyeCD, "UIPanelButtonTemplate");  
	zhuanyeCD.chongzhizhushouBUT:SetSize(50,18);
	zhuanyeCD.chongzhizhushouBUT:SetPoint("RIGHT",zhuanyeCD.Close,"LEFT",-20,0);
	zhuanyeCD.chongzhizhushouBUT:SetText("重置");
	zhuanyeCD.chongzhizhushouBUT:SetScript("OnClick", function ()
		StaticPopup_Show ("HUIFU_ZHUANYEFUBENCD");
	end);
	StaticPopupDialogs["HUIFU_ZHUANYEFUBENCD"] = {
		text = "\124cffff0000重置\124r专业和副本所有CD记录吗?",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG.SkillFBCD.SkillCD={}
			PIG.SkillFBCD.FubenCD={}
			PIG.SkillFBCD.Open="ON";
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	-------------------
	--下方提示
	zhuanyeCD.tishi = zhuanyeCD:CreateFontString();
	zhuanyeCD.tishi:SetPoint("BOTTOM",zhuanyeCD,"BOTTOM",26,12);
	zhuanyeCD.tishi:SetFont(ChatFontNormal:GetFont(), 12,"OUTLINE")
	zhuanyeCD.tishi:SetText("\124cff00ff00第一次使用时请打开专业面板获取一次CD！\124r");
	zhuanyeCD.tishiTex = zhuanyeCD:CreateTexture(nil, "ARTWORK");
	zhuanyeCD.tishiTex:SetTexture("interface/common/help-i.blp");
	zhuanyeCD.tishiTex:SetPoint("RIGHT", zhuanyeCD.tishi, "LEFT", 0, 0);
	zhuanyeCD.tishiTex:SetSize(26,26);

	---专业CD列表
	zhuanyeCD.SkillCD=ADD_Frame(GnUI,zhuanyeCD,(Width-48)/2,Height-70,"TOPLEFT", zhuanyeCD, "TOPLEFT", 5, -40,false,true,false,false,false,"BG3")
	zhuanyeCD.SkillCD.titleL = zhuanyeCD.SkillCD:CreateFontString();
	zhuanyeCD.SkillCD.titleL:SetPoint("BOTTOM", zhuanyeCD.SkillCD, "TOP", 0, 2);
	zhuanyeCD.SkillCD.titleL:SetFontObject(GameFontGreen);
	zhuanyeCD.SkillCD.titleL:SetText("正在冷却中的专业技能");
	------------------
	zhuanyeCD.SkillCD.Scroll = CreateFrame("ScrollFrame",nil,zhuanyeCD.SkillCD, "FauxScrollFrameTemplate");  
	zhuanyeCD.SkillCD.Scroll:SetPoint("TOPLEFT",zhuanyeCD.SkillCD,"TOPLEFT",4,-4);
	zhuanyeCD.SkillCD.Scroll:SetPoint("BOTTOMRIGHT",zhuanyeCD.SkillCD,"BOTTOMRIGHT",-4,2);
	zhuanyeCD.SkillCD.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxin_Skill)
	end)
	for id = 1, hang_NUM, 1 do
		local SK_list = CreateFrame("Frame", "SK_list_"..id, zhuanyeCD.SkillCD.Scroll:GetParent());
		SK_list:SetSize(zhuanyeCD.SkillCD:GetWidth()-18,hang_Height);
		if id==1 then
			SK_list:SetPoint("TOPLEFT", zhuanyeCD.SkillCD.Scroll, "TOPLEFT", 0, -1);
		else
			SK_list:SetPoint("TOPLEFT", _G["SK_list_"..(id-1)], "BOTTOMLEFT", 0, -1);
		end
		SK_list.del = CreateFrame("Button",nil,SK_list, "TruncatedButtonTemplate");
		SK_list.del:SetSize(hang_Height-4,hang_Height-4);
		SK_list.del:SetPoint("LEFT", SK_list, "LEFT", 0,0);
		SK_list.del.Tex = SK_list.del:CreateTexture(nil, "BORDER");
		SK_list.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		SK_list.del.Tex:SetPoint("CENTER");
		SK_list.del.Tex:SetSize(hang_Height-6,hang_Height-6)
		SK_list.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1,-1);
		end);
		SK_list.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		SK_list.del:SetScript("OnClick", function (self)
			local wanjianame = self:GetParent().name:GetText()
			local shujuyuan = PIG["SkillFBCD"]["SkillCD"]
			for i=1,#shujuyuan,1 do
				if shujuyuan[i][1][1].."-"..shujuyuan[i][1][2]==wanjianame then
					table.remove(shujuyuan,i);
					gengxin_Skill(zhuanyeCD.SkillCD.Scroll);
					break
				end
			end
		end);
		SK_list.kong = CreateFrame("Frame", nil, SK_list);
		SK_list.kong:SetSize(18,hang_Height);
		SK_list.kong:SetPoint("LEFT", SK_list.del, "RIGHT", 0, 0);
		SK_list.Tex = SK_list:CreateTexture(nil, "BORDER");
		SK_list.Tex:SetSize(16,16);
		SK_list.Tex:SetPoint("LEFT", SK_list.kong, "RIGHT", 0, 0);			
		SK_list.name = SK_list:CreateFontString();
		SK_list.name:SetPoint("LEFT", SK_list.Tex, "RIGHT", 0, 0);
		SK_list.name:SetFontObject(ChatFontNormal);
		SK_list.time = SK_list:CreateFontString();
		SK_list.time:SetPoint("LEFT", SK_list.name, "RIGHT", 0, 0);
		SK_list.time:SetFontObject(ChatFontNormal);
	end
	--副本CD列表===================================================
	zhuanyeCD.fubenCD=ADD_Frame(GnUI,zhuanyeCD,(Width-48)/2,Height-70,"TOPRIGHT", zhuanyeCD, "TOPRIGHT", -24, -40,false,true,false,false,false,"BG3")
	zhuanyeCD.fubenCD.titleR = zhuanyeCD.fubenCD:CreateFontString();
	zhuanyeCD.fubenCD.titleR:SetPoint("BOTTOM", zhuanyeCD.fubenCD, "TOP", 0, 2);
	zhuanyeCD.fubenCD.titleR:SetFontObject(GameFontGreen);
	zhuanyeCD.fubenCD.titleR:SetText("正在冷却中的副本");
	------
	zhuanyeCD.fubenCD.Scroll = CreateFrame("ScrollFrame",nil,zhuanyeCD.fubenCD, "FauxScrollFrameTemplate");  
	zhuanyeCD.fubenCD.Scroll:SetPoint("TOPLEFT",zhuanyeCD.fubenCD,"TOPLEFT",4,-4);
	zhuanyeCD.fubenCD.Scroll:SetPoint("BOTTOMRIGHT",zhuanyeCD.fubenCD,"BOTTOMRIGHT",-4,2);
	zhuanyeCD.fubenCD.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxin_Fuben)
	end)
	for id = 1, hang_NUM, 1 do
		local fubenCD_list = CreateFrame("Frame", "fubenCD_list_"..id, zhuanyeCD.fubenCD.Scroll:GetParent());
		fubenCD_list:SetSize(zhuanyeCD.fubenCD:GetWidth()-18,hang_Height);
		if id==1 then
			fubenCD_list:SetPoint("TOPLEFT", zhuanyeCD.fubenCD.Scroll, "TOPLEFT", 0, 0);
		else
			fubenCD_list:SetPoint("TOPLEFT", _G["fubenCD_list_"..id-1], "BOTTOMLEFT", 0, -1);
		end
		fubenCD_list.del = CreateFrame("Button",nil,fubenCD_list, "TruncatedButtonTemplate");
		fubenCD_list.del:SetSize(hang_Height-4,hang_Height-4);
		fubenCD_list.del:SetPoint("LEFT", fubenCD_list, "LEFT", 0,0);
		fubenCD_list.del.Tex = fubenCD_list.del:CreateTexture(nil, "BORDER");
		fubenCD_list.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		fubenCD_list.del.Tex:SetPoint("CENTER");
		fubenCD_list.del.Tex:SetSize(hang_Height-6,hang_Height-6)
		fubenCD_list.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1,-1);
		end);
		fubenCD_list.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		fubenCD_list.del:SetScript("OnClick", function (self)
			local wanjianame = self:GetParent().name:GetText()
			local shujuyuan = PIG["SkillFBCD"]["FubenCD"]
			for i=1,#shujuyuan,1 do
				if shujuyuan[i][1][1].."-"..shujuyuan[i][1][2]==wanjianame then
					table.remove(shujuyuan,i);
					gengxin_Fuben(zhuanyeCD.fubenCD.Scroll);
					break
				end
			end
		end);
		fubenCD_list.kong = CreateFrame("Frame", nil, fubenCD_list);
		fubenCD_list.kong:SetSize(18,hang_Height);
		fubenCD_list.kong:SetPoint("LEFT", fubenCD_list.del, "RIGHT", 0, 0);
		fubenCD_list.name = fubenCD_list:CreateFontString();
		fubenCD_list.name:SetPoint("LEFT", fubenCD_list.kong, "RIGHT", 0, 0);
		fubenCD_list.name:SetFontObject(ChatFontNormal);
	end
	--注册CD监测事件
	zhuanyeCDUI:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED","player");              
	zhuanyeCDUI:RegisterEvent("UPDATE_INSTANCE_INFO");
	zhuanyeCDUI:SetScript("OnEvent", function(self,event,arg1,_,arg3)
		if event=="UNIT_SPELLCAST_SUCCEEDED" then
			for s=1,#Pig_SkillID,1 do
				if arg3==Pig_SkillID[s][1] then
					local shujuyuan = PIG["SkillFBCD"]["SkillCD"]
					for k=1,#shujuyuan,1 do
						local fullName, realmXXX = UnitFullName("player")
						if shujuyuan[k][1][1]..shujuyuan[k][1][2]==fullName..realmXXX then
							for kk=1,#shujuyuan[k][2],1 do
								if shujuyuan[k][2][kk][1]==arg3 then
									local function gengxinSPCD1()
										local start, duration = GetSpellCooldown(arg3);
										shujuyuan[k][2][kk][4] =start;
										shujuyuan[k][2][kk][5] =duration;
										gengxin_Skill(zhuanyeCD.SkillCD.Scroll);
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
					local shujuyuan = PIG["SkillFBCD"]["SkillCD"]
					for k=1,#shujuyuan,1 do
						if shujuyuan[k][1][1]..shujuyuan[k][1][2]==fullName..realmXXX then
							for kk=1,#shujuyuan[k][2],1 do
								if shujuyuan[k][2][kk][1]==arg3 then
									local function gengxinSPCD3()
										if tocversion<100000 then
											for Bagid=0,4,1 do
												local numberOfSlots = GetContainerNumSlots(Bagid);
												for sol=1,numberOfSlots,1 do
													if GetContainerItemID(Bagid, sol)==Pig_ItemID[i][3] then
														local startTime, duration = GetContainerItemCooldown(Bagid, sol)
														shujuyuan[k][2][kk][4] =startTime;
														shujuyuan[k][2][kk][5] =duration;
														gengxin_Skill(zhuanyeCD.SkillCD.Scroll);
													end
												end
											end
										else
											for Bagid=0,4,1 do
												local numberOfSlots = C_Container.GetContainerNumSlots(Bagid);
												for sol=1,numberOfSlots,1 do
													if C_Container.GetContainerItemID(Bagid, sol)==Pig_ItemID[i][3] then
														local startTime, duration = C_Container.GetContainerItemCooldown(Bagid, sol)
														shujuyuan[k][2][kk][4] =startTime;
														shujuyuan[k][2][kk][5] =duration;
														gengxin_Skill(zhuanyeCD.SkillCD.Scroll);
													end
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
			gengxin_Fuben(zhuanyeCD.fubenCD.Scroll);
		end
	end)
	---更新专业CD
	local function zhixingdakaigengxin()
		local fullName, realmXXX = UnitFullName("player")
		local shujuyuan = PIG["SkillFBCD"]["SkillCD"]
		for x=1,#shujuyuan,1 do
			if shujuyuan[x][1][1]..shujuyuan[x][1][2]==fullName..realmXXX then
				for xx=1,#shujuyuan[x][2] do
					local chazhaoName= GetSpellInfo(shujuyuan[x][2][xx][1])
					for j=1,GetNumTradeSkills() do
						local Skillname= GetTradeSkillInfo(j);
						if Skillname==chazhaoName then
							local cd = GetTradeSkillCooldown(j);
							if cd then
								shujuyuan[x][2][xx][4]=GetTime()
								shujuyuan[x][2][xx][5]=cd
							else
								shujuyuan[x][2][xx][4]=0
								shujuyuan[x][2][xx][5]=0
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
		gengxin_Skill(zhuanyeCD.SkillCD.Scroll);
	end)
end
--===============================
local ADD_ModCheckbutton =addonTable.ADD_ModCheckbutton
local Tooltip = "创建一个监控所有角色"..GnName.."界面！";
local Cfanwei,xulieID = -80, 2
local OptionsModF_Skill_FB = ADD_ModCheckbutton(GnName,Tooltip,fuFrame,Cfanwei,xulieID)
---
local ADD_QuickButton=addonTable.ADD_QuickButton
local function ADD_QuickButton_SkillfubenCD()
	local ckbut = OptionsModF_Skill_FB.ADD
	if PIG["SkillFBCD"]["AddBut"]=="ON" then
		ckbut:SetChecked(true);
	end
	if PIG['QuickButton']['Open'] and PIG["SkillFBCD"]["Open"]=="ON" and OptionsModF_Skill_FB:IsEnabled() then
		ckbut:Enable();
	else
		ckbut:Disable();
	end
	if PIG['QuickButton']['Open'] and PIG["SkillFBCD"]["Open"]=="ON" and PIG["SkillFBCD"]["AddBut"]=="ON" and OptionsModF_Skill_FB:IsEnabled() then
		local QkBut = "QkBut_Skill"
		if _G[QkBut] then return end
		local Icon=133735
		local Tooltip = "点击-|cff00FFFF打开"..GnName.."监控|r"
		local QkBut=ADD_QuickButton(QkBut,Tooltip,Icon)
		QkBut.Height = QkBut:CreateTexture(nil, "OVERLAY");
		QkBut.Height:SetTexture(130724);
		QkBut.Height:SetBlendMode("ADD");
		QkBut.Height:SetAllPoints(QkBut)
		QkBut.Height:Hide()
		QkBut:SetScript("OnClick", function(self,button)
			if _G[GnUI]:IsShown() then
				_G[GnUI]:Hide();
			else
				_G[GnUI]:SetFrameLevel(FrameLevel)
				_G[GnUI]:Show();
			end
		end);
		--提示图标
		local function xianshitishi()
			if not InCombatLockdown() then
				local youlengquewancCD=false;
				local shujuyaun = PIG["SkillFBCD"]["SkillCD"]
				for i=1,#shujuyaun,1 do
					if #shujuyaun[i][2]>0 then
						for ii=1,#shujuyaun[i][2],1 do
							if shujuyaun[i][2][ii][5] then
								if shujuyaun[i][2][ii][5]~=0 then
									local sitng=shujuyaun[i][2][ii][4]+shujuyaun[i][2][ii][5]-GetTime();
									if sitng<=0 then
										youlengquewancCD=true;
										break
									end
								else
									youlengquewancCD=true;
									break
								end
							end
						end
					end
				end
				if youlengquewancCD then 
					QkBut.Height:Show(); 
				else
					QkBut.Height:Hide();
				end
			end
			C_Timer.After(10,xianshitishi);
		end
		C_Timer.After(10,xianshitishi);
	end
end
addonTable.ADD_QuickButton_SkillfubenCD=ADD_QuickButton_SkillfubenCD
---
OptionsModF_Skill_FB:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["SkillFBCD"]["Open"]="ON";
		Options_zhuanyeCD:Enable();
		Add_Skill_CD();
		huoqu_Skill()
	else
		PIG["SkillFBCD"]["Open"]="OFF";
		Options_zhuanyeCD:Disable();
		Pig_Options_RLtishi_UI:Show()
	end
	ADD_QuickButton_SkillfubenCD()
end);
OptionsModF_Skill_FB.ADD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["SkillFBCD"]["AddBut"]="ON"
		ADD_QuickButton_SkillfubenCD()
	else
		PIG["SkillFBCD"]["AddBut"]="OFF"
		Pig_Options_RLtishi_UI:Show();
	end
end);
--=============================================
addonTable.Skill_FuBen = function()
	if PIG["SkillFBCD"]["Open"]=="ON" then
		OptionsModF_Skill_FB:SetChecked(true);
		if OptionsModF_Skill_FB:IsEnabled() then
			Options_zhuanyeCD:Enable();
			Add_Skill_CD()
			C_Timer.After(3, huoqu_Skill)
			C_Timer.After(6, huoqu_Skill)
		end
	end
end