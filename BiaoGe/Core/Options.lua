if BG.IsBlackListPlayer then return end
local AddonName, ns                     = ...

local LibBG                             = ns.LibBG
local L                                 = ns.L

local RR                                = ns.RR
local NN                                = ns.NN
local RN                                = ns.RN
local Size                              = ns.Size
local RGB                               = ns.RGB
local RGB_16                            = ns.RGB_16
local GetClassRGB                       = ns.GetClassRGB
local SetClassCFF                       = ns.SetClassCFF
local GetText_T                         = ns.GetText_T
local AddTexture                        = ns.AddTexture
local GetItemID                         = ns.GetItemID
local Maxb                              = ns.Maxb

local player                            = BG.playerName
local realmID                           = GetRealmID()

local pt                                = print

local O                                 = {}

local IsAddOnLoaded                     = IsAddOnLoaded or C_AddOns.IsAddOnLoaded
ns.InterfaceOptions_AddCategory         = _G.InterfaceOptions_AddCategory or function(frame, addOn, position)
    if frame.parent then
        local category            = _G.Settings.GetCategory(frame.parent)
        local subcategory, layout = _G.Settings.RegisterCanvasLayoutSubcategory(category, frame, frame.name, frame.name)
        subcategory.ID            = frame.name
        return subcategory, category
    else
        local category, layout = _G.Settings.RegisterCanvasLayoutCategory(frame, frame.name, frame.name)
        category.ID            = frame.name
        _G.Settings.RegisterAddOnCategory(category)
        return category
    end
end

ns.InterfaceOptionsFrame_OpenToCategory = _G.InterfaceOptionsFrame_OpenToCategory or function(categoryIDOrFrame)
    if type(categoryIDOrFrame) == "table" then
        local categoryID = categoryIDOrFrame.name;
        return _G.Settings.OpenToCategory(categoryID);
    else
        return _G.Settings.OpenToCategory(categoryIDOrFrame);
    end
end


BG.Init(function()
    local main = CreateFrame("Frame", nil, UIParent)
    do
        main:Hide()
        main.name = "|cff00BFFFBiaoGe|r"
        ns.InterfaceOptions_AddCategory(main)
        local t = main:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        t:SetText("|cff" .. "00BFFF" .. L["< BiaoGe > 金 团 表 格"] .. "|r")
        t:SetPoint("TOPLEFT", main, 15, 0)
        local top = t
        local t = main:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall2")
        t:SetText(L["|cff808080（带*的设置为即时生效，否则需要重载才能生效）|r"])
        t:SetPoint("BOTTOMLEFT", top, "BOTTOMRIGHT", 5, 0)
        -- 重载
        local bt = BG.CreateButton(main)
        bt:SetSize(80, 20)
        bt:SetPoint("TOPRIGHT", -5, 0)
        bt:SetText(L["重载界面"])
        bt:SetScript("OnClick", function(self)
            ReloadUI()
        end)
        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:SetText(L["不能即时生效的设置在重载后生效"])
        end)
        bt:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
    end
    -- 背景框
    do
        local f = CreateFrame("Frame", nil, main, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetPoint("TOPLEFT", SettingsPanel.Container, 5, -60)
        f:SetPoint("BOTTOMRIGHT", SettingsPanel.Container, -5, 0)
        BG.optionsBackground = f
        -- 点空白处取消光标
        SettingsPanel.Container:HookScript("OnMouseDown", function(self, enter)
            local f = GetCurrentKeyBoardFocus()
            if f then
                f:ClearFocus()
            end
        end)
    end

    -- 子选项
    local Frames = {}
    local biaoge, autoAuction, roleOverview, boss, others, config
    do
        local last

        function BG.OptionsCreateTab(name, text) -- "Options_biaoge",L["表格"]
            local bt = CreateFrame("Button", "BG.Button" .. name, main)
            bt:SetHeight(25)
            bt:SetNormalFontObject(BG.FontBlue15)
            bt:SetDisabledFontObject(BG.FontWhite18)
            bt:SetHighlightFontObject(BG.FontWhite15)
            local tex = bt:CreateTexture(nil, "ARTWORK") -- 高亮材质
            tex:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight")
            bt:SetHighlightTexture(tex)
            if not last then
                bt:SetPoint("TOPLEFT", 15, -35)
            else
                bt:SetPoint("LEFT", last, "RIGHT", 0, 0)
            end
            bt:SetText(text)
            local t = bt:GetFontString()
            bt:SetWidth(t:GetStringWidth() + 20)
            BG["Button" .. name] = bt
            last = bt
            bt:SetScript("OnClick", function(self)
                BG.HideTab(Frames, BG["Frame" .. name])
                BiaoGe.options.lastFrame = "Frame" .. name
                BG.PlaySound(1)
            end)

            local f = CreateFrame("Frame", nil, bt)
            tinsert(Frames, f)
            f:Hide()
            BG["Frame" .. name] = f
            local frame = CreateFrame("Frame", nil, f)
            frame:SetSize(1, 1)
            local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
            scroll:SetPoint("TOPLEFT", SettingsPanel.Container, 15, -70)
            scroll:SetPoint("BOTTOMRIGHT", SettingsPanel.Container, -35, 10)
            scroll.ScrollBar.scrollStep = BG.scrollStep
            BG.CreateSrollBarBackdrop(scroll.ScrollBar)
            BG.HookScrollBarShowOrHide(scroll)
            scroll:SetScrollChild(frame)
            frame.scroll = scroll

            return frame
        end

        biaoge = BG.OptionsCreateTab("Options_biaoge", L["表格"])
        autoAuction = BG.OptionsCreateTab("Options_autoAuction", L["自动拍卖"])
        roleOverview = BG.OptionsCreateTab("Options_roleOverview", L["角色总览"])
        if BG.IsWLK then
            boss = BG.OptionsCreateTab("Options_boss", L["团本攻略"])
        end
        others = BG.OptionsCreateTab("Options_others", L["其他功能"])
        config = BG.OptionsCreateTab("Options_config", L["角色配置"])

        if BiaoGe.options.lastFrame and BG[BiaoGe.options.lastFrame] then
            BG[BiaoGe.options.lastFrame]:Show()
            BG[BiaoGe.options.lastFrame]:GetParent():SetEnabled(false)
        else
            BG.FrameOptions_biaoge:Show()
            BG.FrameOptions_biaoge:GetParent():SetEnabled(false)
        end
    end

    -- 模板
    do
        -- 滑块
        do
            local function updateSliderEditBox(self)
                local slider = self.__owner
                local minValue, maxValue = slider:GetMinMaxValues()
                local text = tonumber(self:GetText())
                if not text then return end
                text = min(maxValue, text)
                text = max(minValue, text)
                slider:SetValue(text)
                self:SetText(text)
                BiaoGe.options[slider.name] = text
                self:ClearFocus()
                BG.PlaySound(1)
            end
            local function OnValueChanged(self, value)
                self.edit:ClearFocus()
                value = tonumber(value)
                BiaoGe.options[self.name] = value
                self.edit:SetText(value)
            end
            local function OnClick(self, enter)
                local slider = self.__owner
                if enter == "RightButton" then
                    if BG.options[slider.name .. "reset"] then
                        local value = BG.options[slider.name .. "reset"]
                        BiaoGe.options[slider.name] = value
                        slider:SetValue(value)
                        slider.edit:SetText(value)
                        BG.PlaySound(1)
                    end
                end
            end
            local function OnEnter(self)
                local slider = self.__owner
                if slider.ontext then
                    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 5)
                    GameTooltip:ClearLines()
                    if type(slider.ontext) == "table" then
                        for i, text in ipairs(slider.ontext) do
                            if i == 1 then
                                GameTooltip:AddLine(text, 1, 1, 1, true)
                            else
                                GameTooltip:AddLine(text, 1, 0.82, 0, true)
                            end
                            GameTooltip:Show()
                        end
                    else
                        GameTooltip:SetText(slider.ontext)
                    end
                end
            end
            local function OnLeave(self)
                GameTooltip:Hide()
            end
            function O.CreateSlider(name, text, parent, minValue, maxValue, step, x, y, ontext, width)
                local value = min(maxValue, BiaoGe.options[name])
                value = max(minValue, value)
                BiaoGe.options[name] = value

                local template = BG.IsNewUI and "TextToSpeechSliderTemplate" or "OptionsSliderTemplate"
                local slider = CreateFrame("Slider", nil, parent, template)
                slider:SetPoint("TOPLEFT", parent, x, y)
                slider:SetWidth(width or 180)
                slider:SetMinMaxValues(minValue, maxValue)
                slider:SetValueStep(step)
                slider:SetObeyStepOnDrag(true)
                slider:SetHitRectInsets(0, 0, 0, 0)
                slider:SetValue(BiaoGe.options[name])
                slider.name = name
                slider.ontext = ontext
                slider:SetScript("OnValueChanged", OnValueChanged)

                slider.Low:SetText(minValue)
                slider.Low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 10, -2)
                slider.High:SetText(maxValue)
                slider.High:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -10, -2)
                slider.Text:ClearAllPoints()
                slider.Text:SetPoint("CENTER", 0, 25)
                slider.Text:SetText(text)
                slider.Text:SetTextColor(1, .8, 0)

                slider.edit = CreateFrame("EditBox", nil, slider, "InputBoxTemplate")
                slider.edit:SetSize(50, 20)
                slider.edit:SetPoint("TOP", slider, "BOTTOM")
                slider.edit:SetJustifyH("CENTER")
                slider.edit:SetAutoFocus(false)
                slider.edit:SetText(BiaoGe.options[name])
                slider.edit:SetCursorPosition(0)
                slider.edit.__owner = slider
                slider.edit:SetScript("OnEnterPressed", updateSliderEditBox)
                slider.edit:SetScript("OnEditFocusLost", updateSliderEditBox)

                slider.button = CreateFrame("Button", nil, slider)
                slider.button:SetAllPoints(slider.Text)
                slider.button:RegisterForClicks("RightButtonUp")
                slider.button.__owner = slider
                slider.button:SetScript("OnClick", OnClick)
                slider.button:SetScript("OnEnter", OnEnter)
                slider.button:SetScript("OnLeave", OnLeave)

                return slider
            end
        end
        -- 多选按钮
        do
            local function OnClick(self)
                if self:GetChecked() then
                    BiaoGe.options[self.name] = 1
                else
                    BiaoGe.options[self.name] = 0
                end
                BG.PlaySound(1)
            end
            local function OnEnter(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                if type(self.ontext) == "table" then
                    for i, text in ipairs(self.ontext) do
                        if i == 1 then
                            GameTooltip:AddLine(text, 1, 1, 1, true)
                        else
                            GameTooltip:AddLine(text, 1, 0.82, 0, true)
                        end
                        GameTooltip:Show()
                    end
                else
                    GameTooltip:SetText(self.ontext)
                end
            end
            local function OnLeave(self)
                GameTooltip:Hide()
            end
            function O.CreateCheckButton(name, text, parent, x, y, ontext)
                local bt = CreateFrame("CheckButton", nil, parent, "ChatConfigCheckButtonTemplate")
                bt:SetSize(30, 30)
                bt:SetPoint("TOPLEFT", parent, x, y)
                bt.Text:SetText(text)
                bt:SetHitRectInsets(0, -bt.Text:GetWidth(), 0, 0)
                bt.name = name
                bt.ontext = ontext
                BG.options["button" .. name] = bt
                if BiaoGe.options[name] == 1 then
                    bt:SetChecked(true)
                else
                    bt:SetChecked(false)
                end
                bt:SetScript("OnClick", OnClick)
                bt:SetScript("OnEnter", OnEnter)
                bt:SetScript("OnLeave", OnLeave)
                return bt
            end
        end
        -- 线
        do
            function O.CreateLine(parent, y, height)
                local l = parent:CreateLine()
                l:SetColorTexture(RGB("808080", 1))
                l:SetStartPoint("TOPLEFT", 5, y)
                l:SetEndPoint("TOPLEFT", SettingsPanel.Container:GetWidth() - 20, y)
                l:SetThickness(height or 1.5)
                return l
            end
        end
    end
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -- 表格设置
    do
        local height = 0
        local h = 30
        -- UI缩放
        do
            local name = "scale"
            do
                local ui = UIParent:GetScale()
                if tonumber(ui) >= 0.85 then
                    BG.options[name .. "reset"] = 0.7
                elseif tonumber(ui) >= 0.75 then
                    BG.options[name .. "reset"] = 0.8
                elseif tonumber(ui) >= 0.65 then
                    BG.options[name .. "reset"] = 0.9
                else
                    BG.options[name .. "reset"] = 1
                end

                if not BiaoGe.options[name] then
                    if BiaoGe.Scale then
                        BiaoGe.options[name] = BiaoGe.Scale
                    else
                        BiaoGe.options[name] = BG.options[name .. "reset"]
                    end
                end
                BG.MainFrame:SetScale(BiaoGe.options[name])
                BG.ReceiveMainFrame:SetScale(tonumber(BiaoGe.options[name]) * 0.95)
                if BG.FBCDFrame then
                    BG.FBCDFrame:SetScale(BiaoGe.options[name])
                end
            end

            local ontext = {
                L["UI缩放"] .. L["|cff808080（右键还原设置）|r"],
                L["调整表格UI的大小。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateSlider(name, "|cffFFFFFF" .. L["UI缩放*"] .. "|r", biaoge, 0.5, 1.5, 0.05, 15, height - h, ontext)
            BG.options["button" .. name] = f

            f:SetScript("OnValueChanged", function(self, value)
                f.edit:ClearFocus()
                value = tonumber(string.format("%.2f", value))
                BiaoGe.options[name] = value
                f.edit:SetText(value)
                BG.MainFrame:SetScale(value)
                BG.ReceiveMainFrame:SetScale(tonumber(value) * 0.95)
                if BG.FBCDFrame then
                    BG.FBCDFrame:SetScale(value)
                end
            end)
            f.button:SetScript("OnClick", function(self, enter)
                if enter == "RightButton" then
                    if BG.options[name .. "reset"] then
                        local value = BG.options[name .. "reset"]
                        BiaoGe.options[name] = value
                        f:SetValue(value)
                        f.edit:SetText(value)
                        BG.MainFrame:SetScale(value)
                        BG.ReceiveMainFrame:SetScale(tonumber(value) * 0.95)
                        if BG.FBCDFrame then
                            BG.FBCDFrame:SetScale(value)
                        end
                        BG.PlaySound(1)
                    end
                end
            end)
        end
        -- 背景材质透明度
        do
            local name = "alpha"
            BG.options[name .. "reset"] = 0.8
            if not BiaoGe.options[name] then
                if BiaoGe.Alpha then
                    BiaoGe.options[name] = BiaoGe.Alpha
                else
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
            end
            if type(BiaoGe.options[name]) ~= "number" then
                BiaoGe.options[name] = BG.options[name .. "reset"]
            end

            local ontext = {
                L["背景材质透明度"] .. L["|cff808080（右键还原设置）|r"],
                L["调整背景材质透明度。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateSlider(name, "|cffFFFFFF" .. L["背景材质透明度*"] .. "|r", biaoge, 0, 1, 0.05, 220, height - h, ontext)
            BG.options["button" .. name] = f

            f:SetScript("OnValueChanged", function(self, value)
                f.edit:ClearFocus()
                value = tonumber(string.format("%.2f", value))
                BiaoGe.options[name] = value
                f.edit:SetText(value)
                BG.MainFrame.Bg:SetAlpha(value)
            end)
            f.button:SetScript("OnClick", function(self, enter)
                if enter == "RightButton" then
                    if BG.options[name .. "reset"] then
                        local value = BG.options[name .. "reset"]
                        BiaoGe.options[name] = value
                        f:SetValue(value)
                        f.edit:SetText(value)
                        BG.MainFrame.Bg:SetAlpha(value)
                        BG.PlaySound(1)
                    end
                end
            end)
        end
        -- 背景材质
        do
            local name = "bg"
            BG.options[name .. "reset"] = "0.01,0.01,0.01,0.8"
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            if BiaoGe.options[name] == "0,0,0,0.8" then
                BiaoGe.options[name] = "0.01,0.01,0.01,0.8"
            end

            local table = {
                { tex = "Interface/FrameGeneral/UI-Background-Rock", name = L["岩石"], alpha = 1 },
                { tex = "Interface/FrameGeneral/UI-Background-Marble", name = L["大理石"], alpha = 1 },
                -- { tex = "0,0,0,0.8", name = L["黑夜"], },
                { tex = "0.01,0.01,0.01,0.8", name = L["黑夜"], },
                { tex = "0,0,0,0", name = L["皇帝的新衣"], },
            }

            local function SetTex(v, setAlpha)
                if strfind(v, "/") or strfind(v, "\\") or not strfind(v, ",") then
                    BG.MainFrame.Bg:SetTexture(v, "REPEAT", "REPEAT")
                    BG.MainFrame.Bg:SetHorizTile(true)
                    BG.MainFrame.Bg:SetVertTile(true)

                    if setAlpha then
                        local a = 1
                        for index, value in ipairs(table) do
                            if v == value.tex then
                                a = value.alpha or 1
                            end
                        end
                        BiaoGe.options["alpha"] = a
                        BG.options["buttonalpha"]:SetValue(BiaoGe.options["alpha"])
                        BG.options["buttonalpha"].edit:SetText(BiaoGe.options["alpha"])
                        BG.MainFrame.Bg:SetAlpha(BiaoGe.options["alpha"])
                    end
                else
                    local r, g, b, a = strsplit(",", v)
                    if not a then a = 0.8 end
                    a = tonumber(a)
                    BG.MainFrame.Bg:SetColorTexture(r, g, b)

                    if setAlpha then
                        BiaoGe.options["alpha"] = a
                        BG.options["buttonalpha"]:SetValue(BiaoGe.options["alpha"])
                        BG.options["buttonalpha"].edit:SetText(BiaoGe.options["alpha"])
                        BG.MainFrame.Bg:SetAlpha(tonumber(BiaoGe.options["alpha"]))
                    end
                end
            end
            local function Settext(text)
                for i, v in ipairs(table) do
                    if v.tex == text then
                        return v.name
                    end
                end
                return ""
            end

            BG.MainFrame.Bg:SetAlpha(BiaoGe.options["alpha"])
            SetTex(BiaoGe.options[name])

            local dropDown = LibBG:Create_UIDropDownMenu(nil, biaoge)
            dropDown:SetPoint("TOPLEFT", 430, height - h + 0)
            LibBG:UIDropDownMenu_SetWidth(dropDown, 120)
            LibBG:UIDropDownMenu_SetText(dropDown, Settext(BiaoGe.options[name]))
            LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "TOP", dropDown, "BOTTOM")
            BG.dropDownToggle(dropDown)
            BG.options["button" .. name] = dropDown

            local t = dropDown:CreateFontString()
            t:SetPoint("BOTTOM", dropDown, "TOP", 0, 8)
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetTextColor(1, 1, 1)
            t:SetText(L["背景材质*"])

            LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
                for i, v in ipairs(table) do
                    local info = LibBG:UIDropDownMenu_CreateInfo()
                    info.text = v.name
                    info.func = function()
                        BiaoGe.options[name] = v.tex
                        SetTex(v.tex, "alpha")
                        LibBG:UIDropDownMenu_SetText(dropDown, v.name)
                    end
                    if v.tex == BiaoGe.options[name] then
                        info.checked = true
                    end
                    LibBG:UIDropDownMenu_AddButton(info)
                end
            end)
        end
        h = h + 60

        O.CreateLine(biaoge, height - h)
        h = h + 15
        -- 自动记录装备
        do
            local name = "autoLoot"
            BG.options[name .. "reset"] = 1
            if not BiaoGe.options[name] then
                if BiaoGe.AutoLoot then
                    BiaoGe.options[name] = BiaoGe.AutoLoot
                else
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
            end
            local ontext = {
                L["自动记录装备"],
                L["在团本里拾取装备时，会自动记录进表格。"],
                " ",
                L["不同的副本，要求的最低品质会不同。大团本一般从紫装开始记录，小团本一般从蓝装开始记录。小怪的掉落会记录到杂项里。"],
            }
            local f = O.CreateCheckButton(name, BG.STC_g1(L["自动记录装备*"]), biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local name1 = "lootTime"
                local name2 = "lootFontSize"
                local name3 = "autolootNotice"
                local name4 = "autolootRemind"
                if f:GetChecked() then
                    BG.options["button" .. name1]:Show()
                    BG.options["button" .. name2]:Show()
                    BG.options["button" .. name3]:Show()
                    BG.options["button" .. name4]:Show()
                else
                    BG.options["button" .. name1]:Hide()
                    BG.options["button" .. name2]:Hide()
                    BG.options["button" .. name3]:Hide()
                    BG.options["button" .. name4]:Hide()
                end
            end)
        end
        -- 装备记录通知显示时长
        do
            local name = "lootTime"
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["装备记录通知时长"] .. L["|cff808080（右键还原设置）|r"],
                L["自动记录装备后会在屏幕上方通知记录结果。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateSlider(name, "|cffFFFFFF" .. L["装备记录通知时长(秒)"] .. "|r", biaoge, 1, 30, 1, 220, height - h - 25, ontext)
            BG.options["button" .. name] = f
            local name = "autoLoot"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        -- 装备记录通知字体大小
        do
            local name = "lootFontSize"
            BG.options[name .. "reset"] = 20
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["装备记录通知字号"] .. L["|cff808080（右键还原设置）|r"],
                L["调整该字体的大小。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateSlider(name, "|cffFFFFFF" .. L["装备记录通知字号"] .. "*" .. "|r", biaoge, 10, 30, 1, 425, height - h - 25, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnValueChanged", function(self, value)
                BG.FrameLootMsg:SetFont(STANDARD_TEXT_FONT, value, "OUTLINE")
            end)
            local name = "autoLoot"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 记录装备通知
        do
            local name = "autolootNotice"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["装备记录通知"],
                L["自动记录装备后会在屏幕上方显示记录了什么装备、记录在哪个BOSS槽位。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateCheckButton(name, L["装备记录通知"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            local name = "autoLoot"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 未拾取提醒
        do
            local name = "autolootRemind"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["装备未拾取提醒"],
                L["击杀BOSS超过30秒装备还没拾取，且你是物品分配者时，屏幕中间红字提醒。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateCheckButton(name, AddTexture("QUEST") .. L["装备未拾取提醒"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            local name = "autoLoot"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 40

        O.CreateLine(biaoge, height - h)
        h = h + 15
        -- 交易自动记账
        do
            local name = "autoTrade"
            BG.options[name .. "reset"] = 1
            if not BiaoGe.options[name] then
                if BiaoGe.AutoTrade then
                    BiaoGe.options[name] = BiaoGe.AutoTrade
                else
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
            end
            local ontext = {
                L["交易自动记账"],
                L["需要配合自动记录装备，因为如果表格里没有该交易的装备，则记账失败。"],
                " ",
                L["如果一次交易两件装备以上，则只会记第一件装备。"],
            }
            local f = O.CreateCheckButton(name, BG.STC_g1(L["交易自动记账*"]), biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local name1 = "tradePreview"
                local name2 = "tradeNotice"
                local name3 = "tradeTime"
                local name4 = "tradeFontSize"
                local name5 = "tradeMoneyTop"
                local name7 = "qiankuanTrade"
                local name8 = "tradeSameMoney"
                local name9 = "isTrading"
                if f:GetChecked() then
                    BG.options["button" .. name1]:Show()
                    BG.options["button" .. name2]:Show()
                    BG.options["button" .. name3]:Show()
                    BG.options["button" .. name4]:Show()
                    BG.options["button" .. name5]:Show()
                    BG.options["button" .. name7]:Show()
                    BG.options["button" .. name8]:Show()
                    BG.options["button" .. name9]:Show()
                else
                    BG.options["button" .. name1]:Hide()
                    BG.options["button" .. name2]:Hide()
                    BG.options["button" .. name3]:Hide()
                    BG.options["button" .. name4]:Hide()
                    BG.options["button" .. name5]:Hide()
                    BG.options["button" .. name7]:Hide()
                    BG.options["button" .. name8]:Hide()
                    BG.options["button" .. name9]:Hide()
                end
            end)
        end
        -- 交易通知显示时长
        do
            local name = "tradeTime"
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["交易通知时长"] .. L["|cff808080（右键还原设置）|r"],
                L["通知显示多久。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateSlider(name, "|cffFFFFFF" .. L["交易通知时长(秒)"] .. "|r", biaoge, 1, 10, 1, 220, height - h - 25, ontext)
            BG.options["button" .. name] = f
            local name = "autoTrade"
            if BiaoGe.options[name] ~= 1 or BiaoGe.options["tradeNotice"] ~= 1 then
                f:Hide()
            end
        end
        -- 交易通知字体大小
        do
            local name = "tradeFontSize"
            BG.options[name .. "reset"] = 20
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["交易通知字号"] .. L["|cff808080（右键还原设置）|r"],
                L["调整该字体的大小。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateSlider(name, "|cffFFFFFF" .. L["交易通知字号"] .. "*" .. "|r", biaoge, 10, 30, 1, 425, height - h - 25, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnValueChanged", function(self, value)
                BG.FrameTradeMsg:SetFont(STANDARD_TEXT_FONT, value, "OUTLINE")
            end)
            local name = "autoTrade"
            if BiaoGe.options[name] ~= 1 or BiaoGe.options["tradeNotice"] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 交易通知
        do
            local name = "tradeNotice"
            BG.options[name .. "reset"] = 1
            if not BiaoGe.options[name] then
                if BiaoGe.AutoTrade then
                    BiaoGe.options[name] = BiaoGe.AutoTrade
                else
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
            end
            local ontext = {
                L["交易通知"],
                L["交易完成后会在屏幕中央通知本次记账结果。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateCheckButton(name, L["交易通知*"], biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local name1 = "tradeTime"
                local name2 = "tradeFontSize"
                if f:GetChecked() then
                    BG.options["button" .. name1]:Show()
                    BG.options["button" .. name2]:Show()
                else
                    BG.options["button" .. name1]:Hide()
                    BG.options["button" .. name2]:Hide()
                end
            end)
            local name = "autoTrade"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 交易增强
        do
            local name = "tradePreview"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["在交易界面右侧增加以下界面"],
                " ",
                L["记账效果预览框："],
                L["可以预览这次的记账效果。"],
                " ",
                L["最近拍卖/对方已拍："],
                L["如果你是物品分配者，会显示最近拍卖且可交易的装备，点击一下就能把装备放到交易里。"],
                " ",
                L["一键发工资："],
                L["增加一键发工资和补贴的按钮。"],
            }
            local f = O.CreateCheckButton(name, AddTexture("QUEST") .. L["交易增强*"], biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            local name = "autoTrade"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 欠款记录
        do
            local name = "qiankuanTrade"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["对方欠款记录"],
                L["交易时，如果对方曾有欠款，则会在交易框下方显示其欠款记录，点击可以清除欠款。"],
            }
            local f = O.CreateCheckButton(name, L["对方欠款记录"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            local name = "autoTrade"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 交易金额超上限提醒
        do
            local name = "tradeMoneyTop"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["交易金额超上限提醒"],
                format(L["交易时，如果交易金额超过游戏上限（%s金），则会红字提醒。"], BG.tradeGoldTop.num),
            }
            local f = O.CreateCheckButton(name, L["交易金额超上限提醒"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            local name = "autoTrade"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 重复交易工资提醒
        do
            local name = "tradeSameMoney"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["重复交易工资提醒"],
                L["如果2分钟内你曾与同一个人交易过相同的金币，会有红字提醒。"],
            }
            local f = O.CreateCheckButton(name, AddTexture("QUEST") .. L["重复交易工资提醒"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            local name = "autoTrade"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 团长是否正在交易
        do
            local name = "isTrading"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["团长是否正在交易"],
                L["在团长的团队框架显示其是否正在交易。"],
                L["支持NDui、ElvUI、Cell、原生框架。"],
            }
            local f = O.CreateCheckButton(name, AddTexture("QUEST") .. L["团长是否正在交易"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            local name = "autoTrade"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 40

        O.CreateLine(biaoge, height - h)
        h = h + 15
        -- 高亮拍卖装备
        do
            local name = "auctionHigh"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["高亮拍卖装备"],
                L["当团长或物品分配者贴出装备开始拍卖时，会自动高亮表格里相应的装备。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateCheckButton(name, BG.STC_g1(L["高亮拍卖装备*"]), biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local name = "auctionHighTime"
                if f:GetChecked() then
                    BG.options["button" .. name]:Show()
                else
                    BG.options["button" .. name]:Hide()
                end
            end)
        end
        -- 高亮拍卖装备时长
        do
            local name = "auctionHighTime"
            BG.options[name .. "reset"] = 20
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["高亮拍卖装备时长"] .. L["|cff808080（右键还原设置）|r"],
                L["高亮拍卖装备多久。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateSlider(name, "|cffFFFFFF" .. L["高亮拍卖装备时长(秒)*"] .. "|r", biaoge, 1, 60, 1, 220, height - h - 25, ontext)
            BG.options["button" .. name] = f
            local name = "auctionHigh"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 高亮对应装备
        do
            local name = "HighOnterItem"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["高亮对应装备"],
                L["当鼠标悬停在表格装备时，高亮背包里对应的装备。"],
                " ",
                L["当鼠标悬停在背包装备时，高亮表格里对应的装备。"],
                " ",
                L["当鼠标悬停在聊天框装备时，高亮表格和背包里对应的装备。"],
                " ",
                L["（背包系统支持原生背包、NDui背包、ElvUI背包、大脚背包、Bagnon）"],
            }
            local f = O.CreateCheckButton(name, L["高亮对应装备"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
        end
        h = h + 50


        O.CreateLine(biaoge, height - h)
        h = h + 15
        -- 拍卖聊天记录框
        do
            local name = "auctionChat"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["拍卖聊天记录框"],
                L["自动记录全团跟拍卖有关的聊天。"],
                " ",
                L["当你点击买家或金额时会显示拍卖聊天记录。"],
            }
            local f = O.CreateCheckButton(name, BG.STC_g1(L["拍卖聊天记录框*"]), biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local name = "auctionChatHoldNew"
                if f:GetChecked() then
                    BG.options["button" .. name]:Show()
                else
                    BG.options["button" .. name]:Hide()
                end
            end)
        end
        h = h + 30
        -- 拍卖聊天记录总是保持在最新位置
        do
            local name = "auctionChatHoldNew"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["拍卖聊天记录总是保持在最新位置"],
                L["每次打开拍卖聊天记录框时，自动回到最新的聊天位置。"],
            }
            local f = O.CreateCheckButton(name, L["拍卖聊天记录总是保持在最新位置"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            local name = "auctionChat"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 40


        O.CreateLine(biaoge, height - h)
        h = h + 15
        -- 拍卖倒数
        do
            local name = "countDown"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["拍卖自动倒数"],
                L["该功能只有团长或物品分配者可用。"],
                " ",
                L["使用方法：右键聊天框装备时开始倒数。"],
            }
            local f = O.CreateCheckButton(name, BG.STC_g1(L["拍卖自动倒数"] .. "*"), biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local name1 = "countDownDuration"
                local name2 = "countDownSendChannel"
                local name3 = "countDownStop"
                if f:GetChecked() then
                    BG.options["button" .. name1]:Show()
                    BG.options["button" .. name2]:Show()
                    BG.options["button" .. name3]:Show()
                else
                    BG.options["button" .. name1]:Hide()
                    BG.options["button" .. name2]:Hide()
                    BG.options["button" .. name3]:Hide()
                end
            end)
        end
        -- 拍卖倒数时长
        do
            local name = "countDownDuration"
            BG.options[name .. "reset"] = 5
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["拍卖倒数时长"] .. L["|cff808080（右键还原设置）|r"],
                format(L["拍卖装备倒数多久，默认是%s秒。"], BG.options[name .. "reset"]),
                -- " ",
                -- L[""],
            }
            local f = O.CreateSlider(name, "|cffFFFFFF" .. L["拍卖倒数时长(秒)"] .. "*" .. "|r", biaoge, 1, 20, 1, 220, height - h - 25, ontext)
            BG.options["button" .. name] = f
            if BiaoGe.options["countDown"] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 倒数自动暂停
        do
            local name = "countDownStop"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["倒数自动暂停"],
                L["正在自动倒数时，如果有人出价（在团队频道打出纯数字时），则自动暂停倒数。"],
            }
            local f = O.CreateCheckButton(name, L["倒数自动暂停"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            if BiaoGe.options["countDown"] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 拍卖倒数通报频道
        do
            local name = "countDownSendChannel"
            BG.options[name .. "reset"] = "RAID"
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]

            local function RaidText(channel)
                local text
                if channel == "RAID_WARNING" then
                    text = L["通报至团队通知频道"]
                elseif channel == "RAID" then
                    text = L["通报至团队频道"]
                end
                return text
            end

            local dropDown = LibBG:Create_UIDropDownMenu(nil, biaoge)
            dropDown:SetPoint("TOPLEFT", 0, height - h - 2)
            LibBG:UIDropDownMenu_SetWidth(dropDown, 170)
            LibBG:UIDropDownMenu_SetText(dropDown, RaidText(BiaoGe.options[name]))
            LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "TOP", dropDown, "BOTTOM")
            BG.dropDownToggle(dropDown)
            BG.options["button" .. name] = dropDown

            LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
                local info = LibBG:UIDropDownMenu_CreateInfo()
                info.text = L["通报至团队通知频道"]
                info.func = function()
                    BiaoGe.options[name] = "RAID_WARNING"
                    LibBG:UIDropDownMenu_SetText(dropDown, RaidText(BiaoGe.options[name]))
                end
                if BiaoGe.options[name] == "RAID_WARNING" then
                    info.checked = true
                end
                LibBG:UIDropDownMenu_AddButton(info)
                local info = LibBG:UIDropDownMenu_CreateInfo()
                info.text = L["通报至团队频道"]
                info.func = function()
                    BiaoGe.options[name] = "RAID"
                    LibBG:UIDropDownMenu_SetText(dropDown, RaidText(BiaoGe.options[name]))
                end
                if BiaoGe.options[name] == "RAID" then
                    info.checked = true
                end
                LibBG:UIDropDownMenu_AddButton(info)
            end)

            if BiaoGe.options["countDown"] ~= 1 then
                dropDown:Hide()
            end
        end
        h = h + 50

        O.CreateLine(biaoge, height - h)
        h = h + 15
        -- 快速记账
        do
            local name = "fastCount"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["快速记账"],
                L["这是一种不用打开表格界面就可以完成记账的方式。"],
                " ",
                L["该功能只有普通团员可用（非团长和物品分配者）。"],
                " ",
                L["使用方法：右键聊天框装备时打开。"],
            }
            local f = O.CreateCheckButton(name, BG.STC_g1(L["快速记账"] .. "*"), biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local name1 = "fastCountMsg"
                local name2 = "fastCountPreview"
                if f:GetChecked() then
                    BG.options["button" .. name1]:Show()
                    BG.options["button" .. name2]:Show()
                else
                    BG.options["button" .. name1]:Hide()
                    BG.options["button" .. name2]:Hide()
                end
            end)
        end
        h = h + 30
        -- 记账通知
        do
            local name = "fastCountMsg"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["记账通知"],
                L["快速记账完成后会在屏幕中央通知本次记账结果。"],
            }
            local f = O.CreateCheckButton(name, L["记账通知"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            local name = "fastCount"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 记账效果预览框
        do
            local name = "fastCountPreview"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["记账效果预览框"],
                L["快速记账的时候，可以预览这次的记账效果。"],
            }
            local f = O.CreateCheckButton(name, L["记账效果预览框*"], biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            local name = "fastCount"
            if BiaoGe.options[name] ~= 1 then
                f:Hide()
            end
        end
        h = h + 40

        O.CreateLine(biaoge, height - h)
        h = h + 15
        -- 装备过期提醒
        do
            local name = "guoqiRemind"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["装备过期提醒"],
                L["当装备剩余可交易时间低于一定时（默认是低于30分钟），会有语音+文字提醒。每次提醒的最低间隔是5分钟，避免提醒过于频繁。"],
                " ",
                L["该功能只有你是团长或物品分配者时起作用。"],
            }
            local f = O.CreateCheckButton(name, BG.STC_g1(L["装备过期提醒"] .. "*"), biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local name1 = "guoqiRemindMinTime"
                if f:GetChecked() then
                    BG.options["button" .. name1]:Show()
                else
                    BG.options["button" .. name1]:Hide()
                end
            end)
        end
        -- 剩余多少分钟时提醒
        do
            local name = "guoqiRemindMinTime"
            BG.options[name .. "reset"] = 30
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["剩余时间低于多少时提醒"] .. L["|cff808080（右键还原设置）|r"],
                L["当装备剩余可交易时间低于该时间时，会提醒，默认是30分钟。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateSlider(name, "|cffFFFFFF" .. L["剩余时间低于多少时提醒(分)"] .. "*" .. "|r", biaoge, 1, 120, 1, 220, height - h - 25, ontext)
            BG.options["button" .. name] = f
            if BiaoGe.options["guoqiRemind"] ~= 1 then
                f:Hide()
            end
        end
        h = h + 80

        O.CreateLine(biaoge, height - h)
        h = h + 15
        -- 进本自动清空表格
        do
            local name = "autoQingKong"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["进本自动清空表格"],
                L["当你进入一个新CD团本时，表格会自动清空，原表格数据会保存至历史表格1。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateCheckButton(name, L["进本自动清空表格*"], biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local name = "autoQingKongSaveHistory"
                if f:GetChecked() then
                    BG.options["button" .. name]:Show()
                else
                    BG.options["button" .. name]:Hide()
                end
            end)

            -- 删除旧设置
            if BiaoGe.options["showQingKong"] then
                BiaoGe.options["showQingKong"] = nil
            end
        end
        h = h + 30
        -- 清空表格不保存历史表格
        do
            local name = "autoQingKongSaveHistory"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["自动清空表格时保存表格"],
                L["进本自动清空表格时，把表格保存至历史表格1。"],
                " ",
                L["取消勾选则不会保存表格。"],
            }
            local f = O.CreateCheckButton(name, AddTexture("QUEST") .. L["自动清空表格时保存表格"] .. "*", biaoge, 40, height - h, ontext)
            BG.options["button" .. name] = f
            if BiaoGe.options["autoQingKong"] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 清空表格时保留支出补贴名称
        do
            local name = "retainExpenses"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["清空表格时保留支出补贴名称"],
                L["只保留补贴名称（例如XX补贴）。支出金额正常清空。"],
                " ",
                L["这样就不用每次都重复填写补贴名称。"],
                " ",
                L["只有补贴名称，但没有补贴金额的，在通报账单时不会被通报。"],
            }
            local f = O.CreateCheckButton(name, L["清空表格时保留支出补贴名称"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local name = "retainExpensesMoney"
                if f:GetChecked() then
                    BG.options["button" .. name]:Show()
                else
                    BG.options["button" .. name]:Hide()
                end
            end)
        end
        h = h + 30
        -- 清空表格时保留支出金额
        do
            local name = "retainExpensesMoney"
            BG.options[name .. "reset"] = 0
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["清空表格时保留支出金额"],
                L["如果你们团每次支出的金额都是固定的，可以勾选此项。"],
            }
            local f = O.CreateCheckButton(name, L["清空表格时保留支出金额"] .. "*", biaoge, 40, height - h, ontext)
            BG.options["button" .. name] = f
            if BiaoGe.options["retainExpenses"] ~= 1 then
                f:Hide()
            end
        end
        -- 清空表格时根据副本难度设置分钱人数
        if not BG.IsVanilla then
            h = h + 30
            -- 清空表格时根据副本难度设置分钱人数
            do
                local name = "QingKongPeople"
                BG.options[name .. "reset"] = 1
                if not BiaoGe.options[name] then
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
                local ontext = {
                    L["清空表格时根据副本难度设置分钱人数"],
                    L["10人团本默认分钱人数为10人，25人团本默认分钱人数为25人。"],
                    -- " ",
                    -- L[""],
                }
                local f = O.CreateCheckButton(name, L["清空表格时根据副本难度设置分钱人数*"], biaoge, 15, height - h, ontext)
                BG.options["button" .. name] = f
                f:HookScript("OnClick", function()
                    local name = "MaxPlayers"
                    if f:GetChecked() then
                        BG.options["button" .. name]:Show()
                    else
                        BG.options["button" .. name]:Hide()
                    end
                end)
            end
            h = h + 30
            -- 分钱人数
            do
                local name = "MaxPlayers"
                local f = CreateFrame("Frame", nil, BG.options.buttonQingKongPeople)
                BG.options["button" .. name] = f
                local name = "QingKongPeople"
                if BiaoGe.options[name] ~= 1 then
                    f:Hide()
                end

                local text = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", BG.options.buttonQingKongPeople, "BOTTOMRIGHT", 0, -5)
                text:SetText(L["|cffFFFFFF10人团本分钱人数：|r"])

                local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
                edit:SetSize(50, 20)
                edit:SetPoint("LEFT", text, "RIGHT", 5, 0)
                edit:SetJustifyH("CENTER")
                edit:SetText(BiaoGe.options["10MaxPlayers"] or "10")
                edit:SetAutoFocus(false)
                edit:SetScript("OnTextChanged", function(self)
                    BiaoGe.options["10MaxPlayers"] = tonumber(self:GetText()) or 10
                end)
                edit:SetScript("OnEnterPressed", function(self)
                    self:ClearFocus()
                end)

                local text = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("LEFT", edit, "RIGHT", 40, 0)
                text:SetText(L["|cffFFFFFF25人团本分钱人数：|r"])

                local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
                edit:SetSize(50, 20)
                edit:SetPoint("LEFT", text, "RIGHT", 5, 0)
                edit:SetJustifyH("CENTER")
                edit:SetText(BiaoGe.options["25MaxPlayers"] or "25")
                edit:SetAutoFocus(false)
                edit:SetScript("OnTextChanged", function(self)
                    BiaoGe.options["25MaxPlayers"] = tonumber(self:GetText()) or 25
                end)
                edit:SetScript("OnEnterPressed", function(self)
                    self:ClearFocus()
                end)
            end
        end
        h = h + 45

        O.CreateLine(biaoge, height - h)
        h = h + 15
        -- 按键交互声音
        do
            local name = "buttonSound"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["按键交互声音"],
                L["点击按钮时的声音。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateCheckButton(name, L["按键交互声音*"], biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
        end
        -- 语音提醒
        do
            local name = "Sound"

            local function GetName()
                for i, v in ipairs(BG.soundTbl) do
                    if v.ID == BiaoGe.options.Sound then
                        return v.name
                    end
                end
            end

            BiaoGe.options.Sound = BiaoGe.options.Sound or BG.soundTbl[random(#BG.soundTbl)].ID
            if not GetName() then
                BiaoGe.options.Sound = BG.soundTbl[random(#BG.soundTbl)].ID
            end

            local dropDown = LibBG:Create_UIDropDownMenu(nil, biaoge)
            dropDown:SetPoint("TOPLEFT", 220, height - h - 20)
            LibBG:UIDropDownMenu_SetWidth(dropDown, 180)
            LibBG:UIDropDownMenu_SetText(dropDown, GetName())
            LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "TOP", dropDown, "BOTTOM")
            BG.dropDownToggle(dropDown)
            BG.options["button" .. name] = dropDown

            local f = CreateFrame("Frame", nil, dropDown, "BackdropTemplate")
            f:SetPoint("BOTTOM", dropDown, "TOP", 0, 8)
            local t = f:CreateFontString()
            t:SetPoint("CENTER")
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetTextColor(1, 1, 1)
            t:SetText(L["语音提醒"] .. "*")
            f:SetSize(t:GetWidth(), t:GetHeight())
            f:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["语音提醒"], 1, 1, 1, true)
                GameTooltip:AddLine(L["选择一个语音包。语音提醒的内容有几个，例如：已清空表格、拍卖啦、心愿达成、炼金转化已就绪。"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            f:SetScript("OnLeave", GameTooltip_Hide)

            LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
                for _, v in ipairs(BG.soundTbl) do
                    local info = LibBG:UIDropDownMenu_CreateInfo()
                    info.text = v.name
                    info.func = function()
                        BiaoGe.options[name] = v.ID
                        LibBG:UIDropDownMenu_SetText(dropDown, v.name)
                    end
                    if v.ID == BiaoGe.options[name] then
                        info.checked = true
                    end
                    LibBG:UIDropDownMenu_AddButton(info)
                end
            end)

            hooksecurefunc(LibBG, "ToggleDropDownMenu", function(_, _, _, dropDown)
                if dropDown == BG.options["button" .. name] then
                    for i = 1, _G['L_DropDownList1'].numButtons do
                        local button = _G["L_DropDownList1Button" .. i]
                        if not button.playSound then
                            local bt = CreateFrame("Button", nil, button)
                            bt:SetSize(20, 20)
                            bt:SetPoint("RIGHT", -2, 0)
                            bt:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ArmoryChat")
                            bt:GetNormalTexture():SetVertexColor(0, 1, 0)
                            bt.num = i
                            bt:Hide()
                            button.playSound = bt
                            bt:SetScript("OnClick", function(self)
                                PlaySoundFile(BG["sound_" .. BG.soundTbl2[random(#BG.soundTbl2)].ID .. BG.soundTbl[self.num].ID], "Master")
                            end)
                            bt:SetScript("OnEnter", function(self)
                                LibBG:UIDropDownMenu_StopCounting(self:GetParent():GetParent())
                                button.Highlight:Show()
                                bt:GetNormalTexture():SetVertexColor(1, 1, 1)
                            end)
                            bt:SetScript("OnLeave", function(self)
                                LibBG:UIDropDownMenu_StartCounting(self:GetParent():GetParent())
                                button.Highlight:Hide()
                                GameTooltip:Hide()
                                bt:GetNormalTexture():SetVertexColor(0, 1, 0)
                            end)
                        end
                        button.playSound.num = i
                        button.playSound:Show()
                    end
                else
                    for i = 1, L_UIDROPDOWNMENU_MAXBUTTONS do
                        local button = _G["L_DropDownList1Button" .. i]
                        if button.playSound then
                            button.playSound:Hide()
                        end
                    end
                end
            end)
        end
        h = h + 70

        O.CreateLine(biaoge, height - h)
        h = h + 15
        -- 金额自动加零
        do
            local name = "autoAdd0"
            BG.options[name .. "reset"] = 0
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["金额自动加零"],
                L["输入金额和欠款时自动加两个0，减少记账操作，提高记账效率。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateCheckButton(name, L["金额自动加零*"], biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
        end

        -- 对账单保存时长(小时)
        do
            local name = "duiZhangTime"
            local ontext = {
                L["对账单保存时长"] .. L["|cff808080（右键还原设置）|r"],
                L["对账单保存多久后自动删除。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateSlider(name, "|cffFFFFFF" .. L["对账单保存时长(小时)"] .. "|r", biaoge, 1, 168, 1, 220, height - h - 25, ontext)
            BG.options["button" .. name] = f
        end
        h = h + 30

        -- 自动获取在线人数
        if BG.IsVanilla_Sod or BG.IsCTM then
            do
                local name = "autoGetOnline"
                BG.options[name .. "reset"] = 0
                BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
                BG.Once("autoGetOnline", 240615, function()
                    BiaoGe.options[name] = 0
                end)

                local ontext = {
                    L["自动获取在线人数"],
                    L["打开表格界面时，自动获取当前阵营在线人数。如果你打开表格时出现掉线的情况，请关闭该功能。"],
                    -- " ",
                    -- L[""],
                }
                local f = O.CreateCheckButton(name, L["自动获取在线人数"] .. "*", biaoge, 15, height - h, ontext)
                BG.options["button" .. name] = f
            end
            h = h + 30
        end

        -- 支出百分比自动计算
        do
            local name = "zhichuPercent"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]

            local ontext = {
                L["支出百分比计算"],
                L["如果支出项目有百分比符号，则按照百分比自动计算该支出金额。"],
                " ",
                L[ [[比如支出项目为：TN10%，则该支出金额会自动更新为：总收入*10%]] ],
            }
            local f = O.CreateCheckButton(name, L["支出百分比计算"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                for _, FB in pairs(BG.FBtable) do
                    local b = Maxb[FB] + 1
                    for i = 1, BG.GetMaxi(FB, b) do
                        local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                        local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                        if zhuangbei then
                            BG.UpdateZhiChuPercent(zhuangbei, jine)
                        end
                    end
                end
            end)
        end
        h = h + 30

        -- 数字小键盘
        do
            local name = "NumFrame"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]

            local ontext = {
                L["数字小键盘"],
                L["在可以输入数字的地方，自动显示一个数字小键盘。用鼠标就能完成数字的输入。"],
            }
            local f = O.CreateCheckButton(name, L["数字小键盘"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
        end
        h = h + 30

        -- 显示模型
        do
            local name = "model"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            if BiaoGe.options["model"] ~= 1 then
                for i, model in ipairs(BG.bossModels) do
                    model:Hide()
                end
            end

            local ontext = {
                L["显示BOSS模型"],
                L["在表格里显示BOSS的模型。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateCheckButton(name, L["显示BOSS模型"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                if f:GetChecked() then
                    for i, model in ipairs(BG.bossModels) do
                        model:Show()
                    end
                else
                    for i, model in ipairs(BG.bossModels) do
                        model:Hide()
                    end
                end
            end)
        end
        h = h + 30

        -- 自动删除屏蔽团员
        do
            local name = "ignore"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]

            local ontext = {
                L["自动移除屏蔽对象"],
                L["使用自动拍卖时，如果某个团员在你的屏蔽列表里，则自动把它移出该列表。"],
                " ",
                L["这是为了防止你看不到对方的拍卖聊天信息和自动拍卖出价消息。"],
            }
            local f = O.CreateCheckButton(name, AddTexture("QUEST") .. L["自动移除屏蔽对象"] .. "*", biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
        end
        h = h + 30


        -- 小地图图标
        do
            local name = "miniMap"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["小地图图标"],
                L["显示小地图图标。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateCheckButton(name, L["小地图图标*"], biaoge, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local icon = LibStub("LibDBIcon-1.0", true)
                if icon then
                    if f:GetChecked() then
                        icon:Show(AddonName)
                    else
                        icon:Hide(AddonName)
                    end
                end
            end)
        end
    end

    -- 自动拍卖
    do
        local height = 0
        local h = 30
        -- UI缩放
        do
            local name = "autoAuctionScale"
            BG.options[name .. "reset"] = 0.9
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            if not tonumber(BiaoGe.options[name]) then
                BiaoGe.options[name] = BG.options[name .. "reset"]
            end
            local ontext = {
                L["UI缩放"] .. L["|cff808080（右键还原设置）|r"],
                L["调整自动拍卖UI的大小。"],
                -- " ",
                -- L[""],
            }
            local f = O.CreateSlider(name, "|cffFFFFFF" .. L["UI缩放*"] .. "|r", autoAuction, 0.5, 1.5, 0.01, 15, height - h, ontext)
            BG.options["button" .. name] = f

            f:SetScript("OnValueChanged", function(self, value)
                f.edit:ClearFocus()
                value = tonumber(string.format("%.2f", value))
                BiaoGe.options[name] = value
                f.edit:SetText(value)
                BGA.AuctionMainFrame:SetScale(value)
            end)
            f.button:SetScript("OnClick", function(self, enter)
                if enter == "RightButton" then
                    if BG.options[name .. "reset"] then
                        local value = BG.options[name .. "reset"]
                        BiaoGe.options[name] = value
                        f:SetValue(value)
                        f.edit:SetText(value)
                        BGA.AuctionMainFrame:SetScale(value)
                        BG.PlaySound(1)
                    end
                end
            end)
        end
        h = h + 60

        O.CreateLine(autoAuction, height - h)
        h = h + 15

        -- 一键开拍
        do
            local buttons = {}

            local name = "fastMoney"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["一键开拍"],
                L["在团长拍卖面板里，增加多个价格按钮，点击后直接按该价格开始拍卖。"],
            }
            local f = O.CreateCheckButton(name, L["一键开拍"] .. "*", autoAuction, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function(self)
                if self:GetChecked() then
                    buttons[1]:Show()
                else
                    buttons[1]:Hide()
                end
            end)

            local function CreateEdit(i)
                local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
                edit:SetSize(80, 20)
                if i == 1 then
                    edit:SetPoint("TOPLEFT", f, "BOTTOMRIGHT", 5, 0)
                    if BiaoGe.options[name] ~= 1 then edit:Hide() end
                else
                    edit:SetParent(buttons[1])
                    edit:SetPoint("LEFT", buttons[i - 1], "RIGHT", 10, 0)
                end
                edit:SetAutoFocus(false)
                edit:SetNumeric(true)
                edit.i = i
                tinsert(buttons, edit)
                edit:SetScript("OnTextChanged", function(self)
                    BiaoGe.Auction.fastMoney[i] = tonumber(self:GetText()) or ""
                end)
                edit:SetScript("OnShow", function(self)
                    self:SetText(BiaoGe.Auction.fastMoney[i] or "")
                end)
                edit:HookScript("OnMouseDown", function(self, enter)
                    if enter == "RightButton" then
                        self:SetEnabled(false)
                        self:SetText("")
                    end
                end)
                edit:HookScript("OnMouseUp", function(self, enter)
                    self:SetEnabled(true)
                end)
                edit:HookScript("OnEnterPressed", function(self)
                    self:ClearFocus()
                end)
                edit:HookScript("OnTabPressed", function(self)
                    if buttons[i + 1] then
                        buttons[i + 1]:SetFocus()
                    end
                end)
            end
            for i = 1, #BiaoGe.Auction.fastMoney do
                CreateEdit(i)
            end
        end
        h = h + 30
        h = h + 30
        -- 使用组合键打开拍卖面板
        do
            local name = "autoAuctionStart"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["使用组合键打开拍卖面板"],
                L["团长或物品分配者ALT+点击背包/表格/聊天框装备，来打开拍卖面板。"],
            }
            local f = O.CreateCheckButton(name, L["使用组合键打开团长拍卖面板"] .. "*", autoAuction, 15, height - h, ontext)
            BG.options["button" .. name] = f
        end
        h = h + 30
        -- 交易时自动摆放装备
        do
            local name = "autoAuctionPut"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["交易时自动摆放装备"],
                L["交易时，如果你是物品分配者，会自动把对方所拍装备摆放到交易框。"],
            }
            local f = O.CreateCheckButton(name, L["交易时自动摆放装备"] .. "*", autoAuction, 15, height - h, ontext)
            BG.options["button" .. name] = f
        end
        h = h + 30
        -- 交易时显示应收/应付金额
        do
            local name = "autoAuctionMoney"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["交易时显示应收或应付金额"],
                L["交易时，根据对方或你所拍装备显示应收或应付金额。"],
            }
            local f = O.CreateCheckButton(name, L["交易时显示应收或应付金额"] .. "*", autoAuction, 15, height - h, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                local name1 = "autoAuctionQianKuan"
                local name2 = "autoAuctionSetMoney"
                local name3 = "autoAuctionSureClick"
                if f:GetChecked() then
                    BG.options["button" .. name1]:Show()
                    BG.options["button" .. name2]:Show()
                    BG.options["button" .. name3]:Show()
                else
                    BG.options["button" .. name1]:Hide()
                    BG.options["button" .. name2]:Hide()
                    BG.options["button" .. name3]:Hide()
                end
            end)
        end
        h = h + 30
        -- 交易时自动记录欠款
        do
            local name = "autoAuctionQianKuan"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["交易时自动记录欠款"],
                L["交易时，会自动记录欠款。"],
            }
            local f = O.CreateCheckButton(name, L["交易时自动记录欠款"] .. "*", autoAuction, 40, height - h, ontext)
            BG.options["button" .. name] = f
            if BiaoGe.options["autoAuctionMoney"] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 交易时自动填写交易金额
        do
            local name = "autoAuctionSetMoney"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["交易时自动填写交易金额"],
                L["交易时，自定填写应付的交易金额。"],
            }
            local f = O.CreateCheckButton(name, AddTexture("QUEST") .. L["交易时自动填写交易金额"] .. "*", autoAuction, 40, height - h, ontext)
            BG.options["button" .. name] = f
            if BiaoGe.options["autoAuctionMoney"] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 交易时自动确认交易
        do
            local name = "autoAuctionSureClick"
            BG.options[name .. "reset"] = 0
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["交易时自动确认交易"],
                L["当交易金额等于应收/应付金额时，自动点击交易按钮。但屏幕中间的二次确认框还是需要你手动确认。"],
            }
            local f = O.CreateCheckButton(name, AddTexture("QUEST") .. L["交易时自动确认交易"] .. "*", autoAuction, 40, height - h, ontext)
            BG.options["button" .. name] = f
            if BiaoGe.options["autoAuctionMoney"] ~= 1 then
                f:Hide()
            end
        end
        h = h + 30
        -- 拍卖成功的聊天消息后增加出价记录
        do
            local name = "autoAuctionLogLink"
            BG.options[name .. "reset"] = 1
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["拍卖成功的聊天消息后面增加[出价记录]"],
                L["鼠标悬停在[出价记录]时会显示该装备的出价记录。"],
            }
            local f = O.CreateCheckButton(name, AddTexture("QUEST") .. L["拍卖成功的聊天消息后面增加[出价记录]"] .. "*", autoAuction, 15, height - h, ontext)
            BG.options["button" .. name] = f
        end
        h = h + 30
        -- 拍卖竞价窗口自动往上吸附
        do
            local name = "autoAuctionUp"
            BG.options[name .. "reset"] = 0
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["拍卖竞价窗口自动往上吸附"],
                L["当靠前的窗口消失时，后面的窗口会自动往上吸附。"],
            }
            local f = O.CreateCheckButton(name, AddTexture("QUEST") .. L["拍卖竞价窗口自动往上吸附"] .. "*", autoAuction, 15, height - h, ontext)
            BG.options["button" .. name] = f
        end
    end

    -- 角色总览设置
    do
        local function CreateFBCDbutton(n1, n2, width, height, width2, height_jiange)
            local right
            local first
            for i = n1, n2 do
                local name = BG.FBCDall_table[i].name
                local name2 = BG.FBCDall_table[i].name2
                local color = BG.FBCDall_table[i].color
                local fbId = BG.FBCDall_table[i].fbId
                local type = BG.FBCDall_table[i].type
                local maxplayers = BG.FBCDall_table[i].num and (BG.FBCDall_table[i].num .. L["人"]) or ""

                local bt = CreateFrame("CheckButton", nil, roleOverview, "ChatConfigCheckButtonTemplate")
                bt:SetSize(25, 25)
                bt:SetHitRectInsets(0, -width2 + 45, 0, 0)
                if not right then
                    bt:SetPoint("TOPLEFT", roleOverview, "TOPLEFT", width, height)
                    first = bt
                elseif roleOverview.scroll:GetRight() - right.Text:GetRight() > width2 then
                    bt:SetPoint("TOPLEFT", right, "TOPLEFT", width2, 0)
                else
                    bt:SetPoint("TOPLEFT", first, "BOTTOMLEFT", 0, 0)
                    first = bt
                    height = height - height_jiange
                end
                right = bt
                bt.Text:SetText("|cff" .. color .. (name2 or name):gsub("sod", "") .. RR)

                bt.Text:SetWidth(width2 - 25)
                bt.Text:SetWordWrap(false)

                if not BiaoGe.FBCDchoice[name] or BiaoGe.FBCDchoice[name] == 0 then
                    BiaoGe.FBCDchoice[name] = nil
                    bt:SetChecked(false)
                else
                    BiaoGe.FBCDchoice[name] = 1
                    bt:SetChecked(true)
                end

                bt:SetScript("OnClick", function(self)
                    if self:GetChecked() then
                        BiaoGe.FBCDchoice[name] = 1
                    else
                        BiaoGe.FBCDchoice[name] = nil
                    end

                    BG.PlaySound(1)
                end)
                -- 鼠标悬停提示
                bt:SetScript("OnEnter", function(self)
                    local text = "|cff" .. color .. maxplayers .. GetRealZoneText(fbId) .. RR
                    if type ~= "fb" then
                        text = self.Text:GetText()
                    end
                    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:SetText(text)
                end)
                bt:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                end)
            end
            return height
        end
        local function CreateMONEYbutton(n1, n2, width, height, width2, height_jiange)
            local right
            local first
            for i = n1, n2 do
                local name = BG.MONEYall_table[i].name
                local tex = BG.MONEYall_table[i].tex
                local color = BG.MONEYall_table[i].color
                local id = BG.MONEYall_table[i].id

                local bt = CreateFrame("CheckButton", nil, roleOverview, "ChatConfigCheckButtonTemplate")
                bt:SetSize(25, 25)
                bt:SetHitRectInsets(0, -width2 + 40, 0, 0)
                if not right then
                    bt:SetPoint("TOPLEFT", roleOverview, "TOPLEFT", width, height)
                    first = bt
                elseif roleOverview.scroll:GetRight() - right.Text:GetRight() > width2 then
                    bt:SetPoint("TOPLEFT", right, "TOPLEFT", width2, 0)
                else
                    bt:SetPoint("TOPLEFT", first, "BOTTOMLEFT", 0, 0)
                    first = bt
                    height = height - height_jiange
                end
                right = bt
                bt.Text:SetText(AddTexture(tex))

                if not BiaoGe.MONEYchoice[id] or BiaoGe.MONEYchoice[id] == 0 then
                    BiaoGe.MONEYchoice[id] = nil
                    bt:SetChecked(false)
                else
                    BiaoGe.MONEYchoice[id] = 1
                    bt:SetChecked(true)
                end

                bt:SetScript("OnClick", function(self)
                    if self:GetChecked() then
                        BiaoGe.MONEYchoice[id] = 1
                    else
                        BiaoGe.MONEYchoice[id] = nil
                    end
                    -- BG.MoneyBannerUpdate()

                    BG.PlaySound(1)
                end)
                -- 鼠标悬停提示
                bt:SetScript("OnEnter", function(self)
                    local text = "|cff" .. color .. name .. RR
                    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:SetText(text)
                end)
                bt:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                end)
            end
            return height
        end

        -- 删除角色
        do
            local bt = CreateFrame("Button", nil, roleOverview)
            bt:SetHeight(22)
            bt:SetPoint("TOPRIGHT", BG.optionsBackground:GetWidth() - 45, -5)
            bt:SetNormalFontObject(BG.FontRed15)
            bt:SetDisabledFontObject(BG.FontDis15)
            bt:SetHighlightFontObject(BG.FontWhite15)
            bt:SetText(L["删除角色"])
            BG.SetButtonWidthForString(bt)
            bt:SetScript("OnMouseUp", function(self)
                local bt = BG.ButtonOptions_config
                bt:GetScript("OnClick")(bt)
            end)
        end

        -- 创建多选按钮
        local width = 15
        local height = -10
        local height_jiange = 22
        local line_height = 4
        do
            if BG.IsVanilla_Sod then
                --团本CD
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_b1(L["团本*"]))
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(1, #BG.FBCDall_table - 4, width, height, 100, height_jiange)

                -- 任务
                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText("|cffFF8C00" .. (QUESTS_LABEL .. "*") .. RR)
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(#BG.FBCDall_table - 3, #BG.FBCDall_table - 3, width, height, 100, height_jiange)

                -- 专业
                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText("|cffADFF2F" .. (TRADE_SKILLS .. "*") .. RR)
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(#BG.FBCDall_table - 2, #BG.FBCDall_table, width, height, 100, height_jiange)

                -- 货币
                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_y1(L["货币*"]))
                height = height - height_jiange
                local l = O.CreateLine(roleOverview, height + line_height)

                height = CreateMONEYbutton(1, #BG.MONEYall_table, width, height, 65, height_jiange)
                height = height - height_jiange * 3
            elseif BG.IsVanilla_60 then
                --团本CD
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_b1(L["团本*"]))
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(1, #BG.FBCDall_table - 3, width, height, 100, height_jiange)

                -- 专业
                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText("|cffADFF2F" .. (TRADE_SKILLS .. "*") .. RR)
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(#BG.FBCDall_table - 2, #BG.FBCDall_table, width, height, 100, height_jiange)

                -- 货币
                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_y1(L["货币*"]))
                height = height - height_jiange
                local l = O.CreateLine(roleOverview, height + line_height)

                height = CreateMONEYbutton(1, #BG.MONEYall_table, width, height, 65, height_jiange)
                height = height - height_jiange * 3
            elseif BG.IsWLK then
                --团本CD
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_b1(EXPANSION_NAME2 .. "*"))
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(1, 18, width, height, 100, height_jiange)

                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_r3(EXPANSION_NAME1 .. "*"))
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(19, 29, width, height, 100, height_jiange)

                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_g2(LFG_LIST_LEGACY .. "*"))
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(30, 34, width, height, 100, height_jiange)

                -- 任务
                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText("|cffFF8C00" .. (QUESTS_LABEL .. "*") .. RR)
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(35, 40, width, height, 100, height_jiange)

                -- 专业
                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText("|cffADFF2F" .. (TRADE_SKILLS .. "*") .. RR)
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(41, #BG.FBCDall_table, width, height, 100, height_jiange)

                -- 货币
                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_y1(L["货币*"]))
                height = height - height_jiange
                local l = O.CreateLine(roleOverview, height + line_height)

                height = CreateMONEYbutton(1, #BG.MONEYall_table, width, height, 65, height_jiange)
                height = height - height_jiange * 3
            elseif BG.IsCTM then
                --团本CD
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText("|cffFF4500" .. EXPANSION_NAME3 .. "*")
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(1, #BG.FBCDall_table - 34, width, height, 100, height_jiange)

                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_b1(EXPANSION_NAME2 .. "*"))
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(#BG.FBCDall_table - 33, #BG.FBCDall_table - 14, width, height, 100, height_jiange)

                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_r3(EXPANSION_NAME1 .. "*"))
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(#BG.FBCDall_table - 15, #BG.FBCDall_table - 5, width, height, 100, height_jiange)

                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_g2(LFG_LIST_LEGACY .. "*"))
                height = height - height_jiange
                O.CreateLine(roleOverview, height + line_height)
                height = CreateFBCDbutton(#BG.FBCDall_table - 4, #BG.FBCDall_table, width, height, 100, height_jiange)

                -- 货币
                height = height - height_jiange - height_jiange
                local text = roleOverview:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                text:SetPoint("TOPLEFT", width, height)
                text:SetText(BG.STC_y1(L["货币*"]))
                height = height - height_jiange
                local l = O.CreateLine(roleOverview, height + line_height)

                height = CreateMONEYbutton(1, #BG.MONEYall_table, width, height, 65, height_jiange)
                height = height - height_jiange * 3
            end
        end
        height = height + 10
        local _height = height
        -- 排序
        BG.Init2(function()
            local height = _height
            local name = "roleOverviewSort1"
            BG.options[name .. "reset"] = "iLevel-class-player"
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            if BiaoGe.options[name] == "iLevel-player-class" then
                BiaoGe.options[name] = "iLevel-player"
            elseif BiaoGe.options[name] == "class-player-iLevel" then
                BiaoGe.options[name] = "class-player"
            elseif BiaoGe.options[name] == "player-iLevel-class" then
                BiaoGe.options[name] = "player"
            elseif BiaoGe.options[name] == "player-class-iLevel" then
                BiaoGe.options[name] = "player"
            end
            local tbl = {
                { key = "iLevel-class-player", text = L["装等-职业-名字"] },
                { key = "class-iLevel-player", text = L["职业-装等-名字"] },
                { key = "iLevel-player", text = L["装等-名字"] },
                { key = "class-player", text = L["职业-名字"] },
                { key = "player", text = L["名字"] },
                { key = "vip", text = L["自定义排序"] .. AddTexture("VIP") },
            }

            local t = roleOverview:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOPLEFT", 15, height)
            t:SetTextColor(1, 1, 1)
            t:SetText(L["角色总览的排序方式："])
            BG.options["Text" .. name] = t

            -- 选项
            do
                local function SetText(key)
                    for i, v in ipairs(tbl) do
                        if v.key == key then
                            return v.text
                        end
                    end
                end

                local dropDown = LibBG:Create_UIDropDownMenu(nil, roleOverview)
                dropDown:SetPoint("LEFT", BG.options["Text" .. name], "RIGHT", -10, -2)
                LibBG:UIDropDownMenu_SetWidth(dropDown, 150)
                LibBG:UIDropDownMenu_SetText(dropDown, SetText(BiaoGe.options[name]))
                LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "TOP", dropDown, "BOTTOM")
                BG.dropDownToggle(dropDown)
                BG.options["button" .. name] = dropDown

                LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
                    for i, v in ipairs(tbl) do
                        local info = LibBG:UIDropDownMenu_CreateInfo()
                        info.text = v.text
                        info.func = function()
                            BiaoGe.options[name] = v.key
                            LibBG:UIDropDownMenu_SetText(dropDown, SetText(BiaoGe.options[name]))
                            if BiaoGe.options[name] ~= "vip" then
                                if BGV and BGV.RoleOverviewSortFrame and BGV.RoleOverviewSortFrame:IsVisible() then
                                    BGV.RoleOverviewSortFrame:Hide()
                                end
                            end
                            dropDown.bt:SetShown(BiaoGe.options[name] == "vip" and BG.BiaoGeVIPVerNum and BG.BiaoGeVIPVerNum >= 10140)
                        end
                        if BiaoGe.options[name] == v.key then
                            info.checked = true
                        end
                        if v.key == "vip" and not (BG.BiaoGeVIPVerNum and BG.BiaoGeVIPVerNum >= 10140) then
                            info.disabled = true
                        end
                        LibBG:UIDropDownMenu_AddButton(info)
                    end
                end)

                dropDown.bt = BG.CreateButton(dropDown)
                dropDown.bt:SetSize(100, 25)
                dropDown.bt:SetPoint("LEFT", dropDown, "RIGHT", 0, 3)
                dropDown.bt:SetText(L["修改排序"])
                dropDown.bt:SetShown(BiaoGe.options[name] == "vip" and BG.BiaoGeVIPVerNum and BG.BiaoGeVIPVerNum >= 10140)
                dropDown.bt:SetScript("OnClick", function(self)
                    BG.PlaySound(1)
                    if BGV.RoleOverviewSortFrame and BGV.RoleOverviewSortFrame:IsVisible() then
                        BGV.RoleOverviewSortFrame:Hide()
                    else
                        BGV.CreateRoleOverviewMainFrame(self)
                    end
                end)
            end
        end)
        height = height - 35

        -- 默认显示
        do
            local name = "roleOverviewDefaultShow"
            BG.options[name .. "reset"] = "one"
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]

            local tbl = {
                { key = "one", text = L["当前服务器角色"] },
                { key = "all", text = L["全部服务器角色"] },
            }

            local t = roleOverview:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOPLEFT", 15, height)
            t:SetTextColor(1, 1, 1)
            t:SetText(L["角色总览的默认显示："])
            BG.options["Text" .. name] = t
            -- 选项
            do
                local function SetText(key)
                    for i, v in ipairs(tbl) do
                        if v.key == key then
                            return v.text
                        end
                    end
                end

                local dropDown = LibBG:Create_UIDropDownMenu(nil, roleOverview)
                dropDown:SetPoint("LEFT", BG.options["Text" .. name], "RIGHT", -10, -2)
                LibBG:UIDropDownMenu_SetWidth(dropDown, 150)
                LibBG:UIDropDownMenu_SetText(dropDown, SetText(BiaoGe.options[name]))
                LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "TOP", dropDown, "BOTTOM")
                BG.dropDownToggle(dropDown)
                BG.options["button" .. name] = dropDown

                LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
                    for i, v in ipairs(tbl) do
                        local info = LibBG:UIDropDownMenu_CreateInfo()
                        info.text = v.text
                        info.func = function()
                            BiaoGe.options[name] = v.key
                            LibBG:UIDropDownMenu_SetText(dropDown, SetText(BiaoGe.options[name]))
                        end
                        if BiaoGe.options[name] == v.key then
                            info.checked = true
                        end
                        LibBG:UIDropDownMenu_AddButton(info)
                    end
                end)
            end
        end
        height = height - 35

        -- 布局
        do
            local name = "roleOverviewLayout"
            BG.options[name .. "reset"] = "up_down"
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]

            local tbl = {
                { key = "up_down", text = L["上下布局"] },
                { key = "left_right", text = L["左右布局"] },
            }

            local t = roleOverview:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOPLEFT", 15, height)
            t:SetTextColor(1, 1, 1)
            t:SetText(L["角色总览的布局方式："])
            BG.options["Text" .. name] = t
            -- 选项
            do
                local function SetText(key)
                    for i, v in ipairs(tbl) do
                        if v.key == key then
                            return v.text
                        end
                    end
                end

                local dropDown = LibBG:Create_UIDropDownMenu(nil, roleOverview)
                dropDown:SetPoint("LEFT", BG.options["Text" .. name], "RIGHT", -10, -2)
                LibBG:UIDropDownMenu_SetWidth(dropDown, 150)
                LibBG:UIDropDownMenu_SetText(dropDown, SetText(BiaoGe.options[name]))
                LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "TOP", dropDown, "BOTTOM")
                BG.dropDownToggle(dropDown)
                BG.options["button" .. name] = dropDown

                LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
                    for i, v in ipairs(tbl) do
                        local info = LibBG:UIDropDownMenu_CreateInfo()
                        info.text = v.text
                        info.func = function()
                            BiaoGe.options[name] = v.key
                            LibBG:UIDropDownMenu_SetText(dropDown, SetText(BiaoGe.options[name]))
                        end
                        if BiaoGe.options[name] == v.key then
                            info.checked = true
                        end
                        LibBG:UIDropDownMenu_AddButton(info)
                    end
                end)
            end
        end
        height = height - 35

        -- 屏蔽等级
        do
            local name = "roleOverviewNotShowLevel"
            BG.options[name .. "reset"] = 0
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]

            local t = roleOverview:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOPLEFT", 15, height)
            t:SetTextColor(1, 1, 1)
            t:SetText(L["不显示低于该等级的角色："])

            local edit = CreateFrame("EditBox", nil, roleOverview, "InputBoxTemplate")
            edit:SetSize(50, 20)
            edit:SetPoint("LEFT", t, "RIGHT", 10, 0)
            edit:SetText(BiaoGe.options[name] or 0)
            edit:SetAutoFocus(false)
            edit:SetScript("OnTextChanged", function(self)
                BiaoGe.options[name] = tonumber(self:GetText()) or 0
            end)
            edit:SetScript("OnEnterPressed", function(self)
                self:ClearFocus()
            end)
        end
        height = height - 30

        -- 屏蔽装等
        do
            local name = "roleOverviewNotShowiLevel"
            BG.options[name .. "reset"] = 0
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]

            local t = roleOverview:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOPLEFT", 15, height)
            t:SetTextColor(1, 1, 1)
            t:SetText(AddTexture("QUEST") .. L["不显示低于该装等的角色："])

            local edit = CreateFrame("EditBox", nil, roleOverview, "InputBoxTemplate")
            edit:SetSize(50, 20)
            edit:SetPoint("LEFT", t, "RIGHT", 10, 0)
            edit:SetText(BiaoGe.options[name] or 0)
            edit:SetAutoFocus(false)
            edit:SetScript("OnTextChanged", function(self)
                BiaoGe.options[name] = tonumber(self:GetText()) or 0
            end)
            edit:SetScript("OnEnterPressed", function(self)
                self:ClearFocus()
            end)
        end

        -- 5人本完成总览
        if not BG.IsVanilla then
            height = height - 30

            local name = "FB5M"
            BG.options[name .. "reset"] = 0
            BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
            local ontext = {
                L["角色5人本完成总览"],
                L["在队伍查找器旁边显示角色5人本完成总览。"],
            }
            local f = O.CreateCheckButton(name, BG.STC_g1(L["显示角色5人本完成总览"] .. "*"), roleOverview, 15, height, ontext)
            BG.options["button" .. name] = f
            f:HookScript("OnClick", function()
                if BG.FBCD_5M_Frame then
                    if f:GetChecked() then
                        BG.FBCD_5M_Frame:Show()
                    else
                        BG.FBCD_5M_Frame:Hide()
                    end
                end
            end)
        end
    end

    -- 团本攻略设置
    do
        if BG.IsWLK then
            local height = 0

            -- 团本攻略字体大小
            do
                local name = "BossFontSize"
                if not BiaoGe.options[name] then
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
                local ontext = {
                    L["团本攻略字号"] .. L["|cff808080（右键还原设置）|r"],
                    L["调整该字体的大小。"],
                    -- " ",
                    -- L[""],
                }
                local f = O.CreateSlider(name, "|cffFFFFFF" .. L["团本攻略字号"] .. "|r", boss, 10, 20, 1, 15, height - 30, ontext)
                BG.options["button" .. name] = f
            end
        end
    end

    -- 其他功能设置
    do
        local width = 15
        local height = -10
        local height_jiange = 22
        local line_height = 4
        local h = 0

        -- 原生功能
        do
            local text = others:CreateFontString(nil, "ARTWORK", "GameFontNormal")
            text:SetPoint("TOPLEFT", width, height)
            text:SetText(BG.STC_g1(L["原生功能"]))
            height = height - height_jiange

            O.CreateLine(others, height + line_height)

            -- 退队/入队玩家上色
            do
                local name = "joinorleavePlayercolor"
                BG.options[name .. "reset"] = 1
                if not BiaoGe.options[name] then
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
                local ontext = {
                    L["退队/入队玩家上色"],
                    L["在退队/入队的系统消息里，给该玩家名字加上职业色并设置为链接。"],
                }
                local f = O.CreateCheckButton(name, L["退队/入队玩家上色"] .. "*", others, 15, height - h, ontext)
                BG.options["button" .. name] = f
            end
            -- 一键指定灵魂烘炉
            if not BG.IsVanilla then
                h = h + 30
                do
                    local fbID = 632

                    local name = "zhidingFB"
                    BG.options[name .. "reset"] = 1
                    if not BiaoGe.options[name] then
                        BiaoGe.options[name] = BG.options[name .. "reset"]
                    end
                    local text1
                    if BG.IsWLK then
                        text1 = L["节日副本和"] .. GetRealZoneText(fbID)
                    else
                        text1 = L["节日副本"]
                    end
                    local ontext = {
                        format(L["一键指定%s"], text1),
                        format(L["在地下城和团队副本界面增加一键指定%s按钮。"], text1),
                        " ",
                        L["打开随机本界面时，会自动选择上一次的随机本类型，而不是傻傻地在默认类型。"],
                    }
                    local f = O.CreateCheckButton(name, format(L["一键指定%s"], text1) .. "*", others, 15, height - h, ontext)
                    BG.options["button" .. name] = f
                end
            end
            -- 一键自动分配
            h = h + 30
            do
                local name = "allLootToMe"
                BG.options[name .. "reset"] = 1
                if not BiaoGe.options[name] then
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
                local ontext = {
                    L["队长模式一键分配"],
                    L["队长分配模式时，在战利品界面增加一键分配按钮。"],
                    " ",
                    L["点击按钮后会把全部可交易的物品分配给自己（橙片、任务物品等不会自动分配）。"],
                }

                local f = O.CreateCheckButton(name, L["队长模式一键分配"] .. "*", others, 15, height - h, ontext)
                BG.options["button" .. name] = f
                f:HookScript("OnClick", function(self)
                    if self:GetChecked() then
                        BG.options["buttonautoAllLootToMe"]:Show()
                    else
                        BG.options["buttonautoAllLootToMe"]:Hide()
                    end
                end)


                h = h + 30
                local name = "autoAllLootToMe"
                BG.options[name .. "reset"] = 0
                BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
                local ontext
                ontext = {
                    L["自动点击一键分配"],
                    L["当你打开战利品界面时，自动点击一键分配按钮（等于自动把符合条件的装备全部分配给你，省去你每次点击按钮的动作）。"],
                    " ",
                    L["按下ALT/SHIFT/CTRL时不会自动一键分配。"],
                }
                local f = O.CreateCheckButton(name, L["自动点击一键分配"] .. "*", others, 40, height - h, ontext)
                BG.options["button" .. name] = f
                if BiaoGe.options["allLootToMe"] ~= 1 then
                    f:Hide()
                end
            end
            -- 一键举报脚本
            do
                h = h + 30

                local name = "report"
                BG.options[name .. "reset"] = 1
                if not BiaoGe.options[name] then
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
                if false then
                    local ontext = {
                        L["一键举报"],
                        L["在目标玩家/聊天频道玩家的右键菜单里增加一键举报脚本按钮。快捷命令：/BGReport。"],
                        " ",
                        L["在目标玩家/聊天频道玩家的右键菜单里增加一键举报RMT按钮。"],
                        " ",
                        L["在战场时，在目标玩家的右键菜单里增加一键举报挂机按钮。"],
                        " ",
                        L["在查询名单列表界面中增加全部举报按钮。"],
                    }
                    local f = O.CreateCheckButton(name, L["一键举报"] .. "*", others, 15, height - h, ontext)
                    BG.options["button" .. name] = f
                else
                    local ontext = {
                        L["举报成功后自动隐藏感谢界面"],
                        L["正常情况下，当你举报成功后，会显示一个感谢你的举报的界面。现在该感谢界面不会再显示。"],
                    }
                    local f = O.CreateCheckButton(name, L["举报成功后自动隐藏感谢界面"] .. "*", others, 15, height - h, ontext)
                    BG.options["button" .. name] = f
                end
            end
            -- 查询名单搜索记录
            do
                h = h + 30

                local name = "searchList"
                BG.options[name .. "reset"] = 1
                if not BiaoGe.options[name] then
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
                local ontext = {
                    L["查询记录"],
                    L["在查询名单列表中增加查询记录。"],
                    " ",
                    L["在查询名单列表中增加导出名单功能（可用于在官网进行批量举报）。"],
                }
                local f = O.CreateCheckButton(name, L["查询记录"] .. "*", others, 15, height - h, ontext)
                BG.options["button" .. name] = f
            end
            -- 贸易局
            if BG.IsVanilla_Sod then
                h = h + 30

                local name = "commerceAuthorityTooltip"
                BG.options[name .. "reset"] = 1
                if not BiaoGe.options[name] then
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
                local ontext = {
                    L["贸易局的遭劫货物显示具体声望奖励"],
                    L["在贸易局声望的遭劫货物提示工具中增加具体的声望奖励。如果你安装了Auctionator插件，还会显示所需货物的拍卖行价格。"],
                    " ",
                    L["在专业制造面板和专业学习面板中，高亮与[遭劫货物]有关物品。"],
                    " ",
                    L["在拍卖行Shift点击[遭劫货物]时，只会搜索其所需货物，而不是搜索[遭劫货物]（支持原生界面和Auctionator插件）。"],
                }

                local f = O.CreateCheckButton(name, L["贸易局的遭劫货物显示具体声望奖励"] .. "*", others, 15, height - h, ontext)
                BG.options["button" .. name] = f
            end
            -- 血月活动期间自动释放尸体和自动对话复活
            if BG.IsVanilla_Sod then
                h = h + 30

                local name = "xueyueAuto"
                BG.options[name .. "reset"] = 0
                if not BiaoGe.options[name] then
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
                local ontext = {
                    L["荆棘谷血月活动期间自动释放尸体和对话自动复活"],
                }
                local f = O.CreateCheckButton(name, L["荆棘谷血月活动期间自动释放尸体和对话自动复活"] .. "*", others, 15, height - h, ontext)
                BG.options["button" .. name] = f
                f:SetScript("OnShow", function(self)
                    if BiaoGe.options[name] == 1 then
                        self:SetChecked(true)
                    else
                        self:SetChecked(false)
                    end
                end)
            end

            h = h + 45
        end

        -- AtlasLoot
        if BG.IsWLK then
            local text = others:CreateFontString(nil, "ARTWORK", "GameFontNormal")
            text:SetPoint("TOPLEFT", width, height - h)
            text:SetText(BG.STC_g1("AtlasLoot"))
            height = height - height_jiange

            O.CreateLine(others, height - h + line_height)

            -- 更好的选择
            do
                local name = "AtlasLoot_betterChoose"
                BG.options[name .. "reset"] = 1
                BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
                local ontext = {
                    L["更好的选择"],
                    L["当你点击一个菜单选项时，"],
                    L["该插件的原本设定：下一级菜单中总是默认显示第一项。"],
                    -- " ",
                    L["现在优化为：下一级菜单中会显示更合适的项目。"],
                    " ",
                    L["比如："],
                    L["点击地下城和团队副本时，会自动显示25人奥杜尔；"],
                    L["点击专业制造时，会自动显示附魔；"],
                    L["点击专业制造-铭文时，会自动显示你对应的铭文；"],
                }
                local f = O.CreateCheckButton(name, L["更好的选择"] .. "*", others, 15, height - h, ontext)
                BG.options["button" .. name] = f
            end
            h = h + 30

            -- 一键显示
            do
                local name = "AtlasLoot_fastChoose"
                BG.options[name .. "reset"] = 0
                BiaoGe.options[name] = BiaoGe.options[name] or BG.options[name .. "reset"]
                local ontext = {
                    L["一键显示"],
                    L["在AtlasLoot主界面的右边，增加多个快捷按钮，点击后直接显示相应页面。"],
                    " ",
                    L["比如珠宝按钮，点击后直接显示珠宝页面。"],
                }
                local f = O.CreateCheckButton(name, L["一键显示"] .. "*", others, 15, height - h, ontext)
                BG.options["button" .. name] = f
            end

            h = h + 45
        end

        -- 集结号
        BG.Init2(function()
            local text = others:CreateFontString(nil, "ARTWORK", "GameFontNormal")
            text:SetPoint("TOPLEFT", width, height - h)
            text:SetText(BG.STC_g1(L["集结号"]))
            height = height - height_jiange

            O.CreateLine(others, height - h + line_height)

            local function Update_OnShow(f, name)
                f:SetScript("OnShow", function(self)
                    if BiaoGe.options[name] == 1 then
                        f:SetChecked(true)
                    else
                        f:SetChecked(false)
                    end
                end)
            end

            local tbl = {}

            -- 显示综合频道/鼠标提示工具/目标右键菜单显示星团长
            if BG.IsWLK then
                tinsert(tbl, {
                    name = "MeetingHorn_starRaidLeader",
                    name2 = L["聊天频道显示星团长标记"] .. "*",
                    reset = 1,
                    ontext = {
                        L["聊天频道显示星团长标记"],
                        L["在聊天频道（综合、组队等）/鼠标提示工具/目标右键菜单中，显示星团长标记。"],
                        " ",
                        L["需要集结号v2.0.0或以上版本才能生效。"],
                    },
                })
            end
            -- 自动加入集结号频道
            tinsert(tbl, {
                name = "MeetingHorn_always",
                name2 = L["自动加入集结号频道"] .. "*",
                reset = 0,
                ontext = {
                    L["自动加入集结号频道"],
                    L["进入游戏后，自动加入集结号频道，让你提前获取组队消息。"],
                    " ",
                    L["而且，关闭集结号界面时不会自动退出该频道，这样可以一直同步组队消息，让你随时打开集结号都能查看全部活动。"],
                },
            })
            -- 历史搜索记录
            tinsert(tbl, {
                name = "MeetingHorn_history",
                name2 = L["历史搜索记录"] .. "*",
                reset = 0,
                ontext = {
                    L["历史搜索记录"],
                    L["给集结号的搜索框增加一个历史搜索记录，提高你搜索的效率。"],
                },
            })
            -- 多个关键词搜索
            tinsert(tbl, {
                -- notdefault = true,
                name = "MeetingHorn_search",
                name2 = L["多个关键词搜索"] .. "*",
                reset = 0,
                ontext = {
                    L["多个关键词搜索"],
                    L[ [[搜索框支持多个关键词搜索。]] ],
                    " ",
                    L[ [["空格"表示"且"，需同时满足全部关键词。比如你想搜索哪个诺莫瑞根活动里缺少治疗，可以搜索"诺莫瑞根 治疗"。]] ],
                    " ",
                    L[ [["/"表示"或"，满足其中一个关键词即可。比如你是双修牧师，可以搜索"牧师/MS/暗牧/AM"。]] ],
                    " ",
                    L[ [[如果把"空格"和"/"结合起来，比如搜索"诺莫瑞根/矮子 牧师/MS/暗牧/AM"，表示我想找诺莫瑞根或者矮子的活动，且该活动缺少任意牧师。]] ],
                },
                onClick = function(self)
                    local addonName = "MeetingHorn"
                    if not IsAddOnLoaded(addonName) then return end
                    local MeetingHorn = LibStub("AceAddon-3.0"):GetAddon(addonName)
                    local Activity = MeetingHorn:GetClass('Activity')
                    if self:GetChecked() then
                        Activity.Match = BG.MeetingHorn.ActivityMatch_newFuc
                    else
                        Activity.Match = BG.MeetingHorn.ActivityMatch_oldFuc
                    end
                end
            })
            -- 按队伍人数排序
            tinsert(tbl, {
                -- notdefault = true,
                name = "MeetingHorn_members",
                name2 = L["按队伍人数排序"] .. "*",
                reset = 0,
                ontext = {
                    L["按队伍人数排序"],
                    L["集结号活动可以按队伍人数排序。"],
                },
                onClick = function(self)
                    local addonName = "MeetingHorn"
                    if not IsAddOnLoaded(addonName) then return end
                    local MeetingHorn = LibStub("AceAddon-3.0"):GetAddon(addonName)
                    local Browser = MeetingHorn:GetClass('UI.Browser', 'Frame')
                    local bt = MeetingHorn.MainPanel.Browser.Header3
                    if self:GetChecked() then
                        bt:SetEnabled(true)
                        Browser.Sort = BG.MeetingHorn.BrowserSort_newFuc
                    else
                        bt:SetEnabled(false)
                        Browser.Sort = BG.MeetingHorn.BrowserSort_oldFuc
                    end
                end
            })
            -- 标记已密语过的活动
            tinsert(tbl, {
                name = "MeetingHorn_isSend",
                name2 = L["标记已密语过的活动"] .. "*",
                reset = 0,
                ontext = {
                    L["标记已密语过的活动"],
                    L["如果你在最近15分钟内曾经密语过团长，那么该活动的说明变为灰色。"],
                },
            })
            -- 密语模板
            tinsert(tbl, {
                name = "MeetingHorn_whisper",
                name2 = L["密语模板"] .. L["(重载后生效)"],
                reset = 0,
                ontext = {
                    L["密语模板"],
                    L["预设成就、装等、自定义文本，当你点击集结号活动密语时会自动添加该内容。"],
                    " ",
                    L["按住SHIFT+点击密语时不会添加。"],
                    " ",
                    L["在聊天频道玩家的右键菜单里增加[密语模板]按钮。"],
                    " ",
                    L["在聊天输入框的右键菜单里增加[密语模板]按钮。"],
                    " ",
                    L["在集结号活动的右键菜单里增加[邀请][复制活动说明]按钮。"],
                },
                -- onClick = function(self)
                --     local addonName = "MeetingHorn"
                --     if not IsAddOnLoaded(addonName) then return end
                --     if self:GetChecked() then
                --         BG.MeetingHorn.WhisperButton:Show()
                --         BG.MeetingHorn.WhisperFrame:Show()
                --         BiaoGe.MeetingHornWhisper.WhisperFrame = true
                --     else
                --         BG.MeetingHorn.WhisperButton:Hide()
                --     end
                -- end
            })
            if BG.IsWLK then
                -- tinsert(tbl[#tbl].ontext, " ")
                -- tinsert(tbl[#tbl].ontext, L["在团长的右键菜单里增加[进入DD语音房间]按钮。"])
            end
            if BG.IsVanilla then
                tbl[#tbl].ontext[2] = L["预设装等、自定义文本，当你点击集结号活动密语时会自动添加该内容。"]
            end

            for i, v in ipairs(tbl) do
                if not v.notdefault then
                    BG.options[v.name .. "reset"] = v.reset
                    BiaoGe.options[v.name] = BiaoGe.options[v.name] or BG.options[v.name .. "reset"]
                end
                BG.options["button" .. v.name] = O.CreateCheckButton(v.name, v.name2, others, 15, height - h, v.ontext)
                Update_OnShow(BG.options["button" .. v.name], v.name)
                if v.onClick then
                    BG.options["button" .. v.name]:HookScript("OnClick", v.onClick)
                end
                h = h + 30
            end

            -- 在集结号增加设置按钮
            local addonName = "MeetingHorn"
            if not IsAddOnLoaded(addonName) then return end
            local MeetingHorn = LibStub("AceAddon-3.0"):GetAddon(addonName)
            local others = MeetingHorn.MainPanel.Options.Options

            local height = -150
            local width = 25
            local h = 0
            local h_jiange = 28

            local text = others:CreateFontString(nil, "ARTWORK", "GameFontNormal")
            text:SetPoint("TOPLEFT", width, height - h)
            text:SetText(BG.STC_g1(L["集结号增强|cff808080（该功能由BiaoGe插件提供）|r"]))
            height = height - height_jiange

            local l = others:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("TOPLEFT", 15, height - h + line_height)
            l:SetEndPoint("TOPLEFT", 380, height - h + line_height)
            l:SetThickness(1.5)

            -- 集结号设置
            do
                local buttons = {}
                for i, v in ipairs(tbl) do
                    if v.notdefault then
                        v.ontext[1] = v.ontext[1] .. L["（重载界面后生效）"]
                    end
                    local f = O.CreateCheckButton(v.name, v.name2, others, 15, height - h, v.ontext)
                    Update_OnShow(f, v.name)
                    if v.onClick then
                        f:HookScript("OnClick", v.onClick)
                    end
                    if i == 6 then
                        f:ClearAllPoints()
                        f:SetPoint("LEFT", buttons[1], "RIGHT", 190, 0)
                        f.Text:SetWidth(140)
                    elseif i > 6 then
                        f:ClearAllPoints()
                        f:SetPoint("TOPLEFT", buttons[i - 1], "TOPLEFT", 0, -h_jiange)
                        f.Text:SetWidth(140)
                    else
                        f.Text:SetWidth(180)
                    end
                    f.Text:SetWordWrap(false)
                    tinsert(buttons, f)
                    h = h + h_jiange
                end
            end
        end)
    end

    -- 角色配置
    do
        BiaoGe.options.configChooseHope = BiaoGe.options.configChooseHope or 1
        BiaoGe.options.configChooseFilter = BiaoGe.options.configChooseFilter or 1
        BiaoGe.options.configChooseMeetingHornHistory = BiaoGe.options.configChooseMeetingHornHistory or 1
        BiaoGe.options.configChooseMeetingHornWhisper = BiaoGe.options.configChooseMeetingHornWhisper or 1

        local width = 15
        local height = -15
        local width2 = 200
        local width3 = 160
        local height2 = 350

        local text = config:CreateFontString()
        text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        text:SetPoint("TOPLEFT", width, height)
        text:SetText(L["BiaoGe的配置文件中，大部分都是账号互通的，比如当前表格、历史表格、YY评价、设置。但也有一些是按角色来保存的，比如心愿清单、装备过滤方案、集结号的搜索记录和密语模板。\n\n当一个角色改名或者转服时，该角色的心愿清单等数据就会丢失。所以该功能就是为了帮你找回原来的角色数据。"])
        text:SetTextColor(1, 1, 1)
        text:SetJustifyH("LEFT")
        text:SetWidth(SettingsPanel.Container:GetWidth() - 70)

        height = height - text:GetHeight()

        local text = config:CreateFontString()
        text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        text:SetPoint("TOPLEFT", width, height - 15)
        text:SetText(L["选择一个目标角色"])
        text:SetTextColor(0, 1, 0)
        text:SetWidth(width2)

        local text = config:CreateFontString()
        text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        text:SetPoint("TOPLEFT", width + width2 + 15, height - 15)
        text:SetText(L["要复制的内容"])
        text:SetTextColor(0, 1, 0)
        text:SetWidth(width2)

        local text = config:CreateFontString()
        text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        text:SetPoint("TOPLEFT", width + width2 + 15 + width2 + 15, height - 15)
        text:SetText(L["操作"])
        text:SetTextColor(0, 1, 0)
        text:SetWidth(width3)

        height = height - 15

        local f, child = BG.CreateScrollFrame(config, width2, height2)
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.3)
        f:SetPoint("TOPLEFT", width, height - 15)

        local choose = { realmID = nil, player = nil }
        local buttons = {}
        local button2s = {}

        local function UpdateCopyButton()
            BG.options.configCopyButton:Disable()
            BG.options.configDeleteButton:Disable()
            if choose.realmID and choose.player then
                local yes
                for i, bt in ipairs(button2s) do
                    if bt:GetChecked() then
                        yes = true
                        break
                    end
                end
                if yes then
                    BG.options.configCopyButton:Enable()
                end
                BG.options.configDeleteButton:Enable()
            end
        end

        local function UpdateAllButtons()
            for i, bt in ipairs(buttons) do
                bt:Hide()
            end
            wipe(buttons)

            for realmID, v in pairs(BiaoGe.Hope) do
                if next(v) then
                    local bt = CreateFrame("Button", nil, child)
                    if not buttons[1] then
                        bt:SetPoint("TOPLEFT", child, 0, 0)
                    else
                        bt:SetPoint("TOPLEFT", buttons[#buttons], "BOTTOMLEFT", 0, 0)
                    end
                    bt:SetNormalFontObject(BG.FontWhite15)
                    if BiaoGe.realmName[realmID] then
                        bt:SetText(BiaoGe.realmName[realmID])
                    else
                        bt:SetText(realmID)
                    end
                    bt:SetSize(child:GetWidth(), 20)
                    BG.SetTextHighlightTexture(bt)
                    tinsert(buttons, bt)
                    local t = bt:GetFontString()
                    t:SetPoint("LEFT")
                    t:SetTextColor(1, 0.82, 0)
                    bt:Disable()

                    for player, v in pairs(BiaoGe.Hope[realmID]) do
                        local bt = CreateFrame("Button", nil, child)
                        if not buttons[1] then
                            bt:SetPoint("TOPLEFT", child, 0, 0)
                        else
                            bt:SetPoint("TOPLEFT", buttons[#buttons], "BOTTOMLEFT", 0, 0)
                        end
                        bt:SetNormalFontObject(BG.FontWhite15)
                        bt:SetText("   " .. player)
                        bt:SetSize(child:GetWidth(), 20)
                        bt.realmID = realmID
                        bt.player = player
                        tinsert(buttons, bt)

                        local tex = bt:CreateTexture()
                        tex:SetAllPoints()
                        tex:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
                        bt:SetHighlightTexture(tex)

                        bt.chooseTex = bt:CreateTexture()
                        bt.chooseTex:SetAllPoints()
                        bt.chooseTex:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
                        bt.chooseTex:SetVertexColor(0, 1, 0)
                        bt.chooseTex:Hide()

                        local t = bt:GetFontString()
                        t:SetPoint("LEFT")
                        if BiaoGe.playerInfo[realmID] and BiaoGe.playerInfo[realmID][player] and BiaoGe.playerInfo[realmID][player].class then
                            local r, g, b = GetClassColor(BiaoGe.playerInfo[realmID][player].class)
                            t:SetTextColor(r, g, b)
                            tex:SetVertexColor(r, g, b)
                            bt:SetText("   " .. player .. " (" .. BiaoGe.playerInfo[realmID][player].level .. ")")
                        else
                            t:SetTextColor(.5, .5, .5)
                            tex:SetVertexColor(.5, .5, .5)
                        end

                        bt:SetScript("OnClick", function(self)
                            BG.PlaySound(1)
                            if self.isChoose then
                                choose.realmID = nil
                                choose.player = nil
                                self.isChoose = false
                                self.chooseTex:Hide()
                            else
                                for i, bt in ipairs(buttons) do
                                    bt.isChoose = false
                                    if bt.chooseTex then
                                        bt.chooseTex:Hide()
                                    end
                                end
                                choose.realmID = self.realmID
                                choose.player = self.player
                                self.isChoose = true
                                self.chooseTex:Show()
                            end
                            UpdateCopyButton()
                        end)
                    end
                end
            end
        end
        UpdateAllButtons()


        local f = CreateFrame("Frame", nil, config, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.3)
        f:SetSize(width2, height2)
        f:EnableMouse(true)
        f:SetPoint("TOPLEFT", width + width2 + 15, height - 15)

        local function CreateButton(text, configName)
            local bt = CreateFrame("CheckButton", nil, f, "ChatConfigCheckButtonTemplate")
            bt:SetSize(30, 30)
            if not button2s[1] then
                bt:SetPoint("TOPLEFT", 10, -10)
            else
                bt:SetPoint("TOPLEFT", button2s[#button2s], "BOTTOMLEFT", 0, 0)
            end
            bt.Text:SetText(text)
            bt.Text:SetWidth(width2 - 30 - 20)
            bt:SetHitRectInsets(0, -bt.Text:GetWidth(), 0, 0)
            bt.text = text
            tinsert(button2s, bt)
            if BiaoGe.options[configName] == 1 then
                bt:SetChecked(true)
            end
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                if self:GetChecked() then
                    BiaoGe.options[configName] = 1
                else
                    BiaoGe.options[configName] = 0
                end
                UpdateCopyButton()
            end)
        end
        CreateButton(L["心愿清单"], "configChooseHope")
        CreateButton(L["装备过滤方案"], "configChooseFilter")
        CreateButton(L["集结号历史搜索记录"], "configChooseMeetingHornHistory")
        CreateButton(L["集结号密语模板"], "configChooseMeetingHornWhisper")

        local f = CreateFrame("Frame", nil, config, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.3)
        f:SetSize(width3, height2)
        f:EnableMouse(true)
        f:SetPoint("TOPLEFT", width + width2 + 15 + width2 + 15, height - 15)

        -- 确定复制
        local bt = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        local bt = BG.CreateButton(f)
        do
            bt:SetSize(100, 25)
            bt:SetPoint("TOP", 0, -15)
            bt:SetText(L["确定复制"])
            bt:Disable()
            BG.options.configCopyButton = bt
            bt:SetScript("OnEnter", function(self)
                local chooseText = ""
                for i, bt in ipairs(button2s) do
                    if bt:GetChecked() then
                        if chooseText ~= "" then
                            chooseText = chooseText .. "|cffFFD100/|r" .. bt.text
                        else
                            chooseText = bt.text
                        end
                    end
                end
                local c2 = "ffFFFFFF"
                if BiaoGe.playerInfo[choose.realmID] and BiaoGe.playerInfo[choose.realmID][choose.player]
                    and BiaoGe.playerInfo[choose.realmID][choose.player].class then
                    c2 = select(4, GetClassColor(BiaoGe.playerInfo[choose.realmID][choose.player].class))
                end
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["提醒"], 1, 1, 1, true)
                GameTooltip:AddLine(format(L["你当前角色%s的%s将会被%s的|cffff0000替换|r。"],
                        SetClassCFF(BG.GN(), "player"),
                        "|cff00FF00" .. chooseText .. RR,
                        "|c" .. c2 .. (BiaoGe.realmName[choose.realmID] or choose.realmID) .. "-" .. choose.player .. RR),
                    1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)
            bt:SetScript("OnClick", function(self)
                local chooseText = ""
                for i, bt in ipairs(button2s) do
                    if bt:GetChecked() then
                        if chooseText ~= "" then
                            chooseText = chooseText .. "|cffffffff/|r" .. bt.text
                        else
                            chooseText = bt.text
                        end
                    end
                end
                local c2 = "ffFFFFFF"
                if BiaoGe.playerInfo[choose.realmID] and BiaoGe.playerInfo[choose.realmID][choose.player]
                    and BiaoGe.playerInfo[choose.realmID][choose.player].class then
                    c2 = select(4, GetClassColor(BiaoGe.playerInfo[choose.realmID][choose.player].class))
                end
                StaticPopup_Show("BIAOGE_QUEDINGFUZHI",
                    format(L["你当前角色%s的%s将会被%s的|cffff0000替换|r。"],
                        SetClassCFF(BG.GN(), "player"),
                        "|cff00FF00" .. chooseText .. RR,
                        "|c" .. c2 .. (BiaoGe.realmName[choose.realmID] or choose.realmID) .. "-" .. choose.player .. RR))
            end)

            StaticPopupDialogs["BIAOGE_QUEDINGFUZHI"] = {
                text = L["确定复制？\n%s"],
                button1 = L["是"],
                button2 = L["否"],
                OnAccept = function()
                    BG.PlaySound(2)
                    local realmID = GetRealmID()
                    local player = BG.playerName
                    if BiaoGe.options.configChooseHope == 1 then
                        if BiaoGe.Hope[choose.realmID][choose.player] then
                            BiaoGe.Hope[realmID][player] = BiaoGe.Hope[choose.realmID][choose.player]
                        end
                    end
                    if BiaoGe.options.configChooseFilter == 1 then
                        if BiaoGe.FilterClassItemDB[choose.realmID][choose.player] then
                            BiaoGe.FilterClassItemDB[realmID][player] = BiaoGe.FilterClassItemDB[choose.realmID][choose.player]
                            BiaoGe.filterClassNum[realmID][player] = 0
                        end
                    end
                    if BiaoGe.options.configChooseMeetingHornHistory == 1 then
                        if BiaoGe.MeetingHorn[choose.realmID] and BiaoGe.MeetingHorn[choose.realmID][choose.player] then
                            BiaoGe.MeetingHorn[realmID][player] = BiaoGe.MeetingHorn[choose.realmID][choose.player]
                        end
                    end
                    if BiaoGe.options.configChooseMeetingHornWhisper == 1 then
                        if BiaoGe.MeetingHornWhisper[choose.realmID] and BiaoGe.MeetingHornWhisper[choose.realmID][choose.player] then
                            BiaoGe.MeetingHornWhisper[realmID][player] = BiaoGe.MeetingHornWhisper[choose.realmID][choose.player]
                        end
                    end
                    ReloadUI()
                end,
                OnCancel = function()
                end,
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                showAlert = true,
            }
        end

        -- 删除角色
        local bt = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        local bt = BG.CreateButton(f)
        bt:SetSize(100, 25)
        bt:SetPoint("TOP", BG.options.configCopyButton, "BOTTOM", 0, -15)
        bt:SetText(L["删除角色"])
        bt:Disable()
        BG.options.configDeleteButton = bt
        bt:SetScript("OnEnter", function(self)
            local c2 = "ffFFFFFF"
            if BiaoGe.playerInfo[choose.realmID] and BiaoGe.playerInfo[choose.realmID][choose.player]
                and BiaoGe.playerInfo[choose.realmID][choose.player].class then
                c2 = select(4, GetClassColor(BiaoGe.playerInfo[choose.realmID][choose.player].class))
            end
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(format(L["删除%s的全部配置文件。"],
                    "|c" .. c2 .. choose.player .. RR),
                1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", GameTooltip_Hide)
        bt:SetScript("OnClick", function(self)
            local c2 = "ffFFFFFF"
            if BiaoGe.playerInfo[choose.realmID] and BiaoGe.playerInfo[choose.realmID][choose.player]
                and BiaoGe.playerInfo[choose.realmID][choose.player].class then
                c2 = select(4, GetClassColor(BiaoGe.playerInfo[choose.realmID][choose.player].class))
            end
            StaticPopup_Show("BIAOGE_SHANCHUJUESE", "|c" .. c2 .. choose.player .. RR)
        end)

        StaticPopupDialogs["BIAOGE_SHANCHUJUESE"] = {
            text = L["确定删除%s的全部配置文件？"],
            button1 = L["是"],
            button2 = L["否"],
            OnAccept = function()
                local realmID = GetRealmID()
                local player = BG.playerName
                BG.DeletePlayerData(choose.realmID, choose.player)
                if realmID == choose.realmID and player == choose.player then
                    ReloadUI()
                else
                    UpdateAllButtons()
                end
            end,
            OnCancel = function()
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            showAlert = true,
        }
    end

    -- 清理旧数据
    do
        if not BiaoGe.options.SearchHistory.dt231005 then
            BiaoGe.Scale = nil
            BiaoGe.Alpha = nil
            BiaoGe.AutoLoot = nil
            BiaoGe.AutoTrade = nil
            BiaoGe.AutoJine0 = nil
            BiaoGe.helperZF = nil
            BiaoGe.tradeFrame = nil
            BiaoGe.helperTongBao = nil
            BiaoGe.text = nil
            BiaoGe.HopeSendICC = nil
            BiaoGe.HopeSendTOC = nil
            BiaoGe.HopeSendULD = nil
            BiaoGe.HopeSendNAXX = nil
            BiaoGe.HopeShow = nil
            BiaoGe.mini = nil

            for FB, _ in pairs(BiaoGe.History) do
                for dt, v in pairs(BiaoGe.History[FB]) do
                    for b = 1, 25 do
                        if BiaoGe.History[FB][dt]["boss" .. b] then
                            for i = 1, 35 do
                                if BiaoGe.History[FB][dt]["boss" .. b]["zhuangbei" .. i] then
                                    if BiaoGe.History[FB][dt]["boss" .. b]["zhuangbei" .. i] == "" then
                                        BiaoGe.History[FB][dt]["boss" .. b]["zhuangbei" .. i] = nil
                                    end
                                    if BiaoGe.History[FB][dt]["boss" .. b]["maijia" .. i] == "" then
                                        BiaoGe.History[FB][dt]["boss" .. b]["maijia" .. i] = nil
                                        BiaoGe.History[FB][dt]["boss" .. b]["color" .. i] = nil
                                    end
                                    if BiaoGe.History[FB][dt]["boss" .. b]["jine" .. i] == "" then
                                        BiaoGe.History[FB][dt]["boss" .. b]["jine" .. i] = nil
                                    end
                                end

                                if BiaoGe[FB]["boss" .. b]["zhuangbei" .. i] or BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
                                    if BiaoGe[FB]["boss" .. b]["zhuangbei" .. i] == "" then
                                        BiaoGe[FB]["boss" .. b]["zhuangbei" .. i] = nil
                                    end
                                    if BiaoGe[FB]["boss" .. b]["maijia" .. i] == "" then
                                        BiaoGe[FB]["boss" .. b]["maijia" .. i] = nil
                                        BiaoGe[FB]["boss" .. b]["color" .. i] = nil
                                    end
                                    if BiaoGe[FB]["boss" .. b]["jine" .. i] == "" then
                                        BiaoGe[FB]["boss" .. b]["jine" .. i] = nil
                                    end
                                    if BiaoGe[FB]["boss" .. b]["qiankuan" .. i] == "" then
                                        BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = nil
                                    end
                                end
                            end
                            if BiaoGe.History[FB][dt]["boss" .. b]["time"] then
                                if BiaoGe.History[FB][dt]["boss" .. b]["time"] == "" then
                                    BiaoGe.History[FB][dt]["boss" .. b]["time"] = nil
                                end
                            end
                        end
                    end
                end
            end
            BiaoGe.options.SearchHistory.dt231005 = true
        end

        -- 修正击杀用时文本
        if not BiaoGe.options.SearchHistory["yongshi240425"] then
            for _, FB in pairs(BG.FBtable) do
                for b = 1, 25 do
                    if BiaoGe[FB]["boss" .. b] then
                        local t = BiaoGe[FB]["boss" .. b].time
                        if t then
                            if t == "" then
                                BiaoGe[FB]["boss" .. b].time = nil
                            else
                                local m, s = t:match("(%d+)分(%d+)秒")
                                if m and s then
                                    BiaoGe[FB]["boss" .. b].time = m .. ":" .. s
                                else
                                    m, s = t:match("(%d+):(%d+)")
                                    if m and s then
                                        BiaoGe[FB]["boss" .. b].time = m .. ":" .. s
                                    end
                                end
                            end
                        end
                    end
                end
            end
            for FB, _ in pairs(BiaoGe.History) do
                for dt, v in pairs(BiaoGe.History[FB]) do
                    for b = 1, 25 do
                        if BiaoGe.History[FB][dt]["boss" .. b] then
                            local t = BiaoGe.History[FB][dt]["boss" .. b].time
                            if t then
                                if t == "" then
                                    BiaoGe.History[FB][dt]["boss" .. b].time = nil
                                else
                                    local m, s = t:match("(%d+)分(%d+)秒")
                                    if m and s then
                                        BiaoGe.History[FB][dt]["boss" .. b].time = m .. ":" .. s
                                    else
                                        m, s = t:match("(%d+):(%d+)")
                                        if m and s then
                                            BiaoGe.History[FB][dt]["boss" .. b].time = m .. ":" .. s
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            BiaoGe.options.SearchHistory["yongshi240425"] = true
        end
    end
    -- print(GetTimePreciseSec())
end)

BG.RegisterEvent("PLAYER_LOGIN", function(self, event, addonName)
    local name = "miniMap"
    local icon = LibStub("LibDBIcon-1.0", true)
    if icon then
        if BiaoGe.options[name] == 1 then
            icon:Show(AddonName)
        else
            icon:Hide(AddonName)
        end
    end
end)

-- debug
-- BG.Init2(function(self, event, ...)
--     InterfaceOptionsFrame_OpenToCategory("|cff00BFFFBiaoGe|r")
-- end)
