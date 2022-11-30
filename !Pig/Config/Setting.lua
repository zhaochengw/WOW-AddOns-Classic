local _, addonTable = ...;
-------
local fuFrame=List_R_F_1_13
--载入默认配置
local function Config_Default()
	PIG = PIG or addonTable.Default;
	for k,v in pairs(addonTable.Default) do
		if PIG[k]==nil then
			PIG[k] = addonTable.Default[k]
		end
		if type(v)=="table" then
			for kk,vv in pairs(v) do
				if PIG[k][kk]==nil then
					PIG[k][kk] = addonTable.Default[k][kk]
				end
				if type(kk)~="number" and type(vv)=="table" then
					for kkk,vvv in pairs(vv) do
						if PIG[k][kk][kkk]==nil then
							PIG[k][kk][kkk] = addonTable.Default[k][kk][kkk]
						end
					end
				end
			end
		end
	end
	PIG_Per = PIG_Per or addonTable.Default_Per;
	for k,v in pairs(addonTable.Default_Per) do
		if PIG_Per[k]==nil then
			PIG_Per[k] = addonTable.Default_Per[k]
		end
		if type(v)=="table" then
			for kk,vv in pairs(v) do
				if PIG_Per[k][kk]==nil then
					PIG_Per[k][kk] = addonTable.Default_Per[k][kk]
				end
				if type(kk)~="number" and type(vv)=="table" then
					for kkk,vvv in pairs(vv) do
						if PIG_Per[k][kk][kkk]==nil then
							PIG_Per[k][kk][kkk] =addonTable.Default_Per[k][kk][kkk]
						end
					end
				end
			end
		end
	end
end
addonTable.Config_Default=Config_Default
--------------
local Config_Name ={"常用配置","调试配置","PIG",};
local Config_ID ={"AllNO","Default","PIG"};
local Config_SM ={
	"开启常用功能，不需要功能请自行关闭。",
	"此配置默认关闭所有功能，供调试插件使用。",
	"作者个人使用的配置",
};
---------
for id=1,#Config_ID do
	local Default_Button = CreateFrame("Button", "Default_Button_"..id, fuFrame, "UIPanelButtonTemplate");  
	Default_Button:SetSize(120,30);
	if id==1 then
		Default_Button:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
	else
		Default_Button:SetPoint("TOPLEFT",_G["Default_Button_"..(id-1)],"BOTTOMLEFT",0,-40);
	end
	Default_Button:SetText(Config_Name[id]);
	Default_Button.title = Default_Button:CreateFontString();
	Default_Button.title:SetPoint("LEFT", Default_Button, "RIGHT", 6, 0);
	Default_Button.title:SetFontObject(GameFontNormal);
	Default_Button.title:SetTextColor(0, 1, 0, 1);
	Default_Button.title:SetJustifyH("LEFT");
	Default_Button.title:SetText(Config_SM[id]);
	Default_Button.line = Default_Button:CreateLine()
	Default_Button.line:SetColorTexture(1,1,1,0.2)
	Default_Button.line:SetThickness(1);
	Default_Button.line:SetStartPoint("BOTTOMLEFT",-16,-20)
	Default_Button.line:SetEndPoint("BOTTOMRIGHT",444,-20)
end

for id=1,#Config_ID do
	_G["Default_Button_"..id]:SetScript("OnClick", function ()
		StaticPopup_Show ("PEIZHI_"..Config_ID[id]);
	end);
	StaticPopupDialogs["PEIZHI_"..Config_ID[id]] = {
		text = "此操作将\124cff00ff00载入\124r\n"..Config_Name[id].."的设置。\n已保存的聊天记录，副本助手/带本助手的数据也将被\124cffff0000清空\124r。\n确定载入?",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG = addonTable[Config_ID[id]];
			PIG_Per = addonTable[Config_ID[id].."_Per"];
			Pig_Options_RLtishi_UI:Show()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
end
----------------------------------------------------------------
---提示
fuFrame.tishi = fuFrame:CreateFontString();
fuFrame.tishi:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 20, -300);
fuFrame.tishi:SetFont(GameFontNormal:GetFont(), 20,"OUTLINE")
fuFrame.tishi:SetTextColor(1, 1, 0, 1);
fuFrame.tishi:SetText("提示：");
fuFrame.tishi1 = fuFrame:CreateFontString();
fuFrame.tishi1:SetPoint("TOPLEFT", fuFrame.tishi, "TOPRIGHT", 10, -2);
fuFrame.tishi1:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
fuFrame.tishi1:SetTextColor(0.6, 1, 0, 1);
fuFrame.tishi1:SetJustifyH("LEFT");
fuFrame.tishi1:SetText(
	"1、如遇到问题，请在对应功能内单独重置功能配置。\n"..
	"2、如未解决请先在此恢复初始配置再查看是否还存在问题。\n"..
	"\124cffFFff003、如问题仍未解决请加关于内的反馈群。\124r");
-----------------
--配置导出/导入页面
local ConfigWWW,ConfigHHH = 800, 600
local Config_daochu= CreateFrame("Frame", "Config_daochu_UI", UIParent,"BackdropTemplate")
Config_daochu:SetBackdrop({
bgFile = "interface/characterframe/ui-party-background.blp",
edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
edgeSize = 16,insets = { left = 2, right = 2, top = 2, bottom = 2 }
})
Config_daochu:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
Config_daochu:SetSize(ConfigWWW,ConfigHHH)
Config_daochu:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
Config_daochu:SetFrameLevel(999);
Config_daochu:SetClampedToScreen(true)
Config_daochu:EnableMouse(true)
Config_daochu:SetMovable(true)
Config_daochu:Hide();
Config_daochu:EnableKeyboard(true);
Config_daochu:SetScript("OnKeyDown",function(self,key)
	if GetBindingFromClick(key)=="TOGGLEGAMEMENU" then
		self:Hide();
	end
end)

Config_daochu.biaoti = CreateFrame("Frame", nil, Config_daochu,"BackdropTemplate")
Config_daochu.biaoti:SetBackdrop({
    bgFile = "interface/characterframe/ui-party-background.blp",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	edgeSize = 16,insets = { left = 2, right = 2, top = 2, bottom = 2 }
})
Config_daochu.biaoti:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
Config_daochu.biaoti:SetSize(120, 30)
Config_daochu.biaoti:SetPoint("BOTTOM", Config_daochu, "TOP", 0, -6)
Config_daochu.biaoti:RegisterForDrag("LeftButton")
Config_daochu.biaoti:EnableMouse(true)
Config_daochu.biaoti:SetScript("OnDragStart",function()
	Config_daochu:StartMoving()
end)
Config_daochu.biaoti:SetScript("OnDragStop",function()
	Config_daochu:StopMovingOrSizing()
end)
Config_daochu.biaoti.t = Config_daochu.biaoti:CreateFontString();
Config_daochu.biaoti.t:SetPoint("TOP", Config_daochu.biaoti, "TOP", 0, -8);
Config_daochu.biaoti.t:SetFontObject(GameFontNormal);
--
Config_daochu.CloseF = CreateFrame("Frame", nil, Config_daochu,"BackdropTemplate")
Config_daochu.CloseF:SetBackdrop({
    bgFile = "interface/characterframe/ui-party-background.blp",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	edgeSize = 16,insets = { left = 2, right = 2, top = 2, bottom = 2 }
})
Config_daochu.CloseF:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8);
Config_daochu.CloseF:SetSize(28,28);
Config_daochu.CloseF:SetPoint("BOTTOMRIGHT", Config_daochu, "TOPRIGHT", -6, -7);
Config_daochu.CloseF.Close = CreateFrame("Button",nil, Config_daochu.CloseF);
Config_daochu.CloseF.Close:SetSize(26,26);
Config_daochu.CloseF.Close:SetPoint("CENTER", 0,0);
Config_daochu.CloseF.Close.Tex = Config_daochu.CloseF.Close:CreateTexture();
Config_daochu.CloseF.Close.Tex:SetTexture("interface/common/voicechat-muted.blp");
Config_daochu.CloseF.Close.Tex:SetPoint("CENTER");
Config_daochu.CloseF.Close.Tex:SetSize(14,14);
Config_daochu.CloseF.Close:SetScript("OnMouseDown", function (self)
	self.Tex:SetPoint("CENTER",1.5,-1.5);
end);
Config_daochu.CloseF.Close:SetScript("OnMouseUp", function (self)
	self.Tex:SetPoint("CENTER");
end);
Config_daochu.CloseF.Close:SetScript("OnClick", function (self)
	Config_daochu:Hide()
end);
--
Config_daochu.scroll = CreateFrame("ScrollFrame", nil, Config_daochu, "UIPanelScrollFrameTemplate")
Config_daochu.scroll:SetPoint("TOPLEFT", Config_daochu, "TOPLEFT", 12, -36)
Config_daochu.scroll:SetPoint("BOTTOMRIGHT", Config_daochu, "BOTTOMRIGHT", -30, 12)

Config_daochu.textArea = CreateFrame("EditBox", nil, Config_daochu.scroll)
Config_daochu.textArea:SetTextColor(.8, .8, .8, 1)
Config_daochu.textArea:SetAutoFocus(false)
Config_daochu.textArea:SetMultiLine(true)
Config_daochu.textArea:SetFontObject(GameFontHighlightSmall)
Config_daochu.textArea:SetMaxLetters(99999)
Config_daochu.textArea:EnableMouse(true)
Config_daochu.textArea:SetScript("OnEscapePressed", Config_daochu.textArea.ClearFocus)
Config_daochu.textArea:SetWidth(ConfigWWW-40)
Config_daochu.textArea:SetAutoFocus(true);

Config_daochu.scroll:SetScrollChild(Config_daochu.textArea)
---

local julidi,daoruTXT,daochuTXT = -6,"请在下方输入要导入的目录字符串，并点击导入按钮","请复制下方字符串，粘贴到需要导入位置"
Config_daochu.drctishi = Config_daochu:CreateFontString();
Config_daochu.drctishi:SetPoint("TOPLEFT",Config_daochu,"TOPLEFT",6,julidi-2);
Config_daochu.drctishi:SetFontObject(GameFontNormal);
Config_daochu.drctishi:SetTextColor(0, 1, 0, 1);
Config_daochu.drctishi:SetText(daoruTXT);

Config_daochu.daoru = CreateFrame("Button",nil,Config_daochu, "UIPanelButtonTemplate");
Config_daochu.daoru:SetSize(130,20);
Config_daochu.daoru:SetPoint("TOPRIGHT",Config_daochu,"TOPRIGHT",-6,julidi);
Config_daochu.daoru:SetText("导入(并重载UI)");
Config_daochu.daoru:Hide();

Config_daochu.bottomlin = Config_daochu:CreateLine()
Config_daochu.bottomlin:SetColorTexture(0.4,0.4,0.4,0.4)
Config_daochu.bottomlin:SetThickness(2);
Config_daochu.bottomlin:SetStartPoint("TOPLEFT",4,-28)
Config_daochu.bottomlin:SetEndPoint("TOPRIGHT",-4,-28)
-------------
---以下部分来自ALA大神告诉的AEC3代码
local strbyte, strchar, gsub, gmatch, format = string.byte, string.char, string.gsub, string.gmatch, string.format
local assert, error, pcall = assert, error, pcall
local type, tostring, tonumber = type, tostring, tonumber
local pairs, select, frexp = pairs, select, math.frexp
local tconcat = table.concat
local function SerializeStringHelper(ch)
	local n = strbyte(ch)
	if n==30 then
		return "\126\122"
	elseif n<=32 then
		return "\126"..strchar(n+64)
	elseif n==94 then
		return "\126\125"
	elseif n==126 then
		return "\126\124"
	elseif n==127 then
		return "\126\123"
	else
		assert(false)
	end
end
--
local function SerializeValue(v, res, nres)
	local t=type(v)
	if t=="string" then
		v = gsub(v,"|", "P124")
		res[nres+1] = "^S"
		res[nres+2] = gsub(v,"[%c \94\126\127]", SerializeStringHelper)
		nres=nres+2
	elseif t=="number" then	
		local str = tostring(v)
		if tonumber(str)==v then
			res[nres+1] = "^N"
			res[nres+2] = str
			nres=nres+2
		elseif v == inf or v == -inf then
			res[nres+1] = "^N"
			res[nres+2] = v == inf and serInf or serNegInf
			nres=nres+2
		else
			local m,e = frexp(v)
			res[nres+1] = "^F"
			res[nres+2] = format("%.0f",m*2^53)	
			res[nres+4] = tostring(e-53)
			nres=nres+4
		end
	elseif t=="table" then
		nres=nres+1
		res[nres] = "^T"
		for k,v in pairs(v) do
			nres = SerializeValue(k, res, nres)
			nres = SerializeValue(v, res, nres)
		end
		nres=nres+1
		res[nres] = "^t"
	elseif t=="boolean" then
		nres=nres+1
		if v then
			res[nres] = "^B"
		else
			res[nres] = "^b"
		end
	elseif t=="nil" then
		nres=nres+1
		res[nres] = "^Z"

	else
		error(MAJOR..": 无法序列化类型的值 '"..t.."'")
	end
	return nres
end
---
local serializeTbl = { "^1" }
local tconcat = table.concat
local function Serialize(...)
	local nres = 1
	for i=1,select("#", ...) do
		local v = select(i, ...)
		nres = SerializeValue(v, serializeTbl, nres)
	end
	serializeTbl[nres+1] = "^^"	
	return tconcat(serializeTbl, "", 1, nres+1)
end
local function Config_daochu_UP(self,peizhiInfo)
	local fjiF = Config_daochu_UI
	fjiF:Show()
	fjiF.daoru:Hide();
	fjiF.biaoti.t:SetText(self:GetText().."配置字符");
	fjiF.drctishi:SetText(daochuTXT);
	local text = Serialize(peizhiInfo)
	fjiF.textArea:SetText(text)
	fjiF.textArea:HighlightText() 
end
addonTable.Config_daochu_UP=Config_daochu_UP
--导入
local function DeserializeStringHelper(escape)
	if escape<"~\122" then
		return strchar(strbyte(escape,2,2)-64)
	elseif escape=="~\122" then
		return "\030"
	elseif escape=="~\123" then
		return "\127"
	elseif escape=="~\124" then
		return "\126"
	elseif escape=="~\125" then
		return "\94"
	end
	error("DeserializeStringHelper got called for '"..escape.."'?!?")
end

local function DeserializeNumberHelper(number)
	if number == serNegInf or number == serNegInfMac then
		return -inf
	elseif number == serInf or number == serInfMac then
		return inf
	else
		return tonumber(number)
	end
end
local function DeserializeValue(iter,single,ctl,data)
	if not single then
		ctl,data = iter()
	end
	if not ctl then 
		error("Supplied data misses AceSerializer terminator ('^^')")
	end	
	if ctl=="^^" then
		return
	end
	local res
	if ctl=="^S" then
		res = gsub(data, "~.", DeserializeStringHelper)
	elseif ctl=="^N" then
		res = DeserializeNumberHelper(data)
		if not res then
			error("无效的序列化的数量: '"..tostring(data).."'")
		end
	elseif ctl=="^F" then
		local ctl2,e = iter()
		if ctl2~="^f" then
			error("预期无效的序列化浮点数 '^f', not '"..tostring(ctl2).."'")
		end
		local m=tonumber(data)
		e=tonumber(e)
		if not (m and e) then
			error("无效的序列化浮点数，期望的尾数和指数 '"..tostring(m).."' and '"..tostring(e).."'")
		end
		res = m*(2^e)
	elseif ctl=="^B" then
		res = true
	elseif ctl=="^b" then
		res = false
	elseif ctl=="^Z" then
		res = nil
	elseif ctl=="^T" then
		res = {}
		local k,v
		while true do
			ctl,data = iter()
			if ctl=="^t" then break end
			k = DeserializeValue(iter,true,ctl,data)
			if k==nil then 
				error("无效的AceSerializer表格式(没有表结束标记)")
			end
			ctl,data = iter()
			v = DeserializeValue(iter,true,ctl,data)
			if v==nil then
				error("无效的AceSerializer表格式(没有表结束标记)")
			end
			res[k]=v
		end
	else
		error("无效的AceSerializer控制代码 '"..ctl.."'")
	end
	if not single then
		return res,DeserializeValue(iter)
	else
		return res
	end
end
local function Deserialize(str)
	str = gsub(str,"P124", "|")
	str = gsub(str, "[%c ]", "")
	local iter = gmatch(str, "(^.)([^^]*)")	
	local ctl,data = iter()
	if not ctl or ctl~="^1" then
		return false, "未知数据"
	end
	return pcall(DeserializeValue, iter)
end
Config_daochu.daoru:SetScript("OnClick", function(self, button)
	local tttxt =Config_daochu.textArea:GetText()
	local OOKK,dataff =Deserialize(tttxt)
	if OOKK then
		local piger =self.juese
		local peizhiInfo =self.peizhiInfo
		local peizhiInfo1, peizhiInfo2,peizhiInfo3 = strsplit("~", peizhiInfo);
		if peizhiInfo3 then
			_G[piger][peizhiInfo1][peizhiInfo2][peizhiInfo3]=dataff
		elseif peizhiInfo2 then
			_G[piger][peizhiInfo1][peizhiInfo2]=dataff
		elseif peizhiInfo1 then
			_G[piger][peizhiInfo1]=dataff
		end
		ReloadUI()
	else
		message("导入失败，无法识别的字符串");
	end
end)
----
local function Config_daoru_UP(self,juese,peizhiInfo)
	local fjiF = Config_daochu_UI
	fjiF:Show()
	fjiF.daoru:Show();
	fjiF.biaoti.t:SetText(self:GetText().."配置字符");
	fjiF.drctishi:SetText(daoruTXT);
	fjiF.textArea:SetText("")
	Config_daochu.daoru.juese=juese
	Config_daochu.daoru.peizhiInfo=peizhiInfo
end
addonTable.Config_daoru_UP=Config_daoru_UP