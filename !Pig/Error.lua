local addonName, addonTable = ...;
local L =addonTable.locale
-----------------
local bencierrinfo={}
--------------------------------
local WWW,HHH = 600,380
local biaotiW = 25
local Backdropinfo={bgFile = "interface/chatframe/chatframebackground.blp",
	edgeFile = "Interface/AddOns/!Pig/Pigs/Pig_Border.blp", edgeSize = 6,}
local function PIGSetBackdrop(self,but)
	self:SetBackdrop(Backdropinfo)
	if but then
		self:SetBackdropColor(0.2, 0.2, 0.2, 1);
	else
		self:SetBackdropColor(0.08, 0.08, 0.08, 0.9);
	end
	self:SetBackdropBorderColor(0, 0, 0, 1);
end
local function ADD_Button(Text,UIName,fuF,WH,Point)
	local But = CreateFrame("Button", UIName, fuF,"BackdropTemplate");
	PIGSetBackdrop(But,true)
	But:SetSize(WH[1],WH[2]);
	But:SetPoint(Point[1],Point[2],Point[3],Point[4],Point[5]);
	hooksecurefunc(But, "Enable", function(self)
		self.Text:SetTextColor(1, 0.843, 0, 1);
	end)
	hooksecurefunc(But, "Disable", function(self)
		self.Text:SetTextColor(0.5, 0.5, 0.5, 1);
	end)
	But:HookScript("OnEnter", function(self)
		if self:IsEnabled() then
			self:SetBackdropBorderColor(0,0.8,1, 0.9);
		end
	end);
	But:HookScript("OnLeave", function(self)
		if self:IsEnabled() then
			self:SetBackdropBorderColor(0, 0, 0, 1);
		end
	end);
	But:HookScript("OnMouseDown", function(self)
		if self:IsEnabled() then
			self.Text:SetPoint("CENTER", 1.5, -1.5);
		end
	end);
	But:HookScript("OnMouseUp", function(self)
		if self:IsEnabled() then
			self.Text:SetPoint("CENTER", 0, 0);
		end
	end);
	But:HookScript("PostClick", function (self)
		PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
	end)
	But.Text = But:CreateFontString();
	But.Text:SetPoint("CENTER", 0, 0);
	But.Text:SetFont(ChatFontNormal:GetFont(), 13)
	But.Text:SetTextColor(1, 0.843, 0, 1);
	But.Text:SetText(Text);
	return But
end

local function ADD_TabBut(Text,UIName,fuF,WH,Point,id)
	local But = CreateFrame("Button", UIName, fuF,"BackdropTemplate",id);
	But.Show=false;
	PIGSetBackdrop(But,true)
	But:SetSize(WH[1],WH[2]);
	But:SetPoint(Point[1],Point[2],Point[3],Point[4],Point[5]);
	hooksecurefunc(But, "Enable", function(self)
		self.Text:SetTextColor(1, 0.843, 0, 1);
	end)
	hooksecurefunc(But, "Disable", function(self)
		self.Text:SetTextColor(0.5, 0.5, 0.5, 1);
	end)
	But:HookScript("OnEnter", function(self)
		if self:IsEnabled() and not self.Show then
			self:SetBackdropBorderColor(0,0.8,1, 1);
		end
	end);
	But:HookScript("OnLeave", function(self)
		if self:IsEnabled() and not self.Show then
			self:SetBackdropBorderColor(0, 0, 0, 1);
		end
	end);
	But:HookScript("OnMouseDown", function(self)
		if self:IsEnabled() and not self.Show then
			self.Text:SetPoint("CENTER", 1.5, -1.5);
		end
	end);
	But:HookScript("OnMouseUp", function(self)
		if self:IsEnabled() and not self.Show then
			self.Text:SetPoint("CENTER", 0, 0);
		end
	end);
	But.Text = But:CreateFontString();
	But.Text:SetPoint("CENTER", 0, 0);
	But.Text:SetFont(ChatFontNormal:GetFont(), 13)
	But.Text:SetTextColor(1, 0.843, 0, 1);
	But.Text:SetText(Text);
	function But:selected()
		PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB);
		self.Show=true;
		self.Text:SetTextColor(1, 1, 1, 1);
		self:SetBackdropColor(0.3098,0.262745,0.0353, 1);
		self:SetBackdropBorderColor(1, 1, 0, 1);	
	end
	return But
end
----
local Bugcollect = CreateFrame("Frame", "Bugcollect_UI", UIParent,"BackdropTemplate");
PIGSetBackdrop(Bugcollect)
Bugcollect:SetSize(WWW,HHH);
Bugcollect:SetPoint("CENTER",0,0);
Bugcollect:EnableMouse(true)
Bugcollect:SetMovable(true)
Bugcollect:SetClampedToScreen(true)
Bugcollect:SetFrameStrata("HIGH")
Bugcollect:Hide()
tinsert(UISpecialFrames,"Bugcollect_UI");

Bugcollect.Moving = CreateFrame("Frame", nil, Bugcollect);
Bugcollect.Moving:SetSize(WWW-60,biaotiW);
Bugcollect.Moving:SetPoint("TOP",Bugcollect,"TOP",0,0);
Bugcollect.Moving:EnableMouse(true)
Bugcollect.Moving:RegisterForDrag("LeftButton")
Bugcollect.Moving:SetScript("OnDragStart",function()
    Bugcollect:StartMoving();
end)
Bugcollect.Moving:SetScript("OnDragStop",function()
    Bugcollect:StopMovingOrSizing()
end)
Bugcollect.Moving.qingkong = ADD_Button(L["ERROR_CLEAR"],nil,Bugcollect.Moving,{60,20},{"TOPRIGHT",Bugcollect.Moving,"TOPRIGHT",-80,-2.8})
Bugcollect.Moving.qingkong:SetScript("OnClick", function (self)
	PIG["Error"]["ErrorInfo"]={}
	bencierrinfo={}
	Bugcollect:qingkongERR()
end);
Bugcollect.Close = CreateFrame("Button",nil,Bugcollect);
Bugcollect.Close:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp")
Bugcollect.Close:SetSize(24,24);
Bugcollect.Close:SetPoint("TOPRIGHT",Bugcollect,"TOPRIGHT",0,0);
Bugcollect.Close.Tex = Bugcollect.Close:CreateTexture(nil, "BORDER");
Bugcollect.Close.Tex:SetTexture("interface/common/voicechat-muted.blp");
Bugcollect.Close.Tex:SetSize(Bugcollect.Close:GetWidth()-8,Bugcollect.Close:GetHeight()-8);
Bugcollect.Close.Tex:SetPoint("CENTER",0,0);
Bugcollect.Close:SetScript("OnMouseDown", function (self)
	self.Tex:SetPoint("CENTER",-1.5,-1.5);
end);
Bugcollect.Close:SetScript("OnMouseUp", function (self)
	self.Tex:SetPoint("CENTER");
end);
Bugcollect.Close:SetScript("OnClick", function (self)
	PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
	self:GetParent():Hide()
end);

Bugcollect.Time = Bugcollect.Moving:CreateFontString();
Bugcollect.Time:SetPoint("TOPLEFT",Bugcollect,"TOPLEFT",10,-5);
Bugcollect.Time:SetFontObject(GameFontNormal);
Bugcollect.biaoti = Bugcollect.Moving:CreateFontString();
Bugcollect.biaoti:SetPoint("TOP",Bugcollect,"TOP",0,-6);
Bugcollect.biaoti:SetFont(ChatFontNormal:GetFont(), 14)
Bugcollect.biaoti:SetTextColor(1,0.843,0)
---显示区域
Bugcollect.NR = CreateFrame("Frame", nil, Bugcollect,"BackdropTemplate");
Bugcollect.NR:SetBackdrop(Backdropinfo)
Bugcollect.NR:SetBackdropColor(0.14, 0.14, 0.14, 0.8);
Bugcollect.NR:SetBackdropBorderColor(0, 0, 0, 1);
Bugcollect.NR:SetSize(WWW,HHH-biaotiW*2);
Bugcollect.NR:SetPoint("TOP",Bugcollect,"TOP",0,-biaotiW);
----------
Bugcollect.NR.scroll = CreateFrame("ScrollFrame", nil, Bugcollect.NR, "UIPanelScrollFrameTemplate")
Bugcollect.NR.scroll:SetPoint("TOPLEFT", Bugcollect.NR, "TOPLEFT", 6, -2)
Bugcollect.NR.scroll:SetPoint("BOTTOMRIGHT", Bugcollect.NR, "BOTTOMRIGHT", -24, 6)

Bugcollect.NR.textArea = CreateFrame("EditBox", nil, Bugcollect.NR.scroll)
Bugcollect.NR.textArea:SetTextColor(0.9, 0.9, 0.9, 1)
Bugcollect.NR.textArea:SetAutoFocus(false)
Bugcollect.NR.textArea:SetMultiLine(true)
Bugcollect.NR.textArea:SetFontObject(GameFontHighlightSmall)
Bugcollect.NR.textArea:SetMaxLetters(99999)
Bugcollect.NR.textArea:EnableMouse(true)
Bugcollect.NR.textArea:SetScript("OnEscapePressed", Bugcollect.NR.textArea.ClearFocus)
Bugcollect.NR.textArea:SetWidth(WWW-30)

Bugcollect.NR.scroll:SetScrollChild(Bugcollect.NR.textArea)
--------------
Bugcollect.prevZ = ADD_Button("《 ",nil,Bugcollect,{30,20},{"BOTTOMLEFT",Bugcollect,"BOTTOMLEFT",10,3})
Bugcollect.prevZ:Disable()
Bugcollect.prev = ADD_Button(L["ERROR_PREVIOUS"],nil,Bugcollect,{90,20},{"BOTTOM",Bugcollect,"BOTTOM",-130,3})
Bugcollect.prev:Disable()
Bugcollect.next = ADD_Button(L["ERROR_NEXT"],nil,Bugcollect,{90,20},{"BOTTOM",Bugcollect,"BOTTOM",130,3})
Bugcollect.next:Disable()
Bugcollect.nextZ = ADD_Button(" 》",nil,Bugcollect,{30,20},{"BOTTOMRIGHT",Bugcollect,"BOTTOMRIGHT",-10,3})
Bugcollect.nextZ:Disable()
------------
function Bugcollect:qingkongERR()
	Bugcollect.prev:Disable()
	Bugcollect.next:Disable()
	Bugcollect.prevZ:Disable()
	Bugcollect.nextZ:Disable()
	Bugcollect.Time:SetText("");
	Bugcollect.biaoti:SetText(L["ERROR_EMPTY"]);
	Bugcollect.NR.textArea:SetText("")
end
----------------------
local function xianshixinxi(id)
	if Bugcollect_UI:IsShown() then
		Bugcollect:qingkongERR()
		local shujuyuan = {}
		if BugcollectTAB_1.Show then
			shujuyuan.ly=bencierrinfo
			shujuyuan.num=#shujuyuan.ly
		elseif BugcollectTAB_2.Show then
			shujuyuan.ly=PIG["Error"]["ErrorInfo"]
			shujuyuan.num=#shujuyuan.ly
		end
		if shujuyuan.num==0 then return end
		local msg=shujuyuan.ly[id][1]
		local time=shujuyuan.ly[id][2]
		local time = date("%Y/%m/%d %H:%M:%S",time)
		local stack=shujuyuan.ly[id][3]
		local logrizhi=shujuyuan.ly[id][4]
		local cuowushu=shujuyuan.ly[id][5]
		Bugcollect.Time:SetText(time);
		Bugcollect.biaoti:SetText(id.."/"..shujuyuan.num);
		if cuowushu>1 then
			Bugcollect.NR.textArea:SetText(cuowushu.."× "..msg.."\n"..stack.."\n"..logrizhi)
		else
			Bugcollect.NR.textArea:SetText(msg.."\n"..stack.."\n"..logrizhi)
		end
		Bugcollect.prev.id=id
		Bugcollect.next.id=id
		if shujuyuan.num>1 then
			if id==1 then
				Bugcollect.prevZ:Disable()
				Bugcollect.prev:Disable()
				Bugcollect.next:Enable()
				Bugcollect.nextZ:Enable()
			elseif shujuyuan.num==id then
				Bugcollect.next:Disable()
				Bugcollect.nextZ:Disable()
				Bugcollect.prev:Enable()
				Bugcollect.prevZ:Enable()
			else
				Bugcollect.prev:Enable()
				Bugcollect.next:Enable()
				Bugcollect.prevZ:Enable()
				Bugcollect.nextZ:Enable()
			end
		else	
			Bugcollect.prev:Disable()
			Bugcollect.next:Disable()
			Bugcollect.prevZ:Disable()
			Bugcollect.nextZ:Disable()
		end
	end
end
local function kaishiShow()
	if BugcollectTAB_1.Show then
		local tablenum = #bencierrinfo
		xianshixinxi(tablenum)
	elseif BugcollectTAB_2.Show then
		local tablenum = #PIG["Error"]["ErrorInfo"]
		xianshixinxi(tablenum)
	end
end
-----
local TabWidth,TabHeight = 110,24;
local TabName = {L["ERROR_CURRENT"],L["ERROR_OLD"]};
for id=1,#TabName do
	local Point = {"TOPLEFT", Bugcollect, "BOTTOMLEFT", 30,0}
	if id>1 then
		Point = {"LEFT", _G["BugcollectTAB_"..(id-1)], "RIGHT", 20,0}
	end
	local Tablist = ADD_TabBut(TabName[id],"BugcollectTAB_"..id,Bugcollect,{TabWidth,TabHeight},Point,id)
	Tablist:SetScript("OnClick", function (self)
		for x=1,#TabName do
			local fagg=_G["BugcollectTAB_"..x]
			fagg.Show=false;
			fagg.Text:SetTextColor(1, 0.843, 0, 1);
			fagg:SetBackdropColor(0.2, 0.2, 0.2, 1);
			fagg:SetBackdropBorderColor(0, 0, 0, 1);
		end
		self:selected()
		kaishiShow()
	end);
	---
	if id==1 then
		Tablist:selected()
	end
end
-------
Bugcollect.prevZ:SetScript("OnClick", function(self, button)
	local newid = 1
	xianshixinxi(newid)
end)
Bugcollect.prev:SetScript("OnClick", function(self, button)
	local newid = self.id-1
	xianshixinxi(newid)
end)
Bugcollect.next:SetScript("OnClick", function(self, button)
	local newid = self.id+1
	xianshixinxi(newid)
end)
Bugcollect.nextZ:SetScript("OnClick", function(self, button)
	for x=1,#TabName do
		if _G["BugcollectTAB_"..x].Show then
			if x==1 then
				xianshixinxi(#bencierrinfo)
			elseif x==2 then
				xianshixinxi(#PIG["Error"]["ErrorInfo"])
			end
		end
	end
end)
----------------
Bugcollect:SetScript("OnShow", function(self)
	self:SetFrameLevel(99)
	kaishiShow()
end)
----错误处理FUN
local function errottishi()
	if Bugcollect.yijiazai then
		if PIG["Error"]["ErrorTishi"] and MinimapButton_PigUI then
			MinimapButton_PigUI.error:Show();
		end
	end
end
local function errotFUN(msg)
	--print(msg)
	local stack = debugstack(3) or "null"
	local logrizhi = debuglocals(3) or "null"
	local time = GetServerTime()
	local hejishu=#bencierrinfo
	Bugcollect.cuowushu = 1
	for i=hejishu,1,-1 do
		if bencierrinfo[i][1]==msg then
			Bugcollect.cuowushu = Bugcollect.cuowushu+bencierrinfo[i][5]
			table.remove(bencierrinfo,i);
			break
		end
	end
	table.insert(bencierrinfo, {msg,time,stack,logrizhi,Bugcollect.cuowushu});
	xianshixinxi(#bencierrinfo)
	errottishi()
end
UIParent:UnregisterEvent("LUA_WARNING")
local Pig_seterrorhandler=seterrorhandler
Pig_seterrorhandler(errotFUN);
function seterrorhandler() end
--========================================================
local function del_ErrorInfo()			
	PIG["Error"]=PIG["Error"] or addonTable.Default["Error"]
	if #PIG["Error"]["ErrorInfo"]>0 then
		for i=#PIG["Error"]["ErrorInfo"],1,-1 do
			if (GetServerTime()-PIG["Error"]["ErrorInfo"][i][2])>86400 then
				table.remove(PIG["Error"]["ErrorInfo"],i)
			end
		end
	end
	Bugcollect.yijiazai=true
	if #bencierrinfo>0 then	
		errottishi()
	end
end
--
Bugcollect:RegisterEvent("LUA_WARNING")
Bugcollect:RegisterEvent("ADDON_ACTION_FORBIDDEN");
Bugcollect:RegisterEvent("ADDON_ACTION_BLOCKED");
Bugcollect:RegisterEvent("MACRO_ACTION_FORBIDDEN");
Bugcollect:RegisterEvent("MACRO_ACTION_BLOCKED");
Bugcollect:RegisterEvent("PLAYER_LOGIN")
Bugcollect:RegisterEvent("PLAYER_LOGOUT");
Bugcollect:RegisterEvent("ADDON_LOADED")
Bugcollect:SetScript("OnEvent", function(self,event,arg1,arg2)
	if event=="ADDON_LOADED" then
		--if event=="ADDON_LOADED" and arg1==addonName then
		C_Timer.After(3,del_ErrorInfo)
		Bugcollect:UnregisterEvent("ADDON_LOADED")
	elseif event=="PLAYER_LOGIN" then
		--C_Timer.After(3,del_ErrorInfo)
	elseif event=="PLAYER_LOGOUT" then
		local hejishu=#bencierrinfo
		for i=1,hejishu do
			table.insert(PIG["Error"]["ErrorInfo"], bencierrinfo[i]);
		end
	elseif event=="ADDON_ACTION_FORBIDDEN" or event=="ADDON_ACTION_BLOCKED" then
		local msg = "["..event.."] "..L["ERROR_ADDON"].."< "..arg1.." >"..L["ERROR_ERROR1"].."< "..arg2.." >"
		local stack = debugstack(3) or "null"
		local logrizhi = debuglocals(3) or "null"
		local time = GetServerTime()
		local hejishu=#bencierrinfo
		Bugcollect.cuowushu = 1
		for i=hejishu,1,-1 do
			if bencierrinfo[i][1]==msg then
				Bugcollect.cuowushu =Bugcollect.cuowushu+bencierrinfo[i][5]
				table.remove(bencierrinfo,i);
				break
			end
		end
		table.insert(bencierrinfo, {msg,time,stack,logrizhi,Bugcollect.cuowushu});
		xianshixinxi(#bencierrinfo)
		errottishi()
	elseif event=="MACRO_ACTION_FORBIDDEN" or event=="MACRO_ACTION_BLOCKED" then
		local msg = "["..event.."] "..L["ERROR_ERROR2"].."<"..arg1..">"
		local stack = debugstack(3) or "null"
		local logrizhi = debuglocals(3) or "null"
		local time = GetServerTime()
		local hejishu=#bencierrinfo
		Bugcollect.cuowushu = 1
		for i=hejishu,1,-1 do
			if bencierrinfo[i][1]==msg then
				Bugcollect.cuowushu =Bugcollect.cuowushu+bencierrinfo[i][5]
				table.remove(bencierrinfo,i);
				break
			end
		end
		table.insert(bencierrinfo, {msg,time,stack,logrizhi,Bugcollect.cuowushu});
		xianshixinxi(#bencierrinfo)
		errottishi()
	elseif event=="LUA_WARNING" then
		errotFUN(arg2)
	end
end)
--==================================
SLASH_PER1 = "/per"
SLASH_PER2 = "/Per"
SLASH_PER3 = "/PER"
SlashCmdList["PER"] = function()
	Bugcollect_UI:Show();
end