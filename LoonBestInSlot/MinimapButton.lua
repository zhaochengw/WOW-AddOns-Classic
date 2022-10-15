local LDB = LibStub ("LibDataBroker-1.1", true)
local LBISButton = LDB and LibStub ("LibDBIcon-1.0", true)

function LBIS:RegisterMiniMap()
    
    if LDB then
  
        local databroker = LDB:NewDataObject ("LoonBestInSlot", {
            type = "data source",
            icon = "Interface\\AddOns\\LoonBestInSlot\\Icons\\loon",
            text = "0",
        
            HotCornerIgnore = true,
        
            OnClick = function (self, button)
        
                if button == "LeftButton" then 
                    LBIS.BrowserWindow:ToggleWindow()
                elseif button == "RightButton" then
		            InterfaceOptionsFrame_Show()
		            InterfaceOptionsFrame_OpenToCategory("Loon Best In Slot")
                end

            end,

            OnTooltipShow = function (tooltip)
                tooltip:AddLine (LBIS.L["Loon Best In Slot"]);
                tooltip:AddLine("|cFF9CD6DE"..LBIS.L["Left-Click"].."|r: "..LBIS.L["Open Browser Window"]);
                tooltip:AddLine("|cFF9CD6DE"..LBIS.L["Right-Click"].."|r: "..LBIS.L["Open Settings"]);
            end,
        })
        
        if (databroker and not LBISButton:IsRegistered ("LoonBestInSlot")) then
            LBISButton:Register ("LoonBestInSlot", databroker, LBISSettings.minimap)
        end

        LBIS:ShowHideMiniMap(LBISSettings.minimap.hide);
  
    end

  end

  function LBIS:ShowHideMiniMap(shouldHide)
    LBISSettings.minimap.hide = shouldHide;
    if shouldHide then
        LBISButton:Hide("LoonBestInSlot");
    else
        LBISButton:Show("LoonBestInSlot");
    end

    function LBIS:ShowHideTooltip(shouldHide)
        LBISSettings.ShowTooltip = shouldHide;
    end
end