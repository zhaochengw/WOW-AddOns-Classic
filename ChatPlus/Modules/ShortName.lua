--聊天框短频道名
local ChannelStrings = {};
local ShortStrings = {};
local Chats = {};

if GetLocale() == "zhCN" then
    Chats = {
        CHAT_WHISPER_GET = "[密]%s说: ",
        CHAT_WHISPER_INFORM_GET = "[密]对%s说: ",
        CHAT_MONSTER_WHISPER_GET = "[密]%s说: ",
        CHAT_BN_WHISPER_GET = "[密]%s说: ",
        CHAT_BN_WHISPER_INFORM_GET = "[密]对%s说: ",
        CHAT_BN_CONVERSATION_GET = "%s:",
        CHAT_BN_CONVERSATION_GET_LINK = "|Hchannel:BN_CONVERSATION:%d|h[%s.对话]|h",
        CHAT_SAY_GET = "[说]%s: ",
        CHAT_MONSTER_SAY_GET = "[说]%s: ",
        CHAT_YELL_GET = "[喊]%s: ",
        CHAT_MONSTER_YELL_GET = "[喊]%s: ",
        CHAT_GUILD_GET = "|Hchannel:Guild|h[会]|h%s: ",
        CHAT_OFFICER_GET = "|Hchannel:OFFICER|h[官]|h%s: ",
        CHAT_PARTY_GET = "|Hchannel:Party|h[队]|h%s: ",
        CHAT_PARTY_LEADER_GET = "|Hchannel:PARTY|h[队]|h%s: ",
        CHAT_MONSTER_PARTY_GET = "|Hchannel:Party|h[队]|h%s: ",
        CHAT_PARTY_GUIDE_GET = "|Hchannel:PARTY|h[副]|h%s: ",
        CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|h[副]|h%s: ",
        CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|h[副]|h%s: ",
        CHAT_RAID_GET = "|Hchannel:raid|h[团]|h%s: ",
        CHAT_RAID_LEADER_GET = "|Hchannel:raid|h[团]|h%s: ",
        CHAT_RAID_WARNING_GET = "[团]%s: ",

        CHAT_AFK_GET = "[AFK]%s: ",
        CHAT_DND_GET = "[DND]%s: ",
        CHAT_EMOTE_GET = "%s: ",
        CHAT_PET_BATTLE_INFO_GET = "|Hchannel:PET_BATTLE_INFO|h[宠]|h: ",
        CHAT_PET_BATTLE_COMBAT_LOG_GET = "|Hchannel:PET_BATTLE_COMBAT_LOG|h[宠]|h: ",
        CHAT_CHANNEL_LIST_GET = "|Hchannel:频道:%d|h[%s]|h",
        CHAT_CHANNEL_GET = "%s: ",
    }

    ChannelStrings = {
        ChannelGeneral = "%[%d+%. 综合.-%]",
        ChannelTrade = "%[%d+%. 交易.-%]",
        ChannelWorldDefense = "%[%d+%. 世界防务%]",
        ChannelLocalDefense = "%[%d+%. 本地防务.-%]",
        ChannelLookingForGroup = "%[%d+%. 寻求组队%]",
        ChannelGuildRecruitment = "%[%d+%. 公会招募.-%]",
        ChannelWorldChannel = "%[%d+%. 大脚世界频道%]",
    };

    ShortStrings = {
        ChannelGeneral = "综",
        ChannelTrade = "交",
        ChannelWorldDefense = "世防",
        ChannelLocalDefense = "本防",
        ChannelLookingForGroup = "寻",
        ChannelGuildRecruitment = "募",
        ChannelWorldChannel = "世",
    };
elseif GetLocale() == "zhTW" then
    Chats = {
        CHAT_WHISPER_GET = "[密]%s説: ",
        CHAT_WHISPER_INFORM_GET = "[密]对%s説: ",
        CHAT_MONSTER_WHISPER_GET = "[密]%s説: ",
        CHAT_BN_WHISPER_GET = "[密]%s説: ",
        CHAT_BN_WHISPER_INFORM_GET = "[密]对%s説: ",
        CHAT_BN_CONVERSATION_GET = "%s:",
        CHAT_BN_CONVERSATION_GET_LINK = "|Hchannel:BN_CONVERSATION:%d|h[%s.對話]|h",
        CHAT_SAY_GET = "[説]%s: ",
        CHAT_MONSTER_SAY_GET = "[説]%s: ",
        CHAT_YELL_GET = "[喊]%s: ",
        CHAT_MONSTER_YELL_GET = "[喊]%s: ",
        CHAT_GUILD_GET = "|Hchannel:Guild|h[會]|h%s: ",
        CHAT_OFFICER_GET = "|Hchannel:OFFICER|h[官]|h%s: ",
        CHAT_PARTY_GET = "|Hchannel:Party|h[隊]|h%s: ",
        CHAT_PARTY_LEADER_GET = "|Hchannel:PARTY|h[隊]|h%s: ",
        CHAT_MONSTER_PARTY_GET = "|Hchannel:Party|h[隊]|h%s: ",
        CHAT_PARTY_GUIDE_GET = "|Hchannel:PARTY|h[副]|h%s: ",
        CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|h[副]|h%s: ",
        CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|h[副]|h%s: ",
        CHAT_RAID_GET = "|Hchannel:raid|h[團]|h%s: ",
        CHAT_RAID_LEADER_GET = "|Hchannel:raid|h[團]|h%s: ",
        CHAT_RAID_WARNING_GET = "[團]%s: ",

        CHAT_AFK_GET = "[AFK]%s: ",
        CHAT_DND_GET = "[DND]%s: ",
        CHAT_EMOTE_GET = "%s: ",
        CHAT_PET_BATTLE_INFO_GET = "|Hchannel:PET_BATTLE_INFO|h[寵]|h: ",
        CHAT_PET_BATTLE_COMBAT_LOG_GET = "|Hchannel:PET_BATTLE_COMBAT_LOG|h[寵]|h: ",
        CHAT_CHANNEL_LIST_GET = "|Hchannel:頻道:%d|h[%s]|h",
        CHAT_CHANNEL_GET = "%s: ",
    };

    ChannelStrings = {
        ChannelGeneral = "%[%d+%. 綜合.-%]",
        ChannelTrade = "%[%d+%. 交易.-%]",
        ChannelWorldDefense = "%[%d+%. 世界防務%]",
        ChannelLocalDefense = "%[%d+%. 本地防務.-%]",
        ChannelLookingForGroup = "%[%d+%. 尋求組隊%]",
        ChannelGuildRecruitment = "%[%d+%. 公會招募.-%]",
        ChannelWorldChannel = "%[%d+%. 大脚世界频道%]",
    };

    ShortStrings = {
        ChannelGeneral = "綜",
        ChannelTrade = "交",
        ChannelWorldDefense = "世防",
        ChannelLocalDefense = "本防",
        ChannelLookingForGroup = "尋",
        ChannelGuildRecruitment = "募",
        ChannelWorldChannel = "世",
    };
else
    Chats = {
        CHAT_WHISPER_GET = "[W]%s: ",
        CHAT_WHISPER_INFORM_GET = "[W]to%s: ",
        CHAT_MONSTER_WHISPER_GET = "[W]%s: ",
        CHAT_BN_WHISPER_GET = "[W]%s: ",
        CHAT_BN_WHISPER_INFORM_GET = "[W]to%s: ",
        CHAT_BN_CONVERSATION_GET = "%s:",
        CHAT_BN_CONVERSATION_GET_LINK = "|Hchannel:BN_CONVERSATION:%d|h[%s.C]|h",
        CHAT_SAY_GET = "[S]%s: ",
        CHAT_MONSTER_SAY_GET = "[S]%s: ",
        CHAT_YELL_GET = "[Y]%s: ",
        CHAT_MONSTER_YELL_GET = "[Y]%s: ",
        CHAT_GUILD_GET = "|Hchannel:Guild|h[G]|h%s: ",
        CHAT_OFFICER_GET = "|Hchannel:OFFICER|h[O]|h%s: ",
        CHAT_PARTY_GET = "|Hchannel:Party|h[P]|h%s: ",
        CHAT_PARTY_LEADER_GET = "|Hchannel:PARTY|h[P]|h%s: ",
        CHAT_MONSTER_PARTY_GET = "|Hchannel:Party|h[P]|h%s: ",
        CHAT_PARTY_GUIDE_GET = "|Hchannel:PARTY|h[I]|h%s: ",
        CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|h[I]|h%s: ",
        CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|h[I]|h%s: ",
        CHAT_RAID_GET = "|Hchannel:raid|h[R]|h%s: ",
        CHAT_RAID_LEADER_GET = "|Hchannel:raid|h[R]|h%s: ",
        CHAT_RAID_WARNING_GET = "[R]%s: ",

        CHAT_AFK_GET = "[AFK]%s: ",
        CHAT_DND_GET = "[DND]%s: ",
        CHAT_EMOTE_GET = "%s: ",
        CHAT_PET_BATTLE_INFO_GET = "|Hchannel:PET_BATTLE_INFO|h[Pet]|h: ",
        CHAT_PET_BATTLE_COMBAT_LOG_GET = "|Hchannel:PET_BATTLE_COMBAT_LOG|h[Pet]|h: ",
        CHAT_CHANNEL_LIST_GET = "|Hchannel:CHANNEL:%d|h[%s]|h",
        CHAT_CHANNEL_GET = "%s: ",
    };

    ChannelStrings = {
        ChannelGeneral = "%[%d+%. General.-%]",
        ChannelTrade = "%[%d+%. Trade.-%]",
        ChannelWorldDefense = "%[%d+%. WorldDefense%]",
        ChannelLocalDefense = "%[%d+%. LocalDefense.-%]",
        ChannelLookingForGroup = "%[%d+%. LookingForGroup%]",
        ChannelGuildRecruitment = "%[%d+%. GuildRecruitment.-%]",
        ChannelWorldChannel = "%[%d+%. 大脚世界频道%]",
    };

    ShortStrings = {
        ChannelGeneral = "GN",
        ChannelTrade = "TR",
        ChannelWorldDefense = "WD",
        ChannelLookingForGroup = "LD",
        ChannelLookingForGroup = "LFG",
        ChannelGuildRecruitment = "GR",
        ChannelWorldChannel = "WC",
    };
end

local msgHooks = {};
local AddMessage = function(frame, text, ...)
    if type(text) == "string" then
        local chatNum = string.match(text,"%d+") or "";
        if not tonumber(chatNum) then chatNum = "" else chatNum = chatNum.."." end
        if ChatPlusDB["shortname"] == 1 then
            for k, v in pairs(ChannelStrings) do
                text = gsub(text, ChannelStrings[k], "["..chatNum..ShortStrings[k].."]");
            end
        end
    end
    msgHooks[frame:GetName()].AddMessage(frame, text, ...);
end

local hooks = {};
function ChatPlusDB_ShortChannelName()
    if ChatPlusDB["shortname"] == 1 then
        for i = 1, NUM_CHAT_WINDOWS do
            local name = ("ChatFrame%d"):format(i);
            local f = _G[name];
            if f then
                if f ~= COMBATLOG and not msgHooks[name] then
                    msgHooks[name] = {};
                    msgHooks[name].AddMessage = f.AddMessage;
                    f.AddMessage = AddMessage;
                end
            end
        end
        if not hooks.CHAT_SAY_GET then
            for k, v in pairs(Chats) do
                hooks[k] = _G[k];
                _G[k] = v;
            end
        end
    else
        if hooks.CHAT_SAY_GET then
            for k, v in pairs(hooks) do
                _G[k] = v;
                hooks[k] = nil;
            end
        end
    end
end
