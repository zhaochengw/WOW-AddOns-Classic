local addonName, addonTable = ...;
local hangH = 22
local gsub = _G.string.gsub 
local find = _G.string.find
local sub = _G.string.sub 
local upper = _G.string.upper 
--===============================================
local ADD_Frame=addonTable.ADD_Frame
--
local function ADD_QuickBut_Roll()
	PIG_Per["ChatFrame"]["RollList"]=PIG_Per["ChatFrame"]["RollList"] or addonTable.Default_Per["ChatFrame"]["RollList"]
	local RollWidth,RollHeight,RollbiaotiH  = 520, 540, 34;
	local hang_Height,hang_NUM  = 30, 16;
	--父框架
	local RollF=ADD_Frame("RollF_UI",UIParent,RollWidth, RollHeight,"CENTER",UIParent,"CENTER",0,100,true,false,true,true,true)
	--标题+拖拽按钮
	RollF.biaoti = CreateFrame("Frame", nil, RollF,"BackdropTemplate")
	RollF.biaoti:SetBackdrop({
	    bgFile = "interface/characterframe/ui-party-background.blp",
	    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		edgeSize = 16,insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
	RollF.biaoti:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
	RollF.biaoti:SetSize(120, RollbiaotiH)
	RollF.biaoti:SetPoint("TOP", RollF, "TOP", 0, 0)
	RollF.biaoti:EnableMouse(true)
	RollF.biaoti:RegisterForDrag("LeftButton")
	RollF.biaoti:SetClampedToScreen(true)
	RollF.biaoti:SetScript("OnDragStart",function()
		RollF:StartMoving()
	end)
	RollF.biaoti:SetScript("OnDragStop",function()
		RollF:StopMovingOrSizing()
	end)
	RollF.biaoti_title = RollF.biaoti:CreateFontString();
	RollF.biaoti_title:SetPoint("TOP", RollF.biaoti, "TOP", 0, -10);
	RollF.biaoti_title:SetFontObject(GameFontNormal);
	RollF.biaoti_title:SetText("Roll点记录");
	--关闭按钮
	RollF.CloseF = CreateFrame("Frame", nil, RollF,"BackdropTemplate")
	RollF.CloseF:SetBackdrop({
	    bgFile = "interface/characterframe/ui-party-background.blp",
	    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		edgeSize = 16,insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
	RollF.CloseF:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
	RollF.CloseF:SetSize(28,28);
	RollF.CloseF:SetPoint("TOPRIGHT", RollF, "TOPRIGHT", -6, -6);
	RollF.Close = CreateFrame("Button",nil,RollF, "UIPanelCloseButton");  
	RollF.Close:SetSize(32,32);
	RollF.Close:SetPoint("CENTER", RollF.CloseF, "CENTER", 1, 0);
	----内容显示框架
	RollF.F = CreateFrame("Frame", nil, RollF,"BackdropTemplate");
	RollF.F:SetBackdrop({
	    bgFile = "interface/characterframe/ui-party-background.blp",
	    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		edgeSize = 16,insets = { left = 4, right = 4, top = 4, bottom = 4 }
	})
	RollF.F:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
	RollF.F:SetSize(RollWidth,RollHeight-RollbiaotiH+6);
	RollF.F:SetPoint("TOP",RollF,"TOP",0,-RollbiaotiH+6);
	--
	RollF.F.biati1 = RollF.F:CreateFontString();
	RollF.F.biati1:SetPoint("TOPLEFT", RollF.F, "TOPLEFT", 20,-6);
	RollF.F.biati1:SetFontObject(GameFontNormal);
	RollF.F.biati1:SetText("位置");
	RollF.F.biati2 = RollF.F:CreateFontString();
	RollF.F.biati2:SetPoint("TOPLEFT", RollF.F, "TOPLEFT", 170,-6);
	RollF.F.biati2:SetFontObject(GameFontNormal);
	RollF.F.biati2:SetText("物品");
	RollF.F.biati3 = RollF.F:CreateFontString();
	RollF.F.biati3:SetPoint("TOPLEFT", RollF.F, "TOPLEFT", 390,-6);
	RollF.F.biati3:SetFontObject(GameFontNormal);
	RollF.F.biati3:SetText("获胜人");
	RollF.F.lineBT = RollF.F:CreateLine()
	RollF.F.lineBT:SetColorTexture(0.2,0.2,0.2,0.8)
	RollF.F.lineBT:SetThickness(1);
	RollF.F.lineBT:SetStartPoint("TOPLEFT",4,-24)
	RollF.F.lineBT:SetEndPoint("TOPRIGHT",-4,-24)
	---------
	local GOUMAIlist = #PIG_Per["ChatFrame"]["RollList"];
	for i=GOUMAIlist,1,-1 do
		if PIG_Per["ChatFrame"]["RollList"][i][7] then
			if GetServerTime()-PIG_Per["ChatFrame"]["RollList"][i][7]>86400 then
				table.remove(PIG_Per["ChatFrame"]["RollList"],i);
			end
		else
			table.remove(PIG_Per["ChatFrame"]["RollList"],i) 
		end
	end
	local function gengxinlist(self)
		for id = 1, hang_NUM do
			_G["RollP_hang"..id]:Hide();
	    end
	    local GOUMAIlist = #PIG_Per["ChatFrame"]["RollList"];
		if GOUMAIlist>0 then
			FauxScrollFrame_Update(self, GOUMAIlist, hang_NUM, hang_Height);
			local offset = FauxScrollFrame_GetOffset(self);
		    for id = 1, hang_NUM do
		    	local dangqianH = GOUMAIlist-id-offset+1;
		    	if PIG_Per["ChatFrame"]["RollList"][dangqianH] then
		    		_G["RollP_hang"..id]:Show();
		    		if PIG_Per['ChatFrame']['RollList'][dangqianH][1]=="jiange" then
		    			_G["RollP_hang"..id].item.icon:SetTexture();
		    			_G["RollP_hang"..id].guishu.fangshi:SetTexture();
		    			_G["RollP_hang"..id].item.link:SetText("-----");
		    			_G["RollP_hang"..id].guishuren:SetText("-----");
		    			_G["RollP_hang"..id].guishu.diansshu:SetText();
						_G["RollP_hang"..id].weizhi:SetText("-----");
		    		else
			    		local itemlink=PIG_Per['ChatFrame']['RollList'][dangqianH][4]
			    		local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subclassID = GetItemInfoInstant(itemlink) 
				 		_G["RollP_hang"..id].item.icon:SetTexture(icon);
						_G["RollP_hang"..id].item.link:SetText(itemlink);
						_G["RollP_hang"..id].item:SetScript("OnMouseDown", function (self)
							if not IsShiftKeyDown() then
								GameTooltip:ClearLines();
								GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
								GameTooltip:SetHyperlink(itemlink)
								GameTooltip:Show()
							end
						end);
						_G["RollP_hang"..id].item:SetScript("OnMouseUp", function ()
							GameTooltip:ClearLines();
							GameTooltip:Hide()
							if IsShiftKeyDown() then
								local editBox = ChatEdit_ChooseBoxForSend();
								local hasText = editBox:GetText()..itemlink
								if editBox:HasFocus() then
									editBox:SetText(hasText);
								else
									ChatEdit_ActivateChat(editBox)
									editBox:SetText(hasText);
								end
							end
						end);
						_G["RollP_hang"..id].guishu.fangshi:SetTexture("interface/buttons/ui-grouploot-pass-up.blp");
						_G["RollP_hang"..id].guishuren:SetText("全部放弃");
						_G["RollP_hang"..id].weizhi:SetText(PIG_Per['ChatFrame']['RollList'][dangqianH][6]);
						for f=1,#PIG_Per['ChatFrame']['RollList'][dangqianH][5] do
							if PIG_Per['ChatFrame']['RollList'][dangqianH][5][f][5] then
								local rrr, yyy, bbb, argbHex = GetClassColor(PIG_Per['ChatFrame']['RollList'][dangqianH][5][f][2]);
								_G["RollP_hang"..id].guishuren:SetTextColor(rrr, yyy, bbb,1)
								_G["RollP_hang"..id].guishuren:SetText(PIG_Per['ChatFrame']['RollList'][dangqianH][5][f][1]);
								_G["RollP_hang"..id].guishu.diansshu:SetText(PIG_Per['ChatFrame']['RollList'][dangqianH][5][f][4]);
								if PIG_Per['ChatFrame']['RollList'][dangqianH][5][f][3]==1 then
									_G["RollP_hang"..id].guishu.fangshi:SetTexture("interface/buttons/ui-grouploot-dice-up.blp");
								elseif PIG_Per['ChatFrame']['RollList'][dangqianH][5][f][3]==2 then
									_G["RollP_hang"..id].guishu.fangshi:SetTexture("interface/buttons/ui-grouploot-coin-up.blp");
								elseif PIG_Per['ChatFrame']['RollList'][dangqianH][5][f][3]==3 then
									_G["RollP_hang"..id].guishu.fangshi:SetTexture("interface/buttons/ui-grouploot-de-up.blp");--分解
								end
							end
						end
					end
				end
			end
		end
	end
	RollF.F.Scroll = CreateFrame("ScrollFrame",nil,RollF.F, "FauxScrollFrameTemplate");  
	RollF.F.Scroll:SetPoint("TOPLEFT",RollF.F,"TOPLEFT",5,-26);
	RollF.F.Scroll:SetPoint("BOTTOMRIGHT",RollF.F,"BOTTOMRIGHT",-27,5);
	RollF.F.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinlist)
	end)
	for id = 1, hang_NUM do
		local RollP = CreateFrame("Frame", "RollP_hang"..id, RollF.F);
		RollP:SetSize(RollWidth-36, hang_Height);
		if id==1 then
			RollP:SetPoint("TOP",RollF.F.Scroll,"TOP",0,0);
		else
			RollP:SetPoint("TOP",_G["RollP_hang"..(id-1)],"BOTTOM",0,-0);
		end
		if id~=hang_NUM then
			local RollP_line = RollP:CreateLine()
			RollP_line:SetColorTexture(1,1,1,0.2)
			RollP_line:SetThickness(1);
			RollP_line:SetStartPoint("BOTTOMLEFT",0,0)
			RollP_line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		RollP.weizhi = RollP:CreateFontString();
		RollP.weizhi:SetWidth(130);
		RollP.weizhi:SetPoint("LEFT",RollP,"LEFT",0,0);
		RollP.weizhi:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		RollP.weizhi:SetJustifyH("LEFT");

		RollP.item = CreateFrame("Frame", nil, RollP);
		RollP.item:SetSize(200,hang_Height);
		RollP.item:SetPoint("LEFT",RollP.weizhi,"RIGHT",0,0);
		RollP.item.icon = RollP.item:CreateTexture(nil, "BORDER");
		RollP.item.icon:SetSize(hang_Height-4,hang_Height-4);
		RollP.item.icon:SetPoint("LEFT", RollP.item, "LEFT", 0,0);
		RollP.item.link = RollP.item:CreateFontString();
		RollP.item.link:SetWidth(200-hang_Height-4);
		RollP.item.link:SetPoint("LEFT", RollP.item, "LEFT", 30,0);
		RollP.item.link:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		RollP.item.link:SetJustifyH("LEFT");

		RollP.guishu = CreateFrame("Frame", nil, RollP);
		RollP.guishu:SetSize(48,hang_Height);
		RollP.guishu:SetPoint("LEFT",RollP.item,"RIGHT",0,0);
		RollP.guishu.fangshi = RollP.guishu:CreateTexture(nil, "BORDER");
		RollP.guishu.fangshi:SetSize(hang_Height-8,hang_Height-8);
		RollP.guishu.fangshi:SetPoint("LEFT", RollP.guishu, "LEFT", 0,0);
		RollP.guishu.diansshu = RollP.guishu:CreateFontString();
		RollP.guishu.diansshu:SetPoint("LEFT", RollP.guishu.fangshi, "RIGHT", -1,0);
		RollP.guishu.diansshu:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		RollP.guishu.diansshu:SetTextColor(0, 1, 0, 1);

		RollP.guishuren = RollP:CreateFontString();
		RollP.guishuren:SetPoint("LEFT", RollP.guishu, "RIGHT", 2,0);
		RollP.guishuren:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	end
	RollF:SetScript("OnShow", function()
		gengxinlist(RollF.F.Scroll)
	end)
	---
	local linshishujuROLL = {};
	local ROLLFrame = CreateFrame("Frame")
	ROLLFrame:RegisterEvent("START_LOOT_ROLL");
	ROLLFrame:RegisterEvent("LOOT_ITEM_AVAILABLE");
	ROLLFrame:RegisterEvent("LOOT_ITEM_ROLL_WON");
	ROLLFrame:RegisterEvent("LOOT_ROLLS_COMPLETE");
	ROLLFrame:RegisterEvent("CHAT_MSG_SAY")
	ROLLFrame:SetScript("OnEvent", function(self,event,arg1,arg2,arg3,arg4,arg5)
		if event=="START_LOOT_ROLL" then
			local quyuming =GetRealZoneText()
			local zongshu =#PIG_Per['ChatFrame']['RollList']
			if zongshu>0 then
				if PIG_Per['ChatFrame']['RollList'][zongshu][6]~=quyuming then
					table.insert(PIG_Per['ChatFrame']['RollList'], {"jiange",nil,nil,nil,nil,nil,GetServerTime()});
					table.insert(PIG_Per['ChatFrame']['RollList'], {arg1,arg2,arg3,"-",{},quyuming,GetServerTime()});
				else
																--1rollID, 2rollTime, 3lootHandle,4link，5人员R点信息,6区域名，7时间
					table.insert(PIG_Per['ChatFrame']['RollList'], {arg1,arg2,arg3,"-",{},quyuming,GetServerTime()});
				end
			else
				table.insert(PIG_Per['ChatFrame']['RollList'], {arg1,arg2,arg3,"-",{},quyuming,GetServerTime()});
			end
		end
		if event=="LOOT_ITEM_AVAILABLE" then
			for i=#PIG_Per['ChatFrame']['RollList'],1,-1 do
				if PIG_Per['ChatFrame']['RollList'][i][3]==arg2 then
					PIG_Per['ChatFrame']['RollList'][i][4]=arg1
					break
				end
			end
		end
		-- if event=="LOOT_ITEM_ROLL_WON" then
		-- 	linshishujuROLL = {arg1,arg2,arg3,arg4,arg5};
		-- end
		if event=="LOOT_ROLLS_COMPLETE" then
			for i=#PIG_Per['ChatFrame']['RollList'],1,-1 do
				if PIG_Per['ChatFrame']['RollList'][i][3]==arg1 then
					for itemIdx=C_LootHistory.GetNumItems(),1,-1 do
						local rollID, itemLink, numPlayers, isDone, winnerIdx, isMasterLoot = C_LootHistory.GetItem(itemIdx)
						if rollID==PIG_Per['ChatFrame']['RollList'][i][1] then
							for x=1,5 do
								local name, class, rollType, roll, isWinner, isMe = C_LootHistory.GetPlayerInfo(itemIdx, x)
								if name then
									table.insert(PIG_Per['ChatFrame']['RollList'][i][5],{name,class,rollType, roll, isWinner, isMe})
								end
							end
							break
						end
					end
					break
				end
			end
		end
	end)

	---------
	local fuFrame=QuickChatFFF_UI
	local Width,Height,jiangejuli = 24,24,0;
	local ziframe = {fuFrame:GetChildren()}
	if PIG["ChatFrame"]["QuickChat_style"]==1 then
		fuFrame.ROLL = CreateFrame("Button",nil,fuFrame, "TruncatedButtonTemplate"); 
	elseif PIG["ChatFrame"]["QuickChat_style"]==2 then
		fuFrame.ROLL = CreateFrame("Button",nil,fuFrame, "UIMenuButtonStretchTemplate"); 
	end
	fuFrame.ROLL:SetSize(Width,Height);
	fuFrame.ROLL:SetFrameStrata("LOW")
	fuFrame.ROLL:SetPoint("LEFT",fuFrame,"LEFT",#ziframe*Width,0);
	fuFrame.ROLL:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	fuFrame.ROLL.Tex = fuFrame.ROLL:CreateTexture(nil, "BORDER");
	fuFrame.ROLL.Tex:SetTexture("interface/buttons/ui-grouploot-dice-up.blp");
	fuFrame.ROLL.Tex:SetPoint("CENTER",0,-1);
	fuFrame.ROLL.Tex:SetSize(Width-8,Height-4);
	fuFrame.ROLL:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",1,-2);
	end);
	fuFrame.ROLL:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER",0,-1);
	end);
	fuFrame.ROLL:SetScript("OnEnter", function (self)	
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:SetText("|cff00FFff左键-|r|cffFFFF00Roll点\n|cff00FFff右键-|r|cffFFFF00Roll点记录|r");
		GameTooltip:Show();
		GameTooltip:FadeOut()
	end);
	fuFrame.ROLL:SetScript("OnLeave", function (self)
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	fuFrame.ROLL:SetScript("OnClick", function(self, event)
		if event=="RightButton" then
			if RollF_UI:IsShown() then
				RollF_UI:Hide()
			else
				RollF_UI:Show()
			end
		else
			RandomRoll(1, 100)
		end
	end);
end
---==============================================
addonTable.ADD_QuickBut_Roll = ADD_QuickBut_Roll