local locale = GetLocale()

if locale ~= "zhCN" then return end

local L = {}

-- UI Text
L["Main"] = "主要"
L["Saved Data"] = "已保存数据"
L["Open Exporter Window"] = "打开导出窗口"
L["Opens the exporter window"] = "打开导出窗口"
L["Click 'Generate Data' to generate exportable data"] = "点击'生成数据'以生成可导出的数据"
L["Your characters class is currently unsupported. The supported classes are currently:"] = "您的角色职业目前不受支持。当前支持的职业有："
L["To upload your character to the simuator, click on the url below that leads to the simuator website."] = "要将您的角色上传到模拟器，请点击下面的链接访问模拟器网站。"
L["You will find an Import button on the top right of the simulator named \"Import\". Click that and select the \"Addon\" tab, paste the data into the provided box and click \"Import\""] = "您会在模拟器右上角找到一个名为\"导入\"的按钮。点击它并选择\"插件\"标签，将数据粘贴到提供的框中，然后点击\"导入\""
L["Click to copy:"] = "点击复制："
L["Generate Data (Equipped Only)"] = "生成数据（仅装备）"
L["Batch: Export Bag Items"] = "批量：导出背包物品"
L["Copy and paste into the websites importer!"] = "复制并粘贴到网站的导入器中！"

-- Saved Data Tab
L["Saved Character Data Management"] = "已保存角色数据管理"
L["Auto-Save Settings"] = "自动保存设置"
L["Enable Auto-Save"] = "启用自动保存"
L["Show Auto-Save Messages"] = "显示自动保存消息"
L["Saved Characters"] = "已保存角色"
L["No saved characters found."] = "未找到已保存的角色。"
L["Saved:"] = "保存时间："
L["Export"] = "导出"
L["Delete"] = "删除"

-- SavedDataManager Messages
L["Character data saved for %s"] = "角色数据已保存：%s"
L["Updated saved character data for %s"] = "已更新角色数据：%s"
L["Deleted saved character: %s"] = "已删除角色：%s"
L["No saved characters found."] = "未找到已保存的角色。"
L["Saved Characters:"] = "已保存角色："
L["Usage: /wsedelete <number> - Use /wselist to see available characters"] = "用法：/wsedelete <数字> - 使用 /wselist 查看可用角色"
L["No saved character found at index %d"] = "在索引 %d 处未找到已保存的角色"
L["Auto-save enabled. Character will be saved automatically on equipment, talent, level, and other changes."] = "自动保存已启用。角色将在装备、天赋、等级等变化时自动保存。"
L["Auto-save disabled. Use /wse export to manually save character data."] = "自动保存已禁用。使用 /wse export 手动保存角色数据。"
L["Auto-save messages %s."] = "自动保存消息已%s。"
L["enabled"] = "启用"
L["disabled"] = "禁用"
L["Usage: /wseautosave [on|off|messages]"] = "用法：/wseautosave [on|off|messages]"
L["Auto-save %s."] = "自动保存已%s。"
L["Character auto-saved due to %s"] = "角色因 %s 自动保存"

-- Initialization Messages
L["Initialized. Commands:"] = "已初始化。命令："
L["/wse - Open window"] = "/wse - 打开窗口"
L["/wse export - Export character (auto-saves)"] = "/wse export - 导出角色（自动保存）"
L["Auto-save:"] = "自动保存："
L["ENABLED"] = "已启用"
L["DISABLED"] = "已禁用"
L["Credits go to %s"] = "致谢：%s"
L["WARNING: Sim does not support your game version! Supported versions are:"] = "警告：模拟器不支持您的游戏版本！支持的版本有："

-- Export Messages
L["Exported %d items from bags."] = "已从背包导出 %d 件物品。"

-- WSE Copy Dialog
L["WSE Copy Dialog"] = "WSE 复制对话框"
L["Use CTRL+C to copy link"] = "使用 CTRL+C 复制链接"

-- Character Panel Button
L["WowSims"] = "WowSims"

-- Register locale
if not _G.WowSimsExporterLocale then
    _G.WowSimsExporterLocale = {}
end
_G.WowSimsExporterLocale.zhCN = L

