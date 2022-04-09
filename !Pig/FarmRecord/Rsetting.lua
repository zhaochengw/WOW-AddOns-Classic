local _, addonTable = ...;
local gsub = _G.string.gsub
local find = _G.string.find
--============带本助手-设置====================
--目的地
local daibenzhushou = {};
daibenzhushou.mudidiList = {};
local englishFaction, _ = UnitFactionGroup("player")
if englishFaction=="Alliance" then
	daibenzhushou.mudidiList = {"无","死亡矿井","监狱","血色修道院","玛拉顿","斯坦索姆","地狱火城墙","奴隶围栏","破碎大厅","蒸汽地窟","暗影迷宫","生态船",};
elseif englishFaction=="Horde" then
	daibenzhushou.mudidiList = {"无","怒焰裂谷","影牙城堡","血色修道院","玛拉顿","斯坦索姆","地狱火城墙","奴隶围栏","破碎大厅","蒸汽地窟","暗影迷宫","生态船",};
end

addonTable.daibenmulu=daibenzhushou.mudidiList
------------------
local function ADD_shezhi_F_UI()
	local fuFrame = daiben_UI.nr.setting
	fuFrame.set_F = CreateFrame("Frame", "Daiben_shezhi_F_UI", fuFrame,"BackdropTemplate");
	fuFrame.set_F:SetBackdrop({
		bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
		tile = true, tileSize = 0, edgeSize = 6,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	fuFrame.set_F:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
	fuFrame.set_F:SetWidth(520)
	fuFrame.set_F:SetHeight(334)
	fuFrame.set_F:Hide()
	fuFrame.set_F:EnableMouse(true);
	tinsert(UISpecialFrames,"Daiben_shezhi_F_UI");
	fuFrame.set_F.Close = CreateFrame("Button",nil,fuFrame.set_F, "UIPanelCloseButton");  
	fuFrame.set_F.Close:SetSize(28,28);
	fuFrame.set_F.Close:SetPoint("TOPRIGHT",fuFrame.set_F,"TOPRIGHT",3,3);
	local LV_danjia = {
		["怒焰裂谷"]={{8,16,5,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["死亡矿井"]={{10,20,10,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["影牙城堡"]={{14,21,10,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["监狱"]={{15,25,5,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["血色修道院"]={{20,40,20,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["玛拉顿"]={{30,48,30,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["斯坦索姆"]={{45,60,30,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["地狱火城墙"]={{58,65,40,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["奴隶围栏"]={{60,65,40,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["破碎大厅"]={{65,70,40,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["蒸汽地窟"]={{65,70,40,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["暗影迷宫"]={{65,70,40,},{0,0,0,},{0,0,0,},{0,0,0,}},
		["生态船"]={{65,70,40,},{0,0,0,},{0,0,0,},{0,0,0,}},
	}
	fuFrame.set_F.mudidiT = fuFrame.set_F:CreateFontString();
	fuFrame.set_F.mudidiT:SetPoint("TOPLEFT",fuFrame.set_F,"TOPLEFT",6,-7);
	fuFrame.set_F.mudidiT:SetFontObject(GameFontNormal);
	fuFrame.set_F.mudidiT:SetText("选择副本:");
	fuFrame.set_F.mudidi = CreateFrame("FRAME", nil, fuFrame.set_F, "UIDropDownMenuTemplate")
	fuFrame.set_F.mudidi:SetPoint("LEFT",fuFrame.set_F.mudidiT,"RIGHT",-14,-2)
	UIDropDownMenu_SetWidth(fuFrame.set_F.mudidi, 110)
	local function chushihuaxiala(self)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		for i=1,#daibenzhushou.mudidiList,1 do
		    info.text, info.arg1, info.checked = daibenzhushou.mudidiList[i], daibenzhushou.mudidiList[i], daibenzhushou.mudidiList[i] == PIG_Per["FarmRecord"]["kaichemudidi"];
			UIDropDownMenu_AddButton(info)
		end 
	end
	function fuFrame.set_F.mudidi:SetValue(newValue)
		UIDropDownMenu_SetText(fuFrame.set_F.mudidi, newValue)
		PIG_Per["FarmRecord"]["kaichemudidi"] = newValue;
		if newValue=="无" then
			fuFrame.set_F.danjiaF.XG:Hide();
			PIG_Per["FarmRecord"]['autohuifu']="OFF"
			daiben_UI.yesno.Tex:SetTexture("interface/common/indicator-red.blp");
			daiben_UI.yesno:SetChecked(false)
		else
			fuFrame.set_F.danjiaF.XG:Show();
		end
		PIG_Per["FarmRecord"]["LV-danjia"][newValue]=PIG_Per["FarmRecord"]["LV-danjia"][newValue] or LV_danjia[newValue]
		local jiageinfo = PIG_Per["FarmRecord"]["LV-danjia"][newValue] or LV_danjia[newValue]
		for id = 1, 4, 1 do
			_G["danjiashezhi_lvK_"..id]:SetText("");
			_G["danjiashezhi_lvJ_"..id]:SetText("");
			_G["danjiashezhi_danjia_"..id]:SetText("");
			local kaishi,jieshu,danjia=jiageinfo[id][1],jiageinfo[id][2],jiageinfo[id][3]
			if kaishi>0 then
				_G["danjiashezhi_lvK_"..id]:SetText(kaishi);
			end
			if jieshu>0 then
				_G["danjiashezhi_lvJ_"..id]:SetText(jieshu);
			end
			if danjia>0 then
				_G["danjiashezhi_danjia_"..id]:SetText(danjia);
			end
		end
		addonTable.FarmRecord_gengxinjizhangData("shezhi")
		CloseDropDownMenus()
	end
	--单价设置
	fuFrame.set_F.danjiaF = CreateFrame("Frame", nil, fuFrame.set_F,"BackdropTemplate");
	fuFrame.set_F.danjiaF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 10,});
	fuFrame.set_F.danjiaF:SetSize(fuFrame.set_F:GetWidth()/2+10,126);
	fuFrame.set_F.danjiaF:SetPoint("TOPLEFT", fuFrame.set_F, "TOPLEFT", 4,-30);

	--错误提示
	fuFrame.set_F.danjiaF.error = CreateFrame("Frame", nil, fuFrame.set_F.danjiaF,"BackdropTemplate");
	fuFrame.set_F.danjiaF.error:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 0, edgeSize = 10,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	fuFrame.set_F.danjiaF.error:SetSize(fuFrame.set_F.danjiaF:GetWidth()-10,80);
	fuFrame.set_F.danjiaF.error:SetPoint("TOP",fuFrame.set_F.danjiaF,"TOP",0,-8);
	fuFrame.set_F.danjiaF.error:SetFrameStrata("HIGH")
	fuFrame.set_F.danjiaF.error:Hide();
	fuFrame.set_F.danjiaF.error.T = fuFrame.set_F.danjiaF.error:CreateFontString();
	fuFrame.set_F.danjiaF.error.T:SetPoint("TOP",fuFrame.set_F.danjiaF.error,"TOP",0,-14);
	fuFrame.set_F.danjiaF.error.T:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.set_F.danjiaF.error.Close = CreateFrame("Button",nil,fuFrame.set_F.danjiaF.error, "UIPanelButtonTemplate");  
	fuFrame.set_F.danjiaF.error.Close:SetSize(80,20);
	fuFrame.set_F.danjiaF.error.Close:SetPoint("TOP",fuFrame.set_F.danjiaF.error,"TOP",0,-46);
	fuFrame.set_F.danjiaF.error.Close:SetText("去修改");
	fuFrame.set_F.danjiaF.error.Close:SetScript("OnClick", function (self)
		fuFrame.set_F.danjiaF.error:Hide()
	end)
	fuFrame.set_F.danjiaF.XG = CreateFrame("Button",nil,fuFrame.set_F.danjiaF, "UIPanelButtonTemplate");  
	fuFrame.set_F.danjiaF.XG:SetSize(60,20);
	fuFrame.set_F.danjiaF.XG:SetPoint("LEFT",fuFrame.set_F.mudidi,"RIGHT",-7,2);
	fuFrame.set_F.danjiaF.XG:SetText("修改");
	fuFrame.set_F.danjiaF.XG:Hide();
	fuFrame.set_F.danjiaF.XG:SetScript("OnClick", function (self)
		if self:GetText()=="修改" then
			self:SetText("保存");
			for id = 1, 4, 1 do
				_G["danjiashezhi_lvK_"..id]:Enable()
				_G["danjiashezhi_lvJ_"..id]:Enable()
				_G["danjiashezhi_danjia_"..id]:Enable()
				_G["danjiashezhi_lvK_"..id]:SetTextColor(1, 1, 0, 1);
				_G["danjiashezhi_lvJ_"..id]:SetTextColor(1, 1, 0, 1);
				_G["danjiashezhi_danjia_"..id]:SetTextColor(1, 1, 0, 1);
				_G["danjiashezhi_lvK_"..id]:SetBackdropColor(1, 1, 1, 1);
				_G["danjiashezhi_lvJ_"..id]:SetBackdropColor(1, 1, 1, 1);
				_G["danjiashezhi_danjia_"..id]:SetBackdropColor(1, 1, 1, 1);
			end
		elseif self:GetText()=="保存" then
			for id = 1, 4, 1 do
				local kasihi =_G["danjiashezhi_lvK_"..id]:GetNumber()
				local jieshu =_G["danjiashezhi_lvJ_"..id]:GetNumber()
				if kasihi>0 or jieshu>0 then
					if kasihi>jieshu then
						fuFrame.set_F.danjiaF.error:Show();
						fuFrame.set_F.danjiaF.error.T:SetText("\124cffffFF00起始级别不能大于结束级别！\124r\n\124cff00ff00错误位置：第"..id.."行\124r");
						return
					end
					if id<4 then
						local kasihi_pl =_G["danjiashezhi_lvK_"..id+1]:GetNumber()
						if kasihi_pl>0 then
							if jieshu>=kasihi_pl then
								fuFrame.set_F.danjiaF.error:Show();
								fuFrame.set_F.danjiaF.error.T:SetText("\124cffffFF00第"..id.."行与第"..(id+1).."行级别范围重复，请检查\124r");
								return
							end
						end
						if kasihi_pl>0 then
							if kasihi_pl-jieshu>1 then
								fuFrame.set_F.danjiaF.error:Show();
								fuFrame.set_F.danjiaF.error.T:SetText("\124cffffFF00第"..id.."行与第"..(id+1).."行之间有空余级别，请检查\124r");
								return
							end
						end
					end

				end
			end
			--
			for id = 1, 4, 1 do
				local kasihi =_G["danjiashezhi_lvK_"..id]:GetNumber()
				local jieshu =_G["danjiashezhi_lvJ_"..id]:GetNumber()
				local danjiaG =_G["danjiashezhi_danjia_"..id]:GetNumber()
				PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][1]=kasihi
				PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][2]=jieshu
				PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][3]=danjiaG
				if kasihi==0 then _G["danjiashezhi_lvK_"..id]:SetText("") end
				if jieshu==0 then _G["danjiashezhi_lvJ_"..id]:SetText("") end
				if danjiaG==0 then _G["danjiashezhi_danjia_"..id]:SetText("") end
				_G["danjiashezhi_lvK_"..id]:Disable()
				_G["danjiashezhi_lvJ_"..id]:Disable()
				_G["danjiashezhi_danjia_"..id]:Disable()
				_G["danjiashezhi_lvK_"..id]:SetTextColor(0, 1, 0, 1);
				_G["danjiashezhi_lvJ_"..id]:SetTextColor(0, 1, 0, 1);
				_G["danjiashezhi_danjia_"..id]:SetTextColor(0, 1, 0, 1);
				_G["danjiashezhi_lvK_"..id]:SetBackdropColor(1, 1, 1, 0);
				_G["danjiashezhi_lvJ_"..id]:SetBackdropColor(1, 1, 1, 0);
				_G["danjiashezhi_danjia_"..id]:SetBackdropColor(1, 1, 1, 0);
			end
			self:SetText("修改");
			addonTable.FarmRecord_gengxinjizhangData("shezhi")
		end
	end);
	-----------
	for id = 1, 4, 1 do
		fuFrame.set_F.danjiaF.listID = fuFrame.set_F.danjiaF:CreateFontString("danjiashezhi_"..id);
		fuFrame.set_F.danjiaF.listID:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		if id==1 then
			fuFrame.set_F.danjiaF.listID:SetPoint("TOPLEFT", fuFrame.set_F.danjiaF, "TOPLEFT", 4,-12);
		else
			fuFrame.set_F.danjiaF.listID:SetPoint("TOPLEFT", _G["danjiashezhi_"..(id-1)], "BOTTOMLEFT", 0,-17);
		end
		fuFrame.set_F.danjiaF.listID:SetText(id.."、");
		fuFrame.set_F.danjiaF.listID:SetTextColor(0, 0.8, 0.8, 1);

		fuFrame.set_F.danjiaF.lvK = CreateFrame('EditBox', "danjiashezhi_lvK_"..id, fuFrame.set_F.danjiaF,"BackdropTemplate");
		fuFrame.set_F.danjiaF.lvK:SetSize(30,30);
		fuFrame.set_F.danjiaF.lvK:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = 0,right = -0,top = 2,bottom = -13}})
		fuFrame.set_F.danjiaF.lvK:SetPoint("LEFT", fuFrame.set_F.danjiaF.listID, "RIGHT", 4,0);
		fuFrame.set_F.danjiaF.lvK:SetFontObject(ChatFontNormal);
		fuFrame.set_F.danjiaF.lvK:SetAutoFocus(false);
		fuFrame.set_F.danjiaF.lvK:SetNumeric()
		fuFrame.set_F.danjiaF.lvK:SetMaxLetters(2)
		fuFrame.set_F.danjiaF.lvK:Disable();
		fuFrame.set_F.danjiaF.lvK:SetTextColor(0, 1, 0, 1);
		fuFrame.set_F.danjiaF.lvK:SetBackdropColor(1, 1, 1, 0);
		fuFrame.set_F.danjiaF.lvK:SetJustifyH("CENTER");

		fuFrame.set_F.danjiaF.lvKT = fuFrame.set_F.danjiaF:CreateFontString();
		fuFrame.set_F.danjiaF.lvKT:SetPoint("LEFT", fuFrame.set_F.danjiaF.lvK, "RIGHT", 2,0);
		fuFrame.set_F.danjiaF.lvKT:SetFont(ChatFontNormal:GetFont(), 13);
		fuFrame.set_F.danjiaF.lvKT:SetText("级—");
		fuFrame.set_F.danjiaF.lvKT:SetTextColor(0.8, 0.8, 0.8, 1);

		fuFrame.set_F.danjiaF.lvJ = CreateFrame('EditBox', "danjiashezhi_lvJ_"..id, fuFrame.set_F.danjiaF,"BackdropTemplate");
		fuFrame.set_F.danjiaF.lvJ:SetSize(30,30);
		fuFrame.set_F.danjiaF.lvJ:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = 0,right = -0,top = 2,bottom = -13}})
		fuFrame.set_F.danjiaF.lvJ:SetPoint("LEFT", fuFrame.set_F.danjiaF.lvKT, "RIGHT", 4,0);
		fuFrame.set_F.danjiaF.lvJ:SetFontObject(ChatFontNormal);
		fuFrame.set_F.danjiaF.lvJ:SetAutoFocus(false);
		fuFrame.set_F.danjiaF.lvJ:SetNumeric()
		fuFrame.set_F.danjiaF.lvJ:SetMaxLetters(2)
		fuFrame.set_F.danjiaF.lvJ:Disable();
		fuFrame.set_F.danjiaF.lvJ:SetTextColor(0, 1, 0, 1);
		fuFrame.set_F.danjiaF.lvJ:SetBackdropColor(1, 1, 1, 0);
		fuFrame.set_F.danjiaF.lvJ:SetJustifyH("CENTER");

		fuFrame.set_F.danjiaF.lvJT = fuFrame.set_F.danjiaF:CreateFontString();
		fuFrame.set_F.danjiaF.lvJT:SetPoint("LEFT",fuFrame.set_F.danjiaF.lvJ,"RIGHT",2,0);
		fuFrame.set_F.danjiaF.lvJT:SetFont(ChatFontNormal:GetFont(), 13);
		fuFrame.set_F.danjiaF.lvJT:SetText("级，单价:");
		fuFrame.set_F.danjiaF.lvJT:SetTextColor(0.8, 0.8, 0.8, 1);

		fuFrame.set_F.danjiaF.danjia = CreateFrame('EditBox', "danjiashezhi_danjia_"..id, fuFrame.set_F.danjiaF,"BackdropTemplate");
		fuFrame.set_F.danjiaF.danjia:SetSize(40,30);
		fuFrame.set_F.danjiaF.danjia:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = 0,right = -0,top = 2,bottom = -13}})
		fuFrame.set_F.danjiaF.danjia:SetPoint("LEFT", fuFrame.set_F.danjiaF.lvJT, "RIGHT", 4,0);
		fuFrame.set_F.danjiaF.danjia:SetFontObject(ChatFontNormal);
		fuFrame.set_F.danjiaF.danjia:SetAutoFocus(false);
		fuFrame.set_F.danjiaF.danjia:SetNumeric()
		fuFrame.set_F.danjiaF.danjia:SetMaxLetters(4)
		fuFrame.set_F.danjiaF.danjia:Disable();
		fuFrame.set_F.danjiaF.danjia:SetTextColor(0, 1, 0, 1);
		fuFrame.set_F.danjiaF.danjia:SetBackdropColor(1, 1, 1, 0);
		fuFrame.set_F.danjiaF.danjia:SetJustifyH("CENTER");

		fuFrame.set_F.danjiaF.danjiaT = fuFrame.set_F.danjiaF:CreateFontString();
		fuFrame.set_F.danjiaF.danjiaT:SetPoint("LEFT",fuFrame.set_F.danjiaF.danjia,"RIGHT",2,0);
		fuFrame.set_F.danjiaF.danjiaT:SetFont(ChatFontNormal:GetFont(), 13);
		fuFrame.set_F.danjiaF.danjiaT:SetText("G/次");
		fuFrame.set_F.danjiaF.danjiaT:SetTextColor(0.8, 0.8, 0.8, 1);
	end

	--单价目录
	local function gengxinjibiedanjia()
		UIDropDownMenu_Initialize(fuFrame.set_F.mudidi, chushihuaxiala)
		UIDropDownMenu_SetText(fuFrame.set_F.mudidi, PIG_Per["FarmRecord"]["kaichemudidi"])
		fuFrame.set_F.danjiaF.XG:SetText("修改")
		if PIG_Per["FarmRecord"]["kaichemudidi"]~="无" then
			fuFrame.set_F.danjiaF.XG:Show()
			for id = 1, 4, 1 do
				local kaishi=PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][1]
				local jieshu=PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][2]
				local danjia=PIG_Per["FarmRecord"]["LV-danjia"][PIG_Per["FarmRecord"]["kaichemudidi"]][id][3]
				if kaishi>0 then
					_G["danjiashezhi_lvK_"..id]:SetText(kaishi);
				end
				if jieshu>0 then
					_G["danjiashezhi_lvJ_"..id]:SetText(jieshu);
				end
				if danjia>0 then
					_G["danjiashezhi_danjia_"..id]:SetText(danjia);
				end
				_G["danjiashezhi_lvK_"..id]:Disable()
				_G["danjiashezhi_lvJ_"..id]:Disable()
				_G["danjiashezhi_danjia_"..id]:Disable()
				_G["danjiashezhi_lvK_"..id]:SetTextColor(0, 1, 0, 1);
				_G["danjiashezhi_lvJ_"..id]:SetTextColor(0, 1, 0, 1);
				_G["danjiashezhi_danjia_"..id]:SetTextColor(0, 1, 0, 1);
				_G["danjiashezhi_lvK_"..id]:SetBackdropColor(1, 1, 1, 0);
				_G["danjiashezhi_lvJ_"..id]:SetBackdropColor(1, 1, 1, 0);
				_G["danjiashezhi_danjia_"..id]:SetBackdropColor(1, 1, 1, 0);
			end
		end

		if PIG_Per["FarmRecord"]["autobobao"]=="ON" then
			fuFrame.set_F.bobaoshezhi:SetChecked(true);
		else
			fuFrame.set_F.bobaoyue:Disable();
		end
		if PIG_Per["FarmRecord"]["bobaoyue"] then
			fuFrame.set_F.bobaoyue:SetChecked(true);
		end
		
		if PIG_Per["FarmRecord"]["jiuweiqueren"]=="ON" then
			fuFrame.set_F.jiuweiqueren:SetChecked(true);
		end
		if PIG_Per["FarmRecord"]["yuedanjiasuoding"] then
			fuFrame.set_F.suodingdanjia:SetChecked(true);
		end

		if PIG_Per["FarmRecord"]['autohuifu_danjia']=="ON" then
			fuFrame.set_F.huifudanjia:SetChecked(true);
		end
		if PIG_Per["FarmRecord"]['huifudengji']=="ON" then
			fuFrame.set_F.huifudengji:SetChecked(true);
		end
		if PIG_Per["FarmRecord"]["bangdingUI"]=="ON" then
			fuFrame.set_F.bangdingUI:SetChecked(true);
		end
		
		----
		fuFrame.set_F.guanjianzineirong="";
		for i=1,#PIG_Per["FarmRecord"]["autohuifu_TXT"] do
			if i~=#PIG_Per["FarmRecord"]["autohuifu_TXT"] then
				fuFrame.set_F.guanjianzineirong=fuFrame.set_F.guanjianzineirong..PIG_Per["FarmRecord"]["autohuifu_TXT"][i].."，"
			else
				fuFrame.set_F.guanjianzineirong=fuFrame.set_F.guanjianzineirong..PIG_Per["FarmRecord"]["autohuifu_TXT"][i]
			end
		end
		fuFrame.set_F.guanjiazi_E:SetText(fuFrame.set_F.guanjianzineirong);
		fuFrame.set_F.qianzhui="";
		fuFrame.set_F.qianzhui=fuFrame.set_F.qianzhui..PIG_Per["FarmRecord"]["autohuifu_Qianzhui"]
		fuFrame.set_F.huifuqianzhui_E:SetText(fuFrame.set_F.qianzhui);
		if PIG_Per["FarmRecord"]['autoyaoqing']=="ON" then
			fuFrame.set_F.Yaoqing:SetChecked(true);
		end
		fuFrame.set_F.yaoqingCMD_E:SetText(PIG_Per["FarmRecord"]['autohuifu_inv'])
	end

	--播报内容
	fuFrame.set_F.bobaoshezhi = CreateFrame("CheckButton", nil, fuFrame.set_F, "ChatConfigCheckButtonTemplate");
	fuFrame.set_F.bobaoshezhi:SetSize(30,30);
	fuFrame.set_F.bobaoshezhi:SetPoint("TOPLEFT",fuFrame.set_F,"TOPLEFT",290,-28);
	fuFrame.set_F.bobaoshezhi:SetHitRectInsets(0,-10,0,0);
	fuFrame.set_F.bobaoshezhi.Text:SetText("播报详情");
	fuFrame.set_F.bobaoshezhi.tooltip = "重置播报上次刷本耗时/击杀数/队伍内玩家剩余次数/经验/声望\n\124cff00ff00默认只播报副本已重置\124r\n\124cffFFff00不是队长时只播报经验/声望\124r";
	fuFrame.set_F.bobaoshezhi:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per["FarmRecord"]['autobobao']="ON"
			fuFrame.set_F.bobaoyue:Enable()
		else
			PIG_Per["FarmRecord"]['autobobao']="OFF"
			fuFrame.set_F.bobaoyue:Disable()
		end
	end);
	--有余额时锁定单价
	fuFrame.set_F.bobaoyue = CreateFrame("CheckButton", nil, fuFrame.set_F, "ChatConfigCheckButtonTemplate");
	fuFrame.set_F.bobaoyue:SetSize(30,30);
	fuFrame.set_F.bobaoyue:SetPoint("TOPLEFT",fuFrame.set_F,"TOPLEFT",290,-60);
	fuFrame.set_F.bobaoyue:SetHitRectInsets(0,-10,0,0);
	fuFrame.set_F.bobaoyue.Text:SetText("播报玩家余额");
	fuFrame.set_F.bobaoyue.tooltip = "需先开启播报详情，播报玩家余次时也会播报余额。";
	fuFrame.set_F.bobaoyue:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per["FarmRecord"]["bobaoyue"]=true
		else
			PIG_Per["FarmRecord"]["bobaoyue"]=false
		end
	end);
	--重置时就位确认
	fuFrame.set_F.jiuweiqueren = CreateFrame("CheckButton", nil, fuFrame.set_F, "ChatConfigCheckButtonTemplate");
	fuFrame.set_F.jiuweiqueren:SetSize(30,30);
	fuFrame.set_F.jiuweiqueren:SetPoint("TOPLEFT",fuFrame.set_F,"TOPLEFT",290,-94);
	fuFrame.set_F.jiuweiqueren:SetHitRectInsets(0,-10,0,0);
	fuFrame.set_F.jiuweiqueren.Text:SetText("重置时就位确认");
	fuFrame.set_F.jiuweiqueren.tooltip = "重置时就位确认";
	fuFrame.set_F.jiuweiqueren:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per["FarmRecord"]['jiuweiqueren']="ON"
		else
			PIG_Per["FarmRecord"]['jiuweiqueren']="OFF"
		end
	end);
	--有余额时锁定单价
	fuFrame.set_F.suodingdanjia = CreateFrame("CheckButton", nil, fuFrame.set_F, "ChatConfigCheckButtonTemplate");
	fuFrame.set_F.suodingdanjia:SetSize(30,30);
	fuFrame.set_F.suodingdanjia:SetPoint("TOPLEFT",fuFrame.set_F,"TOPLEFT",290,-126);
	fuFrame.set_F.suodingdanjia:SetHitRectInsets(0,-10,0,0);
	fuFrame.set_F.suodingdanjia.Text:SetText("有余额时锁定单价");
	fuFrame.set_F.suodingdanjia.tooltip = "启用后，当玩家有余额时升级将不会更新单价，如需刷新请右击单价数字。";
	fuFrame.set_F.suodingdanjia:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per["FarmRecord"]["yuedanjiasuoding"]=true
		else
			PIG_Per["FarmRecord"]["yuedanjiasuoding"]=false
		end
	end);
	--------------------
	---自动回复
	local huifuhanhuagaodu=20
	fuFrame.set_F.huifushezhiXX = fuFrame.set_F:CreateFontString();
	fuFrame.set_F.huifushezhiXX:SetPoint("TOPLEFT",fuFrame.set_F,"TOPLEFT",10,-180);
	fuFrame.set_F.huifushezhiXX:SetFontObject(GameFontNormal);
	fuFrame.set_F.huifushezhiXX:SetText("自动回复:");
	---回复单价
	fuFrame.set_F.huifudanjia = CreateFrame("CheckButton", nil, fuFrame.set_F, "ChatConfigCheckButtonTemplate");
	fuFrame.set_F.huifudanjia:SetSize(28,28);
	fuFrame.set_F.huifudanjia:SetPoint("LEFT", fuFrame.set_F.huifushezhiXX, "RIGHT", 20,-0);
	fuFrame.set_F.huifudanjia:SetHitRectInsets(0,-10,0,0);
	fuFrame.set_F.huifudanjia.Text:SetText("回复等级单价");
	fuFrame.set_F.huifudanjia.tooltip = "自动回复等级要求和单价(也会在车队显示，为了方便老板询价，建议开启)";
	fuFrame.set_F.huifudanjia:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per["FarmRecord"]['autohuifu_danjia']="ON"
		else
			PIG_Per["FarmRecord"]['autohuifu_danjia']="OFF"
		end
	end);
	----
	fuFrame.set_F.huifudengji = CreateFrame("CheckButton", nil, fuFrame.set_F, "ChatConfigCheckButtonTemplate");
	fuFrame.set_F.huifudengji:SetSize(28,28);
	fuFrame.set_F.huifudengji:SetPoint("LEFT",fuFrame.set_F.huifudanjia,"RIGHT",120,-1);
	fuFrame.set_F.huifudengji:SetHitRectInsets(0,-10,0,0);
	fuFrame.set_F.huifudengji.Text:SetText("回复队伍等级");
	fuFrame.set_F.huifudengji.tooltip = "回复追加现有队伍玩家等级。(只在队伍中且队伍成员大于1才会生效)";
	fuFrame.set_F.huifudengji:SetScript("OnClick", function ()
		if fuFrame.set_F.huifudengji:GetChecked() then
			PIG_Per["FarmRecord"]['huifudengji']="ON"
		else
			PIG_Per["FarmRecord"]['huifudengji']="OFF"
		end
	end);
	--
	fuFrame.set_F.guanjiazi = fuFrame.set_F:CreateFontString();
	fuFrame.set_F.guanjiazi:SetPoint("TOPLEFT",fuFrame.set_F.huifushezhiXX,"BOTTOMLEFT",0,-14);
	fuFrame.set_F.guanjiazi:SetFontObject(GameFontNormal);
	fuFrame.set_F.guanjiazi:SetText("\124cff00ff00触发关键字(用，分隔):\124r");
	fuFrame.set_F.guanjiaziFFF = CreateFrame("Frame", nil, fuFrame.set_F,"BackdropTemplate");
	fuFrame.set_F.guanjiaziFFF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 16,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	fuFrame.set_F.guanjiaziFFF:SetSize(300,27);
	fuFrame.set_F.guanjiaziFFF:SetPoint("LEFT", fuFrame.set_F.guanjiazi, "RIGHT", 10,0);
	fuFrame.set_F.guanjiazi_E = CreateFrame('EditBox', nil, fuFrame.set_F.guanjiaziFFF,"BackdropTemplate");
	fuFrame.set_F.guanjiazi_E:SetPoint("TOPLEFT", fuFrame.set_F.guanjiaziFFF, "TOPLEFT", 6,-0);
	fuFrame.set_F.guanjiazi_E:SetPoint("BOTTOMRIGHT", fuFrame.set_F.guanjiaziFFF, "BOTTOMRIGHT", -6,-0);
	fuFrame.set_F.guanjiazi_E:SetFontObject(ChatFontNormal);
	fuFrame.set_F.guanjiazi_E:SetAutoFocus(false);
	fuFrame.set_F.guanjiazi_E:SetMaxLetters(100);
	fuFrame.set_F.guanjiazi_E:SetTextColor(1, 1, 1, 0.7);
	fuFrame.set_F.guanjiazi_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.set_F.guanjiazi_E:SetScript("OnEnterPressed", function(self) 
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
	fuFrame.set_F.guanjiazi_E:SetScript("OnEditFocusGained", function(self)
		self:SetTextColor(1, 1, 1, 1);
	end);
	fuFrame.set_F.guanjiazi_E:SetScript("OnEditFocusLost", function(self)
		local guanjianV = self:GetText();
		local guanjianshuzu = guanjianV:gsub("，", ",")
		local guanjianzilist = fengeguanjianzi(guanjianshuzu, ",")
		PIG_Per["FarmRecord"]["autohuifu_TXT"]=guanjianzilist;
		self:SetTextColor(1, 1, 1, 0.7);
	end);
	--自动回复前缀
	fuFrame.set_F.huifuqianzhui = fuFrame.set_F:CreateFontString();
	fuFrame.set_F.huifuqianzhui:SetPoint("TOPLEFT",fuFrame.set_F.guanjiazi,"BOTTOMLEFT",0,-14);
	fuFrame.set_F.huifuqianzhui:SetFontObject(GameFontNormal);
	fuFrame.set_F.huifuqianzhui:SetText("\124cff00ff00自动回复前缀:\124r");
	fuFrame.set_F.huifuqianzhuiFFF = CreateFrame("Frame", nil, fuFrame.set_F,"BackdropTemplate");
	fuFrame.set_F.huifuqianzhuiFFF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 16,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	fuFrame.set_F.huifuqianzhuiFFF:SetSize(320,27);
	fuFrame.set_F.huifuqianzhuiFFF:SetPoint("LEFT", fuFrame.set_F.huifuqianzhui, "RIGHT", 10,0);
	fuFrame.set_F.huifuqianzhui_E = CreateFrame('EditBox', nil, fuFrame.set_F.huifuqianzhuiFFF,"BackdropTemplate");
	fuFrame.set_F.huifuqianzhui_E:SetPoint("TOPLEFT", fuFrame.set_F.huifuqianzhuiFFF, "TOPLEFT", 8,0);
	fuFrame.set_F.huifuqianzhui_E:SetPoint("BOTTOMRIGHT", fuFrame.set_F.huifuqianzhuiFFF, "BOTTOMRIGHT", -8,0);
	fuFrame.set_F.huifuqianzhui_E:SetFontObject(ChatFontNormal);
	fuFrame.set_F.huifuqianzhui_E:SetAutoFocus(false);
	fuFrame.set_F.huifuqianzhui_E:SetMaxLetters(20);
	fuFrame.set_F.huifuqianzhui_E:SetTextColor(1, 1, 1, 0.7);
	fuFrame.set_F.huifuqianzhui_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.set_F.huifuqianzhui_E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.set_F.huifuqianzhui_E:SetScript("OnEditFocusGained", function(self)
		self:SetTextColor(1, 1, 1, 1);
	end);
	fuFrame.set_F.huifuqianzhui_E:SetScript("OnEditFocusLost", function(self)
		PIG_Per["FarmRecord"]["autohuifu_Qianzhui"]=self:GetText();
		self:SetTextColor(1, 1, 1, 0.7);
	end);
	--自动邀请
	fuFrame.set_F.Yaoqing = CreateFrame("CheckButton", nil, fuFrame.set_F, "ChatConfigCheckButtonTemplate");
	fuFrame.set_F.Yaoqing:SetSize(30,30);
	fuFrame.set_F.Yaoqing:SetPoint("TOPLEFT",fuFrame.set_F,"TOPLEFT",10,-260);
	fuFrame.set_F.Yaoqing:SetHitRectInsets(0,-60,0,0);
	fuFrame.set_F.Yaoqing.Text:SetText("自动邀请");
	fuFrame.set_F.Yaoqing.tooltip = "开启后收到预设指令将会自动邀请玩家进组（也会自动同意玩家在车队的上车申请）";
	fuFrame.set_F.Yaoqing:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per["FarmRecord"]['autoyaoqing']="ON"
		else
			PIG_Per["FarmRecord"]['autoyaoqing']="OFF"
		end
	end);
	--自动邀请指令
	fuFrame.set_F.yaoqingCMD = fuFrame.set_F:CreateFontString();
	fuFrame.set_F.yaoqingCMD:SetPoint("LEFT",fuFrame.set_F.Yaoqing,"RIGHT",90,-0);
	fuFrame.set_F.yaoqingCMD:SetFontObject(GameFontNormal);
	fuFrame.set_F.yaoqingCMD:SetText("\124cff00ff00自动邀请指令:\124r");
	fuFrame.set_F.yaoqingCMD_E = CreateFrame('EditBox', nil, fuFrame.set_F,"BackdropTemplate");
	fuFrame.set_F.yaoqingCMD_E:SetSize(60,30);
	fuFrame.set_F.yaoqingCMD_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -8,right = -0,top = 2,bottom = -13}})
	fuFrame.set_F.yaoqingCMD_E:SetPoint("LEFT", fuFrame.set_F.yaoqingCMD, "RIGHT", 10,0);
	fuFrame.set_F.yaoqingCMD_E:SetFontObject(ChatFontNormal);
	fuFrame.set_F.yaoqingCMD_E:SetAutoFocus(false);
	fuFrame.set_F.yaoqingCMD_E:SetMaxLetters(10)
	fuFrame.set_F.yaoqingCMD_E:SetTextColor(1, 1, 1, 0.7);
	fuFrame.set_F.yaoqingCMD_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.set_F.yaoqingCMD_E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.set_F.yaoqingCMD_E:SetScript("OnEditFocusGained", function(self)
		self:SetTextColor(1, 1, 1, 1);
	end);
	fuFrame.set_F.yaoqingCMD_E:SetScript("OnEditFocusLost", function(self)
		PIG_Per["FarmRecord"]["autohuifu_inv"]=self:GetText();
		self:SetTextColor(1, 1, 1, 0.7);
	end);
	--绑定计时于记账窗口
	fuFrame.set_F.bangdingUI = CreateFrame("CheckButton", nil, fuFrame.set_F, "ChatConfigCheckButtonTemplate");
	fuFrame.set_F.bangdingUI:SetSize(30,30);
	fuFrame.set_F.bangdingUI:SetPoint("TOPLEFT",fuFrame.set_F,"TOPLEFT",10,-300);
	fuFrame.set_F.bangdingUI:SetHitRectInsets(0,-60,0,0);
	fuFrame.set_F.bangdingUI.Text:SetText("计时窗口跟随记账窗口打开");
	fuFrame.set_F.bangdingUI.tooltip = "计时窗口跟随记账窗口打开或关闭";
	fuFrame.set_F.bangdingUI:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per["FarmRecord"]['bangdingUI']="ON"
			daiben_UI.zhankaijishi:Hide()
		else
			PIG_Per["FarmRecord"]['bangdingUI']="OFF"
			daiben_UI.zhankaijishi:Show()
		end
	end);
	----==============================================-
	fuFrame.set_F:SetScript("OnShow", function ()
		gengxinjibiedanjia()
	end)

	---重置带本助手配置
	fuFrame.set_F.chongzhizhushou = fuFrame.set_F:CreateFontString();
	fuFrame.set_F.chongzhizhushou:SetPoint("TOPLEFT",fuFrame.set_F,"TOPLEFT",280,-306);
	fuFrame.set_F.chongzhizhushou:SetFontObject(GameFontNormal);
	fuFrame.set_F.chongzhizhushou:SetText("\124cffFFff00出现问题请点这里:\124r");
	fuFrame.set_F.chongzhizhushouBUT = CreateFrame("Button","Default_Button_daibenzhushou_UI",fuFrame.set_F, "UIPanelButtonTemplate");  
	fuFrame.set_F.chongzhizhushouBUT:SetSize(80,20);
	fuFrame.set_F.chongzhizhushouBUT:SetPoint("LEFT",fuFrame.set_F.chongzhizhushou,"RIGHT",10,0);
	fuFrame.set_F.chongzhizhushouBUT:SetText("重置配置");
	fuFrame.set_F.chongzhizhushouBUT:SetScript("OnClick", function ()
		StaticPopup_Show ("HUIFU_DEFAULT_DAIBEN_XX");
	end);
	StaticPopupDialogs["HUIFU_DEFAULT_DAIBEN_XX"] = {
		text = "此操作将\124cffff0000重置\124r带本助手所有配置，并清空所有已保存数据，需重载界面。\n确定重置?",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG_Per["FarmRecord"] = addonTable.Default_Per["FarmRecord"];
			PIG_Per["FarmRecord"]["Kaiqi"] = "ON";
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
end
addonTable.ADD_shezhi_F_UI=ADD_shezhi_F_UI