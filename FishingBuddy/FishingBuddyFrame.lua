local _

local LFH = LibStub("LibTabbedFrame-1.0");
local LO = LibStub("LibOptionsFrame-1.0");
local LS = LibStub("LibSideTabFrame-1.0");

local FBFRAMES = {
    [1] = {
        ["frame"] = "FishingOptionsFrame",
        ["name"] = FBConstants.OPTIONS_TAB,
        ["tooltip"] = FBConstants.OPTIONS_INFO,
        ["toggle"] = "_OPT",
        ["ultimate"] = 1,
    }
};

local ManagedFrames = {};
local function DisableSubFrame(target)
    FishingBuddyFrame:DisableSubFrame(target);
end
FishingBuddy.DisableSubFrame = DisableSubFrame;

local function EnableSubFrame(target)
    FishingBuddyFrame:EnableSubFrame(target);
end
FishingBuddy.EnableSubFrame = EnableSubFrame;

local function ManageFrame(target, tabname, tooltip, toggle)
    FishingBuddyFrame:ManageFrame(target, tabname, tooltip, toggle);
end
FishingBuddy.ManageFrame = ManageFrame;

local function Group_OnClick(tabframe, tabname)
    for idx,group in ipairs(tabframe.target.groups) do
        if group.name == tabname then
            group.frame:Show()
        else
            group.frame:Hide()
        end
    end
end

local function ShowFrameGroup(self)
    self:HandleOnShow(self:GetSelected());
    local tabframe = self:GetSelected();
    for _,group in ipairs(self.groups) do
        if tabframe == group.frame.tabframe then
            group.frame:Show()
        end
    end
end

local function HideFrameGroup(self)
    self:HideTabs();
    for _,group in ipairs(self.groups) do
        group.frame:Hide()
    end
end

local function CreateManagedOptionsTab(target, tabname, groups, optiontab)
    local tabframe = _G["Options"..tabname];
    if (not tabframe) then
        tabframe = CreateFrame("Frame", "Options"..tabname, target);
        FishingBuddy.EmbeddedOptions(tabframe)
        tabframe:SetScript("OnShow", function (self)
            self:ShowButtons();
        end)
        tinsert(groups, {
            ["name"] = optiontab.name,
            ["icon"] = optiontab.icon,
            ["frame"] = tabframe
        })
        optiontab.last = true
        tabframe.options = optiontab
        tabframe.ontabclick = Group_OnClick
        target.handoff = tabframe
    end
    FishingBuddy.OptionsFrame.HandleOptions(optiontab.name, optiontab.icon, optiontab.options, optiontab.setter, optiontab.getter, optiontab.last, target)
end
FishingBuddy.CreateManagedOptionsTab = CreateManagedOptionsTab;

local function CreateManagedFrameGroup(tabname, tooltip, toggle, groups, optiontab)
    local target = _G["Managed"..tabname];
    if not target then
        target = FishingBuddyFrame:CreateManagedFrame("Managed"..tabname, tabname, tooltip, toggle);
        LS:Embed(target)
        target:SetScript("OnShow", ShowFrameGroup);
        target:SetScript("OnHide", HideFrameGroup);
        target.groups = groups
        for idx,group in ipairs(groups) do
            local tabframe = target:CreateTab(group.name, group.icon, Group_OnClick, group.tooltip or group.name);
            group.frame, _ = target:GetFrameInfo(group.frame)
            group.frame.tabframe = tabframe;
            group.frame:SetParent(target);
            group.frame:SetAllPoints();
            group.frame:Hide();
        end
    else
        -- Add new groups to the target.
        for idx,group in ipairs(groups) do
            local tabframe = target:CreateTab(group.name, group.icon, Group_OnClick, group.tooltip or group.name);
            group.frame, _ = target:GetFrameInfo(group.frame)
            group.frame:Hide()
            tinsert(target.groups, group)
        end

    end

    if (optiontab) then
        CreateManagedOptionsTab(target, tabname, groups, optiontab)
    end

    target:ResetTabFrames();
    target:SelectTab(target:GetSelected());
    return target
end
FishingBuddy.CreateManagedFrameGroup = CreateManagedFrameGroup;

function ToggleFishingBuddyFrame(target)
    FishingBuddyFrame:ToggleTab(target);
end

local function OnVariablesLoaded(self, _, ...)
    -- set up mappings
    for idx,info in pairs(FBFRAMES) do
        local tf = FishingBuddyFrame:MakeFrameTab(info.frame, info.name, info.tooltip, info.toggle);
        if ( info.first) then
            FishingBuddyFrame:MakePrimary(info.frame);
        elseif ( info.ultimate ) then
            FishingBuddyFrame:MakeUltimate(info.frame);
        end
    end
end

local function OnShow()
    FishingBuddy.RunHandlers(FBConstants.FRAME_SHOW_EVT);
end

FishingBuddyFrame = LFH:CreateFrameHandler("FishingBuddyFrame",
            "Interface\\LootFrame\\FishingLoot-Icon", FBConstants.WINDOW_TITLE, "FISHINGBUDDY",
            OnShow, nil, OnVariablesLoaded);
FishingBuddyFrame:Show();
FishingBuddyFrame:Hide();
