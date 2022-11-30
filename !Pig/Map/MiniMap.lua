local addonName, addonTable = ...;
local fuFrame=List_R_F_1_8
local _, _, _, tocversion = GetBuildInfo()
local PIGDownMenu=addonTable.PIGDownMenu
local ADD_Checkbutton=addonTable.ADD_Checkbutton
----------------------------------------------------------
local ShouNaButHeji={};
local function gengxinMBweizhi(newValue)
	local meipaishu=newValue or PIG.Map.MinimapShouNa_hang;--每排按钮数
	MinimapButton_PigUI.Snf:SetSize(meipaishu*35+30, math.ceil(#ShouNaButHeji/meipaishu)*35+30)
	for i=1, #ShouNaButHeji,1 do
		_G[ShouNaButHeji[i]]:SetParent(MinimapButton_PigUI.Snf)
		_G[ShouNaButHeji[i]]:HookScript("OnEnter", function()
			MinimapButton_PigUI.Snf.zhengzaixianshi = nil;
		end)
		_G[ShouNaButHeji[i]]:HookScript("OnLeave", function()
			MinimapButton_PigUI.Snf.xiaoshidaojishi = 1.5;
			MinimapButton_PigUI.Snf.zhengzaixianshi = true;
		end)
		-- _G[ShouNaButHeji[i]]:HookScript("PostClick", function ()
		-- 	MinimapButton_PigUI.Snf:Hide();
		-- end);
	end	
	for iiii=1, math.ceil(#ShouNaButHeji/meipaishu),1 do
		if iiii==1 then
			for xxxx=1, iiii*meipaishu, 1 do
				if xxxx==1 then
					_G[ShouNaButHeji[xxxx]]:ClearAllPoints();
					_G[ShouNaButHeji[xxxx]]:SetPoint("TOPLEFT", MinimapButton_PigUI.Snf, "TOPLEFT", 15, -15)
				else
					if _G[ShouNaButHeji[xxxx]] then
						_G[ShouNaButHeji[xxxx]]:ClearAllPoints();
						_G[ShouNaButHeji[xxxx]]:SetPoint("TOPLEFT", MinimapButton_PigUI.Snf, "TOPLEFT", 35*(xxxx-1)+15, -15)
					end
				end
			end
		else
			for xxxx=(iiii-1)*meipaishu+1, iiii*meipaishu, 1 do
				if xxxx-(iiii-1)*meipaishu==1 then
					_G[ShouNaButHeji[xxxx]]:ClearAllPoints();
					_G[ShouNaButHeji[xxxx]]:SetPoint("TOPLEFT", MinimapButton_PigUI.Snf, "TOPLEFT", 15, -35*(iiii-1)-15)
				else
					if _G[ShouNaButHeji[xxxx]] then
						_G[ShouNaButHeji[xxxx]]:ClearAllPoints();
						_G[ShouNaButHeji[xxxx]]:SetPoint("TOPLEFT", MinimapButton_PigUI.Snf, "TOPLEFT", 35*(xxxx-(iiii-1)*meipaishu-1)+15, -35*(iiii-1)-15)
					end
				end
				
			end
		end
	end
end
local paichulist = {
	"MiniMapTrackingFrame",
	"MiniMapMeetingStoneFrame",
	"MiniMapMailFrame",
	"MiniMapBattlefieldFrame",
	"MiniMapWorldMapButton",
	"MiniMapPing",
	"MinimapBackdrop",
	"MinimapZoomIn",
	"MinimapZoomOut",
	"BookOfTracksFrame",
	"GatherNote",
	"FishingExtravaganzaMini",
	"MiniNotePOI",
	"RecipeRadarMinimapIcon",
	"FWGMinimapPOI",
	"CartographerNotesPOI",
	"MBB_MinimapButtonFrame",
	"EnhancedFrameMinimapButton",
	"GFW_TrackMenuFrame",
	"GFW_TrackMenuButton",
	"TDial_TrackingIcon",
	"TDial_TrackButton",
	"MiniMapTracking",
	"GatherMatePin",
	"HandyNotesPin",
	"TimeManagerClockButton",
	"GameTimeFrame",
	"DA_Minimap",
	"ElvConfigToggle",
	"MiniMapInstanceDifficulty",
	"MinimapZoneTextButton",
	"GuildInstanceDifficulty",
	"MiniMapVoiceChatFrame",
	"MiniMapRecordingButton",
	"QueueStatusMinimapButton",
	"GatherArchNote",
	"ZGVMarker",
	"QuestPointerPOI",
	"poiMinimap",
	"MiniMapLFGFrame",
	"PremadeFilter_MinimapButton",
	"QuestieFrame",
	"Guidelime",
	"MiniMapBattlefieldFrame",
	"LibDBIcon10_BugSack",
	"MinimapButton_PigUI",
	"MinimapLayerFrame",
	"NWBNaxxMarkerMini",
	"NWBMini",
	"SexyMapCustomBackdrop",
	"SexyMapCoordFrame",
	"SexyMapPingFrame",
	"SexyMapZoneTextButton",
}
local function Other_ShouNaBut()
	local children = { Minimap:GetChildren() };
	local NewPaichulist = {}
	for i=1,10 do
		table.insert(NewPaichulist,"Spy_MapNoteList_mini"..i)
	end
	for i=1,#paichulist do
		table.insert(NewPaichulist,paichulist[i])
	end
	for i=1,#children do
		if children[i]:GetName() then
			--print(children[i]:GetName())
			local shifouzaiguolvliebiao = true;
			for ii=1,#NewPaichulist do
					local cunzai=string.match(children[i]:GetName(),NewPaichulist[ii])
					if cunzai then
						shifouzaiguolvliebiao = false;
					end
			end
			if shifouzaiguolvliebiao then
				table.insert(ShouNaButHeji,children[i]:GetName())
			end
		end
	end
	gengxinMBweizhi(newValue)
end
addonTable.Map_ShouNaBut = function()
	if PIG.Map.MinimapBut then
		if PIG.Map.MinimapShouNa then
			Other_ShouNaBut();
			C_Timer.After(3, Other_ShouNaBut);
			C_Timer.After(8, Other_ShouNaBut);
			C_Timer.After(14, Other_ShouNaBut);
		end	
	end
end

--小地图按钮--==============================
local function MinimapButton_Pig_Open()
	if MinimapButton_PigUI==nil then
		if tocversion<100000 then
			Minimap.chushipianyi = 52
			Minimap.zhijing = 80
		else
			Minimap.chushipianyi = 82
			Minimap.zhijing = 110
		end
		local fujikname = UIParent
		if PIG.Map.MinimapShouNa_BS then
			fujikname = Minimap
		end
		local MinimapButton_Pig = CreateFrame("Button","MinimapButton_PigUI",fujikname); 
		MinimapButton_Pig:SetSize(33,33);
		MinimapButton_Pig:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0);
		MinimapButton_Pig:SetMovable(true)
		MinimapButton_Pig:EnableMouse(true)
		MinimapButton_Pig:RegisterForClicks("LeftButtonUp","RightButtonUp")
		MinimapButton_Pig:RegisterForDrag("LeftButton")
		MinimapButton_Pig:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");

		MinimapButton_Pig.Border = MinimapButton_Pig:CreateTexture(nil, "OVERLAY");
		MinimapButton_Pig.Border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder");
		MinimapButton_Pig.Border:SetSize(56,56);
		MinimapButton_Pig.Border:SetPoint("TOPLEFT", 0, 0);
		MinimapButton_Pig.Icon = MinimapButton_Pig:CreateTexture(nil, "ARTWORK");
		MinimapButton_Pig.Icon:SetTexture(132311);
		MinimapButton_Pig.Icon:SetSize(23,23);
		if tocversion<100000 then
			MinimapButton_Pig.Icon:SetPoint("CENTER", 0, 1);
		else
			MinimapButton_Pig.Icon:SetPoint("CENTER", 0.8, 0);
		end
		MinimapButton_Pig.error = MinimapButton_Pig:CreateTexture(nil, "OVERLAY");
		MinimapButton_Pig.error:SetTexture("interface/common/voicechat-muted.blp");
		MinimapButton_Pig.error:SetSize(19,19);
		MinimapButton_Pig.error:SetAlpha(0.8);
		MinimapButton_Pig.error:SetPoint("CENTER", 0, 0);
		MinimapButton_Pig.error:Hide();

		MinimapButton_Pig:SetScript("OnEnter", function()
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(MinimapButton_Pig, "ANCHOR_TOPRIGHT",0,0);
			GameTooltip:AddLine("|cffFF00FF!Pig|r-"..GetAddOnMetadata(addonName, "Version"))
			GameTooltip:AddLine("左击-|cff00FFFF展开小地图按钮|r\r右击-|cff00FFFF设置|r\rShift+左击-|cff00FFFF打开错误报告|r")
			GameTooltip:Show();
		end);
		MinimapButton_Pig:SetScript("OnLeave", function()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);

		local function YDButtonP()
			local weizhiXY = PIG.Map.MinimapPos
			MinimapButton_Pig:ClearAllPoints();
			MinimapButton_Pig:SetPoint("TOPLEFT","Minimap","TOPLEFT",Minimap.chushipianyi-(Minimap.zhijing*cos(weizhiXY)),(Minimap.zhijing*sin(weizhiXY))-Minimap.chushipianyi)
		end

		local function YDButtonP_OnUpdate()
			local xpos,ypos = GetCursorPosition()
			local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()
			local xpos = xmin-xpos/UIParent:GetScale()+70 
			local ypos = ypos/UIParent:GetScale()-ymin-70
			PIG.Map.MinimapPos = math.deg(math.atan2(ypos,xpos))
			YDButtonP()
		end

		local MinimapButton_PigYD = CreateFrame("Frame", nil);
		MinimapButton_PigYD:Hide();
		MinimapButton_PigYD:SetScript("OnUpdate",YDButtonP_OnUpdate)
		MinimapButton_Pig:SetScript("OnDragStart", function()
			MinimapButton_Pig:LockHighlight();MinimapButton_PigYD:Show();
		end)
		MinimapButton_Pig:SetScript("OnDragStop", function()
			MinimapButton_Pig:UnlockHighlight();MinimapButton_PigYD:Hide();
		end)
		YDButtonP();
		MinimapButton_Pig:SetScript("OnClick", function(event, button)
			if button=="LeftButton" then
				if IsShiftKeyDown() then
					Bugshouji_UI:Show()
					MinimapButton_PigUI.error:Hide();
				else
					if PIG.Map.MinimapShouNa then
						MinimapButton_Pig.Snf.tishi:Hide();
						if MinimapButton_Pig.Snf:IsShown() then	
							MinimapButton_Pig.Snf:Hide();
						else
							Pig_OptionsUI:Hide();
							MinimapButton_Pig.Snf:Show();
							MinimapButton_Pig.Snf.xiaoshidaojishi = 1.5;
							MinimapButton_Pig.Snf.zhengzaixianshi = true;
						end
					else
						MinimapButton_Pig.Snf.tishi:Show();
						if MinimapButton_Pig.Snf:IsShown() then
							MinimapButton_Pig.Snf:Hide();
						else
							print("\124cff00FFFF!Pig：\124cffffFF00请先开启小地图按钮收纳功能！\124r");
							MinimapButton_Pig.Snf:Show();
						end
					end
				end
			else
				if Pig_OptionsUI:IsShown() then	
					Pig_OptionsUI:Hide();
				else
					MinimapButton_Pig.Snf:Hide();
					Pig_OptionsUI:Show();
				end
			end
		end)
		--Collect Button
		MinimapButton_Pig.Snf = CreateFrame("Frame", nil, MinimapButton_Pig,"BackdropTemplate");
		MinimapButton_Pig.Snf:SetBackdrop({
		    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		    edgeFile = "interface/friendsframe/ui-toast-border.blp",
		    tile = true,tileSize = 32,edgeSize = 8,
		    insets = { left = 3, right = 3, top = 3, bottom = 3 }
		})
		MinimapButton_Pig.Snf:SetSize(200, 100)
		MinimapButton_Pig.Snf:SetPoint("TOPRIGHT", MinimapButton_PigUI, "BOTTOMLEFT", 0, 25)
		MinimapButton_Pig.Snf:Hide();
		MinimapButton_Pig.Snf.tishi = MinimapButton_Pig.Snf:CreateFontString();
		MinimapButton_Pig.Snf.tishi:SetPoint("TOPLEFT", MinimapButton_Pig.Snf, "TOPLEFT", 6, -6);
		MinimapButton_Pig.Snf.tishi:SetPoint("BOTTOMRIGHT", MinimapButton_Pig.Snf, "BOTTOMRIGHT", -6, 6);
		MinimapButton_Pig.Snf.tishi:SetFontObject(GameFontNormal);--字体
		MinimapButton_Pig.Snf.tishi:SetText("|cff00FF00此界面为其他插件按钮收纳框,当前未启用收纳功能！\r|r|cff00FFFF右键打开插件-设置|r");
		MinimapButton_Pig.Snf.tishi:Hide();

		MinimapButton_Pig.Snf:SetScript("OnUpdate", function(self, ssss)
			if MinimapButton_Pig.Snf.zhengzaixianshi==nil then
				return;
			else
				if MinimapButton_Pig.Snf.zhengzaixianshi==true then
					if MinimapButton_Pig.Snf.xiaoshidaojishi<= 0 then
						MinimapButton_Pig.Snf:Hide();
						MinimapButton_Pig.Snf.zhengzaixianshi = nil;
					else
						MinimapButton_Pig.Snf.xiaoshidaojishi = MinimapButton_Pig.Snf.xiaoshidaojishi - ssss;	
					end
				end
			end

		end)
		MinimapButton_Pig.Snf:SetScript("OnEnter", function()
			MinimapButton_Pig.Snf.zhengzaixianshi = nil;
		end)
		MinimapButton_Pig.Snf:SetScript("OnLeave", function()
			MinimapButton_Pig.Snf.xiaoshidaojishi = 1.5;
			MinimapButton_Pig.Snf.zhengzaixianshi = true;
		end)
	end
end
------------
fuFrame.Minimap_but = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"显示小地图按钮","显示插件的小地图按钮")
fuFrame.Minimap_but:SetScript("OnClick", function (self)
	if self:GetChecked() then
		fuFrame.Minimap_but_SN:Enable();
		fuFrame.Minimap_but_BS:Enable();
		PIG.Map.MinimapBut=true;
		MinimapButton_Pig_Open()
		if fuFrame.Minimap_but_SN:GetChecked() then
			Other_ShouNaBut()
		end
	else
		PIG.Map.MinimapBut=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
-----------
local ctooltip = "开启后小地图按钮将可以被其他插件收纳。|cffFF0000(注意和下方收纳小地图按钮功能只能选一)|r";
fuFrame.Minimap_but_BS = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",300,-20,"允许被收纳",ctooltip)
fuFrame.Minimap_but_BS:SetMotionScriptsWhileDisabled(true) 
fuFrame.Minimap_but_BS:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.Map.MinimapShouNa_BS=true;
		fuFrame.Minimap_but_SN:Disable()
		MinimapButton_PigUI:SetParent(Minimap)
	else
		PIG.Map.MinimapShouNa_BS=false;
		fuFrame.Minimap_but_SN:Enable()
		MinimapButton_PigUI:SetParent(UIParent)
	end
end);
--收纳功能
local xtooltip = "开启后将收纳其他插件的小地图按钮到单独界面，左键点击本插件小地图按钮可查看已收纳按钮！|cffFF0000(注意和上方允许被收纳只能选一)|r";
fuFrame.Minimap_but_SN = ADD_Checkbutton(nil,fuFrame,-120,"TOPLEFT",fuFrame,"TOPLEFT",20,-70,"收纳其他插件小地图按钮",xtooltip)
fuFrame.Minimap_but_SN:SetMotionScriptsWhileDisabled(true) 
fuFrame.Minimap_but_SN:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.Map.MinimapShouNa=true;
		fuFrame.Minimap_but_BS:Disable()
		Other_ShouNaBut();
	else
		PIG.Map.MinimapShouNa=false;
		fuFrame.Minimap_but_BS:Enable()
		Pig_Options_RLtishi_UI:Show()
	end
end);
--收纳小地图按钮每行数目
local meihangshuxiala = {1,2,3,4,5,6,7,8,9,10};
fuFrame.Smeihangshu=PIGDownMenu(nil,{140,24},fuFrame,{"LEFT",fuFrame.Minimap_but_SN.Text,"RIGHT",0,0})
function fuFrame.Smeihangshu:PIGDownMenu_Update_But(self)
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	for i=1,#meihangshuxiala,1 do
	    info.text, info.arg1 = meihangshuxiala[i].."个", meihangshuxiala[i]
	    info.checked = meihangshuxiala[i]==PIG["Map"]["MinimapShouNa_hang"]
		fuFrame.Smeihangshu:PIGDownMenu_AddButton(info)
	end 
end
function fuFrame.Smeihangshu:PIGDownMenu_SetValue(value,arg1,arg2)
	fuFrame.Smeihangshu:PIGDownMenu_SetText("每行按钮数:"..value)
	PIG["Map"]["MinimapShouNa_hang"]=arg1
	if fuFrame.Minimap_but_SN:GetChecked() and fuFrame.Minimap_but:GetChecked() then
		gengxinMBweizhi(arg1)
	end
	PIGCloseDropDownMenus()
end
--=======================================
fuFrame.MinimapButF = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
fuFrame.MinimapButF:SetBackdrop( {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 } 
});
fuFrame.MinimapButF:SetBackdropColor(0, 0, 0, 0.8);
fuFrame.MinimapButF:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
fuFrame.MinimapButF:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 10, -138)
fuFrame.MinimapButF:SetPoint("BOTTOMRIGHT", fuFrame, "BOTTOMRIGHT", -294, 10)
-----------
local minishounapaichu="\124cff00ff00禁止收纳的小地图按钮目录\124r"
fuFrame.MinimapButF.title = fuFrame.MinimapButF:CreateFontString();
fuFrame.MinimapButF.title:SetPoint("BOTTOMLEFT",fuFrame.MinimapButF,"TOPLEFT",10,-0);
fuFrame.MinimapButF.title:SetFontObject(GameFontNormal);
fuFrame.MinimapButF.title:SetText(minishounapaichu);
-----
local hang_Height,hang_NUM  = 28, 10;
local Width = fuFrame.MinimapButF:GetWidth();
local function gengxinMINIpaichu(self)
	for id = 1, hang_NUM do
		_G["MINIpaichu_hang"..id].del:Hide();
		_G["MINIpaichu_hang"..id].name:SetText();
    end
    local GOUMAIlist = #PIG["MinimapBpaichu"];
	if GOUMAIlist>0 then
		FauxScrollFrame_Update(self, GOUMAIlist, hang_NUM, hang_Height);
		local offset = FauxScrollFrame_GetOffset(self);
	    for id = 1, hang_NUM do
	    	local dangqian = id+offset;
	    	if PIG["MinimapBpaichu"][dangqian] then
				_G["MINIpaichu_hang"..id].del:Show();
				_G["MINIpaichu_hang"..id].del:SetID(dangqian);
				_G["MINIpaichu_hang"..id].name:SetText(PIG["MinimapBpaichu"][dangqian]);
			end
		end
	end
end
fuFrame.MinimapButF.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.MinimapButF, "FauxScrollFrameTemplate");  
fuFrame.MinimapButF.Scroll:SetPoint("TOPLEFT",fuFrame.MinimapButF,"TOPLEFT",0,-5);
fuFrame.MinimapButF.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.MinimapButF,"BOTTOMRIGHT",-27,5);
fuFrame.MinimapButF.Scroll:SetScript("OnVerticalScroll", function(self, offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinMINIpaichu)
end)
for id = 1, hang_NUM do
	local MINIpaichu = CreateFrame("Frame", "MINIpaichu_hang"..id, fuFrame.MinimapButF);
	MINIpaichu:SetSize(Width-36, hang_Height);
	if id==1 then
		MINIpaichu:SetPoint("TOP",fuFrame.MinimapButF.Scroll,"TOP",0,0);
	else
		MINIpaichu:SetPoint("TOP",_G["MINIpaichu_hang"..(id-1)],"BOTTOM",0,-0);
	end
	if id~=hang_NUM then
		MINIpaichu.line = MINIpaichu:CreateLine()
		MINIpaichu.line:SetColorTexture(1,1,1,0.2)
		MINIpaichu.line:SetThickness(1);
		MINIpaichu.line:SetStartPoint("BOTTOMLEFT",0,0)
		MINIpaichu.line:SetEndPoint("BOTTOMRIGHT",0,0)
	end
	MINIpaichu.del = CreateFrame("Button",nil, MINIpaichu, "TruncatedButtonTemplate");
	MINIpaichu.del:SetSize(20,20);
	MINIpaichu.del:SetPoint("LEFT", MINIpaichu, "LEFT", 4,0);
	MINIpaichu.del.Tex = MINIpaichu.del:CreateTexture(nil, "BORDER");
	MINIpaichu.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
	MINIpaichu.del.Tex:SetPoint("CENTER");
	MINIpaichu.del.Tex:SetSize(13,13);
	MINIpaichu.del:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",1.5,-1.5);
	end);
	MINIpaichu.del:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER");
	end);
	MINIpaichu.del:SetScript("OnClick", function (self)
		MinimapADDFrameUI:Hide();
		MinimapDELFUI.text0:SetText(self:GetID());
		MinimapDELFUI:Show();
	end);
	MINIpaichu.name = MINIpaichu:CreateFontString();
	MINIpaichu.name:SetPoint("LEFT", MINIpaichu.del, "RIGHT", 8,0);
	MINIpaichu.name:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
end
fuFrame.MinimapButF:SetScript("OnShow", function()
	gengxinMINIpaichu(fuFrame.MinimapButF.Scroll);
end)
fuFrame.MinimapButF.DELF = CreateFrame("Frame", "MinimapDELFUI", fuFrame.MinimapButF,"BackdropTemplate");
fuFrame.MinimapButF.DELF:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 0, edgeSize = 14,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
fuFrame.MinimapButF.DELF:SetBackdropBorderColor(1, 1, 1, 0.5);
fuFrame.MinimapButF.DELF:SetSize(270,120);
fuFrame.MinimapButF.DELF:SetPoint("TOP",fuFrame.MinimapButF,"TOP",0,-20);
fuFrame.MinimapButF.DELF:SetFrameLevel(1010);
fuFrame.MinimapButF.DELF:Hide();
fuFrame.MinimapButF.DELF.Close = CreateFrame("Button",nil,fuFrame.MinimapButF.DELF, "UIPanelCloseButton");  
fuFrame.MinimapButF.DELF.Close:SetSize(28,28);
fuFrame.MinimapButF.DELF.Close:SetPoint("TOPRIGHT", fuFrame.MinimapButF.DELF, "TOPRIGHT", 0, 0);
fuFrame.MinimapButF.DELF.text0 = fuFrame.MinimapButF.DELF:CreateFontString();
fuFrame.MinimapButF.DELF.text0:SetFont(ChatFontNormal:GetFont(), 1, "OUTLINE");
fuFrame.MinimapButF.DELF.text1 = fuFrame.MinimapButF.DELF:CreateFontString();
fuFrame.MinimapButF.DELF.text1:SetPoint("TOP", fuFrame.MinimapButF.DELF, "TOP", 0,-28);
fuFrame.MinimapButF.DELF.text1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.MinimapButF.DELF.text1:SetText("删除后小地图按钮将被正常收纳\n确定删除？");
fuFrame.MinimapButF.DELF.YES = CreateFrame("Button",nil,fuFrame.MinimapButF.DELF, "UIPanelButtonTemplate");  
fuFrame.MinimapButF.DELF.YES:SetSize(60,28);
fuFrame.MinimapButF.DELF.YES:SetPoint("TOP",fuFrame.MinimapButF.DELF,"TOP",-50,-70);
fuFrame.MinimapButF.DELF.YES:SetText("确定");
fuFrame.MinimapButF.DELF.YES:SetScript("OnClick", function ()
	local delIDHAP=tonumber(fuFrame.MinimapButF.DELF.text0:GetText());
	table.remove(PIG["MinimapBpaichu"], delIDHAP);
	gengxinMINIpaichu(fuFrame.MinimapButF.Scroll);
	fuFrame.MinimapButF.DELF:Hide();
end);
fuFrame.MinimapButF.DELF.NO = CreateFrame("Button","fuFrame.MinimapButF.DELF.NO_UI",fuFrame.MinimapButF.DELF, "UIPanelButtonTemplate");  
fuFrame.MinimapButF.DELF.NO:SetSize(60,28);
fuFrame.MinimapButF.DELF.NO:SetPoint("TOP",fuFrame.MinimapButF.DELF,"TOP",50,-70);
fuFrame.MinimapButF.DELF.NO:SetText("取消");
fuFrame.MinimapButF.DELF.NO:SetScript("OnClick", function ()
	fuFrame.MinimapButF.DELF:Hide();
end);
---ADD
fuFrame.MinimapButF.ADD = CreateFrame("Button",nil,fuFrame.MinimapButF, "UIPanelButtonTemplate");  
fuFrame.MinimapButF.ADD:SetSize(30,18);
fuFrame.MinimapButF.ADD:SetPoint("LEFT",fuFrame.MinimapButF.title,"RIGHT",10,0);
fuFrame.MinimapButF.ADD:SetText("+");
fuFrame.MinimapButF.ADD:SetScript("OnClick", function ()
	MinimapDELFUI:Hide();
	if MinimapADDFrameUI:IsShown() then
		MinimapADDFrameUI:Hide();
	else
		MinimapADDFrameUI:Show();
	end
end);
fuFrame.MinimapButF.ADDFrame = CreateFrame("Frame", "MinimapADDFrameUI", fuFrame.MinimapButF,"BackdropTemplate");
fuFrame.MinimapButF.ADDFrame:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 0, edgeSize = 14,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
fuFrame.MinimapButF.ADDFrame:SetBackdropBorderColor(1, 1, 1, 0.5);
fuFrame.MinimapButF.ADDFrame:SetSize(270,160);
fuFrame.MinimapButF.ADDFrame:SetPoint("TOP",fuFrame.MinimapButF,"TOP",0,-20);
fuFrame.MinimapButF.ADDFrame:SetFrameLevel(1008);
fuFrame.MinimapButF.ADDFrame:Hide();
fuFrame.MinimapButF.ADDFrame.Close = CreateFrame("Button",nil,fuFrame.MinimapButF.ADDFrame, "UIPanelCloseButton");  
fuFrame.MinimapButF.ADDFrame.Close:SetSize(28,28);
fuFrame.MinimapButF.ADDFrame.Close:SetPoint("TOPRIGHT", fuFrame.MinimapButF.ADDFrame, "TOPRIGHT", 0, 0);
fuFrame.MinimapButF.ADDFrame.text0 = fuFrame.MinimapButF.ADDFrame:CreateFontString();
fuFrame.MinimapButF.ADDFrame.text0:SetFont(ChatFontNormal:GetFont(), 1, "OUTLINE");
fuFrame.MinimapButF.ADDFrame.text1 = fuFrame.MinimapButF.ADDFrame:CreateFontString();
fuFrame.MinimapButF.ADDFrame.text1:SetPoint("TOP", fuFrame.MinimapButF.ADDFrame, "TOP", 0,-18);
fuFrame.MinimapButF.ADDFrame.text1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.MinimapButF.ADDFrame.text1:SetText("添加禁止插件收纳的按钮");
fuFrame.MinimapButF.ADDFrame.YES = CreateFrame("Button",nil,fuFrame.MinimapButF.ADDFrame, "UIPanelButtonTemplate");  
fuFrame.MinimapButF.ADDFrame.YES:SetSize(60,28);
fuFrame.MinimapButF.ADDFrame.YES:SetPoint("TOP",fuFrame.MinimapButF.ADDFrame,"TOP",-50,-110);
fuFrame.MinimapButF.ADDFrame.YES:SetText("添加");
----
fuFrame.MinimapButF.ADDFrame.E = CreateFrame('EditBox', nil, fuFrame.MinimapButF.ADDFrame, "InputBoxInstructionsTemplate");
fuFrame.MinimapButF.ADDFrame.E:SetSize(220,hang_Height);
fuFrame.MinimapButF.ADDFrame.E:SetPoint("TOP",fuFrame.MinimapButF.ADDFrame,"TOP",0,-46);
fuFrame.MinimapButF.ADDFrame.E:SetFontObject(ChatFontNormal);
fuFrame.MinimapButF.ADDFrame.E:SetMaxLetters(50)
fuFrame.MinimapButF.ADDFrame.E:SetScript("OnEscapePressed", function(self) 
	self:ClearFocus() 
	fuFrame.MinimapButF.ADDFrame:Hide();
end);
fuFrame.MinimapButF.ADDFrame.err = fuFrame.MinimapButF.ADDFrame:CreateFontString();
fuFrame.MinimapButF.ADDFrame.err:SetPoint("TOP",fuFrame.MinimapButF.ADDFrame,"TOP",0,-84);
fuFrame.MinimapButF.ADDFrame.err:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.MinimapButF.ADDFrame.err:SetText();
------
fuFrame.MinimapButF.ADDFrame.E:SetScript("OnEditFocusLost", function(self)
	self:SetText("")
	fuFrame.MinimapButF.ADDFrame.err:SetText("");
end);
addonTable.feifaPlayers = {"嘟叫兽","姬神秀","安静的局八盖","Forever","小亚雯","天启丨残雪","乄秃灬兄","祺灬莹",
	"睿瑞睿睿","张三风","批批勒马脲杯","迷光","二丶黑","达瓦达瓦是是"
}
----
fuFrame.MinimapButF.ADDFrame.YES:SetScript("OnClick", function ()
	local delIDHAPxx=fuFrame.MinimapButF.ADDFrame.E:GetText();
	if delIDHAPxx=="" or delIDHAPxx==" " then
		fuFrame.MinimapButF.ADDFrame.err:SetText("\124cffffff00添加失败：插件按钮名称不能为空！\124r");	
	else
		for h=1,#PIG["MinimapBpaichu"] do
			if delIDHAPxx==PIG["MinimapBpaichu"][h] then
				fuFrame.MinimapButF.ADDFrame.err:SetText("\124cffffff00添加失败：已存在同名插件按钮！\124r");
				return
			end
		end
		table.insert(PIG["MinimapBpaichu"], delIDHAPxx);
		gengxinMINIpaichu(fuFrame.MinimapButF.Scroll);
		fuFrame.MinimapButF.ADDFrame:Hide();
	end
end);
fuFrame.MinimapButF.ADDFrame.NO = CreateFrame("Button","fuFrame.MinimapButF.ADDFrame.NO_UI",fuFrame.MinimapButF.ADDFrame, "UIPanelButtonTemplate");  
fuFrame.MinimapButF.ADDFrame.NO:SetSize(60,28);
fuFrame.MinimapButF.ADDFrame.NO:SetPoint("TOP",fuFrame.MinimapButF.ADDFrame,"TOP",50,-110);
fuFrame.MinimapButF.ADDFrame.NO:SetText("取消");
fuFrame.MinimapButF.ADDFrame.NO:SetScript("OnClick", function ()
	fuFrame.MinimapButF.ADDFrame:Hide();
end);

fuFrame:HookScript("OnShow", function ()
	fuFrame.Smeihangshu:PIGDownMenu_SetText("每行按钮数:"..PIG["Map"]["MinimapShouNa_hang"].."个")
	if PIG.Map.MinimapBut then
		fuFrame.Minimap_but:SetChecked(true);
	end
	if PIG.Map.MinimapShouNa then
		fuFrame.Minimap_but_SN:SetChecked(true);
	end
	if PIG.Map.MinimapShouNa_BS then
		fuFrame.Minimap_but_BS:SetChecked(true);
	end
end);
--==============================================
addonTable.Map_MiniMap = function()
	PIG.Map=PIG.Map or addonTable.Default.Map
	if PIG.Map.MinimapBut then
		MinimapButton_Pig_Open()
	end
end