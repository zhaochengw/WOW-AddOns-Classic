local AddonName, ns = ...

local pt = print

BG.RegisterEvent("ADDON_LOADED", function(self, event, addonName)
    if addonName ~= AddonName then return end

    local aura_env = aura_env or {}
    aura_env.ver = "v2.1"

    function aura_env.GetVerNum(str)
        return tonumber(string.match(str, "v(%d+%.%d+)")) or 0
    end

    if not _G.BGA then
        _G.BGA = {}
        _G.BGA.Frames = {}
    else
        if aura_env.GetVerNum(aura_env.ver) <= aura_env.GetVerNum(_G.BGA.ver) then
            return
        end

        if _G.BGA.AuctionMainFrame then
            _G.BGA.AuctionMainFrame:Hide()
        end
        if _G.BGA.Even then
            _G.BGA.Even:UnregisterAllEvents()
        end
        if _G.BGA.Frames then
            wipe(_G.BGA.Frames)
        end
    end
    _G.BGA.ver = aura_env.ver
    _G.BGA.aura_env = aura_env

    aura_env.AddonChannel = "BiaoGeAuction"
    C_ChatInfo.RegisterAddonMessagePrefix(aura_env.AddonChannel)

    local L = setmetatable({}, {
        __index = function(table, key)
            return tostring(key)
        end
    })

    if (GetLocale() == "zhTW") then
        L["Alt+点击才能生效"] = "Alt+點擊才能生效"
        L["只有团长或物品分配者有权限取消拍卖"] = "只有團長或物品分配者有權限取消拍賣"
        L["根据你的出价动态改变增减幅度"] = "根據你的出價動態改變增減幅度"
        L["长按可以快速调整价格"] = "長按可以快速調整價格"
        L["在输入框使用滚轮也可快速调整价格"] = "在輸入框使用滾輪也可快速調整價格"
        L[">> 你 <<"] = ">> 你 <<"
        L["別人(匿名)"] = "別人(匿名)"
        L["需高于当前价格"] = "需高於當前價格"
        L["需高于或等于起拍价"] = "需高於或等於起拍價"
        L["取消拍卖"] = "取消拍賣"
        L["装绑"] = "裝綁"
        L["|cffFFD100当前价格：|r"] = "|cffFFD100當前價格：|r"
        L["|cffFFD100起拍价：|r"] = "|cffFFD100起拍價：|r"
        L["|cffFFD100出价最高者：|r"] = "|cffFFD100出價最高者：|r"
        L["|cffFFD100< 匿名模式 >|r"] = "|cffFFD100< 匿名模式 >|r"
        L["出价"] = "出價"
        L["正常模式"] = "正常模式"
        L["匿名模式"] = "匿名模式"
        L["{rt1}拍卖开始{rt1} %s 起拍价：%s 拍卖时长：%ss %s"] = "{rt1}拍賣開始{rt1} %s 起拍價：%s 拍賣時長：%ss %s"
        L["拍卖结束"] = "拍賣結束"
        L["|cffFF0000流拍：|r"] = "|cffFF0000流拍：|r"
        L["{rt7}流拍{rt7} %s"] = "{rt7}流拍{rt7} %s"
        L["|cff00FF00成交价：|r"] = "|cff00FF00成交價：|r"
        L["|cff00FF00买家：|r"] = "|cff00FF00買家：|r"
        L["{rt6}拍卖成功{rt6} %s %s %s"] = "{rt6}拍賣成功{rt6} %s %s %s"
        L["拍卖取消"] = "拍賣取消"
        L["{rt7}拍卖取消{rt7} %s"] = "{rt7}拍賣取消{rt7} %s"
        L["滚轮：快速调整价格"] = "滾輪：快速調整價格"
        L["长按：快速调整价格"] = "長按：快速調整價格"
        L["点击：复制当前价格并增加"] = "點擊：複製當前價格並增加"
        L["隐藏"] = "隱藏"
        L["显示"] = "顯示"
        L["拍卖成功"] = "拍賣成功"
        L["流拍"] = "流拍"
        L["设置心理价格"] = "設置心理價格"
        L["开启自动出价"] = "開啟自動出價"
        L["取消自动出价"] = "取消自動出價"
        L["自动出价"] = "自動出價"
        L[">>正在自动出价<<"] = ">>正在自動出價<<"
        L["心理价格锁定中"] = "心理價格鎖定中"
        L["取消自动出价后才能修改。"] = "取消自動出價後才能修改。"
        L["如果别人出价比你高时，自动帮你出价，每次加价为最低幅度，出价不会高于你设定的心理价格。"] = "如果別人出價比你高時，自動幫你出價，每次加價為最低幅度，出價不會高於你設定的心理價格。"
        L["心理价格"] = "心理價格"
        L["最小加价幅度为%s"] = "最小加價幅度为%s"
        L["（%s）"] = "（%s）"
        L["没有人出价"] = "沒有人出價"
        L["出价记录"] = "出價記錄"
        L["记录"] = "記錄"
        L["、"] = "、"
        L["匿名"] = "匿名"
    end

    function aura_env.RGB(hex, Alpha)
        local red = string.sub(hex, 1, 2)
        local green = string.sub(hex, 3, 4)
        local blue = string.sub(hex, 5, 6)

        red = tonumber(red, 16) / 255
        green = tonumber(green, 16) / 255
        blue = tonumber(blue, 16) / 255

        if Alpha then
            return red, green, blue, Alpha
        else
            return red, green, blue
        end
    end

    function aura_env.SetClassCFF(name, player, type)
        if type then return name end
        local _, class
        if player then
            _, class = UnitClass(player)
        else
            _, class = UnitClass(name)
        end
        local colorname = ""
        if class then
            local color = select(4, GetClassColor(class))
            colorname = "|c" .. color .. name .. "|r"
            return colorname, color
        else
            return name, ""
        end
    end

    -- 常量
    do
        aura_env.sound1 = SOUNDKIT.GS_TITLE_OPTION_OK -- 按键音效
        aura_env.sound2 = 569593                      -- 升级音效
        aura_env.GREEN1 = "00FF00"
        aura_env.RED1 = "FF0000"

        aura_env.WIDTH = 310
        aura_env.REPEAT_TIME = 20
        aura_env.HIDEFRAME_TIME = 3
        aura_env.edgeSize = 2.5
        aura_env.backdropColor = { 0, 0, 0, .6 }
        aura_env.backdropBorderColor = { 1, 1, 0, 1 }
        aura_env.backdropColor_filter = { .5, .5, .5, .3 }
        aura_env.backdropBorderColor_filter = { .5, .5, .5, 1 }
        aura_env.backdropColor_IsMe = { aura_env.RGB("009900", .6) }
        aura_env.backdropBorderColor_IsMe = { 0, 1, 0, 1 }
        aura_env.raidRosterInfo = {}

        aura_env.MiniMoneyTbl = {
            -- 小于该价格时，每次加价幅度，最低加价幅度
            { 30, 1, 1 },
            { 100, 10, 1 },
            { 3000, 100, 100 },
            { 10000, 500, 100 },
            { 30000, 1000, 500 },
            { 100000, 5000, 500 },
            { nil, 10000, 1000 },
        }
    end

    -- 字体
    local STANDARD_TEXT_FONT
    do
        local l = GetLocale()
        if (l == "koKR") then
            STANDARD_TEXT_FONT = "Fonts\\2002.TTF";
        elseif (l == "zhCN") then
            STANDARD_TEXT_FONT = "Fonts\\ARKai_T.ttf";
        elseif (l == "zhTW") then
            STANDARD_TEXT_FONT = "Fonts\\ARKai_T.ttf";
        elseif (l == "ruRU") then
            STANDARD_TEXT_FONT = "Fonts\\FRIZQT___CYR.TTF";
        else
            STANDARD_TEXT_FONT = "Fonts\\FRIZQT__.TTF";
        end

        local color = "Gold18" -- BGA.FontGold18
        _G.BGA.FontGold18 = CreateFont("BGA.Font" .. color)
        _G.BGA.FontGold18:SetTextColor(1, 0.82, 0)
        _G.BGA.FontGold18:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")

        local color = "Dis18" -- BGA.FontDis18
        _G.BGA.FontDis18 = CreateFont("BGA.Font" .. color)
        _G.BGA.FontDis18:SetTextColor(.5, .5, .5)
        _G.BGA.FontDis18:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
        local color = "Dis15" -- BGA.FontDis15
        _G.BGA.FontDis15 = CreateFont("BGA.Font" .. color)
        _G.BGA.FontDis15:SetTextColor(.5, .5, .5)
        _G.BGA.FontDis15:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")

        local color = "Green15" -- BGA.FontGreen15
        _G.BGA.FontGreen15 = CreateFont("BGA.Font" .. color)
        _G.BGA.FontGreen15:SetTextColor(0, 1, 0)
        _G.BGA.FontGreen15:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")

        local color = "white15" -- BGA.Fontwhite15
        _G.BGA.FontWhite15 = CreateFont("BGA.Font" .. color)
        _G.BGA.FontWhite15:SetTextColor(1, 1, 1)
        _G.BGA.FontWhite15:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
    end

    function aura_env.IsRaidLeader(player)
        if not player then
            player = UnitName("player")
        end
        if player == aura_env.raidLeader then
            return true
        end
    end

    function aura_env.IsML(player)
        if not player then
            player = UnitName("player")
        end
        if (player == aura_env.raidLeader) or (player == aura_env.ML) then
            return true
        end
    end

    function aura_env.UpdateRaidRosterInfo()
        wipe(aura_env.raidRosterInfo)
        aura_env.raidLeader = nil
        aura_env.ML = nil
        if IsInRaid(1) then
            for i = 1, GetNumGroupMembers() do
                local name, rank, subgroup, level, class2, class, zone, online,
                isDead, role, isML, combatRole = GetRaidRosterInfo(i)
                if name then
                    name = strsplit("-", name)
                    local a = {
                        name = name,
                        rank = rank,
                        subgroup = subgroup,
                        level = level,
                        class2 = class2,
                        class = class,
                        zone = zone,
                        online = online,
                        isDead = isDead,
                        role = role,
                        isML = isML,
                        combatRole = combatRole
                    }
                    table.insert(aura_env.raidRosterInfo, a)
                    if rank == 2 then
                        aura_env.raidLeader = name
                    end
                    if isML then
                        aura_env.ML = name
                    end
                end
            end

            C_ChatInfo.SendAddonMessage(aura_env.AddonChannel, "MyVer" .. "," .. aura_env.ver, "RAID")
        end
        for i, f in ipairs(_G.BGA.Frames) do
            if not f.IsEnd and aura_env.IsML() then
                f.cancel:Show()
                f.autoTextButton:ClearAllPoints()
                f.autoTextButton:SetPoint("TOP", 45, -2)
            else
                f.cancel:Hide()
                f.autoTextButton:ClearAllPoints()
                f.autoTextButton:SetPoint("TOP", 0, -2)
            end
        end
    end

    function aura_env.GetAuctioningFromRaid()
        if not IsInRaid(1) then return end
        aura_env.canGetAuctioning = true
        C_ChatInfo.SendAddonMessage(aura_env.AddonChannel, "GetAuctioning", "RAID")
        C_Timer.After(1, function()
            aura_env.canGetAuctioning = false
        end)
    end

    function aura_env.Pass_OnClick(self)
        local f = self.owner
        if f.IsAlpha then
            self:SetText(L["隐藏"])
            f:SetAlpha(1)
            f.IsAlpha = false
            f.AlphaFrame:Hide()
            f.AlphaFrame2:Hide()
        else
            self:SetText(L["显示"])
            if aura_env.lastFocus then
                aura_env.lastFocus:ClearFocus()
            end
            f:SetAlpha(0.3)
            f.IsAlpha = true
            f.AlphaFrame:Show()
            f.AlphaFrame2:Show()
        end
        PlaySound(aura_env.sound1)
    end

    function aura_env.Cancel_OnClick(self)
        if IsAltKeyDown() then
            C_ChatInfo.SendAddonMessage(aura_env.AddonChannel, "CancelAuction" .. "," ..
                self.owner.auctionID, "RAID")
            PlaySound(aura_env.sound1)
        end
    end

    function aura_env.Cancel_OnEnter(self)
        local f = self.owner
        if aura_env.IsRight(self) then
            GameTooltip:SetOwner(f, "ANCHOR_LEFT", 0, 0)
        else
            GameTooltip:SetOwner(f, "ANCHOR_RIGHT", 0, 0)
        end
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
        GameTooltip:AddLine(L["Alt+点击才能生效"], 1, 0.82, 0, true)
        GameTooltip:AddLine(L["只有团长或物品分配者有权限取消拍卖"], 0.5, 0.5, 0.5, true)
        GameTooltip:Show()
    end

    function aura_env.LogTextButton_OnEnter(self)
        self.isOnEnter = true
        local f = self.owner
        if aura_env.IsRight(self) then
            GameTooltip:SetOwner(f, "ANCHOR_LEFT", 0, 0)
        else
            GameTooltip:SetOwner(f, "ANCHOR_RIGHT", 0, 0)
        end
        GameTooltip:ClearLines()
        GameTooltip:AddLine(L["出价记录"], 1, 1, 1, true)

        if #f.logs == 0 then
            GameTooltip:AddLine(L["没有人出价"], .5, .5, .5, true)
        elseif #f.logs > 15 then
            GameTooltip:AddLine("......", .5, .5, .5, true)
            for i = #f.logs - 14, #f.logs do
                GameTooltip:AddLine(i .. L["、"] .. f.logs[i].money .. format(L["（%s）"], f.logs[i].player), 1, .82, 0, true)
            end
        else
            for i = 1, #f.logs do
                GameTooltip:AddLine(i .. L["、"] .. f.logs[i].money .. format(L["（%s）"], f.logs[i].player), 1, .82, 0, true)
            end
        end
        GameTooltip:Show()
    end

    function aura_env.LogTextButton_OnLeave(self)
        self.isOnEnter = false
        GameTooltip:Hide()
    end

    function aura_env.JiaJian(money, fudu, _type)
        if _type == "+" then
            return money + fudu
        elseif _type == "-" then
            if money - fudu > 0 then
                return money - fudu
            elseif (money == fudu) and money ~= 1 then
                return money - 10
            else
                return 0
            end
        end
    end

    function aura_env.Addmoney(money, _type)
        local money = tonumber(money) or 0
        local fudu
        for i, v in ipairs(aura_env.MiniMoneyTbl) do
            if not v[1] or money < v[1] then
                fudu = v[2]
                break
            end
        end
        return aura_env.JiaJian(money, fudu, _type), fudu
    end

    function aura_env.TooSmall(self)
        local myMoney = tonumber(self:GetText()) or 0
        local currentMoney = self.owner.money
        local money = myMoney - currentMoney
        for i, v in ipairs(aura_env.MiniMoneyTbl) do
            if not v[1] or currentMoney < v[1] then
                if money < v[3] then
                    return v[3]
                else
                    return false
                end
            end
        end
    end

    function aura_env.IsRight(self)
        if self.owner:GetCenter() > UIParent:GetCenter() then
            return true
        end
    end

    function aura_env.itemOnEnter(self)
        if aura_env.IsRight(self) then
            GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
        else
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
        end
        GameTooltip:ClearLines()
        GameTooltip:SetItemByID(self.itemID)
        GameTooltip:Show()
        if IsControlKeyDown() then
            SetCursor("Interface/Cursor/Inspect")
        end
        self.isOnEnter = true
        aura_env.itemIsOnEnter = true
        if BG and BG.Show_AllHighlight then
            BG.Show_AllHighlight(self.link)
        end
    end

    function aura_env.itemOnLeave(self)
        GameTooltip:Hide()
        self.isOnEnter = false
        aura_env.itemIsOnEnter = false
        SetCursor(nil)
        if BG and BG.Hide_AllHighlight then
            BG.Hide_AllHighlight()
        end
    end

    function aura_env.Auctioning(f, duration)
        f.bar:Show()
        local t = 0
        f.bar:SetScript("OnUpdate", function(self, elapsed)
            t = t + elapsed
            local remaining = tonumber(format("%.3f", duration - t))
            local a = remaining / duration
            local _, max = f.bar:GetMinMaxValues()
            local v = a * max
            f.bar:SetValue(v)
            if remaining <= 10 then
                if f.filter and not (f.player and f.player == UnitName("player")) then
                    f.bar:SetStatusBarColor(unpack(BGA.aura_env.backdropBorderColor_filter))
                else
                    f.bar:SetStatusBarColor(1, 0, 0, 0.6)
                end
                f.remainingTime:SetTextColor(1, 0, 0)
                f.remainingTime:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
            else
                if f.filter and not (f.player and f.player == UnitName("player")) then
                    f.bar:SetStatusBarColor(unpack(BGA.aura_env.backdropBorderColor_filter))
                else
                    f.bar:SetStatusBarColor(1, 1, 0, 0.6)
                end
                f.remainingTime:SetTextColor(1, 1, 1)
                f.remainingTime:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            end
            f.remainingTime:SetText((format("%d", remaining) + 1) .. "s")
            f.remaining = remaining

            if remaining <= 0 then
                f.myMoneyEdit:Hide()
                f.remainingTime:SetText("0s")
            end
            if remaining <= -0.5 then
                f.bar:SetScript("OnUpdate", nil)

                f.remainingTime:Hide()
                f.bar:Hide()
                f.IsEnd = true
                f.cancel:Hide()

                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 30, "OUTLINE")
                t:SetPoint("TOPRIGHT", f.itemFrame, "BOTTOMRIGHT", -10, -5)

                if f.player and f.player ~= "" then
                    t:SetText(L["拍卖成功"])
                    t:SetTextColor(0, 1, 0)
                    f.currentMoneyText:SetText(L["|cff00FF00成交价：|r"] .. f.money)
                    if f.player == UnitName("player") then
                        f.topMoneyText:SetText(L["|cff00FF00买家：|r"] .. "|cff" .. aura_env.GREEN1 .. L[">> 你 <<"])
                    else
                        f.topMoneyText:SetText(L["|cff00FF00买家：|r"] .. f.colorplayer)
                    end

                    if BG then
                        BG.sendMoneyLog=BG.sendMoneyLog or {}
                        BG.sendMoneyLog[f.itemID]=f.logs
                    end

                    if aura_env.IsRaidLeader() then
                        SendChatMessage(format(L["{rt6}拍卖成功{rt6} %s %s %s"], f.link, f.player, f.money), "RAID")
                    end
                else
                    t:SetText(L["流拍"])
                    t:SetTextColor(1, 0, 0)
                    f.currentMoneyText:SetText(L["|cffFF0000流拍：|r"] .. f.money)
                    f.topMoneyText:SetText("")

                    if aura_env.IsRaidLeader() then
                        SendChatMessage(format(L["{rt7}流拍{rt7} %s"], f.link), "RAID")
                    end
                end

                C_Timer.After(aura_env.HIDEFRAME_TIME, function()
                    aura_env.UpdateFrame(f)
                end)
            end
        end)
    end

    function aura_env.currentMoney_OnEnter(self)
        if not self.owner.start and not self.owner.IsEnd and self.owner.player ~= UnitName("player") then
            local _, fudu = aura_env.Addmoney(self.owner.money, "+")
            GameTooltip:SetOwner(self.owner, "ANCHOR_BOTTOM", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self.owner.currentMoneyText:GetText(), 1, 1, 1)
            GameTooltip:AddLine(L["点击：复制当前价格并增加"] .. fudu, 1, 0.82, 0, true)
            GameTooltip:Show()
            self.isOnEnter = true
        end
    end

    function aura_env.currentMoney_OnMouseDown(self)
        self.owner:GetScript("OnMouseDown")(_G.BGA.AuctionMainFrame)
    end

    function aura_env.currentMoney_OnMouseUp(self)
        if not self.owner.start and not self.owner.IsEnd and self.owner.player ~= UnitName("player") then
            self.owner.myMoneyEdit:SetText(aura_env.Addmoney(self.owner.money, "+"))
            aura_env.UpdateAllOnEnters()
            PlaySound(aura_env.sound1)
        end
        self.owner:GetScript("OnMouseUp")(_G.BGA.AuctionMainFrame)
    end

    function aura_env.myMoney_OnTextChanged(self)
        local f = self.owner
        local money = tonumber(self:GetText()) or 0
        if f.start then
            if money < f.money then
                self:SetTextColor(1, 0, 0)
                f.ButtonSendMyMoney:Disable()
                if f.player ~= UnitName("player") then
                    f.ButtonSendMyMoney.disf:Show()
                    f.ButtonSendMyMoney.disf.text = L["需高于或等于起拍价"]
                end
            else
                self:SetTextColor(1, 1, 1)
                f.ButtonSendMyMoney:Enable()
                f.ButtonSendMyMoney.disf:Hide()
            end
        elseif money <= f.money then
            f.ButtonSendMyMoney:Disable()
            if f.player ~= UnitName("player") then
                self:SetTextColor(1, 0, 0)
                f.ButtonSendMyMoney.disf:Show()
                f.ButtonSendMyMoney.disf.text = L["需高于当前价格"]
            else
                self:SetTextColor(1, 1, 1)
            end
        elseif aura_env.TooSmall(self) then
            self:SetTextColor(1, 0, 0)
            f.ButtonSendMyMoney:Disable()
            f.ButtonSendMyMoney.disf:Show()
            f.ButtonSendMyMoney.disf.text = format(L["最小加价幅度为%s"], aura_env.TooSmall(self))
        else
            self:SetTextColor(1, 1, 1)
            f.ButtonSendMyMoney:Enable()
            f.ButtonSendMyMoney.disf:Hide()
        end
        aura_env.UpdateAllOnEnters()
    end

    function aura_env.myMoney_OnMouseWheel(self, delta)
        local _type = "-"
        if delta == 1 then
            _type = "+"
        end
        self:SetText(aura_env.Addmoney(self:GetText(), _type))
    end

    function aura_env.myMoney_OnEnter(self)
        GameTooltip:SetOwner(self.owner, "ANCHOR_BOTTOM", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self:GetText(), 1, 1, 1)
        GameTooltip:AddLine(L["滚轮：快速调整价格"], 1, 0.82, 0, true)
        GameTooltip:Show()
        self.isOnEnter = true
    end

    function aura_env.OnLeave(self)
        GameTooltip_Hide()
        self.isOnEnter = false
    end

    function aura_env.JiaJian_OnEnter(self)
        local _, fudu = aura_env.Addmoney(self.edit:GetText(), self._type)
        local r, g, b = 1, 0, 0
        if self._type == "+" then
            r, g, b = 0, 1, 0
        end
        GameTooltip:SetOwner(self.owner, "ANCHOR_BOTTOM", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self._type .. " " .. fudu, r, g, b, true)
        GameTooltip:AddLine(L["根据你的出价动态改变增减幅度"], 1, 0.82, 0, true)
        GameTooltip:AddLine(L["长按：快速调整价格"], 1, 0.82, 0, true)
        GameTooltip:Show()
        self.isOnEnter = true
    end

    function aura_env.JiaJian_OnClick(self)
        self.edit:SetText(aura_env.Addmoney(self.edit:GetText(), self._type))
        aura_env.UpdateAllOnEnters()
        PlaySound(aura_env.sound1)
    end

    function aura_env.JiaJian_OnMouseDown(self)
        local t = 0
        local t_do = 0.5
        self:SetScript("OnUpdate", function(self, elapsed)
            t = t + elapsed
            if t >= t_do then
                t = t_do - 0.1
                self.edit:SetText(aura_env.Addmoney(self.edit:GetText(), self._type))
                aura_env.JiaJian_OnEnter(self)
            end
        end)
    end

    function aura_env.JiaJian_OnMouseUp(self)
        self:SetScript("OnUpdate", nil)
    end

    function aura_env.SendMyMoney_OnClick(self)
        local f = self.owner
        if f.ButtonSendMyMoney:IsEnabled() then
            local money = tonumber(f.myMoneyEdit:GetText()) or 0
            C_ChatInfo.SendAddonMessage(aura_env.AddonChannel, "SendMyMoney" .. "," ..
                f.auctionID .. "," .. money, "RAID")
            f.myMoneyEdit:ClearFocus()
            PlaySound(aura_env.sound1)

            if not f.start and BiaoGe and BiaoGe.options and BiaoGe.options.Sound then
                local num = random(10)
                if num <= 1 then
                    PlaySoundFile(BG["sound_HusbandComeOn" .. BiaoGe.options.Sound], "Master")
                end
            end
        end
    end

    function aura_env.SetMoney(f, money, player)
        f.updateFrame:Show()
        f.autoFrame.updateFrame:Show()

        f.money = money
        f.currentMoneyText:SetText(L["|cffFFD100当前价格：|r"] .. money)
        f.player = player
        f.colorplayer = aura_env.SetClassCFF(player)
        f.myMoneyEdit:Show()
        f.start = false
        if player == UnitName("player") then
            f.topMoneyText:SetText(L["|cffFFD100出价最高者：|r"] .. "|cff" .. aura_env.GREEN1 .. L[">> 你 <<"])
            f:SetBackdropColor(unpack(aura_env.backdropColor_IsMe))
            f:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor_IsMe))
            f.autoFrame:SetBackdropColor(unpack(aura_env.backdropColor_IsMe))
            f.autoFrame:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor_IsMe))
            f.hide:SetNormalFontObject(_G.BGA.FontGreen15)
            f.cancel:SetNormalFontObject(_G.BGA.FontGreen15)
            f.autoTextButton:SetNormalFontObject(_G.BGA.FontGreen15)
            f.logTextButton:SetNormalFontObject(_G.BGA.FontGreen15)
            tinsert(f.logs, { money = money, player = "|cff" .. aura_env.GREEN1 .. L["你"] .. "|r" })
        else
            if f.mod == "anonymous" then
                f.topMoneyText:SetText(L["|cffFFD100出价最高者：|r"] .. L["別人(匿名)"])
                tinsert(f.logs, { money = money, player = L["匿名"] })
            else
                f.topMoneyText:SetText(L["|cffFFD100出价最高者：|r"] .. f.colorplayer)
                tinsert(f.logs, { money = money, player = f.colorplayer })
            end
            if f.filter then
                f:SetBackdropColor(unpack(aura_env.backdropColor_filter))
                f:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor_filter))
                f.autoFrame:SetBackdropColor(unpack(aura_env.backdropColor_filter))
                f.autoFrame:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor_filter))
                f.hide:SetNormalFontObject(_G.BGA.FontDis15)
                f.cancel:SetNormalFontObject(_G.BGA.FontDis15)
                f.autoTextButton:SetNormalFontObject(_G.BGA.FontDis15)
                f.logTextButton:SetNormalFontObject(_G.BGA.FontDis15)
            else
                f:SetBackdropColor(unpack(aura_env.backdropColor))
                f:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor))
                f.autoFrame:SetBackdropColor(unpack(aura_env.backdropColor))
                f.autoFrame:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor))
                f.hide:SetNormalFontObject(_G.BGA.FontGreen15)
                f.cancel:SetNormalFontObject(_G.BGA.FontGreen15)
                f.autoTextButton:SetNormalFontObject(_G.BGA.FontGreen15)
                f.logTextButton:SetNormalFontObject(_G.BGA.FontGreen15)
            end
            C_Timer.After(.5, function()
                aura_env.AutoSendMyMoney(f)
            end)
        end
        aura_env.myMoney_OnTextChanged(f.myMoneyEdit)
        aura_env.UpdateAllOnEnters()

        if f.isAuto and f.money >= f.autoMoney then
            f.autoTitleText:SetText(L["设置心理价格"])
            f.autoTitleText:SetTextColor(1, .82, 0)
            f.isAutoTex:Hide()
            f.autoButton:SetText(L["开启自动出价"])
            f.autoButton:Enable()
            f.autoMoneyEdit.Left:SetAlpha(1)
            f.autoMoneyEdit.Right:SetAlpha(1)
            f.autoMoneyEdit.Middle:SetAlpha(1)
            f.isAuto = false
            f.autoTextButton:SetText(L["自动出价"])
            f.autoTextButton:SetWidth(f.autoTextButton:GetFontString():GetWidth())
            f.autoMoneyEdit:SetTextColor(1, 1, 1)
            f.autoMoneyEdit:SetEnabled(true)
            f.autoMoneyEdit.isLocked = false
        end

        aura_env.UpdateAutoButton(f)

        if (f.remaining or 0) <= aura_env.REPEAT_TIME then
            aura_env.Auctioning(f, aura_env.REPEAT_TIME)
        end
    end

    function aura_env.SendMyMoney_OnEnter(self)
        local f = self.owner
        GameTooltip:SetOwner(self.owner, "ANCHOR_BOTTOM", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self.text, 1, 0, 0, true)
        GameTooltip:Show()
    end

    function aura_env.UpdateAllOnEnters()
        for i, f in ipairs(_G.BGA.Frames) do
            if f.currentMoneyText.isOnEnter then
                aura_env.currentMoney_OnEnter(f.currentMoneyText)
            end
            if f.myMoneyEdit.isOnEnter then
                aura_env.myMoney_OnEnter(f.myMoneyEdit)
            end
            if f.ButtonJian.isOnEnter then
                aura_env.JiaJian_OnEnter(f.ButtonJian)
            end
            if f.ButtonJia.isOnEnter then
                aura_env.JiaJian_OnEnter(f.ButtonJia)
            end
            if f.logTextButton.isOnEnter then
                f.logTextButton:GetScript("OnEnter")(f.logTextButton)
            end
        end
    end

    function aura_env.UpdateAllFrames()
        for i, f in ipairs(_G.BGA.Frames) do
            if not f.notShowCantClickFrame then
                f.cantClickFrame:Show()
                f.cantClickFrame.t = 0
                f.cantClickFrame:SetScript("OnUpdate", function(self, elapsed)
                    self.t = self.t + elapsed
                    if self.t >= .8 then
                        self:SetScript("OnUpdate", nil)
                        self:Hide()
                    end
                end)
            end

            f:ClearAllPoints()
            if i == 1 then
                f:SetPoint("TOPLEFT", _G.BGA.AuctionMainFrame, "TOPLEFT", 0, 0)
            else
                f:SetPoint("TOPLEFT", _G.BGA.Frames[i - 1], "BOTTOMLEFT", 0, -5)
            end
        end
    end

    function aura_env.UpdateFrame(f)
        local t = 1
        f:SetScript("OnUpdate", function(self, elapsed)
            t = t - elapsed
            if t >= 0 then
                if not f.IsAlpha then
                    f:SetAlpha(t)
                end
            else
                for i, _f in ipairs(_G.BGA.Frames) do
                    if i < f.num then
                        _f.notShowCantClickFrame = true
                    else
                        _f.notShowCantClickFrame = false
                    end
                end
                f:SetScript("OnUpdate", nil)
                tremove(_G.BGA.Frames, f.num)
                f:Hide()
                _G.BGA.AuctionMainFrame:StopMovingOrSizing()
                for i, f in ipairs(_G.BGA.Frames) do
                    f.num = i
                end
                aura_env.UpdateAllFrames()
            end
        end)
    end

    function aura_env.anim(parent)
        parent.alltime = 0.5
        parent.t = 0.5
        parent:SetScale(3)
        parent:SetScript("OnUpdate", function(self, t)
            self.t = self.t - t
            if self.t <= 0 then self.t = 0 end
            self:SetScale(1 + self.t / self.alltime)
            if self.t <= 0 then
                self:SetScript("OnUpdate", nil)
            end
        end)
    end

    function aura_env.OnEditFocusGained(self)
        aura_env.lastFocus = self
        self:HighlightText()
    end

    -- 自动出价函数
    do
        function aura_env.AutoText_OnClick(self)
            self.owner.autoFrame:SetShown(not self.owner.autoFrame:IsVisible())
            self.owner.autoFrame.isClicked = true
            PlaySound(aura_env.sound1)
        end

        function aura_env.Auto_OnTextChanged(self)
            local f = self.owner
            local money = tonumber(self:GetText()) or 0
            f.autoMoney = money
            aura_env.UpdateAutoButton(self)
        end

        function aura_env.AutoEdit_OnEnter(self)
            local f = self.owner
            GameTooltip:SetOwner(f.autoFrame, "ANCHOR_BOTTOM", 0, 0)
            GameTooltip:ClearLines()
            if self.isLocked then
                GameTooltip:AddLine(L["心理价格锁定中"], 1, 0, 0, true)
                GameTooltip:AddLine(L["取消自动出价后才能修改。"], 1, 0.82, 0, true)
            else
                GameTooltip:AddLine(L["自动出价"], 1, 1, 1, true)
                GameTooltip:AddLine(L["如果别人出价比你高时，自动帮你出价，每次加价为最低幅度，出价不会高于你设定的心理价格。"], 1, 0.82, 0, true)
            end
            GameTooltip:Show()
        end

        function aura_env.UpdateAutoButton(self)
            local f = self.owner or self
            f.autoButton:Enable()
            f.autoButton.disf:Hide()
            if f.autoMoney == 0 then
                f.autoButton:Disable()
                f.autoButton.disf:Hide()
            elseif f.start then
                if f.autoMoney < f.money then
                    f.autoButton.onEnterText = L["心理价格需高于或等于起拍价"]
                    f.autoButton:Disable()
                    f.autoButton.disf:Show()
                end
            elseif f.autoMoney <= f.money then
                f.autoButton.onEnterText = L["心理价格需高于当前价格"]
                f.autoButton:Disable()
                f.autoButton.disf:Show()
            end
        end

        function aura_env.AutoButton_OnClick(self)
            local f = self.owner
            if f.isAuto then
                f.autoTitleText:SetText(L["设置心理价格"])
                f.autoTitleText:SetTextColor(1, .82, 0)
                f.isAutoTex:Hide()
                f.autoButton:SetText(L["开启自动出价"])
                f.autoMoneyEdit.Left:SetAlpha(1)
                f.autoMoneyEdit.Right:SetAlpha(1)
                f.autoMoneyEdit.Middle:SetAlpha(1)
                f.isAuto = false
                f.autoTextButton:SetText(L["自动出价"])
                f.autoTextButton:SetWidth(f.autoTextButton:GetFontString():GetWidth())
                f.autoMoneyEdit:SetTextColor(1, 1, 1)
                f.autoMoneyEdit:SetEnabled(true)
                f.autoMoneyEdit.isLocked = false
            else
                f.autoTitleText:SetText(L["心理价格"])
                f.autoTitleText:SetTextColor(0, 1, 0)
                f.isAutoTex:Show()
                f.autoButton:SetText(L["取消自动出价"])
                f.autoMoneyEdit:ClearFocus()
                f.autoMoneyEdit.Left:SetAlpha(f.autoMoneyEdit.alpha)
                f.autoMoneyEdit.Right:SetAlpha(f.autoMoneyEdit.alpha)
                f.autoMoneyEdit.Middle:SetAlpha(f.autoMoneyEdit.alpha)
                f.isAuto = true
                f.autoTextButton:SetText(L[">>正在自动出价<<"])
                f.autoTextButton:SetWidth(f.autoTextButton:GetFontString():GetWidth())
                f.autoMoneyEdit:SetTextColor(0, 1, 0)
                f.autoMoneyEdit:SetEnabled(false)
                f.autoMoneyEdit.isLocked = true
                aura_env.AutoSendMyMoney(f)
            end
            PlaySound(aura_env.sound1)
        end

        function aura_env.AutoButton_OnEnter(self)
            local f = self.owner
            GameTooltip:SetOwner(f.autoFrame, "ANCHOR_BOTTOM", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(f.autoButton.onEnterText, 1, 0, 0, true)
            GameTooltip:Show()
        end

        function aura_env.AutoSendMyMoney(f)
            if not f.isAuto then return end
            if f.player and f.player == UnitName("player") then return end

            local newmoney
            if f.start then
                newmoney = f.money
            else
                newmoney = aura_env.Addmoney(f.money, "+")
                if newmoney > f.autoMoney and f.money < f.autoMoney then
                    newmoney = f.autoMoney
                end
            end

            if newmoney <= f.autoMoney then
                C_ChatInfo.SendAddonMessage(aura_env.AddonChannel, "SendMyMoney" .. "," ..
                    f.auctionID .. "," .. newmoney, "RAID")
            end
        end
    end

    function aura_env.CreateAuction(auctionID, itemID, money, duration, player, mod, notAfter)
        for i, f in ipairs(_G.BGA.Frames) do
            if f.auctionID == auctionID then
                return
            end
        end

        local name, link, quality, level, _, itemType, itemSubType, _, itemEquipLoc, Texture, _, classID, subclassID, bindType = GetItemInfo(itemID)
        if not link then
            if not notAfter then
                C_Timer.After(0.5, function()
                    aura_env.CreateAuction(auctionID, itemID, money, duration - 0.5, player, mod, true)
                end)
            end
            return
        end
        local AuctionFrame

        -- 主界面
        do
            local f = CreateFrame("Frame", nil, _G.BGA.AuctionMainFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = aura_env.edgeSize,
            })
            f:SetBackdropColor(unpack(aura_env.backdropColor))
            f:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor))
            f:SetSize(aura_env.WIDTH, 105)
            if #_G.BGA.Frames == 0 then
                f:SetPoint("TOP", 0, 0)
            else
                f:SetPoint("TOP", _G.BGA.Frames[#_G.BGA.Frames], "BOTTOM", 0, -5)
            end
            f:EnableMouse(true)
            f.auctionID = auctionID
            f.itemID = itemID
            f.link = link
            f.mod = mod
            f.num = #_G.BGA.Frames + 1
            f.logs = {}
            AuctionFrame = f
            tinsert(_G.BGA.Frames, f)
            f:SetScript("OnMouseUp", function(self)
                local mainFrame = _G.BGA.AuctionMainFrame
                mainFrame:StopMovingOrSizing()
                if _G.BiaoGe and _G.BiaoGe.point then
                    _G.BiaoGe.point.Auction = { mainFrame:GetPoint(1) }
                end
                mainFrame:SetScript("OnUpdate", nil)
            end)

            f:SetScript("OnMouseDown", function(self)
                local mainFrame = _G.BGA.AuctionMainFrame
                mainFrame:StartMoving()
                if aura_env.lastFocus then
                    aura_env.lastFocus:ClearFocus()
                end
                mainFrame.time = 0
                mainFrame:SetScript("OnUpdate", function(self, time)
                    mainFrame.time = mainFrame.time + time
                    if mainFrame.time >= 0.2 then
                        mainFrame.time = 0
                        for _, f in ipairs(_G.BGA.Frames) do
                            if f.itemFrame.isOnEnter then
                                GameTooltip:Hide()
                                f.itemFrame:GetScript("OnEnter")(f.itemFrame)
                            end
                            if f.autoFrame:IsVisible() then
                                f.autoFrame:GetScript("OnShow")(f.autoFrame)
                            end
                        end
                    end
                end)
            end)

            f.cantClickFrame = CreateFrame("Frame", nil, f, "BackdropTemplate")
            f.cantClickFrame:SetAllPoints()
            f.cantClickFrame:SetFrameLevel(200)
            f.cantClickFrame:EnableMouse(true)
            C_Timer.After(.6, function()
                f.cantClickFrame:Hide()
            end)

            f.updateFrame = CreateFrame("Frame", nil, f, "BackdropTemplate")
            f.updateFrame:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
            })
            f.updateFrame:SetBackdropColor(1, 1, 1, .4)
            f.updateFrame:SetAllPoints()
            f.updateFrame:SetFrameLevel(150)
            f.updateFrame.alpha = .5
            f.updateFrame.totalTime = .4
            f.updateFrame:Hide()
            f.updateFrame:SetScript("OnShow", function(self)
                self.time = 0
                self:SetScript("OnUpdate", function(self, time)
                    self.time = self.time + time
                    local alpha = self.alpha - self.time / self.totalTime * self.alpha
                    if alpha < 0 then alpha = 0 end
                    self:SetAlpha(alpha)
                    f.autoFrame.updateFrame:SetAlpha(alpha)
                    if self:GetAlpha() <= 0 then
                        self:SetScript("OnUpdate", nil)
                        self:Hide()
                        f.autoFrame.updateFrame:Hide()
                    end
                end)
            end)
        end
        -- 自动出价
        do
            local f = CreateFrame("Frame", nil, AuctionFrame, "BackdropTemplate")
            do
                f:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = aura_env.edgeSize,
                })
                f:SetBackdropColor(unpack(aura_env.backdropColor))
                f:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor))
                f:SetSize(120, 73)
                f:EnableMouse(true)
                f:Hide()
                f.owner = AuctionFrame
                AuctionFrame.autoFrame = f
                f:SetScript("OnShow", function(self)
                    f:ClearAllPoints()
                    if aura_env.IsRight(self) then
                        f:SetPoint("BOTTOMRIGHT", AuctionFrame, "BOTTOMLEFT", 2, 0)
                    else
                        f:SetPoint("BOTTOMLEFT", AuctionFrame, "BOTTOMRIGHT", -2, 0)
                    end
                end)
                f:SetScript("OnMouseUp", function(self)
                    AuctionFrame:GetScript("OnMouseUp")(_G.BGA.AuctionMainFrame)
                end)
                f:SetScript("OnMouseDown", function(self)
                    AuctionFrame:GetScript("OnMouseDown")(_G.BGA.AuctionMainFrame)
                end)

                AuctionFrame.cantClickFrame.autoFrame = CreateFrame("Frame", nil, AuctionFrame.cantClickFrame, "BackdropTemplate")
                AuctionFrame.cantClickFrame.autoFrame:SetPoint("TOPLEFT", f, 0, 0)
                AuctionFrame.cantClickFrame.autoFrame:SetPoint("BOTTOMRIGHT", f, 0, 0)
                AuctionFrame.cantClickFrame.autoFrame:EnableMouse(true)
                C_Timer.After(.6, function()
                    AuctionFrame.cantClickFrame.autoFrame:Hide()
                end)

                f.updateFrame = CreateFrame("Frame", nil, f, "BackdropTemplate")
                f.updateFrame:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                })
                f.updateFrame:SetBackdropColor(1, 1, 1, .3)
                f.updateFrame:SetAllPoints()
                f.updateFrame:SetFrameLevel(150)
                f.updateFrame:Hide()
            end

            local t = f:CreateFontString()
            do
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                t:SetPoint("TOP", 0, -8)
                t:SetTextColor(1, 0.82, 0)
                t:SetText(L["设置心理价格"])
                AuctionFrame.autoTitleText = t
            end

            local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            do
                edit:SetSize(f:GetWidth() - 30, 20)
                edit:SetPoint("BOTTOM", 2, 27)
                edit:SetAutoFocus(false)
                edit:SetNumeric(true)
                edit.owner = AuctionFrame
                edit.alpha = .3
                AuctionFrame.autoMoney = 0
                AuctionFrame.autoMoneyEdit = edit
                edit:SetScript("OnTextChanged", aura_env.Auto_OnTextChanged)
                edit:SetScript("OnEnterPressed", aura_env.AutoButton_OnClick)
                edit:SetScript("OnEnter", aura_env.AutoEdit_OnEnter)
                edit:SetScript("OnLeave", GameTooltip_Hide)
                edit:SetScript("OnEditFocusGained", aura_env.OnEditFocusGained)

                local f = CreateFrame("Frame", nil, edit)
                f:SetPoint("RIGHT", 12, 2)
                f:SetSize(25, 25)
                f:Hide()
                AuctionFrame.isAutoTex = f
                local tex = f:CreateTexture()
                tex:SetAllPoints()
                tex:SetTexture("interface/raidframe/readycheck-ready")
                tex:SetAlpha(1)
            end

            local bt = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
            do
                bt:SetPoint("BOTTOM", 0, 5)
                bt:SetSize(f:GetWidth() - 20, 22)
                bt:SetText(L["开启自动出价"])
                bt:Disable()
                bt.owner = AuctionFrame
                AuctionFrame.autoButton = bt
                bt:SetScript("OnClick", aura_env.AutoButton_OnClick)

                local disf = CreateFrame("Frame", nil, AuctionFrame.autoButton)
                disf:SetAllPoints()
                disf:Hide()
                disf.dis = true
                disf.owner = AuctionFrame
                disf:SetScript("OnEnter", aura_env.AutoButton_OnEnter)
                disf:SetScript("OnLeave", GameTooltip_Hide)
                AuctionFrame.autoButton.disf = disf
            end

            local f = CreateFrame("Frame", nil, AuctionFrame.autoFrame)
            do
                f:SetAllPoints()
                f:SetFrameLevel(f:GetParent():GetFrameLevel() + 50)
                f:EnableMouse(true)
                f:Hide()
                f.owner = AuctionFrame
                f:SetScript("OnMouseUp", function(self)
                    AuctionFrame:GetScript("OnMouseUp")(_G.BGA.AuctionMainFrame)
                end)
                f:SetScript("OnMouseDown", function(self)
                    AuctionFrame:GetScript("OnMouseDown")(_G.BGA.AuctionMainFrame)
                end)
                AuctionFrame.AlphaFrame2 = f
            end
        end
        -- 操作
        do
            -- Pass
            local bt = CreateFrame("Button", nil, AuctionFrame)
            bt:SetNormalFontObject(_G.BGA.FontGreen15)
            bt:SetHighlightFontObject(_G.BGA.FontWhite15)
            bt:SetPoint("TOPRIGHT", -aura_env.edgeSize - 1, -2)
            bt:SetText(L["隐藏"])
            bt:SetSize(bt:GetFontString():GetWidth(), 18)
            bt.owner = AuctionFrame
            bt:SetScript("OnClick", aura_env.Pass_OnClick)
            AuctionFrame.hide = bt

            local f = CreateFrame("Frame", nil, AuctionFrame)
            f:SetPoint("TOPLEFT", AuctionFrame, "TOPLEFT", 0, -20)
            f:SetPoint("BOTTOMRIGHT", AuctionFrame, "BOTTOMRIGHT", 0, 0)
            f:SetFrameLevel(AuctionFrame:GetFrameLevel() + 50)
            f:EnableMouse(true)
            f:Hide()
            f.owner = AuctionFrame
            f:SetScript("OnMouseUp", function(self)
                AuctionFrame:GetScript("OnMouseUp")(_G.BGA.AuctionMainFrame)
            end)
            f:SetScript("OnMouseDown", function(self)
                AuctionFrame:GetScript("OnMouseDown")(_G.BGA.AuctionMainFrame)
            end)
            AuctionFrame.AlphaFrame = f

            -- 取消拍卖
            local bt = CreateFrame("Button", nil, AuctionFrame)
            bt:SetNormalFontObject(_G.BGA.FontGreen15)
            bt:SetHighlightFontObject(_G.BGA.FontWhite15)
            bt:SetPoint("TOPLEFT", aura_env.edgeSize + 60, -2)
            bt:SetText(L["取消拍卖"])
            bt:SetSize(bt:GetFontString():GetWidth(), 18)
            bt:RegisterForClicks("AnyUp")
            bt.owner = AuctionFrame
            bt:SetScript("OnClick", aura_env.Cancel_OnClick)
            bt:SetScript("OnEnter", aura_env.Cancel_OnEnter)
            bt:SetScript("OnLeave", GameTooltip_Hide)
            AuctionFrame.cancel = bt
            if aura_env.IsML() then
                bt:Show()
            else
                bt:Hide()
            end

            -- 自动出价
            local bt = CreateFrame("Button", nil, AuctionFrame)
            bt:SetNormalFontObject(_G.BGA.FontGreen15)
            bt:SetHighlightFontObject(_G.BGA.FontWhite15)
            bt:SetText(L["自动出价"])
            bt:SetSize(bt:GetFontString():GetWidth(), 18)
            bt:RegisterForClicks("AnyUp")
            bt.owner = AuctionFrame
            AuctionFrame.autoTextButton = bt
            bt:SetScript("OnClick", aura_env.AutoText_OnClick)
            if aura_env.IsML() then
                bt:SetPoint("TOP", 45, -2)
            else
                bt:SetPoint("TOP", 0, -2)
            end

            -- 记录
            local bt = CreateFrame("Button", nil, AuctionFrame)
            bt:SetNormalFontObject(_G.BGA.FontGreen15)
            bt:SetHighlightFontObject(_G.BGA.FontWhite15)
            bt:SetPoint("TOPLEFT", aura_env.edgeSize + 1, -2)
            bt:SetText(L["记录"])
            bt:SetSize(bt:GetFontString():GetWidth(), 18)
            bt.owner = AuctionFrame
            AuctionFrame.logTextButton = bt
            bt:SetScript("OnEnter", aura_env.LogTextButton_OnEnter)
            bt:SetScript("OnLeave", aura_env.LogTextButton_OnLeave)
        end
        -- 装备显示
        do
            local f = CreateFrame("Frame", nil, AuctionFrame, "BackdropTemplate")
            f:SetPoint("TOPLEFT", f:GetParent(), "TOPLEFT", aura_env.edgeSize + 1, -AuctionFrame.hide:GetHeight() - 3)
            f:SetPoint("BOTTOMRIGHT", f:GetParent(), "TOPRIGHT", -aura_env.edgeSize, -55)
            f:SetFrameLevel(f:GetParent():GetFrameLevel() + 10)
            f.owner = AuctionFrame
            f.itemID = itemID
            f.link = link
            f:SetScript("OnEnter", aura_env.itemOnEnter)
            f:SetScript("OnLeave", aura_env.itemOnLeave)
            f:SetScript("OnMouseUp", function(self)
                AuctionFrame:GetScript("OnMouseUp")(_G.BGA.AuctionMainFrame)
            end)
            f:SetScript("OnMouseDown", function(self)
                if IsShiftKeyDown() then
                    if not GetCurrentKeyBoardFocus() then
                        ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    end
                    ChatEdit_InsertLink(link)
                elseif IsControlKeyDown() then
                    DressUpItemLink(link)
                else
                    AuctionFrame:GetScript("OnMouseDown")(_G.BGA.AuctionMainFrame)
                end
            end)
            AuctionFrame.itemFrame = f
            -- 黑色背景
            local s = CreateFrame("StatusBar", nil, f)
            s:SetAllPoints()
            s:SetFrameLevel(s:GetParent():GetFrameLevel() - 5)
            s:SetStatusBarTexture("Interface/ChatFrame/ChatFrameBackground")
            s:SetStatusBarColor(0, 0, 0, 0.5)
            -- 图标
            local r, g, b = GetItemQualityColor(quality)
            local ftex = CreateFrame("Frame", nil, f, "BackdropTemplate")
            ftex:SetBackdrop({
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 2,
            })
            ftex:SetBackdropBorderColor(r, g, b, 1)
            ftex:SetPoint("TOPLEFT", 0, 0)
            ftex:SetSize(f:GetHeight(), f:GetHeight())
            ftex.tex = ftex:CreateTexture(nil, "BACKGROUND")
            ftex.tex:SetAllPoints()
            ftex.tex:SetTexture(Texture)
            ftex.tex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
            AuctionFrame.itemFrame.iconFrame = ftex
            -- 装备等级
            local t = ftex:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            t:SetPoint("BOTTOM", ftex, "BOTTOM", 0, 1)
            t:SetText(level)
            t:SetTextColor(r, g, b)
            -- 装绑
            if bindType == 2 then
                local t = ftex:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
                t:SetPoint("TOP", ftex, 0, -2)
                t:SetText(L["装绑"])
                t:SetTextColor(0, 1, 0)
            end
            -- 装备名称
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOPLEFT", ftex, "TOPRIGHT", 2, -2)
            t:SetWidth(f:GetWidth() - f:GetHeight() - 50)
            t:SetText(link:gsub("%[", ""):gsub("%]", ""))
            t:SetJustifyH("LEFT")
            t:SetWordWrap(false)
            AuctionFrame.itemFrame.itemNameText = t
            -- 已有
            if BG and BG.GetItemCount and BG.GetItemCount(itemID) ~= 0 or GetItemCount(itemID, true) ~= 0 then
                local tex = f:CreateTexture(nil, 'ARTWORK')
                tex:SetSize(15, 15)
                tex:SetPoint('LEFT', t, 'LEFT', t:GetWrappedWidth(), 0)
                tex:SetTexture("interface/raidframe/readycheck-ready")
            end
            -- 装备类型
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            t:SetPoint("BOTTOMLEFT", ftex, "BOTTOMRIGHT", 2, 2)
            t:SetHeight(13)
            if _G[itemEquipLoc] then
                if classID == 2 then
                    t:SetText(itemSubType)
                else
                    t:SetText(_G[itemEquipLoc] .. " " .. itemSubType)
                end
            else
                t:SetText("")
            end
            t:SetJustifyH("LEFT")
            AuctionFrame.itemFrame.itemTypeText = t

            -- 倒计时条
            local s = CreateFrame("StatusBar", nil, f)
            s:SetPoint("TOPLEFT", ftex, "TOPRIGHT", 0, 0)
            s:SetSize(f:GetWidth() - f:GetHeight(), f:GetHeight())
            s:SetFrameLevel(s:GetParent():GetFrameLevel() - 2)
            s:SetStatusBarTexture("Interface/ChatFrame/ChatFrameBackground")
            s:SetStatusBarColor(1, 1, 0, 0.6)
            s:SetMinMaxValues(0, 1000)
            s.owner = AuctionFrame
            AuctionFrame.bar = s

            -- 剩余时间
            local remainingTime = f:CreateFontString()
            remainingTime:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            remainingTime:SetPoint("RIGHT", -5, 0)
            remainingTime:SetTextColor(1, 1, 1)
            AuctionFrame.remainingTime = remainingTime
        end
        -- 价格
        do
            local textwidth = 190
            local buttonwidth = 25
            local height = 22
            -- 当前价格
            local f = CreateFrame("Frame", nil, AuctionFrame)
            f:SetSize(textwidth, 20)
            f:SetPoint("TOPLEFT", AuctionFrame.itemFrame, "BOTTOMLEFT", 3, -3)
            f:SetScript("OnMouseDown", aura_env.currentMoney_OnMouseDown)
            f:SetScript("OnMouseUp", aura_env.currentMoney_OnMouseUp)
            f:SetScript("OnEnter", aura_env.currentMoney_OnEnter)
            f:SetScript("OnLeave", aura_env.OnLeave)
            f.owner = AuctionFrame
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
            t:SetAllPoints()
            t:SetJustifyH("LEFT")
            if player and player ~= "" then
                t:SetText(L["|cffFFD100当前价格：|r"] .. money)
                AuctionFrame.start = false
            else
                t:SetText(L["|cffFFD100起拍价：|r"] .. money)
                AuctionFrame.start = true
            end
            local currentMoneyText = f
            AuctionFrame.currentMoneyText = t
            AuctionFrame.money = money
            -- 出价最高者
            local f = CreateFrame("Frame", nil, currentMoneyText)
            f:SetSize(textwidth, height)
            f:SetPoint("TOPLEFT", currentMoneyText, "BOTTOMLEFT", 0, 0)
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
            t:SetAllPoints()
            t:SetJustifyH("LEFT")
            if player then
                AuctionFrame.player = player
                AuctionFrame.colorplayer = aura_env.SetClassCFF(player)
            end
            if player and player ~= "" then
                if player == UnitName("player") then
                    t:SetText(L["|cffFFD100出价最高者：|r"] .. "|cff" .. aura_env.GREEN1 .. L[">> 你 <<"])
                    AuctionFrame:SetBackdropColor(unpack(aura_env.backdropColor_IsMe))
                    AuctionFrame:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor_IsMe))
                    AuctionFrame.autoFrame:SetBackdropColor(unpack(aura_env.backdropColor_IsMe))
                    AuctionFrame.autoFrame:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor_IsMe))
                else
                    if mod == "anonymous" then
                        t:SetText(L["|cffFFD100出价最高者：|r"] .. L["別人(匿名)"])
                    else
                        t:SetText(L["|cffFFD100出价最高者：|r"] .. AuctionFrame.colorplayer)
                    end
                    AuctionFrame:SetBackdropColor(unpack(aura_env.backdropColor))
                    AuctionFrame:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor))
                    AuctionFrame.autoFrame:SetBackdropColor(unpack(aura_env.backdropColor))
                    AuctionFrame.autoFrame:SetBackdropBorderColor(unpack(aura_env.backdropBorderColor))
                end
            elseif mod == "anonymous" then
                t:SetText(L["|cffFFD100< 匿名模式 >|r"])
            end
            AuctionFrame.topMoneyText = t

            -- 输入框
            local edit = CreateFrame("EditBox", nil, currentMoneyText, "InputBoxTemplate")
            edit:SetSize(AuctionFrame:GetRight() - currentMoneyText:GetRight() - 3, 20)
            edit:SetPoint("TOPLEFT", currentMoneyText, "TOPRIGHT", 0, 0)
            edit:SetText(money)
            edit:SetAutoFocus(false)
            edit:SetNumeric(true)
            edit.owner = AuctionFrame
            edit:SetScript("OnTextChanged", aura_env.myMoney_OnTextChanged)
            edit:SetScript("OnEnterPressed", aura_env.SendMyMoney_OnClick)
            edit:SetScript("OnMouseWheel", aura_env.myMoney_OnMouseWheel)
            edit:SetScript("OnEnter", aura_env.myMoney_OnEnter)
            edit:SetScript("OnLeave", aura_env.OnLeave)
            edit:SetScript("OnEditFocusGained", aura_env.OnEditFocusGained)
            AuctionFrame.myMoneyEdit = edit
            -- 减
            local bt = CreateFrame("Button", nil, edit, "UIPanelButtonTemplate")
            bt:SetSize(buttonwidth, 22)
            bt:SetPoint("TOPLEFT", edit, "BOTTOMLEFT", -5, 0)
            bt:SetNormalFontObject(_G.BGA.FontGold18)
            bt:SetDisabledFontObject(_G.BGA.FontDis18)
            bt.owner = AuctionFrame
            bt.edit = edit
            bt._type = "-"
            bt:SetText(bt._type)
            bt:SetScript("OnMouseDown", aura_env.JiaJian_OnMouseDown)
            bt:SetScript("OnMouseUp", aura_env.JiaJian_OnMouseUp)
            bt:SetScript("OnClick", aura_env.JiaJian_OnClick)
            bt:SetScript("OnEnter", aura_env.JiaJian_OnEnter)
            bt:SetScript("OnLeave", aura_env.OnLeave)
            AuctionFrame.ButtonJian = bt
            -- 加
            local bt = CreateFrame("Button", nil, edit, "UIPanelButtonTemplate")
            bt:SetSize(buttonwidth, 22)
            bt:SetPoint("LEFT", AuctionFrame.ButtonJian, "RIGHT", 0, 0)
            bt:SetNormalFontObject(_G.BGA.FontGold18)
            bt:SetDisabledFontObject(_G.BGA.FontDis18)
            bt.owner = AuctionFrame
            bt.edit = edit
            bt._type = "+"
            bt:SetText(bt._type)
            bt:SetScript("OnMouseDown", aura_env.JiaJian_OnMouseDown)
            bt:SetScript("OnMouseUp", aura_env.JiaJian_OnMouseUp)
            bt:SetScript("OnClick", aura_env.JiaJian_OnClick)
            bt:SetScript("OnEnter", aura_env.JiaJian_OnEnter)
            bt:SetScript("OnLeave", aura_env.OnLeave)
            AuctionFrame.ButtonJia = bt
            -- 出价
            local bt = CreateFrame("Button", nil, edit, "UIPanelButtonTemplate")
            bt:SetPoint("TOPLEFT", AuctionFrame.ButtonJia, "TOPRIGHT", 0, 0)
            bt:SetPoint("BOTTOMRIGHT", edit, "BOTTOMRIGHT", 0, -height)
            bt:SetText(L["出价"])
            bt.owner = AuctionFrame
            bt.edit = edit
            bt.itemID = itemID
            AuctionFrame.ButtonSendMyMoney = bt
            bt:SetScript("OnClick", aura_env.SendMyMoney_OnClick)

            local f = CreateFrame("Frame", nil, bt)
            f:SetAllPoints()
            f:Hide()
            f.dis = true
            f.owner = AuctionFrame
            f:SetScript("OnEnter", aura_env.SendMyMoney_OnEnter)
            f:SetScript("OnLeave", GameTooltip_Hide)
            AuctionFrame.disf = f
            bt.disf = f

            aura_env.myMoney_OnTextChanged(AuctionFrame.myMoneyEdit)
        end

        aura_env.anim(AuctionFrame)
        aura_env.Auctioning(AuctionFrame, duration)

        if BG and BG.HookCreateAuction then
            BG.HookCreateAuction(AuctionFrame)
        end
    end

    aura_env.UpdateRaidRosterInfo()
    aura_env.GetAuctioningFromRaid()

    -- 主界面
    do
        local f = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
        f:SetSize(aura_env.WIDTH, 100)
        f:SetFrameStrata('HIGH')
        f:SetClampedToScreen(true)
        f:SetFrameLevel(100)
        f:SetToplevel(true)
        f:SetMovable(true)
        f:SetScale(BiaoGe and BiaoGe.options and BiaoGe.options["autoAuctionScale"] or 0.95)
        _G.BGA.AuctionMainFrame = f

        if _G.BiaoGe and _G.BiaoGe.point and _G.BiaoGe.point.Auction then
            _G.BiaoGe.point.Auction[2] = nil
            f:SetPoint(unpack(_G.BiaoGe.point.Auction))
        else
            f:SetPoint("TOPRIGHT", -100, -200)
        end
    end

    _G.BGA.Even = CreateFrame("Frame")
    _G.BGA.Even:RegisterEvent("CHAT_MSG_ADDON")
    _G.BGA.Even:RegisterEvent("GROUP_ROSTER_UPDATE")
    _G.BGA.Even:RegisterEvent("PLAYER_ENTERING_WORLD")
    _G.BGA.Even:RegisterEvent("MODIFIER_STATE_CHANGED")
    _G.BGA.Even:SetScript("OnEvent", function(self, even, ...)
        if even == "CHAT_MSG_ADDON" then
            local prefix, msg, distType, senderFullName = ...
            if prefix ~= aura_env.AddonChannel then return end
            local arg1, arg2, arg3, arg4, arg5, arg6, arg7 = strsplit(",", msg)
            local sender, realm = strsplit("-", senderFullName)
            -- print(sender, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
            if arg1 == "SendMyMoney" and distType == "RAID" then
                local auctionID = tonumber(arg2)
                local money = tonumber(arg3)
                for i, f in ipairs(_G.BGA.Frames) do
                    if not f.IsEnd and f.auctionID == auctionID then
                        if f.start then
                            if money >= f.money then
                                aura_env.SetMoney(f, money, sender)
                                return
                            end
                        elseif money > f.money then
                            aura_env.SetMoney(f, money, sender)
                            return
                        end
                    end
                end
            elseif arg1 == "StartAuction" and distType == "RAID" then
                local auctionID = tonumber(arg2)
                local itemID = tonumber(arg3)
                local money = tonumber(arg4)
                local duration = tonumber(arg5)
                local player = arg6
                local mod = arg7
                aura_env.CreateAuction(auctionID, itemID, money, duration, player, mod)

                if aura_env.IsRaidLeader() then
                    local tbl = {
                        normal = L["正常模式"],
                        anonymous = L["匿名模式"],
                    }

                    local _, link = GetItemInfo(itemID)
                    if link then
                        SendChatMessage(format(L["{rt1}拍卖开始{rt1} %s 起拍价：%s 拍卖时长：%ss %s"],
                            link, money, duration, (tbl[mod] and "<" .. tbl[mod] .. ">" or "")), "RAID_WARNING")
                    else
                        C_Timer.After(0.5, function()
                            local _, link = GetItemInfo(itemID)
                            if link then
                                SendChatMessage(format(L["{rt1}拍卖开始{rt1} %s 起拍价：%s 拍卖时长：%ss %s"],
                                    link, money, duration, (tbl[mod] and "<" .. tbl[mod] .. ">" or "")), "RAID_WARNING")
                            end
                        end)
                    end
                end
            elseif arg1 == "CancelAuction" and distType == "RAID" then
                local auctionID = tonumber(arg2)
                for i, f in ipairs(_G.BGA.Frames) do
                    if f.auctionID == auctionID and not f.IsEnd then
                        local t = f:CreateFontString()
                        t:SetFont(STANDARD_TEXT_FONT, 30, "OUTLINE")
                        t:SetPoint("TOPRIGHT", f.itemFrame, "BOTTOMRIGHT", -10, -5)
                        t:SetText(L["拍卖取消"])
                        t:SetTextColor(1, 0, 0)

                        f.remainingTime:Hide()
                        f.bar:Hide()
                        f.IsEnd = true
                        f.myMoneyEdit:Hide()
                        f.cancel:Hide()

                        if aura_env.IsRaidLeader() then
                            SendChatMessage(format(L["{rt7}拍卖取消{rt7} %s"], f.link), "RAID")
                        end

                        C_Timer.After(aura_env.HIDEFRAME_TIME, function()
                            aura_env.UpdateFrame(f)
                        end)
                        return
                    end
                end
            elseif arg1 == "GetAuctioning" and distType == "RAID" and sender ~= UnitName("player") then
                for i, f in ipairs(_G.BGA.Frames) do
                    if (not f.IsEnd) and f.remaining and f.remaining >= 2 then
                        local text = "Auctioning" .. "," .. f.auctionID .. "," .. f.itemID .. "," .. f.money ..
                            "," .. (f.remaining) .. "," .. (f.player or "") .. "," .. (f.mod or "")
                        C_ChatInfo.SendAddonMessage(aura_env.AddonChannel, text, "WHISPER", senderFullName)
                    end
                end
            elseif arg1 == "Auctioning" and distType == "WHISPER" and sender ~= UnitName("player") then
                local auctionID = tonumber(arg2)
                local itemID = tonumber(arg3)
                local money = tonumber(arg4)
                local duration = tonumber(arg5)
                local player = arg6
                local mod = arg7

                for i, f in ipairs(_G.BGA.Frames) do
                    if f.auctionID == auctionID then
                        return
                    end
                end

                aura_env.CreateAuction(auctionID, itemID, money, duration, player, mod)
            elseif arg1 == "VersionCheck" and distType == "RAID" then
                C_ChatInfo.SendAddonMessage(aura_env.AddonChannel, "MyVer" .. "," .. aura_env.ver, "RAID")
            end
        elseif even == "GROUP_ROSTER_UPDATE" then
            C_Timer.After(0.5, function()
                aura_env.UpdateRaidRosterInfo()
            end)
        elseif even == "PLAYER_ENTERING_WORLD" then
            local isLogin, isReload = ...
            if not (isLogin or isReload) then return end
            C_Timer.After(0.5, function()
                aura_env.UpdateRaidRosterInfo()
            end)
            C_Timer.After(2, function()
                aura_env.GetAuctioningFromRaid()
            end)
        elseif even == "MODIFIER_STATE_CHANGED" then
            local mod, type = ...
            if (mod == "LCTRL" or mod == "RCTRL") then
                if type == 1 then
                    if aura_env.itemIsOnEnter then
                        SetCursor("Interface/Cursor/Inspect")
                    end
                else
                    SetCursor(nil)
                end
            end
        end
    end)
end)

--[[
/run C_ChatInfo.SendAddonMessage("BiaoGeAuction","StartAuction,"..GetTime()..",".."50011"..",".."5000"..",".."60","RAID")
 ]]
