---@class L
local L = LibStub('AceLocale-3.0'):NewLocale(..., 'zhCN')
if not L then
    return
end

-- @import@

L.TITLE_BAG = '%s的背包'
L.TITLE_BANK = '%s的银行'
L.TITLE_MAIL = '%s的邮箱'
L.TITLE_EQUIP = '%s的装备'
L.TITLE_COD = '%s的付款取信'

L['Total'] = '总共'
L['|cffff2020(Offline)|r'] = '|cffff2020(离线)|r'
L['Bag Toggle'] = '背包按钮'
L['Expired'] = '过期'

L['Equipped'] = '装备'
L['Inventory'] = '背包'
L['Bank'] = '银行'
L['Mail'] = '邮箱'
L['COD'] = '付款取信'
L['Equip'] = '装备'
L['Global search'] = '全局搜索'
L['Guild bank'] = '公会银行'

L['Move up'] = '上移'
L['Move down'] = '下移'

L.TOOLTIP_CHANGE_PLAYER = '查看其他角色的物品'
L.TOOLTIP_RETURN_TO_SELF = '返回到当前角色'
L.TOOLTIP_HIDE_BAG_FRAME = '隐藏背包列表'
L.TOOLTIP_SHOW_BAG_FRAME = '显示背包列表'
L.TOOLTIP_TOGGLE_BAG = '打开背包'
L.TOOLTIP_TOGGLE_BANK = '打开银行'
L.TOOLTIP_TOGGLE_MAIL = '打开邮箱'
L.TOOLTIP_TOGGLE_EQUIP = '打开装备栏'
L.TOOLTIP_TOGGLE_GLOBAL_SEARCH = '打开全局搜索'
L.TOOLTIP_TOGGLE_OTHER_FRAME = '打开其它背包'
L.TOOLTIP_PURCHASE_BANK_SLOT = '购买银行空位'
L.TOOLTIP_WATCHED_TOKENS_LEFTTIP = '拖动物品到这里以添加监控'
L.TOOLTIP_WATCHED_TOKENS_RIGHTTIP = '管理物品监控'
L.TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG = '仅统计背包内数量'
L.TOOLTIP_WATCHED_TOKENS_SHIFT = '<按住SHIFT查看单个物品>'
L.TOOLTIP_SHOW_BAG = '显示背包'
L.TOOLTIP_HIDE_BAG = '隐藏背包'
L.TOOLTIP_SEARCH_TOGGLE = '搜索背包'
L.TOOLTIP_SEARCH_RECORDS = '打开/保存搜索条件'

L.HOTKEY_CTRL_RIGHT = 'Ctrl-右键'
L.HOTKEY_ALT_RIGHT = 'Alt-右键'

---- options

L.DESC_GENERAL = '通用偏好设置。'
L.DESC_FRAMES = '%s偏好设置。'
L.DESC_COLORS = '颜色偏好设置。'
L.DESC_DISPLAY = '自动显示和关闭。'

L['Character Specific Settings'] = '角色独立设置'
L['Frame Settings'] = '背包设置'
L['Appearance'] = '外观'
L['Blizzard Panel'] = '标准面板'
L['Reverse Bag Order'] = '反向背包排列'
L['Reverse Slot Order'] = '反向物品排列'
L['Columns'] = '列数'
L['Item Scale'] = '物品缩放'

L['Time Remaining'] = '剩余时间'
L['Always show'] = '始终显示'
L['Never show'] = '从不显示'
L['Less than one day'] = '低于1天'
L['Less than %s days'] = '低于%s天'

L['Features'] = '功能'
L['Watch Frame'] = '物品监控'
L['Bag Frame'] = '背包列表'

L['No record'] = '没有记录'

L['Restore default Settings'] = '恢复默认设置'
L['Are you sure you want to restore the current Settings?'] = '你确定要恢复到默认设置吗？'
L['Global Settings'] = '全局设置'
L['Need to reload UI to make some settings take effect'] = '需要重新载入UI后，使部分设置生效。'

L['Lock Frames'] = '锁定位置'
L['Show Junk Icon'] = '显示垃圾图标'
L['Show Character Portrait'] = '显示角色头像'
L['Show Quest Starter Icon'] = '显示任务给予物图标'
L['Show Offline Text in Bag\'s Title'] = '在背包标题上显示离线'
L['Show Item Count in Tooltip'] = '鼠标提示物品统计'
L['Show Guild Bank Count in Tooltip'] = '鼠标提示显示公会银行数量'
L['Trade Containers Location'] = '特殊容器位置'
L['Bag Style'] = '背包风格'

L['Default'] = '默认'
L['Top'] = '顶部'
L['Bottom'] = '底部'

L['Color Settings'] = '颜色设置'
L['Highlight Border'] = '边框着色'
L['Highlight Quest Items'] = '对任务物品着色'
L['Highlight Unusable Items'] = '对不可用物品着色'
L['Highlight Items by Quality'] = '根据物品品质着色'
L['Highlight Equipment Set Items'] = '对套装物品着色'
L['Highlight New Items'] = '对新物品着色'
L['Highlight Brightness'] = '边框着色亮度'

L['Color Empty Slots by Bag Type'] = '根据容器类型对空格着色'
L['Slot Colors'] = '槽位颜色'
L['Container Colors'] = '容器颜色'
L['Normal Color'] = '普通容器颜色'
L['Quiver Color'] = '箭袋颜色'
L['Soul Color'] = '灵魂袋颜色'
L['Enchanting Color'] = '附魔材料袋颜色'
L['Herbalism Color'] = '草药袋颜色'
L['Keyring Color'] = '钥匙链颜色'
L['Leatherworking Color'] = '制皮袋颜色'
L['Engineering Color'] = '工程学材料袋颜色'
L['Gems Color'] = '宝石袋颜色'
L['Mining Color'] = '矿石袋颜色'
L['Empty Slot Brightness'] = '空格亮度'

L['Plugin Buttons'] = '扩展按钮'

L['Auto Display'] = '自动显示'
L['Visiting the Mail Box'] = '打开邮箱时'
L['Visiting the Auction House'] = '打开拍卖行时'
L['Visiting the Bank'] = '打开银行时'
L['Visiting a Vendor'] = '打开商人时'
L['Opening the Character Info'] = '打开角色面板时'
L['Opening Trade Skills'] = '打开专业技能时'
L['Trading Items'] = '交易时'
L['Auto Close'] = '自动关闭'
L['Leaving the Mail Box'] = '关闭邮箱时'
L['Leaving the Auction House'] = '关闭拍卖行时'
L['Leaving the Bank'] = '关闭银行时'
L['Leaving a Vendor'] = '关闭商人时'
L['Closing the Character Info'] = '关闭角色面板时'
L['Closing Trade Skills'] = '关闭专业技能时'
L['Completed Trade'] = '完成交易时'
L['Entering Combat'] = '进入战斗时'

-- @end-import@
