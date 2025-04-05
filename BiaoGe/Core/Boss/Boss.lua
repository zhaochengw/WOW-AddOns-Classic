if BG.IsBlackListPlayer then return end
if not BG.IsWLK then return end

local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local Maxb = ns.Maxb
local BossNum = ns.BossNum
local AddTexture = ns.AddTexture

local pt = print

local BOSS_TEXT_FONT
local l = GetLocale()
if (l == "koKR") then
    BOSS_TEXT_FONT = "Fonts\\2002.TTF";
elseif (l == "zhCN") then
    BOSS_TEXT_FONT = "Fonts\\ARKai_T.TTF";
elseif (l == "zhTW") then
    BOSS_TEXT_FONT = "Fonts\\ARKai_T.TTF";
    -- BOSS_TEXT_FONT = "Fonts\\blei00d.TTF";
elseif (l == "ruRU") then
    BOSS_TEXT_FONT = "Fonts\\FRIZQT___CYR.TTF";
else
    BOSS_TEXT_FONT = "Fonts\\FRIZQT__.TTF";
end

local function P_color(text)
    if not text then return "" end
    text = "|cff" .. "00FF00" .. "(" .. text .. ")|r"
    return text
end

BG.Init(function()
    local name = "BossFontSize"
    BG.options[name .. "reset"] = 15
    local fontsize = BiaoGe.options["BossFontSize"] or BG.options[name .. "reset"]
    local fontsize2 = 18 -- BOSS、NPC名字
    local fontsize3 = 17 -- 法術名字、職責名字
    local fontsize4 = 15 -- 阶段文字（P1、P2、全程）

    local textable = {
        ICC = {
            "interface/encounterjournal/ui-ej-boss-lord marrowgar",        -- 1
            "interface/encounterjournal/ui-ej-boss-lady deathwhisper",     -- 2
            UnitFactionGroup("player") == "Horde" and 1385736 or 1385737,  -- 3
            "Interface/EncounterJournal/UI-EJ-BOSS-Deathbringer Saurfang", -- 4
            "Interface/EncounterJournal/UI-EJ-BOSS-Festergut",             -- 5
            "Interface/EncounterJournal/UI-EJ-BOSS-Rotface",               -- 6
            1379007,                                                       -- 7
            1385721,                                                       -- 8
            1378967,                                                       -- 9
            1379023,                                                       -- 10
            1379014,                                                       -- 11
            1379021,                                                       -- 12
            1385738,                                                       -- 13
        }
    }

    -- 创建主UI -- BG.BossFrameICC，ICC
    function BG.CreateBossNameUI(frame, FB)
        -- 左边Boss名字列表
        local f = CreateFrame("Frame", nil, frame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetSize(230, 700)
        f:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 25, -80)
        frame.BossNameFrame = f
        local t = f:CreateFontString()
        t:SetFont(BOSS_TEXT_FONT, 15, "OUTLINE")
        t:SetTextColor(RGB(BG.y2))
        t:SetPoint("BOTTOM", f, "TOP", 0, 0)
        t:SetText(L["< BOSS >"])
        t:SetTextColor(1, 1, 1)

        -- 中间技能介绍
        local f = CreateFrame("Frame", nil, frame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetSize(620, 700)
        f:SetPoint("TOPLEFT", frame.BossNameFrame, "TOPRIGHT", 10, 0)
        frame.spellFramebg = f
        local t = f:CreateFontString()
        t:SetFont(BOSS_TEXT_FONT, 15, "OUTLINE")
        t:SetTextColor(RGB(BG.y2))
        t:SetPoint("BOTTOM", f, "TOP", 0, 0)
        t:SetText(L["< 技能应对 >"])
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
            GameTooltip:SetText(L["该攻略是按照25H去呈现，但由于暴雪数据库问题，部分技能链接里的描述文本并不符合25H的真实情况。请看技能的介绍文本"], 1, 0.84, 0, 1, true)
        end)
        BG.GameTooltip_Hide(bt)

        local t = f:CreateFontString(nil, "ARTWORK")
        t:SetFont(BOSS_TEXT_FONT, 13, "OUTLINE")
        t:SetPoint("TOP", f, "BOTTOM", 0, 0)
        t:SetTextColor(RGB(BG.dis))
        t:SetText(L["（SHIFT+点击技能可发送到聊天框）"])

        -- 右边职业职责
        local f = CreateFrame("Frame", nil, frame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.4)
        f:SetSize(370, 700)
        f:SetPoint("TOPLEFT", frame.spellFramebg, "TOPRIGHT", 10, 0)
        frame.classFramebg = f
        local t = f:CreateFontString()
        t:SetFont(BOSS_TEXT_FONT, 15, "OUTLINE")
        t:SetTextColor(RGB(BG.y2))
        t:SetPoint("BOTTOM", f, "TOP", 0, 0)
        t:SetText(L["< 职业职责 >"])
        t:SetTextColor(1, 1, 1)

        -- 攻略作者
        do
            local f = CreateFrame("Frame", nil, frame.classFramebg)
            f:SetPoint("TOPRIGHT", frame.classFramebg, "BOTTOMRIGHT", -5, 0)
            local t = f:CreateFontString(nil, "ARTWORK")
            t:SetFont(BOSS_TEXT_FONT, 13, "OUTLINE")
            t:SetPoint("CENTER")
            t:SetJustifyH("RIGHT")
            t:SetTextColor(RGB(BG.dis))
            t:SetText(L["该BOSS攻略提供：@祈福-太乙公会 大树\n点击复制NGA攻略地址"])
            f:SetSize(t:GetStringWidth(), t:GetStringHeight())

            local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            edit:SetSize(400, 20)
            edit:SetPoint("TOPRIGHT", f, "BOTTOMRIGHT", -2, 0)
            edit:SetText("https://bbs.nga.cn/read.php?tid=37708565")
            edit:SetAutoFocus(true)
            edit:Hide()
            edit:SetScript("OnEditFocusGained", function(self)
                self:HighlightText()
            end)
            edit:SetScript("OnEscapePressed", function(self)
                self:Hide()
            end)
            local bt = CreateFrame("Button", nil, edit)
            bt:SetPoint("RIGHT")
            bt:SetSize(16, 16)
            bt:SetAlpha(0.5)
            bt:SetNormalTexture("Interface/FriendsFrame/ClearBroadcastIcon")
            bt:SetHighlightTexture("Interface/FriendsFrame/ClearBroadcastIcon")
            bt:SetScript("OnClick", function(self)
                self:GetParent():Hide()
            end)
            bt:SetScript("OnMouseDown", function(self)
                if self:IsEnabled() then
                    self:SetPoint("RIGHT", self:GetParent(), "RIGHT", 1, -1)
                end
            end)
            bt:SetScript("OnMouseUp", function(self)
                if self:IsEnabled() then
                    self:SetPoint("RIGHT", self:GetParent(), "RIGHT", 0, 0)
                end
                BG.PlaySound(1)
            end)

            f:SetScript("OnMouseUp", function(self)
                if not edit:IsVisible() then
                    edit:SetText("https://bbs.nga.cn/read.php?tid=37708565")
                    edit:HighlightText()
                    edit:Show()
                else
                    edit:Hide()
                end
                BG.PlaySound(1)
            end)
            f:SetScript("OnEnter", function(self)
                t:SetTextColor(RGB(BG.w1))
            end)
            f:SetScript("OnLeave", function(self)
                t:SetTextColor(RGB(BG.dis))
            end)
        end


        BG["BossTabButtons" .. FB] = {}
        local height = 35
        local texwidth = 90
        for i = 1, Maxb[FB] - 2 do
            -- 创建BOSS切换按钮
            local bt = BG.Create_Button1(frame.BossNameFrame)
            tinsert(BG["BossTabButtons" .. FB], bt)
            bt:SetPoint("TOPLEFT", 4, -5 - height * (i - 1) - 15 * i)
            bt:SetPoint("BOTTOMRIGHT", frame.BossNameFrame, "TOPRIGHT", -5, -5 - height * i - 15 * i)
            bt:SetText("|cff" .. BG.Boss[FB]["boss" .. i].color .. BG.Boss[FB]["boss" .. i].name2 .. RR)
            bt.text = bt:GetFontString()
            bt.text:SetPoint("LEFT", texwidth - 5, 0)
            frame["Boss" .. i] = bt
            if textable[FB] then
                local tex = bt:CreateTexture(nil, "OVERLAY")
                tex:SetSize(texwidth, 55)
                tex:SetPoint("LEFT", -5, 8)
                tex:SetTexture(textable[FB][i])
            end

            -- 创建技能介绍滚动框
            local f = CreateFrame("Frame", nil, frame)
            f:SetSize(frame.spellFramebg:GetWidth() - 28, frame.spellFramebg:GetHeight() - 10)
            frame["Boss" .. i].spellFrame = f
            local scroll = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
            scroll:SetPoint("TOPLEFT", frame.spellFramebg, "TOPLEFT", 0, -5)
            scroll:SetSize(frame.spellFramebg:GetWidth() - 28, frame.spellFramebg:GetHeight() - 10)
            scroll.ScrollBar.scrollStep = BG.scrollStep
            BG.CreateSrollBarBackdrop(scroll.ScrollBar)
            BG.HookScrollBarShowOrHide(scroll)

            scroll:SetScrollChild(f)
            frame["Boss" .. i].spellScrollFrame = scroll


            -- 创建职业职责滚动框
            local f = CreateFrame("Frame", nil, frame)
            f:SetSize(frame.classFramebg:GetWidth() - 28, frame.classFramebg:GetHeight() - 10)
            frame["Boss" .. i].classFrame = f
            local scroll = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
            scroll:SetPoint("TOPLEFT", frame.classFramebg, "TOPLEFT", 0, -5)
            scroll:SetSize(frame.classFramebg:GetWidth() - 28, frame.classFramebg:GetHeight() - 10)
            scroll.ScrollBar.scrollStep = BG.scrollStep
            BG.CreateSrollBarBackdrop(scroll.ScrollBar)
            BG.HookScrollBarShowOrHide(scroll)
            scroll:SetScrollChild(f)
            frame["Boss" .. i].classScrollFrame = scroll

            -- BOSS切换按钮点击
            bt:SetScript("OnClick", function(self)
                for i, v in ipairs(BG["BossTabButtons" .. FB]) do
                    v:Enable()
                    v.spellScrollFrame:Hide()
                    v.classScrollFrame:Hide()
                end
                self:Disable()
                self.spellScrollFrame:Show()
                self.classScrollFrame:Show()
                BiaoGe.BossFrame[FB].lastFrame = i
                BG.PlaySound(1)
            end)

            if not BiaoGe.BossFrame[FB].lastFrame then
                BiaoGe.BossFrame[FB].lastFrame = 1
            end
            if i == BiaoGe.BossFrame[FB].lastFrame then
                bt:Disable()
                bt.spellScrollFrame:Show()
                bt.classScrollFrame:Show()
            else
                bt:Enable()
                bt.spellScrollFrame:Hide()
                bt.classScrollFrame:Hide()
            end
        end
    end

    -- 创建每个NPC -- BG.BossFrameICC.Boss1.spellFrame，ICC，1
    function BG.CreateBossSpellFrameNpc(frame, NPCNum, bossName, bossOnEnterText, Pnum)
        -- NPC名字
        local f = CreateFrame("Frame", nil, frame)
        f:SetSize(frame:GetWidth(), 30)
        if NPCNum == 1 then
            f:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -5)
        else
            f:SetPoint("TOPLEFT", frame["NPCframe" .. NPCNum - 1], "BOTTOMLEFT", 5, -10)
        end
        frame["NPCname" .. NPCNum] = f
        local t = f:CreateFontString()
        t:SetFont(BOSS_TEXT_FONT, fontsize2, "OUTLINE")
        t:SetPoint("LEFT")
        if bossOnEnterText and bossOnEnterText ~= "" then
            t:SetText("[" .. bossName .. "]")
        else
            t:SetText(bossName)
        end
        t:SetTextColor(1, 1, 1)
        local w = t:GetStringWidth()
        f:SetWidth(w)

        -- 阶段文字（P1、P2、全程）
        local p_t = f:CreateFontString()
        p_t:SetFont(BOSS_TEXT_FONT, fontsize4, "OUTLINE")
        p_t:SetPoint("LEFT", t, "RIGHT", 3, 0)
        p_t:SetText(Pnum and P_color(Pnum) or "")
        frame["NPCnamePnum" .. NPCNum] = p_t

        -- 展开/收缩按钮
        local bt = CreateFrame("Frame", nil, frame, "BackdropTemplate")
        bt:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
        })
        bt:SetBackdropColor(0, 0, 0, 0)
        bt:SetBackdropBorderColor(0, 0, 0, 0)
        bt:SetSize(frame:GetWidth() - 10, 25)
        bt:SetPoint("LEFT", f, -5, 0)
        bt.open = true
        bt.tex = bt:CreateTexture()
        bt.tex:SetPoint("RIGHT")
        bt.tex:SetSize(20, 20)
        bt.tex:SetTexture(130821)

        local function Open()
            if frame["NPCframe" .. NPCNum].height then
                if bt.open then
                    local i = 1
                    while frame["NPCframe" .. NPCNum]["Spellname" .. i] do
                        frame["NPCframe" .. NPCNum]["Spellname" .. i]:Hide()
                        frame["NPCframe" .. NPCNum]["Spelldone" .. i]:Hide()
                        i = i + 1
                    end
                    frame["NPCframe" .. NPCNum]:SetHeight(2)
                    bt.tex:SetTexture(130838)
                    bt.open = nil
                else
                    local i = 1
                    while frame["NPCframe" .. NPCNum]["Spellname" .. i] do
                        frame["NPCframe" .. NPCNum]["Spellname" .. i]:Show()
                        frame["NPCframe" .. NPCNum]["Spelldone" .. i]:Show()
                        i = i + 1
                    end
                    frame["NPCframe" .. NPCNum]:SetHeight(frame["NPCframe" .. NPCNum].height)
                    bt.tex:SetTexture(130821)
                    bt.open = true
                end
                BG.PlaySound(1)
            end
        end

        f:SetScript("OnMouseDown", Open)
        bt:SetScript("OnMouseDown", Open)

        f:SetScript("OnEnter", function(self)
            if bossOnEnterText and bossOnEnterText ~= "" then
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(bossName, 1, 1, 1, true)
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine(bossOnEnterText, 1, 0.84, 0, true)
                GameTooltip:Show()
            end
            if frame["NPCframe" .. NPCNum].height then
                bt:SetBackdropColor(RGB(BG.y2, 0.1))
                bt:SetBackdropBorderColor(0, 0, 0, 1)
            end
        end)
        f:SetScript("OnLeave", function(self)
            bt:SetBackdropColor(0, 0, 0, 0)
            bt:SetBackdropBorderColor(0, 0, 0, 0)
            GameTooltip:Hide()
        end)

        bt:SetScript("OnEnter", function(self)
            if frame["NPCframe" .. NPCNum].height then
                bt:SetBackdropColor(RGB(BG.y2, 0.1))
                bt:SetBackdropBorderColor(0, 0, 0, 1)
            end
        end)
        bt:SetScript("OnLeave", function(self)
            bt:SetBackdropColor(0, 0, 0, 0)
            bt:SetBackdropBorderColor(0, 0, 0, 0)
        end)

        -- NPC技能框体
        local NPCname = frame["NPCname" .. NPCNum]
        local f = CreateFrame("Frame", nil, NPCname, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        f:SetBackdropColor(0, 0, 0, 0.3)
        f:SetBackdropBorderColor(1, 1, 1, 0.5)
        f:SetSize(frame:GetWidth() - 10, 2)
        f:SetPoint("TOPLEFT", NPCname, "BOTTOMLEFT", -5, 0)
        frame["NPCframe" .. NPCNum] = f

        -- 在框架最末端增加一个虚拟框架，为了让滚动框能显示全部内容
        C_Timer.After(0.5, function()
            if not frame["NPCframe" .. NPCNum + 1] then
                local f = CreateFrame("Frame", nil, frame)
                f:SetSize(5, 5)
                f:SetPoint("TOPLEFT", frame["NPCframe" .. NPCNum], "BOTTOMLEFT", 5, -10)
            end
        end)
    end

    -- 创建具体每个技能介绍 -- BG.BossFrameICC.Boss1.spellFrame，ICC，1
    function BG.CreateBossSpell(frame, NPCNum, SpellNum, spellID, SpellInfoText, SpellDoneText, Pnum, spellID2, spellID3)
        -- 技能名称
        local frame = frame["NPCframe" .. NPCNum]
        local f = CreateFrame("Frame", nil, frame)
        f:SetSize(frame:GetWidth(), 25)
        f:SetHyperlinksEnabled(true)
        if SpellNum == 1 then
            f:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -5)
        else
            f:SetPoint("TOPLEFT", frame["Spelldone" .. SpellNum - 1], "BOTTOMLEFT", 0, -15)
        end
        frame["Spellname" .. SpellNum] = f

        local t = f:CreateFontString()
        t:SetFont(BOSS_TEXT_FONT, fontsize3, "OUTLINE")
        t:SetPoint("LEFT")
        local _, _, icon = GetSpellInfo(spellID)
        t:SetText(AddTexture(icon) .. GetSpellLink(spellID)
            .. (spellID2 and (AddTexture(select(3, GetSpellInfo(spellID2))) .. GetSpellLink(spellID2)) or "")
            .. (spellID3 and (AddTexture(select(3, GetSpellInfo(spellID3))) .. GetSpellLink(spellID3)) or ""))
        local w = t:GetStringWidth()
        f:SetWidth(w)
        -- 阶段文字（P1、P2、全程）
        local p_t = f:CreateFontString()
        p_t:SetFont(BOSS_TEXT_FONT, fontsize4, "OUTLINE")
        p_t:SetPoint("LEFT", t, "RIGHT", 3, 0)
        p_t:SetText(Pnum and P_color(Pnum) or "")
        frame["SpellnamePnum" .. SpellNum] = p_t

        f:SetScript("OnHyperlinkClick", function(self, link, text, button)
            if IsShiftKeyDown() then
                ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                local id = link:match("spell:(%d+):")
                local text = GetSpellLink(id)
                ChatEdit_InsertLink(text)
            end
        end)
        f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
            local id = link:match("spell:(%d+):")
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:SetSpellByID((id))
        end)
        f:SetScript("OnHyperlinkLeave", GameTooltip_Hide)

        local l = f:CreateLine()
        l:SetColorTexture(RGB("808080", 1))
        l:SetStartPoint("BOTTOMLEFT", -2, 0)
        l:SetEndPoint("BOTTOMLEFT", 300, 0)
        l:SetThickness(1)

        -- -- 技能应对
        local Spellname = frame["Spellname" .. SpellNum]
        local f = CreateFrame("Frame", nil, frame)
        f:SetPoint("TOPLEFT", Spellname, "BOTTOMLEFT", 0, -5)
        f:SetSize(frame:GetWidth() - 20, 50)
        f:SetHyperlinksEnabled(true)
        frame["Spelldone" .. SpellNum] = f
        f:SetScript("OnHyperlinkClick", function(self, link, text, button)
            if IsShiftKeyDown() then
                local id = link:match("spell:(%d*)")
                if id then
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    local text = GetSpellLink(id)
                    ChatEdit_InsertLink(text)
                end
            end
        end)
        f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR", 0, 5)
            GameTooltip:ClearLines()
            local id = link:match("spell:(%d*)")
            if id then
                GameTooltip:SetSpellByID((id))
            end
        end)
        f:SetScript("OnHyperlinkLeave", function(self, link, text, button)
            GameTooltip:Hide()
        end)

        local t = f:CreateFontString()
        t:SetPoint("TOPLEFT")
        t:SetWidth(frame:GetWidth() - 20)
        t:SetFont(BOSS_TEXT_FONT, fontsize, "OUTLINE")
        t:SetTextColor(RGB(BG.y2))
        t:SetJustifyH("LEFT")
        t:SetJustifyV("TOP")
        t:SetWordWrap(true)
        t:SetText(BG.STC_w1(L["介绍："]) .. (SpellInfoText or ""))
        local info = t

        local t
        if SpellDoneText then
            t = f:CreateFontString()
            t:SetPoint("TOPLEFT", info, "BOTTOMLEFT", 0, -5)
            t:SetWidth(frame:GetWidth() - 20)
            t:SetFont(BOSS_TEXT_FONT, fontsize, "OUTLINE")
            t:SetTextColor(RGB(BG.y2))
            t:SetJustifyH("LEFT")
            t:SetJustifyV("TOP")
            t:SetWordWrap(true)
            t:SetText(BG.STC_w1(L["应对："]) .. (SpellDoneText or ""))
        end
        f:SetHeight(info:GetStringHeight() + (SpellDoneText and t:GetStringHeight() or 0) + 3)

        -- 更新NPC框架高度
        local h = frame:GetTop() - f:GetBottom() + 10
        frame:SetHeight(h)
        frame.height = h
    end

    -- 创建技能预警图标
    local icons = {
        L["坦克预警"], -- 1
        L["输出预警"], -- 2
        L["治疗预警"], -- 3
        L["英雄难度"], -- 4
        L["灭团技能"], -- 5
        L["重要"], -- 6
        L["可打断技能"], -- 7
        L["法术效果"], -- 8
        L["诅咒"], -- 9
        L["中毒"], -- 10
        L["疾病"], -- 11
    }
    function BG.CreateBossSpellTisIcon(frame, NPCNum, SpellNum, IconNum, NPC)
        local Pnum
        if not NPC then
            Pnum = frame["NPCframe" .. NPCNum]["SpellnamePnum" .. SpellNum]
            frame = frame["NPCframe" .. NPCNum]["Spellname" .. SpellNum]
        else
            Pnum = frame["NPCnamePnum" .. NPCNum]
            frame = frame["NPCname" .. NPCNum]
        end
        local f = CreateFrame("Frame", nil, frame)
        f:SetSize(30, 30)
        -- f:SetSize(frame:GetHeight() + 2, frame:GetHeight() + 2)
        if not frame.LastIcon then
            f:SetPoint("LEFT", frame, "RIGHT", Pnum and Pnum:GetWidth() + 3 or 0, 0)
        else
            f:SetPoint("LEFT", frame.LastIcon, "RIGHT", 0, 0)
        end
        frame.LastIcon = f
        f:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:SetText(icons[IconNum])
        end)
        BG.GameTooltip_Hide(f)

        local icon = f:CreateTexture(nil, 'ARTWORK')
        icon:SetAllPoints()
        icon:SetTexture(521749)

        if IconNum == 1 then
            icon:SetTexCoord(0, 0.125, 0, 0.5)
        elseif IconNum == 2 then
            icon:SetTexCoord(0.125, 0.25, 0, 0.5)
        elseif IconNum == 3 then
            icon:SetTexCoord(0.25, 0.375, 0, 0.5)
        elseif IconNum == 4 then
            icon:SetTexCoord(0.375, 0.5, 0, 0.5)
        elseif IconNum == 5 then
            icon:SetTexCoord(0.5, 0.625, 0, 0.5)
        elseif IconNum == 6 then
            icon:SetTexCoord(0.625, 0.75, 0, 0.5)
        elseif IconNum == 7 then
            icon:SetTexCoord(0.75, 0.875, 0, 0.5)
        elseif IconNum == 8 then
            icon:SetTexCoord(0.875, 1, 0, 0.5)
        elseif IconNum == 9 then
            icon:SetTexCoord(0, 0.125, 0.5, 1)
        elseif IconNum == 10 then
            icon:SetTexCoord(0.125, 0.25, 0.5, 1)
        elseif IconNum == 11 then
            icon:SetTexCoord(0.25, 0.375, 0.5, 1)
        end
    end

    -- 创建各职业职责 -- BG.BossFrameICC.Boss1.classFrame，ICC，1，1
    local classtable = { L["坦克职责"], L["治疗职责"], L["近战职责"], L["远程职责"], }
    -- local classtable = { L["坦克职责"], L["治疗职责"], L["输出职责"] }
    function BG.CreateBossClassFrame(frame, ClassNum, ...)
        -- 职责名称
        local f = CreateFrame("Frame", nil, frame)
        f:SetSize(frame:GetWidth(), 30)
        if ClassNum == 1 then
            f:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -5)
        else
            f:SetPoint("TOPLEFT", frame["Classframe" .. ClassNum - 1], "BOTTOMLEFT", 5, -10)
        end
        frame["Classname" .. ClassNum] = f
        local t = f:CreateFontString()
        t:SetFont(BOSS_TEXT_FONT, fontsize3, "OUTLINE")
        t:SetPoint("LEFT")
        t:SetText(classtable[ClassNum])
        t:SetTextColor(1, 1, 1)
        local w = t:GetStringWidth()
        f:SetWidth(w)

        -- 职责内容
        local Classname = frame["Classname" .. ClassNum]
        local f = CreateFrame("Frame", nil, Classname, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.3)
        f:SetBackdropBorderColor(1, 1, 1, 0.5)
        f:SetSize(frame:GetWidth() - 10, 100)
        f:SetPoint("TOPLEFT", Classname, "BOTTOMLEFT", -5, 0)
        f:SetHyperlinksEnabled(true)
        frame["Classframe" .. ClassNum] = f
        f:SetScript("OnHyperlinkClick", function(self, link, text, button)
            if IsShiftKeyDown() then
                local id = link:match("spell:(%d*)")
                if id then
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    local text = GetSpellLink(id)
                    ChatEdit_InsertLink(text)
                end
            end
        end)
        f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR", 0, 0)
            GameTooltip:ClearLines()
            local id = link:match("spell:(%d*)")
            if id then
                GameTooltip:SetSpellByID((id))
            end
        end)
        f:SetScript("OnHyperlinkLeave", function(self, link, text, button)
            GameTooltip:Hide()
        end)

        local donetable = { ... }
        local last
        for i, v in ipairs(donetable) do
            local t = f:CreateFontString()
            t:SetFont(BOSS_TEXT_FONT, fontsize, "OUTLINE")
            t:SetTextColor(RGB(BG.y2))
            if i == 1 then
                t:SetPoint("TOPLEFT", f, "TOPLEFT", 30, -8)
            else
                t:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -3)
            end
            t:SetWidth(f:GetWidth() - 40)
            t:SetJustifyH("LEFT")
            t:SetJustifyV("TOP")
            t:SetWordWrap(true)
            t:SetText(v)
            last = t

            local tex = f:CreateTexture()
            tex:SetPoint("TOPRIGHT", t, "TOPLEFT", -10, -3)
            tex:SetSize(10, 10)
            tex:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
            tex:SetTexCoord(0, 0.25, 0, 0.25)

            local h = f:GetTop() - t:GetBottom() + 10
            f:SetHeight(h)
        end
    end
end)



--[[
    local spellname = "统御心灵"
    spellnum = spellnum + 1
    local SpellInfoText = L[""]
    local SpellDoneText = L[""]
    BG.CreateBossSpell(BG.BossFrameICC["Boss" .. bossnum].spellFrame, npcnum, spellnum, spell[spellname], SpellInfoText, SpellDoneText)

local icons = {
    L["坦克预警"], -- 1
    L["输出预警"], -- 2
    L["治疗预警"], -- 3
    L["英雄难度"], -- 4
    L["灭团技能"], -- 5
    L["重要"], -- 6
    L["可打断技能"], -- 7
    L["法术效果"], -- 8
    L["诅咒"], -- 9
    L["中毒"], -- 10
    L["疾病"], -- 11
}
    ]]
