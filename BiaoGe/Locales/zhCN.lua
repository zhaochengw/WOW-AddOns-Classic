local AddonName, ADDONSELF = ...

ADDONSELF.ver = "v1.8.0"

if (GetLocale() == "zhTW") then return end

local update = ""
do --简体说明书
    local text
    text = "|cff00BFFF< 我是说明书 >|r\n\n"
    text = text .. "|cffFFFFFF-打开命令：|r/BiaoGe或/GBG，或游戏设置里绑定按键。小地图图标：" .. "|TInterface\\AddOns\\BiaoGe\\Media\\icon\\icon:0|t" .. "\n"
    text = text .. "|cffFFFFFF-快捷操作：|r点空白处取消光标，右键输入框清除内容\n"
    text = text .. "|cffFFFFFF-跳转光标：|r按Tab、方向键跳转光标，ALT/CTRL/SHIFT+方向键跳转至下个BOSS\n"
    text = text .. "|cffFFFFFF-添加装备：|r从装备下拉列表里选择；或者从背包把装备拖进表格\n"
    text = text .. "|cffFFFFFF-发送装备：|rSHIFT+点击装备\n"
    text = text .. "|cffFFFFFF-关注装备：|rALT+点击装备，团长拍卖此装备时会提醒（当你是团员时）\n"
    text = text .. "|cffFFFFFF-团长拍卖：|rALT+点击表格/背包/聊天框装备，打开拍卖面板（当你是团长时）\n"
    text = text .. "|cffFFFFFF-查看同部位其他可选装备：|rCTRL+点击装备\n"
    text = text .. "|cffFFFFFF-交换格子：|rCTRL+ALT+点击格子1，再点格子2，可交换两行全部内容\n"
    text = text .. "|cffFFFFFF-更多功能介绍可在设置里查看|r\n\n"
    text = text .. "-BUG反馈：邮箱buick_hbj@163.com，Q群322785325\n\n"

    update = update .. "|cff00FF00" .. "2月8日更新1.8.0版本" .. "|r\n"
    update = update .. [[-在表格格子里按下Enter键时，不再下跳光标，而是取消光标]] .. "\n"
    update = update .. [[-<赛季服>P2装备库添加了部分新装备，且旧版装备替换为新版装备]] .. "\n"
    update = update .. [[-<赛季服>角色团本总览添加新团本诺莫瑞根]] .. "\n\n"

    update = update .. "|cff00FF00" .. "2月5日更新1.7.9c版本" .. "|r\n"
    update = update .. [[-<赛季服>添加诺莫瑞根BOSS战ID，使P2的表格能正确生效]] .. "\n\n"

    update = update .. "|cff00FF00" .. "1月31日更新1.7.9b版本" .. "|r\n"
    update = update .. [[-修复了繁体端关于一键举报功能的报错]] .. "\n\n"

    update = update .. "|cff00FF00" .. "1月27日更新1.7.9版本" .. "|r\n"
    update = update .. [[-新增模块：举报记录（查看举报记录和追踪举报结果）]] .. "\n"
    update = update .. [[-修复了导入心愿时，第10个及以上boss的心愿会导入错误的问题]] .. "\n"
    update = update .. [[-<WLK>添加了海里昂的成就参考ID到密语模板里]] .. "\n"
    update = update .. [[-<60服>不再自动记录NAXX小怪掉落的布甲等碎片]] .. "\n\n"

    -- update = update .. "|cff00FF00" .. "" .. "|r\n"
    -- update = update .. [[]] .. "\n"
    -- update = update .. [[]] .. "\n\n"

    text = text .. update
    text = text .. "|cff00FF00按住ALT显示更多更新记录|r"

    ADDONSELF.instructionsText = text
end
do --简体更新内容
    local update = "|cff00BFFF< 主要更新记录 >|r\n\n" .. update

    update = update .. "|cff00FF00" .. "1月20日更新1.7.8版本" .. "|r\n"
    update = update .. [[-装备库现在可以按其他进行排序]] .. "\n"
    update = update .. [[-重做历史表格改名功能]] .. "\n"
    update = update .. [[-修复一些文本错误]] .. "\n"
    update = update .. [[-<赛季服>更新P2装备库]] .. "\n"
    update = update .. [[-<赛季/60服>心愿清单的格子增加至5个]] .. "\n\n"

    update = update .. "|cff00FF00" .. "1月16日更新1.7.7版本" .. "|r\n"
    update = update .. [[-在心愿清单中增加<导出心愿>和<导入心愿>功能]] .. "\n"
    update = update .. [[-表格设置增加选项<拍卖聊天记录总是保持在最新位置>]] .. "\n"
    update = update .. [[-现在点击拍卖聊天记录框的玩家名字时，不再是密语，而是设置他为买家]] .. "\n"
    update = update .. [[-查看在线人数改为手动刷新，避免可能出现掉线的情况]] .. "\n"
    update = update .. [[-优化一键分配，现在会识别更多可交易的物品]] .. "\n"
    update = update .. [[-<赛季服>增加灰谷周常完成总览]] .. "\n"
    update = update .. [[-<60服>不再自动记录安其拉副本掉落的蓝色坐骑和雕像]] .. "\n\n"

    update = update .. "|cff00FF00" .. "1月12日更新1.7.6版本" .. "|r\n"
    update = update .. [[-新增显示联盟/部落当前在线人数]] .. "\n"
    update = update .. [[-在查询名单列表界面中增加<全部举报>按钮（把当前名单里的全部玩家举报为自动脚本）]] .. "\n"
    update = update .. [[-在查询名单列表界面中增加<历史搜索记录>]] .. "\n"
    update = update .. [[-当交易自动记账后，如果你刚买到的装备是你的关注或心愿，则自动取消关注或取消心愿]] .. "\n\n"

    update = update .. "|cff00FF00" .. "1月10日更新1.7.5b版本" .. "|r\n"
    update = update .. [[-买家下拉列表的格子增加至40个]] .. "\n"
    update = update .. [[-<WLK>装备库现在会显示海里昂的装备]] .. "\n\n"

    ADDONSELF.updateText = update
end

local L = setmetatable({}, {
    __index = function(table, key)
        return tostring(key)
    end
})

ADDONSELF.L = L

local L = {}

do
    L["荆棘谷血月活动"] = true
    L["锻造"] = true
    L["制皮"] = true
    L["裁缝"] = true
    L["工程"] = true


    L["一键举报脚本"] = true

    L["本次一共举报|cff00BFFF%s|r个脚本。第一次举报的|cff00FF00%s|r个，曾举报的|cffFF0000%s|r个。"] = true
    L["举报记录"] = true
    L["举报记录："] = true
    L["< 举报记录 >"] = true
    L["查看举报记录和追踪举报结果"] = true
    L["举报时间"] = true
    L["服务器"] = true
    L["举报类型"] = true
    L["举报项目"] = true
    L["举报细节"] = true
    L["举报次数"] = true
    L["已封号"] = true
    L["操作"] = true
    L["确定清空全部举报记录？"] = true
    L["已清空全部举报记录，一共 %s 个。"] = true
    L["清空记录"] = true
    L["一键清空全部举报记录。"] = true
    L["已封号："] = true
    L["未封号："] = true
    L["举报合计："] = true
    L["%s：已被封号"] = true
    L["%s：未被封号"] = true
    L["|cff00ff00查：|r查询该玩家是否已被封号"] = true
    L["|cffff0000删：|r删除该条举报记录"] = true
    L["查"] = true
    L["删"] = true


    L["不能使用该名字，因为跟其他历史表格重名！"] = true
    L["检测到配置文件错误，现已重置！"] = true

    L["灰谷周常"] = true
    L["把全部可交易的物品分配给自己"] = true
    L["心愿清单是空的"] = true
    L["心愿清单导入成功：%s，一共导入%s件装备。"] = true
    L["导入心愿"] = true
    L["导出心愿"] = true
    L["（获取时间：%s）"] = true
    L["未刷新"] = true
    L["<点击刷新>"] = true
    L["待刷新"] = true
    L["拍卖聊天记录总是保持在最新位置"] = true
    L["每次打开拍卖聊天记录框时，自动回到最新的聊天位置。"] = true
    L["拍卖聊天记录框"] = true
    L["|cffFFFFFF左键玩家名字：|r设置为买家"] = true
    L["|cffFFFFFFSHIFT+左键玩家名字：|r密语"] = true
    L["|cffFFFFFFCTRL+滚轮：|r快速滚动"] = true
    L["|cffFFFFFFSHIFT+滚轮：|r滚动到最前/最后"] = true


    L["当前时光徽章"] = true
    L["不可用"] = true
    L["数据来源："] = true
    L["%s在线人数"] = true
    L["本次一共举报 |cff00FF00%s|r 个脚本。艾泽拉斯感谢你！"] = true
    L["当前名单为空，或者新名单正在等待服务器响应。你可以尝试点击刷新按钮，直到新名单出现。"] = true
    L["全部举报"] = true
    L["把当前名单里的全部玩家举报为自动脚本。"] = true
    L["在查询名单列表界面中增加全部举报按钮。"] = true
    L["你可在插件设置-BiaoGe-其他功能里关闭这个功能。"] = true
    L["查询记录"] = true
    L["|cff00BFFF<BiaoGe>|r 已自动取消%s的|cff00BFFF关注|r和|cff00FF00心愿|r。"] = true
    L["|cff00BFFF<BiaoGe>|r 已自动取消%s的|cff00BFFF关注|r。"] = true
    L["|cff00BFFF<BiaoGe>|r 已自动取消%s的|cff00FF00心愿|r。"] = true


    L["全阶段"] = true
    L["工程"] = true
    L["团本*"] = true
    L["小团本 %s"] = true
    L["你击中目标"] = true
    L["你造成爆击"] = true
    L["你的法术击中"] = true
    L["你的法术造成爆击"] = true
    L["当前没有满级角色"] = true


    L["恶意骚扰"] = true
    L["自动脚本"] = true
    L["已举报<%s>为%s。"] = true
    L["选择举报理由：%s\n选择举报项目：%s\n填写举报细节：%s\n\n快捷命令：/BGReport\n\n|cff808080你可在插件设置-BiaoGe-其他功能里关闭这个功能。|r"] = true
    L["一键举报RMT"] = true
    L["选择举报理由：%s\n选择举报项目：%s\n填写举报细节：%s\n\n|cff808080你可在插件设置-BiaoGe-其他功能里关闭这个功能。|r"] = true
    L["一键举报骚扰"] = true
    L["在聊天频道的玩家右键菜单里增加一键举报骚扰和一键举报RMT按钮。"] = true
    L["抹去工资小数点"] = true
    L["工资抹零"] = true


    L["选择举报理由：作弊\n选择举报项目：外挂\n填写举报细节：自动脚本 自動腳本 Automatic Scripting\n\n快捷命令：/BGReport\n\n|cff808080你可在插件设置-BiaoGe-其他功能里关闭这个功能。|r"] = true
    L["|cffFFFFFF左键：|r搜索该记录"] = true
    L["|cffFFFFFF右键：|r删除该记录"] = true
    L["一键举报"] = true
    L["在目标玩家的右键菜单里增加一键举报脚本按钮。快捷命令：/BGReport。"] = true
    L["多个关键词搜索"] = true
    L["搜索框支持多个关键词搜索，每个关键词用空格隔开。"] = true
    L["已举报<%s>。"] = true
    L["自动帮你选择并填写举报内容"] = true
    L["该目标类型不是玩家。"] = true
    L["你没有目标。"] = true
    L["集结号增强|cff808080（该功能由BiaoGe插件提供）|r"] = true
    L["不自动退出集结号频道"] = true
    L["这样你可以一直同步集结号的组队消息，让你随时打开集结号都能查看全部活动。"] = true
    L["历史搜索记录"] = true
    L["给集结号的搜索框增加一个历史搜索记录，提高你搜索的效率。"] = true
    L["按队伍人数排序"] = true
    L["集结号活动可以按队伍人数排序。"] = true


    L["预设装等、自定义文本，当你点击集结号活动密语时会自动添加该内容。"] = true
    L["预设成就、装等、自定义文本，当你点击集结号活动密语时会自动添加该内容。"] = true
    L["按住SHIFT+点击密语时不会添加。"] = true
    L["聊天频道玩家的右键菜单里增加密语模板按钮。"] = true
    L["聊天输入框的右键菜单里增加密语模板按钮。"] = true


    L["提醒：插件目前仅支持WLK和plus赛季服，传统60服暂不支持！"] = true
    L["没有价格"] = true
    L["这个物品不是装备"] = true
    L["（SHIFT+点击发送装备，CTRL+点击查看该部位的其他可选装备）"] = true
    L["（ALT+点击关注装备，SHIFT+点击发送装备，CTRL+点击查看该部位的其他可选装备）"] = true
    L["在贸易局声望的遭劫货物提示工具中增加具体的声望奖励。如果你安装了Auctionator插件，还会显示所需货物的拍卖行价格。"] = true


    L["声望奖励"] = true
    L["可用于"] = true
    L["需要数量"] = true
    L["空载时声望奖励"] = true
    L["补足时声望奖励"] = true
    L["贸易局的遭劫货物显示具体声望奖励"] = true
    L["在贸易局声望的遭劫货物提示工具中增加具体的声望奖励"] = true


    L["（SHIFT+左键发送装备，ALT+左键设为心愿装备。部位按钮支持使用滚轮切换）"] = true


    L["击中"] = true
    L["所有法术和魔法效果所造成的伤害和治疗效果"] = true
    L["法术和效果所造成的伤害"] = true
    L["法术所造成的治疗效果"] = true
    L["赛季服*"] = true


    L["副本: "] = true
    L["只能设置团本BOSS正常掉落的装备为心愿"] = true
    L["点击按钮后会把全部掉落分配给自己，只对精良/史诗装备生效，其他分类的物品不会生效。"] = true
    L["把全部掉落分配给自己，只对精良/史诗装备生效，其他类型的物品不会生效"] = true
    L["<BiaoGe> 金团表格"] = true
    L["|cffFFFFFF左键：|r打开表格"] = true
    L["|cffFFFFFF右键：|r打开设置"] = true
    L["世界掉落"] = true


    L["BiaoGe版本"] = true
    L["插件：%s"] = true
    L["拍卖WA版本"] = true
    L["拍卖：%s"] = true
    L["需全团安装拍卖WA，没安装的人将会看不到拍卖窗口"] = true
    L["|cffFFD100起拍价|r"] = true
    L["|cffFFD100拍卖时长(秒)"] = true
    L["|cffFFD100拍卖模式|r"] = true
    L["正常模式"] = true
    L["匿名模式"] = true
    L["拍卖过程中不会显示当前出价最高人是谁。拍卖结束后才会知晓"] = true
    L["开始拍卖"] = true
    L["已安装拍卖WA：%s"] = true
    L["全新的拍卖方式，不再通过传统的聊天栏来拍卖装备，而是使用新的UI来拍卖。"] = true
    L["|cffFFFFFF安装WA：|r此WA是团员端，用于接收团长发出的拍卖消息，没安装的团员显示不了拍卖UI。请团长安装该WA字符串后发给团员安装。如果团员已经安装了BiaoGe插件并且版本在1.7.0或以上，可以不用安装该WA。"] = true
    L["|cffFFFFFF拍卖教程：|r团长ALT+点击表格/背包/聊天框的装备来打开拍卖面板，填写起拍价、拍卖时长、拍卖模式即可开始拍卖。可同时拍卖多件装备。"] = true
    L["拍卖WA字符串"] = true


    L["YY评价模块初始化成功，已自动加入%s频道，用于共享和查询YY大众评价。"] = true
    L["你已退出%s频道，YY评价模块自动关闭。"] = true
    L["点击后会把这些物品分配给你："] = true
    L["没有符合条件的物品"] = true


    L["关注中"] = true
    L["欠款：%s\n右键清除欠款"] = true
    L["欠款：%s"] = true
    L["一键分配"] = true
    L["你不是物品分配者，不能使用"] = true
    L["把全部掉落分配给自己，只对史诗装备或套装兑换物生效，其他类型的物品不会生效（例如橙片、任务物品不会自动分配）"] = true
    L["你可在插件设置-BiaoGe-其他功能里关闭这个功能"] = true
    L["高亮对应装备"] = true
    L["当鼠标悬停在表格装备时，高亮背包里对应的装备。"] = true
    L["当鼠标悬停在背包装备时，高亮表格里对应的装备。"] = true
    L["当鼠标悬停在聊天框装备时，高亮表格和背包里对应的装备。"] = true
    L["（背包系统支持原生背包、NDui背包、ElvUI背包、大脚背包）"] = true
    L["退队/入队玩家上色"] = true
    L["在退队/入队的系统消息里，给该玩家名字加上职业色并设置为链接。"] = true
    L["一键指定%s"] = true
    L["在地下城和团队副本界面增加一键指定%s按钮。"] = true
    L["队长模式一键自动分配"] = true
    L["队长分配模式时，在战利品界面增加一键分配按钮。"] = true
    L["点击按钮后会把全部掉落分配给自己，只对史诗装备或套装兑换物生效，其他分类的物品不会生效（例如橙片、任务物品等不会自动分配）。"] = true


    L["|cffffffff< 进本自动清空表格 >|r\n\n当你进入一个新CD团本时，表格会自动清空，原表格数据会保存至历史表格1"] = true
    L["进本自动清空表格*"] = true
    L["<BiaoGe> 已自动清空表格< %s >，分钱人数已改为%s人。原表格数据已保存至历史表格1。"] = true
    L["撤回清空"] = true
    L["<BiaoGe> 已撤回清空，还原了表格数据，并删除了历史表格1。"] = true
    L["只能撤回一次。"] = true


    L["没有欠款"] = true
    L["当前装备自动记录位置："] = true
    L["BOSS战开始"] = true
    L["BOSS击杀成功"] = true
    L["BOSS击杀失败"] = true
    L["非BOSS战"] = true


    L["心愿汇总"] = true
    L["（右键删除心愿装备）"] = true
    L["部位"] = true
    L["心愿"] = true
    L["复制对方账单"] = true
    L["把对方账单的金额覆盖我当前表格的金额"] = true
    L["不会对漏记的装备和金额生效"] = true
    L[" {rt1}拍卖倒数{rt1}"] = true
    L["清空表格"] = true
    L["一键清空全部装备、买家、金额，同时还清空关注和欠款"] = true
    L["清空心愿"] = true
    L["一键清空全部心愿装备"] = true
    L["指定%s"] = true
    L["一键指定副本伽马%s"] = true
    L["副本已锁定"] = true
    L["装等+职业"] = true
    L["输入你的职业、天赋等"] = true
    L["输入你的经验、WCL分数等"] = true
    L["自定义文本1"] = true
    L["自定义文本2"] = true
    L["没有收入"] = true
    L["< 收 %s 入 >"] = true
    L["< 支 %s 出 >"] = true
    L["< 总 %s 览 >"] = true
    L["< 工 %s 资 >"] = true
    L["(长按ALT：仅通报总览)"] = true
    L["(长按SHITF：仅通报罚款)"] = true
    L["———通报总览———"] = true
    L["< 总 %s 览 >"] = true
    L["< 工 %s 资 >"] = true
    L["———通报罚款———"] = true
    L["———通报总览———"] = true
    L["———通报罚款———"] = true
    L["没有罚款"] = true
    L["没有支出"] = true
    L["通报流拍"] = true
    L["流拍："] = true
    L["没有流拍装备"] = true
    L["%s 流拍装备一共%s件 %s"] = true


    L["心愿"] = true


    L["日期："] = true
    L["频道名称："] = true
    L["评价："] = true
    L["理由："] = true
    L["打包交易"] = true
    L["表格里没找到此次交易的装备，或者该装备已记过账"] = true
    L["不能设置为心愿，因为该装备不是正常掉落"] = true
    L["不能设置为心愿，因为该BOSS的心愿格子已满"] = true


    L["掉落后会提醒"] = true
    L["重置为默认方案"] = true
    L["不能设置该装备为心愿，可能因为该装备不是正常掉落"] = true
    L["不能设置该装备为心愿，因为该BOSS的心愿格子已满"] = true
    L["心愿装备"] = true
    L["右键取消心愿装备"] = true
    L["装绑"] = true
    L["当前表格"] = true
    L["< 当前表格 >"] = true
    L["表格的核心功能都在这里"] = true
    L["心愿清单"] = true
    L["< 心愿清单 >"] = true
    L["你可以设置一些装备，这些装备只要掉落就会提醒，并且自动关注团长拍卖"] = true
    L["装备库"] = true
    L["< 装备库 >"] = true
    L["查看所有适合你的装备"] = true
    L["对账"] = true
    L["< 对账 >"] = true
    L["当团队有人通报BiaoGe/RaidLedger/大脚的账单，你可以选择该账单，来对账"] = true
    L["只对比装备收入，不对比罚款收入，也不对比支出"] = true
    L["别人账单会自动保存1天，过后自动删除"] = true
    L["YY评价"] = true
    L["< YY评价 >"] = true
    L["|cff808080（右键：开启/关闭该模块）|r"] = true
    L["你可以给YY频道做评价，帮助别人辨别该团好与坏"] = true
    L["你可以查询YY频道的大众评价"] = true
    L["聊天频道的YY号变为超链接，方便你复制该号码或查询大众评价"] = true
    L["替换集结号的评价框，击杀当前版本团本尾王后弹出"] = true
    L["< 团本攻略 >"] = true
    L["了解BOSS技能和应对策略、职业职责"] = true
    L["序号"] = true
    L["等级"] = true
    L["装备"] = true
    L["获取途径"] = true
    L["奥\n妮\n克\n希\n亚"] = true
    L["海\n里\n昂"] = true
    L["杂项"] = true
    L["小怪"] = true
    L["装绑"] = true
    L["该部位没有合适当前过滤方案的装备"] = true
    L["请在下方选择一个过滤方案"] = true
    L["没有过滤方案"] = true
    L["件"] = true
    L["过滤方案："] = true
    L["装备库："] = true


    L["自动关注心愿装备：%s。团长拍卖此装备时会提醒"] = true
    L["|cffffffff< 背景材质透明度 >|r|cff808080（右键还原设置）|r\n\n1、调整背景材质透明度"] = true
    L["背景材质透明度*"] = true
    L["岩石"] = true
    L["大理石"] = true
    L["黑夜"] = true
    L["皇帝的新衣"] = true
    L["背景材质*"] = true


    L["日常任务*"] = true
    L["更改至第几位"] = true
    L["修改名称/图标"] = true
    L["正在修改方案："] = true
    L["更改顺序"] = true
    L["删除方案"] = true
    L["使用装备过滤方案："] = true
    L["左键使用方案"] = true
    L["右键修改方案"] = true
    L["< 装备过滤 >"] = true
    L["关闭"] = true
    L["选择方案："] = true
    L["新建过滤方案"] = true
    L["名称："] = true
    L["图标："] = true
    L["确定"] = true
    L["名称"] = true
    L["图标"] = true
    L["不能新建"] = true
    L["不能修改"] = true
    L["还需填写："] = true
    L["返回"] = true
    L["新建过滤方案"] = true
    L["new"] = true
    L["方案数量已达上限，不能再新建方案"] = true
    L["新建过滤方案"] = true
    L["重置"] = true
    L["把方案重置为默认值"] = true
    L["默认方案"] = true
    L["其他"] = true
    L["勾选全部多选框"] = true
    L["取消勾选全部多选框"] = true
    L["自定义装备过滤方案"] = true
    L["装备属性中包含特定词缀时，就会被过滤。例如勾选了力量，如果装备中有力量属性，则该装备会被过滤"] = true
    L["装备词缀过滤"] = true
    L["例如勾选了单手剑，如果装备是单手剑，则会被过滤"] = true
    L["武器类型过滤"] = true
    L["例如勾选了布甲，如果装备是布甲，则会被过滤"] = true
    L["护甲类型过滤"] = true
    L["像套装兑换物这种有职业限定的装备，不适合你的会被过滤"] = true
    L["职业限定过滤"] = true
    L["没有%s任一属性的装备会被过滤（武器、饰品、圣物除外）"] = true
    L["坦克专属过滤"] = true
    L["死亡骑士-鲜血"] = true
    L["死亡骑士-冰霜/邪恶"] = true
    L["战士-防御"] = true
    L["战士-武器/狂怒"] = true
    L["圣骑士-神圣"] = true
    L["圣骑士-防御"] = true
    L["圣骑士-惩戒"] = true
    L["猎人"] = true
    L["萨满-元素"] = true
    L["萨满-增强"] = true
    L["萨满-恢复"] = true
    L["德鲁伊-平衡"] = true
    L["德鲁伊-巨熊"] = true
    L["德鲁伊-猎豹"] = true
    L["德鲁伊-恢复"] = true
    L["盗贼"] = true
    L["术士"] = true
    L["法师"] = true
    L["牧师-戒律/神圣"] = true
    L["牧师-暗影"] = true
    L["这里是指法系的副手，不是物理dps的副手武器"] = true
    L["单手剑"] = true
    L["单手斧"] = true
    L["单手锤"] = true
    L["匕首"] = true
    L["拳套"] = true
    L["双手剑"] = true
    L["双手斧"] = true
    L["双手锤"] = true
    L["长柄武器"] = true
    L["法杖"] = true
    L["枪"] = true
    L["弓"] = true
    L["弩"] = true
    L["魔杖"] = true
    L["投掷武器"] = true
    L["布甲"] = true
    L["全部布甲会被过滤（披风除外，否则本来合适你的披风也可能会被过滤）"] = true
    L["皮甲"] = true
    L["锁甲"] = true
    L["板甲"] = true
    L["盾牌"] = true
    L["圣契"] = true
    L["神像"] = true
    L["图腾"] = true
    L["魔印"] = true
    L["过滤职业限定的装备"] = true
    L["过滤职业限定的装备"] = true
    L["像套装兑换物这种有职业限定的装备，不适合你的会被过滤"] = true
    L["过滤没有坦克属性的装备"] = true


    L["周常"] = true
    L["该周常是指达拉然的周常，不是ICC副本内的周常"] = true
    L["没有%s属性的装备（武器和饰品部位除外）"] = true
    L["含有%s属性的装备"] = true


    L["如果你想关闭该功能，可在插件设置-BiaoGe-角色总览里关闭"] = true
    L["SHIFT+点击："] = true
    L["< 我是教程 >"] = true
    L["鉴于部分玩家找不到|cff00BFFF切换模块|r的按钮，特做此教程：\n按钮就在底下|cffFF0000红色框框|r里"] = true
    L["@_@ 我知道了。。"] = true
    L["伽马"] = true
    L["英雄"] = true


    L["该BOSS攻略提供：@大树先生\n点击复制NGA攻略地址"] = true
    L["3、右键聊天频道玩家的菜单里增加密语模板按钮"] = true
    L["4、右键聊天输入框增加密语模板按钮"] = true
    L["< 查询大众评价 >"] = true
    L["1、对BiaoGeYY频道的在线玩家发出该YY的请求"] = true
    L["2、如果这些玩家有该YY的评价，则会通过匿名方式把评价发送给你"] = true
    L["3、不同时间查询到的大众评价可能会不同，因为在线的玩家会不同"] = true


    L["使用密语模板"] = true
    L["查询正在初始化，请稍后再试"] = true
    L["正在查询中"] = true
    L["查询CD中，剩余%s秒"] = true
    L["正在查询YY%s的大众评价"] = true
    L["详细"] = true
    L["|cffFFFFFF左键：|r查询大众评价"] = true
    L["|cffFFFFFFSHIFT+左键：|r复制该号码"] = true
    L["以往查询结果(%s)："] = true
    L["以往查询结果(可能已过时)："] = true
    L["|cff00FF00好评：%s个|r"] = true
    L["|cffFFFF00中评：%s个|r"] = true
    L["|cffDC143C差评：%s个|r"] = true
    L["查询成功：YY%s的评价|cffFFFFFF一共%s个|r。|cff00FF00好评%s个|r，|cffFFFF00中评%s个|r，|cffDC143C差评%s个。|r%s"] = true
    L["查询成功！CD"] = true


    L["你的评价可以帮助别人辨别该团好与坏\n当其他玩家查询大众评价而你有该YY的评价时，会以匿名的方式发送给对方"] = true
    L["你的评价被其他玩家查询的次数"] = true


    L["1、预设成就、装等、自定义文本，当你点击集结号活动密语时会自动添加该内容"] = true
    L["2、按住SHIFT+点击密语时不会添加"] = true


    L["|cff808080（右键打开设置）|r"] = true
    L["|cff808080（左键打开表格，右键打开设置）|r"] = true


    L["该攻略是按照25H去呈现，但由于暴雪数据库问题，部分技能链接里的描述文本并不符合25H的真实情况。请看技能的介绍文本"] = true
    L["|cffffffff< 角色5人本完成总览 >|r\n\n1、在队伍查找器旁边显示角色5人本完成总览"] = true
    L["显示角色5人本完成总览*"] = true
    L["|cffffffff< 团本攻略字体大小 >|r|cff808080（右键还原设置）|r\n\n1、调整该字体的大小"] = true
    L["团本攻略字体大小"] = true
    L["|cffffffff< 密语模板 >|r\n\n1、预设成就、装等、自定义文本，当你点击集结号活动密语时会自动添加该内容\n2、按住SHIFT+点击密语时不会添加"] = true
    L["密语模板*"] = true
    L["< 历史搜索记录 >"] = true
    L["|cffFFFFFF左键：|r搜索该记录\n|cffFFFFFF右键：|r删除该记录"] = true
    L["把搜索文本添加至历史记录"] = true
    L["密语模板"] = true
    L["< 密语模板 >"] = true
    L["成就"] = true
    L["成就ID："] = true
    L["成就ID参考"] = true
    L["当前没有成就"] = true
    L["装等"] = true
    L["自定义文本"] = true
    L["自定义文本参考"] = true
    L["1、可以输入你的职业、天赋"] = true
    L["2、或你的经验、WCL分数等等"] = true
    L["其他功能"] = true


    L["|cffffffff< 按队伍人数排序 >|r\n\n1、集结号活动可以按队伍人数排序"] = true
    L["按队伍人数排序*"] = true


    L["|cffFFFFFF左键：|r搜索该记录\n|cffFFFFFF右键：|r删除该记录"] = true
    L["集结号"] = true
    L["|cffffffff< 历史搜索记录 >|r\n\n1、给集结号的搜索框增加一个历史搜索记录，提高你搜索的效率"] = true
    L["历史搜索记录*"] = true
    L["|cffffffff< 不自动退出集结号频道 >|r\n\n1、这样你可以一直同步集结号的组队消息，让你随时打开集结号都能查看全部活动"] = true
    L["不自动退出集结号频道*"] = true


    L["|cffffffff< YY评价 >|cff808080（右键：开启/关闭该模块）|r|r\n\n1、你可以给YY频道做评价，帮助别人辨别该团好与坏\n2、你可以查询YY频道的大众评价\n3、聊天频道的YY号变为超链接，方便你复制该号码或查询大众评价\n4、替换集结号的评价框，击杀当前版本团本尾王后弹出\n"] = true
    L["模块开关"] = true
    L["开启"] = true
    L["关闭"] = true
    L["该模块已关闭。右键底部标签页开启"] = true
    L["< 历史搜索记录 >"] = true
    L["把搜索文本添加至历史记录"] = true


    L["团本攻略"] = true
    L["|cffffffff< 团本攻略 >|r\n\n1、了解BOSS技能和应对策略、职业职责\n"] = true
    L["查看该BOSS攻略"] = true
    L["当前时光徽章不可用"] = true
    L["< BOSS >"] = true
    L["< 技能应对 >"] = true
    L["< 职业职责 >"] = true
    L["（SHIFT+点击技能可发送到聊天框）"] = true
    L["该BOSS攻略提供：@大树先生"] = true
    L["介绍："] = true
    L["应对："] = true
    L["坦克预警"] = true
    L["输出预警"] = true
    L["治疗预警"] = true
    L["英雄难度"] = true
    L["灭团技能"] = true
    L["重要"] = true
    L["可打断技能"] = true
    L["法术效果"] = true
    L["诅咒"] = true
    L["中毒"] = true
    L["疾病"] = true
    L["坦克职责"] = true
    L["治疗职责"] = true
    L["输出职责"] = true
    L["近战职责"] = true
    L["远程职责"] = true
    L["该副本没有团本攻略"] = true


    L["< BiaoGe > 你的当前版本%s已过期，请更新插件"] = true
    L["团长YY（根据聊天记录帮你生成）"] = true
    L["详细评价"] = true
    L["< 快速评价 >"] = true
    L["恭喜你们击杀尾王！请给团长个评价吧！"] = true
    L["YY号必填，填写数字"] = true
    L["评价:"] = true
    L["评价必填，默认中评"] = true
    L["必填"] = true
    L["修改评价"] = true
    L["详细评价"] = true
    L["好评"] = true
    L["中评"] = true
    L["差评"] = true
    L["感谢你的评价：|cff%sYY%s，%s|r"] = true
    L["保存"] = true
    L["详细评价"] = true
    L["|cffffffff< 详细评价 >|r\n\n1、在金团表格里写详细评价"] = true
    L["|cffffffff< 修改评价 >|r\n\n1、该YY号已有评价，去金团表格里修改评价"] = true
    L["退出"] = true


    L["|cffffffff< 装备记录通知字体大小 >|r|cff808080（右键还原设置）|r\n\n1、调整该字体的大小"] = true
    L["装备记录通知字体大小*"] = true
    L["|cffffffff< 交易通知字体大小 >|r|cff808080（右键还原设置）|r\n\n1、调整该字体的大小"] = true
    L["交易通知字体大小*"] = true
    L["|cffffffff< 当前表格 >|r\n\n1、表格的核心功能都在这里"] = true
    L["当前表格"] = true
    L["对账"] = true
    L["心愿清单"] = true
    L["YY评价"] = true
    L["团员插件版本"] = true
    L["插件版本：%s"] = true

    L["当前时光徽章："] = true
    L["|cffFFFFFF左键：|r查询|cff00BFFFYY%s|r的大众评价\n|cffFFFFFFSHIFT+左键：|r复制该YY号"] = true
    L["通报至团队通知频道"] = true
    L["通报至团队频道"] = true
    L["|cffffffff< 拍卖倒数时长 >|r|cff808080（右键还原设置）|r\n\n1、拍卖装备倒数多久，默认是8秒"] = true
    L["拍卖倒数时长(秒)*"] = true
    L["|cffffffff< 拍卖倒数 >|r\n\n1、该功能只有团长或物品分配者可用\n2、ALT+点击当前表格、背包、聊天框的装备，自动开始拍卖倒数\n3、背包目前支持原生背包、NDUI背包、EUI背包、大脚背包\n"] = true
    L["拍卖倒数*"] = true
    L["你已共享|r |cff00FF00%s|r |cffffffff人次评价"] = true
    L["{rt7}倒数暂停{rt7}"] = true
    L[" {rt1}拍卖倒数"] = true
    L["秒{rt1}"] = true

    L["（左键修改评价，SHIFT+左键查询大众评价，ALT+右键删除评价）"] = true
    L["|cffffffff< 共享我的评价 >   （你已共享|r |cff00FF00%s|r |cffffffff人次评价）|r\n\n1、当别人查询大众评价时，如果你有该YY的评价，则会以匿名的方式共享给对方\n2、如果你不开启该功能，则你的查询大众评价功能会被禁用，因为共享是相互的\n3、开启该功能后，会使聊天记录里的YY号变为超链接\n4、没满级的角色会被禁止共享和使用查询大众评价"] = true
    L["金币已超上限！"] = true

    L["|cffffffff< YY评价 >|r\n\n1、你可以查询某个YY的评价如何\n2、降低你进入坑团的可能\n"] = true
    L["< 新增评价 >"] = true
    L["YY号必填，填写数字"] = true
    L["频道名称:"] = true
    L["频道名称选填，方便自己辨认是哪个YY\n该名称不会共享给别人，仅自己可见"] = true
    L["评价:"] = true
    L["评价必填，默认中评"] = true
    L["理由:"] = true
    L["理由选填"] = true
    L["必填"] = true
    L["选填"] = true
    L["好评"] = true
    L["中评"] = true
    L["差评"] = true
    L["好评或差评需要填写不少于6字"] = true
    L["保存评价"] = true
    L["|cffffffff< 保存评价 >|r\n\n1、必填项填完才能保存\n2、同一个YY只能写一次评价，但你可以修改之前的评价"] = true
    L["退出修改"] = true
    L["该YY已有评价，需要修改吗？"] = true
    L["< 我的评价 >"] = true
    L["序号"] = true
    L["日期"] = true
    L["YY"] = true
    L["频道名称"] = true
    L["评价"] = true
    L["理由"] = true
    L["正在初始化"] = true
    L["|cffffffff< 共享我的评价 >   （你已共享|r |cff00FF00%s|r |cffffffff人次评价）|r\n\n1、当别人查询大众评价时，如果你有该YY的评价，则会以匿名的方式共享给对方\n2、如果你不开启该功能，则你的查询大众评价功能会被禁用，所以共享是相互的\n3、没满级的角色会被禁止共享和使用查询大众评价"] = true
    L["理由"] = true
    L["好评"] = true
    L["中评"] = true
    L["差评"] = true
    L["< 新增评价 >"] = true
    L["保存评价"] = true
    L["< 修改评价 >"] = true
    L["保存修改"] = true
    L["（左键修改评价，SHIFT+左键把yy号发到查询里，ALT+右键删除评价）"] = true
    L["< 查询大众评价 >"] = true
    L["查询成功：YY%s的评价|cffFFFFFF一共%s个|r。|cff00FF00好评%s个|r，|cffFFFF00中评%s个|r，|cffDC143C差评%s个|r"] = true
    L["查询成功！CD"] = true
    L["查询"] = true
    L["无"] = true
    L["查询失败：没有找到YY%s的评价"] = true
    L["查询中 "] = true
    L["查询"] = true
    L["正在初始化"] = true
    L["个)|r"] = true
    L["无"] = true
    L["无"] = true
    L["无"] = true
    L["历史查询："] = true
    L["筛选："] = true
    L["全部"] = true
    L["好评"] = true
    L["中评"] = true
    L["差评"] = true
    L[" (0个)"] = true
    L["无"] = true
    L["序号"] = true
    L["日期"] = true
    L["YY"] = true
    L["评价"] = true
    L["理由"] = true
    L["理由"] = true
    L["个"] = true
    L["个"] = true
    L["查询"] = true
    L["共享我的评价"] = true
    L["查询"] = true
    L["共享我的评价"] = true
    L["共享我的评价"] = true
    L["查询"] = true

    L["< BiaoGe > 金 团 表 格"] = true
    L["|cff808080（带*的设置为即时生效，否则需要重载才能生效）|r"] = true
    L["重载界面"] = true
    L["不能即时生效的设置在重载后生效"] = true
    L["表格"] = true
    L["角色总览"] = true
    L["表格"] = true
    L["表格"] = true
    L["角色总览"] = true
    L["角色总览"] = true
    L["|cffffffff< UI缩放 >|r|cff808080（右键还原设置）|r\n\n1、调整表格UI的大小"] = true
    L["UI缩放*"] = true
    L["|cffffffff< UI透明度 >|r|cff808080（右键还原设置）|r\n\n1、调整表格UI的透明度"] = true
    L["UI透明度*"] = true
    L["|cffffffff< 自动记录装备 >|r\n\n1、在团本里拾取装备时，会自动记录进表格\n2、只会记录橙装、紫装、和蓝色的宝珠，不会记录图纸，小怪掉落会记录到杂项里\n"] = true
    L["自动记录装备*"] = true
    L["|cffffffff< 装备记录通知时长 >|r|cff808080（右键还原设置）|r\n\n1、自动记录装备后会在屏幕上方通知记录结果"] = true
    L["装备记录通知时长(秒)"] = true
    L["|cffffffff< 交易自动记账 >|r\n\n1、需要配合自动记录装备，因为如果表格里没有该交易的装备，则记账失败\n2、如果一次交易两件装备以上，则只会记第一件装备\n"] = true
    L["交易自动记账*"] = true
    L["|cffffffff< 交易通知时长 >|r|cff808080（右键还原设置）|r\n\n1、通知显示多久"] = true
    L["交易通知时长(秒)"] = true
    L["|cffffffff< 交易通知 >|r\n\n1、交易完成后会在屏幕中央通知本次记账结果\n"] = true
    L["交易通知*"] = true
    L["|cffffffff< 记账效果预览框 >|r\n\n1、交易的时候，可以预览这次的记账效果\n2、如果这次交易的装备不在表格，则可以选择强制记账"] = true
    L["记账效果预览框*"] = true
    L["|cffffffff< 高亮拍卖装备 >|r\n\n1、当团长或物品分配者贴出装备开始拍卖时，会自动高亮表格里相应的装备"] = true
    L["高亮拍卖装备*"] = true
    L["|cffffffff< 高亮拍卖装备时长 >|r|cff808080（右键还原设置）|r\n\n1、高亮拍卖装备多久"] = true
    L["高亮拍卖装备时长(秒)*"] = true
    L["|cffffffff< 拍卖聊天记录框 >|r\n\n1、自动记录全团跟拍卖有关的聊天\n2、当你点击买家或金额时会显示拍卖聊天记录"] = true
    L["拍卖聊天记录框*"] = true
    L["|cffffffff< 金额自动加零 >|r\n\n1、输入金额和欠款时自动加两个0，减少记账操作，提高记账效率"] = true
    L["金额自动加零*"] = true
    L["|cffffffff< 对账单保存时长(小时) >|r|cff808080（右键还原设置）|r\n\n1、对账单保存多久后自动删除"] = true
    L["对账单保存时长(小时)"] = true
    L["|cffffffff< 进本提示清空表格 >|r\n\n1、每次进入副本都会提示清空表格"] = true
    L["进本提示清空表格*"] = true
    L["|cffffffff< 按键交互声音 >|r\n\n1、点击按钮时的声音"] = true
    L["按键交互声音*"] = true
    L["|cffffffff< 小地图图标 >|r\n\n1、显示小地图图标"] = true
    L["小地图图标*"] = true
    L["人"] = true
    L["删除角色"] = true
    L["删除角色"] = true
    L["总览数据"] = true
    L["巫妖王之怒*"] = true
    L["燃烧的远征*"] = true
    L["经典旧世*"] = true
    L["货币*"] = true
    L["|cffffffff< 清空表格时根据副本难度设置分钱人数 >|r\n\n1、10人团本默认分钱人数为10人\n2、25人团本默认分钱人数为25人"] = true
    L["清空表格时根据副本难度设置分钱人数*"] = true
    L["|cffFFFFFF10人团本分钱人数：|r"] = true
    L["|cffFFFFFF25人团本分钱人数：|r"] = true
    L["快捷命令：/BGO"] = true
    L["|cffffffff< 清空表格时保留支出补贴名称 >|r\n\n1、只保留补贴名称（例如XX补贴），支出玩家和支出金额正常清空\n2、这样就不用每次都重复填写补贴名称\n3、只有补贴名称，但没有补贴金额的，在通报账单时不会被通报"] = true
    L["清空表格时保留支出补贴名称*"] = true

    L["< BiaoGe > 金 团 表 格"] = true
    L["<说明书与更新记录> "] = true
    L["保存至历史表格"] = true
    L["该表格已在你历史表格里"] = true
    L["历史表格（%d个）"] = true
    L["已保存至历史表格1"] = true
    L["设置"] = true
    L["当前难度:"] = true
    L["切换副本难度"] = true
    L["10人|cff00BFFF普通|r"] = true
    L["25人|cff00BFFF普通|r"] = true
    L["10人|cffFF0000英雄|r"] = true
    L["25人|cffFF0000英雄|r"] = true
    L["确认切换难度为< %s >？"] = true
    L["心愿清单"] = true
    L["清空当前表格"] = true
    L["关闭心愿清单"] = true
    L["清空当前心愿"] = true
    L["对账"] = true
    L["关闭对账"] = true
    L["要清空表格< %s >吗？"] = true
    L["角色"] = true
    L["黑龙"] = true
    L["宝库"] = true
    L["赛德精华"] = true
    L["金币"] = true
    L["< 角色团本完成总览 >"] = true
    L["（团本重置时间：%s）"] = true
    L["当前没有符合的角色"] = true
    L["（右键删除角色总览数据）"] = true
    L["（插件右下角右键可删除数据）"] = true
    L["< 角色货币总览 >"] = true
    L["金"] = true
    L["合计"] = true
    L["删除角色"] = true
    L["总览数据"] = true
    L["你关注的装备开始拍卖了：%s（右键取消关注）"] = true
    L["已成功关注装备：%s。团长拍卖此装备时会提醒"] = true
    L["<自动记录装备>"] = true
    L["已取消关注装备：%s"] = true
    L["你的心愿达成啦！！！>>>>> %s(%s) <<<<<"] = true
    L["已自动记入表格：%s%s(%s) x%d => %s< %s >%s"] = true
    L["自动关注心愿装备：%s%s。团长拍卖此装备时会提醒"] = true
    L["自动记录失败：%s%s(%s)。因为%s< %s >%s的格子满了。。"] = true
    L["自动关注心愿装备失败：%s%s"] = true
    L["已自动记入表格：%s%s(%s) => %s< %s >%s"] = true
    L["< 交易记账失败 >"] = true
    L["双方都给了装备，但没金额"] = true
    L["我不知道谁才是买家"] = true
    L["如果有金额我就能识别了"] = true
    L["（欠款%d）"] = true
    L["< 交易记账成功 >"] = true
    L["< 交易记账成功 >|r\n装备：%s\n买家：%s\n金额：%s%d|rg%s\nBOSS：%s< %s >|r"] = true
    L["表格里没找到此次交易的装备"] = true
    L["该BOSS格子已满"] = true
    L["欠款："] = true
    L["记账效果预览"] = true
    L["无"] = true
    L["交易自动记账"] = true
    L["次"] = true
    L["打断"] = true
    L["级"] = true
    L["装等"] = true
    L["分钟"] = true
    L["时间"] = true
    L["已清空表格< %s >，分钱人数已改为%s人"] = true
    L["已清空表格< %s >"] = true
    L["已清空心愿< %s >"] = true
    L["确认清空表格< %s >？"] = true
    L["高亮该天赋的装备"] = true
    L["<金额自动加零>"] = true
    L["<UI缩放>"] = true
    L["<UI透明度>"] = true
    L["< BiaoGe > 版本过期提醒，最新版本是：%s，你的当前版本是：%s"] = true
    L["你可以前往curseforge搜索biaoge更新"] = true
    L["< BiaoGe > 金团表格载入成功。插件命令：%s或%s，小地图图标：%s"] = true
    L["星星"] = true
    L["BiaoGe金团表格"] = true
    L["显示/关闭表格"] = true
    L["对比的账单："] = true
    L["  项目"] = true
    L["装备"] = true
    L["我的金额"] = true
    L["对方金额"] = true
    L["装备总收入"] = true
    L["差额"] = true
    L["买家"] = true
    L["金额"] = true
    L["关注"] = true
    L["关注中，团长拍卖此装备会提醒"] = true
    L["右键取消关注"] = true
    L["欠款：%s|r\n右键清除欠款"] = true
    L["坦克补贴"] = true
    L["治疗补贴"] = true
    L["输出补贴"] = true
    L["放鱼补贴"] = true
    L["人数可自行修改"] = true
    L["（SHIFT+点击可发送装备，CTRL+点击可通报历史价格）"] = true
    L["（ALT+点击可关注装备，SHIFT+点击可发送装备，CTRL+点击可通报历史价格）"] = true
    L["欠款金额"] = true
    L["不在团队，无法通报"] = true
    L["———通报历史价格———"] = true
    L["装备：%s(%s)"] = true
    L["月"] = true
    L["日"] = true
    L["，价格:"] = true
    L["，买家:"] = true
    L["取消交换"] = true
    L["你正在交换该行全部内容"] = true
    L["\n点击取消交换"] = true
    L["交换成功"] = true
    L["（ALT+左键改名，ALT+右键删除表格）"] = true
    L["保存表格"] = true
    L["把当前表格保存至历史表格"] = true
    L["%m月%d日%H:%M:%S\n"] = true
    L["%s%s %s人 工资:%s"] = true
    L["分享表格"] = true
    L["把当前表格发给别人，类似发WA那样"] = true
    L["当前表格-"] = true
    L["历史表格-"] = true
    L["导出表格"] = true
    L["把表格导出为文本"] = true
    L["应用表格"] = true
    L["把该历史表格复制粘贴到当前表格，这样你可以编辑内容"] = true
    L["确定应用表格？\n你当前的表格将被"] = true
    L[" 替换 "] = true
    L["当前名字："] = true
    L["名字改为："] = true
    L["确定"] = true
    L["取消"] = true
    L["（CTRL+点击可通报历史价格）"] = true
    L["< 历史表格 > "] = true
    L["你正在改名第 %s 个表格"] = true
    L["< |cffFFFFFF10人|r|cff00BFFF普通|r >"] = true
    L["< |cffFFFFFF25人|r|cff00BFFF普通|r >"] = true
    L["< |cffFFFFFF10人|r|cffFF0000英雄|r >"] = true
    L["< |cffFFFFFF25人|r|cffFF0000英雄|r >"] = true
    L["心愿1"] = true
    L["心愿2"] = true
    L["已掉落"] = true
    L["恭喜你，该装备已掉落"] = true
    L["右键取消提示"] = true
    L["当前团队还有 %s 人也许愿该装备！"] = true
    L["查询心愿竞争"] = true
    L["查询团队里，有多少人许愿跟你相同的装备"] = true
    L["不在团队，无法查询"] = true
    L["恭喜你，当前团队没人许愿跟你相同的装备"] = true
    L["分享心愿10PT"] = true
    L["分享心愿25PT"] = true
    L["分享心愿10H"] = true
    L["分享心愿25H"] = true
    L["< 我 的 心 愿 >"] = true
    L["副本难度："] = true
    L["频道：团队"] = true
    L["频道：队伍"] = true
    L["不在队伍，无法通报"] = true
    L["频道：公会"] = true
    L["没有公会，无法通报"] = true
    L["频道：密语"] = true
    L["没有目标，无法通报"] = true
    L["————我的心愿————"] = true
    L["——感谢使用金团表格——"] = true
    L["队伍"] = true
    L["公会"] = true
    L["团队"] = true
    L["密语目标"] = true
    L["心愿清单："] = true
    L["心愿装备只要掉落就会有提醒，并且掉落后自动关注团长拍卖"] = true
    L["你今天的运气指数(1-100)："] = true
    L["当前表格"] = true
    L["历史表格"] = true
    L["（当前为自动显示)"] = true
    L["<BiaoGe>金团表格"] = true
    L["左键：|r打开表格"] = true
    L["中键：|r切换自动显示角色总览"] = true
    L["（当前为不自动显示)"] = true
    L["通报流拍"] = true
    L["< 流 拍 装 备 >"] = true
    L["通报欠款"] = true
    L["< 通 报 欠 款 >"] = true
    L["< 合 计 欠 款 >"] = true
    L["没记买家"] = true
    L["合计欠款："] = true
    L["————通报欠款————"] = true
    L["{rt7} 合计欠款 {rt7}"] = true
    L[" 合计欠款："] = true
    L["没有WCL记录"] = true
    L["读取不到数据，你可能没安装或者没打开WCL插件"] = true
    L["更新时间："] = true
    L["< WCL分数 >"] = true
    L["———通报WCL分数———"] = true
    L["通报WCL"] = true
    L["通报消费"] = true
    L["< 消 费 排 名 >"] = true
    L["———通报消费排名———"] = true
    L["< 通报击杀用时 >"] = true
    L["———通报击杀用时———"] = true
    L["分"] = true
    L["秒"] = true
    L["击杀用时："] = true
    L["通报账单"] = true
    L["< 收  入 >"] = true
    L["Boss："] = true
    L["项目："] = true
    L["< 支  出 >"] = true
    L["< 总  览 >"] = true
    L["< 工  资 >"] = true
    L["———通报金团账单———"] = true
    L["< 收 {rt1} 入 >"] = true
    L["< 支 {rt4} 出 >"] = true
    L["< 总 {rt3} 览 >"] = true
    L["人"] = true
    L["< 工 {rt6} 资 >"] = true
    L["|cffffffff< 心愿清单 >|r\n\n1、你可以设置一些装备，\n    这些装备只要掉落就会有提醒，\n    并且掉落后自动关注团长拍卖\n"] = true
    L["|cffffffff< 自动记录装备 >|r\n\n1、只会记录紫装和橙装\n2、橙片、飞机头、小怪掉落\n    会存到杂项里\n3、图纸不会自动保存\n"] = true
    L["|cffffffff< 对账 >|r\n\n1、当团队有人通报BiaoGe/RaidLedger/大脚的账单，\n    你可以选择该账单，来对账\n2、只对比装备收入，不对比罚款收入，也不对比支出\n3、别人账单会自动保存1天，过后自动删除\n"] = true
    L["|cffffffff< 交易自动记账 >|r\n\n1、需要配合自动记录装备，因为\n    如果表格里没有该交易的装备，\n    则记账失败\n2、如果一次交易两件装备以上，\n    则只会记第一件装备，\n"] = true
    L["|cffffffff< 清空当前表格/心愿 >|r\n\n1、表格界面时一键清空装备、买家、金额，同时还清空关注和欠款\n2、心愿界面时一键清空全部心愿装备\n"] = true
    L["|cffffffff< 金额自动加零 >|r\n\n1、输入金额和欠款时自动加两个0\n    减少记账操作，提高记账效率\n"] = true
    L["通报金团账单"] = true
    L["RaidLedger:.... 收入 ...."] = true
    L["事件：.-|c.-|Hitem.-|h|r"] = true
    L["(%d+)金"] = true
    L["收入为："] = true
    L["收入为：%d+。"] = true
    L["平均每人收入:"] = true
    L["感谢使用金团表格"] = true
    L["，装备总收入"] = true
    L["-感谢使用大脚金团辅助工具-"] = true
    L["总收入"] = true
    L["总支出"] = true
    L["净收入"] = true
    L["分钱人数"] = true
    L["人均工资"] = true
    L["历史价格：%s%s(%s)"] = true
    L["通报用时"] = true
    L["返回表格"] = true
    L["当前"] = true
    L["没有金额"] = true
    L["———通报流拍装备———"] = true
    L["欠"] = true
    L["人"] = true
    L["< 角色总览设置 >"] = true
    L["删除角色"] = true
    L["巫妖王之怒"] = true
    L["燃烧的远征"] = true
    L["经典旧世"] = true
    L["货币"] = true
    L["角色"] = true
    L["（右键打开设置）"] = true
    L["< 角色货币总览 >"] = true
    L["中键：|r切换自动显示角色总览"] = true
    L["右键：|r打开设置"] = true
    L[" （测试） "] = true
    L["通知锁定"] = true
    L["通知移动"] = true
    L["调整装备记录通知和交易通知的位置\n快捷命令：/BGM"] = true
    L["|cffFF0000（欠款2000）|r"] = true
    L["装备记录通知"] = true
    L["交易通知"] = true
end


-- BOSS名字
do
    L["你\n漏\n记\n的\n装\n备"] = true
    L["总\n结"] = true
    L["工\n资"] = true
    L["杂\n\n项"] = true
    L["罚\n\n款"] = true
    L["支\n\n出"] = true
    L["总\n览"] = true

    -- WLK
    do
        L["玛\n洛\n加\n尔"] = true
        L["亡\n语\n者\n女\n士"] = true
        L["炮\n舰\n战"] = true
        L["萨\n鲁\n法\n尔"] = true
        L["烂\n肠"] = true
        L["腐\n面"] = true
        L["普\n崔\n塞\n德\n教\n授"] = true
        L["鲜\n血\n议\n会"] = true
        L["鲜\n血\n女\n王"] = true
        L["踏\n梦\n者"] = true
        L["辛\n达\n苟\n萨"] = true
        L["巫\n妖\n王"] = true
        L["海\n里\n昂"] = true

        L["诺\n森\n德\n猛\n兽"] = true
        L["加\n拉\n克\n苏\n斯"] = true
        L["阵\n营\n冠\n军"] = true
        L["瓦\n克\n里\n双\n子"] = true
        L["阿\n努\n巴\n拉\n克"] = true
        L["嘉\n奖\n宝\n箱"] = true
        L["奥\n妮\n克\n希\n亚"] = true

        L["烈\n焰\n巨\n兽"] = true
        L["锋\n鳞"] = true
        L["掌\n炉\n者"] = true
        L["拆\n解\n者"] = true
        L["钢\n铁\n议\n会"] = true
        L["科\n隆\n加\n恩"] = true
        L["欧\n尔\n利\n亚"] = true
        L["霍\n迪\n尔"] = true
        L["托\n里\n姆"] = true
        L["弗\n蕾\n亚"] = true
        L["米\n米\n尔\n隆"] = true
        L["维\n扎\n克\n斯\n将\n军"] = true
        L["尤\n格\n萨\n隆"] = true
        L["奥\n尔\n加\n隆"] = true

        L["阿\n努\n布\n雷\n坎"] = true
        L["黑\n女\n巫\n法\n琳\n娜"] = true
        L["迈\n克\n斯\n纳"] = true
        L["瘟\n疫\n使\n者\n诺\n斯"] = true
        L["肮\n脏\n的\n希\n尔\n盖"] = true
        L["洛\n欧\n塞\n布"] = true
        L["教\n官"] = true
        L["收\n割\n者\n戈\n提\n克"] = true
        L["天\n启\n四\n骑\n士"] = true
        L["帕\n奇\n维\n克"] = true
        L["格\n罗\n布\n鲁\n斯"] = true
        L["格\n拉\n斯"] = true
        L["塔\n迪\n乌\n斯"] = true
        L["萨\n菲\n隆"] = true
        L["克\n尔\n苏\n加\n德"] = true
        L["萨\n塔\n里\n奥"] = true
        L["玛\n里\n苟\n斯"] = true
    end

    -- 永久60
    do
        L["鲁\n西\n弗\n隆"] = true
        L["玛\n格\n曼\n达"] = true
        L["基\n赫\n纳\n斯"] = true
        L["加\n尔"] = true
        L["沙\n斯\n拉\n尔"] = true
        L["迦\n顿\n男\n爵"] = true
        L["古\n雷\n曼\n格"] = true
        L["萨\n弗\n隆\n先\n驱\n者"] = true
        L["埃\n克\n索\n图\n斯"] = true
        L["拉\n格\n纳\n罗\n斯"] = true
        L["奥\n妮\n克\n希\n亚"] = true

        L["狂\n野\n的\n拉\n佐\n格\n尔"] = true
        L["堕\n落\n的\n瓦\n拉\n斯\n塔\n兹"] = true
        L["勒\n什\n雷\n尔"] = true
        L["费\n尔\n默"] = true
        L["埃\n博\n诺\n克"] = true
        L["弗\n莱\n格\n尔"] = true
        L["克\n洛\n玛\n古\n斯"] = true
        L["奈\n法\n利\n安"] = true

        L["耶\n克\n里\n克"] = true
        L["温\n诺\n希\n斯"] = true
        L["玛\n尔\n里"] = true
        L["血\n领\n主\n曼\n多\n基\n尔"] = true
        L["疯\n狂\n之\n缘"] = true
        L["加\n兹\n兰\n卡"] = true
        L["塞\n卡\n尔"] = true
        L["娅\n尔\n罗"] = true
        L["妖\n术\n师\n金\n度"] = true
        L["哈\n卡"] = true

        L["库\n林\n纳\n克\n斯"] = true
        L["拉\n贾\n克\n斯\n将\n军"] = true
        L["莫\n阿\n姆"] = true
        L["吞\n咽\n者\n布\n鲁"] = true
        L["狩\n猎\n者\n阿\n亚\n米\n斯"] = true
        L["无\n疤\n者\n奥\n斯\n里\n安"] = true

        L["预\n言\n者\n斯\n克\n拉\n姆"] = true
        L["安\n其\n拉\n三\n宝"] = true
        L["沙\n尔\n图\n拉"] = true
        L["顽\n强\n的\n范\n克\n瑞\n斯"] = true
        L["维\n希\n度\n斯"] = true
        L["哈\n霍\n兰\n公\n主"] = true
        L["双\n子\n皇\n帝"] = true
        L["奥\n罗"] = true
        L["克\n苏\n恩"] = true

        L["艾索雷葛斯"] = true
        L["卡扎克"] = true
        L["莱索恩"] = true
        L["艾莫莉丝"] = true
        L["泰拉尔"] = true
        L["伊森德雷"] = true
    end

    -- 60级赛季服
    do
        L["阿\n奎\n尼\n斯\n男\n爵"] = true
        L["加\n摩\n拉"] = true
        L["萨\n利\n维\n丝"] = true
        L["格\n里\n哈\n斯\n特"] = true
        L["洛\n古\n斯\n·\n杰\n特"] = true
        L["梦\n游\n者\n克\n尔\n里\n斯"] = true
        L["阿\n库\n麦\n尔"] = true

        L["矿工约翰森"] = true
        L["斯尼德"] = true
        L["基尔尼格"] = true
        L["重锤先生"] = true
        L["绿皮队长"] = true
        L["艾德温·范克里夫"] = true
        L["曲奇"] = true
        L["考布莱恩"] = true
        L["克雷什"] = true
        L["皮萨斯"] = true
        L["斯卡姆"] = true
        L["瑟芬迪斯"] = true
        L["永生者沃尔丹"] = true
        L["吞噬者穆坦努斯"] = true
        L["变异精灵龙"] = true
        L["屠夫拉佐克劳"] = true
        L["席瓦莱恩男爵"] = true
        L["指挥官"] = true
        L["盲眼守卫奥杜"] = true
        L["幻影之甲"] = true
        L["狼王南杜斯"] = true
        L["大法师阿鲁高"] = true
        L["布鲁高·铁拳"] = true

        L["格\n鲁\n比\n斯"] = true
        L["粘\n性\n辐\n射\n尘"] = true
        L["电\n刑\n器\n6\n0\n0\n0\n型"] = true
        L["群\n体\n打\n击\n者"] = true
        L["黑\n铁\n大\n师"] = true
        L["瑟\n玛\n普\n拉\n格"] = true
        L["机\n械\n动\n物\n园"] = true

        L["亡语者贾格巴"] = true
        L["主宰拉姆塔斯"] = true
        L["暴怒的阿迦赛罗斯"] = true
        L["盲眼猎手"] = true
        L["卡尔加·刺肋"] = true
        L["唤地者哈穆加"] = true
        L["审讯员韦沙斯"] = true
        L["永醒的艾希尔"] = true
        L["死灵勇士"] = true
        L["铁脊死灵"] = true
        L["血法师萨尔诺斯"] = true
        L["驯犬者洛克希"] = true
        L["奥法师杜安"] = true
        L["赫洛德"] = true
        L["莫格莱尼"] = true
        L["怀特迈恩"] = true
        L["图特卡什"] = true
        L["火眼莫德雷斯"] = true
        L["暴食者"] = true
        L["拉戈斯诺特"] = true
        L["寒冰之王亚门纳尔"] = true
        L["腐烂的普雷莫尔"] = true
        L["埃瑞克"] = true
        L["巴尔洛戈"] = true
        L["奥拉夫"] = true
        L["鲁维罗什"] = true
        L["艾隆纳亚"] = true
        L["石头看守者"] = true
    end

    -- L[] = true
    -- L[] = true
    -- L[] = true
    -- L[] = true
end
