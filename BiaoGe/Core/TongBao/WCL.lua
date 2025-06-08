local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local SetClassCFF = ns.SetClassCFF
local RGB_16 = ns.RGB_16

local pt = print

--[[
print( "|cFFE5CC80".."啊~")
print( "|cFFE26880".."啊~")
print( "|cFFFF8000".."啊~")
print( "|cFFBE8200".."啊~")
print( "|cFFA335EE".."啊~")
print( "|cFF0070FF".."啊~")
print( "|cFF1EFF00".."啊~")
print( "|cFF666666".."啊~")

5046匕首岭
 ]]

function BG.Expand(v)
    local switch = {
        ["r"] = function()
            return "RS"
        end,
        ["V"] = function()
            return "VOA"
        end,
        ["X"] = function()
            return "NAX"
        end,
        ["D"] = function()
            return "ULD"
        end,
        ["O"] = function()
            return "Onyxia"
        end,
        ["T"] = function()
            return "TOC"
        end,
        ["I"] = function()
            return "ICC"
        end,
        ["A"] = function()
            return "|cFFE5CC80" -- 金
        end,
        ["S"] = function()
            return "|cFFE26880" -- 粉
        end,
        ["L"] = function()
            return "|cFFFF8000" -- 橙
        end,
        ["N"] = function()
            return "|cFFBE8200"
        end,
        ["E"] = function()
            return "|cFFA335EE" -- 紫
        end,
        ["R"] = function()
            return "|cFF0070FF" -- 蓝
        end,
        ["U"] = function()
            return "|cFF1EFF00" -- 绿
        end,
        ["C"] = function()
            return "|cFF666666" -- 灰
        end,
        ["%"] = function()
            return "% "
        end
    }
    local fenshu = ""
    local max = strlen(v)
    for j = 1, max do
        local ts = strsub(v, j, j)
        local f = switch[ts]
        if f then
            fenshu = fenshu .. f()
        else
            fenshu = fenshu .. ts
        end
    end
    return fenshu
end

local function GetWCLinfo(name)
    -- test
    -- WP_Database["苍刃"] = "RT:(鲜血)148.26/57.8%LD:(鲜血)130.91/98.8%|13"
    -- STOP_Database["苍刃"] = "1血DK,3符文DK,3血DKDPS"
    local tbl = {}
    local wclText = WP_Database[name]
    local pmText
    if STOP_Database then
        pmText = STOP_Database[name]
        if pmText then
            pmText = pmText:gsub("(%d+)", "本服第%1")
        end
    end
    if wclText then
        wclText = strsplit("|", wclText)
        local yes
        for k, str in pairs({ strsplit("%", wclText) }) do
            local FB = 0
            local ED = str:match("(.+):")
            if ED and ED:find("T") then
                yes = true
                ED = strsub(ED, 2, 2)
                if ED == "r" then
                    FB = 9
                elseif ED == "I" then
                    FB = 8
                elseif ED == "T" then
                    FB = 7
                elseif ED == "O" then
                    FB = 6
                elseif ED == "D" then
                    FB = 5
                elseif ED == "X" then
                    FB = 4
                elseif ED == "V" then
                    FB = 4
                end
                local topfen = tonumber(str:match("/(.+)"))
                if topfen then
                    topfen = topfen / 100 + FB
                    if not tbl.topfen then
                        tbl.topfen = topfen
                    elseif topfen > tbl.topfen then
                        tbl.topfen = topfen
                    end
                end
            end
        end
        if not yes then
            tbl.topfen = 1
        end
        tbl.colortext = BG.Expand(wclText):gsub("%).-/", ")")
        tbl.colortext = tbl.colortext:gsub(" ", "") .. " "
        tbl.text = tbl.colortext:gsub("|c[fF][fF]......", ""):gsub("|r", "")
        if pmText then
            tbl.colortext = tbl.colortext .. "\n" .. pmText
            tbl.text = tbl.text .. pmText
        end
    else
        tbl.topfen = 0
        tbl.colortext = BG.STC_dis(L["没有wc1记录"])
        tbl.text = L["没有wc1记录"]
    end
    tbl.colorname = SetClassCFF(name)
    tbl.name = name
    return tbl
end

local function GetColor(per)
    if per < 25 then
        return "|cFF666666" .. per .. "|r" -- 灰
    elseif per < 50 then
        return "|cFF1EFF00" .. per .. "|r" -- 绿
    elseif per < 75 then
        return "|cFF0070FF" .. per .. "|r" -- 蓝
    elseif per < 95 then
        return "|cFFA335EE" .. per .. "|r" -- 紫
    elseif per < 99 then
        return "|cFFFF8000" .. per .. "|r" -- 橙
    elseif per < 100 then
        return "|cFFE26880" .. per .. "|r" -- 粉
    elseif per == 100 then
        return "|cFFE5CC80" .. per .. "|r" -- 金
    else
        return per
    end
end

local function CreateListTable()
    local wclInfo = {}
    local function GetInfo(unit)
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:SetUnit(unit)
        local tbl = {}
        local info
        for i = 1, GameTooltip:NumLines() do
            local t = _G["GameTooltipTextLeft" .. i]:GetText()
            if t then
                tinsert(tbl, t)
            end
        end
        if next(tbl) then
            for i, t in ipairs(tbl) do
                if t:match("Warcraft Logs") and tbl[i + 1] then
                    local text = BG.ClearColorCode(tbl[i + 1])
                    local FB, per = text:match("^.-%s(%a+)%s+(%d+%.-%d-)%s+")
                    if FB and per then
                        info = {
                            FB = FB,
                            per = tonumber(per),
                            text = tbl[i + 1],
                            clearText = text,
                        }
                    end
                    break
                end
            end
        end
        if info then
            tinsert(wclInfo, {
                name = BG.GN(unit),
                info = info,
            })
        end
    end
    if IsInRaid(1) then
        for i = 1, GetNumGroupMembers() do
            GetInfo("raid" .. i)
        end
    else
        GetInfo("player")
    end
    sort(wclInfo, function(a, b)
        return a.info.per > b.info.per
    end)
    return wclInfo
end

local yes
function BG.WCLUI(lastbt)
    local bt = BG.CreateButton(BG.ButtonZhangDan)
    bt:SetSize(BG.ButtonZhangDan:GetWidth(), BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", BG.ButtonZhangDan.jiange, 0)
    bt:SetText("WCL")
    BG.ButtonWCL = bt
    tinsert(BG.TongBaoButtons, bt)

    -- 鼠标悬停提示
    bt:SetScript("OnEnter", function(self)
        if BG.Backing then return end
        if IsAddOnLoaded("ArchonTooltip") then
            local tbl = CreateListTable()
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["———通报WCL———"])
            for i, v in ipairs(tbl) do
                GameTooltip:AddLine(format("%s. %s %s %s", i, SetClassCFF(v.name), v.info.FB, GetColor(v.info.per)))
            end
        else
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["错误"], 1, 0, 0, true)
            GameTooltip:AddLine(L["你没有安装官方WCL插件。"], 1, .82, 0, true)
        end
        GameTooltip:Show()
    end)
    bt:SetScript("OnLeave", GameTooltip_Hide)
    bt:SetScript("OnClick", function(self)
        BG.FrameHide(0)
        if not IsInRaid(1) then
            SendSystemMessage(L["不在团队，无法通报"])
            BG.PlaySound(1)
        else
            self:SetEnabled(false) 
            C_Timer.After(2, function()
                bt:SetEnabled(true)
            end)
            local tbl = CreateListTable()
            if not next(tbl) then return end
            yes = true
            local t = 0
            SendChatMessage(L["———通报wc1———"], "RAID")
            t = t + BG.tongBaoSendCD
            for i, v in ipairs(CreateListTable()) do
                BG.After(t, function()
                    SendChatMessage(format("%s. %s %s %s", i, v.name,
                        v.info.FB, v.info.per), "RAID")
                end)
                t = t + BG.tongBaoSendCD
            end
            BG.After(t, function()
                yes = false
            end)
            BG.PlaySound(2)
        end
    end)

    return bt
end

local function AddWCLColor(self, event, msg, player, l, cs, t, flag, channelId, ...)
    if not yes then return false end
    local num, name, FB, per = strsplit(" ", msg)
    per = tonumber(per)
    if num and name and per then
        name = SetClassCFF(name)
        local newmsg = num .. " " .. name .. " " .. FB .. " " .. GetColor(per)
        return false, newmsg, player, l, cs, t, flag, channelId, ...
    end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", AddWCLColor)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", AddWCLColor)
