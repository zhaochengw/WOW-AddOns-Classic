local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local Width,Height  = TabFrame_UI:GetWidth(), TabFrame_UI:GetHeight();
local duiwu_Width,duiwu_Height=160,28;
local jiangeW,jiangeH=30,0;
--================================
--职业图标
local classes_Width,classes_Height=60,24;
local classes_Name={"WARRIOR","PALADIN","HUNTER","ROGUE","PRIEST","SHAMAN","MAGE","WARLOCK","DRUID"};
local _, _, _, tocversion = GetBuildInfo()
if tocversion>29999 then
	table.insert(classes_Name,"DEATHKNIGHT");
end
if tocversion>49999 then
	table.insert(classes_Name,"MONK");
end
if tocversion>69999 then
	table.insert(classes_Name,"DEMONHUNTER");
end
--全部
local classesAll = CreateFrame("Frame", "classesAll_UI", TablistFrame_5_UI);
classesAll:SetSize(classes_Height*2, classes_Height);
classesAll:SetPoint("TOPLEFT",TablistFrame_5_UI,"TOPLEFT",6,-10);
local classesAll_Tex = classesAll:CreateTexture("classesAll_Tex_UI", "BORDER");
classesAll_Tex:SetTexture("interface/glues/charactercreate/ui-charactercreate-factions.blp");
classesAll_Tex:SetPoint("LEFT", classesAll, "LEFT", 0,0);
classesAll_Tex:SetSize(classes_Height-2,classes_Height-2);
classesAll:SetScript("OnMouseDown", function ()
	classesAll_Tex:SetPoint("LEFT", classesAll, "LEFT",1.5,-1.5);
	playersLeft_UI:Hide();
end);
classesAll:SetScript("OnMouseUp", function ()
	classesAll_Tex:SetPoint("LEFT", classesAll, "LEFT", 0,0);
end);
local classesAll_Num = classesAll:CreateFontString("classesAll_Num_UI");
classesAll_Num:SetPoint("LEFT", classesAll_Tex, "RIGHT", 0,0);
classesAll_Num:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
classesAll_Num:SetText(0);
--分职业
for id=1,#classes_Name do
	local classesList = CreateFrame("Frame", "classesList_"..id.."_UI", TablistFrame_5_UI);
	classesList:SetSize(classes_Height*2-4, classes_Height);
	if id==1 then
		classesList:SetPoint("LEFT",classesAll,"RIGHT",2,0);
	else
		classesList:SetPoint("LEFT",_G["classesList_"..(id-1).."_UI"],"RIGHT",2,0);
	end
	local classesList_Tex = classesList:CreateTexture("classesList_Tex_"..id.."_UI", "BORDER");
	classesList_Tex:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
	classesList_Tex:SetPoint("LEFT", classesList, "LEFT", 0,0);
	classesList_Tex:SetSize(classes_Height-2,classes_Height-2);
	local coords = CLASS_ICON_TCOORDS[classes_Name[id]]
	classesList_Tex:SetTexCoord(unpack(coords));
	classesList:SetScript("OnMouseDown", function ()
		classesList_Tex:SetPoint("LEFT", classesList, "LEFT",1.5,-1.5);
		playersLeft_UI:Hide();playersRight_UI:Hide();
	end);
	classesList:SetScript("OnMouseUp", function ()
		classesList_Tex:SetPoint("LEFT", classesList, "LEFT", 0,0);
	end);
	local classesList_Num = classesList:CreateFontString("classesList_Num_"..id.."_UI");
	classesList_Num:SetPoint("LEFT", classesList_Tex, "RIGHT", 0,0);
	classesList_Num:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	classesList_Num:SetText(0);
end
---职责分类
--local zhizeIcon = {{0.01,0.26,0.26,0.51},{0.27,0.52,0,0.25},{0.01,0.26,0,0.25},{0.27,0.52,0.52,0.77}}
local zhizeIcon = {{0.01,0.26,0.26,0.51},{0.27,0.52,0,0.25},{0.01,0.26,0,0.25}}
for id=1,#zhizeIcon do
	local zhizeList = CreateFrame("Frame", "zhizeList_"..id.."_UI", TablistFrame_5_UI); 
	zhizeList:SetSize(classes_Height*2-4, classes_Height);
	if id==1 then
		zhizeList:SetPoint("LEFT",_G["classesList_"..#classes_Name.."_UI"],"RIGHT",10,0);
	else
		zhizeList:SetPoint("LEFT",_G["zhizeList_"..(id-1).."_UI"],"RIGHT",2,0);
	end
	local zhizeList_Tex = zhizeList:CreateTexture("zhizeList_Tex_"..id.."_UI", "BORDER");
	zhizeList_Tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
	zhizeList_Tex:SetTexCoord(zhizeIcon[id][1],zhizeIcon[id][2],zhizeIcon[id][3],zhizeIcon[id][4]);
	zhizeList_Tex:SetSize(classes_Height,classes_Height);
	zhizeList_Tex:SetPoint("LEFT", zhizeList, "LEFT", 0,0);
	zhizeList:SetScript("OnMouseDown", function ()
		zhizeList_Tex:SetPoint("LEFT", zhizeList, "LEFT",1.5,-1.5);
		playersLeft_UI:Hide();playersRight_UI:Hide();
	end);
	zhizeList:SetScript("OnMouseUp", function ()
		zhizeList_Tex:SetPoint("LEFT", zhizeList, "LEFT", 0,0);
	end);
	local zhizeList_Num = zhizeList:CreateFontString("zhizeList_Num_"..id.."_UI");
	zhizeList_Num:SetPoint("LEFT", zhizeList_Tex, "RIGHT", 0,0);
	zhizeList_Num:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	zhizeList_Num:SetText(0);
end
--图标点击提示
local classes_tishi = CreateFrame("Frame", "classes_tishi_UI", TablistFrame_5_UI);
classes_tishi:SetSize(30,30);
classes_tishi:SetPoint("TOPRIGHT",TablistFrame_5_UI,"TOPRIGHT",0,0);
local classes_tishi_Texture = classes_tishi:CreateTexture("classes_tishi_Texture_UI", "BORDER");
classes_tishi_Texture:SetTexture("interface/common/help-i.blp");
classes_tishi_Texture:SetAllPoints(classes_tishi)
classes_tishi:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(classes_tishi, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("\124cff00ff00左键角色名设置人员补助类型。\n右键角色名设置人员分G比例。\124r")
	GameTooltip:Show();
end);
classes_tishi:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);

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
			local renyuaninfo={coords,{rPerc, gPerc, bPerc},fileName,name,buzhuleixing,0,1,0,0,0};--1职业图标2职业颜色3职业4玩家名5补助类型6补助金额7分G比例8分G数值9[需要邮寄0/1]10[已邮寄0/1]		
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
	local numSubgroupMembers = GetNumSubgroupMembers("LE_PARTY_CATEGORY_HOME")
	local numGroupMembers = GetNumGroupMembers("LE_PARTY_CATEGORY_HOME")
	if yiyoutuanduishuju>=numGroupMembers then
		for x=1,#renyuanifoHC do
			if #renyuanifoHC[x]>0 then
				for xx=1,#renyuanifoHC[x] do
							--检索组队信息里人员职责
							for v=#PIG["RaidRecord"]["Invite"]["linshiInfo"],1, -1 do
								if renyuanifoHC[x][xx][4]==PIG["RaidRecord"]["Invite"]["linshiInfo"][v][1] then
									if PIG["RaidRecord"]["Invite"]["linshiInfo"][v][2]=="坦克补助" or PIG["RaidRecord"]["Invite"]["linshiInfo"][v][2]=="治疗补助" then
										--renyuanifoHC[x][xx]={coords,{rPerc, gPerc, bPerc},fileName,name,PIG["RaidRecord"]["Invite"]["linshiInfo"][v][2],0,1,0,0,0};
										renyuanifoHC[x][xx][5]=PIG["RaidRecord"]["Invite"]["linshiInfo"][v][2];
									end
									table.remove(PIG["RaidRecord"]["Invite"]["linshiInfo"], v);
								end
							end
							--检索OLD
							for i=1,8 do
								if #PIG["RaidRecord"]["Raidinfo"][i]>0 then
									for ii=1,#PIG["RaidRecord"]["Raidinfo"][i] do
										if renyuanifoHC[x][xx][4]==PIG["RaidRecord"]["Raidinfo"][i][ii][4] then
											renyuanifoHC[x][xx][5]=PIG["RaidRecord"]["Raidinfo"][i][ii][5];
											renyuanifoHC[x][xx][6]=PIG["RaidRecord"]["Raidinfo"][i][ii][6];
											renyuanifoHC[x][xx][7]=PIG["RaidRecord"]["Raidinfo"][i][ii][7];
											renyuanifoHC[x][xx][8]=PIG["RaidRecord"]["Raidinfo"][i][ii][8];
											renyuanifoHC[x][xx][9]=PIG["RaidRecord"]["Raidinfo"][i][ii][9];
											renyuanifoHC[x][xx][10]=PIG["RaidRecord"]["Raidinfo"][i][ii][10];
											--renyuanifoHC[x][xx]={coords,{rPerc, gPerc, bPerc},fileName,name,renyuaninfo1,renyuaninfo2,renyuaninfo3,renyuaninfo4,renyuaninfo5,renyuaninfo6};
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
	local IsInGroup = IsInGroup("LE_PARTY_CATEGORY_HOME");
	if IsInGroup then
		huoquRaidInfo_UI:Enable();
	else
		huoquRaidInfo_UI:Disable();
	end
	if PIG["RaidRecord"]["Dongjie"]=="OFF" then
		renyuankuaizhaomoshi_tishi_UI:Hide();
		fenG_BUT_UI:Disable();
		zudui_but_UI:Enable();
		UpdateRiadInfo();
		addonTable.RaidRecord_UpdateChengjiaorenxuanze()
		addonTable.RaidRecord_Updatejianglixuanze()
		addonTable.RaidRecord_Updatefakuanxuanze()
	elseif PIG["RaidRecord"]["Dongjie"]=="ON" then			
		renyuankuaizhaomoshi_tishi_UI:Show();
		fenG_BUT_UI:Enable();
		zudui_but_UI:Disable();
	end
	----------
	local classes_Shu={0,0,0,0,0,0,0,0,0};
	local classes_zongShu=0;
	local buzhurenshu={0,0,0};
	for i=1, 8 do
		for ii=1, 5 do
			_G["RaidiDuiwu_"..i.."_"..ii]:Hide();
			_G["RaidiDuiwu_Name_"..i.."_"..ii]:SetText()
			_G["RaidiDuiwu_zhizeIcon_"..i.."_"..ii]:Hide();
			_G["RaidiDuiwu_fenGbili_"..i.."_"..ii]:Hide();
			_G["RaidiDuiwu_fenGbili_1_"..i.."_"..ii]:Hide();
			_G["RaidiDuiwu_fenGbili_2_"..i.."_"..ii]:Hide();
		end
	end
	for i=1, #PIG["RaidRecord"]["Raidinfo"] do
		if #PIG["RaidRecord"]["Raidinfo"][i]>0 then
			for ii=1, #PIG["RaidRecord"]["Raidinfo"][i] do
					for xx=1,#classes_Name do
						if PIG["RaidRecord"]["Raidinfo"][i][ii][3]==classes_Name[xx] then
							classes_Shu[xx]=classes_Shu[xx]+1;
						end
					end
					classes_zongShu=classes_zongShu+1;
					_G["RaidiDuiwu_"..i.."_"..ii]:Show();
					_G["RaidiDuiwu_Name_"..i.."_"..ii]:SetText(PIG["RaidRecord"]["Raidinfo"][i][ii][4])
					local _, _, _, wanjiaName = PIG["RaidRecord"]["Raidinfo"][i][ii][4]:find("((.+)-)");
					if wanjiaName then
						_G["RaidiDuiwu_Name_XS_"..i.."_"..ii]:SetText(wanjiaName)
					else
						_G["RaidiDuiwu_Name_XS_"..i.."_"..ii]:SetText(PIG["RaidRecord"]["Raidinfo"][i][ii][4])
					end
					_G["RaidiDuiwu_Name_XS_"..i.."_"..ii]:SetTextColor(PIG["RaidRecord"]["Raidinfo"][i][ii][2][1],PIG["RaidRecord"]["Raidinfo"][i][ii][2][2],PIG["RaidRecord"]["Raidinfo"][i][ii][2][3], 1);
					if PIG["RaidRecord"]["Raidinfo"][i][ii][5]=="坦克补助" then
						buzhurenshu[1]=buzhurenshu[1]+1;
						_G["RaidiDuiwu_zhizeIcon_"..i.."_"..ii]:Show();
						_G["RaidiDuiwu_zhizeIcon_"..i.."_"..ii]:SetTexCoord(zhizeIcon[1][1],zhizeIcon[1][2],zhizeIcon[1][3],zhizeIcon[1][4]);
					elseif PIG["RaidRecord"]["Raidinfo"][i][ii][5]=="治疗补助" then
						buzhurenshu[2]=buzhurenshu[2]+1;
						_G["RaidiDuiwu_zhizeIcon_"..i.."_"..ii]:Show();
						_G["RaidiDuiwu_zhizeIcon_"..i.."_"..ii]:SetTexCoord(zhizeIcon[2][1],zhizeIcon[2][2],zhizeIcon[2][3],zhizeIcon[2][4]);
					elseif PIG["RaidRecord"]["Raidinfo"][i][ii][5]=="开怪猎人" then
						buzhurenshu[3]=buzhurenshu[3]+1;
						_G["RaidiDuiwu_zhizeIcon_"..i.."_"..ii]:Show();
						_G["RaidiDuiwu_zhizeIcon_"..i.."_"..ii]:SetTexCoord(zhizeIcon[3][1],zhizeIcon[3][2],zhizeIcon[3][3],zhizeIcon[3][4]);				
					end
					if PIG["RaidRecord"]["Raidinfo"][i][ii][7]==2 then
						_G["RaidiDuiwu_fenGbili_"..i.."_"..ii]:Show();
					elseif PIG["RaidRecord"]["Raidinfo"][i][ii][7]==0.5 then
						_G["RaidiDuiwu_fenGbili_1_"..i.."_"..ii]:Show();
					elseif PIG["RaidRecord"]["Raidinfo"][i][ii][7]==0 then
						_G["RaidiDuiwu_fenGbili_2_"..i.."_"..ii]:Show();			
					end
			end
		end
	end
	for j=1,#classes_Name do
		_G["classesList_Num_"..j.."_UI"]:SetText(classes_Shu[j]);
	end
	for x=1,#zhizeIcon do
		_G["zhizeList_Num_"..x.."_UI"]:SetText(buzhurenshu[x]);
	end
	classesAll_Num_UI:SetText(classes_zongShu);
end
--==刷新冻结数据===========================================
TablistFrame_5_UI.shuaxinINFO = CreateFrame("Button",nil,TablistFrame_5_UI, "UIMenuButtonStretchTemplate");
TablistFrame_5_UI.shuaxinINFO:SetSize(24,24);
TablistFrame_5_UI.shuaxinINFO:SetPoint("TOPRIGHT", TablistFrame_5_UI, "TOPRIGHT", -38,-10);
TablistFrame_5_UI.shuaxinINFO:Hide();
TablistFrame_5_UI.shuaxinINFO.Tex = TablistFrame_5_UI.shuaxinINFO:CreateTexture(nil, "BORDER");
TablistFrame_5_UI.shuaxinINFO.Tex:SetTexture("interface/buttons/ui-refreshbutton.blp");
TablistFrame_5_UI.shuaxinINFO.Tex:SetPoint("CENTER");
TablistFrame_5_UI.shuaxinINFO.Tex:SetSize(14,14);
TablistFrame_5_UI.shuaxinINFO:SetScript("OnMouseDown", function (self)
	self.Tex:SetPoint("CENTER",1.5,-1.5);
end);
TablistFrame_5_UI.shuaxinINFO:SetScript("OnMouseUp", function (self)
	self.Tex:SetPoint("CENTER");
end);
TablistFrame_5_UI.shuaxinINFO:SetScript("OnClick", function (self)
	StaticPopup_Show ("SHUAXINRENYUANXINXI");
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
local menuName={"设为坦克补助","设为治疗补助","设为开怪猎人","撤销补助设置","取消"}
local playersLeft = CreateFrame("Frame", "playersLeft_UI", TablistFrame_5_UI,"BackdropTemplate");
playersLeft:SetBackdrop( { bgFile = "interface/minimap/tooltipbackdrop-background.blp",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = false, tileSize = 0, edgeSize = 12, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 }});
playersLeft:SetSize(ClickCaidanW,(ClickCaidanH+4)*#menuName+40);
playersLeft:SetPoint("TOPLEFT",TablistFrame_5_UI,"TOPLEFT",0,0);
playersLeft:SetFrameStrata("FULLSCREEN_DIALOG")
playersLeft:EnableMouse(true)
playersLeft:Hide();
local playersLeft_Name = playersLeft:CreateFontString("playersLeft_Name_UI");
playersLeft_Name:SetPoint("TOPLEFT",playersLeft,"TOPLEFT", 10, -4);
playersLeft_Name:SetHeight(ClickCaidanH);
playersLeft_Name:SetFontObject(GameFontNormal);
playersLeft_Name:SetJustifyH("LEFT");
playersLeft_Name:SetText();
local playersLeft_ID = playersLeft:CreateFontString("playersLeft_ID_UI");
playersLeft_ID:SetPoint("LEFT",playersLeft_Name,"RIGHT", 0, 0);
playersLeft_ID:SetFontObject(GameFontNormal);
playersLeft_ID:Hide();
local playersLeft_ID1 = playersLeft:CreateFontString("playersLeft_ID1_UI");
playersLeft_ID1:SetPoint("LEFT",playersLeft_Name,"RIGHT", 0, 0);
playersLeft_ID1:SetFontObject(GameFontNormal);
playersLeft_ID1:Hide();
playersLeft.xiaoshidaojishi = 0;
playersLeft.zhengzaixianshi = nil;
playersLeft:SetScript("OnUpdate", function(self, ssss)
	if playersLeft.zhengzaixianshi==nil then
		return;
	else
		if playersLeft.zhengzaixianshi==true then
			if playersLeft.xiaoshidaojishi<= 0 then
				playersLeft:Hide();
				playersLeft.zhengzaixianshi = nil;
			else
				playersLeft.xiaoshidaojishi = playersLeft.xiaoshidaojishi - ssss;	
			end
		end
	end
end)
playersLeft:SetScript("OnEnter", function()
	playersLeft.zhengzaixianshi = nil;
end)
playersLeft:SetScript("OnLeave", function()
	playersLeft.xiaoshidaojishi = 1.5;
	playersLeft.zhengzaixianshi = true;
end)
--菜单函数
local function LeftMenu(id,i,ii)
	if _G["playersLeftmenu_text_"..id.."_UI"]:GetText()=="取消" then
		playersLeft_UI:Hide();
	end
	if _G["playersLeftmenu_text_"..id.."_UI"]:GetText()=="设为坦克补助" then
		PIG["RaidRecord"]["Raidinfo"][tonumber(i)][tonumber(ii)][5]="坦克补助";
		playersLeft_UI:Hide();
	end
	if _G["playersLeftmenu_text_"..id.."_UI"]:GetText()=="设为治疗补助" then
		PIG["RaidRecord"]["Raidinfo"][tonumber(i)][tonumber(ii)][5]="治疗补助";
		playersLeft_UI:Hide();
	end
	if _G["playersLeftmenu_text_"..id.."_UI"]:GetText()=="设为开怪猎人" then
		PIG["RaidRecord"]["Raidinfo"][tonumber(i)][tonumber(ii)][5]="开怪猎人";
		playersLeft_UI:Hide();
	end
	if _G["playersLeftmenu_text_"..id.."_UI"]:GetText()=="撤销补助设置" then
		PIG["RaidRecord"]["Raidinfo"][tonumber(i)][tonumber(ii)][5]="无";
		playersLeft_UI:Hide();
	end
	addonTable.RaidRecord_UpdateG();
end
-----
for i=1,#menuName do
	local playersLeftmenu = CreateFrame("Frame", "playersLeftmenu_"..i.."_UI", playersLeft);
	playersLeftmenu:SetHeight(ClickCaidanH);
	playersLeftmenu:SetPoint("LEFT",playersLeft,"LEFT", 0, 0);
	playersLeftmenu:SetPoint("RIGHT",playersLeft,"RIGHT", -10, 0);
	if i==1 then
		playersLeftmenu:SetPoint("TOPLEFT",playersLeft_Name,"BOTTOMLEFT", 0, -4);
	else
		playersLeftmenu:SetPoint("TOPLEFT",_G["playersLeftmenu_"..(i-1).."_UI"],"BOTTOMLEFT", 0, -4);
	end
	local playersLeftmenu_highlight = playersLeftmenu:CreateTexture("playersLeftmenu_highlight_"..i.."_UI", "BACKGROUND");
	playersLeftmenu_highlight:SetTexture("interface/buttons/ui-listbox-highlight.blp");
	playersLeftmenu_highlight:SetSize(playersLeftmenu:GetWidth(),ClickCaidanH);
	playersLeftmenu_highlight:SetPoint("TOPLEFT", playersLeftmenu, "TOPLEFT", 0,0);
	playersLeftmenu_highlight:SetPoint("BOTTOMRIGHT", playersLeftmenu, "BOTTOMRIGHT", 0,0);
	playersLeftmenu_highlight:SetAlpha(0.9);
	playersLeftmenu_highlight:Hide();
	if i<4 then
		local playersLeftmenu_tex = playersLeftmenu:CreateTexture("playersLeftmenu_"..i.."_tex_UI", "ARTWORK");
		playersLeftmenu_tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
		playersLeftmenu_tex:SetTexCoord(zhizeIcon[i][1],zhizeIcon[i][2],zhizeIcon[i][3],zhizeIcon[i][4]);
		playersLeftmenu_tex:SetSize(ClickCaidanH,ClickCaidanH);
		playersLeftmenu_tex:SetPoint("LEFT", playersLeftmenu, "LEFT", 0,0);
	end
	local playersLeftmenu_text = playersLeftmenu:CreateFontString("playersLeftmenu_text_"..i.."_UI");
	playersLeftmenu_text:SetPoint("LEFT",playersLeftmenu,"LEFT", 22, 0);
	playersLeftmenu_text:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	playersLeftmenu_text:SetText(menuName[i]);
	_G["playersLeftmenu_"..i.."_UI"]:SetScript("OnEnter", function (self)
		_G["playersLeftmenu_highlight_"..i.."_UI"]:Show();
		playersLeft.zhengzaixianshi = nil;
	end);
	_G["playersLeftmenu_"..i.."_UI"]:SetScript("OnLeave", function (self)
		_G["playersLeftmenu_highlight_"..i.."_UI"]:Hide();
		playersLeft.xiaoshidaojishi = 1.5;
		playersLeft.zhengzaixianshi = true;
	end);
	_G["playersLeftmenu_"..i.."_UI"]:SetScript("OnMouseDown", function (self)
		if i<4 then _G["playersLeftmenu_"..i.."_tex_UI"]:SetPoint("LEFT",self,"LEFT",1,-1); end
		_G["playersLeftmenu_text_"..i.."_UI"]:SetPoint("LEFT",self,"LEFT",23,-1);
	end);
	_G["playersLeftmenu_"..i.."_UI"]:SetScript("OnMouseUp", function (self,button)
		if i<4 then _G["playersLeftmenu_"..i.."_tex_UI"]:SetPoint("LEFT",self,"LEFT",0,0);end
		_G["playersLeftmenu_text_"..i.."_UI"]:SetPoint("LEFT",self,"LEFT",22,0);
		LeftMenu(i,playersLeft_ID_UI:GetText(),playersLeft_ID1_UI:GetText())
		UpdateShow()
	end);
end
--===================================================
-- 设置分G比例
local RightmenuName={"设为双倍工资","设为0.5倍工资","设为不分G","恢复默认1倍","取消"}
local playersRight = CreateFrame("Frame", "playersRight_UI", TablistFrame_5_UI,"BackdropTemplate");
playersRight:SetBackdrop( { bgFile = "interface/minimap/tooltipbackdrop-background.blp",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = false, tileSize = 0, edgeSize = 12, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 }});
playersRight:SetSize(ClickCaidanW,(ClickCaidanH+4)*#RightmenuName+40);
playersRight:SetPoint("TOPLEFT",TablistFrame_5_UI,"TOPLEFT",0,0);
playersRight:SetFrameStrata("FULLSCREEN_DIALOG")
playersRight:EnableMouse(true)
playersRight:Hide();
local playersRight_Name = playersRight:CreateFontString("playersRight_Name_UI");
playersRight_Name:SetPoint("TOPLEFT",playersRight,"TOPLEFT", 10, -4);
playersRight_Name:SetHeight(ClickCaidanH);
playersRight_Name:SetFontObject(GameFontNormal);
playersRight_Name:SetJustifyH("LEFT");
playersRight_Name:SetText();
local playersRight_ID = playersRight:CreateFontString("playersRight_ID_UI");
playersRight_ID:SetPoint("LEFT",playersRight_Name,"RIGHT", 0, 0);
playersRight_ID:SetFontObject(GameFontNormal);
playersRight_ID:Hide();
local playersRight_ID1 = playersRight:CreateFontString("playersRight_ID1_UI");
playersRight_ID1:SetPoint("LEFT",playersRight_Name,"RIGHT", 0, 0);
playersRight_ID1:SetFontObject(GameFontNormal);
playersRight_ID1:Hide();
playersRight.xiaoshidaojishi = 0;
playersRight.zhengzaixianshi = nil;
playersRight:SetScript("OnUpdate", function(self, ssss)
	if playersRight.zhengzaixianshi==nil then
		return;
	else
		if playersRight.zhengzaixianshi==true then
			if playersRight.xiaoshidaojishi<= 0 then
				playersRight:Hide();
				playersRight.zhengzaixianshi = nil;
			else
				playersRight.xiaoshidaojishi = playersRight.xiaoshidaojishi - ssss;	
			end
		end
	end
end)
playersRight:SetScript("OnEnter", function()
	playersRight.zhengzaixianshi = nil;
end)
playersRight:SetScript("OnLeave", function()
	playersRight.xiaoshidaojishi = 1.5;
	playersRight.zhengzaixianshi = true;
end)
--菜单函数
local function RightClickMenu(id,i,ii)
	if _G["playersRightmenu_text_"..id.."_UI"]:GetText()=="取消" then
		playersRight_UI:Hide();
	end
	if _G["playersRightmenu_text_"..id.."_UI"]:GetText()=="设为双倍工资" then
		PIG["RaidRecord"]["Raidinfo"][tonumber(i)][tonumber(ii)][7]=2;
		playersRight_UI:Hide();
	end
	if _G["playersRightmenu_text_"..id.."_UI"]:GetText()=="设为0.5倍工资" then
		PIG["RaidRecord"]["Raidinfo"][tonumber(i)][tonumber(ii)][7]=0.5;
		playersRight_UI:Hide();
	end
	if _G["playersRightmenu_text_"..id.."_UI"]:GetText()=="设为不分G" then
		PIG["RaidRecord"]["Raidinfo"][tonumber(i)][tonumber(ii)][7]=0;
		playersRight_UI:Hide();
	end
	if _G["playersRightmenu_text_"..id.."_UI"]:GetText()=="恢复默认1倍" then
		PIG["RaidRecord"]["Raidinfo"][tonumber(i)][tonumber(ii)][7]=1;
		playersRight_UI:Hide();
	end
	addonTable.RaidRecord_UpdateG();
end
-----
for i=1,#RightmenuName do
	local playersRightmenu = CreateFrame("Frame", "playersRightmenu_"..i.."_UI", playersRight);
	playersRightmenu:SetHeight(ClickCaidanH);
	playersRightmenu:SetPoint("LEFT",playersRight,"LEFT", 0, 0);
	playersRightmenu:SetPoint("RIGHT",playersRight,"RIGHT", -10, 0);
	if i==1 then
		playersRightmenu:SetPoint("TOPLEFT",playersRight_Name,"BOTTOMLEFT", 0, -4);
	else
		playersRightmenu:SetPoint("TOPLEFT",_G["playersRightmenu_"..(i-1).."_UI"],"BOTTOMLEFT", 0, -4);
	end
	local playersRightmenu_highlight = playersRightmenu:CreateTexture("playersRightmenu_highlight_"..i.."_UI", "BACKGROUND");
	playersRightmenu_highlight:SetTexture("interface/buttons/ui-listbox-highlight.blp");
	playersRightmenu_highlight:SetSize(playersRightmenu:GetWidth(),ClickCaidanH);
	playersRightmenu_highlight:SetPoint("TOPLEFT", playersRightmenu, "TOPLEFT", 0,0);
	playersRightmenu_highlight:SetPoint("BOTTOMRIGHT", playersRightmenu, "BOTTOMRIGHT", 0,0);
	playersRightmenu_highlight:SetAlpha(0.9);
	playersRightmenu_highlight:Hide();
	local playersRightmenu_tex = playersRightmenu:CreateTexture("playersRightmenu_"..i.."_tex_UI", "ARTWORK");
	if i==1 then
		playersRightmenu_tex:SetTexture(fenGbiliIcon[i]);
		playersRightmenu_tex:SetSize(ClickCaidanH,ClickCaidanH);
		playersRightmenu_tex:SetPoint("LEFT", playersRightmenu, "LEFT", 0,0);
	elseif i<4 then
		playersRightmenu_tex:SetTexture(fenGbiliIcon[i]);
		playersRightmenu_tex:SetTexCoord(fenGbiliIconCaiqie[i][1],fenGbiliIconCaiqie[i][2],fenGbiliIconCaiqie[i][3],fenGbiliIconCaiqie[i][4]);
		playersRightmenu_tex:SetSize(ClickCaidanH-4,ClickCaidanH-4);
		playersRightmenu_tex:SetPoint("LEFT", playersRightmenu, "LEFT", 1,0);
	end
	local playersRightmenu_text = playersRightmenu:CreateFontString("playersRightmenu_text_"..i.."_UI");
	playersRightmenu_text:SetPoint("LEFT",playersRightmenu,"LEFT", 22, 0);
	playersRightmenu_text:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	playersRightmenu_text:SetText(RightmenuName[i]);
	_G["playersRightmenu_"..i.."_UI"]:SetScript("OnEnter", function (self)
		_G["playersRightmenu_highlight_"..i.."_UI"]:Show();
		playersRight.zhengzaixianshi = nil;
	end);
	_G["playersRightmenu_"..i.."_UI"]:SetScript("OnLeave", function (self)
		_G["playersRightmenu_highlight_"..i.."_UI"]:Hide();
		playersRight.xiaoshidaojishi = 1.5;
		playersRight.zhengzaixianshi = true;
	end);
	_G["playersRightmenu_"..i.."_UI"]:SetScript("OnMouseDown", function (self)
		_G["playersRightmenu_text_"..i.."_UI"]:SetPoint("LEFT",self,"LEFT",23,-1);
	end);
	_G["playersRightmenu_"..i.."_UI"]:SetScript("OnMouseUp", function (self,button)
		_G["playersRightmenu_text_"..i.."_UI"]:SetPoint("LEFT",self,"LEFT",22,0);
		RightClickMenu(i,playersRight_ID_UI:GetText(),playersRight_ID1_UI:GetText())
		UpdateShow()
	end);
end
------------------------------------------------------------
--创建队伍角色框架
for p=1,8 do
	local RaidiDuiwu = CreateFrame("Frame", "RaidiDuiwu_"..p.."_UI", TablistFrame_5_UI);
	RaidiDuiwu:SetSize(duiwu_Width,duiwu_Height*5+24);
	if p==1 then
		RaidiDuiwu:SetPoint("TOPLEFT",TablistFrame_5_UI,"TOPLEFT",26,-54);
	end
	if p>1 and p<5 then
		RaidiDuiwu:SetPoint("LEFT",_G["RaidiDuiwu_"..(p-1).."_UI"],"RIGHT",jiangeW,jiangeH);
	end
	if p==5 then
		RaidiDuiwu:SetPoint("TOP",_G["RaidiDuiwu_1_UI"],"BOTTOM",0,-20);
	end
	if p>5 then
		RaidiDuiwu:SetPoint("LEFT",_G["RaidiDuiwu_"..(p-1).."_UI"],"RIGHT",jiangeW,jiangeH);
	end
	for pp=1,5 do
		local RaidiDuiwu = CreateFrame("Frame", "RaidiDuiwu_"..p.."_"..pp, _G["RaidiDuiwu_"..p.."_UI"]);
		RaidiDuiwu:SetSize(duiwu_Width,duiwu_Height);
		if pp==1 then
			RaidiDuiwu:SetPoint("TOP",_G["RaidiDuiwu_"..p.."_UI"],"TOP",0,0);
		else
			RaidiDuiwu:SetPoint("TOP",_G["RaidiDuiwu_"..p.."_"..(pp-1)],"BOTTOM",0,-6);
		end
		local RaidiDuiwu_HP = RaidiDuiwu:CreateTexture("RaidiDuiwu_HP_"..p.."_"..pp, "BORDER");
		RaidiDuiwu_HP:SetTexture("Interface/DialogFrame/UI-DialogBox-Background");
		RaidiDuiwu_HP:SetColorTexture(1, 1, 1, 0.1)
		RaidiDuiwu_HP:SetSize(duiwu_Width,duiwu_Height);
		RaidiDuiwu_HP:SetPoint("CENTER");
		local RaidiDuiwu_zhizeIcon = RaidiDuiwu:CreateTexture("RaidiDuiwu_zhizeIcon_"..p.."_"..pp, "ARTWORK");
		RaidiDuiwu_zhizeIcon:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
		RaidiDuiwu_zhizeIcon:SetSize(duiwu_Height-6,duiwu_Height-6);
		RaidiDuiwu_zhizeIcon:SetPoint("LEFT", RaidiDuiwu, "LEFT", 2,0);
		local RaidiDuiwu_Name = RaidiDuiwu:CreateFontString("RaidiDuiwu_Name_"..p.."_"..pp);
		RaidiDuiwu_Name:SetPoint("CENTER",RaidiDuiwu,"CENTER",0,1);
		RaidiDuiwu_Name:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		RaidiDuiwu_Name:SetText()
		RaidiDuiwu_Name:Hide()
		local RaidiDuiwu_Name_XS = RaidiDuiwu:CreateFontString("RaidiDuiwu_Name_XS_"..p.."_"..pp);
		RaidiDuiwu_Name_XS:SetPoint("CENTER",RaidiDuiwu,"CENTER",0,1);
		RaidiDuiwu_Name_XS:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		RaidiDuiwu_Name_XS:SetText()
		local RaidiDuiwu_fenGbili = RaidiDuiwu:CreateTexture("RaidiDuiwu_fenGbili_"..p.."_"..pp, "ARTWORK");
		RaidiDuiwu_fenGbili:SetTexture(fenGbiliIcon[1]);
		RaidiDuiwu_fenGbili:SetSize(duiwu_Height-7,duiwu_Height-7);
		RaidiDuiwu_fenGbili:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,-0.6);
		local RaidiDuiwu_fenGbili_1 = RaidiDuiwu:CreateTexture("RaidiDuiwu_fenGbili_1_"..p.."_"..pp, "ARTWORK");
		RaidiDuiwu_fenGbili_1:SetTexture(fenGbiliIcon[2]);
		RaidiDuiwu_fenGbili_1:SetTexCoord(fenGbiliIconCaiqie[2][1],fenGbiliIconCaiqie[2][2],fenGbiliIconCaiqie[2][3],fenGbiliIconCaiqie[2][4]);
		RaidiDuiwu_fenGbili_1:SetSize(duiwu_Height-10,duiwu_Height-10);
		RaidiDuiwu_fenGbili_1:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,0);
		local RaidiDuiwu_fenGbili_2 = RaidiDuiwu:CreateTexture("RaidiDuiwu_fenGbili_2_"..p.."_"..pp, "ARTWORK");
		RaidiDuiwu_fenGbili_2:SetTexture(fenGbiliIcon[3]);
		RaidiDuiwu_fenGbili_2:SetTexCoord(fenGbiliIconCaiqie[3][1],fenGbiliIconCaiqie[3][2],fenGbiliIconCaiqie[3][3],fenGbiliIconCaiqie[3][4]);
		RaidiDuiwu_fenGbili_2:SetSize(duiwu_Height-10,duiwu_Height-10);
		RaidiDuiwu_fenGbili_2:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,0);
		_G["RaidiDuiwu_"..p.."_"..pp]:SetScript("OnMouseDown", function (self)
			_G["RaidiDuiwu_zhizeIcon_"..p.."_"..pp]:SetPoint("LEFT",self,"LEFT",3,-1);
			_G["RaidiDuiwu_fenGbili_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -0.5,-2.1);
			_G["RaidiDuiwu_fenGbili_1_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -0.5,-1.5);
			_G["RaidiDuiwu_fenGbili_2_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -0.5,-1.5);
			_G["RaidiDuiwu_Name_XS_"..p.."_"..pp]:SetPoint("CENTER",self,"CENTER",1.5,-0.5);
		end);
		_G["RaidiDuiwu_"..p.."_"..pp]:SetScript("OnMouseUp", function (self,button)
			_G["RaidiDuiwu_zhizeIcon_"..p.."_"..pp]:SetPoint("LEFT",self,"LEFT",2,0);
			_G["RaidiDuiwu_fenGbili_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,-0.6);
			_G["RaidiDuiwu_fenGbili_1_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,0);
			_G["RaidiDuiwu_fenGbili_2_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,0);
			_G["RaidiDuiwu_Name_XS_"..p.."_"..pp]:SetPoint("CENTER",self,"CENTER",0,1);
			if button=="LeftButton" then
				playersRight_UI:Hide();
				playersLeft_UI:ClearAllPoints();
				playersLeft_UI:SetPoint("TOP",self,"BOTTOM",0,4);
				if playersLeft_UI:IsShown() then
					playersLeft_UI:Hide();
				else
					playersLeft_UI:Show();
					playersLeft.xiaoshidaojishi = 1.5;
					playersLeft.zhengzaixianshi = true;
				end
				playersLeft_Name_UI:SetText(_G["RaidiDuiwu_Name_"..p.."_"..pp]:GetText());
				playersLeft_ID_UI:SetText(p);playersLeft_ID1_UI:SetText(pp);
				if playersLeft_Name_UI:GetWidth()>120 then
					playersLeft_UI:SetWidth(playersLeft_Name_UI:GetWidth()+20)
				end
			elseif button=="RightButton" then
				playersLeft_UI:Hide();
				playersRight_UI:ClearAllPoints();
				playersRight_UI:SetPoint("TOP",self,"BOTTOM",0,4);
				if playersRight_UI:IsShown() then
					playersRight_UI:Hide();
				else
					playersRight_UI:Show();
					playersRight.xiaoshidaojishi = 1.5;
					playersRight.zhengzaixianshi = true;
				end
				playersRight_Name_UI:SetText(_G["RaidiDuiwu_Name_"..p.."_"..pp]:GetText());
				playersRight_ID_UI:SetText(p);playersRight_ID1_UI:SetText(pp);
				if playersRight_Name_UI:GetWidth()>120 then
					playersRight_UI:SetWidth(playersRight_Name_UI:GetWidth()+20)
				end
			end
		end);
	end
end
----=========================================================
--冻结模式提示
local renyuankuaizhaomoshi_tishi = CreateFrame("Frame", "renyuankuaizhaomoshi_tishi_UI", xiafangFrame_UI);
renyuankuaizhaomoshi_tishi:SetSize(34,34);
renyuankuaizhaomoshi_tishi:SetPoint("TOPLEFT",xiafangFrame_UI,"TOPLEFT",Width*0.55,-2);
renyuankuaizhaomoshi_tishi:Hide();
local renyuankuaizhaomoshi_tishi_Texture = renyuankuaizhaomoshi_tishi:CreateTexture("renyuankuaizhaomoshi_tishi_Texture_UI", "BORDER");
renyuankuaizhaomoshi_tishi_Texture:SetTexture("interface/helpframe/helpicon-reportabuse.blp");
renyuankuaizhaomoshi_tishi_Texture:SetSize(50,50);
renyuankuaizhaomoshi_tishi_Texture:SetPoint("CENTER",renyuankuaizhaomoshi_tishi,"CENTER",0,0);
renyuankuaizhaomoshi_tishi:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(renyuankuaizhaomoshi_tishi, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("点击解除冻结")
	GameTooltip:AddLine("\124cff00FFFF当前人员信息已冻结(不会因退组/新增人员改变)！\124r")
	GameTooltip:AddLine("\124cff00FF00如需获取人员实时信息，请点击此图标关闭冻结！\124r")
	GameTooltip:Show();
end);
renyuankuaizhaomoshi_tishi:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
renyuankuaizhaomoshi_tishi:SetScript("OnMouseUp", function (self,button)
	StaticPopup_Show ("OFFSHISHIRAIDINFO");
end);
StaticPopupDialogs["OFFSHISHIRAIDINFO"] = {
	text = "确定解除人员信息冻结吗？\n\n解除后人员将实时更新\n\n\124cff00FF00分G计算前需重新冻结\124r\n\n",
	button1 = "确定",
	button2 = "取消",
	OnAccept = function()
		PIG["RaidRecord"]["Dongjie"] = "OFF";
		huoquRaidInfo_UI:SetText('冻结人员信息');
		TablistFrame_5_UI.shuaxinINFO:Hide();
		RaidgengxinUI:UnregisterEvent("CHAT_MSG_WHISPER"); 
		UpdateShow()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}

--获取快照
local huoquRaidInfo = CreateFrame("Button","huoquRaidInfo_UI",xiafangFrame_UI, "UIPanelButtonTemplate");
huoquRaidInfo:SetSize(110,28);
huoquRaidInfo:SetPoint("TOPLEFT",Jing_RS_UI,"BOTTOMLEFT",0,-6);
huoquRaidInfo:SetText('冻结人员信息');
huoquRaidInfo:SetScript("OnClick", function (self)
	if self:GetText()=='更新冻结信息' then
		StaticPopup_Show ("HUOQU_RAIDINFO_UP");
	elseif self:GetText()=='冻结人员信息' then
		StaticPopup_Show ("HUOQU_RAIDINFO");
	end
end);
StaticPopupDialogs["HUOQU_RAIDINFO_UP"] = {
	text = "确定要更新已冻结人员信息吗？\n\n",
	button1 = "确定",
	button2 = "取消",
	OnAccept = function()
		PIG["RaidRecord"]["Dongjie"] = "ON";
		TablistFrame_5_UI.shuaxinINFO:Show();
		RaidgengxinUI:RegisterEvent("CHAT_MSG_WHISPER");
		addonTable.RaidRecord_Invite_yaoqing=false;
		addonTable.RaidRecord_Invite_hanhua=false;
		UpdateRiadInfo();
		addonTable.RaidRecord_UpdateChengjiaorenxuanze()
		addonTable.RaidRecord_Updatejianglixuanze()
		addonTable.RaidRecord_Updatefakuanxuanze()
		UpdateShow()
		print("|cff00FFFF!Pig:|r|cffFFFF00人员冻结信息已更新！|r");
		local isLeader = UnitIsGroupLeader("player", "LE_PARTY_CATEGORY_HOME");
		if isLeader then
			local fullName, realm = UnitFullName("player")
			local IsInRaid=IsInRaid("LE_PARTY_CATEGORY_HOME");
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
		huoquRaidInfo:SetText('更新冻结信息');
		TablistFrame_5_UI.shuaxinINFO:Show();
		RaidgengxinUI:RegisterEvent("CHAT_MSG_WHISPER");
		addonTable.RaidRecord_Invite_yaoqing=false;
		addonTable.RaidRecord_Invite_hanhua=false;
		UpdateShow()
		print("|cff00FFFF!Pig:|r|cffFFFF00人员信息已冻结！|r");
		local isLeader = UnitIsGroupLeader("player", "LE_PARTY_CATEGORY_HOME");
		if isLeader then
			local fullName, realm = UnitFullName("player")
			local IsInRaid=IsInRaid("LE_PARTY_CATEGORY_HOME");
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
--快照提示
local huoquRaidInfo_tishi = CreateFrame("Frame", "huoquRaidInfo_tishi_UI", xiafangFrame_UI);
huoquRaidInfo_tishi:SetSize(30,30);
huoquRaidInfo_tishi:SetPoint("LEFT",huoquRaidInfo,"RIGHT",-8,0);
local huoquRaidInfo_tishi_Texture = huoquRaidInfo_tishi:CreateTexture("huoquRaidInfo_tishi_Texture_UI", "BORDER");
huoquRaidInfo_tishi_Texture:SetTexture("interface/common/help-i.blp");
huoquRaidInfo_tishi_Texture:SetAllPoints(huoquRaidInfo_tishi)
huoquRaidInfo_tishi:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(huoquRaidInfo_tishi, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("\124cff00ff001、分G计算前需冻结人员信息，防止人员变动影响分G计算结果。\124r\n"..
		"\124cff00ff002、冻结后方可在\124r\124cffFFff00分G助手\124r\124cff00ff00计算分账明细。\124r\n")
	GameTooltip:AddLine(
		"\124cffFFA500建议在活动结束后人员变动之前冻结人员信息。冻结之后，分G结果\n不会因\124r\124cffFFff00新增人员/移动分组/人员退组/离线\124r\124cffFFA500而改变。\124r")
	GameTooltip:Show();
end);
huoquRaidInfo_tishi:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);

--界面显示隐藏刷新
TablistFrame_5_UI:SetScript("OnShow", function ()
	UpdateShow()
end)
TablistFrame_5_UI:SetScript("OnHide", function ()
	playersLeft_UI:Hide();playersRight_UI:Hide();
end)
--=============================================================================
local RaidgengxinUI = CreateFrame("Frame","RaidgengxinUI");     
RaidgengxinUI:HookScript("OnEvent",function(self, event,arg1,_,_,_,arg5)
	if event=="GROUP_ROSTER_UPDATE" then
		if PIG["RaidRecord"]["Dongjie"] == "OFF" then
			UpdateShow()
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
local function RaidinfoEvent()
	if PIG["RaidRecord"]["Kaiqi"]=="ON" then
		local englishFaction, _ = UnitFactionGroup("player")
		if englishFaction=="Alliance" then
			classesAll_Tex_UI:SetTexCoord(0,0.5,0,1);
		elseif englishFaction=="Horde" then
			classesAll_Tex_UI:SetTexCoord(0.5,1,0,1);
		end
		local IsInGroup = IsInGroup("LE_PARTY_CATEGORY_HOME");
		if IsInGroup then
			huoquRaidInfo_UI:Enable();
		else
			huoquRaidInfo_UI:Disable();
		end
		RaidgengxinUI:RegisterEvent("GROUP_ROSTER_UPDATE")
		if PIG["RaidRecord"]["Dongjie"]=="OFF" then
			renyuankuaizhaomoshi_tishi_UI:Hide();
			fenG_BUT_UI:Disable();
			zudui_but_UI:Enable(); 
			RaidgengxinUI:UnregisterEvent("CHAT_MSG_WHISPER"); 
		elseif PIG["RaidRecord"]["Dongjie"]=="ON" then
			huoquRaidInfo:SetText('更新冻结信息');
			TablistFrame_5_UI.shuaxinINFO:Show();		
			renyuankuaizhaomoshi_tishi_UI:Show();
			fenG_BUT_UI:Enable();
			zudui_but_UI:Disable();
			RaidgengxinUI:RegisterEvent("CHAT_MSG_WHISPER");
		end
	else
		RaidgengxinUI:UnregisterEvent("GROUP_ROSTER_UPDATE")
		RaidgengxinUI:UnregisterEvent("CHAT_MSG_WHISPER");
	end
end
addonTable.RaidRecord_RaidInfo = RaidinfoEvent;