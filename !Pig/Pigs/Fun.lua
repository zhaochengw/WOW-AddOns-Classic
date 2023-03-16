local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
-------------
-- ContainerIDToInventoryID = ContainerIDToInventoryID or (C_Container and C_Container.ContainerIDToInventoryID)
-- GetContainerItemInfo=GetContainerItemInfo or (C_Container and C_Container.GetContainerItemInfo)
-- GetContainerItemID = GetContainerItemID or (C_Container and C_Container.GetContainerItemID)
-- GetContainerItemLink = GetContainerItemLink or (C_Container and C_Container.GetContainerItemLink)
-- GetContainerNumFreeSlots = GetContainerNumFreeSlots or (C_Container and C_Container.GetContainerNumFreeSlots)
-- GetContainerNumSlots = GetContainerNumSlots or (C_Container and C_Container.GetContainerNumSlots)
-- PickupContainerItem = PickupContainerItem or (C_Container and C_Container.PickupContainerItem)
-- SplitContainerItem = SplitContainerItem or (C_Container and C_Container.SplitContainerItem)
-- SortBags = SortBags or (C_Container and C_Container.SortBags)
-- SortBankBags = SortBankBags or (C_Container and C_Container.SortBankBags)
-- SortReagentBankBags = SortReagentBankBags or (C_Container and C_Container.SortReagentBankBags)
-- SetItemSearch = SetItemSearch or (C_Container and C_Container.SetItemSearch)
-- GetBagSlotFlag = GetBagSlotFlag or (C_Container and C_Container.GetBagSlotFlag)
-- SetBagSlotFlag = SetBagSlotFlag or (C_Container and C_Container.SetBagSlotFlag)
-- GetBankBagSlotFlag = GetBankBagSlotFlag or (C_Container and C_Container.GetBankBagSlotFlag)
-- SetBankBagSlotFlag = SetBankBagSlotFlag or (C_Container and C_Container.SetBankBagSlotFlag)
-- GetBackpackAutosortDisabled = GetBackpackAutosortDisabled or (C_Container and C_Container.GetBackpackAutosortDisabled)
-- GetBankAutosortDisabled = GetBankAutosortDisabled or (C_Container and C_Container.GetBankAutosortDisabled)
-- GetContainerItemCooldown = GetContainerItemCooldown or (C_Container and C_Container.GetContainerItemCooldown)
-- SetBackpackAutosortDisabled = SetBackpackAutosortDisabled or (C_Container and C_Container.SetBackpackAutosortDisabled)
-- SetInsertItemsLeftToRight = SetInsertItemsLeftToRight or (C_Container and C_Container.SetInsertItemsLeftToRight)
-- GetInsertItemsLeftToRight = GetInsertItemsLeftToRight or (C_Container and C_Container.GetInsertItemsLeftToRight)
-- UseContainerItem = UseContainerItem or (C_Container and C_Container.UseContainerItem)
function table.removekey(table, key)
    local element = table[key]
    table[key] = nil
    return element
end
function PIG_print(msg)
	print("|cff00FFFF!Pig:|r|cffFFFF00"..msg.."！|r");
end
----
local OLD_SetRotation=SetRotation
function PIGRotation(self,dushu)
	local angle = math.rad(dushu)
	self:SetRotation(angle)
end

function PIGEnable(self)
	self:Enable() self.Text:SetTextColor(1, 1, 1, 1) 
end
function PIGDisable(self)
	self:Disable() self.Text:SetTextColor(0.4, 0.4, 0.4, 1) 
end
---
if tocversion<40000 then
	PIG_InviteUnit=InviteUnit
else
	PIG_InviteUnit=C_PartyInfo.InviteUnit
	--PIG_InviteUnit=C_PartyInfo.ConfirmInviteUnit
end