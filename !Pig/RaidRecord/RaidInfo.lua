local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local duiwu_Width,duiwu_Height=160,28;
local jiangeW,jiangeH=30,0;
local function ADD_RaidInfo()
	local fuFrame = TablistFrame_5_UI
	local Width,Height  = fuFrame:GetWidth(), fuFrame:GetHeight();
	--================================
	--职业图标
	local c_W,c_H=60,24;
	local cl_Name={"WARRIOR","PALADIN","HUNTER","ROGUE","PRIEST","SHAMAN","MAGE","WARLOCK","DRUID"};
	local _, _, _, tocversion = GetBuildInfo()
	if tocversion>29999 then
		table.insert(cl_Name,"DEATHKNIGHT");
	end
	if tocversion>49999 then
		table.insert(cl_Name,"MONK");
	end
	if tocversion>69999 then
		table.insert(cl_Name,"DEMONHUNTER");
	end
	--图标点击提示
	fuFrame.tishi = CreateFrame("Frame", nil, fuFrame);
	fuFrame.tishi:SetSize(c_H-6,c_H-6);
	fuFrame.tishi:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",6,-12);
	fuFrame.tishi.Tex = fuFrame.tishi:CreateTexture(nil, "BORDER");
	fuFrame.tishi.Tex:SetTexture("interface/common/help-i.blp");
	fuFrame.tishi.Tex:SetSize(c_H+4,c_H+4);
	fuFrame.tishi.Tex:SetPoint("CENTER");
	fuFrame.tishi:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("提示：")
		GameTooltip:AddLine("\124cff00ff00左键角色名设置人员补助类型。\n右键角色名设置人员分G比例。\124r")
		GameTooltip:Show();
	end);
	fuFrame.tishi:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	--全部
	fuFrame.All = CreateFrame("Frame", nil, fuFrame);
	fuFrame.All:SetSize(c_H*2, c_H);
	fuFrame.All:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",c_H+2,-10);
	fuFrame.All.Tex = fuFrame.All:CreateTexture(nil, "BORDER");
	fuFrame.All.Tex:SetTexture("interface/glues/charactercreate/ui-charactercreate-factions.blp");
	fuFrame.All.Tex:SetPoint("LEFT", fuFrame.All, "LEFT", 0,0);
	fuFrame.All.Tex:SetSize(c_H-2,c_H-2);
	fuFrame.All:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("LEFT", fuFrame.All, "LEFT",1.5,-1.5);
	end);
	fuFrame.All:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("LEFT", fuFrame.All, "LEFT", 0,0);
	end);
	fuFrame.All.Num = fuFrame.All:CreateFontString("fuFrame.All.Num_UI");
	fuFrame.All.Num:SetPoint("LEFT", fuFrame.All.Tex, "RIGHT", 0,0);
	fuFrame.All.Num:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.All.Num:SetText(0);
	--分职业
	for id=1,#cl_Name do
		local classes = CreateFrame("Frame", "classes_"..id, fuFrame);
		classes:SetSize(c_H*2-4, c_H);
		if id==1 then
			classes:SetPoint("LEFT",fuFrame.All,"RIGHT",2,0);
		else
			classes:SetPoint("LEFT",_G["classes_"..(id-1)],"RIGHT",1,0);
		end
		classes.Tex = classes:CreateTexture(nil, "BORDER");
		classes.Tex:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
		classes.Tex:SetPoint("LEFT", classes, "LEFT", 0,0);
		classes.Tex:SetSize(c_H-2,c_H-2);
		classes.Tex:SetTexCoord(unpack(CLASS_ICON_TCOORDS[cl_Name[id]]));
		classes:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("LEFT", classes, "LEFT",1.5,-1.5);
		end);
		classes:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("LEFT", classes, "LEFT", 0,0);
		end);
		classes.Num = classes:CreateFontString();
		classes.Num:SetPoint("LEFT", classes.Tex, "RIGHT", 0,0);
		classes.Num:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		classes.Num:SetText(0);
	end
	---职责分类
	--local zhizeIcon = {{0.01,0.26,0.26,0.51},{0.27,0.52,0,0.25},{0.01,0.26,0,0.25},{0.27,0.52,0.52,0.77}}
	local zhizeIcon = {{0.01,0.26,0.26,0.51},{0.27,0.52,0,0.25},{0.01,0.26,0,0.25}}
	for id=1,#zhizeIcon do
		local zhize = CreateFrame("Frame", "zhize_"..id, fuFrame); 
		zhize:SetSize(c_H*2-4, c_H);
		if id==1 then
			zhize:SetPoint("LEFT",_G["classes_"..#cl_Name],"RIGHT",2,0);
		else
			zhize:SetPoint("LEFT",_G["zhize_"..(id-1)],"RIGHT",1,0);
		end
		zhize.Tex = zhize:CreateTexture(nil, "BORDER");
		zhize.Tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
		zhize.Tex:SetTexCoord(zhizeIcon[id][1],zhizeIcon[id][2],zhizeIcon[id][3],zhizeIcon[id][4]);
		zhize.Tex:SetSize(c_H,c_H);
		zhize.Tex:SetPoint("LEFT", zhize, "LEFT", 0,0);
		zhize:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("LEFT", zhize, "LEFT",1.5,-1.5);
		end);
		zhize:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("LEFT", zhize, "LEFT", 0,0);
		end);
		zhize.Num = zhize:CreateFontString();
		zhize.Num:SetPoint("LEFT", zhize.Tex, "RIGHT", 0,0);
		zhize.Num:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		zhize.Num:SetText(0);
	end
	--===============================================================
	---获取队伍信息
	local function UpdateRiadInfo()
		local renyuanifoHC={{},{},{},{},{},{},{},{}};
		local yiyoutuanduishuju=0;
		for p=1,40 do
			local name, _, subgroup, _, _, fileName = GetRaidRosterInfo(p);
			if name~=nil then
				yiyoutuanduishuju=yiyoutuanduishuju+1;
				local coords = CLASS_ICON_TCOORDS[fileName];
				local rPerc, gPerc, bPerc, argbHex = GetClassColor(fileName);
							--1职业图标2职业颜色3职业4玩家名5补助类型6补助金额7分G比例8分G数值9[需要邮寄0/1]10[已邮寄0/1]	
				local renyuaninfo={coords,{rPerc, gPerc, bPerc},fileName,name,buzhuleixing,0,1,0,0,0};	
				if subgroup==1 then
					table.insert(renyuanifoHC[1],renyuaninfo);
				elseif subgroup==2 then
					table.insert(renyuanifoHC[2],renyuaninfo);
				elseif subgroup==3 then
					table.insert(renyuanifoHC[3],renyuaninfo);
				elseif subgroup==4 then
					table.insert(renyuanifoHC[4],renyuaninfo);
				elseif subgroup==5 then
					table.insert(renyuanifoHC[5],renyuaninfo);
				elseif subgroup==6 then
					table.insert(renyuanifoHC[6],renyuaninfo);
				elseif subgroup==7 then
					table.insert(renyuanifoHC[7],renyuaninfo);
				elseif subgroup==8 then
					table.insert(renyuanifoHC[8],renyuaninfo);
				end
			end
		end
		--更新已有人员数据
		local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
		if yiyoutuanduishuju>=numGroupMembers then
			for x=1,#renyuanifoHC do
				if #renyuanifoHC[x]>0 then
					for xx=1,#renyuanifoHC[x] do
								--检索组队信息里人员职责
								local zuduiinfo = PIG["RaidRecord"]["Invite"]["linshiInfo"]
								for v=#zuduiinfo,1, -1 do
									if renyuanifoHC[x][xx][4]==zuduiinfo[v][1] then
										if zuduiinfo[v][2]=="坦克补助" or zuduiinfo[v][2]=="治疗补助" then
											renyuanifoHC[x][xx][5]=zuduiinfo[v][2];
										end
										table.remove(zuduiinfo, v);
									end
								end
								--检索OLD
								local tuanduiinfo = PIG["RaidRecord"]["Raidinfo"]
								for i=1,8 do
									if #tuanduiinfo[i]>0 then
										for ii=1,#tuanduiinfo[i] do
											if renyuanifoHC[x][xx][4]==tuanduiinfo[i][ii][4] then
												renyuanifoHC[x][xx][5]=tuanduiinfo[i][ii][5];
												renyuanifoHC[x][xx][6]=tuanduiinfo[i][ii][6];
												renyuanifoHC[x][xx][7]=tuanduiinfo[i][ii][7];
												renyuanifoHC[x][xx][8]=tuanduiinfo[i][ii][8];
												renyuanifoHC[x][xx][9]=tuanduiinfo[i][ii][9];
												renyuanifoHC[x][xx][10]=tuanduiinfo[i][ii][10];
											end
										end
									end
								end
					end
				end
			end
			PIG["RaidRecord"]["Raidinfo"]=renyuanifoHC;
		end
	end
	--刷新显示
	local function UpdateShow()
		----------
		if fuFrame:IsShown() then
			local classes_Shu={0,0,0,0,0,0,0,0,0,0,0,0};
			local classes_zongShu=0;
			local buzhurenshu={0,0,0,0,0};
			for i=1, 8 do
				for ii=1, 5 do
					_G["DuiwuF_P_"..i.."_"..ii]:Hide();
					_G["DuiwuF_P_"..i.."_"..ii].Name:SetText()
					_G["DuiwuF_P_"..i.."_"..ii].zhizeIcon:Hide();
					_G["DuiwuF_P_"..i.."_"..ii].fenGbili:Hide();
					_G["DuiwuF_P_"..i.."_"..ii].fenGbili_1:Hide();
					_G["DuiwuF_P_"..i.."_"..ii].fenGbili_2:Hide();
				end
			end
			local shujuyuan = PIG["RaidRecord"]["Raidinfo"]
			for i=1, #shujuyuan do
				if #shujuyuan[i]>0 then
					for ii=1, #shujuyuan[i] do
							for xx=1,#cl_Name do
								if shujuyuan[i][ii][3]==cl_Name[xx] then
									classes_Shu[xx]=classes_Shu[xx]+1;
								end
							end
							classes_zongShu=classes_zongShu+1;
							_G["DuiwuF_P_"..i.."_"..ii]:Show();
							_G["DuiwuF_P_"..i.."_"..ii].Name.Pserver=shujuyuan[i][ii][4]
							local name1,name2 = strsplit("-", shujuyuan[i][ii][4]);
							_G["DuiwuF_P_"..i.."_"..ii].Name:SetText(name1)
							_G["DuiwuF_P_"..i.."_"..ii].Name:SetTextColor(shujuyuan[i][ii][2][1],shujuyuan[i][ii][2][2],shujuyuan[i][ii][2][3], 1);
							if shujuyuan[i][ii][5]=="坦克补助" then
								buzhurenshu[1]=buzhurenshu[1]+1;
								_G["DuiwuF_P_"..i.."_"..ii].zhizeIcon:Show();
								_G["DuiwuF_P_"..i.."_"..ii].zhizeIcon:SetTexCoord(zhizeIcon[1][1],zhizeIcon[1][2],zhizeIcon[1][3],zhizeIcon[1][4]);
							elseif shujuyuan[i][ii][5]=="治疗补助" then
								buzhurenshu[2]=buzhurenshu[2]+1;
								_G["DuiwuF_P_"..i.."_"..ii].zhizeIcon:Show();
								_G["DuiwuF_P_"..i.."_"..ii].zhizeIcon:SetTexCoord(zhizeIcon[2][1],zhizeIcon[2][2],zhizeIcon[2][3],zhizeIcon[2][4]);
							elseif shujuyuan[i][ii][5]=="其他补助" then
								buzhurenshu[3]=buzhurenshu[3]+1;
								_G["DuiwuF_P_"..i.."_"..ii].zhizeIcon:Show();
								_G["DuiwuF_P_"..i.."_"..ii].zhizeIcon:SetTexCoord(zhizeIcon[3][1],zhizeIcon[3][2],zhizeIcon[3][3],zhizeIcon[3][4]);				
							end
							if shujuyuan[i][ii][7]==2 then
								_G["DuiwuF_P_"..i.."_"..ii].fenGbili:Show();
							elseif shujuyuan[i][ii][7]==0.5 then
								_G["DuiwuF_P_"..i.."_"..ii].fenGbili_1:Show();
							elseif shujuyuan[i][ii][7]==0 then
								_G["DuiwuF_P_"..i.."_"..ii].fenGbili_2:Show();			
							end
					end
				end
			end
			for j=1,#cl_Name do
				_G["classes_"..j].Num:SetText(classes_Shu[j]);
			end
			for x=1,#zhizeIcon do
				_G["zhize_"..x].Num:SetText(buzhurenshu[x]);
			end
			fuFrame.All.Num:SetText(classes_zongShu);
		end
	end
	local function Update_BUT()
		local IsInGroup = IsInGroup();
		if IsInGroup then
			huoquRaidInfo_UI:Enable();
		else
			huoquRaidInfo_UI:Disable();
		end
		if PIG["RaidRecord"]["Dongjie"]=="OFF" then
			fuFrame:UnregisterEvent("CHAT_MSG_WHISPER"); 
			huoquRaidInfo_UI:SetText('冻结人员信息');
			RaidR_UI.xiafangF.DongjieTishi:Hide();--冻结提示
			fuFrame.shuaxinINFO:Hide();--人员分组获取按钮
			fenG_BUT_UI:Disable();
			zudui_but_UI:Enable();	
		elseif PIG["RaidRecord"]["Dongjie"]=="ON" then
			fuFrame:RegisterEvent("CHAT_MSG_WHISPER");
			huoquRaidInfo_UI:SetText('更新冻结信息');		
			RaidR_UI.xiafangF.DongjieTishi:Show();
			fuFrame.shuaxinINFO:Show();
			fenG_BUT_UI:Enable();
			zudui_but_UI:Disable();
		end
	end
	addonTable.RaidInfo_Update_BUT = Update_BUT;
	--==刷新冻结数据===========================================
	fuFrame.shuaxinINFO = CreateFrame("Button",nil,fuFrame, "UIMenuButtonStretchTemplate");
	fuFrame.shuaxinINFO:SetSize(24,24);
	fuFrame.shuaxinINFO:SetPoint("TOPRIGHT", fuFrame, "TOPRIGHT", -6,-10);
	fuFrame.shuaxinINFO:Hide();
	fuFrame.shuaxinINFO.Tex = fuFrame.shuaxinINFO:CreateTexture(nil, "BORDER");
	fuFrame.shuaxinINFO.Tex:SetTexture("interface/buttons/ui-refreshbutton.blp");
	fuFrame.shuaxinINFO.Tex:SetPoint("CENTER");
	fuFrame.shuaxinINFO.Tex:SetSize(14,14);
	fuFrame.shuaxinINFO:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",1.5,-1.5);
	end);
	fuFrame.shuaxinINFO:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	fuFrame.shuaxinINFO:SetScript("OnClick", function (self)
		StaticPopup_Show("SHUAXINRENYUANXINXI");
	end);

	StaticPopupDialogs["SHUAXINRENYUANXINXI"] = {
		text = "确定提取\124cffffFF00最新\124r人员分组信息吗？\n将会执行以下操作：\n\124cff00FF00更新冻结人员最新团队分组信息\124r\n\124cff00FF00无法获取位置信息的成员(已离队)将会被移动到末尾\124r\n",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			--UpdateShow()
			print("功能尚未实装！")
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	--===================================================
	local fenGbiliIcon = {
		"interface/gossipframe/transmogrifygossipicon.blp",
		"interface/glues/characterselect/glues-addon-icons.blp",
		"interface/glues/characterselect/glues-addon-icons.blp",}
	local fenGbiliIconCaiqie = {{0,1,0,1},{0.75,1,0,1},{0.49,0.75,0,1}}
	local ClickCaidanW,ClickCaidanH = 140,22;
	local topjulu,duiwuW,duiwuH,jiaosejiange = 56,28,30,6;
	-- 设置/坦克/治疗/开怪猎人
	local LeftmenuName={"设为坦克补助","设为治疗补助","设为其他补助","撤销补助设置","取消"}
	local RightmenuName={"设为双倍工资","设为0.5倍工资","设为不分G","恢复默认1倍","取消"}
	local playerClick = CreateFrame("Frame", "playerClick_UI", fuFrame,"BackdropTemplate");
	playerClick:SetBackdrop( { bgFile = "interface/minimap/tooltipbackdrop-background.blp",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12, 
		insets = { left = 2, right = 2, top = 2, bottom = 2 }});
	playerClick:SetSize(ClickCaidanW,(ClickCaidanH+4)*#LeftmenuName+40);
	playerClick:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",0,0);
	playerClick:SetFrameStrata("FULLSCREEN_DIALOG")
	playerClick:EnableMouse(true)
	playerClick:Hide();
	playerClick.Name = playerClick:CreateFontString();
	playerClick.Name:SetPoint("TOP",playerClick,"TOP", 0, -4);
	playerClick.Name:SetHeight(ClickCaidanH);
	playerClick.Name:SetFontObject(GameFontNormal);
	playerClick.xiaoshidaojishi = 0;
	playerClick.zhengzaixianshi = nil;
	playerClick:SetScript("OnUpdate", function(self, ssss)
		if playerClick.zhengzaixianshi==nil then
			return;
		else
			if playerClick.zhengzaixianshi==true then
				if playerClick.xiaoshidaojishi<= 0 then
					playerClick:Hide();
					playerClick.zhengzaixianshi = nil;
				else
					playerClick.xiaoshidaojishi = playerClick.xiaoshidaojishi - ssss;	
				end
			end
		end
	end)
	playerClick:SetScript("OnEnter", function()
		playerClick.zhengzaixianshi = nil;
	end)
	playerClick:SetScript("OnLeave", function()
		playerClick.xiaoshidaojishi = 1.5;
		playerClick.zhengzaixianshi = true;
	end)
	--菜单函数
	local function ClickMenuFUN(menuN,nameser)
		local shujuyuan = PIG["RaidRecord"]["Raidinfo"]
		for i=1, #shujuyuan do
			if #shujuyuan[i]>0 then
				for ii=1, #shujuyuan[i] do
					if shujuyuan[i][ii][4]==nameser then
						if menuN=="设为坦克补助" then
							shujuyuan[i][ii][5]="坦克补助";
						elseif menuN=="设为治疗补助" then
							shujuyuan[i][ii][5]="治疗补助";
						elseif menuN=="设为其他补助" then
							shujuyuan[i][ii][5]="其他补助";
						elseif menuN=="撤销补助设置" then
							shujuyuan[i][ii][5]="无";
						elseif menuN=="设为双倍工资" then
							shujuyuan[i][ii][7]=2;
						elseif menuN=="设为0.5倍工资" then
							shujuyuan[i][ii][7]=0.5;
						elseif menuN=="设为不分G" then
							shujuyuan[i][ii][7]=0;
						elseif menuN=="恢复默认1倍" then
							shujuyuan[i][ii][7]=1;
						end
						addonTable.RaidRecord_UpdateG();
						break
					end
				end
			end
		end
	end
	-----
	for i=1,#LeftmenuName do
		local playerClickMenu = CreateFrame("Frame", "playerClickMenu_"..i, playerClick);
		playerClickMenu:SetHeight(ClickCaidanH);
		playerClickMenu:SetPoint("LEFT",playerClick,"LEFT", 10, 0);
		playerClickMenu:SetPoint("RIGHT",playerClick,"RIGHT", -10, 0);
		if i==1 then
			playerClickMenu:SetPoint("TOP",playerClick.Name,"BOTTOM", 0, -4);
		else
			playerClickMenu:SetPoint("TOPLEFT",_G["playerClickMenu_"..(i-1)],"BOTTOMLEFT", 0, -4);
		end
		playerClickMenu.highlight = playerClickMenu:CreateTexture(nil, "BACKGROUND");
		playerClickMenu.highlight:SetTexture("interface/buttons/ui-listbox-highlight.blp");
		playerClickMenu.highlight:SetSize(playerClickMenu:GetWidth(),ClickCaidanH);
		playerClickMenu.highlight:SetPoint("TOPLEFT", playerClickMenu, "TOPLEFT", 0,0);
		playerClickMenu.highlight:SetPoint("BOTTOMRIGHT", playerClickMenu, "BOTTOMRIGHT", 0,0);
		playerClickMenu.highlight:SetAlpha(0.9);
		playerClickMenu.highlight:Hide();
		if i<4 then
			playerClickMenu.tex = playerClickMenu:CreateTexture(nil, "ARTWORK");
			playerClickMenu.tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
			playerClickMenu.tex:SetTexCoord(zhizeIcon[i][1],zhizeIcon[i][2],zhizeIcon[i][3],zhizeIcon[i][4]);
			playerClickMenu.tex:SetSize(ClickCaidanH,ClickCaidanH);
			playerClickMenu.tex:SetPoint("LEFT", playerClickMenu, "LEFT", 0,0);
		end
		playerClickMenu.text = playerClickMenu:CreateFontString();
		playerClickMenu.text:SetPoint("LEFT",playerClickMenu,"LEFT", 22, 0);
		playerClickMenu.text:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		playerClickMenu.text:SetText(LeftmenuName[i]);
		playerClickMenu:SetScript("OnEnter", function (self)
			self.highlight:Show();
			playerClick.zhengzaixianshi = nil;
		end);
		playerClickMenu:SetScript("OnLeave", function (self)
			self.highlight:Hide();
			playerClick.xiaoshidaojishi = 1.5;
			playerClick.zhengzaixianshi = true;
		end);
		playerClickMenu:SetScript("OnMouseDown", function (self)
			if i<4 then self.tex:SetPoint("LEFT",self,"LEFT",1,-1); end
			self.text:SetPoint("LEFT",self,"LEFT",23,-1);
		end);
		playerClickMenu:SetScript("OnMouseUp", function (self,button)
			if i<4 then self.tex:SetPoint("LEFT",self,"LEFT",0,0);end
			self.text:SetPoint("LEFT",self,"LEFT",22,0);
			ClickMenuFUN(self.text:GetText(),playerClick.Name.PS)
			playerClick:Hide();
			UpdateShow()
		end);
	end
	fuFrame:SetScript("OnHide", function ()
		playerClick:Hide();
	end)
	------------------------------------------------------------
	--创建队伍角色框架
	for p=1,8 do
		local DuiwuF = CreateFrame("Frame", "DuiwuF_"..p, fuFrame);
		DuiwuF:SetSize(duiwu_Width,duiwu_Height*5+24);
		if p==1 then
			DuiwuF:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",26,-54);
		end
		if p>1 and p<5 then
			DuiwuF:SetPoint("LEFT",_G["DuiwuF_"..(p-1)],"RIGHT",jiangeW,jiangeH);
		end
		if p==5 then
			DuiwuF:SetPoint("TOP",DuiwuF_1,"BOTTOM",0,-20);
		end
		if p>5 then
			DuiwuF:SetPoint("LEFT",_G["DuiwuF_"..(p-1)],"RIGHT",jiangeW,jiangeH);
		end
		for pp=1,5 do
			local DuiwuF_P = CreateFrame("Frame", "DuiwuF_P_"..p.."_"..pp, DuiwuF);
			DuiwuF_P:SetSize(duiwu_Width,duiwu_Height);
			if pp==1 then
				DuiwuF_P:SetPoint("TOP",DuiwuF,"TOP",0,0);
			else
				DuiwuF_P:SetPoint("TOP",_G["DuiwuF_P_"..p.."_"..(pp-1)],"BOTTOM",0,-6);
			end
			DuiwuF_P.HP = DuiwuF_P:CreateTexture(nil, "BORDER");
			DuiwuF_P.HP:SetTexture("Interface/DialogFrame/UI-DialogBox-Background");
			DuiwuF_P.HP:SetColorTexture(1, 1, 1, 0.1)
			DuiwuF_P.HP:SetSize(duiwu_Width,duiwu_Height);
			DuiwuF_P.HP:SetPoint("CENTER");
			DuiwuF_P.zhizeIcon = DuiwuF_P:CreateTexture(nil, "ARTWORK");
			DuiwuF_P.zhizeIcon:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
			DuiwuF_P.zhizeIcon:SetSize(duiwu_Height-6,duiwu_Height-6);
			DuiwuF_P.zhizeIcon:SetPoint("LEFT", DuiwuF_P, "LEFT", 2,0);
			DuiwuF_P.Name = DuiwuF_P:CreateFontString("DuiwuF_P.Name_"..p.."_"..pp);
			DuiwuF_P.Name:SetPoint("CENTER",DuiwuF_P,"CENTER",0,1);
			DuiwuF_P.Name:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
			DuiwuF_P.fenGbili = DuiwuF_P:CreateTexture(nil, "ARTWORK");
			DuiwuF_P.fenGbili:SetTexture(fenGbiliIcon[1]);
			DuiwuF_P.fenGbili:SetSize(duiwu_Height-7,duiwu_Height-7);
			DuiwuF_P.fenGbili:SetPoint("RIGHT", DuiwuF_P, "RIGHT", -2,-0.6);
			DuiwuF_P.fenGbili_1 = DuiwuF_P:CreateTexture(nil, "ARTWORK");
			DuiwuF_P.fenGbili_1:SetTexture(fenGbiliIcon[2]);
			DuiwuF_P.fenGbili_1:SetTexCoord(fenGbiliIconCaiqie[2][1],fenGbiliIconCaiqie[2][2],fenGbiliIconCaiqie[2][3],fenGbiliIconCaiqie[2][4]);
			DuiwuF_P.fenGbili_1:SetSize(duiwu_Height-10,duiwu_Height-10);
			DuiwuF_P.fenGbili_1:SetPoint("RIGHT", DuiwuF_P, "RIGHT", -2,0);
			DuiwuF_P.fenGbili_2 = DuiwuF_P:CreateTexture(nil, "ARTWORK");
			DuiwuF_P.fenGbili_2:SetTexture(fenGbiliIcon[3]);
			DuiwuF_P.fenGbili_2:SetTexCoord(fenGbiliIconCaiqie[3][1],fenGbiliIconCaiqie[3][2],fenGbiliIconCaiqie[3][3],fenGbiliIconCaiqie[3][4]);
			DuiwuF_P.fenGbili_2:SetSize(duiwu_Height-10,duiwu_Height-10);
			DuiwuF_P.fenGbili_2:SetPoint("RIGHT", DuiwuF_P, "RIGHT", -2,0);
			DuiwuF_P:SetScript("OnMouseDown", function (self)
				self.zhizeIcon:SetPoint("LEFT",self,"LEFT",3,-1);
				self.fenGbili:SetPoint("RIGHT", DuiwuF_P, "RIGHT", -0.5,-2.1);
				self.fenGbili_1:SetPoint("RIGHT", DuiwuF_P, "RIGHT", -0.5,-1.5);
				self.fenGbili_2:SetPoint("RIGHT", DuiwuF_P, "RIGHT", -0.5,-1.5);
				self.Name:SetPoint("CENTER",self,"CENTER",1.5,-0.5);
			end);
			DuiwuF_P:SetScript("OnMouseUp", function (self,button)
				self.zhizeIcon:SetPoint("LEFT",self,"LEFT",2,0);
				self.fenGbili:SetPoint("RIGHT", DuiwuF_P, "RIGHT", -2,-0.6);
				self.fenGbili_1:SetPoint("RIGHT", DuiwuF_P, "RIGHT", -2,0);
				self.fenGbili_2:SetPoint("RIGHT", DuiwuF_P, "RIGHT", -2,0);
				self.Name:SetPoint("CENTER",self,"CENTER",0,1);
				if button=="LeftButton" then
					playerClick:ClearAllPoints();
					playerClick:SetPoint("TOP",self,"BOTTOM",0,4);
					if playerClick:IsShown() then
						playerClick:Hide();
					else
						playerClick:Show();
						playerClick.Name:SetText(self.Name:GetText());
						playerClick.Name.PS=self.Name.Pserver
						playerClick.xiaoshidaojishi = 1.5;
						playerClick.zhengzaixianshi = true;
						for i=1,#LeftmenuName do
							if i<4 then
								_G["playerClickMenu_"..i].tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
								_G["playerClickMenu_"..i].tex:SetTexCoord(zhizeIcon[i][1],zhizeIcon[i][2],zhizeIcon[i][3],zhizeIcon[i][4]);
							end
							_G["playerClickMenu_"..i].text:SetText(LeftmenuName[i]);
						end
					end
				elseif button=="RightButton" then
					playerClick:ClearAllPoints();
					playerClick:SetPoint("TOP",self,"BOTTOM",0,4);
					if playerClick:IsShown() then
						playerClick:Hide();
					else
						playerClick:Show();
						playerClick.Name:SetText(self.Name:GetText());
						playerClick.Name.PS=self.Name.Pserver
						playerClick.xiaoshidaojishi = 1.5;
						playerClick.zhengzaixianshi = true;
						for i=1,#RightmenuName do
							if i==1 then
								_G["playerClickMenu_"..i].tex:SetTexture(fenGbiliIcon[i]);
								_G["playerClickMenu_"..i].tex:SetTexCoord(0,1,0,1);
							elseif i<4 then
								_G["playerClickMenu_"..i].tex:SetTexture(fenGbiliIcon[i]);
								_G["playerClickMenu_"..i].tex:SetTexCoord(fenGbiliIconCaiqie[i][1],fenGbiliIconCaiqie[i][2],fenGbiliIconCaiqie[i][3],fenGbiliIconCaiqie[i][4]);
							end
							_G["playerClickMenu_"..i].text:SetText(RightmenuName[i]);
						end
					end
				end
			end);
		end
	end
	----=========================================================
	--冻结模式提示
	local wwwx,hhhx = 32,32
	RaidR_UI.xiafangF.DongjieTishi = CreateFrame("Frame", nil, RaidR_UI.xiafangF);
	RaidR_UI.xiafangF.DongjieTishi:SetSize(wwwx,hhhx);
	RaidR_UI.xiafangF.DongjieTishi:SetPoint("TOPLEFT",RaidR_UI.xiafangF,"TOPLEFT",Width*0.55,-2);
	RaidR_UI.xiafangF.DongjieTishi:Hide();
	RaidR_UI.xiafangF.DongjieTishi.Tex = RaidR_UI.xiafangF.DongjieTishi:CreateTexture(nil, "BORDER");
	RaidR_UI.xiafangF.DongjieTishi.Tex:SetTexture("interface/icons/spell_frost_frost.blp");
	RaidR_UI.xiafangF.DongjieTishi.Tex:SetSize(wwwx,hhhx);
	RaidR_UI.xiafangF.DongjieTishi.Tex:SetPoint("CENTER",RaidR_UI.xiafangF.DongjieTishi,"CENTER",0,0);
	RaidR_UI.xiafangF.DongjieTishi:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("\124cff00BFFF人员信息已冻结\124r")
		GameTooltip:AddLine("\124cff00FF00如需获取人员实时信息，请点击此图标关闭冻结！\124r")
		GameTooltip:Show();
	end);
	RaidR_UI.xiafangF.DongjieTishi:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	RaidR_UI.xiafangF.DongjieTishi:SetScript("OnMouseUp", function ()
		StaticPopup_Show("OFFSHISHIRAIDINFO");
	end);
	StaticPopupDialogs["OFFSHISHIRAIDINFO"] = {
		text = "确定解除人员信息冻结吗？\n\n解除后人员将实时更新\n\n\124cff00FF00分G计算前需重新冻结\124r\n\n",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG["RaidRecord"]["Dongjie"] = "OFF";
			UpdateRiadInfo();
			UpdateShow()
			Update_BUT()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}

	--冻结人员信息
	RaidR_UI.xiafangF.huoquRaidInfo = CreateFrame("Button","huoquRaidInfo_UI",RaidR_UI.xiafangF, "UIPanelButtonTemplate");
	RaidR_UI.xiafangF.huoquRaidInfo:SetSize(110,28);
	RaidR_UI.xiafangF.huoquRaidInfo:SetPoint("BOTTOMLEFT",RaidR_UI.xiafangF.lian,"BOTTOMLEFT",6,6);
	RaidR_UI.xiafangF.huoquRaidInfo:SetText('冻结人员信息');
	RaidR_UI.xiafangF.huoquRaidInfo:SetMotionScriptsWhileDisabled(true)
	RaidR_UI.xiafangF.huoquRaidInfo:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("提示：")
		GameTooltip:AddLine("\124cff00ff001、分G计算前需冻结人员信息，防止人员变动影响分G计算结果。\124r\n"..
			"\124cff00ff002、冻结后方可在\124r\124cffFFff00分G助手\124r\124cff00ff00计算分账明细。\124r\n")
		GameTooltip:AddLine(
			"\124cffFFA500建议在活动结束后人员变动之前冻结人员信息。冻结之后，分G结果\n不会因\124r\124cffFFff00新增人员/移动分组/人员退组/离线\124r\124cffFFA500而改变。\124r")
		GameTooltip:Show();
	end);
	RaidR_UI.xiafangF.huoquRaidInfo:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	RaidR_UI.xiafangF.huoquRaidInfo:SetScript("OnClick", function (self)
		if self:GetText()=='更新冻结信息' then
			StaticPopup_Show("HUOQU_RAIDINFO_UP");
		elseif self:GetText()=='冻结人员信息' then
			StaticPopup_Show("HUOQU_RAIDINFO");
		end
	end);
	StaticPopupDialogs["HUOQU_RAIDINFO_UP"] = {
		text = "确定要更新已冻结人员信息吗？\n\n",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG["RaidRecord"]["Dongjie"] = "ON";
			addonTable.RaidRecord_Invite_yaoqing=false;
			addonTable.RaidRecord_Invite_hanhua=false;
			UpdateRiadInfo();
			UpdateShow()
			Update_BUT()
			addonTable.RaidRecord_UpdateChengjiaorenxuanze()
			addonTable.RaidRecord_Updatejianglixuanze()
			addonTable.RaidRecord_Updatefakuanxuanze()
			print("|cff00FFFF!Pig:|r|cffFFFF00人员冻结信息已更新！|r");
			local isLeader = UnitIsGroupLeader("player");
			if isLeader then
				local fullName, realm = UnitFullName("player")
				local IsInRaid=IsInRaid();
				if IsInRaid then
					SendChatMessage("人员冻结信息已更新,退组/离线/不影响分G，需要邮寄工资请私聊【"..fullName.."】,私聊内容请打:邮寄工资", "RAID_WARNING", nil);
				else
					SendChatMessage("人员冻结信息已更新,退组/离线/不影响分G，需要邮寄工资请私聊【"..fullName.."】,私聊内容请打:邮寄工资", "PARTY", nil);
				end
			end
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	StaticPopupDialogs["HUOQU_RAIDINFO"] = {
		text = "确定冻结当前人员信息列表吗？\n\n",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG["RaidRecord"]["Dongjie"] = "ON";
			addonTable.RaidRecord_Invite_yaoqing=false;
			addonTable.RaidRecord_Invite_hanhua=false;
			Update_BUT()
			print("|cff00FFFF!Pig:|r|cffFFFF00人员信息已冻结！|r");
			local isLeader = UnitIsGroupLeader("player");
			if isLeader then
				local fullName, realm = UnitFullName("player")
				local IsInRaid=IsInRaid();
				if IsInRaid then
					SendChatMessage("人员信息已冻结,退组/离线/不影响分G，需要邮寄工资请私聊【"..fullName.."】,私聊内容请打:邮寄工资", "RAID_WARNING", nil);
				else
					SendChatMessage("人员信息已冻结,退组/离线/不影响分G，需要邮寄工资请私聊【"..fullName.."】,私聊内容请打:邮寄工资", "PARTY", nil);
				end
			end
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}

	--界面显示隐藏刷新
	fuFrame:SetScript("OnShow", function ()
		UpdateShow()
	end)
	--=============================================================================
	fuFrame:HookScript("OnEvent",function(self, event,arg1,_,_,_,arg5)
		if event=="GROUP_ROSTER_UPDATE" then
			Update_BUT()
			if PIG["RaidRecord"]["Dongjie"] == "OFF" then
				UpdateRiadInfo()
				if fuFrame:IsShown() then UpdateShow() end
				addonTable.RaidRecord_UpdateChengjiaorenxuanze()
				addonTable.RaidRecord_Updatejianglixuanze()
				addonTable.RaidRecord_Updatefakuanxuanze()
			end
		end
		--私聊激活邮寄图标
		if event=="CHAT_MSG_WHISPER" then
			local mailYES=arg1:find("邮寄", 1)
			if mailYES then
				local gongzi=arg1:find("工资", 1)
				local xinshui=arg1:find("薪水", 1)
				if gongzi or xinshui then
					for x=1,8 do
						for xx=1,#PIG["RaidRecord"]["Raidinfo"][x] do
							if #PIG["RaidRecord"]["Raidinfo"][x][xx]>0 then
								if arg5 == PIG["RaidRecord"]["Raidinfo"][x][xx][4] then
									if PIG["RaidRecord"]["Raidinfo"][x][xx][9]==0 then
										PIG["RaidRecord"]["Raidinfo"][x][xx][9]=1;
										SendChatMessage("已登记，工资将通过邮件送达,请注意查收！", "WHISPER", nil, arg5);
										addonTable.RaidRecord_jisuanfenGData()--更新分G界面
									elseif PIG["RaidRecord"]["Raidinfo"][x][xx][9]==1 then
										SendChatMessage("你已登记，请勿重复发送！", "WHISPER", nil, arg5);
									end
								end
							end
						end
					end
				end
			end
		end
	end)
	----------------------------------------------------------
	if PIG["RaidRecord"]["Kaiqi"]=="ON" then
		local englishFaction, _ = UnitFactionGroup("player")
		if englishFaction=="Alliance" then
			fuFrame.All.Tex:SetTexCoord(0,0.5,0,1);
		elseif englishFaction=="Horde" then
			fuFrame.All.Tex:SetTexCoord(0.5,1,0,1);
		end
		fuFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
	else
		fuFrame:UnregisterEvent("GROUP_ROSTER_UPDATE")
		fuFrame:UnregisterEvent("CHAT_MSG_WHISPER");
	end
end
addonTable.ADD_RaidInfo = ADD_RaidInfo;