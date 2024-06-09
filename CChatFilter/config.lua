
local function whitelist_init()
    if BFWC_Filter_SavedConfigs.whitelist then
       return
    end

    BFWC_Filter_SavedConfigs.whitelist = { }
end

local function blacklist_init()
    if BFWC_Filter_SavedConfigs_G.blacklist then
        return
    end

    BFWC_Filter_SavedConfigs_G.blacklist = {
        '一组','/组','邮寄','U寄','大量','带价','代价','位面','支付',
        'VX','ZFB','收G','无限收','大米','小米','G收','全区服',
        '双法','导航','收人','招收','一波','荣誉','一门','爆本',
        '中转','直飞','飞机',"霜狼","工会","紫门","DKP",
        "宝宝","飞行","航空","接送","MLD","人双","玛拉顿",
        '代工','附魔',"托管","-80","/门","优惠",
    }

end

local function blocklist_init()
    if BFWC_Filter_SavedConfigs_G.blocklist then
        return
    end

    BFWC_Filter_SavedConfigs_G.blocklist = {}

end

local function dungeons_init()
    BFWC_Filter_SavedConfigs.dungeons = {}
    if bfwf_player.level and bfwf_player.level>0 and BFWC_Filter_SavedConfigs.auto_filter_by_level then
        local lv = bfwf_player.level
        for _,d in ipairs(bfwf_dungeons) do
            if lv>=d.lmin and lv<= d.lmax then
                BFWC_Filter_SavedConfigs.dungeons[d.name] = true
            else
                BFWC_Filter_SavedConfigs.dungeons[d.name] = false
            end
        end
    end
end

local reset_width = false
local reset_height = false

local function reset_configs_character()
    reset_width = true
    reset_height = true
    BFWC_Filter_SavedConfigs = {
        saved = true,
        enable = true,
        interval = 40,
        dlg_width = 900,
        dlg_height = 600,
        hide_enter_leave = true,
        auto_filter_by_level = false,
        filter_request_to_join = true,
        minimap = { hide = false},
        shortChannels = false,
        player = {},
        dungeons = {},
        bigfoot = true,
        bigfoot_chatframe_name = 1,
        blacklist_enable = true,
        blocklist_enable = true,
        remain_unchanged_msg = false
    }
    BFWC_Filter_SavedConfigs.white_to_chatframe = true
    BFWC_Filter_SavedConfigs.white_to_chatframe_color={a=1,r=1,g=0.753,b=0.753,hex='ffffc0c0'}
    dungeons_init()
    whitelist_init()
end

function JoinBigfoot()
    local id = GetChannelName("大脚世界频道")
    if id == 0 then
        JoinPermanentChannel("大脚世界频道")
        C_Timer.After(1, function() JoinBigfoot() end)
    end
    if BFWC_Filter_SavedConfigs.bigfoot_chatframe_name then
        for i = 1 , 10 do
            ChatFrame_RemoveChannel(_G['ChatFrame'..i], "大脚世界频道")
        end
        ChatFrame_AddChannel(_G['ChatFrame'..BFWC_Filter_SavedConfigs.bigfoot_chatframe_name], "大脚世界频道")
    else
        for i = 1 , 10 do
            ChatFrame_RemoveChannel(_G['ChatFrame'..i], "大脚世界频道")
        end
        ChatFrame_AddChannel(ChatFrame1, "大脚世界频道")
    end
end

function LeaveBigfoot()
    LeaveChannelByName("大脚世界频道");
end

StaticPopupDialogs['BFWC_CONFIRM'] = {
    text = '',
    button1 = '是',
    button2 = '取消',
    timeout = 0,
    showAlert = true,
    whileDead = true,
    preferredIndex = STATICPOPUP_NUMDIALOGS,
    OnAccept = function(self)

    end
}

local function hex_color(r,g,b,a)
    local hex = string.format('%x',math.floor(255*a))
    hex = hex .. string.format('%x',math.floor(255*r))
    hex = hex .. string.format('%x',math.floor(255*g))
    hex = hex .. string.format('%x',math.floor(255*b))
    return hex
end

local debug_data = {}

-- https://www.wowace.com/projects/ace3/pages/ace-config-3-0-options-tables
local config_options = {
    type = 'group',
    name = '组队频道信息过滤器',
    args = {
        common = {
            type = 'group',
            name = '通用设置',
            order = 1,
            args = {
                reset = {
                    type = 'execute',
                    name = '恢复默认设置',
                    order = 1,
                    func = function()
                        reset_configs_character()
                        BFWC_Filter_SavedConfigs_G.blacklist = nil
                        blacklist_init()
                        BFWC_Filter_SavedConfigs_G.blocklist = nil
                        blocklist_init()
                    end
                },

                enable = {
                    type = 'toggle',
                    name = '启用过滤器',
                    order = 2,
                    width = 'full',
                    get = function(info)
                        return BFWC_Filter_SavedConfigs.enable
                    end,
                    set = function(info, val)
                        BFWC_Filter_SavedConfigs.enable = val
                        bfwf_update_icon()
                    end
                },

                enterleave = {
                    type = 'toggle',
                    name = '不显示进入/离开频道信息',
                    order = 3,
                    width = 'full',
                    get = function(info)
                        return BFWC_Filter_SavedConfigs.hide_enter_leave
                    end,
                    set = function(info, val)
                        BFWC_Filter_SavedConfigs.hide_enter_leave = val
                    end,
                    disabled = function(info)
                        return not BFWC_Filter_SavedConfigs.enable
                    end
                },

                minimap = {
                    type = 'toggle',
                    name = '显示小地图按钮',
                    order = 4,
                    width = 'full',
                    set = function(info, val)
                        BFWC_Filter_SavedConfigs.minimap.hide = not val
                        if val then
                            LibStub("LibDBIcon-1.0"):Show(BFF_ADDON_NAME)
                        else
                            LibStub("LibDBIcon-1.0"):Hide(BFF_ADDON_NAME)
                        end
                    end,
                    get = function(info)
                        return not BFWC_Filter_SavedConfigs.minimap.hide
                    end
                },

                shortChannels = {
                    type = 'toggle',
                    name = '隐藏频道名称',
                    order = 5,
                    width = 'full',
                    get = function(info)
                        return BFWC_Filter_SavedConfigs.shortChannels
                    end,
                    set = function(info, val)
                        BFWC_Filter_SavedConfigs.shortChannels = val
                        shortChannels()
                    end,
                    disabled = function(info)
                        return not BFWC_Filter_SavedConfigs.enable
                    end
                },

                bigfoot = {
                    type = 'toggle',
                    name = '自动加入大脚世界频道',
                    order = 6,
                    width = 'full',
                    get = function()
                        return BFWC_Filter_SavedConfigs.bigfoot
                    end,
                    set = function(info, val)
                        BFWC_Filter_SavedConfigs.bigfoot = val
                        if val then
                            JoinBigfoot()
                        elseif not val then
                            LeaveBigfoot()
                        end
                    end,
                    disabled = function(info)
                        return not BFWC_Filter_SavedConfigs.enable
                    end
                },

                chatframe = {
                    type = 'select',
                    name = '聊天窗口',
                    order = 7,
                    width = 1,
                    values = function()
                        local arr = {}
                        for i=1,NUM_CHAT_WINDOWS do
                            local name,_=GetChatWindowInfo(i)
                            if name and string.len(name)>0 then
                                arr[''..i] = name
                            end
                        end
                        return arr
                    end,
                    get = function()
                        return BFWC_Filter_SavedConfigs.bigfoot_chatframe_name
                    end,
                    set = function(info,val)
                        for i = 1 , 10 do
                            ChatFrame_RemoveChannel(_G['ChatFrame'..i], "大脚世界频道")
                        end
                        BFWC_Filter_SavedConfigs.bigfoot_chatframe_name = val
                        ChatFrame_AddChannel(_G['ChatFrame'..BFWC_Filter_SavedConfigs.bigfoot_chatframe_name], "大脚世界频道")
                    end,
                    disabled = function(info)
                        return not BFWC_Filter_SavedConfigs.enable
                    end
                },

                desc1={
                    type='description',
                    name='选择一个聊天窗口显示大脚世界频道信息(可选)，默认为“综合”频道\n也可以右键点击聊天窗口，选“设置”，再选“通用频道”，手动勾选大脚世界频道',
                    order = 8,
                    width = 'full',
                },

                interval = {
                    type = 'range',
                    name = '刷屏过滤(同一个人，间隔小于设定秒数的发言将被过滤掉)',
                    desc = '同一个人，间隔小于设定秒数的发言将被过滤掉',
                    min = 0,
                    max = 60,
                    step = 1,
                    width = 'full',
                    order = 9,
                    get = function(info)
                        return BFWC_Filter_SavedConfigs.interval
                    end,
                    set = function(info, val)
                        BFWC_Filter_SavedConfigs.interval = val
                    end,
                    disabled = function(info)
                        return not BFWC_Filter_SavedConfigs.enable
                    end
                },

                reducemsg = {
                    type = 'toggle',
                    name = '|cffffd100重复符号、词、句裁减|r',
                    desc = '|cffffd100比如：ZUL 4=1T++++++++++MMMMMMMMMMM压缩成ZUL 4=1T++MM|r',
                    descStyle = 'inline',
                    order = 10,
                    width = 'full',
                    get = function() return not BFWC_Filter_SavedConfigs.remain_unchanged_msg end,
                    set = function(info,val)
                        BFWC_Filter_SavedConfigs.remain_unchanged_msg=not val
                    end,
                    disabled = function(info)
                        return not BFWC_Filter_SavedConfigs.enable
                    end
                },

                whiteonly = {
                    type = 'toggle',
                    name = '|cffffd100只显示包含白名单关键词的信息|r',
                    desc = '|cffff0000危险：本选项会过滤掉所有白名单以外信息。这将导致大量信息被过滤!\n如果你不是明确明白该选项的用途，请不要勾选！|r',
                    descStyle = 'inline',
                    order = 11,
                    width = 'full',
                    get = function() return BFWC_Filter_SavedConfigs.whiteonly end,
                    set = function(info,val) BFWC_Filter_SavedConfigs.whiteonly=val end,
                    disabled = function(info)
                        return not BFWC_Filter_SavedConfigs.enable
                    end
                },

                classcolor = {
                    type = 'toggle',
                    name = '使用职业颜色',
                    order = 12,
                    width = 'full',
                    get = function()
                        local v,_ = GetCVarInfo('chatClassColorOverride')
                        if v == '0' then
                            return true
                        end
                        return false
                    end,
                    set = function(info,val)
                        if val then
                            BFWC_Filter_SavedConfigs.use_class_color = true
                            SetCVar("chatClassColorOverride", "0")
                        else
                            BFWC_Filter_SavedConfigs.use_class_color = false
                            SetCVar("chatClassColorOverride", "1")
                        end
                    end,
                    disabled = function(info)
                        return not BFWC_Filter_SavedConfigs.enable
                    end
                },

                blacklist_to_all_channel = {
                    type = 'toggle',
                    name = '黑名单过滤所有通用频道以及“说”、“大喊”',
                    desc = '(不含小队、团队、公会、私聊)',
                    descStyle='inline',
                    width = 'full',
                    order = 13,
                    get = function()
                        return BFWC_Filter_SavedConfigs.blacklist_to_all_channel~=false
                    end,
                    set = function(info,val)
                        BFWC_Filter_SavedConfigs.blacklist_to_all_channel = val
                    end,
                    disabled = function(info)
                        return not BFWC_Filter_SavedConfigs.enable
                    end
                }
            }
        },

        blacklist = {
            type = 'group',
            name = '黑名单',
            order = 2,
            width = 0.5,
            disabled = function(info)
                return not BFWC_Filter_SavedConfigs.enable
            end,
            args = {
                enable = {
                    type = 'toggle',
                    name = '启用关键词黑名单',
                    order = 1,
                    disabled = false,
                    get = function(info) return BFWC_Filter_SavedConfigs.blacklist_enable end,
                    set = function(info, val) BFWC_Filter_SavedConfigs.blacklist_enable = val  end
                },
                editor = {
                    type = 'input',
                    name = '自定义关键词(用英文逗号分隔，不要回车)',
                    multiline = true,
                    usage = '关键词之间用英文逗号分隔，不要回车',
                    width = 'full',
                    order = 2,
                    disabled = function() return not BFWC_Filter_SavedConfigs.blacklist_enable end,
                    get = function()
                        return table.concat(BFWC_Filter_SavedConfigs_G.blacklist,',')
                    end,
                    set = function(info,val)
                        BFWC_Filter_SavedConfigs_G.blacklist = bfwf_split_str(val)
                    end
                },
                blockenable = {
                    type = 'toggle',
                    name = '启用无限屏蔽黑名单',
                    order = 3,
                    disabled = false,
                    get = function(info) return BFWC_Filter_SavedConfigs.blocklist_enable end,
                    set = function(info, val) BFWC_Filter_SavedConfigs.blocklist_enable = val end
                },
                blockeditor = {
                    type = 'input',
                    name = '角色名字(右键点击聊天频道角色名字添加，也可手动添加)',
                    multiline = true,
                    usage = '名字之间用英文逗号分隔，不要回车',
                    width = 'full',
                    multiline = 21,
                    order = 4,
                    disabled = function() return not BFWC_Filter_SavedConfigs.blocklist_enable end,
                    get = function()
                        return table.concat(BFWC_Filter_SavedConfigs_G.blocklist,',')
                    end,
                    set = function(info,val)
                        BFWC_Filter_SavedConfigs_G.blocklist = bfwf_split_str(val)
                    end
                }
            }
        },

        whitelist = {
            type = 'group',
            name = '白名单',
            order = 3,
            width = 0.5,
            disabled = function(info)
                return not BFWC_Filter_SavedConfigs.enable
            end,
            args = {
                editor = {
                    type = 'input',
                    name = '自定义组队信息关键词(用英文逗号分隔，不要回车)',
                    multiline = true,
                    usage = '关键词之间用英文逗号分隔，不要回车',
                    width = 'full',
                    order = 1,
                    disabled = function() return not BFWC_Filter_SavedConfigs.enable end,
                    get = function()
                        return table.concat(BFWC_Filter_SavedConfigs.whitelist or {},',')
                    end,
                    set = function(info,val)
                        BFWC_Filter_SavedConfigs.whitelist = bfwf_split_str(val) or {}
                    end
                },
                unsel_as_black = {
                    type = 'toggle',
                    name = '|cffee0e00未勾选的副本当成黑名单|r|cffffee00(如果您不明白该选项的用途，不要勾选)|r',
                    order = 2,
                    width = 'full',
                    get = function() return BFWC_Filter_SavedConfigs.not_sel_dungeons_as_blacklist end,
                    set = function(info,val)
                        BFWC_Filter_SavedConfigs.not_sel_dungeons_as_blacklist = val
                    end
                },
                autosel = {
                    type = 'toggle',
                    name = '根据我的等级自动过滤组队信息！|cffffee00(建议您手动勾选副本，更精确)|r',
                    disabled = function() return not BFWC_Filter_SavedConfigs.enable end,
                    get = function(info) return BFWC_Filter_SavedConfigs.auto_filter_by_level end,
                    set = function(info,val)
                        BFWC_Filter_SavedConfigs.auto_filter_by_level = val
                        bfwf_update_dungeons_filter()
                    end,
                    width = 'full',
                    order = 3,
                },
                addtochatframe = {
                    type = 'toggle',
                    name = '白名单过滤出来的信息添加到指定聊天窗口',
                    order = 4,
                    width = 'full',
                    get = function() return BFWC_Filter_SavedConfigs.white_to_chatframe end,
                    set = function(info,val) BFWC_Filter_SavedConfigs.white_to_chatframe=val end
                },

                chatframe = {
                    type = 'select',
                    name = '聊天窗口',
                    order = 5,
                    width=0.75,
                    values = function()
                        local arr = {}
                        for i=1,NUM_CHAT_WINDOWS do
                            local name,_=GetChatWindowInfo(i)
                            if name and string.len(name)>0 then
                                arr[''..i] = name
                            end
                        end
                        return arr
                    end,
                    get = function()
                        return BFWC_Filter_SavedConfigs.white_to_chatframe_num
                    end,
                    set = function(info,val)
                        BFWC_Filter_SavedConfigs.white_to_chatframe_num=val
                    end,
                    disabled = function() return not BFWC_Filter_SavedConfigs.white_to_chatframe end
                },

                chatcolor = {
                    type = 'color',
                    name = '文字颜色',
                    order = 6,
                    width=0.75,
                    hasAlpha = true,
                    disabled = function() return BFWC_Filter_SavedConfigs.use_class_color_for_text end,
                    get = function()
                        local r,g,b,a
                        r = BFWC_Filter_SavedConfigs.white_to_chatframe_color.r or 1
                        g = BFWC_Filter_SavedConfigs.white_to_chatframe_color.g or 1
                        b = BFWC_Filter_SavedConfigs.white_to_chatframe_color.b or 1
                        a = BFWC_Filter_SavedConfigs.white_to_chatframe_color.a or 1
                        return r,g,b,a
                    end,
                    set = function(info,r,g,b,a)
                        r = r or 1
                        g = g or 1
                        b = b or 1
                        a = a or 1
                        BFWC_Filter_SavedConfigs.white_to_chatframe_color = {
                            r=r,g=g,b=b,a=a,hex = hex_color(r,g,b,a)
                        }
                    end
                },

                txcolor = {
                    type = 'toggle',
                    name = '文字用职业颜色',
                    order = 7,
                    get = function() return BFWC_Filter_SavedConfigs.use_class_color_for_text end,
                    set = function(info,val) BFWC_Filter_SavedConfigs.use_class_color_for_text=val end
                },

                flash = {
                    type = 'toggle',
                    name = '新信息提醒',
                    order = 8,
                    get = function() return BFWC_Filter_SavedConfigs.new_msg_flash end,
                    set = function(info,val) BFWC_Filter_SavedConfigs.new_msg_flash=val end
                },

                desc2 = {
                    type = 'description',
                    name = '\n手动选择关心的副本组队信息\n|cffffee00中括号内文字是预设的关键字，如果不能满足需求可在上方编辑框自行添加白名单关键词。|r',
                    order = 9,
                    width = 'full'
                }
            }
        },
    }
}

local function str_cat(arr)
    local s = '    ['
    local first = true
    for _,k in ipairs(arr or {}) do
        if first then
            first = false
        else
            s = s .. ','
        end
        s = s .. '|cffbb9e75' .. string.upper(k) .. '|r'
        first = false
    end
    s = s .. ']'
    return s
end

bfwf_configs_init = function()
    if not BFWC_Filter_SavedConfigs or not BFWC_Filter_SavedConfigs.saved then
        reset_configs_character()
    end

    blacklist_init()
    whitelist_init()
    blocklist_init()

    local args = config_options.args.whitelist.args

    if not BFWC_Filter_SavedConfigs.white_to_chatframe_color then
        BFWC_Filter_SavedConfigs.white_to_chatframe = true
        BFWC_Filter_SavedConfigs.white_to_chatframe_color={a=1,r=0.753,g=0.753,b=0.753,hex='ffffc0c0'}
    end

    local order = 10
    for _,d in ipairs(bfwf_dungeons) do
        order = order + 1
        args[d.name] = {
            type = 'toggle',
            name = '|cff0099ff' .. d.name .. '|r' .. str_cat(d.keys),
            width = 'full',
            order = order,
            disabled = function(info) return BFWC_Filter_SavedConfigs.auto_filter_by_level end,
            get = function(info) return BFWC_Filter_SavedConfigs.dungeons[info[2]] end,
            set = function(info,val) BFWC_Filter_SavedConfigs.dungeons[info[2]] = val end
        }
    end
    LibStub("AceConfig-3.0"):RegisterOptionsTable(BFF_ADDON_NAME, config_options)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(BFF_ADDON_NAME, "组队频道过滤")
end

--[[
"PARENT"
"BACKGROUND"
"LOW"
"MEDIUM"
"HIGH"
"DIALOG"
"FULLSCREEN"
"FULLSCREEN_DIALOG"
"TOOLTIP"
--]]
local cfgdlg = LibStub("AceConfigDialog-3.0")
local close_button = nil
local function close_dialog()
    if cfgdlg then
        cfgdlg:Close(BFF_ADDON_NAME)
    end
end

local old_on_width_set_func
local old_on_height_set_func
local function OnWidthSet(self,width)
    if reset_width then
        reset_width = false
        width = 900
    end
    BFWC_Filter_SavedConfigs.dlg_width = math.floor(width or 900)
    if BFWC_Filter_SavedConfigs.dlg_width<640 then
        BFWC_Filter_SavedConfigs.dlg_width = 640
    end
    if old_on_width_set_func and old_on_width_set_func ~= OnWidthSet then
        old_on_width_set_func(self,width)
    end
end

local function OnHeightSet(self,height)
    if reset_height then
        reset_height = false
        height = 600
    end
    BFWC_Filter_SavedConfigs.dlg_height = math.floor(height or 600)
    if BFWC_Filter_SavedConfigs.dlg_height<480 then
        BFWC_Filter_SavedConfigs.dlg_height = 480
    end
    if old_on_height_set_func and old_on_height_set_func ~= OnHeightSet then
        old_on_height_set_func(self,height)
    end
end

bfwf_toggle_config_dialog = function()
    local w = BFWC_Filter_SavedConfigs.dlg_width or 950
    local h = BFWC_Filter_SavedConfigs.dlg_height or 600
    if cfgdlg.OpenFrames and cfgdlg.OpenFrames[BFF_ADDON_NAME] then
        if cfgdlg.OpenFrames[BFF_ADDON_NAME]:IsShown() then
            cfgdlg:Close(BFF_ADDON_NAME)
            old_on_width_set_func = nil
            old_on_height_set_func = nil
        else
            cfgdlg:SetDefaultSize(BFF_ADDON_NAME, w, h)
            cfgdlg:Open(BFF_ADDON_NAME)
            cfgdlg.OpenFrames[BFF_ADDON_NAME].frame:SetFrameStrata("MEDIUM")
            create_close_button()
            if not old_on_width_set_func then
                old_on_width_set_func = cfgdlg.OpenFrames[BFF_ADDON_NAME].OnWidthSet
            end
            if not old_on_height_set_func then
                old_on_height_set_func = cfgdlg.OpenFrames[BFF_ADDON_NAME].OnHeightSet
            end
            cfgdlg.OpenFrames[BFF_ADDON_NAME].OnWidthSet = OnWidthSet
            cfgdlg.OpenFrames[BFF_ADDON_NAME].OnHeightSet = OnHeightSet
        end
    else
        cfgdlg:SetDefaultSize(BFF_ADDON_NAME, w, h)
        cfgdlg:Open(BFF_ADDON_NAME)
        cfgdlg.OpenFrames[BFF_ADDON_NAME].frame:SetFrameStrata("MEDIUM")
        if not old_on_width_set_func then
            old_on_width_set_func = cfgdlg.OpenFrames[BFF_ADDON_NAME].OnWidthSet
        end
        if not old_on_height_set_func then
            old_on_height_set_func = cfgdlg.OpenFrames[BFF_ADDON_NAME].OnHeightSet
        end
        cfgdlg.OpenFrames[BFF_ADDON_NAME].OnWidthSet = OnWidthSet
        cfgdlg.OpenFrames[BFF_ADDON_NAME].OnHeightSet = OnHeightSet
    end
end
