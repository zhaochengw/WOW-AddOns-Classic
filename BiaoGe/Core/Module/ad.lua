local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local RGB_16 = ADDONSELF.RGB_16
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local GetText_T = ADDONSELF.GetText_T
local FrameDongHua = ADDONSELF.FrameDongHua
local FrameHide = ADDONSELF.FrameHide
local AddTexture = ADDONSELF.AddTexture
local GetItemID = ADDONSELF.GetItemID

local Width = ADDONSELF.Width
local Height = ADDONSELF.Height
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local pt = print
local RealmId = GetRealmID()
local player = UnitName("player")

BG.RegisterEvent("ADDON_LOADED", function(self, event, addonName)
    if addonName ~= AddonName then return end

    BG.ButtonAd = BG.ButtonOnLineCount
    if BG.ButtonAd then return end

    local adtitle = "飞越工会"
    local adtext1 = "飞越工会招收优质指挥，精英玩家！欢迎团长来YY 65538 开团，提供资源，私人补助！"
    local adtext2 = L["< 点击复制YY号 >"]
    local adtext3 = L["(广告)"]
    local yy = 65538

    local f = CreateFrame("Button", nil, BG.MainFrame)
    f:SetSize(1, 20)
    f:SetPoint("LEFT", BG.ButtonOnLineCount, "RIGHT", 0, 0)
    f:SetNormalFontObject(BG.FontWhite13)
    f:SetText(BG.STC_y1(AddTexture(132351) .. L["招募"]))
    f:GetFontString():SetPoint("LEFT")
    f:SetWidth(f:GetFontString():GetWidth() + 10)
    BG.ButtonAd = f

    f:SetScript("OnClick", function(self)
        if not self.copyFrame then
            local f = CreateFrame("Frame", nil, self, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 16,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:SetSize(150, 30)
            f:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -2)
            f:SetFrameLevel(130)
            f:EnableMouse(true)
            f:Hide()
            self.copyFrame = f
            f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
            f.CloseButton:SetPoint("RIGHT", f, "RIGHT", 0, 0)

            local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            edit:SetSize(90, 20)
            edit:SetPoint("LEFT", 10, 0)
            edit:SetScript("OnEscapePressed", function(self)
                f:Hide()
            end)

            f:SetScript("OnShow", function(self)
                edit:SetText(yy)
                edit:SetFocus()
                edit:HighlightText()
            end)
        end
        if self.copyFrame:IsVisible() then
            self.copyFrame:Hide()
        else
            self.copyFrame:Show()
        end
        BG.PlaySound(1)
    end)
    f:SetScript("OnHide", function(self)
        if self.copyFrame then
            self.copyFrame:Hide()
        end
    end)

    f:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(adtitle, 1, 1, 1, true)
        GameTooltip:AddLine(adtext1, 1, 0.82, 0, true)
        GameTooltip:AddLine(" ", 1, 0.82, 0, true)
        GameTooltip:AddDoubleLine(adtext2, adtext3, 0, 1, 0, 0.5, 0.5, 0.5)
        GameTooltip:Show()
    end)
    f:SetScript("OnLeave", GameTooltip_Hide)
end)
