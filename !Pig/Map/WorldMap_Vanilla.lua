local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
local fuFrame=List_R_F_1_8
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local MapData=addonTable.MapData
-------
local WorldMapScrollChild = WorldMapFrame.ScrollContainer.Child
local function MouseXY()
	local left, top = WorldMapScrollChild:GetLeft(), WorldMapScrollChild:GetTop()
	local width, height = WorldMapScrollChild:GetWidth(), WorldMapScrollChild:GetHeight()
	local scale = WorldMapScrollChild:GetEffectiveScale()
	local x, y = GetCursorPosition()
	local cx = (x/scale - left) / width
	local cy = (top - y/scale) / height
	if cx < 0 or cx > 1 or cy < 0 or cy > 1 then
		return
	end
	return cx, cy
end
----------
local function WorldMap_Wind()
	UIPanelWindows["WorldMapFrame"] = nil
	table.insert(UISpecialFrames, "WorldMapFrame")
	WorldMapFrame.IsMaximized = function() return false end
	WorldMapFrame.HandleUserActionToggleSelf = function()
		if WorldMapFrame:IsShown() then WorldMapFrame:Hide() else WorldMapFrame:Show() end
	end
	WorldMapFrame:SetMovable(true)
	WorldMapFrame:RegisterForDrag("LeftButton")

	WorldMapFrame:SetScript("OnDragStart", function(self)
		self:StartMoving()
	end)
	WorldMapFrame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		self:SetUserPlaced(false)
	end)
	---
	local Width,Height=800,618;--1004 689
	WorldMapFrame:SetSize(Width,Height);
	WorldMapFrame:SetFrameStrata("HIGH")
	WorldMapFrame.BorderFrame:SetFrameStrata("LOW")
	WorldMapFrame.BorderFrame:SetScale(0.78)
	WorldMapFrame.BorderFrame:SetPoint("TOPLEFT", WorldMapFrame, "TOPLEFT", 0, -14)
	WorldMapFrame.BorderFrame:SetPoint("BOTTOMRIGHT", WorldMapFrame, "BOTTOMRIGHT", 0, 0)
	WorldMapFrame.BlackoutFrame:SetFrameStrata("LOW")
	WorldMapFrame.BlackoutFrame:Hide()
	WorldMapFrameCloseButton:ClearAllPoints();
	WorldMapFrameCloseButton:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", 4, -12)
	WorldMapFrameCloseButton:SetScale(0.86)
	WorldMapMagnifyingGlassButton:ClearAllPoints();
	WorldMapMagnifyingGlassButton:SetPoint("TOPLEFT", WorldMapFrame, "TOPLEFT", 10, -70)
	WorldMapZoneMinimapDropDown:SetScale(0.86)
	WorldMapContinentDropDown:SetScale(0.86)
	WorldMapZoneDropDown:SetScale(0.86)
	WorldMapZoomOutButton:SetScale(0.86)
	WorldMapContinentDropDown:SetPoint("TOP", WorldMapFrame, "TOP", -40, -50)
end
local function WorldMap_XY()
	WorldMapFrame.zuobiaoX = WorldMapFrame:CreateFontString();
	WorldMapFrame.zuobiaoX:SetPoint("BOTTOM", WorldMapFrame, "BOTTOM", -200, 9);
	WorldMapFrame.zuobiaoX:SetFontObject(GameFontNormal);
	WorldMapFrame.zuobiaoX:SetText('玩家 X:');

	WorldMapFrame.zuobiaoXV = WorldMapFrame:CreateFontString();
	WorldMapFrame.zuobiaoXV:SetPoint("LEFT", WorldMapFrame.zuobiaoX, "RIGHT", 0, 0);
	WorldMapFrame.zuobiaoXV:SetFont(GameFontNormal:GetFont(), 14,"OUTLINE")

	WorldMapFrame.zuobiaoY = WorldMapFrame:CreateFontString();
	WorldMapFrame.zuobiaoY:SetPoint("LEFT", WorldMapFrame.zuobiaoX, "RIGHT", 50, 0);
	WorldMapFrame.zuobiaoY:SetFontObject(GameFontNormal);
	WorldMapFrame.zuobiaoY:SetText('Y:');
	WorldMapFrame.zuobiaoYV = WorldMapFrame:CreateFontString();
	WorldMapFrame.zuobiaoYV:SetPoint("LEFT", WorldMapFrame.zuobiaoY, "RIGHT", 0, 0);
	WorldMapFrame.zuobiaoYV:SetFont(GameFontNormal:GetFont(), 14,"OUTLINE")

	WorldMapFrame.shubiaoX = WorldMapFrame:CreateFontString();
	WorldMapFrame.shubiaoX:SetPoint("BOTTOM", WorldMapFrame, "BOTTOM", 100, 9);
	WorldMapFrame.shubiaoX:SetFontObject(GameFontNormal);
	WorldMapFrame.shubiaoX:SetText('鼠标 X:');

	WorldMapFrame.shubiaoXV = WorldMapFrame:CreateFontString();
	WorldMapFrame.shubiaoXV:SetPoint("LEFT", WorldMapFrame.shubiaoX, "RIGHT", 0, 0);
	WorldMapFrame.shubiaoXV:SetFont(GameFontNormal:GetFont(), 14,"OUTLINE")

	WorldMapFrame.shubiaoY = WorldMapFrame:CreateFontString();
	WorldMapFrame.shubiaoY:SetPoint("LEFT", WorldMapFrame.shubiaoX, "RIGHT", 50, 0);
	WorldMapFrame.shubiaoY:SetFontObject(GameFontNormal);
	WorldMapFrame.shubiaoY:SetText('Y:');
	WorldMapFrame.shubiaoYV = WorldMapFrame:CreateFontString();
	WorldMapFrame.shubiaoYV:SetPoint("LEFT", WorldMapFrame.shubiaoY, "RIGHT", 0, 0);
	WorldMapFrame.shubiaoYV:SetFont(GameFontNormal:GetFont(), 14,"OUTLINE")

	WorldMapFrame:HookScript("OnUpdate", function(self)
		local mapinfo = C_Map.GetBestMapForUnit("player"); 
		if not mapinfo then return end
		local pos = C_Map.GetPlayerMapPosition(mapinfo,"player");
		if not pos then return end
		--local zuobiaoBB = C_Map.GetMapInfo(mapinfo).name, 
		local zuobiaoXX,zuobiaoYY = math.ceil(pos.x*10000)/100, math.ceil(pos.y*10000)/100
		self.zuobiaoXV:SetText(zuobiaoXX);
		self.zuobiaoYV:SetText(zuobiaoYY);
		local xxx, yyy = MouseXY()
		if xxx and yyy then
			local xxx =math.ceil(xxx*10000)/100
			local yyy =math.ceil(yyy*10000)/100
			self.shubiaoXV:SetText(xxx);
			self.shubiaoYV:SetText(yyy);
		end
	end);
end
local function WorldMap_LVSkill()
	local floor = math.floor
	local format = string.format
	local zoneData=MapData.zoneData
	local AreaLabel_OnUpdate = function(self)
		self:SetScale(0.6)
		self:ClearLabel(MAP_AREA_LABEL_TYPE.AREA_NAME)
		local map = self.dataProvider:GetMap()
		if (map:IsCanvasMouseFocus()) then
			local name, description
			local mapID = map:GetMapID()
			local normalizedCursorX, normalizedCursorY = MouseXY()
			if mapID and normalizedCursorX and normalizedCursorY then
				local positionMapInfo = C_Map.GetMapInfoAtPosition(mapID, normalizedCursorX, normalizedCursorY)	
				if (positionMapInfo and (positionMapInfo.mapID ~= mapID)) then
					name = positionMapInfo.name
					local playerMinLevel, playerMaxLevel, playerminFish, playerFaction
					--local playerMinLevel, playerMaxLevel, petMinLevel, petMaxLevel = C_Map.GetMapLevels(positionMapInfo.mapID)
					if (zoneData[positionMapInfo.mapID]) then
						playerMinLevel = zoneData[positionMapInfo.mapID].min
						playerMaxLevel = zoneData[positionMapInfo.mapID].max
						playerminFish = zoneData[positionMapInfo.mapID].minFish
						playerFaction = zoneData[positionMapInfo.mapID].faction
					end
					if (playerFaction) then 
						local englishFaction, localizedFaction = UnitFactionGroup("player")
						if (playerFaction == "Alliance") then 
							description = format(FACTION_CONTROLLED_TERRITORY, FACTION_ALLIANCE) 
						elseif (playerFaction == "Horde") then 
							description = format(FACTION_CONTROLLED_TERRITORY, FACTION_HORDE) 
						end 
						if (englishFaction == playerFaction) then 
							description = "|cff00FF00" .. description .. "|r"
						else
							description = "|cffFF0000" .. description .. "|r"
						end 
					end
					if (name and playerMinLevel and playerMaxLevel and (playerMinLevel > 0) and (playerMaxLevel > 0)) then
						local playerLevel = UnitLevel("player")
						local colorbb="|cffFFFF00"
						if (playerLevel < playerMinLevel) then
							colorbb="|cffFF0000"
						elseif (playerLevel > playerMaxLevel+2) then
							colorbb="|cff808080"
						elseif (playerLevel > playerMaxLevel) then
							colorbb="|cff00FF00"
						end
						if PIG.Map.WorldMapLV then
							name = name..colorbb.." ("..playerMinLevel.."-"..playerMaxLevel..")|r"
						end
						if PIG.Map.WorldMapSkill then
							if playerminFish then
								name = name.."\n渔点|cff00FFFF("..playerminFish..")|r"
							end
						end
					end
				else
					name = MapUtil.FindBestAreaNameAtMouse(mapID, normalizedCursorX, normalizedCursorY)
				end
				if name then
					self:SetLabel(MAP_AREA_LABEL_TYPE.AREA_NAME, name, description)
				end
			end
		end
		self:EvaluateLabels()
	end
	for provider in next, WorldMapFrame.dataProviders do
		if provider.setAreaLabelCallback then
			provider.Label:HookScript("OnUpdate", AreaLabel_OnUpdate)
		end
	end
end
local function WorldMap_Miwu()
	---战争迷雾
	local Reveal=MapData.Reveal
	local overlayTextures = {}

	local function MapExplorationPin_RefreshOverlays(pin, fullUpdate)
		overlayTextures = {}
		local mapID = WorldMapFrame.mapID; if not mapID then return end
		local artID = C_Map.GetMapArtID(mapID); if not artID or not Reveal[artID] then return end
		local LeaMapsZone = Reveal[artID]

		local TileExists = {}
		local exploredMapTextures = C_MapExplorationInfo.GetExploredMapTextures(mapID)
		if exploredMapTextures then
			for i, exploredTextureInfo in ipairs(exploredMapTextures) do
				local key = exploredTextureInfo.textureWidth .. ":" .. exploredTextureInfo.textureHeight .. ":" .. exploredTextureInfo.offsetX .. ":" .. exploredTextureInfo.offsetY
				TileExists[key] = true
			end
		end

		pin.layerIndex = pin:GetMap():GetCanvasContainer():GetCurrentLayerIndex()
		local layers = C_Map.GetMapArtLayers(mapID)
		local layerInfo = layers and layers[pin.layerIndex]
		if not layerInfo then return end
		local TILE_SIZE_WIDTH = layerInfo.tileWidth
		local TILE_SIZE_HEIGHT = layerInfo.tileHeight

		for key, files in pairs(LeaMapsZone) do
			if not TileExists[key] then
				local width, height, offsetX, offsetY = strsplit(":", key)
				local fileDataIDs = { strsplit(",", files) }
				local numTexturesWide = ceil(width/TILE_SIZE_WIDTH)
				local numTexturesTall = ceil(height/TILE_SIZE_HEIGHT)
				local texturePixelWidth, textureFileWidth, texturePixelHeight, textureFileHeight
				for j = 1, numTexturesTall do
					if ( j < numTexturesTall ) then
						texturePixelHeight = TILE_SIZE_HEIGHT
						textureFileHeight = TILE_SIZE_HEIGHT
					else
						texturePixelHeight = mod(height, TILE_SIZE_HEIGHT)
						if ( texturePixelHeight == 0 ) then
							texturePixelHeight = TILE_SIZE_HEIGHT
						end
						textureFileHeight = 16
						while(textureFileHeight < texturePixelHeight) do
							textureFileHeight = textureFileHeight * 2
						end
					end
					for k = 1, numTexturesWide do
						local texture = pin.overlayTexturePool:Acquire()
						if ( k < numTexturesWide ) then
							texturePixelWidth = TILE_SIZE_WIDTH
							textureFileWidth = TILE_SIZE_WIDTH
						else
							texturePixelWidth = mod(width, TILE_SIZE_WIDTH)
							if ( texturePixelWidth == 0 ) then
								texturePixelWidth = TILE_SIZE_WIDTH
							end
							textureFileWidth = 16
							while(textureFileWidth < texturePixelWidth) do
								textureFileWidth = textureFileWidth * 2
							end
						end
						texture:SetSize(texturePixelWidth, texturePixelHeight)
						texture:SetTexCoord(0, texturePixelWidth/textureFileWidth, 0, texturePixelHeight/textureFileHeight)
						texture:SetPoint("TOPLEFT", offsetX + (TILE_SIZE_WIDTH * (k-1)), -(offsetY + (TILE_SIZE_HEIGHT * (j - 1))))
						texture:SetTexture(tonumber(fileDataIDs[((j - 1) * numTexturesWide) + k]), nil, nil, "TRILINEAR")
						texture:SetDrawLayer("ARTWORK", -1)
						texture:Show()
						if fullUpdate then
							pin.textureLoadGroup:AddTexture(texture)
						end
						texture:SetVertexColor(0, 1, 0.1, 1)
						tinsert(overlayTextures, texture)
					end
				end
			end
		end
	end

	local function TexturePool_ResetVertexColor(pool, texture)
		texture:SetVertexColor(1, 1, 1)
		texture:SetAlpha(1)
		return TexturePool_HideAndClearAnchors(pool, texture)
	end

	for pin in WorldMapFrame:EnumeratePinsByTemplate("MapExplorationPinTemplate") do
		hooksecurefunc(pin, "RefreshOverlays", MapExplorationPin_RefreshOverlays)
		pin.overlayTexturePool.resetterFunc = TexturePool_ResetVertexColor
	end
end
local function WorldMap_Plus()
	if PIG.Map.WorldMapPlus then
		fuFrame.WorldMapPIG.Wind:Enable()
		fuFrame.WorldMapPIG.XY:Enable()
		fuFrame.WorldMapPIG.LV:Enable()
		fuFrame.WorldMapPIG.Skill:Enable()
		fuFrame.WorldMapPIG.Miwu:Enable()
	else
		fuFrame.WorldMapPIG.Wind:Disable()
		fuFrame.WorldMapPIG.XY:Disable()
		fuFrame.WorldMapPIG.LV:Disable()
		fuFrame.WorldMapPIG.Skill:Disable()
		fuFrame.WorldMapPIG.Miwu:Disable()
	end
	if PIG.Map.WorldMapWind then WorldMap_Wind() end
	if PIG.Map.WorldMapXY then WorldMap_XY() end
	if PIG.Map.WorldMapLV or PIG.Map.WorldMapSkill then WorldMap_LVSkill() end
	if PIG.Map.WorldMapMiwu then WorldMap_Miwu() end
end
------------
fuFrame.WorldMapPIG = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
fuFrame.WorldMapPIG:SetBackdrop( {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 } 
});
fuFrame.WorldMapPIG:SetBackdropColor(0, 0, 0, 0.8);
fuFrame.WorldMapPIG:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
fuFrame.WorldMapPIG:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 300, -138)
fuFrame.WorldMapPIG:SetPoint("BOTTOMRIGHT", fuFrame, "BOTTOMRIGHT", -10, 10)
-----------
fuFrame.WorldMapPIG.Open = ADD_Checkbutton(nil,fuFrame.WorldMapPIG,-80,"TOPLEFT",fuFrame.WorldMapPIG,"TOPLEFT",40,25,"世界地图增强","世界地图增强")
fuFrame.WorldMapPIG.Open:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.Map.WorldMapPlus=true;	
	else
		PIG.Map.WorldMapPlus=false;
		Pig_Options_RLtishi_UI:Show()
	end
	WorldMap_Plus()
end);
--==================================================
fuFrame.WorldMapPIG.Wind = ADD_Checkbutton(nil,fuFrame.WorldMapPIG,-80,"TOPLEFT",fuFrame.WorldMapPIG,"TOPLEFT",20,-20,"窗口化世界地图","窗口化世界地图并使其可以拖动")
fuFrame.WorldMapPIG.Wind:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.Map.WorldMapWind=true;
		WorldMap_Wind()
	else
		PIG.Map.WorldMapWind=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.WorldMapPIG.XY = ADD_Checkbutton(nil,fuFrame.WorldMapPIG,-80,"TOPLEFT",fuFrame.WorldMapPIG,"TOPLEFT",20,-60,"显示玩家坐标","显示玩家在地图坐标")
fuFrame.WorldMapPIG.XY:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.Map.WorldMapXY=true;
		WorldMap_XY()
	else
		PIG.Map.WorldMapXY=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.WorldMapPIG.LV = ADD_Checkbutton(nil,fuFrame.WorldMapPIG,-80,"TOPLEFT",fuFrame.WorldMapPIG,"TOPLEFT",20,-100,"显示等级范围","显示地图的等级范围")
fuFrame.WorldMapPIG.LV:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.Map.WorldMapLV=true;
		WorldMap_LVSkill()
	else
		PIG.Map.WorldMapLV=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.WorldMapPIG.Skill = ADD_Checkbutton(nil,fuFrame.WorldMapPIG,-80,"TOPLEFT",fuFrame.WorldMapPIG,"TOPLEFT",20,-140,"显示钓鱼技能要求","显示地图的钓鱼技能最低要求")
fuFrame.WorldMapPIG.Skill:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.Map.WorldMapSkill=true;
		WorldMap_LVSkill()
	else
		PIG.Map.WorldMapSkill=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.WorldMapPIG.Miwu = ADD_Checkbutton(nil,fuFrame.WorldMapPIG,-80,"TOPLEFT",fuFrame.WorldMapPIG,"TOPLEFT",20,-180,"去除战争迷雾","去除地图战争迷雾")
fuFrame.WorldMapPIG.Miwu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.Map.WorldMapMiwu=true;
		WorldMap_Miwu()
	else
		PIG.Map.WorldMapMiwu=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
-----------
fuFrame:HookScript("OnShow", function ()
	if PIG.Map.WorldMapPlus and fuFrame.WorldMapPIG.Open:IsEnabled() then
		fuFrame.WorldMapPIG.Wind:Enable()
		fuFrame.WorldMapPIG.XY:Enable()
		fuFrame.WorldMapPIG.LV:Enable()
		fuFrame.WorldMapPIG.Skill:Enable()
		fuFrame.WorldMapPIG.Miwu:Enable()
	else
		fuFrame.WorldMapPIG.Wind:Disable()
		fuFrame.WorldMapPIG.XY:Disable()
		fuFrame.WorldMapPIG.LV:Disable()
		fuFrame.WorldMapPIG.Skill:Disable()
		fuFrame.WorldMapPIG.Miwu:Disable()
	end
	if PIG.Map.WorldMapPlus then
		fuFrame.WorldMapPIG.Open:SetChecked(true);
	end
	if PIG.Map.WorldMapWind then 
		fuFrame.WorldMapPIG.Wind:SetChecked(true)
	end
	if PIG.Map.WorldMapXY then 
		fuFrame.WorldMapPIG.XY:SetChecked(true)
	end
	if PIG.Map.WorldMapLV then 
		fuFrame.WorldMapPIG.LV:SetChecked(true)
	end
	if PIG.Map.WorldMapSkill then 
		fuFrame.WorldMapPIG.Skill:SetChecked(true)
	end
	if PIG.Map.WorldMapMiwu then 
		fuFrame.WorldMapPIG.Miwu:SetChecked(true)
	end
end);
--==============================================
addonTable.Map_WorldMap = function()
    if tocversion>50000 then
    	fuFrame.WorldMapPIG.Open:Disable()
    else
		if PIG.Map.WorldMapPlus then
			WorldMap_Plus()
		end
	end
end