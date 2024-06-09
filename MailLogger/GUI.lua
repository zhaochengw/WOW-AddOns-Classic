local _, Addon = ...

local Output = Addon.Output
local Config = Addon.Config
local L = Addon.L

--初始化Export窗口
function Output:Initialize()
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
    f:SetPoint(Config.OutputFramePos[1], nil, Config.OutputFramePos[3], Config.OutputFramePos[4], Config.OutputFramePos[5])
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
        Config.OutputFramePos[1], _, Config.OutputFramePos[3], Config.OutputFramePos[4], Config.OutputFramePos[5] = f:GetPoint()
    end)
    f:SetPropagateKeyboardInput(false)
    f:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            f:SetPropagateKeyboardInput(false)
            f:Hide()
            Addon.Calendar.background:Hide()
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
        t:SetText("")
        t:SetPoint("TOP", f.texture, 0, -14)
        self.title = t
    end
    do -- 创建关闭按钮
        local cls = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        cls:SetWidth(50)
        cls:SetHeight(23)
        cls:SetPoint("BOTTOMLEFT", 290, 10)
        cls:SetText(CLOSE)
        cls:SetScript("OnClick", function()
            f:Hide()
            Addon.Calendar.background:Hide()
        end)
        local all = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        all:SetWidth(70)
        all:SetHeight(23)
        all:SetPoint("BOTTOMLEFT", 220, 10)
        all:SetText(L["All"])
        all:SetScript("OnClick", function(self) Addon:PrintTradeLog("ALL", nil) end)
        local tl = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        tl:SetWidth(50)
        tl:SetHeight(23)
        tl:SetPoint("BOTTOMLEFT", 20, 10)
        tl:SetText(L["Trades"])
        tl:SetScript("OnClick", function(self) Addon:PrintTradeLog("TRADE", nil) end)
        local ml = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        ml:SetWidth(50)
        ml:SetHeight(23)
        ml:SetPoint("BOTTOMLEFT", 70, 10)
        ml:SetText(L["Mails"])
        ml:SetScript("OnClick", function(self) Addon:PrintTradeLog("MAIL", nil) end)
        local sm = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        sm:SetWidth(50)
        sm:SetHeight(23)
        sm:SetPoint("BOTTOMLEFT", 120, 10)
        sm:SetText(L["Sent"])
        sm:SetScript("OnClick", function(self) Addon:PrintTradeLog("SMAIL", nil) end)
        local rm = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        rm:SetWidth(50)
        rm:SetHeight(23)
        rm:SetPoint("BOTTOMLEFT", 170, 10)
        rm:SetText(L["Received"])
        rm:SetScript("OnClick", function(self) Addon:PrintTradeLog("RMAIL", nil) end)
	end
    do -- 角色筛选下拉菜单
        local d = CreateFrame("Frame", nil, f, "UIDropDownMenuTemplate")
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmallLeft")
        t:SetText(L["Alt Name"])
        t:SetPoint("LEFT", d, "LEFT", -60, 2)

        local value = {}
        local text = {}
        local index = 1

        for k in pairs(Addon.Config.AltList) do
            table.insert(value, index)
            table.insert(text, k)
            index = index + 1
        end

        UIDropDownMenu_Initialize(d, function(self)
            local info = UIDropDownMenu_CreateInfo()
            d.text = text
            for i = 1, #text do
                info.text = text[i]
                info.value = value[i]
                info.func = function(v)
                    Config.SelectName = text[v.value]
                    UIDropDownMenu_SetText(d, text[v.value])
                    CloseDropDownMenus()
                end
                info.arg1, info.arg2 = d, value[i]
                UIDropDownMenu_AddButton(info)
            end
        end)
        d.SetValue = function(v) Config.SelectName = text[v] end
        d:SetScript("OnShow", function(self)
            UIDropDownMenu_SetText(self, Config.SelectName)
        end)
        UIDropDownMenu_JustifyText(d, "CENTER")
        UIDropDownMenu_SetWidth(d, 120)
        UIDropDownMenu_SetButtonWidth(d, 120)
        d:SetPoint("TOPLEFT", 80, -35)

        local sift = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        sift:SetWidth(100)
        sift:SetHeight(23)
        sift:SetPoint("LEFT", d, "LEFT", 160, 3)
        sift:SetText(L["Sift"])
        sift:SetScript("OnClick", function()
            local DisplayType = "ALL"
            if Output.title:GetText() == L["Trade Logs"] then
                DisplayType = "TRADE"
            elseif Output.title:GetText() == L["Mail Logs"] then
                DisplayType = "MAIL"
            elseif Output.title:GetText() == L["Sent Mail"] then
                DisplayType = "SMAIL"
            elseif Output.title:GetText() == L["Received Mail"] then
                DisplayType = "RMAIL"
            end
            Addon:PrintTradeLog(DisplayType, Config.SelectName)
        end)

        self.dropdowntitle = t
        self.dropdownlist = d
        self.dropdownbutton = sift
    end
    do -- 带Scroll的可编辑输出窗口
        local t = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
        t:SetPoint("TOPLEFT", f, 25, -70)
        t:SetWidth(290)
        t:SetHeight(390)

        local edit = CreateFrame("EditBox", nil, t)
        edit.cursorOffset = 0
        edit:SetWidth(290)
        edit:SetHeight(420)
        edit:SetPoint("TOPLEFT", t, 15, 0)
        edit:SetAutoFocus(false)
        edit:EnableMouse(true)
        edit:SetMaxLetters(99999999)
        edit:SetMultiLine(true)
        edit:SetFontObject(GameTooltipText)
        edit:SetScript("OnTextChanged", function(self)
            ScrollingEdit_OnTextChanged(self, t)
        end)
        edit:SetScript("OnCursorChanged", ScrollingEdit_OnCursorChanged)
        edit:SetScript("OnEditFocusGained", function() edit:HighlightText() end)
        edit:SetScript("OnEscapePressed", function() f:Hide() Addon.Calendar.background:Hide() end)
        edit:Disable()

        edit:SetScript("OnEnter", function()
            if not InCombatLockdown() then
                edit:Enable()
            end
        end)
        edit:SetScript("OnLeave", function() edit:HighlightText(0, 0) edit:Disable() end)

        self.export = edit

        t:SetScrollChild(edit)

        t:Hide()
    end
end
