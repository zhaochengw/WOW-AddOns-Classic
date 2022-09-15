local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local _, _, _, tocversion = GetBuildInfo()
-- ----------------------------------
local CDWMinfo=addonTable.CDWMinfo
local SQPindao = CDWMinfo["pindao"]
local qingqiumsg = CDWMinfo["Leisure"]
----
local biaotou='!Pig-Leisure';
local PIG_Lei={}
PIG_Lei.ListInfo={};
C_ChatInfo.RegisterAddonMessagePrefix(biaotou)
--=============================================================
local FBdata=addonTable.FBdata
local InstanceList = FBdata[1]
local InstanceID = FBdata[2]
local ADD_Frame=addonTable.ADD_Frame
local ADD_Biaoti=addonTable.ADD_Biaoti
local ADD_jindutiaoBUT=addonTable.ADD_jindutiaoBUT
local function ADD_Leisure_Frame()
	local fufufuFrame=PlaneInvite_UI
	local fuFrame=PlaneInviteFrame_1;
	local Width,Height=fuFrame:GetWidth(),fuFrame:GetHeight();	
	
	-- fuFrame.xuanzhong1="全部"
	-- local huodongLXlist={"全部","副本","PVP","任务","喝茶","其他"}
	-- local huodongLXlistID={["全部"]=0,["副本"]=1,["PVP"]=2,["任务"]=3,["喝茶"]=8,["其他"]=9}
	-- fuFrame.Fenlai_1 = CreateFrame("FRAME", nil, fuFrame, "UIDropDownMenuTemplate")
	-- fuFrame.Fenlai_1:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",0,-18)
	-- UIDropDownMenu_SetWidth(fuFrame.Fenlai_1, 80)
	-- local function jiazaifenlei_1(self)
	-- 	local info = UIDropDownMenu_CreateInfo()
	-- 	info.func = self.SetValue
	-- 	for i=1,#huodongLXlist,1 do
	-- 		info.text, info.arg1, info.checked = huodongLXlist[i], huodongLXlist[i], huodongLXlist[i] == fuFrame.xuanzhong1;
	-- 		UIDropDownMenu_AddButton(info)
	-- 	end 
	-- end
	-- function fuFrame.Fenlai_1:SetValue(newValue)
	-- 	UIDropDownMenu_SetText(fuFrame.Fenlai_1, newValue)
	-- 	fuFrame.xuanzhong1=newValue
	-- 	CloseDropDownMenus()
	-- 	if #PIG_Lei.ListInfo>0 then
	-- 		fuFrame.NR.Scroll:gengxinhang(fuFrame.NR.Scroll,fuFrame.xuanzhong1)
	-- 	end
	-- end
	-- UIDropDownMenu_SetText(fuFrame.Fenlai_1, fuFrame.xuanzhong1)
	-- fuFrame.Fenlai_1.T = fuFrame.Fenlai_1:CreateFontString();
	-- fuFrame.Fenlai_1.T:SetPoint("BOTTOMLEFT",fuFrame.Fenlai_1,"TOPLEFT",20,0);
	-- fuFrame.Fenlai_1.T:SetFontObject(GameFontNormal);
	-- fuFrame.Fenlai_1.T:SetText("活动类型");
	-- ---2
	-- fuFrame.xuanzhong2="全部"
	-- fuFrame.Fenlai_2 = CreateFrame("FRAME", nil, fuFrame, "UIDropDownMenuTemplate")
	-- fuFrame.Fenlai_2:SetPoint("LEFT",fuFrame.Fenlai_1,"RIGHT",0,0)
	-- UIDropDownMenu_SetWidth(fuFrame.Fenlai_2, 170)
	-- local NewInstanceList = {{"全部","全部"}}
	-- for i=1,#InstanceList do
	-- 	table.insert(NewInstanceList,InstanceList[i])
	-- end
	-- local function jiazaifenlei_2(self, level, menuList)
	-- 	local info = UIDropDownMenu_CreateInfo()
	-- 	if (level or 1) == 1 then
	-- 		for i=1,#NewInstanceList do
	-- 			info.text= NewInstanceList[i][1]
	-- 			if i==1 then
	-- 				info.func = self.SetValue
	-- 				info.arg1= NewInstanceList[i][2];
	-- 				info.hasArrow = false
	-- 				info.checked = info.arg1 == fuFrame.xuanzhong2
	-- 			else
	-- 				local xuanzhongzai=false
	-- 				local data2=InstanceID[NewInstanceList[i][2]][NewInstanceList[i][3]]
	-- 				for x=1,#data2 do
	-- 					if data2[x]==fuFrame.xuanzhong2 then
	-- 						xuanzhongzai = true
	-- 						break
	-- 					end
	-- 				end
	-- 				info.checked = xuanzhongzai
	-- 				info.menuList, info.hasArrow = data2, true
	-- 			end
	-- 			UIDropDownMenu_AddButton(info)
	-- 		end
	-- 	else
	-- 		info.func = self.SetValue
	-- 		for ii=1, #menuList do
	-- 			local inname = menuList[ii]
	-- 			info.text, info.arg1= inname, inname;
	-- 			info.checked = info.arg1 == fuFrame.xuanzhong2
	-- 			UIDropDownMenu_AddButton(info, level)
	-- 		end
	-- 	end
	-- end
	-- function fuFrame.Fenlai_2:SetValue(newValue)
	-- 	UIDropDownMenu_SetText(fuFrame.Fenlai_2, newValue)
	-- 	fuFrame.xuanzhong2=newValue
	-- 	CloseDropDownMenus()
	-- 	if #PIG_Lei.ListInfo>0 then
	-- 		fuFrame.NR.Scroll:gengxinhang(fuFrame.NR.Scroll,fuFrame.xuanzhong1)
	-- 	end
	-- end
	-- UIDropDownMenu_SetText(fuFrame.Fenlai_2, fuFrame.xuanzhong2)
	-- fuFrame.Fenlai_2.T = fuFrame.Fenlai_2:CreateFontString();
	-- fuFrame.Fenlai_2.T:SetPoint("BOTTOMLEFT",fuFrame.Fenlai_2,"TOPLEFT",20,0);
	-- fuFrame.Fenlai_2.T:SetFontObject(GameFontNormal);
	-- fuFrame.Fenlai_2.T:SetText("区域");
	-- -----

	-- fuFrame.daojishiJG =PIG['PlaneInvite']['Cheduidaojishi'] or 0;
	-- fuFrame.morenjiange=10
	-- local jindutiaoWW = 156
	-- fuFrame.jieshoushuju,fuFrame.shuaxinBUT=ADD_jindutiaoBUT(fuFrame,jindutiaoWW,"获取活动信息",360,0)

	-- fuFrame.shuaxinBUT:HookScript("OnShow", function (self)
	-- 	if #PIG_Lei.ListInfo>0 then
	-- 		local yiguoqu = GetServerTime()-fuFrame.daojishiJG
	-- 		if yiguoqu>3600 then
	-- 			self.err:SetText("上次获取时间:一小时之前");
	-- 		elseif yiguoqu>1800 then
	-- 			self.err:SetText("上次获取时间:半小时之前");
	-- 		elseif yiguoqu>600 then
	-- 			self.err:SetText("上次获取时间:10分钟之前");
	-- 		elseif yiguoqu>300 then
	-- 			self.err:SetText("上次获取时间:5分钟之前");
	-- 		else
	-- 			self.err:SetText("上次获取时间:刚刚");
	-- 		end
	-- 	end
	-- end)
	-- fuFrame.shuaxinBUT:SetScript("OnUpdate", function(self,sss)
	-- 	local yiguoqu = GetServerTime()-fuFrame.daojishiJG
	-- 	local chazhiV = fuFrame.morenjiange-yiguoqu
	-- 	if chazhiV>0 then
	-- 		self:SetText(self.anTXT.."("..chazhiV..")");
	-- 		self:Disable()
	-- 	else
	-- 		self:SetText(self.anTXT);
	-- 		if fufufuFrame.yijiaru then
	-- 			self:Enable()
	-- 		else
	-- 			self:Disable()
	-- 		end	
	-- 	end
	-- end);
	-- --
	-- fuFrame.shuaxinBUT.time = 0
	-- local function jindutiaodaojishi()
	-- 	fuFrame.shuaxinBUT.time=fuFrame.shuaxinBUT.time+1
	-- 	if fuFrame.shuaxinBUT.time<100 then
	-- 		fuFrame.jieshoushuju.jindu:SetWidth(jindutiaoWW*((fuFrame.shuaxinBUT.time)/(100)))
	-- 		fuFrame.jieshoushuju:Show();	
	-- 	else
	-- 		fuFrame.jieshoushuju:Hide()
	-- 		fuFrame.NR.Scroll:gengxinhang(fuFrame.NR.Scroll,fuFrame.xuanzhong2)
	-- 	end
	-- end
	-- fuFrame.shuaxinBUT:Hide()
	-- fuFrame.shuaxinBUT:SetScript("OnClick", function (self)
	-- 	fuFrame.shuaxinBUT.anTXT="更新活动信息"
	-- 	local pindaolheji = {GetChannelList()};
	-- 	pindaolheji.yijiaruPIG=true
	-- 	pindaolheji.PIGID=0
	-- 	for i=1,#pindaolheji do
	-- 		if pindaolheji[i]==SQPindao then
	-- 			pindaolheji.PIGID=pindaolheji[i-1]
	-- 			pindaolheji.yijiaruPIG=false
	-- 			break
	-- 		end
	-- 	end
	-- 	if pindaolheji.yijiaruPIG then
	-- 		print("|cff00FFFF!Pig:|r|cffFFFF00请先加入"..SQPindao.."频道获取活动信息！|r")
	-- 		return
	-- 	end

	-- 	self:Disable();
	-- 	PIG_Lei.ListInfo={};
	-- 	SendChatMessage(qingqiumsg,"CHANNEL",nil,pindaolheji.PIGID)
	-- 	fuFrame.daojishiJG =GetServerTime();
	-- 	PIG['PlaneInvite']['Cheduidaojishi']=fuFrame.daojishiJG

	-- 	fuFrame.shuaxinBUT.err:SetText("")
	-- 	fuFrame.shuaxinBUT.time = 0
	-- 	C_Timer.NewTicker(0.01, jindutiaodaojishi, 100)
	-- end);


	--浏览窗口
	fuFrame.NR=ADD_Frame(nil,fuFrame,Width-20,Height-80,"BOTTOMLEFT",fuFrame,"BOTTOMLEFT",1,3,false,true,false,false,false,"BG3")
	--
	-- local biaotiName={"类型","区域","要求","乘客","司机","详情","操作"}
	-- local biaotiNameL={50,140,80,60,100,340,70}
	-- for i=1,#biaotiName do
	-- 	local biaoti = CreateFrame("Button","Huodongbiaoti_"..i,fuFrame.NR);
	-- 	biaoti:SetSize(biaotiNameL[i],22);
	-- 	if i==1 then
	-- 		biaoti:SetPoint("BOTTOMLEFT",fuFrame.NR,"TOPLEFT",6,0);
	-- 	else
	-- 		biaoti:SetPoint("LEFT",_G["Huodongbiaoti_"..(i-1)],"RIGHT",0,0);
	-- 	end
	-- 	biaoti.title = biaoti:CreateFontString();
	-- 	biaoti.title:SetPoint("LEFT", biaoti, "LEFT", 8, -1);
	-- 	biaoti.title:SetFontObject(CombatLogFont);
	-- 	biaoti.title:SetText(biaotiName[i]);
	-- 	ADD_Biaoti(biaoti)
	-- end
	--
	-- local hang_Width,hang_Height,hang_NUM = fuFrame.NR:GetWidth()-4, 25, 14;
	-- --
	-- fuFrame.NR.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.NR, "FauxScrollFrameTemplate");  
	-- fuFrame.NR.Scroll:SetPoint("TOPLEFT",fuFrame.NR,"TOPLEFT",2,-2);
	-- fuFrame.NR.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.NR,"BOTTOMRIGHT",-4,2);
	-- fuFrame.NR.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	--     FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, fuFrame.NR.Scroll:gengxinhang(fuFrame.NR.Scroll,fuFrame.xuanzhong2))
	-- end)
	-- for i=1, hang_NUM, 1 do
	-- 	local liebiao = CreateFrame("Frame", "HuodongList_"..i, fuFrame.NR.Scroll:GetParent());
	-- 	liebiao:SetSize(hang_Width,hang_Height);
	-- 	if i==1 then
	-- 		liebiao:SetPoint("TOPLEFT", fuFrame.NR.Scroll, "TOPLEFT", 0, -3);
	-- 	else
	-- 		liebiao:SetPoint("TOPLEFT", _G["HuodongList_"..(i-1)], "BOTTOMLEFT", 0, -2);
	-- 	end
	-- 	liebiao:Hide()
	-- 	if i~=hang_NUM then
	-- 		liebiao.line = liebiao:CreateLine()
	-- 		liebiao.line:SetColorTexture(1,1,1,0.2)
	-- 		liebiao.line:SetThickness(1);
	-- 		liebiao.line:SetStartPoint("BOTTOMLEFT",0,0)
	-- 		liebiao.line:SetEndPoint("BOTTOMRIGHT",0,0)
	-- 	end

	-- 	liebiao.Leixing = liebiao:CreateFontString();
	-- 	liebiao.Leixing:SetWidth(biaotiNameL[1]);
	-- 	liebiao.Leixing:SetPoint("LEFT", liebiao, "LEFT", 8, 0);
	-- 	liebiao.Leixing:SetFontObject(GameFontNormal);
	-- 	liebiao.Leixing:SetJustifyH("LEFT");

	-- 	liebiao.Mudidi = liebiao:CreateFontString();
	-- 	liebiao.Mudidi:SetWidth(biaotiNameL[2]);
	-- 	liebiao.Mudidi:SetPoint("LEFT", liebiao.Leixing, "RIGHT", 0, 0);
	-- 	liebiao.Mudidi:SetFontObject(ChatFontNormal);
	-- 	liebiao.Mudidi:SetTextColor(1,1,0,1);
	-- 	liebiao.Mudidi:SetJustifyH("LEFT");

	-- 	liebiao.LVfanwei = liebiao:CreateFontString();
	-- 	liebiao.LVfanwei:SetWidth(biaotiNameL[3]-6);
	-- 	liebiao.LVfanwei:SetPoint("LEFT", liebiao.Mudidi, "RIGHT", 0, 0);
	-- 	liebiao.LVfanwei:SetFontObject(ChatFontNormal);

	-- 	liebiao.Chengke = CreateFrame("Frame", nil, liebiao);
	-- 	liebiao.Chengke:SetSize(biaotiNameL[4],hang_Height);
	-- 	liebiao.Chengke:SetPoint("LEFT", liebiao.LVfanwei, "RIGHT", 0, 0);
	-- 	liebiao.Chengke.renshu = liebiao.Chengke:CreateFontString();
	-- 	liebiao.Chengke.renshu:SetPoint("CENTER", liebiao.Chengke, "CENTER", 0, 0);
	-- 	liebiao.Chengke.renshu:SetFontObject(ChatFontNormal);
	-- 	liebiao.Chengke.renshu:SetTextColor(0,250/255,154/255, 1);
	-- 	liebiao.Chengke.xiangqing = liebiao.Chengke:CreateFontString();
	-- 	liebiao.Chengke.xiangqing:SetFontObject(ChatFontNormal);
	-- 	liebiao.Chengke:SetScript("OnEnter", function (self)
	-- 		GameTooltip:ClearLines();
	-- 		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
	-- 		GameTooltip:SetText(self.xiangqing:GetText() ,0, 1, 0, 1, true)
	-- 		GameTooltip:Show();
	-- 	end);
	-- 	liebiao.Chengke:SetScript("OnLeave", function ()
	-- 		GameTooltip:ClearLines();
	-- 		GameTooltip:Hide() 
	-- 	end);

	-- 	liebiao.Name = CreateFrame("Frame", nil, liebiao);
	-- 	liebiao.Name:SetSize(biaotiNameL[5],hang_Height);
	-- 	liebiao.Name:SetPoint("LEFT", liebiao.Chengke, "RIGHT", 4, 0);
	-- 	liebiao.Name.T = liebiao.Name:CreateFontString();
	-- 	liebiao.Name.T:SetPoint("LEFT", liebiao.Name, "LEFT", 0, 0);
	-- 	liebiao.Name.T:SetFontObject(ChatFontNormal);
	-- 	liebiao.Name:SetScript("OnMouseUp", function(self,button)

	-- 	end)

	-- 	liebiao.xiangqing = CreateFrame("Frame", nil, liebiao);
	-- 	liebiao.xiangqing:SetSize(biaotiNameL[6],hang_Height);
	-- 	liebiao.xiangqing:SetPoint("LEFT", liebiao.Name, "RIGHT", 0, 0);
	-- 	liebiao.xiangqing.t = liebiao.xiangqing:CreateFontString();
	-- 	liebiao.xiangqing.t:SetPoint("LEFT", liebiao.xiangqing, "LEFT", 0, 0);
	-- 	liebiao.xiangqing.t:SetFontObject(ChatFontNormal);
	-- 	liebiao.xiangqing.t:SetTextColor(0,250/255,154/255, 1);
	-- 	liebiao.xiangqing.t:SetSize(biaotiNameL[6],hang_Height);
	-- 	liebiao.xiangqing.t:SetJustifyH("LEFT");
	-- 	liebiao.xiangqing:SetScript("OnEnter", function (self)
	-- 		GameTooltip:ClearLines();
	-- 		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
	-- 		GameTooltip:SetText(self.t:GetText() ,0, 1, 0, 1, true)
	-- 		GameTooltip:Show();
	-- 	end);
	-- 	liebiao.xiangqing:SetScript("OnLeave", function ()
	-- 		GameTooltip:ClearLines();
	-- 		GameTooltip:Hide() 
	-- 	end);

	-- 	liebiao.miyu = CreateFrame("Button",nil,liebiao, "UIPanelButtonTemplate");
	-- 	liebiao.miyu:SetSize(biaotiNameL[7],20);
	-- 	liebiao.miyu:SetPoint("RIGHT",liebiao,"RIGHT",-4,0);
	-- 	liebiao.miyu:SetText("申请上车");
	-- 	liebiao.miyu.Font=liebiao.miyu:GetFontString()
	-- 	liebiao.miyu.Font:SetFont(ChatFontNormal:GetFont(), 10);
	-- 	liebiao.miyu:SetScript("OnClick", function(self)

	-- 	end)
	-- end
	-- function fuFrame.NR.Scroll:gengxinhang(self)
	-- 	for i = 1, hang_NUM do
	-- 		_G["HuodongList_"..i]:Hide()	
	-- 	end
	-- end
	-----------
	-- fuFrame:SetScript("OnShow", function (self)
	-- 	UIDropDownMenu_Initialize(fuFrame.Fenlai_1, jiazaifenlei_1)
	-- 	UIDropDownMenu_Initialize(fuFrame.Fenlai_2, jiazaifenlei_2)
	-- end)
end
addonTable.ADD_Leisure_Frame=ADD_Leisure_Frame