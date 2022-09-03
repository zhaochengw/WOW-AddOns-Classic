local addonName, addonTable = ...;
----------------------------------
local biaotou='!Pig-Plane';
local PIG_WB={}
PIG_WB.weimianListInfo={};
local CDWMinfo=addonTable.CDWMinfo
local SQPindao = CDWMinfo[1]
local qingqiumsg = CDWMinfo[2];
local qingqiuMSG = "你好，我需要换个位面，方便的话请组下，谢谢！";
C_ChatInfo.RegisterAddonMessagePrefix(biaotou)
local PlaneFFFFF = CreateFrame("Frame")
PlaneFFFFF:RegisterEvent("CHAT_MSG_CHANNEL");
PlaneFFFFF:RegisterEvent("CHAT_MSG_ADDON");
PlaneFFFFF:RegisterEvent("PLAYER_TARGET_CHANGED");
PlaneFFFFF:RegisterEvent("CHAT_MSG_WHISPER");  
PlaneFFFFF:RegisterEvent("PLAYER_ENTERING_WORLD");   
PlaneFFFFF:SetScript("OnEvent",function(self, event, arg1, arg2, _, _, arg5,_,_,_,arg9)
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
						PIG_WB.weimianMapID=C_Map.GetBestMapForUnit("player")
						if zoneID and PIG_WB.weimianMapID then
							if not PIG_WB.realm then PIG_WB.realm = GetRealmName() end
							PIG_WB.weimianID_MapID=zoneID.."^"..PIG_WB.weimianMapID.."^"..PIG_WB.realm
							
							PIG_WB.weimianID=tonumber(zoneID)
							PIG_WB.weimianMapID=tonumber(PIG_WB.weimianMapID)
							if PIG_WB.weimianMapID==1453 or PIG_WB.weimianMapID==1454 then
								local PIG_WB_inshipaixu_you=true
								if PIG['PlaneInvite']['WeimianList'][PIG_WB.realm] then 
									for x=1,#PIG['PlaneInvite']['WeimianList'][PIG_WB.realm] do
										if PIG_WB.weimianID==PIG['PlaneInvite']['WeimianList'][PIG_WB.realm][x][1] then
											PIG_WB_inshipaixu_you=false
										end
									end
								else
									PIG['PlaneInvite']['WeimianList'][PIG_WB.realm]={}
								end
								if PIG_WB_inshipaixu_you then
									table.insert(PIG['PlaneInvite']['WeimianList'][PIG_WB.realm],{PIG_WB.weimianID,GetServerTime()})
								end
							end

							if PlaneInviteFrame_1 then
								PlaneInviteFrame_1.zijiweimianID:SetText(PIG_WB.weimianID);
							end
						end
					end
			end
		end
	end
	----
	if event=="CHAT_MSG_CHANNEL" then
		if PIG_WB.weimianID_MapID then
			local inInstance, instanceType =IsInInstance()
			if not inInstance then
				if arg9==SQPindao and arg1==qingqiumsg then
					--if arg5 ~=GetUnitName("player", true) then
						local SMessage=PIG_WB.weimianID_MapID.."^"..PIG['PlaneInvite']['Kaiqi']
						C_ChatInfo.SendAddonMessage(biaotou,SMessage,"WHISPER",arg5)
					--end
				end
			end
		end
	end

	if event=="CHAT_MSG_ADDON" and arg1 == biaotou then
		table.insert(PIG_WB.weimianListInfo, {arg2,arg5,GetServerTime()});
	end

	if PIG['PlaneInvite']['Kaiqi']=="ON" and PIG['PlaneInvite']['zidongjieshou']=="ON" then
		local inInstance, instanceType =IsInInstance()
		local zuduizhong =IsInGroup("LE_PARTY_CATEGORY_HOME");
		if not inInstance and not zuduizhong then
			if event=="CHAT_MSG_WHISPER"  then
				if arg1 == qingqiuMSG then
					SendChatMessage("!Pig:你的插件版本过低，无法接受你的申请！", "WHISPER", nil, arg5);
				end
			end
			if event=="CHAT_MSG_ADDON" and arg1 == biaotou then
				if arg2 == qingqiuMSG then
					InviteUnit(arg5)
				end
			end
		end
	end
end)
--=============================================================
local function ADD_Plane_Frame()
	PIG['PlaneInvite']['WeimianList']=PIG['PlaneInvite']['WeimianList'] or addonTable.Default['PlaneInvite']['WeimianList']
	local fuFrame=PlaneInviteFrame_1;
	local Width,Height=fuFrame:GetWidth(),fuFrame:GetHeight();
	------------------
	local biaotiName={"位面(区域ID)","玩家名(点击私聊)","位置","更新时间"}
	local biaotiNameL={20,202,350,460}
	for i=1,#biaotiName do
		fuFrame.biaoti = fuFrame:CreateFontString();
		fuFrame.biaoti:SetFontObject(GameFontNormal);
		fuFrame.biaoti:SetText(biaotiName[i]);
		if i==1 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",biaotiNameL[i],-8);
		elseif i==2 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",biaotiNameL[i],-8);
		elseif i==3 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",biaotiNameL[i],-8);
			fuFrame.biaoti:Hide()
		elseif i==4 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",biaotiNameL[i],-8);
		end
	end
	fuFrame.biaotiline = fuFrame:CreateLine()
	fuFrame.biaotiline:SetColorTexture(1,1,1,0.2)
	fuFrame.biaotiline:SetThickness(1);
	fuFrame.biaotiline:SetStartPoint("TOPLEFT",0,-29)
	fuFrame.biaotiline:SetEndPoint("TOPRIGHT",0,-29)
	------------
	local hang_Height,hang_NUM  = 24, 16;
	local function gengxinhang(self)
		for i = 1, hang_NUM do
			local kjframe = _G["WeimianList_"..i]
			kjframe:Hide()
			kjframe.Weimian:SetText();
			kjframe.WMID:SetText();
			kjframe.Name.T:SetText();
			kjframe.Weizhi:SetText();
			kjframe.Time:SetText();	
		end
		local ItemsNum = #PIG_WB.weimianListInfo;
		if ItemsNum>0 then
			fuFrame.shuaxinWeimian.err:Hide();
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
				local zoneID, MapID, fuwuqiname = strsplit("^", PIG_WB.weimianListInfo[i][1]);
				if tonumber(MapID)==1453 or tonumber(MapID)==1454 then
					local PIG_WB_inshipaixu_you=true
					for x=1,#PIG_WB.linshipaixu do
						if tonumber(zoneID)==PIG_WB.linshipaixu[x][1] then
							PIG_WB_inshipaixu_you=false
						end
					end
					if PIG_WB_inshipaixu_you then
						table.insert(PIG_WB.linshipaixu,{tonumber(zoneID),GetServerTime()})
					end
				end
			end

			PIG['PlaneInvite']['WeimianList'][PIG_WB.realm]=PIG_WB.linshipaixu

			local weimianbianhao={}
			for i=1,#PIG_WB.linshipaixu do
				table.insert(weimianbianhao,PIG_WB.linshipaixu[i][1])
			end
			local function paixuxiaoda(element1, elemnet2)
			    return element1 < elemnet2
			end
			table.sort(weimianbianhao, paixuxiaoda)
		    					
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
		    local offset = FauxScrollFrame_GetOffset(self);
		    for i = 1, hang_NUM do
				local dangqian = i+offset;
				if PIG_WB.weimianListInfo[dangqian] then
					local kjframe = _G["WeimianList_"..i]
					kjframe:Show()
					local zoneID, MapID, fuwuqiname,OnOff = strsplit("^", PIG_WB.weimianListInfo[dangqian][1]);
					kjframe.WMID:SetText(zoneID);
					local zuixiaozhiweimian={nil,"？"}
					local function panduanMin(zoneID,VVV,x)
						local ChazhiV=0
						local ChazhiV=zoneID-VVV
						if ChazhiV<0 then
							ChazhiV=VVV-zoneID
						end
						if ChazhiV<100 then
							if zuixiaozhiweimian[1] then
								if ChazhiV<zuixiaozhiweimian[1] then
									zuixiaozhiweimian[1]=ChazhiV
									zuixiaozhiweimian[2]=x
									return
								end
							else
						    	zuixiaozhiweimian[1]=ChazhiV
						    	zuixiaozhiweimian[2]=x
						    	return
						    end
						end
					end
					
					for x=1,#weimianbianhao do	
						panduanMin(tonumber(zoneID),weimianbianhao[x],x)
				    end
					kjframe.Weimian:SetText(zuixiaozhiweimian[2]);
					
					kjframe.Weimian:SetTextColor(0,250/255,154/255, 1);
					kjframe.Name.T:SetTextColor(0,250/255,154/255, 1);
					kjframe.Time:SetTextColor(0,250/255,154/255, 1);
					kjframe.miyu:SetText("请求换位面");
					kjframe.miyu:Enable()
					if PIG_WB.weimianListInfo[dangqian][4] then
						kjframe.miyu:Disable()
						kjframe.miyu:SetText("已申请");
					end
					if OnOff and OnOff=="OFF" then
						kjframe.miyu:SetText("未开启");
						kjframe.miyu:Disable()
						kjframe.Weimian:SetTextColor(1,1,1, 0.4);
						kjframe.Name.T:SetTextColor(1,1,1, 0.4);
						kjframe.Time:SetTextColor(1,1,1, 0.4);
					end				
				
					local zuixiaozhiweimian_ziji={nil,"？"}
					local function panduanMin_ziji(zoneID,VVV,x)
						local ChazhiV_ziji=0
						local ChazhiV_ziji=zoneID-VVV
						if ChazhiV_ziji<0 then
							ChazhiV_ziji=VVV-zoneID
						end
						if ChazhiV_ziji<50 then
							if zuixiaozhiweimian_ziji[1] then
								if ChazhiV_ziji<zuixiaozhiweimian_ziji[1] then
									zuixiaozhiweimian_ziji[1]=ChazhiV_ziji
									zuixiaozhiweimian_ziji[2]=x
									return
								end
							else
						    	zuixiaozhiweimian_ziji[1]=ChazhiV_ziji
						    	zuixiaozhiweimian_ziji[2]=x
						    	return
						    end
						end
					end
					for x=1,#weimianbianhao do	
						panduanMin_ziji(PIG_WB.weimianID,weimianbianhao[x],x)
					end
					if zuixiaozhiweimian[2]~="？" and zuixiaozhiweimian_ziji[2]~="？" then
						if zuixiaozhiweimian[2]==zuixiaozhiweimian_ziji[2] then
							kjframe.miyu:Disable()
							kjframe.miyu:SetText("同位面");
							kjframe.Weimian:SetTextColor(1,1,1, 0.4);
							kjframe.Name.T:SetTextColor(1,1,1, 0.4);
							kjframe.Time:SetTextColor(1,1,1, 0.4);
						end
					end

					kjframe.Name.T:SetText(PIG_WB.weimianListInfo[dangqian][2]);
					if MapID then
						local weizhixinxi = C_Map.GetMapInfo(MapID).name
						kjframe.Weizhi:SetText(weizhixinxi);
					else
						kjframe.Weizhi:SetText("|cffFFFF00未知|r");
					end
					kjframe.Time:SetText(date("%H:%M:%S",PIG_WB.weimianListInfo[dangqian][3]));
					kjframe.miyu:SetID(dangqian)
				end
			end
		else
			fuFrame.shuaxinWeimian.err:Show();
		end
	end
	---目录
	fuFrame.Scroll = CreateFrame("ScrollFrame",nil,fuFrame, "FauxScrollFrameTemplate");  
	fuFrame.Scroll:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",2,-26);
	fuFrame.Scroll:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",-24,0);
	fuFrame.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinhang)
	end)
	for i=1, hang_NUM, 1 do
		local liebiao = CreateFrame("Frame", "WeimianList_"..i, fuFrame.Scroll:GetParent());
		liebiao:SetSize(Width-30,hang_Height);
		if i==1 then
			liebiao:SetPoint("TOPLEFT", fuFrame.Scroll, "TOPLEFT", 0, -3);
		else
			liebiao:SetPoint("TOPLEFT", _G["WeimianList_"..(i-1)], "BOTTOMLEFT", 0, -2);
		end
		liebiao:Hide()
		liebiao.line = liebiao:CreateLine()
		liebiao.line:SetColorTexture(1,1,1,0.2)
		liebiao.line:SetThickness(1);
		liebiao.line:SetStartPoint("BOTTOMLEFT",0,0)
		liebiao.line:SetEndPoint("BOTTOMRIGHT",0,0)
		liebiao.Weimian = liebiao:CreateFontString();
		liebiao.Weimian:SetPoint("LEFT", liebiao, "LEFT", 20, 0);
		liebiao.Weimian:SetFontObject(ChatFontNormal);
		liebiao.Weimian:SetTextColor(0,250/255,154/255, 1);
		liebiao.WMID = liebiao:CreateFontString();
		liebiao.WMID:SetPoint("BOTTOMLEFT", liebiao.Weimian, "BOTTOMRIGHT", 26, -0);
		liebiao.WMID:SetFontObject(ChatFontNormal);
		liebiao.WMID:SetFont(GameFontNormal:GetFont(), 12,"OUTLINE")
		liebiao.WMID:SetTextColor(0.9,0.9,0.9, 0.9);

		liebiao.Name = CreateFrame("Frame", nil, liebiao);
		liebiao.Name:SetSize(120,hang_Height);
		liebiao.Name:SetPoint("LEFT", liebiao, "LEFT", 200, 0);
		liebiao.Name.T = liebiao.Name:CreateFontString();
		liebiao.Name.T:SetPoint("LEFT", liebiao.Name, "LEFT", 0, 0);
		liebiao.Name.T:SetFontObject(ChatFontNormal);
		liebiao.Name.T:SetTextColor(0,250/255,154/255, 1);
		liebiao.Name:SetScript("OnMouseUp", function(self,button)
			local name = self.T:GetText()
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
		liebiao.Weizhi:SetPoint("LEFT", liebiao, "LEFT", 350, 0);
		liebiao.Weizhi:SetFontObject(ChatFontNormal);
		liebiao.Weizhi:SetTextColor(0,250/255,154/255, 1);
		liebiao.Weizhi:Hide()

		liebiao.Time = liebiao:CreateFontString();
		liebiao.Time:SetPoint("LEFT", liebiao, "LEFT", 460, 0);
		liebiao.Time:SetFontObject(ChatFontNormal);

		liebiao.miyu = CreateFrame("Button",nil,liebiao, "UIPanelButtonTemplate");
		liebiao.miyu:SetSize(80,20);
		liebiao.miyu:SetPoint("LEFT",liebiao,"LEFT",690,0);
		liebiao.miyu.Font=liebiao.miyu:GetFontString()
		liebiao.miyu.Font:SetFont(ChatFontNormal:GetFont(), 10);
		liebiao.miyu:SetScript("OnClick", function(self)
			local name = self:GetParent().Name.T:GetText()
			C_ChatInfo.SendAddonMessage(biaotou,qingqiuMSG,"WHISPER",name)
			PIG_WB.weimianListInfo[self:GetID()][4]=true
			self:Disable()
			self:SetText("已申请");
		end)
	end
	-----
	fuFrame.zijiweimian = fuFrame:CreateFontString();
	fuFrame.zijiweimian:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,40);
	fuFrame.zijiweimian:SetFontObject(ChatFontNormal);
	fuFrame.zijiweimian:SetTextColor(0,250/255,154/255, 1);
	fuFrame.zijiweimian:SetText("你的位面ID:");
	fuFrame.zijiweimianID = fuFrame:CreateFontString();
	fuFrame.zijiweimianID:SetPoint("LEFT", fuFrame.zijiweimian, "RIGHT", 0, 0);
	fuFrame.zijiweimianID:SetFontObject(ChatFontNormal);
	---
	fuFrame.jieshoushuju = CreateFrame("Frame", nil, fuFrame);
	fuFrame.jieshoushuju:SetSize(160,20);
	fuFrame.jieshoushuju:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,22);
	fuFrame.jieshoushuju:Hide();
	fuFrame.jieshoushuju.jindu = fuFrame.jieshoushuju:CreateTexture(nil, "BORDER");
	fuFrame.jieshoushuju.jindu:SetTexture("interface/raidframe/raid-bar-hp-fill.blp");
	fuFrame.jieshoushuju.jindu:SetColorTexture(0.3, 0.7, 0.1, 1)
	fuFrame.jieshoushuju.jindu:SetSize(156,16);
	fuFrame.jieshoushuju.jindu:SetPoint("LEFT",fuFrame.jieshoushuju,"LEFT",2,0);
	fuFrame.jieshoushuju.edg = CreateFrame("Frame", nil, fuFrame.jieshoushuju,"BackdropTemplate");
	fuFrame.jieshoushuju.edg:SetBackdrop( { edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 13,});
	fuFrame.jieshoushuju.edg:SetBackdropBorderColor(0, 1, 1, 0.9);
	fuFrame.jieshoushuju.edg:SetAllPoints(fuFrame.jieshoushuju)
	fuFrame.jieshoushuju.edg.t = fuFrame.jieshoushuju.edg:CreateFontString();
	fuFrame.jieshoushuju.edg.t:SetPoint("CENTER",fuFrame.jieshoushuju.edg,"CENTER",0,0);
	fuFrame.jieshoushuju.edg.t:SetFont(GameFontNormal:GetFont(), 12)
	fuFrame.jieshoushuju.edg.t:SetText("正在接收数据...");
	local yanchishuaxinliebiao = 3
	fuFrame.zhengzaihuoqudaojishi = yanchishuaxinliebiao
	fuFrame.jieshoushuju:SetScript("OnUpdate", function(self,sss)
		fuFrame.zhengzaihuoqudaojishi = fuFrame.zhengzaihuoqudaojishi-sss
		if fuFrame.zhengzaihuoqudaojishi>0 then
			fuFrame.jieshoushuju.jindu:SetWidth(156*((yanchishuaxinliebiao-fuFrame.zhengzaihuoqudaojishi)/yanchishuaxinliebiao))
		else
			fuFrame.jieshoushuju:Hide()
		end
	end);
	------
	local function shuaxinweimianliebiao()
		gengxinhang(fuFrame.Scroll)
	end
	fuFrame.morenjiange =300;
	fuFrame.daojishiJG =PIG['PlaneInvite']['Weimiandaojishi'] or 0;
	local function Weimian_daojishi()
		local chazhiV = GetServerTime()-fuFrame.daojishiJG
		if chazhiV>fuFrame.morenjiange then
			print(PlaneInvite_UI.yijiaru)
			if PlaneInvite_UI.yijiaru then
				fuFrame.shuaxinWeimian:Enable()
			else
				fuFrame.shuaxinWeimian:Disable()
			end
			fuFrame.shuaxinWeimian:SetText("更新位面信息");
		else
			fuFrame.shuaxinWeimian:SetText("更新位面信息("..fuFrame.morenjiange-chazhiV..")");
			C_Timer.After(1,Weimian_daojishi)
			fuFrame.shuaxinWeimian:Disable() 
		end
	end	

	fuFrame.shuaxinWeimian = CreateFrame("Button","huiquweimian_UI",fuFrame, "UIPanelButtonTemplate");  
	fuFrame.shuaxinWeimian:SetSize(136,24);
	fuFrame.shuaxinWeimian:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",200,28);
	fuFrame.shuaxinWeimian:SetText("获取位面信息");
	fuFrame.shuaxinWeimian.err = fuFrame.shuaxinWeimian:CreateFontString();
	fuFrame.shuaxinWeimian.err:SetPoint("BOTTOMLEFT",fuFrame.shuaxinWeimian,"TOPLEFT",2,0);
	fuFrame.shuaxinWeimian.err:SetFont(GameFontNormal:GetFont(), 14)
	fuFrame.shuaxinWeimian.err:SetText("未获取到位面信息，请稍后再试!");
	fuFrame.shuaxinWeimian.err:SetTextColor(1, 0.4, 0, 1);
	fuFrame.shuaxinWeimian.err:Hide();
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
	fuFrame.shuaxinWeimian:SetScript("OnClick", function (self)
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

		self:Disable();
		fuFrame.jieshoushuju:Show();
		fuFrame.zhengzaihuoqudaojishi = yanchishuaxinliebiao

		PIG_WB.weimianListInfo={};
		SendChatMessage(qingqiumsg,"CHANNEL",nil,pindaolheji.PIGID)
		C_Timer.After(yanchishuaxinliebiao,shuaxinweimianliebiao)

		fuFrame.daojishiJG =GetServerTime();
		PIG['PlaneInvite']['Weimiandaojishi']=fuFrame.daojishiJG
		Weimian_daojishi()
	end);
	Weimian_daojishi()
	-----------------------
	fuFrame.PIGPlane_zudui = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
	fuFrame.PIGPlane_zudui:SetSize(30,32);
	fuFrame.PIGPlane_zudui:SetHitRectInsets(0,-120,0,0);
	fuFrame.PIGPlane_zudui:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",360,32);
	fuFrame.PIGPlane_zudui.Text:SetText("|cff00FF00自动接受玩家位面申请(单人且不在副本时)|r");
	fuFrame.PIGPlane_zudui.tooltip = "自动接受玩家位面申请(未组队且不在副本时)\n|cff00FF00我为人人，人人为我。请不要做精致的利己主义者。|r";
	fuFrame.PIGPlane_zudui:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['PlaneInvite']['zidongjieshou']="ON";
		else
			PIG['PlaneInvite']['zidongjieshou']="OFF";
		end
	end);
	if PIG['PlaneInvite']['zidongjieshou']=="ON" then
		fuFrame.PIGPlane_zudui:SetChecked(true);
	end
	------
	fuFrame.Errorxiufu = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");  
	fuFrame.Errorxiufu:SetSize(80,24);
	fuFrame.Errorxiufu:SetPoint("TOPRIGHT",fuFrame,"TOPRIGHT",-10,32);
	fuFrame.Errorxiufu:SetText("异常修复");
	fuFrame.Errorxiufu:SetScript("OnClick", function (self)
		if not PIG_WB.realm then PIG_WB.realm = GetRealmName() end
		PIG['PlaneInvite']['WeimianList'][PIG_WB.realm]={}
		print("|cff00FFFF!Pig:|r|cff00FF00修复完成，请重新获取！|r")
	end)

	fuFrame:SetScript("OnShow", function()
		if PIG_WB.weimianID then
			fuFrame.zijiweimianID:SetText(PIG_WB.weimianID);
		else
			fuFrame.zijiweimianID:SetText("点击NPC获取");
		end
	end);
end
addonTable.ADD_Plane_Frame=ADD_Plane_Frame