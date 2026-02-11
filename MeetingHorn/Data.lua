local ns = select(2, ...)

local factionGroup = UnitFactionGroup("player")
local function GetUnitFactionGroupIcon()
    if factionGroup == "Alliance" then
        return '1390441'
    end
    return '1390442'
end
local function GetUnitFactionGroupName()
    if factionGroup == "Alliance" then
        return '部落'
    end
    return '联盟'
end

local function BuildSpellLink(id)
    local link = GetSpellLink(id)
    if link then
        return gsub(link, "|cff%x%x%x%x%x%x", "|cff4151c9");
    end
    return nil
end


local ENCOUNTER_BOSSES = {
    [1107] = {
        bossId = 1107,
        abilities = {
            children = {
                {
                    spell = '28783',
                    title = '穿刺',
                    noCollapse = false,
                    expanded = false,
                    desc = '随机朝一个方向释放穿刺对路线上的人造成伤害，并击飞同一直线方向上的玩家。',
                },
                {
                    spell = '28785',
                    title = '虫群风暴',
                    noCollapse = false,
                    expanded = false,
                    desc = '战斗开始后，每隔一段时间BOSS会释放出一簇虫群，使BOSS移动速度降低并对附近玩家造成伤害且伤害会叠加，BOSS移动过程中范围内玩家无法施法，持续20秒。',
                },
                {
                    title = '召唤地穴卫士',
                    noCollapse = false,
                    expanded = false,
                    desc = 'BOSS在释放虫群风暴同时会召唤一只地穴卫士（精英怪）。',
                },
                {
                    title = '召唤甲虫',
                    noCollapse = false,
                    expanded = false,
                    desc = '随机从地穴卫士尸体或玩家的尸体上召唤出甲虫。',
                },
            },
            desc = '阿努布雷坎会释放虫群风暴，期间会使范围内玩家受到大量伤害，但是BOSS移动速度会降低，需要主T在虫群风暴期间拉着BOSS跑，直到技能结束。',
        },
        zone = 1,
        summary = {
            children = {
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    战斗开始后先击杀地穴卫士，然后再输出BOSS。\n2.    虫群风暴期间远离BOSS，击杀召唤出来的地穴卫士。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    战斗开始后先击杀地穴卫士，之后于场地左半边分散站位，最远距离输出BOSS。\n2.    虫群风暴期间远离BOSS，优先击杀召唤出来的地穴卫士。\n3.    法师尽量靠近地穴卫士尸体分散站位，在甲虫被召唤出来之后第一时间轮流冰环，控制后击杀。\n4.    安排接应主T的猎人，站在场地右边输出，虫群风暴后开启豹群接应主T，确保自己和主T不会吃到虫群风暴。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    开战后，主T需要将BOSS拉在房间最里面的角落上。\n2.    在BOSS释放虫群风暴时，主T沿着房间右边的水沟风筝BOSS，保持一定距离不受虫群伤害，也需要确保BOSS沿着水沟移动远离其他玩家，在虫群风暴结束后将BOSS拉至房间入口处。第二轮虫群风暴开始时沿原路风筝BOSS回到最里面的角落，一直循环即可。\n3.    副T在战斗开始后拉住BOSS边上的地穴卫士，将精英怪拉至房间左边，靠近水沟处击杀，地穴卫士死亡位置尽量靠在一起。后续召唤的地穴卫士都需要副T拉住并击杀于同一位置。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    战斗开始后在场地中间分散站位治疗。\n2.    治疗好被穿刺的玩家，确保其在掉落地面时不会被摔死。\n3.    虫群风暴开始后往场地左边移动，远离BOSS，随时注意主T的血量。',
                },
            },
            desc = '阿努布雷坎整场战斗远程远离BOSS输出，优先击杀小怪，近战虫群风暴时远离BOSS，治疗需要在虫群时最远距离治疗坦克，确保不会被沉默，所有人分散站位躲开地刺范围。',
        },
        icon = '1378964',
        name = '阿努布雷坎',
    },
    [1108] = {
        bossId = 1108,
        summary = {
            children = {
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    和远程一起集中站位治疗。\n2.    BOSS残杀后第一时间刷好T的血量，然后再刷满全团的血。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    进入战斗后输出BOSS。\n2.    残杀后优先击杀小僵尸，阻止僵尸靠近BOSS。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    进入战斗后集中站位，最远距离输出BOSS。\n2.    残杀后优先控制击杀小僵尸。\n3.    LR打好宁神。分配好的远程辅助副T风筝小僵尸，例如猎人冰霜陷阱等。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    主T将BOSS拉至门口位置，副T一起制造仇恨。主T身上重伤叠加层数过高时副T接手。\n2.    拉小僵尸的T在残杀前风筝好小僵尸，使得小僵尸远离BOSS，残杀结束后继续拉住新出现的小僵尸仇恨。',
                },
            },
            desc = '格拉斯战斗除了拉BOSS的两位坦克不断替换外，风筝小僵尸的也需要在残杀之前控制好小僵尸，残杀后治疗优先加满坦克，输出们优先击杀小僵尸。',
        },
        zone = 4,
        name = '格拉斯',
        icon = '1378977',
        abilities = {
            children = {
                {
                    spell = '54378',
                    title = '致命伤',
                    noCollapse = false,
                    expanded = false,
                    desc = '对主T释放，造成伤害并附加受到治疗效果减少10%的debuff，可叠加。',
                },
                {
                    spell = '28317',
                    title = '激怒',
                    noCollapse = false,
                    expanded = false,
                    desc = '每30秒释放一次，攻击速度提高100%，持续8秒，可驱散。',
                },
                {
                    spell = '29307',
                    title = '感染之伤',
                    noCollapse = false,
                    expanded = false,
                    desc = '小僵尸每次攻击使目标受到的伤害提高，可叠加。',
                },
                {
                    spell = '28374',
                    title = '残杀',
                    noCollapse = false,
                    expanded = false,
                    desc = '每隔一段时间，会把BOSS房间内任何玩家和小怪的血量都降低至5%。此时小僵尸会无视仇恨走向BOSS。',
                },
            },
            desc = '格拉斯战斗开始后，房间井口附近会不断刷新小僵尸，在残杀后，小僵尸会无视仇恨走向BOSS，BOSS会吞噬靠近自己的僵尸，每吞噬一只恢复BOSS 5%的血量。',
        },
    },
    [1109] = {
        bossId = 1109,
        summary = {
            children = {
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    T在面对BOSS的左边房间的三个台子边站位，开始先拉死亡骑士仇恨，在骑兵出来后拉住骑兵仇恨，死亡骑士由牧师锁住。\n2.    BOSS下楼后会在2个房间内传送， T注意拉住BOSS。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    在面对BOSS的左边房间时和远程站在一起，治疗好全团；亡灵怪出现时，最远距离治疗。\n2.    BOSS下楼后加好T。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    优先击杀骑兵和死亡骑士，亡灵小怪出现后骑士可以上去施展神圣愤怒。\n2.    BOSS下楼后全力输出BOSS。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    优先击杀骑兵和死亡骑士，亡灵小怪出现后法师冰环控制怪，远距离下暴风雪处理掉。\n2.    BOSS下楼后全力输出BOSS。',
                },
            },
            desc = '收割者戈提克战斗开始，所有人都站在面对BOSS的左边房间，击杀完所有小怪之后中间的门开启，法师和骑士控制右边房间冲出来的亡灵怪，控制好之后A掉即可。',
        },
        zone = 3,
        name = '收割者戈提克',
        icon = '1378979',
        abilities = {
            children = {
                {
                    title = '左边房间',
                    children = {
                        {
                            title = '冷酷的学徒',
                            noCollapse = false,
                            expanded = false,
                            children = {
                                {
                                    spell = '55604',
                                    title = '死亡疫病',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '每3秒造成自然伤害。',
                                },
                            },
                        },
                        {
                            title = '冷酷的死亡骑士',
                            noCollapse = false,
                            expanded = false,
                            children = {
                                {
                                    spell = '27825',
                                    title = '暗影遮罩',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '攻击附近的敌人造成武器伤害。',
                                },
                            },
                        },
                        {
                            title = '冷酷的骑兵',
                            noCollapse = false,
                            expanded = false,
                            children = {
                                {
                                    spell = '27831',
                                    title = '暗影箭雨',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '对周围玩家释放多支暗影箭，造成暗影伤害。',
                                },
                                {
                                    spell = '55606',
                                    title = '邪恶光环',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '每3秒对所有附近玩家造成暗影伤害。',
                                },
                            },
                        },
                    },
                    noCollapse = false,
                    expanded = true,
                    desc = '小怪只会刷新在3个平台上',
                },
                {
                    title = '右边房间',
                    children = {
                        {
                            title = '鬼灵学徒',
                            children = {
                                {
                                    spell = '27989',
                                    title = '魔爆术',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '对附近玩家造成奥术伤害。',
                                },
                                {
                                    spell = '27990',
                                    title = '群体恐惧',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '恐惧范围内的玩家，持续4秒。',
                                },
                            },
                            noCollapse = false,
                            expanded = false,
                            desc = '由冷酷的学徒复活而来',
                        },
                        {
                            title = '鬼灵死亡骑士',
                            children = {
                                {
                                    spell = '56408',
                                    title = '旋风斩',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '对周围玩家造成物理伤害。',
                                },
                            },
                            noCollapse = false,
                            expanded = false,
                            desc = '由冷酷的死亡骑士复活而来',
                        },
                        {
                            title = '鬼灵骑兵',
                            children = {
                                {
                                    spell = '55606',
                                    title = '邪恶光环',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '每3秒对所有附近玩家造成暗影伤害。',
                                },
                                {
                                    spell = '27994',
                                    title = '吸取生命',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '从目标身上吸取生命值转移给施法者。',
                                },
                            },
                            noCollapse = false,
                            expanded = false,
                            desc = '由冷酷的骑兵复活而来，会形成鬼灵骑兵和鬼灵战马2种',
                        },
                        {
                            title = '鬼灵战马',
                            children = {
                                {
                                    spell = '27993',
                                    title = '践踏',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '对周围玩家造成物理伤害且降低移动速度。',
                                },
                            },
                            noCollapse = false,
                            expanded = false,
                            desc = '由冷酷的骑兵复活而来，会形成鬼灵骑兵和鬼灵战马2种',
                        },
                    },
                    noCollapse = false,
                    expanded = true,
                    desc = '会在随机骨堆上复活三种小怪的灵魂形态',
                },
                {
                    title = '收割者戈提克',
                    noCollapse = false,
                    expanded = true,
                    children = {
                        {
                            spell = '29317',
                            title = '暗影箭',
                            noCollapse = false,
                            expanded = false,
                            desc = '对当前目标释放，造成大量暗影伤害。',
                        },
                        {
                            spell = '28679',
                            title = '收割灵魂',
                            noCollapse = false,
                            expanded = false,
                            desc = '对所有玩家释放，使得属性降低10%，持续60秒，每隔一段时间释放一次，可叠加。',
                        },
                        {
                            spell = '35517',
                            title = '传送',
                            noCollapse = false,
                            expanded = false,
                            desc = 'BOSS每隔30秒会在左右两个房间内传送。',
                        },
                    },
                },
            },
            desc = '收割者戈提克自身难度不大，这场战斗主要是需要处理好BOSS下楼前的小怪。BOSS房间被分割为两部分，战斗开始中间门会关闭，变成2个独立的区域，在面对BOSS的左边房间被击杀的小怪会在右边房间复活。小怪被击杀完之后BOSS下楼，会并在两个房间内传送。',
        },
    },
    [1110] = {
        bossId = 1110,
        summary = {
            children = {
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    战斗开始后优先击杀2个追随者，随后输出BOSS，注意躲避火雨，10人模式下需要在BOSS狂乱时击杀一个膜拜者。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    战斗开始后优先击杀2个追随者，随后输出BOSS，10人模式下需要在BOSS狂乱时击杀一个膜拜者。\n2.    分散站位，躲好火雨。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    开战后主T将BOSS拉在平台中间，注意躲避火雨。\n2.    其余6个小怪需要副T拉住，优先击杀追随者。\n3.    拉住膜拜者的副T站在台子的附近， BOSS狂乱时，听指挥将膜拜者拉近BOSS，方便击杀或者牧师控制。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    战斗开始后分散站位，躲好火雨，治疗好中毒箭的玩家。德鲁伊优先驱散毒。\n2.    25人模式下精神控制的牧师听从指挥，在BOSS狂乱前控制膜拜者靠近BOSS，狂乱时对BOSS使用黑女巫的拥抱技能即可（使用技能后膜拜者就会死亡）。',
                },
            },
            desc = '黑女巫法琳娜的战斗10人和25人模式有所区别，10人模式下无法精神控制小怪，在BOSS附近击杀小怪即可解除狂乱状态；25人模式下需要精神控制小怪自爆之后解除BOSS的狂乱状态。',
        },
        zone = 1,
        name = '黑女巫法琳娜',
        icon = '1378980',
        abilities = {
            children = {
                {
                    spell = '28796',
                    title = '毒液箭雨',
                    noCollapse = false,
                    expanded = false,
                    desc = '向所有人喷射毒液造成自然伤害，并在接下来的8秒内每2秒造成一次额外伤害，可驱散。',
                },
                {
                    spell = '28794',
                    title = '火焰之雨',
                    noCollapse = false,
                    expanded = false,
                    desc = '随机区域召唤火焰之雨，对范围内玩家造成火焰伤害。',
                },
                {
                    spell = '28798',
                    title = '狂乱',
                    noCollapse = false,
                    expanded = false,
                    desc = 'BOSS攻击速度提高50%，对玩家造成的伤害提高。10人模式下膜拜者无法被精神控制，当膜拜者死亡之后，会造成一个范围冲击，解除BOSS的狂乱状态。25人模式下需要精神控制膜拜者，使用膜拜者的技能：黑女巫的拥抱使用后膜拜者会自爆，解除BOSS的狂乱状态。',
                },
            },
            desc = '黑女巫法琳娜身边有2个追随者和4个膜拜者，膜拜者是解除BOSS狂乱状态的关键，10人模式下击杀膜拜者即可解除BOSS狂乱效果，25人模式下需要控制膜拜者，使用黑女巫的拥抱技能，让膜拜者自爆解除。战斗期间BOSS还会释放群体毒箭和火雨。',
        },
    },
    [1111] = {
        bossId = 1111,
        summary = {
            children = {
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    在场地中间集中站位，按照分配最远距离治疗T和DPS。\n2.    若被注射毒素（变异注射），速度跑到墙角的毒云边上，等待治疗解除疾病。解除后返回继续治疗。\n3.    指定解疾病的治疗随时注意被注射玩家，疾病不要第一时间驱散，需要中的玩家站好位置后驱散疾病。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    主T拉住后，站在BOSS的侧后方输出。注意毒云位置，边打边走，不要接触到毒云。\n2.    优先击杀出现的小软泥怪。\n3.    若被注射毒素（变异注射），速度跑到墙角的毒云边上，等待治疗解除疾病。解除后返回继续输出。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    在场地中间集中站位，最远距离输出BOSS。\n2.    若被注射毒素（变异注射），速度跑到墙角的毒云边上，等待治疗解除疾病。解除后返回继续输出。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    主T开怪后将BOSS拉至墙边，一旦BOSS脚下生成毒云就沿着墙后退，确保不会接触到毒云。\n2.    T需要将BOSS拉着背对或者是侧对着大团和近战，避免软泥喷射到人群。\n3.    副T拉住产生的小软泥怪。',
                },
            },
            desc = '格罗布鲁斯战斗开始后需要主T拉着BOSS在场地上不断移动来使得近战和T躲开毒云，其他人可集中站位，中注射玩家需要跑离大团，到角落去释放注射产生的毒云。',
        },
        zone = 4,
        name = '格罗布鲁斯',
        icon = '1378981',
        abilities = {
            children = {
                {
                    spell = '28157',
                    title = '软泥喷射',
                    noCollapse = false,
                    expanded = false,
                    desc = '对BOSS身前释放一个范围性喷射，造成大量自然伤害，并且每个被击中的玩家都将召唤出一个小软泥怪。',
                },
                {
                    spell = '28240',
                    title = '毒云',
                    noCollapse = false,
                    expanded = false,
                    desc = 'BOSS脚下出现一片毒云，不会移动，但会随时间缓慢扩散开来，直到直径30码之后缓慢消失。接触到毒云会每秒掉血。',
                },
                {
                    spell = '28169',
                    title = '变异注射',
                    noCollapse = false,
                    expanded = false,
                    desc = '随机对一名玩家注射毒素，毒素为疾病，持续10秒，可驱散。持续时间结束或者被驱散后该玩家会对周围人造成伤害，且会在脚下出现一片毒云。',
                },
            },
            desc = '格罗布鲁斯战斗是一场移动战，BOSS会不断在脚下出现毒云，且随机注射一个玩家，该玩家需要及时跑开全团，否则注射时间到了或者被驱散后，该玩家脚下也会出现毒云。',
        },
    },
    [1112] = {
        bossId = 1112,
        summary = {
            children = {
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    10人模式下，一阶段T将BOSS拉到台子下面，靠近门口即可。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n2.    25人模式下，一阶段T先将BOSS拉到台子下面靠近门口处，然后根据熔岩喷射的规律拉着BOSS跑动，躲避伤害。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n3.    BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。熔岩喷射时只有一块安全区域，安全区域出现顺序为：1-2-3-4-3-2-1-2-3-4……，需要根据这个规律找到安全区域，躲避熔岩伤害。\n4.    二阶段熔岩喷射节奏会加快，需要集中精神跑动。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    一阶段在台子上集合站位治疗全团，牧师、骑士和萨满需要优先驱散疾病。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n2.    BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。熔岩喷射时只有一块安全区域，安全区域出现顺序为：1-2-3-4-3-2-1-2-3-4……，需要根据这个规律找到安全区域，躲避熔岩伤害。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    10人模式下，一阶段输出BOSS即可。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n2.    25人模式下，一阶段在输出BOSS的同时需要根据熔岩喷射的规律跑动，躲避伤害。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n3.    BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。熔岩喷射时只有一块安全区域，安全区域出现顺序为：1-2-3-4-3-2-1-2-3-4……，需要根据这个规律找到安全区域，躲避熔岩伤害。\n4.    二阶段熔岩喷射节奏会加快，需要集中精神跑动。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    一阶段在台子上集合站位输出BOSS。二阶段需要和全团人在台子下集合，根据熔岩喷射的规律跑动，躲避伤害。\n2.    BOSS所站台子为扇柄，台子以下区域为扇叶，将扇叶均分为4块区域（从门口至里面分别编号为1-2-3-4号）。熔岩喷射时只有一块安全区域，安全区域出现顺序为：1-2-3-4-3-2-1-2-3-4……，需要根据这个规律找到安全区域，躲避熔岩伤害。',
                },
            },
            desc = '肮脏的希尔盖战斗10人和25人模式有所区别，10人在一阶段期间不需要跑动，25人模式的一阶段会喷发熔岩，需要坦克拉动BOSS跑位躲避。二阶段则是两种模式一样，所有人一起跑动躲避熔岩。',
        },
        zone = 2,
        abilities = {
            children = {
                {
                    expanded = true,
                    noCollapse = false,
                    children = {
                        {
                            spell = '29310',
                            title = '法术瓦解',
                            noCollapse = false,
                            expanded = false,
                            desc = '附近所有目标施法速度降低。',
                        },
                        {
                            spell = '55011',
                            title = '衰老热疫',
                            noCollapse = false,
                            expanded = false,
                            desc = '对近战范围内所有目标释放疾病，疾病会降低血量上限的50%，并每3秒造成500伤害。',
                        },
                        {
                            spell = '29371',
                            title = '爆发（25人模式）',
                            noCollapse = false,
                            expanded = false,
                            desc = '每隔数秒，地面以固定规律喷射熔岩，接触到熔岩的玩家将受到大量自然伤害。',
                        },
                    },
                    title = '一阶段',
                },
                {
                    title = '二阶段',
                    expanded = true,
                    noCollapse = false,
                    children = {
                        {
                            spell = '29350',
                            title = '瘟疫之云',
                            noCollapse = false,
                            expanded = false,
                            desc = '给范围内所有玩家一个Debuff，持续性造成大量伤害。',
                        },
                        {
                            spell = '29371',
                            title = '爆发',
                            noCollapse = false,
                            expanded = false,
                            desc = '地面以固定规律喷射熔岩，接触到熔岩的玩家将受到大量自然伤害，二阶段喷射节奏加快。',
                        },
                    },
                    desc = '90秒后，BOSS回到平台，释放瘟疫之云。',
                },
            },
            desc = '肮脏的希尔盖整体分为两个阶段，一阶段时BOSS可移动，10人模式下地面不会喷射熔岩，25人模式下地面会以固定规律喷射熔岩。二阶段BOSS在台子上释放技能无法靠近，台子下的地面会喷射熔岩，需要全团所有人一起跑动避开。二阶段结束后会回到一阶段，两阶段循环直至BOSS倒下。',
        },
        icon = '1378984',
        name = '肮脏的希尔盖',
    },
    [1113] = {
        bossId = 1113,
        abilities = {
            children = {
                {
                    spell = '55543',
                    title = '瓦解怒吼',
                    noCollapse = false,
                    expanded = false,
                    desc = '凶猛的尖叫，对所有玩家造成大量伤害。',
                },
                {
                    spell = '37123',
                    title = '裂纹小刀',
                    noCollapse = false,
                    expanded = false,
                    desc = '对随机目标投出一把匕首造成大量伤害，附带持续性伤害。',
                },
                {
                    spell = '55470',
                    title = '紊乱打击',
                    noCollapse = false,
                    expanded = false,
                    desc = '对当前目标释放，造成大量物理伤害并使其防御值降低，持续6秒。',
                },
            },
            desc = '教官拉苏维奥斯物理攻击非常强力，玩家无法坦克，需要控制死亡骑士学员，依靠学员的白骨屏障和嘲讽技能拉住BOSS，治疗在加好全团的血量之外也要注意当前的学员的血量。',
        },
        zone = 3,
        summary = {
            children = {
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    由控制学员的人控制开怪，开启学员的白骨屏障和嘲讽技能将BOSS拉至靠近楼梯位置。学员白骨屏障快结束时，控制另外的学员使用白骨屏障和嘲讽技能顶上，轮流控制学员直至BOSS倒下。\n2.    主副T将其余学员拉至另一边，方便控制。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    和大团集中站位，加好全团和学员的血量。\n2.    注意中裂纹小刀的人的血。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    等学员拉住BOSS后输出即可。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    集中站在楼梯上输出BOSS。',
                },
            },
            desc = '教官拉苏维奥斯战斗开始后，10人模式下，需要操作场地上的控制水晶控制BOSS边上的死亡骑士学员（学员拥有白骨屏障和嘲讽技能），让学员开白骨屏障去坦BOSS。而25人模式下就需要牧师精神控制死亡骑士学员去坦克。',
        },
        icon = '1378988',
        name = '教官拉苏维奥斯',
    },
    [1114] = {
        bossId = 1114,
        abilities = {
            children = {
                {
                    title = 'P1',
                    children = {
                        {
                            expanded = false,
                            noCollapse = false,
                            title = '骷髅',
                            desc = '接触人群会自爆释放暗影冲击，对所有目标造成大量暗影伤害。',
                        },
                        {
                            expanded = false,
                            noCollapse = false,
                            title = '女妖',
                            desc = '靠近目标会造成大量暗影伤害，且具有击退效果。',
                        },
                        {
                            expanded = false,
                            noCollapse = false,
                            title = '憎恶',
                            desc = '对近战释放仇恨打击，对目标释放重伤，降低10%治疗效果，可叠加。',
                        },
                    },
                    noCollapse = false,
                    expanded = true,
                    desc = '不断召唤3种小怪',
                },
                {
                    title = 'P2',
                    children = {
                        {
                            spell = '28478',
                            title = '单体寒冰箭',
                            noCollapse = false,
                            expanded = false,
                            desc = '对当前目标释放，造成大量冰霜伤害且减速，可打断。',
                        },
                        {
                            spell = '28479',
                            title = '群体寒冰箭',
                            noCollapse = false,
                            expanded = false,
                            desc = '对所有玩家释放，造成大量冰霜伤害。',
                        },
                        {
                            spell = '27810',
                            title = '暗影裂隙',
                            noCollapse = false,
                            expanded = false,
                            desc = '随机在一名玩家脚下释放，5秒后对还在范围内玩家造成大量暗影伤害。',
                        },
                        {
                            spell = '27808',
                            title = '冰霜冲击',
                            noCollapse = false,
                            expanded = false,
                            desc = '对随机玩家释放，使目标冻结进入昏迷状态，每秒造成大量冰霜伤害。该技能会同样影响周围10码范围内的玩家，且数量无上限。',
                        },
                        {
                            spell = '27819',
                            title = '自爆法力',
                            noCollapse = false,
                            expanded = false,
                            desc = '对随机一名玩家释放，使其在4秒后产生爆炸，且对周围玩家造成伤害。',
                        },
                        {
                            spell = '28410',
                            title = '克尔苏加德锁链',
                            noCollapse = false,
                            expanded = false,
                            desc = '随机控制1-3名玩家，被控制玩家体型变大，伤害和治疗能力增加。',
                        },
                    },
                    noCollapse = false,
                    expanded = true,
                    desc = '开始输出BOSS',
                },
                {
                    expanded = false,
                    noCollapse = false,
                    title = 'P3',
                    desc = '克尔苏加德血量降低至45%后进入P3，会刷新寒冰皇冠卫士。BOSS技能和P2一样。',
                },
            },
            desc = '克尔苏加德整场战斗分为三个阶段，P1期间BOSS不参与战斗，不断召唤小怪。P2阶段后小怪不再刷新，开始输出BOSS，在BOSS血量降至45%时进入P3阶段，该阶段会召唤寒冰皇冠卫士。',
        },
        zone = 5,
        name = '克尔苏加德',
        icon = '1378989',
        summary = {
            children = {
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = 'P1：场地中间集中站位，治疗全团之余可以使用攻击技能输出骷髅。牧师锁住靠近大团的骷髅。\nP2：全场10码距离分散站位，治疗中技能玩家，躲开暗影裂隙。\nP3：和P2一样站位，躲好暗影裂隙。牧师可以锁住出现的寒冰皇冠卫士。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = 'P1：击杀憎恶，远离女妖和骷髅。\nP2：清理完场上小怪后输出BOSS，按照指挥分配分堆站位，打断单体寒冰箭，躲开暗影裂隙。若身边有人被BOSS控制，可以使用技能控制一下。\nP3：和P2一样站位输出BOSS，打断单体寒冰箭，躲开暗影裂隙。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = 'P1：场地中间集中站位，优先击杀骷髅和女妖。\nP2：全场10码距离分散站位，清理完所有场上小怪后最远距离输出BOSS，躲开暗影裂隙。若有玩家被BOSS控制，法师优先变羊\nP3：和P2一样站位输出BOSS，躲好暗影裂隙。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = 'P1：拉住憎恶仇恨，远离女妖和骷髅。\nP2：主T在场地中间拉住BOSS，副T和近战分堆站在BOSS四周，打断单体寒冰箭，躲开暗影裂隙。\nP3：副T拉住出现的寒冰皇冠卫士（大甲虫）。',
                },
            },
            desc = '克尔苏加德战斗开始时需要所有人站在场地中间输出小怪，进入P2阶段后，近战需要分堆站位，远程分散站位，确保不会在中冰霜冲击时连累太多人，战斗过程中躲避好脚下出现的暗影裂隙；进入P3后，副T拉住出现的小怪，其他人继续输出BOSS。',
        },
    },
    [1115] = {
        bossId = 1115,
        summary = {
            children = {
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    在死灵光环失效期间加好全团的血，优先加满主T和血少的。\n2.    死灵光环存在期间输出BOSS。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    开场后输出BOSS，孢子出现后，按照指挥分配，和队友一起去孢子刷新地点击杀孢子，吃到孢子的buff后返回全力输出BOSS。\n2.    吃孢子的时候和队友靠近，没有轮到的时候远离孢子，避免重复。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    开场后输出BOSS，孢子出现后，按照指挥分配，和队友一起去孢子刷新地点击杀孢子，吃到孢子的buff后返回全力输出BOSS。\n2.    吃孢子的时候和队友靠近，没有轮到的时候远离孢子，避免重复。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    战斗开始主T将BOSS拉在房间中间，拉住仇恨即可，自身低血量时注意开启减伤技能。',
                },
            },
            desc = '洛欧塞布战斗开始后需要治疗们注意死灵光环的倒数计时，消失后有3秒时间将全团血量补满，然后光环会再次出现开始倒数，如此不断的循环，其余时间都需要帮助输出。近战和远程输出都需要轮流吃孢子，确保输出伤害和仇恨。',
        },
        zone = 2,
        name = '洛欧塞布',
        icon = '1378991',
        abilities = {
            children = {
                {
                    spell = '29204',
                    title = '必然的厄运',
                    noCollapse = false,
                    expanded = false,
                    desc = '战斗开始2分钟后，BOSS会对所有玩家释放必然的厄运诅咒，10秒后受到大量暗影伤害，之后每隔30秒释放一次，五分钟后会15秒释放一次。',
                },
                {
                    spell = '55593',
                    title = '死灵光环',
                    noCollapse = false,
                    expanded = false,
                    desc = '战斗开始每持续17秒后光环会失效3秒，光环持续期间治疗效果会降低100%，只有在失效时间内才能进行有效治疗。',
                },
                {
                    spell = '29234',
                    title = '召唤孢子',
                    noCollapse = false,
                    expanded = false,
                    desc = '战斗开始后BOSS房间墙边会刷新孢子，血量很少，打掉后会使附近最多5位玩家爆击提高50%，所有法术和技能都不会造成仇恨，持续1.5分钟。',
                },
                {
                    spell = '29865',
                    title = '死亡之花',
                    noCollapse = false,
                    expanded = false,
                    desc = '每隔30秒释放一次，对所有人在6秒内造成大量伤害，结束时还会额外造成伤害。',
                },
            },
            desc = '洛欧塞布战斗开始之后会有治疗量降低100%的光环，持续17秒后停止3秒，一直循环至战斗结束，只有在停止的3秒时间内才能治疗。BOSS每隔一段时间还会释放厄运和死亡之花，均会造成全团伤害。',
        },
    },
    [1116] = {
        bossId = 1116,
        summary = {
            children = {
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    分配解救在墙角被包裹玩家的远程靠近墙边站位，若有玩家被包裹，迅速选取目标，第一时间打破蛛网解救。\n2.    其余远程和近战一起站位输出BOSS，召唤出小蜘蛛优先击杀。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    进入战斗后，主T将BOSS拉在原位，使BOSS背对大团。\n2.    蛛网喷射（全团缠绕）前和BOSS狂暴时注意开保命技能。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    分配治疗墙角被包裹玩家的治疗者，靠近墙边站位，在BOSS释放技能时速度给蛛网内玩家治疗。\n2.    蛛网喷射（全团缠绕）前给主T加好所有持续性治疗技能，套好盾，确保主T在全团昏迷期间存活。\n3.    分配德鲁伊第一时间驱散主T身上的死灵之毒。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    进入战斗后站在BOSS背后输出，若被弹至墙角包裹，解除后需要迅速返回输出BOSS。\n2.    BOSS召唤小蜘蛛时使用群攻技能击杀小蜘蛛。',
                },
            },
            desc = '迈克斯纳战斗期间需要分配玩家解救被蛛网包裹的人，在蛛网束缚全团前给T上好所有持续性治疗技能，结束后第一时间治疗主T，确保T的存活，召唤出的小蜘蛛也需要第一时间清理。',
        },
        zone = 1,
        name = '迈克斯纳',
        icon = '1378994',
        abilities = {
            children = {
                {
                    spell = '52086',
                    title = '蛛网裹体',
                    noCollapse = false,
                    expanded = false,
                    desc = 'BOSS随机将3名玩家弹至墙角并用蛛网包裹住，玩家会受到持续的自然伤害，蛛网有血条，可打破。',
                },
                {
                    spell = '29484',
                    title = '蛛网喷射',
                    noCollapse = false,
                    expanded = false,
                    desc = '使用蛛网缠绕所有玩家造成自然伤害，并使全团昏迷，持续数秒。',
                },
                {
                    spell = '51357',
                    title = '召唤蜘蛛',
                    noCollapse = false,
                    expanded = false,
                    desc = 'BOSS会周期性的召唤出小蜘蛛。',
                },
                {
                    spell = '54121',
                    title = '死灵之毒',
                    noCollapse = false,
                    expanded = false,
                    desc = '使目标在30秒内治疗效果降低90%，可驱散。',
                },
                {
                    spell = '54123',
                    title = '狂乱',
                    noCollapse = false,
                    expanded = false,
                    desc = 'BOSS血量30%后会狂乱，使BOSS攻击速度提高50%，伤害提高。',
                },
            },
            desc = '迈克斯纳整场战斗在蛛网上进行，BOSS会随机点名玩家在墙角被蛛网包裹住，需要打破蛛网解救队友，每隔一段时间BOSS会蛛网喷射束缚全团，期间不能进行任何动作，BOSS还会召唤小蜘蛛，需要及时清理。',
        },
    },
    [1117] = {
        bossId = 1117,
        summary = {
            children = {
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    和人群集中站位，加好全团。\n2.    德鲁伊第一时间驱散BOSS释放的群体诅咒。牧师可以在小怪多的时候锁住天灾战士。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    进入战斗后对BOSS输出。BOSS瞬移时停止输出，等T拉住仇恨之后再输出。\n2.    BOSS上墙后帮助击杀小怪，第二次上墙后优先控制击杀天灾卫士。\n3.    BOSS下来后仍先击杀完小怪后再继续输出BOSS。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    主T开怪，将BOSS拉在房间正中间，BOSS瞬移后和从阳台上下来时，都需要主T及时拉住仇恨。副T站在人群外，等待拉住召唤出的小怪。\n2.    BOSS上平台后，召唤出的小怪需要T拉出人群后等待击杀。',
                },
                {
                    children = {
                    },
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    集中站位，优先击杀召唤出的精英怪。\n2.    小怪击杀完之后再输出BOSS，BOSS瞬移时停止输出，等T拉住仇恨之后再输出。BOSS第二次上墙后优先控制击杀天灾卫士（奥爆法系怪）。\n3.    法师第一时间驱散BOSS释放的群体诅咒。',
                },
            },
            desc = '药剂师诺斯的战斗需要主T在BOSS瞬移后及时拉住仇恨，并且在召唤小怪后和副T一起拉住小怪的仇恨，全团需要在BOSS第三次上平台前击杀BOSS，第三次BOSS下来就会狂暴灭团。',
        },
        zone = 2,
        name = '瘟疫使者诺斯',
        icon = '1379004',
        abilities = {
            children = {
                {
                    spell = '54835',
                    title = '药剂师诅咒',
                    noCollapse = false,
                    expanded = false,
                    desc = '使BOSS身边的人受到诅咒，如果10秒内未被驱散，则周围的玩家都会遭受到一波暗影伤害，还会附带持续性伤害。',
                },
                {
                    spell = '65793',
                    title = '闪现',
                    noCollapse = false,
                    expanded = false,
                    desc = 'BOSS闪现至前方，并清除仇恨。',
                },
                {
                    spell = '54814',
                    title = '残废术',
                    noCollapse = false,
                    expanded = false,
                    desc = 'BOSS瞬移时对近战范围内玩家释放，降低玩家移动速度和攻击速度，可驱散。',
                },
                {
                    expanded = false,
                    noCollapse = false,
                    title = '召唤骷髅战士',
                    desc = '每隔30秒，BOSS会从房间的骨堆上召唤天灾战士（精英小怪）。',
                },
                {
                    expanded = false,
                    noCollapse = false,
                    title = '上平台',
                    desc = '每隔一段时间BOSS会上到阳台上，无法被攻击，期间会在骨堆上召唤更多的精英小怪，每一次上墙召唤的小怪都比上一次更多，时间到达BOSS将会瞬移回房间正中位置。第一次召唤4个天灾勇士，第二次召唤4个天灾勇士+2个天灾卫士，第三次召唤与第二次相似。',
                },
            },
            desc = '药剂师诺斯战斗开始后会瞬移清空仇恨，期间还会释放群体残废，在战斗过程中会召唤精英小怪。每隔一段时间BOSS还会传送到墙上的阳台上召唤更多的精英小怪，期间无法被攻击。BOSS会在传送三次后进入狂暴状态，造成灭团伤害。',
        },
    },
    [1118] = {
        bossId = 1118,
        summary = {
            children = {
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '按照指挥分配加好负责的T的血量，其他人不需要治疗。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '确保自己血量低于坦克，注意仇恨，全力输出。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '注意仇恨，全力输出。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    主T开怪，确保第一个进入BOSS仇恨列表，副T确保血量高于其他团员。\n2.    最后阶段BOSS狂乱后开启保命技能。',
                },
            },
            desc = '帕奇维克伤害很高，对坦克和治疗的压力都很大，坦克会吃到巨量的伤害，需要治疗们安排好治疗循环，另外对DPS的要求也很大，是一场输出竞赛。',
        },
        zone = 4,
        abilities = {
            children = {
                {
                    spell = '41926',
                    title = '仇恨打击',
                    noCollapse = false,
                    expanded = false,
                    desc = '对近战范围内血量最高的有仇恨的目标造成巨量伤害。',
                },
                {
                    spell = '28131',
                    title = '狂乱',
                    noCollapse = false,
                    expanded = false,
                    desc = '当帕奇维克血量降低至5%后，攻击速度提升100%。',
                },
            },
            desc = '帕奇维克伤害是纯物理伤害，伤害非常的高，需要坦克轮流承担伤害。BOSS战斗开始后规定时间内没有击杀，BOSS就会狂暴，造成足以秒杀的伤害。',
        },
        icon = '1379005',
        name = '帕奇维克',
    },
    [1119] = {
        bossId = 1119,
        abilities = {
            children = {
                {
                    title = '地面阶段',
                    noCollapse = false,
                    expanded = true,
                    children = {
                        {
                            spell = '28531',
                            title = '冰霜光环',
                            noCollapse = false,
                            expanded = false,
                            desc = '每2秒造成冰霜伤害。',
                        },
                        {
                            spell = '28542',
                            title = '生命吸取',
                            children = {
                            },
                            noCollapse = false,
                            expanded = false,
                            desc = '对随机玩家释放诅咒，每3秒造成大量暗影伤害且恢复BOSS血量，可驱散。',
                        },
                        {
                            spell = '28560',
                            title = '召唤暴风雪',
                            noCollapse = false,
                            expanded = false,
                            desc = '随机位置释放一个暴风雪，且暴风雪会移动，暴风雪范围内玩家会每2秒受到大量冰霜伤害且降低移动速度。',
                        },
                        {
                            spell = '55697',
                            title = '扫尾',
                            noCollapse = false,
                            expanded = false,
                            desc = '对位于BOSS身后锥形范围内玩家造成物理伤害，并击退。',
                        },
                        {
                            spell = '19983',
                            title = '顺劈斩',
                            noCollapse = false,
                            expanded = false,
                            desc = '对目标和他周围玩家造成大量物理伤害。',
                        },
                    },
                },
                {
                    title = '空中阶段',
                    noCollapse = false,
                    expanded = true,
                    children = {
                        {
                            spell = '28531',
                            title = '冰霜光环',
                            noCollapse = false,
                            expanded = false,
                            desc = '每2秒造成冰霜伤害。',
                        },
                        {
                            spell = '28522',
                            title = '寒冰箭',
                            noCollapse = false,
                            expanded = false,
                            desc = '将随机目标禁锢在寒冰之中，使其陷入昏迷且对目标周围玩家造成大量冰霜伤害。',
                        },
                        {
                            spell = '44799',
                            title = '冰霜吐息',
                            noCollapse = false,
                            expanded = false,
                            desc = '对玩家造成足够秒杀的冰霜伤害，可在冰块后躲避。',
                        },
                    },
                },
            },
            desc = '萨菲隆战斗分为两个阶段，开始时为地面阶段，每隔60秒，BOSS进入空中阶段，会数次将随机一名玩家冻成冰块，且对冰块周围玩家造成大量的冰霜伤害。冰冻结束后，BOSS对场地正中间释放冰霜吐息，需要在冰块后躲避伤害，否则会被秒杀，吐息结束后BOSS回到地面阶段，两阶段循环直至BOSS倒下。',
        },
        zone = 5,
        name = '萨菲隆',
        icon = '1379010',
        summary = {
            children = {
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    根据指挥分配站位，在BOSS两侧分散治疗。德鲁伊第一时间驱散好诅咒。\n2.    躲好暴风雪。\n3.    BOSS上天后分散站位，冰霜吐息时第一时间到冰块后躲避。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    根据指挥分配站位，在BOSS两侧输出BOSS。\n2.    躲好暴风雪。\n3.    BOSS上天后分散站位，冰霜吐息时第一时间到冰块后躲避。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    根据指挥分配站位，在BOSS两侧分散输出BOSS。法师第一时间驱散好诅咒。\n2.    躲好暴风雪。\n3.    BOSS上天后分散站位，冰霜吐息时第一时间到冰块后躲避。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    萨菲隆只需要主T，开打后将BOSS拉在原地，且BOSS背对入口。\n2.    躲避好暴风雪。\n3.    BOSS上天后分散站位，冰霜吐息时第一时间到冰块后躲避。',
                },
            },
            desc = '萨菲隆战斗地面阶段需要所有人躲避好暴风雪，空中阶段时需要所有人分散站位，避免被点名成冰块的人炸伤，在冰霜吐息出现后尽快躲到冰块后面避免被秒杀。',
        },
    },
    [1120] = {
        bossId = 1120,
        name = '塔迪乌斯',
        zone = 4,
        abilities = {
            children = {
                {
                    title = '斯塔拉格',
                    noCollapse = false,
                    expanded = true,
                    children = {
                        {
                            spell = '54529',
                            title = '能量涌动',
                            noCollapse = false,
                            expanded = false,
                            desc = 'BOSS攻击速度提高，造成的伤害提高，持续10秒。',
                        },
                        {
                            spell = '54517',
                            title = '磁性牵引',
                            noCollapse = false,
                            expanded = false,
                            desc = '每隔一段时间，斯塔拉格和费尔根同时使用电磁牵引，将对方的第一仇恨目标拖至自己面前，并将仇恨值交换。',
                        },
                    },
                },
                {
                    title = '费尔根',
                    noCollapse = false,
                    expanded = true,
                    children = {
                        {
                            spell = '28135',
                            title = '静止力场',
                            noCollapse = false,
                            expanded = false,
                            desc = '每秒对自身平台上玩家造成自然伤害。',
                        },
                        {
                            spell = '54517',
                            title = '磁性牵引',
                            noCollapse = false,
                            expanded = false,
                            desc = '每隔一段时间，费尔根和斯塔拉格同时使用电磁牵引，将对方的第一仇恨目标拖至自己面前，并将仇恨值交换。',
                        },
                    },
                },
                {
                    title = '塔迪乌斯',
                    noCollapse = false,
                    expanded = false,
                    children = {
                        {
                            spell = '28089',
                            title = '极性转化',
                            noCollapse = false,
                            expanded = false,
                            desc = '每隔一段时间会对所有玩家随机释放正能量电荷或者负能量电荷，相同电荷玩家互相靠近时，会周围给同电荷玩家提高造成的伤害BUFF。不同电荷玩家相互靠近时，会对附近所有玩家造成伤害。',
                        },
                        {
                            spell = '28167',
                            title = '闪电链',
                            noCollapse = false,
                            expanded = false,
                            desc = '对当前目标释放，击中后继续攻击附近多个目标。',
                        },
                        {
                            spell = '28299',
                            title = '球状闪电',
                            noCollapse = false,
                            expanded = false,
                            desc = '当BOSS近战范围内没有可攻击目标时会释放此技能，每个闪电都会对目标造成巨量伤害。',
                        },
                    },
                },
            },
            desc = '塔迪乌斯战斗分为2个阶段，第一阶段需要先同时击杀两边小平台的小boss斯塔拉格和费尔根，第二阶段需要跳至BOSS所在平台等待BOSS激活，BOSS每隔一段时间会释放电荷，所有人需要查看身上的电荷正负极，根据指挥分配位置和其他同一种电荷的站在一起。6分钟内没有击杀则BOSS狂暴。',
        },
        icon = '1379019',
        summary = {
            children = {
                {
                    role = 'HEALER',
                    expanded = false,
                    children = {
                        {
                            expanded = false,
                            noCollapse = false,
                            title = '小BOSS阶段',
                            desc = '1.    按照分配前往2个小BOSS平台治疗。\n2.    T被交换位置时，及时切换目标，治疗BOSS的当前T。',
                        },
                        {
                            expanded = false,
                            noCollapse = false,
                            title = '塔迪乌斯阶段',
                            desc = '1.    跳上BOSS所在平台后，和主T站在一起等待BOSS激活。\n2.    根据指挥分配看好T和自身队伍血量。\n3.    BOSS释放电荷时第一时间查看身上电荷标记，然后按照指挥分配和其他同一种电荷（加号或者减号）的人一起站在BOSS侧面。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。\n4.    注意：电荷变换时打断读条，第一时间换位。',
                        },
                    },
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    children = {
                        {
                            expanded = false,
                            noCollapse = false,
                            title = '小BOSS阶段',
                            desc = '1.    按照分配前往两个小平台输出。\n2.    注意小BOSS血量，确保费尔根和斯塔拉格同时死亡。',
                        },
                        {
                            expanded = false,
                            noCollapse = false,
                            title = '塔迪乌斯阶段',
                            desc = '1.    跳上BOSS所在平台后，和主T站在一起等待BOSS激活，激活后输出BOSS。\n2.    BOSS释放电荷时第一时间查看身上电荷标记，然后按照指挥分配和其他同一种电荷（加号或者减号）的人一起站在BOSS侧面。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。',
                        },
                    },
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    children = {
                        {
                            expanded = false,
                            noCollapse = false,
                            title = '小BOSS阶段',
                            desc = '1.    按照分配前往两个小平台输出。\n2.    注意小BOSS血量，确保费尔根和斯塔拉格同时死亡。',
                        },
                        {
                            expanded = false,
                            noCollapse = false,
                            title = '塔迪乌斯阶段',
                            footDesc = '1.    跳上BOSS所在平台后，和主T站在一起等待BOSS激活，激活后输出BOSS。\n2.    BOSS释放电荷时第一时间查看身上电荷标记，然后按照指挥分配和其他同一种电荷（加号或者减号）的人一起站在BOSS侧面。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。\n3.    注意：电荷变换时打断读条，第一时间换位。',
                        },
                    },
                },
                {
                    role = 'TANK',
                    expanded = false,
                    children = {
                        {
                            expanded = false,
                            noCollapse = false,
                            title = '小BOSS阶段',
                            desc = '1.    每个平台一个T，拉好当前小BOSS仇恨。\n2.    被抛至另一平台后迅速拉好当前BOSS，循环直至小BOSS被同时击杀。',
                        },
                        {
                            expanded = false,
                            noCollapse = false,
                            title = '塔迪乌斯阶段',
                            desc = '1.    跳上BOSS所在平台后，主T站在BOSS前方等待BOSS激活后拉住仇恨。\n2.    BOSS释放电荷时第一时间查看身上电荷标记，然后按照指挥分配和其他同一种电荷（加号或者减号）的人一起站在BOSS侧面。每一次电荷变换均要注意，电荷仍旧为正极或者负极就原地不动，若正极变为负极，或者负极变为正极，就跑至BOSS对面，确保和所有同样电荷玩家站在一起。循环直至BOSS倒下。',
                        },
                    },
                },
            },
            desc = '塔迪乌斯战斗开始后需要先击杀两个平台上的小BOSS，小BOSS需要同时击杀，否则会再次复活，击杀之后跳至BOSS所在平台开启BOSS战。战斗期间BOSS释放电荷时注意自身的电荷属性，同一种电荷的站在一起会增加攻击力，而不同电荷的站一起会受到伤害。',
        },
    },
    [1121] = {
        bossId = 1121,
        abilities = {
            children = {
                {
                    title = '瑞文戴尔男爵',
                    children = {
                        {
                            spell = '28882',
                            title = '邪恶之影',
                            noCollapse = false,
                            expanded = false,
                            desc = '对当前目标造成大量暗影伤害，并附带一个持续性伤害，不可驱散。',
                        },
                        {
                            spell = '28834',
                            title = '瑞文戴尔印记',
                            noCollapse = false,
                            expanded = false,
                            desc = '对光环范围内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
                        },
                    },
                    noCollapse = false,
                    expanded = true,
                    desc = '激活后会跑向大门右侧的角落',
                },
                {
                    title = '库尔塔兹领主',
                    children = {
                        {
                            spell = '57467',
                            title = '流星',
                            noCollapse = false,
                            expanded = false,
                            desc = '范围伤害，由陨石冲击点周围8码内所有玩家共同分担。',
                        },
                        {
                            spell = '28832',
                            title = '库尔塔兹印记',
                            noCollapse = false,
                            expanded = false,
                            desc = '对光环范围内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
                        },
                    },
                    noCollapse = false,
                    expanded = true,
                    desc = '激活后会跑向大门左侧的角落',
                },
                {
                    title = '瑟里耶克爵士',
                    children = {
                        {
                            spell = '28883',
                            title = '神圣愤怒',
                            children = {
                            },
                            noCollapse = false,
                            expanded = false,
                            desc = '对第一个目标射出神圣箭矢，随后会在目标和其身旁玩家间弹跳，造成神圣伤害，每次跳跃提高50%伤害。',
                        },
                        {
                            spell = '57376',
                            title = '神圣之箭',
                            noCollapse = false,
                            expanded = false,
                            desc = '对距离最近玩家连发此技能，造成大量神圣伤害。',
                        },
                        {
                            spell = '57377',
                            title = '谴责',
                            noCollapse = false,
                            expanded = false,
                            desc = '如瑟里耶克爵士无法攻击到任何玩家，对所有目标造成大量神圣伤害。',
                        },
                        {
                            spell = '28835',
                            title = '瑟里耶克印记',
                            noCollapse = false,
                            expanded = false,
                            desc = '对光环范围内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
                        },
                    },
                    noCollapse = false,
                    expanded = true,
                    desc = '激活后会跑向远离大门的右边角落',
                },
                {
                    title = '女公爵布劳缪克丝',
                    children = {
                        {
                            spell = '57374',
                            title = '暗影箭',
                            noCollapse = false,
                            expanded = false,
                            desc = '对距离自己最近的目标射出魔法箭，造成大量暗影伤害。',
                        },
                        {
                            spell = '28863',
                            title = '虚空领域',
                            noCollapse = false,
                            expanded = false,
                            desc = '随机范围内玩家脚下召唤一个虚空领域，对站在范围内的所有玩家造成暗影伤害。',
                        },
                        {
                            spell = '28833',
                            title = '布劳缪克丝印记',
                            noCollapse = false,
                            expanded = false,
                            desc = '对光环范围内玩家造成伤害并留下印记，叠加的印记层数越多所受伤害越大。',
                        },
                        {
                            spell = '57381',
                            title = '不灭痛楚',
                            noCollapse = false,
                            expanded = false,
                            desc = '如女公爵布劳缪克丝无法攻击到任何玩家，对所有目标造成大量暗影伤害',
                        },
                    },
                    noCollapse = false,
                    expanded = true,
                    desc = '激活后会跑向远离大门的左边角落',
                },
            },
            desc = '天启四骑士有4个BOSS，分别是瑞文戴尔男爵、库尔塔兹领主、瑟里耶克爵士、女公爵布劳缪克丝，4个BOSS都有各自的光环印记和独特技能，相同光环印记可叠加，层数越高受到的伤害越多，每个BOSS的印记互不干涉。开战后BOSS会自动跑向房间的四个角落。',
        },
        zone = 3,
        name = '天启四骑士',
        icon = '1385732',
        summary = {
            children = {
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    跟随分配到的主副T，T去接手哪个BOSS就去跟随治疗。\n2.    进内场加血的治疗需要注意身上光环，一种光环叠加过高时去另一个BOSS附近即可。\n3.    击杀库尔塔兹领主时治疗和T站在一起，击杀女公爵布劳缪克丝拉时注意躲避脚下出现的黑水。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    和主T站一起全力爆发输出库尔塔兹领主。领主死亡后输出瑞文戴尔男爵。25人模式下若无法击杀瑞文戴尔男爵则需要去输出瑟里耶克爵士，等印记消掉之后再返回击杀瑞文戴尔男爵。\n2.    输出库尔塔兹领主时注意和T站在一起，输出女公爵布劳缪克丝拉时注意躲避脚下出现的黑水。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    和主T站一起全力爆发输出库尔塔兹领主。领主死亡后输出瑞文戴尔男爵。25人模式下若无法击杀瑞文戴尔男爵则需要去输出瑟里耶克爵士，等印记消掉之后再返回击杀瑞文戴尔男爵。\n2.    输出库尔塔兹领主时注意和T站在一起，输出女公爵布劳缪克丝拉时注意躲避脚下出现的黑水。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    10人模式下需要主T拉住库尔塔兹领主和瑞文戴尔男爵。副T和一个血量较高的治疗去内场分别站在女公爵布劳缪克丝和瑟里耶克爵士附近。光环叠加过高时两个人互换位置即可。击杀完前场的两个BOSS，再去拉住后场两个BOSS。\n2.    25人模式下需要主T前往靠近大门的左侧角落拉住库尔塔兹领主。副T前往靠近大门的右侧角落拉住瑞文戴尔男爵。\n主T在库尔塔兹领主死后接手瑞文戴尔男爵，此时副T需要前往台子上等待消除印记，待印记消除后再去接手瑞文戴尔男爵。\n女公爵布劳缪克丝和瑟里耶克爵士需要2个血量较高的人去抗住伤害。在印记叠加过3层后交换位置即可。',
                },
            },
            desc = '天启四骑士开场后需要大团优先击杀库尔塔兹领主，然后再去输出瑞文戴尔男爵，两个BOSS杀完之后再击杀剩余两个，注意一种印记叠加过高之后就需要切换到另一个BOSS处输出。瑟里耶克爵士和女公爵布劳缪克丝前期只需要他们的光环范围内有人，在光环叠加过高之后换位置去另一个BOSS范围内，待光环消除之后再更换回来即可。',
        },
    },
    [1094] = {
        bossId = 1094,
        abilities = {
            children = {
                {
                    children = {
                        {
                            spell = '56272',
                            title = '奥术吐息',
                            noCollapse = false,
                            expanded = false,
                            desc = '对正面所有人造成大量伤害且附加一个数秒后会爆炸的debuff，爆炸会对周围人造成大量伤害。',
                        },
                        {
                            spell = '57473',
                            title = '奥术风暴',
                            noCollapse = false,
                            expanded = false,
                            desc = '随机对数个目标施放，造成大量伤害。',
                        },
                        {
                            spell = '56266',
                            title = '漩涡',
                            noCollapse = false,
                            expanded = false,
                            desc = 'BOSS飞至空中，将所有人卷上天，期间造成持续性的大量伤害。',
                        },
                        {
                            spell = '55849',
                            title = '能量火花',
                            noCollapse = false,
                            expanded = false,
                            desc = '每隔一段时间召唤一个火花，从场地外围向BOSS靠近，BOSS一旦吸收会提升攻击力。火花可击杀，击杀后会留下一个区域，站在其中的玩家会提升伤害。',
                        },
                    },
                    noCollapse = false,
                    title = 'P1阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '56431',
                            title = '奥术炸弹',
                            noCollapse = false,
                            expanded = false,
                            desc = '对任意地点投掷奥术炸弹，击退附近目标并造成大量伤害。',
                        },
                        {
                            spell = '125030',
                            title = '深呼吸',
                            noCollapse = false,
                            expanded = false,
                            desc = '对整个场地释放吐息，每秒造成大量伤害。',
                        },
                        {
                            spell = '45848',
                            title = '蓝龙护盾',
                            noCollapse = false,
                            expanded = false,
                            desc = '场地上随机位置出现一个护盾，进入后会吸收BOSS的伤害，护盾会不断缩小，需要及时更换。',
                        },
                    },
                    noCollapse = false,
                    title = 'P2阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            children = {
                                {
                                    spell = '54672',
                                    title = '能量涌动',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '对随机目标造成持续性的大量伤害，技能无冷却时间。',
                                },
                                {
                                    spell = '57428',
                                    title = '静电力场',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '随机对一个目标释放秘法球，对目标范围内的所有人造成大量群体伤害。',
                                },
                            },
                            noCollapse = false,
                            title = 'BOSS',
                            expanded = false,
                        },
                        {
                            children = {
                                {
                                    spell = '56091',
                                    title = '烈焰之刺',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '向目标发射火焰，造成大量火焰伤害，奖励一个连击点数。',
                                },
                                {
                                    spell = '56092',
                                    title = '烈焰噬体',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '喷射火焰，对目标造成持续性伤害，可叠加，根据连击点数决定持续时间。',
                                },
                                {
                                    spell = '57090',
                                    title = '再生',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '每秒为目标恢复生命值，持续一段时间，可叠加，奖励一个连击点数。',
                                },
                                {
                                    spell = '57143',
                                    title = '生命爆发',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '治疗周围范围内友方目标，并使施法者治疗效果提高。治疗效果和持续时间根据连击点数的数量决定。',
                                },
                                {
                                    spell = '57108',
                                    title = '烈焰之盾',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '使施法者所有受到伤害降低，根据连击点数的数量决定持续时间。',
                                },
                                {
                                    spell = '57092',
                                    title = '炽热疾速',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '飞行速度提高，持续数秒。',
                                },
                            },
                            noCollapse = false,
                            title = '坐骑龙',
                            expanded = false,
                        },
                    },
                    noCollapse = false,
                    title = 'P3阶段',
                    expanded = true,
                },
            },
            desc = '整个永恒之眼副本只有玛里苟斯一个BOSS，整场战斗分为3个阶段。第一阶段在场地正中间，BOSS血量降低至50%的血量会进入第二阶段，玛里苟斯进入无法攻击状态，场地内出现站在飞盘上的小怪，在击杀完所有小怪后进入第三阶段，场地会被摧毁，全员骑龙，且使用龙的技能作战。',
        },
        name = '玛里苟斯',
        icon = '1385753',
        summary = {
            children = {
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = 'P1：在BOSS侧面治疗全团，在漩涡结束后立即离开BOSS龙头方向。\nP2：注意大团血量，在蓝龙盾内躲避BOSS的深呼吸和远程小怪的技能，盾范围缩小后及时更换位置。\nP3：失去自身职业技能，全部使用坐骑龙的技能，按照指挥安排进行治疗或者输出。负责输出的可以按两下1技能，然后就按2技能叠加伤害，血少的按4技能回血。负责治疗的可以按两下3技能，再按4技能，所有人中点名技能了按5减伤。躲好BOSS放出的秘法球。',
                },
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = 'P1：在BOSS侧面输出BOSS，在力量火花靠近BOSS时优先击杀能量火花。在漩涡结束后立即离开BOSS龙头方向。\nP2：优先击杀地面上的小怪，然后登录小怪留下的圆盘，操作圆盘飞上去击杀远程小怪。在地面时，注意进入蓝龙盾内躲避BOSS的深呼吸和远程小怪的技能，盾范围缩小后及时更换位置。\nP3：失去自身职业技能，全部使用坐骑龙的技能，按照指挥安排进行治疗或者输出。负责输出的可以按两下1技能，然后就按2技能叠加伤害，血少的按4技能回血。负责治疗的可以按两下3技能，再按4技能，所有人中点名技能了按5减伤。躲好BOSS放出的秘法球。',
                },
                {
                    children = {
                    },
                    role = 'RANGE',
                    expanded = false,
                    desc = 'P1：在BOSS侧面输出BOSS，优先击杀能量火花。火花死亡后地面会留下一个光环，站在上面可以增加伤害。在漩涡结束后立即离开BOSS龙头方向。\nP2：优先击杀地面上的小怪，然后再输出远程小怪，在蓝龙盾内躲避BOSS的深呼吸和远程小怪的技能，盾范围缩小后及时更换位置。\nP3：失去自身职业技能，全部使用坐骑龙的技能，按照指挥安排进行治疗或者输出。负责输出的可以按两下1技能，然后就按2技能叠加伤害，血少的按4技能回血。负责治疗的可以按两下3技能，再按4技能，所有人中点名技能了按5减伤。躲好BOSS放出的秘法球。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = 'P1：主T将BOSS拉在中间，漩涡下地后立即拉住BOSS，避免龙头面向大团。\nP2：拉住降至地面的近战小怪，在蓝龙盾内躲避BOSS的深呼吸和远程小怪的技能。盾范围缩小后及时更换位置。\nP3：失去自身职业技能，全部使用坐骑龙的技能，按照指挥安排进行治疗或者输出。负责输出的可以按两下1技能，然后就按2技能叠加伤害，血少的按4技能回血。负责治疗的可以按两下3技能，再按4技能，所有人中点名技能了按5减伤。躲好BOSS放出的秘法球。',
                },
            },
            desc = '玛里苟斯战斗分为三阶段，一阶段在场地正中间开打，BOSS会飞到空中释放漩涡，还会召唤火花，一旦火花被BOSS吸收掉就会提升BOSS攻击力。BOSS血量降低至50%的血量会进入第二阶段，场面上出现站在飞盘上的小怪，清理完之后进入第三阶段，场地会被摧毁，全员骑龙，失去自身的职业技能，使用龙的技能作战。',
        },
    },
    [1126] = {
        bossId = 1126,
        summary = {
            children = {
                {
                    role = 'MELEE',
                    expanded = false,
                    desc = '1.    战斗开始全力输出BOSS，若边上有人中了岩石碎片技能，赶紧远离中技能的人。\n2.    远离重压跳跃后产生的云雾。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.    分散站位治疗全团，特别是注意中岩石碎片和重压跳跃技能的人。主T在被穿刺时也需要照顾好两个坦克的血量。\n2.    若边上有人中了岩石碎片技能，赶紧远离中技能的人。\n3.    远离重压跳跃后产生的云雾。',
                },
                {
                    role = 'RANGE',
                    expanded = false,
                    desc = '1.    分散站位输出BOSS，若边上有人中了岩石碎片技能，赶紧远离中技能的人。\n2.    远离重压跳跃后产生的云雾。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.    主T拉住BOSS，在BOSS施放重压跳跃时主T要跑向BOSS拉住仇恨。\n2.    在主T被穿刺时需要副T嘲讽，接手BOSS。',
                },
            },
            desc = '岩石看守者阿尔卡冯的战斗需要所有人躲避岩石碎片技能，且在边上人被重压跳跃后赶紧跑开，避免受到窒息云雾的伤害。副T在主T被穿刺的时候要及时拉住BOSS仇恨。',
        },
        name = ' 岩石看守者阿尔卡冯',
        icon = '1385715',
        abilities = {
            children = {
                {
                    spell = '58678',
                    title = '岩石碎片',
                    noCollapse = false,
                    expanded = false,
                    desc = '随机对一个玩家快速的发射石片，造成大量物理伤害，同时也会对目标周围的人造成伤害。',
                },
                {
                    spell = '58960',
                    title = '重压跳跃',
                    noCollapse = false,
                    expanded = false,
                    desc = '随机对一个玩家进行跳跃攻击，造成大量物理伤害并击退 ，会在地面上留下一片窒息云雾。',
                },
                {
                    spell = '58965',
                    title = '窒息云雾',
                    noCollapse = false,
                    expanded = false,
                    desc = '重压跳跃后地面留下一片云雾，云雾内的玩家会受到持续性的自然伤害，并使命中降低50%。',
                },
                {
                    spell = '58663',
                    title = '践踏',
                    noCollapse = false,
                    expanded = false,
                    desc = '使所有玩家眩晕，并造成大量的物理伤害。',
                },
                {
                    spell = '58978',
                    title = '穿刺',
                    noCollapse = false,
                    expanded = false,
                    desc = '践踏后的连续技能，对当前目标使用，造成大量物理伤害，并将该目标捏在手上使其数秒内无法行动，且会暂时移除仇恨。',
                },
            },
            desc = '岩石看守者阿尔卡冯战斗开始后，会对随机目标发射岩石碎片，重压跳跃之后会留下云雾，都需要及时躲避，BOSS践踏技能后，还需要副T接手，BOSS会在战斗开始5分钟后狂暴。',
        },
    },
    [772] = {
        bossId = 772,
        abilities = {
            desc = '岩石看守者阿尔卡冯战斗开始后，会对随机目标发射岩石碎片，重压跳跃之后会留下云雾，都需要及时躲避，BOSS践踏技能后，还需要副T接手，BOSS会在战斗开始5分钟后狂暴。',
        },
        name = ' 岩石看守者阿尔卡冯',
        summary = {
            desc = '岩石看守者阿尔卡冯的战斗需要所有人躲避岩石碎片技能，且在边上人被重压跳跃后赶紧跑开，避免受到窒息云雾的伤害。副T在主T被穿刺的时候要及时拉住BOSS仇恨。',
        },
        icon = '1385715',
    },
    [742] = {
        bossId = 742,
        abilities = {
            desc = '黑曜石圣殿只有萨塔里奥一个BOSS，在面对他之前要先清理周围的小怪，还有他的三条暮光幼龙“维斯匹隆”、“塔尼布隆”和“沙德隆”。BOSS萨塔里奥战斗开始后会从两边的熔岩内不断召唤熔岩元素，每隔一段时间还会召唤熔岩墙扫过战斗区域，随机释放的火雨也是需要注意的。',
        },
        name = '萨塔里奥',
        summary = {
            desc = '黑曜石圣殿内的三个暮光幼龙可以选择性击杀，每保留一个幼龙副本难度会增加且BOSS多一件装备掉落。在BOSS战时BOSS会召唤未被击杀的暮光龙，且每条龙在场地上被击杀时都会导致BOSS攻击增加。BOSS战时需要大团在场地侧面输出，躲避出现的所有技能。',
        },
        icon = '1385765',
    },
    [734] = {
        bossId = 734,
        abilities = {
            desc = '整个永恒之眼副本只有玛里苟斯一个BOSS，整场战斗分为3个阶段。第一阶段在场地正中间，BOSS血量降低至50%的血量会进入第二阶段，玛里苟斯进入无法攻击状态，场地内出现站在飞盘上的小怪，在击杀完所有小怪后进入第三阶段，场地会被摧毁，全员骑龙，且使用龙的技能作战。',
        },
        name = '玛里苟斯',
        summary = {
            desc = '玛里苟斯战斗分为三阶段，一阶段在场地正中间开打，BOSS会飞到空中释放漩涡，还会召唤火花，一旦火花被BOSS吸收掉就会提升BOSS攻击力。BOSS血量降低至50%的血量会进入第二阶段，场面上出现站在飞盘上的小怪，清理完之后进入第三阶段，场地会被摧毁，全员骑龙，失去自身的职业技能，使用龙的技能作战。',
        },
        icon = '1385753',
    },
    [744] = {
        bossId = 744,
        abilities = {
            desc = '|cFF000000 BOSS技能主要体现在“点名”以及“炮塔”，具体在战斗的时候根据团长指挥，结合职责攻略里总结的要点各司其职即可！ ',
        },
        name = '烈焰巨兽',
        summary = {
            desc = '|cFF000000◆ 该BOSS的核心机制是三种载具：\n【坦克】\n[主驾职责] 打断好技能，被点名风筝boss保持好距离；\n[副驾职责] 输出boss、打蓝铁、开盾\n\n【攻城车】\n[主驾职责] 维持好DOT，看准时机发射队友去打炮台（一般由团长指定）；\n[副驾职责] 打蓝铁钩蓝铁、被点名风筝boss保持好距离\n\n【摩托车】\n负责减速、运蓝铁、以及接打完炮台的队友并为其回血。（一般由团长指定）\n\n◆ 困难模式：会多出防御塔对应的守护者技能，躲好光束和光柱、清理好小怪\n\n◆ 载具介绍：\n一共三种载具，每种都可以乘坐主、副驾两名角色；主驾一般负责控制载具移动、部分输出技能；副驾控制核心伤害输出、增益、勾汽油补充载具能量等\n\n【被修复的攻城坦克】 - 样子形似坦克的载具，共5辆。\n主驾技能——\n[撞锤] 瞬发，15码，消耗40蒸汽动力。攻击前方所有敌人，并有击退效果。\n[震击] 瞬发，25码，38蒸汽动力，10秒冷却。击打前方锥形范围内的敌人，可打断施法4秒。\n[蒸汽冲刺] 瞬发，40蒸汽动力，15秒冷却。加速，向前方冲锋，可对敌人造成伤害并击退。\n\n副驾技能——\n[发射火炮] 瞬发，10-70码，20蒸汽动力。造成大量伤害。\n[发射火炮] 瞬发，10-70码，20蒸汽动力。造成大量伤害。\n[护盾发生器] 瞬发，1分钟冷却。吸收一定量的物理、火焰、冰霜和奥术伤害，持续5秒\n\n【被修复的攻城车】\n主驾技能——\n[投射巨石] 瞬发，10-70码。向远方投射巨石，造成伤害。\n[投射蓝铁桶] 瞬发，10-70码，消耗5蓝铁。向远方投射一枚蓝铁球，造成火焰伤害，并产生持续伤害的Debuff，可叠加10次。\n[撞锤] 瞬发，15码，4秒冷却。撞击敌人，造成伤害。\n[投掷乘客] 1秒施法，2秒冷却。把一位乘客投射到远方。\n\n\副驾技能——\n[火炮]瞬发，50码，1秒冷却。发射小型的爆破弹，造成伤害。\n[防空导弹] 瞬发，1000码，0.25秒冷却。向正前方发射一枚爆炸火箭，命中飞行目标后爆炸。\n[抓住箱子] 瞬发，50码。使用铁钩和锁链抓住已锁定为目标的箱子。\n[速度提高] 瞬发，25蓝铁。向发动机中灌注液态蓝铁，移动速度提高100%，持续20秒。\n[装入投石车] 瞬发，8码，30秒冷却。将你装载到投石车弹药篮中，把自己发射出去。\n\n【摩托车】\n主驾技能——\n[声波号角] 瞬发，20能量。向摩托车前方发射声波，对敌人造成伤害。\n[焦油] 瞬发，15秒冷却。向后方释放一滩焦油，降低10码范围内敌人移动速度，持续45秒。焦油可被点燃，效果持续45秒。\n[急救包] 瞬发，1分钟冷却。在4秒内完全治疗乘客。\n\n副驾技能——无\n\n◆ 副本难度：\n进本后，和戴防护口罩的矮子对话开启普通模式；和楼梯下的泰坦对话开启# 困难模式 ',
        },
        icon = '1385731',
    },
    [745] = {
        bossId = 745,
        abilities = {
            desc = '|cFF000000【烈焰喷射】2.7秒施法，25秒冷却。践踏地面，对所有玩家造成8483~9517点火焰伤害，并将目标击飞，同时反制其施法，持续6秒。（BOSS施法该技能时注意停止读条施法，防止被反制！）\n\n【熔渣炉】（点名技能）瞬发，20秒冷却。随机冲锋一个目标并将其抓住，扔进施法者的熔渣炉。目标不能攻击施法者，且每秒收到6000点火焰伤害，持续10秒。如果目标存活下来，则受到魔法熔渣的影响，急速提高100%，持续10秒。（治疗注意看好被抓角色的血量！）\n\n【灼烧】3秒施法，30码，25秒冷却。发射一团烈焰，灼烧施法者面前半径30码范围的所有敌人，每0.5秒造成3770~4230点火焰伤害，持续3秒。另外，被这个法术灼烧的地面将持续燃烧，每一秒对周围13码范围内的所有敌人造成3016~3384点火焰伤害。位于这个区域内的铁铸像会被加热，并最终融化。持续燃烧效果无法在水中生效。\n\n【创造者之力】瞬发，BOSS会周期性的激活我方周围的[铁铸像]来加入战斗。每个激活的[铁铸像]可以使BOSS获得物理攻击力提高20%效果。可叠加。\n\n[铁铸像]技能：\n\n【高热】[铁铸像]处于灼烧效果中时，会不停受到热能冲击，每秒使他们的移动速度提高5%，急速提高5%，这个效果可以叠加最多10次。叠加到10次之后，[铁铸像]会熔化。\n\n【熔化】施法者融化，急速提高100%，持续30秒。另外，每秒都有烈焰从施法者身上冒出，对周围半径7码范围的敌人造成1885~2115点火焰伤害。\n\n【脆弱】冷水使融化的[铁铸像]迅速固化，无法行动，并使其受到的暴击几率提高50%，持续15秒，如果他们在这个状态下受到5000点以上的单次伤害，就会碎裂。对周围半径10码范围内的所有敌人造成18850~21150点物理伤害。该伤害无视护甲减免。',
        },
        name = '掌炉者伊格尼斯',
        summary = {
            desc = '|cFF000000◆ 主T拉boss，副T拉小怪[铁铸像]。治疗奶好被抓的人的血；打断BOSS读条；\n\n◆ 中灼烧点名及时跑开，不要让灼烧产生的火圈靠近人群；\n\n◆ 出现小怪[铁铸像]，副T需要把小怪拉到火圈里烫至融化，然后再拉到水里冷却，冷却后安排DPS快速点掉。被点掉时不要靠近人群，避免中AOE伤害。',
        },
        icon = '1385742',
    },
    [746] = {
        bossId = 746,
        abilities = {
            desc = '|cFF000000◆ 主要注意P1阶段小怪的[旋风斩]；躲地面的火\n\n◆ P2除T以外的职业不要中BOSS前方扇形区域的喷火\n\n◆T注意身上[护甲融化]的Debuff层数，需要伺机换嘲。',
        },
        name = '锋鳞',
        summary = {
            desc = '|cFF000000◆ 战斗开始，击杀小怪，躲开地板技能；\n\n◆ P0：清理小怪，【T】把旋风斩小怪拉出人群，【远程】全力输出；中了火远离人群\n\n◆ P1：身后4座炮台，有NPC每30秒修复一个。修复后可以点击发射钩子束缚BOSS（可询问团长具体发射钩子的人员安排，或伺机而动）。当BOSS被4个钩子束缚，则会被拉到地面，昏迷30秒。BOSS血量被打到50%以下则不会再上天，否则30秒之后BOSS上天循环P1。\n\n◆ P2：把BOSS血量打到50%以下，BOSS落地后不会再上天。DPS侧面输出，不要正对BOSS头部；BOSS会给T释放融化护甲的Debuff，两T注意换嘲，DPS猛打，注意躲火。BOSS下地6分钟后会狂暴。',
        },
        icon = '1385763',
    },
    [747] = {
        bossId = 747,
        abilities = {
            desc = '|cFF000000【发脾气】1分钟冷却，对周围500码范围内的敌人每秒造成其最大生命值10%的物理伤害，持续10秒。在造成伤害的同时会使移动速度降低50%，持续4秒。\n\n【灼热之光】（点名技能） 点名1名随机玩家，使其每秒受到3500点伤害，持续9秒。该伤害会同时影响周围8码范围内的盟友。\n\n【重力炸弹】（点名技能）点名1名随机玩家，向其投掷一枚重力炸弹。炸弹将在9秒后爆炸，对其造成15000点暗影伤害，该伤害会同时影响范围12码范围内的盟友，并将受影响的玩家拉到初始目标所在位置。\n\n【心脏暴露】当BOSS生命值达到75%、50%、25%时，会进入信息状态，停止移动和攻击，并且本体不可被攻击，持续30秒。但会暴露出心脏。此时受到的伤害提高100%，心脏承受的血量等同于本体的。这个阶段场地会刷新小怪，小怪会产生爆炸效果。\n\n【心碎】（困难模式，当BOSS心脏被打掉）移出战斗限制。造成伤害提高15%，最大生命值提高40%并恢复至满值。不会再进入心脏阶段，也不会再召唤小怪。常规阶段的部分技能被强化。\n\n【生命火花】（困难模式）【灼热之光】的点名结束后，会在目标角色身边召唤1个生命火花。\n\n【震击】：生命火花的近战攻击将造成自然伤害，无视护甲。并对目标附近的3个敌人造成同等伤害。\n\n【静电充能】：光环每3秒对周围半径500码范围内的所有敌人造成2000点自然伤害。',
        },
        name = 'XT-002拆解者',
        summary = {
            desc = '|cFF000000◆ BOSS有AOE技能，治疗注意加好团血\n\n◆ BOSS有两种点名技能，根据团长的安排，不同的点名技能分别从两个不同的方向跑出人群，等待效果结束释放（一般[重力炸弹]往左，[灼热之光]往右）\n\n◆ 出小怪时，远程清理好小怪，近战专心boss。心脏阶段提高输出（打爆心脏会激活# 困难模式，注意听团长指挥控制节奏）\n\n◆ 如果触发困难模式：困难模式下，小怪不再刷新，BOSS伤害和血量大幅提升。并且被[灼热之光]点名，需要跑对位置释放（听团长指挥）一般是在BOSS脚下（但和近战反方向不要靠近）方便T及时拉住释放出来的[生命火花]，DPS也需及时转火将其点掉',
        },
        icon = '1385773',
    },
    [748] = {
        bossId = 748,
        abilities = {
            desc = '|cFF000000【增压】BOSS在死亡时释放最后一股能量，使其他所有盟友的生命值恢复100%，体型增大15%，造成的伤害提高25%，并使他们获得新的技能\n\n◆小个子唤雷者：\n\n【闪电链】2秒施法向敌人射出一支闪电箭，造成5550~6450点自然伤害。最多可攻击5个目标。可打断。\n\n【过载】需要引导，6秒后对20码范围内所有敌人25000点自然范围伤害。无法打断。\n\n【闪电风暴】（1增压，即场上死掉1个BOSS后）BOSS开始旋转，每秒对随机数个目标发射闪电箭造成5655到6345点自然伤害，持续5秒。可打断。\n\n【风暴之盾】（2增压，即场上死掉2个BOSS后）电能护盾保卫施法者，对攻击者造成250点自然伤害。\n\n【闪电之藤】（2增压）BOSS开始进入飞行状态，随机追踪一名玩家。闪电根须从BOSS身上不断射出，对周围18码范围内的敌人每秒造成5000点自然伤害，持续30秒\n\n◆中个子符文大师\n\n【符文之盾】1.5秒施法，可吸收50000点伤害，持续30秒。吸收满伤害后，会转化成强大的能量，使施法者造成的伤害提高50%，持续15秒。BOSS身上的这个护盾可偷取，可驱散。\n\n【能量符文】1.5秒施法，30秒冷却。在随机友方单位脚下召唤一个能量符文。这个符文可以使周围半径5码范围内的所有友方和地方单位造成的伤害提高50%，持续30秒。\n\n【死亡符文】（1增压）在随机敌方单位脚下召唤一个死亡符文。符文会对周围半径13码范围内的所有单位秒0.5秒造成3500点暗影伤害，持续30秒。\n\n【召唤符文】（2增压）2秒施法，在随机地方目标周围制造召唤符文，它会周期性地召唤闪电元素，冲向随机目标并爆炸，释放强大的闪电冲击，对周围半径30码范围内的所有敌人造成14138~15862点自然伤害。爆炸后元素消失。\n\n◆大个子断钢者\n\n【高压】光环对所有玩家每3秒造成3000点自然伤害。\n\n【熔化冲压】对当前目标造成35000点自然伤害，并每1秒造成额外20000点自然伤害，持续4秒。可驱散。\n\n【静电瓦解】（1增压）向随机玩家投掷一个闪电球，对目标及其半径5码范围内的所有敌方单位造成7000点自然伤害，并使其受到的自然伤害提升75%，持续20秒。优先瞄准远处的玩家\n\n【压倒能量】（2增压）瞬发，10秒冷却。使当前目标充满过载能量，造成的伤害提高200%，持续25秒。时间结束后，目标将熔解自爆，对周围半径15码范围内的友方单位造成29250~30750点自然伤害。\n\n【2电荷充能】（2增压）每当玩家或宠物死亡时，BOSS造成的伤害提高25%，并为他治疗40%的最大生命值。可叠加。',
        },
        name = '钢铁议会',
        summary = {
            desc = '|cFF000000◆ 有三个BOSS，按体型分别是大、中、小个子。按顺序击杀，如果把大个子留在后杀就是# 困难模式。\n\n◆ 普通模式通常按大、中、小顺序（实战听团长指挥）\n\n◆ 集中输出一个目标，目标死后其他两个会满血，并获得新技能 \n\n◆ 【大个子】释放[熔化冲压]后，T注意用减伤技能，注意驱散Debuff\n\n◆ 【中个子】释放[篮圈能量符文]后，T要把他拉出篮圈。远程可以站在篮圈里输出，有50%伤害增益；他还会点名释放[绿圈死亡符文]，可以注意插件上的技能预警，Boss读条时尽量人群分散；他还会释放一个护盾，此时需要法师偷取，或者牧师/萨满进攻驱散一下\n\n◆ 【小个子】他的[闪电链]、[闪电风暴]技能注意进行打断。注意躲开[过载]、[闪电之藤]\n\n◆ 困难模式：注意【大个子】的[静电瓦解]技能，会点名打远处的玩家，并且造成范围攻击，一般团长会安排“沙包”在打团外吃这个技能。留到最后的【大个子】，施放[压倒能量]后当前T的伤害提高200%，25秒后会自爆，注意留好换坦和跑出人群的时间，死了之后爬起来继续。注意其他位置不要减员，每死一个人会给boss增伤25%回40%血，可以给BOSS上致死打击。',
        },
        icon = '1390439',
    },
    [749] = {
        bossId = 749,
        abilities = {
            desc = '|cFF000000【聚焦视线】BOSS双眼放出能量射线，追踪并扫射随机玩家。对扫射点周围3码范围内的地方单位每1秒造成3238到3762点奥术伤害。优先瞄准远处的玩家。\n\n【粉碎打击】15秒冷却，造成125%物理伤害并造成25%破甲，持续25秒\n\n【单手粉碎打击】(当BOSS一只手臂死亡时)他会发动此技能。造成物理伤害，并使护甲值降低25%，持续45秒。可叠加\n\n【粉碎打击震颤】每次发动粉碎打击或者单手粉碎打击时，会同时造成粉碎打击震颤的效果。对其周围20码范围的敌人造成6338~6662点物理伤害，并反制其施法，持续8秒\n\n【岩石怒吼】(当BOSS两只手臂死亡时)释放碎石之雨，秒0.2秒对所有地方单位造成707到793点物理伤害，持续2秒。\n\n【石化吐息】当BOSS近战范围没有可攻击的目标时，发动该技能。对所有地方单位每1秒造成18750~21250点自然伤害，并使其受到的伤害提高20%，持续8秒。可叠加\n\n【碎岩】BOSS的手臂被摧毁时召唤出5个碎石',
        },
        name = '科隆加恩',
        summary = {
            desc = '|cFF000000◆ 俗称左右手，主要伤害靠左、右两只手造成。（这个左右是以BOSS的视角！）左手会放AOE，右手会抓人\n\n◆ MT拉住BOSS在原地，DPS输出。BOSS会给当前MT上DEBUFF 护甲降低，如果T的护甲过低，需要由2T换嘲\n\n◆ 右手随机抓人 治疗需要及时刷血 并且DPS集中火力打右手 直到BOSS放手\n\n◆ 左手地震，群伤，注意刷好团血\n\n◆ BOSS眼睛会盯人释放射线，被盯的人需要跑，直到射线消失；技能有范围伤害，避免跑到人群里误伤\n\n◆ 右手打掉后会刷出数只小石头人，机动T注意拉小怪\n\n◆ BOSS左手和右手打掉都会让BOSS掉30%的血量，具体左、右手的击杀优先级，根据团长战术安排。一切行动听指挥！',
        },
        icon = '1385747',
    },
    [750] = {
        bossId = 750,
        abilities = {
            desc = '|cFF000000【音速尖啸】2.5秒施法，30秒冷却。BOSS向面前发出冲击性的声波攻击，对行进路线上的所有敌人造成19万到21点物理伤害。震荡波的伤害由所有行进路线上的敌人分担。\n\n【惊骇尖啸】2秒施法，30秒冷却。发出尖啸，恐惧敌人，持续5秒。可驱散。\n\n【警戒冲击】4秒施法，需引导，30秒冷却。BOSS吟唱发出连续而强大的冲击，在接下来的3秒内，每1秒对所有地方单位造成6000点暗影伤害，并使目标受到的暗影伤害提高100%，持续5秒。可叠加，可打断。\n\n【守护虫群】2秒施法，标记一个玩家，召唤一群黑豹对标记的玩家发动攻击\n\n【召唤野性防御者】3秒施法，战斗开始一分钟后，召唤1只白豹子参与战斗',
        },
        name = '欧尔莉亚',
        summary = {
            desc = '|cFF000000◆ 俗称猫女，开局伴随4只豹子\n\n◆ 装备不好的情况下，尽量安排3名T ，1名拉BOSS 剩下两个T，一人两只豹子（1个T拉多只豹子的话，开场注意用减伤/无敌技能）\n\n◆ 豹子的伤害会很高 而且会有流血DEBUFF\n\n◆ 开打前先站好位，坦克各自选好标记好的豹子，开减伤技能墙接怪；大团一般可以集中站在BOSS脚下\n\n◆ 拉豹子的2个坦克，尽量空出距离，豹子在一起重叠伤害会加倍。DPS可以先击杀4只豹子\n\n◆ 打掉豹子后开始集火BOSS，BOSS会定期刷一群小豹子 A掉即可。还会刷一只白色的豹子，这只Boss没有仇恨值，但吃嘲讽，T可以轮流嘲讽，白豹子死后会在地方留下黑水，尽量拉出人群击杀之\n\n◆ BOSS定期会群体恐惧，注意预读驱散/上反恐/战栗图腾/战士切换姿态反恐惧，注意打断BOSS读条技能',
        },
        icon = '1385717',
    },
    [751] = {
        bossId = 751,
        abilities = {
            desc = '|cFF000000【刺骨之寒】光环，对静止不动的敌人每1秒造成600点冰霜伤害，每3秒叠加1曾。移动或跳跃则可以削减叠加层数，保持移动每1秒则减少1层\n\n【冰冻】对半径10码范围内的地方单位造成5550~6450点冰霜伤害，并使其无法移动，最长持续10秒。可驱散\n\n【冰柱】瞄准随机1名玩家当前所在位置。数秒后召唤冰柱从空中落下，对落点4码范围内的所有地方单位造成14000点冰霜伤害，并将其击飞\n\n【大冰柱】瞄准随机3名玩家当前所有位置，数秒后，召唤大冰柱从空中落下，对落点7码范围内的所有单位造成14000点冰霜伤害，并将其击飞。大冰柱碎裂后会在地面上留下[雪流]，持续12秒。站在上面可以免疫快速冻结。\n\n【快速冻结】9秒施法，50秒冷却，霍迪尔释放强力的冰霜冲击，将所有地方单位永久冻结。已经被冻结的目标如果再被攻击命中则立即死亡。角色站在[雪流]中可以免疫快速冻结\n\n【冰冻重击】瞬发，1分钟冷却，物理伤害降低70%，但是每次攻击可以造成40000点额外的冰霜伤害。另外，使所有敌人每2秒受到4000点冰霜伤害，持续20秒',
        },
        name = '霍迪尔',
        summary = {
            desc = '|cFF000000◆ 进入霍迪尔的房间，里面有6名被冻住的NPC\n\n◆ 进入战斗后，先打掉冰块释放所有NPC（NPC会给玩家提供各种增益，尽量及时释放）\n\n◆ BOSS施加的冰霜Debuff需要不停跳跃或移动来削减\n\n◆ 场内NPC提供的光柱可以提高施法速度，法系注意利用；还有一个雷云的BUFF加暴击伤害，并且可以传给队友，中了的话，可以靠近法系队友传给他们\n\n◆ 注意躲天上砸冰块的技能（有1大1小两种），地上有光圈，不要上去被砸了\n\n◆ 大的砸冰块技能，会在结束的时候提供一个[雪流]效果，就是地上的圈看起来变得模糊的那个瞬间，这个时候听团长指挥，快速站上去，可以免疫掉BOSS接下来的致命技能[快速冻结]\n\n# 困难模式：2分钟之内打掉就算完成困难模式',
        },
        icon = '1385740',
    },
    [752] = {
        bossId = 752,
        abilities = {
            desc = '|cFF000000◆ P1阶段\n\n【闪电之鞘】P1的托里姆不会参与战斗，只是在台子上观看。偶尔使用技能扰乱玩家。这个技能可以保护它受到的伤害降低99%\n\n【风暴之锤】投掷一把风暴之锤，对一个敌人造成2451~2551点自然伤害，并将其击倒昏迷2秒。\n\n【震耳雷霆】对靠近风暴之锤落点周围15码范围内的敌人造成4625~5375点自然伤害，并使其施法时间延长75%，持续8秒\n\n【宝珠充能】向竞技场周围4根闪电柱的其中之一充能，使其放出强大的电能，对周围35码范围内的敌人造成巨人伤害\n\n【狂暴】竞技场战斗开始5分钟后，如果未能进入P2，托里姆将强化竞技场和通道里的所有怪物，使其造成的伤害提高500%，攻击和施法速度提高200%，生命值提高300%，持续10分钟。\n\n【召唤闪电宝珠】当托里姆受到来自通道里玩家的直接攻击后，他将跳入竞技场参加战斗，进入P2。同时，他会在身后召唤一颗超载的能量球，快速返回并贯穿通道，消灭行进路线上的一切目标。\n\n◆ P2阶段\n\n【统御之触】造成的伤害降低40%，生命值降低30%，持续10分钟（普通模式才有，即内场的战斗完成时间超过3分钟）\n\n【闪电链】以一道闪电打击敌人，造成4625~5375点自然伤害。闪电会跳跃到其他队友身上\n\n【闪电充能】瞬发，30秒冷却。从竞技场周围的其中一根闪电柱吸收电能，8秒后，向电柱方向释放叉状闪电，对锥形区域种的敌人造成17344~20156点自然伤害。并使施法者近战伤害和攻击速度提高15%，自然伤害提供10%，可叠加\n\n#困难模式：内场3分钟之内解决战斗，托里姆下到外场。此时，【统御之触】效果不会触发，且[西芙]会加入战斗，她无法被攻击，但会用技能骚扰玩家的战斗\n\n【寒冰箭雨】全体范围11250~13750冰霜伤害，移动速度降低50%，持续4秒。可驱散\n\n【冰霜新星】对附近敌人造成14138~15862点冰霜伤害，定身效果，最多持续6秒，可驱散\n\n【暴风雪】召唤缓慢移动的暴风雪，每1秒造成4813~6187点冰霜伤害，移动速度降低65%，持续10秒',
        },
        name = '托里姆',
        summary = {
            desc = '|cFF000000◆ 这个BOSS需要将团对分成两组，简称内场、外场\n\n◆ 打个比方，BOSS站在城楼上，外场就像是城楼外侧的大门口广场。内场就好比是从侧门可以进到城楼，一路过关斩将找到城楼上的BOSS，把它推下去，和广场上的队友两面夹击它\n\n◆ 内外场的队伍配置听团长指挥即可\n\n◆ 外场— 会不停刷怪，T拉好，打好，加好即可，躲好上面BOSS向下扔的技能，有昏迷效果、有延长施法效果的，中了会比较麻烦\n\n◆ 内场— 在一条通道里打小怪，需要注意的点：\n1.有个巨人会抬左、右手，释放竖排路径上的冲击波秒人（类似乌特加德之巅副本里骑飞龙那个BOSS的左右车道的吐息），注意提前观察左右，躲开。\n2.通道有两个守门的小BOSS，其中2号会随机点人放炸弹，注意躲开\n3.通道最后一段，地上中央区域的符文圈不要踩，会有高伤害，靠墙走即可\n\n4.看到BOSS后，攻击就可以把他推下外场，进入P2阶段\n\n◆ P2阶段BOSS战，注意分散站位，避免被BOSS的闪电链技能链接；躲好BOSS的锥形区域攻击\n\n# 困难模式：内场如果在3分钟之内把BOSS推下去，则开启困难模式。这个模式下会有个冰法NPC骚扰玩家，有群体冰箭、冰环、暴风雪技能，并她还不可以被攻击；托里姆也不会有普通模式下的削弱（伤害降低40%、生命值降低30%）效果',
        },
        icon = '1385770',
    },
    [753] = {
        bossId = 753,
        abilities = {
            desc = '|cFF000000【自然协调】开战前，弗蕾雅带有150层自然协调。每1层使弗蕾亚受到的治疗效果提高8%。阶段1每一波召唤的自然盟友死亡时，都会移除相应的自然协调层数。当自然协调全部被移除后，进入阶段2\n\n【艾欧娜尔之触】生命缚誓者的能量每1秒为弗蕾亚恢复24000点生命值\n\n【阳光】对目标周围半径8码范围内的敌人造成7400到8600点火焰伤害\n\n【艾欧娜尔的礼物】在随机地点投掷一颗种子，种子会萌芽成小树苗状的艾欧娜尔的礼物并快速生长。大概12秒后，礼物完全成长，为费蕾雅及其盟友恢复最大生命值的60%。礼物在成长过程中，会对附近8码范围内的玩家释放信息素，使其免疫监护者之握\n\n【召唤自然盟友】召唤自然系小怪，总共6波。每一波会从以下3种怪物组合里随机选择一种。（相同组合不会连续出现，每周组合都会出现两次）\n\n组合1：小花。死亡时会爆炸\n\n组合2：三个只元素怪。迅疾鞭挞者[硬化树皮，被攻击可提升体型、伤害]、水之精魂[直线路径上的AOE伤害技能，还可击退]、风暴鞭挞者[拥有类似闪电链、闪电箭的伤害技能]\n\n组合3：一棵大树[技能：监护者之握群里沉默效果、自然之怒DOT、召唤孢子蘑菇形状，站在下面可免疫沉默]。\n\nBOSS进入P2阶段：\n\n【自然炸弹】在多名随机玩家脚下召唤一个自然炸弹。炸弹一段时间之后爆炸，对半径10码范围内的敌人造成8775到9225点自然伤害，并击退',
        },
        name = '弗蕾亚',
        summary = {
            desc = '|cFF000000◆ P1阶段BOSS会召唤6波小怪，会有以下组合（这个阶段不需要输出BOSS，只打小怪）：\n\n组合1：小花。死亡时会爆炸。注意躲开\n\n组合2：三个只元素怪。迅疾鞭挞者[硬化树皮，被攻击可提升体型、伤害]、水之精魂[直线路径上的AOE伤害技能，还可击退]、风暴鞭挞者[拥有类似闪电链、闪电箭的伤害技能] —— 需要同时击杀，不然会复活\n\n组合3：一棵大树。有群体沉默，需要站在它召唤出来的蘑菇下面，即可免疫沉默；它还有点名爆炸的技能，注意跑开人群\n\n◆ 同时也注意躲BOSS的[阳光]技能，地上会有光圈\n\n◆ 6波小怪打完，BOSS身上的BUFF全部消除就会进入P2\n\n◆ P2阶段BOSS会在地上放定时炸弹，注意躲开就好。（一般是河的两边来回跳',
        },
        icon = '1385733',
    },
    [754] = {
        bossId = 754,
        abilities = {
            desc = '|cFF000000◆ P1阶段\n\n【感应地雷】抛出10个左右的感应地雷，玩家踩到后触发爆炸，对半径3码范围内的盟友造成12000点火焰伤害\n\n【凝固汽油弹】向随机敌方目标发射凝固汽油炸弹，撞击时爆炸，5码范围内的盟友造成9425~19575点火焰伤害，并每1秒造成6000点火焰伤害，持续8秒。这个技能会优先选择15码以外的目标\n\n【等离子冲击】对当前目标发射等离子束，每1秒造成25000点火焰伤害，持续6秒。这个效果无法抵抗\n\n【震荡冲击】对周围半径15码范围内的所有敌人造成10万点自然伤害\n\n◆ P2阶段\n\n【热浪】发射冲击波，对所有敌人造成2828~3172点火焰伤害，并每1秒造成3000点火焰伤害，持续5秒\n\n【急速爆发】向随机目标所在方向发射一串等离子爆破弹，每发造成1885~2115点火焰伤害，共6发，持续3秒\n\n【激光弹幕】瞄准随机方向蓄力，然后向扇形范围内发射激光束，并缓慢旋转。每0.25秒对敌人造成20000点火焰伤害，持续10秒\n\n【火箭打击】向随机目标发射火箭。火箭抵达目标位置后，对周围半径3码范围内所有敌人造成500万点火焰伤害\n\n◆ P3阶段\n\n【飞行】BOSS头部飞上天，只有远程攻击能打到\n\n【等离子球】向当前目标发射等离子电球，造成14138到15862点火焰伤害\n\n【召唤机器人】持续召唤3种机器人参与战斗。其中，摧毁[突击机器人]后会掉落道具【磁核】，拾取后在BOSS头部下方使用可使BOSS进入短暂的昏迷、易伤状态',
        },
        name = '米米尔隆',
        summary = {
            desc = '|cFF000000◆ 这个BOSS大致分为4个阶段\n\n◆ 开打后MT拉住BOSS在场地的中央，其他队员分组成扇型站在外围。\n\n◆ 近战DPS注意每隔一段时间看到BOSS身上发光就表明要爆炸了 包括MT 必须迅速跑开等爆炸 爆炸完后回来继续打 另外注意BOSS会在自己身旁放很多地雷 注意不要踩到即可。坦克注意BOSS有个技能叫离子冲击 需要坦克开盾墙或治疗给大技能等接住，硬刷是无论如何刷不起来的。如果坦克技能用掉，下次可以换坦克嘲讽接住\n\n◆ 远程组要注意不要太过于集中 BOSS会对随机目标扔燃烧弹 遭成初始伤害及DOT，需要治疗帮刷几口血\n\n◆ P1打掉后，迅速按团长指定的区域集中，把身上的火放掉\n\n◆ P2阶段BOSS没有仇恨，会进行360度扫射，这个阶段可以开嗜血。治疗猛刷，DPS猛打，同时注意BOSS每隔段时间会放弹幕，需要大家转圈躲避，被喷到就秒。同时会对随机目标放个导弹，需要及时躲开\n\n◆ P3阶段 BOSS上天，这时候需要一名远程T（术士/猎人/法师均可）吸引BOSS在天上的头部的仇恨，来控制头部的移动。 其他人先注意点杀刷出来的地面的小机器人，机器人死后会掉落道具，团长安排拾取，拾取之后和远程T进行配合，道具放在头部下面可使BOSS昏迷、易伤12秒，此时全力输出。之后循环这个过程，直到打爆头部\n\n◆ P4阶段 BOSS组合在一起 几乎拥有之前3个阶段的所有技能：会爆炸放地雷，会扫射等。但是血量只有之前的30% ，只需要注意好之前几个阶段的注意事项，并一定注意头、身体、脚 三个部分要同时打掉，不然BOSS会自我修理，回血回满\n\n# 困难模式：按下车间最内侧墙壁上的红色按钮开启。',
        },
        icon = '1385754',
    },
    [755] = {
        bossId = 755,
        abilities = {
            desc = '|cFF000000【绝望光环】阻止敌方几乎所有类型的法力值自然回复方式，同时使其近战攻击速度降低20%\n\n【灼热烈焰】2秒施法，对周围半径100码范围内的所有敌人造成13875~16125点火焰伤害，减低防护效果75%，持续10秒。可打断。\n\n【暗影撞击】向一个目标发射暗影箭，对冲击点10码范围的所有敌人造成11310~12690点暗影伤害，并击退。冲击之后留下一个持续20秒的能量场，身处其中的玩家魔法伤害提高100%，施法速度提高100%，治疗能力降低75%，法力值消耗降低75%\n\n【无面者印记】对一个目标施放咒语，每1秒从该目标周围15码范围内的其他盟友身上吸取5000点生命值，持续10秒。吸取的生命值会以20倍的效果治疗BOSS\n\n【黑暗涌动】BOSS造成的物品伤害提高100%，但移动速度降低55%，持续10秒\n\n【召唤萨隆邪铁蒸汽】召唤一枚萨隆斜铁蒸汽，被打碎后会留下萨钢蒸汽。处于蒸汽中的玩家，每一秒会将100点生命转化为自身的法力值。蒸汽持续30秒。蒸汽的转换效果会叠加，每层消耗的生命值和恢复的法力值翻倍，但离开范围就全部消失。\n\n#困难模式：不击杀任何一个萨隆邪铁蒸汽，当场面上同时存在8个萨隆邪铁蒸汽时，他们会融合成萨隆邪铁畸体，技能如下\n\n【萨隆邪铁屏障】制造屏障保护BOSS，使其受到的所有伤害降低99%\n\n【极度黑暗】对所有敌人造成750点暗影伤害，并使其受到的暗影伤害提高10%，持续3分钟。可叠加',
        },
        name = '维扎克斯将军',
        summary = {
            desc = '|cFF000000◆ BOSS会有个绝望光环，禁止几乎所有形式的回蓝(除了惩戒骑和增强SM)，并且近战攻击减速20%\n\n◆ 通常法系分可以为2队，站BOSS的左右2边。BOSS有2个技能需要远程组非常密切的关注：\n\n1.暗影冲击：该技能对随机远程目标释放，一旦释放插件会提示某人中了，那一组的人必须马上离开10码距离，否则会掉血和弹飞，暗影冲击结束后地上会有一摊黑水，站在上面输出会降低耗蓝70%，法伤和急速提高100%，所以远程要做好的就是躲好炸弹 然后站黑水上输出；\n\n2.无面者印记，这个诅咒也是对随机目标释放，会对周围10码的其他人造成伤害并20倍的给BOSS回血，被点到第一时间离开人群即可\n\n◆ 近战队需要提供23名打断职业，如盗贼，放弃DPS密切关注BOSS的一个技能灼热烈焰，如果不打断BOSS会全屏AOE并降低75%护甲，几乎等于灭团\n\n◆ 场地上会有飘来飘去的萨钢晶体，可以将其打掉 在地上形成一摊绿水，踩上去会掉血并回蓝。如果没蓝了，可以在上面踩一会但不要踩久了，叠高了DEBUFF会被秒掉\n\n# 困难模式：全程不打萨钢晶体，等8个全出来之后融和成萨钢畸体协助BOSS',
        },
        icon = '1385735',
    },
    [756] = {
        bossId = 756,
        abilities = {
            desc = '|cFF000000【心智】战斗开始时，玩家拥有100点心智。战斗中部分技能会消耗心智，全部消耗完就会被控制，BOSS自身数值大幅度提升；战斗期间，玩家可以通过站在场上的绿色光柱处恢复心智。\n\n【湮灭】 战斗开始15分钟后，BOSS触发团灭\n\n◆ P1阶段萨拉\n\n【萨拉的热情】 使1名玩家造成的伤害提高20%，但是受到的伤害提高100%，持续15秒\n\n【萨拉的祝福】 为1名玩家恢复27000~33000点生命值，但是每2秒造成6000点暗影伤害，持续20秒\n\n【萨拉的怒火】 使1名[尤格萨隆的卫士]体型增大30%，物理伤害能力提高12000点，但每3秒造成125000点暗影伤害，持续12秒\n\n【邪恶之云】 产生6团邪恶之云做缓慢的圆周运动。[尤格萨隆的卫士]会从云里刷出来，随着战斗进行，刷新频率不断变高，同时玩家触碰毒云，也会额外刷新1只\n\nP1阶段尤格萨隆的卫士\n\n【黑暗箭雨】 发射黑暗之箭，对周围35码范围内的敌人造成8500~11500点暗影伤害，且受到的治疗效果降低25%，持续10秒\n\n【支配心智】 暂时控制目标的思维，使其听从BOSS命令，持续10秒。并损失4点心智，可驱散\n\n【暗影新星】 尤格萨隆的卫士死亡时发生自爆，对15码范围内所有目标造成25000~27500点暗影伤害。这是对[萨拉]造成伤害的唯一方式\n\nP1阶段需要8只卫士炸到[萨拉]，则会进入P2\n\n◆ P2阶段尤格萨隆外场\n\n【古神之躯】 尤格萨隆现身，但被护盾保护无法造成伤害。\n\n【精神错乱】 1秒施法，对1名随机玩家造成5000点暗影伤害，并且心智降低12点。优先对心智大于40的玩家施放\n\n【心灵疾病】 1.5秒施法，对1名随机玩家造成5000点暗影伤害，心智降低3点，且有恐惧效果，持续4秒。该效果还将尝试转移到半径10码范围内的另一名玩家身上，优先对心智大于40的玩家施放\n\n【心智链接】 1.5秒施法，将2名随机玩家的心智链接，这两名玩家距离大于20码，则每1秒受到3000点暗影伤害，并损失2点心智。持续30秒\n\n【死亡射线】 释放四道致命的能量射线，他们会在场地缓缓的随机扫射，接触到的玩家将每0.5秒受到20000点自然伤害\n\n【疯狂阶梯】 开启10道通往尤格萨隆梦境的传送们，每个传送们只能传送1名玩家。进入后，环境外厅会出现幻象NPC，攻击后变换为感应触须;还会出现狞笑的骷髅干扰玩家。清完外厅的触须可以进到大脑内厅\n\n【疯狂诱导】 1分钟施法，当通往环境的传送们开启时，环境里的尤格萨隆大脑开始吟唱疯狂诱导。1分钟后，仍处于幻境内的玩家将被立即传送到外场，并清空所有心智。\n\nP3阶段尤格萨隆\n\n【疯狂凝视】 引导疯狂凝视，持续4秒。当玩家面向施法者时，每1秒受到5700到6300点暗影伤害，并损失4点心智。\n\n【召唤守护者】 每隔10秒左右，召唤1只[不朽守护者]参与战斗\n\n【暗影信标】 瞬发，45秒冷却。选择3名[不朽守护者]进行强化，持续10秒。尤格萨隆向所有带有暗影信标的[不朽守护者]投掷暗影能量球，能量球接触到目标后爆炸，强化目标周围半径20码范围内的所有友方单位包括尤格萨隆，使其每1秒恢复37500点生命值，持续20秒',
        },
        name = '尤格-萨隆',
        summary = {
            desc = '|cFF000000◆ 战斗开始前，如果和4位守护者（就是前面击败的弗蕾亚、霍迪尔、托里姆、米米尔隆）逐一对话，则开启普通模式（俗称“4盏灯”）\n\n◆ P1阶段，刷出卫士怪，近战断好读条，卫士怪残血后，坦克拉到[萨拉]处由远程点掉，近战远离，卫士怪的爆炸是对萨拉造成伤害的唯一手段；所有人避免踩绿色毒云而刷出不必要的卫士怪。治疗注意刷中了点名的人\n\n◆ P2阶段，场上出现触须，尽量近战打小的，远程打大的，总之不要靠近大的，拍人伤害非常高；时刻注意自己的心智值，可以找场边绿色光柱进行心智的恢复；注意驱散场上的所有诅咒、疾病、中毒等；有个技能会将两个玩家进行连线，一旦被连，两人的距离不能超过20码，否则会承受持续伤害以及心智降低；还有就是BOSS会有一个从中心向外发射的射线技能，注意躲，会秒人。\n\n◆ 内场P2持续1分钟左右，会刷新传送门，按找团长分配的职责进门，进门注意先杀掉幻象触手，不要面朝狞笑的骷髅。清理完内场触手，进入大脑的房间全力输出，直到大脑开始读条，立即点传送门出去。继续循环传送内场的机制\n\n◆ 当内场将大脑血量打到30%，进入P3\n\n◆ P3阶段会不断刷新小怪，可以由T拉住A掉。当BOSS读[疯狂凝视]技能时所有人背对即可破解。建议治疗全程背对',
        },
        icon = '1385774',
    },
    [757] = {
        bossId = 757,
        abilities = {
            desc = '|cFF000000◆ P1阶段\n\n【传送倒计时】 在一个副本CD中，当玩家首次与奥尔加隆交战时，他会立即启动行星分析程序，最多一小时后，如果奥尔加隆未被击败并处于脱离战斗状态，他会立即返回万神殿。\n\n【狂暴】 战斗开始6分钟后，BOSS伤害能力提高900%，攻击速度提高150%\n\n【量子打击】 攻击当前目标，造成34125~35875点物理伤害\n\n【相位冲压】 凶猛的攻击，对当前目标造成8788到10212点奥术伤害，并使目标叠加1层相位冲压，叠满5层会被立即传送进黑洞位面，持续10秒\n\n【宇宙重击】 点名3名随机玩家，召唤3颗流星轰炸。对轰炸点周围6码范围内的玩家造成5W+火焰伤害，并将其击飞。其他玩家仅会受到随距离递减的火焰伤害。\n\n【大爆炸】 对现实位面的所有敌人造成11W+物理伤害，并使所有身处黑洞位面的玩家传送回现实位面\n\n【召唤坍塌星】 第一次释放于开战后15秒。会有4个坍塌星加入战斗。后续随着被击杀也会再次召唤，场地最多4个。死亡后产生范围爆炸，并且在地面留下黑洞\n\n【召唤活化星座】 第一次释放于开战后60秒。奥尔加隆唤醒宇宙中的3颗小行星。星座会使用弹幕攻击玩家，并接触[黑洞]会进行中和，双双消弭\n\n【黑洞】 玩家可以通过主动踏入黑洞的方式来进入黑洞位面。最多可以在黑洞位面中停留10秒。在此期间，玩家将每1秒受到1532~1968点奥术伤害，同时黑洞位面的暗物质也会对玩家发起攻击。\n\n◆ P2阶段\n\n星座、坍缩星、黑洞全部消失；仍然会释放【量子打击】、【相位冲压】、【宇宙重击】以及召唤新的【黑洞】，新的黑洞还会召唤暗物质；【大爆炸】也会有一定几率发生',
        },
        name = '观察者奥尔加隆',
        summary = {
            desc = '|cFF000000◆ 核心机制：P1按团长分配的顺序击杀[坍缩星]，避免4个[坍缩星]同时爆炸，从而造成过量伤害团队无法抵御；把[坍缩星]打掉会产生范围爆炸伤害，注意躲避，并且会在地面生成[黑洞]。这个[黑洞]可以进入，主要是在后面会来躲避BOSS团灭技能。当BOSS出[大爆炸]技能，外场留1个能抗住该机制的职业（比如暗牧的消散，骑士无敌、法师冰箱都不可抵御），其余人全部进黑洞躲避（其他必要场景下也可以根据团长指挥来把握进黑洞的时机）。场上还会有3个[星座]怪，这个怪一旦和[黑洞]接触就会跟[黑洞]中和，从而[黑洞]消失。所以T需要拉着[星座]控制好与[黑洞]的关系，比如，黑洞较多的时候，适当拉[星座]去中和消弭，但务必要保留1~2个[黑洞]，用于在[大爆炸]时躲避。并且在[大爆炸]的时候把握好拉怪的节奏：让所有需要进[黑洞]的角色先进去，然后自己在[黑洞]与[星座]中和之前也进去；躲避好BOSS随机点名的[宇宙重击]技能，会有陨石砸向地面，伤害非常高\n\n◆ P1其他注意事项：[坍缩星]尽量拉远离BOSS，避免误伤，从而破坏“修星”的节奏；进入黑洞，这些技能：法师冰箱、骑士无敌、盗贼斗篷和死亡骑士绿罩子都会被传出到外场，所以不要乱开\n\n◆ BOSS血量达到20%进入P2，P2场地上所有坍缩星、星座和黑洞都会消失，全力输出BOSS即可；BOSS会在4个新位置召唤4个新的黑洞，新的黑洞会不停刷新小怪[暗物质]；T需要拉好避免小怪骚扰治疗，同时打团和P1一样需要躲避[宇宙重击]。将BOSS打到3%血量，战斗结束，艾泽拉斯的勇士胜出！',
        },
        icon = '1385713',
    },
    [629] = {
        bossId = 629,
        abilities = {
            desc = [[|TInterface\AddOns\MeetingHorn\Media\Introduce\Introduce629:2580:320:0:0:1:1:0:1:0:1|t]],
        },
        name = '诺森德猛兽',
        summary = {
            desc = [[|TInterface\AddOns\MeetingHorn\Media\Introduce\Introduce629:2580:320:0:0:1:1:0:1:0:1|t]],
        },
        icon = '1390440',
    },
    [633] = {
        bossId = 633,
        abilities = {
            desc = [[|TInterface\AddOns\MeetingHorn\Media\Introduce\Introduce633:2580:320:0:0:1:1:0:1:0:1|t]],
        },
        name = '加拉克苏斯大王',
        summary = {
            desc = [[|TInterface\AddOns\MeetingHorn\Media\Introduce\Introduce633:2580:320:0:0:1:1:0:1:0:1|t]],
        },
        icon = '1385752',
    },
    [637] = {
        bossId = 637,
        abilities = {
            desc = [[|TInterface\AddOns\MeetingHorn\Media\Introduce\Introduce637:1250:320:0:0:1:1:0:1:0:1|t]],
        },
        name = GetUnitFactionGroupName() .. '的冠军',
        summary = {
            desc = [[|TInterface\AddOns\MeetingHorn\Media\Introduce\Introduce637:1250:320:0:0:1:1:0:1:0:1|t]],
        },
        icon = GetUnitFactionGroupIcon(),
    },
    [641] = {
        bossId = 641,
        abilities = {
            desc = [[|TInterface\AddOns\MeetingHorn\Media\Introduce\Introduce641:2580:320:0:0:1:1:0:1:0:1|t]],
        },
        name = '瓦格里双子',
        summary = {
            desc = [[|TInterface\AddOns\MeetingHorn\Media\Introduce\Introduce641:2580:320:0:0:1:1:0:1:0:1|t]],
        },
        icon = '1390443',
    },
    [645] = {
        bossId = 645,
        abilities = {
            desc = [[|TInterface\AddOns\MeetingHorn\Media\Introduce\Introduce645:2580:320:0:0:1:1:0:1:0:1|t]],
        },
        name = '阿努巴拉克',
        summary = {
            desc = [[|TInterface\AddOns\MeetingHorn\Media\Introduce\Introduce645:2580:320:0:0:1:1:0:1:0:1|t]],
        },
        icon = '607542',
    },
    [1624] = {
        bossId = 1624,
        abilities = {
            children = {
                {
                    children = {
                        {
                            spell = '69055',
                            title = '军刀猛刺',
                            noCollapse = false,
                            expanded = false,
                            desc = '对当前目标造成300%武器伤害，由当前目标以及附近8码2名玩家分担。',
                        },
                        {
                            spell = '69146',
                            title = '冷焰',
                            noCollapse = false,
                            expanded = false,
                            desc = '向随机一名玩家发射一条持续8秒的蓝色火焰，对触碰到的火焰的玩家每秒造成中额冰霜伤害。',
                        },
                        {
                            spell = '69057',
                            title = '天灾领主之刺',
                            noCollapse = false,
                            expanded = false,
                            desc = 'Boss随机向3名非坦克玩家投掷一枚骨针，使其无法移动，并立即造成小额物理伤害，并每2秒对其造成最大生命值10%的物理伤害，直至骨针被打破。',
                        },
                    },
                    noCollapse = false,
                    title = '第一阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '69075',
                            title = '白骨风暴',
                            noCollapse = false,
                            expanded = false,
                            desc = '读条3秒引导白骨风暴，选定离BOSS最远的玩家并沿路进行旋风，离Boss越远受到的伤害越低，Boss抵达冲锋位置后会施放'..(BuildSpellLink(69146) or "[冷焰]")..'并重新选定最远目标再次旋风，持续30秒。',
                        },
                        {
                            spell = '69146',
                            title = '冷焰',
                            noCollapse = false,
                            expanded = false,
                            desc = 'P2阶段会在Boss旋风至目标位置后施放4道冷焰。',
                        },
                        {
                            spell = '69057',
                            title = '天灾领主之刺',
                            noCollapse = false,
                            expanded = false,
                            desc = 'Boss随机向3名非坦克玩家投掷一枚骨针，使其无法移动，并立即造成小额物理伤害，并每2秒对其造成最大生命值10%的物理伤害，直至骨针被打破。',
                        },
                    },
                    noCollapse = false,
                    title = '第二阶段',
                    expanded = true,
                },
            },
        },
        name = '玛洛加尔领主',
        icon = '1378992',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1. 在Boss战中，应随时注意躲避脚下的' .. (BuildSpellLink(69146) or "[冷焰]") .. '。\n2. 近战应站在Boss红圈内输出，并注意BOSS正面坦克位置以防吃到' .. (BuildSpellLink(69055) or "[军刀猛刺]") .. '。 \n3.  场面上出现' .. (BuildSpellLink(69057) or "[骨针]") .. '应第一时间转火解救队友。\n4.  在P2阶段应远离Boss' .. (BuildSpellLink(69075) or "[白骨风暴]") .. '范围，躲避' .. (BuildSpellLink(69146) or "[冷焰]") .. '并转火' .. (BuildSpellLink(69057) or "[骨针]") .. '。转完阶段应等坦克接好Boss再进行输出。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '在Boss站中，治疗应随时关注中' .. (BuildSpellLink(69057) or "[骨针]") .. '的队友，躲避地上的' .. (BuildSpellLink(69146) or "[冷焰]") .. '，P2远离' .. (BuildSpellLink(69075) or "[白骨风暴]") .. '，保持与BOSS的距离进行治疗。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '在P1阶段BOSS站中，应时刻与其余坦克保持重叠分摊' .. (BuildSpellLink(69055) or "[军刀猛刺]") .. '伤害，P2阶段应第一时间前往团长安排的沙包位置（如存在此项任务），P2结束后应立即嘲讽Boss带往P1位置保持与T队友重合站位。',
                },
            },
            desc = ' 一、BOSS简介\n 玛洛加尔领主是冰冠堡垒的看门人，巫妖王亲手用一千个被他击败的生物的骸骨将它组合而成。他手持巨大的镰刀，对胆敢侵入的人宣判死刑。他是无数想挑战巫妖王的勇士们必须面对的第一道考验。\n二、综述\n2.1：团队配置推荐（3坦克5治疗17输出）\n2.2：玛洛加尔领主是冰冠堡垒的守门Boss，整场战斗分为2个阶段：P1和P2。50秒后进入P2，P2持续30秒转\n回P1以此循环。\n2.3：战斗核心策略：坦克重合分摊' .. (BuildSpellLink(69055) or "[军刀猛刺]") .. '，其余玩家规避地上的' .. (BuildSpellLink(69146) or "[冷焰]") .. '，转火' .. (BuildSpellLink(69057) or "[骨针]") .. '，躲避' .. (BuildSpellLink(69075) or "[白骨风暴]") .. '来进行最大化输出。P2' .. (BuildSpellLink(69075) or "[白骨风暴]") .. '阶段应安排沙包远离大团引导BOSS。',
        },
    },
    [1625] = {
        bossId = 1625,
        abilities = {
            children = {
                {
                    children = {
                        {
                            children = {
                                {
                                    spell = '70842',
                                    title = '法力壁垒',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = 'Boss笼罩在强大的屏障当中，该屏障会为施法者恢复其损失的生命值，但会消耗其法力值。每消耗1点法力可以为其提供一个2.5点吸收量护盾。',
                                },
                                {
                                    spell = '71289',
                                    title = '统御心灵',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '随机心控3名玩家，使其伤害提供200%，治疗效果提供500%，持续12秒。',
                                },
                                {
                                    spell = '71001',
                                    title = '死亡凋零',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = 'Boss随机选择一名玩家脚底，并对附近所有敌人造成每秒高额暗影伤害，并降低其移动速度。死亡凋零持续10秒。',
                                },
                                {
                                    spell = '71254',
                                    title = '暗影箭',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = 'Boss读条2秒，随机对一名玩家造成高额的暗影伤害。',
                                },
                            },
                            title = '亡语者女士',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
                            children = {
                                {
                                    spell = '70670',
                                    title = '暗影顺劈',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，对攻击者前方8码内的所有敌人造成高额暗影伤害。',
                                },
                                {
                                    spell = '70659',
                                    title = '死疽打击',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，使用一把诅咒的武器打击一名敌人，对其造成70%的武器伤害，并使其感染一种疾病，该疾病会给造成敌人高额的治疗吸收盾。',
                                },
                                {
                                    spell = '70674',
                                    title = '吸血鬼之力',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，施法者体内充盈着黑暗之力，使其造成的所有伤害提高25%，并且所造成伤害的300%将为施法者治疗。持续15秒。',
                                },
                                {
                                    spell = '71236',
                                    title = '黑暗殉道',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '亡语者命令一名教派狂热者施放黑暗殉道，引爆自身对15码范围内敌人造成高额暗影伤害，随后便重生为复活的狂热者。',
                                },
                                {
                                    spell = '70900',
                                    title = '黑暗突变',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '成为亡灵巨兽，体型增大，移动速度降低。造成的伤害提高100%。',
                                },
                            },
                            title = '教派狂热者',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
                            children = {
                                {
                                    spell = '70594',
                                    title = '死寒之箭',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '读条2秒，对一名敌方目标造成中额的暗影冰霜伤害。',
                                },
                                {
                                    spell = '71237',
                                    title = '麻痹诅咒',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '读条1秒，对一名随机敌方施放诅咒，使其所有冷却时间增加15秒，持续15秒。可驱散。',
                                },
                                {
                                    spell = '70768',
                                    title = '玄秘遮蔽',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '使施法者笼罩在一层强大的屏障中，该屏障会反射魔法攻击，并且免疫打断效果。最多吸收50000点伤害。',
                                },
                                {
                                    spell = '71236',
                                    title = '黑暗殉道',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '亡语者命令一名教派追随者施放黑暗殉道，引爆自身对15码范围内敌人造成高额暗影伤害，随后便重生为复活的追逐者。',
                                },
                                {
                                    spell = '70901',
                                    title = '黑暗增效',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '强化法术，使其造成范围伤害且不会被打断。',
                                },
                            },
                            title = '教派追随者',
                            noCollapse = false,
                            expanded = true,
                        },
                    },
                    noCollapse = false,
                    title = '第一阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            children = {
                                {
                                    spell = '71420',
                                    title = '寒冰箭',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '读条2秒，对一名玩家造成高额冰霜伤害，并使其移动速度降低50%，持续4秒。',
                                },
                                {
                                    spell = '72905',
                                    title = '寒冰箭雨',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '对附近所有玩家造成中额冰霜伤害，并使其移动速度降低，持续4秒。',
                                },
                                {
                                    spell = '71001',
                                    title = '死亡凋零',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = 'Boss随机选择一名玩家脚底，并对附近所有敌人造成每秒高额暗影伤害，并降低其移动速度。死亡凋零持续10秒。',
                                },
                                {
                                    spell = '71289',
                                    title = '统御心灵',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '随机心控3名玩家，使其伤害提供200%，治疗效果提供500%，持续12秒。',
                                },
                                {
                                    spell = '71204',
                                    title = '蔑视之触',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '对当前目标产生的威胁值减少20%，可叠加5层。',
                                },
                            },
                            title = '亡语者女士',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
                            children = {
                                {
                                    spell = '71544',
                                    title = '复仇冲击',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '亡语者女士发出召唤，在场地随机生成3只怨毒之影，追逐随机玩家，持续7秒。无法被选中。如触碰到被追逐的玩家会产生爆炸，对范围内玩家造成高额暗影冰霜伤害。',
                                },
                            },
                            title = '召唤怨毒之影',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
                            children = {
                                {
                                    spell = '70670',
                                    title = '暗影顺劈',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，对攻击者前方8码内的所有敌人造成高额暗影伤害。',
                                },
                                {
                                    spell = '70659',
                                    title = '死疽打击',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，使用一把诅咒的武器打击一名敌人，对其造成70%的武器伤害，并使其感染一种疾病，该疾病会给造成敌人高额的治疗吸收盾。',
                                },
                                {
                                    spell = '70674',
                                    title = '吸血鬼之力',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，施法者体内充盈着黑暗之力，使其造成的所有伤害提高25%，并且所造成伤害的300%将为施法者治疗。持续15秒。',
                                },
                                {
                                    spell = '71236',
                                    title = '黑暗殉道',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '亡语者命令一名教派狂热者施放黑暗殉道，引爆自身对15码范围内敌人造成高额暗影伤害，随后便重生为复活的狂热者。',
                                },
                                {
                                    spell = '70900',
                                    title = '黑暗突变',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '成为亡灵巨兽，体型增大，移动速度降低。造成的伤害提高100%。',
                                },
                            },
                            title = '教派狂热者',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
                            children = {
                                {
                                    spell = '70594',
                                    title = '死寒之箭',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '读条2秒，对一名敌方目标造成中额的暗影冰霜伤害。',
                                },
                                {
                                    spell = '71237',
                                    title = '麻痹诅咒',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '读条1秒，对一名随机敌方施放诅咒，使其所有冷却时间增加15秒，持续15秒。可驱散。',
                                },
                                {
                                    spell = '70768',
                                    title = '玄秘遮蔽',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '使施法者笼罩在一层强大的屏障中，该屏障会反射魔法攻击，并且免疫打断效果。最多吸收50000点伤害。',
                                },
                                {
                                    spell = '71236',
                                    title = '黑暗殉道',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '亡语者命令一名教派追随者施放黑暗殉道，引爆自身对15码范围内敌人造成高额暗影伤害，随后便重生为复活的追逐者。',
                                },
                                {
                                    spell = '70901',
                                    title = '黑暗增效',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '强化法术，使其造成范围伤害且不会被打断。',
                                },
                            },
                            title = '教派追随者',
                            noCollapse = false,
                            expanded = true,
                        },
                    },
                    noCollapse = false,
                    title = '第二阶段',
                    expanded = true,
                },
            },
        },
        name = '亡语者女士',
        icon = '1378990',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1.在Boss战中，应随时注意躲避脚下的'..(BuildSpellLink(71001) or "[死亡凋零]")..'。\n2.及时打断Boss暗影箭、寒冰箭以及小怪读条技能。\n3.控制职业应随时观察被'..(BuildSpellLink(71289) or "[统御心灵]")..'心控的队友及时控制以免误伤。\n4.Boss召唤的小怪应及时处理，被Boss强化之后的小怪应听从团长安排及时停手/远离/击杀。\n5.P2及时躲避怨毒之影，被追时应远离人群。\n6.驱散职业应及时驱散队友身上的减益Buff。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.治疗应随时躲避脚下的'..(BuildSpellLink(71001) or "[死亡凋零]")..'。\n2.及时驱散队友减益、驱散小怪增益。\n3.P2及时躲避怨毒之影，被追时应远离人群。\n4.P2Boss读条'..(BuildSpellLink(72905) or "[寒冰箭雨]")..'时应及时群体抬血。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.P1阶段及时聚好小怪方便Dps进行击杀处理。\n2.小怪被强化时，应及时打断、风筝。读条黑暗殉道(71236)时应及时远离小怪。\n3.P2应第一时间建立Boss仇恨并拉到指定位置，注意'..(BuildSpellLink(71204) or "[蔑视之触]")..'导致OT，建立第一第二仇恨。',
                },
            },
            desc = ' 一、BOSS简介\n 亡语者女士是冰冠堡垒副本中的一个强大首领。她是指挥诅咒神教的女巫妖，位于冰冠堡垒的下层区域。玩家在击败玛洛加尔领主后才能见到她。亡语者女士会指挥所有诅咒神教成员阻止玩家前进。\n二、综述\n1：团队配置推荐（3坦克5治疗17输出）\n2：亡语者女士是冰冠堡垒的下层区域第二位Boss，整场战斗分为2个阶段：P1和P2。P1对Boss造成伤害将损失Boss蓝量，蓝量耗尽进入P2。\n3：战斗核心策略：P1阶段应在处理好小怪的同时，尽可能在最短时间内把Boss蓝量耗尽转入P2。'..(BuildSpellLink(71289) or "[统御心灵]")..'需第一时间控制队友以免误伤，'..(BuildSpellLink(71001) or "[死亡凋零]")..'应立即躲开，P1和P2会召唤信徒加入战斗，应根据团长要求立即处理，P2阶段Boss还会召唤怨毒之影，及时躲避。',
        },
    },
    [725] = {
        bossId = 725,
        abilities = {
            children = {
                {
                    children = {
                        {
                            children = {
                                {
                                    spell = '72307',
                                    title = '战斗之怒',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，每次近战攻击都会使自己体型增大1%，造成伤害提高12%，持续16秒。可叠加。',
                                },
                                {
                                    spell = '30014',
                                    title = '顺劈斩',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，对当前目标和正面近战范围内最近的一个敌人造成110%的武器伤害。',
                                },
                                {
                                    spell = '70309',
                                    title = '撕裂投掷',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '将武器扔向远处敌人，对其造成中额物理伤害，并在18秒内每3秒造成小额物理伤害。',
                                },
                            },
                            title = '穆拉丁●铜须/萨鲁法尔大王',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
                            children = {
                                {
                                    spell = '69678',
                                    title = '火箭炮',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '5秒施法，瞄准敌方炮舰发射一枚会爆炸的火箭，落地后对附近5码敌人造成中额火焰伤害，并击退。并对炮舰本体造成伤害。',
                                },
                            },
                            title = '破天号炮兵/库卡隆炮手',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
                            children = {
                                {
                                    spell = '52771',
                                    title = '致伤打击',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，对目标造成200%的武器伤害，并使目标的所有治疗效果降低40%，持续10秒。',
                                },
                                {
                                    spell = '67541',
                                    title = '剑刃风暴',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '立即对附近目标发动旋风斩，持续6秒，无法被控制。',
                                },
                            },
                            title = '破天号陆战队员/库卡隆军士',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
                            children = {
                                {
                                    --spell = '69678',
                                    title = '射击/掷斧',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '2秒施法，对远处目标造成中额物理伤害。',
                                },
                            },
                            title = '破天号火枪手/库卡隆掷斧者',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
                            children = {
                                {
                                    spell = '69705',
                                    title = '零度冻结',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '将敌方所有火炮冻结入冰块中，持续15分钟。施法者必须引导才能保持冻结状态。',
                                },
                            },
                            title = '破天号巫师/库卡隆战斗法师',
                            noCollapse = false,
                            expanded = true,
                        },
                    },
                    noCollapse = false,
                    title = '第一阶段',
                    expanded = true,
                },
            },
        },
        name = '冰冠炮舰战斗',
        icon = '630819',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1.除了被安排上火炮的玩家，近战Dps清理本船小怪，远程Dps清理敌方炮舰小怪。\n2.火炮被冻结时，使用火箭背包飞跃到敌方炮舰击杀库卡隆战斗法师/破天号巫师',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.刷坦治疗注意看好首领战斗之怒层数，给予当前坦更多治疗。\n2.其余治疗刷好团血',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.注意躲避剑刃风暴。\n2.注意战斗之怒的层数根据层数交减伤。',
                },
                {
                    title = '炮手',
                    expanded = false,
                    desc = '炮管会过热，火炮轰炸施放8-9次放一次大技能灼烧冲击泄能。',
                },
            },
            desc = ' 一、BOSS简介\n 冰冠炮舰是一场载具混合战斗，当击杀亡语者女士后乘坐浮梯上升到平台，阵营的飞船在等待准备运送玩家抵达冰冠堡垒的上层地图，但是遇到敌对阵营的骚扰。浮梯达到平台后联盟走左边，部落走右边，击杀小怪后即可到达本阵营的船舰。\n二、综述\n1：团队配置推荐（2坦克4治疗19输出）\n2：冰冠炮舰是冰冠堡垒的下层区域第三位Boss，整场战斗分为2个阶段：P1和P2。P1通过火炮攻击敌方炮舰，火炮被冻结后进入P2。\n3：战斗核心策略：战斗开始前对话Npc获取火箭背包并装备上，P1阶段玩家利用火炮攻击对方舰船。T拉好小怪，其余玩家击杀小怪。当敌方法师/巫师施放零度冻结()时，火炮会被冻结，玩家应迅速通过火箭背包飞往敌方飞船快速击杀库卡隆战斗法师/破天号巫师，解冻火炮后再返回。以此循环直到敌方炮舰被摧毁。',
        },
    },
    [1628] = {
        bossId = 1628,
        abilities = {
            children = {
                {
                    children = {
                        {
                            spell = '72195',
                            title = '鲜血链接',
                            noCollapse = false,
                            expanded = false,
                            desc = '萨鲁法尔可以从他的技能和召唤物造成的伤害中汲取鲜血能量。',
                        },
                        {
                            spell = '72371',
                            title = '鲜血能量',
                            noCollapse = false,
                            expanded = false,
                            desc = '萨鲁法尔每获得1点鲜血能量，身体就会变大1%，所造成的伤害也会提高1%。最多可提高100%。',
                        },
                        {
                            spell = '72293',
                            title = '阵亡勇士印记',
                            noCollapse = false,
                            expanded = false,
                            desc = '萨鲁法尔'..(BuildSpellLink(72371) or "[鲜血能量]")..'满100后，随机对1名敌人施放阵亡勇士印记，并且萨鲁法尔的近战攻击会溅射到该目标，每次攻击将对印记目标造成物理伤害，此伤害受'..(BuildSpellLink(72371) or "[鲜血能量]")..'增益影响。如果印记目标死亡将治疗萨鲁法尔其总生命值的20%。印记无法以任何形式驱散，包括死亡。',
                        },
                        {
                            spell = '72723',
                            title = '坚韧之皮',
                            noCollapse = false,
                            expanded = false,
                            desc = '生物的皮肤坚韧，具有很强的抵抗力。效果范围攻击的伤害降低95%，并且受到的疾病伤害降低70%。',
                        },
                        {
                            spell = '72769',
                            title = '血之气息',
                            noCollapse = false,
                            expanded = false,
                            desc = '萨鲁法尔的血兽捕捉到血的气味，使附近10码范围内所有敌人移动速度降低80%，并使他们的伤害提高300%，持续10秒。',
                        },
                    },
                    noCollapse = false,
                    title = '第一阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '72737',
                            title = '狂乱',
                            noCollapse = false,
                            expanded = false,
                            desc = '当萨鲁法尔的生命值低于30%时，进入狂乱状态。使自身体型增大20%，攻击速度提高30%。同时第一阶段所有技能依然按序施放。',
                        },
                    },
                    noCollapse = false,
                    title = '第二阶段',
                    expanded = true,
                },
            },
        },
        name = '死亡使者萨鲁法尔',
        icon = '1378970',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1.与队友保持安全距离规避鲜血'..(BuildSpellLink(72380) or "[新星]")..'带来的Aoe伤害。\n2.被'..(BuildSpellLink(72385) or "[沸腾之血]")..'点名应及时开减伤防止减员。可用无敌、冰箱、保护之手消除。\n3.被'..(BuildSpellLink(72293) or "[阵亡勇士印记]")..'点名应规划开启减伤，印记不会消失直到你死亡。\n4.应及时处理血兽，时刻注意与血兽保持安全距离。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.与队友保持安全距离规避鲜血'..(BuildSpellLink(72380) or "[新星]")..'带来的Aoe伤害。\n2.根据团长安排治疗被'..(BuildSpellLink(72293) or "[阵亡勇士印记]")..'点名的玩家，如死亡则会为Boss回血。\n3.中'..(BuildSpellLink(72385) or "[沸腾之血]")..'的玩家应在持续时间内额外关注。\n4.Boss高能量时应格外注意治疗好中Debuff的玩家和坦克。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.在当前坦克中'..(BuildSpellLink(72410) or "[符文之血]")..'后，副T应及时嘲讽。\n2.Boss在高能量/低于30%血量时应注意规划自己的减伤。',
                },
            },
            desc = ' 一、BOSS简介\n 萨鲁法尔作为战歌远征军的将领，参加了远征诺森德的行动，并作为部落军团的先锋参加了愤怒之门安加萨的战役。是瓦罗克·萨鲁法尔之子和“赤斧”布洛克斯加的侄子。\n二、综述\n 2.1：团队配置推荐（2坦克5治疗18输出）\n2.2：冰冠炮舰是冰冠堡垒的下层区域第四位Boss，整场战斗分为2个阶段：P1和P2。P1应尽可能对Boss造成更多伤害的同时迅速击杀小怪，BOSS血量低于30%时进入P2，Boss会进入狂乱状态。Boss战属于软狂暴机制，应尽快击杀。\n2.3：战斗核心策略：Boss通过'..(BuildSpellLink(72195) or "[鲜血链接]")..'对玩家造成伤害增加自己的'..(BuildSpellLink(72371) or "[鲜血能量]")..'，玩家应减少自己承受的伤害来阻止Boss过快增长'..(BuildSpellLink(72371) or "[鲜血能量]")..'。Boss100能量会施放'..(BuildSpellLink(72293) or "[阵亡勇士的印记]")..'，治疗应刷好中'..(BuildSpellLink(72293) or "[阵亡勇士的印记]")..'玩家的同时刷好坦克，刷新血兽Dps应尽快处理。Boss血量低于30%会进入获得'..(BuildSpellLink(72737) or "[狂乱]")..'增益，应尽快击杀。',
        },
    },
    [1629] = {
        bossId = 1629,
        abilities = {
            children = {
                {
                    children = {
                        {
                            spell = '69165',
                            title = '凋零呼吸',
                            noCollapse = false,
                            expanded = false,
                            desc = '3秒读条，吸入房间里的'..(BuildSpellLink(69159) or "[凋零毒气]")..'，获得凋零呼吸增益，使其体型增大20%，攻击速度和物理伤害提供30%。烂肠30秒吸一次，最多叠加3层。',
                        },
                        {
                            spell = '69159',
                            title = '凋零毒气',
                            noCollapse = false,
                            expanded = false,
                            desc = '凋零毒气对所有玩家造成中额的暗影伤害。受每次施放'..(BuildSpellLink(69165) or "[凋零呼吸]")..'影响，伤害递减。',
                        },
                        {
                            spell = '72219',
                            title = '毒肿',
                            noCollapse = false,
                            expanded = false,
                            desc = '对当前目标造成中额伤害，并对目标施加一层毒肿减益，使伤害提高10%，持续2分钟，最高可叠加10层。并在10层造成'..(BuildSpellLink(72227) or "[毒性爆炸]")..'，对附近的玩家造成高额伤害。',
                        },
                        {
                            spell = '72227',
                            title = '毒性爆炸',
                            noCollapse = false,
                            expanded = false,
                            desc = '毒肿10层后引起毒性爆炸，对附近的所有玩家造成高额的暗影伤害。同时目标玩家即刻死亡。',
                        },
                        {
                            spell = '69240',
                            title = '邪恶毒气',
                            noCollapse = false,
                            expanded = false,
                            desc = '烂肠随机对远处的三名玩家范围施放一个邪恶毒气，每2秒造成小额暗影伤害，持续6秒。邪恶毒气会使其无法控制的呕吐，并对其8码范围内所有玩家造成小额暗影伤害。',
                        },
                        {
                            spell = '69278',
                            title = '毒气孢子',
                            noCollapse = false,
                            expanded = false,
                            desc = '烂肠随机对3名玩家'..(BuildSpellLink(69279) or "[感染毒性孢子]")..'减益，持续12秒。持续时间结束后，毒气孢子会爆炸并使8码内的所有玩家'..(BuildSpellLink(69290) or "[感染枯萎的孢子]")..'。',
                        },
                        {
                            spell = '69290',
                            title = '枯萎的孢子',
                            noCollapse = false,
                            expanded = false,
                            desc = '被感染的玩家每秒受到中额暗影伤害，持续6秒。持续时间结束后，此玩家会获得播种疫苗影响。',
                        },
                        {
                            spell = '69291',
                            title = '播种疫苗',
                            noCollapse = false,
                            expanded = false,
                            desc = '使你对'..(BuildSpellLink(69159) or "[凋零毒气]")..'产生抗性，受到的暗影伤害降低25%，持续2分钟。该效果最多叠加3层。',
                        },
                        {
                            spell = '69195',
                            title = '刺鼻毒气',
                            noCollapse = false,
                            expanded = false,
                            desc = '烂肠获得3层'..(BuildSpellLink(69165) or "[凋零呼吸]")..'后一段时间，开始3秒读条，对所有玩家造成高额的暗影伤害，并将致命的'..(BuildSpellLink(69159) or "[凋零毒气]")..'重新放回房间内。',
                        },
                        {
                            spell = '72297',
                            title = '可延展的粘液(英雄难度)',
                            noCollapse = false,
                            expanded = false,
                            desc = '普崔塞德教授随机选定玩家所在的区域扔出一团弹跳的可延展粘液，粘液在弹跳2次后落地爆炸，对目标区域半径8码范围内的玩家造成中额自然暗影伤害，并降低其攻击和施法速度250%，持续20秒。',
                        },
                    },
                    noCollapse = false,
                    title = '第一阶段',
                    expanded = true,
                },
            },
        },
        name = '烂肠',
        icon = '1378972',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1.与队友保持安全距离规避中'..(BuildSpellLink(69240) or "[邪恶毒气]")..'玩家带来的Aoe伤害和失控效果。\n2.中'..(BuildSpellLink(69278) or "[毒气孢子]")..'后应按照团长要求迅速站定位置等待其余队友向你集合。爆炸之后迅速回原来的位置。\n3.Boss在施放'..(BuildSpellLink(69165) or "[刺鼻毒气]")..'时，如不满3层'..(BuildSpellLink(69291) or "[播种疫苗]")..'的增益，应立即开启减伤或无敌类技能规避死亡。\n4.英雄难度下，应时刻关注可'..(BuildSpellLink(72297) or "[延展黏液]")..'的弹跳位置及时小范围躲避',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.与队友保持安全距离规避中'..(BuildSpellLink(69240) or "[邪恶毒气]")..'玩家带来的Aoe伤害和失控效果。\n2.中'..(BuildSpellLink(69278) or "[毒气孢子]")..'后应按照团长要求迅速站定位置等待其余队友向你集合。爆炸之后迅速回原来的位置。\n3.Boss在施放'..(BuildSpellLink(69165) or "[刺鼻毒气]")..'时，如不满3层'..(BuildSpellLink(69291) or "[播种疫苗]")..'的增益，应立即开启减伤或无敌类技能规避死亡。\n4.在当前坦克叠加'..(BuildSpellLink(72219) or "[毒肿]")..'层数过高时，应额外提供治疗。\n5.英雄难度下，应时刻关注可'..(BuildSpellLink(72297) or "[延展黏液]")..'的弹跳位置及时小范围躲避。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.坦克应时刻关注对方的'..(BuildSpellLink(72219) or "[毒肿]")..'减益，通过约定层数换嘲。\n2.防止'..(BuildSpellLink(72219) or "[毒肿]")..'减益叠到10层，否则会导致死亡并且对范围内玩家造成高额伤害。',
                },
            },
            desc = ' 一、BOSS简介\n 烂肠与他的兄弟腐面想把进入冰冠堡垒的玩家通通杀光，以赢得父亲（普崔塞德教授）的肯定。同时也替自己死去的小狗报仇。\n二、综述\n 2.1：团队配置推荐（2坦克5治疗18输出）\n2.2：烂肠是位于冰冠堡垒上层区域的首领之一，整场战斗只有1个阶段，玩家需要通过获得'..(BuildSpellLink(69291) or "[播种疫苗]")..'的增益来应对Boss施放的'..(BuildSpellLink(69165) or "[刺鼻毒气]")..'，并快速进行击杀。\n2.3：战斗核心策略：Boss技能机制环环相扣，中'..(BuildSpellLink(69278) or "[毒气孢子]")..'的玩家需根据团长安排站位，其余玩家应迅速与其集合，通过'..(BuildSpellLink(69278) or "[毒气孢子]")..'爆炸感染玩家'..(BuildSpellLink(69291) or "[播种疫苗]")..'的增益来避免Boss施放'..(BuildSpellLink(69165) or "[刺鼻毒气]")..'时导致死亡。其余时候应保持分散来规避被'..(BuildSpellLink(69240) or "[邪恶毒气]")..'点名的玩家。在英雄难度下，额外技能可'..(BuildSpellLink(72297) or "[延展黏液]")..'应及时查看其弹跳位置及时小范围躲避。',
        },
    },
    [1630] = {
        bossId = 1630,
        abilities = {
            children = {
                {
                    children = {
                        {
                            spell = '69789',
                            title = '软泥洪流',
                            noCollapse = false,
                            expanded = false,
                            desc = '每隔20秒会有一对软泥管道开启，向地面放出覆盖房间1/4范围位置的软泥洪流，持续20秒。当有生物踏入时，每秒会受到中额自然暗影伤害，并使其移动速度降低10%，持续5秒。可叠加10层直到无法移动。',
                        },
                        {
                            spell = '69508',
                            title = '软泥喷射',
                            noCollapse = false,
                            expanded = false,
                            desc = '施法1.5秒引导，随机瞄准1名玩家当前所在位置，对其前方锥形区域引导施法，对玩家造成每秒中额自然暗影伤害，持续5秒。',
                        },
                        {
                            spell = '72272',
                            title = '邪恶毒气(英雄难度)',
                            noCollapse = false,
                            expanded = false,
                            desc = '普崔赛德教授随机对远处的三名玩家范围施放一个邪恶毒气，每2秒造成小额暗影伤害，持续6秒。邪恶毒气会使其无法控制的呕吐，并对其8码范围内所有玩家每2秒造成小额暗影伤害。优先对远离腐面玩家施放。',
                        },
                        {
                            spell = '69674',
                            title = '畸变感染',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发，随机对1名非坦克玩家施放疾病，每秒对其造成小额自然暗影伤害，并在12秒内降低玩家75%受到的治疗效果。被驱散后，会在目标处位置生成1个小软泥怪。',
                        },
                        {
                            spell = '69778',
                            title = '粘稠的软泥',
                            noCollapse = false,
                            expanded = false,
                            desc = '读条1秒，朝正面23码内喷射一滩绿水。对处在绿水区域的玩家每秒造成小额自然暗影伤害，并使其降低移动速度50%。',
                        },
                        {
                            spell = '69558',
                            title = '不稳定的软泥怪',
                            noCollapse = false,
                            expanded = false,
                            desc = '每次大软泥怪与其它软泥怪融合时，它会变得更加不稳定，体型增大，造成的伤害提高20%。可叠加10次。',
                        },
                        {
                            spell = '69833',
                            title = '不稳定的软泥爆炸',
                            noCollapse = false,
                            expanded = false,
                            desc = '当大软泥怪与其它软泥怪融合5次之后，它会引爆自己，并朝就近玩家位置投射软泥炸弹，软泥炸弹会瞄准目标当前所在位置缓慢抛射，落地后会对目标位置6码内所有玩家造成高额自然暗影伤害。',
                        },
                    },
                    noCollapse = false,
                    title = '第一阶段',
                    expanded = true,
                },
            },
        },
        name = '腐面',
        icon = '1379009',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1.时刻关注Boss头前朝向躲避'..(BuildSpellLink(69508) or "[软泥喷射]")..'。\n2.中'..(BuildSpellLink(69674) or "[畸变感染]")..'后应立即远离人群等待驱散，小软形成后引到大软附近进行融合并且时刻远离大软。\n3.大软在读条不稳定的'..(BuildSpellLink(69833) or "[软泥爆炸]")..'结束时需离开自己当前所在位置和队友当前所在位置。\n4.时刻关注'..(BuildSpellLink(69789) or "[软泥洪流]")..'所影响的区域，防止受到伤害。\n5.英雄难度下，应分散站位规避队友中'..(BuildSpellLink(72272) or "[邪恶毒气]")..'带来的范围AOE和失控。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.时刻关注Boss头前朝向躲避'..(BuildSpellLink(69508) or "[软泥喷射]")..'。\n2.中'..(BuildSpellLink(69674) or "[畸变感染]")..'后应立即远离人群驱散自己/驱散队友，小软形成后引到大软附近进行融合并且时刻远离大软。\n3.大软在读条不稳定的'..(BuildSpellLink(69833) or "[软泥爆炸]")..'结束时需离开自己当前所在位置和队友当前所在位置。并且根据团长开启减伤。\n4.时刻关注'..(BuildSpellLink(69789) or "[软泥洪流]")..'所影响的区域，防止受到伤害。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.主坦克应注意Boss所在位置，远离大软并且在软泥爆炸时及时微调位置。\n2.风筝坦应保持与大软的距离，并且时刻关注小软位置进行融合。不稳定的'..(BuildSpellLink(69833) or "[软泥爆炸]")..'前应及时通知队友。',
                },
            },
            desc = ' 一、BOSS简介\n 腐面是普崔赛德教授的得意作品。腐面与他的兄弟烂肠是打算要将敢于踏入冰冠堡垒的敌人统统杀光，以赢得父亲普崔塞德教授的欢心，同时也替自己死去的小狗报仇。\n二、综述\n 2.1：团队配置推荐（2坦克5治疗18输出）\n2.2：腐面是位于冰冠堡垒上层区域的首领之一，整场战斗只有1个阶段。玩家需规避'..(BuildSpellLink(69789) or "[软泥洪流]")..'，并在中'..(BuildSpellLink(69674) or "[畸变感染]")..'时去寻找大软融合，然后寻找位置尽可能快的击杀Boss。\n2.3：战斗核心策略：玩家需要躲避'..(BuildSpellLink(69789) or "[软泥洪流]")..'的绿圈范围进行治疗和输出，躲避Boss朝向施放的'..(BuildSpellLink(69508) or "[软泥喷射]")..'，在中'..(BuildSpellLink(69674) or "[畸变感染]")..'时立即远离人群等待驱散，小软形成后去寻找大软进行融合，坦克需风筝大软远离大团，不稳定的'..(BuildSpellLink(69833) or "[软泥爆炸]")..'时需所有人离开自己当前所在位置。并快速进行击杀Boss。英雄难度下，还需安排远程沙包组在远处吸引'..(BuildSpellLink(72272) or "[邪恶毒气]")..'以免点名大团成员。',
        },
    },
    [1631] = {
        bossId = 1631,
        abilities = {
            children = {
                {
                    children = {
                        {
                            spell = '70911',
                            title = '肆虐毒疫',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，普崔塞德教授会随机向1名敌人施放，对其造成小额暗影伤害，且每1秒都会递增造成25%的暗影伤害，持续1分钟。如果感染的玩家身边5码内有其余玩家，还会继续传染。感染过'..(BuildSpellLink(70911) or "[肆虐毒疫]")..'后，会获得1层天灾疾病。',
                        },
                        {
                            spell = '70953',
                            title = '天灾疾病',
                            noCollapse = false,
                            expanded = false,
                            desc = '使其下次受到'..(BuildSpellLink(70911) or "[肆虐毒疫]")..'的伤害提高250%，最多叠加10层，持续1分钟。',
                        },
                        {
                            spell = '70346',
                            title = '软泥滩',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，向2名随机玩家当前所在位置扔出一团变异黏液，落地后会形成一滩逐渐蔓延的绿色软泥滩。对踩中的目标造成中额自然暗影伤害。可被'..(BuildSpellLink(37672) or "[畸变的憎恶]")..'吞食，并使它获得4点软泥能量。',
                        },
                        {
                            spell = '70351',
                            title = '不稳定的实验',
                            noCollapse = false,
                            expanded = false,
                            desc = '2.5秒施法，普崔塞德教授进行一项不稳定的实验！从Boss初始位置右侧召唤1只[不稳定的软泥怪]，随后左侧召唤1只毒气之云(37562)。',
                        },
                        {
                            spell = '70447',
                            title = '不稳定的软泥怪粘合剂',
                            noCollapse = false,
                            expanded = false,
                            desc = '3秒施法，随机选定1个目标施放粘合剂将目标粘在原地，同时每1秒受到中额的自然暗影伤害。',
                        },
                        {
                            spell = '69558',
                            title = '不稳定的软泥怪',
                            noCollapse = false,
                            expanded = false,
                            desc = '每次大软泥怪与其它软泥怪融合时，它会变得更加不稳定，体型增大，造成的伤害提高20%。可叠加10次。',
                        },
                        {
                            spell = '70492',
                            title = '软泥喷发',
                            noCollapse = false,
                            expanded = false,
                            desc = '[不稳定的软泥怪]向目标移动，触碰到时将造成高额伤害，该伤害将由附近所有目标分摊并击退。',
                        },
                        {
                            children = {
                                {
                                    spell = '70672',
                                    title = '毒肿',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '3秒施法，随机锁定1名玩家，每2秒造成中额自然暗影伤害并追赶目标玩家。毒肿起始10层，每次造成伤害减少1层。层数为0时，会重新锁定目标。如果追上玩家会施放所有气体，对所有玩家造成毁灭毒气伤害。',
                                },
                                {
                                    spell = '70701',
                                    title = '毁灭毒气',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，毒气之云的攻击释放了该目标身上的所有气体！对所有敌人造成伤害。',
                                },
                            },
                            title = '毒气之云',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
                            children = {
                                {
                                    spell = '70402',
                                    title = '畸变',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '畸变的憎恶产生的疾病对所有玩家每2秒造成中额暗影伤害。光环技能。',
                                },
                                {
                                    spell = '70360',
                                    title = '吞食软泥',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，吞食附近的软泥滩来缩小池区大小，并获得4点软泥能量。',
                                },
                                {
                                    spell = '70539',
                                    title = '回流软泥',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，使目标降低50%移动速度，并造成高额自然暗影伤害，范围50码，持续20秒。',
                                },
                                {
                                    spell = '70542',
                                    title = '变异打击',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，近战范围立即造成100%的武器伤害，并使目标物理抗性降低4%，持续20秒，可叠加5层。',
                                },
                            },
                            title = '畸变的憎恶',
                            noCollapse = false,
                            expanded = true,
                        },
                    },
                    noCollapse = false,
                    title = '第一阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '70346',
                            title = '软泥滩',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，向2名随机玩家当前所在位置扔出一团变异黏液，落地后会形成一滩逐渐蔓延的绿色软泥滩。对踩中的目标造成中额自然暗影伤害。可被畸变的憎恶(37672)吞食，并使它获得4点软泥能量。',
                        },
                        {
                            spell = '70351',
                            title = '不稳定的实验',
                            noCollapse = false,
                            expanded = false,
                            desc = '2.5秒施法，普崔塞德教授进行一项不稳定的实验！从Boss初始位置右侧召唤1只不稳定的软泥怪(37697)，随后左侧召唤1只毒气之云(37562)。',
                        },
                        {
                            spell = '70447',
                            title = '软泥滩',
                            noCollapse = false,
                            expanded = false,
                            desc = '3秒施法，随机选定1个目标施放粘合剂将目标粘在原地，同时每1秒受到中额的自然暗影伤害。',
                        },
                        {
                            spell = '70492',
                            title = '软泥喷发',
                            noCollapse = false,
                            expanded = false,
                            desc = '[不稳定的软泥怪]向目标移动，触碰到时将造成高额伤害，该伤害将由附近所有目标分摊并击退。',
                        },
                        {
                            spell = '70672',
                            title = '毒肿',
                            noCollapse = false,
                            expanded = false,
                            desc = '3秒施法，随机锁定1名玩家，每2秒造成中额自然暗影伤害并追赶目标玩家。毒肿起始10层，每次造成伤害减少1层。层数为0时，会重新锁定目标。如果追上玩家会施放所有气体，对所有玩家造成毁灭毒气伤害。',
                        },
                        {
                            spell = '70701',
                            title = '毁灭毒气',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，毒气之云的攻击释放了该目标身上的所有气体！对所有敌人造成伤害。',
                        },
                        {
                            spell = '71255',
                            title = '窒息毒气弹',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，普崔塞德教授朝自己周围投掷2枚毒气炸弹，落地后产生窒息毒气，毒气范围内的玩家每秒造成中额暗影伤害，并使其命中降低100%，持续15秒。毒气弹会在20秒后发生爆炸，对10码范围内玩家造成高额暗影伤害，将其击退并使其命中几率降低100%，持续20秒。',
                        },
                        {
                            spell = '72295',
                            title = '可延展黏液',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，朝3名随机玩家所在的区域扔出一团弹跳的可延展黏液，黏液在弹跳2次后爆炸，对目标区域5码范围内的玩家造成高额自然暗影伤害，并降低攻击和施法速度250%，持续15秒。',
                        },
                    },
                    title = '第二阶段',
                    noCollapse = false,
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '72840',
                            title = '危险实验(英雄难度)',
                            noCollapse = false,
                            expanded = false,
                            desc = '2.5秒施法，普崔塞德教授对所有玩家进行一项邪恶的实验！使一半玩家被软泥特性影响，另一半玩家被异变毒气影响。并召唤软泥怪。',
                        },
                        {
                            spell = '70352',
                            title = '软泥特性',
                            noCollapse = false,
                            expanded = false,
                            desc = '你有了软泥特性！你将被同样有软泥特性的怪物视为目标。你将无法伤害气态怪物。',
                        },
                        {
                            spell = '70353',
                            title = '异变毒气',
                            noCollapse = false,
                            expanded = false,
                            desc = '你有了气体特性！你将被同样有软泥特性的怪物视为目标。你将无法伤害软泥怪物。',
                        },
                        {
                            spell = '70351',
                            title = '不稳定的实验',
                            noCollapse = false,
                            expanded = false,
                            desc = '普崔塞德教授进行一项不稳定的实验！从Boss初始位置右侧召唤1只[不稳定的软泥怪]，随后左侧召唤1只毒气之云(37562)。',
                        },
                        {
                            spell = '71621',
                            title = '调制化合药剂',
                            noCollapse = false,
                            expanded = false,
                            desc = '普崔塞德教授正把实验室桌子翻个底朝天，找那瓶效力极强的药剂！持续30秒。',
                        },
                        {
                            spell = '71603',
                            title = '疯狂试药',
                            noCollapse = false,
                            expanded = false,
                            desc = '普崔塞德教授开始一瓶瓶地试喝桌上的所有药剂！持续20秒。',
                        },
                    },
                    title = '阶段转换',
                    noCollapse = false,
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '71603',
                            title = '畸变之力',
                            noCollapse = false,
                            expanded = false,
                            desc = '普崔塞德教授开始一瓶瓶地试喝桌上的所有药剂并开始完全变异，使得他物理伤害提高50%，攻击速度提高50%，攻击还会使得他畸变更加严重，会对当前目标释放畸变瘟疫。',
                        },
                        {
                            spell = '72451',
                            title = '畸变瘟疫',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发。朝当前目标释放畸变瘟疫，持续3分钟。可叠加。每1个带有畸变瘟疫的玩家会每3秒对所有玩家造成小额暗影伤害。每多叠加1层，该伤害将提高3倍。当畸变瘟疫从玩家身上消失时，每一层畸变瘟疫会为普崔塞德教授回复210万生命值。',
                        },
                        {
                            spell = '70341',
                            title = '软泥滩',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，向2名随机玩家当前所在位置扔出一团变异黏液，落地后会形成一滩逐渐蔓延的绿色软泥滩。对踩中的目标造成中额自然暗影伤害。',
                        },
                        {
                            spell = '71255',
                            title = '窒息毒气弹',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，普崔塞德教授朝自己周围投掷2枚毒气炸弹，落地后产生窒息毒气，毒气范围内的玩家每秒造成中额暗影伤害，并使其命中降低100%，持续15秒。毒气弹会在20秒后发生爆炸，对10码范围内玩家造成高额暗影伤害，将其击退并使其命中几率降低100%，持续20秒。',
                        },
                        {
                            spell = '72295',
                            title = '可延展黏液',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，朝3名随机玩家所在的区域扔出一团弹跳的可延展黏液，黏液在弹跳2次后爆炸，对目标区域5码范围内的玩家造成高额自然暗影伤害，并降低攻击和施法速度250%，持续15秒。',
                        },
                        {
                            title = '狂暴',
                            noCollapse = false,
                            expanded = false,
                            desc = '10分钟后，Boss伤害能力提高900%，攻击速度提高150%。',
                        },
                    },
                    title = '第三阶段',
                    noCollapse = false,
                    expanded = true,
                },
            },
        },
        name = '普崔塞德教授',
        icon = '1379007',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1.根据团长要求处理'..(BuildSpellLink(70911) or "[肆虐毒疫]")..'。例如：传染沙包组或一起承担。\n2.躲避'..(BuildSpellLink(71255) or "[窒息毒气弹]")..'和可'..(BuildSpellLink(72295) or "[延展的粘液]")..'。\n当有软泥怪时，应第一时间进行转火。\n3.当被'..(BuildSpellLink(70672) or "[红软泥怪]")..'锁定时，应第一时间进行风筝。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.根据团长要求治疗'..(BuildSpellLink(70911) or "[肆虐毒疫]")..'。例如：传染沙包组或一起承担需治疗。\n2.躲避'..(BuildSpellLink(71255) or "[窒息毒气弹]")..'和可'..(BuildSpellLink(72295) or "[延展的粘液]")..'。\n治疗关注被'..(BuildSpellLink(70672) or "[红软泥怪]")..'锁定的玩家。\n3.负责治疗坦克的玩家应时刻注意当前目标的血线。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.Boss时刻注意背对人群，及时带位规避'..(BuildSpellLink(70346) or "[软泥滩]")..'和'..(BuildSpellLink(71255) or "[窒息毒气弹]")..'。\n2.P3阶段有规划的移动，注意坦克互相之间的'..(BuildSpellLink(72451) or "[畸变瘟疫]")..'层数以及持续时间，注意换坦。',
                },
            },
            desc = ' 一、BOSS简介\n 普崔塞德教授这位天才科学家在自己的实验室为天灾军团开发各种瘟疫、凋零、毒气和软泥。\n二、综述\n 2.1：团队配置推荐（3坦克5治疗17输出）\n2.2：普崔塞德教授是冰冠堡垒瘟疫区守关BOSS，整场战斗分为3个阶段。P1阶段：100%-80%血量，P2阶段：80%-35%，P3阶段：35%-0%，并且具有阶段转换时间轴。\n2.3：战斗核心策略：驾驶[畸变的憎恶]坦克需利用技能吸收绿圈，减速软泥等操作。按照团长策略处理'..(BuildSpellLink(70911) or "[肆虐毒疫]")..'，其余玩家应躲避'..(BuildSpellLink(70346) or "[软泥滩]")..'，可'..(BuildSpellLink(72295) or "[延展的粘液]")..'，近战躲避'..(BuildSpellLink(71255) or "[窒息毒气弹]")..'，被'..(BuildSpellLink(70447) or "[绿软泥怪]")..'和'..(BuildSpellLink(70672) or "[红软泥怪]")..'锁定其余玩家都应及时转火处理。转阶段你将获得'..(BuildSpellLink(70352) or "[软泥特性]")..'和'..(BuildSpellLink(70353) or "[异变毒气]")..'根据特性击杀对应软泥怪。P3坦克注意'..(BuildSpellLink(72451) or "[畸变瘟疫]")..'合理换坦保持层数以免给Boss回血，其余玩家应合理站位最大化利用场地处理'..(BuildSpellLink(70346) or "[软泥滩]")..'位置。',
        },
    },
    [1632] = {
        bossId = 1632,
        abilities = {
            children = {
                {
                    children = {
                        {
						    children = {
								{
									spell = '70952',
									title = '鲜血唤醒',
									noCollapse = false,
									expanded = false,
									desc = '黑暗堕落者的宝珠，会每45秒控制三个王子的其中一位，使其充满能量，并赐予他更多强大的能力。开战后，三个王子都会进入战斗并共享生命值，但只有被鲜血唤醒的王子被赋予生命值和强化他的能力。',
								},
								{
									spell = '72999',
									title = '暗影牢笼(英雄难度)',
									noCollapse = false,
									expanded = false,
									desc = '束缚一名敌人，被束缚的敌人只要移动，就会受到小额起始暗影伤害，每移动一秒，伤害提高。10秒内保持不动则会重置该效果。',
								},
							},
                            title = '全局技能',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
						    children = {
								{
									spell = '72052',
									title = '动力炸弹',
									noCollapse = false,
									expanded = false,
									desc = '1.5秒施法，召唤一枚在空中缓慢落向地面的动力炸弹。炸弹接触到地面爆炸。造成50码范围内所有玩家高额物理伤害，并将敌人击飞。直接攻击的伤害会被动力炸弹吸收并转换为能量，使炸弹飞的更高阻止它落地。动力炸弹最多存在1分钟。',
								},
								{
									spell = '71944',
									title = '震荡涡流',
									noCollapse = false,
									expanded = false,
									desc = '随机在1名玩家脚下召唤一团小型的震荡漩涡，5秒后形成半径12码的震荡涡流，持续20秒。触碰到震荡涡流的玩家将受到中额物理伤害，并击退。',
								},
                                {
                                    spell = '72039',
                                    title = '强能震荡涡流',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '4.5秒读条，瓦拉纳王子在所有玩家脚下立即召唤一道强猛的冲击涡流。对玩家造成中额物理伤害，并对其12码范围内的其余玩家造成中额物理伤害并将其击退。',
                                },
							},
                            title = '瓦拉纳王子',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
						    children = {
								{
									spell = '71807',
									title = '闪耀火花',
									noCollapse = false,
									expanded = false,
									desc = '瞬发技，每20秒塔达拉姆王子朝自己前方锥形区域发射闪耀火花，对所有玩家造成每2秒中额火焰伤害，并使其移动速度降低40%的魔法效果，持续8秒。可被驱散。',
								},
								{
									spell = '71718',
									title = '幻化烈焰',
									noCollapse = false,
									expanded = false,
									desc = '3秒施法，召唤一个烈焰之球(38332)并追逐玩家，飞向目标并命中时爆炸。',
								},
                                {
									spell = '38332',
									title = '烈焰之球',
									noCollapse = false,
									expanded = false,
									desc = '在触碰到目标后发生爆炸，对15码范围内的所有玩家造成高额火焰伤害。烈焰之球会在空中飞行时间越长，爆炸时造成的伤害越低。',
								},
                                {
									spell = '72040',
									title = '塑造强能烈焰',
									noCollapse = false,
									expanded = false,
									desc = '3秒施法，随机点名1名玩家，召唤一个强能炼狱火球(38451)并追逐玩家，飞向目标并在命中时爆炸。',
								},
                                {
									spell = '38451',
									title = '炼狱火球',
									noCollapse = false,
									expanded = false,
									desc = '在触碰到目标后发生爆炸，对15码范围内的所有玩家造成高额火焰伤害。还会对10码范围内玩家造成每秒小额火焰伤害来释放能量，能量释放的越多，爆炸时造成的伤害越低。',
								},
							},
                            title = '塔达拉姆王子',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
						    children = {
								{
									spell = '71405',
									title = '影枪',
									noCollapse = false,
									expanded = false,
									desc = '1.5秒施法，对当前目标射出一发黑暗魔法之箭，造成高额暗影伤害。',
								},
								{
									spell = '71815',
									title = '强能影枪',
									noCollapse = false,
									expanded = false,
									desc = '1.5秒施法，对当前目标射出一发黑暗魔法之箭，造成巨额暗影伤害。',
								},
                                {
									spell = '38369',
									title = '召唤黑暗之核',
									noCollapse = false,
									expanded = false,
									desc = '凯雷塞斯王子每隔10秒会召唤一个黑暗之核。',
								},
                                {
									spell = '71822',
									title = '黑暗之核',
									noCollapse = false,
									expanded = false,
									desc = '瞬发技，当目标靠近黑暗之核15码内的时候与暗影产生共鸣，造成每3秒小额暗影伤害，并使其受到的所有类型的暗影伤害降低35%。',
								},
							},
                            title = '凯雷塞斯王子',
                            noCollapse = false,
                            expanded = true,
                        },
                    },
                    noCollapse = false,
                    title = '第一阶段',
                    expanded = true,
                },
            },
        },
        name = '鲜血王子议会',
        icon = '1385721',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1.根据分配的站位，'..(BuildSpellLink(72039) or "[强能震荡涡流]")..'读条时迅速分散并保持12码。\n2.在击杀凯雷赛德王子时，不要用AOE技能误伤到'..(BuildSpellLink(38369) or "[黑暗之核]")..'。\n3.被'..(BuildSpellLink(72040) or "[塑造强能烈焰]")..'点名的玩家及时离开人群。\n4.被分配打'..(BuildSpellLink(72052) or "[动力炸弹]")..'的玩家，应时刻关注其高度。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.快速驱散中'..(BuildSpellLink(71807) or "[闪耀火花]")..'的玩家。\n被'..(BuildSpellLink(72040) or "[塑造强能烈焰]")..'点名的玩家及时离开人群并注意团队血量。\n2.根据分配的站位，'..(BuildSpellLink(72039) or "[强能震荡涡流]")..'读条时迅速分散并保持12码，并注意团队血量。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.根据团长安排的任务拉对应Boss，除了拉凯雷塞斯的坦克，其余坦克尽量不要过多移动位置。\n2.拉凯雷塞斯的坦克应时刻注意'..(BuildSpellLink(38369) or "[黑暗之核]")..'的位置和仇恨。确保自己有足够的减伤。\n3.注意躲避'..(BuildSpellLink(72039) or "[强能震荡涡流]")..'。',
                },
            },
            desc = ' 一、BOSS简介\n 瓦拉纳王子、塔达拉姆王子、凯雷塞斯王子三个分别已经战死在俄塞、北风的恩吉拉圣城和古王国。鲜血女王兰娜瑟尔用鲜血宝珠复活了他们，他们3个共享生命值，并受到黑暗堕落者的鲜血宝珠的控制，展开对远征军的复仇。\n二、综述\n 2.1：团队配置推荐（3坦克5治疗17输出）\n2.2：鲜血王子议会位于冰冠堡垒赤红大厅入口的第一个Boss。整场战斗每46秒切换王子。\n2.3：战斗核心策略：每46秒会通过'..(BuildSpellLink(70952) or "[鲜血唤醒]")..'技能强化其中1位Boss，瓦拉纳王子强化时需要合理分散站位来规避'..(BuildSpellLink(72039) or "[强能震荡涡流]")..'，塔达拉姆王子强化时被'..(BuildSpellLink(72040) or "[塑造强能烈焰]")..'点名的玩家及时离开人群，凯雷塞斯王子强化时不要使用AOE技能，避免误伤'..(BuildSpellLink(38369) or "[黑暗之核]")..'，全程需注意'..(BuildSpellLink(72052) or "[动力炸弹]")..'对其造成伤害不要让它落地。在英雄难度下，暗影牢笼(72999)技能会限制我们移动并造成伤害，应减少移动频率。',
        },
    },
    [1633] = {
        bossId = 1633,
        abilities = {
            children = {
                {
                    children = {
                        {
                            children = {
                                {
                                    spell = '70985',
                                    title = '哀伤之雾',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '施法者体内散发出一道悲惨绝望的光芒，对附近40码范围的敌人每2秒造成中额暗影伤害。',
                                },
                                {
                                    spell = '71341',
                                    title = '黑暗堕落者的灵气',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '每当有一名玩家吸血鬼存在都会将他的气息注入了鲜血女王兰娜瑟尔，使其哀伤之雾的强度提高5%。可叠加。',
                                },
                            },
                            title = '全局技能',
                            noCollapse = false,
                            expanded = true,
                        },
                        {
                            children = {
                                {
                                    spell = '70838',
                                    title = '鲜血镜像',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，鲜血女王兰娜瑟尔会将当前目标和其离的最近的一名玩家连接起来。将鲜血女王兰娜瑟尔当前目标受到的100%的伤害反射给相连的一方。',
                                },
                                {
                                    spell = '71623',
                                    title = '疯狂斩杀',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，对与鲜血女王兰娜瑟尔当前目标连接起来的玩家造成75%的武器伤害并使其不断流血，每3秒造成中额流血伤害，持续15 秒。',
                                },
                                {
                                    spell = '71818',
                                    title = '暮光血箭',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，每30秒随机对1名玩家施放，造成每秒小额暗影伤害，持续6秒。持续期间该玩家每0.5秒将在脚下生成一团蜂拥之影，并将持续燃烧1分钟，触碰到蜂拥之影的玩家每1秒将受到小额暗影伤害。',
                                },
                                {
                                    spell = '71340',
                                    title = '黑暗堕落者的契约',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，将随机3名玩家以黑暗堕落者的契约连接，持续28秒。当连接存在时，每0.5秒都会对其和附近未相连的盟友造成暗影伤害。当所有相连的目标都相互位于各自5码范围内时，连接将消失。',
                                },
                                {
                                    spell = '71726',
                                    title = '吸血撕咬',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '瞬发技，进入战斗后鲜血女王兰娜瑟尔发动吸血撕咬，对最高仇恨玩家（坦克除外）造成高额物理伤害，并使其获得鲜血女王的精华效果(70867)，持续1分钟。时间结束后，被鲜血女王的精华影响的玩家将进入持续10秒的疯狂嗜血状态。在此期间，必须撕咬一名友方玩家，从而延缓你对鲜血的需求。否则将会被鲜血女王控制，从而进入失心疯状态。吸血撕咬无法对已经成为吸血鬼的对象使用。',
                                },
                                {
                                    spell = '70867',
                                    title = '鲜血女王的精华',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '被吸血撕咬后玩家获得增益，使你造成的伤害提高100%，所造成伤害的10%转而治疗施法者。攻击不会产生威胁值。持续1分钟。',
                                },
                                {
                                    spell = '70877',
                                    title = '疯狂嗜血',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '当鲜血女王的精华结束，进入疯狂嗜血阶段，你必须在10秒内去施法者必须满足其对鲜血的渴望，否则即会失去为兰娜瑟尔作战的斗志。你必须饮血！你的斗志正在减弱……持续10秒。',
                                },
                                {
                                    spell = '70923',
                                    title = '失心疯',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '如果没有在疯狂嗜血持续时间内咬人，那么玩家将被魅惑，所造成的伤害提高100%，生命值提高900%，所造成的治疗效果提高1000%。',
                                },
                            },
                            title = '鲜血女王兰娜瑟尔',
                            noCollapse = false,
                            expanded = true,
                        },
                    },
                    noCollapse = false,
                    title = '第一阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '73070',
                            title = '煽动惊恐',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，在空中阶段开始时，鲜血女王会发动煽动惊恐，使所有玩家因恐惧而逃跑，持续4秒。可驱散。',
                        },
                        {
                            spell = '71772',
                            title = '血箭飞舞',
                            noCollapse = false,
                            expanded = false,
                            desc = '引导技，鲜血女王兰娜瑟尔在空中召唤一场血箭风暴，持续6秒。每2秒朝多名随机玩家射出血箭，对目标及其6码范围内的盟友造成高额暗影奥术伤害。',
                        },
                        {
                            spell = '26662',
                            title = '狂暴',
                            noCollapse = false,
                            expanded = false,
                            desc = '进入战斗5分20秒后，鲜血女王兰娜瑟尔会变的狂暴，其中攻击和移动速度提高150%，对玩家造成的所有伤害提高500%，持续5分钟。在效果持续期间免疫嘲讽。',
                        },
                    },
                    noCollapse = false,
                    title = '第二阶段',
                    expanded = true,
                },
            },
        },
        name = '鲜血女王兰娜瑟尔',
        icon = '1378967',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1.中'..(BuildSpellLink(71340) or "[黑暗堕落者的契约]")..'应立即寻找连线玩家重合消除。\n2.被'..(BuildSpellLink(71277) or "[蜂拥之影]")..'点名立即靠边缓慢移动放火。\n3.'..(BuildSpellLink(71726) or "[吸血撕咬]")..'应根据团长安排合理咬队友，最好是在最后3-5秒的时候咬。\n4.近战尽量分组站位规避P1'..(BuildSpellLink(71818) or "[暮光血箭]")..'和P2'..(BuildSpellLink(71772) or "[血箭飞舞]")..'带来的范围伤害。\n5.远程则随时保持分散规避P1'..(BuildSpellLink(71818) or "[暮光血箭]")..'和P2'..(BuildSpellLink(71772) or "[血箭飞舞]")..'带来的范围伤害。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.重点关注坦克，尤其是副坦中了'..(BuildSpellLink(71623) or "[疯狂斩杀]")..'，应保持治疗。\n2.保持分散规避P1'..(BuildSpellLink(71818) or "[暮光血箭]")..'和P2'..(BuildSpellLink(71772) or "[血箭飞舞]")..'带来的范围伤害。\n3.'..(BuildSpellLink(71726) or "[吸血撕咬]")..'应根据团长安排合理咬队友，最好是在最后3-5秒的时候咬。\n4.被'..(BuildSpellLink(71277) or "[蜂拥之影]")..'点名立即靠边缓慢移动放火。\n5.中'..(BuildSpellLink(71340) or "[黑暗堕落者的契约]")..'应立即寻找连线玩家重合消除。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.副坦应安排血量高的T来吃'..(BuildSpellLink(71623) or "[疯狂斩杀]")..'，注意开好减伤。\n2.主坦和副坦重合站位。',
                },
            },
            desc = ' 一、BOSS简介\n 兰娜瑟尔生前带领血精灵与伊利丹一同进入诺森德讨伐巫妖王，然而一心想向天灾军团复仇的她不幸在战斗中丧生。死去的兰娜瑟尔还有其余血精灵精英被巫妖王复活为萨莱茵一族，协助巫妖王指挥天灾军团四处作战。他们出身高贵，以鲜血为生命，被他们咬中后会传染为后裔，他们是真正以吸血鬼为原型创造出来的。鲜血女王兰娜瑟尔作为萨莱茵一族的领袖，镇守着冰冠堡垒的赤红大厅。\n二、综述\n 2.1：团队配置推荐（2坦克5治疗18输出）\n2.2：鲜血女王兰娜瑟尔是位于冰冠堡垒赤红大厅的首领之一。Boss战分为P1和P2，地面阶段和空中阶段。\n2.3：战斗核心策略：团长合理安排'..(BuildSpellLink(71726) or "[吸血撕咬]")..'让队友和自己获得'..(BuildSpellLink(70867) or "[鲜血女王的精华]")..'来大幅度提高输出。同时保持分散规避P1'..(BuildSpellLink(71818) or "[暮光血箭]")..'和P2'..(BuildSpellLink(71772) or "[血箭飞舞]")..'带来的范围伤害。中'..(BuildSpellLink(71340) or "[黑暗堕落者的契约]")..'的3名玩家应及时集中消除连线。被'..(BuildSpellLink(71277) or "[蜂拥之影]")..'点名的玩家应立即靠边缓慢移动放火。Boss在5分20秒会进入狂暴。',
        },
    },
    [1634] = {
        bossId = 1634,
        abilities = {
            children = {
                {
                    children = {
                        {
                            spell = '72483',
                            title = '召唤梦魇之门',
                            noCollapse = false,
                            expanded = false,
                            desc = '每45秒瓦莉瑟瑞娅在场地上召唤8个红色的梦魇之门，15秒后梦魇之门形成并可点击，持续10秒。每个梦魇之门只可进入1人，玩家点击后来将其进入进梦魇位面。梦魇位面持续20秒，玩家获得漂浮的能力。梦魇位面的空中漂浮遇到有12多红色球形的梦魇之云，玩家触碰到梦魇之云，即会引爆梦魇之云，使周围10码范围内的玩家获得'..(BuildSpellLink(71940) or "[扭曲梦魇]")..'效果。',
                        },
                        {
                            spell = '71940',
                            title = '扭曲梦魇',
                            noCollapse = false,
                            expanded = false,
                            desc = '玩家触碰到梦魇之云获得效果。每层对玩家造成每秒小额自然伤害。此外，该目标还会每3秒回复少量法力值。目标的伤害和治疗效果同样会被提高10%。最多叠加100层。持续40秒。',
                        },
                    },
                    noCollapse = false,
                    title = '踏梦者瓦莉瑟瑞娅',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '70633',
                            title = '胆汁喷溅',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，对当前正面施放胆汁喷溅，使目标感染疾病，对其每秒造成小额自然伤害，并使其受到的物理伤害提高25%，持续12秒。可驱散。',
                        },
                        {
                            spell = '72963',
                            title = '血肉腐烂',
                            noCollapse = false,
                            expanded = false,
                            desc = '憎恶死亡后，尸体内腐烂生成多只腐蛆参与战斗，近战攻击会造成血肉腐烂效果，每秒造成小额自然伤害，持续8秒。可叠加。',
                        },
                    },
                    noCollapse = false,
                    title = '贪食的憎恶',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '70588',
                            title = '镇压',
                            noCollapse = false,
                            expanded = false,
                            desc = '引导技，对踏梦者瓦莉瑟瑞娅引导镇压效果，使其受到的治疗效果降低10%。',
                        },
                    },
                    noCollapse = false,
                    title = '镇压者',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '70751',
                            title = '腐蚀',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，近战攻击会使目标每3秒造成小额自然伤害，并使目标的护甲值降低10%。可叠加5层。持续6秒。',
                        },
                        {
                            spell = '70744',
                            title = '酸性爆炸',
                            noCollapse = false,
                            expanded = false,
                            desc = '0.75秒施法，死亡时发生爆炸，立即对15码范围内所有敌人造成高额自然伤害，并在20秒内造成小额自然伤害。',
                        },
                    },
                    noCollapse = false,
                    title = '脓疮僵尸',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '70759',
                            title = '寒冰箭雨',
                            noCollapse = false,
                            expanded = false,
                            desc = '2秒施法，对60码范围内所有敌人造成中额冰霜伤害，并使其移动速度降低50%，燃烧其少量法力值。持续8秒。可打断。可驱散。',
                        },
                        {
                            spell = '71086',
                            title = '法力黑洞',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，在随机1名玩家所在位置召唤一个法力黑洞。使半径6码范围内敌人每秒燃烧少量法力值，持续30秒。',
                        },
                    },
                    noCollapse = false,
                    title = '复生的大法师',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '70754',
                            title = '火球术',
                            noCollapse = false,
                            expanded = false,
                            desc = '0.5秒施法，对一个敌人造成中额火焰伤害。',
                        },
                        {
                            spell = '69326',
                            title = '损毁',
                            noCollapse = false,
                            expanded = false,
                            desc = '引导技，烈焰围绕施法者全身，持续12秒。每2秒对所有敌人造成中额火焰伤害。',
                        },
                    },
                    noCollapse = false,
                    title = '灼热骷髅',
                    expanded = true,
                },
            },
        },
        name = '踏梦者瓦莉瑟瑞娅',
        icon = '1379023',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1.按照小怪优先级进行处理。[灼热骷髅])>[镇压者]>[复生的大法师]>[脓疮僵尸]>[贪食的憎恶]。\n2.'..'[复生的大法师]的读条注意打断。\n3.'..(BuildSpellLink(70702) or "[寒冰气旋]")..'和'..(BuildSpellLink(71086) or "[法力黑洞]")..'地面技能注意及时躲避。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.在外场的治疗注意刷好坦克和中减益的队友。\n2.在外场的治疗注意躲避'..(BuildSpellLink(70702) or "[寒冰气旋]")..'和'..(BuildSpellLink(71086) or "[法力黑洞]")..'地面技能。\n3.内场治疗提前就位注意'..(BuildSpellLink(72483) or "[梦魇之门]")..'的位置。\n4.内场治疗应尽量统一移动吃好梦魇之云，续好'..(BuildSpellLink(71940) or "[扭曲梦魇]")..'的层数保证不断层。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.坦克优先拉贪食的憎恶，及时聚怪方便Dps进行输出。\n2.脓疮僵尸爆炸时注意远离人群。',
                },
            },
            desc = ' 一、BOSS简介\n踏梦者瓦莉瑟瑞娅是一位被天灾军团捕获的绿龙，她被困在冰冠堡垒霜翼大厅无法动弹。为了拯救梦行者，玩家需要在天灾士兵的阻挠下将她从半身不遂治疗到满血。 \n二、综述\n 2.1：团队配置推荐（2坦克5治疗18输出）\n2.2：Boss战分为外场和内场，将50%生命值的踏梦者瓦莉瑟瑞娅治疗至生命值全满，即可获得胜利。\n2.3：战斗核心策略：内场治疗通过'..(BuildSpellLink(72483) or "[梦魇之门]")..'进入到梦魇位面，会看到漂浮的梦魇之云，触碰之后会获得一层'..(BuildSpellLink(71940) or "[扭曲梦魇]")..'效果，并在高层数时利用其持续时间开爆发治愈Boss，满血即胜利。外场的击杀顺序为[灼热骷髅])>[镇压者]>[复生的大法师]>[脓疮僵尸]>[贪食的憎恶]。',
        },
    },
    [1635] = {
        bossId = 1635,
        abilities = {
            children = {
                {
                    children = {
                        {
                            spell = '19983',
                            title = '顺劈斩',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，下一次近战攻击对当前目标和它身边最多10名敌人造成武器伤害再加少额伤害。',
                        },
                        {
                            spell = '71077',
                            title = '尾击',
                            noCollapse = false,
                            expanded = false,
                            desc = '1秒施法，对尾部范围20码的敌人造成高额物理伤害，并将其击退。',
                        },
                        {
                            spell = '69649',
                            title = '冰霜吐息',
                            noCollapse = false,
                            expanded = false,
                            desc = '1.5秒施法，辛达苟萨朝面前半径60码的锥形范围内所有玩家造成高额冰霜伤害。使目标的攻击速度降低50%，移动速度降低15%，持续1.5分钟。可叠加6次。',
                        },
                        {
                            spell = '70106',
                            title = '寒霜刺骨',
                            noCollapse = false,
                            expanded = false,
                            desc = '使对辛达苟萨进行物理攻击的敌人有20%的几率受到寒霜刺骨效果的影响，每叠加一层该魔法效果就会使目标每2秒受到小额冰霜伤害。持续8秒。',
                        },
                        {
                            spell = '69762',
                            title = '狂咒',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技。对6名玩家施法奥术邪咒，使其在接下来的30秒内每施法1次法术都会叠加1层动荡效果。',
                        },
                        {
                            spell = '69766',
                            title = '动荡',
                            noCollapse = false,
                            expanded = false,
                            desc = '在受到狂咒效果影响下使用法术会积聚不稳定的动荡效果。动荡效果持续5秒，每次施放法术会叠加1层动荡，每次叠加会刷新持续时间。当持续时间结束时， 动荡效果会根据累加的层数瞬间结算，每1层动荡效果会对施法者自身以及20码范围内的盟友造成中额奥术伤害。',
                        },
                        {
                            spell = '70123',
                            title = '严寒',
                            noCollapse = false,
                            expanded = false,
                            desc = '5秒施法，辛达苟萨会把视野范围内所有敌人拉到面前，并再施法结束后对半径25码范围内敌人造成高额冰霜伤害。',
                        },
                    },
                    noCollapse = false,
                    title = '第一阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '70126',
                            title = '冰霜道标',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，P2阶段辛达苟萨在空中用魔法球标记6名玩家，持续7秒，时间结束时，将点名玩家囚禁在寒冰坟墓中。',
                        },
                        {
                            spell = '70157',
                            title = '寒冰坟墓',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，朝带有冰霜道标的玩家投掷冰霜炸弹，对其及周围10码范围内的所有玩家造成高额冰霜伤害，并将其冻入寒冰坟墓。被冻结的玩家将陷入深度昏迷，不会受到其他伤害。但也无法被外界玩家选中。其他玩家可以打破寒冰坟墓来救出被冻结的玩家。',
                        },
                        {
                            spell = '71665',
                            title = '窒息',
                            noCollapse = false,
                            expanded = false,
                            desc = '被寒冰坟墓冻结25秒后，还被冻结在寒冰坟墓中的玩家会因缺氧而窒息，每秒损失总生命值的8%。',
                        },
                        {
                            spell = '69845',
                            title = '冰霜炸弹',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，'..(BuildSpellLink(70157) or "[寒冰坟墓]")..'施放完后，辛达苟萨会依次朝场地上的随机位置投掷4次冰霜炸弹。每次冰霜炸弹落地后的爆炸对视野内所有玩家造成高额冰霜伤害。玩家可以通过'..(BuildSpellLink(70157) or "[寒冰坟墓]")..'来躲避冰霜炸弹的视野来规避伤害。',
                        },
                    },
                    noCollapse = false,
                    title = '第二阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '19983',
                            title = '顺劈斩',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，下一次近战攻击对当前目标和它身边最多10名敌人造成武器伤害再加少额伤害。',
                        },
                        {
                            spell = '71077',
                            title = '尾击',
                            noCollapse = false,
                            expanded = false,
                            desc = '1秒施法，对尾部范围20码的敌人造成高额物理伤害，并将其击退。',
                        },
                        {
                            spell = '70127',
                            title = '秘法打击',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，辛达苟萨每6秒施放一次奥术能量波，使所有视野内的玩家被秘法打击影响，持续8秒。可叠加。每1层秘法打击会使目标受到的魔法伤害提高20%。',
                        },
                        {
                            spell = '69649',
                            title = '冰霜吐息',
                            noCollapse = false,
                            expanded = false,
                            desc = '1.5秒施法，辛达苟萨朝面前半径60码的锥形范围内所有玩家造成高额冰霜伤害。使目标的攻击速度降低50%，移动速度降低15%，持续1.5分钟。可叠加6次。',
                        },
                        {
                            spell = '70106',
                            title = '寒霜刺骨',
                            noCollapse = false,
                            expanded = false,
                            desc = '使对辛达苟萨进行物理攻击的敌人有20%的几率受到寒霜刺骨效果的影响，每叠加一层该魔法效果就会使目标每2秒受到小额冰霜伤害。持续8秒。',
                        },
                        {
                            spell = '69762',
                            title = '狂咒',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技。对6名玩家施法奥术邪咒，使其在接下来的30秒内每施法1次法术都会叠加1层动荡效果。',
                        },
                        {
                            spell = '69766',
                            title = '动荡',
                            noCollapse = false,
                            expanded = false,
                            desc = '在受到狂咒效果影响下使用法术会积聚不稳定的动荡效果。动荡效果持续5秒，每次施放法术会叠加1层动荡，每次叠加会刷新持续时间。当持续时间结束时， 动荡效果会根据累加的层数瞬间结算，每1层动荡效果会对施法者自身以及20码范围内的盟友造成中额奥术伤害。',
                        },
                        {
                            spell = '70123',
                            title = '严寒',
                            noCollapse = false,
                            expanded = false,
                            desc = '5秒施法，辛达苟萨会把视野范围内所有敌人拉到面前，并再施法结束后对半径25码范围内敌人造成高额冰霜伤害。',
                        },
                        {
                            spell = '70126',
                            title = '冰霜道标',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，P2阶段辛达苟萨在空中用魔法球标记6名玩家，持续7秒，时间结束时，将点名玩家囚禁在寒冰坟墓中。',
                        },
                        {
                            spell = '70157',
                            title = '寒冰坟墓',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，朝带有冰霜道标的玩家投掷冰霜炸弹，对其及周围10码范围内的所有玩家造成高额冰霜伤害，并将其冻入寒冰坟墓。被冻结的玩家将陷入深度昏迷，不会受到其他伤害。但也无法被外界玩家选中。其他玩家可以打破寒冰坟墓来救出被冻结的玩家。',
                        },
                        {
                            spell = '71665',
                            title = '窒息',
                            noCollapse = false,
                            expanded = false,
                            desc = '被寒冰坟墓冻结25秒后，还被冻结在寒冰坟墓中的玩家会因缺氧而窒息，每秒损失总生命值的8%。',
                        },
                    },
                    noCollapse = false,
                    title = '第三阶段',
                    expanded = true,
                },
            },
        },
        name = '辛达苟萨',
        icon = '1379014',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1.近战Dps在侧面输出避免吃到'..(BuildSpellLink(19983) or "[顺劈斩]")..'和'..(BuildSpellLink(69649) or "[寒冰吐息]")..'。\n2.近战Dps时刻注意'..(BuildSpellLink(70106) or "[寒霜刺骨]")..'的层数。6-8层可停手消层。\n3.远程Dps注意中了狂咒(69762)远离人群并分散20码。注意层数不要叠太高。狂咒结束回人群。\n4.P2阶段注意自己是否被点名'..(BuildSpellLink(70126) or "[冰霜道标]")..'，及时站位。\n5.P2阶段注意'..(BuildSpellLink(70157) or "[寒冰坟墓]")..'击杀速度，确保在第四次'..(BuildSpellLink(69845) or "[冰霜炸弹]")..'结束后打破。\n6.P3阶段时刻注意'..(BuildSpellLink(70127) or "[秘法打击]")..'层数，3层左右可以躲避到'..(BuildSpellLink(70157) or "[寒冰坟墓]")..'后面消除。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.注意中了狂咒(69762)远离人群并分散20码。注意层数不要叠太高。狂咒结束回人群。\n2.P2注意被点名'..(BuildSpellLink(70126) or "[冰霜道标]")..'的玩家，应及时刷满血。\n3.P3阶段时刻注意'..(BuildSpellLink(70127) or "[秘法打击]")..'层数，治疗应协商消层时间以免坦克断疗。\n4.P3刷坦克的治疗应在'..(BuildSpellLink(69649) or "[寒冰吐息]")..'时给予坦克更多的治疗和减伤。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.坦克确保Boss位置不动，注意'..(BuildSpellLink(70106) or "[寒霜刺骨]")..'的层数过高需要停手消层。\n2.P2阶段快速躲避在'..(BuildSpellLink(70157) or "[寒冰坟墓]")..'后面等待接住Boss。\n3.每次'..(BuildSpellLink(69649) or "[寒冰吐息]")..'应保持自己的减伤，尤其是P3阶段。\nP3阶段注意'..(BuildSpellLink(70127) or "[秘法打击]")..'层数进行换坦，非当前坦应躲避在'..(BuildSpellLink(70157) or "[寒冰坟墓]")..'后面消层。',
                },
            },
            desc = ' 一、BOSS简介\n 冰霜巨龙辛达苟萨，是一只被巫妖王在冰冠冰川复活的强大冰霜巨龙。生前是玛里苟斯的配偶。永恒之井一战大地守护者耐萨里奥意图占据巨龙之魂公然反叛其他龙族，玛里苟斯和辛达苟萨带领的蓝龙军团攻击耐萨里奥都以失败告终。辛达苟萨被击飞至诺森德的冰冠冰川，身负重伤的她无法飞往龙骨荒野安息，只能绝望地在冰冠冰川殒命。当巫妖王与死亡骑士阿尔萨斯·米奈希尔融合一体觉醒后，辛达苟萨被复活为冰霜巨龙为巫妖王效命，镇守于冰冠堡垒的霜翼大厅。\n二、综述\n 2.1：团队配置推荐（2坦克7治疗16输出）\n2.2：Boss战分为3个阶段，P1地面阶段，P2空中阶段，P3（35%血量以下）\n2.3：战斗核心策略：P1阶段近战Dps应注意'..(BuildSpellLink(70106) or "[寒霜刺骨]")..'的层数不能叠太高，远程和治疗注意被狂咒(69762)点名玩家及时远离人群并注意层数不能叠太高。P2阶段被'..(BuildSpellLink(70126) or "[冰霜道标]")..'点名的玩家应按照团长要求站位，其余人应躲避在'..(BuildSpellLink(70157) or "[寒冰坟墓]")..'后面，Dps应在第4次'..(BuildSpellLink(69845) or "[冰霜炸弹]")..'结束后打破'..(BuildSpellLink(70157) or "[寒冰坟墓]")..'。Boss施放'..(BuildSpellLink(70123) or "[严寒]")..'被拉时，应及时远离Boss归位。P3阶段所有人应注意'..(BuildSpellLink(70127) or "[秘法打击]")..'层数注意躲在'..(BuildSpellLink(70157) or "[寒冰坟墓]")..'后面可消层。',
        },
    },
    [1636] = {
        bossId = 1636,
        abilities = {
            children = {
                {
                    children = {
                        {
                            spell = '70541',
                            title = '寄生',
                            noCollapse = false,
                            expanded = false,
                            desc = '2秒施法，巫妖王会对所有玩家造成高额暗影伤害。此外，目标还会受到每秒提升的暗影伤害。该效果会在目标的生命值超过90%后消失。',
                        },
                        {
                            spell = '70337',
                            title = '死疽',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，随机点名一个目标使其承受致命效果，每5秒对其造成高额暗影伤害，持续15秒。如果目标在承受此效果时死亡，或者此效果结束，该效果会额外叠加一层并转移到附近的一名单位身上。如果效果被驱散，则该效果会减少一层并转移到附近的一名单位身上。每当这一效果转移的时候，巫妖王的力量都会提升获得热病虹吸的效果。',
                        },
                        {
                            spell = '74074',
                            title = '热病虹吸',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，巫妖王从死疽的传染中获得力量，造成的物理伤害提高2%，持续30秒，每次'..(BuildSpellLink(70337) or "[死疽]")..'传染会叠加1层。',
                        },
                        {
                            spell = '73539',
                            title = '召唤暗影陷阱(英雄难度)',
                            noCollapse = false,
                            expanded = false,
                            desc = '巫妖王在60码范围内随机对1名玩家脚下扔一个暗影陷阱，陷阱落地后5秒触发生成1个半径5码的暗影陷阱。任意玩家触碰暗影陷阱都会导致其发生爆炸。对周围10码范围内的所有敌人造成高额暗影伤害，并将他们远远击退。',
                        },
                        {
                            spell = '37695',
                            title = '食尸鬼苦工',
                            noCollapse = false,
                            expanded = false,
                            desc = '对目标使用普通攻击，攻击可被对方护甲减免。',
                        },
                        {
                            children = {
                                {
                                    spell = '72143',
                                    title = '激怒',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '1秒施法，造成的伤害提供200%，持续5秒。可驱散。',
                                },
                                {
                                    spell = '72149',
                                    title = '震荡波',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '1.25秒施法，朝前方施放强大的能量波，对面前半径20码范围内的正面锥形区域造成150%的武器物理伤害。',
                                },
                                {
                                    spell = '28747',
                                    title = '狂乱',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '当蹒跚的血僵尸血量少于20%时，获得狂乱效果，使其攻击速度提高50%，对玩家造成的物理伤害提高100%，持续10分钟。',
                                },
                            },
                            noCollapse = false,
                            title = '蹒跚的血僵尸',
                            expanded = true,
                        },
                    },
                    noCollapse = false,
                    title = '第一阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '68983',
                            title = '冷酷严冬',
                            noCollapse = false,
                            expanded = false,
                            desc = '当生命值70%时，巫妖王会跑到场地的中心，制造一场猛烈的寒冬风暴，对半径45码之内的所有敌人每秒造成中额冰霜伤害。持续1分钟。',
                        },
                        {
                            spell = '72133',
                            title = '饱受折磨',
                            noCollapse = false,
                            expanded = false,
                            desc = '0.5秒施法，随机选中1名玩家，对巫妖王面向目标方向的锥形区域内所有玩家造成中额暗影伤害。而且目标还会每秒承受小额暗影伤害，持续3秒。',
                        },
                        {
                            spell = '36633',
                            title = '召唤寒冰之球',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技。巫妖王在其身边召唤1颗寒冰之球。寒冰之球出现后，会随机连线一名玩家并朝其缓慢移动。当寒冰之球触碰到连线玩家时，对其释放寒冰脉冲，对目标附近半径5码内的所有敌人造成中额冰霜伤害。',
                        },
                        {
                            spell = '36701',
                            title = '暴怒的灵魂',
                            noCollapse = false,
                            expanded = false,
                            desc = '转阶段会召唤暴怒的灵魂出来战斗，对施法者面前15码内锥形区域所有敌人造成高额暗影伤害并使其沉默5秒。',
                        },
                        {
                            spell = '72262',
                            title = '地震',
                            noCollapse = false,
                            expanded = false,
                            desc = '1.5秒施法。当冷酷严冬结束后，巫妖王开始施展强大的力量5秒后使平台边缘破碎，边缘破碎后玩家还在上面的话会掉落虚空阵亡。',
                        },
                    },
                    noCollapse = false,
                    title = '第二阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '70541',
                            title = '寄生',
                            noCollapse = false,
                            expanded = false,
                            desc = '2秒施法，巫妖王会对所有玩家造成高额暗影伤害。此外，目标还会受到每秒提升的暗影伤害。该效果会在目标的生命值超过90%后消失。',
                        },
                        {
                            spell = '72754',
                            title = '污染',
                            noCollapse = false,
                            expanded = false,
                            desc = '3秒施法，随机点名一名玩家，污染目标脚下的区域，生成一个暗影能量的污点。任何在此区域内的玩家会每秒造成高额暗影伤害。一旦有玩家受到污染的伤害，污染区域的面积会每秒翻倍，每次尺寸增加都会增加小额暗影伤害。污点存在30秒。',
                        },
                        {
                            spell = '69409',
                            title = '灵魂收割',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，每30秒挥舞霜之哀伤攻击目标，造成50%的武器伤害，并使其受到灵魂收割的效果影响。该效果会在5 秒后对目标造成高额暗影伤害，并使巫妖王的近战急速等级提高100%，持续5 秒。',
                        },
                        {
                            spell = '36609',
                            title = '召唤瓦格里',
                            noCollapse = false,
                            expanded = false,
                            desc = '巫妖王在上空召唤3只瓦格里暗影戒卫者。每轮新召唤的瓦格里都会冲向并分别抓起随机1名玩家。之后，瓦格里会寻找距离平台边缘最短的路径缓慢飞行。当飞出平台边缘后，他们会把其扔下平台导致其掉落虚空。如果玩家将其生命值打到50%，瓦格里就会扔下被抓的玩家并返回空中施放生命虹吸。',
                        },
                        {
                            spell = '73488',
                            title = '生命虹吸',
                            noCollapse = false,
                            expanded = false,
                            desc = '2 秒施法，对一个敌人造成中额暗影伤害，并让施法者获得十倍于伤害量的生命值。',
                        },
                    },
                    noCollapse = false,
                    title = '第三阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '68983',
                            title = '冷酷严冬',
                            noCollapse = false,
                            expanded = false,
                            desc = '当生命值70%时，巫妖王会跑到场地的中心，制造一场猛烈的寒冬风暴，对半径45码之内的所有敌人每秒造成中额冰霜伤害。持续1分钟。',
                        },
                        {
                            spell = '72133',
                            title = '饱受折磨',
                            noCollapse = false,
                            expanded = false,
                            desc = '0.5秒施法，随机选中1名玩家，对巫妖王面向目标方向的锥形区域内所有玩家造成中额暗影伤害。而且目标还会每秒承受小额暗影伤害，持续3秒。',
                        },
                        {
                            spell = '36633',
                            title = '召唤寒冰之球',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技。巫妖王在其身边召唤1颗寒冰之球。寒冰之球出现后，会随机连线一名玩家并朝其缓慢移动。当寒冰之球触碰到连线玩家时，对其释放寒冰脉冲，对目标附近半径5码内的所有敌人造成中额冰霜伤害。',
                        },
                        {
                            spell = '36701',
                            title = '暴怒的灵魂',
                            noCollapse = false,
                            expanded = false,
                            desc = '转阶段会召唤暴怒的灵魂出来战斗，对施法者面前15码内锥形区域所有敌人造成高额暗影伤害并使其沉默5秒。',
                        },
                        {
                            spell = '72262',
                            title = '地震',
                            noCollapse = false,
                            expanded = false,
                            desc = '1.5秒施法。当冷酷严冬结束后，巫妖王开始施展强大的力量5秒后使平台边缘破碎，边缘破碎后玩家还在上面的话会掉落虚空阵亡。',
                        },
                    },
                    noCollapse = false,
                    title = '第四阶段',
                    expanded = true,
                },
                {
                    children = {
                        {
                            spell = '69409',
                            title = '灵魂收割',
                            noCollapse = false,
                            expanded = false,
                            desc = '瞬发技，每30秒挥舞霜之哀伤攻击目标，造成50%的武器伤害，并使其受到灵魂收割的效果影响。该效果会在5 秒后对目标造成高额暗影伤害，并使巫妖王的近战急速等级提高100%，持续5 秒。',
                        },
                        {
                            spell = '72754',
                            title = '污染',
                            noCollapse = false,
                            expanded = false,
                            desc = '3秒施法，随机点名一名玩家，污染目标脚下的区域，生成一个暗影能量的污点。任何在此区域内的玩家会每秒造成高额暗影伤害。一旦有玩家受到污染的伤害，污染区域的面积会每秒翻倍，每次尺寸增加都会增加小额暗影伤害。污点存在30秒。',
                        },
                        {
                            spell = '73654',
                            title = '收割灵魂',
                            noCollapse = false,
                            expanded = false,
                            desc = '引导技能，俗称"进剑"，巫妖王会高举霜之哀伤尝试收割附近所有玩家的灵魂，玩家进入昏迷状态并缓慢拉入霜之哀伤位面（俗称剑内），这个过程每秒钟对玩家造成中额暗影伤害，持续6秒。如果目标在法术效果结束以后还活着，他的灵魂就会被吸入霜之哀伤，被这把魔剑吞噬。',
                        },
                        {
                            children = {
                                {
                                    spell = '73655',
                                    title = '收割灵魂',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '你的灵魂被霜之哀伤吞噬了。每秒造成中额暗影伤害。光环技能。',
                                },
                                {
                                    title = '爆炸',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '当卑劣的灵魂碰到目标，将牺牲自己，对10码范围内的所有敌人造成高额暗影伤害。',
                                },
                                {
                                    spell = '73654',
                                    title = '被收割的灵魂',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '每当有1名玩家在霜之哀伤内部阵亡时，巫妖王都会吸收其灵魂力量。使得巫妖王的体型增大50%，造成的伤害提高500%，持续15秒。可叠加。',
                                },
                                {
                                    spell = '70503',
                                    title = '灵魂爆裂',
                                    noCollapse = false,
                                    expanded = false,
                                    desc = '0.5秒读条。每30秒巫妖王在外场上空陆续创造10个卑劣的灵魂，卑劣的灵魂触碰玩家会牺牲自己，让5码范围内的所有玩家承受高额暗影伤害。',
                                },
                            },
                            noCollapse = false,
                            title = '霜之哀伤位面(剑内)',
                            expanded = true,
                        },
                    },
                    noCollapse = false,
                    title = '第五阶段',
                    expanded = true,
                },
            },
        },
        name = '巫妖王',
        icon = '607688',
        summary = {
            children = {
                {
                    role = 'DAMAGER',
                    expanded = false,
                    desc = '1.打Boss本体阶段应全力输出。缩短战斗时长。\n2.英雄难度下召唤'..(BuildSpellLink(73539) or "[暗影陷阱]")..'应时刻注意是否在自己脚下。\n3.转阶段应优先处理[暴怒的灵魂]和'..(BuildSpellLink(36633) or "[寒冰之球]")..'。\n时刻注意'..(BuildSpellLink(70337) or "[死疽]")..'点名传染给副坦。'..(BuildSpellLink(72754) or "[污染]")..'点名远离大团。\n4.[瓦格里]出现时应及时转火解救队友。',
                },
                {
                    role = 'HEALER',
                    expanded = false,
                    desc = '1.全程时刻关注主坦和副坦血量，尤其是'..(BuildSpellLink(69409) or "[灵魂收割]")..'时。\n2.英雄难度下召唤'..(BuildSpellLink(73539) or "[暗影陷阱]")..'应时刻注意是否在自己脚下。\n3.P1注意驱散'..(BuildSpellLink(70337) or "[死疽]")..'时机，确保死疽顺利传到副坦身上才进行驱散。\n4.全程保证全团健康血量，尤其在'..(BuildSpellLink(70541) or "[寄生]")..'之前。',
                },
                {
                    role = 'TANK',
                    expanded = false,
                    desc = '1.P1阶段时刻注意Boss和小怪背对人群。英雄难度下还将注意'..(BuildSpellLink(73539) or "[暗影陷阱]")..'位置进行带位。\n2.P1阶段小怪坦应保持与人群合理距离保证'..(BuildSpellLink(70337) or "[死疽]")..'可以顺利传染给你。\n3.英雄难度下召唤'..(BuildSpellLink(73539) or "[暗影陷阱]")..'应时刻注意是否在自己脚下。\n4.P2阶段应及时建立[暴怒的灵魂]仇恨，背对人群。\n5.P3阶段注意'..(BuildSpellLink(72754) or "[污染]")..'位置，带着Boss远离污染。\n6.P5阶段应关注[卑劣的灵魂]召唤位置，确保距离足够让队友进行处理。',
                },
            },
            desc = ' 一、BOSS简介\n 巫妖王是艾泽拉斯天灾军团的统领，带上统御头盔的统领，都称之为巫妖王。通过统御头盔从冰冠堡垒顶端的冰封王座上统治天灾军团，巫妖王曾是艾泽拉斯这个世界上在行走过的最强大的生物之一。在魔兽世界的现存故事当中，目前总共有三位巫妖王。而我们这次面对的是第二位巫妖王，堕落的洛丹伦王子阿尔萨斯·米奈希尔，阿尔萨斯击碎了束缚耐奥祖的坚冰，戴上了统御头盔成为了第二任巫妖王。\n二、综述\n 2.1：团队配置推荐（2坦克5治疗18输出）\n2.2：Boss战分为5个阶段，P1阶段（100%血量-70%血量），P2转阶段，P3（70%血量-40%血量），P4转阶段，P5阶段（40%-10%）\n2.3：战斗核心策略：P1阶段坦克应拉好小怪与人群保持合适的位置，P1中'..(BuildSpellLink(70337) or "[死疽]")..'点名玩家，应在5秒内跑往小怪坦最近处，传染给小怪坦之后及时驱散疾病，保证'..(BuildSpellLink(70337) or "[死疽]")..'传染给小怪。'..(BuildSpellLink(70541) or "[寄生]")..'技能应全程保持全团血量处于健康状态。在英雄难度下，P1还会有召唤'..(BuildSpellLink(73539) or "[暗影陷阱]")..'，应Boss坦，人群，小怪坦应保持移动节奏确保'..(BuildSpellLink(70337) or "[死疽]")..'的传染。转阶段依然按照团长要求保持分散，Dps应及时处理'..(BuildSpellLink(36633) or "[寒冰之球]")..'和[暴怒的灵魂]。P3阶段被点名'..(BuildSpellLink(72754) or "[污染]")..'玩家应立即远离大团放水，召唤[瓦格里]及时转火救下队友。P5阶段被'..(BuildSpellLink(73654) or "[收割灵魂]")..'拉进内场的玩家应迅速集合移动处理15只[卑劣的灵魂]，在外场同样会召唤10个[卑劣的灵魂]，等待靠近时，应指定玩家开启减伤或无敌进行触碰引爆。',
        },
    },
}
local ENCOUNTER_INSTANCES = {
    [533] = {
        zones = {
            {
                zone = 1,
                text = '蜘蛛区',
            },
            {
                zone = 2,
                text = '瘟疫区',
            },
            {
                zone = 3,
                text = '军事区',
            },
            {
                zone = 4,
                text = '构造区',
            },
            {
                text = '冰龙区',
                zone = 5,
            },
        },
        bosses = {
            ENCOUNTER_BOSSES[1107],
            ENCOUNTER_BOSSES[1110],
            ENCOUNTER_BOSSES[1116],
            ENCOUNTER_BOSSES[1117],
            ENCOUNTER_BOSSES[1112],
            ENCOUNTER_BOSSES[1115],
            ENCOUNTER_BOSSES[1113],
            ENCOUNTER_BOSSES[1109],
            ENCOUNTER_BOSSES[1121],
            ENCOUNTER_BOSSES[1118],
            ENCOUNTER_BOSSES[1111],
            ENCOUNTER_BOSSES[1108],
            ENCOUNTER_BOSSES[1120],
            ENCOUNTER_BOSSES[1119],
            ENCOUNTER_BOSSES[1114],
        },
        title = '纳克萨玛斯',
        instanceId = 533,
    },
    [616] = {
        zones = {
        },
        bosses = {
            ENCOUNTER_BOSSES[734],
        },
        title = '永恒之眼',
        instanceId = 616,
    },
    [615] = {
        zones = {
        },
        bosses = {
            ENCOUNTER_BOSSES[742],
        },
        title = '黑曜石圣殿',
        instanceId = 615,
    },
    [624] = {
        bosses = {
            ENCOUNTER_BOSSES[772],
        },
        zones = {
        },
        title = '阿尔卡冯的宝库',
        instanceId = 624,
    },
    [603] = {
        bosses = {
            ENCOUNTER_BOSSES[744],
            ENCOUNTER_BOSSES[745],
            ENCOUNTER_BOSSES[746],
            ENCOUNTER_BOSSES[747],
            ENCOUNTER_BOSSES[748],
            ENCOUNTER_BOSSES[749],
            ENCOUNTER_BOSSES[750],
            ENCOUNTER_BOSSES[751],
            ENCOUNTER_BOSSES[752],
            ENCOUNTER_BOSSES[753],
            ENCOUNTER_BOSSES[754],
            ENCOUNTER_BOSSES[755],
            ENCOUNTER_BOSSES[756],
            ENCOUNTER_BOSSES[757],
        },
        zones = {
        },
        title = '奥杜尔',
        instanceId = 603,
    },
    [631] = {
        bosses = {
            ENCOUNTER_BOSSES[1624],
            ENCOUNTER_BOSSES[1625],
            ENCOUNTER_BOSSES[725],
            ENCOUNTER_BOSSES[1628],
            ENCOUNTER_BOSSES[1629],
            ENCOUNTER_BOSSES[1630],
            ENCOUNTER_BOSSES[1631],
            ENCOUNTER_BOSSES[1632],
            ENCOUNTER_BOSSES[1633],
            ENCOUNTER_BOSSES[1634],
            ENCOUNTER_BOSSES[1635],
            ENCOUNTER_BOSSES[1636],
        },
        zones = {
        },
        title = '冰冠堡垒',
        instanceId = 631,
    },
    [649] = {
        bosses = {
            ENCOUNTER_BOSSES[629],
            ENCOUNTER_BOSSES[633],
            ENCOUNTER_BOSSES[637],
            ENCOUNTER_BOSSES[641],
            ENCOUNTER_BOSSES[645],
        },
        zones = {
        },
        title = '十字军的试炼',
        instanceId = 649,
    },
}
local ENCOUNTER_DATA = {
    ENCOUNTER_INSTANCES[533],
    ENCOUNTER_INSTANCES[615],
    ENCOUNTER_INSTANCES[616],
    ENCOUNTER_INSTANCES[624],
    ENCOUNTER_INSTANCES[603],
    ENCOUNTER_INSTANCES[649],
    ENCOUNTER_INSTANCES[631],
}
ns.ULDUAR_BOSSES = 603
ns.ICECROWN_CITADEL_ID = 631
ns.THE_CRUSADES_TRIAL_ID = 649
ns.DEFAULT_ENCOUNTER_INSTANCE_ID = 624
ns.ENCOUNTER_BOSSES = ENCOUNTER_BOSSES
ns.ENCOUNTER_INSTANCES = ENCOUNTER_INSTANCES
ns.ENCOUNTER_DATA = ENCOUNTER_DATA

local QUEST_NAMES = {
    [1] = '关注|cff00ffff|Hqrcode:http://weixin.qq.com/q/02JtAwgez6cal10000M03f|h[暴雪游戏服务中心公众号]|h|r并绑定战网账号和手机号',
}

function ns.GetEncouterBossName(id)
    local data = ENCOUNTER_BOSSES[id]
    return data and data.name or UNKNOWN
end

function ns.GetEncounterRaidName(id)
    local data = ENCOUNTER_INSTANCES[id]
    return data and data.title or UNKNOWN
end

function ns.GetChallengeQuest(id)
    return QUEST_NAMES[id] or UNKNOWN
end
