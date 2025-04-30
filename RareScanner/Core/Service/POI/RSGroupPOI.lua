-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSGroupPOI = private.NewLib("RareScannerGroupPOI")

-- RareScanner general libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")

---============================================================================
-- Utils to set the correct textures depending on the group entities
--- Textures are ordered by importance:
--- 1. RecentlySeen (pink)
--- 2. Achievement not discovered
--- 3. Not discovered (red)
--- 4. Achievement discovered (green)
--- 5. Normal state
--- 6. Dead (blue)
--- 7. Friendly (light blue); only NPCs
---============================================================================

local function GetNumOfEntities(POIs)
	local npcs = 0
	local containers = 0
	for _, POI in ipairs(POIs) do
		-- Usually we will set rare NPCs in the top position, containers in the left and events in the right
		if (POI.isNpc) then
			npcs = npcs + 1;
		elseif (POI.isContainer) then
			containers = containers + 1
		end
	end

	return npcs, containers
end

---============================================================================
-- Container textures
---============================================================================

local function GetContainerLeftTexture(POI)
	if (RSUtils.Contains(POI.Texture, RSConstants.PINK_CONTAINER_TEXTURE_FILE)) then
		return RSConstants.GROUP_PINK_CONTAINER_L_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.RED_CONTAINER_TEXTURE_FILE)) then
		return RSConstants.GROUP_RED_CONTAINER_L_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.NORMAL_CONTAINER_TEXTURE_FILE)) then
		return RSConstants.GROUP_NORMAL_CONTAINER_L_TEXTURE
	end
end

local function GetContainerRightTexture(POI)
	if (RSUtils.Contains(POI.Texture, RSConstants.PINK_CONTAINER_TEXTURE_FILE)) then
		return RSConstants.GROUP_PINK_CONTAINER_R_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.RED_CONTAINER_TEXTURE_FILE)) then
		return RSConstants.GROUP_RED_CONTAINER_R_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.NORMAL_CONTAINER_TEXTURE_FILE)) then
		return RSConstants.GROUP_NORMAL_CONTAINER_R_TEXTURE
	end
end

local function GetContainerTopTexture(POI)
	if (RSUtils.Contains(POI.Texture, RSConstants.PINK_CONTAINER_TEXTURE_FILE)) then
		return RSConstants.GROUP_PINK_CONTAINER_T_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.RED_CONTAINER_TEXTURE_FILE)) then
		return RSConstants.GROUP_RED_CONTAINER_T_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.NORMAL_CONTAINER_TEXTURE_FILE)) then
		return RSConstants.GROUP_NORMAL_CONTAINER_T_TEXTURE
	end
end

local function GetContainerTextures(POIs)
	local top, right, left
	for i, POI in ipairs (POIs) do
		if (not top) then
			top = GetContainerTopTexture(POI)
		elseif (not right) then
			right = GetContainerRightTexture(POI)
		elseif (not left) then
			left = GetContainerLeftTexture(POI)
		else
			break
		end
	end

	return top, right, left
end

---============================================================================
-- Npc textures
---============================================================================

local function GetNpcLeftTexture(POI)
	if (RSUtils.Contains(POI.Texture, RSConstants.PINK_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_PINK_NPC_L_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.RED_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_RED_NPC_L_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.NORMAL_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_NORMAL_NPC_L_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.LIGHT_BLUE_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_LIGHT_BLUE_NPC_L_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.PURPLE_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_PURPLE_NPC_L_TEXTURE
	end
end

local function GetNpcRightTexture(POI)
	if (RSUtils.Contains(POI.Texture, RSConstants.PINK_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_PINK_NPC_R_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.RED_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_RED_NPC_R_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.NORMAL_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_NORMAL_NPC_R_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.LIGHT_BLUE_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_LIGHT_BLUE_NPC_R_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.PURPLE_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_PURPLE_NPC_R_TEXTURE
	end
end

local function GetNpcTopTexture(POI)
	if (RSUtils.Contains(POI.Texture, RSConstants.PINK_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_PINK_NPC_T_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.RED_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_RED_NPC_T_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.NORMAL_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_NORMAL_NPC_T_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.LIGHT_BLUE_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_LIGHT_BLUE_NPC_T_TEXTURE
	elseif (RSUtils.Contains(POI.Texture, RSConstants.PURPLE_NPC_TEXTURE_FILE)) then
		return RSConstants.GROUP_PURPLE_NPC_T_TEXTURE
	end
end

local function GetNpcTextures(POIs)
	local top, right, left
	for i, POI in ipairs (POIs) do
		if (not top) then
			top = GetNpcTopTexture(POI)
		elseif (not right) then
			right = GetNpcRightTexture(POI)
		elseif (not left) then
			left = GetNpcLeftTexture(POI)
		else
			break;
		end
	end

	return top, right, left
end

---============================================================================
-- POI Utils
---============================================================================

function RSGroupPOI.GetGroupPOI(POIs)
	local groupPOI = {}
	groupPOI.isGroup = true
	groupPOI.POIs = POIs
	-- Take the coordinates of one of the POIs, it doesnt matter because they are toGether
	groupPOI.x = RSUtils.FixCoord(POIs[1].x)
	groupPOI.y = RSUtils.FixCoord(POIs[1].y)

	if (POIs) then
		-- Usually we will set rare NPCs in the top position, containers in the left and events in the right
		local numNpcs, numContainers = GetNumOfEntities(POIs)

		-- If only containers
		if (numNpcs == 0 and numContainers > 0) then
			groupPOI.TopTexture, groupPOI.RightTexture, groupPOI.LeftTexture = GetContainerTextures(POIs)
		-- If only npcs
		elseif (numNpcs > 0 and numContainers == 0) then
			groupPOI.TopTexture, groupPOI.RightTexture, groupPOI.LeftTexture = GetNpcTextures(POIs)
		-- If only npcs and containers
		elseif (numNpcs > 0 and numContainers > 0) then
			-- Show more npcs than containers (if there are more than 2 npcs)
			for _, POI in ipairs (POIs) do
				if (not groupPOI.TopTexture and POI.isNpc) then
					groupPOI.TopTexture = GetNpcTopTexture(POI)
				elseif (not groupPOI.RightTexture and POI.isContainer) then
					groupPOI.RightTexture = GetContainerRightTexture(POI)
				elseif (numNpcs > 1 and not groupPOI.LeftTexture and POI.isNpc) then
					groupPOI.LeftTexture = GetNpcLeftTexture(POI)
				elseif (not groupPOI.LeftTexture and POI.isContainer) then
					groupPOI.LeftTexture = GetContainerLeftTexture(POI)
				else
					break;
				end
			end
		-- If everything
		else
			for _, POI in ipairs (POIs) do
				if (not groupPOI.TopTexture and POI.isNpc) then
					groupPOI.TopTexture = GetNpcTopTexture(POI)
				elseif (not groupPOI.LeftTexture and POI.isContainer) then
					groupPOI.LeftTexture = GetContainerLeftTexture(POI)
				else
					break;
				end
			end
		end
		
		-- If proffesions
		for _, POI in ipairs(POIs) do
			if (POI.iconAtlas) then
				groupPOI.iconAtlas = POI.iconAtlas
				break
			end
		end
	end

	return groupPOI
end
