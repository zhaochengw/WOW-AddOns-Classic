-- Addon
local modName = ...;
local iu = CreateFrame("Frame",modName,UIParent,BackdropTemplateMixin and "BackdropTemplate");	-- 9.0.1: Using BackdropTemplate

-- Global Chat Message Function
function AzMsg(msg) DEFAULT_CHAT_FRAME:AddMessage(tostring(msg):gsub("|1","|cffffff80"):gsub("|2","|cffffffff"),0.5,0.75,1.0); end

-- Constants
local ITEM_HEIGHT;
local NUM_ITEMS = 20;

local COLOR_ITEM_DEFAULT = { 1, 1, 1 };
local COLOR_HEADER_NORMAL = { 1, 1, 0 };
local COLOR_HEADER_SORTED = { 0, 1, 0 };

local SELECT_POLLING_METHOD = "Select Polling Method...";

-- Variables
local updateInterval = 1;
local pollData;

-- Polling Type Data
local PollTypeData = {};
iu.PollTypeData = PollTypeData;

--------------------------------------------------------------------------------------------------------
--                                                Code                                                --
--------------------------------------------------------------------------------------------------------

-- Update Scroll List
local function EntryList_Update(self)
	FauxScrollFrame_Update(self,#pollData.data,#iu.entries,ITEM_HEIGHT);
	local index = self.offset;
	local columns = pollData;
	for i = 1, NUM_ITEMS do
		index = (index + 1);
		local btn = iu.entries[i];
		local entry = pollData.data[index];
		if (entry) then
			for index, column in ipairs(columns) do
				local field = btn.fields[index];
				local value = entry[column.label];
				if (not value) or (value == 0) then
					field:SetText("");
				else
					field:SetFormattedText(column.fmt or "%s",value);
				end
			end
			if (MouseIsOver(btn)) then
				btn:GetScript("OnEnter")(btn);
			end
			btn:Show();
		else
			btn:Hide();
		end
	end
end

-- SortFunc
local function SortFunc(a,b)
	local sortMethod = pollData.sortMethod;
	if (a[sortMethod] == b[sortMethod]) then
		return a.name > b.name;
	elseif (type(a[sortMethod]) == "number") then
		return (a[sortMethod] or 0) > (b[sortMethod] or 0);	-- Az: this causes negative values to go below no value entries!
	else
		return (a[sortMethod] or "") < (b[sortMethod] or "");
	end
end

-- Set Polling Type
function iu:SetPollingIndex(index)
	pollData = PollTypeData[index];

	-- Initialize Poll
	if (pollData.OnInitialize) then
		pollData.data = {};
		pollData:OnInitialize();
		pollData.OnInitialize = nil;
		if (pollData.OnReset) then
			pollData:OnReset();
		end
	end
	iu.columns:UpdateHeader(pollData);

	-- Update Columns
	for i = 1, NUM_ITEMS do
		local btn = iu.entries[i];
		local left = 0;
		for index, fs in ipairs(btn.fields) do
			local column = pollData[index];
			if (column) then
				fs:ClearAllPoints();
				fs:SetPoint("LEFT",left,0);
				local adjustedWidth = (not column.width or column.width <= 0) and (iu.columns.width - left) or column.width;
				fs:SetWidth(adjustedWidth);
				fs:SetTextColor(unpack(column.color or COLOR_ITEM_DEFAULT));
				fs:SetJustifyH(column.align or "RIGHT");
				fs:Show();
				left = (left + (column.width or 0));
			else
				fs:Hide();
			end
		end
	end

	-- Misc
	iu.nextUpdate = 0;
end

-- Create Poll Type
function iu:CreatePollType(title)
	local poll = { title = title };
	PollTypeData[#PollTypeData + 1] = poll;
	return poll;
end

--------------------------------------------------------------------------------------------------------
--                                       Frame Scripts & Events                                       --
--------------------------------------------------------------------------------------------------------

-- OnUpdate
local function OnUpdate(self,elapsed)
	self.nextUpdate = (self.nextUpdate - elapsed);
	if (self.nextUpdate <= 0) then
		if (pollData) then
			if (pollData.OnPoll) then
				pollData:OnPoll();
			end
			sort(pollData.data,SortFunc);
			self.header:SetFormattedText("%s (|cffffff00%d|r)",pollData.title,#pollData.data);
			EntryList_Update(self.scroll);
		end
		self.nextUpdate = updateInterval;
	end
end

--------------------------------------------------------------------------------------------------------
--                                           Widget Creation                                          --
--------------------------------------------------------------------------------------------------------

iu:SetSize(560,420);
iu:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 16, edgeSize = 16, insets = { left = 3, right = 3, top = 3, bottom = 3 } });
iu:SetBackdropColor(0.1,0.22,0.35,1);
iu:SetBackdropBorderColor(0.1,0.1,0.1,1);
iu:EnableMouse(true);
iu:SetMovable(true);
iu:SetFrameStrata("HIGH");
iu:SetToplevel(true);
iu:SetPoint("CENTER");
iu:Hide();

iu:SetScript("OnUpdate",OnUpdate);
iu:SetScript("OnMouseDown",iu.StartMoving);
iu:SetScript("OnMouseUp",iu.StopMovingOrSizing);

iu.outline = CreateFrame("Frame",nil,iu,BackdropTemplateMixin and "BackdropTemplate");	-- 9.0.1: Using BackdropTemplate
iu.outline:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 } });
iu.outline:SetBackdropColor(0.1,0.1,0.2,1);
iu.outline:SetBackdropBorderColor(0.8,0.8,0.9,0.4);
iu.outline:SetPoint("TOPLEFT",12,-38);
iu.outline:SetPoint("BOTTOMRIGHT",-12,42);

iu.close = CreateFrame("Button",nil,iu,"UIPanelCloseButton");
iu.close:SetPoint("TOPRIGHT",-5,-5);
iu.close:SetScript("OnClick",function() iu:Hide(); end);

iu.header = iu:CreateFontString(nil,"ARTWORK","GameFontHighlight");
iu.header:SetFont(iu.header:GetFont(),24,"THICKOUTLINE");
iu.header:SetPoint("TOPLEFT",12,-12);
iu.header:SetText(SELECT_POLLING_METHOD);

-- Reset Button
iu.btnReset = CreateFrame("Button",nil,iu,"UIPanelButtonTemplate");
iu.btnReset:SetSize(75,24);
iu.btnReset:SetPoint("BOTTOMRIGHT",-12,12);
iu.btnReset:SetScript("OnClick",function(self) if (pollData.OnReset) then pollData:OnReset(); iu.nextUpdate = 0; end end);
iu.btnReset:SetText("Reset");

-- CheckButton: Script Profiling
local chk = CreateFrame("CheckButton",nil,iu);
chk:SetSize(24,24);
chk:SetPoint("BOTTOMRIGHT",-210,12);
chk:SetChecked(GetCVar("scriptProfile") == "1");
chk:SetScript("OnClick",function(self) SetCVar("scriptProfile",self:GetChecked() and 1 or 0); ReloadUI(); end);
chk:SetScript("OnEnter",function(self) GameTooltip:SetOwner(self,"ANCHOR_TOPLEFT"); GameTooltip:AddLine(self.text:GetText(),1,1,1); GameTooltip:AddLine("This option must be enabled for CPU usage to be tracked\nWarning: Toggling this option will reload the user interface"); GameTooltip:Show() end);
chk:SetScript("OnLeave",function(self) GameTooltip:Hide() end); -- az: set to hidegtt!

chk:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
chk:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down");
chk:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight");
chk:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled");
chk:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");

chk.text = chk:CreateFontString("ARTWORK",nil,"GameFontNormalSmall");
chk.text:SetPoint("LEFT",chk,"RIGHT",0,1);
chk.text:SetText("Enable Script Profiling");
chk:SetHitRectInsets(0,chk.text:GetWidth() * -1,0,0);

iu.profiling = chk;

--------------------------------------------------------------------------------------------------------
--                                          Columns Headers                                           --
--------------------------------------------------------------------------------------------------------

iu.columns = CreateFrame("Frame",nil,iu.outline,BackdropTemplateMixin and "BackdropTemplate");	-- 9.0.1: Using BackdropTemplate
iu.columns:SetPoint("TOPLEFT",8,-8);
iu.columns:SetPoint("TOPRIGHT",-8,0);
iu.columns:SetHeight(12);
iu.columns:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", insets = { left = -4, right = -4, top = -4, bottom = -4 } });
iu.columns:SetBackdropColor(0.1,0.1,0.1,1);

iu.columns.items = {};
iu.columns.width = (iu.columns:GetWidth() - 20);

local function HeaderButton_OnClick(self,button,down)
	pollData.sortMethod = pollData[self.index].label;
	iu.nextUpdate = 0;
	iu.columns:UpdateHeader(pollData);
end

function iu.columns:CreateColumnButton()
	local b = CreateFrame("Button",nil,self);

	b:SetHighlightTexture("Interface\\TargetingFrame\\UI-StatusBar");
	b:GetHighlightTexture():SetVertexColor(0.8,1,0.8,0.2);

	b:SetScript("OnClick",HeaderButton_OnClick);
	b:SetHighlightFontObject(GameFontNormal);

	b.fs = b:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	b.fs:SetAllPoints();
	b.fs:SetWordWrap(false);

	b.index = #self.items + 1;

	self.items[b.index] = b;
	return b;
end

function iu.columns:UpdateHeader(pollData)
	local left = 0;
	for index, field in ipairs(pollData) do
		local col = self.items[index] or self:CreateColumnButton();
		col:Show();

		col:ClearAllPoints();
		col:SetPoint("TOPLEFT",left,0);
		col:SetPoint("BOTTOMLEFT",left,0);

		local adjustedWidth = (not field.width or field.width <= 0) and (self.width - left) or field.width;
		col:SetWidth(adjustedWidth);

		col.fs:SetText(field.label);
		col.fs:SetJustifyH(field.align or "RIGHT");

		col.fs:SetTextColor(unpack(field.label == pollData.sortMethod and COLOR_HEADER_SORTED or COLOR_HEADER_NORMAL))

		left = (left + (field.width or 0));
	end

	-- hide the rest
	for i = #pollData + 1, #self.items do
		self.items[i]:Hide();
	end
end

--------------------------------------------------------------------------------------------------------
--                                             List Items                                             --
--------------------------------------------------------------------------------------------------------

-- Entry OnEnter
local function Entry_OnEnter(self)
	local index = (iu.scroll.offset + self.index);
	GameTooltip_SetDefaultAnchor(GameTooltip,self);
	GameTooltip:AddLine(pollData.data[index].name,1,1,1);
	for name, value in next, pollData.data[index] do
		if (name ~= "name") then
			GameTooltip:AddDoubleLine(name,tostring(value),nil,nil,nil,1,1,1);
		end
	end
	GameTooltip:Show();
end

-- Hide GTT
local function HideGTT()
	GameTooltip:Hide();
end

-- Create Entries
ITEM_HEIGHT = (iu.outline:GetHeight() - 16 - 22) / NUM_ITEMS - 1;
iu.entries = {};
for i = 1, NUM_ITEMS do
	local btn = CreateFrame("Button",nil,iu.outline);
	btn:SetHeight(ITEM_HEIGHT);
	btn:RegisterForClicks("AnyUp");
	btn:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	btn:SetScript("OnEnter",Entry_OnEnter);
	btn:SetScript("OnLeave",HideGTT);
	btn:Hide();
	btn.index = i;

	if (i == 1) then
		btn:SetPoint("TOPLEFT",8,-28);
		btn:SetPoint("TOPRIGHT",-23,-28);
	else
		btn:SetPoint("TOPLEFT",iu.entries[i - 1],"BOTTOMLEFT",0,-1);
		btn:SetPoint("TOPRIGHT",iu.entries[i - 1],"BOTTOMRIGHT",0,-1);
	end

	btn.fields = {};
	for n = 1, 6 do
		btn.fields[n] = btn:CreateFontString(nil,"ARTWORK","GameFontNormal");
	end

	iu.entries[i] = btn;
end

iu.scroll = CreateFrame("ScrollFrame",modName.."Scroll",iu,"FauxScrollFrameTemplate");
iu.scroll:SetPoint("TOPLEFT",iu.entries[1]);
iu.scroll:SetPoint("BOTTOMRIGHT",iu.entries[#iu.entries],-6,-1);
iu.scroll:SetScript("OnVerticalScroll",function(self,offset) FauxScrollFrame_OnVerticalScroll(self,offset,ITEM_HEIGHT,EntryList_Update) end);

--------------------------------------------------------------------------------------------------------
--                                      DropDown: Polling Method                                      --
--------------------------------------------------------------------------------------------------------

local function DropDownPoll_Init(self,list)
	for index, poll in ipairs(PollTypeData) do
		local tbl = list[index];
		tbl.text = (poll.OnInitialize and "" or "|cff80ff80")..poll.title;
		tbl.value = index;
		tbl.checked = (poll == pollData);
	end
end

local function DropDownPoll_SelectValue(self,entry,index)
	iu:SetPollingIndex(index);
	self:SetText("|cff80ff80"..pollData.title);
end

iu.dropDownPoll = AzDropDown:CreateDropDown(iu,-180,DropDownPoll_Init,DropDownPoll_SelectValue);
iu.dropDownPoll:SetPoint("BOTTOMLEFT",12,12);
iu.dropDownPoll:SetText(SELECT_POLLING_METHOD);

--------------------------------------------------------------------------------------------------------
--                                           Slash Handling                                           --
--------------------------------------------------------------------------------------------------------

iu.slashCommands = {
	_void = function(self,cmd)
		self.nextUpdate = 0;
		self:SetShown(not self:IsShown());
	end,
	" |2interval <seconds>|r = Change the polling interval",
	interval = function(self,cmd)
		local interval = tonumber(cmd);
		if (interval) then
			updateInterval = interval;
			AzMsg(format("|2%s|r Interval changed to |1%g|r",modName,interval));
			self.nextUpdate = 0;
		else
			AzMsg(format("|2%s|r Invalid Input - Use: /iu interval <seconds>",modName));
		end
	end,
};

function iu:HandleSlashCommand(cmd)
	-- Extract Paramters
	local param1, param2 = cmd:match("^([^%s]+)%s*(.*)$");
	param1 = (param1 and param1:lower() or cmd:lower());
	param1 = (param1 == "" and "_void" or param1);
	-- Check Param Function
	if (self.slashCommands[param1]) then
		self.slashCommands[param1](self,param2);
	-- Invalid or No Command
	else
		UpdateAddOnMemoryUsage();
		AzMsg(format("----- |2%s|r |1%s|r ----- |1%.2f |2kb|r -----",modName,GetAddOnMetadata(modName,"Version"),GetAddOnMemoryUsage(modName)));
		AzMsg("The following |2parameters|r are valid for this addon:");
		for index, help in ipairs(self.slashCommands) do
			AzMsg(help);
		end
	end
end

_G["SLASH_"..modName.."1"] = "/iu";
_G["SLASH_"..modName.."2"] = "/interfaceusage";
SlashCmdList[modName] = function(cmd) iu:HandleSlashCommand(cmd) end