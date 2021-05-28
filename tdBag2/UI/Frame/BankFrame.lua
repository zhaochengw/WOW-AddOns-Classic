-- BankFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/17/2019, 6:42:42 PM

---- LUA
local select = select

---- WOW
local CloseBankFrame = CloseBankFrame

---@type ns
local ns = select(2, ...)
local ContainerFrame = ns.UI.ContainerFrame

---@type tdBag2Bank
local BankFrame = ns.Addon:NewClass('UI.BankFrame', ContainerFrame)

function BankFrame:OnHide()
    if not self.updatingManaged then
        CloseBankFrame()
    end
    ContainerFrame.OnHide(self)
end
