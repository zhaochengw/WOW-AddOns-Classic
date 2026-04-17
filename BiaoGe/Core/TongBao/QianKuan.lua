local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local SetClassCFF = ns.SetClassCFF
local RGB_16 = ns.RGB_16

local Maxb = ns.Maxb
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print

------------------函数：通报欠款-----------------
local function CreateListTable(onClick, tbl1)
    local alltable = {}
    local maijiatable = {}
    local sumtable = {}
    local allsum = 0
    local FB = BG.FB1
    for b = 1, Maxb[FB] do
        for i = 1, BG.GetMaxi(FB, b) do
            if BG.Frame[FB]["boss" .. b]["qiankuan" .. i] then
                if BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
                    local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetText() == "" and L["没记买家"]
                        or BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetText()
                    local q = {
                        zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText(),
                        maijia = maijia,
                        color = { BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetTextColor() },
                        qiankuan = tonumber(BiaoGe[FB]["boss" .. b]["qiankuan" .. i])
                    }
                    tinsert(alltable, q)
                    -- 单独保存买家名字
                    maijiatable[maijia] = true
                end
            end
        end
    end
    for i, v in ipairs(alltable) do
        allsum = v.qiankuan + allsum
    end
    for maijia, _ in pairs(maijiatable) do
        local sum = 0
        local color
        for i, v in ipairs(alltable) do
            if maijia == v.maijia then
                sum = v.qiankuan + sum
                color = v.color
            end
        end
        local s = { maijia = maijia, color = color, qiankuan = sum }
        tinsert(sumtable, s)
    end
    sort(sumtable, function(a, b)
        if a.qiankuan > b.qiankuan then
            return true
        end
        return false
    end)

    -- 开始
    local tbl1 = tbl1 or {}
    local tbl2 = {}
    local text = L["———通报欠款———"]
    table.insert(tbl1, text)
    table.insert(tbl2, { text })

    if #alltable ~= 0 then
        for i, v in ipairs(sumtable) do
            if onClick then
                text = L["欠款："] .. v.maijia .. " " .. v.qiankuan
            else
                text = L["欠款："] .. RGB_16(v.maijia, unpack(v.color)) .. " |cffFF0000" .. v.qiankuan .. RR
            end
            table.insert(tbl1, text)
            table.insert(tbl2, { text })
        end

        if onClick then
            text = L["总欠款："] .. allsum
        else
            text = L["总欠款："] .. " |cffFF0000" .. allsum .. RR
        end
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
    else
        local text = L["没有欠款"]
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
    end
    return tbl1, tbl2, sumtable
end


function BG.QianKuanUI(lastbt)
    local bt = BG.CreateButton(BG.ButtonZhangDan)
    bt:SetSize(BG.ButtonZhangDan:GetWidth(), BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", BG.ButtonZhangDan.jiange, 0)
    bt:SetText(L["欠款"])
    BG.ButtonQianKuan = bt
    tinsert(BG.TongBaoButtons, bt)

    bt:SetScript("OnEnter", function(self)
        if BG.Backing then return end
        local tx = CreateListTable(nil)

        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0);
        GameTooltip:ClearLines()
        for i, text in ipairs(tx) do
            GameTooltip:AddLine(text)
        end
        GameTooltip:Show()
        GameTooltip:SetClampedToScreen(false)
    end)
    bt:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        GameTooltip:SetClampedToScreen(true)
    end)
    -- 单击触发
    bt:SetScript("OnClick", function(self)
        BG.FrameHide(0)
        if BG.IsErrorSendChannel() then return end
        self:SetEnabled(false)
        C_Timer.After(2, function()
            bt:SetEnabled(true)
        end)

        local _, tbl = CreateListTable(true)
        BG.SendMsgToRaid(tbl)

        BG.PlaySound(2)
    end)

    return bt
end

-- 欠款者移到78队
BG.Init(function()
    local bt
    local qkPlayers
    local function IsLeader()
        return UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")
    end
    local function CanMove()
        if IsLeader() and not InCombatLockdown() then
            return true
        else
            bt:SetEnabled(true)
        end
    end
    local function GetSupgroupEmpty()
        local tbl = {}
        for i = 1, 8 do
            tbl[i] = 5
        end
        for id = 1, GetNumGroupMembers() do
            local _, _, subgroup = GetRaidRosterInfo(id)
            tbl[subgroup] = tbl[subgroup] - 1
        end
        return tbl
    end
    local function Move(team)
        if not CanMove() then return end
        if team <= 1 then
            BG.SendSystemMessage(L["队伍调整已完成。"])
            bt:SetEnabled(true)
            PlaySoundFile("Interface\\AddOns\\BiaoGe\\Media\\sound\\other\\done.mp3", "Master")
            return
        end
        local needMoveIDs = {}
        for id = 1, GetNumGroupMembers() do
            local name, _, subgroup = GetRaidRosterInfo(id)
            if subgroup == team and name ~= BG.playerName then
                tinsert(needMoveIDs, id)
            end
        end
        if next(needMoveIDs) then
            local emptypTeams = {}
            local emptyTbl = GetSupgroupEmpty()
            for teamIndex = 1, team - 1 do
                for _ = 1, emptyTbl[teamIndex] do
                    tinsert(emptypTeams, teamIndex)
                end
            end
            for i, id in ipairs(needMoveIDs) do
                if emptypTeams[i] then
                    SetRaidSubgroup(id, emptypTeams[i])
                end
            end
            BG.After(.5, function()
                Move(team - 1)
            end)
        else
            Move(team - 1)
        end
    end
    local function Move78()
        if not CanMove() then return end
        local t78 = {}
        for id = 1, GetNumGroupMembers() do
            local name, _, subgroup = GetRaidRosterInfo(id)
            if (subgroup == 7 or subgroup == 8) and not BG.ValueInTable(qkPlayers, name) then
                tinsert(t78, id)
            end
        end
        if next(t78) then
            local emptypTeams = {}
            local emptyTbl = GetSupgroupEmpty()
            for teamIndex = 1, 6 do
                for _ = 1, emptyTbl[teamIndex] do
                    tinsert(emptypTeams, teamIndex)
                end
            end
            for i, id in ipairs(t78) do
                if emptypTeams[i] then
                    SetRaidSubgroup(id, emptypTeams[i])
                end
            end
            return true
        end
    end
    local function Move16()
        if not CanMove() then return end
        local qkPlayerIDs = {}
        for id = 1, GetNumGroupMembers() do
            local name = GetRaidRosterInfo(id)
            if BG.ValueInTable(qkPlayers, name) then
                tinsert(qkPlayerIDs, id)
            end
        end
        for i, id in ipairs(qkPlayerIDs) do
            SetRaidSubgroup(id, i <= 5 and 8 or 7) -- 前5个先移到8队，后5个移到7队
        end
        BG.After(.5, function()
            if not BG.ValueInTable(qkPlayers, BG.playerName) then
                for id = 1, GetNumGroupMembers() do
                    local name, _, subgroup = GetRaidRosterInfo(id)
                    if name == BG.playerName then
                        SetRaidSubgroup(id, 6) -- 把自己调到6队
                        BG.After(.5, function()
                            Move(6)
                        end)
                        return
                    end
                end
            else
                Move(6)
            end
        end)
    end

    -- 先清空78队，再把欠款者放到78队，接着把6-1队往前填充空闲位置
    function BG.SetRaidSubgroup()
        if not CanMove() then return end
        BG.After((Move78() and .5 or 0), Move16)
    end
    
    bt = BG.CreateButton(RaidFrame)
    bt:SetSize(90, 25)
    bt:SetPoint("TOPRIGHT", FriendsFrame, "BOTTOMRIGHT", -2, -2)
    bt:SetText(L["移动欠款者"])
    bt:SetShown(IsInRaid(1) and IsLeader())
    bt:SetScript("OnClick", function(self)
        if qkPlayers then
            self:SetEnabled(false)
            BG.SetRaidSubgroup()
            BG.PlaySound(2)
        end
    end)
    bt:SetScript("OnEnter", function(self)
        qkPlayers = nil
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(L["把欠款者移到78队"], 1, 1, 1, true)
        if not IsInRaid(1) then
            GameTooltip:AddLine(L["不在团队，该功能无法使用。"], 1, 0, 0, true)
            GameTooltip:Show()
            return
        end
        if not IsLeader() then
            GameTooltip:AddLine(L["你不是团长或助理，该功能无法使用。"], 1, 0, 0, true)
            GameTooltip:Show()
            return
        end
        if InCombatLockdown() then
            GameTooltip:AddLine(L["战斗中，该功能无法使用。"], 1, 0, 0, true)
            GameTooltip:Show()
            return
        end
        if GetNumGroupMembers() > 30 then
            GameTooltip:AddLine(L["团队人数超过30人，该功能无法使用。"], 1, 0, 0, true)
            GameTooltip:Show()
            return
        end
        local _, _, players = CreateListTable(nil)
        if not next(players) then
            GameTooltip:AddLine(L["没有欠款。"], 1, 0, 0, true)
            GameTooltip:Show()
            return
        end
        if #players > 10 then
            GameTooltip:AddLine(L["欠款者超过10人，该功能无法使用。"], 1, 0, 0, true)
            GameTooltip:Show()
            return
        end
        local tbl = {}
        for i, v in ipairs(players) do
            GameTooltip:AddLine(format(L["%s. %s（欠款%s）"], i, SetClassCFF(v.maijia), v.qiankuan), 1, 0.82, 0)
            tinsert(tbl, v.maijia)
        end
        GameTooltip:Show()
        qkPlayers = tbl
    end)
    bt:SetScript("OnLeave", GameTooltip_Hide)

    BG.RegisterEvent("GROUP_ROSTER_UPDATE", function()
        BG.After(0.5, function()
            bt:SetShown(IsInRaid(1) and IsLeader())
        end)
    end)
end)
