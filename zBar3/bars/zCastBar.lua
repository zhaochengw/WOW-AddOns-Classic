local _G = _G

zCastBar = CreateFrame("Frame", "zCastBar", UIParent)
-- zBar3:AddPlugin(zCastBar)
-- zBar3:AddBar(zCastBar)

function zCastBar:Load()
	self:ResetChildren()

	-- skin
	CastingBarFrame.Border:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small")
	CastingBarFrame.Flash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small")

	-- icon
	CastingBarFrame.Icon:Show()
	CastingBarFrame.Icon:SetWidth(24)
	CastingBarFrame.Icon:SetHeight(24)

	-- text
	CastingBarFrame.Text:ClearAllPoints()
	CastingBarFrame.Text:SetPoint("CENTER",0,1)

	-- width and height
	CastingBarFrame.Border:SetWidth(CastingBarFrame.Border:GetWidth() + 4)
	CastingBarFrame.Flash:SetWidth(CastingBarFrame.Flash:GetWidth() + 4)
	CastingBarFrame.BorderShield:SetWidth(CastingBarFrame.BorderShield:GetWidth() + 4)
	CastingBarFrame.Border:SetPoint("TOP", 0, 26)
	CastingBarFrame.Flash:SetPoint("TOP", 0, 26)
	CastingBarFrame.BorderShield:SetPoint("TOP", 0, 26)
	
	self:Hook()
end

function zCastBar:Hook()
	UIPARENT_MANAGED_FRAME_POSITIONS["CastingBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["FramerateLabel"] = nil
end

function zCastBar:ResetChildren()
	-- positon of CastingBarFrame and FramerateLabel
	CastingBarFrame:SetParent(self)
	CastingBarFrame:ClearAllPoints()
	CastingBarFrame:SetPoint("TOP",zCastBar,0,-3)
	FramerateLabel:SetParent(self)
	FramerateLabel:ClearAllPoints()
	FramerateLabel:SetPoint("BOTTOM",self:GetLabel(),"TOP")
	CastingBarFrame.Icon:SetPoint("RIGHT",CastingBarFrame,"LEFT",-6,0)
end

function zCastBar:UpdateButtons()
	if zBar3Data["zCastBar"].num > 1 then
		CastingBarFrame.Icon:Show()
	else
		CastingBarFrame.Icon:Hide()
	end
end

function zCastBar:UpdateLayouts()
	CastingBarFrame.Icon:ClearAllPoints()
	if zBar3Data["zCastBar"].invert then
		CastingBarFrame.Icon:SetPoint("LEFT",CastingBarFrame,"RIGHT",5,2)
	else
		CastingBarFrame.Icon:SetPoint("RIGHT",CastingBarFrame,"LEFT",-5,2)
	end
end

-- show texture when zTab:OnDragStart()
function zCastBar:SetShowTexture(show)
	if show then
		CastingBarFrame.fadeOut = nil
		CastingBarFrame:Show()
		CastingBarFrame:SetAlpha(1)
	else
		CastingBarFrame:Hide()
	end
end