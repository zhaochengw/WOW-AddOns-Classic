-- Handle all the option settings

local FL = LibStub("LibFishing-1.0");
local LO = LibStub("LibOptionsFrame-1.0");
local LS = LibStub("LibSideTabFrame-1.0");

-- 5.0.4 has a problem with a global "_" (see some for loops below)
local _

local FBOptionsTable = {};

local function FindOptionInfo (setting)
    for _,info in pairs(FBOptionsTable) do
        if ( info.options and info.options[setting] ) then
            return info;
        end
    end
    -- return nil;
end

local function GetSettingOption(setting)
    if ( setting ) then
        local info = FindOptionInfo(setting);
        if info and info.options then
            return info.options[setting];
        end
    end
    -- return nil;
end
FishingBuddy.GetSettingOption = GetSettingOption;

local function GetDefault(setting)
    local opt = GetSettingOption(setting);
    if ( opt ) then
        if ( opt.check and opt.checkfail ) then
            if ( not opt.check() ) then
                return opt.checkfail;
            end
        end
        return opt.default;
    end
    -- return nil;
end
FishingBuddy.GetDefault = GetDefault;

local function OptionGetSetting(setting)
    local info = GetSettingOption(setting)
    local val = nil
    if info then
        if ( info.global ) then
            val = FishingBuddy.GlobalGetSetting(setting);
        else
            val = FishingBuddy.BaseGetSetting(setting);
        end
    end
    return val
end
FishingBuddy.OptionGetSetting = OptionGetSetting

local function GetSetting(setting)
    local val = nil;
    if ( setting ) then
        local info = FindOptionInfo(setting);
        if ( info ) then
            if ( info.getter) then
                val = info.getter(setting);
                if ( val == nil ) then
                    val = GetDefault(setting);
                end
            else
                val = OptionGetSetting(setting)
            end
        end
    end
    return val;
end
FishingBuddy.GetSetting = GetSetting;

local function GetSettingBool(setting)
    local val = GetSetting(setting);
    return val ~= nil and (val == true or val == 1);
end
FishingBuddy.GetSettingBool = GetSettingBool;

local function OptionSetSetting(setting, value)
    local info = GetSettingOption(setting)
    if info then
        if ( info.global ) then
            FishingBuddy.GlobalSetSetting(setting, value);
        else
            FishingBuddy.BaseSetSetting(setting, value);
        end
    end
end
FishingBuddy.OptionSetSetting = OptionSetSetting

local function SetSetting(setting, value)
    if ( setting ) then
        local info = FindOptionInfo(setting);
        if ( info) then
            if ( info.setter ) then
                local val = GetDefault(setting);
                if ( val == value ) then
                    info.setter(setting, nil);
                else
                    info.setter(setting, value);
                end
            else
                OptionSetSetting(setting, value)
            end
        end
    end
end
FishingBuddy.SetSetting = SetSetting;

local function ActiveSetting(setting)
    local info = GetSettingOption(setting);
    if info then
        local active = GetSettingBool(setting);
        if info.active then
            return info.active(info, setting, active);
        end
        return active;
    end
    -- Let's pretend we're good, even if we don't have the setting
    return true
end
FishingBuddy.ActiveSetting = ActiveSetting;

-- tooltip support for disabled buttons
local function Handle_OnEnter(self)
    if(self.tooltipText ~= nil) then
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 48, 0);
        FL:AddTooltip(self.tooltipText);
        GameTooltip:Show();
    end
end

local function Handle_OnLeave(self)
    if(self.tooltipText ~= nil) then
        GameTooltip:Hide();
    end
end

-- display all the option settings
FishingBuddy.OptionsFrame = {};

local function CheckButton_OnShow(button)
    button:SetChecked(GetSettingBool(button.name));
end

local function CheckButton_OnClick(button, quiet)
    if ( not button ) then
        return;
    end
    local value = true;
    if ( button.checkbox ) then
        if ( not button:GetChecked() ) then
            value = false;
        end
        if ( not quiet ) then
            if ( value ) then
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
            else
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
            end
        end
    end
    SetSetting(button.name, value);
    FishingBuddy.OptionsUpdate();
    if ( button.update ) then
        button.update(button);
    end
    FishingOptionsFrame:HandleDeps(button);
end

-- handle option panel tabs
local tabbuttons = {};
local tabmap = {};

local function Handle_TabClick(tabframe, tabname)
    local target;
    if tabframe.target.handoff then
        target = tabframe.target.handoff
    else
        target = tabframe.target
    end
    if target.ontabclick then
        target.ontabclick(tabframe, tabname)
    end
    FishingBuddy.OptionsUpdate();
    target:LayoutOptions(FBOptionsTable[tabname].options);
    target:ShowButtons();
end
FishingBuddy.Handle_OptionsTabClick = Handle_TabClick

local INV_MISC_QUESTIONMARK = "Interface\\Icons\\INV_Misc_QuestionMark";
local function ProcessOptions(name, icon, options, setter, getter, last, frame)
    local index = #tabbuttons + 1;
    local handler = {};
    local maketab = true;
    if ( not frame ) then
        frame = FishingOptionsFrame
    end

    if ( not name ) then
        name = "FBHIDDEN";
        handler.index = 0;
        -- handle option buttons that show up outside of option frames
        for name,option in pairs(options) do
            local button = FL:GetFrameInfo(option.button)
            if (option.init) then
                option.init(option, button);
            end
            if ( option.setup ) then
                option.setup(button);
            end
        end
        maketab = false;
    elseif ( name == GENERAL ) then
        handler.first = true;
        handler.icon = "Interface\\Icons\\inv_gauntlets_18";
    else
        handler.icon = icon or INV_MISC_QUESTIONMARK;
    end

    handler.last = last;
    handler.name = name;
    handler.options = FL:copytable(options);
    handler.setter = setter;
    handler.getter = getter;
    handler.visible = maketab;
    if ( FBOptionsTable[name] ) then
        for name,info in pairs(FBOptionsTable[name].options) do
            handler.options[name] = FL:copytable(info);
        end
        handler.icon = FBOptionsTable[name].icon;
        handler.index = FBOptionsTable[name].index;
        handler.getter = handler.getter or FBOptionsTable[name].getter;
        handler.setter = handler.setter or FBOptionsTable[name].setter;
    end
    FBOptionsTable[name] = handler;

    -- just handle the setting and getting if no name supplied
    if ( maketab ) then
        local optiontab = tabmap[name];
        if ( not optiontab ) then
            optiontab = frame:CreateTab(name, handler.icon, Handle_TabClick, name);
            tinsert(tabbuttons, optiontab);
            tabmap[name] = optiontab;
            handler.index = index;
        end

        -- if we show this one, then check to see if it has
        -- any options for the drop down menu
        for name,option in pairs(handler.options) do
            if ( option.m ) then
                handler.hasdd = true;
            end
        end

        if (handler.first) then
            frame:MakePrimary(optiontab);
        elseif (handler.last) then
            frame:MakeUltimate(optiontab);
        end
    end
end

local _delayedframe = nil;
local _delayedoptions = nil;
local function HandleOptions(name, icon, options, setter, getter, last, frame)
    if (not frame) then
        frame = FishingOptionsFrame;
    end
    if (not _delayedoptions) then
        _delayedoptions = {};
        if (not _delayedframe) then
            _delayedframe = CreateFrame("Frame");
            _delayedframe:SetScript("OnUpdate",
                function()
                    if (_delayedoptions) then
                        for _,rec in ipairs(_delayedoptions) do
                            ProcessOptions(rec.name, rec.icon, rec.options, rec.setter, rec.getter, rec.last, rec.frame);
                        end
                        _delayedoptions = nil;
                        FishingBuddy.OptionsUpdate(true, false)
                    end
                    _delayedframe:Hide();
                end);
        end
        _delayedframe:Show();
    end
    tinsert(_delayedoptions, { name = name, icon = icon, options = options, setter = setter, getter = getter, last = last, frame = frame } );
end
FishingBuddy.OptionsFrame.HandleOptions = HandleOptions;

local function HideOptionsTab(name)
    if ( FBOptionsTable[name] and FBOptionsTable[name].visible ) then
        FBOptionsTable[name].visible = nil;
    end
end
FishingBuddy.HideOptionsTab = HideOptionsTab;

local function ShowOptionsTab(name)
    if ( FBOptionsTable[name] and not FBOptionsTable[name].visible ) then
        FBOptionsTable[name].visible = true;
    end
end
FishingBuddy.ShowOptionsTab = ShowOptionsTab;

local function OptionsFrame_OnShow(self)
    local selected = self.selected;
    local first = nil;
    for name,handler in pairs(FBOptionsTable) do
        if ( handler.visible ) then
            if ( not first or handler.first ) then
                first = name;
            end
        else
            if ( selected == name ) then
                selected = nil;
            end
        end
    end
    if ( not selected and first ) then
        selected = first;
    end
    self:HandleOnShow(selected);
    self:ShowButtons();
end

-- Drop-down menu support
local function ToggleSetting(setting)
    local value = GetSetting(setting);
    if ( not value ) then
        value = false;
    end
    SetSetting(setting, not value);
    FishingBuddy.OptionsUpdate(true);
end
FishingBuddy.ToggleSetting = ToggleSetting;

-- save some memory by keeping one copy of each one
local ToggleFunctions = {};
-- let's use closures
local function MakeToggle(name, callme)
    if ( not ToggleFunctions[name] ) then
        local n = name;
        local c = callme;
        ToggleFunctions[name] = function() ToggleSetting(n); if (c) then c() end; end;
    end
    return ToggleFunctions[name];
end
FishingBuddy.MakeToggle = MakeToggle;

local function MakeClickToSwitchEntry(switchText, switchSetting, level, keepShowing, callMe)
    local entry = {};
    entry.text = switchText;
    entry.func = MakeToggle(switchSetting, callMe);
    entry.checked = FishingBuddy.GetSettingBool(switchSetting);
    entry.keepShownOnClick = keepShowing;
    UIDropDownMenu_AddButton(entry, level);
end

local function MakeDropDownSep(level)
    local entry = {};
    entry.disabled = true;
    UIDropDownMenu_AddButton(entry, level);
end

local function MakeDropDownEntry(name, option, level)
    local addthis = true;
    if ( option.check ) then
        addthis = option.check();
    end
    if ( addthis ) then
        local entry = {};
        entry.text = option.text;
        entry.func = MakeToggle(name);
        entry.checked = FishingBuddy.GetSettingBool(name);
        entry.keepShownOnClick = true;
        UIDropDownMenu_AddButton(entry, level);
    end
end

local function MakeDropDownInitialize(self, level)
    if ( level == 1) then
        local entry = {};
        if ( self.title ) then
            entry.isTitle = 1;
            entry.text = self.title;
            entry.notCheckable = 1;
            UIDropDownMenu_AddButton(entry, level);
        end

        -- If no outfit frame, we can't switch outfits...
        if ( FishingBuddy.OutfitManager.HasManager() ) then
            MakeClickToSwitchEntry(self.switchText, self.switchSetting, level, 1);
            MakeDropDownSep(level);
        end

        wipe(entry);
        for tabname,handler in pairs(FBOptionsTable) do
            if (handler.hasdd) then
                entry.text = tabname;
                entry.func = self.UncheckHack;
                entry.hasArrow = 1;
                entry.value = handler.options;
                UIDropDownMenu_AddButton(entry, level);
            end
        end
    elseif (level == 2 and type(UIDROPDOWNMENU_MENU_VALUE) == "table") then
        for name,option in pairs(UIDROPDOWNMENU_MENU_VALUE) do
            if ( option.m1 ) then
                MakeDropDownEntry(name, option, level);
            end
        end
        for name,option in pairs(UIDROPDOWNMENU_MENU_VALUE) do
            if ( option.m ) then
                MakeDropDownEntry(name, option, level);
            end
        end
    end
end
FishingBuddy.DropDownInitFunc = MakeDropDownInitialize;

local FB_DropDownMenu = CreateFrame("Frame", "FB_DropDownMenu");
local function UncheckHack(dropdownbutton)
    _G[dropdownbutton:GetName().."Check"]:Hide()
end

FishingBuddy.GetDropDown = function(switchText, switchSetting, title, frame)
    if (not frame) then
        frame = FB_DropDownMenu;
        frame.displayMode = "MENU"
    end

    frame.title = title or FBConstants.NAME;
    frame.switchText = switchText;
    frame.switchSetting = switchSetting;
    frame.initialize = MakeDropDownInitialize;
    frame.UncheckHack = UncheckHack;

    return frame;
end

-- Old style drop down handling, which will add taint
-- Everything happens at level 1
FishingBuddy.MakeDropDown = function(switchText, switchSetting)
    -- If no outfit frame, we can't switch outfits...
    if ( FishingBuddy.OutfitManager.HasManager() ) then
        MakeClickToSwitchEntry(switchText, switchSetting, 1, 1);
        MakeDropDownSep(1);
    end

    for _,info in pairs(FBOptionsTable) do
        for name,option in pairs(info.options) do
            if ( option.p ) then
                MakeDropDownEntry(name, option);
            end
        end
    end
end

local function CreateLabeledThing(holdername, label, thing, thingname)
    local holder = CreateFrame("Frame", holdername);
    thingname = thingname or 'thing';
    holder[thingname] = thing;

    thing:ClearAllPoints();
    thing:SetParent(holder)
    thing:SetPoint("TOPRIGHT", holder, "TOPRIGHT", 0, -4);
    thing.label:ClearAllPoints();
    thing.label:SetParent(holder)
    local offset = thing.label:GetHeight() - thing:GetHeight();
    thing.label:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, 0)

    function holder:FixSizes()
        self:SetWidth(thing:GetWidth() + thing.label:GetWidth() + (holder.width_adjust or 8));
        self:SetHeight(thing:GetHeight() + (holder.height_adjust or 8));
        local offset = (thing.label:GetHeight() - thing:GetHeight())/2;
        thing.label:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, offset - 4)
    end

    function holder:SetLabel(text)
        if (text) then
            thing.label:Show();
            thing.label:SetText(text);
        else
            thing.label:SetText("");
            thing.label:Hide();
        end
        self:FixSizes();
    end

    return holder;
end
FishingBuddy.CreateLabeledThing = CreateLabeledThing

-- menuname has to be set regardless, or UI drop down doesn't work
FishingBuddy.CreateFBDropDownMenu = function(holdername, menuname)
    if (not menuname) then
        menuname = holdername.."Menu"
    end
    local menu = CreateFrame("Frame", menuname, nil, "FishingBuddyDropDownMenuTemplate");
    local holder = CreateLabeledThing(holdername, '', menu, 'menu')
    menu:SetParent(holder)
    holder.width_adjust = -12;
    holder.html = CreateFrame("SimpleHTML", nil, holder);
    holder.html:ClearAllPoints();
    holder.html:SetAllPoints(holder);
    holder.fontstring = holder.html:CreateFontString(nil, nil, "GameFontNormalSmall");
    holder.fontstring:SetAllPoints(holder.html);
    holder:FixSizes();

    return holder;
end

-- handle menu with a mapping table for settings to displayed values
local function SetMappedValue(self, what, value)
    local show = self.Mapping[value];
    FishingBuddy.SetSetting(what, value);
    UIDropDownMenu_SetSelectedValue(self, show);
    UIDropDownMenu_SetText(self, show);
    FishingBuddy.OptionsUpdate();
end

local function LoadMappedMenu(keymenu)
    local menu = keymenu.menu;
    local menuwidth = 0;
    local setting = FishingBuddy.GetSetting(keymenu.Setting);
    for value,label in pairs(menu.Mapping) do
        local info = {};
        local v = value;
        local w = keymenu.Setting;
        local m = menu;
        info.text = label;
        info.func = function() SetMappedValue(m, w, v); end;
        if ( setting == value ) then
            info.checked = true;
        else
            info.checked = false;
        end
        UIDropDownMenu_AddButton(info);
        menu.label:SetText(label);
        local width = menu.label:GetWidth();
        if (width > menuwidth) then
            menuwidth = width;
        end
    end
    UIDropDownMenu_SetWidth(menu, menuwidth + 32);
    keymenu:SetLabel(keymenu.Label);
end

local function InitMappedMenu(option, button)
    UIDropDownMenu_Initialize(button.menu, function()
                                      LoadMappedMenu(button);
                                  end);
end

FishingBuddy.CreateFBMappedDropDown = function(holdername, setting, label, mapping, menuname)
    local keymenu = FishingBuddy.CreateFBDropDownMenu(holdername, menuname);
    keymenu.html:Hide();
    keymenu.menu.label:SetText(label);
    keymenu.Label = label;
    keymenu.Setting = setting;
    keymenu.Build = BuildMappedMenu
    keymenu.menu.Mapping = mapping;
    keymenu.menu.SetMappedValue = SetMappedValue;
    keymenu.InitMappedMenu = InitMappedMenu;
    keymenu:FixSizes()
    return keymenu;
end

FishingBuddy.GetOptionList = function()
    local options = {};
    for _,info in pairs(FBOptionsTable) do
        for name,option in pairs(info.options) do
            options[name] = option;
        end
    end
    return options;
end

-- Helper function
FishingBuddy.FitInOptionFrame = function(width)
    return FishingOptionsFrame:FitInFrame(width);
end

FishingBuddy.EmbeddedOptions = function(frame)
    frame.GetSettingBool = FishingBuddy.GetSettingBool
    LO:Embed(frame, CheckButton_OnClick, CheckButton_OnShow, FishingBuddyFrameInset);
end

-- Create the options frame, unmanaged -- we get managed specially later
local f = FishingBuddyFrame:CreateManagedFrame("FishingOptionsFrame");

FishingBuddy.EmbeddedOptions(f);
LS:Embed(f);

f:SetScript("OnShow", OptionsFrame_OnShow);
f:SetScript("OnHide", function (self) self:HideTabs(); end);

