local _, addonTable = ...;
--=============================
local hang_Height,hang_NUM  = 30, 14;
----//////////////////
function Pig_DelItem()
	if AutoSellBuy_but then
		AutoSellBuy_but.Height:Hide();
	end
	if #PIG["FastDiuqi"]>0 then
		for i=0,4 do
			local xx=GetContainerNumSlots(i) 
			for j=1,xx do
				for k=1,#PIG["FastDiuqi"] do
					if GetContainerItemID(i,j)==PIG["FastDiuqi"][k][3] then
						PickupContainerItem(i,j);
						DeleteCursorItem(i,j);
					end
				end
			end 
		end
	end
end
local function DelItem()
	if #PIG["FastDiuqi"]==0 then
		print("\124cff00FFFF!Pig（一键丢弃）：\124cffffFF00丢弃目录为空，右键打开设置添加物品！\124r");
		return
	end
	Pig_DelItem()
end
addonTable.FastDiuqi_DelItem = DelItem
-------
local function FastDiuqi_ADD()
	local frameX = SpllBuy_TabFrame_1
	local Width = frameX:GetWidth()-20;
	--滚动框架
	frameX.FastDiuqi = CreateFrame("Frame", nil, frameX,"BackdropTemplate")
	frameX.FastDiuqi:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 14,insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	frameX.FastDiuqi:SetSize(Width, hang_Height*hang_NUM+10)
	frameX.FastDiuqi:SetPoint("BOTTOM", frameX, "BOTTOM", 0, 10)
	frameX.FastDiuqi:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.5);
	frameX.FastDiuqi.biaoti = frameX.FastDiuqi:CreateFontString();
	frameX.FastDiuqi.biaoti:SetPoint("BOTTOM", frameX.FastDiuqi, "TOP", 0, -0);
	frameX.FastDiuqi.biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	frameX.FastDiuqi.biaoti:SetText("\124cffFFFF00丢弃目录\124r\124cff00FF00(拖拽物品到此)\124r");
	-- --滚动更新
	local function gengxinDEL(self)
		for id = 1, hang_NUM do
			_G["DelH_hang"..id].item.icon:SetTexture();
			_G["DelH_hang"..id].item.link:SetText();
			_G["DelH_hang"..id].item:Hide();
			_G["DelH_hang"..id].del:Hide();
	    end
		if #PIG["FastDiuqi"]>0 then
		    local ItemsNum = #PIG["FastDiuqi"];
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
		    local offset = FauxScrollFrame_GetOffset(self);
		    for id = 1, hang_NUM do
		    	local dangqianH = id+offset;
		    	if PIG["FastDiuqi"][dangqianH] then
			    	_G["DelH_hang"..id].item.icon:SetTexture(PIG["FastDiuqi"][dangqianH][1]);
					_G["DelH_hang"..id].item.link:SetText(PIG["FastDiuqi"][dangqianH][2]);
					_G["DelH_hang"..id].item:Show();
					_G["DelH_hang"..id].item:SetScript("OnMouseDown", function (self)
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
						GameTooltip:SetHyperlink(PIG["FastDiuqi"][dangqianH][2])
					end);
					_G["DelH_hang"..id].item:SetScript("OnMouseUp", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
					_G["DelH_hang"..id].del:Show();
					_G["DelH_hang"..id].del:SetID(dangqianH);
				end
			end
		end
	end

	----创建可滚动区域
	frameX.FastDiuqi.Scroll = CreateFrame("ScrollFrame",nil,frameX.FastDiuqi, "FauxScrollFrameTemplate");  
	frameX.FastDiuqi.Scroll:SetPoint("TOPLEFT",frameX.FastDiuqi,"TOPLEFT",0,-5);
	frameX.FastDiuqi.Scroll:SetPoint("BOTTOMRIGHT",frameX.FastDiuqi,"BOTTOMRIGHT",-27,5);
	frameX.FastDiuqi.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinDEL)
	end)
	--创建行
	for id = 1, hang_NUM do
		local DelH = CreateFrame("Frame", "DelH_hang"..id, frameX.FastDiuqi);
		DelH:SetSize(Width-36, hang_Height);
		if id==1 then
			DelH:SetPoint("TOP",frameX.FastDiuqi.Scroll,"TOP",0,0);
		else
			DelH:SetPoint("TOP",_G["DelH_hang"..(id-1)],"BOTTOM",0,-0);
		end
		if id~=hang_NUM then
			DelH.line = DelH:CreateLine()
			DelH.line:SetColorTexture(1,1,1,0.2)
			DelH.line:SetThickness(1);
			DelH.line:SetStartPoint("BOTTOMLEFT",0,0)
			DelH.line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		DelH.item = CreateFrame("Frame", nil, DelH);
		DelH.item:SetSize(Width-70,hang_Height);
		DelH.item:SetPoint("LEFT",DelH,"LEFT",hang_Height,0);
		DelH.item.icon = DelH.item:CreateTexture(nil, "BORDER");
		DelH.item.icon:SetSize(26,26);
		DelH.item.icon:SetPoint("LEFT", DelH.item, "LEFT", 0,0);
		DelH.item.link = DelH.item:CreateFontString();
		DelH.item.link:SetPoint("LEFT", DelH.item, "LEFT", 30,0);
		DelH.item.link:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");

		DelH.del = CreateFrame("Button",nil,DelH, "TruncatedButtonTemplate");
		DelH.del:SetSize(hang_Height,hang_Height);
		DelH.del:SetPoint("LEFT", DelH, "LEFT", 0,0);
		DelH.del.Tex = DelH.del:CreateTexture(nil, "BORDER");
		DelH.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		DelH.del.Tex:SetPoint("CENTER");
		DelH.del.Tex:SetSize(13,13);
		DelH.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1.5,-1.5);
		end);
		DelH.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		DelH.del:SetScript("OnClick", function (self)
			table.remove(PIG["FastDiuqi"], self:GetID());
			gengxinDEL(frameX.FastDiuqi.Scroll);
		end);
	end
	-- ----
	frameX.FastDiuqi.ADD = CreateFrame("Frame",nil,frameX.FastDiuqi);  
	frameX.FastDiuqi.ADD:SetPoint("TOPLEFT",frameX.FastDiuqi,"TOPLEFT",0,0);
	frameX.FastDiuqi.ADD:SetPoint("BOTTOMRIGHT",frameX.FastDiuqi,"BOTTOMRIGHT",-0,0);
	---
	frameX.FastDiuqi:RegisterEvent("ITEM_LOCK_CHANGED");
	frameX.FastDiuqi.ADD.iteminfo={};
	frameX.FastDiuqi:SetScript("OnEvent",function (self,event,arg1,arg2)
		if arg1 and arg2 then
			if CursorHasItem() then
				local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(arg1,arg2);
				frameX.FastDiuqi.ADD.iteminfo={icon, itemLink, itemID};
				frameX.FastDiuqi.ADD:SetFrameLevel(48);
			end
		end
	end);
	frameX.FastDiuqi.ADD:SetScript("OnMouseUp", function ()
		if CursorHasItem() then
			for i=1,#PIG["FastDiuqi"] do
				if frameX.FastDiuqi.ADD.iteminfo[3]==PIG["FastDiuqi"][i][3] then
					print("|cff00FFFF!Pig:|r|cffffFF00物品已在目录内！|r");
					ClearCursor();
					frameX.FastDiuqi.ADD.iteminfo={};
					frameX.FastDiuqi.ADD:SetFrameLevel(40);
					return
				end			
			end
			table.insert(PIG["FastDiuqi"], frameX.FastDiuqi.ADD.iteminfo);
			ClearCursor();
			frameX.FastDiuqi.ADD.iteminfo={};
			gengxinDEL(frameX.FastDiuqi.Scroll);
		end
		frameX.FastDiuqi.ADD:SetFrameLevel(40);
	end);
	frameX.FastDiuqi:SetScript("OnShow", function()
		gengxinDEL(frameX.FastDiuqi.Scroll);
	end)

	--需要开锁技能打开的物品
	local xukaisuo = {4632,4633,4634,4636,4637,4638,5758,5759,5760,6354,6355,6712,12033,13875,13918,16882,16883,16884,16885,29569,31952};
	local zidongkaishidiuqiFFF = CreateFrame("Frame");
	zidongkaishidiuqiFFF:RegisterEvent("BAG_UPDATE");
	zidongkaishidiuqiFFF:SetScript("OnEvent", function(self,event,arg1)
		if PIG['AutoSellBuy']['diuqitishi']=="ON" then
			local bnum=GetContainerNumSlots(arg1)
			for l=1,bnum do
				for kk=1,#PIG["FastDiuqi"] do
					if GetContainerItemID(arg1,l)==PIG["FastDiuqi"][kk][3] then
						if AutoSellBuy_but then
							AutoSellBuy_but.Height:Show();
						end
					end
				end
			end	
		end
	end);


	----
	frameX.tishidiuqi = CreateFrame("CheckButton", nil, frameX, "ChatConfigCheckButtonTemplate");
	frameX.tishidiuqi:SetSize(28,30);
	frameX.tishidiuqi:SetHitRectInsets(0,-68,0,0);
	frameX.tishidiuqi:SetPoint("TOPLEFT",frameX,"TOPLEFT",20,-10);
	frameX.tishidiuqi.Text:SetText("提示丢弃");
	frameX.tishidiuqi.tooltip = "有可丢弃物品将会在快捷按钮提示!|r";
	frameX.tishidiuqi:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['AutoSellBuy']['diuqitishi']="ON";
		else
			PIG['AutoSellBuy']['diuqitishi']="OFF";
		end
	end);
	---
	StaticPopupDialogs["FUZHIXIAOHUIZHILING"] = {
		text = "因TBC暴雪API改动，无法自动销毁，请复制销毁指令到吃喝宏，或其技能宏尾部。这样在吃喝时或使用技能宏时将执行一次销毁动作",
		button1 = "知道了",
		OnAccept = function()
			editBoxXX = ChatEdit_ChooseBoxForSend()
			ChatEdit_ActivateChat(editBoxXX)
			editBoxXX:Insert("/run Pig_DelItem()")
			editBoxXX:HighlightText()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	frameX.zidongDiuqi = CreateFrame("Button",nil,frameX, "UIPanelButtonTemplate");
	frameX.zidongDiuqi:SetSize(110,22);
	frameX.zidongDiuqi:SetPoint("TOPLEFT",frameX,"TOPLEFT",160,-10);
	frameX.zidongDiuqi:SetText("复制销毁指令");
	frameX.zidongDiuqi:SetScript("OnClick", function(event, button)
		StaticPopup_Show ("FUZHIXIAOHUIZHILING");
	end)
	-----
	if PIG['AutoSellBuy']['diuqitishi']=="ON" then
		frameX.tishidiuqi:SetChecked(true);
	end
end
--==============================
addonTable.FastDiuqi = FastDiuqi_ADD