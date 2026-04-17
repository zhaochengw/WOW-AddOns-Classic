-- FrameBase.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 1/7/2020, 12:31:57 AM
--
local _G = _G
local tinsert = table.insert
local tDeleteItem = tDeleteItem

local PlaySound = PlaySound
local CreateFrame = CreateFrame

local UISpecialFrames = UISpecialFrames

local UIParent = UIParent

---@type ns
local ns = select(2, ...)

local LibWindow = LibStub('LibWindow-1.1')

---@class UI.Frame: tdBag2BaseFrameTemplate, Object, EventsMixin
-- UI
---@field Container UI.Container
-- members
---@field lockOwner boolean
---@field manual boolean
local Frame = ns.Addon:NewClass('UI.Frame', 'Frame')
Frame.TEMPLATE = 'tdBag2BaseFrameTemplate'
Frame.GenerateName = ns.NameGenerator('tdBag2Frame')

function Frame:Constructor(_, meta)
    ---@type FrameMeta
    self.meta = meta
    self.name = self:GetName()

    ns.UI.TitleFrame:Bind(self.TitleFrame, self.meta)
    self.meta.class.Container:Bind(self.Container, self.meta)

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)

    local Close = self.CloseButton or self.Close
    if Close then
        Close:SetScript('OnClick', function()
            ns.Addon:HideFrame(self.meta.bagId, true)
        end)
    end

    self:UpdateManaged()
    self:UpdateSpecial()
end

---@param meta FrameMeta
function Frame:Create(meta)
    return self:Bind(CreateFrame('Frame', self:GenerateName(), UIParent, self.TEMPLATE), meta)
end

function Frame:OnShow()
    PlaySound(862) -- SOUNDKIT.IG_BACKPACK_OPEN
    self:RegisterFrameEvent('MANAGED_TOGGLED', 'UpdateManaged')
    self:UpdateBorder()
end

function Frame:OnHide()
    PlaySound(863) -- SOUNDKIT.IG_BACKPACK_CLOSE
    self:UnregisterAllEvents()

    if not self.lockOwner then
        self.meta:SetOwner(nil)
    end
end

Frame.OnSizeChanged = ns.Spawned(UpdateUIPanelPositions)

function Frame:UpdateBorder()
end

function Frame:UpdatePosition()
    if not self.meta.profile.managed then
        LibWindow.RegisterConfig(self, self.meta.profile.window)
        LibWindow.RestorePosition(self)
    end
end

function Frame:SavePosition()
    if not self.meta.profile.managed then
        LibWindow.SavePosition(self)
    end
end

function Frame:UpdateManaged()
    local managed = self.meta.profile.managed
    local changed = (not self:GetAttribute('UIPanelLayout-enabled')) ~= (not managed)

    if not changed then
        return
    end

    self.updatingManaged = true

    local shown = self:IsShown()
    if shown then
        ns.HideUIPanel(self)
    end

    self:SetAttribute('UIPanelLayout-enabled', managed)
    self:SetAttribute('UIPanelLayout-defined', managed)
    self:SetAttribute('UIPanelLayout-whileDead', managed)
    self:SetAttribute('UIPanelLayout-area', managed and 'left')
    self:SetAttribute('UIPanelLayout-pushable', managed and 1)

    if shown then
        ns.ShowUIPanel(self)
    end

    self:UpdateSpecial()
    self.updatingManaged = nil
end

function Frame:UpdateSpecial()
    if not self.meta.profile.managed then
        if not tIndexOf(UISpecialFrames, self.name) then
            tinsert(UISpecialFrames, self.name)
        end

        self:SetScript('OnSizeChanged', nil)
        self:UpdatePosition()
    else
        tDeleteItem(UISpecialFrames, self.name)

        self:SetScript('OnSizeChanged', self.OnSizeChanged)
        self:OnSizeChanged()
    end
end

function Frame:UpdateSize()
    return self:SetSize(self.Container:GetRealWidth() + self.fixedWidth,
                        self.Container:GetRealHeight() + self.fixedHeight)
end
