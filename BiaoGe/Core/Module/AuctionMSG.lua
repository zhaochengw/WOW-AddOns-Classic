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

local Width = ns.Width
local Height = ns.Height
local Maxb = ns.Maxb
local Maxi = ns.Maxi
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName ~= AddonName then return end

    BiaoGe.auctionMSGhistory = BiaoGe.auctionMSGhistory or {}

    local maxLine = 1000

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
        BG.FrameAuctionMSGbg:SetSize(220, 230) -- 大小
        BG.FrameAuctionMSGbg:SetFrameLevel(120)
        BG.FrameAuctionMSGbg:EnableMouse(true)
        BG.FrameAuctionMSGbg:Hide()

        local f = CreateFrame("ScrollingMessageFrame", nil, BG.FrameAuctionMSGbg)
        f:SetSpacing(1)                                                                        -- 行间隔
        f:SetFading(false)
        f:SetJustifyH("LEFT")                                                                  -- 对齐格式
        f:SetSize(BG.FrameAuctionMSGbg:GetWidth() - 15, BG.FrameAuctionMSGbg:GetHeight() - 15) -- 大小
        f:SetPoint("CENTER", BG.FrameAuctionMSGbg)                                             --设置显示位置
        f:SetMaxLines(maxLine)
        f:SetFontObject(GameFontNormalSmall2)
        f:SetJustifyH("LEFT")
        f:SetHyperlinksEnabled(true)
        BG.FrameAuctionMSG = f
        f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR", 0, 0)
            GameTooltip:ClearLines()
            local itemID = GetItemInfoInstant(link)
            if itemID then
                GameTooltip:SetItemByID(itemID)
                GameTooltip:Show()
                BG.HighlightBiaoGe(link)
                BG.HighlightBag(link)
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
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    ChatEdit_InsertLink(text)
                elseif IsAltKeyDown() then
                    if BG.IsML then -- 开始拍卖
                        BG.StartAuction(link)
                    else
                        BG.AddGuanZhu(link)
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
        for i, msg in ipairs(BiaoGe.auctionMSGhistory) do
            BG.FrameAuctionMSG:AddMessage(msg)
        end
    end

    -- 滚动按钮
    local hilighttexture
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
        texture:SetAllPoints()
        texture:SetTexture("Interface/ChatFrame/UI-ChatIcon-BlinkHilight")
        texture:Hide()
        hilighttexture = texture
        C_Timer.NewTicker(1, function()
            if time() % 2 == 0 then
                texture:SetAlpha(0)
            else
                texture:SetAlpha(1)
            end
        end)
        bt:SetScript("OnClick", function(self)
            self:GetParent():ScrollToBottom()
            hilighttexture:Hide()
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
                hilighttexture:Hide()
            end
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
        -- 提示
        local bt = CreateFrame("Button", nil, BG.FrameAuctionMSG)
        bt:SetSize(25, 25)
        bt:SetPoint("BOTTOM", chatbt, "TOP", 0, -5)
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
            GameTooltip:AddLine(L["|cffFFFFFF左键玩家名字：|r设置为买家"], 1, 0.82, 0, true)
            GameTooltip:AddLine(L["|cffFFFFFFSHIFT+左键玩家名字：|r密语"], 1, 0.82, 0, true)
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
                    hilighttexture:Hide()
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
                        hilighttexture:Hide()
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
                local h, m = GetGameTime()
                h = string.format("%02d", h)
                m = string.format("%02d", m)
                local time = "|cff" .. "808080" .. "(" .. h .. ":" .. m .. ")|r"
                local nameLink = "|Hplayer:" .. playerName .. ":" .. lineID .. ":RAID:" .. "|h[" .. SetClassCFF(playerName) .. "]|h"
                if ML then
                    msg = time .. " " .. "|cffFF4500" .. nameLink .. L["："] .. text .. RN -- 物品分配者聊天
                else
                    msg = time .. " " .. "|cffFF7F50" .. nameLink .. L["："] .. text .. RN -- 团员聊天
                end
                BG.FrameAuctionMSG:AddMessage(msg)

                for i, v in ipairs(BiaoGe.auctionMSGhistory) do
                    if #BiaoGe.auctionMSGhistory <= maxLine then
                        break
                    end
                    tremove(BiaoGe.auctionMSGhistory, 1)
                end
                tinsert(BiaoGe.auctionMSGhistory, msg)

                if not BG.FrameAuctionMSG:AtBottom() then
                    hilighttexture:Show()
                end
            end
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_RAID_WARNING")
        f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:RegisterEvent("CHAT_MSG_RAID")
        f:SetScript("OnEvent", function(self, even, ...)
            local msg, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid = ...
            playerName = strsplit("-", playerName)
            local ML
            if even == "CHAT_MSG_RAID_WARNING" or even == "CHAT_MSG_RAID_LEADER" then
                ML = true
            elseif even == "CHAT_MSG_RAID" then
                if playerName == BG.MasterLooter then
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
end)
