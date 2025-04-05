-- Pool.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2024, 1:13:38 PM
--
---@class ns
local ns = select(2, ...)

---@class Pool
---@field pool table<any, boolean>
---@field OnFree? function
---@field Create? function
---@field New? function
---@field SetParent? function
---@field Hide? function
local Pool = {}
ns.Pool = Pool

function Pool:Alloc(parent)
    local obj = next(self.pool)
    if not obj then
        if self.Create then
            obj = self:Create(parent)
        else
            obj = self:New(parent)
        end
    else
        self.pool[obj] = nil

        if obj.SetParent then
            obj:SetParent(parent)
        end
        if obj.Show then
            obj:Show()
        end
    end
    return obj
end

function Pool:Free()
    self.pool[self] = true

    if self.Hide then
        self:Hide()
    end
    if self.SetParent then
        self:SetParent(nil)
    end
    if self.OnFree then
        self:OnFree()
    end
end

function Pool:Mixin(class)
    class.pool = {}
    class.Alloc = Pool.Alloc
    class.Free = Pool.Free
end
