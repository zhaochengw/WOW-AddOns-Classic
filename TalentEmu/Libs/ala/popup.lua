--[[--
	by ALA
--]]--

local __version = 241011.0;

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

-->

local __dead = false;
__poplib.MethodScript = __poplib.MethodScript or {  };
__poplib.ScriptEntry = __poplib.ScriptEntry or {  };

local MethodScript = __poplib.MethodScript;
local ScriptEntry = __poplib.ScriptEntry;
local AllFrames = {  };
--[[
	def = {
		GetText(def, context),
		CanShow(def, context),
		OnClick(def, which, context),
		category = "",
	}
--]]
function __poplib:AddMethod(method, def)
	if type(method) == 'string' then
		MethodScript[method] = def;
	end
end
function __poplib:AddEntry(which, method)
	if type(which) == 'string' and type(method) == 'string' and MethodScript[method] then
		local E = ScriptEntry[which];
		local m = MethodScript[method];
		if E == nil then
			ScriptEntry[which] = { m, };
		else
			for i = 1, #E do
				if E[i] == m then
					return;
				end
			end
			if E[1].category ~= nil and m.category == nil then
				tinsert(E, 1, m);
				return;
			end
			for i = 2, #E do
				if E[i - 1].category == m.category and E[i].category ~= m.category then
					tinsert(E, i, m);
					return;
				end
			end
			E[#E + 1] = m;
		end
	end
end

function __poplib:CreateInsertFrame(DividerHeight, DividerTextureHeight, LabelHeight, ButtonHeight, OnClick)
	local InsertFrame = CreateFrame('FRAME');
	InsertFrame:Hide();
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
		if def and (def.CanShow == nil or def:CanShow(context)) then
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
	local M = Menu.GetManager();

	local InsertFrame = __poplib:CreateInsertFrame(13, 13, 20, 20, function(Button, InsertFrame, def)
		M:CloseMenu(InsertFrame.menu);
		return def:OnClick(InsertFrame.which, InsertFrame.contextData);
	end);
	hooksecurefunc(MenuUtil, "CreateContextMenu", function()
		if __dead then
			return;
		end 
		InsertFrame:Hide();
	end);
	hooksecurefunc("UnitPopup_OpenMenu", function(which, contextData)
		if __dead then
			return;
		end 
		local E = ScriptEntry[which];
		if E then
			local menu = M:GetOpenMenu();
			InsertFrame:Show();
			InsertFrame:SetParent(menu);
			InsertFrame:SetPoint("BOTTOM", menu, "BOTTOM", 0, 14);
			InsertFrame:SetPoint("LEFT", menu, "LEFT", 14, 0);
			InsertFrame:SetPoint("RIGHT", menu, "RIGHT", -14, 0);
			InsertFrame:Clear();
			local category;
			local first = true;
			for i = 1, #E do
				local def = E[i];
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
end

if DropDownList1 then
	local InsertFrame = __poplib:CreateInsertFrame(16, 8, 16, 16, function(Button, InsertFrame, def)
		DropDownList1:Hide();
		local contextData = DropDownList1.dropdown;
		return def:OnClick(contextData.which, contextData);
	end);
	local IsSettingHeight = false;
	--UnitPopup_ShowMenu
	DropDownList1:HookScript("OnShow", function(menu)
		if __dead then
			return;
		end 
		local E = ScriptEntry[DropDownList1.dropdown.which];
		if E then
			InsertFrame:Show();
			InsertFrame:SetParent(menu);
			InsertFrame:SetPoint("BOTTOM", menu, "BOTTOM", 0, 15);
			InsertFrame:SetPoint("LEFT", menu, "LEFT", 15, 0);
			InsertFrame:SetPoint("RIGHT", menu, "RIGHT", -16, 0);
			InsertFrame:Clear();
			local category;
			local first = true;
			for i = 1, #E do
				local def = E[i];
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
		if __dead then
			return;
		end 
		InsertFrame:Hide();
	end);
	--UIDropDownMenu_AddButton
	hooksecurefunc(DropDownList1, "SetHeight", function(menu, height)
		if __dead then
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
	__dead = true;
	for i = 1, #AllFrames do
		AllFrames[i]:Clear();
	end
end

