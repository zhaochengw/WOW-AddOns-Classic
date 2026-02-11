--焦点目标
local ToFFrame = CreateFrame("Button", "UFP_ToFFrame", FocusFrame, "SecureUnitButtonTemplate, SecureHandlerAttributeTemplate");
ToFFrame:SetFrameLevel(7);
ToFFrame:SetWidth(96);
ToFFrame:SetHeight(48);
ToFFrame:ClearAllPoints();
ToFFrame:SetPoint("LEFT", FocusFrame, "RIGHT", -20, 0);
ToFFrame:SetMovable(1);

ToFFrame:SetAttribute("unit", "focustarget");
RegisterUnitWatch(ToFFrame);
ToFFrame:SetAttribute("*type1", "target");
ToFFrame:RegisterForClicks("AnyUp");
ToFFrame:RegisterForDrag("LeftButton");

ToFFrame.Portrait = ToFFrame:CreateTexture("UFP_ToFFramePortrait", "BORDER");
ToFFrame.Portrait:SetWidth(27);
ToFFrame.Portrait:SetHeight(27);
ToFFrame.Portrait:ClearAllPoints();
ToFFrame.Portrait:SetPoint("TOPLEFT", ToFFrame, "TOPLEFT", 6, -5);

ToFFrame.ClassPortrait = ToFFrame:CreateTexture("UFP_ToFFrameClassPortrait", "ARTWORK");
ToFFrame.ClassPortrait:SetWidth(27);
ToFFrame.ClassPortrait:SetHeight(27);
ToFFrame.ClassPortrait:ClearAllPoints();
ToFFrame.ClassPortrait:SetPoint("TOPLEFT", ToFFrame, "TOPLEFT", 6, -5);
ToFFrame.ClassPortrait:Hide();

ToFFrame.Texture = ToFFrame:CreateTexture("UFP_ToFFrameTexture", "ARTWORK");
ToFFrame.Texture:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame");
ToFFrame.Texture:SetWidth(96);
ToFFrame.Texture:SetHeight(48);
ToFFrame.Texture:ClearAllPoints();
ToFFrame.Texture:SetPoint("TOPLEFT", ToFFrame, "TOPLEFT", 0, -2);

ToFFrame.Highlight = ToFFrame:CreateTexture("UFP_ToFFlash", "BACKGROUND");
ToFFrame.Highlight:SetSize(96, 48);
ToFFrame.Highlight:SetPoint("TOPLEFT", ToFFrame, "TOPLEFT", -2, 1);
ToFFrame.Highlight:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame-Flash");
ToFFrame.Highlight:SetVertexColor(1, 0.82, 0);
ToFFrame.Highlight:SetAlpha(0);

-- ToFFrame.Name = ToFFrame:CreateFontString("UFP_ToFFrameName", "ARTWORK", "GameFontNormalSmall");
ToFFrame.Name = ToFFrame:CreateFontString("UFP_ToTName", "ARTWORK");
ToFFrame.Name:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
ToFFrame.Name:SetTextColor(1, 0.75, 0);
ToFFrame.Name:ClearAllPoints();
ToFFrame.Name:SetPoint("BOTTOMLEFT", ToFFrame, "BOTTOMLEFT", 36, 39);

ToFFrame.HealthBar = CreateFrame("StatusBar", "UFP_ToFFrameHealthBar", ToFFrame);
ToFFrame.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToFFrame.HealthBar:SetFrameLevel(2);
ToFFrame.HealthBar:SetMinMaxValues(0, 100);
ToFFrame.HealthBar:SetValue(0);
ToFFrame.HealthBar:SetWidth(53);
ToFFrame.HealthBar:SetHeight(6);
ToFFrame.HealthBar:ClearAllPoints();
ToFFrame.HealthBar:SetPoint("TOPLEFT", ToFFrame, "TOPLEFT", 35, -9);
ToFFrame.HealthBar:SetStatusBarColor(0, 1, 0);

ToFFrame.HPPct = ToFFrame:CreateFontString("UFP_ToFFrameHPPct", "ARTWORK", "TextStatusBarText");
ToFFrame.HPPct:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
ToFFrame.HPPct:SetTextColor(1, 0.75, 0);
ToFFrame.HPPct:SetJustifyH("LEFT");
ToFFrame.HPPct:ClearAllPoints();
ToFFrame.HPPct:SetPoint("LEFT", ToFFrame.HealthBar, "RIGHT", 2, -4);

ToFFrame.PowerBar = CreateFrame("StatusBar", "UFP_ToFFramePowerBar", ToFFrame);
ToFFrame.PowerBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToFFrame.PowerBar:SetFrameLevel(2);
ToFFrame.PowerBar:SetMinMaxValues(0, 100);
ToFFrame.PowerBar:SetValue(0);
ToFFrame.PowerBar:SetWidth(53);
ToFFrame.PowerBar:SetHeight(6);
ToFFrame.PowerBar:ClearAllPoints();
ToFFrame.PowerBar:SetPoint("TOPLEFT", ToFFrame, "TOPLEFT", 35, -16);
ToFFrame.PowerBar:SetStatusBarColor(0, 0, 1);

local tof = CreateFrame("Frame");
function UnitFramesPlus_FocusTarget()
    UnitFramesPlus_ToFAttribute();
    if UnitFramesPlusDB["focustarget"]["show"] == 1 then
        tof:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.2 then
                UnitFramesPlus_FocusTargetDisplayUpdate();
                self.timer = 0;
            end
        end);
    else
        tof:SetScript("OnUpdate", nil);
    end
end

function UnitFramesPlus_FocusTargetDisplayUpdate()
    if UnitExists("focustarget") then
        local name, realm = UnitName("focustarget");
        local fullname = name;
        if realm then
            if UnitFramesPlusDB["focustarget"]["shortname"] == 1 then
                fullname = name.."(*)";
            else
                fullname = name.."-"..realm;
            end
        end
        ToFFrame.Name:SetText(fullname);

        local color = NORMAL_FONT_COLOR;
        if UnitFramesPlusDB["focustarget"]["colorname"] == 1 and (UnitFramesPlusDB["focustarget"]["colornamenpcno"] ~= 1 or UnitIsPlayer("focustarget")) then
            color = RAID_CLASS_COLORS[select(2, UnitClass("focustarget"))] or NORMAL_FONT_COLOR;
        end
        ToFFrame.Name:SetTextColor(color.r, color.g, color.b);

        local ToFNameColor = PowerBarColor[UnitPowerType("focustarget")] or PowerBarColor["MANA"];
        ToFFrame.PowerBar:SetStatusBarColor(ToFNameColor.r, ToFNameColor.g, ToFNameColor.b);

        -- SetPortraitTexture(ToFFrame.Portrait, "focustarget");
        UnitFramesPlus_FocusTargetClassPortraitDisplayUpdate()

        if UnitHealthMax("focustarget") > 0 then
            ToFFrame.HealthBar:SetValue(UnitHealth("focustarget") / UnitHealthMax("focustarget") * 100);
            local ToFPctText = "";
            if UnitFramesPlusDB["focustarget"]["hppct"] == 1 then
                ToFPctText = math.floor(UnitHealth("focustarget") / UnitHealthMax("focustarget") * 100).."%";
            end
            ToFFrame.HPPct:SetText(ToFPctText);
        else
            ToFFrame.HealthBar:SetValue(0);
            ToFFrame.HPPct:SetText("");
        end

        if UnitPowerMax("focustarget") > 0 then
            ToFFrame.PowerBar:SetValue(UnitPower("focustarget") / UnitPowerMax("focustarget") * 100);
        else
            ToFFrame.PowerBar:SetValue(0);
        end

        if UnitFramesPlusDB["focustarget"]["enemycheck"] == 1 then
            if UnitIsEnemy("player", "focustarget") then
                ToFFrame.Highlight:SetAlpha(1);
                ToFFrame.Highlight:SetVertexColor(1, 0, 0);
            elseif UnitIsFriend("player", "focustarget") then
                ToFFrame.Highlight:SetAlpha(1);
                ToFFrame.Highlight:SetVertexColor(0, 1, 0);
            else
                ToFFrame.Highlight:SetAlpha(0);
                ToFFrame.Highlight:SetVertexColor(1, 0.82, 0);
            end
        end
    else
        -- ToFFrame.HealthBar:SetValue(0);
        -- ToFFrame.PowerBar:SetValue(0);
        ToFFrame.HPPct:SetText("");
    end
end

function UnitFramesPlus_FocusTargetClassPortraitDisplayUpdate()
    if UnitFramesPlusDB["focustarget"]["portrait"] == 1 
    and (UnitFramesPlusDB["focustarget"]["portraitnpcno"] ~= 1 or UnitIsPlayer("focustarget")) then
        if ToFFrame.Portrait:IsShown() then
            ToFFrame.Portrait:Hide();
            ToFFrame.ClassPortrait:Show();
        end
        local IconCoord = CLASS_ICON_TCOORDS[select(2,UnitClass("focustarget"))]
        if IconCoord then
            ToFFrame.ClassPortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
            ToFFrame.ClassPortrait:SetTexCoord(unpack(IconCoord));
        end
    else
        if ToFFrame.ClassPortrait:IsShown() then
            ToFFrame.Portrait:Show();
            ToFFrame.ClassPortrait:Hide();
        end
        SetPortraitTexture(ToFFrame.Portrait, "focustarget");
    end
end

function UnitFramesPlus_ToFAttributeSet()
    if UnitFramesPlusDB["focustarget"]["show"] == 1 then
        ToFFrame:SetAttribute("unit", "focustarget");
    else
        ToFFrame:SetAttribute("unit", nil);
    end
end

function UnitFramesPlus_ToFAttribute()
    if not InCombatLockdown() then
        UnitFramesPlus_ToFAttributeSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_ToFAttributeSet";
        func.callback = function()
            UnitFramesPlus_ToFAttributeSet();            
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--非战斗状态中允许shift+左键拖动焦点目标头像
function UnitFramesPlus_FocusTargetPositionSet()
    if UnitFramesPlusVar["focustarget"]["moved"] == 1 then
        ToFFrame:ClearAllPoints();
        ToFFrame:SetPoint("BOTTOMLEFT", FocusFrame, "BOTTOMLEFT", UnitFramesPlusVar["focustarget"]["x"], UnitFramesPlusVar["focustarget"]["y"]);
    else
        ToFFrame:ClearAllPoints();
        ToFFrame:SetPoint("LEFT", FocusFrame, "RIGHT", -20, 0);
    end
end

function UnitFramesPlus_FocusTargetPosition()
    if not InCombatLockdown() then
        UnitFramesPlus_FocusTargetPositionSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_FocusTargetPositionSet";
        func.callback = function()
            UnitFramesPlus_FocusTargetPositionSet();        
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

local function UnitFramesPlus_FocusTargetShiftDrag()
    ToFFrame:SetScript("OnMouseDown", function(self, elapsed)
        if UnitFramesPlusDB["focus"]["movable"] == 1 then
            if IsShiftKeyDown() and (not InCombatLockdown()) then
                ToFFrame:StartMoving();
                UnitFramesPlusVar["focustarget"]["moving"] = 1;
            end
        end
    end)

    ToFFrame:SetScript("OnMouseUp", function(self, elapsed)
        if UnitFramesPlusVar["focustarget"]["moving"] == 1 then
            ToFFrame:StopMovingOrSizing();
            UnitFramesPlusVar["focustarget"]["moving"] = 0;
            UnitFramesPlusVar["focustarget"]["moved"] = 1;
            local bottom = ToFFrame:GetBottom();
            local left = ToFFrame:GetLeft();
            local scale = ToFFrame:GetScale()*FocusFrame:GetScale();
            local bottomX = FocusFrame:GetBottom();
            local leftX = FocusFrame:GetLeft();
            local scaleX = FocusFrame:GetScale();
            UnitFramesPlusVar["focustarget"]["x"] = (left*scale-leftX*scaleX)/scale;
            UnitFramesPlusVar["focustarget"]["y"] = (bottom*scale-bottomX*scaleX)/scale;
            ToFFrame:ClearAllPoints();
            ToFFrame:SetPoint("BOTTOMLEFT", FocusFrame, "BOTTOMLEFT", UnitFramesPlusVar["focustarget"]["x"], UnitFramesPlusVar["focustarget"]["y"]);
        end
    end)

    ToFFrame:SetClampedToScreen(1);

    --重置目标位置时同时重置焦点目标位置
    hooksecurefunc("TargetFrame_ResetUserPlacedPosition", function()
        UnitFramesPlusVar["focustarget"]["moved"] = 0;
        UnitFramesPlus_FocusTargetPosition();
    end)
end

--焦点目标头像缩放
function UnitFramesPlus_FocusTargetScaleSet(newscale)
    -- local oldscale = oldscale or UnitFramesPlusDB["focustarget"]["scale"];
    local oldscale = ToFFrame:GetScale();
    local newscale = newscale or UnitFramesPlusDB["focustarget"]["scale"];
    if UnitFramesPlusDB["focustarget"]["show"] == 1 then
        local point, relativeTo, relativePoint, offsetX, offsetY = ToFFrame:GetPoint();
        ToFFrame:SetScale(newscale);
        ToFFrame:ClearAllPoints();
        ToFFrame:SetPoint(point, relativeTo, relativePoint, offsetX*oldscale/newscale, offsetY*oldscale/newscale);
    end
end

function UnitFramesPlus_FocusTargetScale(newscale)
    if not InCombatLockdown() then
        UnitFramesPlus_FocusTargetScaleSet(newscale);
    else
        local func = {};
        func.name = "UnitFramesPlus_FocusTargetScaleSet";
        func.callback = function()
            UnitFramesPlus_FocusTargetScaleSet(newscale);            
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--ToF debuff
local id = 1;
local UFP_MAX_TOF_DEBUFFS = 5;
for id = 1, UFP_MAX_TOF_DEBUFFS, 1 do
    local debuff;
    debuff = CreateFrame("Button", "UFP_ToFFrameDebuff"..id, ToFFrame);
    debuff:SetFrameLevel(7);
    debuff:SetWidth(15);
    debuff:SetHeight(15);
    debuff:SetID(id);
    debuff:ClearAllPoints();
    if id == 1 then
        -- debuff:SetPoint("BOTTOMLEFT", ToFFrame.Name, "TOPLEFT", -1, 5);--4个
        debuff:SetPoint("BOTTOMLEFT", ToFFrame, "TOPLEFT", 5, 8);--5个
    else
        debuff:SetPoint("LEFT", "UFP_ToFFrameDebuff"..id-1, "RIGHT", 2, 0);
    end
    debuff:SetAttribute("unit", "focustarget");
    RegisterUnitWatch(debuff);

    debuff.Icon = debuff:CreateTexture("UFP_ToFFrameDebuff"..id.."Icon", "ARTWORK");
    debuff.Icon:ClearAllPoints();
    debuff.Icon:SetAllPoints(debuff);

    debuff.Cooldown = CreateFrame("Cooldown", "UFP_ToFFrameDebuff"..id.."Cooldown", debuff, "CooldownFrameTemplate");
    debuff.Cooldown:SetFrameLevel(8);
    debuff.Cooldown:SetReverse(true);
    debuff.Cooldown:ClearAllPoints();
    debuff.Cooldown:SetAllPoints(debuff.Icon);
    debuff.Cooldown:SetParent(debuff);
    -- debuff.Cooldown:Hide();

    debuff.CooldownText = debuff.Cooldown:CreateFontString("UFP_ToFFrameDebuff"..id.."CooldownText", "OVERLAY");
    debuff.CooldownText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
    debuff.CooldownText:SetTextColor(1, 1, 1);--(1, 0.75, 0);
    debuff.CooldownText:ClearAllPoints();
    -- debuff.CooldownText:SetPoint("BOTTOM", debuff.Icon, "TOP", 0, 1);
    debuff.CooldownText:SetPoint("TOPLEFT", debuff.Icon, "TOPLEFT", 0, 0);

    debuff.CountText = debuff.Cooldown:CreateFontString("UFP_ToFFrameDebuff"..id.."CountText", "OVERLAY");
    debuff.CountText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
    debuff.CountText:SetTextColor(1, 1, 1);
    debuff.CountText:ClearAllPoints();
    -- debuff.CountText:SetPoint("CENTER", debuff.Icon, "BOTTOM", 0, 0);
    debuff.CountText:SetPoint("BOTTOMRIGHT", debuff.Icon, "BOTTOMRIGHT", 0, 0);

    debuff.Border = debuff:CreateTexture("UFP_ToFFrameDebuff"..id.."Border", "OVERLAY");
    debuff.Border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays");
    debuff.Border:SetWidth(17);
    debuff.Border:SetHeight(17);
    debuff.Border:SetTexCoord(0.296875, 0.5703125, 0, 0.515625);
    debuff.Border:ClearAllPoints();
    debuff.Border:SetPoint("TOPLEFT", debuff, "TOPLEFT", -1, 1);

    debuff:EnableMouse(true);
    debuff:SetScript("OnEnter",function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 20, -20);
        GameTooltip:SetUnitDebuff("focustarget", id);
    end)
    debuff:SetScript("OnLeave",function()
        GameTooltip:Hide();
    end)
end

local tofdb = CreateFrame("Frame");
function UnitFramesPlus_FocusTargetDebuff()
    UnitFramesPlus_ToFDebuff();
    if UnitFramesPlusDB["focustarget"]["show"] == 1 and UnitFramesPlusDB["focustarget"]["debuff"] == 1 then
        tofdb:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.1 then
                if UnitExists("focustarget") then
                    for id = 1, UFP_MAX_TOF_DEBUFFS do
                        local _, icon, count, _, duration, expires = UnitDebuff("focustarget", id);
                        if icon then
                            local counttext = "";
                            local timetext = "";
                            if count and count > 1 then
                                counttext = count;
                            end
                            _G["UFP_ToFFrameDebuff"..id].Icon:SetTexture(icon);
                            _G["UFP_ToFFrameDebuff"..id]:SetAlpha(1);
                            if UnitFramesPlusDB["focustarget"]["cooldown"] == 1 then
                                CooldownFrame_Set(_G["UFP_ToFFrameDebuff"..id].Cooldown, expires - duration, duration, true);
                                if duration > 0 then
                                    local timeleft = expires - GetTime();
                                    -- local r, g, b = 0, 1, 0;
                                    local alpha = 0.7;
                                    if timeleft >= 0 and timeleft <= 60 then
                                        timetext = math.floor(timeleft);
                                        if timeleft < 15 then
                                            -- r, g, b = UnitFramesPlus_GetRGB(timeleft, 15);
                                            alpha = 1 - timeleft/50;
                                        end
                                    end
                                    -- _G["UFP_ToFFrameDebuff"..id].CooldownText:SetTextColor(r, g, b);
                                    _G["UFP_ToFFrameDebuff"..id].CooldownText:SetAlpha(alpha);
                                end
                            end
                            _G["UFP_ToFFrameDebuff"..id].CooldownText:SetText(timetext);
                            _G["UFP_ToFFrameDebuff"..id].CountText:SetText(counttext);
                        else
                            _G["UFP_ToFFrameDebuff"..id]:SetAlpha(0);
                        end
                    end
                end
                self.timer = 0;
            end
        end)
    else
        for id = 1, UFP_MAX_TOF_DEBUFFS, 1 do
            _G["UFP_ToFFrameDebuff"..id]:SetAlpha(0);
        end
        tofdb:SetScript("OnUpdate", nil);
    end
end

function UnitFramesPlus_OptionsFrame_FocusTargetDebuffCooldownDisplayUpdate()
    if  UnitFramesPlusDB["focustarget"]["cooldown"] == 1 then
        if UnitExists("focustarget") then
            for id = 1, UFP_MAX_TOF_DEBUFFS do
                _G["UFP_ToFFrameDebuff"..id].Cooldown:Show();
                local _, icon, count, _, duration, expires = UnitDebuff("focustarget", id);
                local counttext = "";
                local timetext = "";
                if icon then
                    if count and count > 1 then
                        counttext = count;
                    end
                    CooldownFrame_Set(_G["UFP_ToFFrameDebuff"..id].Cooldown, expires - duration, duration, true);
                    if duration > 0 then
                        local timeleft = expires - GetTime();
                        -- local r, g, b = 0, 1, 0;
                        local alpha = 0.7;
                        if timeleft >= 0 and timeleft <= 60 then
                            timetext = math.floor(timeleft);
                            if timeleft < 15 then
                                -- r, g, b = UnitFramesPlus_GetRGB(timeleft, 15);
                                alpha = 1 - timeleft/50;
                            end
                        end
                        -- _G["UFP_ToFFrameDebuff"..id].CooldownText:SetTextColor(r, g, b);
                        _G["UFP_ToFFrameDebuff"..id].CooldownText:SetAlpha(alpha);
                    end
                -- else
                --     _G["UFP_ToFFrameDebuff"..id].CooldownText:SetText("");
                end
                _G["UFP_ToFFrameDebuff"..id].CooldownText:SetText(timetext);
                _G["UFP_ToFFrameDebuff"..id].CountText:SetText(counttext);
            end
        end
    else
        if UnitExists("focustarget") then
            for id = 1, UFP_MAX_TOF_DEBUFFS do
                _G["UFP_ToFFrameDebuff"..id].Cooldown:Hide();
                _G["UFP_ToFFrameDebuff"..id].CooldownText:SetText("");
            end
        end
    end
end

function UnitFramesPlus_ToFDebuffSet()
    if UnitFramesPlusDB["focustarget"]["debuff"] == 1 then
        for id = 1, UFP_MAX_TOF_DEBUFFS, 1 do
            _G["UFP_ToFFrameDebuff"..id]:SetAttribute("unit", "focustarget");
        end
    else
        for id = 1, UFP_MAX_TOF_DEBUFFS, 1 do
            _G["UFP_ToFFrameDebuff"..id]:SetAttribute("unit", nil);
        end
    end
end

function UnitFramesPlus_ToFDebuff()
    if not InCombatLockdown() then
        UnitFramesPlus_ToFDebuffSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_ToFDebuffSet";
        func.callback = function()
            UnitFramesPlus_ToFDebuffSet();            
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--模块初始化
function UnitFramesPlus_FocusTargetInit()
    UnitFramesPlus_FocusTarget();
    UnitFramesPlus_FocusTargetShiftDrag();
    UnitFramesPlus_FocusTargetDebuff();
end

function UnitFramesPlus_FocusTargetLayout()
    UnitFramesPlus_FocusTargetPosition();
    UnitFramesPlus_FocusTargetScale();
end

