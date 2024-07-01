-- Bag.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https:\dengsir.github.io
-- @Date   : 10\17\2019, 3:23:57 PM
--
---- WOW
local CursorCanGoInSlot = CursorCanGoInSlot
local CursorHasItem = CursorHasItem
local IsInventoryItemLocked = IsInventoryItemLocked
local PickupBagFromSlot = PickupBagFromSlot
local PlaySound = PlaySound
local PutItemInBackpack = PutItemInBackpack
local PutItemInBag = PutItemInBag
local PutKeyInKeyRing = PutKeyInKeyRing

local SetItemButtonDesaturated = SetItemButtonDesaturated
local SetItemButtonTexture = SetItemButtonTexture
local SetItemButtonTextureVertexColor = SetItemButtonTextureVertexColor
local SetTooltipMoney = SetTooltipMoney
local StaticPopup_Show = StaticPopup_Show

---- UI
local GameTooltip = GameTooltip
local BankFrame = BankFrame

---- G
local BACKPACK_TOOLTIP = BACKPACK_TOOLTIP
local BANK = BANK
local BANK_BAG = BANK_BAG
local BANK_BAG_PURCHASE = BANK_BAG_PURCHASE
local EQUIP_CONTAINER = EQUIP_CONTAINER

---@type ns
local ns = select(2, ...)
local L = ns.L
local Addon = ns.Addon
local Cache = ns.Cache

---@class UI.Bag: EventsMixin, Object, Button, tdBag2BagTemplate
local Bag = ns.Addon:NewClass('UI.Bag', 'Button')

function Bag:Constructor(_, meta, bag)
    ---@type FrameMeta
    self.meta = meta
    self.bag = bag

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.UnregisterAllEvents)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', self.OnLeave)
    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnDragStart', self.OnDragStart)
    self:SetScript('OnReceiveDrag', self.OnClick)

    if self:IsVisible() then
        self:OnShow()
    end
end

function Bag:OnShow()
    self:Update()
    self:UnregisterAllEvents()
    self:RegisterFrameEvent('OWNER_CHANGED', 'Update')
    self:RegisterEvent('BAG_UPDATE')
    self:RegisterEvent('UPDATE_ALL', 'Update')

    if self:IsBank() or self:IsBankBag() then
        self:RegisterEvent('BANK_OPENED', 'OnShow')
        self:RegisterEvent('BANK_CLOSED', 'OnShow')
    end

    if self:IsCustomBag() then
        if not self.info.cached then
            self:RegisterEvent('BAG_LOCK_CHANGED')
            self:RegisterEvent('CURSOR_CHANGED', 'UpdateCursor')

            if not self.info.owned and self:IsBankBag() then
                self:RegisterEvent('PLAYERBANKBAGSLOTS_CHANGED', 'Update')
            end
        end
    end
end

function Bag:OnEnter()
    self:UpdateTooltip()
    Addon:FocusBag(self.bag)
end

function Bag:OnLeave()
    GameTooltip:Hide()
    Addon:FocusBag(nil)
end

function Bag:OnClick(button)
    if button == 'RightButton' then
        self.meta:ToggleBagHidden(self.bag)
        ns.PlayToggleSound(not self:IsHidden())
    else
        if self:IsPurchasable() then
            BankFrame.nextSlotCost = self.info.cost
            StaticPopup_Show('CONFIRM_BUY_BANK_SLOT')
            BankFrame.nextSlotCost = nil
        elseif CursorHasItem() and not self.info.cached then
            if self:IsBackpack() then
                PutItemInBackpack()
            elseif self:IsKeyring() then
                PutKeyInKeyRing()
            elseif self.info.slot then
                PutItemInBag(self.info.slot)
            end
        end
    end
end

function Bag:OnDragStart()
    if self:IsCustomBag() and not self.info.cached then
        PlaySound(862) -- SOUNDKIT.IG_BACKPACK_OPEN
        PickupBagFromSlot(self.info.slot)
    end
end

function Bag:BAG_UPDATE(_, bag)
    if self.bag == bag then
        self:Update()
    end
end

function Bag:BAG_LOCK_CHANGED(_, bag)
    if self.bag == bag then
        self:UpdateLock()
    end
end

function Bag:SetIcon(icon)
    if not self.Icon then
        return
    end
    local color = self.info.owned and 1 or .1
    SetItemButtonTexture(self, icon)
    SetItemButtonTextureVertexColor(self, 1, color, color)
end

function Bag:Update()
    self:UpdateInfo()
    self:UpdateIcon()
    self:UpdateCount()
    self:UpdateLock()
    self:UpdateCursor()
    self:UpdateHidden()
end

function Bag:UpdateInfo()
    self.info = Cache:GetBagInfo(self.meta.owner, self.bag)
end

function Bag:UpdateIcon()
    if self:IsKeyring() then
        -- self:SetIcon([[Interface\ContainerFrame\Keyring-Bag-Icon]])
    elseif self:IsBaseBag() then
        self:SetIcon(self.meta.icon)
    else
        self:SetIcon(self.info.icon or [[Interface\PaperDoll\UI-PaperDoll-Slot-Bag]])
    end
end

function Bag:UpdateCount()
    if not self.Count then
        return
    end
    local free = self:GetFreeCount()
    self.Count:SetText(free and free > 0 and free or '')
end

function Bag:UpdateLock()
    if self:IsCustomBag() then
        SetItemButtonDesaturated(self, self:IsLocked())
    end
end

function Bag:UpdateCursor()
    if self:IsCustomBag() then
        if not self.info.cached and CursorCanGoInSlot(self.info.slot) then
            self:LockHighlight()
        else
            self:UnlockHighlight()
        end
    end
end

function Bag:UpdateHidden()
    local obj = self.Icon or self:GetNormalTexture()
    if self:IsHidden() then
        obj:SetAlpha(0.4)
    else
        obj:SetAlpha(1)
    end
end

function Bag:UpdateTooltip()
    ns.AnchorTooltip(self)
    if self:IsPurchasable() then
        GameTooltip:SetText(BANK_BAG_PURCHASE, 1, 1, 1)
        SetTooltipMoney(GameTooltip, self.info.cost)
    elseif self:IsBackpack() then
        GameTooltip:SetText(BACKPACK_TOOLTIP, 1, 1, 1)
    elseif self:IsBank() then
        GameTooltip:SetText(BANK, 1, 1, 1)
    elseif self:IsKeyring() then
        GameTooltip:SetText(KEYRING, 1, 1, 1)
    elseif self.info.link and self.info.cached then
        GameTooltip:SetHyperlink(self.info.link)
    elseif self.info.link then
        GameTooltip:SetInventoryItem('player', self.info.slot)
    elseif self:IsBankBag() then
        GameTooltip:SetText(BANK_BAG, 1, 1, 1)
    else
        GameTooltip:SetText(EQUIP_CONTAINER, 1, 1, 1)
    end

    GameTooltip:AddLine(' ')

    if self:IsPurchasable() then
        GameTooltip:AddLine(ns.LeftButtonTip(L.TOOLTIP_PURCHASE_BANK_SLOT))
    end

    GameTooltip:AddLine(ns.RightButtonTip(self:IsHidden() and L.TOOLTIP_SHOW_BAG or L.TOOLTIP_HIDE_BAG))
    GameTooltip:Show()
end

function Bag:IsLocked()
    if self.info.cached or not self.info.slot then
        return false
    end
    return IsInventoryItemLocked(self.info.slot)
end

function Bag:GetFreeCount()
    if not self.info.owned then
        return
    end
    if not self.info.cached then
        return self.info.free
    end
    if not self.info.count then
        return 0
    end
    return self.info.free
end

function Bag:IsPurchasable()
    return not self.info.cached and not self.info.owned
end

function Bag:IsBaseBag()
    return self:IsBackpack() or self:IsBank() or self:IsKeyring()
end

function Bag:IsBackpack()
    return ns.IsBackpack(self.bag)
end

function Bag:IsBank()
    return ns.IsBank(self.bag)
end

function Bag:IsKeyring()
    return ns.IsKeyring(self.bag)
end

function Bag:IsBackpackBag()
    return not self:IsBackpack() and not self:IsKeyring() and ns.IsInBag(self.bag)
end

function Bag:IsBankBag()
    return not self:IsBank() and ns.IsInBank(self.bag)
end

function Bag:IsCustomBag()
    return self:IsBackpackBag() or self:IsBankBag()
end

function Bag:IsHidden()
    return self.meta:IsBagHidden(self.bag)
end
