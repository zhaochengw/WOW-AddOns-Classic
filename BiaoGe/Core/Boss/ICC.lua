if BG.IsBlackListPlayer then return end
if not BG.IsWLK then return end

local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local Maxb = ns.Maxb
local BossNum = ns.BossNum
local AddTexture = ns.AddTexture

local pt = print


BG.Init(function()
    for i, FB in ipairs(BG.FBtable) do
        if FB ~= "ICC" then
            local t = BG["BossFrame" .. FB]:CreateFontString()
            t:SetPoint("TOP", BG.MainFrame, "TOP", 0, -70)
            t:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
            t:SetTextColor(1, 1, 1)
            t:SetText(L["该副本没有团本攻略。目前只有ICC有团本攻略"])
        end
    end

    BG.CreateBossNameUI(BG.BossFrameICC, "ICC")

    local bossnum = 1
    do
        local spell = {
            ["军刀猛刺"] = 69055,
            ["冷焰"] = 69146,
            ["天灾领主之刺"] = 69057,
            ["白骨风暴"] = 69075,
            ["穿刺"] = 72670,
        }

        -- NPC 1
        do
            local npcnum = 1
            local spellnum = 0

            -- 名字
            local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            local bossOnEnterText = L["团队配置建议：开荒初期建议3T5N17DPS\n该BOSS分2个阶段。P1常规战斗，持续50-60秒；施放白骨风暴时为P2，持续30秒。\n\n攻速：2.0\n伤害：原始伤害7.5万，实际伤害约1.5万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText)

            -- 技能
            local spellname = "冷焰"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["随机向一名远处的玩家发射一条逐渐蔓延的蓝色火焰，每堆火焰持续8秒，对触碰到火焰的玩家每1秒造成11000点冰霜伤害。优先选择远处的目标"]
            local SpellDoneText = L["躲开地上蓝色火焰"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "天灾领主之刺"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = format(L["随机点名3名非坦克玩家，对其造成9000点物理伤害。被点名玩家会被完全钉在骨针上（处于昏迷状态且无法使用无敌或冰箱），被骨针期间还将受到每2秒2500的%s物理伤害，直至打破骨针"]
            , GetSpellLink(spell["穿刺"]))
            local SpellDoneText = L["DPS马上转火骨针，治疗刷好被点名玩家，如果该玩家重叠吃到冷焰伤害，交团减，并加大治疗"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "军刀猛刺"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["对当前目标造成300%武器伤害的物理伤害，由目标及其附近的2个玩家分摊。被军刀猛刺击中的玩家不会被天灾领主之刺点名，CD1.5秒"]
            local SpellDoneText = L["确保坦克站一起分摊，三个坦克可以让军刀的伤害等于BOSS一次普通攻击。注意：防止军刀误伤近战，请坦克站在BOSS红圈外边缘"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)

            local spellname = "白骨风暴"
            spellnum = spellnum + 1
            local Pnum = "P2"
            local SpellInfoText = L["转入P2玛洛加尔领主开始3秒读条引导一阵旋风斩，会选择离BOSS最远的两个玩家，然后随机选定其中一个玩家位置定位，沿路发动旋风冲锋，选定目标位置后对所有靠近BOSS最近的玩家造成每2秒14000点物理伤害，玩家距离BOSS越远受到的伤害越低，当30码外伤害仅为10%，且伤害不受护甲减免。到达选定位置后会在其以正面为参照角度偏斜40°角成X四个方向喷射冷焰，5秒后，玛洛加尔领主会以相同机制重新锁定目标并发动冲锋，整个白骨风暴持续30秒结束。P2继承P1仇恨，但P2BOSS无视仇恨列表，白骨风暴结束后仇恨机制恢复"]
            local SpellDoneText = L["\n方法一：安排两两一组对角站位作为沙包，当选定一组方向时，这一组的沙发，上下移动躲开白骨风暴中心，当转移目标后，这一组沙包继续重合。这种方式比较符合机制本身的解决方案，但是容易出现大团伤害过高的情况发生。\n方法二：如本攻略的站位图安排，提前安排沙包到三点站位，让三点始终保持距离BOSS最远距离，引诱boss锁定位置；其他人中场活动移动，方便抬血、和输出BOSS。详细见展站位图，本人更建议此种战术"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)
        end

        -- 职责
        local text1 = L["P1阶段保持在BOSS模型红圈圈外边缘，并和其他坦克保持重合，时刻注意BOSS正面并背对人群；P2阶段在读白骨风暴时提前跑到沙包位，并做好位其他队员减伤任务。当P2结束，坦克应当嘲讽接怪，以并尽快将BOSS定位合理位置"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["P1治疗这这场战斗中要照顾好被天灾领主之刺点名玩家，安排一名奶骑站近战位是一个不错的选择；P2阶段应留意沙包坦的血量，保持自己与BOSS合适的距离，同时保护好自己"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["P1站BOSS红圈内输出，并躲好因意外触发的冷焰，以及时刻注意BOSS正面位置以免吃到军刀猛刺；骨针点名近战位第一时间转火；P2转阶段前提前跑位，躲好冷焰以及处理好骨针，并做好自保技能的准备；如果被BOSS追，离开其移动路径和方向。并确保自己位置在沙包和BOSS之间。当回到P1时由于P2清空仇恨，DPS注意先让坦克接怪"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["P1根据安排站位，躲好冷焰以及转火骨针，P2站位沙包坦和BOSS之间的区域，躲好冷焰、白骨风暴和转火好骨针，并做好自保技能的准备。如果被BOSS追，离开其移动方向和路径。并确保自己位置在沙包和BOSS之间。当回到P1时由于P2清空仇恨，DPS注意先让坦克先接怪"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end


    local bossnum = 2
    do
        local npcnum = 0
        local spell = {
            ["法力壁垒"] = 70842,
            ["暗影箭"] = 71254,
            ["统御心灵"] = 71289,
            ["死亡凋零"] = 71001,

            ["寒冰箭"] = 71420,
            ["寒冰箭雨"] = 72905,
            ["蔑视之触"] = 71204,
            ["召唤灵魂"] = 71426,
            ["复仇冲击"] = 71544,

            ["暗影顺劈"] = 70670,
            ["死疽打击"] = 70659,
            ["吸血鬼之力"] = 70674,
            ["黑暗殉道"] = 71236,
            ["黑暗突变"] = 70900,

            ["死寒之箭"] = 70594,
            ["麻痹诅咒"] = 71237,
            ["玄秘遮蔽"] = 70768,
            ["黑暗增效"] = 70901,
        }

        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            local bossOnEnterText = L["团队配置建议：开荒初期3T5N17DPS\nP1：BOSS处于法力壁垒，不会移动也不会普攻。P2：当法力壁垒消失，BOSS将转入P2，变的可移动；不可嘲讽\n\n攻速：2.0\n伤害：原始伤害8万左右，实际伤害约2万；BOSS会在对其他目标施放读条技能后连续对当前目标释放2-3次普通攻击"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText)

            -- 技能
            local spellname = "统御心灵"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["随机心控3名玩家，使其伤害提高200%，治疗效果提高500%，持续12秒。40秒一次"]
            local SpellDoneText = L["德鲁伊的吹风首选，可避免被误伤；法师变羊、萨满妖术、牧师和术士的恐惧等一切控制技能均可。无法自解"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "死亡凋零"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["随机选一名玩家，并对附近（8码？）的所有敌人每秒造成6000点暗影伤害，并使其移动速度降低，持续4秒。凋零持续10秒"]
            local SpellDoneText = L["躲开"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "法力壁垒"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["P1机制技能，消耗完BOSS的法力值，战斗将转入P2阶段；这里有一个公式：每消耗1点法力可以为她提供一个吸收2.5点伤害的护盾"]
            local SpellDoneText = L["术士的法力吸取，猎人的蝰蛇钉刺，牧师的法力燃烧可以加速消耗BOSS的蓝量，其他DPS合理平衡小怪处理和BOSS的输出即可"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "暗影箭"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["2秒读条，随机对一名玩家造成原始伤害约1.5万左右暗影伤害。频率最高的技能，可打断"]
            local SpellDoneText = L["能打断打断"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 7)

            local spellname = "寒冰箭"
            spellnum = spellnum + 1
            local Pnum = "P2"
            local SpellInfoText = L["2秒施法，随机对一名玩家造成原始伤害约4万左右冰霜伤害。可打断"]
            local SpellDoneText = L["安排打断链"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 7)

            local spellname = "寒冰箭雨"
            spellnum = spellnum + 1
            local Pnum = "P2"
            local SpellInfoText = L["每隔20秒会释放寒冰箭雨，对附近的所有玩家造成16500左右的冰霜伤害，并使其移动速度降低，持续4秒"]
            local SpellDoneText = L["无法躲避，治疗群体抬血"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "蔑视之触"
            spellnum = spellnum + 1
            local Pnum = "P2"
            local SpellInfoText = L["对当前目标产生的威胁值减少20%，可叠加5层到100%"]
            local SpellDoneText = L["其他DPS不要超过仇恨序列的1和2，BOSS坦保持自己仇恨序列一直处于1和2；注：刚转入P2主坦要借此大团处理小怪和占位阶段尽可能多的建立仇恨"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["教派狂热者"]
            local Pnum
            local bossOnEnterText = L["开战5秒，后面45秒一次；亡语者会召唤7个小怪（初始两种小怪教派狂热者和教派追随者）组成来加入战斗。左边刷新2个教派狂热者和1个教派追随者，右边会刷新2个教派追随者和1个教派狂热者，入口处台阶上会随机刷新1个教派狂热者或教派追随者\n\nPT难度：只在P1召唤小怪\nH难度：P2阶段，BOSS还会召唤小怪，只是变为一次刷新一边循环；第一次为大厅左边2个教派狂热者加1个教派追随者。45秒后右侧刷新2个教派追随者加1个教派狂热者，反复循环直至BOSS被成功击杀"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "暗影顺劈"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["对攻击者前方8码范围内的所有敌人造成19000到21000点暗影伤害"]
            local SpellDoneText = L["坦克把小怪背对人群"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)

            local spellname = "死疽打击"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["使用一把诅咒的武器打击当前目标，对其造成70%的武器伤害，并使其感染一种痘疫，该瘟疫会抵消目标随后获得的20000点治疗效果"]
            local SpellDoneText = L["无"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "吸血鬼之力"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["施法者体内充盈着黑暗之力，使其造成的所有伤害提高25%，并且所造成伤害的300%将治疗施法者。持续15秒。可偷取，可驱散"]
            local SpellDoneText = L["及时偷取或进攻驱散"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 8)

            local spellname = "黑暗殉道"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["亡语者会命令一名教派狂热者释放黑暗殉道，引爆自身的黑暗能量，对15码范围内的所有敌人造成25000点自然暗影伤害。随后，施法者将以被复活的姿态重生变成被复活的狂热者（受到的物理伤害降低99%）"]
            local SpellDoneText = L["法系职业转火被复活的狂热者"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 2)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "黑暗突变"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["变形为亡灵巨兽，体型明显增大，移动速度显著降低。造成的伤害提高100%）"]
            local SpellDoneText = L["安排一名远程DPS或坦克风筝"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["教派追逐者"]
            local Pnum
            local bossOnEnterText = L["开战5秒，后面45秒一次；亡语者会召唤7个小怪（初始两种小怪教派狂热者和教派追随者）组成来加入战斗。左边刷新2个教派狂热者和1个教派追随者，右边会刷新2个教派追随者和1个教派狂热者，入口处台阶上会随机刷新1个教派狂热者或教派追随者\n\nPT难度：只在P1召唤小怪\nH难度：P2阶段，BOSS还会召唤小怪，只是变为一次刷新一边循环；第一次为大厅左边2个教派狂热者加1个教派追随者。45秒后右侧刷新2个教派追随者加1个教派狂热者，反复循环直至BOSS被成功击杀"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "死寒之箭"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["2秒施法，对1个敌方目标造成11563到13437点暗影冰霜伤害"]
            local SpellDoneText = L["打断"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 7)

            local spellname = "麻痹诅咒"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["1秒施法，对1名随机玩家释放诅咒，使其所有技能的冷却时间增加15秒，持续15秒。可驱散"]
            local SpellDoneText = L["打断或第一时间驱散"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 7)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 8)

            local spellname = "玄秘遮蔽"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["使施法者笼置在一层强大的屏障之中，该屏障会反射所有对施法者进行的魔法攻击，并且使施法者免疫施法打断效果，该屏障最多能吸收50000点伤害"]
            local SpellDoneText = L["法系DPS停手，物理DPS全力输出"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 2)

            local spellname = "黑暗殉道"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["亡语者会命令一名教派追逐者释放黑暗殉道，引爆自身的黑暗能量，对15码范围内的所有敌人造成25000点自然暗影伤害。随后，施法者将以被复活的姿态重生变成被复活的追逐者（受到的法术伤害降低99%）"]
            local SpellDoneText = L["物理职业转火被复活的追逐者"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 2)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "黑暗增效"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["强化你的法术，使其造成范围伤害且不会被打断"]
            local SpellDoneText = L["被点名玩家远离人群，其他DPS速度击杀"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["怨毒之影"]
            local Pnum = "P2"
            local bossOnEnterText = L["亡语者女士发出召唤，在场地上的随机位置生成3只怨毒之影，持续7秒。它们无法被选中，生成后会缓慢追逐随机玩家"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "复仇冲击"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["引爆自身，对位于目标半径20码范围内的所有敌人造成23160到24840点暗影和冰霜伤害"]
            local SpellDoneText = L["视野拉到最高，提高专注力，不要被怪追到，否则炸团"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 5)
        end
        -- 职责
        local text1 = L["P1阶段坦克注意自己的职责任务，并躲避“畸形的狂热者”和正在释放“黑暗殉道”的小怪；做好其他坦克被心控后的小怪问题；P2建立好仇恨序列以及聚好小怪"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["尽可能的保持8码分散，P1阶段看好几个小怪坦克，团血注意被死亡凋零和小怪技能误伤的玩家；P2阶段注意BOSS非读条施法的状态下坦克吃到的普攻三连。应当监控boss的读条。驱散各类敌对BUFF和友方debuff"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["P1优先处理追随者，并AOEboss；场地出什么躲什么；尽可能打断死寒之箭，不要误伤被心控的玩家；P2看好自己是否有处理小怪的任务，同时注意打断BOSS的寒冰箭，躲好怨毒之影和死亡凋零"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["P1躲避各种环境伤害，保持8码分散，尽快输出小怪，优先击杀“畸形的狂热者”，空闲全力输出BOSS；P2躲好怨毒之影和在危险时确保自己可以自保"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end


    local bossnum = 3
    do
        local npcnum = 0
        local spell = {}
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0

        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- -- 名字
            -- local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            -- local Pnum
            -- local bossOnEnterText = L[""]
            -- BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- -- 技能
            -- local spellname = ""
            -- spellnum = spellnum + 1
            -- local Pnum
            -- local SpellInfoText = L[""]
            -- local SpellDoneText = L[""]
            -- BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
            --     npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end

        -- 职责
        local text1 = L["群啦坦注意躲避剑刃风暴，首领坦如果法师击杀慢了，注意首领NPC的战斗之怒技能叠层，危险的时候减伤技能该交的交"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["看好自己安排什么样任务，如果刷敌对舰首领坦，注意首领的战斗之怒层数；友方舰这边治疗注意看到剑刃风暴误伤的伤害，总体而言，这个BOSS没什么特别注意点"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["飞跃敌对舰的近战DPS注意首领的位置，注意别吃到顺劈，尽快击杀法师；除了被安排上火炮的玩家，优先安排单体高的近战DPS飞跃敌对舰杀法师，群攻高职业留友方舰清理小怪"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["飞跃敌对舰的远程DPS站在船边上尽快击杀法师；除了被安排上火炮的玩家，优先安排单体高的近战DPS飞跃敌对舰杀法师，群攻高职业留友方舰清理小怪"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end


    local bossnum = 4
    do
        local npcnum = 0
        local spell = {
            ["鲜血连接"] = 72195,
            ["鲜血能量"] = 72371,
            ["沸腾之血"] = 72385,
            ["鲜血新星"] = 72380,
            ["符文之血"] = 72410,
            ["阵亡勇士的印记"] = 72293,
            ["召唤血兽"] = 72173,
            ["狂乱"] = 72737,

            ["坚韧之皮"] = 72723,
            ["血之气息"] = 72769,
        }

        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            local bossOnEnterText = L["团队配置建议：2T5N18DPS / 2T4N19DPS\n本场战斗非常考验DPS转火续航和治疗的节奏，DPS是本场战斗的关键。萨鲁法尔的伤害均为物理伤害，请全团保持法师的魔法增益\n\n攻速：1.0\n伤害：原始伤害8万左右，实际伤害1.5万-1.8万左右，伤害受鲜血能量值加成"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText)

            -- 技能
            local spellname = "鲜血连接"
            spellnum = spellnum + 1
            local SpellInfoText = L["萨鲁法尔可以从他的技能和召唤生物造成的伤害中汲取鲜血能量。每2500点技能伤害产生一点鲜血能量"]
            local SpellDoneText = L["不要让血兽攻击到玩家，以减少鲜血能量的回复速度"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText)

            local spellname = "鲜血能量"
            spellnum = spellnum + 1
            local SpellInfoText = L["萨鲁法尔每获得一点鲜血能量，身体就会变大1%，所造成的伤害也会提高1%。最多100点"]
            local SpellDoneText = L["后续由于印记的治疗压力，根据时间轴安排减伤链很有必要。在治疗有压力缺口的时候开始安排减伤链"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText)

            local spellname = "阵亡勇士的印记"
            spellnum = spellnum + 1
            local SpellInfoText = L["当萨鲁法尔鲜血能量叠满到100，会随机对1名玩家释放阵亡勇士的印记，死亡使者萨鲁法尔的近战攻击会波及到该目标，每挥动一次攻击将对印记目标造成6175到6825点物理伤害。如果印记目标死亡将治疗萨鲁法尔其总生命值的20%。印记无法以任何形式驱散，包括死亡。伤害频率受萨鲁法尔攻速影响，物理伤害；不可被抵抗。印记伤害并不产生鲜血能量"]
            local SpellDoneText = L["整场战斗需要合理安排印记治疗策略来保持团队续航，奶骑利用道标可以1拖2；同时随着战斗时间的推移，出现多个玩家被中印记，整场战斗印记最好不要超过6个；法师的冰箱，骑士的无敌和干涉可以抵消伤害但是无法取消印记"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 3)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "沸腾之血"
            spellnum = spellnum + 1
            local SpellInfoText = L["进入战斗后每16秒使3名随机玩家的鲜血沸腾，每3秒造成5000点物理伤害，持续15秒，共25000点伤害"]
            local SpellDoneText = L["法师冰箱，骑士自己无敌，给其他玩家保护祝福，并在后续没有保护祝福的时候，每个玩家的自身减伤技能都将是非常重要。另外治疗的HOT是个非常不错的弥补。补充：关于骑士的保护祝福在鲜血能量什么阶段丢最优，根据计算，只要沸腾之血一出，就可以上保护了，后面的沸腾之血，玩家可交自己的减伤技能"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText)

            local spellname = "鲜血新星"
            spellnum = spellnum + 1
            local SpellInfoText = L["进入战斗后每20秒随机从一名玩家的身上迸出鲜血，对目标及其12码范围内的盟友造成9500到10500点物理伤害"]
            local SpellDoneText = L["开打前各职业安排好站位，彼此保持12码距离；合理安排好站位，不单单减少伤害，同时减少BOSS鲜血能量的涨幅速度"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText)

            local spellname = "符文之血"
            spellnum = spellnum + 1
            local SpellInfoText = L["进入战斗每21秒对当前目标释放符文之血，持续20秒。当萨鲁法尔对标记有符文之血的目标发动近战攻击时，他会从中吸取5950到8050点生命值，并以10倍的治疗量恢复自身的生命值"]
            local SpellDoneText = L["坦克第一时间嘲讽，并在被攻击期间不要多次使用嘲讽，防止出现嘲讽免疫；全程应当保持BOSS身上减少回血的debuff"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)

            local spellname = "狂乱"
            spellnum = spellnum + 1
            local SpellInfoText = L["当萨鲁法尔的生命值低于30%时，他会进入狂乱状态。使自身的体型增大20%，攻击速度提高30%"]
            local SpellDoneText = L["软狂暴，前期开荒受装备数值制约，建议团队爆发应当覆盖在此。坦克应当在当前坦时，安排覆盖自身减伤以及治疗和团队的减伤技能。每个团队组合不同，具体不作策略说明"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText)
        end

        -- NPC
        do
            local npcnum = 2
            local spellnum = 0

            -- 名字
            local npcname = L["血兽"]
            local bossOnEnterText = L["进入战斗后，每40秒萨鲁法尔在其身边召唤5只血兽来参与战斗。血兽的普攻伤害很高，攻速1.0，受鲜血连接影响，其攻击还受鲜血能量增益"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText)

            -- 技能
            local spellname = "坚韧之皮"
            spellnum = spellnum + 1
            local SpellInfoText = L["这种生物的皮肤有很强的抵抗力。效果范围攻击的伤害降低95%，疾病攻击的伤害降低70%"]
            local SpellDoneText = L["单点输出，不要AOE"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText)

            local spellname = "血之气息"
            spellnum = spellnum + 1
            local SpellInfoText = L["存活10秒后，萨鲁法尔的血兽捕捉到血的气味，使附近10码范围所有敌人的移动速度降低80%，并使他们的伤害提高300%，持续10秒"]
            local SpellDoneText = L["可安排一名强化正义之怒的奶骑来抢初始仇恨，让血兽出现第一时间追奶骑，同时避免血兽碰到玩家，合理安排比如猎人的冰霜陷阱、萨满天赋强化后的地缚图腾、术士的暗影之怒、鸟德的台风、DK的冰链等一切减速控制手段，并最快速度击杀"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 2)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 4)
        end

        -- 职责
        local text1 = L["2个T保持重叠站位，注意强化自己嘲讽的命中率；在符文之血最短时间内换嘲，多1秒就会给BOSS增加至少4-6点能量；BOSS30%血量以及高能量叠加时一定要做好自保技能。全程保持不灭药水"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["固定站位，全力根据安排看好自己任务目标，BOSS30%软狂暴期间以及BOSS高能量叠加期间做好饰品，技能等爆发。团队治疗注意看到沸腾之血和鲜血新星的玩家"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["固定站位全力输出，辅助血兽控制和输出；仇恨保持1，2坦之后避免倒T后，BOSS瞬间转头秒你；中沸腾之血交物理减伤，减少鲜血能量涨幅速度"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["根据自己站位全力输出boss和血兽，安排减速链职业看好血兽刷新时间提前做好准备；安排击杀血兽玩家优先击杀离自己最远的目标，临近时要躲开并注意血兽存活10秒后的血之气息"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end


    local bossnum = 5
    do
        local npcnum = 0
        local spell = {
            ["凋零毒气3"] = 69159,
            ["凋零毒气2"] = 69161,
            ["凋零毒气1"] = 69163,
            ["凋零呼吸"] = 69165,
            ["刺鼻毒气"] = 69195,

            ["邪恶毒气"] = 69240,

            ["毒气孢子"] = 69279,
            ["枯萎的孢子"] = 69290,
            ["播种疫苗"] = 69291,

            ["毒肿"] = 72219,
            ["毒性爆炸"] = 72227,

            ["可延展黏液"] = 72297,
        }

        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            local Pnum
            local bossOnEnterText = L["团队配置建议：2T5N18DPS\n\n攻速：1.5\n伤害：原始伤害8万左右，实际伤害约1.9万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "凋零毒气3"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["开始战斗后8秒，烂肠的房间内充斥着凋零毒气，每2秒对玩家造成一次暗影伤害，此技能伤害会有三个阶段，每30秒烂肠释放凋零呼吸吸收一次凋零毒气，使得伤害下降一级，烂肠每吸一次凋零毒气将为其伤害是攻速增加30%，并且体型增加20%，可叠3层\n[凋零毒气-浓烈]：每2秒对所有玩家造成6338-6662点暗影伤害\n[凋零毒气-均匀]：每2秒对所有玩家造成4388-4612点暗影伤害\n[凋零毒气-稀疏]：每2秒对所有玩家造成2438-2562点暗影伤害"]
            local SpellDoneText = L["治疗从原本的主团刷转换为主刷坦克的节奏"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["凋零毒气2"], spell["凋零毒气1"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 3)

            local spellname = "凋零呼吸"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["烂肠3.5秒施法，吸入房间里的凋零毒气，获得凋零呼吸BUFF，使其体型增大20%，攻击速度和物理伤害提高30%。最高可叠加三次。之后房间内凋零毒气变的稀疏"]
            local SpellDoneText = L["BOSS增伤BUFF，会让整场战斗的治疗压力从团队转向坦克。根据时间轴，安排治疗减伤链"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 3)

            local spellname = "刺鼻毒气"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["当烂肠获得3层凋零呼吸后30秒，烂肠开始猛烈释放刺鼻毒气（3秒读条），对所有玩家造成73125到76875点暗影伤害，并将致命的凋零毒气放回房间"]
            local SpellDoneText = L["通过全团孢子叠满三层，获得减少75%的暗影伤害BUFF；如果意外层数不够，另外法师[冰箱]，盗贼[暗影斗篷]，牧师都可以自保，德鲁伊2层+树皮也可以存活"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "毒气孢子"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["\n[毒气孢子]：Debuff，使3名随机玩家感染毒性孢子，持续12秒。时间结束后，毒气孢子会爆炸并使8码范围内的所有友方玩家感染枯萎的孢子，毒气孢子本身没有伤害\n[枯萎的孢子]：Debuff，被枯萎的孢子感染的玩家每1秒受到3900到4100点暗影伤害，持续6秒。时间结束后，被感染的玩家会受到获得播种疫苗BUFF影响\n[播种疫苗]：BUFF；你对凋零毒气的产生抗性，受到的暗影伤害降低25%，持续2分钟。该效果最多可叠加3次"]
            local SpellDoneText = L["该机制是为了应对刺鼻毒气。安排近战1个，远程2个，全程吃到BUFF；法师，暗牧，盗贼，因为有技能可以减免伤害，可以不吃孢子，以减少枯萎袍子带来的6秒伤害"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["枯萎的孢子"], spell["播种疫苗"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "邪恶毒气"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["随机对远处三名在目标区域造成一个邪恶毒气，每2秒造成6338到6662点暗影伤害，持续6秒。邪恶毒气使被感染的目标无法控制地呕吐，并对其8码附近的盟友造成5850到6150点暗影伤害"]
            local SpellDoneText = L["这是一个分散规避且需要治疗关注的技能，同时和后面的毒气孢子的机制容易让队友产生混乱，这里的时间轴一般是先出邪恶毒气，然后孢子。毒气孢子聚合后，吃到枯萎的孢子后应当快速分散，躲避邪恶毒气以及后面的可延展黏液"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "毒肿"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["\n[毒肿]：对当前目标造成14625到15375点伤害，并对目标施加一层毒肿，使伤害提高10%，持续2分钟，最高可叠加10层\n[毒性爆炸]：当玩家毒肿叠加10层后，引发毒性爆炸，对附近的所有盟友造成48750到51250点暗影伤害，同时目标玩家死亡"]
            local SpellDoneText = L["两个坦克9层后换坦。而且换坦后，9层的坦克要停手输出BOSS，否则容易OT"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["毒性爆炸"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 5)

            local spellname = "可延展黏液"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["普崔塞德教授在阳台上随机会选定玩家所在的区域扔出一团弹跳的可延展粘液，粘液在弹跳2次后爆炸，对目标区域半径8码范围内的玩家造成14625-15375点自然暗影伤害，并降低攻击和施法速度250%，持续20秒"]
            local SpellDoneText = L["目标地点会有一摊很小的绿水，第一时间躲开8码。近战可类似奥尔加隆左右换脚输出"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 4)
        end

        -- 职责
        local text1 = L["坦克将BOSS坦在中间，做好相互之间毒肿层数的监控，按约定层数换嘲；遇到三层凋零呼吸既然到来时或BOSS已经三层凋零呼吸时，嘲讽前做好开好减伤再嘲讽；同时坦克注意可延展黏液丢在近战位的时候，要稍微带离BOSS离开伤害范围，方便近战和自己躲避可延展黏液"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["安排刷坦治疗注意凋零毒气和凋零呼吸的层数，做到团刷和坦刷直接的节奏；凋零呼吸高层切好需要换嘲时主要要给准备嘲讽的坦克预读治疗，适时可提交交减伤。三层凋零毒气需要团刷时提高团刷效率；并注意可延展黏液和孢子的分散和集合"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["全力输出BOSS，注意点名孢子的位置以及躲避可延展黏液，危险的时候自己开个减伤技能，尤其出现自己播种疫苗层数不够的时候"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["注意可延展黏液和孢子的分散和集合，其他全力输出BOSS，注意如果出现自己播种疫苗未满三层，记得一定要开个减伤或向机制职业要一个减伤续命"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end


    local bossnum = 6
    do
        local npcnum = 0
        local spell = {
            ["软泥洪流"] = 69789,
            ["软泥喷射"] = 69508,
            ["畸变感染"] = 69674,
            ["邪恶毒气"] = 72272,

            ["粘稠的软泥"] = 69778,
            ["弱化放射性软泥怪"] = 69751,

            ["放射性软泥怪"] = 69761,
            ["不稳定的软泥怪"] = 69558,
            ["不稳定的软泥爆炸"] = 69833,
        }

        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            local Pnum
            local bossOnEnterText = L["团队配置建议：2T5N18DPS\n\n攻速：1.5\n伤害：原始伤害7万，实际伤害约1.6万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "软泥洪流"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["房间周围的墙壁上会有两两一组共计四组软泥管道受普崔塞德教授控制。战斗中，每隔20秒就会有一对软泥管道开启，向地面上放出可覆盖房间1/4位置的软泥洪流，持续20秒。四组软泥管道以逆时针或对角循环。当有生物踏入软泥洪流时，会每1秒受到6338到6662点瘟疫（自然暗影）伤害，并使其移动速度降低10%，持续5秒，可叠加10次，最终玩家将不可移动"]
            local SpellDoneText = L["躲开。坦克如果风筝大软泥怪需要穿过时软泥洪流，上自由祝福"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "软泥喷射"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["1.5秒引导施法，20秒冷却。瞄准随机玩家当前所在位置，引导性的对前方锥形区域内的所有敌人每1秒造成7800到8200点自然暗影伤害，持续5秒"]
            local SpellDoneText = L["当BOSS开始引导施法时，离开BOSS正面；腐面没有正面范围攻击，玩家可以直接穿过BOSS肚子到屁股后面"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "畸变感染"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["随机对一名非坦克玩家释放疾病，对其每1秒造成4875到5125点瘟疫(自然暗影)伤害，并在12秒内降低玩家75%的受到的治疗效果。驱散疾病后，会在目标所处的位置生成一个小软泥怪"]
            local SpellDoneText = L["由于机制里存在减少75%治疗效果，因此要立即驱散；并且点名玩家要立即离开人群，带着小软泥怪去找其他小软泥合成大软泥怪"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "邪恶毒气"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["普崔赛德教授在楼上随机点名3名玩家，朝目标区域施放邪恶毒气，对其目标区域内玩家造成每2秒6338到6662点瘟疫（自然暗影）伤害，持续6秒。该毒气会使被感染的目标呕吐不止，并对其8码范围内的盟友造成每2秒5850到6150点瘟疫（自然暗影）伤害。优先对远离腐面的玩家释放"]
            local SpellDoneText = L["远程沙包组相互保持8码分散"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 4)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["小软泥怪"]
            local Pnum
            local bossOnEnterText = L["小软泥怪是由畸变感染被驱散后产生。小软泥怪会追逐该名玩家，免疫嘲讽，且没有普攻。该小怪不用击杀"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6, "NPC")

            local spellname = "粘稠的软泥"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["1秒读条施法，朝小软泥怪正面23码内喷射一团粘的软泥(地上绿水6码范围，并持续30秒）。造成处于软泥区域的玩家每秒受到3900-4100点瘟疫（自然暗影伤害），并使其降低移动速度50%"]
            local SpellDoneText = L["被追逐的玩家要带着小软泥怪跑出人群，同时避免面朝大团"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "弱化放射性软泥怪"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["对半径10码范围内的敌人每2秒造成4875-5125点瘟疫(自然暗影)伤害，并使与10码范围内的其它的软泥怪进行融合"]
            local SpellDoneText = L["被追逐的玩家要带着小软泥怪跑出人群，并且去找其他软泥怪融合，注意：遇到后在10码范围保持2秒，开战第一只小软泥怪请带离人群并保特10码范围等待下一只融合"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["大软泥怪"]
            local Pnum
            local bossOnEnterText = L["大软泥怪由2只小软泥怪靠近后合成而来，大软泥怪普攻很高，实际伤害2万多，需安排坦克负责风筝。该小怪不用击杀"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1, "NPC")

            -- 技能
            local spellname = "粘稠的软泥"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["1秒读条施法，朝小软泥怪正面23码内喷射一团粘的软泥(地上绿水6码范围，并持续30秒）。造成处于软泥区域的玩家每秒受到3900-4100点瘟疫（自然暗影伤害），并使其降低移动速度50%"]
            local SpellDoneText = L["风筝大软泥怪的坦克要避免小怪面朝大团"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "放射性软泥怪"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["对半径10码范围内的敌人每2秒造成6338到6662点自然暗影伤害，它还会使大软泥怪与10码范围内的其它的软泥怪进行融合"]
            local SpellDoneText = L["风筝大软泥怪的坦克要远离大团"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "不稳定的软泥怪"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["每次大软泥怪和其他软泥怪融合时，它都会变得更加不稳定，体型增大，造成的伤害提高20%。可叠加10次"]
            local SpellDoneText = L["风筝，大软泥怪叠高BUFF后可能秒T"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "不稳定的软泥爆炸"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["当大软泥怪与其他软泥怪融合5次之后，它会引爆自己，并朝8个就近玩家投射软泥炸弹。软泥炸弹会瞄准目标当前所在位置缓慢抛射，落地后会对着陆点6码范围的所有玩家造成14625到15375点自然暗影伤害"]
            local SpellDoneText = L["爆炸后，大团移动到其他区域即可，躲避难度并不大"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)
        end

        -- 职责
        local text1 = L["1坦拉好腐面在场地中间，注意拉开意外放在中间的粘稠的软泥；大软泥怪风筝坦逆时针风筝大软泥，小软追不上的时候可制裁"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["根据安排奶好自己任务目标；躲避大小软泥10码；不稳定的软泥爆炸注意移动躲开，并适当开启团队减伤和迅速抬血。站外圈治疗逆时针移动躲避软泥洪流"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["腐面背面疯狂输出，躲避偶尔可能的邪恶毒气；当腐面软泥喷流时移动到侧面继续输出，躲避各类会引起伤害的位置。不稳定的软泥爆炸移动躲开"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["安排邪恶毒气沙包的远程，8码分散全力输出BOSS；其他远程站BOSS背面，移动方式和近战一致；并躲避一切范围伤害"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end


    local bossnum = 7
    do
        local npcnum = 0
        local spell = {}
        spell["软泥滩"] = 70346
        spell["不稳定的实验"] = 70351
        spell["肆虐毒疫"] = 70911
        spell["天灾疾病"] = 70953

        spell["危险实验"] = 72840
        spell["软泥特性"] = 70352
        spell["异变毒气"] = 70353

        spell["窒息毒气弹"] = 71255
        spell["可延展黏液"] = 72295

        spell["畸变之力"] = 71603
        spell["畸变瘟疫"] = 72451

        spell["畸变"] = 70405
        spell["吞食软泥"] = 70360
        spell["回流软泥"] = 70539
        spell["变异打击"] = 70542

        spell["不稳定的软泥怪黏合剂"] = 70447
        spell["软泥喷发"] = 70492

        spell["毒肿"] = 70215
        spell["毁灭毒气"] = 70701

        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            local Pnum
            local bossOnEnterText = L["团队配置建议：3T5N17DPS or 2T5N18DPS\n该BOSS分3个阶段。P1：100%-80%，转接段：30秒，P2：80%-35%，转接段：20秒，P3：35%-0%\n\n攻速：1.5\n伤害：原始伤害8.2万左右，实际伤害约2.2万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "肆虐毒疫"
            spellnum = spellnum + 1
            local Pnum = "P1/P2/P3"
            local SpellInfoText = L["瞬发，普崔塞德教授会随机向1名玩家释放肆虐毒疫，对其造成800点暗影伤害，之后每1秒都会造成以加25%递增的暗影伤害，持续1分钟。每秒时间判定如果感染肆虐毒疫的玩家离其他友方目标5码内，还会将该毒疫传染给其他玩家。被传染出去的肆虐毒疫的持续时间不会刷新，但伤害会恢复初始重新累加。每次当玩家感染过肆虐毒疫之后，他将会获得一层天灾疾病的影响，使其受到肆虐毒疫的伤害提高250%，持续1分钟。可叠加10次"]
            local SpellDoneText = L["方法一：将获得肆虐毒疫的传染给指定玩家放生，以消除一分钟内肆虐毒疫对团队的影响（这里指定玩家可以是3T），此方法需要安排好德鲁伊战复以及术士灵魂石的顺序，一场战斗大概需要7-8次复活，此方法对团队治疗压力较轻，但会因为每次战复死亡玩家和刷BUFF期间浪费一些DPS，比较适合开荒阶段\n方法二：合理安排相互传染的节奏，比如让其中每感染的玩家在等待持续8-10秒然后传染给下一个人，这种方案可在前期开荒阶段因团队战复和术士数量不足的情况下考虑，方案将增加团队执行力的压力，但对一个成熟的团队相对还是可以应付的\n方法三：全团分近战组和远程组集合站位来感染肆虐毒疫，让其在人群中随机传染，此方案的好处是团队无视肆虐毒疫的传染机制，减少团队的行动次数，但会显著增加团队治疗的压力，并且团队还需要配合观察团血情况来覆盖减伤技能，以避免团队崩盘"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["天灾疾病"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 4)

            local spellname = "软泥滩"
            spellnum = spellnum + 1
            local Pnum = "P1/P2/P3"
            local SpellInfoText = L["瞬发，35秒冷却。朝2名随机玩家当前所在位置扔出一团变异黏液，落地后会在地面上形成一滩逐渐扩大的绿色软泥滩。对处在软泥滩中的目标造成6825 to 7175点自然暗影伤害。畸变的憎恶使用吞食软泥技能吞食脚下的变异软泥来缩小软泥滩的大小，并使畸变的憎恶获得4点软泥能量"]
            local SpellDoneText = L["大团在处理好肆虐毒疫后尽量靠近，以避免软泥摊相互距离太远；变异体应快速清理干净"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "不稳定的实验"
            spellnum = spellnum + 1
            local Pnum = "P1/P2"
            local SpellInfoText = L["2.5秒施法，40秒冷却；普崔塞德教授进行一项不稳定的实验！2.5秒施法后从房间两侧的导管之一中召唤1只软泥生物来加入战斗。先开启面朝BOSS初始位置的右侧导管，召唤一只不稳定的软泥怪。然后开启左侧，召唤一只毒气之云。以此循环"]
            local SpellDoneText = L["绿软集合分摊击杀，红软风筝击杀；畸变的憎恶记得留能量给软泥怪上减速"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "危险实验"
            spellnum = spellnum + 1
            local Pnum = "转阶段"
            local SpellInfoText = L["转简单，教授会马上开始2.5秒施法，普崔塞德教授对所有玩家进行一项邪恶的实验！使一半玩家被软泥特性影响，另一半玩家被异变毒气影响。同时从左右两侧的导管中各召唤一只软泥怪出来加入战斗"]
            local SpellDoneText = L["特性让玩家相对异色怪物输出伤害免疫。根据自己的状态输出对应软泥怪。处理方式同样，绿软集合分摊击杀，红软风筝击杀；畸变的憎恶记得留能量给软泥怪上减速"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["软泥特性"], spell["异变毒气"])

            local spellname = "窒息毒气弹"
            spellnum = spellnum + 1
            local Pnum = "P2"
            local SpellInfoText = L["瞬发，35秒冷却。普崔塞德教授向他周围投掷2枚毒气炸弹，落地3秒后产生3码范围的窒息毒气，处在窒息毒气范围内的玩家每1秒会造成6825 to 7175点暗影伤害，并使其命中降低100%，持续15秒。炸弹会在20秒后发生爆炸，对10码范围内玩家造成29250 to 30750点暗影伤害，将其击退并使其命中几率降低100%，持续20秒。DEBUFF不可被驱散"]
            local SpellDoneText = L["释放后近战先远离，坦克看BOSS放了炸弹后拉走远离即可，其他远程请勿靠近。建立团队合理安排坦克拉BOSS的行进路线"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)

            local spellname = "可延展黏液"
            spellnum = spellnum + 1
            local Pnum = "P2"
            local SpellInfoText = L["瞬发，20秒冷却。分别朝3名随机玩家所在的区域扔出一团弹跳的可延展粘液，粘液在弹跳2次后爆炸，对目标区域半径5码范围内的玩家造成23400到24600点自然暗影伤害，并降低攻击和施法速度250%，持续15秒"]
            local SpellDoneText = L["当发现地上有绿色小软泥坑，即表示可延展黏液即将落在此处。可延展黏液会沿直线反弹并击中其路径上的所有玩家，而不仅仅是着陆点，因此每个人都必须移到一边。可以远程集合站位，统一移动"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "畸变之力"
            spellnum = spellnum + 1
            local Pnum = "P3"
            local SpellInfoText = L["普崔塞德教授开始一瓶瓶地试喝桌上的所有药剂并开始完全变异，使得他物理伤害提高50%，攻击速度提高50%，攻击还会使得他畸变更加严重，会对当前目标释放畸变瘟疫"]
            local SpellDoneText = L["BOSS变为攻速1.2，攻击原始伤害高达13万左右，实际在3万左右。此阶段坦克尽可能的全程覆盖减伤，以应对高频，高强度的伤害"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "畸变瘟疫"
            spellnum = spellnum + 1
            local Pnum = "P3"
            local SpellInfoText = L["瞬发，10秒冷却。朝当前目标释放畸变瘟疫，持续1分钟。可叠加。每1个带有畸变瘟疫的玩家会每3秒对所有玩家造成250点暗影伤害。每多叠加1层，该伤害将提高3倍即750点暗影伤害。当畸变瘟疫从玩家身上消失时，每一层畸变瘟疫会为普崔塞德教授回复210万生命值"]
            local SpellDoneText = L["本场战斗选择2T还是3T打法取决于团队DPS；建议2层换嘲，DPS也可以开减伤给压制或保护来嘲讽吃层数"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["畸变的憎恶"]
            local Pnum = "P1/P2/转阶段"
            local bossOnEnterText = L["战斗开始，需要一名玩家通过点击实验台上道具，5秒倒计时后变异成畸变的憎恶，畸变的憎恶的技能没有GCD，请尽量双技能多按，与此同时所有玩家还将受其光环技能畸变影响，对所有玩家造成每2秒4388点自然暗影伤害。P3阶段，畸变的憎恶将无法使用。普攻实际伤害约1.2万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "畸变"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["该疾病使1名玩家变成憎恶人柱力，但也会每2秒对所有玩家造成4388到4612点自然暗影伤害。治愈该疾病可以使玩家恢复正常状态。千万不要解除！"]
            local SpellDoneText = L["刷团血"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "吞食软泥"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["（载具技能1）吞食脚下的变异软泥来缩小软泥滩的大小，并使你获得4点软泥能量！"]
            local SpellDoneText = L["在绿水里拼命按1技能，积攒的能量将用于技能2。其他玩家有回能量的技能也可以作用于畸变的憎恶"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "回流软泥"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["（载具技能2）消耗45点软泥能量对当前目标施放一种奇特效果，降低其移动速度50%，并且每2秒造成9263到9737点自然暗影伤害，持续20秒"]
            local SpellDoneText = L["给软泥怪上减速，减缓它追上玩家的速度。需要注意留够能量给转阶段同时出现的两只软泥怪"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "变异打击"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["（载具技能3）立即对当前目标造成100%的武器伤害，并使其对物理伤害的抗性降低4%，持续20秒。最多叠加5次"]
            local SpellDoneText = L["请全程对教授和软泥怪保持层数，可以和破甲叠加"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["不稳定的软泥怪（绿软）"]
            local Pnum = "P1/P2/转阶段"
            local bossOnEnterText = L["血量：198万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "不稳定的软泥怪黏合剂"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["不稳定的软泥怪释放强力黏合剂将1名随机玩家粘附在原地，目标被缠绕的同时每1秒还会受到7313到7687点自然暗影伤害。同时，不稳定的软泥怪会不顾一切的尝试靠近目标玩家。当其成功接触到目标玩家时将释放软泥喷发。软泥喷发：不稳定的软泥怪引爆自身，对当前目标造成243750到256250点自然暗影伤害。该伤害将由目标10码范围内的盟友均摊，并将它们向四周击退！"]
            local SpellDoneText = L["点近战，近战分摊。点远程，围绕黏合剂目标集合站位输出绿软，等待分担伤害，团队择时根据情况开启团队减伤技能。所有宝宝应攻击绿软，猎人放毒蛇陷阱，可以分担伤害"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["软泥喷发"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["毒气之云（红软）"]
            local Pnum = "P1/P2/转阶段"
            local bossOnEnterText = L["血量：198万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "毒肿"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["毒气之云锁定1名随机玩家，使其瞬间受到10层毒肿效果的影响，每1层毒肿效果会对其每2秒造成1950到2050点自然暗影伤害。之后，毒气之云会不顾一切的追逐目标玩家。毒肿效果每2秒会自动削减1层。如果毒气之云攻击到目标玩家，则会释放毁灭毒气，瞬间引爆目标身上剩余的全部毒肿层数，对所有玩家造成巨大伤害。当目标的毒肿效果全部消失后，毒气之云会重新锁定目标"]
            local SpellDoneText = L["毒肿的伤害受层数影响，治疗要注意奶好，被点名玩家风第毒气之云，但不要脱离治疗范围。近战在1层左右离开目标，以防止下次被点名"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["毁灭毒气"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 5)
        end

        -- 职责
        local text1 = L["全程注意BOSS背朝大团，以及软泥滩和窒息毒气弹 的位置。当教授刷新不稳定的软泥怪的时候拉倒脚下，方便近战输出，注意绿软点名近战时自己开个减伤。并确保减伤技能CD可在P3使用。尽量把教授拉倒软泥摊附近，方便憎恶吸水以及输出BOSS,P3阶段延墙壁移动，在畸变瘟疫2层换嘲，按情况自己交好减伤"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["躲好软泥摊和可延展粘液，以及P2,P3阶段不要站近战的移动轨迹位，确保离开炸弹10码，中肆虐毒疫去传染沙包，看坦克治疗确保远离绿软点名玩家，以防止爆炸时产生位移影响治疗。团队治疗可一起分摊伤害。注意看好红软点名玩家的玩家。P3阶段注意坦克换嘲后的目标，别时刻注意血线。确保P3阶段群体减伤技能可用"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["中肆虐毒疫，跑去传染沙包。躲好炸弹和窒息毒气，当场面有软泥怪时，优先处理软泥怪，红软毒肿1层就要跑开，防止自己被点名来不及风筝。在P3阶段留好自保和爆发技能"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["中肆虐毒疫，跑去传染沙包。躲好软泥摊和可延展粘液，以及P2,P3阶段不要站近战的移动轨迹位，确保离开炸弹10码，优先处理软泥怪 ，并确保爆发和保护技能在P3可用"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end


    local bossnum = 8
    do
        local npcnum = 0
        local spell = {
            ["鲜血唤醒-风"] = 70952,
            ["鲜血唤醒-火"] = 70982,
            ["鲜血唤醒-暗"] = 70981,
            ["暗影牢笼"] = 72999,

            ["动力炸弹"] = 72052,
            ["震荡涡流"] = 71944,
            ["强能震荡涡流"] = 72039,

            ["闪耀火花"] = 71807,
            ["幻化烈焰"] = 71718,
            ["塑造强能烈焰"] = 72040,

            ["暗影共鸣1"] = 71943,
            ["暗影共鸣2"] = 71822,
            ["影枪"] = 71405,
            ["强能影枪"] = 71815,
        }

        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["环境技能"]
            local Pnum
            local bossOnEnterText = L[""]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "鲜血唤醒-风"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["黑暗堕落者的宝珠，会每45秒控制三个王子的其中一位，使其充满能量，并赐予他更多强大的能力。开战后，三个王子都会进入战斗并共享生命值，但只有被鲜血唤醒的王子被赋予生命值和强化他的能力。第一次控制瓦拉纳王子，然后随机选择凯雷塞斯王子或塔达拉姆王子"]
            local SpellDoneText = L["根据不同王子安排不同坦克拉到安排的站位"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["鲜血唤醒-火"], spell["鲜血唤醒-暗"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "暗影牢笼"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["本场战斗中，玩家只要移动，就会受到350点起始暗影伤害，每移动一秒，伤害提高500点。10s内保持不动则会重置该效果"]
            local SpellDoneText = L["尽量别动，但危险的时候还是要动一动；开战安排合理站位将变的很重要"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 4)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["瓦拉纳王子"]
            local Pnum
            local bossOnEnterText = L["团队配置建议：3T5N17DPS\n\n攻速：2.0\n伤害：原始伤害12万，实际伤害约2.5万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "动力炸弹"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["1.5秒施法；进入战斗18秒后，其后每30秒开始召唤一枚在空中缓慢落向地面的动力炸弹。炸弹接触地面爆炸。造成50码范围内所有玩家18000- 22000点物理伤害，并将敌人远远地击飞。直接攻击炸弹的伤害会被炸弹吸收并转换为能量，使炸弹飞的更高阻止它落地。动力炸弹最多存在1分钟。一个挂着空中的动力炸弹，有生命值，但无法被消灭；可通过攻击让其永远飘在空中；根据时间轴，最多可同时存在三枚"]
            local SpellDoneText = L["安排远程看着即可，可上一些DOT，这里建议任务玩家做个焦点宏输出。利用猎人、术士的宠物攻击你会发现变的非常简单"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "震荡涡流"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["（未被鲜血召唤时的技能）随机在1名玩家脚下召唤一团小型的震荡漩涡，5秒后形成半径12码的震荡涡流，持续20秒。震荡涡流触发判定，触碰震荡涡流的玩家将受到12000点物理伤害，并被远远击退"]
            local SpellDoneText = L["躲开即可"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "强能震荡涡流"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["（被鲜血召唤时的技能）4.5秒读条，20秒一次，瓦拉纳王子在所有玩家脚下立即召唤一道强猛的冲击涡流。产生的涡流会对玩家自身造成5000物理伤害，并对12码范围内的其玩家造成8000点物理伤害，并将其击退"]
            local SpellDoneText = L["远程提前站位，近战要看到读条时快速分散彼此保持12码"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["塔达拉姆王子"]
            local Pnum
            local bossOnEnterText = L["攻速：2.0\n伤害：原始伤害12万，实际伤害约2.5万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "闪耀火花"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["瞬发，90码。每20秒塔达拉姆王子向自己前方锥形区域射出闪耀火花，对所有玩家造成每2秒4180到4620点火焰伤害共计造成16720 to 18480点左右的火焰伤害，并使其移动速度降低40%的魔法效果，持续8秒，可被驱散"]
            local SpellDoneText = L["群体抬血或驱散即可"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 8)

            local spellname = "幻化烈焰"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["（未被鲜血召唤时的技能）进入战斗30秒后，后面每隔20秒，50码范围内随机点名一名玩家，3秒施法召唤一个烈焰之球并追逐玩家，飞向目标并在命中时爆炸，对15码范围内的所有玩家造成最少12000点火焰伤害。烈焰之球会在空中飞行时间越长体积越小，爆炸时造成的伤害越低"]
            local SpellDoneText = L["被点名玩家跑开人群，尽量多带一些路，确保小球变小后并在吃爆炸的时候远离人群15码，其他玩家不用处理；由于伤害并不算高，带离一点距离后直接爆炸也无妨"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "塑造强能烈焰"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["（被鲜血召唤时的技能）50码范围内随机点名一名玩家，3秒施法召唤一个强能炼狱火球并追逐玩家，飞向目标并在命中时爆炸，对15码范围内的所有玩家造成基础值12000点火焰伤害（满额高达6.5万）。炼狱火球还会对沿途10码范围玩家造成每秒1500点火焰伤害，炼狱火球通过沿途释放能量越多体积会变得越小，体积越小最终造成的爆炸伤害越低"]
            local SpellDoneText = L["被点名玩家跑开人群，尽量多带一些路，让更多玩家吃到强能烈焰伤害，以确保炼狱火球体积变小，并确保最终爆炸时离开人群15码。大团可以保持集合。此时需要交一个光环掌握或神圣牺牲"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["凯雷塞斯王子"]
            local Pnum
            local bossOnEnterText = L["无普攻，此BOSS还可以让术士作为坦克"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "暗影共鸣1"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["凯雷塞斯王子每隔10秒左右会召唤一个黑暗之核（10万血量），该小怪会施放黑暗之核技能：光环技能；瞬发；当目标靠近黑暗之核15码内的时候与暗影产生共鸣，立即引导施法使其承受每三秒1000点暗影伤害，并使其受到的所有类型的暗影伤害降低35%"]
            local SpellDoneText = L["拉凯雷塞斯王子的坦克嘲讽拉倒自己身边，血量较少；其他玩家不要输出黑暗之核，鲜血召唤是凯雷塞斯王子的时候注意不要AOE，6层暗影共鸣最佳"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["暗影共鸣2"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)

            local spellname = "影枪"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["（未被鲜血召唤时的技能）1.5秒施法，30码。对当前目标射出一发黑暗魔法之箭，造成19013 to 19987点暗影伤害。无法反射"]
            local SpellDoneText = L["利用黑暗之核的暗影共鸣减伤来抵挡高额伤害，一般凯雷塞斯王子的坦克有吃到3层暗影共鸣，就没什么压力了"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "强能影枪"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["（被鲜血召唤时的技能）1.5秒施法，30码。对当前目标射出一发黑暗魔法之箭，造成95063 to 99937点暗影伤害。无法反射"]
            local SpellDoneText = L["利用黑暗之核的暗影共鸣叠加BUFF的减伤效果来抵挡高额伤害，一般凯雷塞斯王子的坦克有吃到3层暗影共鸣，就没什么压力了"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end

        -- 职责
        local text1 = L["根据自己任务安排拉好BOSS，并注意躲避震荡涡流；自保技能根据压力自行安排；尽量拉定位置后不要移动"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["坦克治疗注意瓦拉纳王子和塔达拉姆王子的高压普攻伤害；快速驱散闪耀火花，分散站位注意AOE伤害的抬血。注意强能震荡涡流和塑造强能烈焰的团血健康"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["根据站位全力输出，强能震荡涡流时快速分散到指定位置并保持相隔12码；处理凯雷赛德王子时，不要AOE到黑暗之核。中炸弹跑开人群"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["根据站位全力输出，强能震荡涡流时注意自己相邻位置保持12码；处理凯雷赛德王子时，不要AOE到黑暗之核。中炸弹跑开人群。挂好动力炸弹的伤害"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end


    local bossnum = 9
    do
        local npcnum = 0
        local spell = {}
        spell["哀伤之雾"] = 70985
        spell["黑暗堕落者的灵气"] = 70995

        spell["鲜血镜像"] = 70838
        spell["疯狂斩杀"] = 71623
        spell["暮光血箭"] = 71818
        spell["蜂拥之影"] = 71277
        spell["黑暗堕落者的契约"] = 71340
        spell["吸血撕咬"] = 71726
        spell["鲜血女王的精华"] = 70867
        spell["疯狂嗜血"] = 70877
        spell["失心疯"] = 70923

        spell["煽动惊恐"] = 73070
        spell["血箭飞舞"] = 71772



        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["环境技能"]
            local Pnum
            local bossOnEnterText = L[""]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "哀伤之雾"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["光环技能；贯穿整场战斗。施法者体内散发出一道悲惨绝望的光芒，对附近40码范围的敌人造成每2秒4500点暗影伤害。受黑暗堕落者的灵气影响，狂暴前最后每2秒高达8100点暗影伤害。被鲜血镜像连线的坦克不受此技能影响"]
            local SpellDoneText = L["团血职业的主场"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "黑暗堕落者的灵气"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["每当有一名玩家吸血鬼存在都会将他的气息注入了鲜血女王兰娜瑟尔，使其哀伤之雾的强度提高5%，可叠加。吸血撕咬技能产生的副作用，鲜血女王的精华的Debuff算作一个吸血鬼，增加鲜血女王的精华有二个渠道，一是BOSS会每X释放一次吸血撕咬，2玩家吸血撕咬后还会继续存在鲜血女王的精华，所以越到后面会人数越多，版本开荒初期一场战斗会有16层左右。1-2-4-8-16"]
            local SpellDoneText = L["越到后面团队治疗压力越大"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 4)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            local Pnum
            local bossOnEnterText = L["团队配置建议：开荒初期2T5N18DPS\nP1：地面阶段。P2：空中阶段（一共有2次：第一次2分05秒，第二次3分45秒）\n\n攻速：2.0\n伤害：原始伤害8万左右，实际伤害约2万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "鲜血镜像"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["瞬发。进入战斗后3秒鲜血女王兰娜瑟尔会将当前目标和其离的最近的一名玩家连接起来。将鲜血女王兰娜瑟尔当前目标受到的100%的伤害反射给相连的一方。开战3秒开始判定"]
            local SpellDoneText = L["双坦重合站位。其他玩家不要抢了2T位置"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)

            local spellname = "疯狂斩杀"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["瞬发，10码，20秒一次。对与鲜血女王兰娜瑟尔当前目标连接起来的玩家造成75%的武器伤害并使其不断流血，并在后面每3秒造成7000到9000点流血伤害，持续15秒"]
            local SpellDoneText = L["沙包坦，三维不再重要，尽量多叠一些耐力和暗抗装。此处将是熊坦的高光时刻"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)

            local spellname = "暮光血箭"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["瞬发。随机点名2名玩家，向目标射出一股黑色血箭，对目标及其周围6码内的盟友造成16150 to 17850暗影奥术伤害。不会点名鲜血连接的玩家"]
            local SpellDoneText = L["团队要严格安排分散站位"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "蜂拥之影"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["瞬发，每隔30秒随机对1名玩家释放蜂拥之影，对其每秒造成3238到3762点暗影伤害，持续6秒（实际伤害为5次判定）。持续期间该玩家每0.5秒将在脚下生成一团半径4码的蜂拥之影，并将持续燃烧1分钟，触碰到蜂拥之影的玩家每1秒将受到5850到6150点暗影伤害"]
            local SpellDoneText = L["点名到生效有2秒时间提前跑位，将蜂拥之影放在角落，0.5秒移动一下，类似TOC的2号的烈焰之火"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "黑暗堕落者的契约"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["瞬发，30秒冷却。将随机3名玩家以黑暗堕落者的契约连接，持续28秒。当连接存在时，每0.5秒都会对其和附近未相连的盟友造成持续加剧的暗影伤害。当所有相连的目标都相互位于各自5码范围内时，连接将消失"]
            local SpellDoneText = L["安排一个区域给连线集合位，中连线的人以最快速度集合"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "吸血撕咬"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["瞬发，5码。释放于开战后15秒。鲜血女王兰娜瑟尔发动吸血撕咬，对仇恨列表（这里无视鲜血连线的二个坦克）最高的玩家造成10175到11825点物理伤害，并使其受到鲜血女王的精华效果的影响，持续1分钟。时间结束后，被鲜血女王的精华影响的玩家将进入持续10秒的疯狂嗜血状态。在此期间，必须啮咬一名友方玩家，从而延缓你对鲜血的需求。否则将会被鲜血女王控制，从而进入失心疯状态。吸血撕咬无法对已经成为吸血鬼的对象使用"]
            local SpellDoneText = L["吸血撕咬只会对仇恨最高玩家释放，且无视鲜血连线的坦克。由于吸血撕咬是个近战攻击，建议第一咬让近战抢仇恨，这样减少BOSS的位移，以减少DPS的浪费"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["鲜血女王的精华"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "疯狂嗜血"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["当鲜血女王的精华结束，进入疯狂嗜血阶段，你的动作条会变成载具状态，在动作条1有吸血撕咬技能，对5码范围内的目标造成10175 to 11825点伤害，并使其受到鲜血女王的精华效果的影响。你必须在10秒内去施法者必须满足其对鲜血的渴望，否则即会失去为兰娜瑟尔作战的斗志"]
            local SpellDoneText = L["确保被咬对象血量健康且10秒必须咬出去"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["失心疯"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "煽动惊恐"
            spellnum = spellnum + 1
            local Pnum = "P2"
            local SpellInfoText = L["瞬发。在空中阶段开始时，鲜血女王会走到中间立即释放煽动惊恐，使所有玩家因恐惧而逃跑，持续4秒。可驱散"]
            local SpellDoneText = L["萨满的战栗图腾，人类的自利，牧师的防恐给自己，卡着点预读群体驱散；牧师注意插防护恐惧结界雕文"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 8)

            local spellname = "血箭飞舞"
            spellnum = spellnum + 1
            local Pnum = "P2"
            local SpellInfoText = L["瞬发，需引导。鲜血女王兰娜瑟尔在空中召唤一场血箭风暴，持续6秒。每2秒朝多名随机玩家射出血箭，对目标及其6码范围内的盟友造成16150 到 17850点暗影奥术伤害"]
            local SpellDoneText = L["严格确保6码分散站位，个人注意自保，团队开大牺牲以及光环掌握；第二轮上天由于层面有黑暗堕落者的灵气的叠层，因此此阶段的血箭飞舞要格外注意"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end

        -- 职责
        local text1 = L["血量高的坦克安排副坦吃疯狂斩杀，主坦和副坦站位要重叠，择时自保，并交出自己的增益技能，如DKT的狂乱，防战的警戒"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["主要看好两个坦，尤其副坦中了疯狂斩杀，其他治疗要保持HOT，其他治疗要看好蜂拥之影玩家，以及每次暮光血箭技能，P2阶段要在血箭飞舞保持团血爆发。并注意自己的站位，在疯狂嗜血最后3-5秒左右去咬他人"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["DPS最高的近战抢到除坦克外的第一仇恨；快速处理好连线和蜂拥之影，在疯狂嗜血最后3-5秒左右去咬他人，确保时间轴P2阶段不出现需要咬人的情况，以及在P2阶段注意自己的站位，每次转阶段先让坦克吃到鲜血镜像。如果近战人多，可尽量分组站位，以避免吃到更多的暮光血箭AOE伤害"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["确保让DPS最高的近战仇恨保持除坦克外的第一仇恨，以确保他被第一个吸血撕咬点名；快速处理好连线和蜂拥之影，在疯狂嗜血最后3-5秒左右去咬他人，确保时间轴P2阶段不出现需要咬人的情况，以及全阶段注意自己的站位"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end


    local bossnum = 10
    do
        local npcnum = 0
        local spell = {}
        spell["召唤梦魇之门"] = 72483
        spell["扭曲梦魇"] = 71941

        spell["胆汁喷溅"] = 70633
        spell["血肉腐烂"] = 72963

        spell["镇压"] = 70588

        spell["腐蚀"] = 70751
        spell["酸性爆炸"] = 70744

        spell["寒冰箭雨"] = 70759
        spell["寒冰气旋"] = 70702
        spell["法力黑洞"] = 71086

        spell["火球术"] = 70754
        spell["损毁"] = 69326

        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            local Pnum
            local bossOnEnterText = L["团队配置建议：1T5N19DPS或2T5N18DPS\n本场战斗需要玩家将只有50%生命值的踏梦者瓦莉瑟瑞娅治疗至生命值全满，即可获得胜利。战斗开始后，瓦莉瑟瑞娅的会因为梦魇之云所困进入梦境，并受每朵梦魇之云的梦魇伤害影响，梦魇每秒造成8000点自然伤害（伤害无法被减免）。在此期间，天灾军团的怪物会源源不断的出现来干扰玩家的进程并伤害踏梦者瓦莉瑟瑞娅。顶住小怪的攻击，并完成治愈瓦莉瑟瑞娅的任务，恢复能力的瓦莉瑟瑞娅将释放踏梦者之怒来消灭所有亡灵怪物，战斗胜利"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "召唤梦魇之门"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["开战后，每45秒瓦莉瑟瑞娅在场地上召唤8个红色的梦魇之门，15秒后生成可点击的梦魇之门，生成后的梦魇之门持续存在10秒。梦魇之门仅供一人使用，玩家点击后来将其进入进梦魇位面。进入的玩家最多可以在梦魇位面中停留20秒，并且获得漂浮的能力。梦魇位面的空中漂浮遇到有12多红色球形的梦魇之云，玩家触碰到梦魇之云，即会引爆梦魇之云，使周围10码范围内的玩家获得扭曲梦魇效果（每层对玩家造成每秒200点自然伤害(普通难度没有此伤害)。此外，该目标还会每3秒回复200点法力值。目标的伤害和治疗效果同样会被提高10%。最多叠加100层。持续40s）"]
            local SpellDoneText = L["45秒/次 15秒生成时间，相当于1分钟玩家可进入梦魇位面一次。为了确保让每次进入梦魇治疗在20秒内获得更多扭曲梦魇层数，建议进入后固定一个集合位置，并安排大家进入梦魇之门后尽量跟随一个治疗，一起叠层；同时治疗注意保持身上OT，以抵消扭曲梦魇带来的伤害"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["扭曲梦魇"])
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["贪食的憎恶"]
            local Pnum
            local bossOnEnterText = L["血量：130万\n攻速：2.0\n伤害：原始伤害4.8万左右，实际伤害约1万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "胆汁喷溅"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["瞬发，正面8码；对自己当前正面释放胆汁喷溅，使目标感染疾病，对其每秒造成3750点自然伤害，并使其受到的物理伤害提高25%，持续12 秒。可驱散"]
            local SpellDoneText = L["治疗加好，并驱散疾病"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 11)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["腐蛆"]
            local Pnum
            local bossOnEnterText = L["憎恶死亡后，几秒后会在尸体内腐烂并生成7-10只腐蛆出来参与战斗"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "血肉腐烂"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["瞬发。腐蛆的近战攻击会造成血肉腐烂的效果，每1秒造成250点自然伤害，持续8秒。可叠加"]
            local SpellDoneText = L["近战不要贴脸打，法师冰环，远程AOE,血很少"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["镇压者"]
            local Pnum
            local bossOnEnterText = L["血量：15.1万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "镇压"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["瞬发，需引导。对踏梦者瓦莉瑟瑞娅引导镇压效果，使其受到的治疗效果降低10%"]
            local SpellDoneText = L["吃减速，刷新时尽量让其缓慢靠近踏梦者，并尽快击杀"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["脓疮僵尸"]
            local Pnum
            local bossOnEnterText = L["血量：30.2万\n攻速：2.0\n伤害：原始伤害5.5万左右，实际伤害约1.5万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "腐蚀"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["瞬发。每当施法者发动近战攻击时，就会每3秒对目标造成3125点自然伤害，并使目标的护甲值降低10%。该效果最多可叠加5次。持续6 秒"]
            local SpellDoneText = L["快速击杀"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "酸性爆炸"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["0.75秒施法。施法者在死亡时发起爆炸，对15码范围内的全部敌人即刻造成17672到19828点自然伤害，并在接下来的20 秒内造成每秒1250点自然伤害"]
            local SpellDoneText = L["残血的时候，坦克拉离人群并风筝，近战DPS可以转火其他小伙，让远程击杀"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["复生的大法师"]
            local Pnum
            local bossOnEnterText = L["血量：39万\n攻速：2.0\n伤害：原始伤害4.8万左右，实际伤害约1万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "寒冰箭雨"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["2秒施法。对60码范围内的所有敌方目标造成4713到5287点冰霜伤害，并使其移动速度降低50%，持续8秒。可打断，可驱散。寒冰箭在命中目标的同时还会燃烧其2828点法力值"]
            local SpellDoneText = L["能断就断，被施放了就加血和驱散"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 7)

            local spellname = "寒冰气旋"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["瞬发。标记随机1名玩家当前所在的位置。2秒后寒冰气旋从该位置喷发，对3码内的所有敌人造成17672到19828 点冰霜伤害，并使其飞上天"]
            local SpellDoneText = L["躲开，不小心被炸上天，可以开降落伞，牧师法师可以漂浮术"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "法力黑洞"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["瞬发。在随机1名玩家的当前所在位置召唤一个法力黑洞。该法力黑洞将会使半径6码范围内的所有敌人每秒燃烧掉1250点法力值。持续30秒"]
            local SpellDoneText = L["躲开"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["灼热骷髅"]
            local Pnum
            local bossOnEnterText = L["血量：35万\n攻速：2.0\n伤害：原始伤害1.2万左右，实际伤害约0.3万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "火球术"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["0.5秒施法。对一个敌人造成5891到6609点火焰伤害"]
            local SpellDoneText = L["没"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "损毁"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["瞬发，需引导。烈焰围绕施法者全身，持续12 sec，每2秒对所有敌人释放出5891 to 6609点火焰伤害"]
            local SpellDoneText = L["优先全力击杀"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 2)
        end

        -- 职责
        local text1 = L["坦克拉住刷新的小怪，择时聚怪方便DPSAOE，脓疮僵尸爆炸的时候要带离人群，自己也注意远离；注意躲避其他减益技能"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["治疗在进入翡翠梦境时应特别注意受到的DOT伤害，互相保持治疗，最好使用瞬发和HOT技能，进梦境吃梦魇之云的时候注意统一移动，尽量叠好更多的层数；出来继续治疗踏梦者和全团玩家以及注意躲避寒冰气旋 、法力黑洞等其他减益技能，奶骑圣光道标给踏梦者瓦莉瑟瑞娅；叠够层数后开爆发全力治愈踏梦者;如果有神牧给BOSS上守护之魂，并镶嵌守护之魂雕文使其CD缩短为1分钟，法师的魔法增益似乎也有一些效果"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["优先处理灼热骷髅、和镇压者；出现复生的大法师记得打断技能并全力输出。注意躲避其他减益技能"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["全力输出，躲避大法师的寒冰气旋和法力黑洞；优先击杀灼热骷髅并躲避其他减益技能"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end


    local bossnum = 11
    do
        local npcnum = 0
        local spell = {}
        spell["冰霜光环"] = 70084
        spell["顺劈斩"] = 19983
        spell["尾击"] = 71077
        spell["冰霜吐息"] = 69649

        spell["蚀骨之寒"] = 70109
        spell["寒霜刺骨"] = 70106

        spell["狂咒"] = 69762
        spell["动荡"] = 69766

        spell["冰冷之握"] = 70117
        spell["严寒"] = 70123

        spell["冰霜道标"] = 70126
        spell["寒冰坟墓"] = 70157
        spell["窒息"] = 71665
        spell["冰霜炸弹"] = 69845

        spell["秘法打击"] = 70127

        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            local Pnum
            local bossOnEnterText = L["团队配置建议：2T7N16DPS或2T8N15DPS\nBOSS分3个阶段。100%-35%时BOSS会在地面（P11分钟）和空中（P250秒）来回切换，35%-0%为P3阶段，不再上天\n\n攻速：1.5\n伤害：实际伤害约3.2万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "冰霜光环"
            spellnum = spellnum + 1
            local Pnum = "P1/P3"
            local SpellInfoText = L["光环技能，每3秒对附近的所有敌人造成6000点冰霜伤害"]
            local SpellDoneText = L["建议全团装备一两件冰抗装。满BUFF有个300+冰抗，这个技能的难度就少很多了"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "顺劈斩"
            spellnum = spellnum + 1
            local Pnum = "P1/P3"
            local SpellInfoText = L["瞬发，5码。下一次近战攻击对当前目标和它身边最近的敌人造成武器伤害再加50点伤害，最多可影响10个目标"]
            local SpellDoneText = L["非独立技能，作为下一次近战攻击代替普攻。不出出现普攻+顺劈斩连造出现"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "尾击"
            spellnum = spellnum + 1
            local Pnum = "P1/P3"
            local SpellInfoText = L["1秒施法，45码。对尾击效果点周围20码内的敌人造成11250到18750点物理伤害，并将其击退。龙类的常规技能"]
            local SpellDoneText = L["远离尾部，近战在侧翼和前爪之间站位输出即可"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "冰霜吐息"
            spellnum = spellnum + 1
            local Pnum = "P1/P3"
            local SpellInfoText = L["1.5秒施法，20秒冷却。辛达苟萨对其面前半径60码范围的一个90度锥形范围内的所有玩家造成55500到64500点冰霜伤害。另外，目标的攻击速度降低50%，移动速度降低15%（P3不会降低移速），持续1.5分钟（P3为10秒）。可叠加6次。DEBUFF无法驱散。冰霜吐息后会重置普攻时间"]
            local SpellDoneText = L["这里建议坦克要堆叠一些冰抗属性，例如：冰霜抗性光环 + 次级抗性合剂 + 附魔-结霜之魂秘药 + 附魔披风-超强冰霜抗性 + 预兆禁锢之戒，锻造的破冰战靴，基本有300左右的抗性就很不错了。坦克的减伤技能可以看好时机覆盖，但确保在P3阶段技能CD可用，这里骑士的牺牲之手，牧师压制，光环掌握都可以覆盖。骑士的自由之手、人类的生存意志和侏儒的逃命专家可解除DEBUFF的移动效果的限制"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 3)

            local spellname = "蚀骨之寒"
            spellnum = spellnum + 1
            local Pnum = "P1/P3"
            local SpellInfoText = L["使对辛达苟萨进行物理攻击的敌人有20%的几率受到寒霜刺骨效果的影响，每叠加一层该魔法效果就会使目标每2秒受到1000点冰霜伤害。持续8秒"]
            local SpellDoneText = L["近战叠满5-6层时按esc暂停攻击，坦克4层差不多就要停手等消除了。当然也可根据团队自身情况做些调整。应付冰龙最佳坦克是死亡骑士，其技能攻击不容易触发物理攻击，其次受到冰霜吐息的减攻影响，基本上很少可以叠到4层"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["寒霜刺骨"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 2)

            local spellname = "狂咒"
            spellnum = spellnum + 1
            local Pnum = "P1/P3"
            local SpellInfoText = L["瞬发，30秒冷却（P3为80秒冷却）。对6名玩家释放奥术邪咒，使其在接下来的30秒内每释放1次法术都会叠加1层动荡效果。狂咒总是会根据玩家的天赋来优先选择3名法系输出加3名治疗。在受到狂咒效果影响时使用法术会积聚不稳定的动荡效果。动荡效果持续5秒，每次施放法术会叠加1层动荡，每次叠加会刷新持续时间。当持续时间结束时，动荡效果会根据累加的层数瞬间结算，每1层动荡效果会对施法者自身以及20码范围内的盟友造成2000点奥术伤害"]
            local SpellDoneText = L["点名后按团队职责安排远离人群，并根据时间轴可适当施法，但是不要超过5层，另外第一次点名狂咒，之后会有一次冰冷之握，注意看好时间轴，确保在冰冷之握到来之前释放掉动荡，不然会炸大团了。如果反应跟不上，建议中狂咒就不要输出了，冰龙这个BOSS可以慢慢磨死"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["动荡"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 2)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 3)

            local spellname = "冰冷之握"
            spellnum = spellnum + 1
            local Pnum = "P1/P3"
            local SpellInfoText = L["瞬发，100码，1分钟冷却。用寒风席卷周围视野内的所有敌人，将其拉到施法者面前。然后开始读条严寒：5秒施法。对半径25码范围内的敌人造成60000点冰霜伤害"]
            local SpellDoneText = L["确保技能释放之前不要有AOE伤害带入团队，集合后马上远离BOSS，迎接5秒后的严寒技能的到来。由于坦克需要固定BOSS位置，因此可在此阶段交一些减伤技能；术士的语言诅咒有效，可用于P3阶段，增强坦克的生存压力"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["严寒"])

            local spellname = "冰霜道标"
            spellnum = spellnum + 1
            local Pnum = "P2"
            local SpellInfoText = L["瞬发。进入P2辛达苟萨飞向空中的用魔法球标记6名玩家，持续7秒，时间结束时，朝带有冰霜道标的玩家投掷冰霜炸弹，对其及周围10码范围内的所有玩家造成15600到16400点冰霜伤害，并将其冻入寒冰坟墓（45万血量）。被冻结的玩家将陷入深度昏迷，不会受到其他伤害。但也无法被外界玩家选中。被寒冰坟墓冻结25秒后，还被冻结在寒冰坟墓中的玩家会因缺氧而窒息，每秒损失总生命值的8%。其他玩家可以打破寒冰坟墓来救出被冻结的玩家。"]
            local SpellDoneText = L["以两两为一组，并根据战前位置安排，相互保持10码间距；同时治疗应提前刷满血量并保持HOT，在25秒后，被冰冻玩家可根据情况交减伤技能。攻击寒冰坟墓节奏，应当保证四次冰霜炸弹结束后可以破冰，当确保不要提前，以免没有寒冰坟墓来抵挡冰霜炸弹"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["寒冰坟墓"], spell["窒息"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "冰霜炸弹"
            spellnum = spellnum + 1
            local Pnum = "P2"
            local SpellInfoText = L["瞬发。释放完寒冰坟墓之后，在空中的辛达苟萨会依次朝场地上的随机位置投掷4次冰霜炸弹，相隔7秒。每次冰霜炸弹落地后的爆炸对视野内所有玩家造成188500到211500点冰霜伤害。玩家每次可以通过寒冰坟墓来躲避冰霜炸弹的视野，从而规避此次伤害"]
            local SpellDoneText = L["只要玩家确保自己位于，炸弹--冰墓--自己，保持三点一线站位即可安全躲避"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "秘法打击"
            spellnum = spellnum + 1
            local Pnum = "P3"
            local SpellInfoText = L["瞬发，6秒冷却。辛达苟萨每6秒释放一次奥术能量波，使所有视野内的玩家被秘法打击影响，持续8秒。可叠加。每1层秘法打击会使目标受到的魔法伤害提高20%"]
            local SpellDoneText = L["2-3层躲在冰墓后面消层。坦克在8-9层左右换嘲"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "冰霜道标"
            spellnum = spellnum + 1
            local Pnum = "P3"
            local SpellInfoText = L["跟P2技能的区别是：每次只会点名一名玩家，每15秒施放一次"]
            local SpellDoneText = L["冰墓位置确保远离BOSS25码，P3冰墓只有一个，被冰霜道标点名玩家被冰冻之前，其他玩家远离10码。由于躲在冰墓后面的玩家不在BOSS的视野范围之内，所以吃不到6秒一次的秘法打击，我们可以借助冰墓的存在来抵消团队的秘法打击层数。为了避免过早破冰，建议专门安排2-4名DPS专门输出冰墓，只要在15秒内打破即可，根据计算DPS3万即可，注：寒冰坟墓同时影响治疗与治疗目标的视野。这里的坦克治疗应当轮流来处理秘法打击"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["寒冰坟墓"], spell["窒息"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)
        end

        -- 职责
        local text1 = L["开战时，快速跑位，将坦克定在中间位置，确保后续站位不乱；确保自己的减伤技能CD，能覆盖P3阶段；P3阶段的每次吐息要覆盖减伤。寒霜刺骨层输高的时候注意esc 消一下；和副坦商量好秘法打击嘲讽层数，并且在非坦阶段躲在寒冰坟墓后面消层"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["开战时远程和治疗集中站，中狂咒后左右按安排左右两边分散20码站位并消除动荡后方可集合；P2转阶段给坦克消减速debuff，并给冰霜道标点名的玩家刷满血，自己注意躲好炸弹；P3阶段注意自己秘法打击的叠层，和其他治疗商量好相互配合消层时间，防止坦克断治疗，P3按事先安排为主坦每次吐息覆盖减伤。并注意在寒冰坟墓时自己的视野，不要卡视野断治疗"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["站在冰龙的侧面前爪之间，避免吃到吐息和顺劈斩；不要让自己的寒霜刺骨层数太高，6-8层就停手消一下，有减伤技能也可以覆盖；P2阶段注意好自己是否被点名，寒冰坟墓确保4次寒冰炸弹后打破；P3阶段3层秘法打击左右可以利用寒冰坟墓来消层，同时可以清理寒霜刺骨"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["开战时远程和治疗集中站，中狂咒后左右按安排左右两边分散20码站位并消除动荡后方可集合；P2阶段注意好自己是否被点名，寒冰坟墓确保4次寒冰炸弹后打破；P3阶段中狂咒不要有技能动作，3层秘法打击左右可以利用寒冰坟墓来消层"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end


    local bossnum = 12
    do
        local npcnum = 0
        local spell = {}
        spell["寄生"] = 70541

        spell["死疽"] = 70337
        spell["热病虹吸"] = 74074

        spell["召唤暗影陷阱"] = 73539

        spell["冷酷严冬"] = 68983
        spell["饱受折磨"] = 72133

        spell["召唤寒冰之球"] = 36633
        spell["寒冰脉冲"] = 69099
        spell["寒冰爆裂"] = 69108

        spell["污染"] = 72754
        spell["灵魂收割"] = 69409
        spell["寒冰脉冲"] = 69099

        spell["收割灵魂"] = 73654
        spell["收割灵魂内场"] = 73655

        spell["激怒"] = 72143
        spell["震荡波"] = 72149
        spell["狂乱"] = 28747

        spell["灵魂尖啸"] = 69242

        spell["诅咒之翼"] = 74352
        spell["生命虹吸"] = 73488

        spell["灵魂爆裂"] = 70503


        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            local Pnum
            local bossOnEnterText = L["团队配置建议：2T5N18DPS\n该BOSS分3个阶段。P1：100%-70%，转接段：1分钟，P2：70%-40%，转接段：1分钟，P3：40%-10%\n\n攻速：1.5\n伤害：原始伤害17.5万左右，实际伤害约3.5万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "寄生"
            spellnum = spellnum + 1
            local Pnum = "P1/P2"
            local SpellInfoText = L["2秒施法，20秒冷却，巫妖王会对所有玩家造成17672到19828点暗影伤害。此外，目标还会受到每秒提升的暗影伤害（2500点暗影伤害左右）。该效果会在目标的生命值超过90%后消失"]
            local SpellDoneText = L["牧师提前给团队套盾，治疗快速抬血即可"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "死疽"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["瞬发，30秒冷却；随机点名一个目标使其承受致命效果，每5秒对其造成150000点暗影伤害，持续15秒。如果目标在承受此效果时死亡，或者此效果结束，该效果会额外叠加一层并转移到附近的一名单位身上。如果效果被驱散，则该效果会减少一层并转移到附近的一名单位身上。每当这一效果转移的时候，巫妖王的力量都会提升获得热病虹吸的效果"]
            local SpellDoneText = L["P1阶段的核心机制。被点名玩家5秒内跑到副坦位，并在5秒内驱散疾病，确保疾病传染到小怪身上。由于dps问题，玩家必须让死疽感染到小怪身上，不然小怪会出现无法清理的处理干净的情况"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 11)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "热病虹吸"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["巫妖王从死疽的传染中获得力量，造成的物理伤害提高2%，持续30秒，可叠加。每次死疽传染的时候，都会多叠加1层"]
            local SpellDoneText = L["这其实是一个压缩DPS技能，团队必须尽快击杀巫妖王进入P2，不然后面的死疽传染次数会越来越多，层数到达20-25层，巫妖王可能一刀秒坦"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "召唤暗影陷阱"
            spellnum = spellnum + 1
            local Pnum = "P1"
            local SpellInfoText = L["0.5秒施法，15秒冷却。60码范围内随机对一名玩家脚下扔一个暗影陷阱，陷阱落地后5秒触发生成1个半径5码的暗影陷阱。任意玩家触碰成形的暗影陷阱都会导致其发生爆炸。对周围10码范围内的所有敌人造成23563到26437点暗影伤害，并将他们远远击退。基本会击飞出场地，还无法复活"]
            local SpellDoneText = L["点名跑开即可，如果点的是近战，坦克要拉着巫妖王移动"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 4)

            local spellname = "冷酷严冬"
            spellnum = spellnum + 1
            local Pnum = "转阶段"
            local SpellInfoText = L["当生命值70%时，巫妖王会跑到场地的中心，制造一场猛烈的寒冬风暴，对半径45码之内的所有敌人每秒造成14138 to 15862点冰霜伤害。持续1分钟"]
            local SpellDoneText = L["刚好站地图纹理边缘即可"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "饱受折磨"
            spellnum = spellnum + 1
            local Pnum = "转阶段"
            local SpellInfoText = L["0.5秒施法，随机选定一名玩家，对目标面前的锥形区域内所有玩家造成7540 to 8460点暗影伤害。而且目标还会每秒承受1200点暗影伤害，持续3秒"]
            local SpellDoneText = L["转阶段期间，远程和治疗两边分散，远离坦克和近战；治疗团血刷好"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "污染"
            spellnum = spellnum + 1
            local Pnum = "P2/P3"
            local SpellInfoText = L["每30秒随机点名一名玩家，3秒施法后污染目标脚下的区域，生成一个暗影能量的污点。任何在此区域内的玩家会每1秒受到10000点暗影伤害。一旦有玩家受到污染的伤害，污染区域的面积会每秒翻倍，每次尺寸增加都会增加500点暗影伤害。每个污点30秒后消失"]
            local SpellDoneText = L["污染技能是本阶段的核心机制，被点名玩家要第一时间跑出人群，并在其脚下生成污点后快速离开，这个时候不要犹豫你的火箭靴。其他玩家第一时间分散躲开，如果多名玩家被困在“污染”中，它的大小可能会比玩家逃离的速度更快，迅速失控，最终填满整个平台并导致灭团。注意离开污点请不要按空格跳跃，这会让系统判定你没有在移动"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "灵魂收割"
            spellnum = spellnum + 1
            local Pnum = "P2/P3"
            local SpellInfoText = L["瞬发，5码，每30秒挥舞霜之哀伤攻击目标，造成50%的武器伤害，并使其受到灵魂收割的效果影响。该效果会在5 秒后对目标造成70000点暗影伤害，并使巫妖王的近战急速等级提高100%，持续5 秒"]
            local SpellDoneText = L["短时间内由于高额的承伤，再加上巫妖王急速100%5秒的高爆发，此阶段容易倒坦，我们应该安排一名副坦嘲讽，嘲讽的坦克还应该安排减伤链接怪，安排好骑士的“牺牲之手”、“神圣守护者”、“光环掌握”、“痛苦压制”、“守护之魂”‘，坦克自身防御技能建议先留着。如果团队带了防战，这里作为副坦吃灵魂收割就很不错了"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)

            local spellname = "收割灵魂"
            spellnum = spellnum + 1
            local Pnum = "P3"
            local SpellInfoText = L["瞬发，引导技能，1分45秒冷却。巫妖王会高举霜之哀伤尝试收割附近所有玩家的灵魂，玩家进入昏迷状态并缓慢拉入霜之哀伤位面（俗称剑内），这个过程每秒钟对玩家造成4000点暗影伤害持续6秒，合计2.4万。如果目标在法术效果结束以后还活着，他的灵魂就会被吸入霜之哀伤，被这把魔剑吞噬。进入内场后玩家会受到一个光环技能收割灵魂影响，每秒造成2000点暗影伤害，同时内场还会生成一定数量的卑劣的灵魂亡灵怪，漂浮在空中，一定时间后缓慢飞向玩家，如果接触到玩家后会发生爆炸。如果玩家在内场死亡，外场巫妖王还将获得一层收割灵魂的BUFF（使巫妖王的体型增大50%，造成的伤害提高500%，持续15秒。可叠加）。玩家如果在这段时间内存活下来，那么仍然存活的每个玩家都将被传送回到巫妖王平台继续战斗"]
            local SpellDoneText = L["被控前保持全团满血。进入后玩家先在中间集合，远程迅速处理空中的小怪。5秒后大团集合统一移动到边缘，走一下处理一波灵魂后再移动一下，优先处理快靠近的灵魂。内场战斗只要行动一致，压力并不大"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum, spell["收割灵魂内场"])
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["食尸鬼苦工"]
            local Pnum = "P1"
            local bossOnEnterText = L["0.5秒引导施法，30秒冷却。巫妖王开始召唤食尸鬼苦工，每秒在身边召唤1只食尸鬼苦工出来参与战斗，持续3秒。也就是说每波3只。该小怪无任何技能\n\n血量：75万\n攻速：2.0\n伤害：实际伤害约2千"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["蹒跚的血僵尸"]
            local Pnum = "P1"
            local bossOnEnterText = L["1秒施法，1分钟冷却。巫妖王开始在身边召唤1只蹒跚的血僵尸出来参与战斗\n\n血量：600万\n攻速：2.0\n伤害：实际伤害约2.3万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "激怒"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["1秒施法。进入激怒状态，造成的物理伤害提高200%。持续5秒。可驱散"]
            local SpellDoneText = L["安排猎人第一时间宁静"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "震荡波"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["1.25秒施法。向前方释放出强大的能量波，对你面前半径20码范围内的正面锥形区域中的所有敌方目标造成150%的武器伤害"]
            local SpellDoneText = L["坦克注意让小怪背对人群"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)

            local spellname = "狂乱"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["当蹒跚的血僵尸的生命值低于20%时，他会进入狂乱状态。攻击速度提高50%，对敌人造成的物理伤害提高100%，持续10分钟"]
            local SpellDoneText = L["低于20%血量时，优先转火"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 4)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["寒冰之球"]
            local Pnum = "转接段"
            local bossOnEnterText = L["瞬发。巫妖王在其身边召唤1颗寒冰之球。寒冰之球出现后，会随机连线一名玩家并朝其缓慢移动，并对点名玩家释放寒冰脉冲。当寒冰之球触碰到连线玩家时，对其释放寒冰脉冲\n\n血量：5.4万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "寒冰脉冲"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["对点名玩家释放寒冰脉冲，对其附近半径5码内的所有敌人造成7540 to 8460点冰霜伤害"]
            local SpellDoneText = L["远离被点名的玩家"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)

            local spellname = "寒冰爆裂"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["瞬发，当寒冰之球接触到玩家，将对10码范围内的所有敌人造成28275 to 31725点冰霜伤害，并将其击退"]
            local SpellDoneText = L["安排远程优先击杀，尤其猎人是VIP"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["暴怒的灵魂"]
            local Pnum = "转接段"
            local bossOnEnterText = L["巫妖王随机扯下一片目标的灵魂，在其身边召唤一个暴怒的灵魂出来参与战斗，使其攻击玩家。\nP1-P2阶段转换，会召唤3个，P2-P3会召唤4个。坦克拉住并背对大团，转阶段DPS最大的压力尽快击杀，开荒初期会有可能因为DPS不足带入P2\n\n血量：415万\n攻速：2.0\n伤害：实际伤害约2.6万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "灵魂尖啸"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["对施法者面前15码内的锥形区域中的所有敌人造成42413到47587点暗影伤害，并使其沉默5秒。可驱散"]
            local SpellDoneText = L["坦克注意让小怪背对人群"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 1)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 8)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["瓦格里暗影戒卫者"]
            local Pnum = "P2"
            local bossOnEnterText = L["瞬发，45秒冷却。巫妖王在其上空召唤3只瓦格里暗影戒卫者。每轮新召唤的瓦格里都会冲向并分别抓起随机1名玩家。之后，瓦格里会寻找距离平台边缘最短的路径缓慢飞行。当飞出平台边缘后，他们会将被抓的玩家扔下平台导致其掉落虚空。如果玩家将其生命值打到50%，瓦格里就会扔下被抓的玩家并返回空中并释放生命虹吸技能。之后它们会停留在空中继续参与战斗\n\n血量：300万\n攻速：未知\n伤害：伤害很低"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "诅咒之翼"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["巫妖王赋予的力量使得瓦格里暗影戒卫者无法被减速至普通速度的50%以下"]
            local SpellDoneText = L["此阶段巫妖王应当尽量啦在中间位置，大团应当统一站另外一边，这样可以让瓦格里朝同一个方向飞行；方便集合AOE和击晕，这里骑士的神圣愤怒，制裁之锤、萨满的地束图腾，战士的刺耳，DK的冰链都可以。术士的传送门、猎人的逃脱都可以在被瓦格里丢下之后回到平台；他们只要站在和大团相同方向的一边即并不需要集合。因为我们需要他们来当沙包，抓他们的瓦格里团队可以不用处理，省下DPS来输出巫妖王"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

            local spellname = "生命虹吸"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["2秒施法。对一个敌人造成4625到5375点暗影伤害，并让施法者获得十倍于伤害量的生命值"]
            local SpellDoneText = L[""]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 4)
        end
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = L["卑劣的灵魂（外场）"]
            local Pnum = "P3"
            local bossOnEnterText = L["0.5秒读条，5秒引导施法，30秒冷却。巫妖王在其上空陆续创造10个卑劣的灵魂。它们会在空中徘徊30秒，之后飞向玩家，随着它们靠近，它们的高度会降低，接触到玩家发生灵魂爆裂，造成5码范围内的所有玩家承受35100 to 36900点暗影伤害\n\n血量：180万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = "灵魂爆裂"
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L["瞬发。卑劣的灵魂牺牲自己，让5码范围内的所有玩家承受35100 to 36900点暗影伤害"]
            local SpellDoneText = L["大团应当利用场地，先将巫妖王拉到平台边缘，当召唤卑劣的灵魂后，移动到平台的对面边缘。在卑劣的灵魂和距离大团10码以上的位置放置猎人的冰箱陷阱，灵魂会越靠近玩家飞的越低，当快接近玩家时，基本以触及地面，因此可触发陷阱产生减速效果，保险期间，萨满可以单独再插一根地束图腾。当接触陷阱和临近大团后，可安排副坦开技能慢慢引爆，同时，暗牧的消散，骑士的圣盾术，盗贼的斗篷，都可以引爆所有卑劣的灵魂。在第三轮灵魂时，因为时间刚好巫妖王要施放收割灵魂，因此，坦克一定要提前带离大团远离刚刷新的卑劣的灵魂，防止下一轮从内场出来后直接被炸导致灭团。这个循环持续1分钟，巫妖王将再次释放收割灵魂技能，拉玩家进入内场"]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
            BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)
        end

        -- 职责
        local text1 = L["注意将巫妖王背对大团，并注意近战位的暗影陷阱以及污染，P1监控巫妖王的热病虹吸叠层，在10-15层开始覆盖减伤；小怪坦同样注意背对大团，并且确保小怪不要离大团太远，保持12-15左右即可，方便吃到瘟疫伤害，P2/P3灵魂收割时换嘲注意技能覆盖，以防止秒坦"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L["P1当中了死疽的玩家靠近副坦克时驱散，P2/P3中了污染第一时间跑出人群，P2/P3注意协调好坦克灵魂收割的减伤"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L["P1中了死疽马上靠近副坦克，不要毛P1小怪的伤害，P2/P3中了污染第一时间跑出人群，全程处理小怪时不要站在正面"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L["P1中了死疽马上靠近副坦克，不要毛P1小怪的伤害，转阶段优先打冰球，P2/P3中了污染第一时间跑出人群。P3内场时，优先处理靠近大团的卑劣的灵魂"]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)
    end
end)

--[[
    local bossnum = 4
    do
        local npcnum = 0
        local spell = {}
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0
        spell["鲜血连接"] = 0

        -- NPC
        do
            npcnum = npcnum + 1
            local spellnum = 0

            -- 名字
            local npcname = BG.Boss["ICC"]["boss" .. bossnum].name2
            local Pnum
            local bossOnEnterText = L["团队配置建议：2T5N18DPS\n\n攻速：1.5\n伤害：原始伤害8万左右，实际伤害约1.9万"]
            BG.CreateBossSpellFrameNpc(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, npcname, bossOnEnterText, Pnum)

            -- 技能
            local spellname = ""
            spellnum = spellnum + 1
            local Pnum
            local SpellInfoText = L[""]
            local SpellDoneText = L[""]
            BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame,
                npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText, Pnum)
        end

        -- 职责
        local text1 = L[""]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 1, text1)
        local text1 = L[""]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 2, text1)
        local text1 = L[""]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 3, text1)
        local text1 = L[""]
        BG.CreateBossClassFrame(BG.BossFrameICC["Boss" .. bossnum].classFrame, 4, text1)

    end

        BG.CreateBossSpellTisIcon(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, 6)

    local icons = {
        L["坦克预警"], -- 1
        L["输出预警"], -- 2
        L["治疗预警"], -- 3
        L["英雄难度"], -- 4
        L["灭团技能"], -- 5
        L["重要"], -- 6
        L["可打断技能"], -- 7
        L["法术效果"], -- 8
        L["诅咒"], -- 9
        L["中毒"], -- 10
        L["疾病"], -- 11
    }
]]
