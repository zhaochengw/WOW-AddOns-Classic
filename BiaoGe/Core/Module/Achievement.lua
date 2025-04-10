if not BG.IsWLK then return end
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
local RealmId = GetRealmID()
local player = BG.playerName

BG.Init(function()
    BiaoGe.achievement = BiaoGe.achievement or {}
    for _, FB in ipairs(BG.FBtable) do
        BiaoGe.achievement[FB] = BiaoGe.achievement[FB] or {}
    end

    local raidAchievement_AllPlayer = {}
    local raidAchievement_Total = {}
    local UpdateChoose

    local db = {
        ["25ULD"] = {
            -- 40821, -- test
            2895,
            3037,
            4626,
            3164,
            3163,
            3189,
            3184,
            2944,
            3059,
        },
        ["10ULD"] = {
            2894,
            3036,
            3159,
            3158,
            3180,
            3182,
            2941,
            3058,
        },
        ["25ICC"] = {
            4816,
            4637,
            4608,
            4625,
            -- 4584,
            4635,
            4634,
            4633,
            4632,
        },
        ["10ICC"] = {
            4818,
            4636,
            4532,
            4583,
            4631,
            4630,
            4629,
            4628,
        },
        ["25TOC"] = {
            3812,
            3916,
            3819,
            3818,
            3817,
        },
        ["10TOC"] = {
            3918,
            3917,
            3810,
            3809,
            3808,
        },
        ["25NAXX"] = {
            2054,
        },
        ["10NAXX"] = {
            2051,
        },
    }
    local db_stats = {
        {
            ID = 334,
            name = L["历史最大金币"],
            icon = "Interface/MoneyFrame/UI-GoldIcon",
        },
        {
            ID = 1544,
            name = L["工程技能点"],
            icon = "Interface/Icons/trade_engineering",
        },
        {
            ID = 339,
            name = L["获得坐骑数量"],
            icon = "Interface/Icons/inv_misc_summerfest_brazierorange",
        },
        {
            ID = 338,
            name = L["获得小宠物数量"],
            icon = "Interface/Icons/spell_nature_polymorph",
        },
        {
            ID = 336,
            name = L["拥有传说物品"],
            icon = "Interface/Icons/inv_sword_39",
        },
    }

    --[[
/dump SetAchievementComparisonUnit("raid1")
/dump SetAchievementComparisonUnit("raid2")
/dump GetComparisonStatistic(334)
/dump GetStatistic(334)
 ]]

    -- 25人
    local f, child = BG.CreateScrollFrame(BG.AchievementMainFrame, 300, 250, nil, true)
    do
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        f:SetBackdropColor(0, 0, 0, 0)
        f:SetBackdropBorderColor(1, 1, 1, .2)
        f:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 100, -80)
        f.scroll:SetWidth(f:GetWidth() - 10)
        child:SetWidth(f:GetWidth() - 10)
        child.buttons = {}
        child.frame = f
        BG.AchievementMainFrame.Frame1 = child

        local t = f:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
        t:SetPoint("RIGHT", f, "BOTTOMLEFT", -10, 0)
        t:SetTextColor(0, 1, 0)
        t:SetText(L["成\n就"])
    end

    -- 10人
    local f, child = BG.CreateScrollFrame(BG.AchievementMainFrame, 300, 250, nil, true)
    do
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        f:SetBackdropColor(0, 0, 0, 0)
        f:SetBackdropBorderColor(1, 1, 1, .2)
        f:SetPoint("TOPLEFT", BG.AchievementMainFrame.Frame1.frame, "BOTTOMLEFT", 0, -0)
        f.scroll:SetWidth(f:GetWidth() - 10)
        child:SetWidth(f:GetWidth() - 10)
        child.buttons = {}
        child.frame = f
        BG.AchievementMainFrame.Frame2 = child
    end

    -- 统计
    local f, child = BG.CreateScrollFrame(BG.AchievementMainFrame, 300, 160, nil, true)
    do
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        f:SetBackdropColor(0, 0, 0, 0)
        f:SetBackdropBorderColor(1, 1, 1, .2)
        f:SetPoint("TOPLEFT", BG.AchievementMainFrame.Frame2.frame, "BOTTOMLEFT", 0, -20)
        f.scroll:SetWidth(f:GetWidth() - 10)
        child:SetWidth(f:GetWidth() - 10)
        child.buttons = {}
        child.frame = f
        BG.AchievementMainFrame.Frame3 = child

        local t = f:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
        t:SetPoint("RIGHT", f, "LEFT", -10, 0)
        t:SetTextColor(0, 1, 0)
        t:SetText(L["统\n计"])
    end

    -- 团队框架
    do
        local f = CreateFrame("Frame", nil, BG.AchievementMainFrame)
        f.buttons = {}
        BG.AchievementMainFrame.raidFrame = f

        local function OnEnter(self)
            local name = self.name
            if not name or not raidAchievement_AllPlayer[name] then return end
            GameTooltip:SetOwner(self, "ANCHOR_NONE", 0, 0)
            GameTooltip:SetPoint("RIGHT", self, "LEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self.nameText:GetText())
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(L["成就："])
            local FB = BG.FB1
            for _, num in ipairs({ 25, 10 }) do
                if db[num .. FB] then
                    for _, ID in ipairs(db[num .. FB]) do
                        local text, r1, g1, b1, r2, g2, b2
                        local v = raidAchievement_AllPlayer[name][ID]
                        if v then
                            text = v.year .. "/" .. v.month .. "/" .. v.day
                            r1, g1, b1 = 1, 1, 1
                            r2, g2, b2 = 0, 1, 0
                        else
                            text = L["没有成就"]
                            r1, g1, b1 = .5, .5, .5
                            r2, g2, b2 = .5, .5, .5
                        end
                        GameTooltip:AddDoubleLine(select(2, GetAchievementInfo(ID)), text, r1, g1, b1, r2, g2, b2)
                    end
                end
            end
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(L["统计："])
            for i in ipairs(db_stats) do
                local text = raidAchievement_AllPlayer[name]["stats" .. db_stats[i].ID]:gsub("(GoldIcon.-|t).+", "%1"):gsub("(%d+)", BG.FormatNumber)
                GameTooltip:AddDoubleLine(db_stats[i].name, text, 1, 1, 0, 1, 1, 1)
            end
            GameTooltip:Show()

            if not self.ds then
                self.ds = self:CreateTexture(nil, "BACKGROUND")
                self.ds:SetAllPoints()
                self.ds:SetColorTexture(.5, .5, .5, .3)
            end
            self.ds:Show()
        end

        local function OnLeave(self)
            GameTooltip:Hide()
            if self.ds then
                self.ds:Hide()
            end
        end

        local function CreateRaidButton(i)
            local f = CreateFrame("Frame", nil, nil, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            f:SetBackdropColor(0, 0, 0, .2)
            f:SetBackdropBorderColor(1, 1, 1, .2)
            f:SetSize(120, 35)
            if i == 1 then
                f:SetPoint("TOPLEFT", BG.AchievementMainFrame.Frame1.frame, "TOPRIGHT", 30, 0)
                f:SetParent(BG.AchievementMainFrame.raidFrame)

                local text = f:CreateFontString()
                text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                text:SetPoint("BOTTOM", f, "TOP", 0, 2)
                text:SetText(1)
                text:SetTextColor(.5, .5, .5)
            elseif i == 26 then
                f:SetPoint("TOPLEFT", BG.AchievementMainFrame.raidFrame.buttons[5], "BOTTOMLEFT", 0, -30)
                f:SetParent(BG.AchievementMainFrame.raidFrame)

                local text = f:CreateFontString()
                text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                text:SetPoint("BOTTOM", f, "TOP", 0, 2)
                text:SetText((i - 1) / 5 + 1)
                text:SetTextColor(.5, .5, .5)
            elseif (i - 1) % 5 == 0 then
                f:SetPoint("TOPLEFT", BG.AchievementMainFrame.raidFrame.buttons[i - 5], "TOPRIGHT", 5, 0)
                f:SetParent(BG.AchievementMainFrame.raidFrame)

                local text = f:CreateFontString()
                text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                text:SetPoint("BOTTOM", f, "TOP", 0, 2)
                text:SetText((i - 1) / 5 + 1)
                text:SetTextColor(.5, .5, .5)
            else
                f:SetPoint("TOPLEFT", BG.AchievementMainFrame.raidFrame.buttons[i - 1], "BOTTOMLEFT", 0, -1)
                local num = floor((i - 1) / 5) * 5 + 1
                f:SetParent(BG.AchievementMainFrame.raidFrame.buttons[num])
            end
            tinsert(BG.AchievementMainFrame.raidFrame.buttons, f)
            f:SetScript("OnEnter", OnEnter)
            f:SetScript("OnLeave", OnLeave)

            local text = f:CreateFontString()
            text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            text:SetPoint("TOPLEFT", 2, -2)
            text:SetWidth(f:GetWidth() - 5)
            text:SetJustifyH("LEFT")
            text:SetWordWrap(false)
            f.nameText = text

            local text = f:CreateFontString()
            text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
            text:SetPoint("BOTTOMLEFT", 2, 2)
            text:SetWidth(f:GetWidth() - 5)
            text:SetJustifyH("LEFT")
            text:SetWordWrap(false)
            f.otherText = text

            local tex = f:CreateTexture(nil, "OVERLAY")
            tex:SetPoint("CENTER", f, "TOPLEFT", 2, -2)
            tex:SetSize(10, 10)
            f.icon = tex
        end

        for i = 1, 40 do
            CreateRaidButton(i)
        end
    end

    local function UpdateRaidName()
        for i, bt in ipairs(BG.AchievementMainFrame.raidFrame.buttons) do
            bt.nameText:Hide()
            bt.otherText:Hide()
            bt.icon:SetTexture(nil)
            bt.name = nil
        end
        if IsInRaid(1) then
            for _, v in ipairs(BG.raidRosterInfo) do
                for i = (v.subgroup - 1) * 5 + 1, v.subgroup * 5 do
                    local bt = BG.AchievementMainFrame.raidFrame.buttons[i]
                    if not bt.name then
                        bt.name = v.name
                        bt.nameText:SetText(SetClassCFF(v.name))
                        bt.nameText:Show()
                        bt.otherText:SetTextColor(1, 1, 1)
                        if v.rank == 2 then
                            bt.icon:SetTexture("interface/groupframe/ui-group-leadericon")
                        elseif v.role == "MAINTANK" then
                            bt.icon:SetTexture(132064)
                        elseif v.role == "MAINASSIST" then
                            bt.icon:SetTexture(132063)
                        elseif v.rank == 1 then
                            bt.icon:SetTexture("interface/groupframe/ui-group-assistanticon")
                        end
                        if not raidAchievement_AllPlayer[v.name] then
                            bt.nameText:SetAlpha(.3)
                            bt.otherText:SetAlpha(.3)
                            if BG.raidRosterIsOnline[v.name] then
                                bt.otherText:SetText(L["距离太远读取失败"])
                            else
                                bt.otherText:SetText(L["离线"])
                            end
                            bt.otherText:Show()
                        else
                            bt.nameText:SetAlpha(1)
                            bt.otherText:SetAlpha(1)
                            bt.otherText:SetText("")
                            bt.otherText:Hide()
                        end
                        break
                    end
                end
            end
            UpdateChoose()
        end

        local has
        for j = 25, 35, 5 do
            local yes
            for i = 1, 5 do
                if BG.AchievementMainFrame.raidFrame.buttons[j + i].name then
                    has = true
                    yes = true
                    BG.AchievementMainFrame.raidFrame.buttons[j + 1]:Show()
                    break
                end
            end
            if not yes then
                BG.AchievementMainFrame.raidFrame.buttons[j + 1]:Hide()
            end
        end

        local bt = BG.AchievementMainFrame.ButtonRefresh
        bt:ClearAllPoints()
        if has then
            bt:SetPoint("BOTTOMLEFT", BG.AchievementMainFrame.Frame2.frame, "BOTTOMRIGHT", 30, 5)
        else
            bt:SetPoint("BOTTOMLEFT", BG.AchievementMainFrame.Frame1.frame, "BOTTOMRIGHT", 30, 5)
        end
    end

    local function OnEnter(self, ID, isStats, notShowDs)
        for i, bt in ipairs(BG.AchievementMainFrame.raidFrame.buttons) do
            if bt.name then
                if raidAchievement_AllPlayer[bt.name] then
                    local text
                    if not isStats then
                        local v = raidAchievement_AllPlayer[bt.name][ID]
                        if v then
                            text = v.year .. "/" .. v.month .. "/" .. v.day
                            bt.otherText:SetTextColor(0, 1, 0)
                            bt:SetBackdropColor(0, 1, 0, .2)
                            bt:SetBackdropBorderColor(0, 1, 0, 1)
                        else
                            text = L["没有成就"]
                            bt.otherText:SetTextColor(1, 0, 0)
                            bt:SetBackdropColor(1, 0, 0, .2)
                            bt:SetBackdropBorderColor(1, 0, 0, 1)
                        end
                        bt.otherText:SetText(text)
                        bt.otherText:Show()
                    else
                        text = raidAchievement_AllPlayer[bt.name]["stats" .. ID]:gsub("(GoldIcon.-|t).+", "%1"):gsub("(%d+)", BG.FormatNumber)
                        bt.otherText:SetText(text)
                        bt.otherText:SetTextColor(1, 1, 1)
                        bt.otherText:Show()
                        bt:SetBackdropColor(0, 0, 0, .2)
                        bt:SetBackdropBorderColor(1, 1, 1, .2)
                    end
                end
            end
        end
        if not notShowDs then
            if not self.ds then
                self.ds = self:CreateTexture(nil, "BACKGROUND")
                self.ds:SetAllPoints()
                self.ds:SetColorTexture(.5, .5, .5, .3)
            end
            self.ds:Show()
        end
    end
    local function OnLeave(self)
        GameTooltip:Hide()
        self.ds:Hide()
        for i, bt in ipairs(BG.AchievementMainFrame.raidFrame.buttons) do
            if raidAchievement_AllPlayer[bt.name] then
                bt.otherText:Hide()
                bt:SetBackdropColor(0, 0, 0, .2)
                bt:SetBackdropBorderColor(1, 1, 1, .2)
            end
        end
        UpdateChoose()
    end
    local function OnClick(self)
        BG.PlaySound(1)
        if IsShiftKeyDown() then
            if not self.chooseStats then
                local achievementLink = GetAchievementLink(self.chooseID);
                if achievementLink then
                    BG.InsertLink(achievementLink)
                end
            end
        else
            for i = 1, 3 do
                for _, bt in ipairs(BG.AchievementMainFrame["Frame" .. i].buttons) do
                    if not (bt.chooseID == self.chooseID and
                            bt.chooseStats == self.chooseStats) then
                        bt.chooseTex:Hide()
                        bt.ischoose = false
                    end
                end
            end
            self.ischoose = not self.ischoose
            if self.ischoose then
                BiaoGe.achievement[BG.FB1].chooseID = self.chooseID
                BiaoGe.achievement[BG.FB1].chooseStats = self.chooseStats
                self.chooseTex:Show()
            else
                BiaoGe.achievement[BG.FB1].chooseID = nil
                BiaoGe.achievement[BG.FB1].chooseStats = nil
                self.chooseTex:Hide()
            end
        end
    end
    function UpdateChoose()
        if BiaoGe.achievement[BG.FB1].chooseID then
            local button
            for i = 1, 3 do
                for _, bt in ipairs(BG.AchievementMainFrame["Frame" .. i].buttons) do
                    if (bt.chooseID == BiaoGe.achievement[BG.FB1].chooseID and
                            bt.chooseStats == BiaoGe.achievement[BG.FB1].chooseStats) then
                        button = bt
                        break
                    end
                end
                if button then break end
            end
            OnEnter(button, BiaoGe.achievement[BG.FB1].chooseID, BiaoGe.achievement[BG.FB1].chooseStats, true)
        end
    end

    local function CreateButton(i, ID, child, isStats)
        local id, name, points, completed, month, day, year, description, flags, icon
        if not isStats then
            id, name, points, completed, month, day, year, description, flags, icon = GetAchievementInfo(ID)
        else
            ID = db_stats[i].ID
            name = db_stats[i].name
            icon = db_stats[i].icon
        end

        local f = CreateFrame("Frame", nil, child, "BackdropTemplate")
        f:SetSize(child:GetWidth(), 30)
        if i == 1 then
            f:SetPoint("TOPLEFT")
        else
            f:SetPoint("TOPLEFT", child.buttons[i - 1], "BOTTOMLEFT", 0, 0)
        end
        f.chooseID = ID
        f.chooseStats = isStats
        tinsert(child.buttons, f)
        f:SetScript("OnEnter", function(self)
            if not isStats then
                GameTooltip:SetOwner(self, "ANCHOR_NONE", 0, 0)
                GameTooltip:SetPoint("RIGHT", self, "LEFT")
                GameTooltip:ClearLines()
                GameTooltip:SetHyperlink(GetAchievementLink(ID))
            end
            OnEnter(self, ID, isStats)
        end)
        f:SetScript("OnLeave", OnLeave)
        f:SetScript("OnMouseDown", OnClick)

        local tex = f:CreateTexture(nil, "BACKGROUND")
        tex:SetAllPoints()
        if i % 2 == 0 then
            tex:SetColorTexture(.5, .5, .5, .15)
        else
            tex:SetColorTexture(0, 0, 0, .25)
        end

        local tex = f:CreateTexture(nil, "BORDER")
        tex:SetAllPoints()
        tex:SetColorTexture(1, 1, 0, .5)
        tex:Hide()
        f.chooseTex = tex

        if f.chooseID == BiaoGe.achievement[BG.FB1].chooseID and f.chooseStats == BiaoGe.achievement[BG.FB1].chooseStats then
            f.ischoose = true
            f.chooseTex:Show()
        end

        local icon_tex = f:CreateTexture()
        icon_tex:SetPoint("TOPLEFT", -0, -0)
        icon_tex:SetPoint("BOTTOMRIGHT", f, "BOTTOMLEFT", f:GetHeight() - 0, 0)
        icon_tex:SetTexture(icon)
        icon_tex:SetTexCoord(.07, .93, .07, .93)
        if not isStats and not completed then
            icon_tex:SetDesaturated(true)
        end

        local text = f:CreateFontString()
        text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        text:SetPoint("TOPLEFT", icon_tex, "TOPRIGHT", 1, -1)
        text:SetText(name)
        text:SetTextColor(1, 1, 0)
        if not isStats and not completed then
            text:SetTextColor(.5, .5, .5)
        end

        local text = f:CreateFontString()
        text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
        text:SetPoint("BOTTOMLEFT", icon_tex, "BOTTOMRIGHT", 1, 1)
        if not isStats then
            if IsInRaid(1) then
                local num = 0
                for name in pairs(raidAchievement_AllPlayer) do
                    if BG.raidRosterName[name] then
                        num = num + 1
                    end
                end
                text:SetText((raidAchievement_Total[ID] or 0) .. "/" .. num)
                if (raidAchievement_Total[ID] or 0) == num then
                    text:SetTextColor(0, 1, 0)
                end
            end
        else
            text:SetText(GetStatistic(ID))
        end
    end

    function BG.UpdateAchievementFrame()
        local FB = BG.FB1
        for i, bt in ipairs(BG.AchievementMainFrame.Frame1.buttons) do
            bt:Hide()
        end
        wipe(BG.AchievementMainFrame.Frame1.buttons)
        for i, bt in ipairs(BG.AchievementMainFrame.Frame2.buttons) do
            bt:Hide()
        end
        wipe(BG.AchievementMainFrame.Frame2.buttons)
        for i, bt in ipairs(BG.AchievementMainFrame.Frame3.buttons) do
            bt:Hide()
        end
        wipe(BG.AchievementMainFrame.Frame3.buttons)

        if db["25" .. FB] then
            for i, ID in ipairs(db["25" .. FB]) do
                CreateButton(i, ID, BG.AchievementMainFrame.Frame1)
            end
        end
        if db["10" .. FB] then
            for i, ID in ipairs(db["10" .. FB]) do
                CreateButton(i, ID, BG.AchievementMainFrame.Frame2)
            end
        end
        for i in pairs(db_stats) do
            CreateButton(i, nil, BG.AchievementMainFrame.Frame3, true)
        end

        UpdateRaidName()
        BG.AchievementMainFrame.ButtonRefresh:Enable()
        BG.AchievementMainFrame.ButtonRefresh:SetText(L["刷新数据"])
    end

    local function UpdateAaidAchievement_Total()
        for FB in pairs(db) do
            for _, ID in ipairs(db[FB]) do
                for name in pairs(raidAchievement_AllPlayer) do
                    if BG.raidRosterName[name] then
                        for _ID, v in pairs(raidAchievement_AllPlayer[name]) do
                            if ID == _ID and v.completed then
                                raidAchievement_Total[ID] = raidAchievement_Total[ID] or 0
                                raidAchievement_Total[ID] = raidAchievement_Total[ID] + 1
                                break
                            end
                        end
                    end
                end
            end
        end
    end

    local function GetRaidAchievement()
        wipe(raidAchievement_Total)

        if IsInRaid(1) then
            if not BG.AchievementUpdateFrame then
                BG.AchievementUpdateFrame = CreateFrame("Frame")
            end
            local f = BG.AchievementUpdateFrame
            f:SetScript("OnUpdate", nil)
            f:Show()
            f.t = 0
            local i = 1
            ClearAchievementComparisonUnit()
            SetAchievementComparisonUnit("raid" .. i)
            f:SetScript("OnUpdate", function(self, t)
                self.t = self.t + t
                if self.t >= 0.2 then
                    self.t = 0
                    i = i + 1
                    if i <= GetNumGroupMembers() then
                        ClearAchievementComparisonUnit()
                        SetAchievementComparisonUnit("raid" .. i)
                    else
                        UpdateAaidAchievement_Total()
                        BG.UpdateAchievementFrame()
                        self:SetScript("OnUpdate", nil)
                        self:Hide()
                        return
                    end
                end
            end)
        else
            BG.UpdateAchievementFrame()
        end
    end

    -- 刷新数据
    local needRefresh = true
    do
        local bt = BG.CreateButton(BG.AchievementMainFrame)
        bt:SetSize(130, 25)
        bt:SetText(L["刷新数据"])
        BG.AchievementMainFrame.ButtonRefresh = bt
        bt:SetScript("OnClick", function(self)
            BG.PlaySound(1)
            BG.AchievementMainFrame.ButtonRefresh:Disable()
            BG.AchievementMainFrame.ButtonRefresh:SetText(L["正在刷新"])
            GetRaidAchievement()
        end)

        BG.AchievementMainFrame:HookScript("OnShow", function(self)
            if needRefresh then
                needRefresh = false
                BG.AchievementMainFrame.ButtonRefresh:Disable()
                BG.AchievementMainFrame.ButtonRefresh:SetText(L["正在刷新"])
                GetRaidAchievement()
            else
                BG.UpdateAchievementFrame()
            end
        end)
    end

    BG.RegisterEvent("INSPECT_ACHIEVEMENT_READY", function(self, event, guid)
        if achievementFunctions then achievementFunctions.selectedCategory = -1 end
        if not IsInRaid(1) then return end
        local name = BG.raidRosterGUID[guid]
        if not name then return end
        local GetAchievementComparisonInfo = GetAchievementComparisonInfo
        local GetComparisonStatistic = GetComparisonStatistic
        local tbl = {}
        local num = 1
        if name == BG.GN() then
            GetAchievementComparisonInfo = GetAchievementInfo
            GetComparisonStatistic = GetStatistic
            num = 4
        end
        for FB in pairs(db) do
            for _, ID in ipairs(db[FB]) do
                local completed, month, day, year = select(num, GetAchievementComparisonInfo(ID))
                if completed then
                    tbl[ID] = {
                        completed = completed,
                        month = month,
                        day = day,
                        year = year
                    }
                end
            end
        end
        for i in ipairs(db_stats) do
            local ID = db_stats[i].ID
            tbl["stats" .. ID] = GetComparisonStatistic(ID)
        end
        if tbl["stats" .. 334] ~= "--" then
            -- pt(tbl["stats" .. 334])
            raidAchievement_AllPlayer[name] = tbl
        end
    end)

    local last
    BG.RegisterEvent("GROUP_ROSTER_UPDATE", function(self, event)
        needRefresh = true
        if not last then
            BG.After(0.6, function()
                GetRaidAchievement()
            end)
        end
        if not IsInRaid(1) then
            wipe(raidAchievement_Total)
            BG.UpdateAchievementFrame()
            last = nil
        else
            last = true
        end
        BG.After(0.6, function()
            UpdateRaidName()
        end)
    end)

    BG.Init2(function()
        BG.UpdateAchievementFrame()
    end)
end)
