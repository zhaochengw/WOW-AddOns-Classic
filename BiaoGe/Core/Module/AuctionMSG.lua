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

local Width = ADDONSELF.Width
local Height = ADDONSELF.Height
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local pt = print

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName ~= AddonName then return end
    -- UI
    do
        BG.FramePaiMaiMsg = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
        BG.FramePaiMaiMsg:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        BG.FramePaiMaiMsg:SetBackdropColor(0, 0, 0, 0.8)
        BG.FramePaiMaiMsg:SetPoint("CENTER")
        BG.FramePaiMaiMsg:SetSize(220, 230) -- 大小
        BG.FramePaiMaiMsg:SetFrameLevel(120)
        BG.FramePaiMaiMsg:EnableMouse(true)
        BG.FramePaiMaiMsg:Hide()

        local f = CreateFrame("ScrollingMessageFrame", nil, BG.FramePaiMaiMsg)
        f:SetSpacing(1)                                                                  -- 行间隔
        f:SetFading(false)
        f:SetJustifyH("LEFT")                                                            -- 对齐格式
        f:SetSize(BG.FramePaiMaiMsg:GetWidth() - 15, BG.FramePaiMaiMsg:GetHeight() - 15) -- 大小
        f:SetPoint("CENTER", BG.FramePaiMaiMsg)                                          --设置显示位置
        f:SetMaxLines(1000)
        f:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
        f:SetHyperlinksEnabled(true)
        BG.FramePaiMaiMsg2 = f
        f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR", 0, 0)
            GameTooltip:ClearLines()
            local itemID = GetItemInfoInstant(link)
            if itemID then
                GameTooltip:SetItemByID(itemID)
                GameTooltip:Show()
            end
        end)
        f:SetScript("OnHyperlinkLeave", function(self, link, text, button)
            GameTooltip:Hide()
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
                elseif button == "RightButton" then
                end
            elseif (strsub(link, 1, 4) == "item") then
                local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
                if IsShiftKeyDown() then
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    ChatEdit_InsertLink(text)
                elseif IsAltKeyDown() then
                    if BG.IsLeader then -- 开始拍卖
                        BG.StartAuction(link)
                    else
                        for b = 1, Maxb[BG.FB1], 1 do
                            for i = 1, Maxi[BG.FB1], 1 do
                                if BG.Frame[BG.FB1]["boss" .. b]["zhuangbei" .. i] then
                                    if GetItemID(link) == GetItemID(BG.Frame[BG.FB1]["boss" .. b]["zhuangbei" .. i]:GetText()) then
                                        BiaoGe[BG.FB1]["boss" .. b]["guanzhu" .. i] = true
                                        BG.Frame[BG.FB1]["boss" .. b]["guanzhu" .. i]:Show()
                                        BG.FrameLootMsg:AddMessage(BG.STC_g2(format(L["已成功关注装备：%s。团长拍卖此装备时会提醒"],
                                            AddTexture(Texture) .. link)))
                                        return
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end

    -- 滚动按钮
    local hilighttexture
    do
        local bt = CreateFrame("Button", nil, BG.FramePaiMaiMsg2) -- 到底
        bt:SetSize(30, 30)
        bt:SetPoint("BOTTOMRIGHT", BG.FramePaiMaiMsg2, "BOTTOMLEFT", -2, -10)
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

        local bt = CreateFrame("Button", nil, BG.FramePaiMaiMsg2) -- 下滚
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
            if BG.FramePaiMaiMsg2:AtBottom() then
                hilighttexture:Hide()
            end
        end)
        local bt = CreateFrame("Button", nil, BG.FramePaiMaiMsg2) -- 上滚
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
        local bt = CreateFrame("Button", nil, BG.FramePaiMaiMsg2)
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

        BG.FramePaiMaiMsg2:SetScript("OnMouseWheel", function(self, delta, ...)
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

        local function AddMsg(text, playerName, lineID, ML)
            if string.find(text, "%d+") or string.find(text, "[pP]") or ML then
                local msg
                local h, m = GetGameTime()
                h = string.format("%02d", h)
                m = string.format("%02d", m)
                local time = "|cff" .. "808080" .. "(" .. h .. ":" .. m .. ")|r"
                local nameLink = "|Hplayer:" .. playerName .. ":" .. lineID .. ":RAID:" .. "|h[" .. SetClassCFF(playerName) .. "]|h"
                if ML then
                    msg = time .. " " .. "|cffFF4500" .. nameLink .. "：" .. text .. RN -- 物品分配者聊天
                else
                    msg = time .. " " .. "|cffFF7F50" .. nameLink .. "：" .. text .. RN -- 团员聊天
                end
                BG.FramePaiMaiMsg2:AddMessage(msg)
                if not BG.FramePaiMaiMsg2:AtBottom() then
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
            AddMsg(msg, playerName, lineID, ML)
        end)
    end
end)
