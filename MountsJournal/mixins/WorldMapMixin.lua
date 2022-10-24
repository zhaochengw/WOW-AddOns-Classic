MJMapCanvasMixin = {}


function MJMapCanvasMixin:onLoad()
	self.navBar = self:GetParent().navBar
	self.child = self.ScrollContainer.Child
	self.highlight = self.child.HighlightTexture
	self.detailLayerPool = CreateFramePool("FRAME", self.child, "MapCanvasDetailLayerTemplate")
	self.explorationLayerPool = CreateTexturePool(self.child.Exploration, "ARTWORK", 0)
	self.navigation = LibStub("LibSFDropDown-1.4"):CreateButtonOriginal(self)
	self.navigation:SetFrameLevel(self:GetFrameLevel() + 10)
	self.navigation:SetPoint("TOPLEFT", 2, -5)
	self.navigation:ddSetInitFunc(function(...) self:dropDownInit(...) end)
end


function MJMapCanvasMixin:onUpdate()
	-- MAP HIGHLIGHT
	local fileDataID, atlasID, texPercentageX, texPercentageY, textureX, textureY, scrollChildX, scrollChildY = C_Map.GetMapHighlightInfoAtPosition(self.mapID, self:getCursorPosition())

	if fileDataID and fileDataID > 0 or atlasID then
		self.highlight:SetTexCoord(0, texPercentageX, 0, texPercentageY)
		local width = self.child:GetWidth()
		local height = self.child:GetHeight()
		self.highlight:ClearAllPoints()
		if atlasID then
			self.highlight:SetAtlas(atlasID, true, "TRILINEAR")
			scrollChildX = (scrollChildX + .5 * textureX - .5) * width
			scrollChildY = -(scrollChildY + .5 * textureY - .5) * height
			self.highlight:SetPoint("CENTER", scrollChildX, scrollChildY)
		else
			self.highlight:SetTexture(fileDataID, nil, nil, "TRILINEAR")
			textureX = textureX * width
			textureY = textureY * height
			scrollChildX = scrollChildX * width
			scrollChildY = -scrollChildY * height
			if textureX > 0 and textureY > 0 then
				self.highlight:SetWidth(textureX)
				self.highlight:SetHeight(textureY)
				self.highlight:SetPoint("TOPLEFT", scrollChildX, scrollChildY)
			end
		end
		self.highlight:Show()
	else
		self.highlight:Hide()
	end
end


function MJMapCanvasMixin:dropDownInit(btn, level)
	local mapGroupID = C_Map.GetMapGroupID(self.mapID)
	if not mapGroupID then return end

	local mapGroupMembersInfo = C_Map.GetMapGroupMembersInfo(mapGroupID)
	if not mapGroupMembersInfo then return end

	local function goToMap(button)
		self.navBar:setMapID(button.value)
	end

	local info = {}
	for _, mapInfo in ipairs(mapGroupMembersInfo) do
		info.text = mapInfo.name
		info.value = mapInfo.mapID
		info.checked = self.mapID == mapInfo.mapID
		info.func = goToMap
		btn:ddAddButton(info, level)
	end
end


function MJMapCanvasMixin:onClick(btn)
	if btn == "LeftButton" then
		local mapInfo = C_Map.GetMapInfoAtPosition(self.mapID, self:getCursorPosition())
		if mapInfo and mapInfo.mapID ~= self.mapID then
			self.navBar:setMapID(mapInfo.mapID)
		end
	else
		local mapInfo = C_Map.GetMapInfo(self.mapID)
		if mapInfo.parentMapID > 0 then
			self.navBar:setMapID(mapInfo.parentMapID)
		elseif mapInfo.mapID ~= self.navBar.defMapID then
			self.navBar:setDefMap()
		end
	end
end


function MJMapCanvasMixin:refresh()
	self:refreshLayers()

	local mapGroupID = C_Map.GetMapGroupID(self.mapID)
	if mapGroupID then
		local mapGroupInfo = C_Map.GetMapGroupMembersInfo(mapGroupID)
		if mapGroupInfo then
			for _, mapInfo in ipairs(mapGroupInfo) do
				if mapInfo.mapID == self.mapID then
					self.navigation:ddSetSelectedText(mapInfo.name)
					self.navigation:Show()
					return
				end
			end
		end
	end
	self.navigation:Hide()
end


function MJMapCanvasMixin:onShow()
	self:refresh()
	self.navBar:on("MAP_CHANGE.WORLDMAP", function() self:refresh() end)
end


function MJMapCanvasMixin:onHide()
	self.navBar:off("MAP_CHANGE.WORLDMAP")
end


-- Need for MapCanvasDetailLayerTemplate (MapCanvasDetailLayerMixin)
function MJMapCanvasMixin:AddMaskableTexture() end


function MJMapCanvasMixin:refreshLayers()
	self.mapID = self.navBar.mapID
	self.detailLayerPool:ReleaseAll()
	self.explorationLayerPool:ReleaseAll()

	local layers = C_Map.GetMapArtLayers(self.mapID)
	if not layers then return end
	self:setCanvasSize(layers[1].layerWidth, layers[1].layerHeight)
	for index, layerInfo in ipairs(layers) do
		local detailLayer = self.detailLayerPool:Acquire()
		detailLayer:SetAllPoints(self.child)
		detailLayer:SetMapAndLayer(self.mapID, index, self)
		detailLayer:SetGlobalAlpha(1)
		detailLayer:Show()
	end

	local exploredMapTextures = C_MapExplorationInfo.GetExploredMapTextures(self.mapID)
	if exploredMapTextures then
		local tileWidth = layers[1].tileWidth
		local tileHeight = layers[1].tileHeight

		for i, exploredTextureInfo in ipairs(exploredMapTextures) do
			local numTexturesWide = ceil(exploredTextureInfo.textureWidth/tileWidth)
			local numTexturesTall = ceil(exploredTextureInfo.textureHeight/tileHeight)
			local texturePixelWidth, textureFileWidth, texturePixelHeight, textureFileHeight
			for j = 1, numTexturesTall do
				if j < numTexturesTall then
					texturePixelHeight = tileHeight
					textureFileHeight = tileHeight
				else
					texturePixelHeight = mod(exploredTextureInfo.textureHeight, tileHeight)
					if texturePixelHeight == 0 then
						texturePixelHeight = tileHeight
					end
					textureFileHeight = 16
					while(textureFileHeight < texturePixelHeight) do
						textureFileHeight = textureFileHeight * 2
					end
				end
				for k = 1, numTexturesWide do
					local texture = self.explorationLayerPool:Acquire()
					if k < numTexturesWide then
						texturePixelWidth = tileWidth
						textureFileWidth = tileWidth
					else
						texturePixelWidth = mod(exploredTextureInfo.textureWidth, tileWidth)
						if texturePixelWidth == 0 then
							texturePixelWidth = tileWidth
						end
						textureFileWidth = 16
						while(textureFileWidth < texturePixelWidth) do
							textureFileWidth = textureFileWidth * 2
						end
					end
					texture:SetWidth(texturePixelWidth)
					texture:SetHeight(texturePixelHeight)
					texture:SetTexCoord(0, texturePixelWidth/textureFileWidth, 0, texturePixelHeight/textureFileHeight)
					texture:SetPoint("TOPLEFT", exploredTextureInfo.offsetX + (tileWidth * (k-1)), -(exploredTextureInfo.offsetY + (tileHeight * (j - 1))))
					texture:SetTexture(exploredTextureInfo.fileDataIDs[((j - 1) * numTexturesWide) + k], nil, nil, "TRILINEAR")

					if not exploredTextureInfo.isShownByMouseOver then
						texture:SetDrawLayer("ARTWORK", 0)
						texture:Show()
					end
				end
			end
		end
	end
end


function MJMapCanvasMixin:setCanvasSize(width, height)
	local child = self.child
	local scroll = self.ScrollContainer
	child:SetSize(width, height)

	self.currentScale = min(scroll:GetWidth() / child:GetWidth(), scroll:GetHeight() / child:GetHeight())
	child:SetScale(self.currentScale)
end


function MJMapCanvasMixin:normalizeHorizontalSize(size)
	return size / self.child:GetWidth()
end


function MJMapCanvasMixin:normalizeVerticalSize(size)
	return size / self.child:GetHeight()
end


function MJMapCanvasMixin:getCursorPosition()
	local x, y = GetCursorPosition()
	local scale = UIParent:GetEffectiveScale() * self.currentScale
	x, y = x / scale, y / scale
	return Saturate(self:normalizeHorizontalSize(x - self.child:GetLeft())), Saturate(self:normalizeVerticalSize(self.child:GetTop() - y))
end