local myname, ns = ...

ns.defaultsOverride = {
    show_on_minimap = true,
}

ns.groups = {
    spirithealer = "{npc:6491:Spirit Healer}",
}

if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE and LE_EXPANSION_LEVEL_CURRENT <= LE_EXPANSION_CATACLYSM then
    ns.OUTLAND = 1945
    ns.HELLFIRE = 1944
    ns.ZANGARMARSH = 1946
    ns.BLADESEDGE = 1949
    ns.NETHERSTORM = 1953
    ns.NAGRAND = 1951
    ns.TEROKKAR = 1952
    ns.SHADOWMOON = 1948

    ns.AZUREMYST = 1943
    ns.BLOODMYST = 1950
    ns.EVERSONG = 1941
    ns.GHOSTLANDS = 1942

    ns.QUELDANAS = 1957

    -- ns.KARAZHAN_SERVANTS = 350
else
    ns.OUTLAND = 101
    ns.HELLFIRE = 100
    ns.ZANGARMARSH = 102
    ns.BLADESEDGE = 105
    ns.NETHERSTORM = 109
    ns.NAGRAND = 107
    ns.TEROKKAR = 108
    ns.SHADOWMOON = 104

    ns.AZUREMYST = 97
    ns.BLOODMYST = 106
    ns.EVERSONG = 94
    ns.GHOSTLANDS = 95

    ns.QUELDANAS = 122

    -- ns.KARAZHAN_SERVANTS = 350
end

ns.BLOODY_RARE = 1312,

-- Outland
ns.RegisterPoints(ns.OUTLAND, {})

ns.RegisterPoints(ns.HELLFIRE, {
    -- Mekthorg the Wild
    [44804280] = {route={44804280, 46704920}},
    [45005980] = {route={45005980, 46505550}},
    [53405040] = {route={53405040, 49605100}},
    [70807140] = {route={70807140, 68306970, 65207010, 64907630, 69207700, loop=true}},
}, {
    achievement=ns.BLOODY_RARE, criteria=4517,
    npc=18677,
    loot={31170,31172,31174,31168},
})
ns.RegisterPoints(ns.HELLFIRE, {
    -- Fulgorge
    [27706920] = {route={27706920, 31006080, 34505910, 36005310, 38205140, 42305090, 45104900, r=1, g=0, b=0}},
    [31003700] = {route={31003700, 27004270, 24704820, 23605590, 23506180, r=1, g=0, b=0}},
    [58207170] = {route={58207170, 51207090, 41007310, 41106520, r=1, g=0, b=0}},
}, {
    achievement=ns.BLOODY_RARE, criteria=4512,
    npc=18678,
    loot={31176,31177,31179,31181},
    note="Watch for red rocks being thrown up; you can't target it before it leaves the ground",
})
ns.RegisterPoints(ns.HELLFIRE, {
    -- Vorakem Doomspeaker
    [38603100] = {route={38603100, 42203130, r=0, g=1, b=0}},
    [60603080] = {route={53802740, 60603080, 65603060, r=0, g=1, b=0}},
    [70204440] = {route={70204440, 74203570, r=0, g=1, b=0}},
    [73406000] = {route={71405490, 73406000, r=0, g=1, b=0}},
}, {
    achievement=ns.BLOODY_RARE, criteria=4523,
    npc=18679,
    loot={31182,31185},
})

ns.RegisterPoints(ns.ZANGARMARSH, {
    [18203140] = {route={10805520, 09805220, 11204640, 14804440, 15004040, 17603460, 18203140, r=1, g=0, b=0}},
    [54803380] = {route={54803380, 47803000, 43603480, 41403320, 38803380, 37803840, r=1, g=0, b=0}},
    [73603620] = {route={73603620, 70403740, 70203980, 72204320, 73604320, 73804660, 75204720, 77005140, 78805360, r=1, g=0, b=0}},
}, { -- Marticar
    achievement=ns.BLOODY_RARE, criteria=4516,
    npc=18680,
    loot={31254},
    -- tameable=643423,
})
ns.RegisterPoints(ns.ZANGARMARSH, {
    -- Coilfang Emissary
    [25403760] = {},
    [25403760] = {},
    [25804260] = {},
    [59803640] = {},
    [62006960] = {},
    [63003800] = {},
    [63404380] = {},
    [63806500] = {},
    [64406960] = {},
    [64804140] = {},
    [70407280] = {},
    [72207600] = {},
    [73608220] = {},
    [74807700] = {},
}, {
    achievement=ns.BLOODY_RARE, criteria=4507,
    npc=18681,
    loot={31244,31246,31243,31242},
    note="Many spawn points, around Naga huts",
})
ns.RegisterPoints(ns.ZANGARMARSH, {
    -- Bog Lurker
    [29002220] = {route={29002220, 27602320, 26402860, 23602900, 21602200, 25401940, loop=true, r=0, g=1, b=0}},
    [50006640] = {route={50006640, 51006080, 49005820, 45405800, 43006000, 42206060, r=0, g=1, b=0}},
    [82607720] = {route={82607720, 83007960, 85807940, 86808200, 85808480, 86608860, 85809200, r=0, g=1, b=0}},
}, {
    achievement=ns.BLOODY_RARE, criteria=4505,
    npc=18682,
    loot={31250,31249,31248,31247},
})

ns.RegisterPoints(ns.NAGRAND, {
    [39806940] = { -- Voidhunter Yar
        achievement=ns.BLOODY_RARE, criteria=4522,
        npc=18683,
        loot={31195,31197,31198,31199},
        route={39806940, 37806620, 34206620, 32206960, 32407380, 34407720, 37607660, 39607300, loop=true, r=0, g=0, b=1},
    },
})
ns.RegisterPoints(ns.NAGRAND, {
    -- Goretooth
    [33205100] = {route={33205100, 36404480, 40804290, 43204000, 45204260, 45204640, 43004780, r=0, g=1, b=0},note="Underwater"},
    [58202780] = {note="Underwater"},
    [77608120] = {route={77608120, 75007620, r=0, g=1, b=0}},
}, {
    achievement=ns.BLOODY_RARE, criteria=4513,
    npc=17144,
    loot={31188,31189,31191,31192},
    -- tameable=132187,
})
ns.RegisterPoints(ns.NAGRAND, {
    [25805260] = {route={25805260, 28803560, 32802920, 33201940, r=1, g=0.8, b=0}},
    [50205120] = {route={50205120, 52805200, 53605600, 51606060, 48006180, 44005580, r=1, g=0.8, b=0}},
    [70007000] = {route={70007000, 66807660, 58607300, 60807160, 60407840, 59608000, r=1, g=0.8, b=0}},
}, { -- Bro'Gaz the Clanless
    npc=18684,
    loot={31194},
})

ns.RegisterPoints(ns.TEROKKAR, {
    -- Okrek
    [30404340] = {},
    [49601840] = {},
    [57206540] = {},
    [57802300] = {},
}, {
    achievement=ns.BLOODY_RARE, criteria=4520,
    npc=18685,
    loot={31227,31228,31229,31231},
    note="Up in the trees",
})
ns.RegisterPoints(ns.TEROKKAR, {
    -- Doomsayer Jurim
    [36404260] = {route={36404260, 36204060, 35603880, 36003660, 36003360, 36603040, r=0.8, g=0, b=0.8}},
    [53802120] = {route={53802120, 52802340, 50802520, 48802540, 47602680, 43402620, 42402660, 41202580, r=0.8, g=0, b=0.8}},
    [70605000] = {route={70605000, 66404440, 65204040, 60403500, 58403400, 57003240, 56103330, 55403260, r=0.8, g=0, b=0.8}},
}, {
    achievement=ns.BLOODY_RARE, criteria=4510,
    npc=18686,
    loot={31232,31233,31235,31236},
})
ns.RegisterPoints(ns.TEROKKAR, {
    -- Crippler
    [38806740] = {}, -- inside Auchindoun ring
    [30406380] = {},
    [32405200] = {},
    [39604860] = {},
    [48405740] = {},
    [48207460] = {},
}, {
    achievement=ns.BLOODY_RARE, criteria=4509,
    npc=18689,
    loot={31238},
    note="Wanders the Bone Wastes",
})
ns.RegisterPoints(ns.TEROKKAR, {
    [76208100] = { -- Hawkbane
        npc=21724,
        -- tameable=true,
    },
})

ns.RegisterPoints(ns.BLADESEDGE, {
    -- Morcrush
    [61802260] = {},
    [78602980] = {route={78602980, 77802440, 74402340, 71602920, 71403460, r=0.8, g=0.8, b=0.8}},
    [61805440] = {route={61805440, 65004920, 67604720, 71004140, r=0.8, g=0.8, b=0.8}},
    [68207560] = {route={68207560, 68807200, 67206820, 67806440, r=0.8, g=0.8, b=0.8}},
}, {
    achievement=ns.BLOODY_RARE, criteria=4518,
    npc=18690,
    loot={31159,31160,31161,31162},
})
ns.RegisterPoints(ns.BLADESEDGE, {
    -- Hemathion
    [30004540] = {route={30004540, 29604980, 32605340, 31405700, r=1, g=0, b=0}},
    [30007160] = {route={30007160, 28006620, 29206360, 30206600, 30206740, 31006900, r=1, g=0, b=0}},
}, {
    achievement=ns.BLOODY_RARE, criteria=4514,
    npc=18692,
    loot={31155,31156,31157,31158},
})
ns.RegisterPoints(ns.BLADESEDGE, {
    -- Speaker Mar'grom
    [39205660] = {route={39205660, 41605400, 41805600, 42605580, r=1, g=0.8, b=0}},
    [41004880] = {route={41004880, 41605180, 42604940, r=1, g=0.8, b=0}},
    [42408200] = {route={42408200, 45207660, 46607800, 47207520, r=1, g=0.8, b=0}},
    [56402440] = {route={56402440, 56602740, 57603000, 57603340, 55803500, r=1, g=0.8, b=0}},
}, {
    achievement=ns.BLOODY_RARE, criteria=4521,
    npc=18693,
    loot={31163,31164,31165,31166},
})

ns.RegisterPoints(ns.SHADOWMOON, {
    -- Collidus the Warp-Watcher
    [55007040] = {route={55007040, 56007360, 57607460, 59607020, r=1, g=0, b=0}},
    [72006640] = {route={72006640, 69806680, 68006920, 65806940, 64406660, r=1, g=0, b=0}},
    [37604440] = {route={37604440, 38604280, 40004360, 41804700, 45005040, 46005380, r=1, g=0, b=0}},
    [57802400] = {route={57802400, 60802160, 63202260, 67202180, 66602580, 68202940, 70402940, r=1, g=0, b=0}},
}, {
    achievement=ns.BLOODY_RARE, criteria=4508,
    npc=18694,
    loot={31217,31218,31219,31220},
})
ns.RegisterPoints(ns.SHADOWMOON, {
    -- Ambassador Jerrikar
    [29805260] = {},
    [46803020] = {},
    [47006840] = {},
    [58403640] = {},
    [71206220] = {},
}, {
    achievement=ns.BLOODY_RARE, criteria=4504,
    npc=18695,
    loot={31221,31223,31224,31225},
})
ns.RegisterPoints(ns.SHADOWMOON, {
    -- Kraator
    [31404480] = {},
    [42604120] = {},
    [43006740] = {},
    [45601280] = {},
    [59604700] = {},
}, {
    achievement=ns.BLOODY_RARE, criteria=4515,
    npc=18696,
    loot={31213,31214,31215,31216},
})

ns.RegisterPoints(ns.NETHERSTORM, {
    -- Chief Engineer Lorthander
    [25804240] = {},
    [48008140] = {},
    [58606380] = {},
}, {
    achievement=ns.BLOODY_RARE, criteria=4506,
    npc=18697,
    loot={31201},
})
ns.RegisterPoints(ns.NETHERSTORM, {
    -- Ever-Core the Punisher
    [19807000] = {route={19807000, 22606440, 26006540, 27606740, 26207240, 23207500, 20407340, loop=true, r=0, b=1, g=0}},
    [30804260] = {route={30804260, 29804160, 29603940, 27204200, 24404160, 23604020, 24003840, r=0, b=1, g=0}},
    [59803480] = {route={59803480, 61603220, 65603380, 68604180, 67804460, 64204820, 57604400, 57403920, loop=true, r=0, b=1, g=0}},
}, {
    achievement=ns.BLOODY_RARE, criteria=4511,
    npc=18698,
    loot={31203},
})
ns.RegisterPoints(ns.NETHERSTORM, {
    -- Nuramoc
    [25008020] = {route={25008020, 34607860, 43807600, 43607100, r=1, g=0.8, b=0}},
    [53605960] = {route={53605960, 59205800, 65605820, r=1, g=0.8, b=0}},
    [32603100] = {route={32603100, 35201960, r=1, g=0.8, b=0}},
}, { 
    achievement=ns.BLOODY_RARE, criteria=4519,
    npc=20932,
    loot={31209,31210,31211,31212},
})

--[[
ns.RegisterPoints(ns.KARAZHAN_SERVANTS, {
    --48003660,50404320,59602870,65603240,
    [] = { -- Hyakiss the Lurker
        npc=16179,
        loot={30678,30677,30676,30675},
        --tameable=true,
    },
    --48602780,59003560,59602870,64802980,
    [] = { -- Shadikith the Glider
        npc=16180,
        loot={30683,30682,30681,30680},
        --tameable=132182,
    },
    --58201960,59602870,66801820,72001980,
    [] = { -- Rokad the Ravager
        npc=16181,
        loot={30687,30686,30685,30684},
        --tameable=877481,
    },
})
--]]

-- Starter zones in Azeroth:

ns.RegisterPoints(ns.EVERSONG, {
    [70804780] = { -- Eldinarcus
        npc=16854,
    },
    [62407980] = { -- Tregla
        npc=16855,
        route={62407980, 65207880, 67607960, 69408380, 69407880, 70607660, 68807120, 67007140, 65206720},
    },
})

ns.RegisterPoints(ns.GHOSTLANDS, {
    [29408840] = {},
    [34404700] = {},
    [35408860] = {},
    [40004960] = {},
}, { -- Dr. Whitherlimb
        npc=22062,
        loot={31268,31269,31270},
})

ns.RegisterPoints(ns.AZUREMYST, {
    [26406720] = {},
    [27405200] = {},
    [28607920] = {},
    [32406280] = {},
    [33402660] = {},
    [33607060] = {},
    [34001840] = {},
    [35606440] = {},
    [36403240] = {},
    [36606040] = {},
    [37201960] = {},
    [43006320] = {},
    [46403920] = {},
    [50202900] = {},
    [51601840] = {},
    [53604120] = {},
    [59001820] = {},
    [64803940] = {},
}, { -- Blood Elf Bandit
    npc=17591,
    loot={23909,{23910,quest=9616,}},
})

ns.RegisterPoints(ns.BLOODMYST, {
    -- Fenissa the Assassin
    --14605500,17404880,20806240,21805580,24205040,35606280,
    [15405020] = {route={15405020, 14805480, 18405940, 19855520, 19204980, r=1, g=0, b=0}},
    [20806180] = {route={20806180, 22405960, 21805540, 23005420, 25005320, 26005180, r=1, g=0, b=0}},
    [36606060] = {route={36606060, 37006360, 40206380, 41006120, 39605820, 37805820, loop=true, r=1, g=0, b=0},note="Patrols counterclockwise"},
}, {
        npc=22060,
        loot={31256,31263,31264},
        note="{spell:1784:Stealth}",
})

-- ns.RegisterPoints(66, { -- desolace
--     --34402420,41002020,
--     [] = { -- Crusty
--         npc=18241,
--         --},tameable=132186,
--     },

-- Spirit healers
local spirit = {
    label="{npc:6491:Spirit Healer}",
    texture=ns.atlas_texture("poi-graveyard-neutral", {r=0.5, g=1, b=1}),
    IsActive=function(point) return UnitIsDead("player") end,
    group="spirithealer",
}
ns.RegisterPoints(ns.HELLFIRE, {
    [22803780] = {},
    [27406340] = {},
    [54806640] = {},
    [57403820] = {},
    [60007980] = {},
    [64402260] = {},
    [68602700] = {},
    [87205020] = {},
}, spirit)
ns.RegisterPoints(ns.ZANGARMARSH, {
    [17004800] = {},
    [36804740] = {},
    [43403140] = {},
    [47405020] = {},
    [65005120] = {},
    [77206400] = {},
}, spirit)
ns.RegisterPoints(ns.TEROKKAR, {
    [22000380] = {},
    [39802180] = {},
    [44607120] = {},
    [50601160] = {},
    [59404260] = {},
    [62808140] = {},
}, spirit)
ns.RegisterPoints(ns.BLADESEDGE, {
    [33405860] = {},
    [37202440] = {},
    [38406780] = {},
    [52006040] = {},
    [60206620] = {},
    [61401420] = {},
    [62803740] = {},
    [69205840] = {},
    [74402660] = {},
}, spirit)
ns.RegisterPoints(ns.NAGRAND, {
    [20203580] = {},
    [32805620] = {},
    [40203040] = {},
    [42604620] = {},
    [63406900] = {},
    [66602460] = {},
}, spirit)
ns.RegisterPoints(ns.NETHERSTORM, {
    [33806540] = {},
    [42602920] = {},
    [56408340] = {},
    [64806640] = {},
}, spirit)
ns.RegisterPoints(ns.SHADOWMOON, {
    [32202860] = {},
    [39405620] = {},
    [57405920] = {},
    [63603220] = {},
    [65404320] = {},
    [65604300] = {},
    -- [65804560] = {}, -- technically...
}, spirit)
ns.RegisterPoints(ns.AZUREMYST, {
    [39001940] = {},
    [47805600] = {},
    [77604880] = {},
}, spirit)
ns.RegisterPoints(ns.BLOODMYST, {
    [30404600] = {},
    [58405800] = {},
}, spirit)
ns.RegisterPoints(ns.EVERSONG, {
    [38201760] = {},
    [44207100] = {},
    [48004960] = {},
    [60006400] = {},
}, spirit)
ns.RegisterPoints(ns.GHOSTLANDS, {
    [43802580] = {},
    [61405680] = {},
    [80406920] = {},
}, spirit)
ns.RegisterPoints(ns.QUELDANAS, {
    [46603260] = {},
}, spirit)
