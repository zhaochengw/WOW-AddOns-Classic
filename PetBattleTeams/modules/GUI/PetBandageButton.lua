local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local GUI = PetBattleTeams:GetModule("GUI")

local function OnEvent(self,event)
    local itemCount = C_Item.GetItemCount(86143)
    self.QuantityOwned:SetText(itemCount)
    if (itemCount <= 0) then
        self.Icon:SetVertexColor(.5, .5, .5)
    else
        self.Icon:SetVertexColor(1, 1 , 1)
    end
end

local function OnLeave()
    GameTooltip:Hide()
end

local function OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT");
    GameTooltip:SetItemByID(86143)
end

local function OnShow(self)
    self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
end

local function OnHide(self)
    self:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
end

function GUI:CreateBandageButton(name,parent)
    local itemName = "Battle Pet Bandage"
    local icon = C_Item.GetItemIconByID(86143)
    local itemCount = C_Item.GetItemCount(86143)
    local button = CreateFrame("Button",parent:GetName()..name,UIParent,"secureactionbuttontemplate")
    button:EnableMouse(true);
    button:RegisterForClicks("AnyUp", "AnyDown");
    button:SetAttribute("unit", "player")
    button:SetAttribute("type", "macro")
    button:SetAttribute("macrotext","/use item:86143" )

    button:SetSize(38,38)

    button.Icon = button:CreateTexture(name.."Icon","ARTWORK")
    button.Icon:SetTexture(icon)
    button.Icon:SetAllPoints()
    if (itemCount <= 0) then
        button.Icon:SetVertexColor(.5, .5, .5)
    else
        button.Icon:SetVertexColor(1, 1 , 1)
    end

    button.Border = button:CreateTexture(name.."Border","OVERLAY","ActionBarFlyoutButton-IconFrame")
    button:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
    button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square","ADD")

    button.QuantityOwned = button:CreateFontString(nil,"OVERLAY","GameFontHighlight")
    button.QuantityOwned:SetText(itemCount)
    button.QuantityOwned:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-2,2)
    button.QuantityOwned:SetJustifyH("RIGHT")

    button:SetScript("OnEvent", OnEvent)
    button:SetScript("OnShow", OnShow)
    button:SetScript("OnHide",OnHide)
    button:SetScript("OnEnter", OnEnter)
    button:SetScript("OnLeave",OnLeave)
    button:RegisterEvent("BAG_UPDATE")

    return button
end

