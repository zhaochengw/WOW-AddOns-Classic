local _, L = ...;

----------------------------------------------------------------------------------
------------------------------ STATS PANE FUNCTIONS ------------------------------
----------------------------------------------------------------------------------

local STATCATEGORY_PADDING = 4;
local STATCATEGORY_MOVING_INDENT = 4;
local STRIPE_COLOR = {r=0.9, g=0.9, b=1};

local StatCategoryFrames = {};

-- Creating StatsPane
function MCF_CreateStatsFrame(frame)
    frame.StatsPane = CreateFrame("ScrollFrame", "CharacterStatsPane", frame, "MCF-CharacterStatsPaneTemplate");
end

function MCF_PaperDollFrame_CollapseStatCategory(categoryFrame)
	if (not categoryFrame.collapsed) then
		categoryFrame.collapsed = true;
		local index = 1;
		while (_G[categoryFrame:GetName().."Stat"..index]) do 
			_G[categoryFrame:GetName().."Stat"..index]:Hide();
			index = index + 1;
		end
		categoryFrame.CollapsedIcon:Show();
		categoryFrame.ExpandedIcon:Hide();
		categoryFrame:SetHeight(18);
		MCF_PaperDollFrame_UpdateStatScrollChildHeight();
		categoryFrame.BgMinimized:Show();
		categoryFrame.BgTop:Hide();
		categoryFrame.BgMiddle:Hide();
		categoryFrame.BgBottom:Hide();
	end
end

function MCF_PaperDollFrame_ExpandStatCategory(categoryFrame)
	if (categoryFrame.collapsed) then
		categoryFrame.collapsed = false;
		categoryFrame.CollapsedIcon:Hide();
		categoryFrame.ExpandedIcon:Show();
		MCF_PaperDollFrame_UpdateStatCategory(categoryFrame);
		MCF_PaperDollFrame_UpdateStatScrollChildHeight();
		categoryFrame.BgMinimized:Hide();
		categoryFrame.BgTop:Show();
		categoryFrame.BgMiddle:Show();
		categoryFrame.BgBottom:Show();
	end
end

-- /run MCF_PaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder", "statCategoriesCollapsed", "player");
function MCF_PaperDoll_InitStatCategories(defaultOrder, orderCVarName, collapsedCVarName, unit)
	local category;
	local order = defaultOrder;

	-- Load order from cvar
	if (orderCVarName) then
		local orderString = MCF_GetSettings(orderCVarName);
		local savedOrder = {};
		if (orderString and orderString ~= "") then
			for i in gmatch(orderString, "%d+,?") do
				i = gsub(i, ",", "");
				i = tonumber(i);
				if (i) then
					local categoryName = MCF_PaperDoll_FindCategoryById(i);
					if (categoryName) then
						tinsert(savedOrder, categoryName);
					end
				end
			end
			 
			-- Validate the saved order
			local valid = true;
			if (#savedOrder == #defaultOrder) then
				for i, category1 in next, defaultOrder do
					local found = false;
					for j, category2 in next, savedOrder do
						if (category1 == category2) then
							found = true;
							break;
						end
					end
					if (not found) then
						valid = false;
						break;
					end
				end
			else
				valid = false;
			end
			
			if (valid) then
				order = savedOrder;
			else
				MCF_SetSettings(orderCVarName, "");
			end
		end
	end

	-- Initialize stat frames
	table.wipe(StatCategoryFrames);
	for index=1, #order do
		local frame = _G["CharacterStatsPaneCategory"..index];
		assert(frame);
		tinsert(StatCategoryFrames, frame);
		frame.Category = order[index];
		frame:Show();
		
		-- Expand or collapse
		local categoryInfo = MCF_PAPERDOLL_STATCATEGORIES[frame.Category];
		if (categoryInfo and collapsedCVarName and MCF_GetSettings(collapsedCVarName, categoryInfo.id)) then
			MCF_PaperDollFrame_CollapseStatCategory(frame);
		else
			MCF_PaperDollFrame_ExpandStatCategory(frame);
		end
	end
	
	-- Hide unused stat frames
	local index = #order+1;
	while(_G["CharacterStatsPaneCategory"..index]) do
		_G["CharacterStatsPaneCategory"..index]:Hide();
		_G["CharacterStatsPaneCategory"..index].Category = nil;
		index = index + 1;
	end	
	
	-- Set up stats data
	CharacterStatsPane.defaultOrder = defaultOrder;
	CharacterStatsPane.orderCVarName = orderCVarName;
	CharacterStatsPane.collapsedCVarName = collapsedCVarName;
	CharacterStatsPane.unit = unit;
	
	-- Update
	MCF_PaperDoll_UpdateCategoryPositions();
	MCF_PaperDollFrame_UpdateStats();
end

function MCF_PaperDoll_FindCategoryById(id)
	for categoryName, category in pairs(MCF_PAPERDOLL_STATCATEGORIES) do
		if (category.id == id) then
			return categoryName;
		end
	end
	return nil;
end

function MCF_PaperDollFrame_UpdateStatCategory(categoryFrame)
	if (not categoryFrame.Category) then
		categoryFrame:Hide();
		return;
	end
	
	local categoryInfo = MCF_PAPERDOLL_STATCATEGORIES[categoryFrame.Category];
	
	categoryFrame.NameText:SetText(_G["STAT_CATEGORY_"..categoryFrame.Category]);
	
	if (categoryFrame.collapsed) then
		return;
	end
	
	local stat;
	local totalHeight = categoryFrame.NameText:GetHeight() + 10;
	local numVisible = 0;
	if (categoryInfo) then
		local prevStatFrame = nil;
		for index, stat in next, categoryInfo.stats do
			local statInfo = MCF_PAPERDOLL_STATINFO[stat];
			if (statInfo) then
				local statFrame = _G[categoryFrame:GetName().."Stat"..numVisible+1];
				if (not statFrame) then
					statFrame = CreateFrame("FRAME", categoryFrame:GetName().."Stat"..numVisible+1, categoryFrame, "MCF-StatFrameTemplate");
					if (prevStatFrame) then
						statFrame:SetPoint("TOPLEFT", prevStatFrame, "BOTTOMLEFT", 0, 0);
						statFrame:SetPoint("TOPRIGHT", prevStatFrame, "BOTTOMRIGHT", 0, 0);
					end
				end
				statFrame:Show();
				-- Reset tooltip script in case it's been changed
				statFrame:SetScript("OnEnter", MCF_PaperDollStatTooltip);
				statFrame.tooltip = nil;
				statFrame.tooltip2 = nil;
				statFrame.UpdateTooltip = nil;
				statFrame:SetScript("OnUpdate", nil);
				statInfo.updateFunc(statFrame, CharacterStatsPane.unit);
				if (statFrame:IsShown()) then
					numVisible = numVisible+1;
					totalHeight = totalHeight + statFrame:GetHeight();
					prevStatFrame = statFrame;
					-- Update Tooltip
					if (GameTooltip:GetOwner() == statFrame) then
						statFrame.changed = true;
						statFrame:GetScript("OnEnter")(statFrame);
					end
				end
			end
		end
	end
	
	local i;
	for index=1, numVisible do
		if (index%2 == 0) then
			local statFrame = _G[categoryFrame:GetName().."Stat"..index];
			if (not statFrame.Bg) then
				statFrame.Bg = statFrame:CreateTexture(statFrame:GetName().."Bg", "BACKGROUND");
				statFrame.Bg:SetPoint("LEFT", categoryFrame, "LEFT", 1, 0);
				statFrame.Bg:SetPoint("RIGHT", categoryFrame, "RIGHT", 0, 0);
				statFrame.Bg:SetPoint("TOP");
				statFrame.Bg:SetPoint("BOTTOM");
				statFrame.Bg:SetColorTexture(STRIPE_COLOR.r, STRIPE_COLOR.g, STRIPE_COLOR.b);
				statFrame.Bg:SetAlpha(0.1);
			end
		end
	end
	
	-- Hide all other stats
	local index = numVisible + 1;
	while (_G[categoryFrame:GetName().."Stat"..index]) do 
		_G[categoryFrame:GetName().."Stat"..index]:Hide();
		index = index + 1;
	end
	
	-- Hack to fix category frames that only have 1 item in them
	if (totalHeight < 44) then
		categoryFrame.BgBottom:SetHeight(totalHeight - 2);
	else
		categoryFrame.BgBottom:SetHeight(46);
	end
	
	categoryFrame:SetHeight(totalHeight);
end

function MCF_PaperDollFrame_UpdateStats()
	local index = 1;
	while(_G["CharacterStatsPaneCategory"..index]) do
		MCF_PaperDollFrame_UpdateStatCategory(_G["CharacterStatsPaneCategory"..index]);
		index = index + 1;
	end
	MCF_PaperDollFrame_UpdateStatScrollChildHeight();
end

function MCF_PaperDollFrame_UpdateStatScrollChildHeight()
	local index = 1;
	local totalHeight = 0;
	while(_G["CharacterStatsPaneCategory"..index]) do
		if (_G["CharacterStatsPaneCategory"..index]:IsShown()) then
			totalHeight = totalHeight + _G["CharacterStatsPaneCategory"..index]:GetHeight() + STATCATEGORY_PADDING;
		end
		index = index + 1;
	end
	CharacterStatsPaneScrollChild:SetHeight(totalHeight+10-(CharacterStatsPane.initialOffsetY or 0));
end



function MCF_PaperDollFrame_SetLabelAndText(statFrame, label, text, isPercentage)
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, label));
	if ( isPercentage ) then
		text = format("%.2F%%", text);
	end
	_G[statFrame:GetName().."StatText"]:SetText(text);
end

function MCF_PaperDollStatTooltip(self)
	if (MOVING_STAT_CATEGORY ~= nil) then return; end
	if ( not self.tooltip ) then
		return;
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(self.tooltip);
	if ( self.tooltip2 ) then
		GameTooltip:AddLine(self.tooltip2, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	end
	GameTooltip:Show();
end



function MCF_PaperDoll_SaveStatCategoryOrder()
	if (not CharacterStatsPane.orderCVarName) then
		return;
	end

	-- Check if the current order matches the default order
	if (CharacterStatsPane.defaultOrder and #CharacterStatsPane.defaultOrder == #StatCategoryFrames) then
		local same = true;
		for index=1, #StatCategoryFrames do
			if (StatCategoryFrames[index].Category ~= CharacterStatsPane.defaultOrder[index]) then
				same = false;
				break;
			end
		end
		if (same) then
			MCF_SetSettings(CharacterStatsPane.orderCVarName, "");
			return;
		end
	end
		
	local cvarString = "";
	for index=1, #StatCategoryFrames do
		if (index ~= #StatCategoryFrames) then
			cvarString = cvarString..MCF_PAPERDOLL_STATCATEGORIES[StatCategoryFrames[index].Category].id..",";
		else
			cvarString = cvarString..MCF_PAPERDOLL_STATCATEGORIES[StatCategoryFrames[index].Category].id;
		end
	end
	MCF_SetSettings(CharacterStatsPane.orderCVarName, cvarString);
end

function MCF_PaperDoll_UpdateCategoryPositions()
	local prevFrame = nil;
	for index = 1, #StatCategoryFrames do
		local frame = StatCategoryFrames[index];
		frame:ClearAllPoints();
	end
	
	for index = 1, #StatCategoryFrames do
		local frame = StatCategoryFrames[index];
		
		-- Indent the one we are currently dragging
		local xOffset = 0;
		if (frame == MOVING_STAT_CATEGORY) then
			xOffset = STATCATEGORY_MOVING_INDENT;
		elseif (prevFrame and prevFrame == MOVING_STAT_CATEGORY) then
			xOffset = -STATCATEGORY_MOVING_INDENT;
		end
		
		if (prevFrame) then
			frame:SetPoint("TOPLEFT", prevFrame, "BOTTOMLEFT", 0+xOffset, -STATCATEGORY_PADDING);
		else
			frame:SetPoint("TOPLEFT", 1+xOffset, -STATCATEGORY_PADDING+(CharacterStatsPane.initialOffsetY or 0));
		end
		prevFrame = frame;
	end
end

function MCF_PaperDoll_MoveCategoryUp(self)
	for index = 2, #StatCategoryFrames do
		if (StatCategoryFrames[index] == self) then
			tremove(StatCategoryFrames, index);
			tinsert(StatCategoryFrames, index-1, self);
			break;
		end
	end
	
	MCF_PaperDoll_UpdateCategoryPositions();
	MCF_PaperDoll_SaveStatCategoryOrder();
end

function MCF_PaperDoll_MoveCategoryDown(self)
	for index = 1, #StatCategoryFrames-1 do
		if (StatCategoryFrames[index] == self) then
			tremove(StatCategoryFrames, index);
			tinsert(StatCategoryFrames, index+1, self);
			break;
		end
	end
	MCF_PaperDoll_UpdateCategoryPositions();
	MCF_PaperDoll_SaveStatCategoryOrder();
end

function MCF_PaperDollStatCategory_OnDragUpdate(self)
	local _, cursorY = GetCursorPosition();
	cursorY = cursorY*GetScreenHeightScale();
	
	local myIndex = nil;
	local insertIndex = nil;
	local closestPos;
	
	-- Find position that will put the dragged frame closest to the cursor
	for index=1, #StatCategoryFrames+1 do -- +1 is to check the very last position at the bottom
		if (StatCategoryFrames[index] == self) then
			myIndex = index;
		end

		local frameY;
		if (index <= #StatCategoryFrames) then
			frameY = StatCategoryFrames[index]:GetTop();
		else
			frameY = StatCategoryFrames[#StatCategoryFrames]:GetBottom();
		end
		frameY = frameY - 8;  -- compensate for height of the toolbar area
		if (myIndex and index > myIndex) then
			-- Remove height of the dragged frame, since it's going to be moved out of it's current position
			frameY = frameY + self:GetHeight();
		end
		if (not closestPos or abs(cursorY - frameY)<closestPos) then
			insertIndex = index;
			closestPos = abs(cursorY-frameY);
		end
	end
	
	if (insertIndex > myIndex) then
		insertIndex = insertIndex - 1;
	end
	
	if ( myIndex ~= insertIndex) then
		tremove(StatCategoryFrames, myIndex);
		tinsert(StatCategoryFrames, insertIndex, self);
		MCF_PaperDoll_UpdateCategoryPositions();
	end
end

function MCF_PaperDollStatCategory_OnDragStart(self)
	MOVING_STAT_CATEGORY = self;
	MCF_PaperDoll_UpdateCategoryPositions();
	GameTooltip:Hide();
	self:SetScript("OnUpdate", MCF_PaperDollStatCategory_OnDragUpdate);
	local i;
	local frame;
	for i, frame in next, StatCategoryFrames do
		if (frame ~= self) then
			frame:SetAlpha(0.6);
		end
	end
end

function MCF_PaperDollStatCategory_OnDragStop(self)
	MOVING_STAT_CATEGORY = nil;
	MCF_PaperDoll_UpdateCategoryPositions();
	self:SetScript("OnUpdate", nil);
	local i;
	local frame;
	for i, frame in next, StatCategoryFrames do
		if (frame ~= self) then
			frame:SetAlpha(1);
		end
	end
	MCF_PaperDoll_SaveStatCategoryOrder();
end



function MCF_ColorPaperDollStat(base, posBuff, negBuff)
	local stat;
	local effective = max(0,base + posBuff + negBuff);
	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		stat = effective;
	else 
		
		-- if there is a negative buff then show the main number in red, even if there are
		-- positive buffs. Otherwise show the number in green
		if ( negBuff < 0 ) then
			stat = RED_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE;
		else
			stat = GREEN_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE;
		end
	end
	return stat;
end

function MCF_PaperDollFormatStat(name, base, posBuff, negBuff, frame, textString, result)
	local effective = max(0,base + posBuff + negBuff);
	local text = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT,name).." "..effective;
	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		text = text..FONT_COLOR_CODE_CLOSE;
		if (not result) then
			textString:SetText(effective);
		end
	else 
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text.." ("..base..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 ) then
			text = text..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( negBuff < 0 ) then
			text = text..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
		end

		-- if there is a negative buff then show the main number in red, even if there are
		-- positive buffs. Otherwise show the number in green
		if ( negBuff < 0 ) then
			if (not result) then
				textString:SetText(RED_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE);
			else
				effective = RED_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE;
			end
		else
			if (not result) then
				textString:SetText(GREEN_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE);
			else
				effective = GREEN_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE;
			end
		end
	end
	if (not result) then
		frame.tooltip = text;
	else
		return effective, text;
	end
end

function MCF_ComputePetBonus(stat, value)
	local temp, unitClass = UnitClass("player");
	unitClass = strupper(unitClass);
	if( unitClass == "WARLOCK" ) then
		if( WARLOCK_PET_BONUS[stat] ) then
			return value * WARLOCK_PET_BONUS[stat];
		else
			return 0;
		end
	elseif( unitClass == "HUNTER" ) then
		if( HUNTER_PET_BONUS[stat] ) then 
			return value * HUNTER_PET_BONUS[stat];
		else
			return 0;
		end
	end
	
	return 0;
end

function MCF_CalculateAverageItemLevel()
    local avgItemLevel, sumItemLevel, itemCount = 0, 0, 0;

    for i=1, 18 do
        if ( (i ~= 4) and GetInventoryItemID("player", i) ) then
            local id, _ = GetInventoryItemID("player", i);
            local ilvl = GetDetailedItemLevelInfo(id); -- Attempt to fix error when item isn't loaded at first open
            sumItemLevel = sumItemLevel + ilvl;
            itemCount = itemCount + 1;
        end
    end
    avgItemLevel = sumItemLevel/itemCount;
    return avgItemLevel;    
end

-- Check if player has specific talents. Returns dict
-- /run for i=1, GetNumTalents(1) do local name = GetTalentInfo(1, i); print(i, name); end
function MCF_CheckHitTalents(class, hit_type)
	if ( not MCF_TALENTS_FOR_HIT[class] ) then
		return;
	end

	local result = {};
	for tableIndex, talent in pairs(MCF_TALENTS_FOR_HIT[class]) do
		local requiredHitType = false;
		if (talent.hit_types == "all") then
			requiredHitType = true;
		else
			for _, v in pairs(talent.hit_types) do
				if (v == hit_type) then
					requiredHitType = true;
				end
			end
		end

		if (requiredHitType) then
			local _, _, _, _, rank = GetTalentInfo(talent.tab, talent.index);
			if (rank > 0) then
				local schools = {};
				if ( not talent.all_schools ) then
					for i=3, #talent.schools do
						if talent.schools[i] then
							table.insert(schools, i-1);
						end
					end
				else
					schools = nil;
				end

				local plusHit = rank * talent.increment;
				table.insert(result, {all_schools = talent.all_schools,
									  schools = schools,
									  plusHit = plusHit,
									  tab = talent.tab,
									  index = talent.index,
									  icon = talent.icon});
			end
		end
	end

	if (#result ~= 0) then
		return result
	end
end

----------------------------------------------------------------------------------
-------------------------------- STATS ON UPDATE ---------------------------------
----------------------------------------------------------------------------------
function MCF_MovementSpeed_OnUpdate(statFrame, elapsedTime)
	local unit = statFrame.unit;
	local _, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed(unit);
	runSpeed = runSpeed/BASE_MOVEMENT_SPEED*100;
	flightSpeed = flightSpeed/BASE_MOVEMENT_SPEED*100;
	swimSpeed = swimSpeed/BASE_MOVEMENT_SPEED*100;
	
	-- Pets seem to always actually use run speed
	if (unit == "pet") then
		swimSpeed = runSpeed;
	end

	-- Determine whether to display running, flying, or swimming speed
	local speed = runSpeed;
	local swimming = IsSwimming(unit);
	if (swimming) then
		speed = swimSpeed;
	elseif (IsFlying(unit)) then
		speed = flightSpeed;
	end
	
	-- Hack so that your speed doesn't appear to change when jumping out of the water
	if (IsFalling(unit)) then
		if (statFrame.wasSwimming) then
			speed = swimSpeed;
		end
	else
		statFrame.wasSwimming = swimming;
	end
	
	statFrame.Value:SetFormattedText("%d%%", speed+0.5);
	statFrame.speed = speed;
	statFrame.runSpeed = runSpeed;
	statFrame.flightSpeed = flightSpeed;
	statFrame.swimSpeed = swimSpeed;
end

----------------------------------------------------------------------------------
------------------------------- GET STAT FUNCTIONS -------------------------------
----------------------------------------------------------------------------------
function MCF_GetMeleeMissChance(levelOffset, talentHit, special)
	if (levelOffset < 0 or levelOffset > 3) then
		return 0;
	end
	local chance = MCF_BASE_MISS_CHANCE_PHYSICAL[levelOffset];
	chance = chance - GetCombatRatingBonus(CR_HIT_MELEE) - talentHit;--[[  - GetHitModifier(); ]] --MCFFIX this function gives another result
	if (IsDualWielding() and not special) then
		chance = chance + MCF_DUAL_WIELD_HIT_PENALTY;
	end
	if (chance < 0) then
		chance = 0;
	elseif (chance > 100) then
		chance = 100;
	end
	return chance;
end

function MCF_GetRangedMissChance(levelOffset, talentHit, special)
	if (levelOffset < 0 or levelOffset > 3) then
		return 0;
	end
	local chance = MCF_BASE_MISS_CHANCE_PHYSICAL[levelOffset];
	chance = chance - GetCombatRatingBonus(CR_HIT_RANGED) - talentHit;--[[  - GetHitModifier(); ]] --MCFFIX this function gives another result
	if (chance < 0) then
		chance = 0;
	elseif (chance > 100) then
		chance = 100;
	end
	return chance;
end

function MCF_GetSpellMissChance(levelOffset, talentHit, special)
	if (levelOffset < 0 or levelOffset > 3) then
		return 0;
	end
	local chance = MCF_BASE_MISS_CHANCE_SPELL[levelOffset];
	chance = chance - GetCombatRatingBonus(CR_HIT_SPELL) - talentHit;--[[  - GetSpellHitModifier(); ]] --MCFFIX this function gives another result
	if (chance < 0) then
		chance = 0;
	elseif (chance > 100) then
		chance = 100;
	end
	return chance;
end

function MCF_PaperDollFrame_GetArmorReduction(armor, attackerLevel)
	local levelModifier = attackerLevel;
	if ( levelModifier > 80 ) then
		levelModifier = levelModifier + (4.5 * (levelModifier-59)) + (20 * (levelModifier - 80));
	elseif ( levelModifier > 59 ) then
		levelModifier = levelModifier + (4.5 * (levelModifier-59));
	end
	local temp = 0.1*armor/(8.5*levelModifier + 40);
	temp = temp/(1+temp);

	if ( temp > 0.75 ) then
		return 75;
	end

	if ( temp < 0 ) then
		return 0;
	end

	return temp*100;
end

function MCF_GetCritHitTakenChance(levelOffset, special)
	if (levelOffset < 0 or levelOffset > 3) then
		return 0;
	end
	local chance = 5 + levelOffset * 0.04 * 5; -- Base crit hit taken chance (5, 5.2, 5.4, 5.6)
	local defSkill, currentModifier = UnitDefense("player");
	local currentDefTotal = defSkill + currentModifier;
	local defDifference = currentDefTotal - UnitLevel("player") * 5;
	local critChanceFromResilience = GetCombatRatingBonus(CR_RESILIENCE_CRIT_TAKEN);

	local _, class = UnitClass("player");
	local specialTalentPercent = 0;
	if (class == "DRUID") then
		local _,_,_,_, rank = GetTalentInfo(2, 18);
		specialTalentPercent = rank * 2;
	end
	if (class == "WARLOCK") then
		local _,_,_,_, rank = GetTalentInfo(2, 20);
		specialTalentPercent = rank;
	end

	chance = chance - defDifference * 0.04 - critChanceFromResilience - specialTalentPercent;
	if (chance < 0) then
		chance = 0;
	elseif (chance > 100) then
		chance = 100;
	end
	return chance;
end

function MCF_GetEnemyDodgeChance(levelOffset)
	if (levelOffset < 0 or levelOffset > 3) then
		return 0;
	end
	local chance = MCF_BASE_ENEMY_DODGE_CHANCE[levelOffset];
	local offhandChance = MCF_BASE_ENEMY_DODGE_CHANCE[levelOffset];
	local expertisePct, offhandExpertisePct = GetExpertisePercent();
	chance = chance - expertisePct;
	offhandChance = offhandChance - offhandExpertisePct;
	if (chance < 0) then
		chance = 0;
	elseif (chance > 100) then
		chance = 100;
	end
	if (offhandChance < 0) then
		offhandChance = 0;
	elseif (offhandChance > 100) then
		offhandChance = 100;
	end
	return chance, offhandChance;
end

function MCF_GetEnemyParryChance(levelOffset)
	if (levelOffset < 0 or levelOffset > 3) then
		return 0;
	end
	local chance = MCF_BASE_ENEMY_PARRY_CHANCE[levelOffset];
	local offhandChance = MCF_BASE_ENEMY_PARRY_CHANCE[levelOffset];
	local expertisePct, offhandExpertisePct = GetExpertisePercent();
	chance = chance - expertisePct;
	offhandChance = offhandChance - offhandExpertisePct;
	if (chance < 0) then
		chance = 0;
	elseif (chance > 100) then
		chance = 100;
	end
	if (offhandChance < 0) then
		offhandChance = 0;
	elseif (offhandChance > 100) then
		offhandChance = 100;
	end
	return chance, offhandChance;
end

local ITEM_SLOTS_WITH_DURABILITY = {
	[1] = _G.INVTYPE_HEAD,
	[3] = _G.INVTYPE_SHOULDER,
	[5] = _G.INVTYPE_CHEST,
	[6] = _G.INVTYPE_WAIST,
	[7] = _G.INVTYPE_LEGS,
	[8] = _G.INVTYPE_FEET,
	[9] = _G.INVTYPE_WRIST,
   [10] = _G.INVTYPE_HAND,
   [16] = _G.INVTYPE_WEAPONMAINHAND,
   [17] = _G.INVTYPE_WEAPONOFFHAND,
   [18] = _G.INVTYPE_RANGED,
};
function MCF_GetTotalRepairCost()
    local repair_cost_total = 0;

    for slot_id in pairs(ITEM_SLOTS_WITH_DURABILITY) do
	    MCF_ScanTooltip:ClearLines();
	    local repair_item_cost = select(3, MCF_ScanTooltip:SetInventoryItem("player", slot_id));

	    repair_cost_total = repair_cost_total + (repair_item_cost or 0);
    end

    return repair_cost_total;
end

----------------------------------------------------------------------------------
------------------------------- SET STAT FUNCTIONS -------------------------------
----------------------------------------------------------------------------------
-- GENERAL
function MCF_PaperDollFrame_SetHealth(statFrame, unit)
	if (not unit) then
		unit = "player";
	end
	local health = UnitHealthMax(unit);
	MCF_PaperDollFrame_SetLabelAndText(statFrame, HEALTH, health, false);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, HEALTH).." "..health..FONT_COLOR_CODE_CLOSE;
	if (unit == "player") then
		statFrame.tooltip2 = STAT_HEALTH_TOOLTIP;
	elseif (unit == "pet") then
		statFrame.tooltip2 = STAT_HEALTH_PET_TOOLTIP;
	end
	statFrame:Show();
end

function MCF_PaperDollFrame_SetPower(statFrame, unit)
	if (not unit) then
		unit = "player";
	end
	local powerType, powerToken = UnitPowerType(unit);
	local power = UnitPowerMax(unit) or 0;
	if (powerToken and _G[powerToken]) then
		MCF_PaperDollFrame_SetLabelAndText(statFrame, _G[powerToken], power, false);
		statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, _G[powerToken]).." "..power..FONT_COLOR_CODE_CLOSE;
		statFrame.tooltip2 = _G["STAT_"..powerToken.."_TOOLTIP"];
		statFrame:Show();
	else
		statFrame:Hide();
	end
end

function MCF_PaperDollFrame_SetDruidMana(statFrame, unit)
	if (not unit) then
		unit = "player";
	end
	local _, class = UnitClass(unit);
	if (class ~= "DRUID") then
		statFrame:Hide();
		return;
	end
	local powerType, powerToken = UnitPowerType(unit);
	if (powerToken == "MANA") then
		statFrame:Hide();
		return;
	end
	
	local power = UnitPowerMax(unit, 0);
	MCF_PaperDollFrame_SetLabelAndText(statFrame, MANA, power, false);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, MANA).." "..power..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = _G["STAT_MANA_TOOLTIP"];
	statFrame:Show();
end

function MCF_PaperDollFrame_SetItemLevel(statFrame, unit)
    if ( unit ~= "player" ) then
        statFrame:Hide();
        return;
    end
    _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_STAT_AVERAGE_ITEM_LEVEL"]));
    local text = _G[statFrame:GetName().."StatText"];
    --[[ local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel();
    avgItemLevel = floor(avgItemLevel);
    avgItemLevelEquipped = floor(avgItemLevelEquipped);
    text:SetText(avgItemLevelEquipped .. " / " .. avgItemLevel);
    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, L["MCF_STAT_AVERAGE_ITEM_LEVEL"]).." "..avgItemLevel;
    if (avgItemLevelEquipped ~= avgItemLevel) then
        statFrame.tooltip = statFrame.tooltip .. "  " .. format(L["MCF_STAT_AVERAGE_ITEM_LEVEL_EQUIPPED"], avgItemLevelEquipped);
    end ]]

    local avgItemLevelEquipped = MCF_CalculateAverageItemLevel();
    avgItemLevelEquipped = floor(avgItemLevelEquipped);

    if ( IsAddOnLoaded("TacoTip") and MCF_GetSettings("TT_IntegrationEnabled") ) then
        local personalGS, _ = TT_GS:GetScore("player");
        local textType = MCF_GetSettings("TT_IntegrationType");
        local colorGS = "";
        if ( MCF_GetSettings("TT_IntegrationColorEnabled") ) then
            local r, g, b, _ = TT_GS:GetQuality(personalGS);
			if ( personalGS == 0 ) then
				r, g, b = 0.55, 0.55, 0.55;
			end
            local tempColor = CreateColor(r, g, b);
            colorGS = tempColor:GenerateHexColorMarkup();
        end

        if ( textType == 2 ) then
            text:SetText(avgItemLevelEquipped .. " (" .. (colorGS..(personalGS or NOT_APPLICABLE)..FONT_COLOR_CODE_CLOSE) .. ")");
        elseif ( textType == 3 ) then
            _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_STAT_GEARSCORE_LABEL"]));
            text:SetText(colorGS..(personalGS or NOT_APPLICABLE)..FONT_COLOR_CODE_CLOSE);
        else
            text:SetText(avgItemLevelEquipped .. " / " .. (colorGS..(personalGS or NOT_APPLICABLE)..FONT_COLOR_CODE_CLOSE));
        end
        statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, L["MCF_STAT_AVERAGE_ITEM_LEVEL"]).." "..avgItemLevelEquipped;
        statFrame.tooltip = statFrame.tooltip .. "  " .. format(L["MCF_STAT_GEARSCORE"], (personalGS or NOT_APPLICABLE));
    else
        text:SetText(avgItemLevelEquipped);
        statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, L["MCF_STAT_AVERAGE_ITEM_LEVEL"]).." "..avgItemLevelEquipped;
    end
    
    statFrame.tooltip = statFrame.tooltip .. FONT_COLOR_CODE_CLOSE;
    statFrame.tooltip2 = STAT_AVERAGE_ITEM_LEVEL_TOOLTIP;
end

function MCF_PaperDollFrame_SetMovementSpeed(statFrame, unit)
	statFrame.Label:SetText(format(STAT_FORMAT, L["MCF_STAT_MOVEMENT_SPEED"]));
	
	statFrame.wasSwimming = nil;
	statFrame.unit = unit;
	MCF_MovementSpeed_OnUpdate(statFrame);
	
	statFrame:SetScript("OnEnter", MCF_MovementSpeed_OnEnter);
	statFrame:SetScript("OnUpdate", MCF_MovementSpeed_OnUpdate);
end

function MCF_PaperDollFrame_SetRepairCost(statFrame, unit)
	if MCF_GetSettings("showRepairCost") == false then
		statFrame:Hide();
		return;
	end
	
	if (not unit) then
		unit = "player";
	end

	local repairCost = MCF_GetTotalRepairCost();
	local repairCostShort = repairCost;
	if repairCost == 0 then
		statFrame:Hide();
		return;
	elseif repairCost > 999999 then
		repairCostShort = floor((repairCost + 500000) / 1000000) * 1000000;
	elseif repairCost > 9999 then
		repairCostShort = floor((repairCost + 5000) / 10000) * 10000;
	elseif repairCost > 99 then
		repairCostShort = floor((repairCost + 50) / 100) * 100;
	end
	
	local repairCostString = GetMoneyString(repairCostShort);

	local REPAIR_COST_STR = gsub(REPAIR_COST, ":", "");
	MCF_PaperDollFrame_SetLabelAndText(statFrame, REPAIR_COST_STR, repairCostString, false);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, REPAIR_COST_STR).." "..GetMoneyString(repairCost)..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = L["MCF_STAT_REPAIR"];
	statFrame:Show();
end

-- ATTRIBUTES
-- NEEDS INTELLECT REWORK
function MCF_PaperDollFrame_SetStat(statFrame, unit, statIndex)
	local label = _G[statFrame:GetName().."Label"];
	local text = _G[statFrame:GetName().."StatText"];
	local stat;
	local effectiveStat;
	local posBuff;
	local negBuff;
	stat, effectiveStat, posBuff, negBuff = UnitStat(unit, statIndex);
	local statName = _G["SPELL_STAT"..statIndex.."_NAME"];
	label:SetText(format(STAT_FORMAT, statName));
	
	-- Set the tooltip text
	local tooltipText = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, statName).." ";

	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		text:SetText(effectiveStat);
		statFrame.tooltip = tooltipText..effectiveStat..FONT_COLOR_CODE_CLOSE;
	else 
		tooltipText = tooltipText..effectiveStat;
		if ( posBuff > 0 or negBuff < 0 ) then
			tooltipText = tooltipText.." ("..(stat - posBuff - negBuff)..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 ) then
			tooltipText = tooltipText..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( negBuff < 0 ) then
			tooltipText = tooltipText..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 or negBuff < 0 ) then
			tooltipText = tooltipText..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
		end
		statFrame.tooltip = tooltipText;

		-- If there are any negative buffs then show the main number in red even if there are
		-- positive buffs. Otherwise show in green.
		if ( negBuff < 0 ) then
			text:SetText(RED_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE);
		else
			text:SetText(GREEN_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE);
		end
	end
	statFrame.tooltip2 = L["MCF_DEFAULT_STAT"..statIndex.."_TOOLTIP"];
	
	if (unit == "player") then
		local _, unitClass = UnitClass("player");
		unitClass = strupper(unitClass);
		
		-- Strength
		if ( statIndex == 1 ) then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat);
			statFrame.tooltip2 = format(statFrame.tooltip2, attackPower);
		-- Agility
		elseif ( statIndex == 2 ) then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat);
			if ( attackPower > 0 ) then
				statFrame.tooltip2 = format(L["MCF_STAT_TOOLTIP_BONUS_AP"], attackPower) .. format(statFrame.tooltip2, GetCritChanceFromAgility("player"), effectiveStat*ARMOR_PER_AGILITY);
			else
				statFrame.tooltip2 = format(statFrame.tooltip2, GetCritChanceFromAgility("player"), effectiveStat*ARMOR_PER_AGILITY);
			end
		-- Stamina
		elseif ( statIndex == 3 ) then
			local baseStam = min(20, effectiveStat);
			local moreStam = effectiveStat - baseStam;
			statFrame.tooltip2 = format(statFrame.tooltip2, (baseStam + (moreStam*HEALTH_PER_STAMINA))*GetUnitMaxHealthModifier("player"));
		-- Intellect
		elseif ( statIndex == 4 ) then
			if ( UnitHasMana("player") ) then
				local baseInt = min(20, effectiveStat);
				local moreInt = effectiveStat - baseInt;
				local spellPowerFromIntellect = max(0, effectiveStat-10);
				
				if ( UnitHasMana("player") ) then
					statFrame.tooltip2 = format(statFrame.tooltip2, baseInt + moreInt*MANA_PER_INTELLECT, spellPowerFromIntellect, GetSpellCritChanceFromIntellect("player"));
				else
					statFrame.tooltip2 = nil;
				end
				--[[ if (GetOverrideSpellPowerByAP() ~= nil) then
					statFrame.tooltip2 = format(STAT4_NOSPELLPOWER_TOOLTIP, baseInt + moreInt*MANA_PER_INTELLECT, GetSpellCritChanceFromIntellect("player"));
				else
					statFrame.tooltip2 = format(statFrame.tooltip2, baseInt + moreInt*MANA_PER_INTELLECT, max(0, effectiveStat-10), GetSpellCritChanceFromIntellect("player"));
				end ]] --MCFFIX wrote another condition
			else
				statFrame.tooltip2 = STAT_USELESS_TOOLTIP;
			end
		-- Spirit
		elseif ( statIndex == 5 ) then
			-- All mana regen stats are displayed as mana/5 sec.
			if ( UnitHasMana("player") ) then
				local regen = GetUnitManaRegenRateFromSpirit("player");
				regen = floor( regen * 5.0 );
				statFrame.tooltip2 = format(L["MCF_MANA_REGEN_FROM_SPIRIT"], regen);
			else
				statFrame.tooltip2 = STAT_USELESS_TOOLTIP;
			end
		end
	elseif (unit == "pet") then
		if ( statIndex == 1 ) then
			local attackPower = effectiveStat-20;
			statFrame.tooltip2 = format(statFrame.tooltip2, attackPower);
		elseif ( statIndex == 2 ) then
			statFrame.tooltip2 = format(statFrame.tooltip2, GetCritChanceFromAgility("pet"));
		elseif ( statIndex == 3 ) then
			local expectedHealthGain = (((stat - posBuff - negBuff)-20)*10+20)*GetUnitHealthModifier("pet");
			local realHealthGain = ((effectiveStat-20)*10+20)*GetUnitHealthModifier("pet");
			local healthGain = (realHealthGain - expectedHealthGain)*GetUnitMaxHealthModifier("pet");
			statFrame.tooltip2 = format(statFrame.tooltip2, healthGain);
		elseif ( statIndex == 4 ) then
			if ( UnitHasMana("pet") ) then
				local manaGain = ((effectiveStat-20)*15+20)*GetUnitPowerModifier("pet");
				statFrame.tooltip2 = format(statFrame.tooltip2, manaGain, max(0, effectiveStat-10), GetSpellCritChanceFromIntellect("pet"));
			else
				statFrame.tooltip2 = nil;
			end
		elseif ( statIndex == 5 ) then
			statFrame.tooltip2 = "";
			if ( UnitHasMana("pet") ) then
				statFrame.tooltip2 = format(L["MCF_MANA_REGEN_FROM_SPIRIT"], GetUnitManaRegenRateFromSpirit("pet"));
			end
		end
	end
	statFrame:Show();
end

-- MELEE
function MCF_PaperDollFrame_SetDamage(statFrame, unit)
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, DAMAGE));
	local text = _G[statFrame:GetName().."StatText"];
	local speed, offhandSpeed = UnitAttackSpeed(unit);
	
	local minDamage;
	local maxDamage; 
	local minOffHandDamage;
	local maxOffHandDamage; 
	local physicalBonusPos;
	local physicalBonusNeg;
	local percent;
	minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage(unit);
	local displayMin = max(floor(minDamage),1);
	local displayMax = max(ceil(maxDamage),1);

	minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
	maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

	local baseDamage = (minDamage + maxDamage) * 0.5;
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
	local totalBonus = (fullDamage - baseDamage);
	local damagePerSecond = (max(fullDamage,1) / speed);
	local damageTooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	
	local colorPos = "|cff20ff20";
	local colorNeg = "|cffff2020";

	-- epsilon check
	if ( totalBonus < 0.1 and totalBonus > -0.1 ) then
		totalBonus = 0.0;
	end

	if ( totalBonus == 0 ) then
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			text:SetText(displayMin.." - "..displayMax);	
		else
			text:SetText(displayMin.."-"..displayMax);
		end
	else
		
		local color;
		if ( totalBonus > 0 ) then
			color = colorPos;
		else
			color = colorNeg;
		end
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			text:SetText(color..displayMin.." - "..displayMax.."|r");	
		else
			text:SetText(color..displayMin.."-"..displayMax.."|r");
		end
		if ( physicalBonusPos > 0 ) then
			damageTooltip = damageTooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			damageTooltip = damageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			damageTooltip = damageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			damageTooltip = damageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		
	end
	statFrame.damage = damageTooltip;
	statFrame.attackSpeed = speed;
	statFrame.dps = damagePerSecond;
	statFrame.unit = unit;
	
	-- If there's an offhand speed then add the offhand info to the tooltip
	if ( offhandSpeed ) then
		minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
		maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;

		local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
		local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
		local offhandDamageTooltip = max(floor(minOffHandDamage),1).." - "..max(ceil(maxOffHandDamage),1);
		if ( physicalBonusPos > 0 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		statFrame.offhandDamage = offhandDamageTooltip;
		statFrame.offhandAttackSpeed = offhandSpeed;
		statFrame.offhandDps = offhandDamagePerSecond;
	else
		statFrame.offhandAttackSpeed = nil;
	end
	
	statFrame:SetScript("OnEnter", MCF_CharacterDamageFrame_OnEnter);
	
	statFrame:Show();
end

function MCF_PaperDollFrame_SetMeleeDPS(statFrame, unit)
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_STAT_DPS_SHORT"]));
	local text = _G[statFrame:GetName().."StatText"];
	local speed, offhandSpeed = UnitAttackSpeed(unit);
	
	local minDamage;
	local maxDamage; 
	local minOffHandDamage;
	local maxOffHandDamage; 
	local physicalBonusPos;
	local physicalBonusNeg;
	local percent;
	minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage(unit);
	local displayMin = max(floor(minDamage),1);
	local displayMax = max(ceil(maxDamage),1);

	minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
	maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

	local baseDamage = (minDamage + maxDamage) * 0.5;
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
	local totalBonus = (fullDamage - baseDamage);
	local damagePerSecond = (max(fullDamage,1) / speed);
	local damageTooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	
	local colorPos = "|cff20ff20";
	local colorNeg = "|cffff2020";
	local text;

	-- epsilon check
	if ( totalBonus < 0.1 and totalBonus > -0.1 ) then
		totalBonus = 0.0;
	end

	if ( totalBonus == 0 ) then
		text = format("%.1F", damagePerSecond);
	else
		local color;
		if ( totalBonus > 0 ) then
			color = colorPos;
		else
			color = colorNeg;
		end
		text = color..format("%.1F", damagePerSecond).."|r";
	end
	
	-- If there's an offhand speed then add the offhand info
	if ( offhandSpeed ) then
		minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
		maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;

		local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
		local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
		local offhandTotalBonus = (offhandFullDamage - offhandBaseDamage);
		
		-- epsilon check
		if ( offhandTotalBonus < 0.1 and offhandTotalBonus > -0.1 ) then
			offhandTotalBonus = 0.0;
		end
		local separator = " / ";
		if (damagePerSecond > 1000 and offhandDamagePerSecond > 1000) then
			separator = "/";
		end
		if ( offhandTotalBonus == 0 ) then
			text = text..separator..format("%.1F", offhandDamagePerSecond);
		else
			local color;
			if ( offhandTotalBonus > 0 ) then
				color = colorPos;
			else
				color = colorNeg;
			end
			text = text..separator..color..format("%.1F", offhandDamagePerSecond).."|r";	
		end
	end
	
	statFrame.Value:SetText(text);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..DAMAGE_PER_SECOND..FONT_COLOR_CODE_CLOSE;
	statFrame:Show();
end
-- needs improvement because function GetOverrideSpellPowerByAP() doesn't work anymore
function MCF_PaperDollFrame_SetAttackPower(statFrame, unit)
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_STAT_ATTACK_POWER"]));
	local text = _G[statFrame:GetName().."StatText"];
	local base, posBuff, negBuff = UnitAttackPower(unit);

	MCF_PaperDollFormatStat(MELEE_ATTACK_POWER, base, posBuff, negBuff, statFrame, text);
	local damageBonus = max((base+posBuff+negBuff), 0)/ATTACK_POWER_MAGIC_NUMBER;
	local effectiveAP = max(0,base + posBuff + negBuff);
	--[[ if (GetOverrideSpellPowerByAP() ~= nil) then
		statFrame.tooltip2 = format(MELEE_ATTACK_POWER_SPELL_POWER_TOOLTIP, damageBonus, effectiveAP * GetOverrideSpellPowerByAP() + 0.5);
	else
		statFrame.tooltip2 = format(MELEE_ATTACK_POWER_TOOLTIP, damageBonus);
	end ]] --MCFFIX disabled if condition, copied tooltip generation (next line)
	statFrame.tooltip2 = format(MELEE_ATTACK_POWER_TOOLTIP, damageBonus);
	statFrame:Show();
end

function MCF_PaperDollFrame_SetAttackSpeed(statFrame, unit)
	local speed, offhandSpeed = UnitAttackSpeed(unit);
	speed = format("%.2F", speed);
	if ( offhandSpeed ) then
		offhandSpeed = format("%.2F", offhandSpeed);
	end
	local text;	
	if ( offhandSpeed ) then
		text = speed.." / "..offhandSpeed;
	else
		text = speed;
	end
	MCF_PaperDollFrame_SetLabelAndText(statFrame, L["MCF_WEAPON_SPEED"], text);

	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..text..FONT_COLOR_CODE_CLOSE;
	
	statFrame:Show();
end

function MCF_PaperDollFrame_SetMeleeHaste(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local haste = GetMeleeHaste();
	if (haste < 0) then
		haste = RED_FONT_COLOR_CODE..format("%.2F%%", haste)..FONT_COLOR_CODE_CLOSE;
	else
		haste = "+"..format("%.2F%%", haste);
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_STAT_HASTE"]));	
	local text = _G[statFrame:GetName().."StatText"];
	text:SetText(haste);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, L["MCF_STAT_HASTE"]) .. " " .. haste .. FONT_COLOR_CODE_CLOSE;
	
	local _, class = UnitClass(unit);	
	statFrame.tooltip2 = _G["STAT_HASTE_MELEE_"..class.."_TOOLTIP"];
	if (not statFrame.tooltip2) then
		statFrame.tooltip2 = STAT_HASTE_MELEE_TOOLTIP;
	end
	statFrame.tooltip2 = statFrame.tooltip2 .. format(L["MCF_STAT_HASTE_BASE_TOOLTIP"], GetCombatRating(CR_HASTE_MELEE), GetCombatRatingBonus(CR_HASTE_MELEE));
	
	statFrame:Show();
end

function MCF_PaperDollFrame_SetMeleeHitChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	local _, class = UnitClass("player");
	local _, race = UnitRace("player");

	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local hitChance = GetCombatRatingBonus(CR_HIT_MELEE);--[[  + GetHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.

	-- Check for Draenei racial ability
	if (race == "Draenei") then
		hitChance = hitChance + 1;
	end
	
	-- Check DK's "Nerves of Cold Steel talent and equipped weapon type
	if (class == "DEATHKNIGHT") then
		local _, _, _, _, rank = GetTalentInfo(2, 16);
		if (rank > 0) then
			local id = GetInventoryItemID("player", 16);
			if (not id) then
				id = GetInventoryItemID("player", 17);
			end
			if id then
				local _,_,_,_,_,_,_,_, weapon_type = GetItemInfo(id);
				if (weapon_type == "INVTYPE_WEAPON") then
					hitChance = hitChance + rank;
				end
			end
		end
	end

	-- Check Shaman's Dual Wield Specialization talent and dual wielding
	if (class == "SHAMAN") then
		local _, _, _, _, rank = GetTalentInfo(2, 19);
		if ((rank > 0) and IsDualWielding()) then
			hitChance = hitChance + rank * 2;
		end
	end

	local hitFromTalents = MCF_CheckHitTalents(class, "melee");
	if (hitFromTalents and #hitFromTalents > 0) then
		for i=1, #hitFromTalents do
			hitChance = hitChance + hitFromTalents[i].plusHit;
		end
	end

	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	text:SetText(hitChance);
	statFrame:SetScript("OnEnter", MCF_MeleeHitChance_OnEnter);
	statFrame:Show();
end

function MCF_PaperDollFrame_SetMeleeCritChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, MELEE_CRIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local critChance = GetCritChance();
	critChance = format("%.2F%%", critChance);
	text:SetText(critChance);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, MELEE_CRIT_CHANCE).." "..critChance..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(L["MCF_CR_CRIT_MELEE_TOOLTIP"], GetCombatRating(CR_CRIT_MELEE), GetCombatRatingBonus(CR_CRIT_MELEE));
end

function MCF_PaperDollFrame_SetArmorPenetration(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_STAT_ARMOR_PENETRATION"]));
	local text = _G[statFrame:GetName().."StatText"];
	local armorPenetration = GetArmorPenetration();
	armorPenetration = format("%.2F%%", armorPenetration);
	text:SetText(armorPenetration);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, L["MCF_STAT_ARMOR_PENETRATION"]).." "..armorPenetration..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(L["MCF_CR_ARMOR_PENETRATION_TOOLTIP"], GetCombatRating(CR_ARMOR_PENETRATION), GetCombatRatingBonus(CR_ARMOR_PENETRATION));
end

function MCF_PaperDollFrame_SetExpertise(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local expertise, offhandExpertise = GetExpertise();
	local speed, offhandSpeed = UnitAttackSpeed(unit);
	local text;
	if( offhandSpeed ) then
		text = expertise.." / "..offhandExpertise;
	else
		text = expertise;
	end
	MCF_PaperDollFrame_SetLabelAndText(statFrame, STAT_EXPERTISE, text);
	statFrame:SetScript("OnEnter", MCF_Expertise_OnEnter);
	statFrame:Show();
end

-- RANGED
function MCF_PaperDollFrame_SetRangedDamage(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, DAMAGE));
	local text = _G[statFrame:GetName().."StatText"];

	-- If no ranged attack then set to n/a
	local hasRelic = UnitHasRelicSlot(unit);	
	local rangedTexture = GetInventoryItemTexture("player", 18);
	if ( rangedTexture and not hasRelic ) then
		PaperDollFrame.noRanged = nil;
	else
		text:SetText(NOT_APPLICABLE);
		PaperDollFrame.noRanged = 1;
		statFrame.damage = nil;
		return;
	end

	local rangedAttackSpeed, minDamage, maxDamage, physicalBonusPos, physicalBonusNeg, percent = UnitRangedDamage(unit);
	
	-- Round to the third decimal place (i.e. 99.9 percent)
	percent = math.floor(percent  * 10^3 + 0.5) / 10^3
	local displayMin = max(floor(minDamage),1);
	local displayMax = max(ceil(maxDamage),1);

	local baseDamage;
	local fullDamage;
	local totalBonus;
	local damagePerSecond;
	local tooltip;

	if ( HasWandEquipped() ) then
		baseDamage = (minDamage + maxDamage) * 0.5;
		fullDamage = baseDamage * percent;
		totalBonus = 0;
		if( rangedAttackSpeed == 0 ) then
			damagePerSecond = 0;
		else
			damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
		end
		tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	else
		minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
		maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

		baseDamage = (minDamage + maxDamage) * 0.5;
		fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		totalBonus = (fullDamage - baseDamage);
		if( rangedAttackSpeed == 0 ) then
			damagePerSecond = 0;
		else
			damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
		end
		tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	end

	if ( totalBonus == 0 ) then
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			text:SetText(displayMin.." - "..displayMax);	
		else
			text:SetText(displayMin.."-"..displayMax);
		end
	else
		local colorPos = "|cff20ff20";
		local colorNeg = "|cffff2020";
		local color;
		if ( totalBonus > 0 ) then
			color = colorPos;
		else
			color = colorNeg;
		end
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			text:SetText(color..displayMin.." - "..displayMax.."|r");	
		else
			text:SetText(color..displayMin.."-"..displayMax.."|r");
		end
		if ( physicalBonusPos > 0 ) then
			tooltip = tooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			tooltip = tooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			tooltip = tooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			tooltip = tooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		statFrame.tooltip = tooltip.." "..format(DPS_TEMPLATE, damagePerSecond);
	end
	statFrame.attackSpeed = rangedAttackSpeed;
	statFrame.damage = tooltip;
	statFrame.dps = damagePerSecond;
	statFrame:SetScript("OnEnter", MCF_CharacterRangedDamageFrame_OnEnter);
	statFrame:Show();
end

function MCF_PaperDollFrame_SetRangedDPS(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_STAT_DPS_SHORT"]));
	local text = _G[statFrame:GetName().."StatText"];

	-- If no ranged attack then set to n/a
	local hasRelic = UnitHasRelicSlot(unit);	
	local rangedTexture = GetInventoryItemTexture("player", 18);
	if ( rangedTexture and not hasRelic ) then
		PaperDollFrame.noRanged = nil;
	else
		text:SetText(NOT_APPLICABLE);
		PaperDollFrame.noRanged = 1;
		statFrame.damage = nil;
		return;
	end

	local rangedAttackSpeed, minDamage, maxDamage, physicalBonusPos, physicalBonusNeg, percent = UnitRangedDamage(unit);
	
	-- Round to the third decimal place (i.e. 99.9 percent)
	percent = math.floor(percent  * 10^3 + 0.5) / 10^3
	local displayMin = max(floor(minDamage),1);
	local displayMax = max(ceil(maxDamage),1);

	local baseDamage;
	local fullDamage;
	local totalBonus;
	local damagePerSecond;
	local tooltip;

	if ( HasWandEquipped() ) then
		baseDamage = (minDamage + maxDamage) * 0.5;
		fullDamage = baseDamage * percent;
		totalBonus = 0;
		if( rangedAttackSpeed == 0 ) then
			damagePerSecond = 0;
		else
			damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
		end
		tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	else
		minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
		maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

		baseDamage = (minDamage + maxDamage) * 0.5;
		fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		totalBonus = (fullDamage - baseDamage);
		if( rangedAttackSpeed == 0 ) then
			damagePerSecond = 0;
		else
			damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
		end
		tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	end

	if ( totalBonus == 0 ) then
		text:SetText( format("%.1F", damagePerSecond));
	else
		local colorPos = "|cff20ff20";
		local colorNeg = "|cffff2020";
		local color;
		if ( totalBonus > 0 ) then
			color = colorPos;
		else
			color = colorNeg;
		end
		text:SetText(color..format("%.1F", damagePerSecond).."|r");
		if ( physicalBonusPos > 0 ) then
			tooltip = tooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			tooltip = tooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			tooltip = tooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			tooltip = tooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		--statFrame.tooltip2 = tooltip.." "..format(DPS_TEMPLATE, damagePerSecond);
	end

	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..DAMAGE_PER_SECOND..FONT_COLOR_CODE_CLOSE;
	statFrame:Show();
end

function MCF_PaperDollFrame_SetRangedAttackPower(statFrame, unit)
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_STAT_ATTACK_POWER"]));
	local text = _G[statFrame:GetName().."StatText"];
	local base, posBuff, negBuff = UnitRangedAttackPower(unit);

	MCF_PaperDollFormatStat(RANGED_ATTACK_POWER, base, posBuff, negBuff, statFrame, text);
	local totalAP = base+posBuff+negBuff;
	statFrame.tooltip2 = format(RANGED_ATTACK_POWER_TOOLTIP, max((totalAP), 0)/ATTACK_POWER_MAGIC_NUMBER);
	local petAPBonus = MCF_ComputePetBonus( "PET_BONUS_RAP_TO_AP", totalAP );
	if( petAPBonus > 0 ) then
		statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_RANGED_ATTACK_POWER, petAPBonus);
	end
	
	local petSpellDmgBonus = MCF_ComputePetBonus( "PET_BONUS_RAP_TO_SPELLDMG", totalAP );
	if( petSpellDmgBonus > 0 ) then
		statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_SPELLDAMAGE, petSpellDmgBonus);
	end
	
	statFrame:Show();
end

function MCF_PaperDollFrame_SetRangedAttackSpeed(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	local text;
	-- If no ranged attack then set to n/a
	if ( PaperDollFrame.noRanged ) then
		text = NOT_APPLICABLE;
		statFrame.tooltip = nil;
	else
		text = UnitRangedDamage(unit);
		text = format("%.2F", text);
		statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..text..FONT_COLOR_CODE_CLOSE;
	end
	MCF_PaperDollFrame_SetLabelAndText(statFrame, L["MCF_WEAPON_SPEED"], text);
	statFrame:Show();
end

function MCF_PaperDollFrame_SetRangedHaste(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local haste = GetRangedHaste();
	if (haste < 0) then
		haste = RED_FONT_COLOR_CODE..format("%.2F%%", haste)..FONT_COLOR_CODE_CLOSE;
	else
		haste = "+"..format("%.2F%%", haste);
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_STAT_HASTE"]));
	local text = _G[statFrame:GetName().."StatText"];
	text:SetText(haste);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, L["MCF_STAT_HASTE"]) .. " " .. haste .. FONT_COLOR_CODE_CLOSE;

	local _, class = UnitClass(unit);	
	statFrame.tooltip2 = _G["STAT_HASTE_RANGED_"..class.."_TOOLTIP"];
	if (not statFrame.tooltip2) then
		statFrame.tooltip2 = STAT_HASTE_RANGED_TOOLTIP;
	end
	statFrame.tooltip2 = statFrame.tooltip2 .. format(L["MCF_STAT_HASTE_BASE_TOOLTIP"], GetCombatRating(CR_HASTE_RANGED), GetCombatRatingBonus(CR_HASTE_RANGED));

	statFrame:Show();
end

function MCF_PaperDollFrame_SetRangedHitChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	local _, class = UnitClass("player");
	local _, race = UnitRace("player");

	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local hitChance = GetCombatRatingBonus(CR_HIT_RANGED);--[[  + GetHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.

	if (race == "Draenei") then
		hitChance = hitChance + 1;
	end

	local hitFromTalents = MCF_CheckHitTalents(class, "ranged");
	if (hitFromTalents and #hitFromTalents > 0) then
		for i=1, #hitFromTalents do
			hitChance = hitChance + hitFromTalents[i].plusHit;
		end
	end

	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	text:SetText(hitChance);
	statFrame:SetScript("OnEnter", MCF_RangedHitChance_OnEnter);
	statFrame:Show();
end

function MCF_PaperDollFrame_SetRangedCritChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, RANGED_CRIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local critChance = GetRangedCritChance();
	critChance = format("%.2F%%", critChance);
	text:SetText(critChance);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, RANGED_CRIT_CHANCE).." "..critChance..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(L["MCF_CR_CRIT_RANGED_TOOLTIP"], GetCombatRating(CR_CRIT_RANGED), GetCombatRatingBonus(CR_CRIT_RANGED));
end

-- SPELLS
function MCF_PaperDollFrame_SetSpellBonusDamage(statFrame, unit)
	local text = _G[statFrame:GetName().."StatText"];
	local minModifier = 0;
	
	if (unit == "player") then
		local holySchool = 2;
		-- Start at 2 to skip physical damage
		minModifier = GetSpellBonusDamage(holySchool);
		
		if (statFrame.bonusDamage) then
			table.wipe(statFrame.bonusDamage);
		else
			statFrame.bonusDamage = {};
		end
		statFrame.bonusDamage[holySchool] = minModifier;
		for i=(holySchool+1), MAX_SPELL_SCHOOLS do
			local bonusDamage = GetSpellBonusDamage(i);
			minModifier = min(minModifier, bonusDamage);
			statFrame.bonusDamage[i] = bonusDamage;
		end
	elseif (unit == "pet") then
		minModifier = GetPetSpellBonusDamage();
		statFrame.bonusDamage = nil;
	end
	
	local healerClasses = {
		["DRUID"] = true,
		["PALADIN"] = true,
		["PRIEST"] = true,
		["SHAMAN"] = true,
	};
    local _, class = UnitClass(unit);
	local spellHealing = GetSpellBonusHealing();
	if ( (spellHealing == minModifier) or (not healerClasses[class]) ) then
		_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_SPELLPOWER));
		statFrame.tooltip = STAT_SPELLPOWER;
		statFrame.tooltip2 = STAT_SPELLPOWER_TOOLTIP;
	else
		_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_SPELLDAMAGE));
		statFrame.tooltip = STAT_SPELLDAMAGE;
		statFrame.tooltip2 = STAT_SPELLDAMAGE_TOOLTIP;
	end
	
	text:SetText(minModifier);
	statFrame.minModifier = minModifier;
	statFrame.unit = unit;
	statFrame:SetScript("OnEnter", MCF_CharacterSpellBonusDamage_OnEnter);
	statFrame:Show();
end

function MCF_PaperDollFrame_SetSpellBonusHealing(statFrame, unit)
	local text = _G[statFrame:GetName().."StatText"];
	local minDamage = 0;
	
	if (unit == "player") then
		local holySchool = 2;
		-- Start at 2 to skip physical damage
		minDamage = GetSpellBonusDamage(holySchool);		
		for i=(holySchool+1), MAX_SPELL_SCHOOLS do
			minDamage = min(minDamage, GetSpellBonusDamage(i));
		end
	elseif (unit == "pet") then
		--Healing is not needed for pets (see bug  238141)
		--minDamage = GetPetSpellBonusDamage();
		statFrame:Hide();
		return;
	end
	statFrame.bonusDamage = nil;
	
	local healerClasses = {
		["DRUID"] = true,
		["PALADIN"] = true,
		["PRIEST"] = true,
		["SHAMAN"] = true,
	};
    local _, class = UnitClass(unit);
	local spellHealing = GetSpellBonusHealing();
	if ( (spellHealing == minDamage) or (not healerClasses[class]) ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_SPELLHEALING));
	statFrame.tooltip = STAT_SPELLHEALING;
	statFrame.tooltip2 = STAT_SPELLHEALING_TOOLTIP;
	text:SetText(spellHealing);
	statFrame.minModifier = spellHealing;
	statFrame.unit = unit;
	statFrame:SetScript("OnEnter", MCF_CharacterSpellBonusDamage_OnEnter);
	statFrame:Show();
end

function MCF_PaperDollFrame_SetSpellHitChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	local _, class = UnitClass("player");
	local _, race = UnitRace("player");
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local hitChance = GetCombatRatingBonus(CR_HIT_SPELL);--[[  + GetSpellHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.

	if (race == "Draenei") then
		hitChance = hitChance + 1;
	end

	local hitFromTalents = MCF_CheckHitTalents(class, "spells");
	if (hitFromTalents and #hitFromTalents > 0) then
		for i=1, #hitFromTalents do
			if hitFromTalents[i].all_schools then
				hitChance = hitChance + hitFromTalents[i].plusHit;
			end
		end
	end

	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	text:SetText(hitChance);
	statFrame:SetScript("OnEnter", MCF_SpellHitChance_OnEnter);
	-- HACK to reset Spell Hit tooltip lines font OnLeave
	statFrame:HookScript("OnLeave", function(self) MCF_ResetTooltipTextFonts(self, 4); end);
	statFrame:Show();
end

function MCF_PaperDollFrame_SetSpellHaste(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local haste = GetCombatRatingBonus(CR_HASTE_SPELL); --UnitSpellHaste(unit); --MCFFIX disabled deleted function. GetCombatRatingBonus doesn't calculate talents so needs rework
	if (haste < 0) then
		haste = RED_FONT_COLOR_CODE..format("%.2F%%", haste)..FONT_COLOR_CODE_CLOSE;
	else
		haste = "+"..format("%.2F%%", haste);
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_STAT_HASTE"]));
	local text = _G[statFrame:GetName().."StatText"];
	text:SetText(haste);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, L["MCF_STAT_HASTE"]) .. " " .. haste .. FONT_COLOR_CODE_CLOSE;
	
	local _, class = UnitClass(unit);	
	statFrame.tooltip2 = _G["STAT_HASTE_SPELL_"..class.."_TOOLTIP"];
	if (not statFrame.tooltip2) then
		statFrame.tooltip2 = STAT_HASTE_SPELL_TOOLTIP;
	end
	statFrame.tooltip2 = statFrame.tooltip2 .. format(L["MCF_STAT_HASTE_BASE_TOOLTIP"], GetCombatRating(CR_HASTE_SPELL), GetCombatRatingBonus(CR_HASTE_SPELL));

	statFrame:Show();
end

function MCF_PaperDollFrame_SetSpellPenetration(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_SPELL_PENETRATION"]));
	local text = _G[statFrame:GetName().."StatText"];
	local spellPenetration = GetSpellPenetration();
	text:SetText(spellPenetration);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE ..L["MCF_SPELL_PENETRATION"].. FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(L["MCF_SPELL_PENETRATION_TOOLTIP"], spellPenetration, spellPenetration);
	statFrame:Show();
end

-- These vars needed for checking if Mana regen update is needed (on UNIT_AURA event)
local MCF_ManaRegenVisible = 0;
local MCF_CombatManaRegenVisible = 0;
function MCF_PaperDollFrame_UpdateManaRegen(self)
	local base, casting = GetManaRegen();
	base = floor( base * 5.0 );
	casting = floor( casting * 5.0 );
	if ((MCF_ManaRegenVisible ~= base) or (MCF_CombatManaRegenVisible ~= casting)) then
		self:SetScript("OnUpdate", MCF_PaperDollFrame_QueuedUpdate);
	end
end

function MCF_PaperDollFrame_SetManaRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, L["MCF_MANA_REGEN"]));
	local text = _G[statFrame:GetName().."StatText"];
	if ( not UnitHasMana("player") ) then
		text:SetText(NOT_APPLICABLE);
		statFrame.tooltip = nil;
		return;
	end
	
	local base, casting = GetManaRegen();
	-- All mana regen stats are displayed as mana/5 sec.
	base = floor( base * 5.0 );
	casting = floor( casting * 5.0 );
	text:SetText(base);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. L["MCF_MANA_REGEN"] .. FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(L["MCF_MANA_REGEN_TOOLTIP"], base);
	statFrame:Show();

	MCF_ManaRegenVisible = base;
end

function MCF_PaperDollFrame_SetCombatManaRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, MANA_REGEN_COMBAT));
	local text = _G[statFrame:GetName().."StatText"];
	if ( not UnitHasMana("player") ) then
		text:SetText(NOT_APPLICABLE);
		statFrame.tooltip = nil;
		return;
	end
	
	local base, casting = GetManaRegen();
	-- All mana regen stats are displayed as mana/5 sec.
	base = floor( base * 5.0 );
	casting = floor( casting * 5.0 );
	text:SetText(casting);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. MANA_REGEN_COMBAT .. FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(MANA_COMBAT_REGEN_TOOLTIP, casting);
	statFrame:Show();

	MCF_CombatManaRegenVisible = casting;
end

function MCF_PaperDollFrame_SetSpellCritChance(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, SPELL_CRIT_CHANCE));
	local text = _G[statFrame:GetName().."StatText"];
	local holySchool = 2;
	-- Start at 2 to skip physical damage
	local minCrit = GetSpellCritChance(holySchool);
	statFrame.spellCrit = {};
	statFrame.spellCrit[holySchool] = minCrit;
	local spellCrit;
	for i=(holySchool+1), MAX_SPELL_SCHOOLS do
		spellCrit = GetSpellCritChance(i);
		minCrit = min(minCrit, spellCrit);
		statFrame.spellCrit[i] = spellCrit;
	end
	minCrit = format("%.2F%%", minCrit);
	text:SetText(minCrit);
	statFrame.minCrit = minCrit;
	statFrame:SetScript("OnEnter", MCF_CharacterSpellCritChance_OnEnter);
	statFrame:Show();
end

-- DEFENSE
function MCF_PaperDollFrame_SetArmor(statFrame, unit)
	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor(unit);
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, ARMOR));
	local text = _G[statFrame:GetName().."StatText"];

	MCF_PaperDollFormatStat(ARMOR, base, posBuff, negBuff, statFrame, text);
	local armorReduction = MCF_PaperDollFrame_GetArmorReduction(effectiveArmor, UnitLevel(unit));
	statFrame.tooltip2 = format(DEFAULT_STATARMOR_TOOLTIP, armorReduction);
	
	if ( unit == "player" ) then
		local petBonus = MCF_ComputePetBonus("PET_BONUS_ARMOR", effectiveArmor );
		if( petBonus > 0 ) then
			statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_ARMOR, petBonus);
		end
	end
	
	statFrame:Show();
end

function MCF_PaperDollFrame_SetDefense(statFrame, unit)
	if (unit ~= "player") then
		statFrame:Hide();
		return;
	end

	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, DEFENSE));
	local text = _G[statFrame:GetName().."StatText"];

	local base, modifier = UnitDefense("player");
	local posBuff = 0;
	local negBuff = 0;
	if ( modifier > 0 ) then
		posBuff = modifier;
	elseif ( modifier < 0 ) then
		negBuff = modifier;
	end
	
	local effective = MCF_PaperDollFormatStat(DEFENSE, base, posBuff, negBuff, statFrame, text, true);
	text:SetText(effective);

	statFrame:SetScript("OnEnter", MCF_Defense_OnEnter);
	statFrame:Show();
end

function MCF_PaperDollFrame_SetDodge(statFrame, unit)
	if (unit ~= "player") then
		statFrame:Hide();
		return;
	end
	
	local chance = GetDodgeChance();
	MCF_PaperDollFrame_SetLabelAndText(statFrame, STAT_DODGE, chance, 1);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, DODGE_CHANCE).." "..string.format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(CR_DODGE_TOOLTIP, GetCombatRating(CR_DODGE), GetCombatRatingBonus(CR_DODGE));
	statFrame:Show();
end

function MCF_PaperDollFrame_SetParry(statFrame, unit)
	if (unit ~= "player") then
		statFrame:Hide();
		return;
	end
	
	local chance = GetParryChance();
	MCF_PaperDollFrame_SetLabelAndText(statFrame, L["MCF_STAT_PARRY"], chance, 1);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, PARRY_CHANCE).." "..string.format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(CR_PARRY_TOOLTIP, GetCombatRating(CR_PARRY), GetCombatRatingBonus(CR_PARRY));
	statFrame:Show();
end

function MCF_PaperDollFrame_SetBlock(statFrame, unit)
	if (unit ~= "player") then
		statFrame:Hide();
		return;
	end
	
	local chance = GetBlockChance();
	MCF_PaperDollFrame_SetLabelAndText(statFrame, STAT_BLOCK, chance, 1);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, BLOCK_CHANCE).." "..string.format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(L["MCF_CR_BLOCK_TOOLTIP"], GetCombatRating(CR_BLOCK), GetCombatRatingBonus(CR_BLOCK), GetShieldBlock());
	statFrame:Show();
end

function MCF_PaperDollFrame_SetResilience(statFrame, unit)
	if (unit ~= "player") then
		statFrame:Hide();
		return;
	end

	local damageResilience = GetCombatRating(CR_RESILIENCE_CRIT_TAKEN);
	local damageRatingBonus = GetCombatRatingBonus(CR_RESILIENCE_CRIT_TAKEN);
	local maxBonus = GetMaxCombatRatingBonus(CR_RESILIENCE_CRIT_TAKEN);
	MCF_PaperDollFrame_SetLabelAndText(statFrame, STAT_RESILIENCE, damageResilience);
	
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_RESILIENCE).." "..damageResilience..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(RESILIENCE_TOOLTIP, damageRatingBonus, min(damageRatingBonus * RESILIENCE_CRIT_CHANCE_TO_DAMAGE_REDUCTION_MULTIPLIER, maxBonus), damageRatingBonus * RESILIENCE_CRIT_CHANCE_TO_CONSTANT_DAMAGE_REDUCTION_MULTIPLIER);
	statFrame:Show();
end

-- RESISTANCE
function MCF_PaperDollFrame_SetResistance(statFrame, unit, resistanceIndex)
	local base, resistance, positive, negative = UnitResistance(unit, resistanceIndex);
	local resistanceNameShort = _G["DAMAGE_SCHOOL"..(resistanceIndex+1)];
	local resistanceName = _G["RESISTANCE"..resistanceIndex.."_NAME"];
	local resistanceIconCode = "|TInterface\\PaperDollInfoFrame\\SpellSchoolIcon"..(resistanceIndex+1)..":0|t";
	_G[statFrame:GetName().."Label"]:SetText(resistanceIconCode.." "..format(STAT_FORMAT, resistanceNameShort));
	local text = _G[statFrame:GetName().."StatText"];
	MCF_PaperDollFormatStat(resistanceName, base, positive, negative, statFrame, text);
	statFrame.tooltip = resistanceIconCode.." "..HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, resistanceName).." "..resistance..FONT_COLOR_CODE_CLOSE;
	
	if ( positive ~= 0 or negative ~= 0 ) then
		statFrame.tooltip = statFrame.tooltip.. " ( "..HIGHLIGHT_FONT_COLOR_CODE..base;
		if( positive > 0 ) then
			statFrame.tooltip = statFrame.tooltip..GREEN_FONT_COLOR_CODE.." +"..positive;
		end
		if( negative < 0 ) then
			statFrame.tooltip = statFrame.tooltip.." "..RED_FONT_COLOR_CODE..negative;
		end
		statFrame.tooltip = statFrame.tooltip..FONT_COLOR_CODE_CLOSE.." )";
	end
	
	statFrame.tooltip2 = format(L["MCF_RESISTANCE_TOOLTIP_SUBTEXT"], _G["SPELL_SCHOOL"..resistanceIndex.."_CAP"], ResistancePercent(resistance, UnitLevel(unit)));
	
	-- TODO: Put this in the tooltip?
	--local petBonus = ComputePetBonus( "PET_BONUS_RES", resistance );
end

-- VARIOUS
function MCF_PaperDollFrame_SetEnergyRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local powerType, powerToken = UnitPowerType(unit);
	if (powerToken ~= "ENERGY") then
		statFrame:Hide();
		return;
	end
	
	local regenRate = GetPowerRegen();
	regenRate = format("%.2F", regenRate);
	MCF_PaperDollFrame_SetLabelAndText(statFrame, STAT_ENERGY_REGEN, regenRate, false);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_ENERGY_REGEN).." "..regenRate..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_ENERGY_REGEN_TOOLTIP;
	statFrame:Show();
end

function MCF_PaperDollFrame_SetFocusRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local powerType, powerToken = UnitPowerType(unit);
	if (powerToken ~= "FOCUS") then
		statFrame:Hide();
		return;
	end
	
	local regenRate = GetPowerRegen();
	regenRate = format("%.2F", regenRate);
	MCF_PaperDollFrame_SetLabelAndText(statFrame, STAT_FOCUS_REGEN, regenRate, false);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_FOCUS_REGEN).." "..regenRate..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_FOCUS_REGEN_TOOLTIP;
	statFrame:Show();
end

function MCF_PaperDollFrame_SetRuneRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local _, class = UnitClass(unit);
	if (class ~= "DEATHKNIGHT") then
		statFrame:Hide();
		return;
	end
	
	local _, regenRate = GetRuneCooldown(1); -- Assuming they are all the same for now
	regenRate = format(STAT_RUNE_REGEN_FORMAT, regenRate);
	MCF_PaperDollFrame_SetLabelAndText(statFrame, STAT_RUNE_REGEN, regenRate, false);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_RUNE_REGEN).." "..regenRate..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_RUNE_REGEN_TOOLTIP;
	statFrame:Show();
end



-- UNUSED
function MCF_PaperDollFrame_SetRangedAttack(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

	local hasRelic = UnitHasRelicSlot(unit);
	local rangedAttackBase, rangedAttackMod = UnitRangedAttack(unit);
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, COMBAT_RATING_NAME1));
	local text = _G[statFrame:GetName().."StatText"];

	-- If no ranged texture then set stats to n/a
	local rangedTexture = GetInventoryItemTexture("player", 18);
	if ( rangedTexture and not hasRelic ) then
		PaperDollFrame.noRanged = nil;
	else
		text:SetText(NOT_APPLICABLE);
		PaperDollFrame.noRanged = 1;
		statFrame.tooltip = nil;
		return;
	end
	
	if( rangedAttackMod == 0 ) then
		text:SetText(rangedAttackBase);
		statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, COMBAT_RATING_NAME1).." "..rangedAttackBase..FONT_COLOR_CODE_CLOSE;
	else
		local color = RED_FONT_COLOR_CODE;
		if( rangedAttackMod > 0 ) then
	  		color = GREEN_FONT_COLOR_CODE;
			statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, COMBAT_RATING_NAME1).." "..(rangedAttackBase + rangedAttackMod).." ("..rangedAttackBase..color.." +"..rangedAttackMod..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..")";
		else
			statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, COMBAT_RATING_NAME1).." "..(rangedAttackBase + rangedAttackMod).." ("..rangedAttackBase..color.." "..rangedAttackMod..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..")";
		end
		text:SetText(color..(rangedAttackBase + rangedAttackMod)..FONT_COLOR_CODE_CLOSE);
	end
	local total = GetCombatRating(CR_WEAPON_SKILL) + GetCombatRating(CR_WEAPON_SKILL_RANGED);
	statFrame.tooltip2 = format(WEAPON_SKILL_RATING, total);
	if ( total > 0 ) then
		statFrame.tooltip2 = statFrame.tooltip2..format(WEAPON_SKILL_RATING_BONUS, GetCombatRatingBonus(CR_WEAPON_SKILL) + GetCombatRatingBonus(CR_WEAPON_SKILL_RANGED));
	end
	statFrame:Show();
end

-- Disabled completely because mastery doesn't exist in WotLK
--[[ function MCF_PaperDollFrame_SetMastery(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	if (UnitLevel("player") < SHOW_MASTERY_LEVEL) then
		statFrame:Hide();
		return;
	end
	
	_G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_MASTERY));
	local text = _G[statFrame:GetName().."StatText"];
	local mastery = GetMastery();
	mastery = format("%.2F", mastery);
	text:SetText(mastery);
	statFrame:SetScript("OnEnter", MCF_Mastery_OnEnter);
	statFrame:Show();
end ]]

----------------------------------------------------------------------------------
--------------------------------- STATS ON ENTER ---------------------------------
----------------------------------------------------------------------------------
-- Reset tooltip text font (for Hit tooltips)
function MCF_ResetTooltipTextFonts(self, startLine)
	if (not startLine) then
		startLine = 1;
	end
	if (self.lines) then
		for i=startLine, self.lines do
			local left = _G["GameTooltipTextLeft"..i];
			local right = _G["GameTooltipTextRight"..i];
			if (left.changed) then
				left:SetFontObject(GameTooltipText);
			end
			if (right.changed) then
				right:SetFontObject(GameTooltipText);
			end
		end
		self.changed = nil;
	end
end

-- GENERAL
function MCF_MovementSpeed_OnEnter(statFrame)
	if (MOVING_STAT_CATEGORY) then return; end
	
	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_MOVEMENT_SPEED).." "..format("%d%%", statFrame.speed+0.5)..FONT_COLOR_CODE_CLOSE);
	
	GameTooltip:AddLine(format(STAT_MOVEMENT_GROUND_TOOLTIP, statFrame.runSpeed+0.5));
	if (statFrame.unit ~= "pet") then
		GameTooltip:AddLine(format(STAT_MOVEMENT_FLIGHT_TOOLTIP, statFrame.flightSpeed+0.5));
	end
	GameTooltip:AddLine(format(STAT_MOVEMENT_SWIM_TOOLTIP, statFrame.swimSpeed+0.5));
	GameTooltip:Show();
	
	statFrame.UpdateTooltip = MCF_MovementSpeed_OnEnter;
end

-- MELEE
function MCF_CharacterDamageFrame_OnEnter(self)
	if (MOVING_STAT_CATEGORY) then return; end
	-- Main hand weapon
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if ( self.unit == "pet" ) then
		GameTooltip:SetText(INVTYPE_WEAPONMAINHAND_PET, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	else
		GameTooltip:SetText(INVTYPE_WEAPONMAINHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, ATTACK_SPEED_SECONDS), format("%.2F", self.attackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE), self.damage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE_PER_SECOND), format("%.1F", self.dps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	-- Check for offhand weapon
	if ( self.offhandAttackSpeed ) then
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine(INVTYPE_WEAPONOFFHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(format(STAT_FORMAT, ATTACK_SPEED_SECONDS), format("%.2F", self.offhandAttackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE), self.offhandDamage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE_PER_SECOND), format("%.1F", self.offhandDps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	GameTooltip:Show();
end

function MCF_MeleeHitChance_OnEnter(statFrame)
	if (MOVING_STAT_CATEGORY) then
		return;
	end

	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");

	local hitChance = GetCombatRatingBonus(CR_HIT_MELEE);--[[  + GetHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.
	local _, class = UnitClass("player");
	local _, race = UnitRace("player");
	local hitFromTalents = MCF_CheckHitTalents(class, "melee");

	local special = 0;
	if (race == "Draenei") then
		special = 1;
	end

	if ( hitFromTalents and (#hitFromTalents > 0) ) then
		for i=1, #hitFromTalents do
			special = special + hitFromTalents[i].plusHit;
		end
	end

	-- Check DK's "Nerves of Cold Steel talent and equipped weapon type
	local dk_cold_steel = nil;
	if (class == "DEATHKNIGHT") then
		local _, _, _, _, rank = GetTalentInfo(2, 16);
		if (rank > 0) then
			local id = GetInventoryItemID("player", 16);
			if (not id) then
				id = GetInventoryItemID("player", 17);
			end
			if (id) then
				local _,_,_,_,_,_,_,_, weapon_type = GetItemInfo(id);
				if (weapon_type == "INVTYPE_WEAPON") then
					special = special + rank;
					dk_cold_steel = rank;
				end
			end
		end
	end

	-- Check Shaman's "Dual Wielding Specialization" talent and dual wielding
	local shaman_dualwield_spec = nil;
	if (class == "SHAMAN") then
		local _, _, _, _, rank = GetTalentInfo(2, 19);
		if ((rank > 0) and IsDualWielding()) then
			special = special + rank * 2;
			shaman_dualwield_spec = rank * 2;
		end
	end

	hitChance = hitChance + special;
	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HIT_CHANCE).." "..hitChance..FONT_COLOR_CODE_CLOSE);
	GameTooltip:AddLine(format(L["MCF_STAT_HIT_MELEE_TOOLTIP"], GetCombatRating(CR_HIT_MELEE), GetCombatRatingBonus(CR_HIT_MELEE)));

	if (race == "Draenei") then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(L["MCF_TALENTS_AND_ABILITIES_EFFECTS_ACTIVE"]);
		GameTooltip:AddDoubleLine(GetSpellInfo(6562), GREEN_FONT_COLOR_CODE..format(L["MCF_TALENT_DESC_BASE"], 1)..FONT_COLOR_CODE_CLOSE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddTexture("Interface\\Icons\\inv_helmet_21");
	end

	if (dk_cold_steel) then
		if (race ~= "Draenei") then
			GameTooltip:AddLine(" ");
			GameTooltip:AddLine(L["MCF_TALENT_EFFECTS_ACTIVE"]);
		end
		GameTooltip:AddDoubleLine(GetTalentInfo(2, 16), GREEN_FONT_COLOR_CODE..format(L["MCF_TALENT_DESC_BASE"], dk_cold_steel)..FONT_COLOR_CODE_CLOSE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddTexture("Interface\\Icons\\ability_dualwield");
	end

	if (shaman_dualwield_spec) then
		if (race ~= "Draenei") then
			GameTooltip:AddLine(" ");
			GameTooltip:AddLine(L["MCF_TALENT_EFFECTS_ACTIVE"]);
		end
		GameTooltip:AddDoubleLine(GetTalentInfo(2, 19), GREEN_FONT_COLOR_CODE..format(L["MCF_TALENT_DESC_BASE"], shaman_dualwield_spec)..FONT_COLOR_CODE_CLOSE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddTexture("Interface\\Icons\\ability_dualwieldspecialization");
	end

	if ( hitFromTalents and (#hitFromTalents > 0) ) then
		if (race ~= "Draenei") then
			GameTooltip:AddLine(" ");
			GameTooltip:AddLine(L["MCF_TALENT_EFFECTS_ACTIVE"]);
		end

		for i=1, #hitFromTalents do
			local talentName, _, _, _, _ = GetTalentInfo(hitFromTalents[i].tab, hitFromTalents[i].index);
			local icon = hitFromTalents[i].icon;
			local description = L["MCF_TALENT_DESC_BASE"];
			local talentPercent = hitFromTalents[i].plusHit;

			GameTooltip:AddDoubleLine(talentName, GREEN_FONT_COLOR_CODE..format(description, talentPercent)..FONT_COLOR_CODE_CLOSE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			GameTooltip:AddTexture(icon);
		end
	end

	GameTooltip:AddLine(" ");
	GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, MISS_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	if (IsDualWielding()) then
		GameTooltip:AddLine(STAT_HIT_NORMAL_ATTACKS, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	end
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local missChance = format("%.2F%%", MCF_GetMeleeMissChance(i, special, false));
		local level = playerLevel + i;
			if (i == 3) then
				level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
			end
		GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	
	if (IsDualWielding()) then
		GameTooltip:AddLine(STAT_HIT_SPECIAL_ATTACKS, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		for i=0, 3 do
			local missChance = format("%.2F%%", MCF_GetMeleeMissChance(i, special, true));
			local level = playerLevel + i;
			if (i == 3) then
				level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
			end
			GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
	end
	
	GameTooltip:Show();
end

function MCF_Expertise_OnEnter(statFrame)
	if (MOVING_STAT_CATEGORY) then
		return;
	end

	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
	local expertise, offhandExpertise = GetExpertise();
	local expertisePercent, offhandExpertisePercent = GetExpertisePercent();
	expertisePercent = format("%.2F", expertisePercent);
	offhandExpertisePercent = format("%.2F", offhandExpertisePercent);
	
	local expertiseDisplay, expertisePercentDisplay;
	if (IsDualWielding()) then
		expertiseDisplay = expertise.." / "..offhandExpertise;
		expertisePercentDisplay = expertisePercent.."% / "..offhandExpertisePercent.."%";
	else
		expertiseDisplay = expertise;
		expertisePercentDisplay = expertisePercent.."%";
	end
	
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, _G["COMBAT_RATING_NAME"..CR_EXPERTISE]).." "..expertiseDisplay..FONT_COLOR_CODE_CLOSE);
	GameTooltip:AddLine(format(L["MCF_CR_EXPERTISE_TOOLTIP"], expertisePercentDisplay, GetCombatRating(CR_EXPERTISE), GetCombatRatingBonus(CR_EXPERTISE)), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
	GameTooltip:AddLine(" ");
	
	-- Dodge chance
	GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, DODGE_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local mainhandDodge, offhandDodge = MCF_GetEnemyDodgeChance(i);
		mainhandDodge = format("%.2F%%", mainhandDodge);
		offhandDodge = format("%.2F%%", offhandDodge);
		local level = playerLevel + i;
		if (i == 3) then
			level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
		end
		local dodgeDisplay;
		if (IsDualWielding() and mainhandDodge ~= offhandDodge) then
			dodgeDisplay = mainhandDodge.." / "..offhandDodge;
		else
			dodgeDisplay = mainhandDodge.."  ";
		end
		GameTooltip:AddDoubleLine("      "..level, dodgeDisplay.."  ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	
	-- Parry chance
	GameTooltip:AddLine(" ");
	GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, PARRY_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local mainhandParry, offhandParry = MCF_GetEnemyParryChance(i);
		mainhandParry = format("%.2F%%", mainhandParry);
		offhandParry = format("%.2F%%", offhandParry);
		local level = playerLevel + i;
		if (i == 3) then
			level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
		end
		local parryDisplay;
		if (IsDualWielding() and mainhandParry ~= offhandParry) then
			parryDisplay = mainhandParry.." / "..offhandParry;
		else
			parryDisplay = mainhandParry.."  ";
		end
		GameTooltip:AddDoubleLine("      "..level, parryDisplay.."  ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
		
	GameTooltip:Show();
end

-- RANGED
function MCF_CharacterRangedDamageFrame_OnEnter(self)
	if (MOVING_STAT_CATEGORY) then return; end
	if ( not self.damage ) then
		return;
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(INVTYPE_RANGED, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, ATTACK_SPEED_SECONDS), format("%.2F", self.attackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE), self.damage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(format(STAT_FORMAT, DAMAGE_PER_SECOND), format("%.1F", self.dps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:Show();
end

function MCF_RangedHitChance_OnEnter(statFrame)
	if (MOVING_STAT_CATEGORY) then
		return;
	end

	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");

	local hitChance = GetCombatRatingBonus(CR_HIT_RANGED);--[[  + GetHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.
	local _, class = UnitClass("player");
	local _, race = UnitRace("player");
	local faction = UnitFactionGroup("player");
	local hitFromTalents = MCF_CheckHitTalents(class, "ranged");

	local special = 0;
	if (race == "Draenei") then
		special = 1;
	end

	if ( hitFromTalents and (#hitFromTalents > 0) ) then
		for i=1, #hitFromTalents do
			special = special + hitFromTalents[i].plusHit;
		end
	end

	hitChance = hitChance + special;
	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HIT_CHANCE).." "..hitChance..FONT_COLOR_CODE_CLOSE);
	GameTooltip:AddLine(format(L["MCF_STAT_HIT_RANGED_TOOLTIP"], GetCombatRating(CR_HIT_RANGED), GetCombatRatingBonus(CR_HIT_RANGED)));

	if (race == "Draenei") then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(L["MCF_TALENTS_AND_ABILITIES_EFFECTS_ACTIVE"]);
		GameTooltip:AddDoubleLine(GetSpellInfo(6562), GREEN_FONT_COLOR_CODE..format(L["MCF_TALENT_DESC_BASE"], 1)..FONT_COLOR_CODE_CLOSE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddTexture("Interface\\Icons\\inv_helmet_21");
	end

	if ( hitFromTalents and (#hitFromTalents > 0) ) then
		if (race ~= "Draenei") then
			GameTooltip:AddLine(" ");
			GameTooltip:AddLine(L["MCF_TALENT_EFFECTS_ACTIVE"]);
		end

		for i=1, #hitFromTalents do
			local talentName, _, _, _, _ = GetTalentInfo(hitFromTalents[i].tab, hitFromTalents[i].index);
			local icon = hitFromTalents[i].icon;
			local description = L["MCF_TALENT_DESC_BASE"];
			local talentPercent = hitFromTalents[i].plusHit;

			GameTooltip:AddDoubleLine(talentName, GREEN_FONT_COLOR_CODE..format(description, talentPercent)..FONT_COLOR_CODE_CLOSE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			GameTooltip:AddTexture(icon);
		end
	end

	GameTooltip:AddLine(" ");
	GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, MISS_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local missChance = format("%.2F%%", MCF_GetRangedMissChance(i, special));
		local level = playerLevel + i;
			if (i == 3) then
				level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
			end
		GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
		
	GameTooltip:Show();
end

-- SPELLS
function MCF_CharacterSpellBonusDamage_OnEnter(self)
	if (MOVING_STAT_CATEGORY) then return; end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, self.tooltip).." "..self.minModifier..FONT_COLOR_CODE_CLOSE);

	for i=2, MAX_SPELL_SCHOOLS do
		if (self.bonusDamage and self.bonusDamage[i] ~= self.minModifier) then
			GameTooltip:AddLine(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, _G["DAMAGE_SCHOOL"..i]).." "..self.bonusDamage[i]..FONT_COLOR_CODE_CLOSE);
			GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon"..i);
		end
	end
	
	GameTooltip:AddLine(self.tooltip2);
	
	if (self.bonusDamage and self.unit == "player") then
		local petStr, damage;
		if (self.bonusDamage[6] == self.minModifier and self.bonusDamage[3] == self.minModifier) then
			petStr = PET_BONUS_TOOLTIP_WARLOCK_SPELLDMG;
			damage = self.minModifier;
		elseif( self.bonusDamage[6] > self.bonusDamage[3] ) then
			petStr = PET_BONUS_TOOLTIP_WARLOCK_SPELLDMG_SHADOW;
			damage = self.bonusDamage[6];
		else
			petStr = PET_BONUS_TOOLTIP_WARLOCK_SPELLDMG_FIRE;
			damage = self.bonusDamage[3];
		end
		
		local petBonusAP = MCF_ComputePetBonus("PET_BONUS_SPELLDMG_TO_AP", damage );
		local petBonusDmg = MCF_ComputePetBonus("PET_BONUS_SPELLDMG_TO_SPELLDMG", damage );
		if( petBonusAP > 0 or petBonusDmg > 0 ) then
			GameTooltip:AddLine(format(petStr, petBonusAP, petBonusDmg), nil, nil, nil, 1 );
		end
	end
	GameTooltip:Show();
end

function MCF_SpellHitChance_OnEnter(statFrame)
	if (MOVING_STAT_CATEGORY) then
		return;
	end

	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");

	-- Resetting text lines font to default (first 3 lines skipped)
	if (statFrame.changed) then
		MCF_ResetTooltipTextFonts(statFrame, 4);
	end

	local hitChance = GetCombatRatingBonus(CR_HIT_SPELL);
	local _, class = UnitClass("player");
	local _, race = UnitRace("player");
	local hitFromTalents = MCF_CheckHitTalents(class, "spells");
	local schools;

	local special = 0;
	if (race == "Draenei") then
		special = 1;
	end
	if ( hitFromTalents and (#hitFromTalents > 0) ) then
		for i=1, #hitFromTalents do
			if hitFromTalents[i].all_schools then
				special = special + hitFromTalents[i].plusHit;
			else
				schools = hitFromTalents[i].schools;
			end
		end
	end

	hitChance = hitChance + special;
	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HIT_CHANCE).." "..hitChance..FONT_COLOR_CODE_CLOSE);
	
	GameTooltip:AddLine(format(L["MCF_STAT_HIT_SPELL_TOOLTIP"], GetCombatRating(CR_HIT_SPELL), GetCombatRatingBonus(CR_HIT_SPELL)));

	local line = 3;
	-- If unit is Draenei then use another "talents active" string and add racial Heroic Presence buff (+1% hit)
	if (race == "Draenei") then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(L["MCF_TALENTS_AND_ABILITIES_EFFECTS_ACTIVE"]);
		GameTooltip:AddDoubleLine(GetSpellInfo(6562), GREEN_FONT_COLOR_CODE..format(L["MCF_TALENT_DESC_BASE"], 1)..FONT_COLOR_CODE_CLOSE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddTexture("Interface\\Icons\\inv_helmet_21");
		line = line + 2;
	end

	if ( hitFromTalents and (#hitFromTalents > 0) ) then
		if (race ~= "Draenei") then
			GameTooltip:AddLine(" ");
			GameTooltip:AddLine(L["MCF_TALENT_EFFECTS_ACTIVE"]);
			line = line + 1;
		end

		for i=1, #hitFromTalents do
			local talentName, _, _, _, _ = GetTalentInfo(hitFromTalents[i].tab, hitFromTalents[i].index);
			local icon = hitFromTalents[i].icon;
			local description = L["MCF_TALENT_DESC_BASE"];
			local talentPercent = hitFromTalents[i].plusHit;

			GameTooltip:AddDoubleLine(talentName, GREEN_FONT_COLOR_CODE..format(description, talentPercent)..FONT_COLOR_CODE_CLOSE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			GameTooltip:AddTexture(icon);
			line = line + 1;

			if (not hitFromTalents[i].all_schools) then
				local schoolsText = "";
				for i, id in ipairs(schools) do
					if (i ~= #schools) then
						schoolsText = schoolsText.._G["DAMAGE_SCHOOL"..id]..", ";
					else
						schoolsText = schoolsText.._G["DAMAGE_SCHOOL"..id];
					end
				end
				GameTooltip:AddDoubleLine(L["MCF_TALENT_NOT_TAKEN_INTO_ACCOUNT"], schoolsText);
				GameTooltip:AddTexture("");

				-- Changing font size (font object) for specific talent descriptions and setting flags for tooltip updates
				line = line + 1;
				local left = _G["GameTooltipTextLeft"..line];
				local right = _G["GameTooltipTextRight"..line];
				left:SetFontObject(GameFontNormalSmall);
				left.changed = true;
				right:SetFontObject(GameFontNormalSmall);
				right.changed = true;
			end
		end
	end
	statFrame.lines = line;

	GameTooltip:AddLine(" ");
	GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, MISS_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local missChance = format("%.2F%%", MCF_GetSpellMissChance(i, special));
		local level = playerLevel + i;
			if (i == 3) then
				level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
			end
		GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end

	GameTooltip:Show();
end

function MCF_CharacterSpellCritChance_OnEnter(self)
	if (MOVING_STAT_CATEGORY) then return; end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, SPELL_CRIT_CHANCE).." "..self.minCrit..FONT_COLOR_CODE_CLOSE);
	local spellCrit;
	for i=2, MAX_SPELL_SCHOOLS do
		spellCrit = format("%.2F%%", self.spellCrit[i]);
		if (spellCrit ~= self.minCrit) then
			GameTooltip:AddDoubleLine(_G["DAMAGE_SCHOOL"..i], spellCrit, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon"..i);
		end
	end
	GameTooltip:AddLine(format(L["MCF_CR_CRIT_SPELL_TOOLTIP"], GetCombatRating(CR_CRIT_SPELL), GetCombatRatingBonus(CR_CRIT_SPELL)));
	GameTooltip:Show();
end

-- DEFENSE
function MCF_Defense_OnEnter(statFrame)
	if (MOVING_STAT_CATEGORY) then
		return;
	end

	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");

	local base, modifier = UnitDefense("player");
	local CritHitTakenChance = GetCombatRatingBonus(CR_DEFENSE_SKILL);
	local percentFromRating = CritHitTakenChance * 0.04;

	local posBuff = 0;
	local negBuff = 0;
	if ( modifier > 0 ) then
		posBuff = modifier;
	elseif ( modifier < 0 ) then
		negBuff = modifier;
	end

	if (CritHitTakenChance >= 0) then
		CritHitTakenChance = format("+%.2F%%", CritHitTakenChance);
	else
		CritHitTakenChance = RED_FONT_COLOR_CODE..format("%.2F%%", CritHitTakenChance)..FONT_COLOR_CODE_CLOSE;
	end
	
	local _, defenseText = MCF_PaperDollFormatStat(DEFENSE, base, posBuff, negBuff, statFrame, text, true);

	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..defenseText..FONT_COLOR_CODE_CLOSE);

	GameTooltip:AddLine(format(DEFAULT_STATDEFENSE_TOOLTIP, GetCombatRating(CR_DEFENSE_SKILL), GetCombatRatingBonus(CR_DEFENSE_SKILL), percentFromRating, percentFromRating));
	GameTooltip:AddLine(" ");

	-- Check for specific talents that decrease chance to be critically hit
	local _, class = UnitClass("player");
	if ( class == "DRUID" ) then
		local talentName, _, _, _, rank = GetTalentInfo(2, 18);
		if (rank > 0) then
			local icon = "Interface\\Icons\\Ability_Druid_Enrage";
			local talentPercent = rank * 2;

			GameTooltip:AddLine(L["MCF_TALENT_EFFECTS_ACTIVE"]);
			GameTooltip:AddDoubleLine(talentName, GREEN_FONT_COLOR_CODE..format(L["MCF_DEFENSE_TOOLTIP_DRUID_TALENT"], talentPercent)..FONT_COLOR_CODE_CLOSE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			GameTooltip:AddTexture(icon);
			GameTooltip:AddLine(" ");
		end
	end
	if ( class == "WARLOCK" ) then
		local talentName, _, _, _, rank = GetTalentInfo(2, 20);
		if (rank > 0) then
			local icon = "Interface\\Icons\\spell_shadow_demonicfortitude";
			local talentPercent = rank;

			GameTooltip:AddLine(L["MCF_TALENT_EFFECTS_ACTIVE"]);
			GameTooltip:AddDoubleLine(talentName, GREEN_FONT_COLOR_CODE..format(L["MCF_DEFENSE_TOOLTIP_DRUID_TALENT"], talentPercent)..FONT_COLOR_CODE_CLOSE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			GameTooltip:AddTexture(icon);
			GameTooltip:AddLine(" ");
		end
	end

	GameTooltip:AddDoubleLine(L["MCF_STAT_ENEMY_LEVEL"], L["MCF_CRIT_HIT_TAKEN_CHANCE"], HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local critHitTakenChance = format("%.2F%%", MCF_GetCritHitTakenChance(i));
		local level = playerLevel + i;
			if (playerLevel == 80 and i == 3) then
				level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
			end
		GameTooltip:AddDoubleLine("      "..level, critHitTakenChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
		
	GameTooltip:Show();
end


-- UNUSED
function MCF_CharacterAttackFrame_OnEnter(self)
	if (MOVING_STAT_CATEGORY) then return; end
	-- Main hand weapon
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(INVTYPE_WEAPONMAINHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine(self.weaponSkill);
	GameTooltip:AddLine(self.weaponRating);
	-- Check for offhand weapon
	if ( self.offhandSkill ) then
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine(INVTYPE_WEAPONOFFHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine(self.offhandSkill);
		GameTooltip:AddLine(self.offhandRating);
	end
	GameTooltip:Show();
end

-- Disabled completely because mastery doesn't exist in WotLK
--[[ function MCF_Mastery_OnEnter(statFrame)
	if (not MOVING_STAT_CATEGORY) then return; end
	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
	
	local _, class = UnitClass("player");
	local mastery = GetMastery();
	local masteryBonus = GetCombatRatingBonus(CR_MASTERY);
	
	local title = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_MASTERY).." "..format("%.2F", mastery)..FONT_COLOR_CODE_CLOSE;
	if (masteryBonus > 0) then
		title = title..HIGHLIGHT_FONT_COLOR_CODE.." ("..format("%.2F", mastery-masteryBonus)..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..format("%.2F", masteryBonus)..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..")";
	end
	GameTooltip:SetText(title);
	
	local masteryKnown = IsSpellKnown(MCF_CLASS_MASTERY_SPELLS[class]);
	local primaryTalentTree = GetPrimaryTalentTree();
	if (masteryKnown and primaryTalentTree) then
		local masterySpell, masterySpell2 = GetTalentTreeMasterySpells(primaryTalentTree);
		if (masterySpell) then
			GameTooltip:AddSpellByID(masterySpell);
		end
		if (masterySpell2) then
			GameTooltip:AddLine(" ");
			GameTooltip:AddSpellByID(masterySpell2);
		end
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(format(STAT_MASTERY_TOOLTIP, GetCombatRating(CR_MASTERY), masteryBonus), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
	else
		GameTooltip:AddLine(format(STAT_MASTERY_TOOLTIP, GetCombatRating(CR_MASTERY), masteryBonus), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
		GameTooltip:AddLine(" ");
		if (masteryKnown) then
			GameTooltip:AddLine(STAT_MASTERY_TOOLTIP_NO_TALENT_SPEC, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, true);
		else
			GameTooltip:AddLine(STAT_MASTERY_TOOLTIP_NOT_KNOWN, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, true);
		end
	end
	GameTooltip:Show();
end ]]

-- Replaced with custom one
function _MCF_SpellHitChance_OnEnter(statFrame)

	if (MOVING_STAT_CATEGORY) then return; end
	GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT");
	local hitChance = GetCombatRatingBonus(CR_HIT_SPELL);--[[  + GetSpellHitModifier(); ]] --MCFFIX isn't needed in Wrath Classic.
	if (hitChance >= 0) then
		hitChance = format("+%.2F%%", hitChance);
	else
		hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
	end
	GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HIT_CHANCE).." "..hitChance..FONT_COLOR_CODE_CLOSE);
	GameTooltip:AddLine(format(L["MCF_STAT_HIT_SPELL_TOOLTIP"], GetCombatRating(CR_HIT_SPELL), GetCombatRatingBonus(CR_HIT_SPELL)));
	GameTooltip:AddLine(L["MCF_SPELLHIT_NOTALENTS_TOOLTIP"]);
	GameTooltip:AddLine(" ");
	GameTooltip:AddDoubleLine(STAT_TARGET_LEVEL, MISS_CHANCE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	local playerLevel = UnitLevel("player");
	for i=0, 3 do
		local missChance = format("%.2F%%", MCF_GetSpellMissChance(i));
		local level = playerLevel + i;
			if (i == 3) then
				level = level.." / |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:0|t";
			end
		GameTooltip:AddDoubleLine("      "..level, missChance.."    ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
		
	GameTooltip:Show();
end