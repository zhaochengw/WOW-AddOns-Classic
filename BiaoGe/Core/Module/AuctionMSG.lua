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
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print

BG.Init(function()
    BiaoGe.auctionMSGhistory = BiaoGe.auctionMSGhistory or {}


    local maxLine = 1000
    local normalX, normalY = 250, 230
    local bigX, bigY = 400, 230
    -- UI
    do
        BG.FrameAuctionMSGbg = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
        BG.FrameAuctionMSGbg:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        BG.FrameAuctionMSGbg:SetBackdropColor(0, 0, 0, 0.8)
        BG.FrameAuctionMSGbg:SetPoint("CENTER")
        if BiaoGe.auctionMSGIsBig then
            BG.FrameAuctionMSGbg:SetSize(bigX, bigY)
        else
            BG.FrameAuctionMSGbg:SetSize(normalX, normalY)
        end
        BG.FrameAuctionMSGbg:SetFrameLevel(120)
        BG.FrameAuctionMSGbg:EnableMouse(true)
        BG.FrameAuctionMSGbg:Hide()

        local _f = CreateFrame("Frame", nil, BG.FrameAuctionMSGbg)
        _f:SetSize(1, 1)
        _f:SetPoint("TOPRIGHT", 0, 1)
        BG.FrameAuctionMSGbg.tooltip = _f

        local f = CreateFrame("ScrollingMessageFrame", nil, BG.FrameAuctionMSGbg)
        f:SetSpacing(1)       -- 行间隔
        f:SetFading(false)
        f:SetJustifyH("LEFT") -- 对齐格式
        f:SetPoint("TOPLEFT", 7, -7)
        f:SetPoint("BOTTOMRIGHT", -7, 7)
        f:SetMaxLines(maxLine)
        f:SetFontObject(GameFontNormalSmall2)
        f:SetJustifyH("LEFT")
        f:SetHyperlinksEnabled(true)
        BG.FrameAuctionMSG = f
        f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
            GameTooltip:SetOwner(BG.FrameAuctionMSGbg.tooltip, "ANCHOR_BOTTOMRIGHT", 0, 0)
            GameTooltip:ClearLines()
            local itemID = GetItemInfoInstant(link)
            if itemID then
                GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))
                BG.Show_AllHighlight(link)
            end
        end)
        f:SetScript("OnHyperlinkLeave", function(self, link, text, button)
            GameTooltip:Hide()
            BG.Hide_AllHighlight()
        end)
        f:SetScript("OnHyperlinkClick", function(self, link, text, button)
            if (strsub(link, 1, 6) == "player") then
                local _, name, lineID, chatType = strsplit(":", link)
                if button == "LeftButton" then
                    if IsShiftKeyDown() then
                        ChatFrame_SendTell(name, ChatFrame1)
                    else
                        if BG.maijiaButton then
                            BG.PlaySound(1)
                            BG.maijiaButton:SetTextColor(GetClassRGB(name))
                            BG.maijiaButton:SetText(name)
                            BG.maijiaButton:SetCursorPosition(0)
                        end
                    end
                end
            elseif (strsub(link, 1, 4) == "item") then
                local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
                if IsShiftKeyDown() then
                    BG.InsertLink(text)
                elseif IsAltKeyDown() then
                    if BG.IsML then -- 开始拍卖
                        BG.StartAuction(link, nil, nil, nil, button == "RightButton")
                    else
                        if button ~= "RightButton" then
                            BG.AddGuanZhu(link)
                        end
                    end
                else
                    ShowUIPanel(ItemRefTooltip)
                    if (not ItemRefTooltip:IsShown()) then
                        ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
                    end
                    ItemRefTooltip:SetHyperlink(link)
                end
            end
        end)
        f:SetScript("OnShow", function(self)
            if not BG.FrameAuctionMSG:AtBottom() then
                BG.FrameAuctionMSG.hilighttexture:Show()
            else
                BG.FrameAuctionMSG.hilighttexture:Hide()
            end
            self.UpdateButtonItem()
        end)
        hooksecurefunc(f, "RefreshDisplay", function(self)
            self.UpdateButtonItem()
        end)

        local t = GetServerTime()
        for i = #BiaoGe.auctionMSGhistory, 1, -1 do
            if type(BiaoGe.auctionMSGhistory[i]) == "table" then
                if t - BiaoGe.auctionMSGhistory[i].time > 60 * 60 * 12 then
                    tremove(BiaoGe.auctionMSGhistory, i)
                end
            end
        end

        for i, v in ipairs(BiaoGe.auctionMSGhistory) do
            if type(v) == "table" then
                local info = date("*t", v.time)
                local hour, min = info.hour, info.min
                hour = string.format("%02d", hour)
                min = string.format("%02d", min)
                local _time = "|cff" .. "808080" .. hour .. ":" .. min .. "|r"
                local msg = _time .. " |cff" .. v.textColor .. v.nameLink .. L["："] .. v.text .. RN
                BG.FrameAuctionMSG:AddMessage(msg)
            end
        end
    end

    -- 滚动按钮
    do
        local bt = CreateFrame("Button", nil, BG.FrameAuctionMSG) -- 到底
        bt:SetSize(30, 30)
        bt:SetPoint("BOTTOMRIGHT", BG.FrameAuctionMSG, "BOTTOMLEFT", -2, -10)
        bt:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollEnd-Up")
        bt:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollEnd-Down")
        bt:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-ScrollEnd-Disabled")
        bt:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
        local chatbt = bt
        local texture = bt:CreateTexture(nil, "BACKGROUND") -- 高亮材质
        texture:SetPoint("TOPLEFT", -2, 2)
        texture:SetPoint("BOTTOMRIGHT", 2, -2)
        texture:SetTexture("Interface/ChatFrame/UI-ChatIcon-BlinkHilight")
        texture:Hide()
        BG.FrameAuctionMSG.hilighttexture = texture
        local flashGroup = texture:CreateAnimationGroup()
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
        bt:SetScript("OnClick", function(self)
            BG.PlaySound(1)
            self:GetParent():ScrollToBottom()
            BG.FrameAuctionMSG.hilighttexture:Hide()
        end)

        local bt = CreateFrame("Button", nil, BG.FrameAuctionMSG) -- 下滚
        bt:SetSize(30, 30)
        bt:SetPoint("BOTTOM", chatbt, "TOP", 0, -8)
        bt:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Up")
        bt:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Down")
        bt:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Disabled")
        bt:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
        local chatbt = bt
        bt:SetScript("OnClick", function(self)
            self:GetParent():ScrollDown()
            self:GetParent():ScrollDown()
            if BG.FrameAuctionMSG:AtBottom() then
                BG.FrameAuctionMSG.hilighttexture:Hide()
            end
        end)
        bt:SetScript("OnMouseDown", function(self)
            BG.PlaySound(1)
            local t = 0
            local t_do = 0.3
            self:SetScript("OnUpdate", function(self, elapsed)
                t = t + elapsed
                if t >= t_do then
                    t = t_do - 0.05
                    self:GetParent():ScrollDown()
                    if BG.FrameAuctionMSG:AtBottom() then
                        BG.FrameAuctionMSG.hilighttexture:Hide()
                    end
                end
            end)
        end)
        bt:SetScript("OnMouseUp", function(self)
            self:SetScript("OnUpdate", nil)
        end)


        local bt = CreateFrame("Button", nil, BG.FrameAuctionMSG) -- 上滚
        bt:SetSize(30, 30)
        bt:SetPoint("BOTTOM", chatbt, "TOP", 0, -8)
        bt:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Up")
        bt:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Down")
        bt:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Disabled")
        bt:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
        local chatbt = bt
        bt:SetScript("OnClick", function(self)
            self:GetParent():ScrollUp()
            self:GetParent():ScrollUp()
        end)
        bt:SetScript("OnMouseDown", function(self)
            BG.PlaySound(1)
            local t = 0
            local t_do = 0.3
            self:SetScript("OnUpdate", function(self, elapsed)
                t = t + elapsed
                if t >= t_do then
                    t = t_do - 0.05
                    self:GetParent():ScrollUp()
                end
            end)
        end)
        bt:SetScript("OnMouseUp", function(self)
            self:SetScript("OnUpdate", nil)
        end)

        local bt = CreateFrame("Button", nil, BG.FrameAuctionMSG) -- 放大
        bt:SetSize(18, 18)
        bt:SetPoint("BOTTOM", chatbt, "TOP", 1, -2)
        BG.SetButtonAtlas(bt, "common-icon-zoomin")
        BG.FrameAuctionMSG.buttonBig = bt
        if BiaoGe.auctionMSGIsBig then
            bt:Hide()
        end
        bt:SetScript("OnClick", function(self)
            BG.PlaySound(1)
            BG.FrameAuctionMSGbg:SetSize(bigX, bigY)
            BG.FrameAuctionMSG.buttonBig:Hide()
            BG.FrameAuctionMSG.buttonSmall:Show()
            BiaoGe.auctionMSGIsBig = true
        end)
        local bt = CreateFrame("Button", nil, BG.FrameAuctionMSG) -- 缩小
        bt:SetSize(18, 18)
        bt:SetPoint("BOTTOM", chatbt, "TOP", 1, -2)
        BG.SetButtonAtlas(bt, "common-icon-zoomout")
        BG.FrameAuctionMSG.buttonSmall = bt
        if not BiaoGe.auctionMSGIsBig then
            bt:Hide()
        end
        bt:SetScript("OnClick", function(self)
            BG.PlaySound(1)
            BG.FrameAuctionMSGbg:SetSize(normalX, normalY)
            BG.FrameAuctionMSG.buttonBig:Show()
            BG.FrameAuctionMSG.buttonSmall:Hide()
            BiaoGe.auctionMSGIsBig = nil
        end)

        -- 提示
        local bt = CreateFrame("Button", nil, BG.FrameAuctionMSG)
        bt:SetSize(25, 25)
        bt:SetPoint("BOTTOM", chatbt, "TOP", 0, 16)
        local tex = bt:CreateTexture()
        tex:SetAllPoints()
        tex:SetTexture(616343)
        tex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
        local tex2 = bt:CreateTexture()
        tex2:SetAllPoints()
        tex2:SetTexture(616343)
        tex2:SetTexCoord(0.1, 0.9, 0.1, 0.9)
        bt:SetNormalTexture(tex)
        bt:SetHighlightTexture(tex2)
        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["拍卖聊天记录框"], 1, 1, 1)
            GameTooltip:AddLine(format(L["|cffFFFFFF%s玩家名字：|r设置为买家"], AddTexture("LEFT")), 1, 0.82, 0, true)
            GameTooltip:AddLine(format(L["|cffFFFFFFSHIFT+%s玩家名字：|r密语"], AddTexture("LEFT")), 1, 0.82, 0, true)
            GameTooltip:AddLine(L["|cffFFFFFFCTRL+滚轮：|r快速滚动"], 1, 0.82, 0, true)
            GameTooltip:AddLine(L["|cffFFFFFFSHIFT+滚轮：|r滚动到最前/最后"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        BG.GameTooltip_Hide(bt)

        BG.FrameAuctionMSG:SetScript("OnMouseWheel", function(self, delta, ...)
            if delta == 1 then
                if IsShiftKeyDown() then
                    self:ScrollToTop()
                elseif IsControlKeyDown() then
                    self:ScrollUp()
                    self:ScrollUp()
                    self:ScrollUp()
                    self:ScrollUp()
                    self:ScrollUp()
                else
                    self:ScrollUp()
                    self:ScrollUp()
                end
            elseif delta == -1 then
                if IsShiftKeyDown() then
                    self:ScrollToBottom()
                    BG.FrameAuctionMSG.hilighttexture:Hide()
                elseif IsControlKeyDown() then
                    self:ScrollDown()
                    self:ScrollDown()
                    self:ScrollDown()
                    self:ScrollDown()
                    self:ScrollDown()
                else
                    self:ScrollDown()
                    self:ScrollDown()
                    if self:AtBottom() then
                        BG.FrameAuctionMSG.hilighttexture:Hide()
                    end
                end
            end
        end)
    end

    -- 监控聊天事件
    do
        local blacklist = {
            "spell",
            "achievement",
            "enchant",
            "JT",
            L["次"],
            "、",
            L["打断"],
            -- "<",
            -- ">",
            L["级"],
            L["装等"],
            L["分钟"],
            L["时间"],
        }

        local function AddMSG(text, playerName, lineID, ML)
            if string.find(text, "%d+") or string.find(text, "[pP]") or ML then
                text = BG.GsubRaidTargetingIcons(text)
                local msg
                local hour, min = GetGameTime()
                hour = string.format("%02d", hour)
                min = string.format("%02d", min)
                local _time = "|cff" .. "808080" .. hour .. ":" .. min .. "|r"
                local nameLink = "|Hplayer:" .. playerName .. ":" .. lineID .. ":RAID:" .. "|h[" .. SetClassCFF(playerName) .. "]|h"
                if ML then
                    msg = _time .. " " .. "|cffFF4500" .. nameLink .. L["："] .. text .. RN -- 物品分配者聊天
                else
                    msg = _time .. " " .. "|cffFF7F50" .. nameLink .. L["："] .. text .. RN -- 团员聊天
                end
                BG.FrameAuctionMSG:AddMessage(msg)

                tinsert(BiaoGe.auctionMSGhistory, {
                    time = GetServerTime(),
                    textColor = ML and "FF4500" or "FF7F50",
                    nameLink = nameLink,
                    text = text,
                })
                for i, v in ipairs(BiaoGe.auctionMSGhistory) do
                    if #BiaoGe.auctionMSGhistory <= maxLine then
                        break
                    end
                    tremove(BiaoGe.auctionMSGhistory, 1)
                end

                if not BG.FrameAuctionMSG:AtBottom() then
                    BG.FrameAuctionMSG.hilighttexture:Show()
                end
            end
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_RAID_WARNING")
        f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:RegisterEvent("CHAT_MSG_RAID")
        f:SetScript("OnEvent", function(self, event, ...)
            local msg, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid = ...
            local ML
            playerName = BG.GSN(playerName)
            if event == "CHAT_MSG_RAID_WARNING" or event == "CHAT_MSG_RAID_LEADER" then
                ML = true
            elseif event == "CHAT_MSG_RAID" then
                if playerName == BG.masterLooter then
                    ML = true
                end
            end
            for key, text in pairs(blacklist) do
                if string.find(msg, text) and not string.find(msg, "item:") then
                    return
                end
            end
            AddMSG(msg, playerName, lineID, ML)
        end)
    end

    -- 定位装备
    do
        local function SetItemButtonUpColor(r, g, b)
            BG.FrameAuctionMSG.buttonItemUp:GetNormalTexture():SetVertexColor(r, g, b)
            BG.FrameAuctionMSG.buttonItemUp:GetPushedTexture():SetVertexColor(r, g, b)
            BG.FrameAuctionMSG.buttonItemUp:GetHighlightTexture():SetVertexColor(r, g, b)
        end
        local function SetItemButtonDownColor(r, g, b)
            BG.FrameAuctionMSG.buttonItemDown:GetNormalTexture():SetVertexColor(r, g, b)
            BG.FrameAuctionMSG.buttonItemDown:GetPushedTexture():SetVertexColor(r, g, b)
            BG.FrameAuctionMSG.buttonItemDown:GetHighlightTexture():SetVertexColor(r, g, b)
        end
        local function Find(itemID, i, mod)
            if not BG.FrameAuctionMSG.historyBuffer.elements[i] then return end
            local headIndex = BG.FrameAuctionMSG.historyBuffer.headIndex
            local message = BG.FrameAuctionMSG.historyBuffer.elements[i].message
            if message:find("item:" .. itemID .. ":") then
                if not mod then
                    local offset
                    if BG.FrameAuctionMSG.historyBuffer:IsFull() then
                        offset = (headIndex - i + maxLine) % maxLine
                    else
                        offset = headIndex - i
                    end
                    BG.FrameAuctionMSG:SetScrollOffset(offset)
                    BG.FrameAuctionMSG:ResetAllFadeTimes()
                end
                return true
            end
        end
        local function OnClick(self)
            --[[
            ...
            91
            92
            93
            94
            95
            96
            97
            98
            99
            100
            1
            2
            3
            4
            5
            6
            7
            8
            9
            10
            ]]
            BG.PlaySound(1)
            local item = BG.FrameAuctionMSG.item
            local itemID = GetItemID(item)
            if not itemID then return end
            local maxLine = BG.FrameAuctionMSG:GetMaxLines()
            local headIndex = BG.FrameAuctionMSG.historyBuffer.headIndex
            local offset = BG.FrameAuctionMSG.scrollOffset
            local elements = #BG.FrameAuctionMSG.historyBuffer.elements
            if self.type == "up" then
                if BG.FrameAuctionMSG.historyBuffer:IsFull() then
                    for offset = offset, elements do
                        local i = (headIndex - (offset + 1) + maxLine) % maxLine
                        if Find(itemID, i) then return end
                    end
                else
                    for i = #BG.FrameAuctionMSG.historyBuffer.elements - offset - 1, 1, -1 do
                        if Find(itemID, i) then return end
                    end
                end
            elseif self.type == "down" then
                if BG.FrameAuctionMSG.historyBuffer:IsFull() then
                    for offset = offset, 0, -1 do
                        local i = (headIndex - (offset - 1) + maxLine) % maxLine
                        if Find(itemID, i) then return end
                    end
                else
                    for i = #BG.FrameAuctionMSG.historyBuffer.elements - offset + 1, #BG.FrameAuctionMSG.historyBuffer.elements do
                        if Find(itemID, i) then return end
                    end
                end
            end
        end

        local function UpdateButtonItemUp()
            if not BG.FrameAuctionMSG:IsVisible() then return end
            SetItemButtonUpColor(1, 0, 0)
            local item = BG.FrameAuctionMSG.item
            local itemID = GetItemID(item)
            if not itemID then return end
            local maxLine = BG.FrameAuctionMSG:GetMaxLines()
            local headIndex = BG.FrameAuctionMSG.historyBuffer.headIndex
            local offset = BG.FrameAuctionMSG.scrollOffset
            local elements = #BG.FrameAuctionMSG.historyBuffer.elements
            if BG.FrameAuctionMSG.historyBuffer:IsFull() then
                for offset = offset, elements do
                    local i = (headIndex - (offset + 1) + maxLine) % maxLine
                    if Find(itemID, i, true) then
                        SetItemButtonUpColor(0, 1, 0)
                        return
                    end
                end
            else
                for i = #BG.FrameAuctionMSG.historyBuffer.elements - offset - 1, 1, -1 do
                    if Find(itemID, i, true) then
                        SetItemButtonUpColor(0, 1, 0)
                        return
                    end
                end
            end
        end
        local function UpdateButtonItemDown()
            if not BG.FrameAuctionMSG:IsVisible() then return end
            SetItemButtonDownColor(1, 0, 0)
            local item = BG.FrameAuctionMSG.item
            local itemID = GetItemID(item)
            if not itemID then return end
            local maxLine = BG.FrameAuctionMSG:GetMaxLines()
            local headIndex = BG.FrameAuctionMSG.historyBuffer.headIndex
            local offset = BG.FrameAuctionMSG.scrollOffset
            if BG.FrameAuctionMSG.historyBuffer:IsFull() then
                for offset = offset, 0, -1 do
                    local i = (headIndex - (offset - 1) + maxLine) % maxLine
                    if Find(itemID, i, true) then
                        SetItemButtonDownColor(0, 1, 0)
                        return
                    end
                end
            else
                for i = #BG.FrameAuctionMSG.historyBuffer.elements - offset + 1, #BG.FrameAuctionMSG.historyBuffer.elements do
                    if Find(itemID, i, true) then
                        SetItemButtonDownColor(0, 1, 0)
                        return
                    end
                end
            end
        end


        function BG.FrameAuctionMSG.UpdateButtonItem()
            UpdateButtonItemUp()
            UpdateButtonItemDown()
            local offset = BG.FrameAuctionMSG.scrollOffset
            local headIndex = BG.FrameAuctionMSG.historyBuffer.headIndex
            local elements = #BG.FrameAuctionMSG.historyBuffer.elements
            local i = (headIndex - offset + maxLine) % maxLine
            -- local text = "offset:" .. BG.STC_w1(offset) .. NN
            --     .. "i:" .. BG.STC_w1(i) .. NN
            --     .. "headIndex:" .. BG.STC_w1(headIndex) .. NN
            --     .. "elements:" .. BG.STC_w1(elements) .. NN
            --     .. "maxLine:" .. BG.STC_w1(maxLine) .. NN
            local text = (offset + 1) .. "/" .. elements
            BG.FrameAuctionMSG.lineText:SetText(text)
        end

        local t = BG.FrameAuctionMSG:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
        t:SetPoint("TOPRIGHT", BG.FrameAuctionMSG, "BOTTOMRIGHT", 5, -7)
        t:SetTextColor(1, 0.82, 0)
        t:SetJustifyH("LEFT")
        BG.FrameAuctionMSG.lineText = t

        local lastbutton
        -- 提示
        local bt = CreateFrame("Button", nil, BG.FrameAuctionMSG)
        bt:SetSize(25, 25)
        bt:SetPoint("TOPRIGHT", BG.FrameAuctionMSG, "TOPLEFT", -4, 5)
        local tex = bt:CreateTexture()
        tex:SetAllPoints()
        tex:SetTexture(616343)
        tex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
        local tex2 = bt:CreateTexture()
        tex2:SetAllPoints()
        tex2:SetTexture(616343)
        tex2:SetTexCoord(0.1, 0.9, 0.1, 0.9)
        bt:SetNormalTexture(tex)
        bt:SetHighlightTexture(tex2)
        lastbutton = bt
        bt:SetScript("OnEnter", function(self)
            local item = BG.FrameAuctionMSG.item or ""
            local tip = ""
            if item == "" then
                tip = BG.STC_r1(L["（当前装备为空）"])
            end
            GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["定位装备"], 1, 1, 1)
            GameTooltip:AddLine(format(L["把拍卖聊天记录定位到当前装备%s所在处。%s"], item, tip), 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", GameTooltip_Hide)

        local color = { 0, 1, 0 }
        local bt = CreateFrame("Button", nil, BG.FrameAuctionMSG) -- 上滚
        bt.type = "up"
        BG.FrameAuctionMSG.buttonItemUp = bt
        bt:SetSize(30, 30)
        bt:SetPoint("TOP", lastbutton, "BOTTOM", 0, 8)
        bt:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Up")
        bt:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Down")
        bt:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Disabled")
        bt:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
        bt:GetNormalTexture():SetVertexColor(unpack(color))
        bt:GetPushedTexture():SetVertexColor(unpack(color))
        bt:GetHighlightTexture():SetVertexColor(unpack(color))
        lastbutton = bt
        bt:SetScript("OnClick", OnClick)

        local bt = CreateFrame("Button", nil, BG.FrameAuctionMSG) -- 下滚
        bt.type = "down"
        BG.FrameAuctionMSG.buttonItemDown = bt
        bt:SetSize(30, 30)
        bt:SetPoint("TOP", lastbutton, "BOTTOM", 0, 8)
        bt:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Up")
        bt:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Down")
        bt:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Disabled")
        bt:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
        bt:GetNormalTexture():SetVertexColor(unpack(color))
        bt:GetPushedTexture():SetVertexColor(unpack(color))
        bt:GetHighlightTexture():SetVertexColor(unpack(color))
        bt:SetScript("OnClick", OnClick)
    end
end)
