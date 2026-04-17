local _, ns = ...

local L = ns.L

local Maxb = ns.Maxb

local pt = print

BG.Boss = {}

function BG.FormatBossName(name)
    local n, c
    if ns.enUS then
        n, c = name:gsub(" ", "\n")
    elseif name:find("\n") then
        return name
    else
        local newstr = ""
        for i = 1, string.utf8len(name) do
            newstr = newstr .. (i == 1 and "" or "\n") .. string.utf8sub(name, i, i)
        end
        n = newstr
    end
    return n, c
end

local function AddDB(FB, boss)
    if not BG.Boss[FB] then BG.Boss[FB] = {} end
    for b = 1, #boss do
        local name = boss[b].name
        BG.Boss[FB]["boss" .. b] = BG.Boss[FB]["boss" .. b] or {}
        BG.Boss[FB]["boss" .. b].name2 = name:gsub("\n", "")
        BG.Boss[FB]["boss" .. b].color = boss[b].color
        BG.Boss[FB]["boss" .. b].name, BG.Boss[FB]["boss" .. b].nCount = BG.FormatBossName(name)
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
        { name = L["奥妮克希亚"], color = "CC6600" },
        { name = L["艾索雷葛斯"], color = "0099FF" },
        { name = L["卡扎克"], color = "cc9999" },
        { name = L["桑德兰王子"], color = "87CEFA" },
        { name = L["莱索恩"], color = c },
        { name = L["艾莫莉丝"], color = c },
        { name = L["泰拉尔"], color = c },
        { name = L["伊森德雷"], color = c },
    }
    Addother(boss)
    AddDB("Worldsod", boss)

    local boss = {
        { name = L["拉佐格尔"], color = "DA70D6" },
        { name = L["瓦拉斯塔兹"], color = "DA70D6" },
        { name = L["勒什雷尔"], color = "D2B48C" },
        { name = L["费尔默"], color = "D2B48C" },
        { name = L["双龙"], color = "FFFF00" },
        { name = L["克洛玛古斯"], color = "9370DB" },
        { name = L["奈法利安"], color = "D2691E" },
    }
    Addother(boss)
    AddDB("BWLsod", boss)

    local boss = {
        { name = L["耶克里克"], color = "98FB98" },
        { name = L["温诺希斯"], color = "98FB98" },
        { name = L["玛尔里"], color = "EE82EE" },
        { name = L["血领主曼多基尔"], color = "EE82EE" },
        { name = L["疯狂之缘"], color = "00BFFF" },
        { name = L["加兹兰卡"], color = "00BFFF" },
        { name = L["塞卡尔"], color = "00FF00" },
        { name = L["娅尔罗"], color = "00FF00" },
        { name = L["妖术师金度"], color = "FFFF00" },
        { name = L["哈卡"], color = "FF4500" },
    }
    Addother(boss)
    AddDB("ZUGsod", boss)

    local boss = {
        { name = L["鲁西弗隆"], color = "90EE90" },
        { name = L["玛格曼达"], color = "90EE90" },
        { name = L["基赫纳斯"], color = "CC9966" },
        { name = L["加尔"], color = "CC9966" },
        { name = L["沙斯拉尔"], color = "99FFFF" },
        { name = L["迦顿男爵"], color = "99FFFF" },
        { name = L["萨弗隆先驱者"], color = "FFFF00" },
        { name = L["古雷曼格"], color = "FFFF00" },
        { name = L["埃克索图斯"], color = "FF6699" },
        { name = L["拉格纳罗斯"], color = "FF6699" },
        { name = L["熔火之心"], color = "FF6699" },
    }
    Addother(boss)
    AddDB("MCsod", boss)

    local boss = {
        { name = L["阿塔拉利恩"], color = "D2B48C" },
        { name = L["腐溃烂泥"], color = "90EE90" },
        { name = L["阿塔莱防御者"], color = "9932CC" },
        { name = L["德姆塞卡尔"], color = BG.g2 },
        { name = L["迦玛兰和奥戈姆"], color = "FF69B4" },
        { name = L["哈扎斯"], color = BG.g2 },
        { name = L["伊兰尼库斯"], color = "7B68EE" },
        { name = L["哈卡的化身"], color = "FF4400" },
    }
    Addother(boss)
    AddDB("Temple", boss)

    local boss = {
        { name = L["格鲁比斯"], color = "CB7F00" },
        { name = L["粘性辐射尘"], color = "90EE90" },
        { name = L["群体打击者"], color = "FF6168" },
        { name = L["电刑器6000型"], color = "9C98FF" },
        { name = L["机械动物园"], color = "A5A5A5" },
        { name = L["瑟玛普拉格"], color = "00BFFF" },
    }
    Addother(boss)
    AddDB("Gno", boss)

    local boss = {
        { name = L["阿奎尼斯男爵"], color = "90EE90" },
        { name = L["加摩拉"], color = "C0C0C0" },
        { name = L["萨利维丝"], color = "FF69B4" },
        { name = L["格里哈斯特"], color = "7B68EE" },
        { name = L["洛古斯・杰特"], color = "FFFF00" },
        { name = L["梦游者克尔里斯"], color = "9932CC" },
        { name = L["阿库麦尔"], color = "00BFFF" },
    }
    Addother(boss)
    AddDB("BD", boss)
end

-- 60
do
    local boss = {
        { name = L["鲁西弗隆"], color = "90EE90" },
        { name = L["玛格曼达"], color = "90EE90" },
        { name = L["基赫纳斯"], color = "CC9966" },
        { name = L["加尔"], color = "CC9966" },
        { name = L["沙斯拉尔"], color = "99FFFF" },
        { name = L["迦顿男爵"], color = "99FFFF" },
        { name = L["萨弗隆先驱者"], color = "FFFF00" },
        { name = L["古雷曼格"], color = "FFFF00" },
        { name = L["埃克索图斯"], color = "FF6699" },
        { name = L["拉格纳罗斯"], color = "FF6699" },
        { name = L["奥妮克希亚"], color = "CC6600" },
    }
    Addother(boss)
    AddDB("MC", boss)

    local boss = {
        { name = L["狂野的拉佐格尔"], color = "DA70D6" },
        { name = L["堕落的瓦拉斯塔兹"], color = "DA70D6" },
        { name = L["勒什雷尔"], color = "D2B48C" },
        { name = L["费尔默"], color = "D2B48C" },
        { name = L["埃博诺克"], color = "FFFF00" },
        { name = L["弗莱格尔"], color = "FFFF00" },
        { name = L["克洛玛古斯"], color = "9370DB" },
        { name = L["奈法利安"], color = "D2691E" },
    }
    Addother(boss)
    AddDB("BWL", boss)

    local boss = {
        { name = L["耶克里克"], color = "98FB98" },
        { name = L["温诺希斯"], color = "98FB98" },
        { name = L["玛尔里"], color = "EE82EE" },
        { name = L["血领主曼多基尔"], color = "EE82EE" },
        { name = L["疯狂之缘"], color = "00BFFF" },
        { name = L["加兹兰卡"], color = "00BFFF" },
        { name = L["塞卡尔"], color = "00FF00" },
        { name = L["娅尔罗"], color = "00FF00" },
        { name = L["妖术师金度"], color = "FFFF00" },
        { name = L["哈卡"], color = "FF4500" },
    }
    Addother(boss)
    AddDB("ZUG", boss)

    local boss = {
        { name = L["库林纳克斯"], color = "CC9966" },
        { name = L["拉贾克斯将军"], color = "CC9966" },
        { name = L["莫阿姆"], color = "CC9966" },
        { name = L["吞咽者布鲁"], color = "BA55D3" },
        { name = L["狩猎者阿亚米斯"], color = "BA55D3" },
        { name = L["无疤者奥斯里安"], color = "00BFFF" },
    }
    Addother(boss)
    AddDB("AQL", boss)

    local boss = {
        { name = L["预言者斯克拉姆"], color = "FFB6C1" },
        { name = L["安其拉三宝"], color = "FFB6C1" },
        { name = L["沙尔图拉"], color = "FF8C00" },
        { name = L["顽强的范克瑞斯"], color = "FF8C00" },
        { name = L["维希度斯"], color = "90EE90" },
        { name = L["哈霍兰公主"], color = "90EE90" },
        { name = L["双子皇帝"], color = "BA55D3" },
        { name = L["奥罗"], color = "BA55D3" },
        { name = L["克苏恩"], color = "C0C0C0" },
    }
    Addother(boss)
    AddDB("TAQ", boss)

    if BG.IsVanilla then
        local boss = {
            { name = L["阿努布雷坎"], color = "7B68EE", },
            { name = L["法琳娜"], color = "7B68EE", },
            { name = L["迈克斯纳"], color = "7B68EE", },
            { name = L["诺斯"], color = "9932CC", },
            { name = L["希尔盖"], color = "9932CC", },
            { name = L["洛欧塞布"], color = "9932CC", },
            { name = L["教官"], color = "FF69B4", },
            { name = L["戈提克"], color = "FF69B4", },
            { name = L["天启四骑士"], color = "FF69B4", },
            { name = L["帕奇维克"], color = "FFD100", },
            { name = L["格罗布鲁斯"], color = "FFD100", },
            { name = L["格拉斯"], color = "FFD100", },
            { name = L["塔迪乌斯"], color = "FFD100", },
            { name = L["萨菲隆"], color = "90EE90", },
            { name = L["克尔苏加德"], color = "90EE90", },
        }
        Addother(boss)
        AddDB("NAXX", boss)
    end
end

-- TBC
do
    local boss = {
        { name = L["猎手阿图门"], color = "32CD32" },
        { name = L["莫罗斯"], color = "87CEFA" },
        { name = L["贞节圣女"], color = "FFFF00" },
        { name = L["歌剧院"], color = "9932CC" },
        { name = L["馆长"], color = "00BFFF" },
        { name = L["邪蹄"], color = "CC6600" },
        { name = L["埃兰之影"], color = "FF7F50" },
        { name = L["虚空幽龙"], color = "D3D3D3" },
        { name = L["国际象棋"], color = "7B68EE" },
        { name = L["玛克扎尔王子"], color = "FF3300" },
        { name = L["夜之魇"], color = "FF3300" },
    }
    local FB = "KZ"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["莫加尔大王"], color = "CC6600" },
        { name = L["屠龙者格鲁尔"], color = "CC6600" },
        { name = L["玛瑟里顿"], color = "32CD32" },
    }
    local FB = "GL"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["海度斯"], color = "32CD32" },
        { name = L["鱼斯拉"], color = "87CEFA" },
        { name = L["盲眼者"], color = "D3D3D3" },
        { name = L["深水领主"], color = "9932CC" },
        { name = L["踏潮者"], color = "CC6600" },
        { name = L["瓦丝琪"], color = "00BFFF" },
        { name = L["奥"], color = "FF7F50" },
        { name = L["空灵机甲"], color = "FFFF00" },
        { name = L["大星术师"], color = "7B68EE" },
        { name = L["凯尔萨斯"], color = "FF3300" },
    }
    local FB = "SSC"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["雷基・冬寒"], color = "87CEFA" },
        { name = L["安纳塞隆"], color = "CD5C5C" },
        { name = L["卡兹洛加"], color = "FFD700" },
        { name = L["阿兹加洛"], color = "CC6600" },
        { name = L["阿克蒙德"], color = "FF3300" },
    }
    local FB = "HS"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["纳因图斯"], color = "32CD32" },
        { name = L["苏普雷姆斯"], color = "87CEFA" },
        { name = L["阿卡玛之影"], color = "7B68EE" },
        { name = L["塔隆・血魔"], color = "FF3300" },
        { name = L["古尔图格・血沸"], color = "FF3300" },
        { name = L["灵魂之匣"], color = "87CEFA" },
        { name = L["莎赫拉丝主母"], color = "9932CC" },
        { name = L["伊利达雷议会"], color = "9932CC" },
        { name = L["伊利丹・怒风"], color = "00BFFF" },
    }
    local FB = "BT"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["卡雷苟斯"], color = "87CEFA" },
        { name = L["布鲁塔卢斯"], color = "CC6600" },
        { name = L["菲米丝"], color = "D3D3D3" },
        { name = L["艾瑞达双子"], color = "FF69B4" },
        { name = L["穆鲁"], color = "7B68EE" },
        { name = L["基尔加丹"], color = "FF3300" },
    }
    local FB = "SW"
    Addother(boss)
    AddDB(FB, boss)
end

-- WLK
do
    local boss = {
        { name = L["玛洛加尔"], color = "D3D3D3" },
        { name = L["亡语者女士"], color = "D3D3D3" },
        { name = L["炮舰战"], color = "FFD700" },
        { name = L["萨鲁法尔"], color = "FFD700" },
        { name = L["烂肠"], color = "FF7F50" },
        { name = L["腐面"], color = "FF7F50" },
        { name = L["普崔塞德教授"], color = "FF7F50" },
        { name = L["鲜血议会"], color = "FF69B4" },
        { name = L["鲜血女王"], color = "FF69B4" },
        { name = L["踏梦者"], color = "90EE90" },
        { name = L["辛达苟萨"], color = "90EE90" },
        { name = L["巫妖王"], color = "00BFFF" },
        { name = L["海里昂"], color = "993300" },
    }
    local FB = "ICC"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["诺森德猛兽"], color = "32CD32" },
        { name = L["加拉克苏斯"], color = "CD5C5C" },
        { name = L["阵营冠军"], color = "FFD700" },
        { name = L["瓦格里双子"], color = "7B68EE" },
        { name = L["阿努巴拉克"], color = "00BFFF" },
        { name = L["嘉奖宝箱"], color = "FFFF00" },
        { name = L["奥妮克希亚"], color = "CC6600" },
    }
    local FB = "TOC"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["烈焰巨兽"], color = "90EE90", },
        { name = L["锋鳞"], color = "90EE90", },
        { name = L["掌炉者"], color = "90EE90", },
        { name = L["拆解者"], color = "90EE90", },
        { name = L["钢铁议会"], color = "7B68EE", },
        { name = L["科隆加恩"], color = "7B68EE", },
        { name = L["欧尔利亚"], color = "7B68EE", },
        { name = L["霍迪尔"], color = "FFD100", },
        { name = L["托里姆"], color = "FFD100", },
        { name = L["弗蕾亚"], color = "FFD100", },
        { name = L["米米尔隆"], color = "FFD100", },
        { name = L["维扎克斯将军"], color = "9932CC", },
        { name = L["尤格萨隆"], color = "9932CC", },
        { name = L["奥尔加隆"], color = "00BFFF", },
    }
    local FB = "ULD"
    Addother(boss)
    AddDB(FB, boss)

    if not BG.IsVanilla then
        local boss = {
            { name = L["阿努布雷坎"], color = "7B68EE", },
            { name = L["黑女巫法琳娜"], color = "7B68EE", },
            { name = L["迈克斯纳"], color = "7B68EE", },
            { name = L["帕奇维克"], color = "FFD100", },
            { name = L["格罗布鲁斯"], color = "FFD100", },
            { name = L["格拉斯"], color = "FFD100", },
            { name = L["塔迪乌斯"], color = "FFD100", },
            { name = L["教官"], color = "FF69B4", },
            { name = L["收割者戈提克"], color = "FF69B4", },
            { name = L["天启四骑士"], color = "FF69B4", },
            { name = L["瘟疫使者诺斯"], color = "9932CC", },
            { name = L["肮脏的希尔盖"], color = "9932CC", },
            { name = L["洛欧塞布"], color = "9932CC", },
            { name = L["萨菲隆"], color = "90EE90", },
            { name = L["克尔苏加德"], color = "90EE90", },
            { name = L["萨塔里奥"], color = "CC6600", },
            { name = L["玛里苟斯"], color = "87CEFA", },
        }
        local FB = "NAXX"
        Addother(boss)
        AddDB(FB, boss)
    end
end

-- Titan
do
    local c = "339900"
    local boss = {
        { name = L["艾索雷葛斯"], color = "0099FF" },
        { name = L["卡扎克"], color = "0099FF" },
        { name = L["末日行者"], color = "cc9999" },
        { name = L["末日领主卡扎克"], color = "cc9999" },
        { name = L["莱索恩"], color = c },
        { name = L["艾莫莉丝"], color = c },
        { name = L["泰拉尔"], color = c },
        { name = L["伊森德雷"], color = c },
    }
    Addother(boss)
    AddDB("Worldtitan", boss)

    local boss = {
        { name = L["鲁西弗隆"], color = "90EE90" },
        { name = L["玛格曼达"], color = "90EE90" },
        { name = L["基赫纳斯"], color = "CC9966" },
        { name = L["加尔"], color = "CC9966" },
        { name = L["沙斯拉尔"], color = "99FFFF" },
        { name = L["迦顿男爵"], color = "99FFFF" },
        { name = L["萨弗隆先驱者"], color = "FFFF00" },
        { name = L["古雷曼格"], color = "FFFF00" },
        { name = L["埃克索图斯"], color = "FF6699" },
        { name = L["拉格纳罗斯"], color = "FF6699" },
    }
    Addother(boss)
    AddDB("MCtitan", boss)

    local boss = {
        { name = L["海度斯"], color = "32CD32" },
        { name = L["鱼斯拉"], color = "87CEFA" },
        { name = L["盲眼者"], color = "D3D3D3" },
        { name = L["深水领主"], color = "9932CC" },
        { name = L["踏潮者"], color = "CC6600" },
        { name = L["瓦丝琪"], color = "00BFFF" },
        { name = L["奥"], color = "FF7F50" },
        { name = L["空灵机甲"], color = "FFFF00" },
        { name = L["大星术师"], color = "7B68EE" },
        { name = L["凯尔萨斯"], color = "FF3300" },
    }
    local FB = "SSCtitan"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["阿努布雷坎"], color = "7B68EE", },
        { name = L["法琳娜"], color = "7B68EE", },
        { name = L["迈克斯纳"], color = "7B68EE", },
        { name = L["帕奇维克"], color = "FFD100", },
        { name = L["格罗布鲁斯"], color = "FFD100", },
        { name = L["格拉斯"], color = "FFD100", },
        { name = L["塔迪乌斯"], color = "FFD100", },
        { name = L["教官"], color = "FF69B4", },
        { name = L["戈提克"], color = "FF69B4", },
        { name = L["天启四骑士"], color = "FF69B4", },
        { name = L["诺斯"], color = "9932CC", },
        { name = L["希尔盖"], color = "9932CC", },
        { name = L["洛欧塞布"], color = "9932CC", },
        { name = L["萨菲隆"], color = "90EE90", },
        { name = L["克尔苏加德"], color = "90EE90", },
        { name = L["萨塔里奥"], color = "CC6600", },
        { name = L["玛里苟斯"], color = "87CEFA", },
    }
    local FB = "NAXXtitan"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["耶克里克"], color = "98FB98" },
        { name = L["温诺希斯"], color = "98FB98" },
        { name = L["玛尔里"], color = "EE82EE" },
        { name = L["血领主"], color = "EE82EE" },
        { name = L["疯狂之缘"], color = "00BFFF" },
        { name = L["加兹兰卡"], color = "00BFFF" },
        { name = L["塞卡尔"], color = "00FF00" },
        { name = L["娅尔罗"], color = "00FF00" },
        { name = L["妖术师金度"], color = "FFFF00" },
        { name = L["哈卡"], color = "FF4500" },
        { name = L["诺森德猛兽"], color = "32CD32" },
        { name = L["加拉克苏斯"], color = "CD5C5C" },
        { name = L["阵营冠军"], color = "FFD700" },
        { name = L["瓦格里双子"], color = "7B68EE" },
        { name = L["阿努巴拉克"], color = "00BFFF" },
    }
    Addother(boss)
    AddDB("TOCtitan", boss)
end

-- CTM
do
    local boss = {
        { name = L["哈尔弗斯・碎龙者"], color = "DEB887" },
        { name = L["瓦里昂娜和瑟纳利昂"], color = "FF69B4" },
        { name = L["升腾者议会"], color = "7B68EE" },
        { name = L["古加尔"], color = "FFD700" },
        { name = L["希奈丝特拉"], color = "FFFF00" },
        { name = L["全能金刚防御系统"], color = "D3D3D3" },
        { name = L["熔喉"], color = "FF7F50" },
        { name = L["艾卓曼德斯"], color = "DEB887" },
        { name = L["奇美隆"], color = "87CEFA" },
        { name = L["马洛拉克"], color = "FF4500" },
        { name = L["奈法利安的末日"], color = "FF1493" },
        { name = L["风之议会"], color = "87CEFA" },
        { name = L["奥拉基尔"], color = "FFFF00" },
    }
    local FB = "BOT"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["贝丝缇拉克"], color = "DEB887" },
        { name = L["雷奥利斯领主"], color = "FF7220" },
        { name = L["奥利瑟拉佐尔"], color = "FF7220" },
        { name = L["沙恩诺克斯"], color = "FFC400" },
        { name = L["贝尔洛克"], color = "FFC400" },
        { name = L["管理者鹿盔"], color = "FF4500" },
        { name = L["拉格纳罗斯"], color = "FF1493" },
    }
    local FB = "FL"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["莫卓克"], color = "7B68EE" },
        { name = L["督军佐诺兹"], color = "FF4500" },
        { name = L["不眠的约萨希"], color = "FF4500" },
        { name = L["缚风者哈格拉"], color = "FF69B4" },
        { name = L["奥卓克希昂"], color = "318AFF" },
        { name = L["战争大师黑角"], color = "318AFF" },
        { name = L["死亡之翼的背脊"], color = "D3D3D3" },
        { name = L["疯狂的死亡之翼"], color = "FF1493" },
    }
    local FB = "DS"
    Addother(boss)
    AddDB(FB, boss)
end

-- MOP
do
    local boss = {
        { name = L["石头守卫"], color = "DEB887" },
        { name = L["受诅者魔封"], color = "DEB887" },
        { name = L["缚灵者戈拉亚"], color = "DEB887" },
        { name = L["先王之魂"], color = "DEB887" },
        { name = L["伊拉贡"], color = "DEB887" },
        { name = L["皇帝的意志"], color = "DEB887" },
        { name = L["皇家宰相"], color = "FFFF00" },
        { name = L["刀锋领主"], color = "FFFF00" },
        { name = L["加拉隆"], color = "FFFF00" },
        { name = L["风领主"], color = "FFFF00" },
        { name = L["琥珀塑形者"], color = "FFFF00" },
        { name = L["大女皇夏柯希尔"], color = "FFFF00" },
        { name = L["无尽守护者"], color = "4FFC56" },
        { name = L["烛龙"], color = "4FFC56" },
        { name = L["雷施"], color = "4FFC56" },
        { name = L["惧之煞"], color = "4FFC56" },
    }
    local FB = "MSV"
    Addother(boss)
    AddDB(FB, boss)

    local boss = {
        { name = L["击碎者金罗克"], color = "99ccff" },
        { name = L["赫利东"], color = "99ccff" },
        { name = L["长者议会"], color = "99ccff" },
        { name = L["托多斯"], color = "ff9999" },
        { name = L["墨格瑞拉"], color = "ff9999" },
        { name = L["季鹍"], color = "ff9999" },
        { name = L["遗忘者杜鲁姆"], color = "cc6600" },
        { name = L["普利莫修斯"], color = "cc6600" },
        { name = L["黑暗意志"], color = "cc6600" },
        { name = L["铁穹"], color = "339933" },
        { name = L["神女双天"], color = "339933" },
        { name = L["雷神"], color = "00BFFF" },
        { name = L["莱登"], color = "DEB887" },
    }
    local FB = "TOT"
    Addother(boss)
    AddDB(FB, boss)
end

-- Retail
do
    local boss = {
        { name = L["噬灭者"], color = "A12987" },
        { name = L["血缚恐魔"], color = "A12987" },
        { name = L["苏雷吉队长"], color = "FFFF00" },
        { name = L["拉夏南"], color = "AAAAAA" },
        { name = L["虫巢扭曲者"], color = "AAAAAA" },
        { name = L["节点女亲王"], color = "853CC9" },
        { name = L["流丝之庭"], color = "853CC9" },
        { name = L["安苏雷克女王"], color = "00BFFF" },
    }
    Addother(boss)
    AddDB("NP", boss)
end
