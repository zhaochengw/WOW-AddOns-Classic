--变量
local select = select;
local floor = math.floor;
local UnitExists = UnitExists;
local UnitClass = UnitClass;
local UnitName = UnitName;
local UnitHealth = UnitHealth;
local UnitHealthMax = UnitHealthMax;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local UnitPowerType = UnitPowerType;
local SetPortraitTexture = SetPortraitTexture;
local IsShiftKeyDown = IsShiftKeyDown;
local InCombatLockdown = InCombatLockdown;
local RegisterUnitWatch = RegisterUnitWatch;
local hooksecurefunc = hooksecurefunc;

--宠物目标
local ToPetFrameBase = CreateFrame("Button", "UFP_ToPetFrameBase", PetFrame);
ToPetFrameBase:SetFrameLevel(1);
ToPetFrameBase:SetWidth(96);
ToPetFrameBase:SetHeight(48);
ToPetFrameBase:ClearAllPoints();
ToPetFrameBase:SetPoint("LEFT", PetFrame, "RIGHT", 0, -10);
ToPetFrameBase:SetAlpha(0);

ToPetFrameBase.Texture = ToPetFrameBase:CreateTexture("UFP_ToPetFrameBaseTexture", "ARTWORK");
ToPetFrameBase.Texture:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame");
ToPetFrameBase.Texture:SetWidth(96);
ToPetFrameBase.Texture:SetHeight(48);
ToPetFrameBase.Texture:ClearAllPoints();
ToPetFrameBase.Texture:SetPoint("TOPLEFT", ToPetFrameBase, "TOPLEFT", 0, -2);

local ToPetFrame = CreateFrame("Button", "UFP_ToPetFrame", PetFrame, "SecureUnitButtonTemplate, SecureHandlerAttributeTemplate");
ToPetFrame:SetFrameLevel(8);
ToPetFrame:SetWidth(96);
ToPetFrame:SetHeight(48);
ToPetFrame:ClearAllPoints();
-- ToPetFrame:SetPoint("LEFT", PetFrame, "RIGHT", 0, -10);
ToPetFrame:SetPoint("LEFT", ToPetFrameBase, "LEFT", 0, 0);

ToPetFrame:SetAttribute("unit", "pettarget");
RegisterUnitWatch(ToPetFrame);
ToPetFrame:SetAttribute("*type1", "target");
ToPetFrame:RegisterForClicks("AnyUp");

ToPetFrame.Portrait = ToPetFrame:CreateTexture("UFP_ToPetFramePortrait", "BORDER");
ToPetFrame.Portrait:SetWidth(27);
ToPetFrame.Portrait:SetHeight(27);
ToPetFrame.Portrait:ClearAllPoints();
ToPetFrame.Portrait:SetPoint("TOPLEFT", ToPetFrame, "TOPLEFT", 6, -5);

ToPetFrame.Texture = ToPetFrame:CreateTexture("UFP_ToPetFrameTexture", "ARTWORK");
ToPetFrame.Texture:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame");
ToPetFrame.Texture:SetWidth(96);
ToPetFrame.Texture:SetHeight(48);
ToPetFrame.Texture:ClearAllPoints();
ToPetFrame.Texture:SetPoint("TOPLEFT", ToPetFrame, "TOPLEFT", 0, -2);

ToPetFrame.Name = ToPetFrame:CreateFontString("UFP_ToPetFrameName", "ARTWORK", "GameFontNormalSmall");
ToPetFrame.Name:ClearAllPoints();
ToPetFrame.Name:SetPoint("BOTTOMLEFT", ToPetFrame, "BOTTOMLEFT", 33, 39);

ToPetFrame.HealthBar = CreateFrame("StatusBar", "UFP_ToPetFrameHealthBar", ToPetFrame);
ToPetFrame.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToPetFrame.HealthBar:SetFrameLevel(2);
ToPetFrame.HealthBar:SetMinMaxValues(0, 100);
ToPetFrame.HealthBar:SetValue(0);
ToPetFrame.HealthBar:SetWidth(53);
ToPetFrame.HealthBar:SetHeight(6);
ToPetFrame.HealthBar:ClearAllPoints();
ToPetFrame.HealthBar:SetPoint("TOPLEFT", ToPetFrame, "TOPLEFT", 35, -9);
ToPetFrame.HealthBar:SetStatusBarColor(0, 1, 0);

ToPetFrame.HPPct = ToPetFrame:CreateFontString("UFP_ToPetFrameHPPct", "ARTWORK", "TextStatusBarText");
ToPetFrame.HPPct:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
ToPetFrame.HPPct:SetTextColor(1, 0.75, 0);
ToPetFrame.HPPct:SetJustifyH("LEFT");
ToPetFrame.HPPct:ClearAllPoints();
ToPetFrame.HPPct:SetPoint("LEFT", ToPetFrame.HealthBar, "RIGHT", 2, -4);

ToPetFrame.PowerBar = CreateFrame("StatusBar", "UFP_ToPetFramePowerBar", ToPetFrame);
ToPetFrame.PowerBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToPetFrame.PowerBar:SetFrameLevel(2);
ToPetFrame.PowerBar:SetMinMaxValues(0, 100);
ToPetFrame.PowerBar:SetValue(0);
ToPetFrame.PowerBar:SetWidth(53);
ToPetFrame.PowerBar:SetHeight(6);
ToPetFrame.PowerBar:ClearAllPoints();
ToPetFrame.PowerBar:SetPoint("TOPLEFT", ToPetFrame, "TOPLEFT", 35, -16);
ToPetFrame.PowerBar:SetStatusBarColor(0, 0, 1);

local pettarget = CreateFrame("Frame");
function UnitFramesPlus_PetTarget()
    UnitFramesPlus_PetTargetAttribute();
    if UnitFramesPlusDB["pet"]["target"] == 1 then
        pettarget:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.2 then
                if UnitExists("pettarget") then
                    ToPetFrame.Name:SetText(UnitName("pettarget"));

                    local ToPetNameColor = PowerBarColor[UnitPowerType("pettarget")] or PowerBarColor["MANA"];
                    ToPetFrame.PowerBar:SetStatusBarColor(ToPetNameColor.r, ToPetNameColor.g, ToPetNameColor.b);

                    SetPortraitTexture(ToPetFrame.Portrait, "pettarget");

                    if UnitHealthMax("pettarget") > 0 then
                        ToPetFrame.HealthBar:SetValue(UnitHealth("pettarget") / UnitHealthMax("pettarget") * 100);
                        local ToPetPctText = "";
                        if UnitFramesPlusDB["pet"]["hppct"] == 1 then
                            ToPetPctText = floor(UnitHealth("pettarget") / UnitHealthMax("pettarget") * 100).."%";
                        end
                        ToPetFrame.HPPct:SetText(ToPetPctText);
                    else
                        ToPetFrame.HealthBar:SetValue(0);
                        ToPetFrame.HPPct:SetText("");
                    end

                    if UnitPowerMax("pettarget") > 0 then
                        ToPetFrame.PowerBar:SetValue(UnitPower("pettarget") / UnitPowerMax("pettarget") * 100);
                    else
                        ToPetFrame.PowerBar:SetValue(0);
                    end
                else
                    -- ToPetFrame.HealthBar:SetValue(0);
                    -- ToPetFrame.PowerBar:SetValue(0);
                    ToPetFrame.HPPct:SetText("");
                end
                self.timer = 0;
            end
        end);
    else
        -- ToPetFrame.HealthBar:SetValue(0);
        -- ToPetFrame.PowerBar:SetValue(0);
        ToPetFrame.HPPct:SetText("");
        pettarget:SetScript("OnUpdate", nil);
    end
end

function UnitFramesPlus_PetTargetAttributeSet()
    if UnitFramesPlusDB["pet"]["target"] == 1 then
        ToPetFrame:SetAttribute("unit", "pettarget");
    else
        ToPetFrame:SetAttribute("unit", nil);
    end
end

function UnitFramesPlus_PetTargetAttribute()
    if not InCombatLockdown() then
        UnitFramesPlus_PetTargetAttributeSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PetTargetAttributeSet";
        func.callback = function()
            UnitFramesPlus_PetTargetAttributeSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--宠物目标缩放
function UnitFramesPlus_PetTargetScaleSet(newscale)
    -- local oldscale = oldscale or UnitFramesPlusDB["pet"]["scale"];
    local oldscale = ToPetFrameBase:GetScale();
    local newscale = newscale or UnitFramesPlusDB["pet"]["scale"];
    -- if UnitFramesPlusDB["pet"]["target"] == 1 then
    local point, relativeTo, relativePoint, offsetX, offsetY = ToPetFrameBase:GetPoint();
    ToPetFrameBase:SetScale(newscale);
    ToPetFrame:SetScale(newscale);
    ToPetFrameBase:ClearAllPoints();
    ToPetFrameBase:SetPoint(point, relativeTo, relativePoint, offsetX*oldscale/newscale, offsetY*oldscale/newscale);
    -- end
end

function UnitFramesPlus_PetTargetScale(newscale)
    if not InCombatLockdown() then
        UnitFramesPlus_PetTargetScaleSet(newscale);
    else
        local func = {};
        func.name = "UnitFramesPlus_PetTargetScaleSet";
        func.callback = function()
            UnitFramesPlus_PetTargetScaleSet(newscale);
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--非战斗状态中允许shift+左键拖动宠物目标头像
function UnitFramesPlus_PetTargetPositionSet()
    if UnitFramesPlusVar["pet"]["targetmoved"] == 1 then
        ToPetFrameBase:ClearAllPoints();
        ToPetFrameBase:SetPoint("BOTTOMLEFT", PetFrame, "BOTTOMLEFT", UnitFramesPlusVar["pet"]["targetx"], UnitFramesPlusVar["pet"]["targety"]);
    else
        ToPetFrameBase:ClearAllPoints();
        if select(2, UnitClass("player")) == "HUNTER" then
            --Hunter needs PetFrameHappiness
            ToPetFrameBase:SetPoint("LEFT", PetFrame, "RIGHT", 28, -10);
        else
            ToPetFrameBase:SetPoint("LEFT", PetFrame, "RIGHT", 0, -10);
        end
    end
end

function UnitFramesPlus_PetTargetPosition()
    if not InCombatLockdown() then
        UnitFramesPlus_PetTargetPositionSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PetTargetPositionSet";
        func.callback = function()
            UnitFramesPlus_PetTargetPositionSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

local function UnitFramesPlus_PetTargetShiftDrag()
    ToPetFrameBase:SetMovable(1);

    ToPetFrameBase:SetScript("OnMouseDown", function(self, elapsed)
        if UnitFramesPlusDB["pet"]["targetmovable"] == 1 then
            if IsShiftKeyDown() and (not InCombatLockdown()) then
                ToPetFrameBase:StartMoving();
                UnitFramesPlusVar["pet"]["targetmoving"] = 1;
            end
        end
    end)

    ToPetFrameBase:SetScript("OnMouseUp", function(self, elapsed)
        if UnitFramesPlusVar["pet"]["targetmoving"] == 1 then
            ToPetFrameBase:StopMovingOrSizing();
            UnitFramesPlusVar["pet"]["targetmoving"] = 0;
            UnitFramesPlusVar["pet"]["targetmoved"] = 1;
            local bottom = ToPetFrameBase:GetBottom();
            local left = ToPetFrameBase:GetLeft();
            local scale = ToPetFrameBase:GetScale()*PetFrame:GetScale();
            local bottomX = PetFrame:GetBottom();
            local leftX = PetFrame:GetLeft();
            local scaleX = PetFrame:GetScale();
            UnitFramesPlusVar["pet"]["targetx"] = (left*scale-leftX*scaleX)/scale;
            UnitFramesPlusVar["pet"]["targety"] = (bottom*scale-bottomX*scaleX)/scale;
            ToPetFrameBase:ClearAllPoints();
            ToPetFrameBase:SetPoint("BOTTOMLEFT", PetFrame, "BOTTOMLEFT", UnitFramesPlusVar["pet"]["targetx"], UnitFramesPlusVar["pet"]["targety"]);
        end
    end)

    ToPetFrameBase:SetClampedToScreen(1);

    --重置目标位置时同时重置宠物位置
    hooksecurefunc("PlayerFrame_ResetUserPlacedPosition", function()
        UnitFramesPlusVar["pet"]["targetmoved"] = 0;
        UnitFramesPlus_PetTargetPosition();
    end)
end

--模块初始化
function UnitFramesPlus_PetTargetInit()
    UnitFramesPlus_PetTarget();
    UnitFramesPlus_PetTargetShiftDrag();
end

function UnitFramesPlus_PetTargetLayout()
    UnitFramesPlus_PetTargetScale();
    UnitFramesPlus_PetTargetPosition();
    if UnitFramesPlusDB["pet"]["targettmp"] == 1 then
        UFP_ToPetFrameBase:SetAlpha(1);
    else
        UFP_ToPetFrameBase:SetAlpha(0);
    end
end
