local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local actualVersion = TI_GetAddOnMetadata("TinyInspect-Classic", "Version") or "unknown"

local addon, ns = ...
local L = ns.L or {}
setmetatable(L, { __index = function(_, k)
    return k:gsub("([a-z])([A-Z])", "%1 %2")
end})

local DefaultReforgedDB = {
    version = actualVersion,
    ShowItemBorder = false,
    EnableItemLevel  = true,
      ShowColoredItemLevelString = false,
      ShowCorruptedMark = false,
      ShowItemSlotString = true,
        EnableItemLevelBag = true,
        EnableItemLevelBank = true,
        EnableItemLevelMerchant = true,
        EnableItemLevelTrade = true,
        EnableItemLevelGuildBank = true,
        EnableItemLevelAuction = true,
        EnableItemLevelAltEquipment = true,
        EnableItemLevelPaperDoll = true,
        EnableItemLevelGuildNews = true,
        EnableItemLevelChat = false,
        EnableItemLevelLoot = true,
        EnableItemLevelOther = true,
    ShowInspectAngularBorder = false,
    ShowInspectColoredLabel = true,
    ShowCharacterItemSheet = true,
    ShowInspectItemSheet = true,
        ShowOwnFrameWhenInspecting = false,
        ShowItemStats = false,
    EnablePartyItemLevel = false,
        SendPartyItemLevelToSelf = false,
        SendPartyItemLevelToParty = false,
        ShowPartySpecialization = true,
    EnableRaidItemLevel = false,
    EnableMouseItemLevel = true,
    EnableMouseSpecialization = true,
    EnableMouseWeaponLevel = true,
    PaperDollItemLevelOutsideString = false,
    ItemLevelAnchorPoint = "TOP",
    ShowPluginGreenState = false,
    ShowGemAndEnchant = true,
    HideOffHandEnchantIcon = true,
        EnchantParts = {
            {false, "HEADSLOT", },
            {false, "NECKSLOT", },
            {true, "SHOULDERSLOT", },
            false,
            {true, "CHESTSLOT", },
            {true, "WAISTSLOT", },
            {true, "LEGSSLOT", },
            {true, "FEETSLOT", },
            {true, "WRISTSLOT", },
            {true, "HANDSSLOT", },
            {true, "FINGER0SLOT", },
            {true, "FINGER1SLOT", },
            {false, "TRINKET0SLOT", },
            {false, "TRINKET1SLOT", },
            {true, "BACKSLOT", },
            {true, "MAINHANDSLOT", },
            {true, "SECONDARYHANDSLOT", },
        },
}

local options = {
    { key = "ShowItemBorder" },
    { key = "ShowGemAndEnchant",
        subcheck = DefaultReforgedDB.EnchantParts,
    },
    { key = "EnableItemLevel",
      child = {
        { key = "ShowColoredItemLevelString" },
        --{ key = "ShowCorruptedMark" }, -- dont exists in mop
        { key = "ShowItemSlotString" },
	{ key = "PaperDollItemLevelOutsideString" },
      },
      subtype = {
        xpos = 490, ypos = -50,
        { key = "Other" },
        { key = "AltEquipment" },
        { key = "GuildNews" },
        { key = "Chat" },
        { key = "Bag" },
        { key = "Bank" },
        { key = "GuildBank" },
        { key = "Merchant" },
        { key = "Trade" },
        { key = "PaperDoll" },
        { key = "Loot" },
      },
      anchorkey = "ItemLevelAnchorPoint",
    },
    { key = "ShowInspectAngularBorder" },
    { key = "ShowInspectColoredLabel" },
    { key = "ShowCharacterItemSheet" },
    { key = "ShowInspectItemSheet",
        child = {
            { key = "ShowOwnFrameWhenInspecting" },
            { key = "ShowItemStats" },
        }
    },
    { key = "EnablePartyItemLevel", -- Disabling due to many issues
      child = {
        { key = "ShowPartySpecialization" },
        { key = "SendPartyItemLevelToSelf" },
        { key = "SendPartyItemLevelToParty" },
      }
    },
    { key = "EnableRaidItemLevel",
        checkedFunc = function() TinyInspectRaidFrame:Show() end,
        uncheckedFunc = function() TinyInspectRaidFrame:Hide() end,
    },
    { key = "EnableMouseItemLevel",
      child = {
        { key = "EnableMouseSpecialization" },
        { key = "EnableMouseWeaponLevel" },
      }
    },
}

if (GetLocale():sub(1,2) == "zh") then
    tinsert(options, { key = "ShowPluginGreenState" })
end

TinyInspectClassicDB = DefaultReforgedDB

local function CallCustomFunc(self)
    local checked = self:GetChecked()
    if (checked and self.checkedFunc) then
        self.checkedFunc(self)
    end
    if (not checked and self.uncheckedFunc) then
        self.uncheckedFunc(self)
    end
end

local function StatusSubCheckbox(self, status)
    local checkbox
    for i = 1, self:GetNumChildren() do
        checkbox = select(i, self:GetChildren())
        if (checkbox.key) then
            checkbox:SetEnabled(status)
            StatusSubCheckbox(checkbox, status)
        end
    end
    if (status and self.SubtypeFrame) then
        self.SubtypeFrame:Show()
    elseif (not status and self.SubtypeFrame) then
        self.SubtypeFrame:Hide()
    end
end

local function OnClickCheckbox(self)
    local status = self:GetChecked()
    if (strfind(self.key, "EnchantParts|")) then
        local _, key = strsplit("|", self.key)
        key = tonumber(key)
        if (TinyInspectClassicDB.EnchantParts[key]) then
            TinyInspectClassicDB.EnchantParts[key][1] = status
        end
    else
        TinyInspectClassicDB[self.key] = status
    end
    StatusSubCheckbox(self, status)
    CallCustomFunc(self)
end

local function CreateSubtypeFrame(list, parent, xpos, ypos)
    if (not list) then return end
    if (not parent.SubtypeFrame) then
        parent.SubtypeFrame = CreateFrame("Frame", nil, parent, BackdropTemplateMixin and "BackdropTemplate" or nil)
        parent.SubtypeFrame:SetScale(0.92)
        parent.SubtypeFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", xpos or 300, ypos or 20)
        parent.SubtypeFrame:SetBackdrop({
            bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile     = true,
            tileSize = 8,
            edgeSize = 16,
            insets   = {left = 4, right = 4, top = 4, bottom = 4}
        })
        parent.SubtypeFrame:SetBackdropColor(0, 0, 0, 0.6)
        parent.SubtypeFrame:SetBackdropBorderColor(0.6, 0.6, 0.6)
        parent.SubtypeFrame.title = parent.SubtypeFrame:CreateFontString(nil, "BORDER", "GameFontNormalOutline")
        parent.SubtypeFrame.title:SetPoint("TOPLEFT", 16, -18)
        parent.SubtypeFrame.title:SetText(L[parent.key])
    end
    local checkbox
    for i, v in ipairs(list) do
        checkbox = CreateFrame("CheckButton", nil, parent.SubtypeFrame, "InterfaceOptionsCheckButtonTemplate")
        checkbox.key = parent.key .. v.key
        checkbox.checkedFunc = v.checkedFunc
        checkbox.uncheckedFunc = v.uncheckedFunc
        checkbox.Text:SetText(L[v.key])
        checkbox:SetScript("OnClick", OnClickCheckbox)
        checkbox:SetPoint("TOPLEFT", parent.SubtypeFrame, "TOPLEFT", 16, -46-(i-1)*30)
    end
    parent.SubtypeFrame:SetSize(168, #list*30+58)
end

local function CreateSubcheckFrame(list, parent, xpos, ypos)
    if (not list) then return end
    if (not parent.SubtypeFrame) then
        parent.SubtypeFrame = CreateFrame("Frame", nil, parent, BackdropTemplateMixin and "BackdropTemplate" or nil)
        parent.SubtypeFrame:SetScale(0.95)
        parent.SubtypeFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", xpos or 300, ypos or 22)
        parent.SubtypeFrame:SetBackdrop({
            bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile     = true,
            tileSize = 8,
            edgeSize = 16,
            insets   = {left = 4, right = 6, top = 4, bottom = 4}
        })
        parent.SubtypeFrame:SetBackdropColor(0, 0, 0, 0.6)
        parent.SubtypeFrame:SetBackdropBorderColor(0.6, 0.6, 0.6)
        parent.SubtypeFrame.title = parent.SubtypeFrame:CreateFontString(nil, "BORDER", "GameFontNormalOutline")
        parent.SubtypeFrame.title:SetPoint("TOPLEFT", 16, -18)
        parent.SubtypeFrame.title:SetText(L[parent.key])
    end
    local checkbox, j
    for i, v in ipairs(list) do
      if (i <= 3) then j = i else j = i-1 end
      if (v) then
        checkbox = CreateFrame("CheckButton", nil, parent.SubtypeFrame, "InterfaceOptionsCheckButtonTemplate")
        checkbox.key = "EnchantParts|" .. i 
        checkbox.checkedFunc = v.checkedFunc
        checkbox.uncheckedFunc = v.uncheckedFunc
        checkbox.Text:SetText(_G[v[2]] or v[2])
        checkbox:SetScript("OnClick", OnClickCheckbox)
        checkbox:SetPoint("TOPLEFT", parent.SubtypeFrame, "TOPLEFT", 16, -46-(j-1)*30)
      end
    end
    parent.SubtypeFrame:SetSize(168, #list*30+58)
end

local function CreateAnchorFrame(anchorkey, parent)
    if (not anchorkey) then return end
    local CreateAnchorButton = function(frame, anchorPoint)
        local button = CreateFrame("Button", nil, frame)
        button.anchorPoint = anchorPoint
        button:SetSize(12, 12)
        button:SetPoint(anchorPoint)
        button:SetNormalTexture("Interface\\Buttons\\WHITE8X8")
        if (TinyInspectClassicDB[frame.anchorkey] == anchorPoint) then
            button:GetNormalTexture():SetVertexColor(1, 0.2, 0.1)
        end
        button:SetScript("OnClick", function(self)
            local parent = self:GetParent()
            local anchorPoint = self.anchorPoint
            local anchorOrig = TinyInspectClassicDB[parent.anchorkey]
            if (parent[anchorOrig]) then
                parent[anchorOrig]:GetNormalTexture():SetVertexColor(1, 1, 1)
            end
            self:GetNormalTexture():SetVertexColor(1, 0.2, 0.1)
            TinyInspectClassicDB[parent.anchorkey] = anchorPoint
        end)
        frame[anchorPoint] = button
    end
    local frame = CreateFrame("Frame", nil, parent.SubtypeFrame or parent, BackdropTemplateMixin and "BackdropTemplate" or "BackdropTemplate")
    frame.anchorkey = anchorkey
    frame:SetBackdrop({
            bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile     = true, tileSize = 8, edgeSize = 16,
            insets   = {left = 4, right = 4, top = 4, bottom = 4}
    })
    frame:SetBackdropColor(0, 0, 0, 0.7)
    frame:SetBackdropBorderColor(1, 1, 1, 0)
    frame:SetSize(80, 80)
    frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 530, 44)
    CreateAnchorButton(frame, "TOPLEFT")
    CreateAnchorButton(frame, "LEFT")
    CreateAnchorButton(frame, "BOTTOMLEFT")
    CreateAnchorButton(frame, "TOP")
    CreateAnchorButton(frame, "BOTTOM")
    CreateAnchorButton(frame, "TOPRIGHT")
    CreateAnchorButton(frame, "RIGHT")
    CreateAnchorButton(frame, "BOTTOMRIGHT")
    CreateAnchorButton(frame, "CENTER")
end

local function CreateCheckbox(list, parent, anchor, offsetx, offsety)
    local checkbox, subbox
    local stepx, stepy = 20, 25
    if (not list) then return offsety end
    for i, v in ipairs(list) do
        checkbox = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
        checkbox.key = v.key
        checkbox.checkedFunc = v.checkedFunc
        checkbox.uncheckedFunc = v.uncheckedFunc
        checkbox.Text:SetText(L[v.key])
        checkbox:SetScript("OnClick", OnClickCheckbox)
        checkbox:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", offsetx, -6-offsety)
        offsety = offsety + stepy
        offsety = CreateCheckbox(v.child, checkbox, anchor, offsetx+stepx, offsety)
        CreateSubtypeFrame(v.subtype, checkbox, v.subtype and v.subtype.xpos, v.subtype and v.subtype.ypos)
        CreateAnchorFrame(v.anchorkey, checkbox)
        CreateSubcheckFrame(v.subcheck, checkbox, v.subcheck and v.subcheck.xpos, v.subcheck and v.subcheck.ypos)
    end
    return offsety
end

local function InitCheckbox(parent)
    local checkbox
    for i = 1, parent:GetNumChildren() do
        checkbox = select(i, parent:GetChildren())
        if (checkbox.key) then
            local key
            if (strfind(checkbox.key, "EnchantParts|")) then
                key = select(2, strsplit("|", checkbox.key))
                key = tonumber(key)
                if (TinyInspectClassicDB.EnchantParts[key]) then
                    checkbox:SetChecked(TinyInspectClassicDB.EnchantParts[key][1])
                end
            else
                checkbox:SetChecked(TinyInspectClassicDB[checkbox.key])
            end
            StatusSubCheckbox(checkbox, checkbox:GetChecked())
            CallCustomFunc(checkbox)
            InitCheckbox(checkbox)
        end
    end
    if (parent.SubtypeFrame) then
        InitCheckbox(parent.SubtypeFrame)
    end
end

local frame = CreateFrame("Frame", "TinyInspect-ClassicFrame", UIParent)
frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
frame.title:SetPoint("TOPLEFT", 18, -16)
frame.title:SetText(addon)
frame.name = addon

frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
frame.text:SetPoint("TOPLEFT", 30, -35)
frame.text:SetText("by |cffF58CBAShîrîana|r |cffff00ff<Krieger der alten Welt>|r - |cff33eeffEverlook EU Horde|r")

CreateCheckbox(options, frame, frame.title, 18, 11)

LibEvent:attachEvent("VARIABLES_LOADED", function()
    if (not TinyInspectClassicDB or not TinyInspectClassicDB.version) then
        TinyInspectClassicDB = DefaultReforgedDB
    elseif (TinyInspectClassicDB.version <= DefaultReforgedDB.version) then
        TinyInspectClassicDB.version = DefaultReforgedDB.version
        for k, v in pairs(DefaultReforgedDB) do
            if (TinyInspectClassicDB[k] == nil) then
                TinyInspectClassicDB[k] = v
            end
        end
    end
    InitCheckbox(frame)
end)

if Settings and Settings.RegisterCanvasLayoutCategory then
    local category = Settings.RegisterCanvasLayoutCategory(frame, "TinyInspect Classic")
    Settings.RegisterAddOnCategory(category)
    frame.categoryID = category:GetID()    
else
    InterfaceOptions_AddCategory(frame)
end

SLASH_TinyInspectClassic1 = "/TinyInspectClassic"
SLASH_TinyInspectClassic2 = "/tic"

function SlashCmdList.TinyInspectClassic(msg, editbox)
    if (msg == "raid") then
        return ToggleFrame(TinyInspect-ClassicRaidFrame)
    elseif (msg == "reset") then
        TinyInspectClassicDB = {}
        ReloadUI()
    elseif (msg == "reload") then
        ReloadUI()
    end
    if Settings and Settings.RegisterCanvasLayoutCategory then
        local settingsCategoryID = _G["TinyInspect-ClassicFrame"].categoryID
        Settings.OpenToCategory(settingsCategoryID)
    else
        InterfaceOptionsFrame_OpenToCategory(frame)
        InterfaceOptionsFrame_OpenToCategory(frame)
   end
end
