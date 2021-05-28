if GetLocale() == "zhCN" then
    -- UFPLocal_DeathText = "死";
    -- UFPLocal_GhostText = "魂";
    UFPLocal_LeftOpen  = "左键点击打开插件设置面板";
    UFPLocal_RightMove = "右键点住按钮后拖动移动位置";
    UFPLocal_OptionFailed = "|cFFFF0000UnitFramesPlus设置面板载入失败|R";
    UFPLocal_Loaded    = "|cFFFFFF99UnitFramesPlus载入成功，请输入|R |cFF00FF00/ufp|R |cFFFFFF99或|R |cFF00FF00/unitframesplus|R |cFFFFFF99进行设置 (|cFF00FF00/ufp reset|R |cFFFFFF99可重置插件设置)|R";
    UFPLocal_HideRaid  = "重载界面以切换系统团队界面显示\n\n（请更新Grid2等插件的相关配置！）";
    UFPLocal_ShowParty = "重载界面以切换系统小队界面显示";
elseif GetLocale() == "zhTW" then
    -- UFPLocal_DeathText = "死";
    -- UFPLocal_GhostText = "魂";
    UFPLocal_LeftOpen  = "左鍵點擊打開插件設置面板";
    UFPLocal_RightMove = "右鍵點住按鈕後拖動移動位置";
    UFPLocal_OptionFailed = "|cFFFF0000UnitFramesPlus設置面板載入失敗|R";
    UFPLocal_Loaded    = "|cFFFFFF99UnitFramesPlus載入成功，請輸入|R |cFF00FF00/ufp|R |cFFFFFF99或|R |cFF00FF00/unitframesplus|R |cFFFFFF99進行設置 (|R|cFF00FF00/ufp reset|R |cFFFFFF99可重置插件設置)|R";
    UFPLocal_HideRaid  = "重載介面以切換系統團隊介面顯示\n\n（請更新Grid2等插件的相關配置！）";
    UFPLocal_ShowParty = "重載介面以切換系統小隊介面顯示";
else
    -- UFPLocal_DeathText = "Death";
    -- UFPLocal_GhostText = "Ghost";
    UFPLocal_LeftOpen  = "Left-click to open option panel";
    UFPLocal_RightMove = "Right-click and drag to move this button";
    UFPLocal_OptionFailed = "|cFFFF0000The option panel can't be loaded.|R";
    UFPLocal_Loaded    = "|cFFFFFF99UnitFramesPlus loaded. Type|R |cFF00FF00/ufp|R |cFFFFFF99or|R |cFF00FF00/unitframesplus|R |cFFFFFF99to open the option panel, (|R|cFF00FF00/ufp reset|R |cFFFFFF99to restore defaults).|R";
    UFPLocal_HideRaid  = "Reload UI for enable/disable blizzard raidframe\n\n(Please update settings for other addons, such as Grid2)";
    UFPLocal_ShowParty = "Reload UI for enable/disable blizzard partyframe";
end
