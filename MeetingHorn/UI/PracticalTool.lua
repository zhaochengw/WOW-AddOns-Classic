-- PracticalTool.lua  实用工具
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 13/3/2025, 10:41:15 AM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local PracticalTool = ns.Addon:NewClass('UI.PracticalTool', 'Frame')
LibStub:GetLibrary('AceEvent-3.0'):Embed(PracticalTool)

function PracticalTool:CreateImageTextModule(parent, imagePath, text, onClick)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetSize(100, 100)

    frame.image = frame:CreateTexture(nil, "ARTWORK")
    frame.image:SetTexture(imagePath)
    frame.image:SetSize(64, 64)
    frame.image:SetPoint("CENTER", frame, "CENTER", 0, 10)

    frame.textLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.textLabel:SetText(text)
    frame.textLabel:SetPoint("BOTTOM", frame, "BOTTOM", 0, 0)
    frame.textLabel:SetTextColor(1, 0.82, 0, 1)

    frame:EnableMouse(true)
    frame:SetScript("OnMouseDown", function(_, button)
        self:SelectModule(frame)
        onClick()
    end)

    -- 鼠标悬停和离开事件处理
    frame:SetScript("OnEnter", function(_)
        if self.selectedModule ~= frame then
            frame.image:SetVertexColor(1, 1, 1, 0.8)
            frame.textLabel:SetTextColor(1, 1, 1, 1)
        end
    end)

    frame:SetScript("OnLeave", function(_)
        if self.selectedModule ~= frame then
            frame.image:SetVertexColor(1, 1, 1, 1)
            frame.textLabel:SetTextColor(1, 0.82, 0, 1)
        end
    end)

    table.insert(self.modules, frame)

    return frame
end

function PracticalTool:SelectModule(selectedFrame)
    self.selectedModule = selectedFrame
    for _, module in ipairs(self.modules) do
        if module == selectedFrame then
            module.image:SetVertexColor(1, 1, 1, 0.8)
            module.textLabel:SetTextColor(1, 1, 1, 1)
        else
            module.image:SetVertexColor(1, 1, 1, 1)
            module.textLabel:SetTextColor(1, 0.82, 0, 1)
        end
    end
end

function PracticalTool:Constructor()
    self.db = ns.Addon.db
    self.modules = {}
    self.PracticalToolVersion = 1

    self:RegisterMessage('MEETINGHORN_SHOW')

    self.Toolbar = CreateFrame("Frame", nil, self, "InsetFrameTemplate")
    self.Toolbar:SetPoint("TOPLEFT", self, "TOPLEFT", 2, -25)
    self.Toolbar:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -6, 230)

    local TocPricesModule = self:CreateImageTextModule(self.Toolbar, "Interface/AddOns/MeetingHorn/Media/PracticalTool/iocn1", "ICC物价", function()
        self:OnTocPricesModuleClick()
    end )
    TocPricesModule:SetPoint("LEFT", self.Toolbar, "LEFT", 10, 0)
    TocPricesModule.image:SetVertexColor(1, 1, 1, 0.8)
    TocPricesModule.textLabel:SetTextColor(1, 1, 1, 1)
    self.selectedModule = TocPricesModule

    local TaskGuideModule = self:CreateImageTextModule(self.Toolbar, "Interface/AddOns/MeetingHorn/Media/PracticalTool/iocn2", "任务指引",  function()
        self:OnTaskGuideModuleClick()
    end)
    TaskGuideModule:SetPoint("LEFT", TocPricesModule, "RIGHT", 10, 0)

    local CustomsModule = self:CreateImageTextModule(self.Toolbar, "Interface/AddOns/MeetingHorn/Media/PracticalTool/iocn3", "副本攻略", function()
        self:OnCustomsModuleClick()
    end)
    CustomsModule:SetPoint("LEFT", TaskGuideModule, "RIGHT", 10, 0)

    local RoleReportModule = self:CreateImageTextModule(self.Toolbar, "Interface/AddOns/MeetingHorn/Media/PracticalTool/iocn4", "角色周报", function()
        self:OnRoleReportModuleClick()
    end)
    RoleReportModule:SetPoint("LEFT", CustomsModule, "RIGHT", 10, 0)

    local InnateViewerModule = self:CreateImageTextModule(self.Toolbar, "Interface/AddOns/MeetingHorn/Media/PracticalTool/iocn5", "天赋装备", function()
        self:OnInnateViewerModuleClick()
    end)
    InnateViewerModule:SetPoint("LEFT", RoleReportModule, "RIGHT", 10, 0)

    local PalmtopModule = self:CreateImageTextModule(self.Toolbar, "Interface/AddOns/MeetingHorn/Media/PracticalTool/iocn6", "掌上集结号", function()
        self:OnPalmtopModuleClick()
    end)
    PalmtopModule:SetPoint("LEFT", InnateViewerModule, "RIGHT", 10, 0)

    self.Present = CreateFrame("Frame", nil, self, "InsetFrameTemplate")
    self.Present:SetPoint("TOPLEFT", self.Toolbar, "BOTTOMLEFT", 2, -2)
    self.Present:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -345, 6)

    self.PresentTitle = self.Present:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    self.PresentTitle:SetPoint("TOPLEFT", 16, -10)
    self.PresentTitle:SetText(L.TOC_PRICES_TITLE)

    self.PresentText = self.Present:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
    self.PresentText:SetPoint("TOPLEFT", self.PresentTitle, "BOTTOMLEFT", 0, -10)
    self.PresentText:SetText(L.TOC_PRICES)

    self.QRCodeExhibition = CreateFrame("Frame", nil, self, "InsetFrameTemplate")
    self.QRCodeExhibition:SetPoint("TOPLEFT", self.Present, "TOPRIGHT", 2, -2)
    self.QRCodeExhibition:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -6, 6)

    local FontString = self.QRCodeExhibition:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    FontString:SetText("扫码立即使用")
    FontString:SetPoint("TOP", 0, -8)

    self.VXQRCode = CreateFrame("Button", nil, self.QRCodeExhibition)
    self.VXQRCode:SetSize(152, 152)
    self.VXQRCode:SetPoint("TOPLEFT", self.QRCodeExhibition, "TOPLEFT", 13, -35)

    self.VXQRCodeBannerBackground = self.VXQRCode:CreateTexture(nil, "BACKGROUND")
    self.VXQRCodeBannerBackground:SetAllPoints(self.VXQRCode)
    self.VXQRCodeBannerBackground:SetTexture("Interface\\AddOns\\MeetingHorn\\Media\\PracticalTool\\PresentDSQECode")
    self.VXQRCode:Hide()

    self.VXFontString = self.QRCodeExhibition:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    self.VXFontString:SetText("微信扫码")
    self.VXFontString:SetPoint("TOP", self.VXQRCode, "BOTTOM", 0, -8)
    self.VXFontString:Hide()

    self.DSQRCode = CreateFrame("Frame", nil, self.QRCodeExhibition)
    self.DSQRCode:SetSize(152, 152)
    self.DSQRCode:SetPoint("TOP", self.QRCodeExhibition, "TOP", 0, -35)

    self.DSQRCodeBannerBackground = self.DSQRCode:CreateTexture(nil, "BACKGROUND")
    self.DSQRCodeBannerBackground:SetAllPoints(self.DSQRCode)
    self.DSQRCodeBannerBackground:SetTexture("Interface\\AddOns\\MeetingHorn\\Media\\PracticalTool\\PresentDSQECode")

    local DSFontString = self.QRCodeExhibition:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    DSFontString:SetText("大神扫码")
    DSFontString:SetPoint("TOP", self.DSQRCode, "BOTTOM", 0, -8)

    self:SetScript('OnShow', self.OnShow)
end

function PracticalTool:OnShow()
    if self.flashFrame then
        ns.HideAtFrameFlash(self.flashFrame)
    end
    ns.LogStatistics:InsertLog({ time(), 9, 1 })
end

function PracticalTool:MEETINGHORN_SHOW()
    if not self.db.global.PracticalToolVersion or (self.PracticalToolVersion > self.db.global.PracticalToolVersion) then
        if  not self.flashFrame then
            self.flashFrame = ns:CreateFlashFrame()
            ns.BindFlashAtFrame(self.flashFrame, ns.Addon.MainPanel.Tabs[5])
        end
        ns.ShowAtFrameFlash(self.flashFrame)
        self.db.global.PracticalToolVersion = self.PracticalToolVersion
    end
end

function PracticalTool:HideVXQEcode()
    self.DSQRCode:ClearAllPoints()
    self.DSQRCode:SetPoint("TOP", self.QRCodeExhibition, "TOP", 0, -35)
    self.VXQRCode:Hide()
    self.VXFontString:Hide()
end

function PracticalTool:ShowVXQEcode()
    self.DSQRCode:ClearAllPoints()
    self.DSQRCode:SetPoint("TOPLEFT", self.VXQRCode, "TOPRIGHT", 10, 0)
    self.VXQRCode:Show()
    self.VXFontString:Show()
end

function PracticalTool:OnTocPricesModuleClick()
    self:HideVXQEcode()
    self.DSQRCodeBannerBackground:SetTexture("Interface\\AddOns\\MeetingHorn\\Media\\PracticalTool\\PresentDSQECode")
    self.PresentTitle:SetText(L.TOC_PRICES_TITLE)
    self.PresentText:SetText(L.TOC_PRICES)
    ns.LogStatistics:InsertLog({ time(), 9, 2 })
end

function PracticalTool:OnTaskGuideModuleClick()
    self:ShowVXQEcode()
    self.VXQRCodeBannerBackground:SetTexture("Interface\\AddOns\\MeetingHorn\\Media\\PracticalTool\\TaskGuideVXQECode")
    self.DSQRCodeBannerBackground:SetTexture("Interface\\AddOns\\MeetingHorn\\Media\\PracticalTool\\TaskGuideDSQECode")
    self.PresentTitle:SetText(L.TASK_GUIDE_TITLE)
    self.PresentText:SetText(L.TASK_GUIDE)
    ns.LogStatistics:InsertLog({ time(), 9, 3 })
end

function PracticalTool:OnCustomsModuleClick()
    self:HideVXQEcode()
    self.DSQRCodeBannerBackground:SetTexture("Interface\\AddOns\\MeetingHorn\\Media\\PracticalTool\\CustomsDSQECode")
    self.PresentTitle:SetText(L.CUSTOMS_TITLE)
    self.PresentText:SetText(L.CUSTOMS)
    ns.LogStatistics:InsertLog({ time(), 9, 4 })
end

function PracticalTool:OnRoleReportModuleClick()
    self:HideVXQEcode()
    self.DSQRCodeBannerBackground:SetTexture("Interface\\AddOns\\MeetingHorn\\Media\\PracticalTool\\RoleReportDSQECode")
    self.PresentTitle:SetText(L.ROLE_REPORT_TITLE)
    self.PresentText:SetText(L.ROLE_REPORT)
    ns.LogStatistics:InsertLog({ time(), 9, 5 })
end

function PracticalTool:OnInnateViewerModuleClick()
    self:HideVXQEcode()
    self.DSQRCodeBannerBackground:SetTexture("Interface\\AddOns\\MeetingHorn\\Media\\PracticalTool\\InnateViewerDSQECode")
    self.PresentTitle:SetText(L.INNATE_VIEWER_TITLE)
    self.PresentText:SetText(L.INNATE_VIEWER)
    ns.LogStatistics:InsertLog({ time(), 9, 6 })
end

function PracticalTool:OnPalmtopModuleClick()
    self:ShowVXQEcode()
    self.VXQRCodeBannerBackground:SetTexture("Interface\\AddOns\\MeetingHorn\\Media\\PracticalTool\\PalmtopVXQECode")
    self.DSQRCodeBannerBackground:SetTexture("Interface\\AddOns\\MeetingHorn\\Media\\PracticalTool\\PalmtopDSQECode")
    self.PresentTitle:SetText(L.PALMTOP_TITLE)
    self.PresentText:SetText(L.PALMTOP)
    ns.LogStatistics:InsertLog({ time(), 9, 7 })
end

