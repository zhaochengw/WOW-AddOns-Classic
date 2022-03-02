local _, addonTable = ...;
--================================
local hang_Height,hang_NUM  = 30, 12;

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
	local Width = SpllBuy_TabFrame_3:GetWidth()-20;
	----------------
	SpllBuy_TabFrame_3.title = SpllBuy_TabFrame_3:CreateFontString();
	SpllBuy_TabFrame_3.title:SetPoint("TOP", SpllBuy_TabFrame_3, "TOP", 0, -10);
	SpllBuy_TabFrame_3.title:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	SpllBuy_TabFrame_3.title:SetTextColor(0.8, 0.8, 0, 1);
	SpllBuy_TabFrame_3.title:SetText("自动购买物品角色独享");
	--滚动框架
	SpllBuy_TabFrame_3.Buy = CreateFrame("Frame", nil, SpllBuy_TabFrame_3,"BackdropTemplate")
	SpllBuy_TabFrame_3.Buy:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 14,insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	SpllBuy_TabFrame_3.Buy:SetSize(Width, hang_Height*12+10)
	SpllBuy_TabFrame_3.Buy:SetPoint("BOTTOM", SpllBuy_TabFrame_3, "BOTTOM", 0, 10)
	SpllBuy_TabFrame_3.Buy:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.5);
	SpllBuy_TabFrame_3.Buy.biaoti = SpllBuy_TabFrame_3.Buy:CreateFontString();
	SpllBuy_TabFrame_3.Buy.biaoti:SetPoint("BOTTOM", SpllBuy_TabFrame_3.Buy, "TOP", 0, -0);
	SpllBuy_TabFrame_3.Buy.biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	SpllBuy_TabFrame_3.Buy.biaoti:SetText("\124cffFFFF00自动购买目录\124r\124cff00FF00(拖拽物品到此)\124r");
	----创建可滚动区域
	SpllBuy_TabFrame_3.Buy.Scroll = CreateFrame("ScrollFrame",nil,SpllBuy_TabFrame_3.Buy, "FauxScrollFrameTemplate");  
	SpllBuy_TabFrame_3.Buy.Scroll:SetPoint("TOPLEFT",SpllBuy_TabFrame_3.Buy,"TOPLEFT",0,-5);
	SpllBuy_TabFrame_3.Buy.Scroll:SetPoint("BOTTOMRIGHT",SpllBuy_TabFrame_3.Buy,"BOTTOMRIGHT",-27,5);
	SpllBuy_TabFrame_3.Buy.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinBuylist)
	end)
	--创建行
	for id = 1, hang_NUM do
		local Buy = CreateFrame("Frame", "Buy_hang"..id, SpllBuy_TabFrame_3.Buy);
		Buy:SetSize(Width-36, hang_Height);
		if id==1 then
			Buy:SetPoint("TOP",SpllBuy_TabFrame_3.Buy.Scroll,"TOP",0,0);
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
		Buy.Cont = CreateFrame('EditBox', nil, Buy,"BackdropTemplate");
		Buy.Cont:SetSize(36,28);
		Buy.Cont:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -3,right = -0,top = 2,bottom = -13}})
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
			gengxinBuylist(SpllBuy_TabFrame_3.Buy.Scroll);
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
			gengxinBuylist(SpllBuy_TabFrame_3.Buy.Scroll);
		end);
	end
	SpllBuy_TabFrame_3.Buy:SetScript("OnShow", function()
		gengxinBuylist(SpllBuy_TabFrame_3.Buy.Scroll)
	end)
	---
	SpllBuy_TabFrame_3.Buy.ADD = CreateFrame("Frame",nil,SpllBuy_TabFrame_3.Buy);  
	SpllBuy_TabFrame_3.Buy.ADD:SetPoint("TOPLEFT",SpllBuy_TabFrame_3.Buy,"TOPLEFT",0,0);
	SpllBuy_TabFrame_3.Buy.ADD:SetPoint("BOTTOMRIGHT",SpllBuy_TabFrame_3.Buy,"BOTTOMRIGHT",0,0);
	---
	local Buy_iteminfo={};
	SpllBuy_TabFrame_3.Buy:RegisterEvent("ITEM_LOCK_CHANGED");
	SpllBuy_TabFrame_3.Buy:SetScript("OnEvent",function (self,event,arg1,arg2)
		if arg1 and arg2 then
			if CursorHasItem() then
				local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(arg1,arg2);
				if itemID then
					local _,_,_,_,_,_,_,itemStackCount= GetItemInfo(itemID) 
					Buy_iteminfo={icon, itemLink, itemID,itemStackCount,itemStackCount,};
					SpllBuy_TabFrame_3.Buy.ADD:SetFrameLevel(48);
				end
			end
		end
	end);
	SpllBuy_TabFrame_3.Buy.ADD:SetScript("OnMouseUp", function ()
		if CursorHasItem() then
			for i=1,#PIG_Per['AutoSellBuy']['BuyList'] do
				if Buy_iteminfo[3]==PIG_Per['AutoSellBuy']['BuyList'][i][3] then
					print("|cff00FFFF!Pig:|r|cffffFF00物品已在目录内！|r");
					ClearCursor();
					Buy_iteminfo={};
					SpllBuy_TabFrame_3.Buy.ADD:SetFrameLevel(40);
					return
				end			
			end
			table.insert(PIG_Per['AutoSellBuy']['BuyList'], Buy_iteminfo);
			ClearCursor();
			Buy_iteminfo={};
			gengxinBuylist(SpllBuy_TabFrame_3.Buy.Scroll)
		end
		SpllBuy_TabFrame_3.Buy.ADD:SetFrameLevel(40);
	end);

	-- --===========================================================
	SpllBuy_TabFrame_3.BuyCheck = CreateFrame("CheckButton",nil,SpllBuy_TabFrame_3, "ChatConfigCheckButtonTemplate");
	SpllBuy_TabFrame_3.BuyCheck:SetSize(28,30);
	SpllBuy_TabFrame_3.BuyCheck:SetHitRectInsets(0,-68,0,0);
	SpllBuy_TabFrame_3.BuyCheck:SetPoint("TOPLEFT",SpllBuy_TabFrame_3,"TOPLEFT",20,-30);
	SpllBuy_TabFrame_3.BuyCheck.Text:SetText("自动购买");
	SpllBuy_TabFrame_3.BuyCheck.tooltip = "打开商人界面自动购买下方目录指定物品！";
	SpllBuy_TabFrame_3.BuyCheck:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per["AutoSellBuy"]["BuyOpen"]="ON";
		else
			PIG_Per["AutoSellBuy"]["BuyOpen"]="OFF";
		end
	end);
	MerchantFrame:HookScript("OnEvent",function (self,event)
		if event=="MERCHANT_SHOW" then
			if SpllBuy_TabFrame_3.BuyCheck:GetChecked() then
				zidonggoumai();
			end
		end
	end);
end
-----------------------------------------------
addonTable.BuyPlus = function()
	PIG_Per["AutoSellBuy"]=PIG_Per["AutoSellBuy"] or addonTable.Default_Per["AutoSellBuy"]
	PIG_Per["AutoSellBuy"]["BuyOpen"]=PIG_Per["AutoSellBuy"]["BuyOpen"] or addonTable.Default_Per["AutoSellBuy"]["BuyOpen"]
	PIG_Per['AutoSellBuy']['BuyList']=PIG_Per['AutoSellBuy']['BuyList'] or addonTable.Default_Per['AutoSellBuy']['BuyList'];
	SellBuy_ADD()
	if PIG_Per["AutoSellBuy"]["BuyOpen"]=="ON" then
		SpllBuy_TabFrame_3.BuyCheck:SetChecked(true);
	end
end