--变量
local id = 1;
local _G = _G;
local RaiseFrameLevel = RaiseFrameLevel;
local CastingBarFrame_OnLoad = CastingBarFrame_OnLoad;
local CastingBarFrame_OnEvent = CastingBarFrame_OnEvent;
local CastingBarFrame_OnUpdate = CastingBarFrame_OnUpdate;
local CastingBarFrame_OnShow = CastingBarFrame_OnShow;

--队友施法条
for id = 1, 4, 1 do
    local PartyCastbar = CreateFrame("StatusBar", "UFP_PartyCastbar"..id, _G["PartyMemberFrame"..id]);
    PartyCastbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
    PartyCastbar:SetStatusBarColor(1.0, 0.7, 0.0);
    PartyCastbar:SetWidth(90);
    PartyCastbar:SetHeight(10);
    PartyCastbar:ClearAllPoints();
    PartyCastbar:SetID(id);
    PartyCastbar:SetFrameStrata("MEDIUM");
    RaiseFrameLevel(PartyCastbar);

    PartyCastbar.Background = PartyCastbar:CreateTexture("UFP_PartyCastbar"..id.."Background", "BACKGROUND");
    PartyCastbar.Background:ClearAllPoints();
    PartyCastbar.Background:SetAllPoints(PartyCastbar);
    PartyCastbar.Background:SetVertexColor(0, 0, 0, 0.5);

    PartyCastbar.Border = PartyCastbar:CreateTexture("UFP_PartyCastbar"..id.."Border", "BORDER");
    PartyCastbar.Border:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small");
    PartyCastbar.Border:SetWidth(126);
    PartyCastbar.Border:SetHeight(48);
    PartyCastbar.Border:ClearAllPoints();
    PartyCastbar.Border:SetPoint("TOP", PartyCastbar, "TOP", 0, 20);

    PartyCastbar.Text = PartyCastbar:CreateFontString("UFP_PartyCastbar"..id.."Text", "ARTWORK", "GameFontHighlight");
    PartyCastbar.Text:SetTextHeight(13);
    PartyCastbar.Text:ClearAllPoints();
    PartyCastbar.Text:SetPoint("TOP", PartyCastbar, "TOP", 0, 2);

    PartyCastbar.Icon = PartyCastbar:CreateTexture("UFP_PartyCastbar"..id.."Icon", "ARTWORK");
    PartyCastbar.Icon:SetWidth(16);
    PartyCastbar.Icon:SetHeight(16);
    PartyCastbar.Icon:ClearAllPoints();
    PartyCastbar.Icon:SetPoint("RIGHT", PartyCastbar, "LEFT", -5, 0);

    PartyCastbar.Spark = PartyCastbar:CreateTexture("UFP_PartyCastbar"..id.."Spark", "OVERLAY");
    PartyCastbar.Spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark");
    PartyCastbar.Spark:SetWidth(32);
    PartyCastbar.Spark:SetHeight(32);
    PartyCastbar.Spark:ClearAllPoints();
    PartyCastbar.Spark:SetPoint("CENTER", PartyCastbar, "CENTER", 0, 0);
    PartyCastbar.Spark:SetBlendMode("ADD");

    PartyCastbar.Flash = PartyCastbar:CreateTexture("UFP_PartyCastbar"..id.."Flash", "OVERLAY");
    PartyCastbar.Flash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small");
    PartyCastbar.Flash:SetWidth(126);
    PartyCastbar.Flash:SetHeight(48);
    PartyCastbar.Flash:ClearAllPoints();
    PartyCastbar.Flash:SetPoint("TOP", PartyCastbar, "TOP", 0, 20);
    PartyCastbar.Flash:SetBlendMode("ADD");

    CastingBarFrame_OnLoad(PartyCastbar, "party"..id, true, false);
end

function UnitFramesPlus_PartyCastbar()
    for id = 1, 4, 1 do
        if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["castbar"] == 1 then
            _G["UFP_PartyCastbar"..id]:SetAlpha(1);
            _G["UFP_PartyCastbar"..id]:SetScript("OnEvent", function(self, event, ...)
                CastingBarFrame_OnEvent(self, event, ...);
            end)
            _G["UFP_PartyCastbar"..id]:SetScript("OnUpdate", function(self, elapsed)
                CastingBarFrame_OnUpdate(self, elapsed);
            end)
            _G["UFP_PartyCastbar"..id]:SetScript("OnShow", function(self)
                CastingBarFrame_OnShow(self);
                self:ClearAllPoints();
                if (_G["PartyMemberFrame"..self:GetID().."PetFrame"]:IsShown()) then
                    self:SetPoint("BOTTOM", self:GetParent(), "BOTTOM", 6, -27);
                else
                    self:SetPoint("BOTTOM", self:GetParent(), "BOTTOM", 6, -12);
                end
            end);
        else
            _G["UFP_PartyCastbar"..id]:SetAlpha(0);
            _G["UFP_PartyCastbar"..id]:SetScript("OnEvent", nil);
            _G["UFP_PartyCastbar"..id]:SetScript("OnUpdate", nil);
            _G["UFP_PartyCastbar"..id]:SetScript("OnShow", nil);
        end
    end
end

function UnitFramesPlus_PartyCastbarInit()
    UnitFramesPlus_PartyCastbar();
end
