--版本控制：2.1.2 取消记录功能

local AddonName, Addon = ...

local Frame = Addon.Frame --Frame
local Warning = Addon.Warning -- WarningFrame
local L = Addon.L --Localization

--Config Setting
local Config = Addon.Config --Config
--固定表
local MissReason = Addon.MissReason
local FailReason = Addon.FailReason
local RaidIconList = Addon.RaidIconList
--SpellList
local RunTime = Addon.RunTime
--输出界面
local Output = Addon.Output
--版本检查
local VersionTable = {}

--本地化函数(提升运行效率)
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local SendChatMessage = SendChatMessage
local UnitIsGroupLeader = UnitIsGroupLeader
local UnitIsGroupAssistant = UnitIsGroupAssistant
local UnitIsPlayer = UnitIsPlayer
local UnitIsFriend = UnitIsFriend
local UnitIsEnemy = UnitIsEnemy
local UnitExists = UnitExists
local UnitIsUnit = UnitIsUnit
local UnitInBattleground = UnitInBattleground
local UnitName = UnitName
local GetUnitName = GetUnitName
local GetSpellLink = GetSpellLink
local UnitGUID = UnitGUID
local UnitDebuff = UnitDebuff
local CheckInteractDistance = CheckInteractDistance
local UnitIsConnected = UnitIsConnected
local UnitAffectingCombat = UnitAffectingCombat
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local UnitClassification = UnitClassification
local UnitInRaid = UnitInRaid
-- local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local GetNumGroupMembers = GetNumGroupMembers
local GetRaidTargetIndex = GetRaidTargetIndex
local GetMinimapZoneText = GetMinimapZoneText
local IsInGroup = IsInGroup
local IsInRaid = IsInRaid
local IsInGuild = IsInGuild
local IsInInstance = IsInInstance
local GetTime = GetTime
local FollowUnit = FollowUnit
local pairs = pairs
local print = print
local t_insert = table.insert
local t_remove = table.remove
local ChatEdit_SendText = ChatEdit_SendText
local ChatFrame10 = ChatFrame10
--Addon_MSG方法
local SendAddonMessage = C_ChatInfo.SendAddonMessage
local IsAddonMessagePrefixRegistered = C_ChatInfo.IsAddonMessagePrefixRegistered
local RegisterAddonMessagePrefix = C_ChatInfo.RegisterAddonMessagePrefix
--GUID
local PlayerGUID = UnitGUID("player")
local TargetGUID = nil --周边Target GUID
--延时过滤表
local OutputCache = {}
--发言Rank
local AnnounceTable = {}
--延时任务
local TaskTable = {}
--破控信息控制
local BreakTable = {}
--仇恨目标信息
local ThreatList = {}

--公共方法：
--读取/保存SpellWhisperDB
function Addon:UpdateTable(Target, Source)
	for k, v in pairs(Source) do
		if type(v) == "table" then
			if type(Target[k]) == "table" then
				self:UpdateTable(Target[k], v)
			else
				Target[k] = self:UpdateTable({}, v)
			end
		elseif type(Target[k]) ~= "table" then
			Target[k] = v
		end
	end
	return Target
end
--获取数据表大小
function Addon:GetTableSize(SourceTable)
	local Num = 0
	for k in pairs(SourceTable) do
		Num = Num + 1
	end
	return Num
end
--格式化信息
function Addon:FormatMessage(msg, args)
	if msg then
		for k, v in pairs(args) do
			msg = string.gsub(msg, k, v)
		end
	end
	return msg
end
--新建延时任务
function Addon:NewTask(Delay, Task)
	local TimeStamp = math.floor(GetTime() * 1000)
	--补全slash
	if Task:sub(1, 1) ~= "/" then
		Task = "/" .. Task
	end
	local CacheTable = {}
	CacheTable["TimeStamp"] = TimeStamp
	CacheTable["Delay"] = Delay
	CacheTable["Task"] = Task
	for k in pairs(TaskTable) do
		if CacheTable["TimeStamp"] - TaskTable[k]["TimeStamp"] <= 2000 and CacheTable["Delay"] == TaskTable[k]["Delay"] and CacheTable["Task"] == TaskTable[k]["Task"] then
			return
		end
	end
	t_insert(TaskTable, CacheTable)
	Addon.HasTask = true
	if not Frame:IsShown() then
		Frame:Show()
	end
	if Config.DelayTips then
		print(string.format(L["|cFFBA55D3SpellWhisper|r Delay Command: |cFFCCA4E3%d|r [seconds] later do |cFFCCA4E3[%s]|r Task."], CacheTable["Delay"], CacheTable["Task"]))
	end
end
--执行Command
function Addon:RunTask(Task)
	if Task then
		ChatFrame10.editBox:SetText(Task)
		ChatEdit_SendText(ChatFrame10.editBox)
		ChatFrame10.editBox:SetText("")
	end
end
--测试当前的GUID是否为团队成员，并返回团队/小队代码（raidX，partyX, raidXtarget, partyXtarget, etc)
function Addon:GetTargetUnit(TestGUID)
	if TestGUID then
		if TestGUID == PlayerGUID then
			return "player", "player"
		elseif TestGUID == UnitGUID("playerpet") then
			return "pet", "playerpet"
		else
			if IsInRaid() then
				for i = 1, GetNumGroupMembers() do
					local u = "raid" .. i
					if UnitGUID(u) == TestGUID then
						return "group", u
					end
				end
				for i = 1, GetNumGroupMembers() do
					local u = "raid" .. i .. "pet"
					if UnitGUID(u) == TestGUID then
						return "pet", u
					end
				end
				for i = 1, GetNumGroupMembers() do
					local u = "raid" .. i .. "target"
					if UnitGUID(u) == TestGUID then
						return "target", u
					end
				end
			elseif IsInGroup() then
				for i = 1, GetNumGroupMembers() do
					local u = "party" .. i
					if UnitGUID(u) == TestGUID then
						return "group", u
					end
				end
				for i = 1, GetNumGroupMembers() do
					local u = "party" .. i .. "pet"
					if UnitGUID(u) == TestGUID then
						return "pet", u
					end
				end
				for i = 1, GetNumGroupMembers() do
					local u = "party" .. i .. "target"
					if UnitGUID(u) == TestGUID then
						return "target", u
					end
				end
			end
		end
		if TestGUID == UnitGUID("playertarget") then
			return "target", "playertarget"
		end
	else
		return nil, nil
	end
end
--根据名字获取raid团队编号
function Addon:GetRaidIndex(TargetName)
	if IsInRaid() then
		for i = 1, 40 do
			local u = "raid" .. i
			if (UnitName(u)) and (UnitName(u)) == TargetName then
				return i
			end
		end
		return nil
	end
	return nil
end
--获取不含服务器名称的角色名
function Addon:GetShortName(SourceName)
	if SourceName then
		return SourceName:match("^(%S*)%-") or SourceName
	else
		return nil
	end
end
--更新发言顺位
function Addon:SendAnnounceRank(Seed) --发送自身Rank
	if UnitIsGroupLeader("player") then
		if IsInRaid() then
			SendAddonMessage(Addon.PrefixSW, "80000", "raid")
		elseif IsInGroup() then
			SendAddonMessage(Addon.PrefixSW, "80000", "party")
		end
	elseif IsInRaid() and UnitIsGroupAssistant("player") then
		SendAddonMessage(Addon.PrefixSW, tostring(40000 + Seed * 1000), "raid")
	elseif IsInRaid() then
		SendAddonMessage(Addon.PrefixSW, tostring(Seed * 1000), "raid")
	elseif IsInGroup() then
		SendAddonMessage(Addon.PrefixSW, tostring(math.random(1000, 40000)), "party")
	end
end
--删除不在队伍的成员信息
function Addon:DeleteVanishMember()
	local IsStillGroupMember = false
	if IsInRaid() then
		for k in pairs(AnnounceTable) do --遍历当前的AnnounceTable，清理已不在团队的成员Rank
			IsStillGroupMember = false
			for i = 1, GetNumGroupMembers() do
				local u = "raid" .. i
				if k == (UnitName(u)) then
					IsStillGroupMember = true
					break
				end
			end
			if not IsStillGroupMember then
				AnnounceTable[k] = nil
			end
		end
	elseif IsInGroup() then
		for k in pairs(AnnounceTable) do --遍历当前的AnnounceTable，清理已不在队伍的成员Rank
			if k == (UnitName("player")) then
				IsStillGroupMember = true
			else
				IsStillGroupMember = false
				for i = 1, GetNumGroupMembers() do
					local u = "party" .. i
					if k == (UnitName(u)) then
						IsStillGroupMember = true
						break
					end
				end
			end
			if not IsStillGroupMember then
				AnnounceTable[k] = nil
			end
		end
	else
		for k in pairs(AnnounceTable) do
			AnnounceTable[k] = nil
		end
	end
end
--比较发言顺序，返回是否允许发言bool值
function Addon:IsPlayerMuted()
	local Max = 0
	if IsInRaid() then
		for k in pairs(AnnounceTable) do
			local i = UnitInRaid(k)
			if i then
				if UnitIsConnected("raid" .. i) then
					if Max < AnnounceTable[k] then
						Max = AnnounceTable[k]
					end
				end
			end
		end
		if AnnounceTable[(UnitName("player"))] == Max then
			return false
		else
			return true
		end
	elseif IsInGroup() then
		for k in pairs(AnnounceTable) do
			if Max < AnnounceTable[k] then
				Max = AnnounceTable[k]
			end
		end
		if AnnounceTable[(UnitName("player"))] == Max then
			return false
		else
			return true
		end
	end
	return true
end

--跟随函数
function Addon:FollowTargetUnit(FollowUnitGUID, WhisperText)
	local t, u = Addon:GetTargetUnit(FollowUnitGUID) -- 根据密语对象GUID判断是否为团队/小队成员
	if t == "group" then
		if Config.StartFollow ~= "" and WhisperText == Config.StartFollow then --跟随
			if not CheckInteractDistance(u, 4) then
				if Addon.Followed.FromWhisper then
					SendChatMessage(L["SPELLWHISPER_TEXT_FOLLOWFAILED_OUTOFRANGE"], "whisper", nil, GetUnitName(u, true))
				end
			else
				FollowUnit(u)
				Addon.Followed.UnitIndex = u
				Addon.Followed.GUID = FollowUnitGUID
				Addon.Followed.StartTime = GetTime()
				if Addon.Followed.FromWhisper then
					SendChatMessage(L["SPELLWHISPER_TEXT_FOLLOWREPLY"], "whisper", nil, GetUnitName(u, true))
				end
			end
		elseif Config.StopFollow ~= "" and WhisperText == Config.StopFollow then --停止跟随
			FollowUnit("player")
			Addon.Followed.UnitIndex = "player"
			Addon.Followed.GUID = ""
			SendChatMessage(L["SPELLWHISPER_TEXT_STOPFOLLOWREPLY"], "whisper", nil, GetUnitName(u, true))
		elseif Config.CombatFollowSwitchKey ~= "" and WhisperText == Config.CombatFollowSwitchKey then
			if Config.CombatFollow then
				Config.CombatFollow = false
				SendChatMessage(L["SPELLWHISPER_TEXT_CHANGEFOLLOWMODEOFF"], "whisper", nil, GetUnitName(u, true))
			else
				Config.CombatFollow = true
				SendChatMessage(L["SPELLWHISPER_TEXT_CHANGEFOLLOWMODEON"], "whisper", nil, GetUnitName(u, true))
			end
			Addon.ScrollFrame:ConfigRefresh()
		end
	end
end

--发送版本检查通知
function Addon:SendVerCheck()
	if not Config.IsEnable then
		print(L["<|cFFBA55D3SW|r>Please Enable |cFFBA55D3SpellWhisper|r First."])
		return
	end
	VersionTable = {}
	-- if UnitInBattleground("player") then -- 战场禁用
	-- 	print(L["<|cFFBA55D3SW|r>Can't Check |cFFBA55D3SpellWhisper|r Version In Battleground."])
    --     return
    -- end
	if IsInRaid() then
		SendAddonMessage(Addon.PrefixSW, "99999", "raid")
		print(L["<|cFFBA55D3SW|r>Start Check Team Member's |cFFBA55D3SpellWhisper|r Version."])
	elseif IsInGroup() then
		SendAddonMessage(Addon.PrefixSW, "99999", "party")
		print(L["<|cFFBA55D3SW|r>Start Check Team Member's |cFFBA55D3SpellWhisper|r Version."])
	else
		print(L["<|cFFBA55D3SW|r>Don't Have Any Team Member(s)."])
	end
end

-- 显示版本检查结果
function Addon:DisplayVersion()
	if not Config.IsEnable then
		print(L["<|cFFBA55D3SW|r>Please Enable |cFFBA55D3SpellWhisper|r First."])
		return
	end
	if not IsInGroup() then
		print(L["<|cFFBA55D3SW|r>Don't Have Any Team Member(s)."])
	else
		Output.title:SetText(L["Version Check"])
		Output.background:Show()
		Output.export:GetParent():Show()
		local Max = 0
		for k in pairs(AnnounceTable) do
			if Max < AnnounceTable[k] then
				Max = AnnounceTable[k]
			end
		end
		local msg = ""
		for k, v in pairs(VersionTable) do
			local Ver1 = math.floor(v / 100)
			local Ver2 = math.floor((v - Ver1 * 100) / 10)
			local Ver3 = v - Ver1 * 100 - Ver2 * 10
			if AnnounceTable[k] == Max then
				msg = msg .. string.format(L["[|cFFDC143C%s|r] (%d.%d.%d)"], k, Ver1, Ver2, Ver3) .. "\n"
			else
				msg = msg .. string.format(L["[%s] (%d.%d.%d)"], k, Ver1, Ver2, Ver3) .. "\n"
			end
		end
		Output.export:SetText(msg)
		Output.export:Disable()
	end
end

--处理仇恨列表
function Addon:AddToThreatList(MobUnit)
	local MobGUID = UnitGUID(MobUnit)
	local NowTime = math.floor(GetTime()*10)/10
	local IsExists = false
	if IsInRaid() then
		for i = #ThreatList, 1, -1 do
			if ThreatList[i].GUID == MobGUID then
				IsExists = true
				for j = 1, GetNumGroupMembers() do
					local RaidUnit = "raid" .. j
					local IsTanking, Status = UnitDetailedThreatSituation(RaidUnit, MobUnit)
					if IsTanking and Status == 3 and RaidUnit ~= ThreatList[i].TargetUnit and NowTime - ThreatList[i].Time >= 4 then
						ThreatList[i].TargetUnit = RaidUnit
						ThreatList[i].Time = NowTime
						local MobName = (UnitName(MobUnit))
						local TargetName = (UnitName(RaidUnit))
						local MobIconIndex = GetRaidTargetIndex(MobUnit) or 0
						local TargetIconIndex = GetRaidTargetIndex(RaidUnit) or 0
						Addon:SendThreatAnnounce(MobName, MobIconIndex, TargetName, TargetIconIndex)
					end
				end
				break
			end
		end
		if not IsExists then
			local TempThreat = {}
			TempThreat["GUID"] = MobGUID
			TempThreat["MobUnit"] = MobUnit
			TempThreat["Time"] = NowTime
			for j = 1, GetNumGroupMembers() do
				local RaidUnit = "raid" .. j
				local IsTanking, Status = UnitDetailedThreatSituation(RaidUnit, MobUnit)
				if IsTanking and Status == 3 then
					TempThreat["TargetUnit"] = RaidUnit
					local MobName = (UnitName(MobUnit))
					local TargetName = (UnitName(RaidUnit))
					local MobIconIndex = GetRaidTargetIndex(MobUnit) or 0
					local TargetIconIndex = GetRaidTargetIndex(RaidUnit) or 0
					Addon:SendThreatAnnounce(MobName, MobIconIndex, TargetName, TargetIconIndex)
				end
			end
			t_insert(ThreatList, TempThreat)
		end
	elseif IsInGroup() then
		for i = #ThreatList, 1, -1 do
			if ThreatList[i].GUID == MobGUID then
				IsExists = true
				do
					local IsTanking, Status = UnitDetailedThreatSituation("player", MobUnit)
					if IsTanking and Status == 3 and ThreatList[i].TargetUnit ~= "player" and NowTime - ThreatList[i].Time >= 4 then
						ThreatList[i].TargetUnit = "player"
						ThreatList[i].Time = NowTime
						local MobName = (UnitName(MobUnit))
						local TargetName = (UnitName("player"))
						local MobIconIndex = GetRaidTargetIndex(MobUnit) or 0
						local TargetIconIndex = GetRaidTargetIndex("player") or 0
						Addon:SendThreatAnnounce(MobName, MobIconIndex, TargetName, TargetIconIndex)
					end
				end
				for j = 1, GetNumGroupMembers() do
					local PartyUnit = "party" .. j
					local IsTanking, Status = UnitDetailedThreatSituation(PartyUnit, MobUnit)
					if IsTanking and Status == 3 and PartyUnit ~= ThreatList[i].TargetUnit and NowTime - ThreatList[i].Time >= 4 then
						ThreatList[i].TargetUnit = PartyUnit
						ThreatList[i].Time = NowTime
						local MobName = (UnitName(MobUnit))
						local TargetName = (UnitName(PartyUnit))
						local MobIconIndex = GetRaidTargetIndex(MobUnit) or 0
						local TargetIconIndex = GetRaidTargetIndex(PartyUnit) or 0
						Addon:SendThreatAnnounce(MobName, MobIconIndex, TargetName, TargetIconIndex)
					end
				end
			end
		end
		if not IsExists then
			local TempThreat = {}
			TempThreat["GUID"] = MobGUID
			TempThreat["MobUnit"] = MobUnit
			TempThreat["Time"] = NowTime
			do
				local IsTanking, Status = UnitDetailedThreatSituation("player", MobUnit)
				if IsTanking and Status == 3 and TempThreat.TargetUnit ~= "player" then
					TempThreat.TargetUnit = "player"
					local MobName = (UnitName(MobUnit))
					local TargetName = (UnitName("player"))
					local MobIconIndex = GetRaidTargetIndex(MobUnit) or 0
					local TargetIconIndex = GetRaidTargetIndex("player") or 0
					Addon:SendThreatAnnounce(MobName, MobIconIndex, TargetName, TargetIconIndex)
				end
			end
			for j = 1, GetNumGroupMembers() do
				local PartyUnit = "party" .. j
				local IsTanking, Status = UnitDetailedThreatSituation(PartyUnit, MobUnit)
				if IsTanking and Status == 3 then
					TempThreat["TargetUnit"] = PartyUnit
					local MobName = (UnitName(MobUnit))
					local TargetName = (UnitName(PartyUnit))
					local MobIconIndex = GetRaidTargetIndex(MobUnit) or 0
					local TargetIconIndex = GetRaidTargetIndex(PartyUnit) or 0
					Addon:SendThreatAnnounce(MobName, MobIconIndex, TargetName, TargetIconIndex)
				end
			end
			t_insert(ThreatList, TempThreat)
		end
	end
end

--输出信息比较方法
--处理OutputCache表
function Addon:AddOutputCache(NewMessage, TargetName)
	local IndexTime = math.floor(GetTime() * 1000)
	if TargetName then
		OutputCache[IndexTime] = NewMessage .. "+" .. TargetName
	else
		OutputCache[IndexTime] = NewMessage
	end
end
--比较信息是否重复，重复返回true，不重复则返回false
function Addon:CompareOutputCache(Message, TargetName)
	if Config.WaitTime == 0 then
		return false
	end
	if TargetName then
		Message = Message .. "+" .. TargetName
	end
	for k in pairs(OutputCache) do
		if OutputCache[k] then
			if Message == OutputCache[k] then
				return true
			end
		else
			return false
		end
	end
	return false
end

--信息报告方法
--治疗法术通告
function Addon:SendHealingMessage(SpellName, TargetName, FailedReason)
	if not Config.IsWhisperEnable or UnitInBattleground("player") then
		return
	end
	-- TargetName = Addon:GetShortName(TargetName)
	local msg = Addon:FormatMessage(
		Config["SpellOutput"]["SPELLWHISPER_TEXT_HEALINGFAILED"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_HEALINGFAILED"] or L["SPELLWHISPER_TEXT_HEALINGFAILED"],
		{
			["#spell#"] = SpellName,
			["#reason#"] = FailedReason,
		}
	)
	if not Addon:CompareOutputCache(msg, TargetName) and msg ~= L["NONE"] then
		SendChatMessage(msg, "whisper", nil, TargetName)
	end
end

--战场信息输出（专用）
function Addon:SendBGMessage(SpellName, CasterName, TargetName)
	if not Config.IsBGWarningEnable or Config.OutputChannel == "off" then
		return
	end
	local SubZoneName = GetMinimapZoneText()
	local msg = Addon:FormatMessage(
		Config["SpellOutput"]["SPELLWHISPER_TEXT_BGWARNING"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_BGWARNING"] or L["SPELLWHISPER_TEXT_BGWARNING"],
		{
			["#caster#"] = CasterName,
			["#spell#"] = SpellName,
			["#target#"] = TargetName,
			["#pos#"] = SubZoneName,
		}
	)
	if msg ~= L["NONE"] then
		SendChatMessage(msg, "instance_chat")
	end
end

--仇恨目标改变通告
function Addon:SendThreatAnnounce(MobName, MobIconIndex, TargetName, TargetIconIndex)
	if Config.OutputChannel == "off" or UnitInBattleground("player") then
		return
	end
	local channel = Config.OutputChannel
	if IsInRaid() and not (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) and channel == "raid_warning" then
		channel = "raid"
	elseif IsInGroup() and not IsInRaid() and (channel == "raid" or channel == "raid_warning") then
		channel = "party"
	end
	local msg = Addon:FormatMessage(
		Config["SpellOutput"]["SPELLWHISPER_TEXT_THREAT"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_THREAT"] or L["SPELLWHISPER_TEXT_THREAT"],
		{
			["#mob#"] = (MobIconIndex ~= 0 and RaidIconList[MobIconIndex] or "") .. MobName,
			["#target#"] = (TargetIconIndex ~= 0 and RaidIconList[TargetIconIndex] or "") .. TargetName,
		}
	)
	if msg ~= L["NONE"] then
		if channel == "hud" then
			Warning:AddMessage(msg)
		elseif channel == "self" then
			print("|cFFFF143C"..msg.."|r")
		elseif not Addon:IsPlayerMuted() then
			SendChatMessage(msg, channel)
		end
	end
end
--CC/Interrupt/missed通告，OtherInfo可以是被打破的控制技能、被打断的法术或者Miss原因
function Addon:SendWarningMessage(WarningType, CasterName, SpellName, TargetName, OtherInfo, TargetIconIndex, TargetUnitGUID)
	if Config.OutputChannel == "off" then
		return
	end
	if Config.SelfOnly and CasterName ~= (UnitName("player")) then
		return
	end
	local channel = Config.OutputChannel
	if IsInRaid() and not (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) and channel == "raid_warning" then
		channel = "raid"
	elseif IsInGroup() and not IsInRaid() and (channel == "raid" or channel == "raid_warning") then
		channel = "party"
	end
	local msg = nil --待输出内容
	if WarningType == "BROKEN" then --破控
		if BreakTable[TargetUnitGUID] then
			if GetTime() - BreakTable[TargetUnitGUID] < Config.BreakTime then
				return
			end
		end
		msg = Addon:FormatMessage(
			Config["SpellOutput"]["SPELLWHISPER_TEXT_BROKEN"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_BROKEN"] or L["SPELLWHISPER_TEXT_BROKEN"],
			{
				["#caster#"] = CasterName,
				["#spell#"] = SpellName,
				["#target#"] = (TargetIconIndex ~= 0 and RaidIconList[TargetIconIndex] or "") .. TargetName,
				["#spell_2#"] = OtherInfo,
			}
		)
		BreakTable[TargetUnitGUID] = math.floor(GetTime()*10)/10
	elseif WarningType == "INTERRUPT" then --打断
		msg = Addon:FormatMessage(
			Config["SpellOutput"]["SPELLWHISPER_TEXT_INTERRUPT"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_INTERRUPT"] or L["SPELLWHISPER_TEXT_INTERRUPT"],
			{
				["#caster#"] = CasterName,
				["#spell#"] = SpellName,
				["#target#"] = (TargetIconIndex ~= 0 and RaidIconList[TargetIconIndex] or "") .. TargetName,
				["#spell_2#"] = OtherInfo,
			}
		)
	elseif WarningType == "STOLEN" then --打断
		msg = Addon:FormatMessage(
			Config["SpellOutput"]["SPELLWHISPER_TEXT_STOLEN"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_STOLEN"] or L["SPELLWHISPER_TEXT_STOLEN"],
			{
				["#caster#"] = CasterName,
				["#spell#"] = SpellName,
				["#target#"] = (TargetIconIndex ~= 0 and RaidIconList[TargetIconIndex] or "") .. TargetName,
			}
		)
	elseif WarningType == "MISSED" then --抵抗/失误
		msg = Addon:FormatMessage(
			Config["SpellOutput"]["SPELLWHISPER_TEXT_MISSED"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_MISSED"] or L["SPELLWHISPER_TEXT_MISSED"],
			{
				["#caster#"] = CasterName,
				["#spell#"] = SpellName,
				["#target#"] = (TargetIconIndex ~= 0 and RaidIconList[TargetIconIndex] or "") .. TargetName,
				["#reason#"] = OtherInfo,
			}
		)
	elseif WarningType == "DISPEL" then --驱散
		msg = Addon:FormatMessage(
			Config["SpellOutput"]["SPELLWHISPER_TEXT_DISPEL"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_DISPEL"] or L["SPELLWHISPER_TEXT_DISPEL"],
			{
				["#caster#"] = CasterName,
				["#spell#"] = SpellName,
				["#target#"] = (TargetIconIndex ~= 0 and RaidIconList[TargetIconIndex] or "") .. TargetName,
				["#spell_2#"] = OtherInfo,
			}
		)
	elseif WarningType == "REFLECT" then --反射
		msg = Addon:FormatMessage(
			Config["SpellOutput"]["SPELLWHISPER_TEXT_REFLECT"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_REFLECT"] or L["SPELLWHISPER_TEXT_REFLECT"],
			{
				["#caster#"] = CasterName,
				["#spell#"] = SpellName,
				["#target"] = (TargetIconIndex ~= 0 and RaidIconList[TargetIconIndex] or "") .. TargetName,
			}
		)
	end
	if not Addon:CompareOutputCache(msg) and msg ~= L["NONE"] then
		if channel == "hud" then
			Warning:AddMessage(msg)
		elseif channel == "self" then
			print("|cFFFF143C"..msg.."|r")
		elseif not Addon:IsPlayerMuted() then
			if (channel == "raid" or channel == "raid_warning") and UnitInBattleground("player") then
				channel = "instance_chat"
			end
			SendChatMessage(msg, channel)
		end
	end
end
--施法相关通告（开始、成功）
function Addon:SendAnnounceMessage(AnnounceChannel, AnnounceReason, AnnounceType, SpellName, TargetName, TargetIconIndex)
	local channel = Config.OutputChannel
	if IsInRaid() and not (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) and channel == "raid_warning" then
		channel = "raid"
	elseif IsInGroup() and not IsInRaid() and (channel == "raid" or channel == "raid_warning") then
		channel = "party"
	end
	local msg = nil --待输出内容
	if AnnounceChannel == "group" and AnnounceReason == "start" then --开始施法通告，有益/有害共用
		msg = Addon:FormatMessage(
			Config["SpellOutput"]["SPELLWHISPER_TEXT_SENTTOGROUPSTART"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_SENTTOGROUPSTART"] or L["SPELLWHISPER_TEXT_SENTTOGROUPSTART"],
			{
				["#spell#"] = SpellName,
				["#target#"] = (TargetIconIndex ~= 0 and RaidIconList[TargetIconIndex] or "") .. TargetName
			}
		)

		if not Addon:CompareOutputCache(msg) and msg ~= L["NONE"] then
			if channel == "off" then
				return
			elseif channel == "hud" then
				Addon.Warning:AddMessage(msg)
			elseif channel == "self" then
				print("|cFFFF143C"..msg.."|r")
			else
				if channel == "raid" and UnitInBattleground("player") then
					channel = "instance_chat"
				end
				SendChatMessage(msg, channel)
			end
		end
	elseif AnnounceChannel == "group" and AnnounceReason == "done" then --完成施法通告，有益/有害共用
		msg = Addon:FormatMessage(
			Config["SpellOutput"]["SPELLWHISPER_TEXT_SENTTOGROUPDONE"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_SENTTOGROUPDONE"] or L["SPELLWHISPER_TEXT_SENTTOGROUPDONE"],
			{
				["#spell#"] = SpellName,
				["#target#"] = (TargetIconIndex ~= 0 and RaidIconList[TargetIconIndex] or "") .. TargetName
			}
		)
		if not Addon:CompareOutputCache(msg) and msg ~= L["NONE"] then
			if channel == "off" then
				return
			elseif channel == "hud" then
				Warning:AddMessage(msg)
			elseif channel == "self" then
				print("|cFFFF143C"..msg.."|r")
			else
				if channel == "raid" and UnitInBattleground("player") then
					channel = "instance_chat"
				end
				SendChatMessage(msg, channel)
			end
		end
	elseif AnnounceChannel == "whisper" and AnnounceReason == "start" and AnnounceType == "help" then --开始施法密语，有益
		if not Config.IsWhisperEnable or UnitInBattleground("player") then
			return
		end
		msg = Addon:FormatMessage(
			Config["SpellOutput"]["SPELLWHISPER_TEXT_SENTTOPLAYERSTART"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_SENTTOPLAYERSTART"] or L["SPELLWHISPER_TEXT_SENTTOPLAYERSTART"],
			{
				["#spell#"] = SpellName
			}
		)
		if TargetName ~= (UnitName("player")) then
			if not Addon:CompareOutputCache(msg, TargetName) and msg ~= L["NONE"] then
				SendChatMessage(msg, AnnounceChannel, nil, TargetName)
			end
		end
	elseif AnnounceChannel == "whisper" and AnnounceReason == "done" and AnnounceType == "help" then --完成施法密语，有益
		if not Config.IsWhisperEnable then
			return
		end
		msg = Addon:FormatMessage(
			Config["SpellOutput"]["SPELLWHISPER_TEXT_SENTTOPLAYERDONE"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_SENTTOPLAYERDONE"] or L["SPELLWHISPER_TEXT_SENTTOPLAYERDONE"],
			{
				["#spell#"] = SpellName
			}
		)
		if TargetName ~= (UnitName("player")) then
			if not Addon:CompareOutputCache(msg, TargetName) and msg ~= L["NONE"] then
				SendChatMessage(msg, AnnounceChannel, nil, TargetName)
			end
		end
	elseif AnnounceChannel == "whisper" and AnnounceReason == "start" and AnnounceType == "harm" then --开始控制技能施法密语
		if not Config.IsWhisperEnable then
			return
		end
		if not Config.ToTWarningEnable then
			return
		end
		msg = Addon:FormatMessage(
			Config["SpellOutput"]["SPELLWHISPER_TEXT_SENTTOPLAYERTARGETTHETARGET"] and Config["SpellOutput"]["SPELLWHISPER_TEXT_SENTTOPLAYERTARGETTHETARGET"] or L["SPELLWHISPER_TEXT_SENTTOPLAYERTARGETTHETARGET"],
			{
				["#spell#"] = SpellName,
				["#target#"] = (TargetIconIndex ~= 0 and RaidIconList[TargetIconIndex] or "") .. TargetName
			}
		)
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				local u = "raid" .. i
				if UnitGUID(u .. "target") == TargetGUID and not UnitIsUnit(u, "player") then
					if not Addon:CompareOutputCache(msg, GetUnitName(u, true)) and msg ~= L["NONE"] then
						SendChatMessage(msg, AnnounceChannel, nil, GetUnitName(u, true))
					end
				end
			end
		elseif IsInGroup() then
			for i = 1, GetNumGroupMembers() do
				local u = "party" .. i
				if UnitGUID(u .. "target") == TargetGUID then
					if not Addon:CompareOutputCache(msg, GetUnitName(u, true)) and msg ~= L["NONE"] then
						SendChatMessage(msg, AnnounceChannel, nil, GetUnitName(u, true))
					end
				end
			end
		end
	elseif AnnounceChannel == "whisper" and AnnounceReason == "done" and AnnounceType == "harm" then --完成施法密语通告，有害
		return
	end
end

--Register Events 注册事件
--装载和退出
Frame:RegisterEvent("ADDON_LOADED")
Frame:RegisterEvent("PLAYER_LOGOUT")
Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
--战斗信息处理
Frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
Frame:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
--文字信息处理
Frame:RegisterEvent("CHAT_MSG_WHISPER")
Frame:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
Frame:RegisterEvent("CHAT_MSG_PARTY")
Frame:RegisterEvent("CHAT_MSG_PARTY_LEADER")
Frame:RegisterEvent("CHAT_MSG_RAID")
Frame:RegisterEvent("CHAT_MSG_RAID_LEADER")
Frame:RegisterEvent("CHAT_MSG_INSTANCE_CHAT")
Frame:RegisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER")
Frame:RegisterEvent("CHAT_MSG_SAY")
Frame:RegisterEvent("GROUP_ROSTER_UPDATE")
Frame:RegisterEvent("CHAT_MSG_ADDON")
Frame:RegisterEvent("PLAYER_LOGOUT")
Frame:RegisterEvent("PLAYER_REGEN_ENABLED")
--移动相关
Frame:RegisterEvent("AUTOFOLLOW_END")

--Update处理（防止重复提示，处理延时任务）
local LastScan = 0

Frame:SetScript("OnUpdate", function(self, lastupdate)
	if not Config.IsEnable then
		Frame:Hide()
		return
	end
	if Config.WaitTime == 0 and not Addon.HasTask then
		Frame:Hide()
		return
	end
	local NowScan = math.floor(GetTime() * 10) / 10
	if NowScan == LastScan then
		return
	end
	LastScan = NowScan
	-- 过滤重复信息
	if Config.WaitTime ~= 0 then
		for k in pairs(OutputCache) do
			if NowScan > k / 1000 + Config.WaitTime then
				OutputCache[k] = nil
			end
		end
	end
	-- 执行延时任务
	if Addon.HasTask and #TaskTable > 0 then
		for i = #TaskTable, 1, -1 do
			if NowScan >= TaskTable[i].TimeStamp / 1000 + TaskTable[i].Delay then
				Addon:RunTask(TaskTable[i].Task)
				t_remove(TaskTable, i)
			end
		end
		if #TaskTable == 0 then
			Addon.HasTask = false
		end
	end
	-- 2秒一次自动跟随
	if Addon.Followed.UnitIndex ~= "player" then
		if NowScan - Addon.Followed.StartTime > 2 then
			Addon.Followed.StartTime = math.floor(GetTime() * 10) / 10
			if not UnitIsConnected(Addon.Followed.UnitIndex) then -- 掉线停止跟随
				Addon.Followed.UnitIndex = "player"
				Addon.Followed.GUID = ""
				FollowUnit("player")
			elseif (not Config.CombatFollow and UnitAffectingCombat(Addon.Followed.UnitIndex)) or not CheckInteractDistance(Addon.Followed.UnitIndex, 4) then -- 战斗状态或超距离原地等候，2秒一次继续扫描
				FollowUnit("player")
			else
				FollowUnit(Addon.Followed.UnitIndex)
			end
		end
	end
end)

--Event处理分配
Frame:SetScript(
	"OnEvent",
	function(self, event, ...)
		if type(self[event]) == "function" then
			return self[event](self, ...)
		end
	end
)

--插件装载
function Frame:ADDON_LOADED(Name)
	if Name ~= AddonName then
		return
	end
	self:UnregisterEvent("ADDON_LOADED") --完成加载后反注册事件
	do
		local VerNumString = string.gsub(Addon.Version, "%.", "")
		Addon.VerNum = tonumber(VerNumString)
	end
	-- 两种情况，如果没有SpellWhisperDB或者SpellWhisperDB中某个表不存在，则创建该表，但不用新表覆盖（读取Core中的默认值）
	-- 如果SpellWhisperDB及SpellWhisperDB中的某个表存在，则用SpellWhisperDB中的子表覆盖，避免删不掉现象
	if not SpellWhisperDB then
		SpellWhisperDB = {}
	end
	if not SpellWhisperDB.Config then
		SpellWhisperDB.Config = {}
	end
	if not SpellWhisperDB.SpellList then
		SpellWhisperDB.SpellList = {}
		Addon:UpdateTable(RunTime, Addon.Default)
	end
	-- 用SpellWhisperDB更新config和SpellList表
	Addon:UpdateTable(Config, SpellWhisperDB.Config)
	Addon:UpdateTable(RunTime, SpellWhisperDB.SpellList)
	-- 初始化Output
	Addon.Output:Initialize()
	-- 注册Prefix：SWPX
	if not IsAddonMessagePrefixRegistered(Addon.PrefixSW) then
		RegisterAddonMessagePrefix(Addon.PrefixSW)
	end
	if IsInGuild() then
		SendAddonMessage(Addon.PrefixSW, tostring(Addon.VerNum), "guild")
	end
	if Config.IsEnable and Config.WaitTime > 0 and not Frame:IsShown() then
		Frame:Show()
	else
		Frame:Hide()
	end
	-- 解决CN客户端部分字符乱码的问题
	if GetCVar("portal") == "CN" then
		ConsoleExec("portal KR")
		ConsoleExec("profanityFilter 0")
		ConsoleExec("overrideArchive 0")
	end
	local msg = string.format(L["|cFFBA55D3SpellWhisper|r v%s|cFFB0C4DE is Loaded.|r"], Addon.Version)
	if Config.IsEnable then
		print(msg .. L["Now is |cFF00FFFFEnabled|r."])
	else
		print(msg .. L["Now is |cFF00FFFFDisabled|r."])
	end
	print("|cFFBA55D3SpellWhisper|r|cFFFFD700: I removed |r|cFF1E90FFTrades/Mails Log function|r |cFFFFD700from this Addon, if you still need this function, please download my another Addon|r |cFF00F000'MailLogger'|r |cFFFFD700in|r |cFFEE82EECurseforge|r|cFFFFD700, Thanks.|r http://https://www.curseforge.com/wow/addons/maillogger")
end

-- 进入世界
function Frame:PLAYER_ENTERING_WORLD()
	if Addon.LDB and Addon.LDBIcon and ((IsAddOnLoaded("TitanClassic")) or (IsAddOnLoaded("Titan"))) then
		Addon.MinimapIcon:InitBroker()
	else
		Addon.MinimapIcon:Initialize()
		if Config.ShowMinimapIcon then -- 小地图
			Addon:UpdatePosition(Config.MinimapIconAngle)
			Addon.MinimapIcon.Minimap:Show()
		else
			Addon.MinimapIcon.Minimap:Hide()
		end
	end
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	Addon.Warning:SetPoint(Addon.Config.HUDPos[1], nil,  Addon.Config.HUDPos[3], Addon.Config.HUDPos[4], Addon.Config.HUDPos[5])
	if Config.OutputChannel == "hud" then
		Addon.Warning:Show()
		Addon.Warning.Text:Show()
	else
		Addon.Warning:Hide()
		Addon.Warning.Text:Hide()
	end
end

-- 退出游戏
function Frame:PLAYER_LOGOUT()
	-- 将数据存入SpellWhisperDB（保存文件）
	Config.HUDPos[1], _, Config.HUDPos[3], Config.HUDPos[4], Config.HUDPos[5] = Addon.Warning:GetPoint()
	SpellWhisperDB = {
		["Config"] = {},
		["SpellList"] = {},
	}
	Addon:UpdateTable(SpellWhisperDB.Config, Config)
	Addon:UpdateTable(SpellWhisperDB.SpellList, Addon.RunTime)
end

--确定发言等级
function Frame:GROUP_ROSTER_UPDATE() --发言者同步, 队伍成员变化时Fire
	if Addon.IsEnable == "off" then
		return
	end
	if Config.OutputChannel == "off" or Config.OutputChannel == "self" then
		return
	end
	if not IsInGroup() then
		VersionTable = {}
	end
	-- 非战斗状态立刻同步
	Addon:DeleteVanishMember()
	if IsInRaid() and not UnitInBattleground("player") then
		Addon:SendAnnounceRank(41 - UnitInRaid("player"))
	elseif IsInGroup() then
		Addon:SendAnnounceRank(0)
	end
	if Addon.Followed.UnitIndex ~= "player" then --更新跟随对象unit
		local t, u = Addon:GetTargetUnit(Addon.Followed.GUID)
		if t == "group" then
			Addon.Followed.UnitIndex = u
		else
			Addon.Followed.UnitIndex = "player"
			Addon.Followed.GUID = ""
		end
	end
end

function Frame:CHAT_MSG_ADDON(...) -- 同步Rank，决定谁能发言，提示更新信息
	if not Config.IsEnable then
		return
	end

	local arg = {...}


	if arg[1] == Addon.PrefixSW then
		local AddonChannelMsg = tonumber(arg[2])
		if AddonChannelMsg >= 1000 and AddonChannelMsg <= 80000 and (arg[3]:lower() == "party" or arg[3]:lower() == "raid") then
			if Config.OutputChannel == "off" or Config.OutputChannel == "self" or Config.OutputChannel == "hud" then
				return
			end
			AnnounceTable[Addon:GetShortName(arg[4])] = AddonChannelMsg
		elseif AddonChannelMsg < 1000 and arg[3]:lower() == "guild" then
			if AddonChannelMsg > Addon.VerNum then
				print(
					string.format(
						L["|cFFBA55D3SpellWhisper|r v%s is |cFFFF4C00Out of date|r. Goto %s for |cFFF48CBANew Version.|r"],
						Addon.Version,
						L["Feedback & Update Link"]
					)
				)
			end
		elseif AddonChannelMsg < 1000 and (arg[3]:lower() == "party" or arg[3]:lower() == "raid") then
			VersionTable[Addon:GetShortName(arg[4])] = AddonChannelMsg
		elseif AddonChannelMsg == 99999 and not UnitInBattleground("player") then
			if IsInRaid() then
				SendAddonMessage(Addon.PrefixSW, tostring(Addon.VerNum), "raid")
				Addon:SendAnnounceRank(41 - UnitInRaid("player"))
			elseif IsInGroup() then
				SendAddonMessage(Addon.PrefixSW, tostring(Addon.VerNum), "party")
				Addon:SendAnnounceRank(0)
			end
		end
	end
end

function Frame:CHAT_MSG_WHISPER(...) --接收密语--arg[1]对话内容，arg[12]GUID
	if not Config.IsEnable or UnitInBattleground("player") then
		return
	end
	local arg = {...}
	Addon.Followed.FromWhisper = true
	Addon:FollowTargetUnit(arg[12], arg[1])
end

function Frame:CHAT_MSG_WHISPER_INFORM(NewMessage, TargetName) --发送密语--arg[1]对话内容，arg[2]发送对象
	if not Config.IsEnable or Config.WaitTime == 0 then
		return
	end
	Addon:AddOutputCache(NewMessage, TargetName)
end

function Frame:CHAT_MSG_SAY(NewMessage) --接收说话频道信息
	if not Config.IsEnable or Config.WaitTime == 0 then
		return
	end
	Addon:AddOutputCache(NewMessage, nil)
end

function Frame:CHAT_MSG_PARTY(NewMessage) --接收队伍对话信息
	if NewMessage == Config.StopFollow then
		Addon.Followed.UnitIndex = "player"
		Addon.Followed.GUID = ""
		FollowUnit("player")
		return
	end
	if not Config.IsEnable or Config.WaitTime == 0 then
		return
	end
	Addon:AddOutputCache(NewMessage, nil)
end

function Frame:CHAT_MSG_PARTY_LEADER(NewMessage) --队长信息
	if NewMessage == Config.StopFollow then
		Addon.Followed.UnitIndex = "player"
		Addon.Followed.GUID = ""
		FollowUnit("player")
		return
	end
	if not Config.IsEnable or Config.WaitTime == 0 then
		return
	end
	Addon:AddOutputCache(NewMessage, nil)
end

function Frame:CHAT_MSG_RAID(NewMessage) --raid频道信息
	if NewMessage == Config.StopFollow then
		Addon.Followed.UnitIndex = "player"
		Addon.Followed.GUID = ""
		FollowUnit("player")
		return
	end
	if not Config.IsEnable or Config.WaitTime == 0 then
		return
	end
	Addon:AddOutputCache(NewMessage, nil)
end

function Frame:CHAT_MSG_RAID_LEADER(NewMessage) --RaidLeader频道
	if NewMessage == Config.StopFollow then
		Addon.Followed.UnitIndex = "player"
		Addon.Followed.GUID = ""
		FollowUnit("player")
		return
	end
	if not Config.IsEnable or Config.WaitTime == 0 then
		return
	end
	Addon:AddOutputCache(NewMessage, nil)
end

function Frame:CHAT_MSG_INSTANCE_CHAT(NewMessage) --战场频道
	if not Config.IsEnable or Config.WaitTime == 0 then
		return
	end
	Addon:AddOutputCache(NewMessage, nil)
end

function Frame:CHAT_MSG_INSTANCE_CHAT_LEADER(NewMessage) --战场Leader频道
	if not Config.IsEnable or Config.WaitTime == 0 then
		return
	end
	Addon:AddOutputCache(NewMessage, nil)
end

-- 战斗结束清空BreakTable，频道delay同步
function Frame:PLAYER_REGEN_ENABLED()
	if BreakTable then
		BreakTable = {}
	end
	if ThreatList then
		ThreatList = {}
	end
end

-- COMBAT_LOG_EVENT_UNFILTERED 战斗信息处理
function Frame:COMBAT_LOG_EVENT_UNFILTERED(...)

	if not Config.IsEnable or not IsInGroup() then
		return
	end

	local arg = { CombatLogGetCurrentEventInfo() } --COMBAT_LOG_EVENT_UNFILTERED 事件参数Payload

	local SpellName = nil
	local TypeHelpHarm = nil
	local InstanceType = select(2, IsInInstance())

	if arg[2] == "SPELL_CAST_FAILED" and arg[4] == PlayerGUID and (InstanceType == "party" or InstanceType == "raid") then --治疗法术失败提示
		local FailedReason = nil
		for k in pairs(FailReason) do
			if arg[15] == FailReason[k] then
				FailedReason = arg[15] --失败原因arg[15]
				break
			end
		end
		if FailedReason then
			for k in pairs(RunTime.Healing) do
				if arg[13] == RunTime.Healing[k] then
					SpellName = arg[13] --失败法术arg[13]
					break
				end
			end
			local CurrentTarget = nil
			if SpellName and UnitExists("mouseover") and UnitIsPlayer("mouseover") and UnitIsFriend("player", "mouseover") then
				CurrentTarget = "mouseover"
			elseif SpellName and UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("player", "target") then
				CurrentTarget = "target"
			elseif
				SpellName and UnitExists("targettarget") and UnitIsPlayer("targettarget") and UnitIsEnemy("player", "target") and UnitIsFriend("player", "targettarget") then
				CurrentTarget = "targettarget"
			end
			if CurrentTarget then
				Addon:SendHealingMessage(GetSpellLink(arg[12]), GetUnitName(CurrentTarget, true), FailedReason)
			end
		end
	elseif arg[2] == "SPELL_MISSED" then --法术未成功通告
		local CasterType, CasterUnit = Addon:GetTargetUnit(arg[4])
		if CasterType and (CasterType == "group" or CasterType == "pet" or arg[4] == PlayerGUID) and (InstanceType == "party" or InstanceType == "raid") then
			local MissedReason = nil
			for k in pairs(MissReason) do
				if arg[15] == k then
					MissedReason = MissReason[k]
					break
				end
			end
			if MissedReason then
				if not SpellName then
					for k in pairs(RunTime.Other) do --是否为其他需要通告的技能
						if arg[13] == RunTime.Other[k] then
							SpellName = arg[13]
							break
						end
					end
				end
				if not SpellName then
					for k in pairs(RunTime.CastHarm) do --是否为施法控制技能
						if arg[13] == RunTime.CastHarm[k] then
							SpellName = arg[13]
							break
						end
					end
				end
				if not SpellName then
					for k in pairs(RunTime.InstantHarm) do --是否为瞬发控制技能
						if arg[13] == RunTime.InstantHarm[k] then
							SpellName = arg[13]
							break
						end
					end
				end
				if SpellName then
					local t, u = Addon:GetTargetUnit(arg[8]) --获取miss对象的Unit代码
					if t == "target" and u then
						local RaidTargetIcon = GetRaidTargetIndex(u) or 0
						Addon:SendWarningMessage("MISSED", arg[5], GetSpellLink(arg[12]), arg[9], MissedReason, RaidTargetIcon, nil) --arg[5]施法者名字，arg[9]目标名字
					end
				end
			end
		elseif CasterType == "target" and UnitIsEnemy("player", CasterUnit) and arg[15] == "REFLECT" then -- 反射提示
			local RaidTargetIcon = GetRaidTargetIndex(CasterUnit) or 0
			Addon:SendWarningMessage("REFLECT", arg[5], GetSpellLink(arg[12]), arg[9], nil, RaidTargetIcon, nil) -- arg[5]施法者，arg[13]被反射技能，arg[9]目標
		end
	elseif arg[2] == "SPELL_INTERRUPT" then --打断通告
		local CasterType = Addon:GetTargetUnit(arg[4])
		if CasterType == "group" or CasterType == "pet" or arg[4] == PlayerGUID then
			local t, u = Addon:GetTargetUnit(arg[8]) --获取miss对象的Unit代码
			if t == "target" and u and not UnitIsFriend("player", u) then
				local RaidTargetIcon = GetRaidTargetIndex(u) or 0
				Addon:SendWarningMessage("INTERRUPT", arg[5], GetSpellLink(arg[12]), arg[9], GetSpellLink(arg[15]), RaidTargetIcon, nil) --arg[5]打断者名字，arg[13]打断技能，arg[9]被打断者名字，arg[16]被打断的技能
			end
		end
	elseif arg[2] == "SPELL_STOLEN" then --偷取通告
		local CasterType = Addon:GetTargetUnit(arg[4])
		if CasterType == "group" or CasterType == "pet" or arg[4] == PlayerGUID then
			local t, u = Addon:GetTargetUnit(arg[8]) --获取miss对象的Unit代码
			if t == "target" and u and not UnitIsFriend("player", u) then
				local RaidTargetIcon = GetRaidTargetIndex(u) or 0
				Addon:SendWarningMessage("STOLEN", arg[5], GetSpellLink(arg[15]), arg[9], nil, RaidTargetIcon, nil) --arg[5]打断者名字，arg[13]打断技能，arg[9]被打断者名字，arg[16]被打断的技能
			end
		end
	elseif arg[2] == "SPELL_DISPEL" and (InstanceType == "party" or InstanceType == "raid") then --进攻驱散提示
		local CasterType = Addon:GetTargetUnit(arg[4])
		if CasterType == "group" or CasterType == "pet" or arg[4] == PlayerGUID then
			local t, u = Addon:GetTargetUnit(arg[8]) --被驱散对象的Unit代码
			if t == "target" and u and not UnitIsFriend("player", u) then
				local RaidTargetIcon = GetRaidTargetIndex(u) or 0
				Addon:SendWarningMessage("DISPEL", arg[5], GetSpellLink(arg[12]), arg[9], GetSpellLink(arg[15]), RaidTargetIcon, nil)
			end
		end
	elseif (arg[2] == "SPELL_AURA_BROKEN_SPELL" or arg[2] == "SPELL_AURA_BROKEN") and (InstanceType == "party" or InstanceType == "raid") then --破控警告
		local CasterType = Addon:GetTargetUnit(arg[4])
		if CasterType == "group" or CasterType == "pet" or arg[4] == PlayerGUID then
			if not arg[16] then --SWING模式下arg补全
				arg[16] = L["SPELLWHISPER_TEXT_SWINGATTACK"]
			end
			local t, u = Addon:GetTargetUnit(arg[8]) --获取破除控制对象的Unit代码
			if t == "target" and u and not UnitIsFriend("player", u) then --arg[5]破控者名字，arg[16]破控技能, arg[9]失去控制对象名字，arg[13]被打破的控制技能
				local RaidTargetIcon = GetRaidTargetIndex(u) or 0
				Addon:SendWarningMessage("BROKEN", arg[5], GetSpellLink(arg[15]), arg[9], GetSpellLink(arg[12]), RaidTargetIcon, arg[8])
			end
		end
	elseif arg[2] == "SPELL_CAST_START" and arg[4] == PlayerGUID then
		local IsIgnoreSpell = false
		TargetGUID = nil
		if not SpellName then
			for k in pairs(RunTime.CastHelp) do --监控有益施法法术
				if arg[13] == RunTime.CastHelp[k] then
					SpellName = arg[13]
					TypeHelpHarm = "help"
					break
				end
			end
		end
		if not SpellName then
			for k in pairs(RunTime.CastHarm) do --监控有害施法法术
				if arg[13] == RunTime.CastHarm[k] then
					SpellName = arg[13]
					TypeHelpHarm = "harm"
					break
				end
			end
		end
		if SpellName then
			for k in pairs(RunTime.Ignore) do --排除忽略列表
				if SpellName == RunTime.Ignore[k] then
					IsIgnoreSpell = true
					break
				end
			end
			local CurrentTarget = nil
			if TypeHelpHarm == "harm" then
				if (UnitName("mouseover")) and not UnitIsFriend("player", "mouseover") then
					CurrentTarget = "mouseover"
				elseif (UnitName("target")) and not UnitIsFriend("player", "target") then
					CurrentTarget = "target"
				end
			elseif TypeHelpHarm == "help" then
				if (UnitName("mouseover")) and UnitIsFriend("player", "mouseover") then
					CurrentTarget = "mouseover"
				elseif (UnitName("target")) and UnitIsFriend("player", "target") then
					CurrentTarget = "target"
				end
			end
			if CurrentTarget then
				TargetGUID = UnitGUID(CurrentTarget) --建立施法状态，以便通告
				for i = 1, 40 do --查找现有debuff，如存在，则施法为renew，不重复提示
					if not UnitDebuff(CurrentTarget, i) then --如无debuff，则跳出查找环节
						break
					elseif UnitDebuff(CurrentTarget, i) == SpellName then
						return
					end
				end
				local RaidTargetIcon = GetRaidTargetIndex(CurrentTarget) or 0
				if TypeHelpHarm == "harm" and (InstanceType == "party" or InstanceType == "raid") or TypeHelpHarm == "help" then
					Addon:SendAnnounceMessage("group", "start", TypeHelpHarm, GetSpellLink(arg[12]), GetUnitName(CurrentTarget, true), RaidTargetIcon)
				end
				if CurrentTarget and not IsIgnoreSpell then
					if TypeHelpHarm == "help" and UnitIsPlayer(CurrentTarget) then
						-- Addon:SendAnnounceMessage("whisper", "start", TypeHelpHarm, SpellName, GetUnitName(CurrentTarget, true), RaidTargetIcon)
					elseif TypeHelpHarm == "harm" and (InstanceType == "party" or InstanceType == "raid") then
						Addon:SendAnnounceMessage("whisper", "start", TypeHelpHarm, GetSpellLink(arg[12]), GetUnitName(CurrentTarget, true), RaidTargetIcon)
					end
				end
			end
		end
	elseif arg[2] == "SPELL_CAST_SUCCESS" and arg[4] == PlayerGUID then --增益通告:arg[4]施法者GUID，arg[9]目标名字，arg[8]目标GUID(不再使用GUID)
		if not SpellName then
			for k in pairs(RunTime.InstantHelp) do --遍历，寻找瞬发增益
				if arg[13] == RunTime.InstantHelp[k] then
					SpellName = arg[13]
					TypeHelpHarm = "help"
					break
				end
			end
		end
		if not SpellName then
			for k in pairs(RunTime.CastHelp) do --遍历，寻找施法增益
				if arg[13] == RunTime.CastHelp[k] then
					SpellName = arg[13]
					TypeHelpHarm = "help"
					break
				end
			end
		end
		if SpellName then
			local NowGUID = nil
			if arg[9] then
				NowGUID = arg[8]
			else
				NowGUID = TargetGUID and TargetGUID or PlayerGUID
			end
			local u = select(2, Addon:GetTargetUnit(NowGUID))
			if UnitIsPlayer(u) and UnitIsFriend(u, "player") then
				local RaidTargetIcon = GetRaidTargetIndex(u) or 0
				Addon:SendAnnounceMessage("group", "done", TypeHelpHarm, GetSpellLink(arg[12]), GetUnitName(u, true), RaidTargetIcon)
				Addon:SendAnnounceMessage("whisper", "done", TypeHelpHarm, GetSpellLink(arg[12]), GetUnitName(u, true), RaidTargetIcon)
			end
		end
	elseif arg[2] == "SPELL_AURA_APPLIED" and (arg[4] == PlayerGUID and not InstanceType == "scenario" or arg[8] == PlayerGUID and (InstanceType == "pvp" or InstanceType == "arena")) then
		if not SpellName then
			for k in pairs(RunTime.InstantHarm) do
				if arg[13] == RunTime.InstantHarm[k] then
					SpellName = RunTime.InstantHarm[k]
					TypeHelpHarm = "harm"
					break
				end
			end
		end
		if not SpellName then
			for k in pairs(RunTime.CastHarm) do
				if arg[13] == RunTime.CastHarm[k] then
					SpellName = RunTime.CastHarm[k]
					TypeHelpHarm = "harm"
					break
				end
			end
		end
		if not SpellName then
			for k in pairs(RunTime.SelfBuff) do
				if arg[13] == RunTime.SelfBuff[k] then
					SpellName = RunTime.SelfBuff[k]
					TypeHelpHarm = "help"
					break
				end
			end
		end
		if SpellName then
			local t, u = Addon:GetTargetUnit(arg[8]) --arg[8] 受影响对象的GUID
			if arg[4] == PlayerGUID and t and u then
				local RaidTargetIcon = GetRaidTargetIndex(u) or 0
				if t == "target" and not UnitIsFriend("player", u) or t == "player" then
					Addon:SendAnnounceMessage("group", "done", TypeHelpHarm, GetSpellLink(arg[12]), arg[9], RaidTargetIcon)
				end
			elseif UnitInBattleground("player") and t == "player" then
				if not arg[5] then
					arg[5] = L["SPELLWHISPER_TEXT_UNKNOWN"]
				end
				Addon:SendBGMessage(GetSpellLink(arg[12]), arg[5], arg[9])
			end
		end
	elseif arg[2] == "UNIT_DIED" and (InstanceType == "party" or InstanceType == "raid") then
		local Type = strsplit("-", arg[8] or "")
		if Type == "Creature" then
			if #ThreatList > 0 then
				for i = #ThreatList, 1, -1 do
					if ThreatList[i].GUID == arg[8] then
						t_remove(ThreatList, i)
					end
				end
			end
		end
	end
end

-- 手动停止跟随
function Frame:AUTOFOLLOW_END()
	if Addon.Followed.UnitIndex ~= "player" then
		if CheckInteractDistance(Addon.Followed.UnitIndex, 4) then
			if math.floor(GetTime() * 100) / 100 - Addon.Followed.StartTime > 0.15 then
				SendChatMessage(L["SPELLWHISPER_TEXT_STOPFOLLOW_MANUALLY"], "whisper", nil, GetUnitName(Addon.Followed.UnitIndex, true))
				Addon.Followed.UnitIndex = "player"
				Addon.Followed.GUID = ""
			end
		end
	end
end

-- 仇恨相关
function Frame:UNIT_THREAT_LIST_UPDATE()
	if not Config.IsEnable or not IsInGroup() then
		return
	end
	if Config.ThreatType == "off" then
		return
	end
	if not IsInInstance() then
		return
	end

	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local RaidTarget = "raid" .. i .. "target"
			if not UnitIsFriend("player", RaidTarget) then
				if Config.ThreatType == "all" then
					Addon:AddToThreatList(RaidTarget)
				elseif Config.ThreatType == "elite" and (UnitClassification(RaidTarget) == "worldboss" or UnitClassification(RaidTarget) == "elite") then
					Addon:AddToThreatList(RaidTarget)
				elseif Config.ThreatType == "worldboss" and UnitClassification(RaidTarget) == "worldboss" then
					Addon:AddToThreatList(RaidTarget)
				end
			end
		end
	elseif IsInGroup() then
		if not UnitIsFriend("player", "target") then
			if Config.ThreatType == "all" then
				Addon:AddToThreatList("target")
			elseif Config.ThreatType == "elite" and (UnitClassification("target") == "worldboss" or UnitClassification("target") == "elite") then
				Addon:AddToThreatList("target")
			elseif Config.ThreatType == "worldboss" and UnitClassification("target") == "worldboss" then
				Addon:AddToThreatList("target")
			end
		end
		for i = 1, GetNumGroupMembers() do
			local PartyTarget = "party" .. i .. "target"
			if not UnitIsFriend("player", PartyTarget) then
				if Config.ThreatType == "all" then
					Addon:AddToThreatList(PartyTarget)
				elseif Config.ThreatType == "elite" and (UnitClassification(PartyTarget) == "worldboss" or UnitClassification(PartyTarget) == "elite") then
					Addon:AddToThreatList(PartyTarget)
				elseif Config.ThreatType == "worldboss" and UnitClassification(PartyTarget) == "worldboss" then
					Addon:AddToThreatList(PartyTarget)
				end
			end
		end
	end
end