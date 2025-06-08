local AddonName, Addon = ...

local Frame = Addon.Frame --Frame
local L = Addon.L --Localization

--Config Setting
local Config = Addon.Config --Config
--当前交易情况
local TradeLog = Addon.TradeLog
--交易输出界面
local Output = Addon.Output
--設置界面
local SetWindow = Addon.SetWindow
--日曆界面
local Calendar = Addon.Calendar
--小地圖圖標
local MinimapIcon = Addon.MinimapIcon
--忽略列表
local IgnoreItems = Addon.IgnoreItems

--本地化函数(提升运行效率)
local SendChatMessage = SendChatMessage
local UnitName = UnitName
local UnitGUID = UnitGUID
local GetNumGroupMembers = GetNumGroupMembers
local GetRealZoneText = GetRealZoneText
local GetTradePlayerItemInfo = GetTradePlayerItemInfo
local GetTradeTargetItemInfo = GetTradeTargetItemInfo
local GetTradePlayerItemLink = GetTradePlayerItemLink
local GetTradeTargetItemLink = GetTradeTargetItemLink
local GetPlayerTradeMoney = GetPlayerTradeMoney
local GetTargetTradeMoney = GetTargetTradeMoney
local GetSendMailItem = GetSendMailItem
local GetSendMailItemLink = GetSendMailItemLink
local GetSendMailMoney = GetSendMailMoney
local GetInboxHeaderInfo = GetInboxHeaderInfo
local GetInboxItem = GetInboxItem
local GetInboxItemLink = GetInboxItemLink
local IsGuildMember = IsGuildMember
local IsFriend = C_FriendList.IsFriend
local IsInGroup = IsInGroup
local IsInRaid = IsInRaid
local IsInInstance = IsInInstance
local IsInGuild = IsInGuild
local CloseTrade = CloseTrade
local GetRealmName = GetRealmName
local pairs = pairs
local print = print
local date = date
local time = time
local hooksecurefunc = hooksecurefunc
local t_insert = table.insert
local t_remove = table.remove
--缓存
local Current = {}
--邮箱界面状态
local MailBoxOpened = false

--公共方法：
--更新table
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
--格式化信息
function Addon:FormatMessage(msg, args)
	if msg then
		for k, v in pairs(args) do
			msg = string.gsub(msg, k, v)
		end
	end
	return msg
end
--获取数据表大小
function Addon:GetTableSize(SourceTable)
	local Num = 0
	for k in pairs(SourceTable) do
		Num = Num + 1
	end
	return Num
end
--比較時間
function Addon:CompareTime(TimeStr, Seconds)
	local H1, M1, S1 = strsplit(":", date("%H:%M:%S"))
	local H2, M2, S2 = strsplit(":", TimeStr)
	H1 = tonumber(H1) and tonumber(H1) or nil
	H2 = tonumber(H2) and tonumber(H2) or nil
	M1 = tonumber(M1) and tonumber(M1) or nil
	M2 = tonumber(M2) and tonumber(M2) or nil
	S1 = tonumber(S1) and tonumber(S1) or nil
	S2 = tonumber(S2) and tonumber(S2) or nil
	if H1 and H2 and M1 and M2 and S1 and S2 then
		local Elapsed = (H1 - H2) * 3600 + (M1 - M2) * 60 + S1 - S2
		if Elapsed > Seconds or Elapsed < 0 then
			return true
		end
	end
	return false
end
--交易相關
--新建交易
function Addon:NewTrade()
	local TempTrade = {
		["Date"] = date("%Y-%m-%d"),
		["Time"] = date("%H:%M:%S"),
		["PlayerName"] = (UnitName("player")) .. "-" .. GetRealmName(),
		["TargetName"] = (UnitName("npc")) .. "-" .. (select(2, UnitName("npc")) or GetRealmName()),
		["Location"] = GetRealZoneText(),
		["ReceiveItems"] = {},
		["GiveItems"] = {},
		["ReceiveMoney"] = 0,
		["GiveMoney"] = 0,
		["Result"] = nil,
		["Reason"] = nil,
	}
	return TempTrade
end
--清空邮寄信息
function Addon:NewMail()
	local TempMail = {
		["Date"] = nil,
		["Time"] = nil,
		["PlayerName"] = (UnitName("player")) .. "-" .. GetRealmName(),
		["TargetName"] = nil,
		["Location"] = nil,
		["ReceiveItems"] = {},
		["GiveItems"] = {},
		["ReceiveMoney"] = 0,
		["GiveMoney"] = 0,
		["Result"] = nil,
		["Reason"] = nil,
	}
	return TempMail
end
--计算金钱值
--返回带颜色的金钱值

--更新交易物品信息
function Addon:UpdateTradeItemInfo(Side, Slot, ItemTable)
	local ItemName, Quantity, Enchantment, ItemLink
	if Side == "target" then
		ItemName, _, Quantity, _, _, Enchantment = GetTradeTargetItemInfo(Slot)
	else
		ItemName, _, Quantity, _, Enchantment = GetTradePlayerItemInfo(Slot)
	end
	if not ItemName or IgnoreItems[ItemName] then
		ItemTable[Slot] = nil
		return
	end
	if Side == "target" then
		ItemLink = GetTradeTargetItemLink(Slot)
	else
		ItemLink = GetTradePlayerItemLink(Slot)
	end
	ItemTable[Slot] = {
		["Name"] = ItemName,
		["Number"] = Quantity,
		["Enchantment"] = Enchantment,
		["ItemLink"] = ItemLink,
	}
end
--更新交易金钱
local function UpdateTradeMoney()
	Current.ReceiveMoney = GetTargetTradeMoney()
	Current.GiveMoney = GetPlayerTradeMoney()
end
--交易通报
function Addon:AnnounceTrade()
    if not (Config.EnableWhisper or Config.SendToPublic) then -- 通報均關閉的情況
        return
    end
    if select(2, IsInInstance()) == "pvp" or select(2, IsInInstance()) == "arena" then -- 戰場不通報
        return
    end
--[[
    local function GetWhisperTarget(TargetName, ServerName) -- 獲取對象帶服務器名稱的名字
        if ServerName and ServerName ~= "" then
            TargetName = TargetName .. "-" .. ServerName
        end
        return TargetName
    end
]]
	local function GetMoneyString(Money) -- 格式化金錢數據
		local Gold = math.floor(Money / 10000)
		local Silver = math.floor(Money / 100) - Gold * 100
		local Copper = Money - (Gold * 100 + Silver) * 100
		local msg = ""
		if Gold > 0 then
			msg = msg .. Gold .. L["g"]
		end
		if Silver > 0 then
			msg = msg .. Silver .. L["s"]
		end
		if Copper > 0 then
			msg = msg .. Copper .. L["c"]
		end
		return msg
	end
    local function GetMessage(CurrentTrade) -- 格式化輸出文本
        local msg = ""
        if (CurrentTrade.Result == "error" or CurrentTrade.Result == "cancelled") and CurrentTrade.TargetName and CurrentTrade.Reason then
            msg = string.format(L["MAILLOGGER_TEXT_TRADE_ERROR"], CurrentTrade.TargetName, CurrentTrade.Reason)
        elseif CurrentTrade.Result == "completed" then
            local ReceiveItemNum = CurrentTrade.ReceiveItems[7] and Addon:GetTableSize(CurrentTrade.ReceiveItems) - 1 or Addon:GetTableSize(CurrentTrade.ReceiveItems)
            local GiveItemNum = CurrentTrade.GiveItems[7] and Addon:GetTableSize(CurrentTrade.GiveItems) - 1 or Addon:GetTableSize(CurrentTrade.GiveItems)
            local ReceiveMoneyString = GetMoneyString(CurrentTrade.ReceiveMoney)
            local GiveMoneyString = GetMoneyString(CurrentTrade.GiveMoney)
            msg = string.format(L["MAILLOGGER_TEXT_TRADE_SUCCEED"], CurrentTrade.TargetName)
            if ReceiveMoneyString ~= "" then
                msg = msg .. string.format(L["MAILLOGGER_TEXT_TRADE_MONEY_RECEIVE"], ReceiveMoneyString)
            end
            if GiveMoneyString ~= "" then
                msg = msg .. string.format(L["MAILLOGGER_TEXT_TRADE_MONEY_GIVE"], GiveMoneyString)
            end
            if ReceiveItemNum > 0 then
                msg = msg .. Addon:FormatMessage(L["MAILLOGGER_TEXT_TRADE_ITEMS_RECEIVE"],
                    {
                        ["#item#"] = CurrentTrade.ReceiveItems[(next(CurrentTrade.ReceiveItems))].ItemLink,
                        ["#quantity#"] = CurrentTrade.ReceiveItems[(next(CurrentTrade.ReceiveItems))].Number,
                        ["#num#"] = ReceiveItemNum,
                    }
                )
            end
            if GiveItemNum > 0 then
                msg = msg ..  Addon:FormatMessage(L["MAILLOGGER_TEXT_TRADE_ITEMS_GIVE"],
                    {
                        ["#item#"] = CurrentTrade.GiveItems[(next(CurrentTrade.GiveItems))].ItemLink,
                        ["#quantity#"] = CurrentTrade.GiveItems[(next(CurrentTrade.GiveItems))].Number,
                        ["#num#"] = GiveItemNum,
                    }
                )
            end
            if CurrentTrade.GiveItems[7] then
                msg = msg .. string.format(L["MAILLOGGER_TEXT_TRADE_ENCHANTMENT"], CurrentTrade.GiveItems[7].ItemLink, CurrentTrade.GiveItems[7].Enchantment)
            end
            if CurrentTrade.ReceiveItems[7] then
                msg = msg .. string.format(L["MAILLOGGER_TEXT_TRADE_ENCHANTMENT"], CurrentTrade.ReceiveItems[7].ItemLink, CurrentTrade.ReceiveItems[7].Enchantment)
            end
        end
        return msg
    end
    local function GetChannel() -- 獲取輸出頻道
        if IsInRaid() then
            return "RAID"
        elseif IsInGroup() and IsInInstance() then
            return "INSTANCE_CHAT"
        elseif IsInGroup() then
            return "PARTY"
        else
            return "SAY"
        end
    end
    do -- 發送信息
        local msg = GetMessage(Current)
--      local Target = GetWhisperTarget(Current.TargetName, Current.ServerName)

        if Config.EnableWhisper then
            SendChatMessage(msg, "WHISPER", nil, Current.TargetName)
        end

        if Config.SendToPublic then
            local channel = GetChannel()
            SendChatMessage(msg, channel)
        end
    end
end
-- 输出交易记录信息
function Addon:PrintTradeLog(ListMode, AltName, SelectedDate)
	-- 帶色彩的金錢字符串
	local function GetColorMoneyString(Money)
		local GoldColor="FFD100"
		local SilverColor="E6E6E6"
		local CopperColor="C8602C"
	
		local Gold = math.floor(Money / 10000)
		local Silver = math.floor(Money / 100) - Gold * 100
		local Copper = Money - (Gold * 100 + Silver) * 100
		local msg = ""
		if Gold > 0 then
			msg = msg .. "|cFFFFFF00" .. Gold .. "|r|cFF" .. GoldColor .. L["g"] .. "|r"
		end
		if Silver > 0 then
			msg = msg .. "|cFFFFFF00" .. Silver .. "|r|cFF" .. SilverColor .. L["s"] .. "|r"
		end
		if Copper > 0 then
			msg = msg .. "|cFFFFFF00" .. Copper .. "|r|cFF" .. CopperColor .. L["c"] .. "|r"
		end
		return msg
	end
	-- 初始化窗口
	local TitleText = {
		["ALL"] = L["All Logs"];
		["TRADE"] = L["Trade Logs"];
		["MAIL"] = L["Mail Logs"];
		["SMAIL"] = L["Sent Mail"];
		["RMAIL"] = L["Received Mail"];
	}
	Output.title:SetText(TitleText[ListMode])
	Output.background:Show()
	Output.export:GetParent():Show()
	Output.export:Enable()
	-- 没有记录
	if #TradeLog == 0 then
		Output.export:SetText(L["<|cFFBA55D3MailLogger|r>There are no logs available."])
		return
	end
	-- 清理不合法TradeLog
	if #TradeLog > 0 then
		for i = #TradeLog, 1, -1 do
			if not TradeLog[i].Date or not TradeLog[i].Time or not TradeLog[i].TargetName or not TradeLog[i].Result or TradeLog[i].GiveMoney == 0 and TradeLog[i].ReceiveMoney == 0 and not (next(TradeLog[i].GiveItems)) and not (next(TradeLog[i].ReceiveItems)) then
				t_remove(TradeLog, i)
			end
		end
	end
	-- 寻找起始点
	local StartPoint, Count = 1, 0
	if AltName then
		for i = #TradeLog, 1, -1 do
			if TradeLog[i].PlayerName == AltName then
				Count = Count + 1
			end
			if Count > 512 then
				StartPoint = i
				break
			end
		end
	elseif not SelectedDate then
		for i = #TradeLog, 1, -1 do
			if ListMode == "ALL" or ListMode == "TRADE" and TradeLog[i].Result == "completed" or ListMode == "MAIL" and (TradeLog[i].Result == "sent" or TradeLog[i].Result == "received") or ListMode == "SMAIL" and TradeLog[i].Result == "sent" or ListMode == "RMAIL" and TradeLog[i].Result == "received" then
				Count = Count + 1
			end
			if Count > 512 then
				StartPoint = i
				break
			end
		end
	end
	-- 輸出字符串
	local msg = ""
	-- 限制输出Log数量，避免资源耗尽
	for i = StartPoint, #TradeLog do
		if (not AltName and TradeLog[i].Date == SelectedDate) or (TradeLog[i].PlayerName == AltName and not SelectedDate) or (not AltName and not SelectedDate) or (TradeLog[i].PlayerName == AltName and TradeLog[i].Date == SelectedDate) then
			if TradeLog[i].Result == "completed" and (ListMode == "ALL" or ListMode == "TRADE") then
				msg = msg .. string.format(L["[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r trades with |cFF00FF00%s|r at |cFF00FF00%s|r"], TradeLog[i].Date, TradeLog[i].Time, TradeLog[i].PlayerName, TradeLog[i].TargetName, TradeLog[i].Location) .. "\n"
			elseif TradeLog[i].Result == "sent" and (ListMode == "ALL" or ListMode == "MAIL" or ListMode == "SMAIL") then
				msg = msg .. string.format(L["[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r sent a mail to |cFF00FF00%s|r"], TradeLog[i].Date, TradeLog[i].Time, TradeLog[i].PlayerName, TradeLog[i].TargetName) .. "\n"
			elseif TradeLog[i].Result == "received" and (ListMode == "ALL" or ListMode == "MAIL" or ListMode == "RMAIL") then
				msg = msg .. string.format(L["[|cFFFFFF00%s %s|r]\n    |cFF00FF00%s|r received item(s) from |cFF00FF00%s|r"], TradeLog[i].Date, TradeLog[i].Time, TradeLog[i].PlayerName, TradeLog[i].TargetName) .. "\n"
			end
			if (TradeLog[i].ReceiveMoney > 0 or TradeLog[i].GiveMoney > 0) and ((TradeLog[i].Result == "completed" and (ListMode == "ALL" or ListMode == "TRADE")) or (TradeLog[i].Result == "sent" or TradeLog[i].Result == "received") and (ListMode == "ALL" or ListMode == "MAIL") or TradeLog[i].Result == "sent" and ListMode == "SMAIL" or TradeLog[i].Result == "received" and ListMode == "RMAIL") then
				if TradeLog[i].ReceiveMoney > 0 then
					msg = msg .. "    " .. L["|cFFDAA520Receive|r "] .. GetColorMoneyString(TradeLog[i].ReceiveMoney) .. "\n"
				end
				if TradeLog[i].GiveMoney > 0 then
					msg = msg .. "    " .. L["|cFFFF4500Give|r "] .. GetColorMoneyString(TradeLog[i].GiveMoney) .. "\n"
				end
			end
			if TradeLog[i].Result == "completed" and (ListMode == "ALL" or ListMode == "TRADE") and next(TradeLog[i].GiveItems) and TradeLog[i].GiveItems[7] then
				msg = msg .. "    " .. L["|cFFDAA520Receive Enchantment|r: "] .. "\n    [|cFFBA55D3" .. TradeLog[i].GiveItems[7].Enchantment .. "|r] -> " .. TradeLog[i].GiveItems[7].ItemLink .. "\n"
			end
			if TradeLog[i].Result == "completed" and (ListMode == "ALL" or ListMode == "TRADE") and next(TradeLog[i].ReceiveItems) and TradeLog[i].ReceiveItems[7] then
				msg = msg .. "    " .. L["|cFFFF4500Provide Enchantment|r: "] .. "\n    [|cFFBA55D3" .. TradeLog[i].ReceiveItems[7].Enchantment .. "|r] -> " .. TradeLog[i].ReceiveItems[7].ItemLink .. "\n"
			end
			if TradeLog[i].Result == "completed" and (ListMode == "ALL" or ListMode == "TRADE") and next(TradeLog[i].ReceiveItems) and not TradeLog[i].ReceiveItems[7] then
				msg = msg .. "    " .. L["|cFFDAA520Receive Item(s)|r: "] .. "\n"
				local j = 1
				for k, v in pairs(TradeLog[i].ReceiveItems) do
					if k ~= 7 then
						msg = msg .. "    [" .. j .. "] " .. v.ItemLink .. " (" .. v.Number .. ")" .. "\n"
						j = j + 1
					end
				end
			elseif TradeLog[i].Result == "received" and (ListMode == "ALL" or ListMode == "MAIL" or ListMode == "RMAIL") and (next(TradeLog[i].ReceiveItems)) then
				msg = msg .. "    " .. L["|cFFDAA520Receive Item(s)|r: "] .. "\n"
				local j = 1
				for k, v in pairs(TradeLog[i].ReceiveItems) do
					msg = msg .. "    [" .. j .. "] " .. v.ItemLink .. " (" .. v.Number .. ")" .. "\n"
					j = j + 1
				end
			end
			if TradeLog[i].Result == "completed" and (ListMode == "ALL" or ListMode == "TRADE") and (next(TradeLog[i].GiveItems)) and not TradeLog[i].GiveItems[7] then
				msg = msg .. "    " .. L["|cFFFF4500Give Item(s)|r: "] .. "\n"
				local j = 1
				for k, v in pairs(TradeLog[i].GiveItems) do
					if k ~= 7 then
						msg = msg .. "    [" .. j .. "] " .. v.ItemLink .. " (" .. v.Number .. ")" .. "\n"
						j = j + 1
					end
				end
			elseif TradeLog[i].Result == "sent" and (ListMode == "ALL" or ListMode == "MAIL" or ListMode == "SMAIL") and (next(TradeLog[i].GiveItems)) then
				msg = msg .. "    " .. L["|cFFFF4500Give Item(s)|r: "] .. "\n"
				local j = 1
				for k, v in pairs(TradeLog[i].GiveItems) do
					msg = msg .. "    [" .. j .. "] " .. v.ItemLink .. " (" .. v.Number .. ")" .. "\n"
					j = j + 1
				end
			end
		end
	end
	Output.export:SetText(msg)
	Output.export:Disable()
end
--保存变量
function Addon:SaveVariables()
	-- 清理临时变量
	Current = {}
	-- 存儲設置和輸出窗口位置
    Config.SetWindowPos[1], _, Config.SetWindowPos[3], Config.SetWindowPos[4], Config.SetWindowPos[5] = SetWindow.background:GetPoint()
	Config.OutputFramePos[1], _, Config.OutputFramePos[3], Config.OutputFramePos[4], Config.OutputFramePos[5] = Output.background:GetPoint()
	-- 将数据存入MailLoggerDB（保存文件）
	MailLoggerDB = {
		["Config"] = {},
		["TradeLog"] = {},
		["IgnoreItems"] = {},
	}
	Addon:UpdateTable(MailLoggerDB.Config, Addon.Config)
	Addon:UpdateTable(MailLoggerDB.TradeLog, Addon.TradeLog)
	Addon:UpdateTable(MailLoggerDB.IgnoreItems, Addon.IgnoreItems)
	if Addon.LDB and Addon.LDBIcon then
		MailLoggerDB.Config.MinimapIconAngle = Addon.MinimapIcon.minimap.minimapPos
	end
end

--Register Events 注册事件
--装载和退出
Frame:RegisterEvent("ADDON_LOADED")
Frame:RegisterEvent("PLAYER_LEAVING_WORLD")
Frame:RegisterEvent("PLAYER_LOGOUT")
Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
--交易相关
Frame:RegisterEvent("MAIL_SHOW")
Frame:RegisterEvent("MAIL_CLOSED")
Frame:RegisterEvent("TRADE_SHOW")
Frame:RegisterEvent("PLAYER_TRADE_MONEY")
Frame:RegisterEvent("TRADE_MONEY_CHANGED")
Frame:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED")
Frame:RegisterEvent("TRADE_TARGET_ITEM_CHANGED")
Frame:RegisterEvent("TRADE_ACCEPT_UPDATE")
Frame:RegisterEvent("MAIL_SEND_INFO_UPDATE")
Frame:RegisterEvent("MAIL_SHOW")
Frame:RegisterEvent("MAIL_CLOSED")
Frame:RegisterEvent("UI_INFO_MESSAGE")
Frame:RegisterEvent("UI_ERROR_MESSAGE")

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
	-- 两种情况，如果没有MailLoggerDB或者MailLoggerDB中某个表不存在，则创建该表，但不用新表覆盖（读取Core中的默认值）
	-- 如果MailLoggerDB及MailLoggerDB中的某个表存在，则用MailLoggerDB中的子表覆盖，避免删不掉现象
	if not MailLoggerDB then
		MailLoggerDB = {}
	end
	if not MailLoggerDB.Config then
		MailLoggerDB.Config = {}
	end
	if not MailLoggerDB.TradeLog then
		MailLoggerDB.TradeLog = {}
	end
	if not MailLoggerDB.IgnoreItems then
		MailLoggerDB.IgnoreItems = {}
	end
	-- 用MailLoggerDB更新config和SpellList表，以及TradeLog表
	Addon:UpdateTable(Config, MailLoggerDB.Config)
	Addon:UpdateTable(TradeLog, MailLoggerDB.TradeLog)
	Addon:UpdateTable(IgnoreItems, MailLoggerDB.IgnoreItems)
	-- 清理过期TradeLog
	if not Config.LogEverything then
		local Today = {}
		Today.year, Today.month, Today.day = strsplit("-", date("%Y-%m-%d"))
		local LogDay = {}
		if #TradeLog > 0 then
			for i = #TradeLog, 1, -1 do
				if TradeLog[i].Date then
					LogDay.year, LogDay.month, LogDay.day = strsplit("-", TradeLog[i].Date)
				else
					t_remove(TradeLog, i)
				end
				if (time(Today) - time(LogDay)) / (3600 * 24) > Config.LogDays then
					t_remove(TradeLog, i)
				end
			end
		end
	end
	if not Config.AltList[(UnitName("player")).."-"..GetRealmName()] then -- 添加名字到列表以便筛选
		Addon.Config.AltList[(UnitName("player")).."-"..GetRealmName()] = true
		if not Config.SelectName then
			Addon.Config.SelectName = (UnitName("player")) .. "-" ..GetRealmName()
		end
	end
	-- 初始化Output和SetWindow和Calendar
    SetWindow:Initialize()
	Output:Initialize()
	Calendar:Initialize()

	print(string.format(L["|cFFBA55D3MailLogger|r v%s|cFFB0C4DE has been loaded.|r"], Addon.Version))

	--[[ 数据格式修复(为不带-的数据添加-)
	if #TradeLog >= 1 then
		for i = 1, #TradeLog do
			if not string.find(TradeLog[i].PlayerName, "%-") then
				TradeLog[i].PlayerName = TradeLog[i].PlayerName .. "-" .. GetRealmName()
			end
			if not string.find(TradeLog[i].TargetName, "%-") then
				TradeLog[i].TargetName = TradeLog[i].TargetName .. "-" .. GetRealmName()
			end
		end
	end]]
end

-- 进入世界
function Frame:PLAYER_ENTERING_WORLD(isLogin, isReload)
	if not isLogin and not isReload then
		return
	end
	if Addon.LDB and Addon.LDBIcon --[[and ((IsAddOnLoaded("TitanClassic")) or (IsAddOnLoaded("Titan")))]] then
		MinimapIcon:InitBroker()
	else
		MinimapIcon:Initialize()
		if Config.ShowMinimapIcon then -- 小地图
			Addon:UpdatePosition(Config.MinimapIconAngle)
			MinimapIcon.Minimap:Show()
		else
			MinimapIcon.Minimap:Hide()
		end
	end
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

-- 退出游戏
function Frame:PLAYER_LEAVING_WORLD()
	Addon:SaveVariables()
end
function Frame:PLAYER_LOGOUT()
	Addon:SaveVariables()
end

-- 交易相关（记录、拒绝恶意交易）
function Frame:TRADE_SHOW()
	-- 阻止小号交易相关功能
	-- 屏蔽外会和团队之外的人交易
	--[[
	if Config.PreventTrade then
		local RequestName, RequestGUID = (UnitName("npc")), UnitGUID("npc")
		local TargetCanTradeMe = false
		if RequestName then
			if (UnitName("target")) == RequestName then
				TargetCanTradeMe = true
			end
			if RequestGUID and not TargetCanTradeMe then
				if IsFriend(RequestGUID) then
					TargetCanTradeMe = true
				end
			end
			if RequestGUID and IsInGuild() and not TargetCanTradeMe then
				if IsGuildMember(RequestGUID) then
					TargetCanTradeMe = true
				end
			end
			if IsInRaid() and not TargetCanTradeMe then
				for i = 1, GetNumGroupMembers() do
					local u = "raid" .. i
					if (UnitName(u)) and (UnitName(u)) == RequestName then
						TargetCanTradeMe = true
						break
					end
				end
			elseif IsInGroup() and not TargetCanTradeMe then
				for i = 1, GetNumGroupMembers() do
					local u = "party" .. i
					if (UnitName(u)) and (UnitName(u)) == RequestName then
						TargetCanTradeMe = true
						break
					end
				end
			end
		end
		if not TargetCanTradeMe then
			CloseTrade()
		end
	end]]
	-- 开始记录合法交易
	if not Config.EnableML then
		return
	end
	-- 戰場關閉
	if select(2, IsInInstance()) == "pvp" or select(2, IsInInstance()) == "arena" then
		return
	end
	Current = Addon:NewTrade()
	t_insert(TradeLog, Addon:NewTrade())
end
-- 交易物品信息更新
function Frame:TRADE_PLAYER_ITEM_CHANGED(Slot)
	if not Config.EnableML then
		return
	end
	if Current and next(Current) then
		Addon:UpdateTradeItemInfo("player", Slot, Current.GiveItems)
	end
end
function Frame:TRADE_TARGET_ITEM_CHANGED(Slot)
	if not Config.EnableML then
		return
	end
	if Current and next(Current) then
		Addon:UpdateTradeItemInfo("target", Slot, Current.ReceiveItems)
	end
end
-- 交易金钱信息更新
function Frame:TRADE_MONEY_CHANGED()
	if not Config.EnableML then
		return
	end
	if Current and next(Current) then
		UpdateTradeMoney()
	end
end
-- 交易接受时更新所有数据
function Frame:TRADE_ACCEPT_UPDATE()
	if not Config.EnableML then
		return
	end
	if Current and next(Current) then
		for i = 1, 7 do
			Addon:UpdateTradeItemInfo("player", i, Current.GiveItems)
			Addon:UpdateTradeItemInfo("target", i, Current.ReceiveItems)
		end
		UpdateTradeMoney()
	end
end

-- 邮件相关（记录、删除无效）
do -- Hook SendMail，获取Recipient
	local function GetRecipient(Recipient, Subject, Body)
		if not Config.EnableML then
			return
		end
		if next(Current) and not Current.TargetName then
			Current.TargetName = Recipient .. "-" .. GetRealmName()
		end
	end
	hooksecurefunc("SendMail", GetRecipient)
end
local function RecordMailItemInfo(Index, ItemSlot) -- 公共方法，獲取郵件物品信息并記錄
	local _, _, Sender, _, _, CODAmount = GetInboxHeaderInfo(Index)
	local ItemName, _, _, Quantity = GetInboxItem(Index, ItemSlot)
	local ItemLink = GetInboxItemLink(Index, ItemSlot)

	if not TradeLog[#TradeLog] or TradeLog[#TradeLog].Result ~= "received" or (TradeLog[#TradeLog].TargetName and TradeLog[#TradeLog].TargetName ~= Sender) or Addon:CompareTime(TradeLog[#TradeLog].Time, 5) then
		if #TradeLog > 0 and TradeLog[#TradeLog] and TradeLog[#TradeLog].Result == "received" and #TradeLog[#TradeLog].ReceiveItems >= 2 then
			for i = #TradeLog[#TradeLog].ReceiveItems, 2, -1 do
				for j = 1, i-1 do
					if TradeLog[#TradeLog].ReceiveItems[i] and TradeLog[#TradeLog].ReceiveItems[j] and TradeLog[#TradeLog].ReceiveItems[i].Name == TradeLog[#TradeLog].ReceiveItems[j].Name and TradeLog[#TradeLog].ReceiveItems[i].ItemLink == TradeLog[#TradeLog].ReceiveItems[j].ItemLink then
						TradeLog[#TradeLog].ReceiveItems[j].Number = TradeLog[#TradeLog].ReceiveItems[i].Number + TradeLog[#TradeLog].ReceiveItems[j].Number
						TradeLog[#TradeLog].ReceiveItems[i] = nil
						break
					end
				end
			end
		end
		t_insert(TradeLog, Addon:NewMail())
	end
	if not TradeLog[#TradeLog].TargetName or not TradeLog[#TradeLog].Result then
		TradeLog[#TradeLog]["TargetName"] = Sender .. "-" .. GetRealmName()
		TradeLog[#TradeLog]["Reason"] = Index
		TradeLog[#TradeLog]["Result"] = "received"
		TradeLog[#TradeLog]["Location"] = GetRealZoneText()
	end
	do
		local TempItem = {
			["Name"] = ItemName,
			["Number"] = Quantity,
			["Enchantment"] = nil,
			["ItemLink"] = ItemLink,
		}
		t_insert(TradeLog[#TradeLog].ReceiveItems, TempItem)
	end
	TradeLog[#TradeLog]["GiveMoney"] = TradeLog[#TradeLog]["GiveMoney"] + CODAmount
	TradeLog[#TradeLog]["Date"] = date("%Y-%m-%d")
	TradeLog[#TradeLog]["Time"] = date("%H:%M:%S")
end
do -- Hook TakeIndexItem，获取邮件取出的邮件及物品信息
	local function GetItemFromMail(MailIndex, ItemIndex)
		if not Config.EnableML then
			return
		end
		RecordMailItemInfo(MailIndex, ItemIndex)
	end
	hooksecurefunc("TakeInboxItem", GetItemFromMail)
end
do -- Hook AutoLootMailItem, 獲取快速收取的郵件信息
	local function GetAutoMailInfo(MailIndex)
		if not Config.EnableML then
			return
		end
		for i = 1, 12 do
			if GetInboxItem(MailIndex, i) then
				RecordMailItemInfo(MailIndex, i)
			end
		end
	end
	hooksecurefunc("AutoLootMailItem", GetAutoMailInfo)
end
do -- Hook TakeIndexMoney，获取邮件取出的金钱信息
	local function GetMoneyFromMail(MailIndex)
		if not Config.EnableML then
			return
		end
		local _, _, Sender, _, Money = GetInboxHeaderInfo(MailIndex)
		if not TradeLog[#TradeLog] or TradeLog[#TradeLog].Result ~= "received" or (TradeLog[#TradeLog].TargetName and TradeLog[#TradeLog].TargetName ~= Sender) or Addon:CompareTime(TradeLog[#TradeLog].Time, 5) then
			t_insert(TradeLog, Addon:NewMail())
		end
		if not TradeLog[#TradeLog].TargetName or not TradeLog[#TradeLog].Result then
			TradeLog[#TradeLog]["TargetName"] = Sender .. "-" .. GetRealmName()
			TradeLog[#TradeLog]["Reason"] = MailIndex
			TradeLog[#TradeLog]["Result"] = "received"
			TradeLog[#TradeLog]["Location"] = GetRealZoneText()
		end
		TradeLog[#TradeLog]["ReceiveMoney"] = TradeLog[#TradeLog]["ReceiveMoney"] + Money
		TradeLog[#TradeLog]["Date"] = date("%Y-%m-%d")
		TradeLog[#TradeLog]["Time"] = date("%H:%M:%S")
	end
	hooksecurefunc("TakeInboxMoney", GetMoneyFromMail)
end
-- 打开邮箱界面
function Frame:MAIL_SHOW()
	if not Config.EnableML then
		return
	end
	Current = Addon:NewMail()
	MailBoxOpened = true
end
-- 记录收件人及邮件附件信息
function Frame:MAIL_SEND_INFO_UPDATE()
	if not Config.EnableML then
		return
	end
	-- 如果CurrentMail为空则需要先创建一个NewMail結構
	if not Current then
		Current = Addon:NewMail()
	end
	for i = 1, 12 do
		local ItemName, _, _, Quantity = GetSendMailItem(i)
		if ItemName then
			Current.GiveItems[i] = {
				["Name"] = ItemName,
				["Number"] = Quantity,
				["Enchantment"] = nil,
				["ItemLink"] = GetSendMailItemLink(i),
			}
		else
			Current.GiveItems[i] = nil
		end
	end
	for i = 12, 2, -1 do
		for j = 1, i-1 do
			if Current.GiveItems[i] and Current.GiveItems[j] and Current.GiveItems[i].Name == Current.GiveItems[j].Name and Current.GiveItems[i].ItemLink == Current.GiveItems[j].ItemLink then
				Current.GiveItems[j].Number = Current.GiveItems[i].Number + Current.GiveItems[j].Number
				Current.GiveItems[i] = nil
				break
			end
		end
	end
end
-- 关闭邮箱界面
function Frame:MAIL_CLOSED()
	if not Config.EnableML then
		return
	end
	Current = {}
	MailBoxOpened = false
	if #TradeLog > 0 and TradeLog[#TradeLog] and TradeLog[#TradeLog].Result == "received" and #TradeLog[#TradeLog].ReceiveItems >= 2 then
		for i = #TradeLog[#TradeLog].ReceiveItems, 2, -1 do
			for j = 1, i-1 do
				if TradeLog[#TradeLog].ReceiveItems[i] and TradeLog[#TradeLog].ReceiveItems[j] and TradeLog[#TradeLog].ReceiveItems[i].Name == TradeLog[#TradeLog].ReceiveItems[j].Name and TradeLog[#TradeLog].ReceiveItems[i].ItemLink == TradeLog[#TradeLog].ReceiveItems[j].ItemLink then
					TradeLog[#TradeLog].ReceiveItems[j].Number = TradeLog[#TradeLog].ReceiveItems[i].Number + TradeLog[#TradeLog].ReceiveItems[j].Number
					TradeLog[#TradeLog].ReceiveItems[i] = nil
					break
				end
			end
		end
	end
end
-- 交易失败通报
function Frame:UI_ERROR_MESSAGE(...)
	if not Config.EnableML then
		return
	end
	local arg = {...}
	if Current and next(Current) then
		if arg[2] == ERR_TRADE_BAG_FULL or arg[2] == ERR_TRADE_MAX_COUNT_EXCEEDED or arg[2] == ERR_TRADE_TARGET_BAG_FULL or arg[2] == ERR_TRADE_TARGET_MAX_COUNT_EXCEEDED or arg[2] == ERR_TRADE_TARGET_DEAD or arg[2] == ERR_TRADE_TOO_FAR then
			Current.Result = "error"
			Current.Reason = arg[2]
			if Config.EnableWhisper or Config.SendToPublic then
				Addon:AnnounceTrade()
			end
		elseif arg[2] == ERR_MAIL_TARGET_NOT_FOUND and MailBoxOpened then
			Current.TargetName = nil
		elseif (arg[2] == ERR_ITEM_MAX_COUNT or arg[2] == ERR_INV_FULL) and MailBoxOpened then
			t_remove(TradeLog[#TradeLog].ReceiveItems, #TradeLog[#TradeLog].ReceiveItems)
		end
	end
end
-- 交易/邮件通报和记录
function Frame:UI_INFO_MESSAGE(...)
	if not Config.EnableML then
		return
	end
	local arg = {...}
	if Current and next(Current) then
		if arg[2] == ERR_TRADE_CANCELLED then
			Current.Result = "cancelled"
			Current.Reason = arg[2]
			if Config.EnableWhisper or Config.SendToPublic then
				Addon:AnnounceTrade()
			end
			Current = {}
		elseif arg[2] == ERR_TRADE_COMPLETE then
			Current.Result = "completed"
			if Current.GiveItems[7] and Current.GiveItems[7].Name and not Current.GiveItems[7].Enchantment then
				Current.GiveItems[7] = nil
			end
			if Current.ReceiveItems[7] and Current.ReceiveItems[7].Name and not Current.ReceiveItems[7].Enchantment then
				Current.ReceiveItems[7] = nil
			end
			if Current.GiveMoney == 0 and Current.ReceiveMoney == 0 and not (next(Current.GiveItems)) and not (next(Current.ReceiveItems)) then
				return
			else
				Addon:AnnounceTrade()
				if not (select(2, IsInInstance()) == "pvp" or select(2, IsInInstance()) == "arena") then
					t_insert(TradeLog, Current)
				end
			end
			Current = {}
		elseif arg[2] == ERR_MAIL_SENT then
			local Money = GetSendMailMoney()
			if Money > 0 then
				Current["GiveMoney"] = Money
			end
			if Current.GiveMoney > 0 or (next(Current.GiveItems)) then
				if #TradeLog > 0 and TradeLog[#TradeLog] and TradeLog[#TradeLog].Result == "received" and #TradeLog[#TradeLog].ReceiveItems >= 2 then
					for i = #TradeLog[#TradeLog].ReceiveItems, 2, -1 do
						for j = 1, i-1 do
							if TradeLog[#TradeLog].ReceiveItems[i] and TradeLog[#TradeLog].ReceiveItems[j] and TradeLog[#TradeLog].ReceiveItems[i].Name == TradeLog[#TradeLog].ReceiveItems[j].Name and TradeLog[#TradeLog].ReceiveItems[i].ItemLink == TradeLog[#TradeLog].ReceiveItems[j].ItemLink then
								TradeLog[#TradeLog].ReceiveItems[j].Number = TradeLog[#TradeLog].ReceiveItems[i].Number + TradeLog[#TradeLog].ReceiveItems[j].Number
								TradeLog[#TradeLog].ReceiveItems[i] = nil
								break
							end
						end
					end
				end
				Current["Result"] = "sent"
				Current["Date"] = date("%Y-%m-%d")
				Current["Time"] = date("%H:%M:%S")
				Current["Location"] = GetRealZoneText()
				t_insert(TradeLog, Current)
				Current = {}
				Current = Addon:NewMail()
			end
		end
	end
end
