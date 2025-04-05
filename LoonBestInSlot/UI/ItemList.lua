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
itemSlotOrder[LBIS.L["Main Hand/Off Hand"]] = 14;
itemSlotOrder[LBIS.L["Two Hand"]] = 15;
itemSlotOrder[LBIS.L["Ranged/Relic"]] = 16;

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

local function printSource(itemId, specItemSource, dl)

    local text = "";

    local sourceText = specItemSource.Source;
    local sourceNumberText = specItemSource.SourceNumber;
    local sourceLocationText = specItemSource.SourceLocation;

    local sourceText1, sourceText2, sourceText3 = strsplit("/", sourceText);
    local sourceNumberText1, sourceNumberText2, sourceNumberText3 = strsplit("/", sourceNumberText);
    local sourceLocationText1, sourceLocationText2, sourceLocationText3 = strsplit("/", sourceLocationText);

    local function printSourceText(sourceText, sourceNumberText, sourceLocationText, firstRow)
        if not firstRow then
            text = text.."\n"
        end

        local sourceSplit = { strsplit("&", sourceText) };
        local sourceNumberSplit = { strsplit("&", sourceNumberText) };
               
		local first = false;
        for index, source in pairs(sourceSplit) do		
			if first then
				text = text.." & ";
			else
				first = true;
			end
            text = text..strtrim(source);
			if sourceNumberSplit[index] ~= nil then
				local trimNumber = strtrim(sourceNumberSplit[index]);
				if trimNumber ~= "" and trimNumber ~= "0" and trimNumber ~= "1" then
					text = text.." ("..trimNumber..")";
				end
			end
        end

        if sourceLocationText ~= nil and sourceLocationText ~= "" then
            text = text.." - "..sourceLocationText;
        end
    end

    if sourceText1 ~= nil and sourceText1 ~= "" then
        printSourceText(sourceText1, sourceNumberText1, sourceLocationText1, true);
    end

    if sourceText2 ~= nil and sourceText2 ~= "" then
        printSourceText(sourceText2, sourceNumberText2, sourceLocationText2, false);       	
    end

    if sourceText3 ~= nil and sourceText3 ~= "" then
		printSourceText(sourceText3, sourceNumberText3, sourceLocationText3, false);
    end
	
    dl:SetText(text);
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

local function IsInSlot(specItem)
    if LBISSettings.SelectedSlot == LBIS.L["All"] then
        return true;
    elseif strfind(specItem.Slot, LBISSettings.SelectedSlot) ~= nil then
        return true;
    end
    return false;
end

local function IsInPhase(specItem, specItemSource)
    if specItemSource.SourceType == LBIS.L["Token"] then
        return false;
    elseif strfind(specItem.Bis, LBIS.L["Transmute"]) ~= nil then
        return false;
    elseif LBISSettings.SelectedPhase == LBIS.L["All"] and specItem.Phase ~= "0" then
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
    elseif LBISSettings.SelectedPhase == LBIS.L["BIS"] and strfind(specItem.Bis, "BIS") ~= nil then
        return true;
    end
    return false;
end

local function IsInSource(specItem)
    if LBISSettings.SelectedSourceType == LBIS.L["All"] then
        return true;
    elseif strfind(specItem.SourceType, LBISSettings.SelectedSourceType) ~= nil then
        return true;
    end
    return false;
end

local function IsInZone(specItem)

    local zone, _ = gsub(gsub(specItem.SourceLocation, "%(25H%)", "(25)"), "%(10H%)", "(10)")

    if LBISSettings.SelectedZone == LBIS.L["All"] then
        return true;
    elseif strfind(zone, gsub(gsub(LBISSettings.SelectedZone, "%(", "%%%("), "%)", "%%%)")) ~= nil then
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
slotToWowCodes[LBIS.L["Two Hand"]] = "MAINHANDSLOT";
slotToWowCodes[LBIS.L["Ranged/Relic"]] = "RANGEDSLOT";
local function IsNotObsolete(specItem)
    if LBISSettings.HideObsolete then
        
        local itemId1, itemId2 = -1, -1;

        if specItem.Slot == "Main Hand/Off Hand" then
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

local function createSourceTypeText(specItemSource)

    local function getSourceColor(sourceType)
        if sourceType == LBIS.L["Profession"] then
            return "|cFF33ADFF";
        elseif sourceType == LBIS.L["Reputation"] then
            return "|cFF23E4C4";
        elseif sourceType == LBIS.L["Quest"] then
            return "|cFFFFEF27";
        elseif sourceType == LBIS.L["Dungeon Token"] then
            return "|cFFFF276D";
        elseif sourceType == LBIS.L["Vendor"] then
            return "|cFF43DC00";
        elseif sourceType == LBIS.L["PvP"] then
            return "|cFFE52AED";
        elseif sourceType == LBIS.L["Transmute"] then
            return "|cFFFC6A03";
        elseif sourceType == LBIS.L["Drop"] then
            return "|cFF7727FF";
        else
            return "|cFFFFFFFF";
        end
    end

    local sourceType1, sourceType2 = strsplit("/", specItemSource.SourceType)    

    --Create Drop Text
    local dtColor = getSourceColor(sourceType1);
    local text = dtColor..sourceType1;

    if sourceType2 ~= nil then
        dtColor = getSourceColor(sourceType2);
        text = text.."|cFFFFD100/"..dtColor..sourceType2;
    end
	return text;
end

local function createItemRow(f, specItem, specItemSource)
    
    LBIS:GetItemInfo(specItem.Id, function(item)
        local window = LBIS.BrowserWindow.Window;

        if item == nil or item.Id == nil or item.Link == nil or item.Type == nil then
            LBIS:Error("Failed Load: "..specItem.Id);
            failedLoad = true;
        end
        --Create Item Button and Text

        local b = CreateFrame("Button", nil, f);
        b:SetSize(32, 32);
        local bt = b:CreateTexture();
        bt:SetAllPoints();
        bt:SetTexture(item.Texture);
        b:SetPoint("TOPLEFT", f, 2, -5);

        LBIS:SetTooltipOnButton(b, item);

        local t = f:CreateFontString(nil, nil, "GameFontNormal");
        t:SetText((item.Link or item.Name):gsub("[%[%]]", ""));
        t:SetPoint("TOPLEFT", b, "TOPRIGHT", 2, -2);

        local type = item.Type;
        if item.Subtype and item.Type ~= item.Subtype then
            type = item.Type .. ", " .. item.Subtype;
        end
        type = type.. ", "..specItem.Slot;
        local st = f:CreateFontString(nil, nil,"GameFontNormalGraySmall");
        st:SetText(type);
        st:SetPoint("BOTTOMLEFT", b, "BOTTOMRIGHT", 2, 2);

        local pt = f:CreateFontString(nil, nil, "GameFontNormal");
        if specItem.Phase == "0" then
            pt:SetText("("..specItem.Bis..")");
        else
            pt:SetText("("..specItem.Bis.." "..string.gsub(specItem.Phase, "0", "PreRaid")..")");
        end
        pt:SetPoint("TOPLEFT", t, "TOPRIGHT", 4, 0);

		local d = f:CreateFontString(nil, nil, "GameFontNormal");
		d:SetText(createSourceTypeText(specItemSource));
		d:SetJustifyH("LEFT");
		d:SetWidth(window.ScrollFrame:GetWidth() / 2);
		d:SetPoint("TOPLEFT", (window.ScrollFrame:GetWidth() / 2), -5);

        local dl = f:CreateFontString(nil, nil, "GameFontNormalSmall");

        if specItemSource.SourceType == LBIS.L["Transmute"] then
        
            LBIS:GetItemInfo(tonumber(specItemSource.Source), function(transmuteItem)

                local tb = CreateFrame("Button", nil, f);
                tb:SetSize(32, 32);
                local bt = tb:CreateTexture();
                bt:SetAllPoints();
                bt:SetTexture(transmuteItem.Texture);
                tb:SetPoint("BOTTOMLEFT", dl, "BOTTOMRIGHT", 5, -2);
                LBIS:SetTooltipOnButton(tb, transmuteItem);
                                    
                local ft = f:CreateFontString(nil, nil, "GameFontNormalSmall")
                ft:SetText("From:");
                ft:SetPoint("TOPRIGHT", tb, "TOPLEFT", -3, -3);
            end);

            dl:SetText(specItemSource.SourceLocation);
            dl:SetPoint("TOPLEFT", d, "BOTTOMLEFT", 0, -5);
        elseif specItemSource.SourceType == LBIS.L["Profession"] and tonumber(specItemSource.SourceLocation) ~= nil then
            LBIS:GetSpellInfo(tonumber(specItemSource.SourceLocation), function(professionSpell)

                local tb = CreateFrame("Button", nil, f);
                tb:SetSize(32, 32);
                local bt = tb:CreateTexture();
                bt:SetAllPoints();
                bt:SetTexture(professionSpell.Texture);
                tb:SetPoint("BOTTOMLEFT", dl, "BOTTOMRIGHT", 5, -2);
                LBIS:SetTooltipOnButton(tb, professionSpell, true);
                
                dl:SetText(specItemSource.Source);
                dl:SetPoint("TOPLEFT", d, "BOTTOMLEFT", 0, -5);
            end);
        else
            printSource(specItem.Id, specItemSource, dl)
            dl:SetPoint("TOPLEFT", d, "BOTTOMLEFT", 0, -5);
        end      
        dl:SetJustifyH("LEFT");

        local userItemCache = LBIS.UserItems[item.Id];
        if userItemCache then
            local ot = f:CreateTexture(nil,"BACKGROUND")
            ot:SetSize(24, 24);
            if userItemCache == "player" then
                ot:SetTexture("Interface/AddOns/LoonBestInSlot/Icons/checkmark.tga")
            elseif userItemCache == "bag" then
                ot:SetTexture("Interface/AddOns/LoonBestInSlot/Icons/bag.tga")
            elseif userItemCache == "bank" then
                ot:SetTexture("Interface/AddOns/LoonBestInSlot/Icons/bank.tga")
            end
            ot:SetPoint("TOPRIGHT", -2, -6);
        end
    end);

    -- even if we are reusing, it may not be in the same order
    local _, count = string.gsub(specItemSource.Source, "/", "")
    if count > 1 then
        count = count - 1;
    else 
        count = 0;
    end
    return (46 + (count * 10));
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

            if specItemSource == nil then
                LBIS:Error("Missing item source: ", specItem);
            else
                if IsInFaction(specItemSource) and IsInSlot(specItem) and IsInPhase(specItem, specItemSource) and IsInSource(specItemSource) and IsInZone(specItemSource) and IsNotInClassic(specItemSource) and IsNotObsolete(specItem) then
                    point = LBIS.BrowserWindow:CreateItemRow(specItem, specItemSource, LBISSettings.SelectedSpec.."_"..specItemSource.Name.."_"..specItem.Id, point, createItemRow);
                end
            end
        end
    end);
end