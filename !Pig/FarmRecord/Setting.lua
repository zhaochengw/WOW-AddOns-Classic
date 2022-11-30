local _, addonTable = ...;
local gsub = _G.string.gsub
local find = _G.string.find
local ADD_Frame=addonTable.ADD_Frame
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local PIGDownMenu=addonTable.PIGDownMenu
local _, _, _, tocversion = GetBuildInfo()
--带本助手-设置====================
local daibenData=addonTable.daibenData
local Width,DHeight,biaotiH= daibenData.Width,daibenData.DHeight,daibenData.biaotiH
local WowWidth= daibenData.WowWidth
local WowHeight= daibenData.WowHeight
--目的地
local FBdata=addonTable.FBdata
local InstanceList = FBdata[1]
local InstanceID = FBdata[2]
--------
local function Open_settingUI()
	local fuF = daiben_UI
	fuF.JizhangF.youhuie:Hide();
	fuF.hanren.bianjiHanhua.F:Hide();
	Daiben_shezhi_F_UI:ClearAllPoints();
	if fuF:GetLeft()<WowWidth then
		if fuF:GetBottom()<WowHeight then
			Daiben_shezhi_F_UI:SetPoint("BOTTOMLEFT",fuF,"BOTTOMRIGHT",2,0);
		else
			Daiben_shezhi_F_UI:SetPoint("TOPLEFT",fuF,"TOPRIGHT",2,0);
		end
	else
		if fuF:GetBottom()<WowHeight then
			Daiben_shezhi_F_UI:SetPoint("BOTTOMRIGHT",fuF,"BOTTOMLEFT",-2,0);
		else
			Daiben_shezhi_F_UI:SetPoint("TOPRIGHT",fuF,"TOPLEFT",-2,0);
		end
	end
	Daiben_shezhi_F_UI:Show();
end
addonTable.Open_settingUI=Open_settingUI
local function ADD_settingUI(Width,WowWidth,WowHeight)
	local fuFrame = daiben_UI.setting
	fuFrame.F=ADD_Frame("Daiben_shezhi_F_UI",fuFrame,520, 334,"CENTER",UIParent,"CENTER",0,0,true,false,false,false,true,"BG4")
	
	fuFrame.F.Close = CreateFrame("Button",nil,fuFrame.F, "UIPanelCloseButton");  
	fuFrame.F.Close:SetSize(28,28);
	fuFrame.F.Close:SetPoint("TOPRIGHT",fuFrame.F,"TOPRIGHT",3,3);

	fuFrame.F.mudidiT = fuFrame.F:CreateFontString();
	fuFrame.F.mudidiT:SetPoint("TOPLEFT",fuFrame.F,"TOPLEFT",5,-7);
	fuFrame.F.mudidiT:SetFontObject(GameFontNormal);
	fuFrame.F.mudidiT:SetText("选择副本:");
	fuFrame.F.mudidi=PIGDownMenu(nil,{170,24},fuFrame.F,{"LEFT",fuFrame.F.mudidiT,"RIGHT", 0,0})
	function fuFrame.F.mudidi:PIGDownMenu_Update_But(self, level, menuList)
		local NewInstanceList = {{"无","无"}}
		for i=1,#InstanceList do
			table.insert(NewInstanceList,InstanceList[i])
		end
		local info = {}
		if (level or 1) == 1 then
			for i=1,#NewInstanceList,1 do
				info.text= NewInstanceList[i][1]
				if i==1 then
					info.func = self.PIGDownMenu_SetValue
					info.arg1= NewInstanceList[i][2];
					info.hasArrow = false
					info.checked = info.arg1 == PIG_Per["daiben"]["fubenName"]
				else
					local xuanzhongzai=false
					local data2=InstanceID[NewInstanceList[i][2]][NewInstanceList[i][3]]
					for x=1,#data2 do
						if data2[x]==PIG_Per["daiben"]["fubenName"] then
							xuanzhongzai = true
							break
						end
					end
					info.checked = xuanzhongzai
					info.menuList, info.hasArrow = data2, true
				end
				fuFrame.F.mudidi:PIGDownMenu_AddButton(info)
			end
		else
			info.func = self.PIGDownMenu_SetValue
			for ii=1, #menuList do
				local inname = menuList[ii]
				info.text, info.arg1= inname, inname;
				info.checked = info.arg1 == PIG_Per["daiben"]["fubenName"]
				fuFrame.F.mudidi:PIGDownMenu_AddButton(info, level)
			end
		end
	end
	fuFrame.F.mudidi:PIGDownMenu_SetText(PIG_Per["daiben"]["fubenName"])

	local function EditBoxBG_Hide()
		for id = 1, 4, 1 do
			local ff = _G["Danjialist_"..id]
			ff.V1:Disable()
			ff.V1:SetTextColor(0, 1, 0, 1);
			ff.V1.Left:Hide();ff.V1.Middle:Hide();ff.V1.Right:Hide();
			ff.V2:Disable()
			ff.V2:SetTextColor(0, 1, 0, 1);
			ff.V2.Left:Hide();ff.V2.Middle:Hide();ff.V2.Right:Hide();
			ff.G:Disable()
			ff.G:SetTextColor(0, 1, 0, 1);
			ff.G.Left:Hide();ff.G.Middle:Hide();ff.G.Right:Hide();
		end
	end
	local function EditBoxBG_Show()
		for id = 1, 4, 1 do
			local ff = _G["Danjialist_"..id]
			ff.V1:Enable()
			ff.V1:SetTextColor(1, 1, 0, 1);
			ff.V1.Left:Show();ff.V1.Middle:Show();ff.V1.Right:Show();
			ff.V2:Enable()
			ff.V2:SetTextColor(1, 1, 0, 1);
			ff.V2.Left:Show();ff.V2.Middle:Show();ff.V2.Right:Show();
			ff.G:Enable()
			ff.G:SetTextColor(1, 1, 0, 1);
			ff.G.Left:Show();ff.G.Middle:Show();ff.G.Right:Show();
		end
	end
	local function gengxinDanjiaV(fbName)
		PIG_Per["daiben"]["LV_danjia"][fbName]=PIG_Per["daiben"]["LV_danjia"][fbName] or {{0,0,0},{0,0,0},{0,0,0},{0,0,0}}
		local jiageinfo = PIG_Per["daiben"]["LV_danjia"][fbName]
		for id = 1, 4, 1 do
			local ff = _G["Danjialist_"..id]
			ff.V1:SetText("");
			ff.V2:SetText("");
			ff.G:SetText("");
			local kaishi,jieshu,danjia=jiageinfo[id][1],jiageinfo[id][2],jiageinfo[id][3]
			if kaishi>0 then
				ff.V1:SetText(kaishi);
				ff.V2:SetText(jieshu);
				if danjia>=0 then
					ff.G:SetText(danjia);
				end
			end
		end
	end
	local Update_jizhangData=addonTable.Update_jizhangData
	function fuFrame.F.mudidi:PIGDownMenu_SetValue(value,arg1,arg2)
		fuFrame.F.mudidi:PIGDownMenu_SetText(value)
		PIG_Per["daiben"]["fubenName"]=arg1
		if arg1=="无" then
			fuFrame.F.danjiaF.XG:Hide();
			PIG_Per.daiben.autohuifu=false
			daiben_UI.yesno.Tex:SetTexture("interface/common/indicator-red.blp");
			daiben_UI.yesno:SetChecked(false)
		else
			fuFrame.F.danjiaF.XG:Show();
		end
		gengxinDanjiaV(arg1)
		Update_jizhangData(true)
		PIGCloseDropDownMenus()
	end
	--单价设置
	local danjiaWW,danjiaHH = fuFrame.F:GetWidth()/2+30,120
	fuFrame.F.danjiaF = CreateFrame("Frame", nil, fuFrame.F,"BackdropTemplate");
	fuFrame.F.danjiaF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 10,});
	fuFrame.F.danjiaF:SetBackdropBorderColor(0, 1, 1, 0.8);
	fuFrame.F.danjiaF:SetSize(danjiaWW,danjiaHH);
	fuFrame.F.danjiaF:SetPoint("TOPLEFT", fuFrame.F, "TOPLEFT", 4,-30);
	--错误提示
	fuFrame.F.danjiaF.error = CreateFrame("Frame", nil, fuFrame.F.danjiaF,"BackdropTemplate");
	fuFrame.F.danjiaF.error:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 0, edgeSize = 10,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	fuFrame.F.danjiaF.error:SetSize(danjiaWW-4,danjiaHH-6);
	fuFrame.F.danjiaF.error:SetPoint("TOP",fuFrame.F.danjiaF,"TOP",0,-2);
	fuFrame.F.danjiaF.error:SetFrameStrata("HIGH")
	fuFrame.F.danjiaF.error:Hide();
	fuFrame.F.danjiaF.error.T = fuFrame.F.danjiaF.error:CreateFontString();
	fuFrame.F.danjiaF.error.T:SetPoint("TOP",fuFrame.F.danjiaF.error,"TOP",0,-20);
	fuFrame.F.danjiaF.error.T:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.F.danjiaF.error.Close = CreateFrame("Button",nil,fuFrame.F.danjiaF.error, "UIPanelButtonTemplate");  
	fuFrame.F.danjiaF.error.Close:SetSize(80,20);
	fuFrame.F.danjiaF.error.Close:SetPoint("TOP",fuFrame.F.danjiaF.error,"TOP",0,-60);
	fuFrame.F.danjiaF.error.Close:SetText("去修改");
	fuFrame.F.danjiaF.error.Close:SetScript("OnClick", function (self)
		fuFrame.F.danjiaF.error:Hide()
	end)
	fuFrame.F.danjiaF.XG = CreateFrame("Button",nil,fuFrame.F.danjiaF, "UIPanelButtonTemplate");  
	fuFrame.F.danjiaF.XG:SetSize(60,20);
	fuFrame.F.danjiaF.XG:SetPoint("LEFT",fuFrame.F.mudidi,"RIGHT",0,0);
	fuFrame.F.danjiaF.XG:SetText("编辑");
	fuFrame.F.danjiaF.XG:Hide();
	fuFrame.F.danjiaF.XG:SetScript("OnClick", function (self)
		if self:GetText()=="编辑" then
			self:SetText("保存");
			EditBoxBG_Show()
		elseif self:GetText()=="保存" then
			local kasihi_p1 =Danjialist_1.V1:GetNumber()
			local kasihi_p2 =Danjialist_2.V1:GetNumber()
			local kasihi_p3 =Danjialist_3.V1:GetNumber()
			local kasihi_p4 =Danjialist_4.V1:GetNumber()
			if kasihi_p4>0 then
				if kasihi_p1==0 or kasihi_p2==0 or kasihi_p3==0 then
					fuFrame.F.danjiaF.error:Show();
					fuFrame.F.danjiaF.error.T:SetText("|cffFF0000错误:|r|cffffFF00请安1234行顺序设置单价|r");
					return
				end
			end
			if kasihi_p3>0 then
				if kasihi_p1==0 or kasihi_p2==0 then
					fuFrame.F.danjiaF.error:Show();
					fuFrame.F.danjiaF.error.T:SetText("|cffFF0000错误:|r|cffffFF00请安1234行顺序设置单价|r");
					return
				end
			end
			if kasihi_p2>0 then
				if kasihi_p1==0 then
					fuFrame.F.danjiaF.error:Show();
					fuFrame.F.danjiaF.error.T:SetText("|cffFF0000错误:|r|cffffFF00请安1234行顺序设置单价|r");
					return
				end
			end
			for id = 1, 4, 1 do
				local ff = _G["Danjialist_"..id]
				local kasihi =ff.V1:GetNumber()
				local jieshu =ff.V2:GetNumber()
				if kasihi>0 or jieshu>0 then
					if kasihi>jieshu then
						fuFrame.F.danjiaF.error:Show();
						fuFrame.F.danjiaF.error.T:SetText("|cffFF0000错误:|r|cffffFF00第"..id.."行起始级别不能大于结束级别|r");
						return
					end
					if id<4 then
						local kasihi_pl =_G["Danjialist_"..id+1].V1:GetNumber()
						if kasihi_pl>0 then
							if jieshu>=kasihi_pl then
								fuFrame.F.danjiaF.error:Show();
								fuFrame.F.danjiaF.error.T:SetText("|cffFF0000错误:|r|cffffFF00第"..id.."行与第"..(id+1).."行级别范围重复|r");
								return
							end
							if kasihi_pl-jieshu>1 then
								fuFrame.F.danjiaF.error:Show();
								fuFrame.F.danjiaF.error.T:SetText("|cffFF0000错误:|r|cffffFF00第"..id.."行与第"..(id+1).."行之间有空余级别|r");
								return
							end
						end
					end
				end
			end
			--
			local fubennameX =PIG_Per.daiben.fubenName
			local dangqianfubandanjia = PIG_Per.daiben.LV_danjia[fubennameX]
			for id = 1, 4, 1 do
				local ff = _G["Danjialist_"..id]
				local kasihi =ff.V1:GetNumber()
				local jieshu =ff.V2:GetNumber()
				local danjiaG =ff.G:GetNumber()
				dangqianfubandanjia[id][1]=kasihi
				dangqianfubandanjia[id][2]=jieshu
				dangqianfubandanjia[id][3]=danjiaG
			end
			gengxinDanjiaV(fubennameX)
			EditBoxBG_Hide()
			self:SetText("编辑");
			Update_jizhangData(true)
		end
	end);
	-----------
	for id = 1, 4, 1 do
		local Danjialist = CreateFrame("Frame", "Danjialist_"..id, fuFrame.F.danjiaF);
		Danjialist:SetSize(danjiaWW,danjiaHH/4);
		if id==1 then
			Danjialist:SetPoint("TOPLEFT", fuFrame.F.danjiaF, "TOPLEFT", 0,0);
		else
			Danjialist:SetPoint("TOPLEFT", _G["Danjialist_"..(id-1)], "BOTTOMLEFT", 0,0);
		end
		if id~=4 then
			Danjialist.line1 = Danjialist:CreateLine()
			Danjialist.line1:SetColorTexture(0, 1, 1, 0.4)
			Danjialist.line1:SetThickness(1);
			Danjialist.line1:SetStartPoint("BOTTOMLEFT",2,0)
			Danjialist.line1:SetEndPoint("BOTTOMRIGHT",-2,0)
		end

		Danjialist.listID = Danjialist:CreateFontString();
		Danjialist.listID:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		Danjialist.listID:SetPoint("LEFT", Danjialist, "LEFT", 6,0);
		Danjialist.listID:SetText(id.."、");
		Danjialist.listID:SetTextColor(0, 0.8, 0.8, 1);

		Danjialist.V1 = CreateFrame('EditBox', nil, Danjialist,"InputBoxInstructionsTemplate");
		Danjialist.V1:SetSize(34,30);
		Danjialist.V1:SetPoint("LEFT", Danjialist.listID, "RIGHT", 5,0);
		Danjialist.V1:SetFontObject(ChatFontNormal);
		Danjialist.V1:SetAutoFocus(false);
		Danjialist.V1:SetNumeric(true)
		Danjialist.V1:SetMaxLetters(2)
		Danjialist.V1:SetJustifyH("CENTER");

		Danjialist.t1 = Danjialist:CreateFontString();
		Danjialist.t1:SetPoint("LEFT", Danjialist.V1, "RIGHT", 2,0);
		Danjialist.t1:SetFont(ChatFontNormal:GetFont(), 13);
		Danjialist.t1:SetText("级—");
		Danjialist.t1:SetTextColor(0.8, 0.8, 0.8, 1);

		Danjialist.V2 = CreateFrame('EditBox', nil, Danjialist,"InputBoxInstructionsTemplate");
		Danjialist.V2:SetSize(34,30);
		Danjialist.V2:SetPoint("LEFT", Danjialist.t1, "RIGHT", 10,0);
		Danjialist.V2:SetFontObject(ChatFontNormal);
		Danjialist.V2:SetAutoFocus(false);
		Danjialist.V2:SetNumeric(true)
		Danjialist.V2:SetMaxLetters(2)
		Danjialist.V2:SetJustifyH("CENTER");

		Danjialist.t2 = Danjialist:CreateFontString();
		Danjialist.t2:SetPoint("LEFT",Danjialist.V2,"RIGHT",5,0);
		Danjialist.t2:SetFont(ChatFontNormal:GetFont(), 13);
		Danjialist.t2:SetText("级,单价:");
		Danjialist.t2:SetTextColor(0.8, 0.8, 0.8, 1);

		Danjialist.G = CreateFrame('EditBox', nil, Danjialist,"InputBoxInstructionsTemplate");
		Danjialist.G:SetSize(50,30);
		Danjialist.G:SetPoint("LEFT", Danjialist.t2, "RIGHT", 10,0);
		Danjialist.G:SetFontObject(ChatFontNormal);
		Danjialist.G:SetAutoFocus(false);
		Danjialist.G:SetNumeric(true)
		Danjialist.G:SetMaxLetters(4)
		Danjialist.G:SetJustifyH("CENTER");

		Danjialist.Gt = Danjialist:CreateFontString();
		Danjialist.Gt:SetPoint("LEFT",Danjialist.G,"RIGHT",5,0);
		Danjialist.Gt:SetFont(ChatFontNormal:GetFont(), 13);
		Danjialist.Gt:SetText("G/次");
		Danjialist.Gt:SetTextColor(0.8, 0.8, 0.8, 1);
	end
	local leftPY,Ckjiange = 20,32
	--播报耗时/击杀数
	fuFrame.F.CZ_timejisha = ADD_Checkbutton(nil,fuFrame.F,-100,"TOPLEFT",fuFrame.F,"TOPLEFT",300,-28,"重置播报耗时/击杀数","重置播报上次刷本耗时/击杀数(非队长不生效)")
	fuFrame.F.CZ_timejisha:SetSize(28,28);
	fuFrame.F.CZ_timejisha:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.CZ_timejisha=true
		else
			PIG_Per.daiben.CZ_timejisha=false
		end
	end)
	fuFrame.F.CZ_yueyuci = ADD_Checkbutton(nil,fuFrame.F,-100,"TOPLEFT",fuFrame.F.CZ_timejisha,"BOTTOMLEFT",0,-2,"重置播报玩家余额/余次","重置播报队伍内玩家余额/余次(非队长不生效)")
	fuFrame.F.CZ_yueyuci:SetSize(28,28);
	fuFrame.F.CZ_yueyuci:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.CZ_yueyuci=true
		else
			PIG_Per.daiben.CZ_yueyuci=false
		end
	end);
	fuFrame.F.CZ_expSw = ADD_Checkbutton(nil,fuFrame.F,-100,"TOPLEFT",fuFrame.F.CZ_yueyuci,"BOTTOMLEFT",0,-2,"重置播报自身经验/声望","重置播报上次自身刷本获得的经验/声望")
	fuFrame.F.CZ_expSw:SetSize(28,28);
	fuFrame.F.CZ_expSw:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.CZ_expSw=true
		else
			PIG_Per.daiben.CZ_expSw=false
		end
	end);
	--重置时就位确认
	fuFrame.F.CZ_jiuwei= ADD_Checkbutton(nil,fuFrame.F,-100,"TOPLEFT",fuFrame.F.CZ_expSw,"BOTTOMLEFT",0,-2,"重置时就位确认","重置时就位确认(非队长不生效)")
	fuFrame.F.CZ_jiuwei:SetSize(28,28);
	fuFrame.F.CZ_jiuwei:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.CZ_jiuwei=true
		else
			PIG_Per.daiben.CZ_jiuwei=false
		end
	end);
	--有余额时锁定单价
	fuFrame.F.SDdanjia= ADD_Checkbutton(nil,fuFrame.F,-100,"TOPLEFT",fuFrame.F,"TOPLEFT",10,-150,"有余额时锁定单价","启用后，当玩家有余额时升级将不会更新单价，右击单价数字可手动刷新。")
	fuFrame.F.SDdanjia:SetSize(28,28);
	fuFrame.F.SDdanjia:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.SDdanjia=true
		else
			PIG_Per.daiben.SDdanjia=false
		end
	end);
	--
	fuFrame.F.CBbukouG= ADD_Checkbutton(nil,fuFrame.F,-100,"LEFT",fuFrame.F.SDdanjia,"RIGHT",200,0,"已击杀进组不扣款","启用后，玩家在进组时，你在副本内且本次已击杀怪物则重置时此玩家本次不扣款。")
	fuFrame.F.CBbukouG:SetSize(28,28);
	fuFrame.F.CBbukouG:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.CBbukouG=true
		else
			PIG_Per.daiben.CBbukouG=false
		end
	end);
	--
	fuFrame.F.HideYue= ADD_Checkbutton(nil,fuFrame.F,-100,"TOPLEFT",fuFrame.F.SDdanjia,"BOTTOMLEFT",0,0,"播报隐藏余额","启用后，重置播报余额/余次功能将不会播余额。")
	fuFrame.F.HideYue:SetSize(28,28);
	fuFrame.F.HideYue:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.HideYue=true
		else
			PIG_Per.daiben.HideYue=false
		end
	end);
	--H模式
	local Htishi = "英雄模式因需要下线重置，所以需要手动扣款，此模式开启后手动扣款<全队->时也会播报队内玩家余次/余额，并自动结束本次刷本记录\n|cff00FF00此模式下插件不在自行判断副本CD，手动扣款后进入副本默认为新CD|r";
	fuFrame.F.shoudongMOD= ADD_Checkbutton(nil,fuFrame.F,-100,"LEFT",fuFrame.F.HideYue,"RIGHT",200,0,"手动模式(英雄模式)",Htishi)
	fuFrame.F.shoudongMOD:SetSize(28,28);
	fuFrame.F.shoudongMOD:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.shoudongMOD=true
		else
			PIG_Per.daiben.shoudongMOD=false
		end
	end);
	---自动回复
	local EditBox_H=26
	fuFrame.F.autohuifuF = CreateFrame("Frame", nil, fuFrame.F,"BackdropTemplate");
	fuFrame.F.autohuifuF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 10,});
	fuFrame.F.autohuifuF:SetBackdropBorderColor(0, 1, 1, 0.8);
	fuFrame.F.autohuifuF:SetSize(fuFrame.F:GetWidth()-8,EditBox_H*3+20);
	fuFrame.F.autohuifuF:SetPoint("TOPLEFT", fuFrame.F, "TOPLEFT", 4,-206);
	----
	fuFrame.F.guanjiazi = fuFrame.F:CreateFontString();
	fuFrame.F.guanjiazi:SetPoint("TOPLEFT",fuFrame.F.autohuifuF,"TOPLEFT",13,-10);
	fuFrame.F.guanjiazi:SetFontObject(GameFontNormal);
	fuFrame.F.guanjiazi:SetText("\124cff00ff00触发回复关键字(用,分隔):\124r");
	fuFrame.F.guanjiaziFFF = CreateFrame("Frame", nil, fuFrame.F,"BackdropTemplate");
	fuFrame.F.guanjiaziFFF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 12});
	fuFrame.F.guanjiaziFFF:SetBackdropBorderColor(1, 1, 0, 0.6);
	fuFrame.F.guanjiaziFFF:SetSize(299,EditBox_H);
	fuFrame.F.guanjiaziFFF:SetPoint("LEFT", fuFrame.F.guanjiazi, "RIGHT", 10,0);
	fuFrame.F.guanjiazi_E = CreateFrame('EditBox', nil, fuFrame.F.guanjiaziFFF,"BackdropTemplate");
	fuFrame.F.guanjiazi_E:SetPoint("TOPLEFT", fuFrame.F.guanjiaziFFF, "TOPLEFT", 6,-0);
	fuFrame.F.guanjiazi_E:SetPoint("BOTTOMRIGHT", fuFrame.F.guanjiaziFFF, "BOTTOMRIGHT", -6,-0);
	fuFrame.F.guanjiazi_E:SetFontObject(ChatFontNormal);
	fuFrame.F.guanjiazi_E:SetAutoFocus(false);
	fuFrame.F.guanjiazi_E:SetMaxLetters(100);
	fuFrame.F.guanjiazi_E:SetTextColor(1, 1, 1, 0.7);
	fuFrame.F.guanjiazi_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.F.guanjiazi_E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	local function fengeguanjianzi(str,delimiter)
	    local dLen = string.len(delimiter)
	    local newDeli = ''
	    for i=1,dLen,1 do
	        newDeli = newDeli .. "["..delimiter:sub(i,i).."]"
	    end

	    local locaStart,locaEnd = str:find(newDeli)
	    local arr = {}
	    local n = 1
	    while locaStart ~= nil
	    do
	        if locaStart>0 then
	            arr[n] = str:sub(1,locaStart-1)
	            n = n + 1
	        end

	        str = str:sub(locaEnd+1,string.len(str))
	        locaStart,locaEnd = str:find(newDeli)
	    end
	    if str ~= nil and str ~= "" and str ~= " " then
	        arr[n] = str
	    end
	    return arr
	end    
	fuFrame.F.guanjiazi_E:SetScript("OnEditFocusGained", function(self)
		self:SetTextColor(1, 1, 1, 1);
	end);
	fuFrame.F.guanjiazi_E:SetScript("OnEditFocusLost", function(self)
		local guanjianV = self:GetText();
		local guanjianshuzu = guanjianV:gsub("，", ",")
		local guanjianzilist = fengeguanjianzi(guanjianshuzu, ",")
		PIG_Per.daiben.autohuifu_key=guanjianzilist;
		self:SetTextColor(1, 1, 1, 0.7);
	end);
	--自动回复内容
	fuFrame.F.huifuqNR = fuFrame.F:CreateFontString();
	fuFrame.F.huifuqNR:SetPoint("TOPLEFT",fuFrame.F.autohuifuF,"TOPLEFT",10,-40);
	fuFrame.F.huifuqNR:SetFontObject(GameFontNormal);
	fuFrame.F.huifuqNR:SetText("\124cff00ff00自动回复内容:\124r");
	fuFrame.F.huifuqNRFFF = CreateFrame("Frame", nil, fuFrame.F,"BackdropTemplate");
	fuFrame.F.huifuqNRFFF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 12});
	fuFrame.F.huifuqNRFFF:SetBackdropBorderColor(1, 1, 0, 0.6);
	fuFrame.F.huifuqNRFFF:SetSize(380,EditBox_H);
	fuFrame.F.huifuqNRFFF:SetPoint("LEFT", fuFrame.F.huifuqNR, "RIGHT", 10,0);
	fuFrame.F.autohuifu_NR = CreateFrame('EditBox', nil, fuFrame.F.huifuqNRFFF,"BackdropTemplate");
	fuFrame.F.autohuifu_NR:SetPoint("TOPLEFT", fuFrame.F.huifuqNRFFF, "TOPLEFT", 8,0);
	fuFrame.F.autohuifu_NR:SetPoint("BOTTOMRIGHT", fuFrame.F.huifuqNRFFF, "BOTTOMRIGHT", -8,0);
	fuFrame.F.autohuifu_NR:SetFontObject(ChatFontNormal);
	fuFrame.F.autohuifu_NR:SetAutoFocus(false);
	fuFrame.F.autohuifu_NR:SetMaxLetters(26);
	fuFrame.F.autohuifu_NR:SetTextColor(1, 1, 1, 0.7);
	fuFrame.F.autohuifu_NR:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.F.autohuifu_NR:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.F.autohuifu_NR:SetScript("OnEditFocusGained", function(self)
		self:SetTextColor(1, 1, 1, 1);
	end);
	fuFrame.F.autohuifu_NR:SetScript("OnEditFocusLost", function(self)
		PIG_Per.daiben.autohuifu_NR=self:GetText();
		self:SetTextColor(1, 1, 1, 0.7);
	end);
	--
	fuFrame.F.autohuifu_danjia= ADD_Checkbutton(nil,fuFrame.F,-60,"TOPLEFT",fuFrame.F.autohuifuF,"TOPLEFT",10,-66,"回复单价","开启自动回复时回复内容附加等级要求和单价(也会在车队显示，为了方便老板询价，建议开启)")
	fuFrame.F.autohuifu_danjia:SetSize(28,28);
	fuFrame.F.autohuifu_danjia:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.autohuifu_danjia=true
		else
			PIG_Per.daiben.autohuifu_danjia=false
		end
	end);
	----
	fuFrame.F.autohuifu_lv= ADD_Checkbutton(nil,fuFrame.F,-80,"LEFT",fuFrame.F.autohuifu_danjia,"RIGHT",80,0,"回复队伍等级","开启自动回复时回复内容附加现有队伍玩家等级")
	fuFrame.F.autohuifu_lv:SetSize(28,28);
	fuFrame.F.autohuifu_lv:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.autohuifu_lv=true
		else
			PIG_Per.daiben.autohuifu_lv=false
		end
	end);
	---
	fuFrame.F.autohuifu_inv= ADD_Checkbutton(nil,fuFrame.F,-80,"LEFT",fuFrame.F.autohuifu_lv,"RIGHT",110,0,"回复邀请指令","开启自动回复时回复内容附加邀请指令，玩家回复邀请指令将会自动邀请玩家进组（也会自动同意玩家在车队的上车申请）")
	fuFrame.F.autohuifu_inv:SetSize(28,28);
	fuFrame.F.autohuifu_inv:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.autohuifu_inv=true
		else
			PIG_Per.daiben.autohuifu_inv=false
		end
	end);
	----
	fuFrame.F.autohuifu_invCMD = CreateFrame('EditBox', nil, fuFrame.F,"InputBoxInstructionsTemplate");
	fuFrame.F.autohuifu_invCMD:SetSize(60,EditBox_H);
	fuFrame.F.autohuifu_invCMD:SetPoint("LEFT", fuFrame.F.autohuifu_inv.Text, "RIGHT", 10,0);
	fuFrame.F.autohuifu_invCMD:SetFontObject(ChatFontNormal);
	fuFrame.F.autohuifu_invCMD:SetAutoFocus(false);
	fuFrame.F.autohuifu_invCMD:SetMaxLetters(10)
	fuFrame.F.autohuifu_invCMD:SetTextColor(1, 1, 1, 0.7);
	fuFrame.F.autohuifu_invCMD:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.F.autohuifu_invCMD:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.F.autohuifu_invCMD:SetScript("OnEditFocusGained", function(self)
		self:SetTextColor(1, 1, 1, 1);
	end);
	fuFrame.F.autohuifu_invCMD:SetScript("OnEditFocusLost", function(self)
		PIG_Per.daiben.autohuifu_invCMD=self:GetText();
		self:SetTextColor(1, 1, 1, 0.7);
	end);
	--绑定计时于记账窗口
	fuFrame.F.bangdingUI= ADD_Checkbutton(nil,fuFrame.F,-80,"BOTTOMLEFT",fuFrame.F,"BOTTOMLEFT",10,2,"计时窗口跟随记账窗口打开","计时窗口跟随记账窗口打开或关闭")
	fuFrame.F.bangdingUI:SetSize(28,28);
	fuFrame.F.bangdingUI:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.bangdingUI=true
			daiben_UI.Time:Hide()
		else
			PIG_Per.daiben.bangdingUI=false
			daiben_UI.Time:Show()
		end
	end);
	----==============================================-
	---重置带本助手配置
	fuFrame.F.chongzhizhushou = fuFrame.F:CreateFontString();
	fuFrame.F.chongzhizhushou:SetPoint("BOTTOMRIGHT",fuFrame.F,"BOTTOMRIGHT",-70,6);
	fuFrame.F.chongzhizhushou:SetFontObject(GameFontNormal);
	fuFrame.F.chongzhizhushou:SetText("\124cffFFff00有问题点:\124r");
	fuFrame.F.chongzhizhushouBUT = CreateFrame("Button",nil,fuFrame.F, "UIPanelButtonTemplate");  
	fuFrame.F.chongzhizhushouBUT:SetSize(50,20);
	fuFrame.F.chongzhizhushouBUT:SetPoint("LEFT",fuFrame.F.chongzhizhushou,"RIGHT",2,0);
	fuFrame.F.chongzhizhushouBUT:SetText("重置");
	fuFrame.F.chongzhizhushouBUT:SetScript("OnClick", function ()
		StaticPopup_Show ("HUIFU_DEFAULT_DAIBEN_XX");
	end);
	StaticPopupDialogs["HUIFU_DEFAULT_DAIBEN_XX"] = {
		text = "此操作将\124cffff0000重置\124r带本助手所有配置，并清空所有已保存数据，需重载界面。\n确定重置?",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG_Per.daiben = addonTable.Default_Per.daiben;
			PIG_Per.daiben.Open = true;
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	fuFrame.F:HookScript("OnShow", function(self)
		local old_fbName=PIG_Per["daiben"]["fubenName"];
		if old_fbName~="无" then
			fuFrame.F.danjiaF.XG:Show()
			fuFrame.F.danjiaF.XG:SetText("编辑")
			gengxinDanjiaV(old_fbName)
		end
		EditBoxBG_Hide()
		if PIG_Per["daiben"]["CZ_timejisha"] then
			fuFrame.F.CZ_timejisha:SetChecked(true);
		end
		if PIG_Per["daiben"]["CZ_expSw"] then
			fuFrame.F.CZ_expSw:SetChecked(true);
		end
		if PIG_Per["daiben"]["CZ_yueyuci"] then
			fuFrame.F.CZ_yueyuci:SetChecked(true);
		end
		if PIG_Per["daiben"]["CZ_jiuwei"] then
			fuFrame.F.CZ_jiuwei:SetChecked(true);
		end
		if PIG_Per["daiben"]["SDdanjia"] then
			fuFrame.F.SDdanjia:SetChecked(true);
		end
		if PIG_Per["daiben"]["CBbukouG"] then
			fuFrame.F.CBbukouG:SetChecked(true);
		end
		if PIG_Per["daiben"]["HideYue"] then
			fuFrame.F.HideYue:SetChecked(true);
		end
		if PIG_Per["daiben"]["autohuifu_danjia"] then
			fuFrame.F.autohuifu_danjia:SetChecked(true);
		end
		if PIG_Per["daiben"]["autohuifu_lv"] then
			fuFrame.F.autohuifu_lv:SetChecked(true);
		end
		if PIG_Per["daiben"]["autohuifu_inv"] then
			fuFrame.F.autohuifu_inv:SetChecked(true);
		end
		if PIG_Per["daiben"]["bangdingUI"] then
			fuFrame.F.bangdingUI:SetChecked(true);
		end
		if PIG_Per["daiben"]["shoudongMOD"] then
			fuFrame.F.shoudongMOD:SetChecked(true);
		end
		fuFrame.F.autohuifu_NR:SetText(PIG_Per["daiben"]["autohuifu_NR"])
		fuFrame.F.autohuifu_invCMD:SetText(PIG_Per["daiben"]["autohuifu_invCMD"])

		fuFrame.F.guanjianzineirong="";
		for i=1,#PIG_Per["daiben"]["autohuifu_key"] do
			if i~=#PIG_Per["daiben"]["autohuifu_key"] then
				fuFrame.F.guanjianzineirong=fuFrame.F.guanjianzineirong..PIG_Per["daiben"]["autohuifu_key"][i].."，"
			else
				fuFrame.F.guanjianzineirong=fuFrame.F.guanjianzineirong..PIG_Per["daiben"]["autohuifu_key"][i]
			end
		end
		fuFrame.F.guanjiazi_E:SetText(fuFrame.F.guanjianzineirong)
	end);
end
addonTable.ADD_settingUI=ADD_settingUI