--[[	ChatLinkIcons - Options
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local Name,AddOn=...;
local Title=select(2,GetAddOnInfo(Name)):gsub("%s*v?[%d%.]+$","");
AddOn.Options_OnOptionsUpdate=AddOn.Callbacks_New();

----------------------------------
--[[	Options Variable Setup	]]
----------------------------------
local Defaults={Options_SaveVersion=2};
AddOn.Options=Defaults;--	Give other modules direct access to defaults while loading

----------------------------------
--[[	Table Copy Function	]]
----------------------------------
local function CopySettings(source,target,overwritemode)
--	Recursively copies source into target, preserving shared keys unless overwrite is set
--	OverwriteMode is true/false/nil
--		true = wipe	false = overwrite	nil = preserve

	if type(source)~="table" then return source; end
	if type(target)~="table" then target={}; end
	if overwritemode then table.wipe(target); end

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
					if overwritemode then table.wipe(newval); end
					registry[v]=newval;
					table.insert(stack,v);
				end

				target[k]=newval;
			elseif overwritemode~=nil or targetval==nil then target[k]=v; end--	Preserve existing values unless overwrite flag set
		end
	end

	return target;
end

--------------------------
--[[	Options Panel	]]
--------------------------
local Panel=CreateFrame("Frame"); do
	Panel:Hide();

	local title=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalLarge");
	title:SetPoint("TOP",0,-12);
	title:SetText(Title);

	local author=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalSmall");
	author:SetPoint("TOP",title,"BOTTOM",0,0);
	author:SetTextColor(1,0.5,0.25);
	author:SetText(AddOn.Localization.Options_ByAuthor_Format:format(GetAddOnMetadata(Name,"Author")));

	local version=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalSmall");
	version:SetPoint("TOPLEFT",title,"TOPRIGHT",4,0);
	version:SetTextColor(0.5,0.5,0.5);
	version:SetText("v"..GetAddOnMetadata(Name,"Version"));
end

--------------------------
--[[	Event Handlers	]]
--------------------------
Panel:RegisterEvent("ADDON_LOADED");
Panel:SetScript("OnEvent",function(self,event,...)
	if event=="ADDON_LOADED" and (...)==Name then
		ChatLinkIcons_Options=CopySettings(Defaults,ChatLinkIcons_Options or {}
--			Cast to either true for wipe or nil for preserve
			,ChatLinkIcons_Options and (ChatLinkIcons_Options.Options_SaveVersion~=Defaults.Options_SaveVersion or nil)
		);

		AddOn.Options=ChatLinkIcons_Options;
		AddOn.Options_OnOptionsUpdate:Fire();
		self:UnregisterEvent(event);
	end
end);

--------------------------
--[[	Options API	]]
--------------------------
local OptionButtonList={};
local OptionButtonLookup={};

local function RefreshOptionButtons()
	local stack={};
	for _,button in ipairs(OptionButtonList) do if not button.Parent then table.insert(stack,button); end end
	for _,parent in ipairs(stack) do for _,child in ipairs(parent) do table.insert(stack,child); end end
	for _,button in ipairs(stack) do button:Refresh(); end
end

function AddOn.Options_LookupOptionButton(key) return OptionButtonLookup[key]; end

do--	AddOn.Options_CreateOptionButton(anchorgroup,key,text,defaultval,xoff)
	local Padding=-8;
	local AnchorGroup={
		{"TOPLEFT",Panel,"TOPLEFT",24,-48};
		{"TOPLEFT",Panel,"TOP",0,-48};
	};

--	Internal API
	local function OptionButton_Refresh(self)
		self:SetEnabled(not self.Parent or (self.Parent:IsEnabled() and AddOn.Options[self.Parent.Key]~=false));
		self:SetChecked(AddOn.Options[self.Key]);
	end

--	Scripts
	local function OptionButton_OnClick(self)
		AddOn.Options[self.Key]=self:GetChecked();

--		Update Dependants
		local stack={self}; repeat
			for _,child in ipairs(table.remove(stack,1)) do
				child:Refresh();
				if #child>0 then table.insert(stack,child); end
			end
		until #stack<=0

		AddOn.Options_OnOptionsUpdate:Fire();
	end

--	Generator
	function AddOn.Options_CreateOptionButton(parentkey,optionkey,text)
		local parent,anchor;
		if type(parentkey)=="number" then
			anchor=assert(AnchorGroup[parentkey],"AnchorID out of bounds");
		else
			parent=assert(OptionButtonLookup[parentkey],"Undefined parent key");
			anchor=parent.Anchor;
		end

		local button=CreateFrame("CheckButton",nil,Panel,"UICheckButtonTemplate");
		local level=parent and parent.Level+1 or 1;
		local point,relframe,relpoint,x,y=unpack(anchor);

		button:SetPoint(point,relframe,relpoint,x+(level-1)*(button:GetWidth()+Padding),y);

		button:SetFontString(button.Text);
		button:SetNormalFontObject(GameFontNormalSmall);
		button:SetHighlightFontObject(GameFontHighlightSmall);
		button:SetDisabledFontObject(GameFontDisableSmall);
		button:SetText(text or AddOn.Localization["OptionsSetting_"..optionkey]);
		button:SetHitRectInsets(4,6-button.Text:GetWidth(),4,4);

		button:SetScript("OnClick",OptionButton_OnClick);

		button.Anchor=anchor;
		button.Parent=parent;
		button.Level=level;
		button.Key=optionkey;

		button.Refresh=OptionButton_Refresh;
		if parent then table.insert(parent,button); end

		anchor[5]=y-button:GetHeight()-Padding;
		table.insert(OptionButtonList,button);
		OptionButtonLookup[optionkey],OptionButtonLookup[button]=button,optionkey;

		return button;
	end
end

------------------------------------------
--[[	Panel Registration & Callbacks	]]
------------------------------------------
local OptionCache={};
local function Options_Cancel()
	CopySettings(OptionCache,AddOn.Options,false);
	RefreshOptionButtons();
	AddOn.Options_OnOptionsUpdate:Fire();
end

local function Options_Default()
	CopySettings(Defaults,AddOn.Options,true);
	CopySettings(Defaults,OptionCache,true);
	RefreshOptionButtons();
	AddOn.Options_OnOptionsUpdate:Fire();
end

local function Options_Refresh()
	CopySettings(AddOn.Options,OptionCache,true);
	RefreshOptionButtons();
end

--	Panel Registration
if Settings and (Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory) then
--	Panel.name=Title;
	Panel.OnCommit=nop;
	Panel.OnDefault=Options_Default;
	Panel.OnRefresh=Options_Refresh;

	local category=Settings.RegisterCanvasLayoutCategory(Panel,Title);
	category.ID=Title;
	Settings.RegisterAddOnCategory(category);
else
	Panel.name=Title;
	Panel.okay=nop;
	Panel.cancel=Options_Cancel;
	Panel.default=Options_Default;
	Panel.refresh=Options_Refresh;
	InterfaceOptions_AddCategory(Panel);
end
