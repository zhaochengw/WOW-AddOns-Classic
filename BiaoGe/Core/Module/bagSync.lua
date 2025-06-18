local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local Size = ns.Size
local RGB = ns.RGB
local RGB_16 = ns.RGB_16
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local GetText_T = ns.GetText_T
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID
local GetClassName = ns.GetClassName
local FormatNumber = ns.FormatNumber
local CreateLine = ns.CreateLine
local SendSystemMessage = ns.SendSystemMessage
local ver = ns.ver
local VIP = ns.VIP
local After = C_Timer.After
local realmName = GetRealmName()
local player = UnitName("player")
local realmID = GetRealmID()

local pt = print

BG.Init(function()
    -- 背包
    BiaoGe.bag = BiaoGe.bag or {}
    BiaoGe.bag[realmID] = BiaoGe.bag[realmID] or {}
    BiaoGe.bag[realmID][player] = BiaoGe.bag[realmID][player] or {}
    BiaoGe.bag[realmID][player].bag = BiaoGe.bag[realmID][player].bag or {}
    BiaoGe.bag[realmID][player].bagKey = BiaoGe.bag[realmID][player].bagKey or {}
    BiaoGe.bag[realmID][player].bank = BiaoGe.bag[realmID][player].bank or {}
    BiaoGe.bag[realmID][player].mail = BiaoGe.bag[realmID][player].mail or {}

    local function GetBagSlots(bagType)
        if bagType == "bag" then
            if BG.IsRetail then
                return BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS
            else
                return BACKPACK_CONTAINER, BACKPACK_CONTAINER + NUM_BAG_SLOTS
            end
        elseif bagType == "bank" then
            if BG.IsRetail then
                return NUM_TOTAL_EQUIPPED_BAG_SLOTS + 1, NUM_TOTAL_EQUIPPED_BAG_SLOTS + NUM_BANKBAGSLOTS
            else
                return NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS
            end
        end
    end

    local function SaveFormBagNum(b, bagType)
        for i = 1, C_Container.GetContainerNumSlots(b) do
            local info = C_Container.GetContainerItemInfo(b, i)
            if info then
                BiaoGe.bag[realmID][player][bagType][info.itemID] =
                    (BiaoGe.bag[realmID][player][bagType][info.itemID] or 0) + info.stackCount
            end
        end
    end
    function BG.SaveBag()
        wipe(BiaoGe.bag[realmID][player].bag)
        wipe(BiaoGe.bag[realmID][player].bagKey)
        local startB, endB = GetBagSlots("bag")
        for b = startB, endB do
            SaveFormBagNum(b, "bag")
        end
        SaveFormBagNum(-2, "bagKey")
    end

    function BG.SaveBank()
        if not BG.bankIsOpen then return end
        wipe(BiaoGe.bag[realmID][player].bank)
        local startB, endB = GetBagSlots("bank")
        for b = startB, endB do
            SaveFormBagNum(b, "bank")
        end
        SaveFormBagNum(-1, "bank")
    end

    function BG.SaveMail()
        wipe(BiaoGe.bag[realmID][player].mail)
        for mailIndex = 1, GetInboxNumItems() do
            local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft,
            hasItem = GetInboxHeaderInfo(mailIndex)
            if CODAmount <= 0 then
                if hasItem then
                    for itemIndex = 1, ATTACHMENTS_MAX_RECEIVE do
                        local name, itemID, texture, count, quality = GetInboxItem(mailIndex, itemIndex)
                        if itemID then
                            BiaoGe.bag[realmID][player].mail[itemID] =
                                (BiaoGe.bag[realmID][player].mail[itemID] or 0) + count
                        end
                    end
                end
            end
        end
    end

    function BG.GetItemBagCount(tbl, itemID)
        return (tbl.bag and tbl.bag[itemID] or 0)
            + (tbl.bagKey and tbl.bagKey[itemID] or 0)
            + (tbl.bank and tbl.bank[itemID] or 0)
            + (tbl.mail and tbl.mail[itemID] or 0)
    end

    local f = CreateFrame("Frame")
    f:RegisterEvent("BAG_UPDATE_DELAYED")
    f:RegisterEvent("BANKFRAME_OPENED")
    f:RegisterEvent("BANKFRAME_CLOSED")
    f:RegisterEvent("MAIL_INBOX_UPDATE")
    f:SetScript("OnEvent", function(self, event, ...)
        if event == "BAG_UPDATE_DELAYED" then
            BG.SaveBag()
            BG.SaveBank()
        elseif event == "BANKFRAME_OPENED" then
            BG.bankIsOpen = true
            BG.SaveBank()
        elseif event == "BANKFRAME_CLOSED" then
            BG.bankIsOpen = false
        elseif event == "MAIL_INBOX_UPDATE" then
            BG.SaveMail()
        end
    end)


    -- 声望
    if not BG.IsRetail then
        BiaoGe.bag[realmID][player].faction = BiaoGe.bag[realmID][player].faction or {}

        local function SaveReputation()
            for _, ID in ipairs(BG.factionTbl) do
                local name, description, standingID, barMin, barMax, barValue = GetFactionInfoByID(ID)
                if name then
                    BiaoGe.bag[realmID][player].faction[ID] = {
                        name = name,
                        standingID = standingID,
                        currentValue = barValue - barMin,
                        maxValue = barMax - barMin,
                        factionID = ID,
                    }
                end
            end
        end

        BG.Init2(function()
            After(10, function()
                SaveReputation()
            end)
        end)

        BG.RegisterEvent("UPDATE_FACTION", function(self, event)
            After(.5, function()
                SaveReputation()
            end)
        end)
    end
end)
