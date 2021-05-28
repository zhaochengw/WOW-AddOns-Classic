--变量
local select = select;
local floor = math.floor;
local tonumber = tonumber;
local GetCVar = GetCVar;
local SetCVar = SetCVar;
local UnitExists = UnitExists;
local UnitName = UnitName;
local UnitRace = UnitRace;
local UnitClass = UnitClass;
local UnitIsEnemy = UnitIsEnemy;
local UnitIsPlayer = UnitIsPlayer;
local UnitHealth = UnitHealth;
local UnitHealthMax = UnitHealthMax;
local UnitIsDead = UnitIsDead;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local UnitPowerType = UnitPowerType;
local UnitBuff = UnitBuff;
local UnitDebuff = UnitDebuff;
local UnitIsGhost = UnitIsGhost;
local UnitIsVisible = UnitIsVisible;
local UnitIsConnected = UnitIsConnected;
local UnitCreatureType = UnitCreatureType;
local UnitClassification = UnitClassification;
local UnitIsSameServer = UnitIsSameServer;
local UnitIsUnit = UnitIsUnit;
local IsShiftKeyDown = IsShiftKeyDown;
local InCombatLockdown = InCombatLockdown;
local CheckInteractDistance = CheckInteractDistance;
local InspectUnit = InspectUnit;
local InitiateTrade = InitiateTrade;
local ChatFrame_SendTell = ChatFrame_SendTell;
local FollowUnit = FollowUnit;
local CombatFeedback_OnCombatEvent = CombatFeedback_OnCombatEvent;
local CombatFeedback_OnUpdate = CombatFeedback_OnUpdate;
local IsAddOnLoaded = IsAddOnLoaded;
local CooldownFrame_Set = CooldownFrame_Set;
local CooldownFrame_Clear = CooldownFrame_Clear;
local GetTime = GetTime;
local UnitIsOwnerOrControllerOfUnit = UnitIsOwnerOrControllerOfUnit;
local updateFunc = updateFunc;
local hooksecurefunc = hooksecurefunc;

--非战斗状态中允许shift+左键拖动目标头像
function UnitFramesPlus_TargetPositionSet()
    if UnitFramesPlusVar["target"]["moved"] == 0 then
        TargetFrame:ClearAllPoints();
        if UnitFramesPlusDB["target"]["extrabar"] == 1 or UnitFramesPlusDB["target"]["hpmpparttwo"] ~= 5 then
            TargetFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPRIGHT", 108+96*UnitFramesPlusDB["player"]["scale"], 0);
        else
            TargetFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPRIGHT", 45+96*UnitFramesPlusDB["player"]["scale"], 0);
        end
    else
        TargetFrame:ClearAllPoints();
        TargetFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", UnitFramesPlusVar["target"]["x"], UnitFramesPlusVar["target"]["y"]);
    end
    if UnitFramesPlus_TargetTargetPosition then
        UnitFramesPlus_TargetTargetPosition();
    end
end

function UnitFramesPlus_TargetPosition()
    -- if UnitFramesPlusVar["target"]["moved"] == 0 then
    if not InCombatLockdown() then
        UnitFramesPlus_TargetPositionSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_TargetPositionSet";
        func.callback = function()
            UnitFramesPlus_TargetPositionSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
    -- end
end

local function UnitFramesPlus_TargetShiftDrag()
    TargetFrame:SetScript("OnMouseDown", function(self, elapsed)
        if UnitFramesPlusDB["target"]["movable"] == 1 then
            if IsShiftKeyDown() and (not InCombatLockdown()) then
                TargetFrame:StartMoving();
                UnitFramesPlusVar["target"]["moving"] = 1;
            end
        end
    end)

    TargetFrame:SetScript("OnMouseUp", function(self, elapsed)
        if UnitFramesPlusVar["target"]["moving"] == 1 then
            TargetFrame:StopMovingOrSizing();
            UnitFramesPlusVar["target"]["moving"] = 0;
            UnitFramesPlusVar["target"]["moved"] = 1;
            local left = TargetFrame:GetLeft();
            local bottom = TargetFrame:GetBottom();
            UnitFramesPlusVar["target"]["x"] = left;
            UnitFramesPlusVar["target"]["y"] = bottom;
        end
    end)

    TargetFrame_SetLocked(true);
    TargetFrame:SetMovable(true);
    TargetFrame:SetUserPlaced(false);
    TargetFrame:SetClampedToScreen(true);

    --更改目标头像默认位置以防止其和玩家扩展框重叠
    hooksecurefunc("UIParent_UpdateTopFramePositions", function()
        if (TargetFrame and not TargetFrame:IsUserPlaced()) then
            UnitFramesPlus_TargetPosition();
        end
    end)

    hooksecurefunc("TargetFrame_ResetUserPlacedPosition", function()
        UnitFramesPlusVar["target"]["moved"] = 0;
        UnitFramesPlus_TargetPosition();
        if TitanPanel_AdjustFrames then
            TitanPanel_AdjustFrames();
        end
    end)
end

--头像缩放
function UnitFramesPlus_TargetFrameScaleSet(newscale)
    -- local oldscale = oldscale or UnitFramesPlusDB["target"]["scale"];
    local oldscale = TargetFrame:GetScale();
    local newscale = newscale or UnitFramesPlusDB["target"]["scale"];
    local point, relativeTo, relativePoint, offsetX, offsetY = TargetFrame:GetPoint();
    TargetFrame:SetScale(newscale);
    if ComboFrame then
        ComboFrame:SetScale(newscale);
    end
    TargetFrame:ClearAllPoints();
    TargetFrame:SetPoint(point, relativeTo, relativePoint, offsetX*oldscale/newscale, offsetY*oldscale/newscale);
    if UnitFramesPlusDB["target"]["portrait"] == 1 and UnitFramesPlusDB["target"]["portraittype"] == 1 then
        UnitFramesPlus_TargetPortraitDisplayUpdate();
    end
end

function UnitFramesPlus_TargetFrameScale(newscale)
    if not InCombatLockdown() then
        UnitFramesPlus_TargetFrameScaleSet(newscale);
    else
        local func = {};
        func.name = "UnitFramesPlus_TargetFrameScaleSet";
        func.callback = function()
            UnitFramesPlus_TargetFrameScaleSet(newscale);
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--目标仇恨高亮
local TargetThreat = TargetFrame:CreateTexture("UFP_TargetThreat", "BACKGROUND");
TargetThreat:ClearAllPoints();
TargetThreat:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", -24, 0);
TargetThreat:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
TargetThreat:SetTexCoord(0, 0.9453125, 0, 0.181640625);
TargetThreat:SetWidth(242);
TargetThreat:SetHeight(93);
TargetThreat:SetAlpha(0);

--目标仇恨百分比
local TargetThreatText = TargetFrame:CreateFontString("UFP_TargetThreatText", "OVERLAY", "TextStatusBarText");
TargetThreatText:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
-- TargetThreatText:SetTextColor(1, 0.75, 0);
TargetThreatText:SetText("");
TargetThreatText:ClearAllPoints();
TargetThreatText:SetPoint("BOTTOMRIGHT", TargetFrameNameBackground, "TOPRIGHT", -6, 2);
TargetThreatText:SetJustifyH("RIGHT");

local tt = CreateFrame("Frame");
function UnitFramesPlus_TargetThreat()
    if UnitFramesPlusDB["target"]["threat"] == 1 or UnitFramesPlusDB["target"]["threattext"] == 1 then
        tt:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.1 then
                UnitFramesPlus_TargetThreatDisplayUpdate();
                self.timer = 0;
            end
        end)
    else
        TargetThreat:SetAlpha(0);
        TargetThreatText:SetText("");
        tt:SetScript("OnUpdate", nil);
    end
end

function UnitFramesPlus_TargetThreatDisplayUpdate()
    local _, _, threat = UnitDetailedThreatSituation("player", "target");
    if threat then
        local threatfix = threat;
        if threatfix > 100 then threatfix = 100 end
        local r, g, b = UnitFramesPlus_GetRGB(threatfix, 100, 1)
        if UnitFramesPlusDB["target"]["threat"] == 1 then
            TargetThreat:SetVertexColor(r, g, b);
            TargetThreat:SetAlpha(1);
        else
            TargetThreat:SetAlpha(0);
        end
        if UnitFramesPlusDB["target"]["threattext"] == 1 then
            TargetThreatText:SetText(floor(threat).."%");
            TargetThreatText:SetTextColor(r, g, b);
        else
            TargetThreatText:SetText("");
        end
    else
        TargetThreat:SetAlpha(0);
        TargetThreatText:SetText("");
    end
end

--状态数值
local TargetHPMPText = CreateFrame("Frame", "UFP_TargetHPMPText", TargetFrame);

TargetFrameTextureFrameHealthBarText = TargetHPMPText:CreateFontString("UFP_TargetHPText", "OVERLAY", "TextStatusBarText");
TargetFrameTextureFrameHealthBarText:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
TargetFrameTextureFrameHealthBarText:SetTextColor(1, 1, 1);
TargetFrameTextureFrameHealthBarText:SetAlpha(1);
TargetFrameTextureFrameHealthBarText:ClearAllPoints();
TargetFrameTextureFrameHealthBarText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER");
TargetFrameTextureFrameHealthBarText:SetJustifyH("CENTER");

TargetFrameTextureFrameManaBarText = TargetHPMPText:CreateFontString("UFP_TargetMPText", "OVERLAY", "TextStatusBarText");
TargetFrameTextureFrameManaBarText:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
TargetFrameTextureFrameManaBarText:SetTextColor(1, 1, 1);
TargetFrameTextureFrameManaBarText:SetAlpha(1);
TargetFrameTextureFrameManaBarText:ClearAllPoints();
TargetFrameTextureFrameManaBarText:SetPoint("CENTER", TargetFrameManaBar, "CENTER");
TargetFrameTextureFrameManaBarText:SetJustifyH("CENTER");

--目标扩展框
local TargetExtraBar = TargetFrame:CreateTexture("UFP_TargetExtraBar", "ARTWORK");
TargetExtraBar:Hide();

local TargetExtraBarBG = TargetFrame:CreateTexture("UFP_TargetExtraBarBG", "BACKGROUND");
TargetExtraBarBG:Hide();

local TargetHPMPPct = CreateFrame("Frame", "UFP_TargetHPMPPct", TargetFrame);
TargetHPMPPct:SetFrameLevel(7);
TargetHPMPPct.HP = TargetHPMPPct:CreateFontString("UFP_TargetHPMPPctHP", "OVERLAY", "TextStatusBarText");
TargetHPMPPct.HP:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
TargetHPMPPct.HP:SetTextColor(1, 0.75, 0);
TargetHPMPPct.HP:Hide();

TargetHPMPPct.MP = TargetHPMPPct:CreateFontString("UFP_TargetHPMPPctMP", "OVERLAY", "TextStatusBarText");
TargetHPMPPct.MP:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
TargetHPMPPct.MP:SetTextColor(1, 1, 1);
TargetHPMPPct.MP:Hide();

TargetHPMPPct.Pct = TargetHPMPPct:CreateFontString("UFP_TargetHPMPPctPct", "OVERLAY", "TextStatusBarText");
TargetHPMPPct.Pct:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
TargetHPMPPct.Pct:SetTextColor(0, 1, 0);
TargetHPMPPct.Pct:Hide();

--刷新额外的生命值显示
function UnitFramesPlus_TargetHPValueDisplayUpdate()
    if not UnitExists("target") then return end
    local CurHP, MaxHP;
    if UnitFramesPlusDB["global"]["exacthp"] == 1 and UnitFramesPlus_GetUnitHealth and UnitIsEnemy("player", "target") and UnitIsPlayer("target") then
        CurHP, MaxHP = UnitFramesPlus_GetUnitHealth("target");
    else
        CurHP = UnitHealth("target");
        MaxHP = UnitHealthMax("target");
    end
    local CurHPfix, MaxHPfix, LossHPfix = UnitFramesPlus_GetValueFix(CurHP, MaxHP, UnitFramesPlusDB["target"]["hpmpunit"], UnitFramesPlusDB["target"]["unittype"]);
    local PctText = "";
    local TargetExtHPText = "";
    local BarText = "";

    if MaxHP > 0 then
        PctText = floor(100*CurHP/MaxHP).."%";
    end

    if UnitFramesPlusDB["target"]["bartext"] == 1 and not UnitIsDead("target") then
        BarText = CurHPfix.."/"..MaxHPfix
    end
    TargetFrameTextureFrameHealthBarText:SetText(BarText);

    -- if UnitFramesPlusDB["target"]["extrabar"] == 1 or UnitFramesPlusDB["target"]["hpmp"] == 1 then
    if UnitFramesPlusDB["target"]["hpmp"] == 1 then
        if UnitFramesPlusDB["target"]["hpmppartone"] == 1 then
            TargetExtHPText = CurHPfix;
        elseif UnitFramesPlusDB["target"]["hpmppartone"] == 2 then
            TargetExtHPText = MaxHPfix;
        elseif UnitFramesPlusDB["target"]["hpmppartone"] == 3 then
            TargetExtHPText = LossHPfix;
        elseif UnitFramesPlusDB["target"]["hpmppartone"] == 4 then
            TargetExtHPText = PctText;
        end

        if UnitFramesPlusDB["target"]["hpmpparttwo"] == 1 then
            TargetExtHPText = TargetExtHPText.."/"..CurHPfix;
        elseif UnitFramesPlusDB["target"]["hpmpparttwo"] == 2 then
            TargetExtHPText = TargetExtHPText.."/"..MaxHPfix;
        elseif UnitFramesPlusDB["target"]["hpmpparttwo"] == 3 then
            TargetExtHPText = TargetExtHPText.."/"..LossHPfix;
        elseif UnitFramesPlusDB["target"]["hpmpparttwo"] == 4 then
            TargetExtHPText = TargetExtHPText.."/"..PctText;
        end

        TargetHPMPPct.HP:SetText(TargetExtHPText);

        if UnitFramesPlusDB["target"]["hpmppartone"] == 4 or UnitFramesPlusDB["target"]["hpmpparttwo"] == 4 then
            TargetHPMPPct.Pct:SetText("");
        else
            TargetHPMPPct.Pct:SetText(PctText);
        end
    end
end

--刷新额外的法力值/能量等显示
function UnitFramesPlus_TargetMPValueDisplayUpdate()
    if not UnitExists("target") then return end
    local CurMP = UnitPower("target");
    local MaxMP = UnitPowerMax("target");
    local CurMPfix, MaxMPfix, LossMPfix = UnitFramesPlus_GetValueFix(CurMP, MaxMP, UnitFramesPlusDB["target"]["hpmpunit"], UnitFramesPlusDB["target"]["unittype"]);
    local PctText = "";
    local powerType = UnitPowerType("target");
    local BarText = "";

    if powerType == 0 then
        if MaxMP > 0 then
            PctText = floor(100*CurMP/MaxMP).."%";
        end
    else
        PctText = CurMP;
        -- PctText == 0 then PctText = "" end
    end

    if UnitFramesPlusDB["target"]["bartext"] == 1 and not UnitIsDead("target") then
        BarText = CurMPfix.."/"..MaxMPfix
    end
    TargetFrameTextureFrameManaBarText:SetText(BarText);

    -- if UnitFramesPlusDB["target"]["extrabar"] == 1 or UnitFramesPlusDB["target"]["hpmp"] == 1 then
    if UnitFramesPlusDB["target"]["hpmp"] == 1 then
        if UnitFramesPlusDB["target"]["extrabar"] == 1 or powerType == 0 then
            if UnitFramesPlusDB["target"]["hpmppartone"] == 1 then
                TargetExtMPText = CurMPfix;
            elseif UnitFramesPlusDB["target"]["hpmppartone"] == 2 then
                TargetExtMPText = MaxMPfix;
            elseif UnitFramesPlusDB["target"]["hpmppartone"] == 3 then
                TargetExtMPText = LossMPfix;
            elseif UnitFramesPlusDB["target"]["hpmppartone"] == 4 then
                TargetExtMPText = PctText;
            end

            if UnitFramesPlusDB["target"]["hpmpparttwo"] == 1 then
                TargetExtMPText = TargetExtMPText.."/"..CurMPfix;
            elseif UnitFramesPlusDB["target"]["hpmpparttwo"] == 2 then
                TargetExtMPText = TargetExtMPText.."/"..MaxMPfix;
            elseif UnitFramesPlusDB["target"]["hpmpparttwo"] == 3 then
                TargetExtMPText = TargetExtMPText.."/"..LossMPfix;
            elseif UnitFramesPlusDB["target"]["hpmpparttwo"] == 4 then
                TargetExtMPText = TargetExtMPText.."/"..PctText;
            end
        else
            TargetExtMPText = "";
        end

        TargetHPMPPct.MP:SetText(TargetExtMPText);
    end
end

function UnitFramesPlus_TargetHPMPPct()
    if UnitFramesPlusDB["target"]["hpmp"] == 0 then
        if TargetHPMPPct:IsEventRegistered("PLAYER_TARGET_CHANGED") then
            TargetHPMPPct:UnregisterAllEvents();
            TargetHPMPPct:SetScript("OnEvent", nil);
            TargetHPMPPct.HP:Hide();
            TargetHPMPPct.MP:Hide();
            TargetHPMPPct.Pct:Hide();
        end
    else
        TargetHPMPPct:RegisterEvent("PLAYER_TARGET_CHANGED");
        TargetHPMPPct:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "target");
        TargetHPMPPct:RegisterUnitEvent("UNIT_POWER_FREQUENT", "target");
        TargetHPMPPct:SetScript("OnEvent", function(self, event, ...)
            if event == "UNIT_HEALTH_FREQUENT" then
                UnitFramesPlus_TargetHPValueDisplayUpdate();
            elseif event == "UNIT_POWER_FREQUENT" then
                UnitFramesPlus_TargetMPValueDisplayUpdate();
            elseif event == "PLAYER_TARGET_CHANGED" then
                UnitFramesPlus_TargetHPValueDisplayUpdate();
                UnitFramesPlus_TargetMPValueDisplayUpdate();
                UnitFramesPlus_TargetExtrabarSet();
            end
        end)
        TargetHPMPPct.HP:Show();
        TargetHPMPPct.MP:Show();
        TargetHPMPPct.Pct:Show();
    end
end

function UnitFramesPlus_TargetExtrabarSet()
    if not UnitExists("target") then return end
    local classification = UnitClassification("target");
    if ( classification == "minus" ) then
        TargetExtraBar:SetTexture("Interface\\Tooltips\\UI-StatusBar-Border");
        TargetExtraBar:SetWidth(102);
        TargetExtraBar:SetHeight(18);
        TargetExtraBar:SetTexCoord(0, 0.796875, 0, 1);
        TargetExtraBar:SetVertexColor(1, 1, 1, 1) 
        TargetExtraBar:ClearAllPoints();
        TargetExtraBar:SetPoint("RIGHT", TargetFrameHealthBar, "LEFT", 0, 0);

        TargetExtraBarBG:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background");
        TargetExtraBarBG:SetWidth(96);
        TargetExtraBarBG:SetHeight(12);
        TargetExtraBarBG:SetVertexColor(0, 0, 0, 0.5);
        TargetExtraBarBG:ClearAllPoints();
        TargetExtraBarBG:SetPoint("RIGHT", TargetFrameHealthBar, "LEFT", -4, 0);

        TargetHPMPPct.MP:SetAlpha(0);
    else
        if ( classification == "worldboss" or classification == "elite" or classification == "rareelite" or classification == "rare" ) then
            TargetExtraBar:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
        else
            TargetExtraBar:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
        end
        TargetExtraBar:SetWidth(138);
        TargetExtraBar:SetHeight(128);
        TargetExtraBar:SetTexCoord(0, 0.3984375, 0, 1);
        TargetExtraBar:ClearAllPoints();
        TargetExtraBar:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", -132, 0);

        TargetExtraBarBG:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background");
        TargetExtraBarBG:SetWidth(96);
        TargetExtraBarBG:SetHeight(42);
        TargetExtraBarBG:SetVertexColor(0, 0, 0, 0.5);
        TargetExtraBarBG:ClearAllPoints();
        TargetExtraBarBG:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", -93, -23);

        TargetHPMPPct.MP:SetAlpha(1);
    end
end

function UnitFramesPlus_TargetExtrabar()
    if UnitFramesPlusDB["target"]["extrabar"] == 1 then
        TargetExtraBar:Show();
        TargetExtraBarBG:Show();
        TargetHPMPPct.HP:ClearAllPoints();
        TargetHPMPPct.HP:SetPoint("CENTER", TargetFrameHealthBar, "LEFT", -49, -1);
        TargetHPMPPct.HP:SetJustifyH("CENTER");
        TargetHPMPPct.MP:ClearAllPoints();
        TargetHPMPPct.MP:SetPoint("CENTER", TargetFrameManaBar, "LEFT", -49, -1);
        TargetHPMPPct.MP:SetJustifyH("CENTER");
        TargetHPMPPct.Pct:ClearAllPoints();
        TargetHPMPPct.Pct:SetPoint("CENTER", TargetFrameNameBackground, "LEFT", -49, -1);
        TargetHPMPPct.Pct:SetJustifyH("CENTER");
    else
        TargetExtraBar:Hide();
        TargetExtraBarBG:Hide();
        TargetHPMPPct.HP:ClearAllPoints();
        TargetHPMPPct.HP:SetPoint("RIGHT", TargetFrameHealthBar, "LEFT", -5, -1);
        TargetHPMPPct.HP:SetJustifyH("RIGHT");
        TargetHPMPPct.MP:ClearAllPoints();
        TargetHPMPPct.MP:SetPoint("RIGHT", TargetFrameManaBar, "LEFT", -5, -1);
        TargetHPMPPct.MP:SetJustifyH("RIGHT");
        TargetHPMPPct.Pct:ClearAllPoints();
        TargetHPMPPct.Pct:SetPoint("RIGHT", TargetFrameNameBackground, "LEFT", -5, -1);
        TargetHPMPPct.Pct:SetJustifyH("RIGHT");
    end
    UnitFramesPlus_TargetExtrabarSet();
    UnitFramesPlus_TargetHPValueDisplayUpdate();
    UnitFramesPlus_TargetMPValueDisplayUpdate();
    UnitFramesPlus_TargetPosition();
end

-- --目标生命条染色
-- local chb = CreateFrame("Frame");
-- function UnitFramesPlus_TargetColorHPBar()
--     if UnitFramesPlusDB["target"]["colorhp"] == 1 then
--         if UnitFramesPlusDB["target"]["colortype"] == 1 then
--             TargetFrameHealthBar:SetScript("OnValueChanged", nil);
--             -- if chb:IsEventRegistered("UNIT_HEALTH_FREQUENT") then
--             --     chb:UnregisterAllEvents();
--             -- end
--             chb:RegisterEvent("PLAYER_TARGET_CHANGED");
--             chb:RegisterEvent("PLAYER_REGEN_ENABLED");
--             chb:SetScript("OnEvent", function(self, event, ...)
--                 UnitFramesPlus_TargetColorHPBarDisplayUpdate();
--             end)
--         elseif UnitFramesPlusDB["target"]["colortype"] == 2 then
--             TargetFrameHealthBar:SetScript("OnValueChanged", function(self, value)
--                 UnitFramesPlus_TargetColorHPBarDisplayUpdate();
--             end)
--             if chb:IsEventRegistered("PLAYER_TARGET_CHANGED") then
--                 chb:UnregisterAllEvents();
--             end
--             -- chb:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "target");
--         end
--         --TargetFrameHealthBar.lockColor = true;
--     else
--         TargetFrameHealthBar:SetScript("OnValueChanged", nil);
--         if chb:IsEventRegistered("PLAYER_TARGET_CHANGED") then
--             chb:UnregisterAllEvents();
--             chb:SetScript("OnEvent", nil);
--         end
--         TargetFrameHealthBar:SetStatusBarColor(0, 1, 0);
--         --TargetFrameHealthBar.lockColor = nil;
--     end
-- end

--刷新目标生命条染色显示
function UnitFramesPlus_TargetColorHPBarDisplayUpdate()
    if UnitExists("target") then
        if UnitFramesPlusDB["target"]["colorhp"] == 1 then
            if UnitFramesPlusDB["target"]["colortype"] == 1 then
                local color = {r=0, g=1, b=0};
                if UnitIsPlayer("target") then
                    color = RAID_CLASS_COLORS[select(2, UnitClass("target"))] or {r=0, g=1, b=0};
                end
                TargetFrameHealthBar:SetStatusBarColor(color.r, color.g, color.b);
            elseif UnitFramesPlusDB["target"]["colortype"] == 2 then
                local CurHP = UnitHealth("target");
                local MaxHP = UnitHealthMax("target");
                local r, g, b = UnitFramesPlus_GetRGB(CurHP, MaxHP);
                TargetFrameHealthBar:SetStatusBarColor(r, g, b);
            end
        end
    end
end

--目标生命条染色
hooksecurefunc("UnitFrameHealthBar_Update", function(statusbar, unit)
    if unit == "target" and statusbar.unit == "target" then
        UnitFramesPlus_TargetColorHPBarDisplayUpdate();
    end
end);
hooksecurefunc("HealthBar_OnValueChanged", function(self, value, smooth)
    if self.unit == "target" then
        UnitFramesPlus_TargetColorHPBarDisplayUpdate();
    end
end);

--目标种族或类型
local TargetRace = TargetFrame:CreateFontString("UFP_TargetRace", "ARTWORK", "TextStatusBarText");
TargetRace:ClearAllPoints();
TargetRace:SetPoint("BOTTOMLEFT", TargetFrameNameBackground, "TOPLEFT", 6, 2);
TargetRace:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
TargetRace:SetTextColor(1, 0.75, 0);

local tr = CreateFrame("Frame");
function UnitFramesPlus_TargetRace()
    if UnitFramesPlusDB["target"]["race"] == 1 then
        tr:RegisterEvent("PLAYER_TARGET_CHANGED");
        tr:SetScript("OnEvent", function(self, event)
            if UnitExists("target") then
                UnitFramesPlus_TargetRaceDisplayUpdate();
            end
        end)
    else
        TargetRace:SetText("");
        if tr:IsEventRegistered("PLAYER_TARGET_CHANGED") then
            tr:UnregisterAllEvents();
            tr:SetScript("OnEvent", nil);
        end
    end
end

--刷新目标种族或类型显示
function UnitFramesPlus_TargetRaceDisplayUpdate()
    local raceText = "";
    if UnitFramesPlusDB["target"]["race"] == 1 then
        if UnitIsPlayer("target") then
            raceText = UnitRace("target");
        elseif UnitCreatureType("target") then
            raceText = UnitCreatureType("target");
        end
    end
    TargetRace:SetText(raceText);
end

--目标职业图标
local ClassIcon = CreateFrame("Button", "UFP_TargetClassIcon", TargetFrame);
ClassIcon:SetWidth(32);
ClassIcon:SetHeight(32);
ClassIcon:ClearAllPoints();
ClassIcon:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 119, 3);
ClassIcon:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
ClassIcon:SetAlpha(0);

ClassIcon.Border = ClassIcon:CreateTexture("UFP_TargetClassIconBorder", "OVERLAY");
ClassIcon.Border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder");
ClassIcon.Border:SetWidth(54);
ClassIcon.Border:SetHeight(54);
ClassIcon.Border:ClearAllPoints();
ClassIcon.Border:SetPoint("CENTER", 11, -12);

ClassIcon.Background = ClassIcon:CreateTexture("UFP_TargetClassIconBG", "BORDER");
ClassIcon.Background:SetTexture("Interface\\Minimap\\UI-Minimap-Background");
ClassIcon.Background:SetWidth(20);
ClassIcon.Background:SetHeight(20);
ClassIcon.Background:ClearAllPoints();
ClassIcon.Background:SetPoint("CENTER");
ClassIcon.Background:SetVertexColor(0, 0, 0, 1);

ClassIcon.Icon = ClassIcon:CreateTexture("UFP_TargetClassIconIcon", "ARTWORK");
ClassIcon.Icon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes");
ClassIcon.Icon:SetWidth(20);
ClassIcon.Icon:SetHeight(20);
ClassIcon.Icon:ClearAllPoints();
ClassIcon.Icon:SetPoint("CENTER");

local tci = CreateFrame("Frame");
function UnitFramesPlus_TargetClassIcon()
    if UnitFramesPlusDB["target"]["classicon"] == 1 then
        tci:RegisterEvent("PLAYER_TARGET_CHANGED");
        tci:SetScript("OnEvent", function(self, event)
            if UnitExists("target") then
                UnitFramesPlus_TargetClassIconDisplayUpdate();
            end
        end)
    else
        ClassIcon:SetAlpha(0);
        if tci:IsEventRegistered("PLAYER_TARGET_CHANGED") then
            tci:UnregisterAllEvents();
            tci:SetScript("OnEvent", nil);
        end
    end
end

--刷新目标职业图标显示
function UnitFramesPlus_TargetClassIconDisplayUpdate()
    if UnitFramesPlusDB["target"]["classicon"] == 1 then
        if UnitIsPlayer("target") then
            local IconCoord = CLASS_ICON_TCOORDS[select(2, UnitClass("target"))];
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

--目标职业图标扩展：左键观察/右键交易/中键密语/四号键跟随
local isclicked = false

local function TargetClassIconDown()
    local point, relativeTo, relativePoint, offsetX, offsetY = ClassIcon.Icon:GetPoint();
    ClassIcon.Icon:ClearAllPoints();
    ClassIcon.Icon:SetPoint(point, relativeTo, relativePoint, offsetX+1, offsetY-1);
    return true;
end

ClassIcon:SetScript("OnMouseDown", function(self, button)
    if UnitFramesPlusDB["target"]["moreaction"] == 1 then
        if (not UnitCanAttack("player", "target")) and UnitIsPlayer("target") then
            if button == "LeftButton" then
                if CheckInteractDistance("target", 1) then
                    isclicked = TargetClassIconDown();
                    InspectUnit("target");
                end
            elseif button == "RightButton" then
                if CheckInteractDistance("target", 2) then
                    isclicked = TargetClassIconDown();
                    InitiateTrade("target");
                end
            elseif button == "MiddleButton" then
                isclicked = TargetClassIconDown();
                local server = nil;
                local name, server = UnitName("target");
                local fullname = name;
                if server and (not "target" or UnitIsSameServer("player", "target") ~= 1) then
                    fullname = name.."-"..server;
                end
                ChatFrame_SendTell(fullname);
            elseif button == "Button4" then
                if CheckInteractDistance("target",4) then
                    isclicked = TargetClassIconDown();
                    local server = nil;
                    local name, server = UnitName("target");
                    local fullname = name;
                    if server and (not "target" or UnitIsSameServer("player", "target") ~= 1) then
                        fullname = name.."-"..server;
                    end
                    FollowUnit(fullname, 1);
                end
            end
        end
    end
end)

local function TargetClassIconUp()
    local point, relativeTo, relativePoint, offsetX, offsetY = ClassIcon.Icon:GetPoint();
    ClassIcon.Icon:ClearAllPoints();
    ClassIcon.Icon:SetPoint(point, relativeTo, relativePoint, offsetX-1, offsetY+1);
    return false;
end

ClassIcon:SetScript("OnMouseUp", function(self)
    if UnitFramesPlusDB["target"]["moreaction"] == 1 and isclicked then
        isclicked = TargetClassIconUp();
    end
end)

--目标头像内战斗信息
local TargetPortraitIndicator = CreateFrame("Frame", "UFP_TargetPortraitIndicator", TargetFrame);
TargetHitIndicator = TargetPortraitIndicator:CreateFontString("UFP_TargetHitIndicator", "OVERLAY", "NumberFontNormalHuge");
TargetHitIndicator:ClearAllPoints();
TargetHitIndicator:SetPoint("CENTER", TargetFramePortrait, "CENTER", 0, 0);
CombatFeedback_Initialize(TargetPortraitIndicator, TargetHitIndicator, 28);
function UnitFramesPlus_TargetPortraitIndicator()
    if UnitFramesPlusDB["target"]["indicator"] == 1 then
        TargetPortraitIndicator:RegisterEvent("PLAYER_TARGET_CHANGED");
        TargetPortraitIndicator:RegisterUnitEvent("UNIT_COMBAT", "target");
        TargetPortraitIndicator:SetScript("OnEvent", function(self, event, ...)
            if event == "PLAYER_TARGET_CHANGED" then
                TargetHitIndicator:Hide();
            elseif event == "UNIT_COMBAT" then
                local arg1, arg2, arg3, arg4, arg5 = ...;
                CombatFeedback_OnCombatEvent(self, arg2, arg3, arg4, arg5);
            end
        end)

        TargetPortraitIndicator:SetScript("OnUpdate", function(self, elapsed)
            CombatFeedback_OnUpdate(self, elapsed);
        end)
    else
        TargetHitIndicator:Hide();
        if TargetPortraitIndicator:IsEventRegistered("UNIT_COMBAT") then
            TargetPortraitIndicator:UnregisterAllEvents();
            TargetPortraitIndicator:SetScript("OnEvent", nil);
            TargetPortraitIndicator:SetScript("OnUpdate", nil);
        end
    end
end

--Target buff/debuff
local UFP_MAX_TARGET_BUFFS = 32;
local UFP_MAX_TARGET_DEBUFFS = 16;
function UFP_TargetFrame_UpdateAuras(self)
    if not IsAddOnLoaded("ClassicAuraDurations") then
        local frame, frameName;
        local selfName = self:GetName();

        for i = 1, UFP_MAX_TARGET_BUFFS do
            local buffName, icon, _, _, duration, expirationTime, caster, _, _, spellId, _, _, casterIsPlayer = UnitBuff(self.unit, i, nil);
            if (buffName) then
                frameName = selfName.."Buff"..i;
                frame = _G[frameName];
                if ( not frame ) then
                    if ( not icon ) then
                        break;
                    end
                end
                if ( icon and ( not self.maxBuffs or i <= self.maxBuffs ) ) then
                    -- Handle cooldowns
                    --frameCooldown = _G[frameName.."Cooldown"];
                    --CooldownFrame_Set(frameCooldown, expirationTime - duration, duration, duration > 0, true);

                    if UFPClassicDurations then
                        local durationNew, expirationTimeNew = UFPClassicDurations:GetAuraDurationByUnit(self.unit, spellId, caster);
                        if duration == 0 and durationNew then
                            duration = durationNew;
                            expirationTime = expirationTimeNew;
                        end
                        if UnitFramesPlusDB["global"]["builtincd"] == 1 and expirationTime and expirationTime ~= 0 and duration > 0 then
                            CooldownFrame_Set(_G[frameName.."Cooldown"], expirationTime - duration, duration, duration > 0, true);
                        else
                            CooldownFrame_Clear(_G[frameName.."Cooldown"]);
                        end
                    else
                        CooldownFrame_Clear(_G[frameName.."Cooldown"]);
                    end
                end
            else
                break;
            end
        end

        local numDebuffs = 0;
        local frameNum = 1;
        local index = 1;

        local maxDebuffs = self.maxDebuffs or UFP_MAX_TARGET_DEBUFFS;
        while ( frameNum <= maxDebuffs and index <= maxDebuffs ) do
            local debuffName, icon, _, _, duration, expirationTime, caster, _, _, spellId, _, _, casterIsPlayer, nameplateShowAll = UnitDebuff(self.unit, index, "INCLUDE_NAME_PLATE_ONLY");
            if ( debuffName ) then
                if ( TargetFrame_ShouldShowDebuffs(self.unit, caster, nameplateShowAll, casterIsPlayer) ) then
                    frameName = selfName.."Debuff"..frameNum;
                    frame = _G[frameName];
                    if ( icon ) then
                        -- Handle cooldowns
                        --frameCooldown = _G[frameName.."Cooldown"];
                        --CooldownFrame_Set(frameCooldown, expirationTime - duration, duration, duration > 0, true);

                        if UFPClassicDurations then
                            local durationNew, expirationTimeNew = UFPClassicDurations:GetAuraDurationByUnit(self.unit, spellId, caster);
                            if duration == 0 and durationNew then
                                duration = durationNew;
                                expirationTime = expirationTimeNew;
                            end
                            if UnitFramesPlusDB["global"]["builtincd"] == 1 and expirationTime and expirationTime ~= 0 and duration > 0 then
                                CooldownFrame_Set(_G[frameName.."Cooldown"], expirationTime - duration, duration, duration > 0, true);
                            else
                                CooldownFrame_Clear(_G[frameName.."Cooldown"]);
                            end
                        else
                            CooldownFrame_Clear(_G[frameName.."Cooldown"]);
                        end

                        frameNum = frameNum + 1;
                    end
                end
            else
                break;
            end
            index = index + 1;
        end
    end
end

function UnitFramesPlus_TargetBuffCooldown()
    hooksecurefunc("TargetFrame_UpdateAuras", UFP_TargetFrame_UpdateAuras);
end

--Target buff/debuff cooldowntext
local tcd = CreateFrame("Frame");
function UnitFramesPlus_TargetCooldownText()
    if UnitFramesPlusDB["global"]["builtincd"] == 1 and UnitFramesPlusDB["global"]["cdtext"] == 1 then
        tcd:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.1 then
                UnitFramesPlus_TargetCooldownTextDisplayUpdate();
                self.timer = 0;
            end
        end);
    else
        tcd:SetScript("OnUpdate", nil);
    end
end

function UnitFramesPlus_TargetCooldownTextDisplayUpdate()
    for i = 1, UFP_MAX_TARGET_BUFFS do
        local buffName, icon, _, _, duration, expirationTime, caster, _, _, spellId, _, _, casterIsPlayer = UnitBuff("target", i, nil);
        if (buffName) then
            local timetext = "";
            -- local textalpha = 0.7;
            -- local r, g, b = 0, 1, 0;
            frameName = "TargetFrameBuff"..i;
            frame = _G[frameName];
            if icon then
                if (not _G[frameName.."CooldownText"]) then
                    BuffCooldownText = _G[frameName.."Cooldown"]:CreateFontString(frameName.."CooldownText", "OVERLAY");
                    BuffCooldownText:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
                    BuffCooldownText:SetTextColor(1, 1, 1);--(1, 0.75, 0);
                    BuffCooldownText:ClearAllPoints();
                    -- BuffCooldownText:SetPoint("TOPLEFT", _G[frameName], "TOPLEFT", 0, 0);
                    BuffCooldownText:SetPoint("CENTER", _G[frameName], "CENTER", 0, 0);
                end
                if UnitFramesPlusDB["global"]["builtincd"] == 1 and UFPClassicDurations then
                    local durationNew, expirationTimeNew = UFPClassicDurations:GetAuraDurationByUnit("target", spellId, caster)
                    if duration == 0 and durationNew then
                        duration = durationNew
                        expirationTime = expirationTimeNew
                    end

                    if UnitFramesPlusDB["global"]["cdtext"] == 1 and expirationTime and expirationTime ~= 0 and duration > 0 then
                        local timeleft = expirationTime - GetTime();
                        if timeleft >= 0 then
                            if timeleft < 60 then
                                timetext = floor(timeleft+1);
                                -- textalpha = 1 - timeleft/200;
                                -- r, g, b = UnitFramesPlus_GetRGB(timeleft, 60);
                            elseif timeleft <= 1800 then
                                timetext = floor(timeleft/60+1).."m";
                            else
                                timetext = floor(timeleft/3600+1).."h";
                            end
                        end
                    end
                end
            end
            if (not IsAddOnLoaded("OmniCC")) then
                _G[frameName.."CooldownText"]:SetText(timetext);
                -- _G[frameName.."CooldownText"]:SetAlpha(textalpha);
                -- _G[frameName.."CooldownText"]:SetTextColor(r, g, b);
            else
                _G[frameName.."CooldownText"]:SetText("");
            end
        else
            break;
        end
    end

    local numDebuffs = 0;
    local frameNum = 1;
    local index = 1;

    local maxDebuffs = UFP_MAX_TARGET_DEBUFFS;
    while ( frameNum <= maxDebuffs and index <= maxDebuffs ) do
        local debuffName, icon, _, _, duration, expirationTime, caster, _, _, spellId, _, _, casterIsPlayer, nameplateShowAll = UnitDebuff("target", index, "INCLUDE_NAME_PLATE_ONLY");
        if ( debuffName ) then
            if ( TargetFrame_ShouldShowDebuffs("target", caster, nameplateShowAll, casterIsPlayer) ) then
                local timetext = "";
                -- local textalpha = 0.7;
                -- local r, g, b = 0, 1, 0;
                frameName = "TargetFrameDebuff"..frameNum;
                frame = _G[frameName];
                if ( icon ) then
                    if (not _G[frameName.."CooldownText"]) then
                        DebuffCooldownText = _G[frameName.."Cooldown"]:CreateFontString(frameName.."CooldownText", "OVERLAY");
                        DebuffCooldownText:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
                        DebuffCooldownText:SetTextColor(1, 1, 1);--(1, 0.75, 0);
                        DebuffCooldownText:ClearAllPoints();
                        -- DebuffCooldownText:SetPoint("TOPLEFT", _G[frameName], "TOPLEFT", 0, 0);
                        DebuffCooldownText:SetPoint("CENTER", _G[frameName], "CENTER", 0, 0);
                    end

                    if UnitFramesPlusDB["global"]["builtincd"] == 1 and UFPClassicDurations then
                        local durationNew, expirationTimeNew = UFPClassicDurations:GetAuraDurationByUnit("target", spellId, caster)
                        if duration == 0 and durationNew then
                            duration = durationNew
                            expirationTime = expirationTimeNew
                        end
                        if UnitFramesPlusDB["global"]["cdtext"] == 1 and expirationTime and expirationTime ~= 0 and duration > 0 then
                            local timeleft = expirationTime - GetTime();
                            if timeleft >= 0 then
                                if timeleft < 60 then
                                    timetext = floor(timeleft+1);
                                    -- textalpha = 1 - timeleft/200;
                                    -- r, g, b = UnitFramesPlus_GetRGB(timeleft, 60);
                                elseif timeleft <= 1800 then
                                    timetext = floor(timeleft/60+1).."m";
                                else
                                    timetext = floor(timeleft/3600+1).."h";
                                end
                            end
                        end
                    end
                    if (not IsAddOnLoaded("OmniCC")) then
                        _G[frameName.."CooldownText"]:SetText(timetext);
                        -- _G[frameName.."CooldownText"]:SetAlpha(textalpha);
                        -- _G[frameName.."CooldownText"]:SetTextColor(r, g, b);
                    else
                        _G[frameName.."CooldownText"]:SetText("");
                    end

                    frameNum = frameNum + 1;
                else
                    break;
                end
            end
        else
            break;
        end
        index = index + 1;
    end
end

--改变目标buff/debuff图标大小
local PLAYER_UNITS = {
    player = true,
    -- vehicle = true,
    pet = true,
};
local function TargetBuffSize(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
    if UnitFramesPlusDB["target"]["buffsize"] == 1 and self.unit == "target"then
        local UFP_AURA_OFFSET_Y = 3;
        local UFP_LARGE_AURA_SIZE, UFP_SMALL_AURA_SIZE;
        UFP_LARGE_AURA_SIZE = UnitFramesPlusDB["target"]["mysize"];
        UFP_SMALL_AURA_SIZE = UnitFramesPlusDB["target"]["othersize"]
        local UFP_AURA_ROW_WIDTH = 122;
        local UFP_NUM_TOT_AURA_ROWS = 2;

        local UFP_SIZE;
        local UFP_OFFSETY = UFP_AURA_OFFSET_Y;
        local UFP_ROWWIDTH = 0;
        local UFP_FIRSTBUFFONROW = 1;

        for i = 1, numAuras, 1 do
            local caster;
            if auraName == "TargetFrameBuff" then
                _, _, _, _, _, _, caster = UnitBuff(self.unit, i, nil);
            elseif auraName == "TargetFrameDebuff" then
                _, _, _, _, _, _, caster = UnitDebuff(self.unit, i, "INCLUDE_NAME_PLATE_ONLY");
            end

            local isLargeAura = 0;
            if caster then
                for token, value in pairs(PLAYER_UNITS) do
                    if UnitIsUnit(caster, token) or UnitIsOwnerOrControllerOfUnit(token, caster) then
                        isLargeAura = 1;
                    end
                end
            end
            -- if ( largeAuraList[i] ) then
            if isLargeAura == 1 then
                UFP_SIZE = UFP_LARGE_AURA_SIZE;
                UFP_OFFSETY = UFP_AURA_OFFSET_Y + UFP_AURA_OFFSET_Y;
            else
                UFP_SIZE = UFP_SMALL_AURA_SIZE;
            end
            if ( i == 1 ) then
                UFP_ROWWIDTH = UFP_SIZE;
                self.auraRows = self.auraRows + 1;
            else
                UFP_ROWWIDTH = UFP_ROWWIDTH + UFP_SIZE + offsetX;
            end
            if ( UFP_ROWWIDTH > maxRowWidth ) then
                updateFunc(self, auraName, i, numOppositeAuras, UFP_FIRSTBUFFONROW, UFP_SIZE, offsetX, UFP_OFFSETY, mirrorAurasVertically);
                UFP_ROWWIDTH = UFP_SIZE;
                self.auraRows = self.auraRows + 1;
                UFP_FIRSTBUFFONROW = i;
                UFP_OFFSETY = UFP_AURA_OFFSET_Y;
                if ( self.auraRows > UFP_NUM_TOT_AURA_ROWS ) then
                    maxRowWidth = UFP_AURA_ROW_WIDTH;
                end
            else
                updateFunc(self, auraName, i, numOppositeAuras, i - 1, UFP_SIZE, offsetX, UFP_OFFSETY, mirrorAurasVertically);
            end
        end
    end
end

function UnitFramesPlus_TargetBuffSize()
    hooksecurefunc("TargetFrame_UpdateAuraPositions", TargetBuffSize);
end

--目标头像
local Target3DPortrait = CreateFrame("PlayerModel", "UFP_Target3DPortrait", TargetFrame);
Target3DPortrait:SetWidth(50);
Target3DPortrait:SetHeight(50);
Target3DPortrait:SetFrameLevel(1);
Target3DPortrait:ClearAllPoints();
Target3DPortrait:SetPoint("CENTER", TargetFramePortrait, "CENTER", -1, -1);
Target3DPortrait:Hide();
Target3DPortrait.Background = Target3DPortrait:CreateTexture("UFP_Target3DPortraitBG", "BACKGROUND");
Target3DPortrait.Background:SetTexture("Interface\\AddOns\\UnitFramesPlus\\Portrait3D");
Target3DPortrait.Background:SetWidth(64);
Target3DPortrait.Background:SetHeight(64);
Target3DPortrait.Background:ClearAllPoints();
Target3DPortrait.Background:SetPoint("CENTER", Target3DPortrait, "CENTER", 0, 0);
Target3DPortrait.Background:Hide();

local TargetClassPortrait = TargetFrame:CreateTexture("UFP_TargetClassPortrait", "ARTWORK");
TargetClassPortrait:SetWidth(64);
TargetClassPortrait:SetHeight(64);
TargetClassPortrait:ClearAllPoints();
TargetClassPortrait:SetPoint("TOPRIGHT", TargetFrame, "TOPRIGHT", -42, -12);
TargetClassPortrait:Hide();

local tpt = CreateFrame("Frame");
function UnitFramesPlus_TargetPortrait()
    if UnitFramesPlusDB["target"]["portrait"] == 1 then
        if UnitFramesPlusDB["target"]["portraittype"] == 1 then
            if TargetFramePortrait:IsShown() then
                TargetFramePortrait:Hide();
            end
            if TargetClassPortrait:IsShown() then
                TargetClassPortrait:Hide();
            end
            if not Target3DPortrait:IsShown() then
                Target3DPortrait:Show();
            end
            UnitFramesPlus_TargetPortrait3DBGDisplayUpdate();
            tpt:RegisterEvent("PLAYER_ENTERING_WORLD");
            tpt:RegisterEvent("PLAYER_TARGET_CHANGED");
            tpt:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", "target");
            tpt:RegisterUnitEvent("UNIT_MODEL_CHANGED", "target");
            tpt:RegisterUnitEvent("UNIT_CONNECTION", "target");
            tpt:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "target");
            tpt:SetScript("OnEvent", function(self, event, ...)
                if event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_ENTERING_WORLD" or event == "UNIT_TARGETABLE_CHANGED" then
                    if UnitExists("target") then
                        if UnitFramesPlusDB["target"]["portrait3dbg"] == 1 then
                            local color = RAID_CLASS_COLORS[select(2, UnitClass("target"))] or NORMAL_FONT_COLOR;
                            Target3DPortrait.Background:SetVertexColor(color.r/1.5, color.g/1.5, color.b/1.5, 1);
                        end
                        UnitFramesPlus_TargetPortraitDisplayUpdate();
                    end
                elseif event == "UNIT_MODEL_CHANGED" or event == "UNIT_CONNECTION" then
                    UnitFramesPlus_TargetPortraitDisplayUpdate();
                elseif event == "UNIT_HEALTH_FREQUENT" then
                    if TargetFramePortrait:IsShown() then
                        TargetFramePortrait:Hide();
                    end
                    if TargetClassPortrait:IsShown() then
                        TargetClassPortrait:Hide();
                    end
                    if not Target3DPortrait:IsShown() then
                        Target3DPortrait:Show();
                    end
                    if (not UnitIsConnected("target")) or UnitIsGhost("target") then
                        Target3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);
                    elseif UnitIsDead("target") then
                        Target3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 0.3, 0.3);
                    else
                        Target3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
                    end
                end
            end)
        elseif UnitFramesPlusDB["target"]["portraittype"] == 2 then
            if TargetFramePortrait:IsShown() then
                TargetFramePortrait:Hide();
            end
            if not TargetClassPortrait:IsShown() then
                TargetClassPortrait:Show();
            end
            if Target3DPortrait:IsShown() then
                Target3DPortrait:Hide();
            end
            if not tpt:IsEventRegistered("PLAYER_ENTERING_WORLD") then
                tpt:RegisterEvent("PLAYER_ENTERING_WORLD");
                tpt:RegisterEvent("PLAYER_TARGET_CHANGED");
                tpt:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", "target");
                tpt:RegisterUnitEvent("UNIT_CONNECTION", "target");
            else
                if tpt:IsEventRegistered("UNIT_MODEL_CHANGED") then
                    tpt:UnregisterEvent("UNIT_MODEL_CHANGED");
                    tpt:UnregisterEvent("UNIT_HEALTH_FREQUENT");
                end
            end
            tpt:SetScript("OnEvent", function(self, event, ...)
                if UnitExists("target") then
                    UnitFramesPlus_TargetPortraitDisplayUpdate();
                end
            end)
        end
        UnitFramesPlus_TargetPortraitDisplayUpdate();
    else
        if not TargetFramePortrait:IsShown() then
            TargetFramePortrait:Show();
        end
        if TargetClassPortrait:IsShown() then
            TargetClassPortrait:Hide();
        end
        if Target3DPortrait:IsShown() then
            Target3DPortrait:Hide();
        end
        if tpt:IsEventRegistered("PLAYER_ENTERING_WORLD") then
            tpt:UnregisterAllEvents();
            tpt:SetScript("OnEvent", nil);
        end
    end
end

--刷新目标头像显示
function UnitFramesPlus_TargetPortraitDisplayUpdate()
    if UnitFramesPlusDB["target"]["portraittype"] == 1 then
        if TargetFramePortrait:IsShown() then
            TargetFramePortrait:Hide();
        end
        if TargetClassPortrait:IsShown() then
            TargetClassPortrait:Hide();
        end
        if not Target3DPortrait:IsShown() then
            Target3DPortrait:Show();
        end
        if (not UnitIsConnected("target")) or (not UnitIsVisible("target")) then
            Target3DPortrait:SetPortraitZoom(0);
            Target3DPortrait:SetCamDistanceScale(0.25);
            Target3DPortrait:SetPosition(0,0,0.5);
            Target3DPortrait:ClearModel();
            Target3DPortrait:SetModel("Interface\\Buttons\\TalkToMeQuestionMark.M2");
        else
            Target3DPortrait:SetPortraitZoom(1);
            Target3DPortrait:SetCamDistanceScale(1);
            Target3DPortrait:SetPosition(0,0,0);
            Target3DPortrait:ClearModel();
            Target3DPortrait:SetUnit("target");
            if (not UnitIsConnected("target")) or UnitIsGhost("target") then
                Target3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);
            elseif UnitIsDead("target") then
                Target3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 0.3, 0.3);
            else
                Target3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
            end
        end
    elseif UnitFramesPlusDB["target"]["portraittype"] == 2 then
        if UnitFramesPlusDB["target"]["portraitnpcno"] == 1 and not UnitIsPlayer("target") then
            if not TargetFramePortrait:IsShown() then
                TargetFramePortrait:Show();
            end
            if TargetClassPortrait:IsShown() then
                TargetClassPortrait:Hide();
            end
            if Target3DPortrait:IsShown() then
                Target3DPortrait:Hide();
            end
        else
            if TargetFramePortrait:IsShown() then
                TargetFramePortrait:Hide();
            end
            if not TargetClassPortrait:IsShown() then
                TargetClassPortrait:Show();
            end
            if Target3DPortrait:IsShown() then
                Target3DPortrait:Hide();
            end
            local IconCoord = CLASS_ICON_TCOORDS[select(2, UnitClass("target"))];
            if IconCoord then
                TargetClassPortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
                TargetClassPortrait:SetTexCoord(unpack(IconCoord));
            end
        end
    end
end

--刷新目标3D头像背景显示
function UnitFramesPlus_TargetPortrait3DBGDisplayUpdate()
    if UnitFramesPlusDB["target"]["portrait"] == 1 
    and UnitFramesPlusDB["target"]["portraittype"] == 1
    and UnitFramesPlusDB["target"]["portrait3dbg"] == 1 then
        Target3DPortrait.Background:Show();
    else
        Target3DPortrait.Background:Hide();
    end
end

--鼠标移过时才显示数值
function UnitFramesPlus_TargetBarTextMouseShow()
    if UnitFramesPlusDB["target"]["mouseshow"] == 1 then
        TargetFrameTextureFrameHealthBarText:SetAlpha(0);
        -- TargetFrameTextureFrameHealthBarTextLeft:SetAlpha(0);
        -- TargetFrameTextureFrameHealthBarTextRight:SetAlpha(0);
        TargetFrameHealthBar:SetScript("OnEnter", function(self)
            TargetFrameTextureFrameHealthBarText:SetAlpha(1);
            -- TargetFrameTextureFrameHealthBarTextLeft:SetAlpha(1);
            -- TargetFrameTextureFrameHealthBarTextRight:SetAlpha(1);
            UnitFrame_UpdateTooltip(TargetFrame);
        end);
        TargetFrameHealthBar:SetScript("OnLeave", function()
            TargetFrameTextureFrameHealthBarText:SetAlpha(0);
            -- TargetFrameTextureFrameHealthBarTextLeft:SetAlpha(0);
            -- TargetFrameTextureFrameHealthBarTextRight:SetAlpha(0);
            GameTooltip:Hide();
        end);
        TargetFrameTextureFrameManaBarText:SetAlpha(0);
        -- TargetFrameTextureFrameManaBarTextLeft:SetAlpha(0);
        -- TargetFrameTextureFrameManaBarTextRight:SetAlpha(0);
        TargetFrameManaBar:SetScript("OnEnter", function(self)
            TargetFrameTextureFrameManaBarText:SetAlpha(1);
            -- TargetFrameTextureFrameManaBarTextLeft:SetAlpha(1);
            -- TargetFrameTextureFrameManaBarTextRight:SetAlpha(1);
            UnitFrame_UpdateTooltip(TargetFrame);
        end);
        TargetFrameManaBar:SetScript("OnLeave", function()
            TargetFrameTextureFrameManaBarText:SetAlpha(0);
            -- TargetFrameTextureFrameManaBarTextLeft:SetAlpha(0);
            -- TargetFrameTextureFrameManaBarTextRight:SetAlpha(0);
            GameTooltip:Hide();
        end);
    else
        TargetFrameTextureFrameHealthBarText:SetAlpha(1);
        -- TargetFrameTextureFrameHealthBarTextLeft:SetAlpha(1);
        -- TargetFrameTextureFrameHealthBarTextRight:SetAlpha(1);
        TargetFrameHealthBar:SetScript("OnEnter", function()
            UnitFrame_UpdateTooltip(TargetFrame);
        end);
        TargetFrameHealthBar:SetScript("OnLeave", function()
            GameTooltip:Hide();
        end);
        TargetFrameTextureFrameManaBarText:SetAlpha(1);
        -- TargetFrameTextureFrameManaBarTextLeft:SetAlpha(1);
        -- TargetFrameTextureFrameManaBarTextRight:SetAlpha(1);
        TargetFrameManaBar:SetScript("OnEnter", function()
            UnitFrame_UpdateTooltip(TargetFrame);
        end);
        TargetFrameManaBar:SetScript("OnLeave", function()
            GameTooltip:Hide();
        end);
    end
end

local function UnitFramesPlus_SysToT()
    if UnitFramesPlusDB["target"]["systot"] == 1 then
        if tonumber(GetCVar("showTargetOfTarget")) == 1 then
            SetCVar("showTargetOfTarget", 0, 1);
        end
    end
end

function UnitFramesPlus_TargetExtraTextFontSize()
    UFP_TargetThreatText:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["target"]["fontsize"], "OUTLINE");
    UFP_TargetHPText:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["target"]["fontsize"], "OUTLINE");
    UFP_TargetMPText:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["target"]["fontsize"], "OUTLINE")
    UFP_TargetHPMPPctHP:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["target"]["fontsize"], "OUTLINE");
    UFP_TargetHPMPPctMP:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["target"]["fontsize"], "OUTLINE");
    UFP_TargetHPMPPctPct:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["target"]["fontsize"], "OUTLINE");
    UFP_TargetRace:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["target"]["fontsize"], "OUTLINE");

    TargetFrameTextureFrameName:SetFont(GameFontNormalSmall:GetFont(), UnitFramesPlusDB["target"]["fontsize"]);
end

--模块初始化
function UnitFramesPlus_TargetInit()
    UnitFramesPlus_TargetShiftDrag();
    UnitFramesPlus_TargetRace();
    UnitFramesPlus_TargetClassIcon();
    UnitFramesPlus_TargetPortraitIndicator();
    -- UnitFramesPlus_TargetColorHPBar();
    UnitFramesPlus_TargetBuffSize();
    UnitFramesPlus_TargetPortrait();
    UnitFramesPlus_TargetBarTextMouseShow();
    UnitFramesPlus_TargetExtrabar();
    UnitFramesPlus_TargetHPMPPct();
    UnitFramesPlus_TargetBuffCooldown();
    UnitFramesPlus_TargetCooldownText();
    UnitFramesPlus_TargetThreat();
    UnitFramesPlus_TargetExtraTextFontSize();
end

function UnitFramesPlus_TargetLayout()
    UnitFramesPlus_TargetFrameScale();
    UnitFramesPlus_TargetPosition();
end

function UnitFramesPlus_TargetCvar()
    UnitFramesPlus_SysToT();
end
