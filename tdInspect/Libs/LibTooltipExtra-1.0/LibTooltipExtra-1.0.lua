-- LibTooltipExtra-1.0.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 6/7/2021, 12:16:52 AM
--
local MAJOR, MINOR = 'LibTooltipExtra-1.0', 7

---@class LibTooltipExtra-1.0
local Lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not Lib then
    return
end

---@class LibGameTooltip: GameTooltip
local Tip = wipe(Lib.Tip or {})

local TipCache = Lib.TipCache or {}

local function new(rawTip, obj)
    obj = setmetatable(Mixin(obj or {}, Tip), {__index = rawTip})
    obj:OnLoad(rawTip)
    return obj
end

setmetatable(TipCache, {
    __mode = 'k',
    __index = function(t, k)
        t[k] = new(k)
        return t[k]
    end,
})

Lib.Tip = Tip
Lib.TipCache = TipCache

if oldminor and oldminor < 5 then
    Lib.TipMeta = nil
    setmetatable(Tip, nil)
end

_G.GameTooltipText:SetSpacing(2)

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

function Lib.SetTooltipMoney(rawTip)
    local tip = Lib:New(rawTip)

    local moneyFrame = tip:GetMoneyFrame(rawTip.shownMoneyFrames)
    if not moneyFrame then
        return
    end

    local p, r, rp, x, y = moneyFrame:GetPoint()
    moneyFrame:ClearAllPoints()
    moneyFrame:SetPoint('BOTTOMLEFT', r, 'BOTTOMLEFT', x, 0)
end

---- Tip

function Tip:OnLoad(rawTip)
    self[0] = rawTip[0]
    self.tip = rawTip
    self.l = self.l or generateCache(rawTip:GetName(), 'TextLeft')
    self.r = self.r or generateCache(rawTip:GetName(), 'TextRight')
    self.m = self.m or generateCache(rawTip:GetName(), 'MoneyFrame')
    self.minor = MINOR
end

---@return FontString
function Tip:GetFontStringLeft(n)
    return self.l[n]
end

---@return FontString
function Tip:GetFontStringRight(n)
    return self.r[n]
end

---@return FontString, FontString
function Tip:GetFontStrings(n)
    return self.l[n], self.r[n]
end

---@return TooltipMoneyFrameTemplate
function Tip:GetMoneyFrame(n)
    return self.m[n]
end

local function AddFront(object, text)
    if object and object:GetText() then
        text = text or ' '
        object:SetText(text .. '|n' .. object:GetText())
        object:Show()
    end
end

---@param toLine integer
---@param textLeft string
---@param textRight string
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

---@param toLine integer
---@param text string
function Tip:AppendLineFrontLeft(toLine, text)
    return self:AppendLineFront(toLine, text)
end

---@param toLine integer
---@param text string
function Tip:AppendLineFrontRight(toLine, text)
    return self:AppendLineFront(toLine, nil, text)
end

---- Lib
---@param tip GameTooltip
---@return LibGameTooltip
function Lib:New(tip)
    return TipCache[tip]
end

do
    -- upgrade
    for rawTip, obj in pairs(TipCache) do
        new(rawTip, obj)
    end
end

if Lib.GameTooltip then
    new(GameTooltip, Lib.GameTooltip)
else
    ---@type LibGameTooltip
    Lib.GameTooltip = Lib:New(GameTooltip)
end
