--[[
    LootMonitor 2.01
]]

local _, Addon = ...

local Config = Addon.Config
local L = Addon.L

local SetWindow = Addon.SetWindow

-- Local API提升效率
local t_insert = table.insert

-- 初始化SetWindow
function SetWindow:Initialize()
    -- 创建SetWindow框体
    local f = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
    f:SetWidth(360)
    f:SetHeight(510)
    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = {left = 8, right = 8, top = 10, bottom = 10}
    })
    f:SetBackdropColor(0, 0, 0)
    f:SetPoint("CENTER", 400, 0)
    f:SetToplevel(true)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self)
        if not InCombatLockdown() then
            f:StartMoving()
        end
    end)
    f:SetScript("OnDragStop", function(self)
        f:StopMovingOrSizing()
    end)
    f:SetScript("OnMouseDown", clearAllFocus)
    f:SetPropagateKeyboardInput(false)
    f:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            f:SetPropagateKeyboardInput(false)
            f:Hide()
        else
            f:SetPropagateKeyboardInput(true)
        end
    end)
    f:Hide()
    self.background = f
    do -- 创建框体标题栏纹理
        local t = f:CreateTexture(nil, "ARTWORK")
        t:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")
        t:SetWidth(360)
        t:SetHeight(64)
        t:SetPoint("TOP", f, 0, 12)
        f.texture = t
    end
    do -- 创建框体标题
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        t:SetText(string.format(L["GatherBot v%s"], Addon.Version))
        t:SetPoint("TOP", f.texture, 0, -14)
    end
    do -- 创建关闭按钮
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b:SetWidth(120)
        b:SetHeight(25)
        b:SetPoint("BOTTOMLEFT", 220, 20)
        b:SetText(CLOSE)
        b:SetScript("OnClick", function() f:Hide() end)
    end
    do -- 插件开关
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t:SetText(L["Enabled"])
        local c = CreateFrame("CheckButton", nil, f, "InterfaceOptionsCheckButtonTemplate")
        c:SetPoint("TOPLEFT", 15, -40)
        t:SetPoint("LEFT", c, "RIGHT", 5, 0)
        c:SetScript("OnShow", function(self) self:SetChecked(Config.Enabled) end)
        c:SetScript("OnClick", function(self)
            Config.Enabled = self:GetChecked()
            Addon:GetCurrentSpells()
            if Addon.TrackingSpellsNum >= 2 then
                PlaySound(8959)
                if Config.Enabled then
                    Config.CurrentStatus = true
                    UIErrorsFrame:AddMessage(L["<|cFFBA55D3GB|r>Truned the Tracking Auto Switch to ON."])
                    Addon.Frame:Show()
                elseif not Config.Enabled then
                    Config.CurrentStatus = false
                    UIErrorsFrame:AddMessage(L["<|cFFBA55D3GB|r>Truned the Tracking Auto Switch to OFF."])
                    Addon.Frame:Hide()
                end
            end
        end)
    end
    do -- 骑马自动切换开关
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t:SetText(L["MountAuto"])
        local c = CreateFrame("CheckButton", nil, f, "InterfaceOptionsCheckButtonTemplate")
        c:SetPoint("TOPLEFT", 115, -40)
        t:SetPoint("LEFT", c, "RIGHT", 5, 0)
        c:SetScript("OnShow", function(self)
            self:SetChecked(Config.MountSwitch)
            if Config.MountSwitch and not (IsMounted() or Addon.IsInTravelMode) and not Addon.Frame:IsShow() then
                Addon.Frame:Show()
            elseif not Config.MountSwitch and (IsMounted() or Addon.IsInTravelMode) and Addon.Frame:IsShow() then
                Addon.Frame:Hide()
            end
        end)
        c:SetScript("OnClick", function(self) Config.MountSwitch = self:GetChecked() end)
    end
    do -- 原地自动切换开关
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t:SetText(L["Standby"])
        local c = CreateFrame("CheckButton", nil, f, "InterfaceOptionsCheckButtonTemplate")
        c:SetPoint("TOPLEFT", 235, -40)
        t:SetPoint("LEFT", c, "RIGHT", 5, 0)
        c:SetScript("OnShow", function(self) self:SetChecked(Config.Standby) end)
        c:SetScript("OnClick", function(self) Config.Standby = self:GetChecked() end)
    end
    do -- 战斗骑马自动切换开关
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t:SetText(L["CombatMount"])
        local c = CreateFrame("CheckButton", nil, f, "InterfaceOptionsCheckButtonTemplate")
        c:SetPoint("TOPLEFT", 115, -80)
        t:SetPoint("LEFT", c, "RIGHT", 5, 0)
        c:SetScript("OnShow", function(self) self:SetChecked(Config.MountedCombat) end)
        c:SetScript("OnClick", function(self) Config.MountedCombat = self:GetChecked() end)
    end
    do -- 小地图按钮
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t:SetText(L["Mini Btn"])
        local c = CreateFrame("CheckButton", nil, f, "InterfaceOptionsCheckButtonTemplate")
        c:SetPoint("TOPLEFT", 15, -80)
        t:SetPoint("LEFT", c, "RIGHT", 5, 0)
        c:SetScript("OnShow", function(self) self:SetChecked(Config.MinimapIcon) end)
        c:SetScript("OnClick", function(self)
            Config.MinimapIcon = self:GetChecked()
            if Config.MinimapIcon and not Addon.MinimapIcon.Minimap:IsShown() then
                Addon.MinimapIcon.Minimap:Show()
            else
                Addon.MinimapIcon.Minimap:Hide()
            end
        end)
    end
    do -- Check Stats 和 Show Logs 按钮
        -- 显示框
        SetWindow.DisplayGroup = {}
        do
            for i = 1, 10 do
                local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
                t:SetWidth(220)
                t:SetHeight(25)
                t:SetText("")
                t:SetPoint("TOPLEFT", f, 20, -145 - i * 15)
                t_insert(SetWindow.DisplayGroup, t)
            end
        end
        -- Switch Time
        local t1 = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        t1:SetText(L["Switch In "])
        local t2 = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        t2:SetText(L[" Seconds"])
        local e1 = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
        e1:SetWidth(30)
        e1:SetHeight(25)
        e1:SetAutoFocus(false)
        e1:SetMaxLetters(2)
        e1:SetNumeric()
        e1:SetScript("OnEnterPressed", function(self)
            if self:HasFocus() then
                if tonumber(self:GetText()) then
                    local Seconds = math.floor(tonumber(self:GetText()))
                    if Seconds >= 2 and Seconds <= 20 then
                        Config.SwitchTime = Seconds
                    end
                end
            end
            self:SetText(tostring(Config.SwitchTime))
            self:ClearFocus()
        end)
        e1:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
        e1:SetScript("OnEscapePressed", function(self)
            self:SetText(tostring(Config.SwitchTime))
            self:ClearFocus()
        end)
        e1:SetScript("OnShow", function(self) self:SetText(tostring(Config.SwitchTime)) end)
        e1:SetPoint("BOTTOMLEFT", f, 105, 20)
        t1:SetPoint("RIGHT", e1, "LEFT", -10, 0)
        t2:SetPoint("LEFT", e1, "RIGHT", 5, 0)
        -- Spell ID Input Line
        local e2 = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
        e2:SetWidth(100)
        e2:SetHeight(30)
        -- e2:SetNumeric()
        e2:SetAutoFocus(false)
        e2:SetPoint("TOPLEFT", 30, -113)
        e2:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
        -- Check All Button
        local b1 = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b1:SetWidth(90)
        b1:SetHeight(25)
        b1:SetText(L["ADD"])
        b1:SetScript("OnClick", function()
            if tonumber(e2:GetText()) then
                if IsPlayerSpell(tonumber(e2:GetText())) then
                    Config.SwitchSpells[tonumber(e2:GetText())] = true
                    e2:SetText("")
                    Addon:ShowSpellInfo()
                else
                    print(L["<|cFFBA55D3GB|r>You do not have this spell."])
                end
            else
                local SpellID = select(7, GetSpellInfo(e2:GetText()))
                if SpellID then
                    Config.SwitchSpells[SpellID] = true
                    e2:SetText("")
                    Addon:ShowSpellInfo()
                else
                    e2:SetText("")
                    print(L["<|cFFBA55D3GB|r>You do not have this spell."])
                end
            end
        end)
        -- Show State Button
        local b2 = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b2:SetWidth(90)
        b2:SetHeight(25)
        b2:SetText(L["REMOVE"])
        b2:SetScript("OnClick", function()
            if tonumber(e2:GetText()) then
                if Config.SwitchSpells[tonumber(e2:GetText())] then
                    Config.SwitchSpells[tonumber(e2:GetText())] = nil
                end
            else
                local SpellID = select(7, GetSpellInfo(e2:GetText()))
                if SpellID then
                    Config.SwitchSpells[SpellID] = nil
                end
            end
            e2:SetText("")
        end)
        b1:SetPoint("TOPLEFT", 140, -115)
        b2:SetPoint("TOPLEFT", 235, -115)
    end
end