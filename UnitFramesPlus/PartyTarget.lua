--变量
local id = 1;
local _G = _G;
local select = select;
local floor = math.floor;
local UnitExists = UnitExists;
local UnitName = UnitName;
local UnitClass = UnitClass;
local UnitIsDead = UnitIsDead;
local UnitIsPlayer = UnitIsPlayer;
local UnitIsEnemy = UnitIsEnemy;
local UnitIsFriend = UnitIsFriend;
local UnitHealth = UnitHealth;
local UnitHealthMax = UnitHealthMax;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local UnitPowerType = UnitPowerType;
local UnitDebuff = UnitDebuff;
local CooldownFrame_Set = CooldownFrame_Set;
local CooldownFrame_Clear = CooldownFrame_Clear;
local RegisterUnitWatch = RegisterUnitWatch;
local InCombatLockdown = InCombatLockdown;

local UFP_MAX_PARTYTARGET_DEBUFFS = 5;

--队友目标
for id = 1, 4, 1 do
    local ToPFrame = CreateFrame("Button", "UFP_PartyTarget"..id, _G["PartyMemberFrame"..id], "SecureUnitButtonTemplate, SecureHandlerAttributeTemplate");
    ToPFrame:SetFrameLevel(8);
    ToPFrame:SetWidth(80);
    ToPFrame:SetHeight(16);
    ToPFrame:SetAttribute("unit", "party"..id.."target");
    RegisterUnitWatch(ToPFrame);
    ToPFrame:SetAttribute("*type1", "target");
    ToPFrame:RegisterForClicks("AnyUp");
    ToPFrame:SetHitRectInsets(0, 0, -8, -6);

    ToPFrame.Portrait = ToPFrame:CreateTexture("UFP_ToPPortrait"..id, "BORDER");
    ToPFrame.Portrait:SetWidth(27);
    ToPFrame.Portrait:SetHeight(27);
    ToPFrame.Portrait:ClearAllPoints();
    ToPFrame.Portrait:SetPoint("TOPLEFT", ToPFrame, "TOPLEFT", 6, -5);

    ToPFrame.ClassPortrait = ToPFrame:CreateTexture("UFP_ToPClassPortrait"..id, "ARTWORK");
    ToPFrame.ClassPortrait:SetWidth(27);
    ToPFrame.ClassPortrait:SetHeight(27);
    ToPFrame.ClassPortrait:ClearAllPoints();
    ToPFrame.ClassPortrait:SetPoint("TOPLEFT", ToPFrame, "TOPLEFT", 6, -5);
    ToPFrame.ClassPortrait:Hide();

    ToPFrame.Texture = ToPFrame:CreateTexture("UFP_ToPTexture"..id, "ARTWORK");
    ToPFrame.Texture:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame");
    ToPFrame.Texture:SetWidth(96);
    ToPFrame.Texture:SetHeight(48);
    ToPFrame.Texture:ClearAllPoints();
    ToPFrame.Texture:SetPoint("TOPLEFT", ToPFrame, "TOPLEFT", 0, -2);

    ToPFrame.Highlight = ToPFrame:CreateTexture("UFP_ToPFlash"..id, "BACKGROUND");
    ToPFrame.Highlight:SetSize(96, 48);
    ToPFrame.Highlight:ClearAllPoints();
    ToPFrame.Highlight:SetPoint("TOPLEFT", ToPFrame, "TOPLEFT", -2, 1);
    ToPFrame.Highlight:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame-Flash");
    ToPFrame.Highlight:SetVertexColor(1, 0.82, 0);
    ToPFrame.Highlight:SetAlpha(0);

    ToPFrame.Name = ToPFrame:CreateFontString("UFP_ToPName"..id, "ARTWORK");
    -- ToPFrame.Name:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
    ToPFrame.Name:SetTextColor(1, 0.75, 0);
    ToPFrame.Name:ClearAllPoints();
    ToPFrame.Name:SetPoint("BOTTOMLEFT", ToPFrame, "BOTTOMLEFT", 36, 9);

    ToPFrame.HealthBar = CreateFrame("StatusBar", "UFP_ToPHealthBar"..id, ToPFrame);
    ToPFrame.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
    ToPFrame.HealthBar:SetFrameLevel(2);
    ToPFrame.HealthBar:SetMinMaxValues(0, 100);
    ToPFrame.HealthBar:SetValue(0);
    ToPFrame.HealthBar:SetWidth(53);
    ToPFrame.HealthBar:SetHeight(6);
    ToPFrame.HealthBar:ClearAllPoints();
    ToPFrame.HealthBar:SetPoint("TOPLEFT", ToPFrame, "TOPLEFT", 35, -9);
    ToPFrame.HealthBar:SetStatusBarColor(0, 1, 0);

    ToPFrame.HPPct = ToPFrame:CreateFontString("UFP_ToPHPPct"..id, "ARTWORK", "TextStatusBarText");
    ToPFrame.HPPct:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
    ToPFrame.HPPct:SetTextColor(1, 0.75, 0);
    ToPFrame.HPPct:SetJustifyH("LEFT");
    ToPFrame.HPPct:ClearAllPoints();
    ToPFrame.HPPct:SetPoint("LEFT", ToPFrame.HealthBar, "RIGHT", 2, -4);

    ToPFrame.PowerBar = CreateFrame("StatusBar", "UFP_ToPPowerBar"..id, ToPFrame);
    ToPFrame.PowerBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
    ToPFrame.PowerBar:SetFrameLevel(2);
    ToPFrame.PowerBar:SetMinMaxValues(0, 100);
    ToPFrame.PowerBar:SetValue(0);
    ToPFrame.PowerBar:SetWidth(53);
    ToPFrame.PowerBar:SetHeight(6);
    ToPFrame.PowerBar:ClearAllPoints();
    ToPFrame.PowerBar:SetPoint("TOPLEFT", ToPFrame, "TOPLEFT", 35, -16);
    ToPFrame.PowerBar:SetStatusBarColor(0, 0, 1);

    --简易模式
    ToPFrame.Border = ToPFrame:CreateTexture("UFP_ToPBorder", "BORDER");
    ToPFrame.Border:SetTexture("Interface\\Tooltips\\UI-StatusBar-Border");
    ToPFrame.Border:SetWidth(80);
    ToPFrame.Border:SetHeight(16);
    ToPFrame.Border:ClearAllPoints();
    ToPFrame.Border:SetPoint("TOPLEFT", ToPFrame, "TOPLEFT", 1, -6);
    ToPFrame.Border:Hide();
end

function UnitFramesPlus_PartyTarget_ModeSet()
    if UnitFramesPlusDB["partytarget"]["lite"] == 1 then
        for id = 1, 4, 1 do
            _G["UFP_PartyTarget"..id].Border:Show();
            _G["UFP_PartyTarget"..id].Portrait:Hide();
            _G["UFP_PartyTarget"..id].ClassPortrait:Hide();
            _G["UFP_PartyTarget"..id].Texture:Hide();
            _G["UFP_PartyTarget"..id].Highlight:Hide();
            _G["UFP_PartyTarget"..id].PowerBar:Hide();
            _G["UFP_PartyTarget"..id].Name:SetFont(GameFontNormal:GetFont(), 11, "OUTLINE");
            for j = 1, UFP_MAX_PARTYTARGET_DEBUFFS, 1 do
                _G["UFP_PartyTarget"..id.."Debuff"..j]:SetScale(0.75);
            end
            _G["UFP_PartyTarget"..id]:SetScale(1);

            _G["UFP_PartyTarget"..id].Name:ClearAllPoints();
            _G["UFP_PartyTarget"..id].Name:SetPoint("TOPLEFT", _G["UFP_PartyTarget"..id], "TOPLEFT", 3, 4);

            _G["UFP_PartyTarget"..id].HealthBar:SetStatusBarTexture("Interface\\AddOns\\UnitFramesPlus\\PartyTarget");
            _G["UFP_PartyTarget"..id].HealthBar:SetWidth(74);
            _G["UFP_PartyTarget"..id].HealthBar:SetHeight(10);
            _G["UFP_PartyTarget"..id].HealthBar:ClearAllPoints();
            _G["UFP_PartyTarget"..id].HealthBar:SetPoint("TOP", _G["UFP_PartyTarget"..id], "TOP", 1, -9);

            _G["UFP_PartyTarget"..id].HPPct:SetTextColor(1, 1, 1);
            _G["UFP_PartyTarget"..id].HPPct:SetJustifyH("CENTER");
            _G["UFP_PartyTarget"..id].HPPct:ClearAllPoints();
            _G["UFP_PartyTarget"..id].HPPct:SetPoint("CENTER", _G["UFP_PartyTarget"..id].HealthBar, "CENTER", 3, -1);
        end
    else
        for id = 1, 4, 1 do
            _G["UFP_PartyTarget"..id].Border:Hide();
            UnitFramesPlus_PartyTargetClassPortraitDisplayUpdate(id);
            _G["UFP_PartyTarget"..id].Texture:Show();
            _G["UFP_PartyTarget"..id].Highlight:Show();
            _G["UFP_PartyTarget"..id].PowerBar:Show();
            _G["UFP_PartyTarget"..id].Name:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
            for j = 1, UFP_MAX_PARTYTARGET_DEBUFFS, 1 do
                _G["UFP_PartyTarget"..id.."Debuff"..j]:SetScale(1);
            end
            _G["UFP_PartyTarget"..id]:SetScale(0.75);

            _G["UFP_PartyTarget"..id].Name:ClearAllPoints();
            _G["UFP_PartyTarget"..id].Name:SetPoint("BOTTOMLEFT", _G["UFP_PartyTarget"..id], "BOTTOMLEFT", 36, 9);

            _G["UFP_PartyTarget"..id].HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
            _G["UFP_PartyTarget"..id].HealthBar:SetWidth(53);
            _G["UFP_PartyTarget"..id].HealthBar:SetHeight(6);
            _G["UFP_PartyTarget"..id].HealthBar:ClearAllPoints();
            _G["UFP_PartyTarget"..id].HealthBar:SetPoint("TOPLEFT", _G["UFP_PartyTarget"..id], "TOPLEFT", 35, -9);

            _G["UFP_PartyTarget"..id].HPPct:SetTextColor(1, 0.75, 0);
            _G["UFP_PartyTarget"..id].HPPct:SetJustifyH("LEFT");
            _G["UFP_PartyTarget"..id].HPPct:ClearAllPoints();
            _G["UFP_PartyTarget"..id].HPPct:SetPoint("LEFT", _G["UFP_PartyTarget"..id].HealthBar, "RIGHT", 2, -4);
        end
    end
    UnitFramesPlus_PartyTargetPosition();
    UnitFramesPlus_PartyTargetDebuffPosition();
end

function UnitFramesPlus_PartyTarget_Mode()
    if not InCombatLockdown() then
        UnitFramesPlus_PartyTarget_ModeSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PartyTarget_ModeSet";
        func.callback = function()
            UnitFramesPlus_PartyTarget_ModeSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

local topm = CreateFrame("Frame");
function UnitFramesPlus_PartyTarget()
    UnitFramesPlus_ToPMAttribute();
    if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["partytarget"]["show"] == 1 then
        topm:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.2 then
                for id = 1, 4, 1 do
                    UnitFramesPlus_PartyTargetDisplayUpdate(id);
                end
                self.timer = 0;
            end
        end);
    else
        topm:SetScript("OnUpdate", nil);
    end
end

function UnitFramesPlus_PartyTargetDisplayUpdate(id)
    local unit = "party"..id.."target";
    if UnitExists(unit) then
        -- short name
        local name, realm = UnitName(unit);
        local fullname = name;
        if realm and realm ~= "" then
            if UnitFramesPlusDB["partytarget"]["shortname"] == 1 then
                fullname = name.."(*)";
            else
                fullname = name.."-"..realm;
            end
        end
        _G["UFP_PartyTarget"..id].Name:SetText(name);

        local color = NORMAL_FONT_COLOR;
        if UnitFramesPlusDB["partytarget"]["colorname"] == 1 and (UnitFramesPlusDB["partytarget"]["colornamenpcno"] ~= 1 or UnitIsPlayer(unit)) then
            color = RAID_CLASS_COLORS[select(2, UnitClass(unit))] or NORMAL_FONT_COLOR;
        end
        _G["UFP_PartyTarget"..id].Name:SetTextColor(color.r, color.g, color.b);

        local ToPPctText = "";
        if UnitHealthMax(unit) > 0 then
            _G["UFP_PartyTarget"..id].HealthBar:SetValue(UnitHealth(unit) / UnitHealthMax(unit) * 100);
            if UnitFramesPlusDB["partytarget"]["hppct"] == 1 then
                ToPPctText = floor(UnitHealth(unit) / UnitHealthMax(unit) * 100).."%";
            end
        else
            _G["UFP_PartyTarget"..id].HealthBar:SetValue(0);
            if UnitFramesPlusDB["partytarget"]["lite"] == 1 and UnitIsDead(unit) then
                ToPPctText = "|cffeed200"..UFPLocal_DeathText.."|r"
            end
        end
        _G["UFP_PartyTarget"..id].HPPct:SetText(ToPPctText);

        -- SetPortraitTexture(_G["UFP_PartyTarget"..id].Portrait, unit);
        if UnitFramesPlusDB["partytarget"]["lite"] == 1 then
            if UnitIsEnemy("player", unit) then
                _G["UFP_PartyTarget"..id].Border:SetVertexColor(1, 0.2, 0.2);
                _G["UFP_PartyTarget"..id].HealthBar:SetStatusBarColor(1, 0.55, 0.72);
            elseif UnitIsFriend("player", unit) then
                _G["UFP_PartyTarget"..id].Border:SetVertexColor(0, 1, 0);
                _G["UFP_PartyTarget"..id].HealthBar:SetStatusBarColor(0, 1, 0);
            else
                _G["UFP_PartyTarget"..id].Border:SetVertexColor(0.9, 0.82, 0);
                _G["UFP_PartyTarget"..id].HealthBar:SetStatusBarColor(0.65, 0.9, 0.85);
            end
        else
            UnitFramesPlus_PartyTargetClassPortraitDisplayUpdate(id);

            local ToPNameColor = PowerBarColor[UnitPowerType(unit)] or PowerBarColor["MANA"];
            _G["UFP_PartyTarget"..id].PowerBar:SetStatusBarColor(ToPNameColor.r, ToPNameColor.g, ToPNameColor.b);

            if UnitPowerMax(unit) > 0 then
                _G["UFP_PartyTarget"..id].PowerBar:SetValue(UnitPower(unit) / UnitPowerMax(unit) * 100);
            else
                _G["UFP_PartyTarget"..id].PowerBar:SetValue(0);
            end

            -- if UnitFramesPlusDB["partytarget"]["highlight"] == 1 and UnitIsUnit(unit, "target") then
            --     _G["UFP_PartyTarget"..id].Highlight:SetAlpha(0.8);
            -- else
            --     _G["UFP_PartyTarget"..id].Highlight:SetAlpha(0);
            -- end

            if UnitFramesPlusDB["partytarget"]["enemycheck"] == 1 then
                if UnitIsEnemy("player", unit) then
                    _G["UFP_PartyTarget"..id].Highlight:SetAlpha(1);
                    _G["UFP_PartyTarget"..id].Highlight:SetVertexColor(1, 0, 0);
                elseif UnitIsFriend("player", unit) then
                    _G["UFP_PartyTarget"..id].Highlight:SetAlpha(1);
                    _G["UFP_PartyTarget"..id].Highlight:SetVertexColor(0, 1, 0);
                else
                    _G["UFP_PartyTarget"..id].Highlight:SetAlpha(0);
                    _G["UFP_PartyTarget"..id].Highlight:SetVertexColor(1, 0.82, 0);
                end
            end
        end
    else
        --  _G["UFP_PartyTarget"..id].HealthBar:SetValue(0);
        --  _G["UFP_PartyTarget"..id].PowerBar:SetValue(0);
         _G["UFP_PartyTarget"..id].HPPct:SetText("");
    end
end

function UnitFramesPlus_PartyTargetClassPortraitDisplayUpdate(id)
    if UnitFramesPlusDB["partytarget"]["portrait"] == 1 
    and (UnitFramesPlusDB["partytarget"]["portraitnpcno"] ~= 1 or UnitIsPlayer("party"..id.."target")) then
        -- if _G["UFP_PartyTarget"..id].Portrait:IsShown() then
            _G["UFP_PartyTarget"..id].Portrait:Hide();
            _G["UFP_PartyTarget"..id].ClassPortrait:Show();
        -- end
        local IconCoord = CLASS_ICON_TCOORDS[select(2, UnitClass("party"..id.."target"))];
        if IconCoord then
            _G["UFP_PartyTarget"..id].ClassPortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
            _G["UFP_PartyTarget"..id].ClassPortrait:SetTexCoord(unpack(IconCoord));
        end
    else
        -- if _G["UFP_PartyTarget"..id].ClassPortrait:IsShown() then
            _G["UFP_PartyTarget"..id].Portrait:Show();
            _G["UFP_PartyTarget"..id].ClassPortrait:Hide();
        -- end
        SetPortraitTexture(_G["UFP_PartyTarget"..id].Portrait, "party"..id.."target");
    end
end

function UnitFramesPlus_ToPMAttributeSet()
    if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["partytarget"]["show"] == 1 then
        for id = 1, 4, 1 do
            _G["UFP_PartyTarget"..id]:SetAttribute("unit", "party"..id.."target");
        end
    else
        for id = 1, 4, 1 do
            _G["UFP_PartyTarget"..id]:SetAttribute("unit", nil);
        end
    end
end

function UnitFramesPlus_ToPMAttribute()
    if not InCombatLockdown() then
        UnitFramesPlus_ToPMAttributeSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_ToPMAttributeSet";
        func.callback = function()
            UnitFramesPlus_ToPMAttributeSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

function UnitFramesPlus_PartyTargetPositionSet()
    local xOffset, yOffset;
    if UnitFramesPlusDB["partytarget"]["lite"] == 1 then
        xOffset = 151;
        if UnitFramesPlusDB["party"]["hp"] == 1 and UnitFramesPlusDB["party"]["hppct"] == 0 then
            xOffset = 211;
        end
        yOffset = -8;
    else
        xOffset = 151+50;
        if UnitFramesPlusDB["party"]["hp"] == 1 and UnitFramesPlusDB["party"]["hppct"] == 0 then
            xOffset = 231+50;
        end
        yOffset = -5;
    end
    for id = 1, 4, 1 do
        _G["UFP_PartyTarget"..id]:ClearAllPoints();
        _G["UFP_PartyTarget"..id]:SetPoint("TOPLEFT", _G["PartyMemberFrame"..id], "TOPLEFT", xOffset, yOffset);
    end
end

function UnitFramesPlus_PartyTargetPosition()
    if not InCombatLockdown() then
        UnitFramesPlus_PartyTargetPositionSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PartyTargetPositionSet";
        func.callback = function()
            UnitFramesPlus_PartyTargetPositionSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--ToT debuff
for id = 1, 4, 1 do
    for j = 1, UFP_MAX_PARTYTARGET_DEBUFFS, 1 do
        local debuff = CreateFrame("Button", "UFP_PartyTarget"..id.."Debuff"..j, _G["UFP_PartyTarget"..id]);
        debuff:SetFrameLevel(7);
        debuff:SetWidth(17);
        debuff:SetHeight(17);
        debuff:SetID(j);
        debuff:ClearAllPoints();
        if j == 1 then
            debuff:SetPoint("LEFT", _G["UFP_PartyTarget"..id].HealthBar, "RIGHT", 40, -4);--右侧大小17
            -- debuff:SetPoint("TOPLEFT", _G["UFP_PartyTarget"..id], "TOPLEFT", 38, -26);--血条下面大小12
        else
            debuff:SetPoint("LEFT", _G["UFP_PartyTarget"..id.."Debuff"..j-1], "RIGHT", 2, 0);
        end
        debuff:SetAttribute("unit", "party"..id.."target");
        RegisterUnitWatch(debuff);

        debuff.Icon = debuff:CreateTexture("UFP_PartyTarget"..id.."Debuff"..j.."Icon", "ARTWORK");
        debuff.Icon:ClearAllPoints();
        debuff.Icon:SetAllPoints(debuff);

        debuff.Cooldown = CreateFrame("Cooldown", "UFP_PartyTarget"..id.."Debuff"..j.."Cooldown", debuff, "CooldownFrameTemplate");
        debuff.Cooldown:SetFrameLevel(8);
        debuff.Cooldown:SetReverse(true);
        debuff.Cooldown:ClearAllPoints();
        debuff.Cooldown:SetAllPoints(debuff.Icon);
        debuff.Cooldown:SetParent(debuff);
        -- debuff.Cooldown:Hide();

        debuff.CooldownText = debuff.Cooldown:CreateFontString("UFP_PartyTarget"..id.."Debuff"..j.."CooldownText", "OVERLAY");
        debuff.CooldownText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
        debuff.CooldownText:SetTextColor(1, 1, 1);--(1, 0.75, 0);
        debuff.CooldownText:ClearAllPoints();
        debuff.CooldownText:SetPoint("CENTER", debuff.Icon, "CENTER", 0, 0);
        -- debuff.CooldownText:SetPoint("TOPLEFT", debuff.Icon, "TOPLEFT", 0, 0);

        debuff.CountText = debuff.Cooldown:CreateFontString("UFP_PartyTarget"..id.."Debuff"..j.."CountText", "OVERLAY");
        debuff.CountText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
        debuff.CountText:SetTextColor(1, 1, 1);
        debuff.CountText:ClearAllPoints();
        -- debuff.CountText:SetPoint("CENTER", debuff.Icon, "BOTTOM", 0, 0);
        debuff.CountText:SetPoint("BOTTOMRIGHT", debuff.Icon, "BOTTOMRIGHT", 0, 0);

        debuff.Border = debuff:CreateTexture("UFP_PartyTarget"..id.."Debuff"..j.."Border", "OVERLAY");
        debuff.Border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays");
        debuff.Border:SetWidth(17);
        debuff.Border:SetHeight(17);
        debuff.Border:SetTexCoord(0.296875, 0.5703125, 0, 0.515625);
        debuff.Border:ClearAllPoints();
        debuff.Border:SetPoint("TOPLEFT", debuff, "TOPLEFT", -1, 1);

        debuff:EnableMouse(true);
        debuff:SetScript("OnEnter",function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
            GameTooltip:SetUnitDebuff("party"..id.."target", j);
        end)
        debuff:SetScript("OnLeave",function()
            GameTooltip:Hide();
        end)
    end
end

local topdb = CreateFrame("Frame");
function UnitFramesPlus_PartyTargetDebuff()
    UnitFramesPlus_PartyMemberPosition();
    if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["partytarget"]["show"] == 1 and UnitFramesPlusDB["partytarget"]["debuff"] == 1 then
        topdb:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.1 then
                UnitFramesPlus_OptionsFrame_PartyTargetDebuffDisplayUpdate();
                self.timer = 0;
            end
        end)
    else
        for id = 1, 4, 1 do
            for j = 1, UFP_MAX_PARTYTARGET_DEBUFFS, 1 do
                _G["UFP_PartyTarget"..id.."Debuff"..j]:SetAlpha(0);
                _G["UFP_PartyTarget"..id.."Debuff"..j].Cooldown:SetAlpha(0);
                _G["UFP_PartyTarget"..id.."Debuff"..j].CooldownText:SetText("");
                _G["UFP_PartyTarget"..id.."Debuff"..j].CountText:SetText("");
            end
        end
        topdb:SetScript("OnUpdate", nil);
    end
end

function UnitFramesPlus_OptionsFrame_PartyTargetDebuffDisplayUpdate()
    for id = 1, 4, 1 do
        if UnitExists("party"..id.."target") then
            for j = 1, UFP_MAX_PARTYTARGET_DEBUFFS, 1 do
                local alpha = 0;
                local cdalpha = 0;
                local timetext = "";
                local counttext = "";
                -- local textalpha = 0.7;
                -- local r, g, b = 0, 1, 0;
                local _, icon, count, _, duration, expirationTime, caster, _, _, spellId = UnitDebuff("party"..id.."target", j);
                if icon then
                    _G["UFP_PartyTarget"..id.."Debuff"..j].Icon:SetTexture(icon);
                    alpha = 1;
                    if count and count > 1 then
                        counttext = count;
                    end
                    if UnitFramesPlusDB["partytarget"]["cooldown"] == 1 then
                        cdalpha = 1;
                        if UnitFramesPlusDB["global"]["builtincd"] == 1 and UFPClassicDurations then
                            local durationNew, expirationTimeNew = UFPClassicDurations:GetAuraDurationByUnit("party"..id.."target", spellId, caster)
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
                            CooldownFrame_Set(_G["UFP_PartyTarget"..id.."Debuff"..j].Cooldown, expirationTime - duration, duration, true);
                        else
                            CooldownFrame_Clear(_G["UFP_PartyTarget"..id.."Debuff"..j].Cooldown);
                        end
                    end
                end
                _G["UFP_PartyTarget"..id.."Debuff"..j]:SetAlpha(alpha);
                _G["UFP_PartyTarget"..id.."Debuff"..j].Cooldown:SetAlpha(cdalpha);
                -- _G["UFP_PartyTarget"..id.."Debuff"..j].CooldownText:SetTextColor(r, g, b);
                -- _G["UFP_PartyTarget"..id.."Debuff"..j].CooldownText:SetAlpha(textalpha);
                _G["UFP_PartyTarget"..id.."Debuff"..j].CooldownText:SetText(timetext);
                _G["UFP_PartyTarget"..id.."Debuff"..j].CountText:SetText(counttext);
            end
        end
    end
end

function UnitFramesPlus_PartyTargetDebuffPositionSet()
    local xOffset = 35+5;
    local yOffset = -4;
    if UnitFramesPlusDB["partytarget"]["hppct"] == 0 or UnitFramesPlusDB["partytarget"]["lite"] == 1 then
        xOffset = 5;
    end
    if UnitFramesPlusDB["partytarget"]["lite"] == 1 then
        yOffset = 0;
    end
    for id = 1, 4, 1 do
        _G["UFP_PartyTarget"..id.."Debuff1"]:ClearAllPoints();
        _G["UFP_PartyTarget"..id.."Debuff1"]:SetPoint("LEFT", _G["UFP_PartyTarget"..id].HealthBar, "RIGHT", xOffset, yOffset);
    end
end

function UnitFramesPlus_PartyTargetDebuffPosition()
    if not InCombatLockdown() then
        UnitFramesPlus_PartyTargetDebuffPositionSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PartyTargetDebuffPositionSet";
        func.callback = function()
            UnitFramesPlus_PartyTargetDebuffPositionSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--模块初始化
function UnitFramesPlus_PartyTargetInit()
    UnitFramesPlus_PartyTarget();
    UnitFramesPlus_PartyTargetDebuff();
    UnitFramesPlus_PartyTarget_Mode();
end

function UnitFramesPlus_PartyTargetLayout()
    UnitFramesPlus_PartyTargetPosition();
    UnitFramesPlus_PartyTargetDebuffPosition();
end
