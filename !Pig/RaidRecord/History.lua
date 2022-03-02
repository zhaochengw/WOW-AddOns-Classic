local _, addonTable = ...;
--============历史记录====================
local Width,Height  = RaidR_UI:GetWidth(), RaidR_UI:GetHeight();
local hang_Height,hang_NUM  = 30, 12;
--创建检测显示框架
local History = CreateFrame("Frame", "History_UI", RaidR_UI,"BackdropTemplate");
History:SetBackdrop({bgFile = "interface/raidframe/ui-raidframe-groupbg.blp", 
	edgeFile = "interface/glues/common/textpanel-border.blp", 
	tile = false, tileSize = 0, edgeSize = 20,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
History:SetSize(Width-22,Height-100);
History:SetPoint("TOP",RaidR_UI,"TOP",0,-18);
History:SetFrameLevel(10);
History:EnableMouse(true);
History:Hide();
local History_Close = CreateFrame("Button","History_Close_UI",History, "UIPanelCloseButton");  
History_Close:SetSize(34,34);
History_Close:SetPoint("TOPRIGHT",History,"TOPRIGHT",2.4,3);
----
local History_list = CreateFrame("Frame", "History_list_UI", History,"BackdropTemplate");
History_list:SetBackdrop({edgeFile = "interface/glues/common/textpanel-border.blp", edgeSize = 18,});
History_list:SetBackdropBorderColor(1, 1, 1, 0.6);
History_list:SetSize(Width*0.24,Height-136);
History_list:SetPoint("TOPLEFT",History,"TOPLEFT",10,-28);
local History_list_biaoti = History_list:CreateFontString("History_list_biaoti_UI");
History_list_biaoti:SetPoint("BOTTOM",History_list,"TOP",0,2);
History_list_biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
History_list_biaoti:SetText("\124cffFFFF00活动目录\124r");
--目录滚动
local History_xuanzhongID=0;
local function gengxinHistory(self)
	History_list_Tex_UI:Hide()
	qingkong_UI:Disable();
	for k = 1, hang_NUM do
		_G["History_list_"..k.."_UI"]:EnableMouse(false);
		_G["History_list_name_"..k.."_UI"]:SetText();
		_G["History_list_time_"..k.."_UI"]:SetText();
		_G["History_list_name_"..k.."_UI"]:SetTextColor(1, 215/255, 0, 1);
		_G["History_list_time_"..k.."_UI"]:SetTextColor(0, 1, 154/255, 1);
		_G["History_list_ID_"..k.."_UI"]:SetText();
    end
	if #PIG["RaidRecord"]["History"]>0 then
		qingkong_UI:Enable();
	    local ItemsNum = #PIG["RaidRecord"]["History"];
	    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
	    local offset = FauxScrollFrame_GetOffset(self);
		if #PIG["RaidRecord"]["History"]<hang_NUM then
	    	New_History_hang_NUM=#PIG["RaidRecord"]["History"];
	    else
	    	New_History_hang_NUM=hang_NUM;
	    end
		for i =1, New_History_hang_NUM do
			_G["History_list_"..i.."_UI"]:EnableMouse(true);
			local dangqian = i+offset;
			if History_xuanzhongID>0 then
				if History_xuanzhongID-offset>0 and History_xuanzhongID-offset<=New_History_hang_NUM then
					History_list_Tex_UI:Show()
					History_list_Tex_UI:SetAllPoints(_G["History_list_"..History_xuanzhongID-offset.."_UI"])
					_G["History_list_name_"..History_xuanzhongID-offset.."_UI"]:SetTextColor(1, 1, 1, 1);
					_G["History_list_time_"..History_xuanzhongID-offset.."_UI"]:SetTextColor(30/255, 144/255, 1, 1);
				else
					History_list_Tex_UI:Hide()
				end
			end
			_G["History_list_ID_"..i.."_UI"]:SetText(dangqian);
			_G["History_list_name_"..i.."_UI"]:SetText(PIG["RaidRecord"]["History"][dangqian][1][2]);
			_G["History_list_time_"..i.."_UI"]:SetText(date("%Y-%m-%d %H:%M",PIG["RaidRecord"]["History"][dangqian][1][1]));
	    end
	end
end
addonTable.RaidRecord_History =gengxinHistory;
--内容滚动
local hang_neirong_Height,hang_neirong_NUM  = 24, 15;
local function gengxinHistory_neirong(self)
	for o = 1, hang_neirong_NUM do
		_G["neirong_1_"..o.."_UI"]:SetText();
		_G["neirong_2_"..o.."_UI"]:SetText();
		_G["neirong_3_"..o.."_UI"]:SetText();
	end
	_G["neirong_Down1_V_UI"]:SetText();
	_G["neirong_Down2_V_UI"]:SetText();
	_G["neirong_Down3_V_UI"]:SetText();
	_G["neirong_Down4_V_UI"]:SetText();
	_G["neirong_Down5_V_UI"]:SetText();
	_G["neirong_Down6_V_UI"]:SetText();
	_G["neirong_Down7_V_UI"]:SetText();
	neirong_Del_UI:Disable();
	if History_xuanzhongID>0 then
		neirong_Del_UI:Enable();
		local Hzonghang={};
		for a=1,#PIG["RaidRecord"]["History"][History_xuanzhongID][2] do
			local list1=PIG["RaidRecord"]["History"][History_xuanzhongID][2][a][1];
			local list2=PIG["RaidRecord"]["History"][History_xuanzhongID][2][a][2];
			local list3=PIG["RaidRecord"]["History"][History_xuanzhongID][2][a][3];
			local list={list1,list2,list3};
			table.insert(Hzonghang,list);
		end
		for b=1,#PIG["RaidRecord"]["History"][History_xuanzhongID][3] do
			local list1=PIG["RaidRecord"]["History"][History_xuanzhongID][3][b][1];
			local list2=PIG["RaidRecord"]["History"][History_xuanzhongID][3][b][2];
			local list3=PIG["RaidRecord"]["History"][History_xuanzhongID][3][b][3];
			local list={list1,list2,list3};
			table.insert(Hzonghang,list);
		end
		for c=1,#PIG["RaidRecord"]["History"][History_xuanzhongID][4] do
			local list1=PIG["RaidRecord"]["History"][History_xuanzhongID][4][c][1];
			local list2=PIG["RaidRecord"]["History"][History_xuanzhongID][4][c][2];
			local list3=PIG["RaidRecord"]["History"][History_xuanzhongID][4][c][3];
			local list={list1,list2,list3};
			table.insert(Hzonghang,list);
		end
		for d=1,#PIG["RaidRecord"]["History"][History_xuanzhongID][5] do
			local list1=PIG["RaidRecord"]["History"][History_xuanzhongID][5][d][1];
			local list2=PIG["RaidRecord"]["History"][History_xuanzhongID][5][d][2];
			local list3=PIG["RaidRecord"]["History"][History_xuanzhongID][5][d][3];
			local list={list1,list2,list3};
			table.insert(Hzonghang,list);
		end

		local ItemsNum = #Hzonghang;
	    FauxScrollFrame_Update(self, ItemsNum, hang_neirong_NUM, hang_neirong_Height);
	    local offset = FauxScrollFrame_GetOffset(self);

		if ItemsNum<hang_neirong_NUM then
	    	New_History_hang_neirong_NUM=ItemsNum;
	    else
	    	New_History_hang_neirong_NUM=hang_neirong_NUM;
	    end
		for i = 1, New_History_hang_neirong_NUM do
			local ii = i+offset;
			_G["neirong_1_"..i.."_UI"]:SetText(Hzonghang[ii][1]);
			_G["neirong_2_"..i.."_UI"]:SetText(Hzonghang[ii][2].."\124cffFFFF00 G\124r");
			_G["neirong_3_"..i.."_UI"]:SetText(Hzonghang[ii][3]);
		end
		--
		_G["neirong_Down1_V_UI"]:SetText(PIG["RaidRecord"]["History"][History_xuanzhongID][6][1]);
		_G["neirong_Down2_V_UI"]:SetText(PIG["RaidRecord"]["History"][History_xuanzhongID][6][2]);
		_G["neirong_Down3_V_UI"]:SetText(PIG["RaidRecord"]["History"][History_xuanzhongID][6][3]);
		_G["neirong_Down4_V_UI"]:SetText(PIG["RaidRecord"]["History"][History_xuanzhongID][6][4]);
		_G["neirong_Down5_V_UI"]:SetText(PIG["RaidRecord"]["History"][History_xuanzhongID][6][5]);
		_G["neirong_Down6_V_UI"]:SetText(PIG["RaidRecord"]["History"][History_xuanzhongID][6][6]);
		_G["neirong_Down7_V_UI"]:SetText(PIG["RaidRecord"]["History"][History_xuanzhongID][6][7]);
	end
end
--创建可滚动区域
local History_list_Scroll = CreateFrame("ScrollFrame","History_list_Scroll_UI",History_list, "FauxScrollFrameTemplate");  
History_list_Scroll:SetPoint("TOPLEFT",History_list,"TOPLEFT",0,-3);
History_list_Scroll:SetPoint("BOTTOMRIGHT",History_list,"BOTTOMRIGHT",-26,5);
History_list_Scroll:SetScript("OnVerticalScroll", function(self, offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinHistory)
end)
local list_Tex = History_list:CreateTexture("History_list_Tex_UI", "BORDER");
list_Tex:SetTexture("interface/buttons/ui-listbox-highlight.blp");
list_Tex:Hide()
for id = 1, hang_NUM do
	local list= CreateFrame("Frame", "History_list_"..id.."_UI", History_list_Scroll:GetParent());
	list:SetSize(History_list:GetWidth()-26, hang_Height);
	if id==1 then
		list:SetPoint("TOP",History_list_Scroll,"TOP",5,0);
	else
		list:SetPoint("TOP",_G["History_list_"..(id-1).."_UI"],"BOTTOM",0,-6);
	end
	_G["History_list_"..id.."_UI"]:SetScript("OnMouseUp", function (self)
		list_Tex:SetAllPoints(self)
		History_list_Tex_UI:Show()
		for k = 1, hang_NUM do
			_G["History_list_name_"..k.."_UI"]:SetTextColor(1, 215/255, 0, 1);
			_G["History_list_time_"..k.."_UI"]:SetTextColor(0, 1, 154/255, 1);
		end
		_G["History_list_name_"..id.."_UI"]:SetTextColor(1, 1, 1, 1);
		_G["History_list_time_"..id.."_UI"]:SetTextColor(30/255, 144/255, 1, 1);
		History_xuanzhongID=tonumber(_G["History_list_ID_"..id.."_UI"]:GetText());
		gengxinHistory_neirong(History_neirong_Scroll_UI);
	end)
	if id~=hang_NUM then
		local list_line = list:CreateLine()
		list_line:SetColorTexture(1,1,1,0.2)
		list_line:SetThickness(1.2);
		list_line:SetStartPoint("BOTTOMLEFT",0,-3)
		list_line:SetEndPoint("BOTTOMRIGHT",0,-3)
	end
	-----
	local list_name = list:CreateFontString("History_list_name_"..id.."_UI");
	list_name:SetPoint("TOPLEFT",list,"TOPLEFT",30,-1.4);
	list_name:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	list_name:SetTextColor(1, 215/255, 0, 1);
	local list_time = list:CreateFontString("History_list_time_"..id.."_UI");
	list_time:SetPoint("TOPLEFT",list_name,"BOTTOMLEFT",1,-1);
	list_time:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	list_time:SetTextColor(0, 1, 154/255, 1);
	local list_ID = list:CreateFontString("History_list_ID_"..id.."_UI");
	list_ID:SetPoint("RIGHT",list_name,"LEFT",0,-6);
	list_ID:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
	list_ID:SetTextColor(1, 1, 1, 0.3);
end
-----
local History_neirong = CreateFrame("Frame", "History_neirong_UI", History,"BackdropTemplate");
History_neirong:SetBackdrop({edgeFile = "interface/glues/common/textpanel-border.blp", edgeSize = 18,});
History_neirong:SetBackdropBorderColor(1, 1, 1, 0.6);
History_neirong:SetSize(Width*0.7,Height-136);
History_neirong:SetPoint("TOPRIGHT",History,"TOPRIGHT",-10,-28);
local History_neirong_biaoti = History_neirong:CreateFontString("History_neirong_biaoti_UI");
History_neirong_biaoti:SetPoint("BOTTOM",History_neirong,"TOP",0,2);
History_neirong_biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
History_neirong_biaoti:SetText("\124cffFFFF00活动详情\124r");
------
--创建可滚动区域
local History_neirong_Scroll = CreateFrame("ScrollFrame","History_neirong_Scroll_UI",History_neirong, "FauxScrollFrameTemplate");  
History_neirong_Scroll:SetPoint("TOPLEFT",History_neirong,"TOPLEFT",0,-4);
History_neirong_Scroll:SetPoint("BOTTOMRIGHT",History_neirong,"BOTTOMRIGHT",-26,68);
History_neirong_Scroll:SetScript("OnVerticalScroll", function(self, offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, hang_neirong_Height, gengxinHistory_neirong)
end)
for id = 1, hang_neirong_NUM do
	local neirong= CreateFrame("Frame", "neirong_"..id.."_UI", History_neirong_Scroll:GetParent());
	neirong:SetSize(History_neirong:GetWidth()-26, hang_neirong_Height);
	if id==1 then
		neirong:SetPoint("TOP",History_neirong_Scroll,"TOP",5,0);
	else
		neirong:SetPoint("TOP",_G["neirong_"..(id-1).."_UI"],"BOTTOM",0,0);
	end
	if id~=hang_neirong_NUM then
		local neirong_line = neirong:CreateLine()
		neirong_line:SetColorTexture(1,1,1,0.2)
		neirong_line:SetThickness(1.2);
		neirong_line:SetStartPoint("BOTTOMLEFT",0,0.1)
		neirong_line:SetEndPoint("BOTTOMRIGHT",0,0.1)
	end
	-- -----
	local neirong_1 = neirong:CreateFontString("neirong_1_"..id.."_UI");
	neirong_1:SetPoint("LEFT",neirong,"LEFT",10,0);
	neirong_1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	local neirong_2 = neirong:CreateFontString("neirong_2_"..id.."_UI");
	neirong_2:SetPoint("LEFT",neirong,"LEFT",280,0);
	neirong_2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	local neirong_3 = neirong:CreateFontString("neirong_3_"..id.."_UI");
	neirong_3:SetPoint("LEFT",neirong,"LEFT",380,0);
	neirong_3:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
end
local History_neirong_line1 = History_neirong:CreateLine()
History_neirong_line1:SetColorTexture(1,1,1,0.3)
History_neirong_line1:SetThickness(1.4);
History_neirong_line1:SetStartPoint("LEFT",4,-150)
History_neirong_line1:SetEndPoint("RIGHT",-3,-150)
--汇总
local neirong_Down1 = History_neirong:CreateFontString("neirong_Down1_UI");
neirong_Down1:SetPoint("TOPLEFT",History_neirong_line1,"TOPLEFT",6,-10);
neirong_Down1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
neirong_Down1:SetText("\124cffFFFF00物品收入/G：\124r");
local neirong_Down1_V = History_neirong:CreateFontString("neirong_Down1_V_UI");
neirong_Down1_V:SetPoint("LEFT",neirong_Down1,"RIGHT",0,0);
neirong_Down1_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
local neirong_Down2 = History_neirong:CreateFontString("neirong_Down2_UI");
neirong_Down2:SetPoint("LEFT",neirong_Down1,"RIGHT",47,0);
neirong_Down2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
neirong_Down2:SetText("\124cffFFFF00补助支出/G：\124r");
local neirong_Down2_V = History_neirong:CreateFontString("neirong_Down2_V_UI");
neirong_Down2_V:SetPoint("LEFT",neirong_Down2,"RIGHT",0,0);
neirong_Down2_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
local neirong_Down3 = History_neirong:CreateFontString("neirong_Down3_UI");
neirong_Down3:SetPoint("LEFT",neirong_Down2,"RIGHT",47,0);
neirong_Down3:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
neirong_Down3:SetText("\124cffFFFF00其他收入/G：\124r");
local neirong_Down3_V = History_neirong:CreateFontString("neirong_Down3_V_UI");
neirong_Down3_V:SetPoint("LEFT",neirong_Down3,"RIGHT",0,0);
neirong_Down3_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
local neirong_Down4 = History_neirong:CreateFontString("neirong_Down4_UI");
neirong_Down4:SetPoint("LEFT",neirong_Down3,"RIGHT",47,0);
neirong_Down4:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
neirong_Down4:SetText("\124cffFFFF00奖励支出/G：\124r");
local neirong_Down4_V = History_neirong:CreateFontString("neirong_Down4_V_UI");
neirong_Down4_V:SetPoint("LEFT",neirong_Down4,"RIGHT",0,0);
neirong_Down4_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
local neirong_Down5 = History_neirong:CreateFontString("neirong_Down5_UI");
neirong_Down5:SetPoint("TOPLEFT",neirong_Down1,"BOTTOMLEFT",0,-15);
neirong_Down5:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
neirong_Down5:SetText("\124cffFFFF00总收入/G：\124r");
local neirong_Down5_V = History_neirong:CreateFontString("neirong_Down5_V_UI");
neirong_Down5_V:SetPoint("LEFT",neirong_Down5,"RIGHT",0,0);
neirong_Down5_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
local neirong_Down6 = History_neirong:CreateFontString("neirong_Down6_UI");
neirong_Down6:SetPoint("LEFT",neirong_Down5,"RIGHT",54,0);
neirong_Down6:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
neirong_Down6:SetText("\124cffFFFF00净收入/G：\124r");
local neirong_Down6_V = History_neirong:CreateFontString("neirong_Down6_V_UI");
neirong_Down6_V:SetPoint("LEFT",neirong_Down6,"RIGHT",0,0);
neirong_Down6_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
local neirong_Down7 = History_neirong:CreateFontString("neirong_Down7_UI");
neirong_Down7:SetPoint("LEFT",neirong_Down6,"RIGHT",54,0);
neirong_Down7:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
neirong_Down7:SetText("\124cffFFFF00人均/G：\124r");
local neirong_Down7_V = History_neirong:CreateFontString("neirong_Down7_V_UI");
neirong_Down7_V:SetPoint("LEFT",neirong_Down7,"RIGHT",0,0);
neirong_Down7_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
local neirong_Del = CreateFrame("Button","neirong_Del_UI",History_neirong, "UIPanelButtonTemplate");  
neirong_Del:SetSize(120,24);
neirong_Del:SetPoint("LEFT",neirong_Down7,"RIGHT",68,-2);
neirong_Del:SetText("删除本条记录");
neirong_Del_UI:Disable();
neirong_Del:SetScript("OnClick", function ()
	if History_xuanzhongID>0 then
		table.remove (PIG["RaidRecord"]["History"], History_xuanzhongID);
		History_xuanzhongID=History_xuanzhongID-1;
		if History_xuanzhongID==0 then 
			if #PIG["RaidRecord"]["History"]~=0 then
				History_xuanzhongID=1;
			end
		end
		gengxinHistory(History_list_Scroll_UI);
		gengxinHistory_neirong(History_neirong_Scroll_UI);
	end
end);
--删除历史记录
StaticPopupDialogs["DEL_HISTORY"] = {
	text = "确定\124cffff0000清空\124r\n所有历史记录吗?",
	button1 = "确定",
	button2 = "取消",
	OnAccept = function()
		PIG["RaidRecord"]["History"]={};
		History_xuanzhongID=0;
		gengxinHistory(History_list_Scroll_UI);
		gengxinHistory_neirong(History_neirong_Scroll_UI);
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
local qingkong = CreateFrame("Button","qingkong_UI",History_UI, "UIPanelButtonTemplate");  
qingkong:SetSize(116,24);
qingkong:SetPoint("TOPRIGHT",History_UI,"TOPRIGHT",-40,-4);
qingkong:SetText("清空所有记录");
qingkong:SetScript("OnClick", function ()
	StaticPopup_Show ("DEL_HISTORY");
end);

-------------------
local History_But = CreateFrame("Button","History_But_UI",xiafangFrame_UI, "UIPanelButtonTemplate");  
History_But:SetSize(80,28);
History_But:SetPoint("TOPRIGHT",xiafangFrame_UI,"TOPRIGHT",-2,-6);
History_But:SetText("历史记录");
History_But:SetScript("OnClick", function ()
	fenG_UI:Hide();
	RsettingF_UI:Hide();
	invite_UI:Hide();
	if History_UI:IsShown() then
		History_UI:Hide();
	else
		History_UI:Show();
	end
	gengxinHistory(History_list_Scroll_UI);
end);