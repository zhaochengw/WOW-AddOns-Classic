local myName = UnitName("player")
local myRace = UnitRace("player")
local normal = NORMAL_FONT_COLOR
local green = GREEN_FONT_COLOR
local white = HIGHLIGHT_FONT_COLOR
local defColor = FRIENDS_WOW_NAME_COLOR_CODE
local _G = _G

local BC = {}
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do BC[v] = k end
for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do BC[v] = k end

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
---------------------------------------------------------------------------------------------------------

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

	for i = 1, #buttons do
		local nameText, infoText
		local button = buttons[i]
		if button:IsShown() then
			if button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
				local info = C_FriendList.GetFriendInfoByIndex(button.id)
				if info and info.connected then
					local name = colorString(info.name, BC[info.className])
					local level = colorString(info.level)
					local class = colorString(info.className, BC[info.className])
					nameText = name .. ", Lv" .. level .. "  " .. class
					if info.area and info.area == myZone then infoText = format("|cff00ff00%s|r", info.area) end
				end
			elseif button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
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
			end
		end
		if nameText then button.name:SetText(nameText) end
		if infoText then button.info:SetText(infoText) end
	end
end

hooksecurefunc(FriendsFrameFriendsScrollFrame, "update", updateFriends)
hooksecurefunc("FriendsFrame_UpdateFriends", updateFriends)

hooksecurefunc("WhoList_Update", function()
  local whoDropdown = _G["WhoFrameDropdown"]
  if whoDropdown then
	local updater = whoDropdown.UpdateSelections or whoDropdown.Update
	if type(updater) == "function" then pcall(function() updater(whoDropdown) end) end
	local menuIndex = 1
	local text = (whoDropdown.GetText and whoDropdown:GetText()) or whoDropdown.text
	if text then
	  if text:find("地区") then menuIndex = 1
	  elseif text:find("公会") then menuIndex = 2
	  elseif text:find("种族") then menuIndex = 3 end
	end
	local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame)
	local myInfo = { GetRealZoneText(), GetGuildInfo("player"), UnitRace("player") }
	for i = 1, WHOS_TO_DISPLAY do
	  local info = C_FriendList.GetWhoInfo(whoOffset + i)
	  if not info then break end
	  local columnTable = { info.area, info.fullGuildName, info.raceStr }
	  local nameColor = info.filename and RAID_CLASS_COLORS[info.filename] or normal
	  _G["WhoFrameButton"..i.."Name"]:SetTextColor(nameColor.r, nameColor.g, nameColor.b)
	  local levelColor = info.level and GetQuestDifficultyColor(info.level) or white
	  _G["WhoFrameButton"..i.."Level"]:SetTextColor(levelColor.r, levelColor.g, levelColor.b)
	  _G["WhoFrameButton"..i.."Level"]:SetFont(_G["WhoFrameButton"..i.."Level"]:GetFont(), 13)
	  local variableColor = columnTable[menuIndex] == myInfo[menuIndex] and green or white
	  _G["WhoFrameButton"..i.."Variable"]:SetTextColor(variableColor.r, variableColor.g, variableColor.b)
	end
  end
end)

hooksecurefunc("WorldStateScoreFrame_Update", function()
	local isArena = IsActiveBattlefieldArena()
	local scrollOffset = FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame)

	for i = 1, MAX_WORLDSTATE_SCORE_BUTTONS do
		local scoreButton = _G["WorldStateScoreButton"..i]
		local name, _, _, _, _, faction, _, _, classToken = GetBattlefieldScore(scrollOffset + i)
		if name and faction and classToken then
			local n, s = strsplit("-", name, 2)
			n = colorString(n, classToken)
			if n == myName then
				n = "> " .. n .. " <"
			end
			if s then
				if isArena then
					n = n.."|cffffffff - |r"..(faction==0 and "|cff20ff20" or "|cffffd200")..s.."|r"
				else
					n = n.."|cffffffff - |r"..(faction==0 and "|cffff2020" or "|cff00aef0")..s.."|r"
				end
			end
			scoreButton.name.text:SetText(n)
		end
	end
end)