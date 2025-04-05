--------------------------------------------------------------------------
-- FeatureFrame.lua
--------------------------------------------------------------------------
--[[

	-- Author
	Vjeux and Alexander Brazie
	Liberated from the Earth library by Ryan "Gryphon" Snook
	Made standalone by AnduinLothar
	More by Isler

	-- Description
	These are functions to allow a user to register a button
	for their feature to appear within the frame here.

	-- Changes
	3.0	- Tab view
		- mouse wheel support
	2.0	- Refactored to be standalone, renamed
		- Still accepts old EarthFeature_AddButton(...) calls, but the new syntax is FeatureFrame_AddButton(...)
	1.0	- Initial separation from Earth

	-- SVN info
	$Id: FeatureFrame.lua 4157 2006-10-13 20:12:04Z geowar $
	$Rev: 4157 $
	$LastChangedBy: geowar $
	$Date: 2006-10-13 20:12:04Z $

]]--

FeatureFrame_Tabs = {
	main = 1,
	data = 2,
	combat = 3,
	group = 4,
	ui = 5,
	class = 6,
	other = 7,
}
FeatureFrame_TabsR = {}
FeatureFrame_selectedTab = "main";

FeatureFrame_Version = {
	Version = "3.00"
}

-- Inform the default UI of our existence...
UIPanelWindows["FeatureFrame"] = { area = "left", pushable = 3, whileDead = 1 };

-- Max Objects
FeatureFrame_MAX = 14;

-- Data objects:
FeatureFrame_Buttons = { };
for k, v in pairs(FeatureFrame_Tabs) do
	FeatureFrame_TabsR[v] = k;
	FeatureFrame_Buttons[k] = {};
end
FeatureFrame_CurrentOffset = 0;

--[[
--	RegisterButton
--
--	Allow you to create a button of your mod in the FeatureFrame.
--
--	Usage:
--
--		FeatureFrame_AddButton ( FeatureFrameRegistrationObject[name,subtext,tooltip,icon,callback,testfunction] )
--
--	Example:
--
--		FeatureFrame_AddButton (
--			{
--				id = "MyAddOnID";
--				tab = "MyAddOnTab";
--				name = "My AddOn";
--				subtext = "Is very cool";
--				tooltip = "Long Tool\n Tip Text";
--				icon = "Interface\\Icons\\Spell_Holy_BlessingOfStrength";
--				callback = function(button)
--					if button == "LeftButton" then
--						if (MinimapFrameFrame:IsVisible()) then
--							HideUIPanel(MinimapFrame);
--						else
--							ShowUIPanel(MinimapFrame);
--						end
--					elseif button == "RightButton" then
--						if (MinimapFrameFrame:IsVisible()) then
--							HideUIPanel(MinimapFrame);
--						else
--							ShowUIPanel(MinimapFrame);
--						end
--					end
--				end;
--				test = function()
--					if not IsAddOnLoaded("MyAddOnID") and not IsAddOnLoadOnDemand("MyAddOnID") then
--						return false; -- The button is disabled
--					else
--						return true; -- The button is enabled
--					end
--				end
--			}
--			);
--
--		A button will be created in the Features Frame.
--
--		Description must not be more than 2 words, you should put a longer description in the tooltip.
--
--	]]--

function FeatureFrameTabs_OnLoad()
	FeatureFrame_selectedTab = "main";
	FeatureFrameTab1:SetChecked(true);
	_G["FeatureFrameTab"..FeatureFrame_Tabs["main"]].tooltip = GENERAL;
	_G["FeatureFrameTab"..FeatureFrame_Tabs["data"]].tooltip = ITEMS;
	_G["FeatureFrameTab"..FeatureFrame_Tabs["combat"]].tooltip = COMBAT;
	_G["FeatureFrameTab"..FeatureFrame_Tabs["group"]].tooltip = GROUPS;
	_G["FeatureFrameTab"..FeatureFrame_Tabs["ui"]].tooltip = SHOW;
	_G["FeatureFrameTab"..FeatureFrame_Tabs["class"]].tooltip = CLASS;
	_G["FeatureFrameTab"..FeatureFrame_Tabs["other"]].tooltip = AUCTION_SUBCATEGORY_OTHER;
end

function FeatureFrame_AddButton(newButton)
	if ( newButton.tab == nil or FeatureFrame_Tabs[newButton.tab] == nil ) then
		newButton.tab = "other";
	end
	local i = 1;
	while ( FeatureFrame_Buttons[newButton.tab][i] ) do
		if FeatureFrame_Buttons[newButton.tab][i].name ~= newButton.name then
			i = i + 1;
		else
			return false;
		end
	end
	if ( not newButton ) or ( type(newButton) ~= "table" ) then
		Sea.io.error ( "FeatureFrame_AddButton: ","Missing a table for the button. From ",self:GetName());
		return false;
	end
	if ( newButton.name == nil ) then
		Sea.io.error ( "FeatureFrame_AddButton: ","Missing a name for the button. From ",self:GetName());
		return false;
	end
	if ( newButton.icon == nil ) then
		Sea.io.error ( "FeatureFrame_AddButton: ","Missing an icon path for the FeatureFrame Button. (",newButton.name,")", " from ", self:GetName());
		return false;
	end
	if ( newButton.callback == nil ) then
		Sea.io.error ( "FeatureFrame_AddButton: ","Missing a callback for the FeatureFrame Button. (",newButton.name,")", " from ", self:GetName());
		return false;
	end
	if ( newButton.test == nil ) then
		newButton.test = function () return true; end;
	end

	table.insert ( FeatureFrame_Buttons[newButton.tab], newButton );

	FeatureFrame_UpdateButtons();
	FeatureFrameMinimapButton:Show();
	if not _G["FeatureFrameTab"..FeatureFrame_Tabs[newButton.tab]]:IsShown() then
		_G["FeatureFrameTab"..FeatureFrame_Tabs[newButton.tab]]:Show();
	end
	return true;
end

-- Reverse compat alias
EarthFeature_AddButton = FeatureFrame_AddButton;

function ToggleFeatureFrame()
	if (FeatureFrame:IsVisible()) then
		HideUIPanel(FeatureFrame);
	else
		ShowUIPanel(FeatureFrame);
	end
end

function FeatureFrame_OnHide(self)
	UpdateMicroButtons();
	-- PlaySound("igSpellBookClose");
	PlaySound(851);
end

function FeatureFrameButtons_UpdateColor()
	local root = "FeatureFrame";
	for i = 1, FeatureFrame_MAX, 1 do
		local icon = getglobal(root.."Button"..i);
		local iconTexture = getglobal(root.."Button"..i.."IconTexture");

		local id = FeatureFrameButton_GetOffset() + i;
		if ( FeatureFrame_Buttons[FeatureFrame_selectedTab][id] ) then
			if ( FeatureFrame_Buttons[FeatureFrame_selectedTab][id].test() == false ) then
				-- icon:Disable();
				iconTexture:SetVertexColor(1.00, 0.00, 0.00);
			else
				-- icon:Enable();
				iconTexture:SetVertexColor(1.00, 1.00, 1.00);
			end
		end
	end
end

function FeatureFrame_OnShow(self)
	FeatureFrameTitleText:SetText(FEATURE_FRAME_TITLE);
	-- PlaySound("igSpellBookOpen");
	PlaySound(850);
	FeatureFrame_UpdateButtons();
end

function FeatureFrameButton_OnEnter(self)
	local id = self:GetID() + FeatureFrameButton_GetOffset();

	if ( FeatureFrame_Buttons[FeatureFrame_selectedTab][id] ) then
		local tooltip = FeatureFrame_Buttons[FeatureFrame_selectedTab][id].tooltip;
		if ( type ( tooltip ) == "function" ) then
			tooltip = tooltip();
		end
		if ( tooltip ) then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(tooltip, 1.0, 1.0, 1.0);
			if ( FeatureFrame_Buttons[FeatureFrame_selectedTab][id].test() == false ) then
				GameTooltip:AddLine(STATUS..": "..DISABLE, 1.0, 0.0, 0.0)
			end
		end
	end
end

function FeatureFrameButton_OnLeave(self)
	GameTooltip:Hide();
end

StaticPopupDialogs["FeatureFrame_EnableAddon"] = {
	text = LOAD_ADDON.."?",
	button1 = YES,
	button2 = NO,
	OnAccept = function(self, data)
		EnableAddOn(data);
		for i = 1, GetNumAddOns() do
			local dep = GetAddOnDependencies(i);
			if dep and dep == data then
				EnableAddOn(i);
			end
		end
		ReloadUI();
	end,
	whileDead = 1, hideOnEscape = 1, showAlert = 1
}

function FeatureFrameButton_OnClick(self, button)
	local id = self:GetID() + FeatureFrameButton_GetOffset();

	if ( FeatureFrame_Buttons[FeatureFrame_selectedTab][id] ) then
		local addon = FeatureFrame_Buttons[FeatureFrame_selectedTab][id].id;
		if ( FeatureFrame_Buttons[FeatureFrame_selectedTab][id].test() == false ) then
			self:SetChecked(false);
			local dialog = StaticPopup_Show("FeatureFrame_EnableAddon");
			if (dialog) then
				dialog.data = addon;
			end
		else
			self:SetChecked(false);
			FeatureFrame_Buttons[FeatureFrame_selectedTab][id].callback(button);
		end
	end
end

function FeatureFrameButton_GetOffset()
	return FeatureFrame_CurrentOffset;
end

function FeatureFrame_NextPage(self, key)
	if not key then
		if ( #FeatureFrame_Buttons[FeatureFrame_selectedTab] > FeatureFrame_CurrentOffset + FeatureFrame_MAX ) then
			FeatureFrame_CurrentOffset = FeatureFrame_CurrentOffset + FeatureFrame_MAX;
		end
	else
		local nid = FeatureFrame_Tabs[FeatureFrame_selectedTab] + 1;
		if nid > #FeatureFrame_TabsR then
			nid = 1;
		end

		local found = false;
		for i = nid, #FeatureFrame_TabsR, 1 do
			if _G["FeatureFrameTab"..i]:IsShown() then
				nid = i;
				found = true;
				break;
			end
		end
		if found == false then
			for i = 1, nid, 1 do
				if _G["FeatureFrameTab"..i]:IsShown() then
					nid = i;
					found = true;
					break;
				end
			end
		end

		if _G["FeatureFrameTab"..nid] and _G["FeatureFrameTab"..nid]:IsShown() then
			FeatureFrameTab_OnClick(_G["FeatureFrameTab"..nid]);
		end
	end
	FeatureFrame_UpdateButtons();
end

function FeatureFrame_PrevPage(self, key)
	if not key then
		if ( FeatureFrame_CurrentOffset - FeatureFrame_MAX < 0 ) then
			FeatureFrame_CurrentOffset = 0;
		else
			FeatureFrame_CurrentOffset = FeatureFrame_CurrentOffset - FeatureFrame_MAX;
		end
	else
		local nid = FeatureFrame_Tabs[FeatureFrame_selectedTab] - 1;
		if nid == 0 then
			nid = #FeatureFrame_TabsR;
		end

		local found = false;
		for i = nid, 1, -1 do
			if _G["FeatureFrameTab"..i]:IsShown() then
				nid = i;
				found = true;
				break;
			end
		end
		if found == false then
			for i = #FeatureFrame_TabsR, nid, -1 do
				if _G["FeatureFrameTab"..i]:IsShown() then
					nid = i;
					found = true;
					break;
				end
			end
		end

		if _G["FeatureFrameTab"..nid] and _G["FeatureFrameTab"..nid]:IsShown() then
			FeatureFrameTab_OnClick(_G["FeatureFrameTab"..nid]);
		end
	end
	FeatureFrame_UpdateButtons();
end

function FeatureFrame_OnScroll(self, delta, key)
	if delta > 0 then
		FeatureFrame_PrevPage(self, key)
	else
		FeatureFrame_NextPage(self, key)
	end
end

function FeatureFrame_UpdateButtons()
	local root = "FeatureFrame";
	for i = 1, FeatureFrame_MAX, 1 do
		local icon = getglobal(root.."Button"..i);
		local iconTexture = getglobal(root.."Button"..i.."IconTexture");
		local iconName = getglobal(root.."Button"..i.."Name");
		local iconDescription = getglobal(root.."Button"..i.."OtherName");

		local id = FeatureFrameButton_GetOffset() + i;
		if ( FeatureFrame_Buttons[FeatureFrame_selectedTab][id] ) then
			icon:Show();
			icon:Enable();
			iconTexture:Show();
			iconTexture:SetTexture(FeatureFrame_Buttons[FeatureFrame_selectedTab][id].icon);
			iconName:Show();
			if ( type ( FeatureFrame_Buttons[FeatureFrame_selectedTab][id].name ) == "function" ) then
				iconName:SetText(FeatureFrame_Buttons[FeatureFrame_selectedTab][id].name());
			else
				iconName:SetText(FeatureFrame_Buttons[FeatureFrame_selectedTab][id].name);
			end
			iconDescription:Show();
			if ( type ( FeatureFrame_Buttons[FeatureFrame_selectedTab][id].subtext ) == "function" ) then
				iconDescription:SetText(FeatureFrame_Buttons[FeatureFrame_selectedTab][id].subtext());
			else
				iconDescription:SetText(FeatureFrame_Buttons[FeatureFrame_selectedTab][id].subtext);
			end
		else
			icon:Hide();
			iconTexture:Hide();
			iconName:Hide();
			iconDescription:Hide();
		end
	end
	FeatureFrame_UpdatePageArrows();
	FeatureFrameButtons_UpdateColor();
end

function FeatureFrame_UpdatePageArrows()
	local root = "FeatureFrame";
	local currentPage, maxPages = FeatureFrame_GetCurrentPage();
	if ( currentPage== 1 ) then
		getglobal(root.."PrevPageButton"):Disable();
	else
		getglobal(root.."PrevPageButton"):Enable();
	end
	if ( currentPage == maxPages ) then
		getglobal(root.."NextPageButton"):Disable();
	else
		getglobal(root.."NextPageButton"):Enable();
	end
end

function FeatureFrame_GetCurrentPage()
	local currentPage = (FeatureFrameButton_GetOffset()/FeatureFrame_MAX) + 1;
	local maxPages = ceil(#FeatureFrame_Buttons[FeatureFrame_selectedTab]/FeatureFrame_MAX);
	return currentPage, maxPages;
end

function FeatureFrameTab_OnClick(self)
	local id = self:GetID();
	if ( FeatureFrame_Tabs[FeatureFrame_selectedTab] ~= id ) then
		-- PlaySound(SOUNDKIT.IG_ABILITY_PAGE_TURN);
		PlaySound(836);
		_G["FeatureFrameTab"..FeatureFrame_Tabs[FeatureFrame_selectedTab]]:SetChecked(false);
		self:SetChecked(true);
		FeatureFrame_selectedTab = FeatureFrame_TabsR[id];
		FeatureFrame_CurrentOffset = 0;
		FeatureFrame_UpdateButtons();
	else
		self:SetChecked(true);
	end
	
	-- Stop tab flashing
	if ( self ) then
		local tabFlash = _G[self:GetName().."Flash"];
		if ( tabFlash ) then
			tabFlash:Hide();
		end
	end
end

--[[
--	Minimap Button Mobility Code
--]]

function FeatureFrameMinimapButton_OnLoad(self)
	self:RegisterEvent("VARIABLES_LOADED");
	FeatureFrameMinimapButton:SetFrameLevel(MinimapZoomIn:GetFrameLevel());
	--FeatureFrameMinimapButton_Reset();
end

function FeatureFrameMinimapButton_Reset()
	--fixes a mysterious frame level problem that would hide the FeatureFrameMinimapButton behind some unknown minimap frame.
	ToggleWorldMap();
	ToggleWorldMap();
end

function FeatureFrameMinimapButton_OnEvent(self, event)
	if (event == "VARIABLES_LOADED") then
		if (FeatureFrameMinimapButton_OffsetX) and (FeatureFrameMinimapButton_OffsetY) then
			self:SetPoint("CENTER", "Minimap", "CENTER", FeatureFrameMinimapButton_OffsetX, FeatureFrameMinimapButton_OffsetY);
		end
	end
end

function FeatureFrameMinimapButton_OnMouseDown(self)
	if (IsControlKeyDown()) then
		if ( arg1 == "RightButton" ) then
			--wait for reset
		else
			self.isMoving = 0;	-- true, so as not to conflict with MobileMinimapButtons
		end
	end
end

function FeatureFrameMinimapButton_OnMouseUp(self)
	if (self.isMoving) then
		self.isMoving = false;
		FeatureFrameMinimapButton_OffsetX = self.currentX;
		FeatureFrameMinimapButton_OffsetY = self.currentY;
	elseif (MouseIsOver(FeatureFrameMinimapButton)) then
		if (IsControlKeyDown()) and ( arg1 == "RightButton" ) then
			FeatureFrameMinimapButton_Reset();
		else
			ToggleFeatureFrame();
		end
	end
end

function FeatureFrameMinimapButton_OnHide(self)
	self.isMoving = false;
end

function FeatureFrameMinimapButton_OnUpdate(self)
	if (self.isMoving) then
		local mouseX, mouseY = GetCursorPosition();
		local centerX, centerY = Minimap:GetCenter();
		local scale = Minimap:GetEffectiveScale();
		mouseX = mouseX / scale;
		mouseY = mouseY / scale;
		local radius = (Minimap:GetWidth()/2) + (self:GetWidth()/3);
		local x = math.abs(mouseX - centerX);
		local y = math.abs(mouseY - centerY);
		local xSign = 1;
		local ySign = 1;
		if not (mouseX >= centerX) then
			xSign = -1;
		end
		if not (mouseY >= centerY) then
			ySign = -1;
		end
		--Sea.io.print(xSign*x,", ",ySign*y);
		local angle = math.atan(x/y);
		x = math.sin(angle)*radius;
		y = math.cos(angle)*radius;
		self.currentX = xSign*x;
		self.currentY = ySign*y;
		self:SetPoint("CENTER", "Minimap", "CENTER", self.currentX, self.currentY);
	end
end

function FeatureFrameMinimapButton_Reset()
	FeatureFrameMinimapButton:ClearAllPoints();
	FeatureFrameMinimapButton_OffsetX = -46.330;	-- Isler's WoWUI
	FeatureFrameMinimapButton_OffsetY = -66.848;	-- Isler's WoWUI
	FeatureFrameMinimapButton:SetPoint("CENTER", "Minimap", "CENTER", FeatureFrameMinimapButton_OffsetX, FeatureFrameMinimapButton_OffsetY);
end
