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

local pt = print

local player = BG.playerName
local realmID = GetRealmID()

local FBCD = "RaidCD"
local MONEY = "MONEY"

local fontsize = 13
local fontsize2 = 14
local fontsize3 = 15
local fontsize0 = 12
local r, g, b = GetClassRGB(nil, "player")

-- 检查子账号名称
local function CheckSameName(frame, realmID, player)
    if BiaoGeAccounts and BiaoGeAccounts.accountName and BGV and BGV.ShowEquipFrame then
        BG.After(0, function()
            local tbl = {}
            for accountName in pairs(BiaoGeAccounts.accountName) do
                for _realmID in pairs(BiaoGeAccounts.accountName[accountName]) do
                    if realmID == _realmID then
                        for _player in pairs(BiaoGeAccounts.accountName[accountName][realmID]) do
                            if player == _player then
                                tinsert(tbl, accountName)
                            end
                        end
                    end
                end
            end
            if #tbl > 1 then
                local str = ""
                for i, accountName in ipairs(tbl) do
                    str = str .. accountName .. (i ~= #tbl and L["，"] or "")
                end

                local t = frame:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, 11, "OUTLINE")
                t:SetPoint("RIGHT", frame, "LEFT", -15, 0)
                t:SetTextColor(1, 0, 0)
                t:SetText(str)
            end
        end)
    end
end
local function CheckBiaoGeAccounts(frame)
    local type = select(5, C_AddOns.GetAddOnInfo("BiaoGeAccounts"))
    if type ~= "MISSING" and not C_AddOns.IsAddOnLoaded("BiaoGeAccounts") then
        local t = frame:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("BOTTOM", frame, "TOP", -0, 0)
        t:SetTextColor(1, 0, 0)
        t:SetText(L["BiaoGeAccounts插件被你禁用了，导致无法显示全战网角色"])
    end
end

local function SetFactionText(f, FBCDchoice_table, text_table, info, ii, height, n)
    local t = f:CreateFontString()
    t:SetPoint("CENTER", BG.FBCDFrame, "TOPLEFT",
        (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
        (-16 - height * n))
    if info.standingID == 8 then
        t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        t:SetTextColor(0, 1, 0)
        t:SetText(_G["FACTION_STANDING_LABEL" .. info.standingID])
    else
        t:SetFont(BIAOGE_TEXT_FONT, 9, "OUTLINE")
        local infoText = format("%s\n%s",
            _G["FACTION_STANDING_LABEL" .. info.standingID],
            info.currentValue)
        t:SetText(infoText)
        if info.standingID == 7 then
            t:SetTextColor(0, .9, 0)
        elseif info.standingID == 6 then
            t:SetTextColor(0, .8, 0)
        elseif info.standingID == 5 then
            t:SetTextColor(0, .7, 0)
        elseif info.standingID == 4 then
            t:SetTextColor(1, .82, 0)
        else
            t:SetTextColor(.51, 0, .02)
        end
    end
end

local width = 19
local function OnEnter(self)
    GameTooltip:SetOwner(self, BG.ButtonIsInRight(self) and "ANCHOR_LEFT" or "ANCHOR_RIGHT", 0, 0)
    GameTooltip:ClearLines()
    GameTooltip:SetItemByID(self.itemID)
    if not self.ds then
        local tex = self:CreateTexture()
        tex:SetAllPoints()
        tex:SetColorTexture(1, 1, 1, .2)
        self.ds = tex
    end
    self.ds:Show()
end
local function OnLeave(self)
    GameTooltip:Hide()
    if self.ds then
        self.ds:Hide()
    end
end
local function CreateItem(t_paizi, i, v)
    local itemID = v.id
    local count = v.count
    Item:CreateFromItemID(itemID):ContinueOnItemLoad(function()
        local name, link, quality, level, _, _, _, stackCount, EquipLoc, Texture,
        _, typeID, subclassID, bindType = GetItemInfo(itemID)
        local f = CreateFrame("Frame", nil, BG.FBCDFrame, "BackdropTemplate")
        f:SetSize(width, width)
        f:SetPoint("RIGHT", t_paizi, "RIGHT", -(width + 0) * (i - 1), 1)
        f.itemID = itemID
        local tex = f:CreateTexture(nil, "BACKGROUND")
        tex:SetAllPoints()
        tex:SetTexture(Texture)
        tex:SetTexCoord(unpack(BG.iconTexCoord))
        if stackCount > 1 then
            f.count = f:CreateFontString()
            f.count:SetFont(BIAOGE_TEXT_FONT, 9, "OUTLINE")
            f.count:SetPoint("BOTTOMRIGHT", 1, 0)
            f.count:SetText(count)
        else
            f.iLevel = f:CreateFontString()
            f.iLevel:SetFont(BIAOGE_TEXT_FONT, 8, "OUTLINE")
            f.iLevel:SetPoint("BOTTOM", 1, 0)
            f.iLevel:SetText(level)
        end
        f:SetScript("OnEnter", OnEnter)
        f:SetScript("OnLeave", OnLeave)
    end)
end
local function SetEquipFrameFuc(bt, isAccounts, realmID, player, colorplayer, level, class, iLevel)
    if BGV and BGV.ShowEquipFrame then
        local r, g, b = GetClassColor(class)
        local tex = bt:CreateTexture()
        tex:SetPoint("CENTER")
        tex:SetSize(bt.width + 20, bt:GetHeight() - 5)
        tex:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
        tex:SetVertexColor(r, g, b)
        bt:SetHighlightTexture(tex)
        bt:SetScript("OnEnter", function(self)
            local f = BGV.equipFrame
            if not (f and f:IsVisible()) then
                BGV.ShowEquipFrame(nil, bt, isAccounts, realmID, player, colorplayer, level, class, iLevel)
            end
        end)
        bt:SetScript("OnLeave", function(self)
            if BGV.equipFrame and not BGV.equipFrame.click then
                BGV.equipFrame:Hide()
            end
            GameTooltip:Hide()
        end)
        bt:SetScript("OnClick", function(self)
            BGV.ShowEquipFrame(true, bt, isAccounts, realmID, player, colorplayer, level, class, iLevel)
        end)
    end
end

function BG.RoleOverviewShowAllServer()
    local isShiftKeyDown = IsShiftKeyDown()
    if BiaoGe.options.roleOverviewDefaultShow == "one" and isShiftKeyDown then
        return true
    end
    if BiaoGe.options.roleOverviewDefaultShow == "all" and not isShiftKeyDown then
        return true
    end
end

function BG.SortRoleOverview(newTbl)
    local isVIP
    if BiaoGe.options["roleOverviewSort1"] == "vip" then
        isVIP = true
    end
    local showAllServer = BG.RoleOverviewShowAllServer()
    sort(newTbl, function(a, b)
        if showAllServer then
            local a_val = a.realmID
            local b_val = b.realmID
            if a_val ~= b_val then
                if a_val == realmID then
                    return true
                elseif b_val == realmID then
                    return false
                end
                return a_val > b_val
            end
        end

        if not isVIP then
            local s = BiaoGe.options["roleOverviewSort1"]
            local tbl = { strsplit("-", s) }
            for _, key in ipairs(tbl) do
                if a[key] and b[key] then
                    if a[key] ~= b[key] then
                        return a[key] > b[key]
                    end
                end
            end
        end
        return false
    end)
    if isVIP and ns.isVIP then
        local tbl = {}
        for _, vv in ipairs(BiaoGeVIP.RoleOverviewSort[realmID]) do
            for i, v in ipairs(newTbl) do
                if v.realmID == realmID and v.player == vv.player then
                    tinsert(tbl, v)
                    tremove(newTbl, i)
                    break
                end
            end
        end
        for i, v in ipairs(newTbl) do
            if showAllServer or v.realmID == realmID then
                tinsert(tbl, v)
            end
        end
        return tbl
    else
        return newTbl
    end
end

local function FormatTitanRealmName(realmName)
    if BG.IsTitan then
        local a = realmName:find(" - ", 1, true)
        if a then
            realmName = realmName:sub(1, a - 1)
        end
    end
    return realmName
end

-- 角色总览UI
function BG.SetFBCD(self, position, click, refresh)
    local frameName
    if click then
        if BG.FBCDFrame then
            if BG.FBCDFrame.click and BG.FBCDFrame:IsVisible() and not refresh then
                BG.FBCDFrame:Hide()
                return
            end
            BG.FBCDFrame:Hide()
        end
        frameName = ("BGFBCDFrame" .. GetTime()):gsub("%.", "")
    else
        if BG.FBCDFrame and BG.FBCDFrame.click and BG.FBCDFrame:IsVisible() then
            return
        end
    end
    BG.UpdateFBCD()
    BG.UpdateXP()
    if BG.UpdateBuffCD then
        BG.UpdateBuffCD()
    end

    local isVIP = ns.isVIP
    local showNote
    local showAllServer = BG.RoleOverviewShowAllServer()

    local height = 20
    local leftOffset = 15
    local width_jiange = 5
    local line_height = 4
    local FBCDchoice_table = {}
    local MONEYchoice_table = {}
    -- 根据你选择的副本，生成table
    for i, v in ipairs(BG.FBCDall_table) do
        for choicefbname, yes in pairs(BiaoGe.FBCDchoice) do
            if v.name == choicefbname then
                if not (v.name == "holiday" and not BG.hasHoliday) then
                    v.width = nil
                    tinsert(FBCDchoice_table, v)
                end
            end
        end
    end
    tinsert(FBCDchoice_table, 1, {
        name = L["角色"] .. " " .. BG.STC_dis(L["(装等)"]),
        type = "title",
        color = "FFFFFF",
        width = (showAllServer and 200 or 140) + (isVIP and 20 or 0),
    })
    if isVIP and BiaoGe.options.roleOverviewShowNote == 1 then
        showNote = true
        tinsert(FBCDchoice_table, 2, {
            -- name = AddTexture("VIP") .. L["备注"],
            name = L["备注"],
            type = "title",
            color = "FFFFFF",
            width = BiaoGe.options.roleOverviewShowNote_width,
        })
    end

    -- 根据你选择的专业技能，生成table
    for i, v in ipairs(BG.SKILLall_table) do
        for id, yes in pairs(BiaoGe.SKILLchoice) do
            if v.id == id then
                tinsert(MONEYchoice_table, v)
            end
        end
    end

    -- 根据你选择的货币，生成table
    for i, v in ipairs(BG.MONEYall_table) do
        for id, yes in pairs(BiaoGe.MONEYchoice) do
            if v.id == id then
                tinsert(MONEYchoice_table, v)
            end
        end
    end
    tinsert(MONEYchoice_table, 1, {
        name = L["角色"] .. " " .. BG.STC_dis("(" .. LEVEL .. ")"),
        type = "title",
        color = "FFFFFF",
        width = (showAllServer and 165 or 105) + (isVIP and 20 or 0),
    })

    -- 计算货币表格的总宽度
    local Moneywidth = 30
    for _, v in pairs(MONEYchoice_table) do
        Moneywidth = Moneywidth + v.width
    end

    local n = 1
    local totalwidth
    local FBCDwidth = 0
    -- 创建框体UI
    local f = CreateFrame("Frame", frameName, UIParent, "BackdropTemplate")
    do
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.9)
        f:SetBackdropBorderColor(r, g, b)
        f:SetFrameLevel(100)
        f:SetSize(300, 100)
        f.lastPosition = position
        f.lastSelf = self
        BG.FBCDFrame = f
        BG.UpdateFBCDFrameScale()
        if click then
            for i = #UISpecialFrames, 1, -1 do
                local name = UISpecialFrames[i]
                if name:match("BGFBCDFrame") then
                    _G[name] = nil
                    tremove(UISpecialFrames, i)
                end
            end
            tinsert(UISpecialFrames, frameName)
            f.click = true
            f:SetFrameStrata("HIGH")
            f:SetToplevel(true)
            f:SetClampedToScreen(false)
            f:EnableMouse(true)
            f:SetMovable(true)
            if BiaoGe.point.roleOverview then
                f:SetPoint(unpack(BiaoGe.point.roleOverview))
            else
                f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
            end
            f:SetScript("OnMouseUp", function(self)
                self:StopMovingOrSizing()
                BiaoGe.point.roleOverview = { self:GetPoint(1) }
                BiaoGe.point.roleOverview[2] = nil
            end)
            f:SetScript("OnMouseDown", function(self)
                self:StartMoving()
            end)

            f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
            f.CloseButton:SetPoint("TOPRIGHT", f, "TOPRIGHT", BG.CloseButtonOffset, BG.CloseButtonOffset)
            f.CloseButton:SetScript("OnClick", function(self)
                f:Hide()
            end)

            local bt = CreateFrame("Button", nil, f)
            bt:SetSize(18, 18)
            bt:SetNormalTexture(851904)
            bt:SetHighlightTexture(851904)
            bt:SetPoint("TOPRIGHT", -30, -5)
            bt:RegisterForClicks("AnyUp")
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                BG.SetFBCD(nil, nil, true, true)
            end)

            local bt = CreateFrame("Button", nil, f)
            bt:SetSize(18, 18)
            bt:SetNormalTexture([[Interface\Buttons\UI-OptionsButton]])
            bt:SetHighlightTexture([[Interface\Buttons\UI-OptionsButton]])
            bt:SetPoint("TOPRIGHT", -52, -5)
            bt:RegisterForClicks("AnyUp")
            bt:SetScript("OnClick", function(self)
                ns.InterfaceOptionsFrame_OpenToCategory(BG.optionsName)
                BG.ButtonOptions_roleOverview:Click()
            end)
        else
            f.click = nil
            f:SetFrameStrata("FULLSCREEN_DIALOG")
            f:SetClampedToScreen(true)
            f:EnableMouse(false)
            f:SetMovable(false)
            if position and position == "minimap" then
                if BG.ButtonIsInRight(self) then
                    f:SetPoint("TOPRIGHT", self, "BOTTOMLEFT", 0, 0)
                else
                    f:SetPoint("TOPLEFT", self, "BOTTOMRIGHT", 0, 0)
                end
            else
                f:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, 0)
            end
        end
    end
    CheckBiaoGeAccounts(f)

    --------- 角色团本完成总览 ---------
    -- 大标题
    local FBCDTitle
    do
        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, fontsize2, "OUTLINE")
        t:SetPoint("TOPLEFT", 15, -10 - (n - 1) * height)
        t:SetText(BG.STC_g1(L["< 角色团本完成总览 >"]))
        t:SetJustifyH("LEFT")
        t:SetWordWrap(false)
        FBCDTitle = t
        n = n + 1
        -- 设置重置时间
        local text3 = ""
        local text7 = ""
        local function IsSmallRaid(FBID)
            -- ZUG ZA AQL 黑暗深渊 诺莫瑞根 风暴悬崖 腐烂之痕 水晶谷
            local tbl = { 309, 568, 509, 48, 90, 2791, 2789, 2804 }
            if BG.IsVanilla_Sod then
                tinsert(tbl, 249) -- 奥妮克希亚
            end
            for i, _FBID in ipairs(tbl) do
                if FBID == _FBID then
                    return true
                end
            end
        end
        for p, v in pairs(BiaoGe[FBCD][realmID]) do
            for i, cd in pairs(BiaoGe[FBCD][realmID][p]) do
                if cd.resettime then
                    if IsSmallRaid(cd.fbId) then
                        text3 = format(L["小团本%s"], SecondsToTime(cd.resettime, true, nil, 2))
                    elseif cd.num ~= 5 then
                        text7 = SecondsToTime(cd.resettime, true, nil, 2)
                    end
                end
            end
        end
        if text3 ~= "" or text7 ~= "" then
            local douhao = ""
            if text3 ~= "" and text7 ~= "" then
                douhao = ", "
            end
            local resettext = format("|cff808080" .. L["（团本重置时间：%s）"] .. RR, text7 .. douhao .. text3)
            t:SetText(t:GetText() .. resettext)
        end
    end
    -- FB标题
    local text_table = {}
    local FBCDLineWidth
    do
        local lastwidth = leftOffset - width_jiange
        for i, v in ipairs(FBCDchoice_table) do
            local t = f:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
            t:SetText("|cff" .. v.color .. (v.name3 or v.name2 or v.name):gsub("sod", "") .. RR)
            local width = FBCDchoice_table[i].width or t:GetWidth()
            lastwidth = lastwidth + width_jiange
            t:SetPoint("TOPLEFT", lastwidth, -10 - height * n)
            FBCDchoice_table[i].width = lastwidth
            lastwidth = lastwidth + width
            FBCDwidth = lastwidth + leftOffset
            tinsert(text_table, t)
        end
        n = n + 1
        -- 比较团本CD和货币的总宽度哪个高，取出最大值
        if tonumber(FBCDwidth) > tonumber(Moneywidth) then
            totalwidth = FBCDwidth
        else
            totalwidth = Moneywidth
        end
        FBCDLineWidth = totalwidth - 5
        if BiaoGe.options.roleOverviewLayout == "left_right" then
            FBCDLineWidth = FBCDwidth - 10
            FBCDTitle:SetWidth(FBCDwidth - 20)  -- 标题设置宽度
        else
            FBCDTitle:SetWidth(totalwidth - 20) -- 标题设置宽度
        end

        local l = f:CreateLine()
        l:SetColorTexture(RGB("808080", 1))
        l:SetStartPoint("TOPLEFT", BG.FBCDFrame, 5, -10 - height * n + line_height)
        l:SetEndPoint("TOPLEFT", BG.FBCDFrame, FBCDLineWidth, -10 - height * n + line_height)
        l:SetThickness(1)
    end
    -- 角色CD
    do
        local newTbl = {}
        local function AddDB(db, isAccounts)
            if db and db[FBCD] then
                local function _AddDB(realmID)
                    if db[FBCD][realmID] then
                        for player, v in pairs(db[FBCD][realmID]) do
                            if not isAccounts or not (BiaoGe[FBCD][realmID] and BiaoGe[FBCD][realmID][player]) then
                                local level = db.playerInfo[realmID] and db.playerInfo[realmID][player] and db.playerInfo[realmID][player].level
                                if level and level >= BiaoGe.options["roleOverviewNotShowLevel"] then
                                    local class = db.playerInfo[realmID][player].class
                                    local iLevel = db.playerInfo[realmID][player].iLevel or (db.PlayerItemsLevel and db.PlayerItemsLevel[realmID] and db.PlayerItemsLevel[realmID][player])
                                    local talent = db.playerInfo[realmID][player].talent
                                    if class and iLevel and iLevel >= BiaoGe.options["roleOverviewNotShowiLevel"] then
                                        local colorplayer = "|c" .. select(4, GetClassColor(class)) .. player .. (isAccounts and "*" or "")
                                        tinsert(newTbl, {
                                            player = player,
                                            colorplayer = colorplayer,
                                            class = class,
                                            iLevel = iLevel,
                                            level = level,
                                            talent = talent,
                                            realmID = realmID,
                                            realmName = (db.realmName and db.realmName[realmID]) or BiaoGe.realmName[realmID] or realmID,
                                            isAccounts = isAccounts,
                                            tbl = BG.Copy(v)
                                        })
                                    end
                                end
                            end
                        end
                    end
                end

                if showAllServer then
                    for realmID, v in pairs(db[FBCD]) do
                        if type(realmID) == "number" and type(v) == "table" then
                            _AddDB(realmID)
                        end
                    end
                else
                    _AddDB(realmID)
                end
            end
        end
        AddDB(BiaoGe)
        if not IsAltKeyDown() then
            AddDB(BiaoGeAccounts, true)
        end
        newTbl = BG.SortRoleOverview(newTbl)

        local num = 1
        for index, v in ipairs(newTbl) do
            local colorplayer = v.colorplayer
            local player = v.player
            local iLevel = v.iLevel
            local realmID = v.realmID
            local r, g, b, color = GetClassColor(v.class)
            -- 玩家名字
            local realmName
            if showAllServer then
                realmName = "|c" .. color .. FormatTitanRealmName(v.realmName) .. "-|r"
            else
                realmName = ""
            end
            local talentText = ""
            if isVIP then
                talentText = BG.GetTalentIcon(v.class, v.talent, 15)
            end
            local bt = CreateFrame("Button", nil, BG.FBCDFrame)
            bt:SetPoint("TOPLEFT", FBCDchoice_table[1].width, -7 - height * n)
            local t = bt:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
            t:SetPoint("LEFT")
            t:SetText(talentText .. realmName .. colorplayer .. " |cff808080(" .. Round(iLevel, 0) .. ")|r")
            bt.width = t:GetWidth()
            bt.isFBCD = true
            bt:SetFontString(t)
            bt:SetSize(bt.width, 20)
            SetEquipFrameFuc(bt, v.isAccounts, realmID, player, colorplayer, v.level, v.class, v.iLevel)
            CheckSameName(bt, realmID, player)

            if showNote then
                local f = CreateFrame("Frame", nil, BG.FBCDFrame)
                f:SetSize(BiaoGe.options.roleOverviewShowNote_width, height)
                f:SetPoint("TOPLEFT", FBCDchoice_table[2].width, -7 - height * n)
                local t = f:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                t:SetAllPoints()
                local note = (BiaoGe.roleOverviewNote[realmID] and BiaoGe.roleOverviewNote[realmID][player])
                    or (BiaoGeAccounts and BiaoGeAccounts.roleOverviewNote and BiaoGeAccounts.roleOverviewNote[realmID]
                        and BiaoGeAccounts.roleOverviewNote[realmID][player])
                if BiaoGe.options.roleOverviewShowNote_useClassColor == 1 then
                    t:SetTextColor(r, g, b)
                else
                    t:SetTextColor(1, 1, 1)
                end
                t:SetText(note)
                t:SetJustifyH("LEFT")
                f:SetScript("OnMouseUp", function(self)
                    if BGV.AddNote and not v.isAccounts then
                        BiaoGe.roleOverviewNote[realmID] = BiaoGe.roleOverviewNote[realmID] or {}
                        BGV.AddNote(realmID, realmName, player, colorplayer, note)
                    end
                end)
                f:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:AddLine((realmName .. colorplayer), 1, 1, 1, true)
                    local note = t:GetText()
                    if not note or note == "" then
                        note = L["无"]
                    end
                    GameTooltip:AddLine(L["备注："] .. note, 1, 0.82, 0, true)
                    GameTooltip:AddLine(" ", 1, 0.82, 0, true)
                    if v.isAccounts then
                        GameTooltip:AddLine(L["需要登录该角色所在的账号才能修改备注。"], 1, 0.82, 0, true)
                    else
                        GameTooltip:AddLine(AddTexture("LEFT") .. L["修改备注"], 1, 0.82, 0, true)
                    end
                    GameTooltip:Show()
                end)
                f:SetScript("OnLeave", GameTooltip_Hide)
            end

            -- 副本CD
            for _, cd in pairs(v.tbl) do
                for ii, vv in pairs(FBCDchoice_table) do
                    if (cd.fbId and cd.fbId == vv.fbId) and (not vv.num or cd.num == vv.num) then
                        local tx = BG.FBCDFrame:CreateTexture(nil, "OVERLAY")
                        tx:SetSize(16, 16)
                        tx:SetPoint("CENTER", BG.FBCDFrame, "TOPLEFT",
                            (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                            (-16 - height * n))
                        tx:SetTexture("interface/raidframe/readycheck-ready")
                    end
                end
            end

            -- 世界BOSS
            if BG.IsMOP then
                for _, db in pairs({ "BiaoGe", "BiaoGeAccounts" }) do
                    if _G[db] and _G[db].worldBossCD and _G[db].worldBossCD[realmID] and _G[db].worldBossCD[realmID][player] then
                        for name in pairs(_G[db].worldBossCD[realmID][player]) do
                            for ii, vv in ipairs(FBCDchoice_table) do
                                if name == vv.name then
                                    local tx = BG.FBCDFrame:CreateTexture(nil, "OVERLAY")
                                    tx:SetSize(16, 16)
                                    tx:SetPoint("CENTER", BG.FBCDFrame, "TOPLEFT",
                                        (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                        (-16 - height * n))
                                    tx:SetTexture("interface/raidframe/readycheck-ready")
                                end
                            end
                        end
                    end
                end
            end

            -- 日常
            for _, db in pairs({ "BiaoGe", "BiaoGeAccounts" }) do
                if _G[db] and _G[db].QuestCD and _G[db].QuestCD[realmID] and _G[db].QuestCD[realmID][player] then
                    for questName, v in pairs(_G[db].QuestCD[realmID][player]) do
                        for ii, vv in ipairs(FBCDchoice_table) do
                            if questName == vv.name then
                                local tx = BG.FBCDFrame:CreateTexture(nil, "OVERLAY")
                                tx:SetSize(16, 16)
                                tx:SetPoint("CENTER", BG.FBCDFrame, "TOPLEFT",
                                    (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                    (-16 - height * n))
                                if v.notFinish then
                                    tx:SetTexture("interface/raidframe/readycheck-notready")
                                    tx:SetAlpha(.5)
                                else
                                    tx:SetTexture("interface/raidframe/readycheck-ready")
                                end
                            end
                        end
                    end
                    break
                end
            end

            -- BuffCD
            for _, db in pairs({ "BiaoGe", "BiaoGeAccounts" }) do
                if _G[db] and _G[db].buffCD and _G[db].buffCD[realmID] and _G[db].buffCD[realmID][player] then
                    for buffID, v in pairs(_G[db].buffCD[realmID][player]) do
                        for ii, vv in ipairs(FBCDchoice_table) do
                            if vv.type == "buff" and buffID == vv.id then
                                local t = f:CreateFontString()
                                t:SetPoint("CENTER", BG.FBCDFrame, "TOPLEFT",
                                    (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                    (-16 - height * n))
                                t:SetFont(BIAOGE_TEXT_FONT, fontsize0, "OUTLINE")
                                t:SetTextColor(1, .82, 0)
                                t:SetText(BG.SecondsToTime(v.resettime))
                            end
                        end
                    end
                    break
                end
            end

            -- 专业CD
            for _, db in pairs({ "BiaoGe", "BiaoGeAccounts" }) do
                if _G[db] and _G[db].tradeSkillCooldown and _G[db].tradeSkillCooldown[realmID] and _G[db].tradeSkillCooldown[realmID][player] then
                    for profession, v in pairs(_G[db].tradeSkillCooldown[realmID][player]) do
                        for ii, vv in ipairs(FBCDchoice_table) do
                            if profession == vv.name then
                                local t = f:CreateFontString()
                                t:SetPoint("CENTER", BG.FBCDFrame, "TOPLEFT",
                                    (FBCDchoice_table[ii].width + text_table[ii]:GetWidth() / 2),
                                    (-16 - height * n))
                                if v.ready then
                                    t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                                    t:SetTextColor(0, 1, 0)
                                    t:SetText(READY)
                                else
                                    t:SetFont(BIAOGE_TEXT_FONT, fontsize0, "OUTLINE")
                                    t:SetTextColor(1, .82, 0)
                                    t:SetText(BG.SecondsToTime(v.resettime))
                                end
                            end
                        end
                    end
                    break
                end
            end

            -- 声望
            for _, db in pairs({ "BiaoGe", "BiaoGeAccounts" }) do
                if _G[db] and _G[db].bag and _G[db].bag[realmID] and _G[db].bag[realmID][player] and _G[db].bag[realmID][player].faction then
                    for id in pairs(_G[db].bag[realmID][player].faction) do
                        for ii, vv in ipairs(FBCDchoice_table) do
                            if vv.type == "faction" and id == vv.id then
                                local info = _G[db].bag[realmID][player].faction[id]
                                SetFactionText(f, FBCDchoice_table, text_table, info, ii, height, n)
                            end
                        end
                    end
                    break
                end
            end
            n = n + 1

            if BG.IsMe(realmID, player) then
                local l = f:CreateLine()
                l:SetStartPoint("TOPLEFT", 5, -10 - height * (n - 0.5) + line_height)
                l:SetEndPoint("TOPLEFT", FBCDLineWidth, -10 - height * (n - 0.5) + line_height)
                l:SetThickness(height - 4)
                l:SetColorTexture(r, g, b, .3)
            end

            local _r, _g, _b, h
            if newTbl[index + 1] and newTbl[index + 1].realmID ~= v.realmID then
                _r, _g, _b, h = 1, 1, 1, 1.5
            else
                _r, _g, _b, h = .5, .5, .5, 1
            end

            local l = f:CreateLine()
            l:SetStartPoint("TOPLEFT", 5, -10 - height * n + line_height)
            l:SetEndPoint("TOPLEFT", FBCDLineWidth, -10 - height * n + line_height)
            l:SetThickness(h)
            l:SetColorTexture(_r, _g, _b)
            num = num + 1
        end

        if num == 1 then
            local t = BG.FBCDFrame:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
            t:SetPoint("TOPLEFT", BG.FBCDFrame, "TOPLEFT", FBCDchoice_table[1].width, -10 - height * n)
            t:SetText(BG.STC_dis(L["当前没有满级角色"]))
            n = n + 1
        end
    end

    --------- 角色货币总览 ---------
    -- 大标题
    local moneyLineWidth = totalwidth - 5
    local allWidth = totalwidth
    do
        if BiaoGe.options.roleOverviewLayout == "left_right" then
            n = -1
            leftOffset = FBCDwidth
            moneyLineWidth = leftOffset - 5 + Moneywidth - 15
            allWidth = FBCDwidth + Moneywidth - 15
        end
        n = n + 1

        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, fontsize2, "OUTLINE")
        t:SetPoint("TOPLEFT", leftOffset, -10 - height * n)
        t:SetText(BG.STC_g1(L["< 角色货币总览 >"]))
        t:SetJustifyH("LEFT")
        t:SetWordWrap(false)
        if BiaoGe.options.roleOverviewLayout == "left_right" then
            t:SetWidth(Moneywidth - 20) -- 标题设置宽度
        else
            t:SetWidth(totalwidth - 20) -- 标题设置宽度
        end

        if not click then
            local accountsText = ""
            if BiaoGeAccounts then
                accountsText = L["，长按ALT仅显示本账号角色"]
            end
            local tipsText
            if BiaoGe.options.roleOverviewDefaultShow == "one" then
                tipsText = L["|cff808080（鼠标中键固定显示，长按SHIFT显示全服务器角色%s）|r"]
            else
                tipsText = L["|cff808080（鼠标中键固定显示，长按SHIFT显示当前服务器角色%s）|r"]
            end
            t:SetText(t:GetText() .. format(tipsText, accountsText))
        end

        n = n + 2
    end
    local function GetCount(db, id, _type)
        local count
        local v = db[id]
        if _type == "skill" then -- 专业点数
            local v = db[_type]  -- 这个才是skill数据库
            if v then
                if id == 0 then  -- 如果是主专业
                    local text = ""
                    local tbl = {}
                    for _id, info in pairs(v) do
                        if info.isMain and v[_id] then
                            tinsert(tbl, {
                                id = _id,
                                text = v[_id].level .. " " .. AddTexture(info.icon)
                            })
                        end
                    end
                    if next(tbl) then
                        sort(tbl, function(a, b)
                            return a.id < b.id
                        end)
                        for i, v in ipairs(tbl) do
                            text = text .. (text == "" and "" or " ") .. v.text
                        end
                        count = text
                    else
                        count = L["未学"]
                    end
                elseif v[id] then
                    count = v[id].level
                else
                    count = L["未学"]
                end
            else
                count = UNKNOWN
            end
        elseif type(v) == "table" then -- 牌子/物品
            if v.isNotKnow then
                count = UNKNOWN
            elseif id == "xp" then
                count = v.perNow .. "%" -- 经验
            else
                count = tonumber(v.count) or 0
            end
        else
            count = tonumber(v) or 0 -- 金币
        end
        return count
    end
    local copyTbl1 = {} -- 用于复制数据
    local copyTbl2 = {}
    local sum = {}
    do
        -- 初始化数据
        local function DefaultDB(db, copyTbl)
            if db and db[MONEY] then
                local function _AddDB(realmID)
                    if db[MONEY][realmID] then
                        copyTbl[realmID] = copyTbl[realmID] or {}
                        for player, vv in pairs(db[MONEY][realmID]) do
                            copyTbl[realmID][player] = BG.Copy(vv)
                            for i, v in ipairs(MONEYchoice_table) do
                                if (not v.type or v.type == "currency") and not copyTbl[realmID][player][v.id] then -- 牌子，给空值设为0，主要是为了填补一些旧角色缺少某些新数据
                                    copyTbl[realmID][player][v.id] = {
                                        count = 0,
                                        tex = BG.verLess2 and v.tex or C_CurrencyInfo.GetCurrencyInfo(v.id).iconFileID,
                                        isNotKnow = true
                                    }
                                elseif v.type == "money" and not copyTbl[realmID][player][v.id] then -- 金币
                                    copyTbl[realmID][player][v.id] = 0
                                elseif v.type == "item" and not copyTbl[realmID][player][v.id] then  -- 物品
                                    copyTbl[realmID][player][v.id] = {
                                        count = 0,
                                        tex = select(5, GetItemInfoInstant(v.id)),
                                        isNotKnow = true
                                    }
                                elseif v.type == "xp" and not copyTbl[realmID][player][v.id] then -- 双倍经验                                      -- 物品
                                    copyTbl[realmID][player][v.id] = {
                                        count = 0,
                                        tex = v.tex,
                                        isNotKnow = true
                                    }
                                end
                            end
                            if not copyTbl[realmID][player].player then
                                copyTbl[realmID][player].player = player
                            end
                            if not copyTbl[realmID][player].colorplayer then
                                copyTbl[realmID][player].colorplayer = BG.STC_dis(player)
                            end
                        end
                    end
                end

                if showAllServer then
                    for realmID, v in pairs(db[MONEY]) do
                        if type(realmID) == "number" and type(v) == "table" then
                            _AddDB(realmID)
                        end
                    end
                else
                    _AddDB(realmID)
                end
            end
        end
        DefaultDB(BiaoGe, copyTbl1)
        if not IsAltKeyDown() then
            DefaultDB(BiaoGeAccounts, copyTbl2)
        end
    end
    -- 货币标题
    do
        local right
        for i, v in ipairs(MONEYchoice_table) do
            local t = f:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
            if i == 1 then
                t:SetPoint("TOPLEFT", leftOffset, -10 - height * n)
                t:SetJustifyH("LEFT")
            else
                local width
                if i == 2 then
                    width = MONEYchoice_table[i - 1].width + MONEYchoice_table[i].width
                    t:SetPoint("TOPRIGHT", right, "TOPLEFT", width, 0)
                else
                    width = MONEYchoice_table[i].width
                    t:SetPoint("TOPRIGHT", right, "TOPRIGHT", width, 0)
                end
                t:SetJustifyH("RIGHT")
            end
            t:SetText(v.name2 or v.name)
            t:SetTextColor(RGB(v.color))
            t:SetWidth(MONEYchoice_table[i].width - 10)
            t:SetWordWrap(false)

            right = t
        end
        n = n + 1
        local l = f:CreateLine()
        l:SetColorTexture(RGB("808080", 1))
        l:SetStartPoint("TOPLEFT", BG.FBCDFrame, leftOffset - 10, -10 - height * n + line_height)
        l:SetEndPoint("TOPLEFT", BG.FBCDFrame, moneyLineWidth, -10 - height * n + line_height)
        l:SetThickness(1)
    end
    -- 角色货币
    do
        local newTbl = {}
        local function AddDB(db, copyTbl, isAccounts)
            for realmID in pairs(copyTbl) do
                for player, v in pairs(copyTbl[realmID]) do
                    if not isAccounts or not (BiaoGe[MONEY][realmID] and BiaoGe[MONEY][realmID][player]) then
                        local level = db.playerInfo[realmID] and db.playerInfo[realmID][player] and db.playerInfo[realmID][player].level
                        if (level and level >= BiaoGe.options["roleOverviewNotShowLevel"]) then
                            local class = db.playerInfo[realmID][player].class
                            local talent = db.playerInfo[realmID][player].talent
                            local iLevel = db.playerInfo[realmID][player].iLevel or (db.PlayerItemsLevel and db.PlayerItemsLevel[realmID] and db.PlayerItemsLevel[realmID][player])
                            if class and iLevel and iLevel >= BiaoGe.options["roleOverviewNotShowiLevel"] then
                                local colorplayer = "|c" .. select(4, GetClassColor(class)) .. player .. (isAccounts and "*" or "")
                                tinsert(newTbl, {
                                    player = player,
                                    colorplayer = colorplayer,
                                    class = class,
                                    iLevel = iLevel,
                                    level = level,
                                    talent = talent,
                                    realmID = realmID,
                                    realmName = (db.realmName and db.realmName[realmID]) or BiaoGe.realmName[realmID] or realmID,
                                    isAccounts = isAccounts,
                                    tbl = v
                                })
                            end
                        end
                    end
                end
            end
        end
        AddDB(BiaoGe, copyTbl1)
        AddDB(BiaoGeAccounts, copyTbl2, true)
        newTbl = BG.SortRoleOverview(newTbl)

        -- 计算合计
        for ii in ipairs(newTbl) do
            local pz = newTbl[ii].tbl
            for i = 2, #MONEYchoice_table do
                local id = MONEYchoice_table[i].id
                sum[id] = sum[id] or 0
                sum[id] = sum[id] + (tonumber(GetCount(pz, id, MONEYchoice_table[i].type)) or 0)
            end
        end

        -- 开始创建
        for index, v in ipairs(newTbl) do
            local colorplayer = v.colorplayer
            local player = v.player
            local level = v.level
            local realmID = v.realmID
            local r, g, b, color = GetClassColor(v.class)
            local right
            -- 名字
            local realmName
            if showAllServer then
                realmName = "|c" .. color .. FormatTitanRealmName(v.realmName) .. "-|r"
            else
                realmName = ""
            end
            local talentText = ""
            if isVIP then
                talentText = BG.GetTalentIcon(v.class, v.talent, 15)
            end
            local levelText = ""
            if level then levelText = BG.STC_dis(" (" .. level .. ")") end

            local bt = CreateFrame("Button", nil, BG.FBCDFrame)
            bt:SetPoint("TOPLEFT", BG.FBCDFrame, "TOPLEFT", leftOffset, -7 - height * n)
            local t = bt:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
            t:SetPoint("LEFT")
            t:SetText(talentText .. realmName .. colorplayer .. levelText)
            bt.width = t:GetWidth()
            bt.isMoney = true
            bt:SetFontString(t)
            bt:SetSize(bt.width, 20)
            right = bt
            SetEquipFrameFuc(bt, v.isAccounts, realmID, player, colorplayer, v.level, v.class, v.iLevel)
            CheckSameName(bt, realmID, player)

            -- 牌子
            local pzDB = v.tbl
            for ii = 2, #MONEYchoice_table do
                local vv = MONEYchoice_table[ii]
                local id = vv.id
                local info = pzDB[id]
                local count = tostring(GetCount(pzDB, vv.id, vv.type))
                local countString
                if vv.type == "skill" and id == 0 then
                    countString = BG.FormatNumber(count)
                else
                    countString = BG.FormatNumber(count) .. " " .. AddTexture(vv.tex)
                end
                local t_paizi = f:CreateFontString()
                t_paizi:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                local width
                if ii == 2 then
                    width = MONEYchoice_table[ii - 1].width + MONEYchoice_table[ii].width
                    t_paizi:SetPoint("RIGHT", right, "LEFT", width, 0)
                else
                    width = MONEYchoice_table[ii].width
                    t_paizi:SetPoint("TOPRIGHT", right, "TOPRIGHT", width, 0)
                end
                if count:match("^%d+") == "0" or count:find(UNKNOWN) or count:find(L["未学"]) then
                    t_paizi:SetTextColor(0.5, 0.5, 0.5)
                end
                if vv.type == "currency" and tonumber(count) then
                    local isFull
                    local weekTimestamp = info.weekTimestamp
                    if info.isFull or (weekTimestamp and weekTimestamp > GetServerTime()) then
                        t_paizi:SetTextColor(1, 0, 0)
                        isFull = true
                    end

                    if BG.showCurrencyTop then
                        local totalCount = info.totalCount
                        local totalMax = info.totalMax
                        if totalCount and totalMax then
                            countString = format("|cff%s%s/%s|r %s %s",
                                isFull and "ff0000" or "808080",
                                BG.FormatNumber(totalCount, 3),
                                totalMax == 0 and UNKNOWN or BG.FormatNumber(totalMax, 3),
                                count,
                                AddTexture(vv.tex))
                        end
                    end

                    local weekCount = info.weekCount
                    local weekMax = info.weekMax
                    if weekCount and weekMax then
                        countString = format("|cff%s%s/%s|r %s %s", isFull and "ff0000" or "808080",
                            BG.FormatNumber(weekCount, 3), BG.FormatNumber(weekMax, 3), count, AddTexture(vv.tex))
                    end
                end
                if type(info) == "table" and info.isItem and info.quest then
                    t_paizi:SetText(L["完成"] .. " " .. AddTexture(vv.tex))
                    t_paizi:SetTextColor(0, 1, 0)
                elseif vv.type == "items" then
                    t_paizi:SetText(" ")
                    if type(info) == "table" then
                        if next(info) then
                            for i, v in ipairs(info) do
                                CreateItem(t_paizi, i, v)
                            end
                        else
                            t_paizi:SetText(L["无"])
                        end
                    else
                        t_paizi:SetText(UNKNOWN)
                    end
                elseif id == "xp" and level and level >= BG.fullLevel then
                    t_paizi:SetText(L["满级"] .. " " .. AddTexture(vv.tex))
                    t_paizi:SetTextColor(0, 1, 0)
                else
                    t_paizi:SetText(countString)
                end
                t_paizi:SetJustifyH("RIGHT")
                right = t_paizi
            end
            n = n + 1

            if BG.IsMe(realmID, player) then
                local l = f:CreateLine()
                l:SetStartPoint("TOPLEFT", BG.FBCDFrame, leftOffset - 10, -10 - height * (n - 0.5) + line_height)
                l:SetEndPoint("TOPRIGHT", BG.FBCDFrame, -5, -10 - height * (n - 0.5) + line_height)
                l:SetThickness(height - 4)
                l:SetColorTexture(r, g, b, .3)
            end

            local _r, _g, _b, h
            if newTbl[index + 1] and newTbl[index + 1].realmID ~= v.realmID then
                _r, _g, _b, h = 1, 1, 1, 1.5
            else
                _r, _g, _b, h = .5, .5, .5, 1
            end
            local l = f:CreateLine()
            l:SetStartPoint("TOPLEFT", BG.FBCDFrame, leftOffset - 10, -10 - height * n + line_height)
            l:SetEndPoint("TOPLEFT", BG.FBCDFrame, moneyLineWidth, -10 - height * n + line_height)
            l:SetThickness(h)
            l:SetColorTexture(_r, _g, _b)
        end

        do -- 合计
            if Size(copyTbl1) ~= 0 then
                local right
                local t_name = f:CreateFontString()
                t_name:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                t_name:SetPoint("TOPLEFT", leftOffset, -10 - height * n)
                t_name:SetText(L["合计"])
                right = t_name

                for ii = 2, #MONEYchoice_table do
                    local vv = MONEYchoice_table[ii]
                    local id = vv.id
                    local count = BG.FormatNumber(GetCount(sum, id, vv.type)) .. " " .. AddTexture(vv.tex) -- 牌子
                    local t_paizi = f:CreateFontString()
                    t_paizi:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
                    local width
                    if ii == 2 then
                        width = MONEYchoice_table[ii - 1].width + MONEYchoice_table[ii].width
                        t_paizi:SetPoint("TOPRIGHT", right, "TOPLEFT", width, 0)
                    else
                        width = MONEYchoice_table[ii].width
                        t_paizi:SetPoint("TOPRIGHT", right, "TOPRIGHT", width, 0)
                    end
                    if id == "xp" or vv.type == "skill" or vv.type == "items" then
                        t_paizi:SetText("")
                    else
                        t_paizi:SetText(count)
                    end
                    if count:match("^%d+") == "0" then
                        t_paizi:SetTextColor(0.5, 0.5, 0.5)
                    end
                    right = t_paizi
                end
                n = n + 1
            end
        end
    end
    f:SetSize(allWidth, 10 + height * n + 5)
end

function BG.UpdateFBCDFrameScale()
    if BG.FBCDFrame then
        BG.FBCDFrame:SetScale(BiaoGe.options.roleOverviewScale or 1)
    end
end

BG.RegisterEvent("MODIFIER_STATE_CHANGED", function(self, event, enter)
    if BG.FBCDFrame and not BG.FBCDFrame.click and BG.FBCDFrame:IsVisible() then
        BG.FBCDFrame:Hide()
        BG.SetFBCD(BG.FBCDFrame.lastSelf, BG.FBCDFrame.lastPosition)
    end
end)
