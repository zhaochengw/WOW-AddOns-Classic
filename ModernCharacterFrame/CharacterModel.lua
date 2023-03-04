----------------------------------------------------------------------------------
-------------------- FUNCTIONS FOR CHARACTER MODEL FRAME -------------------------
----------------------------------------------------------------------------------

function MCF_CharacterModelFrame_OnMouseUp (self, button)
	if ( button == "LeftButton" ) then
		AutoEquipCursorItem();
	end
	Model_OnMouseUp(self, button);
end

-- Editing CharacterModelFrame
function MCF_SetUpCharacterModelFrame(frame)
    frame:SetSize(231, 320);
    frame:SetPoint("TOPLEFT", PaperDollFrame, 65, -78); -- Added x+16, y-12 because anchors in Cata were in another place

    -- Creating background textures and overlay
    frame:CreateTexture("$parentBackgroundTopLeft", "BACKGROUND", "MCF-CharacterModelFrameBackgroundTopLeft");
    frame:CreateTexture("$parentBackgroundTopRight", "BACKGROUND", "MCF-CharacterModelFrameBackgroundTopRight");
    frame:CreateTexture("$parentBackgroundBotLeft", "BACKGROUND", "MCF-CharacterModelFrameBackgroundBotLeft");
    frame:CreateTexture("$parentBackgroundBotRight", "BACKGROUND", "MCF-CharacterModelFrameBackgroundBotRight");
    frame:CreateTexture("$parentBackgroundOverlay", "BORDER", "MCF-CharacterModelFrameBackgroundOverlay");
    -- Creating borders
    frame:CreateTexture("PaperDollInnerBorderTopLeft", "OVERLAY", "MCF-PaperDollInnerBorderTopLeftTemplate");
    frame:CreateTexture("PaperDollInnerBorderTopRight", "OVERLAY", "MCF-PaperDollInnerBorderTopRightTemplate");
    frame:CreateTexture("PaperDollInnerBorderBottomLeft", "OVERLAY", "MCF-PaperDollInnerBorderBottomLeftTemplate");
    frame:CreateTexture("PaperDollInnerBorderBottomRight", "OVERLAY", "MCF-PaperDollInnerBorderBottomRightTemplate");
    frame:CreateTexture("PaperDollInnerBorderLeft", "OVERLAY", "MCF-PaperDollInnerBorderLeftTemplate");
    frame:CreateTexture("PaperDollInnerBorderRight", "OVERLAY", "MCF-PaperDollInnerBorderRightTemplate");
    frame:CreateTexture("PaperDollInnerBorderTop", "OVERLAY", "MCF-PaperDollInnerBorderTopTemplate");
    frame:CreateTexture("PaperDollInnerBorderBottom", "OVERLAY", "MCF-PaperDollInnerBorderBottomTemplate");
    frame:CreateTexture("PaperDollInnerBorderBottom2", "OVERLAY", "MCF-PaperDollInnerBorderBottom2Template");

    -- Creating ControlFrame
    local ControlPanel = CreateFrame("Frame", "$parentControlFrame", CharacterModelFrame, "MCF-CharacterModelControlFrameTemplate");

    MCF_CharacterModelSetScripts(frame);
end

function MCF_SetPaperDollBackground(model, unit)
	local race, fileName = UnitRace(unit);
	local texture = DressUpTexturePath(fileName);
	-- Hack to make troll's texture actual troll's instead of orc's. Need to check other races (like gnomes). Files are in the game.
	if ( fileName == "Troll" ) then
		texture = "Interface\\DressUpFrame\\DressUpBackground-Troll";
    elseif ( fileName == "Gnome" ) then
        texture = "Interface\\DressUpFrame\\DressUpBackground-Gnome";
    end

	model.BackgroundTopLeft:SetTexture(texture..1);
	model.BackgroundTopRight:SetTexture(texture..2);
	model.BackgroundBotLeft:SetTexture(texture..3);
	model.BackgroundBotRight:SetTexture(texture..4);
	
	-- HACK - Adjust background brightness for different races
	if ( strupper(fileName) == "BLOODELF") then
		model.BackgroundOverlay:SetAlpha(0.8);
	elseif (strupper(fileName) == "NIGHTELF") then
		model.BackgroundOverlay:SetAlpha(0.6);
	elseif ( strupper(fileName) == "SCOURGE") then
		model.BackgroundOverlay:SetAlpha(0.3);
	elseif ( strupper(fileName) == "TROLL" or strupper(fileName) == "ORC") then
		model.BackgroundOverlay:SetAlpha(0.6);
	--[[ elseif ( strupper(fileName) == "WORGEN" ) then
		model.BackgroundOverlay:SetAlpha(0.5);
	elseif ( strupper(fileName) == "GOBLIN" ) then
		model.BackgroundOverlay:SetAlpha(0.6); ]]
	else
		model.BackgroundOverlay:SetAlpha(0.7);
	end
    MCF_PaperDollBgDesaturate(1);
end
function MCF_PaperDollBgDesaturate(on)
	CharacterModelFrameBackgroundTopLeft:SetDesaturated(on);
	CharacterModelFrameBackgroundTopRight:SetDesaturated(on);
	CharacterModelFrameBackgroundBotLeft:SetDesaturated(on);
	CharacterModelFrameBackgroundBotRight:SetDesaturated(on);
end

function MCF_CharacterModelSetScripts(frame)
    frame:SetScript("OnLoad", function(self) Model_OnLoad(self, MODELFRAME_MAX_PLAYER_ZOOM, nil, nil, MCF_CharacterModelFrame_OnMouseUp); end);
    frame:SetScript("OnEvent", Model_OnEvent);
    frame:SetScript("OnMouseUp", MCF_CharacterModelFrame_OnMouseUp);
    frame:SetScript("OnMouseDown", MCF_CharacterModelFrame_OnMouseDown);
    frame:SetScript("OnMouseWheel", Model_OnMouseWheel);
    frame:SetScript("OnEnter", function(self) self.controlFrame:Show(); end);
    frame:SetScript("OnLeave", MCF_CharacterModelFrame_OnLeave);
    frame:SetScript("OnHide", MCF_CharacterModelFrame_OnHide);
end

function MCF_CharacterModelFrame_OnMouseUp(self, button)
    if ( button == "RightButton" and self.panning ) then
        Model_StopPanning(self);
    elseif ( self.mouseDown ) then
        self.onMouseUpFunc(self, button);
    end
end
function MCF_CharacterModelFrame_OnMouseDown(self, button)
    if ( button == "RightButton" and not self.mouseDown ) then
        Model_StartPanning(self);
    else
        Model_OnMouseDown(self, button);
    end
end
function MCF_CharacterModelFrame_OnLeave(self)
    if ( not self.controlFrame:IsMouseOver() and not ModelPanningFrame:IsShown() ) then
        self.controlFrame:Hide();
    end
end
function MCF_CharacterModelFrame_OnHide(self)
    if ( self.panning ) then
        Model_StopPanning(self);
    end
    self.mouseDown = false;
    self.controlFrame:Hide();
end
