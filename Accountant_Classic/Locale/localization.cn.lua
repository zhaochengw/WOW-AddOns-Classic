-- $Id: localization.cn.lua 247 2017-05-12 17:08:38Z arith $ 

local L = LibStub("AceLocale-3.0"):NewLocale("Accountant_Classic", "zhCN", false)

if not L then return end
L["(%d+) Copper"] = "(%d+)铜币"
L["(%d+) Gold"] = "(%d+)金币"
L["(%d+) Silver"] = "(%d+)银币"
L["|cffffffff\"%s - %s|cffffffff\" character's Accountant Classic data has been removed."] = "|cffffffff「%s - %s|cffffffff」角色的 Accountant Classic 资料已经移除。"
L["A basic tool to track your monetary incomings and outgoings within WoW."] = "追踪每个角色的所有收入与支出状况，并可显示当日小计、当周小计、以及自有记录起的总计。并可显示所有角色的总金额。"
L["About"] = "关于"
L["Accountant Classic"] = "Accountant Classic"
L["Accountant Classic Floating Info's Scale"] = "Accountant Classic 浮动信息大小"
L["Accountant Classic Floating Info's Transparency"] = "Accountant Classic 浮动信息透明度"
L["Accountant Classic Frame's Scale"] = "Accountant Classic 窗口大小"
L["Accountant Classic Frame's Transparency"] = "Accountant Classic 窗口透明度"
L["Accountant Classic loaded."] = "Accountant Classic 插件已载入"
L["Accountant Classic Options"] = "Accountant Classic 选项"
L["All Chars"] = "所有角色"
L["All Factions"] = "所有阵营"
L["All Servers"] = "所有服务器"
L["Also track subzone info"] = "同时也追踪子区域信息"
L["Are you sure you want to reset the \"%s\" data?"] = "是否确定要将「%s」页签的资料归零?"
L["BINDING_HEADER_ACCOUNTANT_CLASSIC_TITLE"] = "Accountant Classic 绑定"
L["BINDING_NAME_ACCOUNTANT_CLASSIC_TOGGLE"] = "切换 Accountant Classic"
L["c"] = "铜"
L["Character"] = "角色"
L["Character Data's Removal"] = "角色数据删除"
L["Converts a number into a localized string, grouping digits as required."] = "将数字加上本地化千分号"
L["Data type to be displayed on LDB"] = "在LDB上显示的数据类型"
L["Date format showing in \"All Chars\" and \"Week\" tabs"] = "在「本周」与「所有角色」页签所显示的日期格式"
L[ [=[Detected the conflicted addon - "|cFFFF0000Accountant|r" exists and loaded.
It has been disabled, click Okay button to reload the game.]=] ] = [=[侦测到冲突的插件 - |cFFFF0000Accountant|r。
它已被停止启用，按下确定按键以重新载入游戏。]=]
L["Display Instruction Tips"] = "显示指引提示"
L["Done"] = "完成"
L["Enable to also track on the subzone info. For example: Suramar - Sanctum of Order"] = "启用以追踪子区域信息。例如：「苏拉玛 - 秩序大殿」"
L["Enable to show all characters' money info from all factions. Disable to only show all characters' info from current faction."] = "启用时显示所有阵营全部角色的金钱信息。禁用时仅显示当前阵营全部角色信息。"
L["Enable to show all characters' money info from all realms. Disable to only show current realm's character info."] = "启用以显示来自所有服务器的所有角色的金流信息。停用则仅会显示目前服务器的角色信息。"
L["Enable to track the location of each incoming / outgoing money and also show the breakdown info while mouse hover each of the expenditure."] = "启用以追踪每笔您的收入与支出的发生地点，并且在 Accountant Classic 窗口中，当鼠标移到每项金额时，显示这些地点的详细信息。"
L["Enhanced Tracking Options"] = "增强追踪选项"
L["Exit"] = "退出"
L["g "] = "金"
L["General and Data Display Format Settings"] = "常规和数据显示格式设置"
L["Incomings"] = "收入"
L["LDB Display Settings"] = "LDB显示设置"
L["LDB Display Type"] = "LDB显示类型"
L[ [=[Left-click and drag to move this button.
Right-Click to open Accountant Classic.]=] ] = [=[左键点击并拖曳以移动图示按钮位置
右键点击打开 Accountant Classic]=]
L[ [=[Left-Click to open Accountant Classic.
Right-Click for Accountant Classic options.
Left-click and drag to move this button.]=] ] = [=[单击打开 Accountant Classic
右键点击打开设置
右键并拖曳以移动图示按钮位置]=]
L["LFD, LFR and Scen."] = "随机地城、团队与事件"
L["Loaded Accountant Classic Profile for %s"] = "%s的 Accountant Classic 数据已加载"
L["Mail"] = "邮寄"
L["Main Frame's Scale and Alpha Settings"] = "主框架尺寸及透明度设置"
L["Merchants"] = "商人"
L["Minimap Button Position"] = "小地图按钮位置"
L["Minimap Button Settings"] = "小地图按钮设置"
L["Money"] = "金钱"
L["Net Loss"] = "净亏损"
L["Net Profit"] = "净收益"
L["Net Profit / Loss"] = "净收益/亏损"
L["New Accountant Classic profile created for %s"] = "%s的 Accountant Classic 数据已建立"
L["Onscreen Actionbar's Scale and Alpha Settings"] = "屏幕上的拍卖条尺寸及透明度设置"
L["Options"] = "选项"
L["Outgoings"] = "支出"
L["Profile Options"] = "配置选项"
L["Prv. Day"] = "前一天"
L["Prv. Month"] = "上个月"
L["Prv. Week"] = "上星期"
L["Prv. Year"] = "上一年"
L["Quest Rewards"] = "任务奖励"
L["Remember character selected"] = "记住已选角色"
L["Remember the latest character selection in dropdown menu."] = "记住在下拉菜单中选择的最近一个角色"
L["Repair Costs"] = "修理花费"
L["Reset"] = "重置"
L["Reset money frame's position"] = "重置画面上显示现金的位置"
L["Reset position"] = "重置位置"
L["s "] = "银"
L["Scale and Transparency"] = "尺寸及透明度"
L["Select the character to be removed:"] = "选择要移除的角色:"
L["Select the date format:"] = "选择日期格式："
L["Show All Characters"] = "显示所有角色"
L["Show all characters' incoming and outgoing data."] = "显示所有角色的收入与支出加总"
L["Show all factions' characters info"] = "显示所有阵营的角色信息"
L["Show all realms' characters info"] = "显示所有服务器的角色信息"
L["Show current session's net income / expanse instead of total money on LDB"] = "在 LDB 支援的显示列上显示本次的净收入/净支出而非显示总金额"
L["Show minimap button"] = "显示小地图按钮"
L["Show money"] = "显示目前现金"
L["Show money on minimap button's tooltip"] = "在小地图按钮的提示显示目前现金"
L["Show money on screen"] = "在游戏画面显示目前现金"
L["Show net income / expanse on LDB"] = "在 LDB 上显示本次的净收入/支出"
L["Show session info"] = "显示本次收入/支出"
L["Show session info on minimap button's tooltip"] = "在小地图按钮的提示显示本次收入/支出"
L["Source"] = "来源"
L["Start of Week"] = "一周的开始日"
L["Sum Total"] = "总金额"
L["Taxi Fares"] = "飞行花费"
L[ [=[The selected character is about to be removed.
Are you sure you want to remove the following character from Accountant Classic?]=] ] = [=[即将移除选取的角色。
是否确定要从个人会计的资料库中移除下列角色?]=]
L["The selected character's Accountant Classic data will be removed."] = "被选取的角色的个人会计资料将会被移除。"
L["This Month"] = "本月"
L["This Session"] = "本次"
L["This Week"] = "本周"
L["This Year"] = "今年"
L["Today"] = "本日"
L["Toggle whether to display minimap button or floating money frame's operation tips."] = "选择是否在小地图按钮或浮动视窗显示额外的操作提示"
L["Total"] = "总计"
L["Total Incomings"] = "总收入"
L["Total Outgoings"] = "总支出"
L["Track location of incoming / outgoing money"] = "追踪每笔收入/支出的地点"
L["Trade Window"] = "交易"
L["Training Costs"] = "训练费用"
L["Unknown"] = "未知"
L["Updated"] = "更新"
L["Week Start"] = "当周首日"
L[ [=[You have manually called the function 
|cFF00FF00AccountantClassic_CleanUpAccountantDB()|r 
to clean up conflicted data existed in "Accountant". 
Now click Okay button to reload the game.]=] ] = [=[您以手动执行了以下函式
|cFF00FF00AccountantClassic_CleanUpAccountantDB()|r
以清除在 "Accountant" 插件里冲突的资料。
现在请按下确定按键以重新载入游戏。 ]=]

