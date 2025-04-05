-- Style.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/24/2020, 4:21:46 PM
--
local DressUpTexturePath = DressUpTexturePath

---@type ns
local ns = select(2, ...)

---@class Addon
local Addon = ns.Addon

function Addon:SetupDefaultStyles()
    self:RegisterStyle(ns.DEFAULT_STYLE, {
        overrides = {
            OwnerSelector = { --
                MENU_OFFSET = {xOffset = 8},
            },
            TokenFrame = { --
                MENU_OFFSET = {xOffset = -5},
            },

            ContainerFrame = {
                IsSearchBoxSpaceEnough = function(self)
                    return self:GetWidth() - self.BagFrame:GetWidth() -
                               (self.meta.profile.pluginButtons and self.PluginFrame:GetWidth() or 0) > 140
                end,
                PlaceSearchBox = function(self)
                    if not self.meta.profile.bagFrame or self.SearchBox:HasFocus() or Addon:GetSearch() or
                        self:IsSearchBoxSpaceEnough() then
                        self.SearchBox:Show()

                        if self.PluginFrame:IsShown() then
                            self.SearchBox:SetPoint('RIGHT', self.PluginFrame, 'LEFT', -8, 0)
                        else
                            self.SearchBox:SetPoint('RIGHT', self, 'TOPRIGHT', -20, -42)
                        end

                        if self.BagFrame:IsShown() then
                            self.SearchBox:SetPoint('LEFT', self.BagFrame, 'RIGHT', 15, 0)
                        else
                            self.SearchBox:SetPoint('LEFT', self, 'TOPLEFT', 74, -42)
                        end
                    else
                        self.SearchBox:Hide()
                    end
                end,
            },

            EquipFrame = {
                CENTER_TEMPLATE = 'tdBag2EquipContainerCenterFrameTemplate',

                UpdateBackground = function(self)
                    local ownerInfo = ns.Cache:GetOwnerInfo(self.meta.owner)
                    local texturePath = DressUpTexturePath(ownerInfo.race)

                    self.CenterFrame.BackgroundTopLeft:SetTexture(texturePath .. 1)
                    self.CenterFrame.BackgroundTopRight:SetTexture(texturePath .. 2)
                    self.CenterFrame.BackgroundBotLeft:SetTexture(texturePath .. 3)
                    self.CenterFrame.BackgroundBotRight:SetTexture(texturePath .. 4)
                end,
            },

            EquipContainer = {
                LAYOUT_OFFSETS = { --
                    LEFT = {x = -4, y = 6},
                    RIGHT = {x = 4, y = 6},
                    BOTTOM = {x = 0, y = 6},
                },
            },
        },

        hooks = {
            EquipFrame = {
                Constructor = function(self)
                    self.CenterFrame.BackgroundTopLeft:SetDesaturated(true)
                    self.CenterFrame.BackgroundTopRight:SetDesaturated(true)
                    self.CenterFrame.BackgroundBotLeft:SetDesaturated(true)
                    self.CenterFrame.BackgroundBotRight:SetDesaturated(true)
                end,
            },

            EquipItem = {
                SetBagSlot = function(self, _, _, _, slot)
                    local anchors = ns.INV_ANCHORS[slot]
                    if not anchors then
                    elseif anchors.anchor == 'LEFT' then
                        local texture = self:CreateTexture(nil, 'BACKGROUND', 'Char-LeftSlot', -1)
                        texture:ClearAllPoints()
                        texture:SetPoint('TOPLEFT', -4, 0)
                    elseif anchors.anchor == 'RIGHT' then
                        local texture = self:CreateTexture(nil, 'BACKGROUND', 'Char-RightSlot', -1)
                        texture:ClearAllPoints()
                        texture:SetPoint('TOPRIGHT', 4, 0)
                    elseif anchors.anchor == 'BOTTOM' then
                        local texture = self:CreateTexture(nil, 'BACKGROUND', 'Char-BottomSlot', -1)
                        texture:ClearAllPoints()
                        texture:SetPoint('TOPLEFT', -4, 8)

                        if slot == 16 then
                            local texture2 = self:CreateTexture(nil, 'BACKGROUND', 'Char-Slot-Bottom-Left')
                            texture2:ClearAllPoints()
                            texture2:SetPoint('TOPRIGHT', texture, 'TOPLEFT')
                        elseif slot == 18 or (not ns.INV_ANCHORS[18] and slot == 17) then
                            local texture2 = self:CreateTexture(nil, 'BACKGROUND', 'Char-Slot-Bottom-Right')
                            texture2:ClearAllPoints()
                            texture2:SetPoint('TOPLEFT', texture, 'TOPRIGHT')
                        end
                    end
                end,
            },
        },
    })
end
