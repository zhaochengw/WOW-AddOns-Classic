-------------------------------------
-- 物品寶石庫 Author: M
-------------------------------------

local MAJOR, MINOR = "LibItemGem.7000", 1
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

local SocketTexture = {
    ["interface\\itemsocketingframe\\ui-emptysocket-red"] = "EMPTY_SOCKET_RED",
    ["interface\\itemsocketingframe\\ui-emptysocket-yellow"] = "EMPTY_SOCKET_YELLOW",
    ["interface\\itemsocketingframe\\ui-emptysocket-blue"] = "EMPTY_SOCKET_BLUE",
    ["interface\\itemsocketingframe\\ui-emptysocket-meta"] = "EMPTY_SOCKET_META",
    ["interface\\itemsocketingframe\\ui-emptysocket-prismatic"] = "EMPTY_SOCKET_PRISMATIC",
    [136258] = "EMPTY_SOCKET_RED",
    [136259] = "EMPTY_SOCKET_YELLOW",
    [136256] = "EMPTY_SOCKET_BLUE",
    [136257] = "EMPTY_SOCKET_META",
    [458977] = "EMPTY_SOCKET_PRISMATIC",
}

lib.ScanTip = CreateFrame("GameTooltip", "LibItemGem_ScanTooltip", nil, "GameTooltipTemplate")

local function GetGemColor(key)
    local color
    if (key == "EMPTY_SOCKET_YELLOW") then
        color = "Yellow"
    elseif (key == "EMPTY_SOCKET_RED") then
        color = "Red"
    elseif (key == "EMPTY_SOCKET_BLUE") then
        color = "Blue"
    elseif (key == "EMPTY_SOCKET_PRISMATIC") then
        color = "Prismatic"
    end
    return color
end

function lib:GetItemGemInfo(ItemLink, unit, slot)
    local total, info = 0, {}

    if unit and slot then
        local tip = self.ScanTip
        tip:SetOwner(UIParent, "ANCHOR_NONE")
        tip:SetInventoryItem(unit, slot)
        for i = 1, 4 do
            local tex = _G[tip:GetName() .. "Texture" .. i]
            local texture = tex and tex:IsShown() and tex:GetTexture()
            if texture then
                if type(texture) == "string" then
                    texture = strlower(texture)
                end
                total = total + 1
                table.insert(info, { name = _G[SocketTexture[texture]] or EMPTY, texture = texture })
            end
        end
    else
        local stats = GetItemStats(ItemLink)
        for key, num in pairs(stats) do
            if (string.find(key, "EMPTY_SOCKET_")) then
                for i = 1, num do
                    total = total + 1
                    table.insert(info, { name = _G[key] or EMPTY, link = nil, color = GetGemColor(key)})
                end
            end
        end
    end

    local name, link
    for i = 1, 4 do
        name, link = GetItemGem(ItemLink, i)
        if (link) then
            if (info[i]) then
                info[i].name = name
                info[i].link = link
            else
                table.insert(info, { name = name, link = link })
            end
        end
    end
    return total, info
end
