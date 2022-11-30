local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local hang_Height,hang_NUM  = 34, 12;
local function ADD_fakuan()
	local fuFrame = TablistFrame_3_UI
	local Width,Height  = fuFrame:GetWidth(), fuFrame:GetHeight();
	-- --============带本助手====================
	fuFrame.biaoti1 = fuFrame:CreateFontString();
	fuFrame.biaoti1:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",25,-7);
	fuFrame.biaoti1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.biaoti1:SetText("\124cffFFFF00收入事件\124r");
	fuFrame.biaoti2 = fuFrame:CreateFontString();
	fuFrame.biaoti2:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",320,-7);
	fuFrame.biaoti2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.biaoti2:SetText("\124cffFFFF00收入金额/G\124r");
	fuFrame.biaoti3 = fuFrame:CreateFontString();
	fuFrame.biaoti3:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",460,-7);
	fuFrame.biaoti3:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.biaoti3:SetText("\124cffFFFF00欠款/G\124r");
	fuFrame.biaoti3 = fuFrame:CreateFontString();
	fuFrame.biaoti3:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",560,-7);
	fuFrame.biaoti3:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.biaoti3:SetText("\124cffFFFF00出资人\124r");
	--出资人提示
	fuFrame.biaoti3_tishi = CreateFrame("Frame", nil, fuFrame);
	fuFrame.biaoti3_tishi:SetSize(hang_Height-16,hang_Height-16);
	fuFrame.biaoti3_tishi:SetPoint("LEFT",fuFrame.biaoti3,"RIGHT",0,0);
	fuFrame.biaoti3_tishi_Texture = fuFrame.biaoti3_tishi:CreateTexture("fuFrame.biaoti3_tishi_Texture_UI", "BORDER");
	fuFrame.biaoti3_tishi_Texture:SetTexture("interface/common/help-i.blp");
	fuFrame.biaoti3_tishi_Texture:SetSize(hang_Height-6,hang_Height-6);
	fuFrame.biaoti3_tishi_Texture:SetPoint("CENTER");
	fuFrame.biaoti3_tishi:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("请注意：")
		GameTooltip:AddLine("\124cff00ff00未选择\124cffFFff00出资人\124r\124cff00ff00的条目将不会记入罚款和其他收入！\n点击选择受益人\124r")
		GameTooltip:Show();
	end);
	fuFrame.biaoti3_tishi:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	--
	fuFrame.bobaobut = CreateFrame("Button",nil,fuFrame);  
	fuFrame.bobaobut:SetSize(26,26);
	fuFrame.bobaobut:SetPoint("TOPRIGHT",fuFrame,"TOPRIGHT",-5,-2);
	fuFrame.bobaobut.highlight = fuFrame.bobaobut:CreateTexture(nil, "HIGHLIGHT");
	fuFrame.bobaobut.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
	fuFrame.bobaobut.highlight:SetBlendMode("ADD")
	fuFrame.bobaobut.highlight:SetPoint("CENTER", fuFrame.bobaobut, "CENTER", 0,0);
	fuFrame.bobaobut.highlight:SetSize(22,22);
	fuFrame.bobaobut.Tex = fuFrame.bobaobut:CreateTexture(nil, "BORDER");
	fuFrame.bobaobut.Tex:SetTexture(130979);
	fuFrame.bobaobut.Tex:SetPoint("CENTER",4,0);
	fuFrame.bobaobut.Tex:SetSize(24,24);
	fuFrame.bobaobut:SetScript("OnEnter", function ()
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(fuFrame.bobaobut, "ANCHOR_TOPLEFT",20,0);
		GameTooltip:AddLine("|cff00ff00点击播报罚款明细|r")
		GameTooltip:Show();
	end);
	fuFrame.bobaobut:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	fuFrame.bobaobut:SetScript("OnMouseDown", function ()
		fuFrame.bobaobut.Tex:SetPoint("CENTER",2.5,-1.5);
	end);
	fuFrame.bobaobut:SetScript("OnMouseUp", function ()
		fuFrame.bobaobut.Tex:SetPoint("CENTER",4,0);
	end);
	fuFrame.bobaobut:SetScript("OnClick", function()
		for j=1,#PIG["RaidRecord"]["fakuan"] do
			if PIG["RaidRecord"]["fakuan"][j][4]~="无" then
				SendChatMessage("["..PIG["RaidRecord"]["fakuan"][j][1].."]-"..PIG["RaidRecord"]["fakuan"][j][4].."-收入："..PIG["RaidRecord"]["fakuan"][j][2]+PIG["RaidRecord"]["fakuan"][j][3].."G", RaidR_UI.xuanzhongChat, nil);
			end
		end
	end)
	--
	fuFrame.lineT = fuFrame:CreateLine()
	fuFrame.lineT:SetColorTexture(1,1,1,0.2)
	fuFrame.lineT:SetThickness(1);
	fuFrame.lineT:SetStartPoint("TOPLEFT",4,-28)
	fuFrame.lineT:SetEndPoint("TOPRIGHT",-4,-28)
	------------------
	local function UpdateFakuan(self)
		for id = 1, hang_NUM do
			_G["fakuan_hang_"..id.."_UI"]:Hide();
			_G["fakuan_hang_"..id.."_UI"].shiyou:SetText();

			_G["fakuan_hang_"..id.."_UI"].shouru.G:SetText();
			_G["fakuan_hang_"..id.."_UI"].shouru.E:Hide();
			_G["fakuan_hang_"..id.."_UI"].shouru.bianji:Show();
			_G["fakuan_hang_"..id.."_UI"].shouru.baocun:Hide();

			_G["fakuan_hang_"..id.."_UI"].qiankuan.G:SetText();
			_G["fakuan_hang_"..id.."_UI"].qiankuan.E:Hide();
			_G["fakuan_hang_"..id.."_UI"].qiankuan.bianji:Show();
			_G["fakuan_hang_"..id.."_UI"].qiankuan.baocun:Hide();

			_G["fakuan_hang_"..id.."_UI"].chuziren.V:SetText();
			_G["fakuan_hang_"..id.."_UI"].del:Hide();
	    end
		if #PIG["RaidRecord"]["fakuan"]>0 then
		    local ItemsNum = #PIG["RaidRecord"]["fakuan"];
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
		    local offset = FauxScrollFrame_GetOffset(self);
			for id = 1, hang_NUM do
				local dangqian = id+offset;
				if PIG["RaidRecord"]["fakuan"][dangqian] then
					_G["fakuan_hang_"..id.."_UI"]:Show();
					if dangqian==1 then
						_G["fakuan_hang_"..id.."_UI"].shiyou:SetText(PIG["RaidRecord"]["fakuan"][dangqian][1]);
					elseif dangqian==2 then	
			    		_G["fakuan_hang_"..id.."_UI"].shiyou:SetText("|cff00FA9A"..PIG["RaidRecord"]["fakuan"][dangqian][1].."|r");
			    	elseif dangqian<6 then
			    		_G["fakuan_hang_"..id.."_UI"].shiyou:SetText(PIG["RaidRecord"]["fakuan"][dangqian][1]);
			    	elseif dangqian<9 then
			    		_G["fakuan_hang_"..id.."_UI"].shiyou:SetText("|cff00FA9A"..PIG["RaidRecord"]["fakuan"][dangqian][1].."|r");
			    	else
			    		_G["fakuan_hang_"..id.."_UI"].shiyou:SetText(PIG["RaidRecord"]["fakuan"][dangqian][1]);
			    	end
			    	_G["fakuan_hang_"..id.."_UI"].shouru.G:SetText(PIG["RaidRecord"]["fakuan"][dangqian][2]);
					_G["fakuan_hang_"..id.."_UI"].shouru.E:SetID(dangqian);
					_G["fakuan_hang_"..id.."_UI"].shouru.bianji:SetID(dangqian);
					_G["fakuan_hang_"..id.."_UI"].shouru.baocun:SetID(dangqian);

			    	_G["fakuan_hang_"..id.."_UI"].qiankuan.G:SetText(PIG["RaidRecord"]["fakuan"][dangqian][3]);
					_G["fakuan_hang_"..id.."_UI"].qiankuan.E:SetID(dangqian);
					_G["fakuan_hang_"..id.."_UI"].qiankuan.bianji:SetID(dangqian);
					_G["fakuan_hang_"..id.."_UI"].qiankuan.baocun:SetID(dangqian);

					_G["fakuan_hang_"..id.."_UI"].chuziren.V:SetText(PIG["RaidRecord"]["fakuan"][dangqian][4]);
					_G["fakuan_hang_"..id.."_UI"].chuziren:SetID(dangqian);
			    	_G["fakuan_hang_"..id.."_UI"].del:SetID(dangqian);
					_G["fakuan_hang_"..id.."_UI"].del:Show();
				end
			end
		end
		addonTable.RaidRecord_UpdateG();
	end
	addonTable.RaidRecord_UpdateFakuan=UpdateFakuan;
	--刷新选择框角色
	local function Updatefakuanxuanze()
		if xuanzechuziren_UI:IsShown() then
			for p=1,8 do
				for pp=1,5 do
					_G["chuzirenXZP_"..p.."_"..pp]:Hide();
					_G["chuzirenXZP_"..p.."_"..pp].Name:SetText();
					_G["chuzirenXZP_"..p.."_"..pp].Name_XS:SetText();
				end
		    end
			for p=1,8 do
				if #PIG["RaidRecord"]["Raidinfo"][p]>0 then
					for pp=1,#PIG["RaidRecord"]["Raidinfo"][p] do
					   	if PIG["RaidRecord"]["Raidinfo"][p][pp][4]~=nil then
					   		_G["chuzirenXZP_"..p.."_"..pp]:Show();
							_G["chuzirenXZP_"..p.."_"..pp].Name:SetText(PIG["RaidRecord"]["Raidinfo"][p][pp][4]);
							local _, _, _, wanjiaName = PIG["RaidRecord"]["Raidinfo"][p][pp][4]:find("((.+)-)");
							if wanjiaName then
								_G["chuzirenXZP_"..p.."_"..pp].Name_XS:SetText(wanjiaName);
							else
								_G["chuzirenXZP_"..p.."_"..pp].Name_XS:SetText(PIG["RaidRecord"]["Raidinfo"][p][pp][4]);
							end
							_G["chuzirenXZP_"..p.."_"..pp].Name_XS:SetTextColor(PIG["RaidRecord"]["Raidinfo"][p][pp][2][1],PIG["RaidRecord"]["Raidinfo"][p][pp][2][2],PIG["RaidRecord"]["Raidinfo"][p][pp][2][3], 1);
					   	end
					end
				end
			end
		end
	end
	addonTable.RaidRecord_Updatefakuanxuanze = Updatefakuanxuanze;
	--
	fuFrame:SetScript("OnShow", function ()
		UpdateFakuan(fakuan_Scroll_UI)
	end)
	--创建可滚动区域
	local fakuan_Scroll = CreateFrame("ScrollFrame","fakuan_Scroll_UI",fuFrame, "FauxScrollFrameTemplate");  
	fakuan_Scroll:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",5,-hang_Height+6);
	fakuan_Scroll:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",-27,5);
	fakuan_Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, UpdateFakuan)
	end)
	for id = 1, hang_NUM do
		local fakuan_hang= CreateFrame("Frame", "fakuan_hang_"..id.."_UI", fakuan_Scroll:GetParent());
		fakuan_hang:SetSize(Width-30, hang_Height);
		if id==1 then
			fakuan_hang:SetPoint("TOP",fakuan_Scroll,"TOP",0,0);
		else
			fakuan_hang:SetPoint("TOP",_G["fakuan_hang_"..(id-1).."_UI"],"BOTTOM",0,-0);
		end
		fakuan_hang.line = fakuan_hang:CreateLine()
		fakuan_hang.line:SetColorTexture(1,1,1,0.2)
		fakuan_hang.line:SetThickness(1);
		fakuan_hang.line:SetStartPoint("BOTTOMLEFT",0,0)
		fakuan_hang.line:SetEndPoint("BOTTOMRIGHT",0,0)
		-----
		fakuan_hang.shiyou = fakuan_hang:CreateFontString();
		fakuan_hang.shiyou:SetPoint("LEFT",fakuan_hang,"LEFT",18,0);
		fakuan_hang.shiyou:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		fakuan_hang.shiyou:SetText();
		---------
		fakuan_hang.shouru = CreateFrame("Frame", nil, fakuan_hang);
		fakuan_hang.shouru:SetSize(70, hang_Height);
		fakuan_hang.shouru:SetPoint("LEFT", fakuan_hang, "LEFT", 306,0);
		fakuan_hang.shouru.G = fakuan_hang.shouru:CreateFontString();
		fakuan_hang.shouru.G:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		fakuan_hang.shouru.G:SetPoint("RIGHT", fakuan_hang.shouru, "RIGHT", 0,0);
		fakuan_hang.shouru.G:SetTextColor(0, 1, 1, 1);
		fakuan_hang.shouru.E = CreateFrame('EditBox', nil, fakuan_hang.shouru, "InputBoxInstructionsTemplate");
		fakuan_hang.shouru.E:SetSize(60,hang_Height);
		fakuan_hang.shouru.E:SetPoint("RIGHT",fakuan_hang.shouru,"RIGHT",0,0);
		fakuan_hang.shouru.E:SetFontObject(ChatFontNormal);
		fakuan_hang.shouru.E:SetMaxLetters(7)
		fakuan_hang.shouru.E:SetScript("OnEscapePressed", function(self) 
			self:ClearFocus() 
		end);
		fakuan_hang.shouru.E:SetScript("OnEnterPressed", function(self) 
			local fujiFrame=self:GetParent()
			fujiFrame.G:Show()
			fujiFrame.bianji:Show()
			self:Hide();
			fujiFrame.baocun:Hide()
	 		local NWEdanjiaV=self:GetNumber();
	 		fujiFrame.G:SetText(NWEdanjiaV);
			PIG["RaidRecord"]["fakuan"][self:GetID()][2]=NWEdanjiaV;
			UpdateFakuan(fakuan_Scroll_UI)
		end);
		fakuan_hang.shouru.E:SetScript("OnEditFocusLost", function(self)
			local fujiFrame=self:GetParent()
			self:Hide();
			fujiFrame.G:Show()
			fujiFrame.bianji:Show()
			fujiFrame.baocun:Hide()
		end);
		fakuan_hang.shouru.bianji = CreateFrame("Button",nil,fakuan_hang.shouru, "TruncatedButtonTemplate");
		fakuan_hang.shouru.bianji:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
		fakuan_hang.shouru.bianji:SetSize(hang_Height-8,hang_Height-8);
		fakuan_hang.shouru.bianji:SetPoint("LEFT", fakuan_hang.shouru, "RIGHT", -2,0);
		fakuan_hang.shouru.bianji.Tex = fakuan_hang.shouru.bianji:CreateTexture(nil, "BORDER");
		fakuan_hang.shouru.bianji.Tex:SetTexture("interface/buttons/ui-guildbutton-officernote-up.blp");
		fakuan_hang.shouru.bianji.Tex:SetPoint("CENTER");
		fakuan_hang.shouru.bianji.Tex:SetSize(hang_Height-16,hang_Height-14);
		fakuan_hang.shouru.bianji:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1.5,-1.5);
		end);
		fakuan_hang.shouru.bianji:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		fakuan_hang.shouru.bianji:SetScript("OnClick", function (self)
			for xx=1,hang_NUM do
				_G["fakuan_hang_"..xx.."_UI"].shouru.E:ClearFocus() 
				_G["fakuan_hang_"..xx.."_UI"].qiankuan.E:ClearFocus() 
			end
			local fujiFrame=self:GetParent()
			self:Hide();
			fujiFrame.G:Hide()
			fujiFrame.E:Show()
			fujiFrame.baocun:Show()
			fujiFrame.E:SetText(PIG["RaidRecord"]["fakuan"][self:GetID()][2])
		end);
		fakuan_hang.shouru.baocun = CreateFrame("Button",nil,fakuan_hang.shouru, "UIPanelButtonTemplate");
		fakuan_hang.shouru.baocun:SetSize(hang_Height,hang_Height-10);
		fakuan_hang.shouru.baocun:SetPoint("LEFT", fakuan_hang.shouru, "RIGHT", 2,0);
		fakuan_hang.shouru.baocun:Hide();
		fakuan_hang.shouru.baocun:SetText('确定');
		buttonFont=fakuan_hang.shouru.baocun:GetFontString()
		buttonFont:SetFont(ChatFontNormal:GetFont(), 12);
		fakuan_hang.shouru.baocun:SetScript("OnClick", function (self)
			local fujiFrame=self:GetParent()
			fujiFrame.G:Show()
			fujiFrame.bianji:Show()
			fujiFrame.E:Hide();
			self:Hide()
	 		local NWEdanjiaV=fujiFrame.E:GetNumber();
	 		fujiFrame.G:SetText(NWEdanjiaV);
			PIG["RaidRecord"]["fakuan"][self:GetID()][2]=NWEdanjiaV;
			UpdateFakuan(fakuan_Scroll_UI)
		end);
		-----欠款-----
		fakuan_hang.qiankuan = CreateFrame("Frame", "fakuan_hang.qiankuan_"..id.."_UI", fakuan_hang);
		fakuan_hang.qiankuan:SetSize(70, hang_Height);
		fakuan_hang.qiankuan:SetPoint("LEFT", fakuan_hang, "LEFT", 420,0);
		fakuan_hang.qiankuan.G = fakuan_hang.qiankuan:CreateFontString();
		fakuan_hang.qiankuan.G:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		fakuan_hang.qiankuan.G:SetPoint("RIGHT", fakuan_hang.qiankuan, "RIGHT", 0,0);
		fakuan_hang.qiankuan.G:SetTextColor(252/255, 69/255, 0/255, 1);
		fakuan_hang.qiankuan.E = CreateFrame('EditBox', nil, fakuan_hang.qiankuan, "InputBoxInstructionsTemplate");
		fakuan_hang.qiankuan.E:SetSize(60,hang_Height);
		fakuan_hang.qiankuan.E:SetPoint("RIGHT",fakuan_hang.qiankuan,"RIGHT",0,0);
		fakuan_hang.qiankuan.E:SetFontObject(ChatFontNormal);
		fakuan_hang.qiankuan.E:SetMaxLetters(7)
		fakuan_hang.qiankuan.E:SetScript("OnEscapePressed", function(self) 
			self:ClearFocus() 
		end);
		fakuan_hang.qiankuan.E:SetScript("OnEnterPressed", function(self) 
			local fujiFrame=self:GetParent()
			fujiFrame.G:Show()
			fujiFrame.bianji:Show()
			self:Hide();
			fujiFrame.baocun:Hide()
	 		local NWEdanjiaV=self:GetNumber();
	 		fujiFrame.G:SetText(NWEdanjiaV);
			PIG["RaidRecord"]["fakuan"][self:GetID()][3]=NWEdanjiaV;
			UpdateFakuan(fakuan_Scroll_UI)
		end);
		fakuan_hang.qiankuan.E:SetScript("OnEditFocusLost", function(self)
			local fujiFrame=self:GetParent()
			self:Hide();
			fujiFrame.G:Show()
			fujiFrame.bianji:Show()
			fujiFrame.baocun:Hide()
		end);
		fakuan_hang.qiankuan.bianji = CreateFrame("Button",nil,fakuan_hang.qiankuan, "TruncatedButtonTemplate");
		fakuan_hang.qiankuan.bianji:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
		fakuan_hang.qiankuan.bianji:SetSize(hang_Height-8,hang_Height-8);
		fakuan_hang.qiankuan.bianji:SetPoint("LEFT", fakuan_hang.qiankuan, "RIGHT", -2,0);
		fakuan_hang.qiankuan.bianji.Tex = fakuan_hang.qiankuan.bianji:CreateTexture(nil, "BORDER");
		fakuan_hang.qiankuan.bianji.Tex:SetTexture("interface/buttons/ui-guildbutton-officernote-up.blp");
		fakuan_hang.qiankuan.bianji.Tex:SetPoint("CENTER");
		fakuan_hang.qiankuan.bianji.Tex:SetSize(hang_Height-16,hang_Height-14);
		fakuan_hang.qiankuan.bianji:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1.5,-1.5);
		end);
		fakuan_hang.qiankuan.bianji:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		fakuan_hang.qiankuan.bianji:SetScript("OnClick", function (self)
			for xx=1,hang_NUM do
				_G["fakuan_hang_"..xx.."_UI"].shouru.E:ClearFocus() 
				_G["fakuan_hang_"..xx.."_UI"].qiankuan.E:ClearFocus() 
			end
			local fujiFrame=self:GetParent()
			self:Hide();
			fujiFrame.G:Hide()
			fujiFrame.E:Show()
			fujiFrame.baocun:Show()
			fujiFrame.E:SetText(PIG["RaidRecord"]["fakuan"][self:GetID()][3])
		end);
		fakuan_hang.qiankuan.baocun = CreateFrame("Button",nil,fakuan_hang.qiankuan, "UIPanelButtonTemplate");
		fakuan_hang.qiankuan.baocun:SetSize(hang_Height,hang_Height-10);
		fakuan_hang.qiankuan.baocun:SetPoint("LEFT", fakuan_hang.qiankuan, "RIGHT", 2,0);
		fakuan_hang.qiankuan.baocun:Hide();
		fakuan_hang.qiankuan.baocun:SetText('确定');
		buttonFont=fakuan_hang.qiankuan.baocun:GetFontString()
		buttonFont:SetFont(ChatFontNormal:GetFont(), 12);
		fakuan_hang.qiankuan.baocun:SetScript("OnClick", function (self)
			local fujiFrame=self:GetParent()
			fujiFrame.G:Show()
			fujiFrame.bianji:Show()
			fujiFrame.E:Hide();
			self:Hide()
	 		local NWEdanjiaV=fujiFrame.E:GetNumber();
	 		fujiFrame.G:SetText(NWEdanjiaV);
			PIG["RaidRecord"]["fakuan"][self:GetID()][3]=NWEdanjiaV;
			UpdateFakuan(fakuan_Scroll_UI)
		end);

		fakuan_hang.chuziren = CreateFrame("Button",nil,fakuan_hang, "TruncatedButtonTemplate");  
		fakuan_hang.chuziren:SetNormalTexture("")
		fakuan_hang.chuziren:SetSize(140, hang_Height-10);
		fakuan_hang.chuziren:SetPoint("LEFT",fakuan_hang,"LEFT",558,0);
		fakuan_hang.chuziren.V = fakuan_hang.chuziren:CreateFontString();
		fakuan_hang.chuziren.V:SetPoint("LEFT",fakuan_hang.chuziren,"LEFT",0,0);
		fakuan_hang.chuziren.V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		fakuan_hang.chuziren:SetScript("OnMouseDown", function (self)
			self.V:SetPoint("LEFT",self,"LEFT",1,-1);
		end);
		fakuan_hang.chuziren:SetScript("OnMouseUp", function (self)
			self.V:SetPoint("LEFT",self,"LEFT",0,0);
		end);
		fakuan_hang.chuziren:SetScript("OnClick", function (self)
			if xuanzechuziren_UI:IsShown() then
				xuanzechuziren_UI:Hide();
			else
				xuanzechuziren_UI:Show();
				xuanzechuziren_UI.T2:SetText(PIG["RaidRecord"]["fakuan"][self:GetID()][1])
				xuanzechuziren_UI.T4:SetText(self:GetID())
				Updatefakuanxuanze();
			end
		end);

		fakuan_hang.del = CreateFrame("Button",nil,fakuan_hang, "TruncatedButtonTemplate");
		fakuan_hang.del:SetSize(25,25);
		fakuan_hang.del:SetPoint("RIGHT", fakuan_hang, "RIGHT", -4,0);
		fakuan_hang.del.Tex = fakuan_hang.del:CreateTexture(nil, "BORDER");
		fakuan_hang.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		fakuan_hang.del.Tex:SetPoint("CENTER");
		fakuan_hang.del.Tex:SetSize(15,15);
		fakuan_hang.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1.5,-1.5);
		end);
		fakuan_hang.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		fakuan_hang.del:SetScript("OnClick", function (self)
			table.remove(PIG["RaidRecord"]["fakuan"],self:GetID());
			UpdateFakuan(fakuan_Scroll_UI)
		end);
	end
	-----添加其他收入项目-----
	fuFrame.Add = CreateFrame("Button","fakuan_Add_UI",fuFrame, "UIPanelButtonTemplate");
	fuFrame.Add:SetSize(30,20);
	fuFrame.Add:SetPoint("LEFT",fuFrame.biaoti1,"RIGHT",0,0);
	fuFrame.Add:SetText("+");
	fuFrame.Add:SetScript("OnClick", function ()
		if fuFrame.Add.F:IsShown() then
			fuFrame.Add.F:Hide();
		else
			fuFrame.Add.F:Show();
		end
	end);

	fuFrame.Add.F = CreateFrame("Frame", nil, fuFrame.Add);
	fuFrame.Add.F:SetSize(Width,Height-30);
	fuFrame.Add.F:SetPoint("TOP",fuFrame,"TOP",0,-30);
	fuFrame.Add.F:SetFrameLevel(10);
	fuFrame.Add.F:EnableMouse(true);
	fuFrame.Add.F:Hide();
	fuFrame.Add.F.F = CreateFrame("Frame", nil, fuFrame.Add.F,"BackdropTemplate");
	fuFrame.Add.F.F:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp", 
		edgeFile = "interface/glues/common/textpanel-border.blp", 
		tile = true, tileSize = 0, edgeSize = 32,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
	fuFrame.Add.F.F:SetSize(400,180);
	fuFrame.Add.F.F:SetPoint("TOP",fuFrame.Add.F,"TOP",0,0);
	fuFrame.Add.F.F.Close = CreateFrame("Button",nil,fuFrame.Add.F, "UIPanelCloseButton");  
	fuFrame.Add.F.F.Close:SetSize(34,34);
	fuFrame.Add.F.F.Close:SetPoint("TOPRIGHT",fuFrame.Add.F.F,"TOPRIGHT",2.4,3);
	fuFrame.Add.F.F.biaoti = fuFrame.Add.F.F:CreateFontString();
	fuFrame.Add.F.F.biaoti:SetPoint("TOP",fuFrame.Add.F.F,"TOP",0,-6);
	fuFrame.Add.F.F.biaoti:SetFont(GameFontNormal:GetFont(), 18, "OUTLINE");
	fuFrame.Add.F.F.biaoti:SetTextColor(1,215/255,0, 1);
	fuFrame.Add.F.F.biaoti:SetText("添加收入事件");
	--
	fuFrame.Add.F.F.biaoti1 = fuFrame.Add.F.F:CreateFontString();
	fuFrame.Add.F.F.biaoti1:SetPoint("TOPLEFT",fuFrame.Add.F.F,"TOPLEFT",30,-40);
	fuFrame.Add.F.F.biaoti1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.Add.F.F.biaoti1:SetText("\124cff00FF00收入事件\124r");
	fuFrame.Add.F.F.shiyou = CreateFrame('EditBox', nil, fuFrame.Add.F.F, "InputBoxInstructionsTemplate");
	fuFrame.Add.F.F.shiyou:SetSize(200,34);
	fuFrame.Add.F.F.shiyou:SetPoint("TOPLEFT",fuFrame.Add.F.F.biaoti1,"BOTTOMLEFT",0,-10);
	fuFrame.Add.F.F.shiyou:SetFontObject(ChatFontNormal);
	fuFrame.Add.F.F.shiyou:SetMaxLetters(30)
	fuFrame.Add.F.F.shiyou:SetAutoFocus(false);
	fuFrame.Add.F.F.shiyou:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.Add.F.F.biaoti2 = fuFrame.Add.F.F:CreateFontString(nil);
	fuFrame.Add.F.F.biaoti2:SetPoint("TOPLEFT",fuFrame.Add.F.F,"TOPLEFT",260,-40);
	fuFrame.Add.F.F.biaoti2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.Add.F.F.biaoti2:SetText("\124cff00FF00收入金额/G\124r");
	fuFrame.Add.F.F.G = CreateFrame('EditBox', nil, fuFrame.Add.F.F, "InputBoxInstructionsTemplate");
	fuFrame.Add.F.F.G:SetSize(80,34);
	fuFrame.Add.F.F.G:SetPoint("TOPLEFT",fuFrame.Add.F.F.biaoti2,"BOTTOMLEFT",4,-10);
	fuFrame.Add.F.F.G:SetFontObject(ChatFontNormal);
	fuFrame.Add.F.F.G:SetMaxLetters(9)
	fuFrame.Add.F.F.G:SetAutoFocus(false);
	fuFrame.Add.F.F.G:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.Add.F.F.err = fuFrame.Add.F.F:CreateFontString();
	fuFrame.Add.F.F.err:SetPoint("TOP",fuFrame.Add.F.F,"TOP",0,-106);
	fuFrame.Add.F.F.err:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.Add.F.F.err:SetText();
	fuFrame.Add.F.F.YES = CreateFrame("Button",nil,fuFrame.Add.F.F, "UIPanelButtonTemplate"); 
	fuFrame.Add.F.F.YES:SetSize(80,28);
	fuFrame.Add.F.F.YES:SetPoint("TOP",fuFrame.Add.F.F,"TOP",-60,-130);
	fuFrame.Add.F.F.YES:SetText("添加");
	fuFrame.Add.F.F.YES:SetScript("OnClick", function ()
		local qitashouruxiangmu=fuFrame.Add.F.F.shiyou:GetText();
		local qitashouruG=fuFrame.Add.F.F.G:GetNumber();
		local x, xx, xxx, xxxx = qitashouruxiangmu:find("(%S+(.+)%S+)");
		if x==nil then
			fuFrame.Add.F.F.err:SetText("\124cffffff00添加失败：事件不能为空或过短！\124r");	
		else
			for i=1,#PIG["RaidRecord"]["fakuan"] do
				if xxx==PIG["RaidRecord"]["fakuan"][i][1] then
					fuFrame.Add.F.F.err:SetText("\124cffffff00添加失败：已存在同名事件！\124r");
					return
				end
			end
			local qitashouruinfo={xxx,qitashouruG,0,"无"};
			table.insert(PIG["RaidRecord"]["fakuan"],qitashouruinfo);
			fuFrame.Add.F:Hide();
			UpdateFakuan(fakuan_Scroll_UI)
		end
	end);
	fuFrame.Add.F.F.NO = CreateFrame("Button",nil,fuFrame.Add.F.F, "UIPanelButtonTemplate");  
	fuFrame.Add.F.F.NO:SetSize(80,28);
	fuFrame.Add.F.F.NO:SetPoint("TOP",fuFrame.Add.F.F,"TOP",60,-134);
	fuFrame.Add.F.F.NO:SetText("取消");
	fuFrame.Add.F.F.NO:SetScript("OnClick", function ()
		fuFrame.Add.F:Hide();
	end);
	fuFrame.Add.F:SetScript("OnHide", function ()
		fuFrame.Add.F.F.err:SetText()
	end)
	---=======================================================
	--选择受益人
	local xuanzechuziren = CreateFrame("Frame", "xuanzechuziren_UI", fuFrame,"BackdropTemplate");
	xuanzechuziren:SetBackdrop( { bgFile = "interface/raidframe/ui-raidframe-groupbg.blp",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 10, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 } });
	xuanzechuziren:SetSize(Width-228,Height-12);
	xuanzechuziren:SetPoint("TOPRIGHT",fuFrame.biaoti3,"TOPLEFT",-0,0);
	xuanzechuziren:SetFrameLevel(10)
	xuanzechuziren:EnableMouse(true)
	xuanzechuziren:Hide()
	xuanzechuziren.Close = CreateFrame("Button",nil,xuanzechuziren, "UIPanelCloseButton");  
	xuanzechuziren.Close:SetSize(30,30);
	xuanzechuziren.Close:SetPoint("TOPRIGHT",xuanzechuziren,"TOPRIGHT",2.4,3);
	xuanzechuziren.T1 = xuanzechuziren:CreateFontString();
	xuanzechuziren.T1:SetPoint("TOPLEFT",xuanzechuziren,"TOPLEFT",30,-8);
	xuanzechuziren.T1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	xuanzechuziren.T1:SetText("\124cff00ff00选择【\124r")
	xuanzechuziren.T2 = xuanzechuziren:CreateFontString();
	xuanzechuziren.T2:SetPoint("LEFT",xuanzechuziren.T1,"RIGHT",0,0);
	xuanzechuziren.T2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	xuanzechuziren.T2:SetText()
	xuanzechuziren.T3 = xuanzechuziren:CreateFontString();
	xuanzechuziren.T3:SetPoint("LEFT",xuanzechuziren.T2,"RIGHT",0,0);
	xuanzechuziren.T3:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	xuanzechuziren.T3:SetText("\124cff00ff00】出资人\124r")
	xuanzechuziren.T4 = xuanzechuziren:CreateFontString();
	xuanzechuziren.T4:SetPoint("LEFT",xuanzechuziren.T3,"RIGHT",0,0);
	xuanzechuziren.T4:SetFont(ChatFontNormal:GetFont(), 1, "OUTLINE");
	xuanzechuziren.T4:SetText()
	xuanzechuziren.T4:Hide()
	xuanzechuziren.qingchu = CreateFrame("Button",nil,xuanzechuziren, "UIPanelButtonTemplate");  
	xuanzechuziren.qingchu:SetSize(94,22);
	xuanzechuziren.qingchu:SetPoint("TOPLEFT",xuanzechuziren,"TOPLEFT",300,-4);
	xuanzechuziren.qingchu:SetText("清除出资人");
	xuanzechuziren.qingchu:SetScript("OnClick", function ()
		PIG["RaidRecord"]["fakuan"][tonumber(xuanzechuziren.T4:GetText())][4]="无";
		UpdateFakuan(fakuan_Scroll_UI)
		xuanzechuziren_UI:Hide()
	end);
	--
	local duiwuW,duiwuH = 120,30;
	local jiangeW,jiangeH,juesejiangeH = 12,0,6;
	for p=1,8 do
		local chuzirenXZ = CreateFrame("Frame", "chuzirenXZ_"..p.."_UI", xuanzechuziren);
		chuzirenXZ:SetSize(duiwuW,duiwuH*5+juesejiangeH*4);
		if p==1 then
			chuzirenXZ:SetPoint("TOPLEFT",xuanzechuziren,"TOPLEFT",16,-34);
		end
		if p>1 and p<5 then
			chuzirenXZ:SetPoint("LEFT",_G["chuzirenXZ_"..(p-1).."_UI"],"RIGHT",jiangeW,jiangeH);
		end
		if p==5 then
			chuzirenXZ:SetPoint("TOP",_G["chuzirenXZ_1_UI"],"BOTTOM",0,-26);
		end
		if p>5 then
			chuzirenXZ:SetPoint("LEFT",_G["chuzirenXZ_"..(p-1).."_UI"],"RIGHT",jiangeW,jiangeH);
		end
		for pp=1,5 do
			local chuzirenXZP = CreateFrame("Frame", "chuzirenXZP_"..p.."_"..pp, _G["chuzirenXZ_"..p.."_UI"],"BackdropTemplate");
			chuzirenXZP:SetBackdrop( { edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 10, insets = { left = 0, right = 0, top = 0, bottom = 0 } });
			chuzirenXZP:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
			chuzirenXZP:SetSize(duiwuW,duiwuH);
			if pp==1 then
				chuzirenXZP:SetPoint("TOP",_G["chuzirenXZ_"..p.."_UI"],"TOP",0,0);
			else
				chuzirenXZP:SetPoint("TOP",_G["chuzirenXZP_"..p.."_"..(pp-1)],"BOTTOM",0,-juesejiangeH);
			end
			chuzirenXZP.highlight = chuzirenXZP:CreateTexture(nil, "BORDER");
			chuzirenXZP.highlight:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight.blp");
			chuzirenXZP.highlight:SetBlendMode("ADD")
			chuzirenXZP.highlight:SetPoint("CENTER", chuzirenXZP, "CENTER", 0,0);
			chuzirenXZP.highlight:SetSize(duiwuW,duiwuH);
			chuzirenXZP.highlight:Hide();
			chuzirenXZP:SetScript("OnEnter", function (self)
				self.highlight:Show();
			end);
			chuzirenXZP:SetScript("OnLeave", function (self)
				self.highlight:Hide();
			end);
			chuzirenXZP.Name = chuzirenXZP:CreateFontString();
			chuzirenXZP.Name:SetPoint("CENTER",chuzirenXZP,"CENTER",0,1);
			chuzirenXZP.Name:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");
			chuzirenXZP.Name:SetText()
			chuzirenXZP.Name:Hide()
			chuzirenXZP.Name_XS = chuzirenXZP:CreateFontString();
			chuzirenXZP.Name_XS:SetPoint("CENTER",chuzirenXZP,"CENTER",0,1);
			chuzirenXZP.Name_XS:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");
			chuzirenXZP.Name_XS:SetText()
			chuzirenXZP:SetScript("OnMouseDown", function (self)
				self.Name_XS:SetPoint("CENTER",self,"CENTER",1.5,-0.5);
			end);
			chuzirenXZP:SetScript("OnMouseUp", function (self,button)
				self.Name_XS:SetPoint("CENTER",self,"CENTER",0,1);
				PIG["RaidRecord"]["fakuan"][tonumber(xuanzechuziren.T4:GetText())][4]=self.Name:GetText();
				UpdateFakuan(fakuan_Scroll_UI)
				xuanzechuziren_UI:Hide()
			end);
		end
	end
end
addonTable.ADD_fakuan = ADD_fakuan;