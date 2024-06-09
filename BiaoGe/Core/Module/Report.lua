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
local RealmId = GetRealmID()
local player = UnitName("player")

local R = {}

BG.RegisterEvent("ADDON_LOADED", function(self, event, addonName)
    if addonName ~= AddonName then return end

    BiaoGe.Report = BiaoGe.Report or {}
    BiaoGe.Report.db = BiaoGe.Report.db or {}
    BiaoGe.Report.db[RealmId] = BiaoGe.Report.db[RealmId] or {}

    BiaoGe.Report.needDeleteFriends = BiaoGe.Report.needDeleteFriends or {}
    BiaoGe.Report.needDeleteFriends[RealmId] = BiaoGe.Report.needDeleteFriends[RealmId] or {}

    BiaoGe.Report.OrderButtonID = BiaoGe.Report.OrderButtonID or 2
    BiaoGe.Report.Order = BiaoGe.Report.Order or 1

    local db = BiaoGe.Report.db[RealmId]

    -- 举报记录UI
    do
        local BUTTONHEIGHT = 20
        local MAXBUTTONS = 30

        local title_table = {
            { name = L["序号"], width = 50, color = "FFFFFF", JustifyH = "CENTER" },
            { name = L["举报时间"], width = 140, color = "FFFFFF", JustifyH = "CENTER" },
            { name = NAME, width = 85, color = "FFFFFF", JustifyH = "CENTER", },
            { name = L["服务器"], width = 70, color = "FFFFFF", JustifyH = "CENTER" },
            { name = L["举报类型"], width = 70, color = "FFFFFF", JustifyH = "CENTER" },
            { name = L["举报项目"], width = 70, color = "FFFFFF", JustifyH = "CENTER" },
            { name = L["举报细节"], width = 70, color = "FFFFFF", JustifyH = "CENTER" },
            { name = L["举报次数"], width = 60, color = "FFFFFF", JustifyH = "CENTER" },
            { name = L["已封号"], width = 50, color = "FFFFFF", JustifyH = "CENTER" },
            { name = L["操作"], width = 110, color = "FFFFFF", JustifyH = "CENTER" },
        }
        local WIDTH = 10 + 27
        for i, v in ipairs(title_table) do
            WIDTH = WIDTH + v.width
        end

        local function CreateLine(parent, y, width, height, color, alpha)
            local l = parent:CreateLine()
            l:SetColorTexture(RGB(color or "808080", alpha or 1))
            l:SetStartPoint("BOTTOMLEFT", 0, y)
            l:SetEndPoint("BOTTOMLEFT", width, y)
            l:SetThickness(height or 1.5)
            return l
        end

        -- 创建UI
        local f, s, child
        local titlebuttons = {}
        local buttons = {}
        local checkbuttons = {}
        BG.ReportTbl = {}
        R.deleteFriends = {}
        R.errorDelete = {}

        do
            f = CreateFrame("Frame", nil, BG.ReportMainFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 10,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.4)
            f:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 27, -55)
            f:SetSize(WIDTH + 5, BUTTONHEIGHT * (MAXBUTTONS + 1) + 15)
            f:EnableMouse(true)

            s = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate") -- 滚动
            s:SetWidth(WIDTH - 27 + 5)
            s:SetHeight(BUTTONHEIGHT * MAXBUTTONS)
            s:SetPoint("TOPLEFT", 0, -12 - BUTTONHEIGHT)
            s.ScrollBar.scrollStep = 5

            child = CreateFrame("Frame", nil, f) -- 子框架
            child:SetWidth(s:GetWidth())
            child:SetHeight(s:GetHeight())
            s:SetScrollChild(child)

            -- 清空记录
            do
                StaticPopupDialogs["BG_QINGKONGJILU"] = {
                    text = L["确定清空全部举报记录？"],
                    button1 = YES,
                    button2 = NO,
                    OnAccept = function()
                        SendSystemMessage(BG.STC_b1(format(L["已清空全部举报记录，一共 %s 个。"], #db)))
                        wipe(db)
                        R.UpdateScrollFrame()
                        R.UpdateButtons()
                    end,
                    OnCancel = function()
                    end,
                    timeout = 10,
                    whileDead = true,
                    hideOnEscape = true,
                    showAlert = true,
                }

                local bt = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
                bt:SetSize(120, 30)
                bt:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, -20)
                bt:SetText(L["清空记录"])
                f.qingkongButton = bt
                bt:SetScript("OnClick", function(self)
                    StaticPopup_Show("BG_QINGKONGJILU")
                end)
                bt:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:AddLine(L["清空记录"], 1, 1, 1, true)
                    GameTooltip:AddLine(L["一键清空全部举报记录。"], 1, 0.82, 0, true)
                    GameTooltip:Show()
                end)
                bt:SetScript("OnLeave", GameTooltip_Hide)
            end

            -- 统计数据
            do
                f.Text1 = f:CreateFontString()
                f.Text1:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                f.Text1:SetPoint("TOPRIGHT", f, "BOTTOMRIGHT", -50, -10)
                f.Text1:SetTextColor(1, 0.82, 0)
                f.Text1:SetJustifyH("RIGHT")
                f.Text1:SetText(L["已封号："])
                f.Text1Count = f:CreateFontString()
                f.Text1Count:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                f.Text1Count:SetPoint("LEFT", f.Text1, "RIGHT", 5, 0)
                f.Text1Count:SetTextColor(0, 1, 0)

                f.Text2 = f:CreateFontString()
                f.Text2:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                f.Text2:SetPoint("TOPRIGHT", f.Text1, "BOTTOMRIGHT", 0, -5)
                f.Text2:SetTextColor(1, 0.82, 0)
                f.Text2:SetJustifyH("RIGHT")
                f.Text2:SetText(L["未封号："])
                f.Text2Count = f:CreateFontString()
                f.Text2Count:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                f.Text2Count:SetPoint("LEFT", f.Text2, "RIGHT", 5, 0)
                f.Text2Count:SetTextColor(1, 0, 0)

                f.Text3 = f:CreateFontString()
                f.Text3:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                f.Text3:SetPoint("TOPRIGHT", f.Text2, "BOTTOMRIGHT", 0, -5)
                f.Text3:SetTextColor(1, 0.82, 0)
                f.Text3:SetJustifyH("RIGHT")
                f.Text3:SetText(L["举报合计："])
                f.Text3Count = f:CreateFontString()
                f.Text3Count:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                f.Text3Count:SetPoint("LEFT", f.Text3, "RIGHT", 5, 0)
                f.Text3Count:SetTextColor(1, 1, 0)
            end
        end

        -- 重要函数
        do
            function R.SetSort()
                wipe(BG.ReportTbl)
                for i, v in ipairs(db) do
                    BG.ReportTbl[i] = v
                end

                sort(BG.ReportTbl, function(a, b)
                    if BiaoGe.Report.OrderButtonID == 2 then -- 按日期
                        local key = "time"
                        if a[key] and b[key] then
                            if a[key] ~= b[key] then
                                if BiaoGe.Report.Order == 1 then
                                    return a[key] > b[key]
                                else
                                    return b[key] > a[key]
                                end
                            end
                        end
                    elseif BiaoGe.Report.OrderButtonID == 3 then -- 按名字
                        local key = "name"
                        if a[key] and b[key] then
                            if a[key] ~= b[key] then
                                if BiaoGe.Report.Order == 1 then
                                    return a[key] < b[key]
                                else
                                    return b[key] < a[key]
                                end
                            end
                        end
                    elseif BiaoGe.Report.OrderButtonID == 4 then -- 按服务器
                        local key = "realm"
                        if a[key] and b[key] then
                            if a[key] ~= b[key] then
                                if BiaoGe.Report.Order == 1 then
                                    return a[key] < b[key]
                                else
                                    return b[key] < a[key]
                                end
                            end
                        end
                    elseif BiaoGe.Report.OrderButtonID == 5 then -- 按举报类型
                        local key = "majorCategory"
                        if a[key] and b[key] then
                            if a[key] ~= b[key] then
                                if BiaoGe.Report.Order == 1 then
                                    return a[key] < b[key]
                                else
                                    return b[key] < a[key]
                                end
                            end
                        end
                    elseif BiaoGe.Report.OrderButtonID == 6 then -- 按举报项目
                        local key = "minorCategoryFlags"
                        if a[key] and b[key] then
                            local text1 = ""
                            local text2 = ""
                            for i, v in ipairs(a[key]) do
                                text1 = text1 .. v
                            end
                            for i, v in ipairs(b[key]) do
                                text2 = text2 .. v
                            end
                            if text1 ~= text2 then
                                if BiaoGe.Report.Order == 1 then
                                    return text1 < text2
                                else
                                    return text2 < text1
                                end
                            end
                        end
                    elseif BiaoGe.Report.OrderButtonID == 7 then -- 按举报细节
                        local key = "comment"
                        if a[key] and b[key] then
                            if a[key] ~= b[key] then
                                if BiaoGe.Report.Order == 1 then
                                    return a[key] < b[key]
                                else
                                    return b[key] < a[key]
                                end
                            end
                        end
                    elseif BiaoGe.Report.OrderButtonID == 8 then -- 按举报次数
                        local key = "count"
                        if a[key] and b[key] then
                            if a[key] ~= b[key] then
                                if BiaoGe.Report.Order == 1 then
                                    return a[key] > b[key]
                                else
                                    return b[key] > a[key]
                                end
                            end
                        end
                    elseif BiaoGe.Report.OrderButtonID == 9 then -- 按封号
                        local key = "state"
                        local a_key = a[key] or -1
                        local b_key = b[key] or -1
                        if a_key ~= b_key then
                            if BiaoGe.Report.Order == 1 then
                                return a_key > b_key
                            else
                                return b_key > a_key
                            end
                        end
                    end
                    local key = "time"
                    if a[key] and b[key] then
                        if a[key] ~= b[key] then
                            if BiaoGe.Report.Order == 1 then
                                return a[key] > b[key]
                            else
                                return b[key] > a[key]
                            end
                        end
                    end
                    local key = "name"
                    if a[key] and b[key] then
                        if a[key] ~= b[key] then
                            if BiaoGe.Report.Order == 1 then
                                return a[key] < b[key]
                            else
                                return b[key] < a[key]
                            end
                        end
                    end
                    return false
                end)

                local sorter = f.sorter
                local bt = titlebuttons[BiaoGe.Report.OrderButtonID]
                sorter:SetParent(bt)
                sorter:ClearAllPoints()
                if bt.textJustifyH == "CENTER" then
                    sorter:SetPoint("LEFT", bt, "CENTER", bt.textwidth / 2, 0)
                else
                    sorter:SetPoint("LEFT", bt, "LEFT", bt.textwidth, 0)
                end
                if not f.isnewsorter then
                    if BiaoGe.Report.Order == 1 then
                        sorter:SetTexCoord(0, 0.5, 0, 1)
                    else
                        sorter:SetTexCoord(0, 0.5, 1, 0)
                    end
                end
            end

            function R.UpdateButtonStates(self, currValue)
                if (not currValue) then
                    currValue = self:GetValue();
                end

                local scrollDownButton = self.ScrollDownButton or _G[self:GetName() .. "ScrollDownButton"];
                local scrollUpButton = self.ScrollUpButton or _G[self:GetName() .. "ScrollUpButton"];

                scrollUpButton:Enable();
                scrollDownButton:Enable();

                local minVal, maxVal = self:GetMinMaxValues();
                if (currValue >= maxVal) then
                    if (scrollDownButton) then
                        scrollDownButton:Disable()
                    end
                end
                if (currValue <= minVal) then
                    if (scrollUpButton) then
                        scrollUpButton:Disable();
                    end
                end
            end

            local function StateTexture(state)
                if state == 1 then
                    return AddTexture("interface/raidframe/readycheck-ready")
                elseif state == 0 then
                    return AddTexture("interface/raidframe/readycheck-notready")
                end
            end
            function R.GetButtonTbl(ii)
                if not BG.ReportTbl[ii] then return end
                local date = date("*t", date(BG.ReportTbl[ii].time))
                local _, _, _, cff = GetClassColor(BG.ReportTbl[ii].class)
                local minorCategory = ""
                for i, v in ipairs(BG.ReportTbl[ii].minorCategoryFlags) do
                    minorCategory = minorCategory .. _G[C_ReportSystem.GetMinorCategoryString(v)] .. "\n"
                end

                local i_table = {
                    ii,
                    strsub(date.year, 3) .. "/" .. date.month .. "/" .. date.day .. " " ..
                    format("%02d", date.hour) .. ":" .. format("%02d", date.min),
                    "|c" .. cff .. BG.ReportTbl[ii].name .. RR,
                    BG.ReportTbl[ii].realm,
                    _G[C_ReportSystem.GetMajorCategoryString(BG.ReportTbl[ii].majorCategory)],
                    minorCategory,
                    BG.ReportTbl[ii].comment,
                    BG.ReportTbl[ii].count,
                    StateTexture(BG.ReportTbl[ii].state) or "",
                }
                return i_table
            end

            function R.UpdateScrollFrame(type)
                if not BG.ReportMainFrame:IsVisible() then return end
                if not type then
                    R.SetSort()
                end
                local m = #BG.ReportTbl - MAXBUTTONS
                s.ScrollBar:SetMinMaxValues(0, max(0, m))
                R.UpdateButtonStates(s.ScrollBar, nil)

                if #db == 0 then
                    f.qingkongButton:Disable()
                else
                    f.qingkongButton:Enable()
                end

                local good = 0
                for i, v in ipairs(db) do
                    if v.state == 1 then
                        good = good + 1
                    end
                end
                f.Text1Count:SetText(good)
                f.Text2Count:SetText(#db - good)
                f.Text3Count:SetText(#db)
            end

            function R.UpdateButtons()
                if not BG.ReportMainFrame:IsVisible() then return end
                local value = floor(s.ScrollBar:GetValue()) or 0
                for ii = 1, MAXBUTTONS do
                    local i_table = R.GetButtonTbl(ii + value)
                    for i = 1, #title_table - 1 do
                        if i_table then
                            buttons[ii][i].Text:SetText(i_table[i])
                            if buttons[ii][i].Text:GetStringWidth() > buttons[ii][i].Text:GetWidth() + 1 then
                                buttons[ii][i].onenter = i_table[i]
                            else
                                buttons[ii][i].onenter = nil
                            end
                            buttons[ii][i]:Show()
                        else
                            buttons[ii][i].Text:SetText("")
                            buttons[ii][i].onenter = nil
                            buttons[ii][i]:Hide()
                        end
                    end
                end
            end

            s.ScrollBar:SetScript("OnValueChanged", function(self)
                R.UpdateButtons()
                R.UpdateButtonStates(self)
            end)
        end

        -- 标题
        do
            local function TitleOnClick(self)
                BG.PlaySound(1)
                f.isnewsorter = nil
                if BiaoGe.Report.OrderButtonID ~= self.id then
                    f.isnewsorter = true
                end
                if not f.isnewsorter then
                    BiaoGe.Report.Order = BiaoGe.Report.Order == 1 and 0 or 1
                end
                BiaoGe.Report.OrderButtonID = self.id

                R.UpdateScrollFrame()
                R.UpdateButtons()
            end

            for i, v in ipairs(title_table) do
                local bt = CreateFrame("Button", nil, f, "BackdropTemplate")
                -- f:SetBackdrop({
                --     bgFile = "Interface/ChatFrame/ChatFrameBackground",
                -- })
                bt:SetSize(title_table[i].width, BUTTONHEIGHT)
                if i == 1 then
                    bt:SetPoint("TOPLEFT", 10, -10)
                else
                    bt:SetPoint("LEFT", titlebuttons[i - 1], "RIGHT", 0, 0)
                end
                bt:SetNormalFontObject(BG.FontWhite13)
                bt:SetText(title_table[i].name)
                bt.textwidth = bt:GetFontString():GetStringWidth()
                bt.textJustifyH = title_table[i].JustifyH
                bt.sortOrder = 1
                bt.id = i
                bt:SetHighlightTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
                bt:Disable()
                if i ~= 1 and i ~= #title_table then
                    bt:Enable()
                end
                tinsert(titlebuttons, bt)

                bt.Text = bt:GetFontString()
                bt.Text:SetTextColor(RGB(title_table[i].color))
                bt.Text:SetJustifyH(title_table[i].JustifyH)
                bt.Text:SetWidth(bt:GetWidth())
                bt.Text:SetWordWrap(false)

                bt:SetScript("OnClick", TitleOnClick)

                if i == #title_table - 1 then
                    bt:SetScript("OnEnter", function(self)
                        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                        GameTooltip:ClearLines()
                        GameTooltip:AddLine(L["已封号"], 1, 1, 1, true)
                        GameTooltip:AddLine(format(L["%s：已被封号"], AddTexture("interface/raidframe/readycheck-ready")), 1, 0.82, 0, true)
                        GameTooltip:AddLine(format(L["%s：未被封号"], AddTexture("interface/raidframe/readycheck-notready")), 1, 0.82, 0, true)
                        GameTooltip:Show()
                    end)
                    bt:SetScript("OnLeave", GameTooltip_Hide)
                end

                if i == #title_table then
                    local f = CreateFrame("Frame", nil, bt, "BackdropTemplate")
                    f:SetAllPoints()
                    f:SetScript("OnEnter", function(self)
                        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                        GameTooltip:ClearLines()
                        GameTooltip:AddLine(L["操作"], 1, 1, 1, true)
                        GameTooltip:AddLine(L["|cff00ff00查：|r查询该玩家是否已被封号"], 1, 0.82, 0, true)
                        GameTooltip:AddLine(L["|cffff0000删：|r删除该条举报记录"], 1, 0.82, 0, true)
                        GameTooltip:Show()
                    end)
                    f:SetScript("OnLeave", GameTooltip_Hide)
                end
            end
            CreateLine(titlebuttons[1], 0, WIDTH - 35)

            -- 排序材质
            local sorter = f:CreateTexture(nil, "OVERLAY")
            sorter:SetSize(8, 8)
            sorter:SetTexture("Interface/Buttons/ui-sortarrow")
            f.sorter = sorter
        end

        -- 内容
        do
            local function CheckOnMouseUp(self)
                if self.disable then return end
                BG.PlaySound(1)
                self.Text:SetPoint("CENTER", 0, 0)
                local value = floor(s.ScrollBar:GetValue()) or 0
                local tbl = BG.ReportTbl[self.ID + value]
                if not tbl then return end
                R.deleteFriends[tbl.name] = true
                R.lastDelete = tbl.name
                C_FriendList.AddFriend(tbl.name)
                C_FriendList.ShowFriends()
                for i, bt in ipairs(self.checkbuttons) do
                    bt:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
                    bt.Text:SetTextColor(0.5, 0.5, 0.5)
                    bt.disable = true
                    BG.After(0.5, function()
                        bt:SetBackdropBorderColor(0, 1, 0, 0.5)
                        bt.Text:SetTextColor(0, 1, 0)
                        bt.disable = false
                    end)
                end
            end
            local function CheckOnMouseDown(self)
                if self.disable then return end
                self.Text:ClearAllPoints()
                self.Text:SetPoint("CENTER", 1, -1)
            end
            local function CheckOnEnter(self)
                buttons[self.ID][1].ds:Show()
                if self.disable then return end
                self:SetBackdropBorderColor(1, 1, 1, 1)
                self.Text:SetTextColor(1, 1, 1)
            end
            local function CheckOnLeave(self)
                buttons[self.ID][1].ds:Hide()
                if self.disable then return end
                self:SetBackdropBorderColor(0, 1, 0, 0.5)
                self.Text:SetTextColor(0, 1, 0)
            end

            local function DeleteOnMouseUp(self)
                BG.PlaySound(1)
                self.Text:SetPoint("CENTER", 0, 0)
                local value = floor(s.ScrollBar:GetValue()) or 0
                local tbl = BG.ReportTbl[self.ID + value]
                if not tbl then return end
                for i = #db, 1, -1 do
                    if db[i].name == tbl.name and db[i].realm == tbl.realm then
                        tremove(db, i)
                        tremove(BG.ReportTbl, self.ID + value)
                        R.UpdateScrollFrame("notsort")
                        R.UpdateButtons()
                        return
                    end
                end
            end
            local function DeleteOnMouseDown(self)
                self.Text:ClearAllPoints()
                self.Text:SetPoint("CENTER", 1, -1)
            end
            local function DeleteOnEnter(self)
                buttons[self.ID][1].ds:Show()
                self:SetBackdropBorderColor(1, 1, 1, 1)
                self.Text:SetTextColor(1, 1, 1)
            end
            local function DeleteOnLeave(self)
                buttons[self.ID][1].ds:Hide()
                self:SetBackdropBorderColor(1, 0, 0, 0.5)
                self.Text:SetTextColor(1, 0, 0)
            end

            local function Filter(self, even, msg, player, l, cs, t, flag, channelId, ...)
                local name = msg:match(ERR_FRIEND_ADDED_S:gsub("%%s", "(.+)")) or
                    msg:match(ERR_FRIEND_ALREADY_S:gsub("%%s", "(.+)")) or
                    msg:match(ERR_FRIEND_ONLINE_SS:gsub("%%s", "(.+)"):gsub("%[", "%%["):gsub("%]", "%%]"))
                if name then
                    for i, v in ipairs(db) do
                        if name == v.name then
                            return true
                        end
                    end
                end
            end
            ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", Filter)

            BG.RegisterEvent("CHAT_MSG_SYSTEM", function(self, even, msg)
                if msg == ERR_FRIEND_ERROR then
                    for _, v in ipairs(db) do
                        if R.lastDelete == v.name then
                            R.errorDelete[R.lastDelete] = true
                            return
                        end
                    end
                end
            end)
            BG.RegisterEvent("FRIENDLIST_UPDATE", function(self, even)
                -- pt(GetTime(), even, C_FriendList.GetNumFriends())
                -- BG.After(0.2, function()
                for name in pairs(R.deleteFriends) do
                    -- 检查是否为未知好友
                    for errorName in pairs(R.errorDelete) do
                        -- pt(errorName)
                        if name == errorName then
                            for _, v in ipairs(db) do
                                if name == v.name then
                                    v.state = 0
                                    R.UpdateScrollFrame()
                                    R.UpdateButtons()
                                    break
                                end
                            end
                            local info = C_FriendList.GetFriendInfo(name)
                            if info then
                                C_FriendList.RemoveFriend(name)
                                R.deleteFriends[name] = nil
                            end
                            return
                        end
                    end

                    local info = C_FriendList.GetFriendInfo(name)
                    if info then
                        -- 状态改为未封号
                        for _, v in ipairs(db) do
                            if name == v.name then
                                v.state = 0
                                R.UpdateScrollFrame()
                                R.UpdateButtons()
                                break
                            end
                        end
                        -- 删除好友
                        C_FriendList.RemoveFriend(name)
                        R.deleteFriends[name] = nil
                    else
                        -- 状态改为已封号
                        for _, v in ipairs(db) do
                            if name == v.name then
                                v.state = 1
                                R.UpdateScrollFrame()
                                R.UpdateButtons()
                                break
                            end
                        end
                    end
                end
                -- end)
            end)

            for ii = 1, MAXBUTTONS do
                buttons[ii] = {}
                for i = 1, #title_table do
                    local f = CreateFrame("Frame", nil, s)
                    f:SetSize(title_table[i].width, BUTTONHEIGHT)
                    if ii == 1 and i == 1 then
                        f:SetPoint("TOPLEFT", s, 10, 0)
                        f:SetParent(s)
                    elseif i == 1 then
                        f:SetPoint("TOPLEFT", buttons[(ii - 1)][1], "BOTTOMLEFT", 0, 0)
                        f:SetParent(s)
                    else
                        f:SetPoint("LEFT", buttons[ii][i - 1], "RIGHT", 0, 0)
                        f:SetParent(buttons[ii][1])
                    end
                    f.num = ii
                    buttons[ii][i] = f

                    f.Text = f:CreateFontString()
                    f.Text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
                    f.Text:SetPoint("CENTER")
                    f.Text:SetTextColor(RGB(title_table[i].color))
                    f.Text:SetJustifyH(title_table[i].JustifyH)
                    f.Text:SetWidth(f:GetWidth() - 2)
                    f.Text:SetWordWrap(false)

                    f:SetScript("OnEnter", function(self)
                        if self.onenter then
                            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                            GameTooltip:ClearLines()
                            GameTooltip:AddLine(self.onenter, 1, 1, 1, true)
                            GameTooltip:Show()
                        end
                        buttons[ii][1].ds:Show()
                    end)
                    f:SetScript("OnLeave", function(self)
                        GameTooltip:Hide()
                        buttons[ii][1].ds:Hide()
                    end)
                end

                -- 查
                local bt = CreateFrame("Frame", nil, buttons[ii][#buttons[ii]], "BackdropTemplate")
                do
                    bt:SetBackdrop({
                        edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                        edgeSize = 1,
                    })
                    bt:SetBackdropBorderColor(0, 1, 0, 0.5)
                    bt:SetPoint("LEFT", buttons[ii][#buttons[ii] - 1], "RIGHT", 5, 0)
                    bt:SetSize(50, BUTTONHEIGHT - 1)
                    bt.ID = ii
                    checkbuttons[ii] = bt
                    bt.checkbuttons = checkbuttons

                    bt.Text = bt:CreateFontString()
                    bt.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                    bt.Text:SetAllPoints()
                    bt.Text:SetTextColor(0, 1, 0)
                    bt.Text:SetText(L["查"])

                    bt:SetScript("OnMouseUp", CheckOnMouseUp)
                    bt:SetScript("OnMouseDown", CheckOnMouseDown)
                    bt:SetScript("OnEnter", CheckOnEnter)
                    bt:SetScript("OnLeave", CheckOnLeave)
                end
                -- 删
                local bt = CreateFrame("Frame", nil, buttons[ii][#buttons[ii]], "BackdropTemplate")
                do
                    bt:SetBackdrop({
                        edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                        edgeSize = 1,
                    })
                    bt:SetBackdropBorderColor(1, 0, 0, 0.5)
                    bt:SetPoint("LEFT", checkbuttons[ii], "RIGHT", 5, 0)
                    bt:SetSize(50, BUTTONHEIGHT - 1)
                    bt.ID = ii

                    bt.Text = bt:CreateFontString()
                    bt.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                    bt.Text:SetAllPoints()
                    bt.Text:SetTextColor(1, 0, 0)
                    bt.Text:SetText(L["删"])

                    bt:SetScript("OnMouseUp", DeleteOnMouseUp)
                    bt:SetScript("OnMouseDown", DeleteOnMouseDown)
                    bt:SetScript("OnEnter", DeleteOnEnter)
                    bt:SetScript("OnLeave", DeleteOnLeave)
                end

                -- 底色材质
                local f = buttons[ii][1]
                f.ds = f:CreateTexture()
                f.ds:SetSize(s:GetWidth() - 10 - 3, f:GetHeight())
                f.ds:SetPoint("LEFT")
                f.ds:SetColorTexture(1, 1, 1, 0.1)
                f.ds:Hide()

                CreateLine(buttons[ii][1], 0, WIDTH - 35, 1, nil, 0.2)
            end
        end

        BG.ReportMainFrame:HookScript("OnShow", function(self)
            R.UpdateScrollFrame()
            R.UpdateButtons()
        end)
    end

    -- 记录举报数据
    local minorCategoryTbl = {}
    local rp = {}
    local chatPlayerGUIDs = {}
    local whoPlayersClass = {}
    local whoPlayersName = {}
    do
        hooksecurefunc(C_ReportSystem, "SendReport", function(reportInfo, playerLocation)
            local whoIndex = playerLocation:GetWhoIndex()
            local name = C_PlayerInfo.GetName(playerLocation) or whoPlayersName[whoIndex]
            if not name then return end
            local name, realm = strsplit("-", name)
            if not realm then realm = GetRealmName() end

            local _, class = C_PlayerInfo.GetClass(playerLocation)
            if not class then
                class = whoPlayersClass[name]
            end

            sort(minorCategoryTbl, function(a, b)
                return a < b
            end)
            local copy = {}
            for i, v in ipairs(minorCategoryTbl) do
                copy[i] = v
            end

            local count = 1
            local state
            for i = #db, 1, -1 do
                if name == db[i].name and realm == db[i].realm then
                    count = count + db[i].count
                    state = db[i].state
                    tremove(db, i)
                end
            end

            local a = {
                time = time(),
                name = name,
                realm = realm,
                class = class,
                reportType = reportInfo.reportType,
                majorCategory = reportInfo.majorCategory,
                minorCategoryFlags = copy,
                comment = reportInfo.comment,
                count = count,
                state = state,
            }
            tinsert(db, 1, a)

            wipe(minorCategoryTbl)
            R.UpdateScrollFrame()
            R.UpdateButtons()
        end)
    end

    -- 一键举报
    do
        -- 重置
        local function ReSet()
            rp.yes = false
            rp.chattype = nil
            rp.targetName = nil
            rp.targetClass = nil
        end
        -- 举报
        local function SetReport(ReportType, unitname, playerLocation)
            local reportInfo = ReportInfo:CreateReportInfoFromType(ReportType)
            ReportFrame:InitiateReport(reportInfo, unitname, playerLocation)
        end

        -- 举报界面显示时
        hooksecurefunc(ReportFrame, "InitiateReport", function(self, reportInfo, name, playerLocation)
            wipe(minorCategoryTbl)
            if not (rp.yes and BiaoGe.options["report"] == 1) then return end
            if reportInfo.reportType == 1 then
                ToggleDropDownMenu(nil, nil, ReportFrameButton:GetParent())
                UIDropDownMenuButton_OnClick(DropDownList1Button2)
                if ReportFrame.Comment.EditBox then
                    ReportFrame.Comment.EditBox:SetText("自动脚本\n自動腳本\nAutomatic Scripting")
                end
            elseif reportInfo.reportType == 0 then
                ToggleDropDownMenu(nil, nil, ReportFrameButton:GetParent())
                UIDropDownMenuButton_OnClick(DropDownList1Button1)
                if rp.chattype == "saorao" then
                    if ReportFrame.Comment.EditBox then
                        ReportFrame.Comment.EditBox:SetText("恶意骚扰\n惡意騷擾\nMalicious harassment")
                    end
                elseif rp.chattype == "RMT" then
                    if ReportFrame.Comment.EditBox then
                        ReportFrame.Comment.EditBox:SetText("RMT")
                    end
                end
            end
            rp.targetName = name
            if playerLocation then
                local _, class = C_PlayerInfo.GetClass(playerLocation)
                if class then
                    rp.targetClass = class
                else
                    local unitname = strsplit("-", name)
                    rp.targetClass = whoPlayersClass[unitname]
                end
            end
            ReportFrame.ReportButton:UpdateButtonState()
            ReportFrame.ReportButton:OnClick()
        end)
        -- 举报项目创建时
        local function SetCategoryButtonChecked(self, minorCategory)
            if self.minorCategory == minorCategory then
                self:SetChecked(true)
                self:GetParent():SetMinorCategoryFlag(self.minorCategory, self:GetChecked());
                tinsert(minorCategoryTbl, self.minorCategory)
            end
        end
        hooksecurefunc(ReportingFrameMinorCategoryButtonMixin, "OnClick", function(self)
            if self:GetChecked() then
                tinsert(minorCategoryTbl, self.minorCategory)
            else
                for i = #minorCategoryTbl, 1, -1 do
                    if self.minorCategory == minorCategoryTbl[i] then
                        tremove(minorCategoryTbl, i)
                    end
                end
            end
        end)
        hooksecurefunc(ReportingFrameMinorCategoryButtonMixin, "SetupButton", function(self)
            if not (rp.yes and BiaoGe.options["report"] == 1) then return end
            if rp.chattype == "saorao" then
                SetCategoryButtonChecked(self, 1)
                SetCategoryButtonChecked(self, 4)
                SetCategoryButtonChecked(self, 256)
                return
            elseif rp.chattype == "RMT" then
                SetCategoryButtonChecked(self, 1)
                SetCategoryButtonChecked(self, 4)
                SetCategoryButtonChecked(self, 256)
                SetCategoryButtonChecked(self, 2)
                return
            else
                SetCategoryButtonChecked(self, 64)
            end
        end)
        -- 举报完成时
        BG.RegisterEvent("REPORT_PLAYER_RESULT", function(self, even)
            if not (rp.yes and BiaoGe.options["report"] == 1) then return end
            local _type
            if rp.chattype == "saorao" then
                _type = L["恶意骚扰"]
            elseif rp.chattype == "RMT" then
                _type = "RMT"
            else
                _type = L["自动脚本"]
            end
            local color = ""
            if rp.targetClass then
                color = "|c" .. select(4, GetClassColor(rp.targetClass))
            end
            print(BG.STC_y1(format(L["已举报<%s>为%s。"], color .. rp.targetName .. RR, _type)))
            HideUIPanel(ReportFrame)
        end)
        ReportFrame:HookScript("OnHide", function(self)
            ReSet()
        end)

        -- 在右键菜单中插入举报按钮
        do
            local function FindDropdownItem(dropdown, text)
                local name = dropdown:GetName()
                for i = 1, UIDROPDOWNMENU_MAXBUTTONS do
                    local dropdownItem = _G[name .. 'Button' .. i]
                    if dropdownItem:IsShown() and dropdownItem:GetText() == text then
                        return i, dropdownItem
                    end
                end
            end
            local function UpdateButtons(mybuttontext, targetbuttontextTbl)
                local dropdownName = 'DropDownList' .. 1
                local dropdown = _G[dropdownName]
                local myindex1, mybutton1 = FindDropdownItem(dropdown, mybuttontext)
                local index, targetbutton
                for i, text in ipairs(targetbuttontextTbl) do
                    index, targetbutton = FindDropdownItem(dropdown, text)
                    if index and targetbutton then
                        break
                    end
                end
                local x, y = select(4, targetbutton:GetPoint())
                y = y - UIDROPDOWNMENU_BUTTON_HEIGHT
                mybutton1:ClearAllPoints()
                mybutton1:SetPoint("TOPLEFT", x, y)

                for i = index + 1, UIDROPDOWNMENU_MAXBUTTONS do
                    if i ~= myindex1 then
                        local dropdownItem = _G[dropdownName .. 'Button' .. i]
                        if dropdownItem:IsShown() then
                            local p, r, rp, x, y = dropdownItem:GetPoint(1)
                            dropdownItem:SetPoint(p, r, rp, x, y - UIDROPDOWNMENU_BUTTON_HEIGHT)
                        else
                            break
                        end
                    end
                end
            end
            local function AddReportButton(buttontype, unittype, unitorname, dropdown)
                local unitname, playerLocation
                if unittype == "unit" then
                    unitname = UnitName(unitorname)
                    playerLocation = PlayerLocation:CreateFromGUID(UnitGUID(unitorname))
                elseif unittype == "name" then
                    unitname = unitorname
                    local guid = chatPlayerGUIDs[unitorname]
                    if guid then
                        playerLocation = PlayerLocation:CreateFromGUID(guid)
                    elseif dropdown.whoIndex then
                        playerLocation = PlayerLocation:CreateFromWhoIndex(dropdown.whoIndex)
                        rp.targetClass = C_FriendList.GetWhoInfo(dropdown.whoIndex).filename
                    end
                    if not (unitname and playerLocation) then
                        return
                    end
                end

                local mybuttontext
                local info = UIDropDownMenu_CreateInfo()

                if buttontype == 1 then
                    mybuttontext = L["一键举报脚本"]
                    info.text = mybuttontext
                    info.notCheckable = true
                    info.tooltipTitle = L["自动帮你选择并填写举报内容"]
                    info.tooltipText = format(L["选择举报理由：%s\n选择举报项目：%s\n填写举报细节：%s\n\n快捷命令：/BGReport\n\n|cff808080你可在插件设置-BiaoGe-其他功能里关闭这个功能。|r"],
                        REPORTING_MAJOR_CATEGORY_CHEATING, REPORTING_MINOR_CATEGORY_HACKING, "自动脚本 自動腳本 Automatic Scripting")
                    info.func = function()
                        rp.yes = true
                        SetReport(Enum.ReportType.InWorld, unitname, playerLocation)
                    end
                elseif buttontype == 2 then
                    mybuttontext = L["一键举报RMT"]
                    info.text = mybuttontext
                    info.notCheckable = true
                    info.tooltipTitle = L["自动帮你选择并填写举报内容"]
                    info.tooltipText = format(L["选择举报理由：%s\n选择举报项目：%s\n填写举报细节：%s\n\n|cff808080你可在插件设置-BiaoGe-其他功能里关闭这个功能。|r"],
                        REPORTING_MAJOR_CATEGORY_INAPPROPRIATE_COMMUNICATION,
                        REPORTING_MINOR_CATEGORY_TEXT_CHAT .. " " ..
                        REPORTING_MINOR_CATEGORY_SPAM .. " " ..
                        REPORTING_MINOR_CATEGORY_ADVERTISEMENT .. " " ..
                        REPORTING_MINOR_CATEGORY_BOOSTING,
                        "RMT")
                    info.func = function()
                        rp.yes = true
                        rp.chattype = "RMT"
                        SetReport(Enum.ReportType.Chat, unitname, playerLocation)
                    end
                elseif buttontype == 3 then
                    mybuttontext = L["一键举报骚扰"]
                    info.text = mybuttontext
                    info.notCheckable = true
                    info.tooltipTitle = L["自动帮你选择并填写举报内容"]
                    info.tooltipText = format(L["选择举报理由：%s\n选择举报项目：%s\n填写举报细节：%s\n\n|cff808080你可在插件设置-BiaoGe-其他功能里关闭这个功能。|r"],
                        REPORTING_MAJOR_CATEGORY_INAPPROPRIATE_COMMUNICATION,
                        REPORTING_MINOR_CATEGORY_TEXT_CHAT .. " " ..
                        REPORTING_MINOR_CATEGORY_SPAM .. " " ..
                        REPORTING_MINOR_CATEGORY_ADVERTISEMENT,
                        "恶意骚扰 惡意騷擾 Malicious harassment")
                    info.func = function()
                        rp.yes = true
                        rp.chattype = "saorao"
                        SetReport(Enum.ReportType.Chat, unitname, playerLocation)
                    end
                end
                UIDropDownMenu_AddButton(info)
                UpdateButtons(mybuttontext, { REPORT_PLAYER, REPORT_FRIEND, IGNORE })
            end
            hooksecurefunc("UnitPopup_ShowMenu", function(dropdown, which, unit, name, userData)
                -- pt(which, unit, name, userData)
                do
                    local _name, _realm
                    if unit then
                        _name, _realm = UnitFullName(unit)
                    else
                        _name, _realm = strsplit("-", name)
                    end
                    if not _realm then _realm = GetRealmName() end
                    for i, v in ipairs(db) do
                        if _name == v.name and _realm == v.realm then
                            local bt = _G.DropDownList1Button1
                            bt:SetText(bt:GetText() .. BG.STC_r1(format(L["(已举报%s次)"], v.count)))
                            break
                        end
                    end
                end

                if (BiaoGe.options["report"] ~= 1) then return end
                if (UIDROPDOWNMENU_MENU_LEVEL > 1) then return end
                if which ~= "SELF" and which ~= "FRIEND" and unit and UnitIsPlayer(unit) then -- 头像右键菜单
                    AddReportButton(1, "unit", unit, dropdown.whoIndex)
                    AddReportButton(2, "unit", unit, dropdown.whoIndex)
                elseif which == "FRIEND" and not UnitIsUnit('player', Ambiguate(name, 'none')) then -- 聊天框玩家右键菜单
                    AddReportButton(1, "name", name, dropdown)
                    AddReportButton(2, "name", name, dropdown)
                end
            end)

            -- 集结号的举报按钮
            function BG.AddReportButton(ReportType, _chattype, leader, playerLocation, mybuttontext, tooltipText)
                local info = {}
                info.text = mybuttontext
                info.notCheckable = true
                info.tooltipTitle = L["自动帮你选择并填写举报内容"]
                info.tooltipText = tooltipText
                info.func = function()
                    rp.yes = true
                    rp.chattype = _chattype
                    SetReport(ReportType, leader, playerLocation)
                end
                return info
            end
        end
        -- 全部举报
        do
            function OnClick(bt)
                WhoFrameEditBox:ClearFocus()
                local numWhos, totalCount = C_FriendList.GetNumWhoResults()
                if numWhos and numWhos ~= 0 then
                    bt:Disable()
                    WhoFrameWhoButton:Disable()
                    local i = 1
                    local count = 0
                    local goodcount = 0
                    local badcount = 0
                    local updateFrame = CreateFrame("Frame")
                    updateFrame:SetScript("OnUpdate", function(self, elapsed)
                        if not rp.yes then
                            if i <= numWhos then
                                rp.yes = true
                                local info = C_FriendList.GetWhoInfo(i)
                                if info then
                                    local unitname = strsplit("-", info.fullName)
                                    if unitname ~= UnitName("player") then
                                        local playerLocation = PlayerLocation:CreateFromWhoIndex(i)
                                        if unitname and playerLocation then
                                            count = count + 1
                                            bt:SetText(count)

                                            local yes
                                            for i, v in ipairs(db) do
                                                if unitname == v.name then
                                                    badcount = badcount + 1
                                                    yes = true
                                                    break
                                                end
                                            end
                                            if not yes then
                                                goodcount = goodcount + 1
                                            end

                                            SetReport(Enum.ReportType.InWorld, unitname, playerLocation)
                                        end
                                    end
                                end
                                i = i + 1
                            end
                        end
                        if i > numWhos then
                            SendSystemMessage(format(L["本次一共举报|cff00BFFF%s|r个脚本。第一次举报的|cff00FF00%s|r个，曾举报的|cffFF0000%s|r个。"],
                                count, goodcount, badcount))
                            self:SetScript("OnUpdate", nil)
                            self:Hide()
                            bt:Enable()
                            bt:SetText(bt.text)
                            WhoFrameWhoButton:Enable()
                        end
                    end)
                else
                    SendSystemMessage(L["当前名单为空，或者新名单正在等待服务器响应。你可以尝试点击刷新按钮，直到新名单出现。"])
                end
            end

            local bt = CreateFrame("Button", nil, WhoFrame, "UIPanelButtonTemplate")
            bt:SetSize(100, 25)
            bt:SetPoint("TOPLEFT", 60, -27)
            bt.text = L["全部举报"]
            bt:SetText(bt.text)
            bt:Hide()
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                GameTooltip:AddLine(L["把当前名单里的全部玩家举报为自动脚本。"], 1, 0.82, 0, true)
                GameTooltip:AddLine(" ", 1, 0.82, 0, true)
                GameTooltip:AddLine(L["你可在插件设置-BiaoGe-其他功能里关闭这个功能。"], 0.5, 0.5, 0.5, true)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)
            bt:SetScript("OnClick", OnClick)

            BG.RegisterEvent("WHO_LIST_UPDATE", function()
                wipe(whoPlayersName)
                local numWhos, totalCount = C_FriendList.GetNumWhoResults()
                if numWhos and numWhos ~= 0 then
                    for i = 1, numWhos do
                        local info = C_FriendList.GetWhoInfo(i)
                        if info then
                            local unitname = strsplit("-", info.fullName)
                            whoPlayersClass[unitname] = info.filename
                            whoPlayersName[i] = unitname
                        end
                    end
                end
            end)

            WhoFrame:HookScript("OnShow", function(self)
                if BiaoGe.options["report"] == 1 then
                    bt:Show()
                else
                    bt:Hide()
                end
            end)
        end

        -- 举报脚本快捷命令
        SlashCmdList["BIAOGEREPORT"] = function()
            if (BiaoGe.options["report"] ~= 1) then return end
            if UnitExists("target") then
                if UnitIsPlayer("target") then
                    rp.yes = true
                    local unitname = UnitName("target")
                    local playerLocation = PlayerLocation:CreateFromGUID(UnitGUID("target"))
                    SetReport(Enum.ReportType.InWorld, unitname, playerLocation)
                else
                    UIErrorsFrame:AddMessage(L["该目标类型不是玩家。"], 1, 0, 0)
                end
            else
                UIErrorsFrame:AddMessage(L["你没有目标。"], 1, 0, 0)
            end
        end
        SLASH_BIAOGEREPORT1 = "/bgreport"

        -- 监听全部聊天频道，收集GUID
        do
            local f = CreateFrame("Frame")
            f:RegisterEvent("CHAT_MSG_CHANNEL")
            f:RegisterEvent("CHAT_MSG_YELL")
            f:RegisterEvent("CHAT_MSG_GUILD")
            f:RegisterEvent("CHAT_MSG_OFFICER")
            f:RegisterEvent("CHAT_MSG_PARTY")
            f:RegisterEvent("CHAT_MSG_PARTY_LEADER")
            f:RegisterEvent("CHAT_MSG_RAID")
            f:RegisterEvent("CHAT_MSG_RAID_LEADER")
            f:RegisterEvent("CHAT_MSG_RAID_WARNING")
            f:RegisterEvent("CHAT_MSG_SAY")
            f:RegisterEvent("CHAT_MSG_WHISPER")
            f:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
            f:RegisterEvent("CHAT_MSG_BN_WHISPER")
            f:RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM")
            f:RegisterEvent("CHAT_MSG_INSTANCE_CHAT")
            f:RegisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER")
            f:SetScript("OnEvent", function(self, even, ...)
                local _, name = ...
                local guid = select(12, ...)
                if name and guid then
                    chatPlayerGUIDs[name] = guid
                end
            end)
        end
    end
end)
