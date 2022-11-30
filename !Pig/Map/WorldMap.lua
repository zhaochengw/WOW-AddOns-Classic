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
local function WorldMap_XY()
	WorldMapScrollChild.zuobiaoX = WorldMapScrollChild:CreateFontString();
	WorldMapScrollChild.zuobiaoX:SetPoint("TOP", WorldMapScrollChild, "TOP", -200, -2);
	WorldMapScrollChild.zuobiaoX:SetFont(GameFontNormal:GetFont(), 18,"OUTLINE")
	WorldMapScrollChild.zuobiaoX:SetTextColor(0, 1, 0, 1);
	WorldMapScrollChild.zuobiaoX:SetText('玩家 X:');

	WorldMapScrollChild.zuobiaoXV = WorldMapScrollChild:CreateFontString();
	WorldMapScrollChild.zuobiaoXV:SetPoint("LEFT", WorldMapScrollChild.zuobiaoX, "RIGHT", 0, 0);
	WorldMapScrollChild.zuobiaoXV:SetFont(GameFontNormal:GetFont(), 18,"OUTLINE")
	WorldMapScrollChild.zuobiaoXV:SetTextColor(1, 1, 0, 1);

	WorldMapScrollChild.zuobiaoY = WorldMapScrollChild:CreateFontString();
	WorldMapScrollChild.zuobiaoY:SetPoint("LEFT", WorldMapScrollChild.zuobiaoX, "RIGHT", 50, 0);
	WorldMapScrollChild.zuobiaoY:SetFont(GameFontNormal:GetFont(), 18,"OUTLINE")
	WorldMapScrollChild.zuobiaoY:SetTextColor(0, 1, 0, 1);
	WorldMapScrollChild.zuobiaoY:SetText('Y:');
	WorldMapScrollChild.zuobiaoYV = WorldMapScrollChild:CreateFontString();
	WorldMapScrollChild.zuobiaoYV:SetPoint("LEFT", WorldMapScrollChild.zuobiaoY, "RIGHT", 0, 0);
	WorldMapScrollChild.zuobiaoYV:SetFont(GameFontNormal:GetFont(), 18,"OUTLINE")
	WorldMapScrollChild.zuobiaoYV:SetTextColor(1, 1, 0, 1);

	WorldMapScrollChild.shubiaoX = WorldMapScrollChild:CreateFontString();
	WorldMapScrollChild.shubiaoX:SetPoint("TOP", WorldMapScrollChild, "TOP", 100, -2);
	WorldMapScrollChild.shubiaoX:SetFont(GameFontNormal:GetFont(), 18,"OUTLINE")
	WorldMapScrollChild.shubiaoX:SetTextColor(0, 1, 0, 1);
	WorldMapScrollChild.shubiaoX:SetText('鼠标 X:');

	WorldMapScrollChild.shubiaoXV = WorldMapScrollChild:CreateFontString();
	WorldMapScrollChild.shubiaoXV:SetPoint("LEFT", WorldMapScrollChild.shubiaoX, "RIGHT", 0, 0);
	WorldMapScrollChild.shubiaoXV:SetFont(GameFontNormal:GetFont(), 18,"OUTLINE")
	WorldMapScrollChild.shubiaoXV:SetTextColor(1, 1, 0, 1);

	WorldMapScrollChild.shubiaoY = WorldMapScrollChild:CreateFontString();
	WorldMapScrollChild.shubiaoY:SetPoint("LEFT", WorldMapScrollChild.shubiaoX, "RIGHT", 50, 0);
	WorldMapScrollChild.shubiaoY:SetFont(GameFontNormal:GetFont(), 18,"OUTLINE")
	WorldMapScrollChild.shubiaoY:SetTextColor(0, 1, 0, 1);
	WorldMapScrollChild.shubiaoY:SetText('Y:');
	WorldMapScrollChild.shubiaoYV = WorldMapScrollChild:CreateFontString();
	WorldMapScrollChild.shubiaoYV:SetPoint("LEFT", WorldMapScrollChild.shubiaoY, "RIGHT", 0, 0);
	WorldMapScrollChild.shubiaoYV:SetFont(GameFontNormal:GetFont(), 18,"OUTLINE")
	WorldMapScrollChild.shubiaoYV:SetTextColor(1, 1, 0, 1);

	WorldMapScrollChild:HookScript("OnUpdate", function(self)
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
--==================================================
fuFrame.WorldMapPIG.Open = fuFrame.WorldMapPIG:CreateFontString();
fuFrame.WorldMapPIG.Open:SetPoint("BOTTOM",fuFrame.WorldMapPIG,"TOP",0,0);
fuFrame.WorldMapPIG.Open:SetFontObject(GameFontNormal);
fuFrame.WorldMapPIG.Open:SetText("世界地图增强");
-----------
fuFrame.WorldMapPIG.XY = ADD_Checkbutton(nil,fuFrame.WorldMapPIG,-80,"TOPLEFT",fuFrame.WorldMapPIG,"TOPLEFT",20,-20,"显示玩家坐标","显示玩家在地图坐标")
fuFrame.WorldMapPIG.XY:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.Map.WorldMapXY=true;
		WorldMap_XY()
	else
		PIG.Map.WorldMapXY=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.WorldMapPIG.Miwu = ADD_Checkbutton(nil,fuFrame.WorldMapPIG,-80,"TOPLEFT",fuFrame.WorldMapPIG,"TOPLEFT",20,-60,"去除战争迷雾","去除地图战争迷雾")
fuFrame.WorldMapPIG.Miwu:Hide()
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
	if PIG.Map.WorldMapXY then 
		fuFrame.WorldMapPIG.XY:SetChecked(true)
	end
	if PIG.Map.WorldMapMiwu then 
		fuFrame.WorldMapPIG.Miwu:SetChecked(true)
	end
end);
--==============================================
addonTable.Map_WorldMap = function()
	if PIG.Map.WorldMapXY then WorldMap_XY() end
	--if PIG.Map.WorldMapMiwu then WorldMap_Miwu() end
end