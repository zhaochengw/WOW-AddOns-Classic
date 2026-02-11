--[[--
	by enpingking (url = https://ngabbs.com/read.php?tid=45700523&_fu=1409755%2C2&rand=83)
--]]--

local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;

local mod = {};

-- 按 id 查询，自动拼 name:itemid
function mod.F_QueryPriceByID(id, num)
    if mod.dbver == 1 then
        if not id then return nil end
        local name = GetItemInfo(id)
        if not name then return nil end
        local history = EasyAuctionDB and EasyAuctionDB.PriceHistory and EasyAuctionDB.PriceHistory[name]
        if not history or #history == 0 then return nil end
        local min = nil
        for _, info in ipairs(history) do
            if info.unit then
                if not min or info.unit < min then
                    min = info.unit
                end
            end
        end
        if min then
            return min * (num or 1)
        end
    else
        if not id then return nil end
        local name = GetItemInfo(id)
        if not name then return nil end
        local key = name .. ":" .. id
        local history = EasyAuctionDB and EasyAuctionDB.PriceHistory and EasyAuctionDB.PriceHistory[key]
        if not history or #history == 0 then return nil end
        local min = nil
        for _, info in ipairs(history) do
            if info.unit then
                if not min or info.unit < min then
                    min = info.unit
                end
            end
        end
        if min then
            return min * (num or 1)
        end
    end
end

-- 按 name 查询，自动遍历所有 name:itemid，取最低价
function mod.F_QueryPriceByName(name, num)
    if mod.dbver == 1 then
        if not name then return nil end
        local min = nil
        if EasyAuctionDB and EasyAuctionDB.PriceHistory then
            local history = EasyAuctionDB.PriceHistory[name]
            if not history or #history == 0 then return nil end
            for _, info in ipairs(history) do
                if info.unit then
                    if not min or info.unit < min then
                        min = info.unit
                    end
                end
            end
        end
        if min then
            return min * (num or 1)
        end
    else
        if not name then return nil end
        local min = nil
        if EasyAuctionDB and EasyAuctionDB.PriceHistory then
            for key, history in pairs(EasyAuctionDB.PriceHistory) do
                if type(key) == "string" and type(history) == "table" and key:match("^(.-):%d+$") == name then
                    for _, info in ipairs(history) do
                        if info.unit then
                            if not min or info.unit < min then
                                min = info.unit
                            end
                        end
                    end
                end
            end
        end
        if min then
            return min * (num or 1)
        end
    end
end

MT.RegsiterAuctionModOnLoad("EasyAuction", function()
    local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata;
    local version = GetAddOnMetadata("EasyAuction", "Version");
    mod.version = version
    mod.dbver = 1
    if version then
        local major, minor, patch = strsplit(".", version)
        major = tonumber(major)
        minor = tonumber(minor)
        patch = tonumber(patch)
        if major and minor and patch then
            if major > 2
                or (major == 2 and minor > 3)
                or (major == 2 and minor == 3 and patch >= 6)
            then
                mod.dbver = 2
            end
        end
    end
    MT.AddAuctionMod("EasyAuction", mod)
end)
