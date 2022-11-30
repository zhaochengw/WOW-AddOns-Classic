local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local _, _, _, tocversion = GetBuildInfo()
local PIGDownMenu=addonTable.PIGDownMenu
-- ----------------------------------
local CDWMinfo=addonTable.CDWMinfo
local SQPindao = CDWMinfo["pindao"]
local qingqiumsg = CDWMinfo["Chedui"]
local shenqingMSG = "级，申请上车！"
----
local biaotou='!Pig-Chedui';
local PIG_CD={}
PIG_CD.JieshouInfo={};
C_ChatInfo.RegisterAddonMessagePrefix(biaotou)
---
local huoquLVminmax=addonTable.huoquLVminmax
local huoquLVdanjia=addonTable.huoquLVdanjia 
local CheduiFFFFF = CreateFrame("Frame")
CheduiFFFFF:RegisterEvent("CHAT_MSG_CHANNEL");
CheduiFFFFF:RegisterEvent("CHAT_MSG_ADDON");
CheduiFFFFF:RegisterEvent("CHAT_MSG_WHISPER"); 
CheduiFFFFF:SetScript("OnEvent",function(self, event, arg1, arg2, _, _, arg5,_,_,_,arg9)
	if PIG_Per.daiben.Open and PIG_Per.daiben.autohuifu then
		if event=="CHAT_MSG_CHANNEL" then
			if arg9==SQPindao and arg1==qingqiumsg then
				local mudidi=PIG_Per.daiben.fubenName
				if mudidi~="无" then
					local _, englishClass, _ = UnitClass("player");
					PIG_CD.cheduixinxi=mudidi.."~"..englishClass.."~"
					--队伍LV
					if IsInGroup()  then
						if IsInRaid() then
							local numSubgroupMembers = GetNumGroupMembers()
							PIG_CD.duiwuLV=numSubgroupMembers.."/40^"
							-- for id=1,numSubgroupMembers do
							--  	local lvvv = UnitLevel("Raid"..id);
							-- 	PIG_CD.duiwuLV=PIG_CD.duiwuLV..lvvv.."^"
							-- end
							PIG_CD.cheduixinxi=PIG_CD.cheduixinxi..PIG_CD.duiwuLV.."团队模式~"
						else
							local numSubgroupMembers = GetNumSubgroupMembers()
							PIG_CD.duiwuLV=(numSubgroupMembers+1).."/5^"
							for id=1,numSubgroupMembers do
								local lvvv = UnitLevel("Party"..id);
								if id==numSubgroupMembers then
									PIG_CD.duiwuLV=PIG_CD.duiwuLV..lvvv
								else
									PIG_CD.duiwuLV=PIG_CD.duiwuLV..lvvv.."^"
								end
							end
							PIG_CD.cheduixinxi=PIG_CD.cheduixinxi..PIG_CD.duiwuLV.."~"
						end
					else
						PIG_CD.cheduixinxi=PIG_CD.cheduixinxi.."1/5~"
					end
					---票价
					local min,max=huoquLVminmax()
					PIG_CD.cheduixinxi=PIG_CD.cheduixinxi..min.."^"..max.."~"
					local danjiaxinxi=huoquLVdanjia()
					PIG_CD.cheduixinxi=PIG_CD.cheduixinxi..danjiaxinxi..PIG_Per.daiben.autohuifu_NR;
					C_ChatInfo.SendAddonMessage(biaotou,PIG_CD.cheduixinxi,"WHISPER",arg5)
				end
			end
		end
	end
	if event=="CHAT_MSG_ADDON" and arg1 == biaotou then
		table.insert(PIG_CD.JieshouInfo, {GetServerTime(),arg5,arg2});
	end
	local function Invwanjia(arg5)
		if PIG_Per.daiben.autohuifu_inv then
			PIG_InviteUnit(arg5)
		end
	end
	if event=="CHAT_MSG_WHISPER" then
		local shenqingOK=arg1:find(shenqingMSG, 1)
		if shenqingOK then
			if PIG_Per.daiben.autohuifu then
				local minLV,maxLV=huoquLVminmax()
				local shengqingLV= strsplit("~", arg1);
				local shengqingLV= tonumber(shengqingLV)
				if shengqingLV>=minLV and shengqingLV<=maxLV then
						if IsInGroup() then
							if IsInRaid() then
								local numSubgroupMembers = GetNumGroupMembers()
								if numSubgroupMembers<40 then
									Invwanjia(arg5)
								else
									SendChatMessage("已满员，谢谢", "WHISPER", nil, arg5);
								end
							else
								local numSubgroupMembers = GetNumSubgroupMembers()
								if numSubgroupMembers<4 then
									Invwanjia(arg5)
								else
									SendChatMessage("已满员，谢谢", "WHISPER", nil, arg5);
								end
							end
						else
							Invwanjia(arg5)
						end
				end
			else
				SendChatMessage("已收工，谢谢", "WHISPER", nil, arg5);
			end
		end
	end
end)
-- --=============================================================
local FBdata=addonTable.FBdata
local InstanceList = FBdata[1]
local InstanceID = FBdata[2]
local ADD_Frame=addonTable.ADD_Frame
local ADD_Biaoti=addonTable.ADD_Biaoti
local ADD_jindutiaoBUT=addonTable.ADD_jindutiaoBUT
local function ADD_Chedui_Frame()
	local fufufuFrame=PlaneInvite_UI
	local fuFrame=PlaneInviteFrame_2;
	local Width,Height=fuFrame:GetWidth(),fuFrame:GetHeight();	
	
	fuFrame.xuanzhong1="全部"
	local huodongLXlist={"全部","副本","PVP","任务","喝茶","其他"}
	fuFrame.Fenlai_1=PIGDownMenu(nil,{80,24},fuFrame,{"TOPLEFT",fuFrame,"TOPLEFT", 6,-18})
	fuFrame.Fenlai_1:Hide()
	fuFrame.Fenlai_1:PIGDownMenu_SetText(fuFrame.xuanzhong1)
	function fuFrame.Fenlai_1:PIGDownMenu_Update_But(self)
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#huodongLXlist,1 do
		    info.text, info.arg1, info.arg2 = huodongLXlist[i], huodongLXlist[i], huodongLXlist[i]
		    info.checked = huodongLXlist[i]==fuFrame.xuanzhong1
			fuFrame.Fenlai_1:PIGDownMenu_AddButton(info)
		end 
	end
	function fuFrame.Fenlai_1:PIGDownMenu_SetValue(value,arg1,arg2)
		fuFrame.Fenlai_1:PIGDownMenu_SetText(value)
		fuFrame.xuanzhong1=arg1
		PIGCloseDropDownMenus()
	end

	fuFrame.Fenlai_1.T = fuFrame.Fenlai_1:CreateFontString();
	fuFrame.Fenlai_1.T:SetPoint("BOTTOMLEFT",fuFrame.Fenlai_1,"TOPLEFT",2,2);
	fuFrame.Fenlai_1.T:SetFontObject(GameFontNormal);
	fuFrame.Fenlai_1.T:SetText("车队类型");
	---2
	fuFrame.xuanzhong2="全部"
	local NewInstanceList = {{"全部","全部"}}
	for i=1,#InstanceList do
		table.insert(NewInstanceList,InstanceList[i])
	end
	local function jiazaifenlei_2(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		if (level or 1) == 1 then
			for i=1,#NewInstanceList do
				info.text= NewInstanceList[i][1]
				if i==1 then
					info.func = self.SetValue
					info.arg1= NewInstanceList[i][2];
					info.hasArrow = false
					info.checked = info.arg1 == fuFrame.xuanzhong2
				else
					local xuanzhongzai=false
					local data2=InstanceID[NewInstanceList[i][2]][NewInstanceList[i][3]]
					for x=1,#data2 do
						if data2[x]==fuFrame.xuanzhong2 then
							xuanzhongzai = true
							break
						end
					end
					info.checked = xuanzhongzai
					info.menuList, info.hasArrow = data2, true
				end
				UIDropDownMenu_AddButton(info)
			end
		else
			info.func = self.SetValue
			for ii=1, #menuList do
				local inname = menuList[ii]
				info.text, info.arg1= inname, inname;
				info.checked = info.arg1 == fuFrame.xuanzhong2
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end
	fuFrame.Fenlai_2=PIGDownMenu(nil,{170,24},fuFrame,{"LEFT",fuFrame.Fenlai_1,"RIGHT",10,0})
	function fuFrame.Fenlai_2:PIGDownMenu_Update_But(self, level, menuList)
		local info = {}
		if (level or 1) == 1 then
			for i=1,#NewInstanceList do
				info.text= NewInstanceList[i][1]
				if i==1 then
					info.func = self.PIGDownMenu_SetValue
					info.arg1= NewInstanceList[i][2];
					info.hasArrow = false
					info.checked = info.arg1 == fuFrame.xuanzhong2
				else
					local xuanzhongzai=false
					local data2=InstanceID[NewInstanceList[i][2]][NewInstanceList[i][3]]
					for x=1,#data2 do
						if data2[x]==fuFrame.xuanzhong2 then
							xuanzhongzai = true
							break
						end
					end
					info.checked = xuanzhongzai
					info.menuList, info.hasArrow = data2, true
				end
				fuFrame.Fenlai_2:PIGDownMenu_AddButton(info)
			end
		else
			info.func = self.SetValue
			for ii=1, #menuList do
				info.func = self.PIGDownMenu_SetValue
				local inname = menuList[ii]
				info.text, info.arg1= inname, inname;
				info.checked = info.arg1 == fuFrame.xuanzhong2
				fuFrame.Fenlai_2:PIGDownMenu_AddButton(info,level)
			end
		end
	end
	function fuFrame.Fenlai_2:PIGDownMenu_SetValue(value,arg1,arg2)
		fuFrame.Fenlai_2:PIGDownMenu_SetText(value)
		fuFrame.xuanzhong2=arg1
		if #PIG_CD.JieshouInfo>0 then
			fuFrame.gengxinhang(fuFrame.NR.Scroll)
		end
		PIGCloseDropDownMenus()
	end
	fuFrame.Fenlai_2:PIGDownMenu_SetText(fuFrame.xuanzhong2)
	fuFrame.Fenlai_2.T = fuFrame.Fenlai_2:CreateFontString();
	fuFrame.Fenlai_2.T:SetPoint("BOTTOMLEFT",fuFrame.Fenlai_2,"TOPLEFT",2,2);
	fuFrame.Fenlai_2.T:SetFontObject(GameFontNormal);
	fuFrame.Fenlai_2.T:SetText("副本筛选");
	-----

	fuFrame.daojishiJG =PIG['PlaneInvite']['Cheduidaojishi'] or 0;
	fuFrame.morenjiange=120
	local jindutiaoWW = 156
	fuFrame.jieshoushuju,fuFrame.shuaxinBUT=ADD_jindutiaoBUT(fuFrame,jindutiaoWW,"获取车队信息",360,0)

	fuFrame.shuaxinBUT:HookScript("OnShow", function (self)
		if #PIG_CD.JieshouInfo>0 then
			local yiguoqu = GetServerTime()-fuFrame.daojishiJG
			if yiguoqu>3600 then
				self.err:SetText("上次获取时间:一小时之前");
			elseif yiguoqu>1800 then
				self.err:SetText("上次获取时间:半小时之前");
			elseif yiguoqu>600 then
				self.err:SetText("上次获取时间:10分钟之前");
			elseif yiguoqu>300 then
				self.err:SetText("上次获取时间:5分钟之前");
			else
				self.err:SetText("上次获取时间:刚刚");
			end
		end
	end)
	fuFrame.shuaxinBUT:SetScript("OnUpdate", function(self,sss)
		local yiguoqu = GetServerTime()-fuFrame.daojishiJG
		local chazhiV = fuFrame.morenjiange-yiguoqu
		if chazhiV>0 then
			self:SetText(self.anTXT.."("..chazhiV..")");
			self:Disable()
		else
			self:SetText(self.anTXT);
			if fufufuFrame.yijiaru then
				self:Enable()
			else
				self:Disable()
			end	
		end
	end);
	--
	fuFrame.jieshoushuju.time = 0
	fuFrame.jieshoushuju:SetScript("OnUpdate", function(self,sss)
		fuFrame.jieshoushuju.time=fuFrame.jieshoushuju.time+sss
		if fuFrame.jieshoushuju.time<2 then
			fuFrame.jieshoushuju.jindu:SetWidth(jindutiaoWW*(fuFrame.jieshoushuju.time/2))
			fuFrame.jieshoushuju:Show();
		else
			fuFrame.jieshoushuju:Hide()
			fuFrame.gengxinhang(fuFrame.NR.Scroll)
		end
	end);
	
	fuFrame.shuaxinBUT:SetScript("OnClick", function (self)
		fuFrame.shuaxinBUT.anTXT="更新车队信息"
		local pindaolheji = {GetChannelList()};
		pindaolheji.yijiaruPIG=true
		pindaolheji.PIGID=0
		for i=1,#pindaolheji do
			if pindaolheji[i]==SQPindao then
				pindaolheji.PIGID=pindaolheji[i-1]
				pindaolheji.yijiaruPIG=false
				break
			end
		end
		if pindaolheji.yijiaruPIG then
			print("|cff00FFFF!Pig:|r|cffFFFF00请先加入"..SQPindao.."频道获取车队信息！|r")
			return
		end

		self:Disable();
		PIG_CD.JieshouInfo={};
		SendChatMessage(qingqiumsg,"CHANNEL",nil,pindaolheji.PIGID)
		fuFrame.daojishiJG =GetServerTime();
		PIG['PlaneInvite']['Cheduidaojishi']=fuFrame.daojishiJG

		fuFrame.shuaxinBUT.err:SetText("")
		fuFrame.jieshoushuju.time = 0
		fuFrame.jieshoushuju:Show()
	end);


	--浏览窗口
	fuFrame.NR=ADD_Frame(nil,fuFrame,Width-20,Height-80,"BOTTOMLEFT",fuFrame,"BOTTOMLEFT",1,3,false,true,false,false,false,"BG3")
	--
	local biaotiName={"类型","区域","等级要求","乘客","司机","详情","购票"}
	local biaotiNameL={50,140,80,60,120,320,70}
	for i=1,#biaotiName do
		local biaoti = CreateFrame("Button","Cheduibiaoti_"..i,fuFrame.NR);
		biaoti:SetSize(biaotiNameL[i],22);
		if i==1 then
			biaoti:SetPoint("BOTTOMLEFT",fuFrame.NR,"TOPLEFT",6,0);
		else
			biaoti:SetPoint("LEFT",_G["Cheduibiaoti_"..(i-1)],"RIGHT",0,0);
		end
		biaoti.title = biaoti:CreateFontString();
		biaoti.title:SetPoint("LEFT", biaoti, "LEFT", 8, -1);
		biaoti.title:SetFontObject(CombatLogFont);
		biaoti.title:SetText(biaotiName[i]);
		ADD_Biaoti(biaoti)
	end
	--
	local hang_Width,hang_Height,hang_NUM = fuFrame.NR:GetWidth()-4, 25, 14;
	--
	fuFrame.NR.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.NR, "FauxScrollFrameTemplate");  
	fuFrame.NR.Scroll:SetPoint("TOPLEFT",fuFrame.NR,"TOPLEFT",2,-2);
	fuFrame.NR.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.NR,"BOTTOMRIGHT",-4,2);
	fuFrame.NR.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, fuFrame.gengxinhang)
	end)
	for i=1, hang_NUM, 1 do
		local liebiao = CreateFrame("Frame", "CheduiList_"..i, fuFrame.NR.Scroll:GetParent());
		liebiao:SetSize(hang_Width,hang_Height);
		if i==1 then
			liebiao:SetPoint("TOPLEFT", fuFrame.NR.Scroll, "TOPLEFT", 0, -3);
		else
			liebiao:SetPoint("TOPLEFT", _G["CheduiList_"..(i-1)], "BOTTOMLEFT", 0, -2);
		end
		liebiao:Hide()
		if i~=hang_NUM then
			liebiao.line = liebiao:CreateLine()
			liebiao.line:SetColorTexture(1,1,1,0.2)
			liebiao.line:SetThickness(1);
			liebiao.line:SetStartPoint("BOTTOMLEFT",0,0)
			liebiao.line:SetEndPoint("BOTTOMRIGHT",0,0)
		end

		liebiao.Leixing = liebiao:CreateFontString();
		liebiao.Leixing:SetWidth(biaotiNameL[1]);
		liebiao.Leixing:SetPoint("LEFT", liebiao, "LEFT", 8, 0);
		liebiao.Leixing:SetFontObject(GameFontNormal);
		liebiao.Leixing:SetJustifyH("LEFT");

		liebiao.Mudidi = liebiao:CreateFontString();
		liebiao.Mudidi:SetWidth(biaotiNameL[2]);
		liebiao.Mudidi:SetPoint("LEFT", liebiao.Leixing, "RIGHT", 0, 0);
		liebiao.Mudidi:SetFontObject(ChatFontNormal);
		liebiao.Mudidi:SetTextColor(1,1,0,1);
		liebiao.Mudidi:SetJustifyH("LEFT");

		liebiao.LVfanwei = liebiao:CreateFontString();
		liebiao.LVfanwei:SetWidth(biaotiNameL[3]-6);
		liebiao.LVfanwei:SetPoint("LEFT", liebiao.Mudidi, "RIGHT", 0, 0);
		liebiao.LVfanwei:SetFontObject(ChatFontNormal);

		liebiao.Chengke = CreateFrame("Frame", nil, liebiao);
		liebiao.Chengke:SetSize(biaotiNameL[4],hang_Height);
		liebiao.Chengke:SetPoint("LEFT", liebiao.LVfanwei, "RIGHT", 0, 0);
		liebiao.Chengke.renshu = liebiao.Chengke:CreateFontString();
		liebiao.Chengke.renshu:SetPoint("CENTER", liebiao.Chengke, "CENTER", 0, 0);
		liebiao.Chengke.renshu:SetFontObject(ChatFontNormal);
		liebiao.Chengke.renshu:SetTextColor(0,250/255,154/255, 1);
		liebiao.Chengke.xiangqing = liebiao.Chengke:CreateFontString();
		liebiao.Chengke.xiangqing:SetFontObject(ChatFontNormal);
		liebiao.Chengke:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
			GameTooltip:SetText(self.xiangqing:GetText() ,0, 1, 0, 1, true)
			GameTooltip:Show();
		end);
		liebiao.Chengke:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);

		liebiao.Name = CreateFrame("Frame", nil, liebiao);
		liebiao.Name:SetSize(biaotiNameL[5],hang_Height);
		liebiao.Name:SetPoint("LEFT", liebiao.Chengke, "RIGHT", 4, 0);
		liebiao.Name.T = liebiao.Name:CreateFontString();
		liebiao.Name.T:SetPoint("LEFT", liebiao.Name, "LEFT", 0, 0);
		liebiao.Name.T:SetFontObject(ChatFontNormal);
		liebiao.Name:SetScript("OnMouseUp", function(self,button)
			local name = self.nametxt
			if button=="LeftButton" then
				local editBox = ChatEdit_ChooseBoxForSend();
				local hasText = editBox:GetText()
				if editBox:HasFocus() then
					editBox:SetText("/WHISPER " ..name.." ".. hasText);
				else
					ChatEdit_ActivateChat(editBox)
					editBox:SetText("/WHISPER " ..name.." ".. hasText);
				end
			elseif button=="RightButton" then
				if PIG['ChatFrame']['RightPlus']=="ON" then
					addonTable.YCchaokanzhuangbei(name)
				else
					PIG_print("请先开启右键增强")
				end
			end
		end)

		liebiao.xiangqing = CreateFrame("Frame", nil, liebiao);
		liebiao.xiangqing:SetSize(biaotiNameL[6],hang_Height);
		liebiao.xiangqing:SetPoint("LEFT", liebiao.Name, "RIGHT", 0, 0);
		liebiao.xiangqing.t = liebiao.xiangqing:CreateFontString();
		liebiao.xiangqing.t:SetPoint("LEFT", liebiao.xiangqing, "LEFT", 0, 0);
		liebiao.xiangqing.t:SetFontObject(ChatFontNormal);
		liebiao.xiangqing.t:SetTextColor(0,250/255,154/255, 1);
		liebiao.xiangqing.t:SetSize(biaotiNameL[6],hang_Height);
		liebiao.xiangqing.t:SetJustifyH("LEFT");
		liebiao.xiangqing:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
			GameTooltip:SetText(self.t:GetText() ,0, 1, 0, 1, true)
			GameTooltip:Show();
		end);
		liebiao.xiangqing:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);

		liebiao.miyu = CreateFrame("Button",nil,liebiao, "UIPanelButtonTemplate");
		liebiao.miyu:SetSize(biaotiNameL[7],20);
		liebiao.miyu:SetPoint("RIGHT",liebiao,"RIGHT",-4,0);
		liebiao.miyu:SetText("申请上车");
		liebiao.miyu.Font=liebiao.miyu:GetFontString()
		liebiao.miyu.Font:SetFont(ChatFontNormal:GetFont(), 10);
		liebiao.miyu:SetScript("OnClick", function(self)
			local name = self:GetParent().Name.nametxt
			local qingqiuMSG = UnitLevel("player")..shenqingMSG;
			SendChatMessage(qingqiuMSG, "WHISPER", nil, name);
			PIG_CD.JieshouInfo[self:GetID()][4]=true
			fuFrame.gengxinhang(fuFrame.NR.Scroll)
		end)
	end
	fuFrame.gengxinhang=function(self)
		for i = 1, hang_NUM do
			_G["CheduiList_"..i]:Hide()	
		end
		local ItemsNum_ALL = #PIG_CD.JieshouInfo;	
		if ItemsNum_ALL>0 then
			local guolvhouINFO = {};
			for i = 1, ItemsNum_ALL do
				local daozhanming, englishClass,duiwuinfo,LVmin_LVmax, xiangqingmsg = strsplit("~", PIG_CD.JieshouInfo[i][3]);
				if xiangqingmsg then
					if fuFrame.xuanzhong2=="全部" then
						local linshiINFO = {PIG_CD.JieshouInfo[i][1],PIG_CD.JieshouInfo[i][2],daozhanming, englishClass,duiwuinfo,LVmin_LVmax, xiangqingmsg,PIG_CD.JieshouInfo[i][4]};
						table.insert(guolvhouINFO,linshiINFO)
					else
						if daozhanming==fuFrame.xuanzhong2 then
							local linshiINFO = {PIG_CD.JieshouInfo[i][1],PIG_CD.JieshouInfo[i][2],daozhanming, englishClass,duiwuinfo,LVmin_LVmax, xiangqingmsg,PIG_CD.JieshouInfo[i][4]};
							table.insert(guolvhouINFO,linshiINFO)
						end
					end
				end		
			end
			--
			local ItemsNum = #guolvhouINFO
			if ItemsNum>0 then
				FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
				local offset = FauxScrollFrame_GetOffset(self);
				for i = 1, hang_NUM do
					local fujiak = _G["CheduiList_"..i]
					local dangqian = i+offset;
					if guolvhouINFO[dangqian] then		
						fujiak:Show()
						fujiak.miyu:SetID(dangqian)
						fujiak.Name.nametxt=guolvhouINFO[dangqian][2]
						local WJname,WJserver= strsplit("-", guolvhouINFO[dangqian][2]);
						if WJserver then
							fujiak.Name.T:SetText(WJname.."(*)");
						else
							fujiak.Name.T:SetText(guolvhouINFO[dangqian][2]);
						end
						fujiak.Mudidi:SetText(guolvhouINFO[dangqian][3]);
						local rrr, yyy, bbb, argbHex = GetClassColor(guolvhouINFO[dangqian][4]);
						fujiak.Name.T:SetTextColor(rrr, yyy, bbb,1)

						local renyuan= {strsplit("^", guolvhouINFO[dangqian][5])};
						fujiak.Chengke.renshu:SetText(renyuan[1]);

						PIG_CD.duiwuLVjibei="乘客等级："
						for g=2,#renyuan do
							PIG_CD.duiwuLVjibei=PIG_CD.duiwuLVjibei..renyuan[g].."，"
						end
						fujiak.Chengke.xiangqing:SetText(PIG_CD.duiwuLVjibei);
						local LVmin,LVmax= strsplit("^", guolvhouINFO[dangqian][6]);
						fujiak.LVfanwei:SetText(LVmin.."|cFF888888 — |r"..LVmax);
						local dangqianLVV=UnitLevel("player")
						if dangqianLVV>=tonumber(LVmin) and dangqianLVV<=tonumber(LVmax) then
							local xianyou,zuidaren= strsplit("/", renyuan[1]);
							if tonumber(xianyou)<tonumber(zuidaren) then
								if guolvhouINFO[dangqian][8] then
									fujiak.miyu:Disable()
									fujiak.miyu:SetText("已申请");
								else
									fujiak.miyu:Enable()
									fujiak.miyu:SetText("申请上车");
								end
							else
								fujiak.miyu:Disable()
								fujiak.miyu:SetText("已满员");
							end
						else
							fujiak.miyu:Disable()
							fujiak.miyu:SetText("等级不符");
						end
						fujiak.xiangqing.t:SetText(guolvhouINFO[dangqian][7]);
					end
				end
			end
		else
			fuFrame.shuaxinBUT.err:SetText("未获取到车队信息，请稍后再试!");
		end
	end
end
addonTable.ADD_Chedui_Frame=ADD_Chedui_Frame