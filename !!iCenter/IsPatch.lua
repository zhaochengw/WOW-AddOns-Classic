
local prefix = "%%d %%s ";
if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
    prefix = "%%d%%s";
end
local logouttext = string.gsub(tostring(CAMP_TIMER), prefix, "", 1);
local antilogout = CreateFrame("frame");
local function AntiAFKLogout()
    if ExtraConfiguration["antiafk"] == 1 or ExtraConfiguration["antilogout"] == 1 then
        antilogout:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 5 then
                if ExtraConfiguration["antilogout"] == 1 and StaticPopup1:IsShown() and StaticPopup1Button1:GetText() == CANCEL and not IsResting() and UnitIsAFK("player") then
                    local text = StaticPopup1Text:GetText();
                    if string.find(text, logouttext) then
                        StaticPopup1Button1:Click();
                    end
                end
                if ExtraConfiguration["antiafk"] == 1 and UnitIsAFK("player") then
                    SendChatMessage("|cffffffffSober! "..GetTime().."|r", "WHISPER", "COMMON", UnitName("player"));
                end
                self.timer = 0;
            end
        end);
    else
        antilogout:SetScript("OnUpdate", nil);
    end
end

local function AntiCrab()
    if ExtraConfiguration["anticrab"] == 1 then
        if GetCVar("overrideArchive") ~= 0 then
            SetCVar("overrideArchive", 0);
        end
    else
        if GetCVar("overrideArchive") ~= 1 then
            SetCVar("overrideArchive", 1);
        end
    end
end

--Interface/SharedXML/Util.lua
local function BlueShaman()
    if ExtraConfiguration["blueshaman"] == 1 then
        if math.ceil(RAID_CLASS_COLORS['SHAMAN']["r"]) ~= 0 then
            RAID_CLASS_COLORS['SHAMAN']["r"] = 0.0;
            RAID_CLASS_COLORS['SHAMAN']["g"] = 0.44;
            RAID_CLASS_COLORS['SHAMAN']["b"] = 0.87;
            -- RAID_CLASS_COLORS['SHAMAN']["colorStr"] = "ff0070DE";
        end
    else
        if math.ceil(RAID_CLASS_COLORS['SHAMAN']["r"]) == 0 then
            RAID_CLASS_COLORS['SHAMAN']["r"] = 0.96;
            RAID_CLASS_COLORS['SHAMAN']["g"] = 0.55;
            RAID_CLASS_COLORS['SHAMAN']["b"] = 0.73;
            -- RAID_CLASS_COLORS['SHAMAN']["colorStr"] = "ffF58CBA";
        end
    end
end

local function MaxCameraDistance()
    if ExtraConfiguration["maxcamera"] == 1 then
        SetCVar("cameraDistanceMaxZoomFactor", 3.5);
    end
end

local switch = CreateFrame('Frame');
switch:RegisterEvent("ADDON_LOADED");
switch:RegisterEvent("VARIABLES_LOADED");
switch:RegisterEvent("PLAYER_LOGIN");
switch:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...;
        if name == "!!iCenter" then
            if not ExtraConfiguration then ExtraConfiguration = {}; end
            if not ExtraConfiguration["anticrab"] then ExtraConfiguration["anticrab"] = 1; end
            if not ExtraConfiguration["blueshaman"] then ExtraConfiguration["blueshaman"] = 0; end
            if not ExtraConfiguration["maxcamera"] then ExtraConfiguration["maxcamera"] = 1; end
            if not ExtraConfiguration["antiafk"] then ExtraConfiguration["antiafk"] = 0; end
            if not ExtraConfiguration["antilogout"] then ExtraConfiguration["antilogout"] = 0; end
            if not ExtraConfiguration["details"] then ExtraConfiguration["details"] = 1; end
            Switch_OptionPanel_OnShow();
            switch:UnregisterEvent("ADDON_LOADED");
        end
    elseif event == "VARIABLES_LOADED" then
        --自动取消敏感词过滤
        if GetCVar("portal") == "CN" then
            ConsoleExec("portal TW");
        end
        if GetCVar("profanityFilter") ~= 0 then
            SetCVar("profanityFilter", 0);
        end
        -- if GetCVar("overrideArchive") ~= 0 then
        --     SetCVar("overrideArchive", 0);
        -- end
        AntiCrab();
        BlueShaman();
        AntiAFKLogout();
        if Details and ExtraConfiguration["details"] == 1 then
            Details.disable_talent_feature = true;
        end
        switch:UnregisterEvent("VARIABLES_LOADED");
    elseif event == "PLAYER_LOGIN" then
        MaxCameraDistance();
        switch:UnregisterEvent("PLAYER_LOGIN");
    end
end)

--option panel
local SWITCH_ANTICRAB, SWITCH_BLUESHAMAN;
if GetLocale() == "zhCN" then
    SWITCH_INFO            = "杂项设置";
    SWITCH_ANTICRAB        = "原汁原味（重启游戏后生效）";
    SWITCH_BLUESHAMAN      = "蓝色萨满（可能导致战斗中无法调整队伍）";
    SWITCH_MAXCAMERA       = "自动拉远镜头";
    SWITCH_ANTIAFK         = "自动脱离离开状态（最小化窗口、掉线无效&有被封号风险）";
    SWITCH_ANTILOGOUT      = "非休息区不自动登出（最小化窗口、掉线无效&有被封号风险&触发时会提示插件出错）";
elseif GetLocale() == "zhTW" then
    SWITCH_INFO            = "雜項設置";
    SWITCH_ANTICRAB        = "原汁原味（重啟遊戲後生效）";
    SWITCH_BLUESHAMAN      = "藍色薩滿（可能導致戰鬥中無法調整隊伍）";
    SWITCH_MAXCAMERA       = "自動拉遠鏡頭";
    SWITCH_ANTIAFK         = "自動脫離離開狀態（最小化窗口、掉線無效&有被封號風險）";
    SWITCH_ANTILOGOUT      = "非休息區不自動登出（最小化窗口、掉線無效&有被封號風險&觸發時會提示插件出錯）";
else
    SWITCH_INFO            = "options";
    SWITCH_ANTICRAB        = "original taste (Effective after game restarted)";
    SWITCH_BLUESHAMAN      = "blue shaman (may cause taint in party/raid during combat)";
    SWITCH_MAXCAMERA       = "auto maximize camera distance";
    SWITCH_ANTIAFK         = "automatically cancel afk (dangerous!!!)";
    SWITCH_ANTILOGOUT      = "donot automatically logout (dangerous!!!)";
end

Switch_OptionsFrame = CreateFrame("Frame", "Switch_OptionsFrame", UIParent);
Switch_OptionsFrame.name = "!!!"..SWITCH_INFO.."!!!";
InterfaceOptions_AddCategory(Switch_OptionsFrame);
Switch_OptionsFrame:SetScript("OnShow", function()
    Switch_OptionPanel_OnShow();
end)

do
    local SwitchTitle = Switch_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    SwitchTitle:ClearAllPoints();
    SwitchTitle:SetPoint("TOPLEFT", 16, -16);
    SwitchTitle:SetText(SWITCH_INFO);

    local Switch_AnticrabEnable = CreateFrame("CheckButton", "Switch_AnticrabEnable", Switch_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    Switch_AnticrabEnable:ClearAllPoints();
    Switch_AnticrabEnable:SetPoint("TOPLEFT", SwitchTitle, "TOPLEFT", 0, -30);
    Switch_AnticrabEnable:SetHitRectInsets(0, -100, 0, 0);
    Switch_AnticrabEnableText:SetText(SWITCH_ANTICRAB);
    Switch_AnticrabEnable:SetScript("OnClick", function(self)
        ExtraConfiguration["anticrab"] = 1 - ExtraConfiguration["anticrab"];
        AntiCrab();
        self:SetChecked(ExtraConfiguration["anticrab"]==1);
    end)

    local Switch_BlueshamanEnable = CreateFrame("CheckButton", "Switch_BlueshamanEnable", Switch_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    Switch_BlueshamanEnable:ClearAllPoints();
    Switch_BlueshamanEnable:SetPoint("TOPLEFT", Switch_AnticrabEnable, "TOPLEFT", 0, -30);
    Switch_BlueshamanEnable:SetHitRectInsets(0, -100, 0, 0);
    Switch_BlueshamanEnableText:SetText(SWITCH_BLUESHAMAN);
    Switch_BlueshamanEnable:SetScript("OnClick", function(self)
        ExtraConfiguration["blueshaman"] = 1 - ExtraConfiguration["blueshaman"];
        BlueShaman();
        self:SetChecked(ExtraConfiguration["blueshaman"]==1);
    end)

    local Switch_MaxCmareaEnable = CreateFrame("CheckButton", "Switch_MaxCmareaEnable", Switch_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    Switch_MaxCmareaEnable:ClearAllPoints();
    Switch_MaxCmareaEnable:SetPoint("TOPLEFT", Switch_BlueshamanEnable, "TOPLEFT", 0, -30);
    Switch_MaxCmareaEnable:SetHitRectInsets(0, -100, 0, 0);
    Switch_MaxCmareaEnableText:SetText(SWITCH_MAXCAMERA);
    Switch_MaxCmareaEnable:SetScript("OnClick", function(self)
        ExtraConfiguration["maxcamera"] = 1 - ExtraConfiguration["maxcamera"];
        MaxCameraDistance();
        self:SetChecked(ExtraConfiguration["maxcamera"]==1);
    end)

    local Switch_AntiAFKEnable = CreateFrame("CheckButton", "Switch_AntiAFKEnable", Switch_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    Switch_AntiAFKEnable:ClearAllPoints();
    Switch_AntiAFKEnable:SetPoint("TOPLEFT", Switch_MaxCmareaEnable, "TOPLEFT", 0, -30);
    Switch_AntiAFKEnable:SetHitRectInsets(0, -100, 0, 0);
    Switch_AntiAFKEnableText:SetText(SWITCH_ANTIAFK);
    Switch_AntiAFKEnable:SetScript("OnClick", function(self)
        ExtraConfiguration["antiafk"] = 1 - ExtraConfiguration["antiafk"];
        AntiAFKLogout();
        self:SetChecked(ExtraConfiguration["antiafk"]==1);
    end)

    local Switch_AntiLogoutEnable = CreateFrame("CheckButton", "Switch_AntiLogoutEnable", Switch_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    Switch_AntiLogoutEnable:ClearAllPoints();
    Switch_AntiLogoutEnable:SetPoint("TOPLEFT", Switch_AntiAFKEnable, "TOPLEFT", 0, -30);
    Switch_AntiLogoutEnable:SetHitRectInsets(0, -100, 0, 0);
    Switch_AntiLogoutEnableText:SetText(SWITCH_ANTILOGOUT);
    Switch_AntiLogoutEnable:SetScript("OnClick", function(self)
        ExtraConfiguration["antilogout"] = 1 - ExtraConfiguration["antilogout"];
        AntiAFKLogout();
        self:SetChecked(ExtraConfiguration["antilogout"]==1);
    end)
end

function Switch_OptionPanel_OnShow()
    Switch_AnticrabEnable:SetChecked(ExtraConfiguration["anticrab"]==1);
    Switch_BlueshamanEnable:SetChecked(ExtraConfiguration["blueshaman"]==1);
    Switch_MaxCmareaEnable:SetChecked(ExtraConfiguration["maxcamera"]==1);
    Switch_AntiAFKEnable:SetChecked(ExtraConfiguration["antiafk"]==1);
    Switch_AntiLogoutEnable:SetChecked(ExtraConfiguration["antilogout"]==1);
end

--buff精确时间&来源
hooksecurefunc(GameTooltip, "SetUnitAura", function(self, unit, index, filter)
    local _, _, _, _, _, expirationTime, unitCaster = UnitAura(unit, index, filter);

    if expirationTime and expirationTime ~= 0 then
        local time = expirationTime - GetTime();
        if time > 60 then
            local d, h, m, s = ChatFrame_TimeBreakDown(time+1);
            local dtext = d ~= 0 and format(INT_SPELL_DURATION_DAYS, d) or "";
            local htext = h ~= 0 and format(INT_SPELL_DURATION_HOURS, h) or "";
            local mtext = m ~= 0 and format(INT_SPELL_DURATION_MIN, m) or "";
            local stext = format(INT_SPELL_DURATION_SEC, s);
            GameTooltip:AddLine(TIME_REMAINING..dtext..htext..mtext..stext);
            GameTooltip:Show();
        end
    end

    if unitCaster and UnitExists(unitCaster) then
        GameTooltip:AddLine(FROM..UnitName(unitCaster), 0.65, 0.85, 1, 1);
        GameTooltip:Show();
    end
end)

--插件列表鼠标滚动
InterfaceOptionsFrameAddOns:SetScript("OnMouseWheel", function(self, delta)
    if InterfaceOptionsFrameAddOnsListScrollBar:IsShown() then
        local offset = math.ceil(InterfaceOptionsFrameAddOnsListScrollBar:GetValue() - delta*ADDON_BUTTON_HEIGHT*5 - 0.5);
        if offset < 1 then offset = 1 end
        AddonListScrollFrame_OnVerticalScroll(InterfaceOptionsFrameAddOnsList, offset);
    end
end)

-- --新职业颜色
-- if GetLocale() == "zhCN" then
--     LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"] = "死亡骑士"
--     LOCALIZED_CLASS_NAMES_MALE["DEMONHUNTER"] = "恶魔猎手"
--     LOCALIZED_CLASS_NAMES_MALE["MONK"] = "武僧"
--     LOCALIZED_CLASS_NAMES_FEMALE["DEATHKNIGHT"] = "死亡骑士"
--     LOCALIZED_CLASS_NAMES_FEMALE["DEMONHUNTER"] = "恶魔猎手"
--     LOCALIZED_CLASS_NAMES_FEMALE["MONK"] = "武僧"
-- elseif GetLocale() == "zhTW" then
--     LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"] = "死亡騎士"
--     LOCALIZED_CLASS_NAMES_MALE["DEMONHUNTER"] = "惡魔獵人"
--     LOCALIZED_CLASS_NAMES_MALE["MONK"] = "武僧"
--     LOCALIZED_CLASS_NAMES_FEMALE["DEATHKNIGHT"] = "死亡騎士"
--     LOCALIZED_CLASS_NAMES_FEMALE["DEMONHUNTER"] = "惡魔獵人"
--     LOCALIZED_CLASS_NAMES_FEMALE["MONK"] = "武僧"
-- else
--     LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"] = "Death Knight"
--     LOCALIZED_CLASS_NAMES_MALE["DEMONHUNTER"] = "Demon Hunter"
--     LOCALIZED_CLASS_NAMES_MALE["MONK"] = "Monk"
--     LOCALIZED_CLASS_NAMES_FEMALE["DEATHKNIGHT"] = "Death Knight"
--     LOCALIZED_CLASS_NAMES_FEMALE["DEMONHUNTER"] = "Demon Hunter"
--     LOCALIZED_CLASS_NAMES_FEMALE["MONK"] = "Monk"
-- end

-- RAID_CLASS_COLORS["DEATHKNIGHT"] = CreateColor(0.77, 0.12, 0.23, 1);
-- RAID_CLASS_COLORS["DEATHKNIGHT"].colorStr = RAID_CLASS_COLORS["DEATHKNIGHT"]:GenerateHexColor()
-- RAID_CLASS_COLORS["DEMONHUNTER"] = CreateColor(0.64, 0.19, 0.79, 1);
-- RAID_CLASS_COLORS["DEMONHUNTER"].colorStr = RAID_CLASS_COLORS["DEMONHUNTER"]:GenerateHexColor()
-- RAID_CLASS_COLORS["MONK"] = CreateColor(0, 1, 0.59, 1);
-- RAID_CLASS_COLORS["MONK"].colorStr = RAID_CLASS_COLORS["MONK"]:GenerateHexColor()

do
    local function get_panel_name(panel)
        local tp = type(panel)
        local cat = INTERFACEOPTIONS_ADDONCATEGORIES
        if tp == "string" then
            for i = 1, #cat do
                local p = cat[i]
                if p.name == panel then
                    if p.parent then
                        return get_panel_name(p.parent)
                    else
                        return panel
                    end
                end
            end
        elseif tp == "table" then
            for i = 1, #cat do
                local p = cat[i]
                if p == panel then
                    if p.parent then
                        return get_panel_name(p.parent)
                    else
                        return panel.name
                    end
                end
            end
        end
    end

    local function InterfaceOptionsFrame_OpenToCategory_Fix(panel)
        if doNotRun or InCombatLockdown() then return end
        local panelName = get_panel_name(panel)
        if not panelName then return end -- if its not part of our list return early
        local noncollapsedHeaders = {}
        local shownpanels = 0
        local mypanel
        local t = {}
        local cat = INTERFACEOPTIONS_ADDONCATEGORIES
        for i = 1, #cat do
            local panel = cat[i]
            if not panel.parent or noncollapsedHeaders[panel.parent] then
                if panel.name == panelName then
                    panel.collapsed = true
                    t.element = panel
                    InterfaceOptionsListButton_ToggleSubCategories(t)
                    noncollapsedHeaders[panel.name] = true
                    mypanel = shownpanels + 1
                end
                if not panel.collapsed then
                    noncollapsedHeaders[panel.name] = true
                end
                shownpanels = shownpanels + 1
            end
        end
        local Smin, Smax = InterfaceOptionsFrameAddOnsListScrollBar:GetMinMaxValues()
        if shownpanels > 15 and Smin < Smax then
            local val = (Smax/(shownpanels-15))*(mypanel-2)
            InterfaceOptionsFrameAddOnsListScrollBar:SetValue(val)
        end
        doNotRun = true
        InterfaceOptionsFrame_OpenToCategory(panel)
        doNotRun = false
    end

    hooksecurefunc("InterfaceOptionsFrame_OpenToCategory", InterfaceOptionsFrame_OpenToCategory_Fix)

    local orig = AddonTooltip_Update
    _G.AddonTooltip_Update = function(owner, ...) 
        if AddonList and AddonList:IsMouseOver() then
            local id = owner and owner.GetID and owner:GetID()
            if id and id > 0 and id <= GetNumAddOns() then
                orig(owner, ...) 
                return
            end
        end
        --print("ADDON LIST FIX ACTIVATED") 
    end

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(self, event, name)
        if name == "Blizzard_Collections" then
            for i = 1, 3 do
                local button = _G["PetJournalLoadoutPet"..i]
                if button and button.dragButton then
                    button.dragButton:RegisterForClicks("LeftButtonUp")
                end
            end
            self:UnregisterAllEvents()
        end
    end)
end

-- InspectFrame TalentButton for alaTalentEmu
local function CreateInspectTalentButton()
    if (not InspectTalentButton) then
        InspectTalentButton = CreateFrame("Button", "InspectTalentButton", InspectFrame, "OptionsButtonTemplate");
        InspectTalentButton:ClearAllPoints();
        InspectTalentButton:SetPoint("TOPRIGHT", InspectFrame, "TOPRIGHT", -42, -42);
        InspectTalentButton:SetWidth(55);
        InspectTalentButton:SetHeight(25);
        InspectTalentButton:SetText(TALENT);
        InspectTalentButton:SetScript("OnClick", function()
            local name, realm = UnitName("target");
            if name and name ~= "" then
                if not realm or realm == "" then realm = GetRealmName() end
                __ala_meta__.emu.Emu_Query(name, realm);
            end
        end)
    end
end

local tb = CreateFrame("Frame");
tb:RegisterEvent("ADDON_LOADED")
tb:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addon = ...;
        if addon == "Blizzard_InspectUI" then
            if IsAddOnLoaded("alaTalentEmu") then
                CreateInspectTalentButton();
            end
            tb:UnregisterEvent("ADDON_LOADED");
        end
    end
end)

-- fix raidframe
local fr = CreateFrame("Frame");
function Fix_RaidFrame_OnClick()
    if InCombatLockdown() then
        fr:RegisterEvent("PLAYER_REGEN_ENABLED");
        return;
    end

    if RaidFrame and type(RaidFrame) == "table" and type(RaidFrame.SetScript) == "function" then
        local id;
        for id = 1, 40 do
            local button = _G["RaidGroupButton"..id];
            if type(button) == "table" and button.unit then
                button:SetAttribute("type", "target");
                button:SetAttribute("unit", button.unit);
            end
        end
    end
end
fr:RegisterEvent("ADDON_LOADED")
fr:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addon = ...;
        if addon == "Blizzard_RaidUI" then
            Fix_RaidFrame_OnClick();
            fr:UnregisterEvent("ADDON_LOADED");
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        Fix_RaidFrame_OnClick();
        fr:UnregisterEvent("PLAYER_REGEN_ENABLED");
    end
end)
