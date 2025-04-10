local _, ns = ...

local L = ns.L

local Maxb = ns.Maxb

local pt = print

BG.Boss = {}

local function AddDB(FB, boss)
    if not BG.Boss[FB] then BG.Boss[FB] = {} end
    for b = 1, #boss do
        if not BG.Boss[FB]["boss" .. b] then BG.Boss[FB]["boss" .. b] = {} end
        BG.Boss[FB]["boss" .. b].name = boss[b].name
        BG.Boss[FB]["boss" .. b].name2 = string.gsub(string.gsub(boss[b].name, "-\n", ""), "\n", "")
        BG.Boss[FB]["boss" .. b].color = boss[b].color
    end
end
local function Addother(boss)
    tinsert(boss, { name = L["杂\n\n项"], color = "ffffff" })
    tinsert(boss, { name = L["罚\n\n款"], color = "ffffff" })
    tinsert(boss, { name = L["支\n\n出"], color = "00FF00" })
    tinsert(boss, { name = L["总\n览"], color = "EE82EE" })
end

-- Sod
do
    local c = "339900"
    local boss = {
        { name = L["奥\n妮\n克\n希\n亚"], color = "CC6600" },
        { name = L["艾\n索\n雷\n葛\n斯"], color = "0099FF" },
        { name = L["卡\n扎\n克"], color = "cc9999" },
        { name = L["桑\n德\n兰\n王\n子"], color = "87CEFA" },
        { name = L["莱\n索\n恩"], color = c },
        { name = L["艾\n莫\n莉\n丝"], color = c },
        { name = L["泰\n拉\n尔"], color = c },
        { name = L["伊\n森\n德\n雷"], color = c },
    }
    Addother(boss)
    AddDB("Worldsod", boss)

    local boss = {
        { name = L["拉\n佐\n格\n尔"], color = "DA70D6" },
        { name = L["瓦\n拉\n斯\n塔\n兹"], color = "DA70D6" },
        { name = L["勒\n什\n雷\n尔"], color = "D2B48C" },
        { name = L["费\n尔\n默"], color = "D2B48C" },
        { name = L["双\n龙"], color = "FFFF00" },
        { name = L["克\n洛\n玛\n古\n斯"], color = "9370DB" },
        { name = L["奈\n法\n利\n安"], color = "D2691E" },
    }
    Addother(boss)
    AddDB("BWLsod", boss)

    local boss = {
        { name = L["耶\n克\n里\n克"], color = "98FB98" },
        { name = L["温\n诺\n希\n斯"], color = "98FB98" },
        { name = L["玛\n尔\n里"], color = "EE82EE" },
        { name = L["血\n领\n主\n曼\n多\n基\n尔"], color = "EE82EE" },
        { name = L["疯\n狂\n之\n缘"], color = "00BFFF" },
        { name = L["加\n兹\n兰\n卡"], color = "00BFFF" },
        { name = L["塞\n卡\n尔"], color = "00FF00" },
        { name = L["娅\n尔\n罗"], color = "00FF00" },
        { name = L["妖\n术\n师\n金\n度"], color = "FFFF00" },
        { name = L["哈\n卡"], color = "FF4500" },
    }
    Addother(boss)
    AddDB("ZUGsod", boss)

    local boss = {
        { name = L["鲁\n西\n弗\n隆"], color = "90EE90" },
        { name = L["玛\n格\n曼\n达"], color = "90EE90" },
        { name = L["基\n赫\n纳\n斯"], color = "CC9966" },
        { name = L["加\n尔"], color = "CC9966" },
        { name = L["沙\n斯\n拉\n尔"], color = "99FFFF" },
        { name = L["迦\n顿\n男\n爵"], color = "99FFFF" },
        { name = L["萨\n弗\n隆\n先\n驱\n者"], color = "FFFF00" },
        { name = L["古\n雷\n曼\n格"], color = "FFFF00" },
        { name = L["埃\n克\n索\n图\n斯"], color = "FF6699" },
        { name = L["拉\n格\n纳\n罗\n斯"], color = "FF6699" },
        { name = L["熔\n火\n之\n心"], color = "FF6699" },
    }
    Addother(boss)
    AddDB("MCsod", boss)

    local boss = {
        { name = L["阿\n塔\n拉\n利\n恩"], color = "D2B48C" },
        { name = L["腐\n溃\n烂\n泥"], color = "90EE90" },
        { name = L["阿\n塔\n莱\n防\n御\n者"], color = "9932CC" },
        { name = L["德\n姆\n塞\n卡\n尔"], color = BG.g2 },
        { name = L["迦\n玛\n兰\n和\n奥\n戈\n姆"], color = "FF69B4" },
        { name = L["哈\n扎\n斯"], color = BG.g2 },
        { name = L["伊\n兰\n尼\n库\n斯"], color = "7B68EE" },
        { name = L["哈\n卡\n的\n化\n身"], color = "FF4400" },
    }
    Addother(boss)
    AddDB("Temple", boss)

    local boss = {
        { name = L["格\n鲁\n比\n斯"], color = "CB7F00" },
        { name = L["粘\n性\n辐\n射\n尘"], color = "90EE90" },
        { name = L["群\n体\n打\n击\n者"], color = "FF6168" },
        { name = L["电\n刑\n器\n6\n0\n0\n0\n型"], color = "9C98FF" },
        { name = L["机\n械\n动\n物\n园"], color = "A5A5A5" },
        { name = L["瑟\n玛\n普\n拉\n格"], color = "00BFFF" },
    }
    Addother(boss)
    AddDB("Gno", boss)

    local boss = {
        { name = L["阿\n奎\n尼\n斯\n男\n爵"], color = "90EE90" },
        { name = L["加\n摩\n拉"], color = "C0C0C0" },
        { name = L["萨\n利\n维\n丝"], color = "FF69B4" },
        { name = L["格\n里\n哈\n斯\n特"], color = "7B68EE" },
        { name = L["洛\n古\n斯\n・\n杰\n特"], color = "FFFF00" },
        { name = L["梦\n游\n者\n克\n尔\n里\n斯"], color = "9932CC" },
        { name = L["阿\n库\n麦\n尔"], color = "00BFFF" },
    }
    Addother(boss)
    AddDB("BD", boss)
end

-- 60
do
    local boss = {
        { name = L["鲁\n西\n弗\n隆"], color = "90EE90" },
        { name = L["玛\n格\n曼\n达"], color = "90EE90" },
        { name = L["基\n赫\n纳\n斯"], color = "CC9966" },
        { name = L["加\n尔"], color = "CC9966" },
        { name = L["沙\n斯\n拉\n尔"], color = "99FFFF" },
        { name = L["迦\n顿\n男\n爵"], color = "99FFFF" },
        { name = L["萨\n弗\n隆\n先\n驱\n者"], color = "FFFF00" },
        { name = L["古\n雷\n曼\n格"], color = "FFFF00" },
        { name = L["埃\n克\n索\n图\n斯"], color = "FF6699" },
        { name = L["拉\n格\n纳\n罗\n斯"], color = "FF6699" },
        { name = L["奥\n妮\n克\n希\n亚"], color = "CC6600" },
    }
    Addother(boss)
    AddDB("MC", boss)

    local boss = {
        { name = L["狂\n野\n的\n拉\n佐\n格\n尔"], color = "DA70D6" },
        { name = L["堕\n落\n的\n瓦\n拉\n斯\n塔\n兹"], color = "DA70D6" },
        { name = L["勒\n什\n雷\n尔"], color = "D2B48C" },
        { name = L["费\n尔\n默"], color = "D2B48C" },
        { name = L["埃\n博\n诺\n克"], color = "FFFF00" },
        { name = L["弗\n莱\n格\n尔"], color = "FFFF00" },
        { name = L["克\n洛\n玛\n古\n斯"], color = "9370DB" },
        { name = L["奈\n法\n利\n安"], color = "D2691E" },
    }
    Addother(boss)
    AddDB("BWL", boss)

    local boss = {
        { name = L["耶\n克\n里\n克"], color = "98FB98" },
        { name = L["温\n诺\n希\n斯"], color = "98FB98" },
        { name = L["玛\n尔\n里"], color = "EE82EE" },
        { name = L["血\n领\n主\n曼\n多\n基\n尔"], color = "EE82EE" },
        { name = L["疯\n狂\n之\n缘"], color = "00BFFF" },
        { name = L["加\n兹\n兰\n卡"], color = "00BFFF" },
        { name = L["塞\n卡\n尔"], color = "00FF00" },
        { name = L["娅\n尔\n罗"], color = "00FF00" },
        { name = L["妖\n术\n师\n金\n度"], color = "FFFF00" },
        { name = L["哈\n卡"], color = "FF4500" },
    }
    Addother(boss)
    AddDB("ZUG", boss)

    local boss = {
        { name = L["库\n林\n纳\n克\n斯"], color = "CC9966" },
        { name = L["拉\n贾\n克\n斯\n将\n军"], color = "CC9966" },
        { name = L["莫\n阿\n姆"], color = "CC9966" },
        { name = L["吞\n咽\n者\n布\n鲁"], color = "BA55D3" },
        { name = L["狩\n猎\n者\n阿\n亚\n米\n斯"], color = "BA55D3" },
        { name = L["无\n疤\n者\n奥\n斯\n里\n安"], color = "00BFFF" },
    }
    Addother(boss)
    AddDB("AQL", boss)

    local boss = {
        { name = L["预\n言\n者\n斯\n克\n拉\n姆"], color = "FFB6C1" },
        { name = L["安\n其\n拉\n三\n宝"], color = "FFB6C1" },
        { name = L["沙\n尔\n图\n拉"], color = "FF8C00" },
        { name = L["顽\n强\n的\n范\n克\n瑞\n斯"], color = "FF8C00" },
        { name = L["维\n希\n度\n斯"], color = "90EE90" },
        { name = L["哈\n霍\n兰\n公\n主"], color = "90EE90" },
        { name = L["双\n子\n皇\n帝"], color = "BA55D3" },
        { name = L["奥\n罗"], color = "BA55D3" },
        { name = L["克\n苏\n恩"], color = "C0C0C0" },
    }
    Addother(boss)
    AddDB("TAQ", boss)

    if BG.IsVanilla then
        local boss = {
            { name = L["阿\n努\n布\n雷\n坎"], color = "7B68EE", },
            { name = L["黑\n女\n巫\n法\n琳\n娜"], color = "7B68EE", },
            { name = L["迈\n克\n斯\n纳"], color = "7B68EE", },
            { name = L["瘟\n疫\n使\n者\n诺\n斯"], color = "9932CC", },
            { name = L["肮\n脏\n的\n希\n尔\n盖"], color = "9932CC", },
            { name = L["洛\n欧\n塞\n布"], color = "9932CC", },
            { name = L["教\n官"], color = "FF69B4", },
            { name = L["收\n割\n者\n戈\n提\n克"], color = "FF69B4", },
            { name = L["天\n启\n四\n骑\n士"], color = "FF69B4", },
            { name = L["帕\n奇\n维\n克"], color = "FFD100", },
            { name = L["格\n罗\n布\n鲁\n斯"], color = "FFD100", },
            { name = L["格\n拉\n斯"], color = "FFD100", },
            { name = L["塔\n迪\n乌\n斯"], color = "FFD100", },
            { name = L["萨\n菲\n隆"], color = "90EE90", },
            { name = L["克\n尔\n苏\n加\n德"], color = "90EE90", },
        }
        Addother(boss)
        AddDB("NAXX", boss)
    end
end

-- TBC
do
    local boss = {
        { name = L["卡\n雷\n苟\n斯"], color = "87CEFA" },
        { name = L["布\n鲁\n塔\n卢\n斯"], color = "CC6600" },
        { name = L["菲\n米\n丝"], color = "D3D3D3" },
        { name = L["艾\n瑞\n达\n双\n子"], color = "FF69B4" },
        { name = L["穆\n鲁"], color = "7B68EE" },
        { name = L["基\n尔\n加\n丹"], color = "FF3300" },
    }
    local FB = "SW"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["纳\n因\n图\n斯"], color = "32CD32" },
        { name = L["苏\n普\n雷\n姆\n斯"], color = "87CEFA" },
        { name = L["阿\n卡\n玛\n之\n影"], color = "7B68EE" },
        { name = L["塔\n隆\n・\n血\n魔"], color = "FF3300" },
        { name = L["古\n尔\n图\n格\n・\n血\n沸"], color = "FF3300" },
        { name = L["灵\n魂\n之\n匣\n"], color = "87CEFA" },
        { name = L["莎\n赫\n拉\n丝\n主\n母"], color = "9932CC" },
        { name = L["伊\n利\n达\n雷\n议\n会"], color = "9932CC" },
        { name = L["伊\n利\n丹\n・\n怒\n风"], color = "00BFFF" },
    }
    local FB = "BT"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["雷\n基\n・\n冬\n寒"], color = "87CEFA" },
        { name = L["安\n纳\n塞\n隆"], color = "CD5C5C" },
        { name = L["卡\n兹\n洛\n加"], color = "FFD700" },
        { name = L["阿\n兹\n加\n洛"], color = "CC6600" },
        { name = L["阿\n克\n蒙\n德"], color = "FF3300" },
    }
    local FB = "HS"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["海\n度\n斯"], color = "32CD32" },
        { name = L["鱼\n斯\n拉"], color = "87CEFA" },
        { name = L["盲\n眼\n者"], color = "D3D3D3" },
        { name = L["深\n水\n领\n主"], color = "9932CC" },
        { name = L["踏\n潮\n者"], color = "CC6600" },
        { name = L["瓦\n丝\n琪"], color = "00BFFF" },
        { name = L["奥"], color = "FF7F50" },
        { name = L["空\n灵\n机\n甲"], color = "FFFF00" },
        { name = L["大\n星\n术\n师"], color = "7B68EE" },
        { name = L["凯\n尔\n萨\n斯"], color = "FF3300" },
    }
    local FB = "SSC"
    Addother(boss)
    AddDB(FB, boss)
end

-- WLK
do
    local boss = {
        { name = L["玛\n洛\n加\n尔"], color = "D3D3D3" },
        { name = L["亡\n语\n者\n女\n士"], color = "D3D3D3" },
        { name = L["炮\n舰\n战"], color = "FFD700" },
        { name = L["萨\n鲁\n法\n尔"], color = "FFD700" },
        { name = L["烂\n肠"], color = "FF7F50" },
        { name = L["腐\n面"], color = "FF7F50" },
        { name = L["普\n崔\n塞\n德\n教\n授"], color = "FF7F50" },
        { name = L["鲜\n血\n议\n会"], color = "FF69B4" },
        { name = L["鲜\n血\n女\n王"], color = "FF69B4" },
        { name = L["踏\n梦\n者"], color = "90EE90" },
        { name = L["辛\n达\n苟\n萨"], color = "90EE90" },
        { name = L["巫\n妖\n王"], color = "00BFFF" },
        { name = L["海\n里\n昂"], color = "993300" },
    }
    local FB = "ICC"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["诺\n森\n德\n猛\n兽"], color = "32CD32" },
        { name = L["加\n拉\n克\n苏\n斯"], color = "CD5C5C" },
        { name = L["阵\n营\n冠\n军"], color = "FFD700" },
        { name = L["瓦\n克\n里\n双\n子"], color = "7B68EE" },
        { name = L["阿\n努\n巴\n拉\n克"], color = "00BFFF" },
        { name = L["嘉\n奖\n宝\n箱"], color = "FFFF00" },
        { name = L["奥\n妮\n克\n希\n亚"], color = "CC6600" },
    }
    local FB = "TOC"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["烈\n焰\n巨\n兽"], color = "90EE90", },
        { name = L["锋\n鳞"], color = "90EE90", },
        { name = L["掌\n炉\n者"], color = "90EE90", },
        { name = L["拆\n解\n者"], color = "90EE90", },
        { name = L["钢\n铁\n议\n会"], color = "7B68EE", },
        { name = L["科\n隆\n加\n恩"], color = "7B68EE", },
        { name = L["欧\n尔\n利\n亚"], color = "7B68EE", },
        { name = L["霍\n迪\n尔"], color = "FFD100", },
        { name = L["托\n里\n姆"], color = "FFD100", },
        { name = L["弗\n蕾\n亚"], color = "FFD100", },
        { name = L["米\n米\n尔\n隆"], color = "FFD100", },
        { name = L["维\n扎\n克\n斯\n将\n军"], color = "9932CC", },
        { name = L["尤\n格\n萨\n隆"], color = "9932CC", },
        { name = L["奥\n尔\n加\n隆"], color = "00BFFF", },
    }
    local FB = "ULD"
    Addother(boss)
    AddDB(FB, boss)

    if not BG.IsVanilla then
        local boss = {
            { name = L["阿\n努\n布\n雷\n坎"], color = "7B68EE", },
            { name = L["黑\n女\n巫\n法\n琳\n娜"], color = "7B68EE", },
            { name = L["迈\n克\n斯\n纳"], color = "7B68EE", },
            { name = L["帕\n奇\n维\n克"], color = "FFD100", },
            { name = L["格\n罗\n布\n鲁\n斯"], color = "FFD100", },
            { name = L["格\n拉\n斯"], color = "FFD100", },
            { name = L["塔\n迪\n乌\n斯"], color = "FFD100", },
            { name = L["教\n官"], color = "FF69B4", },
            { name = L["收\n割\n者\n戈\n提\n克"], color = "FF69B4", },
            { name = L["天\n启\n四\n骑\n士"], color = "FF69B4", },
            { name = L["瘟\n疫\n使\n者\n诺\n斯"], color = "9932CC", },
            { name = L["肮\n脏\n的\n希\n尔\n盖"], color = "9932CC", },
            { name = L["洛\n欧\n塞\n布"], color = "9932CC", },
            { name = L["萨\n菲\n隆"], color = "90EE90", },
            { name = L["克\n尔\n苏\n加\n德"], color = "90EE90", },
            { name = L["萨\n塔\n里\n奥"], color = "CC6600", },
            { name = L["玛\n里\n苟\n斯"], color = "87CEFA", },
        }
        local FB = "NAXX"
        Addother(boss)
        AddDB(FB, boss)
    end
end

-- CTM
do
    local boss = {
        { name = L["哈\n尔\n弗\n斯\n・\n碎\n龙\n者"], color = "DEB887" },
        { name = L["瓦\n里\n昂\n娜\n和\n瑟\n纳\n利\n昂"], color = "FF69B4" },
        { name = L["升\n腾\n者\n议\n会"], color = "7B68EE" },
        { name = L["古\n加\n尔"], color = "FFD700" },
        { name = L["希\n奈\n丝\n特\n拉"], color = "FFFF00" },
        { name = L["全\n能\n金\n刚\n防\n御\n系\n统"], color = "D3D3D3" },
        { name = L["熔\n喉"], color = "FF7F50" },
        { name = L["艾\n卓\n曼\n德\n斯"], color = "DEB887" },
        { name = L["奇\n美\n隆"], color = "87CEFA" },
        { name = L["马\n洛\n拉\n克"], color = "FF4500" },
        { name = L["奈\n法\n利\n安\n的\n末\n日"], color = "FF1493" },
        { name = L["风\n之\n议\n会"], color = "87CEFA" },
        { name = L["奥\n拉\n基\n尔"], color = "FFFF00" },
    }
    local FB = "BOT"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["贝\n丝\n缇\n拉\n克"], color = "DEB887" },
        { name = L["雷\n奥\n利\n斯\n领\n主"], color = "FF7220" },
        { name = L["奥\n利\n瑟\n拉\n佐\n尔"], color = "FF7220" },
        { name = L["沙\n恩\n诺\n克\n斯"], color = "FFC400" },
        { name = L["贝\n尔\n洛\n克"], color = "FFC400" },
        { name = L["管\n理\n者\n鹿\n盔"], color = "FF4500" },
        { name = L["拉\n格\n纳\n罗\n斯"], color = "FF1493" },
    }
    local FB = "FL"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["莫\n卓\n克"], color = "7B68EE" },
        { name = L["督\n军\n佐\n诺\n兹"], color = "FF4500" },
        { name = L["不\n眠\n的\n约\n萨\n希"], color = "FF4500" },
        { name = L["缚\n风\n者\n哈\n格\n拉"], color = "FF69B4" },
        { name = L["奥\n卓\n克\n希\n昂"], color = "318AFF" },
        { name = L["战\n争\n大\n师\n黑\n角"], color = "318AFF" },
        { name = L["死\n亡\n之\n翼\n的\n背\n脊"], color = "D3D3D3" },
        { name = L["疯\n狂\n的\n死\n亡\n之\n翼"], color = "FF1493" },
    }
    local FB = "DS"
    Addother(boss)
    AddDB(FB, boss)
end

-- Retail
do
    local boss = {
        { name = L["噬\n灭\n者"], color = "A12987" },
        { name = L["血\n缚\n恐\n魔"], color = "A12987" },
        { name = L["苏\n雷\n吉\n队\n长"], color = "FFFF00" },
        { name = L["拉\n夏\n南"], color = "AAAAAA" },
        { name = L["虫\n巢\n扭\n曲\n者"], color = "AAAAAA" },
        { name = L["节\n点\n女\n亲\n王"], color = "853CC9" },
        { name = L["流\n丝\n之\n庭"], color = "853CC9" },
        { name = L["安\n苏\n雷\n克\n女\n王"], color = "00BFFF" },
    }
    Addother(boss)
    AddDB("NP", boss)
end


--[[ local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
    local FB = "Temple"
    local boss = 8

    local function RGB_16(r, g, b)
        local r = string.format("%X", tonumber(r) * 255)
        if r and strlen(r) == 1 then
            r = "0" .. r
        end
        local g = string.format("%X", tonumber(g) * 255)
        if g and strlen(g) == 1 then
            g = "0" .. g
        end
        local b = string.format("%X", tonumber(b) * 255)
        if b and strlen(b) == 1 then
            b = "0" .. b
        end
        local c = r .. g .. b
        return c
    end
    local edit = CreateFrame("EditBox", nil, ColorPickerFrame, "InputBoxTemplate")
    do
        edit:SetSize(80, 20)
        edit:SetPoint("BOTTOM", 62, 40)
        edit:SetAutoFocus(false)
    end

    local function ShowColorPicker(r, g, b, a, changedCallback)
        ColorPickerFrame.hasOpacity = (a ~= nil)
        ColorPickerFrame.opacity = a
        ColorPickerFrame.previousValues = { r, g, b, a }
        ColorPickerFrame.func = changedCallback
        ColorPickerFrame.opacityFunc = changedCallback
        ColorPickerFrame.cancelFunc = changedCallback
        ColorPickerFrame:SetColorRGB(r, g, b)
        ColorPickerFrame:Hide()
        ColorPickerFrame:Show()
        ColorPickerFrame:ClearAllPoints()
        ColorPickerFrame:SetPoint("RIGHT", BG.MainFrame, "RIGHT", 0, 0)
        edit:SetText(RGB_16(r, g, b))
        edit:HighlightText()
        BG.After(0.1, function()
            edit:SetFocus()
        end)
    end
    local r, g, b, a = 1, 1, 1, 1
    local function myColorCallback(restore)
        local newR, newG, newB, newA;
        if restore then
            newR, newG, newB, newA = unpack(restore);
        else
            newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
        end
        r, g, b, a = newR, newG, newB, newA;
        BG.Frame[FB]["boss" .. boss]["name"]:SetTextColor(r, g, b, a)
        edit:SetText(RGB_16(r, g, b))
        edit:HighlightText()
        print(r, g, b)
    end

    BG.MainFrame:HookScript("OnShow", function(self)
        ShowColorPicker(r, g, b, a, myColorCallback)
    end)
end) ]]
