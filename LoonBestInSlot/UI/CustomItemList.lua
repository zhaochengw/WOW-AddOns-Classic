LBIS.CustomItemList = {};

local itemSlotOrder = {}
itemSlotOrder[LBIS.L["Head"]] = 0;
itemSlotOrder[LBIS.L["Shoulder"]] = 1;
itemSlotOrder[LBIS.L["Back"]] = 2;
itemSlotOrder[LBIS.L["Chest"]] = 3;
itemSlotOrder[LBIS.L["Wrist"]] = 4;
itemSlotOrder[LBIS.L["Hands"]] = 5;
itemSlotOrder[LBIS.L["Waist"]] = 6;
itemSlotOrder[LBIS.L["Legs"]] = 7;
itemSlotOrder[LBIS.L["Feet"]] = 8;
itemSlotOrder[LBIS.L["Neck"]] = 9;
itemSlotOrder[LBIS.L["Ring"]] = 10;
itemSlotOrder[LBIS.L["Trinket"]] = 11;
itemSlotOrder[LBIS.L["Main Hand"]] = 12;
itemSlotOrder[LBIS.L["Off Hand"]] = 13;
itemSlotOrder[LBIS.L["Ranged/Relic"]] = 14;

local function slotSortFunction(table, k1, k2)

    local item1Score = 0;
    local item2Score = 0;

    if itemSlotOrder[k1] < itemSlotOrder[k2] then
        item1Score = item1Score + 1000;
    end
    if itemSlotOrder[k1] > itemSlotOrder[k2] then
        item2Score = item2Score +  1000;
    end

    return item1Score > item2Score
end

local function IsInRank(specItem)
    if LBISSettings.SelectedRank == LBIS.L["All"] then
        return true;
    elseif LBISSettings.SelectedRank == LBIS.L["BIS"] and specItem.Rank == 1 then
        return true;
    end
    return false;
end

local function hasAnyItems(list)
    for _, slotList in pairs(list) do
        for _, item in pairs(slotList) do
            if item.ItemId > 0 then
                return true;
            end
        end
    end
    return false;
end

function LBIS.CustomItemList:UpdateItems()

    LBIS.BrowserWindow.Window.SlotDropDown:Show();
    LBIS.BrowserWindow.Window.PhaseDropDown:Hide();
    LBIS.BrowserWindow.Window.RankDropDown:Show();
    LBIS.BrowserWindow.Window.SourceDropDown:Show();
    LBIS.BrowserWindow.Window.RaidDropDown:Show();

    LBIS.BrowserWindow:UpdateItemsForSpec(function(point)

        local selectedSpec = LBIS.NameToSpecId[LBISSettings.SelectedSpec];

        if selectedSpec == nil then
            return;
        end

        local customList = LBISServerSettings.CustomList[selectedSpec];
        if customList == nil or not hasAnyItems(customList) then
            LBIS.BrowserWindow.Window.ShowUnavailable("Custom List not available");
        end

        for slot, slotList in LBIS:spairs(customList, slotSortFunction) do
            local customRank = 0;
            for _, item in pairs(slotList) do
                customRank = customRank + 1;
                local specItem = { Id = item.ItemId, Slot = slot, Bis = item.TooltipText, Rank = customRank};

                local specItemSource = LBIS.ItemSources[item.ItemId];
                if specItemSource == nil then
                    specItemSource = { Name = "Not Available", SourceType = "Not Available", Zone = "Not Available", Source = "Not Available", SourceLocation = "Not Available", SourceNumber = "0" };
                end

                if LBIS:IsInSlot(specItem) and IsInRank(specItem) and LBIS:IsInSource(specItemSource) and LBIS:IsInZone(specItemSource) then
                    point = LBIS.BrowserWindow:CreateItemRow(specItem, specItemSource, "C_"..LBISSettings.SelectedSpec.."_"..specItemSource.Name.."_"..specItem.Id, point, LBIS.CreateItemRow);
                end
            end
        end
    end);
end