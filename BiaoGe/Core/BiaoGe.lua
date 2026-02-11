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
local Round = ns.Round

local Maxb = ns.Maxb
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print
local realmID = GetRealmID()
local player = BG.playerName
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded
local GetLootMethod = GetLootMethod or C_PartyInfo.GetLootMethod

BG.Init(function()
    ----------主界面----------
    do
        BG.MainFrame = CreateFrame("Frame", "BG.MainFrame", UIParent, "BackdropTemplate")
        BG.MainFrame:SetBackdrop({
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        BG.MainFrame:SetBackdropBorderColor(GetClassRGB(nil, "player", BG.borderAlpha))
        BG.MainFrame:SetPoint("CENTER")
        BG.MainFrame:SetFrameLevel(100)
        BG.MainFrame:SetMovable(true)
        BG.MainFrame:SetToplevel(true)
        BG.MainFrame.IsForbidden = nil

        local r, g, b = GetClassRGB(nil, "player")
        local l = BG.MainFrame:CreateLine()
        l:SetColorTexture(r, g, b, BG.borderAlpha)
        l:SetStartPoint("TOPLEFT", 1, -21)
        l:SetEndPoint("TOPRIGHT", -1, -21)
        l:SetThickness(1)

        BG.MainFrame.titleBg = BG.MainFrame:CreateTexture(nil, "BACKGROUND", nil, 1)
        BG.MainFrame.titleBg:SetPoint("TOPLEFT")
        BG.MainFrame.titleBg:SetPoint("BOTTOMRIGHT", BG.MainFrame, "TOPRIGHT", 0, -22)
        BG.MainFrame.titleBg:SetTexture("Interface\\Buttons\\WHITE8x8")
        BG.MainFrame.titleBg:SetGradient("VERTICAL", CreateColor(r, g, b, .2), CreateColor(r, g, b, .0))

        BG.MainFrame.Bg = BG.MainFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
        BG.MainFrame.Bg:SetAllPoints()

        BG.MainFrame.CloseButton = CreateFrame("Button", nil, BG.MainFrame, "UIPanelCloseButton")
        BG.MainFrame.CloseButton:SetPoint("TOPRIGHT", BG.IsRetail and 0 or 5, BG.IsRetail and 0 or 5)

        BG.MainFrame:SetScript("OnMouseUp", function(self)
            self:StopMovingOrSizing()
        end)
        BG.MainFrame:SetScript("OnMouseDown", function(self)
            BG.FrameHide(0)
            LibBG:CloseDropDownMenus()
            BG.ClearFocus()
            self:StartMoving()
        end)
        BG.MainFrame:SetScript("OnHide", function(self)
            BG.FrameHide(0)
            BG.copy1 = nil
            BG.copy2 = nil
        end)
        BG.MainFrame:SetScript("OnShow", function(self)
            if not BiaoGe.options.SearchHistory.firstOpenMainFrame then
                local name = "scale"
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

                if BiaoGe.Scale then
                    BiaoGe.options[name] = BiaoGe.Scale
                else
                    BiaoGe.options[name] = BG.options[name .. "reset"]
                end
                BG.MainFrame:SetScale(BiaoGe.options[name])
                BG.ReceiveMainFrame:SetScale(tonumber(BiaoGe.options[name]) * 0.95)
                if BG.FBCDFrame then
                    BG.FBCDFrame:SetScale(BiaoGe.options[name])
                end

                if BG.options["buttonscale"] then
                    BG.options["buttonscale"].edit:SetText(BiaoGe.options[name])
                    BG.options["buttonscale"]:SetValue(BiaoGe.options[name])
                end

                BiaoGe.options.SearchHistory.firstOpenMainFrame = true
            end

            if BG.ButtonOnLineCount then
                if BiaoGe.options["autoGetOnline"] == 1 then
                    BG.After(0.5, function()
                        BG.GetChannelMemberCount(BG.ButtonOnLineCount.channel)
                    end)
                end
            end
            -- 检查Frame中点是否超过屏幕边界
            if not self.CheckOutSide then
                self.CheckOutSide = true
                local frameCenterX, frameCenterY = self:GetCenter()
                local screenLeft = 0
                local screenRight = UIParent:GetWidth()
                local screenTop = UIParent:GetHeight()
                local screenBottom = 0
                if frameCenterX < screenLeft or frameCenterX > screenRight or
                    frameCenterY < screenBottom or frameCenterY > screenTop then
                    BG.MainFrame:ClearAllPoints()
                    BG.MainFrame:SetPoint("CENTER")
                end
            end

            if not IsInRaid(1) then
                local GuildRoster = GuildRoster or C_GuildInfo.GuildRoster
                GuildRoster()
            end
        end)

        local TitleText = BG.MainFrame:CreateFontString()
        TitleText:SetPoint("TOP", -40, -4);
        TitleText:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        TitleText:SetTextColor(RGB("00BFFF"))
        TitleText:SetText(L["<BiaoGe> 金团表格"])
        BG.Title = TitleText
        local VerText = BG.MainFrame:CreateFontString()
        VerText:SetPoint("BOTTOMLEFT", TitleText, "BOTTOMRIGHT", 0, 0)
        VerText:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
        VerText:SetTextColor(RGB("00BFFF"))
        VerText:SetText(BG.ver)
        BG.VerText = VerText

        -- 说明书
        local f = CreateFrame("Frame", nil, BG.MainFrame)
        f:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 8, -1)
        f:SetHitRectInsets(0, 0, 0, 0)
        local t = f:CreateFontString()
        t:SetPoint("CENTER")
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetJustifyH("LEFT")
        t:SetText(L["说明书"])
        t:SetTextColor(0, 1, 0)
        f:SetSize(t:GetStringWidth(), 20)
        BG.ShuoMingShu = f
        BG.ShuoMingShuText = t
        local function OnEnter(self)
            self.OnEnter = true
            GameTooltip:SetOwner(self, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
            GameTooltip:ClearLines()
            for _, text in ipairs(ns.instructionsText) do
                GameTooltip:AddLine(text)
            end
            for _, text in ipairs(ns.updateText_now) do
                GameTooltip:AddLine(text)
            end
            for _, text in ipairs(ns.updateText_before) do
                GameTooltip:AddLine(text)
            end
            GameTooltip:Show()
            t:SetTextColor(1, 1, 1)
        end
        f:SetScript("OnEnter", OnEnter)
        f:SetScript("OnLeave", function(self)
            self.OnEnter = false
            GameTooltip:Hide()
            t:SetTextColor(0, 1, 0)
        end)
        --[[ BG.RegisterEvent("MODIFIER_STATE_CHANGED", function(self, event, enter)
            if (enter == "LALT" or enter == "RALT") and f.OnEnter then
                OnEnter(f)
            end
        end) ]]

        BG.MainFrame:SetHeight(BG.FBHeight[BG.FB1])
        BG.MainFrame:SetWidth(BG.FBWidth[BG.FB1])

        -- 报错
        BG.MainFrame.ErrorText = BG.MainFrame:CreateFontString()
        BG.MainFrame.ErrorText:SetFont(BIAOGE_TEXT_FONT, 70, "OUTLINE")
        BG.MainFrame.ErrorText:SetPoint("CENTER")
        BG.MainFrame.ErrorText:SetWidth(BG.MainFrame:GetWidth() - 50)
        BG.MainFrame.ErrorText:SetTextColor(1, 0, 0)
        BG.MainFrame.ErrorText:SetText(L["插件加载错误。"])

        -- VIP
        BG.Init2(function()
            if not ns.enUS and not (BGV and BGV.raidVersion) then
                BG.VIPVerText = CreateFrame("Frame", nil, BG.MainFrame)
                BG.VIPVerText:SetPoint("LEFT", BG.VerText, "RIGHT", 5, 0)
                local t = BG.VIPVerText:CreateFontString()
                t:SetPoint("CENTER")
                t:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
                t:SetTextColor(.5, .5, .5)
                t:SetText(L["订阅模块"])
                BG.VIPVerText:SetSize(t:GetWidth(), 15)
                BG.VIPVerText:SetScript("OnMouseDown", function(self)
                    BG.PlaySound(1)
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    ChatEdit_ChooseBoxForSend():SetText("https://www.biaogevip.com")
                    ChatEdit_ChooseBoxForSend():HighlightText()
                end)
                BG.VIPVerText:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_NONE", 0, 0)
                    GameTooltip:SetPoint("TOP", self, "BOTTOM", 0, 0)
                    GameTooltip:ClearLines()
                    for i, text in ipairs(ns.VIPinstructionsText) do
                        if i == 1 then
                            text = text
                        end
                        GameTooltip:AddLine(text)
                    end
                    GameTooltip:Show()
                end)
                BG.VIPVerText:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)

                local vipState = ""
                local type = select(5, C_AddOns.GetAddOnInfo("BiaoGeVIP"))
                if type == "MISSING" then
                    vipState = L["|cffff0000（未订阅）"]
                elseif BiaoGeVIP then
                    if not BGV then
                        if BiaoGeLib then
                            vipState = L["|cffff0000（订阅已过期或未开更新器）"]
                        else
                            vipState = L["|cffff0000（BiaoGeLib插件被禁用）"]
                        end
                    end
                else
                    vipState = L["|cffff0000（插件被禁用）"]
                end
                local aiState = ""
                local type = select(5, C_AddOns.GetAddOnInfo("BiaoGeAI"))
                if type == "MISSING" then
                    aiState = L["|cffff0000（未订阅）"]
                elseif BiaoGeAI then
                    if not BGAI then
                        if BiaoGeLib then
                            aiState = L["|cffff0000（订阅已过期或未开更新器）"]
                        else
                            aiState = L["|cffff0000（BiaoGeLib插件被禁用）"]
                        end
                    end
                else
                    aiState = L["|cffff0000（插件被禁用）"]
                end
                for i, text in ipairs(ns.VIPinstructionsText) do
                    if text:find("BiaoGeVIP" .. L["插件"]) then
                        ns.VIPinstructionsText[i] = text .. vipState
                    elseif text:find("BiaoGeAI" .. L["插件"]) then
                        ns.VIPinstructionsText[i] = text .. aiState
                    end
                end
            end

            BG.HistoryMainFrame:HookScript("OnShow", function(self)
                if BG.VIPVerText then
                    BG.VIPVerText:Hide()
                end
                if BG.AccountsVerText then
                    BG.AccountsVerText:Hide()
                end
            end)
            BG.HistoryMainFrame:HookScript("OnHide", function(self)
                if BG.VIPVerText then
                    BG.VIPVerText:Show()
                end
                if BG.AccountsVerText then
                    BG.AccountsVerText:Show()
                end
            end)
        end)

        -- 更新日记窗口
        -- BiaoGe.options.SearchHistory[ns.updateText_now[1]]=nil
        local function FiterVer(ver)
            for fullVer in pairs(BiaoGe.options.SearchHistory) do
                if fullVer:find(ver) then
                    return false
                end
            end
            return true
        end
        if next(ns.updateText_now) and not BiaoGe.options.SearchHistory[ns.updateText_now[1]] then
            BiaoGe.options.SearchHistory[ns.updateText_now[1]] = true
            if BiaoGe.options.lastVer then
                local f = BG.CreateMainFrame()
                f:SetSize(450, 1)
                f:SetFrameStrata("HIGH")
                f.titleText:SetText(L["<BiaoGe> 金团表格"])
                f.texts = {}
                BG.updateFrame = f
                local w = 15
                for i, text in ipairs(ns.updateText_now) do
                    local t = f:CreateFontString()
                    t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                    t:SetText(text)
                    t:SetWidth(f:GetWidth() - w * 2)
                    if i == 1 then
                        t:SetPoint("TOPLEFT", w, -35)
                        t:SetJustifyH("CENTER")
                    else
                        t:SetPoint("TOPLEFT", f.texts[i - 1], "BOTTOMLEFT", 0, -15)
                        t:SetJustifyH("LEFT")
                    end
                    t:SetTextColor(1, .82, 0)
                    tinsert(f.texts, t)
                end
                f:SetHeight(f:GetTop() - f.texts[#f.texts]:GetBottom())
            end
        end
        BiaoGe.options.lastVer = BG.ver
    end
    tinsert(UISpecialFrames, "BG.MainFrame")

    ----------二级Frame----------
    do
        -- 当前表格
        BG.FBMainFrame = CreateFrame("Frame", nil, BG.MainFrame)
        do
            BG.FBMainFrame:Hide()
            for i, FB in ipairs(BG.FBtable) do
                BG["Frame" .. FB] = CreateFrame("Frame", "BG.Frame" .. FB, BG.FBMainFrame)
                BG["Frame" .. FB]:Hide()
            end
            BG.FBMainFrame:SetScript("OnShow", function(self)
                local FB = BG.FB1
                BG.FrameHide(0)
                for i, FB in ipairs(BG.FBtable) do
                    BG["Frame" .. FB]:Hide()
                end
                BG["Frame" .. FB]:Show()
                BiaoGe.lastFrame = "FB"

                BG.HistoryMainFrame:Hide()
                BG.History.List:Hide()
                BG.History.List:SetParent(self)
                BG.History.List:SetFrameLevel(BG.History.List.frameLevel)

                BG.History.HistoryButton:SetParent(self)
                BG.History.SaveButton:SetParent(self)
                BG.History.SendButton:SetParent(self)
                BG.History.DaoChuButton:SetParent(self)
                BG.History.HistoryButton:SetEnabled(true)
                BG.History.SaveButton:SetEnabled(true)
                BG.History.SendButton:SetEnabled(true)
                BG.History.DaoChuButton:SetEnabled(true)

                BG.ButtonZhangDan:SetParent(self)
                for i, bt in ipairs(BG.TongBaoButtons) do
                    bt:Enable()
                end

                BG.UpdateLockoutIDText()

                BG.TabButtonsFB:Show()
                for i, FB in ipairs(BG.FBtable) do
                    BG["Button" .. FB]:SetEnabled(true)
                end
                BG["Button" .. BG.FB1]:SetEnabled(false)

                BG.ButtonQingKong:SetParent(self)
                BG.ButtonQingKong:SetEnabled(true)
                if BG.NanDuDropDown then
                    BG.NanDuDropDown.DropDown:Show()
                    LibBG:UIDropDownMenu_EnableDropDown(BG.NanDuDropDown.DropDown)
                end

                BG.UpdateBiaoGeAllIsHaved()

                BG.FilterClassItemMainFrame.Buttons2:SetParent(self)
                BG.FilterClassItemMainFrame:Hide()
                BG.FilterClassItemMainFrame.Buttons2:UpdatePoint()
            end)
        end
        -- 心愿清单
        BG.HopeMainFrame = CreateFrame("Frame", nil, BG.MainFrame)
        do
            BG.HopeMainFrame:Hide()
            for i, FB in ipairs(BG.FBtable) do
                BG["HopeFrame" .. FB] = CreateFrame("Frame", "BG.HopeFrame" .. FB, BG.HopeMainFrame)
                BG["HopeFrame" .. FB]:Hide()
            end
            BG.BackBiaoGe(BG.HopeMainFrame)
            BG.HopeMainFrame:SetScript("OnShow", function(self)
                local FB = BG.FB1
                BG.FrameHide(0)
                for i, FB in ipairs(BG.FBtable) do
                    BG["HopeFrame" .. FB]:Hide()
                end
                BG["HopeFrame" .. FB]:Show()
                -- BG.HopePlanMainFrame:Hide()
                BiaoGe.lastFrame = "Hope"

                BG.HistoryMainFrame:Hide()

                BG.TabButtonsFB:Show()
                for i, FB in ipairs(BG.FBtable) do
                    BG["Button" .. FB]:SetEnabled(true)
                end
                BG["Button" .. BG.FB1]:SetEnabled(false)

                if BG.NanDuDropDown then
                    BG.NanDuDropDown.DropDown:Show()
                    LibBG:UIDropDownMenu_EnableDropDown(BG.NanDuDropDown.DropDown)
                end

                BG.UpdateBiaoGeAllIsHaved()

                BG.FilterClassItemMainFrame.Buttons2:SetParent(self)
                BG.FilterClassItemMainFrame:Hide()
                BG.FilterClassItemMainFrame.Buttons2:UpdatePoint()

                BG.ButtonImportHope:SetParent(self)
                BG.ButtonExportHope:SetParent(self)
            end)
            -- 左下角文字介绍
            do
                local t = BG.HopeMainFrame:CreateFontString()
                t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 75)
                t:SetFont(BIAOGE_TEXT_FONT, 20, "OUTLINE")
                t:SetTextColor(RGB(BG.g1))
                t:SetText(L["心愿清单："])
                local tt = t
                local t = BG.HopeMainFrame:CreateFontString()
                t:SetPoint("LEFT", tt, "RIGHT", 0, 0)
                t:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
                t:SetTextColor(RGB(BG.g2))
                t:SetText(L["你可以设置一些装备，这些装备只要掉落就会提醒，并且自动关注团长拍卖"])
            end
        end
        -- 装备库
        BG.ItemLibMainFrame = CreateFrame("Frame", nil, BG.MainFrame)
        do
            BG.ItemLibMainFrame:Hide()
            BG.BackBiaoGe(BG.ItemLibMainFrame)
            BG.ItemLibMainFrame:SetScript("OnShow", function(self)
                local FB = BG.FB1
                BG.FrameHide(0)
                BiaoGe.lastFrame = "ItemLib"

                BG.HistoryMainFrame:Hide()

                BG.TabButtonsFB:Show()
                for i, FB in ipairs(BG.FBtable) do
                    BG["Button" .. FB]:SetEnabled(true)
                end
                BG["Button" .. BG.FB1]:SetEnabled(false)

                if BG.NanDuDropDown then
                    BG.NanDuDropDown.DropDown:Hide()
                end

                BG.FilterClassItemMainFrame.Buttons2:SetParent(self)
                BG.FilterClassItemMainFrame:Hide()
                BG.FilterClassItemMainFrame.Buttons2:ClearAllPoints()
                BG.FilterClassItemMainFrame.Buttons2:SetPoint("LEFT", BG.ItemLibMainFrame.filtleText, "RIGHT", 10, 0)

                BG.ButtonImportHope:SetParent(self)
                BG.ButtonExportHope:SetParent(self)
            end)

            -- 左下角文字介绍
            do
                local t = BG.ItemLibMainFrame:CreateFontString()
                t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 45)
                t:SetFont(BIAOGE_TEXT_FONT, 20, "OUTLINE")
                t:SetTextColor(RGB(BG.g1))
                t:SetText(L["装备库："])
                local tt = t
                local t = BG.ItemLibMainFrame:CreateFontString()
                t:SetPoint("LEFT", tt, "RIGHT", 0, 0)
                t:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
                t:SetTextColor(RGB(BG.g2))
                t:SetText(L["查看所有适合你的装备"])
                local tt = t
                local t = BG.ItemLibMainFrame:CreateFontString()
                t:SetPoint("LEFT", tt, "RIGHT", 0, 0)
                t:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
                -- t:SetTextColor(RGB(BG.dis))
                t:SetText(format(L["（ALT+%s设为心愿装备。部位按钮支持使用滚轮切换）"], AddTexture("LEFT")))
            end
        end
        -- 对账
        BG.DuiZhangMainFrame = CreateFrame("Frame", nil, BG.MainFrame)
        do
            BG.DuiZhangMainFrame:Hide()
            for i, FB in ipairs(BG.FBtable) do
                BG["DuiZhangFrame" .. FB] = CreateFrame("Frame", "BG.DuiZhangFrame" .. FB, BG.DuiZhangMainFrame)
                BG["DuiZhangFrame" .. FB]:Hide()
            end
            BG.BackBiaoGe(BG.DuiZhangMainFrame)
            BG.DuiZhangMainFrame:SetScript("OnShow", function(self)
                local FB = BG.FB1
                BG.FrameHide(0)
                for i, FB in ipairs(BG.FBtable) do
                    BG["DuiZhangFrame" .. FB]:Hide()
                end
                BG["DuiZhangFrame" .. FB]:Show()
                if BG.lastduizhangNum then
                    BG.DuiZhangSet(BG.lastduizhangNum)
                end
                BiaoGe.lastFrame = "DuiZhang"

                BG.HistoryMainFrame:Hide()

                BG.TabButtonsFB:Show()
                for i, FB in ipairs(BG.FBtable) do
                    BG["Button" .. FB]:SetEnabled(true)
                end
                BG["Button" .. BG.FB1]:SetEnabled(false)

                if BG.NanDuDropDown then
                    BG.NanDuDropDown.DropDown:Hide()
                end

                BG.UpdateBiaoGeAllIsHaved()
            end)
            -- 左下角文字介绍
            do
                local t = BG.DuiZhangMainFrame:CreateFontString()
                t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 45)
                t:SetFont(BIAOGE_TEXT_FONT, 20, "OUTLINE")
                t:SetTextColor(RGB(BG.g1))
                t:SetText(L["对账"])
            end
        end
        -- YY评价
        BG.YYMainFrame = CreateFrame("Frame", nil, BG.MainFrame)
        do
            BG.YYMainFrame:Hide()
            BG.BackBiaoGe(BG.YYMainFrame)
            BG.YYMainFrame:SetScript("OnShow", function(self)
                local FB = BG.FB1
                BG.FrameHide(0)
                BiaoGe.lastFrame = "YY"

                BG.HistoryMainFrame:Hide()

                BG.TabButtonsFB:Hide()

                if BG.NanDuDropDown then
                    BG.NanDuDropDown.DropDown:Hide()
                end
            end)
            -- 左下角文字介绍
            do
                local t = BG.YYMainFrame:CreateFontString()
                t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 45)
                t:SetFont(BIAOGE_TEXT_FONT, 20, "OUTLINE")
                t:SetTextColor(RGB(BG.g1))
                t:SetText(L["YY评价"])
            end
        end

        -- 团员成就
        if BG.IsWLK_80 or BG.IsMOP then
            local name = "AchievementMainFrame"
            BG[name] = CreateFrame("Frame", "BG." .. name, BG.MainFrame)
            do
                BG[name]:Hide()
                BG.BackBiaoGe(BG[name])
                BG[name]:SetScript("OnShow", function(self)
                    local FB = BG.FB1
                    BG.FrameHide(0)
                    BiaoGe.lastFrame = "Achievement"

                    BG.HistoryMainFrame:Hide()

                    BG.TabButtonsFB:Show()

                    if BG.NanDuDropDown then
                        BG.NanDuDropDown.DropDown:Hide()
                    end
                end)

                -- 左下角文字介绍
                do
                    local t = BG[name]:CreateFontString()
                    t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 45)
                    t:SetFont(BIAOGE_TEXT_FONT, 20, "OUTLINE")
                    t:SetTextColor(RGB(BG.g1))
                    t:SetText(L["团员成就："])
                    local tt = t
                    local t = BG[name]:CreateFontString()
                    t:SetPoint("LEFT", tt, "RIGHT", 0, 0)
                    t:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
                    t:SetTextColor(RGB(BG.g2))
                    t:SetText(L["查看团员的团本成就完成情况（该功能引用于比较成就里的API）"])
                end
            end
        end

        -- 团本攻略
        if BG.IsWLK_80 then
            BG.BossMainFrame = CreateFrame("Frame", nil, BG.MainFrame)
            do
                BG.BossMainFrame:Hide()
                for i, FB in ipairs(BG.FBtable) do
                    BG["BossFrame" .. FB] = CreateFrame("Frame", "BG.BossFrame" .. FB, BG.BossMainFrame)
                    BG["BossFrame" .. FB]:Hide()
                end
                BG.BackBiaoGe(BG.BossMainFrame)
                BG.BossMainFrame:SetScript("OnShow", function(self)
                    local FB = BG.FB1
                    BG.FrameHide(0)
                    for i, FB in ipairs(BG.FBtable) do
                        BG["BossFrame" .. FB]:Hide()
                    end
                    BG["BossFrame" .. FB]:Show()
                    BiaoGe.lastFrame = "Boss"

                    BG.HistoryMainFrame:Hide()

                    BG.TabButtonsFB:Show()
                    for i, FB in ipairs(BG.FBtable) do
                        BG["Button" .. FB]:SetEnabled(true)
                    end
                    BG["Button" .. BG.FB1]:SetEnabled(false)

                    if BG.NanDuDropDown then
                        BG.NanDuDropDown.DropDown:Hide()
                    end
                end)
                -- 左下角文字介绍
                do
                    local t = BG.BossMainFrame:CreateFontString()
                    t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 45)
                    t:SetFont(BIAOGE_TEXT_FONT, 20, "OUTLINE")
                    t:SetTextColor(RGB(BG.g1))
                    t:SetText(L["团本攻略"])
                end
            end
        end

        -- 历史表格
        BG.HistoryMainFrame = CreateFrame("Frame", "BG.HistoryMainFrame", BG.MainFrame)
        do
            BG.HistoryMainFrame:Hide()
            for i, FB in ipairs(BG.FBtable) do
                BG["HistoryFrame" .. FB] = CreateFrame("Frame", "BG.HistoryFrame" .. FB, BG.HistoryMainFrame)
                BG["HistoryFrame" .. FB]:Hide()
            end
            BG.HistoryMainFrame:SetScript("OnShow", function(self)
                local FB = BG.FB1
                for i, FB in ipairs(BG.FBtable) do
                    BG["HistoryFrame" .. FB]:Hide()
                end
                BG["HistoryFrame" .. FB]:Show()
                BG.FBMainFrame:Hide()
                BG.Title:Hide()
                BG.VerText:Hide()

                BG.History.SaveButton:SetEnabled(false)

                BG.History.List:SetParent(self)
                BG.History.List:SetFrameLevel(BG.History.List.frameLevel)

                BG.History.HistoryButton:SetParent(self)
                BG.History.SaveButton:SetParent(self)
                BG.History.SendButton:SetParent(self)
                BG.History.DaoChuButton:SetParent(self)

                BG.ButtonZhangDan:SetParent(self)
                for i, bt in ipairs(BG.TongBaoButtons) do
                    bt:Disable()
                end

                BG.UpdateLockoutIDText()

                for i, FB in ipairs(BG.FBtable) do
                    BG["Button" .. FB]:SetEnabled(false)
                end

                BG.ButtonQingKong:SetParent(self)
                BG.ButtonQingKong:SetEnabled(false)
                -- BG.ButtonQingKong:Disable()

                if BG.NanDuDropDown then
                    LibBG:UIDropDownMenu_DisableDropDown(BG.NanDuDropDown.DropDown)
                end

                BG.UpdateBiaoGeAllIsHaved()

                BG.FilterClassItemMainFrame.Buttons2:SetParent(self)
                BG.FilterClassItemMainFrame:Hide()

                if BG.ButtonNewBee then
                    BG.ButtonNewBee:Hide()
                end
            end)
            BG.HistoryMainFrame:SetScript("OnHide", function(self)
                BG.Title:Show()
                BG.VerText:Show()

                if BG.ButtonNewBee then
                    BG.ButtonNewBee:Show()
                end
                if not self:IsShown() then
                    BG.History.chooseNum = nil
                end
            end)
        end
    end
    ----------生成各副本UI----------
    do
        for k, FB in pairs(BG.FBtable) do
            BG.CreateFBUI(FB, "FB")
            BG.HopeUI(FB)
        end
        BG.CreateBossModel()
        BG.HopeDaoChuUI()

        --通报UI
        if BG.IsWLK or BG.IsMOP then
            BG.hasWCL = true
        end
        local lastbt
        lastbt = BG.ZhangDanUI(lastbt)
        lastbt = BG.LiuPaiUI(lastbt)
        lastbt = BG.XiaoFeiUI(lastbt)
        lastbt = BG.QianKuanUI(lastbt)
        lastbt = BG.YongShiUI(lastbt)
        if BG.hasWCL then
            lastbt = BG.WCLUI(lastbt)
        end
        BG.NotifyChannelUI(lastbt)

        BG.HistoryUI()
        BG.ReceiveUI()
        BG.DuiZhangUI()
        BG.DuiZhangList()
        BG.RoleOverviewUI()
        BG.FilterClassItemUI()
        BG.ItemLibUI()
        BG.ClearBiaoGeUI()
    end
    ----------设置----------
    do
        BG.TopLeftButtonJianGe = 7
        -- 设置
        do
            local bt = CreateFrame("Button", nil, BG.MainFrame)
            bt:SetPoint("TOPLEFT", BG.ShuoMingShu, "TOPRIGHT", BG.TopLeftButtonJianGe, 0)
            bt:SetNormalFontObject(BG.FontGreen15)
            bt:SetDisabledFontObject(BG.FontDis15)
            bt:SetHighlightFontObject(BG.FontWhite15)
            bt:SetText(L["设置"])
            bt:SetSize(bt:GetFontString():GetWidth(), 20)
            BG.SetTextHighlightTexture(bt)
            BG.ButtonSheZhi = bt

            bt:SetScript("OnClick", function(self)
                ns.InterfaceOptionsFrame_OpenToCategory(BG.optionsName)
                BG.MainFrame:Hide()
                BG.PlaySound(1)
            end)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_NONE")
                GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                GameTooltip:AddLine(L["快捷命令：/BGO"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            BG.GameTooltip_Hide(bt)
        end

        -- 通知移动
        do
            -- 屏幕中央的退出按钮
            do
                local bt = CreateFrame("Button", nil, UIParent, "BackdropTemplate")
                bt:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 1,
                })
                bt:SetBackdropColor(0, 0, 0, 0.5)
                bt:SetBackdropBorderColor(RGB("00FF00", 1))
                bt:SetPoint("CENTER")
                bt:SetFrameStrata("FULLSCREEN_DIALOG")
                bt:SetFrameLevel(200)
                local font = bt:CreateFontString()
                font:SetTextColor(RGB("00FF00"))
                font:SetFont(BIAOGE_TEXT_FONT, 20, "OUTLINE")
                bt:SetFontString(font)
                bt:SetText(L["通知锁定"])
                bt:SetSize(font:GetWidth() + 30, font:GetHeight() + 10)
                bt:Hide()
                BG.ButtonMoveLock = bt

                local text = bt:CreateFontString()
                text:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
                text:SetAlpha(0.8)
                text:SetPoint("BOTTOMLEFT", bt, "BOTTOMRIGHT", 5, 0)
                text:SetText(AddTexture("RIGHT") .. L["通知框体可还原位置"])

                bt:SetScript("OnEnter", function(self)
                    font:SetTextColor(RGB("FFFFFF"))
                    bt:SetBackdropBorderColor(1, 1, 1, 1)
                end)
                bt:SetScript("OnLeave", function(self)
                    font:SetTextColor(RGB("00FF00"))
                    bt:SetBackdropBorderColor(RGB("00FF00", 1))
                end)
                bt:SetScript("OnClick", function()
                    BG.HideMove()
                end)
            end

            local itemID
            if BG.IsVanilla_Sod then
                itemID = 209562
            elseif BG.IsVanilla_60 then
                itemID = 19019
            else
                itemID = 49623
            end

            function BG.HideMove()
                for k, f in pairs(BG.Movetable) do
                    f:SetBackdropColor(0, 0, 0, 0)
                    f:SetBackdropBorderColor(0, 0, 0, 0)
                    f:SetMovable(false)
                    f:EnableMouse(false)
                    f:SetScript("OnUpdate", nil)
                    f.name:Hide()
                    f:Clear()
                end
                BG.ButtonMoveLock:Hide()
                BG.ButtonMove:SetText(L["通知移动"])
            end

            function BG.Move()
                if BG.FrameLootMsg:IsMovable() then
                    BG.HideMove()
                else
                    for k, f in pairs(BG.Movetable) do
                        f:SetBackdrop({
                            bgFile = "Interface/ChatFrame/ChatFrameBackground",
                            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                            edgeSize = 2,
                        })
                        f:SetBackdropColor(0, 0, 0, 0.5)
                        f:SetBackdropBorderColor(0, 0, 0, 1)
                        f:SetMovable(true)
                        f:SetScript("OnMouseUp", function(self, enter)
                            self:StopMovingOrSizing()
                            if enter == "RightButton" then
                                f:ClearAllPoints()
                                f:SetPoint(unpack(f.homepoin))
                            end
                            BiaoGe.point[f:GetName()] = { f:GetPoint(1) }
                        end)
                        f:SetScript("OnMouseDown", function(self)
                            self:StartMoving()
                        end)
                        f.name:Show()

                        local time1 = 0
                        local time_update = 1.5
                        if f == BG.FrameTradeMsg then
                            time_update = 4
                        end
                        local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(itemID)
                        local FB = BG.FB1
                        local num = Maxb[FB] - 2
                        f:SetScript("OnUpdate", function()
                            local time2 = GetTime()
                            if time2 - time1 >= time_update then
                                if link then
                                    if f == BG.FrameLootMsg then
                                        f:AddMessage("|cff00BFFF" ..
                                            format(L["已自动记入表格：%s%s(%s) => %s< %s >%s"], RR, (AddTexture(Texture) .. link), level, "|cffFF1493", BG.Boss[FB]["boss" .. num]["name2"], RR) .. BG.STC_r1(L[" （测试） "]))
                                    else
                                        f:AddMessage(format("|cff00BFFF" .. L["< 交易记账成功 >|r\n装备：%s\n买家：%s\n金额：%s%d|rg%s\nBOSS：%s%s|r"],
                                            (AddTexture(Texture) .. link), SetClassCFF(BG.GN(), "Player"), "|cffFFD700", 10000, L["|cffFF0000（欠款2000）|r"], "|cff" .. BG.Boss[FB]["boss" .. num]["color"], BG.Boss[FB]["boss" .. num]["name2"]) .. BG.STC_r1(L[" （测试） "]))
                                    end
                                else
                                    name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(itemID)
                                end
                                time1 = time2
                            end
                        end)
                    end
                    BG.ButtonMoveLock:Show()
                    BG.MainFrame:Hide()
                    BG.ButtonMove:SetText(L["通知锁定"])
                end
                BG.PlaySound(1)
            end

            local bt = CreateFrame("Button", nil, BG.MainFrame)
            bt:SetPoint("TOPLEFT", BG.ButtonSheZhi, "TOPRIGHT", BG.TopLeftButtonJianGe, 0)
            bt:SetNormalFontObject(BG.FontGreen15)
            bt:SetDisabledFontObject(BG.FontDis15)
            bt:SetHighlightFontObject(BG.FontWhite15)
            bt:SetText(L["通知移动"])
            bt:SetSize(bt:GetFontString():GetWidth(), 20)
            BG.SetTextHighlightTexture(bt)
            BG.ButtonMove = bt
            bt:SetScript("OnClick", BG.Move)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_NONE")
                GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                GameTooltip:AddLine(L["调整装备记录通知和交易通知的位置。"], 1, 0.82, 0, true)
                GameTooltip:AddLine(L["快捷命令：/BGM"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
            GetItemInfo(itemID) -- 提前缓存
        end

        -- 工资抹零
        do
            local name = "moLing"

            local FB = BG.FB1

            local function OnClick(self)
                if self:GetChecked() then
                    BiaoGe.options[self.name] = 1
                else
                    BiaoGe.options[self.name] = 0
                end
                for i, FB in ipairs(BG.FBtable) do
                    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine5"]:SetText(BG.GetWages())
                    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine5"]:SetCursorPosition(0)
                end
                BG.PlaySound(1)
            end
            local function OnEnter(self)
                GameTooltip:SetOwner(self.Text, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self.Text:GetText(), 1, 1, 1, true)
                GameTooltip:AddLine(L["抹去工资小数点"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end
            local function OnLeave(self)
                GameTooltip:Hide()
            end

            local bt = CreateFrame("CheckButton", nil, BG["Frame" .. FB]["scrollFrame" .. Maxb[FB] + 2].owner, "ChatConfigCheckButtonTemplate")
            bt:SetSize(25, 25)
            bt.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            bt.Text:SetText(L["工资抹零"])
            bt.Text:SetTextColor(RGB(BG.b1))
            bt.Text:ClearAllPoints()
            bt.Text:SetHeight(20)
            bt.Text:SetPoint("TOPLEFT", bt:GetParent(), "BOTTOMLEFT", 3, 0)
            bt:SetPoint("LEFT", bt.Text, "RIGHT", 0, -1)
            bt:SetHitRectInsets(-bt.Text:GetWidth(), 0, 0, 0)
            bt.name = name
            if BiaoGe.options[name] == 1 then
                bt:SetChecked(true)
            else
                bt:SetChecked(false)
            end
            bt:SetScript("OnClick", OnClick)
            bt:SetScript("OnEnter", OnEnter)
            bt:SetScript("OnLeave", OnLeave)

            function BG.UpdateMoLingButton()
                local FB = BG.FB1
                bt:SetParent(BG["Frame" .. FB]["scrollFrame" .. Maxb[FB] + 2].owner)
                bt.Text:ClearAllPoints()
                bt.Text:SetPoint("TOPLEFT", bt:GetParent(), "BOTTOMLEFT", 3, -1)
            end
        end
    end
    ----------难度选择菜单----------
    if not BG.onlyOneHard then
        local tbl = {
            [3] = { ID = 3, name = L["10人|cff00BFFF普通|r"], sound = 12880 },
            [5] = { ID = 5, name = L["10人|cffFF0000英雄|r"], sound = 12873 },
            [4] = { ID = 4, name = L["25人|cff00BFFF普通|r"], sound = 12880 },
            [6] = { ID = 6, name = L["25人|cffFF0000英雄|r"], sound = 12873 },

            [175] = { ID = 3, name = L["10人|cff00BFFF普通|r"], sound = 12880 },
            [193] = { ID = 5, name = L["10人|cffFF0000英雄|r"], sound = 12873 },
            [176] = { ID = 4, name = L["25人|cff00BFFF普通|r"], sound = 12880 },
            [194] = { ID = 6, name = L["25人|cffFF0000英雄|r"], sound = 12873 },

            [14] = { ID = 14, name = L["|cff00BFFF普通|r"], sound = 12880 },
            [15] = { ID = 15, name = L["|cffFF0000英雄|r"], sound = 12873 },
            [16] = { ID = 16, name = L["|cffa335ee史诗|r"], sound = 12877 },
        }
        local function AddButton(diffID)
            local text = tbl[diffID].name
            local soundID = tbl[diffID].sound
            local info = LibBG:UIDropDownMenu_CreateInfo()
            info.text = text
            info.func = function()
                local yes, type = IsInInstance()
                if not yes then
                    SetRaidDifficultyID(diffID)
                    PlaySound(soundID)
                else
                    StaticPopupDialogs["QIEHUANFUBEN"].OnAccept = function()
                        SetRaidDifficultyID(diffID)
                        PlaySound(soundID)
                    end
                    StaticPopup_Show("QIEHUANFUBEN", text)
                end
                BG.FrameHide(0)
            end
            if tbl[GetRaidDifficultyID()].ID == diffID then
                info.checked = true
            end
            LibBG:UIDropDownMenu_AddButton(info)
        end
        StaticPopupDialogs["QIEHUANFUBEN"] = {
            text = L["确认切换难度为< %s >？"],
            button1 = L["是"],
            button2 = L["否"],
            OnCancel = function()
            end,
            timeout = 10,
            whileDead = true,
            hideOnEscape = true,
        }

        BG.NanDuDropDown = {}
        local dropDown = LibBG:Create_UIDropDownMenu("BG.NanDuDropDown.dropDown", BG.MainFrame)
        dropDown:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 250, 30)
        LibBG:UIDropDownMenu_SetWidth(dropDown, 95)
        LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "BOTTOM", dropDown, "TOP")
        BG.dropDownToggle(dropDown)
        BG.NanDuDropDown.DropDown = dropDown
        local text = dropDown:CreateFontString()
        text:SetPoint("RIGHT", dropDown, "LEFT", 10, 3)
        text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        text:SetTextColor(RGB(BG.y2))
        text:SetText(L["当前难度："])
        BG.NanDuDropDown.title = text

        LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
            BG.FrameHide(0)
            local info = LibBG:UIDropDownMenu_CreateInfo()
            info.text = L["切换副本难度"]
            info.isTitle = true
            info.notCheckable = true
            LibBG:UIDropDownMenu_AddButton(info)

            if BG.IsRetail then
                AddButton(14)
                AddButton(15)
                AddButton(16)
            else
                AddButton(3)
                AddButton(5)
                AddButton(4)
                AddButton(6)
            end
        end)

        BG.RegisterEvent("GROUP_ROSTER_UPDATE", function(self, event, ...)
            LibBG:UIDropDownMenu_SetText(dropDown, tbl[GetRaidDifficultyID()].name)
        end)

        BG.Init2(function()
            LibBG:UIDropDownMenu_SetText(dropDown, tbl[GetRaidDifficultyID()].name)
        end)

        local changeRaidDifficulty = ERR_RAID_DIFFICULTY_CHANGED_S:gsub("%%s", "(.+)")
        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_SYSTEM")
        f:SetScript("OnEvent", function(self, event, msg, ...)
            if string.find(msg, changeRaidDifficulty) then
                LibBG:UIDropDownMenu_SetText(dropDown, tbl[GetRaidDifficultyID()].name)
            end
        end)
    end
    ----------副本切换按钮----------
    do
        local last
        local lastClickFB = BG.FB1

        function BG.ClickFBbutton(FB)
            if FB == BG.FB1 then return end
            BG.FrameHide(0)
            if BG.FBMainFrame:IsVisible() then
                for i, FB in ipairs(BG.FBtable) do
                    BG["Frame" .. FB]:Hide()
                end
                BG["Frame" .. FB]:Show()
            elseif BG.HopeMainFrame:IsVisible() then
                for i, FB in ipairs(BG.FBtable) do
                    BG["HopeFrame" .. FB]:Hide()
                end
                BG["HopeFrame" .. FB]:Show()
            elseif BG.DuiZhangMainFrame:IsVisible() then
                for i, FB in ipairs(BG.FBtable) do
                    BG["DuiZhangFrame" .. FB]:Hide()
                end
                BG["DuiZhangFrame" .. FB]:Show()
            elseif BG.BossMainFrame and BG.BossMainFrame:IsVisible() then
                for i, FB in ipairs(BG.FBtable) do
                    BG["BossFrame" .. FB]:Hide()
                end
                BG["BossFrame" .. FB]:Show()
            end

            for i, FB in ipairs(BG.FBtable) do
                BG["Button" .. FB]:SetEnabled(false)
            end
            C_Timer.After(0.5, function()
                for i, FB in ipairs(BG.FBtable) do
                    BG["Button" .. FB]:SetEnabled(true)
                end
                BG["Button" .. FB]:SetEnabled(false)
            end)
            BG.FB1 = FB
            BiaoGe.FB = FB
            BG.UpdateHistoryButton()
            BG.CreatHistoryListButton(FB)
            BG.FrameDongHua()

            BG.UpdateAllFilter()
            BG.UpdateHopeFrame_IsLooted_All()

            -- 装备库
            BG.itemLibNeedUpdate = true
            if BG.ItemLibMainFrame:IsShown() then
                local samePhaseFB
                for k, _FB in pairs(BG.phaseFBtable[lastClickFB]) do
                    if _FB == FB then
                        samePhaseFB = true
                        break
                    end
                end

                if samePhaseFB then
                    BG.UpdateItemLib_RightHope_All()
                    BG.UpdateItemLib_RightHope_IsHaved_All()
                    BG.UpdateItemLib_RightHope_IsLooted_All()
                else
                    BG.After(0.6, function()
                        BG.UpdateAllItemLib()
                    end)
                end
            end
            lastClickFB = BG.FB1

            if BG.lastduizhangNum then
                BG.DuiZhangSet(BG.lastduizhangNum)
            end

            if BG.HopeSenddropDown and BG.HopeSenddropDown[FB] then
                LibBG:UIDropDownMenu_SetText(BG.HopeSenddropDown[FB], BG.HopeSendTable[BiaoGe["HopeSendChannel"]])
            end

            BG.UpdateLockoutIDText()
            BG.UpdateMoLingButton()
            BG.UpdateBiaoGeAllIsHaved()
            BG.UpdateAuctionLogFrame()
            BG.UpdateItemGuoQiFrame()
            if BG.UpdateAchievementFrame then
                BG.UpdateAchievementFrame()
            end
            BG.UpdateButtonClearBiaoGeMoney()
        end

        local function Create_FBButton(FB, parent,smallWidth)
            local bt = CreateFrame("Button", nil, parent)
            bt:SetHeight(parent:GetHeight())
            bt:SetNormalFontObject(BG.FontBlue15)
            bt:SetDisabledFontObject(BG.FontWhite15)
            bt:SetHighlightFontObject(BG.FontWhite15)
            if not last then
                bt:SetPoint("LEFT")
            else
                bt:SetPoint("LEFT", last, "RIGHT", 0, 0)
            end
            bt:SetText(BG.GetFBinfo(FB, "shortName"))
            local t = bt:GetFontString()
            bt:SetWidth(t:GetStringWidth() + (smallWidth and 10 or 20))
            parent:SetWidth(parent:GetWidth() + bt:GetWidth())
            bt:SetHighlightTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
            last = bt

            bt:SetScript("OnClick", function(self)
                BG.ClickFBbutton(FB)
                BG.PlaySound(1)
            end)

            return bt
        end

        BG.TabButtonsFB = CreateFrame("Frame", nil, BG.MainFrame)
        BG.TabButtonsFB:SetPoint("TOP", BG.MainFrame, "TOP", 0, -28)
        BG.TabButtonsFB:SetHeight(20)

        if BG.IsWLK_80 then
            BG.TabButtonsFB_TBC = CreateFrame("Frame", nil, BG.TabButtonsFB)
            BG.TabButtonsFB_TBC:SetPoint("RIGHT", BG.TabButtonsFB, "LEFT", -40, -0)
            BG.TabButtonsFB_TBC:SetHeight(20)
        end

        for i, v in ipairs(BG.FBtable2) do
            local FB = v.FB
            if not (BG.IsWLK and BG.IsTBCFB(FB)) then
                BG["Button" .. v.FB] = Create_FBButton(v.FB, BG.TabButtonsFB)
            end
        end
        if BG.IsWLK_80 then
            last = nil
            for i, v in ipairs(BG.FBtable2) do
                local FB = v.FB
                if BG.IsTBCFB(FB) then
                    BG["Button" .. v.FB] = Create_FBButton(v.FB, BG.TabButtonsFB_TBC, true)
                end
            end
        end

        BG["Button" .. BG.FB1]:SetEnabled(false)

        local l = BG.TabButtonsFB:CreateLine()
        l:SetColorTexture(GetClassRGB(nil, "player", BG.borderAlpha))
        l:SetStartPoint("BOTTOMLEFT", -10, -3)
        l:SetEndPoint("BOTTOMRIGHT", 10, -3)
        l:SetThickness(1.5)

        if BG.IsWLK_80 then
            local l = BG.TabButtonsFB_TBC:CreateLine()
            l:SetColorTexture(GetClassRGB(nil, "player", BG.borderAlpha))
            l:SetStartPoint("BOTTOMLEFT", -10, -3)
            l:SetEndPoint("BOTTOMRIGHT", 10, -3)
            l:SetThickness(1.5)
        end
    end
    ----------模块切换按钮----------
    do
        BG.tabButtons = {}

        BG.FBMainFrameTabNum = 1
        BG.ItemLibMainFrameTabNum = 2
        BG.HopeMainFrameTabNum = 3
        BG.DuiZhangMainFrameTabNum = 4
        BG.YYMainFrameTabNum = 5
        BG.AchievementMainFrameTabNum = 6
        -- BG.ReportMainFrameTabNum = 7
        BG.BossMainFrameTabNum = 8

        local r, g, b = GetClassRGB(nil, "player")
        local blackup = CreateColor(.3, .3, .3, .7)
        local blackdown = CreateColor(0, 0, 0, .7)
        local classColorup = CreateColor(r, g, b, .7)
        local classColordown = CreateColor(r, g, b, .1)
        local function SetColor(bt, isOnEnter)
            if isOnEnter then
                local r, g, b = GetClassRGB(nil, "player")
                bt.bg:SetGradient("VERTICAL", CreateColor(r, g, b, 8), CreateColor(r, g, b, .2))
            else
                bt.bg:SetGradient("VERTICAL", CreateColor(0, 0, 0, 1), CreateColor(0, 0, 0, .2))
            end
        end
        function BG.ClickTabButton(num)
            for _, v in ipairs(BG.tabButtons) do
                local bt = v.button
                if v.num == num then
                    bt:Disable()
                    SetColor(bt, true)
                    bt:GetFontString():SetTextColor(1, 1, 1)
                    v.frame:Show()
                else
                    bt:Enable()
                    SetColor(bt, false)
                    bt:GetFontString():SetTextColor(1, .82, 0)
                    v.frame:Hide()
                end
            end
            if BG.UpdateAuctionLogFrame then
                BG.UpdateAuctionLogFrame()
            end
            if num == BG.BossMainFrameTabNum then
                BG.RoadBossUI()
            end
        end

        function BG.Create_TabButton(num, text, frame, width) -- 1,L["当前表格 "],BG["Frame" .. BG.FB1],150
            local bt = CreateFrame("Button", nil, BG.MainFrame, "BackdropTemplate")
            bt:SetBackdrop({
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            bt:SetBackdropBorderColor(GetClassRGB(nil, "player", BG.borderAlpha))
            bt:SetSize(width or 90, 28)
            if #BG.tabButtons == 0 then
                if BG.IsWLK_80 then
                    -- 有团本攻略 团员成就
                    bt:SetPoint("TOPLEFT", BG.MainFrame, "BOTTOM", -330, 1)
                elseif BG.IsMOP then
                    -- 团员成就
                    bt:SetPoint("TOPLEFT", BG.MainFrame, "BOTTOM", -260, 1)
                else
                    -- 什么都没
                    bt:SetPoint("TOPLEFT", BG.MainFrame, "BOTTOM", -220, 1)
                end
            else
                bt:SetPoint("LEFT", BG.tabButtons[#BG.tabButtons].button, "RIGHT", 3, 0)
            end
            bt.bg = bt:CreateTexture(nil, "BACKGROUND")
            bt.bg:SetAllPoints()
            bt.bg:SetTexture("Interface\\Buttons\\WHITE8x8")
            local t = bt:CreateFontString()
            t:SetAllPoints()
            t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            t:SetText(text)
            t:SetWordWrap(false)
            bt:SetFontString(t)
            tinsert(BG.tabButtons, {
                button = bt,
                frame = frame,
                num = num,
            })
            bt:SetScript("OnClick", function(self)
                BG.ClickTabButton(num)
                BG.PlaySound(1)
            end)
            bt:SetScript("OnEnter", function(self)
                SetColor(bt, true)
            end)
            bt:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                SetColor(bt)
                self:SetScript("OnUpdate", nil)
            end)
            return bt
        end

        local bt = BG.Create_TabButton(BG.FBMainFrameTabNum, L["表格"], BG.FBMainFrame)
        BG.OnEnterDelay(bt, function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["< 表格 >"], 1, 1, 1, true)
            GameTooltip:AddLine(L["表格的核心功能都在这里"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end, nil, true)

        local bt = BG.Create_TabButton(BG.ItemLibMainFrameTabNum, L["装备库"], BG.ItemLibMainFrame)
        BG.OnEnterDelay(bt, function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["< 装备库 >"], 1, 1, 1, true)
            GameTooltip:AddLine(L["查看所有适合你的装备"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end, nil, true)

        local bt = BG.Create_TabButton(BG.HopeMainFrameTabNum, L["心愿清单"], BG.HopeMainFrame)
        BG.OnEnterDelay(bt, function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["< 心愿清单 >"], 1, 1, 1, true)
            GameTooltip:AddLine(L["你可以设置一些装备，这些装备只要掉落就会提醒，并且自动关注团长拍卖"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end, nil, true)

        local bt = BG.Create_TabButton(BG.DuiZhangMainFrameTabNum, L["对账"], BG.DuiZhangMainFrame)
        BG.OnEnterDelay(bt, function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["< 对账 >"], 1, 1, 1, true)
            GameTooltip:AddLine(L["当团队有人通报BiaoGe/RaidLedger/大脚的账单，你可以选择该账单，来对账"], 1, 0.82, 0, true)
            GameTooltip:AddLine(L["只对比装备收入，不对比罚款收入，也不对比支出"], 1, 0.82, 0, true)
            GameTooltip:AddLine(L["别人账单会自动保存1天，过后自动删除"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end, nil, true)

        local bt = BG.Create_TabButton(BG.YYMainFrameTabNum, L["YY评价"], BG.YYMainFrame)
        BG.OnEnterDelay(bt, function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["< YY评价 >"], 1, 1, 1, true)
            GameTooltip:AddLine(L["你可以给YY频道做评价，帮助别人辨别该团好与坏"], 1, 0.82, 0, true)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(L["你可以查询YY频道的大众评价"], 1, 0.82, 0, true)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(L["聊天频道的YY号变为超链接，方便你复制该号码或查询大众评价"], 1, 0.82, 0, true)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(L["替换集结号的评价框，击杀当前版本团本尾王后弹出"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end, nil, true)

        if BG.AchievementMainFrame then
            local bt = BG.Create_TabButton(BG.AchievementMainFrameTabNum, L["团员成就"], BG.AchievementMainFrame)
            BG.OnEnterDelay(bt, function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["< 团员成就 >"], 1, 1, 1, true)
                GameTooltip:AddLine(L["查看团员的团本成就完成情况（该功能引用于比较成就里的API）"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end, nil, true)
        end
        if BG.BossMainFram then
            local bt = BG.Create_TabButton(BG.BossMainFrameTabNum, L["团本攻略"], BG.BossMainFrame)
            BG.OnEnterDelay(bt, function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["< 团本攻略 >"], 1, 1, 1, true)
                GameTooltip:AddLine(L["了解BOSS技能和应对策略、职业职责"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end, nil, true)
        end

        ----------更新已拥有----------
        do
            function BG.UpdateBiaoGeAllIsHaved()
                local FB = BG.FB1
                if BG.FBMainFrame:IsVisible() then
                    for b = 1, Maxb[FB] do
                        for i = 1, BG.GetMaxi(FB, b) do
                            local bt = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                            if bt then
                                BG.IsHave(bt)
                            end
                        end
                    end
                elseif BG.HistoryMainFrame:IsVisible() then
                    for b = 1, Maxb[FB] do
                        for i = 1, BG.GetMaxi(FB, b) do
                            local bt = BG.HistoryFrame[FB]["boss" .. b]["zhuangbei" .. i]
                            if bt then
                                BG.IsHave(bt)
                            end
                        end
                    end
                elseif BG.HopeMainFrame:IsVisible() then
                    for n = 1, HopeMaxn[FB] do
                        for b = 1, Maxb[FB] do
                            for i = 1, BG.GetMaxi(FB, b) do
                                local bt = BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                                if bt then
                                    BG.IsHave(bt)
                                end
                            end
                        end
                    end
                elseif BG.DuiZhangMainFrame:IsVisible() then
                    for b = 1, Maxb[FB] do
                        for i = 1, BG.GetMaxi(FB, b) do
                            local bt = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]
                            if bt then
                                BG.IsHave(bt)
                            end
                        end
                    end
                end
            end

            local f = CreateFrame("Frame")
            f:RegisterEvent("BAG_UPDATE_DELAYED")      -- 删除物品
            f:RegisterEvent("PLAYERBANKSLOTS_CHANGED") -- 银行物品更新
            f:SetScript("OnEvent", function(self, event, ...)
                BG.After(0.1, function()
                    BG.UpdateBiaoGeAllIsHaved()
                end)
            end)
        end
    end
    ----------定时获取当前副本----------
    do
        -- 获取当前副本
        local lastZoneID
        C_Timer.NewTicker(5, function()               -- 每5秒执行一次
            BG.FB2 = nil
            local FBID = select(8, GetInstanceInfo()) -- 获取副本ID
            for _FBID, FB in pairs(BG.FBIDtable) do   -- 把副本ID转换为副本英文简写
                if FBID == _FBID then
                    if BG.IsTBCFB(FB) and not ns.canShowTBC then
                        break
                    end
                    BG.FB2 = FB
                    break
                end
            end
            if lastZoneID ~= FBID then
                if BG.FB2 then
                    BG.ClickFBbutton(BG.FB2)
                end
            end
            lastZoneID = FBID
        end)
    end
    ----------高亮团长发出的装备----------
    do
        local blackList = {
            '{rt7}拍卖取消{rt7}',
            '{rt7}流拍{rt7}',
            '{rt1}拍卖倒数{rt1}',

            '{rt7}拍賣取消{rt7}',
            '{rt1}拍賣倒數{rt1}',

            "{rt7}Auction Cancelled{rt7}",
            "{rt7}Auction Failed{rt7}",
            "{rt1}Auction Countdown{rt1}",

            "^%d+:", -- 屏蔽部分插件的掉落通报
        }
        local notShowGuanZhuTbl = {
            '{rt6}拍卖成功{rt6}',
            '{rt6}拍賣成功{rt6}',
            "{rt6}Auction Successful{rt6}",
        }

        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:RegisterEvent("CHAT_MSG_RAID_WARNING")
        f:RegisterEvent("CHAT_MSG_RAID")
        f:SetScript("OnEvent", function(self, event, msg, playerName, ...)
            playerName = BG.GSN(playerName)
            if event == "CHAT_MSG_RAID" then
                if playerName ~= BG.masterLooter then
                    return
                end
            end
            for i, text in ipairs(blackList) do
                if msg:find(text) then
                    return
                end
            end
            -- 不提示关注拍卖
            local ShowGuanZhu = true
            for i, text in ipairs(notShowGuanZhuTbl) do
                if msg:find(text) then
                    ShowGuanZhu = false
                    break
                end
            end
            -- 收集全部物品ID
            local itemIDs = ""
            for itemID in string.gmatch(msg, "|Hitem:(%d+):") do
                itemIDs = itemIDs .. itemID .. " "
            end
            -- 开始
            local name1 = "auctionHigh"
            if BiaoGe.options[name1] ~= 1 then return end
            local name2 = "auctionHighTime"
            local yes
            local sound_yes = ""
            for _, FB in pairs(BG.FBtable) do
                for b = 1, Maxb[FB], 1 do
                    for i = 1, BG.GetMaxi(FB, b) do
                        if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                            if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText() ~= "" then
                                local itemID = GetItemID(BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText())
                                if itemID then
                                    local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(itemID)
                                    yes = string.find(itemIDs, tostring(itemID))
                                    if yes then
                                        BG.FrameDs[FB .. 3]["boss" .. b]["ds" .. i]:Show()
                                        BG.OnUpdateTime(function(self, elapsed)
                                            self.timeElapsed = self.timeElapsed + elapsed
                                            if BiaoGe.options[name1] ~= 1 or self.timeElapsed >= BiaoGe.options[name2] then
                                                BG.FrameDs[FB .. 3]["boss" .. b]["ds" .. i]:Hide()
                                                self:SetScript("OnUpdate", nil)
                                                self:Hide()
                                            end
                                        end)

                                        if not BG.IsSavingLedger and ShowGuanZhu and BiaoGe[FB]["boss" .. b]["guanzhu" .. i] then
                                            if not string.find(sound_yes, tostring(itemID)) then
                                                BG.FrameLootMsg:AddMessage(BG.STC_g1(format(L["你关注的装备开始拍卖了：%s（%s取消关注）"],
                                                    AddTexture(Texture) .. BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText(), AddTexture("RIGHT"))))
                                                BG.PlaySound("paimai")
                                                sound_yes = sound_yes .. itemID .. " "
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if BG.HopeMainFrame:IsVisible() then
                local yes
                for _, FB in pairs(BG.FBtable) do
                    for n = 1, HopeMaxn[FB] do
                        for b = 1, HopeMaxb[FB] do
                            for i = 1, HopeMaxi do
                                if BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] then
                                    local itemID = GetItemID(BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]:GetText())
                                    if itemID then
                                        local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(itemID)
                                        yes = string.find(itemIDs, tostring(itemID))
                                        if yes then
                                            BG.HopeFrameDs[FB .. 3]["nandu" .. n]["boss" .. b]["ds" .. i]:Show()
                                            BG.OnUpdateTime(function(self, elapsed)
                                                self.timeElapsed = self.timeElapsed + elapsed
                                                if BiaoGe.options[name1] ~= 1 or self.timeElapsed >= BiaoGe.options[name2] then
                                                    BG.HopeFrameDs[FB .. 3]["nandu" .. n]["boss" .. b]["ds" .. i]:Hide()
                                                    self:SetScript("OnUpdate", nil)
                                                    self:Hide()
                                                end
                                            end)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
    ----------点击聊天/背包添加装备----------
    do
        local function Insert(text)
            if not GetItemID(text) then return end
            if BG.lastfocuszhuangbei and BG.lastfocuszhuangbei:HasFocus() then
                BG.PlaySound(1)
                if BG.FrameZhuangbeiList then
                    BG.FrameZhuangbeiList:Hide()
                end
                BG.lastfocuszhuangbei:SetText(text)
                if BG.lastfocuszhuangbei2 then
                    BG.lastfocuszhuangbei2:SetFocus()
                    if BG.FrameZhuangbeiList then
                        BG.FrameZhuangbeiList:Hide()
                    end
                end
                return
            end
            if BG.auctionLogFrame_InsertLink(text) then
                return
            end
        end
        -- 聊天框
        hooksecurefunc("SetItemRef", function(link, text, button)
            local item, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
            if not link then return end
            if IsAltKeyDown() then
                if BG.IsML then -- 开始拍卖
                    BG.StartAuction(link, nil, nil, nil, button == "RightButton")
                else            -- 关注装备
                    if button ~= "RightButton" then
                        BG.AddGuanZhu(link)
                    end
                end
            elseif IsShiftKeyDown() then
                Insert(link)
            end
        end)
        -- 背包
        if BG.IsRetail then
            hooksecurefunc("ContainerFrameItemButton_OnClick", function(self, button)
                if not IsShiftKeyDown() then return end
                local link = C_Container.GetContainerItemLink(self:GetParent():GetID(), self:GetID())
                Insert(link)
            end)
        else
            hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", function(self, button)
                if not IsShiftKeyDown() then return end
                local link = C_Container.GetContainerItemLink(self:GetParent():GetID(), self:GetID())
                Insert(link)
            end)
        end
    end
    ----------离队入队染上职业颜色----------
    do
        local lastraidjoinname
        local lastpartyjoinname
        local function GetColorByName(name)
            local class = select(2, UnitClass(name))
            if class then
                return select(4, GetClassColor(class))
            end
        end
        local function MsgClassColor(self, event, msg, player, l, cs, t, flag, channelId, ...)
            if BiaoGe.options.ERR_CHAT_THROTTLED == 1 and msg == ERR_CHAT_THROTTLED then return true end
            if BiaoGe.options["joinorleavePlayercolor"] ~= 1 then return end
            if msg:match("%s$") then return end

            local raidleavename = strmatch(msg, ERR_RAID_MEMBER_REMOVED_S:gsub("%%s", "(.+)"))
            local raidjoinname = strmatch(msg, ERR_RAID_MEMBER_ADDED_S:gsub("%%s", "(.+)"))
            local partyleavename = strmatch(msg, ERR_LEFT_GROUP_S:gsub("%%s", "(.+)"))
            local partyjoinname = strmatch(msg, ERR_JOINED_GROUP_S:gsub("%%s", "(.+)"))
            -- 离开了团队
            if raidleavename then
                if BG.raidRosterInfo and type(BG.raidRosterInfo) == "table" then
                    for k, v in pairs(BG.raidRosterInfo) do
                        if raidleavename == v.name then
                            local raidleavenamelink = "|Hplayer:" .. raidleavename .. "|h[" .. raidleavename .. "]|h"
                            local c = select(4, GetClassColor(v.class))
                            local colorname = "|c" .. c .. raidleavenamelink .. "|r"
                            msg = format(ERR_RAID_MEMBER_REMOVED_S, colorname)
                            lastraidjoinname = nil
                            return false, msg, player, l, cs, t, flag, channelId, ...
                        end
                    end
                end
                -- 加入了团队
            elseif raidjoinname then
                C_Timer.After(0.5, function()
                    if not IsInRaid(1) then return end
                    if lastraidjoinname == raidjoinname then return end
                    local raidjoinnamelink = "|Hplayer:" .. raidjoinname .. "|h[" .. raidjoinname .. "]|h"
                    local color = GetColorByName(raidjoinname)
                    local colorname = color and "|c" .. color .. raidjoinnamelink .. "|r" or raidjoinnamelink
                    SendSystemMessage(format(ERR_RAID_MEMBER_ADDED_S .. " ", colorname))
                    lastraidjoinname = raidjoinname
                end)
                return true

                -- 离开了队伍
            elseif partyleavename then
                if BG.groupRosterInfo and type(BG.groupRosterInfo) == "table" then
                    for k, v in pairs(BG.groupRosterInfo) do
                        if partyleavename == v.name then
                            local partyleavenamelink = "|Hplayer:" .. partyleavename .. "|h[" .. partyleavename .. "]|h"
                            local c = select(4, GetClassColor(v.class))
                            local colorname = "|c" .. c .. partyleavenamelink .. "|r"
                            msg = format(ERR_LEFT_GROUP_S, colorname)
                            lastpartyjoinname = nil
                            return false, msg, player, l, cs, t, flag, channelId, ...
                        end
                    end
                end
                -- 加入了队伍
            elseif partyjoinname then
                C_Timer.After(0.5, function()
                    if not IsInGroup(1) then return end
                    if lastpartyjoinname == partyjoinname then return end
                    local partyjoinnamelink = "|Hplayer:" .. partyjoinname .. "|h[" .. partyjoinname .. "]|h"
                    local color = GetColorByName(partyjoinname)
                    local colorname = color and "|c" .. color .. partyjoinnamelink .. "|r" or partyjoinnamelink
                    SendSystemMessage(format(ERR_JOINED_GROUP_S .. " ", colorname))
                    lastpartyjoinname = partyjoinname
                end)
                return true
            end
        end
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", MsgClassColor)

        BG.RegisterEvent("GROUP_ROSTER_UPDATE", function()
            if not IsInRaid(1) then
                lastraidjoinname = nil
            end
            if not IsInGroup(1) then
                lastpartyjoinname = nil
            end
        end)
    end
    ----------表格/背包高亮对应装备----------
    do
        BG.LastBagItemFrame = {}

        local i = 1
        while _G["ChatFrame" .. i] do
            _G["ChatFrame" .. i]:HookScript("OnHyperlinkEnter", function(self, link, text)
                BG.Show_AllHighlight(link, "chat")
            end)
            _G["ChatFrame" .. i]:HookScript("OnHyperlinkLeave", BG.Hide_AllHighlight)
            i = i + 1
        end

        hooksecurefunc("ContainerFrameItemButton_OnEnter", function(self, button)
            local link = C_Container.GetContainerItemLink(self:GetParent():GetID(), self:GetID())
            BG.Show_AllHighlight(link, "bag")
        end)
        if BG.IsRetail then
            hooksecurefunc("GameTooltip_Hide", BG.Hide_AllHighlight)
        else
            hooksecurefunc("ContainerFrameItemButton_OnLeave", BG.Hide_AllHighlight)
        end
        BG.Init2(function()
            if IsAddOnLoaded("Bagnon") then
                BG.After(1, function()
                    local i = 1
                    while _G["BagnonContainerItem" .. i] do
                        local bag = _G["BagnonContainerItem" .. i]
                        if BG.IsRetail then
                            bag:HookScript("OnLeave", GameTooltip_Hide)
                        else
                            bag:HookScript("OnLeave", ContainerFrameItemButton_OnLeave)
                        end
                        i = i + 1
                    end
                end)
            end
        end)
    end
    ----------拍卖倒数----------
    do
        local f = CreateFrame("Frame")
        local auctioning, needStop

        local function Channel(leader, assistant, looter, optionchannel)
            if leader then
                return optionchannel
            elseif assistant and looter then
                return optionchannel
            elseif looter then
                return "RAID"
            end
        end

        function BG.StartCountDown(link)
            if BiaoGe.options["countDown"] ~= 1 then return end
            if not link then return end
            if ItemRefTooltip:IsVisible() then
                ItemRefTooltip:Hide()
            end

            local leader
            local assistant
            local looter
            local player = BG.playerName
            if BG.raidRosterInfo and type(BG.raidRosterInfo) == "table" then
                for index, v in ipairs(BG.raidRosterInfo) do
                    if v.rank == 2 and v.name == player then
                        leader = true
                    elseif v.rank == 1 and v.name == player then
                        assistant = true
                    end
                    if v.isML and v.name == player then
                        looter = true
                    end
                end
            end
            if not leader and not looter then return end

            local channel = Channel(leader, assistant, looter, BiaoGe.options["countDownSendChannel"])
            if auctioning then
                local text = L["{rt7}倒数暂停{rt7}"]
                SendChatMessage(text, channel)
                auctioning = nil
                f:SetScript("OnUpdate", nil)
                return
            end

            local Maxtime = BiaoGe.options["countDownDuration"]
            local text = link .. L[" {rt1}拍卖倒数{rt1}"]
            SendChatMessage(text, channel)
            auctioning = true

            local timeElapsed = 0
            local lasttime = Maxtime + 1
            f:SetScript("OnUpdate", function(self, elapsed)
                if needStop then
                    needStop = nil
                    BG.PlaySound("countDownStop")
                    local text = L["{rt7}倒数暂停{rt7}"]
                    SendChatMessage(text, channel)
                    auctioning = nil
                    f:SetScript("OnUpdate", nil)
                    return
                end
                timeElapsed = timeElapsed + elapsed
                if timeElapsed >= 1 then
                    lasttime = lasttime - format("%d", timeElapsed)
                    if lasttime <= 0 then
                        auctioning = nil
                        f:SetScript("OnUpdate", nil)
                        return
                    end
                    local text = "> " .. lasttime .. " <"
                    SendChatMessage(text, channel)
                    timeElapsed = 0
                end
            end)
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_RAID_WARNING")
        f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:RegisterEvent("CHAT_MSG_RAID")
        f:SetScript("OnEvent", function(self, event, msg)
            if not (BiaoGe.options["countDown"] == 1 and BiaoGe.options["countDownStop"] == 1) then return end
            if not auctioning then return end
            msg = msg:gsub("%s", "")
            if msg:match("^%d-%.-%d+$") or msg:match("^%d-%.-%d+[pP]$") or msg:match("^=+$") then
                needStop = true
            end
        end)

        hooksecurefunc("SetItemRef", function(link, text, button)
            if not BG.IsML then return end -- 如果是普通团员则退出
            local _type, name, line, chattype = strsplit(":", link)
            if _type == "item" and button == "RightButton" and not IsAltKeyDown() then
                local item, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
                BG.StartCountDown(link)
            end
        end)
    end
    ----------撤销删除----------
    do
        local bt = BG.CreateButton(BG.FBMainFrame)
        bt:SetSize(80, 25)
        bt:SetPoint("TOPRIGHT", BG.MainFrame, "TOPRIGHT", -42, -27)
        -- bt:SetPoint("RIGHT", BG.ButtonZhangDan, "LEFT", -80, 0)
        bt:SetText(L["撤销删除"])
        bt:Hide()
        BG.ButtonCancelDelete = bt
        bt:SetScript("OnEnter", function(self)
            if not self.HighlightFrame then
                local f = CreateFrame("Frame", nil, self, "BackdropTemplate")
                f:SetBackdrop({
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 3,
                })
                f:SetBackdropBorderColor(0, 1, 0)
                self.HighlightFrame = f
                local flashGroup = f:CreateAnimationGroup()
                for i = 1, 3 do
                    local fade = flashGroup:CreateAnimation('Alpha')
                    fade:SetChildKey('flash')
                    fade:SetOrder(i * 2)
                    fade:SetDuration(.4)
                    fade:SetFromAlpha(.1)
                    fade:SetToAlpha(1)

                    local fade = flashGroup:CreateAnimation('Alpha')
                    fade:SetChildKey('flash')
                    fade:SetOrder(i * 2 + 1)
                    fade:SetDuration(.4)
                    fade:SetFromAlpha(1)
                    fade:SetToAlpha(.1)
                end
                flashGroup:Play()
                flashGroup:SetLooping("REPEAT")
            end
            self.HighlightFrame:Show()
            self.HighlightFrame:ClearAllPoints()
            self.HighlightFrame:SetPoint("TOPLEFT", BG.cancelDelete.bt, "TOPLEFT", -4, 0)
            self.HighlightFrame:SetPoint("BOTTOMRIGHT", BG.cancelDelete.bt, "BOTTOMRIGHT", -2, 0)
            self.HighlightFrame:SetFrameLevel(BG.cancelDelete.bt:GetFrameLevel() + 1)

            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["撤销删除当前绿色高亮格子的内容。"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", function(self)
            self.HighlightFrame:Hide()
            GameTooltip:Hide()
        end)

        bt:SetScript("OnClick", function(self)
            BG.PlaySound(1)
            local FB = BG.cancelDelete.FB
            local b = BG.cancelDelete.b
            local i = BG.cancelDelete.i
            BG.cancelDelete.bt:SetText(BG.cancelDelete.text)
            if BG.cancelDelete.type == "zhuangbei" then
                BiaoGe[FB]["boss" .. b]["loot" .. i] = BG.cancelDelete.loot
                BiaoGe[FB]["boss" .. b]["guanzhu" .. i] = BG.cancelDelete.guanzhu
                BG.Frame[FB]["boss" .. b]["guanzhu" .. i]:SetShown(BiaoGe[FB]["boss" .. b]["guanzhu" .. i])
            elseif BG.cancelDelete.type == "maijia" then
                for k, v in pairs(BG.playerClass) do
                    BiaoGe[FB]["boss" .. b][k .. i] = BG.cancelDelete[k]
                end
                if BG.cancelDelete.color then
                    BG.cancelDelete.bt:SetTextColor(unpack(BG.cancelDelete.color))
                end
            elseif BG.cancelDelete.type == "jine" then
            end
            BG.ButtonCancelDelete.OnUpdate:SetScript("OnUpdate", nil)
            self:Hide()
        end)
        BG.CreateHighLightAnim(bt)
    end
    ----------鼠标材质----------
    BG.RegisterEvent("MODIFIER_STATE_CHANGED", function(self, event, mod, type)
        if IsAltKeyDown() and IsControlKeyDown() then
            SetCursor(nil)
            return
        end
        if mod == "LCTRL" or mod == "RCTRL" then
            if type == 1 then
                if BG.canShowInspectCursor then
                    SetCursor("Interface/Cursor/Inspect")
                elseif BG.canShowTrunToItemLibCursor then
                    SetCursor("Interface/Cursor/Inspect")
                end
            else
                SetCursor(nil)
            end
        elseif mod == "LALT" or mod == "RALT" then
            if type == 1 then
                if BG.canShowStartAuctionCursor and BiaoGe.options["autoAuctionStart"] == 1 then
                    SetCursor("interface/cursor/repair")
                elseif BG.canShowHopeCursor then
                    SetCursor("Interface/Cursor/quest")
                end
            else
                SetCursor(nil)
            end
        end
    end)
    -- 鼠标提示工具美化
    BG.Init2(function()
        local color
        if IsAddOnLoaded("NDui") then
            color = { 0, 0, 0, 0.6 }
        elseif IsAddOnLoaded("ElvUI") then
            color = { .05, .05, .05, 0.6 }
        end
        if IsAddOnLoaded("NDui") or IsAddOnLoaded("ElvUI") then
            if BiaoGeTooltip2.NineSlice then BiaoGeTooltip2.NineSlice:SetAlpha(0) end
            if BiaoGeTooltip2.SetBackdrop then BiaoGeTooltip2:SetBackdrop(nil) end

            local f = CreateFrame("Frame", nil, BiaoGeTooltip2, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            f:SetBackdropColor(unpack(color))
            f:SetBackdropBorderColor(0, 0, 0, 1)
            f:SetAllPoints()
            f:SetFrameLevel(f:GetParent():GetFrameLevel())
        end
    end)
    -- 屏蔽你太快了
    do
        local oldFuc = UIErrorsFrame.AddMessage

        local blockedErrorTexts = {
            ERR_GENERIC_THROTTLE, -- "你太快了"
        }

        -- 自定义的过滤方法
        function UIErrorsFrame:AddMessage(text, ...)
            if not text then
                return oldFuc(self, text, ...)
            end

            for _, blockedText in ipairs(blockedErrorTexts) do
                if text == blockedText then
                    return
                end
            end

            return oldFuc(self, text, ...)
        end
    end
    ----------初始显示----------
    do
        if BiaoGe.lastFrame and BG[BiaoGe.lastFrame .. "MainFrameTabNum"] and BG[BiaoGe.lastFrame .. "MainFrame"] then
            BG.ClickTabButton(BG[BiaoGe.lastFrame .. "MainFrameTabNum"])
        else
            BG.ClickTabButton(BG.FBMainFrameTabNum)
        end
    end
    ----------检查版本过期----------
    do
        -- 把版本号转换为纯数字
        function BG.GetVerNum(ver)
            ver = ver:gsub("%s-[Bb]eta%d+", ""):gsub("%s-[Aa]lpha%d+", "")
            local lastString = tonumber(strsub(ver, strlen(ver), strlen(ver)))
            if lastString then
                ver = ver .. "0"
            end
            ver = ver:gsub("a", 1)
            ver = ver:gsub("b", 2)
            ver = ver:gsub("c", 3)
            ver = ver:gsub("d", 4)
            ver = ver:gsub("e", 5)
            ver = ver:gsub("f", 6)
            ver = ver:gsub("g", 7)
            ver = ver:gsub("h", 8)
            ver = ver:gsub("i", 9)
            local start, middle, last = strsplit(".", ver)
            if middle:len() == 1 then
                middle = "0" .. middle
            end
            ver = start .. middle .. last
            ver = ver:gsub("%D", "")
            if ver:len() >= 6 then
                return 0
            else
                ver = tonumber(ver)
                return ver
            end
        end

        -- 比较版本
        local function VerGuoQi(BGVer, ver)
            if ver:find("[Bb]eta") or ver:find("[Aa]lpha") then return false end
            if BG.GetVerNum(ver) > BG.GetVerNum(BGVer) then
                return true
            end
        end
        -- 自己是否为测试版本
        local function IsTestVer()
            if BG.ver:find("[Bb]eta") or BG.ver:find("[Aa]lpha") then
                return true
            end
        end

        local close
        local CDing = {}
        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_ADDON")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:SetScript("OnEvent", function(self, event, ...)
            if event == "CHAT_MSG_ADDON" then
                local prefix, msg, channel, sender = ...
                sender = BG.GSN(sender)
                if not (prefix == "BiaoGe" and channel == "GUILD") then return end
                if msg == "VersionCheck" and not CDing[sender] and not IsTestVer() then
                    C_ChatInfo.SendAddonMessage("BiaoGe", "MyVer-" .. BG.ver, channel)
                    CDing[sender] = true
                    BG.After(10, function()
                        CDing[sender] = nil
                    end)
                elseif strfind(msg, "MyVer") and not close then
                    if BiaoGe.options.addonsOutTime == 1 then
                        local _, version = strsplit("-", msg)
                        if VerGuoQi(BG.ver, version) then
                            BG.VerText:SetTextColor(1, 0, 0)
                            close = true
                        end
                    end
                end
            elseif event == "PLAYER_ENTERING_WORLD" then
                local isLogin, isReload = ...
                if not (isLogin or isReload) then return end
                -- 开始发送版本请求
                C_Timer.After(5, function()
                    if IsInGuild() then
                        C_ChatInfo.SendAddonMessage("BiaoGe", "VersionCheck", "GUILD")
                    end
                end)

                -- x秒后关闭检测版本是否过期的功能
                C_Timer.After(10, function()
                    close = true
                end)
            end
        end)

        BG.After(10, function()
            if not IsTestVer() and BG.GetVerNum(BG.ver) < 11500 then
                BG.SendSystemMessage(L["你的BiaoGe插件存在问题，请删除本地插件再重新安装一次（需要大退）。"])
            end
        end)
    end
    -- abc:Hide()
    BG.MainFrame.ErrorText:Hide()
end)

----------刷新团队成员信息----------
do
    BG.raidRosterInfo = {}
    BG.groupRosterInfo = {}
    BG.raidRosterGUID = {}
    BG.raidRosterName = {}
    BG.raidRosterIsOnline = {}

    function BG.UpdateRaidRosterInfo()
        wipe(BG.raidRosterInfo)
        wipe(BG.groupRosterInfo)
        wipe(BG.raidRosterGUID)
        wipe(BG.raidRosterName)
        wipe(BG.raidRosterIsOnline)

        BG.raidLeader = nil
        BG.masterLooter = nil
        BG.IsML = nil
        BG.IsLeader = nil

        if IsInRaid(1) then
            for i = 1, GetNumGroupMembers() do
                local name, rank, subgroup, level, class2, class, zone, online, isDead, role, isML, combatRole =
                    GetRaidRosterInfo(i)
                if name then
                    local a = {
                        name = name,
                        rank = rank,
                        subgroup = subgroup,
                        level = level,
                        class2 = class2,
                        class = class,
                        zone = zone,
                        online = online,
                        isDead = isDead,
                        role = role,
                        isML = isML,
                        combatRole = combatRole,
                        unitIndex = i,
                    }
                    for k, v in pairs(BG.playerClass) do
                        a[k] = select(v.select, v.func("raid" .. i))
                    end
                    table.insert(BG.raidRosterInfo, a)
                    if rank == 2 then
                        BG.raidLeader = name
                    end
                    if isML then
                        BG.masterLooter = name
                    end
                    if name == BG.GN() and (rank == 2 or isML) then
                        BG.IsML = true
                    end
                    if name == BG.GN() and (rank == 2) then
                        BG.IsLeader = true
                    end
                    local guid = UnitGUID("raid" .. i)
                    if guid then
                        BG.raidRosterGUID[guid] = name
                    end
                    BG.raidRosterName[name] = true
                    BG.raidRosterIsOnline[name] = online
                end
            end
        elseif IsInGroup(1) then
            for i = 1, GetNumGroupMembers() do
                local name = BG.GN("party" .. i)
                local _, class = UnitClass("party" .. i)
                local a = { name = name, class = class }
                table.insert(BG.groupRosterInfo, a)
            end
        end
    end

    function BG.ImML()
        if IsMasterLooter() or BG.IsLeader then
            return true
        end
    end

    function BG.IsMLByName(name)
        local loot = GetLootMethod()
        if loot == "master" or loot == 2 then
            if BG.masterLooter and BG.masterLooter == name then
                return true
            end
        else
            if BG.raidLeader == name then
                return true
            end
        end
    end

    BG.Init2(function()
        C_Timer.After(1, function()
            BG.UpdateRaidRosterInfo()
        end)
    end)
    BG.RegisterEvent("GROUP_ROSTER_UPDATE", function()
        C_Timer.After(0.5, function()
            BG.UpdateRaidRosterInfo()
        end)
    end)
    BG.RegisterEvent("UNIT_CONNECTION", function()
        C_Timer.After(0.5, function()
            BG.UpdateRaidRosterInfo()
        end)
    end)
end

-- 插件命令
BG.Init2(function()
    SlashCmdList["BIAOGE"] = function()
        BG.MainFrame:SetShown(not BG.MainFrame:IsVisible())
    end
    SLASH_BIAOGE1 = "/biaoge"
    SLASH_BIAOGE2 = "/gbg"

    -- 解锁位置
    SlashCmdList["BIAOGEMOVE"] = function()
        BG.Move()
    end
    SLASH_BIAOGEMOVE1 = "/bgm"

    -- 设置
    SlashCmdList["BIAOGEOPTIONS"] = function()
        ns.InterfaceOptionsFrame_OpenToCategory(BG.optionsName)
        BG.MainFrame:Hide()
    end
    SLASH_BIAOGEOPTIONS1 = "/bgo"

    -- 角色总览
    SlashCmdList["BiaoGeRoleOverview"] = function()
        BG.SetFBCD(nil, nil, true)
    end
    SLASH_BiaoGeRoleOverview1 = "/bgr"
end)
