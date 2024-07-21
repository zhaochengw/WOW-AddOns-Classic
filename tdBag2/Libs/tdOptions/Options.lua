-- Options.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/15/2024, 11:37:25 PM
--
local MAJOR, MINOR = 'tdOptions', 3
---@class tdOptions
local Lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not Lib then
    return
end

Lib.panels = Lib.panels or {}
Lib.addons = Lib.addons or {}

local AceGUI = LibStub('AceGUI-3.0')
local AceConfigRegistry = LibStub('AceConfigRegistry-3.0')
local AceConfigDialog = LibStub('AceConfigDialog-3.0')

local tinsert = table.insert
local wipe = table.wipe or _G.wipe
local format = string.format

local C_AddOns = _G.C_AddOns

local STANDARD_TEXT_FONT = _G.STANDARD_TEXT_FONT

function Lib:Register(name, opts)
    AceConfigRegistry:RegisterOptionsTable(name, opts)
    AceConfigDialog:AddToBlizOptions(name, name)
    self:UpdateAddon(name)
end

function Lib:UpdateAddon(name)
    table.insert(self.addons, name)
    table.insert(self.panels, self:GeneratePanel(name))
end

function Lib:Update()
    self.TreeGroup:RefreshTree()
end

function Lib:GeneratePanel(name, item)
    item = item or {}
    item.value = name
    item.text = '  ' .. C_AddOns.GetAddOnMetadata(name, 'Title')
    return item
end

function Lib:Open(name, ...)
    if not self.Frame then
        local Frame = AceGUI:Create('Frame')
        Frame:SetTitle('td\'s AddOns Options')
        Frame:SetLayout('Fill')
        Frame:SetWidth(830)
        Frame:SetHeight(588)
        Frame:EnableResize(false)
        Frame:SetCallback('OnClose', function(widget)
            AceConfigDialog:Close(MAJOR)
            self.InlineGroup:ReleaseChildren()
        end)
        Frame.frame:SetFrameStrata('DIALOG')
        Frame.frame:SetClampedToScreen(true)

        _G.tdOptionsFrame = Frame
        tinsert(_G.UISpecialFrames, 'tdOptionsFrame')

        local TreeGroup = AceGUI:Create('TreeGroup')
        TreeGroup:SetParent(Frame)
        TreeGroup:SetLayout('Fill')
        TreeGroup:EnableButtonTooltips(false)
        TreeGroup:SetTreeWidth(false)
        TreeGroup:SetTree(self.panels)
        TreeGroup:SetCallback('OnGroupSelected', function(_, _, group)
            self.Label:SetText(C_AddOns.GetAddOnMetadata(group, 'Title'))
            self.Label:SetImage(C_AddOns.GetAddOnMetadata(group, 'IconTexture'))
            self.Version:SetText(format('Version: %s', C_AddOns.GetAddOnMetadata(group, 'Version')))
            AceConfigDialog:Open(group, self.InlineGroup)
        end)

        Frame:AddChild(TreeGroup)

        local ParentGroup = AceGUI:Create('SimpleGroup')
        ParentGroup:SetLayout('Flow')
        TreeGroup:AddChild(ParentGroup)

        local Label = AceGUI:Create('Label')
        Label:SetRelativeWidth(0.7)
        Label:SetFont(STANDARD_TEXT_FONT, 16, 'THINKOUTLINE')
        Label:SetColor(0.8, 1, 1)
        Label:SetImageSize(32, 32)
        Label:SetImage([[Interface\ICONS\UI_Chat]])
        Label:SetText('Placeholder')
        ParentGroup:AddChild(Label)

        local Version = AceGUI:Create('Label')
        Version:SetRelativeWidth(0.3)
        Version:SetFont(STANDARD_TEXT_FONT, 13, 'THINKOUTLINE')
        Version:SetColor(1, 0.8, 0.8)
        Version:SetJustifyH('RIGHT')
        Version:SetText('Placeholder')
        ParentGroup:AddChild(Version)

        local Heading = AceGUI:Create('Heading')
        Heading:SetFullWidth(true)
        ParentGroup:AddChild(Heading)

        local InlineGroup = AceGUI:Create('SimpleGroup')
        InlineGroup:SetLayout('Fill')
        InlineGroup:SetFullWidth(true)
        InlineGroup:SetFullHeight(true)
        ParentGroup:AddChild(InlineGroup)

        self.Frame = Frame
        self.TreeGroup = TreeGroup
        self.ParentGroup = ParentGroup
        self.Label = Label
        self.Version = Version
        self.InlineGroup = InlineGroup
    end

    AceConfigDialog:SelectGroup(name, ...)
    self.Frame:Show()
    self:Update()
    self.TreeGroup:SelectByValue(name)
end

if oldminor and oldminor < 2 then
    if Lib.TreeGroup then
        if next(Lib.TreeGroup.buttons) then
            for _, button in ipairs(Lib.TreeGroup.buttons) do
                button:Hide()
                button:SetParent(_G.UIParent)
            end
            wipe(Lib.TreeGroup.buttons)
        end
        if Lib.orig_TreeGroup_CreateButton then
            Lib.TreeGroup.CreateButton = Lib.orig_TreeGroup_CreateButton
            Lib.orig_TreeGroup_CreateButton = nil
        end
    end

    Lib.Frame.frame:SetClampedToScreen(false)
    Lib.Frame:Release()
    Lib.Frame = nil

    for _, v in ipairs(Lib.panels) do
        tinsert(Lib.addons, v.value)
        Lib:GeneratePanel(v.value, v)
    end
end
