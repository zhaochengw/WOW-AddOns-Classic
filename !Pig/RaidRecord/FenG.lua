local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local ADD_Frame=addonTable.ADD_Frame
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local PIGDownMenu=addonTable.PIGDownMenu
--=====分G助手==============================
local function ADD_fenG()
	local Width,Height  = RaidR_UI:GetWidth(), RaidR_UI:GetHeight();
	local duiwu_Width,duiwu_Height,duiwujiange=186,28,10;
	----
	local fenG=ADD_Frame("fenG_UI",RaidR_UI,Width-22,Height-100,"TOP",RaidR_UI,"TOP",0,-18,true,false,false,false,false,"BG6")
	fenG:SetFrameLevel(RaidR_UI:GetFrameLevel()+10);

	fenG.Close = CreateFrame("Button",nil,fenG, "UIPanelCloseButton");  
	fenG.Close:SetSize(34,34);
	fenG.Close:SetPoint("TOPRIGHT",fenG,"TOPRIGHT",2.4,3);

	--计算分G
	local zhizeIcon = {{0.01,0.26,0.26,0.51},{0.27,0.52,0,0.25},{0.01,0.26,0,0.25}};
	local fenGbiliIcon = {
		"interface/gossipframe/transmogrifygossipicon.blp",
		"interface/glues/characterselect/glues-addon-icons.blp",
		"interface/glues/characterselect/glues-addon-icons.blp",}
	local fenGbiliIconCaiqie = {{0,1,0,1},{0.75,1,0,1},{0.49,0.75,0,1}}
	local function jisuanfenGData()
		for x=1,8 do
			_G["duiwuF_UI_"..x].tongzhi:Hide();
			_G["duiwuF_UI_"..x].G_V:SetText()
			for xx=1,5 do
				_G["duiwu_"..x.."_"..xx]:Hide();
				_G["duiwu_"..x.."_"..xx].Players.name:SetText();
				_G["duiwu_"..x.."_"..xx].Players.G:SetText();
				_G["duiwu_"..x.."_"..xx].buzhu:SetWidth(0.001);
				_G["duiwu_"..x.."_"..xx].fenGbili:SetWidth(0.001);
				_G["duiwu_"..x.."_"..xx].mail:SetWidth(0.001);
			end
		end
		local zongrenshu,shuangbeirenshu,banrenshu,bufenrenshu=0,0,0,0;
		local buzhurenshu_T,buzhurenshu_N,buzhurenshu_LR=0,0,0;
		for x=1,8 do
			for xx=1,#PIG["RaidRecord"]["Raidinfo"][x] do
				if #PIG["RaidRecord"]["Raidinfo"][x][xx]>0 then
					zongrenshu=zongrenshu+1;
					_G["duiwuF_UI_"..x].tongzhi:Show();
					_G["duiwu_"..x.."_"..xx]:Show();
					local _, _, _, wanjiaName = PIG["RaidRecord"]["Raidinfo"][x][xx][4]:find("((.+)-)");
					if wanjiaName then
						_G["duiwu_"..x.."_"..xx].Players.name:SetText(wanjiaName);
					else
						_G["duiwu_"..x.."_"..xx].Players.name:SetText(PIG["RaidRecord"]["Raidinfo"][x][xx][4]);
					end
					_G["duiwu_"..x.."_"..xx].Players:SetWidth(_G["duiwu_"..x.."_"..xx].Players.name:GetWidth())
					_G["duiwu_"..x.."_"..xx].Players.name:SetTextColor(PIG["RaidRecord"]["Raidinfo"][x][xx][2][1],PIG["RaidRecord"]["Raidinfo"][x][xx][2][2],PIG["RaidRecord"]["Raidinfo"][x][xx][2][3], 1);
					if PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="坦克补助" then
						buzhurenshu_T=buzhurenshu_T+1;
						_G["duiwu_"..x.."_"..xx].buzhu:SetTexCoord(zhizeIcon[1][1],zhizeIcon[1][2],zhizeIcon[1][3],zhizeIcon[1][4]);
						_G["duiwu_"..x.."_"..xx].buzhu:SetWidth(duiwu_Height-8);
					elseif PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="治疗补助" then
						buzhurenshu_N=buzhurenshu_N+1;
						_G["duiwu_"..x.."_"..xx].buzhu:SetTexCoord(zhizeIcon[2][1],zhizeIcon[2][2],zhizeIcon[2][3],zhizeIcon[2][4]);
						_G["duiwu_"..x.."_"..xx].buzhu:SetWidth(duiwu_Height-8);
					elseif PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="其他补助" then
						buzhurenshu_LR=buzhurenshu_LR+1;
						_G["duiwu_"..x.."_"..xx].buzhu:SetTexCoord(zhizeIcon[3][1],zhizeIcon[3][2],zhizeIcon[3][3],zhizeIcon[3][4]);
						_G["duiwu_"..x.."_"..xx].buzhu:SetWidth(duiwu_Height-8);
					end
					if PIG["RaidRecord"]["Raidinfo"][x][xx][7]==2 then
						shuangbeirenshu=shuangbeirenshu+1;
						_G["duiwu_"..x.."_"..xx].fenGbili:SetTexCoord(0,1,0,1);
						_G["duiwu_"..x.."_"..xx].fenGbili:SetTexture(fenGbiliIcon[1]);
						_G["duiwu_"..x.."_"..xx].fenGbili:SetWidth(duiwu_Height-8);
					elseif PIG["RaidRecord"]["Raidinfo"][x][xx][7]==0.5 then
						banrenshu=banrenshu+1;
						_G["duiwu_"..x.."_"..xx].fenGbili:SetTexture(fenGbiliIcon[2]);
						_G["duiwu_"..x.."_"..xx].fenGbili:SetTexCoord(fenGbiliIconCaiqie[2][1],fenGbiliIconCaiqie[2][2],fenGbiliIconCaiqie[2][3],fenGbiliIconCaiqie[2][4]);
						_G["duiwu_"..x.."_"..xx].fenGbili:SetWidth(duiwu_Height-8);
					elseif PIG["RaidRecord"]["Raidinfo"][x][xx][7]==0 then
						bufenrenshu=bufenrenshu+1;
						_G["duiwu_"..x.."_"..xx].fenGbili:SetTexture(fenGbiliIcon[3]);
						_G["duiwu_"..x.."_"..xx].fenGbili:SetTexCoord(fenGbiliIconCaiqie[3][1],fenGbiliIconCaiqie[3][2],fenGbiliIconCaiqie[3][3],fenGbiliIconCaiqie[3][4]);
						_G["duiwu_"..x.."_"..xx].fenGbili:SetWidth(duiwu_Height-10);
					end
					--邮寄图标
					if PIG["RaidRecord"]["Raidinfo"][x][xx][9]==1 then--需邮寄
						if PIG["RaidRecord"]["Raidinfo"][x][xx][10]==0 then
							_G["duiwu_"..x.."_"..xx].mail.Tex:SetTexture("interface/cursor/mail.blp");
						elseif PIG["RaidRecord"]["Raidinfo"][x][xx][10]==1 then
							_G["duiwu_"..x.."_"..xx].mail.Tex:SetTexture("interface/cursor/unablemail.blp");
						end
						_G["duiwu_"..x.."_"..xx].mail:SetWidth(duiwu_Height-8);
					end
				end
			end
		end
		fenG.rensh_ALL_V:SetText(zongrenshu);
		fenG.renshu_fenGbili_V:SetText(shuangbeirenshu);
		fenG.renshu_fenGbili_1_V:SetText(banrenshu);
		fenG.renshu_fenGbili_2_V:SetText(bufenrenshu);
		fenG.renshu_buzhu_T_V:SetText(buzhurenshu_T);
		fenG.renshu_buzhu_N_V:SetText(buzhurenshu_N);
		fenG.renshu_buzhu_LR_V:SetText(buzhurenshu_LR);
		--
		fenG.renjunshouru_V:SetText(0);
		fenG.renjunshouru_1_V:SetText(0);
		fenG.renjunshouru_2_V:SetText(0);
		local jingshouru=tonumber(RaidR_UI.xiafangF.Jing_RS_V:GetText());
		if jingshouru>0 and zongrenshu>0 then
			if banrenshu==0 and shuangbeirenshu==0 then
				local pingjunshouru=jingshouru/(zongrenshu-bufenrenshu+shuangbeirenshu);--平均收入
				fenG.renjunshouru_V:SetText(floor(pingjunshouru));
			else
				if banrenshu>0 and shuangbeirenshu>0 then
					local pingjunshouru=jingshouru/(zongrenshu-bufenrenshu+shuangbeirenshu);--平均收入
					fenG.renjunshouru_2_V:SetText(floor(pingjunshouru/2));
					local Qrenjunshouru=(pingjunshouru*(zongrenshu-bufenrenshu+shuangbeirenshu-banrenshu)+pingjunshouru/2*banrenshu)/(zongrenshu-bufenrenshu+shuangbeirenshu-banrenshu);--减去半工平均收入
					fenG.renjunshouru_V:SetText(floor(Qrenjunshouru));
					fenG.renjunshouru_1_V:SetText(floor(Qrenjunshouru*2));
				else
					if banrenshu>0 then
						local pingjunshouru=jingshouru/(zongrenshu-bufenrenshu+shuangbeirenshu);--平均收入
						fenG.renjunshouru_2_V:SetText(floor(pingjunshouru/2));
						local Qrenjunshouru=(pingjunshouru*(zongrenshu-bufenrenshu+shuangbeirenshu-banrenshu)+pingjunshouru/2*banrenshu)/(zongrenshu-bufenrenshu+shuangbeirenshu-banrenshu);--减去半工平均收入
						fenG.renjunshouru_V:SetText(floor(Qrenjunshouru));
					end
					if shuangbeirenshu>0 then
						local pingjunshouru=jingshouru/(zongrenshu-bufenrenshu+shuangbeirenshu);--平均收入
						fenG.renjunshouru_V:SetText(floor(pingjunshouru));
						fenG.renjunshouru_1_V:SetText(floor(pingjunshouru*2));
					end
				end
			end
		end
		--个人分G数和队伍需交易数
		for x=1,8 do
			local duiwufenGshu=0;
			for xx=1,#PIG["RaidRecord"]["Raidinfo"][x] do
				local gerenfenGshu=0;
				if #PIG["RaidRecord"]["Raidinfo"][x][xx]>0 then	
					if PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="坦克补助" or PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="治疗补助" or PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="其他补助" then
						gerenfenGshu=gerenfenGshu+PIG["RaidRecord"]["Raidinfo"][x][xx][6];
						if PIG["RaidRecord"]["Raidinfo"][x][xx][9]==0 then--不需邮寄
							duiwufenGshu=duiwufenGshu+PIG["RaidRecord"]["Raidinfo"][x][xx][6];
						end
					end
					for q=1,#PIG["RaidRecord"]["jiangli"] do
						if PIG["RaidRecord"]["jiangli"][q][3]~="无" then
							if PIG["RaidRecord"]["jiangli"][q][3]==PIG["RaidRecord"]["Raidinfo"][x][xx][4] then
								gerenfenGshu=gerenfenGshu+PIG["RaidRecord"]["jiangli"][q][2];
								if PIG["RaidRecord"]["Raidinfo"][x][xx][9]==0 then--不需邮寄
									duiwufenGshu=duiwufenGshu+PIG["RaidRecord"]["jiangli"][q][2];
								end
							end
						end
					end
					for q=1,#PIG["RaidRecord"]["fakuan"] do
						if PIG["RaidRecord"]["fakuan"][q][4]~="无" then
							if PIG["RaidRecord"]["fakuan"][q][4]==PIG["RaidRecord"]["Raidinfo"][x][xx][4] then
								gerenfenGshu=gerenfenGshu-PIG["RaidRecord"]["fakuan"][q][3];
								if PIG["RaidRecord"]["Raidinfo"][x][xx][9]==0 then--不需邮寄
									duiwufenGshu=duiwufenGshu-PIG["RaidRecord"]["fakuan"][q][3];
								end
							end
						end
					end
					if PIG["RaidRecord"]["Raidinfo"][x][xx][7]==2 then
						local shuangfenshu=tonumber(fenG.renjunshouru_1_V:GetText());
						gerenfenGshu=gerenfenGshu+shuangfenshu;
						PIG["RaidRecord"]["Raidinfo"][x][xx][8]=shuangfenshu;
						if PIG["RaidRecord"]["Raidinfo"][x][xx][9]==0 then--不需邮寄
							duiwufenGshu=duiwufenGshu+shuangfenshu;
						end
					elseif PIG["RaidRecord"]["Raidinfo"][x][xx][7]==0.5 then
						local bangongfenshu=tonumber(fenG.renjunshouru_2_V:GetText());
						gerenfenGshu=gerenfenGshu+bangongfenshu
						PIG["RaidRecord"]["Raidinfo"][x][xx][8]=bangongfenshu;
						if PIG["RaidRecord"]["Raidinfo"][x][xx][9]==0 then--不需邮寄
							duiwufenGshu=duiwufenGshu+bangongfenshu;
						end
					elseif PIG["RaidRecord"]["Raidinfo"][x][xx][7]==1 then
						local zhengchangfenshu=tonumber(fenG.renjunshouru_V:GetText());
						gerenfenGshu=gerenfenGshu+zhengchangfenshu;
						PIG["RaidRecord"]["Raidinfo"][x][xx][8]=zhengchangfenshu;
						if PIG["RaidRecord"]["Raidinfo"][x][xx][9]==0 then--不需邮寄
							duiwufenGshu=duiwufenGshu+zhengchangfenshu;
						end
					end
					_G["duiwu_"..x.."_"..xx].Players.G:SetText(gerenfenGshu)
				end
			end
			if #PIG["RaidRecord"]["Raidinfo"][x]>0 then
				_G["duiwuF_UI_"..x].G_V:SetText(duiwufenGshu)
			end
		end
	end
	addonTable.RaidRecord_jisuanfenGData = jisuanfenGData;

	---创建框架---------
	for p=1,8 do
		local duiwuF = CreateFrame("Frame", "duiwuF_UI_"..p, fenG,"BackdropTemplate");
		duiwuF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
			edgeSize = 16,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
		duiwuF:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
		duiwuF:SetSize(duiwu_Width,duiwu_Height*5+4);
		if p==1 then
			duiwuF:SetPoint("TOPLEFT",fenG,"TOPLEFT",12,-26);
		end
		if p>1 and p<5 then
			duiwuF:SetPoint("LEFT",_G["duiwuF_UI_"..(p-1)],"RIGHT",duiwujiange,0);
		end
		if p==5 then
			duiwuF:SetPoint("TOP",_G["duiwuF_UI_1"],"BOTTOM",0,-50);
		end
		if p>5 then
			duiwuF:SetPoint("LEFT",_G["duiwuF_UI_"..(p-1)],"RIGHT",duiwujiange,0);
		end
		duiwuF.biaoti = duiwuF:CreateFontString();
		duiwuF.biaoti:SetPoint("BOTTOM",duiwuF,"TOP",-12,1);
		duiwuF.biaoti:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
		duiwuF.biaoti:SetText("\124cffFFFF00"..p.."队\124r");
		duiwuF.tongzhi = CreateFrame("Button",nil,duiwuF, "TruncatedButtonTemplate",p);  
		duiwuF.tongzhi:SetSize(duiwu_Height-4,duiwu_Height-4);
		duiwuF.tongzhi:SetPoint("LEFT",duiwuF.biaoti,"RIGHT",0,-0);
		duiwuF.tongzhi.Tex = duiwuF.tongzhi:CreateTexture(nil, "BORDER");
		duiwuF.tongzhi.Tex:SetTexture(130979);
		duiwuF.tongzhi.Tex:SetPoint("CENTER");
		duiwuF.tongzhi.Tex:SetSize(duiwu_Height-4,duiwu_Height-4);
		duiwuF.tongzhi:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
			GameTooltip:AddLine("|cff00ff00点击通报本队明细以及通知分G人交易。|r")
			GameTooltip:Show();
		end);
		duiwuF.tongzhi:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		duiwuF.tongzhi:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1.5,-1.5);
		end);
		duiwuF.tongzhi:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		duiwuF.tongzhi:SetScript("OnClick", function(self)	
			local butID=self:GetID()
			local biaojiName={"{rt1}","{rt2}","{rt3}","{rt4}","{rt5}","{rt6}","{rt7}","{rt8}"};
			local yigouxuan=true;
			local fayanpindaoName="Raid";
			for pp=1,5 do
				if _G["duiwu_"..butID.."_"..pp].fenGren:GetChecked() then
					yigouxuan=false;
					local fenGrenname=_G["duiwu_"..butID.."_"..pp].Players.name:GetText()
					if UnitIsConnected(fenGrenname) then
						SendChatMessage("======【"..butID.."队】=========", fayanpindaoName, nil);
						--分G人
						local MSGFENGXINXI="分G总数: ".._G["duiwuF_UI_"..butID].G_V:GetText()..",分G人员【"..fenGrenname.."】标记为{rt"..butID.."}";
						SetRaidTarget(fenGrenname, butID);
						SendChatMessage(MSGFENGXINXI, fayanpindaoName, nil);
						--明细
						local msnfenG="明细: ";
						for xx=1,#PIG["RaidRecord"]["Raidinfo"][butID] do
							if #PIG["RaidRecord"]["Raidinfo"][butID][xx]>0 then
								msnfenG=msnfenG.._G["duiwu_"..butID.."_"..xx].Players.name:GetText()..":".._G["duiwu_"..butID.."_"..xx].Players.G:GetText().."，";	
							end	
						end
						SendChatMessage(msnfenG, fayanpindaoName, nil);
						self.Tex:SetDesaturated(true);
					else
						print("|cff00FFFF!Pig:|r|cffFFFF00当前分G人已离线，请选择其他未离线成员！|r");
					end
				end
			end
			if yigouxuan then
				print("|cff00FFFF!Pig:|r|cffFFFF00请先选择分G人！|r");
			end
		end);
		duiwuF.G = fenG:CreateFontString();
		duiwuF.G:SetPoint("TOPLEFT",duiwuF,"BOTTOMLEFT",20,0);
		duiwuF.G:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		duiwuF.G:SetText("\124cffFFFF00需交易G：\124r");
		duiwuF.G_V = fenG:CreateFontString();
		duiwuF.G_V:SetPoint("LEFT",duiwuF.G,"RIGHT",0,0);
		duiwuF.G_V:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");

		for xx=1,5 do
			duiwuF.list = CreateFrame("Frame", "duiwu_"..p.."_"..xx, duiwuF);
			duiwuF.list:SetSize(duiwu_Width-6,duiwu_Height);
			if xx==1 then
				duiwuF.list:SetPoint("TOP",duiwuF,"TOP",0,-2);
			else
				duiwuF.list:SetPoint("TOP",_G["duiwu_"..p.."_"..(xx-1)],"BOTTOM",0,0);
			end
			if xx~=5 then
				duiwuF.list.line1 = duiwuF.list:CreateLine()
				duiwuF.list.line1:SetColorTexture(1,1,1,0.3)
				duiwuF.list.line1:SetThickness(1);
				duiwuF.list.line1:SetStartPoint("BOTTOMLEFT",0,0.2)
				duiwuF.list.line1:SetEndPoint("BOTTOMRIGHT",0,0.2)
			end
			-------------
			duiwuF.list.fenGren = CreateFrame("CheckButton", nil, duiwuF.list, "UIRadioButtonTemplate");
			duiwuF.list.fenGren:SetSize(duiwu_Height-10,duiwu_Height-10);
			duiwuF.list.fenGren:SetHitRectInsets(0,0,-2,-2);
			duiwuF.list.fenGren:SetPoint("LEFT",duiwuF.list,"LEFT",0,-0);
			duiwuF.list.fenGren:SetScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
				GameTooltip:AddLine("设置为本队分G人员")
				GameTooltip:Show();
			end);
			duiwuF.list.fenGren:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end)
			duiwuF.list.fenGren:SetScript("OnClick", function (self)
				for qq=1,5 do
					_G["duiwu_"..p.."_"..qq].fenGren:SetChecked(false);
				end
				self:SetChecked(true);
			end)	
			-------------
			duiwuF.list.Players = CreateFrame("Frame", nil, duiwuF.list);
			duiwuF.list.Players:SetPoint("LEFT",duiwuF.list.fenGren,"RIGHT",0,0);
			duiwuF.list.Players:SetSize(duiwu_Height*2,duiwu_Height-10);
			duiwuF.list.Players.name = duiwuF.list.Players:CreateFontString();
			duiwuF.list.Players.name:SetPoint("LEFT",duiwuF.list.Players,"LEFT",0,0);
			duiwuF.list.Players.name:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
			duiwuF.list.Players:SetScript("OnMouseUp", function (self)
				if ( MailFrame:IsVisible() and MailFrame.selectedTab == 2 ) then
					local mail_Name=self.name:GetText();
					SendMailNameEditBox:SetText(mail_Name);
					SendMailSubjectEditBox:SetText(date("%Y-%m-%d",PIG["RaidRecord"]["instanceName"][1]).." "..PIG["RaidRecord"]["instanceName"][2]);
					SendMailMoneyGold:SetText(0);
				else
					print("|cff00FFFF!Pig:|r|cffFFFF00请先打开邮箱发件页面！|r");
				end
			end);
			-------------
			duiwuF.list.buzhu = duiwuF.list:CreateTexture(nil, "ARTWORK");
			duiwuF.list.buzhu:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
			duiwuF.list.buzhu:SetSize(duiwu_Height-8,duiwu_Height-8);
			duiwuF.list.buzhu:SetPoint("LEFT", duiwuF.list.Players, "RIGHT", 0,0);
			duiwuF.list.fenGbili = duiwuF.list:CreateTexture(nil, "ARTWORK");
			duiwuF.list.fenGbili:SetTexture(fenGbiliIcon[1]);
			duiwuF.list.fenGbili:SetSize(duiwu_Height-8,duiwu_Height-8);
			duiwuF.list.fenGbili:SetPoint("LEFT", duiwuF.list.buzhu, "RIGHT", 0,0);
			-- ------
			duiwuF.list.mail = CreateFrame("Button",nil,duiwuF.list, "TruncatedButtonTemplate",xx);
			duiwuF.list.mail:SetSize(duiwu_Height-8,duiwu_Height-8);
			duiwuF.list.mail:SetPoint("LEFT", duiwuF.list.fenGbili, "RIGHT", 1,0);
			duiwuF.list.mail.Tex = duiwuF.list.mail:CreateTexture(nil, "BORDER");
			duiwuF.list.mail.Tex:SetTexture("interface/cursor/mail.blp");
			duiwuF.list.mail.Tex:SetAllPoints(duiwuF.list.mail)
			duiwuF.list.mail.Tex:SetPoint("CENTER");
			duiwuF.list.mail:SetScript("OnMouseDown", function (self)
				self.Tex:SetPoint("CENTER",-1.5,-1.5);
			end);
			duiwuF.list.mail:SetScript("OnMouseUp", function (self)
				self.Tex:SetPoint("CENTER");
			end);
			duiwuF.list.mail:SetScript("OnClick", function (self)
				if ( MailFrame:IsVisible() and MailFrame.selectedTab == 2 ) then
					local mail_Name=self:GetParent().Players.name:GetText()
					local mail_Name_G=self:GetParent().Players.G:GetText()
					SendMailNameEditBox:SetText(mail_Name);
					SendMailSubjectEditBox:SetText(date("%Y-%m-%d",PIG["RaidRecord"]["instanceName"][1]).." "..PIG["RaidRecord"]["instanceName"][2]);
					SendMailMoneyGold:SetText(mail_Name_G);
					PIG["RaidRecord"]["Raidinfo"][p][xx][10]=1;
					self.Tex:SetTexture("interface/cursor/unablemail.blp");
				else
					print("|cff00FFFF!Pig:|r|cffFFFF00请先打开邮箱发件页面！|r");
				end
			end);
			duiwuF.list.Players.G = duiwuF.list:CreateFontString();
			duiwuF.list.Players.G:SetPoint("LEFT",duiwuF.list.mail,"RIGHT",0,0);
			duiwuF.list.Players.G:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
			duiwuF.list.Players.G:SetText(0);
			duiwuF.list.Players.G:Hide();
		end
	end
	fenG.line = fenG:CreateLine()
	fenG.line:SetColorTexture(1,1,1,0.3)
	fenG.line:SetThickness(1);
	fenG.line:SetStartPoint("LEFT",4,-duiwu_Height*5.5)
	fenG.line:SetEndPoint("RIGHT",-2,-duiwu_Height*5.5)
	--显示玩家分G数-----
	fenG.XianshiJine = CreateFrame("Button",nil,fenG, "TruncatedButtonTemplate"); 
	fenG.XianshiJine:SetNormalTexture("interface/icons/ability_warrior_revenge.blp"); 
	fenG.XianshiJine:SetSize(16,16);
	fenG.XianshiJine:SetPoint("BOTTOMRIGHT",fenG.line,"BOTTOMRIGHT",-4,2);
	fenG.XianshiJine.Down = fenG.XianshiJine:CreateTexture(nil, "OVERLAY");
	fenG.XianshiJine.Down:SetTexture(130839);
	fenG.XianshiJine.Down:SetSize(16.2,16.2);
	fenG.XianshiJine.Down:SetPoint("CENTER");
	fenG.XianshiJine.Down:Hide();
	fenG.XianshiJine:SetScript("OnMouseDown", function (self)
		self.Down:Show();
	end);
	fenG.XianshiJine:SetScript("OnMouseUp", function (self)
		self.Down:Hide();
		for x=1,8 do
			for xx=1,5 do
				if _G["duiwu_"..x.."_"..xx]:IsShown() then
					if _G["duiwu_"..x.."_"..xx].Players.G:IsShown() then
						_G["duiwu_"..x.."_"..xx].Players.G:Hide()
					else
						_G["duiwu_"..x.."_"..xx].Players.G:Show()
					end
				end
			end
		end
	end);
	fenG:SetScript("OnShow", function ()
		jisuanfenGData();
	end)
	--==========================================
	--分G人数设置
	fenG.rensh_ALL = fenG:CreateFontString();
	fenG.rensh_ALL:SetPoint("TOPLEFT",fenG,"TOPLEFT",20,-(Height-170));
	fenG.rensh_ALL:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.rensh_ALL:SetText("\124cff00FF00总人数：\124r");
	fenG.rensh_ALL_V = fenG:CreateFontString();
	fenG.rensh_ALL_V:SetPoint("LEFT",fenG.rensh_ALL,"RIGHT",0,0);
	fenG.rensh_ALL_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.rensh_ALL_V:SetText(0);
	----分G比例
	fenG.renshu_fenGbili = fenG:CreateTexture(nil, "ARTWORK");
	fenG.renshu_fenGbili:SetTexture(fenGbiliIcon[1]);
	fenG.renshu_fenGbili:SetSize(duiwu_Height-8,duiwu_Height-8);
	fenG.renshu_fenGbili:SetPoint("LEFT", fenG.rensh_ALL, "RIGHT", 100,0);
	fenG.renshu_fenGbili_t = fenG:CreateFontString();
	fenG.renshu_fenGbili_t:SetPoint("LEFT",fenG.renshu_fenGbili,"RIGHT",0,0);
	fenG.renshu_fenGbili_t:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_fenGbili_t:SetText("|cff00ff00双倍:|r")
	fenG.renshu_fenGbili_V = fenG:CreateFontString();
	fenG.renshu_fenGbili_V:SetPoint("LEFT",fenG.renshu_fenGbili_t,"RIGHT",0,0);
	fenG.renshu_fenGbili_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_fenGbili_V:SetText(0);
	fenG.renshu_fenGbili_1 = fenG:CreateTexture(nil, "ARTWORK");
	fenG.renshu_fenGbili_1:SetTexture(fenGbiliIcon[2]);
	fenG.renshu_fenGbili_1:SetTexCoord(fenGbiliIconCaiqie[2][1],fenGbiliIconCaiqie[2][2],fenGbiliIconCaiqie[2][3],fenGbiliIconCaiqie[2][4]);
	fenG.renshu_fenGbili_1:SetSize(duiwu_Height-8,duiwu_Height-8);
	fenG.renshu_fenGbili_1:SetPoint("LEFT", fenG.renshu_fenGbili, "RIGHT", 60,0);
	fenG.renshu_fenGbili_1_t = fenG:CreateFontString();
	fenG.renshu_fenGbili_1_t:SetPoint("LEFT",fenG.renshu_fenGbili_1,"RIGHT",0,0);
	fenG.renshu_fenGbili_1_t:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_fenGbili_1_t:SetText("|cff00ff000.5倍:|r")
	fenG.renshu_fenGbili_1_V = fenG:CreateFontString();
	fenG.renshu_fenGbili_1_V:SetPoint("LEFT",fenG.renshu_fenGbili_1_t,"RIGHT",0,0);
	fenG.renshu_fenGbili_1_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_fenGbili_1_V:SetText(0);
	fenG.renshu_fenGbili_2 = fenG:CreateTexture(nil, "ARTWORK");
	fenG.renshu_fenGbili_2:SetTexture(fenGbiliIcon[3]);
	fenG.renshu_fenGbili_2:SetTexCoord(fenGbiliIconCaiqie[3][1],fenGbiliIconCaiqie[3][2],fenGbiliIconCaiqie[3][3],fenGbiliIconCaiqie[3][4]);
	fenG.renshu_fenGbili_2:SetSize(duiwu_Height-10,duiwu_Height-10);
	fenG.renshu_fenGbili_2:SetPoint("LEFT", fenG.renshu_fenGbili_1, "RIGHT", 60,0);
	fenG.renshu_fenGbili_2_t = fenG:CreateFontString();
	fenG.renshu_fenGbili_2_t:SetPoint("LEFT",fenG.renshu_fenGbili_2,"RIGHT",0,0);
	fenG.renshu_fenGbili_2_t:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_fenGbili_2_t:SetText("|cff00ff00不分:|r")
	fenG.renshu_fenGbili_2_V = fenG:CreateFontString();
	fenG.renshu_fenGbili_2_V:SetPoint("LEFT",fenG.renshu_fenGbili_2_t,"RIGHT",0,0);
	fenG.renshu_fenGbili_2_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_fenGbili_2_V:SetText(0);
	--补助
	fenG.renshu_buzhu_T = fenG:CreateTexture(nil, "ARTWORK");
	fenG.renshu_buzhu_T:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
	fenG.renshu_buzhu_T:SetTexCoord(zhizeIcon[1][1],zhizeIcon[1][2],zhizeIcon[1][3],zhizeIcon[1][4]);
	fenG.renshu_buzhu_T:SetSize(duiwu_Height-8,duiwu_Height-8);
	fenG.renshu_buzhu_T:SetPoint("LEFT", fenG.renshu_fenGbili_2, "RIGHT", 140,0);
	fenG.renshu_buzhu_T_t = fenG:CreateFontString();
	fenG.renshu_buzhu_T_t:SetPoint("LEFT",fenG.renshu_buzhu_T,"RIGHT",0,0);
	fenG.renshu_buzhu_T_t:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_buzhu_T_t:SetText("|cff00ff00T补:|r")
	fenG.renshu_buzhu_T_V = fenG:CreateFontString();
	fenG.renshu_buzhu_T_V:SetPoint("LEFT",fenG.renshu_buzhu_T_t,"RIGHT",0,0);
	fenG.renshu_buzhu_T_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_buzhu_T_V:SetText(0);
	fenG.renshu_buzhu_N = fenG:CreateTexture(nil, "ARTWORK");
	fenG.renshu_buzhu_N:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
	fenG.renshu_buzhu_N:SetTexCoord(zhizeIcon[2][1],zhizeIcon[2][2],zhizeIcon[2][3],zhizeIcon[2][4]);
	fenG.renshu_buzhu_N:SetSize(duiwu_Height-8,duiwu_Height-8);
	fenG.renshu_buzhu_N:SetPoint("LEFT", fenG.renshu_buzhu_T, "RIGHT", 60,0);
	fenG.renshu_buzhu_N_t = fenG:CreateFontString();
	fenG.renshu_buzhu_N_t:SetPoint("LEFT",fenG.renshu_buzhu_N,"RIGHT",0,0);
	fenG.renshu_buzhu_N_t:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_buzhu_N_t:SetText("|cff00ff00奶补:|r")
	fenG.renshu_buzhu_N_V = fenG:CreateFontString();
	fenG.renshu_buzhu_N_V:SetPoint("LEFT",fenG.renshu_buzhu_N_t,"RIGHT",0,0);
	fenG.renshu_buzhu_N_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_buzhu_N_V:SetText(0);
	fenG.renshu_buzhu_LR = fenG:CreateTexture(nil, "ARTWORK");
	fenG.renshu_buzhu_LR:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
	fenG.renshu_buzhu_LR:SetTexCoord(zhizeIcon[3][1],zhizeIcon[3][2],zhizeIcon[3][3],zhizeIcon[3][4]);
	fenG.renshu_buzhu_LR:SetSize(duiwu_Height-8,duiwu_Height-8);
	fenG.renshu_buzhu_LR:SetPoint("LEFT", fenG.renshu_buzhu_N, "RIGHT", 60,0);
	fenG.renshu_buzhu_LR_t = fenG:CreateFontString();
	fenG.renshu_buzhu_LR_t:SetPoint("LEFT",fenG.renshu_buzhu_LR,"RIGHT",0,0);
	fenG.renshu_buzhu_LR_t:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_buzhu_LR_t:SetText("|cff00ff00其他:|r")
	fenG.renshu_buzhu_LR_V = fenG:CreateFontString();
	fenG.renshu_buzhu_LR_V:SetPoint("LEFT",fenG.renshu_buzhu_LR_t,"RIGHT",0,0);
	fenG.renshu_buzhu_LR_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renshu_buzhu_LR_V:SetText(0);
	-----------------
	fenG.line1 = fenG:CreateLine()
	fenG.line1:SetColorTexture(1,1,1,0.3)
	fenG.line1:SetThickness(1);
	fenG.line1:SetStartPoint("LEFT",4,-duiwu_Height*6.8)
	fenG.line1:SetEndPoint("RIGHT",-2,-duiwu_Height*6.8)
	---人均收入
	fenG.renjunshouru = fenG:CreateFontString();
	fenG.renjunshouru:SetPoint("TOPLEFT",fenG,"TOPLEFT",20,-(Height-132));
	fenG.renjunshouru:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renjunshouru:SetText("\124cffFFFF00人均收入/G：\124r");
	fenG.renjunshouru_V = fenG:CreateFontString();
	fenG.renjunshouru_V:SetPoint("LEFT",fenG.renjunshouru ,"RIGHT",0,0);
	fenG.renjunshouru_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renjunshouru_V:SetText(0);
	fenG.renjunshouru_1 = fenG:CreateFontString();
	fenG.renjunshouru_1:SetPoint("LEFT",fenG.renjunshouru,"RIGHT",60,0);
	fenG.renjunshouru_1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renjunshouru_1:SetText("\124cffFFFF00双倍人均/G：\124r");
	fenG.renjunshouru_1_V = fenG:CreateFontString();
	fenG.renjunshouru_1_V:SetPoint("LEFT",fenG.renjunshouru_1 ,"RIGHT",0,0);
	fenG.renjunshouru_1_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renjunshouru_1_V:SetText(0);
	fenG.renjunshouru_2 = fenG:CreateFontString();
	fenG.renjunshouru_2:SetPoint("LEFT",fenG.renjunshouru_1,"RIGHT",60,0);
	fenG.renjunshouru_2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renjunshouru_2:SetText("\124cffFFFF000.5倍人均/G：\124r");
	fenG.renjunshouru_2_V = fenG:CreateFontString();
	fenG.renjunshouru_2_V:SetPoint("LEFT",fenG.renjunshouru_2 ,"RIGHT",0,0);
	fenG.renjunshouru_2_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fenG.renjunshouru_2_V:SetText(0);
	---广播分配信息==================================================
	RaidR_UI.xuanzhongChat = "RAID";
	fenG.guangbo = CreateFrame("Button",nil,fenG, "UIPanelButtonTemplate");  
	fenG.guangbo:SetSize(116,28);
	fenG.guangbo:SetPoint("TOPLEFT",fenG,"TOPLEFT",480,-(Height-138));
	fenG.guangbo:SetText("·发送到");
	fenG.guangbo.Font=fenG.guangbo:GetFontString()
	fenG.guangbo.Font:SetFont(ChatFontNormal:GetFont(), 13);
	fenG.guangbo.Font:SetTextColor(1, 1, 1, 1);
	fenG.guangbo.Text:SetPoint("LEFT",fenG.guangbo,"LEFT",21,0);
	fenG.guangbo.Tex = fenG.guangbo:CreateTexture(nil, "BORDER");
	fenG.guangbo.Tex:SetTexture("interface/common/voicechat-speaker.blp");
	fenG.guangbo.Tex:SetPoint("LEFT",6,0);
	fenG.guangbo.Tex:SetSize(22,22);
	fenG.guangbo:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("LEFT",10,-1);
	end);
	fenG.guangbo:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("LEFT",8,0);
	end);
	fenG.guangbo:SetScript("OnClick", function ()
		local liupaichupin={};
		SendChatMessage("========收支明细========", RaidR_UI.xuanzhongChat, nil);
		local ItemSLsit = PIG["RaidRecord"]["ItemList"];
		for id=1,#ItemSLsit do
			if ItemSLsit[id][9]>0 or ItemSLsit[id][14]>0 then
				if ItemSLsit[id][14]>0 then
					SendChatMessage(ItemSLsit[id][2].."x"..ItemSLsit[id][3].." 收入："..ItemSLsit[id][9]+ItemSLsit[id][14].."G(买方<"..ItemSLsit[id][8]..">尚欠"..ItemSLsit[id][14]..")", RaidR_UI.xuanzhongChat, nil);
				else
					SendChatMessage(ItemSLsit[id][2].."x"..ItemSLsit[id][3].." 收入："..ItemSLsit[id][9].."G(买方<"..ItemSLsit[id][8]..">)", RaidR_UI.xuanzhongChat, nil);
				end
			else
				if PIG["RaidRecord"]["Rsetting"]["liupaibobao"]=="ON" then
					table.insert(liupaichupin,ItemSLsit[id][2]);
				end
			end
		end
		if #liupaichupin>0 then
			if PIG["RaidRecord"]["Rsetting"]["liupaibobao"]=="ON" then
				SendChatMessage("以下为流拍物品：", RaidR_UI.xuanzhongChat, nil);
				--流派每行物品数
				local LPnum = 3
				for l=1,math.ceil(#liupaichupin/LPnum) do
					if l==1 then
						local textmsgIiem="";
						for ll=1,l*LPnum do
							if liupaichupin[ll]~=nil then
								textmsgIiem=textmsgIiem..liupaichupin[ll];
							end
						end
						SendChatMessage(textmsgIiem, RaidR_UI.xuanzhongChat, nil);
					else
						local textmsgIiem1="";
						for ll=(l-1)*LPnum+1,l*LPnum do
							if liupaichupin[ll]~=nil then
								textmsgIiem1=textmsgIiem1..liupaichupin[ll];
							end
						end
						SendChatMessage(textmsgIiem1, RaidR_UI.xuanzhongChat, nil);
					end
					textmsgIiem=nil;textmsgIiem1=nil;
				end
			end
		end
		--补助
		if PIG["RaidRecord"]["Rsetting"]["bobaomingxi"]=="ON" then
			for x=1,#PIG["RaidRecord"]["Raidinfo"] do
				for xx=1,#PIG["RaidRecord"]["Raidinfo"][x] do
					if PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="坦克补助" then
						SendChatMessage("["..PIG["RaidRecord"]["Raidinfo"][x][xx][5].."]-"..PIG["RaidRecord"]["Raidinfo"][x][xx][4].."-支出："..PIG["RaidRecord"]["Raidinfo"][x][xx][6].."G", RaidR_UI.xuanzhongChat, nil);
					end
				end
			end
			for x=1,#PIG["RaidRecord"]["Raidinfo"] do
				for xx=1,#PIG["RaidRecord"]["Raidinfo"][x] do
					if PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="治疗补助" then
						SendChatMessage("["..PIG["RaidRecord"]["Raidinfo"][x][xx][5].."]-"..PIG["RaidRecord"]["Raidinfo"][x][xx][4].."-支出："..PIG["RaidRecord"]["Raidinfo"][x][xx][6].."G", RaidR_UI.xuanzhongChat, nil);
					end
				end
			end
			for x=1,#PIG["RaidRecord"]["Raidinfo"] do
				for xx=1,#PIG["RaidRecord"]["Raidinfo"][x] do
					if PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="其他补助" then
						SendChatMessage("["..PIG["RaidRecord"]["Raidinfo"][x][xx][5].."]-"..PIG["RaidRecord"]["Raidinfo"][x][xx][4].."-支出："..PIG["RaidRecord"]["Raidinfo"][x][xx][6].."G", RaidR_UI.xuanzhongChat, nil);
					end
				end
			end
			for j=1,#PIG["RaidRecord"]["fakuan"] do
				if PIG["RaidRecord"]["fakuan"][j][4]~="无" then
					SendChatMessage("["..PIG["RaidRecord"]["fakuan"][j][1].."]-"..PIG["RaidRecord"]["fakuan"][j][4].."-收入："..PIG["RaidRecord"]["fakuan"][j][2]+PIG["RaidRecord"]["fakuan"][j][3].."G", RaidR_UI.xuanzhongChat, nil);
				end
			end
			for b=1,#PIG["RaidRecord"]["jiangli"] do
				if PIG["RaidRecord"]["jiangli"][b][3]~="无" then
					SendChatMessage("["..PIG["RaidRecord"]["jiangli"][b][1].."]-"..PIG["RaidRecord"]["jiangli"][b][3].."-支出："..PIG["RaidRecord"]["jiangli"][b][2].."G", RaidR_UI.xuanzhongChat, nil);
				end
			end
		end
		local Wupin_SR=RaidR_UI.xiafangF.Wupin_SR_V:GetText();
		local fakuan_SR=RaidR_UI.xiafangF.fakuan_SR_V:GetText();
		local buzhu_ZC=RaidR_UI.xiafangF.buzhu_SR_V:GetText();
		local jiangli_ZC=RaidR_UI.xiafangF.jiangli_SR_V:GetText();
		local ZongSR=RaidR_UI.xiafangF.ZongSR_V:GetText();
		local Jing_RS=RaidR_UI.xiafangF.Jing_RS_V:GetText();
		local hejifayanxianMSG="合计:";
		if tonumber(Wupin_SR)>0 then
			hejifayanxianMSG=hejifayanxianMSG.."物品收入:"..Wupin_SR.."G,";
		end
		if tonumber(fakuan_SR)>0 then
			hejifayanxianMSG=hejifayanxianMSG.."罚款/其他收入:"..fakuan_SR.."G,";
		end
		hejifayanxianMSG=hejifayanxianMSG.."总收入:"..ZongSR.."G,";
		if tonumber(buzhu_ZC)>0 then
			hejifayanxianMSG=hejifayanxianMSG.."补助支出:"..buzhu_ZC.."G,";
		end
		if tonumber(jiangli_ZC)>0 then
			hejifayanxianMSG=hejifayanxianMSG.."奖励支出:"..jiangli_ZC.."G,";
		end
		hejifayanxianMSG=hejifayanxianMSG.."净收入:"..Jing_RS.."G,";
		SendChatMessage(hejifayanxianMSG, RaidR_UI.xuanzhongChat, nil);
		--
		local shourumingxi="";
		if fenG.renjunshouru_V:GetText()~=nil and tonumber(fenG.renjunshouru_V:GetText())>0 then
			shourumingxi=shourumingxi.."人均收入:"..fenG.renjunshouru_V:GetText().."G(分G人数"..fenG.rensh_ALL_V:GetText()-fenG.renshu_fenGbili_2_V:GetText()..")，";
		end
		if fenG.renjunshouru_1_V:GetText()~=nil and tonumber(fenG.renjunshouru_1_V:GetText())>0  then
			shourumingxi=shourumingxi.."双工:"..fenG.renjunshouru_1_V:GetText().."G(人数"..fenG.renshu_fenGbili_V:GetText()..")，";
		end
		if fenG.renjunshouru_2_V:GetText()~=nil and tonumber(fenG.renjunshouru_2_V:GetText())>0 then
			shourumingxi=shourumingxi.."半工:"..fenG.renjunshouru_2_V:GetText().."G(人数"..fenG.renshu_fenGbili_1_V:GetText()..")";
		end
		SendChatMessage(shourumingxi, RaidR_UI.xuanzhongChat, nil);
		SendChatMessage("=《!Pig开团助手为你服务》=", RaidR_UI.xuanzhongChat, nil);
	end);
	local pindaoName = {["RAID"]="|cffFF7F00团队|r",["SAY"]="|cffFFFFFF说话|r",["PARTY"]="|cffAAAAFF队伍|r",["GUILD"]="|cff40FF40公会|r"};
	local pindaoID = {"RAID","SAY","PARTY","GUILD"};
	fenG.guangbo_dow=PIGDownMenu(nil,{68,24},fenG,{"LEFT",fenG.guangbo,"RIGHT", -50,0})
	fenG.guangbo_dow:SetBackdrop(nil)
	function fenG.guangbo_dow:PIGDownMenu_Update_But(self)
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#pindaoID,1 do
		    info.text, info.arg1, info.arg2 = pindaoName[pindaoID[i]], pindaoID[i], pindaoID[i]
		    info.checked = pindaoID[i]==RaidR_UI.xuanzhongChat
			fenG.guangbo_dow:PIGDownMenu_AddButton(info)
		end 
	end
	function fenG.guangbo_dow:PIGDownMenu_SetValue(value,arg1,arg2)
		fenG.guangbo_dow:PIGDownMenu_SetText(value)
		RaidR_UI.xuanzhongChat=arg1
		PIGCloseDropDownMenus()
	end
	fenG.guangbo_dow:PIGDownMenu_SetText(pindaoName[RaidR_UI.xuanzhongChat])
	----==============================================================
	fenG.liupaibobao = ADD_Checkbutton(nil,fenG,-10,"LEFT",fenG.guangbo,"RIGHT",40,0,"流拍","开启后,发送拍卖结果时会播报流拍物品")
	fenG.liupaibobao:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["RaidRecord"]["Rsetting"]["liupaibobao"]="ON";
		else
			PIG["RaidRecord"]["Rsetting"]["liupaibobao"]="OFF";
		end
	end);
	--
	fenG.bobaomingxi = ADD_Checkbutton(nil,fenG,-10,"LEFT",fenG.liupaibobao,"RIGHT",50,0,"明细","开启后,发送拍卖结果时会播报补助/罚款/奖励明细")
	fenG.bobaomingxi:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["RaidRecord"]["Rsetting"]["bobaomingxi"]="ON";
		else
			PIG["RaidRecord"]["Rsetting"]["bobaomingxi"]="OFF";
		end
	end);
	if PIG["RaidRecord"]["Rsetting"]["liupaibobao"]=="ON" then
		fenG.liupaibobao:SetChecked(true);
	end
	if PIG["RaidRecord"]["Rsetting"]["bobaomingxi"]=="ON" then
		fenG.bobaomingxi:SetChecked(true);
	end
	-----------
	RaidR_UI.xiafangF.fenG_BUT = CreateFrame("Button","fenG_BUT_UI",RaidR_UI.xiafangF, "UIPanelButtonTemplate");  
	RaidR_UI.xiafangF.fenG_BUT:SetSize(80,28);
	RaidR_UI.xiafangF.fenG_BUT:SetPoint("BOTTOMLEFT",RaidR_UI.xiafangF.lian,"BOTTOMLEFT",156,6);
	RaidR_UI.xiafangF.fenG_BUT:SetText("分G助手");
	RaidR_UI.xiafangF.fenG_BUT:SetMotionScriptsWhileDisabled(true)
	RaidR_UI.xiafangF.fenG_BUT:SetScript("OnEnter", function (self)
		if not self:IsEnabled() then
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
			GameTooltip:AddLine("提示：")
			GameTooltip:AddLine("\124cff00ff00请先冻结人员信息\124r")
			GameTooltip:Show();
		end
	end);
	RaidR_UI.xiafangF.fenG_BUT:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	RaidR_UI.xiafangF.fenG_BUT:SetScript("OnClick", function ()
		History_UI:Hide();
		RsettingF_UI:Hide();
		invite_UI:Hide();
		if fenG_UI:IsShown() then
			fenG_UI:Hide();
		else
			fenG_UI:Show();
		end
	end);
end
addonTable.ADD_fenG = ADD_fenG;