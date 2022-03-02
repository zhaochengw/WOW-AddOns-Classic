
--[[
    感谢farmer1992，学习了你的RaidLedger很多。
]]

local _, Addon = ...

local Output = Addon.Output
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
    f:SetPoint("RIGHT", -20, 0)
    f:SetToplevel(true)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
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
        t:SetText("")
        t:SetPoint("TOP", f.texture, 0, -14)
        self.title = t
    end
    do -- 创建关闭按钮
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b:SetWidth(120)
        b:SetHeight(25)
        b:SetPoint("BOTTOMLEFT", 200, 20)
        b:SetText(CLOSE)
        b:SetScript("OnClick", function() f:Hide() end)
	end
    do -- 带Scroll的可编辑输出窗口
        local t = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
        t:SetPoint("TOPLEFT", f, 25, -40)
        t:SetWidth(290)
        t:SetHeight(420)

        local edit = CreateFrame("EditBox", nil, t)
        edit.cursorOffset = 0
        edit:SetWidth(290)
        edit:SetHeight(420)
        edit:SetPoint("TOPLEFT", t, 15, 0)
        edit:SetAutoFocus(true)
        edit:EnableMouse(true)
        edit:SetMaxLetters(99999999)
        edit:SetMultiLine(true)
        edit:SetFontObject(GameTooltipText)
        edit:SetScript("OnTextChanged", function(self)
            ScrollingEdit_OnTextChanged(self, t)
        end)
        edit:SetScript("OnCursorChanged", ScrollingEdit_OnCursorChanged)
        edit:SetScript("OnEscapePressed", function() f:Hide() end)
        edit:Disable()

        edit:SetScript("OnEnter", function() edit:Enable() end)
        edit:SetScript("OnLeave", function() edit:Disable() end)
    
        self.export = edit

        t:SetScrollChild(edit)

        t:Hide()
    end
end
