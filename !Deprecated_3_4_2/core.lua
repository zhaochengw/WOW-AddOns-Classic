
do
	-- Deprecated_9_1_5.lua
	if C_LFGList then
		if not C_LFGList.GetCategoryInfo then
			-- Use GetLfgCategoryInfo going forward
			function C_LFGList.GetCategoryInfo(categoryID)
				local categoryInfo = C_LFGList.GetLfgCategoryInfo(categoryID);
				if categoryInfo then
					return categoryInfo.name, categoryInfo.separateRecommended, categoryInfo.autoChooseActivity, categoryInfo.preferCurrentArea, categoryInfo.showPlaystyleDropdown;
				end
			end
		end

		if not C_LFGList.GetActivityInfo then
			function C_LFGList.GetActivityInfo(activityID, questID, showWarmode)
				local activityInfo = C_LFGList.GetActivityInfoTable(activityID, questID, showWarmode);
				if activityInfo then
					return activityInfo.fullName, activityInfo.shortName, activityInfo.categoryID, activityInfo.groupFinderActivityGroupID, activityInfo.ilvlSuggestion, activityInfo.filters, activityInfo.minLevel, activityInfo.maxNumPlayers, activityInfo.displayType, activityInfo.orderIndex, activityInfo.useHonorLevel, activityInfo.showQuickJoinToast, activityInfo.isMythicPlusActivity, activityInfo.isRatedPvpActivity, activityInfo.isCurrentRaidActivity;
				end
			end
		end
	end

	if C_Container then
		ContainerIDToInventoryID = ContainerIDToInventoryID or C_Container.ContainerIDToInventoryID
		PickupContainerItem = PickupContainerItem or C_Container.PickupContainerItem
		UseContainerItem = UseContainerItem or C_Container.UseContainerItem
		GetContainerNumSlots = GetContainerNumSlots or C_Container.GetContainerNumSlots
		GetContainerItemLink = GetContainerItemLink or C_Container.GetContainerItemLink
		GetContainerItemCooldown = GetContainerItemCooldown or C_Container.GetContainerItemCooldown
		GetContainerNumFreeSlots = GetContainerNumFreeSlots or C_Container.GetContainerNumFreeSlots
		GetItemCooldown = GetItemCooldown or C_Container.GetItemCooldown
		GetBagSlotFlag = GetBagSlotFlag or C_Container.GetBagSlotFlag
		GetBagName = GetBagName or C_Container.GetBagName

		GetContainerItemInfo = GetContainerItemInfo or function(containerIndex, slotIndex)
			local itemInfo = C_Container.GetContainerItemInfo(containerIndex, slotIndex)
			if itemInfo then
				return itemInfo.iconFileID, itemInfo.stackCount, itemInfo.isLocked, itemInfo.quality, itemInfo.isReadable, itemInfo.hasLoot, itemInfo.hyperlink, itemInfo.isFiltered, itemInfo.hasNoValue, itemInfo.itemID, itemInfo.isBound
			end
		end
	end

	-- 10.1
	GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata

	-- 10.2
	GetCVarInfo = C_CVar.GetCVarInfo;

	EnableAddOn = C_AddOns.EnableAddOn;
	DisableAddOn = C_AddOns.DisableAddOn;
	GetAddOnEnableState = function(character, name) return C_AddOns.GetAddOnEnableState(name, character); end
	LoadAddOn = C_AddOns.LoadAddOn;
	IsAddOnLoaded = C_AddOns.IsAddOnLoaded;
	EnableAllAddOns = C_AddOns.EnableAllAddOns;
	DisableAllAddOns = C_AddOns.DisableAllAddOns;
	GetAddOnInfo = C_AddOns.GetAddOnInfo;
	GetAddOnDependencies = C_AddOns.GetAddOnDependencies;
	GetAddOnOptionalDependencies = C_AddOns.GetAddOnOptionalDependencies;
	GetNumAddOns = C_AddOns.GetNumAddOns;
	SaveAddOns = C_AddOns.SaveAddOns;
	ResetAddOns = C_AddOns.ResetAddOns;
	ResetDisabledAddOns = C_AddOns.ResetDisabledAddOns;
	IsAddonVersionCheckEnabled = C_AddOns.IsAddonVersionCheckEnabled;
	SetAddonVersionCheck = C_AddOns.SetAddonVersionCheck;
	IsAddOnLoadOnDemand = C_AddOns.IsAddOnLoadOnDemand;

	-- 10.2.5
	GetItemStats = GetItemStats or function(itemLink, existingTable)
		local statTable = C_Item.GetItemStats(itemLink);
		if existingTable then
			MergeTable(existingTable, statTable);
			return existingTable;
		else
			return statTable;
		end
	end

	-- if C_UnitAuras then
		-- UnitAura = function(unitToken, index, filter)
			-- local auraData = C_UnitAuras.GetAuraDataByIndex(unitToken, index, filter);
			-- if not auraData then
				-- return nil;
			-- end

			-- return AuraUtil.UnpackAuraData(auraData);
		-- end
		-- UnitBuff = function(unitToken, index, filter)
			-- local auraData = C_UnitAuras.GetBuffDataByIndex(unitToken, index, filter);
			-- if not auraData then
				-- return nil;
			-- end

			-- return AuraUtil.UnpackAuraData(auraData);
		-- end
		-- UnitDebuff = function(unitToken, index, filter)
			-- local auraData = C_UnitAuras.GetDebuffDataByIndex(unitToken, index, filter);
			-- if not auraData then
				-- return nil;
			-- end

			-- return AuraUtil.UnpackAuraData(auraData);
		-- end
		-- UnitAuraBySlot = function(unitToken, index)
			-- local auraData = C_UnitAuras.GetAuraDataBySlot(unitToken, index);
			-- if not auraData then
				-- return nil;
			-- end

			-- return AuraUtil.UnpackAuraData(auraData);
		-- end
		-- UnitAuraSlots = C_UnitAuras.GetAuraSlots;
	-- end

	-- 11.0
	GetMouseFocus = GetMouseFocus or function(predicate, ctx, fallbackOnReject)
		local foci = GetMouseFoci()
		for i=1, #foci do
			local fi = foci[i]
			if fi and not (fi and fi.IsForbidden and fi:IsForbidden()) and predicate and predicate(fi, ctx) then
				return fi
			end
		end
		return fallbackOnReject ~= false and foci[1] or nil
	end

	if Settings and Settings.RegisterCanvasLayoutCategory then
		--[[ Deprecated.
		See Blizzard_ImplementationReadme.lua for recommended setup.
		]]
		InterfaceOptions_AddCategory = function(frame, addOn, position)
			-- cancel is no longer a default option. May add menu extension for this.
			frame.OnCommit = frame.okay;
			frame.OnDefault = frame.default;
			frame.OnRefresh = frame.refresh;

			if frame.parent then
				local category = Settings.GetCategory(frame.parent);
				local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, frame, frame.name, frame.name);
				subcategory.ID = frame.name;
				return subcategory, category;
			else
				local category, layout = Settings.RegisterCanvasLayoutCategory(frame, frame.name, frame.name);
				category.ID = frame.name;
				Settings.RegisterAddOnCategory(category);
				return category;
			end
		end

		-- Deprecated. Use Settings.OpenToCategory().
		InterfaceOptionsFrame_OpenToCategory = function(categoryIDOrFrame)
			if type(categoryIDOrFrame) == "table" then
				local categoryID = categoryIDOrFrame.name;
				return Settings.OpenToCategory(categoryID);
			else
				return Settings.OpenToCategory(categoryIDOrFrame);
			end
		end
	end

end