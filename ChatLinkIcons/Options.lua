--[[	ChatLinkIcons Options
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local Name,AddOn=...;
local Title=select(2,GetAddOnInfo(Name)):gsub("%s*v?[%d%.]+$","");
local Version=GetAddOnMetadata(Name,"Version");
local Author=GetAddOnMetadata(Name,"Author");

----------------------------------
--[[	Options Variable Setup	]]
----------------------------------
local Defaults={
	Links={
--		Case-sensitive, needs to be the same string that appears as "|H<LinkType>:"
		achievement=true;
		item=true;
		player=true;
		spell=true;
	};
	Icons={
		Race=true;
		Class=true;
	};

	PawnIntegration=true;
};
AddOn.Options=Defaults;--	Set temperarily until we have our SavedVar loaded

----------------------------------
--[[	Table Copy Function	]]
----------------------------------
local function CopySettings(source,target,overwrite)
--	Recursively copies source into target, preserving shared keys unless overwrite is set

	if type(source)~="table" then return source; end
	if type(target)~="table" then target={}; end

	local stack={source};
	local registry={[source]=target};

	while #stack>0 do
		local source=table.remove(stack,1);
		local target=registry[source];

		for k,v in pairs(source) do
			local targetval=target[k];
			if type(v)=="table" then--	Tables are merged, non-tables are automatically overwritten
				local newval=registry[v];
				if not newval then
					newval=(type(targetval)=="table" and targetval or {});
					registry[v]=newval;
					table.insert(stack,v);
				end

				target[k]=newval;
			elseif overwrite or targetval==nil then target[k]=v; end--	Preserve existing values unless overwrite flag set
		end
	end

	return target;
end

--------------------------
--[[	Options Panel	]]
--------------------------
local Options;--	Placeholder for loaded SavedVar

local Panel=CreateFrame("Frame"); do
	AddOn.OptionsPanel=Panel;
	Panel:Hide();

	do	local title=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalLarge");
		title:SetPoint("TOP",0,-12);
		title:SetText(Title);

		local author=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalSmall");
		author:SetPoint("TOP",title,"BOTTOM",0,0);
		author:SetTextColor(1,0.5,0.25);
		author:SetText("by "..Author);

		local ver=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalSmall");
		ver:SetPoint("TOPLEFT",title,"TOPRIGHT",4,0);
		ver:SetTextColor(0.5,0.5,0.5);
		ver:SetText("v"..Version);
	end
end

Panel:RegisterEvent("ADDON_LOADED");
Panel:SetScript("OnEvent",function(self,event,...)
	if event=="ADDON_LOADED" and (...)==Name then
		Options=CopySettings(Defaults,ChatLinkIcons_Options or {});--	Load SavedVar and copy defaults
		if not ChatLinkIcons_Options then ChatLinkIcons_Options=Options; end--	Link new table to SavedVar if it doesn't exist
		AddOn.Options=Options;--	Update pointer for core module

		self:UnregisterEvent(event);
	end
end);

----------------------------------
--[[	Options Controls	]]
----------------------------------
local Changes=CopySettings(Defaults,{},true);--	Init with copy of defaults to build structure

local Buttons={};
local CreateOptionButton; do--	function CreateOptionButton(tbl,key,txt,x,y)
	local function OptionButton_OnClick(self) self.Table[self.Key]=self:GetChecked(); end
	local function OptionButton_Refresh(self) self:SetChecked(self:IsEnabled() and self.Table[self.Key]); end
	function CreateOptionButton(tbl,key,txt,x,y)
		local button=CreateFrame("CheckButton",nil,Panel,"UICheckButtonTemplate");
		button:SetPoint("TOPLEFT",x,y);
		(button.Text or button.text):SetText(txt or tostring(key):gsub("^(.)",string.upper));--		(.text is depreciated in favor of .Text, but Vanilla still uses it)
		button:SetScript("OnClick",OptionButton_OnClick);

		button.Table=tbl;
		button.Key=key;
		button.Refresh=OptionButton_Refresh;

		table.insert(Buttons,button);
		return button;
	end
end

do--	LinkButtons
	local keys=GetKeysArray(Defaults.Links); table.sort(keys);
	for i,key in ipairs(keys) do CreateOptionButton(Changes.Links,key,nil,24,-i*24-24); end
end

CreateOptionButton(Changes.Icons,"Race","Race/Gender",128,-96);
CreateOptionButton(Changes.Icons,"Class",nil,256,-96);

local PawnIsLoaded=IsAddOnLoaded("Pawn");
local PawnButton=CreateOptionButton(Changes,"PawnIntegration","Pawn Integration |cff"..(PawnIsLoaded and "00ff00" or "ff0000").."(Requires Pawn)|r",24,-200);
if not PawnIsLoaded then
	PawnButton:Disable();
	(PawnButton.Text or PawnButton.text):SetTextColor(0.5,0.5,0.5);--	(.text is depreciated in favor of .Text, but Vanilla still uses it)
end

------------------------------------------
--[[	Panel Registration & Callbacks	]]
------------------------------------------
local function Options_Save() CopySettings(Changes,Options,true); end
local function Options_Cancel() CopySettings(Options,Changes,true); end

local function Options_Default()
	CopySettings(Defaults,Options,true);
	CopySettings(Defaults,Changes,true);
end

local function Options_Refresh()
	CopySettings(Options,Changes,true);
	for i,j in ipairs(Buttons) do j:Refresh(); end
end

--	Panel Registration
if select(4,GetBuildInfo())>=100000 then
--	Panel.name=Title;
	Panel.OnCommit=Options_Save;
	Panel.OnDefault=Options_Default;
	Panel.OnRefresh=Options_Refresh;

	local category=Settings.RegisterCanvasLayoutCategory(Panel,Title);
	category.ID=Title;
	Settings.RegisterAddOnCategory(category);
else
	Panel.name=Title;
	Panel.okay=Options_Save;
	Panel.cancel=Options_Cancel;
	Panel.default=Options_Default;
	Panel.refresh=Options_Refresh;
	InterfaceOptions_AddCategory(Panel);
end
