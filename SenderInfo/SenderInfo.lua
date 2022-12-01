
local __addon, __private = ...;

local View = {}
View.Cfg = {};
__private.View = View;
local Main = __private.Main;

SenderInfo = LibStub("AceAddon-3.0"):NewAddon("SenderInfo");
__private.SenderInfo = SenderInfo;

local L = LibStub("AceLocale-3.0"):GetLocale("SenderInfo");

if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
    SenderInfo.isClassic = true;
elseif (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) then
    SenderInfo.isTBC = true;
elseif (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
    SenderInfo.isRetail = true;
end

function SenderInfo:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("SenderInfoOptions", SenderInfo.optionDefaults, "Default");
    LibStub("AceConfig-3.0"):RegisterOptionsTable("SenderInfo", SenderInfo.options);
    self.SenderInfoOptions = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SenderInfo", "SenderInfo");
end

SenderInfo.options = {
	name = "",
	handler = SenderInfo,
	type = 'group',
	args = {

        --版本信息
		titleText = {
			type = "description",
			name = "|cffff6900SenderInfo (v" .. GetAddOnMetadata("SenderInfo", "Version") .. ")\n ",
			fontSize = "large",
			order = 0,
		},

        Open = {
			type = "toggle",
			name = L["开关标题"],
			desc = L["开关描述"],
			order = 1,
			get = "GetOpenToggle",
			set = "SetOpenToggle",
		},

		SendSelfInfo = {
			type = "toggle",
			name = L["是否开启发送自己信息标题"],
			desc = L["是否开启发送自己信息描述"],
			order = 2,
			get = "GetSendSelfInfoToggle",
			set = "SetSendSelfInfoToggle",
		},

		Push = {
			type = "toggle",
			name = L["推广标题"],
			desc = L["推广描述"],
			order = 3,
			get = "GetPushToggle",
			set = "SetPushToggle",
		},

		OpenTeamHelper = {
			type = "toggle",
			name = L["开团助手标题"],
			desc = L["开团助手描述"],
			order = 4,
			get = "GetOpenTeamHelperToggle",
			set = "SetOpenTeamHelperToggle",
		},

		SeekTeamOpen = {
			type = "toggle",
			name = L["寻求组队标题"],
			desc = L["寻求组队描述"],
			order = 5,
			get = "GetSeekTeamOpenToggle",
			set = "SetSeekTeamOpenToggle",
		},

		LeaderOpenHelper = {
			type = "toggle",
			name = L["队长时打开助手标题"],
			desc = L["队长时打开助手描述"],
			order = 6,
			get = "GetLeaderOpenHelperToggle",
			set = "SetLeaderOpenHelperToggle",
		},


		ExecuteOpenHelper = {
			type = "execute",
			name = L["手动打开助手标题"],
			desc = L["手动打开助手描述"],
			order = 7,
			func = "ExecuteOpenHelper",
		},
		


		TeamHelperViewWidth = {
			type = "range",
			name = L["开团助手界面宽度标题"],
			desc = L["开团助手界面宽度描述"],
			order = 8,
			get = "GetTeamHelperViewWidth",
			set = "SetTeamHelperViewWidth",
			min = 300,
			max = 3000,
			softMin = 300,
			softMax = 3000,
			step = 50,
			width = 1,
		},

		AutoOpenHelperTime = {
			type = "range",
			name = L["缩小后自动打开时间标题"],
			desc = L["缩小后自动打开时间描述"],
			order = 9,
			get = "GetAutoOpenHelperTime",
			set = "SetAutoOpenHelperTime",
			min = 0,
			max = 9999,
			softMin = 0,
			softMax = 9999,
			step = 5,
			width = 1,
		},

		ResetHelperViewPos = {
			type = "execute",
			name = L["重置小助手位置标题"],
			desc = L["重置小助手位置描述"],
			order = 10,
			func = "ExecuteResetHelperViewPos",
		},

		JoinGroupNotify = {
			type = "toggle",
			name = L["加入通知标题"],
			desc = L["加入通知描述"],
			order = 21,
			get = "GetJoinGroupNotifyToggle",
			set = "SetJoinGroupNotifyToggle",
		},

		LeaderNotify = {
			type = "toggle",
			name = L["仅队长通知标题"],
			desc = L["仅队长通知描述"],
			order = 22,
			get = "GetLeaderNotifyToggle",
			set = "SetLeaderNotifyToggle",
		},


		title0 = {
			type = "description",
            name = string.format("\n|cfffff000%s|r",L["插件提示0"]),
			fontSize = "medium",
			order = 31,
		},

		title1 = {
			type = "description",
            name = string.format("|cfffff000%s|r",L["插件提示1"]),
			fontSize = "medium",
			order = 32,
		},
        
		title2 = {
			type = "description",
            name = string.format("|cfffff000%s|r",L["插件提示2"]),
			fontSize = "medium",
			order = 33,
		},

		title3 = {
			type = "description",
            name = string.format("|cfffff000%s|r",L["插件提示3"]),
			fontSize = "medium",
			order = 34,
		},

		title4 = {
			type = "description",
            name = string.format("|cfffff000%s|r\n\n",L["插件提示4"]),
			fontSize = "medium",
			order = 35,
		},

		ShowHeader = {
			type = "description",
			name = string.format("|CffDEDE42%s|r\n\n   %s \n\n",L["预览"], ""),
			fontSize = "medium",
			order = 40,
		},

		ShowClassColour = {
			type = "toggle",
			name = L["显示职业颜色标题"],
			desc = L["显示职业颜色描述"],
			order = 41,
			get = "GetShowClassColourToggle",
			set = "SetShowClassColourToggle",
		},

		ShowLevel = {
			type = "toggle",
			name = L["显示等级标题"],
			desc = L["显示等级描述"],
			order = 42,
			get = "GetShowLevelToggle",
			set = "SetShowLevelToggle",
		},

		DetailTalent = {
			type = "toggle",
			name = L["具体天赋加点提示标题"],
			desc = L["具体天赋加点提示描述"],
			order = 43,
			get = "GetDetailTalentToggle",
			set = "SetDetailTalentToggle",
		},
		
		
		ShowWCL = {
			type = "toggle",
			name = L["显示WCL标题"],
			desc = L["显示WCL描述"],
			order = 44,
			get = "GetShowWCLToggle",
			set = "SetShowWCLToggle",
		},


		ShowGS = {
			type = "toggle",
			name = L["显示GS标题"],
			desc = L["显示GS描述"],
			order = 45,
			get = "GetShowGSToggle",
			set = "SetShowGSToggle",
		},


		ShowEquipLevel = {
			type = "toggle",
			name = L["显示装等标题"],
			desc = L["显示装等描述"],
			order = 46,
			get = "GetShowEquipLevelToggle",
			set = "SetShowEquipLevelToggle",
		},

        
		InfoShowToSystem = {
			type = "toggle",
			name = L["显示的信息在系统频道标题"],
			desc = L["显示的信息在系统频道描述"],
			order = 51,
			get = "GetInfoShowToSystemToggle",
			set = "SetInfoShowToSystemToggle",
		},
		

		ShowIntervalTime = {
			type = "range",
			name = L["提示间隔标题"],
			desc = L["提示间隔描述"],
			order = 52,
			get = "GetShowIntervalTime",
			set = "SetShowIntervalTime",
			min = 0,
			max = 600,
			softMin = 0,
			softMax = 600,
			step = 10,
			width = 2,
		},


		SendSelfInfoTitle = {
			type = "description",
            name = string.format(" |cfffff000%s|r  ",L["自己信息私聊发送提示"]),
			fontSize = "medium",
			order = 57,
		},

		SendSelfInfoInput = {
			type = "input",
            name =  L["发送自己信息标题"],
            desc =  L["发送自己信息描述"],
            usage =  L["发送自己信息用法"],
			multiline  = false,
			pattern  = "",
			set = "SetSendSelfInfoInput",
			get = "GetSendSelfInfoInput",
			order = 59,
		},

		SendSelfInfoTitle2 = {
			type = "description",
            name = " ",
			fontSize = "medium",
			order = 60,
		},

		SendSelfInfoEventWhisper = {
			type = "toggle",
			name = L["自己信息私聊发送标题"],
			desc = L["自己信息私聊发送描述"],
			order = 61,
			get = "GetSendSelfInfoEventWhisperToggle",
			set = "SetSendSelfInfoEventWhisperToggle",
		},

		
		SendSelfInfoEventParty = {
			type = "toggle",
			name = L["自己信息队伍发送标题"],
			desc = L["自己信息队伍发送描述"],
			order = 62,
			get = "GetSendSelfInfoEventPartyToggle",
			set = "SetSendSelfInfoEventPartyToggle",
		},

		
		SendSelfInfoEventRaid = {
			type = "toggle",
			name = L["自己信息团队发送标题"],
			desc = L["自己信息团队发送描述"],
			order = 63,
			get = "GetSendSelfInfoEventRaidToggle",
			set = "SetSendSelfInfoEventRaidToggle",
		},

		
		SendSelfInfoEventGuild = {
			type = "toggle",
			name = L["自己信息公会发送标题"],
			desc = L["自己信息公会发送描述"],
			order = 64,
			get = "GetSendSelfInfoEventGuildToggle",
			set = "SetSendSelfInfoEventGuildToggle",
		},

		ReplyMsgTitle = {
			type = "description",
            name = string.format(" |cfffff000%s|r  ",L["快速回复提示"]),
			fontSize = "medium",
			order = 70,
		},

		ReplyMsg1 = {
			type = "input",
            name =  L["快速回复标题"] .. 1,
            desc =  L["快速回复描述"],
            usage =  L["快速回复用法"],
			multiline  = false,
			pattern  = "",
			set = "SetReplyMsg1Input",
			get = "GetReplyMsg1Input",
			order = 71,
		},

		ReplyMsg2 = {
			type = "input",
            name =  L["快速回复标题"] .. 2,
            desc =  L["快速回复描述"],
            usage =  L["快速回复用法"],
			multiline  = false,
			pattern  = "",
			set = "SetReplyMsg2Input",
			get = "GetReplyMsg2Input",
			order = 72,
		},

		ReplyMsg3 = {
			type = "input",
            name =  L["快速回复标题"] .. 3,
            desc =  L["快速回复描述"],
            usage =  L["快速回复用法"],
			multiline  = false,
			pattern  = "",
			set = "SetReplyMsg3Input",
			get = "GetReplyMsg3Input",
			order = 73,
		},

		ReplyMsg4 = {
			type = "input",
            name =  L["快速回复标题"] .. 4,
            desc =  L["快速回复描述"],
            usage =  L["快速回复用法"],
			multiline  = false,
			pattern  = "",
			set = "SetReplyMsg4Input",
			get = "GetReplyMsg4Input",
			order = 74,
		},

		ReplyMsg5 = {
			type = "input",
            name =  L["快速回复标题"] .. 5,
            desc =  L["快速回复描述"],
            usage =  L["快速回复用法"],
			multiline  = false,
			pattern  = "",
			set = "SetReplyMsg5Input",
			get = "GetReplyMsg5Input",
			order = 75,
		},

		ReplyMsg6 = {
			type = "input",
            name =  L["快速回复标题"] .. 6,
            desc =  L["快速回复描述"],
            usage =  L["快速回复用法"],
			multiline  = false,
			pattern  = "",
			set = "SetReplyMsg6Input",
			get = "GetReplyMsg6Input",
			order = 76,
		},

	},
};


SenderInfo.optionDefaults = {
	global = {
        Open = true,
		Push = true,
		DetailTalent = false,
		ShowLevel = true,
		ShowClassColour = true,
		ShowEquipLevel = true,
		ShowGS = true,
		ShowWCL = true,
		InfoShowToSystem = true,
		ShowIntervalTime = 60,
		SendSelfInfo = true,
		SendSelfInfoEventWhisper = true,
		SendSelfInfoEventParty = false,
		SendSelfInfoEventRaid = false,
		SendSelfInfoEventGuild = false,
		SendSelfInfoInput = "1",
		OpenTeamHelper = true,
		TeamHelperViewWidth = 1000,
		AutoOpenHelperTime = 0,
		JoinGroupNotify = true,
		LeaderNotify = false,
		SeekTeamOpen = true,
		LeaderOpenHelper = true,

		ReplyMsg1 = "满了",
		ReplyMsg2 = "需要其他职业",
		ReplyMsg3 = "需要其他职责",
		ReplyMsg4 = "",
		ReplyMsg5 = "",
		ReplyMsg6 = "",
		
	},
};

local function PintBool(value,title)
	print(string.format("%s: %s",title or "",value and "True" or "False"))
end


local function ChangeShowHeader(info)

	if not __private.Load.Prepare and info == nil then
        return;
    end

    local txt = "";

	if SenderInfo.db.global.DetailTalent then
		if SenderInfo.db.global.ShowLevel then
			txt = txt .. L["天赋提示预览1"]
		else
			txt = txt .. L["天赋提示预览3"]
		end
	else
		if SenderInfo.db.global.ShowLevel then
			txt = txt .. L["天赋提示预览2"]
		else
			txt = txt .. L["天赋提示预览4"]
		end
	end

	if SenderInfo.db.global.ShowClassColour then
		txt = string.format(L["职业颜色2"],txt)	
	else
		txt = string.format(L["职业颜色1"],txt)
	end

	if SenderInfo.db.global.ShowWCL then
		txt = txt .. L["WCL显示"]
	end
	
	if SenderInfo.db.global.ShowGS then
		txt = txt .. L["GS显示"]
	end
	
	if SenderInfo.db.global.ShowEquipLevel then
		txt = txt .. L["平均装等显示"]
	end


	if SenderInfo.db.global.Push and (not SenderInfo.db.global.InfoShowToSystem) then
		txt = txt .. L["推广后缀"]
	end

    SenderInfo.options.args.ShowHeader.name = string.format("|CffDEDE42%s|r\n\n   %s \n\n",L["预览"], (info or txt));
end


function SenderInfo:SetTextToggle(info, value)
	self.db.global.TextToggle = value;
    ChangeShowHeader();
end

function SenderInfo:GetTextToggle(info)
	return self.db.global.TextToggle;
end


--------- Open ------------

function SenderInfo:SetOpenToggle(info, value)
	self.db.global.Open = value;
	local hint = Main:ChangeOpen(value);
	__private.InviteTeamView:ChangeOpenTeamHelper(self:GetOpenTeamHelperToggle());
	ChangeShowHeader(hint);
    self.db.global.Open = hint and false or value;
end

function SenderInfo:GetOpenToggle(info)
	return self.db.global.Open;
end

--------- Open ------------

--快捷开关
SLASH_SINFOP1 = "/sinfop";
SlashCmdList["SINFOP"]= function ()
	local open = SenderInfo.db.global.Open;
	SenderInfo:SetOpenToggle(nil,not open);
end;


--------- Push ------------

function SenderInfo:SetPushToggle(info, value)
	self.db.global.Push = value;
	Main:ChangePush(value);
	ChangeShowHeader();
end

function SenderInfo:GetPushToggle(info)
	return self.db.global.Push;
end

--------- Push ------------


--------- DetailTalent ------------

function SenderInfo:SetDetailTalentToggle(info, value)
	self.db.global.DetailTalent = value;
	Main:ChangeDetailTalent(value);
	ChangeShowHeader();
end

function SenderInfo:GetDetailTalentToggle(info)
	return self.db.global.DetailTalent;
end

--------- DetailTalent ------------


--------- ShowLevel ------------

function SenderInfo:SetShowLevelToggle(info, value)
	self.db.global.ShowLevel = value;
	Main:ChangeShowLevel(value);
	ChangeShowHeader();
end

function SenderInfo:GetShowLevelToggle(info)
	return self.db.global.ShowLevel;
end

--------- ShowLevel ------------


--------- ShowClassColour ------------

function SenderInfo:SetShowClassColourToggle(info, value)
	self.db.global.ShowClassColour = value;
	Main:ChangeShowClassColour(value);
	ChangeShowHeader();
end

function SenderInfo:GetShowClassColourToggle(info)
	return self.db.global.ShowClassColour;
end

--------- ShowClassColour ------------



--------- ShowEquipLevel ------------

function SenderInfo:SetShowEquipLevelToggle(info, value)
	self.db.global.ShowEquipLevel = value;
	Main:ChangeShowEquipLevel(value);
	ChangeShowHeader();
end

function SenderInfo:GetShowEquipLevelToggle(info)
	return self.db.global.ShowEquipLevel;
end

--------- ShowEquipLevel ------------


--------- InfoShowToSystem ------------

function SenderInfo:SetInfoShowToSystemToggle(info, value)
	self.db.global.InfoShowToSystem = value;
	Main:ChangeInfoShowToSystem(value);
	ChangeShowHeader();
end

function SenderInfo:GetInfoShowToSystemToggle(info)
	return self.db.global.InfoShowToSystem;
end

--------- InfoShowToSystem ------------


--------- ShowGS ------------

function SenderInfo:SetShowGSToggle(info, value)
	self.db.global.ShowGS = value;
	Main:ChangeShowGS(value);
	ChangeShowHeader();
end

function SenderInfo:GetShowGSToggle(info)
	return self.db.global.ShowGS;
end

--------- ShowGS ------------


--------- ShowWCL ------------

function SenderInfo:SetShowWCLToggle(info, value)
	self.db.global.ShowWCL = value;
	Main:ChangeShowWCL(value);
	ChangeShowHeader();
end

function SenderInfo:GetShowWCLToggle(info)
	return self.db.global.ShowWCL;
end

--------- ShowWCL ------------



--------- ShowIntervalTime ------------

function SenderInfo:SetShowIntervalTime(info, value)
	self.db.global.ShowIntervalTime = value;
	Main:ChangeShowIntervalTime(value);
end

function SenderInfo:GetShowIntervalTime(info)
	return self.db.global.ShowIntervalTime;
end

--------- ShowIntervalTime ------------


--------- SendSelfInfoEvent ------------

function SenderInfo:SetSendSelfInfoEventWhisperToggle(info, value)
	self.db.global.SendSelfInfoEventWhisper = value;
	Main:ChangeSendSelfInfoEventWhisper(value);
end

function SenderInfo:GetSendSelfInfoEventWhisperToggle(info)
	return self.db.global.SendSelfInfoEventWhisper;
end

function SenderInfo:SetSendSelfInfoEventPartyToggle(info, value)
	self.db.global.SendSelfInfoEventParty = value;
	Main:ChangeSendSelfInfoEventParty(value);
end

function SenderInfo:GetSendSelfInfoEventPartyToggle(info)
	return self.db.global.SendSelfInfoEventParty;
end


function SenderInfo:SetSendSelfInfoEventRaidToggle(info, value)
	self.db.global.SendSelfInfoEventRaid = value;
	Main:ChangeSendSelfInfoEventRaid(value);
end

function SenderInfo:GetSendSelfInfoEventRaidToggle(info)
	return self.db.global.SendSelfInfoEventRaid;
end


function SenderInfo:SetSendSelfInfoEventGuildToggle(info, value)
	self.db.global.SendSelfInfoEventGuild = value;
	Main:ChangeSendSelfInfoEventGuild(value);
end

function SenderInfo:GetSendSelfInfoEventGuildToggle(info)
	return self.db.global.SendSelfInfoEventGuild;
end


function SenderInfo:SetSendSelfInfoInput(info, value)
	self.db.global.SendSelfInfoInput = value;
	Main:ChangeSendSelfInfoCondition(value);
end

function SenderInfo:GetSendSelfInfoInput(info)
	return self.db.global.SendSelfInfoInput;
end

--------- SendSelfInfoEvent ------------



--------- SendSelfInfo ------------

function SenderInfo:SetSendSelfInfoToggle(info, value)
	self.db.global.SendSelfInfo = value;
	Main:ChangeSendSelfInfo(value);
end

function SenderInfo:GetSendSelfInfoToggle(info)
	return self.db.global.SendSelfInfo;
end

--------- SendSelfInfo ------------



--------- OpenTeamHelper ------------

function SenderInfo:SetOpenTeamHelperToggle(info, value)
	self.db.global.OpenTeamHelper = value;
	__private.InviteTeamView:ChangeOpenTeamHelper(value);
end

function SenderInfo:GetOpenTeamHelperToggle(info)
	return self.db.global.OpenTeamHelper;
end

--------- OpenTeamHelper ------------



--------- TeamHelperViewWidth ------------

function SenderInfo:SetTeamHelperViewWidth(info, value)
	self.db.global.TeamHelperViewWidth = value;
	__private.InviteTeamView:ChangeViewWidth(value)
end

function SenderInfo:GetTeamHelperViewWidth(info)
	return self.db.global.TeamHelperViewWidth;
end

--------- TeamHelperViewWidth ------------


--------- AutoOpenHelperTime ------------

function SenderInfo:SetAutoOpenHelperTime(info, value)
	self.db.global.AutoOpenHelperTime = value;
	__private.InviteTeamView:ChangeAutoOpenHelperTime(value)
end

function SenderInfo:GetAutoOpenHelperTime(info)
	return self.db.global.AutoOpenHelperTime;
end

--------- AutoOpenHelperTime ------------



--------- JoinGroupNotify ------------

function SenderInfo:SetJoinGroupNotifyToggle(info, value)
	self.db.global.JoinGroupNotify = value;
	__private.Main:ChangeJoinGroupNotify(value);
end

function SenderInfo:GetJoinGroupNotifyToggle(info)
	return self.db.global.JoinGroupNotify;
end

--------- JoinGroupNotify ------------

--------- LeaderNotify ------------

function SenderInfo:SetLeaderNotifyToggle(info, value)
	self.db.global.LeaderNotify = value;
	__private.Main:ChangeLeaderNotify(value);
end

function SenderInfo:GetLeaderNotifyToggle(info)
	return self.db.global.LeaderNotify;
end

--------- LeaderNotify ------------



--------- SeekTeamOpen ------------

function SenderInfo:SetSeekTeamOpenToggle(info, value)
	self.db.global.SeekTeamOpen = value;
	__private.InviteTeamView:ChangeSeekTeamOpen(value);
end

function SenderInfo:GetSeekTeamOpenToggle(info)
	return self.db.global.SeekTeamOpen;
end


function SenderInfo:SetLeaderOpenHelperToggle(info, value)
	self.db.global.LeaderOpenHelper = value;
	__private.InviteTeamView:ChangeLeaderOpenHelper(value);
end

function SenderInfo:GetLeaderOpenHelperToggle(info)
	return self.db.global.LeaderOpenHelper;
end




--------- SeekTeamOpen ------------

--------- ReplyMsg ------------

function SenderInfo:SetReplyMsg1Input(info, value)
	self.db.global.ReplyMsg1 = value;
	__private.InviteTeamView:ChangeReplyMsg1(value);
end

function SenderInfo:GetReplyMsg1Input(info)
	return self.db.global.ReplyMsg1;
end

function SenderInfo:SetReplyMsg2Input(info, value)
	self.db.global.ReplyMsg2 = value;
	__private.InviteTeamView:ChangeReplyMsg2(value);
end

function SenderInfo:GetReplyMsg2Input(info)
	return self.db.global.ReplyMsg2;
end

function SenderInfo:SetReplyMsg3Input(info, value)
	self.db.global.ReplyMsg3 = value;
	__private.InviteTeamView:ChangeReplyMsg3(value);
end

function SenderInfo:GetReplyMsg3Input(info)
	return self.db.global.ReplyMsg3;
end

function SenderInfo:SetReplyMsg4Input(info, value)
	self.db.global.ReplyMsg4 = value;
	__private.InviteTeamView:ChangeReplyMsg4(value);
end

function SenderInfo:GetReplyMsg4Input(info)
	return self.db.global.ReplyMsg4;
end

function SenderInfo:SetReplyMsg5Input(info, value)
	self.db.global.ReplyMsg5 = value;
	__private.InviteTeamView:ChangeReplyMsg5(value);
end

function SenderInfo:GetReplyMsg5Input(info)
	return self.db.global.ReplyMsg5;
end

function SenderInfo:SetReplyMsg6Input(info, value)
	self.db.global.ReplyMsg6 = value;
	__private.InviteTeamView:ChangeReplyMsg6(value);
end

function SenderInfo:GetReplyMsg6Input(info)
	return self.db.global.ReplyMsg6;
end


--------- ReplyMsg ------------

function SenderInfo:ExecuteOpenHelper(info)
	__private.InviteTeamView:SwichViewHelper();
end


function SenderInfo:ExecuteResetHelperViewPos(info)
	__private.InviteTeamView:ResetHelperViewPos();
end


function View:Init()

    Main = __private.Main;
	
    View.Cfg = SenderInfo.db.global;

	SenderInfo:SetOpenToggle(nil,SenderInfo.db.global.Open);
end 


