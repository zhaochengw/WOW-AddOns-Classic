local lp = CreateFrame('Frame')
lp:RegisterEvent("ADDON_LOADED");
lp:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...;
        if name == "LowHPPulser" then
            if not LowHPPulserDB then LowHPPulserDB = {}; end
            if not LowHPPulserDB["instance"] then LowHPPulserDB["instance"] = 1; end
            if not LowHPPulserDB["health"] then LowHPPulserDB["health"] = 1; end
            if not LowHPPulserDB["healthpct"] then LowHPPulserDB["healthpct"] = 25; end
            if not LowHPPulserDB["mana"] then LowHPPulserDB["mana"] = 1; end
            if not LowHPPulserDB["manapct"] then LowHPPulserDB["manapct"] = 25; end
            LowHPPulser_OptionPanel_OnShow();
            lp:UnregisterEvent("ADDON_LOADED");
        end
    end
end)

if (GetLocale() == "zhCN") then
    LowHPPulser_OnlyInInstance = "仅在副本内生效";
    LowHPPulser_HealthWarning = "血量警报";
    LowHPPulser_ManaWarning = "法力值警报";
    LowHPPulser_WarningPct = "警报比例：";
elseif (GetLocale() == "zhTW") then
    LowHPPulser_HealthWarning = "血量警報";
    LowHPPulser_ManaWarning = "法力值警報";
    LowHPPulser_WarningPct = "警報比例：";
else
    LowHPPulser_OnlyInInstance = "Instance only";
    LowHPPulser_HealthWarning = "Health warning";
    LowHPPulser_ManaWarning = "Mana warning";
    LowHPPulser_WarningPct = "Pct: ";
end

--设置面板
LowHPPulser_OptionsFrame = CreateFrame("Frame", "LowHPPulser_OptionsFrame", UIParent);
LowHPPulser_OptionsFrame.name = "LowHPPulser";
InterfaceOptions_AddCategory(LowHPPulser_OptionsFrame);
LowHPPulser_OptionsFrame:SetScript("OnShow", function()
    LowHPPulser_OptionPanel_OnShow();
end)

--插件介绍
local info = LowHPPulser_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
info:ClearAllPoints();
info:SetPoint("TOPLEFT", 16, -16);
info:SetText("LowHPPulser "..GetAddOnMetadata("LowHPPulser", "Version"));

--仅在副本内生效
local LowHPPulser_OptionsFrame_OnlyInInstance = CreateFrame("CheckButton", "LowHPPulser_OptionsFrame_OnlyInInstance", LowHPPulser_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
LowHPPulser_OptionsFrame_OnlyInInstance:ClearAllPoints();
LowHPPulser_OptionsFrame_OnlyInInstance:SetPoint("TOPLEFT", info, "TOPLEFT", 0, -50);
LowHPPulser_OptionsFrame_OnlyInInstance:SetHitRectInsets(0, -100, 0, 0);
LowHPPulser_OptionsFrame_OnlyInInstanceText:SetText(LowHPPulser_OnlyInInstance);
LowHPPulser_OptionsFrame_OnlyInInstance:SetScript("OnClick", function(self)
    LowHPPulserDB["instance"] = 1 - LowHPPulserDB["instance"];
    if LowHPPulserDB["instance"] == 0 then
        local inInstance = IsInInstance();
        if (inInstance == false) then
            LowHPPulser_StopPulsing(LowHPPulser_LowHealthFrame);
            LowHPPulser_StopPulsing(LowHPPulser_OutOfControlFrame);
        end
    end
    self:SetChecked(LowHPPulserDB["instance"]==1);
end)

--血量通告
local LowHPPulser_OptionsFrame_HealthWarning = CreateFrame("CheckButton", "LowHPPulser_OptionsFrame_HealthWarning", LowHPPulser_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
LowHPPulser_OptionsFrame_HealthWarning:ClearAllPoints();
LowHPPulser_OptionsFrame_HealthWarning:SetPoint("TOPLEFT", LowHPPulser_OptionsFrame_OnlyInInstance, "TOPLEFT", 0, -50);
LowHPPulser_OptionsFrame_HealthWarning:SetHitRectInsets(0, -100, 0, 0);
LowHPPulser_OptionsFrame_HealthWarningText:SetText(LowHPPulser_HealthWarning);
LowHPPulser_OptionsFrame_HealthWarning:SetScript("OnClick", function(self)
    LowHPPulserDB["health"] = 1 - LowHPPulserDB["health"];
    if LowHPPulserDB["health"] == 0 then
        LowHPPulser_StopPulsing(LowHPPulser_LowHealthFrame);
    end
    self:SetChecked(LowHPPulserDB["health"]==1);
end)

--血量通告百分比
local LowHPPulser_OptionsFrame_HealthWarningSlider = CreateFrame("Slider", "LowHPPulser_OptionsFrame_HealthWarningSlider", LowHPPulser_OptionsFrame, "OptionsSliderTemplate");
LowHPPulser_OptionsFrame_HealthWarningSlider:SetWidth(175);
LowHPPulser_OptionsFrame_HealthWarningSlider:SetHeight(16);
LowHPPulser_OptionsFrame_HealthWarningSlider:ClearAllPoints();
LowHPPulser_OptionsFrame_HealthWarningSlider:SetPoint("TOPLEFT", LowHPPulser_OptionsFrame_HealthWarning, "TOPLEFT", 155, 0);
LowHPPulser_OptionsFrame_HealthWarningSliderLow:SetText("1%");
LowHPPulser_OptionsFrame_HealthWarningSliderHigh:SetText("100%");
LowHPPulser_OptionsFrame_HealthWarningSlider:SetMinMaxValues(1,100);
LowHPPulser_OptionsFrame_HealthWarningSlider:SetValueStep(1);
LowHPPulser_OptionsFrame_HealthWarningSlider:SetObeyStepOnDrag(true);
LowHPPulser_OptionsFrame_HealthWarningSlider:SetScript("OnValueChanged", function(self, value)
    if LowHPPulserDB["healthpct"] ~= value then
        LowHPPulserDB["healthpct"] = value;
        LowHPPulser_OptionsFrame_HealthWarningSlider:SetValue(value);
        LowHPPulser_OptionsFrame_HealthWarningSliderText:SetText(LowHPPulser_WarningPct..value.."%");
    end
end)

--血量通告
local LowHPPulser_OptionsFrame_ManaWarning = CreateFrame("CheckButton", "LowHPPulser_OptionsFrame_ManaWarning", LowHPPulser_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
LowHPPulser_OptionsFrame_ManaWarning:ClearAllPoints();
LowHPPulser_OptionsFrame_ManaWarning:SetPoint("TOPLEFT", LowHPPulser_OptionsFrame_HealthWarning, "TOPLEFT", 0, -50);
LowHPPulser_OptionsFrame_ManaWarning:SetHitRectInsets(0, -100, 0, 0);
LowHPPulser_OptionsFrame_ManaWarningText:SetText(LowHPPulser_ManaWarning);
LowHPPulser_OptionsFrame_ManaWarning:SetScript("OnClick", function(self)
    LowHPPulserDB["mana"] = 1 - LowHPPulserDB["mana"];
    if LowHPPulserDB["mana"] == 0 then
        LowHPPulser_StopPulsing(LowHPPulser_OutOfControlFrame);
    end
    self:SetChecked(LowHPPulserDB["mana"]==1);
end)

--血量通告百分比
local LowHPPulser_OptionsFrame_ManaWarningSlider = CreateFrame("Slider", "LowHPPulser_OptionsFrame_ManaWarningSlider", LowHPPulser_OptionsFrame, "OptionsSliderTemplate");
LowHPPulser_OptionsFrame_ManaWarningSlider:SetWidth(175);
LowHPPulser_OptionsFrame_ManaWarningSlider:SetHeight(16);
LowHPPulser_OptionsFrame_ManaWarningSlider:ClearAllPoints();
LowHPPulser_OptionsFrame_ManaWarningSlider:SetPoint("TOPLEFT", LowHPPulser_OptionsFrame_ManaWarning, "TOPLEFT", 155, 0);
LowHPPulser_OptionsFrame_ManaWarningSliderLow:SetText("1%");
LowHPPulser_OptionsFrame_ManaWarningSliderHigh:SetText("100%");
LowHPPulser_OptionsFrame_ManaWarningSlider:SetMinMaxValues(1,100);
LowHPPulser_OptionsFrame_ManaWarningSlider:SetValueStep(1);
LowHPPulser_OptionsFrame_ManaWarningSlider:SetObeyStepOnDrag(true);
LowHPPulser_OptionsFrame_ManaWarningSlider:SetScript("OnValueChanged", function(self, value)
    if LowHPPulserDB["manapct"] ~= value then
        LowHPPulserDB["manapct"] = value;
        LowHPPulser_OptionsFrame_ManaWarningSlider:SetValue(value);
        LowHPPulser_OptionsFrame_ManaWarningSliderText:SetText(LowHPPulser_WarningPct..value.."%");
    end
end)

function LowHPPulser_OptionPanel_OnShow()
    LowHPPulser_OptionsFrame_OnlyInInstance:SetChecked(LowHPPulserDB["instance"]==1);
    LowHPPulser_OptionsFrame_HealthWarning:SetChecked(LowHPPulserDB["health"]==1);
    LowHPPulser_OptionsFrame_HealthWarningSlider:SetValue(LowHPPulserDB["healthpct"]);
    LowHPPulser_OptionsFrame_HealthWarningSliderText:SetText(LowHPPulser_WarningPct..LowHPPulserDB["healthpct"].."%");
    LowHPPulser_OptionsFrame_ManaWarning:SetChecked(LowHPPulserDB["mana"]==1);
    LowHPPulser_OptionsFrame_ManaWarningSlider:SetValue(LowHPPulserDB["manapct"]);
    LowHPPulser_OptionsFrame_ManaWarningSliderText:SetText(LowHPPulser_WarningPct..LowHPPulserDB["manapct"].."%");
end
