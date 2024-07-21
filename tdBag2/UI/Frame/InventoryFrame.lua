-- InventoryFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/25/2019, 1:56:22 AM
--
local ipairs = ipairs

--[==[@build^1@
local C_Engraving = C_Engraving
--@end-build^1@]==]

---@type ns
local ns = select(2, ...)
local ContainerFrame = ns.UI.ContainerFrame

---@class UI.InventoryFrame: UI.ContainerFrame
local InventoryFrame = ns.Addon:NewClass('UI.InventoryFrame', ContainerFrame)

--[[@retail@
if true then
    return
end
--@end-retail@]]

local MAIN_MENU_BUTTONS = {
    _G.MainMenuBarBackpackButton, --
    _G.CharacterBag0Slot, --
    _G.CharacterBag1Slot, --
    _G.CharacterBag2Slot, --
    _G.CharacterBag3Slot, --
}

local function SetChecked(self)
    return self:RawSetChecked(ns.Addon:IsFrameShown(ns.BAG_ID.BAG))
end

for i, v in ipairs(MAIN_MENU_BUTTONS) do
    v.RawSetChecked = v.SetChecked
    v.SetChecked = SetChecked
end

function InventoryFrame:OnShow()
    ContainerFrame.OnShow(self)

    --[=[@classic@
    if C_Engraving and C_Engraving.IsEngravingEnabled() then
        C_Engraving.RefreshRunesList()
    end
    --@end-classic@]=]

    self:HighlightMainMenu(true)
end

function InventoryFrame:OnHide()
    ContainerFrame.OnHide(self)

    self:HighlightMainMenu(false)
end

function InventoryFrame:HighlightMainMenu(flag)
    for _, button in ipairs(MAIN_MENU_BUTTONS) do
        button:RawSetChecked(flag)
    end
end
