-- BuyEmAll Classic

BuyEmAll = {}

local L = BUYEMALL_LOCALS;

-- These are used for the text on the Max and Stack buttons. See BuyEmAll.xml.
BUYEMALL_MAX = L.MAX;
BUYEMALL_STACK = L.STACK;

-- It's ALIVE!!! Muahahahahhahahaa!!!!!
function BuyEmAll:OnLoad()
    -- Set up confirmation dialog.
    StaticPopupDialogs["BUYEMALL_CONFIRM"] = {
        preferredIndex = 3,
        text = L.CONFIRM,
        button1 = YES,
        button2 = NO,
        OnAccept = function(dialog) self:DoPurchase(dialog.data) end,
        timeout = 0,
        hideOnEscape = true,
    };
    self.ConfirmNoItemLink = 0;
    StaticPopupDialogs["BUYEMALL_CONFIRM2"] = {
        preferredIndex = 3,
        text = L.CONFIRM,
        button1 = YES,
        button2 = NO,
        OnAccept = function(dialog) BuyMerchantItem(self.ConfirmNoItemLink) end,
        timeout = 0,
        hideOnEscape = true,
    };

    -- Clear textures and text to prevent pink textures.
    BuyEmAllCurrency1:SetTexture();
    BuyEmAllCurrency2:SetTexture();
    BuyEmAllCurrency3:SetTexture();
    BuyEmAllCurrencyAmt1:SetText();
    BuyEmAllCurrencyAmt2:SetText();
    BuyEmAllCurrencyAmt3:SetText();

    self.OrigMerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick;
    MerchantItemButton_OnModifiedClick = function(frame, button)
        self:MerchantItemButton_OnModifiedClick(frame, button);
    end

    self.OrigMerchantFrame_OnHide = MerchantFrame:GetScript("OnHide");
    MerchantFrame:SetScript("OnHide", function(...)
        return self:MerchantFrame_OnHide(...);
    end)

    SLASH_BUYEMALL1 = "/buyemall"
    SlashCmdList["BUYEMALL"] = function(message, editbox)
        BuyEmAll:SlashHandler(message);
    end
end

function BuyEmAll:SlashHandler(message, editbox)
    if (message == "") then
        print("BuyEmAll: Use /buyemall confirm to enable/disable the large purchase confirm.");
    elseif (message == "confirm") then
        if (BEAConfirmToggle == true) then
            BEAConfirmToggle = false;
            print("BuyEmAll: Large purchase confirm window disabled.");
        elseif (BEAConfirmToggle == false) then
            BEAConfirmToggle = true;
            print("BuyEmAll: Large purchase confirm window enabled.");
        end
    end
end

-- Variable setup/check.
local BEAframe = CreateFrame("FRAME", "BEAFrame");
BEAframe:Hide();
BEAframe:RegisterEvent("ADDON_LOADED");
local function eventHandler(self, event, ...)
    local arg1, arg2, arg3, arg4, arg5 = ...;
    if (event == "ADDON_LOADED") and (arg1 == "BuyEmAll") then
        if (BEAConfirmToggle == nil) then
            BEAConfirmToggle = true;
        elseif (BEAConfirmToggle == 0) then
            BEAConfirmToggle = false;
        elseif (BEAConfirmToggle == 1) then
            BEAConfirmToggle = true;
        end
    end
end

BEAframe:SetScript("OnEvent", eventHandler);

-- Makes sure the BuyEmAll frame goes away when you leave a vendor.
function BuyEmAll:MerchantFrame_OnHide(...)
    BuyEmAllFrame:Hide();
    return self.OrigMerchantFrame_OnHide(...);
end

-- Hooks left-clicks on merchant item buttons.
function BuyEmAll:MerchantItemButton_OnModifiedClick(frame, button)
    self.itemIndex = frame:GetID();

    if (MerchantFrame.selectedTab == 1)
            and (IsShiftKeyDown())
            and not (IsControlKeyDown())
            and not (ChatFrame1EditBox:HasFocus()) then
        -- Set up various data before showing the BuyEmAll frame.
        self.NPCName = UnitName("npc");
        self.AltCurrencyMode = false;
        self.AtVendor = true;

        local name, texture, price, quantity, numAvailable = GetMerchantItemInfo(self.itemIndex);
        local maxStack = GetMerchantItemMaxStack(self.itemIndex);
        self.itemName = name;
        self.price = price;
        self.preset = quantity;
        self.available = numAvailable;
        self.itemLink = GetMerchantItemLink(self.itemIndex);

        -- Bypass for purchasable things without an itemlink.
        if (self.itemLink == nil) then
            self.ConfirmNoItemLink = self.itemIndex;
            local dialog = StaticPopup_Show("BUYEMALL_CONFIRM2", quantity, self.itemName);
            return
        end

        -- Buying a currency with a currency!
        if ((strmatch(self.itemLink, "currency")) and (self.price == 0)) then
            local currencyID = tonumber(strmatch(self.itemLink, "currency:(%d+)"));
            if not currencyID then
                print("|cFFFF0000BuyEmAllClassic: 无效的货币链接: " .. tostring(self.itemLink) .. "|r");
                return;
            end
            local info = GetCurrencyInfo(currencyID);
            if not info or not info.maxQuantity then
                print("|cFFFF0000BuyEmAllClassic: 无法获取货币信息: " .. tostring(currencyID) .. "|r");
                return;
            end
            local totalMax = info.maxQuantity;
            if (totalMax == 0) then
                self.fit = 10000000;
            elseif (totalMax > 0) then
                self.fit = totalMax;
            end
            self.stack = self.preset;
            self:AltCurrencyHandling(self.itemIndex, frame);
            return
        end

        if (strmatch(self.itemLink, "item")) then
            local _, itemID = strsplit(":", self.itemLink);
            itemID = tonumber(itemID);
            self.itemID = itemID;
            self.stack = maxStack;
            local bagMax = 0;
            for bag = 0, 4 do
                local numSlots = C_Container.GetContainerNumSlots(bag);
                for slot = 1, numSlots do
                    local Location = ItemLocation:CreateFromBagAndSlot(bag, slot);
                    if (Location and C_Item.DoesItemExist(Location)) then
                        local bagItemID = C_Item.GetItemID(Location);
                        if (bagItemID == itemID) then
                            local itemInfo = C_Container.GetContainerItemInfo(bag, slot);
                            bagMax = bagMax + maxStack - itemInfo.stackCount;
                        end
                    else
                        bagMax = bagMax + maxStack;
                    end
                end
            end
            self.fit = bagMax;
            self.partialFit = self.fit % self.stack;
        elseif (strmatch(self.itemLink, "currency")) then
            local currencyID = tonumber(strmatch(self.itemLink, "currency:(%d+)"));
            if not currencyID then
                print("|cFFFF0000BuyEmAllClassic: 无效的货币链接: " .. tostring(self.itemLink) .. "|r");
                return;
            end
            self.stack = self.preset;
            local maxAmount = select(6, GetCurrencyInfo(currencyID));
            if (maxAmount == 0) then
                self.fit = 10000000;
                self.partialFit = 0;
            end
            self.partialFit = maxAmount - select(2, GetCurrencyInfo(currencyID));
        end

        if ((select(8, GetMerchantItemInfo(self.itemIndex)) == true) and (self.price == 0)) then
            self:AltCurrencyHandling(self.itemIndex, frame);
            return
        end

        BuyEmAllCurrency1:SetTexture("Interface\\MONEYFRAME\\UI-GoldIcon");
        BuyEmAllCurrency2:SetTexture("Interface\\MONEYFRAME\\UI-SilverIcon");
        BuyEmAllCurrency3:SetTexture("Interface\\MONEYFRAME\\UI-CopperIcon");

        if (self.price == 0) then
            self.afford = self.fit;
        else
            self.afford = floor(GetMoney() / ceil(self.price / self.preset));
        end

        self.max = min(self.fit, self.afford);
        if (numAvailable > -1) then
            self.max = min(self.max, numAvailable);
        end
        if (self.max == 0) then
            return
        elseif (self.max == 1) then
            MerchantItemButton_OnClick(frame, "LeftButton");
            return
        end

        self.defaultStack = quantity;
        self.split = 1;

        self:SetStackClick();
        self:Show(frame);
    else
        self.OrigMerchantItemButton_OnModifiedClick(frame, button);
    end
end

-- Processor for Alternate Currencies.
function BuyEmAll:AltCurrencyHandling(itemIndex, frame)
    self.AltCurrencyMode = true;

    self.NumAltCurrency = GetMerchantItemCostInfo(itemIndex);

    self.AltCurrTex = {};
    self.AltCurrPrice = {};
    self.AltCurrAfford = {};

    for i = 1, self.NumAltCurrency do
        local texture, amount, link = GetMerchantItemCostItem(itemIndex, i);
        self.AltCurrPrice[i] = amount;
        local Link = link;
        if not self.AltCurrPrice[i] then
            print("|cFFFF0000BuyEmAllClassic: 无法获取货币价格: index=" .. i .. ", itemIndex=" .. itemIndex .. "|r");
            return;
        end
        if (strmatch(Link, "currency")) then
            local currencyID = tonumber(strmatch(Link, "currency:(%d+)"));
            if not currencyID then
                print("|cFFFF0000BuyEmAllClassic: 无效的货币链接: " .. tostring(Link) .. "|r");
                return;
            end
            local info = GetCurrencyInfo(currencyID);
            if not info then
                print("|cFFFF0000BuyEmAllClassic: 无法获取货币信息: " .. tostring(currencyID) .. "|r");
                return;
            end
            self.AltCurrTex[i] = texture;
            self.AltCurrAfford[i] = floor(info.quantity / self.AltCurrPrice[i]) * self.preset;
        else
            self.AltCurrTex[i] = texture;
            self.AltCurrAfford[i] = floor((GetItemCount(tonumber(strmatch(Link, "item:(%d+):")), true)) / self.AltCurrPrice[i]) * self.preset;
        end
    end

    if (self.NumAltCurrency == 1) then
        self.afford = self.AltCurrAfford[1];
    else
        self.afford = min(self.AltCurrAfford[1], self.AltCurrAfford[2] or 999999, self.AltCurrAfford[3] or 999999);
    end

    self.max = min(self.fit, self.afford);

    if (self.available > -1) then
        self.max = min(self.max, self.available * self.preset);
    end

    if (self.max == 0) then
        return
    elseif (self.max == 1) then
        MerchantItemButton_OnClick(frame, "LeftButton");
        return
    end

    self.defaultStack = self.preset;
    self.split = self.defaultStack;

    self.partialFit = self.fit % self.stack;
    self:SetStackClick();

    self.NPCName = UnitName("npc");
    self.ItemName = select(1, GetMerchantItemInfo(self.itemIndex));

    self:Show(frame);
end

-- Prepare the various UI elements of the BuyEmAll frame and show it.
function BuyEmAll:Show(frame)
    self.typing = false;
    BuyEmAllLeftButton:Disable();
    BuyEmAllRightButton:Enable();

    BuyEmAllStackButton:Enable();
    if (self.max < self.stackClick) then
        BuyEmAllStackButton:Disable();
    end

    BuyEmAllFrame:ClearAllPoints();
    BuyEmAllFrame:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0);

    BuyEmAllFrame:Show(frame);
    self:UpdateDisplay();
end

-- If the amount is more than stack and defaultStack, show a confirmation. Otherwise, do the purchase.
function BuyEmAll:VerifyPurchase(amount)
    amount = amount or self.split;

    if (self.AltCurrencyMode == true) then
        amount = self:AltCurrRounding(amount);
    end

    if (amount > 0) then
        if (amount > self.stack) and (amount > self.defaultStack) then
            if (BEAConfirmToggle == true) then
                self:DoConfirmation(amount);
            else
                self:DoPurchase(amount);
            end
        else
            self:DoPurchase(amount);
        end
    end
end

-- The outer layers of this code are from Treeston on the MMO-Champion forums, and modified to suit my needs.
local framePurchAmount, frameNumLoops, frameLeftover = 0, 0, 0;
local frameItemIndex;

local PurchaseLoopFrame = CreateFrame("Frame");
function BuyEmAll:onUpdate(sinceLastUpdate)
    self.sinceLastUpdate = (self.sinceLastUpdate or 0) + sinceLastUpdate;
    if (self.sinceLastUpdate >= 0.1) then
        if (frameNumLoops == 0) and (frameLeftover == 0) then
            PurchaseLoopFrame:SetScript("OnUpdate", nil);
            return
        end
        if (frameNumLoops == 0) and (frameLeftover ~= 0) then
            BuyMerchantItem(frameItemIndex, frameLeftover);
            frameLeftover = 0;
        elseif (frameNumLoops > 0) then
            BuyMerchantItem(frameItemIndex, framePurchAmount);
            frameNumLoops = frameNumLoops - 1;
        end
        self.sinceLastUpdate = 0;
    end
end

-- Makes the actual purchase(s)
function BuyEmAll:DoPurchase(amount)
    BuyEmAllFrame:Hide();
    if (strmatch(self.itemLink, "currency")) then
        BuyMerchantItem(self.itemIndex, amount);
        return;
    end

    local effectiveAmount = math.floor(amount / self.stack) * self.stack;
    local leftover = amount % self.stack;

    framePurchAmount = self.stack;
    frameNumLoops = math.floor(effectiveAmount / self.stack);
    frameLeftover = leftover;
    frameItemIndex = self.itemIndex;

    PurchaseLoopFrame:SetScript("OnUpdate", BuyEmAll.onUpdate);
end

-- Rounds the alternate currency purchase amount, if needed, to the nearest multiple of the preset stack.
function BuyEmAll:AltCurrRounding(purchase)
    local singleCost = 0;
    local amount = purchase;
    for i = 1, self.NumAltCurrency do
        if (self.AltCurrPrice[i] == 1) then
            singleCost = 1;
        end
    end
    if (singleCost) then
        if ((purchase % self.preset) < (self.preset / 2)) then
            amount = purchase - (purchase % self.preset);
            return amount;
        elseif ((purchase % self.preset) >= (self.preset / 2)) then
            amount = purchase + (self.preset - (purchase % self.preset));
            return amount;
        end
    else
        return amount;
    end 
end

-- Changes the money display to however much amount of the item will cost.
function BuyEmAll:UpdateDisplay()
    BuyEmAllLeftButton:Enable();
    BuyEmAllRightButton:Enable();
    BuyEmAllMaxButton:Enable();
    if (self.split == self.max) then
        BuyEmAllRightButton:Disable();
        BuyEmAllMaxButton:Disable();
    end
    if (self.AltCurrencyMode == false) and (self.split == 1) then
        BuyEmAllLeftButton:Disable();
    end
    if (self.AltCurrencyMode == true) and (self.split == self.preset) then
        BuyEmAllLeftButton:Disable();
    end

    self:SetStackClick();
    BuyEmAllStackButton:Enable();
    if (self.max < self.stackClick) then
        BuyEmAllStackButton:Disable();
    end

    local purchase = self.split;

    if (self.AltCurrencyMode == false) then
        local cost = 0;
        if (self.defaultStack > 1) then
            cost = purchase * (self.price / self.defaultStack);
        else
            cost = purchase * self.price;
        end
        cost = ceil(cost);
        local gold = floor(abs(cost / 10000));
        local silver = floor(abs(mod(cost / 100, 100)));
        local copper = floor(abs(mod(cost, 100)));

        BuyEmAllCurrencyAmt1:SetText(gold);
        BuyEmAllCurrencyAmt2:SetText(silver);
        BuyEmAllCurrencyAmt3:SetText(copper);
    elseif (self.AltCurrencyMode == true) then
        local amount = self:AltCurrRounding(purchase);
        self.AltNumPurchases = amount / self.preset;

        BuyEmAllCurrencyAmt1:SetText(self.AltNumPurchases * self.AltCurrPrice[1]);
        BuyEmAllCurrency1:SetTexture(self.AltCurrTex[1]);
        BuyEmAllCurrencyAmt2:SetText(self.AltNumPurchases * (self.AltCurrPrice[2] or 0));
        BuyEmAllCurrency2:SetTexture(self.AltCurrTex[2]);
        if (self.AltCurrPrice[2] == nil) then BuyEmAllCurrencyAmt2:SetText() end
        BuyEmAllCurrencyAmt3:SetText(self.AltNumPurchases * (self.AltCurrPrice[3] or 0));
        BuyEmAllCurrency3:SetTexture(self.AltCurrTex[3]);
        if (self.AltCurrPrice[2] == nil) then BuyEmAllCurrencyAmt3:SetText() end
    end

    BuyEmAllText:SetText(self.split);
end

-- Shows the confirmation dialog.
function BuyEmAll:DoConfirmation(amount)
    local dialog = StaticPopup_Show("BUYEMALL_CONFIRM", amount, self.itemName);
    dialog.data = amount;
end

-- Calculates the amount that the Stack button will enter.
function BuyEmAll:SetStackClick()
    local increase = (self.partialFit == 0 and self.stack or self.partialFit) - (self.split % self.stack);
    self.stackClick = self.split + (increase == 0 and self.stack or increase);
end

function BuyEmAll:DeStackClick()
    local decrease = tonumber(BuyEmAllText:GetText());
    if (decrease <= self.stack) then
        self.split = 1;
        self:UpdateDisplay();
    else
        self.split = decrease - self.stack;
        self:UpdateDisplay();
    end
end

-- OnClick handler for the four main buttons.
function BuyEmAll:OnClick(frame, button)
    if (frame == BuyEmAllOkayButton) then
        local amount = tonumber(BuyEmAllText:GetText());
        self:VerifyPurchase(amount);
    elseif (frame == BuyEmAllCancelButton) then
        BuyEmAllFrame:Hide();
    elseif (frame == BuyEmAllStackButton) then
        if (button == "LeftButton") then
            self.split = self.stackClick;
            self:UpdateDisplay();
            if (frame:IsEnabled() == true) then
                self:OnEnter(frame);
            else
                GameTooltip:Hide();
            end
        elseif (button == "RightButton") then
            self:DeStackClick();
            self:UpdateDisplay();
            if (frame:IsEnabled() == true) then
                self:OnEnter(frame);
            else
                GameTooltip:Hide();
            end
        end
    elseif (frame == BuyEmAllMaxButton) then
        self.split = self.max;
        self:UpdateDisplay();
    end
end

-- Allows you to type a number to buy.
function BuyEmAll:OnChar(text)
    if (text < "0") or (text > "9") then
        return
    end

    if (self.typing == false) then
        self.typing = true;
        self.split = 0;
    end

    local input = (self.split * 10) + text;

    if (input == self.split) then
        if (self.split == 0) then
            self.split = 1;
        end
        self:UpdateDisplay();
        return
    end
    if (input <= self.max) then
        self.split = input;
    elseif (input > self.max) then
        self.split = self.max;
    elseif (input <= 0) then
        self.split = 1;
    end
    self:UpdateDisplay();
end

-- Key handler for keys other than 0-9.
function BuyEmAll:OnKeyDown(key)
    if (key == "BACKSPACE") or (key == "DELETE") then
        if (self.typing == false) or (self.split == 1) then
            return
        end

        self.split = floor(self.split / 10);
        if (self.split <= 1) then
            self.split = 1;
            self.typing = false;
        end

        self:UpdateDisplay();
    elseif (key == "ENTER") then
        self:VerifyPurchase();
    elseif (key == "ESCAPE") then
        BuyEmAllFrame:Hide();
    elseif (key == "LEFT") or (key == "DOWN") then
        BuyEmAll:Left_Click();
    elseif (key == "RIGHT") or (key == "UP") then
        BuyEmAll:Right_Click();
    elseif (key == "PRINTSCREEN") then
        Screenshot();
    end
end

-- Decreases the amount by however much is necessary to go down to the next lowest multiple of the preset stack size.
function BuyEmAll:Left_Click()
    if (self.AltCurrencyMode == false) then
        self.split = self.split - 1;
        self:UpdateDisplay();
    else
        self.split = self.split - self.preset;
        self:UpdateDisplay();
    end
end

-- Increases the amount by however much is necessary to go up to the next highest multiple of the preset stack size.
function BuyEmAll:Right_Click()
    if (self.AltCurrencyMode == false) then
        self.split = self.split + 1;
        self:UpdateDisplay();
    else
        self.split = self.split + self.preset;
        self:UpdateDisplay();
    end
end

-- This table is used for the two functions that follow.
BuyEmAll.lines = {
    stack = {
        label = L.STACK_PURCH,
        field = "stackClick",
        { label = L.STACK_SIZE, field = "stack" },
        { label = L.PARTIAL, field = "partialFit" },
    },
    max = {
        label = L.MAX_PURCH,
        field = "max",
        { label = L.AFFORD, field = "afford" },
        { label = L.FIT, field = "fit" },
        {
            label = L.AVAILABLE,
            field = "available",
            Hide = function()
                return BuyEmAll.available <= 1
            end
        },
    },
}

-- Shows tooltips when you hover over the Stack or Max buttons.
function BuyEmAll:OnEnter(frame)
    local lines = self.lines[frame == BuyEmAllMaxButton and "max" or "stack"];

    lines.amount = self[lines.field];
    for i, line in ipairs(lines) do
        line.amount = self[line.field];
    end

    self:CreateTooltip(frame, lines);
end

-- Creates the tooltip from the given lines table.
function BuyEmAll:CreateTooltip(frame, lines)
    GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMRIGHT");
    GameTooltip:SetText(lines.label .. "|cFFFFFFFF - |r" .. GREEN_FONT_COLOR_CODE .. lines.amount .. "|r");

    for _, line in ipairs(lines) do
        if not (line.Hide and line.Hide()) then
            local color =
            line.amount == lines.amount and GREEN_FONT_COLOR or HIGHLIGHT_FONT_COLOR;
            GameTooltip:AddDoubleLine(line.label, line.amount, 1, 1, 1, color.r, color.g, color.b);
        end
    end

    GameTooltip:Show();
end

-- Hides the tooltip.
function BuyEmAll:OnLeave()
    GameTooltip:Hide();
end

-- When the BuyEmAll frame is closed, close any confirmations waiting for a response as well as clear the currencies.
function BuyEmAll:OnHide()
    BuyEmAllCurrency1:SetTexture();
    BuyEmAllCurrency2:SetTexture();
    BuyEmAllCurrency3:SetTexture();
    BuyEmAllCurrencyAmt1:SetText();
    BuyEmAllCurrencyAmt2:SetText();
    BuyEmAllCurrencyAmt3:SetText();
    StaticPopup_Hide("BUYEMALL_CONFIRM");
end