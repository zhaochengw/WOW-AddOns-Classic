local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local fuFrame=List_R_F_2_1
local ADD_Frame=addonTable.ADD_Frame
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local PIGDownMenu=addonTable.PIGDownMenu
local _, _, _, tocversion = GetBuildInfo()
--==========================================
local yinhangmorengezishu={}
if tocversion<20000 then
	yinhangmorengezishu={24,6}
else
	yinhangmorengezishu={28,7}
end
yinhangmorengezishu.banknum=yinhangmorengezishu[1]+yinhangmorengezishu[2]*36
----==============
local QualityColor=addonTable.QualityColor
local bagID = {0,1,2,3,4}
if tocversion<20000 then
	bagID.meihang=8
else
	bagID.meihang=10
end
bagID.suofang=1
local bankID = {-1,5,6,7,8,9,10,11}
if tocversion<20000 then
	bankID.meihang=14
else
	bankID.meihang=16
end
bankID.suofang=1
local zhengliIcon="interface/containerframe/bags.blp"	
local BagdangeW=ContainerFrame1Item1:GetWidth()+5
----
local function shuaxinKEYweizhi(frame)
	local name = frame:GetName();
	frame.PortraitButton:Hide();
	frame.Portrait:Show();
	_G[name.."CloseButton"]:Show();
	frame:SetParent(UIParent);
	frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -560, 300);
end
local function Update_BAGFrame_WidthHeight(new_hangshu)
	BAGheji_UI:SetWidth(BagdangeW*bagID.meihang+34)
	if new_hangshu then
		BAGheji_UI:SetHeight(BagdangeW*new_hangshu+106);
	end
end
local function shuaxinBAGweizhi(frame, size, id)
	frame:SetHeight(0);
	frame:SetToplevel(false)
	frame:SetParent(BAGheji_UI)
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
		_G[name.."MoneyFrame"]:SetPoint("TOPRIGHT", BAGheji_UI.moneyframe, "TOPRIGHT", 6, -4);
		_G[name.."MoneyFrame"]:SetParent(BAGheji_UI);
		if PIG["zhegnheBAG"]["qitajinbi"] then
			local function ADDshowEV(fameFF)
					fameFF:SetScript("OnEnter", function (self)
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(self, "ANCHOR_CURSOR",0,0);
						
						local lixianheji = PIG["zhegnheBAG"]["lixian"]
						local lixianhejiNAMEG = {}
						lixianhejiNAMEG.ZIJIg=GetMoney();
						for k,v in pairs(lixianheji) do
							if k~=PIG_renwuming then
								if v["G"] and v["G"]>0 then
									table.insert(lixianhejiNAMEG,{k,v["G"],v["ClassN"]})
									lixianhejiNAMEG.ZIJIg=lixianhejiNAMEG.ZIJIg+v["G"]
								end
							end
						end
						GameTooltip:AddLine("总计："..GetCoinTextureString(lixianhejiNAMEG.ZIJIg))
						for n=1,#lixianhejiNAMEG do
							local rPerc, gPerc, bPerc, argbHex = GetClassColor(lixianhejiNAMEG[n][3]);
							local argbHex=argbHex or "ffffffff"
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
	for slot=1,size do
		local itemF = _G[name.."Item"..slot]
		itemF:ClearAllPoints();
		if slot==1 then
			itemF:SetPoint("TOPRIGHT", BAGheji_UI.wupin, "TOPRIGHT", -(new_kongyu*BagdangeW)-5, -(new_hangshu*BagdangeW)+36);
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
	Update_BAGFrame_WidthHeight(new_hangshu)
end
---------------------
local function Update_BankFrame_Height(hangallgao)
	BankFrame:SetWidth(BagdangeW*bankID.meihang+36)
	BankFrame:SetHeight(hangallgao+106);
end
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
	frame:SetToplevel(false)
	frame:SetParent(BankSlotsFrame);
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
	for slot=1,size do
		local itemF = _G[name.."Item"..slot]
		itemF:ClearAllPoints();
		if slot==1 then
			itemF:SetPoint("TOPRIGHT", BankSlotsFrame, "TOPRIGHT", -new_kongyu*BagdangeW-14, -new_hangshu*BagdangeW-34);
			_G[name.."PortraitButton"]:ClearAllPoints();
			_G[name.."PortraitButton"]:SetPoint("TOPLEFT", BankSlotsFrame, "TOPRIGHT", 0, -(42*(id-4))-18);
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
	local gaoduvvv=hangShuALL*BagdangeW
	Update_BankFrame_Height(gaoduvvv)
end
-------------------
local function zhegnheBANK_Open()
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
			_G["BankFrameItem"..i]:SetPoint("TOPLEFT", BankSlotsFrame, "TOPLEFT", 26, -76);
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
	BankCloseButton:SetPoint("CENTER", BankFrame, "TOPRIGHT", -11, -22);
	BankFrameMoneyFrame:SetPoint("BOTTOMRIGHT", BankFrame, "BOTTOMRIGHT", -10, 11);
	local hangShuALL=math.ceil(yinhangmorengezishu[1]/bankID.meihang)
	local gaoduvvv=hangShuALL*BagdangeW
	Update_BankFrame_Height(gaoduvvv)
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
	PIG["zhegnheBAG"]["lixian"][PIG_renwuming]["C"] = wupinshujuinfo
end
local function SAVE_BAG()
	local wupinshujuinfo = {}
	for f=1,#bagID do
		for ff=1,GetContainerNumSlots(bagID[f]) do
			SAVE_lixian_data(bagID[f], ff,wupinshujuinfo)
		end
	end
	PIG["zhegnheBAG"]["lixian"][PIG_renwuming]["BAG"] = wupinshujuinfo
	PIG["zhegnheBAG"]["lixian"][PIG_renwuming]["G"] = GetMoney();
end
local function SAVE_bank()
	if BankFrame:IsShown() then
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
		PIG["zhegnheBAG"]["lixian"][PIG_renwuming]["BANK"] = wupinshujuinfo
	end
end
--离线显示
local function Show_lixian_data(frameF,renwu,shuju,meihang,zongshu)
	if shuju=="BANK" then
		frameF.biaoti.t:SetText(renwu..' 的银行');
	elseif shuju=="BAG" then
		frameF.biaoti.t:SetText(renwu.." 的背包");
	elseif shuju=="C" then
		frameF.biaoti.t:SetText(renwu);
		local zhiye,zhongzu,Lv = strsplit("~", meihang);
		local zhiye,zhongzu,Lv = tonumber(zhiye),tonumber(zhongzu),tonumber(Lv)
		if zhiye>0 and zhongzu>0 and Lv>0 then
			local classInfo = C_CreatureInfo.GetClassInfo(zhiye)
			local raceInfo = C_CreatureInfo.GetRaceInfo(zhongzu)
			frameF.biaoti.t1:SetText("等级"..Lv.." "..raceInfo["raceName"].." "..classInfo["className"]);
		else
			frameF.biaoti.t1:SetText("等级/种族/职业未更新");
		end
	end
	local gogengName=frameF:GetName()
	if PIG["zhegnheBAG"]["wupinLV"] then
		for i=1,zongshu do
			local frameX=_G[gogengName.."_wupin_item_"..i]
			frameX:Hide();
			frameX.LV:SetText()
		end
	end
	local zongshu=#PIG["zhegnheBAG"]["lixian"][renwu][shuju]
	for i=1,zongshu do
		local frameX=_G[gogengName.."_wupin_item_"..i]
		frameX:Show();
		local itemLink = PIG["zhegnheBAG"]["lixian"][renwu][shuju][i][2]
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
				local MaxCount = PIG["zhegnheBAG"]["lixian"][renwu][shuju][i][4]
				if MaxCount>1 then
					frameX.shuliang:SetText(PIG["zhegnheBAG"]["lixian"][renwu][shuju][i][3])
				end
				if PIG["zhegnheBAG"]["wupinLV"] then
					local ShowLV = PIG["zhegnheBAG"]["lixian"][renwu][shuju][i][5]
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
		local zongkuandu=meihang*BagdangeW+32
		frameF.hhhh=math.ceil(zongshu/meihang)*(BagdangeW)+102
		frameF:SetSize(zongkuandu,frameF.hhhh)
		if shuju=="BAG" then
			for gg=2,164 do
				local yushu=math.fmod((gg-1),meihang)
				local framegg = _G["lixianBAG_UI_wupin_item_"..gg]
				framegg:ClearAllPoints();
				if yushu==0 then
					framegg:SetPoint("TOPLEFT", _G["lixianBAG_UI_wupin_item_"..(gg-meihang)], "BOTTOMLEFT", 0, -4);
				else
					framegg:SetPoint("LEFT", _G["lixianBAG_UI_wupin_item_"..(gg-1)], "RIGHT", 4, 0);
				end
			end
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
	if not PIG["zhegnheBAG"]["qitashulaing"] then return end
	local _, link = self:GetItem()
	if link then
		local itemID = GetItemInfoInstant(link)
		if itemID==6948 then return end
		local renwuWupinshu={}
		local renwuWupinINFO=PIG["zhegnheBAG"]["lixian"]
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
				tooltipxianshineirong.argbHex="ffffffff"
				local zhiyeIDhao = renwuWupinINFO[k]["ClassN"] or 0
				if tonumber(zhiyeIDhao)>0 then
					local classInfo = C_CreatureInfo.GetClassInfo(zhiyeIDhao)
					local _, _, _, argbHex = GetClassColor(classInfo["classFile"]);
					tooltipxianshineirong.argbHex=argbHex
				end
				local argbHex=tooltipxianshineirong.argbHex
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
local ADD_BagBankBGtex=addonTable.ADD_BagBankBGtex
--------
local function zhegnhe_Open()
	if BAGheji_UI then return end
	if PIG["zhegnheBAG"]["wupinLV"] then
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
	if PIG["zhegnheBAG"]["wupinRanse"] then
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
	if PIG["zhegnheBAG"]["JunkShow"] then
		for f=1,#bagID do
			local baogeshu=GetContainerNumSlots(bagID[f])
			for slot=1,baogeshu do
				local framef = _G["ContainerFrame"..(bagID[f]+1).."Item"..slot]
				function framef:UpdateJunkItem(quality, noValue)
					self.JunkIcon:Hide();
					local itemLocation = ItemLocation:CreateFromBagAndSlot(self:GetBagID(), self:GetID());
					if C_Item.DoesItemExist(itemLocation) then
						local isJunk = quality == Enum.ItemQuality.Poor and not noValue;
						self.JunkIcon:SetShown(isJunk);
					end
				end
			end
		end
	end
	------
	local BAGheji=ADD_Frame("BAGheji_UI",UIParent,200,200,"CENTER",UIParent,"CENTER",420,-10,true,false,true,true,true)
	BAGheji:SetScale(bagID.suofang)
	BAGheji:SetToplevel(true)
	BAGheji:HookScript("OnHide",function(self)
		CloseBag(0);CloseBag(1);CloseBag(2);CloseBag(3);CloseBag(4);
		self.biaoti.shezhi.F:Hide()
	end)
	--暴雪UI
	if PIG["zhegnheBAG"]["JianjieMOD"] then
		BAGheji:SetBackdrop( {bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 10 ,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }});
		BAGheji:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
		BAGheji.Portrait_TEX = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.Portrait_TEX:SetSize(30,30);
		BAGheji.Portrait_TEX:SetPoint("TOPLEFT",BAGheji,"TOPLEFT",14,-13);
	else	
		BAGheji.Portrait_TEX = BAGheji:CreateTexture(nil, "BORDER");
		BAGheji.Portrait_TEX:SetSize(56,56);
		BAGheji.Portrait_TEX:SetPoint("TOPLEFT",BAGheji,"TOPLEFT",10,-5);
		BAGheji.Portrait_TEX:SetDrawLayer("BORDER", 2)
		ADD_BagBankBGtex(BAGheji,"BAGheji_")
	end
	SetPortraitTexture(BAGheji.Portrait_TEX, "player")
	--------------------------
	BAGheji.biaoti = CreateFrame("Frame", nil, BAGheji)
	BAGheji.biaoti:SetPoint("TOPLEFT", BAGheji, "TOPLEFT",68, -13);
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
	BAGheji.biaoti.t:SetPoint("CENTER", BAGheji.biaoti, "CENTER", 4, 0);
	BAGheji.biaoti.t:SetFontObject(GameFontNormal);
	BAGheji.biaoti.t:SetText(PIG_renwuming);

	BAGheji.Close = CreateFrame("Button",nil,BAGheji, "UIPanelCloseButton");
	BAGheji.Close:SetSize(32,32);
	BAGheji.Close:SetPoint("TOPRIGHT",BAGheji,"TOPRIGHT",4,-5);
	BAGheji.Close:HookScript("OnClick",  function (self)
		CloseAllBags()
	end);

	BAGheji.Portrait = CreateFrame("Frame",nil,BAGheji);
	if PIG["zhegnheBAG"]["JianjieMOD"] then
		BAGheji.Portrait:SetSize(41,41);
		BAGheji.Portrait:SetPoint("CENTER",BAGheji.Portrait_TEX,"CENTER",0,-2);
	else
		BAGheji.Portrait:SetSize(66,66);
		BAGheji.Portrait:SetPoint("CENTER",BAGheji.Portrait_TEX,"CENTER",0,-4);
	end
	BAGheji.Portrait.xiala=PIGDownMenu(nil,{wwgg,hhgg},BAGheji.Portrait,{"TOPLEFT",BAGheji.Portrait, "CENTER", 0,-4},"DJEasyMenu")
	BAGheji.Portrait.xiala.Button:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight");
	BAGheji.Portrait.xiala.Button:HookScript("OnClick",  function (self,button)
		if button=="LeftButton" then
			if BankFrame:IsShown() then return end
			PlaySoundFile(567463, "Master")
			if lixianBank_UI:IsShown() then
				lixianBank_UI:Hide()
			else
				Show_lixian_data(lixianBank_UI,PIG_renwuming,"BANK",bankID.meihang,yinhangmorengezishu.banknum)
			end
		end
	end)
	function BAGheji.Portrait.xiala:PIGDownMenu_Update_But(self, level, menuList)
		local danxuanerjiList = {}
		local KucunName={["C"]="已装备物品",["BAG"]="背包物品",["BANK"]="银行物品"}
		for k,v in pairs(PIG["zhegnheBAG"]["lixian"]) do
			local xiajicaidan={}
			for kk,vv in pairs(KucunName) do
				table.insert(xiajicaidan,{vv,kk,k,v["ClassN"].."~"..v["Race"].."~"..v["Lv"]})
			end
			if k~=PIG_renwuming then
				BAGheji.lixiancunzaiwupin=true
				table.insert(danxuanerjiList,{k,xiajicaidan})
			end
	    end
	    local info = {}
	    if BAGheji.lixiancunzaiwupin then		
			if (level or 1) == 1 then
				for i=1,#danxuanerjiList,1 do
				    info.text= danxuanerjiList[i][1]
				    info.menuList, info.hasArrow = danxuanerjiList[i][2], true
				    BAGheji.Portrait.xiala:PIGDownMenu_AddButton(info)
				end
			else
				local listFrame = _G["PIGDownList"..level];
				for x=1,#menuList,1 do
					info.text = menuList[x][1]
					if menuList[x][2]=="BANK" then
						info.func = function()
							Show_lixian_data(lixianBank_UI,menuList[x][3],"BANK",bankID.meihang,yinhangmorengezishu.banknum)
							PIGCloseDropDownMenus()
						end
					elseif menuList[x][2]=="C" then
						info.func = function()
							Show_lixian_data(lixianC_UI,menuList[x][3],"C",menuList[x][4],19)
							PIGCloseDropDownMenus()
						end
					elseif menuList[x][2]=="BAG" then
						info.func = function()
							Show_lixian_data(lixianBAG_UI,menuList[x][3],"BAG",bagID.meihang,164)
							PIGCloseDropDownMenus()
						end
					end
					BAGheji.Portrait.xiala:PIGDownMenu_AddButton(info,level)
				end
			end
	    else
	    	info.text= "登录一次其他角色可离线查看" 
	    	info.func = function()
				PIGCloseDropDownMenus()
			end
			BAGheji.Portrait.xiala:PIGDownMenu_AddButton(info)
	    end 
	end

	BAGheji.biaoti.shezhi = CreateFrame("Button",nil,BAGheji.biaoti);
	BAGheji.biaoti.shezhi:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	BAGheji.biaoti.shezhi:SetSize(18,18);
	BAGheji.biaoti.shezhi:SetPoint("TOPRIGHT",BAGheji.biaoti,"TOPRIGHT",-8,-1);
	BAGheji.biaoti.shezhi.Tex = BAGheji.biaoti.shezhi:CreateTexture(nil,"OVERLAY");
	BAGheji.biaoti.shezhi.Tex:SetTexture("interface/gossipframe/bindergossipicon.blp");
	BAGheji.biaoti.shezhi.Tex:SetPoint("CENTER", 0, 0);
	BAGheji.biaoti.shezhi.Tex:SetSize(18,18);
	local caihemeihang =10
	local BAG_shezhi = {
		{"交易时打开背包","jiaoyiOpen",false},
		{"拍卖时打开背包","AHOpen",false},
		{"垃圾物品提示","JunkShow",true},
		{"显示装备等级","wupinLV",true},
		{"装备品质染色","wupinRanse",true},
		{"显示其他角色数量","qitashulaing",false},
		{"显示其他角色金币","qitajinbi",true},
		{"简洁风格","JianjieMOD",true},
		{"反向整理","SortBag_Config",false},
		{"战利品放入左边包",GetInsertItemsLeftToRight(),false},
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
		if PIG["zhegnheBAG"]["jiaoyiOpen"] then
			if(UnitExists("NPC"))then
				OpenAllBags()
			end
		end
	end);

	for i=1,#BAG_shezhi do
		BAGheji.biaoti.shezhi.F.CKB = CreateFrame("CheckButton","BAG_shezhi_CKB_"..i, BAGheji.biaoti.shezhi.F, "ChatConfigCheckButtonTemplate");
		BAGheji.biaoti.shezhi.F.CKB:SetSize(28,28);
		BAGheji.biaoti.shezhi.F.CKB:SetHitRectInsets(0,-100,0,0);
		BAGheji.biaoti.shezhi.F.CKB.Text:SetText(BAG_shezhi[i][1]);
		BAGheji.biaoti.shezhi.F.CKB.tooltip = "勾选将开启"..BAG_shezhi[i][1];
		if BAG_shezhi[i][3] then
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
		BAGheji.biaoti.shezhi.F.CKB:SetScript("OnClick", function (self)
			if self:GetChecked() then
				if BAG_shezhi[i][1]=="反向整理" then
					PIG["zhegnheBAG"]["SortBag_Config"]=false
					SetSortBagsRightToLeft(false)
				else
					PIG["zhegnheBAG"][BAG_shezhi[i][2]]=true
				end
				if BAG_shezhi[i][3] then
					self.CZUI:Show();
				end
			else
				if BAG_shezhi[i][1]=="反向整理" then
					PIG["zhegnheBAG"]["SortBag_Config"]=true
					SetSortBagsRightToLeft(true)
				else
					PIG["zhegnheBAG"][BAG_shezhi[i][2]]=false
				end
				if BAG_shezhi[i][3] then
					self.CZUI:Show();
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
	BAGheji.biaoti.shezhi.F.hangNUM=PIGDownMenu(nil,{60,24},BAGheji.biaoti.shezhi.F,{"LEFT",BAGheji.biaoti.shezhi.F.hangNUMTXT,"RIGHT",0,0})
	function BAGheji.biaoti.shezhi.F.hangNUM:PIGDownMenu_Update_But(self)
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#BagmeihangN,1 do
		    info.text, info.arg1 = BagmeihangN[i], BagmeihangN[i]
		    info.checked = BagmeihangN[i]==PIG['zhegnheBAG']["BAGmeihangshu"]
			BAGheji.biaoti.shezhi.F.hangNUM:PIGDownMenu_AddButton(info)
		end 
	end
	function BAGheji.biaoti.shezhi.F.hangNUM:PIGDownMenu_SetValue(value,arg1,arg2)
		BAGheji.biaoti.shezhi.F.hangNUM:PIGDownMenu_SetText(value)
		PIG['zhegnheBAG']["BAGmeihangshu"] = arg1;
		bagID.meihang = arg1;
		for id=0,4 do
			local Fid=IsBagOpen(id)
			if Fid then 
				local frame = _G["ContainerFrame"..Fid]
				local size = GetContainerNumSlots(id)
				shuaxinBAGweizhi(frame, size, id)
			end
		end
		Update_BAGFrame_WidthHeight()
		PIGCloseDropDownMenus()
	end
	--缩放
	BAGheji.biaoti.shezhi.F.suofangTXT = BAGheji.biaoti.shezhi.F:CreateFontString();
	BAGheji.biaoti.shezhi.F.suofangTXT:SetPoint("TOPLEFT",BAGheji.biaoti.shezhi.F.hangNUMTXT,"BOTTOMLEFT",0,-14);
	BAGheji.biaoti.shezhi.F.suofangTXT:SetFontObject(GameFontNormal);
	BAGheji.biaoti.shezhi.F.suofangTXT:SetText("缩放比例");
	local BAGsuofangbili = {0.6,0.7,0.8,0.9,1,1.1,1.2,1.3,1.4};
	BAGheji.biaoti.shezhi.F.suofang=PIGDownMenu(nil,{60,24},BAGheji.biaoti.shezhi.F,{"LEFT",BAGheji.biaoti.shezhi.F.suofangTXT,"RIGHT",0,0})
	function BAGheji.biaoti.shezhi.F.suofang:PIGDownMenu_Update_But(self)
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#BAGsuofangbili,1 do
		    info.text, info.arg1 = BAGsuofangbili[i], BAGsuofangbili[i]
		    info.checked = BAGsuofangbili[i]==PIG["zhegnheBAG"]["BAGsuofangshu_suofang"]
			BAGheji.biaoti.shezhi.F.suofang:PIGDownMenu_AddButton(info)
		end 
	end
	function BAGheji.biaoti.shezhi.F.suofang:PIGDownMenu_SetValue(value,arg1,arg2)
		BAGheji.biaoti.shezhi.F.suofang:PIGDownMenu_SetText(value)
		PIG["zhegnheBAG"]["BAGsuofangshu_suofang"] = arg1;
		bagID.suofang = arg1;
		BAGheji_UI:SetScale(arg1)
		PIGCloseDropDownMenus()
	end
	
	--设置按钮
	BAGheji.biaoti.shezhi.F:SetScript("OnShow", function (self)
		for i=1,#BAG_shezhi do
			if BAG_shezhi[i][1]=="反向整理" then
				if not PIG["zhegnheBAG"][BAG_shezhi[i][2]] then _G["BAG_shezhi_CKB_"..i]:SetChecked(true) end
			else
				if PIG["zhegnheBAG"][BAG_shezhi[i][2]] then _G["BAG_shezhi_CKB_"..i]:SetChecked(true) end
			end
		end
		BAGheji.biaoti.shezhi.F.hangNUM:PIGDownMenu_SetText(bagID.meihang)
		BAGheji.biaoti.shezhi.F.suofang:PIGDownMenu_SetText(bagID.suofang)
	end);
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
			PIG["zhegnheBAG"]=addonTable.Default["zhegnheBAG"]
			PIG["zhegnheBAG"]["Open"]="ON"
			PIG["zhegnheBAG"]["SortBag_Config"]=true
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}

	BAGheji.Search = CreateFrame('EditBox', nil, BAGheji, "BagSearchBoxTemplate");
	BAGheji.Search:SetSize(120,24);
	BAGheji.Search:SetPoint("TOPLEFT",BAGheji,"TOPLEFT",78,-38);

	BAGheji.AutoSort = CreateFrame("Button",nil,BAGheji, "TruncatedButtonTemplate");
	BAGheji.AutoSort:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
	BAGheji.AutoSort:SetSize(24,24);
	BAGheji.AutoSort:SetPoint("TOPRIGHT",BAGheji,"TOPRIGHT",-80,-39);
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
	for vb=1,13 do
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

	BAGheji.fenlei = CreateFrame("Button",nil,BAGheji, "TruncatedButtonTemplate");
	BAGheji.fenlei:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	BAGheji.fenlei:SetSize(18,18);
	BAGheji.fenlei:SetPoint("TOPRIGHT",BAGheji,"TOPRIGHT",-10,-42);
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
			for vb=1,#bagID do
				local Fid=IsBagOpen(bagID[vb])
				if Fid then
					_G["ContainerFrame"..Fid.."PortraitButton"]:Hide()
				end
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
			for vb=1,#bagID do
				local Fid=IsBagOpen(bagID[vb])
				if Fid then
					local fameXX = _G["ContainerFrame"..Fid.."PortraitButton"]
					fameXX.ICONpig:SetTexture(bagicon[bagID[vb]+1]);
					fameXX:Show()
				end
			end
		end
	end);
	---物品显示区域
	BAGheji.wupin = CreateFrame("Frame", nil, BAGheji,"BackdropTemplate")
	BAGheji.wupin:SetPoint("TOPLEFT", BAGheji, "TOPLEFT",20, -68);
	BAGheji.wupin:SetPoint("BOTTOMRIGHT", BAGheji, "BOTTOMRIGHT", -8, 30);
	BAGheji.wupin:EnableMouse(true)

	local Mkuandu,Mgaodu = 8,22
	BAGheji.moneyframe = CreateFrame("Frame", nil, BAGheji);
	BAGheji.moneyframe:SetSize(160,Mgaodu);
	BAGheji.moneyframe:SetPoint("BOTTOMRIGHT", BAGheji, "BOTTOMRIGHT", -8, 5)
	if not PIG["zhegnheBAG"]["JianjieMOD"] then
		BAGheji.wupin:SetBackdrop( { bgFile = "interface/framegeneral/ui-background-marble.blp" });
	end

	--离线背包================================
	local lixianBAG=ADD_Frame("lixianBAG_UI",UIParent,200,200,"CENTER",UIParent,"CENTER",0,100,true,false,true,true,true)
	lixianBAG:SetUserPlaced(false)
	lixianBAG:SetFrameLevel(110)
	ADD_BagBankBGtex(lixianBAG,"lixianBAG_")

	lixianBAG.Portrait_BG = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.Portrait_BG:SetTexture("interface/buttons/iconborder-glowring.blp");
	lixianBAG.Portrait_BG:SetSize(56,56);
	lixianBAG.Portrait_BG:SetPoint("TOPLEFT",lixianBAG,"TOPLEFT",10,-6);
	lixianBAG.Portrait_BG:SetDrawLayer("BORDER", -2)
	lixianBAG.Portrait_BGmask = lixianBAG:CreateMaskTexture()
	lixianBAG.Portrait_BGmask:SetAllPoints(lixianBAG.Portrait_BG)
	lixianBAG.Portrait_BGmask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	lixianBAG.Portrait_BG:AddMaskTexture(lixianBAG.Portrait_BGmask)
	lixianBAG.Portrait_TEX = lixianBAG:CreateTexture(nil, "BORDER");
	lixianBAG.Portrait_TEX:SetTexture(130899)
	lixianBAG.Portrait_TEX:SetDrawLayer("BORDER", -1)
	lixianBAG.Portrait_TEX:SetAllPoints(lixianBAG.Portrait_BG)
	--------------------------
	lixianBAG.biaoti = CreateFrame("Frame", nil, lixianBAG)
	lixianBAG.biaoti:SetPoint("TOPLEFT", lixianBAG, "TOPLEFT",68, -13);
	lixianBAG.biaoti:SetPoint("TOPRIGHT", lixianBAG, "TOPRIGHT",-28, -1);
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
	lixianBAG.biaoti.t:SetPoint("CENTER", lixianBAG.topbg, "CENTER", 4, 0);
	lixianBAG.biaoti.t:SetFontObject(GameFontNormal);

	lixianBAG.Close = CreateFrame("Button",nil,lixianBAG, "UIPanelCloseButton");
	lixianBAG.Close:SetSize(32,32);
	lixianBAG.Close:SetPoint("TOPRIGHT",lixianBAG,"TOPRIGHT",5,-6);

	lixianBAG.wupin = CreateFrame("Frame", nil, lixianBAG,"BackdropTemplate")
	lixianBAG.wupin:SetBackdrop( { bgFile = "interface/framegeneral/ui-background-marble.blp" });
	lixianBAG.wupin:SetPoint("TOPLEFT", lixianBAG, "TOPLEFT",20, -66);
	lixianBAG.wupin:SetPoint("BOTTOMRIGHT", lixianBAG, "BOTTOMRIGHT", -10, 29);
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
				lixianBAG.wupin.item:SetPoint("TOPLEFT", _G["lixianBAG_UI_wupin_item_"..(i-bagID.meihang)], "BOTTOMLEFT", 0, -4);
			else
				lixianBAG.wupin.item:SetPoint("LEFT", _G["lixianBAG_UI_wupin_item_"..(i-1)], "RIGHT", 4, 0);
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
	--离线装备================
	local CzhuangbeiName = "lixianC_UI"
	local lixianC=ADD_Frame(CzhuangbeiName,UIParent,360,444,"CENTER",UIParent,"CENTER",-100, 100,true,false,true,true,true)
	lixianC:SetUserPlaced(false)
	lixianC:SetFrameLevel(130)
	local ADD_CharacterFrame=addonTable.ADD_CharacterFrame
	ADD_CharacterFrame(lixianC,CzhuangbeiName,360)


	---系统银行处理
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
	local bagicon={BankSlotsFrame.Bag1.icon,BankSlotsFrame.Bag2.icon,BankSlotsFrame.Bag3.icon,BankSlotsFrame.Bag4.icon,BankSlotsFrame.Bag5.icon,BankSlotsFrame.Bag6.icon,}
	if tocversion>19999 then
		table.insert(bagicon, BankSlotsFrame.Bag7.icon);
	end
	BankSlotsFrame.fenlei:SetScript("OnClick",  function (self)
		if BankSlotsFrame.fenlei.show then
			BankSlotsFrame.fenlei.show=false
			self.Tex:SetRotation(0, 0.4, 0.5)
			for vb=2,#bankID do
				local Fid=IsBagOpen(bankID[vb])
				if Fid then
					_G["ContainerFrame"..Fid.."PortraitButton"]:Hide()
				end
			end
		else
			BankSlotsFrame.fenlei.show=true
			self.Tex:SetRotation(-3.1415926, 0.4, 0.5)
			for vb=2,#bankID do
				local Fid=IsBagOpen(bankID[vb])
				if Fid then
					local fameXX = _G["ContainerFrame"..Fid.."PortraitButton"]
					fameXX.ICONpig:SetTexture(bagicon[bankID[vb]-4]:GetTexture());
					fameXX:Show()
				end
			end
		end
	end);
	BankSlotsFrame:HookScript("OnHide", function(self)
		self.fenlei.show=false
		self.fenlei.Tex:SetRotation(0, 0.4, 0.5)
	end);
	---
	ADD_BagBankBGtex(BankFrame,"pig_BankFrame_")
	--物品显示区域
	BankSlotsFrame.wupin = CreateFrame("Frame", nil, BankSlotsFrame,"BackdropTemplate")
	BankSlotsFrame.wupin:SetPoint("TOPLEFT", BankSlotsFrame, "TOPLEFT",21, -70);
	BankSlotsFrame.wupin:SetPoint("BOTTOMRIGHT", BankSlotsFrame, "BOTTOMRIGHT", -10, 30);
	BankSlotsFrame.wupin:EnableMouse(true)
	BankSlotsFrame.wupin:SetBackdrop( { bgFile = "interface/framegeneral/ui-background-marble.blp" });
	---离线银行========
	local lixianBank=ADD_Frame("lixianBank_UI",UIParent,500,210,"TOPLEFT", UIParent, "TOPLEFT",8, -104,true,false,true,true,true)
	lixianBank:SetUserPlaced(false)
	--lixianBank:SetToplevel(true)
	lixianBank.Close = CreateFrame("Button",nil,lixianBank, "UIPanelCloseButton");
	lixianBank.Close:SetSize(32,32);
	lixianBank.Close:SetPoint("TOPRIGHT",lixianBank,"TOPRIGHT",5,-7);
	ADD_BagBankBGtex(lixianBank,"pig_lixianBank_")

	lixianBank.Portrait_BG = lixianBank:CreateTexture(nil, "BORDER");
	lixianBank.Portrait_BG:SetTexture("interface/buttons/iconborder-glowring.blp");
	lixianBank.Portrait_BG:SetSize(55,55);
	lixianBank.Portrait_BG:SetPoint("TOPLEFT",lixianBank,"TOPLEFT",12,-6);
	lixianBank.Portrait_BG:SetDrawLayer("BORDER", -2)
	lixianBank.Portrait_BGmask = lixianBank:CreateMaskTexture()
	lixianBank.Portrait_BGmask:SetAllPoints(lixianBank.Portrait_BG)
	lixianBank.Portrait_BGmask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	lixianBank.Portrait_BG:AddMaskTexture(lixianBank.Portrait_BGmask)
	lixianBank.Portrait_TEX = lixianBank:CreateTexture(nil, "BORDER");
	lixianBank.Portrait_TEX:SetAllPoints(lixianBank.Portrait_BG)
	lixianBank.Portrait_TEX:SetDrawLayer("BORDER", -1)
	lixianBank.Portrait_TEX:SetTexture(130899)
	-- ----------
	lixianBank.biaoti = CreateFrame("Frame", nil, lixianBank)
	lixianBank.biaoti:SetPoint("TOPLEFT", lixianBank, "TOPLEFT",68, -13);
	lixianBank.biaoti:SetPoint("TOPRIGHT", lixianBank, "TOPRIGHT",-24, -13);
	lixianBank.biaoti:SetHeight(20);
	lixianBank.biaoti:EnableMouse(true)
	lixianBank.biaoti:RegisterForDrag("LeftButton")
	lixianBank.biaoti.t = lixianBank.biaoti:CreateFontString();
	lixianBank.biaoti.t:SetPoint("CENTER", lixianBank.biaoti, "CENTER", 8, 0);
	lixianBank.biaoti.t:SetFontObject(GameFontNormal);
	lixianBank.biaoti.t:SetText('银行');
	lixianBank.biaoti:SetScript("OnDragStart",function()
	    lixianBank:StartMoving();
	    lixianBank:SetUserPlaced(false)
	end)
	lixianBank.biaoti:SetScript("OnDragStop",function()
	    lixianBank:StopMovingOrSizing()
	    lixianBank:SetUserPlaced(false)
	end)
	lixianBank.wupin = CreateFrame("Frame", nil, lixianBank,"BackdropTemplate")
	lixianBank.wupin:SetBackdrop( { bgFile = "interface/framegeneral/ui-background-marble.blp" });
	lixianBank.wupin:SetPoint("TOPLEFT", lixianBank, "TOPLEFT",20, -68);
	lixianBank.wupin:SetPoint("BOTTOMRIGHT", lixianBank, "BOTTOMRIGHT", -8, 30);
	lixianBank.wupin:EnableMouse(true)
	for i=1,yinhangmorengezishu.banknum do
		lixianBank.wupin.item = CreateFrame("Button", "lixianBank_UI_wupin_item_"..i, lixianBank.wupin, "SecureActionButtonTemplate");
		lixianBank.wupin.item:SetHighlightTexture(130718);
		lixianBank.wupin.item:SetSize(BagdangeW-4,BagdangeW-4);
		if i==1 then
			lixianBank.wupin.item:SetPoint("TOPLEFT",lixianBank.wupin,"TOPLEFT",4,-4);
		else
			local yushu=math.fmod((i-1),bankID.meihang)
			if yushu==0 then
				lixianBank.wupin.item:SetPoint("TOPLEFT", _G["lixianBank_UI_wupin_item_"..(i-bankID.meihang)], "BOTTOMLEFT", 0, -4);
			else
				lixianBank.wupin.item:SetPoint("LEFT", _G["lixianBank_UI_wupin_item_"..(i-1)], "RIGHT", 4, 0);
			end
		end
		lixianBank.wupin.item:Hide();
		if PIG["zhegnheBAG"]["wupinLV"] then
			lixianBank.wupin.item.LV = lixianBank.wupin.item:CreateFontString();
			lixianBank.wupin.item.LV:SetPoint("TOPRIGHT", lixianBank.wupin.item, "TOPRIGHT", 0,-1);
			lixianBank.wupin.item.LV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		end
		lixianBank.wupin.item.shuliang = lixianBank.wupin.item:CreateFontString();
		lixianBank.wupin.item.shuliang:SetPoint("BOTTOMRIGHT", lixianBank.wupin.item, "BOTTOMRIGHT", -4,2);
		lixianBank.wupin.item.shuliang:SetFontObject(TextStatusBarText);
	end
	BankFrame:HookScript("OnShow", function ()
		lixianBank:Hide()
	end)
	---------------
	BankFrame:RegisterEvent("BAG_UPDATE_DELAYED")
	BankFrame:HookScript("OnEvent", function (self,event,arg1)
		if event=="PLAYERBANKSLOTS_CHANGED" then
			if PIG["zhegnheBAG"]["wupinLV"] then
				shuaxinyinhangMOREN(arg1)
			end
			if PIG["zhegnheBAG"]["wupinRanse"] then shuaxinyinhangMOREN_ranse(arg1) end
			C_Timer.After(0.4,SAVE_bank)
		end
		if event=="BAG_UPDATE_DELAYED" then
			if lixianBank_UI:IsShown() then
				OpenBag(5);OpenBag(6);OpenBag(7);OpenBag(8);OpenBag(9);OpenBag(10);OpenBag(11);	
			end
		end
		if event=="BANKFRAME_OPENED" then
			SetPortraitTexture(BAGheji.Portrait_TEX, "player")
			zhegnheBANK_Open()
			OpenBag(5);OpenBag(6);OpenBag(7);OpenBag(8);OpenBag(9);OpenBag(10);OpenBag(11);	
			if PIG["zhegnheBAG"]["wupinLV"] then
				for i=1,yinhangmorengezishu[1] do
					shuaxinyinhangMOREN(i)
				end
			end
			if PIG["zhegnheBAG"]["wupinRanse"] then
				for i=1,yinhangmorengezishu[1] do
					shuaxinyinhangMOREN_ranse(i) 
				end
			end
			C_Timer.After(0.4,SAVE_bank)
		end
	end)
	---------------------
	BAGheji_UI:RegisterEvent("PLAYER_ENTERING_WORLD");
	BAGheji_UI:RegisterEvent("BAG_UPDATE_DELAYED")
	BAGheji_UI:RegisterEvent("AUCTION_HOUSE_SHOW")
	BAGheji_UI:RegisterUnitEvent("UNIT_MODEL_CHANGED","player")
	BAGheji_UI:RegisterUnitEvent("UNIT_PORTRAIT_UPDATE","player")
	BAGheji_UI:HookScript("OnEvent", function(self,event,arg1)
		if event=="PLAYER_ENTERING_WORLD" then
			local dangqianjusexinxi={["ClassN"]=0,["Race"]=0,["Lv"]=0,["G"]=0,["C"]={},["BAG"]={},["BANK"]={}}
			for k,v in pairs(PIG["zhegnheBAG"]["lixian"]) do
				for kk,vv in pairs(dangqianjusexinxi) do
					if PIG["zhegnheBAG"]["lixian"][k][kk]==nil then
						PIG["zhegnheBAG"]["lixian"][k][kk]=vv
					end
				end
			end
			local _, englishClass,classId= UnitClass("player");
			local raceName, raceFile, raceID = UnitRace("player")
			local level = UnitLevel("player")
			if PIG_renwuming then
				if PIG["zhegnheBAG"]["lixian"][PIG_renwuming]==nil then
					PIG["zhegnheBAG"]["lixian"][PIG_renwuming]=dangqianjusexinxi
				end
				PIG["zhegnheBAG"]["lixian"][PIG_renwuming]["ClassN"]=classId
				PIG["zhegnheBAG"]["lixian"][PIG_renwuming]["Race"]=raceID
				PIG["zhegnheBAG"]["lixian"][PIG_renwuming]["Lv"]=level
			end
		end
		if event=="AUCTION_HOUSE_SHOW" then
			if PIG["zhegnheBAG"]["AHOpen"] then
				if(UnitExists("NPC"))then
					OpenAllBags()
				end
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
				if PIG["zhegnheBAG"]["wupinLV"] then Bag_Item_lv(nil, nil, arg1) end
				if PIG["zhegnheBAG"]["wupinRanse"] then Bag_Item_Ranse(nil, nil, arg1) end
				if PIG["zhegnheBAG"]["JunkShow"] then Bag_Item_Junk(nil, nil, arg1) end
			end
			if BankFrame:IsShown() then
				if arg1>4 then
					if PIG["zhegnheBAG"]["wupinLV"] then Bag_Item_lv(nil, nil, arg1) end
					if PIG["zhegnheBAG"]["wupinRanse"] then Bag_Item_Ranse(nil, nil, arg1) end
					C_Timer.After(0.4,SAVE_bank)
				end
			end
		end
	end)
	local function zhixingbaocunCMD()
		SAVE_BAG()
		BAGheji_UI:RegisterEvent("BAG_UPDATE")
	end
	C_Timer.After(8,zhixingbaocunCMD)
	---------------------
	hooksecurefunc("ContainerFrame_GenerateFrame", function(frame, size, id)
		--print(id)
		if id==-2 then
			shuaxinKEYweizhi(frame)
		end

		if id>=0 and id<5 then
			shuaxinBAGweizhi(frame, size, id)
		end

		if id>4 and id<12 then
			shuaxinBANKweizhi(frame, size, id)
		end

		if PIG["zhegnheBAG"]["wupinLV"] then Bag_Item_lv(frame, size, id) end
		if PIG["zhegnheBAG"]["wupinRanse"] then Bag_Item_Ranse(frame, size, id) end
		if id>=0 and id<5 then
			if PIG["zhegnheBAG"]["JunkShow"] then Bag_Item_Junk(frame, size, id) end
		end
	end)
	if tocversion>30000 then
		hooksecurefunc("ManageBackpackTokenFrame", function(backpack)
			BackpackTokenFrame:ClearAllPoints();
			BackpackTokenFrame:SetPoint("TOPRIGHT", BAGheji_UI.moneyframe, "TOPLEFT", -4, 5);
			BackpackTokenFrame:SetParent(BAGheji_UI);
			local regions = { BackpackTokenFrame:GetRegions() }
			for gg=1,#regions do
				regions[gg]:Hide()
				--regions[gg]:SetTexCoord(0.05,0.8,0,0.74);
			end	
			if (not backpack) then
				backpack = GetBackpackFrame();
			end
			if backpack then
				backpack:SetHeight(0);
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
				local Fid = IsBagOpen(bagID[i]);
				if Fid then
					local frame = _G["ContainerFrame"..Fid];
					if ( frame:IsShown() ) then
						frame:Hide();
						EventRegistry:TriggerEvent("ContainerFrame.CloseBackpack");
					end
					if ( BackpackTokenFrame ) then
						BackpackTokenFrame:Hide();
					end
				end
			end
			CloseBag(-2);
			BAGheji:Hide()
		else
			local Fid=IsBagOpen(-2)
			if Fid then 	
				local frameff = _G["ContainerFrame"..Fid]
				frameff:Hide();
			end
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
	UIParent:HookScript("OnHide", function(self)
		BAGheji:Hide()
		lixianBAG:Hide()
		lixianC:Hide()
		lixianBank:Hide()
	end)
end
--==========================================================
fuFrame.beibaozhenghe = ADD_Checkbutton(nil,fuFrame,-50,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"启用背包/银行整合","整合背包/银行为一个大包裹")
fuFrame.beibaozhenghe:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["zhegnheBAG"]["Open"]="ON";
		zhegnhe_Open()
		addonTable.qiyongzidongzhengli()
	else
		PIG["zhegnheBAG"]["Open"]="OFF";
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
	if PIG["zhegnheBAG"]['BAGkongyu']=="ON" then
		if event=="PLAYER_ENTERING_WORLD" then
			bigfontziti()
		end
		if event=="BAG_UPDATE" then
			gengxinbeibaoshengyugeshu()
		end
	end
end);
----
fuFrame.BAGkongyu = ADD_Checkbutton(nil,fuFrame,-50,"TOPLEFT",fuFrame,"TOPLEFT",20,-80,"","")
if tocversion<20000 then
	fuFrame.BAGkongyu.Text:SetText("显示背包剩余空间");
	fuFrame.BAGkongyu.tooltip = "在背包上显示背包的总剩余空间";
else
	fuFrame.BAGkongyu.Text:SetText("增大系统背包剩余空间数字");
	fuFrame.BAGkongyu.tooltip = "增大系统的背包剩余空间数字(大于等于10显示绿色,小于10显示红色)\n|cff00FF00TBC以后的版本系统已自带背包剩余空间显示，请在ESC菜单-界面-显示内打开|r";
end
fuFrame.BAGkongyu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["zhegnheBAG"]['BAGkongyu']="ON";
		bigfontziti()
	else
		PIG["zhegnheBAG"]['BAGkongyu']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--加载设置---------------
addonTable.BagBank = function()
	local Pname = UnitFullName("player");
	PIG_renwuming=Pname.."-"..GetRealmName()
	if PIG["zhegnheBAG"]["Open"]=="ON" then
		fuFrame.beibaozhenghe:SetChecked(true)
		bagID.meihang=PIG["zhegnheBAG"]["BAGmeihangshu"] or bagID.meihang
		bagID.suofang=PIG["zhegnheBAG"]["BAGsuofangshu_suofang"] or bagID.suofang
		zhegnhe_Open()
		addonTable.qiyongzidongzhengli()
	end
	if PIG["zhegnheBAG"]['BAGkongyu']=="ON" then
		fuFrame.BAGkongyu:SetChecked(true);
		bigfontziti()
	end
end