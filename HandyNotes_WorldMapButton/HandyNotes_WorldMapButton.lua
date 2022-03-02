-- Handynotes Worldmap Button by fuba

local AddOnName, AddOn = ...

if not IsAddOnLoaded('HandyNotes') then return end
local WorldMapTooltip = WorldMapTooltip or GameTooltip;
local buildver = select(4,GetBuildInfo())
local isClassicWow = buildver < 20000
local isTBCC = (buildver > 20000) and (buildver < 30000)

local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_WorldMapButton", false);

local iconDefault = [[Interface\AddOns\]] .. AddOnName .. [[\Buttons\Default]];
local iconDisabled = [[Interface\AddOns\]] .. AddOnName .. [[\Buttons\Disabled]];

local point, relativeTo, relativePoint, xOfs, yOfs

local ButtonName = "HandyNotesWorldMapButton"
local btn = _G[ButtonName]

local function SetIconTexture()
	local btn = _G[ButtonName]
	if not btn then return end
	if HandyNotes then
		if HandyNotes:IsEnabled() then
			btn:SetNormalTexture(iconDefault);
		else
			btn:SetNormalTexture(iconDisabled);
		end
	else
		btn:Hide();
	end
end

local function SetIconTooltip(IsRev)
	local btn = _G[ButtonName]
	if not btn then return end
	if not WorldMapTooltip then return end
	WorldMapTooltip:Hide();
	WorldMapTooltip:SetOwner(btn, "ANCHOR_BOTTOMLEFT");
	if HandyNotes:IsEnabled() then
		WorldMapTooltip:AddLine(L["TEXT_TOOLTIP_HIDE_ICONS"], nil, nil, nil, nil, 1 );
	else
		WorldMapTooltip:AddLine(L["TEXT_TOOLTIP_SHOW_ICONS"], nil, nil, nil, nil, 1 );
	end
	WorldMapTooltip:Show();
end

local function btnOnEnter(self, motion)
	SetIconTexture();
	SetIconTooltip(false);
end

local function btnOnLeave(self, motion)
	SetIconTexture();
	if WorldMapTooltip then
		WorldMapTooltip:Hide();
	end
end

local function btnOnClick(self)
	local db = LibStub("AceDB-3.0"):New("HandyNotesDB", defaults).profile;

	if HandyNotes:IsEnabled() then
		db.enabled = false
		HandyNotes:Disable();
	else
		db.enabled = true
		HandyNotes:Enable();
	end
	SetIconTexture();
	SetIconTooltip(false);
end

hooksecurefunc(HandyNotes, "OnEnable", function(self)
	SetIconTexture()
end)

hooksecurefunc(HandyNotes, "OnDisable", function(self)
	SetIconTexture()
end)

btn = _G[ButtonName] or CreateFrame("Button", ButtonName, WorldMapFrame, "UIPanelButtonTemplate");
btn:RegisterForClicks("AnyUp");
btn:SetText("");
btn:SetScript("OnClick", btnOnClick);
btn:SetScript("OnEnter", btnOnEnter);
btn:SetScript("OnLeave", btnOnLeave);

WorldMapFrame:HookScript("OnShow", function(self)
	local alignmentFrame = _G.WorldMapFrame
	local parent = _G.WorldMapFrame
	
	if isClassicWow then
		alignmentFrame = _G.WorldMapFrameCloseButton;
		parent = alignmentFrame:GetParent();
	elseif isTBCC then
		alignmentFrame = _G.WorldMapFrameCloseButton;
		parent = alignmentFrame:GetParent();
	else
		alignmentFrame = _G.WorldMapFrame.BorderFrame.MaximizeMinimizeFrame or _G.WorldMapFrame;
		parent = alignmentFrame:GetParent();
	end
	if (not alignmentFrame) or (not parent) then return end
	
	btn = _G[ButtonName] or CreateFrame("Button", ButtonName, parent, "UIPanelButtonTemplate");
	btn:ClearAllPoints();
	btn:SetPoint("RIGHT", alignmentFrame, "LEFT", 0, 0);
	btn:SetFrameStrata(alignmentFrame:GetFrameStrata());
	btn:SetFrameLevel(5000);
	btn:SetSize(16, 16);
	
	if IsAddOnLoaded('Leatrix_Maps') then
		if isClassicWow then
			if LeaMapsDB and (LeaMapsDB["NoMapBorder"] == "On") then
				btn = _G[ButtonName] or CreateFrame("Button", ButtonName, WorldMapFrame, "UIPanelButtonTemplate");
				btn:ClearAllPoints();
				btn:SetPoint("RIGHT", WorldMapFrameCloseButton, "LEFT", 0, 0);
				btn:SetFrameStrata(WorldMapFrameCloseButton:GetFrameStrata());
				btn:SetFrameLevel(5000);
				btn:SetSize(18, 18);
			end
		else
			if LeaMapsDB and (LeaMapsDB["NoMapBorder"] == "On") then
				btn = _G[ButtonName] or CreateFrame("Button", ButtonName, WorldMapFrame, "UIPanelButtonTemplate");
				btn:ClearAllPoints();
				btn:SetPoint("TOPLEFT", WorldMapFrame.ScrollContainer, "TOPLEFT", 5, -5);
				btn:SetFrameStrata(WorldMapFrame.ScrollContainer:GetFrameStrata());
				btn:SetFrameLevel(5000);
				btn:SetSize(24, 24);
			end
		end
	end
	btn:Show();	
	SetIconTexture();
end)
