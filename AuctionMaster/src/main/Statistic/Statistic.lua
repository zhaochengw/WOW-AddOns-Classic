--[[
	Gathers statistics for the auctions found.
	
	Copyright (C) Udorn (Blackhand)
	
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.	
--]]

vendor.Statistic = vendor.Vendor:NewModule("Statistic");
local L = vendor.Locale.GetInstance()
local AceEvent = LibStub("AceEvent-3.0")
local self = vendor.Statistic;
local log = vendor.Debug:new("Statistic")

--[[
	Returns avgMinBid, avgBuyout, minMinBid and minBuyout for the given scan result.
--]]
local function _GetAvgs(result, deactivateStdDev)
    local minBids = {};
    local buyouts = {};
    for i = 1, result:Size() do
        local itemLinkKey, time, timeLeft, count, minBid, minIncrement, buyout = result:Get(i);
        if (itemLinkKey) then
            if (minBid and minBid > 0) then
                table.insert(minBids, math.floor(minBid / count + 0.5));
            end
            if (buyout and buyout > 0) then
                table.insert(buyouts, math.floor(buyout / count + 0.5));
            end
        end
    end
    table.sort(minBids);
    table.sort(buyouts);
    if (not deactivateStdDev) then
        vendor.Math.CleanupByStandardDeviation(minBids, self.db.profile.smallerStdDevMul, self.db.profile.largerStdDevMul)
        vendor.Math.CleanupByStandardDeviation(buyouts, self.db.profile.smallerStdDevMul, self.db.profile.largerStdDevMul)
    end
    local avgMinBid = vendor.Math.GetMedian(minBids);
    local avgBuyout = vendor.Math.GetMedian(buyouts);
    local minMinBid = nil
    local minBuyout = nil
    if (table.getn(minBids) > 0) then
        minMinBid = minBids[1]
    end
    if (table.getn(buyouts) > 0) then
        minBuyout = buyouts[1]
    end
    return avgMinBid, avgBuyout, minMinBid, minBuyout;
end

--[[
	Appends the given money description to the tooltip
--]]
local function _AddMoney(self, tooltip, prompt, bid, buyout)
    local msg = vendor.Format.FormatMoney(bid, true) .. "/" .. vendor.Format.FormatMoney(buyout, true)
    tooltip:AddDoubleLine(prompt, msg)
end

--[[
	Initializes the module.
--]]
function vendor.Statistic:OnInitialize()
    self.db = vendor.Vendor.db:RegisterNamespace("Statistic", {
        profile = {
            movingAverage = 12,
            smallerStdDevMul = 2,
            largerStdDevMul = 2,
            showLower = true,
            showMedian = true,
        }
    });
    self.itemInfo = {} -- caching the table
end

--[[
	Initializes the module.
--]]
function vendor.Statistic:OnEnable()
    vendor.TooltipHook:AddAppender(self, 20);
    --	_ApplySettings(self)
end

--[[
	Callback for GameTooltip integration.
--]]
function vendor.Statistic:AppendToGameTooltip(tooltip, itemLink, itemName, count)
    local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink);
    if (itemLinkKey ~= nil) then
        local isNeutral = vendor.AuctionHouse:IsNeutral();
        local itemInfo = self.itemInfo

        local msg1, msg2, msg3, msg4
        local _, _, _, lowerBuyout, _, _, numAuctions, _, _, _, medianBuyout = vendor.Gatherer:GetCurrentAuctionInfo(itemLink, isNeutral, vendor.TooltipHook.db.profile.adjustCurrentPrices)
        local currentAuctions = numAuctions > 0 and lowerBuyout and lowerBuyout > 0
        if (currentAuctions) then
            if (count > 1) then
                if (self.db.profile.showLower) then
                    msg1 = L["Lower [%s](%d)"]:format(numAuctions, count)
                    msg2 = vendor.Format.FormatMoneyValues(lowerBuyout, lowerBuyout * count, true)
                end
                if (self.db.profile.showMedian) then
                    msg3 = L["Median [%s](%d)"]:format(numAuctions, count)
                    msg4 = vendor.Format.FormatMoneyValues(medianBuyout, medianBuyout * count, true)
                end
            else
                if (self.db.profile.showLower) then
                    msg1 = L["Lower [%s]"]:format(numAuctions)
                    msg2 = vendor.Format.FormatMoney(lowerBuyout, true)
                end
                if (self.db.profile.showMedian) then
                    msg3 = L["Median [%s]"]:format(numAuctions)
                    msg4 = vendor.Format.FormatMoney(medianBuyout, true)
                end
            end
            if (msg1) then
                tooltip:AddDoubleLine(msg1, msg2)
            end
            if (msg3) then
                tooltip:AddDoubleLine(msg3, msg4)
            end
        end
        if (not currentAuctions or vendor.TooltipHook.db.profile.compactMarketPrice) then
            local _, avgBuyout, numAuctions = vendor.Gatherer:GetAuctionInfo(itemLink, isNeutral, vendor.TooltipHook.db.profile.adjustCurrentPrices)
            if (numAuctions > 0 and avgBuyout and avgBuyout > 0) then
                msg1 = vendor.Format.GetFontColorCode(vendor.TooltipHook.db.profile.compactColor)
                if (count > 1) then
                    msg1 = msg1 .. L["Historic (%d)"]:format(count)
                    msg2 = vendor.Format.FormatMoneyValues(avgBuyout, avgBuyout * count, true)
                else
                    msg1 = msg1 .. L["Historic"]
                    msg2 = vendor.Format.FormatMoney(avgBuyout, true)
                end
                msg1 = msg1 .. FONT_COLOR_CODE_CLOSE
                tooltip:AddDoubleLine(msg1, msg2)
            end
        end
    end
end

--[[
	Returns avgMinBid, avgBuyout, minMinBid, minBuyout, numAuctions, lowerBuyoutOwner for the current 
	auctions for the specified item or nil. The results may be cleaned up
	by a standard deviation.
--]]
function vendor.Statistic:GetCurrentAuctionInfo(itemLink, isNeutral, deactivateStdDev)
    -- TODO std-dev
    local avgBid, avgBuyout, lowerBid, lowerBuyout, _, _, numAuctions, _, _, lowerBuyoutOwner = vendor.Gatherer:GetCurrentAuctionInfo(itemLink, isNeutral, not deactivateStdDev)
    log:Debug("itemLink %s avgBid [%s] avgBuyout [%s] lowerBid [%s] lowerBuyout [%s] numAuctions [%s] lowerBuyoutOwner [%s]", itemLink, avgBid, avgBuyout, lowerBid, lowerBuyout, numAuctions, lowerBuyoutOwner)
    return avgBid, avgBuyout, lowerBid, lowerBuyout, numAuctions, lowerBuyoutOwner
end
