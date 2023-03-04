LBIS.AutoComplete = {}

local function selectButton(buttonIndex)
    local ac = LBIS.AutoComplete;
    assert(buttonIndex == nil or buttonIndex >= 1 and buttonIndex <= ac.buttonCount,
           'Button index is out of bounds')

    local previousButton = ac.buttons[ac.selectedButtonIndex]
    local selectedButton = ac.buttons[buttonIndex]

    if previousButton ~= nil then
        previousButton:UnlockHighlight()
        previousButton:HideTooltip()
    end

    if selectedButton ~= nil then
        selectedButton:LockHighlight()
        selectedButton:ShowTooltip()
    end

    local oldButtonIndex = ac.selectedButtonIndex;
    ac.selectedButtonIndex = buttonIndex;

    local scrollValue = ac.Scrollbar:GetValue();
    if oldButtonIndex < buttonIndex then
        if ((buttonIndex+1) * 14) > (scrollValue + ac.Frame:GetHeight()) then
            ac.Scrollbar:SetValue(((buttonIndex+1) * 14) - ac.Frame:GetHeight());            
        end
    else
        if ((buttonIndex-1) * 14) < scrollValue then
            ac.Scrollbar:SetValue((buttonIndex-1) * 14);
        end
    end
end

local function isEmpty()
    return LBIS.AutoComplete.buttonCount == 0
end

local function selectItem(button)

    button:UnlockHighlight()
    local found = false;
    --TODO Check all items, not just items for that slot. (fucking double slot weapons :()
    for _, item in pairs(LBIS.SearchFrame.ItemList) do
        if item == button.ItemId then
            found = true;
        end
    end
    if not found then
        LBIS.AutoComplete.SelectFunc(button.ItemId);
        LBIS.AutoComplete.SearchBox:SetText("");
        LBIS.AutoComplete:Clear();
    end
end

local function createButton()
    local ac = LBIS.AutoComplete;
    local button = CreateFrame('Button', nil, ac.Content)

    button:SetSize(50, 14);
    button:SetNormalFontObject("GameFontNormal");
    button:SetHighlightFontObject("GameFontHighlight");
    button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight");

    if ac.buttonCount == 1 then
        button:SetPoint('TOPLEFT', 10, -10)
        button:SetPoint('TOPRIGHT', -10, -10)
    else
        local previousButton = ac.buttons[ac.buttonCount - 1]

        button:SetPoint('TOPLEFT', previousButton, 'BOTTOMLEFT')
        button:SetPoint('TOPRIGHT', previousButton, 'BOTTOMRIGHT')
    end
    
    button.Index = ac.buttonCount;

    button:SetScript("OnEnter", function (self) selectButton(self.Index); end)
    button:SetScript("OnClick", selectItem);

    button.ShowTooltip = function (self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        GameTooltip:SetItemByID(self.ItemId);
        GameTooltip:Show();
    end
      
    button.HideTooltip = function ()
        GameTooltip:Hide();
    end

    return button
end

function LBIS.AutoComplete:Clear()
    local ac = LBIS.AutoComplete;
    if isEmpty() then
      return
    end

    ac.buttons[ac.selectedButtonIndex]:HideTooltip()
    ac.selectedButtonIndex = 0;

    for i = 1, ac.buttonCount do
        ac.buttons[i]:Hide()
    end

    ac.buttonCount = 0;
    ac.Frame:SetHeight(ac.baseHeight);
    ac.Content:SetHeight(ac.baseHeight);
    ac.Frame:Hide();
end

function LBIS.AutoComplete:Add(item)
    local ac = LBIS.AutoComplete;
    ac.Frame:Show();
    ac.buttonCount = ac.buttonCount + 1

    if ac.buttons[ac.buttonCount] == nil then
      -- Create a new button frame if one does not exist
        ac.buttons[ac.buttonCount] = createButton()
    end
    
    local button = ac.buttons[ac.buttonCount]

    button.ItemId = item.Id;
    button:SetText(item.Link)
    button:Show();

    if ac.selectedButtonIndex == 0 then
        selectButton(1)
    end

    LBIS.AutoComplete.MaxHeight = ac.baseHeight + button:GetHeight() * ac.buttonCount;
    local height = 150;
    if LBIS.AutoComplete.MaxHeight > 150 then
        ac.Scrollbar:SetMinMaxValues(0, (LBIS.AutoComplete.MaxHeight-height));
    else
        ac.Scrollbar:SetMinMaxValues(0, 0);
        height = LBIS.AutoComplete.MaxHeight;
    end

    ac.Frame:SetHeight(height);
    ac.Content:SetHeight(height);
    ac.Frame:SetWidth(595);
    ac.Content:SetWidth(595);
end

local function getSelection()
    return LBIS.AutoComplete.buttons[LBIS.AutoComplete.selectedButtonIndex];
end

local function incrementSelection(decrement)
    if isEmpty() then
      return
    end

    local buttonIndex = LBIS.AutoComplete.selectedButtonIndex + (decrement and -1 or 1)

    if buttonIndex <= 0 then
      buttonIndex = LBIS.AutoComplete.buttonCount
    elseif buttonIndex > LBIS.AutoComplete.buttonCount then
      buttonIndex = 1
    end

    selectButton(buttonIndex);
end

function LBIS.AutoComplete:HandleKeyDown(key)
    local action = ({
        ['TAB'] = function()
          incrementSelection(IsShiftKeyDown())
        end,
        ['UP'] = function()
          incrementSelection(true)
        end,
        ['DOWN'] = function()
          incrementSelection(false)
        end,
        ['ESCAPE'] = function()
            LBIS.AutoComplete.buttons[LBIS.AutoComplete.selectedButtonIndex]:HideTooltip()
            LBIS.AutoComplete.Frame:Hide()
        end,
        ['ENTER'] = function()
          selectItem(getSelection())
        end,
      })[key]

      if action ~= nil then
        action()
      end
end

function LBIS.AutoComplete:Create(frame, selectFunc) 
    local scrollframe = CreateFrame("ScrollFrame", nil, frame, 'BackdropTemplate');
    local scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate");
    local content = CreateFrame("Frame", nil, scrollframe);
    
    scrollframe:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = 1,
        tileSize = 10,
        edgeSize = 10,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    });
    
    scrollframe:SetBackdropBorderColor(1, 1, 1)
    scrollframe:SetBackdropColor(0.09, 0.09,  0.19);
    scrollframe:EnableMouseWheel(true);

    local step = 25;
    scrollframe:ClearAllPoints();
    scrollframe:SetPoint('TOPLEFT', frame, 'BOTTOMLEFT', 0, 4);
    scrollbar:SetPoint("TOPRIGHT", scrollframe, "TOPRIGHT", -4, -18);
    scrollbar:SetPoint("BOTTOMRIGHT", scrollframe, "BOTTOMRIGHT", -4, 18);
    scrollbar:SetMinMaxValues(0,0);
    scrollbar:SetWidth(12);
    scrollbar:SetValue(0);
    scrollbar:SetValueStep(step);
    
    scrollbar:SetScript("OnValueChanged",
        function (self, value) 
            self:GetParent():SetVerticalScroll(value);
        end
    );

    local function UpdateScrollValue(self, delta)
        if not scrollbar:IsEnabled() then
            return;
        end
        if(delta == 1 and scrollbar:GetValue() >= 0) then
            if(scrollbar:GetValue()-step < 0) then
                scrollbar:SetValue(0);
            else scrollbar:SetValue(scrollbar:GetValue() - step) end
        elseif(delta == -1 and scrollbar:GetValue() < LBIS.AutoComplete.MaxHeight) then
            if(scrollbar:GetValue()+step > LBIS.AutoComplete.MaxHeight) then
                scrollbar:SetValue(LBIS.AutoComplete.MaxHeight);
            else scrollbar:SetValue(scrollbar:GetValue() + step) end
        end
    end

    scrollframe:EnableMouse(true);
    scrollframe:EnableMouseWheel(true);
    scrollframe:SetScript("OnMouseWheel", UpdateScrollValue);

    local acf = scrollframe:CreateFontString(nil, nil, "GameFontDisableSmall");
    acf:SetText("PRESS_TAB");
    acf:SetPoint("BOTTOMLEFT", 5, 5);

    scrollframe:SetScrollChild(content);

    LBIS.AutoComplete.selectedButtonIndex = 0
    LBIS.AutoComplete.buttonCount = 0
    LBIS.AutoComplete.buttons = {}
    LBIS.AutoComplete.buttonMargin = 30
    LBIS.AutoComplete.baseHeight = 40
    LBIS.AutoComplete.MaxHeight = 0;
    LBIS.AutoComplete.SelectFunc = selectFunc;
    LBIS.AutoComplete.Frame = scrollframe;
    LBIS.AutoComplete.Scrollbar = scrollbar;
    LBIS.AutoComplete.Content = content;
    LBIS.AutoComplete.SearchBox = frame;
end