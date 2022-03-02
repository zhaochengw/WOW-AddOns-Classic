-- Style.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/24/2020, 4:21:46 PM
--
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
        },
    })
end
