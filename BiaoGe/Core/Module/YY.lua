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

local pt = print

local YY = "BiaoGeYY"
local Y = {}
Y.lateTime = 0.5      -- 延迟发送评价的秒数
Y.maxHistory = 40     -- 最多保存多少个历史查询记录
Y.maxSearchText = 300 -- 最多接受多少个评价详细
Y.searchLastDay = 360 -- 接收最近多少天内的评价

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName ~= AddonName then return end

    -- 初始化数据库
    do
        if not BiaoGe.YYdb then
            BiaoGe.YYdb = {}
        end
        if not BiaoGe.YYdb.all then
            BiaoGe.YYdb.all = {}
        end
        if not BiaoGe.YYdb.allFilter then
            BiaoGe.YYdb.allFilter = 0
        end
        if not BiaoGe.YYdb.history then
            BiaoGe.YYdb.history = {}
        end
        if not BiaoGe.YYdb.historyEmpty then
            BiaoGe.YYdb.historyEmpty = {}
        end
        if not BiaoGe.YYdb.historyFilter then
            BiaoGe.YYdb.historyFilter = 0
        end
        if not BiaoGe.YYdb.share then
            BiaoGe.YYdb.share = 1
        end
        if not BiaoGe.YYdb.shareCount then
            BiaoGe.YYdb.shareCount = 0
        end
    end

    function Y.CreateLine(parent, y, width, height, color, alpha)
        local l = parent:CreateLine()
        l:SetColorTexture(RGB(color or "808080", alpha or 1))
        l:SetStartPoint("TOPLEFT", 5, y)
        l:SetEndPoint("TOPLEFT", width, y)
        l:SetThickness(height or 1.5)
        return l
    end

    -- 新增评价Frame
    do
        local f = CreateFrame("Frame", nil, BG.YYMainFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetSize(600, 180)
        f:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 25, -55)
        BG.YYMainFrame.new = f

        -- 大标题：新增评价
        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetTextColor(RGB(BG.y2))
        t:SetPoint("BOTTOM", f, "TOP", 0, 2)
        t:SetText(L["< 新增评价 >"])
        t:SetTextColor(1, 1, 1)
        BG.YYMainFrame.new.title = t

        Y.textcolor_table = {} -- 用于根据所选评价给输入框设置相应颜色
        local height = 22      -- 每行高度
        local n = 0

        -- 小标题
        do
            local text_table = {
                { name = "YY:", onenter = L["YY号必填，填写数字"] },
                { name = L["频道名称:"], onenter = L["频道名称选填，方便自己辨认是哪个YY\n该名称不会共享给别人，仅自己可见"] },
                { name = L["评价:"], onenter = L["评价必填，默认中评"] },
                { name = L["理由:"], onenter = L["理由选填"] } }
            for i, _ in ipairs(text_table) do
                local f = CreateFrame("Frame", nil, BG.YYMainFrame.new)
                f:SetPoint("TOPLEFT", 5, -15 - height * (i - 1))
                f:SetSize(90, 20)
                f.Text = f:CreateFontString()
                f.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                f.Text:SetTextColor(RGB(BG.y2))
                f.Text:SetAllPoints()
                f.Text:SetWordWrap(false) -- 截断
                f.Text:SetText(text_table[i].name)
                f.Text:SetTextColor(RGB("FFFF00"))
                f.Text:SetJustifyH("RIGHT")
                tinsert(Y.textcolor_table, f.Text)
                f:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:SetText(text_table[i].onenter)
                end)
                f:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                end)
            end
        end
        -- YY号
        do
            local edit = CreateFrame("EditBox", nil, BG.YYMainFrame.new, "InputBoxTemplate")
            edit:SetSize(150, 20)
            edit:SetPoint("TOPLEFT", 110, -15 - height * n)
            edit:SetAutoFocus(false)
            edit:SetNumeric(true)
            edit:SetTextColor(RGB("FFFF00"))
            tinsert(Y.textcolor_table, edit)
            BG.YYMainFrame.new.yy = edit
            n = n + 1
            local t = edit:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall2")
            t:SetPoint("LEFT", 3, 0)
            t:SetText(L["必填"])
            edit:SetScript("OnEditFocusGained", function(self)
                BG.lastfocus = self
                BG.LiseYY(self)
            end)
            edit:SetScript("OnEditFocusLost", function(self)
                _G.L_DropDownList1:Hide()
            end)
            edit:SetScript("OnTextChanged", function(self)
                if self:GetText() ~= "" then
                    t:Hide()
                else
                    t:Show()
                end
                if not BG.YYMainFrame.new.buttonesc:IsVisible() then
                    for key, value in pairs(BiaoGe.YYdb.all) do
                        if self:GetText() == value.yy then
                            BG.YYMainFrame.new.yy.num = key
                            BG.YYMainFrame.new.buttonrepeat:Show()
                            return
                        end
                    end
                    BG.YYMainFrame.new.yy.num = nil
                    BG.YYMainFrame.new.buttonrepeat:Hide()
                end
            end)
            edit:SetScript("OnKeyDown", function(self, enter)
                if enter == "ENTER" or enter == "TAB" then
                    BG.YYMainFrame.new.name:SetFocus()
                end
            end)
            edit:SetScript("OnMouseDown", function(self, enter)
                -- if BG.YYMainFrame.new.buttonesc:IsVisible() then return end
                if enter == "RightButton" then
                    self:SetEnabled(false)
                    self:SetText("")
                end
            end)
            edit:SetScript("OnMouseUp", function(self, enter)
                -- if BG.YYMainFrame.new.buttonesc:IsVisible() then return end
                if enter == "RightButton" then
                    self:SetEnabled(true)
                end
            end)
        end
        -- 频道名称
        do
            local edit = CreateFrame("EditBox", nil, BG.YYMainFrame.new, "InputBoxTemplate")
            edit:SetSize(150, 20)
            edit:SetPoint("TOPLEFT", 110, -15 - height * n)
            edit:SetAutoFocus(false)
            edit:SetTextColor(RGB("FFFF00"))
            tinsert(Y.textcolor_table, edit)
            BG.YYMainFrame.new.name = edit
            n = n + 1
            local t = edit:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall2")
            t:SetPoint("LEFT", 3, 0)
            t:SetText(L["选填"])
            edit:SetScript("OnEditFocusGained", function(self)
                BG.lastfocus = self
            end)
            edit:SetScript("OnTextChanged", function(self)
                if self:GetText() ~= "" then
                    t:Hide()
                else
                    t:Show()
                end
            end)
            edit:SetScript("OnKeyDown", function(self, enter)
                if enter == "ENTER" or enter == "TAB" then
                    BG.YYMainFrame.new.edit:SetFocus()
                end
            end)
            edit:SetScript("OnMouseDown", function(self, enter)
                if enter == "RightButton" then
                    self:SetEnabled(false)
                    self:SetText("")
                end
            end)
            edit:SetScript("OnMouseUp", function(self, enter)
                if enter == "RightButton" then
                    self:SetEnabled(true)
                end
            end)
        end
        -- 评价
        do
            local PingJiaGroup = CreateFrame("Frame", nil, BG.YYMainFrame.new)
            PingJiaGroup:SetPoint("TOPLEFT", 110, -15 - height * n)
            PingJiaGroup:SetSize(1, 1)
            local numOptions = {
                { name = L["好评"], color = "00FF00" },
                { name = L["中评"], color = "FFFF00" },
                { name = L["差评"], color = "DC143C" },
            }
            BG.YYMainFrame.new.pingjiaButtons = {}
            for i = 1, #numOptions do
                local bt = CreateFrame("CheckButton", nil, PingJiaGroup, "UIRadioButtonTemplate")
                bt:SetPoint("TOPLEFT", ((i - 1) * 60), -3)
                bt:SetSize(18, 18)
                bt:SetHitRectInsets(0, -30, 0, 0)
                if i == 2 then
                    bt:SetChecked(true)
                    BG.YYMainFrame.new.pingjia = i
                end
                BG.YYMainFrame.new.pingjiaButtons[i] = bt

                bt.Text = bt:CreateFontString()
                bt.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                bt.Text:SetTextColor(RGB(BG.y2))
                bt.Text:SetPoint("LEFT", bt, "RIGHT", 0, 0)
                bt.Text:SetText(numOptions[i].name)
                bt.Text:SetTextColor(RGB(numOptions[i].color))

                bt:SetScript("OnClick", function(self)
                    for _, radioButton in ipairs(BG.YYMainFrame.new.pingjiaButtons) do
                        if radioButton ~= self then
                            radioButton:SetChecked(false)
                        end
                    end
                    for _, edit in pairs(Y.textcolor_table) do
                        edit:SetTextColor(RGB(numOptions[i].color))
                    end
                    self:SetChecked(true)
                    BG.YYMainFrame.new.pingjia = i

                    PlaySound(BG.sound1, "Master")
                end)
            end
            n = n + 1
        end
        -- 理由
        do
            local maxbytes = 200
            local f = CreateFrame("Frame", nil, BG.YYMainFrame.new, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 16,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.2)
            f:SetBackdropBorderColor(1, 1, 1, 0.6)
            f:SetSize(420, 80)
            f:SetPoint("TOPLEFT", 105, -17 - height * n)
            local edit = CreateFrame("EditBox", nil, f)
            edit:SetWidth(f:GetWidth())
            edit:SetAutoFocus(false)
            edit:SetMaxBytes(maxbytes)
            edit:EnableMouse(true)
            edit:SetTextInsets(0, 10, 0, 5)
            edit:SetMultiLine(true)
            edit:SetTextColor(RGB("FFFF00"))
            edit:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
            tinsert(Y.textcolor_table, edit)
            BG.YYMainFrame.new.edit = edit
            local s = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
            s:SetWidth(f:GetWidth() - 10)
            s:SetHeight(f:GetHeight() - 10)
            s:SetPoint("CENTER")
            s.ScrollBar.scrollStep = BG.scrollStep
            s:SetScrollChild(edit)
            BG.YYMainFrame.new.scroll = s

            local rightt = f:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall2")
            rightt:SetPoint("BOTTOMRIGHT", -5, 5)
            local leftt = f:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall2")
            leftt:SetPoint("TOPLEFT", 7, -5)
            leftt:SetText(L["选填"])

            edit:SetScript("OnEditFocusGained", function(self)
                BG.lastfocus = self
            end)
            edit:SetScript("OnTextChanged", function(self)
                local len = strlen(self:GetText())
                rightt:SetText(maxbytes - len)

                if self:GetText() ~= "" then
                    leftt:Hide()
                else
                    leftt:Show()
                end
            end)
            edit:SetScript("OnEscapePressed", function(self)
                self:ClearFocus()
            end)
            edit:SetScript("OnEnterPressed", function(self)
                Y.SaveOnClick(self)
            end)
            edit:SetScript("OnMouseDown", function(self, enter)
                if enter == "RightButton" then
                    edit:SetEnabled(false)
                    edit:SetText("")
                else
                    edit:SetFocus()
                end
            end)
            edit:SetScript("OnMouseUp", function(self, enter)
                if enter == "RightButton" then
                    edit:SetEnabled(true)
                end
            end)
            f:SetScript("OnMouseDown", function(self, enter)
                if enter == "RightButton" then
                    edit:SetEnabled(false)
                    edit:SetText("")
                else
                    edit:SetFocus()
                end
            end)
            f:SetScript("OnMouseUp", function(self, enter)
                if enter == "RightButton" then
                    edit:SetEnabled(true)
                end
            end)
        end
        -- 保存
        do
            function Y.SaveOnClick(self)
                local new = BG.YYMainFrame.new
                if not new.pingjia then return end
                if new.yy:GetText() == "" or new.yy:GetText() == 0 then return end
                if BG.YYMainFrame.new.yy.num then return end

                if BG.YYMainFrame.my.all.lastNum then
                    tremove(BiaoGe.YYdb.all, BG.YYMainFrame.my.all.lastNum)
                end
                local a = {
                    date = tonumber(date("%y%m%d")),
                    yy = new.yy:GetText(),
                    name = new.name:GetText(),
                    pingjia = new.pingjia,
                    edit = new.edit:GetText(),
                }
                tinsert(BiaoGe.YYdb.all, 1, a)

                Y.SetAll()
                Y.EscXiuGai()

                PlaySound(BG.sound1, "Master")
            end

            local bt = CreateFrame("Button", nil, BG.YYMainFrame.new, "UIPanelButtonTemplate")
            bt:SetSize(80, 25)
            bt:SetPoint("BOTTOMRIGHT", BG.YYMainFrame.new.scroll, "TOPRIGHT", 0, 7)
            bt:SetText(L["保存评价"])
            BG.YYMainFrame.new.buttonsave = bt
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:SetText(L["|cffffffff< 保存评价 >|r\n\n1、必填项填完才能保存\n2、同一个YY只能写一次评价，但你可以修改之前的评价"])
            end)
            BG.GameTooltip_Hide(bt)
            bt:SetScript("OnClick", Y.SaveOnClick)
        end
        -- 退出修改
        do
            local bt = CreateFrame("Button", nil, BG.YYMainFrame.new, "UIPanelButtonTemplate")
            bt:SetSize(80, 25)
            bt:SetPoint("RIGHT", BG.YYMainFrame.new.buttonsave, "LEFT", -5, 0)
            bt:SetText(L["退出修改"])
            bt:Hide()
            BG.YYMainFrame.new.buttonesc = bt
            bt:SetScript("OnClick", function(self)
                Y.EscXiuGai()
                PlaySound(BG.sound1, "Master")
            end)
            bt:SetScript("OnShow", function(self)
                BG.YYMainFrame.new.buttonrepeat:Hide()
            end)
        end
        -- 修改评价
        do
            local bt = CreateFrame("Button", nil, BG.YYMainFrame.new)
            bt:SetSize(190, 20)
            bt:SetPoint("LEFT", BG.YYMainFrame.new.yy, "RIGHT", 10, 0)
            bt:SetNormalFontObject(BG.FontGreen15)
            bt:SetDisabledFontObject(BG.FontDis15)
            bt:SetHighlightFontObject(BG.FontWhite15)
            bt:SetText(L["该YY已有评价，需要修改吗？"])
            bt:Hide()
            BG.YYMainFrame.new.buttonrepeat = bt
            bt:SetScript("OnClick", function(self)
                Y.XiuGai(self, "new")
                bt:Hide()
                PlaySound(BG.sound1, "Master")
            end)
        end
    end


    -- 我的全部评价Frame
    do
        local height = 20 -- 每行高度
        local n = 0

        local f = CreateFrame("Frame", nil, BG.YYMainFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetSize(BG.YYMainFrame.new:GetWidth(), 470)
        f:SetPoint("TOPLEFT", BG.YYMainFrame.new, "BOTTOMLEFT", 0, -20)
        BG.YYMainFrame.my = f

        -- 大标题：我的评价
        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetTextColor(RGB(BG.y2))
        t:SetPoint("BOTTOM", f, "TOP", 0, 2)
        t:SetText(L["< 我的评价 >"])
        t:SetTextColor(1, 1, 1)

        -- 提示
        local bt = CreateFrame("Button", nil, f)
        bt:SetSize(30, 30)
        bt:SetPoint("LEFT", t, "RIGHT", 0, 0)
        local tex = bt:CreateTexture()
        tex:SetAllPoints()
        tex:SetTexture(616343)
        bt:SetHighlightTexture(616343)
        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:SetText(L["你的评价可以帮助别人辨别该团好与坏\n当其他玩家查询大众评价而你有该YY的评价时，会以匿名的方式发送给对方"])
        end)
        BG.GameTooltip_Hide(bt)

        local title_table = {
            { name = L["序号"], width = 30, color = "FFFFFF" },
            { name = L["日期"], width = 80, color = "FFFFFF" },
            { name = L["YY"], width = 110, color = "FFFFFF" },
            { name = L["频道名称"], width = 90, color = "FFFFFF" },
            { name = L["评价"], width = 40, color = "FFFFFF" },
            { name = L["理由"], width = 210, color = "FFFFFF" },
        }

        -- 标题
        local right
        for i, v in ipairs(title_table) do
            local f = CreateFrame("Frame", nil, BG.YYMainFrame.my)
            f:SetSize(title_table[i].width, 20)
            if i == 1 then
                f:SetPoint("TOPLEFT", 10, -10)
            else
                f:SetPoint("TOPLEFT", right, "TOPRIGHT", 0, 0)
            end
            right = f
            f.Text = f:CreateFontString(nil, "ARTWORK", "GameFontWhite")
            f.Text:SetWidth(f:GetWidth() - 3)
            f.Text:SetPoint("CENTER")
            f.Text:SetText(title_table[i].name)
            f.Text:SetTextColor(RGB(title_table[i].color))
            f.Text:SetWordWrap(false) -- 截断
            if title_table[i].name == L["理由"] then
                f.Text:SetJustifyH("LEFT")
            end
        end
        n = n + 1
        Y.CreateLine(BG.YYMainFrame.my, -n * height - 10, BG.YYMainFrame.my:GetWidth() - 25)

        -- 内容
        local f = CreateFrame("Frame", nil, BG.YYMainFrame.my)
        f:SetSize(1, 1)
        BG.YYMainFrame.my.all = f
        local s = CreateFrame("ScrollFrame", nil, BG.YYMainFrame.my, "UIPanelScrollFrameTemplate")
        s:SetPoint("TOPLEFT", BG.YYMainFrame.my, 0, -height - 10 - 3)
        s:SetPoint("BOTTOMRIGHT", BG.YYMainFrame.my, -27, 5)
        s.ScrollBar.scrollStep = BG.scrollStep
        s:SetScrollChild(f)

        function Y.Pingjia(text)
            local pingjia = text
            if pingjia == 1 then
                pingjia = "|cff00FF00" .. L["好评"] .. RR
            elseif pingjia == 2 then
                pingjia = "|cffFFFF00" .. L["中评"] .. RR
            elseif pingjia == 3 then
                pingjia = "|cffDC143C" .. L["差评"] .. RR
            end
            return pingjia
        end

        function Y.PingjiaColor(text)
            local pingjia = text
            if pingjia == 1 then
                pingjia = "00FF00"
            elseif pingjia == 2 then
                pingjia = "FFFF00"
            elseif pingjia == 3 then
                pingjia = "DC143C"
            end
            return pingjia
        end

        function Y.EscXiuGai()
            if BG.YYMainFrame.my.all.lastHigh then
                BG.YYMainFrame.my.all.lastHigh:Hide()
            end
            BG.YYMainFrame.my.all.lastHigh = nil
            BG.YYMainFrame.my.all.lastNum = nil
            BG.YYMainFrame.new.buttonesc:Hide()
            BG.YYMainFrame.new:SetBackdropBorderColor(1, 1, 1, 1)
            BG.YYMainFrame.new.title:SetText(L["< 新增评价 >"])
            BG.YYMainFrame.new.title:SetTextColor(1, 1, 1, 1)
            BG.YYMainFrame.new.buttonsave:SetText(L["保存评价"])

            BG.YYMainFrame.new.yy:SetText("")
            BG.YYMainFrame.new.name:SetText("")
            BG.YYMainFrame.new.edit:SetText("")
            BG.YYMainFrame.new.pingjia = 2
            BG.YYMainFrame.new.pingjiaButtons[1]:SetChecked(false)
            BG.YYMainFrame.new.pingjiaButtons[2]:SetChecked(true)
            BG.YYMainFrame.new.pingjiaButtons[3]:SetChecked(false)

            -- BG.YYMainFrame.new.yy:SetEnabled(true)

            for _, edit in pairs(Y.textcolor_table) do
                edit:SetTextColor(RGB("FFFF00"))
            end
            BG.ClearFocus()
        end

        function Y.XiuGai(self, new)
            local num
            if new == "new" then
                num = BG.YYMainFrame.new.yy.num
            else
                num = self.num
            end
            if not num then return end
            if BG.YYMainFrame.my.all.lastHigh then
                BG.YYMainFrame.my.all.lastHigh:Hide()
            end
            BG.YYMainFrame.my.all.lastHigh = BG.YYMainFrame.my.all.button[num].dsHigh
            BG.YYMainFrame.my.all.lastHigh:Show()
            BG.YYMainFrame.my.all.lastNum = num
            BG.YYMainFrame.new.buttonesc:Show()
            BG.YYMainFrame.new:SetBackdropBorderColor(RGB("00BFFF", 1))
            BG.YYMainFrame.new.title:SetText(L["< 修改评价 >"])
            BG.YYMainFrame.new.title:SetTextColor(RGB("00BFFF"))
            BG.YYMainFrame.new.buttonsave:SetText(L["保存修改"])

            BG.YYMainFrame.new.yy:SetText(BiaoGe.YYdb.all[num].yy)
            BG.YYMainFrame.new.name:SetText(BiaoGe.YYdb.all[num].name)
            BG.YYMainFrame.new.edit:SetText(BiaoGe.YYdb.all[num].edit)
            BG.YYMainFrame.new.pingjia = BiaoGe.YYdb.all[num].pingjia
            BG.YYMainFrame.new.pingjiaButtons[1]:SetChecked(false)
            BG.YYMainFrame.new.pingjiaButtons[2]:SetChecked(false)
            BG.YYMainFrame.new.pingjiaButtons[3]:SetChecked(false)
            BG.YYMainFrame.new.pingjiaButtons[BiaoGe.YYdb.all[num].pingjia]:SetChecked(true)

            -- BG.YYMainFrame.new.yy:SetEnabled(false)
            BG.YYMainFrame.new.edit:SetFocus()
            BG.YYMainFrame.new.yy.num = nil

            for _, edit in pairs(Y.textcolor_table) do
                edit:SetTextColor(RGB(Y.PingjiaColor(BiaoGe.YYdb.all[num].pingjia)))
            end
        end

        local function OnEnter(self)
            BG.YYMainFrame.my.all.button[self.num].ds:Show()
            if not self.onenter then return end
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self.onenter, 1, 1, 1, true)
            GameTooltip:Show()
        end
        local function OnLeave(self)
            BG.YYMainFrame.my.all.button[self.num].ds:Hide()
            GameTooltip:Hide()
        end
        local function OnMouseDown(self, enter)
            if IsAltKeyDown() and enter == "RightButton" then -- 删除评价
                tremove(BiaoGe.YYdb.all, self.num)
                Y.SetAll()
                Y.EscXiuGai()
            elseif IsShiftKeyDown() and enter == "LeftButton" then -- 查询YY
                BG.YYMainFrame.search.edit:SetText(BiaoGe.YYdb.all[self.num].yy)
                Y.SearchButtonOnClick()
            elseif not IsAltKeyDown() and enter == "LeftButton" then -- 修改评价
                if BG.YYMainFrame.my.all.lastHigh == BG.YYMainFrame.my.all.button[self.num].dsHigh then
                    Y.EscXiuGai()
                else
                    Y.XiuGai(self)
                end
            end
            PlaySound(BG.sound1, "Master")
        end
        function Y.SetAll()
            -- 先隐藏之前的列表内容
            for i, v in pairs(BG.YYMainFrame.my.all.button) do
                v:Hide()
            end
            BG.YYMainFrame.my.all.button = {}
            local n = 1
            -- 再开始创建新的内容
            for ii, _ in ipairs(BiaoGe.YYdb.all) do
                local right
                for i, _ in ipairs(title_table) do
                    local f = CreateFrame("Frame", nil, right or BG.YYMainFrame.my.all)
                    f:SetSize(title_table[i].width, 20)
                    if i == 1 then
                        f:SetPoint("TOPLEFT", BG.YYMainFrame.my.all, "TOPLEFT", 10, -(n - 1) * height)
                        BG.YYMainFrame.my.all.button[ii] = f
                    else
                        f:SetPoint("TOPLEFT", right, "TOPRIGHT", 0, 0)
                    end
                    right = f
                    f.num = ii
                    f.Text = f:CreateFontString(nil, "ARTWORK", "GameFontWhite")
                    f.Text:SetWidth(f:GetWidth() - 3)
                    f.Text:SetPoint("CENTER")

                    local date    = BiaoGe.YYdb.all[ii].date
                    date          = strsub(date, 1, 2) .. "/" .. strsub(date, 3, 4) .. "/" .. strsub(date, 5, 6)
                    local i_table = { ii, date, BiaoGe.YYdb.all[ii].yy, BiaoGe.YYdb.all[ii].name, Y.Pingjia(BiaoGe.YYdb.all[ii].pingjia),
                        BiaoGe.YYdb.all[ii].edit }
                    f.Text:SetText(i_table[i])
                    -- f.Text:SetTextColor(RGB(PingjiaColor(BiaoGe.YYdb.all[ii].pingjia)))
                    f.Text:SetWordWrap(false) -- 截断
                    if f.Text:GetStringWidth() + 5 > f:GetWidth() then
                        f.onenter = i_table[i]
                    end
                    if i == #title_table then
                        f.Text:SetJustifyH("LEFT")
                    end

                    f:SetScript("OnMouseDown", OnMouseDown)
                    f:SetScript("OnEnter", OnEnter)
                    f:SetScript("OnLeave", OnLeave)
                end
                -- 底色材质
                f.ds = f:CreateTexture()
                f.ds:SetPoint("TOPLEFT", BG.YYMainFrame.my.all, "TOPLEFT", 2, -(n - 1) * height)
                f.ds:SetPoint("BOTTOMRIGHT", BG.YYMainFrame.my.all, "BOTTOMRIGHT", BG.YYMainFrame.my:GetWidth(), -n * height)
                f.ds:SetColorTexture(1, 1, 1, 0.1)
                f.ds:Hide()
                BG.YYMainFrame.my.all.button[ii].ds = f.ds
                -- 修改评价的材质
                f.dsHigh = f:CreateTexture()
                f.dsHigh:SetPoint("TOPLEFT", BG.YYMainFrame.my.all, "TOPLEFT", 2, -(n - 1) * height)
                f.dsHigh:SetPoint("BOTTOMRIGHT", BG.YYMainFrame.my.all, "BOTTOMRIGHT", BG.YYMainFrame.my:GetWidth(), -n * height)
                f.dsHigh:SetColorTexture(RGB("00BFFF", 0.2))
                f.dsHigh:Hide()
                BG.YYMainFrame.my.all.button[ii].dsHigh = f.dsHigh

                local l = right:CreateLine()
                l:SetColorTexture(RGB("808080", 0.2))
                l:SetStartPoint("TOPLEFT", BG.YYMainFrame.my.all, 5, -n * height)
                l:SetEndPoint("TOPLEFT", BG.YYMainFrame.my.all, BG.YYMainFrame.my:GetWidth() - 8, -n * height)
                l:SetThickness(1)
                n = n + 1
            end
        end

        BG.YYMainFrame.my.all.button = {}
        Y.SetAll()

        -- 下方的提示文字
        local t = BG.YYMainFrame.my:CreateFontString()
        t:SetPoint("TOP", BG.YYMainFrame.my, "BOTTOM", 0, 0)
        t:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE") -- 游戏主界面文字
        t:SetText(BG.STC_w1(L["（左键修改评价，SHIFT+左键查询大众评价，ALT+右键删除评价）"]))
    end


    -- 查询评价Frame
    do
        local f = CreateFrame("Frame", nil, BG.YYMainFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetSize(BG.YYMainFrame.new:GetWidth(), 670)
        f:SetPoint("TOPLEFT", BG.YYMainFrame.new, "TOPRIGHT", 20, 0)
        BG.YYMainFrame.search = f

        -- 大标题：查询评价
        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetTextColor(RGB(BG.y2))
        t:SetPoint("BOTTOM", f, "TOP", 0, 2)
        t:SetText(L["< 查询大众评价 >"])
        t:SetTextColor(1, 1, 1)

        -- 查询YY
        do
            -- YY
            local f = CreateFrame("Frame", nil, BG.YYMainFrame.search)
            f:SetPoint("TOPLEFT", 0, -15)
            f:SetSize(50, 20)
            f.Text = f:CreateFontString()
            f.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            f.Text:SetTextColor(RGB(BG.y2))
            f.Text:SetAllPoints()
            f.Text:SetWordWrap(false) -- 截断
            f.Text:SetText("YY: ")
            f.Text:SetTextColor(1, 1, 1)
            f.Text:SetJustifyH("RIGHT")
            -- YY输入框
            local edit = CreateFrame("EditBox", nil, BG.YYMainFrame.search, "InputBoxTemplate")
            edit:SetSize(120, 20)
            edit:SetPoint("LEFT", f, "RIGHT", 10, 2)
            edit:SetAutoFocus(false)
            edit:SetNumeric(true)
            edit.Text = f.Text
            BG.YYMainFrame.search.edit = edit
            edit:SetScript("OnEditFocusGained", function(self)
                BG.lastfocus = self
            end)
            edit:SetScript("OnEnterPressed", function(self, enter)
                Y.SearchButtonOnClick()
            end)
            edit:SetScript("OnMouseDown", function(self, enter)
                if enter == "RightButton" then
                    self:SetEnabled(false)
                    self:SetText("")
                end
            end)
            edit:SetScript("OnMouseUp", function(self, enter)
                if enter == "RightButton" then
                    self:SetEnabled(true)
                end
            end)
            -- 查询按钮
            function Y.SearchButtonOnClick()
                if not BG.YYchannelId then
                    local msg = format(L["查询正在初始化，请稍后再试"])
                    UIErrorsFrame:AddMessage(msg, YELLOW_FONT_COLOR:GetRGB())
                    return
                end
                local yy = edit:GetText()
                if not BG.YYMainFrame.search.button:IsEnabled() then
                    if BG.YYMainFrame.search.cd <= 0 then
                        local msg = format(L["正在查询中"], yy)
                        UIErrorsFrame:AddMessage(msg, YELLOW_FONT_COLOR:GetRGB())
                    else
                        local msg = format(L["查询CD中，剩余%s秒"], BG.YYMainFrame.search.cd)
                        UIErrorsFrame:AddMessage(msg, YELLOW_FONT_COLOR:GetRGB())
                    end
                    return
                elseif tonumber(yy) then
                    local msg = format(L["正在查询YY%s的大众评价"], yy)
                    UIErrorsFrame:AddMessage(msg, YELLOW_FONT_COLOR:GetRGB())
                else
                    return
                end
                local bt = BG.YYMainFrame.search.button
                BG.ClearFocus()
                BG.YYMainFrame.searchText = {
                    yy = yy,
                    sumpingjia = { [1] = 0, [2] = 0, [3] = 0 },
                    all = {},
                    date = tonumber(date("%y%m%d"))
                }
                local current_time = time()                                    -- 获取当前时间戳
                local previous_time = current_time - (Y.searchLastDay * 86400) -- 计算XX天前的时间戳
                local previous_date = date("%y%m%d", previous_time)            -- 格式化为日期字符串

                local sendtext = "yy" .. yy .. "," .. previous_date
                SendChatMessage(sendtext, "CHANNEL", nil, BG.YYchannelId)
                bt:SetEnabled(false)
                edit:SetEnabled(false)
                edit:SetTextColor(RGB(BG.dis))
                edit.Text:SetTextColor(RGB(BG.dis))
                BG.OnUpdateTime(function(self, elapsed)
                    self.timeElapsed = self.timeElapsed + elapsed
                    local time = format("%.1f", Y.lateTime + 0.5 - self.timeElapsed)
                    bt:SetText(L["查询中 "] .. time)

                    if tonumber(time) <= 0 then
                        local sum = 0
                        for key, value in pairs(BG.YYMainFrame.searchText.sumpingjia) do
                            sum = sum + value
                        end
                        if sum ~= 0 then
                            BG.YYMainFrame.searchText.sumpingjia[0] = sum

                            for i = #BiaoGe.YYdb.history, 1, -1 do
                                if BiaoGe.YYdb.history[i].yy == BG.YYMainFrame.searchText.yy then
                                    tremove(BiaoGe.YYdb.history, i)
                                end
                            end
                            for i = #BiaoGe.YYdb.historyEmpty, 1, -1 do
                                if tonumber(BiaoGe.YYdb.historyEmpty[i]) == tonumber(BG.YYMainFrame.searchText.yy) then
                                    tremove(BiaoGe.YYdb.historyEmpty, i)
                                end
                            end
                            tinsert(BiaoGe.YYdb.history, 1, BG.YYMainFrame.searchText)
                            BG.YYMainFrame.historyNum = 1
                            Y.SetResult(BG.YYMainFrame.historyNum)
                            -- 检查数据库是否已经超过上限
                            for i = #BiaoGe.YYdb.history, 1, -1 do
                                if i > Y.maxHistory then
                                    _G["L_DropDownList1"]:Hide()
                                    tremove(BiaoGe.YYdb.history, i)
                                end
                            end
                            LibBG:UIDropDownMenu_SetText(BG.YYMainFrame.DropDown,
                                Y.DropDownColor(BiaoGe.YYdb.history[1], "yy"))

                            local link = "|cffFFFF00|Hgarrmission:" .. "BiaoGeYY:" .. L["详细"] .. ":" .. yy ..
                                "|h[" .. L["详细"] .. "]|h|r"
                            local msg = BG.STC_y1(format(L["查询成功：YY%s的评价一共%s个。%s"],
                                yy, BG.YYMainFrame.searchText.sumpingjia[0], link))
                            SendSystemMessage(msg)
                            local msg = BG.STC_y1(format(L["查询成功：YY%s的评价一共%s个。|cffFFFFFF|cff00FF00%s|r/|cffFFFF00%s|r/|cffDC143C%s|r|r。%s"],
                                yy, BG.YYMainFrame.searchText.sumpingjia[0], BG.YYMainFrame.searchText.sumpingjia[1],
                                BG.YYMainFrame.searchText.sumpingjia[2], BG.YYMainFrame.searchText.sumpingjia[3], link))
                            BG.FrameTradeMsg:AddMessage(msg)
                            local cd = 5
                            if Size(BG.YYMainFrame.searchText.all) == 1 then
                                cd = 3
                            end
                            BG.OnUpdateTime(function(self, elapsed)
                                self.timeElapsed = self.timeElapsed + elapsed
                                BG.YYMainFrame.search.cd = tonumber(format("%d", cd - self.timeElapsed))
                                bt:SetText(L["查询成功！CD"] .. BG.YYMainFrame.search.cd)
                                if BG.YYMainFrame.search.cd <= 0 then
                                    bt:SetEnabled(true)
                                    bt:SetText(L["查询"])
                                    self:SetScript("OnUpdate", nil)
                                    self:Hide()
                                end
                            end)
                        else
                            -- 把查询失败的YY放到空白库
                            for i = #BiaoGe.YYdb.history, 1, -1 do
                                if BiaoGe.YYdb.history[i].yy == BG.YYMainFrame.searchText.yy then
                                    tremove(BiaoGe.YYdb.history, i)
                                end
                            end
                            for i = #BiaoGe.YYdb.historyEmpty, 1, -1 do
                                if tonumber(BiaoGe.YYdb.historyEmpty[i]) == tonumber(BG.YYMainFrame.searchText.yy) then
                                    tremove(BiaoGe.YYdb.historyEmpty, i)
                                end
                            end
                            local a = { yy = BG.YYMainFrame.searchText.yy, date = BG.YYMainFrame.searchText.date }
                            tinsert(BiaoGe.YYdb.historyEmpty, a)

                            bt:SetEnabled(true)
                            bt:SetText(L["查询"])
                            Y.DefaultResult()
                            LibBG:UIDropDownMenu_SetText(BG.YYMainFrame.DropDown, L["无"])
                            local msg = BG.STC_r1(format(L["查询失败：没有找到YY%s的评价。"], yy))
                            SendSystemMessage(msg)
                            BG.FrameTradeMsg:AddMessage(msg)
                        end
                        BG.YYMainFrame.searchText = nil

                        edit:SetEnabled(true)
                        edit:SetTextColor(RGB(BG.w1))
                        edit.Text:SetTextColor(RGB(BG.w1))
                        self:SetScript("OnUpdate", nil)
                        self:Hide()
                    end
                end)
                PlaySound(BG.sound1, "Master")
            end

            local bt = CreateFrame("Button", nil, BG.YYMainFrame.search, "UIPanelButtonTemplate")
            bt:SetSize(130, 25)
            bt:SetPoint("LEFT", edit, "RIGHT", 10, 0)
            bt:SetText(L["查询"])
            BG.YYMainFrame.search.cd = 0
            BG.YYMainFrame.search.button = bt
            bt:SetScript("OnClick", Y.SearchButtonOnClick)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["< 查询大众评价 >"], 1, 1, 1, true)
                GameTooltip:AddLine(L["1、对BiaoGeYY频道的在线玩家发出该YY的请求"], 1, 0.82, 0, true)
                GameTooltip:AddLine(L["2、如果这些玩家有该YY的评价，则会通过匿名方式把评价发送给你"], 1, 0.82, 0, true)
                GameTooltip:AddLine(L["3、不同时间查询到的大众评价可能会不同，因为在线的玩家会不同"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            BG.GameTooltip_Hide(bt)
        end

        -- 历史查询
        do
            function Y.DropDownColor(table, yy)
                local c = { [0] = "|cffFFFFFF", [1] = "|cff00FF00", [2] = "|cffFFFF00", [3] = "|cffDC143C", }
                local max, maxkey
                for k, v in pairs(table["sumpingjia"]) do
                    if k ~= 0 then
                        if not max then
                            max = v
                            maxkey = k
                        end
                        if max <= v then
                            max = v
                            maxkey = k
                        end
                    end
                end
                local maxcount = 0
                for k, v in pairs(table["sumpingjia"]) do
                    if k ~= 0 then
                        if max == v then
                            maxcount = maxcount + 1
                        end
                    end
                end
                if maxcount >= 2 then
                    maxkey = 0
                end
                local text
                if not yy then
                    text = c[maxkey] .. table.yy .. " (" .. table.sumpingjia[0] .. L["个)|r"]
                else
                    text = c[maxkey] .. table.yy .. RR
                end
                return text
            end

            BG.YYDropDownColor = Y.DropDownColor

            function Y.DropDownList()
                LibBG:UIDropDownMenu_Initialize(BG.YYMainFrame.DropDown, function(self, level, menuList)
                    local info = LibBG:UIDropDownMenu_CreateInfo()
                    info.text, info.func = L["无"], function()
                        Y.DefaultResult()
                        LibBG:UIDropDownMenu_SetText(BG.YYMainFrame.DropDown, L["无"])
                        BG.ClearFocus()
                        PlaySound(BG.sound1, "Master")
                    end
                    LibBG:UIDropDownMenu_AddButton(info)

                    for i, v in ipairs(BiaoGe.YYdb.history) do
                        local info = LibBG:UIDropDownMenu_CreateInfo()
                        info.text, info.func = Y.DropDownColor(v), function()
                            BG.YYMainFrame.historyNum = i
                            Y.SetResult(i)
                            LibBG:UIDropDownMenu_SetText(BG.YYMainFrame.DropDown, Y.DropDownColor(v, "yy"))
                            BG.ClearFocus()
                            PlaySound(BG.sound1, "Master")
                        end
                        LibBG:UIDropDownMenu_AddButton(info)
                    end
                end)
            end

            local dropDown = LibBG:Create_UIDropDownMenu("BG.YYMainFrame.dropDown", BG.YYMainFrame.search)
            dropDown:SetPoint("TOPRIGHT", 2, -10)
            LibBG:UIDropDownMenu_SetWidth(dropDown, 150)
            LibBG:UIDropDownMenu_SetText(dropDown, L["无"])
            BG.dropDownToggle(dropDown)
            BG.YYMainFrame.DropDown = dropDown

            local text = dropDown:CreateFontString()
            text:SetPoint("RIGHT", dropDown, "LEFT", 10, 3)
            text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            text:SetTextColor(RGB(BG.y2))
            text:SetText(L["历史查询："])
            text:SetTextColor(1, 1, 1)
            BG.YYMainFrame.DropDownBiaoTi = text

            Y.DropDownList()
        end

        -- 评价筛选
        do
            local f = CreateFrame("Frame", nil, BG.YYMainFrame.search, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 16,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.2)
            f:SetPoint("TOPLEFT", 10, -45)
            f:SetPoint("BOTTOMRIGHT", BG.YYMainFrame.search, "TOPRIGHT", -10, -75)
            BG.YYMainFrame.resultPingjia = f

            f.Text = f:CreateFontString()
            f.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            f.Text:SetTextColor(RGB(BG.y2))
            f.Text:SetPoint("LEFT", 50, 0)
            f.Text:SetText(L["筛选："])

            local PingJiaGroup = CreateFrame("Frame", nil, BG.YYMainFrame.resultPingjia)
            PingJiaGroup:SetPoint("LEFT", f.Text, "RIGHT", 10, -2)
            PingJiaGroup:SetSize(1, 1)
            local numOptions = {
                { name = L["全部"], color = "FFFFFF" },
                { name = L["好评"], color = "00FF00" },
                { name = L["中评"], color = "FFFF00" },
                { name = L["差评"], color = "DC143C" },
            }
            BG.YYMainFrame.resultPingjia.pingjiaButtons = {}
            for i = 1, #numOptions do
                local bt = CreateFrame("CheckButton", nil, PingJiaGroup, "UIRadioButtonTemplate")
                bt:SetPoint("LEFT", ((i - 1) * 120), 2)
                bt:SetSize(18, 18)
                bt:SetHitRectInsets(0, -60, 0, 0)
                if i == BiaoGe.YYdb.historyFilter + 1 then
                    bt:SetChecked(true)
                end
                BG.YYMainFrame.resultPingjia.pingjiaButtons[i] = bt

                bt.Text = bt:CreateFontString()
                bt.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                bt.Text:SetTextColor(RGB(BG.y2))
                bt.Text:SetPoint("LEFT", bt, "RIGHT", 0, 0)
                bt.Text:SetText(numOptions[i].name .. L[" (0个)"])
                bt.Text:SetTextColor(RGB(numOptions[i].color))

                bt:SetScript("OnClick", function(self)
                    for _, radioButton in ipairs(BG.YYMainFrame.resultPingjia.pingjiaButtons) do
                        if radioButton ~= self then
                            radioButton:SetChecked(false)
                        end
                    end
                    self:SetChecked(true)
                    BiaoGe.YYdb.historyFilter = i - 1
                    if LibBG:UIDropDownMenu_GetText(BG.YYMainFrame.DropDown) ~= L["无"] then
                        Y.SetResult(BG.YYMainFrame.historyNum)
                    end
                    PlaySound(BG.sound1, "Master")
                end)
            end
        end

        -- 查询结果Frame
        do
            local height = 20 -- 每行高度
            local n = 0

            local f = CreateFrame("Frame", nil, BG.YYMainFrame.search, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 16,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.2)
            f:SetPoint("TOPLEFT", BG.YYMainFrame.resultPingjia, "BOTTOMLEFT", 0, 2)
            f:SetPoint("BOTTOMRIGHT", -10, 10)
            BG.YYMainFrame.result = f

            local title_table = {
                { name = L["序号"], width = 30, color = "FFFFFF" },
                { name = L["日期"], width = 80, color = "FFFFFF" },
                { name = L["YY"], width = 110, color = "FFFFFF" },
                { name = L["评价"], width = 40, color = "FFFFFF" },
                { name = L["理由"], width = 270, color = "FFFFFF" },
            }
            -- 标题
            local right
            for i, v in ipairs(title_table) do
                local f = CreateFrame("Frame", nil, BG.YYMainFrame.result)
                f:SetSize(title_table[i].width, 20)
                if i == 1 then
                    f:SetPoint("TOPLEFT", 10, -10)
                else
                    f:SetPoint("TOPLEFT", right, "TOPRIGHT", 0, 0)
                end
                right = f
                f.Text = f:CreateFontString(nil, "ARTWORK", "GameFontWhite")
                f.Text:SetWidth(f:GetWidth() - 3)
                f.Text:SetPoint("CENTER")
                f.Text:SetText(title_table[i].name)
                f.Text:SetTextColor(RGB(title_table[i].color))
                f.Text:SetWordWrap(false) -- 截断
                if title_table[i].name == L["理由"] then
                    f.Text:SetJustifyH("LEFT")
                end
            end
            n = n + 1
            Y.CreateLine(BG.YYMainFrame.result, -n * height - 10, BG.YYMainFrame.result:GetWidth() - 25)

            -- 内容
            local f = CreateFrame("Frame", nil, BG.YYMainFrame.result)
            f:SetSize(1, 1)
            BG.YYMainFrame.result.all = f
            local s = CreateFrame("ScrollFrame", nil, BG.YYMainFrame.result, "UIPanelScrollFrameTemplate")
            s:SetPoint("TOPLEFT", BG.YYMainFrame.result, 0, -height - 10 - 3)
            s:SetPoint("BOTTOMRIGHT", BG.YYMainFrame.result, -27, 5)
            s.ScrollBar.scrollStep = BG.scrollStep
            s:SetScrollChild(f)

            local function OnEnter(self)
                BG.YYMainFrame.result.all.button[self.num].ds:Show()
                if not self.onenter then return end
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self.onenter, 1, 1, 1, true)
                GameTooltip:Show()
            end
            local function OnLeave(self)
                BG.YYMainFrame.result.all.button[self.num].ds:Hide()
                GameTooltip:Hide()
            end

            function Y.DefaultResult()
                for i, v in pairs(BG.YYMainFrame.result.all.button) do
                    v:Hide()
                end
                for i, v in ipairs(BG.YYMainFrame.resultPingjia.pingjiaButtons) do
                    local pingjia = BG.YYMainFrame.resultPingjia.pingjiaButtons[i].Text
                    local sum = 0
                    pingjia:SetText(gsub(pingjia:GetText(), " %(.-%)", "") .. " (" .. sum .. L["个"] .. ")")
                end
            end

            function Y.SetResult(num)
                -- 先隐藏之前的列表内容
                Y.DefaultResult()
                BG.YYMainFrame.result.all.button = {}
                local n = 1
                -- 再开始创建新的内容
                for ii, _ in ipairs(BiaoGe.YYdb.history[num].all) do
                    if BiaoGe.YYdb.historyFilter == 0 or BiaoGe.YYdb.history[num].all[ii].pingjia == BiaoGe.YYdb.historyFilter then
                        local right
                        for i, _ in ipairs(title_table) do
                            local f = CreateFrame("Frame", nil, right or BG.YYMainFrame.result.all)
                            f:SetSize(title_table[i].width, 20)
                            if i == 1 then
                                f:SetPoint("TOPLEFT", BG.YYMainFrame.result.all, "TOPLEFT", 10, -(n - 1) * height)
                                BG.YYMainFrame.result.all.button[ii] = f
                            else
                                f:SetPoint("TOPLEFT", right, "TOPRIGHT", 0, 0)
                            end
                            right = f
                            f.num = ii
                            f.Text = f:CreateFontString(nil, "ARTWORK", "GameFontWhite")
                            f.Text:SetWidth(f:GetWidth() - 3)
                            f.Text:SetPoint("CENTER")

                            local date    = BiaoGe.YYdb.history[num].all[ii].date
                            date          = strsub(date, 1, 2) .. "/" .. strsub(date, 3, 4) .. "/" .. strsub(date, 5, 6)
                            local i_table = { ii, date, BiaoGe.YYdb.history[num].yy, Y.Pingjia(BiaoGe.YYdb.history[num].all[ii].pingjia),
                                BiaoGe.YYdb.history[num].all[ii].edit }
                            f.Text:SetText(i_table[i])
                            f.Text:SetTextColor(RGB(Y.PingjiaColor(BiaoGe.YYdb.history[num].all[ii].pingjia)))
                            f.Text:SetWordWrap(false) -- 截断
                            if f.Text:GetStringWidth() + 5 > f:GetWidth() then
                                f.onenter = i_table[i]
                            end
                            if i == #title_table then
                                f.Text:SetJustifyH("LEFT")
                            end

                            f:SetScript("OnEnter", OnEnter)
                            f:SetScript("OnLeave", OnLeave)
                        end
                        -- 底色材质
                        f.ds = f:CreateTexture()
                        f.ds:SetPoint("TOPLEFT", BG.YYMainFrame.result.all, "TOPLEFT", 2, -(n - 1) * height)
                        f.ds:SetPoint("BOTTOMRIGHT", BG.YYMainFrame.result.all, "BOTTOMRIGHT", BG.YYMainFrame.result:GetWidth(), -n * height)
                        f.ds:SetColorTexture(1, 1, 1, 0.1)
                        f.ds:Hide()
                        BG.YYMainFrame.result.all.button[ii].ds = f.ds

                        local l = right:CreateLine()
                        l:SetColorTexture(RGB("808080", 0.2))
                        l:SetStartPoint("TOPLEFT", BG.YYMainFrame.result.all, 5, -n * height)
                        l:SetEndPoint("TOPLEFT", BG.YYMainFrame.result.all, BG.YYMainFrame.result:GetWidth() - 8, -n * height)
                        l:SetThickness(1)
                        n = n + 1
                    end

                    -- 设置评价总数
                    for i, v in ipairs(BG.YYMainFrame.resultPingjia.pingjiaButtons) do
                        local pingjia = BG.YYMainFrame.resultPingjia.pingjiaButtons[i].Text
                        local sum = BiaoGe.YYdb.history[num].sumpingjia[i - 1]
                        pingjia:SetText(gsub(pingjia:GetText(), " %(.-%)", "") .. " (" .. sum .. L["个"] .. ")")
                    end
                end
            end

            BG.YYSetResult = Y.SetResult

            BG.YYMainFrame.result.all.button = {}
        end

        -- 下方的提示文字
        local f = CreateFrame("Frame", nil, BG.YYMainFrame.search)
        f:SetSize(1, 1)
        f:SetPoint("TOP", BG.YYMainFrame.search, "BOTTOM", 0, 0)
        BG.YYMainFrame.shareCountFrame = f

        local t = f:CreateFontString()
        t:SetPoint("CENTER")
        t:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
        t:SetText(format(L["你已共享|r |cff00FF00%s|r |cffffffff人次评价"], BiaoGe.YYdb.shareCount))
        f:SetWidth(t:GetStringWidth())
        f:SetHeight(t:GetStringHeight())
        BG.YYMainFrame.shareCountFrame.Text = t

        f:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:SetText(L["你的评价被其他玩家查询的次数"])
        end)
        BG.GameTooltip_Hide(f)
    end


    ------------------把聊天里的YY转换为链接------------------
    local starttime
    local UpdateFrame = CreateFrame("Frame")
    Y.yykey = "[yY][yY][：:/%-%s]*([%d%s]*%d+)"
    Y.yykey2 = "(%d+[%d%s]*)[：:/%-%s]*[yY][yY]"
    do
        local function PingJia(cleanedYY)
            local text = ""
            local yes
            for i, v in ipairs(BiaoGe.YYdb.history) do
                if tonumber(cleanedYY) == tonumber(v.yy) then
                    text = format("|cffFFFFFF-|cff00FF00%s|r/|cffFFFF00%s|r/|cffDC143C%s|r|r", v.sumpingjia[1], v.sumpingjia[2], v.sumpingjia[3])
                    yes = true
                    break
                end
            end
            if not yes then
                for i, v in ipairs(BiaoGe.YYdb.historyEmpty) do
                    if tonumber(cleanedYY) == tonumber(v.yy) then
                        text = format("|cffFFFFFF-|cff00FF00%s|r/|cffFFFF00%s|r/|cffDC143C%s|r|r", 0, 0, 0)
                        break
                    end
                end
            end
            return text
        end

        local function CreateLink(cleanedYY)
            return "|cff00BFFF|Hgarrmission:BiaoGeYY:YY:" .. cleanedYY ..
                "|h[YY:" .. cleanedYY .. PingJia(cleanedYY) .. "]|h|r"
        end
        local function CreateLinkForGsub(yy)
            return CreateLink(yy:gsub("%s", ""))
        end

        local function ChangSendLink(self, even, msg, player, l, cs, t, flag, channelId, ...)
            if BiaoGe.YYdb.share ~= 1 then return end
            -- 进团5分钟内把纯数字转换为超链接
            local playerName = strsplit("-", player)
            if starttime and Y.IsLeader(playerName) then
                msg = gsub(msg, "%s", "")
                local cleanedYY = strmatch(msg, "^%d+$")
                if cleanedYY and strlen(cleanedYY) >= 4 then
                    local link = CreateLink(cleanedYY)
                    return false, link, player, l, cs, t, flag, channelId, ...
                end
            end

            msg = msg:gsub(Y.yykey, CreateLinkForGsub)
            msg = msg:gsub(Y.yykey2, CreateLinkForGsub)
            return false, msg, player, l, cs, t, flag, channelId, ...
        end

        ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", ChangSendLink)

        function BG.OnClickYYXiangXi(yy)
            BG.MainFrame:Show()
            BG.ClickTabButton(BG.tabButtons, BG.YYMainFrameTabNum)
            for i, v in ipairs(BiaoGe.YYdb.history) do
                if tonumber(yy) == tonumber(v.yy) then
                    BG.YYMainFrame.historyNum = i
                    Y.SetResult(i)
                    LibBG:UIDropDownMenu_SetText(BG.YYMainFrame.DropDown, Y.DropDownColor(v, "yy"))
                    BG.PlaySound(1)
                    return
                end
            end
        end

        hooksecurefunc("SetItemRef", function(link)
            local arg1, arg2, arg3, arg4 = strsplit(":", link)
            local yy = arg4
            if arg2 == "BiaoGeYY" and arg3 == L["详细"] and arg4 then
                -- 点击[详细]后打开UI
                BG.OnClickYYXiangXi(yy)
            elseif arg2 == "BiaoGeYY" and arg3 == "YY" and arg4 then
                -- 点击YY链接后
                if IsShiftKeyDown() then
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    ChatEdit_ChooseBoxForSend():SetText(yy)
                    ChatEdit_ChooseBoxForSend():HighlightText()
                else
                    BG.YYMainFrame.search.edit:SetText(yy)
                    Y.SearchButtonOnClick()
                end
            end
        end)

        function BG.OnEnterYYXiangXi(yy, frame, anchor)
            GameTooltip:SetOwner(frame, anchor, 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine("|cff00BFFFYY:" .. yy .. RR)
            GameTooltip:AddLine(" ")
            for i, v in ipairs(BiaoGe.YYdb.history) do
                if tonumber(yy) == tonumber(v.yy) then
                    for ii, vv in ipairs(BiaoGe.YYdb.history[i].all) do
                        local date = vv.date
                        date = strsub(date, 1, 2) .. "/"
                            .. strsub(date, 3, 4) .. "/"
                            .. strsub(date, 5, 6)
                        local edit = vv.edit
                        if edit ~= "" then
                            edit = ": "
                        end
                        local r, g, b = RGB(Y.PingjiaColor(vv.pingjia))
                        GameTooltip:AddLine(ii .. ". " .. date .. " " .. Y.Pingjia(vv.pingjia)
                            .. edit .. vv.edit, r, g, b, true)
                    end
                end
            end
            GameTooltip:Show()
        end

        local function OnHyperlinkEnter(self, link)
            local arg1, arg2, arg3, arg4 = strsplit(":", link)
            local yy = arg4
            if arg2 == "BiaoGeYY" and arg3 == L["详细"] and arg4 then
                BG.OnEnterYYXiangXi(yy, self, "ANCHOR_TOPRIGHT")
            elseif arg2 == "BiaoGeYY" and arg3 == "YY" and arg4 then
                GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine("|cff00BFFFYY:" .. yy .. RR)
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine(L["|cffFFFFFF左键：|r查询大众评价"])
                GameTooltip:AddLine(L["|cffFFFFFFSHIFT+左键：|r复制该号码"])

                -- 以往查询结果
                local yes
                for i, v in ipairs(BiaoGe.YYdb.history) do
                    if tonumber(yy) == tonumber(v.yy) then
                        GameTooltip:AddLine(" ")
                        if v.date then
                            local date = v.date
                            date       = strsub(date, 1, 2) .. "/" .. strsub(date, 3, 4) .. "/" .. strsub(date, 5, 6)
                            GameTooltip:AddLine(format(L["以往查询结果(%s)："], date))
                        else
                            GameTooltip:AddLine(L["以往查询结果(可能已过时)："])
                        end
                        GameTooltip:AddLine(format(L["|cff00FF00好评：%s个|r"], v.sumpingjia[1]))
                        GameTooltip:AddLine(format(L["|cffFFFF00中评：%s个|r"], v.sumpingjia[2]))
                        GameTooltip:AddLine(format(L["|cffDC143C差评：%s个|r"], v.sumpingjia[3]))
                        yes = true
                        break
                    end
                end
                if not yes then
                    for i, v in ipairs(BiaoGe.YYdb.historyEmpty) do
                        if tonumber(yy) == tonumber(v.yy) then
                            GameTooltip:AddLine(" ")
                            if v.date then
                                local date = v.date
                                date       = strsub(date, 1, 2) .. "/" .. strsub(date, 3, 4) .. "/" .. strsub(date, 5, 6)
                                GameTooltip:AddLine(format(L["以往查询结果(%s)："], date))
                            else
                                GameTooltip:AddLine(L["以往查询结果(可能已过时)："])
                            end
                            GameTooltip:AddLine(BG.STC_r1(L["没有找到任何评价"]))
                            yes = true
                            break
                        end
                    end
                end

                -- 看看自己是否有评价过
                local mypingjia = {}
                for i, v in ipairs(BiaoGe.YYdb.all) do
                    if tonumber(yy) == tonumber(v.yy) then
                        local date = v.date
                        date       = strsub(date, 1, 2) .. "/" .. strsub(date, 3, 4) .. "/" .. strsub(date, 5, 6)
                        tinsert(mypingjia, { name = L["日期："], name2 = date })
                        tinsert(mypingjia, { name = L["频道名称："], name2 = v.name })
                        tinsert(mypingjia, { name = L["评价："], name2 = Y.Pingjia(v.pingjia) })
                        tinsert(mypingjia, { name = L["理由："], name2 = v.edit })
                    end
                end
                if #mypingjia ~= 0 then
                    GameTooltip:AddLine(L[" "])
                    GameTooltip:AddLine(L["我的评价："])
                    for i, v in ipairs(mypingjia) do
                        GameTooltip:AddLine(BG.STC_w1(v.name) .. v.name2, 1, 0.82, 0, true)
                    end
                end
                GameTooltip:Show()
            end
        end
        local function OnHyperlinkLeave(self, link)
            GameTooltip:Hide()
        end
        -- local f = CreateFrame("Frame")
        -- f:RegisterEvent("PLAYER_ENTERING_WORLD")
        -- f:SetScript("OnEvent", function(self, even, isLogin, isReload)
        --     if not (isLogin or isReload) then return end
        local i = 1
        while _G["ChatFrame" .. i] do
            _G["ChatFrame" .. i]:HookScript("OnHyperlinkEnter", OnHyperlinkEnter)
            _G["ChatFrame" .. i]:HookScript("OnHyperlinkLeave", OnHyperlinkLeave)
            i = i + 1
        end
        -- end)
    end

    ------------------记录团长发过的YY号------------------
    do
        if not BiaoGe.YYdb.LeaderYY then
            BiaoGe.YYdb.LeaderYY = {}
        end

        -- 是否团长
        function Y.IsLeader(playerName)
            if BG.raidRosterInfo and type(BG.raidRosterInfo) == "table" then
                for index, v in ipairs(BG.raidRosterInfo) do
                    if v.rank == 2 and v.name == playerName then -- 团长
                        return true
                    end
                    if v.isML and v.name == playerName then -- 物品分配者
                        return true
                    end
                end
            end
        end

        -- 收集团长YY
        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_RAID_WARNING")
        f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:RegisterEvent("CHAT_MSG_WHISPER")
        f:SetScript("OnEvent", function(self, even, msg, playerName, ...)
            if BiaoGe.YYdb.share ~= 1 then return end
            local playerName = strsplit("-", playerName)
            if not Y.IsLeader(playerName) then return end

            if starttime then
                msg = gsub(msg, "%s", "")
                local cleanedYY = strmatch(msg, "^%d+$")
                if cleanedYY and strlen(cleanedYY) >= 4 then
                    for k, v in pairs(BiaoGe.YYdb.LeaderYY) do
                        if tonumber(v.yy) == tonumber(cleanedYY) and v.name == playerName then
                            return
                        end
                    end
                    local a = { yy = cleanedYY, time = time(), name = playerName, colorname = SetClassCFF(playerName) }
                    tinsert(BiaoGe.YYdb.LeaderYY, 1, a)
                    return
                end
            end

            local cleanedYY = msg:match(Y.yykey)
            if not cleanedYY then
                cleanedYY = msg:match(Y.yykey2)
            end
            if cleanedYY then
                cleanedYY = cleanedYY:gsub("%s", "")
            else
                return
            end

            for k, v in pairs(BiaoGe.YYdb.LeaderYY) do
                if tonumber(v.yy) == tonumber(cleanedYY) and v.name == playerName then
                    return
                end
            end
            local a = { yy = cleanedYY, time = time(), name = playerName, colorname = SetClassCFF(playerName) }
            tinsert(BiaoGe.YYdb.LeaderYY, 1, a)
        end)

        -- 进团后的5分钟内生效
        BG.RegisterEvent("GROUP_JOINED", function()
            C_Timer.After(0.5, function()
                if IsInRaid(1) then
                    starttime = time()

                    -- 开始计时：5分钟
                    UpdateFrame.timeElapsed = 0
                    UpdateFrame:SetScript("OnUpdate", function(self, elapsed)
                        self.timeElapsed = self.timeElapsed + elapsed
                        if self.timeElapsed >= 600 then
                            starttime = nil
                            self:SetScript("OnUpdate", nil)
                        end
                    end)
                end
            end)
        end)
        -- 退团后失效
        BG.RegisterEvent("GROUP_ROSTER_UPDATE", function()
            C_Timer.After(1, function()
                if not IsInRaid(1) then
                    starttime = nil
                    UpdateFrame:SetScript("OnUpdate", nil)
                end
            end)
        end)
        -- 如果进了副本则失效
        BG.RegisterEvent("ZONE_CHANGED_NEW_AREA", function()
            if not starttime then return end
            local fbId = select(8, GetInstanceInfo()) -- 获取副本ID
            local yes, type = IsInInstance()
            if not yes then return end
            for id, value in pairs(BG.FBIDtable) do
                if tonumber(fbId) == tonumber(id) then
                    starttime = nil
                    UpdateFrame:SetScript("OnUpdate", nil)
                end
            end
        end)

        -- 如果时间超过12小时就删掉该YY号记录
        local deleteTime = 43200
        BG.RegisterEvent("PLAYER_ENTERING_WORLD", function()
            for i = #BiaoGe.YYdb.LeaderYY, 1, -1 do
                if time() - BiaoGe.YYdb.LeaderYY[i].time >= deleteTime then
                    tremove(BiaoGe.YYdb.LeaderYY, i)
                end
            end
        end)

        local dropDown = LibBG:Create_UIDropDownMenu(nil, UIParent)
        BG.ListYYdropDown = dropDown
        function BG.LiseYY(edit)
            if not edit:HasFocus() then return end
            if Size(BiaoGe.YYdb.LeaderYY) == 0 then return end

            local channelTypeMenu = {
                {
                    isTitle = true,
                    text = L["团长YY（根据聊天记录帮你生成）"],
                    notCheckable = true,
                },
                {
                    isTitle = true,
                    text = " ",
                    notCheckable = true,
                },
            }

            for i, v in ipairs(BiaoGe.YYdb.LeaderYY) do
                local pingjiaText = ""
                for k, vv in pairs(BiaoGe.YYdb.all) do
                    if v.yy == vv.yy then
                        pingjiaText = format(BG.STC_dis(L["（曾评价为：|cff%s%s|r）"]), Y.PingjiaColor(vv.pingjia), Y.Pingjia(vv.pingjia))
                    end
                end
                local a = {
                    text = v.yy .. " " .. v.colorname .. pingjiaText,
                    notCheckable = true,
                    func = function()
                        edit:SetText(v.yy)
                        edit:ClearFocus()
                    end
                }
                tinsert(channelTypeMenu, a)
            end
            local a = {
                text = CANCEL,
                notCheckable = true,
                func = function(self)
                    LibBG:CloseDropDownMenus()
                    edit:ClearFocus()
                end,
            }
            tinsert(channelTypeMenu, a)
            LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "BOTTOMLEFT", edit, "TOPLEFT")
            LibBG:EasyMenu(channelTypeMenu, dropDown, edit, 0, 0, "MENU", 15)
        end
    end

    ------------------屏蔽集结号退队后弹出的评价系统------------------
    do
        BG.RegisterEvent("ENCOUNTER_END", function(self, _, bossId, _, _, _, success)
            if BiaoGe.YYdb.share ~= 1 then return end
            if success ~= 1 then return end
            local addonName = "MeetingHorn"
            if not IsAddOnLoaded(addonName) then return end

            C_Timer.After(1, function()
                local MeetingHorn = LibStub("AceAddon-3.0"):GetAddon("MeetingHorn")
                if MeetingHorn then
                    local db = MeetingHorn.db.profile.goodleader.cache
                    if db then
                        wipe(db)
                    end
                end
            end)
        end)
    end

    ------------------击杀尾王后弹出评价系统------------------
    do
        BG.EndPJ = {}

        local function GetLeaderYY()
            -- 是否有团长发的YY
            for _, v in ipairs(BiaoGe.YYdb.LeaderYY) do
                for _, vv in ipairs(BG.raidRosterInfo) do
                    if v.name == vv.name and vv.rank == 2 then
                        return v.yy
                    end
                end
            end
            -- 是否有物品分配者发的YY
            for _, v in ipairs(BiaoGe.YYdb.LeaderYY) do
                for _, vv in ipairs(BG.raidRosterInfo) do
                    if v.name == vv.name and vv.isML then
                        return v.yy
                    end
                end
            end
            -- 是否有其他人发的YY
            for _, v in ipairs(BiaoGe.YYdb.LeaderYY) do
                for _, vv in ipairs(BG.raidRosterInfo) do
                    if v.name == vv.name then
                        return v.yy
                    end
                end
            end
            return ""
        end

        -- UI
        do
            local f = CreateFrame("Frame", "BG.EndPJ.new", UIParent, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                edgeSize = 32,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:SetSize(340, 210)
            f:SetPoint("TOP", 0, -300)
            f:SetClampedToScreen(true)
            f:SetFrameStrata("FULLSCREEN_DIALOG")
            f:SetFrameLevel(190)
            f:EnableMouse(true)
            f:SetMovable(true)
            BG.EndPJ.new = f
            tinsert(UISpecialFrames, "BG.EndPJ.new") -- 按ESC可关闭插件
            f:SetScript("OnMouseUp", function(self)
                self:StopMovingOrSizing()
            end)
            f:SetScript("OnMouseDown", function(self)
                BG.EndPJ.new.yy:ClearFocus()
                self:StartMoving()
            end)
            f:SetScript("OnShow", function()
                BG.EndPJ.new.yy:SetText("")
                BG.EndPJ.new.pingjia = 2
                BG.EndPJ.new.pingjiaButtons[1]:SetChecked(false)
                BG.EndPJ.new.pingjiaButtons[2]:SetChecked(true)
                BG.EndPJ.new.pingjiaButtons[3]:SetChecked(false)
                BG.EndPJ.new.buttonsave:SetEnabled(true)

                for _, edit in pairs(BG.EndPJ.textcolor_table) do
                    edit:SetTextColor(RGB("FFFF00"))
                end

                -- 历遍团长YY记录
                BG.EndPJ.new.yy:SetText(GetLeaderYY())

                BG.ClearFocus()
                PlaySoundFile(BG.sound2, "Master")
                BG.After(1.5, function()
                    PlaySoundFile(BG["sound_pingjia" .. BiaoGe.options.Sound], "Master")
                end)
            end)

            -- 大标题
            do
                local t = f:CreateTexture(nil, "ARTWORK")
                t:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")
                t:SetWidth(256)
                t:SetHeight(64)
                t:SetPoint("TOP", f, 0, 12)
                f.texture = t

                local t = f:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                t:SetText(L["< 快速评价 >"])
                t:SetPoint("TOP", f.texture, 0, -12)
                t:SetTextColor(1, 1, 1)

                local t = f:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                t:SetText(L["恭喜你们击杀尾王！请给团长个评价吧！"])
                t:SetPoint("TOP", BG.EndPJ.new, "TOP", 0, -30)
                t:SetTextColor(1, 1, 1)

                local l = f:CreateLine()
                l:SetColorTexture(RGB("808080", 1))
                l:SetStartPoint("BOTTOMLEFT", t, -5, -2)
                l:SetEndPoint("BOTTOMRIGHT", t, 5, -2)
                l:SetThickness(1)
            end


            BG.EndPJ.textcolor_table = {} -- 用于根据所选评价给输入框设置相应颜色
            local height = 22             -- 每行高度
            local height_start = -65
            local n = 0

            -- 小标题
            do
                local text_table = {
                    { name = "YY:", onenter = L["YY号必填，填写数字"] },
                    { name = L["评价:"], onenter = L["评价必填，默认中评"] },
                    { name = L["理由:"], onenter = L["理由选填"] },
                }
                for i, _ in ipairs(text_table) do
                    local f = CreateFrame("Frame", nil, BG.EndPJ.new)
                    f:SetPoint("TOPLEFT", 5, height_start - height * (i - 1))
                    f:SetSize(90, 20)
                    f.Text = f:CreateFontString()
                    f.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                    f.Text:SetAllPoints()
                    f.Text:SetWordWrap(false) -- 截断
                    f.Text:SetText(text_table[i].name)
                    f.Text:SetTextColor(RGB("FFFF00"))
                    f.Text:SetJustifyH("RIGHT")
                    tinsert(BG.EndPJ.textcolor_table, f.Text)
                end
            end
            -- YY号
            do
                local edit = CreateFrame("EditBox", nil, BG.EndPJ.new, "InputBoxTemplate")
                edit:SetSize(150, 20)
                edit:SetPoint("TOPLEFT", 110, height_start - height * n)
                edit:SetAutoFocus(false)
                edit:SetNumeric(true)
                edit:SetTextColor(RGB("FFFF00"))
                tinsert(BG.EndPJ.textcolor_table, edit)
                BG.EndPJ.new.yy = edit
                n = n + 1
                local t = edit:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall2")
                t:SetPoint("LEFT", 3, 0)
                t:SetText(L["必填"])
                edit:SetScript("OnEditFocusGained", function(self)
                    BG.LiseYY(self)
                end)
                edit:SetScript("OnEditFocusLost", function(self)
                    _G.L_DropDownList1:Hide()
                end)
                edit:SetScript("OnTextChanged", function(self)
                    BG.EndPJ.new.buttonsave:SetEnabled(true)
                    BG.EndPJ.new.buttonsave.dis:Hide()
                    if self:GetText() ~= "" then
                        t:Hide()
                    else
                        t:Show()
                        BG.EndPJ.new.buttonsave:SetEnabled(false)
                        BG.EndPJ.new.buttonsave.dis:Show()
                    end
                    BG.EndPJ.new.havedYY:Hide()
                    for key, value in pairs(BiaoGe.YYdb.all) do
                        if self:GetText() == value.yy then
                            BG.EndPJ.new.havedYY:Show()
                            return
                        end
                    end
                end)
                edit:SetScript("OnEnterPressed", function(self, enter)
                    self:ClearFocus()
                end)
                edit:SetScript("OnMouseDown", function(self, enter)
                    if enter == "RightButton" then
                        self:SetEnabled(false)
                        self:SetText("")
                    end
                end)
                edit:SetScript("OnMouseUp", function(self, enter)
                    if enter == "RightButton" then
                        self:SetEnabled(true)
                    end
                end)
            end
            -- 评价
            do
                local PingJiaGroup = CreateFrame("Frame", nil, BG.EndPJ.new)
                PingJiaGroup:SetPoint("TOPLEFT", 110, height_start - height * n)
                PingJiaGroup:SetSize(1, 1)
                local numOptions = {
                    { name = L["好评"], color = "00FF00" },
                    { name = L["中评"], color = "FFFF00" },
                    { name = L["差评"], color = "DC143C" },
                }
                BG.EndPJ.new.pingjiaButtons = {}
                for i = 1, #numOptions do
                    local bt = CreateFrame("CheckButton", nil, PingJiaGroup, "UIRadioButtonTemplate")
                    bt:SetPoint("TOPLEFT", -5 + ((i - 1) * 60), -3)
                    bt:SetSize(20, 20)
                    bt:SetHitRectInsets(0, -30, 0, 0)
                    if i == 2 then
                        bt:SetChecked(true)
                        BG.EndPJ.new.pingjia = i
                    end
                    BG.EndPJ.new.pingjiaButtons[i] = bt

                    bt.Text = bt:CreateFontString()
                    bt.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                    bt.Text:SetPoint("LEFT", bt, "RIGHT", 0, 0)
                    bt.Text:SetText(numOptions[i].name)
                    bt.Text:SetTextColor(RGB(numOptions[i].color))

                    bt:SetScript("OnClick", function(self)
                        for _, radioButton in ipairs(BG.EndPJ.new.pingjiaButtons) do
                            if radioButton ~= self then
                                radioButton:SetChecked(false)
                            end
                        end
                        for _, edit in pairs(BG.EndPJ.textcolor_table) do
                            edit:SetTextColor(RGB(numOptions[i].color))
                        end
                        self:SetChecked(true)
                        BG.EndPJ.new.pingjia = i

                        PlaySound(BG.sound1, "Master")
                    end)
                end
                n = n + 1
            end
            -- 理由
            do
                local maxbytes = 200
                local f = CreateFrame("Frame", nil, BG.EndPJ.new, "BackdropTemplate")
                f:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                    edgeSize = 16,
                    insets = { left = 3, right = 3, top = 3, bottom = 3 }
                })
                f:SetBackdropColor(0, 0, 0, 0.2)
                f:SetBackdropBorderColor(1, 1, 1, 0.6)
                f:SetSize(156, height * 2)
                f:SetPoint("TOPLEFT", 107, height_start - height * n - 2)
                local edit = CreateFrame("EditBox", nil, f)
                edit:SetWidth(f:GetWidth())
                edit:SetAutoFocus(false)
                edit:SetMaxBytes(maxbytes)
                edit:EnableMouse(true)
                edit:SetTextInsets(0, 10, 0, 5)
                edit:SetMultiLine(true)
                edit:SetTextColor(RGB("FFFF00"))
                edit:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
                tinsert(BG.EndPJ.textcolor_table, edit)
                BG.EndPJ.new.edit = edit
                local s = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
                s:SetWidth(f:GetWidth() - 10)
                s:SetHeight(f:GetHeight() - 10)
                s:SetPoint("CENTER")
                s.ScrollBar.scrollStep = BG.scrollStep
                s:SetScrollChild(edit)
                n = n + 2

                local leftt = f:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall2")
                leftt:SetPoint("TOPLEFT", 7, -5)
                leftt:SetText(L["选填"])

                edit:SetScript("OnTextChanged", function(self)
                    if self:GetText() ~= "" then
                        leftt:Hide()
                    else
                        leftt:Show()
                    end
                end)
                edit:SetScript("OnEscapePressed", function(self)
                    self:ClearFocus()
                end)
                edit:SetScript("OnEnterPressed", function(self)
                    self:ClearFocus()
                end)
                edit:SetScript("OnMouseDown", function(self, enter)
                    if enter == "RightButton" then
                        edit:SetEnabled(false)
                        edit:SetText("")
                    else
                        edit:SetFocus()
                    end
                end)
                edit:SetScript("OnMouseUp", function(self, enter)
                    if enter == "RightButton" then
                        edit:SetEnabled(true)
                    end
                end)
                f:SetScript("OnMouseDown", function(self, enter)
                    if enter == "RightButton" then
                        edit:SetEnabled(false)
                        edit:SetText("")
                    else
                        edit:SetFocus()
                    end
                end)
                f:SetScript("OnMouseUp", function(self, enter)
                    if enter == "RightButton" then
                        edit:SetEnabled(true)
                    end
                end)
            end
            -- 保存
            do
                function OnClick(self)
                    if not BG.EndPJ.new.buttonsave:IsEnabled() then return end

                    local new = BG.EndPJ.new
                    if not new.pingjia then return end
                    if new.yy:GetText() == "" or new.yy:GetText() == 0 then return end

                    for i = #BiaoGe.YYdb.all, 1, -1 do
                        if new.yy:GetText() == BiaoGe.YYdb.all[i].yy then
                            tremove(BiaoGe.YYdb.all, i)
                        end
                    end

                    local a = {
                        date = tonumber(date("%y%m%d")),
                        yy = new.yy:GetText(),
                        name = "",
                        pingjia = new.pingjia,
                        edit = new.edit:GetText(),
                    }
                    tinsert(BiaoGe.YYdb.all, 1, a)

                    Y.SetAll()
                    Y.EscXiuGai()
                    BG.EndPJ.new:Hide()

                    local liyou = ""
                    if BG.EndPJ.new.edit:GetText() ~= "" then
                        liyou = L["（"] .. BG.EndPJ.new.edit:GetText() .. L["）"]
                    end
                    SendSystemMessage(BG.BG .. format(L["|cff%s感谢你的评价：YY%s，>>%s<<%s。|r"],
                        Y.PingjiaColor(a.pingjia), a.yy, Y.Pingjia(a.pingjia), liyou))

                    PlaySound(BG.sound1, "Master")
                end

                local bt = CreateFrame("Button", nil, BG.EndPJ.new, "UIPanelButtonTemplate")
                bt:SetSize(80, 25)
                bt:SetPoint("TOPRIGHT", BG.EndPJ.new, "TOP", -30, height_start - 10 - height * n)
                bt:SetText(L["保存"])
                BG.EndPJ.new.buttonsave = bt
                bt:SetScript("OnClick", OnClick)

                local f = CreateFrame("Frame", nil, bt)
                f:SetAllPoints()
                f.dis = true
                f.bt = bt
                f:Hide()
                bt.dis = f
                f:SetScript("OnEnter", function(self)
                    if BG.EndPJ.new.yy:GetText() == "" then
                        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                        GameTooltip:ClearLines()
                        GameTooltip:AddLine(bt:GetText(), 1, 1, 1, true)
                        GameTooltip:AddLine(L["未填写YY，不能保存。"], 1, 0, 0, true)
                        GameTooltip:Show()
                    end
                end)
                f:SetScript("OnLeave", GameTooltip_Hide)
            end
            -- 取消
            do
                local bt = CreateFrame("Button", nil, BG.EndPJ.new, "UIPanelButtonTemplate")
                bt:SetSize(80, 25)
                bt:SetPoint("TOPLEFT", BG.EndPJ.new, "TOP", 30, height_start - 10 - height * n)
                bt:SetText(L["退出"])
                BG.EndPJ.new.escsave = bt
                bt:SetScript("OnClick", function()
                    BG.EndPJ.new:Hide()
                    PlaySound(BG.sound1, "Master")
                end)
            end
            -- 底下文字
            do
                local t = f:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                t:SetPoint("TOP", f, "BOTTOM", 0, 0)
                t:SetTextColor(1, 0, 0)
                t:SetText(L["你已给该YY写过评价！"])
                t:Hide()
                BG.EndPJ.new.havedYY = t
            end
        end

        local function IsTheEndBoss(bossId)
            for i, _bossId in ipairs(BG.theEndBossID) do
                if _bossId == bossId then
                    return true
                end
            end
        end
        BG.RegisterEvent("ENCOUNTER_END", function(self, _, bossId, _, _, _, success)
            if not IsTheEndBoss(bossId) or success ~= 1 or BiaoGe.YYdb.share ~= 1 then
                return
            end
            if Y.IsLeader(UnitName("player")) then return end
            local yy = GetLeaderYY()
            if yy == "" then
                SendSystemMessage(BG.BG .. L["恭喜你们击杀尾王！由于没有记录到团长YY，快速评价框不会弹出。"])
                return
            end
            for k, vv in pairs(BiaoGe.YYdb.all) do
                if yy == vv.yy then
                    SendSystemMessage(BG.BG .. format(L["恭喜你们击杀尾王！YY%s你曾评价为：|cff%s>>%s<<。|r"], yy, Y.PingjiaColor(vv.pingjia), Y.Pingjia(vv.pingjia)))
                    return
                end
            end
            C_Timer.After(10, function()
                BG.EndPJ.new:Show()
            end)
        end)
    end

    local t = BG.YYMainFrame:CreateFontString()
    t:SetPoint("TOP", BG.MainFrame, "TOP", 0, -70)
    t:SetFont(BIAOGE_TEXT_FONT, 20, "OUTLINE")
    t:SetTextColor(1, 1, 1)
    t:SetText(L["该模块已关闭。右键底部标签页开启"])

    function BG.YYShowHide(show)
        if show == 1 then
            BG.YYMainFrame.new:Show()
            BG.YYMainFrame.my:Show()
            BG.YYMainFrame.search:Show()
            t:Hide()
        else
            BG.YYMainFrame.new:Hide()
            BG.YYMainFrame.my:Hide()
            BG.YYMainFrame.search:Hide()
            t:Show()
        end
    end
end)

local CDing = {}
local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_ADDON")
f:RegisterEvent("CHAT_MSG_CHANNEL")
f:SetScript("OnEvent", function(self, even, ...)
    if BiaoGe.YYdb.share ~= 1 then return end
    if even == "CHAT_MSG_ADDON" then
        if not BG.YYMainFrame.searchText then return end
        local prefix, msg, distType, sender = ...
        if prefix ~= YY then return end
        local date, pingjia, edit = strmatch(msg, "(%d+),(%d+),(.-),")
        pingjia = tonumber(pingjia)
        BG.YYMainFrame.searchText.sumpingjia[pingjia] = BG.YYMainFrame.searchText.sumpingjia[pingjia] + 1
        if Size(BG.YYMainFrame.searchText.all) <= Y.maxSearchText then -- 最多收集300个评价详细
            local a = { date = date, pingjia = pingjia, edit = edit }
            tinsert(BG.YYMainFrame.searchText.all, a)
        end
    elseif even == "CHAT_MSG_CHANNEL" then
        local text, sender, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName,
        languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons = ...
        if channelBaseName ~= YY then return end
        local sendername = strsplit("-", sender)
        local yy, date = strmatch(text, "yy(%d+),(%d+)")
        if not yy or CDing[sender] then return end
        for i, v in pairs(BiaoGe.YYdb.all) do
            if tonumber(yy) == tonumber(v.yy) and tonumber(v.date) >= tonumber(date) then
                local resendtext = v.date .. "," .. v.pingjia .. "," .. v.edit .. ","
                local randomtime = random(0.1, Y.lateTime)
                C_Timer.After(randomtime, function()
                    if sendername ~= UnitName("player") then
                        BiaoGe.YYdb.shareCount = BiaoGe.YYdb.shareCount + 1
                        BG.YYMainFrame.shareCountFrame.Text:SetText(format(L["你已共享|r |cff00FF00%s|r |cffffffff人次评价"], BiaoGe.YYdb.shareCount))
                        BG.YYMainFrame.shareCountFrame:SetWidth(BG.YYMainFrame.shareCountFrame.Text:GetStringWidth())
                        BG.YYMainFrame.shareCountFrame:SetHeight(BG.YYMainFrame.shareCountFrame.Text:GetStringHeight())
                    end
                    C_ChatInfo.SendAddonMessage(YY, resendtext, "WHISPER", sender)
                    CDing[sender] = true
                    BG.After(2, function() -- 间隔x秒发一次
                        CDing[sender] = nil
                    end)
                end)
                return
            end
        end
    end
end)

local f = CreateFrame("Frame")
f:RegisterEvent("CHANNEL_UI_UPDATE")
f:SetScript("OnEvent", function(self, even)
    if even == "CHANNEL_UI_UPDATE" then
        local i = 1
        while _G["ChatFrame" .. i] do
            ChatFrame_RemoveChannel(_G["ChatFrame" .. i], YY)
            ChatFrame_RemoveChannel(_G["ChatFrame" .. i], "MeetingHorn")
            i = i + 1
        end

        local channels = { GetChannelList() }
        for i = 1, #channels, 3 do
            if channels[i + 1] == YY then
                BG.YYchannelId = channels[i]
                return
            end
        end
        BG.YYchannelId = nil
        if BiaoGe.YYdb.share ~= 1 then
            LeaveChannelByName(YY)
        end
    end
end)

BG.RegisterEvent("CHAT_MSG_CHANNEL_NOTICE", function(self, even, text, playerName, _, _, _, _, _, _, channelBaseName)
    -- pt(text, channelBaseName)
    if channelBaseName ~= YY then return end
    if text == "YOU_LEFT" then
        BiaoGe.YYdb.share = 0
        BG.YYShowHide(BiaoGe.YYdb.share)
        SendSystemMessage(BG.BG .. format(L["你已退出%s频道，YY评价模块自动关闭。"], YY))
    end
end)

BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
    if not (isLogin or isReload) then return end
    BG.YYShowHide(BiaoGe.YYdb.share)

    local i = 1
    while _G["ChatFrame" .. i] do
        ChatFrame_RemoveChannel(_G["ChatFrame" .. i], YY)
        i = i + 1
    end

    -- 禁止玩家点击频道
    hooksecurefunc('ChatConfig_UpdateCheckboxes', function(frame)
        if not frame.checkBoxTable or not frame.checkBoxTable[1] or not frame.checkBoxTable[1].channelID then
            return
        end

        local checkBoxName = frame:GetName() .. 'CheckBox'
        for i, value in ipairs(frame.checkBoxTable) do
            if value.channelName then
                local checkBox = _G[checkBoxName .. i .. 'Check']

                if value.channelName == YY then
                    BlizzardOptionsPanel_CheckButton_Disable(checkBox)
                    BG.YYchannelId = i
                end
            end
        end
    end)
    hooksecurefunc(ChannelFrame.ChannelList, 'AddChannelButtonInternal', function(f, button, _, name, _, channelId)
        if name == YY then
            button:Disable()
            local text = ('%s %s %s'):format(button:GetChannelNumberText(), button:GetChannelName(),
                button:GetMemberCountText())
            button.Text:SetText(DISABLED_FONT_COLOR:WrapTextInColorCode(text))
        end
    end)

    -- 初始化频道
    local channels = { GetChannelList() }
    for i = 1, #channels, 3 do
        if channels[i + 1] == YY then
            BG.YYchannelId = channels[i]
            return
        end
    end
    BG.YYchannelId = nil

    local first = true
    BG.MainFrame:HookScript("OnShow", function(self)
        if first then
            first = nil
            if not BG.YYchannelId and BiaoGe.YYdb.share == 1 then
                JoinPermanentChannel(YY, nil, 1)
                SendSystemMessage(BG.BG .. format(L["YY评价模块初始化成功，已自动加入%s频道，用于共享和查询YY大众评价。"], YY))
            end
        end
    end)
end)


-- 废弃代码
--[[             msg = gsub(msg, "[yY][yY][：: ]*(%d+)", "YY%1")
            msg = gsub(msg, "(%d+)%s*[yY][yY]", "%1YY")

            local yykey = "YY%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*%s*%d+"
            local yykey2 = "%d+%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*%s*%d*YY"
            local last
            for yy in string.gmatch(msg, yykey) do
                local cleanedYY = gsub(yy, "%D", "")     -- 把非数字的格式删掉，只保留YY号码数字
                local s, e = strfind(msg, yy, last or 1) -- 查找yy字符串的开始和结束位置
                local t1 = strsub(msg, 1, s - 1)
                local t2 = strsub(msg, e + 1)
                local link = CreateLink(cleanedYY)
                local newmsg = t1 .. link .. t2
                local s, e = strfind(newmsg, link, last or 1, true)
                msg = newmsg
                last = e + 1
            end
            for yy in string.gmatch(msg, yykey2) do
                local cleanedYY = gsub(yy, "%D", "")     -- 把非数字的格式删掉，只保留YY号码数字
                local s, e = strfind(msg, yy, last or 1) -- 查找yy字符串的开始和结束位置
                local t1 = strsub(msg, 1, s - 1)
                local t2 = strsub(msg, e + 1)
                local link = CreateLink(cleanedYY)
                local newmsg = t1 .. link .. t2
                local s, e = strfind(newmsg, link, last or 1, true)
                msg = newmsg
                last = e + 1
            end
            if last then
                return false, msg, player, l, cs, t, flag, channelId, ...
            end ]]
