-- BagToggle.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/20/2019, 2:30:12 AM

---- LUA
local select = select
local tinsert = table.insert
local format = string.format

---- WOW
local PlaySound = PlaySound
local IsAltKeyDown = IsAltKeyDown
local IsControlKeyDown = IsControlKeyDown

---- UI
local GameTooltip = GameTooltip

---- G
local BAGSLOTTEXT = BAGSLOTTEXT

---@type ns
local ns = select(2, ...)
local L = ns.L
local Addon = ns.Addon
local BAG_ID = ns.BAG_ID

---@type tdBag2BagToggle
local BagToggle = ns.Addon:NewClass('UI.BagToggle', ns.UI.MenuButton)

function BagToggle:Constructor(_, meta)
    self.meta = meta
    self:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', self.OnLeave)
end

function BagToggle:OnClick(button)
    if button == 'LeftButton' then
        self.meta:ToggleOption('bagFrame')
        self:OnEnter()
        ns.PlayToggleSound(self.meta.profile.bagFrame)
    elseif IsControlKeyDown() then
        Addon:ToggleOwnerFrame(BAG_ID.MAIL, self.meta.owner)
    elseif IsAltKeyDown() then
        local bagId = self.meta:IsBag() and BAG_ID.BANK or BAG_ID.BAG
        Addon:ToggleOwnerFrame(bagId, self.meta.owner)
    else
        self:ToggleMenu()
    end
end

function BagToggle:CreateMenu()
    if not self.menuTable then
        local menuTable = {}

        local function addNode(bagId, text)
            tinsert(menuTable, {
                text = text,
                notCheckable = true,
                func = function()
                    return Addon:ToggleOwnerFrame(bagId, self.meta.owner)
                end,
            })
        end

        if not self.meta:IsBag() then
            addNode(BAG_ID.BAG, format('%s |cffffd100(%s)|r', L.TOOLTIP_TOGGLE_BAG, L.HOTKEY_ALT_RIGHT))
        end
        if not self.meta:IsBank() then
            addNode(BAG_ID.BANK, format('%s |cffffd100(%s)|r', L.TOOLTIP_TOGGLE_BANK, L.HOTKEY_ALT_RIGHT))
        end
        if not self.meta:IsMail() then
            addNode(BAG_ID.MAIL, format('%s |cffffd100(%s)|r', L.TOOLTIP_TOGGLE_MAIL, L.HOTKEY_CTRL_RIGHT))
        end
        if not self.meta:IsEquip() then
            addNode(BAG_ID.EQUIP, L.TOOLTIP_TOGGLE_EQUIP)
        end
        self.menuTable = menuTable
    end
    return self.menuTable
end

function BagToggle:OnEnter()
    ns.AnchorTooltip(self)
    GameTooltip:SetText(BAGSLOTTEXT)
    if self.meta.profile.bagFrame then
        GameTooltip:AddLine(ns.LeftButtonTip(L.TOOLTIP_HIDE_BAG_FRAME))
    else
        GameTooltip:AddLine(ns.LeftButtonTip(L.TOOLTIP_SHOW_BAG_FRAME))
    end
    GameTooltip:AddLine(ns.RightButtonTip(L.TOOLTIP_TOGGLE_OTHER_FRAME))
    GameTooltip:Show()
end

function BagToggle:OnLeave()
    GameTooltip:Hide()
end
