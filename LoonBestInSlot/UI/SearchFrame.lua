LBIS.SearchFrame = {}
LBIS.SearchFrame.Slot = "";
LBIS.SearchFrame.ItemList = {};

local function conductSearch(text, foundFunc)

    local foundItems = {};
    for itemId, entry in pairs(LBISServerSettings.ItemCache) do
        if entry.Name:lower():match(string.gsub(text, " ", '.*'):lower()) then
            LBIS:GetItemInfo(itemId, function (item)
                if item and item.Slot and strfind(item.Slot, LBIS.SearchFrame.Slot) ~= nil then
                    table.insert(foundItems, item)
                end
            end);
        end
    end
    foundFunc(foundItems);
end

local debounceTimer = nil;
local function HandleTextChanged(editBox, isUserInput)

    if not isUserInput then
        return
    end

    if debounceTimer ~= nil then
        debounceTimer:Cancel();
    end
    debounceTimer = C_Timer.NewTimer(0.5, function() 
        LBIS.AutoComplete:Clear();
        local text = strtrim(editBox:GetText());
        if (#text > 3) then
            conductSearch(text, function (searchedItems)
                for _, item in pairs(searchedItems) do
                    LBIS.AutoComplete:Add(item);
                end
            end)
        end
    end)
      
end

local function showCustomList()
        
    local itemCount = 0;
    local totalItems = getn(LBIS.SearchFrame.ItemList);
    local f = LBIS.SearchFrame.Frame.ItemListFrame;
    LBIS.SearchFrame.Frame.SearchLabel:SetText("Search for items to add to "..LBIS.SearchFrame.Slot.." list:");

    for orderId, sItem in pairs(LBIS.SearchFrame.ItemList) do
        
        itemCount = itemCount + 1;

        if LBIS.CustomEditList.Items[sItem.ItemId] == nil then
            LBIS.CustomEditList.Items[sItem.ItemId] = {};
        end
        LBIS.CustomEditList.Items[sItem.ItemId][LBIS.NameToSpecId[LBISSettings.SelectedSpec]] = sItem;

        LBIS:GetItemInfo(sItem.ItemId, function(item)
            f.CustomButtons[itemCount].ItemButton:SetNormalTexture(item.Texture);
            LBIS:SetTooltipOnButton(f.CustomButtons[itemCount].ItemButton, item);

            f.CustomButtons[itemCount].ItemLink:SetText((item.Link or item.Name):gsub("[%[%]]", ""));

            local type = item.Type;
            if item.Subtype and item.Type ~= item.Subtype then
                type = item.Type .. ", " .. item.Subtype;
            end
            type = type.. ", "..LBIS.SearchFrame.Slot;
            f.CustomButtons[itemCount].ItemType:SetText(type);

            f.CustomButtons[itemCount].TooltipText:SetText(sItem.TooltipText);
            f.CustomButtons[itemCount].TooltipText:SetScript("OnTextChanged", function(editBox, isUserInput)
                sItem.TooltipText = editBox:GetText();
            end);
            f.CustomButtons[itemCount].TooltipText:SetScript("OnEscapePressed", function(self)
	            self:ClearFocus()
            end);
            f.CustomButtons[itemCount].TooltipText:SetScript("OnTabPressed", function(self)
	            self:ClearFocus()
            end);

            f.CustomButtons[itemCount].UpButton.CustomIndex = itemCount;
            f.CustomButtons[itemCount].UpButton:SetScript("OnClick", function(self, button)
                if button == "LeftButton" then
                    local swap = LBIS.SearchFrame.ItemList[self.CustomIndex]
                    LBIS.SearchFrame.ItemList[self.CustomIndex] = LBIS.SearchFrame.ItemList[self.CustomIndex-1]
                    LBIS.SearchFrame.ItemList[self.CustomIndex-1] = swap;
                    showCustomList();
                end
            end);
            f.CustomButtons[itemCount].DownButton.CustomIndex = itemCount;
            f.CustomButtons[itemCount].DownButton:SetScript("OnClick", function(self, button)
                if button == "LeftButton" then  
                    local swap = LBIS.SearchFrame.ItemList[self.CustomIndex]
                    LBIS.SearchFrame.ItemList[self.CustomIndex] = LBIS.SearchFrame.ItemList[self.CustomIndex+1]
                    LBIS.SearchFrame.ItemList[self.CustomIndex+1] = swap;
                    showCustomList();
                end
            end);
            f.CustomButtons[itemCount].DeleteButton.CustomIndex = itemCount;
            f.CustomButtons[itemCount].DeleteButton:SetScript("OnClick", function(self, button)
                if button == "LeftButton" then
                    table.remove(LBIS.SearchFrame.ItemList, self.CustomIndex);
                    LBIS.CustomEditList.Items[sItem.ItemId][LBIS.NameToSpecId[LBISSettings.SelectedSpec]] = nil;
                    showCustomList();
                end
            end);

            if itemCount == 1 then
                f.CustomButtons[itemCount].UpButton:Disable();
            else                
                f.CustomButtons[itemCount].UpButton:Enable();
            end

            if itemCount == totalItems then
                f.CustomButtons[itemCount].DownButton:Disable();
            else                
                f.CustomButtons[itemCount].DownButton:Enable();
            end

        end);

        f.CustomButtons[itemCount]:ShowButtons();
    end

    for i = itemCount+1,6 do
        f.CustomButtons[i]:HideButtons();
    end

    if totalItems >= 6 then
        LBIS.SearchFrame.Frame.SearchBox:Disable();
        LBIS.SearchFrame.Frame.SearchLabel:SetFontObject("GameFontDisable");
        LBIS.AutoComplete.Frame:Hide();
    else
        LBIS.SearchFrame.Frame.SearchBox:Enable();
        LBIS.SearchFrame.Frame.SearchLabel:SetFontObject("GameFontNormal");
        LBIS.AutoComplete.Frame:Show();
    end

end

local function createCustomList(f)

    local itemf = CreateFrame('Frame', nil, f, 'BackdropTemplate')

    itemf:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = 1,
            tileSize = 10,
            edgeSize = 10,
            insets = { left = 3, right = 3, top = 3, bottom = 3 },
          });

    itemf:SetBackdropBorderColor(1, 1, 1)
    itemf:SetBackdropColor(0.09, 0.09,  0.19);
    itemf:SetPoint('TOP', f, 'CENTER', 0, 75);
    itemf:SetSize(700, 300);
    itemf.CustomButtons = {};

    for i=1,6 do

        local b = CreateFrame("Button", nil, itemf);
        b:SetSize(32, 32);
        b:SetPoint("TOPLEFT", itemf, (math.floor((i-1) / 3) * 350) + 25, (math.fmod(i-1, 3) * -75) - 10);
        b:Hide();

        local il = itemf:CreateFontString(nil, nil, "GameFontNormal");
        il:SetPoint("TOPLEFT", b, "TOPRIGHT", 2, -2);
        il:Hide();

        local it = itemf:CreateFontString(nil, nil,"GameFontNormalGraySmall");
        it:SetPoint("BOTTOMLEFT", b, "BOTTOMRIGHT", 2, 2);
        it:Hide();

        local tl = itemf:CreateFontString(nil, nil, "GameFontNormalSmall");
        tl:SetText("Tooltip:");
        tl:SetPoint("TOPLEFT", b, "BOTTOMLEFT", 0, -5);
        tl:Hide();

        local tt = CreateFrame("EditBox", nil, itemf, "InputBoxTemplate");
        tt:SetPoint("LEFT", tl, "RIGHT", 5, 0);
        tt:SetFontObject(GameFontHighlightSmall)
        tt:SetSize(100, 20);
        tt:SetMovable(false);
        tt:SetAutoFocus(false);
        tt:SetMaxLetters(12);
        tt:Hide();

        local bDelete = CreateFrame("Button", nil, itemf);
        bDelete:SetSize(24, 24);
        bDelete:SetNormalTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\delete.tga");
        bDelete:SetPushedTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\delete_down.tga")
        bDelete:SetPoint("TOPLEFT", (math.floor((i+2) / 3) * 350) - 30, (math.fmod(i-1, 3) * -75) - 15);
        bDelete:Hide();

        local bDown = CreateFrame("Button", nil, itemf);
        bDown:SetSize(24, 24);
        bDown:SetNormalTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowdown.tga");
        bDown:SetPushedTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowdown_down.tga")
        bDown:SetDisabledTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowdown_dis.tga");
        bDown:SetPoint("TOPRIGHT", bDelete, "TOPLEFT", -2, 0);
        bDown:Hide();

        local bUp = CreateFrame("Button", nil, itemf);
        bUp:SetSize(24, 24);
        bUp:SetNormalTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowup.tga");
        bUp:SetPushedTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowup_down.tga");
        bUp:SetDisabledTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\arrowup_dis.tga");
        bUp:SetPoint("TOPRIGHT", bDown, "TOPLEFT", -2, 0);
        bUp:Hide();
        
        local t2 = itemf:CreateFontString(nil, nil, "GameFontNormal");
        t2:SetText(i..": ");
        t2:SetPoint("RIGHT", b, "LEFT", -5, 0);
        t2:Hide();

        itemf.CustomButtons[i] = { 
            ItemButton = b, ItemLink = il, ItemType = it, 
            UpButton = bUp, DownButton = bDown, DeleteButton = bDelete,
            TooltipText = tt,
            ShowButtons = function() 
                b:Show();il:Show();it:Show();bUp:Show();bDown:Show();bDelete:Show();t2:Show();tt:Show();tl:Show();
            end,
            HideButtons = function()
                b:Hide();il:Hide();it:Hide();bUp:Hide();bDown:Hide();bDelete:Hide();t2:Hide();tt:Hide();tl:Hide();
            end
        }
    end

    return itemf;
end

local function addNewItem(itemId)
    
    local listSize = getn(LBIS.SearchFrame.ItemList);
    listSize = listSize+1;
    table.insert(LBIS.SearchFrame.ItemList, { ItemId = itemId, TooltipText = "Custom #"..listSize })

    showCustomList();
end

local onCloseFunc = function() end
function LBIS.SearchFrame:HideSearchFrame()
    LBIS.BrowserWindow.Window.ScrollBar:Enable();
    LBIS.BrowserWindow.Window.Container:Show();
    LBIS.AutoComplete:Clear();
    onCloseFunc();
    LBIS.SearchFrame.Frame:Hide();
end

function LBIS.SearchFrame:ShowSearchFrame(slot, itemList, onClose)
    LBIS.BrowserWindow.Window.ScrollBar:Disable();
    LBIS.BrowserWindow.Window.Container:Hide();
    LBIS.SearchFrame.ItemList = itemList;
    LBIS.SearchFrame.Slot = slot;
    LBIS.SearchFrame.Frame.SearchBox:SetText("");
    LBIS.AutoComplete:Clear();
    showCustomList();
    onCloseFunc = onClose;
    LBIS.SearchFrame.Frame:Show();
end

function LBIS.SearchFrame:CreateSearch()

    local scrollframe = LBIS.BrowserWindow.Window.ScrollFrame;

    local f = CreateFrame("Frame", nil, scrollframe, "BackdropTemplate");
    f:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        tile = true
    });
    f:SetBackdropColor(.1, .1, .1, 1);
    f:SetSize(scrollframe:GetWidth(), scrollframe:GetHeight());
    f:ClearAllPoints();
    f:SetPoint("TOPLEFT", scrollframe, 0, 0);
    f:SetFrameStrata("DIALOG");
    f:Hide();

    local eb = CreateFrame("EditBox", nil, f, "InputBoxTemplate");
    eb:SetPoint("TOP", f, "TOP", 0, -20);
    eb:SetWidth(600);
    eb:SetHeight(25);
    eb:SetMovable(false);
    eb:SetAutoFocus(true);
    eb:SetScript("OnKeyDown", LBIS.AutoComplete.HandleKeyDown)
    eb:SetScript("OnTextChanged", HandleTextChanged)

    local fl = f:CreateFontString(nil, nil, "GameFontNormal");
    fl:SetPoint("BOTTOMLEFT", eb, "TOPLEFT", 0, 0);

    local cb = CreateFrame("Button", nil, f);
    cb:SetSize(25, 25);
    cb:SetNormalTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\close.tga");
    cb:SetPushedTexture("Interface\\AddOns\\LoonBestInSlot\\Icons\\close_down.tga")
    cb:SetPoint("TOPRIGHT", f, "TOPRIGHT", -5, -5);
    cb:SetScript("OnClick", 
        function(self, button)
            if button == "LeftButton" then
                LBIS.SearchFrame:HideSearchFrame()
            end
        end
    );

    LBIS.AutoComplete:Create(eb, addNewItem);
    
    local cf = createCustomList(f);
    
    LBIS.SearchFrame.Frame = f;
    LBIS.SearchFrame.Frame.ItemListFrame = cf;
    LBIS.SearchFrame.Frame.SearchLabel = fl;
    LBIS.SearchFrame.Frame.SearchBox = eb;

end