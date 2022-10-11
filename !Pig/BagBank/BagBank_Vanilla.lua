local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local fuFrame=List_R_F_2_1
local ADD_Frame=addonTable.ADD_Frame
--==========================================
local yinhangmorengezishu={}
local _, _, _, tocversion = GetBuildInfo()
if tocversion<20000 then
	yinhangmorengezishu={24,6}
else
	yinhangmorengezishu={28,7}
end
yinhangmorengezishu.banknum=yinhangmorengezishu[1]+yinhangmorengezishu[2]*36
----==============
local QualityColor=addonTable.QualityColor
local bagID = {0,1,2,3,4}
bagID.meihang=8
bagID.suofang=1
local bankID = {-1,5,6,7,8,9,10,11}
bankID.meihang=14
bankID.suofang=1
local zhengliIcon="interface/containerframe/bags.blp"	
local BagdangeW=ContainerFrame1Item1:GetWidth()+5
----
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
	frame:SetParent(BAGheji_UI)
	frame:SetToplevel(false)
	frame.PortraitButton:Hide();
	frame.Portrait:Hide();
	local name = frame:GetName();
	_G[name.."BackgroundTop"]:Hide();
	_G[name.."BackgroundMiddle1"]:Hide();
	_G[name.."BackgroundMiddle2"]:Hide();
	_G[name.."BackgroundBottom"]:Hide();
	_G[name.."Background1Slot"]:Hide();
	_G[name.."Name"]:Hide();
	_G[name.."CloseButton"]:Hide();
	if id==0 then
		paishuID,kongbuID=0,0
		_G[name.."MoneyFrame"]:Show()
		_G[name.."MoneyFrame"]:ClearAllPoints();
		_G[name.."MoneyFrame"]:SetPoint("TOPRIGHT", BAGheji_UI.moneyframe, "TOPRIGHT", 6, -5);
		_G[name.."MoneyFrame"]:SetParent(BAGheji_UI);
		local function ADDshowEV(fameFF)
				fameFF:SetScript("OnEnter", function (self)
					GameTooltip:ClearLines();
					GameTooltip:SetOwner(self, "ANCHOR_CURSOR",0,0);
					
					local lixianheji = PIG['zhegnheBAG']["lixian"]
					local lixianhejiNAMEG = {}
					lixianhejiNAMEG.ZIJIg=GetMoney();
					for k,v in pairs(lixianheji) do
						if k~=PIG_renwuming then
							if v["G"] and v["G"]>0 then
								table.insert(lixianhejiNAMEG,{k,v["G"],v["Class"]})
								lixianhejiNAMEG.ZIJIg=lixianhejiNAMEG.ZIJIg+v["G"]
							end
						end
					end
					GameTooltip:AddLine("总计："..GetCoinTextureString(lixianhejiNAMEG.ZIJIg))
					for n=1,#lixianhejiNAMEG do
						local rPerc, gPerc, bPerc, argbHex = GetClassColor(lixianhejiNAMEG[n][3]);
						GameTooltip:AddLine("\124c"..argbHex..lixianhejiNAMEG[n][1].."\124r："..GetCoinTextureString(lixianhejiNAMEG[n][2]))
					end
					GameTooltip:Show();
				end);
				fameFF:SetScript("OnLeave", function ()
					GameTooltip:ClearLines();
					GameTooltip:Hide() 
				end);
		end
		ADDshowEV(_G[name.."MoneyFrame"])
		local monheji = {_G[name.."MoneyFrame"]:GetChildren()}
		for i=1,#monheji do
			if monheji[i]~=ContainerFrame1MoneyFrameTrialErrorButton then
				ADDshowEV(monheji[i])
			end
		end
	else
		_G[name.."MoneyFrame"]:Hide()
	end
	local function jisuanzongshu(id)
		BAGheji_UI.zongshu=0
		if id>0 then	
			local qianzhibag = id
			for i=1,qianzhibag do
				local shangnum = GetContainerNumSlots(i-1)
				BAGheji_UI.zongshu=BAGheji_UI.zongshu+shangnum
			end
		end
		return BAGheji_UI.zongshu
	end
	local function jisuankonmgyu(id,zongshu)
		BAGheji_UI.hangShu,BAGheji_UI.kongyu=0,0
		if id>0 then
			BAGheji_UI.hangShu=math.ceil(zongshu/bagID.meihang)
			BAGheji_UI.kongyu=BAGheji_UI.hangShu*bagID.meihang-zongshu
		end
		return BAGheji_UI.hangShu,BAGheji_UI.kongyu
	end

	local shang_allshu=jisuanzongshu(id)
	local shang_hang,shang_yushu=jisuankonmgyu(id,shang_allshu)
	local NEWsize=size-shang_yushu
	local hangShu=math.ceil(NEWsize/bagID.meihang)
	local new_kongyu,new_hangshu=hangShu*bagID.meihang-NEWsize,hangShu+shang_hang
	local Fid=IsBagOpen(id)
	for slot=1,size do
		local itemF = _G[name.."Item"..slot]
		itemF:ClearAllPoints();
		if slot==1 then
			itemF:SetPoint("TOPRIGHT", BAGheji_UI.wupin, "TOPRIGHT", -(new_kongyu*BagdangeW)-6, -(new_hangshu*BagdangeW)+38);
			_G[name.."PortraitButton"]:ClearAllPoints();
			_G[name.."PortraitButton"]:SetPoint("TOPLEFT", BAGheji_UI, "TOPRIGHT", 0, -(42*id)-60);
		else
			local yushu=math.fmod((slot+new_kongyu-1),bagID.meihang)
			local itemFshang = _G[name.."Item"..(slot-1)]
			if yushu==0 then
				itemF:SetPoint("BOTTOMLEFT", itemFshang, "TOPLEFT", (bagID.meihang-1)*BagdangeW, 5);
			else
				itemF:SetPoint("RIGHT", itemFshang, "LEFT", -5, 0);
			end
		end
	end
	frame:SetHeight(0);
	BAGheji_UI:SetHeight(BagdangeW*new_hangshu+88);
end
---------------------
local qishihang=math.ceil(yinhangmorengezishu[1]/bankID.meihang)--行数
local qishikongyu=qishihang*bankID.meihang-yinhangmorengezishu[1]--空余
local function shuaxinBANKweizhi(frame, size, id)
	frame.PortraitButton:Hide();
	frame.Portrait:Hide();
	local name = frame:GetName();
	_G[name.."MoneyFrame"]:Hide()
	_G[name.."BackgroundTop"]:Hide();
	_G[name.."BackgroundMiddle1"]:Hide();
	_G[name.."BackgroundMiddle2"]:Hide();
	_G[name.."BackgroundBottom"]:Hide();
	_G[name.."Background1Slot"]:Hide();
	_G[name.."Name"]:Hide();
	_G[name.."CloseButton"]:Hide();
	frame:SetHeight(0);
	frame:SetFrameStrata("HIGH")
	local function jisuanzongshu(id)
		if id==5 then
			return yinhangmorengezishu[1]
		else
			yinhangmorengezishu.zongshu=yinhangmorengezishu[1]
			local qianzhibag = id-5
			for i=1,qianzhibag do
				local shangnum = GetContainerNumSlots(i+4)
				yinhangmorengezishu.zongshu=yinhangmorengezishu.zongshu+shangnum
			end
			return yinhangmorengezishu.zongshu
		end
	end
	local function jisuankonmgyu(id,zongshu)
		if id==5 then
			return qishihang,qishikongyu
		else
			local hangShu=math.ceil(zongshu/bankID.meihang)
			local kongyu=hangShu*bankID.meihang-zongshu
			return hangShu,kongyu
		end
	end

	local shang_allshu=jisuanzongshu(id)
	local shang_hang,shang_yushu=jisuankonmgyu(id,shang_allshu)
	local NEWsize=size-shang_yushu
	local hangShu=math.ceil(NEWsize/bankID.meihang)
	local new_kongyu,new_hangshu=hangShu*bankID.meihang-NEWsize,hangShu+shang_hang
	local Fid=IsBagOpen(id)
	for slot=1,size do
		local itemF = _G[name.."Item"..slot]
		itemF:ClearAllPoints();
		if slot==1 then
			itemF:SetPoint("TOPRIGHT", BankSlotsFrame, "TOPRIGHT", -new_kongyu*BagdangeW-14, -new_hangshu*BagdangeW-38);
			_G[name.."PortraitButton"]:ClearAllPoints();
			_G[name.."PortraitButton"]:SetPoint("TOPLEFT", BankFrameP_UI, "TOPRIGHT", 0, -(42*(id-4))-18);
		else
			local yushu=math.fmod((slot+new_kongyu-1),bankID.meihang)
			local itemFshang = _G[name.."Item"..(slot-1)]
			if yushu==0 then
				itemF:SetPoint("BOTTOMLEFT", itemFshang, "TOPLEFT", (bankID.meihang-1)*BagdangeW, 4);
			else
				itemF:SetPoint("RIGHT", itemFshang, "LEFT", -5, 0);
			end
		end
	end
	local ZONGGEZI=GetContainerNumSlots(5)+GetContainerNumSlots(6)+GetContainerNumSlots(7)+GetContainerNumSlots(8)+GetContainerNumSlots(9)+GetContainerNumSlots(10)+GetContainerNumSlots(11)+yinhangmorengezishu[1]
	local hangShuALL=math.ceil(ZONGGEZI/bankID.meihang)
	local gaoduvvv=hangShuALL*BagdangeW+96
	BankFrame:SetHeight(gaoduvvv);
	BankFrameP_UI:SetHeight(gaoduvvv);
end
-------------------
local function zhegnheBANK_Open()
	BankFrameP_UI.biaoti.t:SetText();
	for i=1,yinhangmorengezishu.banknum do
		_G["BankFrameP_UI_wupin_item_"..i]:Hide();
	end
	local BKregions = {BankFrame:GetRegions()}
	for i=1,#BKregions do
		if not BKregions[i]:GetName() then
			BKregions[i]:Hide()
		end
	end
	local BKregions0 = {BankSlotsFrame:GetRegions()}
	for i=1,#BKregions0 do
		BKregions0[i]:SetAlpha(0)
	end
	local BKregions1 = {BankFramePurchaseInfo:GetRegions()}
	for i=1,#BKregions1 do
		BKregions1[i]:Hide()
	end
	for i=1,yinhangmorengezishu[2] do
		BankSlotsFrame["Bag"..i]:SetScale(0.76);
		BankSlotsFrame["Bag"..i]:ClearAllPoints();
		if i==1 then
			BankSlotsFrame["Bag"..i]:SetPoint("TOPLEFT", BankFrameItem1, "BOTTOMLEFT", 80, 100);
		else
			BankSlotsFrame["Bag"..i]:SetPoint("LEFT", BankSlotsFrame["Bag"..(i-1)], "RIGHT", 0, 0);
		end
	end
	for i = 1, yinhangmorengezishu[1] do
		_G["BankFrameItem"..i]:ClearAllPoints();
		if i==1 then
			_G["BankFrameItem"..i]:SetPoint("TOPLEFT", BankSlotsFrame, "TOPLEFT", 20, -76);
		else
			local yushu=math.fmod(i-1,bankID.meihang)
			if yushu==0 then
				_G["BankFrameItem"..i]:SetPoint("TOPLEFT", _G["BankFrameItem"..(i-bankID.meihang)], "BOTTOMLEFT", 0, -4);
			else
				_G["BankFrameItem"..i]:SetPoint("LEFT", _G["BankFrameItem"..(i-1)], "RIGHT", 5, 0);
			end
		end
	end
	BankFrameTitleText:ClearAllPoints();
	BankFrameTitleText:SetPoint("TOP", BankFrame, "TOP", 0, -15);
	BankFramePurchaseButton:SetWidth(90)
	BankFramePurchaseButton:ClearAllPoints();
	BankFramePurchaseButton:SetPoint("TOPLEFT", BankSlotsFrame, "TOPLEFT", 300, -42);
	BankFramePurchaseButtonText:SetPoint("RIGHT", BankFramePurchaseButton, "RIGHT", -8, 0);
	BankFrameDetailMoneyFrame:ClearAllPoints();
	BankFrameDetailMoneyFrame:SetPoint("RIGHT", BankFramePurchaseButtonText, "LEFT", 6, -1);
	BankCloseButton:SetPoint("CENTER", BankFrame, "TOPRIGHT", -16, -24);
	BankFrameMoneyFrame:SetPoint("BOTTOMRIGHT", BankFrame, "BOTTOMRIGHT", -10, -3);
	BankFrame:SetWidth(BagdangeW*bankID.meihang+30)
	local hangShuALL=math.ceil(yinhangmorengezishu[1]/bankID.meihang)
	local gaoduvvv=hangShuALL*BagdangeW+96
	BankFrame:SetHeight(gaoduvvv);
	BankFrameP_UI:SetHeight(gaoduvvv);
end
----保存离线数据-----
local function SAVE_lixian_data(bagID, slot,wupinshujuinfo)
	local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(bagID, slot)
	if itemID then
		local wupinxinxi={itemID,itemLink,itemCount,0,false}
		local itemName,itemLink,itemQuality,itemLevel,itemMinLevel,itemType,itemSubType,itemStackCount,itemEquipLoc,itemTexture,sellPrice,classID = GetItemInfo(itemID);
		wupinxinxi[4]=itemStackCount
		if classID==2 or classID==4 then
			wupinxinxi[5]=true
		end
		table.insert(wupinshujuinfo, wupinxinxi);
	end
end
local function SAVE_C()
	local wupinshujuinfo = {}
	for inv = 1, 19 do
		local wupinxinxi={nil,nil,1}--1物品ID/2itemLink/3数量
		local itemID=GetInventoryItemID("player", inv)
		if itemID then
			wupinxinxi[1]=itemID
			local itemLink = GetInventoryItemLink("player", inv)
			wupinxinxi[2] = itemLink
		end	
		table.insert(wupinshujuinfo, wupinxinxi);
	end
	PIG['zhegnheBAG']["lixian"][PIG_renwuming]["C"] = wupinshujuinfo
end
local function SAVE_BAG()
	local wupinshujuinfo = {}
	for f=1,#bagID do
		for ff=1,GetContainerNumSlots(bagID[f]) do
			SAVE_lixian_data(bagID[f], ff,wupinshujuinfo)
		end
	end
	PIG['zhegnheBAG']["lixian"][PIG_renwuming]["BAG"] = wupinshujuinfo
	PIG['zhegnheBAG']["lixian"][PIG_renwuming]["G"] = GetMoney();
end
local function SAVE_bank()
	local wupinshujuinfo = {}
	for f=1,#bankID do
		if f==1 then
			wupinshujuinfo.allnum=yinhangmorengezishu[1]
		else
			wupinshujuinfo.allnum=GetContainerNumSlots(bankID[f])
		end
		for ff=1,wupinshujuinfo.allnum do
			SAVE_lixian_data(bankID[f], ff,wupinshujuinfo)
		end
	end
	PIG['zhegnheBAG']["lixian"][PIG_renwuming]["BANK"] = wupinshujuinfo
end
--离线显示
local function Show_lixian_data(frameF,renwu,shuju,meihang,zongshu)
	if shuju=="BANK" then
		frameF.Portrait_TEX:SetTexture(130899)
		frameF.biaoti.t:SetText(renwu..' 的银行');
	elseif shuju=="BAG" then
		frameF.biaoti.t:SetText(renwu.." 的背包");
	elseif shuju=="C" then
		frameF.biaoti.t:SetText(renwu);
	end
	local framename=frameF:GetName()
	if PIG['zhegnheBAG']["wupinLV"] then
		for i=1,zongshu do
			local frameX=_G[framename.."_wupin_item_"..i]
			frameX:Hide();
			frameX.LV:SetText()
		end
	end
	local zongshu=#PIG['zhegnheBAG']["lixian"][renwu][shuju]
	for i=1,zongshu do
		local frameX=_G[framename.."_wupin_item_"..i]
		frameX:Show();
		local itemLink = PIG['zhegnheBAG']["lixian"][renwu][shuju][i][2]
		if itemLink then
			local icon = GetItemIcon(itemLink)
			frameX:SetNormalTexture(icon)
			frameX:SetScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				GameTooltip:SetHyperlink(itemLink)
				GameTooltip:Show();
			end);
			frameX:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			frameX:SetScript("OnMouseUp", function ()
				if IsShiftKeyDown() then
					local editBox = ChatEdit_ChooseBoxForSend();
					local hasText = editBox:GetText()..itemLink
					if editBox:HasFocus() then
						editBox:SetText(hasText);
					else
						ChatEdit_ActivateChat(editBox)
						editBox:SetText(hasText);
					end
				end
			end);
			if shuju~="C" then
				local MaxCount = PIG['zhegnheBAG']["lixian"][renwu][shuju][i][4]
				if MaxCount>1 then
					frameX.shuliang:SetText(PIG['zhegnheBAG']["lixian"][renwu][shuju][i][3])
				end
				if PIG['zhegnheBAG']["wupinLV"] then
					local ShowLV = PIG['zhegnheBAG']["lixian"][renwu][shuju][i][5]
					if ShowLV then
						local effectiveILvl = GetDetailedItemLevelInfo(itemLink)	
						if effectiveILvl and effectiveILvl>0 then
							frameX.LV:SetText(effectiveILvl)
							local itemQuality = C_Item.GetItemQualityByID(itemLink)
							frameX.LV:SetTextColor(QualityColor[itemQuality][1],QualityColor[itemQuality][2],QualityColor[itemQuality][3], 1);
						end
					end
				end
			else
				if PIG['ShowPlus']['zhuangbeiLV']=="ON" then
					local effectiveILvl = GetDetailedItemLevelInfo(itemLink)
					if effectiveILvl and effectiveILvl>0 then
						frameX.LV:SetText(effectiveILvl)
						local itemQuality = C_Item.GetItemQualityByID(itemLink)
						frameX.LV:SetTextColor(QualityColor[itemQuality][1],QualityColor[itemQuality][2],QualityColor[itemQuality][3], 1);
					end
				end
			end
		end
	end
	if shuju~="C" then
		local zongkuandu=meihang*BagdangeW+16
		if shuju=="BANK" then
			frameF.hhhh=math.ceil(zongshu/meihang)*(BagdangeW+2)+84
			frameF:SetSize(zongkuandu,frameF.hhhh)
			frameF.Close:Show()
		elseif shuju=="BAG" then
			frameF.hhhh=math.ceil(zongshu/meihang)*(BagdangeW+2)+84
			frameF:SetSize(zongkuandu,frameF.hhhh)
		end
	end
	frameF:Show()
end

--刷新背包LV
local function shuaxin_LV(framef, id, slot)
	framef.ZLV:SetText();
	local itemLink = GetContainerItemLink(id, slot)
	if itemLink then
		local _,_,itemQuality,_,_,_,_,_,_,_,_,classID = GetItemInfo(itemLink);
		if itemQuality then
			if classID==2 or classID==4 then
				local effectiveILvl = GetDetailedItemLevelInfo(itemLink)
				framef.ZLV:SetText(effectiveILvl);
				framef.ZLV:SetTextColor(QualityColor[itemQuality][1],QualityColor[itemQuality][2],QualityColor[itemQuality][3], 1);
			end
		end
	end
end
local function Bag_Item_lv(frame, size, id)
	if id==-2 then return end
	if frame and size then
		local fujiFF=frame:GetName()
		for slot =1, size do
			local framef = _G[fujiFF.."Item"..size+1-slot]
			shuaxin_LV(framef, id, slot)
		end
	else
		local Fid=IsBagOpen(id)
		if Fid then
			local baogeshu=GetContainerNumSlots(id)
			for slot =1, baogeshu do
				local framef = _G["ContainerFrame"..Fid.."Item"..baogeshu+1-slot]
				shuaxin_LV(framef, id, slot)
			end
		end
	end
end
--银行默认格子LV
local function shuaxinyinhangMOREN(arg1)
	if arg1>yinhangmorengezishu[1] then return end
	local framef=_G["BankFrameItem"..arg1];
	shuaxin_LV(framef, -1, arg1)
end
--银行默认格子染色
local function shuaxin_ranse(framef,id,slot)
	framef.ranse:Hide()
	local itemLink = GetContainerItemLink(id, slot)
	if itemLink then
		local _,_,itemQuality,_,_,_,_,_,_,_,_,classID = GetItemInfo(itemLink);
		if itemQuality and itemQuality>1 then
			if classID==2 or classID==4 then
           		local r, g, b = GetItemQualityColor(itemQuality);
	            framef.ranse:SetVertexColor(r, g, b);
				framef.ranse:Show()
			end
		end
	end
end
local function shuaxinyinhangMOREN_ranse(arg1)
	if arg1>yinhangmorengezishu[1] then return end
	local framef=_G["BankFrameItem"..arg1];
	shuaxin_ranse(framef, -1, arg1)
end
--刷新背包染色
local function Bag_Item_Ranse(frame, size, id)
	if id==-2 then return end
	if frame and size then
		local fujiFF=frame:GetName()
		for slot =1, size do
			local framef=_G[fujiFF.."Item"..size+1-slot]
			shuaxin_ranse(framef,id,slot)
		end
	else
		local Fid=IsBagOpen(id)
		if Fid then
			local baogeshu=GetContainerNumSlots(id)
			for slot =1, baogeshu do
				local framef=_G["ContainerFrame"..Fid.."Item"..baogeshu+1-slot];
				shuaxin_ranse(framef,id,slot)
			end
		end
	end
end
--刷新背包垃圾物品提示----------
local function shuaxin_Junk(framef,id,slot)
	framef:Hide();
	local _,_,_, quality = GetContainerItemInfo(id,slot)
	if quality and quality==0 then
		framef:Show();
	end
end
local function Bag_Item_Junk(frame, size, id)
	if id==-2 then return end
	if frame and size then
		local fujiFF=frame:GetName()
		for slot =1, size do
			local framef = _G[fujiFF.."Item"..size+1-slot].JunkIcon
			shuaxin_Junk(framef,id, slot)
		end
	else
		local Fid=IsBagOpen(id)
		if Fid then
			local baogeshu=GetContainerNumSlots(id)
			for slot =1, baogeshu do
				local framef = _G["ContainerFrame"..Fid.."Item"..baogeshu+1-slot].JunkIcon
				shuaxin_Junk(framef,id, slot)
			end
		end
	end
end
--其他角色数量
GameTooltip:HookScript("OnTooltipSetItem", function(self)
	if not yinhangmorengezishu.qitashuliang then return end
	local _, link = self:GetItem()
	if link then
		local itemID = GetItemInfoInstant(link)
		if itemID==6948 then return end
		local renwuWupinshu={}
		local renwuWupinINFO=PIG['zhegnheBAG']["lixian"]
		for k,v in pairs(renwuWupinINFO) do
			local Czongshu=#renwuWupinINFO[k]["C"]
			renwuWupinshu.Cshuliang=0
			for x=1,Czongshu do
				if itemID==renwuWupinINFO[k]["C"][x][1] then
					renwuWupinshu.Cshuliang=renwuWupinshu.Cshuliang+renwuWupinINFO[k]["C"][x][3]
				end
			end
			---
			local BAGzongshu=#renwuWupinINFO[k]["BAG"]
			renwuWupinshu.BAGshuliang=0
			for x=1,BAGzongshu do
				if itemID==renwuWupinINFO[k]["BAG"][x][1] then
					renwuWupinshu.BAGshuliang=renwuWupinshu.BAGshuliang+renwuWupinINFO[k]["BAG"][x][3]
				end
			end
			---
			local BANKzongshu=#renwuWupinINFO[k]["BANK"]
			renwuWupinshu.BANKshuliang=0
			for x=1,BANKzongshu do
				if itemID==renwuWupinINFO[k]["BANK"][x][1] then
					renwuWupinshu.BANKshuliang=renwuWupinshu.BANKshuliang+renwuWupinINFO[k]["BANK"][x][3]
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
	if BAGheji_UI then return end
	if PIG['zhegnheBAG']["wupinLV"] then
		--背包
		for bagui = 1, 13 do
			for slot = 1, 36 do
				local famrr=_G["ContainerFrame"..bagui.."Item"..slot]
				if famrr.ZLV then return end
				famrr.ZLV = famrr:CreateFontString();
				famrr.ZLV:SetPoint("TOPRIGHT", famrr, "TOPRIGHT", -1, -1);
				famrr.ZLV:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
				famrr.ZLV:SetDrawLayer("OVERLAY", 7)
			end
		end
		--银行默认格子
		for i = 1, yinhangmorengezishu[1] do
			local famrr=_G["BankFrameItem"..i]
			if famrr.ZLV then return end
			famrr.ZLV = famrr:CreateFontString();
			famrr.ZLV:SetPoint("TOPRIGHT", famrr, "TOPRIGHT", -1, -1);
			famrr.ZLV:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
			famrr.ZLV:SetDrawLayer("OVERLAY", 7)
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
	local BAGheji=ADD_Frame("BAGheji_UI",UIParent,BagdangeW*bagID.meihang+28,200,"CENTER",UIParent,"CENTER",420,-10,true,false,true,true,true)
	BAGheji:SetScale(bagID.suofang)
	BAGheji:SetToplevel(true)
	BAGheji:HookScript("OnHide",function()
		CloseBag(0);CloseBag(1);CloseBag(2);CloseBag(3);CloseBag(4);
	end)
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
		BAGheji.Bg:SetPoint("TOPLEFT", BAGheji, "TOPLEFT",4, -2);
		BAGheji.Bg:SetPoint("BOTTOMRIGHT", BAGheji, "BOTTOMRIGHT", -2, 6);
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
	end)
	BAGheji.biaoti:SetScript("OnDragStop",function()
	    BAGheji:StopMovingOrSizing()
	end)
	BAGheji.biaoti.t = BAGheji.biaoti:CreateFontString();
	BAGheji.biaoti.t:SetPoint("CENTER", BAGheji.biaoti, "CENTER", 4, -1);
	BAGheji.biaoti.t:SetFontObject(GameFontNormal);
	BAGheji.biaoti.t:SetText(PIG_renwuming);

	BAGheji.Close = CreateFrame("Button",nil,BAGheji, "UIPanelCloseButton");
	BAGheji.Close:SetSize(30,30);
	BAGheji.Close:SetPoint("TOPRIGHT",BAGheji,"TOPRIGHT",3,3);
	BAGheji.Close:HookScript("OnClick",  function (self)
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
				Show_lixian_data(BankFrameP_UI,PIG_renwuming,"BANK",bankID.meihang,yinhangmorengezishu.banknum)
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
								Show_lixian_data(BankFrameP_UI,arg1,"BANK",bankID.meihang,yinhangmorengezishu.banknum)
							elseif arg2=="C" then
								Show_lixian_data(juesezhuangbei_UI,arg1,"C",nil,19)
							elseif arg2=="BAG" then
								Show_lixian_data(lixianBAG_UI,arg1,"BAG",bagID.meihang,164)
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
	local caihemeihang =10
	local BAG_shezhi = {"垃圾物品提示","显示装备等级","装备品质染色","其他角色数量","交易时打开背包","打开拍卖行时打开背包","简洁风格","战利品放入左边包","反向整理"}
	local peizhiV = {
		PIG['zhegnheBAG']["JunkShow"],PIG['zhegnheBAG']["wupinLV"],PIG['zhegnheBAG']["wupinRanse"],PIG['zhegnheBAG']["qitashulaing"],
		PIG['zhegnheBAG']["jiaoyiOpen"],PIG['zhegnheBAG']["AHOpen"],PIG['zhegnheBAG']["JianjieMOD"],GetInsertItemsLeftToRight(),PIG['zhegnheBAG']["SortBag_Config"]
	}
	BAGheji.biaoti.shezhi.F = CreateFrame("Frame", nil, BAGheji.biaoti.shezhi,"BackdropTemplate");
	BAGheji.biaoti.shezhi.F:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8,insets = { left = 1, right = 1, top = 1, bottom = 1 }} );
	BAGheji.biaoti.shezhi.F:SetBackdropBorderColor(1, 1, 1, 0.6);
	if #BAG_shezhi>caihemeihang then
		BAGheji.biaoti.shezhi.F:SetSize(400,caihemeihang*36+70);
	else
		BAGheji.biaoti.shezhi.F:SetSize(260,#BAG_shezhi*36+70);
	end
	BAGheji.biaoti.shezhi.F:SetPoint("CENTER",UIParent,"CENTER",0,0);
	BAGheji.biaoti.shezhi.F:Hide()
	BAGheji.biaoti.shezhi.F:SetIgnoreParentScale(true)
	BAGheji.biaoti.shezhi.F:SetScale(0.9)
	BAGheji.biaoti.shezhi.F:SetFrameStrata("HIGH")
	BAGheji.biaoti.shezhi.F.COS = CreateFrame("Button",nil,BAGheji.biaoti.shezhi.F,"UIPanelCloseButton");
	BAGheji.biaoti.shezhi.F.COS:SetSize(28,28);
	BAGheji.biaoti.shezhi.F.COS:SetPoint("TOPRIGHT",BAGheji.biaoti.shezhi.F,"TOPRIGHT",0,0);
	hooksecurefunc("TradeFrame_OnShow", function(self)
		if PIG['zhegnheBAG']["jiaoyiOpen"] then
			if(UnitExists("NPC"))then
				OpenAllBags()
			end
		end
	end);

	for i=1,#BAG_shezhi do
		BAGheji.biaoti.shezhi.F.CKB = CreateFrame("CheckButton","BAG_shezhi_CKB_"..i, BAGheji.biaoti.shezhi.F, "ChatConfigCheckButtonTemplate");
		BAGheji.biaoti.shezhi.F.CKB:SetSize(28,28);
		BAGheji.biaoti.shezhi.F.CKB:SetHitRectInsets(0,-100,0,0);
		BAGheji.biaoti.shezhi.F.CKB.Text:SetText(BAG_shezhi[i]);
		BAGheji.biaoti.shezhi.F.CKB.tooltip = "勾选将开启"..BAG_shezhi[i];
		if BAG_shezhi[i]=="简洁风格" or BAG_shezhi[i]=="显示装备等级" or BAG_shezhi[i]=="装备品质染色" or BAG_shezhi[i]=="垃圾物品提示" then
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
		elseif i==caihemeihang+1 then
			BAGheji.biaoti.shezhi.F.CKB:SetPoint("LEFT", BAG_shezhi_CKB_1, "RIGHT", 150, 0);
		else
			BAGheji.biaoti.shezhi.F.CKB:SetPoint("TOPLEFT", _G["BAG_shezhi_CKB_"..(i-1)], "BOTTOMLEFT", 0, -8);
		end
		if i==#BAG_shezhi then
			if peizhiV[i]==false then _G["BAG_shezhi_CKB_"..i]:SetChecked(true) end
		else
			if peizhiV[i] then _G["BAG_shezhi_CKB_"..i]:SetChecked(true) end
		end

		BAGheji.biaoti.shezhi.F.CKB:SetScript("OnClick", function (self)
			if self:GetChecked() then
				if BAG_shezhi[i]=="垃圾物品提示" then
					PIG['zhegnheBAG']["JunkShow"]=true
					self.CZUI:Show();
				elseif BAG_shezhi[i]=="显示装备等级" then
					PIG['zhegnheBAG']["wupinLV"]=true
					self.CZUI:Show();
				elseif BAG_shezhi[i]=="装备品质染色" then
					PIG['zhegnheBAG']["wupinRanse"]=true
					self.CZUI:Show();
				elseif BAG_shezhi[i]=="其他角色数量" then
					PIG['zhegnheBAG']["qitashulaing"]=true
					yinhangmorengezishu.qitashuliang=true
				elseif BAG_shezhi[i]=="交易时打开背包" then
					PIG['zhegnheBAG']["jiaoyiOpen"]=true
				elseif BAG_shezhi[i]=="打开拍卖行时打开背包" then
					BAGheji_UI:RegisterEvent("AUCTION_HOUSE_SHOW")
					PIG['zhegnheBAG']["AHOpen"]=true
				elseif BAG_shezhi[i]=="简洁风格" then
					PIG['zhegnheBAG']["JianjieMOD"]=true
					self.CZUI:Show();
				elseif BAG_shezhi[i]=="战利品放入左边包" then
					SetInsertItemsLeftToRight(true)				
				elseif BAG_shezhi[i]=="反向整理" then
					PIG['zhegnheBAG']["SortBag_Config"]=false
					SetSortBagsRightToLeft(false)
				end
			else
				if BAG_shezhi[i]=="垃圾物品提示" then
					PIG['zhegnheBAG']["JunkShow"]=false
					self.CZUI:Show();
				elseif BAG_shezhi[i]=="显示装备等级" then
					PIG['zhegnheBAG']["wupinLV"]=false
					self.CZUI:Show();
				elseif BAG_shezhi[i]=="装备品质染色" then
					PIG['zhegnheBAG']["wupinRanse"]=false
					self.CZUI:Show();
				elseif BAG_shezhi[i]=="其他角色数量" then
					PIG['zhegnheBAG']["qitashulaing"]=false
					yinhangmorengezishu.qitashuliang=false
				elseif BAG_shezhi[i]=="交易时打开背包" then
					PIG['zhegnheBAG']["jiaoyiOpen"]=false
				elseif BAG_shezhi[i]=="打开拍卖行时打开背包" then
					BAGheji_UI:UnregisterEvent("AUCTION_HOUSE_SHOW")
					PIG['zhegnheBAG']["AHOpen"]=false
				elseif BAG_shezhi[i]=="简洁风格" then
					PIG['zhegnheBAG']["JianjieMOD"]=false
					self.CZUI:Show();
				elseif BAG_shezhi[i]=="战利品放入左边包" then
					SetInsertItemsLeftToRight(false)				
				elseif BAG_shezhi[i]=="反向整理" then
					PIG['zhegnheBAG']["SortBag_Config"]=true
					SetSortBagsRightToLeft(true)
				end
			end
		end);
	end
	--每行格数
	BAGheji.biaoti.shezhi.F.hangNUMTXT = BAGheji.biaoti.shezhi.F:CreateFontString();
	BAGheji.biaoti.shezhi.F.hangNUMTXT:SetPoint("BOTTOMLEFT",BAGheji.biaoti.shezhi.F,"BOTTOMLEFT",10,50);
	BAGheji.biaoti.shezhi.F.hangNUMTXT:SetFontObject(GameFontNormal);
	BAGheji.biaoti.shezhi.F.hangNUMTXT:SetText("每行格数");
	local BagmeihangN = {8,10,12,14,16};
	BAGheji.biaoti.shezhi.F.hangNUM = CreateFrame("FRAME",nil, BAGheji.biaoti.shezhi.F, "UIDropDownMenuTemplate")
	BAGheji.biaoti.shezhi.F.hangNUM:SetPoint("LEFT",BAGheji.biaoti.shezhi.F.hangNUMTXT,"RIGHT",-16,-4)
	UIDropDownMenu_SetWidth(BAGheji.biaoti.shezhi.F.hangNUM, 60)
	UIDropDownMenu_Initialize(BAGheji.biaoti.shezhi.F.hangNUM, function(self)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		for i=1,#BagmeihangN,1 do
		    info.text, info.arg1, info.checked = BagmeihangN[i], BagmeihangN[i], BagmeihangN[i] == bagID.meihang;
			UIDropDownMenu_AddButton(info)
		end 
	end)
	function BAGheji.biaoti.shezhi.F.hangNUM:SetValue(newValue)
		UIDropDownMenu_SetText(BAGheji.biaoti.shezhi.F.hangNUM, newValue)
		PIG['zhegnheBAG']["BAGmeihangshu"] = newValue;
		bagID.meihang = newValue;
		CloseDropDownMenus()
		for id=0,4 do
			local Fid=IsBagOpen(id)
			local frame = _G["ContainerFrame"..Fid]
			local size = GetContainerNumSlots(id)
			shuaxinBAGweizhi(frame, size, id)
		end
		BAGheji_UI:SetWidth(BagdangeW*bagID.meihang+28);
	end
	UIDropDownMenu_SetText(BAGheji.biaoti.shezhi.F.hangNUM, bagID.meihang)
	--缩放
	BAGheji.biaoti.shezhi.F.suofangTXT = BAGheji.biaoti.shezhi.F:CreateFontString();
	BAGheji.biaoti.shezhi.F.suofangTXT:SetPoint("TOPLEFT",BAGheji.biaoti.shezhi.F.hangNUMTXT,"BOTTOMLEFT",0,-14);
	BAGheji.biaoti.shezhi.F.suofangTXT:SetFontObject(GameFontNormal);
	BAGheji.biaoti.shezhi.F.suofangTXT:SetText("缩放比例");
	local BAGsuofangbili = {0.6,0.7,0.8,0.9,1,1.1,1.2,1.3,1.4};
	BAGheji.biaoti.shezhi.F.suofang = CreateFrame("FRAME",nil, BAGheji.biaoti.shezhi.F, "UIDropDownMenuTemplate")
	BAGheji.biaoti.shezhi.F.suofang:SetPoint("LEFT",BAGheji.biaoti.shezhi.F.suofangTXT,"RIGHT",-16,-4)
	UIDropDownMenu_SetWidth(BAGheji.biaoti.shezhi.F.suofang, 60)
	UIDropDownMenu_Initialize(BAGheji.biaoti.shezhi.F.suofang, function(self)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		for i=1,#BAGsuofangbili,1 do
		    info.text, info.arg1, info.checked = BAGsuofangbili[i], BAGsuofangbili[i], BAGsuofangbili[i] == bagID.suofang;
			UIDropDownMenu_AddButton(info)
		end 
	end)
	function BAGheji.biaoti.shezhi.F.suofang:SetValue(newValue)
		UIDropDownMenu_SetText(BAGheji.biaoti.shezhi.F.suofang, newValue)
		PIG['zhegnheBAG']["BAGsuofangshu_suofang"] = newValue;
		bagID.suofang = newValue;
		CloseDropDownMenus()
		BAGheji_UI:SetScale(newValue)
	end
	UIDropDownMenu_SetText(BAGheji.biaoti.shezhi.F.suofang, bagID.suofang)
	--设置按钮
	BAGheji.biaoti.shezhi:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1,-1);
	end);
	BAGheji.biaoti.shezhi:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	BAGheji.biaoti.shezhi:SetScript("OnClick", function (self)
		if self.F:IsShown() then
			self.F:Hide()
		else
			self.F:Show()
		end
	end);

	BAGheji.biaoti.shezhi.F.CZpeizhi = CreateFrame("Button",nil,BAGheji.biaoti.shezhi.F, "UIPanelButtonTemplate");
	BAGheji.biaoti.shezhi.F.CZpeizhi:SetSize(80,20);
	BAGheji.biaoti.shezhi.F.CZpeizhi:SetPoint("BOTTOMRIGHT",BAGheji.biaoti.shezhi.F,"BOTTOMRIGHT",-4,4);
	BAGheji.biaoti.shezhi.F.CZpeizhi:SetText("修复异常");
	BAGheji.biaoti.shezhi.F.CZpeizhi:SetScript("OnClick", function(self, button)
		StaticPopup_Show ("HUIFU_DEFAULT_BEIBAOZHENGHE");
	end)
	StaticPopupDialogs["HUIFU_DEFAULT_BEIBAOZHENGHE"] = {
		text = "此操作将\124cffff0000重置\124r背包整合所有配置，\n需重载界面。确定重置?",
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

	BAGheji.Search = CreateFrame('EditBox', nil, BAGheji, "BagSearchBoxTemplate");
	BAGheji.Search:SetSize(120,24);
	BAGheji.Search:SetPoint("TOPLEFT",BAGheji,"TOPLEFT",76,-28);

	BAGheji.AutoSort = CreateFrame("Button",nil,BAGheji, "TruncatedButtonTemplate");
	BAGheji.AutoSort:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
	BAGheji.AutoSort:SetSize(24,24);
	BAGheji.AutoSort:SetPoint("TOPRIGHT",BAGheji,"TOPRIGHT",-80,-27);
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
	--分类设置
	BAGheji.fenlei = CreateFrame("Button",nil,BAGheji, "TruncatedButtonTemplate");
	BAGheji.fenlei:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	BAGheji.fenlei:SetSize(18,18);
	BAGheji.fenlei:SetPoint("TOPRIGHT",BAGheji,"TOPRIGHT",-10,-30);
	BAGheji.fenlei.Tex = BAGheji.fenlei:CreateTexture(nil, "BORDER");
	BAGheji.fenlei.Tex:SetTexture("interface/chatframe/chatframeexpandarrow.blp");
	BAGheji.fenlei.Tex:SetSize(18,18);
	BAGheji.fenlei.Tex:SetPoint("CENTER",BAGheji.fenlei,"CENTER",2,0);
	BAGheji.fenlei:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",BAGheji.fenlei,"CENTER",3,-1);
	end);
	BAGheji.fenlei:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER",BAGheji.fenlei,"CENTER",2,0);
	end);
	BAGheji.fenlei.show=false
	BAGheji.fenlei:SetScript("OnClick",  function (self)
		if BAGheji.fenlei.show then
			BAGheji.fenlei.show=false
			self.Tex:SetRotation(0, 0.4, 0.5)
			for vb=1,5 do
				_G["ContainerFrame"..vb.."PortraitButton"]:Hide()
			end
		else
			BAGheji.fenlei.show=true
			self.Tex:SetRotation(-3.1415926, 0.4, 0.5)
			local bagicon={
				133633,
				CharacterBag0SlotIconTexture:GetTexture(),
				CharacterBag1SlotIconTexture:GetTexture(),
				CharacterBag2SlotIconTexture:GetTexture(),
				CharacterBag3SlotIconTexture:GetTexture(),
			}
			for vb=1,5 do
				local fameXX = _G["ContainerFrame"..vb.."PortraitButton"]
				fameXX.ICONpig:SetTexture(bagicon[vb]);
				fameXX:Show()
			end
		end
	end);
	for vb=1,5 do
		local fameXX = _G["ContainerFrame"..vb.."PortraitButton"]
		fameXX.ICONpig = fameXX:CreateTexture(nil, "BORDER");
		fameXX.ICONpig:SetTexture();
		fameXX.ICONpig:SetSize(25,25);
		fameXX.ICONpig:SetPoint("TOPLEFT",fameXX,"TOPLEFT",7,-7);
		fameXX.BGpig = fameXX:CreateTexture(nil, "ARTWORK");
		fameXX.BGpig:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
		fameXX.BGpig:SetSize(70,70);
		fameXX.BGpig:SetPoint("TOPLEFT",fameXX,"TOPLEFT",0,0);
		fameXX:SetScript("OnEnter", function (self)
			local fujikj = self:GetParent()
			local hh = {fujikj:GetChildren()} 
			for _,v in pairs(hh) do
				local Vname = v:GetName()
				if Vname then
					local cunzai = Vname:find("Item")
					if cunzai then
						v.BattlepayItemTexture:Show()
					end
				end
			end
		end);
		fameXX:SetScript("OnLeave", function (self)
			local fujikj = self:GetParent()
			local hh = {fujikj:GetChildren()} 
			for _,v in pairs(hh) do
				local Vname = v:GetName()
				if Vname then
					local cunzai = Vname:find("Item")
					if cunzai then
						v.BattlepayItemTexture:Hide()
					end
				end
			end
		end);
	end
	---物品显示区域
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
	local lixianBAG=ADD_Frame("lixianBAG_UI",UIParent,400,200,"CENTER",UIParent,"CENTER",0,100,true,false,true,true,true)
	lixianBAG:SetUserPlaced(false)
	lixianBAG:SetFrameLevel(110)
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
		lixianBAG.wupin.item = CreateFrame("Button", "lixianBAG_UI_wupin_item_"..i, lixianBAG.wupin, "SecureActionButtonTemplate");
		lixianBAG.wupin.item:SetHighlightTexture(130718);
		lixianBAG.wupin.item:SetSize(BagdangeW-4,BagdangeW-4);
		if i==1 then
			lixianBAG.wupin.item:SetPoint("TOPLEFT",lixianBAG.wupin,"TOPLEFT",4,-4);
		else
			local yushu=math.fmod((i-1),bagID.meihang)
			if yushu==0 then
				lixianBAG.wupin.item:SetPoint("TOPLEFT", _G["lixianBAG_UI_wupin_item_"..(i-bagID.meihang)], "BOTTOMLEFT", 0, -2);
			else
				lixianBAG.wupin.item:SetPoint("LEFT", _G["lixianBAG_UI_wupin_item_"..(i-1)], "RIGHT", 2, 0);
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
	local juesezhuangbei=ADD_Frame("juesezhuangbei_UI",UIParent,360,444,"CENTER",UIParent,"CENTER",-100, 100,true,false,true,true,true)
	juesezhuangbei:SetUserPlaced(false)
	juesezhuangbei:SetFrameLevel(130)
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
		juesezhuangbei.item = CreateFrame("Button", "juesezhuangbei_UI_wupin_item_"..zhuangbeishunxuID[i], juesezhuangbei, "SecureActionButtonTemplate");
		juesezhuangbei.item:SetHighlightTexture(130718);
		juesezhuangbei.item:SetSize(BagdangeW-4,BagdangeW-4);
		if i<17 then
			if i==1 then
				juesezhuangbei.item:SetPoint("TOPLEFT",juesezhuangbei,"TOPLEFT",20,-74);
			elseif i==9 then
				juesezhuangbei.item:SetPoint("TOPLEFT",juesezhuangbei,"TOPLEFT",305,-74);
			else
				juesezhuangbei.item:SetPoint("TOP", _G["juesezhuangbei_UI_wupin_item_"..(zhuangbeishunxuID[i-1])], "BOTTOM", 0, -3);
			end
		else
			if i==17 then
				juesezhuangbei.item:SetPoint("TOPLEFT",juesezhuangbei,"TOPLEFT",121,-385);
			else
				juesezhuangbei.item:SetPoint("LEFT", _G["juesezhuangbei_UI_wupin_item_"..(zhuangbeishunxuID[i-1])], "RIGHT", 3, 0);
			end
		end
		juesezhuangbei.item.LV = juesezhuangbei.item:CreateFontString();
		juesezhuangbei.item.LV:SetPoint("TOPRIGHT", juesezhuangbei.item, "TOPRIGHT", 0,-1);
		juesezhuangbei.item.LV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	end
	
	---银行================================
	local BankFrameP=ADD_Frame("BankFrameP_UI",UIParent,bankID.meihang*BagdangeW+16,210,"TOPLEFT", BankFrame, "TOPLEFT", 9, -12,true,false,true,true,true)
	BankFrameP:SetUserPlaced(false)
	BankFrameP:SetFrameLevel(120)
	BankFrameP.Close = CreateFrame("Button",nil,BankFrameP, "UIPanelCloseButton");
	BankFrameP.Close:SetSize(30,30);
	BankFrameP.Close:SetPoint("TOPRIGHT",BankFrameP,"TOPRIGHT",4,3);
	BankFrameP.Close:Hide();
	BankFrameP:HookScript("OnHide",function()
		CloseBankFrame();
	end)

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
	BankFrameP.biaoti = CreateFrame("Frame", nil, BankFrameP)
	BankFrameP.biaoti:SetPoint("TOPLEFT", BankFrameP, "TOPLEFT",58, -1);
	BankFrameP.biaoti:SetPoint("TOPRIGHT", BankFrameP, "TOPRIGHT",-26, -1);
	BankFrameP.biaoti:SetHeight(20);
	BankFrameP.biaoti:EnableMouse(true)
	BankFrameP.biaoti:RegisterForDrag("LeftButton")
	BankFrameP.biaoti.t = BankFrameP.biaoti:CreateFontString();
	BankFrameP.biaoti.t:SetPoint("CENTER", BankFrameP.biaoti, "CENTER", 8, -1);
	BankFrameP.biaoti.t:SetFontObject(GameFontNormal);
	BankFrameP.biaoti.t:SetText('银行');
	BankFrameP.biaoti:SetScript("OnDragStart",function()
	    BankFrameP:StartMoving();
	    BankFrameP:SetUserPlaced(false)
	end)
	BankFrameP.biaoti:SetScript("OnDragStop",function()
	    BankFrameP:StopMovingOrSizing()
	    BankFrameP:SetUserPlaced(false)
	end)

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
	----------
	BankFrameP.wupin = CreateFrame("Frame", nil, BankFrameP,"BackdropTemplate")
	BankFrameP.wupin:SetBackdrop( { bgFile = "interface/framegeneral/ui-background-marble.blp" });
	BankFrameP.wupin:SetPoint("TOPLEFT", BankFrameP, "TOPLEFT",6, -58);
	BankFrameP.wupin:SetPoint("BOTTOMRIGHT", BankFrameP, "BOTTOMRIGHT", -6, 26);
	BankFrameP.wupin:EnableMouse(true)
	for i=1,yinhangmorengezishu.banknum do
		BankFrameP.wupin.item = CreateFrame("Button", "BankFrameP_UI_wupin_item_"..i, BankFrameP.wupin, "SecureActionButtonTemplate");
		BankFrameP.wupin.item:SetHighlightTexture(130718);
		BankFrameP.wupin.item:SetSize(BagdangeW-2,BagdangeW-2);
		if i==1 then
			BankFrameP.wupin.item:SetPoint("TOPLEFT",BankFrameP.wupin,"TOPLEFT",4,0);
		else
			local yushu=math.fmod((i-1),bankID.meihang)
			if yushu==0 then
				BankFrameP.wupin.item:SetPoint("TOPLEFT", _G["BankFrameP_UI_wupin_item_"..(i-bankID.meihang)], "BOTTOMLEFT", 0, -4);
			else
				BankFrameP.wupin.item:SetPoint("LEFT", _G["BankFrameP_UI_wupin_item_"..(i-1)], "RIGHT", 2, 0);
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
	--系统银行UI增加========================
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
	BankFrame.AutoSort = CreateFrame("Button",nil,BankFrame, "TruncatedButtonTemplate");
	BankFrame.AutoSort:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
	BankFrame.AutoSort:SetSize(24,24);
	BankFrame.AutoSort:SetPoint("TOPRIGHT",BankFrame,"TOPRIGHT",-80,-41);
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

	--分类设置
	BankSlotsFrame.fenlei = CreateFrame("Button",nil,BankSlotsFrame, "TruncatedButtonTemplate");
	BankSlotsFrame.fenlei:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	BankSlotsFrame.fenlei:SetSize(18,18);
	BankSlotsFrame.fenlei:SetPoint("TOPRIGHT",BankSlotsFrame,"TOPRIGHT",-12,-44);
	BankSlotsFrame.fenlei.Tex = BankSlotsFrame.fenlei:CreateTexture(nil, "BORDER");
	BankSlotsFrame.fenlei.Tex:SetTexture("interface/chatframe/chatframeexpandarrow.blp");
	BankSlotsFrame.fenlei.Tex:SetSize(18,18);
	BankSlotsFrame.fenlei.Tex:SetPoint("CENTER",BankSlotsFrame.fenlei,"CENTER",2,0);
	BankSlotsFrame.fenlei:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",BankSlotsFrame.fenlei,"CENTER",3,-1);
	end);
	BankSlotsFrame.fenlei:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER",BankSlotsFrame.fenlei,"CENTER",2,0);
	end);
	BankSlotsFrame.fenlei.show=false
	BankSlotsFrame.fenlei:SetScript("OnClick",  function (self)
		if BankSlotsFrame.fenlei.show then
			BankSlotsFrame.fenlei.show=false
			self.Tex:SetRotation(0, 0.4, 0.5)
			for vb=6,yinhangmorengezishu[2]+5 do
				_G["ContainerFrame"..vb.."PortraitButton"]:Hide()
			end
		else
			BankSlotsFrame.fenlei.show=true
			self.Tex:SetRotation(-3.1415926, 0.4, 0.5)
			local bagicon={BankSlotsFrame.Bag1.icon,BankSlotsFrame.Bag2.icon,BankSlotsFrame.Bag3.icon,BankSlotsFrame.Bag4.icon,BankSlotsFrame.Bag5.icon,BankSlotsFrame.Bag6.icon,}
			if tocversion>19999 then
				table.insert(bagicon, BankSlotsFrame.Bag7.icon);
			end
			for vb=6,yinhangmorengezishu[2]+5 do
				local fameXX = _G["ContainerFrame"..vb.."PortraitButton"]
				fameXX.ICONpig:SetTexture(bagicon[vb-5]:GetTexture());
				fameXX:Show()
			end
		end
	end);
	for vb=6,yinhangmorengezishu[2]+5 do
		local fameXX = _G["ContainerFrame"..vb.."PortraitButton"]
		fameXX.ICONpig = fameXX:CreateTexture(nil, "BORDER");
		fameXX.ICONpig:SetTexture();
		fameXX.ICONpig:SetSize(25,25);
		fameXX.ICONpig:SetPoint("TOPLEFT",fameXX,"TOPLEFT",7,-7);
		fameXX.BGpig = fameXX:CreateTexture(nil, "ARTWORK");
		fameXX.BGpig:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
		fameXX.BGpig:SetSize(70,70);
		fameXX.BGpig:SetPoint("TOPLEFT",fameXX,"TOPLEFT",0,0);
		fameXX:SetScript("OnEnter", function (self)
			local fujikj = self:GetParent()
			local hh = {fujikj:GetChildren()} 
			for _,v in pairs(hh) do
				local Vname = v:GetName()
				if Vname then
					local cunzai = Vname:find("Item")
					if cunzai then
						v.BattlepayItemTexture:Show()
					end
				end
			end
		end);
		fameXX:SetScript("OnLeave", function (self)
			local fujikj = self:GetParent()
			local hh = {fujikj:GetChildren()} 
			for _,v in pairs(hh) do
				local Vname = v:GetName()
				if Vname then
					local cunzai = Vname:find("Item")
					if cunzai then
						v.BattlepayItemTexture:Hide()
					end
				end
			end
		end);
	end
	-------
	BankFrame:HookScript("OnShow", function()
		BankFrameP:Show()
	end);
	BankFrame:HookScript("OnHide", function(self)
		BankFrameP:Hide()
		BankFrameP.Close:Hide()
	end);
	BankSlotsFrame:HookScript("OnHide", function(self)
		self.fenlei.show=false
		self.fenlei.Tex:SetRotation(0, 0.4, 0.5)
	end);
	---------------
	BankFrame:RegisterEvent("BAG_UPDATE_DELAYED")
	BankFrame:HookScript("OnEvent", function (self,event,arg1)
		if event=="PLAYERBANKSLOTS_CHANGED" then
			C_Timer.After(0.4,SAVE_bank)
			if PIG['zhegnheBAG']["wupinLV"] then
				shuaxinyinhangMOREN(arg1)
			end
			if PIG['zhegnheBAG']["wupinRanse"] then shuaxinyinhangMOREN_ranse(arg1) end
		end
		if event=="BAG_UPDATE_DELAYED" then
			if BankFrameP_UI:IsShown() then
				OpenBag(5);OpenBag(6);OpenBag(7);OpenBag(8);OpenBag(9);OpenBag(10);OpenBag(11);	
			end
		end
		if event=="BANKFRAME_OPENED" then
			SetPortraitTexture(BAGheji.Portrait_TEX, "player")
			zhegnheBANK_Open()
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
	BAGheji_UI:RegisterEvent("BAG_UPDATE_DELAYED")
	BAGheji_UI:RegisterUnitEvent("UNIT_MODEL_CHANGED","player")
	BAGheji_UI:RegisterUnitEvent("UNIT_PORTRAIT_UPDATE","player")
	BAGheji_UI:HookScript("OnEvent", function(self,event,arg1)
		if event=="AUCTION_HOUSE_SHOW" then
			if(UnitExists("NPC"))then
				OpenAllBags()
			end
		end		
		if event=="BAG_UPDATE_DELAYED" then
			if self:IsShown() then
				CloseBag(1);CloseBag(2);CloseBag(3);CloseBag(4);
				OpenBag(1);OpenBag(2);OpenBag(3);OpenBag(4);
			end
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
				if PIG['zhegnheBAG']["wupinLV"] then Bag_Item_lv(nil, nil, arg1) end
				if PIG['zhegnheBAG']["wupinRanse"] then Bag_Item_Ranse(nil, nil, arg1) end
				if PIG['zhegnheBAG']["JunkShow"] then Bag_Item_Junk(nil, nil, arg1) end
			end
			if BankFrame:IsShown() then
				if arg1>4 then
					C_Timer.After(0.4,SAVE_bank)
					if PIG['zhegnheBAG']["wupinLV"] then Bag_Item_lv(nil, nil, arg1) end
					if PIG['zhegnheBAG']["wupinRanse"] then Bag_Item_Ranse(nil, nil, arg1) end
				end
			end
		end
	end)
	local function zhixingbaocunCMD()
		SAVE_BAG()
		BAGheji_UI:RegisterEvent("BAG_UPDATE")
	end
	--C_Timer.After(6,zhixingbaocunCMD)
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
		if id>=0 and id<5 then
			if PIG['zhegnheBAG']["JunkShow"] then Bag_Item_Junk(frame, size, id) end
		end
	end)
	if tocversion>30000 then
		hooksecurefunc("ManageBackpackTokenFrame", function(backpack)
			BackpackTokenFrame:ClearAllPoints();
			BackpackTokenFrame:SetPoint("TOPRIGHT", BAGheji_UI.moneyframe, "TOPLEFT", 0, 5);
			BackpackTokenFrame:SetParent(BAGheji_UI);
			local regions = { BackpackTokenFrame:GetRegions() }
			for gg=1,#regions do
				regions[gg]:Hide()
				--regions[gg]:SetTexCoord(0.05,0.8,0,0.74);
			end	
		end)
	end
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
	ToggleBackpack= function() --背包按键打开
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
			BAGheji:Show()
		end	
	end
	---系统关闭背包事件追加关闭背景
	hooksecurefunc('CloseBackpack', function()
		BAGheji:Hide()
		BAGheji.fenlei.show=false
		BAGheji.fenlei.Tex:SetRotation(0, 0.4, 0.5)
	end);
end
--==========================================================
fuFrame.beibaozhenghe = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.beibaozhenghe:SetSize(30,30);
fuFrame.beibaozhenghe:SetHitRectInsets(0,-100,0,0);
fuFrame.beibaozhenghe:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
fuFrame.beibaozhenghe.Text:SetText("启用背包/银行整合");
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
local function gengxinbeibaoshengyugeshu()
	MainMenuBarBackpackButton.zongkongyu = 0
	if tocversion<20000 then
		for bag=BACKPACK_CONTAINER, NUM_BAG_SLOTS do 
			local numberOfFreeSlots=GetContainerNumFreeSlots(bag);
			MainMenuBarBackpackButton.zongkongyu=MainMenuBarBackpackButton.zongkongyu+numberOfFreeSlots
		end
		MainMenuBarBackpackButton.Count:SetText(MainMenuBarBackpackButton.zongkongyu); 
	else
		local zongkongyu = MainMenuBarBackpackButton.Count:GetText() or "99"
		local zongkongyu = zongkongyu:gsub("%(","")
		local zongkongyu = zongkongyu:gsub("%)","")
		MainMenuBarBackpackButton.zongkongyu=tonumber(zongkongyu)
	end
	if MainMenuBarBackpackButton.zongkongyu<10 then
		MainMenuBarBackpackButton.Count:SetTextColor(1, 0, 0, 1);
	else
		MainMenuBarBackpackButton.Count:SetTextColor(0, 1, 0, 1);
	end
end
local function bigfontziti()
	MainMenuBarBackpackButton.Count:SetFont(ChatFontNormal:GetFont(), 18, "OUTLINE");
	MainMenuBarBackpackButton.Count:Show();
	gengxinbeibaoshengyugeshu()
end
MainMenuBarBackpackButton:HookScript("OnEvent", function(self,event,arg1)
	if PIG['zhegnheBAG']['BAGkongyu']=="ON" then
		if event=="PLAYER_ENTERING_WORLD" then
			bigfontziti()
		end
		if event=="BAG_UPDATE" then
			gengxinbeibaoshengyugeshu()
		end
	end
end);
----
fuFrame.BAGkongyu = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.BAGkongyu:SetSize(30,30);
fuFrame.BAGkongyu:SetHitRectInsets(0,-100,0,0);
fuFrame.BAGkongyu:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-80);
if tocversion<20000 then
	fuFrame.BAGkongyu.Text:SetText("显示背包剩余空间");
	fuFrame.BAGkongyu.tooltip = "在背包上显示背包的总剩余空间";
else
	fuFrame.BAGkongyu.Text:SetText("增大系统背包剩余空间数字");
	fuFrame.BAGkongyu.tooltip = "增大系统的背包剩余空间数字(大于等于10显示绿色,小于10显示红色)\n|cff00FF00TBC以后的版本系统已自带背包剩余空间显示，请在ESC菜单-界面-显示内打开|r";
end
fuFrame.BAGkongyu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['zhegnheBAG']['BAGkongyu']="ON";
		bigfontziti()
	else
		PIG['zhegnheBAG']['BAGkongyu']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--加载设置---------------
addonTable.BagBank = function()
	PIG['zhegnheBAG']=PIG['zhegnheBAG'] or addonTable.Default['zhegnheBAG']
	PIG['zhegnheBAG']['BAGkongyu']=PIG['zhegnheBAG']['BAGkongyu'] or addonTable.Default['zhegnheBAG']['BAGkongyu']
	PIG['zhegnheBAG']["BAGmeihangshu"]=PIG['zhegnheBAG']["BAGmeihangshu"] or addonTable.Default['zhegnheBAG']["BAGmeihangshu"]
	local Pname = UnitFullName("player");
	local _, englishClass= UnitClass("player");
	PIG_renwuming=Pname.."-"..GetRealmName()
	if PIG_renwuming then
		if not PIG['zhegnheBAG']["lixian"][PIG_renwuming] then
			PIG['zhegnheBAG']["lixian"][PIG_renwuming]={["Class"]=englishClass,["C"]={},["G"]={},["BAG"]={},["BANK"]={}}
		end
		if not PIG['zhegnheBAG']["lixian"][PIG_renwuming]["Class"] then
			PIG['zhegnheBAG']["lixian"][PIG_renwuming]["Class"]=englishClass
		end
	end
	if PIG['zhegnheBAG']["Open"]=="ON" then
		fuFrame.beibaozhenghe:SetChecked(true)
		bagID.meihang=PIG['zhegnheBAG']["BAGmeihangshu"] or bagID.meihang
		bagID.suofang=PIG['zhegnheBAG']["BAGsuofangshu_suofang"] or bagID.suofang
		zhegnhe_Open()
		addonTable.qiyongzidongzhengli()
		if PIG['zhegnheBAG']["qitashulaing"] then
			yinhangmorengezishu.qitashuliang=true
		end
		if PIG['zhegnheBAG']["AHOpen"] then
			BAGheji_UI:RegisterEvent("AUCTION_HOUSE_SHOW")
		end
	end
	if PIG['zhegnheBAG']['BAGkongyu']=="ON" then
		fuFrame.BAGkongyu:SetChecked(true);
		bigfontziti()
	end
end