local _, addonTable = ...;
local gsub = _G.string.gsub
local find = _G.string.find
local ADD_Frame=addonTable.ADD_Frame
--============带本助手-设置====================
local daibenData=addonTable.daibenData
local Width,DHeight,biaotiH= daibenData.Width,daibenData.DHeight,daibenData.biaotiH
local WowWidth= daibenData.WowWidth
local WowHeight= daibenData.WowHeight
--目的地
daibenData.mudidiList = {};
local englishFaction, _ = UnitFactionGroup("player")
if englishFaction=="Alliance" then
	daibenData.mudidiList = {"无","死亡矿井","监狱","血色修道院","祖尔法拉克","玛拉顿","斯坦索姆","黑石塔","地狱火城墙","奴隶围栏","破碎大厅","蒸汽地窟","暗影迷宫","生态船","魔导师平台",};
elseif englishFaction=="Horde" then
	daibenData.mudidiList = {"无","怒焰裂谷","影牙城堡","血色修道院","祖尔法拉克","玛拉顿","斯坦索姆","黑石塔","地狱火城墙","奴隶围栏","破碎大厅","蒸汽地窟","暗影迷宫","生态船","魔导师平台",};
end
---------
local LV_danjia = {
	["无"]={{0,0,0},{0,0,0},{0,0,0},{0,0,0}},
	["怒焰裂谷"]={{8,16,5},{0,0,0},{0,0,0},{0,0,0}},
	["死亡矿井"]={{10,20,10},{0,0,0},{0,0,0},{0,0,0}},
	["影牙城堡"]={{14,21,10},{0,0,0},{0,0,0},{0,0,0}},
	["监狱"]={{15,25,5},{0,0,0},{0,0,0},{0,0,0}},
	["血色修道院"]={{20,40,20},{0,0,0},{0,0,0},{0,0,0}},
	["祖尔法拉克"]={{35,48,30},{0,0,0},{0,0,0},{0,0,0}},
	["玛拉顿"]={{30,48,30},{0,0,0},{0,0,0},{0,0,0}},
	["斯坦索姆"]={{45,60,30},{0,0,0},{0,0,0},{0,0,0}},
	["黑石塔"]={{45,60,30},{0,0,0},{0,0,0},{0,0,0}},
	["地狱火城墙"]={{58,65,40},{0,0,0},{0,0,0},{0,0,0}},
	["奴隶围栏"]={{60,65,40},{0,0,0},{0,0,0},{0,0,0}},
	["破碎大厅"]={{65,70,40},{0,0,0},{0,0,0},{0,0,0}},
	["蒸汽地窟"]={{65,70,40},{0,0,0},{0,0,0},{0,0,0}},
	["暗影迷宫"]={{65,70,40},{0,0,0},{0,0,0},{0,0,0}},
	["生态船"]={{65,70,40},{0,0,0},{0,0,0},{0,0,0}},
	["魔导师平台"]={{65,70,40},{0,0,0},{0,0,0},{0,0,0}},
}
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
	fuFrame.F=ADD_Frame("Daiben_shezhi_F_UI",fuFrame,520, 334,"CENTER",UIParent,"CENTER",0,0,true,true,true,true,true)
	fuFrame.F:SetBackdrop({
		bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
		tile = true, tileSize = 0, edgeSize = 6});
	fuFrame.F:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
	
	fuFrame.F.Close = CreateFrame("Button",nil,fuFrame.F, "UIPanelCloseButton");  
	fuFrame.F.Close:SetSize(28,28);
	fuFrame.F.Close:SetPoint("TOPRIGHT",fuFrame.F,"TOPRIGHT",3,3);

	fuFrame.F.mudidiT = fuFrame.F:CreateFontString();
	fuFrame.F.mudidiT:SetPoint("TOPLEFT",fuFrame.F,"TOPLEFT",6,-7);
	fuFrame.F.mudidiT:SetFontObject(GameFontNormal);
	fuFrame.F.mudidiT:SetText("选择副本:");
	fuFrame.F.mudidi = CreateFrame("FRAME", nil, fuFrame.F, "UIDropDownMenuTemplate")
	fuFrame.F.mudidi:SetPoint("LEFT",fuFrame.F.mudidiT,"RIGHT",-14,-2)
	fuFrame.F.mudidi.Left:Hide();
	fuFrame.F.mudidi.Middle:Hide();
	fuFrame.F.mudidi.Right:Hide();
	UIDropDownMenu_SetWidth(fuFrame.F.mudidi, 110)
	local function chushihuaxiala(self)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		for i=1,#daibenData.mudidiList,1 do
		    info.text, info.arg1, info.checked = daibenData.mudidiList[i], daibenData.mudidiList[i], daibenData.mudidiList[i] == PIG_Per["daiben"]["fubenName"];
			UIDropDownMenu_AddButton(info)
		end 
	end
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
		PIG_Per.daiben.LV_danjia[fbName]=PIG_Per.daiben.LV_danjia[fbName] or LV_danjia[fbName]
		local jiageinfo = PIG_Per.daiben.LV_danjia[fbName]
		for id = 1, 4, 1 do
			local ff = _G["Danjialist_"..id]
			ff.V1:SetText("");
			ff.V2:SetText("");
			ff.G:SetText("");
			local kaishi,jieshu,danjia=jiageinfo[id][1],jiageinfo[id][2],jiageinfo[id][3]
			if kaishi>0 then
				ff.V1:SetText(kaishi);
				ff.V2:SetText(jieshu);
				if danjia>0 then
					ff.G:SetText(danjia);
				else
					ff.G:SetText("免费");
				end
			end
		end
	end
	local Update_jizhangData=addonTable.Update_jizhangData
	function fuFrame.F.mudidi:SetValue(NewfbName)
		UIDropDownMenu_SetText(fuFrame.F.mudidi, NewfbName)
		PIG_Per.daiben.fubenName= NewfbName;
		if NewfbName=="无" then
			fuFrame.F.danjiaF.XG:Hide();
			PIG_Per.daiben.autohuifu=false
			daiben_UI.yesno.Tex:SetTexture("interface/common/indicator-red.blp");
			daiben_UI.yesno:SetChecked(false)
		else
			fuFrame.F.danjiaF.XG:Show();
		end
		gengxinDanjiaV(NewfbName)
		Update_jizhangData(true)
		CloseDropDownMenus()
	end
	--单价设置
	fuFrame.F.danjiaF = CreateFrame("Frame", nil, fuFrame.F,"BackdropTemplate");
	fuFrame.F.danjiaF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 10,});
	fuFrame.F.danjiaF:SetBackdropBorderColor(0, 1, 1, 0.8);
	fuFrame.F.danjiaF:SetSize(fuFrame.F:GetWidth()/2+10,126);
	fuFrame.F.danjiaF:SetPoint("TOPLEFT", fuFrame.F, "TOPLEFT", 4,-30);
	--错误提示
	local danjiaSZW = fuFrame.F.danjiaF:GetWidth()
	fuFrame.F.danjiaF.error = CreateFrame("Frame", nil, fuFrame.F.danjiaF,"BackdropTemplate");
	fuFrame.F.danjiaF.error:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 0, edgeSize = 10,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	fuFrame.F.danjiaF.error:SetSize(danjiaSZW-10,80);
	fuFrame.F.danjiaF.error:SetPoint("TOP",fuFrame.F.danjiaF,"TOP",0,-8);
	fuFrame.F.danjiaF.error:SetFrameStrata("HIGH")
	fuFrame.F.danjiaF.error:Hide();
	fuFrame.F.danjiaF.error.T = fuFrame.F.danjiaF.error:CreateFontString();
	fuFrame.F.danjiaF.error.T:SetPoint("TOP",fuFrame.F.danjiaF.error,"TOP",0,-14);
	fuFrame.F.danjiaF.error.T:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.F.danjiaF.error.Close = CreateFrame("Button",nil,fuFrame.F.danjiaF.error, "UIPanelButtonTemplate");  
	fuFrame.F.danjiaF.error.Close:SetSize(80,20);
	fuFrame.F.danjiaF.error.Close:SetPoint("TOP",fuFrame.F.danjiaF.error,"TOP",0,-46);
	fuFrame.F.danjiaF.error.Close:SetText("去修改");
	fuFrame.F.danjiaF.error.Close:SetScript("OnClick", function (self)
		fuFrame.F.danjiaF.error:Hide()
	end)
	fuFrame.F.danjiaF.XG = CreateFrame("Button",nil,fuFrame.F.danjiaF, "UIPanelButtonTemplate");  
	fuFrame.F.danjiaF.XG:SetSize(60,20);
	fuFrame.F.danjiaF.XG:SetPoint("LEFT",fuFrame.F.mudidi,"RIGHT",-7,2);
	fuFrame.F.danjiaF.XG:SetText("修改");
	fuFrame.F.danjiaF.XG:Hide();
	fuFrame.F.danjiaF.XG:SetScript("OnClick", function (self)
		if self:GetText()=="修改" then
			self:SetText("保存");
			EditBoxBG_Show()
		elseif self:GetText()=="保存" then
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
						end
						if kasihi_pl>0 then
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
			self:SetText("修改");
			Update_jizhangData(true)
		end
	end);
	-----------
	for id = 1, 4, 1 do
		local Danjialist = CreateFrame("Frame", "Danjialist_"..id, fuFrame.F.danjiaF);
		Danjialist:SetSize(danjiaSZW-10,30);
		if id==1 then
			Danjialist:SetPoint("TOP", fuFrame.F.danjiaF, "TOP", 0,-2);
		else
			Danjialist:SetPoint("TOP", _G["Danjialist_"..(id-1)], "BOTTOM", 0,0);
		end
		Danjialist.listID = Danjialist:CreateFontString();
		Danjialist.listID:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		Danjialist.listID:SetPoint("LEFT", Danjialist, "LEFT", 0,0);
		Danjialist.listID:SetText(id.."、");
		Danjialist.listID:SetTextColor(0, 0.8, 0.8, 1);

		Danjialist.V1 = CreateFrame('EditBox', nil, Danjialist,"InputBoxInstructionsTemplate");
		Danjialist.V1:SetSize(30,30);
		Danjialist.V1:SetPoint("LEFT", Danjialist.listID, "RIGHT", 3,0);
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
		Danjialist.V2:SetSize(30,30);
		Danjialist.V2:SetPoint("LEFT", Danjialist.t1, "RIGHT", 6,0);
		Danjialist.V2:SetFontObject(ChatFontNormal);
		Danjialist.V2:SetAutoFocus(false);
		Danjialist.V2:SetNumeric(true)
		Danjialist.V2:SetMaxLetters(2)
		Danjialist.V2:SetJustifyH("CENTER");

		Danjialist.t2 = Danjialist:CreateFontString();
		Danjialist.t2:SetPoint("LEFT",Danjialist.V2,"RIGHT",2,0);
		Danjialist.t2:SetFont(ChatFontNormal:GetFont(), 13);
		Danjialist.t2:SetText("级，单价:");
		Danjialist.t2:SetTextColor(0.8, 0.8, 0.8, 1);

		Danjialist.G = CreateFrame('EditBox', nil, Danjialist,"InputBoxInstructionsTemplate");
		Danjialist.G:SetSize(40,30);
		Danjialist.G:SetPoint("LEFT", Danjialist.t2, "RIGHT", 5,0);
		Danjialist.G:SetFontObject(ChatFontNormal);
		Danjialist.G:SetAutoFocus(false);
		Danjialist.G:SetNumeric(true)
		Danjialist.G:SetMaxLetters(4)
		Danjialist.G:SetJustifyH("CENTER");

		Danjialist.Gt = Danjialist:CreateFontString();
		Danjialist.Gt:SetPoint("LEFT",Danjialist.G,"RIGHT",2,0);
		Danjialist.Gt:SetFont(ChatFontNormal:GetFont(), 13);
		Danjialist.Gt:SetText("G/次");
		Danjialist.Gt:SetTextColor(0.8, 0.8, 0.8, 1);
	end
	local leftPY,Ckjiange = 280,32
	--播报耗时/击杀数
	fuFrame.F.CZ_timejisha = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.CZ_timejisha:SetSize(30,30);
	fuFrame.F.CZ_timejisha:SetPoint("TOPLEFT",fuFrame.F,"TOPLEFT",leftPY,-Ckjiange+2);
	fuFrame.F.CZ_timejisha:SetHitRectInsets(0,-40,0,0);
	fuFrame.F.CZ_timejisha.Text:SetText("重置播报耗时/击杀数");
	fuFrame.F.CZ_timejisha.tooltip = "重置播报上次刷本耗时/击杀数(非队长不生效)";
	fuFrame.F.CZ_timejisha:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.CZ_timejisha=true
		else
			PIG_Per.daiben.CZ_timejisha=false
		end
	end)
	fuFrame.F.CZ_yueyuci = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.CZ_yueyuci:SetSize(30,30);
	fuFrame.F.CZ_yueyuci:SetPoint("TOPLEFT",fuFrame.F,"TOPLEFT",leftPY,-Ckjiange*2);
	fuFrame.F.CZ_yueyuci:SetHitRectInsets(0,-40,0,0);
	fuFrame.F.CZ_yueyuci.Text:SetText("重置播报玩家余额/余次");
	fuFrame.F.CZ_yueyuci.tooltip = "重置播报队伍内玩家余额/余次(非队长不生效)。";
	fuFrame.F.CZ_yueyuci:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.CZ_yueyuci=true
		else
			PIG_Per.daiben.CZ_yueyuci=false
		end
	end);
	fuFrame.F.CZ_expSw = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.CZ_expSw:SetSize(30,30);
	fuFrame.F.CZ_expSw:SetPoint("TOPLEFT",fuFrame.F,"TOPLEFT",leftPY,-Ckjiange*3);
	fuFrame.F.CZ_expSw:SetHitRectInsets(0,-40,0,0);
	fuFrame.F.CZ_expSw.Text:SetText("重置播报自身经验/声望");
	fuFrame.F.CZ_expSw.tooltip = "重置播报上次自身刷本获得的经验/声望";
	fuFrame.F.CZ_expSw:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.CZ_expSw=true
		else
			PIG_Per.daiben.CZ_expSw=false
		end
	end);
	--重置时就位确认
	fuFrame.F.CZ_jiuwei = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.CZ_jiuwei:SetSize(30,30);
	fuFrame.F.CZ_jiuwei:SetPoint("TOPLEFT",fuFrame.F,"TOPLEFT",leftPY,-Ckjiange*4);
	fuFrame.F.CZ_jiuwei:SetHitRectInsets(0,-40,0,0);
	fuFrame.F.CZ_jiuwei.Text:SetText("重置时就位确认");
	fuFrame.F.CZ_jiuwei.tooltip = "重置时就位确认(非队长不生效)";
	fuFrame.F.CZ_jiuwei:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.CZ_jiuwei=true
		else
			PIG_Per.daiben.CZ_jiuwei=false
		end
	end);
	--有余额时锁定单价
	fuFrame.F.SDdanjia = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.SDdanjia:SetSize(30,30);
	fuFrame.F.SDdanjia:SetPoint("TOPLEFT",fuFrame.F,"TOPLEFT",10,-160);
	fuFrame.F.SDdanjia:SetHitRectInsets(0,-40,0,0);
	fuFrame.F.SDdanjia.Text:SetText("有余额时锁定单价");
	fuFrame.F.SDdanjia.tooltip = "启用后，当玩家有余额时升级将不会更新单价，右击单价数字可手动刷新。";
	fuFrame.F.SDdanjia:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.SDdanjia=true
		else
			PIG_Per.daiben.SDdanjia=false
		end
	end);
	--
	fuFrame.F.CBbukouG = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.CBbukouG:SetSize(30,30);
	fuFrame.F.CBbukouG:SetPoint("LEFT",fuFrame.F.SDdanjia,"RIGHT",140,0);
	fuFrame.F.CBbukouG:SetHitRectInsets(0,-40,0,0);
	fuFrame.F.CBbukouG.Text:SetText("已击杀进组不扣款");
	fuFrame.F.CBbukouG.tooltip = "启用后，玩家在进组时，你在副本内且本次已击杀怪物则重置时此玩家本次不扣款。";
	fuFrame.F.CBbukouG:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.CBbukouG=true
		else
			PIG_Per.daiben.CBbukouG=false
		end
	end);
	--
	fuFrame.F.HideYue = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.HideYue:SetSize(30,30);
	fuFrame.F.HideYue:SetPoint("LEFT",fuFrame.F.CBbukouG,"RIGHT",160,0);
	fuFrame.F.HideYue:SetHitRectInsets(0,-40,0,0);
	fuFrame.F.HideYue.Text:SetText("播报隐藏余额");
	fuFrame.F.HideYue.tooltip = "启用后，重置播报余额/余次功能将不会播余额。";
	fuFrame.F.HideYue:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.HideYue=true
		else
			PIG_Per.daiben.HideYue=false
		end
	end);
	---自动回复
	local EditBox_H=26
	fuFrame.F.autohuifuF = CreateFrame("Frame", nil, fuFrame.F,"BackdropTemplate");
	fuFrame.F.autohuifuF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 10,});
	fuFrame.F.autohuifuF:SetBackdropBorderColor(0, 1, 1, 0.8);
	fuFrame.F.autohuifuF:SetSize(fuFrame.F:GetWidth()-8,EditBox_H*3+20);
	fuFrame.F.autohuifuF:SetPoint("TOPLEFT", fuFrame.F, "TOPLEFT", 4,-194);
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
	fuFrame.F.autohuifu_danjia = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.autohuifu_danjia:SetSize(28,28);
	fuFrame.F.autohuifu_danjia:SetPoint("TOPLEFT",fuFrame.F.autohuifuF,"TOPLEFT",10,-66);
	fuFrame.F.autohuifu_danjia:SetHitRectInsets(0,-40,0,0);
	fuFrame.F.autohuifu_danjia.Text:SetText("回复单价");
	fuFrame.F.autohuifu_danjia.tooltip = "开启自动回复时回复内容附加等级要求和单价(也会在车队显示，为了方便老板询价，建议开启)";
	fuFrame.F.autohuifu_danjia:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.autohuifu_danjia=true
		else
			PIG_Per.daiben.autohuifu_danjia=false
		end
	end);
	----
	fuFrame.F.autohuifu_lv = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.autohuifu_lv:SetSize(28,28);
	fuFrame.F.autohuifu_lv:SetPoint("LEFT",fuFrame.F.autohuifu_danjia,"RIGHT",80,0);
	fuFrame.F.autohuifu_lv:SetHitRectInsets(0,-40,0,0);
	fuFrame.F.autohuifu_lv.Text:SetText("回复队伍等级");
	fuFrame.F.autohuifu_lv.tooltip = "开启自动回复时回复内容附加现有队伍玩家等级。";
	fuFrame.F.autohuifu_lv:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.autohuifu_lv=true
		else
			PIG_Per.daiben.autohuifu_lv=false
		end
	end);
	---
	fuFrame.F.autohuifu_inv = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.autohuifu_inv:SetSize(30,30);
	fuFrame.F.autohuifu_inv:SetPoint("LEFT",fuFrame.F.autohuifu_lv,"RIGHT",110,0);
	fuFrame.F.autohuifu_inv:SetHitRectInsets(0,-60,0,0);
	fuFrame.F.autohuifu_inv.Text:SetText("回复邀请指令");
	fuFrame.F.autohuifu_inv.tooltip = "开启自动回复时回复内容附加邀请指令，玩家回复邀请指令将会自动邀请玩家进组（也会自动同意玩家在车队的上车申请）";
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
	fuFrame.F.bangdingUI = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.bangdingUI:SetSize(30,30);
	fuFrame.F.bangdingUI:SetPoint("TOPLEFT",fuFrame.F,"TOPLEFT",10,-300);
	fuFrame.F.bangdingUI:SetHitRectInsets(0,-60,0,0);
	fuFrame.F.bangdingUI.Text:SetText("计时窗口跟随记账窗口打开");
	fuFrame.F.bangdingUI.tooltip = "计时窗口跟随记账窗口打开或关闭";
	fuFrame.F.bangdingUI:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.bangdingUI=true
			daiben_UI.Time:Hide()
		else
			PIG_Per.daiben.bangdingUI=false
			daiben_UI.Time:Show()
		end
	end);
	--H围栏模式
	fuFrame.F.shoudongMOD = CreateFrame("CheckButton", nil, fuFrame.F, "ChatConfigCheckButtonTemplate");
	fuFrame.F.shoudongMOD:SetSize(30,30);
	fuFrame.F.shoudongMOD:SetPoint("LEFT",fuFrame.F.bangdingUI,"RIGHT",210,0);
	fuFrame.F.shoudongMOD:SetHitRectInsets(0,-60,0,0);
	fuFrame.F.shoudongMOD.Text:SetText("英雄模式");
	fuFrame.F.shoudongMOD.tooltip = "因需要下线重置，所以需要手动扣款，英雄模式开启后手动扣款<全队->时也会播报队内玩家余次/余额，并自动结束本次刷本记录\n|cff00FF00此模式下插件不在自行判断副本CD，手动扣款后进入副本默认为新CD|r";
	fuFrame.F.shoudongMOD:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per.daiben.shoudongMOD=true
		else
			PIG_Per.daiben.shoudongMOD=false
		end
	end);
	----==============================================-
	---重置带本助手配置
	fuFrame.F.chongzhizhushou = fuFrame.F:CreateFontString();
	fuFrame.F.chongzhizhushou:SetPoint("TOPRIGHT",fuFrame.F,"TOPRIGHT",-60,-306);
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
		local cpset = PIG_Per.daiben
		UIDropDownMenu_Initialize(fuFrame.F.mudidi, chushihuaxiala)
		local old_fbName=cpset.fubenName;
		UIDropDownMenu_SetText(fuFrame.F.mudidi, old_fbName)
		if old_fbName~="无" then
			fuFrame.F.danjiaF.XG:Show()
			fuFrame.F.danjiaF.XG:SetText("修改")
			gengxinDanjiaV(old_fbName)
		end
		EditBoxBG_Hide()
		if cpset.CZ_timejisha then
			fuFrame.F.CZ_timejisha:SetChecked(true);
		end
		if cpset.CZ_expSw then
			fuFrame.F.CZ_expSw:SetChecked(true);
		end
		if cpset.CZ_yueyuci then
			fuFrame.F.CZ_yueyuci:SetChecked(true);
		end
		if cpset.CZ_jiuwei then
			fuFrame.F.CZ_jiuwei:SetChecked(true);
		end
		if cpset.SDdanjia then
			fuFrame.F.SDdanjia:SetChecked(true);
		end
		if cpset.CBbukouG then
			fuFrame.F.CBbukouG:SetChecked(true);
		end
		if cpset.HideYue then
			fuFrame.F.HideYue:SetChecked(true);
		end
		if cpset.autohuifu_danjia then
			fuFrame.F.autohuifu_danjia:SetChecked(true);
		end
		if cpset.autohuifu_lv then
			fuFrame.F.autohuifu_lv:SetChecked(true);
		end
		if cpset.autohuifu_inv then
			fuFrame.F.autohuifu_inv:SetChecked(true);
		end
		if cpset.bangdingUI then
			fuFrame.F.bangdingUI:SetChecked(true);
		end
		if PIG_Per.daiben.shoudongMOD then
			fuFrame.F.shoudongMOD:SetChecked(true);
		end
		fuFrame.F.autohuifu_NR:SetText(cpset.autohuifu_NR)
		fuFrame.F.autohuifu_invCMD:SetText(cpset.autohuifu_invCMD)

		fuFrame.F.guanjianzineirong="";
		for i=1,#cpset.autohuifu_key do
			if i~=#cpset.autohuifu_key then
				fuFrame.F.guanjianzineirong=fuFrame.F.guanjianzineirong..cpset.autohuifu_key[i].."，"
			else
				fuFrame.F.guanjianzineirong=fuFrame.F.guanjianzineirong..cpset.autohuifu_key[i]
			end
		end
		fuFrame.F.guanjiazi_E:SetText(fuFrame.F.guanjianzineirong)
	end);
end
addonTable.ADD_settingUI=ADD_settingUI
--获取队伍等级
local function huoquduiwLV(MsgNr)
	if IsInGroup() then
		local numgroup = GetNumSubgroupMembers()
		if numgroup>0 then
			MsgNr=MsgNr.."队伍LV(";
			for id=1,numgroup do
				local dengjiKk = UnitLevel("Party"..id);
				if id==numgroup then
					MsgNr=MsgNr..dengjiKk;
				else
					MsgNr=MsgNr..dengjiKk..",";
				end
			end
			MsgNr=MsgNr.."),";
		end
	end
	return MsgNr
end
addonTable.huoquduiwLV=huoquduiwLV
--获取所带副本级别单价
local function huoquLVdanjia(MsgNr)
	local MsgNr = MsgNr or ""
	local fbName=PIG_Per.daiben.fubenName
	local danjiaList=PIG_Per.daiben.LV_danjia[fbName]
	for id = 1, 4, 1 do
		local kaishiLV =danjiaList[id][1]
		local jieshuLV =danjiaList[id][2]
		local jiageG =danjiaList[id][3]
		if kaishiLV>0 and jieshuLV>0 then
			if jiageG>0 then
				MsgNr=MsgNr.."<"..kaishiLV.."-"..jieshuLV..">"..jiageG.."G;"
			else
				MsgNr=MsgNr.."<"..kaishiLV.."-"..jieshuLV..">".."免费;"
			end
		end
	end
	return MsgNr
end
addonTable.huoquLVdanjia=huoquLVdanjia
--获取级别范围
local function huoquLVminmax()
	local min,max = nil,nil
	local fbName=PIG_Per.daiben.fubenName
	local danjiaList=PIG_Per.daiben.LV_danjia[fbName]
	for id = 1, 4, 1 do
		local kaishiLV =danjiaList[id][1]
		local jieshuLV =danjiaList[id][2]
		if kaishiLV>0 and jieshuLV>0 then
			if min then
				if kaishiLV<min then
					min=kaishiLV
				end
			else
				min=kaishiLV
			end
			if max then
				if jieshuLV>max then
					max=jieshuLV
				end
			else
				max=jieshuLV
			end
		end
	end
	local min,max = min or 0,max or 0
	return min,max
end
addonTable.huoquLVminmax=huoquLVminmax
--根据等级计算单价
local function jisuandanjia(lv)
	local fbName=PIG_Per.daiben.fubenName
	if fbName=="无" then
		return 0
	else
		local danjiaList=PIG_Per.daiben.LV_danjia[fbName]
		for id = 1, 4, 1 do
			if danjiaList[id][1]>0 then
				if lv>=danjiaList[id][1] and lv<=danjiaList[id][2] then
					return danjiaList[id][3]
				end
			end
		end
		return 0
	end
end
addonTable.jisuandanjia=jisuandanjia