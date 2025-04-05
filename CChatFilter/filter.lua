
local timer = LibStub('AceTimer-3.0')
local last_show_message = {

}

local dirty = false
local _G = _G

local emotes = {
        --表情
    { key = "angel",    zhTW="天使",    zhCN="天使" },
    { key = "angry",    zhTW="生氣",    zhCN="生气" },
    { key = "biglaugh", zhTW="大笑",    zhCN="大笑" },
    { key = "clap",  zhTW="鼓掌",   zhCN="鼓掌" },
    { key = "cool",  zhTW="酷",      zhCN="酷" },
    { key = "cry",    zhTW="哭",     zhCN="哭" },
    { key = "cutie",    zhTW="可愛",    zhCN="可爱" },
    { key = "despise",  zhTW="鄙視",    zhCN="鄙视" },
    { key = "dreamsmile", zhTW="美夢",    zhCN="美梦" },
    { key = "embarrass", zhTW="尷尬",  zhCN="尴尬" },
    { key = "evil",  zhTW="邪惡",   zhCN="邪恶" },
    { key = "excited",  zhTW="興奮",    zhCN="兴奋" },
    { key = "faint",    zhTW="暈",       zhCN="晕" },
    { key = "fight",    zhTW="打架",    zhCN="打架" },
    { key = "flu",    zhTW="流感",      zhCN="流感" },
    { key = "freeze",   zhTW="呆",       zhCN="呆" },
    { key = "frown",    zhTW="皺眉",    zhCN="皱眉" },
    { key = "greet",    zhTW="致敬",    zhCN="致敬" },
    { key = "grimace",  zhTW="鬼臉",    zhCN="鬼脸" },
    { key = "growl",    zhTW="齜牙",    zhCN="龇牙" },
    { key = "happy",    zhTW="開心",    zhCN="开心" },
    { key = "heart",    zhTW="心",       zhCN="心" },
    { key = "horror",   zhTW="恐懼",    zhCN="恐惧" },
    { key = "ill",    zhTW="生病",      zhCN="生病" },
    { key = "innocent", zhTW="無辜",    zhCN="无辜" },
    { key = "kongfu",   zhTW="功夫",    zhCN="功夫" },
    { key = "love",  zhTW="花痴",   zhCN="花痴" },
    { key = "mail",  zhTW="郵件",   zhCN="邮件" },
    { key = "makeup",   zhTW="化妝",    zhCN="化妆" },
    { key = "mario",    zhTW="馬里奧", zhCN="马里奥" },
    { key = "meditate", zhTW="沉思",    zhCN="沉思" },
    { key = "miserable", zhTW="可憐",  zhCN="可怜" },
    { key = "okay",  zhTW="好",      zhCN="好" },
    { key = "pretty",   zhTW="漂亮",    zhCN="漂亮" },
    { key = "puke",  zhTW="吐",      zhCN="吐" },
    { key = "shake",    zhTW="握手",    zhCN="握手" },
    { key = "shout",    zhTW="喊",       zhCN="喊" },
    { key = "shuuuu",   zhTW="閉嘴",    zhCN="闭嘴" },
    { key = "shy",    zhTW="害羞",      zhCN="害羞" },
    { key = "sleep",    zhTW="睡覺",    zhCN="睡觉" },
    { key = "smile",    zhTW="微笑",    zhCN="微笑" },
    { key = "suprise",  zhTW="吃驚",    zhCN="吃惊" },
    { key = "surrender", zhTW="失敗",  zhCN="失败" },
    { key = "sweat",    zhTW="流汗",    zhCN="流汗" },
    { key = "tear",  zhTW="流淚",   zhCN="流泪" },
    { key = "tears",    zhTW="悲劇",    zhCN="悲剧" },
    { key = "think",    zhTW="想",       zhCN="想" },
    { key = "titter",   zhTW="偷笑",    zhCN="偷笑" },
    { key = "ugly",  zhTW="猥瑣",   zhCN="猥琐" },
    { key = "victory",  zhTW="勝利",    zhCN="胜利" },
    { key = "volunteer", zhTW="雷鋒",  zhCN="雷锋" },
    { key = "wronged",  zhTW="委屈",    zhCN="委屈" },  
        --指定了texture一般用於BLIZ自帶的素材
    { key = "wrong",    zhTW="錯",       zhCN="错",   texture = "Interface\\RaidFrame\\ReadyCheck-NotReady" },
    { key = "right",    zhTW="對",       zhCN="对",   texture = "Interface\\RaidFrame\\ReadyCheck-Ready" },
    { key = "question", zhTW="疑問",    zhCN="疑问",  texture = "Interface\\RaidFrame\\ReadyCheck-Waiting" },
    { key = "skull",    zhTW="骷髏",    zhCN="骷髅",  texture = "Interface\\TargetingFrame\\UI-TargetingFrame-Skull" },
    { key = "sheep",    zhTW="羊",       zhCN="羊",   texture = "Interface\\TargetingFrame\\UI-TargetingFrame-Sheep" },
        --原版暴雪提供的8个图标
    { key = "rt1",  zhTW="rt1",     zhCN="rt1", texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_1" },
    { key = "rt2",  zhTW="rt2",     zhCN="rt2", texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_2" },
    { key = "rt3",  zhTW="rt3",     zhCN="rt3", texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_3" },
    { key = "rt4",  zhTW="rt4",     zhCN="rt4", texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_4" },
    { key = "rt5",  zhTW="rt5",     zhCN="rt5", texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_5" },
    { key = "rt6",  zhTW="rt6",     zhCN="rt6", texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_6" },
    { key = "rt7",  zhTW="rt7",     zhCN="rt7", texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_7" },
    { key = "rt8",  zhTW="rt8",     zhCN="rt8", texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8" },
}

local function get_whisper_frame()
    for i=1,NUM_CHAT_WINDOWS do
        local name,_=GetChatWindowInfo(i)
        if name == '私聊' or name == '私' or name == '密' then
            return ''..i
        end
    end
    return nil
end

local function ReplaceEmote(value)
    local emote = value:gsub("[%{%}]", "")
    for _, v in ipairs(emotes) do
        if (emote == v.key or emote == v.zhCN or emote == v.zhTW) then
            return "|T".. (v.texture or "Interface\\AddOns\\CChatFilter\\texture\\Emotes\\".. v.key) ..":16|t"
        end
    end
    return value
end

local function filter(_msg)
    local num = BFWC_Filter_SavedConfigs.white_to_chatframe_num or get_whisper_frame()
    if not num then
        return
    end

    local chatframe = _G['ChatFrame' .. num]
    if not chatframe then
        return
    end

    if not BFWC_Filter_SavedConfigs.white_to_chatframe_num then
        BFWC_Filter_SavedConfigs.white_to_chatframe_num = num
    end

    _msg = _msg:gsub("%{.-%}", ReplaceEmote)
    chatframe:AddMessage(_msg)

    if BFWC_Filter_SavedConfigs.new_msg_flash then
        if not chatframe:IsShown() then
            FCF_StartAlertFlash(chatframe)
        end
    end
end

local function add_msgto_chatframe(name,msg,chnum,chname)
    local color = '|c' .. BFWC_Filter_SavedConfigs.white_to_chatframe_color.hex
    local tlcolor = bfwf_player_color[name]
    if not tlcolor then
        tlcolor = '|cffffc0c0'
    end

    if BFWC_Filter_SavedConfigs.use_class_color_for_text then
        color = tlcolor
    end

    local _msg = color .. '|Hchannel:' .. chnum .. '|h[' .. chnum..". "..chname.. ']|h|r'
    _msg = _msg .. " " .. '|Hplayer:' .. name .. '|h' .. color .. '[|r' .. tlcolor .. name .. '|r' .. color .. ']|h:  |r'
    _msg = _msg .. color .. msg .. '|r'
    
    filter(_msg)
end

local function to_short_name(fullname)
    local name
    local sp,_ = string.find(fullname,'-')
    if sp then
        name = string.sub(fullname,1,sp-1)
    else
        name = fullname
    end

    return name
end

local function add_msg_to_team_log(line,message,chnum,chname,lmessage,playerguid,fullname,shortname,mymsg)
    local add_to_log = true
    for _,m in ipairs(bfwf_chat_team_log) do
        if m.line == line then
            add_to_log = false
            break
        end
    end

    if not mymsg and add_to_log and BFWC_Filter_SavedConfigs.filter_request_to_join and string.find(lmessage,'求组') then
        add_to_log = false
    end

    if not add_to_log then
        return
    end

    if not shortname then
        shortname = to_short_name(fullname)
    end
    if BFWC_Filter_SavedConfigs.white_to_chatframe then
        if bfwf_player_color[shortname] or not timer then
            add_msgto_chatframe(shortname,message,chnum,chname)
        else
            --职业颜色没缓存好，延迟0.3秒(filter在AddMessage之前执行)
            timer:ScheduleTimer(add_msgto_chatframe,0.3,shortname,message,chnum,chname)
        end
    end
    local idx = 0
    dirty = true
    for i = 1, #bfwf_chat_team_log do
        if bfwf_chat_team_log[i].playerid == playerguid then
            idx = i
            break
        end
    end
    local data = {
        line = line,
        playerid = playerguid,
        fullname = fullname,
        name = shortname,
        time = GetTime(),
        text = message
    }
    if idx > 0 then
        bfwf_chat_team_log[idx] = data
    else
        table.insert(bfwf_chat_team_log, 1, data)
    end

    if #bfwf_chat_team_log > 100 then
        local oldid = 0
        local oldtime = GetTime()
        for i = 1, #bfwf_chat_team_log do
            if bfwf_chat_team_log[i].time < oldtime then
                oldid = i
                oldtime = bfwf_chat_team_log[i].time
            end
        end
        table.remove(bfwf_chat_team_log, oldix, 1)
    end
end

local _chatframex_hook_addmessage = false

local function get_name_color(msg)
    local pos1,pos2=string.find(msg,'\124Hplayer:')
    if not pos1 or not pos2 then
        return
    end
    pos1,_ = string.find(msg,'%[',pos2)
    if not pos1 then
        return
    end
    local color = string.sub(msg,pos1+1,pos1+10)
    if not color or string.len(color) ~= 10 then
        return
    end
    pos2,_ = string.find(msg,'|r',pos1+11)
    if not pos2 then
        return
    end
    local name = string.sub(msg,pos1+11,pos2-1)
    if not name or string.len(name) == 0 then
        return
    end

    return name,color
end
local function __chatframex_new_addmessage(chatframe,msg,...)
    local name,color = get_name_color(msg)
    if name and color then
        bfwf_player_color[name] = color
    end

    if chatframe._chatframex_origin_addmessage then
        chatframe._chatframex_origin_addmessage(chatframe,msg,...)
    end
end

--返回true拦截，false放行
--同一条信息，过滤器会被多次调用，每个聊天标签一次(line相同)
--每条消息都有不同的行号(line)
--修改消息：return false,newmsg, from, a, b, c, d, e, chnum, chname, f,line,...
--fullname不一定能完整取到，有时服务器名取不到。即使同一个人，刚才能取到，现在不一定能取到
local last_line_number = 0
local last_return
local last_message
local last_trim = 0
local function chat_message_filter(chatFrame, event, message,...)
    if not BFWC_Filter_SavedConfigs.enable then
        return false
    end

    if not message or string.len(message)==0 then
        return false
    end

    --fullname, a, b, shortname, d, e, chnum, chname, f,line,playerguid,
    local fullname = select(1,...)
    local shortname = select(4,...)
    local chatflag = select(5,...)
    local chnum = select(7,...)
    local chname = select(8,...)
    local line = select(10,...)
    local playerguid = select(11,...)

    local sender = Ambiguate(fullname, 'none');
    if sender == UnitName('player') then
        return false;
    end

    if line == last_line_number then
        if last_return then
            return true
        end
        if last_trim == 0 then
            return false
        end
        return false,last_message,...
    end
    last_return = false
    last_line_number = line
    last_trim = 0
    last_message = message

    --目前尚未发现playerguid取不到的情况
    if not playerguid then
        if not bfwf_g_data.playerguid_null then
            bfwf_g_data.playerguid_null = 1
        else
            bfwf_g_data.playerguid_null = bfwf_g_data.playerguid_null + 1
        end
        return false
    end

    if not chname then
        return false
    end

    if chatflag == "DND" then
    	return true
    end

    --一些整合插件会把频道名过滤成简称
    --大脚：
    local filter_it = false
    local black_to_all = false  --黑名单过滤其它频道
    --大脚世界频道满员时会自动加入大脚世界频道

    if bfwf_start_whith(chname,'世') then
        filter_it = true
    elseif bfwf_start_whith(chname,'寻') then
        filter_it = true
    elseif bfwf_start_whith(chname,'大脚世界频道') then
        filter_it = true
    elseif bfwf_start_whith(chname,'寻求组队') then
        filter_it = true
    elseif bfwf_start_whith(chname,'综合') then
        filter_it = true
    elseif bfwf_start_whith(chname,'交易') then
        filter_it = true
    elseif BFWC_Filter_SavedConfigs.blacklist_enable and BFWC_Filter_SavedConfigs.blacklist_to_all_channel~=false then
        black_to_all = true
        filter_it = true
    end
    if not filter_it then
        return false
    end

    if not _chatframex_hook_addmessage then
        for i=1,10 do
            local cf = _G['ChatFrame'..i]
            if cf and cf.GetID and cf.AddMessage then
                local chns = {GetChatWindowChannels(cf:GetID() or 1)}
                for _,v in ipairs(chns) do
                    if bfwf_start_whith(v,'大脚世界频道') then
                        cf._chatframex_origin_addmessage = cf.AddMessage
                        cf.AddMessage = __chatframex_new_addmessage
                        _chatframex_hook_addmessage = true
                        break
                    end
                end
            end
        end
    end

    if BFWC_Filter_SavedConfigs.interval>0 then
        local now = GetTime()
        local last_time = last_show_message[playerguid] and last_show_message[playerguid].time or 0
        local last_line = last_show_message[playerguid] and last_show_message[playerguid].line or 0
        if (now-last_time) < BFWC_Filter_SavedConfigs.interval and line ~= last_line then
            last_return = true
            return true
        else
            last_show_message[playerguid] = { time = now, line = line}
        end
    end

    if BFWC_Filter_SavedConfigs.hide_enter_leave then
        if event == CHAT_MSG_CHANNEL_JOIN or event == CHAT_MSG_CHANNEL_LEAVE then
            last_return = true
            return true
        end
    end

    local lmessage = string.lower(message)
    if BFWC_Filter_SavedConfigs.blacklist_enable then
        for _,k in ipairs(BFWC_Filter_SavedConfigs_G.blacklist) do
            local lk = string.lower(k)
            if lk:len()>0 and string.find(lmessage,lk) then
                last_return = true
                return true
            end
            if k:len()>0 and string.find(fullname,k) then
                last_return = true
                return true
            end
        end
        if BFWC_Filter_SavedConfigs.not_sel_dungeons_as_blacklist then
            for _,d in ipairs(bfwf_dungeons) do
                if not BFWC_Filter_SavedConfigs.dungeons[d.name] then
                    for _,k in ipairs(d.keys) do
                        local lk = string.lower(k)
                        if lk:len()>0 and string.find(lmessage,lk) then
                            last_return = true
                            return true
                        end
                    end
                end
            end
        end
        if black_to_all then
            last_return = false
            return false
        end
    end

    if BFWC_Filter_SavedConfigs.blocklist_enable then
        for _,k in ipairs(BFWC_Filter_SavedConfigs_G.blocklist) do
            if k:len()>0 and string.find(fullname,k) then
                last_return = true
                return true
            end
        end
    end

    local trim = 0
    local _msg = ''
    if not BFWC_Filter_SavedConfigs.remain_unchanged_msg then
        trim,_msg = bfwf_trim_message(message)
        last_trim = trim
        if trim>0 then
            if BFWC_Filter_SavedConfigs.enable_debug then
                message = _msg .. '|r|cffbb9e75[-' .. trim .. ']|r'
            else
                message = _msg
            end
            last_message = message
        end
    end


    for _,d in ipairs(bfwf_dungeons) do
        if BFWC_Filter_SavedConfigs.dungeons[d.name] then
            for _,k in ipairs(d.keys) do
                local lk = string.lower(k)
                if lk:len()>0 and string.find(lmessage,lk) then
                    add_msg_to_team_log(line,message,chnum,chname,lmessage,playerguid,fullname,shortname,mymsg)
                    if trim>0 then
                        return false,message,...
                    end
                    return false
                end
            end
        end
    end

    for _, k in ipairs(BFWC_Filter_SavedConfigs.whitelist) do
        local lk = string.lower(k)
        if lk:len() > 0 and string.find(lmessage, lk) then
            add_msg_to_team_log(line,message,chnum,chname,lmessage,playerguid,fullname,shortname,mymsg)
            if trim>0 then
                return false,message,...
            end
            return false
        end
    end

    if BFWC_Filter_SavedConfigs.whiteonly then
        last_return = true
        return true
    end

    if trim > 0 then
        return false,message,...
    end
    return false
end

local function say_yell_Filter(self,event,message,fullname,...)
    if BFWC_Filter_SavedConfigs.blacklist_to_all_channel==false then
        return
    end
    if BFWC_Filter_SavedConfigs.blacklist_enable then
        local lmessage = string.lower(message)
        for _,k in ipairs(BFWC_Filter_SavedConfigs_G.blacklist) do
            local lk = string.lower(k)
            if lk:len()>0 and string.find(lmessage,lk) then
                return true
            end
        end
    end 
    if BFWC_Filter_SavedConfigs.blocklist_enable then
        for _,k in ipairs(BFWC_Filter_SavedConfigs_G.blocklist) do
            if k:len()>0 and string.find(fullname,k) then
                return true
            end
        end
    end
    return false
end
local function filter_proxy(...)
    local now = GetTime()
    local ret,msg,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13 = chat_message_filter(...)
    local dt = GetTime()-now
    if not msg then
        return ret
    end
    return ret,msg .. dt,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13
end

bfwf_chat_filter_init = function()
    if BFWC_Filter_SavedConfigs.enable_debug then
        ChatFrame_AddMessageEventFilter('CHAT_MSG_CHANNEL', filter_proxy)
    else
        ChatFrame_AddMessageEventFilter('CHAT_MSG_CHANNEL', chat_message_filter)
    end

    ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", say_yell_Filter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", say_yell_Filter)

    bfwf_update_icon()
end

bfwf_toggle_bf_filter = function()
    BFWC_Filter_SavedConfigs.enable = not BFWC_Filter_SavedConfigs.enable
    bfwf_update_icon()
end

local function BLOCKPLAYER()
    local name = UnitPopupSharedUtil.GetFullPlayerName()
    local IGNORE_ADDED = format(ERR_IGNORE_ADDED_S,name)
    table.insert(BFWC_Filter_SavedConfigs_G.blocklist, name)
    SendSystemMessage(IGNORE_ADD)
end

local CustomMenuButtonMixin = CreateFromMixins(UnitPopupButtonBaseMixin)
function CustomMenuButtonMixin:GetText() return IGNORE_PLAYER end
function CustomMenuButtonMixin:OnClick() BLOCKPLAYER() end

local GetFriendMenuButtons = UnitPopupMenuFriend.GetMenuButtons
function UnitPopupMenuFriend:GetMenuButtons()
    local buttons = GetFriendMenuButtons(self)
    table.insert(buttons, 8, CustomMenuButtonMixin)
    return buttons
end

function shortChannels()
    local gsub = _G.string.gsub    
    for i = 1, NUM_CHAT_WINDOWS do
        if ( i ~= 2 ) then
            local f = _G["ChatFrame"..i]
            local am = f.AddMessage
            f.AddMessage = function(frame, text, ...)
                if BFWC_Filter_SavedConfigs.shortChannels == true then
                    return am(frame, text:gsub('|h%[(%d+)%. .-%]|h', '|h[%1]|h'), ...)
                else
                    return am(frame, text, ...)
                end
            end
        end
    end
end