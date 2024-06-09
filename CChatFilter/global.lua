
BFF_ADDON_NAME = 'CChatFilter'
BFWC_Filter_SavedConfigs = {
}
BFWC_Filter_SavedConfigs_G = {}

bfwf_big_foot_world_channel_joined = false

bfwf_dungeons = {
    {name='乌特加德城堡(69 ~ 72)',num=5,lmin=69,lmax=72,sel=true,keys={'cb','城堡'}},
    {name='魔枢(71 ~ 73)',num=5,lmin=71,lmax=73,sel=true,keys={'魔枢'}},
    {name='艾卓-尼鲁布(72 ~ 74)',num=5,lmin=72,lmax=74,sel=true,keys={'艾卓','az'}},
    {name='安卡赫特:古代王国(73 ~ 75)',num=5,lmin=73,lmax=75,sel=true,keys={'古王国','古国'}},
    {name='达克萨隆要塞(74 ~ 76)',num=5,lmin=74,lmax=76,sel=true,keys={'ys','要塞'}},
    {name='紫罗兰监狱(75 ~ 77)',num=5,lmin=75,lmax=77,sel=true,keys={'jy','监狱'}},
    {name='古达克(76 ~ 78)',num=5,lmin=76,lmax=78,sel=true,keys={'gdk','古达克'}},
    {name='岩石大厅(77 ~ 79)',num=5,lmin=77,lmax=79,sel=true,keys={'岩石'}},
    {name='闪电大厅(80)',num=5,lmin=80,lmax=80,sel=true,keys={'闪电'}},
    {name='魔环(80)',num=5,lmin=80,lmax=80,sel=true,keys={'mh','魔环'}},
    {name='净化斯坦索姆(80)',num=5,lmin=80,lmax=80,sel=true,keys={'stsm','斯坦索姆'}},
    {name='乌特加德之巅(80)',num=5,lmin=80,lmax=80,sel=true,keys={'wd','乌巅'}},
    {name='冠军的试炼(80)',num=5,lmin=80,lmax=80,sel=true,keys={'sl','试炼'}},
    {name='灵魂洪炉(80)',num=5,lmin=80,lmax=80,sel=true,keys={'hl','洪炉'}},
    {name='萨隆矿坑(80)',num=5,lmin=80,lmax=80,sel=true,keys={'kk','矿坑'}},
    {name='映像大厅(80)',num=5,lmin=80,lmax=80,sel=true,keys={'dt','大厅'}},

    {name='纳克萨玛斯(团)',num=25,lmin=80,lmax=80,sel=false,keys={'naxx','纳克萨玛斯'}},
    {name='黑耀石圣殿(团)',num=25,lmin=80,lmax=80,sel=false,keys={'hys','黑耀石'}},
    {name='永恒之眼(团)',num=25,lmin=80,lmax=80,sel=false,keys={'eoe','蓝龙'}},
    {name='奥杜尔(团)',num=25,lmin=80,lmax=80,sel=false,keys={'uld','adl','奥杜尔'}},
    {name='奥妮克西亚的巢穴(团)',num=25,lmin=80,lmax=80,sel=false,keys={'黑龙'}},
    {name='阿尔卡冯的宝库(团)',num=25,lmin=80,lmax=80,sel=false,keys={'宝库'}},
    {name='十字军试炼(团)',num=25,lmin=80,lmax=80,sel=false,keys={'toc','十字军'}},
    {name='冰冠堡垒(团)',num=25,lmin=80,lmax=80,sel=false,keys={'icc','冰冠堡垒'}},
    {name='红玉圣殿(团)',num=25,lmin=80,lmax=80,sel=false,keys={'sd','红玉圣殿','圣殿'}},
}

bfwf_player = {}

bfwf_configs_init = function() end
bfwf_update_minimap_icon = function() end
bfwf_minimap_button_init = function() end
bfwf_chat_filter_init = function() end
bfwf_toggle_bf_filter = function() end
bfwf_split_str = function() end
bfwf_toggle_config_dialog = function() end
bfwf_update_dungeons_filter = function() end
bfwf_update_icon = function()
    bfwf_update_minimap_icon()
end

bfwf_chat_team_log = {}

bfwf_g_data = {
    level = 0,
}

--玩家职业颜色缓存
bfwf_player_color = {}
