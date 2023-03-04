--非战斗状态中允许shift+左键拖动焦点头像
local function UnitFramesPlus_FocusShiftDrag()
    FocusFrame:SetScript("OnMouseDown", function(self, elapsed)
        if UnitFramesPlusDB["focus"]["movable"] == 1 then
            if IsShiftKeyDown() and (not InCombatLockdown()) then
                FocusFrame:StartMoving();
                UnitFramesPlusVar["focus"]["moving"] = 1;
            end
        end
    end)

    FocusFrame:SetScript("OnMouseUp", function(self, elapsed)
        if UnitFramesPlusVar["focus"]["moving"] == 1 then
            FocusFrame:StopMovingOrSizing();
            UnitFramesPlusVar["focus"]["moving"] = 0;
        end
    end)

    FocusFrame:SetClampedToScreen(1);
end

--头像缩放
function UnitFramesPlus_FocusFrameScaleSet(newscale)
    -- local oldscale = oldscale or UnitFramesPlusDB["focus"]["scale"];
    local oldscale = FocusFrame:GetScale();
    local newscale = newscale or UnitFramesPlusDB["focus"]["scale"];
    local point, relativeTo, relativePoint, offsetX, offsetY = FocusFrame:GetPoint();
    FocusFrame:SetScale(newscale);
    FocusFrame:ClearAllPoints();
    FocusFrame:SetPoint(point, relativeTo, relativePoint, offsetX*oldscale/newscale, offsetY*oldscale/newscale);
    if UnitFramesPlusDB["focus"]["portrait"] == 1 and UnitFramesPlusDB["focus"]["portraittype"] == 1 then
        UnitFramesPlus_FocusPortraitDisplayUpdate();
    end
end

function UnitFramesPlus_FocusFrameScale(newscale)
    if not InCombatLockdown() then
        UnitFramesPlus_FocusFrameScaleSet(newscale);
    else
        local func = {};
        func.name = "UnitFramesPlus_FocusFrameScaleSet";
        func.callback = function()
            UnitFramesPlus_FocusFrameScaleSet(newscale);            
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--状态数值
--[[
local FocusHPMPText = CreateFrame("Frame", "UFP_FocusHPMPText", FocusFrame);

FocusHPMPText.HP = FocusHPMPText:CreateFontString("UFP_FocusHPText", "OVERLAY", "TextStatusBarText");
FocusHPMPText.HP:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE");
FocusHPMPText.HP:SetTextColor(1, 1, 1);
FocusHPMPText.HP:SetAlpha(1);

FocusHPMPText.MP = FocusHPMPText:CreateFontString("UFP_FocusMPText", "OVERLAY", "TextStatusBarText");
FocusHPMPText.MP:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE");
FocusHPMPText.MP:SetTextColor(1, 1, 1);
FocusHPMPText.MP:SetAlpha(1);
FocusHPMPText.MP:ClearAllPoints();
FocusHPMPText.MP:SetPoint("CENTER", FocusFrameManaBar, "CENTER");
FocusHPMPText.MP:SetJustifyH("CENTER");
--]]

--焦点扩展框
local FocusExtraBar = FocusFrame:CreateTexture("UFP_FocusExtraBar", "ARTWORK");
FocusExtraBar:Hide();

local FocusExtraBarBG = FocusFrame:CreateTexture("UFP_FocusExtraBarBG", "BACKGROUND");
FocusExtraBarBG:Hide();

local FocusHPMPPct = CreateFrame("Frame", "UFP_FocusHPMPPct", FocusFrame);
FocusHPMPPct:SetFrameLevel(7);
FocusHPMPPct.HP = FocusHPMPPct:CreateFontString("UFP_FocusHPMPPctHP", "OVERLAY", "TextStatusBarText");
FocusHPMPPct.HP:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE");
FocusHPMPPct.HP:SetTextColor(1, 0.75, 0);
FocusHPMPPct.HP:Hide();

FocusHPMPPct.MP = FocusHPMPPct:CreateFontString("UFP_FocusHPMPPctMP", "OVERLAY", "TextStatusBarText");
FocusHPMPPct.MP:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE");
FocusHPMPPct.MP:SetTextColor(1, 1, 1);
FocusHPMPPct.MP:Hide();

FocusHPMPPct.Pct = FocusHPMPPct:CreateFontString("UFP_FocusHPMPPctPct", "OVERLAY", "TextStatusBarText");
FocusHPMPPct.Pct:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE");
FocusHPMPPct.Pct:SetTextColor(0, 1, 0);
FocusHPMPPct.Pct:Hide();

--刷新额外的生命值显示
function UnitFramesPlus_FocusHPValueDisplayUpdate()
    if not UnitExists("focus") then return end
    local CurHP = UnitHealth("focus");
    local MaxHP = UnitHealthMax("focus");
    local CurHPfix, MaxHPfix, LossHPfix = UnitFramesPlus_GetValueFix(CurHP, MaxHP, UnitFramesPlusDB["focus"]["hpmpunit"], UnitFramesPlusDB["focus"]["unittype"]);
    local PctText = "";
    local FocusExtHPText = "";

    if MaxHP > 0 then
        PctText = math.floor(100*CurHP/MaxHP).."%";
    end
--[[	
	if not UnitIsDead("target") then
		FocusHPMPText.HP:SetText(CurHPfix.." / "..MaxHPfix);
	else
		FocusHPMPText.HP:SetText("");
    end
--]]
    -- if UnitFramesPlusDB["focus"]["extrabar"] == 1 or UnitFramesPlusDB["focus"]["hpmp"] == 1 then
    if UnitFramesPlusDB["focus"]["hpmp"] == 1 then
        if UnitFramesPlusDB["focus"]["hpmppartone"] == 1 then
            FocusExtHPText = CurHPfix;
        elseif UnitFramesPlusDB["focus"]["hpmppartone"] == 2 then
            FocusExtHPText = MaxHPfix;
        elseif UnitFramesPlusDB["focus"]["hpmppartone"] == 3 then
            FocusExtHPText = LossHPfix;
        elseif UnitFramesPlusDB["focus"]["hpmppartone"] == 4 then
            FocusExtHPText = PctText;
        end

        if UnitFramesPlusDB["focus"]["hpmpparttwo"] == 1 then
            FocusExtHPText = FocusExtHPText.."/"..CurHPfix;
        elseif UnitFramesPlusDB["focus"]["hpmpparttwo"] == 2 then
            FocusExtHPText = FocusExtHPText.."/"..MaxHPfix;
        elseif UnitFramesPlusDB["focus"]["hpmpparttwo"] == 3 then
            FocusExtHPText = FocusExtHPText.."/"..LossHPfix;
        elseif UnitFramesPlusDB["focus"]["hpmpparttwo"] == 4 then
            FocusExtHPText = FocusExtHPText.."/"..PctText;
        end

        FocusHPMPPct.HP:SetText(FocusExtHPText);

        if UnitFramesPlusDB["focus"]["hpmppartone"] == 4 or UnitFramesPlusDB["focus"]["hpmpparttwo"] == 4 then
            FocusHPMPPct.Pct:SetText("");
        else
            FocusHPMPPct.Pct:SetText(PctText);
        end
    end
end

--刷新额外的法力值/能量等显示
function UnitFramesPlus_FocusMPValueDisplayUpdate()
    if not UnitExists("focus") then return end
    local CurMP = UnitPower("focus");
    local MaxMP = UnitPowerMax("focus");
    local CurMPfix, MaxMPfix, LossMPfix = UnitFramesPlus_GetValueFix(CurMP, MaxMP, UnitFramesPlusDB["focus"]["hpmpunit"], UnitFramesPlusDB["focus"]["unittype"]);
    local PctText = "";
    local powerType = UnitPowerType("focus");

    if powerType == 0 then
        if MaxMP > 0 then
            PctText = math.floor(100*CurMP/MaxMP).."%";
        end
    else
        PctText = CurMP;
        -- PctText == 0 then PctText = "" end
    end
--[[	
	if MaxMP > 0 and not UnitIsDead("target") then
		FocusHPMPText.MP:SetText(CurMPfix.." / "..MaxMPfix);
	else
		FocusHPMPText.MP:SetText("");
    end
--]]
    -- if UnitFramesPlusDB["focus"]["extrabar"] == 1 or UnitFramesPlusDB["focus"]["hpmp"] == 1 then
    if UnitFramesPlusDB["focus"]["hpmp"] == 1 then
        if UnitFramesPlusDB["focus"]["extrabar"] == 1 or powerType == 0 then
            if UnitFramesPlusDB["focus"]["hpmppartone"] == 1 then
                FocusExtMPText = CurMPfix;
            elseif UnitFramesPlusDB["focus"]["hpmppartone"] == 2 then
                FocusExtMPText = MaxMPfix;
            elseif UnitFramesPlusDB["focus"]["hpmppartone"] == 3 then
                FocusExtMPText = LossMPfix;
            elseif UnitFramesPlusDB["focus"]["hpmppartone"] == 4 then
                FocusExtMPText = PctText;
            end

            if UnitFramesPlusDB["focus"]["hpmpparttwo"] == 1 then
                FocusExtMPText = FocusExtMPText.."/"..CurMPfix;
            elseif UnitFramesPlusDB["focus"]["hpmpparttwo"] == 2 then
                FocusExtMPText = FocusExtMPText.."/"..MaxMPfix;
            elseif UnitFramesPlusDB["focus"]["hpmpparttwo"] == 3 then
                FocusExtMPText = FocusExtMPText.."/"..LossMPfix;
            elseif UnitFramesPlusDB["focus"]["hpmpparttwo"] == 4 then
                FocusExtMPText = FocusExtMPText.."/"..PctText;
            end
        else
            FocusExtMPText = "";
        end

        FocusHPMPPct.MP:SetText(FocusExtMPText);
    end
end

function UnitFramesPlus_FocusHPMPPct()
    if UnitFramesPlusDB["focus"]["hpmp"] == 0 then
        if FocusHPMPPct:IsEventRegistered("PLAYER_FOCUS_CHANGED") then
            FocusHPMPPct:UnregisterEvent("PLAYER_FOCUS_CHANGED");
            FocusHPMPPct:UnregisterEvent("UNIT_HEALTH_FREQUENT");
            FocusHPMPPct:UnregisterEvent("UNIT_POWER_FREQUENT");
            FocusHPMPPct:SetScript("OnEvent", nil);
            FocusHPMPPct.HP:Hide();
            FocusHPMPPct.MP:Hide();
            FocusHPMPPct.Pct:Hide();
			-- FocusHPMPText.HP:Hide();
			-- FocusHPMPText.MP:Hide();
        end
    else
        FocusHPMPPct:RegisterEvent("PLAYER_FOCUS_CHANGED");
        FocusHPMPPct:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "focus");
        FocusHPMPPct:RegisterUnitEvent("UNIT_POWER_FREQUENT", "focus");
        FocusHPMPPct:SetScript("OnEvent", function(self, event, ...)
            if event == "UNIT_HEALTH_FREQUENT" then
                UnitFramesPlus_FocusHPValueDisplayUpdate();
            elseif event == "UNIT_POWER_FREQUENT" then
                UnitFramesPlus_FocusMPValueDisplayUpdate();
            elseif event == "PLAYER_FOCUS_CHANGED" then
                UnitFramesPlus_FocusHPValueDisplayUpdate();
                UnitFramesPlus_FocusMPValueDisplayUpdate();
                UnitFramesPlus_FocusExtrabarSet();
            end
        end)
		if UnitFramesPlusDB["focus"]["hpmp"] == 1 then
			FocusHPMPPct.HP:Show();
			FocusHPMPPct.MP:Show();
			FocusHPMPPct.Pct:Show();
		else
			FocusHPMPPct.HP:Hide();
			FocusHPMPPct.MP:Hide();
			FocusHPMPPct.Pct:Hide();
		end
    end
end

function UnitFramesPlus_FocusExtrabarSet()
    if not UnitExists("focus") then return end
    local classification = UnitClassification("focus");
    if ( classification == "minus" ) then
        FocusExtraBar:SetTexture("Interface\\Tooltips\\UI-StatusBar-Border");
        FocusExtraBar:SetWidth(102);
        FocusExtraBar:SetHeight(18);
        FocusExtraBar:SetTexCoord(0, 0.796875, 0, 1);
        FocusExtraBar:SetVertexColor(1, 1, 1, 1) 
        FocusExtraBar:ClearAllPoints();
        FocusExtraBar:SetPoint("RIGHT", FocusFrameHealthBar, "LEFT", 0, 0);

        FocusExtraBarBG:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background");
        FocusExtraBarBG:SetWidth(96);
        FocusExtraBarBG:SetHeight(12);
        FocusExtraBarBG:SetVertexColor(0, 0, 0, 0.5);
        FocusExtraBarBG:ClearAllPoints();
        FocusExtraBarBG:SetPoint("RIGHT", FocusFrameHealthBar, "LEFT", -4, 0);

        FocusHPMPPct.MP:SetAlpha(0);
    else
        if ( classification == "worldboss" or classification == "elite" or classification == "rareelite" or classification == "rare" ) then
            FocusExtraBar:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
        else
            FocusExtraBar:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
        end
        FocusExtraBar:SetWidth(138);
        FocusExtraBar:SetHeight(128);
        FocusExtraBar:SetTexCoord(0, 0.3984375, 0, 1);
        FocusExtraBar:ClearAllPoints();
        FocusExtraBar:SetPoint("TOPLEFT", FocusFrame, "TOPLEFT", -132, 0);

        FocusExtraBarBG:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background");
        FocusExtraBarBG:SetWidth(96);
        FocusExtraBarBG:SetHeight(42);
        FocusExtraBarBG:SetVertexColor(0, 0, 0, 0.5);
        FocusExtraBarBG:ClearAllPoints();
        FocusExtraBarBG:SetPoint("TOPLEFT", FocusFrame, "TOPLEFT", -93, -23);

        FocusHPMPPct.MP:SetAlpha(1);
    end
	-- FocusHPMPText.MP:SetAlpha(1);
	-- FocusHPMPText.HP:SetAlpha(1);
end

function UnitFramesPlus_FocusExtrabar()
--[[    
	FocusHPMPText.HP:ClearAllPoints();
	FocusHPMPText.HP:SetPoint("CENTER", FocusFrameHealthBar, "CENTER");
	FocusHPMPText.HP:SetJustifyH("CENTER");
	FocusHPMPText.MP:ClearAllPoints();
	FocusHPMPText.MP:SetPoint("CENTER", FocusFrameManaBar, "CENTER");
	FocusHPMPText.MP:SetJustifyH("CENTER");
--]]	
	if UnitFramesPlusDB["focus"]["extrabar"] == 1 then
        FocusExtraBar:Show();
        FocusExtraBarBG:Show();
        FocusHPMPPct.HP:ClearAllPoints();
        FocusHPMPPct.HP:SetPoint("CENTER", FocusFrameHealthBar, "LEFT", -49, -1);
        FocusHPMPPct.HP:SetJustifyH("CENTER");
        FocusHPMPPct.MP:ClearAllPoints();
        FocusHPMPPct.MP:SetPoint("CENTER", FocusFrameManaBar, "LEFT", -49, -1);
        FocusHPMPPct.MP:SetJustifyH("CENTER");
        FocusHPMPPct.Pct:ClearAllPoints();
        FocusHPMPPct.Pct:SetPoint("CENTER", FocusFrameHealthBar, "LEFT", -49, 14);
        FocusHPMPPct.Pct:SetJustifyH("CENTER");
    else
        FocusExtraBar:Hide();
        FocusExtraBarBG:Hide();
        FocusHPMPPct.HP:ClearAllPoints();
        FocusHPMPPct.HP:SetPoint("RIGHT", FocusFrameHealthBar, "LEFT", -5, -1);
        FocusHPMPPct.HP:SetJustifyH("RIGHT");
        FocusHPMPPct.MP:ClearAllPoints();
        FocusHPMPPct.MP:SetPoint("RIGHT", FocusFrameManaBar, "LEFT", -5, -1);
        FocusHPMPPct.MP:SetJustifyH("RIGHT");
        FocusHPMPPct.Pct:ClearAllPoints();
        FocusHPMPPct.Pct:SetPoint("RIGHT", FocusFrameHealthBar, "LEFT", -5, 14);
        FocusHPMPPct.Pct:SetJustifyH("RIGHT");
    end
    UnitFramesPlus_FocusExtrabarSet();
    UnitFramesPlus_FocusHPValueDisplayUpdate();
    UnitFramesPlus_FocusMPValueDisplayUpdate();
end

--焦点生命条染色
local chb = CreateFrame("Frame");
function UnitFramesPlus_FocusColorHPBar()
    if UnitFramesPlusDB["focus"]["colorhp"] == 1 then
        if UnitFramesPlusDB["focus"]["colortype"] == 1 then
            FocusFrameHealthBar:SetScript("OnValueChanged", nil);
            chb:RegisterEvent("PLAYER_FOCUS_CHANGED");
            chb:SetScript("OnEvent", function(self, event, ...)
                UnitFramesPlus_FocusColorHPBarDisplayUpdate();
            end)
        elseif UnitFramesPlusDB["focus"]["colortype"] == 2 then
            if chb:IsEventRegistered("PLAYER_FOCUS_CHANGED") then
                chb:UnregisterEvent("PLAYER_FOCUS_CHANGED");
                chb:SetScript("OnEvent", nil);
            end
            FocusFrameHealthBar:SetScript("OnValueChanged", function(self, value)
                UnitFramesPlus_FocusColorHPBarDisplayUpdate();
            end)
        end
        --FocusFrameHealthBar.lockColor = true;
    else
        FocusFrameHealthBar:SetScript("OnValueChanged", nil);
        if chb:IsEventRegistered("PLAYER_FOCUS_CHANGED") then
            chb:UnregisterEvent("PLAYER_FOCUS_CHANGED");
            chb:SetScript("OnEvent", nil);
        end
        FocusFrameHealthBar:SetStatusBarColor(0, 1, 0);
        --FocusFrameHealthBar.lockColor = nil;
    end
end

--刷新焦点生命条染色显示
function UnitFramesPlus_FocusColorHPBarDisplayUpdate()
    if UnitExists("focus") then
        if UnitFramesPlusDB["focus"]["colorhp"] == 1 then
            if UnitFramesPlusDB["focus"]["colortype"] == 1 then
                local color = {r=0, g=1, b=0};
                if UnitIsPlayer("focus") then
                    color = RAID_CLASS_COLORS[select(2, UnitClass("focus"))] or {r=0, g=1, b=0};
                end
                FocusFrameHealthBar:SetStatusBarColor(color.r, color.g, color.b);
            elseif UnitFramesPlusDB["focus"]["colortype"] == 2 then
                local CurHP = UnitHealth("focus");
                local MaxHP = UnitHealthMax("focus");
                local r, g, b = UnitFramesPlus_GetRGB(CurHP, MaxHP);
                FocusFrameHealthBar:SetStatusBarColor(r, g, b);
            end
        end
    end
end

--焦点种族或类型
local FocusRace = FocusFrame:CreateFontString("UFP_FocusRace", "ARTWORK", "TextStatusBarText");
FocusRace:ClearAllPoints();
FocusRace:SetPoint("BOTTOMLEFT", FocusFrameNameBackground, "TOPLEFT", 6, 2);
FocusRace:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE");
FocusRace:SetTextColor(1, 0.75, 0);

local tr = CreateFrame("Frame");
function UnitFramesPlus_FocusRace()
    if UnitFramesPlusDB["focus"]["race"] == 1 then
        tr:RegisterEvent("PLAYER_FOCUS_CHANGED");
        tr:SetScript("OnEvent", function(self, event)
            if UnitExists("focus") then
                UnitFramesPlus_FocusRaceDisplayUpdate();
            end
        end)
    else
        FocusRace:SetText("");
        if tr:IsEventRegistered("PLAYER_FOCUS_CHANGED") then
            tr:UnregisterEvent("PLAYER_FOCUS_CHANGED");
            tr:SetScript("OnEvent", nil);
        end
    end
end

--刷新焦点种族或类型显示
function UnitFramesPlus_FocusRaceDisplayUpdate()
    local raceText = "";
    if UnitFramesPlusDB["focus"]["race"] == 1 then
        if UnitIsPlayer("focus") then
            raceText = UnitRace("focus");
        elseif UnitCreatureType("focus") then
            raceText = UnitCreatureType("focus");
        end
    end
    FocusRace:SetText(raceText);
end

--焦点职业图标
local ClassIcon = CreateFrame("Button", "UFP_FocusClassIcon", FocusFrame);
ClassIcon:SetWidth(32);
ClassIcon:SetHeight(32);
ClassIcon:ClearAllPoints();
ClassIcon:SetPoint("TOPLEFT", FocusFrame, "TOPLEFT", 119, 3);
ClassIcon:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
ClassIcon:SetAttribute("unit", "focus");
RegisterUnitWatch(ClassIcon);
ClassIcon:SetAlpha(0);

ClassIcon.Border = ClassIcon:CreateTexture("UFP_FocusClassIconBorder", "OVERLAY");
ClassIcon.Border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder");
ClassIcon.Border:SetWidth(54);
ClassIcon.Border:SetHeight(54);
ClassIcon.Border:SetPoint("CENTER", 11, -12);

ClassIcon.Background = ClassIcon:CreateTexture("UFP_FocusClassIconBG", "BORDER");
ClassIcon.Background:SetTexture("Interface\\Minimap\\UI-Minimap-Background");
ClassIcon.Background:SetWidth(20);
ClassIcon.Background:SetHeight(20);
ClassIcon.Background:SetPoint("CENTER");
ClassIcon.Background:SetVertexColor(0, 0, 0, 1);

ClassIcon.Icon = ClassIcon:CreateTexture("UFP_FocusClassIconIcon", "ARTWORK");
ClassIcon.Icon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes");
ClassIcon.Icon:SetWidth(20);
ClassIcon.Icon:SetHeight(20);
ClassIcon.Icon:SetPoint("CENTER");

local fci = CreateFrame("Frame");
function UnitFramesPlus_FocusClassIcon()
    if UnitFramesPlusDB["focus"]["classicon"] == 1 then
        fci:RegisterEvent("PLAYER_FOCUS_CHANGED");
        fci:SetScript("OnEvent", function(self, event)
            if UnitExists("focus") then
                UnitFramesPlus_FocusClassIconDisplayUpdate();
            end
        end)
    else
        ClassIcon:Hide();
        if fci:IsEventRegistered("PLAYER_FOCUS_CHANGED") then
            fci:UnregisterEvent("PLAYER_FOCUS_CHANGED");
            fci:SetScript("OnEvent", nil);
        end
    end
end

--刷新焦点职业图标显示
function UnitFramesPlus_FocusClassIconDisplayUpdate()
    if UnitFramesPlusDB["focus"]["classicon"] == 1 then
        if UnitIsPlayer("focus") then
            local IconCoord = CLASS_ICON_TCOORDS[select(2,UnitClass("focus"))];
            if IconCoord then
                ClassIcon.Icon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
                ClassIcon.Icon:SetTexCoord(unpack(IconCoord));
            end
            ClassIcon:SetAlpha(1);
        else
            ClassIcon:SetAlpha(0);
        end
    else
        ClassIcon:SetAlpha(0);
    end
end

--焦点职业图标扩展：左键观察/右键交易/中键密语/四号键跟随
local isclicked = false;
local function FocusClassIconDown()
    local point, relativeTo, relativePoint, offsetX, offsetY = ClassIcon.Icon:GetPoint();
    ClassIcon.Icon:ClearAllPoints();
    ClassIcon.Icon:SetPoint(point, relativeTo, relativePoint, offsetX+1, offsetY-1);
    return true;
end

ClassIcon:SetScript("OnMouseDown", function(self, button)
    if UnitFramesPlusDB["focus"]["moreaction"] == 1 then
        if (not UnitCanAttack("player", "focus")) and UnitIsPlayer("focus") then
            if button == "LeftButton" then
                if CheckInteractDistance("focus", 1) then
                    isclicked = FocusClassIconDown();
                    InspectUnit("focus");
                end
            elseif button == "RightButton" then
                if CheckInteractDistance("focus", 2) then
                    isclicked = FocusClassIconDown();
                    InitiateTrade("focus");
                end
            elseif button == "MiddleButton" then
                isclicked = FocusClassIconDown();
                local server = nil;
                local name, server = UnitName("focus");
                local fullname = name;
                if server and (not "focus" or UnitIsSameServer("player", "focus") ~= 1) then
                    fullname = name.."-"..server;
                end
                ChatFrame_SendTell(fullname);
            elseif button == "Button4" then
                if CheckInteractDistance("focus",4) then
                    isclicked = FocusClassIconDown();
                    local server = nil;
                    local name, server = UnitName("focus");
                    local fullname = name;
                    if server and (not "focus" or UnitIsSameServer("player", "focus") ~= 1) then
                        fullname = name.."-"..server;
                    end
                    FollowUnit(fullname, 1);
                end
            end
        end
    end
end)

local function FocusClassIconUp()
    local point, relativeTo, relativePoint, offsetX, offsetY = ClassIcon.Icon:GetPoint();
    ClassIcon.Icon:ClearAllPoints();
    ClassIcon.Icon:SetPoint(point, relativeTo, relativePoint, offsetX-1, offsetY+1);
    return false;
end

ClassIcon:SetScript("OnMouseUp", function(self)
    if UnitFramesPlusDB["focus"]["moreaction"] == 1 and isclicked then
        isclicked = FocusClassIconUp();
    end
end)

--焦点头像内战斗信息
local FocusPortraitIndicator = CreateFrame("Frame", "UFP_FocusPortraitIndicator", FocusFrame);
FocusHitIndicator = FocusPortraitIndicator:CreateFontString("UFP_FocusHitIndicator", "OVERLAY", "NumberFontNormalHuge");
FocusHitIndicator:ClearAllPoints();
FocusHitIndicator:SetPoint("CENTER", FocusFramePortrait, "CENTER", 0, 0);
CombatFeedback_Initialize(FocusPortraitIndicator, FocusHitIndicator, 28);
function UnitFramesPlus_FocusPortraitIndicator()
    if UnitFramesPlusDB["focus"]["indicator"] == 1 then
        FocusPortraitIndicator:RegisterEvent("PLAYER_FOCUS_CHANGED");
        FocusPortraitIndicator:RegisterUnitEvent("UNIT_COMBAT", "focus");
        FocusPortraitIndicator:SetScript("OnEvent", function(self, event, ...)
            if event == "PLAYER_FOCUS_CHANGED" then
                FocusHitIndicator:Hide();
            elseif event == "UNIT_COMBAT" then
                local arg1, arg2, arg3, arg4, arg5 = ...;
                CombatFeedback_OnCombatEvent(self, arg2, arg3, arg4, arg5);
            end
        end)

        --[[
		FocusPortraitIndicator:SetScript("OnUpdate", function(self, elapsed)
            CombatFeedback_OnUpdate(self, elapsed);
        end)
		--]]
    else
        FocusHitIndicator:Hide();
        if FocusPortraitIndicator:IsEventRegistered("UNIT_COMBAT") then
            FocusPortraitIndicator:UnregisterEvent("PLAYER_FOCUS_CHANGED");
            FocusPortraitIndicator:UnregisterEvent("UNIT_COMBAT");
            FocusPortraitIndicator:SetScript("OnEvent", nil);
            FocusPortraitIndicator:SetScript("OnUpdate", nil);
        end
    end
end

--快速焦点，基于slizen的Focuser
local modifierButtons = {"alt", "shift", "ctrl"};
local modifier = "alt";--默认快捷键
local mouseButton = "1";--默认按键：1-左键, 2-右键, 3-中键, 4/5-鼠标快捷键
local actionType = "focus";--默认动作：focus, target
local _G = _G;

local CreateFrame_Hook = function(type, name, parent, template)
    if name and template == "SecureUnitButtonTemplate" then
        _G[name]:SetAttribute(modifier.."-type"..mouseButton, actionType);
    end
end

local frametarget = CreateFrame("CheckButton", "ActionButtonTarget", UIParent, "SecureActionButtonTemplate");
frametarget:SetAttribute("type1", "macro");
frametarget:SetAttribute("macrotext", "/target mouseover");

hooksecurefunc("CreateFrame", CreateFrame_Hook)
local framefocus = CreateFrame("CheckButton", "ActionButton", UIParent, "SecureActionButtonTemplate");
framefocus:SetAttribute("type1", "macro");
framefocus:SetAttribute("macrotext", "/focus mouseover");

local duf = {
    PetFrame,
    PartyMemberFrame1,
    PartyMemberFrame2,
    PartyMemberFrame3,
    PartyMemberFrame4,
    PartyMemberFrame1PetFrame,
    PartyMemberFrame2PetFrame,
    PartyMemberFrame3PetFrame,
    PartyMemberFrame4PetFrame,
    PartyTarget1,
    PartyTarget2,
    PartyTarget3,
    PartyTarget4,
    TargetFrame,
    TargetFrameToT,
    TargetofTargetTargetFrame,
}

function UnitFramesPlus_FocusQuickClear(button)
    actionType = "target";
    modifier = button;
    SetOverrideBindingClick(ActionButtonTarget, true, modifier.."-BUTTON"..mouseButton, "ActionButtonTarget");
    for i, frame in pairs(duf) do
        frame:SetAttribute(modifier.."-type"..mouseButton, actionType);
    end
end

function UnitFramesPlus_FocusQuickInit()
    if UnitFramesPlusDB["focus"]["quick"] == 1 then
        actionType = "focus";
        modifier = modifierButtons[UnitFramesPlusDB["focus"]["button"]];
        SetOverrideBindingClick(ActionButton, true, modifier.."-BUTTON"..mouseButton, "ActionButton");
        for i, frame in pairs(duf) do
            frame:SetAttribute(modifier.."-type"..mouseButton, actionType);
        end
    end
end

function UnitFramesPlus_FocusQuickSet()
    if UnitFramesPlusDB["focus"]["quick"] == 1 then
        UnitFramesPlus_FocusQuickInit();
    else
        UnitFramesPlus_FocusQuickClear(modifierButtons[UnitFramesPlusDB["focus"]["button"]]);
    end
end

function UnitFramesPlus_FocusQuick()
    if not InCombatLockdown() then
        UnitFramesPlus_FocusQuickSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_FocusQuickSet";
        func.callback = function()
            UnitFramesPlus_FocusQuickSet();            
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--焦点头像
local Focus3DPortrait = CreateFrame("PlayerModel", "UFP_Focus3DPortrait", FocusFrame);
Focus3DPortrait:SetWidth(50);
Focus3DPortrait:SetHeight(50);
Focus3DPortrait:SetFrameLevel(1);
Focus3DPortrait:ClearAllPoints();
Focus3DPortrait:SetPoint("CENTER", FocusFramePortrait, "CENTER", -1, -1);
Focus3DPortrait:Hide();
Focus3DPortrait.Background = Focus3DPortrait:CreateTexture("UFP_Focus3DPortraitBG", "BACKGROUND");
Focus3DPortrait.Background:SetTexture("Interface\\AddOns\\UnitFramesPlus\\Portrait3D");
Focus3DPortrait.Background:SetWidth(64);
Focus3DPortrait.Background:SetHeight(64);
Focus3DPortrait.Background:ClearAllPoints();
Focus3DPortrait.Background:SetPoint("CENTER", Focus3DPortrait, "CENTER", 0, 0);
Focus3DPortrait.Background:Hide();

local FocusClassPortrait = FocusFrame:CreateTexture("UFP_FocusClassPortrait", "ARTWORK");
FocusClassPortrait:SetWidth(64);
FocusClassPortrait:SetHeight(64);
FocusClassPortrait:ClearAllPoints();
FocusClassPortrait:SetPoint("TOPRIGHT", FocusFrame, "TOPRIGHT", -42, -12);
FocusClassPortrait:Hide();

local fpt = CreateFrame("Frame");
function UnitFramesPlus_FocusPortrait()
    if UnitFramesPlusDB["focus"]["portrait"] == 1 then
        FocusFramePortrait:Hide();
        if UnitFramesPlusDB["focus"]["portraittype"] == 1 then
            Focus3DPortrait:Show();
            FocusClassPortrait:Hide();
            UnitFramesPlus_FocusPortrait3DBGDisplayUpdate();
            fpt:RegisterEvent("PLAYER_FOCUS_CHANGED");
            fpt:RegisterUnitEvent("UNIT_MODEL_CHANGED", "focus");
            fpt:RegisterUnitEvent("UNIT_CONNECTION", "focus");
            fpt:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "focus");
            fpt:SetScript("OnEvent", function(self, event, ...)
                if event == "PLAYER_FOCUS_CHANGED" then
                    if UnitExists("focus") then
                        if UnitFramesPlusDB["focus"]["portrait3dbg"] == 1 then
                            local color = RAID_CLASS_COLORS[select(2, UnitClass("focus"))] or NORMAL_FONT_COLOR;
                            Focus3DPortrait.Background:SetVertexColor(color.r/1.5, color.g/1.5, color.b/1.5, 1);
                        end
                        UnitFramesPlus_FocusPortraitDisplayUpdate();
                    end
                elseif event == "UNIT_MODEL_CHANGED" or event == "UNIT_CONNECTION" then
                    UnitFramesPlus_FocusPortraitDisplayUpdate();
                --[[
				elseif event == "UNIT_HEALTH_FREQUENT" then
                    if (not UnitIsConnected("focus")) or UnitIsGhost("focus") then
                        Focus3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);
                    elseif UnitIsDead("focus") then
                        Focus3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 0.3, 0.3);
                    else
                        Focus3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
                    end
                --]]
				end				
            end)
        elseif UnitFramesPlusDB["focus"]["portraittype"] == 2 then
            Focus3DPortrait:Hide();
            FocusClassPortrait:Show();
            if not fpt:IsEventRegistered("PLAYER_FOCUS_CHANGED") then
                fpt:RegisterEvent("PLAYER_FOCUS_CHANGED");
            else
                if fpt:IsEventRegistered("UNIT_MODEL_CHANGED") then
                    fpt:UnregisterEvent("UNIT_MODEL_CHANGED");
                    fpt:UnregisterEvent("UNIT_CONNECTION");
                    fpt:UnregisterEvent("UNIT_HEALTH_FREQUENT");
                end
            end
            fpt:SetScript("OnEvent", function(self, event, ...)
                if UnitExists("focus") then
                    UnitFramesPlus_FocusPortraitDisplayUpdate();
                end
            end)
        end
        UnitFramesPlus_FocusPortraitDisplayUpdate();
    else
        FocusFramePortrait:Show();
        Focus3DPortrait:Hide();
        FocusClassPortrait:Hide();
        if fpt:IsEventRegistered("PLAYER_FOCUS_CHANGED") then
            fpt:UnregisterEvent("PLAYER_FOCUS_CHANGED");
            fpt:UnregisterEvent("UNIT_MODEL_CHANGED");
            fpt:UnregisterEvent("UNIT_CONNECTION");
            fpt:UnregisterEvent("UNIT_HEALTH_FREQUENT");
            fpt:SetScript("OnEvent", nil);
        end
    end
end

--刷新焦点头像显示
function UnitFramesPlus_FocusPortraitDisplayUpdate()
    if UnitFramesPlusDB["focus"]["portraittype"] == 1 then
        if (not UnitIsConnected("focus")) or (not UnitIsVisible("focus")) then
            Focus3DPortrait:SetPortraitZoom(0);
            Focus3DPortrait:SetCamDistanceScale(0.25);
            Focus3DPortrait:SetPosition(0,0,0.5);
            Focus3DPortrait:ClearModel();
            Focus3DPortrait:SetModel("Interface\\Buttons\\TalkToMeQuestionMark.M2");
        else
            Focus3DPortrait:SetPortraitZoom(1);
            Focus3DPortrait:SetCamDistanceScale(1);
            Focus3DPortrait:SetPosition(0,0,0);
            Focus3DPortrait:ClearModel();
            Focus3DPortrait:SetUnit("focus");
            --[[
			if (not UnitIsConnected("focus")) or UnitIsGhost("focus") then
                Focus3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);
            elseif UnitIsDead("focus") then
                Focus3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 0.3, 0.3);
            else
                Focus3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
            end
			--]]
        end
    elseif UnitFramesPlusDB["focus"]["portraittype"] == 2 then
        if UnitFramesPlusDB["focus"]["portraitnpcno"] == 1 and not UnitIsPlayer("focus") then
            if FocusClassPortrait:IsShown() then
                FocusFramePortrait:Show();
                FocusClassPortrait:Hide();
            end
        else
            if FocusFramePortrait:IsShown() then
                FocusFramePortrait:Hide();
                FocusClassPortrait:Show();
            end
            local IconCoord = CLASS_ICON_TCOORDS[select(2,UnitClass("focus"))]
            if IconCoord then
                FocusClassPortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
                FocusClassPortrait:SetTexCoord(unpack(IconCoord));
            end
        end
    end
end

--刷新焦点3D头像背景显示
function UnitFramesPlus_FocusPortrait3DBGDisplayUpdate()
    if UnitFramesPlusDB["focus"]["portrait"] == 1 
    and UnitFramesPlusDB["focus"]["portraittype"] == 1
    and UnitFramesPlusDB["focus"]["portrait3dbg"] == 1 then
        Focus3DPortrait.Background:Show();
    else
        Focus3DPortrait.Background:Hide();
    end
end

--鼠标移过时才显示数值

FocusFrame.HealthBarX = CreateFrame("StatusBar", "UFP_FocusFrameHealthBar", FocusFrame);
FocusFrame.HealthBarX:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
FocusFrame.HealthBarX:SetFrameLevel(3);
FocusFrame.HealthBarX:SetWidth(119);
FocusFrame.HealthBarX:SetHeight(12);
FocusFrame.HealthBarX:ClearAllPoints();
FocusFrame.HealthBarX:SetPoint("TOPRIGHT", FocusFrame, "TOPRIGHT", -106, -41);
FocusFrame.HealthBarX:SetAlpha(0);
FocusFrame.PowerBarX = CreateFrame("StatusBar", "UFP_FocusFramePowerBar", FocusFrame);
FocusFrame.PowerBarX:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
FocusFrame.PowerBarX:SetFrameLevel(3);
FocusFrame.PowerBarX:SetWidth(119);
FocusFrame.PowerBarX:SetHeight(12);
FocusFrame.PowerBarX:ClearAllPoints();
FocusFrame.PowerBarX:SetPoint("TOPRIGHT", FocusFrame, "TOPRIGHT", -106, -52);
FocusFrame.PowerBarX:SetAlpha(0);


function UnitFramesPlus_FocusBarTextMouseShow()
		FocusFrameTextureFrame.HealthBarText:SetAlpha(0);
        FocusFrameTextureFrame.HealthBarTextLeft:SetAlpha(0);
        FocusFrameTextureFrame.HealthBarTextRight:SetAlpha(0);
        FocusFrameTextureFrame.ManaBarText:SetAlpha(0);
        FocusFrameTextureFrame.ManaBarTextLeft:SetAlpha(0);
        FocusFrameTextureFrame.ManaBarTextRight:SetAlpha(0);
		-- FocusHPMPText.HP:SetAlpha(0);
		-- FocusHPMPText.MP:SetAlpha(0);
    if UnitFramesPlusDB["focus"]["mouseshow"] == 1 then
        FocusFrame.HealthBarX:SetScript("OnEnter",function(self)
            -- if UnitFramesPlusDB["focus"]["bartext"] == 1 then
				-- FocusHPMPText.HP:SetAlpha(1);
			-- else
				FocusFrameTextureFrame.HealthBarText:SetAlpha(1);
				FocusFrameTextureFrame.HealthBarTextLeft:SetAlpha(1);
				FocusFrameTextureFrame.HealthBarTextRight:SetAlpha(1);
			-- end
        end);
        FocusFrame.HealthBarX:SetScript("OnLeave",function()
            FocusFrameTextureFrame.HealthBarText:SetAlpha(0);
            FocusFrameTextureFrame.HealthBarTextLeft:SetAlpha(0);
            FocusFrameTextureFrame.HealthBarTextRight:SetAlpha(0);
			-- FocusHPMPText.HP:SetAlpha(0);
        end);
        FocusFrame.PowerBarX:SetScript("OnEnter",function(self)
            -- if UnitFramesPlusDB["focus"]["bartext"] == 1 then
				-- FocusHPMPText.MP:SetAlpha(1);
			-- else
				FocusFrameTextureFrame.ManaBarText:SetAlpha(1);
				FocusFrameTextureFrame.ManaBarTextLeft:SetAlpha(1);
				FocusFrameTextureFrame.ManaBarTextRight:SetAlpha(1);
			-- end
        end);
        FocusFrame.PowerBarX:SetScript("OnLeave",function()
            FocusFrameTextureFrame.ManaBarText:SetAlpha(0);
            FocusFrameTextureFrame.ManaBarTextLeft:SetAlpha(0);
            FocusFrameTextureFrame.ManaBarTextRight:SetAlpha(0);
			-- FocusHPMPText.MP:SetAlpha(0);
        end);
    else
        -- if UnitFramesPlusDB["focus"]["bartext"] == 1 then
			-- FocusHPMPText.HP:SetAlpha(1);
			-- FocusHPMPText.MP:SetAlpha(1);
		-- else
			FocusFrameTextureFrame.HealthBarText:SetAlpha(1);
			FocusFrameTextureFrame.HealthBarTextLeft:SetAlpha(1);
			FocusFrameTextureFrame.HealthBarTextRight:SetAlpha(1);
			FocusFrameTextureFrame.ManaBarText:SetAlpha(1);
			FocusFrameTextureFrame.ManaBarTextLeft:SetAlpha(1);
			FocusFrameTextureFrame.ManaBarTextRight:SetAlpha(1);
		-- end
        FocusFrame.HealthBarX:SetScript("OnEnter",nil);
        FocusFrame.HealthBarX:SetScript("OnLeave",nil);
        FocusFrame.PowerBarX:SetScript("OnEnter",nil);
        FocusFrame.PowerBarX:SetScript("OnLeave",nil);
    end
end

function UnitFramesPlus_FocusExtraTextFontSize()
    local BarFont = FocusFrameTextureFrame.HealthBarText:GetFont();
	local BarFontSize = UnitFramesPlusDB["focus"]["barfontsize"];
	local UTPFontSize = UnitFramesPlusDB["focus"]["ufpfontsize"];
	FocusFrameTextureFrame.HealthBarText:SetFont(BarFont, BarFontSize, "OUTLINE");
    FocusFrameTextureFrame.HealthBarTextLeft:SetFont(BarFont, BarFontSize, "OUTLINE");
    FocusFrameTextureFrame.HealthBarTextRight:SetFont(BarFont, BarFontSize, "OUTLINE");
    FocusFrameTextureFrame.ManaBarText:SetFont(BarFont, BarFontSize, "OUTLINE");
    FocusFrameTextureFrame.ManaBarTextLeft:SetFont(BarFont, BarFontSize, "OUTLINE");
    FocusFrameTextureFrame.ManaBarTextRight:SetFont(BarFont, BarFontSize, "OUTLINE");

--    UFP_FocusHPText:SetFont(BarFont, BarFontSize, "OUTLINE");
--    UFP_FocusMPText:SetFont(BarFont, BarFontSize, "OUTLINE")
	UFP_FocusHPMPPctHP:SetFont(STANDARD_TEXT_FONT, UTPFontSize, "OUTLINE");
    UFP_FocusHPMPPctMP:SetFont(STANDARD_TEXT_FONT, UTPFontSize, "OUTLINE");
    UFP_FocusHPMPPctPct:SetFont(STANDARD_TEXT_FONT, UTPFontSize, "OUTLINE");
    UFP_FocusRace:SetFont(STANDARD_TEXT_FONT, UTPFontSize, "OUTLINE");

    FocusFrameTextureFrameName:SetFont(STANDARD_TEXT_FONT, UnitFramesPlusDB["focus"]["namefontsize"]);
end

--模块初始化
function UnitFramesPlus_FocusInit()

	if IsAddOnLoaded("EasyFrames") then
		UnitFramesPlusDB["focus"]["extrabar"] = 0
		UnitFramesPlusDB["focus"]["race"] = 0
		UnitFramesPlusDB["focus"]["colorhp"] = 0
		UnitFramesPlusDB["focus"]["mouseshow"] = 0
		UnitFramesPlusDB["focus"]["namefontsize"] = 12
		UnitFramesPlusDB["focus"]["barfontsize"] = 12
	end

    UnitFramesPlus_FocusShiftDrag();
    UnitFramesPlus_FocusRace();
    UnitFramesPlus_FocusClassIcon();
    UnitFramesPlus_FocusColorHPBar();
    UnitFramesPlus_FocusPortraitIndicator();
    UnitFramesPlus_FocusQuickInit();
    UnitFramesPlus_FocusPortrait();
    UnitFramesPlus_FocusFrameScale();
    UnitFramesPlus_FocusBarTextMouseShow();
    UnitFramesPlus_FocusExtrabar();
    UnitFramesPlus_FocusHPMPPct();
    UnitFramesPlus_FocusExtraTextFontSize();
end
