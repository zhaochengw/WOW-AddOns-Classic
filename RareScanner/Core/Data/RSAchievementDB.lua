-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSAchievementDB = private.NewLib("RareScannerAchievementDB")

-- RareScanner database libraries
local RSMapDB = private.ImportLib("RareScannerMapDB")

-- RareScanner internal libraries
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")


---============================================================================
-- Achievements database
---============================================================================

local cachedAchievements = {}
local cachedCompletedAchievement = {}

local function QueryAchievementState(achievementID)
	if (cachedAchievements[achievementID]) then
		return
	end
	
	cachedAchievements[achievementID] = {}

	local _, _, _, completed, _, _, _, _, _, icon, _, _, _, _, _ = GetAchievementInfo(achievementID)
	if (not completed) then		
		local achievementNumCriteria = GetAchievementNumCriteria(achievementID) 
		if (achievementNumCriteria == 0) then
			cachedAchievements[achievementID][0] = true
		else
			for i = 1, achievementNumCriteria do
				local _, _, completed, _, _, _, _, assetID, _, _, _, _, _ = GetAchievementCriteriaInfo(achievementID, i)
				if (not completed) then
					cachedAchievements[achievementID][assetID] = true
					cachedAchievements[achievementID][i] = true
				end
			end
		end
	else
		cachedCompletedAchievement[achievementID] = true
	end
end

local function IsAchievementCompleted(achievementID, entityID, questIDs, criteriaIndex, isContainer)
	QueryAchievementState(achievementID)

	if (cachedAchievements[achievementID][0] or (not isContainer and cachedAchievements[achievementID][entityID]) or (criteriaIndex and cachedAchievements[achievementID][criteriaIndex])) then
		return false
	end
	
	-- If its a container check the questID because some container achievements dont have criteria and this is the only way we can control if its completed
	if (not cachedCompletedAchievement[achievementID] and isContainer and questIDs) then
		for _, questID in ipairs(questIDs) do
			if (not C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)) then
				return false
			end
		end
	end
	
	return true
end

function RSAchievementDB.GetCachedAchievementLink(achievementID)
	if (achievementID) then
		QueryAchievementState(achievementID)
		
		if (not cachedAchievements[achievementID].link) then
			cachedAchievements[achievementID].link = GetAchievementLink(achievementID)
		end
		
		return cachedAchievements[achievementID].link
	end
	
	return nil
end

function RSAchievementDB.GetCachedAchievementIcon(achievementID)
	if (achievementID) then
		local _, _, _, _, _, _, _, _, _, icon, _, _, _, _, _ = GetAchievementInfo(achievementID)
		return icon
	end
	
	return nil
end

function RSAchievementDB.GetNotCompletedAchievementIDsByMap(entityID, mapID, achievementIDs, questIDs, criteriaIndex, isContainer)
	if (achievementIDs and mapID and entityID) then
		local parentMapID = mapID
		while (not private.ACHIEVEMENT_ZONE_IDS[parentMapID] and parentMapID) do
			parentMapID = RSMapDB.GetParentMapID(parentMapID)
		end
		
		if (parentMapID and private.ACHIEVEMENT_ZONE_IDS[parentMapID]) then
			local notCompletedAchievementIDs = { }
			
			for _, achievementID in ipairs(private.ACHIEVEMENT_ZONE_IDS[parentMapID]) do
				if (RSUtils.Contains(achievementIDs, achievementID) and not IsAchievementCompleted(achievementID, entityID, questIDs, criteriaIndex, isContainer)) then
					tinsert(notCompletedAchievementIDs, achievementID);
				end
			end
			
			return notCompletedAchievementIDs
		end
	end

	return nil
end

function RSAchievementDB.IsNotCompletedAchievementCriteria(entityID, achievementIDs, questIDs, criteriaIndex, isContainer)
	if (entityID) then
		for _, achievementID in ipairs(achievementIDs) do
			return not IsAchievementCompleted(achievementID, entityID, questIDs, criteriaIndex, isContainer)
		end
	end

	return false
end

function RSAchievementDB.RefreshAchievementCache(achievementID)
	if (achievementID) then
		cachedAchievements[achievementID] = nil
		QueryAchievementState(achievementID)
	end
end