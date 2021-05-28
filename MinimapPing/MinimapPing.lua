local msg = CreateFrame("ScrollingMessageFrame", false, Minimap);
msg:SetHeight(10);
msg:SetWidth(100);
msg:ClearAllPoints();
msg:SetPoint("BOTTOM", Minimap, 0, 20);

msg:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE");
msg:SetJustifyH("CENTER");
msg:SetJustifyV("CENTER");
msg:SetMaxLines(1);
msg:SetFading(true);
msg:SetFadeDuration(3);
msg:SetTimeVisible(5);

function MinimapPing_Init()
    if enabled == 1 then
        msg:RegisterEvent("MINIMAP_PING");
        msg:SetScript("OnEvent", function(self, event, ...)
            if event == "MINIMAP_PING" then
                if enabled == 1 then
                    local unit = ...
                    local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))];
                    local name = UnitName(unit);
                    msg:AddMessage(name, color.r, color.g, color.b);
                end
            end
        end)
    else
        msg:UnregisterEvent("ADDON_LOADED");
        msg:SetScript("OnEvent", nil);
    end
end

function MinimapPing_Options_Init()
    if not enabled then
        enabled = 1;
    end
end

local mp = CreateFrame("Frame");
mp:RegisterEvent("ADDON_LOADED");
mp:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        MinimapPing_Options_Init();
        MinimapPing_Init();
        MinimapPing_OptionPanel_OnShow();
        mp:UnregisterEvent("ADDON_LOADED");
    end
end)

if GetLocale() == "zhCN" then
    MINIMAPPING_TITLE        = "谁在点击小地图？";
    MINIMAPPING_ENABLE        = "显示点击者姓名";
elseif GetLocale() == "zhTW" then
    MINIMAPPING_TITLE        = "誰在點擊小地圖？";
    MINIMAPPING_ENABLE        = "顯示點擊者姓名";
else
    MINIMAPPING_TITLE        = "Who is ping the minimap?";
    MINIMAPPING_ENABLE        = "Display player name";
end

--option panel
MinimapPing_OptionsFrame = CreateFrame("Frame", "MinimapPing_OptionsFrame", UIParent);
MinimapPing_OptionsFrame.name = "MinimapPing";
InterfaceOptions_AddCategory(MinimapPing_OptionsFrame);
MinimapPing_OptionsFrame:SetScript("OnShow", function()
    MinimapPing_OptionPanel_OnShow();
end)

do
    local MinimapPingTitle = MinimapPing_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    MinimapPingTitle:ClearAllPoints();
    MinimapPingTitle:SetPoint("TOPLEFT", 16, -16);
    MinimapPingTitle:SetText(MINIMAPPING_TITLE);

    local MinimapPingEnable = CreateFrame("CheckButton", "MinimapPingEnable", MinimapPing_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    MinimapPingEnable:ClearAllPoints();
    MinimapPingEnable:SetPoint("TOPLEFT", MinimapPingTitle, "TOPLEFT", 0, -30);
    MinimapPingEnable:SetHitRectInsets(0, -100, 0, 0);
    MinimapPingEnableText:SetText(MINIMAPPING_ENABLE);
    MinimapPingEnable:SetScript("OnClick", function(self)
        enabled = 1 - enabled;
        self:SetChecked(enabled==1);
    end)
end

function MinimapPing_OptionPanel_OnShow()
    MinimapPingEnable:SetChecked(enabled==1);
end
