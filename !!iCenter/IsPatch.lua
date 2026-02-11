

-- 初始化 ExtraConfiguration
ExtraConfiguration = ExtraConfiguration or {}

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
        if C_CVar.GetCVar("overrideArchive") ~= "0" then  -- 使用C_CVar获取CVar
            C_CVar.SetCVar("overrideArchive", "0");
        end
    else
        if C_CVar.GetCVar("overrideArchive") ~= "1" then  -- 使用C_CVar获取CVar
            C_CVar.SetCVar("overrideArchive", "1");
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

local switch = CreateFrame('Frame');
switch:RegisterEvent("ADDON_LOADED");
switch:RegisterEvent("PLAYER_ENTERING_WORLD");     -- 应改用 PLAYER_ENTERING_WORLD
switch:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...;
        if name == "!!iCenter" then
            if not ExtraConfiguration then ExtraConfiguration = {}; end
            if not ExtraConfiguration["anticrab"] then ExtraConfiguration["anticrab"] = 1; end
            if not ExtraConfiguration["blueshaman"] then ExtraConfiguration["blueshaman"] = 1; end
            if not ExtraConfiguration["maxcamera"] then ExtraConfiguration["maxcamera"] = 1; end
            if not ExtraConfiguration["antiafk"] then ExtraConfiguration["antiafk"] = 0; end
            if not ExtraConfiguration["antilogout"] then ExtraConfiguration["antilogout"] = 0; end
            if not ExtraConfiguration["details"] then ExtraConfiguration["details"] = 1; end
            Switch_OptionPanel_OnShow();
            switch:UnregisterEvent("ADDON_LOADED");
        end
    elseif event == "PLAYER_ENTERING_WORLD" then  -- 修改事件名称
        MaxCameraDistance();
        switch:UnregisterEvent("PLAYER_ENTERING_WORLD");
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
    SWITCH_INFO            = "杂项设置";
    SWITCH_ANTICRAB        = "原汁原味（重启游戏后生效）";
    SWITCH_BLUESHAMAN      = "蓝色萨满（可能导致战斗中无法调整队伍）";
    SWITCH_MAXCAMERA       = "自动拉远镜头";
    SWITCH_ANTIAFK         = "自动脱离离开状态（最小化窗口、掉线无效&有被封号风险）";
    SWITCH_ANTILOGOUT      = "非休息区不自动登出（最小化窗口、掉线无效&有被封号风险&触发时会提示插件出错）";
else
    SWITCH_INFO            = "options";
    SWITCH_ANTICRAB        = "original taste (Effective after game restarted)";
    SWITCH_BLUESHAMAN      = "blue shaman (may cause taint in party/raid during combat)";
    SWITCH_MAXCAMERA       = "auto maximize camera distance";
    SWITCH_ANTIAFK         = "automatically cancel afk (dangerous!!!)";
    SWITCH_ANTILOGOUT      = "donot automatically logout (dangerous!!!)";
end

Switch_OptionsFrame = CreateFrame("Frame", "Switch_OptionsFrame", UIParent);
Switch_OptionsFrame.name = "iCenter Settings";  -- 简化名称避免特殊符号
Switch_OptionsFrame.okay = function() end
Switch_OptionsFrame.cancel = function() end

-- 更新设置面板注册方式
if Settings and Settings.RegisterCanvasLayoutCategory then
    -- 创建主分类
    local category = Settings.RegisterCanvasLayoutCategory(Switch_OptionsFrame, "iCenter")
    category.ID = "iCenterMainCategory"
    
    -- 创建子分类
    local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, Switch_OptionsFrame, SWITCH_INFO)
    subcategory.ID = "iCenterGeneralSettings"
    
    -- 注册到设置面板
    Settings.RegisterAddOnCategory(category)
else
    -- 旧版兼容模式
    InterfaceOptions_AddCategory(Switch_OptionsFrame)
end
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

    -- 修改后
    local Switch_MaxCameraEnable = CreateFrame("CheckButton", "Switch_MaxCameraEnable", Switch_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    Switch_MaxCameraEnable:ClearAllPoints();
    Switch_MaxCameraEnable:SetPoint("TOPLEFT", Switch_BlueshamanEnable, "TOPLEFT", 0, -30);
    Switch_MaxCameraEnable:SetHitRectInsets(0, -100, 0, 0);
    Switch_MaxCameraEnableText:SetText(SWITCH_MAXCAMERA);  -- 修正变量名
    Switch_MaxCameraEnable:SetScript("OnClick", function(self)  -- 修正变量名
        ExtraConfiguration["maxcamera"] = 1 - ExtraConfiguration["maxcamera"];
        MaxCameraDistance();
        self:SetChecked(ExtraConfiguration["maxcamera"]==1);
    end)

    local Switch_AntiAFKEnable = CreateFrame("CheckButton", "Switch_AntiAFKEnable", Switch_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    Switch_AntiAFKEnable:ClearAllPoints();
    Switch_AntiAFKEnable:SetPoint("TOPLEFT", Switch_MaxCameraEnable, "TOPLEFT", 0, -30);
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
    Switch_MaxCameraEnable:SetChecked(ExtraConfiguration["maxcamera"]==1);  -- 修正变量名
    Switch_AntiAFKEnable:SetChecked(ExtraConfiguration["antiafk"]==1);
    Switch_AntiLogoutEnable:SetChecked(ExtraConfiguration["antilogout"]==1);
end

-- 实现MaxCameraDistance函数，使用怀旧服兼容的方式设置最大镜头距离
function MaxCameraDistance()
    if ExtraConfiguration["maxcamera"] == 1 then
        SetCVar("cameraDistanceMax", 50) -- 怀旧服最大镜头距离
        SetCVar("cameraDistanceMaxFactor", 2.6)
    end
end

-- buff精确时间&来源
hooksecurefunc(GameTooltip, "SetUnitAura", function(self, unit, index, filter)
    local name, _, _, _, duration, expirationTime, unitCaster = UnitAura(unit, index, filter)
    if not name then return end

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
