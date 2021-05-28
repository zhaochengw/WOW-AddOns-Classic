--变量
local id = 1;
local _G = _G;
local pairs = pairs;
local select = select;
local UnitClass = UnitClass;
local UnitIsVisible = UnitIsVisible;
local IsInInstance = IsInInstance;
local GetSpellInfo = GetSpellInfo;
local IsSpellInRange = IsSpellInRange;

-- --BOSS生命值百分比
-- for id = 1, MAX_BOSS_FRAMES, 1 do
--     local BossHPPct = CreateFrame("Frame", "UFP_Boss"..id.."HPPct", _G["Boss"..id.."TargetFrameHealthBar"]);
--     BossHPPct:SetWidth(50)
--     BossHPPct:SetHeight(20)
--     BossHPPct:ClearAllPoints();
--     BossHPPct:SetPoint("LEFT", _G["Boss"..id.."TargetFrameHealthBar"], "LEFT", -51, 0)
--     BossHPPct.Text = BossHPPct:CreateFontString("UFP_Boss"..id.."HPPctText", "ARTWORK", "TextStatusBarText")
--     BossHPPct.Text:ClearAllPoints();
--     BossHPPct.Text:SetAllPoints(BossHPPct)
--     BossHPPct.Text:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
--     BossHPPct.Text:SetTextColor(1, 0.75, 0);
--     BossHPPct.Text:SetJustifyH("RIGHT")
-- end

-- function UnitFramesPlus_BossHealthPct()
--     if UnitFramesPlusDB["extra"]["bosshppct"] == 1 then
--         for id = 1, MAX_BOSS_FRAMES, 1 do
--             _G["UFP_Boss"..id.."HPPct"]:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT");
--             _G["UFP_Boss"..id.."HPPct"]:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "boss"..id)
--             _G["UFP_Boss"..id.."HPPct"]:SetScript("OnEvent", function(self, event, ...)
--                 UnitFramesPlus_BossHealthPctDisplayUpdate(id);
--             end)
--         end
--     else
--         for id = 1, MAX_BOSS_FRAMES, 1 do
--             _G["UFP_Boss"..id.."HPPct"].Text:SetText("");
--             if _G["UFP_Boss"..id.."HPPct"]:IsEventRegistered("INSTANCE_ENCOUNTER_ENGAGE_UNIT") then
--                 _G["UFP_Boss"..id.."HPPct"]:UnregisterAllEvents();
--                 _G["UFP_Boss"..id.."HPPct"]:SetScript("OnEvent", nil);
--             end
--         end
--     end
-- end

-- --刷新目标生命值百分比显示
-- function UnitFramesPlus_BossHealthPctDisplayUpdate(id)
--     local PctText = "";
--     if UnitExists("boss"..id) and UnitFramesPlusDB["extra"]["bosshppct"] == 1 then
--         local CurHP = UnitHealth("boss"..id);
--         local MaxHP = UnitHealthMax("boss"..id);
--         if MaxHP > 0 then
--             PctText = math.floor(100*CurHP/MaxHP).."%";
--         end
--     end
--     _G["UFP_Boss"..id.."HPPct"].Text:SetText(PctText);
-- end

--治疗职业距离检测
local function UnitFramesPlus_RangeCheckInit()
    local class = select(2, UnitClass("player"));
    local spellname = "";
    local enable = 0;
    if class == "SHAMAN" then
        enable = 1;
        spellname = GetSpellInfo(331);--治疗波331,1+，治疗之涌8004,7+
    elseif class == "DRUID" then
        enable = 1;
        spellname = GetSpellInfo(5185);--治疗之触5185,1+，回春术774,10+
    elseif class == "PALADIN" then
        enable = 1;
        spellname = GetSpellInfo(635);--圣光术635,1+，圣光闪现19750,8+
    elseif class == "PRIEST" then
        enable = 1;
        spellname = GetSpellInfo(2052);--次级治疗术2052,1+，快速治疗2061,10+
    -- elseif class == "MONK" then
    --     enable = 1;
    --     spellname = GetSpellInfo(116670);--活血术,8+
    end
    UnitFramesPlusVar["rangecheck"]["enable"] = enable;
    UnitFramesPlusVar["rangecheck"]["spellname"] = spellname;
end

local rcframes = {
    TargetFrame,
    -- FocusFrame,
    PartyMemberFrame1,
    PartyMemberFrame2,
    PartyMemberFrame3,
    PartyMemberFrame4,
}

local rc = CreateFrame("Frame");
function UnitFramesPlus_RangeCheck()
    if UnitFramesPlusVar["rangecheck"]["enable"] == 1 then
        if UnitFramesPlusDB["extra"]["rangecheck"] == 1 then
            rc:SetScript("OnUpdate", function(self, elapsed)
                self.timer = (self.timer or 0) + elapsed;
                if self.timer >= 0.2 then
                    for i, frame in pairs(rcframes) do
                        if frame:IsShown() and frame.unit then
                            local inRange = IsSpellInRange(UnitFramesPlusVar["rangecheck"]["spellname"], frame.unit);
                            local _, instanceType = IsInInstance();
                            if (inRange == 0 or not UnitIsVisible(frame.unit)) and not (instanceType == "none" and UnitFramesPlusDB["extra"]["instanceonly"] == 1) then
                                frame:SetAlpha(0.5);
                            else
                                frame:SetAlpha(1);
                            end
                        else
                            frame:SetAlpha(1);
                        end
                    end
                end
            end)
        else
            rc:SetScript("OnUpdate", nil);
            for i, frame in pairs(rcframes) do
                frame:SetAlpha(1);
            end
        end
    end
end

-- --状态条数值显示为万亿
-- local function UnitFramesPlus_AbbreviateLargeNumbers(value)
--     if GetLocale() == "zhCN" then
--         unitbig = "亿";
--         unitsmall = "万";
--     elseif GetLocale() == "zhTW" then
--         unitbig = "億";
--         unitsmall = "萬";
--     end
--     local retString = value;
--     if value >= 100000000 then
--         retString = (math.floor(value/10000000)/10)..unitbig;
--     elseif value >= 10000 then
--         retString = math.floor(value/10000)..unitsmall;
--     end
--     return retString;
-- end
 
-- function UnitFramesPlus_TextStatusBar_UpdateTextStringWithValues(statusFrame, textString, value, valueMin, valueMax)
--     if UnitFramesPlusDB["global"]["textunit"] == 1 then
--         if( statusFrame.LeftText and statusFrame.RightText ) then
--             statusFrame.LeftText:SetText("");
--             statusFrame.RightText:SetText("");
--             statusFrame.LeftText:Hide();
--             statusFrame.RightText:Hide();
--         end
     
--         if ( ( tonumber(valueMax) ~= valueMax or valueMax > 0 ) and not ( statusFrame.pauseUpdates ) ) then
--             statusFrame:Show();
         
--             if ( (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) or statusFrame.forceShow ) then
--                 textString:Show();
--             elseif ( statusFrame.lockShow > 0 and (not statusFrame.forceHideText) ) then
--                 textString:Show();
--             else
--                 textString:SetText("");
--                 textString:Hide();
--                 return;
--             end
     
--             local valueDisplay = value;
--             local valueMaxDisplay = valueMax;

--             -- Modern WoW always breaks up large numbers, whereas Classic never did.
--             -- We'll remove breaking-up by default for Classic, but add a flag to reenable it.
--             -- if ( statusFrame.breakUpLargeNumbers ) then
--             --     if ( statusFrame.capNumericDisplay ) then
--             --         valueDisplay = UnitFramesPlus_AbbreviateLargeNumbers(value);
--             --         valueMaxDisplay = UnitFramesPlus_AbbreviateLargeNumbers(valueMax);
--             --     else
--             --         valueDisplay = BreakUpLargeNumbers(value);
--             --         valueMaxDisplay = BreakUpLargeNumbers(valueMax);
--             --     end
--             -- end
--             if ( statusFrame.capNumericDisplay ) then
--                 valueDisplay = UnitFramesPlus_AbbreviateLargeNumbers(value);
--                 valueMaxDisplay = UnitFramesPlus_AbbreviateLargeNumbers(valueMax);
--             else
--                 valueDisplay = BreakUpLargeNumbers(value);
--                 valueMaxDisplay = BreakUpLargeNumbers(valueMax);
--             end

--             local textDisplay = GetCVar("statusTextDisplay");
--             if ( value and valueMax > 0 and ( (textDisplay ~= "NUMERIC" and textDisplay ~= "NONE") or statusFrame.showPercentage ) and not statusFrame.showNumeric) then
--                 if ( value == 0 and statusFrame.zeroText ) then
--                     textString:SetText(statusFrame.zeroText);
--                     statusFrame.isZero = 1;
--                     textString:Show();
--                 elseif ( textDisplay == "BOTH" and not statusFrame.showPercentage) then
--                     if( statusFrame.LeftText and statusFrame.RightText ) then
--                         if(not statusFrame.powerToken or statusFrame.powerToken == "MANA") then
--                             statusFrame.LeftText:SetText(math.ceil((value / valueMax) * 100) .. "%");
--                             statusFrame.LeftText:Show();
--                         end
--                         statusFrame.RightText:SetText(valueDisplay);
--                         statusFrame.RightText:Show();
--                         textString:Hide();
--                     else
--                         valueDisplay = "(" .. math.ceil((value / valueMax) * 100) .. "%) " .. valueDisplay .. " / " .. valueMaxDisplay;
--                     end
--                     textString:SetText(valueDisplay);
--                 else
--                     valueDisplay = math.ceil((value / valueMax) * 100) .. "%";
--                     if ( statusFrame.prefix and (statusFrame.alwaysPrefix or not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) ) ) then
--                         textString:SetText(statusFrame.prefix .. " " .. valueDisplay);
--                     else
--                         textString:SetText(valueDisplay);
--                     end
--                 end
--             elseif ( value == 0 and statusFrame.zeroText ) then
--                 textString:SetText(statusFrame.zeroText);
--                 statusFrame.isZero = 1;
--                 textString:Show();
--                 return;
--             else
--                 statusFrame.isZero = nil;
--                 if ( statusFrame.prefix and (statusFrame.alwaysPrefix or not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) ) ) then
--                     textString:SetText(statusFrame.prefix.." "..valueDisplay.." / "..valueMaxDisplay);
--                 else
--                     textString:SetText(valueDisplay.." / "..valueMaxDisplay);
--                 end
--             end
--         else
--             textString:Hide();
--             textString:SetText("");
--             if ( not statusFrame.alwaysShow ) then
--                 statusFrame:Hide();
--             else
--                 statusFrame:SetValue(0);
--             end
--         end
--     end
-- end

-- --鼠标移过时才显示数值
-- function UnitFramesPlus_ArenaEnemyBarTextMouseShow()
--     if UnitFramesPlusDB["extra"]["pvpmouseshow"] == 1 then
--         if IsAddOnLoaded("Blizzard_ArenaUI") then
--             for id = 1, MAX_ARENA_ENEMIES, 1 do
--                 _G["ArenaEnemyFrame"..id.."HealthBarText"]:SetAlpha(0);
--                 _G["ArenaEnemyFrame"..id.."HealthBar"]:SetScript("OnEnter",function(self)
--                     _G["ArenaEnemyFrame"..id.."HealthBarText"]:SetAlpha(1);
--                 end);
--                 _G["ArenaEnemyFrame"..id.."HealthBar"]:SetScript("OnLeave",function()
--                     _G["ArenaEnemyFrame"..id.."HealthBarText"]:SetAlpha(0);
--                 end);
--                 _G["ArenaEnemyFrame"..id.."ManaBarText"]:SetAlpha(0);
--                 _G["ArenaEnemyFrame"..id.."ManaBar"]:SetScript("OnEnter",function(self)
--                     _G["ArenaEnemyFrame"..id.."ManaBarText"]:SetAlpha(1);
--                 end);
--                 _G["ArenaEnemyFrame"..id.."ManaBar"]:SetScript("OnLeave",function()
--                     _G["ArenaEnemyFrame"..id.."ManaBarText"]:SetAlpha(0);
--                 end);
--             end
--         end
--     else
--         if IsAddOnLoaded("Blizzard_ArenaUI") then
--             for id = 1, MAX_ARENA_ENEMIES, 1 do
--                 _G["ArenaEnemyFrame"..id.."HealthBarText"]:SetAlpha(1);
--                 _G["ArenaEnemyFrame"..id.."HealthBar"]:SetScript("OnEnter",nil);
--                 _G["ArenaEnemyFrame"..id.."HealthBar"]:SetScript("OnLeave",nil);
--                 _G["ArenaEnemyFrame"..id.."ManaBarText"]:SetAlpha(1);
--                 _G["ArenaEnemyFrame"..id.."ManaBar"]:SetScript("OnEnter",nil);
--                 _G["ArenaEnemyFrame"..id.."ManaBar"]:SetScript("OnLeave",nil);
--             end
--         end
--     end
-- end

-- --生命值百分比
-- local function UnitFramesPlus_ArenaEnemyHPPctCreateFrame()
--     if IsAddOnLoaded("Blizzard_ArenaUI") then
--         for id = 1, MAX_ARENA_ENEMIES, 1 do
--             local ArenaEnemyHPPct = CreateFrame("Frame", "UFP_ArenaEnemyHPPct"..id, _G["ArenaEnemyFrame"..id]);
--             ArenaEnemyHPPct:SetWidth(45);
--             ArenaEnemyHPPct:SetHeight(20);
--             ArenaEnemyHPPct:ClearAllPoints();
--             ArenaEnemyHPPct:SetPoint("RIGHT", _G["ArenaEnemyFrame"..id.."HealthBar"], "LEFT", -1, -1);
--             ArenaEnemyHPPct.Text = ArenaEnemyHPPct:CreateFontString("UFP_ArenaEnemyHPPctText"..id, "OVERLAY", "TextStatusBarText");
--             ArenaEnemyHPPct.Text:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
--             ArenaEnemyHPPct.Text:ClearAllPoints();
--             ArenaEnemyHPPct.Text:SetAllPoints(ArenaEnemyHPPct);
--             ArenaEnemyHPPct.Text:SetTextColor(1, 0.75, 0);
--             ArenaEnemyHPPct.Text:SetJustifyH("RIGHT");
--             ArenaEnemyHPPct:Hide();
--         end
--     end
-- end

-- --刷新生命值百分比显示
-- function UnitFramesPlus_ArenaEnemyHPPctDisplayUpdate(id)
--     if UnitExists("arena"..id) then
--         local ArenaEnemyHPPctText = "";
--         if UnitFramesPlusDB["extra"]["pvphppct"] == 1 then
--             local CurHP = UnitHealth("arena"..id);
--             local MaxHP = UnitHealthMax("arena"..id);
--             if MaxHP > 0 then
--                 ArenaEnemyHPPctText = math.floor(100*CurHP/MaxHP).."%";
--             end
--         end
--         _G["UFP_ArenaEnemyHPPct"..id].Text:SetText(ArenaEnemyHPPctText);
--     end
-- end


-- function UnitFramesPlus_ArenaEnemyHPPct()
--     if IsAddOnLoaded("Blizzard_ArenaUI") then
--         for id = 1, MAX_ARENA_ENEMIES, 1 do
--             if UnitFramesPlusDB["extra"]["pvphppct"] == 0 then
--                 if _G["UFP_ArenaEnemyHPPct"..id]:IsEventRegistered("UNIT_HEALTH_FREQUENT") then
--                     _G["UFP_ArenaEnemyHPPct"..id]:UnregisterAllEvents();
--                     _G["UFP_ArenaEnemyHPPct"..id]:SetScript("OnEvent", nil);
--                     _G["UFP_ArenaEnemyHPPct"..id]:Hide();
--                 end
--             else
--                 _G["UFP_ArenaEnemyHPPct"..id]:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "arena"..id);
--                 _G["UFP_ArenaEnemyHPPct"..id]:SetScript("OnEvent", function(self, event, ...)
--                     UnitFramesPlus_ArenaEnemyHPPctDisplayUpdate(id);
--                 end)
--                 _G["UFP_ArenaEnemyHPPct"..id]:Show();
--             end
--         end
--     end
-- end

-- local pvp = CreateFrame("Frame");
-- pvp:RegisterEvent("PLAYER_LOGIN");
-- pvp:SetScript("OnEvent", function(self, event, ...)
--     if event == "PLAYER_LOGIN" then
--         if IsAddOnLoaded("Blizzard_ArenaUI") then
--             UnitFramesPlus_ArenaEnemyBarTextMouseShow();
--             UnitFramesPlus_ArenaEnemyHPPctCreateFrame();
--             UnitFramesPlus_ArenaEnemyHPPct();
--         end
--     end
-- end)

function UnitFramesPlus_ExtraInit()
    -- UnitFramesPlus_BossHealthPct();
    UnitFramesPlus_RangeCheckInit();
    UnitFramesPlus_RangeCheck();
    -- if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
    --     hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UnitFramesPlus_TextStatusBar_UpdateTextStringWithValues);
    -- end
end
