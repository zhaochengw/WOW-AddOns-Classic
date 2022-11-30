local _, addonTable = ...;
--============历史记录====================
local ADD_Frame=addonTable.ADD_Frame
local hang_Height,hang_NUM  = 30, 12;
local function ADD_History()
	local Width,Height  = RaidR_UI:GetWidth(), RaidR_UI:GetHeight();
	-------------------
	--打开按钮
	RaidR_UI.xiafangF.History = CreateFrame("Button",nil,RaidR_UI.xiafangF, "UIPanelButtonTemplate"); 
	RaidR_UI.xiafangF.History:SetSize(80,28);
	RaidR_UI.xiafangF.History:SetPoint("TOPLEFT",RaidR_UI.xiafangF.lian1,"TOPLEFT",210,-6);
	RaidR_UI.xiafangF.History:SetText("历史记录");
	----
	local History=ADD_Frame("History_UI",RaidR_UI,Width-22,Height-100,"TOP",RaidR_UI,"TOP",0,-18,true,false,false,false,false,"BG6")
	History:SetFrameLevel(RaidR_UI:GetFrameLevel()+20);

	History.Close = CreateFrame("Button",nil,History, "UIPanelCloseButton");  
	History.Close:SetSize(34,34);
	History.Close:SetPoint("TOPRIGHT",History,"TOPRIGHT",2.4,3);
	----
	History.list = CreateFrame("Frame", nil, History,"BackdropTemplate");
	History.list:SetBackdrop({edgeFile = "interface/glues/common/textpanel-border.blp", edgeSize = 18,});
	History.list:SetBackdropBorderColor(1, 1, 1, 0.6);
	History.list:SetSize(Width*0.24,Height-136);
	History.list:SetPoint("TOPLEFT",History,"TOPLEFT",10,-28);
	History.list.biaoti = History.list:CreateFontString();
	History.list.biaoti:SetPoint("BOTTOM",History.list,"TOP",0,2);
	History.list.biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.list.biaoti:SetText("\124cffFFFF00活动目录\124r");
	--目录滚动
	History.xuanzhongID=0;
	local function gengxinHistory(self)
		History.list.Highlight:Hide()
		History.qingkong:Disable();
		for i = 1, hang_NUM do
			_G["History_list_"..i]:Hide();
			_G["History_list_"..i].name:SetText();
			_G["History_list_"..i].time:SetText();
			_G["History_list_"..i].name:SetTextColor(1, 215/255, 0, 1);
			_G["History_list_"..i].time:SetTextColor(0, 1, 154/255, 1);
	    end
	    local shujuyuan = PIG["RaidRecord"]["History"]
		if #shujuyuan>0 then
			History.qingkong:Enable();
		    local ItemsNum = #shujuyuan;
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
		    local offset = FauxScrollFrame_GetOffset(self);
			for i = 1, hang_NUM do
				local dangqian = (ItemsNum+1)-i-offset;
				if shujuyuan[dangqian] then
					local fameX = _G["History_list_"..i]
					fameX:Show();
					fameX.ID=dangqian
					fameX.NO:SetText(dangqian);
					fameX.name:SetText(shujuyuan[dangqian][1][2]);
					fameX.time:SetText(date("%Y-%m-%d %H:%M",shujuyuan[dangqian][1][1]));
					if History.xuanzhongID>0 then
						if History.xuanzhongID==dangqian then
							History.list.Highlight:Show()
							History.list.Highlight:SetAllPoints(fameX)
							fameX.name:SetTextColor(1, 1, 1, 1);
							fameX.time:SetTextColor(30/255, 144/255, 1, 1);
						end
					end
				end
		    end
		end
	end
	addonTable.RaidRecord_History =gengxinHistory;
	---
	RaidR_UI.xiafangF.History:SetScript("OnClick", function ()
		fenG_UI:Hide();
		RsettingF_UI:Hide();
		invite_UI:Hide();
		if History_UI:IsShown() then
			History_UI:Hide();
		else
			History_UI:Show();
			gengxinHistory(History.list.Scroll);
		end
	end);
	--内容滚动
	local hang_neirong_Height,hang_neirong_NUM  = 24, 15;
	local function gengxinHistory_neirong(self)
		for i = 1, hang_neirong_NUM do
			local fameX = _G["History_neirong_"..i]
			fameX:Hide()
			fameX.tx1:SetText();
			fameX.tx1:SetText();
			fameX.tx2:SetText();
			fameX.tx3:SetText();
		end
		History.neirong.Down1_V:SetText();
		History.neirong.Down2_V:SetText();
		History.neirong.Down3_V:SetText();
		History.neirong.Down4_V:SetText();
		History.neirong.Down5_V:SetText();
		History.neirong.Down6_V:SetText();
		History.neirong.Down7_V:SetText();
		History.neirong.Del:Disable();
		if History.xuanzhongID>0 then
			History.neirong.Del:Enable();
			local Hzonghang={};
			local shujuyuan=PIG["RaidRecord"]["History"];
			for a=1,#shujuyuan[History.xuanzhongID][2] do
				local list1=shujuyuan[History.xuanzhongID][2][a][1];
				local list2=shujuyuan[History.xuanzhongID][2][a][2];
				local list3=shujuyuan[History.xuanzhongID][2][a][3];
				local list={list1,list2,list3};
				table.insert(Hzonghang,list);
			end
			for b=1,#shujuyuan[History.xuanzhongID][3] do
				local list1=shujuyuan[History.xuanzhongID][3][b][1];
				local list2=shujuyuan[History.xuanzhongID][3][b][2];
				local list3=shujuyuan[History.xuanzhongID][3][b][3];
				local list={list1,list2,list3};
				table.insert(Hzonghang,list);
			end
			for c=1,#shujuyuan[History.xuanzhongID][4] do
				local list1=shujuyuan[History.xuanzhongID][4][c][1];
				local list2=shujuyuan[History.xuanzhongID][4][c][2];
				local list3=shujuyuan[History.xuanzhongID][4][c][3];
				local list={list1,list2,list3};
				table.insert(Hzonghang,list);
			end
			for d=1,#shujuyuan[History.xuanzhongID][5] do
				local list1=shujuyuan[History.xuanzhongID][5][d][1];
				local list2=shujuyuan[History.xuanzhongID][5][d][2];
				local list3=shujuyuan[History.xuanzhongID][5][d][3];
				local list={list1,list2,list3};
				table.insert(Hzonghang,list);
			end

			local ItemsNum = #Hzonghang;
		    FauxScrollFrame_Update(self, ItemsNum, hang_neirong_NUM, hang_neirong_Height);
		    local offset = FauxScrollFrame_GetOffset(self);

			for i = 1, hang_neirong_NUM do
				local ii = i+offset;
				if Hzonghang[ii] then
					local fameX = _G["History_neirong_"..i]
					fameX:Show()
					fameX.tx1:SetText(Hzonghang[ii][1]);
					fameX.tx2:SetText(Hzonghang[ii][2].."\124cffFFFF00 G\124r");
					fameX.tx3:SetText(Hzonghang[ii][3]);
				end
			end
			--
			History.neirong.Down1_V:SetText(shujuyuan[History.xuanzhongID][6][1]);
			History.neirong.Down2_V:SetText(shujuyuan[History.xuanzhongID][6][2]);
			History.neirong.Down3_V:SetText(shujuyuan[History.xuanzhongID][6][3]);
			History.neirong.Down4_V:SetText(shujuyuan[History.xuanzhongID][6][4]);
			History.neirong.Down5_V:SetText(shujuyuan[History.xuanzhongID][6][5]);
			History.neirong.Down6_V:SetText(shujuyuan[History.xuanzhongID][6][6]);
			History.neirong.Down7_V:SetText(shujuyuan[History.xuanzhongID][6][7]);
		end
	end
	--创建可滚动区域
	History.list.Scroll = CreateFrame("ScrollFrame",nil,History.list, "FauxScrollFrameTemplate");  
	History.list.Scroll:SetPoint("TOPLEFT",History.list,"TOPLEFT",0,-3);
	History.list.Scroll:SetPoint("BOTTOMRIGHT",History.list,"BOTTOMRIGHT",-26,5);
	History.list.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinHistory)
	end)
	History.list.Highlight = History.list:CreateTexture(nil, "BORDER");
	History.list.Highlight:SetTexture("interface/buttons/ui-listbox-highlight.blp");
	History.list.Highlight:Hide()
	for id = 1, hang_NUM do
		local mululist= CreateFrame("Frame", "History_list_"..id, History.list.Scroll:GetParent());
		mululist:SetSize(History.list:GetWidth()-30, hang_Height);
		if id==1 then
			mululist:SetPoint("TOP",History.list.Scroll,"TOP",5,0);
		else
			mululist:SetPoint("TOP",_G["History_list_"..(id-1)],"BOTTOM",0,-6);
		end
		mululist:SetScript("OnMouseUp", function (self)
			History.list.Highlight:SetAllPoints(self)
			History.list.Highlight:Show()
			for k = 1, hang_NUM do
				_G["History_list_"..k].name:SetTextColor(1, 215/255, 0, 1);
				_G["History_list_"..k].time:SetTextColor(0, 1, 154/255, 1);
			end
			self.name:SetTextColor(1, 1, 1, 1);
			self.time:SetTextColor(30/255, 144/255, 1, 1);
			History.xuanzhongID=tonumber(self.ID);
			gengxinHistory_neirong(History.neirong.Scroll);
		end)
		mululist.line = mululist:CreateLine()
		mululist.line:SetColorTexture(1,1,1,0.2)
		mululist.line:SetThickness(1);
		mululist.line:SetStartPoint("BOTTOMLEFT",0,-3)
		mululist.line:SetEndPoint("BOTTOMRIGHT",0,-3)
		-----
		mululist.name = mululist:CreateFontString();
		mululist.name:SetPoint("TOPLEFT",mululist,"TOPLEFT",30,-1.4);
		mululist.name:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		mululist.name:SetTextColor(1, 215/255, 0, 1);
		mululist.time = mululist:CreateFontString();
		mululist.time:SetPoint("TOPLEFT",mululist.name,"BOTTOMLEFT",1,-1);
		mululist.time:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		mululist.time:SetTextColor(0, 1, 154/255, 1);
		mululist.NO = mululist:CreateFontString();
		mululist.NO:SetPoint("RIGHT",mululist.name,"LEFT",0,-6);
		mululist.NO:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
		mululist.NO:SetTextColor(1, 1, 1, 0.3);
	end
	-----活动详情-----------
	History.neirong = CreateFrame("Frame", nil, History,"BackdropTemplate");
	History.neirong:SetBackdrop({edgeFile = "interface/glues/common/textpanel-border.blp", edgeSize = 18,});
	History.neirong:SetBackdropBorderColor(1, 1, 1, 0.6);
	History.neirong:SetSize(Width*0.7,Height-136);
	History.neirong:SetPoint("TOPRIGHT",History,"TOPRIGHT",-10,-28);
	History.neirong.biaoti = History.neirong:CreateFontString();
	History.neirong.biaoti:SetPoint("BOTTOM",History.neirong,"TOP",0,2);
	History.neirong.biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.biaoti:SetText("\124cffFFFF00活动详情\124r");
	------
	--创建可滚动区域
	History.neirong.Scroll = CreateFrame("ScrollFrame",nil,History.neirong, "FauxScrollFrameTemplate");  
	History.neirong.Scroll:SetPoint("TOPLEFT",History.neirong,"TOPLEFT",0,-4);
	History.neirong.Scroll:SetPoint("BOTTOMRIGHT",History.neirong,"BOTTOMRIGHT",-26,68);
	History.neirong.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_neirong_Height, gengxinHistory_neirong)
	end)
	for id = 1, hang_neirong_NUM do
		local neirong= CreateFrame("Frame", "History_neirong_"..id, History.neirong.Scroll:GetParent());
		neirong:SetSize(History.neirong:GetWidth()-26, hang_neirong_Height);
		if id==1 then
			neirong:SetPoint("TOP",History.neirong.Scroll,"TOP",5,0);
		else
			neirong:SetPoint("TOP",_G["History_neirong_"..(id-1)],"BOTTOM",0,0);
		end
		neirong:Hide()
		neirong.line = neirong:CreateLine()
		neirong.line:SetColorTexture(1,1,1,0.2)
		neirong.line:SetThickness(1);
		neirong.line:SetStartPoint("BOTTOMLEFT",0,0)
		neirong.line:SetEndPoint("BOTTOMRIGHT",0,0)
		-- -----
		neirong.tx1 = neirong:CreateFontString();
		neirong.tx1:SetPoint("LEFT",neirong,"LEFT",10,0);
		neirong.tx1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		neirong.tx2 = neirong:CreateFontString();
		neirong.tx2:SetPoint("LEFT",neirong,"LEFT",280,0);
		neirong.tx2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		neirong.tx3 = neirong:CreateFontString();
		neirong.tx3:SetPoint("LEFT",neirong,"LEFT",380,0);
		neirong.tx3:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	end
	History.neirong.line1 = History.neirong:CreateLine()
	History.neirong.line1:SetColorTexture(1,1,1,0.3)
	History.neirong.line1:SetThickness(1.4);
	History.neirong.line1:SetStartPoint("LEFT",4,-150)
	History.neirong.line1:SetEndPoint("RIGHT",-3,-150)
	--汇总
	History.neirong.Down1 = History.neirong:CreateFontString();
	History.neirong.Down1:SetPoint("TOPLEFT",History.neirong.line1,"TOPLEFT",6,-10);
	History.neirong.Down1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down1:SetText("\124cffFFFF00物品收入/G：\124r");
	History.neirong.Down1_V = History.neirong:CreateFontString();
	History.neirong.Down1_V:SetPoint("LEFT",History.neirong.Down1,"RIGHT",0,0);
	History.neirong.Down1_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down2 = History.neirong:CreateFontString();
	History.neirong.Down2:SetPoint("LEFT",History.neirong.Down1,"RIGHT",47,0);
	History.neirong.Down2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down2:SetText("\124cffFFFF00补助支出/G：\124r");
	History.neirong.Down2_V = History.neirong:CreateFontString();
	History.neirong.Down2_V:SetPoint("LEFT",History.neirong.Down2,"RIGHT",0,0);
	History.neirong.Down2_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down3 = History.neirong:CreateFontString();
	History.neirong.Down3:SetPoint("LEFT",History.neirong.Down2,"RIGHT",47,0);
	History.neirong.Down3:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down3:SetText("\124cffFFFF00其他收入/G：\124r");
	History.neirong.Down3_V = History.neirong:CreateFontString();
	History.neirong.Down3_V:SetPoint("LEFT",History.neirong.Down3,"RIGHT",0,0);
	History.neirong.Down3_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down4 = History.neirong:CreateFontString();
	History.neirong.Down4:SetPoint("LEFT",History.neirong.Down3,"RIGHT",47,0);
	History.neirong.Down4:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down4:SetText("\124cffFFFF00奖励支出/G：\124r");
	History.neirong.Down4_V = History.neirong:CreateFontString();
	History.neirong.Down4_V:SetPoint("LEFT",History.neirong.Down4,"RIGHT",0,0);
	History.neirong.Down4_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down5 = History.neirong:CreateFontString();
	History.neirong.Down5:SetPoint("TOPLEFT",History.neirong.Down1,"BOTTOMLEFT",0,-15);
	History.neirong.Down5:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down5:SetText("\124cffFFFF00总收入/G：\124r");
	History.neirong.Down5_V = History.neirong:CreateFontString();
	History.neirong.Down5_V:SetPoint("LEFT",History.neirong.Down5,"RIGHT",0,0);
	History.neirong.Down5_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down6 = History.neirong:CreateFontString();
	History.neirong.Down6:SetPoint("LEFT",History.neirong.Down5,"RIGHT",54,0);
	History.neirong.Down6:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down6:SetText("\124cffFFFF00净收入/G：\124r");
	History.neirong.Down6_V = History.neirong:CreateFontString();
	History.neirong.Down6_V:SetPoint("LEFT",History.neirong.Down6,"RIGHT",0,0);
	History.neirong.Down6_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down7 = History.neirong:CreateFontString();
	History.neirong.Down7:SetPoint("LEFT",History.neirong.Down6,"RIGHT",54,0);
	History.neirong.Down7:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	History.neirong.Down7:SetText("\124cffFFFF00人均/G：\124r");
	History.neirong.Down7_V = History.neirong:CreateFontString();
	History.neirong.Down7_V:SetPoint("LEFT",History.neirong.Down7,"RIGHT",0,0);
	History.neirong.Down7_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");

	History.neirong.Del = CreateFrame("Button",nil,History.neirong, "UIPanelButtonTemplate");  
	History.neirong.Del:SetSize(120,24);
	History.neirong.Del:SetPoint("LEFT",History.neirong.Down7,"RIGHT",68,-2);
	History.neirong.Del:SetText("删除本条记录");
	History.neirong.Del:Disable();
	History.neirong.Del:SetScript("OnClick", function ()
		if History.xuanzhongID>0 then
			table.remove (PIG["RaidRecord"]["History"], History.xuanzhongID);
			History.xuanzhongID=History.xuanzhongID-1;
			if History.xuanzhongID==0 then 
				if #PIG["RaidRecord"]["History"]~=0 then
					History.xuanzhongID=1;
				end
			end
			gengxinHistory(History.list.Scroll);
			gengxinHistory_neirong(History.neirong.Scroll);
		end
	end);
	--删除历史记录
	StaticPopupDialogs["DEL_HISTORY"] = {
		text = "确定\124cffff0000清空\124r\n所有历史记录吗?",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG["RaidRecord"]["History"]={};
			History.xuanzhongID=0;
			gengxinHistory(History.list.Scroll);
			gengxinHistory_neirong(History.neirong.Scroll);
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	History.qingkong = CreateFrame("Button",nil,History, "UIPanelButtonTemplate");  
	History.qingkong:SetSize(116,24);
	History.qingkong:SetPoint("TOPRIGHT",History,"TOPRIGHT",-40,-4);
	History.qingkong:SetText("清空所有记录");
	History.qingkong:SetScript("OnClick", function ()
		StaticPopup_Show ("DEL_HISTORY");
	end);
end
addonTable.ADD_History = ADD_History;