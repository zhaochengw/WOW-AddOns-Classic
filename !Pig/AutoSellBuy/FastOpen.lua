local _, addonTable = ...;
--=============================
local hang_Height,hang_NUM  = 30, 14;
local FrameLevel=addonTable.SellBuyFrameLevel
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local _, _, _, tocversion = GetBuildInfo()
----//////////////////
local function FastOpen()
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
	-----
	local function Open_Tishi()
		if QkBut_AutoSellBuy_Open then
			if PIG['AutoSellBuy']['zidongKaiqi']=="ON" then
				if tocversion<100000 then
					for bag=0,4 do
						local bnum=GetContainerNumSlots(bag)
						for l=1,bnum do
							for kk=1,#PIG["AutoSellBuy"]["Openlist"] do
								if GetContainerItemLink(bag,l)==PIG["AutoSellBuy"]["Openlist"][kk][2] then
									QkBut_AutoSellBuy_Open.Height:Show();
									return
								end
							end
						end
					end
				else
					for bag=0,4 do
						local bnum=C_Container.GetContainerNumSlots(bag)
						for l=1,bnum do
							for kk=1,#PIG["AutoSellBuy"]["Openlist"] do
								if C_Container.GetContainerItemLink(bag,l)==PIG["AutoSellBuy"]["Openlist"][kk][2] then
									QkBut_AutoSellBuy_Open.Height:Show();
									return
								end
							end
						end
					end
				end
				QkBut_AutoSellBuy_Open.Height:Hide();
			else
				QkBut_AutoSellBuy_Open.Height:Hide();
			end
		end
	end
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
			Open_Tishi()
		end);
	end
	-- ----
	fuFrame.Open.ADD = CreateFrame("Frame",nil,fuFrame.Open);  
	fuFrame.Open.ADD:SetPoint("TOPLEFT",fuFrame.Open,"TOPLEFT",0,0);
	fuFrame.Open.ADD:SetPoint("BOTTOMRIGHT",fuFrame.Open,"BOTTOMRIGHT",-0,0);
	---
	fuFrame.Open:RegisterEvent("ITEM_LOCK_CHANGED");
	fuFrame.Open:SetScript("OnEvent",function (self)
		if self:IsShown() then
			self.ADD:SetFrameLevel(FrameLevel+8);
		end
	end);
	fuFrame.Open.ADD:SetScript("OnMouseUp", function (self)
		if CursorHasItem() then
			local NewType, TtemID, Itemlink= GetCursorInfo()
			for i=1,#PIG["AutoSellBuy"]["Openlist"] do
				if Itemlink==PIG["AutoSellBuy"]["Openlist"][i][2] then
					print("|cff00FFFF!Pig:|r|cffffFF00物品已在目录内！|r");
					ClearCursor();
					self:SetFrameLevel(FrameLevel);
					return
				end			
			end
			local icon = select(5,GetItemInfoInstant(Itemlink))
			table.insert(PIG["AutoSellBuy"]["Openlist"], {icon,Itemlink,TtemID});
			ClearCursor();
			gengxinDEL(fuFrame.Open.Scroll);
			Open_Tishi()
		end
		self:SetFrameLevel(FrameLevel);
	end);
	fuFrame.Open:SetScript("OnShow", function()
		gengxinDEL(fuFrame.Open.Scroll);
	end)

	--===================
	local xukaisuo = {4632,4633,4634,4636,4637,4638,5758,5759,5760,6354,6355,6712,12033,13875,13918,16882,16883,16884,16885,29569,31952};
	local zidongOpenXXXX = CreateFrame("Frame");
	zidongOpenXXXX:SetScript("OnEvent", function(self,event,arg1)
		Open_Tishi()
	end);

	fuFrame.zidongKaiqi = ADD_Checkbutton(nil,fuFrame,-68,"TOPLEFT",fuFrame,"TOPLEFT",20,-10,"提示打开", "有可打开物品（例如：箱/盒/袋/蚌壳）将会在快捷按钮提示")
	fuFrame.zidongKaiqi:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG['AutoSellBuy']['zidongKaiqi']="ON";
			zidongOpenXXXX:RegisterEvent("BAG_UPDATE");
		else
			PIG['AutoSellBuy']['zidongKaiqi']="OFF";
			zidongOpenXXXX:UnregisterEvent("BAG_UPDATE");
		end
		Open_Tishi()
	end);

	---
	local function Open_Item(self)
		if InCombatLockdown() then
			PIG_print("请在脱战后使用")
		else
			local shujuy =PIG["AutoSellBuy"]["Openlist"]
			if #shujuy>0 then
				if tocversion<100000 then
					for arg1=0,4 do			
						local xx=GetContainerNumSlots(arg1)
						for k=1,xx do	
							local itemLink = GetContainerItemLink(arg1, k);
							for i=1,#shujuy do
								if itemLink==shujuy[i][2] then		
									self:SetAttribute("item", itemLink)
									return
								end
							end
						end
					end
				else
					for arg1=0,4 do			
						local xx=C_Container.GetContainerNumSlots(arg1)
						for k=1,xx do	
							local itemLink = C_Container.GetContainerItemLink(arg1, k);
							for i=1,#shujuy do
								if itemLink==shujuy[i][2] then		
									self:SetAttribute("item", itemLink)
									return
								end
							end
						end
					end
				end
				PIG_print("没有需打开物品")
			else
				PIG_print("打开目录为空,右键设置")
			end	
		end
	end
	addonTable.Open_Item = Open_Item
	fuFrame.yijiandakai = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");
	fuFrame.yijiandakai:SetSize(100,22);
	fuFrame.yijiandakai:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",100,-40);
	fuFrame.yijiandakai:SetText("手动开启");
	fuFrame.yijiandakai:SetAttribute("type", "item")
	fuFrame.yijiandakai:SetScript("PreClick",  function (self)
		Open_Item(self)
	end);
	----
	if PIG['AutoSellBuy']['zidongKaiqi']=="ON" then
		fuFrame.zidongKaiqi:SetChecked(true);
		zidongOpenXXXX:RegisterEvent("BAG_UPDATE");
	end
end
-- --==============================
addonTable.FastOpen = FastOpen