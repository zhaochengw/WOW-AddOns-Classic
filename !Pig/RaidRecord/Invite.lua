local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
--=====组队助手==========================================================
local function ADD_Invite()
	local Width,Height  = RaidR_UI:GetWidth(), RaidR_UI:GetHeight();
	--组队助手
	RaidR_UI.xiafangF.zudui = CreateFrame("Button","zudui_but_UI",RaidR_UI.xiafangF, "UIPanelButtonTemplate");
	RaidR_UI.xiafangF.zudui:SetSize(80,28);
	RaidR_UI.xiafangF.zudui:SetPoint("TOPLEFT",RaidR_UI.xiafangF,"TOPLEFT",Width*0.73,-6);
	RaidR_UI.xiafangF.zudui:SetText('组队助手');
	RaidR_UI.xiafangF.zudui:SetMotionScriptsWhileDisabled(true)
	RaidR_UI.xiafangF.zudui:SetScript("OnEnter", function (self)
		if not self:IsEnabled() then
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
			GameTooltip:AddLine("提示：")
			GameTooltip:AddLine("\124cff00ff00请先解除人员冻结\124r")
			GameTooltip:Show();
		end
	end);
	RaidR_UI.xiafangF.zudui:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	RaidR_UI.xiafangF.zudui.tex = RaidR_UI.xiafangF.zudui:CreateTexture(nil, "OVERLAY");
	RaidR_UI.xiafangF.zudui.tex:SetTexture("interface/helpframe/helpbuttons.blp");
	RaidR_UI.xiafangF.zudui.tex:SetTexCoord(0,0.68,0.66,0.86);
	RaidR_UI.xiafangF.zudui.tex:SetSize(74,20);
	RaidR_UI.xiafangF.zudui.tex:SetPoint("TOP",RaidR_UI.xiafangF.zudui,"TOP",0,-5);
	RaidR_UI.xiafangF.zudui.tex:Hide()
	------------------
	local invite = CreateFrame("Frame", "invite_UI", RaidR_UI,"BackdropTemplate");
	invite:SetBackdrop({bgFile = "interface/raidframe/ui-raidframe-groupbg.blp", 
		edgeFile = "interface/glues/common/textpanel-border.blp", 
		tile = false, tileSize = 20, edgeSize = 20,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
	invite:SetSize(Width-22,Height-100);
	invite:SetPoint("TOP",RaidR_UI,"TOP",0,-18);
	invite:SetFrameLevel(10);
	invite:EnableMouse(true);
	invite:Hide();
	invite.Close = CreateFrame("Button",nil,invite, "UIPanelCloseButton");  
	invite.Close:SetSize(34,34);
	invite.Close:SetPoint("TOPRIGHT",invite,"TOPRIGHT",2.4,2);
	invite.biaoti = invite:CreateFontString();
	invite.biaoti:SetPoint("TOP",invite,"TOP",0,-6);
	invite.biaoti:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
	invite.biaoti:SetTextColor(0, 1, 0, 1);
	invite.biaoti:SetText("!Pig组队助手");
	invite.X = invite:CreateLine()
	invite.X:SetColorTexture(1,1,1,0.4)
	invite.X:SetThickness(1);
	invite.X:SetStartPoint("TOPLEFT",4.6,-28)
	invite.X:SetEndPoint("TOPRIGHT",-3,-28)
	-----------------
	--职责
	invite.Icon = {{0.01,0.26,0.26,0.51},{0.27,0.52,0,0.25},{0.27,0.52,0.26,0.51}}
	invite.classes_Name={{},{},{}};
	invite.TND={"T_C","N_C","D_C"};
	--更新信息
	local function UpdatePlayersINFO()
		local shishirenshu={{},{},{}};
		for i=1,#invite.TND do
			for ii=1,#invite.classes_Name[i] do
				shishirenshu[i][ii]=0;
			end
		end
		-------------
		local shujuY = PIG["RaidRecord"]["Raidinfo"]
		for i=1, 8 do
			if #shujuY[i]>0 then
				for ii=1, #shujuY[i] do
					for x=1,#invite.TND do
						for xx=1,#invite.classes_Name[x] do
							if shujuY[i][ii][3]==invite.classes_Name[x][xx] then
								shishirenshu[x][xx]=shishirenshu[x][xx]+1;
							end
						end
					end
				end
			end
		end
		-------
		local INVshujuY = PIG["RaidRecord"]["Invite"]["dangqianrenshu"]
		shishirenshu.ALL=0
		for i=1,#invite.TND do
			invite.renshu={0,0};
			for ii=1,#invite.classes_Name[i] do
				_G[invite.TND[i].."_mubiao_E_"..ii]:SetText(INVshujuY[i][ii])
				_G[invite.TND[i].."_yizu_"..ii]:SetText(shishirenshu[i][ii])
				if shishirenshu[i][ii]<INVshujuY[i][ii] then
					_G[invite.TND[i].."_wancheng_"..ii]:Hide();
				else
					_G[invite.TND[i].."_wancheng_"..ii]:Show();
				end
				invite.renshu[1]=invite.renshu[1]+INVshujuY[i][ii];
				invite.renshu[2]=invite.renshu[2]+shishirenshu[i][ii];
			end
			_G[invite.TND[i].."_mubiaoAll"]:SetText("目标("..invite.renshu[1]..")");
			_G[invite.TND[i].."_yizuAll"]:SetText("当前("..invite.renshu[2]..")");
			shishirenshu.ALL=shishirenshu.ALL+invite.renshu[1]
		end
		local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
		invite.yizuzongrenshuX_V:SetText(numGroupMembers)
		invite.mubiaozongrenshuX_V:SetText(shishirenshu.ALL)
	end
	--创建框架---------------------------
	local biaotijuliW,biaotijuliH =72,2;
	local LEFTjuli,TOPjuli,hang_jiange=150,10,10;
	local zhiye_Height,zhiye_jiangeW,zhiye_jiangeH=20,40,7;
	local function ADD_zhize_Frame(Fname,xulie)
		--坦克
		local zhizeF = CreateFrame("Frame", Fname, invite,"BackdropTemplate");
		zhizeF:SetBackdrop( {edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 20, 
			insets = { left = 4, right = 4, top = 4, bottom = 4 } });
		zhizeF:SetBackdropBorderColor(1, 1, 1, 0.4);
		zhizeF:SetSize(Width-50,zhiye_Height*5+8);
		if xulie==1 then
			zhizeF:SetPoint("TOP",invite,"TOP",0,-40);
		else
			zhizeF:SetPoint("TOP",invite,"TOP",0,-((xulie-1)*(zhiye_Height*5+8+hang_jiange))-40);
		end
		zhizeF.Tex = zhizeF:CreateTexture(nil, "BORDER");
		zhizeF.Tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
		zhizeF.Tex:SetTexCoord(invite.Icon[xulie][1],invite.Icon[xulie][2],invite.Icon[xulie][3],invite.Icon[xulie][4]);
		zhizeF.Tex:SetSize(zhiye_Height*3,zhiye_Height*3);
		zhizeF.Tex:SetPoint("LEFT", zhizeF, "LEFT", 10,0);
		for id=1,#invite.classes_Name[xulie] do
			zhizeF.Icon = zhizeF:CreateTexture(Fname.."_Icon_"..id, "BORDER");
			zhizeF.Icon:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
			zhizeF.Icon:SetSize(zhiye_Height,zhiye_Height);
			if id==1 then
				zhizeF.Icon:SetPoint("TOPLEFT", zhizeF, "TOPLEFT", LEFTjuli,-TOPjuli);
			else
				zhizeF.Icon:SetPoint("LEFT",_G[Fname.."_Icon_"..(id-1)],"RIGHT",zhiye_jiangeW,0);
			end
			local coords = CLASS_ICON_TCOORDS[invite.classes_Name[xulie][id]]
			zhizeF.Icon:SetTexCoord(unpack(coords));

			zhizeF.mubiao_E = CreateFrame('EditBox', Fname.."_mubiao_E_"..id, zhizeF,"BackdropTemplate");
			zhizeF.mubiao_E:SetSize(zhiye_Height,zhiye_Height);
			zhizeF.mubiao_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = 0,right = 2,top = 0,bottom = -10}})
			zhizeF.mubiao_E:SetPoint("TOP", zhizeF.Icon, "BOTTOM", 0,-zhiye_jiangeH);
			zhizeF.mubiao_E:SetFontObject(ChatFontNormal);
			zhizeF.mubiao_E:SetMaxLetters(2)
			zhizeF.mubiao_E:SetJustifyH("CENTER");
			zhizeF.mubiao_E:SetAutoFocus(false);
			zhizeF.mubiao_E:SetScript("OnEscapePressed", function(self) 
				self:ClearFocus() 
			end);
			zhizeF.mubiao_E:SetScript("OnEnterPressed", function(self) 
				self:ClearFocus() 
			end);
			zhizeF.mubiao_E:SetScript("OnEditFocusLost", function(self)
				PIG["RaidRecord"]["Invite"]["dangqianrenshu"][xulie][id]=self:GetNumber();
				UpdatePlayersINFO()
			end);
			zhizeF.yizu = zhizeF:CreateFontString(Fname.."_yizu_"..id);
			zhizeF.yizu:SetHeight(zhiye_Height);
			zhizeF.yizu:SetPoint("TOP", zhizeF.mubiao_E, "BOTTOM", 0,-zhiye_jiangeH);
			zhizeF.yizu:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
			zhizeF.wancheng = zhizeF:CreateTexture(Fname.."_wancheng_"..id, "BORDER");
			--zhizeF.wancheng:SetTexture("interface/raidframe/readycheck-notready.blp");--X号
			zhizeF.wancheng:SetTexture("interface/raidframe/readycheck-ready.blp");
			zhizeF.wancheng:SetSize(zhiye_Height-4,zhiye_Height-4);
			zhizeF.wancheng:SetPoint("TOP", zhizeF.yizu, "BOTTOM", 0,-zhiye_jiangeH+6);
		end
		-------
		zhizeF.mubiaoAll = zhizeF:CreateFontString(Fname.."_mubiaoAll");
		zhizeF.mubiaoAll:SetPoint("LEFT", _G[Fname.."_mubiao_E_1"], "LEFT", -biaotijuliW,biaotijuliH);
		zhizeF.mubiaoAll:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		zhizeF.yizuAll = zhizeF:CreateFontString(Fname.."_yizuAll");
		zhizeF.yizuAll:SetPoint("LEFT", _G[Fname.."_yizu_1"], "LEFT", -biaotijuliW-4,biaotijuliH);
		zhizeF.yizuAll:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	end
	local function chuangjianFrame()
		for i=1,#invite.TND do
			ADD_zhize_Frame(invite.TND[i],i)
		end
	end
	-------------------

	local xiafangjudingH =400
	--载入默认人数配置
	invite.renyuannpeizhiinfo = invite:CreateFontString("renyuannpeizhiinfo_UI");
	invite.renyuannpeizhiinfo:SetPoint("TOPLEFT",invite,"TOPLEFT",16,-xiafangjudingH);
	invite.renyuannpeizhiinfo:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	invite.renyuannpeizhiinfo:SetText("\124cff00FF00导入配置\124r");
	--
	local fubenMoshi ={10,20,25,40};
	invite.renyuannpeizhiinfo_D = CreateFrame("FRAME", nil, invite, "UIDropDownMenuTemplate")
	invite.renyuannpeizhiinfo_D:SetPoint("LEFT",invite.renyuannpeizhiinfo,"RIGHT",-16,-3)
	UIDropDownMenu_SetWidth(invite.renyuannpeizhiinfo_D, 58)

	local function renyuannpeizhiinfo_Up()
		local info = UIDropDownMenu_CreateInfo()
		info.func = invite.renyuannpeizhiinfo_D.SetValue
		for i=1,#fubenMoshi,1 do
		    info.text, info.arg1 = fubenMoshi[i].."人", fubenMoshi[i];
		    info.notCheckable = true;
			UIDropDownMenu_AddButton(info)
		end 
	end
	function invite.renyuannpeizhiinfo_D:SetValue(newValue)
			if newValue==10 then
				PIG["RaidRecord"]["Invite"]["dangqianrenshu"]=PIG["RaidRecord"]["Invite"]["LMBL"]["10人配置"];
			elseif newValue==20 then
				PIG["RaidRecord"]["Invite"]["dangqianrenshu"]=PIG["RaidRecord"]["Invite"]["LMBL"]["20人配置"];
			elseif newValue==25 then
				PIG["RaidRecord"]["Invite"]["dangqianrenshu"]=PIG["RaidRecord"]["Invite"]["LMBL"]["25人配置"];
			elseif newValue==40 then
				PIG["RaidRecord"]["Invite"]["dangqianrenshu"]=PIG["RaidRecord"]["Invite"]["LMBL"]["40人配置"];
			end
		UIDropDownMenu_SetText(invite.renyuannpeizhiinfo_D, newValue.."人")
		PIG["RaidRecord"]["Invite"]["dangqianpeizhi"]=newValue;
		print("|cff00FFFF!Pig:|r|cffFFFF00已导入|r"..newValue.."|cffFFFF00人副本职业配置！|r");
		CloseDropDownMenus();
		UpdatePlayersINFO();
	end
	--====================================================================
	--总人数
	invite.zongrenshuX = invite:CreateFontString();
	invite.zongrenshuX:SetPoint("LEFT",invite.renyuannpeizhiinfo_D,"RIGHT",-12,3);
	invite.zongrenshuX:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	invite.zongrenshuX:SetText("\124cff00FF00总人数：\124r");
	invite.yizuzongrenshuX_V = invite:CreateFontString();
	invite.yizuzongrenshuX_V:SetPoint("LEFT",invite.zongrenshuX,"RIGHT",0,-0);
	invite.yizuzongrenshuX_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	invite.yizuzongrenshuX_V:SetText(0);
	invite.fengefuxie = invite:CreateFontString();
	invite.fengefuxie:SetPoint("LEFT",invite.yizuzongrenshuX_V,"RIGHT",0,-0);
	invite.fengefuxie:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	invite.fengefuxie:SetText("\124cff00FF00/\124r");
	invite.mubiaozongrenshuX_V = invite:CreateFontString();
	invite.mubiaozongrenshuX_V:SetPoint("LEFT",invite.fengefuxie,"RIGHT",0,-0);
	invite.mubiaozongrenshuX_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	invite.mubiaozongrenshuX_V:SetText(0);

	---进组指令
	invite.jinzuzhiling = invite:CreateFontString();
	invite.jinzuzhiling:SetPoint("LEFT",invite.zongrenshuX,"RIGHT",58,0);
	invite.jinzuzhiling:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	invite.jinzuzhiling:SetText("\124cff00FF00进组指令：\124r");
	invite.jinzuzhiling_E = CreateFrame('EditBox', nil, invite,"BackdropTemplate");
	invite.jinzuzhiling_E:SetSize(49,zhiye_Height+14);
	invite.jinzuzhiling_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -2,right = 2,top = 4,bottom = -10}})
	invite.jinzuzhiling_E:SetPoint("LEFT", invite.jinzuzhiling, "RIGHT", 6,-0);
	invite.jinzuzhiling_E:SetFontObject(ChatFontNormal);
	invite.jinzuzhiling_E:SetMaxLetters(6)
	invite.jinzuzhiling_E:SetAutoFocus(false);
	invite.jinzuzhiling_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
	end);
	invite.jinzuzhiling_E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	invite.jinzuzhiling_E:SetScript("OnEditFocusLost", function(self)
		PIG["RaidRecord"]["Invite"]["jinzuZhiling"]=self:GetText();
	end);
	--无限制邀请
	invite.INV_wuxianzhiyaoqing = CreateFrame("CheckButton", nil, invite, "ChatConfigCheckButtonTemplate");
	invite.INV_wuxianzhiyaoqing:SetSize(28,28);
	invite.INV_wuxianzhiyaoqing:SetHitRectInsets(0,0,0,0);
	invite.INV_wuxianzhiyaoqing:SetPoint("LEFT",invite.jinzuzhiling_E,"RIGHT",8,-1);
	invite.INV_wuxianzhiyaoqing.Text:SetText("无限制");
	invite.INV_wuxianzhiyaoqing.tooltip = "收到邀请指令后不再判断职业职责，将直接邀请进组|cff00FF00(注意人数限制功能依然生效，到达人数后将自动停止邀请)|r。";
	invite.INV_wuxianzhiyaoqing:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["RaidRecord"]["Invite"]["wutiaojianjINV"]="ON";
		else
			PIG["RaidRecord"]["Invite"]["wutiaojianjINV"]="OFF";
		end
	end);
	---开团喊话
	invite.kaituanName = invite:CreateFontString();
	invite.kaituanName:SetPoint("TOPLEFT",invite,"TOPLEFT",16,-xiafangjudingH-36);
	invite.kaituanName:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	invite.kaituanName:SetText("\124cff00FF00喊话:\124r");
	invite.kaituanNameFFF = CreateFrame("Frame", nil, invite,"BackdropTemplate");
	invite.kaituanNameFFF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 16,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	invite.kaituanNameFFF:SetSize(540,zhiye_Height+8);
	invite.kaituanNameFFF:SetPoint("LEFT", invite.kaituanName, "RIGHT", 0,-1);
	invite.kaituanhanhua_E = CreateFrame('EditBox', nil, invite.kaituanNameFFF,"BackdropTemplate");
	invite.kaituanhanhua_E:SetSize(zhiye_Height*20,zhiye_Height);
	invite.kaituanhanhua_E:SetPoint("TOPLEFT", invite.kaituanNameFFF, "TOPLEFT", 6,-2);
	invite.kaituanhanhua_E:SetPoint("BOTTOMRIGHT", invite.kaituanNameFFF, "BOTTOMRIGHT", -6,2);
	invite.kaituanhanhua_E:SetFontObject(ChatFontNormal);
	invite.kaituanhanhua_E:SetMaxLetters(40)
	invite.kaituanhanhua_E:SetAutoFocus(false);
	invite.kaituanhanhua_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
	end);
	invite.kaituanhanhua_E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	---==============================================================================================
	local pindaolist ={{"YELL","GUILD"},{"综合","寻求组队","大脚世界频道"}};
	local pindaolist1 ={{"大喊","公会"},{"综合","寻求组队","大脚世界频道"}};
	--喊话频道
	invite.hanhuaxuanzexiala = CreateFrame("FRAME", nil, invite, "UIDropDownMenuTemplate")
	invite.hanhuaxuanzexiala:SetPoint("LEFT",invite.kaituanNameFFF,"RIGHT",-16,-1.6)
	UIDropDownMenu_SetWidth(invite.hanhuaxuanzexiala, 58)
	UIDropDownMenu_SetText(invite.hanhuaxuanzexiala, "频道")--默认
	local function hanhuaxuanzexiala_Up()
		local info = UIDropDownMenu_CreateInfo()
		info.func = invite.hanhuaxuanzexiala.SetValue
		local pindaomuluheji={}
		local pindaomuluheji_YN={}
		for i=1,#pindaolist1 do
			for ii=1,#pindaolist1[i] do
				table.insert(pindaomuluheji,pindaolist1[i][ii]);
				table.insert(pindaomuluheji_YN,PIG["RaidRecord"]["Invite"]["hanhuapindao"][i][ii]);	
			end
		end
		for i=1,#pindaomuluheji,1 do
		    info.text, info.arg1 = pindaomuluheji[i], pindaomuluheji[i];
		    info.checked=pindaomuluheji_YN[i]
		    info.isNotRadio = true;
			UIDropDownMenu_AddButton(info)
		end 
	end
	--喊话宏
	local function NEWhanhuahong()
		local yijiarupindaolist ={};
		local channel1 = {GetChannelList()};
		for i=1,#channel1 do
			for ii=1,#pindaolist[2] do
				if PIG["RaidRecord"]["Invite"]["hanhuapindao"][2][ii] ==true then
					if channel1[i]==pindaolist[2][ii] then
						table.insert(yijiarupindaolist,channel1[i-1]);
					end
				end
			end
		end
		for s=1,#pindaolist[1] do
			if PIG["RaidRecord"]["Invite"]["hanhuapindao"][1][s] ==true then
				table.insert(yijiarupindaolist,pindaolist[1][s]);
			end
		end
		local macroSlot = GetMacroIndexByName("!Pig")
		local hanhuaneirong="";
		hanhuaneirong=hanhuaneirong..invite.kaituanhanhua_E:GetText();
		if zhilingV~="" and zhilingV~=" " then
			hanhuaneirong=hanhuaneirong..",密"..zhilingV.."进组";
		end
		local hanhuaneirong1="";
		for i=1,#yijiarupindaolist do
			hanhuaneirong1=hanhuaneirong1.."/"..yijiarupindaolist[i].." "..hanhuaneirong.."\r"
		end
		if macroSlot==0 then
			CreateMacro("!Pig", 133742, hanhuaneirong1, nil)
		else
			EditMacro(macroSlot, nil, nil, hanhuaneirong1)
		end
	end
	--
	invite.kaituanhanhua_E:SetScript("OnEditFocusLost", function(self)
		PIG["RaidRecord"]["Invite"]["kaituanName"]=self:GetText();
		local macroSlot = GetMacroIndexByName("!Pig")
		if macroSlot>0 then
			NEWhanhuahong()
		end
	end);
	function invite.hanhuaxuanzexiala:SetValue(pindaoNameVVV)
		for x=1,#pindaolist1 do
			for xx=1,#pindaolist1[x] do
				if pindaoNameVVV==pindaolist1[x][xx] then
					if PIG["RaidRecord"]["Invite"]["hanhuapindao"][x][xx]==true then
						PIG["RaidRecord"]["Invite"]["hanhuapindao"][x][xx]=false
					elseif PIG["RaidRecord"]["Invite"]["hanhuapindao"][x][xx]==false then
						PIG["RaidRecord"]["Invite"]["hanhuapindao"][x][xx]=true
					end
				end
			end
		end
		local macroSlot = GetMacroIndexByName("!Pig")
		if macroSlot>0 then
			NEWhanhuahong()
		end
		CloseDropDownMenus();
	end
	----
	invite.New_hong = CreateFrame("Button",nil,invite, "UIPanelButtonTemplate");  
	invite.New_hong:SetSize(100,24);
	invite.New_hong:SetPoint("LEFT",invite.hanhuaxuanzexiala,"RIGHT",-5,2);
	invite.New_hong:SetText('创建喊话宏');
	invite.New_hong:SetScript("OnClick", function ()
		local macroSlot = GetMacroIndexByName("!Pig")
		if macroSlot>0 then
			StaticPopup_Show ("CHUANGJIANHONGPIG");
		else
			local global, perChar = GetNumMacros()
			if global<120 then
				StaticPopup_Show ("CHUANGJIANHONGPIG");
			else
				print("|cff00FFFF!Pig:|r|cffFFFF00你的宏数量已达最大值120，请删除一些再尝试。|r");
			end
		end
	end)
	StaticPopupDialogs["CHUANGJIANHONGPIG"] = {
		text = "将创建一个喊话宏，请拖拽到动作条使用\n\n确定创建吗？\n\n",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			NEWhanhuahong()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}

	--=============================================================================================
	--主屏幕眼睛提示
	invite.zuduizhuangtaitishi = CreateFrame("Button",nil,UIParent);
	invite.zuduizhuangtaitishi:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight");  
	invite.zuduizhuangtaitishi:SetSize(80,80);
	invite.zuduizhuangtaitishi:SetPoint("TOP",UIParent,"TOP",0,-100);
	invite.zuduizhuangtaitishi:SetMovable(true)
	invite.zuduizhuangtaitishi:EnableMouse(true)
	invite.zuduizhuangtaitishi:SetClampedToScreen(true)
	invite.zuduizhuangtaitishi:RegisterForDrag("LeftButton")
	invite.zuduizhuangtaitishi:RegisterForClicks("LeftButtonUp","RightButtonUp")
	invite.zuduizhuangtaitishi:Hide()
	invite.zuduizhuangtaitishi:SetScript("OnDragStart",function(self)
		self:StartMoving()
	end)
	invite.zuduizhuangtaitishi:SetScript("OnDragStop",function(self)
		self:StopMovingOrSizing()
	end)
	local zhuangdongkaishixulie={0,1,2,3,4,3,2,1,0,9,10,11,12,13,14,15,15,17,18,19,20,21,22,23,24,25,26,21,20,27,28};
	for i=1,#zhuangdongkaishixulie do
		invite.zuduizhuangtaitishi_Tex = invite.zuduizhuangtaitishi:CreateTexture("invite_zuduitishi_Tex_"..zhuangdongkaishixulie[i], "BORDER");
		invite.zuduizhuangtaitishi_Tex:SetTexture("interface/lfgframe/battlenetworking"..zhuangdongkaishixulie[i]..".blp");
		invite.zuduizhuangtaitishi_Tex:SetAllPoints(invite.zuduizhuangtaitishi)
		invite.zuduizhuangtaitishi_Tex:Hide()
	end
	invite.zuduizhuangtaitishi:SetScript("OnClick", function ()
		RsettingF_UI:Hide();
		History_UI:Hide();
		fenG_UI:Hide();
		RaidR_UI:Show();
		invite.zuduizhuangtaitishi:Hide()
	end)
	local zhuangdongkaishiID=1;
	local function yanjingzhuandongkaishi()
		if addonTable.RaidRecord_Invite_yaoqing==true or addonTable.RaidRecord_Invite_hanhua==true then
			if RaidR_UI:IsShown() then
				invite.zuduizhuangtaitishi:Hide()
			else
				invite.zuduizhuangtaitishi:Show()
				for i=1,#zhuangdongkaishixulie do
					_G["invite_zuduitishi_Tex_"..zhuangdongkaishixulie[i]]:Hide()
				end
				_G["invite_zuduitishi_Tex_"..zhuangdongkaishixulie[zhuangdongkaishiID]]:Show();
			end
			zhuangdongkaishiID=zhuangdongkaishiID+1;
			if zhuangdongkaishiID==#zhuangdongkaishixulie then zhuangdongkaishiID=1 end
			C_Timer.After(0.2,yanjingzhuandongkaishi)
		else
			invite.zuduizhuangtaitishi:Hide()
		end
	end
	---组队助手按钮闪动
	local shandongbianhaoID=0;
	local function zuduizhushoushandong()
		if addonTable.RaidRecord_Invite_yaoqing==true or addonTable.RaidRecord_Invite_hanhua==true then
			if shandongbianhaoID==0 then
				shandongbianhaoID=1
			else
				shandongbianhaoID=0
			end
			if invite_UI:IsShown() then
				zudui_but_UI.tex:Hide()
			else
				if shandongbianhaoID==0 then
					zudui_but_UI.tex:Hide()
				elseif shandongbianhaoID==1 then
					zudui_but_UI.tex:Show()
				end
			end
			C_Timer.After(0.5,zuduizhushoushandong)
		else
			zudui_but_UI.tex:Hide()
		end
	end

	---自动邀请
	addonTable.RaidRecord_Invite_yaoqing=false;
	local lishiwanjiaxinxi={};
	local autoZuduiKaiqi_tex=0;
	local function zidongyaoqingFun()
		if IsInGroup() then
			local isLeader = UnitIsGroupLeader("player", "LE_PARTY_CATEGORY_HOME");
			local isTrue = UnitIsGroupAssistant("player", "LE_PARTY_CATEGORY_HOME");
			if isLeader~=true and isTrue~=true  then
				invite.zidongyaoqingBUT.Tex:SetTexture("interface/common/indicator-gray.blp");
				addonTable.RaidRecord_Invite_yaoqing=false;
				zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_WHISPER");
				zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_SYSTEM");
				print("|cff00FFFF!Pig:|r|cffFFFF00自动邀请已关闭，你必须是队长/团长/助理！|r");
			end
		end
		local yizuzongrenshuXxx=tonumber(invite.yizuzongrenshuX_V:GetText());
		local mubiaozongrenshuXxx=tonumber(invite.mubiaozongrenshuX_V:GetText());
		if yizuzongrenshuXxx>=mubiaozongrenshuXxx then
			invite.zidongyaoqingBUT.Tex:SetTexture("interface/common/indicator-gray.blp");
			addonTable.RaidRecord_Invite_yaoqing=false;
			zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_WHISPER");
			zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_SYSTEM");
			print("|cff00FFFF!Pig:|r|cffFFFF00已达目标人数，自动邀请已关闭。|r");
		end
		if addonTable.RaidRecord_Invite_yaoqing==true then
			if invite_UI:IsShown() then
				if autoZuduiKaiqi_tex==0 then
					invite.zidongyaoqingBUT.Tex:SetTexture("interface/common/indicator-green.blp");
					autoZuduiKaiqi_tex=1
				else
					invite.zidongyaoqingBUT.Tex:SetTexture("interface/common/indicator-gray.blp");
					autoZuduiKaiqi_tex=0
				end
			end
			C_Timer.After(0.5,zidongyaoqingFun)
		else
			invite.zidongyaoqingBUT.Tex:SetTexture("interface/common/indicator-gray.blp");
			addonTable.RaidRecord_Invite_yaoqing=false;
			zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_WHISPER");
			zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_SYSTEM");
		end
	end

	--自动喊话====================
	--过滤频道发言过频提示
	local function guolvliaotiancuowuINFO(self,event,arg1,...)
		if arg1=="THROTTLED" then
			return true;
		else
	    	return false, arg1, ...
		end
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE",guolvliaotiancuowuINFO)
	addonTable.RaidRecord_Invite_hanhua=false;
	local hanhuaxuliebianhaoID=0;
	local function zidonghanhuaFun()
		if IsInGroup() then
			local isLeader = UnitIsGroupLeader("player", "LE_PARTY_CATEGORY_HOME");
			local isTrue = UnitIsGroupAssistant("player", "LE_PARTY_CATEGORY_HOME");
			if isLeader~=true and isTrue~=true  then
				addonTable.RaidRecord_Invite_hanhua=false;
				print("|cff00FFFF!Pig:|r|cffFFFF00自动喊话已停止，你必须是队长/团长/助理！|r");
			end
		end
		if tonumber(invite.yizuzongrenshuX_V:GetText())>=tonumber(invite.mubiaozongrenshuX_V:GetText()) then
			addonTable.RaidRecord_Invite_hanhua=false;
			print("|cff00FFFF!Pig:|r|cffFFFF00已达目标人数，自动喊话已停止。|r");
		end
		if addonTable.RaidRecord_Invite_hanhua==true then
			if invite_UI:IsShown() then
				if hanhuaxuliebianhaoID==0 then
					invite.hanhuakaishi.Tex:SetTexture("interface/common/indicator-green.blp");
					hanhuaxuliebianhaoID=1
				else
					invite.hanhuakaishi.Tex:SetTexture("interface/common/indicator-gray.blp");
					hanhuaxuliebianhaoID=0
				end
			end
			C_Timer.After(0.5,zidonghanhuaFun)
		else
			invite.hanhuakaishi.Tex:SetTexture("interface/common/indicator-gray.blp");
			addonTable.RaidRecord_Invite_hanhua=false;
		end
	end
	local function zidonghanhuahanshu()
		local hanhuaneirong="";
		hanhuaneirong=hanhuaneirong..invite.kaituanhanhua_E:GetText();
		local zhilingV = invite.jinzuzhiling_E:GetText()
		if zhilingV~="" and zhilingV~=" " then
			hanhuaneirong=hanhuaneirong..",密"..zhilingV.."进组";
		end
		--公共
		local yijiarupindaolist ={};
		local channel1 = {GetChannelList()};
		for i=1,#channel1 do
			for ii=1,#pindaolist[2] do
				if PIG["RaidRecord"]["Invite"]["hanhuapindao"][2][ii] ==true then
					if channel1[i]==pindaolist[2][ii] then
						table.insert(yijiarupindaolist,channel1[i-1]);
					end
				end
			end
		end
		for i=1,#yijiarupindaolist do
			SendChatMessage(hanhuaneirong,"CHANNEL",nil,yijiarupindaolist[i])
		end
	end
	local function zidonghanhuahanshu_Open()
		if addonTable.RaidRecord_Invite_hanhua==true then
			if tonumber(invite.yizuzongrenshuX_V:GetText())<tonumber(invite.mubiaozongrenshuX_V:GetText()) then
				C_Timer.After(0.1,zidonghanhuahanshu)
				C_Timer.After(0.2,zidonghanhuahanshu)
				C_Timer.After(0.3,zidonghanhuahanshu)
				C_Timer.After(0.4,zidonghanhuahanshu)
				C_Timer.After(0.5,zidonghanhuahanshu)
				C_Timer.After(0.6,zidonghanhuahanshu)
				C_Timer.After(0.7,zidonghanhuahanshu)
				C_Timer.After(0.8,zidonghanhuahanshu)
				C_Timer.After(0.9,zidonghanhuahanshu)
				C_Timer.After(1.0,zidonghanhuahanshu)
				C_Timer.After(1.1,zidonghanhuahanshu)
				for s=1,#pindaolist[1] do
					if PIG["RaidRecord"]["Invite"]["hanhuapindao"][1][s] ==true then
						if pindaolist[1][s]=="GUILD" then
							local hanhuaneirong="";
							hanhuaneirong=hanhuaneirong..invite.kaituanhanhua_E:GetText();
							local zhilingV = invite.jinzuzhiling_E:GetText()
							if zhilingV and zhilingV then
								hanhuaneirong=hanhuaneirong..",密"..zhilingV.."进组";
							end
							SendChatMessage(hanhuaneirong,pindaolist[1][s],nil)
							break
						end
					end
				end
				C_Timer.After(PIG["RaidRecord"]["Invite"]["shijianjiange"],zidonghanhuahanshu_Open) 
			end
		end
	end
	----自动邀请
	invite.zidongyaoqingBUT = CreateFrame("Button",nil,invite, "UIPanelButtonTemplate");  
	invite.zidongyaoqingBUT:SetSize(100,28);
	invite.zidongyaoqingBUT:SetPoint("LEFT",invite.INV_wuxianzhiyaoqing.Text,"RIGHT",6,-0);
	invite.zidongyaoqingBUT.Text:SetPoint("CENTER",invite.zidongyaoqingBUT,"CENTER",10,0);
	invite.zidongyaoqingBUT_Font=invite.zidongyaoqingBUT:GetFontString()
	invite.zidongyaoqingBUT_Font:SetFont(ChatFontNormal:GetFont(), 13);
	invite.zidongyaoqingBUT_Font:SetTextColor(0, 1, 1, 1);
	invite.zidongyaoqingBUT:SetText('自动邀请');
	invite.zidongyaoqingBUT.Tex = invite.zidongyaoqingBUT:CreateTexture(nil, "BORDER");
	invite.zidongyaoqingBUT.Tex:SetTexture("interface/common/indicator-gray.blp");
	invite.zidongyaoqingBUT.Tex:SetPoint("RIGHT",invite.zidongyaoqingBUT.Text,"LEFT",0,-2);
	invite.zidongyaoqingBUT.Tex:SetSize(23,23);
	invite.zidongyaoqingBUT:SetScript("OnClick", function (self)
		if PIG_Per["FarmRecord"]["Kaiqi"]=="ON" and PIG_Per["FarmRecord"]["autohuifu"]=="ON" then
			print("|cff00FFFF!Pig:|r|cffFFFF00带本助手自动回复处于开启状态，请先关闭带本助手的自动回复。|r");
		else
			if addonTable.RaidRecord_Invite_yaoqing==true then
				addonTable.RaidRecord_Invite_yaoqing=false
				zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_WHISPER");
				zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_SYSTEM")
			elseif addonTable.RaidRecord_Invite_yaoqing==false then
				addonTable.RaidRecord_Invite_yaoqing=true
				zidongyaoqingFun()
				if addonTable.RaidRecord_Invite_hanhua==false then
					zuduizhushoushandong()
					yanjingzhuandongkaishi()
				end
				zuduizhushouXXX_UI:RegisterEvent("CHAT_MSG_WHISPER");
				zuduizhushouXXX_UI:RegisterEvent("CHAT_MSG_SYSTEM")
			end
		end
	end)

	---间隔
	invite.hanhuajiange = invite:CreateFontString();
	invite.hanhuajiange:SetPoint("LEFT",invite.zidongyaoqingBUT,"RIGHT",6,0);
	invite.hanhuajiange:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	invite.hanhuajiange:SetText("\124cff00FF00间隔/S：\124r");
	invite.hanhuajiange:Hide()
	invite.hanhuajiange_E = CreateFrame('EditBox', nil, invite,"BackdropTemplate");
	invite.hanhuajiange_E:SetSize(zhiye_Height*1.8,zhiye_Height+14);
	invite.hanhuajiange_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -6,right = 2,top = 4,bottom = -10}})
	invite.hanhuajiange_E:SetPoint("LEFT", invite.hanhuajiange, "RIGHT", 4,-0);
	invite.hanhuajiange_E:SetFontObject(ChatFontNormal);
	invite.hanhuajiange_E:SetMaxLetters(4)
	invite.hanhuajiange_E:SetAutoFocus(false);
	invite.hanhuajiange_E:SetNumeric()
	invite.hanhuajiange_E:Hide()
	invite.hanhuajiange_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
	end);
	invite.hanhuajiange_E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	invite.hanhuajiange_E:SetScript("OnEditFocusLost", function(self)
		if self:GetNumber()<300 then
			self:SetText(300)
			PIG["RaidRecord"]["Invite"]["shijianjiange"]=self:GetNumber();
			print("|cff00FFFF!Pig:|r|cffFFFF00不能小于300秒。|r");
		else
			PIG["RaidRecord"]["Invite"]["shijianjiange"]=self:GetNumber();
		end
	end);
	---
	invite.hanhuakaishi = CreateFrame("Button",nil,invite, "UIPanelButtonTemplate");  
	invite.hanhuakaishi:SetSize(100,28);
	invite.hanhuakaishi:SetPoint("LEFT",invite.hanhuajiange_E,"RIGHT",0,0);
	invite.hanhuakaishi.Text:SetPoint("CENTER",invite.hanhuakaishi,"CENTER",10,0);
	invite.hanhuakaishi_Font=invite.hanhuakaishi:GetFontString()
	invite.hanhuakaishi_Font:SetFont(ChatFontNormal:GetFont(), 13);
	invite.hanhuakaishi_Font:SetTextColor(0, 1, 1, 1);
	invite.hanhuakaishi:SetText('自动喊话');
	invite.hanhuakaishi:Hide();
	invite.hanhuakaishi.Tex = invite.hanhuakaishi:CreateTexture(nil, "BORDER");
	invite.hanhuakaishi.Tex:SetTexture("interface/common/indicator-gray.blp");
	invite.hanhuakaishi.Tex:SetPoint("RIGHT",invite.hanhuakaishi.Text,"LEFT",0,-2);
	invite.hanhuakaishi.Tex:SetSize(23,23);
	invite.hanhuakaishi:SetScript("OnClick", function ()
		if addonTable.RaidRecord_Invite_hanhua==true then
			addonTable.RaidRecord_Invite_hanhua=false
		elseif addonTable.RaidRecord_Invite_hanhua==false then
			addonTable.RaidRecord_Invite_hanhua=true
			zidonghanhuaFun()
			zidonghanhuahanshu_Open()
			if addonTable.RaidRecord_Invite_yaoqing==false then
				zuduizhushoushandong()
				yanjingzhuandongkaishi()
			end
		end
	end)

	--===================================
	local zhiyeweizhiNameQ={"坦克","治疗","输出"}
	local zhiyeweizhiNameQQ={{"坦克","熊D","熊T","T","MT","坦","战士T","防骑","FQ"},{"治疗","奶","大奶"},{"输出","狂暴战","KBZ", "kbz", "狂暴", "DPS", "dps","惩戒"}}
	local zuduizhushouXXX = CreateFrame("Frame","zuduizhushouXXX_UI");
	zuduizhushouXXX:RegisterEvent("GROUP_ROSTER_UPDATE")
	zuduizhushouXXX:HookScript("OnEvent",function(self, event,arg1,_,_,_,arg5,_,_,_,_,_,_,arg12)
		if PIG["RaidRecord"]["Kaiqi"]=="ON" then
			if PIG["RaidRecord"]["Dongjie"]=="OFF" then
				if event=="GROUP_ROSTER_UPDATE" then
					C_Timer.After(1,UpdatePlayersINFO)
				end
			end
		end
		if addonTable.RaidRecord_Invite_yaoqing==true then
			if event=="CHAT_MSG_SYSTEM" then
				local yijingyouduiwu_fuben=arg1:find("已经加入了别的队伍", 1)
				if yijingyouduiwu_fuben then
					local _, _, _, wanjianameXXk = arg1:find("((.+)已经加入了别的队伍)");
					SendChatMessage("[!Pig] 你已有队伍，请退组后再M", "WHISPER", nil, wanjianameXXk);
				end
			end
			if event=="CHAT_MSG_WHISPER" then
				-- for i=1,#lishiwanjiaxinxi do
				-- 	if (GetServerTime()-lishiwanjiaxinxi[i][1])>60 then
				-- 		table.remove(lishiwanjiaxinxi, i);
				-- 	end
				-- end
				local feizidonghuifu=arg1:find("[!Pig]", 1)
				if feizidonghuifu then return end
				local localizedClass, englishClass= GetPlayerInfoByGUID(arg12)

				local function chunshuchuzhiyeyaoqing()
						local zhiyeweizhiID={0,0,0}
						zhiyeweizhiID.all=0
						for i=1,#invite.classes_Name do
							for ii=1,#invite.classes_Name[i] do
								if englishClass==invite.classes_Name[i][ii] then
									zhiyeweizhiID[i]=ii
									zhiyeweizhiID.all=zhiyeweizhiID.all+1
								end
							end
						end

						if zhiyeweizhiID.all==1 then
							for i=1,#invite.TND do
								if zhiyeweizhiID[i]>0 then
									if _G[invite.TND[i].."_mubiao_E_"..zhiyeweizhiID[i]]:GetNumber()>tonumber(_G[invite.TND[i].."_yizu_"..zhiyeweizhiID[i]]:GetText()) then
										local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
										if numGroupMembers==5 then
											ConvertToRaid() 
										end
										InviteUnit(arg5)
									else
										SendChatMessage("[!Pig] "..localizedClass .. "已满，可换其他职业，感谢支持", "WHISPER", nil, arg5);
									end
								end
							end
						elseif zhiyeweizhiID.all>1 then
							local zuduizhushou_MSG=localizedClass.."尚缺:";
							local chazhiyefenlai={};
							for i=1,#invite.TND do
								if zhiyeweizhiID[i]>0 then
									if _G[invite.TND[i].."_mubiao_E_"..zhiyeweizhiID[i]]:GetNumber()>tonumber(_G[invite.TND[i].."_yizu_"..zhiyeweizhiID[i]]:GetText()) then
										zuduizhushou_MSG=zuduizhushou_MSG..zhiyeweizhiNameQ[i]..",";
										table.insert(chazhiyefenlai,i)
									end
								end
							end
							if #chazhiyefenlai>0 then
								SendChatMessage("[!Pig] "..zuduizhushou_MSG.."请回复职责", "WHISPER", nil, arg5);
								for i=1,#lishiwanjiaxinxi do
									if lishiwanjiaxinxi[i][2]==arg5 then return end
								end
								table.insert(lishiwanjiaxinxi,{GetServerTime(),arg5,chazhiyefenlai})
							else
								SendChatMessage("[!Pig] "..localizedClass.."已满，可换其他职业，感谢支持", "WHISPER", nil, arg5);
							end
						end	
				end

				local function hunhezhiyezhizehuifu()
					for i=1,#lishiwanjiaxinxi do
						if arg5 == lishiwanjiaxinxi[i][2] then
							for x=1,#lishiwanjiaxinxi[i][3] do
								for xx=1,#zhiyeweizhiNameQQ[lishiwanjiaxinxi[i][3][x]] do
									local zuduizhushouzhizeYES=arg1:find(zhiyeweizhiNameQQ[lishiwanjiaxinxi[i][3][x]][xx], 1)
									if zuduizhushouzhizeYES then
										for k=1,#invite.classes_Name do
											for kk=1,#invite.classes_Name[k] do
												if englishClass==invite.classes_Name[k][kk] then
													if lishiwanjiaxinxi[i][3][x]==k then
														if _G[invite.TND[k].."_mubiao_E_"..kk]:GetNumber()>tonumber(_G[invite.TND[k].."_yizu_"..kk]:GetText()) then
															local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
															if numGroupMembers==5 and not IsInRaid("LE_PARTY_CATEGORY_HOME") then
																ConvertToRaid() 
															end
															InviteUnit(arg5)
														else
															SendChatMessage("[!Pig] "..zhiyeweizhiNameQ[k]..localizedClass .. "已满，可换其他职业/天赋，感谢支持", "WHISPER", nil, arg5);
														end
													end
												end
											end
										end
										table.remove(lishiwanjiaxinxi, i);
										return
									end
								end
							end
							SendChatMessage("[!Pig] 职责不符，本次会话结束，进组需重新回复进组指令", "WHISPER", nil, arg5);
							table.remove(lishiwanjiaxinxi,i);
							break
						end
					end
				end
				--执行邀请
				local cunzaiguanjianzi=arg1:find(PIG["RaidRecord"]["Invite"]["jinzuZhiling"], 1)
				if cunzaiguanjianzi then
					if PIG["RaidRecord"]["Invite"]["wutiaojianjINV"]=="ON" then
						local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
						if numGroupMembers==5 and not IsInRaid("LE_PARTY_CATEGORY_HOME") then
							ConvertToRaid() 
						end
						InviteUnit(arg5)
					else
						chunshuchuzhiyeyaoqing()
					end
				else
					hunhezhiyezhizehuifu()
				end
			end
		end
	end)

	--==========================================
	invite:SetScript("OnShow", function ()
		if PIG["RaidRecord"]["Invite"]["jihuo"] then
			if PIG["RaidRecord"]["Invite"]["jihuo"][1]==true and PIG["RaidRecord"]["Invite"]["jihuo"][2]==true and PIG["RaidRecord"]["Invite"]["jihuo"][4]==true and PIG["RaidRecord"]["Invite"]["jihuo"][3]==true then		
				invite.hanhuajiange:Show()
				invite.hanhuajiange_E:Show()
				invite.hanhuakaishi:Show()
			else
				invite.hanhuajiange:Hide()
				invite.hanhuajiange_E:Hide()
				invite.hanhuakaishi:Hide()
			end
		end
		if PIG["RaidRecord"]["Invite"]["wutiaojianjINV"]=="ON" then
			invite.INV_wuxianzhiyaoqing:SetChecked(true);
		end
		invite.kaituanhanhua_E:SetText(PIG["RaidRecord"]["Invite"]["kaituanName"]);
		invite.jinzuzhiling_E:SetText(PIG["RaidRecord"]["Invite"]["jinzuZhiling"]);
		invite.hanhuajiange_E:SetText(PIG["RaidRecord"]["Invite"]["shijianjiange"]);
		UpdatePlayersINFO();
	end)
	------
	RaidR_UI.xiafangF.zudui:SetScript("OnClick", function (self)
		RsettingF_UI:Hide();
		History_UI:Hide();
		fenG_UI:Hide();
		if invite:IsShown() then
			invite:Hide();
		else
			invite:Show();
		end
	end);

	--==========================================
	local _, _, _, tocversion = GetBuildInfo()
	if PIG["RaidRecord"]["Kaiqi"]=="ON" then
		invite.clName={}
		if tocversion>69999 then
			invite.clName={
				{"WARRIOR","PALADIN","DRUID","DEATHKNIGHT","MONK","DEMONHUNTER"},
				{"PRIEST","DRUID","PALADIN","SHAMAN","MONK"},
				{"WARRIOR","HUNTER","ROGUE","MAGE","WARLOCK","PRIEST","DRUID","PALADIN","SHAMAN","DEATHKNIGHT","MONK","DEMONHUNTER"}
			}
		elseif tocversion>29999 then
			invite.clName={
				{"WARRIOR","PALADIN","DRUID","DEATHKNIGHT"},
				{"PRIEST","DRUID","PALADIN","SHAMAN"},
				{"WARRIOR","HUNTER","ROGUE","MAGE","WARLOCK","PRIEST","DRUID","PALADIN","SHAMAN","DEATHKNIGHT"},
			}
		elseif tocversion>19999 then
			invite.clName={
				{"WARRIOR","PALADIN","DRUID"},
				{"PRIEST","DRUID","PALADIN","SHAMAN"},
				{"WARRIOR","HUNTER","ROGUE","MAGE","WARLOCK","PRIEST","DRUID","PALADIN","SHAMAN"}
			}
		else
			local englishFaction, _ = UnitFactionGroup("player")
			if englishFaction=="Alliance" then
				invite.clName={
					{"WARRIOR","DRUID","PALADIN"},
					{"PRIEST","DRUID","PALADIN"},
					{"WARRIOR","HUNTER","ROGUE","MAGE","WARLOCK","PRIEST","DRUID","PALADIN"}
				}
			elseif englishFaction=="Horde" then
				invite.clName={
					{"WARRIOR","DRUID"},
					{"PRIEST","DRUID","SHAMAN"},
					{"WARRIOR","HUNTER","ROGUE","MAGE","WARLOCK","PRIEST","DRUID","SHAMAN"}
				}
			end
		end
		for i=1,#invite.classes_Name do
			invite.classes_Name[i]=invite.clName[i]
		end
		chuangjianFrame()
		UIDropDownMenu_SetText(invite.renyuannpeizhiinfo_D, PIG["RaidRecord"]["Invite"]["dangqianpeizhi"])--默认
		UIDropDownMenu_Initialize(invite.renyuannpeizhiinfo_D, renyuannpeizhiinfo_Up)--初始化
		UIDropDownMenu_Initialize(invite.hanhuaxuanzexiala, hanhuaxuanzexiala_Up)--初始化
	end
end
addonTable.ADD_Invite = ADD_Invite;