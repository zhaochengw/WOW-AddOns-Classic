local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local fuFrame=Pig_Options_RF_TAB_5_UI
--==========================================
local yinhangmorengezishu={}
local _, _, _, tocversion = GetBuildInfo()
if tocversion<20000 then
	yinhangmorengezishu={24,6}
else
	yinhangmorengezishu={28,7}
end
----==============
local bagID = {0,1,2,3,4}
local bankID = {-1,5,6,7,8,9,10,11}
local zhengliIcon="interface/containerframe/bags.blp"	

local BAOGUOdangeW,meihang=ContainerFrame1Item1:GetWidth()+5,8
local paishuID,kongbuID=0,0
local function shuaxinKEYweizhi(frame, size, id)
	local name = frame:GetName();
	_G[name.."Portrait"]:Show();
	_G[name.."CloseButton"]:Show();
	if IsBagOpen(0) or IsBagOpen(1) or IsBagOpen(2) or IsBagOpen(3) or IsBagOpen(4) then
	else
		BAGheji_UI:Hide()
	end
	frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -560, 300);
end
local function shuaxinBAGweizhi(frame, size, id)
	local name = frame:GetName();
	_G[name.."BackgroundTop"]:Hide();
	_G[name.."BackgroundMiddle1"]:Hide();
	_G[name.."BackgroundMiddle2"]:Hide();
	_G[name.."BackgroundBottom"]:Hide();
	_G[name.."Background1Slot"]:Hide();
	_G[name.."Name"]:Hide();
	_G[name.."PortraitButton"]:Hide();
	_G[name.."Portrait"]:Hide();
	_G[name.."CloseButton"]:Hide();
	if tocversion>29999 then
		BagItemSearchBox:SetParent(BAGheji_UI);
		BagItemSearchBox:ClearAllPoints();
		BagItemSearchBox:SetPoint("TOPLEFT",BAGheji_UI,"TOPLEFT",70,-28);
		--BagItemSearchBox.anchorBag = self;
		BagItemSearchBox:Show();
		BagItemAutoSortButton:SetParent(BAGheji_UI);
		BagItemAutoSortButton:ClearAllPoints();
		BagItemAutoSortButton:SetPoint("TOPLEFT",BAGheji_UI,"TOPLEFT",240,-29);
		BagItemAutoSortButton:Show();
	end
	if IsBagOpen(-2) then
		_G["ContainerFrame"..IsBagOpen(-2)]:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -560, 300);
	end
	if id==0 then
		paishuID,kongbuID=0,0
		_G[name.."MoneyFrame"]:Show()
		_G[name.."MoneyFrame"]:SetPoint("TOPRIGHT", BAGheji_UI.moneyframe, "TOPRIGHT", 6, -5);
		_G[name.."AddSlotsButton"]:SetShown(false);
		_G[name.."MoneyFrame"]:SetParent(BAGheji_UI);
	else
		_G[name.."MoneyFrame"]:Hide()
	end
	BAGheji_UI:SetFrameLevel(99)
	BAGheji_UI:Show()
	BAGheji_UI:Raise()
	local Fid=IsBagOpen(id)
	local hangShu=math.ceil((size-kongbuID)/meihang)--行数
	local kongyu=hangShu*meihang-(size-kongbuID)--空余
	local Newhangshu=paishuID+hangShu
	for slot=1,size do
		--_G["ContainerFrame"..Fid.."Item"..slot]:SetFrameLevel(10)
		_G["ContainerFrame"..Fid.."Item"..slot]:ClearAllPoints();
		if slot==1 then
			_G["ContainerFrame"..Fid.."Item"..slot]:SetPoint("TOPRIGHT", BAGheji_UI.wupin, "TOPRIGHT", -(kongyu*BAOGUOdangeW)-6, -Newhangshu*BAOGUOdangeW+38);
		else
			local yushu=math.fmod((slot+kongyu-1),meihang)
			if yushu==0 then
				_G["ContainerFrame"..Fid.."Item"..slot]:SetPoint("BOTTOMLEFT", _G["ContainerFrame"..Fid.."Item"..(slot-1)], "TOPLEFT", (meihang-1)*BAOGUOdangeW, 4);
			else
				_G["ContainerFrame"..Fid.."Item"..slot]:SetPoint("RIGHT", _G["ContainerFrame"..Fid.."Item"..(slot-1)], "LEFT", -5, 0);
			end
		end
	end
	paishuID,kongbuID=Newhangshu,kongyu
	frame:SetHeight(0);
	BAGheji_UI:SetHeight(BAOGUOdangeW*paishuID+88);
end
---------------------
local BKdangeW,BKmeihang=BankFrameItem1:GetWidth()+5,12
local qishihang=math.ceil(yinhangmorengezishu[1]/BKmeihang)--行数
local qishikongyu=qishihang*BKmeihang-yinhangmorengezishu[1]--空余
local BKpaishuID,BKkongbuID=0,0

local function shuaxinBANKweizhi(frame, size, id)
	if id==5 then
		BKpaishuID,BKkongbuID=qishihang,qishikongyu
	elseif id==6 then
		if not IsBagOpen(id-1) then
			BKpaishuID,BKkongbuID=qishihang,qishikongyu
		end
	elseif id==7 then
		if not IsBagOpen(id-1) and not IsBagOpen(id-2) then
			BKpaishuID,BKkongbuID=qishihang,qishikongyu
		end
	elseif id==8 then
		if not IsBagOpen(id-1) and not IsBagOpen(id-2) and not IsBagOpen(id-3) then
			BKpaishuID,BKkongbuID=qishihang,qishikongyu
		end
	elseif id==9 then
		if not IsBagOpen(id-1) and not IsBagOpen(id-2) and not IsBagOpen(id-3) and not IsBagOpen(id-4) then
			BKpaishuID,BKkongbuID=qishihang,qishikongyu
		end
	elseif id==10 then
		if not IsBagOpen(id-1) and not IsBagOpen(id-2) and not IsBagOpen(id-3) and not IsBagOpen(id-4) and not IsBagOpen(id-5) then
			BKpaishuID,BKkongbuID=qishihang,qishikongyu
		end
	elseif id==11 then
		if not IsBagOpen(id-1) and not IsBagOpen(id-2) and not IsBagOpen(id-3) and not IsBagOpen(id-4) and not IsBagOpen(id-5) and not IsBagOpen(id-6) then
			BKpaishuID,BKkongbuID=qishihang,qishikongyu
		end
	end
	local Fid=IsBagOpen(id)
	local NEWsize=size-BKkongbuID
	local hangShu=math.ceil(NEWsize/BKmeihang)
	local kongyu=hangShu*BKmeihang-NEWsize--空余
	local NEWhangShu=hangShu+BKpaishuID
	for slot=1,size do
		_G["ContainerFrame"..Fid.."Item"..slot]:ClearAllPoints();
		if slot==1 then
			_G["ContainerFrame"..Fid.."Item"..slot]:SetPoint("TOPRIGHT", BankSlotsFrame, "TOPRIGHT", -kongyu*BKdangeW-14, -NEWhangShu*BKdangeW-16);
		else
			local yushu=math.fmod((slot+kongyu-1),BKmeihang)
			if yushu==0 then
				_G["ContainerFrame"..Fid.."Item"..slot]:SetPoint("BOTTOMLEFT", _G["ContainerFrame"..Fid.."Item"..(slot-1)], "TOPLEFT", (BKmeihang-1)*BKdangeW, 4);
			else
				_G["ContainerFrame"..Fid.."Item"..slot]:SetPoint("RIGHT", _G["ContainerFrame"..Fid.."Item"..(slot-1)], "LEFT", -5, 0);
			end
		end
	end
	BKpaishuID,BKkongbuID=NEWhangShu,kongyu
	local name = frame:GetName();
	_G[name.."MoneyFrame"]:Hide()
	_G[name.."BackgroundTop"]:Hide();
	_G[name.."BackgroundMiddle1"]:Hide();
	_G[name.."BackgroundMiddle2"]:Hide();
	_G[name.."BackgroundBottom"]:Hide();
	_G[name.."Background1Slot"]:Hide();
	_G[name.."Name"]:Hide();
	_G[name.."PortraitButton"]:Hide();
	_G[name.."Portrait"]:Hide();
	_G[name.."CloseButton"]:Hide();
	frame:SetHeight(0);
	frame:SetFrameStrata("HIGH")
	BankFrameP_UI:SetHeight(BKpaishuID*BKdangeW+84);
end
-------------------
local function zhegnheBANK()
	for i=1,280 do
		local framx=_G["BankFrameP_wupin_item_"..i]
		framx:Hide();
		framx:SetNormalTexture("")
		framx.shuliang:SetText()
		if PIG['zhegnheBAG']["wupinLV"] then
			framx.LV:SetText()
		end
	end
	SetPortraitTexture(BankFrameP_UI.Portrait_TEX, "target")
	BankFrameP_UI.biaoti_t:SetText("银行");
	local BKregions = {BankFrame:GetRegions()}
	for i=1,#BKregions do
		BKregions[i]:Hide()
	end
	local BKregions0 = {BankSlotsFrame:GetRegions()}
	for i=1,#BKregions0 do
		BKregions0[i]:SetAlpha(0.1)
	end
	local BKregions1 = {BankFramePurchaseInfo:GetRegions()}
	for i=1,#BKregions1 do
		BKregions1[i]:Hide()
	end
	BankFrame:SetFrameStrata("HIGH")
	BankFrame:SetHeight(140);
	BankFrame:SetWidth(BKdangeW*BKmeihang+30)
	BankFrameMoneyFrame:SetPoint("BOTTOMRIGHT", BankFrameP_UI, "BOTTOMRIGHT", 0, 10);
	BankCloseButton:ClearAllPoints();
	BankCloseButton:SetPoint("TOPRIGHT", BankFrame, "TOPRIGHT", 1, 3.8);
	for i=1,yinhangmorengezishu[2] do
		BankSlotsFrame["Bag"..i]:SetScale(0.76);
		BankSlotsFrame["Bag"..i]:ClearAllPoints();
		if i==1 then
			BankSlotsFrame["Bag"..i]:SetPoint("TOPLEFT", BankFrameItem1, "BOTTOMLEFT", 70, 94);
		else
			BankSlotsFrame["Bag"..i]:SetPoint("LEFT", BankSlotsFrame["Bag"..(i-1)], "RIGHT", 0, 0);
		end
	end
	BankFramePurchaseButton:SetWidth(90)
	BankFramePurchaseButton:ClearAllPoints();
	BankFramePurchaseButton:SetPoint("LEFT", BankSlotsFrame.Bag7, "RIGHT", 6, 0);
	BankFramePurchaseButtonText:SetPoint("RIGHT", BankFramePurchaseButton, "RIGHT", -8, 0);
	BankFrameDetailMoneyFrame:ClearAllPoints();
	BankFrameDetailMoneyFrame:SetPoint("RIGHT", BankFramePurchaseButtonText, "LEFT", 6, 0);
	for i = 1, yinhangmorengezishu[1] do
		_G["BankFrameItem"..i]:ClearAllPoints();
		if i==1 then
			_G["BankFrameItem"..i]:SetPoint("TOPLEFT", BankSlotsFrame, "TOPLEFT", 22, -60);
		else
			local yushu=math.fmod(i-1,BKmeihang)
			if yushu==0 then
				_G["BankFrameItem"..i]:SetPoint("TOPLEFT", _G["BankFrameItem"..(i-BKmeihang)], "BOTTOMLEFT", 0, -4);
			else
				_G["BankFrameItem"..i]:SetPoint("LEFT", _G["BankFrameItem"..(i-1)], "RIGHT", 5, 0);
			end
		end
	end
end
---------
local function SAVE_C()
	local wupinshujuinfo = {}
	for inv = 1, 19 do
		local wupinxinxi={nil,nil,nil,0,0,1,0}--1物品ID/2图标/3物品品质/4物品等级/5堆叠数/6数量/7itemLink
		local itemID=GetInventoryItemID("player", inv)
		if itemID then
			wupinxinxi[1]=itemID
			wupinxinxi[2] = GetInventoryItemTexture("player", inv)
			wupinxinxi[7] = GetInventoryItemLink("player", inv)
			wupinxinxi[3] = GetInventoryItemQuality("player", inv)
			local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount = GetItemInfo(itemID);
			wupinxinxi[4]=itemLevel
			wupinxinxi[5]=itemStackCount
		end	
		table.insert(wupinshujuinfo, wupinxinxi);
	end
	PIG['zhegnheBAG']["lixian"][PIG_renwuming]["C"] = wupinshujuinfo
end
local function SAVE_BAG()
	local wupinshujuinfo = {}
	for f=1,#bagID do
		for ff=1,GetContainerNumSlots(bagID[f]) do
			local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(bagID[f], ff)
			if itemID then
				local wupinxinxi={itemID,icon,quality,0,0,itemCount,itemLink}
				-- local item = Item:CreateFromItemID(itemID)
				-- item:ContinueOnItemLoad(function()
					local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount,itemEquipLoc,itemTexture,sellPrice,classID = GetItemInfo(itemID);
					wupinxinxi[5]=itemStackCount
					if classID==2 or classID==4 then
						wupinxinxi[4]=itemLevel
					end
					table.insert(wupinshujuinfo, wupinxinxi);
				--end)
			end
		end
	end
	PIG['zhegnheBAG']["lixian"][PIG_renwuming]["BAG"] = wupinshujuinfo
end
local function SAVE_bank()
	local wupinshujuinfo = {}
	for f=1,#bankID do
		if f==1 then
			for ff=1,yinhangmorengezishu[1] do
				local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(bankID[f], ff)
				if icon then
					local wupinxinxi={itemID,icon,quality,0,0,itemCount,itemLink}
					--
					-- local item = Item:CreateFromItemID(itemID)
					-- item:ContinueOnItemLoad(function()
						local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount,itemEquipLoc,itemTexture,sellPrice,classID = GetItemInfo(itemID);
						wupinxinxi[5]=itemStackCount
						if classID==2 or classID==4 then
							if itemLevel then
								wupinxinxi[4]=itemLevel		
							end
						end
						table.insert(wupinshujuinfo, wupinxinxi);
					--end)

				end
			end
		else
			for xx=1,GetContainerNumSlots(bankID[f]) do
				local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(bankID[f], xx)
				if icon then
					local wupinxinxi={itemID,icon,quality,0,0,itemCount,itemLink}
					--local item = Item:CreateFromItemID(itemID)
					--item:ContinueOnItemLoad(function()
						local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount,itemEquipLoc,itemTexture,sellPrice,classID = GetItemInfo(itemID);
						wupinxinxi[5]=itemStackCount
						if classID==2 or classID==4 then
							if itemLevel then
								wupinxinxi[4]=itemLevel		
							end
						end
						table.insert(wupinshujuinfo, wupinxinxi);
					--end)
				end
			end
		end
	end
	PIG['zhegnheBAG']["lixian"][PIG_renwuming]["BANK"] = wupinshujuinfo
end
------离线显示
local function lixian_zhuangbei(renwu)
	juesezhuangbei_UI.biaoti.t:SetText(renwu);
	juesezhuangbei_UI:Show();
	for i=1,19 do
		if PIG['zhegnheBAG']["lixian"][renwu]["C"][i][1] then
			local frameX=_G["juesezhuangbei_item_"..i]
			frameX:SetNormalTexture(PIG['zhegnheBAG']["lixian"][renwu]["C"][i][2])
			if PIG['ShowPlus']['zhuangbeiLV']=="ON" then
				local itemLevel=PIG['zhegnheBAG']["lixian"][renwu]["C"][i][4]
				local itemQuality=PIG['zhegnheBAG']["lixian"][renwu]["C"][i][3]
				if i~=4 and i~=19 then	
					if itemLevel and itemLevel>0 then
						frameX.LV:SetText(itemLevel)
						if itemQuality==0 then
							frameX.LV:SetTextColor(157/255,157/255,157/255, 1);
						elseif itemQuality==1 then
							frameX.LV:SetTextColor(1, 1, 1, 1);
						elseif itemQuality==2 then
							frameX.LV:SetTextColor(30/255, 1, 0, 1);
						elseif itemQuality==3 then
							frameX.LV:SetTextColor(0,112/255,221/255, 1);
						elseif itemQuality==4 then
							frameX.LV:SetTextColor(163/255,53/255,238/255, 1);
						elseif itemQuality==5 then
							frameX.LV:SetTextColor(1,128/255,0, 1);
						elseif itemQuality==6 then
							frameX.LV:SetTextColor(230/255,204/255,128/255, 1);
						elseif itemQuality==7 then
							frameX.LV:SetTextColor(0,204/255,1, 1);
						end
					end
				end
			end
			frameX:SetScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				GameTooltip:SetHyperlink(PIG['zhegnheBAG']["lixian"][renwu]["C"][i][7])
				GameTooltip:Show();
			end);
			frameX:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			frameX:SetScript("OnMouseUp", function ()
				if IsShiftKeyDown() then
					local editBox = ChatEdit_ChooseBoxForSend();
					local hasText = editBox:GetText()..PIG['zhegnheBAG']["lixian"][renwu]["C"][i][7]
					if editBox:HasFocus() then
						editBox:SetText(hasText);
					else
						ChatEdit_ActivateChat(editBox)
						editBox:SetText(hasText);
					end
				end
			end);
		end
	end
end
---
local function lixian_bag(renwu)
	lixianBAG_UI.biaoti.t:SetText(renwu.." 的背包");
	lixianBAG_UI:Show();
	for i=1,164 do
		local frameX=_G["lixianBAG_wupin_item_"..i]
		frameX:Hide();
		frameX:SetNormalTexture("")
		frameX.shuliang:SetText()
		if PIG['zhegnheBAG']["wupinLV"] then
			frameX.LV:SetText()
		end
	end

	local zongshu=#PIG['zhegnheBAG']["lixian"][renwu]["BAG"]
	for i=1,zongshu do
		local frameX=_G["lixianBAG_wupin_item_"..i]
		frameX:Show();
		frameX:SetNormalTexture(PIG['zhegnheBAG']["lixian"][renwu]["BAG"][i][2])
		if PIG['zhegnheBAG']["lixian"][renwu]["BAG"][i][5]>1 then
			frameX.shuliang:SetText(PIG['zhegnheBAG']["lixian"][renwu]["BAG"][i][6])
		end
		if PIG['zhegnheBAG']["wupinLV"] then
			local itemQuality=PIG['zhegnheBAG']["lixian"][renwu]["BAG"][i][3]
			local itemLevel=PIG['zhegnheBAG']["lixian"][renwu]["BAG"][i][4]
			if itemLevel and itemLevel>0 then
				frameX.LV:SetText(itemLevel)
				if itemQuality==0 then
					frameX.LV:SetTextColor(157/255,157/255,157/255, 1);
				elseif itemQuality==1 then
					frameX.LV:SetTextColor(1, 1, 1, 1);
				elseif itemQuality==2 then
					frameX.LV:SetTextColor(30/255, 1, 0, 1);
				elseif itemQuality==3 then
					frameX.LV:SetTextColor(0,112/255,221/255, 1);
				elseif itemQuality==4 then
					frameX.LV:SetTextColor(163/255,53/255,238/255, 1);
				elseif itemQuality==5 then
					frameX.LV:SetTextColor(1,128/255,0, 1);
				elseif itemQuality==6 then
					frameX.LV:SetTextColor(230/255,204/255,128/255, 1);
				elseif itemQuality==7 then
					frameX.LV:SetTextColor(0,204/255,1, 1);
				end
			end
		end
		frameX:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
			GameTooltip:SetHyperlink(PIG['zhegnheBAG']["lixian"][renwu]["BAG"][i][7])
			GameTooltip:Show();
		end);
		frameX:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		frameX:SetScript("OnMouseUp", function ()
			if IsShiftKeyDown() then
				local editBox = ChatEdit_ChooseBoxForSend();
				local hasText = editBox:GetText()..PIG['zhegnheBAG']["lixian"][renwu]["BAG"][i][7]
				if editBox:HasFocus() then
					editBox:SetText(hasText);
				else
					ChatEdit_ActivateChat(editBox)
					editBox:SetText(hasText);
				end
			end
		end);
	end

	local zongkuandu=meihang*(BAOGUOdangeW-4+2)+26
	local zonggaodu=math.ceil(zongshu/meihang)*(BAOGUOdangeW-4+2)+88
	lixianBAG_UI:SetSize(zongkuandu,zonggaodu)
end
---
local function lixian_bank(renwu)
	BankFrameP_UI.Portrait_TEX:SetTexture(130899)
	BankFrameP_UI.biaoti_t:SetText(renwu..' 的银行');
	for i=1,280 do
		local frameX=_G["BankFrameP_wupin_item_"..i]
		frameX:Hide();
		frameX:SetNormalTexture("")
		frameX.shuliang:SetText()
		if PIG['zhegnheBAG']["wupinLV"] then
			frameX.LV:SetText()
		end
	end
	local zongshu=#PIG['zhegnheBAG']["lixian"][renwu]["BANK"]
	for i=1,zongshu do
		local frameX=_G["BankFrameP_wupin_item_"..i]
		frameX:Show();
		frameX:SetNormalTexture(PIG['zhegnheBAG']["lixian"][renwu]["BANK"][i][2])
		if PIG['zhegnheBAG']["lixian"][renwu]["BANK"][i][5]>1 then
			frameX.shuliang:SetText(PIG['zhegnheBAG']["lixian"][renwu]["BANK"][i][6])
		end
		if PIG['zhegnheBAG']["wupinLV"] then
			local itemLevel=PIG['zhegnheBAG']["lixian"][renwu]["BANK"][i][4]
			local itemQuality=PIG['zhegnheBAG']["lixian"][renwu]["BANK"][i][3]
			if itemLevel and itemLevel>0 then
				frameX.LV:SetText(itemLevel)
				if itemQuality==0 then
					frameX.LV:SetTextColor(157/255,157/255,157/255, 1);
				elseif itemQuality==1 then
					frameX.LV:SetTextColor(1, 1, 1, 1);
				elseif itemQuality==2 then
					frameX.LV:SetTextColor(30/255, 1, 0, 1);
				elseif itemQuality==3 then
					frameX.LV:SetTextColor(0,112/255,221/255, 1);
				elseif itemQuality==4 then
					frameX.LV:SetTextColor(163/255,53/255,238/255, 1);
				elseif itemQuality==5 then
					frameX.LV:SetTextColor(1,128/255,0, 1);
				elseif itemQuality==6 then
					frameX.LV:SetTextColor(230/255,204/255,128/255, 1);
				elseif itemQuality==7 then
					frameX.LV:SetTextColor(0,204/255,1, 1);
				end
			end
		end
		frameX:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
			GameTooltip:SetHyperlink(PIG['zhegnheBAG']["lixian"][renwu]["BANK"][i][7])
			GameTooltip:Show();
		end);
		frameX:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		frameX:SetScript("OnMouseUp", function ()
			if IsShiftKeyDown() then
				local editBox = ChatEdit_ChooseBoxForSend();
				local hasText = editBox:GetText()..PIG['zhegnheBAG']["lixian"][renwu]["BANK"][i][7]
				if editBox:HasFocus() then
					editBox:SetText(hasText);
				else
					ChatEdit_ActivateChat(editBox)
					editBox:SetText(hasText);
				end
			end
		end);
	end

	local zongkuandu=BKmeihang*BKdangeW+16
	local zonggaodu=math.ceil(zongshu/BKmeihang)*(BKdangeW+2)+84
	BankFrameP_UI:SetSize(zongkuandu,zonggaodu)
	BankFrameP_UI:Show()
	BankFrameP_UI.Close:Show()
end

---刷新背包银行LV
local function Bag_Item_lv(frame, size, id)
	if id==-2 then return end
	if frame and size then
		local fujiFF=frame:GetName()
		for slot =1, size do
			local itemID = GetContainerItemID(id, slot)
			local framef = _G[fujiFF.."Item"..size+1-slot]
			framef.ZLV:SetText();
			if itemID then
				local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount,itemEquipLoc,itemTexture,sellPrice,classID = GetItemInfo(itemID);
				if itemQuality then
						if classID==2 or classID==4 then
							if itemLevel then
								framef.ZLV:SetText(itemLevel);
								if itemQuality==0 then
									framef.ZLV:SetTextColor(157/255,157/255,157/255, 1);
								elseif itemQuality==1 then
									framef.ZLV:SetTextColor(1, 1, 1, 1);
								elseif itemQuality==2 then
									framef.ZLV:SetTextColor(30/255, 1, 0, 1);
								elseif itemQuality==3 then
									framef.ZLV:SetTextColor(0,112/255,221/255, 1);
								elseif itemQuality==4 then
									framef.ZLV:SetTextColor(163/255,53/255,238/255, 1);
								elseif itemQuality==5 then
									framef.ZLV:SetTextColor(1,128/255,0, 1);
								elseif itemQuality==6 then
									framef.ZLV:SetTextColor(230/255,204/255,128/255, 1);
								elseif itemQuality==7 then
									framef.ZLV:SetTextColor(0,204/255,1, 1);
								end
							end
						end
				end
			end
		end
	else
		local Fid=IsBagOpen(id)
		if Fid then
			local baogeshu=GetContainerNumSlots(id)
			for slot =1, baogeshu do
				local itemID = GetContainerItemID(id, slot)
				local framef = _G["ContainerFrame"..Fid.."Item"..baogeshu+1-slot]
				framef.ZLV:SetText();
				if itemID then
					local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount,itemEquipLoc,itemTexture,sellPrice,classID = GetItemInfo(itemID);
					if itemQuality then
							if classID==2 or classID==4 then
								if itemLevel then
									framef.ZLV:SetText(itemLevel);
									if itemQuality==0 then
										framef.ZLV:SetTextColor(157/255,157/255,157/255, 1);
									elseif itemQuality==1 then
										framef.ZLV:SetTextColor(1, 1, 1, 1);
									elseif itemQuality==2 then
										framef.ZLV:SetTextColor(30/255, 1, 0, 1);
									elseif itemQuality==3 then
										framef.ZLV:SetTextColor(0,112/255,221/255, 1);
									elseif itemQuality==4 then
										framef.ZLV:SetTextColor(163/255,53/255,238/255, 1);
									elseif itemQuality==5 then
										framef.ZLV:SetTextColor(1,128/255,0, 1);
									elseif itemQuality==6 then
										framef.ZLV:SetTextColor(230/255,204/255,128/255, 1);
									elseif itemQuality==7 then
										framef.ZLV:SetTextColor(0,204/255,1, 1);
									end
								end
							end
					end
				end
			end
		end
	end
end
--银行默认格子LV
local function shuaxinyinhangMOREN(arg1)
	if arg1>yinhangmorengezishu[1] then return end
	local fujiFFX=_G["BankFrameItem"..arg1];
	fujiFFX.ZLV:SetText();
	local itemID = GetContainerItemID(-1, arg1)
	if itemID then
		local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount,itemEquipLoc,itemTexture,sellPrice,classID = GetItemInfo(itemID);
		if itemQuality then
				if classID==2 or classID==4 then
					if itemLevel then
						fujiFFX.ZLV:SetText(itemLevel);
						if itemQuality==0 then
							fujiFFX.ZLV:SetTextColor(157/255,157/255,157/255, 1);
						elseif itemQuality==1 then
							fujiFFX.ZLV:SetTextColor(1, 1, 1, 1);
						elseif itemQuality==2 then
							fujiFFX.ZLV:SetTextColor(30/255, 1, 0, 1);
						elseif itemQuality==3 then
							fujiFFX.ZLV:SetTextColor(0,112/255,221/255, 1);
						elseif itemQuality==4 then
							fujiFFX.ZLV:SetTextColor(163/255,53/255,238/255, 1);
						elseif itemQuality==5 then
							fujiFFX.ZLV:SetTextColor(1,128/255,0, 1);
						elseif itemQuality==6 then
							fujiFFX.ZLV:SetTextColor(230/255,204/255,128/255, 1);
						elseif itemQuality==7 then
							fujiFFX.ZLV:SetTextColor(0,204/255,1, 1);
						end
					end
				end
		end
	end
end
---刷新背包银行染色
local function Bag_Item_Ranse(frame, size, id)
	if id==-2 then return end
	if frame and size then
		local fujiFF=frame:GetName()
		for slot =1, size do
			local fujiFFX=_G[fujiFF.."Item"..size+1-slot]
			fujiFFX.ranse:Hide()
			local itemID = GetContainerItemID(id, slot)
			if itemID then
				local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount,itemEquipLoc,itemTexture,sellPrice,classID = GetItemInfo(itemID);
				if itemQuality and itemQuality>1 then
					if classID==2 or classID==4 then
		           		local r, g, b = GetItemQualityColor(itemQuality);
			            fujiFFX.ranse:SetVertexColor(r, g, b);
						fujiFFX.ranse:Show()
					end
				end
			end
		end
	else
		local Fid=IsBagOpen(id)
		if Fid then
			local baogeshu=GetContainerNumSlots(id)
			for slot =1, baogeshu do
				local fujiFFX=_G["ContainerFrame"..Fid.."Item"..baogeshu+1-slot];
				fujiFFX.ranse:Hide()
				local itemID = GetContainerItemID(id, slot)
				if itemID then
					local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount,itemEquipLoc,itemTexture,sellPrice,classID = GetItemInfo(itemID);
					if itemQuality and itemQuality>1 then
						if classID==2 or classID==4 then
			           		local r, g, b = GetItemQualityColor(itemQuality);
				            fujiFFX.ranse:SetVertexColor(r, g, b);
							fujiFFX.ranse:Show()
						end
					end			
				end
			end
		end
	end
end
--银行默认格子染色
local function shuaxinyinhangMOREN_ranse(arg1)
	if arg1>yinhangmorengezishu[1] then return end
	local fujiFFX=_G["BankFrameItem"..arg1];
	fujiFFX.ranse:Hide()
	local itemID = GetContainerItemID(-1, arg1)
	if itemID then
		local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount,itemEquipLoc,itemTexture,sellPrice,classID = GetItemInfo(itemID);
		if itemQuality and itemQuality>1 then
			if classID==2 or classID==4 then
           		local r, g, b = GetItemQualityColor(itemQuality);
	            fujiFFX.ranse:SetVertexColor(r, g, b);
				fujiFFX.ranse:Show()
			end
		end
	end
end
----------------------
----其他角色数量
GameTooltip:HookScript("OnTooltipSetItem", function(self)
	if not yinhangmorengezishu.qitashuliang then return end
	local _, link = self:GetItem()
	if link then
		local itemID = GetItemInfoInstant(link)
		local renwuWupinshu={}
		local renwuWupinINFO=PIG['zhegnheBAG']["lixian"]
		for k,v in pairs(renwuWupinINFO) do
			local Czongshu=#renwuWupinINFO[k]["C"]
			renwuWupinshu.Cshuliang=0
			for x=1,Czongshu do
				if itemID==renwuWupinINFO[k]["C"][x][1] then
					renwuWupinshu.Cshuliang=renwuWupinshu.Cshuliang+renwuWupinINFO[k]["C"][x][6]
				end
			end
			---
			local BAGzongshu=#renwuWupinINFO[k]["BAG"]
			renwuWupinshu.BAGshuliang=0
			for x=1,BAGzongshu do
				if itemID==renwuWupinINFO[k]["BAG"][x][1] then
					renwuWupinshu.BAGshuliang=renwuWupinshu.BAGshuliang+renwuWupinINFO[k]["BAG"][x][6]
				end
			end
			---
			local BANKzongshu=#renwuWupinINFO[k]["BANK"]
			renwuWupinshu.BANKshuliang=0
			for x=1,BANKzongshu do
				if itemID==renwuWupinINFO[k]["BANK"][x][1] then
					renwuWupinshu.BANKshuliang=renwuWupinshu.BANKshuliang+renwuWupinINFO[k]["BANK"][x][6]
				end
			end

			if renwuWupinshu.Cshuliang>0 or renwuWupinshu.BAGshuliang>0 or renwuWupinshu.BANKshuliang>0 then
				local tooltipxianshineirong={"","",0}
				local _, _, _, argbHex = GetClassColor(renwuWupinINFO[k]["Class"]);	
				if k==PIG_renwuming then 
					tooltipxianshineirong[1]="|c"..argbHex.."当前角色|r"
				else
					tooltipxianshineirong[1]="|c"..argbHex..k.."|r"
				end
				if renwuWupinshu.Cshuliang>0 then
					tooltipxianshineirong[2]="|c"..argbHex.."装备:|r|cffFFFFFF"..renwuWupinshu.Cshuliang.."|r"
				end
				if renwuWupinshu.BAGshuliang>0 then
					if renwuWupinshu.Cshuliang>0 then
						tooltipxianshineirong[2]="|c"..argbHex.."总|r|cffFFFFFF"..renwuWupinshu.Cshuliang+renwuWupinshu.BAGshuliang.."|r(|c"..argbHex.."装备:|r|cffFFFFFF"..renwuWupinshu.Cshuliang.."|r|c"..argbHex.." 背包:|r|cffFFFFFF"..renwuWupinshu.BAGshuliang.."|r)"
					else
						tooltipxianshineirong[2]="|c"..argbHex.."背包:|r|cffFFFFFF"..renwuWupinshu.BAGshuliang.."|r"
					end
				end
				if renwuWupinshu.BANKshuliang>0 then
					if renwuWupinshu.Cshuliang>0 and renwuWupinshu.BAGshuliang>0 then
						tooltipxianshineirong[2]="|c"..argbHex.."总|r|cffFFFFFF"..renwuWupinshu.Cshuliang+renwuWupinshu.BAGshuliang+renwuWupinshu.BANKshuliang.."|r(|c"..argbHex.."装备:|r|cffFFFFFF"..renwuWupinshu.Cshuliang.."|r|c"..argbHex.." 背包:|r|cffFFFFFF"..renwuWupinshu.BAGshuliang.."|r|c"..argbHex.." 银行:|r|cffFFFFFF"..renwuWupinshu.BANKshuliang.."|r)"
					elseif renwuWupinshu.Cshuliang>0 then
						tooltipxianshineirong[2]="|c"..argbHex.."总|r|cffFFFFFF"..renwuWupinshu.Cshuliang+renwuWupinshu.BANKshuliang.."|r(|c"..argbHex.."装备:|r|cffFFFFFF"..renwuWupinshu.Cshuliang.."|r|c"..argbHex.." 银行:|r|cffFFFFFF"..renwuWupinshu.BANKshuliang.."|r)"
					elseif renwuWupinshu.BAGshuliang>0 then
						tooltipxianshineirong[2]="|c"..argbHex.."总|r|cffFFFFFF"..renwuWupinshu.BAGshuliang+renwuWupinshu.BANKshuliang.."|r(|c"..argbHex.."背包:|r|cffFFFFFF"..renwuWupinshu.BAGshuliang.."|r|c"..argbHex.." 银行:|r|cffFFFFFF"..renwuWupinshu.BANKshuliang.."|r)"
					else
						tooltipxianshineirong[2]="|c"..argbHex.."银行:|r|cffFFFFFF"..renwuWupinshu.BANKshuliang.."|r"
					end
				end
				tooltipxianshineirong[3]=renwuWupinshu.Cshuliang+renwuWupinshu.BAGshuliang+renwuWupinshu.BANKshuliang
				if k==PIG_renwuming then 
					table.insert(renwuWupinshu,1,tooltipxianshineirong)
				else
					table.insert(renwuWupinshu,tooltipxianshineirong)
				end
			end
		end
		local yiyouwupinjuese=#renwuWupinshu
		if yiyouwupinjuese>0 then
			renwuWupinshu.hejishu=0
			for i=1,yiyouwupinjuese do
				self:AddDoubleLine(renwuWupinshu[i][1],renwuWupinshu[i][2])
				renwuWupinshu.hejishu=renwuWupinshu.hejishu+renwuWupinshu[i][3]
			end
			if yiyouwupinjuese>1 then
				self:AddDoubleLine("|cff00FF00所有角色|r","|cff00FF00合计:|r|cffFFFFFF"..renwuWupinshu.hejishu)
			end
			self:Show()
		end
	end
end)

--===========================================
local XWidth, XHeight =CharacterHeadSlot:GetWidth(),CharacterHeadSlot:GetHeight()
--------
local function zhegnhe_Open()
	if PIG['zhegnheBAG']["wupinLV"] then
		--背包
		for bagui = 1, 13 do
			for slot = 1, 36 do
				local famrr=_G["ContainerFrame"..bagui.."Item"..slot]
				if famrr.ZLV then return end
				famrr.ZLV = famrr:CreateFontString();
				famrr.ZLV:SetPoint("TOPRIGHT", famrr, "TOPRIGHT", 0, 0);
				famrr.ZLV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
			end
		end
		--银行默认格子
		for i = 1, yinhangmorengezishu[1] do
			local famrr=_G["BankFrameItem"..i]
			if famrr.ZLV then return end
			famrr.ZLV = famrr:CreateFontString();
			famrr.ZLV:SetPoint("TOPRIGHT", famrr, "TOPRIGHT", 0, 0);
			famrr.ZLV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		end
	end
	if PIG['zhegnheBAG']["wupinRanse"] then
		--背包
		for bagui = 1, 13 do
				for slot = 1, 36 do
					local famrr=_G["ContainerFrame"..bagui.."Item"..slot]
					if famrr.ranse then return end
				    famrr.ranse = famrr:CreateTexture(nil, 'OVERLAY');
				    famrr.ranse:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
				    famrr.ranse:SetBlendMode('ADD');
				    famrr.ranse:SetSize(XWidth*1.8, XHeight*1.8);
				    famrr.ranse:SetPoint('CENTER', famrr, 'CENTER', 0, 0);
				    famrr.ranse:Hide()
				end
		end
		--银行默认格子
		for i = 1, yinhangmorengezishu[1] do
			local famrr=_G["BankFrameItem"..i]
			if famrr.ranse then return end
		    famrr.ranse = famrr:CreateTexture(nil, 'OVERLAY');
		    famrr.ranse:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
		    famrr.ranse:SetBlendMode('ADD');
		    famrr.ranse:SetSize(XWidth*1.8, XHeight*1.8);
		    famrr.ranse:SetPoint('CENTER', famrr, 'CENTER', 0, 0);
		    famrr.ranse:Hide()
		end
	end
	------
	if BAGheji_UI then return end
	local BAGheji = CreateFrame("Frame", "BAGheji_UI", UIParent,"BackdropTemplate");
	BAGheji:SetSize(BAOGUOdangeW*meihang+28,200);
	BAGheji:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -170, 100)
	BAGheji:SetMovable(true)
	BAGheji:SetUserPlaced(false)
	BAGheji:SetClampedToScreen(true)
	BAGheji:Hide()
	tinsert(UISpecialFrames,"BAGheji_UI");
	--暴雪UI
	if PIG['zhegnheBAG']["JianjieMOD"] then
		BAGheji:SetBackdrop( {bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 10 ,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }});
		BAGheji:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
		BAGheji.Portrait_TEX = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.Portrait_TEX:SetSize(30,30);
		BAGheji.Portrait_TEX:SetPoint("TOPLEFT",BAGheji,"TOPLEFT",14,-13);
	else
		BAGheji.Bg = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.Bg:SetTexture("interface/framegeneral/ui-background-rock.blp");
		BAGheji.Bg:SetPoint("TOPLEFT", BAGheji, "TOPLEFT",2, -2);
		BAGheji.Bg:SetPoint("BOTTOMRIGHT", BAGheji, "BOTTOMRIGHT", -2, 2);
		BAGheji.Bg:SetDrawLayer("BORDER", 1)
		BAGheji.topbg = BAGheji:CreateTexture(nil, "BACKGROUND");
		BAGheji.topbg:SetTexture(374157);
		BAGheji.topbg:SetPoint("TOPLEFT", BAGheji, "TOPLEFT",58, -1);
		BAGheji.topbg:SetPoint("TOPRIGHT", BAGheji, "TOPRIGHT",-20, -1);
		BAGheji.topbg:SetTexCoord(0,0.2890625,0,0.421875,1.359809994697571,0.2890625,1.359809994697571,0.421875);
		BAGheji.topbg:SetHeight(20);
		BAGheji.topbg:SetDrawLayer("BORDER", 2)
		BAGheji.Portrait_TEX = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.Portrait_TEX:SetSize(55,55);
		BAGheji.Portrait_TEX:SetPoint("TOPLEFT",BAGheji,"TOPLEFT",1,4);
		BAGheji.Portrait_TEX:SetDrawLayer("BORDER", 2)

		BAGheji.TOPLEFT = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.TOPLEFT:SetTexture("interface/framegeneral/ui-frame.blp");
		BAGheji.TOPLEFT:SetPoint("TOPLEFT", BAGheji, "TOPLEFT",-10, 10);
		BAGheji.TOPLEFT:SetTexCoord(0.0078125,0.0078125,0.0078125,0.6171875,0.6171875,0.0078125,0.6171875,0.6171875);
		BAGheji.TOPLEFT:SetSize(78,78);
		BAGheji.TOPLEFT:SetDrawLayer("BORDER", 3)
		BAGheji.TOPRIGHT = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.TOPRIGHT:SetTexture(374156);
		BAGheji.TOPRIGHT:SetPoint("TOPRIGHT", BAGheji, "TOPRIGHT",0, 0);
		BAGheji.TOPRIGHT:SetTexCoord(0.6328125,0.0078125,0.6328125,0.265625,0.890625,0.0078125,0.890625,0.265625);
		BAGheji.TOPRIGHT:SetSize(33,33);
		BAGheji.TOPRIGHT:SetDrawLayer("BORDER", 3)
		BAGheji.TOP = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.TOP:SetTexture(374157);
		BAGheji.TOP:SetPoint("TOPLEFT", BAGheji.TOPLEFT, "TOPRIGHT",0, -10);
		BAGheji.TOP:SetPoint("BOTTOMRIGHT", BAGheji.TOPRIGHT, "BOTTOMLEFT", 0, 5);
		BAGheji.TOP:SetTexCoord(0,0.4375,0,0.65625,1.08637285232544,0.4375,1.08637285232544,0.65625);
		BAGheji.TOP:SetDrawLayer("BORDER", 3)

		BAGheji.BOTTOMLEFT = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.BOTTOMLEFT:SetTexture(374156);
		BAGheji.BOTTOMLEFT:SetPoint("BOTTOMLEFT", BAGheji, "BOTTOMLEFT",-2, 0);
		BAGheji.BOTTOMLEFT:SetTexCoord(0.0078125,0.6328125,0.0078125,0.7421875,0.1171875,0.6328125,0.1171875,0.7421875);
		BAGheji.BOTTOMLEFT:SetSize(14,14);
		BAGheji.BOTTOMLEFT:SetDrawLayer("BORDER", 3)

		BAGheji.BOTTOMRIGHT = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.BOTTOMRIGHT:SetTexture(374156);
		BAGheji.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", BAGheji, "BOTTOMRIGHT",0, 0);
		BAGheji.BOTTOMRIGHT:SetTexCoord(0.1328125,0.8984375,0.1328125,0.984375,0.21875,0.8984375,0.21875,0.984375);
		BAGheji.BOTTOMRIGHT:SetSize(11,11);
		BAGheji.BOTTOMRIGHT:SetDrawLayer("BORDER", 3)

		BAGheji.LEFT = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.LEFT:SetTexture(374153);
		BAGheji.LEFT:SetTexCoord(0.359375,0,0.359375,1.42187488079071,0.609375,0,0.609375,1.42187488079071);
		BAGheji.LEFT:SetPoint("TOPLEFT", BAGheji.TOPLEFT, "BOTTOMLEFT",8.04, 0);
		BAGheji.LEFT:SetPoint("BOTTOMLEFT", BAGheji.BOTTOMLEFT, "TOPLEFT", 0, 0);
		BAGheji.LEFT:SetWidth(16);
		BAGheji.LEFT:SetDrawLayer("BORDER", 3)

		BAGheji.RIGHT = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.RIGHT:SetTexture(374153);
		BAGheji.RIGHT:SetTexCoord(0.171875,0,0.171875,1.5703125,0.328125,0,0.328125,1.5703125);
		BAGheji.RIGHT:SetPoint("TOPRIGHT", BAGheji.TOPRIGHT, "BOTTOMRIGHT",0.8, 0);
		BAGheji.RIGHT:SetPoint("BOTTOMRIGHT", BAGheji.BOTTOMRIGHT, "TOPRIGHT", 0, 0);
		BAGheji.RIGHT:SetWidth(10);
		BAGheji.RIGHT:SetDrawLayer("BORDER", 3)

		BAGheji.BOTTOM = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.BOTTOM:SetTexture(374157);
		BAGheji.BOTTOM:SetTexCoord(0,0.203125,0,0.2734375,1.425781607627869,0.203125,1.425781607627869,0.2734375);
		BAGheji.BOTTOM:SetPoint("BOTTOMLEFT", BAGheji.BOTTOMLEFT, "BOTTOMRIGHT",0, -0);
		BAGheji.BOTTOM:SetPoint("BOTTOMRIGHT", BAGheji.BOTTOMRIGHT, "BOTTOMLEFT", 0, 0);
		BAGheji.BOTTOM:SetHeight(9);
		BAGheji.BOTTOM:SetDrawLayer("BORDER", 3)
	end
	SetPortraitTexture(BAGheji.Portrait_TEX, "player")
	--------------------------
	BAGheji.biaoti = CreateFrame("Frame", nil, BAGheji)
	BAGheji.biaoti:SetPoint("TOPLEFT", BAGheji, "TOPLEFT",58, -1);
	BAGheji.biaoti:SetPoint("TOPRIGHT", BAGheji, "TOPRIGHT",-26, -1);
	BAGheji.biaoti:SetHeight(20);
	BAGheji.biaoti:EnableMouse(true)
	BAGheji.biaoti:RegisterForDrag("LeftButton")
	BAGheji.biaoti:SetScript("OnDragStart",function()
	    BAGheji:StartMoving();
	    BAGheji:SetUserPlaced(false)
	end)
	BAGheji.biaoti:SetScript("OnDragStop",function()
	    BAGheji:StopMovingOrSizing()
	    BAGheji:SetUserPlaced(false)
	end)
	BAGheji.biaoti.t = BAGheji.biaoti:CreateFontString();
	BAGheji.biaoti.t:SetPoint("CENTER", BAGheji.biaoti, "CENTER", 4, -1);
	BAGheji.biaoti.t:SetFontObject(GameFontNormal);
	BAGheji.biaoti.t:SetText(PIG_renwuming);


	BAGheji.Close = CreateFrame("Button",nil,BAGheji, "UIPanelCloseButton");
	BAGheji.Close:SetSize(30,30);
	BAGheji.Close:SetPoint("TOPRIGHT",BAGheji,"TOPRIGHT",3,3);
	BAGheji.Close:SetScript("OnClick",  function (self)
		CloseAllBags()
	end);

	BAGheji.Portrait = CreateFrame("Button",nil,BAGheji, "TruncatedButtonTemplate");
	BAGheji.Portrait:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
	if PIG['zhegnheBAG']["JianjieMOD"] then
		BAGheji.Portrait:SetSize(41,41);
		BAGheji.Portrait:SetPoint("CENTER",BAGheji.Portrait_TEX,"CENTER",0,-2);
	else
		BAGheji.Portrait:SetSize(70,70);
		BAGheji.Portrait:SetPoint("CENTER",BAGheji.Portrait_TEX,"CENTER",0,-4);
	end
	BAGheji.Portrait:RegisterForClicks("LeftButtonUp","RightButtonUp")
	BAGheji.menuFrame = CreateFrame("Frame", nil, BAGheji.Portrait, "UIDropDownMenuTemplate")
	BAGheji.Portrait:SetScript("OnClick",  function (self,button)
		if BankFrame:IsShown() then return end
		if button=="LeftButton" then
			PlaySoundFile(567463, "Master")
			if BankFrameP_UI:IsShown() then
				BankFrameP_UI:Hide()
			else
				lixian_bank(PIG_renwuming)
			end
		else
			local menu = {}
			local KucunName={["C"]="已装备物品",["BAG"]="背包物品",["BANK"]="银行物品"}
			for k,v in pairs(PIG['zhegnheBAG']["lixian"]) do
				local xiajicaidan={}
				for kk,vv in pairs(v) do
					local xiajicaidanlinshi={ 
						text = KucunName[kk],arg1 = k,arg2 = kk,notCheckable = true;
						func = function(self,arg1,arg2)
							if arg2=="BANK" then
								lixian_bank(arg1)
							elseif arg2=="C" then
								lixian_zhuangbei(arg1)
							elseif arg2=="BAG" then
								lixian_bag(arg1)
							end
							DropDownList1:Hide()
						end 
					}
					table.insert(xiajicaidan,xiajicaidanlinshi)
	            end
				if k~=PIG_renwuming then
			    	table.insert(menu,{
						text = k,
						hasArrow = true,
						menuList = xiajicaidan,
						notCheckable = true,
						keepShownOnClick = false;
					})
				end
		    end
		    if #menu==0 then 			    	
		    	table.insert(menu,{
					text = "登录一次其他角色可离线查看",
					notCheckable = true,
				})
			end
			EasyMenu(menu, BAGheji.menuFrame, "cursor", 0 , 0, "MENU");
		end
	end);

	BAGheji.biaoti.shezhi = CreateFrame("Button",nil,BAGheji.biaoti);
	BAGheji.biaoti.shezhi:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	BAGheji.biaoti.shezhi:SetSize(17,17);
	BAGheji.biaoti.shezhi:SetPoint("TOPRIGHT",BAGheji.biaoti,"TOPRIGHT",-6,-3);
	BAGheji.biaoti.shezhi.Tex = BAGheji.biaoti.shezhi:CreateTexture(nil,"OVERLAY");
	BAGheji.biaoti.shezhi.Tex:SetTexture("interface/gossipframe/bindergossipicon.blp");
	BAGheji.biaoti.shezhi.Tex:SetPoint("CENTER", 0, 0);
	BAGheji.biaoti.shezhi.Tex:SetSize(17,17);

	BAGheji.biaoti.shezhi.F = CreateFrame("Frame", nil, BAGheji.biaoti.shezhi,"BackdropTemplate");
	BAGheji.biaoti.shezhi.F:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8,} );
	BAGheji.biaoti.shezhi.F:SetBackdropBorderColor(1, 1, 1, 0.6);
	BAGheji.biaoti.shezhi.F:SetSize(260,290);
	BAGheji.biaoti.shezhi.F:SetPoint("CENTER",UIParent,"CENTER",0,0);
	BAGheji.biaoti.shezhi.F:Hide()
	BAGheji.biaoti.shezhi.F.COS = CreateFrame("Button",nil,BAGheji.biaoti.shezhi.F,"UIPanelCloseButton");
	BAGheji.biaoti.shezhi.F.COS:SetSize(28,28);
	BAGheji.biaoti.shezhi.F.COS:SetPoint("TOPRIGHT",BAGheji.biaoti.shezhi.F,"TOPRIGHT",0,0);
	hooksecurefunc("TradeFrame_OnShow", function(self)
		if PIG['zhegnheBAG']["autoOpen"] then
			if(UnitExists("NPC"))then
				OpenAllBags()
			end
		end
	end);
	--local BAG_shezhi = {"反向整理","战利品放入左边包","简洁风格","不整理背包1","不整理背包2","不整理背包3","不整理背包4","不整理银行1","不整理银行2","不整理银行3","不整理银行4","不整理银行5","不整理银行6","不整理银行7"}
	local BAG_shezhi = {"反向整理","战利品放入左边包","简洁风格","提示其他角色数量","显示装备等级","根据品质染色装备","交易时自动打开背包"}
	for i=1,#BAG_shezhi do
		BAGheji.biaoti.shezhi.F.CKB = CreateFrame("CheckButton","BAG_shezhi_CKB_"..i, BAGheji.biaoti.shezhi.F, "ChatConfigCheckButtonTemplate");
		BAGheji.biaoti.shezhi.F.CKB:SetSize(28,28);
		BAGheji.biaoti.shezhi.F.CKB:SetHitRectInsets(0,-100,0,0);
		BAGheji.biaoti.shezhi.F.CKB.Text:SetText(BAG_shezhi[i]);
		BAGheji.biaoti.shezhi.F.CKB.tooltip = "勾选将开启"..BAG_shezhi[i];
		if i==3 or i==4 or i==5 or i==6 then
			BAGheji.biaoti.shezhi.F.CKB.CZUI = CreateFrame("Button",nil,BAGheji.biaoti.shezhi.F.CKB, "UIPanelButtonTemplate");
			BAGheji.biaoti.shezhi.F.CKB.CZUI:SetSize(70,22);
			BAGheji.biaoti.shezhi.F.CKB.CZUI:SetPoint("LEFT",BAGheji.biaoti.shezhi.F.CKB.Text,"RIGHT",4,0);
			BAGheji.biaoti.shezhi.F.CKB.CZUI:SetText("重载UI");
			BAGheji.biaoti.shezhi.F.CKB.CZUI:Hide();
			BAGheji.biaoti.shezhi.F.CKB.CZUI:SetScript("OnClick", function(self, button)
				ReloadUI()
			end)
		end
		if i==1 then
			BAGheji.biaoti.shezhi.F.CKB:SetPoint("TOPLEFT", BAGheji.biaoti.shezhi.F, "TOPLEFT", 10, -10);
		elseif i==8 then
			BAGheji.biaoti.shezhi.F.CKB:SetPoint("LEFT", BAG_shezhi_CKB_1, "RIGHT", 150, 0);
		else
			BAGheji.biaoti.shezhi.F.CKB:SetPoint("TOPLEFT", _G["BAG_shezhi_CKB_"..(i-1)], "BOTTOMLEFT", 0, -8);
		end

		BAGheji.biaoti.shezhi.F.CKB:SetScript("OnClick", function (self)
			if self:GetChecked() then
				if i==1 then
					if tocversion<30000 then
						PIG['zhegnheBAG']["SortBag_Config"]=false
						SetSortBagsRightToLeft(false)
					else
						SetSortBagsRightToLeft(true)
					end
				elseif i==2 then
					SetInsertItemsLeftToRight(true)
				elseif i==3 then
					PIG['zhegnheBAG']["JianjieMOD"]=true
					self.CZUI:Show();
				elseif i==4 then
					PIG['zhegnheBAG']["qitashulaing"]=true
					yinhangmorengezishu.qitashuliang=true
				elseif i==5 then
					PIG['zhegnheBAG']["wupinLV"]=true
					self.CZUI:Show();
				elseif i==6 then
					PIG['zhegnheBAG']["wupinRanse"]=true
					self.CZUI:Show();
				elseif i==7 then
					PIG['zhegnheBAG']["autoOpen"]=true
				end
			else
				if i==1 then
					if tocversion<30000 then
						PIG['zhegnheBAG']["SortBag_Config"]=true
						SetSortBagsRightToLeft(true)
					else
						SetSortBagsRightToLeft(false)
					end
				elseif i==2 then
					SetInsertItemsLeftToRight(false)
				elseif i==3 then
					PIG['zhegnheBAG']["JianjieMOD"]=false
					self.CZUI:Show();
				elseif i==4 then
					PIG['zhegnheBAG']["qitashulaing"]=false
					yinhangmorengezishu.qitashuliang=false
				elseif i==5 then
					PIG['zhegnheBAG']["wupinLV"]=false
					self.CZUI:Show();
				elseif i==6 then
					PIG['zhegnheBAG']["wupinRanse"]=false
					self.CZUI:Show();
				elseif i==7 then
					PIG['zhegnheBAG']["autoOpen"]=false
				end
			end
		end);
	end
	--------
	BAGheji.biaoti.shezhi:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1,-1);
	end);
	BAGheji.biaoti.shezhi:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	local function shuaxinxuanxiang()
		if tocversion<30000 then
			if PIG['zhegnheBAG']["SortBag_Config"] then
				BAG_shezhi_CKB_1:SetChecked(false)
			else
				BAG_shezhi_CKB_1:SetChecked(true)
			end
		else	
			if GetSortBagsRightToLeft() then
				BAG_shezhi_CKB_1:SetChecked(true)
			else
				BAG_shezhi_CKB_1:SetChecked(false)
			end
		end
		if GetInsertItemsLeftToRight() then
			BAG_shezhi_CKB_2:SetChecked(true)
		else
			BAG_shezhi_CKB_2:SetChecked(false)
		end
		if PIG['zhegnheBAG']["JianjieMOD"] then
			BAG_shezhi_CKB_3:SetChecked(true)
		else
			BAG_shezhi_CKB_3:SetChecked(false)
		end
		if PIG['zhegnheBAG']["qitashulaing"] then
			BAG_shezhi_CKB_4:SetChecked(true)
		else
			BAG_shezhi_CKB_4:SetChecked(false)
		end
		if PIG['zhegnheBAG']["wupinLV"] then
			BAG_shezhi_CKB_5:SetChecked(true)
		else
			BAG_shezhi_CKB_5:SetChecked(false)
		end
		if PIG['zhegnheBAG']["wupinRanse"] then
			BAG_shezhi_CKB_6:SetChecked(true)
		else
			BAG_shezhi_CKB_6:SetChecked(false)
		end
		if PIG['zhegnheBAG']["autoOpen"] then
			BAG_shezhi_CKB_7:SetChecked(true)
		else
			BAG_shezhi_CKB_7:SetChecked(false)
		end
	end
	BAGheji.biaoti.shezhi:SetScript("OnClick", function (self)
		if BAGheji.biaoti.shezhi.F:IsShown() then
			BAGheji.biaoti.shezhi.F:Hide()
		else
			BAGheji.biaoti.shezhi.F:Show()
			shuaxinxuanxiang()
		end
	end);

	BAGheji.biaoti.shezhi.F.CZpeizhi = CreateFrame("Button",nil,BAGheji.biaoti.shezhi.F, "UIPanelButtonTemplate");
	BAGheji.biaoti.shezhi.F.CZpeizhi:SetSize(80,22);
	BAGheji.biaoti.shezhi.F.CZpeizhi:SetPoint("BOTTOMRIGHT",BAGheji.biaoti.shezhi.F,"BOTTOMRIGHT",-4,4);
	BAGheji.biaoti.shezhi.F.CZpeizhi:SetText("恢复默认");
	BAGheji.biaoti.shezhi.F.CZpeizhi:SetScript("OnClick", function(self, button)
		StaticPopup_Show ("HUIFU_DEFAULT_BEIBAOZHENGHE");
	end)
	StaticPopupDialogs["HUIFU_DEFAULT_BEIBAOZHENGHE"] = {
		text = "此操作将\124cffff0000重置\124r背包整合所有配置，需重载界面。\n确定重置?",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG['zhegnheBAG']=addonTable.Default['zhegnheBAG']
			PIG['zhegnheBAG']["Open"]="ON"
			PIG['zhegnheBAG']["SortBag_Config"]=true
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}

	if tocversion<30000 then
		BAGheji.Search = CreateFrame('EditBox', nil, BAGheji, "BagSearchBoxTemplate");
		BAGheji.Search:SetSize(120,24);
		BAGheji.Search:SetPoint("TOPLEFT",BAGheji,"TOPLEFT",70,-28);

		BAGheji.AutoSort = CreateFrame("Button",nil,BAGheji, "TruncatedButtonTemplate");
		BAGheji.AutoSort:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
		BAGheji.AutoSort:SetSize(24,24);
		BAGheji.AutoSort:SetPoint("TOPLEFT",BAGheji,"TOPLEFT",290,-29);
		BAGheji.AutoSort.Tex = BAGheji.AutoSort:CreateTexture(nil, "BORDER");
		BAGheji.AutoSort.Tex:SetTexture(zhengliIcon);
		BAGheji.AutoSort.Tex:SetTexCoord(0.168,0.27,0.837,0.934);
		BAGheji.AutoSort.Tex:SetAllPoints(BAGheji.AutoSort)

		BAGheji.AutoSort.Tex1 = BAGheji.AutoSort:CreateTexture(nil, "BORDER");
		BAGheji.AutoSort.Tex1:SetTexture(zhengliIcon);
		BAGheji.AutoSort.Tex1:SetTexCoord(0.008,0.11,0.86,0.958);
		BAGheji.AutoSort.Tex1:SetAllPoints(BAGheji.AutoSort)
		BAGheji.AutoSort.Tex1:Hide();
		BAGheji.AutoSort:SetScript("OnMouseDown", function (self)
			self.Tex:Hide();
			self.Tex1:Show();
		end);
		BAGheji.AutoSort:SetScript("OnMouseUp", function (self)
			self.Tex:Show();
			self.Tex1:Hide();
		end);

		BAGheji.AutoSort:SetScript("OnClick",  function (self)
			PlaySoundFile(567463, "Master")
			SortBagsPIG()
		end);
	end

	BAGheji.wupin = CreateFrame("Frame", nil, BAGheji,"BackdropTemplate")
	BAGheji.wupin:SetPoint("TOPLEFT", BAGheji, "TOPLEFT",10, -56);
	BAGheji.wupin:SetPoint("BOTTOMRIGHT", BAGheji, "BOTTOMRIGHT", -10, 26);
	BAGheji.wupin:EnableMouse(true)

	local Mkuandu,Mgaodu = 8,22
	BAGheji.moneyframe = CreateFrame("Frame", nil, BAGheji);
	BAGheji.moneyframe:SetSize(160,Mgaodu);
	BAGheji.moneyframe:SetPoint("BOTTOMRIGHT", BAGheji, "BOTTOMRIGHT", -8, 5)
	if not PIG['zhegnheBAG']["JianjieMOD"] then
		BAGheji.wupin:SetBackdrop( { bgFile = "interface/framegeneral/ui-background-marble.blp" });
		BAGheji.moneyframe.l = BAGheji.moneyframe:CreateTexture(nil, "BORDER");
		BAGheji.moneyframe.l:SetTexture("interface/common/moneyframe.blp");
		BAGheji.moneyframe.l:SetTexCoord(0.95,1,0,0.31);
		BAGheji.moneyframe.l:SetSize(Mkuandu,Mgaodu);
		BAGheji.moneyframe.l:SetPoint("LEFT", BAGheji.moneyframe, "LEFT", 0, 0)
		BAGheji.moneyframe.R = BAGheji.moneyframe:CreateTexture(nil, "BORDER");
		BAGheji.moneyframe.R:SetTexture("interface/common/moneyframe.blp");
		BAGheji.moneyframe.R:SetTexCoord(0,0.05,0,0.31);
		BAGheji.moneyframe.R:SetSize(Mkuandu,Mgaodu);
		BAGheji.moneyframe.R:SetPoint("RIGHT", BAGheji.moneyframe, "RIGHT", 0, 0)
		BAGheji.moneyframeC = BAGheji.moneyframe:CreateTexture(nil, "BORDER");
		BAGheji.moneyframeC:SetTexture("interface/common/moneyframe.blp");
		BAGheji.moneyframeC:SetTexCoord(0.1,0.9,0.314,0.621);
		BAGheji.moneyframeC:SetPoint("TOPLEFT", BAGheji.moneyframe.l, "TOPRIGHT", 0, 0)
		BAGheji.moneyframeC:SetPoint("BOTTOMRIGHT", BAGheji.moneyframe.R, "BOTTOMLEFT", 0, 0)
	end

	--离线背包================================
	local lixianBAG = CreateFrame("Frame", "lixianBAG_UI", UIParent,"BackdropTemplate");
	lixianBAG:SetSize(400,200);
	lixianBAG:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
	lixianBAG:SetMovable(true)
	lixianBAG:SetUserPlaced(false)
	lixianBAG:SetClampedToScreen(true)
	lixianBAG:SetFrameLevel(110)
	lixianBAG:Hide()
	tinsert(UISpecialFrames,"lixianBAG_UI");
	lixianBAG.Bg = lixianBAG:CreateTexture(nil, "BACKGROUND");
	lixianBAG.Bg:SetTexture("interface/framegeneral/ui-background-rock.blp");
	lixianBAG.Bg:SetPoint("TOPLEFT", lixianBAG, "TOPLEFT",2, -2);
	lixianBAG.Bg:SetPoint("BOTTOMRIGHT", lixianBAG, "BOTTOMRIGHT", -2, 2);
	lixianBAG.topbg = lixianBAG:CreateTexture(nil, "BACKGROUND");
	lixianBAG.topbg:SetTexture(374157);
	lixianBAG.topbg:SetPoint("TOPLEFT", lixianBAG, "TOPLEFT",58, -1);
	lixianBAG.topbg:SetPoint("TOPRIGHT", lixianBAG, "TOPRIGHT",-20, -1);
	lixianBAG.topbg:SetTexCoord(0,0.2890625,0,0.421875,1.359809994697571,0.2890625,1.359809994697571,0.421875);
	lixianBAG.topbg:SetHeight(20);

	lixianBAG.Portrait_BG = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.Portrait_BG:SetTexture("interface/buttons/iconborder-glowring.blp");
	lixianBAG.Portrait_BG:SetSize(56,56);
	lixianBAG.Portrait_BG:SetPoint("TOPLEFT",lixianBAG,"TOPLEFT",0,4.6);
	lixianBAG.Portrait_BG:SetDrawLayer("BORDER", -2)
	lixianBAG.Portrait_BGmask = lixianBAG:CreateMaskTexture()
	lixianBAG.Portrait_BGmask:SetAllPoints(lixianBAG.Portrait_BG)
	lixianBAG.Portrait_BGmask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	lixianBAG.Portrait_BG:AddMaskTexture(lixianBAG.Portrait_BGmask)
	lixianBAG.Portrait_TEX = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.Portrait_TEX:SetTexture(130899)
	lixianBAG.Portrait_TEX:SetDrawLayer("BORDER", -1)
	lixianBAG.Portrait_TEX:SetAllPoints(lixianBAG.Portrait_BG)

	lixianBAG.TOPLEFT = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.TOPLEFT:SetTexture("interface/framegeneral/ui-frame.blp");
	lixianBAG.TOPLEFT:SetPoint("TOPLEFT", lixianBAG, "TOPLEFT",-10, 10);
	lixianBAG.TOPLEFT:SetTexCoord(0.0078125,0.0078125,0.0078125,0.6171875,0.6171875,0.0078125,0.6171875,0.6171875);
	lixianBAG.TOPLEFT:SetSize(78,78);
	lixianBAG.TOPRIGHT = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.TOPRIGHT:SetTexture(374156);
	lixianBAG.TOPRIGHT:SetPoint("TOPRIGHT", lixianBAG, "TOPRIGHT",0, 0);
	lixianBAG.TOPRIGHT:SetTexCoord(0.6328125,0.0078125,0.6328125,0.265625,0.890625,0.0078125,0.890625,0.265625);
	lixianBAG.TOPRIGHT:SetSize(33,33);
	lixianBAG.TOP = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.TOP:SetTexture(374157);
	lixianBAG.TOP:SetPoint("TOPLEFT", lixianBAG.TOPLEFT, "TOPRIGHT",0, -10);
	lixianBAG.TOP:SetPoint("BOTTOMRIGHT", lixianBAG.TOPRIGHT, "BOTTOMLEFT", 0, 5);
	lixianBAG.TOP:SetTexCoord(0,0.4375,0,0.65625,1.08637285232544,0.4375,1.08637285232544,0.65625);

	lixianBAG.BOTTOMLEFT = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.BOTTOMLEFT:SetTexture(374156);
	lixianBAG.BOTTOMLEFT:SetPoint("BOTTOMLEFT", lixianBAG, "BOTTOMLEFT",-2, 0);
	lixianBAG.BOTTOMLEFT:SetTexCoord(0.0078125,0.6328125,0.0078125,0.7421875,0.1171875,0.6328125,0.1171875,0.7421875);
	lixianBAG.BOTTOMLEFT:SetSize(14,14);

	lixianBAG.BOTTOMRIGHT = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.BOTTOMRIGHT:SetTexture(374156);
	lixianBAG.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", lixianBAG, "BOTTOMRIGHT",0, 0);
	lixianBAG.BOTTOMRIGHT:SetTexCoord(0.1328125,0.8984375,0.1328125,0.984375,0.21875,0.8984375,0.21875,0.984375);
	lixianBAG.BOTTOMRIGHT:SetSize(11,11);

	lixianBAG.LEFT = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.LEFT:SetTexture(374153);
	lixianBAG.LEFT:SetTexCoord(0.359375,0,0.359375,1.42187488079071,0.609375,0,0.609375,1.42187488079071);
	lixianBAG.LEFT:SetPoint("TOPLEFT", lixianBAG.TOPLEFT, "BOTTOMLEFT",8.04, 0);
	lixianBAG.LEFT:SetPoint("BOTTOMLEFT", lixianBAG.BOTTOMLEFT, "TOPLEFT", 0, 0);
	lixianBAG.LEFT:SetWidth(16);

	lixianBAG.RIGHT = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.RIGHT:SetTexture(374153);
	lixianBAG.RIGHT:SetTexCoord(0.171875,0,0.171875,1.5703125,0.328125,0,0.328125,1.5703125);
	lixianBAG.RIGHT:SetPoint("TOPRIGHT", lixianBAG.TOPRIGHT, "BOTTOMRIGHT",0.8, 0);
	lixianBAG.RIGHT:SetPoint("BOTTOMRIGHT", lixianBAG.BOTTOMRIGHT, "TOPRIGHT", 0, 0);
	lixianBAG.RIGHT:SetWidth(10);

	lixianBAG.BOTTOM = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.BOTTOM:SetTexture(374157);
	lixianBAG.BOTTOM:SetTexCoord(0,0.203125,0,0.2734375,1.425781607627869,0.203125,1.425781607627869,0.2734375);
	lixianBAG.BOTTOM:SetPoint("BOTTOMLEFT", lixianBAG.BOTTOMLEFT, "BOTTOMRIGHT",0, -0);
	lixianBAG.BOTTOM:SetPoint("BOTTOMRIGHT", lixianBAG.BOTTOMRIGHT, "BOTTOMLEFT", 0, 0);
	lixianBAG.BOTTOM:SetHeight(9);

	--------------------------
	lixianBAG.biaoti = CreateFrame("Frame", nil, lixianBAG)
	lixianBAG.biaoti:SetPoint("TOPLEFT", lixianBAG, "TOPLEFT",58, -1);
	lixianBAG.biaoti:SetPoint("TOPRIGHT", lixianBAG, "TOPRIGHT",-26, -1);
	lixianBAG.biaoti:SetHeight(20);
	lixianBAG.biaoti:EnableMouse(true)
	lixianBAG.biaoti:RegisterForDrag("LeftButton")
	lixianBAG.biaoti:SetScript("OnDragStart",function()
	    lixianBAG:StartMoving();
	    lixianBAG:SetUserPlaced(false)
	end)
	lixianBAG.biaoti:SetScript("OnDragStop",function()
	    lixianBAG:StopMovingOrSizing()
	    lixianBAG:SetUserPlaced(false)
	end)
	lixianBAG.biaoti.t = lixianBAG:CreateFontString();
	lixianBAG.biaoti.t:SetPoint("CENTER", lixianBAG.topbg, "CENTER", 4, -1);
	lixianBAG.biaoti.t:SetFontObject(GameFontNormal);

	lixianBAG.Close = CreateFrame("Button",nil,lixianBAG, "UIPanelCloseButton");
	lixianBAG.Close:SetSize(30,30);
	lixianBAG.Close:SetPoint("TOPRIGHT",lixianBAG,"TOPRIGHT",3,3);

	lixianBAG.wupin = CreateFrame("Frame", nil, lixianBAG,"BackdropTemplate")
	lixianBAG.wupin:SetBackdrop( { bgFile = "interface/framegeneral/ui-background-marble.blp" });
	lixianBAG.wupin:SetPoint("TOPLEFT", lixianBAG, "TOPLEFT",10, -56);
	lixianBAG.wupin:SetPoint("BOTTOMRIGHT", lixianBAG, "BOTTOMRIGHT", -10, 26);
	lixianBAG.wupin:EnableMouse(true)
	for i=1,164 do
		lixianBAG.wupin.item = CreateFrame("Button", "lixianBAG_wupin_item_"..i, lixianBAG.wupin, "SecureActionButtonTemplate");
		lixianBAG.wupin.item:SetHighlightTexture(130718);
		lixianBAG.wupin.item:SetSize(BAOGUOdangeW-4,BAOGUOdangeW-4);
		if i==1 then
			lixianBAG.wupin.item:SetPoint("TOPLEFT",lixianBAG.wupin,"TOPLEFT",4,-4);
		else
			local yushu=math.fmod((i-1),meihang)
			if yushu==0 then
				lixianBAG.wupin.item:SetPoint("TOPLEFT", _G["lixianBAG_wupin_item_"..(i-meihang)], "BOTTOMLEFT", 0, -2);
			else
				lixianBAG.wupin.item:SetPoint("LEFT", _G["lixianBAG_wupin_item_"..(i-1)], "RIGHT", 2, 0);
			end
		end
		lixianBAG.wupin.item:Hide();
		lixianBAG.wupin.item.LV = lixianBAG.wupin.item:CreateFontString();
		lixianBAG.wupin.item.LV:SetPoint("TOPRIGHT", lixianBAG.wupin.item, "TOPRIGHT", 0,-1);
		lixianBAG.wupin.item.LV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		lixianBAG.wupin.item.shuliang = lixianBAG.wupin.item:CreateFontString();
		lixianBAG.wupin.item.shuliang:SetPoint("BOTTOMRIGHT", lixianBAG.wupin.item, "BOTTOMRIGHT", -4,2);
		lixianBAG.wupin.item.shuliang:SetFontObject(TextStatusBarText);
	end
	--已装备物品================================
	local juesezhuangbei = CreateFrame("Frame", "juesezhuangbei_UI", UIParent,"BackdropTemplate");
	juesezhuangbei:SetSize(360,444);
	juesezhuangbei:SetPoint("CENTER", UIParent, "CENTER", -100, 100)
	juesezhuangbei:SetMovable(true)
	juesezhuangbei:SetUserPlaced(false)
	juesezhuangbei:SetClampedToScreen(true)
	juesezhuangbei:SetFrameLevel(130)
	juesezhuangbei:Hide();
	tinsert(UISpecialFrames,"juesezhuangbei_UI");
	juesezhuangbei.Portrait_BG = juesezhuangbei:CreateTexture(nil, "BORDER");
	juesezhuangbei.Portrait_BG:SetTexture("interface/buttons/iconborder-glowring.blp");
	juesezhuangbei.Portrait_BG:SetSize(57,57);
	juesezhuangbei.Portrait_BG:SetPoint("TOPLEFT",juesezhuangbei,"TOPLEFT",11,-7.8);
	juesezhuangbei.Portrait_BG:SetDrawLayer("BORDER", -2)
	juesezhuangbei.Portrait_BGmask = juesezhuangbei:CreateMaskTexture()
	juesezhuangbei.Portrait_BGmask:SetAllPoints(juesezhuangbei.Portrait_BG)
	juesezhuangbei.Portrait_BGmask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	juesezhuangbei.Portrait_BG:AddMaskTexture(juesezhuangbei.Portrait_BGmask)
	juesezhuangbei.Portrait_TEX = juesezhuangbei:CreateTexture(nil, "BORDER");
	juesezhuangbei.Portrait_TEX:SetTexture(130899)
	juesezhuangbei.Portrait_TEX:SetDrawLayer("BORDER", -1)
	juesezhuangbei.Portrait_TEX:SetAllPoints(juesezhuangbei.Portrait_BG)
	juesezhuangbei.TOPLEFT = juesezhuangbei:CreateTexture(nil, "BORDER");
	juesezhuangbei.TOPLEFT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-l1.blp");
	juesezhuangbei.TOPLEFT:SetPoint("TOPLEFT", juesezhuangbei, "TOPLEFT",0, 0);
	juesezhuangbei.TOPRIGHT = juesezhuangbei:CreateTexture(nil, "BORDER");
	juesezhuangbei.TOPRIGHT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-r1.blp");
	juesezhuangbei.TOPRIGHT:SetPoint("TOPLEFT", juesezhuangbei.TOPLEFT, "TOPRIGHT",0, 0);
	juesezhuangbei.BOTTOMLEFT = juesezhuangbei:CreateTexture(nil, "BORDER");
	juesezhuangbei.BOTTOMLEFT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-bottomleft.blp");
	juesezhuangbei.BOTTOMLEFT:SetPoint("TOPLEFT", juesezhuangbei.TOPLEFT, "BOTTOMLEFT",0, 0);
	juesezhuangbei.BOTTOMRIGHT = juesezhuangbei:CreateTexture(nil, "BORDER");
	juesezhuangbei.BOTTOMRIGHT:SetTexture("interface/paperdollinfoframe/ui-character-charactertab-bottomright.blp");
	juesezhuangbei.BOTTOMRIGHT:SetPoint("TOPLEFT", juesezhuangbei.BOTTOMLEFT, "TOPRIGHT",0, 0);

	juesezhuangbei.biaoti = CreateFrame("Frame", nil, juesezhuangbei)
	juesezhuangbei.biaoti:SetPoint("TOPLEFT", juesezhuangbei, "TOPLEFT",72, -14);
	juesezhuangbei.biaoti:SetPoint("TOPRIGHT", juesezhuangbei, "TOPRIGHT",-36, -1);
	juesezhuangbei.biaoti:SetHeight(20);
	juesezhuangbei.biaoti:EnableMouse(true)
	juesezhuangbei.biaoti:RegisterForDrag("LeftButton")
	juesezhuangbei.biaoti:SetScript("OnDragStart",function()
	    juesezhuangbei:StartMoving();
	    juesezhuangbei:SetUserPlaced(false)
	end)
	juesezhuangbei.biaoti:SetScript("OnDragStop",function()
	    juesezhuangbei:StopMovingOrSizing()
	    juesezhuangbei:SetUserPlaced(false)
	end)
	juesezhuangbei.biaoti.t = juesezhuangbei:CreateFontString();
	juesezhuangbei.biaoti.t:SetPoint("CENTER", juesezhuangbei.biaoti, "CENTER", 2, -1);
	juesezhuangbei.biaoti.t:SetFontObject(GameFontNormal);
	juesezhuangbei.biaoti.t:SetTextColor(1, 1, 1, 1);

	juesezhuangbei.Close = CreateFrame("Button",nil,juesezhuangbei, "UIPanelCloseButton");
	juesezhuangbei.Close:SetSize(32,32);
	juesezhuangbei.Close:SetPoint("TOPRIGHT",juesezhuangbei,"TOPRIGHT",-3.2,-8.6);
	local zhuangbeishunxuID = {1,2,3,15,5,4,19,9,10,6,7,8,11,12,13,14,16,17,18}
	for i=1,#zhuangbeishunxuID do
		juesezhuangbei.item = CreateFrame("Button", "juesezhuangbei_item_"..zhuangbeishunxuID[i], juesezhuangbei, "SecureActionButtonTemplate");
		juesezhuangbei.item:SetHighlightTexture(130718);
		juesezhuangbei.item:SetSize(BKdangeW-4,BKdangeW-4);
		if i<17 then
			if i==1 then
				juesezhuangbei.item:SetPoint("TOPLEFT",juesezhuangbei,"TOPLEFT",20,-74);
			elseif i==9 then
				juesezhuangbei.item:SetPoint("TOPLEFT",juesezhuangbei,"TOPLEFT",305,-74);
			else
				juesezhuangbei.item:SetPoint("TOP", _G["juesezhuangbei_item_"..(zhuangbeishunxuID[i-1])], "BOTTOM", 0, -3);
			end
		else
			if i==17 then
				juesezhuangbei.item:SetPoint("TOPLEFT",juesezhuangbei,"TOPLEFT",121,-385);
			else
				juesezhuangbei.item:SetPoint("LEFT", _G["juesezhuangbei_item_"..(zhuangbeishunxuID[i-1])], "RIGHT", 3, 0);
			end
		end
		juesezhuangbei.item.LV = juesezhuangbei.item:CreateFontString();
		juesezhuangbei.item.LV:SetPoint("TOPRIGHT", juesezhuangbei.item, "TOPRIGHT", 0,-1);
		juesezhuangbei.item.LV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	end

	
	---银行================================
	local BankFrameP = CreateFrame("Frame", "BankFrameP_UI", UIParent,"BackdropTemplate");
	BankFrameP:SetBackdropBorderColor(0.8, 0.8, 0.8, 1);
	BankFrameP:SetPoint("TOPLEFT", BankFrame, "TOPLEFT", 10, 0)
	BankFrameP:SetSize(BKmeihang*BKdangeW+16,210);
	BankFrameP:SetMovable(true)
	BankFrameP:SetUserPlaced(false)
	BankFrameP:SetClampedToScreen(true)
	BankFrame:HookScript("OnShow", function()
		BankFrameP:Show()
	end);
	BankFrame:HookScript("OnHide", function()
		BankFrameP:Hide()
		BankFrameP.Close:Hide()
	end);
	BankFrameP:Hide()
	BankFrameP:SetFrameLevel(120)
	tinsert(UISpecialFrames,"BankFrameP_UI");
	BankFrameP.Close = CreateFrame("Button",nil,BankFrameP, "UIPanelCloseButton");
	BankFrameP.Close:SetSize(30,30);
	BankFrameP.Close:SetPoint("TOPRIGHT",BankFrameP,"TOPRIGHT",4,3);
	BankFrameP.Close:Hide();

	BankFrameP.Bg = BankFrameP:CreateTexture(nil, "BACKGROUND");
	BankFrameP.Bg:SetTexture("interface/framegeneral/ui-background-rock.blp");
	BankFrameP.Bg:SetPoint("TOPLEFT", BankFrameP, "TOPLEFT",2, -2);
	BankFrameP.Bg:SetPoint("BOTTOMRIGHT", BankFrameP, "BOTTOMRIGHT", -2, 2);
	BankFrameP.topbg = BankFrameP:CreateTexture(nil, "BACKGROUND");
	BankFrameP.topbg:SetTexture(374157);
	BankFrameP.topbg:SetPoint("TOPLEFT", BankFrameP, "TOPLEFT",58, -1);
	BankFrameP.topbg:SetPoint("TOPRIGHT", BankFrameP, "TOPRIGHT",-20, -1);
	BankFrameP.topbg:SetTexCoord(0,0.2890625,0,0.421875,1.359809994697571,0.2890625,1.359809994697571,0.421875);
	BankFrameP.topbg:SetHeight(20);
	BankFrameP.biaoti_t = BankFrameP:CreateFontString();
	BankFrameP.biaoti_t:SetPoint("CENTER", BankFrameP.topbg, "CENTER", 8, -1);
	BankFrameP.biaoti_t:SetFontObject(GameFontNormal);
	BankFrameP.biaoti_t:SetText('银行');

	BankFrameP.Portrait_BG = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.Portrait_BG:SetTexture("interface/buttons/iconborder-glowring.blp");
	BankFrameP.Portrait_BG:SetSize(55,55);
	BankFrameP.Portrait_BG:SetPoint("TOPLEFT",BankFrameP,"TOPLEFT",1,4);
	BankFrameP.Portrait_BG:SetDrawLayer("BORDER", -2)
	BankFrameP.Portrait_BGmask = BankFrameP:CreateMaskTexture()
	BankFrameP.Portrait_BGmask:SetAllPoints(BankFrameP.Portrait_BG)
	BankFrameP.Portrait_BGmask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	BankFrameP.Portrait_BG:AddMaskTexture(BankFrameP.Portrait_BGmask)
	BankFrameP.Portrait_TEX = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.Portrait_TEX:SetAllPoints(BankFrameP.Portrait_BG)
	BankFrameP.Portrait_TEX:SetDrawLayer("BORDER", -1)

	BankFrameP.TOPLEFT = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.TOPLEFT:SetTexture("interface/framegeneral/ui-frame.blp");
	BankFrameP.TOPLEFT:SetPoint("TOPLEFT", BankFrameP, "TOPLEFT",-10, 10);
	BankFrameP.TOPLEFT:SetTexCoord(0.0078125,0.0078125,0.0078125,0.6171875,0.6171875,0.0078125,0.6171875,0.6171875);
	BankFrameP.TOPLEFT:SetSize(78,78);
	BankFrameP.TOPRIGHT = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.TOPRIGHT:SetTexture(374156);
	BankFrameP.TOPRIGHT:SetPoint("TOPRIGHT", BankFrameP, "TOPRIGHT",0, 0);
	BankFrameP.TOPRIGHT:SetTexCoord(0.6328125,0.0078125,0.6328125,0.265625,0.890625,0.0078125,0.890625,0.265625);
	BankFrameP.TOPRIGHT:SetSize(33,33);
	BankFrameP.TOP = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.TOP:SetTexture(374157);
	BankFrameP.TOP:SetPoint("TOPLEFT", BankFrameP.TOPLEFT, "TOPRIGHT",0, -10);
	BankFrameP.TOP:SetPoint("BOTTOMRIGHT", BankFrameP.TOPRIGHT, "BOTTOMLEFT", 0, 5);
	BankFrameP.TOP:SetTexCoord(0,0.4375,0,0.65625,1.08637285232544,0.4375,1.08637285232544,0.65625);

	BankFrameP.BOTTOMLEFT = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.BOTTOMLEFT:SetTexture(374156);
	BankFrameP.BOTTOMLEFT:SetPoint("BOTTOMLEFT", BankFrameP, "BOTTOMLEFT",-2, 0);
	BankFrameP.BOTTOMLEFT:SetTexCoord(0.0078125,0.6328125,0.0078125,0.7421875,0.1171875,0.6328125,0.1171875,0.7421875);
	BankFrameP.BOTTOMLEFT:SetSize(14,14);

	BankFrameP.BOTTOMRIGHT = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.BOTTOMRIGHT:SetTexture(374156);
	BankFrameP.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", BankFrameP, "BOTTOMRIGHT",0, 0);
	BankFrameP.BOTTOMRIGHT:SetTexCoord(0.1328125,0.8984375,0.1328125,0.984375,0.21875,0.8984375,0.21875,0.984375);
	BankFrameP.BOTTOMRIGHT:SetSize(11,11);

	BankFrameP.LEFT = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.LEFT:SetTexture(374153);
	BankFrameP.LEFT:SetTexCoord(0.359375,0,0.359375,1.42187488079071,0.609375,0,0.609375,1.42187488079071);
	BankFrameP.LEFT:SetPoint("TOPLEFT", BankFrameP.TOPLEFT, "BOTTOMLEFT",8.04, 0);
	BankFrameP.LEFT:SetPoint("BOTTOMLEFT", BankFrameP.BOTTOMLEFT, "TOPLEFT", 0, 0);
	BankFrameP.LEFT:SetWidth(16);

	BankFrameP.RIGHT = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.RIGHT:SetTexture(374153);
	BankFrameP.RIGHT:SetTexCoord(0.171875,0,0.171875,1.5703125,0.328125,0,0.328125,1.5703125);
	BankFrameP.RIGHT:SetPoint("TOPRIGHT", BankFrameP.TOPRIGHT, "BOTTOMRIGHT",0.8, 0);
	BankFrameP.RIGHT:SetPoint("BOTTOMRIGHT", BankFrameP.BOTTOMRIGHT, "TOPRIGHT", 0, 0);
	BankFrameP.RIGHT:SetWidth(10);

	BankFrameP.BOTTOM = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.BOTTOM:SetTexture(374157);
	BankFrameP.BOTTOM:SetTexCoord(0,0.203125,0,0.2734375,1.425781607627869,0.203125,1.425781607627869,0.2734375);
	BankFrameP.BOTTOM:SetPoint("BOTTOMLEFT", BankFrameP.BOTTOMLEFT, "BOTTOMRIGHT",0, -0);
	BankFrameP.BOTTOM:SetPoint("BOTTOMRIGHT", BankFrameP.BOTTOMRIGHT, "BOTTOMLEFT", 0, 0);
	BankFrameP.BOTTOM:SetHeight(9);

	local Mkuandu,Mgaodu = 8,22
	BankFrameP.R = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.R:SetTexture("interface/common/moneyframe.blp");
	BankFrameP.R:SetTexCoord(0,0.05,0,0.31);
	BankFrameP.R:SetSize(Mkuandu,Mgaodu);
	BankFrameP.R:SetPoint("BOTTOMRIGHT", BankFrameP, "BOTTOMRIGHT", -5, 6)
	BankFrameP.l = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.l:SetTexture("interface/common/moneyframe.blp");
	BankFrameP.l:SetTexCoord(0.95,1,0,0.31);
	BankFrameP.l:SetSize(Mkuandu,Mgaodu);
	BankFrameP.l:SetPoint("RIGHT", BankFrameP.R, "LEFT", -160, 0)
	BankFrameP.C = BankFrameP:CreateTexture(nil, "BORDER");
	BankFrameP.C:SetTexture("interface/common/moneyframe.blp");
	BankFrameP.C:SetTexCoord(0.1,0.9,0.314,0.621);
	BankFrameP.C:SetPoint("TOPLEFT", BankFrameP.l, "TOPRIGHT", 0, 0)
	BankFrameP.C:SetPoint("BOTTOMRIGHT", BankFrameP.R, "BOTTOMLEFT", 0, 0)
	-------
	BankFrame.biaoti = CreateFrame("Frame", nil, BankFrame)
	BankFrame.biaoti:SetPoint("TOPLEFT", BankFrame, "TOPLEFT",58, -1);
	BankFrame.biaoti:SetPoint("TOPRIGHT", BankFrame, "TOPRIGHT",-26, -1);
	BankFrame.biaoti:SetHeight(20);
	BankFrame.biaoti:EnableMouse(true)
	BankFrame.biaoti:RegisterForDrag("LeftButton")
	BankFrame:SetMovable(true)
	BankFrame:SetUserPlaced(false)
	BankFrame:SetClampedToScreen(true)
	BankFrame.biaoti:SetScript("OnDragStart",function()
	    BankFrame:StartMoving();
	    BankFrame:SetUserPlaced(false)
	end)
	BankFrame.biaoti:SetScript("OnDragStop",function()
	    BankFrame:StopMovingOrSizing()
	    BankFrame:SetUserPlaced(false)
	end)
	BankCloseButton:SetScript("PostClick",  function (self)
		if not IsBagOpen(0) then BAGheji_UI:Hide() end
	end);
	BankFrame.AutoSort = CreateFrame("Button",nil,BankFrame, "TruncatedButtonTemplate");
	BankFrame.AutoSort:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
	BankFrame.AutoSort:SetSize(24,24);
	BankFrame.AutoSort:SetPoint("TOPRIGHT",BankFrame,"TOPRIGHT",-60,-29);
	BankFrame.AutoSort.Tex = BankFrame.AutoSort:CreateTexture(nil, "BORDER");
	BankFrame.AutoSort.Tex:SetTexture(zhengliIcon);
	BankFrame.AutoSort.Tex:SetTexCoord(0.168,0.27,0.837,0.934);
	BankFrame.AutoSort.Tex:SetAllPoints(BankFrame.AutoSort)

	BankFrame.AutoSort.Tex1 = BankFrame.AutoSort:CreateTexture(nil, "BORDER");
	BankFrame.AutoSort.Tex1:SetTexture(zhengliIcon);
	BankFrame.AutoSort.Tex1:SetTexCoord(0.008,0.11,0.86,0.958);
	BankFrame.AutoSort.Tex1:SetAllPoints(BankFrame.AutoSort)
	BankFrame.AutoSort.Tex1:Hide();
	BankFrame.AutoSort:SetScript("OnMouseDown", function (self)
		self.Tex:Hide();
		self.Tex1:Show();
	end);
	BankFrame.AutoSort:SetScript("OnMouseUp", function (self)
		self.Tex:Show();
		self.Tex1:Hide();
	end);
	BankFrame.AutoSort:SetScript("OnClick",  function (self)
		PlaySoundFile(567463, "Master")
		SortBankBagsPIG()
	end);

	BankFrameP.wupin = CreateFrame("Frame", nil, BankFrameP,"BackdropTemplate")
	BankFrameP.wupin:SetBackdrop( { bgFile = "interface/framegeneral/ui-background-marble.blp" });
	BankFrameP.wupin:SetPoint("TOPLEFT", BankFrameP, "TOPLEFT",6, -56);
	BankFrameP.wupin:SetPoint("BOTTOMRIGHT", BankFrameP, "BOTTOMRIGHT", -6, 26);
	BankFrameP.wupin:EnableMouse(true)
	for i=1,280 do
		BankFrameP.wupin.item = CreateFrame("Button", "BankFrameP_wupin_item_"..i, BankFrameP.wupin, "SecureActionButtonTemplate");
		BankFrameP.wupin.item:SetHighlightTexture(130718);
		BankFrameP.wupin.item:SetSize(BKdangeW-2,BKdangeW-2);
		if i==1 then
			BankFrameP.wupin.item:SetPoint("TOPLEFT",BankFrameP.wupin,"TOPLEFT",4,-2);
		else
			local yushu=math.fmod((i-1),BKmeihang)
			if yushu==0 then
				BankFrameP.wupin.item:SetPoint("TOPLEFT", _G["BankFrameP_wupin_item_"..(i-BKmeihang)], "BOTTOMLEFT", 0, -4);
			else
				BankFrameP.wupin.item:SetPoint("LEFT", _G["BankFrameP_wupin_item_"..(i-1)], "RIGHT", 2, 0);
			end
		end
		BankFrameP.wupin.item:Hide();
		if PIG['zhegnheBAG']["wupinLV"] then
			BankFrameP.wupin.item.LV = BankFrameP.wupin.item:CreateFontString();
			BankFrameP.wupin.item.LV:SetPoint("TOPRIGHT", BankFrameP.wupin.item, "TOPRIGHT", 0,-1);
			BankFrameP.wupin.item.LV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		end
		BankFrameP.wupin.item.shuliang = BankFrameP.wupin.item:CreateFontString();
		BankFrameP.wupin.item.shuliang:SetPoint("BOTTOMRIGHT", BankFrameP.wupin.item, "BOTTOMRIGHT", -4,2);
		BankFrameP.wupin.item.shuliang:SetFontObject(TextStatusBarText);
	end
	---------------
	--BankFrame:RegisterEvent("BAG_UPDATE_DELAYED")
	BankFrame:HookScript("OnEvent", function (self,event,arg1)
		if event=="PLAYERBANKSLOTS_CHANGED" then
			C_Timer.After(0.4,SAVE_bank)
			if PIG['zhegnheBAG']["wupinLV"] then
				shuaxinyinhangMOREN(arg1)
			end
			if PIG['zhegnheBAG']["wupinRanse"] then shuaxinyinhangMOREN_ranse(arg1) end
		end
		if event=="BAG_UPDATE_DELAYED" then
			-- BankFrameMoneyFrame:SetPoint("BOTTOMRIGHT", BankSlotsFrame, "BOTTOMRIGHT", 6, -60);
			-- for i=0,11 do
			-- 	shuaxinBANKweizhi(frame, size, id)
			-- end
			-- CloseBag(0);CloseBag(1);CloseBag(2);CloseBag(3);CloseBag(4);CloseBag(5);CloseBag(6);CloseBag(7);CloseBag(8);CloseBag(9);CloseBag(10);CloseBag(11);
			-- OpenBag(0);OpenBag(1);OpenBag(2);OpenBag(3);OpenBag(4);OpenBag(5);OpenBag(6);OpenBag(7);OpenBag(8);OpenBag(9);OpenBag(10);OpenBag(11);
		end
		if event=="BANKFRAME_OPENED" then
			SetPortraitTexture(BAGheji.Portrait_TEX, "player")
			zhegnheBANK()
			OpenBag(5);OpenBag(6);OpenBag(7);OpenBag(8);OpenBag(9);OpenBag(10);OpenBag(11);	
			C_Timer.After(0.4,SAVE_bank)
			if PIG['zhegnheBAG']["wupinLV"] then
				for i=1,yinhangmorengezishu[1] do
					shuaxinyinhangMOREN(i)
				end
			end
			if PIG['zhegnheBAG']["wupinRanse"] then
				for i=1,yinhangmorengezishu[1] do
					shuaxinyinhangMOREN_ranse(i) 
				end
			end
		end
	end)
	---------------------
	local beibaozhengheFFF = CreateFrame("Frame");
	beibaozhengheFFF:RegisterUnitEvent("PLAYER_ENTERING_WORLD")
	beibaozhengheFFF:RegisterUnitEvent("UNIT_MODEL_CHANGED","player")
	beibaozhengheFFF:RegisterUnitEvent("UNIT_PORTRAIT_UPDATE","player")
	beibaozhengheFFF:HookScript("OnEvent", function(self,event,arg1)			
		if event=="PLAYER_ENTERING_WORLD" then 
			BAGheji_UI:Hide()
		end
		if event=="UNIT_MODEL_CHANGED" then
			SAVE_C()
		end
				
		if event=="UNIT_PORTRAIT_UPDATE" then
			SetPortraitTexture(BAGheji.Portrait_TEX, "player")
		end
		if event=="BAG_UPDATE" then
			if arg1>=0 and arg1<5 then
				C_Timer.After(0.4,SAVE_BAG)
				if PIG['zhegnheBAG']["wupinLV"] then
					Bag_Item_lv(nil, nil, arg1)
				end
				if PIG['zhegnheBAG']["wupinRanse"] then Bag_Item_Ranse(nil, nil, arg1) end
			end
			if BankFrame:IsShown() then
				if arg1>4 then
					C_Timer.After(0.4,SAVE_bank)
					if PIG['zhegnheBAG']["wupinLV"] then
						Bag_Item_lv(nil, nil, arg1)
					end
					if PIG['zhegnheBAG']["wupinRanse"] then Bag_Item_Ranse(nil, nil, arg1) end
				end
			end
			if tocversion>29999 then	
				if arg1==0 then
					BagItemSearchBox:SetParent(BAGheji_UI);
					BagItemSearchBox:ClearAllPoints();
					BagItemSearchBox:SetPoint("TOPLEFT",BAGheji_UI,"TOPLEFT",70,-28);
					--BagItemSearchBox.anchorBag = self;
					BagItemSearchBox:Show();
					BagItemAutoSortButton:SetParent(BAGheji_UI);
					BagItemAutoSortButton:ClearAllPoints();
					BagItemAutoSortButton:SetPoint("TOPLEFT",BAGheji_UI,"TOPLEFT",240,-29);
					BagItemAutoSortButton:Show();
				end
			end
		end
	end)
	local function zhixingbaocunCMD()
		SAVE_BAG()
		beibaozhengheFFF:RegisterEvent("BAG_UPDATE")
	end
	C_Timer.After(6,zhixingbaocunCMD)
	C_Timer.After(10,zhixingbaocunCMD)
	---------------------
	hooksecurefunc("ContainerFrame_GenerateFrame", function(frame, size, id)
		--print(id)
		if id==-2 then
			shuaxinKEYweizhi(frame, size, id)
		end

		if id>=0 and id<5 then
			shuaxinBAGweizhi(frame, size, id)
		end

		if id>4 and id<12 then
			shuaxinBANKweizhi(frame, size, id)
		end

		if PIG['zhegnheBAG']["wupinLV"] then Bag_Item_lv(frame, size, id) end
		if PIG['zhegnheBAG']["wupinRanse"] then Bag_Item_Ranse(frame, size, id) end
	end)
	MainMenuBarBackpackButton:SetScript("OnClick", function(self, button)
		if ( IsBagOpen(0) ) then
			CloseAllBags()
		else
			OpenAllBags()
		end
	end)
	CharacterBag0Slot:SetScript("OnClick", function(self, button)
		if ( IsBagOpen(0) ) then
			CloseAllBags()
		else
			OpenAllBags()
		end
	end)
	CharacterBag1Slot:SetScript("OnClick", function(self, button)
		if ( IsBagOpen(0) ) then
			CloseAllBags()
		else
			OpenAllBags()
		end
	end)
	CharacterBag2Slot:SetScript("OnClick", function(self, button)
		if ( IsBagOpen(0) ) then
			CloseAllBags()
		else
			OpenAllBags()
		end
	end)
	CharacterBag3Slot:SetScript("OnClick", function(self, button)
		if ( IsBagOpen(0) ) then
			CloseAllBags()
		else
			OpenAllBags()
		end
	end)

	local Old_ContainerFrame_GenerateFrame=ContainerFrame_GenerateFrame
	ContainerFrame_GenerateFrame= function(frame, size, id)
		local name = frame:GetName();
		for i=1,size do
			_G[name.."Item"..i]:ClearAllPoints();
		end
		return Old_ContainerFrame_GenerateFrame(frame, size, id);
	end

	local Old_ToggleBackpack=ToggleBackpack
	ToggleBackpack= function()
		if ( IsOptionFrameOpen() ) then
			return;
		end
		if ( IsBagOpen(0) ) then
			for i=1,#bagID do
				local x = IsBagOpen(bagID[i]);
				if x then
					local frame = _G["ContainerFrame"..x];
					if ( frame:IsShown() ) then
						frame:Hide();
						EventRegistry:TriggerEvent("ContainerFrame.CloseBackpack");
					end
					if ( BackpackTokenFrame ) then
						BackpackTokenFrame:Hide();
					end
				end
			end
			BAGheji:Hide()
		else
			CloseBag(-2);
			ToggleBag(0);ToggleBag(1);ToggleBag(2);ToggleBag(3);ToggleBag(4);
			if ( ManageBackpackTokenFrame ) then
				BackpackTokenFrame_Update();
				ManageBackpackTokenFrame();
			end
		end	
	end
	---系统关闭背包事件追加关闭背景
	hooksecurefunc('CloseBackpack', function()
		BAGheji_UI:Hide()
	end);
end
--==========================================================
fuFrame.beibaoxin1 = fuFrame:CreateLine()
fuFrame.beibaoxin1:SetColorTexture(1,1,1,0.4)
fuFrame.beibaoxin1:SetThickness(1);
fuFrame.beibaoxin1:SetStartPoint("TOPLEFT",3,-110)
fuFrame.beibaoxin1:SetEndPoint("TOPRIGHT",-2,-110)

fuFrame.beibaozhenghe = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.beibaozhenghe:SetSize(30,32);
fuFrame.beibaozhenghe:SetHitRectInsets(0,-100,0,0);
fuFrame.beibaozhenghe:SetPoint("TOPLEFT",fuFrame.beibaoxin1,"TOPLEFT",20,-20);
fuFrame.beibaozhenghe.Text:SetText("整合背包/银行");
fuFrame.beibaozhenghe.tooltip = "整合背包/银行！";
fuFrame.beibaozhenghe:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['zhegnheBAG']["Open"]="ON";
		zhegnhe_Open()
		addonTable.qiyongzidongzhengli()
	else
		PIG['zhegnheBAG']["Open"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);

-------------
--背包剩余
MainMenuBarBackpackButton.yushu = MainMenuBarBackpackButton:CreateFontString();
MainMenuBarBackpackButton.yushu:SetPoint("BOTTOMRIGHT", MainMenuBarBackpackButton, "BOTTOMRIGHT", -2, 4);
MainMenuBarBackpackButton.yushu:SetFont(ChatFontNormal:GetFont(), 18, "OUTLINE");
local function gengxinbeibaoshengyugeshu()
	local beibaoshengyushuliangduoshao = 0
	for bag=BACKPACK_CONTAINER, NUM_BAG_SLOTS do 
		local numberOfFreeSlots=GetContainerNumFreeSlots(bag);
		beibaoshengyushuliangduoshao=beibaoshengyushuliangduoshao+numberOfFreeSlots
	end
	MainMenuBarBackpackButton.yushu:SetText(beibaoshengyushuliangduoshao); 
	if beibaoshengyushuliangduoshao<10 then
		MainMenuBarBackpackButton.yushu:SetTextColor(1, 0, 0, 1);
	else
		MainMenuBarBackpackButton.yushu:SetTextColor(0, 1, 0, 1);
	end
end

fuFrame.BAGkongyu = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.BAGkongyu:SetSize(30,32);
fuFrame.BAGkongyu:SetHitRectInsets(0,-100,0,0);
fuFrame.BAGkongyu:SetPoint("TOPLEFT",fuFrame.beibaoxin1,"TOPLEFT",300,-20);
fuFrame.BAGkongyu.Text:SetText("显示背包剩余格数");
fuFrame.BAGkongyu.tooltip = "在背包上显示背包的总剩余格数！";
fuFrame.BAGkongyu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['zhegnheBAG']['BAGkongyu']="ON";
		gengxinbeibaoshengyugeshu()
		MainMenuBarBackpackButton.yushu:Show()
	else
		PIG['zhegnheBAG']['BAGkongyu']="OFF";
		MainMenuBarBackpackButton.yushu:Hide()
	end
end);
MainMenuBarBackpackButton:HookScript("OnEvent", function(self,event,arg1)
	if PIG['zhegnheBAG']['BAGkongyu']=="ON" then
		if event=="BAG_UPDATE" then
			gengxinbeibaoshengyugeshu()
		end
	end
end);
--加载设置---------------
addonTable.BagBank = function()
	PIG['zhegnheBAG']=PIG['zhegnheBAG'] or addonTable.Default['zhegnheBAG']
	PIG['zhegnheBAG']['BAGkongyu']=PIG['zhegnheBAG']['BAGkongyu'] or addonTable.Default['zhegnheBAG']['BAGkongyu']
	local Pname = UnitFullName("player");
	local _, englishClass= UnitClass("player");
	PIG_renwuming=Pname.."-"..GetRealmName()
	if PIG_renwuming then
		if not PIG['zhegnheBAG']["lixian"][PIG_renwuming] then
			PIG['zhegnheBAG']["lixian"][PIG_renwuming]={["Class"]=englishClass,["C"]={},["BAG"]={},["BANK"]={}}
		end
		if not PIG['zhegnheBAG']["lixian"][PIG_renwuming]["Class"] then
			PIG['zhegnheBAG']["lixian"][PIG_renwuming]["Class"]=englishClass
		end
	end
	if PIG['zhegnheBAG']["Open"]=="ON" then
		fuFrame.beibaozhenghe:SetChecked(true)
		zhegnhe_Open()
		addonTable.qiyongzidongzhengli()
		if PIG['zhegnheBAG']["qitashulaing"] then
			yinhangmorengezishu.qitashuliang=true
		end
	end
	--
	if PIG['zhegnheBAG']['BAGkongyu']=="ON" then
		fuFrame.BAGkongyu:SetChecked(true);
	end
end


-- local ButtonXX = CreateFrame("Button","ButtonXX_UI",UIParent, "UIPanelButtonTemplate");
-- ButtonXX:SetSize(100,29);
-- ButtonXX:SetPoint("CENTER",UIParent,"CENTER",0,-2);
-- ButtonXX:SetText("GetTexture");
-- ButtonXX:SetScript("OnClick", function(self, button)
-- 		-- PIG['zhegnheBAG']["linshiceshi"]={}
-- 		-- local frame = CombuctorInventoryFrame1
-- 		-- local regions = { frame:GetRegions() }
-- 		-- for i=1,#regions do
-- 		-- 	-- print(regions[i]:GetName())
-- 		-- 	-- if regions[i]:GetName() then
-- 		-- 	-- else
-- 		-- 		regions[i]:GetTexture()
-- 		-- 	--end
-- 		-- end
-- 		-- local hh = {TargetFrameToT:GetChildren()} for k,v in pairs(hh) do local rr = {v:GetRegions()} for kk,vv in pairs(rr) do print(kk,vv:GetTexture()) end end
-- 		--local frame = ContainerFrame1BackgroundBottom
-- 		--local frame = CombuctorInventoryFrame1InsetBg
-- 		--local frame = CombuctorInventoryFrame1LeftBorder
-- 		--local frame = CombuctorInventoryFrame1BtnCornerLeft
-- 		--local frame = CombuctorInventoryFrame1BotLeftCorner
-- 		--local frame = CombuctorInventoryFrame1RightBorder
-- 		--local frame = CombuctorInventoryFrame1BottomBorder
-- 		--local frame = CombuctorInventoryFrame1BottomBorder
-- 		-- local Icon = frame:GetTexture()
-- 		-- local zipboap = {frame:GetTexCoord()}
-- 		-- local kuandu =frame:GetWidth()
-- 		-- local gaodu =frame:GetHeight()
-- 		-- local ffxinxi ={Icon,zipboap,kuandu,gaodu}
-- 		-- print(Icon)
-- 		-- for i=1,#zipboap do
-- 		-- 	print(zipboap[i])
-- 		-- end
-- 		-- print(kuandu.."--"..gaodu)
-- 		-- table.insert(PIG['zhegnheBAG']["linshiceshi"],ffxinxi)
-- 		local vvvv = SpellBookNextButton11Icon:GetTexture()
-- 		print(vvvv)
-- end)