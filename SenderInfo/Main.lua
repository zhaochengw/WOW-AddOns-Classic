
local __addon, __private = ...;
local Main = {}
__private.Main = Main;
Main.MyData = {};
local GS = __private.GS;
local WCL = __private.WCL;
local View = __private.View;
local SenderInfo = __private.SenderInfo;
local _G = _G;
local alaMeta ;
local alaEmu ;
local __emulib ;

local pushState = true;
local allChat = {};
local allTalent = {};
local allEquip = {};
local allEquipInfo = {};
local allNotify = {};
local allQueryRequest = {};

local lastAllChat = {}; --已经私聊过的人员名单 30秒内再次私聊会屏蔽的名单
local SELFNAME = "";
local SELFFULLNAME = "";

local open;
local showClassColour = true; --职业颜色
local showLevel = true; --显示等级
local showDetailTalent = true; --具体天赋信息
local showEquipLevel = true; --显示装等
local showGS = true; --显示GS
local showWCL = true; --显示WCL
local infoShowToSystem = true; --显示的信息在 系统频道 / 聊天频道

local selfChat; --被我私聊人的名字
local sendSelfInfo = true; ---发送自己的信息
local sendSelfInfoCondition = "1"; ---发送1 才发送自己的消息
local sendSelfMSG_WHISPER_INFORM = true; --私聊时 可以发送
local sendSelfMSG_SAY = true; --说时 可以发送
local sendSelfMSG_GUILD = true;--公会频道 可以发送
local sendSelfChatType = ""; ---发送的位置

local joinGroupNotify = true; --加入通知
local leaderNotify = true; --只有是队长/团长 助手时才通知

local L = LibStub("AceLocale-3.0"):GetLocale("SenderInfo");
local showIntervalTime = 30; --显示间隔  防止一个人连续私聊
local maxTime = 10; --X秒后清空缓存 因为有的人没装插件 或者 查询装备很慢的情况
local yellowColour = "fff000"; --黄色
local redColour = "ff0000"; --红色
local huiColour = "666666"; --灰色
local whiteColour = "ffffff"; --白色
local greenColour = "1EFF00"; --绿色
local blueColour = "0070FF"; --蓝色
local violetColour = "A335EE"; --紫色
local orangeColour = "FF8000"; --橙色

local ClassColour = {
    --DK
	DEATHKNIGHT = "B51B36",
    --XD
	DRUID = "CA6209",
    --LR
	HUNTER = "A8D170",
    --FS
	MAGE = "38B4D5",
    --QS
	PALADIN = "E884B0",
    --MS
	PRIEST = "FFFFFF",
    --DZ
	ROGUE = "DCD259",
    --SM
	SHAMAN = "005FBC",
    --SS
	WARLOCK = "7373CB",
    --ZS
	WARRIOR = "C69B6D",
};

local TalentConfig = {
	talent = "天赋",

	DEATHKNIGHT = "死亡骑士",
	DRUID = "德鲁伊",
	HUNTER = "猎人",
	MAGE = "法师",
	PALADIN = "圣骑士",
	PRIEST = "牧师",
	ROGUE = "盗贼",
	SHAMAN = "萨满",
	WARLOCK = "术士",
	WARRIOR = "战士",

	[398] = "鲜血",
	[399] = "冰霜",
	[400] = "邪恶",
	[283] = "平衡",
	[281] = "野性战斗",
	[282] = "恢复",
	[361] = "野兽控制",
	[363] = "射击",
	[362] = "生存",
	[81] = "奥术",
	[41] = "火焰",
	[61] = "冰霜",
	[382] = "神圣",
	[383] = "防护",
	[381] = "惩戒",
	[201] = "戒律",
	[202] = "神圣",
	[203] = "暗影",
	[182] = "刺杀",
	[181] = "战斗",
	[183] = "敏锐",
	[261] = "元素",
	[263] = "增强",
	[262] = "恢复",
	[302] = "痛苦",
	[303] = "恶魔学识",
	[301] = "毁灭",
	[161] = "武器",
	[164] = "狂怒",
	[163] = "防护",

	H = "|cff00ff00治疗|r",
	D = "|cffff0000输出|r",
	T = "|cffafafff坦克|r",
	P = "|cffff0000PVP|r",
	E = "|cffffff00PVE|r",

};

--排除0 4 19
local needSlot = {1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18};

--[[
0 = 远程子弹
1 = 头
2 = 项链
3 = 肩膀
4 = 衬衣
5 = 衣服
6 = 要带
7 = 裤子
8 = 鞋子
9 = 护腕
10 = 手
11 = 第一个戒指
12 = 第二个戒指
13 = 第一个饰品
14 = 第二个饰品
15 = 披风
16 = 主手
17 = 副手
18 = 远程/图腾/神像
19 = 战袍
]]


--为了好看 所以进行了颜色优化
--更新到WLK P2 奥杜尔
local function GetEquipAverageLevelColour(level)
    
    if level < 150 then --白
        return whiteColour;
    elseif level < 220 then --绿
        return greenColour;
    elseif level < 230 then -- 蓝
        return blueColour;
    elseif level < 240 then -- 紫
        return violetColour;
    else
        return orangeColour; -- 橙
    end

    return whiteColour;
end


local function OnChangeSenderInfo()
    allChat = {};
    allTalent = {};
    allEquip = {};
    allEquipInfo = {};
    lastAllChat = {};
    allNotify = {};
    allQueryRequest = {};
    selfChat = nil;
end

local function ClearData(name)
    allChat[name] = nil;
    allTalent[name] = nil;
    allEquip[name] = nil;
    allEquipInfo[name] = nil;
    selfChat = nil;
    sendSelfChatType = "";
end


local function StatReport_UpdateMyData()
    Main.MyData.Name = UnitName("player"); --名字
    Main.MyData.LV = UnitLevel("player"); --等级
    Main.MyData.CLASS, Main.MyData.CLASS_EN = UnitClass("player"); --职业
    --MyData.TKEY, MyData.TDATA = StatReport_TalentData(); --
end



local function Print(count,colour)
    if colour then
        SendSystemMessage(string.format("|cff%s%s|r",colour,count));
    else
        SendSystemMessage(string.format("|cff%s%s|r",yellowColour,count));
    end
end


local function PrintError(count)
    SendSystemMessage(string.format("|cff%s%s|r",redColour,count));
end


local function OnEvent(frame,event,...)
    local arg = {...};

    for i, v in pairs(arg) do
        print(i,v)
    end
    
    local msg = arg[1];
    local name = arg[5];
    
    print( UnitLevel(name)) --等级
    print( GetNumTalentTabs()) --天赋页
    print(   UnitClass(name)) --职业
    --print(   UnitArmor(name)) --护甲信息 1 基础 2 最终
    print(   UnitStat(name,1)) -- 1-4 力量 敏捷 耐力 智力
    print(  "角色伤害:" .. UnitDamage(name))
    print(  "角色治疗:" .. UnitGetIncomingHeals(name))
    print(  "角色当前生命值:" .. UnitHealth(name))
    print(  "角色最大生命值:" .. UnitHealthMax(name))
    print(  "资源类型:" .. UnitPowerType(name))
    print(  "资源值:" .. UnitPowerMax(name))
    print(  "资源值2:" .. UnitPowerMax(name,UnitPowerType(name)))
end



local function PrintTable(key,value,index)
    
    print("key" ..  index .. ": ".. key)

    if type(value) == "table" then
            
        for key2, value2 in pairs(value) do

            PrintTable(key2,value2,index+1);

        end

    else
        print("value: " .. value)
    end

end


local __base64, __debase64 = {  }, {  };
for i = 0, 9 do __base64[i] = tostring(i); end
__base64[10] = "-";
__base64[11] = "=";
for i = 0, 25 do __base64[i + 1 + 11] = strchar(i + 65); end
for i = 0, 25 do __base64[i + 1 + 11 + 26] = strchar(i + 97); end
for i = 0, 63 do
    __debase64[__base64[i]] = i;
end

local wipe, concat = table.wipe, table.concat;
local TALENT_REPLY_THROTTLED_INTERVAL = 1;
local GLYPH_REPLY_THROTTLED_INTERVAL = 4;
local EQUIPMENT_REPLY_THROTTLED_INTERVAL = 5;
local _TThrottle = {  };		--	Talent		--	1s lock
local _GThrottle = {  };		--	Glyph		--	4s lock
local _EThrottle = {  };		--	Equipment	--	15s lock
local COMM_PREFIX_LIST = { "ATEADD", "ATECOM", "EMUADD", "EMUCOM", };
local COMM_PREFIX_HASH = {  };
local _RecvBuffer = {  };
for i = 1, #COMM_PREFIX_LIST do
	local prefix = COMM_PREFIX_LIST[i];
	_RecvBuffer[prefix] = {  };
	COMM_PREFIX_HASH[prefix] = i;
end



---获取天赋字符串
local function GetTalent(name, code)

    local class, level, numGroup, activeGroup, data1, data2 = __emulib.DecodeTalentDataV2(code);
    local subIndex = 0;
    local cData = activeGroup == 1 and data1 or data2;
    local maxCount = 0;
    local curTal = 0;
    local strT = "(";

    local classSpec = alaEmu.DT.ClassSpec[class];

    for index, value in ipairs(classSpec) do

        local talentDB = alaEmu.DT.TalentDB[class][value];
        local curT = strsub(cData, subIndex + 1, subIndex + #talentDB )
        subIndex = subIndex + #talentDB;
        local count = 0;
        for utfChar in string.gmatch(curT, "[%z\1-\127\194-\244][\128-\191]*") do
            count = count + utfChar;
        end
        if count >= maxCount then
            curTal = value;
            maxCount = count;
        end
        
        if	index >= #classSpec then
            strT = strT .. count .. ")"
        else
            strT = strT .. count .. "/"
        end

    end 



    local talentStr = "";

    if showDetailTalent then
        if showLevel then
            talentStr = string.format(L["天赋字符串1全部"], name,level,TalentConfig[curTal],TalentConfig[class],strT);
        else
            talentStr = string.format(L["天赋字符串2无级"], name,TalentConfig[curTal],TalentConfig[class],strT);
        end
    else
        if showLevel then
            talentStr = string.format(L["天赋字符串3无点"], name,level,TalentConfig[curTal],TalentConfig[class]);
        else
            talentStr = string.format(L["天赋字符串4无级无点"], name,TalentConfig[curTal],TalentConfig[class]);
        end
    end

    local classC = yellowColour;

    if showClassColour then
        classC = ClassColour[class];
    end

    talentStr = string.format("|cff%s%s|r",classC, talentStr);

    allTalent[name] = talentStr;
    return talentStr;
end


local function UpdateEquipLevel(name)

    if (not showEquipLevel) and (not showGS) then
        return true;
    end

    local EquData = allEquipInfo[name].EquData;

    local haveSlot = allEquipInfo[name].haveSlot;

    local itemLevelTable = allEquipInfo[name].itemLevelTable;

    local itemGearScore = allEquipInfo[name].itemGearScore;

    local itemAltScore = allEquipInfo[name].itemAltScore;

    local allResult = true;

    for key, slot in pairs(haveSlot) do

        --有一个没有结果都要继续查询
        if itemLevelTable[slot] == nil then

            --因为有可能查不到需要多查几次 同步无法解决 需要等待异步 循环只是一个小处理而已
            local name, link, quality, itemLevel, _, _, _, _, _, texture = GetItemInfo(EquData[slot]);
        
            --已查询到结果
            if itemLevel ~= nil then
                itemLevelTable[slot] = itemLevel;
                local GearScore, AltScore =  GS.GearScore_GetItemScore(link);
                itemGearScore[slot] = GearScore;
                itemAltScore[slot] = AltScore;
            else
                allResult = false;
            end

        end

    end

    if not allResult then
        return false
    end

    --双手武器时  副手 = 主手装等
    --如果只带了副手没带主手 不管
    if itemLevelTable[16] ~= nil and itemLevelTable[17] == nil then
        itemLevelTable[17] = itemLevelTable[16]
    end

    local allLevel = 0;
    for slot, level in pairs(itemLevelTable) do
        allLevel = allLevel + level;
    end

    local averageLevel = allLevel / #needSlot;

    --总值
    local allGs = 0
    for slot, gs in pairs(itemGearScore) do
        allGs = allGs + gs;
    end

    --修正值
    local allAltScore  = 0
    for slot, AltScore in pairs(itemAltScore) do
        allAltScore = allAltScore + AltScore;
    end

    --local gsStr = string.format(L["装备评分"],yellowColour,greenColour, string.format("%s(+%s)", allGs,allAltScore));
    local gsStr = string.format(L["装备评分"],yellowColour,greenColour, string.format("%s", allGs));
    local colour = GetEquipAverageLevelColour(averageLevel);
    local equipStr  = string.format(L["平均装等"],yellowColour,colour, string.format("%.2f", averageLevel));

    allEquip[name] = (showGS and gsStr or "") .. (showEquipLevel and equipStr or "") ;

    return true;
end


local function GetEquipment(name, code)
    
    if (not showEquipLevel) and (not showGS) then
        allEquipInfo[name] = {};
        return
    end

    local Decoder = __emulib.DecodeEquipmentDataV2;

    local cache = alaEmu.VT.TQueryCache[name];
    if cache == nil then
        cache = { TalData = {  }, EquData = {  }, GlyData = {  }, PakData = {  }, };
        alaEmu.VT.TQueryCache[name] = cache;
    end

    local EquData = cache.EquData;

    local isSelf = (name == alaEmu.CT.SELFNAME);

    if  Decoder(EquData, code) or isSelf then

        allEquipInfo[name] = {};

        local haveSlot = {}; -- 对于我需要查询的 我是不是有这个装备

        for key, slot in pairs(needSlot) do
            local item = EquData[slot];
            if item ~= nil  then
                table.insert(haveSlot,slot)
            end
        end

        allEquipInfo[name].haveSlot = haveSlot;--存储需要查询的
        allEquipInfo[name].itemLevelTable = {}; --查询结果
        allEquipInfo[name].EquData = EquData;
        allEquipInfo[name].itemGearScore = {};
        allEquipInfo[name].itemAltScore = {};

        UpdateEquipLevel(name);

    end

end


--name 当前名字
--allName 带服务器的名字
local function SendQueryRequest(name,allName)


    if lastAllChat[name] then
        return;
    end

    if not allName then
        allName = name .. "-" .. GetRealmName()
    end
    
    local time = GetTime();

    lastAllChat[name] = time; -- 防止重复发送的

    allChat[name] = time; -- 记录时间  X秒后直接清空 无论情况如何

    alaEmu.MT.SendQueryRequest(allName, nil, true, false)

end


local function CHAT_MSG(self,event,...)

    if not open then
        return;
    end

    local arg = {...};

    SendQueryRequest(arg[5],arg[2]);

end

local frame = CreateFrame("Frame")
--frame:RegisterEvent("CHAT_MSG_SAY");
--frame:RegisterEvent("CHAT_MSG_GUILD");
frame:RegisterEvent("CHAT_MSG_WHISPER");
--frame:RegisterEvent("CHAT_MSG_CHANNEL");
frame:SetScript("OnEvent",CHAT_MSG);




local function CHAT_MSG_SendSelfInfo(self,event,...)

    if not open or not sendSelfInfo then
        return;
    end

    local arg = {...};
    local msg = arg[1]; --消息内容
    local name = arg[5]; --被私聊的人的名字/发送者的名字

    local selfName = alaEmu.CT.SELFNAME;

    if event ~= "CHAT_MSG_WHISPER_INFORM" then
        if name ~= selfName then
            --print("不是我私聊别人,且不是我说话")
            return;
        end
    end

    if msg ~= sendSelfInfoCondition then
        return
    end

    if event == "CHAT_MSG_PARTY" then
        sendSelfChatType = "PARTY";
    elseif event == "CHAT_MSG_PARTY_LEADER" then
        sendSelfChatType = "PARTY";

    elseif event == "CHAT_MSG_RAID" then
        sendSelfChatType = "RAID";
    elseif event == "CHAT_MSG_RAID_LEADER" then
        sendSelfChatType = "GUILD";

    elseif event == "CHAT_MSG_GUILD" then
        sendSelfChatType = "GUILD";

    elseif event == "CHAT_MSG_WHISPER_INFORM" then
        sendSelfChatType = "WHISPER";
    else
        sendSelfChatType = "PARTY";
        PrintError("未知的消息类型" .. event)
    end

    alaEmu.MT.SendQueryRequest(alaEmu.CT.SELFFULLNAME, nil, true, false)

    local code = alaEmu.VT.VAR[alaEmu.CT.SELFGUID];

    if code then       
        selfChat = name;
        GetTalent(selfName,code);
        GetEquipment(selfName,code);
    end

end

local sendSelfInfoframe = CreateFrame("Frame")
sendSelfInfoframe:SetScript("OnEvent",CHAT_MSG_SendSelfInfo);

--私聊
function Main:ChangeSendSelfInfoEventWhisper(register)
    if register then
        sendSelfInfoframe:RegisterEvent("CHAT_MSG_WHISPER_INFORM"); --私聊别人
    else
        sendSelfInfoframe:UnregisterEvent("CHAT_MSG_WHISPER_INFORM"); --私聊别人
    end
end


--队伍
function Main:ChangeSendSelfInfoEventParty(register)
    if register then
        sendSelfInfoframe:RegisterEvent("CHAT_MSG_PARTY"); --队伍
        sendSelfInfoframe:RegisterEvent("CHAT_MSG_PARTY_LEADER"); --队长
    else
        sendSelfInfoframe:UnregisterEvent("CHAT_MSG_PARTY"); --队伍
        sendSelfInfoframe:UnregisterEvent("CHAT_MSG_PARTY_LEADER"); --队长
    end
end

--团队
function Main:ChangeSendSelfInfoEventRaid(register)
    if register then
        sendSelfInfoframe:RegisterEvent("CHAT_MSG_RAID"); --团队
        sendSelfInfoframe:RegisterEvent("CHAT_MSG_RAID_LEADER"); --团长
    else
        sendSelfInfoframe:UnregisterEvent("CHAT_MSG_RAID"); --团队
        sendSelfInfoframe:UnregisterEvent("CHAT_MSG_RAID_LEADER"); --团长
    end
end

--公会
function Main:ChangeSendSelfInfoEventGuild(register)
    if register then
        sendSelfInfoframe:RegisterEvent("CHAT_MSG_GUILD"); --公会频道
    else
        sendSelfInfoframe:UnregisterEvent("CHAT_MSG_GUILD"); --公会频道
    end
end

--触发条件
function Main:ChangeSendSelfInfoCondition(value)
    sendSelfInfoCondition = (value == nil or value == "") and "1" or value;
end

--发送开关
function Main:ChangeSendSelfInfo(value)
    sendSelfInfo = value;
    if not value then
        self:ChangeSendSelfInfoEventWhisper(false);
        self:ChangeSendSelfInfoEventParty(false);
        self:ChangeSendSelfInfoEventRaid(false);
        self:ChangeSendSelfInfoEventGuild(false);
    else
        self:InitSendSelfInfoEvent(__private.View.Cfg);
    end
end



function Main:InitSendSelfInfoEvent(cfg)
    self:ChangeSendSelfInfoEventWhisper(cfg.SendSelfInfoEventWhisper);
    self:ChangeSendSelfInfoEventParty(cfg.SendSelfInfoEventParty);
    self:ChangeSendSelfInfoEventRaid(cfg.SendSelfInfoEventRaid);
    self:ChangeSendSelfInfoEventGuild(cfg.SendSelfInfoEventGuild);
    sendSelfInfoCondition = cfg.SendSelfInfoInput;
    sendSelfInfo = cfg.SendSelfInfo;
end


local function OnEquipment(prefix, name, code, version, Decoder, overheard)
    GetEquipment(name, code)
end



local function OnTalent(prefix, name, code, version, Decoder, overheard)
    GetTalent(name,code);
end



local function ProcV2Message(prefix, msg, channel, sender)

	local overheard = false;
	local receiver = SELFNAME;
	if channel == "INSTANCE_CHAT" then
		local _1, _2 = strsplit("#", msg);
		msg = _1;
		if _2 ~= nil and _2 ~= SELFFULLNAME then
			overheard = true;
			receiver = _2;
		end
	end

	if strsub(msg, 1, 2) == "!P" then

		local num = __debase64[strsub(msg, 5, 5)] + __debase64[strsub(msg, 6, 6)] * 64;

		local index = __debase64[strsub(msg, 7, 7)] + __debase64[strsub(msg, 8, 8)] * 64;

		local Buffer = _RecvBuffer[prefix];

        Buffer[receiver] = Buffer[receiver] or {  };

		Buffer = Buffer[receiver]; Buffer[sender] = Buffer[sender] or {  };

		Buffer = Buffer[sender];

		Buffer[index] = strsub(msg, 9);

		for index = 1, num do
			if Buffer[index] == nil then
				return;
			end
		end

		_RecvBuffer[prefix][receiver][sender] = nil;

		return ProcV2Message(prefix, overheard and (concat(Buffer) .. "#" .. receiver) or concat(Buffer), channel, sender);

	end


	local _;
	local pos = 1;
	local code = nil;
	local v2_ctrl_code = nil;
	local len = #msg;
	while pos < len do
		_, pos, code, v2_ctrl_code = strfind(msg, "((![^!])[^!]+)", pos);
		if v2_ctrl_code == "!Q" then
			if overheard then
				return;
			end
			local name = Ambiguate(sender, 'none');
			local now = GetTime();

			local ReplyData = {  };
			for index = 3, #code do
				local v = strsub(code, index, index);
				if v == "T" then
					local prev = _TThrottle[name];
					if prev == nil or now - prev > TALENT_REPLY_THROTTLED_INTERVAL then
						_TThrottle[name] = now;
						ReplyData[1] = __emulib.EncodePlayerTalentDataV2();
						ReplyData[4] = __emulib.EncodeAddOnPackDataV2();
					end
				elseif v == "G" then
					local prev = _GThrottle[name];
					if prev == nil or now - prev > GLYPH_REPLY_THROTTLED_INTERVAL then
						_GThrottle[name] = now;
						ReplyData[2] = __emulib.EncodePlayerGlyphDataV2();
					end
				elseif v == "E" then
					local prev = _EThrottle[name];
					if prev == nil or now - prev > EQUIPMENT_REPLY_THROTTLED_INTERVAL then
						_EThrottle[name] = now;
						ReplyData[3] = __emulib.EncodePlayerEquipmentDataV2();
					end
				elseif v == "A" then
				else
				end
			end
			local msg = "";
			for index = 1, 4 do
				if ReplyData[index] ~= nil then
					msg = msg .. ReplyData[index];
				end
			end

			if msg ~= "" then
                --print("_SendLongMessage_____________________");
			end

		elseif v2_ctrl_code == "!T" then
            OnTalent(prefix, Ambiguate(sender, 'none'), code, "V2", __emulib.DecodeTalentDataV2, overheard);
		elseif v2_ctrl_code == "!G" then

		elseif v2_ctrl_code == "!E" then
            OnEquipment(prefix, Ambiguate(sender, 'none'), code, "V2", __emulib.DecodeEquipmentDataV2, overheard);
		elseif v2_ctrl_code == "!A" then
	
		end
	end
end


local function CHAT_MSG_ADDON(self,event,prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)

    if not open then
        --print("已关闭");
        return;
    end

    local shortname, r2 = strsplit("-", sender);

    if not allChat[shortname] then
        --print("非我想要的消息 " .. shortname);
        return
    end

    local verkey = strsub(msg, 1, 1);
    if verkey == "_" then
        return __emulib.ProcV1Message(prefix, msg, channel, sender);
    elseif verkey == "!" and __emulib._NumDistributors > 0 then
        return ProcV2Message(prefix, msg, channel, sender);
    else
        --print("一个无法解析的消息内容: " .. msg);
    end

end


--去掉所有颜色代码
--因为在密语时 无法加载颜色 会报错
local function GetNewMsg(msg)
    
    -- |cff%s--%s %s级 %s %s %s|r 
    local cIndex = string.find(msg,"|c");
    if cIndex then
        local start = "";
        if cIndex ~= 1 then
            start = string.sub(msg,1,cIndex-1);
        end

        local strEnd = string.sub(msg,cIndex+10,#msg);

        local newMsg = start .. strEnd;

        return GetNewMsg(newMsg);
    end

    local rIndex = string.find(msg,"|r");
    if rIndex then
        local start = "";
        if rIndex ~= 1 then
            start = string.sub(msg,1,rIndex-1);
        end

        local strEnd = string.sub(msg,rIndex+2,#msg);

        local newMsg = start .. strEnd;

        return GetNewMsg(newMsg);
    end

    return msg;

end

local function SendChatJoinNotify(name,channel,infoStr)

    local reportText = format("欢迎加入: %s ", infoStr)

    if __private.View.Cfg.Push then
        reportText = "[SenderInfo]" .. reportText;
    end

    SendChatMessage(reportText, channel)

    allNotify[name] = nil;
end


local function OnUpdate()
    
    if not open then
        return;
    end

    local time = GetTime();

    for name, lastTime in pairs(lastAllChat) do
        if time - lastTime >= showIntervalTime then
            lastAllChat[name] = nil;
            return;
        end
    end

    for name, lastTime in pairs(allChat) do
        if time - lastTime >= maxTime then
            ClearData(name);
            return;
        end
    end

    for name, _ in pairs(allEquipInfo) do

        if UpdateEquipLevel(name) then

            local msg = "";

            msg = msg .. (allTalent[name] or ""); --天赋信息

            if showWCL then
                local wcl = WCL.GetWclScore(name);  --WCL
                if wcl then
                    msg = msg .. wcl;
                end  
            end
      
            if showEquipLevel or showGS then
                msg = msg .. allEquip[name]; --装备信息 (GS -- 装等)
            end

            local newMsg = GetNewMsg(msg); --取掉颜色代码

            allNotify[name] = newMsg;

            --如果是入队通知
            for qName, channel in pairs(allQueryRequest) do
                if qName == name  then
                    SendChatJoinNotify(name,channel,allNotify[name]);
                    allQueryRequest[name] = nil;
                    ClearData(name);
                    return;
                end
            end

            if pushState then
                local pushMsg = L["推广后缀"];
                newMsg = newMsg .. pushMsg;
            end

            if name == alaEmu.CT.SELFNAME and selfChat ~= nil  then
                SendChatMessage(newMsg,sendSelfChatType,nil,selfChat);
            else

                __private.InviteTeamView:Add(name,msg);

                if infoShowToSystem then  --信息显示在系统频道  还是 聊天频道 (私聊对方)
                    SendSystemMessage(msg);
                else
                    SendChatMessage(newMsg,"WHISPER",nil,name);
                end
            end
             
            ClearData(name);
            return;
        end
    end

end



local frame2 = CreateFrame("Frame")
frame2:RegisterEvent("CHAT_MSG_ADDON");
frame2:SetScript("OnEvent",CHAT_MSG_ADDON);
frame2:SetScript("OnUpdate",OnUpdate);



local reportTemplate = "  %s:%s(%s%%)"
local raidTemplate = gsub(ERR_RAID_MEMBER_ADDED_S, '%%s', '(.+)')
local partyTemplate = gsub(JOINED_PARTY, '%%s', '(.+)')


local function JoinGroupNotifyEvent(self,event,msg,...)


    if not open then return end
    if not msg then return end
    if not IsInGroup() then return end
    
    local template, channel
    if IsInRaid() then
        template = raidTemplate
        channel = 'RAID'
    else
        template = partyTemplate
        channel = 'PARTY'
    end
    
    local name = strmatch(msg, template)

    if not name then return end

    __private.InviteTeamView:Remove(name);

    --通告
    if not joinGroupNotify then
        return
    end

    if leaderNotify then 
        if (not UnitIsGroupLeader('player') and not UnitIsGroupAssistant('player')) then
            return 
        end
    end

    local infoStr = allNotify[name];

    if infoStr then
        SendChatJoinNotify(name,channel,infoStr);
    else
        --需要请求
        allQueryRequest[name] = channel;
        SendQueryRequest(name);
    end
end


local frame3 = CreateFrame("Frame")
frame3:RegisterEvent("CHAT_MSG_SYSTEM")
frame3:SetScript("OnEvent",JoinGroupNotifyEvent)



local function OpenSenderInfo()
    InterfaceOptionsFrame_OpenToCategory("SenderInfo");
    InterfaceOptionsFrameAddOnsListScrollBar:SetValue(0);
    InterfaceOptionsFrame_OpenToCategory("SenderInfo");
end

SLASH_SINFO1 = "/sinfo";
SlashCmdList["SINFO"]=OpenSenderInfo;


function Main:ChangeOpen(set)
    
    if not __private.Load.TalentEmuLoaded then
        local hint = L["依赖天赋模拟器提示2"];
        PrintError(hint)
        return hint;
    end

    if not __private.Load.Prepare then
        local hint = L["未准备就绪"];
        PrintError(hint)
        return hint;
    end

    open = set;
    OnChangeSenderInfo();
    Print(string.format(L["开关提示1"],(open and "开启" or "关闭")));
end


function Main:ChangePush(set)
    pushState = set;
    Print(string.format(L["开关提示2"],(pushState and "开启" or "关闭")));
end


function Main:ChangeDetailTalent(set)
    showDetailTalent = set;
end

function Main:ChangeShowLevel(set)
    showLevel = set;
end

function Main:ChangeShowClassColour(set)
    showClassColour = set;
end

function Main:ChangeShowEquipLevel(set)
    showEquipLevel = set;
end

function Main:ChangeShowGS(set)
    showGS = set;
end

function Main:ChangeShowWCL(set)
    showWCL = set;
end

function Main:ChangeInfoShowToSystem(set)
    infoShowToSystem = set;
end


function Main:ChangeShowIntervalTime(set)
    showIntervalTime = set;
end

function Main:ChangeJoinGroupNotify(value)
    joinGroupNotify = value;
end

function Main:ChangeLeaderNotify(value)
    leaderNotify = value;
end

function Main:RemoveTargetNotifyInfo(name)
    --allNotify[name] = nil;
end
function Main:ClearNotifyInfo()
    allNotify = {};
end


function Main:Init()

    GS = __private.GS;
    WCL = __private.WCL;
    View = __private.View;
    SenderInfo = __private.SenderInfo;

    alaMeta = _G.__ala_meta__;
    alaEmu = alaMeta.emu;
    __emulib = _G.__ala_meta__.__emulib;
    local cfg = View.Cfg;

    View.Cfg.Open = self:ChangeOpen(cfg.Open) and false or cfg.Open;
    open = View.Cfg.Open;

    pushState = View.Cfg.Push;
    showDetailTalent = cfg.DetailTalent;
    showLevel = cfg.ShowLevel;
    showClassColour = cfg.ShowClassColour;
    showEquipLevel = cfg.ShowEquipLevel;
    showGS = cfg.ShowGS;
    showWCL = cfg.ShowWCL;
    infoShowToSystem = cfg.InfoShowToSystem;
    showIntervalTime = cfg.ShowIntervalTime;

    joinGroupNotify = cfg.JoinGroupNotify
    leaderNotify = cfg.LeaderNotify

    self:InitSendSelfInfoEvent(cfg);

    StatReport_UpdateMyData();

end 


