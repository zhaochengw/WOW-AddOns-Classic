local _, ns = ...
local oGlow = ns.oGlow

local argcheck = oGlow.argcheck
local colorTable = ns.colorTable

local createBorder = function(self, point)
	local bc = self.oGlowBorder
	if(not bc) then
		if(not self:IsObjectType'Frame') then
			bc = self:GetParent():CreateTexture(nil, 'OVERLAY')
		else
			bc = self:CreateTexture(nil, "OVERLAY")
		end

		bc:SetTexture"Interface\\Buttons\\UI-ActionButton-Border"
		bc:SetBlendMode"ADD"
		bc:SetAlpha(.8)

		bc:SetWidth(70)
		bc:SetHeight(70)

		bc:SetPoint("CENTER", point or self)
		self.oGlowBorder = bc
	end

	return bc
end

local createFontString = function(self, point)
	local bc = self.oGlowDurability
	if(not bc) then
		if(not self:IsObjectType'Frame') then
			bc = self:GetParent():CreateFontString(nil, 'OVERLAY')
		else
			bc = self:CreateFontString(nil, "OVERLAY")
		end

		local font, _, flags = NumberFontNormal:GetFont()
		bc:SetFont(font, 12, flags)
		bc:SetPoint("CENTER", point or self, "BOTTOM", 1, 8)

		self.oGlowDurability = bc
	end

	return bc
end

local borderDisplay = function(frame, color)
	local text = createFontString(frame)

	if(color) then
		local bc = createBorder(frame)
		local rgb = colorTable[color]

		if(rgb) then
			bc:SetVertexColor(rgb[1], rgb[2], rgb[3])
			bc:Show()
		end

		return true
	elseif(frame.oGlowBorder) then
		frame.oGlowBorder:Hide()
	end
end

oGlow:RegisterDisplay('Border', borderDisplay)
