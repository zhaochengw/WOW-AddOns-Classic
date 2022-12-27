local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local sub = _G.string.sub
local trremove = _G.tremove
local strsplit = strsplit
local fuFrame=List_R_F_2_11
local _, _, _, tocversion = GetBuildInfo()
--===============================
local ADD_Frame=addonTable.ADD_Frame
local Create = addonTable.Create
local PIGModbutton=Create.PIGModbutton
local Create=addonTable.Create
local PIGDownMenu=Create.PIGDownMenu
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local GnName,GnUI = "带本助手","daiben_UI";
local FrameLevel=1
local Options_Daibenzhushou = PIGModbutton(GnName,GnUI,FrameLevel,6)
---------------------------------------
local Width,DHeight,biaotiH=350,28,26;
local JZ_Height,TIME_Height=164,140;
local WowWidth=(GetScreenWidth()-Width)/2;
local WowHeight=GetScreenHeight()/2;
----------
local daibenData = {}
daibenData.Width,daibenData.DHeight,daibenData.biaotiH=Width,DHeight,biaotiH
daibenData.WowWidth=WowWidth
daibenData.WowHeight=WowHeight
addonTable.daibenData=daibenData
local jisuandanjia=addonTable.jisuandanjia--计算单价
local huoquduiwLV=addonTable.huoquduiwLV
local huoquLVdanjia=addonTable.huoquLVdanjia
--===================================
local function ADD_daibenUI()
	if _G[GnUI] then return end
	local Open_settingUI=addonTable.Open_settingUI--设置

	local daiben = CreateFrame("Frame", GnUI, UIParent,"BackdropTemplate");
	daiben:SetBackdrop({ edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 6});
	daiben:SetBackdropBorderColor(0, 1, 1, 0.4);
	daiben:SetSize(Width,DHeight);
	daiben:SetPoint(PIG.daiben.Point[1],UIParent,PIG.daiben.Point[2],PIG.daiben.Point[3],PIG.daiben.Point[4]);
	daiben:SetMovable(true)
	daiben:SetClampedToScreen(true)
	daiben:EnableMouse(true);
	if not PIG.daiben.Show then
		daiben:Hide();
	end
	daiben:SetScript("OnShow", function()
		PIG.daiben.Show=true 
	end);
	daiben:SetScript("OnHide", function()
		PIG.daiben.Show=false 
	end);
	--启动状态
	local guanbiicon,kaqiicon = "interface/common/indicator-red.blp","interface/common/indicator-green.blp"
	daiben.yesno = CreateFrame("CheckButton",nil,daiben);  
	daiben.yesno:SetSize(biaotiH,biaotiH);
	daiben.yesno:SetPoint("LEFT", daiben, "LEFT", 0, 0);
	daiben.yesno.Tex = daiben.yesno:CreateTexture(nil, "BORDER");
	daiben.yesno.Tex:SetTexture(guanbiicon);
	daiben.yesno.Tex:SetPoint("CENTER",daiben.yesno,"CENTER",0,-1.4);
	daiben.yesno.Tex:SetSize(biaotiH,biaotiH);
	if PIG_Per.daiben.autohuifu then
		daiben.yesno:SetChecked(true);
		daiben.yesno.Tex:SetTexture(kaqiicon);
	end
	daiben.yesno:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.2,-2.2);
		GameTooltip:Hide() 
	end);
	daiben.yesno:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER",0,-1.6);
	end);
	---
	local function Open_YES()
		GameTooltip:AddLine("工作状态：|cff00ff00营业中|r")
		GameTooltip:AddLine("|cffff0000点击关闭自动回复/自动邀请\n"..
			"并取消车辆登记|r")
		GameTooltip:AddLine("|cff00ffff按住拖拽可移动位置|r")
	end
	local function Off_NO()
		GameTooltip:AddLine("工作状态：|cffff0000休息中|r")
		GameTooltip:AddLine("|cff00ff00点击启用自动回复/自动邀请\n"..
			"并登记车辆到车队（在时空之门功能查看车队）|r")
		GameTooltip:AddLine("|cff00ffff按住拖拽可移动位置|r")
	end
	daiben.yesno:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT",0,0);
		if self:GetChecked() then
			Open_YES()
		else
			Off_NO()
		end
		GameTooltip:Show();
	end);
	daiben.yesno:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide()
	end);
	daiben.yesno:SetScript("OnClick", function (self)
		if PIG_Per.daiben.fubenName=="无" then
			print("|cff00FFFF!Pig:|r|cffFFFF00请先选择所带副本。|r");
			self:SetChecked(false)
			Open_settingUI()
			return 
		end
		if self:GetChecked() then
			if addonTable.RaidRecord_Invite_yaoqing==true then
				print("|cff00FFFF!Pig:|r|cffFFFF00开团助手自动回复邀请处于开启状态，请先开团助手的自动邀请。|r");
				self:SetChecked(false)
			else
				PIG_Per.daiben.autohuifu=true
				addonTable.daiben_Invite_yaoqing=true
				self.Tex:SetTexture(kaqiicon);
			end
		else
			PIG_Per.daiben.autohuifu=false
			addonTable.daiben_Invite_yaoqing=false
			self.Tex:SetTexture(guanbiicon);
		end
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		if self:GetChecked() then
			Open_YES()
		else
			Off_NO()
		end
		GameTooltip:Show() 
	end);
	daiben.yesno:RegisterForDrag("LeftButton")
	daiben.yesno:SetScript("OnDragStart",function()
		daiben:StartMoving()
	end)
	daiben.yesno:SetScript("OnDragStop",function()
		daiben:StopMovingOrSizing()
		daiben:SetUserPlaced(false)
		local point, relativeTo, relativePoint, xOfs, yOfs = daiben:GetPoint()
		PIG.daiben.Point={point, relativePoint, xOfs, yOfs};
	end)

	--喊话
	daiben.hanhuajiange =10;
	daiben.hanhuadaojishi =0;
	----
	daiben.hanren = CreateFrame("Button",nil,daiben, "UIPanelButtonTemplate");  
	daiben.hanren:SetSize(80,biaotiH-2);
	daiben.hanren:SetPoint("LEFT",daiben.yesno,"RIGHT",8,0);
	daiben.hanren:SetText("喊话");
	local function hanhuadaojishiTime()
		if daiben.hanhuadaojishi>0 then
			daiben.hanren:SetText("喊话("..daiben.hanhuadaojishi..")");
			C_Timer.After(1,hanhuadaojishiTime)
			daiben.hanhuadaojishi=daiben.hanhuadaojishi-1
		else
			daiben.hanren:Enable() 
			daiben.hanren:SetText("喊话");
		end
	end
	local suijizifu ={",",".","!",";","，","。","！","；"};
	daiben.hanren.chatpindaoList={}
	local paichupindaolist ={"交易","本地防务","世界防务","服务"};
	local function huoqupindaoxulie()
		local chatpindaoList = {{"说","SAY"},{"大喊","YELL"},{"公会","GUILD"}}
		local channels = {GetChannelList()}
		for i = 1, #channels, 3 do
			local id, name, disabled = channels[i], channels[i+1], channels[i+2]
			daiben.hanren.bushipaichupindao=true
			for ii=1,#paichupindaolist do
				if name==paichupindaolist[ii] then
					daiben.hanren.bushipaichupindao=false
					break
				end	
			end
			if daiben.hanren.bushipaichupindao then
				table.insert(chatpindaoList,{name,"CHANNEL",id})
			end
		end
		daiben.hanren.chatpindaoList=chatpindaoList
	end
	daiben.hanren:SetScript("OnClick", function (self)
		huoqupindaoxulie()
		local chatpindaoList=self.chatpindaoList
		local keyongpindaokkk = {}
		for i=1,#chatpindaoList do
			if PIG["daiben"]["hanhua_pindao"][chatpindaoList[i][1]] then
				table.insert(keyongpindaokkk,{chatpindaoList[i][2],chatpindaoList[i][3]})
			end
		end
		local keyongshu = #keyongpindaokkk
		if keyongshu>0 then
			self.nr=PIG_Per["daiben"]["hanhuaMSG"]
			if PIG_Per["daiben"]["hanhua_lv"] and IsInGroup() then
				self.nr=self.nr..",".."队伍LV("..huoquduiwLV()..")"
			end
			if PIG_Per["daiben"]["hanhua_danjia"] and PIG_Per["daiben"]["fubenName"]~="无" then
				self.nr=self.nr..","..huoquLVdanjia()
			end
			for x=1,#keyongpindaokkk do
				local suijishu=random(1, 8)
				self.nr=self.nr..suijizifu[suijishu]
				if keyongpindaokkk[x][1]=="CHANNEL" then
					SendChatMessage(self.nr,keyongpindaokkk[x][1],nil,keyongpindaokkk[x][2])
				else
					SendChatMessage(self.nr,keyongpindaokkk[x][1])
				end
			end
			self:Disable();
			daiben.hanhuadaojishi=daiben.hanhuajiange*keyongshu
			self:SetText("喊话("..daiben.hanhuadaojishi..")");
			hanhuadaojishiTime()
		end
	end);
	--喊话频道
	daiben.hanren.xialai=PIGDownMenu(nil,{22,24},daiben.hanren,{"LEFT",daiben.hanren,"RIGHT", 0,0})
	daiben.hanren.xialai:SetBackdrop(nil)
	daiben.hanren.xialai.Text:Hide()
	function daiben.hanren.xialai:PIGDownMenu_Update_But(self)
		huoqupindaoxulie()
		local chatpindaoList=daiben.hanren.chatpindaoList
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#chatpindaoList,1 do
		    info.text, info.arg1 = chatpindaoList[i][1], chatpindaoList[i][2]
		    info.checked = PIG["daiben"]["hanhua_pindao"][chatpindaoList[i][1]]
		    info.isNotRadio=true
			daiben.hanren.xialai:PIGDownMenu_AddButton(info)
		end 
	end
	function daiben.hanren.xialai:PIGDownMenu_SetValue(value,arg1,arg2,checked)
		PIG["daiben"]["hanhua_pindao"][value]=checked
		PIGCloseDropDownMenus()
	end
	--编辑内容
	daiben.hanren.bianjiHanhua = CreateFrame("Button",nil,daiben.hanren, "TruncatedButtonTemplate");
	daiben.hanren.bianjiHanhua:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	daiben.hanren.bianjiHanhua:SetSize(biaotiH-2,biaotiH-2);
	daiben.hanren.bianjiHanhua:SetPoint("LEFT",daiben.hanren.xialai,"RIGHT",0,0);
	daiben.hanren.bianjiHanhua.Tex = daiben.hanren.bianjiHanhua:CreateTexture(nil, "BORDER");
	daiben.hanren.bianjiHanhua.Tex:SetTexture("interface/buttons/ui-guildbutton-publicnote-up.blp");
	daiben.hanren.bianjiHanhua.Tex:SetPoint("CENTER");
	daiben.hanren.bianjiHanhua.Tex:SetSize(biaotiH-4,biaotiH-4);
	---------
	local bianjikuanghanhuaH = 130
	daiben.hanren.bianjiHanhua.F=ADD_Frame("daiben_bianjiHanhua_F_UI",daiben.hanren.bianjiHanhua,daiben:GetWidth(),bianjikuanghanhuaH,"CENTER",UIParent,"CENTER",0,0,true,false,true,true,true,"BG4")

	daiben.hanren.bianjiHanhua.F.Close = CreateFrame("Button",nil,daiben.hanren.bianjiHanhua.F, "UIPanelCloseButton");  
	daiben.hanren.bianjiHanhua.F.Close:SetSize(28,28);
	daiben.hanren.bianjiHanhua.F.Close:SetPoint("TOPRIGHT",daiben.hanren.bianjiHanhua.F,"TOPRIGHT",3,3);
	---喊话
	local huifuhanhuagaoduX=40
	daiben.hanren.bianjiHanhua.F.hanhuaneirong = daiben.hanren.bianjiHanhua.F:CreateFontString();
	daiben.hanren.bianjiHanhua.F.hanhuaneirong:SetPoint("TOPLEFT", daiben.hanren.bianjiHanhua.F, "TOPLEFT", 10,-10);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong:SetFontObject(GameFontNormal);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong:SetText("喊话内容:");
	daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF = CreateFrame("Frame", nil, daiben.hanren.bianjiHanhua.F,"BackdropTemplate");
	daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 16,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF:SetSize(daiben.hanren.bianjiHanhua.F:GetWidth()-10,30);
	daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF:SetPoint("TOPLEFT", daiben.hanren.bianjiHanhua.F.hanhuaneirong, "BOTTOMLEFT", -3,-6);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E = CreateFrame('EditBox', nil, daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF,"BackdropTemplate");
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetPoint("TOPLEFT", daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF, "TOPLEFT", 6,-6);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetWidth(daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF:GetWidth()-6);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetMultiLine(true)
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetFontObject(ChatFontNormal);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetAutoFocus(false);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetMaxLetters(110);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetTextColor(1, 1, 1, 0.7);
	---
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji = ADD_Checkbutton(nil,daiben.hanren.bianjiHanhua.F,-40,"LEFT",daiben.hanren.bianjiHanhua.F.hanhuaneirong,"RIGHT",6,-1,"喊话队伍等级","喊话内容附带现有队伍成员等级，坑位数")
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T = daiben.hanren.bianjiHanhua.F:CreateFontString("daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T_UI");
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetPoint("TOPRIGHT", daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF, "BOTTOMRIGHT", 0,0);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetText("当前字符数:0");
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetTextColor(1, 1, 0, 1);
	----
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetScript("OnCursorChanged", function(self) 
		local bianji_W=self:GetHeight()
		daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF:SetHeight(bianji_W+12);
		if daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji:GetChecked() then
			if string.len(self:GetText())>230 then
				daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetText("当前字符数:"..string.len(self:GetText()).."可能无法发送")
				daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetTextColor(1, 0, 0, 1);
			else
				daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetText("当前字符数:"..string.len(self:GetText()))
				daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetTextColor(1, 1, 0, 1);
			end
		else
			if string.len(self:GetText())>250 then
				daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetText("当前字符数:"..string.len(self:GetText()).."可能无法发送")
				daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetTextColor(1, 0, 0, 1);
			else
				daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetText("当前字符数:"..string.len(self:GetText()))
				daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetTextColor(1, 1, 0, 1);
			end
		end
	end);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetScript("OnEditFocusGained", function(self)
		self:SetTextColor(1, 1, 1, 1);
		self.YES:Show();
	end);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetScript("OnEditFocusLost", function(self)
		PIG_Per.daiben.hanhuaMSG=self:GetText();
		self:SetTextColor(1, 1, 1, 0.7);
		self.YES:Hide();
	end);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.hanhua_lv=true
		else
			PIG_Per.daiben.hanhua_lv=false
		end
	end);
	local tooltiplv = "喊话内容附带已设置的等级范围和单价\n谨慎使用，可能会被别人举报是刷子";
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_LVdanjia = ADD_Checkbutton(nil,daiben.hanren.bianjiHanhua.F,-40,"LEFT",daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji,"RIGHT",110,-1,"喊话价格",tooltiplv)
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_LVdanjia:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.hanhua_danjia=true
		else
			PIG_Per.daiben.hanhua_danjia=false
		end
	end);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E.YES = CreateFrame("Button",nil,daiben.hanren.bianjiHanhua.F.hanhuaneirong_E, "UIPanelButtonTemplate");
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E.YES:SetSize(50,18);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E.YES:SetPoint("TOPLEFT", daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF, "BOTTOMLEFT", 0,1.8);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E.YES:SetText("保存");
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E.YES:Hide();
	local buttonFont=daiben.hanren.bianjiHanhua.F.hanhuaneirong_E.YES:GetFontString()
	buttonFont:SetFont(ChatFontNormal:GetFont(), 9);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E.YES:SetScript("OnClick", function (self)
		local ParentF = self:GetParent();
		ParentF:ClearFocus()
		local guanjianV = ParentF:GetText();
		PIG_Per.daiben.hanhuaMSG=guanjianV;
		ParentF:SetTextColor(1, 1, 1, 0.7);
	end);
	----------
	daiben.hanren.bianjiHanhua:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.2,-1.2);
	end);
	daiben.hanren.bianjiHanhua:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	daiben.hanren.bianjiHanhua.F:HookScript("OnShow", function (self)
		Daiben_shezhi_F_UI:Hide()
		daiben.JizhangF.youhuie:Hide();
		self:ClearAllPoints();
		if daiben_UI:GetLeft()<WowWidth then
			if daiben_UI:GetBottom()<WowHeight then
				self:SetPoint("BOTTOMLEFT",daiben_UI,"BOTTOMRIGHT",2,-0);
			else
				self:SetPoint("TOPLEFT",daiben_UI,"TOPRIGHT",2,-0);
			end
		else
			if daiben_UI:GetBottom()<WowHeight then
				self:SetPoint("BOTTOMRIGHT",daiben_UI,"BOTTOMLEFT",-2,-0);
			else
				self:SetPoint("TOPRIGHT",daiben_UI,"TOPLEFT",-2,-0);
			end
		end
		if PIG_Per.daiben.hanhua_lv then
			daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji:SetChecked(true);
		end
		if PIG_Per.daiben.hanhua_danjia then
			daiben.hanren.bianjiHanhua.F.hanhuaneirong_LVdanjia:SetChecked(true);
		end
		daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetText(PIG_Per.daiben.hanhuaMSG)
	end);
	daiben.hanren.bianjiHanhua:SetScript("OnClick", function (self)
		if self.F:IsShown() then
			self.F:Hide()
		else
			self.F:Show()
		end
	end);
	--重置就位
	local jiuweiTXT,chongzhiTXT = "就位","重置"
	daiben.CZbutton = CreateFrame("Button",nil,daiben, "UIPanelButtonTemplate");  
	daiben.CZbutton:SetSize(56,biaotiH-2);
	daiben.CZbutton:SetPoint("LEFT",daiben.hanren.bianjiHanhua,"RIGHT",8,0);
	daiben.CZbutton:SetText(jiuweiTXT);
	daiben.CZbutton:RegisterForClicks("LeftButtonUp","RightButtonUp")
	daiben.CZbutton:SetScript("OnClick", function (self,button)
		if button=="LeftButton" then
			if self:GetText()==jiuweiTXT then
				DoReadyCheck();
			elseif self:GetText()==chongzhiTXT then
				ResetInstances();
				if PIG_Per.daiben.CZ_jiuwei then
					DoReadyCheck();
				end
			end
		else
			DoReadyCheck();
		end
	end);
	--队伍拾取方式
	daiben.Loot = CreateFrame("Button",nil,daiben);
	daiben.Loot:SetSize(30,biaotiH-4);
	daiben.Loot:SetPoint("LEFT",daiben.CZbutton,"RIGHT",10,0);
	daiben.Loot.t = daiben.Loot:CreateFontString();
	daiben.Loot.t:SetPoint("LEFT", daiben.Loot, "LEFT", 0, 0);
	daiben.Loot.t:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	daiben.Loot:SetScript("OnClick", function ()
		local lootmethod, _, _ = GetLootMethod();
		if lootmethod=="freeforall" then
			SetLootMethod("master","player")
			return
		elseif lootmethod=="master" then
			SetLootMethod("freeforall")
			return
		end
		SetLootMethod("freeforall")
	end);
	local function gengxinLOOTfs()
		if IsInGroup() then
			local lootmethod, _, _ = GetLootMethod();
			if lootmethod=="freeforall" then 
				daiben.Loot.t:SetText("\124cff00ff00自由\124r");
			elseif lootmethod=="roundrobin" then 
				daiben.Loot.t:SetText("\124cffff0000轮流\124r");	
			elseif lootmethod=="master" then 
				daiben.Loot.t:SetText("\124cffff0000队长\124r");	
			elseif lootmethod=="group" then 
				daiben.Loot.t:SetText("\124cffff0000队伍\124r");	
			elseif lootmethod=="needbeforegreed" then 
				daiben.Loot.t:SetText("\124cffff0000需求\124r");	
			end
		else
			daiben.Loot.t:SetText("\124cff00ff00单人\124r");
		end
	end
	gengxinLOOTfs()
	daiben.Loot:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
	daiben.Loot:RegisterEvent("GROUP_ROSTER_UPDATE");
	daiben.Loot:SetScript("OnEvent", function ()
		gengxinLOOTfs()
	end)
	--设置按钮
	daiben.setting = CreateFrame("Button",nil,daiben, "TruncatedButtonTemplate"); 
	daiben.setting:SetNormalTexture("interface/gossipframe/bindergossipicon.blp"); 
	daiben.setting:SetHighlightTexture(130718);
	daiben.setting:SetSize(biaotiH-6,biaotiH-6);
	daiben.setting:SetPoint("RIGHT", daiben, "RIGHT", -60, 0);
	daiben.setting.Down = daiben.setting:CreateTexture(nil, "OVERLAY");
	daiben.setting.Down:SetTexture(130839);
	daiben.setting.Down:SetAllPoints(daiben.setting)
	daiben.setting.Down:Hide();
	daiben.setting:SetScript("OnMouseDown", function (self)
		self.Down:Show();
	end);
	daiben.setting:SetScript("OnMouseUp", function (self)
		self.Down:Hide();
	end);
	daiben.setting:SetScript("OnClick", function (self)
		if Daiben_shezhi_F_UI:IsShown() then
			Daiben_shezhi_F_UI:Hide();
		else
			Open_settingUI()
		end
	end);
	--计时====
	daiben.Time = CreateFrame("Button",nil,daiben);
	daiben.Time:SetNormalTexture("interface/icons/inv_misc_pocketwatch_01.blp");
	daiben.Time:SetHighlightTexture(130718);
	daiben.Time:SetSize(biaotiH-7,biaotiH-7);
	daiben.Time:SetPoint("RIGHT", daiben, "RIGHT", -30, 0);
	if PIG_Per.daiben.bangdingUI then daiben.Time:Hide(); end
	daiben.Time.Down = daiben.Time:CreateTexture(nil, "OVERLAY");
	daiben.Time.Down:SetTexture(130839);
	daiben.Time.Down:SetAllPoints(daiben.Time)
	daiben.Time.Down:Hide();
	daiben.Time:HookScript("OnMouseDown", function (self)
		self.Down:Show();
	end);
	daiben.Time:HookScript("OnMouseUp", function (self)
		self.Down:Hide();
	end);
	---
	daiben.TimeF=ADD_Frame(nil,daiben,520, 334,"TOPLEFT",daiben,"BOTTOMLEFT",0,-2,false,false,false,false,false,"BG4")
	daiben.TimeF:SetHeight(TIME_Height)
	--记账=========
	daiben.Jizhang = CreateFrame("Button",nil,daiben, "TruncatedButtonTemplate"); 
	daiben.Jizhang:SetNormalTexture("interface/chatframe/ui-chaticon-maximize-up.blp");
	daiben.Jizhang:SetPushedTexture("interface/chatframe/ui-chaticon-maximize-down.blp")
	daiben.Jizhang:SetHighlightTexture("interface/buttons/ui-checkbox-highlight.blp");
	daiben.Jizhang:SetSize(biaotiH,biaotiH);
	daiben.Jizhang:SetPoint("RIGHT", daiben, "RIGHT", 0, 0);
	--
	daiben.JizhangF=ADD_Frame(nil,daiben,520, 334,"TOPLEFT",daiben,"BOTTOMLEFT",0,-2,false,false,false,false,false,"BG4")
	daiben.JizhangF:SetHeight(JZ_Height)
	--==刷新位置========================
	local maxiconup ="interface/chatframe/ui-chaticon-maximize-up.blp"
	local maxicondown ="interface/chatframe/ui-chaticon-maximize-down.blp"
	local miniconup ="interface/chatframe/ui-chaticon-minimize-up.blp"
	local minicondown ="interface/chatframe/ui-chaticon-minimize-down.blp"
	local function UpdatePoint(jizhangShow,TimeShow)
		local jizhangShow = jizhangShow or PIG_Per.daiben.Jizhang_Show
		local TimeShow = TimeShow or PIG_Per.daiben.Time_Show
		if PIG_Per.daiben.bangdingUI then TimeShow=jizhangShow end
		local TimeUI =daiben.TimeF
		local JizhangUI =daiben.JizhangF
		TimeUI:Hide()
		JizhangUI:Hide()
		daiben.Jizhang:SetNormalTexture(maxiconup);
		daiben.Jizhang:SetPushedTexture(maxicondown)
		TimeUI:ClearAllPoints();
		JizhangUI:ClearAllPoints();
		if daiben:GetBottom()<WowHeight then--在下半部		
			if jizhangShow and TimeShow then
				TimeUI:SetPoint("BOTTOMLEFT",daiben,"TOPLEFT",0,0);
				TimeUI:SetPoint("BOTTOMRIGHT",daiben,"TOPRIGHT",0,0);
				TimeUI:Show()
				daiben.Jizhang:SetNormalTexture(miniconup);
				daiben.Jizhang:SetPushedTexture(minicondown)
				JizhangUI:SetPoint("BOTTOMLEFT",TimeUI,"TOPLEFT",0,2);
				JizhangUI:SetPoint("BOTTOMRIGHT",TimeUI,"TOPRIGHT",0,2);
				JizhangUI:Show()
			elseif TimeShow then
				TimeUI:SetPoint("BOTTOMLEFT",daiben,"TOPLEFT",0,0);
				TimeUI:SetPoint("BOTTOMRIGHT",daiben,"TOPRIGHT",0,0);
				TimeUI:Show()
			elseif jizhangShow then
				daiben.Jizhang:SetNormalTexture(miniconup);
				daiben.Jizhang:SetPushedTexture(minicondown)
				JizhangUI:SetPoint("BOTTOMLEFT",daiben,"TOPLEFT",0,0);
				JizhangUI:SetPoint("BOTTOMRIGHT",daiben,"TOPRIGHT",0,0);
				JizhangUI:Show()
			end
		else
			if jizhangShow and TimeShow then
				daiben.Jizhang:SetNormalTexture(miniconup);
				daiben.Jizhang:SetPushedTexture(minicondown)
				JizhangUI:SetPoint("TOPLEFT",daiben,"BOTTOMLEFT",0,0);
				JizhangUI:SetPoint("TOPRIGHT",daiben,"BOTTOMRIGHT",0,0);
				JizhangUI:Show()
				TimeUI:SetPoint("TOPLEFT",JizhangUI,"BOTTOMLEFT",0,-2);
				TimeUI:SetPoint("TOPRIGHT",JizhangUI,"BOTTOMRIGHT",0,-2);
				TimeUI:Show()
			elseif TimeShow then
				TimeUI:SetPoint("TOPLEFT",daiben,"BOTTOMLEFT",0,0);
				TimeUI:SetPoint("TOPRIGHT",daiben,"BOTTOMRIGHT",0,0);
				TimeUI:Show()
			elseif jizhangShow then
				daiben.Jizhang:SetNormalTexture(miniconup);
				daiben.Jizhang:SetPushedTexture(minicondown)
				JizhangUI:SetPoint("TOPLEFT",daiben,"BOTTOMLEFT",0,0);
				JizhangUI:SetPoint("TOPRIGHT",daiben,"BOTTOMRIGHT",0,0);
				JizhangUI:Show()
			end
		end
	end
	UpdatePoint(jizhangShow,TimeShow)
	daiben.Time:SetScript("OnClick", function (self)
		if daiben.TimeF:IsShown() then
			PIG_Per.daiben.Time_Show=false 
		else
			PIG_Per.daiben.Time_Show=true
		end
		UpdatePoint(PIG_Per.daiben.Jizhang_Show,PIG_Per.daiben.Time_Show)
	end)
	daiben.Jizhang:SetScript("OnClick", function (self)
		if daiben.JizhangF:IsShown() then
			PIG_Per.daiben.Jizhang_Show=false 
		else
			PIG_Per.daiben.Jizhang_Show=true
		end
		UpdatePoint(PIG_Per.daiben.Jizhang_Show,PIG_Per.daiben.Time_Show)
	end);
	--记账标题
	local jizhangList = {"LV","玩家","单价|cffFF69B4(优惠)|r","余额","余次","已带"}
	local jizhangListPoint = {5,30,140,210,270,310}
	for i=1,#jizhangList do
		local jizhangList1 = daiben.JizhangF:CreateFontString();
		jizhangList1:SetPoint("TOPLEFT", daiben.JizhangF, "TOPLEFT", jizhangListPoint[i],-3);
		jizhangList1:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		jizhangList1:SetTextColor(1, 1, 0, 1);
		jizhangList1:SetText(jizhangList[i]);
	end
	daiben.JizhangF.line = daiben.JizhangF:CreateLine()
	daiben.JizhangF.line:SetThickness(1);
	daiben.JizhangF.line:SetStartPoint("TOPLEFT",0,-21)
	daiben.JizhangF.line:SetEndPoint("TOPRIGHT",0,-21)
	daiben.JizhangF.line:SetColorTexture(0, 1, 1, 0.3)
	--计时标题
	local TimeList = {"#","进本|cffFF69B4(CD)|r","出本|cffFF69B4(CD)|r","重置|cffFF69B4(CD)|r","击杀数","耗时/m"}
	local TimeListPoint = {5,24,94,162,238,294}
	for i=1,#TimeList do
		local TimeList1 = daiben.TimeF:CreateFontString();
		TimeList1:SetPoint("TOPLEFT", daiben.TimeF, "TOPLEFT", TimeListPoint[i],-3);
		TimeList1:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		TimeList1:SetTextColor(1, 1, 0, 1);
		TimeList1:SetText(TimeList[i]);
	end
	--更新记账面板
	local function Update_danjiaqita(fuFF,danjiaV,youhui,yue,yidai)
		fuFF.danjia.t:SetText(danjiaV);
		fuFF.danjia.yh:SetText(youhui);
		fuFF.yue.t:SetText(yue);
		fuFF.yidai.t:SetText(yidai);
		local danjiaV = danjiaV-youhui
		if danjiaV>0 then
			local yuciV = yue/danjiaV
			local yuciV =floor(yuciV*10)
			local yuciV =yuciV/10
			fuFF.yuci.t:SetText(yuciV);
		else
			fuFF.yuci.t:SetText("免费");
		end
	end
	local zijirealm = GetRealmName()
	local function Update_jizhangData(UPdanjia,bukoukuan)
		local datayuan = PIG_Per.daiben.Namelist
		local dataNum = #datayuan
		for i = dataNum, 1, -1 do
			if GetServerTime()-datayuan[i][1]>86400 then
				trremove(datayuan,i)
			end
		end

		for id = 1, MAX_PARTY_MEMBERS, 1 do
			local fuFF=_G["jzhang_"..id]
			fuFF:Hide();
			local name, realm = UnitFullName("Party"..id)
			if name~=nil and name~="未知目标" then
				if realm=="" or realm==nil then realm=zijirealm end
				local name_realm =name.."-"..realm;
				fuFF:Show();
				local _, classFilename = UnitClass("Party"..id);
				local rPerc, gPerc, bPerc, argbHex = GetClassColor(classFilename);
				fuFF.name.t:SetTextColor(rPerc, gPerc, bPerc, 1);
				fuFF.name.t:SetText(name);
				fuFF.name.qm=name_realm;
				local Level=UnitLevel("Party"..id) or 1;
				local danjiaV=jisuandanjia(Level);
				fuFF.lv.t:SetText(Level);

				fuFF.wanjiaYes=true;
				for x=1, #datayuan,1 do
					if datayuan[x][2]==name_realm then---如果存在更新信息
						fuFF.wanjiaYes=false
						datayuan[x][1]=GetServerTime()
						if UPdanjia then
							datayuan[x][7]=danjiaV;
						else
							if PIG_Per.daiben.SDdanjia then--锁定单价
								if datayuan[x][4]>0 then--有余额
									--print(name_realm.."有余额已锁定单价")
								else
									datayuan[x][7]=danjiaV;
								end
							else
								datayuan[x][7]=danjiaV;
							end
						end
						Update_danjiaqita(fuFF,datayuan[x][7],datayuan[x][3],datayuan[x][4],datayuan[x][5])
						break
					end
				end
				if fuFF.wanjiaYes then
					local wanjaixinxi={GetServerTime(),name_realm,0,0,0,false,danjiaV,false};--1时间/2名/3优惠/4余额/5已带次/6退款状态/7单价/8本次不扣款
					if bukoukuan then
						wanjaixinxi[8]=true
					end
					table.insert(datayuan,wanjaixinxi);
					Update_danjiaqita(fuFF,danjiaV,0,0,0)
				end
			end
		end
	end
	addonTable.Update_jizhangData = Update_jizhangData
	---记账内容----
	local hangHHH = 23
	for id = 1, MAX_PARTY_MEMBERS, 1 do
		local jzhang = CreateFrame("Frame", "jzhang_"..id, daiben.JizhangF);
		jzhang:SetSize(Width-2,hangHHH);
		if id==1 then
			jzhang:SetPoint("TOP", daiben.JizhangF, "TOP", 0,-22);
		else
			jzhang:SetPoint("TOP", _G["jzhang_"..(id-1)], "BOTTOM", 0,0);
		end
		jzhang:Hide();
		if id~=MAX_PARTY_MEMBERS then
			jzhang.line = jzhang:CreateLine()
			jzhang.line:SetThickness(1);
			jzhang.line:SetStartPoint("BOTTOMLEFT",0,0)
			jzhang.line:SetEndPoint("BOTTOMRIGHT",0,0)
			jzhang.line:SetColorTexture(0, 1, 1, 0.2)
		end
		--
		jzhang.lv = CreateFrame("Frame", nil, jzhang);
		jzhang.lv:SetSize(22,hangHHH);
		jzhang.lv:SetPoint("LEFT", jzhang, "LEFT", jizhangListPoint[1]-2,-0);
		jzhang.lv.t = jzhang.lv:CreateFontString();	
		jzhang.lv.t:SetPoint("LEFT", jzhang.lv, "LEFT", 0,0);
		jzhang.lv.t:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		jzhang.lv.t:SetTextColor(0, 1, 0, 1);

		jzhang.name = CreateFrame("Frame", nil, jzhang);
		jzhang.name:SetSize(110,hangHHH);
		jzhang.name:SetPoint("LEFT", jzhang, "LEFT", jizhangListPoint[2],-0);
		jzhang.name.t = jzhang.name:CreateFontString();
		jzhang.name.t:SetPoint("LEFT", jzhang.name, "LEFT", 0,0);
		jzhang.name.t:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		-- -------
		jzhang.danjia = CreateFrame("Frame", nil, jzhang);
		jzhang.danjia:SetSize(54,hangHHH);
		jzhang.danjia:SetPoint("LEFT", jzhang, "LEFT", jizhangListPoint[3]+4,-0);
		jzhang.danjia.t = jzhang.danjia:CreateFontString();
		jzhang.danjia.t:SetPoint("LEFT", jzhang.danjia, "LEFT", 0,0);
		jzhang.danjia.t:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		jzhang.danjia.t:SetTextColor(0, 1, 0, 1);
		jzhang.danjia.yhL = jzhang.danjia:CreateFontString();
		jzhang.danjia.yhL:SetPoint("LEFT", jzhang.danjia.t, "RIGHT", 0,0);
		jzhang.danjia.yhL:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		jzhang.danjia.yhL:SetTextColor(1, 105/255,180/255, 1);
		jzhang.danjia.yhL:SetText("(");
		jzhang.danjia.yh = jzhang.danjia:CreateFontString();
		jzhang.danjia.yh:SetPoint("LEFT", jzhang.danjia.yhL, "RIGHT", -2,0);
		jzhang.danjia.yh:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		jzhang.danjia.yh:SetTextColor(1, 105/255,180/255, 1);
		jzhang.danjia.yhR = jzhang.danjia:CreateFontString();
		jzhang.danjia.yhR:SetPoint("LEFT", jzhang.danjia.yh, "RIGHT", -2,0);
		jzhang.danjia.yhR:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		jzhang.danjia.yhR:SetTextColor(1, 105/255,180/255, 1);
		jzhang.danjia.yhR:SetText(")");
		jzhang.danjia:SetScript("OnMouseUp", function (self,button)
			if button=="LeftButton" then
				if daiben.JizhangF.youhuie:IsShown() then
					daiben.JizhangF.youhuie:Hide();
				else
					Daiben_shezhi_F_UI:Hide()
					daiben.hanren.bianjiHanhua.F:Hide();
					daiben.Jizhang:Open_youhuiyue(self,"为此玩家优惠",3)
				end
			else
				local bianji_name=self:GetParent().name.qm
				local shujuyaunX = PIG_Per.daiben.Namelist
				for x=1, #shujuyaunX,1 do
					if shujuyaunX[x][2]==bianji_name then
						shujuyaunX[x][7]=jisuandanjia(UnitLevel("Party"..id))
						break
					end
				end
				Update_jizhangData();
			end
		end);
		-- ---------
		jzhang.yue = CreateFrame("Frame",nil, jzhang);
		jzhang.yue:SetSize(50,hangHHH);
		jzhang.yue:SetPoint("LEFT", jzhang, "LEFT", jizhangListPoint[4]+2,-0);
		jzhang.yue.t = jzhang.yue:CreateFontString();
		jzhang.yue.t:SetPoint("LEFT", jzhang.yue, "LEFT", 0,0);
		jzhang.yue.t:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		jzhang.yue.t:SetTextColor(0, 1, 0, 1);
		jzhang.yue:SetScript("OnMouseUp", function (self)
			if daiben.JizhangF.youhuie:IsShown() then
				daiben.JizhangF.youhuie:Hide();
			else
				Daiben_shezhi_F_UI:Hide()
				daiben.hanren.bianjiHanhua.F:Hide();
				daiben.Jizhang:Open_youhuiyue(self,"修改此玩家的余额为",4)
			end
		end);
		-------	
		jzhang.yuci = CreateFrame("Frame",nil, jzhang);
		jzhang.yuci:SetSize(28,hangHHH);
		jzhang.yuci:SetPoint("LEFT", jzhang, "LEFT", jizhangListPoint[5]+2,-0);
		jzhang.yuci.t = jzhang.yuci:CreateFontString();
		jzhang.yuci.t:SetPoint("LEFT", jzhang.yuci, "LEFT", 0,0);
		jzhang.yuci.t:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		jzhang.yuci.t:SetTextColor(243/255, 108/255, 33/255, 1);
		jzhang.yuci:SetScript("OnMouseUp", function (self,button)
			local bianji_name=self:GetParent().name.qm
			local shujuyaunX = PIG_Per.daiben.Namelist
			for x=1, #shujuyaunX,1 do
				if shujuyaunX[x][2]==bianji_name then
					if button=="LeftButton" then
						shujuyaunX[x][4]=shujuyaunX[x][4]+(shujuyaunX[x][7]-shujuyaunX[x][3])
					else
						shujuyaunX[x][4]=shujuyaunX[x][4]-(shujuyaunX[x][7]-shujuyaunX[x][3])
					end
					Update_jizhangData();
					break
				end
			end
		end);
		-- --
		jzhang.yidai = CreateFrame("Frame",nil, jzhang);
		jzhang.yidai:SetSize(28,hangHHH);
		jzhang.yidai:SetPoint("LEFT", jzhang, "LEFT", jizhangListPoint[6]+2,-0);
		jzhang.yidai.t = jzhang.yidai:CreateFontString();
		jzhang.yidai.t:SetPoint("LEFT", jzhang.yidai, "LEFT", 0,0);
		jzhang.yidai.t:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		jzhang.yidai.t:SetTextColor(0, 1, 0, 1);
		jzhang.yidai:SetScript("OnMouseUp", function (self,button)
			local bianji_name=self:GetParent().name.qm
			local shujuyaunX = PIG_Per.daiben.Namelist
			for x=1, #shujuyaunX,1 do
				if shujuyaunX[x][2]==bianji_name then
					if button=="LeftButton" then
						shujuyaunX[x][5]=shujuyaunX[x][5]+1
					else
						shujuyaunX[x][5]=shujuyaunX[x][5]-1
					end
					Update_jizhangData();
					break
				end
			end
		end);
	end
	---
	daiben.JizhangF.linx1 = daiben.JizhangF:CreateLine()
	daiben.JizhangF.linx1:SetColorTexture(0, 1, 1, 0.3)
	daiben.JizhangF.linx1:SetThickness(1);
	daiben.JizhangF.linx1:SetStartPoint("TOPLEFT",1,-114)
	daiben.JizhangF.linx1:SetEndPoint("TOPRIGHT",-1,-114)

	daiben.JizhangF.shouruT = daiben.JizhangF:CreateFontString();
	daiben.JizhangF.shouruT:SetPoint("TOPLEFT", daiben.JizhangF.linx1, "BOTTOMLEFT", 8,-5);
	daiben.JizhangF.shouruT:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	daiben.JizhangF.shouruT:SetText("|cff00ff00本次收入:|r");
	daiben.JizhangF.shouru = daiben.JizhangF:CreateFontString();
	daiben.JizhangF.shouru:SetPoint("LEFT", daiben.JizhangF.shouruT, "RIGHT", 0,0);
	daiben.JizhangF.shouru:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	daiben.JizhangF.shouru:SetTextColor(1, 1, 0, 1);
	daiben.JizhangF.shouru:SetText(0);
	--收入清零-----------
	local CZGw,CZGy = 16,16
	daiben.JizhangF.QkSr = CreateFrame("Button",nil,daiben.JizhangF);
	daiben.JizhangF.QkSr:SetSize(CZGw,CZGy);
	daiben.JizhangF.QkSr:SetPoint("LEFT", daiben.JizhangF.shouru, "RIGHT", 1,-0.8);
	daiben.JizhangF.QkSr.highlight = daiben.JizhangF.QkSr:CreateTexture(nil, "HIGHLIGHT");
	daiben.JizhangF.QkSr.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
	daiben.JizhangF.QkSr.highlight:SetBlendMode("ADD")
	daiben.JizhangF.QkSr.highlight:SetPoint("CENTER", daiben.JizhangF.QkSr, "CENTER", 0,0);
	daiben.JizhangF.QkSr.highlight:SetSize(CZGw,CZGy);
	daiben.JizhangF.QkSr.Normal = daiben.JizhangF.QkSr:CreateTexture(nil, "BORDER");
	daiben.JizhangF.QkSr.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
	daiben.JizhangF.QkSr.Normal:SetBlendMode("ADD")
	daiben.JizhangF.QkSr.Normal:SetPoint("CENTER", daiben.JizhangF.QkSr, "CENTER", 0,0);
	daiben.JizhangF.QkSr.Normal:SetSize(CZGw,CZGy);
	daiben.JizhangF.QkSr:HookScript("OnMouseDown", function (self)
		self.Normal:SetPoint("CENTER", self, "CENTER", -1.2,-1.2);
	end);
	daiben.JizhangF.QkSr:HookScript("OnMouseUp", function (self)
		self.Normal:SetPoint("CENTER", self, "CENTER", 0,0);
	end);
	StaticPopupDialogs["SHOURU_QINGLING"] = {
		text = "|cff00FFFF!Pig"..GnName.."：|r\n|cffff0000重置|r本次收入统计?",
		button1 = "是",
		button2 = "否",
		OnAccept = function()
			PIG_Per.daiben.Shouru = GetMoney();
			PIG_Per.daiben.Over_Time = GetServerTime();
			daiben.JizhangF.shouru:SetText("|cffffff000G(总"..floor((GetMoney()/10000)).."G)|r");
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	daiben.JizhangF.QkSr:SetScript("OnClick", function (self)
		StaticPopup_Show ("SHOURU_QINGLING")
	end)
	--帮助提示
	daiben.JizhangF.tishi = CreateFrame("Frame", nil, daiben.JizhangF);
	daiben.JizhangF.tishi:SetSize(20,20);
	daiben.JizhangF.tishi:SetPoint("TOPRIGHT", daiben.JizhangF.linx1, "BOTTOMRIGHT", 0,0);
	daiben.JizhangF.tishi.Texture = daiben.JizhangF.tishi:CreateTexture(nil, "BORDER");
	daiben.JizhangF.tishi.Texture:SetTexture("interface/common/help-i.blp");
	daiben.JizhangF.tishi.Texture:SetSize(26,26);
	daiben.JizhangF.tishi.Texture:SetPoint("CENTER", daiben.JizhangF.tishi, "CENTER", -1,-1);
	daiben.JizhangF.tishi:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("提示：")
		GameTooltip:AddLine(
			"|cff00ff001、重置副本会自动扣除一次费用。|r\n"..
			"|cff00ff002、玩家交易给予的金币会自动加入余额。|r\n"..
			"|cff00ff003、点击单价设置玩家的优惠金额,点击余额输入最新余额。|r\n"..
			"|cff00ff004、余次和已带左键点击增加一次，右键减少一次。|r\n"..
			"|cff00ff005、|cffffff00启用有余额锁定单价时右击单价数字可手动更新单价。|r\n"..
			"|cff00ff006、下线超过1小时本次收入统计将会清零。|r")
		GameTooltip:Show();
	end);
	daiben.JizhangF.tishi:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);

	--设置部分
	daiben.JizhangF.linx2 = daiben.JizhangF:CreateLine()
	daiben.JizhangF.linx2:SetColorTexture(0,1,1,0.3)
	daiben.JizhangF.linx2:SetThickness(1);
	daiben.JizhangF.linx2:SetStartPoint("TOPLEFT",1,-138)
	daiben.JizhangF.linx2:SetEndPoint("TOPRIGHT",-1,-138)
	--扣款
	local function shoudongkouqian(jiakuan)
		local numSubgroupMembers = GetNumSubgroupMembers()
		local shujuyaunX = PIG_Per.daiben.Namelist
		for id = 1, numSubgroupMembers, 1 do
			local name, realm = UnitName("Party"..id)
			if name~="未知目标" then
				if realm=="" or realm==nil then realm=zijirealm end
				local name_realm =name.."-"..realm;
				for x=1, #shujuyaunX,1 do
					if shujuyaunX[x][2]==name_realm then
						if jiakuan then
							shujuyaunX[x][4]=shujuyaunX[x][4]+(shujuyaunX[x][7]-shujuyaunX[x][3])
						else
							if not shujuyaunX[x][8] then
								shujuyaunX[x][4]=shujuyaunX[x][4]-(shujuyaunX[x][7]-shujuyaunX[x][3])
								shujuyaunX[x][5]=shujuyaunX[x][5]+1
							end
						end
						break
					end
				end
			end
		end
		for x=1, #shujuyaunX,1 do
			shujuyaunX[x][8]=false
		end
		Update_jizhangData();
	end
	daiben.JizhangF.kouqian = CreateFrame("Button",nil,daiben.JizhangF, "UIPanelButtonTemplate");  
	daiben.JizhangF.kouqian:SetSize(biaotiH*2+4,biaotiH-6);
	daiben.JizhangF.kouqian:SetPoint("TOPLEFT",daiben.JizhangF.linx2,"TOPLEFT",14,-2);
	daiben.JizhangF.kouqian:SetText("全队-");
	daiben.JizhangF.kouqian:SetScript("OnClick", function (self)
		local DQTime = GetServerTime()
		if self.daojishi then
			if DQTime-self.daojishi<2 then
				return
			end
		end
		if PIG_Per.daiben.shoudongMOD then
			local timedata = PIG_Per.daiben.Timelist[1]
			daiben:zhixingCZ(timedata)
			daiben:daiben_bobao(timedata,"正常")
		else
			shoudongkouqian()
		end
		self.daojishi=DQTime
	end);
	daiben.JizhangF.jiaqianG = CreateFrame("Button",nil,daiben.JizhangF, "UIPanelButtonTemplate");  
	daiben.JizhangF.jiaqianG:SetSize(biaotiH*2+4,biaotiH-6);
	daiben.JizhangF.jiaqianG:SetPoint("TOPLEFT",daiben.JizhangF.linx2,"TOPLEFT",88,-2);
	daiben.JizhangF.jiaqianG:SetText("全队+");
	daiben.JizhangF.jiaqianG:SetScript("OnClick", function (self)
		local DQTime = GetServerTime()
		if self.daojishi then
			if DQTime-self.daojishi<2 then
				return
			end
		end
		shoudongkouqian(true)
		self.daojishi=DQTime
	end);
	--手动通报
	daiben.JizhangF.shoudongguangboyuci = CreateFrame("Button",nil,daiben.JizhangF);  
	daiben.JizhangF.shoudongguangboyuci:SetSize(biaotiH-6,biaotiH-6);
	daiben.JizhangF.shoudongguangboyuci:SetPoint("TOPLEFT",daiben.JizhangF.linx2,"TOPLEFT",180,-3);
	daiben.JizhangF.shoudongguangboyuci.highlight = daiben.JizhangF.shoudongguangboyuci:CreateTexture(nil, "HIGHLIGHT");
	daiben.JizhangF.shoudongguangboyuci.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
	daiben.JizhangF.shoudongguangboyuci.highlight:SetBlendMode("ADD")
	daiben.JizhangF.shoudongguangboyuci.highlight:SetPoint("CENTER", daiben.JizhangF.shoudongguangboyuci, "CENTER", 0,0);
	daiben.JizhangF.shoudongguangboyuci.highlight:SetSize(22,22);
	daiben.JizhangF.shoudongguangboyuci.Tex = daiben.JizhangF.shoudongguangboyuci:CreateTexture(nil, "BORDER");
	daiben.JizhangF.shoudongguangboyuci.Tex:SetTexture(130979);
	daiben.JizhangF.shoudongguangboyuci.Tex:SetPoint("CENTER",4,0);
	daiben.JizhangF.shoudongguangboyuci.Tex:SetSize(24,24);
	daiben.JizhangF.shoudongguangboyuci:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
		GameTooltip:AddLine("|cff00ff00播报队内成员余额/余次|r")
		GameTooltip:Show();
	end);
	daiben.JizhangF.shoudongguangboyuci:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	daiben.JizhangF.shoudongguangboyuci:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",2.8,-1.2);
	end);
	daiben.JizhangF.shoudongguangboyuci:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER",4,0);
	end);
	--手动播报
	daiben.JizhangF.shoudongguangboyuci:SetScript("OnClick", function(self)
		daiben:shoudongbobaoG()
	end)
	---退款
	daiben.JizhangF.tuikuan = CreateFrame("Button",nil,daiben.JizhangF); 
	daiben.JizhangF.tuikuan:SetHighlightTexture(130718);
	daiben.JizhangF.tuikuan:SetSize(biaotiH-2,biaotiH-4);
	daiben.JizhangF.tuikuan:SetPoint("TOPLEFT",daiben.JizhangF.linx2,"TOPLEFT",290,-2.4);
	daiben.JizhangF.tuikuan.Tex = daiben.JizhangF.tuikuan:CreateTexture(nil, "BORDER");
	daiben.JizhangF.tuikuan.Tex:SetTexture("interface/cursor/mail.blp");
	daiben.JizhangF.tuikuan.Tex:SetTexCoord(0,1,0.23,1);
	daiben.JizhangF.tuikuan.Tex:SetPoint("CENTER",0,-3);
	daiben.JizhangF.tuikuan.Tex:SetSize(24,20);
	daiben.JizhangF.tuikuan:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
		GameTooltip:AddLine("|cff00ff00退款|r")
		GameTooltip:Show();
	end);
	daiben.JizhangF.tuikuan:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	daiben.JizhangF.tuikuan:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",self,"CENTER",-1.2,-4.2);
	end);
	daiben.JizhangF.tuikuan:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER",self,"CENTER",0,-3);
	end);
	daiben.JizhangF.tuikuan:SetScript("OnClick", function(self)	
		if self.F:IsShown() then
			self.F:Hide()
		else
			self.F:SetFrameLevel(FrameLevel+8)
			self.F:Show()
		end
	end)
	----------------------
	local tuikuanW,tuikuanH = 420,508;
	daiben.JizhangF.tuikuan.F =ADD_Frame("tuikuan_F_UI",daiben.JizhangF.tuikuan,tuikuanW,tuikuanH,"CENTER",UIParent,"CENTER",0,0,true,false,true,true,true,"BG4")
	local tuikuanF = daiben.JizhangF.tuikuan.F

	tuikuanF.yidong = CreateFrame("Frame", nil, tuikuanF);
	tuikuanF.yidong:SetSize(tuikuanW-180,24);
	tuikuanF.yidong:SetPoint("TOP", tuikuanF, "TOP", 0, -1);
	tuikuanF.yidong:EnableMouse(true)
	tuikuanF.yidong:RegisterForDrag("LeftButton")
	tuikuanF.yidong:SetScript("OnDragStart",function(self)
		tuikuanF:StartMoving()
	end)
	tuikuanF.yidong:SetScript("OnDragStop",function(self)
		tuikuanF:StopMovingOrSizing()
	end)
	tuikuanF.Biaoti = tuikuanF:CreateFontString();
	tuikuanF.Biaoti:SetPoint("CENTER", tuikuanF.yidong, "CENTER", 0,0);
	tuikuanF.Biaoti:SetFontObject(GameFontNormal);
	tuikuanF.Biaoti:SetText("!Pig带本助手玩家账目");
	tuikuanF.Close = CreateFrame("Button",nil,tuikuanF, "UIPanelCloseButton");  
	tuikuanF.Close:SetSize(28,28);
	tuikuanF.Close:SetPoint("TOPRIGHT",tuikuanF,"TOPRIGHT",2,1);
	---重置配置
	tuikuanF.qingkongwanjiaLIST = CreateFrame("Button",nil,tuikuanF, "UIPanelButtonTemplate");  
	tuikuanF.qingkongwanjiaLIST:SetSize(50,20);
	tuikuanF.qingkongwanjiaLIST:SetPoint("RIGHT",tuikuanF.Close,"LEFT",-10,0);
	tuikuanF.qingkongwanjiaLIST:SetText("清空");
	tuikuanF.qingkongwanjiaLIST:SetScript("OnClick", function ()
		StaticPopup_Show ("QINGKONGWANJIA_INFO");
	end);
	StaticPopupDialogs["QINGKONGWANJIA_INFO"] = {
		text = "\124cffff0000清空\124r所有已带玩家记录吗?",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG_Per.daiben.Namelist={}
			Update_jizhangData();
			tuikuanF:Hide()
			tuikuanF:Show()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	tuikuanF.linx = tuikuanF:CreateLine()
	tuikuanF.linx:SetColorTexture(0,1,1,0.3)
	tuikuanF.linx:SetThickness(1);
	tuikuanF.linx:SetStartPoint("TOPLEFT",3,-24)
	tuikuanF.linx:SetEndPoint("TOPRIGHT",-3,-24)
	-------
	tuikuanF.nr = CreateFrame("Frame", nil, tuikuanF);
	tuikuanF.nr:SetPoint("TOPLEFT",tuikuanF,"TOPLEFT",0,-48);
	tuikuanF.nr:SetPoint("BOTTOMRIGHT",tuikuanF,"BOTTOMRIGHT",0,0);
	--
	local tuikuanList = {"玩家名","已带次","余额","退款"}
	local tuikuanListPoint = {10,200,280,340}
	for i=1,#tuikuanList do
		local tuikuanList1 = tuikuanF.nr:CreateFontString();
		tuikuanList1:SetPoint("BOTTOMLEFT", tuikuanF.nr, "TOPLEFT", tuikuanListPoint[i],2);
		tuikuanList1:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		tuikuanList1:SetTextColor(1, 1, 0, 1);
		tuikuanList1:SetText(tuikuanList[i]);
	end
	tuikuanF.linx1 = tuikuanF:CreateLine()
	tuikuanF.linx1:SetColorTexture(0,1,1,0.3)
	tuikuanF.linx1:SetThickness(1);
	tuikuanF.linx1:SetStartPoint("TOPLEFT",3,-51)
	tuikuanF.linx1:SetEndPoint("TOPRIGHT",-3,-51)
	------------
	local hang_Height,hang_NUM  = 30, 15;
	local function OnUpdate_tuikuan(self)
		for id = 1, hang_NUM do
			local tuik = _G["tk_hang_"..id]
			tuik:Hide();
			tuik.mail:Hide()
	    end
		local namemulu = PIG_Per.daiben.Namelist
		FauxScrollFrame_Update(self,#namemulu, hang_NUM, hang_Height);
		local offset = FauxScrollFrame_GetOffset(self);
	    for id = 1, hang_NUM do
			local dangqian = id+offset;
			if namemulu[dangqian] then
				local tuik = _G["tk_hang_"..id]
				tuik:Show();
				tuik.Name:SetText(namemulu[dangqian][2]);
				tuik.yidai:SetText(namemulu[dangqian][5]);
	    		tuik.yue:SetText(namemulu[dangqian][4]);
	    		if namemulu[dangqian][4]>0 then
	    			tuik.mail:Show()
	    		end
	    	end
		end
	end
	tuikuanF.nr.Scroll = CreateFrame("ScrollFrame",nil,tuikuanF.nr, "FauxScrollFrameTemplate");  
	tuikuanF.nr.Scroll:SetPoint("TOPLEFT",tuikuanF.nr,"TOPLEFT",6,-4);
	tuikuanF.nr.Scroll:SetPoint("BOTTOMRIGHT",tuikuanF.nr,"BOTTOMRIGHT",-28,5);
	tuikuanF.nr.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, OnUpdate_tuikuan)
	end)
	for id = 1, hang_NUM do
		local tk_hang = CreateFrame("Frame", "tk_hang_"..id, tuikuanF.nr);
		tk_hang:SetSize(tuikuanF.nr.Scroll:GetWidth(), hang_Height);
		if id==1 then
			tk_hang:SetPoint("TOP",tuikuanF.nr.Scroll,"TOP",0,0);
		else
			tk_hang:SetPoint("TOP",_G["tk_hang_"..(id-1)],"BOTTOM",0,-0);
		end
		if id~=hang_NUM then
			tk_hang.line = tk_hang:CreateLine()
			tk_hang.line:SetColorTexture(0,1,1,0.2)
			tk_hang.line:SetThickness(1);
			tk_hang.line:SetStartPoint("BOTTOMLEFT",0,0)
			tk_hang.line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		tk_hang.Name = tk_hang:CreateFontString();
		tk_hang.Name:SetPoint("LEFT", tk_hang, "LEFT", tuikuanListPoint[1]-4,0);
		tk_hang.Name:SetSize(180,22);
		tk_hang.Name:SetFont(ChatFontNormal:GetFont(), 13);
		tk_hang.Name:SetJustifyH("LEFT");

		tk_hang.yidai = tk_hang:CreateFontString();
		tk_hang.yidai:SetPoint("LEFT", tk_hang.Name, "LEFT", tuikuanListPoint[2]-18,0);
		tk_hang.yidai:SetSize(50,22);
		tk_hang.yidai:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		tk_hang.yidai:SetJustifyH("RIGHT");
		tk_hang.yidai:SetTextColor(0, 1, 0, 1);

		tk_hang.yue = tk_hang:CreateFontString();
		tk_hang.yue:SetPoint("LEFT", tk_hang.Name, "LEFT", tuikuanListPoint[3]-38,0);
		tk_hang.yue:SetSize(60,22);
		tk_hang.yue:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		tk_hang.yue:SetJustifyH("RIGHT");
		tk_hang.yue:SetTextColor(1, 1, 0, 1);
		----
		tk_hang.mail = CreateFrame("Button",nil,tk_hang, "TruncatedButtonTemplate");
		tk_hang.mail:SetSize(32,24);
		tk_hang.mail:SetPoint("LEFT", tk_hang, "LEFT", tuikuanListPoint[4]-6,0);
		tk_hang.mail.Tex = tk_hang.mail:CreateTexture(nil, "BORDER");
		tk_hang.mail.Tex:SetTexture("interface/cursor/mail.blp");
		tk_hang.mail.Tex:SetTexCoord(0,1,0.23,1);
		tk_hang.mail.Tex:SetPoint("CENTER",0,-3);
		tk_hang.mail.Tex:SetSize(24,20);
		tk_hang.mail:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1,-4);
		end);
		tk_hang.mail:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER",0,-3);
		end);
		tk_hang.mail:RegisterForClicks("LeftButtonUp","RightButtonUp")
		tk_hang.mail:SetScript("OnClick", function (self,button)
			local gujiK=self:GetParent()
			local wanjianame=gujiK.Name:GetText()
			local namemulu = PIG_Per.daiben.Namelist
			if button=="LeftButton" then
				for i=1,#namemulu do
					if wanjianame==namemulu[i][2] then
						if TradeFrame:IsShown() then
							TradePlayerInputMoneyFrameGold:SetText(namemulu[i][4]);
							namemulu[i][4]=0
							gujiK.yue:SetText(0)
							self.Tex:SetDesaturated(true)
						else
							if ( MailFrame:IsVisible() and MailFrame.selectedTab == 2 ) then
								SendMailNameEditBox:SetText(wanjianame);
								SendMailSubjectEditBox:SetText("消费剩余尾款退款");
								SendMailMoneyGold:SetText(namemulu[i][4]);
								namemulu[i][4]=0
								gujiK.yue:SetText(0)
								self.Tex:SetDesaturated(true)
							else
								print("|cff00FFFF!Pig:|r|cffFFFF00请先打开交易界面或邮箱发件页面！|r");
							end
						end
						break
					end
				end
			else
				for i=1,#namemulu do
					if wanjianame==namemulu[i][2] then
						namemulu[i][4]=0
						gujiK.yue:SetText(0)
						gujiK.mail:Hide()
					end
				end
			end
		end);
	end
	tuikuanF:SetScript("OnShow", function(self)	
		OnUpdate_tuikuan(tuikuanF.nr.Scroll)
	end)
	--记时内容===========
	local function TimeInfo_Update()
		local shujudata = PIG_Per.daiben.Timelist
		local shujudataNum = #shujudata+1
		for i=1, 5 do
			local fujiK=_G["Timehang_"..i]
			fujiK.txt1:SetText(" -");
			fujiK.txt2:SetText(" -");
			fujiK.txt3:SetText(" -");
			fujiK.shaNum.t:SetText(" -");
			fujiK.Haoshi:SetText(" -");
			local Nid = shujudataNum-i
			if shujudata[Nid] then
				local Time1 = shujudata[Nid][1]
				local Time2 = shujudata[Nid][2]
				local Time3 = shujudata[Nid][3]
				local shaguai = shujudata[Nid][4]
				local daojishiTime1 =math.floor((3600+Time1-GetServerTime()) / 60+0.5);
				if daojishiTime1>0 then
					fujiK.txt1:SetText("|cffFF0000"..date("%H:%M",Time1).."|r".."|cffFF8C00("..daojishiTime1..")|r");
				else
					fujiK.txt1:SetText(date("%H:%M",Time1));
				end

				if Time2 then
					local daojishiTime2 =math.floor((3600+Time2-GetServerTime()) / 60+0.5);
					if daojishiTime2>0 then
						fujiK.txt2:SetText("|cffFF0000"..date("%H:%M",Time2).."|r".."|cffFF8C00("..daojishiTime2..")|r");
					else
						fujiK.txt2:SetText(date("%H:%M",Time2));
					end
				end
				if Time3 then
					local daojishiTime3 =math.floor((3600+Time3-GetServerTime()) / 60+0.5);
					if daojishiTime3>0 then
						fujiK.txt3:SetText("|cffFF0000"..date("%H:%M",Time3).."|r".."|cffFF8C00("..daojishiTime3..")|r");
					else
						fujiK.txt3:SetText(date("%H:%M",Time3));
					end
				end

				fujiK.shaNum.t:SetText(shaguai);

				if Time1 and Time2 then
					fujiK.Haoshi:SetText(math.floor((Time2-Time1)/60+0.5));
				end
			end
			
		end
		daiben.TimeF.cishu:SetText(PIG_Per.daiben.shuabenshu);
	end
	------
	daiben.TimeF.timexian1 = daiben.TimeF:CreateLine()
	daiben.TimeF.timexian1:SetColorTexture(0, 1, 1, 0.2)
	daiben.TimeF.timexian1:SetThickness(1);
	daiben.TimeF.timexian1:SetStartPoint("TOPLEFT",1,-20)
	daiben.TimeF.timexian1:SetEndPoint("TOPRIGHT",-1,-20)
	local hangHHH = 17
	for id = 1, 5, 1 do
		local Timehang = CreateFrame("Frame", "Timehang_"..id, daiben.TimeF);
		Timehang:SetSize(Width,hangHHH);
		if id==1 then
			Timehang:SetPoint("TOPLEFT", daiben.TimeF.timexian1, "TOPLEFT", 0,-1);
		else
			Timehang:SetPoint("TOPLEFT", _G["Timehang_"..(id-1)], "BOTTOMLEFT", 0,-2);
		end
		Timehang.xuhaoID = Timehang:CreateFontString();
		Timehang.xuhaoID:SetPoint("LEFT", Timehang, "LEFT", TimeListPoint[1],0);
		Timehang.xuhaoID:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		Timehang.xuhaoID:SetTextColor(1, 1, 0, 1);
		Timehang.xuhaoID:SetText(id);

		Timehang.txt1 = Timehang:CreateFontString();
		Timehang.txt1:SetPoint("LEFT", Timehang, "LEFT", TimeListPoint[2], 0);
		Timehang.txt1:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		Timehang.txt1:SetTextColor(0, 1, 0, 1);

		Timehang.txt2 = Timehang:CreateFontString();
		Timehang.txt2:SetPoint("LEFT", Timehang, "LEFT", TimeListPoint[3], 0);
		Timehang.txt2:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		Timehang.txt2:SetTextColor(0, 1, 0, 1);

		Timehang.txt3 = Timehang:CreateFontString();
		Timehang.txt3:SetPoint("LEFT", Timehang, "LEFT", TimeListPoint[4], 0);
		Timehang.txt3:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		Timehang.txt3:SetTextColor(0, 1, 0, 1);

		Timehang.shaNum = CreateFrame("Frame", nil, Timehang);
		Timehang.shaNum:SetSize(44,17);
		Timehang.shaNum:SetPoint("LEFT", Timehang, "LEFT", TimeListPoint[5], 0);
		Timehang.shaNum.t = Timehang.shaNum:CreateFontString();
		Timehang.shaNum.t:SetPoint("LEFT", Timehang.shaNum, "LEFT", 0, 0);
		Timehang.shaNum.t:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		Timehang.shaNum.t:SetTextColor(243/255, 108/255, 33/255, 1);

		Timehang.Haoshi = Timehang:CreateFontString();
		Timehang.Haoshi:SetPoint("LEFT", Timehang, "LEFT", TimeListPoint[6], 0);
		Timehang.Haoshi:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	end
	daiben.TimeF.timexian2 = daiben.TimeF:CreateLine()
	daiben.TimeF.timexian2:SetColorTexture(0, 1, 1, 0.3)
	daiben.TimeF.timexian2:SetThickness(1);
	daiben.TimeF.timexian2:SetStartPoint("TOPLEFT",1,-116)
	daiben.TimeF.timexian2:SetEndPoint("TOPRIGHT",-1,-116)
	daiben.TimeF.cishut = daiben.TimeF:CreateFontString();
	daiben.TimeF.cishut:SetPoint("TOPLEFT", daiben.TimeF.timexian2, "TOPLEFT", 4,-4);
	daiben.TimeF.cishut:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	daiben.TimeF.cishut:SetText("|cff00ff00 本次刷本次数：|r");
	daiben.TimeF.cishu = daiben.TimeF:CreateFontString();
	daiben.TimeF.cishu:SetPoint("LEFT", daiben.TimeF.cishut, "RIGHT", 2,0);
	daiben.TimeF.cishu:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	daiben.TimeF.cishu:SetTextColor(1, 1, 0, 1);
	daiben.TimeF.cishu:SetText(0);
	--清空刷本数
	daiben.TimeF.QkTime = CreateFrame("Button",nil,daiben.TimeF);
	daiben.TimeF.QkTime:SetSize(26,26);
	daiben.TimeF.QkTime:SetPoint("LEFT", daiben.TimeF.cishu, "RIGHT", 0,-1);
	daiben.TimeF.QkTime.highlight = daiben.TimeF.QkTime:CreateTexture(nil, "HIGHLIGHT");
	daiben.TimeF.QkTime.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
	daiben.TimeF.QkTime.highlight:SetBlendMode("ADD")
	daiben.TimeF.QkTime.highlight:SetPoint("CENTER", daiben.TimeF.QkTime, "CENTER", 0,0);
	daiben.TimeF.QkTime.highlight:SetSize(30,30);
	daiben.TimeF.QkTime.Normal = daiben.TimeF.QkTime:CreateTexture(nil, "BORDER");
	daiben.TimeF.QkTime.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
	daiben.TimeF.QkTime.Normal:SetBlendMode("ADD")
	daiben.TimeF.QkTime.Normal:SetPoint("CENTER", daiben.TimeF.QkTime, "CENTER", 0,0);
	daiben.TimeF.QkTime.Normal:SetSize(16,16);
	daiben.TimeF.QkTime:HookScript("OnMouseDown", function (self)
		self.Normal:SetPoint("CENTER", daiben.TimeF.QkTime, "CENTER", -1.5,-1.5);
	end);
	daiben.TimeF.QkTime:HookScript("OnMouseUp", function (self)
		self.Normal:SetPoint("CENTER", daiben.TimeF.QkTime, "CENTER", 0,0);
	end);
	--清空
	StaticPopupDialogs["QINGKONG_TIME_SHUABENNUM"] = {
		text = "|cff00FFFF!Pig"..GnName.."：|r\n|cffff0000清空|r副本时间和本次刷本次数吗?",
		button1 = "是",
		button2 = "否",
		OnAccept = function()
			PIG_Per.daiben.Timelist={};
			PIG_Per.daiben.shuabenshu = 0;
			PIG_Per.daiben.Over_Time = GetServerTime();
			TimeInfo_Update()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	daiben.TimeF.QkTime:SetScript("OnClick", function (self)
		StaticPopup_Show ("QINGKONG_TIME_SHUABENNUM")
	end)
	--手动增加次数
	local cishuWW,cishuHH,cishuzihao = 22,20,28
	daiben.TimeF.cishujia = CreateFrame("Button",nil,daiben.TimeF);
	daiben.TimeF.cishujia:SetSize(cishuWW,cishuHH);
	daiben.TimeF.cishujia:SetPoint("TOPLEFT", daiben.TimeF.timexian2, "TOPLEFT", 180,-2);
	daiben.TimeF.cishujia.title = daiben.TimeF.cishujia:CreateFontString();
	daiben.TimeF.cishujia.title:SetPoint("CENTER", daiben.TimeF.cishujia, "CENTER", 1, 2);
	daiben.TimeF.cishujia.title:SetFont(GameFontNormal:GetFont(), cishuzihao,"OUTLINE")
	daiben.TimeF.cishujia.title:SetTextColor(1, 1, 0, 1);
	daiben.TimeF.cishujia.title:SetText('+');
	daiben.TimeF.cishujia:HookScript("OnMouseDown", function (self)
		self.title:SetPoint("CENTER", self, "CENTER", -0.2,0.8);
	end);
	daiben.TimeF.cishujia:HookScript("OnMouseUp", function (self)
		self.title:SetPoint("CENTER", self, "CENTER", 1, 2);
	end);
	daiben.TimeF.cishujia:SetScript("OnClick", function (self)
		StaticPopup_Show("NEW_FUBEN_RECORD","手动增加一次副本记录吗？")
	end)
	--
	daiben.TimeF.cishujian = CreateFrame("Button",nil,daiben.TimeF);
	daiben.TimeF.cishujian:SetSize(cishuWW,cishuHH);
	daiben.TimeF.cishujian:SetPoint("LEFT", daiben.TimeF.cishujia, "RIGHT", 10,0);
	daiben.TimeF.cishujian.title = daiben.TimeF.cishujian:CreateFontString();
	daiben.TimeF.cishujian.title:SetPoint("CENTER", daiben.TimeF.cishujian, "CENTER", 2, 13);
	daiben.TimeF.cishujian.title:SetFont(GameFontNormal:GetFont(), cishuzihao,"OUTLINE")
	daiben.TimeF.cishujian.title:SetTextColor(1, 1, 0, 1);
	daiben.TimeF.cishujian.title:SetText('_');
	daiben.TimeF.cishujian:HookScript("OnMouseDown", function (self)
		self.title:SetPoint("CENTER", self, "CENTER", 0.8,11.8);
	end);
	daiben.TimeF.cishujian:HookScript("OnMouseUp", function (self)
		self.title:SetPoint("CENTER", self, "CENTER", 2, 13);
	end);
	daiben.TimeF.cishujian:SetScript("OnClick", function (self)
		local dialog = StaticPopup_Show("NEW_FUBEN_RECORD","删除最近一次副本记录吗？")
		if dialog then
			dialog.data  = "del"
		end
	end)
	--击杀报告
	daiben.TimeF.jishaBG = CreateFrame("Button",nil,daiben.TimeF);  
	daiben.TimeF.jishaBG:SetSize(cishuWW,cishuHH);
	daiben.TimeF.jishaBG:SetPoint("LEFT", daiben.TimeF.cishujian, "RIGHT", 40,0);
	daiben.TimeF.jishaBG.highlight = daiben.TimeF.jishaBG:CreateTexture(nil, "HIGHLIGHT");
	daiben.TimeF.jishaBG.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
	daiben.TimeF.jishaBG.highlight:SetBlendMode("ADD")
	daiben.TimeF.jishaBG.highlight:SetPoint("CENTER", daiben.TimeF.jishaBG, "CENTER", 0,0);
	daiben.TimeF.jishaBG.highlight:SetSize(cishuWW,cishuHH);
	daiben.TimeF.jishaBG.Tex = daiben.TimeF.jishaBG:CreateTexture(nil, "BORDER");
	daiben.TimeF.jishaBG.Tex:SetTexture("interface/targetingframe/ui-targetingframe-skull.blp");
	daiben.TimeF.jishaBG.Tex:SetPoint("CENTER",0,0);
	daiben.TimeF.jishaBG.Tex:SetSize(cishuWW-2,cishuHH-2);
	daiben.TimeF.jishaBG:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
		GameTooltip:AddLine("|cff00ff00击杀报告|r")
		GameTooltip:Show();
	end);
	daiben.TimeF.jishaBG:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	daiben.TimeF.jishaBG:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.2,-1.2);
	end);
	daiben.TimeF.jishaBG:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER",0,0);
	end);
	daiben.TimeF.jishaBG:SetScript("OnClick", function(self)
		if self.F:IsShown() then
			self.F:Hide()
		else
			self.F:SetFrameLevel(FrameLevel+5)
			self.F:Show()
		end
	end)
	----分析击杀明细
	local mingxizhanshihangshu,jsbgmxH=50,20
	local function Update_jishamingxi()
		daiben.zuidajishashumu = 6
		local shuju=PIG_Per.daiben.Timelist
		local shujudataNum = #shuju+1
		for i=#shuju,1,-1 do
			local fujiP = _G["JsbgList"..i]
			fujiP.heji:SetText("")
			fujiP.EXP_v:SetText("")
			fujiP.SW_v:SetText("")
			local Nid = shujudataNum-i
			if shuju[Nid] then
				fujiP.heji:SetText(shuju[Nid][4])
				local expchazhi=shuju[Nid][6]
				fujiP.EXP_v:SetText(expchazhi)
				local shengwangV=shuju[Nid][7]
				local shengwangMSG = ""
				for g=1,#shengwangV do
					if g==#shengwangV then
						shengwangMSG=shengwangMSG..shengwangV[g][1]..shengwangV[g][2]
					else
						shengwangMSG=shengwangMSG..shengwangV[g][1]..shengwangV[g][2]..","
					end
				end
				fujiP.SW_v:SetText(shengwangMSG)
				local jisahmx=shuju[Nid][8]
				local jisahmxNum=#jisahmx
				if jisahmxNum>daiben.zuidajishashumu then
					daiben.zuidajishashumu=jisahmxNum
				end
				local jishamingxiNPCmame={}
				local jishamingxiNPCmameVV={}
				for ii=1,jisahmxNum do
					table.insert(jishamingxiNPCmame,jisahmx[ii][1]);
					jishamingxiNPCmameVV[jisahmx[ii][1]]=jisahmx[ii][2];
				end
				table.sort(jishamingxiNPCmame)
				for ii=1,#jishamingxiNPCmame do
					local fujiPMX = _G["JsbgList_MX_"..i.."_"..ii]
					fujiPMX:Show()
					fujiPMX.NPC:SetText(jishamingxiNPCmame[ii])
					fujiPMX.NUM:SetText(jishamingxiNPCmameVV[jishamingxiNPCmame[ii]])
				end
				fujiP.tongzhi:Show()
				fujiP.tongzhi:SetID(Nid)
				fujiP.tongzhi:SetScript("OnClick", function(self)
					local pindao = "PARTY"
					SendChatMessage("[!Pig] 击杀报告详情:", pindao, nil);
					if expchazhi>0 then
						SendChatMessage("获得经验："..expchazhi, pindao, nil);
					end
					if shengwangMSG~="" then
						SendChatMessage("获得声望："..shengwangMSG, pindao, nil);
					end
					local fenduanshudanhangshu=10
					if #jishamingxiNPCmame>fenduanshudanhangshu then
						local fenduanshubaoben = math.ceil(#jishamingxiNPCmame/fenduanshudanhangshu)
						for x=1,fenduanshubaoben do
							local baogaomingxiguangboPVV = ""
							for ii=(x-1)*fenduanshudanhangshu+1,x*fenduanshudanhangshu do
								if jishamingxiNPCmame[ii] then
									baogaomingxiguangboPVV=baogaomingxiguangboPVV..jishamingxiNPCmame[ii]..jishamingxiNPCmameVV[jishamingxiNPCmame[ii]]..","
								end
							end
							SendChatMessage(baogaomingxiguangboPVV, pindao, nil);
						end
					else
						local baogaomingxiguangboPVV = ""
						for ii=1,#jishamingxiNPCmame do
							baogaomingxiguangboPVV=baogaomingxiguangboPVV..jishamingxiNPCmame[ii]..jishamingxiNPCmameVV[jishamingxiNPCmame[ii]]..","
						end
						SendChatMessage(baogaomingxiguangboPVV, pindao, nil);
					end
					SendChatMessage("击杀总数为："..shuju[Nid][4], pindao, nil);
				end);
			end
		end
		jishafenxi_mingxiF_UI:SetHeight(jsbgmxH*daiben.zuidajishashumu+76);
	end
	local jsbgW,jsbgH = 800,jsbgmxH*6+76
	daiben.TimeF.jishaBG.F=ADD_Frame("jishafenxi_mingxiF_UI",daiben.TimeF.jishaBG,jsbgW,jsbgH,"CENTER",UIParent,"CENTER",0,0,true,false,true,true,true,"BG4")
	local jishaBGF = daiben.TimeF.jishaBG.F

	jishaBGF.yidong = CreateFrame("Frame", nil, jishaBGF);
	jishaBGF.yidong:SetSize(jsbgW-100,20);
	jishaBGF.yidong:SetPoint("TOP", jishaBGF, "TOP", 0, -2);
	jishaBGF.yidong:EnableMouse(true)
	jishaBGF.yidong:RegisterForDrag("LeftButton")
	jishaBGF.yidong:SetScript("OnDragStart",function()
		jishaBGF:StartMoving()
	end)
	jishaBGF.yidong:SetScript("OnDragStop",function()
		jishaBGF:StopMovingOrSizing()
	end)
	jishaBGF.Biaoti = jishaBGF:CreateFontString();
	jishaBGF.Biaoti:SetPoint("TOP", jishaBGF, "TOP", 0,-4);
	jishaBGF.Biaoti:SetFontObject(GameFontNormal);
	jishaBGF.Biaoti:SetText("!Pig带本助手击杀报告");
	jishaBGF.Close = CreateFrame("Button",nil,jishaBGF, "UIPanelCloseButton");  
	jishaBGF.Close:SetSize(28,28);
	jishaBGF.Close:SetPoint("TOPRIGHT",jishaBGF,"TOPRIGHT",2,3);
	jishaBGF.line = jishaBGF:CreateLine()
	jishaBGF.line:SetColorTexture(0,1,1,0.4)
	jishaBGF.line:SetThickness(1);
	jishaBGF.line:SetStartPoint("TOPLEFT",3,-22)
	jishaBGF.line:SetEndPoint("TOPRIGHT",-2,-22)
	local fenxiW=jsbgW-6
	local fenxiH=jsbgH-50
	for i=1,5 do
		local JsbgList = CreateFrame("Frame", "JsbgList"..i, jishaBGF);
		JsbgList:SetWidth(fenxiW/5);
		if i==1 then
			JsbgList:SetPoint("TOPLEFT", jishaBGF.line, "TOPLEFT", 0,-20);
			JsbgList:SetPoint("BOTTOMLEFT", jishaBGF, "BOTTOMLEFT", 0,2);
		else
			JsbgList:SetPoint("TOPLEFT", _G["JsbgList"..(i-1)], "TOPRIGHT", 0,-0);
			JsbgList:SetPoint("BOTTOMLEFT", _G["JsbgList"..(i-1)], "BOTTOMRIGHT", 0,-0);
		end
		JsbgList.line = JsbgList:CreateLine()
		JsbgList.line:SetColorTexture(0,1,1,0.4)
		JsbgList.line:SetThickness(1);
		if i~=5 then
			JsbgList.line:SetStartPoint("TOPRIGHT",0,20)
			JsbgList.line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		JsbgList.biaoti = JsbgList:CreateFontString();
		JsbgList.biaoti:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		JsbgList.biaoti:SetTextColor(1, 1, 0, 1);
		JsbgList.biaoti:SetPoint("BOTTOM", JsbgList, "TOP", -10,1);
		JsbgList.biaoti:SetText("#"..i);
		--
		JsbgList.tongzhi = CreateFrame("Button",nil,JsbgList, "TruncatedButtonTemplate",i);  
		JsbgList.tongzhi:SetSize(20,20);
		JsbgList.tongzhi:SetPoint("LEFT",JsbgList.biaoti,"RIGHT",2,0);
		JsbgList.tongzhi.Tex = JsbgList.tongzhi:CreateTexture(nil, "BORDER");
		JsbgList.tongzhi.Tex:SetTexture(130979);
		JsbgList.tongzhi.Tex:SetPoint("CENTER");
		JsbgList.tongzhi.Tex:SetSize(20,20);
		JsbgList.tongzhi:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER", 1.2,-1.2);
		end);
		JsbgList.tongzhi:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		JsbgList.heji = JsbgList:CreateFontString();
		JsbgList.heji:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		JsbgList.heji:SetTextColor(0, 1, 0, 1);
		JsbgList.heji:SetPoint("LEFT", JsbgList.tongzhi, "RIGHT", 0,0);
		---EXP
		JsbgList.EXP = JsbgList:CreateFontString();
		JsbgList.EXP:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		JsbgList.EXP:SetTextColor(1, 1, 0, 1);
		JsbgList.EXP:SetPoint("TOPLEFT", JsbgList, "TOPLEFT", 2,0);
		JsbgList.EXP:SetText("EXP");
		JsbgList.EXP_v = JsbgList:CreateFontString();
		JsbgList.EXP_v:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		JsbgList.EXP_v:SetTextColor(0, 1, 0, 1);
		JsbgList.EXP_v:SetPoint("LEFT", JsbgList.EXP, "RIGHT", 0,0);
		---声望
		JsbgList.SW = JsbgList:CreateFontString();
		JsbgList.SW:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		JsbgList.SW:SetTextColor(1, 1, 0, 1);
		JsbgList.SW:SetPoint("TOPLEFT", JsbgList.EXP, "BOTTOMLEFT", 0,0);
		JsbgList.SW:SetText("声望");
		JsbgList.SW_v = JsbgList:CreateFontString();
		JsbgList.SW_v:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		JsbgList.SW_v:SetTextColor(0, 1, 0, 1);
		JsbgList.SW_v:SetPoint("LEFT", JsbgList.SW, "RIGHT", 0,0);
		--
		for ii=1,mingxizhanshihangshu do
			local jsbgmx = CreateFrame("Frame", "JsbgList_MX_"..i.."_"..ii, JsbgList);
			jsbgmx:SetSize(fenxiW/5,jsbgmxH);
			if ii==1 then
				jsbgmx:SetPoint("TOP", JsbgList, "TOP", 0,-30);
			else
				jsbgmx:SetPoint("TOP", _G["JsbgList_MX_"..i.."_"..(ii-1)], "BOTTOM", 0,0);
			end
			jsbgmx:Hide()
			jsbgmx.line = jsbgmx:CreateLine()
			if ii==1 then
				jsbgmx.line:SetColorTexture(0,1,1,0.4)
			else
				jsbgmx.line:SetColorTexture(0,1,1,0.2)
			end
			jsbgmx.line:SetThickness(1);
			jsbgmx.line:SetStartPoint("TOPLEFT",0,1)
			jsbgmx.line:SetEndPoint("TOPRIGHT",0,1)
			jsbgmx.NPC = jsbgmx:CreateFontString();
			jsbgmx.NPC:SetPoint("LEFT", jsbgmx, "LEFT", 2,-0);
			jsbgmx.NPC:SetSize(fenxiW/5*0.8,jsbgmxH);
			jsbgmx.NPC:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
			jsbgmx.NPC:SetJustifyH("LEFT");
			jsbgmx.NPC:SetTextColor(1, 0.5, 0, 1);
			jsbgmx.NUM = jsbgmx:CreateFontString();
			jsbgmx.NUM:SetPoint("LEFT", jsbgmx.NPC, "RIGHT", 2,-0);
			jsbgmx.NUM:SetSize(fenxiW/5*0.16,jsbgmxH);
			jsbgmx.NUM:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
			jsbgmx.NUM:SetJustifyH("LEFT");
			jsbgmx.NUM:SetTextColor(0, 1, 0, 1);
		end
	end
	jishaBGF:SetScript("OnShow", function(self)	
		Update_jishamingxi()
	end)
	--帮助提示
	daiben.TimeF.tishi = CreateFrame("Frame", nil, daiben.TimeF);
	daiben.TimeF.tishi:SetSize(cishuHH,cishuHH);
	daiben.TimeF.tishi:SetPoint("TOPRIGHT", daiben.TimeF.timexian2, "TOPRIGHT", -1,-1);
	daiben.TimeF.tishi.Texture = daiben.TimeF.tishi:CreateTexture(nil, "BORDER");
	daiben.TimeF.tishi.Texture:SetTexture("interface/common/help-i.blp");
	daiben.TimeF.tishi.Texture:SetSize(cishuHH+6,cishuHH+6);
	daiben.TimeF.tishi.Texture:SetPoint("CENTER", daiben.TimeF.tishi, "CENTER", -1,-1);
	daiben.TimeF.tishi:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("提示：")
		GameTooltip:AddLine(
			"|cff00ff001、进/出/重置副本会记录当时时间.|r\n"..
			"|cff00ff002、下线超过1小时本次刷本次数将会清零。|r\n"..
			"|cffffff00作者也不清楚爆本计算是以什么时间为准，\n所以均有倒计时，请自行判断。|r")
		GameTooltip:Show();
	end);
	daiben.TimeF.tishi:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	--修改单价优惠栏UI-------------
	daiben.JizhangF.youhuie = CreateFrame("Frame", nil, daiben.JizhangF,"BackdropTemplate");
	daiben.JizhangF.youhuie:SetBackdrop({
		bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
		tile = true, tileSize = 0, edgeSize = 6});
	daiben.JizhangF.youhuie:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
	daiben.JizhangF.youhuie:SetSize(200,164);
	daiben.JizhangF.youhuie:SetPoint("TOPRIGHT",daiben.JizhangF,"TOPLEFT",-2,-0);
	daiben.JizhangF.youhuie:EnableMouse(true);
	daiben.JizhangF.youhuie:Hide();
	daiben.JizhangF.youhuie.T0 = daiben.JizhangF.youhuie:CreateFontString();
	daiben.JizhangF.youhuie.T0:SetPoint("TOP", daiben.JizhangF.youhuie, "TOP", 0,-10);
	daiben.JizhangF.youhuie.T0:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
	daiben.JizhangF.youhuie.T1 = daiben.JizhangF.youhuie:CreateFontString();
	daiben.JizhangF.youhuie.T1:SetPoint("TOP", daiben.JizhangF.youhuie.T0, "BOTTOM", 0,-10);
	daiben.JizhangF.youhuie.T1:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	daiben.JizhangF.youhuie.E = CreateFrame('EditBox', nil, daiben.JizhangF.youhuie,"InputBoxInstructionsTemplate");
	daiben.JizhangF.youhuie.E:SetSize(60,30);
	daiben.JizhangF.youhuie.E:SetPoint("TOP",daiben.JizhangF.youhuie.T1,"BOTTOM",0,-16);
	daiben.JizhangF.youhuie.E:SetFontObject(ChatFontNormal);
	daiben.JizhangF.youhuie.E:SetAutoFocus(false);
	daiben.JizhangF.youhuie.E:SetMaxLetters(6)
	daiben.JizhangF.youhuie.E:SetJustifyH("CENTER");
	daiben.JizhangF.youhuie.E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
		daiben.JizhangF.youhuie:Hide();
	end);
	local function zhixingxiugaiYeyh(bianji_wanjia,bianji_ID,self)
		local shujuyaunX = PIG_Per.daiben.Namelist
		for x=1, #shujuyaunX,1 do
			if shujuyaunX[x][2]==bianji_wanjia then
				shujuyaunX[x][bianji_ID]=self:GetNumber();
				break
			end
		end
		daiben.JizhangF.youhuie:Hide();
		Update_jizhangData()
	end
	daiben.JizhangF.youhuie.E:SetScript("OnEnterPressed", function(self)
		local fukj = self:GetParent()
		local bianji_ID = fukj.bianjiID
		local bianji_wanjia = fukj.T0:GetText()
		zhixingxiugaiYeyh(bianji_wanjia,bianji_ID,self)
	end);
	--修改优惠取消按钮
	daiben.JizhangF.youhuie.NO = CreateFrame("Button",nil,daiben.JizhangF.youhuie, "UIPanelButtonTemplate");  
	daiben.JizhangF.youhuie.NO:SetSize(48,20);
	daiben.JizhangF.youhuie.NO:SetPoint("BOTTOM",daiben.JizhangF.youhuie,"BOTTOM",40,16);
	daiben.JizhangF.youhuie.NO:SetText("取消");
	daiben.JizhangF.youhuie.NO:SetScript("OnClick", function (self)
		daiben.JizhangF.youhuie:Hide();
	end);
	--修改优惠确定按钮
	daiben.JizhangF.youhuie.YES = CreateFrame("Button",nil,daiben.JizhangF.youhuie, "UIPanelButtonTemplate");  
	daiben.JizhangF.youhuie.YES:SetSize(48,20);
	daiben.JizhangF.youhuie.YES:SetPoint("BOTTOM",daiben.JizhangF.youhuie,"BOTTOM",-40,16);
	daiben.JizhangF.youhuie.YES:SetText("确定");
	daiben.JizhangF.youhuie.YES:SetScript("OnClick", function (self)
		local fukj = self:GetParent()
		local bianji_ID = fukj.bianjiID
		local bianji_wanjia = fukj.T0:GetText()
		zhixingxiugaiYeyh(bianji_wanjia,bianji_ID,fukj.E)
	end);
	---修改优惠/余额
	function daiben.Jizhang:Open_youhuiyue(self,caozuo,bianjiID)
		daiben.JizhangF.youhuie:ClearAllPoints();
		if daiben.JizhangF:GetLeft()<WowWidth then
			daiben.JizhangF.youhuie:SetPoint("TOPLEFT",daiben.JizhangF,"TOPRIGHT",2,0);
		else	
			daiben.JizhangF.youhuie:SetPoint("TOPRIGHT",daiben.JizhangF,"TOPLEFT",-2,0);
		end
		local fuji=self:GetParent().name
		local bianji_name=fuji.qm
		daiben.JizhangF.youhuie.T0:SetText(bianji_name);
		daiben.JizhangF.youhuie.T1:SetText(caozuo);
		daiben.JizhangF.youhuie.T0:SetTextColor(fuji.t:GetTextColor());
		local shujuyaunX = PIG_Per.daiben.Namelist
		for x=1, #shujuyaunX,1 do
			if shujuyaunX[x][2]==bianji_name then
				daiben.JizhangF.youhuie.E:SetText(shujuyaunX[x][bianjiID])
				break
			end
		end
		daiben.JizhangF.youhuie.bianjiID=bianjiID
		daiben.JizhangF.youhuie:Show();	
	end
	--播报余额
	function daiben:shoudongbobaoG()
		for id = 1, GetNumSubgroupMembers(), 1 do
			local fujiK=_G["jzhang_"..id]
			local wanjia=fujiK.name.t:GetText();
			local yue=fujiK.yue.t:GetText();
			local yuci=fujiK.yuci.t:GetText();
			if PIG_Per.daiben.HideYue then
				local wanjiayuciMSN =wanjia.." (剩余次数:"..yuci..")";
				SendChatMessage("[!Pig] "..wanjiayuciMSN, "PARTY", nil);
			else
				local wanjiayuciMSN =wanjia.." (余额:"..yue.."，剩余次数:"..yuci..")";
				SendChatMessage("[!Pig] "..wanjiayuciMSN, "PARTY", nil);
			end	
		end
	end
	-----更新收入/刷本数
	local function gengxinshouruG()
		local shangciTime=PIG_Per.daiben.Over_Time
		local DQTime=GetServerTime()
		local shouInfo = PIG_Per.daiben.Shouru
		local DQMoney= GetMoney();
		if shangciTime>0 and shouInfo>0 then
			if (DQTime-shangciTime)>3600 then
				PIG_Per.daiben.Shouru = DQMoney;
			end
		else
			PIG_Per.daiben.Shouru = DQMoney;
		end
		local shouruV = floor((DQMoney-PIG_Per.daiben.Shouru)/10000);
		daiben.JizhangF.shouru:SetText(shouruV.."G(总"..floor((DQMoney/10000)).."G)");
		local shuabenshuInfo = PIG_Per.daiben.shuabenshu
		if shuabenshuInfo>0 then
			if (DQTime-shangciTime)>3600 then
				PIG_Per.daiben.shuabenshu = 0;
				daiben.TimeF.cishu:SetText(0);
			else
				daiben.TimeF.cishu:SetText(shuabenshuInfo);
			end
		end
		PIG_Per.daiben.Over_Time = GetServerTime()
	end

	--========================================================
	--判断队伍状态
	local function gengxinDuiwuInfo()
		local duiwuD = PIG_Per.daiben.DuiwuNei
		if IsInGroup() then
			duiwuD[1]=true
			if UnitIsGroupLeader("player") then
				duiwuD[2]=true
			else
				duiwuD[2]=false
			end
		else
			duiwuD[1]=false
			duiwuD[2]=false
		end
	end
	local function ADD_NewCD(instancename)
		gengxinDuiwuInfo()
		PIG_Per.daiben.YijingCZ=false;
		--1进入时间2退出时间3重置时间4击杀数5副本名6经验7声望8击杀明细
		local NewInfo={GetServerTime(),nil,nil,0,instancename,0,{},{}}
		local timeData=PIG_Per.daiben.Timelist
		local timeDataNum = #timeData
		for i = timeDataNum, 1, -1 do
			if i>4 then
				trremove(timeData,i)
			end
		end
		PIG_Per.daiben.shuabenshu = PIG_Per.daiben.shuabenshu+1
		table.insert(timeData, 1, NewInfo);
		TimeInfo_Update()
	end
	--判断新旧CD
	local FarmRecordEventF = CreateFrame("Frame");
	local New_fubenMSG="这是|cff00ff00新的|r副本CD吗?"
	local function InstanceCD()
		local timeData1= PIG_Per.daiben.Timelist[1]
		local instancename, instanceType, difficultyID, difficultyName, maxPlayers = GetInstanceInfo()
		if instanceType=="none" then
			daiben.CZbutton:SetText(chongzhiTXT)
			FarmRecordEventF:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			FarmRecordEventF:UnregisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
			FarmRecordEventF:UnregisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
			if PIG_Per.daiben.FBneiYN then
				timeData1[2]=GetServerTime();
				PIG_Per.daiben.FBneiYN=false;
			end
		end
		if instanceType=="party" or instanceType=="raid" then
			daiben.CZbutton:SetText(jiuweiTXT)
			FarmRecordEventF:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			FarmRecordEventF:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
			FarmRecordEventF:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
			PIG_Per.daiben.FBneiYN=true;
			if not timeData1 then ADD_NewCD(instancename) return end
			if PIG_Per.daiben.YijingCZ then--有重置信息
				ADD_NewCD(instancename)
				return
			end
			---
			if instancename~=timeData1[5] then--不是同一副本
				ADD_NewCD(instancename)
				return
			end
			---
			if GetServerTime()-PIG_Per.daiben.Over_Time>1800 then--已过去半小时以上
				ADD_NewCD(instancename)
				return
			end
			--
			if timeData1[2] then
				if GetServerTime()-timeData1[2]>1800 then--出本时间大于半小时
					ADD_NewCD(instancename)
					return
				end
			end
			-----
			local duiwuD = PIG_Per.daiben.DuiwuNei
			if IsInGroup()==duiwuD[1] then
				if UnitIsGroupLeader("player")~=duiwuD[2] then
					StaticPopup_Show("NEW_FUBEN_RECORD",New_fubenMSG)
				end
			else
				StaticPopup_Show("NEW_FUBEN_RECORD",New_fubenMSG)
			end
		end
	end
	--是否新CD提示框
	StaticPopupDialogs["NEW_FUBEN_RECORD"] = {
		text = "|cff00FFFF!Pig"..GnName.."：|r\n%s",
		button1 = "是",
		button2 = "否",
		OnAccept = function(self, data)
			if data=="del" then
				local timeData=PIG_Per.daiben.Timelist
				table.remove(timeData,1);
				PIG_Per.daiben.shuabenshu = PIG_Per.daiben.shuabenshu-1
				TimeInfo_Update()
			else
				local instancename = GetInstanceInfo()
				ADD_NewCD(instancename)
			end
		end,
		OnCancel = function()
			gengxinDuiwuInfo()
		end,
		timeout = 60,
		whileDead = true,
		hideOnEscape = true,
	}
	local function DS_TimeInfo_Update()
		if PIG_Per.daiben.Open then
			if daiben.TimeF:IsVisible() then
				TimeInfo_Update()
			end
		end
		C_Timer.After(1,DS_TimeInfo_Update)
	end
	DS_TimeInfo_Update()
	---
	function daiben:shoudongbobaoEXP(timedata,duiyuan)
		local EXP_FACTION =""
		if duiyuan then EXP_FACTION =EXP_FACTION.."[!Pig] 上次副本" end
		local expV = timedata[6]
		if expV>0 then
			local zuidaXP = UnitXPMax("player")
			local dangqianXP = UnitXP("player")
			local haichazhi = zuidaXP-dangqianXP
			local baifenbi = math.ceil((haichazhi/expV)*10)/10
			EXP_FACTION=EXP_FACTION.."获得经验值为:"..expV..", 升级还差:"..haichazhi.."（"..baifenbi.."次）"
		end
		local shengwangV =timedata[7]
		for g=1,#shengwangV do
			if g==1 then
				EXP_FACTION=EXP_FACTION.."声望值:"..shengwangV[g][2].."("..shengwangV[g][1]..")"
			else
				EXP_FACTION=EXP_FACTION..";"..shengwangV[g][2].."("..shengwangV[g][1]..")"
			end
		end
		if EXP_FACTION ~="[!Pig] 上次副本" and EXP_FACTION ~="" then
			SendChatMessage(EXP_FACTION, "PARTY", nil);
		end
	end
	function daiben:daiben_bobao(timedata,CZZT)
		if timedata then
			if PIG_Per.daiben.CZ_timejisha then
				if timedata[1] and timedata[2] then
					local fubenhaoshi=timedata[2]-timedata[1]
					local fubenhaoshi=date("%M分%S秒", fubenhaoshi)
					SendChatMessage("[!Pig] 上次副本耗时"..fubenhaoshi.."总击杀数"..timedata[4].."。", "PARTY", nil);
				end	
			end
			if PIG_Per.daiben.CZ_expSw then
				daiben:shoudongbobaoEXP(timedata)
			end
		end
		if PIG_Per.daiben.CZ_yueyuci then
			daiben:shoudongbobaoG()
		end
		if CZZT=="正常" then
			SendChatMessage("[!Pig] {rt1}副本已重置，请进入副本{rt1}", "PARTY", nil);
		elseif CZZT=="非正常" then
			SendChatMessage("[!Pig] {rt1}副本已重置，请进入副本(副本内的请退出重进){rt1}", "PARTY", nil);
		end
	end
	function daiben:zhixingCZ(timedata)
		daiben.CZbutton:SetText(jiuweiTXT)
		PIG_Per.daiben.YijingCZ = true;
		shoudongkouqian()
		Update_jizhangData()
		if timedata then
			if not timedata[2] then timedata[2]=GetServerTime() end
			timedata[3]=GetServerTime();
		end
		TimeInfo_Update()
	end
	--===================
	C_Timer.After(4,gengxinshouruG)
	C_Timer.After(4,InstanceCD)
	--处理事件===================
	FarmRecordEventF:RegisterEvent("GROUP_ROSTER_UPDATE");
	FarmRecordEventF:RegisterEvent("PLAYER_MONEY");
	FarmRecordEventF:RegisterEvent("PLAYER_LEAVING_WORLD")
	FarmRecordEventF:RegisterEvent("PLAYER_ENTERING_WORLD");
	--FarmRecordEventF:RegisterEvent("CHAT_MSG_SAY");
	FarmRecordEventF:RegisterEvent("CHAT_MSG_SYSTEM");
	FarmRecordEventF:RegisterEvent("CHAT_MSG_PARTY_LEADER");
	FarmRecordEventF:RegisterEvent("CHAT_MSG_RAID_LEADER");
	FarmRecordEventF:RegisterEvent("CHAT_MSG_WHISPER");
	FarmRecordEventF:RegisterEvent("TRADE_SHOW");
	FarmRecordEventF:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED");
	FarmRecordEventF:RegisterEvent("TRADE_TARGET_ITEM_CHANGED");
	FarmRecordEventF:RegisterEvent("TRADE_MONEY_CHANGED");
	FarmRecordEventF:RegisterEvent("TRADE_ACCEPT_UPDATE");
	FarmRecordEventF:RegisterEvent("UI_INFO_MESSAGE");
	daiben.jiaoyiInfo={0,nil}
	daiben.CZjiange = 0 --重置间隔
	FarmRecordEventF:SetScript("OnEvent",function (self,event,arg1,arg2,_,_,arg5,_,_,_,_,_,_,arg12)
		--print(event)
		local function shuaxinjizhangInfo()
			local inInstance, instanceType = IsInInstance()
			if inInstance and instanceType=="party" or instanceType=="raid" then
				local jishadata = PIG_Per.daiben.Timelist[1][4]
				if jishadata and jishadata>1 then
					Update_jizhangData(nil,true)
				else
					Update_jizhangData()
				end
			else
				Update_jizhangData()
			end
		end
		if event=="GROUP_ROSTER_UPDATE" then
			C_Timer.After(1,shuaxinjizhangInfo)
		end
		if event=="PLAYER_MONEY" then
			gengxinshouruG()
		end
		if event=="PLAYER_LEAVING_WORLD" then 
			PIG_Per.daiben.Over_Time = GetServerTime()
		end
		if event=="PLAYER_ENTERING_WORLD" then
			C_Timer.After(1,Update_jizhangData)
			if arg1 or arg2 then
				--print("加载UI")
			else
				InstanceCD()
			end
		end
		--杀怪
		if event=="COMBAT_LOG_EVENT_UNFILTERED" then
			local Kill_guolv={
				510,--FS水元素
				2914,--蛇
				13321,--青蛙
				4076,--蟑螂
				721,--兔子
				4075,--老鼠
				2110,--黑老鼠
				3300,--蝰蛇
				6827,--海湾蟹
				12473,--奥金幼龙
				2678,--机械幼龙
				8615,--秘银幼龙
				17893,--博学者拜特
				10441,--瘟疫鼠
				10461,--瘟疫虫
				10536,--瘟疫蛆
				10383,--破碎的死尸
				10387,--复仇的幻影
				10955,--被召唤的水元素
				10408,--石翼石像鬼
				18179,--堕落新星图腾
				20208,--门努的治疗图腾
				31985,--腐蚀石肤图腾
				31981,--腐蚀地缚图腾
				10577,--STSM墓穴甲虫
				8477,--骷髅仆从
				8179,--zul治疗图腾
			}
			local Combat1,Combat2,Combat3,Combat4,Combat5,Combat6,Combat7,Combat8,Combat9= CombatLogGetCurrentEventInfo();
			-- local Combatlist={CombatLogGetCurrentEventInfo()}
			-- for k,v in pairs(Combatlist) do
			-- 	print(k,v)
			-- end
			--if Combat2=="UNIT_DIED" then--死亡
			if Combat2=="PARTY_KILL" then--击杀
				--Creature   -0-    976-          0-           11-          31146-  000136DF91"
				--[单位类型]  -0-   [服务器 ID]-   [实例 ID]-   [区域 UID]-   [ID]-   [生成 UID]
				local NPCclasses, _,_,_,_,NPCID = strsplit("-",Combat8);
				if NPCclasses=="Player" then--是玩家

				else--"Creature"--生物
					for i=1,#Kill_guolv do--不是小动物
						if tonumber(NPCID)==Kill_guolv[i] then return end
					end
					local data = PIG_Per.daiben.Timelist[1]
					data[4]=data[4]+1;
					local jisha = data[8]
					for j=1,#jisha do
						if jisha[j][1]==Combat9 then
							jisha[j][2]=jisha[j][2]+1;
							return
						end
					end
					table.insert(jisha, {Combat9,1});
				end
			end
		end
		if event=="CHAT_MSG_COMBAT_XP_GAIN" then
			local _, _, _, expVVV = arg1:find("(你获得了(.-)点经验值)");
			local _, _, _, waiexpVVV = arg1:find("(+(.-)点经验值)");
			if expVVV then
				local expVVV = tonumber(expVVV)
				PIG_Per.daiben.Timelist[1][6]=PIG_Per.daiben.Timelist[1][6]+expVVV
			end
			if waiexpVVV then
				local waiexpVVV = tonumber(waiexpVVV)
				PIG_Per.daiben.Timelist[1][6]=PIG_Per.daiben.Timelist[1][6]+waiexpVVV
			end
		end
		if event=="CHAT_MSG_COMBAT_FACTION_CHANGE" then
			local _, _, _, shengwangName = arg1:find("(你在(.+)中的声望)");
			local _, _, _, shengwangV = arg1:find("(声望值提高了(.+)点)");	
			if shengwangName and shengwangV then
				local V = tonumber(shengwangV)
				local SWdata = PIG_Per.daiben.Timelist[1][7]
				for i=1,#SWdata do
					if SWdata[i][1]==shengwangName then
						SWdata[i][2]=SWdata[i][2]+V
						return
					end
				end
				table.insert(SWdata,{shengwangName,V})
			end
		end
		---
		if event=="CHAT_MSG_SAY" or event=="CHAT_MSG_SYSTEM" then
			local ZCCZ = arg1:find("已被重置")
			local FZCCZ = arg1:find("无法重置")
			if ZCCZ or FZCCZ then
				if GetServerTime()-daiben.CZjiange>2 then
					local timedata = PIG_Per.daiben.Timelist[1]
					daiben:zhixingCZ(timedata)
					if ZCCZ then
						daiben:daiben_bobao(timedata,"正常")
					else
						daiben:daiben_bobao(timedata,"非正常")
					end
					daiben.CZjiange = GetServerTime()
				end
			end
		end
		if event=="CHAT_MSG_PARTY_LEADER" or event=="CHAT_MSG_RAID_LEADER" then
			if not UnitIsGroupLeader("player") then
				if PIG_Per.daiben.CZ_expSw then
					if (arg1:find("已被重置"))~=nil or (arg1:find("已重置"))~=nil or (arg1:find("reset"))~=nil then
						if GetServerTime()-daiben.CZjiange>2 then
							local timedata = PIG_Per.daiben.Timelist[1]
							daiben:zhixingCZ(timedata)
							daiben:shoudongbobaoEXP(timedata,true)
							daiben.CZjiange = GetServerTime()
						end
					end
				end
			end
		end

		if event=="CHAT_MSG_WHISPER" then
			if PIG_Per.daiben.autohuifu then
				local feizidonghuifu=arg1:find("[!Pig]", 1)
				if feizidonghuifu then return end
				--获取人数
				local zidonghuifuMSG = {}
				if IsInRaid() then
					zidonghuifuMSG.Dnum = GetNumGroupMembers()
					zidonghuifuMSG.Znum = 40
				else
					zidonghuifuMSG.Dnum = GetNumSubgroupMembers()
					zidonghuifuMSG.Znum = 4
				end
				--回复关键字
				local keylist = PIG_Per.daiben.autohuifu_key
				for i=1,#keylist do
					local keyYes=arg1:find(keylist[i], 1)
					if keyYes then
						if zidonghuifuMSG.Dnum<zidonghuifuMSG.Znum then
							zidonghuifuMSG.info="[!Pig]"..PIG_Per.daiben.autohuifu_NR..",尚有坑位:"..(zidonghuifuMSG.Znum-zidonghuifuMSG.Dnum);
							if PIG_Per.daiben.autohuifu_lv  and IsInGroup() then
								zidonghuifuMSG.info=zidonghuifuMSG.info..",队伍LV("..huoquduiwLV()..")"
							end
							if PIG_Per.daiben.autohuifu_danjia and PIG_Per.daiben.fubenName~="无" then
								zidonghuifuMSG.info=zidonghuifuMSG.info..","..huoquLVdanjia()
							end
							if PIG_Per.daiben.autohuifu_inv then
								zidonghuifuMSG.info=zidonghuifuMSG.info.."回复"..PIG_Per.daiben.autohuifu_invCMD.."进组";
							end
							SendChatMessage(zidonghuifuMSG.info, "WHISPER", nil, arg5);
						else
							SendChatMessage("[!Pig] 位置已满，感谢支持！", "WHISPER", nil, arg5);
						end
						break
					end
				end
				--自动邀请
				local isLeader = UnitIsGroupLeader("player");
				if isLeader or not IsInGroup() then
					local invkey=arg1:find(PIG_Per.daiben.autohuifu_invCMD, 1)
					if invkey then
						if zidonghuifuMSG.Dnum<zidonghuifuMSG.Znum then
							PIG_InviteUnit(arg5)
						else
							SendChatMessage("[!Pig] 位置已满，感谢支持！", "WHISPER", nil, arg5);
						end
					end
				end
				---
			end
		end
		--------
		if event=="TRADE_SHOW" then
			daiben.jiaoyiInfo[1]=0
			local Tradename = GetUnitName("NPC",true);
			local youSERVER = Tradename:find("-")
			if not youSERVER then Tradename=Tradename.."-"..zijirealm end
			daiben.jiaoyiInfo[2]=Tradename
		end
		if event=="TRADE_PLAYER_ITEM_CHANGED" or event=="TRADE_TARGET_ITEM_CHANGED" or event=="TRADE_ACCEPT_UPDATE" or event=="TRADE_MONEY_CHANGED" then
			daiben.jiaoyiInfo[1]=GetTargetTradeMoney();
		end
		if event=="UI_INFO_MESSAGE" then
			if arg2=="交易完成" then
				local wanjiList = PIG_Per.daiben.Namelist
				if realm=="" or realm==nil then realm=zijirealm end
				for g=1,#wanjiList,1 do
					if wanjiList[g][2]==daiben.jiaoyiInfo[2] then
						wanjiList[g][4]=wanjiList[g][4]+(daiben.jiaoyiInfo[1]/10000)
						Update_jizhangData()
						break
					end
				end
			end
		end
	end)
	----设置
	addonTable.ADD_settingUI()
end
--================================
local ADD_ModCheckbutton =addonTable.ADD_ModCheckbutton
local Tooltip = "一个方便带刷副本小功能。"
local Cfanwei,xulieID = -60, 5
local OptionsModF_daiben = ADD_ModCheckbutton(GnName,Tooltip,fuFrame,Cfanwei,xulieID)
---
local ADD_QuickButton=addonTable.ADD_QuickButton
local function ADD_QuickButton_daiben()
	local ckbut = OptionsModF_daiben.ADD
	if PIG_Per.daiben.AddBut then
		ckbut:SetChecked(true);
	end
	if PIG.QuickButton.Open and PIG_Per.daiben.Open then
		ckbut:Enable();
	else
		ckbut:Disable();
	end
	if PIG.QuickButton.Open and PIG_Per.daiben.Open and PIG_Per.daiben.AddBut then
		local QkBut = "QkBut_daiben"
		if _G[QkBut] then return end
		local Icon=134377
		local Tooltip = "点击-|cff00FFFF打开"..GnName.."|r"
		local QkBut=ADD_QuickButton(QkBut,Tooltip,Icon)
		QkBut.yunxingzhong = QkBut:CreateTexture(nil, "OVERLAY");
		QkBut.yunxingzhong:SetTexture("interface/common/indicator-green.blp");
		QkBut.yunxingzhong:SetSize(24,24);
		QkBut.yunxingzhong:SetPoint("TOPRIGHT",QkBut,"TOPRIGHT",1,1);
		if not PIG_Per.daiben.autohuifu or _G[GnUI]:IsShown() then
			QkBut.yunxingzhong:Hide()
		end
		QkBut:SetScript("OnClick", function(self,button)
			if _G[GnUI]:IsShown() then
				_G[GnUI]:Hide();
				if PIG_Per.daiben.autohuifu then
					self.yunxingzhong:Show()
				end
			else
				self.yunxingzhong:Hide()
				_G[GnUI]:SetFrameLevel(FrameLevel)
				_G[GnUI]:Show();
			end
		end);
	end
end
addonTable.ADD_QuickButton_daiben=ADD_QuickButton_daiben
---
OptionsModF_daiben:SetScript("OnClick", function (self)
	if self:GetChecked() then
		Options_Daibenzhushou:Enable();
		PIG_Per.daiben.Open=true;
		ADD_daibenUI()
	else
		Options_Daibenzhushou:Disable();
		PIG_Per.daiben.Open=false;
		Pig_Options_RLtishi_UI:Show();
	end
	ADD_QuickButton_daiben()
end);
OptionsModF_daiben.ADD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per.daiben.AddBut=true
		ADD_QuickButton_daiben()
	else
		PIG_Per.daiben.AddBut=false
		Pig_Options_RLtishi_UI:Show();
	end
end);
---重置位置
OptionsModF_daiben.CZPoint = CreateFrame("Button",nil,OptionsModF_daiben);
OptionsModF_daiben.CZPoint:SetSize(22,22);
OptionsModF_daiben.CZPoint:SetPoint("LEFT",OptionsModF_daiben.Text,"RIGHT",16,-1);
OptionsModF_daiben.CZPoint.highlight = OptionsModF_daiben.CZPoint:CreateTexture(nil, "HIGHLIGHT");
OptionsModF_daiben.CZPoint.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
OptionsModF_daiben.CZPoint.highlight:SetBlendMode("ADD")
OptionsModF_daiben.CZPoint.highlight:SetPoint("CENTER", OptionsModF_daiben.CZPoint, "CENTER", 0,0);
OptionsModF_daiben.CZPoint.highlight:SetSize(30,30);
OptionsModF_daiben.CZPoint.Normal = OptionsModF_daiben.CZPoint:CreateTexture(nil, "BORDER");
OptionsModF_daiben.CZPoint.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
OptionsModF_daiben.CZPoint.Normal:SetBlendMode("ADD")
OptionsModF_daiben.CZPoint.Normal:SetPoint("CENTER", OptionsModF_daiben.CZPoint, "CENTER", 0,0);
OptionsModF_daiben.CZPoint.Normal:SetSize(18,18);
OptionsModF_daiben.CZPoint:HookScript("OnMouseDown", function (self)
	self.Normal:SetPoint("CENTER", OptionsModF_daiben.CZPoint, "CENTER", -1.5,-1.5);
end);
OptionsModF_daiben.CZPoint:HookScript("OnMouseUp", function (self)
	self.Normal:SetPoint("CENTER", OptionsModF_daiben.CZPoint, "CENTER", 0,0);
end);
OptionsModF_daiben.CZPoint:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("|cff00ff00重置"..GnName.."的位置|r")
	GameTooltip:Show();
end);
OptionsModF_daiben.CZPoint:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
OptionsModF_daiben.CZPoint:SetScript("OnClick", function ()
	daiben_UI:ClearAllPoints();
	daiben_UI:SetPoint("CENTER",UIParent,"CENTER",0,0);
end)
--=====================================
addonTable.daiben = function()
	if PIG_Per.daiben.Open then
		OptionsModF_daiben:SetChecked(true);
		Options_Daibenzhushou:Enable();
		ADD_daibenUI()
	end
end