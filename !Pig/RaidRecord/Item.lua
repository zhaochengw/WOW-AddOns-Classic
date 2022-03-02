local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local sub = _G.string.sub 
local Width,Height  = TabFrame_UI:GetWidth(), TabFrame_UI:GetHeight();
local hang_Height,hang_NUM  = 34, 12;
local fuFrame = TablistFrame_1_UI
-- --================================
--物品点击提示
fuFrame.tishi = CreateFrame("Frame", nil, fuFrame);
fuFrame.tishi:SetSize(26,26);
fuFrame.tishi:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 4,-2);
fuFrame.tishi.Tex = fuFrame.tishi:CreateTexture(nil, "BORDER");
fuFrame.tishi.Tex:SetTexture("interface/common/help-i.blp");
fuFrame.tishi.Tex:SetAllPoints(fuFrame.tishi)
fuFrame.tishi:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("|cff00FFff鼠标左键按住：|r|cff00FF00预览物品属性|r\n"..
		"|cff00FFff右击：|r|cff00FF00设置拾取过滤此物品,交易面板打开状态下为摆放物品到交易窗口|r\n"..
		"|cff00FFffShift+左击：|r|cff00ff00发送物品到聊天栏|r\n"..
		"|cff00FFffCtrl+左击：|r|cff00ff00合并目录内当前物品|r\n"..
		"|cff00FFffCtrl+右击：|r|cff00ff00拆分当前物品|r")
	GameTooltip:Show();
end);
fuFrame.tishi:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
--标题
local julidingbu = -7;
for id = 1, 7, 1 do
	fuFrame.biaoti = fuFrame:CreateFontString("item_biaoti_"..id);
	fuFrame.biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
end
---
item_biaoti_1:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 70,julidingbu);
item_biaoti_1:SetText("\124cffFFFF00物品\124r");
---显示过滤
local guolvlist = {"全部","已成交","未成交","有欠款"}
local guolvlist_dangqianmoshi = "全部"
fuFrame.ShowGuolv = CreateFrame("FRAME", nil, fuFrame, "UIDropDownMenuTemplate")
fuFrame.ShowGuolv:SetPoint("LEFT",item_biaoti_1,"RIGHT",-14,-2)
UIDropDownMenu_SetWidth(fuFrame.ShowGuolv, 80)

local function ShowGuolv_Up()
	local info = UIDropDownMenu_CreateInfo()
	info.func = fuFrame.ShowGuolv.SetValue
	for i=1,#guolvlist,1 do
	    info.text, info.arg1, info.checked= guolvlist[i], guolvlist[i], guolvlist[i] == guolvlist_dangqianmoshi;
		UIDropDownMenu_AddButton(info)
	end 
end
--
item_biaoti_2:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 328,julidingbu);
item_biaoti_2:SetText("\124cffFFFF00拾取者\124r");
item_biaoti_3:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 446,julidingbu);
item_biaoti_3:SetText("\124cffFFFF00成交价/G\124r");
item_biaoti_4:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 552,julidingbu);
item_biaoti_4:SetText("\124cffFFFF00欠款/G\124r");
item_biaoti_5:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 626,julidingbu);
item_biaoti_5:SetText("\124cffFFFF00成交人\124r");

fuFrame.lineT = fuFrame:CreateLine()
fuFrame.lineT:SetColorTexture(1,1,1,0.2)
fuFrame.lineT:SetThickness(1);
fuFrame.lineT:SetStartPoint("TOPLEFT",4,-28)
fuFrame.lineT:SetEndPoint("TOPRIGHT",-4,-28)
--//////物品显示目录//////////////////////////////////////////////
local function UpdateItem(self)
	for line = 1, hang_NUM do
		_G["Item_hang_"..line.."_UI"]:Hide();
		_G["Item_hang_"..line.."_UI"].time:SetText();

		_G["Item_hang_"..line.."_UI"].item.icon:SetTexture();
		_G["Item_hang_"..line.."_UI"].item.link:SetText();
		_G["Item_hang_"..line.."_UI"].item.NO:SetText();
		_G["Item_hang_"..line.."_UI"].item.daojishiF:Hide();

		_G["Item_hang_"..line.."_UI"].Shiquzhe:SetText();

		_G["Item_hang_"..line.."_UI"].chengjiao.G:SetText();
		_G["Item_hang_"..line.."_UI"].chengjiao.E:Hide();
		_G["Item_hang_"..line.."_UI"].chengjiao.bianji:Show();
		_G["Item_hang_"..line.."_UI"].chengjiao.baocun:Hide();

		_G["Item_hang_"..line.."_UI"].Qiankuan.G:SetText();
		_G["Item_hang_"..line.."_UI"].Qiankuan.E:Hide();
		_G["Item_hang_"..line.."_UI"].Qiankuan.bianji:Show();
		_G["Item_hang_"..line.."_UI"].Qiankuan.baocun:Hide();

		_G["Item_hang_"..line.."_UI"].ChengjiaoRen.T:SetText(" 无");
    end
	local ItemS = PIG["RaidRecord"]["ItemList"];
	local ItemsNum = #ItemS;
	local ItemsNum_GL = {};
    if ItemsNum>0 then
    	if guolvlist_dangqianmoshi == "已成交" then
			for x = 1, #ItemS do
				if ItemS[x][9]~=0 or ItemS[x][14]~=0 then
					table.insert(ItemsNum_GL,x);
				end	
			end
		elseif guolvlist_dangqianmoshi == "未成交" then
			for x = 1, #ItemS do
				if ItemS[x][9]==0 and ItemS[x][14]==0 then
					table.insert(ItemsNum_GL,x);
				end	
			end
		elseif guolvlist_dangqianmoshi == "有欠款" then
			for x = 1, #ItemS do
				if ItemS[x][14]~=0 then
					table.insert(ItemsNum_GL,x);
				end	
			end
		end

		FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
		local offset = FauxScrollFrame_GetOffset(self);
		for line = 1, hang_NUM do
			local LOOT_dangqian = line+offset;
			if guolvlist_dangqianmoshi ~= "全部" then
			    LOOT_dangqian = ItemsNum_GL[LOOT_dangqian];
			end
			if ItemS[LOOT_dangqian] then
				local dangqianItem=ItemS[LOOT_dangqian]
				_G["Item_hang_"..line.."_UI"]:Show();
				_G["Item_hang_"..line.."_UI"].time:SetText("\124cff00ffFF"..LOOT_dangqian.."\124r  "..date("%m-%d %H:%M",dangqianItem[1]));
				_G["Item_hang_"..line.."_UI"].paimai:SetID(LOOT_dangqian);
				if dangqianItem[7]==0 then
					_G["Item_hang_"..line.."_UI"].paimai.Tex:SetDesaturated(false);
				elseif dangqianItem[7]==1 then
					_G["Item_hang_"..line.."_UI"].paimai.Tex:SetDesaturated(true);
				end

				_G["Item_hang_"..line.."_UI"].item.icon:SetTexture(dangqianItem[6]);
				_G["Item_hang_"..line.."_UI"].item.link:SetText(dangqianItem[2]);
				_G["Item_hang_"..line.."_UI"].item.NO:SetText(dangqianItem[3]);

				local item_daojishi=GetServerTime()-dangqianItem[1];
				if item_daojishi>6600 then
					_G["Item_hang_"..line.."_UI"].item.daojishiF:Show();
					if item_daojishi>7200 then
						_G["Item_hang_"..line.."_UI"].item.daojishiF:Hide();
					end
				end

				_G["Item_hang_"..line.."_UI"].item:SetScript("OnMouseDown", function (self,button)
					if button=="LeftButton" then
						if IsShiftKeyDown() or IsControlKeyDown() then
						else
							GameTooltip:ClearLines();
							GameTooltip:SetOwner(self.link, "ANCHOR_CURSOR");
							GameTooltip:SetHyperlink(dangqianItem[2]);
						end
					end
				end);
				_G["Item_hang_"..line.."_UI"].item:SetScript("OnMouseUp", function (self,button)
						GameTooltip:ClearLines();GameTooltip:Hide()
						if button=="LeftButton" then
					 		if IsShiftKeyDown() then
								local editBox = ChatEdit_ChooseBoxForSend();
								local hasText = editBox:GetText()..dangqianItem[2]
								if editBox:HasFocus() then
									editBox:SetText(hasText);
								else
									ChatEdit_ActivateChat(editBox)
									editBox:SetText(hasText);
								end
							elseif IsControlKeyDown() then
								if not Paimai_UI:IsShown() then
									tishi_UI.nr.hei:Hide()
									tishi_UI.nr.del:Hide()
									tishi_UI.nr.chaif:Hide()
									tishi_UI:Show();
									tishi_UI.nr.hebi:Show()
									tishi_UI.nr.bianjiID:SetText(LOOT_dangqian);
									tishi_UI.nr.bianjiN:SetText("hebi");
									tishi_UI.nr.hebi.T1:SetText(dangqianItem[2].."\n");
								end
							end 
						elseif button=="RightButton" then
							if IsControlKeyDown() then
								if not Paimai_UI:IsShown() then
									local zonliag = dangqianItem[3]
									if zonliag>1 then
										tishi_UI.nr.hei:Hide()
										tishi_UI.nr.del:Hide()
										tishi_UI.nr.hebi:Hide()
										tishi_UI:Show();
										tishi_UI.nr.chaif:Show()
										tishi_UI.nr.bianjiID:SetText(LOOT_dangqian);
										tishi_UI.nr.bianjiN:SetText("chaif");
										tishi_UI.nr.chaif.T1:SetText(dangqianItem[2].."\n");
										tishi_UI.nr.chaif.Slider.Text:SetText(1);
										tishi_UI.nr.chaif.Slider:SetValue(1);
										tishi_UI.nr.chaif.Slider.High:SetText(zonliag-1);
										tishi_UI.nr.chaif.Slider:SetMinMaxValues(1, zonliag-1);
									end
								end
							elseif IsShiftKeyDown() then
							else
								if TradeFrame:IsShown() then
									for i=0,4 do
										local xx=GetContainerNumSlots(i) 
										for j=1,xx do
											if GetContainerItemID(i,j)==dangqianItem[11] then
												UseContainerItem(i, j);
												break;
											end
										end 
									end
								else
									if not Paimai_UI:IsShown() then
										tishi_UI.nr.del:Hide()
										tishi_UI.nr.hebi:Hide()
										tishi_UI.nr.chaif:Hide()
										tishi_UI:Show();
										tishi_UI.nr.hei:Show()
										tishi_UI.nr.bianjiID:SetText(dangqianItem[11]);
										tishi_UI.nr.bianjiN:SetText("hei");
										tishi_UI.nr.hei.T1:SetText(dangqianItem[2].."\n");
									end
								end
							end
						end
				end);

				local _, _, _, shiquname = dangqianItem[4]:find("((.+)-)");
				if shiquname then
					_G["Item_hang_"..line.."_UI"].Shiquzhe:SetText(shiquname);
				else
					_G["Item_hang_"..line.."_UI"].Shiquzhe:SetText(dangqianItem[4]);
				end

				_G["Item_hang_"..line.."_UI"].chengjiao.G:SetText(dangqianItem[9]);
				_G["Item_hang_"..line.."_UI"].chengjiao.E:SetID(LOOT_dangqian);
				_G["Item_hang_"..line.."_UI"].chengjiao.bianji:SetID(LOOT_dangqian);
				_G["Item_hang_"..line.."_UI"].chengjiao.baocun:SetID(LOOT_dangqian);

				_G["Item_hang_"..line.."_UI"].Qiankuan.G:SetText(dangqianItem[14]);
				_G["Item_hang_"..line.."_UI"].Qiankuan.E:SetID(LOOT_dangqian);
				_G["Item_hang_"..line.."_UI"].Qiankuan.bianji:SetID(LOOT_dangqian);
				_G["Item_hang_"..line.."_UI"].Qiankuan.baocun:SetID(LOOT_dangqian);

				if dangqianItem[8]~="无" then
					local _, _, _, chengjiaoname = dangqianItem[8]:find("((.+)-)");
					if chengjiaoname then
						_G["Item_hang_"..line.."_UI"].ChengjiaoRen.T:SetText(chengjiaoname);
					else
						_G["Item_hang_"..line.."_UI"].ChengjiaoRen.T:SetText(dangqianItem[8]);
					end
				end
				_G["Item_hang_"..line.."_UI"].ChengjiaoRen:SetID(LOOT_dangqian);

				_G["Item_hang_"..line.."_UI"].del:SetID(LOOT_dangqian);

			end
		end
	end
	addonTable.RaidRecord_UpdateG();
end
addonTable.RaidRecord_UpdateItem=UpdateItem;
----------
fuFrame:SetScript("OnShow", function ()
	UpdateItem(Item_Scroll_UI);
end)
function fuFrame.ShowGuolv:SetValue(newValueqk)
	UIDropDownMenu_SetText(fuFrame.ShowGuolv, newValueqk)
	guolvlist_dangqianmoshi = newValueqk
	UpdateItem(Item_Scroll_UI);
	CloseDropDownMenus()
end
UIDropDownMenu_Initialize(fuFrame.ShowGuolv, ShowGuolv_Up)
UIDropDownMenu_SetText(fuFrame.ShowGuolv, guolvlist_dangqianmoshi)
-----
--刷新选择框角色
local function UpdateChengjiaorenxuanze()
	for p=1,8 do
		for pp=1,5 do
			_G["chengjiaoren_"..p.."_"..pp]:Hide();
			_G["chengjiaoren_"..p.."_"..pp].Name:SetText();
			_G["chengjiaoren_"..p.."_"..pp].Name_XS:SetText();
		end
    end
	for p=1,8 do
		if #PIG["RaidRecord"]["Raidinfo"][p]>0 then
			for pp=1,#PIG["RaidRecord"]["Raidinfo"][p] do
			   	if PIG["RaidRecord"]["Raidinfo"][p][pp][4]~=nil then
			   		_G["chengjiaoren_"..p.."_"..pp]:Show();
			   		_G["chengjiaoren_"..p.."_"..pp].Name:SetText(PIG["RaidRecord"]["Raidinfo"][p][pp][4]);
			   		local _, _, _, wanjiaName = PIG["RaidRecord"]["Raidinfo"][p][pp][4]:find("((.+)-)");
					if wanjiaName then
						_G["chengjiaoren_"..p.."_"..pp].Name_XS:SetText(wanjiaName);
					else
						_G["chengjiaoren_"..p.."_"..pp].Name_XS:SetText(PIG["RaidRecord"]["Raidinfo"][p][pp][4]);
					end
					_G["chengjiaoren_"..p.."_"..pp].Name_XS:SetTextColor(PIG["RaidRecord"]["Raidinfo"][p][pp][2][1],PIG["RaidRecord"]["Raidinfo"][p][pp][2][2],PIG["RaidRecord"]["Raidinfo"][p][pp][2][3], 1);
			   	end
			end
		end
	end
end
addonTable.RaidRecord_UpdateChengjiaorenxuanze = UpdateChengjiaorenxuanze;
----创建滚动区域
local Item_Scroll = CreateFrame("ScrollFrame","Item_Scroll_UI",fuFrame, "FauxScrollFrameTemplate");  
Item_Scroll:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",5,-hang_Height+6);
Item_Scroll:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",-27,5);
Item_Scroll:SetScript("OnVerticalScroll", function(self, offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, UpdateItem)
end)
--创建行
for id = 1, hang_NUM do
	local Item_hang = CreateFrame("Frame", "Item_hang_"..id.."_UI", Item_Scroll:GetParent());
	Item_hang:SetSize(Width-30, hang_Height);
	if id==1 then
		Item_hang:SetPoint("TOP",Item_Scroll,"TOP",0,0);
	else
		Item_hang:SetPoint("TOP",_G["Item_hang_"..(id-1).."_UI"],"BOTTOM",0,-0);
	end
	Item_hang:Hide()

	Item_hang.line = Item_hang:CreateLine()
	Item_hang.line:SetColorTexture(1,1,1,0.2)
	Item_hang.line:SetThickness(1);
	Item_hang.line:SetStartPoint("BOTTOMLEFT",0,0)
	Item_hang.line:SetEndPoint("BOTTOMRIGHT",0,0)

	Item_hang.time = Item_hang:CreateFontString();
	Item_hang.time:SetPoint("LEFT", Item_hang, "LEFT", -100,0);
	Item_hang.time:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	Item_hang.time:Hide()
	
	Item_hang.paimai = CreateFrame("Button","Item_hang.paimai_"..id.."_UI",Item_hang, "TruncatedButtonTemplate");
	Item_hang.paimai:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	Item_hang.paimai:SetSize(hang_Height-10,hang_Height-10);
	Item_hang.paimai:SetPoint("LEFT", Item_hang, "LEFT", 4,0);
	Item_hang.paimai.Tex = Item_hang.paimai:CreateTexture(nil, "BORDER");
	Item_hang.paimai.Tex:SetTexture("interface/gossipframe/bankergossipicon.blp");
	Item_hang.paimai.Tex:SetPoint("CENTER");
	Item_hang.paimai.Tex:SetSize(hang_Height-16,hang_Height-16);
	Item_hang.paimai:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.5,-1.5);
	end);
	Item_hang.paimai:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	Item_hang.paimai:SetScript("OnClick", function (self)
		Paimai_UI.nr.bianjiID:SetText(self:GetID())
		Paimai_UI:Show();
		Paimai_UI.nr.item_icon:SetTexture(PIG["RaidRecord"]["ItemList"][self:GetID()][6]);
		Paimai_UI.nr.item_link:SetText(PIG["RaidRecord"]["ItemList"][self:GetID()][2]);
		Paimai_UI.nr.item_NO:SetText(PIG["RaidRecord"]["ItemList"][self:GetID()][3]);
	end);

	Item_hang.item = CreateFrame("Frame", nil, Item_hang);
	Item_hang.item:SetSize(280,hang_Height);
	Item_hang.item:SetPoint("LEFT",Item_hang,"LEFT",34,0);
	Item_hang.item.icon = Item_hang.item:CreateTexture(nil, "BORDER");
	Item_hang.item.icon:SetSize(hang_Height-6,hang_Height-6);
	Item_hang.item.icon:SetPoint("LEFT", Item_hang.item, "LEFT", 0,0);
	Item_hang.item.link = Item_hang.item:CreateFontString();
	Item_hang.item.link:SetPoint("LEFT", Item_hang.item, "LEFT", 32,0);
	Item_hang.item.link:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	Item_hang.item.NO = Item_hang.item:CreateFontString();
	Item_hang.item.NO:SetPoint("BOTTOMRIGHT", Item_hang.item.icon, "BOTTOMRIGHT", -1,1);
	Item_hang.item.NO:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");

	Item_hang.item.daojishiF = CreateFrame("Frame", nil, Item_hang.item);
	Item_hang.item.daojishiF:SetSize(22,22);
	Item_hang.item.daojishiF:SetPoint("LEFT", Item_hang.item.link, "RIGHT", 0,0);
	Item_hang.item.daojishiF:Hide();
	Item_hang.item.daojishi = Item_hang.item.daojishiF:CreateTexture(nil, "BORDER");
	Item_hang.item.daojishi:SetTexture("interface/helpframe/helpicon-reportlag.blp");
	Item_hang.item.daojishi:SetSize(28,28);
	Item_hang.item.daojishi:SetPoint("CENTER", 0,0);
	Item_hang.item.daojishiF:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("请注意：")
		GameTooltip:AddLine("|cffFFff00可交易时间不足10分钟|r")
		GameTooltip:Show();
	end);
	Item_hang.item.daojishiF:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);

	Item_hang.Shiquzhe = Item_hang:CreateFontString();
	Item_hang.Shiquzhe:SetSize(94,hang_Height);
	Item_hang.Shiquzhe:SetJustifyH("LEFT");
	Item_hang.Shiquzhe:SetPoint("LEFT", Item_hang, "LEFT", 320,1);
	Item_hang.Shiquzhe:SetFont(ChatFontNormal:GetFont(), 13.4, "OUTLINE");
	---------

	Item_hang.chengjiao = CreateFrame("Frame", nil, Item_hang);
	Item_hang.chengjiao:SetSize(70, hang_Height);
	Item_hang.chengjiao:SetPoint("LEFT", Item_hang, "LEFT", 420,0);
	Item_hang.chengjiao.G = Item_hang.chengjiao:CreateFontString();
	Item_hang.chengjiao.G:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	Item_hang.chengjiao.G:SetPoint("RIGHT", Item_hang.chengjiao, "RIGHT", 0,0);
	Item_hang.chengjiao.G:SetTextColor(0, 1, 1, 1);
	Item_hang.chengjiao.E = CreateFrame('EditBox', nil, Item_hang.chengjiao, "BackdropTemplate");
	Item_hang.chengjiao.E:SetSize(60,hang_Height);
	Item_hang.chengjiao.E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -6,right = 0,top = 2,bottom = -13}})
	Item_hang.chengjiao.E:SetPoint("RIGHT",Item_hang.chengjiao,"RIGHT",0,0);
	Item_hang.chengjiao.E:SetFontObject(ChatFontNormal);
	Item_hang.chengjiao.E:SetMaxLetters(7)
	Item_hang.chengjiao.E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	Item_hang.chengjiao.E:SetScript("OnEnterPressed", function(self) 
 		local NWEdanjiaV=self:GetNumber();
 		local NewSELF=self:GetParent()
 		NewSELF.G:SetText(NWEdanjiaV);
		PIG["RaidRecord"]["ItemList"][self:GetID()][9]=NWEdanjiaV;
		UpdateItem(Item_Scroll_UI);
	end);
	Item_hang.chengjiao.E:SetScript("OnEditFocusLost", function(self)
		local NewSELF=self:GetParent()
		NewSELF.G:Show();
		NewSELF.bianji:Show();
		NewSELF.baocun:Hide();
		self:Hide();
	end);
	Item_hang.chengjiao.bianji = CreateFrame("Button",nil,Item_hang.chengjiao, "TruncatedButtonTemplate");
	Item_hang.chengjiao.bianji:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	Item_hang.chengjiao.bianji:SetSize(hang_Height-8,hang_Height-8);
	Item_hang.chengjiao.bianji:SetPoint("LEFT", Item_hang.chengjiao, "RIGHT", -2,0);
	Item_hang.chengjiao.bianji.Tex = Item_hang.chengjiao.bianji:CreateTexture(nil, "BORDER");
	Item_hang.chengjiao.bianji.Tex:SetTexture("interface/buttons/ui-guildbutton-publicnote-up.blp");
	Item_hang.chengjiao.bianji.Tex:SetPoint("CENTER");
	Item_hang.chengjiao.bianji.Tex:SetSize(hang_Height-16,hang_Height-14);
	Item_hang.chengjiao.bianji:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.5,-1.5);
	end);
	Item_hang.chengjiao.bianji:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	Item_hang.chengjiao.bianji:SetScript("OnClick", function (self)
		local NewSELF=self:GetParent()
		for xxx=1,hang_NUM do
			_G["Item_hang_"..xxx.."_UI"].chengjiao.E:ClearFocus();
			_G["Item_hang_"..xxx.."_UI"].Qiankuan.E:ClearFocus()
		end
		NewSELF.G:Hide();
		NewSELF.bianji:Hide();
		NewSELF.baocun:Show();
		NewSELF.E:Show();
 		NewSELF.E:SetText(PIG["RaidRecord"]["ItemList"][self:GetID()][9]);
	end);
	Item_hang.chengjiao.baocun = CreateFrame("Button",nil,Item_hang.chengjiao, "UIPanelButtonTemplate");
	Item_hang.chengjiao.baocun:SetSize(hang_Height,hang_Height-10);
	Item_hang.chengjiao.baocun:SetPoint("LEFT", Item_hang.chengjiao, "RIGHT", 2,0);
	Item_hang.chengjiao.baocun:Hide();
	Item_hang.chengjiao.baocun:SetText('确定');
	local buttonFont=Item_hang.chengjiao.baocun:GetFontString()
	buttonFont:SetFont(ChatFontNormal:GetFont(), 12);
	Item_hang.chengjiao.baocun:SetScript("OnClick", function (self)
 		local NWEdanjiaV=_G["Item_hang_"..id.."_UI"].chengjiao.E:GetNumber();
 		_G["Item_hang_"..id.."_UI"].chengjiao.G:SetText(NWEdanjiaV);
		PIG["RaidRecord"]["ItemList"][self:GetID()][9]=NWEdanjiaV;
		UpdateItem(Item_Scroll_UI);
	end);

	-----欠款-----
	Item_hang.Qiankuan = CreateFrame("Frame", nil, Item_hang);
	Item_hang.Qiankuan:SetSize(70, hang_Height);
	Item_hang.Qiankuan:SetPoint("LEFT", Item_hang, "LEFT", 510,0);
	Item_hang.Qiankuan.G = Item_hang.Qiankuan:CreateFontString();
	Item_hang.Qiankuan.G:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	Item_hang.Qiankuan.G:SetPoint("RIGHT", Item_hang.Qiankuan, "RIGHT", 0,0);
	Item_hang.Qiankuan.G:SetTextColor(252/255, 69/255, 0/255, 1);
	Item_hang.Qiankuan.E = CreateFrame('EditBox', nil, Item_hang.Qiankuan, "BackdropTemplate");
	Item_hang.Qiankuan.E:SetSize(60,hang_Height);
	Item_hang.Qiankuan.E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -6,right = 0,top = 2,bottom = -13}})
	Item_hang.Qiankuan.E:SetPoint("RIGHT",Item_hang.Qiankuan,"RIGHT",0,0);
	Item_hang.Qiankuan.E:SetFontObject(ChatFontNormal);
	Item_hang.Qiankuan.E:SetMaxLetters(7)
	Item_hang.Qiankuan.E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	Item_hang.Qiankuan.E:SetScript("OnEnterPressed", function(self) 
		local NWEdanjiaV=self:GetNumber();
 		local NewSELF=self:GetParent()
 		NewSELF.G:SetText(NWEdanjiaV);
		PIG["RaidRecord"]["ItemList"][self:GetID()][14]=NWEdanjiaV;
		UpdateItem(Item_Scroll_UI);
	end);
	Item_hang.Qiankuan.E:SetScript("OnEditFocusLost", function(self)
		local NewSELF=self:GetParent()
		NewSELF.G:Show();
		NewSELF.bianji:Show();
		NewSELF.baocun:Hide();
		self:Hide();
	end);
	Item_hang.Qiankuan.bianji = CreateFrame("Button","Item_hang.Qiankuan.bianji_"..id.."_UI",Item_hang.Qiankuan, "TruncatedButtonTemplate");
	Item_hang.Qiankuan.bianji:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	Item_hang.Qiankuan.bianji:SetSize(hang_Height-8,hang_Height-8);
	Item_hang.Qiankuan.bianji:SetPoint("LEFT", Item_hang.Qiankuan, "RIGHT", -2,0);
	Item_hang.Qiankuan.bianji.Tex = Item_hang.Qiankuan.bianji:CreateTexture(nil, "BORDER");
	Item_hang.Qiankuan.bianji.Tex:SetTexture("interface/buttons/ui-guildbutton-publicnote-up.blp");
	Item_hang.Qiankuan.bianji.Tex:SetPoint("CENTER");
	Item_hang.Qiankuan.bianji.Tex:SetSize(hang_Height-16,hang_Height-14);
	Item_hang.Qiankuan.bianji:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.5,-1.5);
	end);
	Item_hang.Qiankuan.bianji:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	Item_hang.Qiankuan.bianji:SetScript("OnClick", function (self)
		local NewSELF=self:GetParent()
		for xxx=1,hang_NUM do
			_G["Item_hang_"..xxx.."_UI"].chengjiao.E:ClearFocus();
			_G["Item_hang_"..xxx.."_UI"].Qiankuan.E:ClearFocus()
		end
		NewSELF.G:Hide();
		NewSELF.bianji:Hide();
		NewSELF.baocun:Show();
		NewSELF.E:Show();
 		NewSELF.E:SetText(PIG["RaidRecord"]["ItemList"][self:GetID()][14]);
	end);
	Item_hang.Qiankuan.baocun = CreateFrame("Button",nil,Item_hang.Qiankuan, "UIPanelButtonTemplate");
	Item_hang.Qiankuan.baocun:SetSize(hang_Height,hang_Height-10);
	Item_hang.Qiankuan.baocun:SetPoint("LEFT", Item_hang.Qiankuan, "RIGHT", 2,0);
	Item_hang.Qiankuan.baocun:Hide();
	Item_hang.Qiankuan.baocun:SetText('确定');
	local buttonFont=Item_hang.Qiankuan.baocun:GetFontString()
	buttonFont:SetFont(ChatFontNormal:GetFont(), 12);
	Item_hang.Qiankuan.baocun:SetScript("OnClick", function (self)
		local NWEdanjiaV=_G["Item_hang_"..id.."_UI"].Qiankuan.E:GetNumber();
 		_G["Item_hang_"..id.."_UI"].Qiankuan.G:SetText(NWEdanjiaV);
		PIG["RaidRecord"]["ItemList"][self:GetID()][14]=NWEdanjiaV;
		UpdateItem(Item_Scroll_UI);
	end);

	Item_hang.ChengjiaoRen = CreateFrame("Button", nil, Item_hang);
	Item_hang.ChengjiaoRen:SetSize(94,hang_Height);
	Item_hang.ChengjiaoRen:SetPoint("LEFT", Item_hang, "LEFT", 616,0);
	Item_hang.ChengjiaoRen.T = Item_hang.ChengjiaoRen:CreateFontString();
	Item_hang.ChengjiaoRen.T:SetPoint("LEFT", Item_hang.ChengjiaoRen, "LEFT",0,0);
	Item_hang.ChengjiaoRen.T:SetFont(ChatFontNormal:GetFont(), 13.6, "OUTLINE");
	Item_hang.ChengjiaoRen:SetScript("OnMouseDown", function (self)
		self.T:SetPoint("LEFT", self, "LEFT",1.5,-1.5);
	end);
	Item_hang.ChengjiaoRen:SetScript("OnMouseUp", function (self)
		self.T:SetPoint("LEFT", self, "LEFT",0,0);
	end);
	Item_hang.ChengjiaoRen:SetScript("OnClick", function (self)
		if xuanzeChengjiaoren_UI:IsShown() then
			xuanzeChengjiaoren_UI:Hide() 
		else
			local NewSELF=self:GetParent()
			xuanzeChengjiaoren_UI:Show()
			xuanzeChengjiaoren_UI.T2:SetText(NewSELF.item.link:GetText())
			xuanzeChengjiaoren_UI.T4:SetText(self:GetID())
			UpdateChengjiaorenxuanze()
		end
	end);

	-----------
	Item_hang.del = CreateFrame("Button",nil,Item_hang, "TruncatedButtonTemplate");
	Item_hang.del:SetSize(hang_Height-14,hang_Height-14);
	Item_hang.del:SetPoint("RIGHT", Item_hang, "RIGHT", -4,0);
	Item_hang.del.Tex = Item_hang.del:CreateTexture(nil, "BORDER");
	Item_hang.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
	Item_hang.del.Tex:SetPoint("CENTER");
	Item_hang.del.Tex:SetSize(hang_Height-20,hang_Height-20)
	Item_hang.del:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1.5,-1.5);
	end);
	Item_hang.del:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	Item_hang.del:SetScript("OnClick", function (self)
		tishi_UI.nr.hei:Hide()
		tishi_UI.nr.hebi:Hide()
		tishi_UI.nr.chaif:Hide()
		tishi_UI:Show();
		tishi_UI.nr.del:Show()
		tishi_UI.nr.bianjiID:SetText(self:GetID());
		tishi_UI.nr.bianjiN:SetText("del");
		tishi_UI.nr.del.T1:SetText(PIG["RaidRecord"]["ItemList"][self:GetID()][2].."\n");	
	end);
end
--=成交人选择==================
local xuanzeChengjiaoren = CreateFrame("Frame", "xuanzeChengjiaoren_UI", fuFrame,"BackdropTemplate");
xuanzeChengjiaoren:SetBackdrop( { bgFile = "interface/raidframe/ui-raidframe-groupbg.blp",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = false, tileSize = 0, edgeSize = 10, 
	insets = { left = 0, right = 0, top = 0, bottom = 0 } });
xuanzeChengjiaoren:SetSize(Width-228,Height-12);
xuanzeChengjiaoren:SetPoint("TOPRIGHT",item_biaoti_5,"TOPLEFT",-12,-0);
xuanzeChengjiaoren:SetFrameLevel(10)
xuanzeChengjiaoren:EnableMouse(true)
xuanzeChengjiaoren:Hide()
xuanzeChengjiaoren.Close = CreateFrame("Button",nil,xuanzeChengjiaoren, "UIPanelCloseButton");  
xuanzeChengjiaoren.Close:SetSize(30,30);
xuanzeChengjiaoren.Close:SetPoint("TOPRIGHT",xuanzeChengjiaoren,"TOPRIGHT",2.4,3);
xuanzeChengjiaoren.T1 = xuanzeChengjiaoren:CreateFontString();
xuanzeChengjiaoren.T1:SetPoint("TOPLEFT",xuanzeChengjiaoren,"TOPLEFT",30,-8);
xuanzeChengjiaoren.T1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
xuanzeChengjiaoren.T1:SetText("\124cffFFff00选择【\124r")
xuanzeChengjiaoren.T2 = xuanzeChengjiaoren:CreateFontString();
xuanzeChengjiaoren.T2:SetPoint("LEFT",xuanzeChengjiaoren.T1,"RIGHT",0,0);
xuanzeChengjiaoren.T2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
xuanzeChengjiaoren.T2:SetText()
xuanzeChengjiaoren.T3 = xuanzeChengjiaoren:CreateFontString();
xuanzeChengjiaoren.T3:SetPoint("LEFT",xuanzeChengjiaoren.T2,"RIGHT",0,0);
xuanzeChengjiaoren.T3:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
xuanzeChengjiaoren.T3:SetText("\124cffFFff00】成交人\124r")
xuanzeChengjiaoren.T4 = xuanzeChengjiaoren:CreateFontString();
xuanzeChengjiaoren.T4:SetPoint("LEFT",xuanzeChengjiaoren.T3,"RIGHT",0,0);
xuanzeChengjiaoren.T4:SetFont(ChatFontNormal:GetFont(), 1, "OUTLINE");
xuanzeChengjiaoren.T4:SetText()
xuanzeChengjiaoren.T4:Hide()
xuanzeChengjiaoren.qingchu = CreateFrame("Button",nil,xuanzeChengjiaoren, "UIPanelButtonTemplate");  
xuanzeChengjiaoren.qingchu:SetSize(94,22);
xuanzeChengjiaoren.qingchu:SetPoint("TOPLEFT",xuanzeChengjiaoren,"TOPLEFT",300,-4);
xuanzeChengjiaoren.qingchu:SetText("清除成交人");
xuanzeChengjiaoren.qingchu:SetScript("OnClick", function ()
	PIG["RaidRecord"]["ItemList"][tonumber(xuanzeChengjiaoren.T4:GetText())][8]="无";
	UpdateItem(Item_Scroll_UI);
	xuanzeChengjiaoren_UI:Hide()
end);
--
local duiwuW,duiwuH = 120,30;
local jiangeW,jiangeH,juesejiangeH = 12,0,6;
for p=1,8 do
	local chengjiaoren = CreateFrame("Frame", "chengjiaoren_"..p, xuanzeChengjiaoren);
	chengjiaoren:SetSize(duiwuW,duiwuH*5+juesejiangeH*4);
	if p==1 then
		chengjiaoren:SetPoint("TOPLEFT",xuanzeChengjiaoren,"TOPLEFT",16,-34);
	end
	if p>1 and p<5 then
		chengjiaoren:SetPoint("LEFT",_G["chengjiaoren_"..(p-1)],"RIGHT",jiangeW,jiangeH);
	end
	if p==5 then
		chengjiaoren:SetPoint("TOP",_G["chengjiaoren_1"],"BOTTOM",0,-26);
	end
	if p>5 then
		chengjiaoren:SetPoint("LEFT",_G["chengjiaoren_"..(p-1)],"RIGHT",jiangeW,jiangeH);
	end
	for pp=1,5 do
		chengjiaoren.player = CreateFrame("Frame", "chengjiaoren_"..p.."_"..pp, chengjiaoren,"BackdropTemplate");
		chengjiaoren.player:SetBackdrop( { edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 10, insets = { left = 0, right = 0, top = 0, bottom = 0 } });
		chengjiaoren.player:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
		chengjiaoren.player:SetSize(duiwuW,duiwuH);
		if pp==1 then
			chengjiaoren.player:SetPoint("TOP",chengjiaoren,"TOP",0,0);
		else
			chengjiaoren.player:SetPoint("TOP",_G["chengjiaoren_"..p.."_"..(pp-1)],"BOTTOM",0,-juesejiangeH);
		end
		chengjiaoren.player.highlight = chengjiaoren.player:CreateTexture(self, "BORDER");
		chengjiaoren.player.highlight:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight.blp");
		chengjiaoren.player.highlight:SetBlendMode("ADD")
		chengjiaoren.player.highlight:SetPoint("CENTER", chengjiaoren.player, "CENTER", 0,0);
		chengjiaoren.player.highlight:SetSize(duiwuW,duiwuH);
		chengjiaoren.player.highlight:Hide();
		chengjiaoren.player:SetScript("OnEnter", function (self)
			self.highlight:Show();
		end);
		chengjiaoren.player:SetScript("OnLeave", function (self)
			self.highlight:Hide();
		end);
		chengjiaoren.player.Name = chengjiaoren.player:CreateFontString();
		chengjiaoren.player.Name:SetPoint("CENTER",chengjiaoren.player,"CENTER",0,1);
		chengjiaoren.player.Name:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");
		chengjiaoren.player.Name:SetText()
		chengjiaoren.player.Name:Hide()
		chengjiaoren.player.Name_XS = chengjiaoren.player:CreateFontString();
		chengjiaoren.player.Name_XS:SetPoint("CENTER",chengjiaoren.player,"CENTER",0,1);
		chengjiaoren.player.Name_XS:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");
		chengjiaoren.player.Name_XS:SetText()
		chengjiaoren.player:SetScript("OnMouseDown", function (self)
			self.Name_XS:SetPoint("CENTER",self,"CENTER",1.5,-0.5);
		end);
		chengjiaoren.player:SetScript("OnMouseUp", function (self)
			self.Name_XS:SetPoint("CENTER",self,"CENTER",0,1);
			PIG["RaidRecord"]["ItemList"][tonumber(xuanzeChengjiaoren.T4:GetText())][8]=self.Name:GetText();
			UpdateItem(Item_Scroll_UI);
			xuanzeChengjiaoren_UI:Hide()
		end);
	end
end
--======================================================
--弹窗提示
local tishiUI = CreateFrame("Frame", "tishi_UI", fuFrame);
tishiUI:SetSize(Width, Height);
tishiUI:SetPoint("TOP",fuFrame,"TOP",0,0);
tishiUI:EnableMouse(true);
tishiUI:SetFrameLevel(10);
tishiUI:Hide();
tishiUI.nr = CreateFrame("Frame", nil, tishiUI,"BackdropTemplate");
tishiUI.nr:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp", 
	edgeFile = "interface/glues/common/textpanel-border.blp", 
	tile = true, tileSize = 0, edgeSize = 32,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
tishiUI.nr:SetSize(300,200);
tishiUI.nr:SetPoint("TOP",tishiUI,"TOP",0,0);
tishiUI.nr.Close = CreateFrame("Button",nil,tishiUI, "UIPanelCloseButton");  
tishiUI.nr.Close:SetSize(32,32);
tishiUI.nr.Close:SetPoint("TOPRIGHT", tishiUI.nr, "TOPRIGHT", 0, 0);
tishiUI.nr.YES = CreateFrame("Button",nil,tishiUI.nr, "UIPanelButtonTemplate");  
tishiUI.nr.YES:SetSize(60,28);
tishiUI.nr.YES:SetPoint("TOP",tishiUI.nr,"TOP",-50,-144);
tishiUI.nr.YES:SetText("确定");
tishiUI.nr.YES:SetScript("OnClick", function()
	local bianjiIDX=tonumber(tishi_UI.nr.bianjiID:GetText());
	local hejishuju = PIG["RaidRecord"]["ItemList"]
	local bianjileixing=tishi_UI.nr.bianjiN:GetText()
	if bianjileixing=="del" then
		table.remove(hejishuju,bianjiIDX);
	elseif bianjileixing=="hei" then
		local paichumulu = PIG["RaidRecord"]["ItemList_Paichu"]
		for i=1,#paichumulu do
			if bianjiIDX==paichumulu[i] then
				print("|cff00FFFF!Pig:|r|cffffFF00物品已在目录内！|r");
				return
			end
		end
		table.insert(paichumulu, bianjiIDX);
		for x=#hejishuju,1,-1 do
			if bianjiIDX==hejishuju[x][11] then
				table.remove(hejishuju, x);
			end
		end
	elseif bianjileixing=="hebi" then
		--统计数量
		local hebingwupinzongshuliang = {0,0}
		for i=1,#hejishuju do
			if hejishuju[bianjiIDX][11]==hejishuju[i][11] then
				hebingwupinzongshuliang[1]=hebingwupinzongshuliang[1]+hejishuju[i][3]
				if hebingwupinzongshuliang[2]==0 then
					hebingwupinzongshuliang[2]=i
				end
			end
		end
		--删除除第一个之外的所有相同
		for i=#hejishuju,1,-1 do
			if hejishuju[bianjiIDX][11]==hejishuju[i][11] then
				if hebingwupinzongshuliang[2]~=i then
					table.remove(hejishuju,i);
				end
			end
		end
		hejishuju[hebingwupinzongshuliang[2]][3]=hebingwupinzongshuliang[1]
	elseif bianjileixing=="chaif" then
		local fengeshux=tishi_UI.nr.chaif.Slider:GetValue()
		if hejishuju[bianjiIDX][3]>1 then
			hejishuju[bianjiIDX][3]=hejishuju[bianjiIDX][3]-fengeshux
			--1时间/2物品/3数量/4拾取人/5品质/6icon/7已拍卖/8成交人/9成交价/10成交时间/11ID/12交易倒计时/13通报结束/14欠款
			local item1=hejishuju[bianjiIDX][1]
			local item2=hejishuju[bianjiIDX][2]
			local item4=hejishuju[bianjiIDX][4]
			local item5=hejishuju[bianjiIDX][5]
			local item6=hejishuju[bianjiIDX][6]
			local item11=hejishuju[bianjiIDX][11]
			local iteminfo={item1,item2,fengeshux,item4,item5,item6,0,"无",0,0,item11,true,true,0};
			table.insert(hejishuju,bianjiIDX+1,iteminfo)
		end
	end
	UpdateItem(Item_Scroll_UI);
	tishi_UI:Hide();
end);
tishiUI.nr.NO = CreateFrame("Button","tishiUI.nr.NO_UI",tishiUI.nr, "UIPanelButtonTemplate");  
tishiUI.nr.NO:SetSize(60,28);
tishiUI.nr.NO:SetPoint("TOP",tishiUI.nr,"TOP",50,-144);
tishiUI.nr.NO:SetText("取消");
tishiUI.nr.NO:SetScript("OnClick", function()
	tishi_UI:Hide();
end);

tishiUI.nr.bianjiID = tishiUI.nr:CreateFontString();
tishiUI.nr.bianjiID:SetFontObject(GameFontNormal);
tishiUI.nr.bianjiID:Hide();
tishiUI.nr.bianjiN = tishiUI.nr:CreateFontString();
tishiUI.nr.bianjiN:SetFontObject(GameFontNormal);
tishiUI.nr.bianjiN:Hide();
--删除
tishiUI.nr.del = CreateFrame("Frame", nil, tishiUI.nr,"BackdropTemplate");
tishiUI.nr.del:SetPoint("TOPLEFT",tishiUI,"TOPLEFT",0,0);
tishiUI.nr.del:SetPoint("BOTTOMRIGHT",tishiUI,"BOTTOMRIGHT",0,0);
tishiUI.nr.del.T0 = tishiUI.nr.del:CreateFontString();
tishiUI.nr.del.T0:SetPoint("TOP", tishiUI.nr.del, "TOP", 0,-12);
tishiUI.nr.del.T0:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
tishiUI.nr.del.T0:SetText("确定要\124cffff0000删除\124r\n");
tishiUI.nr.del.T1 = tishiUI.nr.del:CreateFontString();
tishiUI.nr.del.T1:SetPoint("TOP", tishiUI.nr.del, "TOP", 0,-40);
tishiUI.nr.del.T1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
tishiUI.nr.del.T2 = tishiUI.nr.del:CreateFontString();
tishiUI.nr.del.T2:SetPoint("TOP", tishiUI.nr.del, "TOP", 0,-70);
tishiUI.nr.del.T2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
tishiUI.nr.del.T2:SetText("的拾取记录吗?");
--加入拾取黑名单
tishiUI.nr.hei = CreateFrame("Frame", nil, tishiUI.nr,"BackdropTemplate");
tishiUI.nr.hei:SetPoint("TOPLEFT",tishiUI,"TOPLEFT",0,0);
tishiUI.nr.hei:SetPoint("BOTTOMRIGHT",tishiUI,"BOTTOMRIGHT",0,0);
tishiUI.nr.hei.T0 = tishiUI.nr.hei:CreateFontString();
tishiUI.nr.hei.T0:SetPoint("TOP", tishiUI.nr.hei, "TOP", 0,-12);
tishiUI.nr.hei.T0:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
tishiUI.nr.hei.T0:SetText("确定要把\n");
tishiUI.nr.hei.T1 = tishiUI.nr.hei:CreateFontString();
tishiUI.nr.hei.T1:SetPoint("TOP", tishiUI.nr.hei, "TOP", 0,-40);
tishiUI.nr.hei.T1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
tishiUI.nr.hei.T2 = tishiUI.nr.hei:CreateFontString();
tishiUI.nr.hei.T2:SetPoint("TOP", tishiUI.nr.hei, "TOP", 0,-70);
tishiUI.nr.hei.T2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
tishiUI.nr.hei.T2:SetText("加入到\124cffffFF00拾取黑名单\124r吗?\n\n\124cff00FF00后续拾取此物品将不会记录,\n可在设置内的\124r|cffffFF00拾取黑名单|r\124cff00FF00管理。\124r");
--合并物品
tishiUI.nr.hebi = CreateFrame("Frame", nil, tishiUI.nr,"BackdropTemplate");
tishiUI.nr.hebi:SetPoint("TOPLEFT",tishiUI,"TOPLEFT",0,0);
tishiUI.nr.hebi:SetPoint("BOTTOMRIGHT",tishiUI,"BOTTOMRIGHT",0,0);
tishiUI.nr.hebi.T0 = tishiUI.nr.hebi:CreateFontString();
tishiUI.nr.hebi.T0:SetPoint("TOP", tishiUI.nr.hebi, "TOP", 0,-12);
tishiUI.nr.hebi.T0:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
tishiUI.nr.hebi.T0:SetText("确定要合并列表中的所有\n");
tishiUI.nr.hebi.T1 = tishiUI.nr.hebi:CreateFontString();
tishiUI.nr.hebi.T1:SetPoint("TOP", tishiUI.nr.hebi, "TOP", 0,-40);
tishiUI.nr.hebi.T1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
tishiUI.nr.hebi.T2 = tishiUI.nr.hebi:CreateFontString();
tishiUI.nr.hebi.T2:SetPoint("TOP", tishiUI.nr.hebi, "TOP", 0,-70);
tishiUI.nr.hebi.T2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
tishiUI.nr.hebi.T2:SetText("到一条记录吗？");
--拆分物品
tishiUI.nr.chaif = CreateFrame("Frame", nil, tishiUI.nr,"BackdropTemplate");
tishiUI.nr.chaif:SetPoint("TOPLEFT",tishiUI,"TOPLEFT",0,0);
tishiUI.nr.chaif:SetPoint("BOTTOMRIGHT",tishiUI,"BOTTOMRIGHT",0,0);
tishiUI.nr.chaif.T0 = tishiUI.nr.chaif:CreateFontString();
tishiUI.nr.chaif.T0:SetPoint("TOP", tishiUI.nr.chaif, "TOP", 0,-12);
tishiUI.nr.chaif.T0:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
tishiUI.nr.chaif.T0:SetText("拆分\n");
tishiUI.nr.chaif.T1 = tishiUI.nr.chaif:CreateFontString();
tishiUI.nr.chaif.T1:SetPoint("TOP", tishiUI.nr.chaif, "TOP", 0,-40);
tishiUI.nr.chaif.T1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");

tishiUI.nr.chaif.Slider = CreateFrame("Slider", nil, tishiUI.nr.chaif, "OptionsSliderTemplate")
tishiUI.nr.chaif.Slider:SetSize(140,16);
tishiUI.nr.chaif.Slider:SetPoint("TOP",tishiUI.nr.chaif.T1,"BOTTOM",0,-40);
tishiUI.nr.chaif.Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整拆分数量';
tishiUI.nr.chaif.Slider.Low:SetText('1');
tishiUI.nr.chaif.Slider.High:SetText('1');
tishiUI.nr.chaif.Slider.Low:SetTextColor(0.6, 0.6, 0.6, 0.6);
tishiUI.nr.chaif.Slider.High:SetTextColor(0.6, 0.6, 0.6, 0.6);
tishiUI.nr.chaif.Slider.Text:SetPoint("BOTTOM", tishiUI.nr.chaif.Slider, "TOP", 34,-0);
tishiUI.nr.chaif.Slider.Text:SetFont(GameFontNormal:GetFont(), 20,"OUTLINE")
tishiUI.nr.chaif.Slider.Text:SetText('1');
tishiUI.nr.chaif.Slider:SetMinMaxValues(1, 1);
tishiUI.nr.chaif.Slider:SetValueStep(1);
tishiUI.nr.chaif.Slider:SetObeyStepOnDrag(true);
tishiUI.nr.chaif.Slider:SetValue(1);
tishiUI.nr.chaif.Slider:EnableMouseWheel(true);--接受滚轮输入
tishiUI.nr.chaif.Slider:SetScript("OnMouseWheel", function(self, arg1)
	local sliderMin, sliderMax = self:GetMinMaxValues()
	local value = self:GetValue()
	if arg1 > 0 then
		self:SetValue(min(value + arg1, sliderMax))
	else
		self:SetValue(max(value + arg1, sliderMin))
	end
end)
--拖动滑块值事件
tishiUI.nr.chaif.Slider:SetScript('OnValueChanged', function(self)
	local val = self:GetValue()
	self.Text:SetText(val)
end)
tishiUI.nr.chaif.T2 = tishiUI.nr.chaif:CreateFontString();
tishiUI.nr.chaif.T2:SetPoint("RIGHT", tishiUI.nr.chaif.Slider.Text, "LEFT", 0,-0);
tishiUI.nr.chaif.T2:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
tishiUI.nr.chaif.T2:SetTextColor(1, 1, 0, 1);
tishiUI.nr.chaif.T2:SetText("拆分数量:");
--===============================================================================
--拍卖物品
local Paimai = CreateFrame("Frame", "Paimai_UI", fuFrame);
Paimai:SetSize(Width-300, Height);
Paimai:SetPoint("TOPRIGHT",fuFrame,"TOPRIGHT",0,0);
Paimai:EnableMouse(true);
Paimai:SetFrameLevel(10);
Paimai:Hide();
Paimai.zhedangpaimaibut = CreateFrame("Frame", nil, Paimai);
Paimai.zhedangpaimaibut:SetSize(38, Height);
Paimai.zhedangpaimaibut:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",0,0);
Paimai.zhedangpaimaibut:EnableMouse(true);

Paimai.nr = CreateFrame("Frame", nil, Paimai,"BackdropTemplate");
Paimai.nr:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp", 
	edgeFile = "interface/glues/common/textpanel-border.blp", 
	tile = true, tileSize = 0, edgeSize = 32,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
Paimai.nr:SetSize(364,280);
Paimai.nr:SetPoint("TOPLEFT",Paimai,"TOPLEFT",0,-4);

Paimai.nr.bianjiID = Paimai.nr:CreateFontString();
Paimai.nr.bianjiID:SetFontObject(GameFontNormal);
Paimai.nr.bianjiID:Hide();

Paimai.nr.biaoti = Paimai.nr:CreateFontString();
Paimai.nr.biaoti:SetPoint("TOP", Paimai.nr, "TOP", 0,-12);
Paimai.nr.biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
Paimai.nr.biaoti:SetText("拍卖物品：");

Paimai.nr.item_link = Paimai.nr:CreateFontString();
Paimai.nr.item_link:SetPoint("TOP", Paimai.nr, "TOP", 0,-50);
Paimai.nr.item_link:SetFont(ChatFontNormal:GetFont(), 18, "OUTLINE");
Paimai.nr.item_icon = Paimai.nr:CreateTexture("Paimai.nr.item_icon_UI", "BORDER");
Paimai.nr.item_icon:SetSize(30,30);
Paimai.nr.item_icon:SetPoint("RIGHT", Paimai.nr.item_link, "LEFT", -8,0);
Paimai.nr.item_X = Paimai.nr:CreateFontString();
Paimai.nr.item_X:SetPoint("LEFT", Paimai.nr.item_link, "RIGHT", 4,0);
Paimai.nr.item_X:SetFont(ChatFontNormal:GetFont(), 20, "OUTLINE");
Paimai.nr.item_X:SetText("\124cffffFF00x\124r");
Paimai.nr.item_NO = Paimai.nr:CreateFontString();
Paimai.nr.item_NO:SetPoint("LEFT", Paimai.nr.item_X, "RIGHT", 4,0);
Paimai.nr.item_NO:SetFont(ChatFontNormal:GetFont(), 24, "OUTLINE");
--
Paimai.nr.T1 = Paimai.nr:CreateFontString();
Paimai.nr.T1:SetPoint("TOPLEFT", Paimai.nr, "TOPLEFT", 70,-100);
Paimai.nr.T1:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
Paimai.nr.T1:SetText("起拍价：");
---起拍价
local jiagelist,morenqiV = {1,2,3,4,5,6,7,8,9},1;
Paimai.nr.qipaijia0 = CreateFrame("FRAME", nil, Paimai.nr, "UIDropDownMenuTemplate")
Paimai.nr.qipaijia0:SetPoint("LEFT",Paimai.nr.T1,"RIGHT", -10,-4)
UIDropDownMenu_SetWidth(Paimai.nr.qipaijia0, 50)
local function qipaijia0_Up()
	local info = UIDropDownMenu_CreateInfo()
	info.func = Paimai.nr.qipaijia0.SetValue
	for i=1,#jiagelist,1 do
	    info.text, info.arg1, info.checked = jiagelist[i], jiagelist[i],jiagelist[i] == morenqiV;
		UIDropDownMenu_AddButton(info)
	end 
end
function Paimai.nr.qipaijia0:SetValue(newValue)
	UIDropDownMenu_SetText(Paimai.nr.qipaijia0, newValue)	
	morenqiV=newValue
	CloseDropDownMenus()--关闭下拉
end
UIDropDownMenu_SetText(Paimai.nr.qipaijia0, morenqiV)--设定默认选中
UIDropDownMenu_Initialize(Paimai.nr.qipaijia0, qipaijia0_Up)--初始化
--起拍单位
local danwei,danweiV,morendanweiV = {"十","百","千","万","十万","百万"},{"0","00","000","0000","00000","000000"},"000";
Paimai.nr.qipaijia1 = CreateFrame("FRAME", nil, Paimai.nr, "UIDropDownMenuTemplate")
Paimai.nr.qipaijia1:SetPoint("LEFT",Paimai.nr.qipaijia0,"RIGHT",-30,0)
UIDropDownMenu_SetWidth(Paimai.nr.qipaijia1, 60)

local function qipaijia1_Up()
	local info = UIDropDownMenu_CreateInfo()
	info.func = Paimai.nr.qipaijia1.SetValue
	for i=1,#danweiV,1 do
	    info.text, info.arg1, info.checked = danwei[i], danweiV[i], danweiV[i] == morendanweiV;
		UIDropDownMenu_AddButton(info)
	end 
end
function Paimai.nr.qipaijia1:SetValue(newValue)
	for i=1,#danweiV,1 do
		if newValue==danweiV[i] then
			UIDropDownMenu_SetText(Paimai.nr.qipaijia1, danwei[i]);
		end
	end
	morendanweiV=newValue;
	CloseDropDownMenus();
end
UIDropDownMenu_SetText(Paimai.nr.qipaijia1, "千")--设定默认选中
UIDropDownMenu_Initialize(Paimai.nr.qipaijia1, qipaijia1_Up)--初始化

--单次加价----------------------------------------
Paimai.nr.T2 = Paimai.nr:CreateFontString();
Paimai.nr.T2:SetPoint("TOPLEFT", Paimai.nr, "TOPLEFT", 40,-150);
Paimai.nr.T2:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
Paimai.nr.T2:SetText("单次最低加价：");
---选择单次加价
local dancilist,dancimorenqiV = {1,2,3,4,5,6,7,8,9},1;
Paimai.nr.dancijia0 = CreateFrame("FRAME", nil, Paimai.nr, "UIDropDownMenuTemplate")
Paimai.nr.dancijia0:SetPoint("LEFT",Paimai.nr.T2,"RIGHT",-10,-4)
UIDropDownMenu_SetWidth(Paimai.nr.dancijia0, 50)
local function dancijia0_Up()
	local info = UIDropDownMenu_CreateInfo()
	info.func = Paimai.nr.dancijia0.SetValue
	for i=1,#dancilist,1 do
	    info.text, info.arg1, info.checked = dancilist[i], dancilist[i],dancilist[i] == dancimorenqiV;
		UIDropDownMenu_AddButton(info)
	end 
end
function Paimai.nr.dancijia0:SetValue(newValue)
	UIDropDownMenu_SetText(Paimai.nr.dancijia0, newValue)	
	dancimorenqiV=newValue
	CloseDropDownMenus()--关闭下拉
end
UIDropDownMenu_SetText(Paimai.nr.dancijia0, dancimorenqiV)--设定默认选中
UIDropDownMenu_Initialize(Paimai.nr.dancijia0, dancijia0_Up)--初始化
--选择单次加价单位
local dancidanwei,dancidanweiV,dancimorendanweiV = {"十","百","千","万","十万","百万"},{"0","00","000","0000","00000","000000"},"00";
Paimai.nr.dancijia1 = CreateFrame("FRAME", nil, Paimai.nr, "UIDropDownMenuTemplate")
Paimai.nr.dancijia1:SetPoint("LEFT",Paimai.nr.dancijia0,"RIGHT",-30,0)
UIDropDownMenu_SetWidth(Paimai.nr.dancijia1, 60)

local function dancijia1_Up()
	local info = UIDropDownMenu_CreateInfo()
	info.func = Paimai.nr.dancijia1.SetValue
	for i=1,#danweiV,1 do
	    info.text, info.arg1, info.checked = dancidanwei[i], dancidanweiV[i], dancidanweiV[i] == dancimorendanweiV;
		UIDropDownMenu_AddButton(info)
	end 
end
function Paimai.nr.dancijia1:SetValue(newValue)
	for i=1,#dancidanweiV,1 do
		if newValue==dancidanweiV[i] then
			UIDropDownMenu_SetText(Paimai.nr.dancijia1, dancidanwei[i]);
		end
	end
	dancimorendanweiV=newValue;
	CloseDropDownMenus();
end
UIDropDownMenu_SetText(Paimai.nr.dancijia1, "百")--设定默认选中
UIDropDownMenu_Initialize(Paimai.nr.dancijia1, dancijia1_Up)--初始化

--手动倒计时按钮
local fayanpindao="RAID";
local daojishi_SS=nil;
Paimai.nr.T5 = Paimai.nr:CreateFontString();
Paimai.nr.T5:SetPoint("TOPLEFT", Paimai.nr, "TOPLEFT", 100,-188);
Paimai.nr.T5:SetFont(ChatFontNormal:GetFont(), 22, "OUTLINE");
Paimai.nr.daojishi = CreateFrame("Button",nil,Paimai.nr, "UIPanelButtonTemplate");  
Paimai.nr.daojishi:SetSize(94,28);
Paimai.nr.daojishi:SetPoint("TOP",Paimai.nr,"TOP",0,-188);
Paimai.nr.daojishi:SetText("手动倒计时");
Paimai.nr.daojishi:Disable();
Paimai.nr.daojishi:SetScript("OnClick", function ()
	if daojishi_SS>0 then
		Paimai.nr.T5:SetText(daojishi_SS);
		SendChatMessage("拍卖结束倒计时："..daojishi_SS.."秒。", fayanpindao, nil);
		daojishi_SS=daojishi_SS-1;
	elseif daojishi_SS==0 then
		Paimai.nr.T5:SetText(daojishi_SS);
		SendChatMessage("拍卖结束倒计时："..daojishi_SS.."秒。", fayanpindao, nil);
		local wupin =Paimai.nr.item_link:GetText();
		Paimai.nr.daojishi:Disable();
		Paimai.nr.YES:SetText("拍卖完成");
		Paimai.nr.YES:Enable();
	end
end);
--重置倒计时
Paimai.nr.daojishi_RL = CreateFrame("Button",nil,Paimai.nr, "UIMenuButtonStretchTemplate");
Paimai.nr.daojishi_RL:SetSize(26,26);
Paimai.nr.daojishi_RL:SetPoint("LEFT",Paimai.nr.daojishi,"RIGHT",20,-0);
Paimai.nr.daojishi_RL:Hide();
Paimai.nr.daojishi_RL.tex = Paimai.nr.daojishi_RL:CreateTexture(nil, "BORDER");
Paimai.nr.daojishi_RL.tex:SetTexture("interface/buttons/ui-refreshbutton.blp");
Paimai.nr.daojishi_RL.tex:SetPoint("CENTER");
Paimai.nr.daojishi_RL.tex:SetSize(16,16);
Paimai.nr.daojishi_RL:SetScript("OnMouseDown", function (self)
	self.tex:SetPoint("CENTER",-1.4,-1.5);
end);
Paimai.nr.daojishi_RL:SetScript("OnMouseUp", function (self)
	self.tex:SetPoint("CENTER");
end);
Paimai.nr.daojishi_RL:SetScript("OnClick", function (self)
	daojishi_SS=5;
	Paimai.nr.T5:SetText(daojishi_SS);
	Paimai.nr.daojishi:Enable();
	Paimai.nr.YES:Disable();
end)
--拍卖开始按钮
Paimai.nr.YES = CreateFrame("Button",nil,Paimai.nr, "UIPanelButtonTemplate");  
Paimai.nr.YES:SetSize(120,30);
Paimai.nr.YES:SetPoint("TOP",Paimai.nr,"TOP",0,-228);
Paimai.nr.YES:SetText("开始拍卖");
Paimai.nr.YES:SetScript("OnClick", function (self)
	local wupinhang =tonumber(Paimai.nr.bianjiID:GetText());
	local wupin =PIG["RaidRecord"]["ItemList"][wupinhang]
	if Paimai.nr.YES:GetText()=="开始拍卖" then
		Paimai.nr.daojishi:Enable();
		Paimai.nr.daojishi_RL:Show();
		Paimai.nr.YES:SetText("拍买中...");
		Paimai.nr.YES:Disable();
		daojishi_SS=5;
		Paimai.nr.T5:SetText(daojishi_SS);
		local paimaiwupinxinxi="开始拍卖:"..wupin[2]..",数量:"..wupin[3].."。起拍价:"..morenqiV..morendanweiV..
		"G。单次最低加价："..dancimorenqiV..dancimorendanweiV.."G。";
		SendChatMessage(paimaiwupinxinxi, fayanpindao, nil);
	elseif Paimai.nr.YES:GetText()=="拍卖完成" then
		Paimai.nr.YES:SetText("开始拍卖");
		Paimai.nr.T5:SetText();
		SendChatMessage(wupin[2].."拍卖已结束。", fayanpindao, nil);
		PIG["RaidRecord"]["ItemList"][wupinhang][7]=1;--记录拍卖成功
		UpdateItem(Item_Scroll);
		Paimai.nr.daojishi_RL:Hide();
		Paimai:Hide();
	end
end);
--强制结束拍卖
Paimai.nr.qiangzhijieshu = CreateFrame("Button",nil,Paimai.nr, "UIPanelButtonTemplate");  
Paimai.nr.qiangzhijieshu:SetSize(68,20);
Paimai.nr.qiangzhijieshu:SetPoint("TOPRIGHT", Paimai.nr, "TOPRIGHT", -3, -2);
Paimai.nr.qiangzhijieshu:SetText("终止拍卖");
local JisuanPingjun_Font=Paimai.nr.qiangzhijieshu:GetFontString()
JisuanPingjun_Font:SetFont(ChatFontNormal:GetFont(), 11);
JisuanPingjun_Font:SetTextColor(0.8, 0.8, 0.8, 1);
Paimai.nr.qiangzhijieshu:SetScript("OnClick", function ()
	if Paimai.nr.YES:GetText()~="开始拍卖" then
		local wupinhang =tonumber(Paimai.nr.bianjiID:GetText());
		local wupin =PIG["RaidRecord"]["ItemList"][wupinhang]
		SendChatMessage(wupin[2].."拍卖非正常终止。", fayanpindao, nil);
	end
	Paimai.nr.YES:SetText("开始拍卖");
	Paimai.nr.YES:Enable();
	Paimai.nr.daojishi:Disable();
	Paimai.nr.T5:SetText();
	Paimai.nr.daojishi_RL:Hide();
	Paimai:Hide();
end);

--=============================================
--最低拾取品质
local pinzhiguolv = xiafangFrame_UI:CreateFontString("pinzhiguolv_UI");
pinzhiguolv:SetPoint("TOPLEFT",xiafangFrame_UI,"TOPLEFT",Width/3*2-22,-48);
pinzhiguolv:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
pinzhiguolv:SetText("\124cff00FF00最低记录品质：\124r");

local pinzhiName,pinzhiV = {"普通","\124cff1eff00优秀\124r","\124cff0070dd精良\124r","\124cffa335ee史诗\124r","\124cffff8000传说\124r","\124cffe6cc80神器\124r"},{1,2,3,4,5,6};
local pinzhiguolv_D = CreateFrame("FRAME", "pinzhiguolv_D_UI", xiafangFrame_UI, "UIDropDownMenuTemplate")
pinzhiguolv_D:SetPoint("LEFT",pinzhiguolv,"RIGHT",-16,-2)
UIDropDownMenu_SetWidth(pinzhiguolv_D, 80)

local function pinzhiguolv_Up()
	local info = UIDropDownMenu_CreateInfo()
	info.func = pinzhiguolv_D.SetValue
	for i=1,#pinzhiV,1 do
	    info.text, info.arg1, info.checked = pinzhiName[i], pinzhiV[i], pinzhiV[i] == PIG["RaidRecord"]["pinzhimoren"];
		UIDropDownMenu_AddButton(info)
	end 
end
function pinzhiguolv_D:SetValue(newValue)
	for i=1,#pinzhiV,1 do
		if newValue==pinzhiV[i] then
			UIDropDownMenu_SetText(pinzhiguolv_D, pinzhiName[i]);
		end
	end
	PIG["RaidRecord"]["pinzhimoren"]=newValue;
	CloseDropDownMenus();
end
--======================================================
local function zhixingtianjia(itemLink,LOOT_itemNO,shiquname,itemQuality,itemTexture,itemID)
					--1时间/2物品/3数量/4拾取人/5品质/6icon/7已拍卖/8成交人/9成交价/10成交时间/11ID/12交易倒计时/13通报结束/14欠款
	local iteminfo={GetServerTime(),itemLink,LOOT_itemNO,shiquname,itemQuality,itemTexture,0,"无",0,0,itemID,true,true,0};
	table.insert(PIG["RaidRecord"]["ItemList"],iteminfo);
	UpdateItem(Item_Scroll_UI);
end
--手动添加物品
hooksecurefunc("ChatFrame_OnHyperlinkShow",function(chatFrame, link, text, button)
	if RaidR_UI:IsShown() then
		local aShiftKeyIsDown = IsShiftKeyDown();
		if aShiftKeyIsDown and fuFrame:IsShown() then
			if PIG["RaidRecord"]["Rsetting"]["shoudongloot"]=="ON" then
				local shiwupin = link:find("item");
				if shiwupin then
					local itemID = GetItemInfoInstant(link);
					if #PIG["RaidRecord"]["ItemList"]==0 then
						local diname = GetRealZoneText();
						PIG["RaidRecord"]["instanceName"][1]=GetServerTime();
						PIG["RaidRecord"]["instanceName"][2]=diname;
					end
					
					local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
					itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent=GetItemInfo(itemID);
					if itemLink~=nil and itemQuality~=nil and itemTexture~=nil then
						local LOOT_itemNO,shiquname=1,"手动添加";
						zhixingtianjia(itemLink,LOOT_itemNO,shiquname,itemQuality,itemTexture,itemID)
					end
				end
			else
				print("|cff00FFFF!Pig:|r|cffFFFF00未开启手动添加物品，请在设置中开启！|r");
			end
		end
	end
end)
--=====================================================
--拾取记录添加到数组
local function AddItem(Link,shiquname)
	if #PIG["RaidRecord"]["ItemList"]==0 then
		local diname = GetRealZoneText();
		PIG["RaidRecord"]["instanceName"][1]=GetServerTime();
		PIG["RaidRecord"]["instanceName"][2]=diname;
	end
	local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
	itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent=GetItemInfo(Link);
	if itemQuality>=PIG["RaidRecord"]["pinzhimoren"] then
		local itemID = GetItemInfoInstant(Link);
		local Nkaishi=Link:find("x", 1)
		local LOOT_itemNO = 1;
		if Nkaishi then
			LOOT_itemNO = tonumber(Link:sub(Nkaishi+1,-4));
		end
		--过滤副本临时武器
		local renwuwupin = {22736,30311,30312,30313,30314,30316,30317,30318,30319,30320}
		for id=1,#renwuwupin do--任务物品
			if itemID==renwuwupin[id] then
				return;
			end
		end
		--过滤排除目录物品
		for id=1,#PIG["RaidRecord"]["ItemList_Paichu"] do 
			if itemID==PIG["RaidRecord"]["ItemList_Paichu"][id] then
				return;
			end
		end
		zhixingtianjia(itemLink,LOOT_itemNO,shiquname,itemQuality,itemTexture,itemID)
	end
end
local function shiqushijian(arg1,arg5)
	if string.match(arg1,"获得了")~=nil then
		AddItem(arg1,arg5);
	end
end
---注册事件
local ItemEvent = CreateFrame("Frame");
ItemEvent:SetScript("OnEvent",function (self,event,arg1,arg2,arg3,arg4,arg5)
	if event=="PLAYER_ENTERING_WORLD" then
		local inInstance, instanceType = IsInInstance()
		if inInstance and instanceType=="raid" then
			if #PIG["RaidRecord"]["ItemList"]==0 then
				PIG["RaidRecord"]["instanceName"][1]=GetServerTime();
				PIG["RaidRecord"]["instanceName"][2]=GetRealZoneText();
			else
				StaticPopup_Show ("NEW_WUPIN_LIST");
			end
		end
	end
	if event=="CHAT_MSG_LOOT" then
		local inInstance, instanceType = IsInInstance()
		if inInstance and instanceType=="raid" then
			shiqushijian(arg1,arg5)
		elseif inInstance and instanceType=="party" then
			if PIG["RaidRecord"]["Rsetting"]["wurenben"]=="ON" then
				shiqushijian(arg1,arg5)
			end
		elseif not inInstance and instanceType=="none" then
			if PIG["RaidRecord"]["Rsetting"]["fubenwai"]=="ON" then
				shiqushijian(arg1,arg5)
			end
		end
	end
end);
--=========================================
addonTable.RaidRecord_Item = function()
	UIDropDownMenu_SetText(pinzhiguolv_D, pinzhiName[PIG["RaidRecord"]["pinzhimoren"]])--默认品质默认选中
	UIDropDownMenu_Initialize(pinzhiguolv_D, pinzhiguolv_Up)--默认品质初始化
	if PIG["RaidRecord"]["Kaiqi"]=="ON" then
		--激活选项卡第一页
		Tablist_Tex_1:SetTexture("interface/paperdollinfoframe/ui-character-activetab.blp");
		Tablist_Tex_1:SetPoint("BOTTOM", Tablist_1_UI, "BOTTOM", 0,-2);
		Tablist_title_1:SetTextColor(1, 1, 1, 1);
		fuFrame:Show()
		--注册事件
		ItemEvent:RegisterEvent("PLAYER_ENTERING_WORLD");
		ItemEvent:RegisterEvent("CHAT_MSG_LOOT");
	end
end
--------------------------------------------