local _, addonTable = ...;
---------------------------------
local _, _, _, tocversion = GetBuildInfo()
local hang_Height,hang_NUM  = 30, 14;
local FrameLevel=addonTable.SellBuyFrameLevel
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--卖灰色物品
local function shoumailaji()
	if not SpllBuy_TabFrame_2 then return end
	local fuFrame = SpllBuy_TabFrame_2;
	if ( MerchantFrame:IsVisible() and MerchantFrame.selectedTab == 1 ) then
		fuFrame.shoumaiG = 0;
		fuFrame.shoumaiShuliang = 0;
		if tocversion<100000 then
			for bag = 0, 4 do
				for slot = 1, GetContainerNumSlots(bag) do
					local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID= GetContainerItemInfo(bag, slot);
					if itemID then
						if noValue==false then
							if fuFrame.AutoSellLJ:GetChecked() then
								if quality==0 then
									local shifouzaipaichumuluYN=true
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
									if itemLink==PIG['AutoSellBuy']['AutoSell_List'][i][2] then
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
		else
			for bag = 0, 4 do
				for slot = 1, C_Container.GetContainerNumSlots(bag) do
					local ItemInfo= C_Container.GetContainerItemInfo(bag, slot);
					if ItemInfo then
						if ItemInfo.hasNoValue==false then
							if fuFrame.AutoSellLJ:GetChecked() then
								if ItemInfo.quality==0 then
									local shifouzaipaichumuluYN=true
									if shifouzaipaichumuluYN then
										local name, link, rarity, level, minLevel, itemtype, subType, stackCount, equipLoc, icon, sellPrice = GetItemInfo(ItemInfo.hyperlink);
										fuFrame.shoumaiG = sellPrice*ItemInfo.stackCount+fuFrame.shoumaiG;
										C_Container.UseContainerItem(bag, slot);
										print("|cFF7FFFAA出售|r: " ..link);
										fuFrame.shoumaiShuliang = fuFrame.shoumaiShuliang+1
									end
								end
							end
							--非灰
							if fuFrame.AutoSell_feihui:GetChecked() then
								for i=1,#PIG['AutoSellBuy']['AutoSell_List'] do
									if ItemInfo.hyperlink==PIG['AutoSellBuy']['AutoSell_List'][i][2] then
										local name, link, rarity, level, minLevel, itemtype, subType, stackCount, equipLoc, icon, sellPrice = GetItemInfo(ItemInfo.hyperlink);
										fuFrame.shoumaiG = sellPrice*ItemInfo.stackCount+fuFrame.shoumaiG;
										C_Container.UseContainerItem(bag, slot);
										print("|cFF7FFFAA出售|r: " ..link);
										fuFrame.shoumaiShuliang = fuFrame.shoumaiShuliang+1
									end
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
-----------
local function sell_add()
	local fuFrame = SpllBuy_TabFrame_2;
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
	fuFrame.Sell.biaoti:SetText("\124cffFFFF00出售目录\124r\124cff00FF00(拖拽物品到此)\124r");

	fuFrame.Sell.daochu = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");
	fuFrame.Sell.daochu:SetSize(50,20);
	fuFrame.Sell.daochu:SetPoint("LEFT",fuFrame.Sell.biaoti,"RIGHT",0,0);
	fuFrame.Sell.daochu:SetText("导出");
	local Config_daochu_UP=addonTable.Config_daochu_UP
	fuFrame.Sell.daochu:SetScript("OnClick", function(self, button)
		Config_daochu_UP(self,PIG.AutoSellBuy.AutoSell_List)
	end)

	fuFrame.Sell.daochu = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");
	fuFrame.Sell.daochu:SetSize(50,20);
	fuFrame.Sell.daochu:SetPoint("RIGHT",fuFrame.Sell.biaoti,"LEFT",0,0);
	fuFrame.Sell.daochu:SetText("导入");
	local Config_daoru_UP=addonTable.Config_daoru_UP
	fuFrame.Sell.daochu:SetScript("OnClick", function(self, button)
		Config_daoru_UP(self,"PIG","AutoSellBuy~AutoSell_List")
	end)
	--
	local function gengxinMulu(self)
		for id = 1, hang_NUM do
			_G["Sell_hang"..id].item.icon:SetTexture();
			_G["Sell_hang"..id].item.link:SetText();
			_G["Sell_hang"..id].item:Hide();
			_G["Sell_hang"..id].del:Hide();
	    end
		if #PIG['AutoSellBuy']['AutoSell_List']>0 then
			local paichushu = #PIG['AutoSellBuy']['AutoSell_List'];
			FauxScrollFrame_Update(self, paichushu, hang_NUM, hang_Height);
			local offset = FauxScrollFrame_GetOffset(self);
		    for id = 1, hang_NUM do
		    	local dangqianH = id+offset;
		    	if PIG['AutoSellBuy']['AutoSell_List'][dangqianH] then
			    	_G["Sell_hang"..id].item.icon:SetTexture(PIG['AutoSellBuy']['AutoSell_List'][dangqianH][1]);
					_G["Sell_hang"..id].item.link:SetText(PIG['AutoSellBuy']['AutoSell_List'][dangqianH][2]);
					_G["Sell_hang"..id].item:Show();
					_G["Sell_hang"..id].item:SetScript("OnMouseDown", function (self)
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
						GameTooltip:SetHyperlink(PIG['AutoSellBuy']['AutoSell_List'][dangqianH][2])
					end);
					_G["Sell_hang"..id].item:SetScript("OnMouseUp", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
					_G["Sell_hang"..id].del:Show();
					_G["Sell_hang"..id].del:SetID(dangqianH);
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
		local Sell = CreateFrame("Frame", "Sell_hang"..id, fuFrame.Sell);
		Sell:SetSize(Width-36, hang_Height);
		if id==1 then
			Sell:SetPoint("TOP",fuFrame.Sell.Scroll,"TOP",0,0);
		else
			Sell:SetPoint("TOP",_G["Sell_hang"..(id-1)],"BOTTOM",0,-0);
		end
		if id~=hang_NUM then
			local Sell_line = Sell:CreateLine()
			Sell_line:SetColorTexture(1,1,1,0.2)
			Sell_line:SetThickness(1);
			Sell_line:SetStartPoint("BOTTOMLEFT",0,0)
			Sell_line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		Sell.item = CreateFrame("Frame", nil, Sell);
		Sell.item:SetSize(Width-70,hang_Height);
		Sell.item:SetPoint("LEFT",Sell,"LEFT",hang_Height,0);
		Sell.item.icon = Sell.item:CreateTexture(nil, "BORDER");
		Sell.item.icon:SetSize(26,26);
		Sell.item.icon:SetPoint("LEFT", Sell.item, "LEFT", 0,0);
		Sell.item.link = Sell.item:CreateFontString();
		Sell.item.link:SetPoint("LEFT", Sell.item, "LEFT", 30,0);
		Sell.item.link:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");

		Sell.del = CreateFrame("Button",nil, Sell, "TruncatedButtonTemplate");
		Sell.del:SetSize(hang_Height,hang_Height);
		Sell.del:SetPoint("LEFT", Sell, "LEFT", 0,0);
		Sell.del.Tex = Sell.del:CreateTexture(nil, "BORDER");
		Sell.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		Sell.del.Tex:SetPoint("CENTER");
		Sell.del.Tex:SetSize(13,13);
		Sell.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1.5,-1.5);
		end);
		Sell.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		Sell.del:SetScript("OnClick", function (self)
			table.remove(PIG['AutoSellBuy']['AutoSell_List'], self:GetID());
			gengxinMulu(fuFrame.Sell.Scroll);
		end);
	end
	---
	fuFrame.Sell.ADD = CreateFrame("Frame",nil,fuFrame.Sell);  
	fuFrame.Sell.ADD:SetPoint("TOPLEFT",fuFrame.Sell,"TOPLEFT",0,0);
	fuFrame.Sell.ADD:SetPoint("BOTTOMRIGHT",fuFrame.Sell,"BOTTOMRIGHT",0,0);
	---
	fuFrame.Sell:RegisterEvent("ITEM_LOCK_CHANGED");
	fuFrame.Sell:SetScript("OnEvent",function (self,event,arg1,arg2)
		if self:IsShown() then
			self.ADD:SetFrameLevel(FrameLevel+8);
		end
	end);
	fuFrame.Sell.ADD:SetScript("OnMouseUp", function (self)
		if CursorHasItem() then
			local NewType, TtemID, Itemlink= GetCursorInfo()
			local noValue = select(11,GetItemInfo(Itemlink))
			if noValue==0 then
				print("|cff00FFFF!Pig:|r|cffffFF00物品无法售卖！|r") 
				ClearCursor();
				self:SetFrameLevel(FrameLevel);
				return 
			end
			for i=1,#PIG['AutoSellBuy']['AutoSell_List'] do
				if Itemlink==PIG['AutoSellBuy']['AutoSell_List'][i][2] then
					print("|cff00FFFF!Pig:|r|cffffFF00物品已在目录内！|r");
					ClearCursor();
					self:SetFrameLevel(FrameLevel);
					return
				end			
			end
			local icon = select(5,GetItemInfoInstant(Itemlink))
			table.insert(PIG['AutoSellBuy']['AutoSell_List'], {icon,Itemlink,TtemID});
			ClearCursor();
			gengxinMulu(fuFrame.Sell.Scroll)
		end
		self:SetFrameLevel(FrameLevel);
	end);
	---
	fuFrame.Sell:SetScript("OnShow", function()
		gengxinMulu(fuFrame.Sell.Scroll)
	end)
	---------------------------
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
	fuFrame.SellPlus = ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame,"TOPLEFT",20,-10,"出售按钮", "在商人界面增加一个卖东西按钮（可以点击卖出灰色物品和下方目录内的物品）")
	fuFrame.SellPlus:SetScript("OnClick", function ()
		if fuFrame.SellPlus:GetChecked() then
			PIG['AutoSellBuy']['SellPlus']="ON";
			SellPlus_Open();		
		else
			PIG['AutoSellBuy']['SellPlus']="OFF";
			Pig_Options_RLtishi_UI:Show()
		end
	end);
	if PIG['AutoSellBuy']['SellPlus']=="ON" then
		fuFrame.SellPlus:SetChecked(true);
		SellPlus_Open();
	end
	--自动卖垃圾
	local function AutoSell_Open()
		MerchantFrame:HookScript("OnShow",function (self,event)
			shoumailaji()
		end);
	end
	fuFrame.AutoSellLJ = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",160,-10,"自动卖垃圾", "打开商人界面自动售卖垃圾(灰色)物品")
	fuFrame.AutoSellLJ:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['AutoSellBuy']['AutoSell']="ON";
			AutoSell_Open()
		else
			PIG['AutoSellBuy']['AutoSell']="OFF";
		end
	end);
	if PIG['AutoSellBuy']['AutoSell']=="ON" then
		fuFrame.AutoSellLJ:SetChecked(true)
	end
	--自动售卖
	fuFrame.AutoSell_feihui = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-36,"自动卖下方目录物品", "开启后将自动卖下方目录内的物品")
	fuFrame.AutoSell_feihui:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['AutoSellBuy']['AutoSell_Open']="ON";
		else
			PIG['AutoSellBuy']['AutoSell_Open']="OFF";
		end
	end);

	if PIG['AutoSellBuy']['AutoSell_Open']=="ON" then
		fuFrame.AutoSell_feihui:SetChecked(true)
	end
	if PIG['AutoSellBuy']['AutoSell']=="ON" or PIG['AutoSellBuy']['AutoSell_Open']=="ON" then
		AutoSell_Open()
	end
end
--===============================================
addonTable.SellPlus = sell_add