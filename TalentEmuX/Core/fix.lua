--[[--
	by ALA
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

--		upvalue
	local next = next;
	local GetAddOnInfo = C_AddOns and C_AddOns.GetAddOnInfo or GetAddOnInfo;
	local IsAddOnLoaded = C_AddOns and C_AddOns.IsAddOnLoaded or IsAddOnLoaded;
	local CreateFrame = CreateFrame;
	local _G = _G;

-->
	local l10n = CT.l10n;

-->		constant
-->
-- MT.BuildEnv('FIX');
-->		predef
-->		FIX
	--
	local function Fix38000InspectFrame()
		if InspectFrame then
			if InspectPVPFrame then
				InspectPVPFrame:ClearAllPoints();
				InspectPVPFrame:SetPoint("TOPLEFT", InspectFrame, "TOPLEFT",-16,16);
				InspectPVPFrame:SetPoint("BOTTOMRIGHT", InspectFrame,"BOTTOMRIGHT",-16,16);
			end
			if InspectTalentFrame then
				if InspectTalentFrameTab1 then
					InspectTalentFrameTab1:ClearAllPoints();
					InspectTalentFrameTab1:SetPoint("TOPLEFT", InspectTalentFrame, "TOPLEFT", 70, -28);
				end
				if InspectTalentFramePointsBar and InspectTalentFrameScrollFrame then
					InspectTalentFramePointsBar:ClearAllPoints();
					InspectTalentFramePointsBar:SetPoint("BOTTOM", InspectFrame, "BOTTOM", 0, 4);
					InspectTalentFrameScrollFrame:ClearAllPoints();
					InspectTalentFrameScrollFrame:SetPoint("BOTTOM", InspectTalentFramePointsBar, "TOP", 0, 0);
					InspectTalentFrameScrollFrame:SetPoint("TOP", InspectTalentFrame, "TOP", -14, -69);
				end
				for _, r in next, { InspectTalentFrame:GetRegions() } do
					if r:GetObjectType():upper() == 'TEXTURE' then
						r:Hide();
					end
				end
				if InspectTalentFrameBackgroundTopLeft then
					InspectTalentFrameBackgroundTopLeft:ClearAllPoints();
					InspectTalentFrameBackgroundTopLeft:SetPoint("TOP", InspectTalentFrame, "TOP", -35, -60);
					InspectTalentFrameBackgroundTopLeft:Show();
				end
				if InspectTalentFrameBackgroundTopRight then
					InspectTalentFrameBackgroundTopRight:Show();
				end
				if InspectTalentFrameBackgroundBottomLeft then
					InspectTalentFrameBackgroundBottomLeft:Show();
				end
				if InspectTalentFrameBackgroundBottomRight then
					InspectTalentFrameBackgroundBottomRight:Show();
				end
				if InspectTalentFrameCloseButton then
					InspectTalentFrameCloseButton:Hide();
				end
			end
			return true;
		end
		return false;
	end

	MT.RegisterOnInit('FIX', function(LoggedIn)
	end);
	MT.RegisterOnLogin('FIX', function(LoggedIn)
		if CT.TOCVERSION >= 38000 and CT.TOCVERSION < 40000 then
			if IsAddOnLoaded("Blizzard_InspectUI") and Fix38000InspectFrame() then
			else
				local Driver = CreateFrame('FRAME', nil, UIParent);
				Driver:RegisterEvent("ADDON_LOADED");
				Driver:SetScript("OnEvent", function(Driver, event, addon)
					if addon:upper() == "BLIZZARD_INSPECTUI" then
						Fix38000InspectFrame();
					end
				end);
			end
		end
	end);

-->
