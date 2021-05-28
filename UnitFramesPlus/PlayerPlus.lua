--变量
local select = select;
local floor = math.floor;
local UnitExists = UnitExists;
local UnitClass = UnitClass;
local UnitIsGhost = UnitIsGhost;
local UnitIsDead = UnitIsDead;
local UnitHealth = UnitHealth;
local UnitHealthMax = UnitHealthMax;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local UnitPowerType = UnitPowerType;
local IsInInstance = IsInInstance;
local IsShiftKeyDown = IsShiftKeyDown;
local InCombatLockdown = InCombatLockdown;
local PlayerFrame_SetLocked = PlayerFrame_SetLocked;
local GetBestMapForUnit = C_Map.GetBestMapForUnit;
local GetPlayerMapPosition = C_Map.GetPlayerMapPosition;
local GameTooltip_AddNewbieTip = GameTooltip_AddNewbieTip;
local hooksecurefunc = hooksecurefunc;

--非战斗状态中允许shift+左键拖动玩家头像
local function UnitFramesPlus_PlayerShiftDrag()
    PlayerFrame:SetScript("OnMouseDown", function(self, elapsed)
        if UnitFramesPlusDB["player"]["movable"] == 1 then
            if IsShiftKeyDown() and (not InCombatLockdown()) then
                PlayerFrame:StartMoving();
                UnitFramesPlusVar["player"]["moving"] = 1;
            end
        end
    end)

    PlayerFrame:SetScript("OnMouseUp", function(self, elapsed)
        if UnitFramesPlusVar["player"]["moving"] == 1 then
            PlayerFrame:StopMovingOrSizing();
            UnitFramesPlusVar["player"]["moving"] = 0;
            UnitFramesPlusVar["player"]["moved"] = 1;
            local left = PlayerFrame:GetLeft();
            local bottom = PlayerFrame:GetBottom();
            UnitFramesPlusVar["player"]["x"] = left;
            UnitFramesPlusVar["player"]["y"] = bottom;
        end
    end)

    PlayerFrame_SetLocked(true);
    PlayerFrame:SetMovable(true);
    PlayerFrame:SetUserPlaced(false);
    PlayerFrame:SetClampedToScreen(true);

    hooksecurefunc("PlayerFrame_ResetUserPlacedPosition", function()
        UnitFramesPlusVar["player"]["moved"] = 0;
        -- UnitFramesPlusVar["target"]["moved"] = 0;
        -- UnitFramesPlus_TargetPosition();
        if TitanPanel_AdjustFrames then
            TitanPanel_AdjustFrames();
        end
    end)
end

function UnitFramesPlus_PlayerPositionSet()
    if UnitFramesPlusVar["player"]["moved"] == 0 then
        PlayerFrame:ClearAllPoints();
        if TitanPanel_AdjustFrames then
            PlayerFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -19, -TITAN_PANEL_BAR_HEIGHT);
        else
            PlayerFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -19, -4);
        end
    else
        PlayerFrame:ClearAllPoints();
        PlayerFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", UnitFramesPlusVar["player"]["x"], UnitFramesPlusVar["player"]["y"]);
    end
end

function UnitFramesPlus_PlayerPosition()
    if not InCombatLockdown() then
        UnitFramesPlus_PlayerPositionSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PlayerPositionSet";
        func.callback = function()
            UnitFramesPlus_PlayerPositionSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--额外的生命值/法力值/生命值百分比
local PlayerHPMPPct = CreateFrame("Frame", "UFP_PlayerHPMPPct", PlayerFrame);
PlayerHPMPPct:SetFrameLevel(7);
PlayerHPMPPct.HP = PlayerHPMPPct:CreateFontString("UFP_PlayerHPMPPctHP", "OVERLAY", "TextStatusBarText");
PlayerHPMPPct.HP:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
PlayerHPMPPct.HP:SetTextColor(1, 0.75, 0);
PlayerHPMPPct.HP:Hide();

PlayerHPMPPct.MP = PlayerHPMPPct:CreateFontString("UFP_PlayerHPMPPctMP", "OVERLAY", "TextStatusBarText");
PlayerHPMPPct.MP:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
PlayerHPMPPct.MP:SetTextColor(1, 1, 1);
PlayerHPMPPct.MP:Hide();

PlayerHPMPPct.Pct = PlayerHPMPPct:CreateFontString("UFP_PlayerHPMPPctPct", "OVERLAY", "TextStatusBarText");
PlayerHPMPPct.Pct:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
PlayerHPMPPct.Pct:SetTextColor(0, 1, 0);
PlayerHPMPPct.Pct:Hide();

--扩展框
local PlayerExtraBar = PlayerFrame:CreateTexture("UFP_PlayerExtraBar", "ARTWORK");
PlayerExtraBar:Hide();

local PlayerExtraBarBG = PlayerFrame:CreateTexture("UFP_PlayerExtraBarBG", "BACKGROUND");
PlayerExtraBarBG:Hide();

--精英头像
local UFP_PlayerTexture = "Interface\\TargetingFrame\\UI-TargetingFrame";
function UnitFramesPlus_PlayerDragon()
    if UnitFramesPlusDB["player"]["dragonborder"] == 1 then
        if UnitFramesPlusDB["player"]["bordertype"] == 1 then
            UFP_PlayerTexture = "Interface\\TargetingFrame\\UI-TargetingFrame-Elite";
        elseif UnitFramesPlusDB["player"]["bordertype"] == 2 then
            UFP_PlayerTexture = "Interface\\TargetingFrame\\UI-TargetingFrame-Rare-Elite";
        elseif UnitFramesPlusDB["player"]["bordertype"] == 3 then
            UFP_PlayerTexture = "Interface\\TargetingFrame\\UI-TargetingFrame-Rare";
        end
    else
        UFP_PlayerTexture = "Interface\\TargetingFrame\\UI-TargetingFrame";
    end
    PlayerFrameTexture:SetTexture(UFP_PlayerTexture);
    PlayerFrameTexture:SetAllPoints();

    --设置扩展框素材与头像素材一致
    if UnitFramesPlusDB["player"]["extrabar"] == 1 then
        PlayerExtraBar:SetTexture(UFP_PlayerTexture);
    end
end

-- local fixforvehicle = CreateFrame("Frame");
function UnitFramesPlus_PlayerExtrabar()
    PlayerExtraBar:SetTexture(UFP_PlayerTexture);
    PlayerExtraBar:SetWidth(138);
    PlayerExtraBar:SetHeight(128);
    PlayerExtraBar:SetTexCoord(0.3984375, 0, 0, 1);
    PlayerExtraBar:ClearAllPoints();
    PlayerExtraBar:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 226, 0);

    PlayerExtraBarBG:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background");
    PlayerExtraBarBG:SetWidth(96);
    PlayerExtraBarBG:SetHeight(42);
    PlayerExtraBarBG:SetVertexColor(0, 0, 0, 0.5);
    PlayerExtraBarBG:ClearAllPoints();
    PlayerExtraBarBG:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 226, -23);
    if UnitFramesPlusDB["player"]["extrabar"] == 1 then
        PlayerExtraBar:Show();
        PlayerExtraBarBG:Show();
        PlayerHPMPPct.HP:ClearAllPoints();
        PlayerHPMPPct.HP:SetPoint("CENTER", PlayerFrameHealthBar, "RIGHT", 53, -1);
        PlayerHPMPPct.HP:SetJustifyH("CENTER");
        PlayerHPMPPct.HP:Show();
        PlayerHPMPPct.MP:ClearAllPoints();
        PlayerHPMPPct.MP:SetPoint("CENTER", PlayerFrameManaBar, "RIGHT", 53, -1);
        PlayerHPMPPct.MP:SetJustifyH("CENTER");
        PlayerHPMPPct.MP:Show();
        PlayerHPMPPct.Pct:ClearAllPoints();
        PlayerHPMPPct.Pct:SetPoint("CENTER", PlayerFrameHealthBar, "RIGHT", 55, 14);
        PlayerHPMPPct.Pct:SetJustifyH("CENTER");
        PlayerHPMPPct.Pct:Show();

        PetFrame:SetFrameLevel(5);

        -- --上载具后隐藏扩展框及扩展信息
        -- fixforvehicle:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player");
        -- fixforvehicle:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player");
        -- fixforvehicle:SetScript("OnEvent", function(self, event, ...)
        --     if event == "UNIT_ENTERED_VEHICLE" then
        --         if UnitHasVehicleUI("player") then
        --             PlayerExtraBar:SetAlpha(0);
        --             PlayerExtraBarBG:SetAlpha(0);
        --             PlayerHPMPPct.HP:SetAlpha(0);
        --             PlayerHPMPPct.MP:SetAlpha(0);
        --             PlayerHPMPPct.Pct:SetAlpha(0);
        --         end
        --     elseif event == "UNIT_EXITED_VEHICLE" then
        --         PlayerExtraBar:SetAlpha(1);
        --         PlayerExtraBarBG:SetAlpha(0.5);
        --         PlayerHPMPPct.HP:SetAlpha(1);
        --         PlayerHPMPPct.MP:SetAlpha(1);
        --         PlayerHPMPPct.Pct:SetAlpha(1);
        --     end;
        -- end)

        UnitFramesPlus_PlayerHealth();
        UnitFramesPlus_PlayerHPValueDisplayUpdate();
        UnitFramesPlus_PlayerPower();
        UnitFramesPlus_PlayerMPValueDisplayUpdate();
    else
        PlayerExtraBar:Hide();
        PlayerExtraBarBG:Hide();
        -- if fixforvehicle:IsEventRegistered("UNIT_ENTERED_VEHICLE") then
        --     fixforvehicle:UnregisterAllEvents();
        --     fixforvehicle:SetScript("OnEvent", nil);
        -- end
        UnitFramesPlus_PlayerHPMPPct();
    end
end

--隐藏扩展框后调整额外的生命值/法力值/生命值百分比的位置
function UnitFramesPlus_PlayerHPMPPct()
    if UnitFramesPlusDB["player"]["hpmp"] == 1 then
        PlayerHPMPPct.HP:ClearAllPoints();
        PlayerHPMPPct.HP:SetPoint("LEFT", PlayerFrameHealthBar, "RIGHT", 5, -1);
        PlayerHPMPPct.HP:SetJustifyH("LEFT");
        PlayerHPMPPct.HP:Show();
        PlayerHPMPPct.MP:ClearAllPoints();
        PlayerHPMPPct.MP:SetPoint("LEFT", PlayerFrameManaBar, "RIGHT", 5, -1);
        PlayerHPMPPct.MP:SetJustifyH("LEFT");
        PlayerHPMPPct.MP:Show();
        PlayerHPMPPct.Pct:ClearAllPoints();
        PlayerHPMPPct.Pct:SetPoint("LEFT", PlayerFrameHealthBar, "RIGHT", 5, 14);
        PlayerHPMPPct.Pct:SetJustifyH("LEFT");
        PlayerHPMPPct.Pct:Show();
    else
        PlayerHPMPPct.HP:Hide();
        PlayerHPMPPct.MP:Hide();
        PlayerHPMPPct.Pct:Hide();
    end
    UnitFramesPlus_PlayerHealth();
    UnitFramesPlus_PlayerHPValueDisplayUpdate();
    UnitFramesPlus_PlayerPower();
    UnitFramesPlus_PlayerMPValueDisplayUpdate();
end

--额外的生命值
local PlayerHealth = CreateFrame("Frame");
function UnitFramesPlus_PlayerHealth()
    --if UnitFramesPlusDB["player"]["extrabar"] == 0 and UnitFramesPlusDB["player"]["hpmp"] == 0 and UnitFramesPlusDB["player"]["pctonbar"] == 0 then
    if UnitFramesPlusDB["player"]["extrabar"] == 0 and UnitFramesPlusDB["player"]["hpmp"] == 0 then
        if PlayerHealth:IsEventRegistered("PLAYER_ENTERING_WORLD") then
            PlayerHealth:UnregisterAllEvents();
            PlayerHealth:SetScript("OnEvent", nil);
        end
    else
        PlayerHealth:RegisterEvent("PLAYER_ENTERING_WORLD");
        PlayerHealth:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "player");
        PlayerHealth:SetScript("OnEvent", function(self, event, ...)
            UnitFramesPlus_PlayerHPValueDisplayUpdate();
        end)
    end
end

--刷新额外的生命值显示
function UnitFramesPlus_PlayerHPValueDisplayUpdate()
    local CurHP = UnitHealth("player");
    local MaxHP = UnitHealthMax("player");
    local CurHPfix, MaxHPfix, LossHPfix = UnitFramesPlus_GetValueFix(CurHP, MaxHP, UnitFramesPlusDB["player"]["hpmpunit"], UnitFramesPlusDB["player"]["unittype"]);
    local PctText = "";
    local PlayerExtHPText = "";

    if MaxHP > 0 then
        PctText = floor(100*CurHP/MaxHP).."%";
    end

    if UnitFramesPlusDB["player"]["extrabar"] == 1 or UnitFramesPlusDB["player"]["hpmp"] == 1 then
        if UnitFramesPlusDB["player"]["hpmppartone"] == 1 then
            PlayerExtHPText = CurHPfix;
        elseif UnitFramesPlusDB["player"]["hpmppartone"] == 2 then
            PlayerExtHPText = MaxHPfix;
        elseif UnitFramesPlusDB["player"]["hpmppartone"] == 3 then
            PlayerExtHPText = LossHPfix;
        elseif UnitFramesPlusDB["player"]["hpmppartone"] == 4 then
            PlayerExtHPText = PctText;
        end

        if UnitFramesPlusDB["player"]["hpmpparttwo"] == 1 then
            PlayerExtHPText = PlayerExtHPText.."/"..CurHPfix;
        elseif UnitFramesPlusDB["player"]["hpmpparttwo"] == 2 then
            PlayerExtHPText = PlayerExtHPText.."/"..MaxHPfix;
        elseif UnitFramesPlusDB["player"]["hpmpparttwo"] == 3 then
            PlayerExtHPText = PlayerExtHPText.."/"..LossHPfix;
        elseif UnitFramesPlusDB["player"]["hpmpparttwo"] == 4 then
            PlayerExtHPText = PlayerExtHPText.."/"..PctText;
        end

        PlayerHPMPPct.HP:SetText(PlayerExtHPText);

        if UnitFramesPlusDB["player"]["hpmppartone"] == 4 or UnitFramesPlusDB["player"]["hpmpparttwo"] == 4 then
            if UnitFramesPlusDB["player"]["coord"] == 0 then
                PlayerHPMPPct.Pct:SetText("");
            end
        else
            local _, instanceType = IsInInstance();
            if (UnitFramesPlusDB["player"]["coord"] == 0) 
                or (instanceType ~= "none" and UnitFramesPlusDB["player"]["coord"] == 1) then
                PlayerHPMPPct.Pct:SetText(PctText);
            end
        end
    end
end

--玩家坐标
local coord = CreateFrame("Frame");
local x, y;
function UnitFramesPlus_PlayerCoordinate()
    if UnitFramesPlusDB["player"]["coord"] == 1 then
        coord:RegisterEvent("ZONE_CHANGED");
        coord:RegisterEvent("ZONE_CHANGED_INDOORS");
        coord:RegisterEvent("ZONE_CHANGED_NEW_AREA");
        coord:SetScript("OnEvent", function(self, event)
            UnitFramesPlus_PlayerCoordinateDisplayUpdate();
        end)

        coord:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.3 then
                UnitFramesPlus_PlayerCoordinateDisplayUpdate();
                self.timer = 0;
            end
        end)
    else
        if coord:IsEventRegistered("ZONE_CHANGED") then
            coord:UnregisterAllEvents();
            coord:SetScript("OnEvent", nil);
            coord:SetScript("OnUpdate", nil);
        end
    end
end

function UnitFramesPlus_PlayerCoordinateDisplayUpdate()
    local _, instanceType = IsInInstance();
    if instanceType ~= "none" and UnitFramesPlusDB["player"]["coord"] == 1 then
        return;
    end
    local x, y = 0, 0
    local MapID = GetBestMapForUnit("player");
    if MapID then
        local MapPosObject = GetPlayerMapPosition(MapID, "player");
        if MapPosObject then
            x, y = MapPosObject:GetXY()
        end
    end
    if x ~= 0 or y ~= 0 then
        PlayerHPMPPct.Pct:SetText(format("(%.0f, %.0f)", x*100, y*100));
    else
        if WorldMapFrame:IsShown() == false then
            MapID = GetBestMapForUnit("player");
            if MapID then
                WorldMapFrame:SetMapID(MapID)
                MapPosObject = GetPlayerMapPosition(MapID, "player");
                if MapPosObject then 
                    x, y = MapPosObject:GetXY()
                end
            end
            -- x, y = GetPlayerMapPosition("player");
            PlayerHPMPPct.Pct:SetText(format("(%.0f, %.0f)", x*100, y*100));
        else
            PlayerHPMPPct.Pct:SetText("");
        end
    end
end

--额外的法力值/能量等
local PlayerPower = CreateFrame("Frame");
function UnitFramesPlus_PlayerPower()
    if UnitFramesPlusDB["player"]["extrabar"] == 0 and UnitFramesPlusDB["player"]["hpmp"] == 0 then
        if PlayerPower:IsEventRegistered("UNIT_POWER_UPDATE") then
            PlayerPower:UnregisterAllEvents();
            PlayerPower:SetScript("OnEvent", nil);
        end
    else
        PlayerPower:RegisterEvent("PLAYER_ENTERING_WORLD");
        PlayerPower:RegisterUnitEvent("UNIT_POWER_UPDATE", "player");
        PlayerPower:SetScript("OnEvent", function(self, event, ...)
            UnitFramesPlus_PlayerMPValueDisplayUpdate();
        end)
    end
end

--刷新额外的法力值/能量等显示
function UnitFramesPlus_PlayerMPValueDisplayUpdate()
    local CurMP = UnitPower("player");
    local MaxMP = UnitPowerMax("player");
    local CurMPfix, MaxMPfix, LossMPfix = UnitFramesPlus_GetValueFix(CurMP, MaxMP, UnitFramesPlusDB["player"]["hpmpunit"], UnitFramesPlusDB["player"]["unittype"]);
    local PctText = "";
    local powerType = UnitPowerType("player");

    if powerType == 0 then
        if MaxMP > 0 then
            PctText = floor(100*CurMP/MaxMP).."%";
        end
    else
        PctText = CurMP;
        -- PctText == 0 then PctText = "" end
    end

    if UnitFramesPlusDB["player"]["extrabar"] == 1 or UnitFramesPlusDB["player"]["hpmp"] == 1 then
        if UnitFramesPlusDB["player"]["hpmppartone"] == 1 then
            PlayerExtMPText = CurMPfix;
        elseif UnitFramesPlusDB["player"]["hpmppartone"] == 2 then
            PlayerExtMPText = MaxMPfix;
        elseif UnitFramesPlusDB["player"]["hpmppartone"] == 3 then
            PlayerExtMPText = LossMPfix;
        elseif UnitFramesPlusDB["player"]["hpmppartone"] == 4 then
            PlayerExtMPText = PctText;
        end

        if UnitFramesPlusDB["player"]["hpmpparttwo"] == 1 then
            PlayerExtMPText = PlayerExtMPText.."/"..CurMPfix;
        elseif UnitFramesPlusDB["player"]["hpmpparttwo"] == 2 then
            PlayerExtMPText = PlayerExtMPText.."/"..MaxMPfix;
        elseif UnitFramesPlusDB["player"]["hpmpparttwo"] == 3 then
            PlayerExtMPText = PlayerExtMPText.."/"..LossMPfix;
        elseif UnitFramesPlusDB["player"]["hpmpparttwo"] == 4 then
            PlayerExtMPText = PlayerExtMPText.."/"..PctText;
        end

        PlayerHPMPPct.MP:SetText(PlayerExtMPText);
    end
end

-- --玩家生命条染色
-- local chb = CreateFrame("Frame");
-- function UnitFramesPlus_PlayerColorHPBar()
--     if UnitFramesPlusDB["player"]["colorhp"] == 1 then
--         if UnitFramesPlusDB["player"]["colortype"] == 1 then
--             PlayerFrameHealthBar:SetScript("OnValueChanged", nil);
--             chb:RegisterEvent("PLAYER_ENTERING_WORLD");
--             chb:RegisterEvent("PLAYER_REGEN_ENABLED");
--             -- chb:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player");
--             -- chb:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player");
--             chb:SetScript("OnEvent", function(self, event, ...)
--                 UnitFramesPlus_PlayerColorHPBarDisplayUpdate();
--             end)
--         elseif UnitFramesPlusDB["player"]["colortype"] == 2 then
--             if chb:IsEventRegistered("PLAYER_ENTERING_WORLD") then
--                 chb:UnregisterAllEvents();
--                 chb:SetScript("OnEvent", nil);
--             end
--             PlayerFrameHealthBar:SetScript("OnValueChanged", function(self, value)
--                 UnitFramesPlus_PlayerColorHPBarDisplayUpdate();
--             end)
--         end
--         --PlayerFrameHealthBar.lockColor = true;
--     else
--         PlayerFrameHealthBar:SetScript("OnValueChanged", nil);
--         if chb:IsEventRegistered("PLAYER_ENTERING_WORLD") then
--             chb:UnregisterAllEvents();
--             chb:SetScript("OnEvent", nil);
--         end
--         PlayerFrameHealthBar:SetStatusBarColor(0, 1, 0);
--         --PlayerFrameHealthBar.lockColor = nil;
--     end
-- end

--刷新玩家生命条染色显示
function UnitFramesPlus_PlayerColorHPBarDisplayUpdate()
    if UnitFramesPlusDB["player"]["colorhp"] == 1 then
        if UnitFramesPlusDB["player"]["colortype"] == 1 then
            local color = RAID_CLASS_COLORS[select(2, UnitClass("player"))] or {r=0, g=1, b=0};
            -- if UnitHasVehicleUI("player") then color = {r=0, g=1, b=0} end
            PlayerFrameHealthBar:SetStatusBarColor(color.r, color.g, color.b);
        elseif UnitFramesPlusDB["player"]["colortype"] == 2 then
            local CurHP = UnitHealth("player");
            local MaxHP = UnitHealthMax("player");
            local r, g, b = UnitFramesPlus_GetRGB(CurHP, MaxHP);
            PlayerFrameHealthBar:SetStatusBarColor(r, g, b);
        end
    end
end

--目标生命条染色
hooksecurefunc("UnitFrameHealthBar_Update", function(statusbar, unit)
    if unit == "player" and statusbar.unit == "player" then 
        UnitFramesPlus_PlayerColorHPBarDisplayUpdate();
    end
end);
hooksecurefunc("HealthBar_OnValueChanged", function(self, value, smooth)
    if self.unit == "player" then 
        UnitFramesPlus_PlayerColorHPBarDisplayUpdate();
    end
end);

--玩家头像内战斗信息
function UnitFramesPlus_PlayerPortraitIndicator()
    local registered = PlayerFrame:IsEventRegistered("UNIT_COMBAT");
    if UnitFramesPlusDB["player"]["indicator"] == 1 then
        if not registered then
            -- PlayerFrame:RegisterUnitEvent("UNIT_COMBAT", "player", "vehicle");
            PlayerFrame:RegisterUnitEvent("UNIT_COMBAT", "player");
        end
        return;
    else
        if registered then
            PlayerFrame:UnregisterEvent("UNIT_COMBAT");
        end
    end
end

--玩家头像类型
local Player3DPortrait = CreateFrame("PlayerModel", "UFP_Player3DPortrait", PlayerFrame);
Player3DPortrait:SetWidth(51);
Player3DPortrait:SetHeight(51);
Player3DPortrait:SetFrameLevel(1);
Player3DPortrait:ClearAllPoints();
Player3DPortrait:SetPoint("CENTER", PlayerPortrait, "CENTER", 0, -1);
Player3DPortrait:Hide();
Player3DPortrait.Background = Player3DPortrait:CreateTexture("UFP_Player3DPortraitBG", "BACKGROUND");
Player3DPortrait.Background:SetTexture("Interface\\AddOns\\UnitFramesPlus\\Portrait3D");
Player3DPortrait.Background:SetWidth(64);
Player3DPortrait.Background:SetHeight(64);
Player3DPortrait.Background:ClearAllPoints();
Player3DPortrait.Background:SetPoint("CENTER", Player3DPortrait, "CENTER", 0, 0);
Player3DPortrait.Background:Hide();

local PlayerClassPortrait = PlayerFrame:CreateTexture("UFP_PlayerClassPortrait", "ARTWORK");
PlayerClassPortrait:SetWidth(64);
PlayerClassPortrait:SetHeight(64);
PlayerClassPortrait:ClearAllPoints();
PlayerClassPortrait:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 42, -12);
PlayerClassPortrait:Hide();

local ppt = CreateFrame("Frame");
function UnitFramesPlus_PlayerPortrait()
    if UnitFramesPlusDB["player"]["portrait"] == 1 then
        PlayerPortrait:Hide();
        if UnitFramesPlusDB["player"]["portraittype"] == 1 then
            Player3DPortrait:Show();
            PlayerClassPortrait:Hide();
            ppt:RegisterEvent("PLAYER_ENTERING_WORLD");
            ppt:RegisterEvent("PLAYER_DEAD");
            ppt:RegisterEvent("PLAYER_ALIVE");
            ppt:RegisterEvent("PLAYER_UNGHOST");
            ppt:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player");
            -- ppt:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player");
            -- ppt:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player");
            ppt:SetScript("OnEvent", function(self, event, ...)
                if event == "PLAYER_ENTERING_WORLD" then
                    if UnitFramesPlusDB["player"]["portrait3dbg"] == 1 then
                        local color = RAID_CLASS_COLORS[select(2, UnitClass("player"))] or NORMAL_FONT_COLOR;
                        Player3DPortrait.Background:SetVertexColor(color.r/1.5, color.g/1.5, color.b/1.5, 1);
                    end
                    UnitFramesPlus_PlayerPortraitDisplayUpdate();
                -- elseif event == "UNIT_MODEL_CHANGED" or event == "UNIT_EXITED_VEHICLE" then
                elseif event == "UNIT_MODEL_CHANGED" then
                    UnitFramesPlus_PlayerPortraitDisplayUpdate();
                elseif event == "PLAYER_DEAD" then
                    Player3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 0.3, 0.3);
                elseif event == "PLAYER_ALIVE" then
                    if UnitIsGhost("player") then
                        Player3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);
                    else
                        Player3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
                    end
                elseif event == "PLAYER_UNGHOST" then
                    Player3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
                -- elseif event == "UNIT_ENTERED_VEHICLE" and UnitHasVehicleUI("player") then
                --     Player3DPortrait:SetPortraitZoom(1);
                --     Player3DPortrait:ClearModel();
                --     Player3DPortrait:SetUnit("vehicle");
                end
            end)
        elseif UnitFramesPlusDB["player"]["portraittype"] == 2 then
            Player3DPortrait:Hide();
            PlayerClassPortrait:Show();
            if ppt:IsEventRegistered("PLAYER_ENTERING_WORLD") then
                ppt:UnregisterAllEvents();
                ppt:SetScript("OnEvent", nil);
            end
        end
        UnitFramesPlus_PlayerPortraitDisplayUpdate();
        UnitFramesPlus_PlayerPortrait3DBGDisplayUpdate();
    else
        PlayerPortrait:Show();
        Player3DPortrait:Hide();
        PlayerClassPortrait:Hide();
        if ppt:IsEventRegistered("PLAYER_ENTERING_WORLD") then
            ppt:UnregisterAllEvents();
            ppt:SetScript("OnEvent", nil);
        end
    end
end

--刷新玩家头像显示
function UnitFramesPlus_PlayerPortraitDisplayUpdate()
    if UnitFramesPlusDB["player"]["portraittype"] == 1 then
        -- Player3DPortrait:Show();
        Player3DPortrait:SetPortraitZoom(1);
        -- Player3DPortrait:SetCamDistanceScale(1);
        -- Player3DPortrait:SetPosition(0,0,0);
        Player3DPortrait:ClearModel();
        Player3DPortrait:SetUnit("player");
        if UnitIsGhost("player") then
            Player3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);
        elseif UnitIsDead("player") then
            Player3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 0.3, 0.3);
        else
            Player3DPortrait:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
        end
    elseif UnitFramesPlusDB["player"]["portraittype"] == 2 then
        local IconCoord = CLASS_ICON_TCOORDS[select(2, UnitClass("player"))];
        if IconCoord then
            PlayerClassPortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
            PlayerClassPortrait:SetTexCoord(unpack(IconCoord));
        end
    end
end

--刷新玩家3D头像背景显示
function UnitFramesPlus_PlayerPortrait3DBGDisplayUpdate()
    if UnitFramesPlusDB["player"]["portrait"] == 1 
    and UnitFramesPlusDB["player"]["portraittype"] == 1
    and UnitFramesPlusDB["player"]["portrait3dbg"] == 1 then
        Player3DPortrait.Background:Show();
    else
        Player3DPortrait.Background:Hide();
    end
end

--玩家头像自动隐藏
local fah = CreateFrame("Frame");
function UnitFramesPlus_PlayerFrameAutohide()
    if UnitFramesPlusDB["player"]["autohide"] == 1 then
        fah:RegisterEvent("PLAYER_ENTERING_WORLD");
        fah:RegisterEvent("PLAYER_TARGET_CHANGED");
        fah:RegisterEvent("PLAYER_REGEN_ENABLED");
        fah:RegisterEvent("PLAYER_REGEN_DISABLED");
        fah:RegisterUnitEvent("UNIT_POWER_UPDATE", "player");
        fah:RegisterUnitEvent("UNIT_MAXPOWER", "player");
        fah:RegisterUnitEvent("UNIT_HEALTH", "player");
        fah:RegisterUnitEvent("UNIT_MAXHEALTH", "player");
        -- fah:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player");
        -- fah:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player");
        fah:SetScript("OnEvent", function(self, event, ...)
            if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED"
                -- or event == "PLAYER_REGEN_ENABLED" or event == "UNIT_EXITED_VEHICLE"
                or event == "PLAYER_REGEN_ENABLED"
                or event == "UNIT_POWER_UPDATE" or event == "UNIT_MAXPOWER"
                or event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" then
                UnitFramesPlus_PlayerFrameAutohideDisplayUpdate();
            -- elseif event == "PLAYER_REGEN_DISABLED" or event == "UNIT_ENTERED_VEHICLE" then
            elseif event == "PLAYER_REGEN_DISABLED" then
                PlayerFrame:SetAlpha(1);
            end
        end)
    else
        if fah:IsEventRegistered("PLAYER_ENTERING_WORLD") then
            fah:UnregisterAllEvents();
            fah:SetScript("OnEvent", nil);
            UnitFramesPlus_PlayerFrameAutohideDisplayUpdate();
        end
    end
end

function UnitFramesPlus_PlayerFrameAutohideDisplayUpdate()
    if not InCombatLockdown() then
        if UnitFramesPlusDB["player"]["autohide"] == 1 then
            -- local powertype = UnitPowerType("player");
            -- if (( powertype == 0 or powertype == 2 or powertype == 3 ) and UnitPower("player") ~= UnitPowerMax("player"))
                -- or (( powertype == 1 or powertype == 6 ) and UnitPower("player") ~= 0)
            if (UnitHealth("player") ~= UnitHealthMax("player")) or UnitExists("target") then
                PlayerFrame:SetAlpha(1);
                return;
            end
            PlayerFrame:SetAlpha(0);
        else
            PlayerFrame:SetAlpha(1);
        end
    end
end

--头像缩放
function UnitFramesPlus_PlayerFrameScaleSet(newscale)
    -- local oldscale = oldscale or UnitFramesPlusDB["player"]["scale"];
    local oldscale = PlayerFrame:GetScale();
    local newscale = newscale or UnitFramesPlusDB["player"]["scale"];
    local point, relativeTo, relativePoint, offsetX, offsetY = PlayerFrame:GetPoint();
    PlayerFrame:SetScale(newscale);
    PlayerFrame:ClearAllPoints();
    PlayerFrame:SetPoint(point, relativeTo, relativePoint, offsetX*oldscale/newscale, offsetY*oldscale/newscale);
    UnitFramesPlus_TargetPosition();
    if UnitFramesPlusDB["player"]["portrait"] == 1 and UnitFramesPlusDB["player"]["portraittype"] == 1 then
        UnitFramesPlus_PlayerPortraitDisplayUpdate();
    end
end

function UnitFramesPlus_PlayerFrameScale(newscale)
    if not InCombatLockdown() then
        UnitFramesPlus_PlayerFrameScaleSet(newscale);
    else
        local func = {};
        func.name = "UnitFramesPlus_PlayerFrameScaleSet";
        func.callback = function()
            UnitFramesPlus_PlayerFrameScaleSet(newscale);
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--鼠标移过时才显示数值
function UnitFramesPlus_PlayerBarTextMouseShow()
    if UnitFramesPlusDB["player"]["mouseshow"] == 1 then
        PlayerFrameHealthBarText:SetAlpha(0);
        PlayerFrameHealthBarTextLeft:SetAlpha(0);
        PlayerFrameHealthBarTextRight:SetAlpha(0);
        PlayerFrameHealthBar:SetScript("OnEnter", function(self)
            PlayerFrameHealthBarText:SetAlpha(1);
            PlayerFrameHealthBarTextLeft:SetAlpha(1);
            PlayerFrameHealthBarTextRight:SetAlpha(1);
            if ( self.tooltipTitle ) then
                GameTooltip_AddNewbieTip(self, self.tooltipTitle, 1.0, 1.0, 1.0, self.tooltipText, 1);
            end
        end);
        PlayerFrameHealthBar:SetScript("OnLeave", function()
            PlayerFrameHealthBarText:SetAlpha(0);
            PlayerFrameHealthBarTextLeft:SetAlpha(0);
            PlayerFrameHealthBarTextRight:SetAlpha(0);
            GameTooltip:Hide();
        end);
        PlayerFrameManaBarText:SetAlpha(0);
        PlayerFrameManaBarTextLeft:SetAlpha(0);
        PlayerFrameManaBarTextRight:SetAlpha(0);
        PlayerFrameManaBar:SetScript("OnEnter", function(self)
            PlayerFrameManaBarText:SetAlpha(1);
            PlayerFrameManaBarTextLeft:SetAlpha(1);
            PlayerFrameManaBarTextRight:SetAlpha(1);
            if ( self.tooltipTitle ) then
                GameTooltip_AddNewbieTip(self, self.tooltipTitle, 1.0, 1.0, 1.0, self.tooltipText, 1);
            end
        end);
        PlayerFrameManaBar:SetScript("OnLeave", function()
            PlayerFrameManaBarText:SetAlpha(0);
            PlayerFrameManaBarTextLeft:SetAlpha(0);
            PlayerFrameManaBarTextRight:SetAlpha(0);
            GameTooltip:Hide();
        end);
        -- PlayerFrameAlternateManaBarText:SetAlpha(0);
        -- PlayerFrameAlternateManaBar.LeftText:SetAlpha(0);
        -- PlayerFrameAlternateManaBar.RightText:SetAlpha(0);
        -- PlayerFrameAlternateManaBar:SetScript("OnEnter",function(self)
        --     PlayerFrameAlternateManaBarText:SetAlpha(1);
        --     PlayerFrameAlternateManaBar.LeftText:SetAlpha(1);
        --     PlayerFrameAlternateManaBar.RightText:SetAlpha(1);
        -- end);
        -- PlayerFrameAlternateManaBar:SetScript("OnLeave",function()
        --     PlayerFrameAlternateManaBarText:SetAlpha(0);
        --     PlayerFrameAlternateManaBar.LeftText:SetAlpha(0);
        --     PlayerFrameAlternateManaBar.RightText:SetAlpha(0);
        -- end);
    else
        PlayerFrameHealthBarText:SetAlpha(1);
        PlayerFrameHealthBarTextLeft:SetAlpha(1);
        PlayerFrameHealthBarTextRight:SetAlpha(1);
        PlayerFrameHealthBar:SetScript("OnEnter", function(self)
            if ( self.tooltipTitle ) then
                GameTooltip_AddNewbieTip(self, self.tooltipTitle, 1.0, 1.0, 1.0, self.tooltipText, 1);
            end
        end);
        PlayerFrameHealthBar:SetScript("OnLeave", function()
            GameTooltip:Hide();
        end);
        PlayerFrameManaBarText:SetAlpha(1);
        PlayerFrameManaBarTextLeft:SetAlpha(1);
        PlayerFrameManaBarTextRight:SetAlpha(1);
        PlayerFrameManaBar:SetScript("OnEnter", function(self)
            if ( self.tooltipTitle ) then
                GameTooltip_AddNewbieTip(self, self.tooltipTitle, 1.0, 1.0, 1.0, self.tooltipText, 1);
            end
        end);
        PlayerFrameManaBar:SetScript("OnLeave", function()
            GameTooltip:Hide();
        end);
        -- PlayerFrameAlternateManaBarText:SetAlpha(1);
        -- PlayerFrameAlternateManaBar.LeftText:SetAlpha(1);
        -- PlayerFrameAlternateManaBar.RightText:SetAlpha(1);
        -- PlayerFrameAlternateManaBar:SetScript("OnEnter",nil);
        -- PlayerFrameAlternateManaBar:SetScript("OnLeave",nil);
    end
end

function UnitFramesPlus_PlayerExtraTextFontSize()
    UFP_PlayerHPMPPctHP:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["player"]["fontsize"], "OUTLINE");
    UFP_PlayerHPMPPctMP:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["player"]["fontsize"], "OUTLINE");
    UFP_PlayerHPMPPctPct:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["player"]["fontsize"], "OUTLINE");

    PlayerName:SetFont(GameFontNormalSmall:GetFont(), UnitFramesPlusDB["player"]["fontsize"]);
    PlayerFrameHealthBarText:SetFont(TextStatusBarText:GetFont(), UnitFramesPlusDB["player"]["fontsize"], "OUTLINE");
    PlayerFrameHealthBarTextLeft:SetFont(TextStatusBarText:GetFont(), UnitFramesPlusDB["player"]["fontsize"], "OUTLINE");
    PlayerFrameHealthBarTextRight:SetFont(TextStatusBarText:GetFont(), UnitFramesPlusDB["player"]["fontsize"], "OUTLINE");
    PlayerFrameManaBarText:SetFont(TextStatusBarText:GetFont(), UnitFramesPlusDB["player"]["fontsize"], "OUTLINE");
    PlayerFrameManaBarTextLeft:SetFont(TextStatusBarText:GetFont(), UnitFramesPlusDB["player"]["fontsize"], "OUTLINE");
    PlayerFrameManaBarTextRight:SetFont(TextStatusBarText:GetFont(), UnitFramesPlusDB["player"]["fontsize"], "OUTLINE");
end

--模块初始化
function UnitFramesPlus_PlayerInit()
    UnitFramesPlus_PlayerShiftDrag();
    UnitFramesPlus_PlayerDragon();
    UnitFramesPlus_PlayerExtrabar();
    -- UnitFramesPlus_PlayerColorHPBar();
    UnitFramesPlus_PlayerPortraitIndicator();
    UnitFramesPlus_PlayerPortrait();
    UnitFramesPlus_PlayerCoordinate();
    UnitFramesPlus_PlayerFrameScale();
    UnitFramesPlus_PlayerFrameAutohide();
    UnitFramesPlus_PlayerBarTextMouseShow();
    UnitFramesPlus_PlayerExtraTextFontSize();
end

function UnitFramesPlus_PlayerLayout()
    UnitFramesPlus_PlayerPosition();
end