local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
-- ----------------------------------
local biaotou='!Pig-Chedui';
local PIG_CD={}
PIG_CD.ListInfo={};
PIG_CD.shenqing = "级，申请上车！"
C_ChatInfo.RegisterAddonMessagePrefix(biaotou)
local CheduiFFFFF = CreateFrame("Frame")
CheduiFFFFF:RegisterEvent("CHAT_MSG_CHANNEL");
CheduiFFFFF:RegisterEvent("CHAT_MSG_ADDON");
-- CheduiFFFFF:RegisterEvent("PLAYER_TARGET_CHANGED");
CheduiFFFFF:RegisterEvent("CHAT_MSG_WHISPER");      
CheduiFFFFF:SetScript("OnEvent",function(self, event, arg1, arg2, _, _, arg5,_,_,_,arg9)
	if PIG_Per["FarmRecord"]['Kaiqi']=="ON" and PIG_Per["FarmRecord"]['autohuifu']=="ON" then
		if event=="CHAT_MSG_CHANNEL" then
			if arg9=="PIG" and arg1=="请求车队信息" then
				local _, englishClass, _ = UnitClass("player");
				if PIG_Per["FarmRecord"]["kaichemudidi"]~="无" then
					PIG_CD.cheduixinxi=PIG_Per["FarmRecord"]["kaichemudidi"].."~"..englishClass.."~"
					--队伍LV
					local IsInRaid=IsInRaid("LE_PARTY_CATEGORY_HOME");
					local inGroup = IsInGroup("LE_PARTY_CATEGORY_HOME");
					if IsInRaid then
						local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
						PIG_CD.duiwuLV=numGroupMembers.."/40^"
						for id=1,numGroupMembers do
							local lvvv = UnitLevel("Raid"..id);
							PIG_CD.duiwuLV=PIG_CD.duiwuLV..lvvv.."^"
						end
						PIG_CD.cheduixinxi=PIG_CD.cheduixinxi..PIG_CD.duiwuLV.."~"
					elseif inGroup  then
						local numSubgroupMembers = GetNumSubgroupMembers("LE_PARTY_CATEGORY_HOME")
						PIG_CD.duiwuLV=(numSubgroupMembers+1).."/5^"
						for id=1,numSubgroupMembers do
							local lvvv = UnitLevel("Party"..id);
							PIG_CD.duiwuLV=PIG_CD.duiwuLV..lvvv.."^"
						end
						PIG_CD.cheduixinxi=PIG_CD.cheduixinxi..PIG_CD.duiwuLV.."~"
					else
						PIG_CD.cheduixinxi=PIG_CD.cheduixinxi.."1/5~"
					end
					---票价
					PIG_CD.kaishiLV=nil
					PIG_CD.jieshuLV=nil
					for id = 1, 4, 1 do
						local kaishi =PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][1]
						if kaishi~=0 then
							if PIG_CD.kaishiLV==nil then
								PIG_CD.kaishiLV=kaishi
							else
								if PIG_CD.kaishiLV>kaishi then
									PIG_CD.kaishiLV=kaishi
								end
							end
						end
						local jieshu =PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][2]
						if jieshu~=0 then
							if PIG_CD.jieshuLV==nil then
								PIG_CD.jieshuLV=jieshu
							else
								if PIG_CD.jieshuLV<jieshu then
									PIG_CD.jieshuLV=jieshu
								end
							end
						end
					end
					if PIG_CD.kaishiLV and PIG_CD.jieshuLV then
						PIG_CD.cheduixinxi=PIG_CD.cheduixinxi..PIG_CD.kaishiLV.."^"..PIG_CD.jieshuLV.."~"
						if PIG_Per["FarmRecord"]['autohuifu_danjia']=="ON" then
							local jisuandanjia=addonTable.jisuandanjia
							PIG_CD.danjiafanwei_jia={};
							PIG_CD.danjiafanwei_LV={};
							for i=PIG_CD.kaishiLV,PIG_CD.jieshuLV,1 do
								local danjiashunxue=jisuandanjia(i);
								if i==PIG_CD.kaishiLV then
									table.insert(PIG_CD.danjiafanwei_jia, danjiashunxue);
									table.insert(PIG_CD.danjiafanwei_LV, {i});
								else
									if PIG_CD.danjiafanwei_jia[#PIG_CD.danjiafanwei_jia]~=danjiashunxue then
										table.insert(PIG_CD.danjiafanwei_jia, danjiashunxue);
										table.insert(PIG_CD.danjiafanwei_LV, {i});
									else
										table.insert(PIG_CD.danjiafanwei_LV[#PIG_CD.danjiafanwei_jia], i);
									end
								end
							end
							for i=1,#PIG_CD.danjiafanwei_jia do
								if PIG_CD.danjiafanwei_jia[i]>0 then
									PIG_CD.cheduixinxi=PIG_CD.cheduixinxi.."<"..PIG_CD.danjiafanwei_LV[i][1].."-"..PIG_CD.danjiafanwei_LV[i][#PIG_CD.danjiafanwei_LV[i]]..">"..PIG_CD.danjiafanwei_jia[i].."G；";
								else
									PIG_CD.cheduixinxi=PIG_CD.cheduixinxi.."<"..PIG_CD.danjiafanwei_LV[i][1].."-"..PIG_CD.danjiafanwei_LV[i][#PIG_CD.danjiafanwei_LV[i]]..">免费；";
								end
							end
						end
					else
						PIG_CD.cheduixinxi=PIG_CD.cheduixinxi.."0^0~尚未开售，"
					end
					PIG_CD.cheduixinxi=PIG_CD.cheduixinxi.."\n车辆介绍:"..PIG_Per["FarmRecord"]["hanhuaMSG"];
					C_ChatInfo.SendAddonMessage(biaotou,PIG_CD.cheduixinxi,"WHISPER",arg5)
				end
			end
		end
	end
	if event=="CHAT_MSG_ADDON" and arg1 == biaotou then
		table.insert(PIG_CD.ListInfo, {GetServerTime(),arg5,arg2});
	end
	if event=="CHAT_MSG_WHISPER" then
		PIG_CD.cunzaiguanjianzi=arg1:find(PIG_CD.shenqing, 1)
		if PIG_CD.cunzaiguanjianzi then
			if PIG_Per["FarmRecord"]['autohuifu']=="ON" then
				PIG_CD.LVjibie = strsplit("~", arg1);
				PIG_CD.LVjibie = tonumber(PIG_CD.LVjibie)
				PIG_CD.kaishiLV=nil
				PIG_CD.jieshuLV=nil
				for id = 1, 4, 1 do
					local kaishi =PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][1]
					if kaishi~=0 then
						if PIG_CD.kaishiLV==nil then
							PIG_CD.kaishiLV=kaishi
						else
							if PIG_CD.kaishiLV>kaishi then
								PIG_CD.kaishiLV=kaishi
							end
						end
					end
					local jieshu =PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][2]
					if jieshu~=0 then
						if PIG_CD.jieshuLV==nil then
							PIG_CD.jieshuLV=jieshu
						else
							if PIG_CD.jieshuLV<jieshu then
								PIG_CD.jieshuLV=jieshu
							end
						end
					end
				end
				if PIG_CD.kaishiLV and PIG_CD.jieshuLV then
					if PIG_CD.LVjibie>=PIG_CD.kaishiLV and PIG_CD.LVjibie<=PIG_CD.jieshuLV then
						local IsInRaid=IsInRaid("LE_PARTY_CATEGORY_HOME");
						local inGroup = IsInGroup("LE_PARTY_CATEGORY_HOME");
						if IsInRaid then
							local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
							if numGroupMembers<40 then
								if PIG_Per["FarmRecord"]['autoyaoqing']=="ON" then
									InviteUnit(arg5)
								end
							else
								SendChatMessage("已满载，谢谢", "WHISPER", nil, arg5);
							end
						elseif inGroup  then
							local numSubgroupMembers = GetNumSubgroupMembers("LE_PARTY_CATEGORY_HOME")
							if numSubgroupMembers<4 then
								if PIG_Per["FarmRecord"]['autoyaoqing']=="ON" then
									InviteUnit(arg5)
								end
							else
								SendChatMessage("已满载，谢谢", "WHISPER", nil, arg5);
							end
						else
							if PIG_Per["FarmRecord"]['autoyaoqing']=="ON" then
								InviteUnit(arg5)
							end
						end
					end
				end
			else
				SendChatMessage("已收工，谢谢", "WHISPER", nil, arg5);
			end
		end
	end
end)
-- --=============================================================
yixuanzhongShowfuben="全部显示"
local function ADD_Chedui_Frame()
	local fuFrame=PlaneInviteFrame_2;
	local Width,Height=fuFrame:GetWidth(),fuFrame:GetHeight();
	-----------------
	local biaotiName={"副本名","等级要求","乘客","司机","票价","更新时间"}
	for i=1,#biaotiName do
		fuFrame.biaoti = fuFrame:CreateFontString();
		fuFrame.biaoti:SetFontObject(GameFontNormal);
		fuFrame.biaoti:SetText(biaotiName[i]);
		if i==1 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",10,-8);
		elseif i==2 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",160,-8);
		elseif i==3 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",242,-8);
		elseif i==4 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",286,-8);
		elseif i==5 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",410,-8);
		elseif i==6 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",630,-8);
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
			_G["CheduiList_"..i]:Hide()
			_G["CheduiList_"..i].Mudidi:SetText();
			_G["CheduiList_"..i].Name.T:SetText();
			_G["CheduiList_"..i].Name.T:SetTextColor(1, 1, 1,1)
			_G["CheduiList_"..i].Chengke.renshu:SetText();
			_G["CheduiList_"..i].Chengke.xiangqing:SetText();
			_G["CheduiList_"..i].LVfanwei:SetText();
			_G["CheduiList_"..i].xiangqing.t:SetText();
			_G["CheduiList_"..i].Time:SetText();	
		end
		if #PIG_CD.ListInfo>0 then
			fuFrame.shuaxinweimian.err:Hide();
			--按过滤提取	
			local guolvhouINFO = {};
			local ItemsNum = #PIG_CD.ListInfo;	
			for i = 1, ItemsNum do
				local daozhanming, englishClass,duiwuinfo,LVmin_LVmax, xiangqingmsg = strsplit("~", PIG_CD.ListInfo[i][3]);
				if xiangqingmsg then
					if yixuanzhongShowfuben=="全部显示" then
						local linshiINFO = {PIG_CD.ListInfo[i][1],PIG_CD.ListInfo[i][2],daozhanming, englishClass,duiwuinfo,LVmin_LVmax, xiangqingmsg};
						table.insert(guolvhouINFO,linshiINFO)
					else
						if daozhanming==yixuanzhongShowfuben then
							local linshiINFO = {PIG_CD.ListInfo[i][1],PIG_CD.ListInfo[i][2],daozhanming, englishClass,duiwuinfo,LVmin_LVmax, xiangqingmsg};
							table.insert(guolvhouINFO,linshiINFO)
						end
					end
				end		
			end
			local guolvItemsNum = #guolvhouINFO;
			if guolvItemsNum>0 then
				FauxScrollFrame_Update(self, guolvItemsNum, hang_NUM, hang_Height);
				local offset = FauxScrollFrame_GetOffset(self);
				for i = 1, hang_NUM do
					local dangqian = i+offset;
					if guolvhouINFO[dangqian] then
						_G["CheduiList_"..i]:Show()
						_G["CheduiList_"..i].Time:SetText(date("%H:%M:%S",guolvhouINFO[dangqian][1]));
						_G["CheduiList_"..i].Name.T:SetText(guolvhouINFO[dangqian][2]);
						_G["CheduiList_"..i].Mudidi:SetText(guolvhouINFO[dangqian][3]);
						local rrr, yyy, bbb, argbHex = GetClassColor(guolvhouINFO[dangqian][4]);
						_G["CheduiList_"..i].Name.T:SetTextColor(rrr, yyy, bbb,1)

						local renyuan= {strsplit("^", guolvhouINFO[dangqian][5])};
						_G["CheduiList_"..i].Chengke.renshu:SetText(renyuan[1]);

						PIG_CD.duiwuLVjibei="乘客等级："
						for g=2,#renyuan-1 do
							PIG_CD.duiwuLVjibei=PIG_CD.duiwuLVjibei..renyuan[g].."，"
						end
						_G["CheduiList_"..i].Chengke.xiangqing:SetText(PIG_CD.duiwuLVjibei);
						local LVmin,LVmax= strsplit("^", guolvhouINFO[dangqian][6]);
						_G["CheduiList_"..i].LVfanwei:SetText(LVmin.."|cFF888888 — |r"..LVmax);
						local xianyou,zuidaren= strsplit("/", renyuan[1]);
						if tonumber(xianyou)==0 and tonumber(zuidaren)==0 then
							_G["CheduiList_"..i].miyu:Enable()
							_G["CheduiList_"..i].miyu:SetText("提示升级");
						else
							local dangqianLVV=UnitLevel("player")
							if dangqianLVV>=tonumber(LVmin) and dangqianLVV<=tonumber(LVmax) then
								if tonumber(xianyou)<tonumber(zuidaren) then
									_G["CheduiList_"..i].miyu:Enable()
									_G["CheduiList_"..i].miyu:SetText("申请上车");
								else
									_G["CheduiList_"..i].miyu:Disable()
									_G["CheduiList_"..i].miyu:SetText("已满员");
								end
							else
								_G["CheduiList_"..i].miyu:Disable()
								_G["CheduiList_"..i].miyu:SetText("等级不符");
							end
						end
						_G["CheduiList_"..i].xiangqing.t:SetText(guolvhouINFO[dangqian][7]);	
					end
				end
			end
		else
			fuFrame.shuaxinweimian.err:Show();
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
		local liebiao = CreateFrame("Frame", "CheduiList_"..i, fuFrame.Scroll:GetParent());
		liebiao:SetSize(Width-30,hang_Height);
		if i==1 then
			liebiao:SetPoint("TOPLEFT", fuFrame.Scroll, "TOPLEFT", 0, -3);
		else
			liebiao:SetPoint("TOPLEFT", _G["CheduiList_"..(i-1)], "BOTTOMLEFT", 0, -2);
		end
		liebiao:Hide()
		liebiao.line = liebiao:CreateLine()
		liebiao.line:SetColorTexture(1,1,1,0.2)
		liebiao.line:SetThickness(1);
		liebiao.line:SetStartPoint("BOTTOMLEFT",0,0)
		liebiao.line:SetEndPoint("BOTTOMRIGHT",0,0)

		liebiao.Mudidi = liebiao:CreateFontString();
		liebiao.Mudidi:SetPoint("LEFT", liebiao, "LEFT", 10, 0);
		liebiao.Mudidi:SetFontObject(ChatFontNormal);
		liebiao.Mudidi:SetTextColor(1,1,0, 1);

		liebiao.LVfanwei = liebiao:CreateFontString();
		liebiao.LVfanwei:SetPoint("LEFT", liebiao, "LEFT", 164, 0);
		liebiao.LVfanwei:SetFontObject(ChatFontNormal);

		liebiao.Chengke = CreateFrame("Frame", nil, liebiao);
		liebiao.Chengke:SetSize(30,hang_Height);
		liebiao.Chengke:SetPoint("LEFT", liebiao, "LEFT", 244, 0);
		liebiao.Chengke.renshu = liebiao.Chengke:CreateFontString();
		liebiao.Chengke.renshu:SetPoint("LEFT", liebiao.Chengke, "LEFT", 0, 0);
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
		liebiao.Name:SetSize(120,hang_Height);
		liebiao.Name:SetPoint("LEFT", liebiao, "LEFT", 288, 0);
		--liebiao.Name:EnableMouse(true)
		liebiao.Name.T = liebiao.Name:CreateFontString();
		liebiao.Name.T:SetPoint("LEFT", liebiao.Name, "LEFT", 0, 0);
		liebiao.Name.T:SetFontObject(ChatFontNormal);
		liebiao.Name:SetScript("OnMouseUp", function(self,button)
			local name = self.T:GetText()
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
				addonTable.YCchaokanzhuangbei(name)
			end
		end)

		liebiao.xiangqing = CreateFrame("Frame", nil, liebiao);
		liebiao.xiangqing:SetSize(200,hang_Height);
		liebiao.xiangqing:SetPoint("LEFT", liebiao, "LEFT", 410, 0);
		liebiao.xiangqing.t = liebiao.xiangqing:CreateFontString();
		liebiao.xiangqing.t:SetPoint("LEFT", liebiao.xiangqing, "LEFT", 0, 0);
		liebiao.xiangqing.t:SetFontObject(ChatFontNormal);
		liebiao.xiangqing.t:SetTextColor(0,250/255,154/255, 1);
		liebiao.xiangqing.t:SetSize(200,hang_Height);
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

		liebiao.Time = liebiao:CreateFontString();
		liebiao.Time:SetPoint("LEFT", liebiao, "LEFT", 632, 0);
		liebiao.Time:SetFontObject(ChatFontNormal);
		liebiao.Time:SetTextColor(1,1,1, 0.6);

		liebiao.miyu = CreateFrame("Button",nil,liebiao, "UIPanelButtonTemplate");
		liebiao.miyu:SetSize(70,20);
		liebiao.miyu:SetPoint("LEFT",liebiao,"LEFT",730,0);
		liebiao.miyu:SetText("申请上车");
		liebiao.miyu.Font=liebiao.miyu:GetFontString()
		liebiao.miyu.Font:SetFont(ChatFontNormal:GetFont(), 10);
		liebiao.miyu:SetScript("OnClick", function(self)
			local name = self:GetParent().Name.T:GetText()
			if self:GetText()=="提示升级" then
				SendChatMessage("你的!Pig插件版本过旧，我无法申请上车，请升级下插件！", "WHISPER", nil, name);
				liebiao.miyu:Disable()
				liebiao.miyu:SetText("已提醒");
				return
			end
			local qingqiuMSG = UnitLevel("player").."~级，申请上车！", "WHISPER";
			SendChatMessage(qingqiuMSG, "WHISPER", nil, name);
			liebiao.miyu:Disable()
			liebiao.miyu:SetText("已申请");
		end)

		-- liebiao.siliao = CreateFrame("Button",nil,liebiao, "UIPanelButtonTemplate");
		-- liebiao.siliao:SetSize(70,20);
		-- liebiao.siliao:SetPoint("LEFT",liebiao,"LEFT",790,0);
		-- liebiao.siliao:SetText("密");
		-- liebiao.siliao.Font=liebiao.siliao:GetFontString()
		-- liebiao.siliao.Font:SetFont(ChatFontNormal:GetFont(), 10);
		-- liebiao.siliao:SetScript("OnClick", function(self)
		-- 	local name = self:GetParent().Name.T:GetText()
		-- end)
	end
	-----
	fuFrame.guolvfubenT = fuFrame:CreateFontString();
	fuFrame.guolvfubenT:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,40);
	fuFrame.guolvfubenT:SetFontObject(ChatFontNormal);
	fuFrame.guolvfubenT:SetTextColor(0,250/255,154/255, 1);
	fuFrame.guolvfubenT:SetText("显示副本:");
	fuFrame.guolvfubenN = CreateFrame("FRAME", nil, fuFrame, "UIDropDownMenuTemplate")
	fuFrame.guolvfubenN:SetPoint("LEFT",fuFrame.guolvfubenT,"RIGHT",-12,-3)
	UIDropDownMenu_SetWidth(fuFrame.guolvfubenN, 120)
	local suodaifuben=addonTable.daibenmulu
	UIDropDownMenu_Initialize(fuFrame.guolvfubenN, function(self)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		for i=1,#suodaifuben,1 do
			if suodaifuben[i]=="无" then 
			    info.text, info.arg1 = "全部显示", "全部显示"
			else
				info.text, info.arg1 = suodaifuben[i], suodaifuben[i]
			end
			UIDropDownMenu_AddButton(info)
		end 
	end)
	function fuFrame.guolvfubenN:SetValue(newValue)
		UIDropDownMenu_SetText(fuFrame.guolvfubenN, newValue)
		yixuanzhongShowfuben=newValue
		CloseDropDownMenus()
		gengxinhang(fuFrame.Scroll)
	end
	UIDropDownMenu_SetText(fuFrame.guolvfubenN, yixuanzhongShowfuben)
	---
	fuFrame.jieshoushuju = CreateFrame("Frame", nil, fuFrame);
	fuFrame.jieshoushuju:SetSize(160,20);
	fuFrame.jieshoushuju:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,20);
	fuFrame.jieshoushuju:Hide();
	fuFrame.jieshoushuju.jindu = fuFrame.jieshoushuju:CreateTexture(nil, "BORDER");
	fuFrame.jieshoushuju.jindu:SetTexture("interface/raidframe/raid-bar-hp-fill.blp");
	fuFrame.jieshoushuju.jindu:SetColorTexture(0.3, 0.7, 0.1, 1)
	fuFrame.jieshoushuju.jindu:SetSize(156,16);
	fuFrame.jieshoushuju.jindu:SetPoint("LEFT",fuFrame.jieshoushuju,"LEFT",2,0);
	fuFrame.jieshoushuju.edg = CreateFrame("Frame", nil, fuFrame.jieshoushuju,"BackdropTemplate");
	fuFrame.jieshoushuju.edg:SetBackdrop( { edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 14,});
	fuFrame.jieshoushuju.edg:SetAllPoints(fuFrame.jieshoushuju)
	fuFrame.jieshoushuju.edg.t = fuFrame.jieshoushuju.edg:CreateFontString();
	fuFrame.jieshoushuju.edg.t:SetPoint("CENTER",fuFrame.jieshoushuju.edg,"CENTER",0,0);
	fuFrame.jieshoushuju.edg.t:SetFont(GameFontNormal:GetFont(), 12)
	fuFrame.jieshoushuju.edg.t:SetText("正在接收数据...");
	local yanchishuaxinliebiao = 3
	local zhengzaihuoqudaojishi = yanchishuaxinliebiao
	fuFrame.jieshoushuju:SetScript("OnUpdate", function(self,sss)
		zhengzaihuoqudaojishi = zhengzaihuoqudaojishi-sss
		if zhengzaihuoqudaojishi>0 then
			fuFrame.jieshoushuju.jindu:SetWidth(156*((yanchishuaxinliebiao-zhengzaihuoqudaojishi)/yanchishuaxinliebiao))
		else
			fuFrame.jieshoushuju:Hide()
		end
	end);
	------
	local function shuaxinweimianliebiao()
		gengxinhang(fuFrame.Scroll)
	end
	fuFrame.morenjiange=60
	fuFrame.daojishiJG =fuFrame.morenjiange;
	local function Chedui_daojishi(laiyuan)
		if laiyuan then
			fuFrame.daojishiJG =fuFrame.morenjiange;
		end
		if fuFrame.daojishiJG>0 then
			fuFrame.shuaxinweimian:SetText("更新车队信息("..fuFrame.daojishiJG..")");
			C_Timer.After(1,Chedui_daojishi)
			fuFrame.daojishiJG=fuFrame.daojishiJG-1
		else
			fuFrame.shuaxinweimian:Enable() 
			fuFrame.shuaxinweimian:SetText("更新车队信息");
		end
	end
	addonTable.Chedui_daojishi=Chedui_daojishi

	fuFrame.shuaxinweimian = CreateFrame("Button","huoquchedui_UI",fuFrame, "UIPanelButtonTemplate");  
	fuFrame.shuaxinweimian:SetSize(136,24);
	fuFrame.shuaxinweimian:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",260,28);
	fuFrame.shuaxinweimian:SetText("获取车队信息");
	fuFrame.shuaxinweimian.err = fuFrame.shuaxinweimian:CreateFontString();
	fuFrame.shuaxinweimian.err:SetPoint("BOTTOMLEFT",fuFrame.shuaxinweimian,"TOPLEFT",2,0);
	fuFrame.shuaxinweimian.err:SetFont(GameFontNormal:GetFont(), 14)
	fuFrame.shuaxinweimian.err:SetText("获取数据异常，请稍后再试!");
	fuFrame.shuaxinweimian.err:SetTextColor(1, 0.4, 0, 1);
	fuFrame.shuaxinweimian.err:Hide();
	fuFrame.shuaxinweimian:SetScript("OnClick", function (self)
		local channelheji = {GetChannelList()};
		channelheji.yijiaruPIG=true
		for i=1,#channelheji do
			if channelheji[i]=="PIG" then
				self:Disable();
				PIG_CD.ListInfo={};
				local msg = "请求车队信息";
				SendChatMessage(msg,"CHANNEL",nil,channelheji[i-1])
				C_Timer.After(yanchishuaxinliebiao,shuaxinweimianliebiao)
				fuFrame.daojishiJG =fuFrame.morenjiange;
				fuFrame.shuaxinweimian:SetText("更新车队信息("..fuFrame.daojishiJG..")");
				fuFrame.jieshoushuju:Show();
				zhengzaihuoqudaojishi = yanchishuaxinliebiao		
				Chedui_daojishi()
				addonTable.Weimian_daojishi(true)
				huiquweimian_UI:Disable();
				channelheji.yijiaruPIG=false
				break
			end
		end
		if channelheji.yijiaruPIG then
			print("|cff00FFFF!Pig:|r|cffFFFF00请先加入PIG频道获取车队信息！|r")
		end
	end);
end
addonTable.ADD_Chedui_Frame=ADD_Chedui_Frame