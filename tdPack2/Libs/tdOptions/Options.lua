-- Options.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/15/2024, 11:37:25 PM
--
local MAJOR, MINOR = 'tdOptions', 6
---@class tdOptions
local Lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not Lib then
    return
end

local panels = Lib.panels or {}
local data = Lib.data or {}

wipe(Lib)

Lib.panels = panels
Lib.data = data

local AceGUI = LibStub('AceGUI-3.0')
local AceConfigRegistry = LibStub('AceConfigRegistry-3.0')
local AceConfigDialog = LibStub('AceConfigDialog-3.0')

local tinsert = table.insert
local wipe = table.wipe or _G.wipe
local format = string.format

local C_AddOns = _G.C_AddOns

local STANDARD_TEXT_FONT = _G.STANDARD_TEXT_FONT

local function UpdateAddon(name)
    if select(5, GetAddOnInfo(name)) ~= 'MISSING' then
        data[name] = {
            text = C_AddOns.GetAddOnMetadata(name, 'Title'),
            icon = C_AddOns.GetAddOnMetadata(name, 'IconTexture'),
            notes = C_AddOns.GetAddOnMetadata(name, 'Notes'),
            version = C_AddOns.GetAddOnMetadata(name, 'Version'),
        }
    end
end

local function GeneratePanel(name, item)
    item = item or {}
    item.value = name
    item.text = name
    return item
end

local function AddPanel(name)
    table.insert(panels, GeneratePanel(name))
    sort(panels, function(a, b)
        if a.value == 'tdSupport' then
            return false
        end
        if b.value == 'tdSupport' then
            return true
        end
        return a.text < b.text
    end)
end

function Lib:Register(name, opts)
    AceConfigRegistry:RegisterOptionsTable(name, opts)
    AceConfigDialog:AddToBlizOptions(name, name)
    UpdateAddon(name)
    AddPanel(name)
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
            local addonData = self.data[group]
            self.Label:SetText(addonData.text)
            self.Label:SetImage(addonData.icon)
            self.Version:SetText(addonData.version and format('Version: %s', addonData.version) or '')
            AceConfigDialog:Open(group, self.InlineGroup)
        end)
        TreeGroup:SetCallback('OnButtonEnter', function(_, _, group, button)
            local addonData = self.data[group]
            if not addonData then
                return
            end
            GameTooltip:SetOwner(button, 'ANCHOR_RIGHT')
            GameTooltip:SetText(addonData.text)
            if addonData.notes then
                GameTooltip:AddLine(addonData.notes, 1, 1, 1, true)
            end
            GameTooltip:Show()
        end)
        TreeGroup:SetCallback('OnButtonLeave', GameTooltip_Hide)

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
        InlineGroup.type = 'SimpleGroupHooked' -- hack: SimpleGroup不会创建ScrollFrame
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
    self.TreeGroup:RefreshTree()
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
end

if oldminor and oldminor <= 3 then
    for _, v in ipairs(Lib.panels) do
        GeneratePanel(v.value, v)
        UpdateAddon(v.value)
    end
end

do
    local _L = GetLocale()
    local L = _L == 'zhCN' and { --
        tdSupport = '支持作者',
        Afadian = '爱发电',
        ['Use CTRL+C to copy link'] = '使用CTRL+C复制链接',
    } or { --
        tdSupport = 'Support Author',
        Afadian = 'Afadian',
        ['Use CTRL+C to copy link'] = 'Use CTRL+C to copy link',
    }

    local Addon = 'tdSupport'

    data[Addon] = { --
        text = L['tdSupport'],
        icon = [[Interface\ICONS\Achievement_Reputation_08]],
    }

    local function OpenUrlDialog(url)
        local Frame =  AceGUI:Create('Frame')

        Frame:SetTitle(L['tdSupport'])
        Frame:SetStatusText(L['Use CTRL+C to copy link'])
        Frame:SetLayout('Flow')
        Frame:SetWidth(400)
        Frame:SetHeight(100)
        Frame:EnableResize(false)
        Frame:SetCallback('OnClose', function(widget)
            AceGUI:Release(widget)
        end)

        local EditBox = AceGUI:Create('EditBox')
        EditBox:SetText(url)
        EditBox:SetFullWidth(true)
        EditBox:DisableButton(true)
        EditBox:SetFocus()
        EditBox:HighlightText()
        Frame:AddChild(EditBox)
    end

    local opts = { --
        type = 'group',
        name = L['tdSupport'],
        args = {
            desc = {
                type = 'execute',
                name = L.Afadian,
                order = 1,
                func = function()
                    OpenUrlDialog('https://afdian.com/a/dencer')
                end,
            },
        },
    }

    AceConfigRegistry:RegisterOptionsTable(Addon, opts)

    tinsert(panels, {text = L['tdSupport'], value = Addon})
end
