-------------------
---NovaWorldBuffs--
-------------------

local addonName, addon = ...;
local NWB = addon.a;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");
local calcStart, lastSendGuild, lastSendPersonal = 0, 0, 0;

SLASH_NWBASHVCMD1 = '/ashenvale';
function SlashCmdList.NWBASHVCMD(msg, editBox)
	WorldMapFrame:Show();
	WorldMapFrame:SetMapID(1440);
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

_G["calcStart"] = calcStart;

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
		--Commented out, no static end time for ashenvale so don't show "is running" timer.
		--if (timeLeft > 9000) then
			--If more than 2.5h left then it's running, return time left on current event instead.
		--	type = "running";
		--	timeLeft = timeLeft - 9000;
		--end
		return timeLeft, type, timestamp;
	end
end

function NWB:getAshenvaleTimeString(isShort, veryShort)
	local text;
	local timeLeft, type, timestamp = getTimeLeft();
	if (timeLeft) then
		local timeString = NWB:getTimeString(timeLeft, true, "short");
		if (veryShort) then
			text = L["Ashenvale"] .. ": |cFF9CD6DE" .. timeString .. "|r";
		elseif (isShort) then
			text = string.format(L["startsIn"], "|cFF9CD6DE" .. timeString .. "|r");
		else
			text = string.format(L["ashenvaleEventStartsIn"], "|cFF9CD6DE" .. timeString .. "|r");
		end
	end
	return text, timeLeft, timestamp;
end

function NWB:addAshenvaleMinimapString(tooltip, noTopSeperator, noBottomSeperator)
	if (not NWB.isSOD) then
		return;
	end
	local text, timeLeft, timestamp = NWB:getAshenvaleTimeString();
	if (not text) then
		return;
	end
	--Check if previous line is a seperator so we don't double up.
	if (_G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()] and _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()]:GetText() ~= " "
			and not noTopSeperator) then
		tooltip:AddLine(" ");
		if (not tooltip.NWBSeparator7) then
		    tooltip.NWBSeparator7 = tooltip:CreateTexture(nil, "BORDER");
		    tooltip.NWBSeparator7:SetColorTexture(0.6, 0.6, 0.6, 0.85);
		    tooltip.NWBSeparator7:SetHeight(1);
		    tooltip.NWBSeparator7:SetPoint("LEFT", 10, 0);
		    tooltip.NWBSeparator7:SetPoint("RIGHT", -10, 0);
		end
		tooltip.NWBSeparator7:SetPoint("TOP", _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()], "CENTER");
		tooltip.NWBSeparator7:Show();
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
		if (not tooltip.NWBSeparator8) then
		    tooltip.NWBSeparator8 = tooltip:CreateTexture(nil, "BORDER");
		    tooltip.NWBSeparator8:SetColorTexture(0.6, 0.6, 0.6, 0.85);
		    tooltip.NWBSeparator8:SetHeight(1);
		    tooltip.NWBSeparator8:SetPoint("LEFT", 10, 0);
		    tooltip.NWBSeparator8:SetPoint("RIGHT", -10, 0);
		end
		tooltip.NWBSeparator8:SetPoint("TOP", _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()], "CENTER");
		tooltip.NWBSeparator8:Show();
	end
	return true;
end

function NWB:checkAshenvaleTimer()
	local timeLeft, type = getTimeLeft();
	if (timeLeft <= 900 and timeLeft >= 899 and GetTime() - lastSendGuild > 900) then
		lastSendGuild = GetTime();
		if (NWB.db.global.guild10) then
			local msg = string.format(L["ashenvaleStartSoon"], "15 " .. L["minutes"]) .. ".";
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
	--[[if (NWB.db.global.personalAshenvale30 and timeLeft <= 1800 and timeLeft >= 1799 and GetTime() - lastSendPersonal > 900) then
		lastSendPersonal = GetTime();
		if (NWB.db.global.personalAshenvale30) then
			local msg = string.format(L["ashenvaleStartSoon"], "30 " .. L["minutes"]) .. ".";
			NWB:print(msg);
			local colorTable = {r = self.db.global.middleColorR, g = self.db.global.middleColorG, b = self.db.global.middleColorB, id = 41, sticky = 0};
			RaidNotice_AddMessage(RaidWarningFrame, NWB:stripColors(msg), colorTable, 5);
		end
	end]]
end

local mapMarkerTypes;
if (NWB.isSOD) then
	mapMarkerTypes = {
		["Alliance"] = {x = 88, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\alliancetower.blp"},
		["Horde"] = {x = 93, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\hordetower.blp"},
	};
end

local isCityMap;
--Update timers for worldmap when the map is open.
function NWB:updateAshenvaleMarkers(type)
	if (isCityMap) then
		local text = NWB:getAshenvaleTimeString(true);
		text = L["Ashenvale"] .. " " .. string.lower(text);
		_G["AllianceNWBAshenvaleMap"].timerFrame.fs:SetText("|cFFFFFF00" .. text);
		local text2, _, _, _, type2 = NWB:getStranglethornTimeString(true);
		if (type2 ~= "running") then
			text2 = L["Stranglethorn"] .. " " .. string.lower(text2);
		end
		_G["AllianceNWBAshenvaleMap"].timerFrame2.fs:SetText("|cFFFFFF00" .. text2);
	else
		local text = NWB:getAshenvaleTimeString(true);
		_G["AllianceNWBAshenvaleMap"].timerFrame.fs:SetText("|cFFFFFF00" .. text);
		local text2 = NWB:getStranglethornTimeString(true);
		_G["AllianceNWBAshenvaleMap"].timerFrame2.fs:SetText("|cFFFFFF00" .. text2);
	end
end

local function createAshenvaleMarkers()
	if (not mapMarkerTypes) then
		return;
	end
	for k, v in pairs(mapMarkerTypes) do
		NWB:createAshenvaleMarker(k, v);
	end
	NWB:refreshAshenvaleMarkers();
end

local mapMarkers = {};
function NWB:createAshenvaleMarker(type, data)
	if (not NWB.isClassic) then
		return;
	end
	if (not _G[type .. "NWBAshenvaleMap"]) then
		--Worldmap marker.
		local obj = CreateFrame("Frame", type .. "NWBAshenvaleMap", WorldMapFrame);
		local bg = obj:CreateTexture(nil, "ARTWORK");
		bg:SetTexture(data.icon);
		bg:SetTexCoord(0.1, 0.6, 0.1, 0.6);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(20, 20);
		obj.fsTitle = obj:CreateFontString(type .. "NWBAshenvaleBuffCmdFSTitle", "ARTWORK");
		obj.fsTitle:SetPoint("TOP", 27, 22);
		obj.fsTitle:SetFont("Fonts\\FRIZQT__.ttf", 14, "OUTLINE");
		--obj.fsTitle:SetFontObject(NumberFont_Outline_Med);
		obj.fsBottom = obj:CreateFontString(type .. "NWBAshenvaleBuffCmdFSBottom", "ARTWORK");
		obj.fsBottom:SetPoint("BOTTOM", 28, -45);
		obj.fsBottom:SetFont("Fonts\\FRIZQT__.ttf", 14, "OUTLINE");
		mapMarkers[type .. "NWBAshenvale"] = true;
		obj.tooltip = CreateFrame("Frame", type .. "NWBAshenvaleDailyMapTextTooltip", obj, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("BOTTOM", obj, "TOP", 0, 35);
		--obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -26);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9999);
		obj.tooltip.fs = obj.tooltip:CreateFontString("NWBAshenvaleDailyMapTextTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 14);
		obj.tooltip.fs:SetJustifyH("LEFT")
		obj.tooltip.fs:SetText(L["Ashenvale PvP Event"]);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		obj.tooltip:Hide();
		obj:SetScript("OnEnter", function(self)
			if (WorldMapFrame and (WorldMapFrame:GetMapID() ~= 1454 and WorldMapFrame:GetMapID() ~= 1453)) then
				obj.tooltip:Show();
			end
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		--New version we don't need resource frames for both factions, just attach timer string to alliance and move it to sit in the middle of both.
		if (type == "Alliance") then
			_G["AllianceNWBAshenvaleMap"].fsTitle:SetText("|cFFFFFF00" .. L["Ashenvale"]);
			--Timer frame that sits above the icon when an active timer is found.
			obj.timerFrame = CreateFrame("Frame", type .. "AshenvaleTimerFrame", obj, "TooltipBorderedFrameTemplate");
			obj.timerFrame:SetPoint("CENTER", obj, "CENTER",  26, -23);
			obj.timerFrame:SetFrameStrata("FULLSCREEN");
			obj.timerFrame:SetFrameLevel(9);
			obj.timerFrame.fs = obj.timerFrame:CreateFontString(type .. "NWBAshenvaleTimerFrameFS", "ARTWORK");
			obj.timerFrame.fs:SetPoint("CENTER", 0, 0);
			obj.timerFrame.fs:SetFont("Fonts\\FRIZQT__.ttf", 13);
			obj.timerFrame:SetWidth(54);
			obj.timerFrame:SetHeight(24);
			obj.resetType = L["Ashenvale Towers"];
			obj.timerFrame:SetScript("OnEnter", function(self)
				if (WorldMapFrame and (WorldMapFrame:GetMapID() ~= 1454 and WorldMapFrame:GetMapID() ~= 1453)) then
					obj.tooltip:Show();
				end
			end)
			obj.timerFrame:SetScript("OnLeave", function(self)
				obj.tooltip:Hide();
			end)
			
			obj.timerFrame2 = CreateFrame("Frame", type .. "AshenvaleTimerFrame2", obj, "TooltipBorderedFrameTemplate");
			obj.timerFrame2:SetPoint("CENTER", obj, "CENTER",  26, -43);
			obj.timerFrame2:SetFrameStrata("FULLSCREEN");
			obj.timerFrame2:SetFrameLevel(9);
			obj.timerFrame2.fs = obj.timerFrame2:CreateFontString(type .. "NWBAshenvaletimerFrame22FS", "ARTWORK");
			obj.timerFrame2.fs:SetPoint("CENTER", 0, 0);
			obj.timerFrame2.fs:SetFont("Fonts\\FRIZQT__.ttf", 13);
			obj.timerFrame2:SetWidth(54);
			obj.timerFrame2:SetHeight(24);
			
			obj.lastUpdate = 0;
			obj.resetType = L["Ashenvale Towers"];
			obj:SetScript("OnUpdate", function(self)
				--Update timer when map is open.
				if (GetServerTime() - obj.lastUpdate > 0) then
					obj.lastUpdate = GetServerTime();
					NWB:updateAshenvaleMarkers(type);
					obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 18);
					obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 12);
					obj.timerFrame2:SetWidth(obj.timerFrame2.fs:GetStringWidth() + 18);
					obj.timerFrame2:SetHeight(obj.timerFrame2.fs:GetStringHeight() + 12);
				end
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

local hookWorldMap = true;
function NWB:refreshAshenvaleMarkers(updateOnly)
	if (not NWB.isClassic) then
		return;
	end
	--If we're looking at the capital city map.
	if (NWB.faction == "Horde" and WorldMapFrame and WorldMapFrame:GetMapID() == 1454) then
		mapMarkerTypes = {
			["Alliance"] = {x = 15, y = 80, mapID = 1454, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 20, y = 80, mapID = 1454, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		--If the marker is showing in capital city then it's a combined world events marker not just ashenvale anymore.
		isCityMap = true;
		_G["AllianceNWBAshenvaleMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBAshenvaleMap"].fsBottom:SetPoint("BOTTOM", 28, -45);
		_G["AllianceNWBAshenvaleMap"].timerFrame2:Show();
		_G["AllianceNWBAshenvaleMap"].fsTitle:SetText("|cFFFFFF00" .. L["World Events"]);
	elseif (NWB.faction == "Alliance" and WorldMapFrame and WorldMapFrame:GetMapID() == 1453) then
		mapMarkerTypes = {
			["Alliance"] = {x = 14, y = 80, mapID = 1453, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 19, y = 80, mapID = 1453, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		isCityMap = true;
		_G["AllianceNWBAshenvaleMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBAshenvaleMap"].fsBottom:SetPoint("BOTTOM", 28, -45);
		_G["AllianceNWBAshenvaleMap"].timerFrame2:Show();
		_G["AllianceNWBAshenvaleMap"].fsTitle:SetText("|cFFFFFF00" .. L["World Events"]);
	else
		mapMarkerTypes = {
			["Alliance"] = {x = 88, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 93, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		isCityMap = nil;
		_G["AllianceNWBAshenvaleMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBAshenvaleMap"].fsBottom:SetPoint("TOPRIGHT", _G["AllianceNWBAshenvaleMap"], "TOPRIGHT", 70, -50);
		_G["AllianceNWBAshenvaleMap"].timerFrame2:Hide();
		_G["AllianceNWBAshenvaleMap"].fsTitle:SetText("|cFFFFFF00" .. L["Ashenvale"]);
	end
	if (WorldMapFrame and hookWorldMap) then
		hooksecurefunc(WorldMapFrame, "OnMapChanged", function()
			NWB:refreshAshenvaleMarkers();
		end)
		hookWorldMap = nil;
	end
	for k, v in pairs(mapMarkerTypes) do
		NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBAshenvaleMap", _G[k .. "NWBAshenvaleMap"]);
		if (NWB.db.global.showWorldMapMarkers and _G[k .. "NWBAshenvaleMap"]) then
			NWB.dragonLibPins:AddWorldMapIconMap(k .. "NWBAshenvaleMap", _G[k .. "NWBAshenvaleMap"], v.mapID,
					v.x / 100, v.y / 100, HBD_PINS_WORLDMAP_SHOW_PARENT);
		end
	end
	if (not updateOnly) then
		NWB:updateWorldbuffMarkersScale();
	end
end

function NWB:loadAshenvale()
	if (not NWB.isSOD) then
		return;
	end
	createAshenvaleMarkers();
end







-----------------------------------------------
---Old way when it was resources not a timer---
-----------------------------------------------

--[[
local lastAshenUpdate, lastSendGuild, lastSendGroup = 0, 0, 0;
local lastAlliancePercent, lastHordePercent, lastWinner = 0, 0, 0;
local lastStartSoon, lastStarted = 0;
local logonStartDelay, lastStartSoonDelay = 0, 1200;
local lastIsRunning, isRunning = 0;
local startup = true;
local lastWidget = 0;

SLASH_NWBASHVCMD1 = '/ashenvale';
function SlashCmdList.NWBASHVCMD(msg, editBox)
	WorldMapFrame:Show();
	WorldMapFrame:SetMapID(1440);
end

local f = CreateFrame("Frame");
f:RegisterEvent("UPDATE_UI_WIDGET");
f:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
--f:RegisterEvent("CHAT_MSG_GUILD");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "UPDATE_UI_WIDGET") then
		local data = ...;
		if (data.widgetID == 5360 or data.widgetID == 5361) then -- Alliance and Horde percentage stage.
			--One widget is sent at a time when percent changes.
			NWB:getAshenvaleResourceData();
			isRunning = nil;
			lastWidget = data.widgetID;
		elseif (data.widgetID == 5366 or data.widgetID == 5367 or data.widgetID == 5368) then --Event is running.
			--5367 Alliance.
			--5368 Horde.
			if (data.widgetID == 5367 or data.widgetID == 5368) then
				--Score update while running.
				NWB:getAshenvaleScoreData();
			end
			if (not isRunning and lastAlliancePercent ~= 0 and lastHordePercent ~= 0 and NWB:isAshenvaleTimerValid()) then
				if (lastWidget == 5366 or lastWidget == 5367 or lastWidget == 5368) then
					--Header widget has popped up, event started.
					NWB:ashenvaleEventStarted();
				end
			end
			isRunning = true;
			lastIsRunning = GetServerTime();
			lastWidget = data.widgetID;
		end
	elseif (event == "CHAT_MSG_BG_SYSTEM_NEUTRAL") then
		local _, _, zone = NWB:GetPlayerZonePosition();
		if (zone == 1440) then
			local msg = ...;
			if (strmatch(msg, L["ashenvaleHordeVictoryMsg"])) then
				NWB:ashenvaleWinner("horde");
			elseif (strmatch(msg, L["ashenvaleAllianceVictoryMsg"])) then
				NWB:ashenvaleWinner("alliance");
			end
		end
	elseif (event == "CHAT_MSG_GUILD") then
		--local msg = ...;
		--local match = string.gsub("[NWB] " .. L["ashenvaleWarning"], "%[NWB%] ", ""); --Prefix.
		--match = string.gsub(match, "%(", "%%("); --Brackets.
		--match = string.gsub(match, "%)", "%%)"); --Brackets.
		--match = string.gsub(match, "%%s", "(.+)"); --Captures.
		--match = string.gsub(match, "%.$", "%%."); --Last full stop.
		--if (strmatch(msg, match)) then
		--	NWB.data.lastAshenvaleGuildMsg = GetServerTime();
		--end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		local isLogon, isReload = ...;
		if (isLogon or isReload) then
			local _, _, zone = NWB:GetPlayerZonePosition();
			if (zone == 1440) then
				--If we logon in the zone and it's already about to start don't announce to guild, someone probably already did.
				logonStartDelay = GetServerTime();
			end
		end
	end
end)

function NWB:getAshenvaleResourceData()
	if (not NWB.isClassic) then
		return;
	end
	if (NWB:isAshenvaleRunning()) then
		--Sometimes the resource wdigets update while the game is running, not sure why, probably layer related.
		--NWB:debug("Widget update while game is running.")
		return;
	end
	if (GetTime() - lastWinner < 2) then
		--We get weird widget updates right after the battle ends of resource scores like 100-100 and 100-0.
		return;
	end
	--Percentage widgets stop updating when the event is running.
	local alliance = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5360);
	local horde = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5361);
	if (not alliance or not horde) then
		--NWB:debug("missing widget");
		return;
	end
	if (not UIWidgetTopCenterContainerFrame:IsShown()) then
		--NWB:debug("missing widget2");
		return;
	end
	--Make sure the child being shown is a matching widget, incase the state is ever set wrong.
	local children = {UIWidgetTopCenterContainerFrame:GetChildren()};
	local child;
	for k, v in pairs(children) do
		if (v:IsShown()) then
			child = v;
		end
	end
	if (not child) then
		--NWB:debug("missing child frame");
		return;
	end
	local alliancePercent = string.match(alliance.text, "(%d+)");
	local hordePercent = string.match(horde.text, "(%d+)");
	if (alliancePercent == "0" or hordePercent == "0") then
		--Just ignore 0 updates, it seems to be messing things up with some players, probably something to do with match ending.
		return;
	end
	if (alliancePercent and hordePercent and tonumber(alliancePercent) and tonumber(hordePercent)) then
		NWB:receivedAshenvaleUpdate(alliancePercent .. "_" .. hordePercent, GetServerTime(), "zone");
	end
end

function NWB:isAshenvaleRunning()
	if (isRunning) then
		return true;
	end
	local _, _, zone = NWB:GetPlayerZonePosition();
	if (zone == 1440) then
		local children = {UIWidgetTopCenterContainerFrame:GetChildren()};
		for k, v in pairs(children) do
			if (v:IsShown() and (v.widgetID == 5367 or v.widgetID == 5368)) then
				return true;
			end
		end
	end
end

function NWB:getAshenvaleScoreData()
	--Percentage widgets stop updating when the event is running.
	local alliance = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5367);
	local horde = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5368);
	if (not alliance or not horde) then
		--NWB:debug("missing widget");
		return;
	end
	if (not UIWidgetTopCenterContainerFrame:IsShown()) then
		--NWB:debug("missing widget2");
		return;
	end
	--Make sure the child being shown is a matching widget, incase the state is ever set wrong.
	local children = {UIWidgetTopCenterContainerFrame:GetChildren()};
	local child;
	for k, v in pairs(children) do
		if (v:IsShown()) then
			child = v;
		end
	end
	if (not child) then
		--NWB:debug("missing child frame");
		return;
	end
	local allianceScore = string.match(alliance.text, "(%d+)");
	local hordeScore = string.match(horde.text, "(%d+)");
	if (allianceScore and hordeScore) then
		--I considered showing the scoreboard but it's different for each layer so no point really.
		--I'll leave the code here incase that changes.
		--NWB:debug("Score update:", allianceScore, hordeScore);
	end
end

function NWB:receivedAshenvaleUpdate(data, timestamp, distribution, sender)
	--if (distribution == "zone") then
		--NWB:debug("Received ashenvale data:", data, timestamp, distribution, sender);
	--end
	if (data and timestamp and distribution) then
		if ((not NWB.data.ashenvaleTime or timestamp > NWB.data.ashenvaleTime)
				and (timestamp < GetServerTime() + 60)) then
			local newAlliance, newHorde = strsplit("_", data, 2);
			if (newAlliance == "0" or newHorde == "0") then
				--Just ignore 0 updates, it seems to be messing things up with some players, probably something to do with match ending.
				return;
			end
			local oldAlliance, oldHorde = NWB:getAshenvalePercent();
			if (not NWB.data.ashenvaleTime or GetServerTime() - NWB.data.ashenvaleTime > 1200) then
				oldAlliance, oldHorde = 0, 0;
			end
			NWB.data.ashenvale = data;
			NWB.data.ashenvaleTime = timestamp;
			lastAshenUpdate = GetServerTime();
			if (distribution == "zone") then
				local _, _, onlineCount = GetNumGuildMembers();
				if (IsInGuild() and GetServerTime() - lastSendGuild > 30 and onlineCount > 1) then
					lastSendGuild = GetServerTime()
					NWB:sendData("GUILD", nil, nil, true, true, "ashenvale");
				end
				if (GetServerTime() - lastSendGroup > 30) then
					--Timed delay so receivers can compare data from guild first and ched if it's needed to relay to party.
					lastSendGroup = GetServerTime();
					C_Timer.After(2, function()
						if (IsInRaid()) then
							NWB:sendData("RAID", nil, nil, true, true, "ashenvale");
						elseif (IsInGroup()) then
							NWB:sendData("PARTY", nil, nil, true, true, "ashenvale");
						end
					end)
				end
			end
			if (not startup and not isRunning and not (oldAlliance == 0 and oldHorde == 0)
					and GetServerTime() - lastIsRunning > lastStartSoonDelay + 300) then
				--Not first run and old data isn't too far expired.
				local newTotal = newAlliance + newHorde;
				local oldTotal = oldAlliance + oldHorde;
				--Don't need to check previous total now we're sharing when last guild msg was sent.
				--if (newTotal >= 180 and newTotal < 200 and oldTotal < 180) then
				if (newTotal >= 180 and newTotal < 200 and newTotal > oldTotal) then
					NWB:ashenvaleEventStartsSoon(newAlliance, newHorde, timestamp);
				end
			end
			--NWB:debug("Alliance:", newAlliance, lastAlliancePercent, "Horde:", newHorde, lastHordePercent, distribution, sender);
			lastAlliancePercent = newAlliance;
			lastHordePercent = newHorde;
			startup = nil;
			if (sender and (distribution == "PARTY" or distribution == "RAID" or distribution == "YELL")) then
				local _, _, onlineCount = GetNumGuildMembers();
				if (IsInGuild() and GetServerTime() - lastSendGuild > 90 and not NWB:inMyGuild(sender) and onlineCount > 1) then
					lastSendGuild = GetServerTime()
					C_Timer.After(2, function()
						NWB:sendData("GUILD", nil, nil, true, true, "ashenvale");
					end)
					--NWB:debug("Guild relay sent.");
				end
			end
			isRunning = nil;
		end
	end
end

--Data is within the last 5 mins.
function NWB:isAshenvaleTimerValid()
	if (NWB.data.ashenvale and NWB.data.ashenvaleTime and NWB.data.ashenvaleTime > GetServerTime() - 600) then
		return true;
	end
end

--Data is not within the last 5 mins but still could be shown with a warning.
function NWB:isAshenvaleTimerExpired()
	if (NWB:isAshenvaleTimerValid()) then
		return;
	end
	if (NWB.data.ashenvale and NWB.data.ashenvaleTime and NWB.data.ashenvaleTime > GetServerTime() - 1800) then
		--Within 30mins.
		return true;
	end
end

--Get data expired warning string.
function NWB:getAshenvaleTimerExpiredString(short)
	if (not NWB.data.ashenvale or not NWB.data.ashenvaleTime) then
		return "";
	end
	if (short) then
		return "|cFFFF6900" .. L["Old Data"] .. " (" .. NWB:getTimeString(GetServerTime() - NWB.data.ashenvaleTime, true, "short") .. " ago)|r";
	else
		return "|cFFFF6900" .. L["Ashenvale data is old"] .. " (" .. NWB:getTimeString(GetServerTime() - NWB.data.ashenvaleTime, true, "short") .. " ago).|r";
	end
end

function NWB:ashenvaleEventStartsSoon(alliancePercent, hordePercent, timestamp)
	if (GetServerTime() - lastStartSoon > lastStartSoonDelay and GetServerTime() - logonStartDelay > 30) then
		--Only announce if data is less than 5 mins old, it could be started by then if resources are moving fast.
		if (NWB:isAshenvaleTimerValid() and GetServerTime() - timestamp < 300 and GetServerTime() + 30 > timestamp) then
			lastStartSoon = GetServerTime();
			local msg = string.format(L["ashenvaleWarning"], alliancePercent, hordePercent);
			if (NWB.db.global.chat10) then
				NWB:print(msg, nil, "[NWB]");
			end
			NWB:playSound("soundsAshenvaleStartsSoon", "ashenvale");
			--if (NWB.db.global.middle10) then
			--	NWB:middleScreenMsg("middle30", msg, nil, 5);
			--end
			--Not needed anymore since we check last guild msg.
			--if (lastAlliancePercent == 0 and lastHordePercent == 0) then
				--If first run (we logon in ashenvale) only let ourselves know about spawn and not guild.
			--	return;
			--end
			if (NWB.db.global.guild10) then
				if (not NWB.data.lastAshenvaleGuildMsg or GetServerTime() - NWB.data.lastAshenvaleGuildMsg > lastStartSoonDelay) then
					NWB:sendGuildMsg(msg, "guild10", nil, "[NWB]", 2.60);
					NWB.data.lastAshenvaleGuildMsg = GetServerTime();
				end
			end
		end
	end
end

function NWB:ashenvaleEventStarted()
	--NWB:debug("Ashenvale event started");
end

function NWB:ashenvaleWinner(winner)
	local lastWinner = GetTime();
	--NWB:debug("Ashenvale PvP event ended - Winner:", winner .. ".");
	isRunning = nil;
end

function NWB:getAshenvalePercent()
	if (NWB.data.ashenvale) then
		local alliance, horde = strsplit("_", NWB.data.ashenvale, 2);
		return alliance, horde;
	end
end

function NWB:addAshenvaleMinimapString(tooltip)
	if (not NWB.isSOD) then
		return;
	end
	local alliance, horde = NWB:getAshenvalePercent();
	local allianceString, hordeString;
	if (NWB:isAshenvaleTimerValid()) then
		allianceString = "|TInterface\\worldstateframe\\alliancetower.blp:12:12:-2:1:32:32:1:18:1:18|t " .. alliance .. "%  " .. L["Alliance"];
		hordeString = "|TInterface\\worldstateframe\\hordetower.blp:12:12:-2:0:32:32:1:18:1:18|t " .. horde .. "%  " .. L["Horde"];
	elseif (NWB:isAshenvaleTimerExpired()) then
		allianceString = "|TInterface\\worldstateframe\\alliancetower.blp:12:12:-2:1:32:32:1:18:1:18|t |cFFFF6900" .. alliance .. "%|r  " .. L["Alliance"];
		hordeString = "|TInterface\\worldstateframe\\hordetower.blp:12:12:-2:0:32:32:1:18:1:18|t |cFFFF6900" .. horde .. "%|r  " .. L["Horde"];
	else
		allianceString = "|TInterface\\worldstateframe\\alliancetower.blp:12:12:-2:1:32:32:1:18:1:18|t " .. L["No data yet."];
		hordeString = "|TInterface\\worldstateframe\\hordetower.blp:12:12:-2:0:32:32:1:18:1:18|t " .. L["No data yet."];
	end
	tooltip:AddLine(" ");
	if (not tooltip.NWBSeparator2) then
	    tooltip.NWBSeparator2 = tooltip:CreateTexture(nil, "BORDER");
	    tooltip.NWBSeparator2:SetColorTexture(0.6, 0.6, 0.6, 0.85);
	    tooltip.NWBSeparator2:SetHeight(1);
	    tooltip.NWBSeparator2:SetPoint("LEFT", 10, 0);
	    tooltip.NWBSeparator2:SetPoint("RIGHT", -10, 0);
	end
	tooltip.NWBSeparator2:SetPoint("TOP", _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()], "CENTER");
	tooltip.NWBSeparator2:Show();
	if (isRunning) then
		tooltip:AddLine(NWB.chatColor .. L["Ashenvale"] .. " (" .. L["Event Running"] .. ")");
	else
		tooltip:AddLine(NWB.chatColor .. L["Ashenvale Resources"]);
	end
	tooltip:AddLine(allianceString);
	tooltip:AddLine(hordeString);
	if (NWB:isAshenvaleTimerExpired()) then
		tooltip:AddLine("|cFFFF6900" .. L["Warning"] .. ":|r " .. NWB:getAshenvaleTimerExpiredString());
	end
	tooltip:AddLine(" ");
	if (not tooltip.NWBSeparator3) then
	    tooltip.NWBSeparator3 = tooltip:CreateTexture(nil, "BORDER");
	    tooltip.NWBSeparator3:SetColorTexture(0.6, 0.6, 0.6, 0.85);
	    tooltip.NWBSeparator3:SetHeight(1);
	    tooltip.NWBSeparator3:SetPoint("LEFT", 10, 0);
	    tooltip.NWBSeparator3:SetPoint("RIGHT", -10, 0);
	end
	tooltip.NWBSeparator3:SetPoint("TOP", _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()], "CENTER");
	tooltip.NWBSeparator3:Show();
	return true;
end

local ashenvaleMapMarkerTypes;
if (NWB.isSOD) then
	ashenvaleMapMarkerTypes = {
		["Alliance"] = {x = 90, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\alliancetower.blp"},
		["Horde"] = {x = 95, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\hordetower.blp"},
	};
end

--Update timers for worldmap when the map is open.
function NWB:updateAshenvaleMarkers(type)
	_G["AllianceNWBAshenvaleMap"].fsTitle:SetText("|cFFFFFF00" .. L["Ashenvale"]);
	if (NWB:isAshenvaleTimerValid()) then
		local alliance, horde = NWB:getAshenvalePercent();
		 _G["AllianceNWBAshenvaleMap"].timerFrame.fs:SetText("|cFFFFFF00" .. alliance .. "%");
		 _G["HordeNWBAshenvaleMap"].timerFrame.fs:SetText("|cFFFFFF00" .. horde .. "%");
		 _G["AllianceNWBAshenvaleMap"].fsBottom:SetText("");
	elseif (NWB:isAshenvaleTimerExpired()) then
		local alliance, horde = NWB:getAshenvalePercent();
		 _G["AllianceNWBAshenvaleMap"].timerFrame.fs:SetText("|cFFFF6900" .. alliance .. "%");
		 _G["HordeNWBAshenvaleMap"].timerFrame.fs:SetText("|cFFFF6900" .. horde .. "%");
		 _G["AllianceNWBAshenvaleMap"].fsBottom:SetText(NWB:getAshenvaleTimerExpiredString());
	else
		 _G["AllianceNWBAshenvaleMap"].timerFrame.fs:SetText("---");
		 _G["HordeNWBAshenvaleMap"].timerFrame.fs:SetText("---");
		 _G["AllianceNWBAshenvaleMap"].fsBottom:SetText("");
	end
end

local function createAshenvaleMarkers()
	if (not ashenvaleMapMarkerTypes) then
		return;
	end
	for k, v in pairs(ashenvaleMapMarkerTypes) do
		NWB:createAshenvaleMarker(k, v);
	end
	NWB:refreshAshenvaleMarkers();
end

local mapMarkers = {};
function NWB:createAshenvaleMarker(type, data)
	if (not NWB.isClassic) then
		return;
	end
	if (not _G[type .. "NWBAshenvaleMap"]) then
		--Worldmap marker.
		local obj = CreateFrame("Frame", type .. "NWBAshenvaleMap", WorldMapFrame);
		local bg = obj:CreateTexture(nil, "ARTWORK");
		bg:SetTexture(data.icon);
		bg:SetTexCoord(0.1, 0.6, 0.1, 0.6);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(20, 20);
		obj.fsTitle = obj:CreateFontString(type .. "NWBAshenvaleBuffCmdFSTitle", "ARTWORK");
		obj.fsTitle:SetPoint("TOP", 28, 22);
		obj.fsTitle:SetFont("Fonts\\FRIZQT__.ttf", 14, "OUTLINE");
		--obj.fsTitle:SetFontObject(NumberFont_Outline_Med);
		obj.fsBottom = obj:CreateFontString(type .. "NWBAshenvaleBuffCmdFSBottom", "ARTWORK");
		obj.fsBottom:SetPoint("BOTTOM", 28, -45);
		obj.fsBottom:SetFont("Fonts\\FRIZQT__.ttf", 14, "OUTLINE");
		--Timer frame that sits above the icon when an active timer is found.
		obj.timerFrame = CreateFrame("Frame", type .. "AshenvaleTimerFrame", obj, "TooltipBorderedFrameTemplate");
		obj.timerFrame:SetPoint("CENTER", obj, "CENTER",  0, -22);
		obj.timerFrame:SetFrameStrata("FULLSCREEN");
		obj.timerFrame:SetFrameLevel(9);
		obj.timerFrame.fs = obj.timerFrame:CreateFontString(type .. "NWBAshenvaleTimerFrameFS", "ARTWORK");
		obj.timerFrame.fs:SetPoint("CENTER", 0, 0);
		obj.timerFrame.fs:SetFont("Fonts\\FRIZQT__.ttf", 13);
		obj.timerFrame:SetWidth(54);
		obj.timerFrame:SetHeight(24);
		obj.lastUpdate = 0;
		obj.resetType = L["Ashenvale Towers"];
		obj:SetScript("OnUpdate", function(self)
			--Update timer when map is open.
			if (GetServerTime() - obj.lastUpdate > 0) then
				obj.lastUpdate = GetServerTime();
				NWB:updateAshenvaleMarkers(type);
				obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 18);
				obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 12);
			end
		end)
		--Make it act like pin is the parent and not WorldMapFrame.
		obj:SetScript("OnHide", function(self)
			obj.timerFrame:Hide();
		end)
		obj:SetScript("OnShow", function(self)
			obj.timerFrame:Show();
		end)
		mapMarkers[type .. "NWBAshenvale"] = true;
		obj.tooltip = CreateFrame("Frame", type .. "NWBAshenvaleDailyMapTextTooltip", obj, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("BOTTOM", obj, "TOP", 0, 35);
		--obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -26);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9999);
		obj.tooltip.fs = obj.tooltip:CreateFontString("NWBAshenvaleDailyMapTextTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 14);
		obj.tooltip.fs:SetJustifyH("LEFT")
		obj.tooltip.fs:SetText(L["Ashenvale PvP Event Resources"]);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		obj.tooltip:Hide();
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		obj.timerFrame:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj.timerFrame:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		NWB.extraMapMarkers[obj:GetName()] = true;
	end
end

local hookWorldMap = true;
function NWB:refreshAshenvaleMarkers(updateOnly)
	if (not NWB.isClassic) then
		return;
	end
	--If we're looking at the capital city map.
	if (NWB.faction == "Horde" and WorldMapFrame and WorldMapFrame:GetMapID() == 1454) then
		ashenvaleMapMarkerTypes = {
			["Alliance"] = {x = 15, y = 87, mapID = 1454, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 20, y = 87, mapID = 1454, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		_G["AllianceNWBAshenvaleMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBAshenvaleMap"].fsBottom:SetPoint("BOTTOM", 28, -45);
	elseif (NWB.faction == "Alliance" and WorldMapFrame and WorldMapFrame:GetMapID() == 1453) then
		ashenvaleMapMarkerTypes = {
			["Alliance"] = {x = 12, y = 87, mapID = 1453, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 17, y = 87, mapID = 1453, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		_G["AllianceNWBAshenvaleMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBAshenvaleMap"].fsBottom:SetPoint("BOTTOM", 28, -45);
	else
		ashenvaleMapMarkerTypes = {
			["Alliance"] = {x = 90, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 95, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		_G["AllianceNWBAshenvaleMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBAshenvaleMap"].fsBottom:SetPoint("TOPRIGHT", _G["AllianceNWBAshenvaleMap"], "TOPRIGHT", 70, -50);
	end
	if (WorldMapFrame and hookWorldMap) then
		hooksecurefunc(WorldMapFrame, "OnMapChanged", function()
			NWB:refreshAshenvaleMarkers();
		end)
		hookWorldMap = nil;
	end
	--if (not NWB:isAshenvaleTimerValid()) then
		--Hide markers when no timer.
	--	NWB.dragonLibPins:RemoveWorldMapIcon("AllianceNWBAshenvaleMap", _G["AllianceNWBAshenvaleMap"]);
	--	NWB.dragonLibPins:RemoveWorldMapIcon("HordeNWBAshenvaleMap", _G["HordeNWBAshenvaleMap"]);
	--else
		for k, v in pairs(ashenvaleMapMarkerTypes) do
			NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBAshenvaleMap", _G[k .. "NWBAshenvaleMap"]);
			if (NWB.db.global.showWorldMapMarkers and _G[k .. "NWBAshenvaleMap"]) then
				NWB.dragonLibPins:AddWorldMapIconMap(k .. "NWBAshenvaleMap", _G[k .. "NWBAshenvaleMap"], v.mapID,
						v.x / 100, v.y / 100, HBD_PINS_WORLDMAP_SHOW_PARENT);
			end
		end
	--end
	if (not updateOnly) then
		NWB:updateWorldbuffMarkersScale();
	end
end

local ashnevaleOverlay;
local function updateAshnevaleOverlay()
	if (NWB:isAshenvaleTimerValid()) then
		local alliance, horde = NWB:getAshenvalePercent();
		 ashnevaleOverlay.fsBottomLeft:SetText("|cFFFFFF00" .. alliance .. "%");
		 ashnevaleOverlay.fsBottomRight:SetText("|cFFFFFF00" .. horde .. "%");
		 ashnevaleOverlay.fsBottom:SetText("");
	elseif (NWB:isAshenvaleTimerExpired()) then
		local alliance, horde = NWB:getAshenvalePercent();
		 ashnevaleOverlay.fsBottomLeft:SetText("|cFFFF6900" .. alliance .. "%");
		 ashnevaleOverlay.fsBottomRight:SetText("|cFFFF6900" .. horde .. "%");
		 ashnevaleOverlay.fsBottom:SetText(NWB:getAshenvaleTimerExpiredString(true));
	else
		ashnevaleOverlay.fsBottomLeft:SetText("--");
		 ashnevaleOverlay.fsBottomRight:SetText("--");
		 ashnevaleOverlay.fsBottom:SetText("");
	end
end

local function loadAshenvaleOverlay()
	if (not ashnevaleOverlay) then
		local frame = CreateFrame("Frame", "NWB_AshenvaleOverlay", UIParent);
		frame:SetFrameLevel(8);
		frame.background = CreateFrame("Frame", "NWB_AshenvaleOverlayBackground", frame, "BackdropTemplate");	
		frame.background:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8x8",
		});
		frame.background:SetBackdropColor(0, 0, 0);
		frame.background:SetAlpha(0);
		frame.background:SetAllPoints();
		frame.background:SetFrameLevel(7);
		frame:SetMovable(true);
		frame:EnableMouse(true);
		frame:SetUserPlaced(false);
		if (NWB.db.global[frame:GetName() .. "_point"]) then
			frame.ignoreFramePositionManager = true;
			frame:ClearAllPoints();
			frame:SetPoint(NWB.db.global[frame:GetName() .. "_point"], nil, NWB.db.global[frame:GetName() .. "_relativePoint"],
					NWB.db.global[frame:GetName() .. "_x"], NWB.db.global[frame:GetName() .. "_y"]);
			frame:SetUserPlaced(false);
		else
			frame:SetPoint("CENTER", UIParent, 0, 100);
		end
		frame:SetSize(80, 75);
		frame:SetScript("OnMouseDown", function(self, button)
			if (button == "LeftButton" and not self.isMoving) then
				self:StartMoving();
				self.isMoving = true;
				if (notSpecialFrames) then
					self:SetUserPlaced(false);
				end
			end
		end)
		frame:SetScript("OnMouseUp", function(self, button)
			if (button == "LeftButton" and self.isMoving) then
				self:StopMovingOrSizing();
				self.isMoving = false;
				frame:SetUserPlaced(false);
				NWB.db.global[frame:GetName() .. "_point"], _, NWB.db.global[frame:GetName() .. "_relativePoint"], 
						NWB.db.global[frame:GetName() .. "_x"], NWB.db.global[frame:GetName() .. "_y"] = frame:GetPoint();
			end
		end)
		frame:SetScript("OnHide", function(self)
			if (self.isMoving) then
				self:StopMovingOrSizing();
				self.isMoving = false;
			end
		end)
		frame.lastUpdate = 0;
		frame:SetScript("OnUpdate", function(self)
			--Update throddle.
			if (GetTime() - frame.lastUpdate > 1) then
				frame.lastUpdate = GetTime();
				updateAshnevaleOverlay();
			end
		end)
		frame:SetScript("OnEnter", function(self)
			frame.background:SetAlpha(0.5);
		end);
		frame:SetScript("OnLeave", function(self)
			frame.background:SetAlpha(0);
		end);
		frame:SetFrameStrata("HIGH");
		frame:SetClampedToScreen(true);
		frame.fsTitle = frame:CreateFontString("NWB_AshenvaleOverlayFSTitle", "ARTWORK");
		frame.fsTitle:SetPoint("CENTER", 0, 23);
		frame.fsTitle:SetFont("Fonts\\FRIZQT__.ttf", 13, "OUTLINE");
		frame.fsTitle:SetText("|cFFFFFF00" .. L["Ashenvale"]);
		frame.fsBottom = frame:CreateFontString("NWB_AshenvaleOverlayFSBottom", "ARTWORK");
		frame.fsBottom:SetPoint("CENTER", 0, -32);
		frame.fsBottom:SetFont("Fonts\\FRIZQT__.ttf", 8, "OUTLINE");
		frame.fsBottomLeft = frame:CreateFontString("NWB_AshenvaleOverlayFSBottomLeft", "ARTWORK");
		frame.fsBottomLeft:SetPoint("CENTER", -18, -18);
		frame.fsBottomLeft:SetFont("Fonts\\FRIZQT__.ttf", 13, "OUTLINE");
		frame.fsBottomRight = frame:CreateFontString("NWB_AshenvaleOverlayFSBottomRight", "ARTWORK");
		frame.fsBottomRight:SetPoint("CENTER", 23, -18);
		frame.fsBottomRight:SetFont("Fonts\\FRIZQT__.ttf", 13, "OUTLINE");
		frame.textureLeft = frame:CreateTexture(nil, "ARTWORK");
		frame.textureLeft:SetTexture("Interface\\worldstateframe\\alliancetower.blp");
		frame.textureLeft:SetPoint("CENTER", -14, -6);
		frame.textureLeft:SetSize(42, 42);
		frame.textureRight = frame:CreateTexture(nil, "ARTWORK");
		frame.textureRight:SetTexture("Interface\\worldstateframe\\hordetower.blp");
		frame.textureRight:SetPoint("CENTER", 26, -6);
		frame.textureRight:SetSize(42, 42);
		frame:Hide();
		ashnevaleOverlay = frame;
	end
	NWB:setAshenvaleOverlayState();
end

function NWB:setAshenvaleOverlayState()
	if (not ashnevaleOverlay) then
		return;
	end
	if (NWB.db.global.showAshenvaleOverlay) then
		ashnevaleOverlay:Show();
	else
		ashnevaleOverlay:Hide();
	end
	if (NWB.db.global.lockAshenvaleOverlay) then
		ashnevaleOverlay:EnableMouse(false);
	else
		ashnevaleOverlay:EnableMouse(true);
	end
	NWB:refreshAshenvaleOverlay();
end

function NWB:refreshAshenvaleOverlay()
	if (not ashnevaleOverlay) then
		return;
	end
	ashnevaleOverlay:SetScale(NWB.db.global.ashenvaleOverlayScale);
	ashnevaleOverlay.fsTitle:SetFont(NWB.LSM:Fetch("font", NWB.db.global.ashenvaleOverlayFont), 13, "OUTLINE");
	ashnevaleOverlay.fsBottom:SetFont(NWB.LSM:Fetch("font", NWB.db.global.ashenvaleOverlayFont), 8, "OUTLINE");
	ashnevaleOverlay.fsBottomLeft:SetFont(NWB.LSM:Fetch("font", NWB.db.global.ashenvaleOverlayFont), 13, "OUTLINE");
	ashnevaleOverlay.fsBottomRight:SetFont(NWB.LSM:Fetch("font", NWB.db.global.ashenvaleOverlayFont), 13, "OUTLINE");
end

function NWB:loadAshenvale()
	if (not NWB.isSOD) then
		return;
	end
	createAshenvaleMarkers();
	loadAshenvaleOverlay();
end]]