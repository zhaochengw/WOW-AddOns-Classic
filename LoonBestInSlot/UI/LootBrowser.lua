LBIS.BrowserWindow = {
    MaxHeight = 0,
    CompareTooltip = {},
    LastFeaturesOpenTime = time({year=2022, month=12, day=10, hour=22})
}

function LBIS.BrowserWindow:OpenWindow(tabName)
    LBIS:BuildItemCache()
    if not LBIS.BrowserWindow.Window then
        LBIS.BrowserWindow:CreateBrowserWindow();
    end
    if tabName ~= nil then
        LBISSettings.OpenTab = tabName;
    end
    LBIS.BrowserWindow:RefreshItems();
    LBIS.BrowserWindow.Window:Show();

    --If cache date is updated (because of cache changing) reset the cache
    if (not LBISServerSettings.LastFeaturesWindowDate or LBISServerSettings.LastFeaturesWindowDate < LBIS.BrowserWindow.LastFeaturesOpenTime) then
        LBIS.NewFeaturesWindow:CreateAndShowWindow();
        LBISServerSettings.LastFeaturesWindowDate = time();
    end
    
end

function LBIS.BrowserWindow:ToggleWindow()
    if LBIS.BrowserWindow.Window and LBIS.BrowserWindow.Window:IsShown() then
        LBIS.BrowserWindow.Window:Hide();
    else
        LBIS.BrowserWindow:OpenWindow();
    end
end

local customListTabButton;
local customEditTabButton;
function LBIS.BrowserWindow:RefreshItems()    

    if LBISSettings.ShowCustom then
        customListTabButton:Show()
        customEditTabButton:Show()
    else
        customListTabButton:Hide()
        customEditTabButton:Hide()
    end

    if LBISSettings.OpenTab == "ItemList" then
        PanelTemplates_SetTab(LBIS.BrowserWindow.Window.Container, 1);
        LBIS.ItemList:UpdateItems();
    elseif LBISSettings.OpenTab == "GemList" then
        PanelTemplates_SetTab(LBIS.BrowserWindow.Window.Container, 2);
        LBIS.GemList:UpdateItems();
    elseif LBISSettings.OpenTab == "EnchantList" then
        PanelTemplates_SetTab(LBIS.BrowserWindow.Window.Container, 3);
        LBIS.EnchantList:UpdateItems();        
    elseif LBISSettings.OpenTab == "CustomItemList" then
        PanelTemplates_SetTab(LBIS.BrowserWindow.Window.Container, 4);
        LBIS.CustomItemList:UpdateItems();
    elseif LBISSettings.OpenTab == "CustomEditList" then
        PanelTemplates_SetTab(LBIS.BrowserWindow.Window.Container, 5);
        LBIS.CustomEditList:UpdateItems();
    end
end

local failedLoad = false;
local deleted_windows = {};
function LBIS.BrowserWindow:CreateItemRow(specItem, specItemSource, frameName, point, rowFunc)
    local window = LBIS.BrowserWindow.Window;
    local spacing = 1;
    local reusing = false;
    
    local f = nil;
    --TODO: MAKE THIS FASTER WHEN THERES TONS OF FRAMES !
    -- attempting to reuse a previous child frame if it exists 
    -- (which should include the previously created fontstring and button)
    if(next(deleted_windows) ~= nil) then
        for i=1, #deleted_windows do
            if(frameName == deleted_windows[i]:GetName()) then
                f = deleted_windows[i];
                reusing = true;
            end
        end
    end
    
    if not reusing then        
        f = CreateFrame("Frame", name, window.Container);

        local rowHeight = rowFunc(f, specItem, specItemSource);
        
        local l = f:CreateLine();
        l:SetColorTexture(1,1,1,0.5);
        l:SetThickness(1);
        l:SetStartPoint("BOTTOMLEFT",5, 0);
        l:SetEndPoint("BOTTOMRIGHT",-5, 0);
        f:SetSize(window.ScrollFrame:GetWidth(), rowHeight);
    end

    f:ClearAllPoints();
    f:SetPoint("TOPLEFT", window.Container, 0, point);
    
    point = point - (f:GetHeight()+spacing);
    
    LBIS.BrowserWindow.MaxHeight = LBIS.BrowserWindow.MaxHeight + (f:GetHeight()+spacing);

    f:Show(); -- forcing a show since if we are reusing, the old child was previously hidden

    return point;
end

function LBIS.BrowserWindow:UpdateItemsForSpec(rowFunc)
            
    if LBISSettings.SelectedSpec == "" then
        return;
    end
    
    LBIS.SearchFrame:HideSearchFrame();
    LBIS.BrowserWindow.Window.HideUnavailable();

    local window = LBIS.BrowserWindow.Window;
    local point = -2;
    local function clear_content(self)
        for i=1, self:GetNumChildren() do
        
            local child = select(i, self:GetChildren());
            
            -- Saving a reference to our previous child frame so that we can reuse it later
            if(not tContains(deleted_windows, child)) then 
                tinsert(deleted_windows, child);
            end
            
            child:Hide();
        end
    end

    clear_content(window.Container);
    
    LBIS.BrowserWindow.MaxHeight = 0;
    
    local topl = window.Container:CreateLine();
    topl:SetColorTexture(1,1,1,0.5);
    topl:SetThickness(1);
    topl:SetStartPoint("TOPLEFT",5, 0);
    topl:SetEndPoint("TOPRIGHT",-5, 0);
    
    failedLoad = false;

    rowFunc(point);

    if failedLoad then
        LBIS:Error("Failed to load one or more items into browser. Type /reload to attempt to fix", "");
    end

    window.Container:SetSize(window.ScrollFrame:GetWidth(), window.ScrollFrame:GetHeight());

    if LBIS.BrowserWindow.MaxHeight-window.ScrollFrame:GetHeight() > 0 then
        window.ScrollBar:SetMinMaxValues(0, (LBIS.BrowserWindow.MaxHeight-window.ScrollFrame:GetHeight()));
        window.ScrollBar:Enable();
    else
        window.ScrollBar:SetMinMaxValues(0, 0);
        window.ScrollBar:Disable();
    end
    window.ScrollFrame:SetScrollChild(window.Container);
end

local function createTabs(window, content) 

    local itemListTabButton = CreateFrame("Button", "ContainerTab1", window, "CharacterFrameTabButtonTemplate")
    local itemListTabString = itemListTabButton:CreateFontString("ItemListTabText", "OVERLAY", "GameFontNormalSmall");
    itemListTabString:SetPoint("CENTER", itemListTabButton, "CENTER", 0, 3);
    itemListTabString:SetText(LBIS.L["Items"]);
    itemListTabButton:SetPoint("CENTER", window, "BOTTOMLEFT", 60, -13);
    itemListTabButton:SetScript("OnClick", function(self)
        PanelTemplates_SetTab(content, 1);
        LBISSettings.OpenTab = "ItemList";

        LBIS.BrowserWindow:RefreshItems();
    end);

    local gemListTabButton = CreateFrame("Button", "ContainerTab2", window, "CharacterFrameTabButtonTemplate")
    local gemListTabString = gemListTabButton:CreateFontString("GemListTabText", "OVERLAY", "GameFontNormalSmall");
    gemListTabString:SetPoint("CENTER", gemListTabButton, "CENTER",  0, 3);
    gemListTabString:SetText(LBIS.L["Gems"]);
    gemListTabButton:SetPoint("LEFT", itemListTabButton, "RIGHT", -16, 0);
    gemListTabButton:SetScript("OnClick", function(self)
        PanelTemplates_SetTab(content, 2);
        LBISSettings.OpenTab = "GemList";

        LBIS.BrowserWindow:RefreshItems();
    end);

    local enchantListTabButton = CreateFrame("Button", "ContainerTab3", window, "CharacterFrameTabButtonTemplate")
    local enchantListTabString = enchantListTabButton:CreateFontString("EnchantListTabText", "OVERLAY", "GameFontNormalSmall");
    enchantListTabString:SetPoint("CENTER", enchantListTabButton, "CENTER", 0, 3);
    enchantListTabString:SetText(LBIS.L["Enchants"]);
    enchantListTabButton:SetPoint("LEFT", gemListTabButton, "RIGHT", -16, 0);
    enchantListTabButton:SetScript("OnClick", function(self)
        PanelTemplates_SetTab(content, 3);
        LBISSettings.OpenTab = "EnchantList";

        LBIS.BrowserWindow:RefreshItems();
    end);


    customListTabButton = CreateFrame("Button", "ContainerTab4", window, "CharacterFrameTabButtonTemplate")
    local customListTabString = customListTabButton:CreateFontString("CustomListTabText", "OVERLAY", "GameFontNormalSmall");
    customListTabString:SetPoint("CENTER", customListTabButton, "CENTER", 0, 3);
    customListTabString:SetText(LBIS.L["Custom"]);
    customListTabButton:SetPoint("LEFT", enchantListTabButton, "RIGHT", -16, 0);
    customListTabButton:SetScript("OnClick", function(self)
        PanelTemplates_SetTab(content, 4);
        LBISSettings.OpenTab = "CustomItemList";

        LBIS.BrowserWindow:RefreshItems();
    end);

    customEditTabButton = CreateFrame("Button", "ContainerTab5", window, "CharacterFrameTabButtonTemplate")
    local customEditTabString = customEditTabButton:CreateFontString("CustomEditTabText", "OVERLAY", "GameFontNormalSmall");
    customEditTabString:SetPoint("CENTER", customEditTabButton, "CENTER", 0, 3);
    customEditTabString:SetText(LBIS.L["Edit"]);
    customEditTabButton:SetPoint("LEFT", customListTabButton, "RIGHT", -16, 0);
    customEditTabButton:SetScript("OnClick", function(self)
        PanelTemplates_SetTab(content, 5);
        LBISSettings.OpenTab = "CustomEditList";
    
        LBIS.BrowserWindow:RefreshItems();
    end);

    PanelTemplates_SetNumTabs(content, 5);
    PanelTemplates_SetTab(content, 1);
end

local function createDropDowns(window)
    local getSpecList = function()
        local specList = {};
        for specId, spec in pairs(LBIS.ClassSpec) do

            local specString = spec.Class;
            if strlen(spec.Spec) > 0 then
                specString = specString..": "..spec.Spec;
            end
            table.insert(specList, specString)
            LBIS.NameToSpecId[specString] = specId;
        end
        table.sort(specList);
        return specList;
    end
    
    local spec_opts = {
        ['name']='spec',
        ['parent']=window,
        ['title']='Spec:',
        ['items']= getSpecList(),
        ['defaultVal']=LBISSettings.SelectedSpec,
        ['changeFunc']=function(dropdown_frame, dropdown_val)
            LBISSettings.SelectedSpec = dropdown_val;
            LBIS.BrowserWindow:RefreshItems();
        end
    }
    window.SpecDropDown = LBIS:CreateDropdown(spec_opts, 140);
    window.SpecDropDown:SetPoint("TOPLEFT", window, 15, -28);

    local slot_opts = {
        ['name']='slot',
        ['parent']=window,
        ['title']='Slot:',
        ['items']= { LBIS.L["All"], LBIS.L["Head"], LBIS.L["Shoulder"], LBIS.L["Back"], LBIS.L["Chest"], LBIS.L["Wrist"], 
            LBIS.L["Hands"], LBIS.L["Waist"], LBIS.L["Legs"], LBIS.L["Feet"], LBIS.L["Neck"], LBIS.L["Ring"], LBIS.L["Trinket"], 
            LBIS.L["Main Hand"], LBIS.L["Off Hand"], LBIS.L["Two Hand"], LBIS.L["Ranged/Relic"] },        
        ['defaultVal']=LBISSettings.SelectedSlot,
        ['changeFunc']=function(dropdown_frame, dropdown_val)
            LBISSettings.SelectedSlot = dropdown_val;
            LBIS.BrowserWindow:RefreshItems()
        end
    }
    window.SlotDropDown = LBIS:CreateDropdown(slot_opts, 90);
    window.SlotDropDown:SetPoint("TOPLEFT", window, 195, -28);

    local phase_opts = {
        ['name']='phase',
        ['parent']=window,
        ['title']='Phase:',
        ['items']= { LBIS.L["All"], LBIS.L["PreRaid"], LBIS.L["Phase 1"], LBIS.L["Phase 2"], "BIS" }, --, LBIS.L["Phase 3"], LBIS.L["Phase 4"], LBIS.L["Phase 5"],
        ['defaultVal']=LBISSettings.SelectedPhase,
        ['changeFunc']=function(dropdown_frame, dropdown_val)
            LBISSettings.SelectedPhase = dropdown_val;
            LBIS.BrowserWindow:RefreshItems();
        end
    }
    window.PhaseDropDown = LBIS:CreateDropdown(phase_opts, 70);
    window.PhaseDropDown:SetPoint("TOPLEFT", window, 330, -28);

    local rank_opts = {
        ['name']='rank',
        ['parent']=window,
        ['title']='Rank:',
        ['items']= { LBIS.L["All"], "BIS" },
        ['defaultVal']=LBISSettings.SelectedRank,
        ['changeFunc']=function(dropdown_frame, dropdown_val)
            LBISSettings.SelectedRank = dropdown_val;
            LBIS.BrowserWindow:RefreshItems();
        end
    }
    window.RankDropDown = LBIS:CreateDropdown(rank_opts, 70);
    window.RankDropDown:SetPoint("TOPLEFT", window, 330, -28);

    local source_opts = {
        ['name']='source',
        ['parent']=window,
        ['title']='Source:',
        ['items']= { LBIS.L["All"], LBIS.L["Drop"], LBIS.L["Profession"], LBIS.L["Reputation"], LBIS.L["Dungeon Token"], LBIS.L["Vendor"], LBIS.L["Quest"], LBIS.L["PvP"] },
        ['defaultVal']= LBISSettings.SelectedSourceType,
        ['changeFunc']=function(dropdown_frame, dropdown_val)
            LBISSettings.SelectedSourceType = dropdown_val;
            LBIS.BrowserWindow:RefreshItems();
        end
    }
    window.SourceDropDown = LBIS:CreateDropdown(source_opts, 110);
    window.SourceDropDown:SetPoint("TOPLEFT", window, 450, -28);

    local zone_opts = {
        ['name']='zone',
        ['parent']=window,
        ['title']='Raid:',
        ['items']= { LBIS.L["All"], LBIS.L["Naxxramas"], LBIS.L["The Eye of Eternity"], LBIS.L["The Obsidian Sanctum"], LBIS.L["Vault of Archavon (10)"], 
            LBIS.L["Vault of Archavon (25)"], LBIS.L["Ulduar (10)"], LBIS.L["Ulduar (25)"]},
            --LBIS.L["Trial of the Crusader (10)"], LBIS.L["Trial of the Crusader (25)"], LBIS.L["Onyxia's Lair (10)"], LBIS.L["Onyxia's Lair (25)"], 
            --LBIS.L["Icecrown Citadel (10)"], LBIS.L["Icecrown Citadel (25)"],
            --LBIS.L["The Ruby Sanctum (10)"], LBIS.L["The Ruby Sanctum (25)"]},
        ['defaultVal']= LBISSettings.SelectedZone,
        ['changeFunc']=function(dropdown_frame, dropdown_val)
            LBISSettings.SelectedZone = dropdown_val;
            LBIS.BrowserWindow:RefreshItems();
        end
    }
    window.RaidDropDown = LBIS:CreateDropdown(zone_opts, 160);
    window.RaidDropDown:SetPoint("TOPLEFT", window, 600, -28);

end

function LBIS.BrowserWindow:CreateBrowserWindow()
    local step = 25;
    local windowName = "LootBrowserWindow";
    local window = CreateFrame("Frame", windowName, UIParent, "BackdropTemplate");

    window:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = 1,
        tileSize = 10,
        edgeSize = 10,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    });

    window:SetBackdropBorderColor(1, 1, 1)
    window:SetBackdropColor(0.09, 0.09,  0.19);

    local windowCloseButton = CreateFrame("Button", windowName.."CloseButton", window)
    windowCloseButton:SetPoint("TOPRIGHT", window, "TOPRIGHT", 0, 0)
    windowCloseButton:SetSize(32, 32);
    windowCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up");
    windowCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
    windowCloseButton:SetScript("OnClick", function(self)
        window:Hide();
    end);
    local windowFeatureButton = CreateFrame("Button", "NewFeaturesWindowCloseButton", window)
    windowFeatureButton:SetPoint("TOPLEFT", window, "TOPLEFT", 2, 0)
    windowFeatureButton:SetSize(32, 32);
    windowFeatureButton:SetNormalTexture("Interface\\Buttons\\UI-LinkProfession-Up");
    windowFeatureButton:SetPushedTexture("Interface\\Buttons\\UI-LinkProfession-Down")
    windowFeatureButton:SetScript("OnClick", function(self)
        LBIS.NewFeaturesWindow:CreateAndShowWindow();
    end);
    
    local scrollframe = CreateFrame("ScrollFrame", "ScrollFrame", window);
    local scrollbar = CreateFrame("Slider", "ScrollBar", scrollframe, "UIPanelScrollBarTemplate");
    local content = CreateFrame("Frame", "Container", scrollframe);
    
	tinsert(UISpecialFrames, windowName)	-- allow ESC close

    local function UpdateScrollValue(self, delta)
        if not scrollbar:IsEnabled() then
            return;
        end
        if(delta == 1 and scrollbar:GetValue() >= 0) then
            if(scrollbar:GetValue()-step < 0) then
                scrollbar:SetValue(0);
            else scrollbar:SetValue(scrollbar:GetValue() - step) end
        elseif(delta == -1 and scrollbar:GetValue() < LBIS.BrowserWindow.MaxHeight) then
            if(scrollbar:GetValue()+step > LBIS.BrowserWindow.MaxHeight) then
                scrollbar:SetValue(LBIS.BrowserWindow.MaxHeight);
            else scrollbar:SetValue(scrollbar:GetValue() + step) end
        end
    end

    --parent frame 
    window:SetSize(800, 600);
    window:SetPoint("CENTER", 0, 0);
    window:SetToplevel(true);
    window:SetMovable(true);
    window:EnableMouse(true);
    window:EnableMouseWheel(true);
    window:SetFrameStrata("HIGH");

    window:RegisterForDrag("LeftButton");

    local header = window:CreateFontString(nil, nil, "GameFontHighlightMed2");
    header:SetText(LBIS.L["Loon Best In Slot Browser"]);
    header:SetPoint("TOP", window, -5, -5);

    local topLine = window:CreateLine();
    topLine:SetColorTexture(1,1,1,0.5);
    topLine:SetThickness(2);
    topLine:SetStartPoint("TOPLEFT",10, -59);
    topLine:SetEndPoint("TOPRIGHT",-25, -59);

    scrollframe:SetPoint("TOPLEFT", 10, -60);
    scrollframe:SetPoint("BOTTOMRIGHT", -25, 10);
    
    scrollframe:EnableMouse(true);
    scrollframe:EnableMouseWheel(true);
    scrollframe:SetScript("OnMouseWheel", UpdateScrollValue);

    scrollbar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 4, -12);
    scrollbar:SetPoint("BOTTOMLEFT", scrollframe, "BOTTOMRIGHT", 4, 10);
    scrollbar:SetMinMaxValues(0,0);
    scrollbar:SetWidth(16);
    scrollbar:SetValue(0);
    scrollbar:SetValueStep(step);

    scrollbar:SetScript("OnValueChanged",
        function (self, value) 
            self:GetParent():SetVerticalScroll(value);
        end
    );

    window:SetScript("OnDragStart", function(self) self:StartMoving() end);
    window:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);

    createDropDowns(window);
    createTabs(window, content);

    local f = CreateFrame("Frame", nil, content);				
	f.t = f:CreateFontString(nil, nil, "GameFontNormal");
	f.t:SetText("Wowhead Guide not available");
	f.t:SetPoint("CENTER");				
	f:SetSize(scrollframe:GetWidth(), scrollframe:GetHeight());
	f:ClearAllPoints();
	f:SetPoint("TOPLEFT", content, 0, 0);
    f:Hide();

    local function showUnavailable(text)
        if text == nil then
            text = "Wowhead Guide not available";
        end
        f.t:SetText(text);
        f:Show();
    end

    LBIS.BrowserWindow.Window = window;
    LBIS.BrowserWindow.Window.ScrollFrame = scrollframe;
    LBIS.BrowserWindow.Window.ScrollBar = scrollbar;
    LBIS.BrowserWindow.Window.Container = content;
    LBIS.BrowserWindow.Window.ShowUnavailable = showUnavailable;
    LBIS.BrowserWindow.Window.HideUnavailable = function () f:Hide() end;

    LBIS.SearchFrame:CreateSearch();

    LBIS:RegisterTooltip();

end
