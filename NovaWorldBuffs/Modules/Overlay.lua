-------------------
---NovaWorldBuffs--
-------------------

---The over frame name and options keep the ashenvale name even though this overlay does more than just ashenvale now.
---This is so the users config settings carry over to the new version.

local addonName, addon = ...;
local NWB = addon.a;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");
local overlay;

local function updateOverlay()
	local text = "";
	if (NWB.db.global.overlayShowAshenvale) then
		local ashenvaleText, ashenvaleTimeLeft = NWB:getAshenvaleTimeString(nil, true);
		if (ashenvaleTimeLeft < 900) then
			text = text .. "|cFF00C800" .. ashenvaleText .. "|r";
		else
			text = text .. ashenvaleText;
		end
		text = text .. "\n";
	end
	if (NWB.db.global.overlayShowStranglethorn) then
		local stranglethornText, stranglethornTimeLeftm, stranglethornType, stranglethornRealTimeLeft = NWB:getStranglethornTimeString(nil, true);
		if (stranglethornRealTimeLeft < 900) then
			text = text .. "|cFF00C800" .. stranglethornText .. "|r";
		else
			text = text .. "" .. stranglethornText;
		end
	end
	overlay.fsBottom:SetText("|cFFFFFF00" .. text);
end

local function loadOverlay()
	if (not overlay) then
		local frame = CreateFrame("Frame", "NWB_AshenvaleOverlay", UIParent);
		frame:SetFrameLevel(8);
		frame.background = CreateFrame("Frame", "NWB_AshenvaleOverlayBackground", frame, "BackdropTemplate");	
		frame.background:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8x8",
		});
		frame.background:SetBackdropColor(0, 0, 0);
		frame.background:SetAlpha(0);
		frame.background:SetAllPoints();
		frame.background:SetFrameLevel(7);
		frame:SetMovable(true);
		frame:EnableMouse(true);
		frame:SetUserPlaced(false);
		if (NWB.db.global[frame:GetName() .. "_point"]) then
			frame.ignoreFramePositionManager = true;
			frame:ClearAllPoints();
			frame:SetPoint(NWB.db.global[frame:GetName() .. "_point"], nil, NWB.db.global[frame:GetName() .. "_relativePoint"],
					NWB.db.global[frame:GetName() .. "_x"], NWB.db.global[frame:GetName() .. "_y"]);
			frame:SetUserPlaced(false);
		else
			frame:SetPoint("CENTER", UIParent, 0, 100);
		end
		frame:SetSize(80, 75);
		frame:SetScript("OnMouseDown", function(self, button)
			if (button == "LeftButton" and not self.isMoving) then
				self:StartMoving();
				self.isMoving = true;
			end
		end)
		frame:SetScript("OnMouseUp", function(self, button)
			if (button == "LeftButton" and self.isMoving) then
				self:StopMovingOrSizing();
				self.isMoving = false;
				frame:SetUserPlaced(false);
				NWB.db.global[frame:GetName() .. "_point"], _, NWB.db.global[frame:GetName() .. "_relativePoint"], 
						NWB.db.global[frame:GetName() .. "_x"], NWB.db.global[frame:GetName() .. "_y"] = frame:GetPoint();
			end
		end)
		frame:SetScript("OnHide", function(self)
			if (self.isMoving) then
				self:StopMovingOrSizing();
				self.isMoving = false;
			end
		end)
		frame.lastUpdate = 0;
		frame:SetScript("OnUpdate", function(self)
			--Update throddle.
			if (GetTime() - frame.lastUpdate > 1) then
				frame.lastUpdate = GetTime();
				updateOverlay();
			end
		end)
		frame:SetScript("OnEnter", function(self)
			frame.background:SetAlpha(0.5);
		end);
		frame:SetScript("OnLeave", function(self)
			frame.background:SetAlpha(0);
		end);
		--frame:SetFrameStrata("HIGH");
		frame:SetClampedToScreen(true);
		frame.fsTitle = frame:CreateFontString("NWB_AshenvaleOverlayFSTitle", "ARTWORK");
		frame.fsTitle:SetPoint("CENTER", 0, 23);
		frame.fsTitle:SetFont("Fonts\\FRIZQT__.ttf", 13, "OUTLINE");
		--frame.fsTitle:SetText("|cFFFFFF00" .. L["Ashenvale"]);
		frame.fsBottom = frame:CreateFontString("NWB_AshenvaleOverlayFSBottom", "ARTWORK");
		frame.fsBottom:SetPoint("TOP", frame, "TOP", 0, -52);
		frame.fsBottom:SetFont("Fonts\\FRIZQT__.ttf", 13, "OUTLINE");
		--[[frame.fsBottomLeft = frame:CreateFontString("NWB_AshenvaleOverlayFSBottomLeft", "ARTWORK");
		frame.fsBottomLeft:SetPoint("CENTER", -18, -18);
		frame.fsBottomLeft:SetFont("Fonts\\FRIZQT__.ttf", 13, "OUTLINE");
		frame.fsBottomRight = frame:CreateFontString("NWB_AshenvaleOverlayFSBottomRight", "ARTWORK");
		frame.fsBottomRight:SetPoint("CENTER", 23, -18);
		frame.fsBottomRight:SetFont("Fonts\\FRIZQT__.ttf", 13, "OUTLINE");]]
		frame.textureLeft = frame:CreateTexture(nil, "ARTWORK");
		frame.textureLeft:SetTexture("Interface\\worldstateframe\\alliancetower.blp");
		frame.textureLeft:SetPoint("CENTER", -14, -6);
		frame.textureLeft:SetSize(42, 42);
		frame.textureRight = frame:CreateTexture(nil, "ARTWORK");
		frame.textureRight:SetTexture("Interface\\worldstateframe\\hordetower.blp");
		frame.textureRight:SetPoint("CENTER", 26, -6);
		frame.textureRight:SetSize(42, 42);
		frame:Hide();
		overlay = frame;
	end
	NWB:setOverlayState();
end

function NWB:setOverlayState()
	if (not overlay) then
		return;
	end
	if (NWB.db.global.showAshenvaleOverlay) then
		overlay:Show();
	else
		overlay:Hide();
	end
	if (NWB.db.global.lockAshenvaleOverlay) then
		overlay:EnableMouse(false);
	else
		overlay:EnableMouse(true);
	end
	NWB:refreshOverlay();
end

function NWB:refreshOverlay()
	if (not overlay) then
		return;
	end
	overlay:SetScale(NWB.db.global.ashenvaleOverlayScale);
	overlay.fsTitle:SetFont(NWB.LSM:Fetch("font", NWB.db.global.ashenvaleOverlayFont), 13, "OUTLINE");
	overlay.fsBottom:SetFont(NWB.LSM:Fetch("font", NWB.db.global.ashenvaleOverlayFont), 13, "OUTLINE");
	--overlay.fsBottomLeft:SetFont(NWB.LSM:Fetch("font", NWB.db.global.ashenvaleOverlayFont), 13, "OUTLINE");
	--overlay.fsBottomRight:SetFont(NWB.LSM:Fetch("font", NWB.db.global.ashenvaleOverlayFont), 13, "OUTLINE");
	if (NWB.db.global.overlayShowArt) then
		overlay.textureLeft:Show();
		overlay.textureRight:Show();
	else
		overlay.textureLeft:Hide();
		overlay.textureRight:Hide();
	end
	updateOverlay();
end

function NWB:loadOverlay()
	if (not NWB.isSOD) then
		return;
	end
	loadOverlay();
end