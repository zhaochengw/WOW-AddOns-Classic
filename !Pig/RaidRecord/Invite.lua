local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
--=====组队助手==========================================================
local Width,Height  = RaidR_UI:GetWidth(), RaidR_UI:GetHeight();
----
local invite = CreateFrame("Frame", "invite_UI", RaidR_UI,"BackdropTemplate");
invite:SetBackdrop({bgFile = "interface/raidframe/ui-raidframe-groupbg.blp", 
	edgeFile = "interface/glues/common/textpanel-border.blp", 
	tile = false, tileSize = 20, edgeSize = 20,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
invite:SetSize(Width-22,Height-100);
invite:SetPoint("TOP",RaidR_UI,"TOP",0,-18);
invite:SetFrameLevel(10);
invite:EnableMouse(true);
invite:Hide();
local invite_Close = CreateFrame("Button","invite_Close_UI",invite, "UIPanelCloseButton");  
invite_Close:SetSize(34,34);
invite_Close:SetPoint("TOPRIGHT",invite,"TOPRIGHT",2.4,0);
local invite_biaoti = invite:CreateFontString("invite_biaoti_UI");
invite_biaoti:SetPoint("TOP",invite,"TOP",0,-10);
invite_biaoti:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
invite_biaoti:SetTextColor(0, 1, 0, 1);
invite_biaoti:SetText("!Pig组队助手");
local invite_X = invite:CreateLine()
invite_X:SetColorTexture(1,1,1,0.3)
invite_X:SetThickness(2);
invite_X:SetStartPoint("TOPLEFT",5,-34)
invite_X:SetEndPoint("TOPRIGHT",-3,-34)
-----------------
--职责
local invite_Icon = {{0.01,0.26,0.26,0.51},{0.27,0.52,0,0.25},{0.27,0.52,0.26,0.51}}
------
local LEFTjuli,TOPjuli,hang_jiange=150,10,10;
local zhiye_Height,zhiye_jiangeW,zhiye_jiangeH=20,40,7;
local zhenyingX= nil;
local T_classes_Name={};
local N_classes_Name={};
local D_classes_Name={};
--更新信息
local function UpdatePlayersINFO()
	local Tshishirenyuanxin,Nshishirenyuanxin,Dshishirenyuanxin={},{},{};
	for i=1,#T_classes_Name do
		Tshishirenyuanxin[i]=0;
	end
	for i=1,#N_classes_Name do
		Nshishirenyuanxin[i]=0;
	end
	for i=1,#D_classes_Name do
		Dshishirenyuanxin[i]=0;
	end
	-------------
	for i=1, 8 do
		if #PIG["RaidRecord"]["Raidinfo"][i]>0 then
			for ii=1, #PIG["RaidRecord"]["Raidinfo"][i] do
				if PIG["RaidRecord"]["Raidinfo"][i][ii][5]=="坦克补助" then
					for x=1,#T_classes_Name do
						if PIG["RaidRecord"]["Raidinfo"][i][ii][3]==T_classes_Name[x] then
							Tshishirenyuanxin[x]=Tshishirenyuanxin[x]+1;
						end
					end
				elseif PIG["RaidRecord"]["Raidinfo"][i][ii][5]=="治疗补助" then
					for x=1,#N_classes_Name do
						if PIG["RaidRecord"]["Raidinfo"][i][ii][3]==N_classes_Name[x] then
							Nshishirenyuanxin[x]=Nshishirenyuanxin[x]+1;
						end
					end
				else
					for x=1,#D_classes_Name do
						if PIG["RaidRecord"]["Raidinfo"][i][ii][3]==D_classes_Name[x] then
							Dshishirenyuanxin[x]=Dshishirenyuanxin[x]+1;
						end
					end
				end
			end
		end
	end
	-------
	local T_renyuanshuliang={0,0};
	for i=1,#T_classes_Name do
		_G["T_classes_mubiao_E_"..i.."_UI"]:SetText(PIG["RaidRecord"]["Invite"]["dangqianrenshu"][1][i])
		_G["T_classes_yizu_"..i.."_UI"]:SetText(Tshishirenyuanxin[i])
		if Tshishirenyuanxin[i]<PIG["RaidRecord"]["Invite"]["dangqianrenshu"][1][i] then
			_G['T_classes_wancheng_'..i..'_UI']:Hide();
		else
			_G['T_classes_wancheng_'..i..'_UI']:Show();
		end
		T_renyuanshuliang[1]=T_renyuanshuliang[1]+PIG["RaidRecord"]["Invite"]["dangqianrenshu"][1][i];
		T_renyuanshuliang[2]=T_renyuanshuliang[2]+Tshishirenyuanxin[i];
	end
	tankeF_mubiao_1_UI:SetText("目标("..T_renyuanshuliang[1]..")");
	tankeF_yizu_1_UI:SetText("当前("..T_renyuanshuliang[2]..")");
	---
	local N_renyuanshuliang={0,0};
	for i=1,#N_classes_Name do
		_G["N_classes_mubiao_E_"..i.."_UI"]:SetText(PIG["RaidRecord"]["Invite"]["dangqianrenshu"][2][i])
		_G["N_classes_yizu_"..i.."_UI"]:SetText(Nshishirenyuanxin[i])
		if Nshishirenyuanxin[i]<PIG["RaidRecord"]["Invite"]["dangqianrenshu"][2][i] then
			_G['N_classes_wancheng_'..i..'_UI']:Hide();
		else
			_G['N_classes_wancheng_'..i..'_UI']:Show();
		end
		N_renyuanshuliang[1]=N_renyuanshuliang[1]+PIG["RaidRecord"]["Invite"]["dangqianrenshu"][2][i];
		N_renyuanshuliang[2]=N_renyuanshuliang[2]+Nshishirenyuanxin[i];
	end
	zhiliaoF_mubiao_1_UI:SetText("目标("..N_renyuanshuliang[1]..")");
	zhiliaoF_yizu_1_UI:SetText("当前("..N_renyuanshuliang[2]..")");
	local D_renyuanshuliang={0,0};
	for i=1,#D_classes_Name do
		_G["D_classes_mubiao_E_"..i.."_UI"]:SetText(PIG["RaidRecord"]["Invite"]["dangqianrenshu"][3][i])
		_G["D_classes_yizu_"..i.."_UI"]:SetText(Dshishirenyuanxin[i])
		if Dshishirenyuanxin[i]<PIG["RaidRecord"]["Invite"]["dangqianrenshu"][3][i] then
			_G['D_classes_wancheng_'..i..'_UI']:Hide();
		else
			_G['D_classes_wancheng_'..i..'_UI']:Show();
		end
		D_renyuanshuliang[1]=D_renyuanshuliang[1]+PIG["RaidRecord"]["Invite"]["dangqianrenshu"][3][i];
		D_renyuanshuliang[2]=D_renyuanshuliang[2]+Dshishirenyuanxin[i];
	end
	dpsF_mubiao_1_UI:SetText("目标("..D_renyuanshuliang[1]..")");
	dpsF_yizu_1_UI:SetText("当前("..D_renyuanshuliang[2]..")");
	-- ----------
	local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
	yizuzongrenshuX_V_UI:SetText(numGroupMembers)
	mubiaozongrenshuX_V_UI:SetText(T_renyuanshuliang[1]+N_renyuanshuliang[1]+D_renyuanshuliang[1])
end
--创建框架---------------------------
local biaotijuliW,biaotijuliH =72,2;
local function chuangjianFrame()
	--坦克
	local tankeF = CreateFrame("Frame", "tankeF_UI", invite_UI,"BackdropTemplate");
	tankeF:SetBackdrop( {edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 20, 
		insets = { left = 4, right = 4, top = 4, bottom = 4 } });
	tankeF:SetBackdropBorderColor(1, 1, 1, 0.4);
	tankeF:SetSize(Width-50,zhiye_Height*5+8);
	tankeF:SetPoint("TOP",invite_UI,"TOP",0,-hang_jiange-30);
	local tankeF_Tex = tankeF:CreateTexture("tankeF_Tex_1_UI", "BORDER");
	tankeF_Tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
	tankeF_Tex:SetTexCoord(invite_Icon[1][1],invite_Icon[1][2],invite_Icon[1][3],invite_Icon[1][4]);
	tankeF_Tex:SetSize(zhiye_Height*3,zhiye_Height*3);
	tankeF_Tex:SetPoint("LEFT", tankeF, "LEFT", 10,0);
	for id=1,#T_classes_Name do
		local T_classes_Icon = tankeF_UI:CreateTexture("T_classes_Icon_"..id.."_UI", "BORDER");
		T_classes_Icon:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
		T_classes_Icon:SetSize(zhiye_Height,zhiye_Height);
		if id==1 then
			T_classes_Icon:SetPoint("TOPLEFT", tankeF, "TOPLEFT", LEFTjuli,-TOPjuli);
		else
			T_classes_Icon:SetPoint("LEFT",_G["T_classes_Icon_"..(id-1).."_UI"],"RIGHT",zhiye_jiangeW,0);
		end
		local coords = CLASS_ICON_TCOORDS[T_classes_Name[id]]
		T_classes_Icon:SetTexCoord(unpack(coords));
		local T_classes_mubiao_E = CreateFrame('EditBox', 'T_classes_mubiao_E_'..id..'_UI', tankeF_UI,"BackdropTemplate");
		T_classes_mubiao_E:SetSize(zhiye_Height,zhiye_Height);
		T_classes_mubiao_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = 0,right = 2,top = 0,bottom = -10}})
		T_classes_mubiao_E:SetPoint("TOP", T_classes_Icon, "BOTTOM", 0,-zhiye_jiangeH);
		T_classes_mubiao_E:SetFontObject(ChatFontNormal);
		T_classes_mubiao_E:SetMaxLetters(2)
		--T_classes_mubiao_E:SetText(0);
		T_classes_mubiao_E:SetJustifyH("CENTER");
		T_classes_mubiao_E:SetAutoFocus(false);
		_G['T_classes_mubiao_E_'..id..'_UI']:SetScript("OnEscapePressed", function(self) 
			self:ClearFocus() 
		end);
		_G['T_classes_mubiao_E_'..id..'_UI']:SetScript("OnEnterPressed", function(self) 
			self:ClearFocus() 
		end);
		_G['T_classes_mubiao_E_'..id..'_UI']:SetScript("OnEditFocusLost", function()
			local Newrenshu_T = _G['T_classes_mubiao_E_'..id..'_UI']:GetNumber();
			_G['T_classes_mubiao_E_'..id..'_UI']:SetText(Newrenshu_T);
			PIG["RaidRecord"]["Invite"]["dangqianrenshu"][1][id]=Newrenshu_T;
			UpdatePlayersINFO()
		end);
		local T_classes_yizu = tankeF_UI:CreateFontString("T_classes_yizu_"..id.."_UI");
		T_classes_yizu:SetHeight(zhiye_Height);
		T_classes_yizu:SetPoint("TOP", T_classes_mubiao_E, "BOTTOM", 0,-zhiye_jiangeH);
		T_classes_yizu:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		--T_classes_yizu:SetText(0);
		local T_classes_wancheng = tankeF_UI:CreateTexture("T_classes_wancheng_"..id.."_UI", "BORDER");
		--T_classes_wancheng:SetTexture("interface/raidframe/readycheck-notready.blp");
		T_classes_wancheng:SetTexture("interface/raidframe/readycheck-ready.blp");
		T_classes_wancheng:SetSize(zhiye_Height-4,zhiye_Height-4);
		T_classes_wancheng:SetPoint("TOP", T_classes_yizu, "BOTTOM", 0,-zhiye_jiangeH+6);
	end
	-------
	local tankeF_mubiao = tankeF:CreateFontString("tankeF_mubiao_1_UI");
	tankeF_mubiao:SetPoint("LEFT", _G["T_classes_mubiao_E_1_UI"], "LEFT", -biaotijuliW,biaotijuliH);
	tankeF_mubiao:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	local tankeF_yizu = tankeF:CreateFontString("tankeF_yizu_1_UI");
	tankeF_yizu:SetPoint("LEFT", _G["T_classes_yizu_1_UI"], "LEFT", -biaotijuliW-4,biaotijuliH);
	tankeF_yizu:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	--===============================================
	--治疗
	local zhiliaoF = CreateFrame("Frame", "zhiliaoF_UI", invite_UI,"BackdropTemplate");
	zhiliaoF:SetBackdrop( {edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 20, 
		insets = { left = 4, right = 4, top = 4, bottom = 4 } });
	zhiliaoF:SetBackdropBorderColor(1, 1, 1, 0.4);
	zhiliaoF:SetSize(Width-50,zhiye_Height*5+8);
	zhiliaoF:SetPoint("TOP",tankeF,"BOTTOM",0,-hang_jiange);
	local zhiliaoF_Tex = zhiliaoF:CreateTexture("zhiliaoF_Tex_1_UI", "BORDER");
	zhiliaoF_Tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
	zhiliaoF_Tex:SetTexCoord(invite_Icon[2][1],invite_Icon[2][2],invite_Icon[2][3],invite_Icon[2][4]);
	zhiliaoF_Tex:SetSize(zhiye_Height*3,zhiye_Height*3);
	zhiliaoF_Tex:SetPoint("LEFT", zhiliaoF, "LEFT", 10,0);
	for id=1,#N_classes_Name do
		local N_classes_Icon = zhiliaoF_UI:CreateTexture("N_classes_Icon_"..id.."_UI", "BORDER");
		N_classes_Icon:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
		N_classes_Icon:SetSize(zhiye_Height,zhiye_Height);
		if id==1 then
			N_classes_Icon:SetPoint("TOPLEFT", zhiliaoF, "TOPLEFT", LEFTjuli,-TOPjuli);
		else
			N_classes_Icon:SetPoint("LEFT",_G["N_classes_Icon_"..(id-1).."_UI"],"RIGHT",zhiye_jiangeW,0);
		end
		local coords = CLASS_ICON_TCOORDS[N_classes_Name[id]]
		N_classes_Icon:SetTexCoord(unpack(coords));
		local N_classes_mubiao_E = CreateFrame('EditBox', 'N_classes_mubiao_E_'..id..'_UI', zhiliaoF_UI,"BackdropTemplate");
		N_classes_mubiao_E:SetSize(zhiye_Height,zhiye_Height);
		N_classes_mubiao_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = 0,right = 2,top = 0,bottom = -10}})
		N_classes_mubiao_E:SetPoint("TOP", N_classes_Icon, "BOTTOM", 0,-zhiye_jiangeH);
		N_classes_mubiao_E:SetFontObject(ChatFontNormal);
		N_classes_mubiao_E:SetMaxLetters(2)
		--N_classes_mubiao_E:SetText(0);
		N_classes_mubiao_E:SetJustifyH("CENTER");
		N_classes_mubiao_E:SetAutoFocus(false);
		_G['N_classes_mubiao_E_'..id..'_UI']:SetScript("OnEscapePressed", function(self) 
			self:ClearFocus() 
		end);
		_G['N_classes_mubiao_E_'..id..'_UI']:SetScript("OnEnterPressed", function(self) 
			self:ClearFocus() 
		end);
		_G['N_classes_mubiao_E_'..id..'_UI']:SetScript("OnEditFocusLost", function()
			local Newrenshu_N = _G['N_classes_mubiao_E_'..id..'_UI']:GetNumber();
			_G['N_classes_mubiao_E_'..id..'_UI']:SetText(Newrenshu_N);
			PIG["RaidRecord"]["Invite"]["dangqianrenshu"][2][id]=Newrenshu_N;
			UpdatePlayersINFO()
		end);
		local N_classes_yizu = zhiliaoF_UI:CreateFontString("N_classes_yizu_"..id.."_UI");
		N_classes_yizu:SetHeight(zhiye_Height);
		N_classes_yizu:SetPoint("TOP", N_classes_mubiao_E, "BOTTOM", 0,-zhiye_jiangeH);
		N_classes_yizu:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		--N_classes_yizu:SetText(0);
		local N_classes_wancheng = zhiliaoF_UI:CreateTexture("N_classes_wancheng_"..id.."_UI", "BORDER");
		--N_classes_wancheng:SetTexture("interface/raidframe/readycheck-notready.blp");
		N_classes_wancheng:SetTexture("interface/raidframe/readycheck-ready.blp");
		N_classes_wancheng:SetSize(zhiye_Height-4,zhiye_Height-4);
		N_classes_wancheng:SetPoint("TOP", N_classes_yizu, "BOTTOM", 0,-zhiye_jiangeH+6);
	end
	-------
	local zhiliaoF_mubiao = zhiliaoF:CreateFontString("zhiliaoF_mubiao_1_UI");
	zhiliaoF_mubiao:SetPoint("LEFT", _G["N_classes_mubiao_E_1_UI"], "LEFT", -biaotijuliW,biaotijuliH);
	zhiliaoF_mubiao:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	local zhiliaoF_yizu = zhiliaoF:CreateFontString("zhiliaoF_yizu_1_UI");
	zhiliaoF_yizu:SetPoint("LEFT", _G["N_classes_yizu_1_UI"], "LEFT", -biaotijuliW-4,biaotijuliH);
	zhiliaoF_yizu:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	--===============================================
	--输出
	local dpsF = CreateFrame("Frame", "dpsF_UI", invite_UI,"BackdropTemplate");
	dpsF:SetBackdrop( {edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 20, 
		insets = { left = 4, right = 4, top = 4, bottom = 4 } });
	dpsF:SetBackdropBorderColor(1, 1, 1, 0.4);
	dpsF:SetSize(Width-50,zhiye_Height*5+8);
	dpsF:SetPoint("TOP",zhiliaoF,"BOTTOM",0,-hang_jiange);
	local dpsF_Tex = dpsF:CreateTexture("dpsF_Tex_1_UI", "BORDER");
	dpsF_Tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
	dpsF_Tex:SetTexCoord(invite_Icon[3][1],invite_Icon[3][2],invite_Icon[3][3],invite_Icon[3][4]);
	dpsF_Tex:SetSize(zhiye_Height*3,zhiye_Height*3);
	dpsF_Tex:SetPoint("LEFT", dpsF, "LEFT", 10,0);
	for id=1,#D_classes_Name do
		local D_classes_Icon = dpsF_UI:CreateTexture("D_classes_Icon_"..id.."_UI", "BORDER");
		D_classes_Icon:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
		D_classes_Icon:SetSize(zhiye_Height,zhiye_Height);
		if id==1 then
			D_classes_Icon:SetPoint("TOPLEFT", dpsF, "TOPLEFT", LEFTjuli,-TOPjuli);
		else
			D_classes_Icon:SetPoint("LEFT",_G["D_classes_Icon_"..(id-1).."_UI"],"RIGHT",zhiye_jiangeW-7,0);
		end
		local coords = CLASS_ICON_TCOORDS[D_classes_Name[id]]
		D_classes_Icon:SetTexCoord(unpack(coords));
		local D_classes_mubiao_E = CreateFrame('EditBox', 'D_classes_mubiao_E_'..id..'_UI', dpsF_UI,"BackdropTemplate");
		D_classes_mubiao_E:SetSize(zhiye_Height,zhiye_Height);
		D_classes_mubiao_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = 0,right = 2,top = 0,bottom = -10}})
		D_classes_mubiao_E:SetPoint("TOP", D_classes_Icon, "BOTTOM", 0,-zhiye_jiangeH);
		D_classes_mubiao_E:SetFontObject(ChatFontNormal);
		D_classes_mubiao_E:SetMaxLetters(2)
		--D_classes_mubiao_E:SetText(0);
		D_classes_mubiao_E:SetJustifyH("CENTER");
		D_classes_mubiao_E:SetAutoFocus(false);
		_G['D_classes_mubiao_E_'..id..'_UI']:SetScript("OnEscapePressed", function(self) 
			self:ClearFocus()
		end);
		_G['D_classes_mubiao_E_'..id..'_UI']:SetScript("OnEnterPressed", function(self) 
			self:ClearFocus() 
		end);
		_G['D_classes_mubiao_E_'..id..'_UI']:SetScript("OnEditFocusLost", function()
			local Newrenshu_D = _G['D_classes_mubiao_E_'..id..'_UI']:GetNumber();
			_G['D_classes_mubiao_E_'..id..'_UI']:SetText(Newrenshu_D);
			PIG["RaidRecord"]["Invite"]["dangqianrenshu"][3][id]=Newrenshu_D;
			UpdatePlayersINFO()
		end);
		local D_classes_yizu = dpsF_UI:CreateFontString("D_classes_yizu_"..id.."_UI");
		D_classes_yizu:SetHeight(zhiye_Height);
		D_classes_yizu:SetPoint("TOP", D_classes_mubiao_E, "BOTTOM", 0,-zhiye_jiangeH);
		D_classes_yizu:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		--D_classes_yizu:SetText(0);
		local D_classes_wancheng = dpsF_UI:CreateTexture("D_classes_wancheng_"..id.."_UI", "BORDER");
		--D_classes_wancheng:SetTexture("interface/raidframe/readycheck-notready.blp");
		D_classes_wancheng:SetTexture("interface/raidframe/readycheck-ready.blp");
		D_classes_wancheng:SetSize(zhiye_Height-4,zhiye_Height-4);
		D_classes_wancheng:SetPoint("TOP", D_classes_yizu, "BOTTOM", 0,-zhiye_jiangeH+6);
	end
	-------
	local dpsF_mubiao = dpsF:CreateFontString("dpsF_mubiao_1_UI");
	dpsF_mubiao:SetPoint("LEFT", _G["D_classes_mubiao_E_1_UI"], "LEFT", -biaotijuliW,biaotijuliH);
	dpsF_mubiao:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	local dpsF_yizu = dpsF:CreateFontString("dpsF_yizu_1_UI");
	dpsF_yizu:SetPoint("LEFT", _G["D_classes_yizu_1_UI"], "LEFT", -biaotijuliW-4,biaotijuliH);
	dpsF_yizu:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
end
-------------------

local xiafangjudingH =400
--载入默认人数配置
local renyuannpeizhiinfo = invite_UI:CreateFontString("renyuannpeizhiinfo_UI");
renyuannpeizhiinfo:SetPoint("TOPLEFT",invite_UI,"TOPLEFT",16,-xiafangjudingH);
renyuannpeizhiinfo:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
renyuannpeizhiinfo:SetText("\124cff00FF00导入配置\124r");
--
--local fubenName = {"奥妮克希亚的巢穴","熔火之心","\124cff1eff00黑翼之巢\124r","\124cff0070dd祖尔格拉布\124r","\124cffa335ee安其拉废墟\124r","\124cffff8000安其拉\124r","\124cffe6cc80纳克萨玛斯\124r"}
local fubenMoshi ={10,20,25,40};
local renyuannpeizhiinfo_D = CreateFrame("FRAME", "renyuannpeizhiinfo_D_UI", invite_UI, "UIDropDownMenuTemplate")
renyuannpeizhiinfo_D:SetPoint("LEFT",renyuannpeizhiinfo,"RIGHT",-16,-3)
UIDropDownMenu_SetWidth(renyuannpeizhiinfo_D, 58)

local function renyuannpeizhiinfo_Up()
	local info = UIDropDownMenu_CreateInfo()
	info.func = renyuannpeizhiinfo_D.SetValue
	for i=1,#fubenMoshi,1 do
	    info.text, info.arg1 = fubenMoshi[i].."人", fubenMoshi[i];
	    info.notCheckable = true;
		UIDropDownMenu_AddButton(info)
	end 
end
function renyuannpeizhiinfo_D:SetValue(newValue)
		if newValue==10 then
			PIG["RaidRecord"]["Invite"]["dangqianrenshu"]=PIG["RaidRecord"]["Invite"]["LMBL"]["10人配置"];
		elseif newValue==20 then
			PIG["RaidRecord"]["Invite"]["dangqianrenshu"]=PIG["RaidRecord"]["Invite"]["LMBL"]["20人配置"];
		elseif newValue==25 then
			PIG["RaidRecord"]["Invite"]["dangqianrenshu"]=PIG["RaidRecord"]["Invite"]["LMBL"]["25人配置"];
		elseif newValue==40 then
			PIG["RaidRecord"]["Invite"]["dangqianrenshu"]=PIG["RaidRecord"]["Invite"]["LMBL"]["40人配置"];
		end
	UIDropDownMenu_SetText(renyuannpeizhiinfo_D, newValue.."人")
	PIG["RaidRecord"]["Invite"]["dangqianpeizhi"]=newValue;
	print("|cff00FFFF!Pig:|r|cffFFFF00已导入|r"..newValue.."|cffFFFF00人副本职业配置！|r");
	CloseDropDownMenus();
	UpdatePlayersINFO();
end
--====================================================================
--总人数
local zongrenshuX = invite_UI:CreateFontString("zongrenshuX_UI");
zongrenshuX:SetPoint("LEFT",renyuannpeizhiinfo_D_UI,"RIGHT",-12,3);
zongrenshuX:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
zongrenshuX:SetText("\124cff00FF00总人数：\124r");
local yizuzongrenshuX_V = invite_UI:CreateFontString("yizuzongrenshuX_V_UI");
yizuzongrenshuX_V:SetPoint("LEFT",zongrenshuX,"RIGHT",0,-0);
yizuzongrenshuX_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
yizuzongrenshuX_V:SetText(0);
local fengefuxie = invite_UI:CreateFontString("fengefuxie_UI");
fengefuxie:SetPoint("LEFT",yizuzongrenshuX_V,"RIGHT",0,-0);
fengefuxie:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fengefuxie:SetText("\124cff00FF00/\124r");
local mubiaozongrenshuX_V = invite_UI:CreateFontString("mubiaozongrenshuX_V_UI");
mubiaozongrenshuX_V:SetPoint("LEFT",fengefuxie,"RIGHT",0,-0);
mubiaozongrenshuX_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
mubiaozongrenshuX_V:SetText(0);

---进组指令
local jinzuzhiling = invite_UI:CreateFontString("jinzuzhiling_UI");
jinzuzhiling:SetPoint("LEFT",zongrenshuX,"RIGHT",58,0);
jinzuzhiling:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
jinzuzhiling:SetText("\124cff00FF00进组指令：\124r");
local jinzuzhiling_E = CreateFrame('EditBox', 'jinzuzhiling_E_UI', invite_UI,"BackdropTemplate");
jinzuzhiling_E:SetSize(49,zhiye_Height+14);
jinzuzhiling_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -2,right = 2,top = 4,bottom = -10}})
jinzuzhiling_E:SetPoint("LEFT", jinzuzhiling, "RIGHT", 6,-0);
jinzuzhiling_E:SetFontObject(ChatFontNormal);
jinzuzhiling_E:SetMaxLetters(6)
jinzuzhiling_E:SetAutoFocus(false);
jinzuzhiling_E:SetScript("OnEscapePressed", function(self) 
	self:ClearFocus()
end);
jinzuzhiling_E:SetScript("OnEnterPressed", function(self) 
	self:ClearFocus() 
end);
jinzuzhiling_E:SetScript("OnEditFocusLost", function(self)
	PIG["RaidRecord"]["Invite"]["jinzuZhiling"]=self:GetText();
end);
--无限制邀请
local INV_wuxianzhiyaoqing = CreateFrame("CheckButton", "INV_wuxianzhiyaoqing_UI", invite_UI, "ChatConfigCheckButtonTemplate");
INV_wuxianzhiyaoqing:SetSize(28,28);
INV_wuxianzhiyaoqing:SetHitRectInsets(0,0,0,0);
INV_wuxianzhiyaoqing:SetPoint("LEFT",jinzuzhiling_E,"RIGHT",8,-1);
INV_wuxianzhiyaoqing_UIText:SetText("无限制");
INV_wuxianzhiyaoqing.tooltip = "收到邀请指令后不再判断职业职责，将直接邀请进组|cff00FF00(注意人数限制功能依然生效，到达人数后将自动停止邀请)|r。";
INV_wuxianzhiyaoqing:SetScript("OnClick", function ()
	if INV_wuxianzhiyaoqing:GetChecked() then
		PIG["RaidRecord"]["Invite"]["wutiaojianjINV"]="ON";
	else
		PIG["RaidRecord"]["Invite"]["wutiaojianjINV"]="OFF";
	end
end);
---开团喊话
local kaituanName = invite_UI:CreateFontString("kaituanName_UI");
kaituanName:SetPoint("TOPLEFT",invite_UI,"TOPLEFT",16,-xiafangjudingH-36);
kaituanName:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
kaituanName:SetText("\124cff00FF00喊话:\124r");
local kaituanNameFFF = CreateFrame("Frame", "kaituanNameFFF_UI", invite_UI,"BackdropTemplate");
kaituanNameFFF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 16,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
kaituanNameFFF:SetSize(540,zhiye_Height+8);
kaituanNameFFF:SetPoint("LEFT", kaituanName, "RIGHT", 0,-1);
local kaituanName_E = CreateFrame('EditBox', 'kaituanName_E_UI', kaituanNameFFF,"BackdropTemplate");
kaituanName_E:SetSize(zhiye_Height*20,zhiye_Height);
kaituanName_E:SetPoint("TOPLEFT", kaituanNameFFF, "TOPLEFT", 6,-2);
kaituanName_E:SetPoint("BOTTOMRIGHT", kaituanNameFFF, "BOTTOMRIGHT", -6,2);
kaituanName_E:SetFontObject(ChatFontNormal);
kaituanName_E:SetMaxLetters(40)
kaituanName_E:SetAutoFocus(false);
kaituanName_E:SetScript("OnEscapePressed", function(self) 
	self:ClearFocus()
end);
kaituanName_E:SetScript("OnEnterPressed", function(self) 
	self:ClearFocus() 
end);
---==============================================================================================
local pindaolist ={{"YELL","GUILD"},{"综合","寻求组队","大脚世界频道"}};
local pindaolist1 ={{"大喊","公会"},{"综合","寻求组队","大脚世界频道"}};
--喊话频道
local hanhuaxuanzexiala = CreateFrame("FRAME", "hanhuaxuanzexiala_UI", invite_UI, "UIDropDownMenuTemplate")
hanhuaxuanzexiala:SetPoint("LEFT",kaituanNameFFF_UI,"RIGHT",-16,-1.6)
UIDropDownMenu_SetWidth(hanhuaxuanzexiala, 58)
UIDropDownMenu_SetText(hanhuaxuanzexiala, "频道")--默认
local function hanhuaxuanzexiala_Up()
	local info = UIDropDownMenu_CreateInfo()
	info.func = hanhuaxuanzexiala.SetValue
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
	hanhuaneirong=hanhuaneirong..kaituanName_E_UI:GetText();
	if jinzuzhiling_E_UI:GetText()~="" and jinzuzhiling_E_UI:GetText()~=" " then
		hanhuaneirong=hanhuaneirong..",密"..jinzuzhiling_E_UI:GetText().."进组";
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
kaituanName_E:SetScript("OnEditFocusLost", function(self)
	PIG["RaidRecord"]["Invite"]["kaituanName"]=self:GetText();
	local macroSlot = GetMacroIndexByName("!Pig")
	if macroSlot>0 then
		NEWhanhuahong()
	end
end);
function hanhuaxuanzexiala:SetValue(pindaoNameVVV)
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
local New_hong = CreateFrame("Button","New_hong_UI",invite_UI, "UIPanelButtonTemplate");  
New_hong:SetSize(100,24);
New_hong:SetPoint("LEFT",hanhuaxuanzexiala,"RIGHT",-5,2);
New_hong:SetText('创建喊话宏');
New_hong:SetScript("OnClick", function ()
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
local zuduizhuangtaitishi = CreateFrame("Button","zuduizhuangtaitishi_UI",UIParent);
zuduizhuangtaitishi:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight");  
zuduizhuangtaitishi:SetSize(80,80);
zuduizhuangtaitishi:SetPoint("TOP",UIParent,"TOP",0,-100);
zuduizhuangtaitishi:SetMovable(true)
zuduizhuangtaitishi:EnableMouse(true)
zuduizhuangtaitishi:SetClampedToScreen(true)
zuduizhuangtaitishi:RegisterForDrag("LeftButton")
zuduizhuangtaitishi:RegisterForClicks("LeftButtonUp","RightButtonUp")
zuduizhuangtaitishi:Hide()
zuduizhuangtaitishi:SetScript("OnDragStart",function()
	zuduizhuangtaitishi:StartMoving()
end)
zuduizhuangtaitishi:SetScript("OnDragStop",function()
	zuduizhuangtaitishi:StopMovingOrSizing()
end)
local zhuangdongkaishixulie={0,1,2,3,4,3,2,1,0,9,10,11,12,13,14,15,15,17,18,19,20,21,22,23,24,25,26,21,20,27,28};
for i=1,#zhuangdongkaishixulie do
	local zuduizhuangtaitishi_Tex = zuduizhuangtaitishi:CreateTexture("zuduizhuangtaitishi_Tex_"..zhuangdongkaishixulie[i].."_UI", "BORDER");
	zuduizhuangtaitishi_Tex:SetTexture("interface/lfgframe/battlenetworking"..zhuangdongkaishixulie[i]..".blp");
	zuduizhuangtaitishi_Tex:SetAllPoints(zuduizhuangtaitishi)
	zuduizhuangtaitishi_Tex:Hide()
end
zuduizhuangtaitishi:SetScript("OnClick", function ()
	RsettingF_UI:Hide();
	History_UI:Hide();
	fenG_UI:Hide();
	RaidR_UI:Show();
	zuduizhuangtaitishi:Hide()
end)
local zhuangdongkaishiID=1;
local function yanjingzhuandongkaishi()
	if addonTable.RaidRecord_Invite_yaoqing==true or addonTable.RaidRecord_Invite_hanhua==true then
		if RaidR_UI:IsShown() then
			zuduizhuangtaitishi:Hide()
		else
			zuduizhuangtaitishi:Show()
			for i=1,#zhuangdongkaishixulie do
				_G["zuduizhuangtaitishi_Tex_"..zhuangdongkaishixulie[i].."_UI"]:Hide()
			end
			_G["zuduizhuangtaitishi_Tex_"..zhuangdongkaishixulie[zhuangdongkaishiID].."_UI"]:Show();
		end
		zhuangdongkaishiID=zhuangdongkaishiID+1;
		if zhuangdongkaishiID==#zhuangdongkaishixulie then zhuangdongkaishiID=1 end
		C_Timer.After(0.2,yanjingzhuandongkaishi)
	else
		zuduizhuangtaitishi:Hide()
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
			zudui_but_tex_UI:Hide()
		else
			if shandongbianhaoID==0 then
				zudui_but_tex_UI:Hide()
			elseif shandongbianhaoID==1 then
				zudui_but_tex_UI:Show()
			end
		end
		C_Timer.After(0.5,zuduizhushoushandong)
	else
		zudui_but_tex_UI:Hide()
	end
end

---自动邀请
addonTable.RaidRecord_Invite_yaoqing=false;
local lishiwanjiaxinxi={};
local autoZuduiKaiqi_tex=0;
local function zidongyaoqingFun()
	-- for i=1,#lishiwanjiaxinxi do
	-- 	if (GetServerTime()-lishiwanjiaxinxi[i][1])>60 then
	-- 		table.remove(lishiwanjiaxinxi, i);
	-- 	end
	-- end
	if IsInGroup() then
		local isLeader = UnitIsGroupLeader("player", "LE_PARTY_CATEGORY_HOME");
		local isTrue = UnitIsGroupAssistant("player", "LE_PARTY_CATEGORY_HOME");
		if isLeader~=true and isTrue~=true  then
			zidongyaoqingBUT_Tex_UI:SetTexture("interface/common/indicator-gray.blp");
			addonTable.RaidRecord_Invite_yaoqing=false;
			zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_WHISPER");
			zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_SYSTEM");
			print("|cff00FFFF!Pig:|r|cffFFFF00自动邀请已关闭，你必须是队长/团长/助理！|r");
		end
	end
	local yizuzongrenshuXxx=tonumber(yizuzongrenshuX_V_UI:GetText());
	local mubiaozongrenshuXxx=tonumber(mubiaozongrenshuX_V_UI:GetText());
	if yizuzongrenshuXxx>=mubiaozongrenshuXxx then
		zidongyaoqingBUT_Tex_UI:SetTexture("interface/common/indicator-gray.blp");
		addonTable.RaidRecord_Invite_yaoqing=false;
		zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_WHISPER");
		zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_SYSTEM");
		print("|cff00FFFF!Pig:|r|cffFFFF00已达目标人数，自动邀请已关闭。|r");
	end
	if addonTable.RaidRecord_Invite_yaoqing==true then
		if invite_UI:IsShown() then
			if autoZuduiKaiqi_tex==0 then
				zidongyaoqingBUT_Tex_UI:SetTexture("interface/common/indicator-green.blp");
				autoZuduiKaiqi_tex=1
			else
				zidongyaoqingBUT_Tex_UI:SetTexture("interface/common/indicator-gray.blp");
				autoZuduiKaiqi_tex=0
			end
		end
		C_Timer.After(0.5,zidongyaoqingFun)
	else
		zidongyaoqingBUT_Tex_UI:SetTexture("interface/common/indicator-gray.blp");
		addonTable.RaidRecord_Invite_yaoqing=false;
		zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_WHISPER");
		zuduizhushouXXX_UI:UnregisterEvent("CHAT_MSG_SYSTEM");
	end
end

--自动喊话
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
	if tonumber(yizuzongrenshuX_V_UI:GetText())>=tonumber(mubiaozongrenshuX_V_UI:GetText()) then
		addonTable.RaidRecord_Invite_hanhua=false;
		print("|cff00FFFF!Pig:|r|cffFFFF00已达目标人数，自动喊话已停止。|r");
	end
	if addonTable.RaidRecord_Invite_hanhua==true then
		if invite_UI:IsShown() then
			if hanhuaxuliebianhaoID==0 then
				hanhuakaishi_Tex_UI:SetTexture("interface/common/indicator-green.blp");
				hanhuaxuliebianhaoID=1
			else
				hanhuakaishi_Tex_UI:SetTexture("interface/common/indicator-gray.blp");
				hanhuaxuliebianhaoID=0
			end
		end
		C_Timer.After(0.5,zidonghanhuaFun)
	else
		hanhuakaishi_Tex_UI:SetTexture("interface/common/indicator-gray.blp");
		addonTable.RaidRecord_Invite_hanhua=false;
		--ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", guolvliaotiancuowuINFO)
	end
end
local function zidonghanhuahanshu()
	local hanhuaneirong="";
	hanhuaneirong=hanhuaneirong..kaituanName_E_UI:GetText();
	if jinzuzhiling_E_UI:GetText()~="" and jinzuzhiling_E_UI:GetText()~=" " then
		hanhuaneirong=hanhuaneirong..",密"..jinzuzhiling_E_UI:GetText().."进组";
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
		if tonumber(yizuzongrenshuX_V_UI:GetText())<tonumber(mubiaozongrenshuX_V_UI:GetText()) then
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
						hanhuaneirong=hanhuaneirong..kaituanName_E_UI:GetText();
						if jinzuzhiling_E_UI:GetText()~="" and jinzuzhiling_E_UI:GetText()~=" " then
							hanhuaneirong=hanhuaneirong..",密"..jinzuzhiling_E_UI:GetText().."进组";
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
local zidongyaoqingBUT = CreateFrame("Button","zidongyaoqingBUT_UI",invite_UI, "UIPanelButtonTemplate");  
zidongyaoqingBUT:SetSize(100,28);
zidongyaoqingBUT:SetPoint("LEFT",INV_wuxianzhiyaoqing_UIText,"RIGHT",6,-0);
zidongyaoqingBUT_UIText:SetPoint("CENTER",zidongyaoqingBUT,"CENTER",10,0);
local zidongyaoqingBUT_Font=zidongyaoqingBUT:GetFontString()
zidongyaoqingBUT_Font:SetFont(ChatFontNormal:GetFont(), 13);
zidongyaoqingBUT_Font:SetTextColor(0, 1, 1, 1);
zidongyaoqingBUT:SetText('自动邀请');
local zidongyaoqingBUT_Tex = zidongyaoqingBUT:CreateTexture("zidongyaoqingBUT_Tex_UI", "BORDER");
zidongyaoqingBUT_Tex:SetTexture("interface/common/indicator-gray.blp");
zidongyaoqingBUT_Tex:SetPoint("RIGHT",zidongyaoqingBUT_UIText,"LEFT",0,-2);
zidongyaoqingBUT_Tex:SetSize(23,23);
zidongyaoqingBUT:SetScript("OnClick", function ()
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
-----
---间隔
local hanhuajiange = invite_UI:CreateFontString("hanhuajiange_UI");
hanhuajiange:SetPoint("LEFT",zidongyaoqingBUT_UI,"RIGHT",6,0);
hanhuajiange:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
hanhuajiange:SetText("\124cff00FF00间隔/S：\124r");
hanhuajiange:Hide()
local hanhuajiange_E = CreateFrame('EditBox', 'hanhuajiange_E_UI', invite_UI,"BackdropTemplate");
hanhuajiange_E:SetSize(zhiye_Height*1.8,zhiye_Height+14);
hanhuajiange_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -6,right = 2,top = 4,bottom = -10}})
hanhuajiange_E:SetPoint("LEFT", hanhuajiange, "RIGHT", 4,-0);
hanhuajiange_E:SetFontObject(ChatFontNormal);
hanhuajiange_E:SetMaxLetters(4)
hanhuajiange_E:SetAutoFocus(false);
hanhuajiange_E:SetNumeric()
hanhuajiange_E:Hide()
hanhuajiange_E:SetScript("OnEscapePressed", function(self) 
	self:ClearFocus()
end);
hanhuajiange_E:SetScript("OnEnterPressed", function(self) 
	self:ClearFocus() 
end);
hanhuajiange_E:SetScript("OnEditFocusLost", function(self)
	if self:GetNumber()<300 then
		self:SetText(300)
		PIG["RaidRecord"]["Invite"]["shijianjiange"]=self:GetNumber();
		print("|cff00FFFF!Pig:|r|cffFFFF00不能小于300秒。|r");
	else
		PIG["RaidRecord"]["Invite"]["shijianjiange"]=self:GetNumber();
	end
end);
---
local hanhuakaishi = CreateFrame("Button","hanhuakaishi_UI",invite_UI, "UIPanelButtonTemplate");  
hanhuakaishi:SetSize(100,28);
hanhuakaishi:SetPoint("LEFT",hanhuajiange_E,"RIGHT",0,0);
hanhuakaishi_UIText:SetPoint("CENTER",hanhuakaishi,"CENTER",10,0);
local hanhuakaishi_Font=hanhuakaishi:GetFontString()
hanhuakaishi_Font:SetFont(ChatFontNormal:GetFont(), 13);
hanhuakaishi_Font:SetTextColor(0, 1, 1, 1);
hanhuakaishi:SetText('自动喊话');
hanhuakaishi:Hide();
local hanhuakaishi_Tex = hanhuakaishi:CreateTexture("hanhuakaishi_Tex_UI", "BORDER");
hanhuakaishi_Tex:SetTexture("interface/common/indicator-gray.blp");
hanhuakaishi_Tex:SetPoint("RIGHT",hanhuakaishi_UIText,"LEFT",0,-2);
hanhuakaishi_Tex:SetSize(23,23);
hanhuakaishi:SetScript("OnClick", function ()
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
local zhiyeweizhiName={"T","N","D"}
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
				local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
				SendChatMessage("[!Pig] 你已有队伍，请退组后再M", "WHISPER", nil, wanjianameXXk);
			end
		end
		if event=="CHAT_MSG_WHISPER" then
			local function chunshuchuzhiyeyaoqing()
					local localizedClass, englishClass= GetPlayerInfoByGUID(arg12)
					local zhiyeweizhiIDzongshu=0;
					local zhiyeweizhiID={nil,nil,nil}
					for i=1,#T_classes_Name do
						if englishClass==T_classes_Name[i] then
							zhiyeweizhiID[1]=i
							zhiyeweizhiIDzongshu=zhiyeweizhiIDzongshu+1;
						end
					end
					for i=1,#N_classes_Name do
						if englishClass==N_classes_Name[i] then
							zhiyeweizhiID[2]=i
							zhiyeweizhiIDzongshu=zhiyeweizhiIDzongshu+1;
						end
					end
					for i=1,#D_classes_Name do
						if englishClass==D_classes_Name[i] then
							zhiyeweizhiID[3]=i
							zhiyeweizhiIDzongshu=zhiyeweizhiIDzongshu+1;
						end
					end
					---
					if zhiyeweizhiIDzongshu==1 then
						for i=1,3 do
							if zhiyeweizhiID[i] then
								if _G[zhiyeweizhiName[i].."_classes_mubiao_E_"..zhiyeweizhiID[i].."_UI"]:GetNumber()>tonumber(_G[zhiyeweizhiName[i].."_classes_yizu_"..zhiyeweizhiID[i].."_UI"]:GetText()) then
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
					elseif zhiyeweizhiIDzongshu>1 then
						local zuduizhushou_MSG=localizedClass.."尚缺:";
						local chazhiyefenlai={};
						for i=1,3 do
							if zhiyeweizhiID[i] then
								if _G[zhiyeweizhiName[i].."_classes_mubiao_E_"..zhiyeweizhiID[i].."_UI"]:GetNumber()>tonumber(_G[zhiyeweizhiName[i].."_classes_yizu_"..zhiyeweizhiID[i].."_UI"]:GetText()) then
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
										local localizedClass, englishClass= GetPlayerInfoByGUID(arg12)
										if lishiwanjiaxinxi[i][3][x]==1 then
											for k=1,#T_classes_Name do
												if englishClass==T_classes_Name[k] then
													if _G["T_classes_mubiao_E_"..k.."_UI"]:GetNumber()>tonumber(_G["T_classes_yizu_"..k.."_UI"]:GetText()) then
														local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
														if numGroupMembers==5 and not IsInRaid("LE_PARTY_CATEGORY_HOME") then
															ConvertToRaid() 
														end
														InviteUnit(arg5)
													else
														SendChatMessage("[!Pig] 坦克"..localizedClass .. "已满，可换其他职业/天赋，感谢支持", "WHISPER", nil, arg5);
													end
												end
											end
										elseif lishiwanjiaxinxi[i][3][x]==2 then
											for kk=1,#N_classes_Name do
												if englishClass==N_classes_Name[kk] then
													if _G["T_classes_mubiao_E_"..kk.."_UI"]:GetNumber()>tonumber(_G["T_classes_yizu_"..kk.."_UI"]:GetText()) then
														local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
														if numGroupMembers==5 and not IsInRaid("LE_PARTY_CATEGORY_HOME") then
															ConvertToRaid() 
														end
														InviteUnit(arg5)
													else
														SendChatMessage("[!Pig] 治疗"..localizedClass .. "已满，可换其他职业/天赋，感谢支持", "WHISPER", nil, arg5);
													end
												end
											end
										elseif lishiwanjiaxinxi[i][3][x]==3 then
											for kkk=1,#D_classes_Name do
												if englishClass==D_classes_Name[kkk] then
													if _G["T_classes_mubiao_E_"..kkk.."_UI"]:GetNumber()>tonumber(_G["T_classes_yizu_"..kkk.."_UI"]:GetText()) then
														local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
														if numGroupMembers==5 and not IsInRaid("LE_PARTY_CATEGORY_HOME") then
															ConvertToRaid() 
														end
														InviteUnit(arg5)
													else
														SendChatMessage("[!Pig] 输出"..localizedClass .. "已满，可换其他职业/天赋，感谢支持", "WHISPER", nil, arg5);
													end
												end
											end
										end
										table.remove(lishiwanjiaxinxi, i);
										return
									end
								end
							end
							SendChatMessage("[!Pig] 未检测到职责关键字，本次会话结束，进组需重新回复进组指令", "WHISPER", nil, arg5);
							table.remove(lishiwanjiaxinxi,i);
							break
						end
					end
			end
			--执行邀请
			local function zhixingyaoqingjianceFUN()
				local feizidonghuifu=arg1:find("[!Pig]", 1)
				if not feizidonghuifu then
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
			------
			local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
			if numGroupMembers>0 then
				for p=1,numGroupMembers do
					local name = GetUnitName("raid"..p, true)
					if arg5==name then
						return
					end
				end
				zhixingyaoqingjianceFUN()
			else
				zhixingyaoqingjianceFUN()
			end
		end
	end
end)

--==========================================
invite_UI:SetScript("OnShow", function ()
	UpdatePlayersINFO()
	if PIG["RaidRecord"]["Invite"]["jihuo"] then
		if PIG["RaidRecord"]["Invite"]["jihuo"][1]==true and PIG["RaidRecord"]["Invite"]["jihuo"][2]==true and PIG["RaidRecord"]["Invite"]["jihuo"][4]==true and PIG["RaidRecord"]["Invite"]["jihuo"][3]==true then		
			hanhuajiange:Show()
			hanhuajiange_E:Show()
			hanhuakaishi:Show()
		else
			hanhuajiange:Hide()
			hanhuajiange_E:Hide()
			hanhuakaishi:Hide()
		end
	end
end)
--组队助手
local zudui_but = CreateFrame("Button","zudui_but_UI",xiafangFrame_UI, "UIPanelButtonTemplate");
zudui_but:SetSize(80,28);
zudui_but:SetPoint("TOPLEFT",xiafangFrame_UI,"TOPLEFT",Width*0.73,-6);
zudui_but:SetText('组队助手');
zudui_but:SetMotionScriptsWhileDisabled(true)
zudui_but:SetScript("OnEnter", function (self)
	if not self:IsEnabled() then
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(zudui_but, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("提示：")
		GameTooltip:AddLine("\124cff00ff00请先解除人员冻结\124r")
		GameTooltip:Show();
	end
end);
zudui_but:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
local zudui_but_tex = zudui_but:CreateTexture("zudui_but_tex_UI", "OVERLAY");
zudui_but_tex:SetTexture("interface/helpframe/helpbuttons.blp");
zudui_but_tex:SetTexCoord(0,0.68,0.66,0.86);
zudui_but_tex:SetSize(74,20);
zudui_but_tex:SetPoint("TOP",zudui_but,"TOP",0,-5);
zudui_but_tex_UI:Hide()
zudui_but:SetScript("OnClick", function (self)
	RsettingF_UI:Hide();
	History_UI:Hide();
	fenG_UI:Hide();
	if invite_UI:IsShown() then
		invite_UI:Hide();
	else
		invite_UI:Show();
	end
end);

--==========================================
local _, _, _, tocversion = GetBuildInfo()
local function InviteEvent()
	if PIG["RaidRecord"]["Kaiqi"]=="ON" then
		if tocversion>69999 then
			T_classes_Name={"WARRIOR","PALADIN","DRUID","DEATHKNIGHT","MONK","DEMONHUNTER"};
			N_classes_Name={"PRIEST","DRUID","PALADIN","SHAMAN","MONK"};
			D_classes_Name={"WARRIOR","HUNTER","ROGUE","MAGE","WARLOCK","PRIEST","DRUID","PALADIN","SHAMAN","DEATHKNIGHT","MONK","DEMONHUNTER"};
		elseif tocversion>29999 then
			T_classes_Name={"WARRIOR","PALADIN","DRUID","DEATHKNIGHT"};
			N_classes_Name={"PRIEST","DRUID","PALADIN","SHAMAN"};
			D_classes_Name={"WARRIOR","HUNTER","ROGUE","MAGE","WARLOCK","PRIEST","DRUID","PALADIN","SHAMAN","DEATHKNIGHT"};
		elseif tocversion>19999 then
			T_classes_Name={"WARRIOR","PALADIN","DRUID"};
			N_classes_Name={"PRIEST","DRUID","PALADIN","SHAMAN"};
			D_classes_Name={"WARRIOR","HUNTER","ROGUE","MAGE","WARLOCK","PRIEST","DRUID","PALADIN","SHAMAN"};
		else
			local englishFaction, _ = UnitFactionGroup("player")
			zhenyingX=englishFaction;
			if englishFaction=="Alliance" then
				T_classes_Name={"WARRIOR","DRUID","PALADIN"};
				N_classes_Name={"PRIEST","DRUID","PALADIN",};
				D_classes_Name={"WARRIOR","HUNTER","ROGUE","MAGE","WARLOCK","PRIEST","DRUID","PALADIN"};
			elseif englishFaction=="Horde" then
				T_classes_Name={"WARRIOR","DRUID"};
				N_classes_Name={"PRIEST","DRUID","SHAMAN"};
				D_classes_Name={"WARRIOR","HUNTER","ROGUE","MAGE","WARLOCK","PRIEST","DRUID","SHAMAN"};
			end
		end
		chuangjianFrame()
		if PIG["RaidRecord"]["Invite"]["wutiaojianjINV"]=="ON" then
			INV_wuxianzhiyaoqing_UI:SetChecked(true);
		end
		kaituanName_E_UI:SetText(PIG["RaidRecord"]["Invite"]["kaituanName"]);
		jinzuzhiling_E_UI:SetText(PIG["RaidRecord"]["Invite"]["jinzuZhiling"]);
		hanhuajiange_E_UI:SetText(PIG["RaidRecord"]["Invite"]["shijianjiange"]);
		UIDropDownMenu_SetText(renyuannpeizhiinfo_D, PIG["RaidRecord"]["Invite"]["dangqianpeizhi"])--默认
		UIDropDownMenu_Initialize(renyuannpeizhiinfo_D, renyuannpeizhiinfo_Up)--初始化
		UIDropDownMenu_Initialize(hanhuaxuanzexiala_UI, hanhuaxuanzexiala_Up)--初始化
		UpdatePlayersINFO();
	end
end
addonTable.RaidRecord_Invite = InviteEvent;