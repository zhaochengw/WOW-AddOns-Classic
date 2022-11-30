local addonName, addonTable = ...;
local match = _G.string.match
----------------------------------
local CDWMinfo=addonTable.CDWMinfo
local SQPindao = CDWMinfo["pindao"]
local qingqiumsg = CDWMinfo["Plane"]
local shenqingMSG = "SQHWM_499";
------
local biaotou='!Pig-Plane';
local PIG_WB={}
PIG_WB.JieshouInfo={};
C_ChatInfo.RegisterAddonMessagePrefix(biaotou)
-----
local PlaneFFFFF = CreateFrame("Frame")
PlaneFFFFF:RegisterEvent("CHAT_MSG_CHANNEL");
PlaneFFFFF:RegisterEvent("CHAT_MSG_ADDON");
PlaneFFFFF:RegisterEvent("PLAYER_TARGET_CHANGED"); 
PlaneFFFFF:RegisterEvent("PLAYER_ENTERING_WORLD");   
PlaneFFFFF:SetScript("OnEvent",function(self, event, arg1, arg2, arg3, _, arg5,_,_,_,arg9)
	if event=="PLAYER_ENTERING_WORLD" then	
		PIG_WB.realm = GetRealmName()
	end
	if event=="PLAYER_TARGET_CHANGED" then
		if not UnitIsPlayer("target") then
			local inInstance, instanceType =IsInInstance()
			if not inInstance then
					local mubiaoGUID=UnitGUID("target")
					if mubiaoGUID then
						local unitType, _, serverID, instanceID, zoneID, npcID = strsplit("-", mubiaoGUID);
						if zoneID then
							PIG_WB.weimianID=zoneID
							if PlaneInviteFrame_3 then
								PlaneInviteFrame_3.zijiweimianID:SetText(zoneID);
							end
							local MapID=C_Map.GetBestMapForUnit("player")
							if MapID then
								PIG_WB.WeimianInfo=zoneID.."^"..MapID
								if MapID==1453 or MapID==1454 then
									if not PIG_WB.realm then PIG_WB.realm = GetRealmName() end
									local PIG_WB_inshipaixu_you=true
									if PIG['PlaneInvite']['WeimianList'][PIG_WB.realm] then 
										for x=1,#PIG['PlaneInvite']['WeimianList'][PIG_WB.realm] do
											if zoneID==PIG['PlaneInvite']['WeimianList'][PIG_WB.realm][x][1] then
												PIG_WB_inshipaixu_you=false
											end
										end
									else
										PIG['PlaneInvite']['WeimianList'][PIG_WB.realm]={}
									end
									if PIG_WB_inshipaixu_you then
										table.insert(PIG['PlaneInvite']['WeimianList'][PIG_WB.realm],{zoneID,GetServerTime()})
									end
								end						
							end
						end
					end
			end
		end
	end
	----
	if event=="CHAT_MSG_CHANNEL" then
		if PIG_WB.WeimianInfo then
			local inInstance, instanceType =IsInInstance()
			if not inInstance then
				if arg9==SQPindao and arg1==qingqiumsg then
					if arg5 ~= GetUnitName("player", true) then
						local kaiguanzhuangtai = "^N^N"
						if PIG['PlaneInvite']['Kaiqi']=="ON" then
							kaiguanzhuangtai="^Y"
						else
							kaiguanzhuangtai="^N"
						end
						if PIG['PlaneInvite']['zidongjieshou']=="ON" then
							kaiguanzhuangtai=kaiguanzhuangtai.."^Y"
						else
							kaiguanzhuangtai=kaiguanzhuangtai.."^N"
						end
						local SMessage=PIG_WB.WeimianInfo..kaiguanzhuangtai
						C_ChatInfo.SendAddonMessage(biaotou,SMessage,"WHISPER",arg5)
					end
				end
			end
		end
	end

	if event=="CHAT_MSG_ADDON" and arg1 == biaotou and arg3 == "WHISPER" then
		local banhanshenqing =arg2:match("SQHWM")
		if banhanshenqing then
			if PIG['PlaneInvite']['Kaiqi']=="ON" and PIG['PlaneInvite']['zidongjieshou']=="ON" then
				local inInstance, instanceType =IsInInstance()
				local zuduizhong =IsInGroup("LE_PARTY_CATEGORY_HOME");
				if not inInstance and not zuduizhong then
					if arg2 == shenqingMSG then
						PIG_InviteUnit(arg5)
					else
						SendChatMessage("无法接受你的位面申请,!Pig版本过低", "WHISPER", nil, arg5);
					end
				end
			end
		else
			table.insert(PIG_WB.JieshouInfo, {arg2,arg5,GetServerTime()});
		end
	end
end)
--=============================================================
local ADD_Frame=addonTable.ADD_Frame
local ADD_jindutiaoBUT=addonTable.ADD_jindutiaoBUT
local ADD_Biaoti=addonTable.ADD_Biaoti
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local function ADD_Plane_Frame()
	local fufufuFrame=PlaneInvite_UI
	local fuFrame=PlaneInviteFrame_3;
	local Width,Height=fuFrame:GetWidth(),fuFrame:GetHeight();
	-----------------
	fuFrame.zijiweimian = fuFrame:CreateFontString();
	fuFrame.zijiweimian:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",10,-8);
	fuFrame.zijiweimian:SetFontObject(ChatFontNormal);
	fuFrame.zijiweimian:SetTextColor(0,250/255,154/255, 1);
	fuFrame.zijiweimian:SetText("你的区域ID:");
	fuFrame.zijiweimianID = fuFrame:CreateFontString();
	fuFrame.zijiweimianID:SetPoint("TOPLEFT", fuFrame.zijiweimian, "BOTTOMLEFT", 0, -6);
	fuFrame.zijiweimianID:SetFontObject(ChatFontNormal);
	---
	fuFrame.daojishiJG =PIG['PlaneInvite']['Weimiandaojishi'] or 0;
	fuFrame.morenjiange=300
	local jindutiaoWW = 156
	fuFrame.jieshoushuju,fuFrame.shuaxinBUT=ADD_jindutiaoBUT(fuFrame,jindutiaoWW,"获取位面信息",160,0)

	fuFrame.shuaxinBUT:HookScript("OnShow", function (self)
		if #PIG_WB.JieshouInfo>0 then
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

	StaticPopupDialogs["XIANHUOQUZIJIWEIMIAN"] = {
		text = "请先获取自身角色位面，点击任意NPC即可获取。",
		button1 = "好的",
		OnAccept = function()
			PlaneInvite_UI:Hide()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	fuFrame.shuaxinBUT:SetScript("OnClick", function (self)
		if PIG_WB.weimianID==nil then
			StaticPopup_Show ("XIANHUOQUZIJIWEIMIAN") 
			return 
		end
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
			print("|cff00FFFF!Pig:|r|cffFFFF00请先加入"..SQPindao.."频道获取位面信息！|r")
			return
		end

		fuFrame.shuaxinBUT.anTXT="更新位面信息"
		self:Disable();
		PIG_WB.JieshouInfo={};
		SendChatMessage(qingqiumsg,"CHANNEL",nil,pindaolheji.PIGID)

		fuFrame.daojishiJG =GetServerTime();
		PIG['PlaneInvite']['Weimiandaojishi']=fuFrame.daojishiJG

		fuFrame.shuaxinBUT.err:SetText("")
		fuFrame.jieshoushuju.time = 0
		fuFrame.jieshoushuju:Show()
	end);
	
	-------------------------
	local Tooltip= "|cffFFFF00当双方都打开此选项时可以直接申请组队，如只有一方打开则只能密语申请对方组队。|r";
	fuFrame.PIGPlane_zudui =ADD_Checkbutton(nil,fuFrame,-120,"TOPLEFT",fuFrame,"TOPLEFT",420,-2,"|cff00FF00自动接受玩家位面申请(单人且不在副本时)|r",Tooltip)
	fuFrame.PIGPlane_zudui:SetScript("OnClick", function (self)
		local offtiem = PIG['PlaneInvite']['offtime'] or 0
		local shengyu = GetServerTime()-offtiem
		if shengyu<86400 then
			local chazhi = 86400-shengyu
			local hours = floor(mod(chazhi, 86400)/3600)
			local minutes = math.ceil(mod(chazhi,3600)/60)
			print("|cff00FFFF!Pig:|r|cffFFFF00位面通道充能中...(剩余"..hours.."时"..minutes.."分)！|r")
			self:SetChecked(false)
			return 
		end
		if self:GetChecked() then
			PIG['PlaneInvite']['zidongjieshou']="ON";
		else
			StaticPopup_Show("OPEN_WEIMIANSHENQING");
		end
	end);
	if PIG['PlaneInvite']['zidongjieshou']=="ON" then
		fuFrame.PIGPlane_zudui:SetChecked(true);
	end
	StaticPopupDialogs["OPEN_WEIMIANSHENQING"] = {
		text = "|cff00FFFF!Pig时空之门-位面：|r\n确定关闭自动接受玩家位面申请吗？\n\n|cffff0000注意你在24小时内只能开关一次，并且将无法自动申请玩家邀请你，只能通过密语联系对方。|r\n\n",
		button1 = "确定关闭",
		button2 = "取消关闭",
		OnAccept = function()
			PIG['PlaneInvite']['zidongjieshou']="OFF";
			PIG['PlaneInvite']['offtime']=GetServerTime();
		end,
		OnCancel = function()
			fuFrame.PIGPlane_zudui:SetChecked(true)
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	fuFrame.PIGPlane_zudui.help = fuFrame.PIGPlane_zudui:CreateFontString();
	fuFrame.PIGPlane_zudui.help:SetPoint("TOPLEFT", fuFrame.PIGPlane_zudui, "BOTTOMLEFT", 10, 0);
	fuFrame.PIGPlane_zudui.help:SetFontObject(GameFontNormal);
	fuFrame.PIGPlane_zudui.help:SetTextColor(0, 1, 1, 1);
	fuFrame.PIGPlane_zudui.help:SetText("我为人人，人人为我。请不要做精致的利己主义者");
	------
	fuFrame.Errorxiufu = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");  
	fuFrame.Errorxiufu:SetSize(50,24);
	fuFrame.Errorxiufu:SetPoint("TOPRIGHT",fuFrame,"TOPRIGHT",-10,-4);
	fuFrame.Errorxiufu:SetText("重置");
	fuFrame.Errorxiufu:SetScript("OnClick", function (self)
		if not PIG_WB.realm then PIG_WB.realm = GetRealmName() end
		PIG['PlaneInvite']['WeimianList'][PIG_WB.realm]={}
		print("|cff00FFFF!Pig:|r|cff00FF00重置完成，请重新获取！|r")
	end)
	--------------
	fuFrame.NR=ADD_Frame(nil,fuFrame,Width-20,Height-80,"BOTTOMLEFT",fuFrame,"BOTTOMLEFT",1,3,false,true,false,false,false,"BG3")
	local biaotiName={"位面","区域ID","玩家名(点击私聊)","位置","自动接受申请","操作"}
	local biaotiNameL={80,100,220,220,120,100}
	for i=1,#biaotiName do
		local biaoti = CreateFrame("Button","Weimianbiaoti_"..i,fuFrame.NR);
		biaoti:SetSize(biaotiNameL[i],22);
		if i==1 then
			biaoti:SetPoint("BOTTOMLEFT",fuFrame.NR,"TOPLEFT",6,0);
		else
			biaoti:SetPoint("LEFT",_G["Weimianbiaoti_"..(i-1)],"RIGHT",0,0);
		end
		biaoti.title = biaoti:CreateFontString();
		biaoti.title:SetPoint("LEFT", biaoti, "LEFT", 8, -1);
		biaoti.title:SetFontObject(CombatLogFont);
		biaoti.title:SetText(biaotiName[i]);
		ADD_Biaoti(biaoti)
	end
	local hang_Width,hang_Height,hang_NUM = fuFrame.NR:GetWidth()-4, 25, 14;
	fuFrame.NR.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.NR, "FauxScrollFrameTemplate");  
	fuFrame.NR.Scroll:SetPoint("TOPLEFT",fuFrame.NR,"TOPLEFT",2,-2);
	fuFrame.NR.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.NR,"BOTTOMRIGHT",-4,2);
	fuFrame.NR.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, fuFrame.gengxinhang)
	end)
	for i=1, hang_NUM, 1 do
		local liebiao = CreateFrame("Frame", "WeimianList_"..i, fuFrame.NR.Scroll:GetParent());
		liebiao:SetSize(hang_Width,hang_Height);
		if i==1 then
			liebiao:SetPoint("TOPLEFT", fuFrame.NR.Scroll, "TOPLEFT", 0, -3);
		else
			liebiao:SetPoint("TOPLEFT", _G["WeimianList_"..(i-1)], "BOTTOMLEFT", 0, -2);
		end
		liebiao:Hide()
		if i~=hang_NUM then
			liebiao.line = liebiao:CreateLine()
			liebiao.line:SetColorTexture(1,1,1,0.2)
			liebiao.line:SetThickness(1);
			liebiao.line:SetStartPoint("BOTTOMLEFT",0,0)
			liebiao.line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		liebiao.Weimian = liebiao:CreateFontString();
		liebiao.Weimian:SetWidth(biaotiNameL[1]);
		liebiao.Weimian:SetPoint("LEFT", liebiao, "LEFT", 6, 0);
		liebiao.Weimian:SetFontObject(ChatFontNormal);
		liebiao.Weimian:SetTextColor(0,250/255,154/255, 1);
		liebiao.zoneID = liebiao:CreateFontString();
		liebiao.zoneID:SetWidth(biaotiNameL[2]);
		liebiao.zoneID:SetPoint("LEFT", liebiao.Weimian, "RIGHT", 0, 0);
		liebiao.zoneID:SetFontObject(ChatFontNormal);
		liebiao.zoneID:SetFont(GameFontNormal:GetFont(), 12,"OUTLINE")
		liebiao.zoneID:SetTextColor(0.9,0.9,0.9, 0.9);
		liebiao.zoneID:SetJustifyH("LEFT");

		liebiao.Name = CreateFrame("Frame", nil, liebiao);
		liebiao.Name:SetSize(biaotiNameL[3],hang_Height);
		liebiao.Name:SetPoint("LEFT", liebiao.zoneID, "RIGHT", 0, 0);
		liebiao.Name.T = liebiao.Name:CreateFontString();
		liebiao.Name.T:SetPoint("LEFT", liebiao.Name, "LEFT", 0, 0);
		liebiao.Name.T:SetFontObject(ChatFontNormal);
		liebiao.Name.T:SetTextColor(0,250/255,154/255, 1);
		liebiao.Name:SetScript("OnMouseUp", function(self,button)
			local name = self.T:GetText()
			if name=="匿名" then return end
			local editBox = ChatEdit_ChooseBoxForSend();
			local hasText = editBox:GetText()
			if editBox:HasFocus() then
				editBox:SetText("/WHISPER " ..name.." ".. hasText);
			else
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("/WHISPER " ..name.." ".. hasText);
			end
		end)
		liebiao.Weizhi = liebiao:CreateFontString();
		liebiao.Weizhi:SetWidth(biaotiNameL[4]);
		liebiao.Weizhi:SetPoint("LEFT", liebiao.Name, "RIGHT", 0, 0);
		liebiao.Weizhi:SetFontObject(ChatFontNormal);
		liebiao.Weizhi:SetTextColor(0,250/255,154/255, 1);
		liebiao.Weizhi:SetJustifyH("LEFT");

		liebiao.autoinv = liebiao:CreateFontString();
		liebiao.autoinv:SetWidth(biaotiNameL[5]);
		liebiao.autoinv:SetPoint("LEFT", liebiao.Weizhi, "RIGHT", 10, 0);
		liebiao.autoinv:SetFontObject(ChatFontNormal);
		liebiao.autoinv:SetJustifyH("LEFT");

		liebiao.miyu = CreateFrame("Button",nil,liebiao, "UIPanelButtonTemplate");
		liebiao.miyu:SetSize(biaotiNameL[6]-20,20);
		liebiao.miyu:SetPoint("LEFT",liebiao.autoinv,"RIGHT",0,0);
		liebiao.miyu.Font=liebiao.miyu:GetFontString()
		liebiao.miyu.Font:SetFont(ChatFontNormal:GetFont(), 10);
		liebiao.miyu:SetScript("OnClick", function(self)
			local name = self:GetParent().Name.T:GetText()
			if self:GetText()=="密语" then
				local editBox = ChatEdit_ChooseBoxForSend();
				local hasText = editBox:GetText()
				if editBox:HasFocus() then
					editBox:SetText("/WHISPER " ..name.." ".. hasText);
				else
					ChatEdit_ActivateChat(editBox)
					editBox:SetText("/WHISPER " ..name.." ".. hasText);
				end
			elseif self:GetText()=="请求换位面" then
				C_ChatInfo.SendAddonMessage(biaotou,shenqingMSG,"WHISPER",name)
			end
			PIG_WB.JieshouInfo[self:GetID()][4]=true
			fuFrame.gengxinhang(fuFrame.NR.Scroll)
		end)
	end
	------------
	fuFrame.gengxinhang=function(self)
		for i = 1, hang_NUM do
			_G["WeimianList_"..i]:Hide()	
		end
		local ItemsNum = #PIG_WB.JieshouInfo;
		if ItemsNum>0 then
			fuFrame.shuaxinBUT.err:SetText("");
			if PIG['PlaneInvite']['WeimianList'][PIG_WB.realm] then
				PIG_WB.linshipaixu=PIG['PlaneInvite']['WeimianList'][PIG_WB.realm]
			else
				PIG_WB.linshipaixu={}
			end
			for x=#PIG_WB.linshipaixu,1,-1 do
				if PIG_WB.linshipaixu[x] then
					if PIG_WB.linshipaixu[x][2] then
						local dqTime=GetServerTime()
						local libaiji=date("%w",dqTime)
						local yiguoquTime=dqTime-PIG_WB.linshipaixu[x][2]
						if yiguoquTime and yiguoquTime>604800 then
							table.remove(PIG_WB.linshipaixu,x);
						else
							if libaiji=="4" then
								if yiguoquTime>86400 then
									table.remove(PIG_WB.linshipaixu,x);
								end
							elseif libaiji=="5" then
								if yiguoquTime>172800 then
									table.remove(PIG_WB.linshipaixu,x);
								end
							elseif libaiji=="6" then
								if yiguoquTime>259200 then
									table.remove(PIG_WB.linshipaixu,x);
								end
							elseif libaiji=="7" then
								if yiguoquTime>345600 then
									table.remove(PIG_WB.linshipaixu,x);
								end
							elseif libaiji=="1" then
								if yiguoquTime>432000 then
									table.remove(PIG_WB.linshipaixu,x);
								end
							elseif libaiji=="2" then
								if yiguoquTime>518400 then
									table.remove(PIG_WB.linshipaixu,x);
								end
							-- elseif libaiji=="3" then
							-- 	if yiguoquTime>604800 then
							-- 		table.remove(PIG_WB.linshipaixu,x);
							-- 	end
							end
						end
					end
				end
			end

			for i=1,ItemsNum do
				local zoneID, MapID = strsplit("^", PIG_WB.JieshouInfo[i][1]);
				if tonumber(MapID)==1453 or tonumber(MapID)==1454 then
					local PIG_WB_inshipaixu_you=true
					for x=1,#PIG_WB.linshipaixu do
						if zoneID==PIG_WB.linshipaixu[x][1] then
							PIG_WB_inshipaixu_you=false
						end
					end
					if PIG_WB_inshipaixu_you then
						table.insert(PIG_WB.linshipaixu,{zoneID,GetServerTime()})
					end
				end
			end
			PIG['PlaneInvite']['WeimianList'][PIG_WB.realm]=PIG_WB.linshipaixu

			local weimianbianhao={}
			for i=1,#PIG_WB.linshipaixu do
				table.insert(weimianbianhao,tonumber(PIG_WB.linshipaixu[i][1]))
			end
			local function paixuxiaoda(element1, elemnet2)
			    return element1 < elemnet2
			end
			table.sort(weimianbianhao, paixuxiaoda)
		    					
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
		    local offset = FauxScrollFrame_GetOffset(self);
		    for i = 1, hang_NUM do
		    	local kjframe = _G["WeimianList_"..i]
				local dangqian = i+offset;
				if PIG_WB.JieshouInfo[dangqian] then			
					kjframe:Show()
					kjframe.miyu:SetID(dangqian)
					local zoneID, MapID, Open, autoinv = strsplit("^", PIG_WB.JieshouInfo[dangqian][1]);
					kjframe.zoneID:SetText(zoneID);
					--
					local function panduanweimianID(zoneID)
						local zuixiaozhiweimian={nil,"？"}
						for x=1,#weimianbianhao do	
							local ChazhiV=0
							local ChazhiV=zoneID-weimianbianhao[x]
							if ChazhiV<0 then
								ChazhiV=weimianbianhao[x]-zoneID
							end
							if ChazhiV<100 then
								if zuixiaozhiweimian[1] then
									if ChazhiV<zuixiaozhiweimian[1] then
										zuixiaozhiweimian[1]=ChazhiV
										zuixiaozhiweimian[2]=x
										return zuixiaozhiweimian[2]
									end
								else
							    	zuixiaozhiweimian[1]=ChazhiV
							    	zuixiaozhiweimian[2]=x
							    	return zuixiaozhiweimian[2]
							    end
							end
					    end
					    return zuixiaozhiweimian[2]
					end
				    local weimianID = panduanweimianID(tonumber(zoneID))
					kjframe.Weimian:SetText(weimianID);
					--
					kjframe.Name.T:SetText(PIG_WB.JieshouInfo[dangqian][2]);
					--
					local weizhi = C_Map.GetMapInfo(MapID).name
					kjframe.Weizhi:SetText(weizhi);

					local function DisableFrame(fujiK,Open,autoinv)
						fujiK.miyu:Show()
						fujiK.Weimian:SetTextColor(0,250/255,154/255, 1);
						fujiK.Name.T:SetTextColor(0,250/255,154/255, 1);
						fujiK.Weizhi:SetTextColor(0,250/255,154/255, 1);
						fujiK.autoinv:SetTextColor(0,250/255,154/255, 1);
						if Open=="Y" then
							if autoinv=="Y" then
								fujiK.autoinv:SetText("|cff00FF00是|r")
							else
								fujiK.autoinv:SetText("|cffFF0000否|r");
							end
						else
							fujiK.miyu:Hide()
							fujiK.Name.T:SetText("匿名");
							fujiK.autoinv:SetText("");
							fujiK.Weimian:SetTextColor(0.5,0.5,0.5, 0.4);
							fujiK.Name.T:SetTextColor(0.5,0.5,0.5, 0.4);
							fujiK.Weizhi:SetTextColor(0.5,0.5,0.5, 0.4);
							fujiK.autoinv:SetTextColor(0.5,0.5,0.5, 0.4);
						end
					end
					DisableFrame(kjframe,Open,autoinv)
					local weimianID_ziji = panduanweimianID(tonumber(PIG_WB.weimianID))
					if weimianID~="？" and weimianID_ziji~="？" and weimianID==weimianID_ziji then
						kjframe.miyu:Disable()
						kjframe.miyu:SetText("同位面");
					else
						if PIG_WB.JieshouInfo[dangqian][4] then
							kjframe.miyu:Disable()
							kjframe.miyu:SetText("已发送请求");
						else
							kjframe.miyu:Enable()
							if autoinv=="Y" and PIG['PlaneInvite']['zidongjieshou']=="ON" then
								kjframe.miyu:SetText("请求换位面");
							else
								kjframe.miyu:SetText("密语");
							end
						end
					end	
				end
			end
		else
			fuFrame.shuaxinBUT.err:SetText("未获取到位面信息，请稍后再试!");
		end
	end
	-----
	fuFrame:HookScript("OnShow", function()
		if PIG_WB.weimianID then
			fuFrame.zijiweimianID:SetText(PIG_WB.weimianID);
		else
			fuFrame.zijiweimianID:SetText("点击NPC获取");
		end
	end);
end
addonTable.ADD_Plane_Frame=ADD_Plane_Frame