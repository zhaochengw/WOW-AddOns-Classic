if BG.IsBlackListPlayer then return end

local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local RGB_16 = ns.RGB_16
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local GetText_T = ns.GetText_T
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local Maxb = ns.Maxb

local pt = print
local realmID = GetRealmID()
local player = BG.playerName
local realmName = GetRealmName()

BG.Init(function()
    BiaoGe.whoFrame = BiaoGe.whoFrame or {}
    BiaoGe.whoFrame.history = BiaoGe.whoFrame.history or {}

    local f = CreateFrame("Frame", nil, WhoFrame, "BackdropTemplate")
    f:SetBackdrop({
        bgFile = "Interface/ChatFrame/ChatFrameBackground",
        edgeFile = "Interface/ChatFrame/ChatFrameBackground",
        edgeSize = 1,
    })
    f:SetBackdropColor(0, 0, 0, 0.7)
    f:SetBackdropBorderColor(0, 0, 0, 1)
    f:SetPoint("BOTTOMLEFT", WhoFrameEditBoxInset, "BOTTOMRIGHT", 5, 0)
    f:SetSize(100, FriendsFrame:GetHeight() - 80)
    f:Hide()
    BG.WhoFrameList = f
    local t = f:CreateFontString()
    t:SetPoint("BOTTOM", f, "TOP", 0, 2)
    t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
    t:SetTextColor(RGB("FFFFFF"))
    t:SetText(L["查询记录"])

    -- 提示
    local bt = CreateFrame("Button", nil, f)
    bt:SetSize(30, 30)
    bt:SetPoint("LEFT", t, "RIGHT", -5, 0)
    local tex = bt:CreateTexture()
    tex:SetAllPoints()
    tex:SetTexture(616343)
    bt:SetHighlightTexture(616343)
    bt:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(L["查询记录"], 1, 1, 1)
        GameTooltip:AddLine(" ", 1, 0.82, 0, true)
        GameTooltip:AddLine(L["你可在插件设置-BiaoGe-其他功能里关闭这个功能。"], 0.5, 0.5, 0.5, true)
        GameTooltip:Show()
    end)
    BG.GameTooltip_Hide(bt)

    local buttons = {}
    local max = tonumber(format("%d", f:GetHeight() / 20))
    local function CreateHistory()
        for i, v in pairs(buttons) do
            v:Hide()
        end
        wipe(buttons)

        for i = #BiaoGe.whoFrame.history, 1, -1 do
            if i > max then
                tremove(BiaoGe.whoFrame.history)
            else
                break
            end
        end

        for i, v in ipairs(BiaoGe.whoFrame.history) do
            local bt = CreateFrame("Button", nil, f, "BackdropTemplate")
            bt:SetNormalFontObject(BG.FontGold15)
            bt:SetDisabledFontObject(BG.FontDis15)
            bt:SetHighlightFontObject(BG.FontWhite15)
            bt:SetSize(f:GetWidth() - 10, 20)
            bt:RegisterForClicks("AnyUp")
            if i == 1 then
                bt:SetPoint("BOTTOMLEFT", 8, 5)
            else
                bt:SetPoint("BOTTOMLEFT", buttons[i - 1], "TOPLEFT", 0, 0)
            end
            bt:SetText(v)
            local string = bt:GetFontString()
            if string then
                string:SetWidth(bt:GetWidth() - 2)
                string:SetJustifyH("LEFT")
                string:SetWordWrap(false)
            end
            tinsert(buttons, bt)

            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                GameTooltip:AddLine(AddTexture("LEFT") .. L["搜索该记录"], 1, 0.82, 0)
                GameTooltip:AddLine(AddTexture("RIGHT") .. L["删除该记录"], 1, 0.82, 0)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
            bt:SetScript("OnClick", function(self, enter)
                if enter == "RightButton" then
                    tremove(BiaoGe.whoFrame.history, i)
                    CreateHistory()
                else
                    WhoFrameEditBox:SetText(v)
                    C_FriendList.SendWho(WhoFrameEditBox:GetText(), Enum.SocialWhoOrigin.Social)
                end
                BG.PlaySound(1)
            end)
        end
    end
    CreateHistory()

    local function hookfunc()
        local text = WhoFrameEditBox:GetText()
        if text ~= "" then
            for i = #BiaoGe.whoFrame.history, 1, -1 do
                if BiaoGe.whoFrame.history[i] == text then
                    tremove(BiaoGe.whoFrame.history, i)
                end
            end
            tinsert(BiaoGe.whoFrame.history, 1, text)
            CreateHistory()
        end
    end
    WhoFrameWhoButton:HookScript("OnClick", function()
        hookfunc()
    end)
    WhoFrameEditBox:HookScript("OnEnterPressed", function()
        hookfunc()
    end)


    -- 导出并举报
    local whoText
    local bt = BG.CreateButton(WhoFrame)
    bt:SetSize(100, 22)
    bt:SetPoint("TOPRIGHT", WhoFrame, "TOPRIGHT", -20, -28)
    bt:SetText(L["导出名单"])
    BG.WhoFrameSendOutButton = bt
    bt:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
        GameTooltip:AddLine(L["导出本次查询的所有名单，可以在官网进行批量举报，比游戏里举报更有效。"], 1, 0.82, 0, true)
        GameTooltip:AddLine(" ", 1, 0.82, 0, true)
        GameTooltip:AddLine(L["你可在插件设置-BiaoGe-其他功能-查询记录里关闭这个功能。"], 0.5, 0.5, 0.5, true)
        GameTooltip:Show()
    end)
    bt:SetScript("OnLeave", GameTooltip_Hide)
    bt:SetScript("OnClick", function(self)
        if not self.frame then
            local frame = CreateFrame("Frame", nil, self, "BackdropTemplate")
            frame:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
            })
            frame:SetBackdropColor(0, 0, 0, .9)
            frame:SetPoint("TOPLEFT", WhoFrame, "TOPLEFT", -1, -55)
            frame:SetPoint("BOTTOMRIGHT", WhoFrame, "BOTTOMRIGHT", -1, 68)
            frame:SetFrameLevel(10)
            frame:EnableMouse(true)
            frame:SetFrameStrata("HIGH")
            frame:Hide()
            self.frame = frame
            frame:SetScript("OnHide", function()
                BG.WhoFrameSendOutButton:SetText(L["导出名单"])
                if BG.WhoFrameReportButton then
                    BG.WhoFrameReportButton:Show()
                end
            end)
            frame:SetScript("OnShow", function()
                BG.WhoFrameSendOutButton:SetText(L["关闭名单"])
                if BG.WhoFrameReportButton then
                    BG.WhoFrameReportButton:Hide()
                end
                frame.edit1:SetText(whoText or "")
                frame.edit1:HighlightText()
                frame.edit1:SetFocus()
                frame.edit2:SetText(frame.edit2.text)
            end)
            -- 名单
            do
                local f = CreateFrame("Frame", nil, frame, "BackdropTemplate")
                f:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 1,
                })
                f:SetBackdropColor(0, 0, 0, 0)
                f:SetBackdropBorderColor(1, 1, 1, 0.6)
                f:SetPoint("TOPLEFT", 1, 0)
                f:SetPoint("BOTTOMRIGHT", -1, 90)
                f:EnableMouse(true)
                f:SetScript("OnMouseDown", function()
                    frame.edit1:SetFocus()
                end)
                local edit = CreateFrame("EditBox", nil, f)
                edit:SetWidth(f:GetWidth())
                edit:SetAutoFocus(false)
                edit:EnableMouse(true)
                edit:SetTextInsets(0, 10, 0, 0)
                edit:SetMultiLine(true)
                edit:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                frame.edit1 = edit
                edit:SetScript("OnTextChanged", function()
                    if edit:HasFocus() then
                        edit:SetText(whoText or "")
                        edit:HighlightText()
                    end
                    BG.After(0, function()
                        frame.scroll.ScrollBar:SetValue((select(2, frame.scroll.ScrollBar:GetMinMaxValues())))
                    end)
                end)
                edit:SetScript("OnEscapePressed", function()
                    edit:ClearFocus()
                    edit:ClearHighlightText()
                end)
                edit:SetScript("OnEditFocusGained", function()
                    edit:HighlightText()
                end)
                edit:SetScript("OnEditFocusLost", function()
                    edit:ClearHighlightText()
                end)
                local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
                scroll:SetWidth(f:GetWidth() - 10)
                scroll:SetHeight(f:GetHeight() - 10)
                scroll:SetPoint("CENTER")
                scroll.ScrollBar.scrollStep = BG.scrollStep
                BG.CreateSrollBarBackdrop(scroll.ScrollBar)
                BG.HookScrollBarShowOrHide(scroll, true)
                scroll:SetScrollChild(edit)
                frame.scroll = scroll
            end

            -- 官网
            do
                local f = CreateFrame("Frame", nil, frame, "BackdropTemplate")
                f:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 1,
                })
                f:SetBackdropColor(0, 0, 0, 0)
                f:SetBackdropBorderColor(1, 1, 1, 0.6)
                f:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 1, 60)
                f:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 0)
                f:EnableMouse(true)
                f:SetScript("OnMouseDown", function()
                    frame.edit2:SetFocus()
                end)
                local edit = CreateFrame("EditBox", nil, f)
                edit:SetWidth(f:GetWidth())
                edit:SetAutoFocus(false)
                edit:EnableMouse(true)
                edit:SetTextInsets(0, 10, 0, 0)
                edit:SetMultiLine(true)
                edit:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                if BG.IsVanilla then
                    edit.text = "https://support.battlenet.com.cn/w/question/detail?method=hp_service&template=cheatrpt_aqfk_vanilla"
                else
                    edit.text = "https://support.battlenet.com.cn/w/question/detail?method=hp_service&template=cheatrpt_aqfk"
                end
                frame.edit2 = edit
                edit:SetScript("OnTextChanged", function()
                    if edit:HasFocus() then
                        edit:SetText(edit.text)
                        edit:HighlightText()
                    end
                    BG.After(0, function()
                        frame.scroll.ScrollBar:SetValue((select(2, frame.scroll.ScrollBar:GetMinMaxValues())))
                    end)
                end)
                edit:SetScript("OnEscapePressed", function()
                    edit:ClearFocus()
                    edit:ClearHighlightText()
                end)
                edit:SetScript("OnEditFocusGained", function()
                    edit:HighlightText()
                end)
                edit:SetScript("OnEditFocusLost", function()
                    edit:ClearHighlightText()
                end)
                local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
                scroll:SetWidth(f:GetWidth() - 10)
                scroll:SetHeight(f:GetHeight() - 10)
                scroll:SetPoint("CENTER")
                scroll.ScrollBar.scrollStep = BG.scrollStep
                BG.CreateSrollBarBackdrop(scroll.ScrollBar)
                BG.HookScrollBarShowOrHide(scroll, true)
                scroll:SetScrollChild(edit)

                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                t:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 2, 0)
                t:SetTextColor(1, 0.82, 0)
                t:SetText(L["官方举报地址（比游戏里举报更有效）："])
            end
        end
        self.frame:SetShown(not self.frame:IsVisible())
    end)

    local function GetWhoText()
        whoText = nil
        local whoPlayersName = {}
        local numWhos, totalCount = C_FriendList.GetNumWhoResults()
        if numWhos and numWhos ~= 0 then
            for i = 1, numWhos do
                local info = C_FriendList.GetWhoInfo(i)
                if info then
                    local playerName, realmName = strsplit("-", info.fullName)
                    if not realmName then
                        realmName = GetRealmName()
                    end
                    tinsert(whoPlayersName, playerName .. "/" .. realmName)
                end
            end
        end
        local frame = BG.WhoFrameSendOutButton.frame
        if #whoPlayersName ~= 0 then
            whoText = table.concat(whoPlayersName, " ") .. " "
            BG.WhoFrameSendOutButton:Enable()
            if frame and frame:IsVisible() then
                frame.edit1:SetText(whoText or "")
            end
        else
            BG.WhoFrameSendOutButton:Disable()
            if frame and frame:IsVisible() then
                frame:Hide()
            end
        end
    end

    BG.RegisterEvent("WHO_LIST_UPDATE", function()
        GetWhoText()
    end)

    WhoFrame:HookScript("OnShow", function()
        if BiaoGe.options["searchList"] == 1 then
            BG.WhoFrameList:Show()
            BG.WhoFrameSendOutButton:Show()
            BG.WhoFrameSendOutButton:SetText(L["导出名单"])
            GetWhoText()
        else
            BG.WhoFrameList:Hide()
            BG.WhoFrameSendOutButton:Hide()
        end

        if BG.WhoFrameSendOutButton.frame then
            BG.WhoFrameSendOutButton.frame:Hide()
        end
    end)

    -- test
    -- FriendsFrame:HookScript("OnShow", function(self)
    --     FriendsFrameTab2:Click()
    -- end)
end)
