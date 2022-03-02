local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local sub = _G.string.sub
local fuFrame=Pig_Options_RF_TAB_10_UI
local FrameLevel=1
--===============================
local gongnengName = "带本助手";
--顶部菜单
Pig_OptionsUI.Daibenzhushou = CreateFrame("Button",nil,Pig_OptionsUI, "UIPanelButtonTemplate");  
Pig_OptionsUI.Daibenzhushou:SetSize(90,28);
Pig_OptionsUI.Daibenzhushou:SetPoint("TOPLEFT",Pig_OptionsUI,"TOPLEFT",30,-24);
Pig_OptionsUI.Daibenzhushou:SetText(gongnengName);
Pig_OptionsUI.Daibenzhushou:Disable();
Pig_OptionsUI.Daibenzhushou:SetMotionScriptsWhileDisabled(true)
Pig_OptionsUI.Daibenzhushou:SetScript("OnClick", function ()
	if daiben_UI:IsShown() then
		daiben_UI:Hide();
	else
		Pig_OptionsUI:Hide();
		daiben_UI:SetFrameLevel(FrameLevel);
		daiben_UI:Show();
	end
end);
Pig_OptionsUI.Daibenzhushou:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	if not self:IsEnabled() then
		GameTooltip:AddLine(gongnengName.."尚未启用，请在功能模块内启用")
	end
	GameTooltip:Show();
end);
Pig_OptionsUI.Daibenzhushou:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide()
end);
--===================================
--父框架
local Width,DHeight,biaotiH=350,28,26;
local JZ_Height,TIME_Height=164,140;
local daiben = CreateFrame("Frame", "daiben_UI", UIParent);
daiben:SetSize(Width,DHeight);
daiben:ClearAllPoints();
daiben:SetPoint("CENTER",UIParent,"CENTER",0,0);
daiben:SetMovable(true)
daiben:SetClampedToScreen(true)
daiben:EnableMouse(true);
daiben:Hide();
daiben:SetScript("OnShow", function()
	PIG_Per["FarmRecord"]["Show"]="ON" 
end);
daiben:SetScript("OnHide", function()
	PIG_Per["FarmRecord"]["Show"]="OFF" 
end);

--标题栏
daiben.biaoti = CreateFrame("Frame", nil, daiben);
daiben.biaoti:SetPoint("TOPLEFT",daiben,"TOPLEFT",0,0);
daiben.biaoti:SetPoint("BOTTOMRIGHT",daiben,"BOTTOMRIGHT",0,0);
--启动状态
daiben.yesno = CreateFrame("CheckButton",nil,daiben);  
daiben.yesno:SetSize(biaotiH,biaotiH);
daiben.yesno:SetPoint("LEFT", daiben.biaoti, "LEFT", 0, 0);
daiben.yesno.Tex = daiben.yesno:CreateTexture(nil, "BORDER");
daiben.yesno.Tex:SetTexture("interface/common/indicator-red.blp");
daiben.yesno.Tex:SetPoint("CENTER",daiben.yesno,"CENTER",0,-1.4);
daiben.yesno.Tex:SetSize(biaotiH,biaotiH);
daiben.yesno:SetScript("OnMouseDown", function (self)
	self.Tex:SetPoint("CENTER",-1.5,-2.5);
	GameTooltip:Hide() 
end);
daiben.yesno:SetScript("OnMouseUp", function (self)
	self.Tex:SetPoint("CENTER",0,-1.6);
end);
---
daiben.yesno:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	if self:GetChecked() then
		GameTooltip:AddLine("工作状态：|cff00ff00营业中|r")
		GameTooltip:AddLine("|cffff0000点击关闭自动回复/自动邀请\n"..
			"并取消车辆登记|r")
		GameTooltip:AddLine("|cff00ffff按住拖拽可移动位置|r")
	else
		GameTooltip:AddLine("工作状态：|cffff0000休息中|r")
		GameTooltip:AddLine("|cff00ff00点击启用自动回复/自动邀请\n"..
			"并登记车辆到车队（在时空之门功能查看车队）|r")
		GameTooltip:AddLine("|cff00ffff按住拖拽可移动位置|r")
	end
	GameTooltip:Show();
end);
daiben.yesno:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide()
end);
local function dakaishezhiUI()
	jizhang_Yue_bianji_UI:Hide();
	jizhang_Danjia_bianji_UI:Hide();
	daiben.hanren.bianjiHanhua.F:Hide();
	Daiben_shezhi_F_UI:ClearAllPoints();
	local WowWidth=(GetScreenWidth()-Width)/2;
	local WowHeight=GetScreenHeight()/2;
	if daiben_UI:GetLeft()<WowWidth then
		if daiben_UI:GetBottom()<WowHeight then
			Daiben_shezhi_F_UI:SetPoint("BOTTOMLEFT",daiben_UI,"BOTTOMRIGHT",2,-0);
		else
			Daiben_shezhi_F_UI:SetPoint("TOPLEFT",daiben_UI,"TOPRIGHT",2,-0);
		end
	else
		if daiben_UI:GetBottom()<WowHeight then
			Daiben_shezhi_F_UI:SetPoint("BOTTOMRIGHT",daiben_UI,"BOTTOMLEFT",-2,-0);
		else
			Daiben_shezhi_F_UI:SetPoint("TOPRIGHT",daiben_UI,"TOPLEFT",-2,-0);
		end
	end
	Daiben_shezhi_F_UI:Show();
end
daiben.yesno:SetScript("OnClick", function (self)
	if PIG_Per["FarmRecord"]["kaichemudidi"]=="无" then
		print("|cff00FFFF!Pig:|r|cffFFFF00请先选择所带副本。|r");
		self:SetChecked(false)
		dakaishezhiUI()
		return 
	end
	if self:GetChecked() then
		if PIG["RaidRecord"]["Kaiqi"]=="ON" and addonTable.RaidRecord_Invite_yaoqing==true then
			print("|cff00FFFF!Pig:|r|cffFFFF00开团助手自动邀请处于开启状态，请先关闭副本助手的自动邀请。|r");
			self:SetChecked(false)
		else
			PIG_Per["FarmRecord"]['autohuifu']="ON"
			self.Tex:SetTexture("interface/common/indicator-green.blp");
		end
	else
		PIG_Per["FarmRecord"]['autohuifu']="OFF"
		self.Tex:SetTexture("interface/common/indicator-red.blp");
	end
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	if self:GetChecked() then
		GameTooltip:AddLine("工作状态：|cff00ff00营业中|r")
		GameTooltip:AddLine("|cffff0000点击关闭自动回复/自动邀请\n"..
			"并取消车辆登记|r")
		GameTooltip:AddLine("|cff00ffff按住拖拽可移动位置|r")
	else
		GameTooltip:AddLine("工作状态：|cffff0000休息中|r")
		GameTooltip:AddLine("|cff00ff00点击启用自动回复/自动邀请\n"..
			"并登记车辆到车队（在时空之门功能查看车队）|r")
		GameTooltip:AddLine("|cff00ffff按住拖拽可移动位置|r")
	end
	GameTooltip:Show() 
end);
daiben.yesno:RegisterForDrag("LeftButton")
daiben.yesno:SetScript("OnDragStart",function()
	daiben:StartMoving()
end)
daiben.yesno:SetScript("OnDragStop",function()
	daiben:StopMovingOrSizing()
end)
--喊话
daiben.hanhuajiange =10;
daiben.xuanzhongpindaoshu =0;
daiben.hanhuadaojishi =0;
local pindaolist ={{"SAY","YELL","GUILD"},{"综合","寻求组队","大脚世界频道"}};
local pindaolist1 ={{"说","大喊","公会"},{"综合","寻求组队","大脚世界频道"}};
local suijizifu ={",",".","!",";","，","。","！","；"};
daiben.hanren = CreateFrame("Button",nil,daiben, "UIPanelButtonTemplate");  
daiben.hanren:SetSize(80,biaotiH-2);
daiben.hanren:SetPoint("LEFT",daiben.yesno,"RIGHT",10,0);
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
--根据等级计算单价
local function jisuandanjia(lv)
	if PIG_Per["FarmRecord"]["kaichemudidi"]~="无" then
		for id = 1, 4, 1 do
			if PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][1]~=0 then
				if lv>=PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][1] and lv<=PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][2] then
					return PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][3]
				end
			end
		end
	end
	return 0
end
addonTable.jisuandanjia=jisuandanjia

daiben.hanren:SetScript("OnClick", function (self)
	self:Disable();
	daiben.hanhuadaojishi=daiben.hanhuajiange*daiben.xuanzhongpindaoshu
	daiben.hanren:SetText("喊话("..daiben.hanhuadaojishi..")");
	hanhuadaojishiTime()
		local hanhuaneirong=PIG_Per["FarmRecord"]["hanhuaMSG"];
		if PIG_Per["FarmRecord"]['hanhuapindao_lv']=="ON" then
			local inGroup = IsInGroup("LE_PARTY_CATEGORY_HOME");
			if inGroup then
				local numSubgroupMembers = GetNumSubgroupMembers("LE_PARTY_CATEGORY_HOME")
				if numSubgroupMembers>0 and numSubgroupMembers<4 then
						hanhuaneirong=hanhuaneirong..",队伍LV(";
						for id=1,numSubgroupMembers do
								local dengjiKk = UnitLevel("Party"..id);
								if id==numSubgroupMembers then
									hanhuaneirong=hanhuaneirong..dengjiKk;
								else
									hanhuaneirong=hanhuaneirong..dengjiKk..",";
								end
						end
						hanhuaneirong=hanhuaneirong.."),"..(numSubgroupMembers+1).."="..4-numSubgroupMembers;
				end
			end
		end
		--
		if PIG_Per["FarmRecord"]["kaichemudidi"]~="无" then
			if PIG_Per["FarmRecord"]['hanhuapindao_lvdanjia']=="ON" then
				daiben.kaishiLV=nil
				daiben.jieshuLV=nil
				for id = 1, 4, 1 do
					local kaishi =PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][1]
					if kaishi~=0 then
						if daiben.kaishiLV==nil then
							daiben.kaishiLV=kaishi
						else
							if daiben.kaishiLV>kaishi then
								daiben.kaishiLV=kaishi
							end
						end
					end
					local jieshu =PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][2]
					if jieshu~=0 then
						if daiben.jieshuLV==nil then
							daiben.jieshuLV=jieshu
						else
							if daiben.jieshuLV<jieshu then
								daiben.jieshuLV=jieshu
							end
						end
					end
				end
				if daiben.kaishiLV and daiben.jieshuLV then
					daiben.danjiafanwei_jia={};
					daiben.danjiafanwei_LV={};

					for i=daiben.kaishiLV,daiben.jieshuLV,1 do
						local danjiashunxue=jisuandanjia(i);
						if i==daiben.kaishiLV then
							table.insert(daiben.danjiafanwei_jia, danjiashunxue);
							table.insert(daiben.danjiafanwei_LV, {i});
						else
							if daiben.danjiafanwei_jia[#daiben.danjiafanwei_jia]~=danjiashunxue then
								table.insert(daiben.danjiafanwei_jia, danjiashunxue);
								table.insert(daiben.danjiafanwei_LV, {i});
							else
								table.insert(daiben.danjiafanwei_LV[#daiben.danjiafanwei_jia], i);
							end
						end
					end

					for i=1,#daiben.danjiafanwei_jia do
						if daiben.danjiafanwei_jia[i]>0 then
							hanhuaneirong=hanhuaneirong.."<"..daiben.danjiafanwei_LV[i][1].."-"..daiben.danjiafanwei_LV[i][#daiben.danjiafanwei_LV[i]]..">"..daiben.danjiafanwei_jia[i].."G；";
						else
							hanhuaneirong=hanhuaneirong.."<"..daiben.danjiafanwei_LV[i][1].."-"..daiben.danjiafanwei_LV[i][#daiben.danjiafanwei_LV[i]]..">免费；";
						end
					end
				end	
			end
		end
		---
		for s=1,#pindaolist[1] do
			if PIG_Per["FarmRecord"]["hanhuapindao"][1][s] ==true then
				local suijishu=random(1, 8)
				hanhuaneirong1=hanhuaneirong..suijizifu[suijishu]
				SendChatMessage(hanhuaneirong1,pindaolist[1][s],nil)
			end
		end
		--
		local yijiarupindaolist ={};
		local channel1 = {GetChannelList()};
		for i=1,#channel1 do
			for ii=1,#pindaolist[2] do
				if PIG_Per["FarmRecord"]["hanhuapindao"][2][ii] ==true then
					if channel1[i]==pindaolist[2][ii] then
						table.insert(yijiarupindaolist,channel1[i-1]);
					end
				end
			end
		end
		for i=1,#yijiarupindaolist do
			local suijishu=random(1, 8)
			hanhuaneirong2=hanhuaneirong..suijizifu[suijishu]
			SendChatMessage(hanhuaneirong2,"CHANNEL",nil,yijiarupindaolist[i])
		end
end);
--喊话频道
daiben.hanren.xialai = CreateFrame("FRAME", "daiben.hanren.xialai_UI", daiben.hanren, "UIDropDownMenuTemplate")
daiben.hanren.xialai:SetPoint("LEFT",daiben.hanren,"RIGHT",-25,-3)
daiben.hanren.xialai.Left:Hide();
daiben.hanren.xialai.Middle:Hide();
daiben.hanren.xialai.Right:Hide();
UIDropDownMenu_SetWidth(daiben.hanren.xialai, 12)

local function daiben_hanhuaxialai_Up()
	daiben.xuanzhongpindaoshu =0;
	local info = UIDropDownMenu_CreateInfo()
	info.func = daiben.hanren.xialai.SetValue
	for i=1,#pindaolist do
		for ii=1,#pindaolist[i] do
			info.text, info.arg1, info.arg2 = pindaolist1[i][ii], pindaolist[i][ii],PIG_Per["FarmRecord"]["hanhuapindao"][i][ii];
		    info.checked=PIG_Per["FarmRecord"]["hanhuapindao"][i][ii]
		    if PIG_Per["FarmRecord"]["hanhuapindao"][i][ii]==true then
		    	daiben.xuanzhongpindaoshu =daiben.xuanzhongpindaoshu+1;
		    end
		    info.isNotRadio = true;
			UIDropDownMenu_AddButton(info)
		end
	end
end
function daiben.hanren.xialai:SetValue(pindaoNameV,pindaoNameVV)
	for x=1,#pindaolist do
		for xx=1,#pindaolist[x] do
			if pindaoNameV==pindaolist[x][xx] then
				if pindaoNameVV==true then
					PIG_Per["FarmRecord"]["hanhuapindao"][x][xx]=false
				elseif pindaoNameVV==false then
					PIG_Per["FarmRecord"]["hanhuapindao"][x][xx]=true
				end
			end
		end
	end
	daiben.xuanzhongpindaoshu =0;
	for x=1,#pindaolist do
		for xx=1,#pindaolist[x] do
			if PIG_Per["FarmRecord"]["hanhuapindao"][x][xx]==true then
				daiben.xuanzhongpindaoshu =daiben.xuanzhongpindaoshu+1;
			end
		end
	end
	CloseDropDownMenus();
end
--编辑内容
daiben.hanren.bianjiHanhua = CreateFrame("Button",nil,daiben.hanren, "TruncatedButtonTemplate");
daiben.hanren.bianjiHanhua:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
daiben.hanren.bianjiHanhua:SetSize(biaotiH-2,biaotiH-2);
daiben.hanren.bianjiHanhua:SetPoint("LEFT",daiben.hanren.xialai,"RIGHT",-20,3);
daiben.hanren.bianjiHanhua.Tex = daiben.hanren.bianjiHanhua:CreateTexture(nil, "BORDER");
daiben.hanren.bianjiHanhua.Tex:SetTexture("interface/buttons/ui-guildbutton-publicnote-up.blp");
daiben.hanren.bianjiHanhua.Tex:SetPoint("CENTER");
daiben.hanren.bianjiHanhua.Tex:SetSize(biaotiH-4,biaotiH-4);
---------
local bianjikuanghanhuaH = 130
daiben.hanren.bianjiHanhua.F = CreateFrame("Frame", "daiben_bianjiHanhua_F_UI", daiben.hanren.bianjiHanhua,"BackdropTemplate");
daiben.hanren.bianjiHanhua.F:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 0, edgeSize = 6,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
daiben.hanren.bianjiHanhua.F:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
daiben.hanren.bianjiHanhua.F:SetSize(daiben:GetWidth(),bianjikuanghanhuaH)
daiben.hanren.bianjiHanhua.F:Hide()
daiben.hanren.bianjiHanhua.F:EnableMouse(true);
tinsert(UISpecialFrames,"daiben_bianjiHanhua_F_UI");
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
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji = CreateFrame("CheckButton", nil, daiben.hanren.bianjiHanhua.F, "ChatConfigCheckButtonTemplate");
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji:SetSize(28,28);
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji:SetPoint("LEFT",daiben.hanren.bianjiHanhua.F.hanhuaneirong,"RIGHT",6,-1);
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji:SetHitRectInsets(0,-40,0,0);
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji.Text:SetText("喊话队伍等级");
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji.tooltip = "喊话内容附带现有队伍成员等级，坑位数。(只在队伍中且队伍成员大于1才会生效)";
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T = daiben.hanren.bianjiHanhua.F:CreateFontString("daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T_UI");
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetPoint("TOPRIGHT", daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF, "BOTTOMRIGHT", 0,0);
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetText("当前字符数:0");
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetTextColor(1, 1, 0, 1);
----
daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetScript("OnCursorChanged", function() 
	local bianji_W=daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:GetHeight()
	daiben.hanren.bianjiHanhua.F.hanhuaneirongFFF:SetHeight(bianji_W+12);
	if daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji:GetChecked() then
		if string.len(daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:GetText())>230 then
			daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetText("当前字符数:"..string.len(daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:GetText()).."可能无法发送")
			daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetTextColor(1, 0, 0, 1);
		else
			daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetText("当前字符数:"..string.len(daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:GetText()))
			daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetTextColor(1, 1, 0, 1);
		end
	else
		if string.len(daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:GetText())>250 then
			daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetText("当前字符数:"..string.len(daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:GetText()).."可能无法发送")
			daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetTextColor(1, 0, 0, 1);
		else
			daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji_T:SetText("当前字符数:"..string.len(daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:GetText()))
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
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E.YES:Show();
end);
daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetScript("OnEditFocusLost", function(self)
	PIG_Per["FarmRecord"]["hanhuaMSG"]=self:GetText();
	self:SetTextColor(1, 1, 1, 0.7);
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E.YES:Hide();
end);
daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per["FarmRecord"]['hanhuapindao_lv']="ON"
	else
		PIG_Per["FarmRecord"]['hanhuapindao_lv']="OFF"
	end
end);
daiben.hanren.bianjiHanhua.F.hanhuaneirong_LVdanjia = CreateFrame("CheckButton", nil, daiben.hanren.bianjiHanhua.F, "ChatConfigCheckButtonTemplate");
daiben.hanren.bianjiHanhua.F.hanhuaneirong_LVdanjia:SetSize(28,28);
daiben.hanren.bianjiHanhua.F.hanhuaneirong_LVdanjia:SetPoint("LEFT",daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji,"RIGHT",110,-1);
daiben.hanren.bianjiHanhua.F.hanhuaneirong_LVdanjia:SetHitRectInsets(0,-20,0,0);
daiben.hanren.bianjiHanhua.F.hanhuaneirong_LVdanjia.Text:SetText("喊话价格");
daiben.hanren.bianjiHanhua.F.hanhuaneirong_LVdanjia.tooltip = "喊话内容附带已设置的等级范围和单价";
daiben.hanren.bianjiHanhua.F.hanhuaneirong_LVdanjia:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per["FarmRecord"]['hanhuapindao_lvdanjia']="ON"
	else
		PIG_Per["FarmRecord"]['hanhuapindao_lvdanjia']="OFF"
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
	PIG_Per["FarmRecord"]["hanhuaMSG"]=guanjianV;
	ParentF:SetTextColor(1, 1, 1, 0.7);
end);
----------
daiben.hanren.bianjiHanhua:SetScript("OnMouseDown", function (self)
	self.Tex:SetPoint("CENTER",-1.5,-1.5);
end);
daiben.hanren.bianjiHanhua:SetScript("OnMouseUp", function (self)
	self.Tex:SetPoint("CENTER");
end);

local function bianjiHanhua_UIweizhi()
	if PIG_Per["FarmRecord"]['hanhuapindao_lv']=="ON" then
		daiben.hanren.bianjiHanhua.F.hanhuaneirong_dengji:SetChecked(true);
	end
	if PIG_Per["FarmRecord"]['hanhuapindao_lvdanjia']=="ON" then
		daiben.hanren.bianjiHanhua.F.hanhuaneirong_LVdanjia:SetChecked(true);
	end
	daiben.hanren.bianjiHanhua.F.hanhuaneirong_E:SetText(PIG_Per["FarmRecord"]["hanhuaMSG"])

	Daiben_shezhi_F_UI:Hide()
	jizhang_Yue_bianji_UI:Hide();
	jizhang_Danjia_bianji_UI:Hide();
	daiben.hanren.bianjiHanhua.F:ClearAllPoints();
	local WowWidth=(GetScreenWidth()-Width)/2;
	local WowHeight=GetScreenHeight()/2;
	if daiben_UI:GetLeft()<WowWidth then
		if daiben_UI:GetBottom()<WowHeight then
			daiben.hanren.bianjiHanhua.F:SetPoint("BOTTOMLEFT",daiben_UI,"BOTTOMRIGHT",2,-0);
		else
			daiben.hanren.bianjiHanhua.F:SetPoint("TOPLEFT",daiben_UI,"TOPRIGHT",2,-0);
		end
	else
		if daiben_UI:GetBottom()<WowHeight then
			daiben.hanren.bianjiHanhua.F:SetPoint("BOTTOMRIGHT",daiben_UI,"BOTTOMLEFT",-2,-0);
		else
			daiben.hanren.bianjiHanhua.F:SetPoint("TOPRIGHT",daiben_UI,"TOPLEFT",2,-0);
		end
	end
	daiben.hanren.bianjiHanhua.F:Show();
end
daiben.hanren.bianjiHanhua:SetScript("OnClick", function (self)
	if self.F:IsShown() then
		self.F:Hide()
	else
		bianjiHanhua_UIweizhi()
	end
end);
--重置就位
local jiuweiTXT,chongzhiTXT = "就位","重置"
daiben.CZbutton = CreateFrame("Button",nil,daiben, "UIPanelButtonTemplate");  
daiben.CZbutton:SetSize(56,biaotiH-2);
daiben.CZbutton:SetPoint("LEFT",daiben.hanren.bianjiHanhua,"RIGHT",14,0);
daiben.CZbutton:SetText(jiuweiTXT);
daiben.CZbutton:SetScript("OnClick", function (self,button)
		if button=="LeftButton" then
			if daiben.CZbutton:GetText()==jiuweiTXT then
				DoReadyCheck();
			elseif daiben.CZbutton:GetText()==chongzhiTXT then
				ResetInstances();
				if PIG_Per["FarmRecord"]["jiuweiqueren"]=="ON" then
					DoReadyCheck();
				end
			end
		else
			ResetInstances();
		end
end);
--队伍拾取方式
daiben.Loot = CreateFrame("Button",nil,daiben);
daiben.Loot:SetSize(30,biaotiH);
daiben.Loot:SetPoint("LEFT",daiben.CZbutton,"RIGHT",14,0);
daiben.Loot.t = daiben.Loot:CreateFontString("daiben_biaotiLOOTUI");
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
local daiben_biaotilootF = CreateFrame("Frame");
daiben_biaotilootF:RegisterEvent("PLAYER_ENTERING_WORLD");
daiben_biaotilootF:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
daiben_biaotilootF:RegisterEvent("GROUP_ROSTER_UPDATE");
daiben_biaotilootF:SetScript("OnEvent", function ()
	if IsInGroup()==true then 
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
end)

--展开计时面板----
local function dakaijishiUI()
	local WowHeight=GetScreenHeight()/2;
	jishiTimeUI:ClearAllPoints();
	if daiben:GetBottom()<WowHeight then
		if daiben.nr:IsShown() then
			jishiTimeUI:SetPoint("BOTTOMLEFT",daiben.nr,"TOPLEFT",0,2);
			jishiTimeUI:SetPoint("BOTTOMRIGHT",daiben.nr,"TOPRIGHT",0,2);
		else
			jishiTimeUI:SetPoint("BOTTOMLEFT",daiben,"TOPLEFT",0,0);
			jishiTimeUI:SetPoint("BOTTOMRIGHT",daiben,"TOPRIGHT",0,0);
		end
	else
		if daiben.nr:IsShown() then
			jishiTimeUI:SetPoint("TOPLEFT",daiben.nr,"BOTTOMLEFT",0,-2);
			jishiTimeUI:SetPoint("TOPRIGHT",daiben.nr,"BOTTOMRIGHT",0,-2);
		else
			jishiTimeUI:SetPoint("TOPLEFT",daiben,"BOTTOMLEFT",0,0);
			jishiTimeUI:SetPoint("TOPRIGHT",daiben,"BOTTOMRIGHT",0,0);
		end
	end
	jishiTimeUI:Show();
end

daiben.zhankaijishi = CreateFrame("Button",nil,daiben);
daiben.zhankaijishi:SetSize(biaotiH,biaotiH);
daiben.zhankaijishi:SetPoint("LEFT",daiben.Loot,"RIGHT",14,-0.6);
daiben.zhankaijishi.Texture = daiben.zhankaijishi:CreateTexture(nil, "BORDER");
daiben.zhankaijishi.Texture:SetTexture("interface/icons/inv_misc_pocketwatch_01.blp");
daiben.zhankaijishi.Texture:SetSize(biaotiH-8,biaotiH-8);
daiben.zhankaijishi.Texture:SetPoint("CENTER", daiben.zhankaijishi, "CENTER", 0,0);
daiben.zhankaijishi:HookScript("OnMouseDown", function (self)
	self.Texture:SetPoint("CENTER", daiben.zhankaijishi, "CENTER", -1.1,-1.1);
end);
daiben.zhankaijishi:HookScript("OnMouseUp", function (self)
	self.Texture:SetPoint("CENTER", daiben.zhankaijishi, "CENTER", 0,0);
end);
daiben.zhankaijishi:SetScript("OnClick", function (self)
	if jishiTimeUI:IsShown() then
		jishiTimeUI:Hide()
		PIG_Per["FarmRecord"]["Time_Show"]="ON"
	else
		PIG_Per["FarmRecord"]["Time_Show"]="OFF"
		dakaijishiUI()
	end
end)
--最小化/最大化
local function Show_ZX()
	daiben.Max_Min:SetNormalTexture("interface/chatframe/ui-chaticon-minimize-up.blp");
	daiben.Max_Min:SetPushedTexture("interface/chatframe/ui-chaticon-minimize-down.blp")
	local WowHeight=GetScreenHeight()/2;
	daiben.nr:ClearAllPoints();
	if daiben:GetBottom()<WowHeight then
		daiben.nr:SetPoint("BOTTOMLEFT",daiben,"TOPLEFT",0,0);
		daiben.nr:SetPoint("BOTTOMRIGHT",daiben,"TOPRIGHT",0,0);
		if PIG_Per["FarmRecord"]['bangdingUI']=="OFF" and jishiTimeUI:IsShown() then
			jishiTimeUI:SetPoint("BOTTOMLEFT",daiben.nr,"TOPLEFT",0,2);
			jishiTimeUI:SetPoint("BOTTOMRIGHT",daiben.nr,"TOPRIGHT",0,2);
		end
	else
		daiben.nr:SetPoint("TOPLEFT",daiben,"BOTTOMLEFT",0,0);
		daiben.nr:SetPoint("TOPRIGHT",daiben,"BOTTOMRIGHT",0,0);
		if PIG_Per["FarmRecord"]['bangdingUI']=="OFF" and jishiTimeUI:IsShown() then
			jishiTimeUI:SetPoint("TOPLEFT",daiben.nr,"BOTTOMLEFT",0,-2);
			jishiTimeUI:SetPoint("TOPRIGHT",daiben.nr,"BOTTOMRIGHT",0,-2);
		end
	end
	daiben.nr:Show();
	if PIG_Per["FarmRecord"]['bangdingUI']=="ON" then
		dakaijishiUI()
	end
end
local function dakaijizhangUI(chushi)
	local WowHeight=GetScreenHeight()/2;
	if daiben.nr:IsShown() then
		daiben.Max_Min:SetNormalTexture("interface/chatframe/ui-chaticon-maximize-up.blp");
		daiben.Max_Min:SetPushedTexture("interface/chatframe/ui-chaticon-maximize-down.blp")
		PIG_Per["FarmRecord"]["MaxMin"]="ON"
		daiben.nr:Hide();
		if PIG_Per["FarmRecord"]['bangdingUI']=="OFF" then
			if jishiTimeUI:IsShown() then
				jishiTimeUI:ClearAllPoints();
				if daiben:GetBottom()<WowHeight then
					jishiTimeUI:SetPoint("BOTTOMLEFT",daiben,"TOPLEFT",0,0);
					jishiTimeUI:SetPoint("BOTTOMRIGHT",daiben,"TOPRIGHT",0,0);
				else
					jishiTimeUI:SetPoint("TOPLEFT",daiben,"BOTTOMLEFT",0,0);
					jishiTimeUI:SetPoint("TOPRIGHT",daiben,"BOTTOMRIGHT",0,0);
				end
			end
		elseif PIG_Per["FarmRecord"]['bangdingUI']=="ON" then
			jishiTimeUI:Hide()
		end	
	else
		PIG_Per["FarmRecord"]["MaxMin"]="OFF"
		Show_ZX()	
	end
end
daiben.Max_Min = CreateFrame("Button",nil,daiben, "TruncatedButtonTemplate"); 
daiben.Max_Min:SetNormalTexture("interface/chatframe/ui-chaticon-maximize-up.blp");
daiben.Max_Min:SetPushedTexture("interface/chatframe/ui-chaticon-maximize-down.blp")
daiben.Max_Min:SetHighlightTexture("interface/buttons/ui-checkbox-highlight.blp");
daiben.Max_Min:SetSize(biaotiH,biaotiH);
daiben.Max_Min:SetPoint("LEFT", daiben.zhankaijishi, "RIGHT", 16, 0);
daiben.Max_Min:SetScript("OnClick", function (event, button)
	dakaijizhangUI()
end);

--=============带本记账================================================
daiben.nr = CreateFrame("Frame", nil, daiben,"BackdropTemplate");
daiben.nr:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 0, edgeSize = 6,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
daiben.nr:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
daiben.nr:SetHeight(JZ_Height)
daiben.nr:Hide()
--记账标题
daiben.nr.Biaoti1 = daiben.nr:CreateFontString();
daiben.nr.Biaoti1:SetPoint("TOPLEFT", daiben.nr, "TOPLEFT", 5,-3);
daiben.nr.Biaoti1:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
daiben.nr.Biaoti1:SetText("\124cffffff00LV\124r");
daiben.nr.Biaoti2 = daiben.nr:CreateFontString();
daiben.nr.Biaoti2:SetPoint("TOPLEFT", daiben.nr, "TOPLEFT", 30,-3);
daiben.nr.Biaoti2:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
daiben.nr.Biaoti2:SetText("\124cffffff00玩家\124r");
daiben.nr.Biaoti3 = daiben.nr:CreateFontString();
daiben.nr.Biaoti3:SetPoint("TOPLEFT", daiben.nr, "TOPLEFT", 126,-3);
daiben.nr.Biaoti3:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
daiben.nr.Biaoti3:SetText("\124cffffff00单价\124cffFF69B4(优惠)\124r");
daiben.nr.Biaoti4 = daiben.nr:CreateFontString();
daiben.nr.Biaoti4:SetPoint("TOPLEFT", daiben.nr, "TOPLEFT", 200,-3);
daiben.nr.Biaoti4:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
daiben.nr.Biaoti4:SetText("\124cffffff00余额\124r");
daiben.nr.Biaoti5 = daiben.nr:CreateFontString();
daiben.nr.Biaoti5:SetPoint("TOPLEFT", daiben.nr, "TOPLEFT", 260,-3);
daiben.nr.Biaoti5:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
daiben.nr.Biaoti5:SetText("\124cffffff00余次\124r");
daiben.nr.Biaoti6 = daiben.nr:CreateFontString();
daiben.nr.Biaoti6:SetPoint("TOPLEFT", daiben.nr, "TOPLEFT", 306,-3);
daiben.nr.Biaoti6:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
daiben.nr.Biaoti6:SetText("\124cffffff00已带\124r");

--扣款
local function shoudongkouqian()
	local numSubgroupMembers = GetNumSubgroupMembers("LE_PARTY_CATEGORY_HOME")
	for id = 1, numSubgroupMembers, 1 do
		local wanjia= UnitFullName("Party"..id);
		for x=1, #PIG_Per["FarmRecord"]["namelist"],1 do
			if PIG_Per["FarmRecord"]["namelist"][x][1]==wanjia then
				PIG_Per["FarmRecord"]["namelist"][x][4]=PIG_Per["FarmRecord"]["namelist"][x][4]-(PIG_Per["FarmRecord"]["namelist"][x][9]-PIG_Per["FarmRecord"]["namelist"][x][3])
				PIG_Per["FarmRecord"]["namelist"][x][5]=PIG_Per["FarmRecord"]["namelist"][x][5]+1;
			end
		end
	end
end
--加钱
local function shoudongjiaqian()
	local numSubgroupMembers = GetNumSubgroupMembers("LE_PARTY_CATEGORY_HOME")
	for id = 1, numSubgroupMembers, 1 do
		local wanjia= UnitFullName("Party"..id);
		for x=1, #PIG_Per["FarmRecord"]["namelist"],1 do
			if PIG_Per["FarmRecord"]["namelist"][x][1]==wanjia then
				PIG_Per["FarmRecord"]["namelist"][x][4]=PIG_Per["FarmRecord"]["namelist"][x][4]+(PIG_Per["FarmRecord"]["namelist"][x][9]-PIG_Per["FarmRecord"]["namelist"][x][3])
				--PIG_Per["FarmRecord"]["namelist"][x][5]=PIG_Per["FarmRecord"]["namelist"][x][5]-1;
			end
		end
	end
end
--播报
local function shoudongbobao()
	for id = 1, GetNumSubgroupMembers("LE_PARTY_CATEGORY_HOME"), 1 do
		local wanjia=_G["jizhang_Name"..id.."_UI"]:GetText()
		local yue=_G["jizhang_Yue"..id.."_UI"]:GetText()
		local yuxiacishu=_G["jizhang_Yuci"..id.."_UI"]:GetText()
		if PIG_Per["FarmRecord"]["bobaoyue"] then
			local wanjiayuciMSN =wanjia.." (余额:"..yue.."，剩余次数:"..yuxiacishu..")";
			SendChatMessage("[!Pig] "..wanjiayuciMSN, "PARTY", nil);
		else
			local wanjiayuciMSN =wanjia.." (剩余次数:"..yuxiacishu..")";
			SendChatMessage("[!Pig] "..wanjiayuciMSN, "PARTY", nil);
		end	
	end
end
--更新记账面板
local function gengxinjizhangData(laiyuan)
	for x = #PIG_Per["FarmRecord"]["namelist"], 1, -1 do
		if GetServerTime()-PIG_Per["FarmRecord"]["namelist"][x][2]>86400 then
			table.remove(PIG_Per["FarmRecord"]["namelist"],x);
		end
	end
	for id = 1, MAX_PARTY_MEMBERS, 1 do
		_G["jizhang_lv"..id.."_UI"]:SetText();
		_G["jizhang_Name"..id.."_UI"]:SetText();
		_G["jizhang_Danjia_F"..id.."_UI"]:Hide();
		_G["jizhang_Danjia"..id.."_UI"]:SetText();
		_G["jizhang_Yue_F"..id.."_UI"]:Hide();
		_G["jizhang_Yue"..id.."_UI"]:SetText();
		_G["jizhang_Yuci"..id.."_UI"]:SetText();
		_G["jizhang_Yidaici"..id.."_UI"]:SetText();
	end
	local numSubgroupMembers = GetNumSubgroupMembers("LE_PARTY_CATEGORY_HOME")
	for id = 1, numSubgroupMembers, 1 do
		local wanjia, realm = UnitFullName("Party"..id);
		if wanjia~=nil and wanjia~="未知目标" then
			_G["jizhang_Danjia_F"..id.."_UI"]:Show();
			_G["jizhang_Yue_F"..id.."_UI"]:Show();
			local className, classFilename, classId = UnitClass("Party"..id);
			local rPerc, gPerc, bPerc, argbHex = GetClassColor(classFilename);
			_G["jizhang_Name"..id.."_UI"]:SetTextColor(rPerc, gPerc, bPerc, 1);
			_G["jizhang_Name"..id.."_UI"]:SetText(wanjia);
			--创建玩家信息
			local wanjaixinxi={wanjia,GetServerTime(),0,0,0,1,0,nameserver,0};--1名/2时间/3优惠/4余额/5已带次/6级别/7退款状态/8名称+服务器/9单价
			local LVNEW=UnitLevel("Party"..id);
			if LVNEW then
				wanjaixinxi[6] = LVNEW;
			end
			_G["jizhang_lv"..id.."_UI"]:SetText(wanjaixinxi[6]);
			wanjaixinxi[8] = GetUnitName("Party"..id, true)
			
			local wanjiashitouyihuancun=true;
			for x=1, #PIG_Per["FarmRecord"]["namelist"],1 do
				if PIG_Per["FarmRecord"]["namelist"][x][1]==wanjia then---如果存在拉取信息
					wanjiashitouyihuancun=false;
					PIG_Per["FarmRecord"]["namelist"][x][2]=GetServerTime()
					wanjaixinxi[3]=PIG_Per["FarmRecord"]["namelist"][x][3];
					wanjaixinxi[4]=PIG_Per["FarmRecord"]["namelist"][x][4];
					wanjaixinxi[5]=PIG_Per["FarmRecord"]["namelist"][x][5];
					wanjaixinxi[9]=PIG_Per["FarmRecord"]["namelist"][x][9];
					if laiyuan=="shezhi" then--来自设置的刷新
						wanjaixinxi[9]=jisuandanjia(wanjaixinxi[6])
						PIG_Per["FarmRecord"]["namelist"][x][9]=wanjaixinxi[9]
					elseif laiyuan=="CZ" then--来自重置的刷新
						if PIG_Per["FarmRecord"]["yuedanjiasuoding"] then--锁定单价
							if wanjaixinxi[4]<=0 then--余额小于等于0
								wanjaixinxi[9]=jisuandanjia(wanjaixinxi[6])
								PIG_Per["FarmRecord"]["namelist"][x][9]=wanjaixinxi[9]
							end
						else
							wanjaixinxi[9]=jisuandanjia(wanjaixinxi[6])
							PIG_Per["FarmRecord"]["namelist"][x][9]=wanjaixinxi[9]
						end
					end
					break
				end
			end
			if wanjiashitouyihuancun then
				wanjaixinxi[9]=jisuandanjia(wanjaixinxi[6])
				table.insert(PIG_Per["FarmRecord"]["namelist"],wanjaixinxi);
			end
			_G["jizhang_Danjia"..id.."_UI"]:SetText(wanjaixinxi[9]);
			_G["jizhang_Danjia_YH"..id.."_UI"]:SetText("("..wanjaixinxi[3]..")");
			_G["jizhang_Yue"..id.."_UI"]:SetText(floor(wanjaixinxi[4]));
			---
			if (wanjaixinxi[9]-wanjaixinxi[3])>0 then
				_G["jizhang_Yuci"..id.."_UI"]:SetText(floor(wanjaixinxi[4]/(wanjaixinxi[9]-wanjaixinxi[3])));
			else
				_G["jizhang_Yuci"..id.."_UI"]:SetText("免费");
			end
			_G["jizhang_Yidaici"..id.."_UI"]:SetText(wanjaixinxi[5]);
		end
	end
end
addonTable.FarmRecord_gengxinjizhangData = gengxinjizhangData
--////内容框架///////////////
for id = 1, MAX_PARTY_MEMBERS, 1 do
	local jizhang_hang = CreateFrame("Frame", "jizhang_hang"..id.."_UI", daiben.nr);
	jizhang_hang:SetSize(Width-2,23);
	if id==1 then
		jizhang_hang:SetPoint("TOP", daiben.nr, "TOP", 0,-22);
	else
		jizhang_hang:SetPoint("TOP", _G["jizhang_hang"..(id-1).."_UI"], "BOTTOM", 0,-0);
	end
	local jizhang_hang_line = jizhang_hang:CreateLine("jizhang_hang_line_"..id.."_UI")
	jizhang_hang_line:SetColorTexture(1,1,1,0.2)
	jizhang_hang_line:SetThickness(1);
	jizhang_hang_line:SetStartPoint("TOPLEFT",0,-0.2)
	jizhang_hang_line:SetEndPoint("TOPRIGHT",0,-0.2)
	--
	local jizhang_lv_F = CreateFrame("Frame", "jizhang_lv_F"..id.."_UI", jizhang_hang);
	jizhang_lv_F:SetSize(22,16);
	jizhang_lv_F:SetPoint("LEFT", jizhang_hang, "LEFT", 2,-0);
	local jizhang_lv = jizhang_lv_F:CreateFontString("jizhang_lv"..id.."_UI");	
	jizhang_lv:SetHeight(16);
	jizhang_lv:SetPoint("LEFT", jizhang_lv_F, "LEFT", 4,-0);
	jizhang_lv:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	jizhang_lv:SetTextColor(0, 1, 0, 1);

	local jizhang_Name = jizhang_hang:CreateFontString("jizhang_Name"..id.."_UI");
	jizhang_Name:SetHeight(16);
	jizhang_Name:SetPoint("LEFT", jizhang_hang, "LEFT", 30,-0);
	jizhang_Name:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	-------
	local jizhang_Danjia_F = CreateFrame("Frame", "jizhang_Danjia_F"..id.."_UI", jizhang_hang);
	jizhang_Danjia_F:SetSize(54,16);
	jizhang_Danjia_F:SetPoint("LEFT", jizhang_hang, "LEFT", 130,-0);
	_G["jizhang_Danjia_F"..id.."_UI"]:SetScript("OnMouseUp", function (self,button)
		if button=="LeftButton" then
			if jizhang_Danjia_bianji_UI:IsShown() then
				jizhang_Danjia_bianji_UI:Hide();
			else
				Daiben_shezhi_F_UI:Hide()
				jizhang_Yue_bianji_UI:Hide();
				daiben.hanren.bianjiHanhua.F:Hide();
				jizhang_Danjia_bianji_UI:Show();
				jizhang_Danjia_bianji_UI:ClearAllPoints();
				local WowWidth=(GetScreenWidth()-Width)/2;
				if daiben_UI:GetLeft()<WowWidth then
					jizhang_Danjia_bianji_UI:SetPoint("TOPLEFT",daiben_UI.nr,"TOPRIGHT",2,-0);
				else	
					jizhang_Danjia_bianji_UI:SetPoint("TOPRIGHT",daiben_UI.nr,"TOPLEFT",2,-0);
				end
				local bianji_name=_G["jizhang_Name"..id.."_UI"]:GetText()
				jizhang_Danjia_bianji_UI.T0:SetText(bianji_name);
				jizhang_Danjia_bianji_UI.T0:SetTextColor(_G["jizhang_Name"..id.."_UI"]:GetTextColor());
				for x=1, #PIG_Per["FarmRecord"]["namelist"],1 do
					if PIG_Per["FarmRecord"]["namelist"][x][1]==bianji_name then
						jizhang_Danjia_bianji_UI.E:SetText(PIG_Per["FarmRecord"]["namelist"][x][3])
						jizhang_Danjia_bianji_UI.T4:SetText(PIG_Per["FarmRecord"]["namelist"][x][9]-PIG_Per["FarmRecord"]["namelist"][x][3]);
					end
				end			
			end
		else
			local wanjia= UnitFullName("Party"..id);
			for x=1, #PIG_Per["FarmRecord"]["namelist"],1 do
				if PIG_Per["FarmRecord"]["namelist"][x][1]==wanjia then
					PIG_Per["FarmRecord"]["namelist"][x][9]=jisuandanjia(UnitLevel("Party"..id))
				end
			end
			gengxinjizhangData();
		end
	end);
	local jizhang_Danjia = jizhang_Danjia_F:CreateFontString("jizhang_Danjia"..id.."_UI");
	jizhang_Danjia:SetPoint("LEFT", jizhang_Danjia_F, "LEFT", 0,0);
	jizhang_Danjia:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	jizhang_Danjia:SetTextColor(0, 1, 0, 1);
	local jizhang_Danjia_YH = jizhang_Danjia_F:CreateFontString("jizhang_Danjia_YH"..id.."_UI");
	jizhang_Danjia_YH:SetPoint("LEFT", jizhang_Danjia, "RIGHT", 0,0);
	jizhang_Danjia_YH:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	jizhang_Danjia_YH:SetTextColor(1, 105/255,180/255, 1);
	---------
	local jizhang_Yue_F = CreateFrame("Frame", "jizhang_Yue_F"..id.."_UI", jizhang_hang);
	jizhang_Yue_F:SetSize(54,16);
	jizhang_Yue_F:SetPoint("LEFT", jizhang_hang, "LEFT", 202,-0);
	_G["jizhang_Yue_F"..id.."_UI"]:SetScript("OnMouseUp", function ()
		if jizhang_Yue_bianji_UI:IsShown() then
			jizhang_Yue_bianji_UI:Hide();
		else
			Daiben_shezhi_F_UI:Hide()
			jizhang_Danjia_bianji_UI:Hide();
			daiben.hanren.bianjiHanhua.F:Hide();
			jizhang_Yue_bianji_UI:Show();
			jizhang_Yue_bianji_UI:ClearAllPoints();
			local WowWidth=(GetScreenWidth()-Width)/2;
			if daiben_UI:GetLeft()<WowWidth then
				jizhang_Yue_bianji_UI:SetPoint("TOPLEFT",daiben_UI.nr,"TOPRIGHT",2,-0);
			else	
				jizhang_Yue_bianji_UI:SetPoint("TOPRIGHT",daiben_UI.nr,"TOPLEFT",2,-0);
			end
			local bianji_name=_G["jizhang_Name"..id.."_UI"]:GetText()
			jizhang_Yue_bianji_UI.T0:SetText(bianji_name);
			jizhang_Yue_bianji_UI.T0:SetTextColor(_G["jizhang_Name"..id.."_UI"]:GetTextColor());
			for x=1, #PIG_Per["FarmRecord"]["namelist"],1 do
				if PIG_Per["FarmRecord"]["namelist"][x][1]==bianji_name then
					jizhang_Yue_bianji_UI.E:SetText(PIG_Per["FarmRecord"]["namelist"][x][4])
				end
			end
		end
	end);
	local jizhang_Yue = jizhang_Yue_F:CreateFontString("jizhang_Yue"..id.."_UI");
	jizhang_Yue:SetPoint("LEFT", jizhang_Yue_F, "LEFT", 0,0);
	jizhang_Yue:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	jizhang_Yue:SetTextColor(0, 1, 0, 1);
	-------	
	local jizhang_Yuci = jizhang_hang:CreateFontString("jizhang_Yuci"..id.."_UI");
	jizhang_Yuci:SetHeight(16);
	jizhang_Yuci:SetPoint("LEFT", jizhang_hang, "LEFT", 265,-0);
	jizhang_Yuci:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	jizhang_Yuci:SetTextColor(243/255, 108/255, 33/255, 1);
	--
	local jizhang_Yidaici = jizhang_hang:CreateFontString("jizhang_Yidaici"..id.."_UI");
	jizhang_Yidaici:SetHeight(16);
	jizhang_Yidaici:SetPoint("LEFT", jizhang_hang, "LEFT", 310,-0);
	jizhang_Yidaici:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	jizhang_Yidaici:SetTextColor(0, 1, 0, 1);
end

--修改单价优惠栏UI-------------
local jizhang_Danjia_bianji = CreateFrame("Frame", "jizhang_Danjia_bianji_UI", daiben.nr,"BackdropTemplate");
jizhang_Danjia_bianji:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 0, edgeSize = 6,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
jizhang_Danjia_bianji:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
jizhang_Danjia_bianji:SetSize(150,140);
jizhang_Danjia_bianji:SetPoint("TOPRIGHT",daiben.nr,"TOPLEFT",-2,-0);
jizhang_Danjia_bianji:EnableMouse(true);
jizhang_Danjia_bianji:Hide();
jizhang_Danjia_bianji.T0 = jizhang_Danjia_bianji:CreateFontString();
jizhang_Danjia_bianji.T0:SetPoint("TOP", jizhang_Danjia_bianji, "TOP", 0,-8);
jizhang_Danjia_bianji.T0:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
jizhang_Danjia_bianji.T1 = jizhang_Danjia_bianji:CreateFontString();
jizhang_Danjia_bianji.T1:SetPoint("TOP", jizhang_Danjia_bianji, "TOP", 0,-30);
jizhang_Danjia_bianji.T1:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");
jizhang_Danjia_bianji.T1:SetText("为此玩家单价优惠");
jizhang_Danjia_bianji.E = CreateFrame('EditBox', nil, jizhang_Danjia_bianji,"BackdropTemplate");
jizhang_Danjia_bianji.E:SetSize(38,30);
jizhang_Danjia_bianji.E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -8,right = -8,top = 2,bottom = -13}})
jizhang_Danjia_bianji.E:SetPoint("TOP",jizhang_Danjia_bianji,"TOP",0,-48);
jizhang_Danjia_bianji.E:SetFontObject(ChatFontNormal);
jizhang_Danjia_bianji.E:SetAutoFocus(false);
jizhang_Danjia_bianji.E:SetMaxLetters(4)
jizhang_Danjia_bianji.E:SetText(0)
jizhang_Danjia_bianji.E:SetJustifyH("CENTER");
jizhang_Danjia_bianji.E:SetScript("OnEscapePressed", function(self) 
	self:ClearFocus()
	jizhang_Danjia_bianji_UI:Hide();
end);
jizhang_Danjia_bianji.E:SetScript("OnEnterPressed", function(self) 
	self:ClearFocus()
	for x=1, #PIG_Per["FarmRecord"]["namelist"],1 do
		if PIG_Per["FarmRecord"]["namelist"][x][1]==jizhang_Danjia_bianji.T0:GetText() then
			PIG_Per["FarmRecord"]["namelist"][x][3]=jizhang_Danjia_bianji.E:GetNumber();
		end
	end
	jizhang_Danjia_bianji_UI:Hide();
	gengxinjizhangData()
end);

jizhang_Danjia_bianji.T3 = jizhang_Danjia_bianji:CreateFontString();
jizhang_Danjia_bianji.T3:SetPoint("TOP", jizhang_Danjia_bianji, "TOP", -18,-82);
jizhang_Danjia_bianji.T3:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
jizhang_Danjia_bianji.T3:SetText("优惠后单价");
jizhang_Danjia_bianji.T4 = jizhang_Danjia_bianji:CreateFontString();
jizhang_Danjia_bianji.T4:SetPoint("LEFT", jizhang_Danjia_bianji.T3, "RIGHT", 0,0);
jizhang_Danjia_bianji.T4:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
jizhang_Danjia_bianji.T4:SetTextColor(0, 1, 0, 1);
jizhang_Danjia_bianji.T4:SetText();
--修改优惠取消按钮
jizhang_Danjia_bianji.NO = CreateFrame("Button",nil,jizhang_Danjia_bianji, "UIPanelButtonTemplate");  
jizhang_Danjia_bianji.NO:SetSize(48,20);
jizhang_Danjia_bianji.NO:SetPoint("BOTTOM",jizhang_Danjia_bianji,"BOTTOM",32,12);
jizhang_Danjia_bianji.NO:SetText("取消");
jizhang_Danjia_bianji.NO:SetScript("OnClick", function ()
	jizhang_Danjia_bianji.E:SetText(0);
	jizhang_Danjia_bianji.T4:SetText();
	jizhang_Danjia_bianji_UI:Hide();
end);
--修改优惠确定按钮
jizhang_Danjia_bianji.YES = CreateFrame("Button",nil,jizhang_Danjia_bianji, "UIPanelButtonTemplate");  
jizhang_Danjia_bianji.YES:SetSize(48,20);
jizhang_Danjia_bianji.YES:SetPoint("BOTTOM",jizhang_Danjia_bianji,"BOTTOM",-32,12);
jizhang_Danjia_bianji.YES:SetText("确定");
jizhang_Danjia_bianji.YES:SetScript("OnClick", function ()
	for x=1, #PIG_Per["FarmRecord"]["namelist"],1 do
		if PIG_Per["FarmRecord"]["namelist"][x][1]==jizhang_Danjia_bianji.T0:GetText() then
			PIG_Per["FarmRecord"]["namelist"][x][3]=jizhang_Danjia_bianji.E:GetNumber();
		end
	end
	jizhang_Danjia_bianji_UI:Hide();
	gengxinjizhangData()
end);
--输入即时计算优惠后价钱
jizhang_Danjia_bianji.E:SetScript("OnCursorChanged", function() 
	local bianji_name=jizhang_Danjia_bianji.T0:GetText()
	for x=1, #PIG_Per["FarmRecord"]["namelist"],1 do
		if PIG_Per["FarmRecord"]["namelist"][x][1]==bianji_name then
			local bianjidanjia=PIG_Per["FarmRecord"]["namelist"][x][9];
			local youhuie=jizhang_Danjia_bianji.E:GetNumber();
			jizhang_Danjia_bianji.T4:SetText(bianjidanjia-jizhang_Danjia_bianji.E:GetNumber());
			break
		end
	end
end);
--//////修改余额栏UI//////
local jizhang_Yue_bianji = CreateFrame("Frame", "jizhang_Yue_bianji_UI", daiben.nr,"BackdropTemplate");
jizhang_Yue_bianji:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 0, edgeSize = 6,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
jizhang_Yue_bianji:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
jizhang_Yue_bianji:SetSize(150,140);
jizhang_Yue_bianji:SetPoint("TOPRIGHT",daiben.nr,"TOPLEFT",-2,-0);
jizhang_Yue_bianji:EnableMouse(true);
jizhang_Yue_bianji:Hide();
jizhang_Yue_bianji.T0 = jizhang_Yue_bianji:CreateFontString();
jizhang_Yue_bianji.T0:SetPoint("TOP", jizhang_Yue_bianji, "TOP", 0,-8);
jizhang_Yue_bianji.T0:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
jizhang_Yue_bianji.T0:SetText();
jizhang_Yue_bianji.T1 = jizhang_Yue_bianji:CreateFontString();
jizhang_Yue_bianji.T1:SetPoint("TOP", jizhang_Yue_bianji, "TOP", 0,-34);
jizhang_Yue_bianji.T1:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");
jizhang_Yue_bianji.T1:SetText("修改此玩家余额为:");
jizhang_Yue_bianji.E = CreateFrame('EditBox', nil, jizhang_Yue_bianji,"BackdropTemplate");
jizhang_Yue_bianji.E:SetSize(60,30);
jizhang_Yue_bianji.E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -8,right = -8,top = 2,bottom = -13}})
jizhang_Yue_bianji.E:SetPoint("TOP",jizhang_Yue_bianji,"TOP",0,-60);
jizhang_Yue_bianji.E:SetFontObject(ChatFontNormal);
jizhang_Yue_bianji.E:SetAutoFocus(false);
jizhang_Yue_bianji.E:SetMaxLetters(8)
jizhang_Yue_bianji.E:SetText(0)
jizhang_Yue_bianji.E:SetJustifyH("CENTER");
jizhang_Yue_bianji.E:SetScript("OnEscapePressed", function(self) 
	self:ClearFocus()
	jizhang_Yue_bianji_UI:Hide();
end);
jizhang_Yue_bianji.E:SetScript("OnEnterPressed", function(self) 
	self:ClearFocus()
	for x=1, #PIG_Per["FarmRecord"]["namelist"],1 do
		if PIG_Per["FarmRecord"]["namelist"][x][1]==jizhang_Yue_bianji.T0:GetText() then
			PIG_Per["FarmRecord"]["namelist"][x][4]=jizhang_Yue_bianji.E:GetNumber();
		end
	end
	jizhang_Yue_bianji_UI:Hide();
	gengxinjizhangData()
end);

jizhang_Yue_bianji.T2 = jizhang_Yue_bianji:CreateFontString();
jizhang_Yue_bianji.T2:SetPoint("LEFT", jizhang_Yue_bianji.E, "RIGHT", 10,0);
jizhang_Yue_bianji.T2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
jizhang_Yue_bianji.T2:SetText("\124cffffFF00G\124r");
--修改余额取消按钮
jizhang_Yue_bianji.NO = CreateFrame("Button",nil,jizhang_Yue_bianji, "UIPanelButtonTemplate");  
jizhang_Yue_bianji.NO:SetSize(48,20);
jizhang_Yue_bianji.NO:SetPoint("BOTTOM",jizhang_Yue_bianji,"BOTTOM",32,12);
jizhang_Yue_bianji.NO:SetText("取消");
jizhang_Yue_bianji.NO:SetScript("OnClick", function ()
	jizhang_Yue_bianji_UI:Hide();
end);
--修改余额确定按钮
jizhang_Yue_bianji.YES = CreateFrame("Button",nil,jizhang_Yue_bianji, "UIPanelButtonTemplate");  
jizhang_Yue_bianji.YES:SetSize(48,20);
jizhang_Yue_bianji.YES:SetPoint("BOTTOM",jizhang_Yue_bianji,"BOTTOM",-32,12);
jizhang_Yue_bianji.YES:SetText("确定");
jizhang_Yue_bianji.YES:SetScript("OnClick", function ()	
	for x=1, #PIG_Per["FarmRecord"]["namelist"],1 do
		if PIG_Per["FarmRecord"]["namelist"][x][1]==jizhang_Yue_bianji.T0:GetText() then
			PIG_Per["FarmRecord"]["namelist"][x][4]=jizhang_Yue_bianji.E:GetNumber();
		end
	end
	jizhang_Yue_bianji_UI:Hide();
	gengxinjizhangData()
end);
-------
daiben.nr.fengexian = daiben.nr:CreateLine("fengexian_UI")
daiben.nr.fengexian:SetColorTexture(1,1,1,0.3)
daiben.nr.fengexian:SetThickness(1);
daiben.nr.fengexian:SetStartPoint("TOPLEFT",1,-114)
daiben.nr.fengexian:SetEndPoint("TOPRIGHT",-1,-114)
daiben.nr.shouru = daiben.nr:CreateFontString();
daiben.nr.shouru:SetPoint("TOPLEFT", daiben.nr.fengexian, "BOTTOMLEFT", 4,-5);
daiben.nr.shouru:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
daiben.nr.shouru:SetText("\124cff00ff00本次收入/G:\124r");
daiben.nr.shouru_V = daiben.nr:CreateFontString();
daiben.nr.shouru_V:SetPoint("LEFT", daiben.nr.shouru, "RIGHT", 0,0);
daiben.nr.shouru_V:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
daiben.nr.shouru_V:SetText(0);
-----更新收入
local function gengxinshouru()
	if PIG_Per["FarmRecord"]["shouruG"][1]==0 then
		PIG_Per["FarmRecord"]["shouruG"][1] = GetMoney();
		PIG_Per["FarmRecord"]["shouruG"][2] = GetServerTime();
	else
		if (GetServerTime()-PIG_Per["FarmRecord"]["shouruG"][2])>3600 then
			PIG_Per["FarmRecord"]["shouruG"][1] = GetMoney();
		end
	end
	local shouruduoshao = floor((GetMoney()-PIG_Per["FarmRecord"]["shouruG"][1])/10000);
	daiben.nr.shouru_V:SetText("\124cffffff00"..shouruduoshao.."G(总"..floor((GetMoney()/10000)).."G)\124r");
	PIG_Per["FarmRecord"]["shouruG"][2] = GetServerTime();
end
-----更新次数
local function gengxincishu()
	if (GetServerTime()-PIG_Per["FarmRecord"]['Time_Over'])>3600 then
		PIG_Per["FarmRecord"]["shuabenshu"] = 0;
	end
end
--收入清零---------------------
StaticPopupDialogs["SHOURU_QINGLING"] = {
	text = "|cff00FFFF!Pig"..gongnengName.."：|r\n\124cffff0000重置\124r玩家数据和本次收入统计?",
	button1 = "是",
	button2 = "否",
	OnAccept = function()
		PIG_Per["FarmRecord"]["shouruG"][1] = GetMoney();
		PIG_Per["FarmRecord"]["shouruG"][2] = GetServerTime();
		daiben.nr.shouru_V:SetText("\124cffffff000G(总"..floor((GetMoney()/10000)).."G)\124r");
		PIG_Per["FarmRecord"]["namelist"]= {};
		gengxinjizhangData()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
daiben.nr.shouruqingling = CreateFrame("Button",nil,daiben.nr);
daiben.nr.shouruqingling:SetSize(24,24);
daiben.nr.shouruqingling:SetPoint("LEFT", daiben.nr.shouru_V, "RIGHT", -4,-2);
daiben.nr.shouruqingling.highlight = daiben.nr.shouruqingling:CreateTexture(nil, "HIGHLIGHT");
daiben.nr.shouruqingling.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
daiben.nr.shouruqingling.highlight:SetBlendMode("ADD")
daiben.nr.shouruqingling.highlight:SetPoint("CENTER", daiben.nr.shouruqingling, "CENTER", 0,0);
daiben.nr.shouruqingling.highlight:SetSize(26,26);
daiben.nr.shouruqingling.Normal = daiben.nr.shouruqingling:CreateTexture(nil, "BORDER");
daiben.nr.shouruqingling.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
daiben.nr.shouruqingling.Normal:SetBlendMode("ADD")
daiben.nr.shouruqingling.Normal:SetPoint("CENTER", daiben.nr.shouruqingling, "CENTER", 0,0);
daiben.nr.shouruqingling.Normal:SetSize(16,16);
daiben.nr.shouruqingling:HookScript("OnMouseDown", function (self)
	daiben.nr.shouruqingling.Normal:SetPoint("CENTER", daiben.nr.shouruqingling, "CENTER", -1.5,-1.5);
end);
daiben.nr.shouruqingling:HookScript("OnMouseUp", function (self)
	daiben.nr.shouruqingling.Normal:SetPoint("CENTER", daiben.nr.shouruqingling, "CENTER", 0,0);
end);
daiben.nr.shouruqingling:SetScript("OnClick", function (self)
	StaticPopup_Show ("SHOURU_QINGLING")
end)
--帮助提示
daiben.nr.tishi = CreateFrame("Frame", "daiben.nr.tishi_UI", daiben.nr);
daiben.nr.tishi:SetSize(28,28);
daiben.nr.tishi:SetPoint("TOPRIGHT", daiben.nr.fengexian, "BOTTOMRIGHT", -0,0);
daiben.nr.tishi.Texture = daiben.nr.tishi:CreateTexture(nil, "BORDER");
daiben.nr.tishi.Texture:SetTexture("interface/common/help-i.blp");
daiben.nr.tishi.Texture:SetAllPoints(daiben.nr.tishi)
daiben.nr.tishi:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(daiben.nr.tishi, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine(
		"\124cff00ff001、重置副本会自动扣除一次费用。\124r\n"..
		"\124cff00ff002、玩家交易给予的金币会自动加入余额。\124r\n"..
		"\124cff00ff003、点击单价设置玩家的优惠金额,点击余额输入最新余额。\124r\n"..
		"\124cff00ff004、\124cffffff00启用有余额锁定单价时右击单价数字可手动更新单价。\124r\n"..
		"\124cff00ff005、下线超过1小时本次收入统计将会清零。\124r\n"..
		"\124cff00ff006、编辑单价/锁定单价/重置就位等等请到设置页设置。\124r")
	GameTooltip:Show();
end);
daiben.nr.tishi:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);

--计时功能-----------------------------------------------------------
local jishiT = CreateFrame("Frame", "jishiTimeUI", daiben,"BackdropTemplate");
jishiT:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 0, edgeSize = 6,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
jishiT:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
jishiT:SetPoint("TOPLEFT",daiben,"BOTTOMLEFT",0,-2);
jishiT:SetPoint("TOPRIGHT",daiben,"BOTTOMRIGHT",0,-2);
jishiT:SetHeight(TIME_Height)
jishiT:Hide()
--标题
jishiT.TMbiaoti1 = jishiT:CreateFontString();
jishiT.TMbiaoti1:SetPoint("TOPLEFT", jishiT, "TOPLEFT", 5,-4);
jishiT.TMbiaoti1:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
jishiT.TMbiaoti1:SetText("\124cffffff00#\124r");
jishiT.TMbiaoti2 = jishiT:CreateFontString();
jishiT.TMbiaoti2:SetPoint("TOPLEFT", jishiT, "TOPLEFT", 24,-4);
jishiT.TMbiaoti2:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
jishiT.TMbiaoti2:SetText("\124cffffff00进本\124r\124cffFF69B4(CD)\124r");
jishiT.TMbiaoti3 = jishiT:CreateFontString();
jishiT.TMbiaoti3:SetPoint("TOPLEFT", jishiT, "TOPLEFT", 94,-4);
jishiT.TMbiaoti3:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
jishiT.TMbiaoti3:SetText("\124cffffff00出本\124r\124cffFF69B4(CD)\124r");
jishiT.TMbiaoti4 = jishiT:CreateFontString();
jishiT.TMbiaoti4:SetPoint("TOPLEFT", jishiT, "TOPLEFT", 162,-4);
jishiT.TMbiaoti4:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
jishiT.TMbiaoti4:SetText("\124cffffff00重置\124r\124cffFF69B4(CD)\124r");
jishiT.TMbiaoti5 = jishiT:CreateFontString();
jishiT.TMbiaoti5:SetPoint("TOPLEFT", jishiT, "TOPLEFT", 238,-4);
jishiT.TMbiaoti5:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
jishiT.TMbiaoti5:SetText("\124cffffff00击杀数\124r");
jishiT.TMbiaoti6 = jishiT:CreateFontString();
jishiT.TMbiaoti6:SetPoint("TOPLEFT", jishiT, "TOPLEFT", 294,-4);
jishiT.TMbiaoti6:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
jishiT.TMbiaoti6:SetText("\124cffffff00耗时/m\124r");
--计时行
for id = 1, 5, 1 do
	jishiT.hang = CreateFrame("Frame", "daiben_jishihang_"..id, jishiT);
	jishiT.hang:SetSize(Width,17);
	if id==1 then
		jishiT.hang:SetPoint("TOPLEFT", jishiT.TMbiaoti1, "BOTTOMLEFT", 0,-2);
	else
		jishiT.hang:SetPoint("TOPLEFT", _G["daiben_jishihang_"..(id-1)], "BOTTOMLEFT", 0,-2);
	end
	jishiT.hang.xuhaoID = jishiT.hang:CreateFontString("FarmTime_"..id.."_0");
	jishiT.hang.xuhaoID:SetPoint("LEFT", jishiT.hang, "LEFT", 0,0);
	jishiT.hang.xuhaoID:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	jishiT.hang.xuhaoID:SetText("\124cffffff00"..id.."：\124r");

	jishiT.hang.jinru = jishiT.hang:CreateFontString("FarmTime_"..id.."_1");
	jishiT.hang.jinru:SetPoint("LEFT", jishiT.hang, "LEFT", 20, 0);
	jishiT.hang.jinru:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");

	jishiT.hang.chulai = jishiT.hang:CreateFontString("FarmTime_"..id.."_2");
	jishiT.hang.chulai:SetPoint("LEFT", jishiT.hang, "LEFT", 90, 0);
	jishiT.hang.chulai:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");

	jishiT.hang.chongzhi = jishiT.hang:CreateFontString("FarmTime_"..id.."_3");
	jishiT.hang.chongzhi:SetPoint("LEFT", jishiT.hang, "LEFT", 160, 0);
	jishiT.hang.chongzhi:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");

	jishiT.hang.ShaguaishuFF = CreateFrame("Frame", "FarmTimeFFF_"..id.."_4", jishiT.hang);
	jishiT.hang.ShaguaishuFF:SetSize(44,17);
	jishiT.hang.ShaguaishuFF:SetPoint("LEFT", jishiT.hang, "LEFT", 236, 0);
	jishiT.hang.ShaguaishuFF.Shaguaishu = jishiT.hang.ShaguaishuFF:CreateFontString("FarmTime_"..id.."_4");
	jishiT.hang.ShaguaishuFF.Shaguaishu:SetPoint("LEFT", jishiT.hang.ShaguaishuFF, "LEFT", 0, 0);
	jishiT.hang.ShaguaishuFF.Shaguaishu:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	jishiT.hang.ShaguaishuFF.Shaguaishu:SetTextColor(243/255, 108/255, 33/255, 1);

	jishiT.hang.Haoshi = jishiT.hang:CreateFontString("FarmTime_"..id.."_5");
	jishiT.hang.Haoshi:SetPoint("LEFT", jishiT.hang, "LEFT", 294, 0);
	jishiT.hang.Haoshi:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
end
jishiT.TMlinx1 = jishiT:CreateLine()
jishiT.TMlinx1:SetColorTexture(1,1,1,0.3)
jishiT.TMlinx1:SetThickness(1);
jishiT.TMlinx1:SetStartPoint("TOPLEFT",1,-116)
jishiT.TMlinx1:SetEndPoint("TOPRIGHT",-1,-116)
jishiT.TM24H = jishiT:CreateFontString();
jishiT.TM24H:SetPoint("TOPLEFT", jishiT.TMlinx1, "TOPLEFT", 4,-4);
jishiT.TM24H:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
jishiT.TM24H:SetText("\124cff00ff00 本次刷本次数：\124r");
jishiT.TM24H_V = jishiT:CreateFontString();
jishiT.TM24H_V:SetPoint("LEFT", jishiT.TM24H, "RIGHT", 2,0);
jishiT.TM24H_V:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
jishiT.TM24H_V:SetText(0);
-------
--清空记录
jishiT.qingkongTimejilu = CreateFrame("Button",nil,jishiT);
jishiT.qingkongTimejilu:SetSize(26,26);
jishiT.qingkongTimejilu:SetPoint("LEFT", jishiT.TM24H_V, "RIGHT", 0,-2);
jishiT.qingkongTimejilu.highlight = jishiT.qingkongTimejilu:CreateTexture(nil, "HIGHLIGHT");
jishiT.qingkongTimejilu.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
jishiT.qingkongTimejilu.highlight:SetBlendMode("ADD")
jishiT.qingkongTimejilu.highlight:SetPoint("CENTER", jishiT.qingkongTimejilu, "CENTER", 0,0);
jishiT.qingkongTimejilu.highlight:SetSize(30,30);
jishiT.qingkongTimejilu.Normal = jishiT.qingkongTimejilu:CreateTexture(nil, "BORDER");
jishiT.qingkongTimejilu.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
jishiT.qingkongTimejilu.Normal:SetBlendMode("ADD")
jishiT.qingkongTimejilu.Normal:SetPoint("CENTER", jishiT.qingkongTimejilu, "CENTER", 0,0);
jishiT.qingkongTimejilu.Normal:SetSize(16,16);
jishiT.qingkongTimejilu:HookScript("OnMouseDown", function (self)
	jishiT.qingkongTimejilu.Normal:SetPoint("CENTER", jishiT.qingkongTimejilu, "CENTER", -1.5,-1.5);
end);
jishiT.qingkongTimejilu:HookScript("OnMouseUp", function (self)
	jishiT.qingkongTimejilu.Normal:SetPoint("CENTER", jishiT.qingkongTimejilu, "CENTER", 0,0);
end);
jishiT.qingkongTimejilu:SetScript("OnClick", function (self)
	StaticPopup_Show ("QINGKONG_TIME_JILUXX")
end)
--手动增加次数
jishiT.shoudongADD = CreateFrame("Button",nil,jishiT);
jishiT.shoudongADD:SetSize(20,19);
jishiT.shoudongADD:SetPoint("TOPLEFT", jishiT.TMlinx1, "TOPLEFT", 254,-2);
jishiT.shoudongADD.title = jishiT.shoudongADD:CreateFontString();
jishiT.shoudongADD.title:SetPoint("CENTER", jishiT.shoudongADD, "CENTER", 0, 0);
jishiT.shoudongADD.title:SetFont(GameFontNormal:GetFont(), 22,"OUTLINE")
jishiT.shoudongADD.title:SetTextColor(1, 1, 0, 1);
jishiT.shoudongADD.title:SetText('+');
jishiT.shoudongADD:HookScript("OnMouseDown", function (self)
	self.title:SetPoint("CENTER", jishiT.shoudongADD, "CENTER", -1.5,-1.5);
end);
jishiT.shoudongADD:HookScript("OnMouseUp", function (self)
	self.title:SetPoint("CENTER", jishiT.shoudongADD, "CENTER", 0,0);
end);
jishiT.shoudongADD:SetScript("OnClick", function (self)
	StaticPopup_Show ("NEW_FUBEN_RECORD","手动增加一次副本记录吗？")
end)
----分析击杀明细
local mingxizhanshihangshu=50
local function Show_jishamingxi()
		jishafenxi_mingxiF_UI:SetFrameLevel(FrameLevel+10)
		jishafenxi_mingxiF_UI:Show()
		jishafenxi_mingxiF_UI:SetHeight(50+((20+2)*5));
		for i=1,5 do
			_G["Daiben_listNO"..i].tongzhi:Hide()
			_G["Daiben_listNO"..i].heji:SetText()
			_G["Daiben_listNO"..i].EXP_v:SetText()
			for ii=1,mingxizhanshihangshu do
				_G["Daiben_listNO.FFF"..i.."_"..ii]:Hide()
				_G["Daiben_listNO.FFF.NPC"..i.."_"..ii]:SetText()
				_G["Daiben_listNO.FFF.NUM"..i.."_"..ii]:SetText()
			end
		end
		---
		local hangshudongtaiVVV = 1
		local jishamingxixianshiID = 0
		for i=1,5 do
			if #PIG_Per["FarmRecord"]["Time"][i]>0 then
				--EXP
				local expchazhi=PIG_Per["FarmRecord"]["Time"][i][7]
				if type(expchazhi)=="number" then
					_G["Daiben_listNO"..i].EXP_v:SetText(expchazhi)
				else
					_G["Daiben_listNO"..i].EXP_v:SetText(0)
				end
				if #PIG_Per["FarmRecord"]["Time"][i][5]>0 then
							jishamingxixianshiID = jishamingxixianshiID+1
							local minxilistN=#PIG_Per["FarmRecord"]["Time"][i][5];
							local hejishaguaishudaibenmingxi=0
							local jishamingxiNPCmame={}
							local jishamingxiNPCmameVV={}
							for ii=1,minxilistN do
								table.insert(jishamingxiNPCmame,PIG_Per["FarmRecord"]["Time"][i][5][ii][1]);
								jishamingxiNPCmameVV[PIG_Per["FarmRecord"]["Time"][i][5][ii][1]]=PIG_Per["FarmRecord"]["Time"][i][5][ii][2];
							end
							table.sort(jishamingxiNPCmame)
							for ii=1,minxilistN do
								_G["Daiben_listNO.FFF"..jishamingxixianshiID.."_"..ii]:Show()
								_G["Daiben_listNO.FFF.NPC"..jishamingxixianshiID.."_"..ii]:SetText(jishamingxiNPCmame[ii])
								_G["Daiben_listNO.FFF.NUM"..jishamingxixianshiID.."_"..ii]:SetText(jishamingxiNPCmameVV[jishamingxiNPCmame[ii]])
								hejishaguaishudaibenmingxi=hejishaguaishudaibenmingxi+PIG_Per["FarmRecord"]["Time"][i][5][ii][2];
							end
							_G["Daiben_listNO"..jishamingxixianshiID].heji:SetText(hejishaguaishudaibenmingxi)
							if minxilistN>hangshudongtaiVVV then
								hangshudongtaiVVV=minxilistN
								jishafenxi_mingxiF_UI:SetHeight(50+((20+2)*hangshudongtaiVVV));
							end
							------
							_G["Daiben_listNO"..jishamingxixianshiID].tongzhi:Show()
							_G["Daiben_listNO"..jishamingxixianshiID].tongzhi:SetID(jishamingxixianshiID)
							_G["Daiben_listNO"..jishamingxixianshiID].tongzhi:SetScript("OnClick", function(self)
									SendChatMessage("[!Pig] 击杀报告详情:", "PARTY", nil);
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
											SendChatMessage(baogaomingxiguangboPVV, "PARTY", nil);
										end
									else
										local baogaomingxiguangboPVV = ""
										for ii=1,#jishamingxiNPCmame do
											baogaomingxiguangboPVV=baogaomingxiguangboPVV..jishamingxiNPCmame[ii]..jishamingxiNPCmameVV[jishamingxiNPCmame[ii]]..","
										end
										SendChatMessage(baogaomingxiguangboPVV, "PARTY", nil);
									end
									SendChatMessage("本次击杀总数为：".._G["Daiben_listNO"..self:GetID()].heji:GetText().." (距离过远无法记录)", "PARTY", nil);
									local jingyanV=_G["Daiben_listNO"..self:GetID()].EXP_v:GetText()
									if jingyanV and tonumber(jingyanV)>0 then
										SendChatMessage("本次获得经验值：".._G["Daiben_listNO"..self:GetID()].EXP_v:GetText(), "PARTY", nil);
									end
							end);
				end
			end
		end
end
jishiT.mingxiF = CreateFrame("Frame", "jishafenxi_mingxiF_UI", jishiT,"BackdropTemplate");
jishiT.mingxiF:SetBackdrop( { bgFile = "interface/characterframe/ui-party-background.blp",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = false, tileSize = 0, edgeSize = 14, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 } });
jishiT.mingxiF:SetSize(800,600);
jishiT.mingxiF:SetPoint("CENTER",UIParent,"CENTER",0,0);
jishiT.mingxiF:EnableMouse(true)
jishiT.mingxiF:Hide()
jishiT.mingxiF:SetClampedToScreen(true)
jishiT.mingxiF:SetMovable(true)
tinsert(UISpecialFrames,"jishafenxi_mingxiF_UI");
jishiT.mingxiF.yidong = CreateFrame("Frame", nil, jishiT.mingxiF);
jishiT.mingxiF.yidong:SetSize(200,22);
jishiT.mingxiF.yidong:SetPoint("TOP", jishiT.mingxiF, "TOP", 0, 0);
jishiT.mingxiF.yidong:EnableMouse(true)
jishiT.mingxiF.yidong:RegisterForDrag("LeftButton")
jishiT.mingxiF.yidong:SetScript("OnDragStart",function()
	jishiT.mingxiF:StartMoving()
end)
jishiT.mingxiF.yidong:SetScript("OnDragStop",function()
	jishiT.mingxiF:StopMovingOrSizing()
end)
jishiT.mingxiF.Biaoti = jishiT.mingxiF:CreateFontString();
jishiT.mingxiF.Biaoti:SetPoint("TOP", jishiT.mingxiF, "TOP", 0,-4);
jishiT.mingxiF.Biaoti:SetFontObject(GameFontNormal);
jishiT.mingxiF.Biaoti:SetText("Pig击杀明细报告");
jishiT.mingxiF.Close = CreateFrame("Button",nil,jishiT.mingxiF, "UIPanelCloseButton");  
jishiT.mingxiF.Close:SetSize(30,30);
jishiT.mingxiF.Close:SetPoint("TOPRIGHT",jishiT.mingxiF,"TOPRIGHT",4,3);
jishiT.mingxiF.line = jishiT.mingxiF:CreateLine()
jishiT.mingxiF.line:SetColorTexture(1,1,1,0.4)
jishiT.mingxiF.line:SetThickness(1);
jishiT.mingxiF.line:SetStartPoint("TOPLEFT",3,-22)
jishiT.mingxiF.line:SetEndPoint("TOPRIGHT",-2,-22)
local fenxiW=jishiT.mingxiF:GetWidth()-4
local fenxiH=jishiT.mingxiF:GetHeight()-50
for i=1,5 do
	local Daiben_listNO = CreateFrame("Frame", "Daiben_listNO"..i, jishiT.mingxiF);
	Daiben_listNO:SetWidth(fenxiW/5);
	if i==1 then
		Daiben_listNO:SetPoint("TOPLEFT", jishiT.mingxiF.line, "TOPLEFT", 0,-25);
		Daiben_listNO:SetPoint("BOTTOMLEFT", jishiT.mingxiF, "BOTTOMLEFT", 0,2);
	else
		Daiben_listNO:SetPoint("TOPLEFT", _G["Daiben_listNO"..(i-1)], "TOPRIGHT", 0,-0);
		Daiben_listNO:SetPoint("BOTTOMLEFT", _G["Daiben_listNO"..(i-1)], "BOTTOMRIGHT", 0,-0);
	end
	Daiben_listNO.line = Daiben_listNO:CreateLine()
	Daiben_listNO.line:SetColorTexture(1,1,1,0.4)
	Daiben_listNO.line:SetThickness(1);
	if i~=5 then
		Daiben_listNO.line:SetStartPoint("TOPRIGHT",0,24)
		Daiben_listNO.line:SetEndPoint("BOTTOMRIGHT",0,0)
	end
	Daiben_listNO.biaoti = Daiben_listNO:CreateFontString();
	Daiben_listNO.biaoti:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	Daiben_listNO.biaoti:SetTextColor(1, 1, 0, 1);
	Daiben_listNO.biaoti:SetPoint("BOTTOMLEFT", Daiben_listNO, "TOPLEFT", 2,7);
	Daiben_listNO.biaoti:SetText("#"..i);
	Daiben_listNO.heji = Daiben_listNO:CreateFontString();
	Daiben_listNO.heji:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	Daiben_listNO.heji:SetTextColor(1, 0, 0, 1);
	Daiben_listNO.heji:SetPoint("LEFT", Daiben_listNO.biaoti, "RIGHT", 0,0);
	---EXP
	Daiben_listNO.EXP = Daiben_listNO:CreateFontString();
	Daiben_listNO.EXP:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	Daiben_listNO.EXP:SetTextColor(1, 1, 0, 1);
	Daiben_listNO.EXP:SetPoint("LEFT", Daiben_listNO.heji, "RIGHT", 4,0);
	Daiben_listNO.EXP:SetText("XP");
	Daiben_listNO.EXP_v = Daiben_listNO:CreateFontString();
	Daiben_listNO.EXP_v:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	Daiben_listNO.EXP_v:SetTextColor(0, 1, 0, 1);
	Daiben_listNO.EXP_v:SetPoint("LEFT", Daiben_listNO.EXP, "RIGHT", 0,0);
	--
	Daiben_listNO.tongzhi = CreateFrame("Button","mingxibaogao_tongzhi_"..i.."_UI",Daiben_listNO, "TruncatedButtonTemplate",i);  
	Daiben_listNO.tongzhi:SetSize(20,20);
	Daiben_listNO.tongzhi:SetPoint("LEFT",Daiben_listNO.EXP_v,"RIGHT",2,-0);
	Daiben_listNO.tongzhi.Tex = Daiben_listNO.tongzhi:CreateTexture(nil, "BORDER");
	Daiben_listNO.tongzhi.Tex:SetTexture(130979);
	Daiben_listNO.tongzhi.Tex:SetPoint("CENTER");
	Daiben_listNO.tongzhi.Tex:SetSize(20,20);
	Daiben_listNO.tongzhi:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER", 1.2,-1.2);
	end);
	Daiben_listNO.tongzhi:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	--
	for ii=1,mingxizhanshihangshu do
		Daiben_listNO.FFF = CreateFrame("Frame", "Daiben_listNO.FFF"..i.."_"..ii, Daiben_listNO);
		Daiben_listNO.FFF:SetSize(fenxiW/5-0,20);
		if ii==1 then
			Daiben_listNO.FFF:SetPoint("TOP", Daiben_listNO, "TOP", 0,-0);
		else
			Daiben_listNO.FFF:SetPoint("TOP", _G["Daiben_listNO.FFF"..i.."_"..(ii-1)], "BOTTOM", 0,-2);
		end
		Daiben_listNO.FFF.line = Daiben_listNO.FFF:CreateLine()
		if ii==1 then
			Daiben_listNO.FFF.line:SetColorTexture(1,1,1,0.4)
		else
			Daiben_listNO.FFF.line:SetColorTexture(1,1,1,0.2)
		end
		Daiben_listNO.FFF.line:SetThickness(1);
		Daiben_listNO.FFF.line:SetStartPoint("TOPLEFT",0,1)
		Daiben_listNO.FFF.line:SetEndPoint("TOPRIGHT",0,1)
		Daiben_listNO.FFF.NPC = Daiben_listNO.FFF:CreateFontString("Daiben_listNO.FFF.NPC"..i.."_"..ii);
		Daiben_listNO.FFF.NPC:SetPoint("LEFT", Daiben_listNO.FFF, "LEFT", 2,-0);
		Daiben_listNO.FFF.NPC:SetSize(fenxiW/5*0.8,20);
		Daiben_listNO.FFF.NPC:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		Daiben_listNO.FFF.NPC:SetJustifyH("LEFT");
		Daiben_listNO.FFF.NPC:SetTextColor(1, 0.5, 0, 1);
		Daiben_listNO.FFF.NUM = Daiben_listNO.FFF:CreateFontString("Daiben_listNO.FFF.NUM"..i.."_"..ii);
		Daiben_listNO.FFF.NUM:SetPoint("LEFT", Daiben_listNO.FFF.NPC, "RIGHT", 2,-0);
		Daiben_listNO.FFF.NUM:SetSize(fenxiW/5*0.16,20);
		Daiben_listNO.FFF.NUM:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		Daiben_listNO.FFF.NUM:SetJustifyH("LEFT");
		Daiben_listNO.FFF.NUM:SetTextColor(0, 1, 0, 1);
	end
	jishiT.mingxiF:SetHeight(50+(20+2)*mingxizhanshihangshu);
end
--帮助提示
jishiT.jishitishibut = CreateFrame("Frame", nil, jishiT);
jishiT.jishitishibut:SetSize(28,28);
jishiT.jishitishibut:SetPoint("TOPRIGHT", jishiT.TMlinx1, "TOPRIGHT", 0,1.6);
jishiT.jishitishibut.Texture = jishiT.jishitishibut:CreateTexture(nil, "BORDER");
jishiT.jishitishibut.Texture:SetTexture("interface/common/help-i.blp");
jishiT.jishitishibut.Texture:SetAllPoints(jishiT.jishitishibut)
jishiT.jishitishibut:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(jishiT.jishitishibut, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine(
		"\124cff00ff001、进/出/重置副本会记录当时时间.\124r\n"..
		"\124cff00ff002、下线超过1小时本次刷本次数将会清零。\124r\n"..
		"\124cffffff00作者也不清楚爆本计算是以什么时间为准，\n所以均有倒计时，请自行判断。\124r")
	GameTooltip:Show();
end);
jishiT.jishitishibut:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
---------------------------
local zhengzaixianshijishimianban=false
local function TimeInfo_Update()
		for i = 1, 5, 1 do
			_G["FarmTime_"..i.."_1"]:SetText(" -");
			_G["FarmTime_"..i.."_2"]:SetText(" -");
			_G["FarmTime_"..i.."_3"]:SetText(" -");
			_G["FarmTime_"..i.."_4"]:SetText(" -");
			_G["FarmTime_"..i.."_5"]:SetText(" -");
		end
		-----------
		local xianshibianhaoID=0
		for i=1, 5 do
			if PIG_Per["FarmRecord"]['Time'][i] and #PIG_Per["FarmRecord"]['Time'][i]>0 then
				xianshibianhaoID=xianshibianhaoID+1
				_G["FarmTime_"..xianshibianhaoID.."_1"]:SetText(date("%H:%M",PIG_Per["FarmRecord"]['Time'][i][1]).."\124r");
				local daojishihuifu1 =math.floor((3600+PIG_Per["FarmRecord"]['Time'][i][1]-GetServerTime()) / 60+0.5);
				if daojishihuifu1>0 then
					_G["FarmTime_"..xianshibianhaoID.."_1"]:SetText("\124cffFF0000"..date("%H:%M",PIG_Per["FarmRecord"]['Time'][i][1]).."\124r".."\124cffFF8C00("..daojishihuifu1..")\124r");
				elseif daojishihuifu1<=0 then
					_G["FarmTime_"..xianshibianhaoID.."_1"]:SetText("\124cff00ff00"..date("%H:%M",PIG_Per["FarmRecord"]['Time'][i][1]).."\124r");
				end
				---
				if PIG_Per["FarmRecord"]['Time'][i][2] then
					local daojishihuifu2 =math.floor((3600+PIG_Per["FarmRecord"]['Time'][i][2]-GetServerTime()) / 60+0.5);
					if daojishihuifu2>0 then
						_G["FarmTime_"..xianshibianhaoID.."_2"]:SetText("\124cffFF0000"..date("%H:%M",PIG_Per["FarmRecord"]['Time'][i][2]).."\124r".."\124cffFF8C00("..daojishihuifu2..")\124r");
					else
						_G["FarmTime_"..xianshibianhaoID.."_2"]:SetText("\124cff00ff00"..date("%H:%M",PIG_Per["FarmRecord"]['Time'][i][2]).."\124r");
					end
				end
				if PIG_Per["FarmRecord"]['Time'][i][3] then
					local daojishihuifu3 =math.floor((3600+PIG_Per["FarmRecord"]['Time'][i][3]-GetServerTime()) / 60+0.5);
					if daojishihuifu3>0 then
						_G["FarmTime_"..xianshibianhaoID.."_3"]:SetText("\124cffFF0000"..date("%H:%M",PIG_Per["FarmRecord"]['Time'][i][3]).."\124r".."\124cffFF8C00("..daojishihuifu3..")\124r");
					else
						_G["FarmTime_"..xianshibianhaoID.."_3"]:SetText("\124cff00ff00"..date("%H:%M",PIG_Per["FarmRecord"]['Time'][i][3]).."\124r");
					end
				end
				--
				_G["FarmTime_"..xianshibianhaoID.."_4"]:SetText(PIG_Per["FarmRecord"]['Time'][i][4]);
				_G["FarmTimeFFF_"..xianshibianhaoID.."_4"]:SetScript("OnMouseUp", function()
					if jishafenxi_mingxiF_UI:IsShown() then
						jishafenxi_mingxiF_UI:Hide()
					else
						Show_jishamingxi()
					end
				end);
				-----
				if PIG_Per["FarmRecord"]['Time'][i][1] and PIG_Per["FarmRecord"]['Time'][i][2] then
					_G["FarmTime_"..xianshibianhaoID.."_5"]:SetText(math.floor((PIG_Per["FarmRecord"]['Time'][i][2]-PIG_Per["FarmRecord"]['Time'][i][1]) / 60+0.5));
				end
			end
		end
		jishiT.TM24H_V:SetText("\124cffffff00"..PIG_Per["FarmRecord"]["shuabenshu"].."\124r");
	----
	if zhengzaixianshijishimianban then
		C_Timer.After(1, TimeInfo_Update)
	end
end
jishiT:SetScript("OnShow", function()
	zhengzaixianshijishimianban=true
	TimeInfo_Update()
end);
jishiT:SetScript("OnHide", function()
	zhengzaixianshijishimianban=false
	TimeInfo_Update()
end);
----=============================================================================
--设置部分
daiben.nr.TMlinx2 = daiben.nr:CreateLine()
daiben.nr.TMlinx2:SetColorTexture(1,1,1,0.5)
daiben.nr.TMlinx2:SetThickness(1);
daiben.nr.TMlinx2:SetStartPoint("TOPLEFT",1,-138)
daiben.nr.TMlinx2:SetEndPoint("TOPRIGHT",-1,-138)

---扣钱
daiben.nr.kouqian = CreateFrame("Button",nil,daiben.nr, "UIPanelButtonTemplate");  
daiben.nr.kouqian:SetSize(biaotiH*2+2,biaotiH-6);
daiben.nr.kouqian:SetPoint("TOPLEFT",daiben.nr.TMlinx2,"TOPLEFT",14,-3);
daiben.nr.kouqian:SetText("扣钱");
daiben.nr.kouqian:SetScript("OnClick", function ()
	StaticPopup_Show ("SHOUDONG_KOUQIAN")
end);
StaticPopupDialogs["SHOUDONG_KOUQIAN"] = {
	text = "|cff00FFFF!Pig"..gongnengName.."：|r\n手动扣除队伍内玩家一次费用吗?",
	button1 = "是",
	button2 = "否",
	OnAccept = function()
		shoudongkouqian();
		gengxinjizhangData("CZ");
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
---加钱
daiben.nr.jiaqianG = CreateFrame("Button",nil,daiben.nr, "UIPanelButtonTemplate");  
daiben.nr.jiaqianG:SetSize(biaotiH*2+2,biaotiH-6);
daiben.nr.jiaqianG:SetPoint("TOPLEFT",daiben.nr.TMlinx2,"TOPLEFT",88,-3);
daiben.nr.jiaqianG:SetText("加钱");
daiben.nr.jiaqianG:SetScript("OnClick", function ()
	StaticPopup_Show ("SHOUDONG_JIAQIAN")
end);
StaticPopupDialogs["SHOUDONG_JIAQIAN"] = {
	text = "|cff00FFFF!Pig"..gongnengName.."：|r\n给队伍内玩家增加一次费用吗?",
	button1 = "是",
	button2 = "否",
	OnAccept = function()
		shoudongjiaqian();
		gengxinjizhangData();
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
---手动通报
daiben.nr.shoudongguangboyuci = CreateFrame("Button",nil,daiben.nr);  
daiben.nr.shoudongguangboyuci:SetSize(biaotiH-6,biaotiH-6);
daiben.nr.shoudongguangboyuci:SetPoint("TOPLEFT",daiben.nr.TMlinx2,"TOPLEFT",180,-3);
daiben.nr.shoudongguangboyuci.highlight = daiben.nr.shoudongguangboyuci:CreateTexture(nil, "HIGHLIGHT");
daiben.nr.shoudongguangboyuci.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
daiben.nr.shoudongguangboyuci.highlight:SetBlendMode("ADD")
daiben.nr.shoudongguangboyuci.highlight:SetPoint("CENTER", daiben.nr.shoudongguangboyuci, "CENTER", 0,0);
daiben.nr.shoudongguangboyuci.highlight:SetSize(22,22);
daiben.nr.shoudongguangboyuci.Tex = daiben.nr.shoudongguangboyuci:CreateTexture(nil, "BORDER");
daiben.nr.shoudongguangboyuci.Tex:SetTexture(130979);
daiben.nr.shoudongguangboyuci.Tex:SetPoint("CENTER",4,0);
daiben.nr.shoudongguangboyuci.Tex:SetSize(24,24);
daiben.nr.shoudongguangboyuci:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(daiben.nr.shoudongguangboyuci, "ANCHOR_TOPLEFT",20,0);
	GameTooltip:AddLine("|cff00ff00点击通报队内成员剩余金额/次数|r")
	GameTooltip:Show();
end);
daiben.nr.shoudongguangboyuci:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
daiben.nr.shoudongguangboyuci:SetScript("OnMouseDown", function ()
	daiben.nr.shoudongguangboyuci.Tex:SetPoint("CENTER",2.5,-1.5);
end);
daiben.nr.shoudongguangboyuci:SetScript("OnMouseUp", function ()
	daiben.nr.shoudongguangboyuci.Tex:SetPoint("CENTER",4,0);
end);
daiben.nr.shoudongguangboyuci:SetScript("OnClick", function()
	shoudongbobao()
end)

---退款
daiben.nr.tuikuan = CreateFrame("Button",nil,daiben.nr);  
daiben.nr.tuikuan:SetSize(biaotiH-2,biaotiH-4);
daiben.nr.tuikuan:SetPoint("TOPLEFT",daiben.nr.TMlinx2,"TOPLEFT",230,-2.4);
daiben.nr.tuikuan.highlight = daiben.nr.tuikuan:CreateTexture(nil, "HIGHLIGHT");
daiben.nr.tuikuan.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
daiben.nr.tuikuan.highlight:SetBlendMode("ADD")
daiben.nr.tuikuan.highlight:SetPoint("CENTER", daiben.nr.tuikuan, "CENTER", 0,0);
daiben.nr.tuikuan.highlight:SetSize(22,22);
daiben.nr.tuikuan.Tex = daiben.nr.tuikuan:CreateTexture(nil, "BORDER");
daiben.nr.tuikuan.Tex:SetTexture("interface/cursor/mail.blp");
daiben.nr.tuikuan.Tex:SetTexCoord(0,1,0.23,1);
daiben.nr.tuikuan.Tex:SetPoint("CENTER",0,-3);
daiben.nr.tuikuan.Tex:SetSize(24,20);
daiben.nr.tuikuan:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
	GameTooltip:AddLine("|cff00ff00退款|r")
	GameTooltip:Show();
end);
daiben.nr.tuikuan:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
daiben.nr.tuikuan:SetScript("OnMouseDown", function ()
	daiben.nr.tuikuan.Tex:SetPoint("CENTER",-1.5,-4.5);
end);
daiben.nr.tuikuan:SetScript("OnMouseUp", function ()
	daiben.nr.tuikuan.Tex:SetPoint("CENTER",0,-3);
end);
--------------------
local tuikuanW,tuikuanH = 400,508;
daiben.nr.tuikuan.F = CreateFrame("Frame", "tuikuan_F_UI", daiben.nr.tuikuan,"BackdropTemplate");
daiben.nr.tuikuan.F:SetBackdrop( { bgFile = "interface/characterframe/ui-party-background.blp",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = false, tileSize = 0, edgeSize = 14, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 } });
daiben.nr.tuikuan.F:SetSize(tuikuanW,tuikuanH);
daiben.nr.tuikuan.F:SetPoint("CENTER",UIParent,"CENTER",0,0);
daiben.nr.tuikuan.F:EnableMouse(true)
daiben.nr.tuikuan.F:SetMovable(true)
daiben.nr.tuikuan.F:SetClampedToScreen(true)
daiben.nr.tuikuan.F:Hide()
tinsert(UISpecialFrames,"tuikuan_F_UI");
daiben.nr.tuikuan.F.yidong = CreateFrame("Frame", nil, daiben.nr.tuikuan.F);
daiben.nr.tuikuan.F.yidong:SetSize(tuikuanW-60,24);
daiben.nr.tuikuan.F.yidong:SetPoint("TOP", daiben.nr.tuikuan.F, "TOP", 0, -1);
daiben.nr.tuikuan.F.yidong:EnableMouse(true)
daiben.nr.tuikuan.F.yidong:RegisterForDrag("LeftButton")
daiben.nr.tuikuan.F.yidong:SetScript("OnDragStart",function()
	daiben.nr.tuikuan.F:StartMoving()
end)
daiben.nr.tuikuan.F.yidong:SetScript("OnDragStop",function()
	daiben.nr.tuikuan.F:StopMovingOrSizing()
end)
daiben.nr.tuikuan.F.Biaoti = daiben.nr.tuikuan.F:CreateFontString();
daiben.nr.tuikuan.F.Biaoti:SetPoint("CENTER", daiben.nr.tuikuan.F.yidong, "CENTER", 0,0);
daiben.nr.tuikuan.F.Biaoti:SetFontObject(GameFontNormal);
daiben.nr.tuikuan.F.Biaoti:SetText("有余额玩家明细");
daiben.nr.tuikuan.F.Close = CreateFrame("Button",nil,daiben.nr.tuikuan.F, "UIPanelCloseButton");  
daiben.nr.tuikuan.F.Close:SetSize(30,30);
daiben.nr.tuikuan.F.Close:SetPoint("TOPRIGHT",daiben.nr.tuikuan.F,"TOPRIGHT",3,2);
daiben.nr.tuikuan.F.linx = daiben.nr.tuikuan.F:CreateLine()
daiben.nr.tuikuan.F.linx:SetColorTexture(1,1,1,0.5)
daiben.nr.tuikuan.F.linx:SetThickness(1);
daiben.nr.tuikuan.F.linx:SetStartPoint("TOPLEFT",3,-24)
daiben.nr.tuikuan.F.linx:SetEndPoint("TOPRIGHT",-3,-24)
-------
daiben.nr.tuikuan.F.nr = CreateFrame("Frame", nil, daiben.nr.tuikuan.F);
daiben.nr.tuikuan.F.nr:SetPoint("TOPLEFT",daiben.nr.tuikuan.F,"TOPLEFT",0,-48);
daiben.nr.tuikuan.F.nr:SetPoint("BOTTOMRIGHT",daiben.nr.tuikuan.F,"BOTTOMRIGHT",0,0);
--
daiben.nr.tuikuan.F.nr.biaoti1 = daiben.nr.tuikuan.F.nr:CreateFontString();
daiben.nr.tuikuan.F.nr.biaoti1:SetPoint("BOTTOMLEFT", daiben.nr.tuikuan.F.nr, "TOPLEFT", 16,4);
daiben.nr.tuikuan.F.nr.biaoti1:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
daiben.nr.tuikuan.F.nr.biaoti1:SetText("\124cffffff00玩家名\124r");
daiben.nr.tuikuan.F.nr.biaoti2 = daiben.nr.tuikuan.F.nr:CreateFontString();
daiben.nr.tuikuan.F.nr.biaoti2:SetPoint("BOTTOMLEFT", daiben.nr.tuikuan.F.nr, "TOPLEFT", 240,4);
daiben.nr.tuikuan.F.nr.biaoti2:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
daiben.nr.tuikuan.F.nr.biaoti2:SetText("\124cffffff00余额\124r");
daiben.nr.tuikuan.F.nr.biaoti3 = daiben.nr.tuikuan.F.nr:CreateFontString();
daiben.nr.tuikuan.F.nr.biaoti3:SetPoint("BOTTOMLEFT", daiben.nr.tuikuan.F.nr, "TOPLEFT", 320,4);
daiben.nr.tuikuan.F.nr.biaoti3:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
daiben.nr.tuikuan.F.nr.biaoti3:SetText("\124cffffff00退款状态\124r");
------------
local hang_Height,hang_NUM  = 30, 15;
local function gengxinhangTUIKUAN(self)
	for id = 1, hang_NUM do
		_G["tuikuan_hang_"..id]:Hide();
    	_G["tuikuan_hang_"..id].Name:SetText();
    	_G["tuikuan_hang_"..id].yue:SetText();
    end
    --提取
    local youyuewanjia={} 
    for i=1,#PIG_Per["FarmRecord"]["namelist"] do
    	if PIG_Per["FarmRecord"]["namelist"][i][4]>0 then
    		table.insert(youyuewanjia,PIG_Per["FarmRecord"]["namelist"][i]);
    	end
    end
    ---
    local Num = #youyuewanjia
	if Num>0 then
	    FauxScrollFrame_Update(self, Num, hang_NUM, hang_Height);
	    local offset = FauxScrollFrame_GetOffset(self);
	    for id = 1, hang_NUM do
			local dangqian = id+offset;
			if youyuewanjia[dangqian] then
				_G["tuikuan_hang_"..id]:Show();	
				_G["tuikuan_hang_"..id].Name:SetText(youyuewanjia[dangqian][8]);
	    		_G["tuikuan_hang_"..id].yue:SetText(youyuewanjia[dangqian][4]);
	    	end
		end
	end
end
daiben.nr.tuikuan.F.nr.Scroll = CreateFrame("ScrollFrame",nil,daiben.nr.tuikuan.F.nr, "FauxScrollFrameTemplate");  
daiben.nr.tuikuan.F.nr.Scroll:SetPoint("TOPLEFT",daiben.nr.tuikuan.F.nr,"TOPLEFT",6,-4);
daiben.nr.tuikuan.F.nr.Scroll:SetPoint("BOTTOMRIGHT",daiben.nr.tuikuan.F.nr,"BOTTOMRIGHT",-28,5);
daiben.nr.tuikuan.F.nr.Scroll:SetScript("OnVerticalScroll", function(self, offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinhangTUIKUAN)
end)
--创建行
for id = 1, hang_NUM do
	daiben.nr.tuikuan.F.nr.hang = CreateFrame("Frame", "tuikuan_hang_"..id, daiben.nr.tuikuan.F.nr);
	daiben.nr.tuikuan.F.nr.hang:SetSize(tuikuanW-30, hang_Height);
	if id==1 then
		daiben.nr.tuikuan.F.nr.hang:SetPoint("TOP",daiben.nr.tuikuan.F.nr.Scroll,"TOP",0,0);
	else
		daiben.nr.tuikuan.F.nr.hang:SetPoint("TOP",_G["tuikuan_hang_"..(id-1)],"BOTTOM",0,-0);
	end
	if id~=hang_NUM then
		daiben.nr.tuikuan.F.nr.hang.line = daiben.nr.tuikuan.F.nr.hang:CreateLine()
		daiben.nr.tuikuan.F.nr.hang.line:SetColorTexture(1,1,1,0.2)
		daiben.nr.tuikuan.F.nr.hang.line:SetThickness(1);
		daiben.nr.tuikuan.F.nr.hang.line:SetStartPoint("TOPLEFT",0,0)
		daiben.nr.tuikuan.F.nr.hang.line:SetEndPoint("TOPRIGHT",0,0)
	end
	daiben.nr.tuikuan.F.nr.hang.Name = daiben.nr.tuikuan.F.nr.hang:CreateFontString();
	daiben.nr.tuikuan.F.nr.hang.Name:SetPoint("LEFT", daiben.nr.tuikuan.F.nr.hang, "LEFT", 10,0);
	daiben.nr.tuikuan.F.nr.hang.Name:SetSize(190,22);
	daiben.nr.tuikuan.F.nr.hang.Name:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	daiben.nr.tuikuan.F.nr.hang.Name:SetJustifyH("LEFT");
	daiben.nr.tuikuan.F.nr.hang.yue = daiben.nr.tuikuan.F.nr.hang:CreateFontString();
	daiben.nr.tuikuan.F.nr.hang.yue:SetPoint("LEFT", daiben.nr.tuikuan.F.nr.hang.Name, "RIGHT", 4,0);
	daiben.nr.tuikuan.F.nr.hang.yue:SetSize(60,22);
	daiben.nr.tuikuan.F.nr.hang.yue:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	daiben.nr.tuikuan.F.nr.hang.yue:SetJustifyH("RIGHT");
	----
	daiben.nr.tuikuan.F.nr.hang.mail = CreateFrame("Button",nil,daiben.nr.tuikuan.F.nr.hang, "TruncatedButtonTemplate");
	daiben.nr.tuikuan.F.nr.hang.mail:SetSize(32,24);
	daiben.nr.tuikuan.F.nr.hang.mail:SetPoint("RIGHT", daiben.nr.tuikuan.F.nr.hang, "RIGHT", -4,0);
	daiben.nr.tuikuan.F.nr.hang.mail.Tex = daiben.nr.tuikuan.F.nr.hang.mail:CreateTexture(nil, "BORDER");
	daiben.nr.tuikuan.F.nr.hang.mail.Tex:SetTexture("interface/cursor/mail.blp");
	daiben.nr.tuikuan.F.nr.hang.mail.Tex:SetTexCoord(0,1,0.23,1);
	daiben.nr.tuikuan.F.nr.hang.mail.Tex:SetPoint("CENTER",0,-3);
	daiben.nr.tuikuan.F.nr.hang.mail.Tex:SetSize(24,20);
	daiben.nr.tuikuan.F.nr.hang.mail:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",1,-4);
	end);
	daiben.nr.tuikuan.F.nr.hang.mail:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER",0,-3);
	end);
	daiben.nr.tuikuan.F.nr.hang.mail:SetScript("OnClick", function (self)
		local wanjianame=self:GetParent().Name:GetText()
		for i=1,#PIG_Per["FarmRecord"]["namelist"] do
			if wanjianame==PIG_Per["FarmRecord"]["namelist"][i][8] then
				if TradeFrame:IsVisible() then
					TradePlayerInputMoneyFrameGold:SetText(PIG_Per["FarmRecord"]["namelist"][i][4]);
					PIG_Per["FarmRecord"]["namelist"][i][4]=0
					self.Tex:SetDesaturated(true)
				else
					if ( MailFrame:IsVisible() and MailFrame.selectedTab == 2 ) then
						SendMailNameEditBox:SetText(wanjianame);
						SendMailSubjectEditBox:SetText("消费剩余尾款退款");
						SendMailMoneyGold:SetText(PIG_Per["FarmRecord"]["namelist"][i][4]);
						PIG_Per["FarmRecord"]["namelist"][i][4]=0
						self.Tex:SetDesaturated(true)
					else
						print("|cff00FFFF!Pig:|r|cffFFFF00请先打开交易界面或邮箱发件页面！|r");
					end
				end
			end
		end
	end);
end
-----------------------------
daiben.nr.tuikuan:SetScript("OnClick", function()	
	if daiben.nr.tuikuan.F:IsShown() then
		daiben.nr.tuikuan.F:Hide()
	else
		daiben.nr.tuikuan.F:SetFrameLevel(FrameLevel+20)
		daiben.nr.tuikuan.F:Show()
		gengxinhangTUIKUAN(tuikuan_F_UI.nr.Scroll)
	end
end)
--设置按钮
daiben.nr.setting = CreateFrame("Button",nil,daiben.nr, "TruncatedButtonTemplate"); 
daiben.nr.setting:SetNormalTexture("interface/gossipframe/bindergossipicon.blp"); 
daiben.nr.setting:SetHighlightTexture(130718);
daiben.nr.setting:SetSize(biaotiH-6,biaotiH-6);
daiben.nr.setting:SetPoint("TOPLEFT",daiben.nr.TMlinx2,"TOPLEFT",280,-4);
daiben.nr.setting.Down = daiben.nr.setting:CreateTexture(nil, "OVERLAY");
daiben.nr.setting.Down:SetTexture(130839);
daiben.nr.setting.Down:SetAllPoints(daiben.nr.setting)
daiben.nr.setting.Down:Hide();
daiben.nr.setting:SetScript("OnMouseDown", function (self)
	self.Down:Show();
end);
daiben.nr.setting:SetScript("OnMouseUp", function (self)
	self.Down:Hide();
end);
daiben.nr.setting:SetScript("OnClick", function (self)
	if Daiben_shezhi_F_UI:IsShown() then
		Daiben_shezhi_F_UI:Hide();
	else
		dakaishezhiUI()
	end
end);
--关闭按钮
daiben.nr.Close = CreateFrame("Button",nil,daiben.nr, "TruncatedButtonTemplate");
daiben.nr.Close:SetSize(biaotiH-6,biaotiH-6);
daiben.nr.Close:SetPoint("TOPLEFT",daiben.nr.TMlinx2,"TOPLEFT",324,-4);
daiben.nr.Close.highlight = daiben.nr.Close:CreateTexture(nil, "HIGHLIGHT");
daiben.nr.Close.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
daiben.nr.Close.highlight:SetBlendMode("ADD")
daiben.nr.Close.highlight:SetPoint("CENTER", daiben.nr.Close, "CENTER", 0,0);
daiben.nr.Close.highlight:SetSize(biaotiH-4,biaotiH-4);
daiben.nr.Close.Tex = daiben.nr.Close:CreateTexture(nil, "BORDER");
daiben.nr.Close.Tex:SetTexture("interface/common/voicechat-muted.blp");
daiben.nr.Close.Tex:SetPoint("CENTER");
daiben.nr.Close.Tex:SetSize(biaotiH-10,biaotiH-10)
daiben.nr.Close:SetScript("OnMouseDown", function (self)
	self.Tex:SetPoint("CENTER",-1.5,-1.5);
end);
daiben.nr.Close:SetScript("OnMouseUp", function (self)
	self.Tex:SetPoint("CENTER");
end);
daiben.nr.Close:SetScript("OnClick", function (self)
	StaticPopup_Show("GUANBIDAIBENZHUSHOU")
end)
StaticPopupDialogs["GUANBIDAIBENZHUSHOU"] = {
	text = "|cff00FFFF!Pig"..gongnengName.."：|r\n关闭"..gongnengName.."?\n",
	button1 = "是",
	button2 = "否",
	OnAccept = function()
		daiben:Hide();
		daiben.yesno:SetChecked(false)
		PIG_Per["FarmRecord"]['autohuifu']="OFF"
		daiben.yesno.Tex:SetTexture("interface/common/indicator-red.blp");
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
---=======================================================
--清空
StaticPopupDialogs["QINGKONG_TIME_JILUXX"] = {
	text = "|cff00FFFF!Pig"..gongnengName.."：|r\n\124cffff0000清空\124r副本时间和本次刷本次数吗?",
	button1 = "是",
	button2 = "否",
	OnAccept = function()
		PIG_Per["FarmRecord"]["Time"]={{},{},{},{},{}};
		PIG_Per["FarmRecord"]["shuabenshu"] = 0;
		TimeInfo_Update()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
------
local function Time_NEW(instancename)
	if IsInGroup() then
		PIG_Per["FarmRecord"]["DuiwuNei"][1]=true
		if UnitIsGroupLeader("player") then
			PIG_Per["FarmRecord"]["DuiwuNei"][2]=true
		else
			PIG_Per["FarmRecord"]["DuiwuNei"][2]=false
		end
	else
		PIG_Per["FarmRecord"]["DuiwuNei"][1]=false
		PIG_Per["FarmRecord"]["DuiwuNei"][2]=false
	end
	PIG_Per["FarmRecord"]["YijingCZ"]="OFF";
	PIG_Per["FarmRecord"]['Time'][1]=PIG_Per["FarmRecord"]['Time'][2]
	PIG_Per["FarmRecord"]['Time'][2]=PIG_Per["FarmRecord"]['Time'][3]
	PIG_Per["FarmRecord"]['Time'][3]=PIG_Per["FarmRecord"]['Time'][4]
	PIG_Per["FarmRecord"]['Time'][4]=PIG_Per["FarmRecord"]['Time'][5]
	PIG_Per["FarmRecord"]['Time'][5]={GetServerTime(),nil,nil,0,{},instancename,0,{}}
	TimeInfo_Update()
end
--新CD提示框
StaticPopupDialogs["NEW_FUBEN_RECORD"] = {
	text = "|cff00FFFF!Pig"..gongnengName.."：|r\n%s",
	button1 = "是",
	button2 = "否",
	OnAccept = function()
		local instancename = GetInstanceInfo()
		Time_NEW(instancename)
	end,
	OnCancel = function()
		if IsInGroup() then
			PIG_Per["FarmRecord"]["DuiwuNei"][1]=true
			if UnitIsGroupLeader("player") then
				PIG_Per["FarmRecord"]["DuiwuNei"][2]=true
			else
				PIG_Per["FarmRecord"]["DuiwuNei"][2]=false
			end
		else
			PIG_Per["FarmRecord"]["DuiwuNei"][1]=false
			PIG_Per["FarmRecord"]["DuiwuNei"][2]=false
		end
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
--计时功能
local querenkuangARG1="这是\124cff00ff00新的\124r副本CD吗?"
local function TimeRecord()
	local instancename, instanceType, difficultyID, difficultyName, maxPlayers = GetInstanceInfo()
	if instanceType=="party" or instanceType=="raid" and maxPlayers~=40 then
		PIG_Per["FarmRecord"]['Time_Over']=GetServerTime()
		FarmRecordFFFFF_UI:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		FarmRecordFFFFF_UI:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
		FarmRecordFFFFF_UI:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
		PIG_Per["FarmRecord"]["FBneiYN"]="ON";
		if PIG_Per["FarmRecord"]["YijingCZ"]=="ON" then
			Time_NEW(instancename)
			return
		end
		---
		if instancename~=PIG_Per["FarmRecord"]["Time"][5][6] then
			Time_NEW(instancename)
			return
		end
		---
		if GetServerTime()-PIG_Per["FarmRecord"]['Time_Over']>1800 then
			Time_NEW(instancename)
			return
		end
		--
		if PIG_Per["FarmRecord"]["Time"][5][2] then
			if GetServerTime()-PIG_Per["FarmRecord"]["Time"][5][2]>1800 then
				Time_NEW(instancename)
				return
			end
		end
		-----
		if IsInGroup()==PIG_Per["FarmRecord"]["DuiwuNei"][1] then
			if UnitIsGroupLeader("player")==PIG_Per["FarmRecord"]["DuiwuNei"][2] then
				--
			else
				StaticPopup_Show("NEW_FUBEN_RECORD",querenkuangARG1)
			end
		else
			StaticPopup_Show("NEW_FUBEN_RECORD",querenkuangARG1)
		end
	end
	if instanceType=="none" then
		FarmRecordFFFFF_UI:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		FarmRecordFFFFF_UI:UnregisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
		FarmRecordFFFFF_UI:UnregisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
		if PIG_Per["FarmRecord"]["FBneiYN"]=="ON" then
			PIG_Per["FarmRecord"]['Time'][5][2]=GetServerTime();
			PIG_Per["FarmRecord"]["FBneiYN"]="OFF";
		end
	end
end
------------------------------------------------------
local daibenzhushoujiaoyixinxin={0,nil}
local dianjichongfujiansudu = 0 --重置间隔
local FarmRecordFFFFF = CreateFrame("Frame","FarmRecordFFFFF_UI");
--FarmRecordFFFFF_UI:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
--FarmRecordFFFFF_UI:RegisterEvent("CHAT_MSG_SAY");
--FarmRecordFFFFF:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
FarmRecordFFFFF:SetScript("OnEvent",function (self,event,arg1,arg2,_,_,arg5,_,_,_,_,_,_,arg12)
	if event=="GROUP_ROSTER_UPDATE" then
		C_Timer.After(2,gengxinjizhangData)
	end
	if event=="PLAYER_MONEY" then
		gengxinshouru()
	end
	if event=="PLAYER_ENTERING_WORLD" then 
		local name, instanceType = GetInstanceInfo()
		if instanceType=="none" then
			if PIG_Per["FarmRecord"]["YijingCZ"] == "ON" then
				daiben.CZbutton:SetText(jiuweiTXT)
			elseif PIG_Per["FarmRecord"]["YijingCZ"] == "OFF" then
				daiben.CZbutton:SetText(chongzhiTXT)
			end
		else
			daiben.CZbutton:SetText(jiuweiTXT)
		end 
		if arg1 or arg2 then
			--print("加载UI")
		else
			TimeRecord()
		end
	end

	if event=="PLAYER_LOGOUT" then 
		PIG_Per["FarmRecord"]['Time_Over']=GetServerTime() 
		PIG_Per["FarmRecord"]["shouruG"][2] = GetServerTime();
	end
	--副本重置
	local function daiben_bobao()
		if UnitIsGroupLeader("player") then
			if PIG_Per["FarmRecord"]['autobobao']=="ON" then
				if PIG_Per["FarmRecord"]['Time'][5][1] and PIG_Per["FarmRecord"]['Time'][5][2] then
					local fubenhaoshi=PIG_Per["FarmRecord"]['Time'][5][2]-PIG_Per["FarmRecord"]['Time'][5][1]
					local fubenhaoshi=date("%M分%S秒", fubenhaoshi)
					SendChatMessage("[!Pig] "..PIG_Per["FarmRecord"]["autobobao_TXT"][1]..fubenhaoshi..PIG_Per["FarmRecord"]["autobobao_TXT"][2]..PIG_Per["FarmRecord"]['Time'][5][4].."。", "PARTY", nil);
				end
				shoudongbobao()
			end
			SendChatMessage("[!Pig] {rt1}副本已重置，副本内的玩家请退出副本重进{rt1}", "PARTY", nil);
		end
	end
	local function zhixingCZ()
		daiben.CZbutton:SetText(jiuweiTXT)
		PIG_Per["FarmRecord"]["YijingCZ"] = "ON";
		shoudongkouqian()
		gengxinjizhangData("CZ")
		PIG_Per["FarmRecord"]["shuabenshu"] = PIG_Per["FarmRecord"]["shuabenshu"]+1
		PIG_Per["FarmRecord"]['Time'][5][3]=GetServerTime();
		TimeInfo_Update()
	end
	if event=="CHAT_MSG_SYSTEM" then
	--if event=="CHAT_MSG_SAY" or event=="CHAT_MSG_SYSTEM" then
		if (arg1:find("已被重置"))~=nil or (arg1:find("无法重置"))~=nil then
			if GetServerTime()-dianjichongfujiansudu>2 then	
				zhixingCZ()
				daiben_bobao()
				dianjichongfujiansudu = GetServerTime()
			end
		end
	end
	if not UnitIsGroupLeader("player") then
		--if event=="CHAT_MSG_SAY" then
		if event=="CHAT_MSG_PARTY_LEADER" or event=="CHAT_MSG_RAID_LEADER" then
			if (arg1:find("已被重置"))~=nil or (arg1:find("已重置"))~=nil or (arg1:find("reset"))~=nil then
				if GetServerTime()-dianjichongfujiansudu>2 then
					zhixingCZ()
					dianjichongfujiansudu = GetServerTime()
					if PIG_Per["FarmRecord"]['autobobao']=="ON" then
						local EXP_FACTION ="[!Pig] 上次副本获得"
						local bencihuodeV =PIG_Per["FarmRecord"]['Time'][5][7]
						if bencihuodeV>0 then
							local zuidaXP = UnitXPMax("player")
							local dangqianXP = UnitXP("player")
							local haichazhi = zuidaXP-dangqianXP
							local baifenbi = math.ceil((haichazhi/bencihuodeV)*10)
							EXP_FACTION=EXP_FACTION.."经验值为："..bencihuodeV..", 升级还差："..haichazhi.."（"..(baifenbi/10).."次）"
						end
						local shengwangzhiNUM =#PIG_Per["FarmRecord"]['Time'][5][8]
						if shengwangzhiNUM>0 then
							local dabenshengwanghuoquV =""
							for g=1,shengwangzhiNUM do
								if g==1 then
									dabenshengwanghuoquV=dabenshengwanghuoquV.."声望值："..PIG_Per["FarmRecord"]['Time'][5][8][g][2].."("..PIG_Per["FarmRecord"]['Time'][5][8][g][1]..")"
								else
									dabenshengwanghuoquV=dabenshengwanghuoquV..";"..PIG_Per["FarmRecord"]['Time'][5][8][g][2].."("..PIG_Per["FarmRecord"]['Time'][5][8][g][1]..")"
								end
							end
							EXP_FACTION=EXP_FACTION..dabenshengwanghuoquV
						end
						if EXP_FACTION ~="[!Pig] 上次副本获得" then
							SendChatMessage(EXP_FACTION, "PARTY", nil);
						end
					end
				end
			end
		end
	end
	--杀怪
	if event=="COMBAT_LOG_EVENT_UNFILTERED" then
		local xiaodongwuguolv={
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
		}
		local Combat1,Combat2,Combat3,Combat4,Combat5,Combat6,Combat7,Combat8,Combat9= CombatLogGetCurrentEventInfo();
		--print(CombatLogGetCurrentEventInfo())
		if Combat2=="UNIT_DIED" then
			--Creature   -0-    976-          0-           11-          31146-  000136DF91"
			--[单位类型]  -0-   [服务器 ID]-   [实例 ID]-   [区域 UID]-   [ID]-   [生成 UID]
			local _, _, _, zhongleiXC = Combat8:find("((.-)%-)");
			if zhongleiXC=="Creature" then
				local jiequhou1 =Combat8:sub(10,-12)
				local b, bb, bbb, jiequhou2 = jiequhou1:find("(%-(%w+))$",1);
				for i=1,#xiaodongwuguolv do--不是小动物
					if tonumber(jiequhou2)==xiaodongwuguolv[i] then return end
				end
						
				PIG_Per["FarmRecord"]['Time'][5][4]=PIG_Per["FarmRecord"]['Time'][5][4]+1;
				--明细
				for j=1,#PIG_Per["FarmRecord"]["Time"][5][5] do
					if PIG_Per["FarmRecord"]["Time"][5][5][j][1]==Combat9 then
						PIG_Per["FarmRecord"]["Time"][5][5][j][2]=PIG_Per["FarmRecord"]["Time"][5][5][j][2]+1;
						return
					end
				end
				table.insert(PIG_Per["FarmRecord"]["Time"][5][5], {Combat9,1});
			end
		end
	end
	if event=="CHAT_MSG_COMBAT_XP_GAIN" then
		local _, _, _, wanjianameXXk = arg1:find("(你获得了(.+)点经验值)");
		local expV = tonumber(wanjianameXXk)
		if expV then
			PIG_Per["FarmRecord"]['Time'][5][7]=PIG_Per["FarmRecord"]['Time'][5][7]+expV
		end
	end
	if event=="CHAT_MSG_COMBAT_FACTION_CHANGE" then
		local _, _, _, shengwangName = arg1:find("(你在(.+)中的声望)");
		local _, _, _, shengwangV = arg1:find("(声望值提高了(.+)点)");	
		if shengwangName and shengwangV then
			local V = tonumber(shengwangV)
			if PIG_Per["FarmRecord"]['Time'][5][8] then
				for i=1,#PIG_Per["FarmRecord"]['Time'][5][8] do
					if PIG_Per["FarmRecord"]['Time'][5][8][i][1]==shengwangName then
						PIG_Per["FarmRecord"]['Time'][5][8][i][2]=PIG_Per["FarmRecord"]['Time'][5][8][i][2]+V
						return
					end
				end
				table.insert(PIG_Per["FarmRecord"]['Time'][5][8],{shengwangName,V})
			else
				PIG_Per["FarmRecord"]['Time'][5][8]={}
				table.insert(PIG_Per["FarmRecord"]['Time'][5][8],{shengwangName,V})
			end
		end
	end
	if event=="CHAT_MSG_WHISPER" then
		if PIG_Per["FarmRecord"]['autohuifu']=="ON" then
			local isLeader = UnitIsGroupLeader("player", "LE_PARTY_CATEGORY_HOME");
			if isLeader or not IsInGroup() then
				local bubaohanchajainqianzhui=arg1:find("[!Pig]", 1)
				if not bubaohanchajainqianzhui then
					--触发关键字
					for i=1,#PIG_Per["FarmRecord"]["autohuifu_TXT"] do
						local yijingyouduiwu=arg1:find(PIG_Per["FarmRecord"]["autohuifu_TXT"][i], 1)
						if yijingyouduiwu then
							local IsInRaid=IsInRaid("LE_PARTY_CATEGORY_HOME");
							if IsInRaid then
									local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
									if numGroupMembers<40 then
										daiben.huifuneirongMSG="[!Pig] 尚有坑位<团队>:"..(40-numGroupMembers).."，";
										if PIG_Per["FarmRecord"]['autohuifu_danjia']=="ON" then
											daiben.kaishiLV=nil
											daiben.jieshuLV=nil
											for id = 1, 4, 1 do
												local kaishi =PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][1]
												if kaishi~=0 then
													if daiben.kaishiLV==nil then
														daiben.kaishiLV=kaishi
													else
														if daiben.kaishiLV>kaishi then
															daiben.kaishiLV=kaishi
														end
													end
												end
												local jieshu =PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][2]
												if jieshu~=0 then
													if daiben.jieshuLV==nil then
														daiben.jieshuLV=jieshu
													else
														if daiben.jieshuLV<jieshu then
															daiben.jieshuLV=jieshu
														end
													end
												end
											end
											if daiben.kaishiLV and daiben.jieshuLV then
												daiben.huifuneirongMSG=daiben.huifuneirongMSG.."级别要求("..daiben.kaishiLV.."-"..daiben.jieshuLV..")，价格:";
												daiben.danjiafanwei_jia={};
												daiben.danjiafanwei_LV={};
												for i=daiben.kaishiLV,daiben.jieshuLV,1 do
													local danjiashunxue=jisuandanjia(i);
													if i==daiben.kaishiLV then
														table.insert(daiben.danjiafanwei_jia, danjiashunxue);
														table.insert(daiben.danjiafanwei_LV, {i});
													else
														if daiben.danjiafanwei_jia[#daiben.danjiafanwei_jia]~=danjiashunxue then
															table.insert(daiben.danjiafanwei_jia, danjiashunxue);
															table.insert(daiben.danjiafanwei_LV, {i});
														else
															table.insert(daiben.danjiafanwei_LV[#daiben.danjiafanwei_jia], i);
														end
													end
												end

												for i=1,#daiben.danjiafanwei_jia do
													if daiben.danjiafanwei_jia[i]>0 then
														daiben.huifuneirongMSG=daiben.huifuneirongMSG.."<"..daiben.danjiafanwei_LV[i][1].."-"..daiben.danjiafanwei_LV[i][#daiben.danjiafanwei_LV[i]]..">"..daiben.danjiafanwei_jia[i].."G；";
													else
														daiben.huifuneirongMSG=daiben.huifuneirongMSG.."<"..daiben.danjiafanwei_LV[i][1].."-"..daiben.danjiafanwei_LV[i][#daiben.danjiafanwei_LV[i]]..">免费；";
													end
												end
											end	
										end
										if PIG_Per["FarmRecord"]['autoyaoqing']=="ON" then
											daiben.huifuneirongMSG=daiben.huifuneirongMSG.."回复"..PIG_Per["FarmRecord"]["autohuifu_inv"].."进组";
										end
										SendChatMessage(daiben.huifuneirongMSG, "WHISPER", nil, arg5);
									else
										SendChatMessage("[!Pig] 位置已满，感谢支持！", "WHISPER", nil, arg5);
									end
							else-------------------------------------
									local numSubgroupMembers = GetNumSubgroupMembers("LE_PARTY_CATEGORY_HOME")
									if numSubgroupMembers<4 then
										daiben.huifuneirongMSG="[!Pig]"..PIG_Per["FarmRecord"]["autohuifu_Qianzhui"]..",尚有坑位:"..(4-numSubgroupMembers).."，";
										if PIG_Per["FarmRecord"]['huifudengji']=="ON" then
											if numSubgroupMembers>0 and numSubgroupMembers<4 then
												daiben.huifuneirongMSG=daiben.huifuneirongMSG.."队内LV("
												for id=1,numSubgroupMembers do
														local dengjiKk = UnitLevel("Party"..id);
														if id==numSubgroupMembers then
															daiben.huifuneirongMSG=daiben.huifuneirongMSG..dengjiKk;
														else
															daiben.huifuneirongMSG=daiben.huifuneirongMSG..dengjiKk..",";
														end
												end
												daiben.huifuneirongMSG=daiben.huifuneirongMSG.."),"
											end
										end

										if PIG_Per["FarmRecord"]['autohuifu_danjia']=="ON" then
											daiben.kaishiLV=nil
											daiben.jieshuLV=nil
											for id = 1, 4, 1 do
												local kaishi =PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][1]
												if kaishi~=0 then
													if daiben.kaishiLV==nil then
														daiben.kaishiLV=kaishi
													else
														if daiben.kaishiLV>kaishi then
															daiben.kaishiLV=kaishi
														end
													end
												end
												local jieshu =PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][2]
												if jieshu~=0 then
													if daiben.jieshuLV==nil then
														daiben.jieshuLV=jieshu
													else
														if daiben.jieshuLV<jieshu then
															daiben.jieshuLV=jieshu
														end
													end
												end
											end
											if daiben.kaishiLV and daiben.jieshuLV then
												daiben.huifuneirongMSG=daiben.huifuneirongMSG.."级别要求("..daiben.kaishiLV.."-"..daiben.jieshuLV..")，价格:";
												daiben.danjiafanwei_jia={};
												daiben.danjiafanwei_LV={};

												for i=daiben.kaishiLV,daiben.jieshuLV,1 do
													local danjiashunxue=jisuandanjia(i);
													if i==daiben.kaishiLV then
														table.insert(daiben.danjiafanwei_jia, danjiashunxue);
														table.insert(daiben.danjiafanwei_LV, {i});
													else
														if daiben.danjiafanwei_jia[#daiben.danjiafanwei_jia]~=danjiashunxue then
															table.insert(daiben.danjiafanwei_jia, danjiashunxue);
															table.insert(daiben.danjiafanwei_LV, {i});
														else
															table.insert(daiben.danjiafanwei_LV[#daiben.danjiafanwei_jia], i);
														end
													end
												end

												for i=1,#daiben.danjiafanwei_jia do
													if daiben.danjiafanwei_jia[i]>0 then
														daiben.huifuneirongMSG=daiben.huifuneirongMSG.."<"..daiben.danjiafanwei_LV[i][1].."-"..daiben.danjiafanwei_LV[i][#daiben.danjiafanwei_LV[i]]..">"..daiben.danjiafanwei_jia[i].."G；";
													else
														daiben.huifuneirongMSG=daiben.huifuneirongMSG.."<"..daiben.danjiafanwei_LV[i][1].."-"..daiben.danjiafanwei_LV[i][#daiben.danjiafanwei_LV[i]]..">免费；";
													end
												end
											end	
										end
										if PIG_Per["FarmRecord"]['autoyaoqing']=="ON" then
											daiben.huifuneirongMSG=daiben.huifuneirongMSG.."回复"..PIG_Per["FarmRecord"]["autohuifu_inv"].."进组";
										end
										SendChatMessage(daiben.huifuneirongMSG, "WHISPER", nil, arg5);
									else
										SendChatMessage("[!Pig] 位置已满，感谢支持！", "WHISPER", nil, arg5);
									end
							end
							break
						end
					end
					---触发自动邀请
					if PIG_Per["FarmRecord"]['autoyaoqing']=="ON" then
						local isLeader = UnitIsGroupLeader("player", "LE_PARTY_CATEGORY_HOME");
						if isLeader or not IsInGroup() then
							local chufazidongyaoqingV=arg1:find(PIG_Per["FarmRecord"]["autohuifu_inv"], 1)
							if chufazidongyaoqingV then
								local IsInRaid=IsInRaid("LE_PARTY_CATEGORY_HOME");
								if IsInRaid then
									local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
									if numGroupMembers<40 then	
										InviteUnit(arg5)
									else
										SendChatMessage("[!Pig] 位置已满，感谢支持！", "WHISPER", nil, arg5);
									end
								else
									local numSubgroupMembers = GetNumSubgroupMembers("LE_PARTY_CATEGORY_HOME")
									if numSubgroupMembers<4 then	
										InviteUnit(arg5)
									else
										SendChatMessage("[!Pig] 位置已满，感谢支持！", "WHISPER", nil, arg5);
									end
								end
							end
						end
					end
				end
			end
		end
	end
	--------
	if event=="TRADE_SHOW" then
		daibenzhushoujiaoyixinxin={0,TradeFrameRecipientNameText:GetText()}
	end
	if event=="TRADE_PLAYER_ITEM_CHANGED" or event=="TRADE_TARGET_ITEM_CHANGED" or event=="TRADE_ACCEPT_UPDATE" or event=="TRADE_MONEY_CHANGED" then
		daibenzhushoujiaoyixinxin[1]=GetTargetTradeMoney();
	end
	if event=="UI_INFO_MESSAGE" then
		if arg2=="交易完成" then		
			for nn=1,#PIG_Per["FarmRecord"]["namelist"],1 do
				if PIG_Per["FarmRecord"]["namelist"][nn] then
					if PIG_Per["FarmRecord"]["namelist"][nn][1]==daibenzhushoujiaoyixinxin[2] then
						PIG_Per["FarmRecord"]["namelist"][nn][4]=PIG_Per["FarmRecord"]["namelist"][nn][4]+(daibenzhushoujiaoyixinxin[1]/10000)
						gengxinjizhangData()
						break
					end
				end
			end
		end
	end
end);
---===========================================================================
fuFrame.daiben = fuFrame:CreateLine()
fuFrame.daiben:SetColorTexture(1,1,1,0.4)
fuFrame.daiben:SetThickness(1);
fuFrame.daiben:SetStartPoint("TOPLEFT",2,-340)
fuFrame.daiben:SetEndPoint("TOPRIGHT",-2,-340)
---------------
--添加快捷打开按钮
local function ADD_daibenzhushou()
	PIG_Per["FarmRecord"] =PIG_Per["FarmRecord"] or addonTable.Default_Per["FarmRecord"]
	if PIG_Per["FarmRecord"]["AddBut"]=="ON" then
		fuFrame.FarmRecordBUT_ADD:SetChecked(true);
	end
	if PIG['Classes']['Assistant']=="ON" and PIG_Per["FarmRecord"]["Kaiqi"]=="ON" then
		fuFrame.FarmRecordBUT_ADD:Enable();
	else
		fuFrame.FarmRecordBUT_ADD:Disable();
	end
	if PIG['Classes']['Assistant']=="ON" and PIG_Per["FarmRecord"]["Kaiqi"]=="ON" and PIG_Per["FarmRecord"]["AddBut"]=="ON" then
		if daibenzhushou_but_UI==nil then
			local aciWidth = ActionButton1:GetWidth()
			local Width,Height=aciWidth,aciWidth;
			local daibenzhushou_but = CreateFrame("Button", "daibenzhushou_but_UI", Classes_UI.nr);
			daibenzhushou_but:SetNormalTexture("interface/icons/inv_misc_pocketwatch_02.blp");
			daibenzhushou_but:SetHighlightTexture(130718);
			daibenzhushou_but:SetSize(Width-1,Height-1);
			local geshu = {Classes_UI.nr:GetChildren()};
			if #geshu==0 then
				daibenzhushou_but:SetPoint("LEFT",Classes_UI.nr,"LEFT",0,0);
			else
				local Width=Width+2
				daibenzhushou_but:SetPoint("LEFT",Classes_UI.nr,"LEFT",#geshu*Width-Width,0);
			end
			daibenzhushou_but:RegisterForClicks("LeftButtonUp","RightButtonUp");

			daibenzhushou_but:SetScript("OnEnter", function ()
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(daibenzhushou_but, "ANCHOR_TOPLEFT",2,4);
				GameTooltip:AddLine("左击-|cff00FFFF打开"..gongnengName.."|r")
				GameTooltip:Show();
			end);
			daibenzhushou_but:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);

			daibenzhushou_but.Border = daibenzhushou_but:CreateTexture(nil, "BORDER");
			daibenzhushou_but.Border:SetTexture(130841);
			daibenzhushou_but.Border:ClearAllPoints();
			daibenzhushou_but.Border:SetPoint("TOPLEFT",daibenzhushou_but,"TOPLEFT",-Width*0.38,Height*0.39);
			daibenzhushou_but.Border:SetPoint("BOTTOMRIGHT",daibenzhushou_but,"BOTTOMRIGHT",Width*0.4,-Height*0.4);

			daibenzhushou_but.Down = daibenzhushou_but:CreateTexture(nil, "OVERLAY");
			daibenzhushou_but.Down:SetTexture(130839);
			daibenzhushou_but.Down:SetAllPoints(daibenzhushou_but)
			daibenzhushou_but.Down:Hide();

			daibenzhushou_but.yunxingzhong = daibenzhushou_but:CreateTexture(nil, "OVERLAY");
			daibenzhushou_but.yunxingzhong:SetTexture("interface/common/indicator-green.blp");
			daibenzhushou_but.yunxingzhong:SetSize(Width-14,Height-14);
			daibenzhushou_but.yunxingzhong:SetPoint("TOPRIGHT",daibenzhushou_but,"TOPRIGHT",1,1);
			daibenzhushou_but.yunxingzhong:Hide()

			daibenzhushou_but:SetScript("OnMouseDown", function ()
				daibenzhushou_but.Down:Show();
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			daibenzhushou_but:SetScript("OnMouseUp", function ()
				daibenzhushou_but.Down:Hide();
			end);
			daibenzhushou_but:SetScript("OnClick", function(event, button)
				if daiben_UI:IsShown() then
					daiben_UI:Hide();
					if PIG_Per["FarmRecord"]['autohuifu']=="ON" then
						daibenzhushou_but.yunxingzhong:Show()
					end
				else
					daiben_UI:SetFrameLevel(FrameLevel);
					daiben_UI:Show();
					daibenzhushou_but.yunxingzhong:Hide()
					if PIG_Per["FarmRecord"]["MaxMin"]=="ON" then
						daiben.nr:Hide();
						daiben_UI:SetHeight(32);
						daiben.Max_Min:SetNormalTexture("interface/chatframe/ui-chaticon-maximize-up.blp");
						daiben.Max_Min:SetPushedTexture("interface/chatframe/ui-chaticon-maximize-down.blp")
					end
				end
			end);
		end
		addonTable.Classes_gengxinkuanduinfo()
	end
end
addonTable.FarmRecord_AddBut=ADD_daibenzhushou
--
fuFrame.FarmRecordBUT_ADD = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.FarmRecordBUT_ADD:SetSize(30,30);
fuFrame.FarmRecordBUT_ADD:SetHitRectInsets(0,-120,0,0);
fuFrame.FarmRecordBUT_ADD:SetMotionScriptsWhileDisabled(true) 
fuFrame.FarmRecordBUT_ADD:SetPoint("TOPLEFT",fuFrame.daiben,"TOPLEFT",300,-11);
fuFrame.FarmRecordBUT_ADD.Text:SetText("添加"..gongnengName.."到快捷按钮");
fuFrame.FarmRecordBUT_ADD.tooltip = "添加"..gongnengName.."到快捷按钮中，方便打开关闭。\n|cff00FF00注意：此功能需先打开快捷按钮功能|r";
fuFrame.FarmRecordBUT_ADD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per["FarmRecord"]["AddBut"]="ON"
		ADD_daibenzhushou()
	else
		PIG_Per["FarmRecord"]["AddBut"]="OFF"
		Pig_Options_RLtishi_UI:Show();
	end
end);
------------
fuFrame.FarmRecord = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.FarmRecord:SetSize(30,30);
fuFrame.FarmRecord:SetHitRectInsets(0,-80,0,0);
fuFrame.FarmRecord:SetPoint("TOPLEFT",fuFrame.daiben,"TOPLEFT",20,-11);
fuFrame.FarmRecord.Text:SetText(gongnengName);
fuFrame.FarmRecord.tooltip = "一个方便带刷副本小功能。";
fuFrame.FarmRecord:SetScript("OnClick", function (self)
	if self:GetChecked() then
		Pig_OptionsUI.Daibenzhushou:Enable();
		fuFrame.FarmRecordBUT_ADD:Enable();
		PIG_Per["FarmRecord"]["Kaiqi"]="ON";
		if PIG_Per["FarmRecord"]['autohuifu']=="ON" then
			daiben.yesno:SetChecked(true);
		elseif PIG_Per["FarmRecord"]['autohuifu']=="OFF" then
			daiben.yesno:SetChecked(false);
		end
		UIDropDownMenu_Initialize(daiben.hanren.xialai, daiben_hanhuaxialai_Up)
		gengxinjizhangData()
		TimeRecord()
		gengxinshouru();
		gengxincishu();
		ADD_daibenzhushou();
		FarmRecordFFFFF_UI:RegisterEvent("PLAYER_LOGOUT");
		FarmRecordFFFFF_UI:RegisterEvent("PLAYER_ENTERING_WORLD");
		FarmRecordFFFFF_UI:RegisterEvent("PLAYER_LEAVING_WORLD");
		FarmRecordFFFFF_UI:RegisterEvent("CHAT_MSG_SYSTEM");
		FarmRecordFFFFF_UI:RegisterEvent("CHAT_MSG_PARTY_LEADER");
		FarmRecordFFFFF_UI:RegisterEvent("GROUP_ROSTER_UPDATE");
		FarmRecordFFFFF_UI:RegisterEvent("PLAYER_MONEY");
		FarmRecordFFFFF_UI:RegisterEvent("CHAT_MSG_WHISPER");
		FarmRecordFFFFF_UI:RegisterEvent("TRADE_SHOW");
		FarmRecordFFFFF_UI:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED");
		FarmRecordFFFFF_UI:RegisterEvent("TRADE_TARGET_ITEM_CHANGED");
		FarmRecordFFFFF_UI:RegisterEvent("TRADE_MONEY_CHANGED");
		FarmRecordFFFFF_UI:RegisterEvent("TRADE_ACCEPT_UPDATE");
		FarmRecordFFFFF_UI:RegisterEvent("UI_INFO_MESSAGE");
	else
		Pig_OptionsUI.Daibenzhushou:Disable();
		fuFrame.FarmRecordBUT_ADD:Disable();
		PIG_Per["FarmRecord"]["Kaiqi"]="OFF";
		Pig_Options_RLtishi_UI:Show();
		FarmRecordFFFFF_UI:UnregisterEvent("PLAYER_LOGOUT");
		FarmRecordFFFFF_UI:UnregisterEvent("PLAYER_ENTERING_WORLD");
		FarmRecordFFFFF_UI:UnregisterEvent("PLAYER_LEAVING_WORLD");
		FarmRecordFFFFF_UI:UnregisterEvent("CHAT_MSG_SYSTEM");
		FarmRecordFFFFF_UI:UnregisterEvent("CHAT_MSG_PARTY_LEADER");
		FarmRecordFFFFF_UI:UnregisterEvent("GROUP_ROSTER_UPDATE");
		FarmRecordFFFFF_UI:UnregisterEvent("PLAYER_MONEY");
		FarmRecordFFFFF_UI:UnregisterEvent("CHAT_MSG_WHISPER");
		FarmRecordFFFFF_UI:UnregisterEvent("TRADE_SHOW");
		FarmRecordFFFFF_UI:UnregisterEvent("TRADE_PLAYER_ITEM_CHANGED");
		FarmRecordFFFFF_UI:UnregisterEvent("TRADE_TARGET_ITEM_CHANGED");
		FarmRecordFFFFF_UI:UnregisterEvent("TRADE_MONEY_CHANGED");
		FarmRecordFFFFF_UI:UnregisterEvent("TRADE_ACCEPT_UPDATE");
		FarmRecordFFFFF_UI:UnregisterEvent("UI_INFO_MESSAGE");
	end
end);
---重置位置
fuFrame.CZPoint = CreateFrame("Button",nil,fuFrame);
fuFrame.CZPoint:SetSize(22,22);
fuFrame.CZPoint:SetPoint("LEFT",fuFrame.FarmRecord.Text,"RIGHT",16,-1);
fuFrame.CZPoint.highlight = fuFrame.CZPoint:CreateTexture(nil, "HIGHLIGHT");
fuFrame.CZPoint.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
fuFrame.CZPoint.highlight:SetBlendMode("ADD")
fuFrame.CZPoint.highlight:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", 0,0);
fuFrame.CZPoint.highlight:SetSize(30,30);
fuFrame.CZPoint.Normal = fuFrame.CZPoint:CreateTexture(nil, "BORDER");
fuFrame.CZPoint.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
fuFrame.CZPoint.Normal:SetBlendMode("ADD")
fuFrame.CZPoint.Normal:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", 0,0);
fuFrame.CZPoint.Normal:SetSize(18,18);
fuFrame.CZPoint:HookScript("OnMouseDown", function (self)
	fuFrame.CZPoint.Normal:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", -1.5,-1.5);
end);
fuFrame.CZPoint:HookScript("OnMouseUp", function (self)
	fuFrame.CZPoint.Normal:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", 0,0);
end);
fuFrame.CZPoint:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("\124cff00ff00重置"..gongnengName.."的位置\124r")
	GameTooltip:Show();
end);
fuFrame.CZPoint:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
fuFrame.CZPoint:SetScript("OnClick", function ()
	daiben:ClearAllPoints();
	daiben:SetPoint("CENTER",UIParent,"CENTER",0,0);
end)
--=====================================
addonTable.FarmRecord = function()
	PIG_Per["FarmRecord"]["autobobao_TXT"] = addonTable.Default_Per["FarmRecord"]["autobobao_TXT"]
	PIG_Per["FarmRecord"]["DuiwuNei"]=PIG_Per["FarmRecord"]["DuiwuNei"] or addonTable.Default_Per["FarmRecord"]["DuiwuNei"]
	PIG_Per["FarmRecord"]['huifudengji'] = PIG_Per["FarmRecord"]['huifudengji'] or addonTable.Default_Per["FarmRecord"]['huifudengji']
	PIG_Per["FarmRecord"]["shuabenshu"]=PIG_Per["FarmRecord"]["shuabenshu"] or addonTable.Default_Per["FarmRecord"]["shuabenshu"]
	PIG_Per["FarmRecord"]["jiuweiqueren"]=PIG_Per["FarmRecord"]["jiuweiqueren"] or addonTable.Default_Per["FarmRecord"]["jiuweiqueren"]
	PIG_Per["FarmRecord"]["LV-danjia"] = PIG_Per["FarmRecord"]["LV-danjia"] or addonTable.Default_Per["FarmRecord"]["LV-danjia"]
	PIG_Per["FarmRecord"]["kaichemudidi"]=PIG_Per["FarmRecord"]["kaichemudidi"] or addonTable.Default_Per["FarmRecord"]["kaichemudidi"]
	PIG_Per["FarmRecord"]['hanhuapindao_lvdanjia']=PIG_Per["FarmRecord"]['hanhuapindao_lvdanjia'] or addonTable.Default_Per["FarmRecord"]['hanhuapindao_lvdanjia']
	PIG_Per["FarmRecord"]["autohuifu_Qianzhui"]=PIG_Per["FarmRecord"]["autohuifu_Qianzhui"] or addonTable.Default_Per["FarmRecord"]["autohuifu_Qianzhui"]
	PIG_Per["FarmRecord"]["yuedanjiasuoding"]=PIG_Per["FarmRecord"]["yuedanjiasuoding"] or addonTable.Default_Per["FarmRecord"]["yuedanjiasuoding"]
	PIG_Per["FarmRecord"]["Time_Show"]=PIG_Per["FarmRecord"]["Time_Show"] or addonTable.Default_Per["FarmRecord"]["Time_Show"]
	if #PIG_Per["FarmRecord"]['Time']~=5 then PIG_Per["FarmRecord"]["Time"]={{},{},{},{},{}}; end
	local name, instanceType = GetInstanceInfo()
	if instanceType=="none" then
		if PIG_Per["FarmRecord"]["YijingCZ"] == "ON" then
			daiben.CZbutton:SetText(jiuweiTXT)
		elseif PIG_Per["FarmRecord"]["YijingCZ"] == "OFF" then
			daiben.CZbutton:SetText(chongzhiTXT)
		end
	else
		daiben.CZbutton:SetText(jiuweiTXT)
	end
	if PIG_Per["FarmRecord"]["Kaiqi"]=="ON" then
		fuFrame.FarmRecord:SetChecked(true);
		Pig_OptionsUI.Daibenzhushou:Enable();
		if PIG_Per["FarmRecord"]["Show"]=="ON" then
			daiben_UI:Show()
			daiben_UI:SetFrameLevel(FrameLevel);
			if PIG_Per["FarmRecord"]["MaxMin"]=="OFF" then
				C_Timer.After(1,Show_ZX)
			end
			if PIG_Per["FarmRecord"]['bangdingUI']=="ON" then
				daiben_UI.zhankaijishi:Hide()
			elseif PIG_Per["FarmRecord"]['bangdingUI']=="OFF" then
				if PIG_Per["FarmRecord"]["Time_Show"]=="OFF" then
					C_Timer.After(1.1,dakaijishiUI)
				end
			end
		elseif PIG_Per["FarmRecord"]["Show"]=="OFF" then
			daiben_UI:Hide()
			if PIG_Per["FarmRecord"]['bangdingUI']=="ON" then
				daiben_UI.zhankaijishi:Hide()
			end
		end
	end
	if PIG_Per["FarmRecord"]["autohuifu"]=="ON" then
		daiben.yesno:SetChecked(true);
		daiben.yesno.Tex:SetTexture("interface/common/indicator-green.blp");
		if not daiben_UI:IsShown() then
			daibenzhushou_but_UI.yunxingzhong:Show()
		end
	end

	if PIG_Per["FarmRecord"]["Kaiqi"]=="ON" then
		UIDropDownMenu_Initialize(daiben.hanren.xialai, daiben_hanhuaxialai_Up)
		C_Timer.After(4,gengxinjizhangData)
		C_Timer.After(4,TimeRecord)
		C_Timer.After(4,gengxinshouru);
		C_Timer.After(4,gengxincishu);
		FarmRecordFFFFF_UI:RegisterEvent("PLAYER_LOGOUT");
		FarmRecordFFFFF_UI:RegisterEvent("PLAYER_ENTERING_WORLD");
		FarmRecordFFFFF_UI:RegisterEvent("PLAYER_LEAVING_WORLD");
		FarmRecordFFFFF_UI:RegisterEvent("CHAT_MSG_SYSTEM");
		FarmRecordFFFFF_UI:RegisterEvent("CHAT_MSG_PARTY_LEADER");
		FarmRecordFFFFF_UI:RegisterEvent("GROUP_ROSTER_UPDATE");
		FarmRecordFFFFF_UI:RegisterEvent("PLAYER_MONEY");
		FarmRecordFFFFF_UI:RegisterEvent("CHAT_MSG_WHISPER");
		FarmRecordFFFFF_UI:RegisterEvent("TRADE_SHOW");
		FarmRecordFFFFF_UI:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED");
		FarmRecordFFFFF_UI:RegisterEvent("TRADE_TARGET_ITEM_CHANGED");
		FarmRecordFFFFF_UI:RegisterEvent("TRADE_MONEY_CHANGED");
		FarmRecordFFFFF_UI:RegisterEvent("TRADE_ACCEPT_UPDATE");
		FarmRecordFFFFF_UI:RegisterEvent("UI_INFO_MESSAGE");
	end
end