local _, addonTable = ...;

local hang_Height,hang_NUM  = 30, 14;
-------------
--卖灰色物品
local function shoumailaji()
	if not SpllBuy_TabFrame_2 then return end
	local fuFrame = SpllBuy_TabFrame_2;
	if ( MerchantFrame:IsVisible() and MerchantFrame.selectedTab == 1 ) then
		fuFrame.shoumaiG = 0;
		fuFrame.shoumaiShuliang = 0;
		for bag = 0, 4 do
			for slot = 1, GetContainerNumSlots(bag) do
				local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID= GetContainerItemInfo(bag, slot);
				if itemID then
					if noValue==false then
						if fuFrame.AutoSellLJ:GetChecked() then
							if quality==0 then
								local shifouzaipaichumuluYN=true
								-- for i=1,#PIG["AutoSellBuy"]["SellGuolv"] do
								-- 	if itemID==PIG["AutoSellBuy"]["SellGuolv"][i][3] then
								-- 		shifouzaipaichumuluYN=false
								-- 	end
								-- end
								if shifouzaipaichumuluYN then
									local name, link, rarity, level, minLevel, itemtype, subType, stackCount, equipLoc, icon, sellPrice = GetItemInfo(itemID);
									fuFrame.shoumaiG = sellPrice*itemCount+fuFrame.shoumaiG;
									UseContainerItem(bag, slot);
									print("|cFF7FFFAA出售|r: " ..link);
									fuFrame.shoumaiShuliang = fuFrame.shoumaiShuliang+1
								end
							end
						end
						--非灰
						if fuFrame.AutoSell_feihui:GetChecked() then
							for i=1,#PIG['AutoSellBuy']['AutoSell_List'] do
								if itemID==PIG['AutoSellBuy']['AutoSell_List'][i][3] then
									local name, link, rarity, level, minLevel, itemtype, subType, stackCount, equipLoc, icon, sellPrice = GetItemInfo(itemID);
									fuFrame.shoumaiG = sellPrice*itemCount+fuFrame.shoumaiG;
									UseContainerItem(bag, slot);
									print("|cFF7FFFAA出售|r: " ..link);
									fuFrame.shoumaiShuliang = fuFrame.shoumaiShuliang+1
								end
							end
						end
					end
				end
			end
		end
		if fuFrame.shoumaiG > 0 then
			print("|cFF00ffff!Pig|r|cFF7FFFAA本次售卖获得:|r " .. GetCoinTextureString(fuFrame.shoumaiG));
		end
		if fuFrame.shoumaiShuliang>=12 then 
			C_Timer.After(1,shoumailaji) 
		end
	end
end
--出售按钮
local function SellPlus_Open()
	if button_Sell_UI==nil then
		local button_Sell = CreateFrame("Button","button_Sell_UI",MerchantFrame, "UIPanelButtonTemplate");  
		button_Sell:SetSize(80,28);
		button_Sell:SetPoint("TOPLEFT",MerchantFrame,"TOPLEFT",60,-26);
		button_Sell:SetText("卖东西");
		button_Sell:SetScript("OnClick", function ()
			shoumailaji()
		end)
	end
end
-----------
local function sell_add(fuFrame)
	local Width = fuFrame:GetWidth()-20;
	--滚动框架
	fuFrame.Sell = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
	fuFrame.Sell:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 14,insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	fuFrame.Sell:SetSize(Width, hang_Height*hang_NUM+10)
	fuFrame.Sell:SetPoint("BOTTOM", fuFrame, "BOTTOM", 0, 10)
	fuFrame.Sell:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.5);
	fuFrame.Sell.biaoti = fuFrame.Sell:CreateFontString();
	fuFrame.Sell.biaoti:SetPoint("BOTTOM", fuFrame.Sell, "TOP", 0, -0);
	fuFrame.Sell.biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.Sell.biaoti:SetText("\124cffFFFF00自动出售目录\124r\124cff00FF00(拖拽物品到此)\124r");
	-- --滚动更新目录
	local function gengxinMulu(self)
		for id = 1, hang_NUM do
			_G["Guolv_hang"..id].item.icon:SetTexture();
			_G["Guolv_hang"..id].item.link:SetText();
			_G["Guolv_hang"..id].item:Hide();
			_G["Guolv_hang"..id].del:Hide();
	    end
		if #PIG['AutoSellBuy']['AutoSell_List']>0 then
			local paichushu = #PIG['AutoSellBuy']['AutoSell_List'];
			FauxScrollFrame_Update(self, paichushu, hang_NUM, hang_Height);
			local offset = FauxScrollFrame_GetOffset(self);
		    for id = 1, hang_NUM do
		    	local dangqianH = id+offset;
		    	if PIG['AutoSellBuy']['AutoSell_List'][dangqianH] then
			    	_G["Guolv_hang"..id].item.icon:SetTexture(PIG['AutoSellBuy']['AutoSell_List'][dangqianH][1]);
					_G["Guolv_hang"..id].item.link:SetText(PIG['AutoSellBuy']['AutoSell_List'][dangqianH][2]);
					_G["Guolv_hang"..id].item:Show();
					_G["Guolv_hang"..id].item:SetScript("OnMouseDown", function (self)
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
						GameTooltip:SetHyperlink(PIG['AutoSellBuy']['AutoSell_List'][dangqianH][2])
					end);
					_G["Guolv_hang"..id].item:SetScript("OnMouseUp", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
					_G["Guolv_hang"..id].del:Show();
					_G["Guolv_hang"..id].del:SetID(dangqianH);
				end
			end
		end
	end
	----创建可滚动区域
	fuFrame.Sell.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.Sell, "FauxScrollFrameTemplate");  
	fuFrame.Sell.Scroll:SetPoint("TOPLEFT",fuFrame.Sell,"TOPLEFT",0,-5);
	fuFrame.Sell.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.Sell,"BOTTOMRIGHT",-27,5);
	fuFrame.Sell.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinMulu)
	end)
	--创建行
	for id = 1, hang_NUM do
		local Guolv = CreateFrame("Frame", "Guolv_hang"..id, fuFrame.Sell);
		Guolv:SetSize(Width-36, hang_Height);
		if id==1 then
			Guolv:SetPoint("TOP",fuFrame.Sell.Scroll,"TOP",0,0);
		else
			Guolv:SetPoint("TOP",_G["Guolv_hang"..(id-1)],"BOTTOM",0,-0);
		end
		if id~=hang_NUM then
			local Guolv_line = Guolv:CreateLine()
			Guolv_line:SetColorTexture(1,1,1,0.2)
			Guolv_line:SetThickness(1);
			Guolv_line:SetStartPoint("BOTTOMLEFT",0,0)
			Guolv_line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		Guolv.item = CreateFrame("Frame", nil, Guolv);
		Guolv.item:SetSize(Width-70,hang_Height);
		Guolv.item:SetPoint("LEFT",Guolv,"LEFT",hang_Height,0);
		Guolv.item.icon = Guolv.item:CreateTexture(nil, "BORDER");
		Guolv.item.icon:SetSize(26,26);
		Guolv.item.icon:SetPoint("LEFT", Guolv.item, "LEFT", 0,0);
		Guolv.item.link = Guolv.item:CreateFontString();
		Guolv.item.link:SetPoint("LEFT", Guolv.item, "LEFT", 30,0);
		Guolv.item.link:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");

		Guolv.del = CreateFrame("Button",nil, Guolv, "TruncatedButtonTemplate");
		Guolv.del:SetSize(hang_Height,hang_Height);
		Guolv.del:SetPoint("LEFT", Guolv, "LEFT", 0,0);
		Guolv.del.Tex = Guolv.del:CreateTexture(nil, "BORDER");
		Guolv.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		Guolv.del.Tex:SetPoint("CENTER");
		Guolv.del.Tex:SetSize(13,13);
		Guolv.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1.5,-1.5);
		end);
		Guolv.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		Guolv.del:SetScript("OnClick", function (self)
			table.remove(PIG['AutoSellBuy']['AutoSell_List'], self:GetID());
			gengxinMulu(fuFrame.Sell.Scroll);
		end);
	end
	---
	fuFrame.Sell.ADD = CreateFrame("Frame",nil,fuFrame.Sell);  
	fuFrame.Sell.ADD:SetPoint("TOPLEFT",fuFrame.Sell,"TOPLEFT",0,0);
	fuFrame.Sell.ADD:SetPoint("BOTTOMRIGHT",fuFrame.Sell,"BOTTOMRIGHT",0,0);
	---
	fuFrame.Guolv_iteminfo={};
	fuFrame.Sell:RegisterEvent("ITEM_LOCK_CHANGED");
	fuFrame.Sell:SetScript("OnEvent",function (self,event,arg1,arg2)
		if arg1 and arg2 then
			if CursorHasItem() then
				local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(arg1,arg2);
				fuFrame.Guolv_iteminfo={icon, itemLink, itemID, noValue};
				fuFrame.Sell.ADD:SetFrameLevel(48);
			end
		end
	end);
	fuFrame.Sell.ADD:SetScript("OnMouseUp", function ()
		if CursorHasItem() then
			if fuFrame.Guolv_iteminfo[4]==true then
				print("|cff00FFFF!Pig:|r|cffffFF00物品无法售卖！|r") 
				ClearCursor();
				fuFrame.Guolv_iteminfo={};
				fuFrame.Sell.ADD:SetFrameLevel(40);
				return 
			end
			for i=1,#PIG['AutoSellBuy']['AutoSell_List'] do
				if fuFrame.Guolv_iteminfo[3]==PIG['AutoSellBuy']['AutoSell_List'][i][3] then
					print("|cff00FFFF!Pig:|r|cffffFF00物品已在目录内！|r");
					ClearCursor();
					fuFrame.Guolv_iteminfo={};
					fuFrame.Sell.ADD:SetFrameLevel(40);
					return
				end			
			end
			table.insert(PIG['AutoSellBuy']['AutoSell_List'], fuFrame.Guolv_iteminfo);
			ClearCursor();
			fuFrame.Guolv_iteminfo={};
			gengxinMulu(fuFrame.Sell.Scroll)
		end
		fuFrame.Sell.ADD:SetFrameLevel(40);
	end);
	---
	fuFrame.Sell:SetScript("OnShow", function()
		gengxinMulu(fuFrame.Sell.Scroll)
	end)
	---------------------------
	fuFrame.SellPlus = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
	fuFrame.SellPlus:SetSize(28,30);
	fuFrame.SellPlus:SetHitRectInsets(0,-60,0,0);
	fuFrame.SellPlus:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-10);
	fuFrame.SellPlus.Text:SetText("出售按钮");
	fuFrame.SellPlus.tooltip = "在商人界面增加一个卖东西按钮（可以点击卖出灰色物品和下方目录内的物品）！";
	fuFrame.SellPlus:SetScript("OnClick", function ()
		if fuFrame.SellPlus:GetChecked() then
			PIG['AutoSellBuy']['SellPlus']="ON";
			SellPlus_Open();		
		else
			PIG['AutoSellBuy']['SellPlus']="OFF";
			Pig_Options_RLtishi_UI:Show()
		end
	end);
	--自动卖垃圾
	fuFrame.AutoSellLJ = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
	fuFrame.AutoSellLJ:SetSize(28,30);
	fuFrame.AutoSellLJ:SetHitRectInsets(0,-80,0,0);
	fuFrame.AutoSellLJ:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",160,-10);
	fuFrame.AutoSellLJ.Text:SetText("自动卖垃圾");
	fuFrame.AutoSellLJ.tooltip = "打开商人界面自动售卖垃圾(灰色)物品！";
	fuFrame.AutoSellLJ:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['AutoSellBuy']['AutoSell']="ON";
		else
			PIG['AutoSellBuy']['AutoSell']="OFF";
		end
	end);
	--自动售卖
	fuFrame.AutoSell_feihui = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
	fuFrame.AutoSell_feihui:SetSize(28,30);
	fuFrame.AutoSell_feihui:SetHitRectInsets(0,-100,0,0);
	fuFrame.AutoSell_feihui:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-40);
	fuFrame.AutoSell_feihui.Text:SetText("自动卖下方目录物品");
	fuFrame.AutoSell_feihui.tooltip = "开启后将自动卖下方目录内的物品";
	fuFrame.AutoSell_feihui:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['AutoSellBuy']['AutoSell_Open']="ON";
		else
			PIG['AutoSellBuy']['AutoSell_Open']="OFF";
		end
	end);
	------------------------
	MerchantFrame:HookScript("OnEvent",function (self,event)
		if event=="MERCHANT_SHOW" then
			shoumailaji()
		end
	end);
end
--===============================================
addonTable.SellPlus = function()
	PIG['AutoSellBuy']['AutoSell_Open']=PIG['AutoSellBuy']['AutoSell_Open'] or addonTable.Default['AutoSellBuy']['AutoSell_Open']
	PIG['AutoSellBuy']['AutoSell_List']=PIG['AutoSellBuy']['AutoSell_List'] or addonTable.Default['AutoSellBuy']['AutoSell_List']
	local fuFrame = SpllBuy_TabFrame_2;
	sell_add(fuFrame)
	if PIG['AutoSellBuy']['AutoSell_Open']=="ON" then
		fuFrame.AutoSell_feihui:SetChecked(true);
	end
	PIG['AutoSellBuy']['SellPlus']=PIG['AutoSellBuy']['SellPlus'] or addonTable.Default['AutoSellBuy']['SellPlus'];
	if PIG['AutoSellBuy']['SellPlus']=="ON" then
		fuFrame.SellPlus:SetChecked(true);
		SellPlus_Open();
	end
	PIG['AutoSellBuy']['AutoSell']=PIG['AutoSellBuy']['AutoSell'] or addonTable.Default['AutoSellBuy']['AutoSell'];
	if PIG['AutoSellBuy']['AutoSell']=="ON" then
		fuFrame.AutoSellLJ:SetChecked(true);
	end
end
