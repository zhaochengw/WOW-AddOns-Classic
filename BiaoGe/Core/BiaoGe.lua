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
local FrameDongHua = ns.FrameDongHua
local FrameHide = ns.FrameHide
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID
local Round = ns.Round

local Width = ns.Width
local Height = ns.Height
local Maxb = ns.Maxb
local Maxi = ns.Maxi
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print
local realmID = GetRealmID()
local player = UnitName("player")

BG.RegisterEvent("ADDON_LOADED", function(self, event, addonName)
    if addonName ~= AddonName then return end
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
        BG.MainFrame.CloseButton:SetPoint("TOPRIGHT", 5, 5)

        BG.MainFrame:SetScript("OnMouseUp", function(self)
            self:StopMovingOrSizing()
        end)
        BG.MainFrame:SetScript("OnMouseDown", function(self)
            FrameHide(0)
            LibBG:CloseDropDownMenus()
            BG.ClearFocus()
            self:StartMoving()
        end)
        BG.MainFrame:SetScript("OnHide", function(self)
            FrameHide(0)
            BG.copy1 = nil
            BG.copy2 = nil
            BG.FilterClassItemMainFrame:Hide()
            if BG.copyButton then
                BG.copyButton:Hide()
            end
            if BG.FrameNewBee then
                BG.FrameNewBee:Hide()
            end
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
            -- 更新右下底部的角色总览条
            BG.MoneyBannerUpdate()

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
        end)

        local f = CreateFrame("Frame", nil, BG.MainFrame)
        f:SetPoint("TOP", BG.MainFrame, "TOP", 0, -1)
        f:SetSize(200, 20)
        f:SetFrameLevel(105)
        local TitleText = f:CreateFontString()
        TitleText:SetAllPoints()
        TitleText:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        TitleText:SetText("|cff" .. "00BFFF" .. L["< BiaoGe > 金 团 表 格"])
        BG.Title = TitleText

        -- 说明书
        local f = CreateFrame("Frame", nil, BG.MainFrame)
        f:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 5, -1)
        f:SetHitRectInsets(0, 0, 0, 0)
        local t = f:CreateFontString()
        t:SetPoint("CENTER")
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetJustifyH("LEFT")
        t:SetText(L["<说明书>"] .. " " .. BG.STC_w1(BG.ver))
        t:SetTextColor(0, 1, 0)
        f:SetSize(t:GetStringWidth(), 20)
        BG.ShuoMingShu = f
        BG.ShuoMingShuText = t

        local function OnEnter(self)
            self.OnEnter = true
            GameTooltip:SetOwner(self, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
            GameTooltip:ClearLines()
            if IsAltKeyDown() then
                for i, text in ipairs(BG.instructionsText) do
                    GameTooltip:AddLine(text)
                end
            else
                for i, text in ipairs(BG.instructionsText) do
                    GameTooltip:AddLine(text)
                end
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
        BG.RegisterEvent("MODIFIER_STATE_CHANGED", function(self, event, enter)
            if (enter == "LALT" or enter == "RALT") and f.OnEnter then
                OnEnter(f)
            end
        end)

        -- 副本选择初始化
        -- FB1 是UI当前选择的副本
        -- FB2 是玩家当前所处的副本
        if BiaoGe.FB then
            local right
            for k, FB in pairs(BG.FBtable) do
                if BiaoGe.FB == FB then
                    BG.FB1 = BiaoGe.FB
                    right = true
                    break
                end
            end
            if not right then
                BiaoGe.FB = BG.FB1
            end
        else
            BiaoGe.FB = BG.FB1
        end
        BG.MainFrame:SetHeight(Height[BG.FB1])
        BG.MainFrame:SetWidth(Width[BG.FB1])

        -- 报错
        BG.MainFrame.ErrorText = BG.MainFrame:CreateFontString()
        BG.MainFrame.ErrorText:SetFont(STANDARD_TEXT_FONT, 70, "OUTLINE")
        BG.MainFrame.ErrorText:SetPoint("CENTER")
        BG.MainFrame.ErrorText:SetWidth(BG.MainFrame:GetWidth() - 50)
        BG.MainFrame.ErrorText:SetTextColor(1, 0, 0)
        BG.MainFrame.ErrorText:SetText(L["插件加载出现错误，请把报错发给作者，谢谢。（邮箱buick_hbj@163.com，Q群322785325）"])
    end
    tinsert(UISpecialFrames, "BG.MainFrame")
    ----------接收表格主界面----------
    do
        BG.ReceiveMainFrame = CreateFrame("Frame", "BG.ReceiveFrame", UIParent, "BackdropTemplate")
        BG.ReceiveMainFrame:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 2
        })
        BG.ReceiveMainFrame:SetBackdropColor(0, 0, 0, 0.9)
        BG.ReceiveMainFrame:SetPoint("CENTER")
        BG.ReceiveMainFrame:SetFrameLevel(100)
        BG.ReceiveMainFrame:SetMovable(true)
        BG.ReceiveMainFrame:SetToplevel(true)
        BG.ReceiveMainFrame:SetScript("OnMouseUp", function(self)
            self:StopMovingOrSizing()
        end)
        BG.ReceiveMainFrame:SetScript("OnMouseDown", function(self)
            FrameHide(0)
            self:StartMoving()
        end)
        tinsert(UISpecialFrames, "BG.ReceiveFrame") -- 按ESC可关闭插件

        local _, class = UnitClass("player")
        local r, g, b, cff = GetClassColor(class)
        BG.ReceiveMainFrame:SetBackdropBorderColor(r, g, b)

        BG.ReceiveMainFrame.CloseButton = CreateFrame("Button", nil, BG.ReceiveMainFrame, "UIPanelCloseButton")
        BG.ReceiveMainFrame.CloseButton:SetPoint("TOPRIGHT", BG.ReceiveMainFrame, "TOPRIGHT", 0, 0)
        BG.ReceiveMainFrame.CloseButton:SetSize(40, 40)

        local TitleText = BG.ReceiveMainFrame:CreateFontString()
        TitleText:SetPoint("TOP", BG.ReceiveMainFrame, "TOP", 0, -10)
        TitleText:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
        BG.ReceiveMainFrameTitle = TitleText

        local l = BG.ReceiveMainFrame:CreateLine()
        l:SetColorTexture(r, g, b)
        l:SetStartPoint("BOTTOMLEFT", TitleText, -20, -2)
        l:SetEndPoint("BOTTOMRIGHT", TitleText, 20, -2)
        l:SetThickness(1.5)

        local bt = CreateFrame("Button", nil, BG.ReceiveMainFrame, "BackdropTemplate")
        bt:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        bt:SetBackdropColor(0, 0, 0, 0.5)
        bt:SetBackdropBorderColor(r, g, b)
        bt:SetSize(120, 30)
        bt:SetPoint("BOTTOM", BG.ReceiveMainFrame, "BOTTOM", 0, 30)
        bt:SetNormalFontObject(BG.FontWhite15)
        bt:SetText(L["保存至历史表格"])
        local t = bt:GetFontString()
        t:SetTextColor(r, g, b)
        bt:SetScript("OnEnter", function(self)
            t:SetTextColor(RGB("FFFFFF"))
            bt:SetBackdropBorderColor(1, 1, 1, 1)
        end)
        bt:SetScript("OnLeave", function(self)
            t:SetTextColor(r, g, b)
            bt:SetBackdropBorderColor(r, g, b)
        end)
        bt:SetScript("OnClick", function(self)
            local FB = BG.ReceiveBiaoGe.FB
            local DT = BG.ReceiveBiaoGe.DT
            local BiaoTi = BG.ReceiveBiaoGe.BiaoTi
            for key, value in pairs(BiaoGe.History[FB]) do
                if tonumber(DT) == key then
                    BG.ReceiveMainFrametext:SetText(BG.STC_r1(L["该表格已在你历史表格里"]) .. AddTexture("interface/raidframe/readycheck-notready"))
                    return
                end
            end

            BiaoGe.History[FB][DT] = {}
            for b = 1, Maxb[FB] + 2 do
                BiaoGe.History[FB][DT]["boss" .. b] = {}
                for i = 1, Maxi[FB] do
                    if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                        BiaoGe.History[FB][DT]["boss" .. b]["zhuangbei" .. i] = BG.ReceiveBiaoGe["boss" .. b]
                            ["zhuangbei" .. i]
                        BiaoGe.History[FB][DT]["boss" .. b]["maijia" .. i] = BG.ReceiveBiaoGe["boss" .. b]["maijia" .. i]
                        BiaoGe.History[FB][DT]["boss" .. b]["color" .. i] = { BG.ReceiveBiaoGe["boss" .. b]["color" .. i]
                            [1], BG.ReceiveBiaoGe["boss" .. b]["color" .. i][2],
                            BG.ReceiveBiaoGe["boss" .. b]["color" .. i][3] }
                        BiaoGe.History[FB][DT]["boss" .. b]["jine" .. i] = BG.ReceiveBiaoGe["boss" .. b]["jine" .. i]
                    end
                end
                if BG.Frame[FB]["boss" .. b]["time"] then
                    BiaoGe.History[FB][DT]["boss" .. b]["time"] = BG.ReceiveBiaoGe["boss" .. b]["time"]
                end
            end
            local d = { DT, BiaoTi }
            table.insert(BiaoGe.HistoryList[FB], 1, d)
            BG.UpdateHistoryButton()
            BG.CreatHistoryListButton(FB)
            BG.ReceiveMainFrametext:SetText(L["已保存至历史表格1"] .. AddTexture("interface/raidframe/readycheck-ready"))

            BG.PlaySound(2)
        end)

        local text = BG.ReceiveMainFrame:CreateFontString()
        text:SetPoint("LEFT", bt, "RIGHT", 10, 0)
        text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        text:SetTextColor(0, 1, 0)
        BG.ReceiveMainFrametext = text

        -- 二级
        for i, FB in ipairs(BG.FBtable) do
            BG["ReceiveFrame" .. FB] = CreateFrame("Frame", "BG.ReceiveFrame" .. FB, BG.ReceiveMainFrame)
            BG["ReceiveFrame" .. FB]:Hide()
        end
    end
    ----------二级Frame----------
    do
        -- 当前表格
        BG.FBMainFrame = CreateFrame("Frame", "BG.FBMainFrame", BG.MainFrame)
        do
            BG.FBMainFrame:Hide()
            for i, FB in ipairs(BG.FBtable) do
                BG["Frame" .. FB] = CreateFrame("Frame", "BG.Frame" .. FB, BG.FBMainFrame)
                BG["Frame" .. FB]:Hide()
            end
            BG.FBMainFrame:SetScript("OnShow", function(self)
                local FB = BG.FB1
                FrameHide(0)
                for i, FB in ipairs(BG.FBtable) do
                    BG["Frame" .. FB]:Hide()
                end
                BG["Frame" .. FB]:Show()
                BiaoGe.lastFrame = "FB"

                BG.HistoryMainFrame:Hide()
                BG.History.List:Hide()
                BG.History.List:SetParent(self)
                BG.History.List:SetFrameLevel(BG.History.List.frameLevel)
                BG.Title:SetParent(self)

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
                if not BG.IsVanilla then
                    BG.NanDuDropDown.DropDown:Show()
                    LibBG:UIDropDownMenu_EnableDropDown(BG.NanDuDropDown.DropDown)
                end

                BG.UpdateBiaoGeAllIsHaved()

                BG.FilterClassItemMainFrame.Buttons2:SetParent(self)
                BG.FilterClassItemMainFrame:Hide()
                BG.FilterClassItemMainFrame.Buttons2:ClearAllPoints()
                BG.FilterClassItemMainFrame.Buttons2:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 410, 35)
            end)
        end
        -- 心愿清单
        BG.HopeMainFrame = CreateFrame("Frame", "BG.HopeMainFrame", BG.MainFrame)
        do
            BG.HopeMainFrame:Hide()
            for i, FB in ipairs(BG.FBtable) do
                BG["HopeFrame" .. FB] = CreateFrame("Frame", "BG.HopeFrame" .. FB, BG.HopeMainFrame)
                BG["HopeFrame" .. FB]:Hide()
            end
            BG.BackBiaoGe(BG.HopeMainFrame)
            BG.HopeMainFrame:SetScript("OnShow", function(self)
                local FB = BG.FB1
                FrameHide(0)
                for i, FB in ipairs(BG.FBtable) do
                    BG["HopeFrame" .. FB]:Hide()
                end
                BG["HopeFrame" .. FB]:Show()
                -- BG.HopePlanMainFrame:Hide()
                BiaoGe.lastFrame = "Hope"

                BG.HistoryMainFrame:Hide()
                BG.Title:SetParent(self)

                BG.TabButtonsFB:Show()
                for i, FB in ipairs(BG.FBtable) do
                    BG["Button" .. FB]:SetEnabled(true)
                end
                BG["Button" .. BG.FB1]:SetEnabled(false)

                if not BG.IsVanilla then
                    BG.NanDuDropDown.DropDown:Show()
                    LibBG:UIDropDownMenu_EnableDropDown(BG.NanDuDropDown.DropDown)
                end

                BG.UpdateBiaoGeAllIsHaved()

                BG.FilterClassItemMainFrame.Buttons2:SetParent(self)
                BG.FilterClassItemMainFrame:Hide()
                BG.FilterClassItemMainFrame.Buttons2:ClearAllPoints()
                BG.FilterClassItemMainFrame.Buttons2:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 410, 35)

                BG.ButtonImportHope:SetParent(self)
                BG.ButtonExportHope:SetParent(self)
            end)
            -- 左下角文字介绍
            do
                local t = BG.HopeMainFrame:CreateFontString()
                t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 75)
                t:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
                t:SetTextColor(RGB(BG.g1))
                t:SetText(L["心愿清单："])
                local tt = t
                local t = BG.HopeMainFrame:CreateFontString()
                t:SetPoint("LEFT", tt, "RIGHT", 0, 0)
                t:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
                t:SetTextColor(RGB(BG.g2))
                t:SetText(L["你可以设置一些装备，这些装备只要掉落就会提醒，并且自动关注团长拍卖"])
            end
        end
        -- 装备库
        BG.ItemLibMainFrame = CreateFrame("Frame", "BG.ItemLibMainFrame", BG.MainFrame)
        do
            BG.ItemLibMainFrame:Hide()
            BG.BackBiaoGe(BG.ItemLibMainFrame)
            BG.ItemLibMainFrame:SetScript("OnShow", function(self)
                local FB = BG.FB1
                FrameHide(0)
                BiaoGe.lastFrame = "ItemLib"

                BG.HistoryMainFrame:Hide()
                BG.Title:SetParent(self)

                BG.TabButtonsFB:Show()
                for i, FB in ipairs(BG.FBtable) do
                    BG["Button" .. FB]:SetEnabled(true)
                end
                BG["Button" .. BG.FB1]:SetEnabled(false)

                if not BG.IsVanilla then
                    BG.NanDuDropDown.DropDown:Hide()
                end

                BG.FilterClassItemMainFrame.Buttons2:SetParent(self)
                BG.FilterClassItemMainFrame:Hide()
                BG.FilterClassItemMainFrame.Buttons2:ClearAllPoints()
                BG.FilterClassItemMainFrame.Buttons2:SetPoint("TOP", BG.ItemLibMainFrame[1]["invtypeFrame"], "BOTTOM", 0, -10)

                BG.ButtonImportHope:SetParent(self)
                BG.ButtonExportHope:SetParent(self)
            end)

            -- 左下角文字介绍
            do
                local t = BG.ItemLibMainFrame:CreateFontString()
                t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 45)
                t:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
                t:SetTextColor(RGB(BG.g1))
                t:SetText(L["装备库："])
                local tt = t
                local t = BG.ItemLibMainFrame:CreateFontString()
                t:SetPoint("LEFT", tt, "RIGHT", 0, 0)
                t:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
                t:SetTextColor(RGB(BG.g2))
                t:SetText(L["查看所有适合你的装备"])
                local tt = t
                local t = BG.ItemLibMainFrame:CreateFontString()
                t:SetPoint("LEFT", tt, "RIGHT", 0, 0)
                t:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                -- t:SetTextColor(RGB(BG.dis))
                t:SetText(L["（SHIFT+左键发送装备，ALT+左键设为心愿装备，CTRL+左键打开试衣间。部位按钮支持使用滚轮切换）"])
            end
        end
        -- 对账
        BG.DuiZhangMainFrame = CreateFrame("Frame", "BG.DuiZhangMainFrame", BG.MainFrame)
        do
            BG.DuiZhangMainFrame:Hide()
            for i, FB in ipairs(BG.FBtable) do
                BG["DuiZhangFrame" .. FB] = CreateFrame("Frame", "BG.DuiZhangFrame" .. FB, BG.DuiZhangMainFrame)
                BG["DuiZhangFrame" .. FB]:Hide()
            end
            BG.BackBiaoGe(BG.DuiZhangMainFrame)
            BG.DuiZhangMainFrame:SetScript("OnShow", function(self)
                local FB = BG.FB1
                FrameHide(0)
                for i, FB in ipairs(BG.FBtable) do
                    BG["DuiZhangFrame" .. FB]:Hide()
                end
                BG["DuiZhangFrame" .. FB]:Show()
                if BG.lastduizhangNum then
                    BG.DuiZhangSet(BG.lastduizhangNum)
                end
                BiaoGe.lastFrame = "DuiZhang"

                BG.HistoryMainFrame:Hide()
                BG.Title:SetParent(self)

                BG.TabButtonsFB:Show()
                for i, FB in ipairs(BG.FBtable) do
                    BG["Button" .. FB]:SetEnabled(true)
                end
                BG["Button" .. BG.FB1]:SetEnabled(false)

                if not BG.IsVanilla then
                    BG.NanDuDropDown.DropDown:Hide()
                end

                BG.UpdateBiaoGeAllIsHaved()
            end)
            -- 左下角文字介绍
            do
                local t = BG.DuiZhangMainFrame:CreateFontString()
                t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 45)
                t:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
                t:SetTextColor(RGB(BG.g1))
                t:SetText(L["对账"])
            end
        end
        -- YY评价
        BG.YYMainFrame = CreateFrame("Frame", "BG.YYMainFrame", BG.MainFrame)
        do
            BG.YYMainFrame:Hide()
            BG.BackBiaoGe(BG.YYMainFrame)
            BG.YYMainFrame:SetScript("OnShow", function(self)
                local FB = BG.FB1
                FrameHide(0)
                BiaoGe.lastFrame = "YY"

                BG.HistoryMainFrame:Hide()
                BG.Title:SetParent(self)

                BG.TabButtonsFB:Hide()

                if not BG.IsVanilla then
                    BG.NanDuDropDown.DropDown:Hide()
                end
            end)
            -- 左下角文字介绍
            do
                local t = BG.YYMainFrame:CreateFontString()
                t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 45)
                t:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
                t:SetTextColor(RGB(BG.g1))
                t:SetText(L["YY评价"])
            end
        end

        if BG.IsWLK then
            -- 团员成就
            local name = "AchievementMainFrame"
            BG[name] = CreateFrame("Frame", "BG." .. name, BG.MainFrame)
            do
                BG[name]:Hide()
                BG.BackBiaoGe(BG[name])
                BG[name]:SetScript("OnShow", function(self)
                    local FB = BG.FB1
                    FrameHide(0)
                    BiaoGe.lastFrame = "Achievement"

                    BG.HistoryMainFrame:Hide()
                    BG.Title:SetParent(self)

                    BG.TabButtonsFB:Show()

                    if not BG.IsVanilla then
                        BG.NanDuDropDown.DropDown:Hide()
                    end
                end)

                -- 左下角文字介绍
                do
                    local t = BG[name]:CreateFontString()
                    t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 45)
                    t:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
                    t:SetTextColor(RGB(BG.g1))
                    t:SetText(L["团员成就："])
                    local tt = t
                    local t = BG[name]:CreateFontString()
                    t:SetPoint("LEFT", tt, "RIGHT", 0, 0)
                    t:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
                    t:SetTextColor(RGB(BG.g2))
                    t:SetText(L["查看团员的团本成就完成情况（该功能引用于比较成就里的API）"])
                end
            end

            -- 举报记录
            local name = "ReportMainFrame"
            BG[name] = CreateFrame("Frame", "BG." .. name, BG.MainFrame)
            do
                BG[name]:Hide()
                BG.BackBiaoGe(BG[name])
                BG[name]:SetScript("OnShow", function(self)
                    local FB = BG.FB1
                    FrameHide(0)
                    BiaoGe.lastFrame = "Report"

                    BG.HistoryMainFrame:Hide()
                    BG.Title:SetParent(self)

                    BG.TabButtonsFB:Hide()

                    if not BG.IsVanilla then
                        BG.NanDuDropDown.DropDown:Hide()
                    end
                end)

                -- 左下角文字介绍
                do
                    local t = BG[name]:CreateFontString()
                    t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 45)
                    t:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
                    t:SetTextColor(RGB(BG.g1))
                    t:SetText(L["举报记录："])
                    local tt = t
                    local t = BG[name]:CreateFontString()
                    t:SetPoint("LEFT", tt, "RIGHT", 0, 0)
                    t:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
                    t:SetTextColor(RGB(BG.g2))
                    t:SetText(L["查看举报记录和追踪举报结果"])
                    local tt = t
                    local t = BG[name]:CreateFontString()
                    t:SetPoint("LEFT", tt, "RIGHT", 0, 0)
                    t:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                    t:SetText(L["（右键打开菜单，可以复制其名字）"])
                end
            end

            -- 团本攻略
            BG.BossMainFrame = CreateFrame("Frame", "BG.HopeMainFrame", BG.MainFrame)
            do
                BG.BossMainFrame:Hide()
                for i, FB in ipairs(BG.FBtable) do
                    BG["BossFrame" .. FB] = CreateFrame("Frame", "BG.BossFrame" .. FB, BG.BossMainFrame)
                    BG["BossFrame" .. FB]:Hide()
                end
                BG.BackBiaoGe(BG.BossMainFrame)
                BG.BossMainFrame:SetScript("OnShow", function(self)
                    local FB = BG.FB1
                    FrameHide(0)
                    for i, FB in ipairs(BG.FBtable) do
                        BG["BossFrame" .. FB]:Hide()
                    end
                    BG["BossFrame" .. FB]:Show()
                    BiaoGe.lastFrame = "Boss"

                    BG.HistoryMainFrame:Hide()
                    BG.Title:SetParent(self)

                    BG.TabButtonsFB:Show()
                    for i, FB in ipairs(BG.FBtable) do
                        BG["Button" .. FB]:SetEnabled(true)
                    end
                    BG["Button" .. BG.FB1]:SetEnabled(false)

                    if not BG.IsVanilla then
                        BG.NanDuDropDown.DropDown:Hide()
                    end
                end)
                -- 左下角文字介绍
                do
                    local t = BG.BossMainFrame:CreateFontString()
                    t:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 35, 45)
                    t:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
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
                if not BG.IsVanilla then
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
                if BG.ButtonNewBee then
                    BG.ButtonNewBee:Show()
                end
                BG.History.chooseNum = nil
            end)
        end
    end
    ----------生成各副本UI----------
    do
        for k, FB in pairs(BG.FBtable) do
            BG.CreateFBUI(FB)
            BG.HopeUI(FB)
        end
        BG.CreateBossModel()
        BG.HopeDaoChuUI()

        --通报UI
        local lastbt
        lastbt = BG.ZhangDanUI(lastbt)
        lastbt = BG.LiuPaiUI(lastbt)
        lastbt = BG.XiaoFeiUI(lastbt)
        lastbt = BG.QianKuanUI(lastbt)
        lastbt = BG.YongShiUI(lastbt)
        if BG.IsWLK then
            lastbt = BG.WCLUI(lastbt)
        end

        BG.HistoryUI()
        BG.ReceiveUI()
        BG.DuiZhangUI()
        BG.DuiZhangList()
        BG.RoleOverviewUI()
        BG.FilterClassItemUI()
        BG.ItemLibUI()
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
                ns.InterfaceOptionsFrame_OpenToCategory("|cff00BFFFBiaoGe|r")
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
                font:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
                bt:SetFontString(font)
                bt:SetText(L["通知锁定"])
                bt:SetSize(font:GetWidth() + 30, font:GetHeight() + 10)
                bt:Hide()
                BG.ButtonMoveLock = bt

                local text = bt:CreateFontString()
                text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
                text:SetAlpha(0.8)
                text:SetPoint("BOTTOMLEFT", bt, "BOTTOMRIGHT", 5, 0)
                text:SetText(L["右键通知框体可还原位置"])

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
                                            (AddTexture(Texture) .. link), SetClassCFF(UnitName("player"), "Player"), "|cffFFD700", 10000, L["|cffFF0000（欠款2000）|r"], "|cff" .. BG.Boss[FB]["boss" .. num]["color"], BG.Boss[FB]["boss" .. num]["name2"]) .. BG.STC_r1(L[" （测试） "]))
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
            bt.Text:SetText(L["工资抹零"])
            bt.Text:SetTextColor(RGB(BG.b1))
            bt.Text:ClearAllPoints()
            bt.Text:SetPoint("TOPLEFT", bt:GetParent(), "BOTTOMLEFT", 3, -1)
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
    if not BG.IsVanilla then
        local fbid, sound
        local function RaidDifficultyID()
            local nanduID
            nanduID = GetRaidDifficultyID()
            if nanduID == 3 or nanduID == 175 then
                return 3
            elseif nanduID == 4 or nanduID == 176 then
                return 4
            elseif nanduID == 5 or nanduID == 193 then
                return 5
            elseif nanduID == 6 or nanduID == 194 then
                return 6
            end
        end
        local function AddButton(nanduID, text, soundID) -- 3，L["10人|cff00BFFF普通|r"]，12880
            local info = LibBG:UIDropDownMenu_CreateInfo()
            info.text, info.func = text, function()
                local yes, type = IsInInstance()
                if not yes then
                    SetRaidDifficultyID(nanduID)
                    PlaySound(soundID)
                else
                    fbid = nanduID
                    sound = soundID
                    StaticPopup_Show("QIEHUANFUBEN", text)
                end
                FrameHide(0)
            end
            if RaidDifficultyID() == nanduID then
                info.checked = true
            end
            LibBG:UIDropDownMenu_AddButton(info)
        end
        StaticPopupDialogs["QIEHUANFUBEN"] = {
            text = L["确认切换难度为< %s >？"],
            button1 = L["是"],
            button2 = L["否"],
            OnAccept = function()
                SetRaidDifficultyID(fbid)
                PlaySound(sound)
            end,
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
        text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        text:SetTextColor(RGB(BG.y2))
        text:SetText(L["当前难度："])
        BG.NanDuDropDown.BiaoTi = text

        LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
            FrameHide(0)
            BG.PlaySound(1)
            local info = LibBG:UIDropDownMenu_CreateInfo()
            info.text = L["切换副本难度"]
            info.isTitle = true
            info.notCheckable = true
            LibBG:UIDropDownMenu_AddButton(info)

            AddButton(3, L["10人|cff00BFFF普通|r"], 12880)
            AddButton(5, L["10人|cffFF0000英雄|r"], 12873)
            AddButton(4, L["25人|cff00BFFF普通|r"], 12880)
            AddButton(6, L["25人|cffFF0000英雄|r"], 12873)
        end)

        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:RegisterEvent("GROUP_ROSTER_UPDATE")
        f:SetScript("OnEvent", function(self, even, ...)
            C_Timer.After(1, function()
                local nandu
                local nanduID
                nanduID = GetRaidDifficultyID()
                if nanduID == 3 or nanduID == 175 then
                    nandu = L["10人|cff00BFFF普通|r"]
                elseif nanduID == 4 or nanduID == 176 then
                    nandu = L["25人|cff00BFFF普通|r"]
                elseif nanduID == 5 or nanduID == 193 then
                    nandu = L["10人|cffFF0000英雄|r"]
                elseif nanduID == 6 or nanduID == 194 then
                    nandu = L["25人|cffFF0000英雄|r"]
                end
                LibBG:UIDropDownMenu_SetText(dropDown, nandu)
            end)
        end)

        local changeRaidDifficulty = ERR_RAID_DIFFICULTY_CHANGED_S:gsub("%%s", "(.+)")
        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_SYSTEM")
        f:SetScript("OnEvent", function(self, even, text, ...)
            if string.find(text, changeRaidDifficulty) then
                local nandu
                local nanduID = GetRaidDifficultyID()
                if nanduID == 3 or nanduID == 175 then
                    nandu = L["10人|cff00BFFF普通|r"]
                elseif nanduID == 4 or nanduID == 176 then
                    nandu = L["25人|cff00BFFF普通|r"]
                elseif nanduID == 5 or nanduID == 193 then
                    nandu = L["10人|cffFF0000英雄|r"]
                elseif nanduID == 6 or nanduID == 194 then
                    nandu = L["25人|cffFF0000英雄|r"]
                end
                LibBG:UIDropDownMenu_SetText(dropDown, nandu)
            end
        end)
    end
    ----------副本切换按钮----------
    do
        local buttonsWidth = 0
        local last
        local lastClickFB = BG.FB1

        function BG.ClickFBbutton(FB)
            if FB == BG.FB1 then return end
            FrameHide(0)
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
            FrameDongHua(BG.MainFrame, Height[FB], Width[FB])

            BG.UpdateAllFilter()
            BG.UpdateHopeFrame_IsLooted_All()

            -- 装备库
            if BG.ItemLibMainFrame:IsVisible() then
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
                        if not BG.itemLibCaches[FB] then
                            BG.CacheAndUpdateAllItemLib()
                        else
                            BG.UpdateAllItemLib()
                            BG.UpdateItemLib_RightHope_All()
                            BG.UpdateItemLib_RightHope_IsHaved_All()
                            BG.UpdateItemLib_RightHope_IsLooted_All()
                        end
                    end)
                end
                BG.lastItemLibFB = BG.FB1
                lastClickFB = BG.FB1
            end

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
            if BG.UpdateAchievementFrame then
                BG.UpdateAchievementFrame()
            end
            BG.UpdateButtonClearBiaoGeMoney()
        end

        local function Create_FBButton(FB, fbID)
            local bt = CreateFrame("Button", nil, BG.TabButtonsFB)
            bt:SetHeight(bt:GetParent():GetHeight())
            bt:SetNormalFontObject(BG.FontBlue15)
            bt:SetDisabledFontObject(BG.FontWhite15)
            bt:SetHighlightFontObject(BG.FontWhite15)
            if not last then
                bt:SetPoint("LEFT")
            else
                bt:SetPoint("LEFT", last, "RIGHT", 0, 0)
            end
            bt:SetText(GetRealZoneText(fbID))
            local t = bt:GetFontString()
            bt:SetWidth(t:GetStringWidth() + 20)
            buttonsWidth = buttonsWidth + bt:GetWidth()
            bt:GetParent():SetWidth(buttonsWidth)
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

        local first, last
        for i, v in ipairs(BG.FBtable2) do
            BG["Button" .. v.FB] = Create_FBButton(v.FB, v.ID)
            if i == 1 then
                first = BG["Button" .. v.FB]
            end
            last = BG["Button" .. v.FB]
        end

        BG["Button" .. BG.FB1]:SetEnabled(false)

        local l = first:CreateLine()
        l:SetColorTexture(GetClassRGB(nil, "player", BG.borderAlpha))
        l:SetStartPoint("BOTTOMLEFT", first, -30, -3)
        l:SetEndPoint("BOTTOMRIGHT", last, 30, -3)
        l:SetThickness(1.5)
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
        BG.ReportMainFrameTabNum = 7
        BG.BossMainFrameTabNum = 8

        local clicked
        function BG.ClickTabButton(num)
            clicked = true
            BG.After(0, function() clicked = false end)
            for i, v in pairs(BG.tabButtons) do
                local bt = v.button
                if i == num then
                    local r, g, b = GetClassRGB(nil, "player")
                    bt.bg:SetGradient("VERTICAL", CreateColor(r, g, b, .6), CreateColor(r, g, b, .1))
                    bt:GetFontString():SetTextColor(1, 1, 1)
                    bt:Disable()
                    v.frame:Show()
                else
                    local r, g, b = 0, 0, 0
                    bt.bg:SetGradient("VERTICAL", CreateColor(r, g, b, .8), CreateColor(r, g, b, .2))
                    bt:GetFontString():SetTextColor(1, .82, 0)
                    bt:Enable()
                    v.frame:Hide()
                end
            end
            if BG.FrameNewBee then
                BG.FrameNewBee:Hide()
            end
            if BG.UpdateAuctionLogFrame then
                BG.UpdateAuctionLogFrame()
            end
        end

        local function Create_TabButton(num, text, frame, width) -- 1,L["当前表格 "],BG["Frame" .. BG.FB1],150
            local bt = CreateFrame("Button", nil, BG.MainFrame, "BackdropTemplate")
            bt:SetBackdrop({
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            bt:SetBackdropBorderColor(GetClassRGB(nil, "player", BG.borderAlpha))
            bt:SetSize(90, 28)
            if num == 1 then
                if BG.IsWLK then
                    bt:SetPoint("TOPLEFT", BG.MainFrame, "BOTTOM", -360, 1)
                else
                    bt:SetPoint("TOPLEFT", BG.MainFrame, "BOTTOM", -280, 1)
                end
            else
                bt:SetPoint("LEFT", BG.tabButtons[num - 1].button, "RIGHT", BG.IsWLK and 3 or 20, 0)
            end
            bt.bg = bt:CreateTexture(nil, "BACKGROUND")
            bt.bg:SetAllPoints()
            bt.bg:SetTexture("Interface\\Buttons\\WHITE8x8")
            local t = bt:CreateFontString()
            t:SetAllPoints()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetText(text)
            t:SetWordWrap(false)
            bt:SetFontString(t)
            BG.tabButtons[num] = {
                button = bt,
                frame = frame
            }
            bt:SetScript("OnClick", function(self)
                BG.ClickTabButton(num)
                BG.PlaySound(1)
            end)
            bt:SetScript("OnEnter", function(self)
                local r, g, b = GetClassRGB(nil, "player")
                self.bg:SetGradient("VERTICAL", CreateColor(r, g, b, .6), CreateColor(r, g, b, .1))
            end)
            bt:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                if clicked then return end
                local r, g, b = 0, 0, 0
                self.bg:SetGradient("VERTICAL", CreateColor(r, g, b, .8), CreateColor(r, g, b, .2))
            end)
            return bt
        end

        local bt = Create_TabButton(BG.FBMainFrameTabNum, L["当前表格"], BG.FBMainFrame)
        bt:HookScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["< 当前表格 >"], 1, 1, 1, true)
            GameTooltip:AddLine(L["表格的核心功能都在这里"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)

        local bt = Create_TabButton(BG.ItemLibMainFrameTabNum, L["装备库"], BG.ItemLibMainFrame)
        bt:HookScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["< 装备库 >"], 1, 1, 1, true)
            GameTooltip:AddLine(L["查看所有适合你的装备"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)

        local bt = Create_TabButton(BG.HopeMainFrameTabNum, L["心愿清单"], BG.HopeMainFrame)
        bt:HookScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["< 心愿清单 >"], 1, 1, 1, true)
            GameTooltip:AddLine(L["你可以设置一些装备，这些装备只要掉落就会提醒，并且自动关注团长拍卖"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)

        local bt = Create_TabButton(BG.DuiZhangMainFrameTabNum, L["对账"], BG.DuiZhangMainFrame)
        bt:HookScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["< 对账 >"], 1, 1, 1, true)
            GameTooltip:AddLine(L["当团队有人通报BiaoGe/RaidLedger/大脚的账单，你可以选择该账单，来对账"], 1, 0.82, 0, true)
            GameTooltip:AddLine(L["只对比装备收入，不对比罚款收入，也不对比支出"], 1, 0.82, 0, true)
            GameTooltip:AddLine(L["别人账单会自动保存1天，过后自动删除"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)

        local bt = Create_TabButton(BG.YYMainFrameTabNum, L["YY评价"], BG.YYMainFrame)
        bt:HookScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["< YY评价 >"], 1, 1, 1, true)
            GameTooltip:AddLine(L["|cff808080（右键：开启/关闭该模块）|r"], 1, 0.82, 0, true)
            GameTooltip:AddLine(L["你可以给YY频道做评价，帮助别人辨别该团好与坏"], 1, 0.82, 0, true)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(L["你可以查询YY频道的大众评价"], 1, 0.82, 0, true)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(L["聊天频道的YY号变为超链接，方便你复制该号码或查询大众评价"], 1, 0.82, 0, true)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(L["替换集结号的评价框，击杀当前版本团本尾王后弹出"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        local dropDown = LibBG:Create_UIDropDownMenu(nil, bt)
        LibBG:UIDropDownMenu_SetAnchor(dropDown, -5, 0, "BOTTOM", bt, "TOP")
        bt:SetScript("OnMouseDown", function(self, enter)
            if enter == "RightButton" then
                GameTooltip:Hide()
                if BG.DropDownListIsVisible(self) then
                    _G.L_DropDownList1:Hide()
                else
                    local YY = "BiaoGeYY"
                    local channelTypeMenu = {
                        {
                            isTitle = true,
                            text = L["模块开关"],
                            notCheckable = true,
                        },
                        {
                            text = L["开启"],
                            notCheckable = true,
                            func = function()
                                BiaoGe.YYdb.share = 1
                                BG.YYShowHide(BiaoGe.YYdb.share)
                                JoinPermanentChannel(YY, nil, 1)
                            end,
                        },
                        {
                            text = L["关闭"],
                            notCheckable = true,
                            func = function()
                                BiaoGe.YYdb.share = 0
                                BG.YYShowHide(BiaoGe.YYdb.share)
                                LeaveChannelByName(YY)
                            end,
                        },
                        {
                            text = CANCEL,
                            notCheckable = true,
                            func = function(self)
                                LibBG:CloseDropDownMenus()
                            end,
                        }
                    }
                    LibBG:EasyMenu(channelTypeMenu, dropDown, bt, 0, 0, "MENU", 3)
                    BG.PlaySound(1)
                end
            end
        end)

        if BG.IsWLK then
            local bt = Create_TabButton(BG.AchievementMainFrameTabNum, L["团员成就"], BG.AchievementMainFrame)
            bt:HookScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["< 团员成就 >"], 1, 1, 1, true)
                GameTooltip:AddLine(L["查看团员的团本成就完成情况（该功能引用于比较成就里的API）"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)

            local bt = Create_TabButton(BG.ReportMainFrameTabNum, L["举报记录"], BG.ReportMainFrame)
            bt:HookScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["< 举报记录 >"], 1, 1, 1, true)
                GameTooltip:AddLine(L["查看举报记录和追踪举报结果"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)

            local bt = Create_TabButton(BG.BossMainFrameTabNum, L["团本攻略"], BG.BossMainFrame)
            bt:HookScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["< 团本攻略 >"], 1, 1, 1, true)
                GameTooltip:AddLine(L["了解BOSS技能和应对策略、职业职责"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
        end

        ----------更新已拥有----------
        do
            function BG.UpdateBiaoGeAllIsHaved()
                local FB = BG.FB1
                if BG.FBMainFrame:IsVisible() then
                    for b = 1, Maxb[FB] do
                        for i = 1, Maxi[FB] do
                            local bt = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                            if bt then
                                BG.IsHave(bt)
                            end
                        end
                    end
                elseif BG.HistoryMainFrame:IsVisible() then
                    for b = 1, Maxb[FB] do
                        for i = 1, Maxi[FB] do
                            local bt = BG.HistoryFrame[FB]["boss" .. b]["zhuangbei" .. i]
                            if bt then
                                BG.IsHave(bt)
                            end
                        end
                    end
                elseif BG.HopeMainFrame:IsVisible() then
                    for n = 1, HopeMaxn[FB] do
                        for b = 1, Maxb[FB] do
                            for i = 1, Maxi[FB] do
                                local bt = BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                                if bt then
                                    BG.IsHave(bt)
                                end
                            end
                        end
                    end
                elseif BG.DuiZhangMainFrame:IsVisible() then
                    for b = 1, Maxb[FB] do
                        for i = 1, Maxi[FB] do
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
            f:SetScript("OnEvent", function(self, even, ...)
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
        local notShowGuanZhuTbl = {
            '{rt7}拍卖取消{rt7}',
            '{rt6}拍卖成功{rt6}',
            '{rt7}流拍{rt7}',
            '{rt1}拍卖倒数{rt1}',

            '{rt7}拍賣取消{rt7}',
            '{rt6}拍賣成功{rt6}',
            '{rt1}拍賣倒數{rt1}',
        }

        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:RegisterEvent("CHAT_MSG_RAID_WARNING")
        f:RegisterEvent("CHAT_MSG_RAID")
        f:SetScript("OnEvent", function(self, even, msg, playerName, ...)
            if even == "CHAT_MSG_RAID" then
                playerName = strsplit("-", playerName)
                if playerName ~= BG.masterLooter then
                    return
                end
            end
            -- 收集全部物品ID
            local itemIDs = ""
            for itemID in string.gmatch(msg, "|Hitem:(%d+):") do
                itemIDs = itemIDs .. itemID .. " "
            end
            -- 不提示关注拍卖
            local ShowGuanZhu = true
            for i, text in ipairs(notShowGuanZhuTbl) do
                if msg:find(text) then
                    ShowGuanZhu = false
                    break
                end
            end
            -- 开始
            local name1 = "auctionHigh"
            if BiaoGe.options[name1] ~= 1 then return end
            local name2 = "auctionHighTime"
            local yes
            local sound_yes = ""
            for _, FB in pairs(BG.FBtable) do
                for b = 1, Maxb[FB], 1 do
                    for i = 1, Maxi[FB], 1 do
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

                                        if ShowGuanZhu and BiaoGe[FB]["boss" .. b]["guanzhu" .. i] then
                                            if not string.find(sound_yes, tostring(itemID)) then
                                                BG.FrameLootMsg:AddMessage(BG.STC_g1(format(L["你关注的装备开始拍卖了：%s（右键取消关注）"],
                                                    AddTexture(Texture) .. BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText())))
                                                PlaySoundFile(BG["sound_paimai" .. BiaoGe.options.Sound], "Master")
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
            -- pt(link, text)
            local item, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
            if not link then return end
            if IsAltKeyDown() then
                if BG.IsML then -- 开始拍卖
                    BG.StartAuction(link)
                else            -- 关注装备
                    BG.AddGuanZhu(link)
                end
            elseif IsShiftKeyDown() then
                Insert(link)
            end
        end)
        -- 背包
        hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", function(self, button)
            if not IsShiftKeyDown() then return end
            local link = C_Container.GetContainerItemLink(self:GetParent():GetID(), self:GetID())
            Insert(link)
        end)
    end
    ----------时光徽章价格----------
    do
        local function OnEnter(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["当前时光徽章"], 1, 1, 1, true)
            GameTooltip:AddLine(self.currentPrice, 1, 0.82, 0, true)
            GameTooltip:Show()
        end

        local f = CreateFrame("Frame", nil, BG.MainFrame)
        f:SetSize(1, 20)
        f:SetPoint("BOTTOMLEFT", 10, 2)
        f.text = f:CreateFontString()
        f.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
        f.text:SetPoint("LEFT")
        f.text:SetTextColor(1, 1, 1)
        f.currentPrice = L["不可用"]
        f.text:SetText(AddTexture(1120721) .. BG.STC_dis(L["不可用"]))
        f:SetWidth(f.text:GetWidth() + 10)
        f:SetScript("OnEnter", OnEnter)
        f:SetScript("OnLeave", GameTooltip_Hide)
        BG.ButtonToken = f

        if not BG.IsVanilla then
            local function OnTokenMarketPriceUpdated(event, result)
                if C_WowTokenPublic.GetCurrentMarketPrice() then
                    local currentPrice = GetMoneyString(C_WowTokenPublic.GetCurrentMarketPrice(), false)
                    f.currentPrice = currentPrice
                    f.text:SetText(AddTexture(1120721) .. currentPrice)
                else
                    f.currentPrice = L["不可用"]
                    f.text:SetText(AddTexture(1120721) .. BG.STC_dis(L["不可用"]))
                end
                f:SetWidth(f.text:GetWidth() + 10)
            end
            local frame = CreateFrame("Frame")
            frame:RegisterEvent("TOKEN_MARKET_PRICE_UPDATED")
            frame:SetScript("OnEvent", OnTokenMarketPriceUpdated)

            local f = CreateFrame("Frame")
            f:RegisterEvent("PLAYER_ENTERING_WORLD")
            f:SetScript("OnEvent", function(self, even, ...)
                local isLogin, isReload = ...
                if not (isLogin or isReload) then return end
                C_Timer.After(2, function()
                    C_WowTokenPublic.UpdateMarketPrice()
                    OnTokenMarketPriceUpdated()
                end)
            end)
            C_Timer.NewTicker(60, function()
                C_WowTokenPublic.UpdateMarketPrice()
            end)
        end
    end
    ----------在线玩家数----------
    if not BG.IsWLK then
        BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
            if not (isLogin or isReload) then return end
            if not IsAddOnLoaded("Blizzard_Communities") then
                UIParentLoadAddOn("Blizzard_Communities")
            end
        end)

        -- local World = "BiaoGeYY"
        local World = LOOK_FOR_GROUP
        -- local World = "大脚世界频道"

        local function GetFactionName()
            if UnitFactionGroup("player") == "Alliance" then
                return FACTION_ALLIANCE
            else
                return FACTION_HORDE
            end
        end
        local function OnEnter(self)
            self.isOnEnter = true
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(format(L["%s在线人数"], GetFactionName()), 1, 1, 1, true)
            if self.count then
                GameTooltip:AddLine(self.count .. L["人"] .. format(L["（获取时间：%s）"], self.time), 1, 0.82, 0, true)
            else
                local yes
                local channels = { GetChannelList() }
                for i = 1, #channels, 3 do
                    if channels[i + 1] == World then
                        yes = true
                        break
                    end
                end
                if yes then
                    GameTooltip:AddLine(L["未刷新"], 0.5, 0.5, 0.5, true)
                else
                    GameTooltip:AddLine(format(L["你未加入%s，无法获取在线人数。"], World), 0.5, 0.5, 0.5, true)
                end
            end
            GameTooltip:AddLine(L["<点击刷新>"], 0, 1, 0, true)

            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(format(L["数据来源："]), 1, 1, 1, true)
            GameTooltip:AddLine(format(L["%s在线人数"], World), 1, 0.82, 0, true)
            GameTooltip:Show()
        end
        local function OnLeave(self)
            self.isOnEnter = false
            GameTooltip:Hide()
        end

        local f = CreateFrame("Button", nil, BG.MainFrame)
        f:SetSize(1, 20)
        f:SetPoint("LEFT", BG.ButtonToken, "RIGHT", 0, 0)
        f:SetNormalFontObject(BG.FontWhite13)
        f:SetText(AddTexture(135994) .. L["待刷新"])
        f:GetFontString():SetPoint("LEFT")
        f:SetWidth(f:GetFontString():GetWidth() + 10)
        f.channel = World
        f:SetScript("OnEnter", OnEnter)
        f:SetScript("OnLeave", OnLeave)
        f:SetScript("OnClick", function(self)
            BG.GetChannelMemberCount(self.channel)
            BG.PlaySound(1)
        end)
        BG.ButtonOnLineCount = f

        function BG.GetChannelMemberCount(channelName)
            local yes
            local channels = { GetChannelList() }
            for i = 1, #channels, 3 do
                if channels[i + 1] == channelName then
                    yes = true
                    break
                end
            end
            if yes then
                if ChannelFrame:IsShown() then
                    HideUIPanel(ChannelFrame)
                end
                ChannelFrame.targetChannel = channelName
                ShowUIPanel(ChannelFrame)
            end
        end

        hooksecurefunc(ChannelFrame.ChannelList, 'AddChannelButtonInternal', function(_, bt, _, name, _, channelID)
            if name == ChannelFrame.targetChannel then
                BG.After(0.3, function()
                    ChannelFrame.ChannelList:SetSelectedChannel(bt)
                    BG.After(1, function()
                        local _, _, _, _, count = GetChannelDisplayInfo(bt.channelID)
                        if count then
                            f.count = count
                            local m, s = GetGameTime()
                            s = format("%02d", s)
                            f.time = m .. ":" .. s
                            f:SetText(AddTexture(135994) .. count .. L["人"])
                            f:GetFontString():SetPoint("LEFT")
                            f:SetWidth(f:GetFontString():GetWidth() + 10)
                            if f.isOnEnter then
                                OnEnter(f)
                            end
                        end
                        for k, bt in ipairs(ChannelFrame.ChannelList.buttons) do
                            if bt.name == CHANNEL_CATEGORY_WORLD then
                                ChannelFrame.ChannelList:SetSelectedChannel(bt)
                                return
                            end
                        end
                    end)
                end)
                ChannelFrame.targetChannel = nil
                HideUIPanel(ChannelFrame)
            end
        end)
    end
    ----------离队入队染上职业颜色----------
    do
        local last
        local lastraidjoinname
        local lastpartyjoinname
        local function MsgClassColor(self, even, msg, player, l, cs, t, flag, channelId, ...)
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
                    local _, color = SetClassCFF(raidjoinname)
                    local colorname = "|c" .. color .. raidjoinnamelink .. "|r"
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
                    local _, color = SetClassCFF(partyjoinname)
                    local colorname = "|c" .. color .. partyjoinnamelink .. "|r"
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
                -- pt(link)
            end)
            _G["ChatFrame" .. i]:HookScript("OnHyperlinkLeave", BG.Hide_AllHighlight)

            hooksecurefunc(_G["ChatFrame" .. i], "RefreshDisplay", function(self)
                BG.Hide_ChatHighlight()
                if not (self:IsVisible() and BG.highlightChatFrameItemID) then return end
                BG.HighlightChatFrame("item:" .. BG.highlightChatFrameItemID .. ":")
            end)
            i = i + 1
        end

        hooksecurefunc("ContainerFrameItemButton_OnEnter", function(self, button)
            local link = C_Container.GetContainerItemLink(self:GetParent():GetID(), self:GetID())
            BG.Show_AllHighlight(link, "bag")
        end)
        hooksecurefunc("ContainerFrameItemButton_OnLeave", BG.Hide_AllHighlight)
        BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
            if not (isLogin or isReload) then return end
            if IsAddOnLoaded("Bagnon") then
                BG.After(1, function()
                    local i = 1
                    while _G["BagnonContainerItem" .. i] do
                        local bag = _G["BagnonContainerItem" .. i]
                        bag:HookScript("OnLeave", ContainerFrameItemButton_OnLeave)
                        i = i + 1
                    end
                end)
            end
        end)
    end
    ----------一键分配装备给自己----------
    BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
        if not (isLogin or isReload) then return end
        local isOnter

        local function IsTrueLoot(quality, bindType, itemStackCount, typeID)
            local _quality = GetLootThreshold()
            if quality < _quality then
                return
            end
            if bindType == 4 then          -- 任务物品
                return
            elseif bindType == 1 then      -- 拾取绑定的
                if itemStackCount > 1 then -- 堆叠数量大于1
                    return
                end
            end
            return true
        end

        local function GiveLoot()
            if GetLootMethod() ~= "master" then return end
            for ci = 1, GetNumGroupMembers() do
                for li = 1, GetNumLootItems() do
                    if LootSlotHasItem(li) and GetMasterLootCandidate(li, ci) == UnitName("player") then
                        local itemLink = GetLootSlotLink(li)
                        if itemLink then
                            local name, link, quality, level, _, _, _, itemStackCount, _, Texture,
                            _, typeID, _, bindType = GetItemInfo(itemLink)
                            if IsTrueLoot(quality, bindType, itemStackCount, typeID) then
                                GiveMasterLoot(li, ci)
                            end
                        end
                    end
                end
            end
        end

        local function OnClick(self)
            BG.PlaySound(1)
            GiveLoot()
        end

        local function OnEnter(self)
            isOnter = true
            local bt = self.bt or self
            if bt:IsEnabled() then
                bt:SetBackdropBorderColor(1, 1, 1)
            end
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["一键分配"], 1, 1, 1, true)
            if self.dis then
                if IsInRaid() then
                    GameTooltip:AddLine(L["你不是物品分配者，不能使用"], 1, 0, 0, true)
                else
                    GameTooltip:AddLine(L["不在团队中，不能使用"], 1, 0, 0, true)
                end
            else
                GameTooltip:AddLine(L["把全部可交易的物品分配给自己"], 1, 0.82, 0, true)
            end
            GameTooltip:AddLine(BG.STC_dis(L["你可在插件设置-BiaoGe-其他功能里关闭这个功能"]), 0.5, 0.5, 0.5, true)

            local items = {}
            for li = 1, GetNumLootItems() do
                if LootSlotHasItem(li) then
                    local itemLink = GetLootSlotLink(li)
                    if itemLink then
                        local name, link, quality, level, _, _, _, itemStackCount, _, Texture,
                        _, typeID, _, bindType = GetItemInfo(itemLink)
                        if IsTrueLoot(quality, bindType, itemStackCount, typeID) then
                            tinsert(items, AddTexture(Texture, -3) .. link .. "|cffFFFFFF(" .. level .. ")|r")
                        end
                    end
                end
            end
            GameTooltip:AddLine(" ", 1, 1, 0, true)
            GameTooltip:AddLine(L["点击后会把这些物品分配给你："], 1, 1, 0, true)
            if #items ~= 0 then
                for i, item in ipairs(items) do
                    GameTooltip:AddLine(i .. ". " .. item, 1, 1, 0)
                end
            else
                GameTooltip:AddLine(BG.STC_dis(L["没有符合条件的物品"]), 1, 1, 0, true)
            end
            GameTooltip:Show()
        end

        local function OnLeave(self)
            isOnter = false
            local bt = self.bt or self
            if bt:IsEnabled() then
                bt:SetBackdropBorderColor(0, 1, 0)
            end
            GameTooltip:Hide()
        end

        local parent = ElvLootFrame or XLootFrame or LootFrame
        local bt = CreateFrame("Button", nil, parent, "BackdropTemplate")
        bt:SetBackdrop({
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        bt:SetBackdropBorderColor(0, 1, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetPoint("BOTTOM", parent, "TOP", 0, 0)
        bt:SetText(L["一键分配"])
        bt:SetSize(bt:GetFontString():GetWidth() + 10, 25)
        bt:Hide()
        bt:SetScript("OnClick", OnClick)
        bt:SetScript("OnEnter", OnEnter)
        bt:SetScript("OnLeave", OnLeave)

        local f = CreateFrame("Frame", nil, bt)
        f:SetAllPoints()
        f.dis = true
        f.bt = bt
        f:SetScript("OnEnter", OnEnter)
        f:SetScript("OnLeave", OnLeave)
        local disframe = f

        local function OnShow()
            if BiaoGe.options["allLootToMe"] ~= 1 then
                bt:Hide()
                disframe:Hide()
                return
            end
            isOnter = false

            if GetLootMethod() == "master" then
                bt:Show()
                if select(2, IsInInstance()) == "raid" and BG.masterLooter == UnitName("player") then
                    disframe:Hide()
                    bt:Enable()
                    bt:SetBackdropBorderColor(0, 1, 0)
                    if BiaoGe.options["autoAllLootToMe"] == 1 then
                        BG.After(0.1, function()
                            GiveLoot()
                        end)
                    end
                else
                    disframe:Show()
                    bt:Disable()
                    bt:SetBackdropBorderColor(RGB("808080"))
                end
            else
                bt:Hide()
            end
        end
        hooksecurefunc("LootFrame_Show", OnShow)
        if ElvLootFrame then
            ElvLootFrame:HookScript("OnShow", OnShow)
        end
        if XLootFrame then
            XLootFrame:HookScript("OnShow", OnShow)
        end

        -- 当物品被捡走时，刷新鼠标提示工具
        BG.RegisterEvent("LOOT_SLOT_CLEARED", function(self, even)
            if isOnter then
                if bt:IsEnabled() then
                    OnEnter(bt)
                else
                    OnEnter(disframe)
                end
            end
        end)
    end)
    ----------血月活动期间自动释放尸体和对话自动复活----------
    if BG.IsVanilla_Sod then
        local tbl = {
            121411, -- 血月活动
        }
        BG.RegisterEvent("GOSSIP_SHOW", function(self, even)
            if BiaoGe.options["xueyueAuto"] ~= 1 then return end
            local info = C_GossipInfo.GetOptions()
            for i, v in pairs(info) do
                for _, id in pairs(tbl) do
                    if v.gossipOptionID == id then
                        C_GossipInfo.SelectOption(v.gossipOptionID)
                    end
                end
            end
        end)

        local bt = CreateFrame("CheckButton", nil, UIParent, "ChatConfigCheckButtonTemplate")
        bt:SetSize(30, 30)
        bt.Text:SetText(BG.BG .. L["荆棘谷血月活动期间自动释放尸体和对话自动复活"])
        bt.Text:SetPoint("TOPLEFT", bt, "TOPRIGHT", 0, -5)
        bt:SetHitRectInsets(0, 0, 0, 0)
        bt.name = "xueyueAuto"
        if BiaoGe.options["xueyueAuto"] == 1 then
            bt:SetChecked(true)
        else
            bt:SetChecked(false)
        end
        bt:Hide()
        bt:SetScript("OnShow", function(self)
            if BiaoGe.options[self.name] == 1 then
                self:SetChecked(true)
            else
                self:SetChecked(false)
            end
        end)
        bt:SetScript("OnClick", function(self)
            if self:GetChecked() then
                BiaoGe.options[self.name] = 1
            else
                BiaoGe.options[self.name] = 0
            end
            BG.PlaySound(1)
        end)

        local wh = "DEATH"
        -- local wh = "CONFIRM_DELETE_SELECTED_MACRO"
        hooksecurefunc("StaticPopup_Show", function(whick)
            if whick == wh then
                local yes
                local i = 1
                while UnitAura("player", i) do
                    local spellID = select(10, UnitAura("player", i))
                    if spellID == 436097 then
                        yes = true
                        break
                    end
                    i = i + 1
                end
                if not yes then return end
                local _, dialog = StaticPopup_Visible(wh)
                if dialog then
                    bt:ClearAllPoints()
                    bt:SetPoint("TOPLEFT", dialog, "BOTTOMLEFT", 0, 0)
                    bt.Text:SetWidth(StaticPopup1:GetWidth() - 50)
                    bt:Show()
                    if BiaoGe.options["xueyueAuto"] == 1 then
                        dialog.button1:Click()
                    end
                end
            end
        end)
        hooksecurefunc("StaticPopup_Hide", function(whick)
            if whick == wh then
                if bt then
                    bt:Hide()
                end
            end
        end)
    end
    ----------查询记录----------
    do
        BiaoGe.whoFrame = BiaoGe.whoFrame or {}
        BiaoGe.whoFrame.history = BiaoGe.whoFrame.history or {}

        local f = CreateFrame("Frame", nil, WhoFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
            -- edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            -- edgeSize = 16,
            -- insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.7)
        f:SetBackdropBorderColor(0, 0, 0, 1)
        f:SetPoint("BOTTOMLEFT", WhoFrameEditBoxInset, "BOTTOMRIGHT", 5, 0)
        f:SetSize(100, FriendsFrame:GetHeight() - 80)
        f:Hide()
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
                    GameTooltip:AddLine(L["|cffFFFFFF左键：|r搜索该记录"], 1, 0.82, 0)
                    GameTooltip:AddLine(L["|cffFFFFFF右键：|r删除该记录"], 1, 0.82, 0)
                    GameTooltip:Show()
                end)
                BG.GameTooltip_Hide(bt)
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

        WhoFrame:HookScript("OnShow", function()
            if BiaoGe.options["searchList"] == 1 then
                f:Show()
            else
                f:Hide()
            end
        end)
    end
    ----------快速记账----------
    do
        -- 创建买家
        local function CreateMaijiaFrame(parent)
            local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
            f:SetWidth(395)
            f:SetHeight(230)
            f:SetPoint("TOP", parent, "TOP", 0, -55)
            f:EnableMouse(true)
            parent.maijiaFrame = f
            parent.buttons = {}
            local framedown
            local frameright = f
            local raid = BG.PaiXuRaidRosterInfo()
            for t = 1, 4 do
                for i = 1, 10 do
                    local bt = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
                    bt:SetSize(90, 20)
                    bt:SetAutoFocus(false)
                    bt:SetEnabled(false)
                    if t >= 2 and i == 1 then
                        bt:SetPoint("TOPLEFT", frameright, "TOPLEFT", 97, 0)
                        frameright = bt
                    end
                    if t == 1 and i == 1 then
                        bt:SetPoint("TOPLEFT", frameright, "TOPLEFT", 10, -5)
                        frameright = bt
                    end
                    if i > 1 then
                        bt:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -2)
                    end
                    if not IsInRaid(1) and t == 1 and i == 1 then -- 单人时
                        bt:SetText(UnitName("player"))
                        bt:SetCursorPosition(0)
                        bt:SetTextColor(GetClassRGB(UnitName("player")))
                        bt.hasName = true
                        for k, v in pairs(BG.playerClass) do
                            bt[k] = select(v.select, v.func("player"))
                        end
                    end
                    local num = (t - 1) * 10 + i
                    if raid[num] and raid[num].name then
                        if raid[num].role then
                            bt:SetText(AddTexture(raid[num].role) .. raid[num].name)
                        elseif raid[num].combatRole == "HEALER" then
                            bt:SetText(AddTexture(raid[num].combatRole) .. raid[num].name)
                        else
                            bt:SetText(raid[num].name)
                        end
                        bt:SetCursorPosition(0)
                        bt:SetTextColor(GetClassRGB(GetText_T(raid[num].name)))
                        bt.hasName = true
                    else
                        bt:EnableMouse(false)
                    end
                    framedown = bt

                    if bt.hasName then
                        tinsert(parent.buttons, bt)

                        bt.ds = bt:CreateTexture()
                        bt.ds:SetPoint("TOPLEFT", -3, -2)
                        bt.ds:SetPoint("BOTTOMRIGHT", -1, 2)
                        bt.ds:SetColorTexture(1, 1, 1, BG.onEnterAlpha)
                        bt.ds:Hide()

                        bt.choose = bt:CreateTexture()
                        bt.choose:SetPoint("TOPLEFT", -3, -2)
                        bt.choose:SetPoint("BOTTOMRIGHT", -1, 2)
                        bt.choose:SetColorTexture(0, 1, 0, 0.2)
                        bt.choose:Hide()

                        bt:SetScript("OnMouseDown", function(self, enter)
                            for i, _bt in ipairs(parent.buttons) do
                                _bt.Left:SetVertexColor(1, 1, 1)
                                _bt.Right:SetVertexColor(1, 1, 1)
                                _bt.Middle:SetVertexColor(1, 1, 1)
                                _bt.choose:Hide()
                            end
                            if parent.maijia == GetText_T(self) then
                                parent.maijia = nil
                                for k, v in pairs(BG.playerClass) do
                                    parent[k] = nil
                                end
                            else
                                parent.maijia = GetText_T(self)
                                if raid[num] or self.class then
                                    for k, v in pairs(BG.playerClass) do
                                        parent[k] = raid[num] and raid[num][k] or self[k]
                                    end
                                end
                                self.Left:SetVertexColor(0, 1, 0)
                                self.Right:SetVertexColor(0, 1, 0)
                                self.Middle:SetVertexColor(0, 1, 0)
                                self.choose:Show()
                            end
                            BG.ChatAccountingFrame:SureButtonUpdate()
                            BG.PlaySound(1)
                        end)
                        bt:SetScript("OnEnter", function(self)
                            self.ds:Show()
                        end)
                        bt:SetScript("OnLeave", function(self)
                            GameTooltip:Hide()
                            self.ds:Hide()
                        end)
                    end
                end
            end
        end
        -- 找到合适的格子
        local function HasEmptyGeZi(link)
            for _, FB in ipairs(BG.GetAllFB()) do
                for b = 1, Maxb[FB] do
                    for i = 1, Maxi[FB] do
                        local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                        local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                        local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]

                        if zhuangbei and GetItemID(zhuangbei:GetText()) == GetItemID(link) and
                            maijia:GetText() == "" and jine:GetText() == "" and
                            not BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
                            return b, i, zhuangbei, maijia, jine, FB
                        end
                    end
                end
            end
        end
        -- 记账失败
        local frames = {}
        local updateFrame = CreateFrame("Frame")
        updateFrame.time = 0
        local function JiZhangError(link)
            BG.FrameLootMsg:AddMessage(L["表格里没找到此次交易的装备，或者该装备已记过账"], RED_FONT_COLOR:GetRGB())
            if BG.ChatAccountingFrame:IsVisible() then
                BG.ChatAccountingFrame:Hide()
            end

            for i, textrue in ipairs(frames) do
                textrue:Hide()
            end
            wipe(frames)

            updateFrame.time = 0
            local FB = BG.FB1
            for b = 1, Maxb[FB] do
                for i = 1, Maxi[FB] do
                    local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                    local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                    local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]

                    if zhuangbei and GetItemID(zhuangbei:GetText()) == GetItemID(link) then
                        if not zhuangbei.JiZhangErrorTextrue then
                            local textrue = zhuangbei:CreateTexture()
                            textrue:SetPoint("TOPLEFT", zhuangbei, "TOPLEFT", -4, -2)
                            textrue:SetPoint("BOTTOMRIGHT", jine, "BOTTOMRIGHT", -2, 0)
                            textrue:SetColorTexture(1, 0, 0, 0.3)
                            zhuangbei.JiZhangErrorTextrue = textrue
                        end
                        zhuangbei.JiZhangErrorTextrue:Show()
                        zhuangbei.JiZhangErrorTextrue:SetAlpha(1)
                        tinsert(frames, zhuangbei.JiZhangErrorTextrue)
                    end
                end
            end
            if #frames ~= 0 then
                updateFrame:SetScript("OnUpdate", function(self, elapsed)
                    updateFrame.time = updateFrame.time + elapsed
                    if updateFrame.time >= 3 and updateFrame.time < 5 then
                        for i, textrue in ipairs(frames) do
                            textrue:SetAlpha((5 - updateFrame.time) / 2)
                        end
                    elseif updateFrame.time >= 5 then
                        for i, textrue in ipairs(frames) do
                            textrue:Hide()
                        end
                        updateFrame.time = 0
                        updateFrame:SetScript("OnUpdate", nil)
                    end
                end)
            end
        end
        -- 记账效果预览
        local function UpdateSeeText()
            if not BG.ChatAccountingFrame.itemLink then return end
            if BG.ChatAccountingFrame.maijia or BG.ChatAccountingFrame.jine ~= "" then
                local b, i, zhuangbei, maijia, jine, FB = HasEmptyGeZi(BG.ChatAccountingFrame.itemLink)
                local Texture = select(10, GetItemInfo(BG.ChatAccountingFrame.itemLink))
                local maijiaText = SetClassCFF(BG.ChatAccountingFrame.maijia or "")
                if maijiaText == "" then
                    maijiaText = BG.STC_y2(L["无"])
                end
                local jineText = "|cffFFD700" .. 0 .. "|rg"
                if BG.ChatAccountingFrame.jine ~= "" then
                    jineText = "|cffFFD700" .. BG.ChatAccountingFrame.jine .. "|rg"
                end
                local qiankuantext = ""
                if BG.ChatAccountingFrame.qiankuan ~= "" then
                    qiankuantext = format("|cffFF0000" .. L["（欠款%d）"] .. RR, BG.ChatAccountingFrame.qiankuan)
                end

                local text = format(L["|cff00BFFF< 快速记账成功 >|r\n|cffFFFFFF装备：%s\n买家：%s\n金额：%s%s\n表格：%s\nBoss：%s"],
                    (AddTexture(Texture) .. BG.ChatAccountingFrame.itemLink),
                    maijiaText,
                    jineText,
                    qiankuantext,
                    BG.GetFBinfo(FB, "localName"),
                    "|cff" .. BG.Boss[FB]["boss" .. b]["color"] .. BG.Boss[FB]["boss" .. b]["name2"] .. RR)
                BG.ChatAccountingFrame.seeText:SetText(text)
            else
                BG.ChatAccountingFrame.seeText:SetText("")
            end
        end

        -- 主UI
        local f = CreateFrame("Frame", "BG.ChatAccountingFrame", UIParent, "BackdropTemplate")
        do
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                edgeSize = 32,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:SetSize(430, 380)
            f:SetFrameStrata("HIGH")
            f:SetClampedToScreen(true)
            f:SetFrameLevel(300)
            f:EnableMouse(true)
            f:SetMovable(true)
            f:SetHyperlinksEnabled(true)
            f:SetScript("OnMouseUp", function(self)
                self:StopMovingOrSizing()
            end)
            f:SetScript("OnMouseDown", function(self)
                self:StartMoving()
            end)
            f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
                GameTooltip:SetOwner(self, "ANCHOR_CURSOR", 0, 0)
                GameTooltip:ClearLines()
                local itemID = GetItemInfoInstant(link)
                if itemID then
                    GameTooltip:SetItemByID(itemID)
                    GameTooltip:Show()
                end
            end)
            f:SetScript("OnHyperlinkLeave", GameTooltip_Hide)
            f:SetScript("OnShow", function(self)
                if BG.ChatAccountingFrame.maijiaFrame then
                    BG.ChatAccountingFrame.maijiaFrame:Hide()
                end
                CreateMaijiaFrame(BG.ChatAccountingFrame)
                local link = ""
                local Texture
                if BG.ChatAccountingFrame.itemLink then
                    Texture = select(10, GetItemInfo(BG.ChatAccountingFrame.itemLink))
                    link = BG.ChatAccountingFrame.itemLink
                end

                local x, y = GetCursorPosition()
                x, y = x / UIParent:GetEffectiveScale(), y / UIParent:GetEffectiveScale()
                BG.ChatAccountingFrame:ClearAllPoints()
                BG.ChatAccountingFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x + 10, y + 10)
                BG.ChatAccountingFrame.item:SetText(link)
                BG.ChatAccountingFrame.icon:SetTexture(Texture)
                BG.ChatAccountingFrame.maijia = nil
                BG.ChatAccountingFrame.jine = ""
                BG.ChatAccountingFrame.qiankuan = ""
                BG.ChatAccountingFrame.jineFrame:SetText("")
                BG.ChatAccountingFrame.jineFrame:SetFocus()
                BG.ChatAccountingFrame.qiankuanFrame:SetText("")
                for k, v in pairs(BG.playerClass) do
                    BG.ChatAccountingFrame[k] = nil
                end
                if BiaoGe.options.fastCountPreview == 1 then
                    BG.ChatAccountingFrame.seeFrame:Show()
                else
                    BG.ChatAccountingFrame.seeFrame:Hide()
                end
                BG.ChatAccountingFrame:SureButtonUpdate()
            end)
            f:SetScript("OnHide", function(self)
                if BG.ChatAccountingFrame.BlinkHilight then
                    BG.ChatAccountingFrame.BlinkHilight:Hide()
                end
            end)
            BG.ChatAccountingFrame = f
        end
        tinsert(UISpecialFrames, "BG.ChatAccountingFrame")

        -- 顶部标题
        do
            local t = f:CreateTexture(nil, "ARTWORK")
            t:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")
            t:SetWidth(256)
            t:SetHeight(64)
            t:SetPoint("TOP", f, 0, 12)
            f.texture = t
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetText(L["< 快速记账 >"])
            t:SetPoint("TOP", f.texture, 0, -13)
            t:SetTextColor(RGB(BG.b1))
        end

        -- 装备
        do
            BG.ChatAccountingFrame.item = BG.ChatAccountingFrame:CreateFontString()
            BG.ChatAccountingFrame.item:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            BG.ChatAccountingFrame.item:SetPoint("TOP", BG.ChatAccountingFrame, "TOP", 0, -35)
            BG.ChatAccountingFrame.item:SetTextColor(RGB("FFD100"))

            BG.ChatAccountingFrame.icon = BG.ChatAccountingFrame:CreateTexture(nil, 'ARTWORK')
            BG.ChatAccountingFrame.icon:SetPoint('LEFT', BG.ChatAccountingFrame.item, "LEFT", -20, 0)
            BG.ChatAccountingFrame.icon:SetSize(18, 18)
        end

        -- 金额
        do
            local edit = CreateFrame("EditBox", nil, BG.ChatAccountingFrame, "InputBoxTemplate")
            edit:SetSize(120, 20)
            edit:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOM", -10, 60)
            edit:SetAutoFocus(false)
            BG.ChatAccountingFrame.jineFrame = edit
            edit:SetScript("OnTextChanged", function(self)
                BG.UpdateTwo0(self)
                BG.ChatAccountingFrame.jine = self:GetText()
                BG.ChatAccountingFrame:SureButtonUpdate()
            end)
            edit:SetScript("OnEnterPressed", function()
                BG.ChatAccountingFrame:SureOnClick()
            end)
            edit:SetScript("OnTabPressed", function()
                BG.ChatAccountingFrame.qiankuanFrame:SetFocus()
            end)
            edit:SetScript("OnMouseDown", function(self, button)
                if button == "RightButton" then
                    self:SetEnabled(false)
                    self:SetText("")
                    if self:HasFocus() then
                        self:ClearFocus()
                    end
                end
            end)
            edit:SetScript("OnMouseUp", function(self, button)
                self:SetEnabled(true)
            end)
            edit:SetScript("OnEditFocusGained", function(self)
                local f = BG.CreateNumFrame(BG.ChatAccountingFrame)
                if f then
                    f:ClearAllPoints()
                    f:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOMLEFT", 2, 0)
                end
            end)
            edit:SetScript("OnEditFocusLost", function(self, button)
                edit:ClearHighlightText()
                BG.After(0, function()
                    if BG.ChatAccountingFrame.clickChat then
                        edit:SetFocus()
                        edit:ClearHighlightText()
                    end
                end)
                if BG.FrameNumFrame then
                    BG.FrameNumFrame:Hide()
                end
            end)

            local t = BG.ChatAccountingFrame.jineFrame:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("RIGHT", BG.ChatAccountingFrame.jineFrame, "LEFT", -10, 0)
            t:SetTextColor(RGB("FFD100"))
            t:SetText(L["金额："])
        end

        -- 欠款
        do
            local edit = CreateFrame("EditBox", nil, BG.ChatAccountingFrame, "InputBoxTemplate")
            edit:SetSize(120, 20)
            edit:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOMRIGHT", -40, 60)
            edit:SetAutoFocus(false)
            edit:SetNumeric(true)
            edit:SetTextColor(1, 0, 0)
            BG.ChatAccountingFrame.qiankuanFrame = edit
            edit:SetScript("OnTextChanged", function(self)
                BG.UpdateTwo0(self)
                BG.ChatAccountingFrame.qiankuan = self:GetText()
                BG.ChatAccountingFrame:SureButtonUpdate()
            end)
            edit:SetScript("OnEnterPressed", function()
                BG.ChatAccountingFrame:SureOnClick()
            end)
            edit:SetScript("OnTabPressed", function()
                BG.ChatAccountingFrame.jineFrame:SetFocus()
            end)
            edit:SetScript("OnMouseDown", function(self, button)
                if button == "RightButton" then
                    self:SetEnabled(false)
                    self:SetText("")
                    if self:HasFocus() then
                        self:ClearFocus()
                    end
                end
            end)
            edit:SetScript("OnMouseUp", function(self, button)
                self:SetEnabled(true)
            end)
            edit:SetScript("OnEditFocusGained", function(self)
                local f = BG.CreateNumFrame(BG.ChatAccountingFrame)
                if f then
                    f:ClearAllPoints()
                    f:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOMLEFT", 2, 0)
                end
            end)
            edit:SetScript("OnEditFocusLost", function(self, button)
                edit:ClearHighlightText()
                BG.After(0, function()
                    if BG.ChatAccountingFrame.clickChat then
                        edit:SetFocus()
                        edit:ClearHighlightText()
                    end
                end)
                if BG.FrameNumFrame then
                    BG.FrameNumFrame:Hide()
                end
            end)

            local t = BG.ChatAccountingFrame.qiankuanFrame:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("RIGHT", BG.ChatAccountingFrame.qiankuanFrame, "LEFT", -10, 0)
            t:SetTextColor(RGB("FFD100"))
            t:SetText(L["欠款："])
        end

        -- 确定/取消
        do
            local function GetJinE(jine)
                if jine and jine ~= "" then
                    return jine
                end
                return 0
            end
            function BG.ChatAccountingFrame:SureOnClick()
                if not self.sureButton:IsEnabled() then return end
                local b, i, zhuangbei, maijia, jine, FB = HasEmptyGeZi(self.itemLink)
                if b then
                    maijia:SetText(self.maijia or "")
                    maijia:SetTextColor(unpack(self.color or { 1, 1, 1 }))
                    jine:SetText(GetJinE(self.jine))
                    BiaoGe[FB]["boss" .. b]["maijia" .. i] = self.maijia
                    BiaoGe[FB]["boss" .. b]["jine" .. i] = GetJinE(self.jine)
                    for k, v in pairs(BG.playerClass) do
                        BiaoGe[FB]["boss" .. b][k .. i] = self[k]
                    end

                    local Texture = select(10, GetItemInfo(self.itemLink))

                    local maijiaText = SetClassCFF(self.maijia or "")
                    if maijiaText == "" then
                        maijiaText = BG.STC_y2(L["无"])
                    end

                    local jineText = "|cffFFD700" .. 0 .. "|rg"
                    if self.jine ~= "" then
                        jineText = "|cffFFD700" .. self.jine .. "|rg"
                    end

                    local qiankuantext = ""
                    if self.qiankuan ~= "" then
                        BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = self.qiankuan
                        BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Show()
                        qiankuantext = format("|cffFF0000" .. L["（欠款%d）"] .. RR, self.qiankuan)
                    end
                    self:Hide()

                    if BiaoGe.options["fastCountMsg"] == 1 then
                        local text = format(L["|cff00BFFF< 快速记账成功 >|r\n|cffFFFFFF装备：%s\n买家：%s\n金额：%s%s\n表格：%s\nBoss：%s"],
                            (AddTexture(Texture) .. self.itemLink),
                            maijiaText,
                            jineText,
                            qiankuantext,
                            BG.GetFBinfo(FB, "localName"),
                            "|cff" .. BG.Boss[FB]["boss" .. b]["color"] .. BG.Boss[FB]["boss" .. b]["name2"] .. RR)
                        BG.FrameTradeMsg:AddMessage(text)
                    end
                    return
                end
                JiZhangError(self.itemLink)
            end

            function BG.ChatAccountingFrame:SureButtonUpdate()
                if self.maijia or self.jine ~= "" then
                    self.sureButton:Enable()
                else
                    self.sureButton:Disable()
                end
                UpdateSeeText()
            end

            local bt = CreateFrame("Button", nil, BG.ChatAccountingFrame, "UIPanelButtonTemplate")
            bt:SetSize(150, 25)
            bt:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOM", -10, 20)
            bt:SetText(L["确定"])
            BG.ChatAccountingFrame.sureButton = bt
            bt:SetScript("OnClick", function(self)
                BG.ChatAccountingFrame:SureOnClick()
                BG.PlaySound(1)
            end)
            local bt = CreateFrame("Button", nil, BG.ChatAccountingFrame, "UIPanelButtonTemplate")
            bt:SetSize(150, 25)
            bt:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOMRIGHT", -40, 20)
            bt:SetText(L["取消"])
            bt:SetScript("OnClick", function(self)
                BG.ChatAccountingFrame:Hide()
                BG.PlaySound(1)
            end)
        end

        -- 预览框
        do
            local f = CreateFrame("Frame", nil, BG.ChatAccountingFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            f:SetBackdropColor(0, 0, 0, 0.7)
            f:SetBackdropBorderColor(0, 0, 0, 1)
            f:SetSize(200, 200)
            f:SetPoint("BOTTOMLEFT", BG.ChatAccountingFrame, "BOTTOMRIGHT", -2, 5)
            f:EnableMouse(true)
            BG.ChatAccountingFrame.seeFrame = f

            local text = f:CreateFontString()
            text:SetPoint("TOP", f, "TOP", 0, -10)
            text:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
            text:SetText(L["记账效果预览"])

            local text = f:CreateFontString()
            text:SetPoint("TOPLEFT", f, "TOPLEFT", 8, -45)
            text:SetWidth(f:GetWidth() - 10)
            text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            text:SetJustifyH("LEFT") -- 对齐格式
            BG.ChatAccountingFrame.seeText = text
        end

        hooksecurefunc("SetItemRef", function(link, text, button)
            if BG.IsML then return end -- 如果是团长或物品分配者则退出
            if BiaoGe.options["fastCount"] ~= 1 then return end
            local _type, name, line, chattype = strsplit(":", link)
            if _type == "item" then
                if button == "RightButton" then
                    local item, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
                    if not link then return end
                    if ItemRefTooltip:IsVisible() then
                        ItemRefTooltip:Hide()
                    end
                    local b, i, zhuangbei, maijia, jine, FB = HasEmptyGeZi(link)
                    if b then
                        BG.ChatAccountingFrame.itemLink = link
                        BG.ChatAccountingFrame:Hide()
                        BG.ChatAccountingFrame:Show()
                        GameTooltip:Hide()

                        local f = BG.Create_BlinkHilight(zhuangbei)
                        f:SetPoint("TOPLEFT", zhuangbei, "TOPLEFT", -80, 5)
                        f:SetPoint("BOTTOMRIGHT", jine, "BOTTOMRIGHT", 90, -5)
                        BG.ChatAccountingFrame.BlinkHilight = f
                        return
                    end
                    JiZhangError(link)
                end
            elseif _type == "player" and chattype == "RAID" and BG.ChatAccountingFrame:IsVisible() then
                BG.ChatAccountingFrame.clickChat = true
                BG.After(0.1, function()
                    BG.ChatAccountingFrame.clickChat = false
                end)
                ChatFrame1EditBox:Hide()
                ChatFrame1EditBox:SetText("")

                name = strsplit("-", name)
                local num
                local raid = BG.raidRosterInfo
                for i, v in ipairs(raid) do
                    if v.name == name then
                        num = i
                        break
                    end
                end
                if num then
                    for i, _bt in ipairs(BG.ChatAccountingFrame.buttons) do
                        _bt.Left:SetVertexColor(1, 1, 1)
                        _bt.Right:SetVertexColor(1, 1, 1)
                        _bt.Middle:SetVertexColor(1, 1, 1)
                        _bt.choose:Hide()
                    end
                    if BG.ChatAccountingFrame.maijia == name then
                        BG.ChatAccountingFrame.maijia = nil
                        for k, v in pairs(BG.playerClass) do
                            BG.ChatAccountingFrame[k] = nil
                        end
                    else
                        BG.ChatAccountingFrame.maijia = name
                        for k, v in pairs(BG.playerClass) do
                            BG.ChatAccountingFrame[k] = raid[num][k]
                        end
                        for i, _bt in ipairs(BG.ChatAccountingFrame.buttons) do
                            if GetText_T(_bt) == name then
                                _bt.Left:SetVertexColor(0, 1, 0)
                                _bt.Right:SetVertexColor(0, 1, 0)
                                _bt.Middle:SetVertexColor(0, 1, 0)
                                _bt.choose:Show()
                            end
                        end
                    end
                    BG.ChatAccountingFrame:SureButtonUpdate()
                    BG.PlaySound(1)
                end
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
            local player = UnitName("player")
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
                    PlaySoundFile(BG["sound_countDownStop" .. BiaoGe.options.Sound], "Master")
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
        f:SetScript("OnEvent", function(self, even, msg)
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
            if _type == "item" and button == "RightButton" then
                local item, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
                BG.StartCountDown(link)
            end
        end)
    end
    ----------清空表格----------
    do
        function BG.ClearBiaoGe(_type, FB)
            if not FB then return end
            if _type == "biaoge" then
                for b = 1, Maxb[FB] do
                    for i = 1, Maxi[FB] + 10 do
                        -- 表格
                        if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                            BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:SetText("")
                            BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetText("")
                            BG.Frame[FB]["boss" .. b]["jine" .. i]:SetText("")
                            BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Hide()
                            BG.Frame[FB]["boss" .. b]["guanzhu" .. i]:Hide()
                        end
                        BiaoGe[FB]["boss" .. b]["zhuangbei" .. i] = nil
                        BiaoGe[FB]["boss" .. b]["maijia" .. i] = nil
                        BiaoGe[FB]["boss" .. b]["jine" .. i] = nil
                        BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = nil
                        BiaoGe[FB]["boss" .. b]["guanzhu" .. i] = nil
                        BiaoGe[FB]["boss" .. b]["loot" .. i] = nil
                        for k, v in pairs(BG.playerClass) do
                            BiaoGe[FB]["boss" .. b][k .. i] = nil
                        end
                        -- 对账
                        if BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i] then
                            BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]:SetText("")
                            BG.DuiZhangFrame[FB]["boss" .. b]["myjine" .. i]:SetText("")
                        end
                    end
                    if BG.Frame[FB]["boss" .. b]["time"] then
                        BG.Frame[FB]["boss" .. b]["time"]:SetText("")
                        BiaoGe[FB]["boss" .. b]["time"] = nil
                    end
                end
                for i = 1, Maxi[FB] + 10 do -- 清空支出
                    if BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i] then
                        if BiaoGe.options["retainExpenses"] ~= 1 then
                            BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i]:SetText("")
                            BiaoGe[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i] = nil
                        end
                        if not (BiaoGe.options["retainExpenses"] == 1 and BiaoGe.options["retainExpensesMoney"] == 1) then
                            BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]:SetText("")
                            BiaoGe[FB]["boss" .. Maxb[FB] + 1]["jine" .. i] = nil
                        end
                        BG.Frame[FB]["boss" .. Maxb[FB] + 1]["maijia" .. i]:SetText("")
                        BiaoGe[FB]["boss" .. Maxb[FB] + 1]["maijia" .. i] = nil
                    end
                end
                BiaoGe[FB].tradeTbl = {}
                BiaoGe[FB].lockoutIDtbl = nil
                BiaoGe[FB].raidRoster = nil
                BiaoGe[FB].auctionLog = nil
                BG.UpdateAuctionLogFrame()
                BG.UpdateLockoutIDText()
                BG.auctionLogFrame.changeFrame:Hide()

                local num -- 分钱人数
                if BG.IsVanilla then
                    num = BG.GetFBinfo(FB, "maxplayers") or 10
                else
                    num = 25
                    local nanduID = GetRaidDifficultyID()
                    if nanduID == 3 or nanduID == 175 then
                        num = BiaoGe.options["10MaxPlayers"] or 10
                    elseif nanduID == 4 or nanduID == 176 then
                        num = BiaoGe.options["25MaxPlayers"] or 25
                    elseif nanduID == 5 or nanduID == 193 then
                        num = BiaoGe.options["10MaxPlayers"] or 10
                    elseif nanduID == 6 or nanduID == 194 then
                        num = BiaoGe.options["25MaxPlayers"] or 25
                    end
                end
                if BiaoGe.options["QingKongPeople"] == 1 then
                    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:SetText(num)
                    BiaoGe[FB]["boss" .. Maxb[FB] + 2]["jine4"] = num
                end

                local money = floor(GetMoney() / 1e4)
                BiaoGe.clearBiaoGeMoney = BiaoGe.clearBiaoGeMoney or {}
                BiaoGe.clearBiaoGeMoney[FB] = {
                    FB = FB,
                    realmID = realmID,
                    name = player,
                    money = money,
                    time = GetServerTime()
                }
                BG.UpdateButtonClearBiaoGeMoney()
                return num
            elseif _type == "hope" then
                for n = 1, 4 do
                    for b = 1, Maxb[FB] - 1 do
                        for i = 1, HopeMaxi do
                            if BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] then
                                BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]:SetText("")
                                BiaoGe.Hope[realmID][player][FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] = nil
                            end
                        end
                    end
                end
                BG.UpdateItemLib_LeftHope_HideAll()
                BG.UpdateItemLib_RightHope_HideAll()
            end
        end

        -- 清空按钮
        do
            local bt = CreateFrame("Button", nil, BG.FBMainFrame, "UIPanelButtonTemplate")
            bt:SetSize(120, BG.ButtonZhangDan:GetHeight())
            bt:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 30, select(5, BG.ButtonZhangDan:GetPoint()))
            bt:SetText(L["清空表格"])
            BG.ButtonQingKong = bt
            -- 按钮触发
            bt:SetScript("OnClick", function()
                StaticPopup_Show("QINGKONGBIAOGE")
                BG.PlaySound(1)
            end)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["清空表格"], 1, 1, 1, true)
                GameTooltip:AddLine(L["一键清空全部装备、买家、金额，同时还清空关注和欠款。"], 1, 0.82, 0, true)
                GameTooltip:AddLine(" ", 1, 0.82, 0, true)
                GameTooltip:AddLine(L["如果有自动拍卖记录，则也会被清空。"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            BG.GameTooltip_Hide(bt)

            StaticPopupDialogs["QINGKONGBIAOGE"] = {
                text = L["确定清空表格？"],
                button1 = L["是"],
                button2 = L["否"],
                OnAccept = function()
                    local num = BG.ClearBiaoGe("biaoge", BG.FB1)
                    if not BG.IsVanilla and BiaoGe.options["QingKongPeople"] == 1 then
                        BG.SendSystemMessage(BG.STC_b1(format(
                            L["已清空表格< %s >，分钱人数已改为%s人。"], BG.GetFBinfo(BG.FB1, "localName"), num)))
                    else
                        BG.SendSystemMessage(BG.STC_b1(format(
                            L["已清空表格< %s >。"], BG.GetFBinfo(BG.FB1, "localName"))))
                    end
                    FrameHide(0)
                end,
                OnCancel = function()
                end,
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                showAlert = true,
            }
        end

        -- 自动清空表格
        do
            local lastzone = { zoneID = nil, isInInstance = nil }

            local function IsNotSameTeam(FB)
                if not FB then FB = BG.FB1 end
                -- pt(FB, BiaoGe[FB].raidRoster)
                -- if BiaoGe[FB].raidRoster then
                --     pt(GetServerTime(), BiaoGe[FB].raidRoster.time, GetServerTime() - BiaoGe[FB].raidRoster.time >= 86400 * 1)
                --     pt(GetRealmName(), BiaoGe[FB].raidRoster.realm, GetRealmName() ~= BiaoGe[FB].raidRoster.realm)
                -- end

                if not IsInRaid(1) then return true end
                -- 没有历史成员名单
                if not BiaoGe[FB].raidRoster then return true end
                -- 超过x天了
                if GetServerTime() - BiaoGe[FB].raidRoster.time >= 86400 * 1 then return true end
                -- 服务器不同
                if GetRealmName() ~= BiaoGe[FB].raidRoster.realm then return true end

                local maxCount = max(#BG.raidRosterInfo, #BiaoGe[FB].raidRoster.roster)
                local sameCount = 0
                for ii, vv in ipairs(BG.raidRosterInfo) do
                    for i, name in ipairs(BiaoGe[FB].raidRoster.roster) do
                        if vv.name == name then
                            sameCount = sameCount + 1
                        end
                    end
                end
                -- pt(sameCount, maxCount, sameCount / maxCount < 0.6)
                if sameCount / maxCount < 0.6 then
                    return true
                end
                return false
            end
            BG.IsNotSameTeam = IsNotSameTeam

            local f = CreateFrame("Frame")
            f:RegisterEvent("ZONE_CHANGED")
            f:RegisterEvent("ZONE_CHANGED_INDOORS")
            f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
            f:SetScript("OnEvent", function(self, even, ...)
                if BiaoGe.options["autoQingKong"] ~= 1 then return end
                RequestRaidInfo()

                BG.After(4, function()
                    local _, _, _, _, maxPlayers, _, _, instanceID = GetInstanceInfo()
                    local zoneID = instanceID
                    local isInInstance = IsInInstance()
                    local FB = BG.FBIDtable[instanceID]
                    if FB then
                        -- 如果上一个区域和当前区域id相同且都在副本里（比如在副本里切换子区域）
                        if lastzone.zoneID == zoneID and lastzone.isInInstance and isInInstance then
                            return
                        end
                        if
                        -- 上一个区域和当前区域id相同，且上一个区域不在副本里（比如诺莫瑞根进本时）
                            (lastzone.zoneID == zoneID and not lastzone.isInInstance)
                            -- 上一个区域与当前区域id不相同，且当前区域在副本里（比如黑暗深渊进本）
                            or (lastzone.zoneID ~= zoneID)
                        then
                            local newCD = true
                            for i = 1, GetNumSavedInstances() do
                                local _, _, _, _, locked, _, _, _, _maxPlayers, _, _, _, _, _instanceID = GetSavedInstanceInfo(i)
                                if locked and (instanceID == _instanceID) and (maxPlayers == _maxPlayers) then
                                    newCD = false
                                    break
                                end
                            end

                            -- 如果是新CD
                            if newCD then
                                -- 有这些场景：1 打完NAXX，然后进黑龙（不要清空表格）。2 上CD打过黑龙 这CD进NAXX

                                -- 如果当前副本对应的BOSS格子有东西（除了杂项） 就清空整个表格
                                -- 如果当前副本对应的BOSS格子没东西但其他格子有东西，且当前团队成员跟当前副本的历史成员名单不同 就清空整个表格
                                if BG.BiaoGeIsHavedItem(FB, "autoQingKong", instanceID) or
                                    (BG.BiaoGeIsHavedItem(FB, "onlyboss") and IsNotSameTeam(FB))
                                then
                                    BG.ClickFBbutton(FB)
                                    BG.SaveBiaoGe(FB)
                                    local num = BG.ClearBiaoGe("biaoge", FB)
                                    local link = "|cffFFFF00|Hgarrmission:" .. "BiaoGe:" .. L["撤回清空"] .. ":" .. FB .. ":" .. GetServerTime() ..
                                        "|h[" .. L["撤回清空"] .. "]|h|r"
                                    SendSystemMessage(BG.STC_b1(format(L["<BiaoGe> 已自动清空表格< %s >，分钱人数已改为%s人。原表格数据已保存至历史表格1。"], BG.GetFBinfo(FB, "localName"), num)) .. link)
                                    PlaySoundFile(BG["sound_qingkong" .. BiaoGe.options.Sound], "Master")
                                end
                            end
                        end
                    end

                    lastzone.zoneID = zoneID
                    lastzone.isInInstance = isInInstance
                end)
            end)

            local clicked = {}
            hooksecurefunc("SetItemRef", function(link)
                local _, biaoge, cehui, FB, time = strsplit(":", link)
                if not (biaoge == "BiaoGe" and cehui == L["撤回清空"] and FB) then return end
                if not clicked[time] then
                    clicked[time] = true
                    BG.SetBiaoGeFormHistory(FB, 1)
                    BG.DeleteHistory(FB, 1)
                    SendSystemMessage(BG.STC_b1(L["<BiaoGe> 已撤回清空，还原了表格数据，并删除了历史表格1。"]))
                    PlaySoundFile(BG["sound_cehuiqingkong" .. BiaoGe.options.Sound], "Master")
                    BG.PlaySound(1)
                else
                    SendSystemMessage(BG.STC_b1(L["<BiaoGe>"]) .. " " .. BG.STC_r1(L["只能撤回一次。"]))
                end
            end)
        end

        -- 清空时记录身上金币
        do
            local poit

            local function OnEnter(self)
                local FB = BG.FB1
                local p = SetClassCFF(BiaoGe.clearBiaoGeMoney[FB].name)
                local f = BG.GetFBinfo(BiaoGe.clearBiaoGeMoney[FB].FB, "localName")
                local t = date("%m/%d %H:%M", BiaoGe.clearBiaoGeMoney[FB].time)
                local m = GetMoneyString(BiaoGe.clearBiaoGeMoney[FB].money .. "0000")
                GameTooltip:SetOwner(poit, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["清空表格时携带的金币"], 1, 1, 1, true)
                GameTooltip:AddLine(" ")
                GameTooltip:AddDoubleLine(L["角色："], p, 1, 0.82, 0, 1, 0.82, 0)
                GameTooltip:AddDoubleLine(L["表格："], f, 1, 0.82, 0, 1, 0.82, 0)
                GameTooltip:AddDoubleLine(L["时间："], t, 1, 0.82, 0, 1, 0.82, 0)
                GameTooltip:AddDoubleLine(L["金币："], m, 1, 0.82, 0, 1, 0.82, 0)
                GameTooltip:Show()
            end

            function BG.UpdateButtonClearBiaoGeMoney()
                local FB = BG.FB1
                local f = BG.ButtonClearBiaoGeMoney
                if not (BiaoGe.clearBiaoGeMoney and BiaoGe.clearBiaoGeMoney[FB]) or
                    not (BiaoGe.clearBiaoGeMoney[FB].realmID == realmID and
                        BiaoGe.clearBiaoGeMoney[FB].name == player and
                        GetServerTime() - BiaoGe.clearBiaoGeMoney[FB].time <= 3600 * 24) then
                    f:Hide()
                else
                    f:Show()
                    local jine = BG.Frame[FB]["boss" .. Maxb[FB] + 2].jine5
                    f:ClearAllPoints()
                    f:SetPoint("TOPLEFT", jine, "BOTTOMLEFT", 0, -2)
                    f.Text:SetText(BiaoGe.clearBiaoGeMoney[FB].money)
                end
            end

            local jine = BG.Frame[BG.FB1]["boss" .. Maxb[BG.FB1] + 2].jine5
            local f = CreateFrame("Frame", nil, BG.FBMainFrame, "BackdropTemplate")
            f:SetSize(jine:GetWidth(), 20)
            BG.ButtonClearBiaoGeMoney = f
            local t = f:CreateFontString()
            t:SetFontObject(ChatFontNormal)
            t:SetAllPoints()
            t:SetJustifyH("LEFT")
            t:SetTextColor(1, .82, 0)
            f.Text = t
            f:SetScript("OnEnter", OnEnter)
            f:SetScript("OnLeave", GameTooltip_Hide)

            local f = CreateFrame("Frame", nil, BG.ButtonClearBiaoGeMoney, "BackdropTemplate")
            f:SetSize(0, 20)
            f:SetPoint("RIGHT", BG.ButtonClearBiaoGeMoney, "LEFT", 0, 0)
            poit = f
            local t = f:CreateFontString()
            t:SetFontObject(ChatFontNormal)
            t:SetAllPoints()
            t:SetJustifyH("RIGHT")
            t:SetTextColor(1, .82, 0)
            t:SetText(L["清空表格时的金币： "])
            f:SetWidth(t:GetUnboundedStringWidth())
            f.Text = t
            f:SetScript("OnEnter", OnEnter)
            f:SetScript("OnLeave", GameTooltip_Hide)

            BG.UpdateButtonClearBiaoGeMoney()
        end

        -- 清空心愿
        do
            local bt = CreateFrame("Button", nil, BG.HopeMainFrame, "UIPanelButtonTemplate")
            bt:SetSize(120, BG.ButtonZhangDan:GetHeight())
            bt:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 30, select(5, BG.ButtonZhangDan:GetPoint()))
            bt:SetText(L["清空心愿"])
            BG.ButtonHopeQingKong = bt
            -- 按钮触发
            bt:SetScript("OnClick", function()
                StaticPopup_Show("QINGKONGXINYUAN")
                BG.PlaySound(1)
            end)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["清空心愿"], 1, 1, 1, true)
                GameTooltip:AddLine(L["一键清空全部心愿装备"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            BG.GameTooltip_Hide(bt)

            StaticPopupDialogs["QINGKONGXINYUAN"] = {
                text = L["确定清空心愿？"],
                button1 = L["是"],
                button2 = L["否"],
                OnAccept = function()
                    BG.ClearBiaoGe("hope", BG.FB1)
                    SendSystemMessage(BG.STC_g1(format(L["已清空心愿< %s >"], BG.GetFBinfo(BG.FB1, "localName"))))
                    FrameHide(0)
                end,
                OnCancel = function()
                end,
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                showAlert = true,
            }
        end
    end
    ----------撤销删除----------
    do
        local bt = CreateFrame("Button", nil, BG.FBMainFrame, "UIPanelButtonTemplate")
        bt:SetSize(80, 30)
        bt:SetPoint("RIGHT", BG.ButtonZhangDan, "LEFT", -80, 0)
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

        local tex = bt:CreateTexture(nil, "BACKGROUND", nil, -5)
        tex:SetSize(bt:GetWidth() + 30, bt:GetHeight() + 10)
        tex:SetPoint("CENTER")
        tex:SetTexture("Interface/ChatFrame/UI-ChatIcon-BlinkHilight")
    end
    ----------鼠标材质----------
    BG.RegisterEvent("MODIFIER_STATE_CHANGED", function(self, even, mod, type)
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

    ----------初始显示----------
    do
        if BiaoGe.lastFrame and BG[BiaoGe.lastFrame .. "MainFrameTabNum"] then
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
            ver = ver:gsub("j", 10)
            ver = ver:gsub("k", 11)
            ver = ver:gsub("l", 12)
            ver = ver:gsub("m", 13)
            ver = ver:gsub("n", 14)
            ver = ver:gsub("o", 15)
            ver = ver:gsub("%D", "")
            ver = tonumber(ver)
            return ver
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
        f:SetScript("OnEvent", function(self, even, ...)
            if even == "CHAT_MSG_ADDON" then
                local prefix, msg, channel, sender = ...
                if not (prefix == "BiaoGe" and channel == "GUILD") then return end
                local sendername = strsplit("-", sender)
                local playername = UnitName("player")
                if msg == "VersionCheck" and not CDing[sender] and not IsTestVer() then
                    C_ChatInfo.SendAddonMessage("BiaoGe", "MyVer-" .. BG.ver, channel)
                    CDing[sender] = true
                    BG.After(2, function() -- 间隔x秒发一次
                        CDing[sender] = nil
                    end)
                elseif strfind(msg, "MyVer") and not close then
                    local _, version = strsplit("-", msg)
                    if VerGuoQi(BG.ver, version) then
                        SendSystemMessage("|cff00BFFF" .. format(L["< BiaoGe > 你的当前版本%s已过期，请更新插件。"] .. RR, BG.STC_r1(BG.ver)))
                        BG.ShuoMingShuText:SetText(L["<说明书>"] .. " " .. BG.STC_r1(BG.ver))
                        close = true
                    end
                end
            elseif even == "PLAYER_ENTERING_WORLD" then
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
    end
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
                    name = strsplit("-", name)
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
                    if name == UnitName("player") and (rank == 2 or isML) then
                        BG.IsML = true
                    end
                    if name == UnitName("player") and (rank == 2) then
                        BG.IsLeader = true
                    end

                    BG.raidRosterGUID[UnitGUID("raid" .. i)] = name
                    BG.raidRosterName[name] = true
                    BG.raidRosterIsOnline[name] = online
                end
            end
        elseif IsInGroup(1) then
            for i = 1, GetNumGroupMembers() do
                local name = UnitName("party" .. i)
                local _, class = UnitClass("party" .. i)
                local a = { name = name, class = class }
                table.insert(BG.groupRosterInfo, a)
            end
        end
    end

    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:SetScript("OnEvent", function(self, even, ...)
        local isLogin, isReload = ...
        if not (isLogin or isReload) then return end
        C_Timer.After(1, function()
            BG.UpdateRaidRosterInfo()
        end)
    end)
    local f = CreateFrame("Frame")
    f:RegisterEvent("GROUP_ROSTER_UPDATE")
    f:SetScript("OnEvent", function(self, even, ...)
        C_Timer.After(0.5, function()
            BG.UpdateRaidRosterInfo()
        end)
    end)

    C_Timer.NewTicker(3, function() -- 每3秒执行一次
        if not BG.raidRosterInfo or not BG.groupRosterInfo then return end
        local num = GetNumGroupMembers(1)
        local max
        if IsInRaid(1) then
            max = #BG.raidRosterInfo
        elseif IsInGroup(1) then
            max = #BG.groupRosterInfo
        end
        if tonumber(num) and tonumber(max) and tonumber(num) ~= tonumber(max) then
            BG.UpdateRaidRosterInfo()
        end
    end)
end

----------其他----------
do
    ----------插件命令----------
    SlashCmdList["BIAOGE"] = function()
        if BG.MainFrame and not BG.MainFrame:IsVisible() then
            BG.MainFrame:Show()
        else
            BG.MainFrame:Hide()
        end
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
        ns.InterfaceOptionsFrame_OpenToCategory("|cff00BFFFBiaoGe|r")
        BG.MainFrame:Hide()
    end
    SLASH_BIAOGEOPTIONS1 = "/bgo"
end

--DEBUG
do
    local yes, yes2, yes3
    SlashCmdList["BIAOGETEST"] = function()
        BG.DeBug = true
        local CDing
        if not yes and AtlasLoot then
            yes = true
            function AtlasLoot.Button:AddChatLink(link)
                if CDing then return end
                if ChatFrameEditBox and ChatFrameEditBox:IsVisible() then
                    ChatFrameEditBox:Insert(link)
                else
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    ChatEdit_InsertLink(link)
                end
            end

            for i = 1, 40 do
                if _G["AtlasLoot_Button_" .. i] then
                    local script = _G["AtlasLoot_Button_" .. i]:GetScript("OnClick")
                    _G["AtlasLoot_Button_" .. i]:SetScript("OnClick", function(self, button)
                        if IsShiftKeyDown() and self.ItemID then
                            CDing = true
                            BG.After(0, function()
                                CDing = false
                            end)
                            ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                            ChatFrame1EditBox:ClearHighlightText()
                            ChatEdit_InsertLink(self.ItemID .. ",")
                            ChatFrame1EditBox:HighlightText()
                            BG.PlaySound(1)
                            return
                        end
                        script(self, button)
                    end)
                end
            end
        end

        if AtlasLoot then
            for i = 1, 40 do
                if _G["AtlasLoot_SecButton_" .. i] then
                    local script = _G["AtlasLoot_SecButton_" .. i]:GetScript("OnClick")
                    _G["AtlasLoot_SecButton_" .. i]:SetScript("OnClick", function(self, button)
                        if IsShiftKeyDown() and self.ItemID then
                            CDing = true
                            BG.After(0, function()
                                CDing = false
                            end)
                            ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                            ChatFrame1EditBox:ClearHighlightText()
                            ChatEdit_InsertLink(self.ItemID .. ",")
                            ChatFrame1EditBox:HighlightText()
                            BG.PlaySound(1)
                            return
                        end
                        script(self, button)
                    end)
                end
            end
        end

        if not yes3 and AtlasQuestInsideFrame then
            for i = 1, 6 do
                if _G["AtlasQuestItemframe" .. i] then
                    yes3 = true
                    local script = _G["AtlasQuestItemframe" .. i]:GetScript("OnClick")
                    _G["AtlasQuestItemframe" .. i]:SetScript("OnClick", function(self, button)
                        if IsShiftKeyDown() and self:IsVisible() then
                            CDing = true
                            BG.After(0, function()
                                CDing = false
                            end)
                            local itemID
                            if (Allianceorhorde == 1) then
                                itemID = getglobal("Inst" .. AQINSTANZ .. "Quest" .. AQSHOWNQUEST .. "ID" .. AQTHISISSHOWN)
                            else
                                itemID = getglobal("Inst" .. AQINSTANZ .. "Quest" .. AQSHOWNQUEST .. "ID" .. AQTHISISSHOWN .. "_HORDE")
                            end
                            ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                            ChatFrame1EditBox:ClearHighlightText()
                            ChatEdit_InsertLink(itemID .. ",")
                            ChatFrame1EditBox:HighlightText()
                            BG.PlaySound(1)
                            return
                        end
                        script(self, button)
                    end)
                end
            end
        end


        if IsAddOnLoaded("Blizzard_EncounterJournal") then
            BG.After(0, function()
                ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                ChatFrame1EditBox:SetText("")
                for i = 1, EJ_GetNumLoot() do
                    local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i)
                    ChatEdit_InsertLink(itemInfo.itemID .. ",")
                end
                ChatFrame1EditBox:HighlightText()
                BG.PlaySound(1)
            end)
        end
    end
    SLASH_BIAOGETEST1 = "/bgdebug"

    SlashCmdList["BIAOGETEST2"] = function()
        local f, edit = BG.CreateScrollFrame(UIParent, 400, 500, true)
        f:SetPoint("CENTER")
        edit:EnableMouse(true)
        edit:SetScript("OnEscapePressed", function(self)
            f:Hide()
        end)

        local colortbl = {
            ["0.67.0.83.0.45"] = "猎人",
            ["0.53.0.53.0.93"] = "术士",
            ["1.1.1"] = "牧师",
            ["0.96.0.55.0.73"] = "圣骑士",
            ["0.25.0.78.0.92"] = "法师",
            ["1.0.96.0.41"] = "盗贼",
            ["1.0.49.0.04"] = "德鲁伊",
            ["0.0.44.0.87"] = "萨满",
            ["0.78.0.61.0.43"] = "战士",
            ["0.77.0.12.0.23"] = "死亡骑士",
            ["0.1.0.59"] = "MONK",
            ["0.64.0.19.0.79"] = "DEMONHUNTER",
        }

        local db = {}
        local FB = "ULD"
        for dt in pairs(BiaoGe.History[FB]) do
            for boss in pairs(BiaoGe.History[FB][dt]) do
                for i = 1, 30 do
                    if BiaoGe.History[FB][dt][boss]["maijia" .. i] then
                        local maijia = BiaoGe.History[FB][dt][boss]["maijia" .. i]
                        if not db[maijia] then
                            local r, g, b = 1, 1, 1
                            if BiaoGe.History[FB][dt][boss]["color" .. i] then
                                r = Round(BiaoGe.History[FB][dt][boss]["color" .. i][1], 2)
                                g = Round(BiaoGe.History[FB][dt][boss]["color" .. i][2], 2)
                                b = Round(BiaoGe.History[FB][dt][boss]["color" .. i][3], 2)
                            end
                            local color = colortbl[r .. "." .. g .. "." .. b]
                            db[maijia] = {
                                maijia = maijia,
                                color = color,
                                sum = 0,
                                zhuangbei = {},
                            }
                        end

                        local item = ""
                        if BiaoGe.History[FB][dt][boss]["zhuangbei" .. i] then
                            item = BiaoGe.History[FB][dt][boss]["zhuangbei" .. i]:match("%[.+%]")
                        end
                        local money = BiaoGe.History[FB][dt][boss]["jine" .. i] or ""
                        if item then
                            db[maijia].sum = db[maijia].sum + (tonumber(money) or 0)
                            tinsert(db[maijia].zhuangbei, {
                                item = item,
                                money = money,
                                dt = strsub(dt, 3, 4) .. "月" .. strsub(dt, 5, 6) .. "日",
                            })
                        end
                    end
                end
            end
        end

        local text = ""
        for maijia in pairs(db) do
            text = text .. maijia .. "," .. db[maijia].color .. ",,合计消费," .. db[maijia].sum .. ",\n"
            for i, v in ipairs(db[maijia].zhuangbei) do
                text = text .. "," .. "," .. v.dt .. "," .. v.item .. "," .. v.money .. ",\n"
            end
        end
        -- pt(Size(db))

        edit:SetText(text)
        edit:HighlightText()
        BG.After(0.5, function()
            edit:SetFocus()
        end)




        -- BiaoGe.AuctionLog["苍骑士仓库"] = BiaoGe.AuctionLog["苍骑士仓库"] or {}
        -- tinsert(BiaoGe.AuctionLog["苍骑士仓库"], {
        --     ["money"] = 50,
        --     ["itemID"] = 43013,
        --     ["time"] = 1723270112,
        --     ["item"] = "|cffffffff|Hitem:43013::::::::1:::::::::|h[冰冷的肉]|h|r",
        -- })
        -- tinsert(BiaoGe.AuctionLog["苍骑士仓库"], {
        --     ["money"] = 50,
        --     ["itemID"] = 34054,
        --     ["time"] = 1723272776,
        --     ["item"] = "|cffffffff|Hitem:34054::::::::1:::::::::|h[无限之尘]|h|r",
        -- })
        -- tinsert(BiaoGe.AuctionLog["苍骑士仓库"], {
        --     ["money"] = 300,
        --     ["item"] = "|cffffffff|Hitem:43013::::::::1:::::::::|h[冰冷的肉]|h|r",
        --     ["itemID"] = 43013,
        --     ["time"] = 1723284569,
        -- })

        -- local addonName = "MeetingHorn"
        -- if IsAddOnLoaded(addonName) then
        --     local MeetingHorn = LibStub("AceAddon-3.0"):GetAddon(addonName)
        --     pt(UnitName("target"), MeetingHorn.db.realm.starRegiment.regimentData[UnitName("target")])
        -- end
        -- if BG.lastAuctionFrame.frame:IsVisible() then
        --     BG.lastAuctionFrame.frame:Hide()
        -- else
        --     BG.lastAuctionFrame.frame:Show()
        -- end

        -- BG.qiankuanTradeFrame.Update()

        local name, link, quality, level, _, _, _, stackCount, _, Texture, _, typeID, subclassID, bindType = GetItemInfo(45087)
        BG.AddLootItem_stackCount(BG.FB1, 15, link, Texture, level, nil, 1, typeID)
        BG.AddLootItem_stackCount(BG.FB1, 15, link, Texture, level, nil, 2, typeID)
    end
    SLASH_BIAOGETEST21 = "/bgdebug2"
end

-- local tex = UIParent:CreateTexture()
-- tex:SetPoint("CENTER")
-- tex:SetSize(310,100)
-- tex:SetAtlas("bags-newitem")
