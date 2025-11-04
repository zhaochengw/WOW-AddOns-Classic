LBIS.ItemList = {};

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
itemSlotOrder[LBIS.L["Main Hand~Off Hand"]] = 14;
itemSlotOrder[LBIS.L["Ranged/Relic"]] = 15;

local function itemSortFunction(table, k1, k2)

    local item1 = table[k1];
    local item2 = table[k2];

    local item1Score = 0;
    local item2Score = 0;

    if itemSlotOrder[item1.Slot] > itemSlotOrder[item2.Slot] then
        item1Score = item1Score * -10000;
    end
    if itemSlotOrder[item1.Slot] < itemSlotOrder[item2.Slot] then
        item2Score = item2Score * -10000;
    end

    local _, lastNumber1 = LBIS:GetPhaseNumbers(item1.Phase)
    local _, lastNumber2 = LBIS:GetPhaseNumbers(item2.Phase)

    item1Score = item1Score + (lastNumber1 * -1000);
    item2Score = item2Score + (lastNumber2 * -1000);

    item1Score = item1Score + item1.SortOrder;
    item2Score = item2Score + item2.SortOrder;

    return item1Score < item2Score;
end

local function IsInFaction(specItemSource)

    local englishFaction, _ = UnitFactionGroup("PLAYER");

    if specItemSource.SourceFaction == "B" then
        return true;
    elseif englishFaction == "Alliance" and specItemSource.SourceFaction == "A" then
        return true;
    elseif englishFaction == "Horde" and specItemSource.SourceFaction == "H" then
        return true;
    end
    return false;
end

local function IsInPhase(specItem, specItemSource)
    if specItemSource.SourceType == LBIS.L["Token"] then
        return false;
    elseif strfind(specItem.Bis, LBIS.L["Transmute"]) ~= nil then
        return false;
    elseif LBISSettings.SelectedPhase == LBIS.L["All"] then --  and specItem.Phase ~= "0" then
        return true;
    elseif LBISSettings.SelectedPhase == LBIS.L["PrePatch"] and LBIS:FindInPhase(specItem.Phase, "99") then
        return true;
    elseif LBISSettings.SelectedPhase == LBIS.L["PreRaid"] and LBIS:FindInPhase(specItem.Phase, "0") then
        return true;
    elseif LBISSettings.SelectedPhase == LBIS.L["Phase 1"] and LBIS:FindInPhase(specItem.Phase, "1") then
        return true;
    elseif LBISSettings.SelectedPhase == LBIS.L["Phase 2"] and LBIS:FindInPhase(specItem.Phase, "2") then
        return true;
    elseif LBISSettings.SelectedPhase == LBIS.L["Phase 3"] and LBIS:FindInPhase(specItem.Phase, "3") then
        return true;
    elseif LBISSettings.SelectedPhase == LBIS.L["Phase 4"] and LBIS:FindInPhase(specItem.Phase, "4") then
        return true;
    elseif LBISSettings.SelectedPhase == LBIS.L["Phase 5"] and LBIS:FindInPhase(specItem.Phase, "5") then
        return true;
    elseif LBISSettings.SelectedPhase == LBIS.L["BIS"] and strfind(specItem.Bis, "BIS") ~= nil then
        return true;
    end
    return false;
end

local function IsNotInClassic(specItem)
    if specItem.SourceType == LBIS.L["Legacy"] then
        return false
    end
    return true;
end

local slotToWowCodes = {}
slotToWowCodes[LBIS.L["Head"]] = "HEADSLOT";
slotToWowCodes[LBIS.L["Shoulder"]] = "SHOULDERSLOT";
slotToWowCodes[LBIS.L["Back"]] = "BACKSLOT";
slotToWowCodes[LBIS.L["Chest"]] = "CHESTSLOT";
slotToWowCodes[LBIS.L["Wrist"]] = "WRISTSLOT";
slotToWowCodes[LBIS.L["Hands"]] = "HANDSSLOT";
slotToWowCodes[LBIS.L["Waist"]] = "WAISTSLOT";
slotToWowCodes[LBIS.L["Legs"]] = "LEGSSLOT";
slotToWowCodes[LBIS.L["Feet"]] = "FEETSLOT";
slotToWowCodes[LBIS.L["Neck"]] = "NECKSLOT";
slotToWowCodes[LBIS.L["Ring"]] = "FINGER0SLOT,FINGER1SLOT";
slotToWowCodes[LBIS.L["Trinket"]] = "TRINKET0SLOT,TRINKET1SLOT";
slotToWowCodes[LBIS.L["Main Hand"]] = "MAINHANDSLOT";
slotToWowCodes[LBIS.L["Off Hand"]] = "SECONDARYHANDSLOT";
local function IsNotObsolete(specItem)
    if LBISSettings.HideObsolete then

        local itemId1, itemId2 = -1, -1;

        if specItem.Slot == "Main Hand~Off Hand" then
            itemId1 = LBIS.UserSlotCache[slotToWowCodes["Main Hand"]];
            itemId2 = LBIS.UserSlotCache[slotToWowCodes["Off Hand"]];
        else
            local wowCodes = slotToWowCodes[specItem.Slot];
            local wowCode1, wowCode2 = strsplit(",", wowCodes);
            itemId1 = LBIS.UserSlotCache[wowCode1];
            if wowCode2 ~= nil then
                itemId2 = LBIS.UserSlotCache[wowCode2];
            end
        end

        local equippedPhase1 = "6";
        local equippedPhase2 = "6";
        if itemId1 ~= nil and tonumber(itemId1) > 0 then
            if LBIS.ItemsByIdAndSpec[tonumber(itemId1)] ~= nil then
                local cachedItem1 = LBIS.ItemsByIdAndSpec[tonumber(itemId1)][LBIS.NameToSpecId[LBISSettings.SelectedSpec]];
                if cachedItem1 ~= nil then
                    equippedPhase1 = cachedItem1.Phase;
                end
            end
        else
            --get lowest of other specs?
        end

        if itemId2 ~= nil and tonumber(itemId2) > 0 then    
            if LBIS.ItemsByIdAndSpec[tonumber(itemId2)] ~= nil then    
                local cachedItem2 = LBIS.ItemsByIdAndSpec[tonumber(itemId2)][LBIS.NameToSpecId[LBISSettings.SelectedSpec]];
                if cachedItem2 ~= nil then
                    equippedPhase2 = cachedItem2.Phase;
                end
            end
        else
            --get lowest of other specs?
        end

        local _, last1 = LBIS:GetPhaseNumbers(equippedPhase1);
        local _, last2 = LBIS:GetPhaseNumbers(equippedPhase2);
        local _, itemPhase = LBIS:GetPhaseNumbers(specItem.Phase);

        local lowestLast = last1;
        if tonumber(last2) < tonumber(lowestLast) then
            lowestLast = last2
        end

        if lowestLast == "6" then
            lowestLast = "-1"
        end

        if itemPhase ~= "P" and tonumber(itemPhase) < tonumber(lowestLast) then
            return false;
        end
    end
    return true;
end

function ToPrintableBoolean(boolValue)
    if boolValue then
        return "true";
    else
        return "false";
    end
end

function PrintDebugData(itemId, specItem, specItemSource)
    print("item("..itemId..")");
    print("-- IsInFaction("..ToPrintableBoolean(IsInFaction(specItemSource))..")");
    print("-- IsInSlot("..ToPrintableBoolean(LBIS:IsInSlot(specItem))..")");
    print("-- IsInPhase("..ToPrintableBoolean(IsInPhase(specItem, specItemSource))..")");
    print("-- IsInSource("..ToPrintableBoolean(LBIS:IsInSource(specItemSource))..")"); 
    print("-- IsInZone("..ToPrintableBoolean(LBIS:IsInZone(specItemSource))..")");
    print("-- IsNotInClassic("..ToPrintableBoolean(IsNotInClassic(specItemSource))..")");
    print("-- IsNotObsolete("..ToPrintableBoolean(IsNotObsolete(specItem))..")");
end

function LBIS.ItemList:UpdateItems()

    LBIS.BrowserWindow.Window.SlotDropDown:Show();
    LBIS.BrowserWindow.Window.PhaseDropDown:Show();
    LBIS.BrowserWindow.Window.RankDropDown:Hide();
    LBIS.BrowserWindow.Window.SourceDropDown:Show();
    LBIS.BrowserWindow.Window.RaidDropDown:Show();

    LBIS.BrowserWindow:UpdateItemsForSpec(function(point)

        local specItems = LBIS.ItemsBySpecAndId[LBIS.NameToSpecId[LBISSettings.SelectedSpec]];

        if specItems == nil then
            LBIS.BrowserWindow.Window.ShowUnavailable();
        end

        for itemId, specItem in LBIS:spairs(specItems, itemSortFunction) do
            local specItemSource = LBIS.ItemSources[specItem.Id];
            
			-- if itemId == 71289 then
                -- PrintDebugData(71289, specItem, specItemSource)
			-- end

            if specItemSource == nil then
                LBIS:Error("Missing item source: ", specItem);
            else
                if IsInFaction(specItemSource) and LBIS:IsInSlot(specItem) and IsInPhase(specItem, specItemSource) and LBIS:IsInSource(specItemSource) and LBIS:IsInZone(specItemSource) and IsNotInClassic(specItemSource) and IsNotObsolete(specItem) then
                    point = LBIS.BrowserWindow:CreateItemRow(specItem, specItemSource, LBISSettings.SelectedSpec.."_"..specItemSource.Name.."_"..specItem.Id, point, LBIS.CreateItemRow);
                end
            end
        end
    end);
end