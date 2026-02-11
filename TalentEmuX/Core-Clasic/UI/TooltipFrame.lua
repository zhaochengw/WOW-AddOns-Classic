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
	local pcall = pcall;
	local type = type;
	local next = next;
	local random = math.random;
	local CreateFrame = CreateFrame;
	local _G = _G;
	local UIParent = UIParent;

-->
	local l10n = CT.l10n;

-->
MT.BuildEnv('UI-TooltipFrame');
-->		predef
-->		TooltipFrame
	function MT.UI.CreateTooltipFrame()
		local TooltipFrame = CreateFrame('FRAME', nil, UIParent);
		TooltipFrame:SetSize(1, 1);
		TooltipFrame:SetFrameStrata("FULLSCREEN");
		TooltipFrame:SetClampedToScreen(true);
		TooltipFrame:EnableMouse(false);
		VT.__dep.uireimp._SetSimpleBackdrop(TooltipFrame, 0, 1, 0.0, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0, 1.0);
		TooltipFrame:Hide();
		TooltipFrame:Show();

		local Tooltip1LabelLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
		Tooltip1LabelLeft:SetPoint("TOPLEFT", 6, -6);
		local Tooltip1LabelRight = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
		Tooltip1LabelRight:SetPoint("TOPRIGHT", -6, -6);
		local Tooltip1Name = "Emu_Tooltip1" .. (MT.GetUnifiedTime() + 1) .. random(1000000, 10000000);
		local Tooltip1 = CreateFrame('GAMETOOLTIP', Tooltip1Name, UIParent, "GameTooltipTemplate");
		Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
		if Tooltip1.NineSlice ~= nil then
			Tooltip1.NineSlice:SetAlpha(0.0);
			Tooltip1.NineSlice:Hide();
		end
		for _, v in next, { Tooltip1:GetRegions() } do
			if v:GetObjectType() == 'Texture' then
				v:Hide();
			end
		end
		Tooltip1.TextLeft1 = Tooltip1.TextLeft1 or _G[Tooltip1Name .. "TextLeft1"];
		Tooltip1.TextRight1 = Tooltip1.TextRight1 or _G[Tooltip1Name .. "TextRight1"];
		Tooltip1.TextLeft2 = Tooltip1.TextLeft2 or _G[Tooltip1Name .. "TextLeft2"];
		Tooltip1.TextRight2 = Tooltip1.TextRight2 or _G[Tooltip1Name .. "TextRight2"];

		local Tooltip1FooterLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
		Tooltip1FooterLeft:SetPoint("TOPLEFT", Tooltip1, "BOTTOMLEFT", 12, 6);
		local Tooltip1FooterRight = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
		-- Tooltip1FooterRight:SetPoint("TOPRIGHT", Tooltip1, "BOTTOMRIGHT", -12, 6);
		Tooltip1FooterRight:SetPoint("TOP", Tooltip1, "BOTTOM", 0, 6);
		Tooltip1FooterRight:SetPoint("RIGHT", TooltipFrame, "RIGHT", -6, 0);

		local Tooltip2LabelLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
		Tooltip2LabelLeft:SetPoint("TOPLEFT", Tooltip1FooterLeft, "BOTTOMLEFT", -12, -4);
		local Tooltip2LabelRight = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
		-- Tooltip2LabelRight:SetPoint("TOPRIGHT", Tooltip1FooterRight, "BOTTOMRIGHT", 0, -4);
		Tooltip2LabelRight:SetPoint("TOP", Tooltip1FooterRight, "BOTTOM", 0, -4);
		Tooltip2LabelRight:SetPoint("RIGHT", TooltipFrame, "RIGHT", -6, 0);
		local Tooltip2Name = "Emu_Tooltip2" .. (MT.GetUnifiedTime() + 100) .. random(1000000, 10000000);
		local Tooltip2 = CreateFrame('GAMETOOLTIP', Tooltip2Name, UIParent, "GameTooltipTemplate");
		Tooltip2:SetPoint("TOPLEFT", Tooltip2LabelLeft, "BOTTOMLEFT", 0, 6);
		if Tooltip2.NineSlice ~= nil then
			Tooltip2.NineSlice:SetAlpha(0.0);
			Tooltip2.NineSlice:Hide();
		end
		for _, v in next, { Tooltip2:GetRegions() } do
			if v:GetObjectType() == 'Texture' then
				v:Hide();
			end
		end
		Tooltip2.TextLeft1 = Tooltip2.TextLeft1 or _G[Tooltip2Name .. "TextLeft1"];
		Tooltip2.TextRight1 = Tooltip2.TextRight1 or _G[Tooltip2Name .. "TextRight1"];
		Tooltip2.TextLeft2 = Tooltip2.TextLeft2 or _G[Tooltip2Name .. "TextLeft2"];
		Tooltip2.TextRight2 = Tooltip2.TextRight2 or _G[Tooltip2Name .. "TextRight2"];

		local Tooltip2FooterLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
		Tooltip2FooterLeft:SetPoint("TOPLEFT", Tooltip2, "BOTTOMLEFT", 12, 6);
		local Tooltip2FooterRight = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
		-- Tooltip2FooterRight:SetPoint("TOPRIGHT", Tooltip2, "BOTTOMRIGHT", -12, 6);
		Tooltip2FooterRight:SetPoint("TOP", Tooltip2, "BOTTOM", 0, 6);
		Tooltip2FooterRight:SetPoint("RIGHT", TooltipFrame, "RIGHT", -6, 0);

		Tooltip1LabelLeft:SetText("");
		Tooltip1LabelRight:SetText("");
		Tooltip2LabelLeft:SetText("");
		Tooltip2LabelRight:SetText("");

		Tooltip1FooterLeft:SetTextColor(0.25, 0.5, 1.0, 1.0);
		Tooltip1FooterRight:SetTextColor(0.25, 0.5, 1.0, 1.0);
		Tooltip2FooterLeft:SetTextColor(0.25, 0.5, 1.0, 1.0);
		Tooltip2FooterRight:SetTextColor(0.25, 0.5, 1.0, 1.0);

		Tooltip1FooterLeft:SetText("id");
		Tooltip1FooterRight:SetText("");
		Tooltip2FooterLeft:SetText("id");
		Tooltip2FooterRight:SetText("");

		TooltipFrame.Tooltip1LabelLeft = Tooltip1LabelLeft;
		TooltipFrame.Tooltip1LabelRight = Tooltip1LabelRight;
		TooltipFrame.Tooltip1 = Tooltip1;

		TooltipFrame.Tooltip1FooterLeft = Tooltip1FooterLeft;
		TooltipFrame.Tooltip1FooterRight = Tooltip1FooterRight;

		TooltipFrame.Tooltip2LabelLeft = Tooltip2LabelLeft;
		TooltipFrame.Tooltip2LabelRight = Tooltip2LabelRight;
		TooltipFrame.Tooltip2 = Tooltip2;

		TooltipFrame.Tooltip2FooterLeft = Tooltip2FooterLeft;
		TooltipFrame.Tooltip2FooterRight = Tooltip2FooterRight;

		if _G.GetCurrentRegion() == 3 then	--	EU
			local function OnEvent(self, event, addon)
				--	SetSpellTooltip(self, id)
				if addon:lower() == "woweucn_tooltips" and _G.SetSpellTooltip ~= nil and type(_G.SetSpellTooltip) == 'function' and pcall(_G.SetSpellTooltip, Tooltip1, 5) then
					TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip = _G.SetSpellTooltip;
					Tooltip1:Hide();
					TooltipFrame:UnregisterEvent("ADDON_LOADED");
					return true;
				else
					return false;
				end
			end
			if C_AddOns.IsAddOnLoaded("WoWeuCN_Tooltips") and OnEvent(TooltipFrame, "ADDON_LOADED", "WoWeuCN_Tooltips") then
			else
				TooltipFrame:RegisterEvent("ADDON_LOADED");
				TooltipFrame:SetScript("OnEvent", OnEvent);
			end
		end

		return TooltipFrame;
	end

-->
