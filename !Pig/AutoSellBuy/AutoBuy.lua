local _, addonTable = ...;
--================================
local _, _, _, tocversion = GetBuildInfo()
local hang_Height,hang_NUM  = 30, 14;
local FrameLevel=addonTable.SellBuyFrameLevel
local ADD_Checkbutton=addonTable.ADD_Checkbutton
-- --滚动更新目录
local function gengxinBuylist(self)
	for id = 1, hang_NUM do
		_G["Buy_hang"..id].item.icon:SetTexture();
		_G["Buy_hang"..id].item.link:SetText();
		_G["Buy_hang"..id].item:Hide();
		_G["Buy_hang"..id].Cont:Hide();
		_G["Buy_hang"..id].del:Hide();
    end
	if #PIG_Per['AutoSellBuy']['BuyList']>0 then
		local GOUMAIlist = #PIG_Per['AutoSellBuy']['BuyList'];
		FauxScrollFrame_Update(self, GOUMAIlist, hang_NUM, hang_Height);
		local offset = FauxScrollFrame_GetOffset(self);
	    for id = 1, hang_NUM do
	    	local dangqianH = id+offset;
	    	if PIG_Per['AutoSellBuy']['BuyList'][dangqianH] then
		    	_G["Buy_hang"..id].item.icon:SetTexture(PIG_Per['AutoSellBuy']['BuyList'][dangqianH][1]);
				_G["Buy_hang"..id].item.link:SetText(PIG_Per['AutoSellBuy']['BuyList'][dangqianH][2]);
				_G["Buy_hang"..id].item:Show();
				_G["Buy_hang"..id].item:SetScript("OnMouseDown", function (self)
					GameTooltip:ClearLines();
					GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
					GameTooltip:SetHyperlink(PIG_Per['AutoSellBuy']['BuyList'][dangqianH][2])
				end);
				_G["Buy_hang"..id].item:SetScript("OnMouseUp", function ()
					GameTooltip:ClearLines();
					GameTooltip:Hide() 
				end);
				if PIG_Per['AutoSellBuy']['BuyList'][dangqianH][5]==1 then
					_G["Buy_hang"..id].Cont:Disable();
				else
					_G["Buy_hang"..id].Cont:Enable();
				end
				_G["Buy_hang"..id].Cont:Show();
				_G["Buy_hang"..id].Cont:SetText(PIG_Per['AutoSellBuy']['BuyList'][dangqianH][4]);
				_G["Buy_hang"..id].del:Show();
				_G["Buy_hang"..id].del:SetID(dangqianH);
			end
		end
	end
end
--------------
local function goumaihanshu(i, ii, xuyaogoumaishu)
	if xuyaogoumaishu>PIG_Per['AutoSellBuy']['BuyList'][i][5] then
		BuyMerchantItem(ii,PIG_Per['AutoSellBuy']['BuyList'][i][5])
		xuyaogoumaishu=xuyaogoumaishu-PIG_Per['AutoSellBuy']['BuyList'][i][5]
		if xuyaogoumaishu>0 then
			goumaihanshu(i,ii,xuyaogoumaishu)
		end
	else
		BuyMerchantItem(ii, xuyaogoumaishu)
	end
end
--------------------------------
local function jisuanBAGshuliang(QitemID)
	local zongjiBAGitemCount=0
	if tocversion<100000 then
		for bag = 0, 4 do
			for slot = 1, GetContainerNumSlots(bag) do
				local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID= GetContainerItemInfo(bag, slot);
				if itemID then
					if QitemID==itemID then
						zongjiBAGitemCount=zongjiBAGitemCount+itemCount
					end
				end
			end
		end
	else
		for bag = 0, 4 do
			for slot = 1, C_Container.GetContainerNumSlots(bag) do
				local ItemInfo= C_Container.GetContainerItemInfo(bag, slot);
				if ItemInfo then
					if QitemID==ItemInfo.itemID then
						zongjiBAGitemCount=zongjiBAGitemCount+ItemInfo.stackCount
					end
				end
			end
		end
	end
	return zongjiBAGitemCount
end
---------------------------------
local function zidonggoumai()
	if ( MerchantFrame:IsVisible() and MerchantFrame.selectedTab == 1 ) then
		for i=1,#PIG_Per['AutoSellBuy']['BuyList'] do
			BUGINFO_itemCount=0
			local goumaiItem=PIG_Per['AutoSellBuy']['BuyList'][i][3]
			local xuyaogoumaishu=PIG_Per['AutoSellBuy']['BuyList'][i][4];--预设购买数
			local yiyoushuliang=jisuanBAGshuliang(goumaiItem);--已有数量
			local shijigoumai=xuyaogoumaishu-yiyoushuliang;--实际需要补货数量
			--print(shijigoumai)
			if shijigoumai>0 then
				local numItems = GetMerchantNumItems();
				for ii=1,numItems do
					if goumaiItem==GetMerchantItemID(ii) then
						local NPCshuliang = select(5, GetMerchantItemInfo(ii))
						if NPCshuliang==(-1) then
							goumaihanshu(i,ii,shijigoumai)
							print("|cFF00ffff!Pig|r |cFF00ff00执行自动补货:|r "..PIG_Per['AutoSellBuy']['BuyList'][i][2].." |cFF00ff00补货数量:|r"..shijigoumai);
						else
							if shijigoumai>NPCshuliang then
								BuyMerchantItem(ii,NPCshuliang)
								print("|cFF00ffff!Pig|r |cFF00ff00商家物品限购:|r "..PIG_Per['AutoSellBuy']['BuyList'][i][2].." |cFF00ff00抢购数量:|r"..NPCshuliang);
							else
								goumaihanshu(i,ii,shijigoumai)
								print("|cFF00ffff!Pig|r |cFF00ff00执行自动补货:|r "..PIG_Per['AutoSellBuy']['BuyList'][i][2].." |cFF00ff00补货数量:|r"..shijigoumai);
							end
						end	
					end
				end
			end		
		end
	end
end
---------
local function SellBuy_ADD()
	local fuFrame = SpllBuy_TabFrame_3;
	local Width = fuFrame:GetWidth()-20;
	----------------
	fuFrame.title = fuFrame:CreateFontString();
	fuFrame.title:SetPoint("TOP", fuFrame, "TOP", 0, -10);
	fuFrame.title:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.title:SetTextColor(1,20/255,147/255, 1);
	fuFrame.title:SetText("自动购买物品设置角色独享");
	--滚动框架
	fuFrame.Buy = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
	fuFrame.Buy:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 14,insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	fuFrame.Buy:SetSize(Width, hang_Height*hang_NUM+10)
	fuFrame.Buy:SetPoint("BOTTOM", fuFrame, "BOTTOM", 0, 10)
	fuFrame.Buy:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.5);
	fuFrame.Buy.biaoti = fuFrame.Buy:CreateFontString();
	fuFrame.Buy.biaoti:SetPoint("BOTTOM", fuFrame.Buy, "TOP", 0, -0);
	fuFrame.Buy.biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.Buy.biaoti:SetText("\124cffFFFF00购买目录\124r\124cff00FF00(拖拽物品到此)\124r");

	fuFrame.Buy.daochu = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");
	fuFrame.Buy.daochu:SetSize(50,20);
	fuFrame.Buy.daochu:SetPoint("LEFT",fuFrame.Buy.biaoti,"RIGHT",0,0);
	fuFrame.Buy.daochu:SetText("导出");
	local Config_daochu_UP=addonTable.Config_daochu_UP
	fuFrame.Buy.daochu:SetScript("OnClick", function(self, button)
		Config_daochu_UP(self,PIG_Per.AutoSellBuy.BuyList)
	end)

	fuFrame.Buy.daochu = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");
	fuFrame.Buy.daochu:SetSize(50,20);
	fuFrame.Buy.daochu:SetPoint("RIGHT",fuFrame.Buy.biaoti,"LEFT",0,0);
	fuFrame.Buy.daochu:SetText("导入");
	local Config_daoru_UP=addonTable.Config_daoru_UP
	fuFrame.Buy.daochu:SetScript("OnClick", function(self, button)
		Config_daoru_UP(self,"PIG_Per","AutoSellBuy~BuyList")
	end)
	----
	fuFrame.Buy.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.Buy, "FauxScrollFrameTemplate");  
	fuFrame.Buy.Scroll:SetPoint("TOPLEFT",fuFrame.Buy,"TOPLEFT",0,-5);
	fuFrame.Buy.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.Buy,"BOTTOMRIGHT",-27,5);
	fuFrame.Buy.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinBuylist)
	end)
	--创建行
	for id = 1, hang_NUM do
		local Buy = CreateFrame("Frame", "Buy_hang"..id, fuFrame.Buy);
		Buy:SetSize(Width-36, hang_Height);
		if id==1 then
			Buy:SetPoint("TOP",fuFrame.Buy.Scroll,"TOP",0,0);
		else
			Buy:SetPoint("TOP",_G["Buy_hang"..(id-1)],"BOTTOM",0,-0);
		end
		if id~=hang_NUM then
			local Buy_line = Buy:CreateLine()
			Buy_line:SetColorTexture(1,1,1,0.2)
			Buy_line:SetThickness(1);
			Buy_line:SetStartPoint("BOTTOMLEFT",0,0)
			Buy_line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		Buy.item = CreateFrame("Frame", nil, Buy);
		Buy.item:SetSize(Width-106,hang_Height);
		Buy.item:SetPoint("LEFT",Buy,"LEFT",24,0);
		Buy.item.icon = Buy.item:CreateTexture(nil, "BORDER");
		Buy.item.icon:SetSize(26,26);
		Buy.item.icon:SetPoint("LEFT", Buy.item, "LEFT", 0,0);
		Buy.item.link = Buy.item:CreateFontString();
		Buy.item.link:SetWidth(Width-110-26);
		Buy.item.link:SetPoint("LEFT", Buy.item, "LEFT", 30,0);
		Buy.item.link:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		Buy.item.link:SetJustifyH("LEFT");
		-------
		Buy.Cont = CreateFrame('EditBox', nil, Buy,"InputBoxInstructionsTemplate");
		Buy.Cont:SetSize(36,28);
		Buy.Cont:SetPoint("RIGHT", Buy, "RIGHT", 0,0);
		Buy.Cont:SetFontObject(ChatFontNormal);
		Buy.Cont:SetAutoFocus(false);
		Buy.Cont:SetMaxLetters(4)
		Buy.Cont:SetNumeric()
		Buy.Cont:SetScript("OnEscapePressed", function(self) 
			self:ClearFocus() 
		end);
		Buy.Cont:SetScript("OnEnterPressed", function(self) 
			self:ClearFocus() 
		end);
		Buy.Cont:SetScript("OnEditFocusLost", function(self)
			local NWEdanjiaV=self:GetNumber();
	 		self:SetText(NWEdanjiaV);
	 		local bianjiID=self:GetParent().del:GetID()
			PIG_Per['AutoSellBuy']['BuyList'][bianjiID][4]=NWEdanjiaV;
			gengxinBuylist(fuFrame.Buy.Scroll);
		end);
		----------
		Buy.del = CreateFrame("Button",nil, Buy, "TruncatedButtonTemplate");
		Buy.del:SetSize(20,20);
		Buy.del:SetPoint("LEFT", Buy, "LEFT", 0,0);
		Buy.del.Tex = Buy.del:CreateTexture(nil, "BORDER");
		Buy.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		Buy.del.Tex:SetPoint("CENTER");
		Buy.del.Tex:SetSize(13,13);
		Buy.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1.5,-1.5);
		end);
		Buy.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		Buy.del:SetScript("OnClick", function (self)
			self:GetParent().Cont:ClearFocus() 
			table.remove(PIG_Per['AutoSellBuy']['BuyList'], self:GetID());
			gengxinBuylist(fuFrame.Buy.Scroll);
		end);
	end
	fuFrame.Buy:SetScript("OnShow", function()
		gengxinBuylist(fuFrame.Buy.Scroll)
	end)
	---
	fuFrame.Buy.ADD = CreateFrame("Frame",nil,fuFrame.Buy);  
	fuFrame.Buy.ADD:SetPoint("TOPLEFT",fuFrame.Buy,"TOPLEFT",0,0);
	fuFrame.Buy.ADD:SetPoint("BOTTOMRIGHT",fuFrame.Buy,"BOTTOMRIGHT",0,0);
	---
	fuFrame.Buy:RegisterEvent("ITEM_LOCK_CHANGED");
	fuFrame.Buy:SetScript("OnEvent",function (self)
		if self:IsShown() then
			self.ADD:SetFrameLevel(FrameLevel+8);
		end
	end);
	fuFrame.Buy.ADD:SetScript("OnMouseUp", function (self)
		if CursorHasItem() then
			local NewType, ItemID, ItemLink= GetCursorInfo()
			for i=1,#PIG_Per['AutoSellBuy']['BuyList'] do
				if ItemLink==PIG_Per['AutoSellBuy']['BuyList'][i][2] then
					print("|cff00FFFF!Pig:|r|cffffFF00物品已在目录内！|r");
					ClearCursor();
					self:SetFrameLevel(FrameLevel);
					return
				end			
			end
			local icon = select(5,GetItemInfoInstant(ItemLink))
			local itemStackCount= select(8,GetItemInfo(ItemLink))
			table.insert(PIG_Per['AutoSellBuy']['BuyList'], {icon,ItemLink,ItemID,itemStackCount,itemStackCount});
			ClearCursor();
			gengxinBuylist(fuFrame.Buy.Scroll)
		end
		self:SetFrameLevel(FrameLevel);
	end);

	-- --===========================================================
	fuFrame.BuyCheck = ADD_Checkbutton(nil,fuFrame,-68,"TOPLEFT",fuFrame,"TOPLEFT",20,-30,"自动购买", "打开商人界面自动购买下方目录指定物品！")
	fuFrame.BuyCheck:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per["AutoSellBuy"]["BuyOpen"]="ON";
		else
			PIG_Per["AutoSellBuy"]["BuyOpen"]="OFF";
		end
	end);
	if PIG_Per["AutoSellBuy"]["BuyOpen"]=="ON" then
		fuFrame.BuyCheck:SetChecked(true);
	end
	MerchantFrame:HookScript("OnShow",function (self,event)
		if fuFrame.BuyCheck:GetChecked() then
			zidonggoumai();
		end
	end);
end
-----------------------------------------------
addonTable.BuyPlus = SellBuy_ADD