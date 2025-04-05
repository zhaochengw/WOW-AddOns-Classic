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
        tbl.colortext =tbl.colortext :gsub(" ","").." "
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

local function CreateListTable()
    local wclInfo = {}
    if IsInRaid(1) then
        for i = 1, GetNumGroupMembers() do
            local name = BG.GN("raid" .. i)
            tinsert(wclInfo, GetWCLinfo(name))
        end
    else
        local name = BG.GN()
        tinsert(wclInfo, GetWCLinfo(name))
    end
    sort(wclInfo, function(a, b)
        return a.topfen > b.topfen
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
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        if WP_Database then
            GameTooltip:AddLine(L["———通报wc1———"])
            for i, v in ipairs(CreateListTable()) do
                GameTooltip:AddLine(i .. ". " .. v.colorname .. " " .. v.colortext)
            end
            GameTooltip:AddLine(L["更新日期"] .. ":" .. WP_Database.LASTUPDATE)
        else
            GameTooltip:AddLine(L["错误"], 1, 0, 0, true)
            GameTooltip:AddLine(L["你没有安装WclPlayerScore-WotLK-CN插件。"], 1, .82, 0, true)
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
            self:SetEnabled(false) -- 点击后按钮变灰2秒
            C_Timer.After(2, function()
                bt:SetEnabled(true)
            end)

            if not WP_Database then return end
            yes = true
            local t = 0
            SendChatMessage(L["———通报wc1———"], "RAID")
            t = t + BG.tongBaoSendCD
            for i, v in ipairs(CreateListTable()) do
                BG.After(t, function()
                    SendChatMessage(i .. ". " .. v.name .. " " .. v.text, "RAID")
                end)
                t = t + BG.tongBaoSendCD
            end
            BG.After(t, function()
                SendChatMessage(L["更新日期"] .. ":" .. WP_Database.LASTUPDATE, "RAID")
            end)
            BG.After(t + 1, function()
                yes = false
            end)
            BG.PlaySound(2)
        end
    end)

    return bt
end

local function AddWCLColor(self, event, msg, player, l, cs, t, flag, channelId, ...)
    if not yes then return false end
    local num, name, wcl, pm = strsplit(" ", msg)
    if num and name and wcl then
        name = SetClassCFF(name)
        local newwcl = ""
        for k, str in pairs { strsplit("%", wcl) } do
            local topfen = tonumber(str:match("%)(%d+)"))
            local color = "666666"
            if topfen then
                if topfen >= 100 then
                    color = "E5CC80"
                elseif topfen >= 99 then
                    color = "E26880"
                elseif topfen >= 95 then
                    color = "FF8000"
                elseif topfen >= 75 then
                    color = "A335EE"
                elseif topfen >= 50 then
                    color = "0070FF"
                elseif topfen >= 25 then
                    color = "1EFF00"
                else
                    color = "666666"
                end
                str = str .. "%"
            end
            newwcl = newwcl .. "|cff" .. color .. str .. "|r"
        end
        local newmsg = num .. " " .. name .. " " .. newwcl
        if pm then
            newmsg = newmsg .. " " .. BG.STC_y1(pm)
        end
        return false, newmsg, player, l, cs, t, flag, channelId, ...
    end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", AddWCLColor)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", AddWCLColor)
