--变量
local IsShiftKeyDown = IsShiftKeyDown;
local InCombatLockdown = InCombatLockdown;
local hooksecurefunc = hooksecurefunc;

--宠物头像内战斗信息
function UnitFramesPlus_PetPortraitIndicator()
    local petregistered = PetFrame:IsEventRegistered("UNIT_COMBAT");
    if UnitFramesPlusDB["pet"]["indicator"] == 1 then
        if not petregistered then
            PetFrame:RegisterUnitEvent("UNIT_COMBAT", "player", "vehicle");
        end
    else
        if petregistered then
            PetFrame:UnregisterEvent("UNIT_COMBAT");
        end
    end
end

--鼠标移过时才显示数值
function UnitFramesPlus_PetBarTextMouseShow()
    if UnitFramesPlusDB["pet"]["mouseshow"] == 1 then
        PetFrameHealthBarText:SetAlpha(0);
        PetFrameHealthBarTextLeft:SetAlpha(0);
        PetFrameHealthBarTextRight:SetAlpha(0);
        PetFrameHealthBar:SetScript("OnEnter",function(self)
            PetFrameHealthBarText:SetAlpha(1);
            PetFrameHealthBarTextLeft:SetAlpha(1);
            PetFrameHealthBarTextRight:SetAlpha(1);
        end);
        PetFrameHealthBar:SetScript("OnLeave",function()
            PetFrameHealthBarText:SetAlpha(0);
            PetFrameHealthBarTextLeft:SetAlpha(0);
            PetFrameHealthBarTextRight:SetAlpha(0);
        end);
        PetFrameManaBarText:SetAlpha(0);
        PetFrameManaBarTextLeft:SetAlpha(0);
        PetFrameManaBarTextRight:SetAlpha(0);
        PetFrameManaBar:SetScript("OnEnter",function(self)
            PetFrameManaBarText:SetAlpha(1);
            PetFrameManaBarTextLeft:SetAlpha(1);
            PetFrameManaBarTextRight:SetAlpha(1);
        end);
        PetFrameManaBar:SetScript("OnLeave",function()
            PetFrameManaBarText:SetAlpha(0);
            PetFrameManaBarTextLeft:SetAlpha(0);
            PetFrameManaBarTextRight:SetAlpha(0);
        end);
    else
        PetFrameHealthBarText:SetAlpha(1);
        PetFrameHealthBarTextLeft:SetAlpha(1);
        PetFrameHealthBarTextRight:SetAlpha(1);
        PetFrameHealthBar:SetScript("OnEnter",nil);
        PetFrameHealthBar:SetScript("OnLeave",nil);
        PetFrameManaBarText:SetAlpha(1);
        PetFrameManaBarTextLeft:SetAlpha(1);
        PetFrameManaBarTextRight:SetAlpha(1);
        PetFrameManaBar:SetScript("OnEnter",nil);
        PetFrameManaBar:SetScript("OnLeave",nil);
    end
end

--非战斗状态中允许shift+左键拖动宠物头像
function UnitFramesPlus_PetPositionSet()
    if UnitFramesPlusVar["pet"]["moved"] == 1 then
        PetFrame:ClearAllPoints();
        PetFrame:SetPoint("BOTTOMLEFT", PlayerFrame, "BOTTOMLEFT", UnitFramesPlusVar["pet"]["x"], UnitFramesPlusVar["pet"]["y"]);
    else
        PetFrame:ClearAllPoints();
        PetFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 80, -60);
    end
end

function UnitFramesPlus_PetPosition()
    if not InCombatLockdown() then
        UnitFramesPlus_PetPositionSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PetPositionSet";
        func.callback = function()
            UnitFramesPlus_PetPositionSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

local function UnitFramesPlus_PetShiftDrag()
    PetFrame:SetMovable(1);

    PetFrame:SetScript("OnMouseDown", function(self, elapsed)
        if UnitFramesPlusDB["pet"]["movable"] == 1 then
            if IsShiftKeyDown() and (not InCombatLockdown()) then
                PetFrame:StartMoving();
                UnitFramesPlusVar["pet"]["moving"] = 1;
            end
        end
    end)

    PetFrame:SetScript("OnMouseUp", function(self, elapsed)
        if UnitFramesPlusVar["pet"]["moving"] == 1 then
            PetFrame:StopMovingOrSizing();
            UnitFramesPlusVar["pet"]["moving"] = 0;
            UnitFramesPlusVar["pet"]["moved"] = 1;
            local bottom = PetFrame:GetBottom();
            local left = PetFrame:GetLeft();
            local scale = PetFrame:GetScale()*PlayerFrame:GetScale();
            local bottomX = PlayerFrame:GetBottom();
            local leftX = PlayerFrame:GetLeft();
            local scaleX = PlayerFrame:GetScale();
            UnitFramesPlusVar["pet"]["x"] = (left*scale-leftX*scaleX)/scale;
            UnitFramesPlusVar["pet"]["y"] = (bottom*scale-bottomX*scaleX)/scale;
            PetFrame:ClearAllPoints();
            PetFrame:SetPoint("BOTTOMLEFT", PlayerFrame, "BOTTOMLEFT", UnitFramesPlusVar["pet"]["x"], UnitFramesPlusVar["pet"]["y"]);
        end
    end)

    PetFrame:SetClampedToScreen(1);

    --重置目标位置时同时重置宠物位置
    hooksecurefunc("PlayerFrame_ResetUserPlacedPosition", function()
        UnitFramesPlusVar["pet"]["moved"] = 0;
        UnitFramesPlus_PetPosition();
    end)
end

--模块初始化
function UnitFramesPlus_PetInit()
    UnitFramesPlus_PetPortraitIndicator();
    UnitFramesPlus_PetBarTextMouseShow();
    UnitFramesPlus_PetShiftDrag();
end

function UnitFramesPlus_PetLayout()
    UnitFramesPlus_PetPosition();
end
