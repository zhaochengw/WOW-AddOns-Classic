BistooltipAddon = LibStub("AceAddon-3.0"):NewAddon("Bis-Tooltip")
--local AceAddon =

function addMapIcon()

    local LDB = LibStub("LibDataBroker-1.1", true)
    local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true)
    if LDB then
        local PC_MinimapBtn = LDB:NewDataObject("PoisonCharges", {
            type = "launcher",
			text = "PoisonCharges",
            icon = "interface/icons/inv_weapon_glave_01.blp",
            OnClick = function(_, button)
                if button == "LeftButton" then BistooltipAddon:createMainFrame() end
                if button == "RightButton" then BistooltipAddon:openConfigDialog() end
            end,
            OnTooltipShow = function(tt)
                tt:AddLine(BistooltipAddon.AddonNameAndVersion)
                tt:AddLine("|cffffff00Left click|r to open the BiS lists window")
                tt:AddLine("|cffffff00Right click|r to open addon configuration window")
            end,
        })
        if LDBIcon then
            LDBIcon:Register("PoisonCharges", PC_MinimapBtn, BistooltipAddon.db.char) -- PC_MinimapPos is a SavedVariable which is set to 90 as default
        end
    end
end

function BistooltipAddon:OnInitialize()
    BistooltipAddon.AceAddonName = "Bis-Tooltip"
    BistooltipAddon.AddonNameAndVersion = "Bis-Tooltip v6.6"
    BistooltipAddon:initConfig()
    addMapIcon()
    BistooltipAddon:initBislists()
    BistooltipAddon:initBisTooltip()
end
