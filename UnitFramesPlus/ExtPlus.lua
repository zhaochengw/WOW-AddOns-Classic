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
        spellname = GetSpellInfo(2061);--次级治疗术2052,1+，快速治疗2061,10+
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

function UnitFramesPlus_ExtraInit()
    UnitFramesPlus_RangeCheckInit();
    UnitFramesPlus_RangeCheck();
end
