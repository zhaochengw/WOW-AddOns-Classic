--变量
local floor = math.floor;
local select = select;
local UnitExists = UnitExists;
local UnitName = UnitName;
local UnitClass = UnitClass;
local UnitIsPlayer = UnitIsPlayer;
local UnitIsEnemy = UnitIsEnemy;
local UnitIsFriend = UnitIsFriend;
local UnitHealth = UnitHealth;
local UnitHealthMax = UnitHealthMax;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local UnitPowerType = UnitPowerType;
local UnitDebuff = UnitDebuff;
local GetTime = GetTime;
local IsShiftKeyDown = IsShiftKeyDown;
local InCombatLockdown = InCombatLockdown;
local RegisterUnitWatch = RegisterUnitWatch;
local SetPortraitTexture = SetPortraitTexture;
local CooldownFrame_Set = CooldownFrame_Set;
local CooldownFrame_Clear = CooldownFrame_Clear;
local hooksecurefunc = hooksecurefunc;

--ToT
local ToTFrame = CreateFrame("Button", "UFP_ToTFrame", TargetFrame, "SecureUnitButtonTemplate, SecureHandlerAttributeTemplate");
ToTFrame:SetFrameLevel(8);
ToTFrame:SetWidth(96);
ToTFrame:SetHeight(48);
ToTFrame:ClearAllPoints();
ToTFrame:SetPoint("LEFT", TargetFrame, "RIGHT", -20, 0);
ToTFrame:SetMovable(1);

ToTFrame:SetAttribute("unit", "targettarget");
RegisterUnitWatch(ToTFrame);
ToTFrame:SetAttribute("*type1", "target");
ToTFrame:RegisterForClicks("AnyUp");
ToTFrame:RegisterForDrag("LeftButton");

ToTFrame.Portrait = ToTFrame:CreateTexture("UFP_ToTPortrait", "BORDER");
ToTFrame.Portrait:SetWidth(27);
ToTFrame.Portrait:SetHeight(27);
ToTFrame.Portrait:ClearAllPoints();
ToTFrame.Portrait:SetPoint("TOPLEFT", ToTFrame, "TOPLEFT", 6, -5);

ToTFrame.ClassPortrait = ToTFrame:CreateTexture("UFP_ToTClassPortrait", "ARTWORK");
ToTFrame.ClassPortrait:SetWidth(27);
ToTFrame.ClassPortrait:SetHeight(27);
ToTFrame.ClassPortrait:ClearAllPoints();
ToTFrame.ClassPortrait:SetPoint("TOPLEFT", ToTFrame, "TOPLEFT", 6, -5);
ToTFrame.ClassPortrait:Hide();

ToTFrame.Texture = ToTFrame:CreateTexture("UFP_ToTTexture", "ARTWORK");
ToTFrame.Texture:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame");
ToTFrame.Texture:SetWidth(96);
ToTFrame.Texture:SetHeight(48);
ToTFrame.Texture:ClearAllPoints();
ToTFrame.Texture:SetPoint("TOPLEFT", ToTFrame, "TOPLEFT", 0, -2);

ToTFrame.Highlight = ToTFrame:CreateTexture("UFP_ToTFlash", "BACKGROUND");
ToTFrame.Highlight:SetSize(96, 48);
ToTFrame.Highlight:ClearAllPoints();
ToTFrame.Highlight:SetPoint("TOPLEFT", ToTFrame, "TOPLEFT", -2, 1);
ToTFrame.Highlight:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame-Flash");
ToTFrame.Highlight:SetVertexColor(1, 0.82, 0);
ToTFrame.Highlight:SetAlpha(0);

-- ToTFrame.Name = ToTFrame:CreateFontString("UFP_ToTName", "ARTWORK", "GameFontNormalSmall");
ToTFrame.Name = ToTFrame:CreateFontString("UFP_ToTName", "ARTWORK");
ToTFrame.Name:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
ToTFrame.Name:SetTextColor(1, 0.75, 0);
ToTFrame.Name:ClearAllPoints();
ToTFrame.Name:SetPoint("BOTTOMLEFT", ToTFrame, "BOTTOMLEFT", 36, 39);

ToTFrame.HealthBar = CreateFrame("StatusBar", "UFP_ToTHealthBar", ToTFrame);
ToTFrame.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToTFrame.HealthBar:SetFrameLevel(2);
ToTFrame.HealthBar:SetMinMaxValues(0, 100);
ToTFrame.HealthBar:SetValue(0);
ToTFrame.HealthBar:SetWidth(53);
ToTFrame.HealthBar:SetHeight(6);
ToTFrame.HealthBar:ClearAllPoints();
ToTFrame.HealthBar:SetPoint("TOPLEFT", ToTFrame, "TOPLEFT", 35, -9);
ToTFrame.HealthBar:SetStatusBarColor(0, 1, 0);

-- ToTFrame.HPPct = ToTFrame:CreateFontString("UFP_ToTHPPct", "ARTWORK", "TextStatusBarText");
ToTFrame.HPPct = ToTFrame:CreateFontString("UFP_ToTHPPct", "ARTWORK");
ToTFrame.HPPct:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
ToTFrame.HPPct:SetTextColor(1, 0.75, 0);
ToTFrame.HPPct:SetJustifyH("LEFT");
ToTFrame.HPPct:ClearAllPoints();
ToTFrame.HPPct:SetPoint("LEFT", ToTFrame.HealthBar, "RIGHT", 2, -4);

ToTFrame.PowerBar = CreateFrame("StatusBar", "UFP_ToTPowerBar", ToTFrame);
ToTFrame.PowerBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToTFrame.PowerBar:SetFrameLevel(2);
ToTFrame.PowerBar:SetMinMaxValues(0, 100);
ToTFrame.PowerBar:SetValue(0);
ToTFrame.PowerBar:SetWidth(53);
ToTFrame.PowerBar:SetHeight(6);
ToTFrame.PowerBar:ClearAllPoints();
ToTFrame.PowerBar:SetPoint("TOPLEFT", ToTFrame, "TOPLEFT", 35, -16);
ToTFrame.PowerBar:SetStatusBarColor(0, 0, 1);

local tot = CreateFrame("Frame");
function UnitFramesPlus_TargetTarget()
    UnitFramesPlus_ToTAttribute();
    if UnitFramesPlusDB["targettarget"]["showtot"] == 1 then
        tot:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.2 then
                UnitFramesPlus_TargetTargetDisplayUpdate();
                self.timer = 0;
            end
        end);
    else
        -- ToTFrame.HealthBar:SetValue(0);
        -- ToTFrame.PowerBar:SetValue(0);
        ToTFrame.HPPct:SetText("");
        tot:SetScript("OnUpdate", nil);
    end
end

function UnitFramesPlus_TargetTargetDisplayUpdate()
    if UnitExists("targettarget") then
        local name = UnitName("targettarget");
        -- local name, realm = UnitName("targettarget");
        -- local fullname = name;
        -- if realm then
        --     if UnitFramesPlusDB["targettarget"]["shortname"] == 1 then
        --         fullname = name.."(*)";
        --     else
        --         fullname = name.."-"..realm;
        --     end
        -- end
        -- ToTFrame.Name:SetText(fullname);
        ToTFrame.Name:SetText(name);

        local color = NORMAL_FONT_COLOR;
        if UnitFramesPlusDB["targettarget"]["colorname"] == 1 and (UnitFramesPlusDB["targettarget"]["colornamenpcno"] ~= 1 or UnitIsPlayer("targettarget")) then
            color = RAID_CLASS_COLORS[select(2, UnitClass("targettarget"))] or NORMAL_FONT_COLOR;
        end
        ToTFrame.Name:SetTextColor(color.r, color.g, color.b);

        local ToTNameColor = PowerBarColor[UnitPowerType("targettarget")] or PowerBarColor["MANA"];
        ToTFrame.PowerBar:SetStatusBarColor(ToTNameColor.r, ToTNameColor.g, ToTNameColor.b);

        -- SetPortraitTexture(ToTFrame.Portrait, "targettarget");
        UnitFramesPlus_TargetTargetClassPortraitDisplayUpdate();

        if UnitHealthMax("targettarget") > 0 then
            ToTFrame.HealthBar:SetValue(UnitHealth("targettarget") / UnitHealthMax("targettarget") * 100);
            local ToTPctText = "";
            if UnitFramesPlusDB["targettarget"]["hppct"] == 1 then
                ToTPctText = floor(UnitHealth("targettarget") / UnitHealthMax("targettarget") * 100).."%";
            end
            ToTFrame.HPPct:SetText(ToTPctText);
        else
            ToTFrame.HealthBar:SetValue(0);
            ToTFrame.HPPct:SetText("");
        end

        if UnitPowerMax("targettarget") > 0 then
            ToTFrame.PowerBar:SetValue(UnitPower("targettarget") / UnitPowerMax("targettarget") * 100);
        else
            ToTFrame.PowerBar:SetValue(0);
        end

        if UnitFramesPlusDB["targettarget"]["enemycheck"] == 1 then
            if UnitIsEnemy("player", "targettarget") then
                ToTFrame.Highlight:SetAlpha(1);
                ToTFrame.Highlight:SetVertexColor(1, 0, 0);
            elseif UnitIsFriend("player", "targettarget") then
                ToTFrame.Highlight:SetAlpha(1);
                ToTFrame.Highlight:SetVertexColor(0, 1, 0);
            else
                ToTFrame.Highlight:SetAlpha(0);
                ToTFrame.Highlight:SetVertexColor(1, 0.82, 0);
            end
        end
    else
        -- ToTFrame.HealthBar:SetValue(0);
        -- ToTFrame.PowerBar:SetValue(0);
        ToTFrame.HPPct:SetText("");
    end
end

function UnitFramesPlus_TargetTargetClassPortraitDisplayUpdate()
    if UnitFramesPlusDB["targettarget"]["portrait"] == 1 
    and (UnitFramesPlusDB["targettarget"]["portraitnpcno"] ~= 1 or UnitIsPlayer("targettarget")) then
        if ToTFrame.Portrait:IsShown() then
            ToTFrame.Portrait:Hide();
            ToTFrame.ClassPortrait:Show();
        end
        local IconCoord = CLASS_ICON_TCOORDS[select(2, UnitClass("targettarget"))];
        if IconCoord then
            ToTFrame.ClassPortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
            ToTFrame.ClassPortrait:SetTexCoord(unpack(IconCoord));
        end
    else
        if ToTFrame.ClassPortrait:IsShown() then
            ToTFrame.Portrait:Show();
            ToTFrame.ClassPortrait:Hide();
        end
        SetPortraitTexture(ToTFrame.Portrait, "targettarget");
    end
end

function UnitFramesPlus_ToTAttributeSet()
    if UnitFramesPlusDB["targettarget"]["showtot"] == 1 then
        ToTFrame:SetAttribute("unit", "targettarget");
    else
        ToTFrame:SetAttribute("unit", nil);
    end
end

function UnitFramesPlus_ToTAttribute()
    if not InCombatLockdown() then
        UnitFramesPlus_ToTAttributeSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_ToTAttributeSet";
        func.callback = function()
            UnitFramesPlus_ToTAttributeSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--非战斗状态中允许shift+左键拖动ToT头像
function UnitFramesPlus_TargetTargetPositionSet()
    if UnitFramesPlusVar["targettarget"]["moved"] == 1 then
        ToTFrame:ClearAllPoints();
        ToTFrame:SetPoint("BOTTOMLEFT", TargetFrame, "BOTTOMLEFT", UnitFramesPlusVar["targettarget"]["x"], UnitFramesPlusVar["targettarget"]["y"]);
    else
        ToTFrame:ClearAllPoints();
        ToTFrame:SetPoint("LEFT", TargetFrame, "RIGHT", -20, 0);
    end
end

function UnitFramesPlus_TargetTargetPosition()
    if not InCombatLockdown() then
        UnitFramesPlus_TargetTargetPositionSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_TargetTargetPositionSet";
        func.callback = function()
            UnitFramesPlus_TargetTargetPositionSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

local function UnitFramesPlus_TargetTargetShiftDrag()
    ToTFrame:SetScript("OnMouseDown", function(self, elapsed)
        if UnitFramesPlusDB["target"]["movable"] == 1 then
            if IsShiftKeyDown() and (not InCombatLockdown()) then
                ToTFrame:StartMoving();
                UnitFramesPlusVar["targettarget"]["moving"] = 1;
            end
        end
    end)

    ToTFrame:SetScript("OnMouseUp", function(self, elapsed)
        if UnitFramesPlusVar["targettarget"]["moving"] == 1 then
            ToTFrame:StopMovingOrSizing();
            UnitFramesPlusVar["targettarget"]["moving"] = 0;
            UnitFramesPlusVar["targettarget"]["moved"] = 1;
            local bottom = ToTFrame:GetBottom();
            local left = ToTFrame:GetLeft();
            local scale = ToTFrame:GetScale()*TargetFrame:GetScale();
            local bottomX = TargetFrame:GetBottom();
            local leftX = TargetFrame:GetLeft();
            local scaleX = TargetFrame:GetScale();
            UnitFramesPlusVar["targettarget"]["x"] = (left*scale-leftX*scaleX)/scale;
            UnitFramesPlusVar["targettarget"]["y"] = (bottom*scale-bottomX*scaleX)/scale;
            ToTFrame:ClearAllPoints();
            ToTFrame:SetPoint("BOTTOMLEFT", TargetFrame, "BOTTOMLEFT", UnitFramesPlusVar["targettarget"]["x"], UnitFramesPlusVar["targettarget"]["y"]);
        end
    end)

    ToTFrame:SetClampedToScreen(1);

    --重置目标位置时同时重置ToT位置
    hooksecurefunc("TargetFrame_ResetUserPlacedPosition", function()
        UnitFramesPlusVar["targettarget"]["moved"] = 0;
        UnitFramesPlus_TargetTargetPosition();
    end)
end

--ToT debuff
local id = 1;
local UFP_MAX_TOT_DEBUFFS = 5;
for id = 1, UFP_MAX_TOT_DEBUFFS, 1 do
    local debuff;
    debuff = CreateFrame("Button", "UFP_ToTFrameDebuff"..id, ToTFrame);
    debuff:SetFrameLevel(7);
    debuff:SetWidth(15);
    debuff:SetHeight(15);
    debuff:SetID(id);
    debuff:ClearAllPoints();
    if id == 1 then
        -- debuff:SetPoint("BOTTOMLEFT", ToTFrame.Name, "TOPLEFT", -1, 5);--4个
        debuff:SetPoint("BOTTOMLEFT", ToTFrame, "TOPLEFT", 5, 8);--5个
    else
        debuff:SetPoint("LEFT", "UFP_ToTFrameDebuff"..id-1, "RIGHT", 2, 0);
    end
    debuff:SetAttribute("unit", "targettarget");
    RegisterUnitWatch(debuff);
    --Frame:SetFrameLevel(level)

    debuff.Icon = debuff:CreateTexture("UFP_ToTFrameDebuff"..id.."Icon", "ARTWORK");
    debuff.Icon:ClearAllPoints();
    debuff.Icon:SetAllPoints(debuff);

    debuff.Cooldown = CreateFrame("Cooldown", "UFP_ToTFrameDebuff"..id.."Cooldown", debuff, "CooldownFrameTemplate");
    debuff.Cooldown:SetFrameLevel(8);
    debuff.Cooldown:SetReverse(true);
    debuff.Cooldown:ClearAllPoints();
    debuff.Cooldown:SetAllPoints(debuff.Icon);
    debuff.Cooldown:SetParent(debuff);
    -- debuff.Cooldown:Hide();

    debuff.CooldownText = debuff.Cooldown:CreateFontString("UFP_ToTFrameDebuff"..id.."CooldownText", "OVERLAY");
    debuff.CooldownText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
    debuff.CooldownText:SetTextColor(1, 1, 1);--(1, 0.75, 0);
    debuff.CooldownText:ClearAllPoints();
    debuff.CooldownText:SetPoint("CENTER", debuff.Icon, "CENTER", 0, 0);
    -- debuff.CooldownText:SetPoint("TOPLEFT", debuff.Icon, "TOPLEFT", 0, 0);

    debuff.CountText = debuff.Cooldown:CreateFontString("UFP_ToTFrameDebuff"..id.."CountText", "OVERLAY");
    debuff.CountText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
    debuff.CountText:SetTextColor(1, 1, 1);
    debuff.CountText:ClearAllPoints();
    -- debuff.CountText:SetPoint("CENTER", debuff.Icon, "BOTTOM", 0, 0);
    debuff.CountText:SetPoint("BOTTOMRIGHT", debuff.Icon, "BOTTOMRIGHT", 0, 0);


    debuff.Border = debuff:CreateTexture("UFP_ToTFrameDebuff"..id.."Border", "OVERLAY");
    debuff.Border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays");
    debuff.Border:SetWidth(17);
    debuff.Border:SetHeight(17);
    debuff.Border:SetTexCoord(0.296875, 0.5703125, 0, 0.515625);
    debuff.Border:ClearAllPoints();
    debuff.Border:SetPoint("TOPLEFT", debuff, "TOPLEFT", -1, 1);

    debuff:EnableMouse(true);
    debuff:SetScript("OnEnter",function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 20, -20);
        GameTooltip:SetUnitDebuff("targettarget", id);
    end)
    debuff:SetScript("OnLeave",function()
        GameTooltip:Hide();
    end)
end

local totdb = CreateFrame("Frame");
function UnitFramesPlus_TargetTargetDebuff()
    UnitFramesPlus_ToTDebuff();
    if UnitFramesPlusDB["targettarget"]["debuff"] == 1 then
        totdb:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.1 then
                UnitFramesPlus_OptionsFrame_TargetTargetDebuffDisplayUpdate();
                self.timer = 0;
            end
        end)
    else
        for id = 1, UFP_MAX_TOT_DEBUFFS, 1 do
            _G["UFP_ToTFrameDebuff"..id]:SetAlpha(0);
            _G["UFP_ToTFrameDebuff"..id].Cooldown:SetAlpha(0);
            _G["UFP_ToTFrameDebuff"..id].CooldownText:SetText("");
            _G["UFP_ToTFrameDebuff"..id].CountText:SetText("");
        end
        totdb:SetScript("OnUpdate", nil);
    end
end

function UnitFramesPlus_OptionsFrame_TargetTargetDebuffDisplayUpdate()
    if UnitExists("targettarget") then
        for id = 1, UFP_MAX_TOT_DEBUFFS do
            local alpha = 0;
            local cdalpha = 0;
            local timetext = "";
            local counttext = "";
            -- local textalpha = 0.7;
            -- local r, g, b = 0, 1, 0;
            local _, icon, count, _, duration, expirationTime, caster, _, _, spellId = UnitDebuff("targettarget", id);
            if icon then
                _G["UFP_ToTFrameDebuff"..id].Icon:SetTexture(icon);
                alpha = 1;
                if count and count > 1 then
                    counttext = count;
                end
                if UnitFramesPlusDB["targettarget"]["cooldown"] == 1 then
                    cdalpha = 1;
                    if UnitFramesPlusDB["global"]["builtincd"] == 1 and UFPClassicDurations then
                        local durationNew, expirationTimeNew = UFPClassicDurations:GetAuraDurationByUnit("targettarget", spellId, caster)
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
                        CooldownFrame_Set(_G["UFP_ToTFrameDebuff"..id].Cooldown, expirationTime - duration, duration, true);
                    else
                        CooldownFrame_Clear(_G["UFP_ToTFrameDebuff"..id].Cooldown);
                    end
                end
            end
            _G["UFP_ToTFrameDebuff"..id]:SetAlpha(alpha);
            _G["UFP_ToTFrameDebuff"..id].Cooldown:SetAlpha(cdalpha);
            -- _G["UFP_ToTFrameDebuff"..id].CooldownText:SetTextColor(r, g, b);
            -- _G["UFP_ToTFrameDebuff"..id].CooldownText:SetAlpha(textalpha);
            _G["UFP_ToTFrameDebuff"..id].CooldownText:SetText(timetext);
            _G["UFP_ToTFrameDebuff"..id].CountText:SetText(counttext);
        end
    end
end

function UnitFramesPlus_ToTDebuffSet()
    if UnitFramesPlusDB["targettarget"]["debuff"] == 1 then
        for id = 1, UFP_MAX_TOT_DEBUFFS, 1 do
            _G["UFP_ToTFrameDebuff"..id]:SetAttribute("unit", "targettarget");
        end
    else
        for id = 1, UFP_MAX_TOT_DEBUFFS, 1 do
            _G["UFP_ToTFrameDebuff"..id]:SetAttribute("unit", nil);
        end
    end
end

function UnitFramesPlus_ToTDebuff()
    if not InCombatLockdown() then
        UnitFramesPlus_ToTDebuffSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_ToTDebuffSet";
        func.callback = function()
            UnitFramesPlus_ToTDebuffSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--ToToT
local ToToTFrame = CreateFrame("Button", "UFP_ToToTFrame", TargetFrame, "SecureUnitButtonTemplate, SecureHandlerAttributeTemplate");
ToToTFrame:SetFrameLevel(8);
ToToTFrame:SetWidth(96);
ToToTFrame:SetHeight(48);
ToToTFrame:ClearAllPoints();
ToToTFrame:SetPoint("TOP", ToTFrame, "BOTTOM", 26, 16);

ToToTFrame:SetAttribute("unit", "targettargettarget");
RegisterUnitWatch(ToToTFrame);
ToToTFrame:SetAttribute("*type1", "target");
ToToTFrame:RegisterForClicks("AnyUp");

ToToTFrame.Portrait = ToToTFrame:CreateTexture("UFP_ToToTPortrait", "BORDER");
ToToTFrame.Portrait:SetWidth(27);
ToToTFrame.Portrait:SetHeight(27);
ToToTFrame.Portrait:ClearAllPoints();
ToToTFrame.Portrait:SetPoint("TOPLEFT", ToToTFrame, "TOPLEFT", 6, -5);

ToToTFrame.ClassPortrait = ToToTFrame:CreateTexture("UFP_ToToTClassPortrait", "ARTWORK");
ToToTFrame.ClassPortrait:SetWidth(27);
ToToTFrame.ClassPortrait:SetHeight(27);
ToToTFrame.ClassPortrait:ClearAllPoints();
ToToTFrame.ClassPortrait:SetPoint("TOPLEFT", ToToTFrame, "TOPLEFT", 6, -5);
ToToTFrame.ClassPortrait:Hide();

ToToTFrame.Texture = ToToTFrame:CreateTexture("UFP_ToToTTexture", "ARTWORK");
ToToTFrame.Texture:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame");
ToToTFrame.Texture:SetWidth(96);
ToToTFrame.Texture:SetHeight(48);
ToToTFrame.Texture:ClearAllPoints();
ToToTFrame.Texture:SetPoint("TOPLEFT", ToToTFrame, "TOPLEFT", 0, -2);

ToToTFrame.Highlight = ToToTFrame:CreateTexture("UFP_ToToTFlash", "BACKGROUND");
ToToTFrame.Highlight:SetSize(96, 48);
ToToTFrame.Highlight:ClearAllPoints();
ToToTFrame.Highlight:SetPoint("TOPLEFT", ToToTFrame, "TOPLEFT", -2, 1);
ToToTFrame.Highlight:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame-Flash");
ToToTFrame.Highlight:SetVertexColor(1, 0.82, 0);
ToToTFrame.Highlight:SetAlpha(0);

ToToTFrame.Name = ToToTFrame:CreateFontString("UFP_ToToTName", "ARTWORK");
ToToTFrame.Name:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
ToToTFrame.Name:SetTextColor(1, 0.75, 0);
ToToTFrame.Name:ClearAllPoints();
ToToTFrame.Name:SetPoint("BOTTOMLEFT", ToToTFrame, "BOTTOMLEFT", 36, 39);

ToToTFrame.HealthBar = CreateFrame("StatusBar", "UFP_ToToTHealthBar", ToToTFrame);
ToToTFrame.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToToTFrame.HealthBar:SetFrameLevel(2);
ToToTFrame.HealthBar:SetMinMaxValues(0, 100);
ToToTFrame.HealthBar:SetValue(0);
ToToTFrame.HealthBar:SetWidth(53);
ToToTFrame.HealthBar:SetHeight(6);
ToToTFrame.HealthBar:ClearAllPoints();
ToToTFrame.HealthBar:SetPoint("TOPLEFT", ToToTFrame, "TOPLEFT", 35, -9);
ToToTFrame.HealthBar:SetStatusBarColor(0, 1, 0);

ToToTFrame.PowerBar = CreateFrame("StatusBar", "UFP_ToToTPowerBar", ToToTFrame);
ToToTFrame.PowerBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToToTFrame.PowerBar:SetFrameLevel(2);
ToToTFrame.PowerBar:SetMinMaxValues(0, 100);
ToToTFrame.PowerBar:SetValue(0);
ToToTFrame.PowerBar:SetWidth(53);
ToToTFrame.PowerBar:SetHeight(6);
ToToTFrame.PowerBar:ClearAllPoints();
ToToTFrame.PowerBar:SetPoint("TOPLEFT", ToToTFrame, "TOPLEFT", 35, -16);
ToToTFrame.PowerBar:SetStatusBarColor(0, 0, 1);

local totot = CreateFrame("Frame");
function UnitFramesPlus_TargetTargetTarget()
    UnitFramesPlus_ToToTAttribute();
    if UnitFramesPlusDB["targettarget"]["showtot"] == 1 and UnitFramesPlusDB["targettarget"]["showtotot"] == 1 then
        totot:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.2 then
                ToToTFrame.HealthBar:SetValue(0);
                ToToTFrame.PowerBar:SetValue(0);
                if UnitExists("targettargettarget") then
                    ToToTFrame.Name:SetText(UnitName("targettargettarget"));

                    local color = NORMAL_FONT_COLOR;
                    if UnitFramesPlusDB["targettarget"]["colorname"] == 1 and (UnitFramesPlusDB["targettarget"]["colornamenpcno"] ~= 1 or UnitIsPlayer("targettargettarget")) then
                        color = RAID_CLASS_COLORS[select(2, UnitClass("targettargettarget"))] or NORMAL_FONT_COLOR;
                    end
                    ToToTFrame.Name:SetTextColor(color.r, color.g, color.b);

                    local ToToTNameColor = PowerBarColor[UnitPowerType("targettargettarget")] or PowerBarColor["MANA"];
                    ToToTFrame.PowerBar:SetStatusBarColor(ToToTNameColor.r, ToToTNameColor.g, ToToTNameColor.b);

                    -- SetPortraitTexture(ToToTFrame.Portrait, "targettargettarget");
                    UnitFramesPlus_TargetTargetTargetClassPortraitDisplayUpdate();

                    if UnitHealthMax("targettargettarget") == 0 then
                        ToToTFrame.HealthBar:SetValue(0);
                    else
                        ToToTFrame.HealthBar:SetValue(UnitHealth("targettargettarget") / UnitHealthMax("targettargettarget") * 100);
                    end

                    if UnitPowerMax("targettargettarget") == 0 then
                        ToToTFrame.PowerBar:SetValue(0);
                    else
                        ToToTFrame.PowerBar:SetValue(UnitPower("targettargettarget") / UnitPowerMax("targettargettarget") * 100);
                    end

                    if UnitFramesPlusDB["targettarget"]["enemycheck"] == 1 then
                        if UnitIsEnemy("player", "targettargettarget") then
                            ToToTFrame.Highlight:SetAlpha(1);
                            ToToTFrame.Highlight:SetVertexColor(1, 0, 0);
                        elseif UnitIsFriend("player", "targettargettarget") then
                            ToToTFrame.Highlight:SetAlpha(1);
                            ToToTFrame.Highlight:SetVertexColor(0, 1, 0);
                        else
                            ToToTFrame.Highlight:SetAlpha(0);
                            ToToTFrame.Highlight:SetVertexColor(1, 0.82, 0);
                        end
                    end
                -- else
                --     ToToTFrame.HealthBar:SetValue(0);
                --     ToToTFrame.PowerBar:SetValue(0);
                end
                self.timer = 0;
            end
        end);
    else
        -- ToToTFrame.HealthBar:SetValue(0);
        -- ToToTFrame.PowerBar:SetValue(0);
        totot:SetScript("OnUpdate", nil);
    end
end

function UnitFramesPlus_TargetTargetTargetClassPortraitDisplayUpdate()
    if UnitFramesPlusDB["targettarget"]["portrait"] == 1 
    and not (UnitFramesPlusDB["targettarget"]["portraitnpcno"] == 1 and not UnitIsPlayer("targettargettarget")) then
        if ToToTFrame.Portrait:IsShown() then
            ToToTFrame.Portrait:Hide();
            ToToTFrame.ClassPortrait:Show();
        end
        local IconCoord = CLASS_ICON_TCOORDS[select(2,UnitClass("targettargettarget"))]
        if IconCoord then
            ToToTFrame.ClassPortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
            ToToTFrame.ClassPortrait:SetTexCoord(unpack(IconCoord));
        end
    else
        if ToToTFrame.ClassPortrait:IsShown() then
            ToToTFrame.Portrait:Show();
            ToToTFrame.ClassPortrait:Hide();
        end
        SetPortraitTexture(ToToTFrame.Portrait, "targettargettarget");
    end
end

function UnitFramesPlus_ToToTAttributeSet()
    if UnitFramesPlusDB["targettarget"]["showtot"] == 1 and UnitFramesPlusDB["targettarget"]["showtotot"] == 1 then
        ToToTFrame:SetAttribute("unit", "targettargettarget");
    else
        ToToTFrame:SetAttribute("unit", nil);
    end
end

function UnitFramesPlus_ToToTAttribute()
    if not InCombatLockdown() then
        UnitFramesPlus_ToToTAttributeSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_ToToTAttributeSet";
        func.callback = function()
            UnitFramesPlus_ToToTAttributeSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--ToT头像缩放
function UnitFramesPlus_TargetTargetScaleSet(newscale)
    -- local oldscale = oldscale or UnitFramesPlusDB["targettarget"]["scale"];
    local oldscale = ToTFrame:GetScale();
    local newscale = newscale or UnitFramesPlusDB["targettarget"]["scale"];
    if UnitFramesPlusDB["targettarget"]["showtot"] == 1 then
        local point, relativeTo, relativePoint, offsetX, offsetY = ToTFrame:GetPoint();
        ToTFrame:SetScale(newscale);
        ToTFrame:ClearAllPoints();
        ToTFrame:SetPoint(point, relativeTo, relativePoint, offsetX*oldscale/newscale, offsetY*oldscale/newscale);
        if UnitFramesPlusDB["targettarget"]["showtotot"] == 1 then
            ToToTFrame:SetScale(newscale);
        end
    end
end

function UnitFramesPlus_TargetTargetScale(newscale)
    if not InCombatLockdown() then
        UnitFramesPlus_TargetTargetScaleSet(newscale);
    else
        local func = {};
        func.name = "UnitFramesPlus_TargetTargetScaleSet";
        func.callback = function()
            UnitFramesPlus_TargetTargetScaleSet(newscale);
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--模块初始化
function UnitFramesPlus_TargetTargetInit()
    UnitFramesPlus_TargetTarget();
    UnitFramesPlus_TargetTargetTarget();
    UnitFramesPlus_TargetTargetShiftDrag();
    UnitFramesPlus_TargetTargetDebuff();
end

function UnitFramesPlus_TargetTargetLayout()
    UnitFramesPlus_TargetTargetPosition();
    UnitFramesPlus_TargetTargetScale();
end
