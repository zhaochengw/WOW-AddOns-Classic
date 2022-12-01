LBIS.PriorityList = {};
LBIS.PriorityList.Items = {};

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
itemSlotOrder[LBIS.L["Two Hand"]] = 14;
itemSlotOrder[LBIS.L["Ranged/Relic"]] = 15;

local function itemSortFunction(table, k1, k2)

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

local function assignItemsToFrame(f, itemList)

    local itemCount = 1;
    local totalItems = getn(itemList);
    
    for orderId, itemId in pairs(itemList) do

        LBIS:GetItemInfo(itemId, function(item)

            if item == nil or item.Id == nil or item.Link == nil or item.Type == nil then
                LBIS:Error("Failed Load: "..itemId);
                failedLoad = true;
            end

            f.PriorityButtons[itemCount].ItemButton:SetNormalTexture(item.Texture);
            LBIS:SetTooltipOnButton(f.PriorityButtons[itemCount].ItemButton, item);
                        
            if itemCount == 1 then
                f.PriorityButtons[itemCount].LeftButton:Disable();
            else                
                f.PriorityButtons[itemCount].LeftButton:Enable();
            end

            if itemCount == totalItems then
                f.PriorityButtons[itemCount].RightButton:Disable();
            else                
                f.PriorityButtons[itemCount].RightButton:Enable();
            end

        end);

        f.PriorityButtons[itemCount]:ShowButtons();

        if LBIS.PriorityList.Items[itemId] == nil then
            LBIS.PriorityList.Items[itemId] = {};
        end

        LBIS.PriorityList.Items[itemId][LBIS.SpecToName[LBISSettings.SelectedSpec]] = itemCount;
        
        itemCount = itemCount + 1;
    end

    for i = itemCount,6 do     
        f.PriorityButtons[i]:HideButtons();
    end
end

local function createPriorityRow(f, slot, itemList)

    local t, et, editFrame, eb = nil, nil, nil, nil;
    local window = LBIS.BrowserWindow.Window;
            
    t = f:CreateFontString(nil, nil, "GameFontNormal");
    t:SetText(slot..":");
    t:SetPoint("LEFT", f, "LEFT", 10, 0);
        
    f.PriorityButtons = {};

    for i=1,6 do

        local b, bLeft, bRight, bDelete,  t2 = nil, nil, nil, nil, nil;
        b = CreateFrame("Button", nil, f);
        b:SetSize(32, 32);
        b:SetPoint("TOPLEFT", f, 50 + (i * 85), -5);
        b:Hide();

        bLeft = CreateFrame("Button", nil, f);
        bLeft:SetSize(12, 12);
        bLeft:SetNormalTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowleft.tga");
        bLeft:SetPushedTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowleft_down.tga");
        bLeft:SetDisabledTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowleft_dis.tga");
        bLeft:SetPoint("TOPLEFT", b, "TOPRIGHT", 2, 0);
        bLeft:SetScript("OnClick", 
            function(self, button)
                if button == "LeftButton" then
                    itemList[i], itemList[i-1] = itemList[i-1], itemList[i]                    
                    assignItemsToFrame(f, itemList);
                end
            end
        );
        bLeft:Hide();
                    
        bRight = CreateFrame("Button", nil, f);
        bRight:SetSize(12, 12);
        bRight:SetNormalTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowright.tga");
        bRight:SetPushedTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowright_down.tga")
        bRight:SetDisabledTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowright_dis.tga");
        bRight:SetPoint("TOPLEFT", bLeft, "BOTTOMLEFT", 0, 0);
        bRight:SetScript("OnClick", 
            function(self, button)
                if button == "LeftButton" then
                    itemList[i], itemList[i+1] = itemList[i+1], itemList[i]
                    assignItemsToFrame(f, itemList);
                end
            end
        );
        bRight:Hide();

        bDelete = CreateFrame("Button", nil, f);    
        bDelete:SetSize(12, 12);
        bDelete:SetNormalTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\delete.tga");
        bDelete:SetPushedTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\delete_down.tga")
        bDelete:SetPoint("TOPLEFT", bRight, "BOTTOMLEFT", 0, 0);
        bDelete:SetScript("OnClick", 
            function(self, button)
                if button == "LeftButton" then
                    f.AddButton:Enable();
                    local itemId = itemList[i];
                    table.remove(itemList, i);
                    LBIS.PriorityList.Items[itemId][LBIS.SpecToName[LBISSettings.SelectedSpec]] = nil;
                    assignItemsToFrame(f, itemList);
                end
            end
        );
        bDelete:Hide();
        
        t2 = f:CreateFontString(nil, nil, "GameFontNormal");
        t2:SetText(i..": ");
        t2:SetPoint("RIGHT", b, "LEFT", -5, 0);
        t2:Hide();

        f.PriorityButtons[i] = { ItemButton = b, LeftButton = bLeft, RightButton = bRight, 
        ShowButtons = function() 
            b:Show();bLeft:Show();bRight:Show();bDelete:Show();t2:Show();
        end,
        HideButtons = function()
            b:Hide();bLeft:Hide();bRight:Hide();bDelete:Hide();t2:Hide();
        end}
    end

    local function has_value (tab, val)
        for index, value in ipairs(tab) do
            -- We grab the first index of our sub-table instead
            if value[1] == val then
                return true
            end
        end

        return false
    end

    --TODO: Break out UI for searching for button
    --TODO: Reskin add button
    --TODO: Disable when list is full
    eb = CreateFrame("Button", nil, f);
    eb:SetPoint("RIGHT", f, "RIGHT", -10, 0)
    eb:SetSize(32, 32);
    eb:SetNormalTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\add.tga");
    eb:SetPushedTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\add_down.tga")
    eb:SetDisabledTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\add_dis.tga");
    eb:SetScript("OnClick", 
        function(self, button)
            if button == "LeftButton" then
                local editText = tonumber(editFrame:GetText());

                if editText ~= nil and getn(itemList) < 6 and not has_value(itemList, editText) then
                    table.insert(itemList, editText)
                    editFrame:SetText("");
                    assignItemsToFrame(f, itemList);
                end

                if getn(itemList) >= 6 then
                    self:Disable();
                end
            end
        end
    );

    if getn(itemList) >= 6 then
        eb:Disable();
    end

    f.AddButton = eb;
        
    editFrame = CreateFrame("EditBox", nil, f, "InputBoxTemplate");
    editFrame:SetPoint("RIGHT", eb, "LEFT", -10, 0)
    editFrame:SetWidth(60);
    editFrame:SetHeight(25);
    editFrame:SetMovable(false);
    editFrame:SetAutoFocus(false);
    editFrame:SetMaxLetters(6);
        
    et = f:CreateFontString(nil, nil, "GameFontNormal");
    et:SetText("Item Id");
    et:SetPoint("RIGHT", editFrame, "RIGHT", -10, 0);    

    assignItemsToFrame(f, itemList);

    return 46;

end

local defaultPriorityList = {
	[LBIS.L["Head"]] = {},
	[LBIS.L["Shoulder"]] = {},
	[LBIS.L["Back"]] = {},
	[LBIS.L["Chest"]] = {},
	[LBIS.L["Wrist"]] = {},
	[LBIS.L["Hands"]] = {},
	[LBIS.L["Waist"]] = {},
	[LBIS.L["Legs"]] = {},
	[LBIS.L["Feet"]] = {},
	[LBIS.L["Neck"]] = {},
	[LBIS.L["Ring"]] = {},
	[LBIS.L["Trinket"]] = {},
	[LBIS.L["Main Hand"]] = {},
	[LBIS.L["Off Hand"]] = {},
	[LBIS.L["Two Hand"]] = {},
	[LBIS.L["Ranged/Relic"]] = {}
};

function LBIS.PriorityList:UpdateItems()    

    LBIS.BrowserWindow.Window.SlotDropDown:Hide();
    LBIS.BrowserWindow.Window.PhaseDropDown:Hide();
    LBIS.BrowserWindow.Window.SourceDropDown:Hide();
    LBIS.BrowserWindow.Window.RaidDropDown:Hide();

    LBIS.BrowserWindow:UpdateItemsForSpec(function(point)
        
        local savedPriorityList = LBISPrioritySettings[LBIS.SpecToName[LBISSettings.SelectedSpec]];

        if savedPriorityList == nil then
            LBISPrioritySettings[LBIS.SpecToName[LBISSettings.SelectedSpec]] = defaultPriorityList;
            savedPriorityList = defaultPriorityList;
        end

        for slot, itemList in LBIS:spairs(savedPriorityList, itemSortFunction) do
            
            point = LBIS.BrowserWindow:CreateItemRow(slot, itemList, "Priority"..LBISSettings.SelectedSpec..slot, point, createPriorityRow);

        end

    end);
end