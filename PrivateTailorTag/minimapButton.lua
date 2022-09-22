local _addonName, _addon = ...;
--local L = _addon:GetLocalization();

--------------------------------
-- Setup UI elements
--------------------------------
local mmicon = CreateFrame("Button", "private_tailor_tag", Minimap);

mmicon:SetClampedToScreen(true);
mmicon:SetMovable(true);
mmicon:EnableMouse(true);
mmicon:RegisterForDrag("LeftButton");
mmicon:RegisterForClicks("LeftButtonUp", "RightButtonUp");
mmicon:SetFrameStrata("LOW");
mmicon:SetWidth(31);
mmicon:SetHeight(31);
mmicon:SetFrameLevel(9);
mmicon:SetHighlightTexture([[Interface\Minimap\UI-Minimap-ZoomButton-Highlight]]);
mmicon:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 0, 0);
mmicon.overlay = mmicon:CreateTexture(nil, 'OVERLAY');
mmicon.overlay:SetWidth(53);
mmicon.overlay:SetHeight(53);
mmicon.overlay:SetTexture([[Interface\Minimap\MiniMap-TrackingBorder]]);
mmicon.overlay:SetPoint("TOPLEFT", 0,0);
mmicon.icon = mmicon:CreateTexture(nil, "BACKGROUND");
mmicon.icon:SetWidth(20);
mmicon.icon:SetHeight(20);
mmicon.icon:SetTexture("Interface\\FriendsFrame\\Battlenet-Portrait");
mmicon.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95);
mmicon.icon:SetPoint("CENTER",0,1);


--------------------------------
-- UI functions
--------------------------------

-- Open on click
mmicon:SetScript("OnClick", function(self, arg1)
	PTTGUI();
end)

-- Tooltip
mmicon:SetScript("OnEnter", function(self, arg1)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT", 3, -10);
	GameTooltip:AddLine("Private tailor tag")
	GameTooltip:AddLine("点击打开玩家标签");
	GameTooltip:Show();
end)
mmicon:SetScript("OnLeave", function(self, arg1)
	GameTooltip:Hide();
end)

--- Snap icon to minimap
-- @param refX The x coordinate of the reference point
-- @param refY The y coordinate of the reference point
local function SnapPosition(refX, refY)
	local distTarget = (Minimap:GetWidth()/2 + mmicon:GetWidth()/2 - 5);
	local mmX, mmY = Minimap:GetCenter();
	local angle = math.atan2( refY-mmY, refX-mmX );
	mmicon:ClearAllPoints();
	mmicon:SetPoint("CENTER", Minimap, "CENTER", (math.cos(angle) * distTarget), (math.sin(angle) * distTarget));
end

local function OnUpdateHandler()
	local uiScale, cx, cy = UIParent:GetEffectiveScale(), GetCursorPosition();
	SnapPosition(cx/uiScale, cy/uiScale);
end

mmicon:SetScript("OnDragStart", function(self)

	self:SetScript("OnUpdate", OnUpdateHandler);

	self:StartMoving();
end)

mmicon:SetScript("OnDragStop", function(self) 
	self:SetScript("OnUpdate", nil);
	self:StopMovingOrSizing();
end)


--------------------------------
-- Addon functions
--------------------------------

--- Snap minimap button to minimap from current position
function _addon:MinimapButtonSnap()
	local x, y = mmicon:GetCenter();
	SnapPosition(x, y);
end

--- Update texture to reflect state
function _addon:MinimapButtonUpdate()

        mmicon:Show();

end