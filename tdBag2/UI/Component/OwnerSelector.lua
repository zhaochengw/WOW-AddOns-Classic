-- OwnerSelector.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/18/2019, 10:26:06 AM
--
---- LUA
local select = select
local tinsert = table.insert
local unpack = table.unpack or unpack
local ipairs = ipairs

---- WOW
local CreateFrame = CreateFrame
local SetPortraitTexture = SetPortraitTexture

---- UI
local GameTooltip = GameTooltip
local UIParent = UIParent

---- G
local CHARACTER = CHARACTER
local DELETE = DELETE

---@type ns
local ns = select(2, ...)
local L = ns.L
local Addon = ns.Addon
local Cache = ns.Cache

---@type tdBag2OwnerSelector
local OwnerSelector = ns.Addon:NewClass('UI.OwnerSelector', ns.UI.MenuButton)

function OwnerSelector:Constructor(_, meta)
    self.meta = meta
    self.portrait = self.portrait or self.texture
    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', self.OnLeave)
    self:SetScript('OnShow', self.OnShow)
end

function OwnerSelector:OnShow()
    self:RegisterFrameEvent('OWNER_CHANGED', 'UpdateIcon')
    self:RegisterFrameEvent('ICON_CHARACTER_TOGGLED', 'UpdateIcon')
    self:RegisterEvent('OWNER_REMOVED', 'UpdateEnable')
    self:RegisterEvent('UPDATE_ALL', 'Update')
    self:Update()
end

function OwnerSelector:OnClick(button)
    if button == 'RightButton' then
        self:CloseMenu()
        self.meta:SetOwner(nil)
    else
        self:OnLeave()
        self:ToggleMenu()
    end
end

function OwnerSelector:OnEnter()
    ns.AnchorTooltip(self)
    GameTooltip:SetText(CHARACTER)
    GameTooltip:AddLine(ns.LeftButtonTip(L.TOOLTIP_CHANGE_PLAYER))
    GameTooltip:AddLine(ns.RightButtonTip(L.TOOLTIP_RETURN_TO_SELF))
    GameTooltip:Show()
end

function OwnerSelector:OnLeave()
    GameTooltip:Hide()
end

function OwnerSelector:Update()
    self:UpdateEnable()
    self:UpdateIcon()
end

function OwnerSelector:UpdateEnable()
    self:SetEnabled(Cache:HasMultiOwners())
end

function OwnerSelector:UpdateIcon()
    if not self.meta.profile.iconCharacter then
        self.portrait:SetTexture(self.meta.icon)
        self.portrait:SetTexCoord(0, 1, 0, 1)
    elseif self.meta:IsSelf() then
        SetPortraitTexture(self.portrait, 'player')
        self.portrait:SetTexCoord(0, 1, 0, 1)
    else
        local ownerInfo = Cache:GetOwnerInfo(self.meta.owner)
        if ownerInfo.race then
            local gender = ownerInfo.gender == 3 and 'FEMALE' or 'MALE'
            local race = ownerInfo.race:upper()
            local coords = ns.RACE_ICON_TCOORDS[race .. '_' .. gender]

            self.portrait:SetTexture([[Interface\Glues\CharacterCreate\UI-CharacterCreate-Races]])
            self.portrait:SetTexCoord(unpack(coords))
        elseif ownerInfo.faction == 'Alliance' then
            self.portrait:SetTexture([[Interface\Icons\inv_bannerpvp_02]])
            self.portrait:SetTexCoord(0, 1, 0, 1)
        else
            self.portrait:SetTexture([[Interface\Icons\inv_bannerpvp_01]])
            self.portrait:SetTexCoord(0, 1, 0, 1)
        end
    end
end

function OwnerSelector:CreateMenu()
    local menuList = {}
    for _, owner in ipairs(Cache:GetOwners()) do
        tinsert(menuList, self:CreateOwnerMenu(owner))
    end
    return menuList
end

function OwnerSelector:CreateOwnerMenu(name)
    local isSelf = ns.IsSelf(name)
    if isSelf then
        name = nil
    end
    local isCurrent = name == self.meta.owner
    local hasArrow = not isSelf and not isCurrent
    local info = Cache:GetOwnerInfo(name)

    return {
        text = ns.GetOwnerColoredName(info),
        checked = isCurrent,
        hasArrow = hasArrow,
        menuList = hasArrow and {
            {
                notCheckable = true,
                text = DELETE,
                func = function()
                    Cache:DeleteOwnerInfo(name)
                    self:CloseMenu()
                end,
            },
        },
        func = function()
            return self.meta:SetOwner(name)
        end,
    }
end
