local _, addonTable = ...;
local fuFrame=List_R_F_2_2
local ADD_Checkbutton=addonTable.ADD_Checkbutton
----------------------------------
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
	if AuctionHouseFrame.History then return end
	local FWQrealm = GetRealmName()
	PIG.AHPlus.Data[FWQrealm]=PIG.AHPlus.Data[FWQrealm] or {}
	---缓存
	AuctionHouseFrame.History = CreateFrame("Button",nil,AuctionHouseFrame, "UIPanelButtonTemplate");
	AuctionHouseFrame.History:SetSize(120,18);
	AuctionHouseFrame.History:SetPoint("TOPRIGHT",AuctionHouseFrame,"TOPRIGHT",-100,-2);
	AuctionHouseFrame.History:SetText("缓存价格");
	AuctionHouseFrame.History:SetFrameLevel(510)
	---
	AuctionHouseFrame.huancunUI = CreateFrame("Frame", nil, AuctionHouseFrame,"BackdropTemplate");
	local HCUI = AuctionHouseFrame.huancunUI
	HCUI:SetBackdrop( { 
		bgFile = "interface/characterframe/ui-party-background.blp",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 13,});
	HCUI:SetBackdropBorderColor(0, 1, 1, 0.9);
	HCUI:SetPoint("TOPLEFT",AuctionHouseFrame,"TOPLEFT",4,-22);
	HCUI:SetPoint("BOTTOMRIGHT",AuctionHouseFrame,"BOTTOMRIGHT",-4,28);
	HCUI:SetFrameLevel(520)
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
	HCUI.jindu.edg.t:SetText("正在扫描数据...");
	----
	local huancunjiaqian = CreateFrame("Frame")
	huancunjiaqian:Hide()
	huancunjiaqian.SMend=false
	local chushikuandu=jinduW-6

	local AHlinshiInfoList = {}
	local function Save_Data()
		local shujuyuan = PIG.AHPlus.Data[FWQrealm]
		for _,v in pairs(shujuyuan) do
			v[2]=false
		end
		for i=1,#AHlinshiInfoList do
			--print(AHlinshiInfoList[i][1])
			local nameID=AHlinshiInfoList[i][17]
			local xianzaidanjia = AHlinshiInfoList[i][10]/AHlinshiInfoList[i][3]
	   		if PIG.AHPlus.Data[FWQrealm][nameID] then
	   			if PIG.AHPlus.Data[FWQrealm][nameID][2] then
	   				if xianzaidanjia>0 and xianzaidanjia<PIG.AHPlus.Data[FWQrealm][nameID][1] then
	   					PIG.AHPlus.Data[FWQrealm][nameID][1]=xianzaidanjia
	   				end
	   			else
	   				PIG.AHPlus.Data[FWQrealm][nameID]={xianzaidanjia,true,GetServerTime()}
	   			end
	   		else
	   			PIG.AHPlus.Data[FWQrealm][nameID]={xianzaidanjia,true,GetServerTime()}
	   		end
		end
		--
		HCUI.jindu.edg.t:SetText("价格缓存完毕(总数"..(#AHlinshiInfoList+1)..")");
		HCUI.close:Show();
	end

	local function huancunData()
		AHlinshiInfoList = {}
		local continuables = {}
		wipe(AHlinshiInfoList)
		local zongshuVB = C_AuctionHouse.GetNumReplicateItems()
		local jishuID=0
		for i = 0, zongshuVB-1 do
			AHlinshiInfoList[i] = {C_AuctionHouse.GetReplicateItemInfo(i)}
			if not AHlinshiInfoList[i][18] then -- hasAllInfo
				local item = Item:CreateFromItemID(AHlinshiInfoList[i][17]) -- itemID
				continuables[item] = true
				item:ContinueOnItemLoad(function()
					AHlinshiInfoList[i] = {C_AuctionHouse.GetReplicateItemInfo(i)}
					continuables[item] = nil
					jishuID = jishuID+1
					HCUI.jindu.edg.t:SetText("正在缓存价格("..jishuID.."/"..zongshuVB..")");
					HCUI.jindu.tex:SetWidth(chushikuandu*(jishuID/zongshuVB))
					if not next(continuables) then
						Save_Data()
					end
				end)
			else
				jishuID = jishuID+1
				HCUI.jindu.edg.t:SetText("正在缓存价格("..jishuID.."/"..zongshuVB..")");
				HCUI.jindu.tex:SetWidth(chushikuandu*(jishuID/zongshuVB))
			end
		end
	end

	huancunjiaqian:HookScript("OnUpdate",function(self,sss)
		if self.SMend then
			self:Hide()
			HCUI.jindu.edg.t:SetText("数据扫描完毕,开始缓存...");
			HCUI.jindu.tex:SetWidth(0)
			huancunData()
		else
			local AuctionsNum = C_AuctionHouse.GetNumReplicateItems()
			HCUI.jindu.edg.t:SetText("正在扫描数据("..AuctionsNum.."/"..AuctionsNum..")");
			--HCUI.jindu.tex:SetWidth(chushikuandu*(AuctionsNum/AuctionsNum*1.5))
		end
	end)
	huancunjiaqian:RegisterEvent("REPLICATE_ITEM_LIST_UPDATE")
	huancunjiaqian:HookScript("OnEvent",function(self,event)
		if event == "REPLICATE_ITEM_LIST_UPDATE" then
			if not self.SMend then
				self.SMend=true
			end
		end
	end)
	AuctionHouseFrame.History:HookScript("OnUpdate", function(self)
		local daojishitt = 900-(GetServerTime()-PIG.AHPlus.DaojiTime)
		if daojishitt<0 then
			self:Enable()
			self:SetText("缓存价格");
		else
			self:SetText("缓存价格("..daojishitt..")");
			self:Disable()
		end
	end)
	AuctionHouseFrame.History:HookScript("OnClick", function(self, button)
		self:Disable()
		HCUI:Show();
		HCUI.close:Hide();
		HCUI.jindu.edg.t:SetText("正在扫描数据...");
		HCUI.jindu.tex:SetWidth(0)
		C_AuctionHouse.ReplicateItems()
		PIG.AHPlus.DaojiTime=GetServerTime()
		huancunjiaqian:Show()
		huancunjiaqian.SMend=false
	end)
	---------------------
	for i = 1, 33 do
		local huizhangG = AuctionHouseFrame.WoWTokenResults:CreateFontString("huizhangG_"..i);
		if i==1 then
			huizhangG:SetPoint("TOPLEFT",AuctionHouseFrame.WoWTokenResults,"TOPLEFT",6,-8);
		elseif i==4 then
			huizhangG:SetPoint("TOPLEFT",AuctionHouseFrame.WoWTokenResults,"TOPLEFT",6,-150);
		elseif i==19 then
			huizhangG:SetPoint("TOPRIGHT",AuctionHouseFrame.WoWTokenResults,"TOPRIGHT",-6,-150);
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
	AuctionHouseFrame.WoWTokenResults:HookScript("OnShow",function(self)
		huoquhuizhangjiageG()
		Update_huizhangG()
	end)
	AuctionHouseFrame:HookScript("OnShow",function(self)
		huoquhuizhangjiageG()
		huancunjiaqian:Hide()
		HCUI:Hide();
		HCUI.close:Hide();
	end)
end
--
local AuctionFramejiazai = CreateFrame("FRAME")
AuctionFramejiazai:SetScript("OnEvent", function(self, event, arg1)
	if PIG.AHPlus.Open then
		if arg1 == "Blizzard_AuctionHouseUI" then
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
		if IsAddOnLoaded("Blizzard_AuctionHouseUI") then
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
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
	if PIG.AHPlus.Open and PIG.AHPlus.AHtooltip then
		if tooltip == GameTooltip then	
			local ItemID = data["id"]
			if ItemID then
				local  bubangding = select(14, GetItemInfo(ItemID))--非绑定
				if bindType~=1 then
					local FWQrealm = GetRealmName()
					if PIG.AHPlus.Data[FWQrealm] and PIG.AHPlus.Data[FWQrealm][ItemID] then
						local jiluTime = PIG.AHPlus.Data[FWQrealm][ItemID][3] or 1660000000
						local jiluTime = date("%m-%d %H:%M",jiluTime)
						tooltip:AddDoubleLine("拍卖单价("..jiluTime.."):",GetMoneyString(PIG.AHPlus.Data[FWQrealm][ItemID][1]))
					else
						tooltip:AddDoubleLine("拍卖单价(尚未缓存):","--")
					end
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
		AuctionFramejiazai:RegisterEvent("ADDON_LOADED")
	end
end