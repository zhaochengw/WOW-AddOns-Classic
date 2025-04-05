-- 缓存常用函数以提升性能
local _G = _G
local myName = UnitName("player")
local myRace = UnitRace("player")
local normal = NORMAL_FONT_COLOR
local green = GREEN_FONT_COLOR
local white = HIGHLIGHT_FONT_COLOR
local defColor = FRIENDS_WOW_NAME_COLOR_CODE

local BC = {}
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do BC[v] = k end

local function colorString(string, class)
	local color = class and RAID_CLASS_COLORS[class] or GetQuestDifficultyColor(tonumber(string) or 1)
	return ("%s%s|r"):format(ConvertRGBtoColorString(color), string)
end

local function guildRankColor(index)
	local r, g, b = 1, 1, 1
	local pct = index / GuildControlGetNumRanks()
	if pct <= 1.0 and pct >= 0.5 then
		r, g, b = (1.0-pct)*2, 1, 0
	elseif pct >= 0 and pct < 0.5 then
		r, g, b = 1, pct*2, 0
	end
	return r, g, b
end

hooksecurefunc("GuildStatus_Update", function()
	local guildOffset = FauxScrollFrame_GetOffset(GuildListScrollFrame)
	local myZone = GetRealZoneText()
	local name, rankIndex, level, zone, online, classFileName
	local color, zcolor, lcolor, r, g, b

	for i=1, GUILDMEMBERS_TO_DISPLAY, 1 do
		name, _, rankIndex, level, _, zone, _, _, online, _, classFileName = GetGuildRosterInfo(guildOffset + i)
		if not name then break end

		color = RAID_CLASS_COLORS[classFileName] or normal
		zcolor = zone == myZone and green or white
		lcolor = GetQuestDifficultyColor(level) or white
		r, g, b = guildRankColor(rankIndex)

		if online then
			_G["GuildFrameButton"..i.."Name"]:SetTextColor(color.r, color.g, color.b)
			_G["GuildFrameButton"..i.."Zone"]:SetTextColor(zcolor.r, zcolor.g, zcolor.b)
			_G["GuildFrameButton"..i.."Level"]:SetTextColor(lcolor.r, lcolor.g, lcolor.b)
			_G["GuildFrameButton"..i.."Class"]:SetTextColor(color.r, color.g, color.b)
			_G["GuildFrameGuildStatusButton"..i.."Name"]:SetTextColor(color.r, color.g, color.b)
			_G["GuildFrameGuildStatusButton"..i.."Rank"]:SetTextColor(r, g, b)
		else
			_G["GuildFrameButton"..i.."Name"]:SetTextColor(color.r/2, color.g/2, color.b/2)
			_G["GuildFrameButton"..i.."Zone"]:SetTextColor(zcolor.r/2, zcolor.g/2, zcolor.b/2)
			_G["GuildFrameButton"..i.."Level"]:SetTextColor(lcolor.r/2, lcolor.g/2, lcolor.b/2)
			_G["GuildFrameButton"..i.."Class"]:SetTextColor(color.r/2, color.g/2, color.b/2)
			_G["GuildFrameGuildStatusButton"..i.."Name"]:SetTextColor(color.r/2, color.g/2, color.b/2)
			_G["GuildFrameGuildStatusButton"..i.."Rank"]:SetTextColor(r/2, g/2, b/2)
		end
	end
end)

-- 更新好友列表相关代码
local function updateFriends(button)
    local nameText,infoText
    if button:IsShown() then
        local myZone = GetRealZoneText()
        if button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
            -- 使用新的 BNet API
            local accountInfo = C_BattleNet.GetFriendAccountInfo(button.id)
            if accountInfo and accountInfo.gameAccountInfo and accountInfo.gameAccountInfo.isOnline and accountInfo.gameAccountInfo.clientProgram == BNET_CLIENT_WOW then
                local gameAccountInfo = accountInfo.gameAccountInfo
                if accountInfo.accountName and gameAccountInfo.characterName then
                    local level = colorString(gameAccountInfo.characterLevel)
                    local toonName = colorString(gameAccountInfo.characterName, BC[gameAccountInfo.className])
                    nameText = accountInfo.accountName .. " " .. defColor .. "(Lv" .. level .. " " .. toonName .. defColor .. ")"
                end
                if gameAccountInfo.areaName and gameAccountInfo.areaName == myZone then 
                    infoText = format("|cff00ff00%s|r", gameAccountInfo.areaName) 
                end
            end
        end
        -- print(button.index,button.id,button.buttonType)
        if button.buttonType == FRIENDS_BUTTON_TYPE_BNET then	-- 战网
            local _, presenceName, _, _, _, toonID, client, isOnline = BNGetFriendInfo(button.id)
            if isOnline and client == BNET_CLIENT_WOW then
                local _, toonName, _, _, _, _, _, class, _, zoneName, level = BNGetGameAccountInfo(toonID)
                if presenceName and toonName then
                    level = colorString(level)
                    toonName = colorString(toonName, BC[class])
                    nameText = presenceName .. " " .. defColor .. "(Lv" .. level .. " " .. toonName .. defColor .. ")"
                end
                if zoneName and zoneName == myZone then infoText = format("|cff00ff00%s|r", zoneName) end
            end
        elseif button.buttonType == FRIENDS_BUTTON_TYPE_WOW then		-- 游戏好友
            local info = C_FriendList.GetFriendInfoByIndex(button.id)
            if info and info.connected then
                local name = colorString(info.name, BC[info.className])
                local level = colorString(info.level)
                local class = colorString(info.className, BC[info.className])
                nameText = name .. ", Lv" .. level .. "  " .. class
                if info.area and info.area == myZone then infoText = format("|cff00ff00%s|r", info.area) end
            end
        end
    end
    if nameText then button.name:SetText(nameText) end
    if infoText then button.info:SetText(infoText) end
end
hooksecurefunc("FriendsFrame_UpdateFriendButton", updateFriends)

hooksecurefunc("WhoList_Update", function()
	local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame)
	local menu = WhoFrameDropDown and UIDropDownMenu_GetSelectedID(WhoFrameDropDown) or 1
	local myZone = GetRealZoneText()
	local myGuild = GetGuildInfo("player")
	local myInfo = { myZone, myGuild, myRace }

	for i = 1, WHOS_TO_DISPLAY, 1 do
		local info = C_FriendList.GetWhoInfo(whoOffset + i)
		if not info then break end
		local guild, level, race, zone, class = info.fullGuildName, info.level, info.raceStr, info.area, info.filename
		local color = class and RAID_CLASS_COLORS[class] or normal
		_G["WhoFrameButton"..i.."Name"]:SetTextColor(color.r, color.g, color.b)
		color = level and GetQuestDifficultyColor(level) or white
		_G["WhoFrameButton"..i.."Level"]:SetTextColor(color.r, color.g, color.b)
		_G["WhoFrameButton"..i.."Level"]:SetFont(_G["WhoFrameButton"..i.."Level"]:GetFont(), 13)
		local columnTable = { zone, guild, race }
		color = columnTable[menu] == myInfo[menu] and green or white
		_G["WhoFrameButton"..i.."Variable"]:SetTextColor(color.r, color.g, color.b)
	end
end)

-- 优化战场记分板更新
hooksecurefunc("WorldStateScoreFrame_Update", function()
    local scrollOffset = FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame)
    
    for i = 1, 22 do
        local scoreButton = _G["WorldStateScoreButton"..i]
        if scoreButton and scoreButton.name and scoreButton.name.text then
            -- 使用新的战场API
            local scoringData = C_PvP.GetScoreInfo(scrollOffset + i)
            if scoringData then
                local name = scoringData.name
                local faction = scoringData.faction
                local classToken = scoringData.classToken
                if name and faction and classToken then
                    local n, s = strsplit("-", name, 2)
                    n = colorString(n, classToken)
                    if n == myName then
                        n = "> " .. n .. " <"
                    end
                    if s then
                        n = n.."|cffffffff - |r"..(faction==0 and "|cffff2020" or "|cff00aef0")..s.."|r"
                    end
                    scoreButton.name.text:SetText(n)
                end
            end
        end
    end
end)