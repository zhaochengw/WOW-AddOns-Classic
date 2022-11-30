local _, addonTable = ...;
local hang_Height,hang_NUM  = 33, 12;
local function ADD_buzhu()
	local fuFrame= TablistFrame_2_UI;
	local Width,Height  = fuFrame:GetWidth(), fuFrame:GetHeight();
	--======================
	fuFrame.fengexian = fuFrame:CreateLine()
	fuFrame.fengexian:SetColorTexture(1,1,1,0.3)
	fuFrame.fengexian:SetThickness(1);
	fuFrame.fengexian:SetStartPoint("TOP",0,-2)
	fuFrame.fengexian:SetEndPoint("BOTTOM",0,3)
	-----------------------------------------------------
	--坦克补助
	fuFrame.T_text1 = fuFrame:CreateFontString();
	fuFrame.T_text1:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",28,-14);
	fuFrame.T_text1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.T_text1:SetText("\124cffFFFF00坦克/其他补助\124r");
	fuFrame.T_text1_1 = fuFrame:CreateFontString();
	fuFrame.T_text1_1:SetPoint("LEFT",fuFrame.T_text1,"RIGHT",0,0);
	fuFrame.T_text1_1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	--提示
	fuFrame.T_text1_tishi = CreateFrame("Frame", nil, fuFrame);
	fuFrame.T_text1_tishi:SetSize(hang_Height-16,hang_Height-16);
	fuFrame.T_text1_tishi:SetPoint("RIGHT",fuFrame.T_text1,"LEFT",-1,0);
	fuFrame.T_text1_tishi.Texture = fuFrame.T_text1_tishi:CreateTexture(nil, "BORDER");
	fuFrame.T_text1_tishi.Texture:SetTexture("interface/common/help-i.blp");
	fuFrame.T_text1_tishi.Texture:SetSize(hang_Height-6,hang_Height-6);
	fuFrame.T_text1_tishi.Texture:SetPoint("CENTER");
	fuFrame.T_text1_tishi:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("提示：")
		GameTooltip:AddLine("\124cff00ff00在人员信息界面设置坦克补助/其他补助的玩家会显示在此处。\n如需修改请到人员信息界面修改。\124r")
		GameTooltip:Show();
	end);
	fuFrame.T_text1_tishi:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	fuFrame.T_text2 = fuFrame:CreateFontString();
	fuFrame.T_text2:SetPoint("LEFT",fuFrame.T_text1,"RIGHT",26,0);
	fuFrame.T_text2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.T_text2:SetText("\124cff00FF00每人/G:\124r");
	fuFrame.T_text2_V = fuFrame:CreateFontString();
	fuFrame.T_text2_V:SetSize(50,20);
	fuFrame.T_text2_V:SetPoint("LEFT",fuFrame.T_text2,"RIGHT",0,0);
	fuFrame.T_text2_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.T_text2_V:SetJustifyH("RIGHT");
	fuFrame.T_E = CreateFrame('EditBox', nil, fuFrame, "InputBoxInstructionsTemplate");
	fuFrame.T_E:SetSize(48,33);
	fuFrame.T_E:SetPoint("LEFT",fuFrame.T_text2,"RIGHT",4,0);
	fuFrame.T_E:SetFontObject(ChatFontNormal);
	fuFrame.T_E:SetMaxLetters(5)
	fuFrame.T_E:Hide()
	fuFrame.T_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.T_E:SetScript("OnEnterPressed", function(self) 
		fuFrame.T_B:Show();
		fuFrame.T_E:Hide();
		fuFrame.T_Q:Hide();
		local NewbuzhuV=self:GetNumber();
		fuFrame.T_text2_V:SetText(NewbuzhuV);
		fuFrame.T_text2_V:Show();
		PIG["RaidRecord"]["buzhuG"][1]=NewbuzhuV;
	end);
	fuFrame.T_E:SetScript("OnEditFocusLost", function()
		fuFrame.T_text2_V:Show();
		fuFrame.T_E:Hide();
		fuFrame.T_Q:Hide();
		fuFrame.T_B:Show();
	end);
	fuFrame.T_B = CreateFrame("Button",nil,fuFrame, "TruncatedButtonTemplate");
	fuFrame.T_B:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	fuFrame.T_B:SetSize(25,25);
	fuFrame.T_B:SetPoint("LEFT", fuFrame.T_text1, "RIGHT", 130,0);
	fuFrame.T_B.Texture = fuFrame.T_B:CreateTexture(nil, "BORDER");
	fuFrame.T_B.Texture:SetTexture("interface/buttons/ui-guildbutton-officernote-up.blp");
	fuFrame.T_B.Texture:SetPoint("CENTER");
	fuFrame.T_B.Texture:SetSize(19,22);
	fuFrame.T_B:SetScript("OnMouseDown", function (self)
		self.Texture:SetPoint("CENTER",-1.5,-1.5);
	end);
	fuFrame.T_B:SetScript("OnMouseUp", function (self)
		self.Texture:SetPoint("CENTER");
	end);
	fuFrame.T_B:SetScript("OnClick", function (self)
		fuFrame.T_text2_V:Hide();
		fuFrame.T_B:Hide();
		fuFrame.T_E:Show();
		fuFrame.T_Q:Show();
		fuFrame.T_E:SetText(PIG["RaidRecord"]["buzhuG"][1]);
	end);
	fuFrame.T_Q = CreateFrame("Button","fuFrame.T_Q",fuFrame, "UIPanelButtonTemplate");
	fuFrame.T_Q:SetSize(35,24);
	fuFrame.T_Q:SetPoint("LEFT", fuFrame.T_text1, "RIGHT", 130,0);
	fuFrame.T_Q:Hide();
	fuFrame.T_Q:SetText('确定');
	local buttonFont=fuFrame.T_Q:GetFontString()
	buttonFont:SetFont(ChatFontNormal:GetFont(), 11);
	fuFrame.T_Q:SetScript("OnClick", function (self)
		fuFrame.T_B:Show();
		fuFrame.T_E:Hide();
		fuFrame.T_Q:Hide();
		local NewbuzhuV=fuFrame.T_E:GetNumber();
		fuFrame.T_text2_V:SetText(NewbuzhuV);
		fuFrame.T_text2_V:Show();
		PIG["RaidRecord"]["buzhuG"][1]=NewbuzhuV;
	end);
	------------
	fuFrame.T_List = CreateFrame("Frame", nil, fuFrame);
	fuFrame.T_List:SetSize(Width/2,Height-36);
	fuFrame.T_List:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",0,-36);
	fuFrame.T_List.line_T = fuFrame.T_List:CreateLine()
	fuFrame.T_List.line_T:SetColorTexture(1,1,1,0.3)
	fuFrame.T_List.line_T:SetThickness(1);
	fuFrame.T_List.line_T:SetStartPoint("TOPLEFT",5,-4)
	fuFrame.T_List.line_T:SetEndPoint("TOPRIGHT",-0,-4)
	----------------
	local zhizeIcon = {{0.01,0.26,0.26,0.51},{0.27,0.52,0,0.25},{0.01,0.26,0,0.25}}
	local function Updatebuzhu_T(self)
		fuFrame.T_text2_V:SetText(PIG["RaidRecord"]["buzhuG"][1]);
		for i = 1, hang_NUM do
			fuFrame.T_text1_1:SetText(0);
			_G["buzhu_T_hang_"..i]:Hide();
			_G["buzhu_T_hang_"..i].G.E:Hide();
			_G["buzhu_T_hang_"..i].G.Q:Hide();
	    end
	    local Trenyuan={};
	    for i=1, 8 do
	    	if #PIG["RaidRecord"]["Raidinfo"][i]>0 then
				for ii=1, #PIG["RaidRecord"]["Raidinfo"][i] do
					if PIG["RaidRecord"]["Raidinfo"][i][ii][5]=="坦克补助" or PIG["RaidRecord"]["Raidinfo"][i][ii][5]=="其他补助" then
						table.insert(Trenyuan,PIG["RaidRecord"]["Raidinfo"][i][ii]);
					end
				end
			end
		end

		if #Trenyuan>0 then
			fuFrame.T_text1_1:SetText(#Trenyuan);
		    local ItemsNum = #Trenyuan;
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
		    local offset = FauxScrollFrame_GetOffset(self);
			for i = 1, hang_NUM do
				local dangqian = i+offset;
				if Trenyuan[dangqian] then
					local fameX = _G["buzhu_T_hang_"..i]
					fameX:Show();
					if Trenyuan[dangqian][5]=="坦克补助" then
						fameX.Tex:SetTexCoord(zhizeIcon[1][1],zhizeIcon[1][2],zhizeIcon[1][3],zhizeIcon[1][4]);
					elseif Trenyuan[dangqian][5]=="治疗补助" then
						fameX.Tex:SetTexCoord(zhizeIcon[2][1],zhizeIcon[2][2],zhizeIcon[2][3],zhizeIcon[2][4]);
					elseif Trenyuan[dangqian][5]=="其他补助" then
						fameX.Tex:SetTexCoord(zhizeIcon[3][1],zhizeIcon[3][2],zhizeIcon[3][3],zhizeIcon[3][4]);				
					end
					fameX.name:SetText(Trenyuan[dangqian][4]);
					fameX.name:SetTextColor(Trenyuan[dangqian][2][1], Trenyuan[dangqian][2][2], Trenyuan[dangqian][2][3], 1);
					fameX.G.V:SetText(Trenyuan[dangqian][6]);
				end
		    end
		end
		addonTable.RaidRecord_UpdateG();
	end
	addonTable.RaidRecord_Updatebuzhu_T=Updatebuzhu_T;
	---
	fuFrame.T_piliang = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");  
	fuFrame.T_piliang:SetSize(70,24);
	fuFrame.T_piliang:SetPoint("LEFT",fuFrame.T_text1,"LEFT",264,0);
	fuFrame.T_piliang:SetText("批量设置");
	local buttonFont=fuFrame.T_piliang:GetFontString()
	buttonFont:SetFont(ChatFontNormal:GetFont(), 11);
	fuFrame.T_piliang:SetScript("OnClick", function ()
		for i=1, 8 do
			if #PIG["RaidRecord"]["Raidinfo"][i]>0 then
				for ii=1, #PIG["RaidRecord"]["Raidinfo"][i] do
					if PIG["RaidRecord"]["Raidinfo"][i][ii][5]=="坦克补助" or PIG["RaidRecord"]["Raidinfo"][i][ii][5]=="其他补助" then
						PIG["RaidRecord"]["Raidinfo"][i][ii][6]=PIG["RaidRecord"]["buzhuG"][1];
					end
				end
			end
		end
		Updatebuzhu_T(fuFrame.T_List.Scroll)
	end);
	fuFrame.bobaobuzhu_T = CreateFrame("Button",nil,fuFrame);  
	fuFrame.bobaobuzhu_T:SetSize(26,26);
	fuFrame.bobaobuzhu_T:SetPoint("LEFT",fuFrame.T_piliang,"RIGHT",4,-0);
	fuFrame.bobaobuzhu_T.highlight = fuFrame.bobaobuzhu_T:CreateTexture(nil, "HIGHLIGHT");
	fuFrame.bobaobuzhu_T.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
	fuFrame.bobaobuzhu_T.highlight:SetBlendMode("ADD")
	fuFrame.bobaobuzhu_T.highlight:SetPoint("CENTER", fuFrame.bobaobuzhu_T, "CENTER", 0,0);
	fuFrame.bobaobuzhu_T.highlight:SetSize(22,22);
	fuFrame.bobaobuzhu_T.Tex = fuFrame.bobaobuzhu_T:CreateTexture(nil, "BORDER");
	fuFrame.bobaobuzhu_T.Tex:SetTexture(130979);
	fuFrame.bobaobuzhu_T.Tex:SetPoint("CENTER",4,0);
	fuFrame.bobaobuzhu_T.Tex:SetSize(24,24);
	fuFrame.bobaobuzhu_T:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
		GameTooltip:AddLine("|cff00ff00点击播报补助明细|r")
		GameTooltip:Show();
	end);
	fuFrame.bobaobuzhu_T:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	fuFrame.bobaobuzhu_T:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",2.5,-1.5);
	end);
	fuFrame.bobaobuzhu_T:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER",4,0);
	end);
	fuFrame.bobaobuzhu_T:SetScript("OnClick", function()
		for x=1,#PIG["RaidRecord"]["Raidinfo"] do
			for xx=1,#PIG["RaidRecord"]["Raidinfo"][x] do
				if PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="坦克补助" then
					SendChatMessage("["..PIG["RaidRecord"]["Raidinfo"][x][xx][5].."]-"..PIG["RaidRecord"]["Raidinfo"][x][xx][4].."-支出："..PIG["RaidRecord"]["Raidinfo"][x][xx][6].."G", RaidR_UI.xuanzhongChat, nil);
				end
			end
		end
		for x=1,#PIG["RaidRecord"]["Raidinfo"] do
			for xx=1,#PIG["RaidRecord"]["Raidinfo"][x] do
				if PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="其他补助" then
					SendChatMessage("["..PIG["RaidRecord"]["Raidinfo"][x][xx][5].."]-"..PIG["RaidRecord"]["Raidinfo"][x][xx][4].."-支出："..PIG["RaidRecord"]["Raidinfo"][x][xx][6].."G", RaidR_UI.xuanzhongChat, nil);
				end
			end
		end
	end)
	----创建可滚动区域
	fuFrame.T_List.Scroll = CreateFrame("ScrollFrame","fuFrame.T_List.Scroll",fuFrame.T_List, "FauxScrollFrameTemplate");  
	fuFrame.T_List.Scroll:SetPoint("TOPLEFT",fuFrame.T_List,"TOPLEFT",9,-4);
	fuFrame.T_List.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.T_List,"BOTTOMRIGHT",-26,5);
	fuFrame.T_List.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, Updatebuzhu_T)
	end)
	for id = 1, hang_NUM do
		local buzhu_T_hang = CreateFrame("Frame", "buzhu_T_hang_"..id, fuFrame.T_List.Scroll:GetParent());
		buzhu_T_hang:SetSize((Width)/2-30, hang_Height);
		if id==1 then
			buzhu_T_hang:SetPoint("TOP",fuFrame.T_List.Scroll,"TOP",0,0);
		else
			buzhu_T_hang:SetPoint("TOP",_G["buzhu_T_hang_"..(id-1)],"BOTTOM",0,-0);
		end
		buzhu_T_hang.line = buzhu_T_hang:CreateLine()
		buzhu_T_hang.line:SetColorTexture(1,1,1,0.2)
		buzhu_T_hang.line:SetThickness(1);
		buzhu_T_hang.line:SetStartPoint("BOTTOMLEFT",0,-0)
		buzhu_T_hang.line:SetEndPoint("BOTTOMRIGHT",0,-0)
		buzhu_T_hang.Tex = buzhu_T_hang:CreateTexture(nil, "BORDER");
		buzhu_T_hang.Tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
		buzhu_T_hang.Tex:SetPoint("LEFT", buzhu_T_hang, "LEFT", 4,0);
		buzhu_T_hang.Tex:SetSize(hang_Height-6,hang_Height-6);
		buzhu_T_hang.name = buzhu_T_hang:CreateFontString();
		buzhu_T_hang.name:SetPoint("LEFT", buzhu_T_hang, "LEFT", hang_Height+8,0);
		buzhu_T_hang.name:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		--
		buzhu_T_hang.G = CreateFrame("Frame", nil, buzhu_T_hang);
		buzhu_T_hang.G:SetSize(58, hang_Height);
		buzhu_T_hang.G:SetPoint("LEFT", buzhu_T_hang, "LEFT", hang_Height*7,0);
		buzhu_T_hang.G.V = buzhu_T_hang.G:CreateFontString();
		buzhu_T_hang.G.V:SetPoint("RIGHT", buzhu_T_hang.G, "RIGHT", 0,0);
		buzhu_T_hang.G.V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		buzhu_T_hang.G.E = CreateFrame('EditBox', nil, buzhu_T_hang.G, "InputBoxInstructionsTemplate");
		buzhu_T_hang.G.E:SetSize(54,hang_Height);
		buzhu_T_hang.G.E:SetPoint("RIGHT", buzhu_T_hang.G, "RIGHT", 0,0);
		buzhu_T_hang.G.E:SetFontObject(ChatFontNormal);
		buzhu_T_hang.G.E:SetMaxLetters(6)
		buzhu_T_hang.G.E:SetScript("OnEscapePressed", function(self) 
			self:ClearFocus() 
		end);
		buzhu_T_hang.G.E:SetScript("OnEnterPressed", function(self)
			self:Hide();
			local shangjiF=self:GetParent()
			shangjiF.V:Show();
			shangjiF.B:Show();
			shangjiF.Q:Hide();
	 		local Newbuzhu_T=self:GetNumber();
	 		buzhu_T_hang.G.V:SetText(Newbuzhu_T);
	 		local shangjiFF=shangjiF:GetParent()
	 		local bianjiName=shangjiFF.name:GetText();
	 		for i=1, 8 do
				if #PIG["RaidRecord"]["Raidinfo"][i]>0 then
					for ii=1, #PIG["RaidRecord"]["Raidinfo"][i] do
						if PIG["RaidRecord"]["Raidinfo"][i][ii][4]==bianjiName then
							PIG["RaidRecord"]["Raidinfo"][i][ii][6]=Newbuzhu_T;
						end
					end
				end
			end
			Updatebuzhu_T(fuFrame.T_List.Scroll)
		end);
		buzhu_T_hang.G.E:SetScript("OnEditFocusLost", function(self)
			local shangjiF=self:GetParent()
			shangjiF.V:Show();
			shangjiF.B:Show();
			shangjiF.E:Hide();
			shangjiF.Q:Hide()
		end);
		buzhu_T_hang.G.B = CreateFrame("Button",nil,buzhu_T_hang.G, "TruncatedButtonTemplate");
		buzhu_T_hang.G.B:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
		buzhu_T_hang.G.B:SetSize(hang_Height-8,hang_Height-8);
		buzhu_T_hang.G.B:SetPoint("LEFT", buzhu_T_hang.G, "RIGHT", 0,0);
		buzhu_T_hang.G.B.Texture = buzhu_T_hang.G.B:CreateTexture(nil, "BORDER");
		buzhu_T_hang.G.B.Texture:SetTexture("interface/buttons/ui-guildbutton-officernote-up.blp");
		buzhu_T_hang.G.B.Texture:SetPoint("CENTER");
		buzhu_T_hang.G.B.Texture:SetSize(hang_Height-13,hang_Height-13);
		buzhu_T_hang.G.B:SetScript("OnMouseDown", function (self)
			self.Texture:SetPoint("CENTER",-1.5,-1.5);
		end);
		buzhu_T_hang.G.B:SetScript("OnMouseUp", function (self)
			self.Texture:SetPoint("CENTER");
		end);
		buzhu_T_hang.G.B:SetScript("OnClick", function (self)
			for xx=1,hang_NUM do
				_G['buzhu_T_hang_'..xx].G.E:ClearFocus() 
			end
			local shangjiF=self:GetParent()
			shangjiF.V:Hide();
			shangjiF.B:Hide();
			shangjiF.E:Show();
			shangjiF.Q:Show();
	 		shangjiF.E:SetText(shangjiF.V:GetText());
		end);
		buzhu_T_hang.G.Q = CreateFrame("Button","buzhu_T_hang.G.Q_"..id.."_UI",buzhu_T_hang.G, "UIPanelButtonTemplate");
		buzhu_T_hang.G.Q:SetSize(hang_Height,hang_Height-8);
		buzhu_T_hang.G.Q:SetPoint("LEFT", buzhu_T_hang.G, "RIGHT", 1,0);
		buzhu_T_hang.G.Q:Hide();
		buzhu_T_hang.G.Q:SetText('确定');
		local buttonFont=buzhu_T_hang.G.Q:GetFontString()
		buttonFont:SetFont(ChatFontNormal:GetFont(), 11);
		buzhu_T_hang.G.Q:SetScript("OnClick", function (self)
			self:Hide();
			local shangjiF=self:GetParent()
			shangjiF.V:Show();
			shangjiF.B:Show();
			shangjiF.E:Hide();
	 		local Newbuzhu_T=shangjiF.E:GetNumber();
	 		shangjiF.V:SetText(Newbuzhu_T);
	 		local shangjiFF=shangjiF:GetParent()
	 		local bianjiName=shangjiFF.name:GetText();
	 		for i=1, 8 do
				if #PIG["RaidRecord"]["Raidinfo"][i]>0 then
					for ii=1, #PIG["RaidRecord"]["Raidinfo"][i] do
						if PIG["RaidRecord"]["Raidinfo"][i][ii][4]==bianjiName then
							PIG["RaidRecord"]["Raidinfo"][i][ii][6]=Newbuzhu_T;
						end
					end
				end
			end
			Updatebuzhu_T(fuFrame.T_List.Scroll)
		end);
	end
	--==============================================================================
	--治疗补助
	fuFrame.N_text1 = fuFrame:CreateFontString();
	fuFrame.N_text1:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",Width/2+26,-14);
	fuFrame.N_text1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.N_text1:SetText("\124cffFFFF00治疗补助\124r");
	fuFrame.N_text1_1 = fuFrame:CreateFontString();
	fuFrame.N_text1_1:SetPoint("LEFT",fuFrame.N_text1,"RIGHT",0,0);
	fuFrame.N_text1_1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	--提示
	fuFrame.N_text1_tishi = CreateFrame("Frame", nil, fuFrame);
	fuFrame.N_text1_tishi:SetSize(hang_Height-16,hang_Height-16);
	fuFrame.N_text1_tishi:SetPoint("RIGHT",fuFrame.N_text1,"LEFT",-1,0);
	fuFrame.N_text1_tishi.Texture = fuFrame.N_text1_tishi:CreateTexture(nil, "BORDER");
	fuFrame.N_text1_tishi.Texture:SetTexture("interface/common/help-i.blp");
	fuFrame.N_text1_tishi.Texture:SetSize(hang_Height-6,hang_Height-6);
	fuFrame.N_text1_tishi.Texture:SetPoint("CENTER");
	fuFrame.N_text1_tishi:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("提示：")
		GameTooltip:AddLine("\124cff00ff00在人员信息界面设置治疗补助的玩家会显示在此处。\n如需修改请到人员信息界面修改。\124r")
		GameTooltip:Show();
	end);
	fuFrame.N_text1_tishi:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	fuFrame.N_text2 = fuFrame:CreateFontString();
	fuFrame.N_text2:SetPoint("LEFT",fuFrame.N_text1,"RIGHT",30,0);
	fuFrame.N_text2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.N_text2:SetText("\124cff00FF00每人/G:\124r");
	fuFrame.N_text2_V = fuFrame:CreateFontString();
	fuFrame.N_text2_V:SetSize(50,20);
	fuFrame.N_text2_V:SetPoint("LEFT",fuFrame.N_text2,"RIGHT",0,0);
	fuFrame.N_text2_V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.N_text2_V:SetJustifyH("RIGHT");
	fuFrame.N_E = CreateFrame('EditBox', nil, fuFrame, "InputBoxInstructionsTemplate");
	fuFrame.N_E:SetSize(48,33);
	fuFrame.N_E:SetPoint("LEFT",fuFrame.N_text2,"RIGHT",4,0);
	fuFrame.N_E:SetFontObject(ChatFontNormal);
	fuFrame.N_E:SetMaxLetters(5)
	fuFrame.N_E:Hide()
	fuFrame.N_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.N_E:SetScript("OnEnterPressed", function(self) 
		fuFrame.N_B:Show();
		fuFrame.N_E:Hide();
		fuFrame.N_Q:Hide();
		local NewbuzhuV=fuFrame.N_E:GetNumber();
		fuFrame.N_text2_V:SetText(NewbuzhuV);
		fuFrame.N_text2_V:Show();
		PIG["RaidRecord"]["buzhuG"][2]=NewbuzhuV;
	end);
	fuFrame.N_E:SetScript("OnEditFocusLost", function(self)
		fuFrame.N_text2_V:Show();
		fuFrame.N_E:Hide();
		fuFrame.N_Q:Hide();
		fuFrame.N_B:Show();
	end);
	fuFrame.N_B = CreateFrame("Button","fuFrame.N_B",fuFrame, "TruncatedButtonTemplate");
	fuFrame.N_B:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
	fuFrame.N_B:SetSize(25,25);
	fuFrame.N_B:SetPoint("LEFT", fuFrame.N_text1, "RIGHT", 136,0);
	fuFrame.N_B.Texture = fuFrame.N_B:CreateTexture(nil, "BORDER");
	fuFrame.N_B.Texture:SetTexture("interface/buttons/ui-guildbutton-officernote-up.blp");
	fuFrame.N_B.Texture:SetPoint("CENTER");
	fuFrame.N_B.Texture:SetSize(19,22);
	fuFrame.N_B:SetScript("OnMouseDown", function (self)
		self.Texture:SetPoint("CENTER",-1.5,-1.5);
	end);
	fuFrame.N_B:SetScript("OnMouseUp", function (self)
		self.Texture:SetPoint("CENTER");
	end);
	fuFrame.N_B:SetScript("OnClick", function (self)
		fuFrame.N_text2_V:Hide();
		fuFrame.N_B:Hide();
		fuFrame.N_E:Show();
		fuFrame.N_Q:Show();
		fuFrame.N_E:SetText(PIG["RaidRecord"]["buzhuG"][2]);
	end);
	fuFrame.N_Q = CreateFrame("Button","fuFrame.N_Q",fuFrame, "UIPanelButtonTemplate");
	fuFrame.N_Q:SetSize(35,24);
	fuFrame.N_Q:SetPoint("LEFT", fuFrame.N_text1, "RIGHT", 138,0);
	fuFrame.N_Q:Hide();
	fuFrame.N_Q:SetText('确定');
	buttonFont=fuFrame.N_Q:GetFontString()
	buttonFont:SetFont(ChatFontNormal:GetFont(), 11);
	fuFrame.N_Q:SetScript("OnClick", function (self)
		fuFrame.N_B:Show();
		fuFrame.N_E:Hide();
		fuFrame.N_Q:Hide();
		local NewbuzhuV=fuFrame.N_E:GetNumber();
		fuFrame.N_text2_V:SetText(NewbuzhuV);
		fuFrame.N_text2_V:Show();
		PIG["RaidRecord"]["buzhuG"][2]=NewbuzhuV;
	end);
	---------------
	fuFrame.N_List = CreateFrame("Frame",nil, fuFrame);
	fuFrame.N_List:SetSize(Width/2,Height-36);
	fuFrame.N_List:SetPoint("TOPRIGHT",fuFrame,"TOPRIGHT",0,-36);
	fuFrame.N_List.line_N = fuFrame.N_List:CreateLine()
	fuFrame.N_List.line_N:SetColorTexture(1,1,1,0.3)
	fuFrame.N_List.line_N:SetThickness(1);
	fuFrame.N_List.line_N:SetStartPoint("TOPLEFT",0,-4)
	fuFrame.N_List.line_N:SetEndPoint("TOPRIGHT",-2,-4)
	----------------
	local function Updatebuzhu_N(self)
		fuFrame.N_text2_V:SetText(PIG["RaidRecord"]["buzhuG"][2]);
		for i = 1, hang_NUM do
			fuFrame.N_text1_1:SetText(0);
			_G["buzhu_N_hang_"..i]:Hide();
			_G["buzhu_N_hang_"..i].G.E:Hide();
			_G["buzhu_N_hang_"..i].G.Q:Hide();
	    end
	    local Nrenyuan={};
	    for i=1, 8 do
	    	if #PIG["RaidRecord"]["Raidinfo"][i]>0 then
				for ii=1, #PIG["RaidRecord"]["Raidinfo"][i] do
					if PIG["RaidRecord"]["Raidinfo"][i][ii][5]=="治疗补助" then
						table.insert(Nrenyuan,PIG["RaidRecord"]["Raidinfo"][i][ii]);
					end
				end
			end
		end
		if #Nrenyuan>0 then
			fuFrame.N_text1_1:SetText(#Nrenyuan);
		    local ItemsNum = #Nrenyuan;
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
		    local offset = FauxScrollFrame_GetOffset(self);
			for i = 1, hang_NUM do
				local dangqian = i+offset;
				if Nrenyuan[dangqian] then
					local fameX = _G["buzhu_N_hang_"..i]
					fameX:Show();
					if Nrenyuan[dangqian][5]=="坦克补助" then
						fameX.Tex:SetTexCoord(zhizeIcon[1][1],zhizeIcon[1][2],zhizeIcon[1][3],zhizeIcon[1][4]);
					elseif Nrenyuan[dangqian][5]=="治疗补助" then
						fameX.Tex:SetTexCoord(zhizeIcon[2][1],zhizeIcon[2][2],zhizeIcon[2][3],zhizeIcon[2][4]);
					elseif Nrenyuan[dangqian][5]=="其他补助" then
						fameX.Tex:SetTexCoord(zhizeIcon[3][1],zhizeIcon[3][2],zhizeIcon[3][3],zhizeIcon[3][4]);				
					end
					fameX.name:SetText(Nrenyuan[dangqian][4]);
					fameX.name:SetTextColor(Nrenyuan[dangqian][2][1], Nrenyuan[dangqian][2][2], Nrenyuan[dangqian][2][3], 1);
					fameX.G.V:SetText(Nrenyuan[dangqian][6]);
				end
		    end
		end
		addonTable.RaidRecord_UpdateG();
	end
	addonTable.RaidRecord_Updatebuzhu_N=Updatebuzhu_N;
	---
	fuFrame.N_piliang = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");  
	fuFrame.N_piliang:SetSize(70,26);
	fuFrame.N_piliang:SetPoint("LEFT",fuFrame.N_text1,"LEFT",250,0);
	fuFrame.N_piliang:SetText("批量设置");
	local buttonFont=fuFrame.N_piliang:GetFontString()
	buttonFont:SetFont(ChatFontNormal:GetFont(), 11);
	fuFrame.N_piliang:SetScript("OnClick", function ()
		for i=1, 8 do
			if #PIG["RaidRecord"]["Raidinfo"][i]>0 then
				for ii=1, #PIG["RaidRecord"]["Raidinfo"][i] do
					if PIG["RaidRecord"]["Raidinfo"][i][ii][5]=="治疗补助" then
						PIG["RaidRecord"]["Raidinfo"][i][ii][6]=PIG["RaidRecord"]["buzhuG"][2];
					end
				end
			end
		end
		Updatebuzhu_N(fuFrame.N_List.Scroll)
	end);
	----
	fuFrame.bobaobuzhu_N = CreateFrame("Button",nil,fuFrame);  
	fuFrame.bobaobuzhu_N:SetSize(26,26);
	fuFrame.bobaobuzhu_N:SetPoint("LEFT",fuFrame.N_piliang,"RIGHT",4,-0);
	fuFrame.bobaobuzhu_N.highlight = fuFrame.bobaobuzhu_N:CreateTexture(nil, "HIGHLIGHT");
	fuFrame.bobaobuzhu_N.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
	fuFrame.bobaobuzhu_N.highlight:SetBlendMode("ADD")
	fuFrame.bobaobuzhu_N.highlight:SetPoint("CENTER", fuFrame.bobaobuzhu_N, "CENTER", 0,0);
	fuFrame.bobaobuzhu_N.highlight:SetSize(22,22);
	fuFrame.bobaobuzhu_N.Tex = fuFrame.bobaobuzhu_N:CreateTexture(nil, "BORDER");
	fuFrame.bobaobuzhu_N.Tex:SetTexture(130979);
	fuFrame.bobaobuzhu_N.Tex:SetPoint("CENTER",4,0);
	fuFrame.bobaobuzhu_N.Tex:SetSize(24,24);
	fuFrame.bobaobuzhu_N:SetScript("OnEnter", function ()
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(fuFrame.bobaobuzhu_N, "ANCHOR_TOPLEFT",20,0);
		GameTooltip:AddLine("|cff00ff00点击播报补助明细|r")
		GameTooltip:Show();
	end);
	fuFrame.bobaobuzhu_N:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	fuFrame.bobaobuzhu_N:SetScript("OnMouseDown", function ()
		fuFrame.bobaobuzhu_N.Tex:SetPoint("CENTER",2.5,-1.5);
	end);
	fuFrame.bobaobuzhu_N:SetScript("OnMouseUp", function ()
		fuFrame.bobaobuzhu_N.Tex:SetPoint("CENTER",4,0);
	end);
	fuFrame.bobaobuzhu_N:SetScript("OnClick", function()
		for x=1,#PIG["RaidRecord"]["Raidinfo"] do
			for xx=1,#PIG["RaidRecord"]["Raidinfo"][x] do
				if PIG["RaidRecord"]["Raidinfo"][x][xx][5]=="治疗补助" then
					SendChatMessage("["..PIG["RaidRecord"]["Raidinfo"][x][xx][5].."]-"..PIG["RaidRecord"]["Raidinfo"][x][xx][4].."-支出："..PIG["RaidRecord"]["Raidinfo"][x][xx][6].."G", RaidR_UI.xuanzhongChat, nil);
				end
			end
		end
	end)
	----创建可滚动区域
	fuFrame.N_List.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.N_List, "FauxScrollFrameTemplate");  
	fuFrame.N_List.Scroll:SetPoint("TOPLEFT",fuFrame.N_List,"TOPLEFT",4,-4);
	fuFrame.N_List.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.N_List,"BOTTOMRIGHT",-26,5);
	fuFrame.N_List.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, Updatebuzhu_N)
	end)
	for id = 1, hang_NUM do
		local buzhu_N_hang = CreateFrame("Frame", "buzhu_N_hang_"..id, fuFrame.N_List.Scroll:GetParent());
		buzhu_N_hang:SetSize((Width)/2-30, hang_Height);
		if id==1 then
			buzhu_N_hang:SetPoint("TOP",fuFrame.N_List.Scroll,"TOP",0,0);
		else
			buzhu_N_hang:SetPoint("TOP",_G["buzhu_N_hang_"..(id-1)],"BOTTOM",0,-0);
		end
		buzhu_N_hang.line = buzhu_N_hang:CreateLine()
		buzhu_N_hang.line:SetColorTexture(1,1,1,0.2)
		buzhu_N_hang.line:SetThickness(1);
		buzhu_N_hang.line:SetStartPoint("BOTTOMLEFT",0,-0)
		buzhu_N_hang.line:SetEndPoint("BOTTOMRIGHT",0,-0)
		buzhu_N_hang.Tex = buzhu_N_hang:CreateTexture(nil, "BORDER");
		buzhu_N_hang.Tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
		buzhu_N_hang.Tex:SetPoint("LEFT", buzhu_N_hang, "LEFT", 4,0);
		buzhu_N_hang.Tex:SetSize(hang_Height-6,hang_Height-6);
		buzhu_N_hang.name = buzhu_N_hang:CreateFontString();
		buzhu_N_hang.name:SetPoint("LEFT", buzhu_N_hang, "LEFT", hang_Height+8,0);
		buzhu_N_hang.name:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		--
		buzhu_N_hang.G = CreateFrame("Frame", nil, buzhu_N_hang);
		buzhu_N_hang.G:SetSize(58, hang_Height);
		buzhu_N_hang.G:SetPoint("LEFT", buzhu_N_hang, "LEFT", hang_Height*7,0);
		buzhu_N_hang.G.V = buzhu_N_hang.G:CreateFontString();
		buzhu_N_hang.G.V:SetPoint("RIGHT", buzhu_N_hang.G, "RIGHT", 0,0);
		buzhu_N_hang.G.V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		buzhu_N_hang.G.E = CreateFrame('EditBox', nil, buzhu_N_hang.G, "InputBoxInstructionsTemplate");
		buzhu_N_hang.G.E:SetSize(54,hang_Height);
		buzhu_N_hang.G.E:SetPoint("RIGHT", buzhu_N_hang.G, "RIGHT", 0,0);
		buzhu_N_hang.G.E:SetFontObject(ChatFontNormal);
		buzhu_N_hang.G.E:SetMaxLetters(6)
		buzhu_N_hang.G.E:SetScript("OnEscapePressed", function(self) 
			self:ClearFocus() 
		end);
		buzhu_N_hang.G.E:SetScript("OnEnterPressed", function(self) 
			self:Hide();
			local shangjiF=self:GetParent()
			shangjiF.V:Show();
			shangjiF.B:Show();
			shangjiF.Q:Hide();
	 		local Newbuzhu_N=self:GetNumber();
	 		shangjiF.V:SetText(Newbuzhu_N);
	 		local shangjiFF=shangjiF:GetParent()
			local bianjiName=shangjiFF.name:GetText();
	 		for i=1, 8 do
				if #PIG["RaidRecord"]["Raidinfo"][i]>0 then
					for ii=1, #PIG["RaidRecord"]["Raidinfo"][i] do
						if PIG["RaidRecord"]["Raidinfo"][i][ii][4]==bianjiName then
							PIG["RaidRecord"]["Raidinfo"][i][ii][6]=Newbuzhu_N;
						end
					end
				end
			end
			Updatebuzhu_N(fuFrame.N_List.Scroll)
		end);
		buzhu_N_hang.G.E:SetScript("OnEditFocusLost", function(self)
			local shangjiF=self:GetParent()
			shangjiF.V:Show();
			shangjiF.B:Show();
			shangjiF.E:Hide();
			shangjiF.Q:Hide()
		end);
		buzhu_N_hang.G.B = CreateFrame("Button",nil,buzhu_N_hang.G, "TruncatedButtonTemplate");
		buzhu_N_hang.G.B:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
		buzhu_N_hang.G.B:SetSize(hang_Height-8,hang_Height-8);
		buzhu_N_hang.G.B:SetPoint("LEFT", buzhu_N_hang.G, "RIGHT", 0,0);
		buzhu_N_hang.G.B.Texture = buzhu_N_hang.G.B:CreateTexture(nil, "BORDER");
		buzhu_N_hang.G.B.Texture:SetTexture("interface/buttons/ui-guildbutton-officernote-up.blp");
		buzhu_N_hang.G.B.Texture:SetPoint("CENTER");
		buzhu_N_hang.G.B.Texture:SetSize(hang_Height-13,hang_Height-13);
		buzhu_N_hang.G.B:SetScript("OnMouseDown", function (self)
			self.Texture:SetPoint("CENTER",-1.5,-1.5);
		end);
		buzhu_N_hang.G.B:SetScript("OnMouseUp", function (self)
			self.Texture:SetPoint("CENTER");
		end);
		buzhu_N_hang.G.B:SetScript("OnClick", function (self)
			self:Hide();
			local shangjiF=self:GetParent()
			for xx=1,hang_NUM do
				_G['buzhu_N_hang_'..xx].G.E:ClearFocus() 
			end
			shangjiF.V:Hide();
			shangjiF.E:Show();
			shangjiF.Q:Show();
	 		shangjiF.E:SetText(shangjiF.V:GetText());
		end);
		buzhu_N_hang.G.Q = CreateFrame("Button",nil,buzhu_N_hang.G, "UIPanelButtonTemplate");
		buzhu_N_hang.G.Q:SetSize(hang_Height,hang_Height-8);
		buzhu_N_hang.G.Q:SetPoint("LEFT", buzhu_N_hang.G, "RIGHT", 1,0);
		buzhu_N_hang.G.Q:Hide();
		buzhu_N_hang.G.Q:SetText('确定');
		local buttonFont=buzhu_N_hang.G.Q:GetFontString()
		buttonFont:SetFont(ChatFontNormal:GetFont(), 11);
		buzhu_N_hang.G.Q:SetScript("OnClick", function (self)
			self:Hide();
			local shangjiF=self:GetParent()
			shangjiF.V:Show();
			shangjiF.B:Show();
			shangjiF.E:Hide();
	 		local Newbuzhu_N=shangjiF.E:GetNumber();
	 		shangjiF.V:SetText(Newbuzhu_N);
	 		local shangjiFF=shangjiF:GetParent()
			local bianjiName=shangjiFF.name:GetText();
	 		for i=1, 8 do
				if #PIG["RaidRecord"]["Raidinfo"][i]>0 then
					for ii=1, #PIG["RaidRecord"]["Raidinfo"][i] do
						if PIG["RaidRecord"]["Raidinfo"][i][ii][4]==bianjiName then
							PIG["RaidRecord"]["Raidinfo"][i][ii][6]=Newbuzhu_N;
						end
					end
				end
			end
			Updatebuzhu_N(fuFrame.N_List.Scroll)
		end);
	end
	-------
	fuFrame:SetScript("OnShow", function ()
		Updatebuzhu_T(fuFrame.T_List.Scroll)
		Updatebuzhu_N(fuFrame.N_List.Scroll)
	end)
end
addonTable.ADD_buzhu = ADD_buzhu;