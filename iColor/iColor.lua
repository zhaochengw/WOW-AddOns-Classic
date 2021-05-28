local myName = UnitName("player")
local myRace = UnitRace("player")
local normal = NORMAL_FONT_COLOR
local green = GREEN_FONT_COLOR
local white = HIGHLIGHT_FONT_COLOR
local defColor = FRIENDS_WOW_NAME_COLOR_CODE
local _G = _G
local MAX_SCORE_BUTTONS = MAX_SCORE_BUTTONS or 22

local BC = {}
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do BC[v] = k end
for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do BC[v] = k end

BC["NEW"] = "NEW"
RAID_CLASS_COLORS["NEW"] = CreateColor(0, 1, 0.9647, 1)
-- RAID_CLASS_COLORS["NEW"].colorStr = RAID_CLASS_COLORS["NEW"]:GenerateHexColor()

local function colorString(string, class)
	local color = class and RAID_CLASS_COLORS[class] or GetQuestDifficultyColor(string)
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

local function updateFriends()
	local buttons = FriendsFrameFriendsScrollFrame.buttons
	local myZone = GetRealZoneText()
	local myRealm = GetRealmID()

	for i = 1, #buttons do
		local nameText, infoText
		local button = buttons[i]
		if button:IsShown() then
			if button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
				local info = C_FriendList.GetFriendInfoByIndex(button.id)
				if info and info.connected then
					if info.name and info.name ~= "" and info.level and info.level ~= "" then
						local name = colorString(info.name, BC[info.className])
						local level = colorString(info.level)
						-- local class = colorString(info.className, BC[info.className])
						nameText = name .. " (" .. level .. ")"
					end
					if info.area and info.area == myZone then infoText = format("|cff00ff00%s|r", info.area) end
				end
			elseif button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
				local _, presenceName, _, _, _, toonID, client, isOnline = BNGetFriendInfo(button.id)
				if isOnline and client == BNET_CLIENT_WOW then
					local _, toonName, _, realm, realmID, faction, race, class, _, zoneName, level, gameText = BNGetGameAccountInfo(toonID)
					if presenceName and presenceName ~= "" and toonName and toonName ~= "" and level and level ~= "" and class and class ~= "" then
						level = colorString(level)
						if BC[class] then
							toonName = colorString(toonName, BC[class])
						else
							toonName = colorString(toonName, BC["NEW"])
						end
						nameText = presenceName .. defColor .. " (" .. toonName .. defColor .. " " .. level .. defColor .. ")"
					end
					if gameText and gameText == BNET_FRIEND_TOOLTIP_WOW_CLASSIC then
						if zoneName and zoneName == myZone and realmID and myRealm == realmID then
							infoText = "\124Tinterface\\worldstateframe\\" .. strlower(faction) .. "icon:20\124t" .. string.gsub(EXPANSION_NAME0, "\n", "") .. " " .. format("|cff00ff00%s|r", zoneName) .. " - " .. (format("|cff00ff00%s|r", realm) or UNKNOWN)
						elseif realmID and myRealm == realmID then
							infoText = "\124Tinterface\\worldstateframe\\" .. strlower(faction) .. "icon:20\124t" .. string.gsub(EXPANSION_NAME0, "\n", "") .. " " .. (zoneName or UNKNOWN) .. " - " .. (format("|cff00ff00%s|r", realm) or UNKNOWN)
						else
							infoText = "\124Tinterface\\worldstateframe\\" .. strlower(faction) .. "icon:20\124t" .. string.gsub(EXPANSION_NAME0, "\n", "") .. " " .. (zoneName or UNKNOWN) .. " - " .. (realm or UNKNOWN)
						end
					else
						if faction and faction ~= "" then
							infoText = "\124Tinterface\\worldstateframe\\" .. strlower(faction) .. "icon:20\124t" .. (gameText or UNKNOWN)
						else
							infoText = (gameText or UNKNOWN)
						end
					end
				end
			end
		end
		if nameText then button.name:SetText(nameText) end
		if infoText then button.info:SetText(infoText) end
	end
end

hooksecurefunc(FriendsFrameFriendsScrollFrame, "update", updateFriends)
hooksecurefunc("FriendsFrame_UpdateFriends", updateFriends)

hooksecurefunc("WhoList_Update", function()
	local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame)
	local menu = UIDropDownMenu_GetSelectedID(WhoFrameDropDown)
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

hooksecurefunc("WorldStateScoreFrame_Update", function()
	-- local isArena = IsActiveBattlefieldArena()
	local scrollOffset = FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame)

	for i = 1, MAX_SCORE_BUTTONS do
		local scoreButton = _G["WorldStateScoreButton"..i]
		local name, _, _, _, _, faction, _, _, _, classToken = GetBattlefieldScore(scrollOffset + i)
		if name and faction and classToken then
			local n, s = strsplit("-", name, 2)
			n = colorString(n, classToken)
			if n == myName then
				n = "> " .. n .. " <"
			end
			if s then
				-- if isArena then
				-- 	n = n.."|cffffffff - |r"..(faction==0 and "|cff20ff20" or "|cffffd200")..s.."|r"
				-- else
				-- 	n = n.."|cffffffff - |r"..(faction==0 and "|cffff2020" or "|cff00aef0")..s.."|r"
				-- end
				n = n.."|cffffffff - |r"..(faction==0 and "|cffff2020" or "|cff00aef0")..s.."|r"
			end
			scoreButton.name.text:SetText(n)
		end
	end
end)
