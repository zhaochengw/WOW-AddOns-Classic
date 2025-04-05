--[[--
	by ALA
--]]--

local __version = 241201.0;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;

-->			versioncheck
	local __poplib = __ala_meta__.__poplib;
	if __poplib ~= nil and __poplib.__minor ~= nil and __poplib.__minor >= __version then
		return;
	elseif __poplib == nil then
		__poplib = {  };
		__ala_meta__.__poplib = __poplib;
	else
		if __poplib.Halt ~= nil then
			__poplib:Halt(__poplib.__minor);
		end
	end
	__poplib.__minor = __version;

-->

-->			upvalue
	local type = type;
	local tinsert = tinsert;

	local CreateFrame = CreateFrame;
	local Menu = Menu;
	local MenuUtil = MenuUtil;
	local DropDownList1 = DropDownList1;

-->			constant
	local font, fontsize, fontflag = GameFontNormal:GetFont();
	local _, _, _, TocVerison = GetBuildInfo();

-->

local __isdead = false;
__poplib.MethodScript = __poplib.MethodScript or {  };
__poplib.ScriptEntry = __poplib.ScriptEntry or {  };

local MethodScript = __poplib.MethodScript;
local ScriptEntry = __poplib.ScriptEntry;
local AllFrames = {  };
--[[
	def = {
		GetText(def, context),
		IsShown(def, context),
		OnClick(def, which, context),
		category = "",
	}
--]]
function __poplib:AddMethod(method, def)
	if type(method) == 'string' then
		MethodScript[method] = def;
	end
end

function __poplib:CreateInsertFrame(DividerHeight, DividerTextureHeight, LabelHeight, ButtonHeight, OnClick)
	local InsertFrame = CreateFrame('FRAME');
	InsertFrame:Hide();
	InsertFrame:SetScript("OnHide", function(InsertFrame)
		if InsertFrame.menu == nil or not InsertFrame.menu:IsShown() then
			InsertFrame:Hide();
		end
	end);
	local DivPool = {  };
	local LblPool = {  };
	local BtnPool = {  };
	local Offset = 0;
	local DivIndex = 0;
	local LblIndex = 0;
	local BtnIndex = 0;
	function InsertFrame.Clear(InsertFrame)
		DivIndex = 0;
		LblIndex = 0;
		BtnIndex = 0;
		Offset = 0;
		for i = 1, #DivPool do
			DivPool[i]:Hide();
		end
		for i = 1, #LblPool do
			LblPool[i]:Hide();
		end
		for i = 1, #BtnPool do
			BtnPool[i]:Hide();
		end
		InsertFrame:SetHeight(1);
	end
	function InsertFrame.AddDivider(InsertFrame)
		DivIndex = DivIndex + 1;
		local Divider = DivPool[DivIndex];
		if Divider == nil then
			Divider = CreateFrame('FRAME', nil, InsertFrame);
			Divider.type = 'divider';
			Divider:SetHeight(DividerHeight);
			Divider:SetPoint("LEFT");
			Divider:SetPoint("RIGHT");
			Divider:SetMouseClickEnabled(true);
			Divider.Texture = Divider:CreateTexture(nil, "ARTWORK");
			Divider.Texture:SetHeight(DividerTextureHeight);
			Divider.Texture:SetPoint("LEFT");
			Divider.Texture:SetPoint("RIGHT");
			Divider.Texture:SetTexture(918860);
			DivPool[DivIndex] = Divider;
		else
			Divider:Show();
		end
		Divider:SetPoint("TOP", InsertFrame, "TOP", 0, -Offset);
		Offset = Offset + DividerHeight;
		InsertFrame:SetHeight(Offset);
	end
	function InsertFrame.AddLabel(InsertFrame, text)
		LblIndex = LblIndex + 1;
		local Label = LblPool[LblIndex];
		if Label == nil then
			Label = CreateFrame('FRAME', nil, InsertFrame);
			Label.type = 'label';
			Label:SetHeight(LabelHeight);
			Label:SetPoint("LEFT");
			Label:SetPoint("RIGHT");
			Label:SetMouseClickEnabled(true);
			Label.Text = Label:CreateFontString(nil, "ARTWORK");
			Label.Text:SetFont(font, fontsize, fontflag);
			Label.Text:SetTextColor(1.0, 0.8196, 0.0);
			Label.Text:SetPoint("LEFT");
			Label.Text:SetText("");
			LblPool[LblIndex] = Label;
		else
			Label:Show();
		end
		Label.Text:SetText(text);
		Label:SetPoint("TOP", InsertFrame, "TOP", 0, -Offset);
		Offset = Offset + LabelHeight;
		InsertFrame:SetHeight(Offset);
	end
	function InsertFrame.AddButton(InsertFrame, def, context)
		if def and (def.IsShown == nil or def:IsShown(context)) then
			BtnIndex = BtnIndex + 1;
			local Button = BtnPool[BtnIndex];
			if Button == nil then
				Button = CreateFrame('BUTTON', nil, InsertFrame);
				Button.type = 'button';
				Button:SetHeight(ButtonHeight);
				Button:SetPoint("LEFT");
				Button:SetPoint("RIGHT");
				Button:SetHighlightTexture(136810);
				Button.Text = Button:CreateFontString(nil, "ARTWORK");
				Button.Text:SetFont(font, fontsize, fontflag);
				Button.Text:SetPoint("LEFT");
				Button.Text:SetText("");
				Button:SetScript("OnClick", function(Button)
					return OnClick(Button, InsertFrame, Button.def);
				end);
				BtnPool[BtnIndex] = Button;
			else
				Button:Show();
			end
			Button.def = def;
			Button.Text:SetText(def:GetText(context));
			Button:SetPoint("TOP", InsertFrame, "TOP", 0, -Offset);
			Offset = Offset + ButtonHeight;
			InsertFrame:SetHeight(Offset);
		end
	end
	AllFrames[#AllFrames + 1] = InsertFrame;
	return InsertFrame;
end

if Menu and MenuUtil then
	function __poplib:AddEntry(which, method)
		if type(which) == 'string' and type(method) == 'string' and MethodScript[method] then
			local entrydef = ScriptEntry[which];
			local methoddef = MethodScript[method];
			if entrydef == nil then
				entrydef = { methoddef, };
				ScriptEntry[which] = entrydef;
			else
				for i = 1, #entrydef do
					if entrydef[i] == methoddef then
						return;
					end
				end
				if entrydef[1].category ~= nil and methoddef.category == nil then
					tinsert(entrydef, 1, methoddef);
					return;
				end
				for i = 2, #entrydef do
					if entrydef[i - 1].category == methoddef.category and entrydef[i].category ~= methoddef.category then
						tinsert(entrydef, i, methoddef);
						return;
					end
				end
				entrydef[#entrydef + 1] = methoddef;
			end
			if entrydef.putscript ~= true then
				entrydef.putscript = true;
				Menu.ModifyMenu('MENU_UNIT_' .. which, function(owner, rootDescription, contextData)
					if __isdead then
						return;
					end 
					local category = nil;
					local divider = false;
					local first = true;
					for i = 1, #entrydef do
						local def = entrydef[i];
						if first or category ~= def.category then
							first = false;
							divider = true;
							category = def.category;
						end
						if def.IsShown == nil or def:IsShown(contextData) then
							if divider then
								divider = false;
								rootDescription:CreateDivider();
								if category ~= nil then
									rootDescription:CreateTitle(category);
								end
							end
							rootDescription:CreateButton(def:GetText(contextData), function()
								return def:OnClick(which, contextData);
							end);
						end
					end
				end);
			end
		end
	end
elseif false and Menu and MenuUtil then
	function __poplib:AddEntry(which, method)
		if type(which) == 'string' and type(method) == 'string' and MethodScript[method] then
			local entrydef = ScriptEntry[which];
			local methoddef = MethodScript[method];
			if entrydef == nil then
				ScriptEntry[which] = { methoddef, };
			else
				for i = 1, #entrydef do
					if entrydef[i] == methoddef then
						return;
					end
				end
				if entrydef[1].category ~= nil and methoddef.category == nil then
					tinsert(entrydef, 1, methoddef);
					return;
				end
				for i = 2, #entrydef do
					if entrydef[i - 1].category == methoddef.category and entrydef[i].category ~= methoddef.category then
						tinsert(entrydef, i, methoddef);
						return;
					end
				end
				entrydef[#entrydef + 1] = methoddef;
			end
		end
	end

	local M = Menu.GetManager();
	local Inset = TocVerison >= 100000 and 8 or 14;

	local InsertFrame = __poplib:CreateInsertFrame(13, 13, 20, 20, function(Button, InsertFrame, def)
		M:CloseMenu(InsertFrame.menu);
		return def:OnClick(InsertFrame.which, InsertFrame.contextData);
	end);
	hooksecurefunc(MenuUtil, "CreateContextMenu", function()
		if __isdead then
			return;
		end 
		InsertFrame:Hide();
	end);
	hooksecurefunc("UnitPopup_OpenMenu", function(which, contextData)
		if __isdead then
			return;
		end 
		local entrydef = ScriptEntry[which];
		if entrydef then
			local menu = M:GetOpenMenu();
			InsertFrame:Show();
			InsertFrame:SetParent(menu);
			InsertFrame:SetPoint("BOTTOM", menu, "BOTTOM", 0, 14);
			InsertFrame:SetPoint("LEFT", menu, "LEFT", Inset, 0);
			InsertFrame:SetPoint("RIGHT", menu, "RIGHT", -Inset, 0);
			InsertFrame:Clear();
			local category = nil;
			local first = true;
			for i = 1, #entrydef do
				local def = entrydef[i];
				if first or category ~= def.category then
					first = false;
					category = def.category;
					InsertFrame:AddDivider();
					if category ~= nil then
						InsertFrame:AddLabel(category);
					end
				end
				InsertFrame:AddButton(def, contextData);
			end
			menu:SetHeight(menu:GetHeight() + InsertFrame:GetHeight());
			InsertFrame.menu = menu;
			InsertFrame.which = which
			InsertFrame.contextData = contextData;
		else
			InsertFrame:Hide();
		end
	end);
elseif DropDownList1 then
	function __poplib:AddEntry(which, method)
		if type(which) == 'string' and type(method) == 'string' and MethodScript[method] then
			local entrydef = ScriptEntry[which];
			local methoddef = MethodScript[method];
			if entrydef == nil then
				ScriptEntry[which] = { methoddef, };
			else
				for i = 1, #entrydef do
					if entrydef[i] == methoddef then
						return;
					end
				end
				if entrydef[1].category ~= nil and methoddef.category == nil then
					tinsert(entrydef, 1, methoddef);
					return;
				end
				for i = 2, #entrydef do
					if entrydef[i - 1].category == methoddef.category and entrydef[i].category ~= methoddef.category then
						tinsert(entrydef, i, methoddef);
						return;
					end
				end
				entrydef[#entrydef + 1] = methoddef;
			end
		end
	end

	local InsertFrame = __poplib:CreateInsertFrame(16, 8, 16, 16, function(Button, InsertFrame, def)
		DropDownList1:Hide();
		local contextData = DropDownList1.dropdown;
		return def:OnClick(contextData.which, contextData);
	end);
	local IsSettingHeight = false;
	--UnitPopup_ShowMenu
	DropDownList1:HookScript("OnShow", function(menu)
		if __isdead then
			return;
		end 
		local entrydef = ScriptEntry[DropDownList1.dropdown.which];
		if entrydef then
			InsertFrame:Show();
			InsertFrame:SetParent(menu);
			InsertFrame:SetPoint("BOTTOM", menu, "BOTTOM", 0, 15);
			InsertFrame:SetPoint("LEFT", menu, "LEFT", 15, 0);
			InsertFrame:SetPoint("RIGHT", menu, "RIGHT", -16, 0);
			InsertFrame:Clear();
			local category;
			local first = true;
			for i = 1, #entrydef do
				local def = entrydef[i];
				if first or category ~= def.category then
					first = false;
					category = def.category;
					InsertFrame:AddDivider();
					if category ~= nil then
						InsertFrame:AddLabel(category);
					end
				end
				InsertFrame:AddButton(def, DropDownList1.dropdown);
			end
			IsSettingHeight = true;
			menu:SetHeight(menu:GetHeight() + InsertFrame:GetHeight());
			IsSettingHeight = false;
		else
			InsertFrame:Hide();
		end
	end);
	DropDownList1:HookScript("OnHide", function(menu)
		if __isdead then
			return;
		end 
		InsertFrame:Hide();
	end);
	--UIDropDownMenu_AddButton
	hooksecurefunc(DropDownList1, "SetHeight", function(menu, height)
		if __isdead then
			return;
		end 
		if not IsSettingHeight and InsertFrame:IsVisible() then
			IsSettingHeight = true;
			menu:SetHeight(height + InsertFrame:GetHeight());
			IsSettingHeight = false;
		end
	end);
end

function __poplib:Halt(old)
	__isdead = true;
	for which, entrydef in next, ScriptEntry do
		entrydef.putscript = nil;
	end
	for i = 1, #AllFrames do
		AllFrames[i]:Clear();
	end
end
