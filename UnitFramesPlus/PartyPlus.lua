--变量
local id = 1;
local _G = _G;
local select = select;
local tonumber = tonumber;
local floor = math.floor;
local UnitExists = UnitExists;
local UnitName = UnitName;
local UnitLevel = UnitLevel;
local UnitClass = UnitClass;
local UnitHealth = UnitHealth;
local UnitHealthMax = UnitHealthMax;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local UnitIsDead = UnitIsDead;
local UnitIsGhost = UnitIsGhost;
local UnitIsConnected = UnitIsConnected;
local UnitIsVisible = UnitIsVisible;
local UnitInParty = UnitInParty;
local UnitInOtherParty = UnitInOtherParty;
local UnitAffectingCombat = UnitAffectingCombat;
local UnitBuff = UnitBuff;
local UnitDebuff = UnitDebuff;
local CooldownFrame_Set = CooldownFrame_Set;
local CooldownFrame_Clear = CooldownFrame_Clear;
local GetDisplayedAllyFrames = GetDisplayedAllyFrames;
local GetTime = GetTime;
local GetCVar = GetCVar;
local SetCVar = SetCVar;
local IsAddOnLoaded = IsAddOnLoaded;
local IsShiftKeyDown = IsShiftKeyDown;
local InCombatLockdown = InCombatLockdown;
local RegisterUnitWatch = RegisterUnitWatch;
local hooksecurefunc = hooksecurefunc;
local CombatFeedback_Initialize = CombatFeedback_Initialize;
local CombatFeedback_OnCombatEvent = CombatFeedback_OnCombatEvent;
local UnitFrame_UpdateTooltip = UnitFrame_UpdateTooltip;
local RaidOptionsFrame_UpdatePartyFrames = RaidOptionsFrame_UpdatePartyFrames;
local HidePartyFrame = HidePartyFrame;
local ShowPartyFrame = ShowPartyFrame;
local UnitFrame_Update = UnitFrame_Update;
local RefreshDebuffs = RefreshDebuffs;
local SetDesaturation = SetDesaturation;
local UpdatePartyMemberBackground = UpdatePartyMemberBackground;
local PartyMemberFrame_RefreshPetDebuffs = PartyMemberFrame_RefreshPetDebuffs;
local PartyMemberFrame_UpdateLeader = PartyMemberFrame_UpdateLeader;
local PartyMemberFrame_UpdatePvPStatus = PartyMemberFrame_UpdatePvPStatus;
local PartyMemberFrame_UpdateVoiceStatus = PartyMemberFrame_UpdateVoiceStatus;
local PartyMemberFrame_UpdateReadyCheck = PartyMemberFrame_UpdateReadyCheck;
local PartyMemberFrame_UpdateNotPresentIcon = PartyMemberFrame_UpdateNotPresentIcon;
local PartyMemberFrame_ToPlayerArt = PartyMemberFrame_ToPlayerArt;
local CompactRaidFrameManager_UpdateShown = CompactRaidFrameManager_UpdateShown;
local CompactRaidFrameManager_UpdateContainerLockVisibility = CompactRaidFrameManager_UpdateContainerLockVisibility;
local BlizzardOptionsPanel_CheckButton_Enable = BlizzardOptionsPanel_CheckButton_Enable;
local BlizzardOptionsPanel_CheckButton_Disable = BlizzardOptionsPanel_CheckButton_Disable;
local StaticPopup_Show = StaticPopup_Show;

--状态数值
for id = 1, MAX_PARTY_MEMBERS, 1 do
    local PartyHPMPText = CreateFrame("Frame", "UFP_PartyHPMPText"..id, _G["PartyMemberFrame"..id]);
    PartyHPMPText:SetFrameLevel(5);

    PartyHPMPText.HealthBarText = PartyHPMPText:CreateFontString("PartyMemberFrame"..id.."HealthBarText", "OVERLAY", "TextStatusBarText");
    PartyHPMPText.HealthBarText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
    PartyHPMPText.HealthBarText:SetTextColor(1, 1, 1);
    PartyHPMPText.HealthBarText:SetAlpha(1);
    PartyHPMPText.HealthBarText:ClearAllPoints();
    PartyHPMPText.HealthBarText:SetPoint("CENTER", _G["PartyMemberFrame"..id.."HealthBar"], "CENTER");
    PartyHPMPText.HealthBarText:SetJustifyH("CENTER");

    PartyHPMPText.ManaBarText = PartyHPMPText:CreateFontString("PartyMemberFrame"..id.."ManaBarText", "OVERLAY", "TextStatusBarText");
    PartyHPMPText.ManaBarText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
    PartyHPMPText.ManaBarText:SetTextColor(1, 1, 1);
    PartyHPMPText.ManaBarText:SetAlpha(1);
    PartyHPMPText.ManaBarText:ClearAllPoints();
    PartyHPMPText.ManaBarText:SetPoint("CENTER", _G["PartyMemberFrame"..id.."ManaBar"], "CENTER");
    PartyHPMPText.ManaBarText:SetJustifyH("CENTER");
end

--关闭团队风格小队界面
function UnitFramesPlus_PartyOriginSet()
    if UnitFramesPlusDB["party"]["origin"] == 1 then
        if tonumber(GetCVar("useCompactPartyFrames")) == 1 then
            SetCVar("useCompactPartyFrames", "0");
            local state = IsAddOnLoaded("Blizzard_CompactRaidFrames");
            if state == true then
                _G["CompactUnitFrameProfiles"].optionsFrame.autoActivate2Players:Disable();
                _G["CompactUnitFrameProfiles"].optionsFrame.autoActivate3Players:Disable();
                _G["CompactUnitFrameProfiles"].optionsFrame.autoActivate5Players:Disable();
                CompactUnitFrameProfilesRaidStylePartyFrames:SetChecked(false);
            end
        end
    else
        if tonumber(GetCVar("useCompactPartyFrames")) ~= 1 then
            SetCVar("useCompactPartyFrames", "1");
            local state = IsAddOnLoaded("Blizzard_CompactRaidFrames");
            if state == true then
                _G["CompactUnitFrameProfiles"].optionsFrame.autoActivate2Players:Disable();
                _G["CompactUnitFrameProfiles"].optionsFrame.autoActivate3Players:Disable();
                _G["CompactUnitFrameProfiles"].optionsFrame.autoActivate5Players:Disable();
                CompactUnitFrameProfilesRaidStylePartyFrames:SetChecked(false);
            end
        end
    end
end

function UnitFramesPlus_PartyOrigin()
    if not InCombatLockdown() then
        UnitFramesPlus_PartyOriginSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PartyOriginSet";
        func.callback = function()
            UnitFramesPlus_PartyOriginSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--非战斗状态中允许shift+左键拖动队友头像
local function UnitFramesPlus_PartyShiftDrag()
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        _G["PartyMemberFrame"..id]:SetScript("OnMouseDown", function(self, elapsed)
            if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["movable"] == 1 then
                if IsShiftKeyDown() and (not InCombatLockdown()) then
                    PartyMemberFrame1:StartMoving();
                    UnitFramesPlusVar["party"]["moving"] = 1;
                end
            end
        end)

        _G["PartyMemberFrame"..id]:SetScript("OnMouseUp", function(self, elapsed)
            if UnitFramesPlusVar["party"]["moving"] == 1 then
                PartyMemberFrame1:StopMovingOrSizing();
                UnitFramesPlusVar["party"]["moving"] = 0;
                UnitFramesPlusVar["party"]["moved"] = 1;
                local left = PartyMemberFrame1:GetLeft();
                local bottom = PartyMemberFrame1:GetBottom();
                UnitFramesPlusVar["party"]["x"] = left;
                UnitFramesPlusVar["party"]["y"] = bottom;
            end
        end)
    end

    PartyMemberFrame1:SetMovable(1);
    PartyMemberFrame1:SetClampedToScreen(1);
end

--队友等级
for id = 1, MAX_PARTY_MEMBERS, 1 do
    local PartyLevel = CreateFrame("Frame", "UFP_PartyLevel"..id, _G["PartyMemberFrame"..id]);
    PartyLevel:SetAttribute("unit", "party"..id);
    RegisterUnitWatch(PartyLevel);
    PartyLevel.Text = _G["UFP_PartyLevel"..id]:CreateFontString("PartyMemberFrame"..id.."Level", "OVERLAY", "GameTooltipText");
    PartyLevel.Text:ClearAllPoints();
    PartyLevel.Text:SetPoint("TOPLEFT", _G["PartyMemberFrame"..id], "BOTTOMLEFT", -5, 12);
    PartyLevel.Text:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
    PartyLevel.Text:SetTextColor(1, 0.82, 0);
    PartyLevel.Text:SetJustifyH("CENTER");
end

function UnitFramesPlus_PartyLevel()
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["level"] == 1 then
            _G["UFP_PartyLevel"..id]:RegisterEvent("PLAYER_ENTERING_WORLD");
            _G["UFP_PartyLevel"..id]:RegisterEvent("GROUP_ROSTER_UPDATE");
            _G["UFP_PartyLevel"..id]:RegisterEvent("PARTY_LEADER_CHANGED");
            _G["UFP_PartyLevel"..id]:RegisterEvent("PARTY_MEMBER_ENABLE");
            _G["UFP_PartyLevel"..id]:RegisterEvent("PARTY_MEMBER_DISABLE");
            -- _G["UFP_PartyLevel"..id]:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "party"..id);
            -- _G["UFP_PartyLevel"..id]:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "party"..id);
            _G["UFP_PartyLevel"..id]:RegisterUnitEvent("UNIT_CONNECTION", "party"..id);
            _G["UFP_PartyLevel"..id]:RegisterUnitEvent("UNIT_PHASE", "party"..id);
            _G["UFP_PartyLevel"..id]:RegisterUnitEvent("UNIT_PET", "party"..id);
            _G["UFP_PartyLevel"..id]:RegisterUnitEvent("UNIT_LEVEL", "party"..id);
            _G["UFP_PartyLevel"..id]:SetScript("OnEvent", function(self, event, ...)
                -- if tonumber(GetCVar("useCompactPartyFrames")) ~= 1 then
                    UnitFramesPlus_PartyLevelDisplayUpdate(id);
                -- end
            end)
        else
            _G["UFP_PartyLevel"..id].Text:SetText("");
            if _G["UFP_PartyLevel"..id]:IsEventRegistered("PLAYER_ENTERING_WORLD") then
                _G["UFP_PartyLevel"..id]:UnregisterAllEvents();
                _G["UFP_PartyLevel"..id]:SetScript("OnEvent", nil);
            end
        end
    end
end

--设置插件时刷新队友等级显示
function UnitFramesPlus_PartyLevelDisplayUpdate(id)
    local LevelText = "";
    if UnitExists("party"..id) and UnitFramesPlusDB["party"]["origin"] == 1 then
        if UnitFramesPlusDB["party"]["level"] == 1 then
            if UnitLevel(_G["PartyMemberFrame"..id].unit) and UnitLevel(_G["PartyMemberFrame"..id].unit) >= 1 then
                LevelText = UnitLevel(_G["PartyMemberFrame"..id].unit);
            end
        end
    end
    _G["UFP_PartyLevel"..id].Text:SetText(LevelText);
end

-- --队友生命条染色
-- function UnitFramesPlus_PartyColorHPBar()
--     for id = 1, MAX_PARTY_MEMBERS, 1 do
--         if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["colorhp"] == 1 then
--             if UnitFramesPlusDB["party"]["colortype"] == 1 then
--                 _G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnValueChanged", nil);
--                 _G["PartyMemberFrame"..id.."HealthBar"]:RegisterEvent("PLAYER_ENTERING_WORLD");
--                 _G["PartyMemberFrame"..id.."HealthBar"]:RegisterEvent("GROUP_ROSTER_UPDATE");
--                 _G["PartyMemberFrame"..id.."HealthBar"]:RegisterEvent("PARTY_LEADER_CHANGED");
--                 _G["PartyMemberFrame"..id.."HealthBar"]:RegisterEvent("PARTY_MEMBER_ENABLE");
--                 _G["PartyMemberFrame"..id.."HealthBar"]:RegisterEvent("PARTY_MEMBER_DISABLE");
--                 -- _G["PartyMemberFrame"..id.."HealthBar"]:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "party"..id);
--                 -- _G["PartyMemberFrame"..id.."HealthBar"]:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "party"..id);
--                 _G["PartyMemberFrame"..id.."HealthBar"]:RegisterUnitEvent("UNIT_CONNECTION", "party"..id);
--                 _G["PartyMemberFrame"..id.."HealthBar"]:RegisterUnitEvent("UNIT_PHASE", "party"..id);
--                 _G["PartyMemberFrame"..id.."HealthBar"]:RegisterUnitEvent("UNIT_PET", "party"..id);
--                 _G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnEvent", function(self, event, ...)
--                     -- if tonumber(GetCVar("useCompactPartyFrames")) ~= 1 then
--                         UnitFramesPlus_PartyColorHPBarDisplayUpdate(id);
--                     -- end
--                 end)
--             elseif UnitFramesPlusDB["party"]["colortype"] == 2 then
--                 if _G["PartyMemberFrame"..id.."HealthBar"]:IsEventRegistered("PLAYER_ENTERING_WORLD") then
--                 _G["PartyMemberFrame"..id.."HealthBar"]:UnregisterAllEvents();
--                     _G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnEvent", nil);
--                 end
--                 _G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnValueChanged", function(self, value)
--                     -- if tonumber(GetCVar("useCompactPartyFrames")) ~= 1 then
--                         UnitFramesPlus_PartyColorHPBarDisplayUpdate(id);
--                     -- end
--                 end)
--             end
--             -- _G["PartyMemberFrame"..id.."HealthBar"].lockColor = true;
--         else
--             _G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnValueChanged", nil);
--             if _G["PartyMemberFrame"..id.."HealthBar"]:IsEventRegistered("PLAYER_ENTERING_WORLD") then
--                 _G["PartyMemberFrame"..id.."HealthBar"]:UnregisterAllEvents();
--                 _G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnEvent", nil);
--             end
--             _G["PartyMemberFrame"..id.."HealthBar"]:SetStatusBarColor(0, 1, 0);
--             -- _G["PartyMemberFrame"..id.."HealthBar"].lockColor = nil;
--         end
--     end
-- end

--设置插件时刷新队友生命条染色显示
function UnitFramesPlus_PartyColorHPBarDisplayUpdate(id)
    if UnitExists("party"..id) and UnitIsConnected("party"..id) and UnitFramesPlusDB["party"]["origin"] == 1 then
        if UnitFramesPlusDB["party"]["colorhp"] == 1 then
            if UnitFramesPlusDB["party"]["colortype"] == 2 then
                local CurHP = UnitHealth("party"..id);
                local MaxHP = UnitHealthMax("party"..id);
                local r, g, b = UnitFramesPlus_GetRGB(CurHP, MaxHP);
                _G["PartyMemberFrame"..id.."HealthBar"]:SetStatusBarColor(r, g, b);
            elseif UnitFramesPlusDB["party"]["colortype"] == 1 then
                local color = RAID_CLASS_COLORS[select(2, UnitClass("party"..id))] or {r=0, g=1, b=0};
                _G["PartyMemberFrame"..id.."HealthBar"]:SetStatusBarColor(color.r, color.g, color.b);
            end
        end
    end
end

--队友生命条染色
hooksecurefunc("UnitFrameHealthBar_Update", function(statusbar, unit)
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        if unit == "party"..id and statusbar.unit == "party"..id then
            UnitFramesPlus_PartyColorHPBarDisplayUpdate(id);
        end
    end
end);
hooksecurefunc("HealthBar_OnValueChanged", function(self, value, smooth)
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        if self.unit == "party"..id then
            UnitFramesPlus_PartyColorHPBarDisplayUpdate(id);
        end
    end
end);

--队友名字染色
for id = 1, MAX_PARTY_MEMBERS, 1 do
    local PartyColorName = CreateFrame("Frame", "UFP_PartyColorName"..id,  _G["PartyMemberFrame"..id]);
end

function UnitFramesPlus_PartyName()
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        if UnitFramesPlusDB["party"]["origin"] == 1 and (UnitFramesPlusDB["party"]["colorname"] == 1 
        -- or UnitFramesPlusDB["party"]["shortname"] == 1 
        or UnitFramesPlusDB["party"]["portrait"] == 1) then
            _G["UFP_PartyColorName"..id]:RegisterEvent("PLAYER_ENTERING_WORLD");
            _G["UFP_PartyColorName"..id]:RegisterEvent("GROUP_ROSTER_UPDATE");
            _G["UFP_PartyColorName"..id]:RegisterEvent("PARTY_LEADER_CHANGED");
            _G["UFP_PartyColorName"..id]:RegisterEvent("PARTY_MEMBER_ENABLE");
            _G["UFP_PartyColorName"..id]:RegisterEvent("PARTY_MEMBER_DISABLE");
            _G["UFP_PartyColorName"..id]:RegisterEvent("UPDATE_ACTIVE_BATTLEFIELD");
            _G["UFP_PartyColorName"..id]:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
            _G["UFP_PartyColorName"..id]:RegisterEvent("MUTELIST_UPDATE");
            _G["UFP_PartyColorName"..id]:RegisterEvent("IGNORELIST_UPDATE");
            _G["UFP_PartyColorName"..id]:RegisterEvent("VARIABLES_LOADED");
            _G["UFP_PartyColorName"..id]:RegisterEvent("READY_CHECK");
            _G["UFP_PartyColorName"..id]:RegisterEvent("READY_CHECK_CONFIRM");
            _G["UFP_PartyColorName"..id]:RegisterEvent("READY_CHECK_FINISHED");
            _G["UFP_PartyColorName"..id]:RegisterEvent("UNIT_OTHER_PARTY_CHANGED", "party"..id);
            _G["UFP_PartyColorName"..id]:RegisterEvent("UNIT_FLAGS", "party"..id);
            -- _G["UFP_PartyColorName"..id]:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "party"..id);
            -- _G["UFP_PartyColorName"..id]:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "party"..id);
            _G["UFP_PartyColorName"..id]:RegisterUnitEvent("UNIT_NAME_UPDATE", "party"..id);
            _G["UFP_PartyColorName"..id]:RegisterUnitEvent("UNIT_CONNECTION", "party"..id);
            _G["UFP_PartyColorName"..id]:RegisterUnitEvent("UNIT_PHASE", "party"..id);
            _G["UFP_PartyColorName"..id]:RegisterUnitEvent("UNIT_PET", "party"..id);
            _G["UFP_PartyColorName"..id]:SetScript("OnEvent", function(self, event, ...)
                -- if tonumber(GetCVar("useCompactPartyFrames")) ~= 1 then
                    UnitFramesPlus_PartyNameDisplayUpdate(id);
                -- end
            end)
        else
            _G["PartyMemberFrame"..id].name:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
            if _G["UFP_PartyColorName"..id]:IsEventRegistered("PLAYER_ENTERING_WORLD") then
                _G["UFP_PartyColorName"..id]:UnregisterAllEvents();
            end
            _G["UFP_PartyColorName"..id]:SetScript("OnEvent", nil);
        end
    end
end

--设置插件时刷新队友名字显示
function UnitFramesPlus_PartyNameDisplayUpdate(id)
    if UnitExists("party"..id) and UnitFramesPlusDB["party"]["origin"] == 1 then
        -- short name
        local name, realm = UnitName("party"..id);
        local fullname = name;
        if realm and realm ~= "" then
            if UnitFramesPlusDB["party"]["shortname"] == 1 then
                fullname = name.."(*)";
            else
                fullname = name.."-"..realm;
            end
        end
        _G["PartyMemberFrame"..id].name:SetText(fullname);

        -- color name
        local color = NORMAL_FONT_COLOR;
        if UnitFramesPlusDB["party"]["colorname"] == 1 then
            color = RAID_CLASS_COLORS[select(2, UnitClass("party"..id))] or NORMAL_FONT_COLOR;
        end
        _G["PartyMemberFrame"..id].name:SetTextColor(color.r, color.g, color.b);
    end
end

for id = 1, MAX_PARTY_MEMBERS, 1 do
    local Party3DPortrait = CreateFrame("PlayerModel", "UFP_Party3DPortrait"..id, _G["PartyMemberFrame"..id]);
    Party3DPortrait:SetWidth(29);
    Party3DPortrait:SetHeight(29);
    Party3DPortrait:SetFrameLevel(1);
    Party3DPortrait:ClearAllPoints();
    Party3DPortrait:SetPoint("TOPLEFT", _G["PartyMemberFrame"..id], "TOPLEFT", 11, -12);
    Party3DPortrait:Hide();
    Party3DPortrait.Background = Party3DPortrait:CreateTexture("UFP_Party3DPortraitBG"..id, "BACKGROUND");
    Party3DPortrait.Background:SetTexture("Interface\\AddOns\\UnitFramesPlus\\Portrait3D");
    Party3DPortrait.Background:SetWidth(37);
    Party3DPortrait.Background:SetHeight(37);
    Party3DPortrait.Background:ClearAllPoints();
    Party3DPortrait.Background:SetPoint("CENTER", Party3DPortrait, "CENTER", -1, 0);
    Party3DPortrait.Background:Hide();

    local PartyClassPortrait = _G["PartyMemberFrame"..id]:CreateTexture("UFP_PartyClassPortrait"..id, "ARTWORK");
    PartyClassPortrait:SetWidth(37);
    PartyClassPortrait:SetHeight(37);
    PartyClassPortrait:ClearAllPoints();
    PartyClassPortrait:SetPoint("TOPLEFT", _G["PartyMemberFrame"..id], "TOPLEFT", 7, -6);
    PartyClassPortrait:Hide();
end

for id = 1, MAX_PARTY_MEMBERS, 1 do
    local pp = CreateFrame("Frame", "UFP_PartyPortraitType"..id,  _G["PartyMemberFrame"..id]);
end
function UnitFramesPlus_PartyPortrait()
    if UnitFramesPlusDB["party"]["portrait"] == 1 and UnitFramesPlusDB["party"]["origin"] == 1 then
        for id = 1, MAX_PARTY_MEMBERS, 1 do
            _G["PartyMemberFrame"..id.."Portrait"]:Hide();
            if UnitFramesPlusDB["party"]["portraittype"] == 1 then
                _G["UFP_Party3DPortrait"..id]:Show();
                _G["UFP_PartyClassPortrait"..id]:Hide();
                UnitFramesPlus_PartyPortrait3DBGDisplayUpdate(id);
                _G["UFP_PartyPortraitType"..id]:RegisterEvent("PLAYER_ENTERING_WORLD");
                _G["UFP_PartyPortraitType"..id]:RegisterEvent("GROUP_ROSTER_UPDATE");
                _G["UFP_PartyPortraitType"..id]:RegisterEvent("PARTY_LEADER_CHANGED");
                _G["UFP_PartyPortraitType"..id]:RegisterEvent("PARTY_MEMBER_ENABLE");
                _G["UFP_PartyPortraitType"..id]:RegisterEvent("PARTY_MEMBER_DISABLE");
                -- _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "party"..id);
                -- _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "party"..id);
                _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_PHASE", "party"..id);
                _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_PET", "party"..id);
                _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_MODEL_CHANGED", "party"..id);
                _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_CONNECTION", "party"..id);
                _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "party"..id);
                _G["UFP_PartyPortraitType"..id]:SetScript("OnEvent", function(self, event, ...)
                    if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" 
                    or event == "PARTY_LEADER_CHANGED"  or event == "PARTY_MEMBER_ENABLE" 
                    -- or event == "PARTY_MEMBER_DISABLE"  or event == "UNIT_ENTERED_VEHICLE" 
                    or event == "PARTY_MEMBER_DISABLE" 
                    -- or event == "UNIT_EXITED_VEHICLE"  or event == "UNIT_PET" then
                    or event == "UNIT_PET" then
                        if UnitExists("party"..id) then
                            if UnitFramesPlusDB["party"]["portrait3dbg"] == 1 then
                                local color = RAID_CLASS_COLORS[select(2, UnitClass("party"..id))] or NORMAL_FONT_COLOR;
                                _G["UFP_Party3DPortrait"..id].Background:SetVertexColor(color.r/1.5, color.g/1.5, color.b/1.5, 1);
                            end
                            UnitFramesPlus_PartyPortraitDisplayUpdate(id);
                            UnitFramesPlus_PartyPortrait3DBGDisplayUpdate(id);
                        end
                    elseif event == "UNIT_MODEL_CHANGED" or event == "UNIT_CONNECTION" or event == "UNIT_PHASE" then
                        UnitFramesPlus_PartyPortraitDisplayUpdate(id);
                    elseif event == "UNIT_HEALTH_FREQUENT" then
                        if (not UnitIsConnected("party"..id)) or UnitIsGhost("party"..id) then
                            _G["UFP_Party3DPortrait"..id]:SetLight(true, false, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);
                        elseif UnitIsDead("party"..id) then
                            _G["UFP_Party3DPortrait"..id]:SetLight(true, false, 0, 0, 0, 1.0, 1, 0.3, 0.3);
                        else
                            _G["UFP_Party3DPortrait"..id]:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
                        end
                    end
                end)
            elseif UnitFramesPlusDB["party"]["portraittype"] == 2 then
                _G["UFP_Party3DPortrait"..id]:Hide();
                _G["UFP_PartyClassPortrait"..id]:Show();
                if not _G["UFP_PartyPortraitType"..id]:IsEventRegistered("PLAYER_ENTERING_WORLD") then
                    _G["UFP_PartyPortraitType"..id]:RegisterEvent("PLAYER_ENTERING_WORLD");
                    _G["UFP_PartyPortraitType"..id]:RegisterEvent("GROUP_ROSTER_UPDATE");
                    _G["UFP_PartyPortraitType"..id]:RegisterEvent("PARTY_LEADER_CHANGED");
                    _G["UFP_PartyPortraitType"..id]:RegisterEvent("PARTY_MEMBER_ENABLE");
                    _G["UFP_PartyPortraitType"..id]:RegisterEvent("PARTY_MEMBER_DISABLE");
                    -- _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "party"..id);
                    -- _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "party"..id);
                    _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_PHASE", "party"..id);
                    _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_PET", "party"..id);
                    _G["UFP_PartyPortraitType"..id]:RegisterUnitEvent("UNIT_CONNECTION", "party"..id);
                else
                    if _G["UFP_PartyPortraitType"..id]:IsEventRegistered("UNIT_MODEL_CHANGED") then
                        _G["UFP_PartyPortraitType"..id]:UnregisterEvent("UNIT_MODEL_CHANGED");
                        _G["UFP_PartyPortraitType"..id]:UnregisterEvent("UNIT_HEALTH_FREQUENT");
                    end
                end
                _G["UFP_PartyPortraitType"..id]:SetScript("OnEvent", function(self, event, ...)
                    if UnitExists("party"..id) then
                        UnitFramesPlus_PartyPortraitDisplayUpdate(id);
                    end
                end)
            end
            UnitFramesPlus_PartyPortraitDisplayUpdate(id);
        end
    else
        for id = 1, MAX_PARTY_MEMBERS, 1 do
            if UnitExists("party"..id) then
                _G["PartyMemberFrame"..id.."Portrait"]:Show();
            -- else
            --     if _G["PartyMemberFrame"..id.."Portrait"]:IsVisible() then
            --         _G["PartyMemberFrame"..id.."Portrait"]:Hide();
            --     end
            end
            _G["UFP_Party3DPortrait"..id]:Hide();
            _G["UFP_PartyClassPortrait"..id]:Hide();
            if _G["UFP_PartyPortraitType"..id]:IsEventRegistered("PLAYER_ENTERING_WORLD") then
                _G["UFP_PartyPortraitType"..id]:UnregisterAllEvents();
                _G["UFP_PartyPortraitType"..id]:SetScript("OnEvent", nil);
            end
        end
    end
end

--刷新队友3D头像背景显示
function UnitFramesPlus_PartyPortrait3DBGDisplayUpdate(id)
    if UnitExists("party"..id) and UnitFramesPlusDB["party"]["origin"] == 1 then
        if UnitFramesPlusDB["party"]["portrait"] == 1 
        and UnitFramesPlusDB["party"]["portraittype"] == 1
        and UnitFramesPlusDB["party"]["portrait3dbg"] == 1 then
            _G["UFP_Party3DPortrait"..id].Background:Show();
        else
            _G["UFP_Party3DPortrait"..id].Background:Hide();
        end
    end
end

--刷新队友头像显示
function UnitFramesPlus_PartyPortraitDisplayUpdate(id)
    if UnitExists("party"..id) and UnitFramesPlusDB["party"]["origin"] == 1 then
        if UnitFramesPlusDB["party"]["portraittype"] == 1 then
            if (not UnitIsConnected("party"..id)) or (not UnitIsVisible("party"..id)) then
                _G["UFP_Party3DPortrait"..id]:SetPortraitZoom(0);
                _G["UFP_Party3DPortrait"..id]:SetCamDistanceScale(0.25);
                _G["UFP_Party3DPortrait"..id]:SetPosition(0,0,0.5);
                _G["UFP_Party3DPortrait"..id]:ClearModel();
                _G["UFP_Party3DPortrait"..id]:SetModel("Interface\\Buttons\\TalkToMeQuestionMark.M2");
            else
                _G["UFP_Party3DPortrait"..id]:SetPortraitZoom(1);
                _G["UFP_Party3DPortrait"..id]:SetCamDistanceScale(1);
                _G["UFP_Party3DPortrait"..id]:SetPosition(0,0,0);
                _G["UFP_Party3DPortrait"..id]:ClearModel();
                _G["UFP_Party3DPortrait"..id]:SetUnit("party"..id);
                if (not UnitIsConnected("party"..id)) or UnitIsGhost("party"..id) then
                    _G["UFP_Party3DPortrait"..id]:SetLight(true, false, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);
                elseif UnitIsDead("party"..id) then
                    _G["UFP_Party3DPortrait"..id]:SetLight(true, false, 0, 0, 0, 1.0, 1, 0.3, 0.3);
                else
                    _G["UFP_Party3DPortrait"..id]:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
                end
            end
        elseif UnitFramesPlusDB["party"]["portraittype"] == 2 then
            local IconCoord = CLASS_ICON_TCOORDS[select(2, UnitClass("party"..id))];
            if IconCoord then
                _G["UFP_PartyClassPortrait"..id]:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
                _G["UFP_PartyClassPortrait"..id]:SetTexCoord(unpack(IconCoord));
            end
        end
    end
end


for id = 1, MAX_PARTY_MEMBERS, 1 do
    --队友生命值百分比
    local PartyHPPct = CreateFrame("Frame", "UFP_PartyHPPct"..id,  _G["PartyMemberFrame"..id]);
    PartyHPPct:SetAttribute("unit", "party"..id);
    RegisterUnitWatch(PartyHPPct);
    PartyHPPct.Text = PartyHPPct:CreateFontString("PartyMemberFrame"..id.."HPPct", "OVERLAY", "GameTooltipText");
    PartyHPPct.Text:ClearAllPoints();
    PartyHPPct.Text:SetPoint("LEFT", _G["PartyMemberFrame"..id.."HealthBar"], "RIGHT", 4, 0);
    PartyHPPct.Text:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
    PartyHPPct.Text:SetTextColor(1, 0.82, 0);
    PartyHPPct.Text:SetJustifyH("LEFT");

    -- --队友死亡、灵魂提示
    -- local PartyDeath = CreateFrame("Frame", "UFP_PartyDeath"..id,  _G["PartyMemberFrame"..id]);
    -- PartyDeath:SetAttribute("unit", "party"..id);
    -- RegisterUnitWatch(PartyDeath);
    -- PartyDeath:SetFrameLevel(7);
    -- PartyDeath.Text = PartyDeath:CreateFontString("PartyMemberFrame"..id.."DeathText", "OVERLAY", "GameTooltipText");
    -- PartyDeath.Text:ClearAllPoints();
    -- PartyDeath.Text:SetPoint("CENTER", _G["PartyMemberFrame"..id.."Portrait"], "CENTER", 0, 0);
    -- PartyDeath.Text:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE");
    -- PartyDeath.Text:SetTextColor(1, 1, 1);
    -- PartyDeath.Text:SetJustifyH("CENTER");
end

function UnitFramesPlus_PartyHealthPct()
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["hp"] == 1 then
            _G["UFP_PartyHPPct"..id]:RegisterEvent("PLAYER_ENTERING_WORLD");
            _G["UFP_PartyHPPct"..id]:RegisterEvent("GROUP_ROSTER_UPDATE");
            _G["UFP_PartyHPPct"..id]:RegisterEvent("PARTY_LEADER_CHANGED");
            _G["UFP_PartyHPPct"..id]:RegisterEvent("PARTY_MEMBER_ENABLE");
            _G["UFP_PartyHPPct"..id]:RegisterEvent("PARTY_MEMBER_DISABLE");
            -- _G["UFP_PartyHPPct"..id]:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "party"..id);
            -- _G["UFP_PartyHPPct"..id]:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "party"..id);
            _G["UFP_PartyHPPct"..id]:RegisterUnitEvent("UNIT_CONNECTION", "party"..id);
            _G["UFP_PartyHPPct"..id]:RegisterUnitEvent("UNIT_PHASE", "party"..id);
            _G["UFP_PartyHPPct"..id]:RegisterUnitEvent("UNIT_PET", "party"..id);
            _G["UFP_PartyHPPct"..id]:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "party"..id);
            _G["UFP_PartyHPPct"..id]:RegisterUnitEvent("UNIT_POWER_FREQUENT", "party"..id);
            _G["UFP_PartyHPPct"..id]:SetScript("OnEvent", function(self, event, ...)
                -- if tonumber(GetCVar("useCompactPartyFrames")) ~= 1 then
                    -- UnitFramesPlus_PartyHealthPctDisplayUpdate(id);
                -- end
                    if event == "UNIT_HEALTH_FREQUENT" then
                        UnitFramesPlus_PartyHealthPctDisplayUpdate(id);
                    elseif event == "UNIT_POWER_FREQUENT" then
                        UnitFramesPlus_PartyPowerDisplayUpdate(id);
                    else
                        UnitFramesPlus_PartyHealthPctDisplayUpdate(id);
                        UnitFramesPlus_PartyPowerDisplayUpdate(id);
                    end
            end)
        else
            _G["UFP_PartyHPPct"..id].Text:SetText("");
            if _G["UFP_PartyHPPct"..id]:IsEventRegistered("PLAYER_ENTERING_WORLD") then
                _G["UFP_PartyHPPct"..id]:UnregisterAllEvents();
                _G["UFP_PartyHPPct"..id]:SetScript("OnEvent", nil);
            end
        end
    end
end

--设置插件时刷新队友生命值百分比显示
function UnitFramesPlus_PartyHealthPctDisplayUpdate(id)
    local HPText = "";
    -- local MPText = "";
    local PctText = "";
    -- local DeathText = "";
    if UnitExists("party"..id) and UnitFramesPlusDB["party"]["origin"] == 1 then
        local CurHP = UnitHealth("party"..id);

        if UnitFramesPlusDB["party"]["bartext"] == 1 and not UnitIsDead("party"..id) then
            local CurHPfix, MaxHPfix = UnitFramesPlus_GetValueFix(UnitHealth("party"..id), UnitHealthMax("party"..id), UnitFramesPlusDB["party"]["hpmpunit"], UnitFramesPlusDB["party"]["unittype"]);
            -- local CurManafix, MaxManafix = UnitFramesPlus_GetValueFix(UnitPower("party"..id), UnitPowerMax("party"..id), UnitFramesPlusDB["party"]["hpmpunit"], UnitFramesPlusDB["party"]["unittype"]);
            HPText = CurHPfix.."/"..MaxHPfix;
            -- MPText = CurManafix.."/"..MaxManafix;
        end

        if UnitFramesPlusDB["party"]["hp"] == 1 then
            local MaxHP = UnitHealthMax("party"..id);
            if MaxHP > 0 then
                if UnitFramesPlusDB["party"]["hppct"] == 1 then
                    PctText = floor(100*CurHP/MaxHP).."%";
                else
                    PctText = CurHP.."/"..MaxHP;
                end
            end
        end

        -- if UnitFramesPlusDB["party"]["death"] == 1 then
        --     if UnitIsDead("party"..id) then
        --         DeathText = UFPLocal_DeathText;
        --     elseif UnitIsGhost("party"..id) then
        --         DeathText = UFPLocal_GhostText;
        --     end
        -- end
    end
    _G["UFP_PartyHPPct"..id].Text:SetText(PctText);
    -- _G["UFP_PartyDeath"..id].Text:SetText(DeathText);

    _G["PartyMemberFrame"..id.."HealthBarText"]:SetText(HPText);
    -- _G["PartyMemberFrame"..id.."ManaBarText"]:SetText(MPText);
end

function UnitFramesPlus_PartyPowerDisplayUpdate(id)
    local MPText = "";
    if UnitExists("party"..id) and UnitFramesPlusDB["party"]["origin"] == 1 then
        if UnitFramesPlusDB["party"]["bartext"] == 1 and not UnitIsDead("party"..id) then
            local CurManafix, MaxManafix = UnitFramesPlus_GetValueFix(UnitPower("party"..id), UnitPowerMax("party"..id), UnitFramesPlusDB["party"]["hpmpunit"], UnitFramesPlusDB["party"]["unittype"]);
            MPText = CurManafix.."/"..MaxManafix;
        end
    end
    _G["PartyMemberFrame"..id.."ManaBarText"]:SetText(MPText);
end

--队友头像内战斗信息
for id = 1, MAX_PARTY_MEMBERS, 1 do
    local PartyPortraitIndicator = CreateFrame("Frame", "UFP_PartyPortraitIndicator"..id, _G["PartyMemberFrame"..id]);
    PartyPortraitIndicator:SetAttribute("unit", "party"..id);
    RegisterUnitWatch(PartyPortraitIndicator);
    _G["UFP_PartyPortraitIndicator"..id]:SetFrameStrata("MEDIUM");
    _G["UFP_PartyPortraitIndicator"..id]:SetFrameLevel(_G["PartyMemberFrame"..id]:GetFrameLevel()+1);
    _G["UFP_PartyPortraitIndicator"..id].feedbackStartTime = GetTime();
    _G["UFP_PartyPortraitIndicator"..id]:CreateFontString("UFP_PartyHitIndicator"..id, "OVERLAY", "NumberFontNormalHuge");
    _G["UFP_PartyHitIndicator"..id]:ClearAllPoints();
    _G["UFP_PartyHitIndicator"..id]:SetPoint("CENTER", _G["PartyMemberFrame"..id.."Portrait"], "CENTER", 0, 0);
    CombatFeedback_Initialize(_G["UFP_PartyPortraitIndicator"..id], _G["UFP_PartyHitIndicator"..id], 20);
end

function UnitFramesPlus_PartyPortraitIndicator()
    if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["indicator"] == 1 then
        for id = 1, MAX_PARTY_MEMBERS, 1 do
            _G["UFP_PartyPortraitIndicator"..id]:RegisterEvent("PLAYER_ENTERING_WORLD");
            _G["UFP_PartyPortraitIndicator"..id]:RegisterEvent("GROUP_ROSTER_UPDATE");
            _G["UFP_PartyPortraitIndicator"..id]:RegisterEvent("PARTY_LEADER_CHANGED");
            _G["UFP_PartyPortraitIndicator"..id]:RegisterUnitEvent("UNIT_CONNECTION", "party"..id);
            _G["UFP_PartyPortraitIndicator"..id]:RegisterUnitEvent("UNIT_COMBAT", "party"..id);
            _G["UFP_PartyPortraitIndicator"..id]:SetScript("OnEvent", function(self, event, ...)
                -- if tonumber(GetCVar("useCompactPartyFrames")) ~= 1 then
                    local arg1, arg2, arg3, arg4, arg5 = ...;
                    if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "PARTY_LEADER_CHANGED" or (event == "UNIT_CONNECTION" and arg2 == false) then
                        _G["UFP_PartyHitIndicator"..id]:Hide();
                    elseif event == "UNIT_COMBAT" then
                        CombatFeedback_OnCombatEvent(self, arg2, arg3, arg4, arg5);
                    end
                -- end
            end)

            _G["UFP_PartyPortraitIndicator"..id]:SetScript("OnUpdate", function(self, elapsed)
                -- if tonumber(GetCVar("useCompactPartyFrames")) ~= 1 then
                    CombatFeedback_OnUpdate(self, elapsed);
                -- end
            end)
        end
    else
        for id = 1, MAX_PARTY_MEMBERS, 1 do
            _G["UFP_PartyHitIndicator"..id]:Hide();
            if _G["UFP_PartyPortraitIndicator"..id]:IsEventRegistered("PLAYER_ENTERING_WORLD") then
                _G["UFP_PartyPortraitIndicator"..id]:UnregisterAllEvents();
                _G["UFP_PartyPortraitIndicator"..id]:SetScript("OnUpdate", nil);
                _G["UFP_PartyPortraitIndicator"..id]:SetScript("OnEvent", nil);
            end
        end
    end
end

-- --队友离线检测
-- for id = 1, MAX_PARTY_MEMBERS, 1 do
--     local PartyOfflineStatus = _G["PartyMemberFrame"..id]:CreateTexture("UFP_PartyOfflineStatus"..id, "OVERLAY", _G["PartyMemberFrame"..id]);
--     _G["UFP_PartyOfflineStatus"..id]:SetTexture("Interface\\CharacterFrame\\Disconnect-Icon");
--     _G["UFP_PartyOfflineStatus"..id]:SetWidth(64);
--     _G["UFP_PartyOfflineStatus"..id]:SetHeight(64);
--     _G["UFP_PartyOfflineStatus"..id]:ClearAllPoints();
--     _G["UFP_PartyOfflineStatus"..id]:SetPoint("LEFT", _G["PartyMemberFrame"..id], "LEFT", -7, -1);
--     _G["UFP_PartyOfflineStatus"..id]:SetAlpha(0);
-- end

-- local pm = CreateFrame("Frame");
-- function UnitFramesPlus_PartyOfflineDetection()
--     if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["onoff"] == 1 then
--         pm:RegisterEvent("PLAYER_ENTERING_WORLD");
--         pm:RegisterEvent("GROUP_ROSTER_UPDATE");
--         pm:RegisterEvent("PARTY_LEADER_CHANGED");
--         pm:RegisterEvent("PARTY_MEMBER_ENABLE");
--         pm:RegisterEvent("PARTY_MEMBER_DISABLE");
--         pm:RegisterEvent("UNIT_CONNECTION");
--         pm:SetScript("OnEvent", function(self, event, ...)
--             -- if tonumber(GetCVar("useCompactPartyFrames")) ~= 1 then
--                 if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "PARTY_LEADER_CHANGED" or event == "PARTY_MEMBER_ENABLE" or event == "PARTY_MEMBER_DISABLE" then
--                     UnitFramesPlus_PartyOfflineDetectionDisplayUpdate();
--                 elseif event == "UNIT_CONNECTION" then
--                     local unit, hasConnected = ...;
--                     for id = 1, MAX_PARTY_MEMBERS, 1 do
--                         if UnitExists("party"..id) and unit == "party"..id then
--                             if hasConnected == false then
--                                 -- _G["PartyMemberFrame"..id]:SetAlpha(0.5);
--                                 _G["UFP_PartyOfflineStatus"..id]:SetAlpha(1);
--                             else
--                                 -- _G["PartyMemberFrame"..id]:SetAlpha(1);
--                                 _G["UFP_PartyOfflineStatus"..id]:SetAlpha(0);
--                             end
--                         end
--                     end
--                 end
--             -- end
--         end)
--     else
--         for id = 1, MAX_PARTY_MEMBERS, 1 do
--             -- _G["PartyMemberFrame"..id]:SetAlpha(1);
--             _G["UFP_PartyOfflineStatus"..id]:SetAlpha(0);
--         end
--         if pm:IsEventRegistered("PLAYER_ENTERING_WORLD") then
--             pm:UnregisterAllEvents();
--             pm:SetScript("OnEvent", nil);
--         end
--     end
-- end

-- --刷新队友离线检测显示
-- function UnitFramesPlus_PartyOfflineDetectionDisplayUpdate()
--     for id = 1, MAX_PARTY_MEMBERS, 1 do
--         if UnitExists("party"..id) and UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["onoff"] == 1 then
--             if not UnitIsConnected("party"..id) then
--                 -- _G["PartyMemberFrame"..id]:SetAlpha(0.5);
--                 _G["UFP_PartyOfflineStatus"..id]:SetAlpha(1);
--             else
--                 -- _G["PartyMemberFrame"..id]:SetAlpha(1);
--                 _G["UFP_PartyOfflineStatus"..id]:SetAlpha(0);
--             end
--         else
--             -- _G["PartyMemberFrame"..id]:SetAlpha(1);
--             _G["UFP_PartyOfflineStatus"..id]:SetAlpha(0);
--         end
--     end
-- end

-- local frf = CreateFrame("Frame");
-- function UnitFramesPlus_FrameRangeFade()
--     if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["range"] == 1 then
--         frf:SetScript("OnUpdate", function(self, elapsed)
--             self.timer = (self.timer or 0) + elapsed;
--             if self.timer >= 0.2 then
--                 if IsInGroup() and not IsInRaid() then
--                 for id=1, MAX_PARTY_MEMBERS, 1 do
--                     if not UnitInRange("party"..id) then
--                         _G["PartyMemberFrame"..id]:SetAlpha(0.5);
--                     else
--                         if _G["PartyMemberFrame"..id]:GetAlpha() < 1 then
--                             _G["PartyMemberFrame"..id]:SetAlpha(1);
--                         end
--                     end
--                     if not UnitInRange("partypet"..id) then
--                         _G["PartyMemberFrame"..id.."PetFrame"]:SetAlpha(0.5);
--                     else
--                         if _G["PartyMemberFrame"..id.."PetFrame"]:GetAlpha() < 1 then
--                             _G["PartyMemberFrame"..id.."PetFrame"]:SetAlpha(1);
--                         end
--                     end
--                 end
--                 self.timer = 0;
--             end
--         end)
--     else
--         frf:SetScript("OnUpdate", nil);
--     end
-- end

--队友buff/debuff直接显示

--Buff filter
local UnitFramesPlusBuffFilter = {
    nil,
    "CANCELABLE",
    "NOT_CANCELABLE",
    -- "RAID",
    -- "PLAYER",
    -- "CANCELABLE|PLAYER",
    -- "NOT_CANCELABLE|PLAYER",
    -- "CANCELABLE|RAID",
    -- "NOT_CANCELABLE|RAID",
}

local UFP_MAX_PARTY_BUFFS = 16;
local UFP_MAX_PARTY_DEBUFFS = 8;
local UFP_MAX_PARTY_PET_DEBUFFS = 4;
for id = 1, MAX_PARTY_MEMBERS, 1 do
    for j = 1, UFP_MAX_PARTY_BUFFS, 1 do
        local buff = CreateFrame("Button", "UFP_PartyMemberFrame"..id.."Buff"..j, _G["PartyMemberFrame"..id]);
        buff:SetFrameLevel(_G["PartyMemberFrame"..id]:GetFrameLevel()+1);
        buff:SetWidth(15);
        buff:SetHeight(15);
        buff:SetID(j);
        buff:ClearAllPoints();
        if j == 1 then
            buff:SetPoint("TOPLEFT", _G["PartyMemberFrame"..id], "TOPLEFT", 48, -32);
        else
            buff:SetPoint("LEFT", _G["UFP_PartyMemberFrame"..id.."Buff"..j-1], "RIGHT", 2, 0);
        end
        buff:SetAttribute("unit", "party"..id);
        RegisterUnitWatch(buff);

        buff.Icon = buff:CreateTexture("UFP_PartyMemberFrame"..id.."Buff"..j.."Icon", "ARTWORK");
        buff.Icon:ClearAllPoints();
        buff.Icon:SetAllPoints(buff);

        buff.Cooldown = CreateFrame("Cooldown", "UFP_PartyMemberFrame"..id.."Buff"..j.."Cooldown", buff, "CooldownFrameTemplate");
        buff.Cooldown:SetFrameLevel(buff:GetFrameLevel()+1);
        buff.Cooldown:SetReverse(true);
        buff.Cooldown:ClearAllPoints();
        buff.Cooldown:SetAllPoints(buff.Icon);
        buff.Cooldown:SetParent(buff);
        -- buff.Cooldown:Hide();

        buff.CooldownText = buff.Cooldown:CreateFontString("UFP_PartyMemberFrame"..id.."Buff"..j.."CooldownText", "OVERLAY");
        buff.CooldownText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
        buff.CooldownText:SetTextColor(1, 1, 1);--(1, 0.75, 0);
        buff.CooldownText:ClearAllPoints();
        buff.CooldownText:SetPoint("CENTER", buff.Icon, "CENTER", 0, 0);
        -- buff.CooldownText:SetPoint("TOPLEFT", buff.Icon, "TOPLEFT", 0, 0);

        buff.Border = buff:CreateTexture("UFP_PartyMemberFrame"..id.."Buff"..j.."Border", "OVERLAY");
        buff.Border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays");
        buff.Border:SetWidth(17);
        buff.Border:SetHeight(17);
        buff.Border:SetTexCoord(0.296875, 0.5703125, 0, 0.515625);
        buff.Border:ClearAllPoints();
        buff.Border:SetPoint("TOPLEFT", buff, "TOPLEFT", -1, 1);

        buff:EnableMouse(true);
        buff:SetScript("OnEnter",function(self)
            if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["hidetip"] == 0 then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
                local filter = nil;
                if UnitFramesPlusDB["party"]["filter"] == 1 then
                    filter = UnitFramesPlusBuffFilter[UnitFramesPlusDB["party"]["filtertype"]];
                end
                GameTooltip:SetUnitBuff("party"..id, j, filter);
            end
        end)
        buff:SetScript("OnLeave",function()
            GameTooltip:Hide();
        end)
    end

    _G["PartyMemberFrame"..id.."Debuff1"]:ClearAllPoints();
    -- _G["PartyMemberFrame"..id.."Debuff1"]:SetPoint("BOTTOMLEFT", _G["PartyMemberFrame"..id], "TOPRIGHT", -8, 4);
    for j = 1, UFP_MAX_PARTY_DEBUFFS, 1 do
        local debuff = CreateFrame("Button", "UFP_PartyMemberFrame"..id.."Debuff"..j, _G["PartyMemberFrame"..id]);
        debuff:SetFrameLevel(_G["UFP_PartyMemberFrame"..id.."Buff1"]:GetFrameLevel()+2);
        debuff:SetWidth(17);
        debuff:SetHeight(17);
        debuff:SetID(j);
        debuff:ClearAllPoints();
        if j == 1 then
            debuff:SetPoint("BOTTOMLEFT", _G["PartyMemberFrame"..id], "TOPRIGHT", -8, 4);
        else
            debuff:SetPoint("LEFT", _G["UFP_PartyMemberFrame"..id.."Debuff"..j-1], "RIGHT", 2, 0);
        end
        debuff:SetAttribute("unit", "party"..id);
        RegisterUnitWatch(debuff);

        debuff.Icon = debuff:CreateTexture("UFP_PartyMemberFrame"..id.."Debuff"..j.."Icon", "ARTWORK");
        debuff.Icon:ClearAllPoints();
        debuff.Icon:SetAllPoints(debuff);

        debuff.Cooldown = CreateFrame("Cooldown", "UFP_PartyMemberFrame"..id.."Debuff"..j.."Cooldown", debuff, "CooldownFrameTemplate");
        debuff.Cooldown:SetFrameLevel(debuff:GetFrameLevel()+1);
        debuff.Cooldown:SetReverse(true);
        debuff.Cooldown:ClearAllPoints();
        debuff.Cooldown:SetAllPoints(debuff.Icon);
        debuff.Cooldown:SetParent(debuff);
        -- debuff.Cooldown:Hide();

        debuff.CooldownText = debuff.Cooldown:CreateFontString("UFP_PartyMemberFrame"..id.."Debuff"..j.."CooldownText", "OVERLAY");
        debuff.CooldownText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
        debuff.CooldownText:SetTextColor(1, 1, 1);--(1, 0.75, 0);
        debuff.CooldownText:ClearAllPoints();
        debuff.CooldownText:SetPoint("CENTER", debuff.Icon, "CENTER", 0, 0);
        -- debuff.CooldownText:SetPoint("TOPLEFT", debuff.Icon, "TOPLEFT", 0, 0);

        debuff.CountText = debuff.Cooldown:CreateFontString("UFP_PartyMemberFrame"..id.."Debuff"..j.."CountText", "OVERLAY");
        debuff.CountText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
        debuff.CountText:SetTextColor(1, 1, 1);
        debuff.CountText:ClearAllPoints();
        -- debuff.CountText:SetPoint("CENTER", debuff.Icon, "BOTTOM", 0, 0);
        debuff.CountText:SetPoint("BOTTOMRIGHT", debuff.Icon, "BOTTOMRIGHT", 0, 0);

        debuff.Border = debuff:CreateTexture("UFP_PartyMemberFrame"..id.."Debuff"..j.."Border", "OVERLAY");
        debuff.Border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays");
        debuff.Border:SetWidth(17);
        debuff.Border:SetHeight(17);
        debuff.Border:SetTexCoord(0.296875, 0.5703125, 0, 0.515625);
        debuff.Border:ClearAllPoints();
        debuff.Border:SetPoint("TOPLEFT", debuff, "TOPLEFT", -1, 1);

        debuff:EnableMouse(true);
        debuff:SetScript("OnEnter",function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
            GameTooltip:SetUnitDebuff("party"..id, j);
        end)
        debuff:SetScript("OnLeave",function()
            GameTooltip:Hide();
        end)
    end

    _G["PartyMemberFrame"..id.."PetFrameDebuff1"]:ClearAllPoints();
    -- _G["PartyMemberFrame"..id.."PetFrameDebuff1"]:SetPoint("LEFT", _G["PartyMemberFrame"..id.."PetFrame"], "RIGHT", -3, -1);
    _G["PartyMemberFrame"..id.."PetFrameDebuff1"]:SetPoint("BOTTOM", _G["PartyMemberFrame"..id.."PetFrame"], "TOP", -26, 0);
    -- for j = 1, UFP_MAX_PARTY_PET_DEBUFFS, 1 do
    --     local petdebuff = CreateFrame("Button", "UFP_PartyPetMemberFrame"..id.."Debuff"..j, _G["PartyMemberFrame"..id.."PetFrame"]);
    --     petdebuff:SetFrameLevel(7);
    --     petdebuff:SetWidth(15);
    --     petdebuff:SetHeight(15);
    --     petdebuff:SetID(j);
    --     petdebuff:ClearAllPoints();
    --     if j == 1 then
    --         petdebuff:SetPoint("LEFT", _G["PartyMemberFrame"..id.."PetFrame"], "RIGHT", -3, -1);
    --     else
    --         petdebuff:SetPoint("LEFT", _G["UFP_PartyPetMemberFrame"..id.."Debuff"..j-1], "RIGHT", 2, 0);
    --     end
    --     petdebuff:SetAttribute("unit", "partypet"..id);
    --     RegisterUnitWatch(petdebuff);

    --     petdebuff.Icon = petdebuff:CreateTexture("UFP_PartyPetMemberFrame"..id.."Debuff"..j.."Icon", "ARTWORK");
    --     petdebuff.Icon:ClearAllPoints();
    --     petdebuff.Icon:SetAllPoints(petdebuff);

    --     petdebuff.Cooldown = CreateFrame("Cooldown", "UFP_PartyPetMemberFrame"..id.."Debuff"..j.."Cooldown", petdebuff, "CooldownFrameTemplate");
    --     petdebuff.Cooldown:SetFrameLevel(8);
    --     petdebuff.Cooldown:SetReverse(true);
    --     petdebuff.Cooldown:ClearAllPoints();
    --     petdebuff.Cooldown:SetAllPoints(petdebuff.Icon);
    --     petdebuff.Cooldown:SetParent(petdebuff);
    --     -- petdebuff.Cooldown:Hide();

    --     petdebuff.CooldownText = petdebuff.Cooldown:CreateFontString("UFP_PartyPetMemberFrame"..id.."Debuff"..j.."CooldownText", "OVERLAY");
    --     petdebuff.CooldownText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
    --     petdebuff.CooldownText:SetTextColor(1, 1, 1);--(1, 0.75, 0);
    --     petdebuff.CooldownText:ClearAllPoints();
    --     petdebuff.CooldownText:SetPoint("CENTER", petdebuff.Icon, "CENTER", 0, 0);
    --     -- petdebuff.CooldownText:SetPoint("TOPLEFT", petdebuff.Icon, "TOPLEFT", 0, 0);

    --     petdebuff.CountText = petdebuff.Cooldown:CreateFontString("UFP_PartyPetMemberFrame"..id.."Debuff"..j.."CountText", "OVERLAY");
    --     petdebuff.CountText:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
    --     petdebuff.CountText:SetTextColor(1, 1, 1);
    --     petdebuff.CountText:ClearAllPoints();
    --     -- petdebuff.CountText:SetPoint("CENTER", petdebuff.Icon, "BOTTOM", 0, 0);
    --     petdebuff.CountText:SetPoint("BOTTOMRIGHT", petdebuff.Icon, "BOTTOMRIGHT", 0, 0);

    --     petdebuff.Border = petdebuff:CreateTexture("UFP_PartyPetMemberFrame"..id.."Debuff"..j.."Border", "OVERLAY");
    --     petdebuff.Border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays");
    --     petdebuff.Border:SetWidth(17);
    --     petdebuff.Border:SetHeight(17);
    --     petdebuff.Border:SetTexCoord(0.296875, 0.5703125, 0, 0.515625);
    --     petdebuff.Border:ClearAllPoints();
    --     petdebuff.Border:SetPoint("TOPLEFT", petdebuff, "TOPLEFT", -1, 1);

    --     petdebuff:EnableMouse(true);
    --     petdebuff:SetScript("OnEnter",function(self)
    --         GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    --         GameTooltip:SetUnitDebuff("partypet"..id, j);
    --     end)
    --     petdebuff:SetScript("OnLeave",function()
    --         GameTooltip:Hide();
    --     end)
    -- end
end

--队友buff/debuff直接显示时隐藏buff鼠标提示
hooksecurefunc("PartyMemberBuffTooltip_Update", function(self)
    if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["buff"] == 1 then
        PartyMemberBuffTooltip:Hide();
    end
end)

local pb = CreateFrame("Frame");
function UnitFramesPlus_PartyBuff()
    UnitFramesPlus_PartyMemberPosition();
    pb:SetScript("OnUpdate", function(self, elapsed)
        self.timer = (self.timer or 0) + elapsed;
        if self.timer >= 0.1 then
            UnitFramesPlus_OptionsFrame_PartyBuffDisplayUpdate();
            self.timer = 0;
        end
    end)
    if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["buff"] == 1 then
        for id = 1, MAX_PARTY_MEMBERS, 1 do
            _G["UFP_PartyMemberFrame"..id.."Debuff1"]:ClearAllPoints();
            _G["UFP_PartyMemberFrame"..id.."Debuff1"]:SetPoint("BOTTOMLEFT", _G["PartyMemberFrame"..id], "TOPRIGHT", -8, 4);
        end
        -- pb:SetScript("OnUpdate", function(self, elapsed)
        --     self.timer = (self.timer or 0) + elapsed;
        --     if self.timer >= 0.1 then
        --         UnitFramesPlus_OptionsFrame_PartyBuffDisplayUpdate();
        --         self.timer = 0;
        --     end
        -- end)
    else
        for id = 1, MAX_PARTY_MEMBERS, 1 do
            _G["UFP_PartyMemberFrame"..id.."Debuff1"]:ClearAllPoints();
            _G["UFP_PartyMemberFrame"..id.."Debuff1"]:SetPoint("TOPLEFT", _G["PartyMemberFrame"..id], "TOPLEFT", 48, -32);
            for j = 1, UFP_MAX_PARTY_BUFFS, 1 do
                _G["UFP_PartyMemberFrame"..id.."Buff"..j]:SetAlpha(0);
            end
            for j = 1, UFP_MAX_PARTY_DEBUFFS, 1 do
                _G["UFP_PartyMemberFrame"..id.."Debuff"..j]:SetAlpha(0);
            end
            -- for j = 1, UFP_MAX_PARTY_PET_DEBUFFS, 1 do
            --     _G["UFP_PartyPetMemberFrame"..id.."Debuff"..j]:SetAlpha(0);
            -- end
        end
        -- pb:SetScript("OnUpdate", nil);
    end
end

function UnitFramesPlus_OptionsFrame_PartyBuffDisplayUpdate()
    local filter = nil;
    if UnitFramesPlusDB["party"]["filter"] == 1 then
        filter = UnitFramesPlusBuffFilter[UnitFramesPlusDB["party"]["filtertype"]];
    end
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        if UnitExists("party"..id) then
            if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["buff"] == 1 then
                for j = 1, UFP_MAX_PARTY_BUFFS, 1 do
                    local alpha = 0;
                    local cdalpha = 0;
                    local timetext = "";
                    -- local textalpha = 0.7;
                    -- local r, g, b = 0, 1, 0;

                    local _, icon, _, _, duration, expirationTime, caster, _, _, spellId = UnitBuff("party"..id, j, filter);
                    if icon and (GetDisplayedAllyFrames() == "party" or (GetDisplayedAllyFrames() == "raid" and UnitFramesPlusDB["party"]["hideraid"] == 1 and UnitFramesPlusDB["party"]["always"] == 1)) then
                        _G["UFP_PartyMemberFrame"..id.."Buff"..j].Icon:SetTexture(icon);
                        alpha = 1;

                        if UnitFramesPlusDB["party"]["cooldown"] == 1 then
                            cdalpha = 1;

                            if UnitFramesPlusDB["global"]["builtincd"] == 1 and UFPClassicDurations then
                                local durationNew, expirationTimeNew = UFPClassicDurations:GetAuraDurationByUnit("party"..id, spellId, caster);
                                if duration == 0 and durationNew then
                                    duration = durationNew;
                                    expirationTime = expirationTimeNew;
                                end

                                if UnitFramesPlusDB["global"]["cdtext"] == 1 and expirationTime and expirationTime ~= 0 and duration > 0 then
                                    local timeleft = expirationTime - GetTime();
                                    if timeleft >= 0 then
                                        if timeleft < 60 then
                                            timetext = floor(timeleft+1);
                                            -- textalpha = 1 - timeleft/200;
                                            -- r, g, b = UnitFramesPlus_GetRGB(timeleft, 60);
                                        elseif timeleft <= 1800 then
                                            timetext = floor(timeleft/60+1).."m";
                                        else
                                            timetext = floor(timeleft/3600+1).."h";
                                        end
                                    end
                                end

                                CooldownFrame_Set(_G["UFP_PartyMemberFrame"..id.."Buff"..j].Cooldown, expirationTime - duration, duration, true);
                            else
                                CooldownFrame_Clear(_G["UFP_PartyMemberFrame"..id.."Buff"..j].Cooldown);
                            end
                        else
                            CooldownFrame_Clear(_G["UFP_PartyMemberFrame"..id.."Buff"..j].Cooldown);
                        end
                    end
                    _G["UFP_PartyMemberFrame"..id.."Buff"..j]:SetAlpha(alpha);
                    _G["UFP_PartyMemberFrame"..id.."Buff"..j].Cooldown:SetAlpha(cdalpha);
                    -- _G["UFP_PartyMemberFrame"..id.."Buff"..j].CooldownText:SetTextColor(r, g, b);
                    -- _G["UFP_PartyMemberFrame"..id.."Buff"..j].CooldownText:SetAlpha(textalpha);
                    if (not IsAddOnLoaded("OmniCC")) then
                        _G["UFP_PartyMemberFrame"..id.."Buff"..j].CooldownText:SetText(timetext);
                    else
                        _G["UFP_PartyMemberFrame"..id.."Buff"..j].CooldownText:SetText("");
                    end
                end
            end

            local filter = nil;
            for j = 1, UFP_MAX_PARTY_DEBUFFS, 1 do
                local alpha = 0;
                local cdalpha = 0;
                local timetext = "";
                local counttext = "";
                -- local textalpha = 0.7;
                -- local r, g, b = 0, 1, 0;

                local _, icon, count, _, duration, expirationTime, caster, _, _, spellId = UnitDebuff("party"..id, j, filter);
                if icon and (GetDisplayedAllyFrames() == "party" or (GetDisplayedAllyFrames() == "raid" and UnitFramesPlusDB["party"]["hideraid"] == 1 and UnitFramesPlusDB["party"]["always"] == 1)) then
                    _G["UFP_PartyMemberFrame"..id.."Debuff"..j].Icon:SetTexture(icon);
                    alpha = 1;
                    if count > 1 then
                        counttext = count;
                    end

                    if UnitFramesPlusDB["party"]["cooldown"] == 1 then
                        cdalpha = 1;

                        if UnitFramesPlusDB["global"]["builtincd"] == 1 and UFPClassicDurations then
                            local durationNew, expirationTimeNew = UFPClassicDurations:GetAuraDurationByUnit("party"..id, spellId, caster);
                            if duration == 0 and durationNew then
                                duration = durationNew;
                                expirationTime = expirationTimeNew;
                            end

                            if UnitFramesPlusDB["global"]["cdtext"] == 1 and expirationTime and expirationTime ~= 0 and duration > 0 then
                                local timeleft = expirationTime - GetTime();
                                if timeleft >= 0 then
                                    if timeleft < 60 then
                                        timetext = floor(timeleft+1);
                                        -- textalpha = 1 - timeleft/200;
                                        -- r, g, b = UnitFramesPlus_GetRGB(timeleft, 60);
                                    elseif timeleft <= 1800 then
                                        timetext = floor(timeleft/60+1).."m";
                                    else
                                        timetext = floor(timeleft/3600+1).."h";
                                    end
                                end
                            end

                            CooldownFrame_Set(_G["UFP_PartyMemberFrame"..id.."Debuff"..j].Cooldown, expirationTime - duration, duration, true);
                        else
                            CooldownFrame_Clear(_G["UFP_PartyMemberFrame"..id.."Debuff"..j].Cooldown);
                        end
                    else
                        CooldownFrame_Clear(_G["UFP_PartyMemberFrame"..id.."Debuff"..j].Cooldown);
                    end
                end
                _G["UFP_PartyMemberFrame"..id.."Debuff"..j]:SetAlpha(alpha);
                _G["UFP_PartyMemberFrame"..id.."Debuff"..j].Icon:SetAlpha(alpha);
                _G["UFP_PartyMemberFrame"..id.."Debuff"..j].Border:SetAlpha(alpha);
                _G["UFP_PartyMemberFrame"..id.."Debuff"..j].Cooldown:SetAlpha(cdalpha);
                -- _G["UFP_PartyMemberFrame"..id.."Debuff"..j].CooldownText:SetTextColor(r, g, b);
                -- _G["UFP_PartyMemberFrame"..id.."Debuff"..j].CooldownText:SetAlpha(textalpha);
                if (not IsAddOnLoaded("OmniCC")) then
                    _G["UFP_PartyMemberFrame"..id.."Debuff"..j].CooldownText:SetText(timetext);
                else
                    _G["UFP_PartyMemberFrame"..id.."Debuff"..j].CooldownText:SetText("");
                end
                _G["UFP_PartyMemberFrame"..id.."Debuff"..j].CountText:SetText(counttext);
            end

            -- for j = 1, UFP_MAX_PARTY_PET_DEBUFFS, 1 do
            --     local alpha = 0;
            --     local cdalpha = 0;
            --     local timetext = "";
            --     -- local textalpha = 0.7;
            --     -- local r, g, b = 0, 1, 0;

            --     local _, icon, count, _, duration, expirationTime, caster, _, _, spellId = UnitDebuff("partypet"..id, j);
            --     if icon then
            --         _G["UFP_PartyPetMemberFrame"..id.."Debuff"..j].Icon:SetTexture(icon);
            --         alpha = 1;
            --         if count > 1 then
            --             counttext = count;
            --         end

            --         if UnitFramesPlusDB["party"]["cooldown"] == 1 then
            --             cdalpha = 1;

            --             if UnitFramesPlusDB["global"]["builtincd"] == 1 and UFPClassicDurations then
            --                 local durationNew, expirationTimeNew = UFPClassicDurations:GetAuraDurationByUnit("party"..id, spellId, caster);
            --                 if duration == 0 and durationNew then
            --                     duration = durationNew;
            --                     expirationTime = expirationTimeNew;
            --                 end

            --                 if UnitFramesPlusDB["global"]["cdtext"] == 1 and expirationTime and expirationTime ~= 0 and duration > 0 then
            --                     local timeleft = expirationTime - GetTime();
            --                     if timeleft >= 0 then
            --                         if timeleft < 60 then
            --                             timetext = floor(timeleft+1);
            --                             -- textalpha = 1 - timeleft/200;
            --                             -- r, g, b = UnitFramesPlus_GetRGB(timeleft, 60);
            --                         elseif timeleft <= 1800 then
            --                             timetext = floor(timeleft/60+1).."m";
            --                         else
            --                             timetext = floor(timeleft/3600+1).."h";
            --                         end
            --                     end
            --                 end

            --                 CooldownFrame_Set(_G["UFP_PartyPetMemberFrame"..id.."Debuff"..j].Cooldown, expirationTime - duration, duration, true);
            --             else
            --                 CooldownFrame_Clear(_G["UFP_PartyPetMemberFrame"..id.."Debuff"..j].Cooldown);
            --             end
            --         else
            --             CooldownFrame_Clear(_G["UFP_PartyPetMemberFrame"..id.."Debuff"..j].Cooldown);
            --         end
            --     end
            --     _G["UFP_PartyPetMemberFrame"..id.."Debuff"..j]:SetAlpha(alpha);
            --     _G["UFP_PartyPetMemberFrame"..id.."Debuff"..j].Cooldown:SetAlpha(cdalpha);
            --     -- _G["UFP_PartyPetMemberFrame"..id.."Debuff"..j].CooldownText:SetTextColor(r, g, b);
            --     -- _G["UFP_PartyPetMemberFrame"..id.."Debuff"..j].CooldownText:SetAlpha(textalpha);
            --     if (not IsAddOnLoaded("OmniCC")) then
            --         _G["UFP_PartyPetMemberFrame"..id.."Debuff"..j].CooldownText:SetText(timetext);
            --     else
            --         _G["UFP_PartyPetMemberFrame"..id.."Debuff"..j].CooldownText:SetText("");
            --     end
            --     _G["UFP_PartyPetMemberFrame"..id.."Debuff"..j].CountText:SetText(counttext);
            -- end
        end
    end
end

function UnitFramesPlus_PartyPositionSet()
    if UnitFramesPlusVar["party"]["moved"] ~= 0 then
        PartyMemberFrame1:ClearAllPoints();
        PartyMemberFrame1:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", UnitFramesPlusVar["party"]["x"], UnitFramesPlusVar["party"]["y"]);
    else
        if not IsAddOnLoaded("Blizzard_CompactRaidFrames") then
            PartyMemberFrame1:ClearAllPoints();
            PartyMemberFrame1:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 10, -160);
        end
    end
end

function UnitFramesPlus_PartyPosition()
    if not InCombatLockdown() then
        UnitFramesPlus_PartyPositionSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PartyPositionSet";
        func.callback = function()
            UnitFramesPlus_PartyPositionSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

function UnitFramesPlus_PartyMemberPositionSet()
    -- if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["buff"] == 1 then
    if UnitFramesPlusDB["party"]["buff"] == 1 then
        for id = 2, 4, 1 do
            local lowid = id - 1;
            _G["PartyMemberFrame"..id]:ClearAllPoints();
            -- _G["PartyMemberFrame"..id]:SetPoint("TOPLEFT", _G["PartyMemberFrame"..lowid.."PetFrame"], "BOTTOMLEFT", -23, -20);
            _G["PartyMemberFrame"..id]:SetPoint("TOPLEFT", _G["PartyMemberFrame"..lowid], "TOPLEFT", 0, -86);
        end
    else
        for id = 2, 4, 1 do
            local lowid = id - 1;
            _G["PartyMemberFrame"..id]:ClearAllPoints();
            -- _G["PartyMemberFrame"..id]:SetPoint("TOPLEFT", _G["PartyMemberFrame"..lowid.."PetFrame"], "BOTTOMLEFT", -23, -10);
            _G["PartyMemberFrame"..id]:SetPoint("TOPLEFT", _G["PartyMemberFrame"..lowid], "TOPLEFT", 0, -68);
        end
    end
end

function UnitFramesPlus_PartyMemberPosition()
    if not InCombatLockdown() then
        UnitFramesPlus_PartyMemberPositionSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PartyMemberPositionSet";
        func.callback = function()
            UnitFramesPlus_PartyMemberPositionSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--队友头像缩放
function UnitFramesPlus_PartyScaleSet(scale)
    if UnitFramesPlusDB["party"]["origin"] == 1 then
        local scale = scale or UnitFramesPlusDB["party"]["scale"];
        if not InCombatLockdown() then
            for id = 1, MAX_PARTY_MEMBERS, 1 do
                _G["PartyMemberFrame"..id]:SetScale(scale);
            end
        end
        if UnitFramesPlusDB["party"]["portrait"] == 1 and UnitFramesPlusDB["party"]["portraittype"] == 1 then
            for id = 1, MAX_PARTY_MEMBERS, 1 do
                UnitFramesPlus_PartyPortraitDisplayUpdate(id);
            end
        end
    end
end

function UnitFramesPlus_PartyScale(scale)
    if not InCombatLockdown() then
        UnitFramesPlus_PartyScaleSet(scale);
    else
        local func = {};
        func.name = "UnitFramesPlus_PartyScaleSet";
        func.callback = function()
            UnitFramesPlus_PartyScaleSet(scale);
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

--鼠标移过时才显示数值
function UnitFramesPlus_PartyBarTextMouseShow()
    if UnitFramesPlusDB["party"]["origin"] == 1 and UnitFramesPlusDB["party"]["mouseshow"] == 1 then
        for id = 1, MAX_PARTY_MEMBERS, 1 do
            _G["PartyMemberFrame"..id.."HealthBarText"]:SetAlpha(0);
            -- _G["PartyMemberFrame"..id.."HealthBarTextLeft"]:SetAlpha(0);
            -- _G["PartyMemberFrame"..id.."HealthBarTextRight"]:SetAlpha(0);
            _G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnEnter", function(self)
                _G["PartyMemberFrame"..id.."HealthBarText"]:SetAlpha(1);
                -- _G["PartyMemberFrame"..id.."HealthBarTextLeft"]:SetAlpha(1);
                -- _G["PartyMemberFrame"..id.."HealthBarTextRight"]:SetAlpha(1);
                UnitFrame_UpdateTooltip(_G["PartyMemberFrame"..id]);
            end);
            _G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnLeave", function()
                _G["PartyMemberFrame"..id.."HealthBarText"]:SetAlpha(0);
                -- _G["PartyMemberFrame"..id.."HealthBarTextLeft"]:SetAlpha(0);
                -- _G["PartyMemberFrame"..id.."HealthBarTextRight"]:SetAlpha(0);
                GameTooltip:Hide();
            end);
            _G["PartyMemberFrame"..id.."ManaBarText"]:SetAlpha(0);
            -- _G["PartyMemberFrame"..id.."ManaBarTextLeft"]:SetAlpha(0);
            -- _G["PartyMemberFrame"..id.."ManaBarTextRight"]:SetAlpha(0);
            _G["PartyMemberFrame"..id.."ManaBar"]:SetScript("OnEnter", function(self)
                _G["PartyMemberFrame"..id.."ManaBarText"]:SetAlpha(1);
                -- _G["PartyMemberFrame"..id.."ManaBarTextLeft"]:SetAlpha(1);
                -- _G["PartyMemberFrame"..id.."ManaBarTextRight"]:SetAlpha(1);
                UnitFrame_UpdateTooltip(_G["PartyMemberFrame"..id]);
            end);
            _G["PartyMemberFrame"..id.."ManaBar"]:SetScript("OnLeave", function()
                _G["PartyMemberFrame"..id.."ManaBarText"]:SetAlpha(0);
                -- _G["PartyMemberFrame"..id.."ManaBarTextLeft"]:SetAlpha(0);
                -- _G["PartyMemberFrame"..id.."ManaBarTextRight"]:SetAlpha(0);
                GameTooltip:Hide();
            end);
        end
    else
        for id = 1, MAX_PARTY_MEMBERS, 1 do
            _G["PartyMemberFrame"..id.."HealthBarText"]:SetAlpha(1);
            -- _G["PartyMemberFrame"..id.."HealthBarTextLeft"]:SetAlpha(1);
            -- _G["PartyMemberFrame"..id.."HealthBarTextRight"]:SetAlpha(1);
            _G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnEnter", function()
                UnitFrame_UpdateTooltip(_G["PartyMemberFrame"..id]);
            end);
            _G["PartyMemberFrame"..id.."HealthBar"]:SetScript("OnLeave", function()
                GameTooltip:Hide();
            end);
            _G["PartyMemberFrame"..id.."ManaBarText"]:SetAlpha(1);
            -- _G["PartyMemberFrame"..id.."ManaBarTextLeft"]:SetAlpha(1);
            -- _G["PartyMemberFrame"..id.."ManaBarTextRight"]:SetAlpha(1);
            _G["PartyMemberFrame"..id.."ManaBar"]:SetScript("OnEnter", function()
                UnitFrame_UpdateTooltip(_G["PartyMemberFrame"..id]);
            end);
            _G["PartyMemberFrame"..id.."ManaBar"]:SetScript("OnLeave", function()
                GameTooltip:Hide();
            end);
        end
    end
end

-- hooksecurefunc("PartyMemberFrame_UpdateNotPresentIcon", function(self)
--     if ( UnitIsConnected("party"..id) and UnitExists("partypet"..id) and SHOW_PARTY_PETS == "1" and UnitFramesPlusDB["party"]["pet"] == 1) then
--         _G["PartyMemberFrame"..self:GetID().."PetFrame"]:SetAlpha(self:GetAlpha());
--     end
-- end)

function UnitFramesPlus_PartyPetSet()
    if UnitFramesPlusDB["party"]["pet"] == 0 then
        if GetCVar("showPartypets") == "1" then
            SetCVar("showPartypets", "0");
        end
    else
        if GetCVar("showPartypets") ~= "1" then
            SetCVar("showPartypets", "1");
        end
    end
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        if UnitExists("party"..id) then
            if ( UnitIsConnected("party"..id) and UnitExists("partypet"..id) and SHOW_PARTY_PETS == "1" and UnitFramesPlusDB["party"]["pet"] == 1) then
                _G["PartyMemberFrame"..id.."PetFrame"]:Show();
                -- _G["PartyMemberFrame"..id.."PetFrame"]:ClearAllPoints();
                -- _G["PartyMemberFrame"..id.."PetFrame"]:SetPoint("TOPLEFT", _G["PartyMemberFrame"..id], "TOPLEFT", 23, -43);
            else
                _G["PartyMemberFrame"..id.."PetFrame"]:Hide();
                -- _G["PartyMemberFrame"..id.."PetFrame"]:ClearAllPoints();
                -- _G["PartyMemberFrame"..id.."PetFrame"]:SetPoint("TOPLEFT", _G["PartyMemberFrame"..id], "TOPLEFT", 23, -27);
            end
        end
        _G["PartyMemberFrame"..id.."PetFrame"]:ClearAllPoints();
        _G["PartyMemberFrame"..id.."PetFrame"]:SetPoint("RIGHT", _G["PartyMemberFrame"..id], "LEFT", -5, 0);
    end
end

function UnitFramesPlus_PartyPet()
    if not InCombatLockdown() then
        UnitFramesPlus_PartyPetSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PartyPetSet";
        func.callback = function()
            UnitFramesPlus_PartyPetSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

local UFPHider = CreateFrame("Frame", "UFPHider");
UFPHider:Hide();
function UnitFramesPlus_PartyShowHideSet()
    local parent = PartyMemberFrame1:GetParent():GetName();
    if UnitFramesPlusDB["party"]["origin"] ~= 1 or GetDisplayedAllyFrames() == nil or (GetDisplayedAllyFrames() == "raid" and (UnitFramesPlusDB["party"]["hideraid"] ~= 1 or (UnitFramesPlusDB["party"]["hideraid"] == 1 and UnitFramesPlusDB["party"]["always"] ~= 1))) then
        if parent == nil or parent == "UIParent" then
            for id = 1, MAX_PARTY_MEMBERS, 1 do
                _G["PartyMemberFrame"..id]:SetParent(UFPHider);
            end
            -- PartyMemberBackground:SetParent(UFPHider);
        end
    else
        if parent == "UFPHider" then
            for id = 1, MAX_PARTY_MEMBERS, 1 do
                _G["PartyMemberFrame"..id]:SetParent(UIParent);
            end
            -- PartyMemberBackground:SetParent(UIParent);
        end
    end

    local pparent = _G["PartyMemberFrame"..id.."PetFrame"]:GetParent():GetName();
    if UnitFramesPlusDB["party"]["origin"] ~= 1 or GetDisplayedAllyFrames() == nil or (GetDisplayedAllyFrames() == "raid" and (UnitFramesPlusDB["party"]["hideraid"] ~= 1 or (UnitFramesPlusDB["party"]["hideraid"] == 1 and UnitFramesPlusDB["party"]["always"] ~= 1))) or UnitFramesPlusDB["party"]["pet"] ~= 1 then
        if pparent == nil or pparent == "PartyMemberFrame"..id then
            for id = 1, MAX_PARTY_MEMBERS, 1 do
                _G["PartyMemberFrame"..id.."PetFrame"]:SetParent(UFPHider);
            end
        end
    else
        if pparent == "UFPHider" then
            for id = 1, MAX_PARTY_MEMBERS, 1 do
                _G["PartyMemberFrame"..id.."PetFrame"]:SetParent(_G["PartyMemberFrame"..id]);
            end
        end
    end

    RaidOptionsFrame_UpdatePartyFrames();
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        UnitFramesPlus_PartyMemberFrame_UpdateMember(_G["PartyMemberFrame"..id]);
    end
end

function UnitFramesPlus_PartyShowHide()
    if not InCombatLockdown() then
        UnitFramesPlus_PartyShowHideSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PartyShowHideSet";
        func.callback = function()
            UnitFramesPlus_PartyShowHideSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

local updateneeded = 0;
function UnitFramesPlus_CombatCheck()
    if InCombatLockdown() then return true end

    local id;
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        if ( UnitExists("party"..id) ) then
            if UnitInParty("party"..id) and UnitAffectingCombat("party"..id) then
                return true;
            end
        end
    end

    return false;
end

-- -- Interface/AddOns/Blizzard_CompactRaidFrames/Blizzard_CompactRaidFrameManager.lua
-- local _CompactRaidFrameManager_UpdateContainerLockVisibility = CompactRaidFrameManager_UpdateContainerLockVisibility
-- function UnitFramesPlus_CompactRaidFrameManager_UpdateContainerLockVisibility(self)
--     local combat = UnitFramesPlus_CombatCheck();
--     if combat == false then
--         if ( GetDisplayedAllyFrames() ~= "raid" or not CompactRaidFrameManagerDisplayFrameLockedModeToggle.lockMode ) then
--             CompactRaidFrameManager_LockContainer(self);
--         else
--             CompactRaidFrameManager_UnlockContainer(self);
--         end
--     else
--         updateneeded = 1;
--     end
-- end

-- -- Interface/AddOns/Blizzard_CompactRaidFrames/Blizzard_CompactRaidFrameManager.lua
-- local _CompactRaidFrameManager_UpdateShown = CompactRaidFrameManager_UpdateShown
-- function UnitFramesPlus_CompactRaidFrameManager_UpdateShown(self)
--     local combat = UnitFramesPlus_CombatCheck();
--     if combat == false then
--         if ( GetDisplayedAllyFrames() ) then
--             self:Show();
--         else
--             self:Hide();
--         end
--         CompactRaidFrameManager_UpdateOptionsFlowContainer(self);
--         CompactRaidFrameManager_UpdateContainerVisibility();
--     else
--         updateneeded = 1;
--     end
-- end

-- Interface/FrameXML/RaidFrame.lua
local _RaidOptionsFrame_UpdatePartyFrames = RaidOptionsFrame_UpdatePartyFrames;
function UnitFramesPlus_RaidOptionsFrame_UpdatePartyFrames()
    if GetDisplayedAllyFrames() == nil or (GetDisplayedAllyFrames() == "raid" and (UnitFramesPlusDB["party"]["hideraid"] ~= 1 or (UnitFramesPlusDB["party"]["hideraid"] == 1 and UnitFramesPlusDB["party"]["always"] ~= 1))) then
        HidePartyFrame();
    else
        HidePartyFrame();
        ShowPartyFrame();
    end
    UpdatePartyMemberBackground();
end

-- Interface/FrameXML/PartyMemberFrame.lua
-- local _HidePartyFrame = HidePartyFrame;
-- function UnitFramesPlus_HidePartyFrame()
--     local combat = UnitFramesPlus_CombatCheck();
--     if combat == false then
--         for i=1, MAX_PARTY_MEMBERS, 1 do
--             _G["PartyMemberFrame"..i]:Hide();
--         end
--     else
--         updateneeded = 1;
--     end
-- end

-- Interface/FrameXML/PartyMemberFrame.lua
-- local _ShowPartyFrame = ShowPartyFrame;
-- function UnitFramesPlus_ShowPartyFrame()
--     local combat = UnitFramesPlus_CombatCheck();
--     if combat == false then
--         for i=1, MAX_PARTY_MEMBERS, 1 do
--             if ( UnitExists("party"..i) ) then
--                 _G["PartyMemberFrame"..i]:Show();
--             end
--         end
--     else
--         updateneeded = 1;
--     end
-- end

-- Interface/FrameXML/PartyMemberFrame.lua
local _PartyMemberFrame_UpdatePet = PartyMemberFrame_UpdatePet;
function UnitFramesPlus_PartyMemberFrame_UpdatePet(self, id)
    if ( not id ) then
        id = self:GetID();
    end

    local frameName = "PartyMemberFrame"..id;
    local petFrame = _G["PartyMemberFrame"..id.."PetFrame"];

    if ( UnitIsConnected("party"..id) and UnitExists("partypet"..id) and SHOW_PARTY_PETS == "1" and SHOW_PARTY_PETS == "1" ) then
        petFrame:Show();
        -- petFrame:SetPoint("TOPLEFT", frameName, "TOPLEFT", 23, -43);
    else
        petFrame:Hide();
        -- petFrame:SetPoint("TOPLEFT", frameName, "TOPLEFT", 23, -27);
    end

    PartyMemberFrame_RefreshPetDebuffs(self, id);
    UpdatePartyMemberBackground();
end

local _PartyMemberFrame_UpdateMember = PartyMemberFrame_UpdateMember;
function UnitFramesPlus_PartyMemberFrame_UpdateMember(self)
    if GetDisplayedAllyFrames() == nil or ( GetDisplayedAllyFrames() == "raid" and (UnitFramesPlusDB["party"]["hideraid"] ~= 1 or (UnitFramesPlusDB["party"]["hideraid"] == 1 and UnitFramesPlusDB["party"]["always"] ~= 1 ))) then
        self:Hide();
        UpdatePartyMemberBackground();
        return;
    end
    local id = self:GetID();
    local unit = "party"..id;
    if ( UnitExists(unit) ) then
        self:Show();

        if VoiceActivityManager then
            local guid = UnitGUID(unit);
            VoiceActivityManager:RegisterFrameForVoiceActivityNotifications(self, guid, nil, "VoiceActivityNotificationPartyTemplate", "Button", PartyMemberFrame_VoiceActivityNotificationCreatedCallback);
        end

        UnitFrame_Update(self, true);
    else
        if VoiceActivityManager then
            VoiceActivityManager:UnregisterFrameForVoiceActivityNotifications(self);
            self.voiceNotification = nil;
        end
        self:Hide();
    end
    PartyMemberFrame_UpdatePet(self);
    PartyMemberFrame_UpdateLeader(self);
    PartyMemberFrame_UpdatePvPStatus(self);
    RefreshDebuffs(self, "party"..id, nil, nil, true);
    PartyMemberFrame_UpdateVoiceStatus(self);
    PartyMemberFrame_UpdateReadyCheck(self);
    PartyMemberFrame_UpdateOnlineStatus(self);
    PartyMemberFrame_UpdateNotPresentIcon(self);
    UpdatePartyMemberBackground();
end

local _PartyMemberFrame_UpdateArt = PartyMemberFrame_UpdateArt;
function UnitFramesPlus_PartyMemberFrame_UpdateArt(self)
    local combat = UnitFramesPlus_CombatCheck();
    if combat == false then
        local unit = "party"..self:GetID();
        PartyMemberFrame_ToPlayerArt(self);
    else
        updateneeded = 1;
    end
end

local _PartyMemberFrame_UpdateOnlineStatus = PartyMemberFrame_UpdateOnlineStatus;
function UnitFramesPlus_PartyMemberFrame_UpdateOnlineStatus(self)
    if ( UnitExists("party"..self:GetID()) and not UnitIsConnected("party"..self:GetID()) ) then
        -- Handle disconnected state
        local selfName = self:GetName();
        local healthBar = _G[selfName.."HealthBar"];
        local unitHPMin, unitHPMax = healthBar:GetMinMaxValues();

        healthBar:SetValue(unitHPMax);
        healthBar:SetStatusBarColor(0.5, 0.5, 0.5);
        SetDesaturation(_G[selfName.."Portrait"], true);
        _G[selfName.."Disconnect"]:Show();
        _G[selfName.."PetFrame"]:Hide();
        return;
    else
        local selfName = self:GetName();
        SetDesaturation(_G[selfName.."Portrait"], false);
        _G[selfName.."Disconnect"]:Hide();
    end
end

function UnitFramesPlus_ShowPartyFrameSet()
    PartyMemberFrame_UpdateMember = UnitFramesPlus_PartyMemberFrame_UpdateMember;
    -- -- CompactRaidFrameManager_UpdateContainerLockVisibility = UnitFramesPlus_CompactRaidFrameManager_UpdateContainerLockVisibility;
    -- -- CompactRaidFrameManager_UpdateShown = UnitFramesPlus_CompactRaidFrameManager_UpdateShown;
    RaidOptionsFrame_UpdatePartyFrames = UnitFramesPlus_RaidOptionsFrame_UpdatePartyFrames;
    -- HidePartyFrame = UnitFramesPlus_HidePartyFrame;
    -- ShowPartyFrame = UnitFramesPlus_ShowPartyFrame;
    PartyMemberFrame_UpdateArt = UnitFramesPlus_PartyMemberFrame_UpdateArt;
    PartyMemberFrame_UpdateOnlineStatus = UnitFramesPlus_PartyMemberFrame_UpdateOnlineStatus;
    PartyMemberFrame_UpdatePet = UnitFramesPlus_PartyMemberFrame_UpdatePet;
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        _G["PartyMemberFrame"..id]:Show();
        _G["PartyMemberFrame"..id].Show = function(self)
            local id = self:GetID();
            _G["PartyMemberFrame"..id.."Texture"]:SetAlpha(1);
            _G["PartyMemberFrame"..id.."Name"]:SetAlpha(1);
            _G["PartyMemberFrame"..id.."HealthBar"]:SetAlpha(1);
            _G["PartyMemberFrame"..id.."ManaBar"]:SetAlpha(1);
            if _G["PartyMemberFrame"..id.."Portrait"]:GetAlpha() == 0 then
                _G["PartyMemberFrame"..id.."Portrait"]:SetAlpha(1);
            end
            local alpha = UnitInOtherParty("party"..id) and 0.6 or 1;
            _G["PartyMemberFrame"..id]:SetAlpha(alpha);
            _G["UFP_Party3DPortrait"..id]:SetAlpha(1);
            _G["UFP_PartyClassPortrait"..id]:SetAlpha(1);
            if ( UnitExists("partypet"..id) and UnitFramesPlusDB["party"]["pet"] == 1 ) then
                _G["PartyMemberFrame"..id.."PetFrame"]:SetAlpha(alpha);
            end
        end
        _G["PartyMemberFrame"..id].Hide = function(self)
            local id = self:GetID();
            _G["PartyMemberFrame"..id.."Flash"]:Hide();
            _G["PartyMemberFrame"..id.."VehicleTexture"]:Hide();
            _G["PartyMemberFrame"..id.."Status"]:Hide();
            _G["PartyMemberFrame"..id.."LeaderIcon"]:Hide();
            _G["PartyMemberFrame"..id.."MasterIcon"]:Hide();
            _G["PartyMemberFrame"..id.."GuideIcon"]:Hide();
            _G["PartyMemberFrame"..id.."PVPIcon"]:Hide();
            _G["PartyMemberFrame"..id.."Disconnect"]:Hide();
            _G["PartyMemberFrame"..id.."ReadyCheck"]:Hide();
            _G["PartyMemberFrame"..id.."NotPresentIcon"]:Hide();
            _G["PartyMemberFrame"..id.."Background"]:SetAlpha(0);
            _G["PartyMemberFrame"..id.."Texture"]:SetAlpha(0);
            _G["PartyMemberFrame"..id.."Name"]:SetAlpha(0);
            _G["PartyMemberFrame"..id.."HealthBar"]:SetAlpha(0);
            _G["PartyMemberFrame"..id.."ManaBar"]:SetAlpha(0);
            _G["PartyMemberFrame"..id.."Portrait"]:SetAlpha(0);
            _G["PartyMemberFrame"..id]:SetAlpha(0);
            _G["UFP_Party3DPortrait"..id]:SetAlpha(0);
            _G["UFP_PartyClassPortrait"..id]:SetAlpha(0);
            if ( not UnitExists("partypet"..id) or UnitFramesPlusDB["party"]["pet"] ~= 1 ) then
                _G["PartyMemberFrame"..id.."PetFrame"]:SetAlpha(0);
            end
        end
        _G["PartyMemberFrame"..id]:Hide();

        _G["PartyMemberFrame"..id.."PetFrame"]:Show();
        _G["PartyMemberFrame"..id.."PetFrame"].Show = function(self) 
            if ( UnitExists("partypet"..id) and UnitFramesPlusDB["party"]["pet"] == 1 ) then
                local alpha = UnitInOtherParty("party"..id) and 0.6 or 1;
                _G["PartyMemberFrame"..id.."PetFrame"]:SetAlpha(alpha);
            end
        end
        _G["PartyMemberFrame"..id.."PetFrame"].Hide = function(self) self:SetAlpha(0) end
        _G["PartyMemberFrame"..id.."PetFrame"]:Hide();
    end

    -- PartyMemberBackground:Show();
    -- PartyMemberBackground.Show = function(self) self:SetAlpha(1) end
    -- PartyMemberBackground.Hide = function(self) self:SetAlpha(0) end
    -- PartyMemberBackground:Hide();
    PartyMemberBackground:Hide();
    PartyMemberBackground.Show = function() end
    PartyMemberBackground.Hide = function() end
end

function UnitFramesPlus_ShowPartyFrame()
    if not InCombatLockdown() then
        UnitFramesPlus_ShowPartyFrameSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_ShowPartyFrameSet";
        func.callback = function()
            UnitFramesPlus_ShowPartyFrameSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

function UnitFramesPlus_PartyStyleSet()
    UnitFramesPlus_PartyCvar();
    UnitFramesPlus_PartyInit();
    UnitFramesPlus_PartyTargetInit();
    UnitFramesPlus_PartyTargetLayout();
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        UnitFramesPlus_PartyLevelDisplayUpdate(id);
        UnitFramesPlus_PartyNameDisplayUpdate(id);
        UnitFramesPlus_PartyColorHPBarDisplayUpdate(id);
        UnitFramesPlus_PartyPortrait3DBGDisplayUpdate(id);
        UnitFramesPlus_PartyPortraitDisplayUpdate(id);
        UnitFramesPlus_PartyHealthPctDisplayUpdate(id);
        UnitFramesPlus_PartyPowerDisplayUpdate(id);
    end
    -- UnitFramesPlus_PartyOfflineDetectionDisplayUpdate();
    UnitFramesPlus_OptionsFrame_PartyBuffDisplayUpdate();
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        UnitFramesPlus_PartyTargetDisplayUpdate(id);
        UnitFramesPlus_PartyTargetClassPortraitDisplayUpdate(id);
    end
    if UnitFramesPlusDB["partytarget"]["enemycheck"] ~= 1 then
        for id = 1, MAX_PARTY_MEMBERS, 1 do
            _G["UFP_PartyTarget"..id].Highlight:SetAlpha(0);
        end
    end
    UnitFramesPlus_OptionsFrame_PartyTargetDebuffDisplayUpdate();

    UnitFramesPlus_PartyShowHide();

    local state = IsAddOnLoaded("Blizzard_CompactRaidFrames");
    if state == true then
        RaidOptionsFrame_UpdatePartyFrames();
        CompactRaidFrameManager_UpdateContainerLockVisibility(CompactRaidFrameManager);
        CompactRaidFrameManager_UpdateShown(CompactRaidFrameManager);
    end
end

function UnitFramesPlus_PartyStyle()
    if not InCombatLockdown() then
        UnitFramesPlus_PartyStyleSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_PartyStyleSet";
        func.callback = function()
            UnitFramesPlus_PartyStyleSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

local up = CreateFrame("Frame");
up:RegisterEvent("PLAYER_REGEN_ENABLED");
up:RegisterEvent("PLAYER_ENTERING_WORLD");
up:RegisterEvent("GROUP_ROSTER_UPDATE");
up:RegisterEvent("UPDATE_ACTIVE_BATTLEFIELD");
up:RegisterEvent("VARIABLES_LOADED");
up:RegisterEvent("CVAR_UPDATE");
up:SetScript("OnEvent", function(self, event, ...)
    -- if UnitFramesPlusDB["party"]["hideraid"] == 1 and UnitFramesPlusDB["party"]["always"] == 1 then
        if event == "PLAYER_REGEN_ENABLED" then
            if updateneeded == 1 then
                for id = 1, MAX_PARTY_MEMBERS, 1 do
                    PartyMemberFrame_UpdateMember(_G["PartyMemberFrame"..id]);
                end
                updateneeded = 0;
            end
        elseif event == "PLAYER_ENTERING_WORLD" then
            for id = 1, MAX_PARTY_MEMBERS, 1 do
                PartyMemberFrame_UpdateMember(_G["PartyMemberFrame"..id]);
            end
        elseif event == "GROUP_ROSTER_UPDATE" or event == "UPDATE_ACTIVE_BATTLEFIELD" or event == "VARIABLES_LOADED" then
            UnitFramesPlus_PartyShowHide();
        elseif event == "CVAR_UPDATE" then
            local cvarname, value = ...;
            if cvarname == "USE_RAID_STYLE_PARTY_FRAMES" then
                if (tonumber(GetCVar("useCompactPartyFrames")) == 1 and UnitFramesPlusDB["party"]["origin"] == 1) 
                    or (tonumber(GetCVar("useCompactPartyFrames")) ~= 1 and UnitFramesPlusDB["party"]["origin"] ~= 1) then
                    UnitFramesPlusDB["party"]["origin"] = 1 - tonumber(GetCVar("useCompactPartyFrames"));

                    UnitFramesPlus_PartyStyle();
                    for id = 1, MAX_PARTY_MEMBERS, 1 do
                        PartyMemberFrame_UpdateMember(_G["PartyMemberFrame"..id]);
                    end

                    if IsAddOnLoaded("UnitFramesPlus_Options") then
                        UnitFramesPlus_OptionsFrame_PartyOrigin:SetChecked(UnitFramesPlusDB["party"]["origin"]==1);
                        UnitFramesPlus_OptionsFrame_PartyTargetOrigin:SetChecked(UnitFramesPlusDB["party"]["origin"]==1);
                        if UnitFramesPlusDB["party"]["origin"] ~= 1 then
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPet);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyHP);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyHPPct);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyColorName);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyShortName);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyLevel);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortraitType);
                            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
                            -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyOfflineDetection);
                            -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyDeathGhost);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuff);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuffFilter);
                            UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PartyBuffFilterType);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuffCooldown);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuffHidetip);
                            -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyCastbar);
                            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyScaleSlider);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBartext);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyHPMPUnit);
                            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyMouseShow);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyShiftDrag);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortraitIndicator);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyColorHP);
                            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTarget);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetLite);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHPPct);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorName);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetShortName);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetDebuff);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetDebuffCooldown);
                            -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHighlight);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
                            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
                            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider);
                        else
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPet);
                            UnitFramesPlus_OptionsFrame_PartyPetText:SetTextColor(1, 1, 1);
                            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider);
                            UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSliderText:SetTextColor(1, 1, 1);
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyHP);
                            UnitFramesPlus_OptionsFrame_PartyHPText:SetTextColor(1, 1, 1);
                            if UnitFramesPlusDB["party"]["hp"] == 1 then
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyHPPct);
                                UnitFramesPlus_OptionsFrame_PartyHPPctText:SetTextColor(1, 1, 1);
                            end
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyColorName);
                            UnitFramesPlus_OptionsFrame_PartyColorNameText:SetTextColor(1, 1, 1);
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyShortName);
                            UnitFramesPlus_OptionsFrame_PartyShortNameText:SetTextColor(1, 1, 1);
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyLevel);
                            UnitFramesPlus_OptionsFrame_PartyLevelText:SetTextColor(1, 1, 1);
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortraitType);
                            UnitFramesPlus_OptionsFrame_PartyPortraitTypeText:SetTextColor(1, 1, 1);
                            if UnitFramesPlusDB["party"]["portrait"] == 1 then
                                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider);
                                if UnitFramesPlusDB["party"]["portraittype"] ~= 2 then
                                    BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
                                    UnitFramesPlus_OptionsFrame_PartyPortrait3DBGText:SetTextColor(1, 1, 1);
                                end
                            end
                            -- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyOfflineDetection);
                            -- UnitFramesPlus_OptionsFrame_PartyOfflineDetectionText:SetTextColor(1, 1, 1);
                            -- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyDeathGhost);
                            -- UnitFramesPlus_OptionsFrame_PartyDeathGhostText:SetTextColor(1, 1, 1);
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuff);
                            UnitFramesPlus_OptionsFrame_PartyBuffText:SetTextColor(1, 1, 1);
                            if UnitFramesPlusDB["party"]["buff"] == 1 then
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuffFilter);
                                UnitFramesPlus_OptionsFrame_PartyBuffFilterText:SetTextColor(1, 1, 1);
                                if UnitFramesPlusDB["party"]["filter"] == 1 then
                                    UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_PartyBuffFilterType);
                                end
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuffCooldown);
                                UnitFramesPlus_OptionsFrame_PartyBuffCooldownText:SetTextColor(1, 1, 1);
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuffHidetip);
                                UnitFramesPlus_OptionsFrame_PartyBuffHidetipText:SetTextColor(1, 1, 1);
                            end
                            -- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyCastbar);
                            -- UnitFramesPlus_OptionsFrame_PartyCastbarText:SetTextColor(1, 1, 1);
                            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyScaleSlider);
                            UnitFramesPlus_OptionsFrame_PartyScaleSliderText:SetTextColor(1, 1, 1);
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBartext);
                            UnitFramesPlus_OptionsFrame_PartyBartextText:SetTextColor(1, 1, 1);
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyHPMPUnit);
                            UnitFramesPlus_OptionsFrame_PartyHPMPUnitText:SetTextColor(1, 1, 1);
                            if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
                                UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:SetValue(UnitFramesPlusDB["party"]["unittype"]);
                                if UnitFramesPlusDB["party"]["hpmpunit"] == 1 then
                                    BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider);
                                end
                            end
                            if UnitFramesPlusDB["party"]["bartext"] == 1 then
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyMouseShow);
                                UnitFramesPlus_OptionsFrame_PartyMouseShowText:SetTextColor(1, 1, 1);
                            end
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyShiftDrag);
                            UnitFramesPlus_OptionsFrame_PartyShiftDragText:SetTextColor(1, 1, 1);
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortraitIndicator);
                            UnitFramesPlus_OptionsFrame_PartyPortraitIndicatorText:SetTextColor(1, 1, 1);
                            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyColorHP);
                            UnitFramesPlus_OptionsFrame_PartyColorHPText:SetTextColor(1, 1, 1);
                            if UnitFramesPlusDB["party"]["colorhp"] == 1 then
                                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
                            end
                            if UnitFramesPlusDB["partytarget"]["show"] == 1 then
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTarget);
                                UnitFramesPlus_OptionsFrame_PartyTargetText:SetTextColor(1, 1, 1);
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetLite);
                                UnitFramesPlus_OptionsFrame_PartyTargetLiteText:SetTextColor(1, 1, 1);
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetHPPct);
                                UnitFramesPlus_OptionsFrame_PartyTargetHPPctText:SetTextColor(1, 1, 1);
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck);
                                UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheckText:SetTextColor(1, 1, 1);
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetColorName);
                                UnitFramesPlus_OptionsFrame_PartyTargetColorNameText:SetTextColor(1, 1, 1);
                                if UnitFramesPlusDB["partytarget"]["colorname"] == 1 then
                                    BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
                                    UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNoText:SetTextColor(1, 1, 1);
                                end
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetShortName);
                                UnitFramesPlus_OptionsFrame_PartyTargetShortNameText:SetTextColor(1, 1, 1);
                                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetDebuff);
                                UnitFramesPlus_OptionsFrame_PartyTargetDebuffText:SetTextColor(1, 1, 1);
                                if UnitFramesPlusDB["partytarget"]["debuff"] == 1 then
                                    BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetDebuffCooldown);
                                    UnitFramesPlus_OptionsFrame_PartyTargetDebuffCooldownText:SetTextColor(1, 1, 1);
                                end
                                -- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetHighlight);
                                -- UnitFramesPlus_OptionsFrame_PartyTargetHighlightText:SetTextColor(1, 1, 1);
                                if UnitFramesPlusDB["partytarget"]["lite"] ~= 1 then
                                    BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
                                    UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitText:SetTextColor(1, 1, 1);
                                    if UnitFramesPlusDB["partytarget"]["portrait"] == 1 then
                                        BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
                                        UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNoText:SetTextColor(1, 1, 1);
                                    end
                                end
                            end

                            -- StaticPopup_Show("UFP_RELOADUI");
                        end
                    end
                end
            end
        end
    -- end
end)

-- hooksecurefunc("PartyMemberFrame_UpdateMember", function(self)
--     -- if UnitFramesPlusDB["party"]["hideraid"] == 1 and UnitFramesPlusDB["party"]["always"] == 1 then
--         local id = self:GetID();
--         if ( GetDisplayedAllyFrames() == "party" and UnitExists("party"..id) ) then
--             _G["PartyMemberFrame"..id.."Texture"]:SetAlpha(1);
--             _G["PartyMemberFrame"..id.."Name"]:SetAlpha(1);
--             _G["PartyMemberFrame"..id.."HealthBar"]:SetAlpha(1);
--             _G["PartyMemberFrame"..id.."ManaBar"]:SetAlpha(1);
--             if _G["PartyMemberFrame"..id.."Portrait"]:GetAlpha() == 0 then
--                 _G["PartyMemberFrame"..id.."Portrait"]:SetAlpha(1);
--             end
--             if _G["PartyMemberFrame"..id]:GetAlpha() == 0 then
--                 _G["PartyMemberFrame"..id]:SetAlpha(1);
--             end
--         else
--             _G["PartyMemberFrame"..id.."Flash"]:Hide();
--             _G["PartyMemberFrame"..id.."VehicleTexture"]:Hide();
--             _G["PartyMemberFrame"..id.."Status"]:Hide();
--             _G["PartyMemberFrame"..id.."LeaderIcon"]:Hide();
--             _G["PartyMemberFrame"..id.."MasterIcon"]:Hide();
--             _G["PartyMemberFrame"..id.."GuideIcon"]:Hide();
--             _G["PartyMemberFrame"..id.."PVPIcon"]:Hide();
--             _G["PartyMemberFrame"..id.."Disconnect"]:Hide();
--             _G["PartyMemberFrame"..id.."ReadyCheck"]:Hide();
--             _G["PartyMemberFrame"..id.."NotPresentIcon"]:Hide();
--             _G["PartyMemberFrame"..id.."Background"]:SetAlpha(0);
--             _G["PartyMemberFrame"..id.."Texture"]:SetAlpha(0);
--             _G["PartyMemberFrame"..id.."Name"]:SetAlpha(0);
--             _G["PartyMemberFrame"..id.."HealthBar"]:SetAlpha(0);
--             _G["PartyMemberFrame"..id.."ManaBar"]:SetAlpha(0);
--             _G["PartyMemberFrame"..id.."Portrait"]:SetAlpha(0);
--             _G["PartyMemberFrame"..id]:SetAlpha(0);
--         end
--         if ( UnitExists("partypet"..id) and UnitFramesPlusDB["party"]["pet"] == 1 ) then
--             _G["PartyMemberFrame"..id.."PetFrame"]:SetAlpha(1);
--         else
--             _G["PartyMemberFrame"..id.."PetFrame"]:SetAlpha(0);
--         end
--     -- end
-- end);

hooksecurefunc("PartyMemberHealthCheck", function(self, value)
    -- if UnitFramesPlusDB["party"]["hideraid"] == 1 and UnitFramesPlusDB["party"]["always"] == 1 then
        local id = self:GetParent():GetID();
        if not UnitExists("party"..id) or GetDisplayedAllyFrames() == nil or (GetDisplayedAllyFrames() == "raid" and (UnitFramesPlusDB["party"]["hideraid"] ~= 1 or (UnitFramesPlusDB["party"]["hideraid"] == 1 and UnitFramesPlusDB["party"]["always"] ~= 1))) then
            _G["PartyMemberFrame"..id.."Portrait"]:SetAlpha(0);
        end
    -- end
end)

local sf;
StaticPopupDialogs["UFP_HIDERAIDFRAME"] = {
    text = UFPLocal_HideRaid,
    button1 = OKAY,
    button2 = CANCEL,
    OnAccept = function()
        sf("Blizzard_CompactRaidFrames");
        sf("Blizzard_CUFProfiles");
        ReloadUI();
    end,
    OnCancel = function()
        UnitFramesPlusDB["party"]["hideraid"] = 1 - UnitFramesPlusDB["party"]["hideraid"];
        if IsAddOnLoaded("UnitFramesPlus_Options") then
            _G["UnitFramesPlus_OptionsFrame_PartyHideRaid"]:SetChecked(UnitFramesPlusDB["party"]["hideraid"]==1);
            if UnitFramesPlusDB["party"]["hideraid"] == 1 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyInRaid);
                UnitFramesPlus_OptionsFrame_PartyInRaidText:SetTextColor(1, 1, 1);
            else
                BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyInRaid);
            end
        end
    end,
    whileDead = 1, hideOnEscape = 1, showAlert = 1
}
function UnitFramesPlus_HideRaidFrameSet()
    local state = IsAddOnLoaded("Blizzard_CompactRaidFrames");
    if UnitFramesPlusDB["party"]["hideraid"] == 1 then
        sf = DisableAddOn;
        if state == true then
            StaticPopup_Show("UFP_HIDERAIDFRAME");
        end
    else
        sf = EnableAddOn;
        if state == false then
            StaticPopup_Show("UFP_HIDERAIDFRAME");
        end
    end
end

function UnitFramesPlus_HideRaidFrame()
    if not InCombatLockdown() then
        UnitFramesPlus_HideRaidFrameSet();
    else
        local func = {};
        func.name = "UnitFramesPlus_HideRaidFrameSet";
        func.callback = function()
            UnitFramesPlus_HideRaidFrameSet();
        end;
        UnitFramesPlus_WaitforCall(func);
    end
end

function UnitFramesPlus_PartyExtraTextFontSize()
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        _G["PartyMemberFrame"..id.."HealthBarText"]:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["party"]["fontsize"], "OUTLINE");
        _G["PartyMemberFrame"..id.."ManaBarText"]:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["party"]["fontsize"], "OUTLINE");
        _G["PartyMemberFrame"..id.."Level"]:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["party"]["fontsize"], "OUTLINE");
        _G["PartyMemberFrame"..id.."HPPct"]:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["party"]["fontsize"], "OUTLINE");
        -- _G["PartyMemberFrame"..id.."DeathText"]:SetFont(GameFontNormal:GetFont(), UnitFramesPlusDB["party"]["fontsize"]+2, "OUTLINE");

        _G["PartyMemberFrame"..id.."Name"]:SetFont(GameFontNormalSmall:GetFont(), UnitFramesPlusDB["party"]["fontsize"]+2);
    end
end

function UnitFramesPlus_PartyMemberFrameFix()
    for id = 1, MAX_PARTY_MEMBERS, 1 do
        _G["PartyMemberFrame"..id.."NotPresentIcon"]:SetFrameLevel(_G["PartyMemberFrame"..id]:GetFrameLevel()+2);
        _G["PartyMemberFrame"..id.."NotPresentIcon"]:ClearAllPoints();
        -- _G["PartyMemberFrame"..id.."NotPresentIcon"]:SetPoint("BOTTOMRIGHT", _G["PartyMemberFrame"..id.."Portrait"], "TOPLEFT", 12, -12);
        _G["PartyMemberFrame"..id.."NotPresentIcon"]:SetPoint("RIGHT", _G["PartyMemberFrame"..id.."Name"], "LEFT", 0, 0);
    end
end

--模块初始化
function UnitFramesPlus_PartyInit()
    UnitFramesPlus_ShowPartyFrame();
    UnitFramesPlus_PartyShowHide();
    UnitFramesPlus_PartyMemberFrameFix();
    UnitFramesPlus_PartyShiftDrag();
    -- UnitFramesPlus_PartyOfflineDetection();
    UnitFramesPlus_PartyPortrait();
    UnitFramesPlus_PartyPortraitIndicator();
    UnitFramesPlus_PartyBuff();
    -- UnitFramesPlus_PartyColorHPBar();
    UnitFramesPlus_PartyName();
    UnitFramesPlus_PartyLevel();
    UnitFramesPlus_PartyHealthPct();
    UnitFramesPlus_PartyBarTextMouseShow();
    UnitFramesPlus_PartyExtraTextFontSize();
    -- UnitFramesPlus_HideRaidFrame();
    UnitFramesPlus_PartyPosition();
    UnitFramesPlus_PartyPet();
    UnitFramesPlus_PartyScale();
end

function UnitFramesPlus_PartyCvar()
    UnitFramesPlus_PartyOrigin();
end
