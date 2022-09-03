local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
-- ----------------------------------
local biaotou='!Pig-Chedui';
local PIG_CD={}
PIG_CD.ListInfo={};
local CDWMinfo=addonTable.CDWMinfo
local SQPindao = CDWMinfo[1]
local qingqiumsg = CDWMinfo[3];
local shenqingMSG = "级，申请上车！"
C_ChatInfo.RegisterAddonMessagePrefix(biaotou)
local CheduiFFFFF = CreateFrame("Frame")
CheduiFFFFF:RegisterEvent("CHAT_MSG_CHANNEL");
CheduiFFFFF:RegisterEvent("CHAT_MSG_ADDON");
CheduiFFFFF:RegisterEvent("CHAT_MSG_WHISPER"); 
CheduiFFFFF:SetScript("OnEvent",function(self, event, arg1, arg2, _, _, arg5,_,_,_,arg9)
	local huoquLVminmax=huoquLVminmax or addonTable.huoquLVminmax
	local huoquLVdanjia=huoquLVdanjia or addonTable.huoquLVdanjia 
	if PIG_Per.daiben.Open and PIG_Per.daiben.autohuifu then
		if event=="CHAT_MSG_CHANNEL" then
			if arg9==SQPindao and arg1==qingqiumsg then
				local _, englishClass, _ = UnitClass("player");
				local mudidi=PIG_Per.daiben.fubenName
				if mudidi~="无" then
					PIG_CD.cheduixinxi=mudidi.."~"..englishClass.."~"
					--队伍LV
					--local IsInRaid=IsInRaid();
					local inGroup = IsInGroup();
					if inGroup  then
						local numSubgroupMembers = GetNumSubgroupMembers()
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
					local min,max=huoquLVminmax()
					PIG_CD.cheduixinxi=PIG_CD.cheduixinxi..min.."^"..max.."~"
					local danjiaxinxi=huoquLVdanjia()
					PIG_CD.cheduixinxi=PIG_CD.cheduixinxi..danjiaxinxi
					PIG_CD.cheduixinxi=PIG_CD.cheduixinxi.."\n车辆介绍:"..PIG_Per.daiben.autohuifu_NR;
					C_ChatInfo.SendAddonMessage(biaotou,PIG_CD.cheduixinxi,"WHISPER",arg5)
				end
			end
		end
	end
	if event=="CHAT_MSG_ADDON" and arg1 == biaotou then
		table.insert(PIG_CD.ListInfo, {GetServerTime(),arg5,arg2});
	end
	local function Invwanjia(arg5)
		if PIG_Per.daiben.autohuifu_inv then
			if tocversion<40000 then
				InviteUnit(arg5)
			else
				C_PartyInfo.ConfirmInviteUnit(arg5)
			end
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
					--local IsInRaid=IsInRaid();
					if IsInGroup() then
						local numSubgroupMembers = GetNumSubgroupMembers()
						if numSubgroupMembers<4 then
							Invwanjia(arg5)
						else
							SendChatMessage("已满员，谢谢", "WHISPER", nil, arg5);
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
yixuanzhongShowfuben="全部显示"
local function ADD_Chedui_Frame()
	local fuFrame=PlaneInviteFrame_2;
	local Width,Height=fuFrame:GetWidth(),fuFrame:GetHeight();
	-----------------
	local biaotiName={"副本名","等级要求","乘客","司机","票价","更新时间"}
	local biaotiNameL={10,140,220,270,430,690}
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
		elseif i==4 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",biaotiNameL[i],-8);
		elseif i==5 then
			fuFrame.biaoti:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",biaotiNameL[i],-8);
		elseif i==6 then
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
	local function gengxinhang(self,guolv)
		for i = 1, hang_NUM do
			local fujiak = _G["CheduiList_"..i]
			fujiak:Hide()
			fujiak.Mudidi:SetText();
			fujiak.Name.T:SetText();
			fujiak.Name.T:SetTextColor(1, 1, 1,1)
			fujiak.Chengke.renshu:SetText();
			fujiak.Chengke.xiangqing:SetText();
			fujiak.LVfanwei:SetText();
			fujiak.xiangqing.t:SetText();
			fujiak.Time:SetText();	
		end
		if #PIG_CD.ListInfo>0 then
			fuFrame.shuaxinChedui.err:Hide();
			--按过滤提取	
			local guolvhouINFO = {};
			local ItemsNum = #PIG_CD.ListInfo;	
			for i = 1, ItemsNum do
				local daozhanming, englishClass,duiwuinfo,LVmin_LVmax, xiangqingmsg = strsplit("~", PIG_CD.ListInfo[i][3]);
				if xiangqingmsg then
					if yixuanzhongShowfuben=="全部显示" then
						local linshiINFO = {PIG_CD.ListInfo[i][1],PIG_CD.ListInfo[i][2],daozhanming, englishClass,duiwuinfo,LVmin_LVmax, xiangqingmsg,PIG_CD.ListInfo[i][4]};
						table.insert(guolvhouINFO,linshiINFO)
					else
						if daozhanming==yixuanzhongShowfuben then
							local linshiINFO = {PIG_CD.ListInfo[i][1],PIG_CD.ListInfo[i][2],daozhanming, englishClass,duiwuinfo,LVmin_LVmax, xiangqingmsg,PIG_CD.ListInfo[i][4]};
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
						local fujiak = _G["CheduiList_"..i]
						fujiak:Show()
						fujiak.Time:SetText(date("%H:%M:%S",guolvhouINFO[dangqian][1]));
						fujiak.Name.T:SetText(guolvhouINFO[dangqian][2]);
						fujiak.Mudidi:SetText(guolvhouINFO[dangqian][3]);
						local rrr, yyy, bbb, argbHex = GetClassColor(guolvhouINFO[dangqian][4]);
						fujiak.Name.T:SetTextColor(rrr, yyy, bbb,1)

						local renyuan= {strsplit("^", guolvhouINFO[dangqian][5])};
						fujiak.Chengke.renshu:SetText(renyuan[1]);

						PIG_CD.duiwuLVjibei="乘客等级："
						for g=2,#renyuan-1 do
							PIG_CD.duiwuLVjibei=PIG_CD.duiwuLVjibei..renyuan[g].."，"
						end
						fujiak.Chengke.xiangqing:SetText(PIG_CD.duiwuLVjibei);
						local LVmin,LVmax= strsplit("^", guolvhouINFO[dangqian][6]);
						fujiak.LVfanwei:SetText(LVmin.."|cFF888888 — |r"..LVmax);
						local xianyou,zuidaren= strsplit("/", renyuan[1]);
						if tonumber(xianyou)==0 and tonumber(zuidaren)==0 then
							fujiak.miyu:Enable()
							fujiak.miyu:SetText("提示升级");
						else
							local dangqianLVV=UnitLevel("player")
							if dangqianLVV>=tonumber(LVmin) and dangqianLVV<=tonumber(LVmax) then
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
						end
						fujiak.miyu:SetID(dangqian)
						fujiak.xiangqing.t:SetText(guolvhouINFO[dangqian][7]);	
					end
				end
			end
		else
			if guolv~="guolvlist" then
				fuFrame.shuaxinChedui.err:Show();
			end
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
		liebiao.Mudidi:SetPoint("LEFT", liebiao, "LEFT", biaotiNameL[1], 0);
		liebiao.Mudidi:SetFontObject(ChatFontNormal);
		liebiao.Mudidi:SetTextColor(1,1,0, 1);

		liebiao.LVfanwei = liebiao:CreateFontString();
		liebiao.LVfanwei:SetPoint("LEFT", liebiao, "LEFT", biaotiNameL[2], 0);
		liebiao.LVfanwei:SetFontObject(ChatFontNormal);

		liebiao.Chengke = CreateFrame("Frame", nil, liebiao);
		liebiao.Chengke:SetSize(30,hang_Height);
		liebiao.Chengke:SetPoint("LEFT", liebiao, "LEFT", biaotiNameL[3], 0);
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
		liebiao.Name:SetPoint("LEFT", liebiao, "LEFT", biaotiNameL[4], 0);
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
		local xqwww = 252
		liebiao.xiangqing = CreateFrame("Frame", nil, liebiao);
		liebiao.xiangqing:SetSize(xqwww,hang_Height);
		liebiao.xiangqing:SetPoint("LEFT", liebiao, "LEFT", biaotiNameL[5], 0);
		liebiao.xiangqing.t = liebiao.xiangqing:CreateFontString();
		liebiao.xiangqing.t:SetPoint("LEFT", liebiao.xiangqing, "LEFT", 0, 0);
		liebiao.xiangqing.t:SetFontObject(ChatFontNormal);
		liebiao.xiangqing.t:SetTextColor(0,250/255,154/255, 1);
		liebiao.xiangqing.t:SetSize(xqwww,hang_Height);
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
		liebiao.Time:SetPoint("LEFT", liebiao, "LEFT", biaotiNameL[6]+2, 0);
		liebiao.Time:SetFontObject(ChatFontNormal);
		liebiao.Time:SetTextColor(1,1,1, 0.6);

		liebiao.miyu = CreateFrame("Button",nil,liebiao, "UIPanelButtonTemplate");
		liebiao.miyu:SetSize(70,20);
		liebiao.miyu:SetPoint("RIGHT",liebiao,"RIGHT",-6,0);
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
			local wanjiananem = self:GetParent().Name.T:GetText()
			for i=1,#PIG_CD.ListInfo do
				if PIG_CD.ListInfo[i][2]==wanjiananem then
					PIG_CD.ListInfo[i][4]=true
					break
				end
			end
		end)
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
	function fuFrame.guolvfubenN:SetValue(newValue)
		UIDropDownMenu_SetText(fuFrame.guolvfubenN, newValue)
		yixuanzhongShowfuben=newValue
		CloseDropDownMenus()
		gengxinhang(fuFrame.Scroll,"guolvlist")
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
	fuFrame.jieshoushuju.edg:SetBackdropBorderColor(0, 1, 1, 0.9);
	fuFrame.jieshoushuju.edg:SetAllPoints(fuFrame.jieshoushuju)
	fuFrame.jieshoushuju.edg.t = fuFrame.jieshoushuju.edg:CreateFontString();
	fuFrame.jieshoushuju.edg.t:SetPoint("CENTER",fuFrame.jieshoushuju.edg,"CENTER",0,0);
	fuFrame.jieshoushuju.edg.t:SetFont(GameFontNormal:GetFont(), 12)
	fuFrame.jieshoushuju.edg.t:SetText("正在接收数据...");
	local yanchishuaxinliebiao = 3
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

	fuFrame.morenjiange=120
	fuFrame.daojishiJG =PIG['PlaneInvite']['Cheduidaojishi'] or 0;
	local function Chedui_daojishi()	
		local chazhiV = GetServerTime()-fuFrame.daojishiJG
		if chazhiV>fuFrame.morenjiange then
			if PlaneInvite_UI.yijiaru then
				fuFrame.shuaxinChedui:Enable()
			else
				fuFrame.shuaxinChedui:Disable()
			end
			fuFrame.shuaxinChedui:SetText("更新车队信息");
		else
			fuFrame.shuaxinChedui:SetText("更新车队信息("..fuFrame.morenjiange-chazhiV..")");
			C_Timer.After(1,Chedui_daojishi)
			fuFrame.shuaxinChedui:Disable() 
		end
	end

	fuFrame.shuaxinChedui = CreateFrame("Button","huoquchedui_UI",fuFrame, "UIPanelButtonTemplate");  
	fuFrame.shuaxinChedui:SetSize(136,24);
	fuFrame.shuaxinChedui:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",260,28);
	fuFrame.shuaxinChedui:SetText("获取车队信息");
	fuFrame.shuaxinChedui.err = fuFrame.shuaxinChedui:CreateFontString();
	fuFrame.shuaxinChedui.err:SetPoint("BOTTOMLEFT",fuFrame.shuaxinChedui,"TOPLEFT",2,0);
	fuFrame.shuaxinChedui.err:SetFont(GameFontNormal:GetFont(), 14)
	fuFrame.shuaxinChedui.err:SetText("未获取到车队信息，请稍后再试!");
	fuFrame.shuaxinChedui.err:SetTextColor(1, 0.4, 0, 1);
	fuFrame.shuaxinChedui.err:Hide();
	fuFrame.shuaxinChedui:SetScript("OnClick", function (self)
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
	
		PIG_CD.ListInfo={};
		SendChatMessage(qingqiumsg,"CHANNEL",nil,pindaolheji.PIGID)
		C_Timer.After(yanchishuaxinliebiao,shuaxinweimianliebiao)

		self:Disable();
		fuFrame.jieshoushuju:Show();
		fuFrame.zhengzaihuoqudaojishi = yanchishuaxinliebiao

		fuFrame.daojishiJG =GetServerTime();
		PIG['PlaneInvite']['Cheduidaojishi']=fuFrame.daojishiJG
		Chedui_daojishi()
	end);
	Chedui_daojishi()
	-----------
	fuFrame:SetScript("OnShow", function (self)
		local suodaifuben=addonTable.daibenData.mudidiList
		UIDropDownMenu_Initialize(fuFrame.guolvfubenN, function(self)
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			for i=1,#suodaifuben,1 do
				if suodaifuben[i]=="无" then 
				    info.text, info.arg1, info.checked = "全部显示", "全部显示","全部显示" == yixuanzhongShowfuben;
				else
					info.text, info.arg1, info.checked = suodaifuben[i], suodaifuben[i], suodaifuben[i] == yixuanzhongShowfuben;
				end
				UIDropDownMenu_AddButton(info)
			end 
		end)
	end)
end
addonTable.ADD_Chedui_Frame=ADD_Chedui_Frame