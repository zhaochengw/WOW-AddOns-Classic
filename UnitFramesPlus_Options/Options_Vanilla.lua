--变量
local id = 1;
local _G = _G;
-- local rl = "";

-- 暴雪風格頭像也載入時隱藏一些重複的選項
local showOptions = true
if IsAddOnLoaded("EasyFrames") then
	showOptions = false
end

-- 重新定義暴雪遺棄的函數
local function BlizzardOptionsPanel_Slider_Disable(self)
	self:Disable()
	_G[self:GetName().."Text"]:SetTextColor(0.5, 0.5, 0.5);
end

local function BlizzardOptionsPanel_Slider_Enable(self)
	self:Enable()
	_G[self:GetName().."Text"]:SetTextColor(1, 0.82, 0);
end

local function BlizzardOptionsPanel_CheckButton_Disable(self)
	self:Disable()
	_G[self:GetName().."Text"]:SetTextColor(0.5, 0.5, 0.5);
end

local function BlizzardOptionsPanel_CheckButton_Enable(self)
	self:Enable()
	_G[self:GetName().."Text"]:SetTextColor(1, 0.82, 0);
end

--设置面板
UnitFramesPlus_OptionsFrame = CreateFrame("Frame", "UnitFramesPlus_OptionsFrame", UIParent);
UnitFramesPlus_OptionsFrame.name = UFP_OP_Name;
local category = Settings.RegisterCanvasLayoutCategory(UnitFramesPlus_OptionsFrame, UnitFramesPlus_OptionsFrame.name)
category.ID = UnitFramesPlus_OptionsFrame.name
Settings.RegisterAddOnCategory(category)

UnitFramesPlus_OptionsFrame:SetScript("OnShow", function()
    UnitFramesPlus_OptionPanel_OnShow();
end)

--边框类型下拉菜单
local PlayerDragonBorderTypeDropDown = {UFP_OP_Player_Elite, UFP_OP_Player_RareElite, UFP_OP_Player_Rare};
local function PlayerDragonBorderType_OnClick(self)
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_PlayerDragonBorderType, self:GetID());
    UnitFramesPlusDB["player"]["bordertype"] = self:GetID();
    UnitFramesPlus_PlayerDragon();
end
local function PlayerDragonBorderType_Init()
    local info, text, func;
    for id = 1, #PlayerDragonBorderTypeDropDown, 1 do
        info = {
            text = PlayerDragonBorderTypeDropDown[id];
            func = PlayerDragonBorderType_OnClick;
        };
        UIDropDownMenu_AddButton(info);
    end
end

--玩家生命值/法力值/百分比下拉菜单
local PlayerHPMPPctDropDown = {UFP_OP_Player_NumCur, UFP_OP_Player_NumMax, UFP_OP_Player_NumLoss, UFP_OP_Player_Pct, UFP_OP_Player_None};
local function PlayerHPMPPctPartOne_OnClick(self)
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne, self:GetID());
    UnitFramesPlusDB["player"]["hpmppartone"] = self:GetID();
    UnitFramesPlus_PlayerHPValueDisplayUpdate();
    UnitFramesPlus_PlayerMPValueDisplayUpdate();
end
local function PlayerHPMPPctPartOne_Init()
    local info, text, func;
    for id = 1, #PlayerHPMPPctDropDown, 1 do
        info = {
            text = PlayerHPMPPctDropDown[id];
            func = PlayerHPMPPctPartOne_OnClick;
        };
        UIDropDownMenu_AddButton(info);
    end
end
local function PlayerHPMPPctPartTwo_OnClick(self)
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo, self:GetID());
    UnitFramesPlusDB["player"]["hpmpparttwo"] = self:GetID();
    UnitFramesPlus_PlayerHPValueDisplayUpdate();
    UnitFramesPlus_PlayerMPValueDisplayUpdate();
end
local function PlayerHPMPPctPartTwo_Init()
    local info, text, func;
    for id = 1, #PlayerHPMPPctDropDown, 1 do
        info = {
            text = PlayerHPMPPctDropDown[id];
            func = PlayerHPMPPctPartTwo_OnClick;
        };
        UIDropDownMenu_AddButton(info);
    end
end

--目标生命值/法力值/百分比下拉菜单
local TargetHPMPPctDropDown = {UFP_OP_Player_NumCur, UFP_OP_Player_NumMax, UFP_OP_Player_NumLoss, UFP_OP_Player_Pct, UFP_OP_Player_None};
local function TargetHPMPPctPartOne_OnClick(self)
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne, self:GetID());
    UnitFramesPlusDB["target"]["hpmppartone"] = self:GetID();
    UnitFramesPlus_TargetHPValueDisplayUpdate();
    UnitFramesPlus_TargetMPValueDisplayUpdate();
end
local function TargetHPMPPctPartOne_Init()
    local info, text, func;
    for id = 1, #TargetHPMPPctDropDown, 1 do
        info = {
            text = TargetHPMPPctDropDown[id];
            func = TargetHPMPPctPartOne_OnClick;
        };
        UIDropDownMenu_AddButton(info);
    end
end
local function TargetHPMPPctPartTwo_OnClick(self)
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo, self:GetID());
    UnitFramesPlusDB["target"]["hpmpparttwo"] = self:GetID();
    UnitFramesPlus_TargetHPValueDisplayUpdate();
    UnitFramesPlus_TargetMPValueDisplayUpdate();
    UnitFramesPlus_TargetPosition();
end
local function TargetHPMPPctPartTwo_Init()
    local info, text, func;
    for id = 1, #TargetHPMPPctDropDown, 1 do
        info = {
            text = TargetHPMPPctDropDown[id];
            func = TargetHPMPPctPartTwo_OnClick;
        };
        UIDropDownMenu_AddButton(info);
    end
end

--Party Buff过滤
local PartyBuffFilterTypeDropDown = {
    UFP_OP_FilterAll, 
    UFP_OP_FilterCancel1, 
    UFP_OP_FilterCancel2, 
    -- UFP_OP_FilterCaster1, 
    -- UFP_OP_FilterCaster2 
    -- _G[UFP_OP_FilterCaster1..", "..UFP_OP_FilterCancel1],
    -- _G[UFP_OP_FilterCaster1..", "..UFP_OP_FilterCancel2],
    -- UFP_OP_FilterCaster2, 
    -- _G[UFP_OP_FilterCaster2..", "..UFP_OP_FilterCancel1],
    -- _G[UFP_OP_FilterCaster2..", "..UFP_OP_FilterCancel2]
};
local function PartyBuffFilterType_OnClick(self)
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_PartyBuffFilterType, self:GetID());
    UnitFramesPlusDB["party"]["filtertype"] = self:GetID();
end
local function PartyBuffFilterType_Init()
    local info, text, func;
    for id = 1, #PartyBuffFilterTypeDropDown, 1 do
        info = {
            text = PartyBuffFilterTypeDropDown[id];
            func = PartyBuffFilterType_OnClick;
        };
        UIDropDownMenu_AddButton(info);
    end
end

StaticPopupDialogs["UFP_MOUSESHOW"] = {
    text = UFP_OP_Mouseshow_info,
    button1 = UFP_OP_Accept,
    button2 = UFP_OP_Cancel,
    OnAccept = function()
        -- InterfaceOptionsFrame:Hide();
        -- GameMenuButtonUIOptions:Click();
        -- InterfaceOptionsFrameCategoriesButton3:Click();
    end,
    timeout = 0,
    hideOnEscape = 1,
    exclusive = 1,
    whileDead = 1,
    preferredIndex = 3,
}

StaticPopupDialogs["UFP_RELOADUI"] = {
    text = UFP_OP_Reload_info,
    button1 = UFP_OP_Accept,
    button2 = UFP_OP_Cancel,
    OnAccept = function()
        ReloadUI();
    end,
    timeout = 0,
    hideOnEscape = 1,
    exclusive = 1,
    whileDead = 1,
    preferredIndex = 3,
}

do
    --插件介绍
    local info = UnitFramesPlus_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    info:ClearAllPoints();
    info:SetPoint("TOPLEFT", 16, -16);
    info:SetText(UFP_OP_Title.." v"..GetAddOnMetadata("UnitFramesPlus", "Version"));

    local infotext = UnitFramesPlus_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    infotext:ClearAllPoints();
    infotext:SetPoint("TOPLEFT", info, "TOPLEFT", 0, -40);
    infotext:SetText(UFP_OP_InfoText);

    local infotext2 = UnitFramesPlus_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    infotext2:ClearAllPoints();
    infotext2:SetPoint("TOPLEFT", infotext, "TOPLEFT", 0, -40);
    infotext2:SetText(UFP_OP_InfoText2);

    local infotext3 = UnitFramesPlus_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    infotext3:ClearAllPoints();
    infotext3:SetPoint("TOPLEFT", infotext2, "TOPLEFT", 0, -40);
    infotext3:SetText(UFP_OP_InfoText3);

--[[ 移除不再需要的說明文字
	local infotext4 = UnitFramesPlus_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    infotext4:ClearAllPoints();
    infotext4:SetPoint("TOPLEFT", infotext3, "TOPLEFT", 0, -40);
    infotext4:SetTextColor(1, 0.82, 0);
    infotext4:SetText(UFP_OP_InfoText4);

    local infotext5 = UnitFramesPlus_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    infotext5:ClearAllPoints();
    infotext5:SetPoint("TOPLEFT", infotext4, "TOPLEFT", 0, -40);
    infotext5:SetTextColor(1, 0.82, 0);
    infotext5:SetText(UFP_OP_InfoText5);

    local infotext6 = UnitFramesPlus_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    infotext6:ClearAllPoints();
    infotext6:SetPoint("TOPLEFT", infotext5, "TOPLEFT", 0, -40);
    infotext6:SetTextColor(1, 0.82, 0);
    infotext6:SetText(UFP_OP_InfoText6);
--]]
    if GetLocale() == "zhCN" then
        local infotext7 = UnitFramesPlus_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
        infotext7:ClearAllPoints();
        infotext7:SetPoint("TOPLEFT", infotext6, "TOPLEFT", 0, -40);
        infotext7:SetText("感谢支持：wow.isler.me");
    end
	
	-- UnitFramesPlus_OptionsFrame.name = UFP_OP_Name;

    --全局设置菜单
    local UnitFramesPlus_Global_Options = CreateFrame("Frame", "UnitFramesPlus_Global_Options", UIParent);
    UnitFramesPlus_Global_Options.name = UFP_OP_Global_Options;
    UnitFramesPlus_Global_Options.parent = UFP_OP_Name;
    UnitFramesPlus_Global_Options:Hide();
    category = Settings.GetCategory(UnitFramesPlus_Global_Options.parent)
	local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, UnitFramesPlus_Global_Options, UnitFramesPlus_Global_Options.name)

    --玩家设置菜单
    local UnitFramesPlus_Player_Options = CreateFrame("Frame", "UnitFramesPlus_Player_Options", UIParent);
    UnitFramesPlus_Player_Options.name = "├"..UFP_OP_Player_Options;
    UnitFramesPlus_Player_Options.parent = UFP_OP_Name;
    UnitFramesPlus_Player_Options:Hide();
    local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, UnitFramesPlus_Player_Options, UnitFramesPlus_Player_Options.name)

    --玩家宠物设置菜单
    local UnitFramesPlus_Pet_Options = CreateFrame("Frame", "UnitFramesPlus_Pet_Options", UIParent);
    UnitFramesPlus_Pet_Options.name = "├─"..UFP_OP_Pet_Options;
    UnitFramesPlus_Pet_Options.parent = UFP_OP_Name;
    UnitFramesPlus_Pet_Options:Hide();
    local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, UnitFramesPlus_Pet_Options, UnitFramesPlus_Pet_Options.name)

    --目标设置菜单
    local UnitFramesPlus_Target_Options = CreateFrame("Frame", "UnitFramesPlus_Target_Options", UIParent);
    UnitFramesPlus_Target_Options.name = "├"..UFP_OP_Target_Options;
    UnitFramesPlus_Target_Options.parent = UFP_OP_Name;
    UnitFramesPlus_Target_Options:Hide();
    local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, UnitFramesPlus_Target_Options, UnitFramesPlus_Target_Options.name)

    --目标的目标设置菜单
    local UnitFramesPlus_TargetTarget_Options = CreateFrame("Frame", "UnitFramesPlus_TargetTarget_Options", UIParent);
    UnitFramesPlus_TargetTarget_Options.name = "├─"..UFP_OP_ToT_Options;
    UnitFramesPlus_TargetTarget_Options.parent = UFP_OP_Name;
    UnitFramesPlus_TargetTarget_Options:Hide();
    local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, UnitFramesPlus_TargetTarget_Options, UnitFramesPlus_TargetTarget_Options.name)

    --队友设置菜单
    local UnitFramesPlus_Party_Options = CreateFrame("Frame", "UnitFramesPlus_Party_Options", UIParent);
    UnitFramesPlus_Party_Options.name = "├"..UFP_OP_Party_Options;
    UnitFramesPlus_Party_Options.parent = UFP_OP_Name;
    UnitFramesPlus_Party_Options:Hide();
    local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, UnitFramesPlus_Party_Options, UnitFramesPlus_Party_Options.name)

    --队友目标设置菜单
    local UnitFramesPlus_PartyTarget_Options = CreateFrame("Frame", "UnitFramesPlus_PartyTarget_Options", UIParent);
    UnitFramesPlus_PartyTarget_Options.name = "├─"..UFP_OP_PartyTarget_Options;
    UnitFramesPlus_PartyTarget_Options.parent = UFP_OP_Name;
    UnitFramesPlus_PartyTarget_Options:Hide();
    local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, UnitFramesPlus_PartyTarget_Options, UnitFramesPlus_PartyTarget_Options.name)

    --其他设置菜单
    local UnitFramesPlus_Extra_Options = CreateFrame("Frame", "UnitFramesPlus_Extra_Options", UIParent);
    UnitFramesPlus_Extra_Options.name = "└"..UFP_OP_Ext_Options;
    UnitFramesPlus_Extra_Options.parent = UFP_OP_Name;
    UnitFramesPlus_Extra_Options:Hide();
    local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, UnitFramesPlus_Extra_Options, UnitFramesPlus_Extra_Options.name)

    --全局设定
    local globalconfig = UnitFramesPlus_Global_Options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    globalconfig:ClearAllPoints();
    globalconfig:SetPoint("TOPLEFT", 16, -16);
    globalconfig:SetText(UFP_OP_Global_Options);

    --恢复默认设置
    local UnitFramesPlus_OptionsFrame_Reset = CreateFrame("Button", "UnitFramesPlus_OptionsFrame_Reset", UnitFramesPlus_Global_Options, "UIPanelButtonTemplate");
    UnitFramesPlus_OptionsFrame_Reset:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_Reset:SetPoint("TOPLEFT", globalconfig, "TOPLEFT", 2, -40);
    UnitFramesPlus_OptionsFrame_Reset:SetWidth(154);
    UnitFramesPlus_OptionsFrame_Reset:SetHeight(25);
    UnitFramesPlus_OptionsFrame_ResetText:SetText(UFP_OP_Reset);
    UnitFramesPlus_OptionsFrame_Reset:SetScript("OnClick", function(self)
        UnitFramesPlusVar["reset"] = 1;
        if ((not IsInGroup()) or ((not IsInRaid()) and (GetNumSubgroupMembers() > 0))) and not InCombatLockdown() then
            local id;
            local lock = false;

            for id = 1, MAX_PARTY_MEMBERS, 1 do
                if ( UnitExists("party"..id) ) then
                    if UnitInParty("party"..id) and UnitAffectingCombat("party"..id) then
                        lock = true;
                    end
                end
            end

            if not lock and not InCombatLockdown() then
                StaticPopup_Show("UFP_RELOADUI");
            end
        end
    end)

    --地图设置按钮
    local UnitFramesPlus_OptionsFrame_MinimapButton = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_MinimapButton", UnitFramesPlus_Global_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_MinimapButton:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_MinimapButton:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_Reset, "TOPLEFT", -2, -35);
    UnitFramesPlus_OptionsFrame_MinimapButton:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_MinimapButtonText:SetText(UFP_OP_MinimapButton_Show);
    UnitFramesPlus_OptionsFrame_MinimapButton:SetScript("OnClick", function(self)
        UnitFramesPlusDB["minimap"]["button"] = 1 - UnitFramesPlusDB["minimap"]["button"];
        UnitFramesPlus_MinimapButton();
        self:SetChecked(UnitFramesPlusDB["minimap"]["button"]==1);
    end)

    --系统状态条显示
    --[[
	local UnitFramesPlus_OptionsFrame_SYSOnBar = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_SYSOnBar", UnitFramesPlus_Global_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_SYSOnBar:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_SYSOnBar:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_MinimapButton, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_SYSOnBar:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_SYSOnBarText:SetText(UFP_OP_SYS_OnBar);
    UnitFramesPlus_OptionsFrame_SYSOnBar:SetScript("OnClick", function(self)
        if not InCombatLockdown() then
            --InterfaceOptionsFrame_OpenToCategory(InterfaceOptionsStatusTextPanel);
            InterfaceOptionsFrame:Hide();
            GameMenuButtonUIOptions:Click();
            InterfaceOptionsFrameCategoriesButton3:Click();
        end
        self:SetChecked(false);
    end)
	--]]

    -- --系统状态条显示为万亿
    -- if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
    --     local UnitFramesPlus_OptionsFrame_SYSOnBar_Unit = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_SYSOnBar_Unit", UnitFramesPlus_Global_Options, "InterfaceOptionsCheckButtonTemplate");
    --     UnitFramesPlus_OptionsFrame_SYSOnBar_Unit:ClearAllPoints();
    --     UnitFramesPlus_OptionsFrame_SYSOnBar_Unit:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_SYSOnBar, "TOPLEFT", 180, 0);
    --     UnitFramesPlus_OptionsFrame_SYSOnBar_Unit:SetHitRectInsets(0, -100, 0, 0);
    --     UnitFramesPlus_OptionsFrame_SYSOnBar_UnitText:SetText(UFP_OP_SYS_OnBar_Unit);
    --     UnitFramesPlus_OptionsFrame_SYSOnBar_Unit:SetScript("OnClick", function(self)
    --         UnitFramesPlusDB["global"]["textunit"] = 1 - UnitFramesPlusDB["global"]["textunit"];
    --         InterfaceOptionsStatusTextDisplayDropDown_OnClick(InterfaceOptionsDisplayPanelDisplayDropDown);
    --         self:SetChecked(UnitFramesPlusDB["global"]["textunit"]==1);
    --     end)
    -- end

    --全局鼠标移过时才显示数值
    local UnitFramesPlus_OptionsFrame_GlobalMouseShow = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_GlobalMouseShow", UnitFramesPlus_Global_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_GlobalMouseShow:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_MinimapButton, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_GlobalMouseShowText:SetText(UFP_OP_Mouse_Show);
    UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetScript("OnClick", function(self)
        if tonumber(GetCVar("statusText")) ~= 1 then
            StaticPopup_Show("UFP_MOUSESHOW");
            self:SetChecked(UnitFramesPlusDB["global"]["mouseshow"]==1);
            return;
        end
        UnitFramesPlusDB["global"]["mouseshow"] = 1 - UnitFramesPlusDB["global"]["mouseshow"];
        UnitFramesPlusDB["player"]["mouseshow"] = UnitFramesPlusDB["global"]["mouseshow"];
        UnitFramesPlus_PlayerBarTextMouseShow();
        UnitFramesPlus_OptionsFrame_PlayerMouseShow:SetChecked(UnitFramesPlusDB["global"]["mouseshow"]==1);
        UnitFramesPlusDB["pet"]["mouseshow"] = UnitFramesPlusDB["global"]["mouseshow"];
        UnitFramesPlus_PetBarTextMouseShow();
        UnitFramesPlus_OptionsFrame_PetMouseShow:SetChecked(UnitFramesPlusDB["global"]["mouseshow"]==1);
        UnitFramesPlusDB["target"]["mouseshow"] = UnitFramesPlusDB["global"]["mouseshow"];
        UnitFramesPlus_TargetBarTextMouseShow();
        if showOptions then
			UnitFramesPlus_OptionsFrame_TargetMouseShow:SetChecked(UnitFramesPlusDB["global"]["mouseshow"]==1);
		end
        UnitFramesPlusDB["party"]["mouseshow"] = UnitFramesPlusDB["global"]["mouseshow"];
        UnitFramesPlus_PartyBarTextMouseShow();
        UnitFramesPlus_OptionsFrame_PartyMouseShow:SetChecked(UnitFramesPlusDB["global"]["mouseshow"]==1);
        UnitFramesPlusDB["extra"]["pvpmouseshow"] = UnitFramesPlusDB["global"]["mouseshow"];
        -- UnitFramesPlus_ArenaEnemyBarTextMouseShow();
        -- UnitFramesPlus_OptionsFrame_ArenaEnemyMouseShow:SetChecked(UnitFramesPlusDB["global"]["mouseshow"]==1);
        self:SetChecked(UnitFramesPlusDB["global"]["mouseshow"]==1);
    end)

    --全局头像类型开关
    local UnitFramesPlus_OptionsFrame_GlobalPortraitType = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_GlobalPortraitType", UnitFramesPlus_Global_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_GlobalPortraitType:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_GlobalPortraitType:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_GlobalMouseShow, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_GlobalPortraitType:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeText:SetText(UFP_OP_Portrait);
    UnitFramesPlus_OptionsFrame_GlobalPortraitType:SetScript("OnClick", function(self)
        UnitFramesPlusDB["global"]["portrait"] = 1 - UnitFramesPlusDB["global"]["portrait"];
        if UnitFramesPlusDB["global"]["portrait"] == 1 then
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider);
            if UnitFramesPlusDB["global"]["portraittype"] == 1 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
            elseif UnitFramesPlusDB["global"]["portraittype"] == 2 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
            end
        else
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
        end

        UnitFramesPlusDB["player"]["portrait"] = UnitFramesPlusDB["global"]["portrait"];
        UnitFramesPlus_OptionsFrame_PlayerPortraitType:SetChecked(UnitFramesPlusDB["global"]["portrait"]==1);
        UnitFramesPlusDB["player"]["portraittype"] = UnitFramesPlusDB["global"]["portraittype"];
        UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider:SetValue(UnitFramesPlusDB["global"]["portraittype"]);
        UnitFramesPlusDB["player"]["portrait3dbg"] = UnitFramesPlusDB["global"]["portrait3dbg"];
        UnitFramesPlus_PlayerPortrait3DBGDisplayUpdate();
        UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG:SetChecked(UnitFramesPlusDB["global"]["portrait3dbg"]==1);
        UnitFramesPlus_PlayerPortrait();
        if UnitFramesPlusDB["player"]["portrait"] == 1 then
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider);
            if UnitFramesPlusDB["player"]["portraittype"] == 1 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG);
            end
        else
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG);
        end

        UnitFramesPlusDB["target"]["portrait"] = UnitFramesPlusDB["global"]["portrait"];
        UnitFramesPlus_OptionsFrame_TargetPortraitType:SetChecked(UnitFramesPlusDB["global"]["portrait"]==1);
        UnitFramesPlusDB["target"]["portraittype"] = UnitFramesPlusDB["global"]["portraittype"];
        UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider:SetValue(UnitFramesPlusDB["global"]["portraittype"]);
        UnitFramesPlusDB["target"]["portrait3dbg"] = UnitFramesPlusDB["global"]["portrait3dbg"];
        UnitFramesPlus_TargetPortrait3DBGDisplayUpdate();
        UnitFramesPlus_OptionsFrame_TargetPortrait3DBG:SetChecked(UnitFramesPlusDB["global"]["portrait3dbg"]==1);
        UnitFramesPlusDB["target"]["portraitnpcno"] = UnitFramesPlusDB["global"]["portraitnpcno"];
        UnitFramesPlus_TargetPortraitDisplayUpdate();
        UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo:SetChecked(UnitFramesPlusDB["global"]["portraitnpcno"]==1);
        UnitFramesPlus_TargetPortrait();
        if UnitFramesPlusDB["target"]["portrait"] == 1 then
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider);
            if UnitFramesPlusDB["target"]["portraittype"] == 1 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetPortrait3DBG);
            elseif UnitFramesPlusDB["target"]["portraittype"] == 2 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo);
            end
        else
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortrait3DBG);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo);
        end

        UnitFramesPlusDB["party"]["portrait"] = UnitFramesPlusDB["global"]["portrait"];
        UnitFramesPlusDB["party"]["portraittype"] = UnitFramesPlusDB["global"]["portraittype"];
        UnitFramesPlusDB["party"]["portrait3dbg"] = UnitFramesPlusDB["global"]["portrait3dbg"];
        if UnitFramesPlusDB["party"]["origin"] == 1 then
            UnitFramesPlus_OptionsFrame_PartyPortraitType:SetChecked(UnitFramesPlusDB["global"]["portrait"]==1);
            UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider:SetValue(UnitFramesPlusDB["global"]["portraittype"]);
            for id = 1, 4, 1 do
                UnitFramesPlus_PartyPortrait3DBGDisplayUpdate(id);
            end
            UnitFramesPlus_OptionsFrame_PartyPortrait3DBG:SetChecked(UnitFramesPlusDB["global"]["portrait3dbg"]==1);
            UnitFramesPlus_PartyPortrait();
            if UnitFramesPlusDB["party"]["portrait"] == 1 then
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider);
                if UnitFramesPlusDB["party"]["portraittype"] == 1 then
                    BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
                end
            else
                BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider);
                BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
            end
        end

        self:SetChecked(UnitFramesPlusDB["global"]["portrait"]==1);
    end)

    --全局头像类型
    local UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider", UnitFramesPlus_Global_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_GlobalPortraitType, "TOPLEFT", 183, 0);
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSliderLow:SetText(UFP_OP_3D);
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSliderHigh:SetText(UFP_OP_CLASS);
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider:SetMinMaxValues(1,2);
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider:SetScript("OnValueChanged", function(self, value)
		if UnitFramesPlusDB["global"]["portraittype"] ~= value then
			UnitFramesPlusDB["global"]["portraittype"] = value;
			if value == 1 then
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
			elseif value == 2 then
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
			end

			UnitFramesPlusDB["player"]["portraittype"] = value;
			UnitFramesPlus_PlayerPortrait();
			if value == 1 then
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG);
			else
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG);
			end
			UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider:SetValue(value);

			UnitFramesPlusDB["target"]["portraittype"] = value;
			UnitFramesPlus_TargetPortrait();
			if value == 1 then
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetPortrait3DBG);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo);
			elseif value == 2 then
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortrait3DBG);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo);
			end
			UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider:SetValue(value);

            UnitFramesPlusDB["party"]["portraittype"] = value;
			if UnitFramesPlusDB["party"]["origin"] == 1 then
				UnitFramesPlus_PartyPortrait();
				if value == 1 then
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
				else
					BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
				end
				UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider:SetValue(value);
			end
		end
    end)

    --全局3D头像背景
    local UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG", UnitFramesPlus_Global_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_GlobalPortraitType, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_GlobalPortrait3DBGText:SetText(UFP_OP_Portrait_3DBG);
    UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG:SetScript("OnClick", function(self)
        UnitFramesPlusDB["global"]["portrait3dbg"] = 1 - UnitFramesPlusDB["global"]["portrait3dbg"];
        UnitFramesPlusDB["player"]["portrait3dbg"] = UnitFramesPlusDB["global"]["portrait3dbg"];
        UnitFramesPlus_PlayerPortrait3DBGDisplayUpdate();
        UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG:SetChecked(UnitFramesPlusDB["global"]["portrait3dbg"]==1);
        UnitFramesPlusDB["target"]["portrait3dbg"] = UnitFramesPlusDB["global"]["portrait3dbg"];
        UnitFramesPlus_TargetPortrait3DBGDisplayUpdate();
        UnitFramesPlus_OptionsFrame_TargetPortrait3DBG:SetChecked(UnitFramesPlusDB["global"]["portrait3dbg"]==1);
        UnitFramesPlusDB["party"]["portrait3dbg"] = UnitFramesPlusDB["global"]["portrait3dbg"];
        if UnitFramesPlusDB["party"]["origin"] == 1 then
            for id = 1, 4, 1 do
                UnitFramesPlus_PartyPortrait3DBGDisplayUpdate(id);
            end
            UnitFramesPlus_OptionsFrame_PartyPortrait3DBG:SetChecked(UnitFramesPlusDB["global"]["portrait3dbg"]==1);
        end
        self:SetChecked(UnitFramesPlusDB["global"]["portrait3dbg"]==1);
    end)

    --全局目标为NPC时不显示职业头像
    local UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo", UnitFramesPlus_Global_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNoText:SetText(UFP_OP_NPCNo);
    UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo:SetScript("OnClick", function(self)
        UnitFramesPlusDB["global"]["portraitnpcno"] = 1 - UnitFramesPlusDB["global"]["portraitnpcno"];
        UnitFramesPlusDB["target"]["portraitnpcno"] = UnitFramesPlusDB["global"]["portraitnpcno"];
        UnitFramesPlus_TargetPortraitDisplayUpdate();
        UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo:SetChecked(UnitFramesPlusDB["global"]["portraitnpcno"]==1);
        self:SetChecked(UnitFramesPlusDB["global"]["portraitnpcno"]==1);
    end)

    --全局Shift拖动头像
    local UnitFramesPlus_OptionsFrame_GlobalShiftDrag = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_GlobalShiftDrag", UnitFramesPlus_Global_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_GlobalShiftDrag:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_GlobalShiftDrag:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_GlobalShiftDrag:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_GlobalShiftDragText:SetText(UFP_OP_Shift_Movable);
    UnitFramesPlus_OptionsFrame_GlobalShiftDrag:SetScript("OnClick", function(self)
        UnitFramesPlusDB["global"]["movable"] = 1 - UnitFramesPlusDB["global"]["movable"];
        UnitFramesPlusDB["player"]["movable"] = UnitFramesPlusDB["global"]["movable"];
        UnitFramesPlus_OptionsFrame_PlayerShiftDrag:SetChecked(UnitFramesPlusDB["global"]["movable"]==1);
        UnitFramesPlusDB["target"]["movable"] = UnitFramesPlusDB["global"]["movable"];
        UnitFramesPlus_OptionsFrame_TargetShiftDrag:SetChecked(UnitFramesPlusDB["global"]["movable"]==1);
        UnitFramesPlusDB["targettarget"]["movable"] = UnitFramesPlusDB["global"]["movable"];
        UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag:SetChecked(UnitFramesPlusDB["global"]["movable"]==1);
        UnitFramesPlusDB["party"]["movable"] = UnitFramesPlusDB["global"]["movable"];
        -- UnitFramesPlus_OptionsFrame_PartyShiftDrag:SetChecked(UnitFramesPlusDB["global"]["movable"]==1);
        self:SetChecked(UnitFramesPlusDB["player"]["movable"]==1);
    end)

    --全局头像内战斗信息
    local UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator", UnitFramesPlus_Global_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_GlobalShiftDrag, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_GlobalPortraitIndicatorText:SetText(UFP_OP_Portrait_Indicator);
    UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetScript("OnClick", function(self)
        UnitFramesPlusDB["global"]["indicator"] = 1 - UnitFramesPlusDB["global"]["indicator"];
        UnitFramesPlusDB["player"]["indicator"] = UnitFramesPlusDB["global"]["indicator"];
        UnitFramesPlus_PlayerPortraitIndicator();
        UnitFramesPlus_OptionsFrame_PlayerPortraitIndicator:SetChecked(UnitFramesPlusDB["global"]["indicator"]==1);
        UnitFramesPlusDB["pet"]["indicator"] = UnitFramesPlusDB["global"]["indicator"];
        UnitFramesPlus_PetPortraitIndicator();
        UnitFramesPlus_OptionsFrame_PetPortraitIndicator:SetChecked(UnitFramesPlusDB["global"]["indicator"]==1);
        UnitFramesPlusDB["target"]["indicator"] = UnitFramesPlusDB["global"]["indicator"];
        UnitFramesPlus_TargetPortraitIndicator();
        UnitFramesPlus_OptionsFrame_TargetPortraitIndicator:SetChecked(UnitFramesPlusDB["global"]["indicator"]==1);
        UnitFramesPlusDB["party"]["indicator"] = UnitFramesPlusDB["global"]["indicator"];
        UnitFramesPlus_PartyPortraitIndicator();
        UnitFramesPlus_OptionsFrame_PartyPortraitIndicator:SetChecked(UnitFramesPlusDB["global"]["indicator"]==1);
        self:SetChecked(UnitFramesPlusDB["global"]["indicator"]==1);
    end)

if showOptions then
    --全局生命条染色
    local UnitFramesPlus_OptionsFrame_GlobalColorHP = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_GlobalColorHP", UnitFramesPlus_Global_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_GlobalColorHP:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_GlobalColorHP:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_GlobalColorHP:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_GlobalColorHPText:SetText(UFP_OP_ColorHP);
    UnitFramesPlus_OptionsFrame_GlobalColorHP:SetScript("OnClick", function(self)
        UnitFramesPlusDB["global"]["colorhp"] = 1 - UnitFramesPlusDB["global"]["colorhp"];
        UnitFramesPlusDB["player"]["colorhp"] = UnitFramesPlusDB["global"]["colorhp"];
        BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PlayerColorHPSlider);
        -- UnitFramesPlus_PlayerColorHPBar();
        UnitFramesPlus_PlayerColorHPBarDisplayUpdate();
        UnitFramesPlus_OptionsFrame_PlayerColorHP:SetChecked(UnitFramesPlusDB["global"]["colorhp"]==1);
        UnitFramesPlusDB["target"]["colorhp"] = UnitFramesPlusDB["global"]["colorhp"];
        -- UnitFramesPlus_TargetColorHPBar();
        UnitFramesPlus_TargetColorHPBarDisplayUpdate();
        UnitFramesPlus_OptionsFrame_TargetColorHP:SetChecked(UnitFramesPlusDB["global"]["colorhp"]==1);
        UnitFramesPlusDB["party"]["colorhp"] = UnitFramesPlusDB["global"]["colorhp"];
        -- UnitFramesPlus_PartyColorHPBar();
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyColorHPBarDisplayUpdate(id);
        end
        UnitFramesPlus_OptionsFrame_PartyColorHP:SetChecked(UnitFramesPlusDB["global"]["colorhp"]==1);
        if UnitFramesPlusDB["global"]["colorhp"] == 1 then
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_GlobalColorHPSlider);
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PlayerColorHPSlider);
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_TargetColorHPSlider);
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
        else
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_GlobalColorHPSlider);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PlayerColorHPSlider);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetColorHPSlider);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
        end
        self:SetChecked(UnitFramesPlusDB["global"]["colorhp"]==1);
    end)

    --全局生命条染色类型
    local UnitFramesPlus_OptionsFrame_GlobalColorHPSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_GlobalColorHPSlider", UnitFramesPlus_Global_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_GlobalColorHPSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_GlobalColorHPSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_GlobalColorHPSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_GlobalColorHPSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_GlobalColorHP, "TOPLEFT", 183, 0);
    UnitFramesPlus_OptionsFrame_GlobalColorHPSliderLow:SetText(UFP_OP_ColorHP_Class);
    UnitFramesPlus_OptionsFrame_GlobalColorHPSliderHigh:SetText(UFP_OP_ColorHP_HPPct);
    UnitFramesPlus_OptionsFrame_GlobalColorHPSlider:SetMinMaxValues(1,2);
    UnitFramesPlus_OptionsFrame_GlobalColorHPSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_GlobalColorHPSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_GlobalColorHPSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["global"]["colortype"] ~= value then
			UnitFramesPlusDB["global"]["colortype"] = value;
			UnitFramesPlusDB["player"]["colortype"] = value;
			-- UnitFramesPlus_PlayerColorHPBar();
			UnitFramesPlus_PlayerColorHPBarDisplayUpdate();
			UnitFramesPlus_OptionsFrame_PlayerColorHPSlider:SetValue(value);
			UnitFramesPlusDB["target"]["colortype"] = value;
			-- UnitFramesPlus_TargetColorHPBar();
			UnitFramesPlus_TargetColorHPBarDisplayUpdate();
			UnitFramesPlus_OptionsFrame_TargetColorHPSlider:SetValue(value);
			UnitFramesPlusDB["party"]["colortype"] = value;
			-- UnitFramesPlus_PartyColorHPBar();
			for id = 1, 4, 1 do
				UnitFramesPlus_PartyColorHPBarDisplayUpdate(id);
			end
			UnitFramesPlus_OptionsFrame_PartyColorHPSlider:SetValue(value);
		end
    end)
end

    --玩家设定
    local playerconfig = UnitFramesPlus_Player_Options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    playerconfig:ClearAllPoints();
    playerconfig:SetPoint("TOPLEFT", 16, -16);
    playerconfig:SetText(UFP_OP_Player_Options);

	--玩家鼠标移过时才显示数值
    local UnitFramesPlus_OptionsFrame_PlayerMouseShow = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerMouseShow", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerMouseShow:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerMouseShow:SetPoint("TOPLEFT", playerconfig, "TOPLEFT", 0, -40);
    UnitFramesPlus_OptionsFrame_PlayerMouseShow:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerMouseShowText:SetText(UFP_OP_Mouse_Show);
    UnitFramesPlus_OptionsFrame_PlayerMouseShow:SetScript("OnClick", function(self)
        if tonumber(GetCVar("statusText")) ~= 1 then
            StaticPopup_Show("UFP_MOUSESHOW");
            self:SetChecked(UnitFramesPlusDB["player"]["mouseshow"]==1);
            return;
        end
        UnitFramesPlusDB["player"]["mouseshow"] = 1 - UnitFramesPlusDB["player"]["mouseshow"];
        if UnitFramesPlusDB["player"]["mouseshow"] == 1 then
            if UnitFramesPlusDB["pet"]["mouseshow"] == 1 
            and UnitFramesPlusDB["target"]["mouseshow"] == 1
            and UnitFramesPlusDB["party"]["mouseshow"] == 1 
            and UnitFramesPlusDB["extra"]["pvpmouseshow"] == 1 then
                UnitFramesPlusDB["global"]["mouseshow"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetChecked(true);
            end
        else
            UnitFramesPlusDB["global"]["mouseshow"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetChecked(false);
        end
        UnitFramesPlus_PlayerBarTextMouseShow();
        self:SetChecked(UnitFramesPlusDB["player"]["mouseshow"]==1);
    end)

if showOptions then
    --玩家精英头像
    local UnitFramesPlus_OptionsFrame_PlayerDragonBorder = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerDragonBorder", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerDragonBorder:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerDragonBorder:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerMouseShow, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PlayerDragonBorder:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerDragonBorderText:SetText(UFP_OP_Player_Dragon);
    UnitFramesPlus_OptionsFrame_PlayerDragonBorder:SetScript("OnClick", function(self)
        UnitFramesPlusDB["player"]["dragonborder"] = 1 - UnitFramesPlusDB["player"]["dragonborder"];
        if UnitFramesPlusDB["player"]["dragonborder"] == 1 then
            UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_PlayerDragonBorderType);
        else
            UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PlayerDragonBorderType);
        end
        UnitFramesPlus_PlayerDragon();
        self:SetChecked(UnitFramesPlusDB["player"]["dragonborder"]==1);
    end)

    --玩家扩展框类型
    local UnitFramesPlus_OptionsFrame_PlayerDragonBorderType = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerDragonBorderType", UnitFramesPlus_Player_Options, "UIDropDownMenuTemplate");
    UnitFramesPlus_OptionsFrame_PlayerDragonBorderType:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerDragonBorderType:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerDragonBorder, "TOPLEFT", 165, 0);
    UnitFramesPlus_OptionsFrame_PlayerDragonBorderType:SetHitRectInsets(0, -100, 0, 0);
    UIDropDownMenu_SetWidth(UnitFramesPlus_OptionsFrame_PlayerDragonBorderType, 95);
    UIDropDownMenu_Initialize(UnitFramesPlus_OptionsFrame_PlayerDragonBorderType, PlayerDragonBorderType_Init);
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_PlayerDragonBorderType, UnitFramesPlusDB["player"]["bordertype"]);
end

    --玩家不显示扩展框时的生命值和法力值(百分比)
    local UnitFramesPlus_OptionsFrame_PlayerHPMPPct = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerHPMPPct", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerHPMPPct:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerHPMPPct:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerDragonBorder or UnitFramesPlus_OptionsFrame_PlayerMouseShow, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PlayerHPMPPct:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerHPMPPctText:SetText(UFP_OP_HPMP);
    UnitFramesPlus_OptionsFrame_PlayerHPMPPct:SetScript("OnClick", function(self)
        UnitFramesPlusDB["player"]["hpmp"] = 1 - UnitFramesPlusDB["player"]["hpmp"];
        if UnitFramesPlusDB["player"]["hpmp"] == 1 then
            UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne);
            UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PlayerHPMPUnit);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PlayerCoordinate);
            if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider);
            end
			BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider);
        else
            UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne);
            UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerHPMPUnit);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerCoordinate);
            if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
                BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider);
            end
			if not showOptions then
				BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider);
			end
        end
        UnitFramesPlus_PlayerHPMPPct();
        self:SetChecked(UnitFramesPlusDB["player"]["hpmp"]==1);
    end)

    --玩家生命值/法力值/百分比第一部分
    local UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne", UnitFramesPlus_Player_Options, "UIDropDownMenuTemplate");
    UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerHPMPPct, "TOPLEFT", 165, 0);
    UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne:SetHitRectInsets(0, -100, 0, 0);
    UIDropDownMenu_SetWidth(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne, 95);
    UIDropDownMenu_Initialize(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne, PlayerHPMPPctPartOne_Init);
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne, UnitFramesPlusDB["player"]["hpmppartone"]);

    --玩家斜线
    local splitline = UnitFramesPlus_Player_Options:CreateFontString(nil, "ARTWORK", "TextStatusBarText");
    splitline:ClearAllPoints();
    splitline:SetPoint("LEFT", UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne, "RIGHT", -5, 0);
    splitline:SetText("/");

    --玩家生命值/法力值/百分比第二部分
    local UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo", UnitFramesPlus_Player_Options, "UIDropDownMenuTemplate");
    UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo:SetPoint("LEFT", splitline, "RIGHT", -11, 0);
    UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo:SetHitRectInsets(0, -100, 0, 0);
    UIDropDownMenu_SetWidth(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo, 95);
    UIDropDownMenu_Initialize(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo, PlayerHPMPPctPartTwo_Init);
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo, UnitFramesPlusDB["player"]["hpmpparttwo"]);
	
	--玩家生命值、法力值字体大小
    local UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider", UnitFramesPlus_Player_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerHPMPPct, "TOPLEFT", 30, -45);
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSliderText:SetText(UFP_OP_FontSize..UnitFramesPlusDB["player"]["fontsize"]);
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSliderLow:SetText("8");
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSliderHigh:SetText("18");
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider:SetMinMaxValues(8,18);
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["player"]["fontsize"] ~= value then
            UnitFramesPlusDB["player"]["fontsize"] = value;
            UnitFramesPlus_PlayerExtraTextFontSize();
            UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSliderText:SetText(UFP_OP_FontSize..UnitFramesPlusDB["player"]["fontsize"]);
        end
    end)

if showOptions then
	--玩家扩展框
    local UnitFramesPlus_OptionsFrame_PlayerExtrabar = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerExtrabar", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerExtrabar:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerExtrabar:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider, "TOPLEFT", 149, 0);
    UnitFramesPlus_OptionsFrame_PlayerExtrabar:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerExtrabarText:SetText(UFP_OP_Player_Extrabar);
    UnitFramesPlus_OptionsFrame_PlayerExtrabar:SetScript("OnClick", function(self)
        UnitFramesPlusDB["player"]["extrabar"] = 1 - UnitFramesPlusDB["player"]["extrabar"];
        if UnitFramesPlusDB["player"]["extrabar"] == 1 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerHPMPPct);
            UnitFramesPlusDB["player"]["hpmp"] = 1;
            UnitFramesPlus_OptionsFrame_PlayerHPMPPct:SetChecked(UnitFramesPlusDB["player"]["hpmp"]==1);
            UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne);
            UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PlayerHPMPUnit);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PlayerCoordinate);
        else
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PlayerHPMPPct);
        end
        UnitFramesPlus_PlayerExtrabar();
        self:SetChecked(UnitFramesPlusDB["player"]["extrabar"]==1);
    end)
end

    --玩家生命值、法力值单位
    local UnitFramesPlus_OptionsFrame_PlayerHPMPUnit = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerHPMPUnit", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerHPMPUnit:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerHPMPUnit:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerHPMPPct, "TOPLEFT", 0, -90);
    UnitFramesPlus_OptionsFrame_PlayerHPMPUnit:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerHPMPUnitText:SetText(UFP_OP_Player_Unit);
    UnitFramesPlus_OptionsFrame_PlayerHPMPUnit:SetScript("OnClick", function(self)
        UnitFramesPlusDB["player"]["hpmpunit"] = 1 - UnitFramesPlusDB["player"]["hpmpunit"];
        if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
            if UnitFramesPlusDB["player"]["hpmpunit"] == 1 then
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider);
            else
                BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider);
            end
        end
        UnitFramesPlus_PlayerHPValueDisplayUpdate();
        UnitFramesPlus_PlayerMPValueDisplayUpdate();
        self:SetChecked(UnitFramesPlusDB["player"]["hpmpunit"]==1);
    end)

    --玩家生命值、法力值单位
    if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
        local UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider", UnitFramesPlus_Player_Options, "OptionsSliderTemplate");
        UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider:SetWidth(95);
        UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider:SetHeight(16);
        UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider:ClearAllPoints();
        UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerHPMPUnit, "TOPLEFT", 183, 0);
        UnitFramesPlus_OptionsFrame_PlayerUnitTypeSliderLow:SetText(UFP_OP_Player_UnitK);
        UnitFramesPlus_OptionsFrame_PlayerUnitTypeSliderHigh:SetText(UFP_OP_Player_UnitW);
        UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider:SetMinMaxValues(1,2);
        UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider:SetValueStep(1);
        UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider:SetObeyStepOnDrag(true);
        UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider:SetScript("OnValueChanged", function(self, value)
            if UnitFramesPlusDB["player"]["unittype"] ~= value then
				UnitFramesPlusDB["player"]["unittype"] = value;
				UnitFramesPlus_PlayerHPValueDisplayUpdate();
				UnitFramesPlus_PlayerMPValueDisplayUpdate();
			end
		end)
    end

	--玩家坐标
    local UnitFramesPlus_OptionsFrame_PlayerCoordinate = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerCoordinate", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerCoordinate:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerCoordinate:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerHPMPUnit, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PlayerCoordinate:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerCoordinateText:SetText(UFP_OP_Player_Coordinate);
    UnitFramesPlus_OptionsFrame_PlayerCoordinate:SetScript("OnClick", function(self)
        UnitFramesPlusDB["player"]["coord"] = 1 - UnitFramesPlusDB["player"]["coord"];
        UnitFramesPlus_PlayerCoordinate();
        UnitFramesPlus_PlayerCoordinateDisplayUpdate();
        UnitFramesPlus_PlayerHPValueDisplayUpdate();
        self:SetChecked(UnitFramesPlusDB["player"]["coord"]==1);
    end)

    --玩家头像自动隐藏
    local UnitFramesPlus_OptionsFrame_PlayerFrameAutohide = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerFrameAutohide", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerFrameAutohide:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerFrameAutohide:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerCoordinate, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PlayerFrameAutohide:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerFrameAutohideText:SetText(UFP_OP_Player_Autohide);
    UnitFramesPlus_OptionsFrame_PlayerFrameAutohide:SetScript("OnClick", function(self)
        UnitFramesPlusDB["player"]["autohide"] = 1 - UnitFramesPlusDB["player"]["autohide"];
        UnitFramesPlus_PlayerFrameAutohide();
        UnitFramesPlus_PlayerFrameAutohideDisplayUpdate();
        self:SetChecked(UnitFramesPlusDB["player"]["autohide"]==1);
    end)

    --玩家头像类型开关
    local UnitFramesPlus_OptionsFrame_PlayerPortraitType = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerPortraitType", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerPortraitType:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerPortraitType:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerFrameAutohide, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PlayerPortraitType:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeText:SetText(UFP_OP_Portrait);
    UnitFramesPlus_OptionsFrame_PlayerPortraitType:SetScript("OnClick", function(self)
        UnitFramesPlusDB["player"]["portrait"] = 1 - UnitFramesPlusDB["player"]["portrait"];
        UnitFramesPlus_PlayerPortrait();
        if UnitFramesPlusDB["player"]["portrait"] == 1 then
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider);
            if UnitFramesPlusDB["player"]["portraittype"] == 1 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG);
            end
            if UnitFramesPlusDB["target"]["portrait"] == 1 
            and UnitFramesPlusDB["party"]["portrait"] == 1 then
                UnitFramesPlusDB["global"]["portrait"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalPortraitType:SetChecked(true);
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider);
                if UnitFramesPlusDB["global"]["portraittype"] == 1 then
                    BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
                elseif UnitFramesPlusDB["global"]["portraittype"] == 2 then
                    BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
                end
            end
        else
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG);
            UnitFramesPlusDB["global"]["portrait"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalPortraitType:SetChecked(false);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
        end
        self:SetChecked(UnitFramesPlusDB["player"]["portrait"]==1);
    end)

    --玩家头像类型
    local UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider", UnitFramesPlus_Player_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerPortraitType, "TOPLEFT", 183, 0);
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSliderLow:SetText(UFP_OP_3D);
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSliderHigh:SetText(UFP_OP_CLASS);
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider:SetMinMaxValues(1,2);
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["player"]["portraittype"] ~= value then
			UnitFramesPlusDB["player"]["portraittype"] = value;
			UnitFramesPlus_PlayerPortrait();
			if value == 1 then
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG);
			else
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG);
			end
		end
	end)

    --玩家3D头像背景
    local UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerPortraitType, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerPortrait3DBGText:SetText(UFP_OP_Portrait_3DBG);
    UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG:SetScript("OnClick", function(self)
        UnitFramesPlusDB["player"]["portrait3dbg"] = 1 - UnitFramesPlusDB["player"]["portrait3dbg"];
        UnitFramesPlus_PlayerPortrait3DBGDisplayUpdate();
        if UnitFramesPlusDB["player"]["portrait3dbg"] == 1 then
            if UnitFramesPlusDB["target"]["portrait3dbg"] == 1
            and UnitFramesPlusDB["party"]["portrait3dbg"] == 1 then
                if UnitFramesPlusDB["global"]["portrait"] == 1 
                and UnitFramesPlusDB["global"]["portraittype"] == 1 then
                    UnitFramesPlusDB["global"]["portrait3dbg"] = 1;
                    UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG:SetChecked(true);
                end
            end
        else
            UnitFramesPlusDB["global"]["portrait3dbg"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG:SetChecked(false);
        end
        self:SetChecked(UnitFramesPlusDB["player"]["portrait3dbg"]==1);
    end)

    --玩家Shift拖动头像
    local UnitFramesPlus_OptionsFrame_PlayerShiftDrag = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerShiftDrag", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerShiftDrag:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerShiftDrag:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PlayerShiftDrag:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerShiftDragText:SetText(UFP_OP_Shift_Movable);
    UnitFramesPlus_OptionsFrame_PlayerShiftDrag:SetScript("OnClick", function(self)
        UnitFramesPlusDB["player"]["movable"] = 1 - UnitFramesPlusDB["player"]["movable"];
        if UnitFramesPlusDB["player"]["movable"] == 1 then
            if UnitFramesPlusDB["target"]["movable"] == 1 
            and UnitFramesPlusDB["targettarget"]["movable"] == 1
            and UnitFramesPlusDB["party"]["movable"] == 1 then
                UnitFramesPlusDB["global"]["movable"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalShiftDrag:SetChecked(true);
            end
        else
            UnitFramesPlusDB["global"]["movable"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalShiftDrag:SetChecked(false);
        end
        self:SetChecked(UnitFramesPlusDB["player"]["movable"]==1);
    end)

    --玩家头像内战斗信息
    local UnitFramesPlus_OptionsFrame_PlayerPortraitIndicator = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerPortraitIndicator", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerPortraitIndicator:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerPortraitIndicator:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerShiftDrag, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PlayerPortraitIndicator:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerPortraitIndicatorText:SetText(UFP_OP_Portrait_Indicator);
    UnitFramesPlus_OptionsFrame_PlayerPortraitIndicator:SetScript("OnClick", function(self)
        UnitFramesPlusDB["player"]["indicator"] = 1 - UnitFramesPlusDB["player"]["indicator"];
        UnitFramesPlus_PlayerPortraitIndicator();
        if UnitFramesPlusDB["player"]["indicator"] == 1 then
            if UnitFramesPlusDB["pet"]["indicator"] == 1 
            and UnitFramesPlusDB["target"]["indicator"] == 1
            and UnitFramesPlusDB["party"]["indicator"] == 1 then
                UnitFramesPlusDB["global"]["indicator"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetChecked(true);
            end
        else
            UnitFramesPlusDB["global"]["indicator"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetChecked(false);
        end
        self:SetChecked(UnitFramesPlusDB["player"]["indicator"]==1);
    end)

if showOptions then
    --玩家生命条染色
    local UnitFramesPlus_OptionsFrame_PlayerColorHP = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PlayerColorHP", UnitFramesPlus_Player_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PlayerColorHP:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerColorHP:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerPortraitIndicator, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PlayerColorHP:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PlayerColorHPText:SetText(UFP_OP_ColorHP);
    UnitFramesPlus_OptionsFrame_PlayerColorHP:SetScript("OnClick", function(self)
        UnitFramesPlusDB["player"]["colorhp"] = 1 - UnitFramesPlusDB["player"]["colorhp"];
        if UnitFramesPlusDB["player"]["colorhp"] == 1 then
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PlayerColorHPSlider);
        else
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PlayerColorHPSlider);
        end
        -- UnitFramesPlus_PlayerColorHPBar();
        UnitFramesPlus_PlayerColorHPBarDisplayUpdate();
        if UnitFramesPlusDB["player"]["colorhp"] == 1 then
            if UnitFramesPlusDB["target"]["colorhp"] == 1 
            and UnitFramesPlusDB["party"]["colorhp"] == 1 then
                UnitFramesPlusDB["global"]["colorhp"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalColorHP:SetChecked(true);
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_GlobalColorHPSlider);
            end
        else
            UnitFramesPlusDB["global"]["colorhp"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalColorHP:SetChecked(false);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_GlobalColorHPSlider);
        end
        self:SetChecked(UnitFramesPlusDB["player"]["colorhp"]==1);
    end)

    --玩家生命条染色类型
    local UnitFramesPlus_OptionsFrame_PlayerColorHPSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_PlayerColorHPSlider", UnitFramesPlus_Player_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_PlayerColorHPSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_PlayerColorHPSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_PlayerColorHPSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerColorHPSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerColorHP, "TOPLEFT", 183, 0);
    UnitFramesPlus_OptionsFrame_PlayerColorHPSliderLow:SetText(UFP_OP_ColorHP_Class);
    UnitFramesPlus_OptionsFrame_PlayerColorHPSliderHigh:SetText(UFP_OP_ColorHP_HPPct);
    UnitFramesPlus_OptionsFrame_PlayerColorHPSlider:SetMinMaxValues(1,2);
    UnitFramesPlus_OptionsFrame_PlayerColorHPSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_PlayerColorHPSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_PlayerColorHPSlider:SetScript("OnValueChanged", function(self, value)
		if UnitFramesPlusDB["player"]["colortype"] ~= value then
			UnitFramesPlusDB["player"]["colortype"] = value;
			-- UnitFramesPlus_PlayerColorHPBar();
			UnitFramesPlus_PlayerColorHPBarDisplayUpdate();
		end
    end)

    --玩家头像缩放
    local UnitFramesPlus_OptionsFrame_PlayerFrameScaleSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_PlayerFrameScaleSlider", UnitFramesPlus_Player_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSlider:SetWidth(154);
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PlayerColorHP, "TOPLEFT", 8, -60);
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSliderText:SetText(UFP_OP_Scale..(UnitFramesPlusDB["player"]["scale"]*100).."%");
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSliderLow:SetText("50%");
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSliderHigh:SetText("150%");
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSlider:SetMinMaxValues(50,150);
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["player"]["scale"] ~= value/100 then
			UnitFramesPlusDB["player"]["scale"] = value/100;
			UnitFramesPlus_PlayerFrameScale(UnitFramesPlusDB["player"]["scale"]);
			local left = PlayerFrame:GetLeft();
			local bottom = PlayerFrame:GetBottom();
			UnitFramesPlusVar["player"]["x"] = left;
			UnitFramesPlusVar["player"]["y"] = bottom;
			UnitFramesPlus_OptionsFrame_PlayerFrameScaleSliderText:SetText(UFP_OP_Scale..(UnitFramesPlusDB["player"]["scale"]*100).."%");
		end
	end)
end

    --宠物设定
    local petconfig = UnitFramesPlus_Pet_Options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    petconfig:ClearAllPoints();
    petconfig:SetPoint("TOPLEFT", 16, -16);
    petconfig:SetText(UFP_OP_Pet_Options);

    --宠物鼠标移过时才显示数值
    local UnitFramesPlus_OptionsFrame_PetMouseShow = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PetMouseShow", UnitFramesPlus_Pet_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PetMouseShow:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PetMouseShow:SetPoint("TOPLEFT", petconfig, "TOPLEFT", 0, -40);
    UnitFramesPlus_OptionsFrame_PetMouseShow:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PetMouseShowText:SetText(UFP_OP_Mouse_Show);
    UnitFramesPlus_OptionsFrame_PetMouseShow:SetScript("OnClick", function(self)
        if tonumber(GetCVar("statusText")) ~= 1 then
            StaticPopup_Show("UFP_MOUSESHOW");
            self:SetChecked(UnitFramesPlusDB["pet"]["mouseshow"]==1);
            return;
        end
        UnitFramesPlusDB["pet"]["mouseshow"] = 1 - UnitFramesPlusDB["pet"]["mouseshow"];
        if UnitFramesPlusDB["pet"]["mouseshow"] == 1 then
            if UnitFramesPlusDB["player"]["mouseshow"] == 1
            and UnitFramesPlusDB["target"]["mouseshow"] == 1 
            and UnitFramesPlusDB["party"]["mouseshow"] == 1 
            and UnitFramesPlusDB["extra"]["pvpmouseshow"] == 1 then
                UnitFramesPlusDB["global"]["mouseshow"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetChecked(true);
            end
        else
            UnitFramesPlusDB["global"]["mouseshow"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetChecked(false);
        end
        UnitFramesPlus_PetBarTextMouseShow();
        self:SetChecked(UnitFramesPlusDB["pet"]["mouseshow"]==1);
    end)

    --宠物Shift拖动头像
    local UnitFramesPlus_OptionsFrame_PetShiftDrag = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PetShiftDrag", UnitFramesPlus_Pet_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PetShiftDrag:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PetShiftDrag:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PetMouseShow, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PetShiftDrag:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PetShiftDragText:SetText(UFP_OP_Shift_Movable);
    UnitFramesPlus_OptionsFrame_PetShiftDrag:SetScript("OnClick", function(self)
        UnitFramesPlusDB["pet"]["movable"] = 1 - UnitFramesPlusDB["pet"]["movable"];
        self:SetChecked(UnitFramesPlusDB["pet"]["movable"]==1);
    end)

    --宠物头像内战斗信息
    local UnitFramesPlus_OptionsFrame_PetPortraitIndicator = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PetPortraitIndicator", UnitFramesPlus_Pet_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PetPortraitIndicator:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PetPortraitIndicator:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PetShiftDrag, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PetPortraitIndicator:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PetPortraitIndicatorText:SetText(UFP_OP_Portrait_Indicator);
    UnitFramesPlus_OptionsFrame_PetPortraitIndicator:SetScript("OnClick", function(self)
        UnitFramesPlusDB["pet"]["indicator"] = 1 - UnitFramesPlusDB["pet"]["indicator"];
        UnitFramesPlus_PetPortraitIndicator();
        if UnitFramesPlusDB["pet"]["indicator"] == 1 then
            if UnitFramesPlusDB["player"]["indicator"] == 1 
            and UnitFramesPlusDB["target"]["indicator"] == 1 
            and UnitFramesPlusDB["party"]["indicator"] == 1 then
                UnitFramesPlusDB["global"]["indicator"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetChecked(true);
            end
        else
            UnitFramesPlusDB["global"]["indicator"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetChecked(false);
        end
        self:SetChecked(UnitFramesPlusDB["pet"]["indicator"]==1);
    end)

    --宠物目标
    local UnitFramesPlus_OptionsFrame_PetTarget = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PetTarget", UnitFramesPlus_Pet_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PetTarget:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PetTarget:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PetPortraitIndicator, "TOPLEFT", 0, -60);
    UnitFramesPlus_OptionsFrame_PetTarget:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PetTargetText:SetText(UFP_OP_Pet_Target);
    UnitFramesPlus_OptionsFrame_PetTarget:SetScript("OnClick", function(self)
        UnitFramesPlusDB["pet"]["target"] = 1 - UnitFramesPlusDB["pet"]["target"];
        if UnitFramesPlusDB["pet"]["target"] == 1 then
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PetTargetTmp);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PetTargetHPPct);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PetTargetShiftDrag);
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PetTargetScaleSlider);
        else
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PetTargetTmp);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PetTargetHPPct);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PetTargetShiftDrag);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PetTargetScaleSlider);
        end
        UnitFramesPlus_PetTarget();
        self:SetChecked(UnitFramesPlusDB["pet"]["target"]==1);
    end)

    --宠物目标临时显示
    local UnitFramesPlus_OptionsFrame_PetTargetTmp = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PetTargetTmp", UnitFramesPlus_Pet_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PetTargetTmp:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PetTargetTmp:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PetTarget, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_PetTargetTmp:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PetTargetTmpText:SetText(UFP_OP_Pet_TargetTmp);
    UnitFramesPlus_OptionsFrame_PetTargetTmp:SetScript("OnClick", function(self)
        UnitFramesPlusDB["pet"]["targettmp"] = 1 - UnitFramesPlusDB["pet"]["targettmp"];
        if UnitFramesPlusDB["pet"]["targettmp"] == 1 then
            UFP_ToPetFrameBase:SetAlpha(1);
        else
            UFP_ToPetFrameBase:SetAlpha(0);
        end
        self:SetChecked(UnitFramesPlusDB["pet"]["targettmp"]==1);
    end)

    --宠物目标生命值百分比
    local UnitFramesPlus_OptionsFrame_PetTargetHPPct = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PetTargetHPPct", UnitFramesPlus_Pet_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PetTargetHPPct:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PetTargetHPPct:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PetTarget, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PetTargetHPPct:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PetTargetHPPctText:SetText(UFP_OP_HPPct);
    UnitFramesPlus_OptionsFrame_PetTargetHPPct:SetScript("OnClick", function(self)
        UnitFramesPlusDB["pet"]["hppct"] = 1 - UnitFramesPlusDB["pet"]["hppct"];
        self:SetChecked(UnitFramesPlusDB["pet"]["hppct"]==1);
    end)

    --宠物目标Shift拖动头像
    local UnitFramesPlus_OptionsFrame_PetTargetShiftDrag = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PetTargetShiftDrag", UnitFramesPlus_Pet_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PetTargetShiftDrag:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PetTargetShiftDrag:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PetTargetHPPct, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PetTargetShiftDrag:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PetTargetShiftDragText:SetText(UFP_OP_Shift_Movable);
    UnitFramesPlus_OptionsFrame_PetTargetShiftDrag:SetScript("OnClick", function(self)
        UnitFramesPlusDB["pet"]["targetmovable"] = 1 - UnitFramesPlusDB["pet"]["targetmovable"];
        self:SetChecked(UnitFramesPlusDB["pet"]["targetmovable"]==1);
    end)

    --宠物目标缩放
    local UnitFramesPlus_OptionsFrame_PetTargetScaleSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_PetTargetScaleSlider", UnitFramesPlus_Pet_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_PetTargetScaleSlider:SetWidth(154);
    UnitFramesPlus_OptionsFrame_PetTargetScaleSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_PetTargetScaleSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PetTargetScaleSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PetTargetShiftDrag, "TOPLEFT", 8, -60);
    UnitFramesPlus_OptionsFrame_PetTargetScaleSliderText:SetText(UFP_OP_Scale..(UnitFramesPlusDB["pet"]["scale"]*100).."%");
    UnitFramesPlus_OptionsFrame_PetTargetScaleSliderLow:SetText("50%");
    UnitFramesPlus_OptionsFrame_PetTargetScaleSliderHigh:SetText("150%");
    UnitFramesPlus_OptionsFrame_PetTargetScaleSlider:SetMinMaxValues(50,150);
    UnitFramesPlus_OptionsFrame_PetTargetScaleSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_PetTargetScaleSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_PetTargetScaleSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["pet"]["scale"] ~= value/100 then
			UnitFramesPlusDB["pet"]["scale"] = value/100;
			UnitFramesPlus_PetTargetScale(UnitFramesPlusDB["pet"]["scale"]);
			UnitFramesPlus_OptionsFrame_PetTargetScaleSliderText:SetText(UFP_OP_Scale..(UnitFramesPlusDB["pet"]["scale"]*100).."%");
		end
    end)

    --目标设定
    local targetconfig = UnitFramesPlus_Target_Options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    targetconfig:ClearAllPoints();
    targetconfig:SetPoint("TOPLEFT", 16, -16);
    targetconfig:SetText(UFP_OP_Target_Options);

    --目标使用内置仇恨百分比
    local UnitFramesPlus_OptionsFrame_TargetThreattext = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetThreattext", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetThreattext:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetThreattext:SetPoint("TOPLEFT", targetconfig, "TOPLEFT", 0, -40);
    UnitFramesPlus_OptionsFrame_TargetThreattext:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetThreattextText:SetText(UFP_OP_BuiltinThreattext);
    UnitFramesPlus_OptionsFrame_TargetThreattext:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["threattext"] = 1 - UnitFramesPlusDB["target"]["threattext"];
        UnitFramesPlus_TargetThreat();
        UnitFramesPlus_TargetThreatDisplayUpdate();
        self:SetChecked(UnitFramesPlusDB["target"]["threattext"]==1);
    end)

	--目标鼠标移过时才显示数值
    local UnitFramesPlus_OptionsFrame_TargetMouseShow = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetMouseShow", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetMouseShow:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetMouseShow:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetThreattext , "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetMouseShow:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetMouseShowText:SetText(UFP_OP_Mouse_Show);
    UnitFramesPlus_OptionsFrame_TargetMouseShow:SetScript("OnClick", function(self)
        if tonumber(GetCVar("statusText")) ~= 1 then
            StaticPopup_Show("UFP_MOUSESHOW");
            self:SetChecked(UnitFramesPlusDB["target"]["mouseshow"]==1);
            return;
        end
        UnitFramesPlusDB["target"]["mouseshow"] = 1 - UnitFramesPlusDB["target"]["mouseshow"];
        if UnitFramesPlusDB["target"]["mouseshow"] == 1 then
            if UnitFramesPlusDB["player"]["mouseshow"] == 1
            and UnitFramesPlusDB["pet"]["mouseshow"] == 1 
			and UnitFramesPlusDB["party"]["mouseshow"] == 1 
            and UnitFramesPlusDB["extra"]["pvpmouseshow"] == 1 then
                UnitFramesPlusDB["global"]["mouseshow"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetChecked(true);
            end
        else
            UnitFramesPlusDB["global"]["mouseshow"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetChecked(false);
        end
        UnitFramesPlus_TargetHPValueDisplayUpdate()
        UnitFramesPlus_TargetMPValueDisplayUpdate()
        UnitFramesPlus_TargetBarTextMouseShow();
        self:SetChecked(UnitFramesPlusDB["target"]["mouseshow"]==1);
    end)

    --目标不显示扩展框时的生命值和法力值(百分比)
    local UnitFramesPlus_OptionsFrame_TargetHPMPPct = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetHPMPPct", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetHPMPPct:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetHPMPPct:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetMouseShow, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetHPMPPct:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetHPMPPctText:SetText(UFP_OP_HPMP);
    UnitFramesPlus_OptionsFrame_TargetHPMPPct:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["hpmp"] = 1 - UnitFramesPlusDB["target"]["hpmp"];
        if UnitFramesPlusDB["target"]["hpmp"] == 1 then
            UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne);
            UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetHPMPUnit);
            if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider);
            end
			BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider);
        else
            UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne);
            UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetHPMPUnit);
            if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
                BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider);
            end
			if not showOptions then
				BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider);
			end
        end
        UnitFramesPlus_TargetHPMPPct();
        UnitFramesPlus_TargetHPValueDisplayUpdate();
        UnitFramesPlus_TargetMPValueDisplayUpdate();
        self:SetChecked(UnitFramesPlusDB["target"]["hpmp"]==1);
    end)

    --目标生命值/法力值/百分比第一部分
    local UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne", UnitFramesPlus_Target_Options, "UIDropDownMenuTemplate");
    UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetHPMPPct, "TOPLEFT", 165, 0);
    UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne:SetHitRectInsets(0, -100, 0, 0);
    UIDropDownMenu_SetWidth(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne, 95);
    UIDropDownMenu_Initialize(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne, TargetHPMPPctPartOne_Init);
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne, UnitFramesPlusDB["target"]["hpmppartone"]);

    --目标斜线
    local splitline = UnitFramesPlus_Target_Options:CreateFontString(nil, "ARTWORK", "TextStatusBarText");
    splitline:ClearAllPoints();
    splitline:SetPoint("LEFT", UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne, "RIGHT", -5, 0);
    splitline:SetText("/");

    --目标生命值/法力值/百分比第二部分
    local UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo", UnitFramesPlus_Target_Options, "UIDropDownMenuTemplate");
    UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo:SetPoint("LEFT", splitline, "RIGHT", -11, 0);
    UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo:SetHitRectInsets(0, -100, 0, 0);
    UIDropDownMenu_SetWidth(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo, 95);
    UIDropDownMenu_Initialize(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo, TargetHPMPPctPartTwo_Init);
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo, UnitFramesPlusDB["target"]["hpmpparttwo"]);
	
	--目标生命值、法力值字体大小
    local UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider", UnitFramesPlus_Target_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetHPMPPct, "TOPLEFT", 30, -45);
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSliderText:SetText(UFP_OP_FontSize..UnitFramesPlusDB["target"]["fontsize"]);
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSliderLow:SetText("8");
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSliderHigh:SetText("18");
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider:SetMinMaxValues(8,18);
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["target"]["fontsize"] ~= value then
            UnitFramesPlusDB["target"]["fontsize"] = value;
            UnitFramesPlus_TargetExtraTextFontSize();
            UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSliderText:SetText(UFP_OP_FontSize..UnitFramesPlusDB["target"]["fontsize"]);
        end
    end)
	
if showOptions then
    --目标扩展框
    local UnitFramesPlus_OptionsFrame_TargetExtrabar = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetExtrabar", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetExtrabar:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetExtrabar:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider, "TOPLEFT", 149, 0);
    UnitFramesPlus_OptionsFrame_TargetExtrabar:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetExtrabarText:SetText(UFP_OP_Player_Extrabar);
    UnitFramesPlus_OptionsFrame_TargetExtrabar:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["extrabar"] = 1 - UnitFramesPlusDB["target"]["extrabar"];
        if UnitFramesPlusDB["target"]["extrabar"] == 1 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetHPMPPct);
            UnitFramesPlusDB["target"]["hpmp"] = 1;
            UnitFramesPlus_OptionsFrame_TargetHPMPPct:SetChecked(UnitFramesPlusDB["target"]["hpmp"]==1);
            UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne);
            UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetHPMPUnit);
        else
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetHPMPPct);
        end
        UnitFramesPlus_TargetExtrabar();
        self:SetChecked(UnitFramesPlusDB["target"]["extrabar"]==1);
    end)
end
	
	 --目标生命值、法力值单位
    local UnitFramesPlus_OptionsFrame_TargetHPMPUnit = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetHPMPUnit", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetHPMPUnit:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetHPMPUnit:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetHPMPPct, "TOPLEFT", 0, -90);
    UnitFramesPlus_OptionsFrame_TargetHPMPUnit:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetHPMPUnitText:SetText(UFP_OP_Player_Unit);
    UnitFramesPlus_OptionsFrame_TargetHPMPUnit:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["hpmpunit"] = 1 - UnitFramesPlusDB["target"]["hpmpunit"];
        if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
            if UnitFramesPlusDB["target"]["hpmpunit"] == 1 then
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider);
            else
                BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider);
            end
        end
        UnitFramesPlus_TargetHPValueDisplayUpdate();
        UnitFramesPlus_TargetMPValueDisplayUpdate();
        self:SetChecked(UnitFramesPlusDB["target"]["hpmpunit"]==1);
    end)

    --目标生命值、法力值单位
    if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
        local UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider", UnitFramesPlus_Target_Options, "OptionsSliderTemplate");
        UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider:SetWidth(95);
        UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider:SetHeight(16);
        UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider:ClearAllPoints();
        UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetHPMPUnit, "TOPLEFT", 183, 0);
        UnitFramesPlus_OptionsFrame_TargetUnitTypeSliderLow:SetText(UFP_OP_Player_UnitK);
        UnitFramesPlus_OptionsFrame_TargetUnitTypeSliderHigh:SetText(UFP_OP_Player_UnitW);
        UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider:SetMinMaxValues(1,2);
        UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider:SetValueStep(1);
        UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider:SetObeyStepOnDrag(true);
        UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider:SetScript("OnValueChanged", function(self, value)
			if UnitFramesPlusDB["target"]["unittype"] ~= value then
				UnitFramesPlusDB["target"]["unittype"] = value;
				UnitFramesPlus_TargetHPValueDisplayUpdate();
				UnitFramesPlus_TargetMPValueDisplayUpdate();
			end
        end)
    end

    --目标职业按钮
    local UnitFramesPlus_OptionsFrame_TargetClassIcon = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetClassIcon", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetClassIcon:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetClassIcon:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetBartext or UnitFramesPlus_OptionsFrame_TargetHPMPUnit, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetClassIcon:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetClassIconText:SetText(UFP_OP_ClassIcon);
    UnitFramesPlus_OptionsFrame_TargetClassIcon:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["classicon"] = 1 - UnitFramesPlusDB["target"]["classicon"];
        if UnitFramesPlusDB["target"]["classicon"] == 1 then
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetClassIconMore);
        else
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetClassIconMore);
        end
        UnitFramesPlus_TargetClassIcon();
        UnitFramesPlus_TargetClassIconDisplayUpdate();
        self:SetChecked(UnitFramesPlusDB["target"]["classicon"]==1);
    end)

    --目标职业图标左键观察，右键交易，中键密语，4键跟随
    local UnitFramesPlus_OptionsFrame_TargetClassIconMore = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetClassIconMore", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetClassIconMore:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetClassIconMore:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetClassIcon, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_TargetClassIconMore:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetClassIconMoreText:SetText(UFP_OP_ClassIcon_MoreAction);
    UnitFramesPlus_OptionsFrame_TargetClassIconMore:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["moreaction"] = 1 - UnitFramesPlusDB["target"]["moreaction"];
        self:SetChecked(UnitFramesPlusDB["target"]["moreaction"]==1);
    end)

if showOptions then
    --目标种族或类型
    local UnitFramesPlus_OptionsFrame_TargetRace = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetRace", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetRace:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetRace:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetClassIcon, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetRace:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetRaceText:SetText(UFP_OP_Race);
    UnitFramesPlus_OptionsFrame_TargetRace:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["race"] = 1 - UnitFramesPlusDB["target"]["race"];
        UnitFramesPlus_TargetRace();
        UnitFramesPlus_TargetRaceDisplayUpdate();
        self:SetChecked(UnitFramesPlusDB["target"]["race"]==1);
    end)

    --目标调节目标buff/debuff图标大小
    local UnitFramesPlus_OptionsFrame_TargetBuffSize = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetBuffSize", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetBuffSize:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetBuffSize:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetRace, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetBuffSize:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeText:SetText(UFP_OP_Target_BuffSize);
    UnitFramesPlus_OptionsFrame_TargetBuffSize:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["buffsize"] = 1 - UnitFramesPlusDB["target"]["buffsize"];
        if UnitFramesPlusDB["target"]["buffsize"] == 1 then
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider);
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider);
        else
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider);
        end
        self:SetChecked(UnitFramesPlusDB["target"]["buffsize"]==1);
    end)

    --目标自己施放的buff/debuff大小
    local UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider", UnitFramesPlus_Target_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetBuffSize, "TOPLEFT", 30, -45);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSliderText:SetText(UFP_OP_Target_MySize..UnitFramesPlusDB["target"]["mysize"]);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSliderLow:SetText("8");
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSliderHigh:SetText("32");
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider:SetMinMaxValues(8,32);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider:SetScript("OnValueChanged", function(self, value)
		if UnitFramesPlusDB["target"]["mysize"] ~= value then
			UnitFramesPlusDB["target"]["mysize"] = value;
			UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSliderText:SetText(UFP_OP_Target_MySize..UnitFramesPlusDB["target"]["mysize"]);
		end
	end)

    --目标其他人施放的buff/debuff大小
    local UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider", UnitFramesPlus_Target_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider, "TOPLEFT", 153, 0);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSliderText:SetText(UFP_OP_Target_OtherSize..UnitFramesPlusDB["target"]["othersize"]);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSliderLow:SetText("8");
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSliderHigh:SetText("32");
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider:SetMinMaxValues(8,32);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["target"]["othersize"] ~= value then
			UnitFramesPlusDB["target"]["othersize"] = value;
			UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSliderText:SetText(UFP_OP_Target_OtherSize..UnitFramesPlusDB["target"]["othersize"]);
		end
	end)
end

    --目标头像类型开关
    local UnitFramesPlus_OptionsFrame_TargetPortraitType = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetPortraitType", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
	-- local TargetPortraitTypeX = UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider and -30 or 0
	-- local TargetPortraitTypeY = UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider and -35 or -30
    UnitFramesPlus_OptionsFrame_TargetPortraitType:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetPortraitType:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetBuffSize or UnitFramesPlus_OptionsFrame_TargetClassIcon, "TOPLEFT", 0, UnitFramesPlus_OptionsFrame_TargetBuffSize and -90 or -30);
    UnitFramesPlus_OptionsFrame_TargetPortraitType:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeText:SetText(UFP_OP_Portrait);
    UnitFramesPlus_OptionsFrame_TargetPortraitType:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["portrait"] = 1 - UnitFramesPlusDB["target"]["portrait"];
        UnitFramesPlus_TargetPortrait();
		UnitFramesPlus_TargetPortraitDisplayUpdate();
        if UnitFramesPlusDB["target"]["portrait"] == 1 then
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider);
            if UnitFramesPlusDB["target"]["portraittype"] == 1 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetPortrait3DBG);
            elseif UnitFramesPlusDB["target"]["portraittype"] == 2 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo);
            end
            if UnitFramesPlusDB["player"]["portrait"] == 1 
            and UnitFramesPlusDB["target"]["portrait"] == 1 
            and UnitFramesPlusDB["party"]["portrait"] == 1 then
                UnitFramesPlusDB["global"]["portrait"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalPortraitType:SetChecked(true);
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider);
                if UnitFramesPlusDB["global"]["portraittype"] == 1 then
                    BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
                elseif UnitFramesPlusDB["global"]["portraittype"] == 2 then
                    BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
                end
            end
        else
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortrait3DBG);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo);
            UnitFramesPlusDB["global"]["portrait"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalPortraitType:SetChecked(false);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
        end
        self:SetChecked(UnitFramesPlusDB["target"]["portrait"]==1);
    end)

    --目标头像类型
    local UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider", UnitFramesPlus_Target_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetPortraitType, "TOPLEFT", 183, 0);
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeSliderLow:SetText(UFP_OP_3D);
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeSliderHigh:SetText(UFP_OP_CLASS);
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider:SetMinMaxValues(1,2);
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["target"]["portraittype"] ~= value then
			UnitFramesPlusDB["target"]["portraittype"] = value;
			UnitFramesPlus_TargetPortrait();
			UnitFramesPlus_TargetPortraitDisplayUpdate();
			if value == 1 then
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetPortrait3DBG);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo);
			elseif value == 2 then
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortrait3DBG);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo);
			end
		end
	end)

    --目标3D头像背景
    local UnitFramesPlus_OptionsFrame_TargetPortrait3DBG = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetPortrait3DBG", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetPortrait3DBG:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetPortrait3DBG:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetPortraitType, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetPortrait3DBG:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetPortrait3DBGText:SetText(UFP_OP_Portrait_3DBG);
    UnitFramesPlus_OptionsFrame_TargetPortrait3DBG:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["portrait3dbg"] = 1 - UnitFramesPlusDB["target"]["portrait3dbg"];
        UnitFramesPlus_TargetPortrait3DBGDisplayUpdate();
        if UnitFramesPlusDB["target"]["portrait3dbg"] == 1 then
            if UnitFramesPlusDB["player"]["portrait3dbg"] == 1
            and UnitFramesPlusDB["party"]["portrait3dbg"] == 1 then
                if UnitFramesPlusDB["global"]["portrait"] == 1 
                and UnitFramesPlusDB["global"]["portraittype"] == 1 then
                    UnitFramesPlusDB["global"]["portrait3dbg"] = 1;
                    UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG:SetChecked(true);
                end
            end
        else
            UnitFramesPlusDB["global"]["portrait3dbg"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG:SetChecked(false);
        end
        self:SetChecked(UnitFramesPlusDB["target"]["portrait3dbg"]==1);
    end)

    --目标为NPC时不显示职业头像
    local UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetPortrait3DBG, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetPortraitNPCNoText:SetText(UFP_OP_NPCNo);
    UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["portraitnpcno"] = 1 - UnitFramesPlusDB["target"]["portraitnpcno"];
        UnitFramesPlus_TargetPortraitDisplayUpdate();
        if UnitFramesPlusDB["target"]["portraitnpcno"] == 1 then
			if UnitFramesPlusDB["global"]["portrait"] == 1 
			and UnitFramesPlusDB["global"]["portraittype"] == 2 then
				UnitFramesPlusDB["global"]["portraitnpcno"] = 1;
				UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo:SetChecked(true);
			end
        else
            UnitFramesPlusDB["global"]["portraitnpcno"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo:SetChecked(false);
        end
        self:SetChecked(UnitFramesPlusDB["target"]["portraitnpcno"]==1);
    end)

    --目标Shift拖动头像
    local UnitFramesPlus_OptionsFrame_TargetShiftDrag = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetShiftDrag", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetShiftDrag:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetShiftDrag:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetPortrait3DBG, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetShiftDrag:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetShiftDragText:SetText(UFP_OP_Shift_Movable);
    UnitFramesPlus_OptionsFrame_TargetShiftDrag:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["movable"] = 1 - UnitFramesPlusDB["target"]["movable"];
        if UnitFramesPlusDB["target"]["movable"] == 1 then
            if UnitFramesPlusDB["player"]["movable"] == 1 
            and UnitFramesPlusDB["targettarget"]["movable"] == 1 
            and UnitFramesPlusDB["party"]["movable"] == 1 then
                UnitFramesPlusDB["global"]["movable"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalShiftDrag:SetChecked(true);
            end
        else
            UnitFramesPlusDB["global"]["movable"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalShiftDrag:SetChecked(false);
        end
        self:SetChecked(UnitFramesPlusDB["target"]["movable"]==1);
    end)

    --目标头像内战斗信息
    local UnitFramesPlus_OptionsFrame_TargetPortraitIndicator = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetPortraitIndicator", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetPortraitIndicator:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetPortraitIndicator:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetShiftDrag, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetPortraitIndicator:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetPortraitIndicatorText:SetText(UFP_OP_Portrait_Indicator);
    UnitFramesPlus_OptionsFrame_TargetPortraitIndicator:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["indicator"] = 1 - UnitFramesPlusDB["target"]["indicator"];
        UnitFramesPlus_TargetPortraitIndicator();
        if UnitFramesPlusDB["target"]["indicator"] == 1 then
            if UnitFramesPlusDB["player"]["indicator"] == 1 
            and UnitFramesPlusDB["pet"]["indicator"] == 1 
            and UnitFramesPlusDB["party"]["indicator"] == 1 then
                UnitFramesPlusDB["global"]["indicator"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetChecked(true);
            end
        else
            UnitFramesPlusDB["global"]["indicator"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetChecked(false);
        end
        self:SetChecked(UnitFramesPlusDB["target"]["indicator"]==1);
    end)

if showOptions then
    --目标生命条染色
    local UnitFramesPlus_OptionsFrame_TargetColorHP = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetColorHP", UnitFramesPlus_Target_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetColorHP:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetColorHP:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetPortraitIndicator, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetColorHP:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetColorHPText:SetText(UFP_OP_ColorHP);
    UnitFramesPlus_OptionsFrame_TargetColorHP:SetScript("OnClick", function(self)
        UnitFramesPlusDB["target"]["colorhp"] = 1 - UnitFramesPlusDB["target"]["colorhp"];
        if UnitFramesPlusDB["target"]["colorhp"] == 1 then
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_TargetColorHPSlider);
        else
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetColorHPSlider);
        end
        -- UnitFramesPlus_TargetColorHPBar();
        UnitFramesPlus_TargetColorHPBarDisplayUpdate();
        if UnitFramesPlusDB["target"]["colorhp"] == 1 then
            if UnitFramesPlusDB["player"]["colorhp"] == 1 
            and UnitFramesPlusDB["party"]["colorhp"] == 1 then
                UnitFramesPlusDB["global"]["colorhp"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalColorHP:SetChecked(true);
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_GlobalColorHPSlider);
            end
        else
            UnitFramesPlusDB["global"]["colorhp"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalColorHP:SetChecked(false);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_GlobalColorHPSlider);
        end
        self:SetChecked(UnitFramesPlusDB["target"]["colorhp"]==1);
    end)

    --目标生命条染色类型
    local UnitFramesPlus_OptionsFrame_TargetColorHPSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_TargetColorHPSlider", UnitFramesPlus_Target_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_TargetColorHPSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_TargetColorHPSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_TargetColorHPSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetColorHPSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetColorHP, "TOPLEFT", 183, 0);
    UnitFramesPlus_OptionsFrame_TargetColorHPSliderLow:SetText(UFP_OP_ColorHP_Class);
    UnitFramesPlus_OptionsFrame_TargetColorHPSliderHigh:SetText(UFP_OP_ColorHP_HPPct);
    UnitFramesPlus_OptionsFrame_TargetColorHPSlider:SetMinMaxValues(1,2);
    UnitFramesPlus_OptionsFrame_TargetColorHPSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_TargetColorHPSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_TargetColorHPSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["target"]["colortype"] ~= value then
			UnitFramesPlusDB["target"]["colortype"] = value;
			-- UnitFramesPlus_TargetColorHPBar();
			UnitFramesPlus_TargetColorHPBarDisplayUpdate();
		end
	end)

	--目标头像缩放
    local UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider", UnitFramesPlus_Target_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider:SetWidth(154);
    UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetColorHP, "TOPLEFT", 8, -50);
    UnitFramesPlus_OptionsFrame_TargetFrameScaleSliderText:SetText(UFP_OP_Scale..(UnitFramesPlusDB["target"]["scale"]*100).."%");
    UnitFramesPlus_OptionsFrame_TargetFrameScaleSliderLow:SetText("50%");
    UnitFramesPlus_OptionsFrame_TargetFrameScaleSliderHigh:SetText("150%");
    UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider:SetMinMaxValues(50,150);
    UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["target"]["scale"] ~= value/100 then
			UnitFramesPlusDB["target"]["scale"] = value/100;
			UnitFramesPlus_TargetFrameScale(UnitFramesPlusDB["target"]["scale"]);
			local left = TargetFrame:GetLeft();
			local bottom = TargetFrame:GetBottom();
			UnitFramesPlusVar["target"]["x"] = left;
			UnitFramesPlusVar["target"]["y"] = bottom;
			UnitFramesPlus_OptionsFrame_TargetFrameScaleSliderText:SetText(UFP_OP_Scale..(UnitFramesPlusDB["target"]["scale"]*100).."%");
		end
	end)
end

    --目标的目标设定
    local totconfig = UnitFramesPlus_TargetTarget_Options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    totconfig:ClearAllPoints();
    totconfig:SetPoint("TOPLEFT", 16, -16);
    totconfig:SetText(UFP_OP_ToT_Options);

    --目标的目标系统ToT状态
    --[[
	local UnitFramesPlus_OptionsFrame_TargetTargetSYSToT = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTargetSYSToT", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetSYSToT:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetSYSToT:SetPoint("TOPLEFT", totconfig, "TOPLEFT", 0, -40);
    UnitFramesPlus_OptionsFrame_TargetTargetSYSToT:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetSYSToTText:SetText(UFP_OP_Target_SYSToT);
    UnitFramesPlus_OptionsFrame_TargetTargetSYSToT:SetScript("OnClick", function(self)
        if not InCombatLockdown() then
            --InterfaceOptionsFrame_OpenToCategory(InterfaceOptionsCombatPanel);
            -- InterfaceOptionsFrame:Hide();
            -- GameMenuButtonUIOptions:Click();
            -- InterfaceOptionsFrameCategoriesButton2:Click();
            C_CVar.SetCVar("showTargetOfTarget", 1 - tonumber(C_CVar.GetCVar("showTargetOfTarget")))
			self:SetChecked(tonumber(C_CVar.GetCVar("showTargetOfTarget"))==1);
        end
    end)
	

    --目标的目标在进入游戏时自动关闭系统目标的目标
    local UnitFramesPlus_OptionsFrame_TargetTargetAutoToT = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTargetAutoToT", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetAutoToT:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetAutoToT:SetPoint("TOPLEFT", totconfig, "TOPLEFT", 0, -40);
    UnitFramesPlus_OptionsFrame_TargetTargetAutoToT:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetAutoToTText:SetText(UFP_OP_Target_AutoToT);
    UnitFramesPlus_OptionsFrame_TargetTargetAutoToT:SetScript("OnClick", function(self)
        UnitFramesPlusDB["targettarget"]["systot"] = 1 - UnitFramesPlusDB["targettarget"]["systot"];
        self:SetChecked(UnitFramesPlusDB["targettarget"]["systot"]==1);
    end)
	--]]

    --目标的目标
    local UnitFramesPlus_OptionsFrame_TargetTarget = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTarget", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTarget:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTarget:SetPoint("TOPLEFT", totconfig, "TOPLEFT", 0, -40);
    UnitFramesPlus_OptionsFrame_TargetTarget:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetText:SetText(UFP_OP_Target_ToT);
    UnitFramesPlus_OptionsFrame_TargetTarget:SetScript("OnClick", function(self)
        UnitFramesPlusDB["targettarget"]["showtot"] = 1 - UnitFramesPlusDB["targettarget"]["showtot"];
        if UnitFramesPlusDB["targettarget"]["showtot"] == 1 then
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetTarget);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetDebuff);
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetHPPct);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheck);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetColorName);
            if UnitFramesPlusDB["targettarget"]["colorname"] == 1 then
	            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo);
	        end
            -- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetShortName);
            -- UnitFramesPlus_OptionsFrame_TargetTargetShortNameText:SetTextColor(1, 0.82, 0);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait);
            if UnitFramesPlusDB["targettarget"]["portrait"] == 1 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo);
            end
        else
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetTarget);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetDebuff);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetHPPct);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheck);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetColorName);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo);
            -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetShortName);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo);
        end
        UnitFramesPlus_TargetTarget();
        UnitFramesPlus_TargetTargetTarget();
        self:SetChecked(UnitFramesPlusDB["targettarget"]["showtot"]==1);
    end)

    --目标的目标的目标
    local UnitFramesPlus_OptionsFrame_TargetTargetTarget = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTargetTarget", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetTarget:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetTarget:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetTarget, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetTarget:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetTargetText:SetText(UFP_OP_Target_ToToT);
    UnitFramesPlus_OptionsFrame_TargetTargetTarget:SetScript("OnClick", function(self)
        UnitFramesPlusDB["targettarget"]["showtotot"] = 1 - UnitFramesPlusDB["targettarget"]["showtotot"];
        UnitFramesPlus_TargetTargetTarget();
        self:SetChecked(UnitFramesPlusDB["targettarget"]["showtotot"]==1);
    end)

    --目标的目标职业图标头像
    local UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetTarget, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitText:SetText(UFP_OP_ClassPortrait);
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait:SetScript("OnClick", function(self)
        UnitFramesPlusDB["targettarget"]["portrait"] = 1 - UnitFramesPlusDB["targettarget"]["portrait"];
        UnitFramesPlus_TargetTargetClassPortraitDisplayUpdate();
        UnitFramesPlus_TargetTargetTargetClassPortraitDisplayUpdate();
        if UnitFramesPlusDB["targettarget"]["portrait"] == 1 then
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo);
        else
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo);
        end
        self:SetChecked(UnitFramesPlusDB["targettarget"]["portrait"]==1);
    end)

    --目标的目标为NPC时不显示职业头像
    local UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNoText:SetText(UFP_OP_NPCNo);
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo:SetScript("OnClick", function(self)
        UnitFramesPlusDB["targettarget"]["portraitnpcno"] = 1 - UnitFramesPlusDB["targettarget"]["portraitnpcno"];
        UnitFramesPlus_TargetTargetClassPortraitDisplayUpdate();
        UnitFramesPlus_TargetTargetTargetClassPortraitDisplayUpdate();
        self:SetChecked(UnitFramesPlusDB["targettarget"]["portraitnpcno"]==1);
    end)

    --目标的目标生命值百分比
    local UnitFramesPlus_OptionsFrame_TargetTargetHPPct = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTargetHPPct", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetHPPct:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetHPPct:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetTargetHPPct:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetHPPctText:SetText(UFP_OP_HPPct);
    UnitFramesPlus_OptionsFrame_TargetTargetHPPct:SetScript("OnClick", function(self)
        UnitFramesPlusDB["targettarget"]["hppct"] = 1 - UnitFramesPlusDB["targettarget"]["hppct"];
        self:SetChecked(UnitFramesPlusDB["targettarget"]["hppct"]==1);
    end)

    --目标的目标敌友检测
    local UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheck = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheck", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheck:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheck:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetTargetHPPct, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheck:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheckText:SetText(UFP_OP_EnemyCheck);
    UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheck:SetScript("OnClick", function(self)
        UnitFramesPlusDB["targettarget"]["enemycheck"] = 1 - UnitFramesPlusDB["targettarget"]["enemycheck"];
        if UnitFramesPlusDB["targettarget"]["enemycheck"] ~= 1 then
            _G["UFP_ToTFrame"].Highlight:SetAlpha(0);
            _G["UFP_ToToTFrame"].Highlight:SetAlpha(0);
        end
        self:SetChecked(UnitFramesPlusDB["targettarget"]["enemycheck"]==1);
    end)

    --目标的目标名字职业染色
    local UnitFramesPlus_OptionsFrame_TargetTargetColorName = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTargetColorName", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetColorName:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetColorName:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheck, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetTargetColorName:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetColorNameText:SetText(UFP_OP_ColorName);
    UnitFramesPlus_OptionsFrame_TargetTargetColorName:SetScript("OnClick", function(self)
        UnitFramesPlusDB["targettarget"]["colorname"] = 1 - UnitFramesPlusDB["targettarget"]["colorname"];
        if UnitFramesPlusDB["targettarget"]["colorname"] == 1 then
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo);
        else
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo);
        end
        self:SetChecked(UnitFramesPlusDB["targettarget"]["colorname"]==1);
    end)

    --目标的目标名字职业染色NPC不显示
    local UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetTargetColorName, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNoText:SetText(UFP_OP_NPCNo);
    UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo:SetScript("OnClick", function(self)
        UnitFramesPlusDB["targettarget"]["colornamenpcno"] = 1 - UnitFramesPlusDB["targettarget"]["colornamenpcno"];
        self:SetChecked(UnitFramesPlusDB["targettarget"]["colornamenpcno"]==1);
    end)

    --目标的目标debuff
    local UnitFramesPlus_OptionsFrame_TargetTargetDebuff = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTargetDebuff", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetDebuff:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetDebuff:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetTargetColorName, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetTargetDebuff:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetDebuffText:SetText(UFP_OP_Debuff);
    UnitFramesPlus_OptionsFrame_TargetTargetDebuff:SetScript("OnClick", function(self)
        UnitFramesPlusDB["targettarget"]["debuff"] = 1 - UnitFramesPlusDB["targettarget"]["debuff"];
        UnitFramesPlus_TargetTargetDebuff();
        self:SetChecked(UnitFramesPlusDB["targettarget"]["debuff"]==1);
    end)

    --目标的目标Shift拖动头像
    local UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag", UnitFramesPlus_TargetTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetTargetDebuff, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_TargetTargetShiftDragText:SetText(UFP_OP_Shift_Movable);
    UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag:SetScript("OnClick", function(self)
        UnitFramesPlusDB["targettarget"]["movable"] = 1 - UnitFramesPlusDB["targettarget"]["movable"];
        self:SetChecked(UnitFramesPlusDB["targettarget"]["movable"]==1);
    end)

    --目标的目标缩放
    local UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider", UnitFramesPlus_TargetTarget_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider:SetWidth(154);
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag, "TOPLEFT", 8, -60);
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSliderText:SetText(UFP_OP_Scale..(UnitFramesPlusDB["targettarget"]["scale"]*100).."%");
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSliderLow:SetText("50%");
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSliderHigh:SetText("150%");
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider:SetMinMaxValues(50,150);
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["targettarget"]["scale"] ~= value/100 then
			UnitFramesPlusDB["targettarget"]["scale"] = value/100;
			UnitFramesPlus_TargetTargetScale(UnitFramesPlusDB["targettarget"]["scale"]);
			UnitFramesPlus_OptionsFrame_TargetTargetScaleSliderText:SetText(UFP_OP_Scale..(UnitFramesPlusDB["targettarget"]["scale"]*100).."%");
		end
	end)

    --队伍设定
    local partyconfig = UnitFramesPlus_Party_Options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    partyconfig:ClearAllPoints();
    partyconfig:SetPoint("TOPLEFT", 16, -16);
    partyconfig:SetText(UFP_OP_Party_Options);

	--隐藏团队工具
    local UnitFramesPlus_OptionsFrame_PartyHideRaid = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyHideRaid", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyHideRaid:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyHideRaid:SetPoint("TOPLEFT", partyconfig, "TOPLEFT", 0, -40);
    UnitFramesPlus_OptionsFrame_PartyHideRaid:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyHideRaidText:SetText(UFP_OP_Party_HideRaid);
	UnitFramesPlus_OptionsFrame_PartyHideRaid:Disable()  -- 暫時停用此功能，待修復
	UnitFramesPlus_OptionsFrame_PartyHideRaidText:SetTextColor(0.5, 0.5, 0.5)
    UnitFramesPlus_OptionsFrame_PartyHideRaid:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["hideraid"] = 1 - UnitFramesPlusDB["party"]["hideraid"];
        UnitFramesPlus_HideRaidFrame();
        -- if UnitFramesPlusDB["party"]["hideraid"] == 1 then
        --     BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyInRaid);
        --     UnitFramesPlus_OptionsFrame_PartyInRaidText:SetTextColor(1, 0.82, 0);
        -- else
        --     BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyInRaid);
        -- end
        -- self:SetChecked(UnitFramesPlusDB["party"]["hideraid"]==1);
    end)

    -- StaticPopupDialogs["UFP_SHOWPARTYFRAME"] = {
    --     text = UFPLocal_ShowParty..UFP_OP_Party_Error,
    --     button1 = OKAY,
    --     button2 = CANCEL,
    --     OnAccept = function()
    --         ReloadUI();
    --     end,
    --     OnCancel = function()
    --         UnitFramesPlusDB["party"]["always"] = 1 - UnitFramesPlusDB["party"]["always"];
    --         UnitFramesPlus_OptionsFrame_PartyInRaid:SetChecked(UnitFramesPlusDB["party"]["always"]==1);
    --     end,
    --     whileDead = 1, hideOnEscape = 1, showAlert = 1
    -- }

    -- StaticPopupDialogs["UFP_SHOWPARTYFRAME2"] = {
    --     text = UFPLocal_ShowParty,
    --     button1 = OKAY,
    --     button2 = CANCEL,
    --     OnAccept = function()
    --         ReloadUI();
    --     end,
    --     OnCancel = function()
    --         UnitFramesPlusDB["party"]["always"] = 1 - UnitFramesPlusDB["party"]["always"];
    --         UnitFramesPlus_OptionsFrame_PartyInRaid:SetChecked(UnitFramesPlusDB["party"]["always"]==1);
    --     end,
    --     whileDead = 1, hideOnEscape = 1, showAlert = 1
    -- }

    --团队中显示小队
    local UnitFramesPlus_OptionsFrame_PartyInRaid = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyInRaid", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyInRaid:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyInRaid:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyHideRaid, "TOPLEFT", 220, 0);
    UnitFramesPlus_OptionsFrame_PartyInRaid:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyInRaidText:SetText(UFP_OP_Party_Always);
    UnitFramesPlus_OptionsFrame_PartyInRaid:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["always"] = 1 - UnitFramesPlusDB["party"]["always"];
        -- if UnitFramesPlusDB["party"]["always"] == 1 then
        --     StaticPopup_Show("UFP_SHOWPARTYFRAME");
        -- else
        --     StaticPopup_Show("UFP_SHOWPARTYFRAME2");
        -- end
        UnitFramesPlus_PartyShowHide();
        self:SetChecked(UnitFramesPlusDB["party"]["always"]==1);
    end)

    --自动开启传统小队界面
    local UnitFramesPlus_OptionsFrame_PartyOrigin = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyOrigin", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyOrigin:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyOrigin:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyHideRaid, "TOPLEFT", 0, -25);
    UnitFramesPlus_OptionsFrame_PartyOrigin:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyOriginText:SetText(UFP_OP_Party_Origin);
    UnitFramesPlus_OptionsFrame_PartyOrigin:SetScript("OnClick", function(self)
        -- rl = "origin";
        -- if ((not IsInGroup()) or ((not IsInRaid()) and (GetNumSubgroupMembers() > 0))) and not InCombatLockdown() then
            UnitFramesPlusDB["party"]["origin"] = 1 - UnitFramesPlusDB["party"]["origin"];
            UnitFramesPlus_PartyStyle();
            for id = 1, MAX_PARTY_MEMBERS, 1 do
                PartyMemberFrame_UpdateMember(_G["PartyMemberFrame"..id]);
            end

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
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuffHidetip);
				-- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyCastbar);
				-- BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyScaleSlider);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBartext);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyHPMPUnit);
				BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyMouseShow);
				-- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyShiftDrag);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortraitIndicator);
				if showOptions then
					BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyScaleSlider);
					BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyColorHP);
					BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
				end
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTarget);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetLite);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHPPct);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorName);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetShortName);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetDebuff);
				-- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHighlight);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
				BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider);
			else
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPet);
				BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyHP);
				if UnitFramesPlusDB["party"]["hp"] == 1 then
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyHPPct);
				end
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyColorName);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyShortName);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyLevel);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortraitType);
				if UnitFramesPlusDB["party"]["portrait"] == 1 then
					BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider);
					if UnitFramesPlusDB["party"]["portraittype"] ~= 2 then
						BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
						UnitFramesPlus_OptionsFrame_PartyPortrait3DBGText:SetTextColor(1, 0.82, 0);
					end
				end
				-- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyOfflineDetection);
				-- UnitFramesPlus_OptionsFrame_PartyOfflineDetectionText:SetTextColor(1, 0.82, 0);
				-- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyDeathGhost);
				-- UnitFramesPlus_OptionsFrame_PartyDeathGhostText:SetTextColor(1, 0.82, 0);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuff);
				if UnitFramesPlusDB["party"]["buff"] == 1 then
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuffFilter);
					if UnitFramesPlusDB["party"]["filter"] == 1 then
						UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_PartyBuffFilterType);
					end
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuffHidetip);
				end
				-- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyCastbar);
				-- UnitFramesPlus_OptionsFrame_PartyCastbarText:SetTextColor(1, 0.82, 0);
				-- BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyScaleSlider);
				-- UnitFramesPlus_OptionsFrame_PartyScaleSliderText:SetTextColor(1, 0.82, 0);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBartext);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyHPMPUnit);
				if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
					UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:SetValue(UnitFramesPlusDB["party"]["unittype"]);
					if UnitFramesPlusDB["party"]["hpmpunit"] == 1 then
						BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider);
					end
				end
				if UnitFramesPlusDB["party"]["bartext"] == 1 then
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyMouseShow);
				end
				-- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyShiftDrag);
				-- UnitFramesPlus_OptionsFrame_PartyShiftDragText:SetTextColor(1, 0.82, 0);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortraitIndicator);
				if showOptions then
					BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyScaleSlider);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyColorHP);
					if UnitFramesPlusDB["party"]["colorhp"] == 1 then
						BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
					end
				end
				if UnitFramesPlusDB["partytarget"]["show"] == 1 then
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTarget);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetLite);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetHPPct);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetColorName);
					if UnitFramesPlusDB["partytarget"]["colorname"] == 1 then
						BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
					end
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetShortName);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetDebuff);
					-- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetHighlight);
					-- UnitFramesPlus_OptionsFrame_PartyTargetHighlightText:SetTextColor(1, 0.82, 0);
					if UnitFramesPlusDB["partytarget"]["lite"] ~= 1 then
						BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
						if UnitFramesPlusDB["partytarget"]["portrait"] == 1 then
							BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
						end
					end
                end

                -- StaticPopup_Show("UFP_RELOADUI");
            end
        -- end
        self:SetChecked(UnitFramesPlusDB["party"]["origin"]==1);
		UnitFramesPlus_OptionsFrame_PartyTargetOrigin:SetChecked(UnitFramesPlusDB["party"]["origin"]==1);
    end)

    --队友宠物
    local UnitFramesPlus_OptionsFrame_PartyPet = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyPet", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyPet:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyPet:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyOrigin, "TOPLEFT", 0, -25);
    UnitFramesPlus_OptionsFrame_PartyPet:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyPetText:SetText(UFP_OP_Party_Pet);
    UnitFramesPlus_OptionsFrame_PartyPet:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["pet"] = 1 - UnitFramesPlusDB["party"]["pet"];
        UnitFramesPlus_PartyPet();
		UnitFramesPlus_PartyShowHide();
        self:SetChecked(UnitFramesPlusDB["party"]["pet"]==1);
    end)

    --队友生命值
    local UnitFramesPlus_OptionsFrame_PartyHP = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyHP", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyHP:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyHP:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyPet, "TOPLEFT", 0, -25);
    UnitFramesPlus_OptionsFrame_PartyHP:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyHPText:SetText(UFP_OP_Party_HP);
    UnitFramesPlus_OptionsFrame_PartyHP:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["hp"] = 1 - UnitFramesPlusDB["party"]["hp"];
        if UnitFramesPlusDB["party"]["hp"] == 1 then
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyHPPct);
        else
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyHPPct);
        end
        UnitFramesPlus_PartyTargetPosition();
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyHealthPctDisplayUpdate(id);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["hp"]==1);
    end)

    --队友生命值百分比
    local UnitFramesPlus_OptionsFrame_PartyHPPct = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyHPPct", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyHPPct:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyHPPct:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyHP, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_PartyHPPct:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyHPPctText:SetText(UFP_OP_Party_HPPct);
    UnitFramesPlus_OptionsFrame_PartyHPPct:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["hppct"] = 1 - UnitFramesPlusDB["party"]["hppct"];
        UnitFramesPlus_PartyTargetPosition();
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyHealthPctDisplayUpdate(id);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["hppct"]==1);
    end)

    --队友名字染色
    local UnitFramesPlus_OptionsFrame_PartyColorName = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyColorName", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyColorName:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyColorName:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyHP, "TOPLEFT", 0, -25);
    UnitFramesPlus_OptionsFrame_PartyColorName:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyColorNameText:SetText(UFP_OP_ColorName);
    UnitFramesPlus_OptionsFrame_PartyColorName:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["colorname"] = 1 - UnitFramesPlusDB["party"]["colorname"];
        UnitFramesPlus_PartyName();
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyNameDisplayUpdate(id);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["colorname"]==1);
    end)

    --队友名字显示为(*)
    local UnitFramesPlus_OptionsFrame_PartyShortName = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyShortName", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyShortName:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyShortName:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyColorName, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_PartyShortName:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyShortNameText:SetText(UFP_OP_ShortName);
    UnitFramesPlus_OptionsFrame_PartyShortName:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["shortname"] = 1 - UnitFramesPlusDB["party"]["shortname"];
        UnitFramesPlus_PartyName();
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyNameDisplayUpdate(id);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["shortname"]==1);
    end)
	
    --队友等级
    local UnitFramesPlus_OptionsFrame_PartyLevel = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyLevel", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyLevel:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyLevel:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyColorName, "TOPLEFT", 0, -25);
    UnitFramesPlus_OptionsFrame_PartyLevel:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyLevelText:SetText(UFP_OP_Party_Level);
    UnitFramesPlus_OptionsFrame_PartyLevel:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["level"] = 1 - UnitFramesPlusDB["party"]["level"];
        UnitFramesPlus_PartyLevel();
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyLevelDisplayUpdate(id);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["level"]==1);
    end)

    --队友buff/debuff直接显示
    local UnitFramesPlus_OptionsFrame_PartyBuff = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyBuff", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyBuff:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyBuff:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyLevel, "TOPLEFT", 0, -25);
    UnitFramesPlus_OptionsFrame_PartyBuff:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyBuffText:SetText(UFP_OP_Buff);
    UnitFramesPlus_OptionsFrame_PartyBuff:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["buff"] = 1 - UnitFramesPlusDB["party"]["buff"];
        if UnitFramesPlusDB["party"]["buff"] == 1 then
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuffHidetip);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuffFilter);
            UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_PartyBuffFilterType);
        else
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuffHidetip);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuffFilter);
            UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PartyBuffFilterType);
        end
        UnitFramesPlus_PartyBuff();
        self:SetChecked(UnitFramesPlusDB["party"]["buff"]==1);
    end)

    --队友buff/debuff鼠标提示
    local UnitFramesPlus_OptionsFrame_PartyBuffHidetip = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyBuffHidetip", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyBuffHidetip:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyBuffHidetip:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyBuff, "TOPLEFT", 0, -25);
    UnitFramesPlus_OptionsFrame_PartyBuffHidetip:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyBuffHidetipText:SetText(UFP_OP_HideBuffTip);
    UnitFramesPlus_OptionsFrame_PartyBuffHidetip:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["hidetip"] = 1 - UnitFramesPlusDB["party"]["hidetip"];
        self:SetChecked(UnitFramesPlusDB["party"]["hidetip"]==1);
    end)

    --队友Buff filter
    local UnitFramesPlus_OptionsFrame_PartyBuffFilter = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyBuffFilter", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyBuffFilter:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyBuffFilter:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyBuffHidetip, "TOPLEFT", 0, -25);
    UnitFramesPlus_OptionsFrame_PartyBuffFilter:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyBuffFilterText:SetText(UFP_OP_Filter);
    UnitFramesPlus_OptionsFrame_PartyBuffFilter:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["filter"] = 1 - UnitFramesPlusDB["party"]["filter"];
        if UnitFramesPlusDB["party"]["filter"] ~= 1 then
            UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PartyBuffFilterType);
        else
            UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_PartyBuffFilterType);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["filter"]==1);
    end)

    --队友Buff过滤类型
    local UnitFramesPlus_OptionsFrame_PartyBuffFilterType = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyBuffFilterType", UnitFramesPlus_Party_Options, "UIDropDownMenuTemplate");
    UnitFramesPlus_OptionsFrame_PartyBuffFilterType:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyBuffFilterType:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyBuffFilter, "TOPLEFT", 166, 0);
    UnitFramesPlus_OptionsFrame_PartyBuffFilterType:SetHitRectInsets(0, -100, 0, 0);
    UIDropDownMenu_SetWidth(UnitFramesPlus_OptionsFrame_PartyBuffFilterType, 95);
    UIDropDownMenu_Initialize(UnitFramesPlus_OptionsFrame_PartyBuffFilterType, PartyBuffFilterType_Init);
    UIDropDownMenu_SetSelectedID(UnitFramesPlus_OptionsFrame_PartyBuffFilterType, UnitFramesPlusDB["party"]["filtertype"]);

    --目标状态条数值
    local UnitFramesPlus_OptionsFrame_PartyBartext = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyBartext", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyBartext:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyBartext:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyBuffFilter, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyBartext:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyBartextText:SetText(UFP_OP_Bartex);
    UnitFramesPlus_OptionsFrame_PartyBartext:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["bartext"] = 1 - UnitFramesPlusDB["party"]["bartext"];
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyHealthPctDisplayUpdate(id);
			UnitFramesPlus_PartyPowerDisplayUpdate(id);
        end
        if UnitFramesPlusDB["party"]["bartext"] ~= 1 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyMouseShow);
        else
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyMouseShow);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["bartext"]==1);
    end)

    --队友鼠标移过时才显示数值
    local UnitFramesPlus_OptionsFrame_PartyMouseShow = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyMouseShow", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyMouseShow:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyMouseShow:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyBartext, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_PartyMouseShow:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyMouseShowText:SetText(UFP_OP_Mouse_Show);
    UnitFramesPlus_OptionsFrame_PartyMouseShow:SetScript("OnClick", function(self)
        if tonumber(GetCVar("statusText")) ~= 1 then
            StaticPopup_Show("UFP_MOUSESHOW");
            self:SetChecked(UnitFramesPlusDB["party"]["mouseshow"]==1);
            return;
        end
        UnitFramesPlusDB["party"]["mouseshow"] = 1 - UnitFramesPlusDB["party"]["mouseshow"];
        if UnitFramesPlusDB["party"]["mouseshow"] == 1 then
            if UnitFramesPlusDB["player"]["mouseshow"] == 1
            and UnitFramesPlusDB["pet"]["mouseshow"] == 1 
            and UnitFramesPlusDB["target"]["mouseshow"] == 1 
            and UnitFramesPlusDB["extra"]["pvpmouseshow"] == 1 then
                UnitFramesPlusDB["global"]["mouseshow"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetChecked(true);
            end
            -- UnitFramesPlusDB["party"]["bartext"] = 1;
            -- UnitFramesPlus_OptionsFrame_PartyBartext:SetChecked(UnitFramesPlusDB["party"]["bartext"]==1);
        else
            UnitFramesPlusDB["global"]["mouseshow"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetChecked(false);
        end
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyHealthPctDisplayUpdate(id);
			UnitFramesPlus_PartyPowerDisplayUpdate(id);
        end
        UnitFramesPlus_PartyBarTextMouseShow();
        self:SetChecked(UnitFramesPlusDB["party"]["mouseshow"]==1);
    end)

    --队友生命值、法力值字体大小
    local UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider", UnitFramesPlus_Party_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyBartext, "TOPLEFT", 30, -40);
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSliderText:SetText(UFP_OP_FontSize..UnitFramesPlusDB["party"]["fontsize"]);
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSliderLow:SetText("8");
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSliderHigh:SetText("16");
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider:SetMinMaxValues(8,16);
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["party"]["fontsize"] ~= value then
            UnitFramesPlusDB["party"]["fontsize"] = value;
            UnitFramesPlus_PartyExtraTextFontSize();
            UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSliderText:SetText(UFP_OP_FontSize..UnitFramesPlusDB["party"]["fontsize"]);
        end
    end)

    --队友生命值、法力值单位
    local UnitFramesPlus_OptionsFrame_PartyHPMPUnit = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyHPMPUnit", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyHPMPUnit:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyHPMPUnit:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyBartext, "TOPLEFT", -0, -70);
    UnitFramesPlus_OptionsFrame_PartyHPMPUnit:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyHPMPUnitText:SetText(UFP_OP_Player_Unit);
    UnitFramesPlus_OptionsFrame_PartyHPMPUnit:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["hpmpunit"] = 1 - UnitFramesPlusDB["party"]["hpmpunit"];
        if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
            if UnitFramesPlusDB["party"]["hpmpunit"] == 1 then
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider);
            else
                BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider);
            end
        end
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyHealthPctDisplayUpdate(id);
			UnitFramesPlus_PartyPowerDisplayUpdate(id);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["hpmpunit"]==1);
    end)

    --队友生命值、法力值单位
    if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
        local UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider", UnitFramesPlus_Party_Options, "OptionsSliderTemplate");
        UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:SetWidth(95);
        UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:SetHeight(16);
        UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:ClearAllPoints();
        UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyHPMPUnit, "TOPLEFT", 183, 0);
        UnitFramesPlus_OptionsFrame_PartyUnitTypeSliderLow:SetText(UFP_OP_Player_UnitK);
        UnitFramesPlus_OptionsFrame_PartyUnitTypeSliderHigh:SetText(UFP_OP_Player_UnitW);
        UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:SetMinMaxValues(1,2);
        UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:SetValueStep(1);
        UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:SetObeyStepOnDrag(true);
        UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:SetScript("OnValueChanged", function(self, value)
            if UnitFramesPlusDB["party"]["unittype"] ~= value then
				UnitFramesPlusDB["party"]["unittype"] = value;
				for id = 1, 4, 1 do
					UnitFramesPlus_PartyHealthPctDisplayUpdate(id);
					UnitFramesPlus_PartyPowerDisplayUpdate(id);
				end
			end
		end)
    end

    --队友头像类型开关
    local UnitFramesPlus_OptionsFrame_PartyPortraitType = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyPortraitType", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyPortraitType:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyPortraitType:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyHPMPUnit, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyPortraitType:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeText:SetText(UFP_OP_Portrait);
    UnitFramesPlus_OptionsFrame_PartyPortraitType:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["portrait"] = 1 - UnitFramesPlusDB["party"]["portrait"];
        UnitFramesPlus_PartyPortrait();
        if UnitFramesPlusDB["party"]["portrait"] == 1 then
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider);
            if UnitFramesPlusDB["party"]["portraittype"] == 1 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
            end
            if UnitFramesPlusDB["player"]["portrait"] == 1 
            and UnitFramesPlusDB["target"]["portrait"] == 1 
            and UnitFramesPlusDB["party"]["portrait"] == 1 then
                UnitFramesPlusDB["global"]["portrait"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalPortraitType:SetChecked(true);
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider);
                if UnitFramesPlusDB["global"]["portraittype"] == 1 then
                    BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
                elseif UnitFramesPlusDB["global"]["portraittype"] == 2 then
                    BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
                end
            end
        else
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
            UnitFramesPlusDB["global"]["portrait"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalPortraitType:SetChecked(false);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["portrait"]==1);
    end)

    --队友头像类型
    local UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider", UnitFramesPlus_Party_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyPortraitType, "TOPLEFT", 183, 0);
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeSliderLow:SetText(UFP_OP_3D);
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeSliderHigh:SetText(UFP_OP_CLASS);
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider:SetMinMaxValues(1,2);
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["party"]["portraittype"] ~= value then
			UnitFramesPlusDB["party"]["portraittype"] = value;
			UnitFramesPlus_PartyPortrait();
			if value == 1 then
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
			else
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
			end
		end
	end)

    --队友3D头像背景
    local UnitFramesPlus_OptionsFrame_PartyPortrait3DBG = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyPortrait3DBG", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyPortrait3DBG:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyPortrait3DBG:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyPortraitType, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyPortrait3DBG:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyPortrait3DBGText:SetText(UFP_OP_Portrait_3DBG);
    UnitFramesPlus_OptionsFrame_PartyPortrait3DBG:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["portrait3dbg"] = 1 - UnitFramesPlusDB["party"]["portrait3dbg"];
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyPortrait3DBGDisplayUpdate(id);
        end
        if UnitFramesPlusDB["party"]["portrait3dbg"] == 1 then
            if UnitFramesPlusDB["player"]["portrait3dbg"] == 1 
            and UnitFramesPlusDB["target"]["portrait3dbg"] == 1 then
                if UnitFramesPlusDB["global"]["portrait"] == 1 
                and UnitFramesPlusDB["global"]["portraittype"] == 1 then
                    UnitFramesPlusDB["global"]["portrait3dbg"] = 1;
                    UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG:SetChecked(true);
                end
            end
        else
            UnitFramesPlusDB["global"]["portrait3dbg"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG:SetChecked(false);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["portrait3dbg"]==1);
    end)
--[[
    --队友Shift拖动头像
    local UnitFramesPlus_OptionsFrame_PartyShiftDrag = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyShiftDrag", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyShiftDrag:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyShiftDrag:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyPortrait3DBG, "TOPLEFT", 0, -25);
    UnitFramesPlus_OptionsFrame_PartyShiftDrag:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyShiftDragText:SetText(UFP_OP_Shift_Movable);
    UnitFramesPlus_OptionsFrame_PartyShiftDrag:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["movable"] = 1 - UnitFramesPlusDB["party"]["movable"];
        if UnitFramesPlusDB["party"]["movable"] == 1 then
            if UnitFramesPlusDB["player"]["movable"] == 1 
            and UnitFramesPlusDB["target"]["movable"] == 1 
            and UnitFramesPlusDB["targettarget"]["movable"] == 1 then
                UnitFramesPlusDB["global"]["movable"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalShiftDrag:SetChecked(true);
            end
        else
            UnitFramesPlusDB["global"]["movable"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalShiftDrag:SetChecked(false);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["movable"]==1);
    end)
]]
    --队友头像内战斗信息
    local UnitFramesPlus_OptionsFrame_PartyPortraitIndicator = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyPortraitIndicator", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyPortraitIndicator:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyPortraitIndicator:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyPortrait3DBG, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyPortraitIndicator:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyPortraitIndicatorText:SetText(UFP_OP_Portrait_Indicator);
    UnitFramesPlus_OptionsFrame_PartyPortraitIndicator:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["indicator"] = 1 - UnitFramesPlusDB["party"]["indicator"];
        UnitFramesPlus_PartyPortraitIndicator();
        if UnitFramesPlusDB["party"]["indicator"] == 1 then
            if UnitFramesPlusDB["player"]["indicator"] == 1 
            and UnitFramesPlusDB["pet"]["indicator"] == 1 
            and UnitFramesPlusDB["target"]["indicator"] == 1 then
                UnitFramesPlusDB["global"]["indicator"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetChecked(true);
            end
        else
            UnitFramesPlusDB["global"]["indicator"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetChecked(false);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["indicator"]==1);
    end)

if showOptions then
	--队友生命条染色
    local UnitFramesPlus_OptionsFrame_PartyColorHP = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyColorHP", UnitFramesPlus_Party_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyColorHP:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyColorHP:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyPortraitIndicator, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyColorHP:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyColorHPText:SetText(UFP_OP_ColorHP);
    UnitFramesPlus_OptionsFrame_PartyColorHP:SetScript("OnClick", function(self)
        UnitFramesPlusDB["party"]["colorhp"] = 1 - UnitFramesPlusDB["party"]["colorhp"];
        if UnitFramesPlusDB["party"]["colorhp"] == 1 then
            BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
        else
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
        end
		if UnitFramesPlusDB["party"]["colorhp"] == 1 then
            -- UnitFramesPlus_PartyColorHPBar();
            for id = 1, 4, 1 do
                UnitFramesPlus_PartyColorHPBarDisplayUpdate(id);
            end
        else
            if UnitExists("party"..id) and UnitIsConnected("party"..id) and UnitFramesPlusDB["party"]["origin"] == 1 then
                for id = 1, 4, 1 do
                    _G["PartyMemberFrame"..id.."HealthBar"]:SetStatusBarColor(0, 1, 0);
                end
            end
        end
        if UnitFramesPlusDB["party"]["colorhp"] == 1 then
            if UnitFramesPlusDB["player"]["colorhp"] == 1 
            and UnitFramesPlusDB["target"]["colorhp"] == 1 then
                UnitFramesPlusDB["global"]["colorhp"] = 1;
                UnitFramesPlus_OptionsFrame_GlobalColorHP:SetChecked(true);
                BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_GlobalColorHPSlider);
            end
        else
            UnitFramesPlusDB["global"]["colorhp"] = 0;
            UnitFramesPlus_OptionsFrame_GlobalColorHP:SetChecked(false);
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_GlobalColorHPSlider);
        end
        self:SetChecked(UnitFramesPlusDB["party"]["colorhp"]==1);
    end)

    --队友生命条染色类型
    local UnitFramesPlus_OptionsFrame_PartyColorHPSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_PartyColorHPSlider", UnitFramesPlus_Party_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_PartyColorHPSlider:SetWidth(95);
    UnitFramesPlus_OptionsFrame_PartyColorHPSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_PartyColorHPSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyColorHPSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyColorHP, "TOPLEFT", 183, 0);
    UnitFramesPlus_OptionsFrame_PartyColorHPSliderLow:SetText(UFP_OP_ColorHP_Class);
    UnitFramesPlus_OptionsFrame_PartyColorHPSliderHigh:SetText(UFP_OP_ColorHP_HPPct);
    UnitFramesPlus_OptionsFrame_PartyColorHPSlider:SetMinMaxValues(1,2);
    UnitFramesPlus_OptionsFrame_PartyColorHPSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_PartyColorHPSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_PartyColorHPSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["party"]["colortype"] ~= value then
			UnitFramesPlusDB["party"]["colortype"] = value;
			-- UnitFramesPlus_PartyColorHPBar();
			for id = 1, 4, 1 do
				UnitFramesPlus_PartyColorHPBarDisplayUpdate(id);
			end
		end
    end)
	
	--队友头像缩放
	local UnitFramesPlus_OptionsFrame_PartyScaleSlider = CreateFrame("Slider", "UnitFramesPlus_OptionsFrame_PartyScaleSlider", UnitFramesPlus_Party_Options, "OptionsSliderTemplate");
    UnitFramesPlus_OptionsFrame_PartyScaleSlider:SetWidth(154);
    UnitFramesPlus_OptionsFrame_PartyScaleSlider:SetHeight(16);
    UnitFramesPlus_OptionsFrame_PartyScaleSlider:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyScaleSlider:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyColorHP, "TOPLEFT", 8, -50);
    UnitFramesPlus_OptionsFrame_PartyScaleSliderText:SetText(UFP_OP_Scale..(UnitFramesPlusDB["party"]["scale"]*100).."%");
    UnitFramesPlus_OptionsFrame_PartyScaleSliderLow:SetText("50%");
    UnitFramesPlus_OptionsFrame_PartyScaleSliderHigh:SetText("150%");
    UnitFramesPlus_OptionsFrame_PartyScaleSlider:SetMinMaxValues(50,150);
    UnitFramesPlus_OptionsFrame_PartyScaleSlider:SetValueStep(1);
    UnitFramesPlus_OptionsFrame_PartyScaleSlider:SetObeyStepOnDrag(true);
    UnitFramesPlus_OptionsFrame_PartyScaleSlider:SetScript("OnValueChanged", function(self, value)
        if UnitFramesPlusDB["party"]["scale"] ~= value/100 then
			UnitFramesPlusDB["party"]["scale"] = value/100;
			UnitFramesPlus_PartyScale(UnitFramesPlusDB["party"]["scale"]);
			local left = PartyMemberFrame1:GetLeft();
			local bottom = PartyMemberFrame1:GetBottom();
			UnitFramesPlusVar["party"]["x"] = left;
			UnitFramesPlusVar["party"]["y"] = bottom;
			UnitFramesPlus_OptionsFrame_PartyScaleSliderText:SetText(UFP_OP_Scale..(UnitFramesPlusDB["party"]["scale"]*100).."%");
		end
	end)
end

    --队伍目标设定
    local partytargetconfig = UnitFramesPlus_PartyTarget_Options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    partytargetconfig:ClearAllPoints();
    partytargetconfig:SetPoint("TOPLEFT", 16, -16);
    partytargetconfig:SetText(UFP_OP_PartyTarget_Options);

    --队友目标自动开启传统小队界面
    local UnitFramesPlus_OptionsFrame_PartyTargetOrigin = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyTargetOrigin", UnitFramesPlus_PartyTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyTargetOrigin:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyTargetOrigin:SetPoint("TOPLEFT", partytargetconfig, "TOPLEFT", 0, -40);
    UnitFramesPlus_OptionsFrame_PartyTargetOrigin:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetOriginText:SetText(UFP_OP_Party_Origin);
    UnitFramesPlus_OptionsFrame_PartyTargetOrigin:SetScript("OnClick", function(self)
        -- rl = "origin";
        -- if ((not IsInGroup()) or ((not IsInRaid()) and (GetNumSubgroupMembers() > 0))) and not InCombatLockdown() then
            UnitFramesPlusDB["party"]["origin"] = 1 - UnitFramesPlusDB["party"]["origin"];
            UnitFramesPlus_PartyStyle();
            for id = 1, MAX_PARTY_MEMBERS, 1 do
                PartyMemberFrame_UpdateMember(_G["PartyMemberFrame"..id]);
            end

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
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuffHidetip);
				-- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyCastbar);
				-- BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyScaleSlider);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBartext);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyHPMPUnit);
				BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyMouseShow);
				-- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyShiftDrag);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortraitIndicator);
				if showOptions then
					BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyScaleSlider);
					BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyColorHP);
					BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
				end
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTarget);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetLite);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHPPct);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorName);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetShortName);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetDebuff);
				-- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHighlight);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
				BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
				BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider);
			else
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPet);
				BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyHP);
				if UnitFramesPlusDB["party"]["hp"] == 1 then
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyHPPct);
				end
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyColorName);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyShortName);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyLevel);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortraitType);
				if UnitFramesPlusDB["party"]["portrait"] == 1 then
					BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider);
					if UnitFramesPlusDB["party"]["portraittype"] ~= 2 then
						BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
					end
				end
				-- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyOfflineDetection);
				-- UnitFramesPlus_OptionsFrame_PartyOfflineDetectionText:SetTextColor(1, 0.82, 0);
				-- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyDeathGhost);
				-- UnitFramesPlus_OptionsFrame_PartyDeathGhostText:SetTextColor(1, 0.82, 0);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuff);
				if UnitFramesPlusDB["party"]["buff"] == 1 then
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuffFilter);
					if UnitFramesPlusDB["party"]["filter"] == 1 then
						UIDropDownMenu_EnableDropDown(UnitFramesPlus_OptionsFrame_PartyBuffFilterType);
					end
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBuffHidetip);
				end
				-- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyCastbar);
				-- UnitFramesPlus_OptionsFrame_PartyCastbarText:SetTextColor(1, 0.82, 0);
				-- BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyScaleSlider);
				-- UnitFramesPlus_OptionsFrame_PartyScaleSliderText:SetTextColor(1, 0.82, 0);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyBartext);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyHPMPUnit);
				if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
					UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:SetValue(UnitFramesPlusDB["party"]["unittype"]);
					if UnitFramesPlusDB["party"]["hpmpunit"] == 1 then
						BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider);
					end
				end
				if UnitFramesPlusDB["party"]["bartext"] == 1 then
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyMouseShow);
				end
				-- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyShiftDrag);
				-- UnitFramesPlus_OptionsFrame_PartyShiftDragText:SetTextColor(1, 0.82, 0);
				BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyPortraitIndicator);
				if showOptions then
					BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyScaleSlider);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyColorHP);
					if UnitFramesPlusDB["party"]["colorhp"] == 1 then
						BlizzardOptionsPanel_Slider_Enable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
					end
				end
				if UnitFramesPlusDB["partytarget"]["show"] == 1 then
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTarget);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetLite);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetHPPct);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetColorName);
					if UnitFramesPlusDB["partytarget"]["colorname"] == 1 then
						BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
					end
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetShortName);
					BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetDebuff);
					-- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetHighlight);
					-- UnitFramesPlus_OptionsFrame_PartyTargetHighlightText:SetTextColor(1, 0.82, 0);
					if UnitFramesPlusDB["partytarget"]["lite"] ~= 1 then
						BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
						if UnitFramesPlusDB["partytarget"]["portrait"] == 1 then
							BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
						end
					end
				end

                -- StaticPopup_Show("UFP_RELOADUI");
            end
        -- end
        self:SetChecked(UnitFramesPlusDB["party"]["origin"]==1);
		UnitFramesPlus_OptionsFrame_PartyOrigin:SetChecked(UnitFramesPlusDB["party"]["origin"]==1);
    end)

    --队友目标
    local UnitFramesPlus_OptionsFrame_PartyTarget = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyTarget", UnitFramesPlus_PartyTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyTarget:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyTarget:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyTargetOrigin, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyTarget:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetText:SetText(UFP_OP_Party_Target);
    UnitFramesPlus_OptionsFrame_PartyTarget:SetScript("OnClick", function(self)
        UnitFramesPlusDB["partytarget"]["show"] = 1 - UnitFramesPlusDB["partytarget"]["show"];
        for id = 1, 4, 1 do
            _G["UFP_PartyTarget"..id]:SetAlpha(UnitFramesPlusDB["partytarget"]["show"]);
        end
        UnitFramesPlus_PartyTarget();
        if UnitFramesPlusDB["partytarget"]["show"] == 1 then
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetLite);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetHPPct);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetColorName);
            if UnitFramesPlusDB["partytarget"]["colorname"] == 1 then
	            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
	        end
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetShortName);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetDebuff);
            -- BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetHighlight);
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
            if UnitFramesPlusDB["partytarget"]["portrait"] == 1 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
            end
        else
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetLite);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHPPct);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorName);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetShortName);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetDebuff);
            -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHighlight);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
        end
        self:SetChecked(UnitFramesPlusDB["partytarget"]["show"]==1);
    end)

    --简易模式
    local UnitFramesPlus_OptionsFrame_PartyTargetLite = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyTargetLite", UnitFramesPlus_PartyTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyTargetLite:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyTargetLite:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyTarget, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetLite:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetLiteText:SetText(UFP_OP_Party_TargetLite);
    UnitFramesPlus_OptionsFrame_PartyTargetLite:SetScript("OnClick", function(self)
        UnitFramesPlusDB["partytarget"]["lite"] = 1 - UnitFramesPlusDB["partytarget"]["lite"];
        UnitFramesPlus_PartyTarget_Mode();
        if UnitFramesPlusDB["partytarget"]["lite"] == 1 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
        else
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
            if UnitFramesPlusDB["partytarget"]["portrait"] == 1 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
            end
        end
        self:SetChecked(UnitFramesPlusDB["partytarget"]["lite"]==1);
    end)

    --队友目标职业图标头像
    local UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait", UnitFramesPlus_PartyTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyTarget, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitText:SetText(UFP_OP_ClassPortrait);
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait:SetScript("OnClick", function(self)
        UnitFramesPlusDB["partytarget"]["portrait"] = 1 - UnitFramesPlusDB["partytarget"]["portrait"];
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyTargetClassPortraitDisplayUpdate(id);
        end
        if UnitFramesPlusDB["partytarget"]["portrait"] == 1 then
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
        else
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
        end
        self:SetChecked(UnitFramesPlusDB["partytarget"]["portrait"]==1);
    end)

    --队友目标为NPC时不显示职业头像
    local UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo", UnitFramesPlus_PartyTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNoText:SetText(UFP_OP_NPCNo);
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo:SetScript("OnClick", function(self)
        UnitFramesPlusDB["partytarget"]["portraitnpcno"] = 1 - UnitFramesPlusDB["partytarget"]["portraitnpcno"];
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyTargetClassPortraitDisplayUpdate(id);
        end
        self:SetChecked(UnitFramesPlusDB["partytarget"]["portraitnpcno"]==1);
    end)

    --队友目标生命值百分比
    local UnitFramesPlus_OptionsFrame_PartyTargetHPPct = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyTargetHPPct", UnitFramesPlus_PartyTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyTargetHPPct:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyTargetHPPct:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyTargetHPPct:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetHPPctText:SetText(UFP_OP_HPPct);
    UnitFramesPlus_OptionsFrame_PartyTargetHPPct:SetScript("OnClick", function(self)
        UnitFramesPlusDB["partytarget"]["hppct"] = 1 - UnitFramesPlusDB["partytarget"]["hppct"];
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyTargetDisplayUpdate(id);
        end
        UnitFramesPlus_PartyTargetDebuffPosition();
        self:SetChecked(UnitFramesPlusDB["partytarget"]["hppct"]==1);
    end)

    --队友目标敌友检测
    local UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck", UnitFramesPlus_PartyTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyTargetHPPct, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheckText:SetText(UFP_OP_EnemyCheck);
    UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck:SetScript("OnClick", function(self)
        UnitFramesPlusDB["partytarget"]["enemycheck"] = 1 - UnitFramesPlusDB["partytarget"]["enemycheck"];
        if UnitFramesPlusDB["partytarget"]["enemycheck"] ~= 1 then
            for id = 1, 4, 1 do
                _G["UFP_PartyTarget"..id].Highlight:SetAlpha(0);
            end
        end
        self:SetChecked(UnitFramesPlusDB["partytarget"]["enemycheck"]==1);
    end)

    --队友目标名字职业染色
    local UnitFramesPlus_OptionsFrame_PartyTargetColorName = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyTargetColorName", UnitFramesPlus_PartyTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyTargetColorName:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyTargetColorName:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyTargetColorName:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetColorNameText:SetText(UFP_OP_ColorName);
    UnitFramesPlus_OptionsFrame_PartyTargetColorName:SetScript("OnClick", function(self)
        UnitFramesPlusDB["partytarget"]["colorname"] = 1 - UnitFramesPlusDB["partytarget"]["colorname"];
        if UnitFramesPlusDB["partytarget"]["colorname"] == 1 then
            BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
        else
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
        end
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyTargetDisplayUpdate(id);
        end
        self:SetChecked(UnitFramesPlusDB["partytarget"]["colorname"]==1);
    end)

    --队友目标名字职业染色NPC不显示
    local UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo", UnitFramesPlus_PartyTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyTargetColorName, "TOPLEFT", 180, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNoText:SetText(UFP_OP_NPCNo);
    UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo:SetScript("OnClick", function(self)
        UnitFramesPlusDB["partytarget"]["colornamenpcno"] = 1 - UnitFramesPlusDB["partytarget"]["colornamenpcno"];
        self:SetChecked(UnitFramesPlusDB["partytarget"]["colornamenpcno"]==1);
    end)

    --队友目标名字显示为(*)
    local UnitFramesPlus_OptionsFrame_PartyTargetShortName = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyTargetShortName", UnitFramesPlus_PartyTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyTargetShortName:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyTargetShortName:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyTargetColorName, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyTargetShortName:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetShortNameText:SetText(UFP_OP_ShortName);
    UnitFramesPlus_OptionsFrame_PartyTargetShortName:SetScript("OnClick", function(self)
        UnitFramesPlusDB["partytarget"]["shortname"] = 1 - UnitFramesPlusDB["partytarget"]["shortname"];
        UnitFramesPlus_PartyName();
        for id = 1, 4, 1 do
            UnitFramesPlus_PartyTargetDisplayUpdate(id);
        end
        self:SetChecked(UnitFramesPlusDB["partytarget"]["shortname"]==1);
    end)

    --队友目标Debuff
    local UnitFramesPlus_OptionsFrame_PartyTargetDebuff = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_PartyTargetDebuff", UnitFramesPlus_PartyTarget_Options, "InterfaceOptionsCheckButtonTemplate");
    UnitFramesPlus_OptionsFrame_PartyTargetDebuff:ClearAllPoints();
    UnitFramesPlus_OptionsFrame_PartyTargetDebuff:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_PartyTargetShortName, "TOPLEFT", 0, -30);
    UnitFramesPlus_OptionsFrame_PartyTargetDebuff:SetHitRectInsets(0, -100, 0, 0);
    UnitFramesPlus_OptionsFrame_PartyTargetDebuffText:SetText(UFP_OP_Debuff);
    UnitFramesPlus_OptionsFrame_PartyTargetDebuff:SetScript("OnClick", function(self)
        UnitFramesPlusDB["partytarget"]["debuff"] = 1 - UnitFramesPlusDB["partytarget"]["debuff"];
        UnitFramesPlus_PartyTargetDebuff();
        self:SetChecked(UnitFramesPlusDB["partytarget"]["debuff"]==1);
    end)

    --额外设定
    local otherconfig = UnitFramesPlus_Extra_Options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    otherconfig:ClearAllPoints();
    otherconfig:SetPoint("TOPLEFT", 16, -16);
    otherconfig:SetText(UFP_OP_Ext_Options);

    --治疗职业距离检测
    if UnitFramesPlusVar["rangecheck"]["enable"] == 1 then
        local UnitFramesPlus_OptionsFrame_ExtraRangeCheck = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_ExtraRangeCheck", UnitFramesPlus_Extra_Options, "InterfaceOptionsCheckButtonTemplate");
        UnitFramesPlus_OptionsFrame_ExtraRangeCheck:ClearAllPoints();
        UnitFramesPlus_OptionsFrame_ExtraRangeCheck:SetPoint("TOPLEFT", otherconfig, "TOPLEFT", 0, -30);
        UnitFramesPlus_OptionsFrame_ExtraRangeCheck:SetHitRectInsets(0, -100, 0, 0);
        UnitFramesPlus_OptionsFrame_ExtraRangeCheckText:SetText(UFP_OP_RangeCheck);
        UnitFramesPlus_OptionsFrame_ExtraRangeCheck:SetScript("OnClick", function(self)
            UnitFramesPlusDB["extra"]["rangecheck"] = 1 - UnitFramesPlusDB["extra"]["rangecheck"];
            if UnitFramesPlusDB["extra"]["rangecheck"] == 1 then
                BlizzardOptionsPanel_CheckButton_Enable(UnitFramesPlus_OptionsFrame_ExtraRangeCheckInInstance);
            else
                BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_ExtraRangeCheckInInstance);
            end
            UnitFramesPlus_RangeCheck();
            self:SetChecked(UnitFramesPlusDB["extra"]["rangecheck"]==1);
        end)
    end

    --治疗职业距离检测仅在副本内生效
    if UnitFramesPlusVar["rangecheck"]["enable"] == 1 then
        local UnitFramesPlus_OptionsFrame_ExtraRangeCheckInInstance = CreateFrame("CheckButton", "UnitFramesPlus_OptionsFrame_ExtraRangeCheckInInstance", UnitFramesPlus_Extra_Options, "InterfaceOptionsCheckButtonTemplate");
        UnitFramesPlus_OptionsFrame_ExtraRangeCheckInInstance:ClearAllPoints();
        UnitFramesPlus_OptionsFrame_ExtraRangeCheckInInstance:SetPoint("TOPLEFT", UnitFramesPlus_OptionsFrame_ExtraRangeCheck, "TOPLEFT", 180, 0);
        UnitFramesPlus_OptionsFrame_ExtraRangeCheckInInstance:SetHitRectInsets(0, -100, 0, 0);
        UnitFramesPlus_OptionsFrame_ExtraRangeCheckInInstanceText:SetText(UFP_OP_RangeCheck_InInstance);
        UnitFramesPlus_OptionsFrame_ExtraRangeCheckInInstance:SetScript("OnClick", function(self)
            UnitFramesPlusDB["extra"]["instanceonly"] = 1 - UnitFramesPlusDB["extra"]["instanceonly"];
            self:SetChecked(UnitFramesPlusDB["extra"]["instanceonly"]==1);
        end)
    end
end

function UnitFramesPlus_OptionPanel_OnShow()
    UnitFramesPlus_OptionsFrame_MinimapButton:SetChecked(UnitFramesPlusDB["minimap"]["button"]==1);
    -- UnitFramesPlus_OptionsFrame_SYSOnBar:SetChecked(false);
    -- if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
    --     UnitFramesPlus_OptionsFrame_SYSOnBar_Unit:SetChecked(UnitFramesPlusDB["global"]["textunit"]==1);
    -- end
    UnitFramesPlusDB["global"]["mouseshow"] = 0;
    if UnitFramesPlusDB["player"]["mouseshow"] == 1 and UnitFramesPlusDB["pet"]["mouseshow"] == 1 
    and UnitFramesPlusDB["target"]["mouseshow"] == 1
    and UnitFramesPlusDB["party"]["mouseshow"] == 1 and UnitFramesPlusDB["extra"]["pvpmouseshow"] == 1 then
        UnitFramesPlusDB["global"]["mouseshow"] = 1;
    end
    UnitFramesPlus_OptionsFrame_GlobalMouseShow:SetChecked(UnitFramesPlusDB["global"]["mouseshow"]==1);
    UnitFramesPlusDB["global"]["portrait"] = 0;
    if UnitFramesPlusDB["player"]["portrait"] == 1 and UnitFramesPlusDB["target"]["portrait"] == 1 
    and UnitFramesPlusDB["party"]["portrait"] == 1 then
        UnitFramesPlusDB["global"]["portrait"] = 1;
    end
    UnitFramesPlus_OptionsFrame_GlobalPortraitType:SetChecked(UnitFramesPlusDB["global"]["portrait"]==1);
    UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider:SetValue(UnitFramesPlusDB["global"]["portraittype"]);
    UnitFramesPlusDB["global"]["portrait3dbg"] = 0;
    if UnitFramesPlusDB["player"]["portrait3dbg"] == 1 and UnitFramesPlusDB["target"]["portrait3dbg"] == 1 
    and UnitFramesPlusDB["party"]["portrait3dbg"] == 1 then
        UnitFramesPlusDB["global"]["portrait3dbg"] = 1;
    end
    UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG:SetChecked(UnitFramesPlusDB["global"]["portrait3dbg"]==1);
    UnitFramesPlusDB["global"]["portraitnpcno"] = 0;
    if UnitFramesPlusDB["target"]["portraitnpcno"] == 1 then
        UnitFramesPlusDB["global"]["portraitnpcno"] = 1;
    end
    UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo:SetChecked(UnitFramesPlusDB["global"]["portraitnpcno"]==1);
    if UnitFramesPlusDB["global"]["portrait"] == 0 then
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitTypeSlider);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
    elseif UnitFramesPlusDB["global"]["portrait"] == 1 then
        if UnitFramesPlusDB["global"]["portraittype"] == 1 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortraitNPCNo);
        elseif UnitFramesPlusDB["global"]["portraittype"] == 2 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalPortrait3DBG);
        end
    end
   UnitFramesPlusDB["global"]["movable"] = 0;
    if UnitFramesPlusDB["player"]["movable"] == 1 and UnitFramesPlusDB["target"]["movable"] == 1 
    and UnitFramesPlusDB["targettarget"]["movable"] == 1
    and UnitFramesPlusDB["party"]["movable"] == 1 then
        UnitFramesPlusDB["global"]["movable"] = 1;
    end
    UnitFramesPlus_OptionsFrame_GlobalShiftDrag:SetChecked(UnitFramesPlusDB["global"]["movable"]==1);
    UnitFramesPlusDB["global"]["indicator"] = 0;
    if UnitFramesPlusDB["player"]["indicator"] == 1 and UnitFramesPlusDB["pet"]["indicator"] == 1 
    and UnitFramesPlusDB["target"]["indicator"] == 1
    and UnitFramesPlusDB["party"]["indicator"] == 1 then
        UnitFramesPlusDB["global"]["indicator"] = 1;
    end
    UnitFramesPlus_OptionsFrame_GlobalPortraitIndicator:SetChecked(UnitFramesPlusDB["global"]["indicator"]==1);
    UnitFramesPlusDB["global"]["colorhp"] = 0;
    if UnitFramesPlusDB["player"]["colorhp"] == 1 and UnitFramesPlusDB["target"]["colorhp"] == 1 
    and UnitFramesPlusDB["party"]["colorhp"] == 1 then
        UnitFramesPlusDB["global"]["colorhp"] = 1;
    end

if showOptions then  -- 整體
	UnitFramesPlus_OptionsFrame_GlobalColorHP:SetChecked(UnitFramesPlusDB["global"]["colorhp"]==1);
    UnitFramesPlus_OptionsFrame_GlobalColorHPSlider:SetValue(UnitFramesPlusDB["global"]["colortype"]);
    if UnitFramesPlusDB["global"]["colorhp"] ~= 1 then
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_GlobalColorHPSlider);
    end
end
--[[
    if IsAddOnLoaded("UnitFramesPlus_Cooldown") then
        UnitFramesPlus_OptionsFrame_GlobalBuiltinCooldown:SetChecked(UnitFramesPlusDB["global"]["builtincd"]==1);
        if UnitFramesPlusDB["global"]["builtincd"] ~= 1 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalBuiltinCooldowntext);
        end
        UnitFramesPlus_OptionsFrame_GlobalBuiltinCooldowntext:SetChecked(UnitFramesPlusDB["global"]["cdtext"]==1);
    else
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalBuiltinCooldown);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalBuiltinCooldowntext);
    end

    if IsAddOnLoaded("UnitFramesPlus_MobHealth") then
        UnitFramesPlus_OptionsFrame_GlobalBuiltinExactEnemyHP:SetChecked(UnitFramesPlusDB["global"]["exacthp"]==1);
        if UnitFramesPlusDB["global"]["exacthp"] ~= 1 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalBuiltinExactEnemyHPPrune);
        end
        UnitFramesPlus_OptionsFrame_GlobalBuiltinExactEnemyHPPrune:SetChecked(UnitFramesPlusDB["global"]["prune"]==1);
    else
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalBuiltinExactEnemyHP);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_GlobalBuiltinExactEnemyHPPrune);
    end
--]]

if showOptions then -- 玩家
    UnitFramesPlus_OptionsFrame_PlayerFrameScaleSlider:SetValue(UnitFramesPlusDB["player"]["scale"]*100);
    UnitFramesPlus_OptionsFrame_PlayerDragonBorder:SetChecked(UnitFramesPlusDB["player"]["dragonborder"]==1);
    UnitFramesPlus_OptionsFrame_PlayerDragonBorderType:SetText(PlayerDragonBorderTypeDropDown[UnitFramesPlusDB["player"]["bordertype"]]);
    if UnitFramesPlusDB["player"]["dragonborder"] ~= 1 then
        UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PlayerDragonBorderType);
    end
    UnitFramesPlus_OptionsFrame_PlayerExtrabar:SetChecked(UnitFramesPlusDB["player"]["extrabar"]==1);
	UnitFramesPlus_OptionsFrame_PlayerColorHP:SetChecked(UnitFramesPlusDB["player"]["colorhp"]==1);
    UnitFramesPlus_OptionsFrame_PlayerColorHPSlider:SetValue(UnitFramesPlusDB["player"]["colortype"]);
    if UnitFramesPlusDB["player"]["colorhp"] ~= 1 then
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PlayerColorHPSlider);
    end
end

    UnitFramesPlus_OptionsFrame_PlayerMouseShow:SetChecked(UnitFramesPlusDB["player"]["mouseshow"]==1);
	UnitFramesPlus_OptionsFrame_PlayerHPMPPct:SetChecked(UnitFramesPlusDB["player"]["hpmp"]==1);
    UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne:SetText(PlayerHPMPPctDropDown[UnitFramesPlusDB["player"]["hpmppartone"]]);
    UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo:SetText(PlayerHPMPPctDropDown[UnitFramesPlusDB["player"]["hpmpparttwo"]]);
    if UnitFramesPlusDB["player"]["extrabar"] ~= 0 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerHPMPPct);
    end
    if UnitFramesPlusDB["player"]["hpmp"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerHPMPUnit);
        UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartOne);
        UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PlayerHPMPPctPartTwo);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerCoordinate);
		if not showOptions then
			BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider);
		end
    end
    UnitFramesPlus_OptionsFrame_PlayerExtraTextFontSizeSlider:SetValue(UnitFramesPlusDB["player"]["fontsize"]);
	UnitFramesPlus_OptionsFrame_PlayerHPMPUnit:SetChecked(UnitFramesPlusDB["player"]["hpmpunit"]==1);
    if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
        UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider:SetValue(UnitFramesPlusDB["player"]["unittype"]);
        if UnitFramesPlusDB["player"]["hpmpunit"] ~= 1 or UnitFramesPlusDB["player"]["hpmp"] ~= 1 then
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PlayerUnitTypeSlider);
        end
    end

    UnitFramesPlus_OptionsFrame_PlayerPortraitType:SetChecked(UnitFramesPlusDB["player"]["portrait"]==1);
    UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider:SetValue(UnitFramesPlusDB["player"]["portraittype"]);
    UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG:SetChecked(UnitFramesPlusDB["player"]["portrait3dbg"]==1);
    if UnitFramesPlusDB["player"]["portrait"] ~= 1 then
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PlayerPortraitTypeSlider);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG);
    end
    if UnitFramesPlusDB["player"]["portrait"] == 1 then
        if UnitFramesPlusDB["player"]["portraittype"] == 2 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PlayerPortrait3DBG);
        end
    end
	UnitFramesPlus_OptionsFrame_PlayerPortraitIndicator:SetChecked(UnitFramesPlusDB["player"]["indicator"]==1);
    UnitFramesPlus_OptionsFrame_PlayerShiftDrag:SetChecked(UnitFramesPlusDB["player"]["movable"]==1);
    UnitFramesPlus_OptionsFrame_PlayerFrameAutohide:SetChecked(UnitFramesPlusDB["player"]["autohide"]==1);
    UnitFramesPlus_OptionsFrame_PlayerCoordinate:SetChecked(UnitFramesPlusDB["player"]["coord"]==1);
    UnitFramesPlus_OptionsFrame_PetMouseShow:SetChecked(UnitFramesPlusDB["pet"]["mouseshow"]==1);
    UnitFramesPlus_OptionsFrame_PetShiftDrag:SetChecked(UnitFramesPlusDB["pet"]["movable"]==1);
    UnitFramesPlus_OptionsFrame_PetPortraitIndicator:SetChecked(UnitFramesPlusDB["pet"]["indicator"]==1);
    UnitFramesPlus_OptionsFrame_PetTargetTmp:SetChecked(UnitFramesPlusDB["pet"]["targettmp"]==1);
    UnitFramesPlus_OptionsFrame_PetTargetHPPct:SetChecked(UnitFramesPlusDB["pet"]["hppct"]==1);
    UnitFramesPlus_OptionsFrame_PetTargetShiftDrag:SetChecked(UnitFramesPlusDB["pet"]["targetmovable"]==1);
    UnitFramesPlus_OptionsFrame_PetTargetScaleSlider:SetValue(UnitFramesPlusDB["pet"]["scale"]*100);
    UnitFramesPlus_OptionsFrame_PetTarget:SetChecked(UnitFramesPlusDB["pet"]["target"]==1);
    if UnitFramesPlusDB["pet"]["target"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PetTargetTmp);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PetTargetHPPct);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PetTargetShiftDrag);
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PetTargetScaleSlider);
    end

 -- 目標
    UnitFramesPlus_OptionsFrame_TargetThreattext:SetChecked(UnitFramesPlusDB["target"]["threattext"]==1);
	UnitFramesPlus_OptionsFrame_TargetHPMPPct:SetChecked(UnitFramesPlusDB["target"]["hpmp"]==1);
    UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne:SetText(TargetHPMPPctDropDown[UnitFramesPlusDB["target"]["hpmppartone"]]);
    UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo:SetText(TargetHPMPPctDropDown[UnitFramesPlusDB["target"]["hpmpparttwo"]]);
    if UnitFramesPlusDB["target"]["extrabar"] ~= 0 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetHPMPPct);
    end
    if UnitFramesPlusDB["target"]["hpmp"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetHPMPUnit);
        UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartOne);
        UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_TargetHPMPPctPartTwo);
		BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider);
		if not showOptions then
			BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider);
		end
    end
    UnitFramesPlus_OptionsFrame_TargetExtraTextFontSizeSlider:SetValue(UnitFramesPlusDB["target"]["fontsize"]);
	UnitFramesPlus_OptionsFrame_TargetHPMPUnit:SetChecked(UnitFramesPlusDB["target"]["hpmpunit"]==1);
    if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
        UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider:SetValue(UnitFramesPlusDB["target"]["unittype"]);
        if UnitFramesPlusDB["target"]["hpmpunit"] ~= 1 then
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetUnitTypeSlider);
        end
    end
	
if showOptions then
    UnitFramesPlus_OptionsFrame_TargetExtrabar:SetChecked(UnitFramesPlusDB["target"]["extrabar"]==1);
	UnitFramesPlus_OptionsFrame_TargetFrameScaleSlider:SetValue(UnitFramesPlusDB["target"]["scale"]*100);
	UnitFramesPlus_OptionsFrame_TargetMouseShow:SetChecked(UnitFramesPlusDB["target"]["mouseshow"]==1);
	UnitFramesPlus_OptionsFrame_TargetRace:SetChecked(UnitFramesPlusDB["target"]["race"]==1);
	UnitFramesPlus_OptionsFrame_TargetBuffSize:SetChecked(UnitFramesPlusDB["target"]["buffsize"]==1);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider:SetValue(UnitFramesPlusDB["target"]["mysize"]);
    UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider:SetValue(UnitFramesPlusDB["target"]["othersize"]);
    if UnitFramesPlusDB["target"]["buffsize"] ~= 1 then
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetBuffSizeMineSlider);
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetBuffSizeOtherSlider);
    end
	UnitFramesPlus_OptionsFrame_TargetColorHP:SetChecked(UnitFramesPlusDB["target"]["colorhp"]==1);
    UnitFramesPlus_OptionsFrame_TargetColorHPSlider:SetValue(UnitFramesPlusDB["target"]["colortype"]);
    if UnitFramesPlusDB["target"]["colorhp"] ~= 1 then
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetColorHPSlider);
    end
end

	UnitFramesPlus_OptionsFrame_TargetClassIcon:SetChecked(UnitFramesPlusDB["target"]["classicon"]==1);
    UnitFramesPlus_OptionsFrame_TargetClassIconMore:SetChecked(UnitFramesPlusDB["target"]["moreaction"]==1);
    if UnitFramesPlusDB["target"]["classicon"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetClassIconMore);
    end

    -- UnitFramesPlus_OptionsFrame_TargetTargetSYSToT:SetChecked(tonumber(C_CVar.GetCVar("showTargetOfTarget"))==1);
    -- UnitFramesPlus_OptionsFrame_TargetTargetAutoToT:SetChecked(UnitFramesPlusDB["targettarget"]["systot"]==1);
    UnitFramesPlus_OptionsFrame_TargetTarget:SetChecked(UnitFramesPlusDB["targettarget"]["showtot"]==1);
    UnitFramesPlus_OptionsFrame_TargetTargetTarget:SetChecked(UnitFramesPlusDB["targettarget"]["showtotot"]==1);
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait:SetChecked(UnitFramesPlusDB["targettarget"]["portrait"]==1);
    UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo:SetChecked(UnitFramesPlusDB["targettarget"]["portraitnpcno"]==1);
    if UnitFramesPlusDB["targettarget"]["portrait"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo);
    end
    UnitFramesPlus_OptionsFrame_TargetTargetDebuff:SetChecked(UnitFramesPlusDB["targettarget"]["debuff"]==1);
    -- UnitFramesPlus_OptionsFrame_TargetTargetShortName:SetChecked(UnitFramesPlusDB["targettarget"]["shortname"]==1);
    UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider:SetValue(UnitFramesPlusDB["targettarget"]["scale"]*100);
    UnitFramesPlus_OptionsFrame_TargetTargetHPPct:SetChecked(UnitFramesPlusDB["targettarget"]["hppct"]==1);
    UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheck:SetChecked(UnitFramesPlusDB["targettarget"]["enemycheck"]==1);
    UnitFramesPlus_OptionsFrame_TargetTargetColorName:SetChecked(UnitFramesPlusDB["targettarget"]["colorname"]==1);
    UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo:SetChecked(UnitFramesPlusDB["targettarget"]["colornamenpcno"]==1);
    if UnitFramesPlusDB["targettarget"]["colorname"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo);
    end
    UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag:SetChecked(UnitFramesPlusDB["targettarget"]["movable"]==1);
    if UnitFramesPlusDB["targettarget"]["showtot"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetTarget);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetDebuff);
        -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetShortName);
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetTargetScaleSlider);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetHPPct);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetEnemyCheck);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetColorName);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetColorNameNPCNo);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetShiftDrag);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetClassPortrait);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetTargetClassPortraitNPCNo);
    end

    UnitFramesPlus_OptionsFrame_TargetPortraitType:SetChecked(UnitFramesPlusDB["target"]["portrait"]==1);
    UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider:SetValue(UnitFramesPlusDB["target"]["portraittype"]);
    UnitFramesPlus_OptionsFrame_TargetPortrait3DBG:SetChecked(UnitFramesPlusDB["target"]["portrait3dbg"]==1);
    UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo:SetChecked(UnitFramesPlusDB["target"]["portraitnpcno"]==1);
    if UnitFramesPlusDB["target"]["portrait"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortrait3DBG);
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_TargetPortraitTypeSlider);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo);
    elseif UnitFramesPlusDB["target"]["portrait"] == 1 then
        if UnitFramesPlusDB["target"]["portraittype"] == 1 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortraitNPCNo);
        elseif UnitFramesPlusDB["target"]["portraittype"] == 2 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_TargetPortrait3DBG);
        end
    end
    UnitFramesPlus_OptionsFrame_TargetShiftDrag:SetChecked(UnitFramesPlusDB["target"]["movable"]==1);
    UnitFramesPlus_OptionsFrame_TargetPortraitIndicator:SetChecked(UnitFramesPlusDB["target"]["indicator"]==1);

-- 隊伍
    UnitFramesPlus_OptionsFrame_PartyOrigin:SetChecked(UnitFramesPlusDB["party"]["origin"]==1);
	UnitFramesPlus_OptionsFrame_PartyHideRaid:SetChecked(UnitFramesPlusDB["party"]["hideraid"]==1);
	if UnitFramesPlusDB["party"]["hideraid"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyInRaid);
    end
    UnitFramesPlus_OptionsFrame_PartyInRaid:SetChecked(UnitFramesPlusDB["party"]["always"]==1);
    UnitFramesPlus_OptionsFrame_PartyPet:SetChecked(UnitFramesPlusDB["party"]["pet"]==1);
    UnitFramesPlus_OptionsFrame_PartyBartext:SetChecked(UnitFramesPlusDB["party"]["bartext"]==1);
    if UnitFramesPlusDB["party"]["bartext"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyMouseShow);
    end
    UnitFramesPlus_OptionsFrame_PartyMouseShow:SetChecked(UnitFramesPlusDB["party"]["mouseshow"]==1);
    UnitFramesPlus_OptionsFrame_PartyHPMPUnit:SetChecked(UnitFramesPlusDB["party"]["hpmpunit"]==1);
    if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
        UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider:SetValue(UnitFramesPlusDB["party"]["unittype"]);
        if UnitFramesPlusDB["party"]["hpmpunit"] ~= 1 then
            BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider);
        end
    end
    UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider:SetValue(UnitFramesPlusDB["party"]["fontsize"]);
	UnitFramesPlus_OptionsFrame_PartyLevel:SetChecked(UnitFramesPlusDB["party"]["level"]==1);
    UnitFramesPlus_OptionsFrame_PartyColorName:SetChecked(UnitFramesPlusDB["party"]["colorname"]==1);
    UnitFramesPlus_OptionsFrame_PartyShortName:SetChecked(UnitFramesPlusDB["party"]["shortname"]==1);
    UnitFramesPlus_OptionsFrame_PartyHP:SetChecked(UnitFramesPlusDB["party"]["hp"]==1);
    UnitFramesPlus_OptionsFrame_PartyHPPct:SetChecked(UnitFramesPlusDB["party"]["hppct"]==1);
    if UnitFramesPlusDB["party"]["hp"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyHPPct);
    end
    UnitFramesPlus_OptionsFrame_PartyPortraitType:SetChecked(UnitFramesPlusDB["party"]["portrait"]==1)
    UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider:SetValue(UnitFramesPlusDB["party"]["portraittype"]);
    UnitFramesPlus_OptionsFrame_PartyPortrait3DBG:SetChecked(UnitFramesPlusDB["party"]["portrait3dbg"]==1);
    if UnitFramesPlusDB["party"]["portrait"] ~= 1 then
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyPortraitTypeSlider);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
    elseif UnitFramesPlusDB["party"]["portrait"] == 1 then
        if UnitFramesPlusDB["party"]["portraittype"] == 2 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortrait3DBG);
        end
    end
    -- UnitFramesPlus_OptionsFrame_PartyOfflineDetection:SetChecked(UnitFramesPlusDB["party"]["onoff"]==1);
    -- UnitFramesPlus_OptionsFrame_PartyDeathGhost:SetChecked(UnitFramesPlusDB["party"]["death"]==1);
    -- UnitFramesPlus_OptionsFrame_PartyShiftDrag:SetChecked(UnitFramesPlusDB["party"]["movable"]==1);
    UnitFramesPlus_OptionsFrame_PartyPortraitIndicator:SetChecked(UnitFramesPlusDB["party"]["indicator"]==1);
    UnitFramesPlus_OptionsFrame_PartyTargetOrigin:SetChecked(UnitFramesPlusDB["party"]["origin"]==1);
    UnitFramesPlus_OptionsFrame_PartyTarget:SetChecked(UnitFramesPlusDB["partytarget"]["show"]==1);
    UnitFramesPlus_OptionsFrame_PartyTargetLite:SetChecked(UnitFramesPlusDB["partytarget"]["lite"]==1);
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait:SetChecked(UnitFramesPlusDB["partytarget"]["portrait"]==1);
    UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo:SetChecked(UnitFramesPlusDB["partytarget"]["portraitnpcno"]==1);
    if UnitFramesPlusDB["partytarget"]["portrait"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
    end
    UnitFramesPlus_OptionsFrame_PartyTargetHPPct:SetChecked(UnitFramesPlusDB["partytarget"]["hppct"]==1);
    UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck:SetChecked(UnitFramesPlusDB["partytarget"]["enemycheck"]==1);
    UnitFramesPlus_OptionsFrame_PartyTargetColorName:SetChecked(UnitFramesPlusDB["partytarget"]["colorname"]==1);
    UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo:SetChecked(UnitFramesPlusDB["partytarget"]["colornamenpcno"]==1);
    if UnitFramesPlusDB["partytarget"]["colorname"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
    end
    UnitFramesPlus_OptionsFrame_PartyTargetShortName:SetChecked(UnitFramesPlusDB["partytarget"]["shortname"]==1);
    UnitFramesPlus_OptionsFrame_PartyTargetDebuff:SetChecked(UnitFramesPlusDB["partytarget"]["debuff"]==1);
    -- UnitFramesPlus_OptionsFrame_PartyTargetHighlight:SetChecked(UnitFramesPlusDB["partytarget"]["highlight"]==1);
    if UnitFramesPlusDB["partytarget"]["show"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetLite);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHPPct);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorName);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetShortName);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetDebuff);
        -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHighlight);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
    elseif UnitFramesPlusDB["partytarget"]["lite"] == 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
    end
    UnitFramesPlus_OptionsFrame_PartyBuff:SetChecked(UnitFramesPlusDB["party"]["buff"]==1);
    UnitFramesPlus_OptionsFrame_PartyBuffHidetip:SetChecked(UnitFramesPlusDB["party"]["hidetip"]==1);
    UnitFramesPlus_OptionsFrame_PartyBuffFilter:SetChecked(UnitFramesPlusDB["party"]["filter"]==1);
    UnitFramesPlus_OptionsFrame_PartyBuffFilterType:SetText(PartyBuffFilterTypeDropDown[UnitFramesPlusDB["party"]["filtertype"]]);
    if UnitFramesPlusDB["party"]["buff"] ~= 1 then
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuffHidetip);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuffFilter);
        UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PartyBuffFilterType);
    end
    if UnitFramesPlusDB["party"]["filter"] ~= 1 then
        UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PartyBuffFilterType);
    end
    -- UnitFramesPlus_OptionsFrame_PartyCastbar:SetChecked(UnitFramesPlusDB["party"]["castbar"]==1);
    if showOptions then
		UnitFramesPlus_OptionsFrame_PartyScaleSlider:SetValue(UnitFramesPlusDB["party"]["scale"]*100);
		UnitFramesPlus_OptionsFrame_PartyColorHP:SetChecked(UnitFramesPlusDB["party"]["colorhp"]==1);
		UnitFramesPlus_OptionsFrame_PartyColorHPSlider:SetValue(UnitFramesPlusDB["party"]["colortype"]);
		if UnitFramesPlusDB["party"]["colorhp"] ~= 1 then
			BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
		end
	end
    if UnitFramesPlusDB["party"]["origin"] ~= 1 then
        -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyHideRaid);
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
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTarget);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetLite);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHPPct);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetEnemyCheck);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorName);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetColorNameNPCNo);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetShortName);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetDebuff);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuff);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuffFilter);
        UIDropDownMenu_DisableDropDown(UnitFramesPlus_OptionsFrame_PartyBuffFilterType);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBuffHidetip);
        -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyCastbar);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyBartext);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyHPMPUnit);
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyUnitTypeSlider);
        BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyExtraTextFontSizeSlider);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyMouseShow);
        -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyShiftDrag);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyPortraitIndicator);
        -- BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetHighlight);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortrait);
        BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyTargetClassPortraitNPCNo);
		if showOptions then
			BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyScaleSlider);
			BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_PartyColorHP);
			BlizzardOptionsPanel_Slider_Disable(UnitFramesPlus_OptionsFrame_PartyColorHPSlider);
		end
    end
	-- UnitFramesPlus_OptionsFrame_ArenaEnemyMouseShow:SetChecked(UnitFramesPlusDB["extra"]["pvpmouseshow"]==1);
    -- UnitFramesPlus_OptionsFrame_ArenaEnemyHPPct:SetChecked(UnitFramesPlusDB["extra"]["pvphppct"]==1);
    -- UnitFramesPlus_OptionsFrame_ExtraBossHPPct:SetChecked(UnitFramesPlusDB["extra"]["bosshppct"]==1);
    if UnitFramesPlusVar["rangecheck"]["enable"] == 1 then
        UnitFramesPlus_OptionsFrame_ExtraRangeCheck:SetChecked(UnitFramesPlusDB["extra"]["rangecheck"]==1);
        UnitFramesPlus_OptionsFrame_ExtraRangeCheckInInstance:SetChecked(UnitFramesPlusDB["extra"]["instanceonly"]==1);
        if UnitFramesPlusDB["extra"]["rangecheck"] ~= 1 then
            BlizzardOptionsPanel_CheckButton_Disable(UnitFramesPlus_OptionsFrame_ExtraRangeCheckInInstance);
        end
    end
end
