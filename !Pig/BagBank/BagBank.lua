local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local sub = _G.string.sub  --截取
local fuFrame=List_R_F_2_1
local ADD_Frame=addonTable.ADD_Frame
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local Create=addonTable.Create
local PIGDownMenu=Create.PIGDownMenu
--==========================================
local yinhangmorengezishu={28,7}
yinhangmorengezishu.banknum=yinhangmorengezishu[1]+yinhangmorengezishu[2]*36
----==============
local QualityColor=addonTable.QualityColor
local bagID = {0,1,2,3,4,5}
bagID.meihang=10
bagID.suofang=1
local bankID = {-1,6,7,8,9,10,11,12}
bankID.meihang=16
bankID.suofang=1
local zhengliIcon="interface/containerframe/bags.blp"	
local BagdangeW=ContainerFrame1Item1:GetWidth()+5
---------------------
local qishihang=math.ceil(yinhangmorengezishu[1]/bankID.meihang)--行数
local qishikongyu=qishihang*bankID.meihang-yinhangmorengezishu[1]--空余
local function shuaxinBANKweizhi(frame, size, id)
	frame.TitleContainer:Hide();
	frame.PortraitContainer:Hide();
	frame.Bg:Hide();
	frame.CloseButton:Hide();
	frame.PortraitButton:Hide();
	frame:SetHeight(0);
	frame:SetToplevel(false)
	frame:SetParent(BankSlotsFrame);
	local name = frame:GetName();
	local function jisuanzongshu(id)
		if id==bankID[2] then
			return yinhangmorengezishu[1]
		else
			yinhangmorengezishu.zongshu=yinhangmorengezishu[1]
			local qianzhibag = id-bankID[2]
			for i=1,qianzhibag do
				local shangnum = C_Container.GetContainerNumSlots(i+bankID[2]-1)
				yinhangmorengezishu.zongshu=yinhangmorengezishu.zongshu+shangnum
			end
			return yinhangmorengezishu.zongshu
		end
	end
	local function jisuankonmgyu(id,zongshu)
		if id==bankID[2] then
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
			itemF:SetPoint("TOPRIGHT", BankSlotsFrame, "TOPRIGHT", -new_kongyu*BagdangeW-54.6, -new_hangshu*BagdangeW-18);
			frame.PortraitButton:ClearAllPoints();
			frame.PortraitButton:SetPoint("TOPRIGHT", BankSlotsFrame, "TOPRIGHT", -8, -(42*(id-bankID[2]+1))-8);
			frame.FilterIcon:ClearAllPoints();
			frame.FilterIcon:SetPoint("BOTTOMRIGHT", frame.PortraitButton, "BOTTOMRIGHT", 8, -4);
			if not frame.PortraitButton:IsShown() then frame.FilterIcon:Hide() end
		else
			local yushu=math.fmod((slot+new_kongyu-1),bankID.meihang)
			local itemFshang = _G[name.."Item"..(slot-1)]
			if yushu==0 then
				itemF:SetPoint("BOTTOMLEFT", itemFshang, "TOPLEFT", (bankID.meihang-1)*BagdangeW, 5);
			else
				itemF:SetPoint("RIGHT", itemFshang, "LEFT", -5, 0);
			end
		end
	end
	local ZONGGEZI=C_Container.GetContainerNumSlots(5)+C_Container.GetContainerNumSlots(6)+C_Container.GetContainerNumSlots(7)+C_Container.GetContainerNumSlots(8)+C_Container.GetContainerNumSlots(9)+C_Container.GetContainerNumSlots(10)+C_Container.GetContainerNumSlots(11)+yinhangmorengezishu[1]
	local hangShuALL=math.ceil(ZONGGEZI/bankID.meihang)
	if hangShuALL>7 then
		BankFrame:SetHeight(hangShuALL*BagdangeW+94);
	end
end
-------------------
local function zhegnheBANK_Open()
	BankItemSearchBox:SetPoint("TOPRIGHT",BankFrame,"TOPRIGHT",-100,-33);
	BankFramePurchaseButton:SetWidth(90)
	BankFramePurchaseButton:ClearAllPoints();
	BankFramePurchaseButton:SetPoint("TOPLEFT", BankFrame, "TOPLEFT", 280, -28);
	BankFramePurchaseButtonText:SetPoint("RIGHT", BankFramePurchaseButton, "RIGHT", -8, 0);
	BankFrameDetailMoneyFrame:ClearAllPoints();
	BankFrameDetailMoneyFrame:SetPoint("RIGHT", BankFramePurchaseButtonText, "LEFT", 6, -1);
	local BKregions1 = {BankFramePurchaseInfo:GetRegions()}
	for i=1,#BKregions1 do
		BKregions1[i]:Hide()
	end
	local BankSlotsFrameReg = {BankSlotsFrame:GetRegions()}
	for i=1,#BankSlotsFrameReg do
		BankSlotsFrameReg[i]:SetAlpha(0)
	end
	for i=1,yinhangmorengezishu[2] do
		BankSlotsFrame["Bag"..i]:SetScale(0.76);
		if i==1 then
			BankSlotsFrame["Bag"..i]:SetPoint("TOPLEFT", BankFrameItem1, "BOTTOMLEFT", 70, 92);
		else
			BankSlotsFrame["Bag"..i]:SetPoint("TOPLEFT", BankSlotsFrame["Bag"..(i-1)], "TOPRIGHT", 0, 0);
		end
	end
	for i = 1, yinhangmorengezishu[1] do
		_G["BankFrameItem"..i]:ClearAllPoints();
		if i==1 then
			_G["BankFrameItem"..i]:SetPoint("TOPLEFT", BankSlotsFrame, "TOPLEFT", 16, -60);
		else
			local yushu=math.fmod(i-1,bankID.meihang)
			if yushu==0 then
				_G["BankFrameItem"..i]:SetPoint("TOPLEFT", _G["BankFrameItem"..(i-bankID.meihang)], "BOTTOMLEFT", 0, -5);
			else
				_G["BankFrameItem"..i]:SetPoint("LEFT", _G["BankFrameItem"..(i-1)], "RIGHT", 5, 0);
			end
		end
	end
	BankFrame:SetWidth(BagdangeW*bankID.meihang+66)
end
----保存离线数据-----
local function SAVE_lixian_data(bagID, slot,wupinshujuinfo)
	local ItemInfo= C_Container.GetContainerItemInfo(bagID, slot)
	if ItemInfo then
		local itemStackCount,itemEquipLoc,itemTexture,sellPrice,classID = select(8,GetItemInfo(ItemInfo.hyperlink))
		local wupinxinxi={ItemInfo.itemID,ItemInfo.hyperlink,ItemInfo.stackCount,itemStackCount,false}
		if classID==2 or classID==4 then
			wupinxinxi[5]=true
		end
		table.insert(wupinshujuinfo, wupinxinxi);
	end
end
local function SAVE_C()
	if InCombatLockdown() then return end
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
	if InCombatLockdown() then return end
	local wupinshujuinfo = {}
	for f=1,#bagID do
		for ff=1,C_Container.GetContainerNumSlots(bagID[f]) do
			SAVE_lixian_data(bagID[f], ff,wupinshujuinfo)
		end
	end
	PIG['zhegnheBAG']["lixian"][PIG_renwuming]["BAG"] = wupinshujuinfo
	PIG['zhegnheBAG']["lixian"][PIG_renwuming]["G"] = GetMoney();
end
local function SAVE_BANK()
	if InCombatLockdown() then return end
	local wupinshujuinfo = {}
	for f=1,#bankID do
		if f==1 then
			for ff=1,yinhangmorengezishu[1] do
				SAVE_lixian_data(bankID[f], ff,wupinshujuinfo)
			end
		else
			for ff=1,C_Container.GetContainerNumSlots(bankID[f]) do
				SAVE_lixian_data(bankID[f], ff,wupinshujuinfo)
			end
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
				if i~=4 and i~=19 then
					_G[framename.."_zbBuwei_"..i].itemlink:SetText(itemLink)
				end
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

--刷新背包LV----------------
local function Bag_Item_lv_Update(framef, id, slot)
	framef.ZLV:SetText();
	local itemLink = C_Container.GetContainerItemLink(id, slot)
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
local function Bag_Item_lv_Frame(id)
	if IsBagOpen(id) then
		if id==0 and not IsAccountSecured() then
			local baogeshu=C_Container.GetContainerNumSlots(id)+4
			for slot=1,baogeshu do
				local framef = _G["ContainerFrame"..(id+1).."Item"..baogeshu+1-slot]
				Bag_Item_lv_Update(framef, id, slot)
			end
		else
			local baogeshu=C_Container.GetContainerNumSlots(id)
			for slot=1,baogeshu do
				local framef = _G["ContainerFrame"..(id+1).."Item"..baogeshu+1-slot]
				Bag_Item_lv_Update(framef, id, slot)
			end
		end
	end
end
local function Bag_Item_lv(frame, size, id)
	if frame then
		for f=1,#bagID do
			Bag_Item_lv_Frame(bagID[f])
		end
	else
		Bag_Item_lv_Frame(id)
	end
end
--银行默认格子LV
local function shuaxinyinhangMOREN(arg1)
	if arg1>yinhangmorengezishu[1] then return end
	local framef=_G["BankFrameItem"..arg1];
	Bag_Item_lv_Update(framef, -1, arg1)
end
--银行默认格子染色==================================
local function Bag_Item_Ranse_Update(framef,id,slot)
	framef.ranse:Hide()
	local itemLink = C_Container.GetContainerItemLink(id, slot)
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
	Bag_Item_Ranse_Update(framef,-1,arg1)
end
--刷新背包银行染色
local function Bag_Item_Ranse_Frame(id)
	if IsBagOpen(id) then
		if id==0 and not IsAccountSecured() then
			local baogeshu=C_Container.GetContainerNumSlots(id)+4
			for slot=1,baogeshu do
				local framef = _G["ContainerFrame"..(id+1).."Item"..baogeshu+1-slot]
				Bag_Item_Ranse_Update(framef, id, slot)
			end
		else
			local baogeshu=C_Container.GetContainerNumSlots(id)
			for slot=1,baogeshu do
				local framef = _G["ContainerFrame"..(id+1).."Item"..baogeshu+1-slot]
				Bag_Item_Ranse_Update(framef, id, slot)
			end
		end
	end
end
local function Bag_Item_Ranse(frame, size, id)
	if frame then
		for f=1,#bagID do
			Bag_Item_Ranse_Frame(bagID[f])
		end
	else
		Bag_Item_Ranse_Frame(id)
	end
end
--其他角色数量
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
	if not PIG['zhegnheBAG']["qitashulaing"] then return end
	if tooltip == GameTooltip then
		local itemID = data["id"]
		if itemID then	
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
					tooltipxianshineirong.argbHex="ffffffff"
					if tonumber(renwuWupinINFO[k]["ClassN"])>0 then
						local classInfo = C_CreatureInfo.GetClassInfo(renwuWupinINFO[k]["ClassN"])
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
					GameTooltip:AddDoubleLine(renwuWupinshu[i][1],renwuWupinshu[i][2])
					renwuWupinshu.hejishu=renwuWupinshu.hejishu+renwuWupinshu[i][3]
				end
				if yiyouwupinjuese>1 then
					GameTooltip:AddDoubleLine("|cff00FF00所有角色|r","|cff00FF00合计:|r|cffFFFFFF"..renwuWupinshu.hejishu)
				end
				GameTooltip:Show()
			end
		end
	end
end)

--===========================================
local XWidth, XHeight =CharacterHeadSlot:GetWidth(),CharacterHeadSlot:GetHeight()
--------
local function zhegnhe_Open()
	if ContainerFrameCombinedBags.biaoti then return end
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
	if PIG['zhegnheBAG']["JunkShow"] then
		for f=1,#bagID do
			local baogeshu=C_Container.GetContainerNumSlots(bagID[f])
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
	--------------------------
	ContainerFrameCombinedBags:HookScript("OnHide",function(self)
		self.shezhi.F:Hide()
	end)
	ContainerFrameCombinedBags.biaoti = CreateFrame("Frame", nil, ContainerFrameCombinedBags)
	ContainerFrameCombinedBags.biaoti:SetPoint("TOPLEFT", ContainerFrameCombinedBags, "TOPLEFT",58, -1);
	ContainerFrameCombinedBags.biaoti:SetPoint("TOPRIGHT", ContainerFrameCombinedBags, "TOPRIGHT",-26, -1);
	ContainerFrameCombinedBags.biaoti:SetHeight(20);
	ContainerFrameCombinedBags.biaoti:EnableMouse(true)
	ContainerFrameCombinedBags.biaoti:RegisterForDrag("LeftButton")
	ContainerFrameCombinedBags.biaoti:SetScript("OnDragStart",function()
	    ContainerFrameCombinedBags:StartMoving();
	    ContainerFrameCombinedBags:SetUserPlaced(false)
	end)
	ContainerFrameCombinedBags.biaoti:SetScript("OnDragStop",function()
	    ContainerFrameCombinedBags:StopMovingOrSizing()
	    ContainerFrameCombinedBags:SetUserPlaced(false)
	end)
	hooksecurefunc(ContainerFrameCombinedBags, "SetSearchBoxPoint", function(self)
		BagItemSearchBox:SetWidth(180);
		BagItemSearchBox:SetPoint("TOPLEFT",ContainerFrameCombinedBags,"TOPLEFT",160,-37);
	end)

	ContainerFrameCombinedBags.lixianBUT = CreateFrame("Frame",nil,ContainerFrameCombinedBags);
	ContainerFrameCombinedBags.lixianBUT:SetSize(32,32);
	ContainerFrameCombinedBags.lixianBUT:SetPoint("TOPLEFT",ContainerFrameCombinedBags,"TOPLEFT",36,-30);

	ContainerFrameCombinedBags.lixianBUT.Border = ContainerFrameCombinedBags.lixianBUT:CreateTexture(nil, "OVERLAY");
	ContainerFrameCombinedBags.lixianBUT.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
	ContainerFrameCombinedBags.lixianBUT.Border:SetSize(52,52);
	ContainerFrameCombinedBags.lixianBUT.Border:SetPoint("TOPLEFT", 0, 0);

	ContainerFrameCombinedBags.lixianBUT.Tex = ContainerFrameCombinedBags.lixianBUT:CreateTexture()
	ContainerFrameCombinedBags.lixianBUT.Tex:SetTexture(130899);
	ContainerFrameCombinedBags.lixianBUT.Tex:SetAllPoints(ContainerFrameCombinedBags.lixianBUT)

	ContainerFrameCombinedBags.lixianBUT.xiala=PIGDownMenu(nil,{wwgg,hhgg},ContainerFrameCombinedBags.lixianBUT,{"TOPLEFT",ContainerFrameCombinedBags.lixianBUT, "CENTER", 0,-4},"DJEasyMenu")
	ContainerFrameCombinedBags.lixianBUT.xiala.Button:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight");
	ContainerFrameCombinedBags.lixianBUT.xiala.Button:HookScript("OnClick",  function (self,button)
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
	function ContainerFrameCombinedBags.lixianBUT.xiala:PIGDownMenu_Update_But(self, level, menuList)
		local danxuanerjiList = {}
		local KucunName={["C"]="已装备物品",["BAG"]="背包物品",["BANK"]="银行物品"}
		for k,v in pairs(PIG["zhegnheBAG"]["lixian"]) do	
			local xiajicaidan={}
			for kk,vv in pairs(KucunName) do
				table.insert(xiajicaidan,{vv,kk,k,v["ClassN"].."~"..v["Race"].."~"..v["Lv"]})
			end
			if k~=PIG_renwuming then
				ContainerFrameCombinedBags.lixiancunzaiwupin=true
				table.insert(danxuanerjiList,{k,xiajicaidan})
			end
	    end
	    local info = {}
	    if ContainerFrameCombinedBags.lixiancunzaiwupin then
			if (level or 1) == 1 then
				for i=1,#danxuanerjiList,1 do
				    info.text= danxuanerjiList[i][1]
				    info.menuList, info.hasArrow = danxuanerjiList[i][2], true
				    ContainerFrameCombinedBags.lixianBUT.xiala:PIGDownMenu_AddButton(info)
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
					ContainerFrameCombinedBags.lixianBUT.xiala:PIGDownMenu_AddButton(info,level)
				end
			end
	    else
	    	info.text= "登录一次其他角色可离线查看" 
	    	info.func = function()
				PIGCloseDropDownMenus()
			end
			ContainerFrameCombinedBags.lixianBUT.xiala:PIGDownMenu_AddButton(info)	
	    end 
	end

	--设置按钮
	ContainerFrameCombinedBags.shezhi = CreateFrame("Button",nil,ContainerFrameCombinedBags);
	ContainerFrameCombinedBags.shezhi:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight");
	ContainerFrameCombinedBags.shezhi:SetSize(32,32);
	ContainerFrameCombinedBags.shezhi:SetPoint("TOPLEFT",ContainerFrameCombinedBags,"TOPLEFT",90,-30);
	ContainerFrameCombinedBags.shezhi:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",-1,-1);
	end);
	ContainerFrameCombinedBags.shezhi:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	ContainerFrameCombinedBags.shezhi:SetScript("OnClick", function (self)
		if self.F:IsShown() then
			self.F:Hide()
		else
			self.F:Show()
		end
	end);

	ContainerFrameCombinedBags.shezhi.Border = ContainerFrameCombinedBags.shezhi:CreateTexture(nil, "OVERLAY");
	ContainerFrameCombinedBags.shezhi.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
	ContainerFrameCombinedBags.shezhi.Border:SetSize(52,52);
	ContainerFrameCombinedBags.shezhi.Border:SetPoint("TOPLEFT", 0, 0);

	ContainerFrameCombinedBags.shezhi.Tex = ContainerFrameCombinedBags.shezhi:CreateTexture(nil,"OVERLAY");
	ContainerFrameCombinedBags.shezhi.Tex:SetTexture("interface/gossipframe/healergossipicon.blp");
	ContainerFrameCombinedBags.shezhi.Tex:SetPoint("CENTER", 1, 0);
	ContainerFrameCombinedBags.shezhi.Tex:SetSize(18,18);
	local caihemeihang =10
	local BAG_shezhi = {
		{"交易时打开背包","jiaoyiOpen",false},
		{"拍卖时打开背包","AHOpen",false},
		{"垃圾物品提示","JunkShow",true},
		{"显示装备等级","wupinLV",true},
		{"装备品质染色","wupinRanse",true},
		{"显示其他角色数量","qitashulaing",false},
		{"显示其他角色金币","qitajinbi",true},
		{"反向整理",C_Container.GetSortBagsRightToLeft(),false},
		{"战利品放入左边包",C_Container.GetInsertItemsLeftToRight(),false},
	}
	ContainerFrameCombinedBags.shezhi.F = CreateFrame("Frame", nil, ContainerFrameCombinedBags.shezhi,"BackdropTemplate");
	ContainerFrameCombinedBags.shezhi.F:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8,insets = { left = 1, right = 1, top = 1, bottom = 1 }} );
	ContainerFrameCombinedBags.shezhi.F:SetBackdropBorderColor(1, 1, 1, 0.6);
	if #BAG_shezhi>caihemeihang then
		ContainerFrameCombinedBags.shezhi.F:SetSize(400,caihemeihang*36+70);
	else
		ContainerFrameCombinedBags.shezhi.F:SetSize(260,#BAG_shezhi*36+70);
	end
	ContainerFrameCombinedBags.shezhi.F:SetPoint("CENTER",UIParent,"CENTER",0,0);
	ContainerFrameCombinedBags.shezhi.F:Hide()
	ContainerFrameCombinedBags.shezhi.F:SetIgnoreParentScale(true)
	ContainerFrameCombinedBags.shezhi.F:SetFrameStrata("HIGH")
	ContainerFrameCombinedBags.shezhi.F.COS = CreateFrame("Button",nil,ContainerFrameCombinedBags.shezhi.F,"UIPanelCloseButton");
	ContainerFrameCombinedBags.shezhi.F.COS:SetSize(28,28);
	ContainerFrameCombinedBags.shezhi.F.COS:SetPoint("TOPRIGHT",ContainerFrameCombinedBags.shezhi.F,"TOPRIGHT",0,0);
	hooksecurefunc("TradeFrame_OnShow", function(self)
		if PIG['zhegnheBAG']["jiaoyiOpen"] then
			if(UnitExists("NPC"))then
				OpenAllBags()
			end
		end
	end);
	for i=1,#BAG_shezhi do
		ContainerFrameCombinedBags.shezhi.F.CKB = CreateFrame("CheckButton","BAG_shezhi_CKB_"..i, ContainerFrameCombinedBags.shezhi.F, "ChatConfigCheckButtonTemplate");
		ContainerFrameCombinedBags.shezhi.F.CKB:SetSize(28,28);
		ContainerFrameCombinedBags.shezhi.F.CKB:SetHitRectInsets(0,-100,0,0);
		ContainerFrameCombinedBags.shezhi.F.CKB.Text:SetText(BAG_shezhi[i][1]);
		ContainerFrameCombinedBags.shezhi.F.CKB.tooltip = "勾选将开启"..BAG_shezhi[i][1];
		if BAG_shezhi[i][1] then
			ContainerFrameCombinedBags.shezhi.F.CKB.CZUI = CreateFrame("Button",nil,ContainerFrameCombinedBags.shezhi.F.CKB, "UIPanelButtonTemplate");
			ContainerFrameCombinedBags.shezhi.F.CKB.CZUI:SetSize(70,22);
			ContainerFrameCombinedBags.shezhi.F.CKB.CZUI:SetPoint("LEFT",ContainerFrameCombinedBags.shezhi.F.CKB.Text,"RIGHT",4,0);
			ContainerFrameCombinedBags.shezhi.F.CKB.CZUI:SetText("重载UI");
			ContainerFrameCombinedBags.shezhi.F.CKB.CZUI:Hide();
			ContainerFrameCombinedBags.shezhi.F.CKB.CZUI:SetScript("OnClick", function(self, button)
				ReloadUI()
			end)
		end
		if i==1 then
			ContainerFrameCombinedBags.shezhi.F.CKB:SetPoint("TOPLEFT", ContainerFrameCombinedBags.shezhi.F, "TOPLEFT", 10, -10);
		elseif i==caihemeihang+1 then
			ContainerFrameCombinedBags.shezhi.F.CKB:SetPoint("LEFT", BAG_shezhi_CKB_1, "RIGHT", 150, 0);
		else
			ContainerFrameCombinedBags.shezhi.F.CKB:SetPoint("TOPLEFT", _G["BAG_shezhi_CKB_"..(i-1)], "BOTTOMLEFT", 0, -8);
		end

		ContainerFrameCombinedBags.shezhi.F.CKB:SetScript("OnClick", function (self)
			if self:GetChecked() then
				if BAG_shezhi[i][1]=="反向整理" then
					SetSortBagsRightToLeft(false)
				else
					PIG["zhegnheBAG"][BAG_shezhi[i][2]]=true
				end
				if BAG_shezhi[i][3] then
					self.CZUI:Show();
				end
			else
				if BAG_shezhi[i][1]=="反向整理" then
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
	function ContainerFrameCombinedBags:GetColumns()
		if self:IsCombinedBagContainer() then
			return bagID.meihang;
		else
			return 4;
		end
	end
	ContainerFrameCombinedBags.shezhi.F.hangNUMTXT = ContainerFrameCombinedBags.shezhi.F:CreateFontString();
	ContainerFrameCombinedBags.shezhi.F.hangNUMTXT:SetPoint("BOTTOMLEFT",ContainerFrameCombinedBags.shezhi.F,"BOTTOMLEFT",10,50);
	ContainerFrameCombinedBags.shezhi.F.hangNUMTXT:SetFontObject(GameFontNormal);
	ContainerFrameCombinedBags.shezhi.F.hangNUMTXT:SetText("每行格数");
	local BagmeihangN = {8,10,12,14,16};
	ContainerFrameCombinedBags.shezhi.F.hangNUM=PIGDownMenu(nil,{60,24},ContainerFrameCombinedBags.shezhi.F,{"LEFT",ContainerFrameCombinedBags.shezhi.F.hangNUMTXT,"RIGHT",0,0})
	function ContainerFrameCombinedBags.shezhi.F.hangNUM:PIGDownMenu_Update_But(self)
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#BagmeihangN,1 do
		    info.text, info.arg1 = BagmeihangN[i], BagmeihangN[i]
		    info.checked = BagmeihangN[i]==PIG['zhegnheBAG']["BAGmeihangshu_retail"]
			ContainerFrameCombinedBags.shezhi.F.hangNUM:PIGDownMenu_AddButton(info)
		end 
	end
	function ContainerFrameCombinedBags.shezhi.F.hangNUM:PIGDownMenu_SetValue(value,arg1,arg2)
		ContainerFrameCombinedBags.shezhi.F.hangNUM:PIGDownMenu_SetText(value)
		PIG['zhegnheBAG']["BAGmeihangshu_retail"] = arg1;
		bagID.meihang = arg1;
		CloseAllBags()
		OpenAllBags()
		PIGCloseDropDownMenus()
	end
	--缩放
	ContainerFrameCombinedBags.shezhi.F.suofangTXT = ContainerFrameCombinedBags.shezhi.F:CreateFontString();
	ContainerFrameCombinedBags.shezhi.F.suofangTXT:SetPoint("TOPLEFT",ContainerFrameCombinedBags.shezhi.F.hangNUMTXT,"BOTTOMLEFT",0,-14);
	ContainerFrameCombinedBags.shezhi.F.suofangTXT:SetFontObject(GameFontNormal);
	ContainerFrameCombinedBags.shezhi.F.suofangTXT:SetText("缩放比例");
	local BAGsuofangbili = {0.6,0.7,0.8,0.9,1,1.1,1.2,1.3,1.4};
	ContainerFrameCombinedBags.shezhi.F.suofang=PIGDownMenu(nil,{60,24},ContainerFrameCombinedBags.shezhi.F,{"LEFT",ContainerFrameCombinedBags.shezhi.F.suofangTXT,"RIGHT",0,0})
	function ContainerFrameCombinedBags.shezhi.F.suofang:PIGDownMenu_Update_But(self)
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#BAGsuofangbili,1 do
		    info.text, info.arg1 = BAGsuofangbili[i], BAGsuofangbili[i]
		    info.checked = BAGsuofangbili[i]==PIG["zhegnheBAG"]["BAGsuofangBili"]
			ContainerFrameCombinedBags.shezhi.F.suofang:PIGDownMenu_AddButton(info)
		end 
	end
	function ContainerFrameCombinedBags.shezhi.F.suofang:PIGDownMenu_SetValue(value,arg1,arg2)
		ContainerFrameCombinedBags.shezhi.F.suofang:PIGDownMenu_SetText(value)
		PIG["zhegnheBAG"]["BAGsuofangBili"] = arg1;
		bagID.suofang = arg1;
		ContainerFrameCombinedBags:SetScale(arg1)
		PIGCloseDropDownMenus()
	end

	ContainerFrameCombinedBags.shezhi.F.CZpeizhi = CreateFrame("Button",nil,ContainerFrameCombinedBags.shezhi.F, "UIPanelButtonTemplate");
	ContainerFrameCombinedBags.shezhi.F.CZpeizhi:SetSize(60,20);
	ContainerFrameCombinedBags.shezhi.F.CZpeizhi:SetPoint("BOTTOMRIGHT",ContainerFrameCombinedBags.shezhi.F,"BOTTOMRIGHT",-4,4);
	ContainerFrameCombinedBags.shezhi.F.CZpeizhi:SetText("重置");
	ContainerFrameCombinedBags.shezhi.F.CZpeizhi:SetScript("OnClick", function(self, button)
		StaticPopup_Show ("HUIFU_DEFAULT_BEIBAOZHENGHE");
	end)
	StaticPopupDialogs["HUIFU_DEFAULT_BEIBAOZHENGHE"] = {
		text = "此操作将\124cffff0000重置\124r背包/银行整合所有配置，\n需重载界面。确定重置?",
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
	ContainerFrameCombinedBags.shezhi.F:SetScript("OnShow", function(self)
		for i=1,#BAG_shezhi do
			if BAG_shezhi[i][1]=="反向整理" then
				if not C_Container.GetSortBagsRightToLeft() then _G["BAG_shezhi_CKB_"..i]:SetChecked(true) end
			else
				if PIG["zhegnheBAG"][BAG_shezhi[i][2]] then _G["BAG_shezhi_CKB_"..i]:SetChecked(true) end
			end
		end
		ContainerFrameCombinedBags.shezhi.F.hangNUM:PIGDownMenu_SetText(bagID.meihang)
		ContainerFrameCombinedBags.shezhi.F.suofang:PIGDownMenu_SetText(bagID.suofang)
	end)

	--离线背包================================
	local ADD_BagBankBGtex=addonTable.ADD_BagBankBGtex
	local lixianBAG=ADD_Frame("lixianBAG_UI",UIParent,400,200,"CENTER",UIParent,"CENTER",-200,200,true,false,true,true,true)
	lixianBAG:SetFrameLevel(110)
	lixianBAG:SetUserPlaced(false)
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
	------
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
	lixianBAG.biaoti.t:SetPoint("CENTER", lixianBAG.topbg, "CENTER", 4, 0);
	lixianBAG.biaoti.t:SetFontObject(GameFontNormal);

	lixianBAG.Close = CreateFrame("Button",nil,lixianBAG, "UIPanelCloseButton");
	lixianBAG.Close:SetSize(24,24);
	lixianBAG.Close:SetPoint("TOPRIGHT",lixianBAG,"TOPRIGHT",0,-10);

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
	--已装备物品================================
	local CzhuangbeiName = "lixianC_UI"
	local lixianC=ADD_Frame(CzhuangbeiName,UIParent,360,444,"CENTER",UIParent,"CENTER",-100, 100,true,false,true,true,true)
	lixianC:SetUserPlaced(false)
	lixianC:SetFrameLevel(130)
	local ADD_CharacterFrame=addonTable.ADD_CharacterFrame
	ADD_CharacterFrame(lixianC,CzhuangbeiName,360)

	---银行===============================
	BankSlotsFrame:HookScript("OnHide", function(self)
		self.fenlei.show=false
		PIGRotation(self.fenlei.Tex, -90)
	end);
	---系统银行可移动
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
	--分类设置
	for vb=7,13 do
		local fameXX = _G["ContainerFrame"..vb.."PortraitButton"]
		fameXX.ICONpig = fameXX:CreateTexture(nil, "BORDER");
		fameXX.ICONpig:SetTexture();
		fameXX.ICONpig:SetSize(28,28);
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
	BankSlotsFrame.fenlei = CreateFrame("Button",nil,BankSlotsFrame, "TruncatedButtonTemplate");
	BankSlotsFrame.fenlei:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	BankSlotsFrame.fenlei:SetSize(18,18);
	BankSlotsFrame.fenlei:SetPoint("TOPRIGHT",BankSlotsFrame,"TOPRIGHT",-20,-28);
	BankSlotsFrame.fenlei.Tex = BankSlotsFrame.fenlei:CreateTexture(nil, "BORDER");
	BankSlotsFrame.fenlei.Tex:SetTexture("interface/chatframe/chatframeexpandarrow.blp");
	PIGRotation(BankSlotsFrame.fenlei.Tex,-90)
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
			PIGRotation(self.Tex, -90)
			for vb=2,#bankID do
				local containerFrame, containerShowing = ContainerFrameUtil_GetShownFrameForID(bankID[vb]);
				if containerFrame then
					containerFrame.PortraitButton:Hide()
					containerFrame.FilterIcon:Hide()
				end
			end
		else
			BankSlotsFrame.fenlei.show=true
			PIGRotation(self.Tex, 90)
			local bagicon={BankSlotsFrame.Bag1.icon:GetTexture(),BankSlotsFrame.Bag2.icon:GetTexture(),BankSlotsFrame.Bag3.icon:GetTexture(),
			BankSlotsFrame.Bag4.icon:GetTexture(),BankSlotsFrame.Bag5.icon:GetTexture(),BankSlotsFrame.Bag6.icon:GetTexture(),BankSlotsFrame.Bag7.icon:GetTexture()}
			for vb=2,#bankID do
				local containerFrame, containerShowing = ContainerFrameUtil_GetShownFrameForID(bankID[vb]);
				if containerFrame then
					containerFrame.PortraitButton.ICONpig:SetTexture(bagicon[bankID[vb]-5]);
					containerFrame.PortraitButton:Show()
					for k,v in pairs(Enum.BagSlotFlags) do
						local isSet = C_Container.GetBagSlotFlag(bankID[vb], v)
						if isSet then
							containerFrame.FilterIcon:Show();
							break;
						end
					end
				end
			end
		end
	end);
	---离线银行
	local lixianBank=ADD_Frame("lixianBank_UI",UIParent,bankID.meihang*BagdangeW+16,210,"CENTER",UIParent,"CENTER",-300, 200,true,false,true,true,true)
	lixianBank:SetUserPlaced(false)
	lixianBank:SetFrameLevel(120)
	lixianBank.Close = CreateFrame("Button",nil,lixianBank, "UIPanelCloseButton");
	lixianBank.Close:SetSize(24,24);
	lixianBank.Close:SetPoint("TOPRIGHT",lixianBank,"TOPRIGHT",0,-10);
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

	lixianBank.biaoti = CreateFrame("Frame", nil, lixianBank)
	lixianBank.biaoti:SetPoint("TOPLEFT", lixianBank, "TOPLEFT",68, -12);
	lixianBank.biaoti:SetPoint("TOPRIGHT", lixianBank, "TOPRIGHT",-22, -12);
	lixianBank.biaoti:SetHeight(20);
	lixianBank.biaoti:EnableMouse(true)
	lixianBank.biaoti:RegisterForDrag("LeftButton")
	lixianBank.biaoti.t = lixianBank.biaoti:CreateFontString();
	lixianBank.biaoti.t:SetPoint("CENTER", lixianBank.biaoti, "CENTER", 8, -1);
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
	--
	lixianBank.wupin = CreateFrame("Frame", nil, lixianBank,"BackdropTemplate")
	lixianBank.wupin:SetBackdrop( { bgFile = "interface/framegeneral/ui-background-marble.blp" });
	lixianBank.wupin:SetPoint("TOPLEFT", lixianBank, "TOPLEFT",20, -68);
	lixianBank.wupin:SetPoint("BOTTOMRIGHT", lixianBank, "BOTTOMRIGHT", -8, 30);
	lixianBank.wupin:EnableMouse(true)
	for i=1,yinhangmorengezishu.banknum do
		lixianBank.wupin.item = CreateFrame("Button", "lixianBank_UI_wupin_item_"..i, lixianBank.wupin, "SecureActionButtonTemplate");
		lixianBank.wupin.item:SetHighlightTexture(130718);
		lixianBank.wupin.item:SetSize(BagdangeW-2,BagdangeW-2);
		if i==1 then
			lixianBank.wupin.item:SetPoint("TOPLEFT",lixianBank.wupin,"TOPLEFT",4,-2);
		else
			local yushu=math.fmod((i-1),bankID.meihang)
			if yushu==0 then
				lixianBank.wupin.item:SetPoint("TOPLEFT", _G["lixianBank_UI_wupin_item_"..(i-bankID.meihang)], "BOTTOMLEFT", 0, -4);
			else
				lixianBank.wupin.item:SetPoint("LEFT", _G["lixianBank_UI_wupin_item_"..(i-1)], "RIGHT", 4, 0);
			end
		end
		lixianBank.wupin.item:Hide();
		if PIG['zhegnheBAG']["wupinLV"] then
			lixianBank.wupin.item.LV = lixianBank.wupin.item:CreateFontString();
			lixianBank.wupin.item.LV:SetPoint("TOPRIGHT", lixianBank.wupin.item, "TOPRIGHT", 0,-1);
			lixianBank.wupin.item.LV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		end
		lixianBank.wupin.item.shuliang = lixianBank.wupin.item:CreateFontString();
		lixianBank.wupin.item.shuliang:SetPoint("BOTTOMRIGHT", lixianBank.wupin.item, "BOTTOMRIGHT", -4,2);
		lixianBank.wupin.item.shuliang:SetFontObject(TextStatusBarText);
	end
	---------------
	--BankFrame:RegisterEvent("BAG_UPDATE_DELAYED")
	BankFrame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
	BankFrame:HookScript("OnEvent", function (self,event,arg1)
		if event=="PLAYERBANKSLOTS_CHANGED" then
			C_Timer.After(0.4,SAVE_BANK)
			if PIG['zhegnheBAG']["wupinLV"] then
				shuaxinyinhangMOREN(arg1)
			end
			if PIG['zhegnheBAG']["wupinRanse"] then shuaxinyinhangMOREN_ranse(arg1) end
		end
		if event=="BAG_UPDATE_DELAYED" then
			if BankSlotsFrame:IsShown() then
				--CloseBankFrame();
				-- for i=2,#bankID do
				-- 	CloseBag(bankID[i])
				-- end
				-- for i=2,#bankID do
				-- 	OpenBag(bankID[i])
				-- end
			end
		end
		if event=="PLAYER_INTERACTION_MANAGER_FRAME_SHOW" then
			zhegnheBANK_Open()
			for i=2,#bankID do
				OpenBag(bankID[i])
			end
			C_Timer.After(0.4,SAVE_BANK)
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
	BankFrameTab1:HookScript("OnClick", function ()
		zhegnheBANK_Open()
		for i=2,#bankID do
			OpenBag(bankID[i])
		end
	end)
	BankFrameTab2:HookScript("OnClick", function ()
		for i=2,#bankID do
			CloseBag(bankID[i])
		end
	end)
	------
	hooksecurefunc("ContainerFrame_GenerateFrame", function(frame, size, id)
		if id>=bankID[2] then
			shuaxinBANKweizhi(frame, size, id)
		end
		if PIG['zhegnheBAG']["wupinLV"] then Bag_Item_lv(frame, size, id) end
		if PIG['zhegnheBAG']["wupinRanse"] then Bag_Item_Ranse(frame, size, id) end
	end)
	---
	local PIGCombinedBags = CreateFrame("Frame")
	PIGCombinedBags:RegisterEvent("PLAYER_ENTERING_WORLD");
	PIGCombinedBags:RegisterUnitEvent("UNIT_MODEL_CHANGED","player")
	PIGCombinedBags:RegisterEvent("AUCTION_HOUSE_SHOW")
	PIGCombinedBags:HookScript("OnEvent", function(self,event,arg1)
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
			if PIG['zhegnheBAG']["AHOpen"] then
				if(UnitExists("NPC"))then
					OpenAllBags()
				end
			end
		end
		if event=="UNIT_MODEL_CHANGED" then
			SAVE_C()
		end	
		if event=="BAG_UPDATE" then	
			if arg1>=bagID[1] and arg1<=bagID[#bagID] then
				C_Timer.After(0.5,SAVE_BAG)
				if ContainerFrame1Item1:IsVisible() then
					if PIG['zhegnheBAG']["wupinLV"] then Bag_Item_lv(nil, nil, arg1) end
					if PIG['zhegnheBAG']["wupinRanse"] then Bag_Item_Ranse(nil, nil, arg1) end
				end
			end
			if BankFrame:IsShown() then
				if arg1>=bankID[2] then
					C_Timer.After(0.5,SAVE_BANK)
					if PIG['zhegnheBAG']["wupinLV"] then Bag_Item_lv(nil, nil, arg1) end
					if PIG['zhegnheBAG']["wupinRanse"] then Bag_Item_Ranse(nil, nil, arg1) end
				end
			end
		end
	end)
	local function zhixingbaocunCMD()
		SAVE_BAG()
		PIGCombinedBags:RegisterEvent("BAG_UPDATE")
	end
	C_Timer.After(8,zhixingbaocunCMD)
end
--==========================================================
fuFrame.combinedBags=ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"启用背包整合(系统功能)","启用系统的背包整合功能")
fuFrame.combinedBags:SetScript("OnClick", function (self)
	if self:GetChecked() then
		SetCVar("combinedBags",1)
	else
		SetCVar("combinedBags",0)
	end
end);
fuFrame.beibaozhenghe=ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-60,"启用银行整合","整合银行包裹到一个界面")
fuFrame.beibaozhenghe:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['zhegnheBAG']["Open"]="ON";
		zhegnhe_Open()
	else
		PIG['zhegnheBAG']["Open"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--背包剩余-------------
local function gengxinbeibaoshengyugeshu()
	if MainMenuBarBackpackButton.freeSlots<10 then
		MainMenuBarBackpackButton.Count:SetTextColor(1, 0, 0, 1);
	else
		MainMenuBarBackpackButton.Count:SetTextColor(0, 1, 0, 1);
	end
end
local function bigfontziti()
	if PIG["zhegnheBAG"]['BAGkongyu']=="ON" then
		SetCVar("displayFreeBagSlots", "1")
		MainMenuBarBackpackButton.Count:Show()
		MainMenuBarBackpackButton.Count:SetFont(ChatFontNormal:GetFont(), 18, "OUTLINE");
		gengxinbeibaoshengyugeshu()
	else
		SetCVar("displayFreeBagSlots", "0")
		MainMenuBarBackpackButton.Count:Hide()
	end
end
----
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
fuFrame.BAGkongyu=ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-100,"显示背包剩余空间","在行囊显示背包剩余空间(大于等于10显示绿色,小于10显示红色)")
fuFrame.BAGkongyu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['zhegnheBAG']['BAGkongyu']="ON";	
	else
		PIG['zhegnheBAG']['BAGkongyu']="OFF";
	end
	bigfontziti()
end);
fuFrame:HookScript("OnShow", function(self)
	if GetCVar("combinedBags")=="1" then
		fuFrame.combinedBags:SetChecked(true)
	end
	if PIG['zhegnheBAG']["Open"]=="ON" then
		fuFrame.beibaozhenghe:SetChecked(true)
	end
	--
	if PIG['zhegnheBAG']['BAGkongyu']=="ON" then
		fuFrame.BAGkongyu:SetChecked(true);
	end
end);
--加载设置---------------
addonTable.BagBank = function()
	local Pname = UnitFullName("player");
	local _, englishClass= UnitClass("player");
	PIG_renwuming=Pname.."-"..GetRealmName()
	if PIG['zhegnheBAG']["Open"]=="ON" then
		bagID.meihang=PIG['zhegnheBAG']["BAGmeihangshu_retail"] or bagID.meihang
		bagID.suofang=PIG['zhegnheBAG']["BAGsuofangBili"] or bagID.suofang
		zhegnhe_Open()
	end
end