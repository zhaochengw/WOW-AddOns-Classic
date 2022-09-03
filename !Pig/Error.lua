local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local ADD_Frame=addonTable.ADD_Frame
-----------------
local Pig_seterrorhandler=seterrorhandler
local bencierrinfo={}
--------------------------------
local WWW,HHH = 600,380
local biaotiW = 25
local Bugshouji=ADD_Frame("Bugshouji_UI",UIParent,WWW,HHH,"CENTER",UIParent,"CENTER",0,0,true,true,true,true,true)
Bugshouji:SetBackdrop({bgFile = "interface/raidframe/ui-raidframe-groupbg.blp", 
	edgeFile = "interface/glues/common/textpanel-border.blp", 
	tile = false, tileSize = 0, edgeSize = 20,insets = { left = 4, right = 4, top = 2, bottom = 4 }});
Bugshouji:SetFrameStrata("HIGH")

Bugshouji.Moving = CreateFrame("Frame", nil, Bugshouji);
Bugshouji.Moving:SetSize(WWW-60,biaotiW);
Bugshouji.Moving:SetPoint("TOP",Bugshouji,"TOP",0,-2);
Bugshouji.Moving:EnableMouse(true)
Bugshouji.Moving:RegisterForDrag("LeftButton")
Bugshouji.Moving.qingkong = CreateFrame("Button",nil,Bugshouji.Moving, "UIPanelButtonTemplate");
Bugshouji.Moving.qingkong:SetSize(60,20);
Bugshouji.Moving.qingkong:SetPoint("TOPRIGHT",Bugshouji.Moving,"TOPRIGHT",-20,-1);
Bugshouji.Moving.qingkong:SetText('清空');
Bugshouji.Moving.qingkong:SetScript("OnClick", function (self)
	PIG["Error"]["ErrorInfo"]={}
	bencierrinfo={}
	Bugshouji:qingkongERR()
end);
Bugshouji.Moving:SetScript("OnDragStart",function()
    Bugshouji:StartMoving();
end)
Bugshouji.Moving:SetScript("OnDragStop",function()
    Bugshouji:StopMovingOrSizing()
end)
Bugshouji.Close = CreateFrame("Button",nil,Bugshouji, "UIPanelCloseButton");  
Bugshouji.Close:SetSize(34,34);
Bugshouji.Close:SetPoint("TOPRIGHT",Bugshouji,"TOPRIGHT",4,4);
Bugshouji.Time = Bugshouji:CreateFontString();
Bugshouji.Time:SetPoint("TOPLEFT",Bugshouji,"TOPLEFT",10,-5);
Bugshouji.Time:SetFontObject(GameFontNormal);
Bugshouji.biaoti = Bugshouji:CreateFontString();
Bugshouji.biaoti:SetPoint("TOP",Bugshouji,"TOP",0,-5);
Bugshouji.biaoti:SetFontObject(GameFontNormal);
Bugshouji.xxX = Bugshouji:CreateLine()
Bugshouji.xxX:SetColorTexture(1,1,1,0.3)
Bugshouji.xxX:SetThickness(2);
Bugshouji.xxX:SetStartPoint("TOPLEFT",5,-biaotiW)
Bugshouji.xxX:SetEndPoint("TOPRIGHT",-3,-biaotiW)
---显示区域
Bugshouji.NR = CreateFrame("Frame", nil, Bugshouji);
Bugshouji.NR:SetSize(WWW-20,HHH-biaotiW-10);
Bugshouji.NR:SetPoint("TOP",Bugshouji.xxX,"TOP",0,-4);
----------
Bugshouji.NR.scroll = CreateFrame("ScrollFrame", nil, Bugshouji.NR, "UIPanelScrollFrameTemplate")
Bugshouji.NR.scroll:SetPoint("TOPLEFT", Bugshouji.NR, "TOPLEFT", 0, 0)
Bugshouji.NR.scroll:SetPoint("BOTTOMRIGHT", Bugshouji.NR, "BOTTOMRIGHT", -20, 30)

Bugshouji.NR.textArea = CreateFrame("EditBox", nil, Bugshouji.NR.scroll)
Bugshouji.NR.textArea:SetTextColor(.8, .8, .8, 1)
Bugshouji.NR.textArea:SetAutoFocus(false)
Bugshouji.NR.textArea:SetMultiLine(true)
Bugshouji.NR.textArea:SetFontObject(GameFontHighlightSmall)
Bugshouji.NR.textArea:SetMaxLetters(99999)
Bugshouji.NR.textArea:EnableMouse(true)
Bugshouji.NR.textArea:SetScript("OnEscapePressed", Bugshouji.NR.textArea.ClearFocus)
Bugshouji.NR.textArea:SetWidth(WWW-40)

Bugshouji.NR.scroll:SetScrollChild(Bugshouji.NR.textArea)
--------------
Bugshouji.prev = CreateFrame("Button",nil,Bugshouji, "UIPanelButtonTemplate");
Bugshouji.prev:SetSize(90,22);
Bugshouji.prev:SetPoint("BOTTOM",Bugshouji,"BOTTOM",-140,8);
Bugshouji.prev:SetText("上一条");
Bugshouji.prev:Disable()

Bugshouji.next = CreateFrame("Button",nil,Bugshouji, "UIPanelButtonTemplate");
Bugshouji.next:SetSize(90,22);
Bugshouji.next:SetPoint("BOTTOM",Bugshouji,"BOTTOM",140,8);
Bugshouji.next:SetText("下一条");
Bugshouji.next:Disable()
------------
function Bugshouji:qingkongERR()
	Bugshouji.prev:Disable()
	Bugshouji.next:Disable()
	Bugshouji.Time:SetText("");
	Bugshouji.biaoti:SetText("没有错误发生");
	Bugshouji.NR.textArea:SetText("")
end
----------------------
local function xianshixinxi(id)
	if Bugshouji_UI:IsShown() then
		Bugshouji:qingkongERR()
		local shujuyuan = {}
		if BugshoujiTAB_1.Show then
			shujuyuan.ly=bencierrinfo
			shujuyuan.num=#shujuyuan.ly
		elseif BugshoujiTAB_2.Show then
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
		Bugshouji.Time:SetText(time);
		Bugshouji.biaoti:SetText(id.."/"..shujuyuan.num);
		if cuowushu>1 then
			Bugshouji.NR.textArea:SetText(cuowushu.."× "..msg.."\n"..stack.."\n"..logrizhi)
		else
			Bugshouji.NR.textArea:SetText(msg.."\n"..stack.."\n"..logrizhi)
		end
		Bugshouji.prev.id=id
		Bugshouji.next.id=id
		if shujuyuan.num>1 then
			if id==1 then
				Bugshouji.prev:Disable()
				Bugshouji.next:Enable()
			elseif shujuyuan.num==id then
				Bugshouji.next:Disable()
				Bugshouji.prev:Enable()
			else
				Bugshouji.prev:Enable()
				Bugshouji.next:Enable()
			end
		else	
			Bugshouji.prev:Disable()
			Bugshouji.next:Disable()
		end
	end
end
local function kaishiShow()
	if BugshoujiTAB_1.Show then
		local tablenum = #bencierrinfo
		xianshixinxi(tablenum)
	elseif BugshoujiTAB_2.Show then
		local tablenum = #PIG["Error"]["ErrorInfo"]
		xianshixinxi(tablenum)
	end
end
-----
local TabWidth,TabHeight = 110,26;
local TabName = {"本次错误","之前错误"};
for id=1,#TabName do
	local Tablist = CreateFrame("Button","BugshoujiTAB_"..id,Bugshouji, "TruncatedButtonTemplate",id);
	Tablist:SetSize(TabWidth,TabHeight);
	if id==1 then
		Tablist:SetPoint("TOPLEFT", Bugshouji, "BOTTOMLEFT", 30,5);
	else
		Tablist:SetPoint("LEFT", _G["BugshoujiTAB_"..(id-1)], "RIGHT", 20,0);
	end
	Tablist.Tex = Tablist:CreateTexture(nil, "BORDER");
	Tablist.Tex:SetTexture("interface/paperdollinfoframe/ui-character-inactivetab.blp");
	Tablist.Tex:SetPoint("TOP", Tablist, "TOP", 0,0);
	Tablist.title = Tablist:CreateFontString();
	Tablist.title:SetPoint("CENTER", Tablist, "CENTER", 0,0);
	Tablist.title:SetFontObject(GameFontNormalSmall);
	Tablist.title:SetText(TabName[id]);
	Tablist.highlight = Tablist:CreateTexture(nil, "BORDER");
	Tablist.highlight:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight.blp");
	Tablist.highlight:SetBlendMode("ADD")
	Tablist.highlight:SetPoint("CENTER", Tablist.title, "CENTER", 0,0);
	Tablist.highlight:SetSize(TabWidth-12,TabHeight+4);
	Tablist.highlight:Hide();
	Tablist:SetScript("OnEnter", function (self)
		if self.Show==false then
			self.title:SetTextColor(1, 1, 1, 1);
			self.highlight:Show();
		end
	end);
	Tablist:SetScript("OnLeave", function (self)
		if self.Show==false then
			self.title:SetTextColor(1, 215/255, 0, 1);
		end
		self.highlight:Hide();
	end);
	Tablist:SetScript("OnMouseDown", function (self)
		if self.Show==false then
			self.title:SetPoint("CENTER", self, "CENTER", 1.5, -1.5);
		end
	end);
	Tablist:SetScript("OnMouseUp", function (self)
		if self.Show==false then
			self.title:SetPoint("CENTER", self, "CENTER", 0, 0);
		end
	end);
	-- ---------
	Tablist:SetScript("OnClick", function (self)
		for x=1,#TabName do
			local fagg=_G["BugshoujiTAB_"..x]
			fagg.Tex:SetTexture("interface/paperdollinfoframe/ui-character-inactivetab.blp");
			fagg.Tex:SetPoint("TOP", fagg, "TOP", 0,0);
			fagg.title:SetTextColor(1, 215/255, 0, 1);
			fagg.Show=false;
		end
		self.Tex:SetTexture("interface/paperdollinfoframe/ui-character-activetab.blp");
		self.Tex:SetPoint("TOP", self, "TOP", 0,1);
		self.title:SetTextColor(1, 1, 1, 1);
		self.highlight:Hide();
		self.Show=true;
		kaishiShow()
	end);
	---
	Tablist.Show=false;
	if id==1 then
		Tablist.Tex:SetTexture("interface/paperdollinfoframe/ui-character-activetab.blp");
		Tablist.Tex:SetPoint("TOP", Tablist, "TOP", 0,1);
		Tablist.title:SetTextColor(1, 1, 1, 1);
		Tablist.highlight:Hide();
		Tablist.Show=true;
	end
end
-------
Bugshouji.prev:SetScript("OnClick", function(self, button)
	local newid = self.id-1
	xianshixinxi(newid)
end)
Bugshouji.next:SetScript("OnClick", function(self, button)
	local newid = self.id+1
	xianshixinxi(newid)
end)
----------------
Bugshouji:SetScript("OnShow", function(self)
	self:SetFrameLevel(99)
	kaishiShow()
end)
----错误处理FUN
local function errottishi()
	if Bugshouji.yijiazai then
		if PIG["Error"]["ErrorTishi"] then
			if MinimapButton_PigUI then
				MinimapButton_PigUI.error:Show();
			end
		end
	else
		--print("|cff00FFFF"..addonName.."：|r|cffFF0000插件发生LUA错误，/per查看错误报告！|r");
	end
end
local function errotFUN(msg)
	--print(msg)
	local stack = debugstack(3) or "未知错误"
	local logrizhi = debuglocals(3) or "未知错误"
	local time = GetServerTime()
	local hejishu=#bencierrinfo
	Bugshouji.cuowushu = 1
	for i=hejishu,1,-1 do
		if bencierrinfo[i][1]==msg then
			Bugshouji.cuowushu =Bugshouji.cuowushu+bencierrinfo[i][5]
			table.remove(bencierrinfo,i);
			break
		end
	end
	table.insert(bencierrinfo, {msg,time,stack,logrizhi,Bugshouji.cuowushu});
	xianshixinxi(#bencierrinfo)
	errottishi()
end
local function yanchizhixing()
	if #bencierrinfo>0 then
		errottishi()
	end
end
UIParent:UnregisterEvent("LUA_WARNING")
Pig_seterrorhandler(errotFUN);
--function seterrorhandler() end
--========================================================
Bugshouji:RegisterEvent("PLAYER_LOGOUT");
Bugshouji:RegisterEvent("ADDON_LOADED")
Bugshouji:SetScript("OnEvent", function(self,event,arg1)
	if event=="ADDON_LOADED" then
		if arg1 == addonName then
			PIG["Error"]=PIG["Error"] or addonTable.Default["Error"]
			self.yijiazai=true
			C_Timer.After(2,yanchizhixing)
			Bugshouji:UnregisterEvent("ADDON_LOADED")
			if #PIG["Error"]["ErrorInfo"]>0 then
				for i=#PIG["Error"]["ErrorInfo"],1,-1 do
					if (GetServerTime()-PIG["Error"]["ErrorInfo"][i][2])>86400 then
						table.remove(PIG["Error"]["ErrorInfo"],i)
					end
				end
			end
		end
	else
		local hejishu=#bencierrinfo
		for i=1,hejishu do
			table.insert(PIG["Error"]["ErrorInfo"], bencierrinfo[i]);
		end
	end
end)
--==================================
SLASH_PER1 = "/per"
SLASH_PER2 = "/Per"
SLASH_PER3 = "/PER"
SlashCmdList["PER"] = function()
	Bugshouji_UI:Show();
end