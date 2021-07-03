-- LibTooltipExtra-1.0.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 6/7/2021, 12:16:52 AM
--
local MAJOR, MINOR = 'LibTooltipExtra-1.0', 1

---@class LibTooltipExtra-1.0
local Lib = LibStub:NewLibrary(MAJOR, MINOR)
if not Lib then
    return
end

---@class LibGameTooltip: GameTooltip
local Tip = Lib.Tip or {}
local TipMeta = Lib.TipMeta or {__index = Tip}

Lib.Tip = Tip
Lib.TipMeta = TipMeta

_G.GameTooltipText:SetSpacing(2)

setmetatable(Tip, getmetatable(GameTooltip))

local cacheMeta = {
    __index = function(t, num)
        local fontString = _G[t._prefix .. num]
        t[num] = fontString
        return fontString
    end,
}

local function generateCache(tipName, key)
    return setmetatable({_prefix = tipName .. key}, cacheMeta)
end

if not Lib.SetTooltipMoney then
    hooksecurefunc('SetTooltipMoney', function(tip)
        return Lib.SetTooltipMoney(tip)
    end)
end

function Lib.SetTooltipMoney(tip)
    local moneyFrame = _G[tip:GetName() .. 'MoneyFrame' .. tip.shownMoneyFrames]
    if not moneyFrame then
        return
    end

    local p, r, rp, x, y = moneyFrame:GetPoint()
    moneyFrame:ClearAllPoints()
    moneyFrame:SetPoint('BOTTOMLEFT', r, 'BOTTOMLEFT', x, 0)
end

---@return LibGameTooltip
function Tip:New(tip)
    local obj = {}
    obj[0] = tip[0]
    obj.tip = tip
    obj.l = generateCache(tip:GetName(), 'TextLeft')
    obj.r = generateCache(tip:GetName(), 'TextRight')
    return setmetatable(obj, TipMeta)
end

function Tip:GetFontStringLeft(n)
    return self.l[n]
end

function Tip:GetFontStringRight(n)
    return self.r[n]
end

function Tip:GetFontStrings(n)
    return self.l[n], self.r[n]
end

local function AddFront(object, text)
    if object and object:GetText() then
        text = text or ' '
        object:SetText(text .. '|n' .. object:GetText())
        object:Show()
    end
end

function Tip:AppendLineFront(toLine, textLeft, textRight)
    if self:NumLines() >= toLine then
        local fontLeft, fontRight = self:GetFontStrings(toLine)
        AddFront(fontLeft, textLeft)
        AddFront(fontRight, textRight)
    elseif textRight then
        self:AddDoubleLine(textLeft, textRight)
    else
        self:AddLine(textLeft)
    end
end

function Tip:AppendLineFrontLeft(toLine, text)
    return self:AppendLineFront(toLine, text)
end

function Tip:AppendLineFrontRight(toLine, text)
    return self:AppendLineFront(toLine, nil, text)
end

---@type LibGameTooltip
Lib.GameTooltip = Tip:New(GameTooltip)
