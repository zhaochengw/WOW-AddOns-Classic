if GetLocale() == "zhCN" then
    -- UFPLocal_DeathText = "死亡";
    -- UFPLocal_GhostText = "鬼魂";
    UFPLocal_LeftOpen  = "左键点击打开插件设置面板";
    UFPLocal_RightMove = "右键点住按钮后拖动移动位置";
    UFPLocal_OptionFailed = "|cFFFF0000UnitFramesPlus设置面板载入失败|R";
    UFPLocal_Loaded    = "|cFFFFFF99UnitFramesPlus载入成功，请输入|R |cFF00FF00/ufp|R |cFFFFFF99或|R |cFF00FF00/unitframesplus|R |cFFFFFF99进行设置 (|cFF00FF00/ufp reset|R |cFFFFFF99可重置插件设置)|R";
	UFPLocal_HideRaid  = "重载界面以切换系统团队界面显示";
    UFPLocal_ShowParty = "重载界面以切换系统小队界面显示";
	UFPLocal_Title = "UnitFramesPlus";
	UFPLocal_RightOpen  = "左键点击打开 EasyFrame 插件设置面板";
	UFPLocal_ClassIcon = "左键: 观察\n右键: 交易\n中键: 密语\n按键4: 跟随";
elseif GetLocale() == "zhTW" then
    -- UFPLocal_DeathText = "死亡";
    -- UFPLocal_GhostText = "鬼魂";
    UFPLocal_LeftOpen  = "左鍵: 開啟 (增強功能) 設定";
    UFPLocal_RightMove = "右鍵拖曳: 移動小地圖按鈕";
    UFPLocal_OptionFailed = "|cFFFF0000因遊戲改版功能失效，目前暫不提供暴雪頭像 (增強功能) 的設定選項。|R";
    UFPLocal_Loaded    = "|cFFFFFF99UnitFramesPlus 載入成功，請輸入|R |cFF00FF00/ufp|R |cFFFFFF99或|R |cFF00FF00/unitframesplus|R |cFFFFFF99進行設定 (|R|cFF00FF00/ufp reset|R  |cFFFFFF99重置設定)|R";
	UFPLocal_HideRaid  = "重新載入來切換顯示遊戲內建的團隊框架";
    UFPLocal_ShowParty = "重新載入來切換顯示遊戲內建的小隊框架";
	UFPLocal_Title = "暴雪頭像";
	UFPLocal_RightOpen = "右鍵: 開啟 (美化調整) 設定";
	UFPLocal_ClassIcon = "左鍵: 觀察\n右鍵: 交易\n中鍵: 密語\n按鍵4: 跟隨";
else
    -- UFPLocal_DeathText = "Death";
    -- UFPLocal_GhostText = "Ghost";
    UFPLocal_LeftOpen  = "Left-click to open option panel";
    UFPLocal_RightMove = "Right-click and drag to move this button";
    UFPLocal_OptionFailed = "|cFFFF0000The option panel can't be loaded.|R";
    UFPLocal_Loaded    = "|cFFFFFF99UnitFramesPlus loaded. Type|R |cFF00FF00/ufp|R |cFFFFFF99or|R |cFF00FF00/unitframesplus|R |cFFFFFF99to open the option panel, (|R|cFF00FF00/ufp reset|R |cFFFFFF99to restore defaults).|R";
	UFPLocal_HideRaid  = "Reload UI for enable/disable blizzard raidframe\n\n(Please update settings for other addons, such as Grid2)";
    UFPLocal_ShowParty = "Reload UI for enable/disable blizzard partyframe";
	UFPLocal_Title = "UnitFramesPlus";
	UFPLocal_RightOpen = "Right-click to open EasyFrame option panel";
	UFPLocal_ClassIcon = "Left-click: Inspect\nRight-click: Trade\nMiddle-click: Whisper\nButton 4-click: Follow";
end
