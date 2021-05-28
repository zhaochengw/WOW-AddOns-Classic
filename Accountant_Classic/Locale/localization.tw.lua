-- $Id: localization.tw.lua 294 2018-03-15 13:48:21Z arith $ 

local L = LibStub("AceLocale-3.0"):NewLocale("Accountant_Classic", "zhTW", false)

if not L then return end
L["(%d+) Copper"] = "(%d+)銅幣"
L["(%d+) Gold"] = "(%d+)金幣"
L["(%d+) Silver"] = "(%d+)銀幣"
L["|cffffffff\"%s - %s|cffffffff\" character's Accountant Classic data has been removed."] = "|cffffffff「%s - %s|cffffffff」角色的個人會計資料已經移除。"
L["A basic tool to track your monetary incomings and outgoings within WoW."] = "追蹤每個角色的所有收入與支出狀況，並可顯示當日小計、當週小計、以及自有記錄起的總計。並可顯示所有角色的總金額。"
L["About"] = "關於"
L["Accountant Classic"] = "個人會計"
L["Accountant Classic Floating Info's Scale"] = "個人會計浮動資訊大小"
L["Accountant Classic Floating Info's Transparency"] = "個人會計浮動資訊透明度"
L["Accountant Classic Frame's Scale"] = "個人會計視窗大小"
L["Accountant Classic Frame's Transparency"] = "個人會計視窗透明度"
L["Accountant Classic loaded."] = "個人會計插件已載入"
L["Accountant Classic Options"] = "個人會計選項"
L["All Chars"] = "所有角色"
L["All Factions"] = "所有陣營"
L["All Servers"] = "所有伺服器"
L["Also track subzone info"] = "同時也追蹤子區域資訊"
L["Are you sure you want to reset the \"%s\" data?"] = "是否確定要將「%s」頁籤的資料歸零?"
L["BINDING_HEADER_ACCOUNTANT_CLASSIC_TITLE"] = "個人會計按鍵設定"
L["BINDING_NAME_ACCOUNTANT_CLASSIC_TOGGLE"] = "開啟個人會計"
L["c"] = "銅"
L["Character"] = "角色"
L["Character Data's Removal"] = "角色資料刪除"
L["Converts a number into a localized string, grouping digits as required."] = "將數字加上本地化千分號"
L["Data type to be displayed on LDB"] = "在 LDB 上要顯示的資料類型"
L["Date format showing in \"All Chars\" and \"Week\" tabs"] = "在「本週」與「所有角色」頁籤所顯示的日期格式"
L[ [=[Detected the conflicted addon - "|cFFFF0000Accountant|r" exists and loaded.
It has been disabled, click Okay button to reload the game.]=] ] = [=[偵測到衝突的插件 - |cFFFF0000Accountant|r。
它已被停止啟用，按下確定按鍵以重新載入遊戲。]=]
L["Display Instruction Tips"] = "顯示指引提示"
L["Done"] = "完成"
L["Enable to also track on the subzone info. For example: Suramar - Sanctum of Order"] = "啟用以追蹤子區域資訊。例如：「蘇拉瑪爾 - 秩序聖所」"
L["Enable to show all characters' money info from all factions. Disable to only show all characters' info from current faction."] = "啟用以顯示來自所有陣營的所有角色的金流資訊。停用則僅會顯示目前陣營的角色資訊。"
L["Enable to show all characters' money info from all realms. Disable to only show current realm's character info."] = "啟用以顯示來自所有伺服器的所有角色的金流資訊。停用則僅會顯示目前伺服器的角色資訊。"
L["Enable to track the location of each incoming / outgoing money and also show the breakdown info while mouse hover each of the expenditure."] = "啟用以追蹤每筆您的收入與支出的發生地點，並且在個人會計視窗中，當滑鼠移到每項金額時，顯示這些地點的詳細資訊。"
L["Enhanced Tracking Options"] = "更多的追蹤選項"
L["Exit"] = "離開"
L["g "] = "金"
L["General and Data Display Format Settings"] = "一般與資訊顯示格式設定"
L["Incomings"] = "收入"
L["LDB Display Settings"] = "LDB 顯示設定"
L["LDB Display Type"] = "LDB 顯示類型"
L[ [=[Left-click and drag to move this button.
Right-Click to open Accountant Classic.]=] ] = [=[左鍵並拖曳以移動圖示按鈕位置
右鍵開啟個人會計]=]
L[ [=[Left-Click to open Accountant Classic.
Right-Click for Accountant Classic options.
Left-click and drag to move this button.]=] ] = [=[左鍵開啟個人會計
右鍵開啟個人會計選項
右鍵並拖曳以移動圖示按鈕位置]=]
L["LFD, LFR and Scen."] = "隨機地城、團隊與事件"
L["Loaded Accountant Classic Profile for %s"] = "%s的個人會計資料已載入"
L["Mail"] = "郵寄"
L["Main Frame's Scale and Alpha Settings"] = "主視窗的大小與透明度"
L["Merchants"] = "商人"
L["Minimap Button Position"] = "小地圖按鈕位置"
L["Minimap Button Settings"] = "小地圖按鍵設定"
L["Money"] = "金錢"
L["Net Loss"] = "淨虧損"
L["Net Profit"] = "淨收益"
L["Net Profit / Loss"] = "淨收益/虧損"
L["New Accountant Classic profile created for %s"] = "%s的個人會計資料已建立"
L["Onscreen Actionbar's Scale and Alpha Settings"] = "浮動視窗的大小與透明度"
L["Options"] = "選項"
L["Outgoings"] = "支出"
L["Profile Options"] = "設定檔"
L["Prv. Day"] = "上一日"
L["Prv. Month"] = "上月"
L["Prv. Week"] = "上週"
L["Prv. Year"] = "上一年"
L["Quest Rewards"] = "任務獎勵"
L["Remember character selected"] = "記憶選擇的角色"
L["Remember the latest character selection in dropdown menu."] = "記憶上次在下拉式選單所選擇的角色。"
L["Repair Costs"] = "修理裝備"
L["Reset"] = "歸零"
L["Reset money frame's position"] = "重置畫面上顯示現金的位置"
L["Reset position"] = "重設位置"
L["s "] = "銀"
L["Scale and Transparency"] = "大小與透明度"
L["Select the character to be removed:"] = "選擇要移除的角色:"
L["Select the date format:"] = "選擇日期格式："
L["Show All Characters"] = "顯示所有角色"
L["Show all characters' incoming and outgoing data."] = "顯示所有角色的收入與支出加總"
L["Show all factions' characters info"] = "顯示所有陣營的角色資訊"
L["Show all realms' characters info"] = "顯示所有伺服器的角色資訊"
L["Show current session's net income / expanse instead of total money on LDB"] = "在 LDB 支援的顯示列上顯示本次的淨收入/支出而不是總是顯示總金額"
L["Show minimap button"] = "顯示小地圖按鈕"
L["Show money"] = "顯示目前現金"
L["Show money on minimap button's tooltip"] = "在小地圖按鈕的提示顯示目前現金"
L["Show money on screen"] = "在遊戲畫面顯示目前現金"
L["Show net income / expanse on LDB"] = "在 LDB 上顯示本次的淨收入/支出"
L["Show session info"] = "顯示本次收入/支出"
L["Show session info on minimap button's tooltip"] = "在小地圖按鈕的提示顯示本次收入/支出"
L["Source"] = "類別"
L["Start of Week"] = "一週的開始日"
L["Sum Total"] = "總金額"
L["Taxi Fares"] = "飛行花費"
L[ [=[The selected character is about to be removed.
Are you sure you want to remove the following character from Accountant Classic?]=] ] = [=[即將移除選取的角色。
是否確定要從個人會計的資料庫中
移除下列角色?]=]
L["The selected character's Accountant Classic data will be removed."] = "被選取的角色的個人會計資料將會被移除。"
L["This Month"] = "本月"
L["This Session"] = "本次"
L["This Week"] = "本週"
L["This Year"] = "今年"
L["Today"] = "今日"
L["Toggle whether to display minimap button or floating money frame's operation tips."] = "選擇是否在小地圖按鈕或浮動視窗顯示額外的操作提示"
L["Total"] = "總計"
L["Total Incomings"] = "總收入"
L["Total Outgoings"] = "總支出"
L["Track location of incoming / outgoing money"] = "追蹤每筆收入/支出的地點"
L["Trade Window"] = "交易"
L["Training Costs"] = "訓練費用"
L["Unknown"] = "未知"
L["Updated"] = "更新"
L["Week Start"] = "當週首日"
L[ [=[You have manually called the function 
|cFF00FF00AccountantClassic_CleanUpAccountantDB()|r 
to clean up conflicted data existed in "Accountant". 
Now click Okay button to reload the game.]=] ] = [=[您以手動執行了以下函式
|cFF00FF00AccountantClassic_CleanUpAccountantDB()|r 
以清除在 "Accountant" 插件裡衝突的資料。
現在請按下確定按鍵以重新載入遊戲。]=]


