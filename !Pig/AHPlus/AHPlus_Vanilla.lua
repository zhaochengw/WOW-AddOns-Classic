local _, addonTable = ...;
local fuFrame=List_R_F_2_2
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
----------------------------------
local function Update_GGG(self,GGG)
	self:Hide();
	self.T:Hide();
	self.Y:Hide();
	self.G:Hide();
	self.TV:SetText();
	self.YV:SetText();
	self.GV:SetText();
	if GGG>0 then
		self:Show();
		local copper = floor(GGG % 100+0.5)
		self.TV:SetText(copper);
		self.T:Show();
		local silver = floor(GGG / 100) % 100
		local gold = floor(GGG / 10000)	
		if silver>0 or gold>0 then
			self.YV:SetText(silver);
			self.Y:Show();
		end
		if gold>0 then
			self.GV:SetText(gold);
			self.G:Show();
		end
	end
end
local function huoquhuizhangjiageG()
	local marketPrice = C_WowTokenPublic.GetCurrentMarketPrice();
	if marketPrice and marketPrice>0 then
		local hzlishiGG = PIG.AHPlus.Tokens
		local hzlishiGGNum = #hzlishiGG
		if hzlishiGGNum>0 then
			if hzlishiGGNum>50 then
				local kaishiwb = hzlishiGGNum-50
				for i=kaishiwb,1,-1 do
					table.remove(PIG.AHPlus.Tokens,i)
				end
			end
			local OldmarketPrice = PIG.AHPlus.Tokens[#PIG.AHPlus.Tokens][2] or 0
			if OldmarketPrice~=marketPrice then
				table.insert(PIG.AHPlus.Tokens,{GetServerTime(),marketPrice})
			end
		else
			table.insert(PIG.AHPlus.Tokens,{GetServerTime(),marketPrice})
		end
	end
end
local function ADD_AHPlus()
	if AuctionFrameBrowse.piglist then return end
	local OLD_QueryAuctionItems = QueryAuctionItems	
	QueryAuctionItems = function(...)
		local text, minLevel, maxLevel, page, usable, rarity, allxiazai, exactMatch, filterData =...
		if PIG.AHPlus.exactMatch or AuctionFrame.maichuxunjia then
			local exactMatch = true
			return OLD_QueryAuctionItems(text, minLevel, maxLevel, page, usable, rarity, allxiazai, exactMatch, filterData)
		else
			return OLD_QueryAuctionItems(text, minLevel, maxLevel, page, usable, rarity, allxiazai, exactMatch, filterData)
		end
	end
	AuctionFrameBrowse.exact =ADD_Checkbutton(nil,AuctionFrameBrowse,-20,"TOPLEFT",AuctionFrameBrowse,"TOPLEFT",530,-13,"精确查找","选中后查找结果将精确匹配关键字")
	AuctionFrameBrowse.exact:SetSize(24,24);
	AuctionFrameBrowse.exact.Text:SetTextColor(0, 1, 0, 0.8);
	AuctionFrameBrowse.exact:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG.AHPlus.exactMatch=true
		else
			PIG.AHPlus.exactMatch=false
		end
	end);
	if PIG.AHPlus.exactMatch then
		AuctionFrameBrowse.exact:SetChecked(true)
	else
		AuctionFrameBrowse.exact:SetChecked(false)
	end
	local function qingkongtiaojian()
		BrowseName:SetText("")--清空搜索名
		BrowseMinLevel:SetText("")
		BrowseMaxLevel:SetText("")
		UIDropDownMenu_SetSelectedValue(BrowseDropDown, -1, useValue)--品质
		IsUsableCheckButton:SetChecked(false)--可用
		AuctionFrameBrowse.selectedCategoryIndex=nil
		AuctionFrameBrowse.selectedSubCategoryIndex=nil
		AuctionFrameBrowse.selectedSubSubCategoryIndex =nil
		AuctionFrameBrowse.page=0
	end
	local FWQrealm = GetRealmName()
	PIG.AHPlus.Data[FWQrealm]=PIG.AHPlus.Data[FWQrealm] or {}
	--调整原版UI
	local function shezhixitongHide(tmV)
		local suoxiaozhi = 34
		hooksecurefunc("AuctionFrameFilters_UpdateCategories", function(forceSelectionIntoView)	
			BrowseFilterScrollFrame:ClearAllPoints();
			BrowseFilterScrollFrame:SetPoint("TOPRIGHT",AuctionFrameBrowse,"TOPLEFT",158-suoxiaozhi,-105);
			local hasScrollBar = #OPEN_FILTER_LIST > NUM_FILTERS_TO_DISPLAY;
			local offset = FauxScrollFrame_GetOffset(BrowseFilterScrollFrame);
			local dataIndex = offset;
			for i = 1, NUM_FILTERS_TO_DISPLAY do
				local button = AuctionFrameBrowse.FilterButtons[i];
				button:SetWidth(hasScrollBar and 136-suoxiaozhi or 156-suoxiaozhi);
				if button.Text:GetText()=="魔兽世界时光徽章" then
					button.Text:SetText("时光徽章")
				end
			end	
		end)
		BrowseNameText:ClearAllPoints();
		BrowseNameText:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",540,-40);
		BrowseLevelText:ClearAllPoints();
		BrowseLevelText:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",80,-40);
		BrowseIsUsableText:ClearAllPoints();
		BrowseIsUsableText:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",300,-40);
		BrowseShowOnCharacterText:ClearAllPoints();
		BrowseShowOnCharacterText:SetPoint("LEFT",BrowseIsUsableText,"RIGHT",40,0);
		BrowseSearchButton:ClearAllPoints();
		BrowseSearchButton:SetPoint("LEFT",BrowseName,"RIGHT",4,0);
		BrowseBidPrice:ClearAllPoints();
		BrowseBidPrice:SetPoint("RIGHT",BrowseBidButton,"LEFT",0,0);
		if BrowseResetButton then
			BrowseResetButton:ClearAllPoints();
			BrowseResetButton:SetPoint("LEFT",BrowseNameText,"RIGHT",4,0);
		end
		BrowseQualitySort:SetAlpha(tmV);
	 	BrowseLevelSort:SetAlpha(tmV);
		BrowseDurationSort:SetAlpha(tmV);
		BrowseHighBidderSort:SetAlpha(tmV);
		BrowseCurrentBidSort:SetAlpha(tmV);
		--拍卖页
		--堆叠数量
		AuctionsStackSizeEntry:ClearAllPoints();
		AuctionsStackSizeEntry:SetPoint("TOPLEFT",AuctionFrameAuctions,"TOPLEFT",33,-154);
		AuctionsStackSizeMaxButton:SetWidth(40);
		AuctionsStackSizeMaxButton:SetPoint("LEFT",AuctionsStackSizeEntry,"RIGHT",-10,0);
		--堆叠组数
		AuctionsNumStacksEntry:ClearAllPoints();
		AuctionsNumStacksEntry:SetPoint("LEFT",AuctionsStackSizeEntry,"RIGHT",40,0);
		AuctionsNumStacksMaxButton:SetWidth(40);
		AuctionsNumStacksMaxButton:SetPoint("LEFT",AuctionsNumStacksEntry,"RIGHT",-10,0);
		--每个/每组
		UIDropDownMenu_SetWidth(PriceDropDown, 100)
		PriceDropDown:ClearAllPoints();
		PriceDropDown:SetPoint("TOPLEFT",AuctionFrameAuctions,"TOPLEFT",70,-174);
		--价格
		StartPrice:ClearAllPoints();
		StartPrice:SetPoint("TOPLEFT",AuctionFrameAuctions,"TOPLEFT",33,-214);
		BuyoutPrice:ClearAllPoints();
		BuyoutPrice:SetPoint("TOPLEFT",StartPrice,"BOTTOMLEFT",0,-20);
		--错误提示
		AuctionsBuyoutErrorText:ClearAllPoints();
		AuctionsBuyoutErrorText:SetPoint("TOPLEFT",BuyoutPrice,"BOTTOMLEFT",-15,-4);
		--时限
		AuctionsDurationText:ClearAllPoints();
		AuctionsDurationText:SetPoint("TOPLEFT",AuctionFrameAuctions,"TOPLEFT",28,-310);
		AuctionsShortAuctionButton:ClearAllPoints();
		AuctionsShortAuctionButton:SetPoint("TOPLEFT",AuctionsDurationText,"BOTTOMLEFT",0,0);
		AuctionsShortAuctionButton:SetHitRectInsets(0,-36,0,0);
		AuctionsShortAuctionButtonText:SetText("12时");
		AuctionsMediumAuctionButton:ClearAllPoints();
		AuctionsMediumAuctionButton:SetPoint("LEFT",AuctionsShortAuctionButtonText,"RIGHT",10,0);
		AuctionsMediumAuctionButton:SetHitRectInsets(0,-36,0,0);
		AuctionsMediumAuctionButtonText:SetText("24时");
		AuctionsLongAuctionButton:ClearAllPoints();
		AuctionsLongAuctionButton:SetPoint("LEFT",AuctionsMediumAuctionButtonText,"RIGHT",10,0);
		AuctionsLongAuctionButton:SetHitRectInsets(0,-36,0,0);
		AuctionsLongAuctionButtonText:SetText("48时");
	end
	shezhixitongHide(0)
	--ADD浏览页
	local ADD_Biaoti=addonTable.ADD_Biaoti
	AuctionFrameBrowse.piglist = CreateFrame("Frame", nil, AuctionFrameBrowse,"BackdropTemplate")
	local listF=AuctionFrameBrowse.piglist
	listF:SetBackdrop( { bgFile = "interface/characterframe/ui-party-background.blp", });
	listF:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",153,-104);
	listF:SetPoint("BOTTOMRIGHT",AuctionFrameBrowse,"BOTTOMRIGHT",70,38);
	listF:SetFrameLevel(10)
	listF:EnableMouse(true)
	listF.fengeline = listF:CreateTexture(nil, "BORDER");
	listF.fengeline:SetTexture("interface/dialogframe/ui-dialogbox-divider.blp");
	listF.fengeline:SetRotation(-3.1415926/2, 0, 0)
	listF.fengeline:SetSize(408,24);
	listF.fengeline:SetPoint("TOPLEFT",listF,"TOPLEFT",-20,26);
	listF.tishi = listF:CreateFontString();
	listF.tishi:SetPoint("CENTER", listF, "CENTER", 0,100);
	listF.tishi:SetFontObject(GameFontNormal);
	listF.tishi:SetText('选择搜索条件,然后按下"搜索"');
	---
	local xulieID = {"物品名","数量","剩余","竞标价","一口价","一口单价","涨跌","出售者"}
	local xulieID_www = {172,42,60,110,110,110,50,100}
	local anniuH = 18
	for i=1,#xulieID do
		local Buttonxx = CreateFrame("Button","piglist_biaoti_"..i,listF);
		Buttonxx:SetSize(xulieID_www[i],anniuH);
		if i==1 then
			Buttonxx:SetPoint("BOTTOMLEFT",listF,"TOPLEFT",0,4);
		elseif xulieID[i]=="出售者" then
			Buttonxx:Hide()
			Buttonxx:SetPoint("LEFT",_G["piglist_biaoti_"..(i-1)],"RIGHT",22,0);
		else
			Buttonxx:SetPoint("LEFT",_G["piglist_biaoti_"..(i-1)],"RIGHT",0,0);
		end
		ADD_Biaoti(Buttonxx)
		Buttonxx.title = Buttonxx:CreateFontString();
		Buttonxx.title:SetFontObject(CombatLogFont);
		Buttonxx.title:SetText(xulieID[i]);
		if xulieID[i]=="竞标价" or xulieID[i]=="一口价" or xulieID[i]=="一口单价" then
			Buttonxx.title:SetPoint("RIGHT", Buttonxx, "RIGHT", -12, 0);
			Buttonxx.paixu = Buttonxx:CreateTexture(nil, "ARTWORK");
			Buttonxx.paixu:SetTexture("interface/buttons/ui-sortarrow.blp");
			Buttonxx.paixu:SetPoint("LEFT",Buttonxx.title,"RIGHT",0,-2);
			Buttonxx.paixu:Hide();
			Buttonxx:SetScript("OnMouseDown", function (self)
				self.title:SetPoint("RIGHT", self, "RIGHT", -13.5, -1.5);
			end);
			Buttonxx:SetScript("OnMouseUp", function (self)
				self.title:SetPoint("RIGHT", self, "RIGHT", -12, 0);
			end);
			Buttonxx:SetScript("OnClick", function (self)
				for i=1,#xulieID do
					if xulieID[i]=="竞标价" or xulieID[i]=="一口价" or xulieID[i]=="一口单价" then
						_G["piglist_biaoti_"..i].paixu:Hide()
					end
				end
				if xulieID[i]=="竞标价" then
					SortAuctionItems("list", "bid");
					local sorted = IsAuctionSortReversed("list","bid")
					if sorted then
						self.paixu:SetRotation(-3.1415926, 0.29, 0.6)
					else
						self.paixu:SetRotation(0, 0.29, 0.6)
					end
					self.paixu:Show()
				elseif xulieID[i]=="一口价" then
					SortAuctionItems("list", "buyout");
					local sorted = IsAuctionSortReversed("list","buyout")
					if sorted then
						self.paixu:SetRotation(-3.1415926, 0.29, 0.6)
					else
						self.paixu:SetRotation(0, 0.29, 0.6)
					end
					self.paixu:Show()
				elseif xulieID[i]=="一口单价" then
					SortAuctionItems("list", "unitprice");
					local sorted = IsAuctionSortReversed("list","unitprice")
					if sorted then
						self.paixu:SetRotation(-3.1415926, 0.29, 0.6)
					else
						self.paixu:SetRotation(0, 0.29, 0.6)
					end
					self.paixu:Show()
				end
			end);
		else
			Buttonxx.title:SetPoint("LEFT", Buttonxx, "LEFT", 6, 0);
		end
	end
	local hang_Height,hang_NUM  = 20, 14;
	local shengyuTime = {[1]="|cffFF0000<30m|r",[2]="|cffFFFF0030m~2H|r",[3]="|cff00FF002H~12H|r",[4]="|cff00FF00>12H|r",}
	local function gengxinlist(self)
		BrowseBidButton:Disable();
		BrowseBuyoutButton:Disable();
		local numBatchAuctions=listF.numBatchAuctions
		local totalAuctions=listF.totalAuctions
		if numBatchAuctions>0 then
			listF.tishi:SetText('');
			BrowseNextPageButton:ClearAllPoints();
			BrowseNextPageButton:SetPoint("RIGHT",BrowseBidPrice,"LEFT",-60,0);
			BrowseNextPageButton:SetScale(0.88);
			BrowseNextPageButton:Show();
			BrowsePrevPageButton:ClearAllPoints();
			BrowsePrevPageButton:SetPoint("RIGHT",BrowseNextPageButton,"LEFT",-110,0);
			BrowsePrevPageButton:SetScale(0.88);
			BrowsePrevPageButton:Show();
			BrowseSearchCountText:ClearAllPoints();
			BrowseSearchCountText:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",330,-64);
			BrowseSearchCountText:Show();
			local kaishiV = NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page+1
			local jieshuV = NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page+numBatchAuctions
			if jieshuV>totalAuctions then
				BrowseSearchCountText:SetText("当前"..kaishiV.."-"..totalAuctions.."(总"..totalAuctions..")");
			else
				BrowseSearchCountText:SetText("当前"..kaishiV.."-"..jieshuV.."(总"..totalAuctions..")");
			end
			FauxScrollFrame_Update(self, numBatchAuctions, hang_NUM, hang_Height);
			local offset = FauxScrollFrame_GetOffset(self);
		    for i = 1, hang_NUM do
		    	local listFGV = _G["piglist_item_"..i]
				local AHdangqianH = i+offset;
				local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, 
	   			highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo =  GetAuctionItemInfo("list", AHdangqianH);
	   			if name then
	   				listFGV:SetID(AHdangqianH)
	   				listFGV:Show()
	   				local Index = GetSelectedAuctionItem("list");
    				if Index == AHdangqianH then
    					listFGV.xuanzhong:Show()
    					local ownerName;
						if (not ownerFullName) then
							ownerName = owner;
						else
							ownerName = ownerFullName
						end
						--一口价
    					if ( buyoutPrice > 0 and buyoutPrice >= minBid ) then
							local canBuyout = 1;
							if ( GetMoney() < buyoutPrice ) then
								if ( not highBidder or GetMoney()+bidAmount < buyoutPrice ) then
									canBuyout = nil;
								end
							end
							if ( canBuyout and (ownerName ~= UnitName("player")) ) then
								BrowseBuyoutButton:Enable();
								AuctionFrame.buyoutPrice = buyoutPrice;
							end
						else
							AuctionFrame.buyoutPrice = nil;
						end
						---竞拍
						if ( bidAmount == 0 ) then
							displayedPrice = minBid;
							requiredBid = minBid;
						else
							displayedPrice = bidAmount;
							requiredBid = bidAmount + minIncrement ;
						end
						if ( requiredBid >= MAXIMUM_BID_PRICE ) then
							buyoutPrice = requiredBid;
						end
						MoneyInputFrame_SetCopper(BrowseBidPrice, requiredBid);

						if ( not highBidder and ownerName ~= UnitName("player") and GetMoney() >= MoneyInputFrame_GetCopper(BrowseBidPrice) and MoneyInputFrame_GetCopper(BrowseBidPrice) <= MAXIMUM_BID_PRICE ) then
							BrowseBidButton:Enable();
						end
				    else
				        listFGV.xuanzhong:Hide()
    				end
					listFGV.itemicon.tex:SetTexture(texture);
					local r, g, b, hex = GetItemQualityColor(quality)
					listFGV.itemlink.t:SetText(name);
					listFGV.itemlink.quality=quality
					listFGV.itemlink.t:SetTextColor(r, g, b, hex);

					listFGV.count:SetText(count);
					listFGV.chushouzhe:SetText(owner);
					local timeleft = GetAuctionItemTimeLeft("list", AHdangqianH)
					listFGV.TimeLeft:SetText(shengyuTime[timeleft]);
					Update_GGG(listFGV.jingbiao,minBid)
					Update_GGG(listFGV.yikou,buyoutPrice)
					Update_GGG(listFGV.yikoudanjia,buyoutPrice/count)
					listFGV.zhangdie:SetText("-");
					listFGV.zhangdie:SetTextColor(1, 1, 1, 1);
					if PIG.AHPlus.Data[FWQrealm][name] then
						if buyoutPrice>0 and PIG.AHPlus.Data[FWQrealm][name][1]>0 then
							local baifenbi = ((buyoutPrice/count)/PIG.AHPlus.Data[FWQrealm][name][1])*100+0.5
							local baifenbi = floor(baifenbi)
							listFGV.zhangdie:SetText(baifenbi.."%");
							if baifenbi<100 then
								listFGV.zhangdie:SetTextColor(0, 1, 0, 1);
							elseif baifenbi>100 then
								listFGV.zhangdie:SetTextColor(1, 0, 0, 1);
							end
						end
					end
	   			else
	   				listFGV:Hide()
	   			end
			end
		else
			for i = 1, hang_NUM do
		    	_G["piglist_item_"..i]:Hide()
		    end
			listF.tishi:SetText('未发现物品');
			SetSelectedAuctionItem("list", 0);
		end
	end
	listF.Scroll = CreateFrame("ScrollFrame",nil,listF, "FauxScrollFrameTemplate");  
	listF.Scroll:SetPoint("TOPLEFT",listF,"TOPLEFT",0,-2);
	listF.Scroll:SetPoint("BOTTOMRIGHT",listF,"BOTTOMRIGHT",-25,2);
	listF.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinlist)
	end)
	BrowseScrollFrame:HookScript("OnVerticalScroll", function(self, offset)
		BrowseNextPageButton:Show();
		BrowsePrevPageButton:Show();
		BrowseSearchCountText:Show();
	end)
	--创建行
	local function zhixinghuanjie(frame,fujiF,Tooltip)
		frame:HookScript("OnEnter", function()
			fujiF.xuanzhong:Show()
			if Tooltip then
				local Itemlink=GetAuctionItemLink("list", fujiF:GetID())
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(frame, "ANCHOR_RIGHT",0,0);
				GameTooltip:SetHyperlink(Itemlink)
				GameTooltip:Show();
			end
		end);
		frame:HookScript("OnLeave", function()
			local Index = GetSelectedAuctionItem("list");
		    if (Index ~= fujiF:GetID()) then
				fujiF.xuanzhong:Hide()
			end
			if Tooltip then
				GameTooltip:ClearLines();
				GameTooltip:Hide()
			end
		end);
		frame:SetScript("OnClick", function ()
			SetSelectedAuctionItem("list", fujiF:GetID())
			gengxinlist(listF.Scroll)
		end);
		if frame==fujiF.itemlink or frame==fujiF.itemicon then
			frame:SetScript("OnMouseUp", function (self,button)
				GameTooltip:ClearLines();
				GameTooltip:Hide()
				local Itemlink=GetAuctionItemLink("list", fujiF:GetID())
				local name=fujiF.itemlink.t:GetText()
				if button=="LeftButton" then
					if IsShiftKeyDown() then
						local editBox = ChatEdit_ChooseBoxForSend();
						if editBox:HasFocus() then			
							local hasText = editBox:GetText()..Itemlink
							editBox:SetText(hasText);
						else
							BrowseName:SetText(name)
						end
					elseif IsControlKeyDown() then
						DressUpItemLink(Itemlink)
					end
				else
					local hejiinfo = PIG.AHPlus["Coll"]
					for kk=1,#hejiinfo do
						if hejiinfo[kk][1]==name then
							print("|cff00FFFF!Pig:|r<"..name..">|cffFFFF00已存在|r")
							return
						end
					end
					table.insert(PIG.AHPlus["Coll"],{name,fujiF.itemicon.tex:GetTexture(),fujiF.itemlink.quality})
					listF:Gengxinlistcoll()
				end
			end);
		end
	end
	local function chuangjianjinbiF(fujiF,Point,width,hang_Height)
		local frame = CreateFrame("Frame", nil, fujiF);
		frame:SetSize(width, hang_Height);
		frame:SetPoint("LEFT", Point, "RIGHT", 0,0);
		frame.T = frame:CreateTexture(nil, "BORDER");
		frame.T:SetTexture("interface/moneyframe/ui-coppericon.blp");
		frame.T:SetPoint("RIGHT",frame,"RIGHT",-6,0);
		frame.T:SetSize(12,14);
		frame.TV = frame:CreateFontString();
		frame.TV:SetPoint("RIGHT", frame.T, "LEFT", 0,0);
		frame.TV:SetFont(ChatFontNormal:GetFont(), 13);
		frame.TV:SetJustifyH("RIGHT");
		frame.Y = frame:CreateTexture(nil, "BORDER");
		frame.Y:SetTexture("interface/moneyframe/ui-silvericon.blp");
		frame.Y:SetPoint("RIGHT",frame.T,"LEFT",-14,0);
		frame.Y:SetSize(12,14);
		frame.YV = frame:CreateFontString();
		frame.YV:SetPoint("RIGHT", frame.Y, "LEFT", 0,0);
		frame.YV:SetFont(ChatFontNormal:GetFont(), 13);
		frame.YV:SetJustifyH("RIGHT");
		frame.G = frame:CreateTexture(nil, "BORDER");
		frame.G:SetTexture("interface/moneyframe/ui-goldicon.blp");
		frame.G:SetPoint("RIGHT",frame.Y,"LEFT",-14,0);
		frame.G:SetSize(12,14);
		frame.GV = frame:CreateFontString();
		frame.GV:SetPoint("RIGHT", frame.G, "LEFT", 0,0);
		frame.GV:SetFont(ChatFontNormal:GetFont(), 13);
		frame.GV:SetJustifyH("RIGHT");
		return frame
	end
	local hang_Width =listF.Scroll:GetWidth()
	for i = 1, hang_NUM do
		local listFitem = CreateFrame("Button", "piglist_item_"..i, listF);
		listFitem:SetSize(hang_Width, hang_Height);
		if i==1 then
			listFitem:SetPoint("TOP",listF.Scroll,"TOP",0,0);
		else
			listFitem:SetPoint("TOP",_G["piglist_item_"..(i-1)],"BOTTOM",0,-1.5);
		end
		listFitem:Hide()
		zhixinghuanjie(listFitem,listFitem)
		listFitem.xuanzhong = listFitem:CreateTexture(nil, "BORDER");
		listFitem.xuanzhong:SetTexture("interface/helpframe/helpframebutton-highlight.blp");
		listFitem.xuanzhong:SetTexCoord(0.00,0.00,0.00,0.58,1.00,0.00,1.00,0.58);
		listFitem.xuanzhong:SetAllPoints(listFitem)
		listFitem.xuanzhong:SetBlendMode("ADD")
		listFitem.xuanzhong:Hide()
		if i~=hang_NUM then
			listFitem.line = listFitem:CreateLine()
			listFitem.line:SetColorTexture(1,1,1,0.2)
			listFitem.line:SetThickness(1);
			listFitem.line:SetStartPoint("BOTTOMLEFT",0,0)
			listFitem.line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		listFitem.itemicon = CreateFrame("Button", nil, listFitem);
		listFitem.itemicon:SetSize(hang_Height,hang_Height);
		listFitem.itemicon:SetPoint("LEFT",listFitem,"LEFT",2,0);
		zhixinghuanjie(listFitem.itemicon,listFitem,true)
		listFitem.itemicon.tex = listFitem.itemicon:CreateTexture(nil, "BORDER");
		listFitem.itemicon.tex:SetAllPoints(listFitem.itemicon)

		listFitem.itemlink = CreateFrame("Button", nil, listFitem);
		listFitem.itemlink:SetSize(xulieID_www[1]-hang_Height,hang_Height);
		listFitem.itemlink:SetPoint("LEFT", listFitem.itemicon, "RIGHT", 0,0);
		zhixinghuanjie(listFitem.itemlink,listFitem)

		listFitem.itemlink.t = listFitem.itemlink:CreateFontString();
		listFitem.itemlink.t:SetAllPoints(listFitem.itemlink)
		listFitem.itemlink.t:SetFont(ChatFontNormal:GetFont(), 13);
		listFitem.itemlink.t:SetJustifyH("LEFT");
		---
		listFitem.count = listFitem:CreateFontString();
		listFitem.count:SetWidth(xulieID_www[2]);
		listFitem.count:SetPoint("LEFT", listFitem.itemlink, "RIGHT", 0,0);
		listFitem.count:SetFont(ChatFontNormal:GetFont(), 13);
		listFitem.count:SetJustifyH("LEFT");
		--
		listFitem.TimeLeft = listFitem:CreateFontString();
		listFitem.TimeLeft:SetWidth(xulieID_www[3]);
		listFitem.TimeLeft:SetPoint("LEFT", listFitem.count, "RIGHT", 0,0);
		listFitem.TimeLeft:SetFont(ChatFontNormal:GetFont(), 13);
		listFitem.TimeLeft:SetJustifyH("LEFT");
		--
		listFitem.jingbiao=chuangjianjinbiF(listFitem,listFitem.TimeLeft,xulieID_www[4],hang_Height)
		--
		listFitem.yikou=chuangjianjinbiF(listFitem,listFitem.jingbiao,xulieID_www[5],hang_Height)
		--
		listFitem.yikoudanjia=chuangjianjinbiF(listFitem,listFitem.yikou,xulieID_www[6],hang_Height)
		--
		listFitem.zhangdie = listFitem:CreateFontString();
		listFitem.zhangdie:SetWidth(xulieID_www[7]);
		listFitem.zhangdie:SetPoint("LEFT", listFitem.yikoudanjia, "RIGHT", 0,0);
		listFitem.zhangdie:SetFont(ChatFontNormal:GetFont(), 13);
		listFitem.zhangdie:SetJustifyH("LEFT");
		----
		listFitem.chushouzhe = listFitem:CreateFontString();
		listFitem.chushouzhe:SetWidth(xulieID_www[8]);
		listFitem.chushouzhe:SetPoint("LEFT", listFitem.zhangdie, "RIGHT", 20,0);
		listFitem.chushouzhe:SetFont(ChatFontNormal:GetFont(), 13,"OUTLINE");
		listFitem.chushouzhe:SetJustifyH("LEFT");
		listFitem.chushouzhe:Hide();
	end

	AuctionFrameBrowse.ShowHide = CreateFrame("Button",nil,AuctionFrameBrowse, "UIPanelButtonTemplate");
	AuctionFrameBrowse.ShowHide:SetSize(70,18);
	AuctionFrameBrowse.ShowHide:SetPoint("BOTTOMLEFT",listF,"TOPLEFT",90,2);
	AuctionFrameBrowse.ShowHide:SetText("出售者");
	AuctionFrameBrowse.ShowHide:SetFrameLevel(13)
	AuctionFrameBrowse.ShowHide:SetScript("OnClick", function(self)
		if piglist_biaoti_8:IsShown() then
			piglist_biaoti_8:Hide()
			for i=1,hang_NUM do
				local listFGV = _G["piglist_item_"..i].chushouzhe:Hide()
			end
		else
			AuctionFrameBrowse.coll.list:Hide()
			piglist_biaoti_8:Show()
			for i=1,hang_NUM do
				local listFGV = _G["piglist_item_"..i].chushouzhe:Show()
			end
		end
	end)
	---缓存
	AuctionFrameBrowse.History = CreateFrame("Button",nil,AuctionFrameBrowse, "UIPanelButtonTemplate");
	AuctionFrameBrowse.History:SetSize(90,18);
	AuctionFrameBrowse.History:SetPoint("TOPRIGHT",AuctionFrameBrowse,"TOPRIGHT",10,-15);
	AuctionFrameBrowse.History:SetText("缓存价格");
	---
	AuctionFrameBrowse.huancunUI = CreateFrame("Frame", nil, AuctionFrameBrowse,"BackdropTemplate");
	local HCUI = AuctionFrameBrowse.huancunUI
	HCUI:SetBackdrop( { 
		bgFile = "interface/characterframe/ui-party-background.blp",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 13,});
	HCUI:SetBackdropBorderColor(0, 1, 1, 0.9);
	HCUI:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",14,-34);
	HCUI:SetPoint("BOTTOMRIGHT",AuctionFrameBrowse,"BOTTOMRIGHT",70,12);
	HCUI:SetFrameLevel(20)
	HCUI:Hide();
	HCUI.close = CreateFrame("Button",nil,HCUI, "UIPanelButtonTemplate");
	HCUI.close:SetSize(90,30);
	HCUI.close:SetPoint("CENTER",HCUI,"CENTER",0,-40);
	HCUI.close:SetText("关闭");
	HCUI.close:Hide();
	HCUI.close:HookScript("OnClick",function(self)
		HCUI:Hide()
	end)
	local jinduW,jinduH = 300,30
	HCUI.jindu = CreateFrame("Frame", nil, HCUI);
	HCUI.jindu:SetSize(jinduW,jinduH);
	HCUI.jindu:SetPoint("CENTER",HCUI,"CENTER",0,40);
	HCUI.jindu.tex = HCUI.jindu:CreateTexture(nil, "BORDER");
	HCUI.jindu.tex:SetTexture("interface/raidframe/raid-bar-hp-fill.blp");
	HCUI.jindu.tex:SetColorTexture(0.3, 0.7, 0.1, 1)
	HCUI.jindu.tex:SetSize(jinduW-6,jinduH-7.6);
	HCUI.jindu.tex:SetPoint("LEFT",HCUI.jindu,"LEFT",3,0);
	HCUI.jindu.edg = CreateFrame("Frame", nil, HCUI.jindu,"BackdropTemplate");
	HCUI.jindu.edg:SetBackdrop( { edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 13,});
	HCUI.jindu.edg:SetBackdropBorderColor(0, 1, 1, 0.9);
	HCUI.jindu.edg:SetAllPoints(HCUI.jindu)
	HCUI.jindu.edg.t = HCUI.jindu.edg:CreateFontString();
	HCUI.jindu.edg.t:SetPoint("CENTER",HCUI.jindu.edg,"CENTER",0,0);
	HCUI.jindu.edg.t:SetFont(GameFontNormal:GetFont(), 13,"OUTLINE")
	HCUI.jindu.edg.t:SetText("正在获取数据...");
	----
	local huancunjiaqian = CreateFrame("Frame")
	huancunjiaqian:Hide()
	local chushikuandu=jinduW-6

	local AHlinshiInfoList = {}
	local AHlinshiInfoListNum=0
	local AHlinshiInfoListID=0
	local function Save_Data()
		local shujuyuan = PIG.AHPlus.Data[FWQrealm]
		for _,v in pairs(shujuyuan) do
			v[2]=false
		end
		for i=1,AHlinshiInfoListNum do
			local name=AHlinshiInfoList[i][1]
			local xianzaidanjia = AHlinshiInfoList[i][3]/AHlinshiInfoList[i][2]
			if xianzaidanjia>0 then
		   		if PIG.AHPlus.Data[FWQrealm][name] then
		   			if PIG.AHPlus.Data[FWQrealm][name][2] then
		   				if xianzaidanjia<PIG.AHPlus.Data[FWQrealm][name][1] then
		   					PIG.AHPlus.Data[FWQrealm][name][1]=xianzaidanjia
		   				end
		   			else
		   				PIG.AHPlus.Data[FWQrealm][name]={xianzaidanjia,true,GetServerTime()}
		   			end
		   		else
		   			PIG.AHPlus.Data[FWQrealm][name]={xianzaidanjia,true,GetServerTime()}
		   		end
		   	end
		end
		HCUI.jindu.edg.t:SetText("数据缓存完毕");
		for i = 1, hang_NUM do
			_G["piglist_item_"..i]:Hide()
		end
		listF.tishi:SetText('未发现物品');
		SetSelectedAuctionItem("list", 0);
		--
		AuctionFrameBrowse_Search()
		HCUI.close:Show();
	end
	local function huancunData_wow()
		local youweihuoqudaodexinxi = false
		for i=1,AHlinshiInfoListNum do
			if #AHlinshiInfoList[i]==0 then
				local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice =  GetAuctionItemInfo("list", i);
				if name and name~="" and name~=" " then
					AHlinshiInfoListID=AHlinshiInfoListID+1
			   		AHlinshiInfoList[i]={name,count,buyoutPrice}
		   			HCUI.jindu.edg.t:SetText("正在缓存数据("..AHlinshiInfoListID.."/"..AHlinshiInfoListNum..")");
					HCUI.jindu.tex:SetWidth(chushikuandu*(AHlinshiInfoListID/AHlinshiInfoListNum))
			   	else
			   		youweihuoqudaodexinxi = true
				end
			end
		end
		if youweihuoqudaodexinxi and AuctionFrame:IsShown() then
			C_Timer.After(0.3,huancunData_wow)
		else
			Save_Data()
		end
	end
	local function huancunData(totalAuctions)
		AHlinshiInfoList = {}
		AHlinshiInfoListID=0
		AHlinshiInfoListNum=totalAuctions
		for i=1,totalAuctions do
			AHlinshiInfoList[i]={}
		end
		C_Timer.After(0.1,huancunData_wow)
	end

	huancunjiaqian:HookScript("OnUpdate",function(self,sss)
		local _, totalAuctions = GetNumAuctionItems("list");
		local canQuery,canQueryAll = CanSendAuctionQuery()
		if canQuery then
			self:Hide()
			HCUI.jindu.edg.t:SetText("数据获取完毕,开始缓存...");
			HCUI.jindu.tex:SetWidth(0)
			huancunData(totalAuctions)
		else
			HCUI.jindu.edg.t:SetText("正在获取数据("..totalAuctions.."/"..self.AllNum..")");
			HCUI.jindu.tex:SetWidth(chushikuandu*(totalAuctions/self.AllNum))
		end
	end)

	local function huoquzongshu()
		local suozhog,canQueryAll = CanSendAuctionQuery()
		if suozhog then
			local _, ALL_totalAuctions = GetNumAuctionItems("list");
			huancunjiaqian.AllNum=ALL_totalAuctions		
			QueryAuctionItems("", nil, nil, 0, nil, nil, true, false, nil)
			huancunjiaqian:Show()
		else
			if HCUI:IsShown() then
				C_Timer.After(0.32,huoquzongshu)
			end
		end
	end
	AuctionFrameBrowse.History:HookScript("OnShow",function(self)
		local _,canQueryAll = CanSendAuctionQuery()
		if canQueryAll and not HCUI:IsShown() then
			self:Enable()
		else
			self:Disable()
		end
	end)
	AuctionFrameBrowse.History:SetScript("OnClick", function(self, button)
		self:Disable()
		HCUI:Show();
		HCUI.close:Hide();
		HCUI.jindu.edg.t:SetText("正在获取数据...");
		HCUI.jindu.tex:SetWidth(0)
		qingkongtiaojian()
		AuctionFrameBrowse_Search()
		C_Timer.After(0.64,huoquzongshu)
	end)
	---------------------
	for i = 1, 33 do
		local huizhangG = BrowseWowTokenResults:CreateFontString("huizhangG_"..i);
		if i==1 then
			huizhangG:SetPoint("TOPLEFT",BrowseWowTokenResults,"TOPLEFT",2,0);
		elseif i==19 then
			huizhangG:SetPoint("TOPRIGHT",BrowseWowTokenResults,"TOPRIGHT",-4,-50);
		else
			huizhangG:SetPoint("TOPLEFT",_G["huizhangG_"..(i-1)],"BOTTOMLEFT",0,-4);
		end
		huizhangG:SetFont(ChatFontNormal:GetFont(), 13);
		huizhangG:SetJustifyH("LEFT");
	end
	local function Update_huizhangG()
		local lishihuizhangG = PIG.AHPlus.Tokens
		local SHUJUNUM = #lishihuizhangG
		local shujukaishiid = 0
		if SHUJUNUM>33 then
			shujukaishiid=SHUJUNUM-33
		end
		for i = 1, 33 do
			local shujuid = i+shujukaishiid
			if lishihuizhangG[shujuid] then
				local tiem1 = date("%Y-%m-%d %H:%M",lishihuizhangG[shujuid][1])
				local jinbiV = lishihuizhangG[shujuid][2] or 0
				local jinbiV = (jinbiV/10000)
				_G["huizhangG_"..i]:SetText(tiem1.."：|cffFFFF00"..jinbiV.."G|r")
			end
		end
	end
	BrowseWowTokenResults:HookScript("OnShow",function(self)
		AuctionFrameBrowse.piglist:Hide()
		AuctionFrameBrowse.ShowHide:Hide()
		huoquhuizhangjiageG()
		Update_huizhangG()
	end)
	BrowseWowTokenResults:HookScript("OnHide",function(self)
		AuctionFrameBrowse.piglist:Show()
		AuctionFrameBrowse.ShowHide:Show()
	end)
	AuctionFrameBrowse:HookScript("OnEvent",function(self,event,arg1,arg2)
		if event=="AUCTION_ITEM_LIST_UPDATE" then
			local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
			listF.numBatchAuctions=numBatchAuctions
			listF.totalAuctions=totalAuctions
			gengxinlist(listF.Scroll)
		end
	end)
	AuctionFrame:HookScript("OnShow",function(self)
		huoquhuizhangjiageG()
		piglist_biaoti_8:Hide()
		huancunjiaqian:Hide()
		HCUI:Hide();
		HCUI.close:Hide();
		listF.tishi:SetText('选择搜索条件,然后按下"搜索"');
		for i = 1, hang_NUM do
			local fujiks = _G["piglist_item_"..i]
	    	fujiks:Hide()
	    	fujiks.chushouzhe:Hide()
	    end
		SortAuctionSetSort("list","unitprice", false)
		piglist_biaoti_6.paixu:Show()
		piglist_biaoti_6.paixu:SetRotation(-0, 0.5, 0.5)
		SetSelectedAuctionItem("list", 0);
	end)
	AuctionFrame:HookScript("OnHide",function(self)
		huancunjiaqian:Hide()
	end)
	--收藏夹----------------------------
	PIG.AHPlus["Coll"] = PIG.AHPlus["Coll"] or addonTable.Default.AHPlus["Coll"]
	local collW,collY = 24,24
	AuctionFrameBrowse.coll = CreateFrame("Button",nil,AuctionFrameBrowse);
	local coll=AuctionFrameBrowse.coll
	coll:SetSize(collW,collY);
	coll:SetPoint("LEFT",BrowseSearchButton,"RIGHT",20,8);
	coll.TexC = coll:CreateTexture(nil, "BORDER");
	coll.TexC:SetTexture("interface/lootframe/toast-star.blp");
	coll.TexC:SetSize(collW*1.5,collY*1.5);
	coll.TexC:SetPoint("TOPLEFT",coll,"TOPLEFT",0,0);
	coll:SetScript("OnMouseDown", function (self)
		self.TexC:SetPoint("TOPLEFT",coll,"TOPLEFT",1.5,-1.5);
	end);
	coll:SetScript("OnMouseUp", function (self)
		self.TexC:SetPoint("TOPLEFT",coll,"TOPLEFT",0,0);
	end);
	coll:SetScript("OnClick", function (self)
		if self.list:IsShown() then
			self.list:Hide()
		else
			self.list:Show()
		end
	end);
	coll.list = CreateFrame("Frame", nil, coll,"BackdropTemplate")
	coll.list:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = false, tileSize = 0, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 } });
	coll.list:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPRIGHT",72,-12);--72
	coll.list:SetPoint("BOTTOMRIGHT",AuctionFrameBrowse,"BOTTOMRIGHT",250,10);--250
	coll.list:Hide()
	coll.list:EnableMouse(true)
	coll.list:SetToplevel(true)
	coll.list.Close = CreateFrame("Button",nil,coll.list, "UIPanelCloseButton");  
	coll.list.Close:SetSize(30,30);
	coll.list.Close:SetPoint("TOPRIGHT", coll.list, "TOPRIGHT", 0, 0);
	coll.list.title = coll.list:CreateFontString();
	coll.list.title:SetPoint("TOP", coll.list, "TOP", -2, -6);
	coll.list.title:SetFontObject(GameFontNormal);
	coll.list.title:SetText('收藏夹');
	coll.list.tishi = CreateFrame("Frame", nil, coll.list);
	coll.list.tishi:SetSize(20,20);
	coll.list.tishi:SetPoint("TOPLEFT",coll.list,"TOPLEFT",5,-5);
	coll.list.tishi.Texture = coll.list.tishi:CreateTexture(nil, "BORDER");
	coll.list.tishi.Texture:SetTexture("interface/common/help-i.blp");
	coll.list.tishi.Texture:SetSize(30,30);
	coll.list.tishi.Texture:SetPoint("CENTER");
	coll.list.tishi:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("提示：")
		GameTooltip:AddLine("\124cff00ff001、在浏览列表右键物品名可加入收藏。\n2、收藏列表物品左键搜索，右键删除。\124r")
		GameTooltip:Show();
	end);
	coll.list.tishi:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	--
	local collhang_NUM = 18
	local function gengxinlistcoll(self)
		for i = 1, collhang_NUM do
			local listFGV = _G["colllistitem_"..i]
	    	listFGV:Hide()
	    end
	    local datainfo=PIG.AHPlus["Coll"]
		local zongshuNum=#datainfo
		if zongshuNum>0 then
			FauxScrollFrame_Update(self, zongshuNum, collhang_NUM, hang_Height);
			local offset = FauxScrollFrame_GetOffset(self);
		    for i = 1, collhang_NUM do
		    	local listFGV = _G["colllistitem_"..i]
				local AHdangqianH = i+offset;
				if datainfo[AHdangqianH] then
					listFGV:Show()
					listFGV.icon:SetTexture(datainfo[AHdangqianH][2])
					listFGV.link:SetText(datainfo[AHdangqianH][1])
					local r, g, b, hex = GetItemQualityColor(datainfo[AHdangqianH][3])
					listFGV.link:SetTextColor(r, g, b, hex);
					listFGV:SetID(AHdangqianH);
				end
			end
		end
	end
	coll.list.Scroll = CreateFrame("ScrollFrame",nil,coll.list, "FauxScrollFrameTemplate");  
	coll.list.Scroll:SetPoint("TOPLEFT",coll.list,"TOPLEFT",0,-32);
	coll.list.Scroll:SetPoint("BOTTOMRIGHT",coll.list,"BOTTOMRIGHT",-26,4);
	coll.list.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinlistcoll)
	end)
	--创建行
	local collhang_Width =coll.list.Scroll:GetWidth()
	for i = 1, collhang_NUM do
		local colllistitem = CreateFrame("Button", "colllistitem_"..i, coll.list);
		colllistitem:SetSize(collhang_Width, hang_Height);
		if i==1 then
			colllistitem:SetPoint("TOP",coll.list.Scroll,"TOP",5,0);
		else
			colllistitem:SetPoint("TOP",_G["colllistitem_"..(i-1)],"BOTTOM",0,-1.5);
		end
		colllistitem:RegisterForClicks("LeftButtonUp","RightButtonUp")
		colllistitem:Hide()
		colllistitem.xuanzhong = colllistitem:CreateTexture(nil, "BORDER");
		colllistitem.xuanzhong:SetTexture("interface/helpframe/helpframebutton-highlight.blp");
		colllistitem.xuanzhong:SetTexCoord(0.00,0.00,0.00,0.58,1.00,0.00,1.00,0.58);
		colllistitem.xuanzhong:SetAllPoints(colllistitem)
		colllistitem.xuanzhong:SetBlendMode("ADD")
		colllistitem.xuanzhong:Hide()
		if i~=collhang_NUM then
			colllistitem.line = colllistitem:CreateLine()
			colllistitem.line:SetColorTexture(1,1,1,0.2)
			colllistitem.line:SetThickness(1);
			colllistitem.line:SetStartPoint("BOTTOMLEFT",0,0)
			colllistitem.line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		colllistitem.icon = colllistitem:CreateTexture(nil, "BORDER");
		colllistitem.icon:SetSize(hang_Height,hang_Height);
		colllistitem.icon:SetPoint("LEFT", colllistitem, "LEFT", 0,0);
		colllistitem.link = colllistitem:CreateFontString();
		colllistitem.link:SetWidth(colllistitem:GetWidth()-hang_Height);
		colllistitem.link:SetPoint("LEFT", colllistitem.icon, "RIGHT", 0,0);
		colllistitem.link:SetFont(ChatFontNormal:GetFont(), 13);
		colllistitem.link:SetJustifyH("LEFT");
		colllistitem:SetScript("OnEnter", function(self)
			self.xuanzhong:Show()
		end);
		colllistitem:SetScript("OnLeave", function(self)
			self.xuanzhong:Hide()
		end);
		colllistitem:SetScript("OnClick", function (self,button)
			local caozuoID = self:GetID()
			if button=="LeftButton" then
				local datakey=PIG.AHPlus["Coll"][caozuoID][1]
				BrowseName:SetText(datakey)
				AuctionFrameBrowse_Search()
			else
				table.remove(PIG.AHPlus["Coll"],caozuoID)
				gengxinlistcoll(coll.list.Scroll)
			end
		end);
	end
	coll.list:SetScript("OnShow", function (self)
		piglist_biaoti_8:Hide()
		for i=1,hang_NUM do
			local listFGV = _G["piglist_item_"..i].chushouzhe:Hide()
		end
		gengxinlistcoll(self.Scroll)
	end);
	function listF:Gengxinlistcoll()
		gengxinlistcoll(coll.list.Scroll)	
	end	
	---拍卖页
	AuctionFrameAuctions.SellList = CreateFrame("Frame", nil, AuctionFrameAuctions,"BackdropTemplate")
	local SellListF=AuctionFrameAuctions.SellList
	SellListF:SetBackdrop( { bgFile = "interface/characterframe/ui-party-background.blp",edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = false, tileSize = 0, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 } });
	SellListF:SetPoint("TOPLEFT",AuctionFrameAuctions,"TOPLEFT",216,-222);
	SellListF:SetPoint("BOTTOMRIGHT",AuctionFrameAuctions,"BOTTOMRIGHT",70,38);
	SellListF:SetFrameLevel(10)
	SellListF:EnableMouse(true)
	SellListF:Hide()
	SellListF.Close = CreateFrame("Button",nil,SellListF, "UIPanelCloseButton");  
	SellListF.Close:SetSize(30,30);
	SellListF.Close:SetPoint("TOPRIGHT", SellListF, "TOPRIGHT", 1, 0);
	SellListF.tishi = SellListF:CreateFontString();
	SellListF.tishi:SetPoint("CENTER", SellListF, "CENTER", 0,0);
	SellListF.tishi:SetFontObject(GameFontNormal);
	SellListF.tishi:SetText('没有此物品在售卖，无参考价！');
	--
	local SellxulieID = {"","竞标价","一口价","一口单价","数量","剩余","出售者"}
	local SellxulieID_www = {30,106,106,106,42,60,134}
	for i=1,#SellxulieID do
		local Buttonxx = CreateFrame("Button","SellList_biaoti_"..i,SellListF);
		Buttonxx:SetSize(SellxulieID_www[i],anniuH);
		if i==1 then
			Buttonxx:SetPoint("TOPLEFT",SellListF,"TOPLEFT",3,-3);
		else
			Buttonxx:SetPoint("LEFT",_G["SellList_biaoti_"..(i-1)],"RIGHT",0,0);
		end
		Buttonxx.TexC = Buttonxx:CreateTexture(nil, "BORDER");
		Buttonxx.TexC:SetTexture("interface/friendsframe/whoframe-columntabs.blp");
		Buttonxx.TexC:SetTexCoord(0.08,0.00,0.08,0.59,0.91,0.00,0.91,0.59);
		Buttonxx.TexC:SetPoint("TOPLEFT",Buttonxx,"TOPLEFT",2,0);
		Buttonxx.TexC:SetPoint("BOTTOMRIGHT",Buttonxx,"BOTTOMRIGHT",-0.8,0);
		Buttonxx.TexL = Buttonxx:CreateTexture(nil, "BORDER");
		Buttonxx.TexL:SetTexture("interface/friendsframe/whoframe-columntabs.blp");
		Buttonxx.TexL:SetTexCoord(0.00,0.00,0.00,0.59,0.08,0.00,0.08,0.59);
		Buttonxx.TexL:SetPoint("TOPRIGHT",Buttonxx.TexC,"TOPLEFT",0,0);
		Buttonxx.TexL:SetPoint("BOTTOMRIGHT",Buttonxx.TexC,"BOTTOMLEFT",0,0);
		Buttonxx.TexL:SetWidth(2)
		Buttonxx.TexR = Buttonxx:CreateTexture(nil, "BORDER");
		Buttonxx.TexR:SetTexture("interface/friendsframe/whoframe-columntabs.blp");
		Buttonxx.TexR:SetTexCoord(0.91,0.00,0.91,0.59,0.97,0.00,0.97,0.59);
		Buttonxx.TexR:SetPoint("TOPLEFT",Buttonxx.TexC,"TOPRIGHT",0,0);
		Buttonxx.TexR:SetPoint("BOTTOMLEFT",Buttonxx.TexC,"BOTTOMRIGHT",0,0);
		Buttonxx.TexR:SetWidth(2)
		Buttonxx.title = Buttonxx:CreateFontString();
		Buttonxx.title:SetFontObject(CombatLogFont);
		Buttonxx.title:SetText(SellxulieID[i]);
		if SellxulieID[i]=="竞标价" or SellxulieID[i]=="一口价" or SellxulieID[i]=="一口单价" then
			Buttonxx.title:SetPoint("RIGHT", Buttonxx, "RIGHT", -8, 0);
		else
			Buttonxx.title:SetPoint("LEFT", Buttonxx, "LEFT", 6, 0);
		end
	end
	local spellhangnum, hang_Height1= 6,hang_Height+4
	local function gengxinSpelllist()
		SellListF.tishi:SetText('没有此物品在售，无参考价！');
		for i = 1, spellhangnum do
		   	local listFGV = _G["SellList_item_"..i]
		   	listFGV:Hide()
		   	listFGV.yajia.hang_count=count
			listFGV.yajia.hang_minBid=minBid
			listFGV.yajia.hang_buyoutPrice=buyoutPrice
		end
		local numBatchAuctions = GetNumAuctionItems("list");
		if numBatchAuctions>0 then
			SellListF.tishi:SetText('');
			for i = 1, spellhangnum do
				local listFGV = _G["SellList_item_"..i]
				local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, 
	   			highBidder, bidderFullName, owner =  GetAuctionItemInfo("list", i);
				if name then
					if i==1 then
						local chushouwupinname = GetAuctionSellItemInfo();
			   			if chushouwupinname~=name then
							SellListF.tishi:SetText('查询超时，请稍后再试！');
							break
			   			end
			   		end
			   		listFGV.yajia.hang_count=count
					listFGV.yajia.hang_minBid=minBid
					listFGV.yajia.hang_buyoutPrice=buyoutPrice
			   		Update_GGG(listFGV.jingbiao,minBid)
					Update_GGG(listFGV.yikou,buyoutPrice)
					Update_GGG(listFGV.yikoudanjia,buyoutPrice/count)
					listFGV.count:SetText(count);
					listFGV.chushouzhe:SetText(owner);
					local timeleft = GetAuctionItemTimeLeft("list", i)
					listFGV.TimeLeft:SetText(shengyuTime[timeleft]);
					listFGV:Show()
		   		end
			end
		end
		SellListF:Show()
	end
	local hang_Width1 =SellListF:GetWidth()-10
	for i = 1, spellhangnum do
		local listFitem = CreateFrame("Button", "SellList_item_"..i, SellListF);
		listFitem:SetSize(hang_Width1, hang_Height1);
		if i==1 then
			listFitem:SetPoint("TOP",SellListF,"TOP",0,-28);
		else
			listFitem:SetPoint("TOP",_G["SellList_item_"..(i-1)],"BOTTOM",0,-2);
		end
		listFitem:Hide()
	
		listFitem.line = listFitem:CreateLine()
		listFitem.line:SetColorTexture(1,1,1,0.2)
		listFitem.line:SetThickness(1);
		listFitem.line:SetStartPoint("TOPLEFT",0,0)
		listFitem.line:SetEndPoint("TOPRIGHT",0,0)

		listFitem.yajia = CreateFrame("Button",nil,listFitem, "UIPanelButtonTemplate");
		listFitem.yajia:SetSize(SellxulieID_www[1],22);
		listFitem.yajia:SetPoint("LEFT", listFitem, "LEFT", 0,0);
		listFitem.yajia:SetText("压");
		listFitem.yajia:SetScript("OnClick", function(self, button)
			local count=self.hang_count
			local minBid=self.hang_minBid
			local buyoutPrice=self.hang_buyoutPrice
			local BiddanjiaGG = minBid/count
			local buyoutdanjiaGG = buyoutPrice/count
			local wanjiaN, realm = UnitFullName("player");

			local priceType =UIDropDownMenu_GetSelectedValue(PriceDropDown) or 2
			if priceType == 1  then
				if owner~=wanjiaN then
					if PIG.AHPlus.yajingbiao then
						MoneyInputFrame_SetCopper(StartPrice, BiddanjiaGG-1);
					else
						MoneyInputFrame_SetCopper(StartPrice, buyoutdanjiaGG-1);
					end
					MoneyInputFrame_SetCopper(BuyoutPrice, buyoutdanjiaGG-1);
				else
					MoneyInputFrame_SetCopper(StartPrice, BiddanjiaGG);
					MoneyInputFrame_SetCopper(BuyoutPrice, buyoutdanjiaGG);
				end
			else
				local meizushu = AuctionsStackSizeEntry:GetNumber()
				local ZBiddanjiaGG = meizushu*BiddanjiaGG
				local ZbuyoutdanjiaGG = meizushu*buyoutdanjiaGG
				if owner~=wanjiaN then
					if PIG.AHPlus.yajingbiao then
						MoneyInputFrame_SetCopper(StartPrice, ZBiddanjiaGG-1);
					else
						MoneyInputFrame_SetCopper(StartPrice, ZbuyoutdanjiaGG-1);
					end
					MoneyInputFrame_SetCopper(BuyoutPrice, ZbuyoutdanjiaGG-1);
				else
					MoneyInputFrame_SetCopper(StartPrice, ZBiddanjiaGG);
					MoneyInputFrame_SetCopper(BuyoutPrice, ZbuyoutdanjiaGG);
				end
			end
		end)
		--
		listFitem.jingbiao=chuangjianjinbiF(listFitem,listFitem.yajia,SellxulieID_www[2],hang_Height1)
		--
		listFitem.yikou=chuangjianjinbiF(listFitem,listFitem.jingbiao,SellxulieID_www[3],hang_Height1)
		--
		listFitem.yikoudanjia=chuangjianjinbiF(listFitem,listFitem.yikou,SellxulieID_www[4],hang_Height1)
		---
		listFitem.count = listFitem:CreateFontString();
		listFitem.count:SetWidth(SellxulieID_www[5]);
		listFitem.count:SetPoint("LEFT", listFitem.yikoudanjia, "RIGHT", 0,0);
		listFitem.count:SetFont(ChatFontNormal:GetFont(), 13);
		listFitem.count:SetTextColor(0, 1, 1, 1);
		--
		listFitem.TimeLeft = listFitem:CreateFontString();
		listFitem.TimeLeft:SetWidth(SellxulieID_www[6]);
		listFitem.TimeLeft:SetPoint("LEFT", listFitem.count, "RIGHT", 0,0);
		listFitem.TimeLeft:SetFont(ChatFontNormal:GetFont(), 13);
		--
		listFitem.chushouzhe = listFitem:CreateFontString();
		listFitem.chushouzhe:SetWidth(SellxulieID_www[7]);
		listFitem.chushouzhe:SetPoint("LEFT", listFitem.TimeLeft, "RIGHT", 2,0);
		listFitem.chushouzhe:SetFont(ChatFontNormal:GetFont(), 13,"OUTLINE");
		listFitem.chushouzhe:SetJustifyH("LEFT");
	end
	AuctionFrameAuctions:HookScript("OnHide",function()
		SellListF:Hide()
	end)
	--压价按钮
	AuctionFrameAuctions.yajingbiao =ADD_Checkbutton(nil,AuctionFrameAuctions,-20,"TOPLEFT",AuctionFrameAuctions,"TOPLEFT",70,-286,"同时压竞标价","选中后压一口价同时压竞标价")
	AuctionFrameAuctions.yajingbiao.Text:SetTextColor(0, 1, 0, 0.8);
	AuctionFrameAuctions.yajingbiao:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG.AHPlus.yajingbiao=true
		else
			PIG.AHPlus.yajingbiao=false
		end
	end);
	if PIG.AHPlus.yajingbiao then
		AuctionFrameAuctions.yajingbiao:SetChecked(true)
	end

	AuctionsItemButton:HookScript("OnEvent",function(self,event,arg1,arg2)
		if event=="NEW_AUCTION_UPDATE" then
			AuctionsItemButtonCount:Hide();
			local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount, itemID = GetAuctionSellItemInfo();
			if name then
				SortAuctionSetSort("list","unitprice", false)
				piglist_biaoti_6.paixu:Show()
				piglist_biaoti_6.paixu:SetRotation(-0, 0.5, 0.5)
				-- 	QueryAuctionItems(name, nil, nil, 0, nil, nil, false, true, nil)
				qingkongtiaojian()
				BrowseName:SetText(name)
				AuctionFrame.maichuxunjia=true
				AuctionFrameBrowse_Search()
				AuctionFrame.maichuxunjia=false
				if (C_WowTokenPublic.IsAuctionableWowToken(itemID)) then
				else
					if ( totalCount > 1 ) then
						AuctionsStackSizeEntry:Show();
						AuctionsStackSizeMaxButton:Show();
						AuctionsNumStacksEntry:Show();
						AuctionsNumStacksMaxButton:Show();
						PriceDropDown:Show();
						UpdateMaximumButtons();
					else	
						AuctionsStackSizeEntry:Hide();
						AuctionsStackSizeMaxButton:Hide();
						AuctionsNumStacksEntry:Hide();
						AuctionsNumStacksMaxButton:Hide();
					end
				end
				C_Timer.After(0.2,gengxinSpelllist)
			else
				AuctionsStackSizeEntry:Hide();
				AuctionsStackSizeMaxButton:Hide();
				AuctionsNumStacksEntry:Hide();
				AuctionsNumStacksMaxButton:Hide();
				SellListF:Hide()
			end
		end
	end)
end
--
local AuctionFramejiazai = CreateFrame("FRAME")
AuctionFramejiazai:SetScript("OnEvent", function(self, event, arg1)
	if PIG.AHPlus.Open then
		if arg1 == "Blizzard_AuctionUI" then
			ADD_AHPlus()
			AuctionFramejiazai:UnregisterEvent("ADDON_LOADED")
		end
	else
		AuctionFramejiazai:UnregisterEvent("ADDON_LOADED")
	end
end)
------------
local tooltipAHOpen="在拍卖行浏览列表显示一口价，和涨跌百分比。界面增加一个缓存单价按钮，时光徽章界面显示历史价格";
fuFrame.AHOpen =ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"启用拍卖增强",tooltipAHOpen)
fuFrame.AHOpen:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.AHPlus.Open=true;
		fuFrame.AHtooltip:Enable()
		if IsAddOnLoaded("Blizzard_AuctionUI") then
			ADD_AHPlus()
		else
			AuctionFramejiazai:RegisterEvent("ADDON_LOADED")
		end
	else
		PIG.AHPlus.Open=false;
		Pig_Options_RLtishi_UI:Show()
		fuFrame.AHtooltip:Disable()
	end
end);
--
fuFrame.AHtooltip =ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-80,"鼠标提示AH价钱","鼠标提示AH价钱（AH没有价格的物品不会提示）")
fuFrame.AHtooltip:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.AHPlus.AHtooltip=true;
	else
		PIG.AHPlus.AHtooltip=false;
	end
end);
GameTooltip:HookScript("OnTooltipSetItem", function(self)
	if PIG.AHPlus.Open and PIG.AHPlus.AHtooltip then
		local name, link = self:GetItem()
		if link then
			local  bindType = select(14, GetItemInfo(link))
			if bindType~=1 then
				local FWQrealm = GetRealmName()
				if PIG.AHPlus.Data[FWQrealm] and PIG.AHPlus.Data[FWQrealm][name] then
					local jiluTime = PIG.AHPlus.Data[FWQrealm][name][3] or 1660000000
					local jiluTime = date("%m-%d %H:%M",jiluTime)
					self:AddDoubleLine("拍卖单价("..jiluTime.."):",GetMoneyString(PIG.AHPlus.Data[FWQrealm][name][1]))
				else
					self:AddDoubleLine("拍卖单价(尚未缓存):","--")
				end
			end
		end
	end
end)
---
fuFrame.CZAHinfo = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");  
fuFrame.CZAHinfo:SetSize(80,20);
fuFrame.CZAHinfo:SetPoint("TOPRIGHT",fuFrame,"TOPRIGHT",-20,-20);
fuFrame.CZAHinfo:SetText("重置数据");
fuFrame.CZAHinfo:SetScript("OnClick", function ()
	StaticPopup_Show ("CZAHZENGQIANGINFO");
end);
StaticPopupDialogs["CZAHZENGQIANGINFO"] = {
	text = "此操作将\124cffff0000重置\124r拍卖增强数据，需重载界面。\n确定重置?",
	button1 = "确定",
	button2 = "取消",
	OnAccept = function()
		PIG.AHPlus=addonTable.Default.AHPlus
		PIG.AHPlus.Open=true
		ReloadUI()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}

------------------
fuFrame:SetScript("OnShow", function (self)
	if PIG.AHPlus.Open then
		fuFrame.AHOpen:SetChecked(true)
	else
		fuFrame.AHtooltip:Disable()
	end
	if PIG.AHPlus.AHtooltip then
		fuFrame.AHtooltip:SetChecked(true)
	end
end);
------------------------
addonTable.AHPlus = function()
	huoquhuizhangjiageG()
	if PIG.AHPlus.Open then
		ITEM_QUALITY_COLORS[-1]={ r = 0, g = 0, b = 0, hex = "", color = 0 };
		AuctionFramejiazai:RegisterEvent("ADDON_LOADED")
	end
end