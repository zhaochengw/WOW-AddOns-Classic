local addonName, ns = ...
local RS = ns.RS or LibStub("AceAddon-3.0"):GetAddon("RurutiaSuite", true)
if not RS then return end
local Module = RS:NewModule("Consumables", "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0")

local CFG_ROOT = ns.Config
if not CFG_ROOT then return end
local SPELLBAR_CFG = CFG_ROOT and CFG_ROOT.spellBar
local THEME = CFG_ROOT and CFG_ROOT.theme

local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local UnitClass = _G.UnitClass
local UnitFactionGroup = _G.UnitFactionGroup
local InCombatLockdown = _G.InCombatLockdown
local IsSpellKnown = _G.IsSpellKnown
local GetSpellInfo = _G.GetSpellInfo
local GetItemCount = _G.GetItemCount
local MouseIsOver = _G.MouseIsOver
local C_Timer = _G.C_Timer

local function ComputeAnchorPosition(frame, desiredAnchor)
    local anchor = desiredAnchor or "CENTER"
    local screenW = UIParent:GetWidth()
    local screenH = UIParent:GetHeight()
    if not screenW or not screenH then return nil end

    local left = frame:GetLeft()
    local right = frame:GetRight()
    local top = frame:GetTop()
    local bottom = frame:GetBottom()
    if not left or not top or not right or not bottom then return nil end

    if anchor == "TOPLEFT" then
        return anchor, left, top - screenH
    elseif anchor == "TOPRIGHT" then
        return anchor, right - screenW, top - screenH
    elseif anchor == "TOP" then
        local centerX = (left + right) / 2
        return anchor, centerX - screenW / 2, top - screenH
    elseif anchor == "CENTER" then
        local centerX = (left + right) / 2
        local centerY = (top + bottom) / 2
        return anchor, centerX - screenW / 2, centerY - screenH / 2
    end

    return "TOPLEFT", left, top - screenH
end

local defaultsPosition = { "CENTER", nil, "CENTER", 0, 0 }
if SPELLBAR_CFG and SPELLBAR_CFG.anchor and SPELLBAR_CFG.defaultPosition then
    defaultsPosition = { SPELLBAR_CFG.anchor, nil, SPELLBAR_CFG.anchor, SPELLBAR_CFG.defaultPosition.x or 0, SPELLBAR_CFG.defaultPosition.y or 0 }
end

local defaults = {
    profile = {
        spellBarEnabled = true,
        position = defaultsPosition,
        direction = "DOWN",
        buttonSize = (SPELLBAR_CFG and SPELLBAR_CFG.buttonWidth) or 34,
        padding = (SPELLBAR_CFG and SPELLBAR_CFG.spacing) or 1,
        maxButtons = (SPELLBAR_CFG and SPELLBAR_CFG.maxButtons) or 12,
    }
}

local AVAILABLE_DIRECTIONS = {
    ["DOWN"] = "向下",
    ["UP"] = "向上",
    ["RIGHT"] = "向右",
    ["LEFT"] = "向左",
}

-- ============================================================
-- 生命周期
-- ============================================================
function Module:OnInitialize()
    self.db = RS.db:RegisterNamespace("Consumables", defaults)

    if SPELLBAR_CFG then
        local p = self.db.profile.position
        if not p or (p[1] == "CENTER" and (p[4] or 0) == 0 and (p[5] or 0) == 0) then
            self.db.profile.position = defaultsPosition
        end

        if not self.db.profile.direction or self.db.profile.direction == "HORIZONTAL" then
            local layout = SPELLBAR_CFG.layout
            if layout == "VERTICAL" then self.db.profile.direction = "DOWN"
            elseif layout == "HORIZONTAL" then self.db.profile.direction = "RIGHT"
            else self.db.profile.direction = "DOWN" end
        end
        if not self.db.profile.buttonSize or self.db.profile.buttonSize == 30 then
            self.db.profile.buttonSize = SPELLBAR_CFG.buttonWidth
        end
        if not self.db.profile.padding or self.db.profile.padding == 5 then
            self.db.profile.padding = SPELLBAR_CFG.spacing
        end
        if not self.db.profile.maxButtons or self.db.profile.maxButtons == 12 then
            self.db.profile.maxButtons = SPELLBAR_CFG.maxButtons
        end
        if self.db.profile.spellBarEnabled == nil then self.db.profile.spellBarEnabled = SPELLBAR_CFG.enabled end
    end

    self:RegisterChatCommand("rsm", "OnChatCommand")
end

function Module:OnEnable()
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateBar")
    self:RegisterEvent("SPELLS_CHANGED", "UpdateBar")

    local _, class = UnitClass("player")
    if class == "MAGE" or self.previewEnabled then
        self:CreateBar()

        -- 延迟执行 UpdateBar，确保数据加载完成
        self:ScheduleTimer("UpdateBar", 1)
    end
end

function Module:SetReagentListenerEnabled(enabled)
    enabled = enabled and true or false

    if enabled == self.isReagentListenerEnabled then return end
    self.isReagentListenerEnabled = enabled

    if enabled then
        self:RegisterEvent("BAG_UPDATE_DELAYED", "RequestReagentCountRefresh")
    else
        self:UnregisterEvent("BAG_UPDATE_DELAYED")
        if self.reagentRefreshTimer then
            self.reagentRefreshTimer:Cancel()
            self.reagentRefreshTimer = nil
        end
    end
end

function Module:RequestReagentCountRefresh()
    if self.reagentRefreshTimer then return end
    self.reagentRefreshTimer = self:ScheduleTimer("UpdateReagentCountText", 0.05)
end

function Module:UpdateReagentCountText()
    self.reagentRefreshTimer = nil

    if not self.bar or not self.buttons or not self.activeCount then return end

    for i = 2, self.activeCount do
        local btn = self.buttons[i]
        if btn and btn.textTop then
            btn.textTop:SetText("")
        end
    end

    local btn = self.buttons[1]
    if not btn or not btn.textTop then return end

    if ns.IsPortalReagentFree then
        btn.textTop:SetText("")
        return
    end

    local info = btn.customInfo
    if info and info.itemTeleport then
        btn.textTop:SetText(GetItemCount(info.itemTeleport) or 0)
        return
    end

    btn.textTop:SetText("")
end

function Module:OnDisable()
    self:UnregisterAllEvents()
    if self.bar then self.bar:Hide() end
end

function Module:OnChatCommand(input)
    local _, class = UnitClass("player")
    if class ~= "MAGE" and not self.previewEnabled then
        RS:Print("非法师职业，请先在设置中勾选【预览】以解锁动作条。")
        return
    end
    self:ToggleAnchor()
end

-- ============================================================
-- 核心逻辑
-- ============================================================

function Module:ToggleSpellBar(value)
    self.db.profile.spellBarEnabled = value
    self:UpdateBar()
end

function Module:TogglePreview(value)
    self.previewEnabled = value
    
    -- 确保 Bar 存在
    if value and not self.bar then
        self:CreateBar()
    end

    self:UpdateBar()
end

function Module:SetUnlocked(unlocked)
    if not self.bar then self:CreateBar() end

    if unlocked then
        self.isUnlocked = true

        if not self.dragOverlay then
            local ov = CreateFrame("Frame", nil, self.bar, "BackdropTemplate")
            ov:SetPoint("TOPLEFT", -5, 5)
            ov:SetPoint("BOTTOMRIGHT", 5, -5)
            ov:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
            ov:SetBackdropColor(0, 1, 0, 0.5)
            ov:SetFrameLevel((self.bar:GetFrameLevel() or 0) + 50)
            ov:EnableMouse(true)
            ov:RegisterForDrag("LeftButton")
            ov:SetScript("OnDragStart", function()
                if InCombatLockdown() then return end
                Module.bar:StartMoving()
            end)
            ov:SetScript("OnDragStop", function()
                Module.bar:StopMovingOrSizing()
                local desiredAnchor = (Module.db and Module.db.profile and Module.db.profile.position and Module.db.profile.position[1]) or (SPELLBAR_CFG and SPELLBAR_CFG.anchor) or "CENTER"
                local anchor, x, y = ComputeAnchorPosition(Module.bar, desiredAnchor)
                if not anchor then return end

                Module.db.profile.position = { anchor, nil, anchor, x, y }
                Module.bar:ClearAllPoints()
                Module.bar:SetPoint(anchor, UIParent, anchor, x, y)
            end)

            self.dragOverlay = ov
        end

        self.dragOverlay:Show()
    else
        self.isUnlocked = false

        if self.dragOverlay then self.dragOverlay:Hide() end

        self.bar:ClearAllPoints()
        self.bar:SetPoint(unpack(self.db.profile.position))
    end

    self:UpdateBar()
end

function Module:ToggleAnchor()
    self:SetUnlocked(not self.isUnlocked)
end

function Module:CreateBar()
    if self.bar then return end
    
    local cfg = SPELLBAR_CFG or {}
    local db = self.db.profile
    local size = db.buttonSize or 34
    local maxButtons = db.maxButtons or 12

    local f = CreateFrame("Frame", "RurutiaMageBar", UIParent, "SecureHandlerStateTemplate")
    f:SetSize(size, size)
    f:SetPoint(unpack(db.position))
    f:SetFrameStrata(cfg.frameStrata or "MEDIUM")
    f:SetFrameLevel(cfg.frameLevel or 100)
    f:SetMovable(true)
    f:SetClampedToScreen(true)
    
    self.bar = f
    self.buttons = {}

    f:SetScript("OnEnter", function() Module:ExpandFlyout() end)
    f:SetScript("OnLeave", function() Module:CollapseFlyout() end)

    for i = 1, maxButtons do
        local btn = CreateFrame("Button", "RurutiaMageBarBtn"..i, f, "SecureActionButtonTemplate, BackdropTemplate")
        btn:SetSize(size, size)
        btn:RegisterForClicks("AnyDown", "AnyUp")
        btn:Hide()

        btn:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
        if THEME and THEME.background then
            local bg = THEME.background
            btn:SetBackdropColor(bg.r, bg.g, bg.b, bg.a)
        end

        btn.icon = btn:CreateTexture(nil, "ARTWORK")
        btn.icon:SetAllPoints()
        if THEME and THEME.iconCoords then
            local c = THEME.iconCoords
            btn.icon:SetTexCoord(c[1], c[2], c[3], c[4])
        else
            btn.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        end

        local border = CreateFrame("Frame", nil, btn, "BackdropTemplate")
        border:SetAllPoints(btn)
        border:SetFrameLevel(btn:GetFrameLevel() + 2)
        border:SetBackdrop({ edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1 })
        if THEME and THEME.border and THEME.border.color then
            local bd = THEME.border.color
            border:SetBackdropBorderColor(bd.r, bd.g, bd.b, bd.a)
        else
            border:SetBackdropBorderColor(0, 0, 0, 1)
        end
        btn.borderFrame = border

        local pushed = btn:CreateTexture(nil, "OVERLAY")
        pushed:SetAllPoints()
        pushed:SetColorTexture(0, 0, 0, 0.3)
        btn:SetPushedTexture(pushed)

        local highlight = btn:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetAllPoints()
        highlight:SetColorTexture(1, 1, 1, 0.15)
        btn:SetHighlightTexture(highlight)

        if cfg.texts and cfg.texts.top then
            local t = cfg.texts.top
            btn.textTop = btn:CreateFontString(nil, "OVERLAY")
            btn.textTop:SetFont(t.font, t.size, t.flags)
            btn.textTop:SetPoint(t.point, t.x, t.y)
            btn.textTop:SetTextColor(t.color.r, t.color.g, t.color.b)
        end

        if cfg.texts and cfg.texts.bottom then
            local t = cfg.texts.bottom
            btn.textBottom = btn:CreateFontString(nil, "OVERLAY")
            btn.textBottom:SetFont(t.font, t.size, t.flags)
            btn.textBottom:SetPoint(t.point, t.x, t.y)
            btn.textBottom:SetTextColor(t.color.r, t.color.g, t.color.b)
        end

        btn:SetScript("OnEnter", function(self)
            Module:ExpandFlyout()
            local info = self.customInfo
            if not info then return end

            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            
            -- [Fix] MOP及后续版本不显示材料数量
            local showCount = not ns.IsPortalReagentFree
            
            local countLeft = showCount and (" ("..(GetItemCount(info.itemPortal) or 0)..")") or ""
            local countRight = showCount and (" ("..(GetItemCount(info.itemTeleport) or 0)..")") or ""
            
            local line1 = "|cffffffff左键：|r|cff00ff00"..(info.spellLeft or "")..countLeft.."|r"
            local line2 = "|cffffffff右键：|r|cff00ff00"..(info.spellRight or "")..countRight.."|r"
            
            GameTooltip:SetText(line1 .. "\n" .. line2)
            if info.isKnown == false and not Module.previewEnabled then
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("|cffff0000(未学会)|r")
            end
            GameTooltip:Show()
        end)

        btn:SetScript("OnLeave", function()
            GameTooltip:Hide()
            Module:CollapseFlyout()
        end)

        self.buttons[i] = btn
    end
end

function Module:ExpandFlyout()
    if self.hideTimer then
        self.hideTimer:Cancel()
        self.hideTimer = nil
    end

    if not self.bar or self.isUnlocked then return end
    if not self.activeCount or self.activeCount <= 1 then return end

    for i = 2, self.activeCount do
        local btn = self.buttons[i]
        if btn then btn:Show() end
    end

    if self.bar.expandedWidth and self.bar.expandedHeight then
        self.bar:SetSize(self.bar.expandedWidth, self.bar.expandedHeight)
    end
end

function Module:CollapseFlyout()
    if not self.bar or self.isUnlocked then return end
    if not self.activeCount or self.activeCount <= 1 then return end
    if not C_Timer or not C_Timer.NewTimer then return end

    if self.hideTimer then
        self.hideTimer:Cancel()
        self.hideTimer = nil
    end

    self.hideTimer = C_Timer.NewTimer(0.2, function()
        if not self.bar then return end
        if MouseIsOver(self.bar) then return end

        for i = 2, self.activeCount do
            local btn = self.buttons[i]
            if btn then btn:Hide() end
        end

        local db = self.db.profile
        local size = db.buttonSize or 34
        self.bar:SetSize(size, size)
    end)
end

function Module:UpdateBar()
    if InCombatLockdown() then return end
    if not self.bar then
        self:SetReagentListenerEnabled(false)
        return
    end
    
    local db = self.db.profile
    if not db.spellBarEnabled and not self.previewEnabled then
        self.bar:Hide()
        self:SetReagentListenerEnabled(false)
        return
    end
    
    local _, class = UnitClass("player")
    -- [Fix] 预览模式下忽略职业限制
    if class ~= "MAGE" and not self.previewEnabled then
        self.bar:Hide()
        self:SetReagentListenerEnabled(false)
        return
    end
    
    local data = ns.SpellBarData
    if not data then
        self.bar:Hide()
        self:SetReagentListenerEnabled(false)
        return
    end
    
    local validSpells = {}

    local myFaction = UnitFactionGroup("player")
    for _, info in ipairs(data) do
        if self.previewEnabled or (not info.requiredFaction or info.requiredFaction == myFaction) then
            local isKnown = self.previewEnabled and true or false

            if not self.previewEnabled and IsSpellKnown then
                if info.teleportID then
                    isKnown = IsSpellKnown(info.teleportID)
                end
                if not isKnown and info.portalID then
                    isKnown = IsSpellKnown(info.portalID)
                end
                if not isKnown and info.spellRight and GetSpellInfo then
                    local _, _, _, _, _, _, nameID = GetSpellInfo(info.spellRight)
                    if nameID then
                        isKnown = IsSpellKnown(nameID)
                    end
                end
            end

            info.isKnown = isKnown
            validSpells[#validSpells + 1] = info
        end
    end
    
    if #validSpells == 0 then
        self.bar:Hide()
        self:SetReagentListenerEnabled(false)
        return
    end

    local maxButtons = db.maxButtons or #self.buttons
    local count = #validSpells
    if count > maxButtons then count = maxButtons end
    self.activeCount = count

    self:SetReagentListenerEnabled((not ns.IsPortalReagentFree) and (self.activeCount and self.activeCount > 0))

    local size = db.buttonSize or 34
    local padding = db.padding or 1
    local direction = db.direction or "DOWN"
    -- 兼容旧配置
    if direction == "VERTICAL" then direction = "DOWN" end
    if direction == "HORIZONTAL" then direction = "RIGHT" end

    -- [Fix] 移除动态尺寸逻辑，Bar 始终保持单按钮大小，仅作为锚点
    self.bar:SetSize(size, size)
    self.bar:Show()

    -- [Fix] 解锁时强制展开，避免只显示第一个按钮
    local collapsed = (not self.isUnlocked) and (not MouseIsOver(self.bar))

    -- [Font] 使用插件内置字体 (用户需自行放入 Rurutia.ttf)
    local fontPath = "Interface\\AddOns\\RurutiaSuite\\Media\\Fonts\\Rurutia.ttf"

    for i = 1, #self.buttons do
        local btn = self.buttons[i]
        local info = (i <= count) and validSpells[i] or nil

        btn.customInfo = nil

        if btn.textTop then 
            btn.textTop:SetText("") 
            local _, size, flags = btn.textTop:GetFont()
            btn.textTop:SetFont(fontPath, size or 12, flags or "OUTLINE")
        end
        if btn.textBottom then 
            btn.textBottom:SetText("") 
            local _, size, flags = btn.textBottom:GetFont()
            btn.textBottom:SetFont(fontPath, size or 12, flags or "OUTLINE")
        end

        btn:SetAttribute("type1", nil)
        btn:SetAttribute("spell1", nil)
        btn:SetAttribute("type2", nil)
        btn:SetAttribute("spell2", nil)

        if info then
            btn.customInfo = info

            btn:SetSize(size, size)
            btn:ClearAllPoints()
            
            if i == 1 then
                -- [Fix] 第一个按钮始终居中于 Bar，确保位置不随生长方向偏移
                btn:SetPoint("CENTER", self.bar, "CENTER", 0, 0)
            else
                local prevBtn = self.buttons[i - 1]
                if direction == "DOWN" then
                    btn:SetPoint("TOP", prevBtn, "BOTTOM", 0, -padding)
                elseif direction == "UP" then
                    btn:SetPoint("BOTTOM", prevBtn, "TOP", 0, padding)
                elseif direction == "RIGHT" then
                    btn:SetPoint("LEFT", prevBtn, "RIGHT", padding, 0)
                elseif direction == "LEFT" then
                    btn:SetPoint("RIGHT", prevBtn, "LEFT", -padding, 0)
                end
            end

            btn.icon:SetTexture(info.icon)

            btn.icon:SetDesaturated(false)
            btn.icon:SetVertexColor(1, 1, 1)

            if btn.textTop then
                if (not ns.IsPortalReagentFree) and i == 1 and info.itemTeleport then
                    btn.textTop:SetText(GetItemCount(info.itemTeleport) or 0)
                else
                    btn.textTop:SetText("")
                end
            end
            if btn.textBottom and info.overlayText then
                btn.textBottom:SetText(info.overlayText)
            end

            btn:SetAttribute("type1", "spell")
            btn:SetAttribute("spell1", info.spellLeft)
            btn:SetAttribute("type2", "spell")
            btn:SetAttribute("spell2", info.spellRight)

            if collapsed and i > 1 then
                btn:Hide()
            else
                btn:Show()
            end
        else
            btn:Hide()
        end
    end

    if self.dragOverlay then
        self.dragOverlay:SetFrameLevel((self.bar:GetFrameLevel() or 0) + 50)
        
        -- [Fix] 动态调整拖拽层大小，覆盖所有按钮
        if self.isUnlocked then
            self.dragOverlay:ClearAllPoints()
            
            local totalLength = count * size + (count - 1) * padding
            local extension = totalLength - size
            
            if direction == "DOWN" then
                self.dragOverlay:SetPoint("TOPLEFT", self.bar, "TOPLEFT", -5, 5)
                self.dragOverlay:SetPoint("BOTTOMRIGHT", self.bar, "BOTTOMRIGHT", 5, -extension - 5)
            elseif direction == "UP" then
                self.dragOverlay:SetPoint("BOTTOMLEFT", self.bar, "BOTTOMLEFT", -5, -5)
                self.dragOverlay:SetPoint("TOPRIGHT", self.bar, "TOPRIGHT", 5, extension + 5)
            elseif direction == "RIGHT" then
                self.dragOverlay:SetPoint("TOPLEFT", self.bar, "TOPLEFT", -5, 5)
                self.dragOverlay:SetPoint("BOTTOMRIGHT", self.bar, "BOTTOMRIGHT", extension + 5, -5)
            elseif direction == "LEFT" then
                self.dragOverlay:SetPoint("TOPRIGHT", self.bar, "TOPRIGHT", 5, 5)
                self.dragOverlay:SetPoint("BOTTOMLEFT", self.bar, "BOTTOMLEFT", -extension - 5, -5)
            end
        end
    end
end

-- =============================================
-- 界面绘制 (标准化接口)
-- =============================================
function Module:DrawSettings(container)
    local UILib = RS.UILib
    
    -- [TOC 版本检查]
    -- 强制忽略版本检查，确保 UI 可见
    -- if not RS:IsBarModuleSupported() then ... end

    local scroll = UILib:CreateScrollFrame({
        layout = "List",
        parent = container
    })

    UILib:AddSpacer(scroll, 10)
    
    -- ========================================
    -- [RS] 法师传送门动作条
    -- ========================================
    local consGroup = UILib:CreateSimpleGroup({
        layout = "List",
        fullWidth = true,
        parent = scroll
    })
    
    -- 模块标题
    UILib:CreateSectionHeader(consGroup, "法师动作条 (传送门)", 10, 5)

    -- 控制选项组 (Flow 布局)
    local checkGroup = UILib:CreateSimpleGroup({
        layout = "Flow",
        fullWidth = true,
        parent = consGroup
    })

    local isSpellBarEnabled = false
    local isPreviewEnabled = false
    if self.db and self.db.profile then
        isSpellBarEnabled = self.db.profile.spellBarEnabled
        if isSpellBarEnabled == nil then isSpellBarEnabled = true end
    end
    isPreviewEnabled = self.previewEnabled or false

    -- 选项：启用
    UILib:CreateCheckBox({
        label = "启用 (仅法师)",
        value = isSpellBarEnabled,
        width = 150,
        onValueChanged = function(widget, value)
            self:ToggleSpellBar(value)
        end,
        parent = checkGroup
    })

    -- 选项：预览
    UILib:CreateCheckBox({
        label = "预览 (调试用)",
        value = isPreviewEnabled,
        width = 150,
        onValueChanged = function(widget, value)
            self:TogglePreview(value)
        end,
        parent = checkGroup
    })

    -- 选项：生长方向
    local dirValue = self.db.profile.direction or "DOWN"
    if dirValue == "VERTICAL" then dirValue = "DOWN" end
    if dirValue == "HORIZONTAL" then dirValue = "RIGHT" end

    UILib:CreateDropdown({
        label = "生长方向",
        value = dirValue,
        list = AVAILABLE_DIRECTIONS,
        width = 200,
        onValueChanged = function(widget, value)
            self.db.profile.direction = value
            self:UpdateBar()
        end,
        parent = checkGroup
    })

    -- 按钮组
    UILib:AddSpacer(consGroup, 20)
    local btnGroup = UILib:CreateSimpleGroup({
        layout = "Flow",
        fullWidth = true,
        parent = consGroup
    })

    UILib:AddHorizontalSpacer(btnGroup, 3)

    local unlockBtn = UILib:CreateButton({
        text = "解锁动作条",
        width = 147,
        height = 35,
        parent = btnGroup
    })

    -- 错误提示
    local errorLabel = UILib:CreateLabel({
        text = "",
        color = {1, 0, 0},
        fullWidth = false,
        parent = btnGroup
    })
    errorLabel:SetWidth(250)

    unlockBtn:SetCallback("OnClick", function()
        local _, playerClass = UnitClass("player")
        local isMage = (playerClass == "MAGE")
        local isPreview = self.previewEnabled

        if not isMage and not isPreview then
            errorLabel:SetText("  非法师职业，勾选“预览”调试")
            C_Timer.After(2, function() errorLabel:SetText("") end)
        else
            self:ToggleAnchor()
        end
    end)

    UILib:AddSpacer(consGroup, 4)

    -- 说明文本
    local colorCode = RS:GetThemeColorCode() 
    local rsmText = colorCode .. "/rsm|r"

    local line1 = UILib:CreateSimpleGroup({
        layout = "Flow",
        fullWidth = true,
        parent = consGroup
    })
    
    UILib:AddHorizontalSpacer(line1, 3)
    
    local label1 = UILib:CreateLabel({
        text = "输入：" .. rsmText .. "，解锁/锁定动作条位置。",
        fullWidth = false,
        parent = line1
    })
    if label1.SetRelativeWidth then
        label1:SetRelativeWidth(0.96)
    end

    local line2 = UILib:CreateSimpleGroup({
        layout = "Flow",
        fullWidth = true,
        parent = consGroup
    })

    UILib:AddHorizontalSpacer(line2, 3)

    local label2 = UILib:CreateLabel({
        text = "功能说明：左键|A:NPE_LeftClick:18:18:0:0|a开启传送门，右键|A:NPE_RightClick:18:18:0:0|a传送。",
        fullWidth = false,
        parent = line2
    })
    if label2.SetRelativeWidth then
        label2:SetRelativeWidth(0.96)
    end
end
