--[[
	Offers functionality for the auction house, needed by Vendor.
	This includes the addition of new tabs and specifying the 
	tab to be selected when opening the auction house frame.

	Copyright (C) Udorn (Blackhand)

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]

vendor.AuctionHouse = vendor.Vendor:NewModule("AuctionHouse", "AceEvent-3.0", "AceHook-3.0")
vendor.AuctionHouse:SetEnabledState(true)

local L = vendor.Locale.GetInstance()
local self = vendor.AuctionHouse
local log = vendor.Debug:new("AuctionHouse")
local AUCTIONHOUSE_VERSION = 2
local BLINK_INTERVAL = 1.5

vendor.AuctionHouse.ACTION_BID = 1
vendor.AuctionHouse.ACTION_SELL = 2
vendor.AuctionHouse.ACTION_CANCEL = 3

local START_TABS = {
    [L["Browse"]] = 1,
    [L["Bids"]] = 2,
    [L["Auctions"]] = 3,
    [L["AuctionMaster"]] = 4,
    [L["Sell"]] = 4,
    [L["Scanner"]] = 5,
}

--[[
	Migrates the database.
--]]
local function _MigrateDb(self)
    if (not self.db.profile.version or self.db.profile.version < AUCTIONHOUSE_VERSION) then
        self.db.profile.startTab = START_TABS[self.db.profile.startTab] or 1
    end
    self.db.profile.version = AUCTIONHOUSE_VERSION
end

-- Fix for buggy GetTradeSkillReagentItemLink. Found here: http://www.wowace.com/addons/lil-sparkys-workshop/tickets/100-fix-for-get-trade-skill-reagent-item-link-issue-in/
local function FixedGetTradeSkillReagentItemLink(self, i, j)
    local tooltip = self.bugfixTooltip
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:ClearLines()
    tooltip:SetTradeSkillItem(i, j)
    local _, reagentLink = tooltip:GetItem()
    return reagentLink
end

local function _StopWait(self)
    log:Debug("stop waiting")
    self.waiters = wipe(self.waiters)
end

--[[
	Toggles the position of the AuctionMaster button.
--]]
local function _ToggleButtonPosition(but, arg1, arg2, initPos)
    log:Debug("_ToggleButtonPosition initPos: %s", initPos)
    local self = arg1
    self.but:ClearAllPoints()
    if (not initPos) then
        log:Debug("toggle pos")
        self.db.profile.amButtonPos = math.fmod(self.db.profile.amButtonPos + 1, 2)
    end
    log:Debug("pos: %s", self.db.profile.amButtonPos)
    if (self.db.profile.amButtonPos == 0) then
        log:Debug("right")
        self.but:SetPoint("TOPRIGHT", AuctionFrame, "TOPRIGHT", -21, -13);
        self.isLeftPos = false
    else
        log:Debug("left")
        self.but:SetPoint("TOPLEFT", AuctionFrame, "TOPLEFT", 67, -13);
        self.isLeftPos = true
    end
end

--[[
	Sets the given value in the profile.
--]]
local function _SetValue(info, value, key)
    log:Debug("_SetValue value: %s key: %s", value, key)
    self.db.profile[key or info.arg] = value
end

--[[
	Returns the given value from the profile.
--]]
local function _GetValue(info, key)
    log:Debug("_GetValue key: %s", key)
    return self.db.profile[key or info.arg]
end

-- describe the commands contained in the main menu
local CMDS = {
    scan = {
        type = "execute",
        text = L["Scan"],
        func = function() vendor.AuctionHouse:SelectTab(vendor.SearchTab.id) end,
        order = 1
    },
    --	snipe = {
    --		type = "execute",
    --		text = L["Snipe"],
    --		func = function() vendor.Scanner:SnipeItem() end,
    --		order = 3
    --	},
    conf = {
        type = "execute",
        text = L["Configuration"],
        func = function()
            vendor.Config:ToggleConfigDialog()
        end,
        order = 4
    },
    help = {
        type = "execute",
        text = L["Help"],
        func = function() vendor.Help:Show(vendor.Help.DOCUMENTATION) end,
        order = 5
    },
    togglePos = {
        type = "execute",
        text = L["Toggle position"],
        func = _ToggleButtonPosition,
        arg = vendor.AuctionHouse,
        arg1 = vendor.AuctionHouse,
        order = 20
    },
    toggleBlizzardAuctionsTab = {
        type = "execute",
        text = L["Toggle blizzard auctions tab"],
        func = function() vendor.AuctionHouse:ToggleBlizzardAuctionsTab() end,
        order = 21
    },
}

--[[
	Called for the tab button.
--]]
local function _TabOnClick(self, id)
    log:Debug("TabOnClick enter id: " .. id);
    self.typeId = id
    -- hide all custom tabs
    --self.buttonFrame:Show()
    self.but:Show()
    local unknownTab = false
    for _, frame in pairs(self.frames) do
        frame:HideTabFrame();
    end
    -- hide our auctions tab (performance)
    if (id ~= 3 or self.db.profile.showBlizzardAuctionsTab) then
        log:Debug("Hide own auctions tab")
        vendor.OwnAuctions:Hide()
    end
    if (self.frames[id] and not (id == 3 and self.db.profile.showBlizzardAuctionsTab)) then
        -- blizzard's' frames, set tab and play sound
        PanelTemplates_SetTab(AuctionFrame, id);
        AuctionFrame.type = self.frames[id]:GetTabType();

        AuctionFrameAuctions:Hide();
        AuctionFrameBrowse:Hide();
        AuctionFrameBid:Hide();
        PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB);
        self.frames[id]:UpdateTabFrame();
        self.frames[id]:ShowTabFrame();
    elseif (id > 3) then
        unknownTab = true
        --self.buttonFrame:Hide()
        self.but:Hide()
    end
    if (id == 3) then
        -- there is a bug in blizzard's code: they don't set the tab for "owner"
        self.type = "owner"
        if (not self.db.profile.showBlizzardAuctionsTab) then
            log:Debug("Show own auctions")
            vendor.OwnAuctions:Show()
        end
    elseif (unknownTab) then
        self.type = "???"
    else
        self.type = AuctionFrame.type
    end
    log:Debug("set to type: " .. self.type)
end

--[[
	Create the main menu dropdown.
--]]
local function _CreateButton(self)
    local but = CreateFrame("Button", nil, AuctionFrame, "UIPanelButtonTemplate")
    but:SetText(L["AuctionMaster"])
    but:SetWidth(120)
    but:SetHeight(22)
    self.but = but;
    _ToggleButtonPosition(nil, self, nil, true)
    but.ctrl = self
    but:SetScript("OnClick", function(but) but.ctrl.mainMenu:Show() end)
end

--[[
	Returns the frame for the given tab number
--]]
local function _GetTabFrame(self, id)
    log:Debug("_GetTabFrame enter")
    if (self.frames[id] and not (id == 3 and self.db.profile.showBlizzardAuctionsTab)) then
        return self.frames[id]
    end
    log:Debug("_GetTabFrame global")
    return getglobal("AuctionFrameTab" .. id)
end

--[[
	The portrait button has been clicked.
--]]
local function _OnClick(self, button)
    log:Debug("_OnClick button: %s", button)
    if (button == "LeftButton") then
        if (vendor.Scanner:IsScanning()) then
            vendor.Scanner:StopScan()
        else
            vendor.Scanner:Scan()
        end
    elseif (button == "RightButton") then
        self:SelectTab(vendor.SearchTab:GetTabId())
    end
end

--[[
	Update the portrait for blinking effect.
--]]
local function _OnUpdate(self, diff)
    local doBlink = vendor.Scanner:IsScanning()
    if (doBlink) then
        -- OnLeave will reset it, so we do it each time
        self.logoTexture:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\portrait_orange_highlight")
        if (not self.blinkTime) then
            self.blinkTime = 0.0
        end
        self.blinkTime = self.blinkTime + diff
        -- the blinking is a like a triangle with twice the blinking interval as "length"
        local tri = math.fmod(self.blinkTime, BLINK_INTERVAL * 2.0)
        -- the shorter the diff from BLINK_INTERVAL, the more transparent the portrait will be
        local diff = math.abs(tri - BLINK_INTERVAL)
        -- finally get a value between 0 and 1
        self.logoTexture:SetAlpha(diff / BLINK_INTERVAL)
    else
        if (self.blinkTime) then
            log:Debug("_OnUpdate set normal texture")
            self.logoTexture:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\portrait_orange")
        end
        self.blinkTime = nil
        self.logoTexture:SetAlpha(1)
    end
end

--[[
	Creates the AuctionMaster texture.
--]]
local function _CreateAuctionMasterLogo(self)
    log:Debug("_CreateAuctionMasterLogo enter")
    self.logo = CreateFrame("Button", "VendorLogo", AuctionFrame)
    self.logo:SetWidth(55)
    self.logo:SetHeight(55)
    self.logo:SetPoint("TOPLEFT", 10, -8)
    self.logo:SetToplevel(true)
    self.logo.ctrl = self
    self.logo:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    self.logo:SetScript("OnClick", function(frame, button) _OnClick(frame.ctrl, button) end)

    self.logo.tooltipText = L["Left click for starting/stopping scan.\nRight click for opening the scan window."]

    self.logoBackground = self.logo:CreateTexture("VendorLogoBackground", "BACKGROUND")
    self.logoBackground:SetWidth(55)
    self.logoBackground:SetHeight(55)
    self.logoBackground:SetTexCoord(0, 1, 0, 1)
    self.logoBackground:SetPoint("TOPLEFT", 0, 0)
    self.logoBackground:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\portrait_orange_dark")

    self.logoTexture = self.logo:CreateTexture("VendorLogoTexture", "ARTWORK")
    self.logoTexture:SetWidth(55)
    self.logoTexture:SetHeight(55)
    self.logoTexture:SetTexCoord(0, 1, 0, 1)
    self.logoTexture:SetPoint("TOPLEFT", 0, 0)
    self.logoTexture:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\portrait_orange")

    self.logoLetters = self.logo:CreateTexture("VendorLogoLetters", "OVERLAY")
    self.logoLetters:SetWidth(55)
    self.logoLetters:SetHeight(55)
    self.logoLetters:SetTexCoord(0, 1, 0, 1)
    self.logoLetters:SetPoint("TOPLEFT", 1, 2)
    self.logoLetters:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\letters_bright")

    -- handle highlighting of portrait
    self.logo:SetScript("OnEnter", function(frame)
        GameTooltip_SetDefaultAnchor(GameTooltip, frame)
        GameTooltip:SetText(frame.tooltipText, 1, 1, 1, 1, true)
        self.blinkTime = nil; frame.ctrl.logoTexture:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\portrait_orange_highlight")
    end)
    self.logo:SetScript("OnLeave", function(frame)
        GameTooltip:Hide()
        frame.ctrl.logoTexture:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\portrait_orange")
    end)

    -- set blinking effect
    self.logo:SetScript("OnUpdate", function(frame, arg1) _OnUpdate(frame.ctrl, arg1) end)

    log:Debug("_CreateAuctionMasterLogo exit")
end

--[[
	Ensures the loading of blizzard's auction house module.
--]]
function vendor.AuctionHouse.EnsureAuctionHouseUI()
    if (not IsAddOnLoaded("Blizzard_AuctionUi")) then
        local loaded, reason = LoadAddOn("Blizzard_AuctionUi")
        if (not loaded) then
            if (reason) then
                vendor.Vendor:Error("Blizzard_AuctionUi not loaded because of: " .. reason)
            else
                vendor.Vendor:Error("Blizzard_AuctionUi not loaded because of unknown reason")
            end
        end
    end
end

--[[
	Creates mappings from locale string to index for itemClass and itemSubClass.
	See http://www.wowwiki.com/ItemType.
--]]
local function _InitDictionary(self)
    self.itemClasses = {}
    self.itemSubClasses = {}
    local itemClasses = { vendor.Items:GetAuctionItemClasses() }
    for itemClassId = 1, #itemClasses do
        log:Debug("itemClasses [%s] itemClassId [%s] size [%s]", itemClasses, itemClassId, #itemClasses)
        self.itemClasses[itemClasses[itemClassId]] = itemClassId
        local itemSubClasses = { GetAuctionItemSubClasses(itemClassId) }
        for itemSubClassId = 1, #itemSubClasses do
            self.itemSubClasses[itemSubClasses[itemSubClassId]] = itemSubClassId
        end
    end
end

local function _TriggerAction(self, success)
    if (#self.actions == 0) then
        log:Debug("WARN: No pending action")
    else
        local action = tremove(self.actions, 1)
        if (type(success) == "function") then
            log:Debug("call success func")
            success = success(action)
        end
        log:Debug("SendMessage AUCTION_ACTION action [%s] itemLink [%s] success [%s]", action.action, action.itemLink, success)
        self:SendMessage("AUCTION_ACTION", action.action, action.itemLink, success)
    end
end

local function _RegisterTradeSkill(self)
    if (self.tradeSkillHooked) then
        return
    end
    local reagent
    for i = 1, 8 do
        reagent = _G["TradeSkillReagent" .. i]
        if (reagent) then
            reagent:HookScript("OnClick", function(but)
                if (vendor.AuctionHouse.type == "seller") then
                    self:SelectTab(vendor.SearchTab:GetTabId())
                end
                if (vendor.AuctionHouse.type == "scan") then
                    -- search reagent in scan-tab
                    local itemLink = FixedGetTradeSkillReagentItemLink(self, TradeSkillFrame.selectedSkill, but:GetID())
                    if (itemLink) then
                        vendor.SearchTab:PickItem(itemLink, true)
                    end
                end
            end)
            self.tradeSkillHooked = true
        end
    end
    local skillIcon = _G["TradeSkillSkillIcon"]
    if (skillIcon) then
        skillIcon:HookScript("OnClick", function()
            if (vendor.AuctionHouse.type == "scan") then
                -- search reagent in scan-tab
                local itemLink = GetTradeSkillItemLink(TradeSkillFrame.selectedSkill)
                if (itemLink) then
                    vendor.SearchTab:PickItem(itemLink, true)
                end
            end
        end)
    end
end

local function _UnregisterTradeSkill(self)
end

--[[
	Initializes the module.
--]]
function vendor.AuctionHouse:OnInitialize()
    log:Debug("OnInititialize")
    self.db = vendor.Vendor.db:RegisterNamespace("AuctionHouse", {
        profile = {
            startTab = L["Browse"],
            showBlizzardAuctionsTab = false,
            amButtonPos = 0
        }
    })
    _MigrateDb(self)
    self.actions = {}
end

--[[
	Initializes the module.
--]]
function vendor.AuctionHouse:OnEnable()
    log:Debug("OnEnable [%s]", self)
    self.frames = {};
    self.waiters = {}
    self.waitId = 0
    self:RegisterEvent("AUCTION_HOUSE_SHOW")
    self:RegisterEvent("AUCTION_HOUSE_CLOSED")
    --	vendor.AuctionHouse.EnsureAuctionHouseUI()
    self:RegisterEvent("TRADE_SKILL_SHOW")
    self:SecureHook("AuctionFrameTab_OnClick");
    _CreateButton(self)
    self.bugfixTooltip = CreateFrame("GameTooltip", "AMBugfixTooltip", UIParent, "GameTooltipTemplate")
    self.mainMenu = vendor.PopupMenu:new("VendorMainMenu", CMDS, self)
    --self.portraitMenu = vendor.PopupMenu:new("VendorPortraitMenu", FAST_CMDS, self)
    _CreateAuctionMasterLogo(self)
    _InitDictionary(self)
    log:Debug("AuctionHouse:OnEnable exit")
end

function vendor.AuctionHouse:TRADE_SKILL_SHOW()
    --_InitTradeSkillReagents(self)
    _RegisterTradeSkill(self)
    if (self.tradeSkillHooked) then
        self:UnregisterEvent("TRADE_SKILL_SHOW")
    end
end

--[[
	Hooks opening of the auction house to select start tab.
--]]
function vendor.AuctionHouse:AUCTION_HOUSE_SHOW()
    _RegisterTradeSkill(self)
    self:RegisterEvent("CHAT_MSG_SYSTEM")
    self:RegisterEvent("UI_ERROR_MESSAGE")
    if (self.db.profile.startTab) then
        log:Debug("AUCTION_HOUSE_SHOW startTab: %s", self.db.profile.startTab)
        --PanelTemplates_SetTab(AuctionFrame, self.startTab);
        -- the first parameter is unused
        if (self.db.profile.startTab and self.db.profile.startTab <= 3) then
            AuctionFrameTab_OnClick(_GetTabFrame(self, self.db.profile.startTab), self.db.profile.startTab)
        else
            self:AuctionFrameTab_OnClick(_GetTabFrame(self, self.db.profile.startTab), "LeftButton", self.db.profile.startTab);
        end
    end
end

function vendor.AuctionHouse:AUCTION_HOUSE_CLOSED()
    _UnregisterTradeSkill(self)
    self:UnregisterEvent("CHAT_MSG_SYSTEM")
    self:UnregisterEvent("UI_ERROR_MESSAGE")
    wipe(self.actions)
end

--[[
	Hook for auction frame tab clicks
--]]
function vendor.AuctionHouse:AuctionFrameTab_OnClick(frame, mb, id)
    if (not AuctionFrameAuctions.duration) then
        -- needed since patch 4.0.1
        AuctionFrameAuctions.duration = 2
    end
    _TabOnClick(self, id or frame:GetID());
end

--[[
	Returns true, if the currently opened auction house is neutral.
	If no auction house is open, false will be returned.
--]]
function vendor.AuctionHouse:IsNeutral()
    if (not AuctionFrame or not AuctionFrame:IsVisible()) then
        return false;
    end
    return GetAuctionHouseDepositRate() ~= 5;
end

--[[
	Constructor for tabbed frames.
	@param name the name of the created frame
	@id the tab sequence starting with 4
	@tabFrame the controler for the created frame. It has to implement the following methods:
	
	UpdateTabFrame: Updates the frame for displaying it. This is the right place to 
	switch the background.

	ShowTabFrame: Displays the frame object.
		
	HideTabFrame: Hides the frame object.
	
	GetTabType: Returns an unqiue string identifier like "vendor" to be used
	for GetCurrentAuctionHouseTab.
--]]
function vendor.AuctionHouse:CreateTabFrame(name, title, tabTitle, tabFrame, overwriteId)
    log:Debug("CreateTabFrame name: %s title: %s", name, title)
    local frame = CreateFrame("Frame", name, AuctionFrame)
    frame:SetWidth(758)
    frame:SetHeight(447)
    frame:SetPoint("TOPLEFT")
    local f = frame:CreateFontString("BrowseTitle", "BACKGROUND", "GameFontNormal")
    f:SetText(title)
    f:SetPoint("TOP", 0, -18)
    tabFrame.title = f
    frame:Hide()

    local id = AuctionFrame.numTabs + 1
    if (overwriteId) then
        id = overwriteId
    end
    tabFrame.id = id
    self.frames[id] = tabFrame

    if (not overwriteId) then
        -- create the tab button
        log:Debug("CreateTabFrame numTabs: " .. AuctionFrame.numTabs)
        local but = CreateFrame("Button", "AuctionFrameTab" .. id, AuctionFrame, "AuctionTabTemplate")
        log:Debug("CreateTabFrame created tab button with id: " .. id)
        but:SetID(id)
        but:SetText(tabTitle)
        but:SetPoint("TOPLEFT", "AuctionFrameTab" .. (id - 1), "TOPRIGHT", -8, 0)
        but.ctrl = self
        --but:SetScript("OnClick", function(but) _TabOnClick(but.ctrl, but:GetID()) end)
        but:Hide() -- don't know, why it's needed!?
        but:Show()
        PanelTemplates_SetNumTabs(AuctionFrame, id)
        PanelTemplates_EnableTab(AuctionFrame, id)
    end
    return frame
end

--[[
	Constructor for close button of the tabs.
--]]
function vendor.AuctionHouse:CreateCloseButton(parent, name)
    local but = CreateFrame("Button", name, parent, "UIPanelButtonTemplate");
    but:SetText(L["Close"]);
    but:SetWidth("80");
    but:SetHeight("22");
    but:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 66, 14);
    but:SetScript("OnClick", function() CloseAuctionHouse(); end);
    return but;
end

--[[
	Returns the type of tab currently shown in the auction house. Possible 
	values are the ones from blizzard "list", "bidder", "owner" and
	the vendor defined ones. The Tabs of vendor have to implement the
	method GetTabType to retrieve it from them.
--]]
function vendor.AuctionHouse:GetCurrentAuctionHouseTab()
    return self.type, self.typeId
end

--[[
	Returns whether the given tab is currently shown.
--]]
function vendor.AuctionHouse:IsAuctionHouseTabShown(tabType)
    log:Debug("IsAuctionHouseTabShown tabType: " .. tabType)
    if (AuctionFrame and AuctionFrame:IsVisible()) then
        log:Debug("type: " .. self.type)
        return self.type == tabType
    end
    log:Debug("return false")
    return false
end

--[[
	Cancels the given list of auctions. The given table has to contain entries with the following information:
	itemLinkKey, minBid, buyout, count 
--]]
function vendor.AuctionHouse:CancelAuctions(auctions, func, arg1)
    local task = vendor.CancelTask:new(auctions)
    vendor.TaskQueue:AddTask(task, func, arg1)
end

--[[
	Handles chat events to recognize auction actions.
--]]
function vendor.AuctionHouse:CHAT_MSG_SYSTEM(event, message)
    log:Debug("received cmessage: %s", message)
    if (message == ERR_AUCTION_REMOVED) then
        _StopWait(self)
        _TriggerAction(self, function(action) return action.action == self.ACTION_CANCEL end)
    elseif (message == ERR_AUCTION_BID_PLACED) then
        _StopWait(self)
        _TriggerAction(self, function(action) return action.action == self.ACTION_BID end)
    elseif (message == ERR_AUCTION_STARTED) then
        _StopWait(self)
        _TriggerAction(self, function(action) return action.action == self.ACTION_SELL end)
    end
end

--[[
	Handles error messages to recognize failures during auction actions
--]]
function vendor.AuctionHouse:UI_ERROR_MESSAGE(event, message)
    log:Debug("received emessage: %s", message)
    if (message == ERR_ITEM_NOT_FOUND) then
        _StopWait(self)
        _TriggerAction(self, false)
    elseif (message == ERR_NOT_ENOUGH_MONEY) then
        _StopWait(self)
        _TriggerAction(self, false)
    elseif (message == ERR_AUCTION_BID_OWN) then
        _StopWait(self)
        _TriggerAction(self, false)
    elseif (message == ERR_AUCTION_HIGHER_BID) then
        _StopWait(self)
        _TriggerAction(self, false)
    elseif (message == ERR_ITEM_MAX_COUNT) then
        _StopWait(self)
        _TriggerAction(self, false)
    end
end

--[[
	Registers for auction chat messages.
--]]
function vendor.AuctionHouse:RegisterChatWait()
    local id = self.waitId
    self.waitId = self.waitId + 1
    self.waiters[id] = GetTime() + 10
    return id
end

--[[
	Unregisters any current chat wait.
--]]
function vendor.AuctionHouse:UnregisterChatWait(id)
    if (id) then
        self.waiters[id] = nil
    end
end

--[[
	Waits until the given id is done.
--]]
function vendor.AuctionHouse:ChatWait(id)
    if (id) then
        while (true) do
            local stopWait = self.waiters[id]
            if (not stopWait or GetTime() > stopWait) then
                self.waiters[id] = nil
                break
            end
            coroutine.yield()
        end
    end
end

--[[
	Returns true, if the auction house is currently open.
--]]
function vendor.AuctionHouse:IsOpen()
    return AuctionFrame:IsShown()
end

--[[
	Returns the numerical itemClassId for the given text representation.
--]]
function vendor.AuctionHouse:GetItemClassId(itemClass)
    return self.itemClasses[itemClass]
end

--[[
	Returns the numerical itemSubClassId for the given text representation.
--]]
function vendor.AuctionHouse:GetItemSubClassId(itemSubClass)
    return self.itemSubClasses[itemSubClass]
end

--[[
	Selects the given tab in the auctionhouse.
--]]
function vendor.AuctionHouse:SelectTab(tabId)
    log:Debug("SelectTab [%s]", tabId)
    if (tabId <= 3) then
        AuctionFrameTab_OnClick(_GetTabFrame(self, tabId), tabId)
    else
        self:AuctionFrameTab_OnClick(_GetTabFrame(self, tabId), "LeftButton", tabId)
    end
end

-- Registers the given action. After receiving the corresponding chat message
-- a AUCTION_ACTION message will be sent with action and itemLink as arguments.
function vendor.AuctionHouse:AddAction(action, itemLink)
    tinsert(self.actions, { action = action, itemLink = itemLink })
end

function vendor.AuctionHouse:ToggleBlizzardAuctionsTab()
    self.db.profile.showBlizzardAuctionsTab = not self.db.profile.showBlizzardAuctionsTab
    local name, id = self:GetCurrentAuctionHouseTab()
    if (id == 3) then
        AuctionFrameTab_OnClick(AuctionFrameTab3)
    end

end

function vendor.AuctionHouse:ShowBlizzardAuctionTabOnce()
    log:Debug("ShowBlizzardAuctionTabOnce")
    if (not self.db.profile.showBlizzardAuctionsTab) then
        log:Debug("UpdateOwnerTab with revert")
        self.db.profile.showBlizzardAuctionsTab = true
        AuctionFrameTab_OnClick(AuctionFrameTab3)
        self.db.profile.showBlizzardAuctionsTab = false
    else
        AuctionFrameTab_OnClick(AuctionFrameTab3)
    end
end