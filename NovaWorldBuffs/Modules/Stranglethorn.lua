-------------------
---NovaWorldBuffs--
-------------------

local addonName, addon = ...;
local NWB = addon.a;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");
local calcStart, lastSendGuild, lastSendGuild30, lastSendPersonal, lastBossMsg = 0, 0, 0, 0, 0;
local isBossShown;
local bossCache = {};
local lastSeenBoss = 0;

SLASH_NWBASTVCMD1 = '/stv';
function SlashCmdList.NWBASTVCMD(msg, editBox)
	WorldMapFrame:Show();
	WorldMapFrame:SetMapID(1434);
end

--These times are adjusted if DST is active in the getTimeLeft() func.
local isUS;
local region = GetCurrentRegion();
if (region == 1 and string.match(NWB.realm, "(AU)")) then
	--OCE.
	calcStart = 1707264000; --Date and time (GMT): Wednesday, February 7, 2024 12:00:00 AM
elseif (region == 1) then
	--US.
	isUS = true;
	calcStart = 1707264000; --Date and time (GMT):Wednesday, February 7, 2024 12:00:00 AM; --OCE and US different.
elseif (region == 2) then
	--Korea.
	calcStart = 1707256800; --Date and time (GMT): Tuesday, February 6, 2024 10:00:00 PM --KR starts 1h before OCE/US.
elseif (region == 3) then
	--EU.
	calcStart = 1707220800; --Date and time (GMT): Tuesday, February 6, 2024 12:00:00 PM
elseif (region == 4) then
	--Taiwan.
	calcStart = 1707260400; --TW same as OCE/US.
elseif (region == 5) then
	--China.
	calcStart = 1707260400; --CN same as OCE/US.
end
calcStart = calcStart - 3600; --Stv runs 1 hour before ashenvale.

local function getTimeLeft()
	local timeLeft, type;
	if (calcStart) then
		local start = calcStart;
		local isDST = NWB:isDST();
		if (isDST) then
			if (isUS) then
				start = start + 3600;
			else
				start = start - 3600;
			end
		end
		local utc = GetServerTime();
		local secondsSinceFirstReset = utc - start;
		local timestamp = start + ((math.floor(secondsSinceFirstReset / 10800) + 1) * 10800);
		local timeLeft = timestamp - utc;
		local realTimeLeft = timeLeft;
		if (timeLeft > 9000) then
			--If more than 2.5h left then it's running, return tim left on current event instead.
			type = "running";
			timeLeft = timeLeft - 9000;
			timestamp = timestamp - 9000;
			NWB.stvRunning = true;
		else
			if (isBossShown) then
				NWB:updateStvBoss(nil, nil, nil, true);
				isBossShown = nil;
			end
			NWB.stvRunning = false;
		end
		return timeLeft, type, timestamp, realTimeLeft;
	end
end

function NWB:getStranglethornTimeString(isShort, veryShort)
	local text;
	local timeLeft, type, timestamp, realTimeLeft = getTimeLeft();
	if (timeLeft) then
		local timeString = NWB:getTimeString(timeLeft, true, "short");
		if (veryShort) then
			if (type == "running") then
				--For the overlay we don't show it running, so add the time until next start.
				timeString = NWB:getTimeString(timeLeft + 9000, true, "short");
			end
			--if (type == "running") then
			--	text = "|cFF00C800" .. L["Stranglethorn"] .. ": |cFF9CD6DE" .. timeString .. "|r" .. "|r |cFF9CD6DE" .. L["remaining"] .. "|r";
			--else
				text = L["Stranglethorn"] .. ": |cFF9CD6DE" .. timeString .. "|r";
			--end
		elseif (isShort) then
			if (type == "running") then
				text = "|cFF00C800" .. string.format(L["stranglethornEventRunning"], "|cFF9CD6DE" .. timeString .. "|r") .. "|r |cFF9CD6DE" .. L["remaining"] .. "|r";
			else
				text = string.format(L["startsIn"], "|cFF9CD6DE" .. timeString .. "|r");
			end
		else
			if (type == "running") then
				text = "|cFF00C800" .. string.format(L["stranglethornEventRunning"], "|cFF9CD6DE" .. timeString .. "|r") .. "|r |cFF9CD6DE" .. L["remaining"] .. "|r";
			else
				text = string.format(L["stranglethornEventStartsIn"], "|cFF9CD6DE" .. timeString .. "|r");
			end
		end
	end
	return text, timeLeft, timestamp, realTimeLeft, type;
end

function NWB:addStranglethornMinimapString(tooltip, noTopSeperator, noBottomSeperator)
	if (not NWB.isSOD) then
		return;
	end
	local text, timeLeft, timestamp = NWB:getStranglethornTimeString();
	if (not text) then
		return;
	end
	--Check if previous line is a seperator so we don't double up.
	if (_G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()] and _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()]:GetText() ~= " "
			and not noTopSeperator) then
		tooltip:AddLine(" ");
		if (not tooltip.NWBSeparator9) then
		    tooltip.NWBSeparator9 = tooltip:CreateTexture(nil, "BORDER");
		    tooltip.NWBSeparator9:SetColorTexture(0.6, 0.6, 0.6, 0.85);
		    tooltip.NWBSeparator9:SetHeight(1);
		    tooltip.NWBSeparator9:SetPoint("LEFT", 10, 0);
		    tooltip.NWBSeparator9:SetPoint("RIGHT", -10, 0);
		end
		tooltip.NWBSeparator9:SetPoint("TOP", _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()], "CENTER");
		tooltip.NWBSeparator9:Show();
	end
	local dateString = "";
	if (IsShiftKeyDown()) then
		if (NWB.db.global.timeStampFormat == 12) then
			dateString = " (" .. date("%A", timestamp) .. " " .. gsub(date("%I:%M", timestamp), "^0", "")
					.. string.lower(date("%p", timestamp)) .. ")";
		else
			dateString = " (" .. date("%A %H:%M", timestamp) .. ")";
		end
	end
	tooltip:AddLine(text .. dateString);
	if (not noBottomSeperator) then
		tooltip:AddLine(" ");
		if (not tooltip.NWBSeparator10) then
		    tooltip.NWBSeparator10 = tooltip:CreateTexture(nil, "BORDER");
		    tooltip.NWBSeparator10:SetColorTexture(0.6, 0.6, 0.6, 0.85);
		    tooltip.NWBSeparator10:SetHeight(1);
		    tooltip.NWBSeparator10:SetPoint("LEFT", 10, 0);
		    tooltip.NWBSeparator10:SetPoint("RIGHT", -10, 0);
		end
		tooltip.NWBSeparator10:SetPoint("TOP", _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()], "CENTER");
		tooltip.NWBSeparator10:Show();
	end
	return true;
end

function NWB:checkStranglethornTimer()
	local _, _, _, realTimeLeft = getTimeLeft();
	if (realTimeLeft <= 900 and realTimeLeft >= 899 and GetTime() - lastSendGuild > 900) then
		lastSendGuild = GetTime();
		if (NWB.db.global.guild10) then
			local msg = string.format(L["stranglethornStartSoon"], "15 " .. L["minutes"]) .. ".";
			if (IsInGuild()) then
				if (isUS) then
					NWB:sendGuildMsg(msg, "guild10", nil, "[NWB]", 2.69);
				else
					NWB:sendGuildMsg(msg, "guild10", nil, "[NWB]", 2.67);
				end
			else
				NWB:print(msg, nil, "[NWB]");
			end
		end
	end
	if (realTimeLeft <= 1800 and realTimeLeft >= 1799 and GetTime() - lastSendGuild30 > 900) then
		lastSendGuild30 = GetTime();
		local msg = string.format(L["stranglethornStartSoon"], "30 " .. L["minutes"]) .. ".";
		--Just tie it to guild10 settings.
		if (NWB.db.global.guild10) then
			if (IsInGuild()) then
				if (isUS) then
					NWB:sendGuildMsg(msg, "guild10", nil, "[NWB]", 2.69);
				else
					NWB:sendGuildMsg(msg, "guild10", nil, "[NWB]", 2.68);
				end
			else
				NWB:print(msg, nil, "[NWB]");
			end
		end
		if (NWB.db.global.sodMiddleScreenWarning) then
			local colorTable = {r = self.db.global.middleColorR, g = self.db.global.middleColorG, b = self.db.global.middleColorB, id = 41, sticky = 0};
			RaidNotice_AddMessage(RaidWarningFrame, NWB:stripColors(msg), colorTable, 5);
		end
	end
end

local mapMarkerTypes;
if (NWB.isSOD) then
	mapMarkerTypes = {
		["Alliance"] = {x = 78, y = 90, mapID = 1434, icon = "Interface\\worldstateframe\\alliancetower.blp"},
		["Horde"] = {x = 83, y = 90, mapID = 1434, icon = "Interface\\worldstateframe\\hordetower.blp"},
	};
end

--Update timers for worldmap when the map is open.
function NWB:updateStranglethornMarkers(type)
	local text = NWB:getStranglethornTimeString(true);
	_G["AllianceNWBStranglethornMap"].timerFrame.fs:SetText("|cFFFFFF00" .. text);
end

local function createStranglethornMarkers()
	if (not mapMarkerTypes) then
		return;
	end
	for k, v in pairs(mapMarkerTypes) do
		NWB:createStranglethornMarker(k, v);
	end
	NWB:createStranglethornBossMarker();
	NWB:refreshStranglethornMarkers();
end

function NWB:createStranglethornMarker(type, data)
	if (not NWB.isSOD) then
		return;
	end
	if (not _G[type .. "NWBStranglethornMap"]) then
		--Worldmap marker.
		local obj = CreateFrame("Frame", type .. "NWBStranglethornMap", WorldMapFrame);
		local bg = obj:CreateTexture(nil, "ARTWORK");
		bg:SetTexture(data.icon);
		bg:SetTexCoord(0.1, 0.6, 0.1, 0.6);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(20, 20);
		obj.fsTitle = obj:CreateFontString(type .. "NWBStranglethornBuffCmdFSTitle", "ARTWORK");
		obj.fsTitle:SetPoint("TOP", 27, 22);
		obj.fsTitle:SetFont("Fonts\\FRIZQT__.ttf", 14, "OUTLINE");
		--obj.fsTitle:SetFontObject(NumberFont_Outline_Med);
		obj.fsBottom = obj:CreateFontString(type .. "NWBStranglethornBuffCmdFSBottom", "ARTWORK");
		obj.fsBottom:SetPoint("BOTTOM", 28, -45);
		obj.fsBottom:SetFont("Fonts\\FRIZQT__.ttf", 14, "OUTLINE");
		obj.tooltip = CreateFrame("Frame", type .. "NWBStranglethornDailyMapTextTooltip", obj, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("BOTTOM", obj, "TOP", 0, 35);
		--obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -26);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9999);
		obj.tooltip.fs = obj.tooltip:CreateFontString("NWBStranglethornDailyMapTextTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 14);
		obj.tooltip.fs:SetJustifyH("LEFT")
		obj.tooltip.fs:SetText(L["Stranglethorn PvP Event"]);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		obj.tooltip:Hide();
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		--New version we don't need resource frames for both factions, just attach timer string to alliance and move it to sit in the middle of both.
		if (type == "Alliance") then
			_G["AllianceNWBStranglethornMap"].fsTitle:SetText("|cFFFFFF00" .. L["Stranglethorn"]);
			--Timer frame that sits above the icon when an active timer is found.
			obj.timerFrame = CreateFrame("Frame", type .. "StranglethornTimerFrame", obj, "TooltipBorderedFrameTemplate");
			obj.timerFrame:SetPoint("CENTER", obj, "CENTER",  26, -23);
			obj.timerFrame:SetFrameStrata("FULLSCREEN");
			obj.timerFrame:SetFrameLevel(9);
			obj.timerFrame.fs = obj.timerFrame:CreateFontString(type .. "NWBStranglethornTimerFrameFS", "ARTWORK");
			obj.timerFrame.fs:SetPoint("CENTER", 0, 0);
			obj.timerFrame.fs:SetFont("Fonts\\FRIZQT__.ttf", 13);
			obj.timerFrame:SetWidth(54);
			obj.timerFrame:SetHeight(24);
			obj.lastUpdate = 0;
			obj.resetType = L["Stranglethorn Towers"];
			obj:SetScript("OnUpdate", function(self)
				--Update timer when map is open.
				if (GetServerTime() - obj.lastUpdate > 0) then
					obj.lastUpdate = GetServerTime();
					NWB:updateStranglethornMarkers(type);
					obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 18);
					obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 12);
				end
			end)
			obj.timerFrame:SetScript("OnEnter", function(self)
				obj.tooltip:Show();
			end)
			obj.timerFrame:SetScript("OnLeave", function(self)
				obj.tooltip:Hide();
			end)
			--Make it act like pin is the parent and not WorldMapFrame.
			obj:SetScript("OnHide", function(self)
				obj.timerFrame:Hide();
			end)
			obj:SetScript("OnShow", function(self)
				obj.timerFrame:Show();
			end)
		end
		NWB.extraMapMarkers[obj:GetName()] = true;
	end
end

function NWB:createStranglethornBossMarker()
	if (not NWB.isSOD) then
		return;
	end
	if (not _G["NWBStranglethornBoss"]) then
		--Worldmap marker.
		local obj = CreateFrame("Frame", "NWBStranglethornBoss", WorldMapFrame);
		local bg = obj:CreateTexture(nil, "ARTWORK");
		bg:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_8");
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(20, 20);
		obj.fs = obj:CreateFontString("NWBStranglethornBossFS", "ARTWORK");
		obj.fs:SetPoint("TOP", obj, "BOTTOM", 0, 0);
		obj.fs:SetFont("Fonts\\FRIZQT__.ttf", 14, "OUTLINE");
		obj.fs:SetText("|cFFFFFF00" .. L["Boss"]);
		obj.tooltip = CreateFrame("Frame", "NWBStranglethornBossTooltip", obj, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("BOTTOM", obj, "TOP", 0, 10);
		--obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -26);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9999);
		obj.tooltip.fs = obj.tooltip:CreateFontString("NWBStranglethornBossTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 14);
		obj.tooltip.fs:SetJustifyH("LEFT")
		obj.tooltip.fs:SetText("|cFFFFFF00" .. L["stvBossMarkerTooltip"]);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		obj.tooltip:Hide();
		obj:SetScript("OnEnter", function(self)
			obj.tooltip.fs:SetText("|cFFFFFF00" .. L["stvBossMarkerTooltip"] .."\n|cFF9CD6DELast seen: " .. NWB:getTimeString(GetServerTime() - lastSeenBoss, true) .. " ago");
			obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
			obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		NWB.extraMapMarkers[obj:GetName()] = true;
	end
end

local hookWorldMap = true;
function NWB:refreshStranglethornMarkers(updateOnly)
	if (not NWB.isSOD) then
		return;
	end
	--If we're looking at the capital city map.
	if (NWB.faction == "Horde" and WorldMapFrame and WorldMapFrame:GetMapID() == 1454) then
		--This is now attached to the ashenvale city markers.
		--[[mapMarkerTypes = {
			["Alliance"] = {x = 15, y = 92, mapID = 1454, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 20, y = 92, mapID = 1454, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		_G["AllianceNWBStranglethornMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBStranglethornMap"].fsBottom:SetPoint("BOTTOM", 28, -45);]]
	elseif (NWB.faction == "Alliance" and WorldMapFrame and WorldMapFrame:GetMapID() == 1453) then
		--[[mapMarkerTypes = {
			["Alliance"] = {x = 14, y = 92, mapID = 1453, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 19, y = 92, mapID = 1453, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		_G["AllianceNWBStranglethornMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBStranglethornMap"].fsBottom:SetPoint("BOTTOM", 28, -45);]]
	else
		mapMarkerTypes = {
			["Alliance"] = {x = 78, y = 90, mapID = 1434, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 83, y = 90, mapID = 1434, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		_G["AllianceNWBStranglethornMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBStranglethornMap"].fsBottom:SetPoint("TOPRIGHT", _G["AllianceNWBStranglethornMap"], "TOPRIGHT", 70, -50);
	end
	if (WorldMapFrame and hookWorldMap) then
		hooksecurefunc(WorldMapFrame, "OnMapChanged", function()
			NWB:refreshStranglethornMarkers();
		end)
		hookWorldMap = nil;
	end
	for k, v in pairs(mapMarkerTypes) do
		NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBStranglethornMap", _G[k .. "NWBStranglethornMap"]);
		if (NWB.db.global.showWorldMapMarkers and _G[k .. "NWBStranglethornMap"]) then
			NWB.dragonLibPins:AddWorldMapIconMap(k .. "NWBStranglethornMap", _G[k .. "NWBStranglethornMap"], v.mapID,
					v.x / 100, v.y / 100, HBD_PINS_WORLDMAP_SHOW_PARENT);
		end
	end
	if (not updateOnly) then
		NWB:updateWorldbuffMarkersScale();
	end
end

function NWB:loadStranglethorn()
	if (not NWB.isSOD) then
		return;
	end
	createStranglethornMarkers();
end

local lastCoin, coinCount = 0, 0;
local function coinsLooted(amount)
	if (GetTime() - lastCoin > 3600) then
		--If last coint was seen too long ago then reset to start, it's a new event.
		coinCount = 0;
	end
	coinCount = coinCount + amount;
	C_Timer.After(0.1, function()
		NWB:print("|cFFFFFFFF" .. L["Total coins this event"] .. ":|r " .. coinCount, nil, "[NWB]");
	end);
	lastCoin = GetTime();
end

local function chatMsgLoot(...)
	local msg = ...;
    local name = UnitName("Player");
    local otherPlayer;
    --Self loot multiple item "You create: [Item]x2"
	local itemLink, amount = strmatch(msg, string.gsub(string.gsub(LOOT_ITEM_CREATED_SELF_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
	if (not itemLink) then
 		--Self receive single loot "You create: [Item]"
    	local itemLink, amount = strmatch(msg, string.gsub(LOOT_ITEM_CREATED_SELF, "%%s", "(.+)"));
    end
    if (itemLink) then --Copper Blood Coin and Copper Massacre Coin.
    	if (string.match(itemLink, "item:213168") or string.match(itemLink, "item:221364")) then
    		if (amount) then
	    		amount = tonumber(amount);
	    	end
	    	coinsLooted(amount);
    	end
    end
end


---This stv boss stuff is still experimental and not added in options yet, needs testing with real data.
local lastGuildMsg, lastGroupMsg = {}, {};
local function validateStv(zoneID)
	for k, v in NWB:pairsByKeys(NWB.data.layers) do
		if (v.layerMap) then
			for k, v in pairs(v.layerMap) do
				if (k == zoneID and v == 1434) then
					return true;
				end
			end
		end
	end
end

local function addBossMarker(x, y)
	if (NWB.db.global.showStvBoss) then
		NWB.dragonLibPins:AddWorldMapIconMap("NWBStranglethornBoss", _G["NWBStranglethornBoss"], 1434,
				x, y, HBD_PINS_WORLDMAP_SHOW_PARENT);
		isBossShown = true;
		lastSeenBoss = GetServerTime();
		if (GetServerTime() - lastBossMsg  > 3600) then
			lastBossMsg = GetServerTime(); --This is also set in mouseover so no msg if we see it ourself.
			local _, _, zone = NWB:GetPlayerZonePosition();
			if (zone == 1434) then
				NWB:print(L["stvBossSpotted"]);
				local colorTable = {r = NWB.db.global.middleColorR, g = NWB.db.global.middleColorG, b = NWB.db.global.middleColorB, id = 41, sticky = 0};
				RaidNotice_AddMessage(RaidWarningFrame, NWB:stripColors(L["stvBossSpotted"]), colorTable, 5);
			end
		end
	end
end

--validateStv(zoneID) must be checked before this is called.
function NWB:updateStvBoss(zoneID, x, y, hide)
	if (not _G["NWBStranglethornBoss"]) then
		return;
	end
	if (hide) then
		--Hide map marker.
		isBossShown = nil;
		NWB.dragonLibPins:RemoveWorldMapIcon("NWBStranglethornBoss", _G["NWBStranglethornBoss"]);
	else
		addBossMarker(x, y);
	end
end

local function getStvPos(zoneID)
	if (not NWB.stvRunning) then
		return;
	end
	local x, y, zone = NWB:GetPlayerZonePosition();
	if (validateStv(zoneID) and zoneID and x and y and zone == 1434) then
		NWB:updateStvBoss(zoneID, x, y);
		return zoneID, x, y;
	end
end

function NWB:buildStvData()
	if (not NWB.stvRunning) then
		return;
	end
	local count = 0;
	local data = {};
	for k, v in pairs(bossCache) do
		if (v.timestamp and v.zoneID and v.x and v.y) then
			if (v.timestamp and GetServerTime() - v.timestamp < 1800) then
				data[k] = v.zoneID .. "_" .. v.x .. "_" .. v.y;
				count = count + 1;
				if (count == NWB.limitLayerCount) then
					break;
				end
			end
		end
	end
	if (next(data)) then
		return data;
	end
end

function NWB:parseStvData(data)
	if (not NWB.stvRunning) then
		return;
	end
	if (data) then
		for k, v in pairs(data) do
			local zoneID, x, y = strsplit("_", v, 3);
			if (zoneID and x and y) then
				bossCache[zoneID] = {
					timestamp = GetServerTime();
					zoneID = zoneID,
					x = x,
					y = y,
				};
			end
		end
	end
end

function NWB:sendStvPos(distribution, zoneID, x, y)
	if (not NWB.stvRunning) then
		return;
	end
	if (zoneID and x and y) then
		if (not bossCache[zoneID]) then
			bossCache[zoneID] = {};
		end
		bossCache[zoneID] = {
			timestamp = GetServerTime();
			zoneID = zoneID,
			x = x,
			y = y,
		};
		if (distribution == "BOTH") then
			if (not lastGuildMsg[zoneID] or GetServerTime() - lastGuildMsg[zoneID] > 180) then
				NWB:sendStvData("GUILD", zoneID .. " " .. x .. " " .. y);
				lastGuildMsg[zoneID] = GetServerTime();
			end
			if (not NWB:isFullGuildGroup() and (not lastGroupMsg[zoneID] or GetServerTime() - lastGroupMsg[zoneID] > 180)) then
				if (IsInRaid()) then
					NWB:sendStvData("PARTY", zoneID .. " " .. x .. " " .. y);
				elseif (IsInGroup()) then
					NWB:sendStvData("RAID", zoneID .. " " .. x .. " " .. y);
				end
				lastGroupMsg[zoneID] = GetServerTime();
			end
		elseif (distribution == "GUILD") then
			if (not lastGuildMsg[zoneID] or GetServerTime() - lastGuildMsg[zoneID] > 180) then
				NWB:sendStvData("GUILD", zoneID .. " " .. x .. " " .. y);
				lastGuildMsg[zoneID] = GetServerTime();
			end
		elseif (distribution == "PARTY" or distribution == "RAID") then
			if (not lastGroupMsg[zoneID] or GetServerTime() - lastGroupMsg[zoneID] > 180) then
				if (IsInRaid()) then
					NWB:sendStvData("PARTY", zoneID .. " " .. x .. " " .. y);
				elseif (IsInGroup()) then
					NWB:sendStvData("RAID", zoneID .. " " .. x .. " " .. y);
				end
				lastGroupMsg[zoneID] = GetServerTime();
			end
		end
	end
end

function NWB:receivedStvPos(distribution, zoneID, x, y)
	if (not NWB.stvRunning) then
		return;
	end
	if (zoneID and x and y) then
		zoneID = tonumber(zoneID);
		x = tonumber(x);
		y = tonumber(y);
		if (not bossCache[zoneID]) then
			bossCache[zoneID] = {};
		end
		bossCache[zoneID] = {
			timestamp = GetServerTime();
			zoneID = zoneID,
			x = x,
			y = y,
		};
		if (distribution == "GUILD") then
			lastGuildMsg[zoneID] = GetServerTime();
		elseif (distribution == "PARTY" or distribution == "RAID") then
			--Wait a couple secs to see if we got guild data too, so we don't send uneeded comms to guild.
			if (not lastGroupMsg[zoneID] or GetServerTime() - lastGuildMsg[zoneID] > 180) then
				NWB:sendStvPos("GUILD", zoneID, x, y);
				lastGroupMsg[zoneID] = GetServerTime();
			end
		end
		if (validateStv(zoneID)) then
			NWB:updateStvBoss(zoneID, x, y);
		end
	end
end

--If we get randomly layered during the event or we have data and the map isn't showing just refresh the marker when we get a zoneID from inside the zone.
local function refreshStvBossMarker(zoneID, fromLayerCalc)
	if (fromLayerCalc) then
		--From outside the zone.
		--Get zoneID for STV on current layer.
		local layerZoneID, stvZoneID;
		for k, v in NWB:pairsByKeys(NWB.data.layers) do
			if (v.layerMap) then
				for kk, vv in pairs(v.layerMap) do
					if (kk == zoneID) then
						layerZoneID = k;
						break;
					end
				end
			end
		end
		if (layerZoneID) then
			for k, v in NWB:pairsByKeys(NWB.data.layers[layerZoneID].layerMap) do
				if (v == 1434) then
					stvZoneID = k;
					break;
				end
			end
			if (stvZoneID) then
				for k, v in pairs(bossCache) do
					if (stvZoneID == v.zoneID and v.timestamp and GetServerTime() - v.timestamp < 3600) then
						addBossMarker(v.x, v.y);
						break;
					end
				end
			end
		end
	else
		--From being in the zone.
		for k, v in pairs(bossCache) do
			if (zoneID == v.zoneID and v.timestamp and GetServerTime() - v.timestamp < 3600) then
				addBossMarker(v.x, v.y);
			end
		end
	end
end

function NWB:refreshStvBossMarker(zoneID, fromLayerCalc)
	refreshStvBossMarker(zoneID, fromLayerCalc);
end

local function parseGUID(unit)
	if (NWB.stvRunning) then
		local guid = UnitGUID(unit);
		if (guid) then
			local _, _, zone = NWB:GetPlayerZonePosition();
			if (zone == 1434) then
				local unitType, _, _, _, zoneID, npcID = strsplit("-", guid);
				if (unitType == "Creature" and npcID) then
					zoneID = tonumber(zoneID);
					npcID = tonumber(npcID);
					if (npcID == 218690) then
						lastBossMsg = GetServerTime();
						local zoneID, x, y = getStvPos(zoneID);
						if (x and y) then
							--Shrink the coords numbers a bit for data sharing, no need to be super accurate.
							x = NWB:round(x, 3);
							y = NWB:round(y, 3);
							NWB:sendStvPos("BOTH", zoneID, x, y);
						end
					else
						refreshStvBossMarker(zoneID);
					end
				end
			end
		end
	end
end

if (NWB.isSOD) then
	local f = CreateFrame("Frame");
	f:RegisterEvent("CHAT_MSG_LOOT");
	f:RegisterEvent("UNIT_TARGET");
	f:RegisterEvent("PLAYER_TARGET_CHANGED");
	f:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	f:RegisterEvent("NAME_PLATE_UNIT_ADDED");
	f:SetScript('OnEvent', function(self, event, ...)
		if (event == "CHAT_MSG_LOOT") then
			chatMsgLoot(...)
		elseif (event == "UNIT_TARGET" or event == "PLAYER_TARGET_CHANGED") then
			parseGUID("target");
		elseif (event == "UPDATE_MOUSEOVER_UNIT") then
			parseGUID("mouseover");
		elseif (event == "NAME_PLATE_UNIT_ADDED") then
			parseGUID("nameplate1");
		end
	end)
end