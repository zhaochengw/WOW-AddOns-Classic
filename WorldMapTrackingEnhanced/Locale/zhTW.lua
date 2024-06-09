-- $Id: zhTW.lua 105 2020-02-10 15:00:34Z arith $

local L = LibStub("AceLocale-3.0"):NewLocale("WorldMapTrackingEnhanced", "zhTW", false)

if not L then return end

if L then
L[" (Core}"] = " (主程式)"
L["Addon Configuration"] = "插件設定"
L["Addon Info"] = "插件資訊"
L["Author"] = "作者"
L["Click to open GatherMate2's config panel"] = "點一下打開採集助手的設定選項"
L["Click to open HandyNotes' config panel"] = "點一下打開地圖標記的設定選項"
L["Click to open PetTracker's config panel"] = "點一下打開戰寵助手的設定選項"
L["Click to open RareScanner's config panel"] = "點一下打開稀有怪通知的設定選項"
L["Click to open World Map Tracking Enhanced's config panel"] = "點一下打開世界地圖追蹤增強的設定選項"
L["Config"] = "設定"
L["Disable Icons on World Map"] = "停用世界地圖上的圖示"
L["GatherMate2 Config"] = "採集助手設定"
L["HandyNotes Config"] = "地圖標記設定"
L["Icon on left"] = "圖示在左側"
L["Independent Button"] = "獨立按鈕"
L["Modules"] = "模組"
L[ [=[Move filter icon on map frame's left side.
Requires to reload addon to take effect.]=] ] = [=[將放大鏡圖示移動到地圖視窗的左側。
需要重新載入介面才會生效。]=]
L["Options"] = "選項"
L["Others"] = "其他"
L["PetTracker Config"] = "戰寵助手設定"
L["Profile Options"] = "設定檔"
L["RareScanner Config"] = "稀有怪通知設定"
L["Second Level Menu"] = "第二層選單"
L["Second level menu will be forced to be created when there are more than 20 of HandyNotes plugins."] = "當有超過 20 個以上的地圖標記插件時，會強制顯示在第二層選單"
L["Show %s module's config link in menu."] = "在選單中顯示%s的設定選項連結"
L["Show %s module's menu items in second level of menu."] = "將%s的選單選項顯示在第二層選單"
L["Show HandyNotes plugins in second level menu."] = "將地圖標記的套件清單顯示在第二層選單"
L["Show RareScanner plugins in second level menu."] = "將稀有怪通知的套件清單顯示在第二層選單"
L["Show WorldQuestTracker's filter selections in second level menu."] = "在世界任務追蹤的過濾方式顯示在第二層選單"
L["Support"] = "支援"
L["Toggle which map enhancement addon to be included in the enhanced tracking option menu."] = "選擇要將哪些地圖增強的插件加入強化的地圖追蹤選項清單裡。"
L[ [=[Use an independent filter button and place closed to WorldMap frame's buttons on the top-right corner.
Requires to reload addon to take effect.]=] ] = [=[使用獨立的放大鏡按鈕，並且放在靠近世界地圖右上角按鈕的地方。
需要重新載入介面才會生效。]=]
L["Use Separator"] = "使用分隔線"
L["Use separator in menu to separate different type of menu items"] = "使用分隔線來區隔不同的選單項目"
L["World Map Tracking Enhanced Config"] = "世界地圖追蹤增強設定"

-- 自行加入
L["Description"] = "強化的世界地圖追蹤選項，支援最熱門的遊戲插件"
L["Title"] = "世界地圖追蹤增強"
L["WorldMapTrackingEnhanced"] = "世界地圖-追蹤"
L["PetTracker"] = "戰寵助手"
L["Pet Tracker"] = "戰寵 |TInterface/Garrison/MobileAppIcons:13:13:0:0:1024:1024:261:389:261:389|t"
L["Species"] = "寵物種類"
L["World Quest Tracker"] = "世界任務追蹤"
L["GatherMate2"] = "採集助手"
L["HandyNotes"] = "地圖標記"
L["Atlas"] = "副本地圖"
L["AtlasLoot"] = "副本戰利品查詢"
L["RareScanner"] = "稀有怪通知"
end
