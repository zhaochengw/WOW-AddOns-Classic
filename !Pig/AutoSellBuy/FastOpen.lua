local _, addonTable = ...;
--=============================
local hang_Height,hang_NUM  = 30, 14;
local FrameLevel=addonTable.SellBuyFrameLevel
----//////////////////
local function OKEY_OPEN(arg1)
	local shujuy =PIG["AutoSellBuy"]["Openlist"]
	local xx=GetContainerNumSlots(arg1)
	for k=1,xx do	
		local texture, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(arg1, k);
		if lootable then
			for i=1,#shujuy do
				if itemID==shujuy[i][3] then
					UseContainerItem(arg1, k)
				end
			end
		end
	end
end
function Pig_OpenItem()
	for i=1,5 do
		OKEY_OPEN(i-1)
	end	
end
local function Open_ADD()
	PIG["AutoSellBuy"]["Openlist"]=PIG["AutoSellBuy"]["Openlist"] or addonTable.Default["AutoSellBuy"]["Openlist"]
	local fuFrame = SpllBuy_TabFrame_4
	local Width = fuFrame:GetWidth()-20;
	--滚动框架
	fuFrame.Open = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
	fuFrame.Open:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 14,insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	fuFrame.Open:SetSize(Width, hang_Height*14+10)
	fuFrame.Open:SetPoint("BOTTOM", fuFrame, "BOTTOM", 0, 10)
	fuFrame.Open:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.5);
	fuFrame.Open.biaoti = fuFrame.Open:CreateFontString();
	fuFrame.Open.biaoti:SetPoint("BOTTOM", fuFrame.Open, "TOP", 0, -0);
	fuFrame.Open.biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.Open.biaoti:SetText("\124cffFFFF00开启目录\124r\124cff00FF00(拖拽物品到此)\124r");
	
	fuFrame.Open.daochu = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");
	fuFrame.Open.daochu:SetSize(50,20);
	fuFrame.Open.daochu:SetPoint("LEFT",fuFrame.Open.biaoti,"RIGHT",0,0);
	fuFrame.Open.daochu:SetText("导出");
	local Config_daochu_UP=addonTable.Config_daochu_UP
	fuFrame.Open.daochu:SetScript("OnClick", function(self, button)
		Config_daochu_UP(self,PIG.AutoSellBuy.Openlist)
	end)

	fuFrame.Open.daochu = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");
	fuFrame.Open.daochu:SetSize(50,20);
	fuFrame.Open.daochu:SetPoint("RIGHT",fuFrame.Open.biaoti,"LEFT",0,0);
	fuFrame.Open.daochu:SetText("导入");
	local Config_daoru_UP=addonTable.Config_daoru_UP
	fuFrame.Open.daochu:SetScript("OnClick", function(self, button)
		Config_daoru_UP(self,"PIG","AutoSellBuy~Openlist")
	end)
	-- --滚动更新
	local function gengxinDEL(self)
		for id = 1, hang_NUM do
			_G["Open_hang"..id].item.icon:SetTexture();
			_G["Open_hang"..id].item.link:SetText();
			_G["Open_hang"..id].item:Hide();
			_G["Open_hang"..id].del:Hide();
	    end
	    local shujuy =PIG["AutoSellBuy"]["Openlist"]
		if #shujuy>0 then
		    local ItemsNum = #shujuy;
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
		    local offset = FauxScrollFrame_GetOffset(self);
		    for id = 1, hang_NUM do
		    	local dangqianH = id+offset;
		    	if shujuy[dangqianH] then
			    	_G["Open_hang"..id].item.icon:SetTexture(shujuy[dangqianH][1]);
					_G["Open_hang"..id].item.link:SetText(shujuy[dangqianH][2]);
					_G["Open_hang"..id].item:Show();
					_G["Open_hang"..id].item:SetScript("OnMouseDown", function (self)
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
						GameTooltip:SetHyperlink(shujuy[dangqianH][2])
					end);
					_G["Open_hang"..id].item:SetScript("OnMouseUp", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
					_G["Open_hang"..id].del:Show();
					_G["Open_hang"..id].del:SetID(dangqianH);
				end
			end
		end
	end

	----创建可滚动区域
	fuFrame.Open.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.Open, "FauxScrollFrameTemplate");  
	fuFrame.Open.Scroll:SetPoint("TOPLEFT",fuFrame.Open,"TOPLEFT",0,-5);
	fuFrame.Open.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.Open,"BOTTOMRIGHT",-27,5);
	fuFrame.Open.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinDEL)
	end)
	--创建行
	for id = 1, hang_NUM do
		local Open = CreateFrame("Frame", "Open_hang"..id, fuFrame.Open);
		Open:SetSize(Width-36, hang_Height);
		if id==1 then
			Open:SetPoint("TOP",fuFrame.Open.Scroll,"TOP",0,0);
		else
			Open:SetPoint("TOP",_G["Open_hang"..(id-1)],"BOTTOM",0,-0);
		end
		if id~=hang_NUM then
			Open.line = Open:CreateLine()
			Open.line:SetColorTexture(1,1,1,0.2)
			Open.line:SetThickness(1);
			Open.line:SetStartPoint("BOTTOMLEFT",0,0)
			Open.line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		Open.item = CreateFrame("Frame", nil, Open);
		Open.item:SetSize(Width-70,hang_Height);
		Open.item:SetPoint("LEFT",Open,"LEFT",hang_Height,0);
		Open.item.icon = Open.item:CreateTexture(nil, "BORDER");
		Open.item.icon:SetSize(26,26);
		Open.item.icon:SetPoint("LEFT", Open.item, "LEFT", 0,0);
		Open.item.link = Open.item:CreateFontString();
		Open.item.link:SetPoint("LEFT", Open.item, "LEFT", 30,0);
		Open.item.link:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");

		Open.del = CreateFrame("Button",nil,Open, "TruncatedButtonTemplate");
		Open.del:SetSize(hang_Height,hang_Height);
		Open.del:SetPoint("LEFT", Open, "LEFT", 0,0);
		Open.del.Tex = Open.del:CreateTexture(nil, "BORDER");
		Open.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		Open.del.Tex:SetPoint("CENTER");
		Open.del.Tex:SetSize(13,13);
		Open.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1.5,-1.5);
		end);
		Open.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		Open.del:SetScript("OnClick", function (self)
			table.remove(PIG["AutoSellBuy"]["Openlist"], self:GetID());
			gengxinDEL(fuFrame.Open.Scroll);
		end);
	end
	-- ----
	fuFrame.Open.ADD = CreateFrame("Frame",nil,fuFrame.Open);  
	fuFrame.Open.ADD:SetPoint("TOPLEFT",fuFrame.Open,"TOPLEFT",0,0);
	fuFrame.Open.ADD:SetPoint("BOTTOMRIGHT",fuFrame.Open,"BOTTOMRIGHT",-0,0);
	---
	fuFrame.Open:RegisterEvent("ITEM_LOCK_CHANGED");
	fuFrame.Open.ADD.iteminfo={};
	fuFrame.Open:SetScript("OnEvent",function (self,event,arg1,arg2)
		if arg1 and arg2 then
			if CursorHasItem() then
				local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(arg1,arg2);
				fuFrame.Open.ADD.iteminfo={icon, itemLink, itemID};
				fuFrame.Open.ADD:SetFrameLevel(FrameLevel+8);
			end
		end
	end);
	fuFrame.Open.ADD:SetScript("OnMouseUp", function ()
		if CursorHasItem() then
			local shujuy =PIG["AutoSellBuy"]["Openlist"]
			for i=1,#shujuy do
				if fuFrame.Open.ADD.iteminfo[3]==shujuy[i][3] then
					print("|cff00FFFF!Pig:|r|cffffFF00物品已在目录内！|r");
					ClearCursor();
					fuFrame.Open.ADD.iteminfo={};
					fuFrame.Open.ADD:SetFrameLevel(FrameLevel);
					return
				end			
			end
			table.insert(shujuy, fuFrame.Open.ADD.iteminfo);
			ClearCursor();
			fuFrame.Open.ADD.iteminfo={};
			gengxinDEL(fuFrame.Open.Scroll);
		end
		fuFrame.Open.ADD:SetFrameLevel(FrameLevel);
	end);
	fuFrame.Open:SetScript("OnShow", function()
		gengxinDEL(fuFrame.Open.Scroll);
	end)
	----
	local zidongOpenXXXX = CreateFrame("Frame");
	zidongOpenXXXX:SetScript("OnEvent", function(self,event,arg1)
		if PIG['AutoSellBuy']['zidongKaiqi']=="ON" then
			if arg1>=0 and arg1<5 then
				OKEY_OPEN(arg1)
			end
		end
	end);

	fuFrame.zidongKaiqi = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
	fuFrame.zidongKaiqi:SetSize(28,30);
	fuFrame.zidongKaiqi:SetHitRectInsets(0,-72,0,0);
	fuFrame.zidongKaiqi:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-10);
	fuFrame.zidongKaiqi.Text:SetText("自动打开");
	fuFrame.zidongKaiqi.tooltip = "启用后将自动打开目录内可开启物品（例如：箱/盒/袋/蚌壳）!|r";
	fuFrame.zidongKaiqi:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['AutoSellBuy']['zidongKaiqi']="ON";
		else
			PIG['AutoSellBuy']['zidongKaiqi']="OFF";
		end
	end);
	----
	StaticPopupDialogs["FUZHICMD_OPEN"] = {
		text = "新建一个宏并复制指令到宏内，拖动到技能条使用。\n或者复制到已有的宏尾部。这样在使用宏时将执行一次动作",
		button1 = "知道了",
		OnAccept = function()
			editBoxXX = ChatEdit_ChooseBoxForSend()
			ChatEdit_ActivateChat(editBoxXX)
			editBoxXX:Insert("/run Pig_OpenItem()")
			editBoxXX:HighlightText()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	fuFrame.CopyCMD = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");
	fuFrame.CopyCMD:SetSize(110,22);
	fuFrame.CopyCMD:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",160,-10);
	fuFrame.CopyCMD:SetText("复制打开指令");
	fuFrame.CopyCMD:SetScript("OnClick", function(event, button)
		StaticPopup_Show ("FUZHICMD_OPEN");
	end)
	---
	fuFrame.yijiandakai = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");
	fuFrame.yijiandakai:SetSize(100,22);
	fuFrame.yijiandakai:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",100,-40);
	fuFrame.yijiandakai:SetText("手动开启");
	fuFrame.yijiandakai:SetScript("OnClick", function(event, button)
		for i=1,5 do
			OKEY_OPEN(i-1)
		end	
	end)
	----
	if PIG['AutoSellBuy']['zidongKaiqi']=="ON" then
		fuFrame.zidongKaiqi:SetChecked(true);
		local function zhuceopenshijian()
			zidongOpenXXXX:RegisterEvent("BAG_UPDATE");
		end
		C_Timer.After(4,zhuceopenshijian)
	end
end
-- --==============================
addonTable.Open_ADD = Open_ADD