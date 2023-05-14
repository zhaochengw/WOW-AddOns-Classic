local _, ADDONSELF = ...

local pt = print

local function Size(t)
    local s = 0;
    for k, v in pairs(t) do
        if v ~= nil then s = s + 1 end
    end
    return s;
end

local function RGB(hex)
    local red = string.sub(hex, 1, 2)
    local green = string.sub(hex, 3, 4)
    local blue = string.sub(hex, 5, 6)
 
    red = tonumber(red, 16)/255
    green = tonumber(green, 16)/255
    blue = tonumber(blue, 16)/255
    return red, green, blue
end


local FB = {"NAXX","ULD","TOC","ICC"}

    -- 全局变量
    BG = {}
    
do
    BG.FB1 = "ULD"

    BG.NAXXname = "纳克萨玛斯"
    BG.ULDname = "奥杜尔"
    BG.TOCname = "十字军的试炼"
    BG.ICCname = "冰冠堡垒"
    
        -- 表格
    do
        -- 表格UI
        BG.Frame = {}    
        for index, value in ipairs(FB) do
            BG.Frame[value] = {}
            for b=1,22 do
                BG.Frame[value]["boss"..b] = {}
            end
        end

        -- 底色
        BG.FrameDs = {}    
        for index, value in ipairs(FB) do
            for i = 1, 3, 1 do
                BG.FrameDs[value..i] = {}
                for b=1,22 do
                    BG.FrameDs[value..i]["boss"..b] = {}
                end
            end        
        end

        -- 心愿UI
        BG.HopeFrame = {}    
        for index, value in ipairs(FB) do
            BG.HopeFrame[value] = {}
            for n=1,4 do
                BG.HopeFrame[value]["nandu"..n] = {}
                for b=1,22 do
                    BG.HopeFrame[value]["nandu"..n]["boss"..b] = {}
                end
            end
        end

        -- 心愿底色
        BG.HopeFrameDs = {}
        for index, value in ipairs(FB) do
            for t = 1, 3, 1 do
                BG.HopeFrameDs[value..t] = {}
                for n=1,4 do
                    BG.HopeFrameDs[value..t]["nandu"..n] = {}
                    for b=1,22 do
                        BG.HopeFrameDs[value..t]["nandu"..n]["boss"..b] = {}
                    end
                end
            end        
        end

        -- 历史UI
        BG.HistoryFrame = {}    
        for index, value in ipairs(FB) do
            BG.HistoryFrame[value] = {}
            for b=1,22 do
                BG.HistoryFrame[value]["boss"..b] = {}
            end
        end

        -- 历史底色
        BG.HistoryFrameDs = {}
        for index, value in ipairs(FB) do
            for i = 1, 3, 1 do
                BG.HistoryFrameDs[value..i] = {}
                for b=1,22 do
                    BG.HistoryFrameDs[value..i]["boss"..b] = {}
                end
            end        
        end

        -- 接收UI
        BG.ReceiveFrame = {}    
        for index, value in ipairs(FB) do
            BG.ReceiveFrame[value] = {}
            for b=1,22 do
                BG.ReceiveFrame[value]["boss"..b] = {}
            end
        end

        -- 接收底色
        BG.ReceiveFrameDs = {}
        for index, value in ipairs(FB) do
            for i = 1, 3, 1 do
                BG.ReceiveFrameDs[value..i] = {}
                for b=1,22 do
                    BG.ReceiveFrameDs[value..i]["boss"..b] = {}
                end
            end        
        end
    end

        -- 字体
    do
        BG.FontBlue1 = CreateFont("BG.FontBlue1")
        BG.FontBlue1:SetTextColor(RGB("00BFFF"))
        BG.FontBlue1:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")

        BG.FontBlue1Left = CreateFont("BG.FontBlue1Left")
        BG.FontBlue1Left:SetTextColor(RGB("00BFFF"))
        BG.FontBlue1Left:SetJustifyH("LEFT")
        BG.FontBlue1Left:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")

        BG.FontGold1 = CreateFont("BG.FontGold1")
        BG.FontGold1:SetTextColor(RGB("FFD100"))
        BG.FontGold1:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")

        local Green1 = "Green1" -- BG.FontGreen1
        BG["Font"..Green1] = CreateFont("BG.Font"..Green1)
        BG["Font"..Green1]:SetTextColor(RGB("00FF00"))
        BG["Font"..Green1]:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")

        BG.FontRed1 = CreateFont("BG.FontRed1")
        BG.FontRed1:SetTextColor(RGB("FF0000"))
        BG.FontRed1:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")

        BG.FontRed2 = CreateFont("BG.FontRed2")
        BG.FontRed2:SetTextColor(RGB("DC143C"))
        BG.FontRed2:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")

        BG.FontFen1 = CreateFont("BG.FontFen1")
        BG.FontFen1:SetTextColor(RGB("FF69B4"))
        BG.FontFen1:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")

        BG.FontHilight = CreateFont("BG.FontHilight")
        BG.FontHilight:SetTextColor(RGB("FFFFFF"))
        BG.FontHilight:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")

        BG.FontHilightLeft = CreateFont("BG.FontHilightLeft")
        BG.FontHilightLeft:SetTextColor(RGB("FFFFFF"))
        BG.FontHilightLeft:SetJustifyH("LEFT")
        BG.FontHilightLeft:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")

        BG.FontDisabled = CreateFont("BG.FontDisabled")
        BG.FontDisabled:SetTextColor(RGB("808080"))
        BG.FontDisabled:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")
    end

        -- 声音
    do
        BG.sound1 = SOUNDKIT.GS_TITLE_OPTION_OK
        BG.sound2 = 569593
        BG.sound_paimai = "Interface\\AddOns\\BiaoGe\\Media\\sound\\paimai.mp3"
        BG.sound_hope = "Interface\\AddOns\\BiaoGe\\Media\\sound\\hope.mp3"
    end

        -- 隐藏装备
    do
        BG.Icon = {
            ["DEATHKNIGHT".."1"] = "Interface/Icons/spell_deathknight_bloodpresence",   -- 血脸T
            ["DEATHKNIGHT".."2"] = "Interface/Icons/inv_sword_122", -- 杀戮机器DPS

            ["WARRIOR".."1"] = "Interface/Icons/ability_warrior_defensivestance",   -- 防御姿势T
            ["WARRIOR".."2"] = "Interface/Icons/INV_Sword_48",  -- 斩杀DPS

            ["PALADIN".."1"] = "Interface/Icons/spell_holy_holybolt",   -- 圣光N
            ["PALADIN".."2"] = "Interface/Icons/spell_holy_devotionaura",   -- 虔诚T
            ["PALADIN".."3"] = "Interface/Icons/spell_holy_auraoflight",    -- 惩戒DPS

            ["HUNTER".."1"] = "Interface/Icons/classicon_hunter",   -- LR

            ["SHAMAN".."1"] = "Interface/Icons/spell_nature_lightning",     -- 闪电箭FXDPS
            ["SHAMAN".."2"] = "Interface/Icons/spell_nature_lightningshield",       -- 闪电之盾DPS
            ["SHAMAN".."3"] = "Interface/Icons/spell_nature_magicimmunity",     -- 治疗波N

            ["DRUID".."1"] = "Interface/Icons/spell_nature_starfall",       -- 月火FXDPS
            ["DRUID".."2"] = "Interface/Icons/ability_racial_bearform",       -- 熊T
            ["DRUID".."3"] = "Interface/Icons/ability_druid_catform",       -- 猎豹形态DPS
            ["DRUID".."4"] = "Interface/Icons/spell_nature_healingtouch",       -- 治疗之触N

            ["ROGUE".."1"] = "Interface/Icons/classicon_rogue",     -- DZ

            ["WARLOCK".."1"] = "Interface/Icons/classicon_warlock",     -- SS

            ["MAGE".."1"] = "Interface/Icons/classicon_mage",     -- FS

            ["PRIEST".."1"] = "Interface/Icons/spell_holy_wordfortitude",     -- 真言术：韧N
            ["PRIEST".."2"] = "Interface/Icons/spell_shadow_shadowwordpain",     -- 暗言术：痛AM
        }

        local t1 = {"法术强度","法力","布甲","皮甲","锁甲"} -- FZ,FQ
        local t2 = {"法术强度","法力","格挡等级","布甲","皮甲","锁甲"} -- DKT
        local t3 = {"法术强度","法力","格挡等级","招架","布甲"}   -- 熊T
        local wl1 = {"法术强度","法力","防御","格挡等级","躲闪","招架","布甲"}  -- 物理DPS
        local wl2 = {"防御","格挡","躲闪","招架"}   -- ZQS
        local wl3 = {"力量","精准","法术强度","法力","防御","格挡等级","躲闪","招架","布甲"}  -- LR
        local fx1 = {"力量","敏捷","攻击强度","护甲穿透","精准","防御","格挡等级","躲闪","招架"}    -- 法系DPS
        local n1 = {"力量","敏捷","攻击强度","护甲穿透","精准","防御","格挡等级","躲闪","招架","命中"}  -- 奶
        
        BG.DisClassTextLeft = {
            ["DEATHKNIGHT".."1"] = t2,  --血DK
            ["DEATHKNIGHT".."2"] = wl1,     --DPS

            ["WARRIOR".."1"] = t1,      --FZ
            ["WARRIOR".."2"] = wl1,     --DPS

            ["PALADIN".."1"] = n1,     --NQ
            ["PALADIN".."2"] = t1,      --FQ
            ["PALADIN".."3"] = wl1,     --CJQ
        
            ["HUNTER".."1"] = wl3,      --LR

            ["SHAMAN".."1"] = fx1,      --元素
            ["SHAMAN".."2"] = wl2,      --ZQS
            ["SHAMAN".."3"] = n1,      --NS
        
            ["DRUID".."1"] = fx1,      --咕咕
            ["DRUID".."2"] = t3,      --熊T
            ["DRUID".."3"] = wl1,      --猫D
            ["DRUID".."4"] = n1,      --ND

            ["ROGUE".."1"] = wl1,      --DZ

            ["WARLOCK".."1"] = fx1,      --SS

            ["MAGE".."1"] = fx1,      --FS

            ["PRIEST".."1"] = n1,      --MS
            ["PRIEST".."2"] = fx1,      --AM
        }

        BG.DisClassTextRight = {
            ["DEATHKNIGHT"] = {"拳套","弓","魔杖","弩","枪械","匕首","法杖","盾牌","图腾","圣契","神像","投掷武器"}, --DK
            ["WARRIOR"] = {"魔杖","圣物"}, --ZS
            ["PALADIN"] = {"拳套","弓","魔杖","弩","枪械","匕首","法杖","魔印","图腾","神像","投掷武器"}, --QS
            ["HUNTER"] = {"主手锤","单手锤","魔杖","双手锤","板甲","圣物","盾牌"}, --LR
            ["SHAMAN"] = {"主手剑","单手剑","弓","魔杖","弩","枪械","长柄武器","双手剑","板甲","魔印","圣契","神像","投掷武器"},    --SM
            ["DRUID"] = {"主手斧","单手斧","弓","魔杖","弩","枪械","双手剑","双手斧","板甲","锁甲","盾牌","魔印","图腾","圣契","投掷武器"}, --XD
            ["ROGUE"] = {"魔杖","长柄武器","双手剑","双手斧","双手锤","法杖","板甲","锁甲","圣物","盾牌"},   --DZ
            ["WARLOCK"] = {"主手斧","单手斧","主手锤","单手锤","拳套","弓","弩","枪械","长柄武器","双手剑","双手斧","双手锤","板甲","锁甲","皮甲","圣物","盾牌","投掷武器"},  --SS
            ["MAGE"] = {"主手斧","单手斧","主手锤","单手锤","拳套","弓","弩","枪械","长柄武器","双手剑","双手斧","双手锤","板甲","锁甲","皮甲","圣物","盾牌","投掷武器"}, --FS
            ["PRIEST"] = {"主手剑","单手剑","主手斧","单手斧","拳套","弓","弩","枪械","长柄武器","双手剑","双手斧","双手锤","板甲","锁甲","皮甲","圣物","盾牌","投掷武器"}    --MS
        }

            -- 物理：KBZ,WQZ,BDK,XDK,CJQ,LR,ZQS,DZ,YD       屏蔽：法强
            -- 法系：NQ,YS,GG,ND,FS,SS,MS       屏蔽：力量、敏捷、攻强、防等、躲闪、招架、精准、
            -- 坦克：FZ,FQ,DK,XT        屏蔽：法强

    end
end



    -- 数据库（保存至本地）
local function DataBase()

    ------------------BiaoGe账号数据------------------
    do
        if BiaoGe then
            if type(BiaoGe)~="table" then
                BiaoGe = {}
            end
        else
            BiaoGe = {}
        end
        if not BiaoGe.AutoLoot then
            BiaoGe.AutoLoot = 1
        end
        if not BiaoGe.AutoTrade then
            BiaoGe.AutoTrade = 1
        end
        if not BiaoGe.AutoJine0 then
            BiaoGe.AutoJine0 = 1
        end
        if not BiaoGe.Scale then
            BiaoGe.Scale = 1
        end
        if not BiaoGe.point then
            BiaoGe.point = {}
        end
        for index, value in ipairs(FB) do
            if not BiaoGe[value] then
                BiaoGe[value] = {}
            end
            for b=1,22 do
                if not BiaoGe[value]["boss"..b] then
                    BiaoGe[value]["boss"..b] = {}
                end
            end
        end


        if not BiaoGe.HistoryList then
            BiaoGe.HistoryList = {}
        end
        for index, value in ipairs(FB) do
            if not BiaoGe.HistoryList[value] then
                BiaoGe.HistoryList[value] = {}
            end
        end

        if not BiaoGe.History then
            BiaoGe.History = {}
        end
        for index, value in ipairs(FB) do
            if not BiaoGe.History[value] then
                BiaoGe.History[value] = {}
            end
        end
    end

    ------------------BiaoGeA单角色数据------------------
    do
        if BiaoGeA then
            if type(BiaoGeA)~="table" then
                BiaoGeA = {}
            end
        else
            BiaoGeA = {}
        end
        if BiaoGeA.Hope then
            if type(BiaoGeA.Hope)~="table" then
                BiaoGeA.Hope = {}
            end
        else
            BiaoGeA.Hope = {}
        end
        for index, value in ipairs(FB) do
            if not BiaoGeA.Hope[value] then
                BiaoGeA.Hope[value] = {}
            end
            
            for n=1,4 do
                if not BiaoGeA.Hope[value]["nandu"..n] then
                    BiaoGeA.Hope[value]["nandu"..n] = {}
                    for b=1,22 do
                        if not BiaoGeA.Hope[value]["nandu"..n]["boss"..b] then
                            BiaoGeA.Hope[value]["nandu"..n]["boss"..b] = {}
                        end
                    end
                end
            end
        end
    end

    -- Boss名字
    do        
        BiaoGe.ICC.boss1.bossname = "\n|cff".."D3D3D3".."玛\n洛\n加\n尔\n领\n主|r"
        BiaoGe.ICC.boss2.bossname = "\n|cff".."D3D3D3".."亡\n语\n者\n女\n士|r"
        BiaoGe.ICC.boss3.bossname = "\n|cff".."FFD700".."冰\n冠\n炮\n舰\n战\n斗|r"
        BiaoGe.ICC.boss4.bossname = "\n|cff".."FFD700".."萨\n鲁\n法\n尔|r"
        BiaoGe.ICC.boss5.bossname = "\n|cff".."FF7F50".."烂\n肠|r"
        BiaoGe.ICC.boss6.bossname = "\n|cff".."FF7F50".."腐\n面|r"
        BiaoGe.ICC.boss7.bossname = "\n|cff".."FF7F50".."普\n崔\n塞\n德\n教\n授|r"
        BiaoGe.ICC.boss8.bossname = "\n|cff".."FF69B4".."鲜\n血\n议\n会|r"
        BiaoGe.ICC.boss9.bossname = "\n|cff".."FF69B4".."鲜\n血\n女\n王|r"
        BiaoGe.ICC.boss10.bossname = "\n|cff".."90EE90".."踏\n梦\n者|r"
        BiaoGe.ICC.boss11.bossname = "\n|cff".."90EE90".."辛\n达\n苟\n萨|r"
        BiaoGe.ICC.boss12.bossname = "\n|cff".."00BFFF".."巫\n妖\n王|r"
        BiaoGe.ICC.boss13.bossname = "\n|cff".."993300".."海\n里\n昂|r"
        BiaoGe.ICC.boss14.bossname = "\n|cff".."ffffff".."杂\n\n项|r"
        BiaoGe.ICC.boss15.bossname = "\n|cff".."ffffff".."罚\n\n款|r"        
        BiaoGe.ICC.boss16.bossname = "\n|cff00FF00支\n\n出|r"
        BiaoGe.ICC.boss17.bossname = "\n|cffEE82EE总\n览|r"
        BiaoGe.ICC.boss18.bossname = nil

        BiaoGe.ICC.boss1.bossname2 = "玛洛加尔领主"
        BiaoGe.ICC.boss2.bossname2 = "亡语者女士"
        BiaoGe.ICC.boss3.bossname2 = "冰冠炮舰战斗"
        BiaoGe.ICC.boss4.bossname2 = "萨鲁法尔"
        BiaoGe.ICC.boss5.bossname2 = "烂肠"
        BiaoGe.ICC.boss6.bossname2 = "腐面"
        BiaoGe.ICC.boss7.bossname2 = "普崔塞德教授"
        BiaoGe.ICC.boss8.bossname2 = "鲜血议会"
        BiaoGe.ICC.boss9.bossname2 = "鲜血女王"
        BiaoGe.ICC.boss10.bossname2 = "踏梦者"
        BiaoGe.ICC.boss11.bossname2 = "辛达苟萨"
        BiaoGe.ICC.boss12.bossname2 = "巫妖王"
        BiaoGe.ICC.boss13.bossname2 = "海里昂"
        BiaoGe.ICC.boss14.bossname2 = "杂项"
        BiaoGe.ICC.boss15.bossname2 = "罚款"
        BiaoGe.ICC.boss16.bossname2 = "支出"
        BiaoGe.ICC.boss17.bossname2 = "总览工资"
        BiaoGe.ICC.boss18.bossname2 = nil

        BiaoGe.TOC.boss1.bossname = "|cff".."32CD32".."\n诺\n森\n德\n猛\n兽|r"
        BiaoGe.TOC.boss2.bossname = "|cff".."CD5C5C".."\n加\n拉\n克\n苏\n斯|r"
        BiaoGe.TOC.boss3.bossname = "|cff".."FFD700".."\n阵\n营\n冠\n军|r"
        BiaoGe.TOC.boss4.bossname = "|cff".."7B68EE".."\n瓦\n克\n里\n双\n子|r"
        BiaoGe.TOC.boss5.bossname = "|cff".."00BFFF".."\n阿\n奴\n巴\n拉\n克|r"
        BiaoGe.TOC.boss6.bossname = "|cff".."FFFF00".."\n嘉\n奖\n宝\n箱|r"
        BiaoGe.TOC.boss7.bossname = "|cff".."CC6600".."\n奥\n妮\n克\n希\n亚|r"
        BiaoGe.TOC.boss8.bossname = "\n|cffffffff杂\n\n项|r"
        BiaoGe.TOC.boss9.bossname = "\n|cffffffff罚\n\n款|r"
        BiaoGe.TOC.boss10.bossname = "\n|cff00FF00支\n\n出|r"
        BiaoGe.TOC.boss11.bossname = "\n|cffEE82EE总\n览|r"
        BiaoGe.TOC.boss12.bossname = nil
        BiaoGe.TOC.boss13.bossname = nil
        BiaoGe.TOC.boss14.bossname = nil
        BiaoGe.TOC.boss15.bossname = nil
        BiaoGe.TOC.boss16.bossname = nil
        BiaoGe.TOC.boss17.bossname = nil
        BiaoGe.TOC.boss18.bossname = nil

        BiaoGe.TOC.boss1.bossname2 = "诺森德猛兽"
        BiaoGe.TOC.boss2.bossname2 = "加拉克苏斯"
        BiaoGe.TOC.boss3.bossname2 = "阵营冠军"
        BiaoGe.TOC.boss4.bossname2 = "瓦克里双子"
        BiaoGe.TOC.boss5.bossname2 = "阿奴巴拉克"
        BiaoGe.TOC.boss6.bossname2 = "嘉奖宝箱"
        BiaoGe.TOC.boss7.bossname2 = "奥妮克希亚"
        BiaoGe.TOC.boss8.bossname2 = "杂项"
        BiaoGe.TOC.boss9.bossname2 = "罚款"
        BiaoGe.TOC.boss10.bossname2 = "支出"
        BiaoGe.TOC.boss11.bossname2 = "总览工资"
        BiaoGe.TOC.boss12.bossname2 = nil
        BiaoGe.TOC.boss13.bossname2 = nil
        BiaoGe.TOC.boss14.bossname2 = nil
        BiaoGe.TOC.boss15.bossname2 = nil
        BiaoGe.TOC.boss16.bossname2 = nil
        BiaoGe.TOC.boss17.bossname2 = nil
        BiaoGe.TOC.boss18.bossname2 = nil

        BiaoGe.ULD.boss1.bossname = "|cff90EE90\n烈\n焰\n巨\n兽|r"
        BiaoGe.ULD.boss2.bossname = "|cff90EE90\n锋\n鳞|r"
        BiaoGe.ULD.boss3.bossname = "|cff90EE90\n掌\n炉\n者|r"
        BiaoGe.ULD.boss4.bossname = "|cff90EE90\n拆\n解\n者|r"
        BiaoGe.ULD.boss5.bossname = "|cff7B68EE\n钢\n铁\n议\n会|r"
        BiaoGe.ULD.boss6.bossname = "|cff7B68EE\n科\n隆\n加\n恩|r"
        BiaoGe.ULD.boss7.bossname = "|cff7B68EE\n欧\n尔\n利\n亚|r"
        BiaoGe.ULD.boss8.bossname = "|cffFFD100\n霍\n迪\n尔"
        BiaoGe.ULD.boss9.bossname = "|cffFFD100\n托\n里\n姆"
        BiaoGe.ULD.boss10.bossname = "|cffFFD100\n弗\n蕾\n亚"
        BiaoGe.ULD.boss11.bossname = "|cffFFD100\n米\n米\n尔\n隆"
        BiaoGe.ULD.boss12.bossname = "|cff9932CC\n维\n扎\n克\n斯\n将\n军|r"
        BiaoGe.ULD.boss13.bossname = "|cff9932CC\n尤\n格\n萨\n隆|r"
        BiaoGe.ULD.boss14.bossname = "|cff00BFFF\n奥\n尔\n加\n隆|r"
        BiaoGe.ULD.boss15.bossname = "\n|cffffffff杂\n\n项|r"
        BiaoGe.ULD.boss16.bossname = "\n|cffffffff罚\n\n款|r"
        BiaoGe.ULD.boss17.bossname = "\n|cff00FF00支\n\n出|r"
        BiaoGe.ULD.boss18.bossname = "\n|cffEE82EE总\n览|r"

        BiaoGe.ULD.boss1.bossname2 = "烈焰巨兽"
        BiaoGe.ULD.boss2.bossname2 = "锋鳞"
        BiaoGe.ULD.boss3.bossname2 = "掌炉者"
        BiaoGe.ULD.boss4.bossname2 = "拆解者"
        BiaoGe.ULD.boss5.bossname2 = "钢铁议会"
        BiaoGe.ULD.boss6.bossname2 = "科隆加恩"
        BiaoGe.ULD.boss7.bossname2 = "欧尔利亚"
        BiaoGe.ULD.boss8.bossname2 = "霍迪尔"
        BiaoGe.ULD.boss9.bossname2 = "托里姆"
        BiaoGe.ULD.boss10.bossname2 = "弗蕾亚"
        BiaoGe.ULD.boss11.bossname2 = "米米尔隆"
        BiaoGe.ULD.boss12.bossname2 = "维扎克斯将军"
        BiaoGe.ULD.boss13.bossname2 = "尤格萨隆"
        BiaoGe.ULD.boss14.bossname2 = "奥尔加隆"
        BiaoGe.ULD.boss15.bossname2 = "杂项"
        BiaoGe.ULD.boss16.bossname2 = "罚款"
        BiaoGe.ULD.boss17.bossname2 = "支出"
        BiaoGe.ULD.boss18.bossname2 = "总览工资"

        BiaoGe.NAXX.boss1.bossname = "\n|cff7B68EE阿\n努\n布\n雷\n坎"
        BiaoGe.NAXX.boss2.bossname = "\n|cff7B68EE黑\n女\n巫\n法\n琳\n娜"
        BiaoGe.NAXX.boss3.bossname = "\n|cff7B68EE迈\n克\n斯\n纳"
        BiaoGe.NAXX.boss4.bossname = "\n|cff9932CC瘟\n疫\n使\n者\n诺\n斯"
        BiaoGe.NAXX.boss5.bossname = "\n|cff9932CC肮\n脏\n的\n希\n尔\n盖"
        BiaoGe.NAXX.boss6.bossname = "\n|cff9932CC洛\n欧\n塞\n布"
        BiaoGe.NAXX.boss7.bossname = "\n|cffFF69B4教\n官"
        BiaoGe.NAXX.boss8.bossname = "\n|cffFF69B4收\n割\n者\n戈\n提\n克"
        BiaoGe.NAXX.boss9.bossname = "\n|cffFF69B4天\n启\n四\n骑\n士"
        BiaoGe.NAXX.boss10.bossname = "\n|cffFFD100帕\n奇\n维\n克"
        BiaoGe.NAXX.boss11.bossname = "\n|cffFFD100格\n罗\n布\n鲁\n斯"
        BiaoGe.NAXX.boss12.bossname = "\n|cffFFD100格\n拉\n斯"
        BiaoGe.NAXX.boss13.bossname = "\n|cffFFD100塔\n迪\n乌\n斯"
        BiaoGe.NAXX.boss14.bossname = "\n|cff90EE90萨\n菲\n隆"
        BiaoGe.NAXX.boss15.bossname = "\n|cff90EE90克\n尔\n苏\n加\n德"
        BiaoGe.NAXX.boss16.bossname = "\n|cff87CEFA萨\n塔\n里\n奥"
        BiaoGe.NAXX.boss17.bossname = "\n|cff87CEFA玛\n里\n苟\n斯"
        BiaoGe.NAXX.boss18.bossname = "\n|cffffffff杂\n\n项"
        BiaoGe.NAXX.boss19.bossname = "\n|cffffffff罚\n\n款"
        BiaoGe.NAXX.boss20.bossname = "\n|cff00FF00支\n\n出"
        BiaoGe.NAXX.boss21.bossname = "\n|cffEE82EE总\n览"

        BiaoGe.NAXX.boss1.bossname2 = "阿努布雷坎"
        BiaoGe.NAXX.boss2.bossname2 = "黑女巫法琳娜"
        BiaoGe.NAXX.boss3.bossname2 = "迈克斯纳"
        BiaoGe.NAXX.boss4.bossname2 = "瘟疫使者诺斯"
        BiaoGe.NAXX.boss5.bossname2 = "肮脏的希尔盖"
        BiaoGe.NAXX.boss6.bossname2 = "洛欧塞布"
        BiaoGe.NAXX.boss7.bossname2 = "教官"
        BiaoGe.NAXX.boss8.bossname2 = "收割者戈提克"
        BiaoGe.NAXX.boss9.bossname2 = "天启四骑士"
        BiaoGe.NAXX.boss10.bossname2 = "帕奇维克"
        BiaoGe.NAXX.boss11.bossname2 = "格罗布鲁斯"
        BiaoGe.NAXX.boss12.bossname2 = "格拉斯"
        BiaoGe.NAXX.boss13.bossname2 = "塔迪乌斯"
        BiaoGe.NAXX.boss14.bossname2 = "萨菲隆"
        BiaoGe.NAXX.boss15.bossname2 = "克尔苏加德"
        BiaoGe.NAXX.boss16.bossname2 = "萨塔里奥"
        BiaoGe.NAXX.boss17.bossname2 = "玛里苟斯"
        BiaoGe.NAXX.boss18.bossname2 = "杂项"
        BiaoGe.NAXX.boss19.bossname2 = "罚款"
        BiaoGe.NAXX.boss20.bossname2 = "支出"
        BiaoGe.NAXX.boss21.bossname2 = "总览"

    end
end

    -- 其他
do
    local Width = {}
    local Height = {}
    local Maxb = {}
    local Maxi = {}

    Width["BG.MainFrame"] = 1710
    Width["ICC"] = 1290
    Width["TOC"] = 1290
    Width["ULD"] = 1710
    Width["NAXX"] = 1710
    ADDONSELF.Width = Width

    Height["BG.MainFrame"] = 920
    Height["ICC"] = 920
    Height["TOC"] = 780
    Height["ULD"] = 920
    Height["NAXX"] = 920
    ADDONSELF.Height = Height

    Maxb["ICC"] = 15
    Maxb["TOC"] = 9
    Maxb["ULD"] = 16
    Maxb["NAXX"] = 19
    ADDONSELF.Maxb = Maxb

    Maxi["ICC"] = 10
    Maxi["TOC"] = 15
    Maxi["ULD"] = 14
    Maxi["NAXX"] = 11
    ADDONSELF.Maxi = Maxi

    local HopeMaxi = 2
    local HopeMaxb = {}
    local HopeMaxn = {}

    ADDONSELF.HopeMaxi = HopeMaxi

    HopeMaxb["ICC"] = 14
    HopeMaxb["TOC"] = 8
    HopeMaxb["ULD"] = 15
    HopeMaxb["NAXX"] = 18
    ADDONSELF.HopeMaxb = HopeMaxb

    HopeMaxn["ICC"] = 4
    HopeMaxn["TOC"] = 4
    HopeMaxn["ULD"] = 2
    HopeMaxn["NAXX"] = 2
    ADDONSELF.HopeMaxn = HopeMaxn
end

C_ChatInfo.RegisterAddonMessagePrefix("BiaoGe") -- 注册插件通信频道

CreateFrame("GameTooltip", "BiaoGeFilterTooltip", nil, "GameTooltipTemplate")   -- 用于收集提示工具文字
BiaoGeFilterTooltip:SetOwner( WorldFrame, "ANCHOR_NONE" )

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "BiaoGe" then
        DataBase()
    end
end)

GameTooltip:SetItemByID(45931)
GameTooltip:Show()
for i=1,GameTooltip:NumLines() do 
    print(_G["GameTooltipTextLeft"..i]:GetText())
end

