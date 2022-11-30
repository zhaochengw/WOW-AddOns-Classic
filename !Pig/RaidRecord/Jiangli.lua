local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local hang_Height,hang_NUM  = 34, 12;
local function ADD_jiangli()
	local fuFrame = TablistFrame_4_UI
	local Width,Height  = fuFrame:GetWidth(), fuFrame:GetHeight();
	-- --============带本助手====================
	fuFrame.biaoti1 = fuFrame:CreateFontString("fuFrame.biaoti1_UI");
	fuFrame.biaoti1:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",25,-7);
	fuFrame.biaoti1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.biaoti1:SetText("\124cffFFFF00奖励事件\124r");
	fuFrame.biaoti2 = fuFrame:CreateFontString("fuFrame.biaoti2_UI");
	fuFrame.biaoti2:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",320,-7);
	fuFrame.biaoti2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.biaoti2:SetText("\124cffFFFF00奖励金额/G\124r");
	fuFrame.biaoti3 = fuFrame:CreateFontString("fuFrame.biaoti3_UI");
	fuFrame.biaoti3:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",560,-7);
	fuFrame.biaoti3:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.biaoti3:SetText("\124cffFFFF00受益人\124r");
	--受益人提示
	fuFrame.biaoti3_tishi = CreateFrame("Frame", "fuFrame.biaoti3_tishi_UI", fuFrame);
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
		GameTooltip:AddLine("\124cff00ff00未选择\124cffFFff00受益人\124r\124cff00ff00的条目将不会记入奖励支出！\n点击选择受益人\124r")
		GameTooltip:Show();
	end);
	fuFrame.biaoti3_tishi:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	---
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
		GameTooltip:AddLine("|cff00ff00点击播报奖励明细|r")
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
		for b=1,#PIG["RaidRecord"]["jiangli"] do
			if PIG["RaidRecord"]["jiangli"][b][3]~="无" then
				SendChatMessage("["..PIG["RaidRecord"]["jiangli"][b][1].."]-"..PIG["RaidRecord"]["jiangli"][b][3].."-支出："..PIG["RaidRecord"]["jiangli"][b][2].."G", RaidR_UI.xuanzhongChat, nil);
			end
		end
	end)
	--
	fuFrame.lineT = fuFrame:CreateLine()
	fuFrame.lineT:SetColorTexture(1,1,1,0.2)
	fuFrame.lineT:SetThickness(1);
	fuFrame.lineT:SetStartPoint("TOPLEFT",4,-28)
	fuFrame.lineT:SetEndPoint("TOPRIGHT",-4,-28)
	--///////////////////////////////////////////////////////////////////////////////////////
	local function Updatejiangli(self)
		for id = 1, hang_NUM do
			_G["jiangli_hang_"..id.."_UI"]:Hide();
			_G["jiangli_hang_"..id.."_UI"].shiyou:SetText();

			_G["jiangli_hang_"..id.."_UI"].shouru.G:SetText();
			_G["jiangli_hang_"..id.."_UI"].shouru.E:Hide();
			_G["jiangli_hang_"..id.."_UI"].shouru.bianji:Show();
			_G["jiangli_hang_"..id.."_UI"].shouru.baocun:Hide();

			_G["jiangli_hang_"..id.."_UI"].shouyiren.V:SetText();
			_G["jiangli_hang_"..id.."_UI"].del:Hide();
	    end
		if #PIG["RaidRecord"]["jiangli"]>0 then
		    local ItemsNum = #PIG["RaidRecord"]["jiangli"];
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
		    local offset = FauxScrollFrame_GetOffset(self);
			for id = 1, hang_NUM do
				local dangqian = id+offset;
				if PIG["RaidRecord"]["jiangli"][dangqian] then
					_G["jiangli_hang_"..id.."_UI"]:Show();
					if dangqian<4 then
						_G["jiangli_hang_"..id.."_UI"].shiyou:SetText(PIG["RaidRecord"]["jiangli"][dangqian][1]);
					elseif dangqian<7 then	
			    		_G["jiangli_hang_"..id.."_UI"].shiyou:SetText("|cff00FA9A"..PIG["RaidRecord"]["jiangli"][dangqian][1].."|r");
			    	else
			    		_G["jiangli_hang_"..id.."_UI"].shiyou:SetText(PIG["RaidRecord"]["jiangli"][dangqian][1]);
			    	end
			  		_G["jiangli_hang_"..id.."_UI"].shouru.G:SetText(PIG["RaidRecord"]["jiangli"][dangqian][2]);
			    	_G["jiangli_hang_"..id.."_UI"].shouru.bianji:SetID(dangqian);
			    	_G["jiangli_hang_"..id.."_UI"].shouru.E:SetID(dangqian);
		    		_G["jiangli_hang_"..id.."_UI"].shouru.baocun:SetID(dangqian);
					_G["jiangli_hang_"..id.."_UI"].shouyiren.V:SetText(PIG["RaidRecord"]["jiangli"][dangqian][3]);
					_G["jiangli_hang_"..id.."_UI"].shouyiren:SetID(dangqian);
			    	_G["jiangli_hang_"..id.."_UI"].del:SetID(dangqian);
					_G["jiangli_hang_"..id.."_UI"].del:Show();
				end
			end
		end
		addonTable.RaidRecord_UpdateG();
	end
	addonTable.RaidRecord_Updatejiangli = Updatejiangli;
	--刷新选择框角色
	local function Updatejianglixuanze()
		if xuanzeshouyiren_UI:IsShown() then
			for p=1,8 do
				for pp=1,5 do
					_G["shouyirenXZP_"..p.."_"..pp]:Hide();
					_G["shouyirenXZP_Name_"..p.."_"..pp]:SetText();
					_G["shouyirenXZP_Name_XS_"..p.."_"..pp]:SetText();
				end
		    end
			for p=1,8 do
				if #PIG["RaidRecord"]["Raidinfo"][p]>0 then
					for pp=1,#PIG["RaidRecord"]["Raidinfo"][p] do
					   	if PIG["RaidRecord"]["Raidinfo"][p][pp][4]~=nil then
					   		_G["shouyirenXZP_"..p.."_"..pp]:Show();
					   		_G["shouyirenXZP_Name_"..p.."_"..pp]:SetText(PIG["RaidRecord"]["Raidinfo"][p][pp][4]);
					   		local _, _, _, wanjiaName = PIG["RaidRecord"]["Raidinfo"][p][pp][4]:find("((.+)-)");
							if wanjiaName then
								_G["shouyirenXZP_Name_XS_"..p.."_"..pp]:SetText(wanjiaName);
							else
								_G["shouyirenXZP_Name_XS_"..p.."_"..pp]:SetText(PIG["RaidRecord"]["Raidinfo"][p][pp][4]);
							end
							_G["shouyirenXZP_Name_XS_"..p.."_"..pp]:SetTextColor(PIG["RaidRecord"]["Raidinfo"][p][pp][2][1],PIG["RaidRecord"]["Raidinfo"][p][pp][2][2],PIG["RaidRecord"]["Raidinfo"][p][pp][2][3], 1);
					   	end
					end
				end
			end
		end
	end
	addonTable.RaidRecord_Updatejianglixuanze = Updatejianglixuanze;
	--
	fuFrame:SetScript("OnShow", function ()
		Updatejiangli(jiangli_Scroll_UI)
	end)
	--创建可滚动区域
	local jiangli_Scroll = CreateFrame("ScrollFrame","jiangli_Scroll_UI",fuFrame, "FauxScrollFrameTemplate");  
	jiangli_Scroll:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",5,-hang_Height+6);
	jiangli_Scroll:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",-27,5);
	jiangli_Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, Updatejiangli)
	end)
	for id = 1, hang_NUM do
		local jiangli_hang= CreateFrame("Frame", "jiangli_hang_"..id.."_UI", jiangli_Scroll:GetParent());
		jiangli_hang:SetSize(Width-30, hang_Height);
		if id==1 then
			jiangli_hang:SetPoint("TOP",jiangli_Scroll,"TOP",0,0);
		else
			jiangli_hang:SetPoint("TOP",_G["jiangli_hang_"..(id-1).."_UI"],"BOTTOM",0,-0);
		end
		jiangli_hang.line = jiangli_hang:CreateLine()
		jiangli_hang.line:SetColorTexture(1,1,1,0.2)
		jiangli_hang.line:SetThickness(1);
		jiangli_hang.line:SetStartPoint("BOTTOMLEFT",0,0)
		jiangli_hang.line:SetEndPoint("BOTTOMRIGHT",0,0)
		-----
		jiangli_hang.shiyou = jiangli_hang:CreateFontString();
		jiangli_hang.shiyou:SetPoint("LEFT",jiangli_hang,"LEFT",18,0);
		jiangli_hang.shiyou:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		---------
		jiangli_hang.shouru = CreateFrame("Frame", nil, jiangli_hang);
		jiangli_hang.shouru:SetSize(70, hang_Height);
		jiangli_hang.shouru:SetPoint("LEFT", jiangli_hang, "LEFT", 306,0);
		jiangli_hang.shouru.G = jiangli_hang.shouru:CreateFontString();
		jiangli_hang.shouru.G:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		jiangli_hang.shouru.G:SetPoint("RIGHT", jiangli_hang.shouru, "RIGHT", 0,0);
		jiangli_hang.shouru.G:SetTextColor(0, 1, 1, 1);
		jiangli_hang.shouru.E = CreateFrame('EditBox', nil, jiangli_hang.shouru, "InputBoxInstructionsTemplate");
		jiangli_hang.shouru.E:SetSize(60,hang_Height);
		jiangli_hang.shouru.E:SetPoint("RIGHT",jiangli_hang.shouru,"RIGHT",0,0);
		jiangli_hang.shouru.E:SetFontObject(ChatFontNormal);
		jiangli_hang.shouru.E:SetMaxLetters(7)
		jiangli_hang.shouru.E:SetScript("OnEscapePressed", function(self) 
			self:ClearFocus() 
		end);
		jiangli_hang.shouru.E:SetScript("OnEnterPressed", function(self) 
			local fujiFrame=self:GetParent()
			fujiFrame.G:Show()
			fujiFrame.bianji:Show()
			self:Hide();
			fujiFrame.baocun:Hide()
	 		local NWEdanjiaV=self:GetNumber();
	 		fujiFrame.G:SetText(NWEdanjiaV);
			PIG["RaidRecord"]["jiangli"][self:GetID()][2]=NWEdanjiaV;
			Updatejiangli(jiangli_Scroll_UI)
		end);
		jiangli_hang.shouru.E:SetScript("OnEditFocusLost", function(self)
			local fujiFrame=self:GetParent()
			self:Hide();
			fujiFrame.G:Show()
			fujiFrame.bianji:Show()
			fujiFrame.baocun:Hide()
		end);
		jiangli_hang.shouru.bianji = CreateFrame("Button",nil,jiangli_hang.shouru, "TruncatedButtonTemplate");
		jiangli_hang.shouru.bianji:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
		jiangli_hang.shouru.bianji:SetSize(hang_Height-8,hang_Height-8);
		jiangli_hang.shouru.bianji:SetPoint("LEFT", jiangli_hang.shouru, "RIGHT", -2,0);
		jiangli_hang.shouru.bianji.Tex = jiangli_hang.shouru.bianji:CreateTexture(nil, "BORDER");
		jiangli_hang.shouru.bianji.Tex:SetTexture("interface/buttons/ui-guildbutton-officernote-up.blp");
		jiangli_hang.shouru.bianji.Tex:SetPoint("CENTER");
		jiangli_hang.shouru.bianji.Tex:SetSize(hang_Height-16,hang_Height-14);
		jiangli_hang.shouru.bianji:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1.5,-1.5);
		end);
		jiangli_hang.shouru.bianji:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		jiangli_hang.shouru.bianji:SetScript("OnClick", function (self)
			for xx=1,hang_NUM do
				_G["jiangli_hang_"..id.."_UI"].shouru.E:ClearFocus() 
			end
			local fujiFrame=self:GetParent()
			self:Hide();
			fujiFrame.G:Hide()
			fujiFrame.E:Show()
			fujiFrame.baocun:Show()
			fujiFrame.E:SetText(PIG["RaidRecord"]["jiangli"][self:GetID()][2])
		end);
		jiangli_hang.shouru.baocun = CreateFrame("Button",nil,jiangli_hang.shouru, "UIPanelButtonTemplate");
		jiangli_hang.shouru.baocun:SetSize(hang_Height,hang_Height-10);
		jiangli_hang.shouru.baocun:SetPoint("LEFT", jiangli_hang.shouru, "RIGHT", 2,0);
		jiangli_hang.shouru.baocun:Hide();
		jiangli_hang.shouru.baocun:SetText('确定');
		buttonFont=jiangli_hang.shouru.baocun:GetFontString()
		buttonFont:SetFont(ChatFontNormal:GetFont(), 12);
		jiangli_hang.shouru.baocun:SetScript("OnClick", function (self)
			local fujiFrame=self:GetParent()
			fujiFrame.G:Show()
			fujiFrame.bianji:Show()
			fujiFrame.E:Hide();
			self:Hide()
	 		local NWEdanjiaV=fujiFrame.E:GetNumber();
	 		fujiFrame.G:SetText(NWEdanjiaV);
			PIG["RaidRecord"]["jiangli"][self:GetID()][2]=NWEdanjiaV;
			Updatejiangli(jiangli_Scroll_UI)
		end);

		jiangli_hang.shouyiren = CreateFrame("Button",nil,jiangli_hang, "TruncatedButtonTemplate");  
		jiangli_hang.shouyiren:SetNormalTexture("")
		jiangli_hang.shouyiren:SetSize(140, hang_Height-10);
		jiangli_hang.shouyiren:SetPoint("LEFT",jiangli_hang,"LEFT",558,0);

		jiangli_hang.shouyiren.V = jiangli_hang.shouyiren:CreateFontString();
		jiangli_hang.shouyiren.V:SetPoint("LEFT",jiangli_hang.shouyiren,"LEFT",0,0);
		jiangli_hang.shouyiren.V:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		jiangli_hang.shouyiren:SetScript("OnMouseDown", function (self)
			self.V:SetPoint("LEFT",self,"LEFT",1,-1);
		end);
		jiangli_hang.shouyiren:SetScript("OnMouseUp", function (self)
			self.V:SetPoint("LEFT",self,"LEFT",0,0);
		end);
		jiangli_hang.shouyiren:SetScript("OnClick", function (self)
			if xuanzeshouyiren_UI:IsShown() then
				xuanzeshouyiren_UI:Hide();
			else
				xuanzeshouyiren_UI:Show();
				xuanzeshouyiren_UI.T2:SetText(PIG["RaidRecord"]["jiangli"][self:GetID()][1])
				xuanzeshouyiren_UI.T4:SetText(self:GetID())
				Updatejianglixuanze();
			end
		end);

		jiangli_hang.del = CreateFrame("Button",nil,jiangli_hang, "TruncatedButtonTemplate");
		jiangli_hang.del:SetSize(25,25);
		jiangli_hang.del:SetPoint("RIGHT", jiangli_hang, "RIGHT", -4,0);
		jiangli_hang.del.Tex = jiangli_hang.del:CreateTexture(nil, "BORDER");
		jiangli_hang.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		jiangli_hang.del.Tex:SetPoint("CENTER");
		jiangli_hang.del.Tex:SetSize(15,15);
		jiangli_hang.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1.5,-1.5);
		end);
		jiangli_hang.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		jiangli_hang.del:SetScript("OnClick", function (self)
			table.remove(PIG["RaidRecord"]["jiangli"],self:GetID());
			Updatejiangli(jiangli_Scroll_UI)
		end);
	end
	-----添加其他收入项目-----
	fuFrame.Add = CreateFrame("Button","jiangli_Add_UI",fuFrame, "UIPanelButtonTemplate");
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

	fuFrame.Add.F.F = CreateFrame("Frame",nil, fuFrame.Add.F,"BackdropTemplate");
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
	fuFrame.Add.F.F.biaoti:SetText("添加奖励事件");
	--
	fuFrame.Add.F.F.biaoti1 = fuFrame.Add.F.F:CreateFontString();
	fuFrame.Add.F.F.biaoti1:SetPoint("TOPLEFT",fuFrame.Add.F.F,"TOPLEFT",30,-40);
	fuFrame.Add.F.F.biaoti1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.Add.F.F.biaoti1:SetText("\124cff00FF00奖励事件\124r");
	fuFrame.Add.F.F.shiyou = CreateFrame('EditBox', nil, fuFrame.Add.F.F, "InputBoxInstructionsTemplate");
	fuFrame.Add.F.F.shiyou:SetSize(200,34);
	fuFrame.Add.F.F.shiyou:SetPoint("TOPLEFT",fuFrame.Add.F.F.biaoti1,"BOTTOMLEFT",0,-10);
	fuFrame.Add.F.F.shiyou:SetFontObject(ChatFontNormal);
	fuFrame.Add.F.F.shiyou:SetMaxLetters(30)
	fuFrame.Add.F.F.shiyou:SetAutoFocus(false);
	fuFrame.Add.F.F.shiyou:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.Add.F.F.biaoti2 = fuFrame.Add.F.F:CreateFontString();
	fuFrame.Add.F.F.biaoti2:SetPoint("TOPLEFT",fuFrame.Add.F.F,"TOPLEFT",260,-40);
	fuFrame.Add.F.F.biaoti2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.Add.F.F.biaoti2:SetText("\124cff00FF00奖励金额/G\124r");
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
			for i=1,#PIG["RaidRecord"]["jiangli"] do
				if xxx==PIG["RaidRecord"]["jiangli"][i][1] then
					fuFrame.Add.F.F.err:SetText("\124cffffff00添加失败：已存在同名事件！\124r");
					return
				end
			end
			local qitashouruinfo={xxx,qitashouruG,"无"};
			table.insert(PIG["RaidRecord"]["jiangli"],qitashouruinfo);
			fuFrame.Add.F:Hide();
			Updatejiangli(jiangli_Scroll_UI)
		end
	end);
	fuFrame.Add.F.F.NO = CreateFrame("Button","fuFrame.Add.F.F.NO_UI",fuFrame.Add.F.F, "UIPanelButtonTemplate");  
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
	local xuanzeshouyiren = CreateFrame("Frame", "xuanzeshouyiren_UI", fuFrame,"BackdropTemplate");
	xuanzeshouyiren:SetBackdrop( { bgFile = "interface/raidframe/ui-raidframe-groupbg.blp",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 10, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 } });
	xuanzeshouyiren:SetSize(Width-228,Height-12);
	xuanzeshouyiren:SetPoint("TOPRIGHT",fuFrame.biaoti3,"TOPLEFT",-0,0);
	xuanzeshouyiren:SetFrameLevel(10)
	xuanzeshouyiren:EnableMouse(true)
	xuanzeshouyiren:Hide()
	xuanzeshouyiren.Close = CreateFrame("Button",nil,xuanzeshouyiren, "UIPanelCloseButton");  
	xuanzeshouyiren.Close:SetSize(30,30);
	xuanzeshouyiren.Close:SetPoint("TOPRIGHT",xuanzeshouyiren,"TOPRIGHT",2.4,3);
	xuanzeshouyiren.T1 = xuanzeshouyiren:CreateFontString();
	xuanzeshouyiren.T1:SetPoint("TOPLEFT",xuanzeshouyiren,"TOPLEFT",30,-8);
	xuanzeshouyiren.T1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	xuanzeshouyiren.T1:SetText("\124cff00ff00选择【\124r")
	xuanzeshouyiren.T2 = xuanzeshouyiren:CreateFontString();
	xuanzeshouyiren.T2:SetPoint("LEFT",xuanzeshouyiren.T1,"RIGHT",0,0);
	xuanzeshouyiren.T2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	xuanzeshouyiren.T2:SetText()
	xuanzeshouyiren.T3 = xuanzeshouyiren:CreateFontString();
	xuanzeshouyiren.T3:SetPoint("LEFT",xuanzeshouyiren.T2,"RIGHT",0,0);
	xuanzeshouyiren.T3:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	xuanzeshouyiren.T3:SetText("\124cff00ff00】受益人\124r")
	xuanzeshouyiren.T4 = xuanzeshouyiren:CreateFontString();
	xuanzeshouyiren.T4:SetPoint("LEFT",xuanzeshouyiren.T3,"RIGHT",0,0);
	xuanzeshouyiren.T4:SetFont(ChatFontNormal:GetFont(), 1, "OUTLINE");
	xuanzeshouyiren.T4:SetText()
	xuanzeshouyiren.T4:Hide()
	xuanzeshouyiren.qingchu = CreateFrame("Button",nil,xuanzeshouyiren, "UIPanelButtonTemplate");  
	xuanzeshouyiren.qingchu:SetSize(94,22);
	xuanzeshouyiren.qingchu:SetPoint("TOPLEFT",xuanzeshouyiren,"TOPLEFT",300,-4);
	xuanzeshouyiren.qingchu:SetText("清除收益人");
	xuanzeshouyiren.qingchu:SetScript("OnClick", function ()
		PIG["RaidRecord"]["jiangli"][tonumber(xuanzeshouyiren.T4:GetText())][3]="无";
		Updatejiangli(jiangli_Scroll_UI)
		xuanzeshouyiren_UI:Hide()
	end);
	--
	local duiwuW,duiwuH = 120,30;
	local jiangeW,jiangeH,juesejiangeH = 12,0,6;
	for p=1,8 do
		local shouyirenXZ = CreateFrame("Frame", "shouyirenXZ_"..p.."_UI", xuanzeshouyiren);
		shouyirenXZ:SetSize(duiwuW,duiwuH*5+juesejiangeH*4);
		if p==1 then
			shouyirenXZ:SetPoint("TOPLEFT",xuanzeshouyiren,"TOPLEFT",16,-34);
		end
		if p>1 and p<5 then
			shouyirenXZ:SetPoint("LEFT",_G["shouyirenXZ_"..(p-1).."_UI"],"RIGHT",jiangeW,jiangeH);
		end
		if p==5 then
			shouyirenXZ:SetPoint("TOP",_G["shouyirenXZ_1_UI"],"BOTTOM",0,-26);
		end
		if p>5 then
			shouyirenXZ:SetPoint("LEFT",_G["shouyirenXZ_"..(p-1).."_UI"],"RIGHT",jiangeW,jiangeH);
		end
		for pp=1,5 do
			local shouyirenXZP = CreateFrame("Frame", "shouyirenXZP_"..p.."_"..pp, _G["shouyirenXZ_"..p.."_UI"],"BackdropTemplate");
			shouyirenXZP:SetBackdrop( { edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 10, insets = { left = 0, right = 0, top = 0, bottom = 0 } });
			shouyirenXZP:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
			shouyirenXZP:SetSize(duiwuW,duiwuH);
			if pp==1 then
				shouyirenXZP:SetPoint("TOP",_G["shouyirenXZ_"..p.."_UI"],"TOP",0,0);
			else
				shouyirenXZP:SetPoint("TOP",_G["shouyirenXZP_"..p.."_"..(pp-1)],"BOTTOM",0,-juesejiangeH);
			end
			local shouyirenXZP_highlight = shouyirenXZP:CreateTexture("shouyirenXZP_highlight_"..p.."_"..pp, "BORDER");
			shouyirenXZP_highlight:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight.blp");
			shouyirenXZP_highlight:SetBlendMode("ADD")
			shouyirenXZP_highlight:SetPoint("CENTER", shouyirenXZP, "CENTER", 0,0);
			shouyirenXZP_highlight:SetSize(duiwuW,duiwuH);
			shouyirenXZP_highlight:Hide();
			_G["shouyirenXZP_"..p.."_"..pp]:SetScript("OnEnter", function (self)
				_G["shouyirenXZP_highlight_"..p.."_"..pp]:Show();
			end);
			_G["shouyirenXZP_"..p.."_"..pp]:SetScript("OnLeave", function (self)
				_G["shouyirenXZP_highlight_"..p.."_"..pp]:Hide();
			end);
			local shouyirenXZP_Name = shouyirenXZP:CreateFontString("shouyirenXZP_Name_"..p.."_"..pp);
			shouyirenXZP_Name:SetPoint("CENTER",shouyirenXZP,"CENTER",0,1);
			shouyirenXZP_Name:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");
			shouyirenXZP_Name:SetText()
			shouyirenXZP_Name:Hide()
			local shouyirenXZP_Name_XS = shouyirenXZP:CreateFontString("shouyirenXZP_Name_XS_"..p.."_"..pp);
			shouyirenXZP_Name_XS:SetPoint("CENTER",shouyirenXZP,"CENTER",0,1);
			shouyirenXZP_Name_XS:SetFont(ChatFontNormal:GetFont(), 12, "OUTLINE");
			shouyirenXZP_Name_XS:SetText()
			_G["shouyirenXZP_"..p.."_"..pp]:SetScript("OnMouseDown", function (self)
				_G["shouyirenXZP_Name_XS_"..p.."_"..pp]:SetPoint("CENTER",self,"CENTER",1.5,-0.5);
			end);
			_G["shouyirenXZP_"..p.."_"..pp]:SetScript("OnMouseUp", function (self,button)
				_G["shouyirenXZP_Name_XS_"..p.."_"..pp]:SetPoint("CENTER",self,"CENTER",0,1);
				PIG["RaidRecord"]["jiangli"][tonumber(xuanzeshouyiren.T4:GetText())][3]=_G["shouyirenXZP_Name_"..p.."_"..pp]:GetText();
				Updatejiangli(jiangli_Scroll_UI)
				xuanzeshouyiren_UI:Hide()
			end);
		end
	end
end
addonTable.ADD_jiangli = ADD_jiangli;