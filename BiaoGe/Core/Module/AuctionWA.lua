local AddonName, ADDONSELF = ...

local pt = print

BG.RegisterEvent("ADDON_LOADED", function(self, event, addonName)
    if addonName ~= AddonName then return end

    local aura_env = aura_env or {}
    aura_env.ver = "v1.1"

    if not _G.BGA then
        _G.BGA = {}
        _G.BGA.Frames = {}
    else
        local function GetVerNum(str)
            local ver = tonumber(string.match(str, "v(%d+%.%d+)"))
            return ver
        end

        if GetVerNum(aura_env.ver) <= GetVerNum(_G.BGA.ver) then
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

    aura_env.AddonChannel = "BiaoGeAuction"
    C_ChatInfo.RegisterAddonMessagePrefix(aura_env.AddonChannel) -- 注册插件通信频道

    aura_env.L = setmetatable({}, {
        __index = function(table, key)
            return tostring(key)
        end
    })

    if (GetLocale() == "zhTW") then
        aura_env.L["Alt+点击才能生效"] = "Alt+點擊才能生效"
        aura_env.L["只有团长有权限取消拍卖"] = "只有團長有權限取消拍賣"
        aura_env.L["根据你的出价动态改变增减幅度"] = "根據你的出價動態改變增減幅度"
        aura_env.L["长按可以快速调整价格"] = "長按可以快速調整價格"
        aura_env.L["在输入框使用滚轮也可快速调整价格"] = "在輸入框使用滾輪也可快速調整價格"
        aura_env.L[">> 你 <<"] = ">> 你 <<"
        aura_env.L["匿名"] = "匿名"
        aura_env.L["你的出价需高于当前价格"] = "你的出價需高於當前價格"
        aura_env.L["取消拍卖"] = "取消拍賣"
        aura_env.L["装绑"] = "裝綁"
        aura_env.L["|cffFFD100当前价格：|r"] = "|cffFFD100當前價格：|r"
        aura_env.L["|cffFFD100起拍价：|r"] = "|cffFFD100起拍價：|r"
        aura_env.L["|cffFFD100出价最高者：|r"] = "|cffFFD100出價最高者：|r"
        aura_env.L["|cffFFD100< 匿名模式 >|r"] = "|cffFFD100< 匿名模式 >|r"
        aura_env.L["出价"] = "出價"
        aura_env.L["正常模式"] = "正常模式"
        aura_env.L["匿名模式"] = "匿名模式"
        aura_env.L["{rt1}拍卖开始{rt1} %s 起拍价：%s 拍卖时长：%ss %s"] = "{rt1}拍賣開始{rt1} %s 起拍價：%s 拍賣時長：%ss %s"
        aura_env.L["拍卖结束"] = "拍賣結束"
        aura_env.L["|cffFF0000流拍：|r"] = "|cffFF0000流拍：|r"
        aura_env.L["{rt7}流拍{rt7} %s"] = "{rt7}流拍{rt7} %s"
        aura_env.L["|cff00FF00成交价：|r"] = "|cff00FF00成交價：|r"
        aura_env.L["|cff00FF00买家：|r"] = "|cff00FF00買家：|r"
        aura_env.L["{rt6}拍卖成功{rt6} %s %s %s"] = "{rt6}拍賣成功{rt6} %s %s %s"
        aura_env.L["拍卖取消"] = "拍賣取消"
        aura_env.L["{rt7}拍卖取消{rt7} %s"] = "{rt7}拍賣取消{rt7} %s"
        aura_env.L["滚轮：快速调整价格"] = "滾輪：快速調整價格"
        aura_env.L["长按：快速调整价格"] = "長按：快速調整價格"
        aura_env.L["点击：复制当前价格并增加"] = "點擊：複製當前價格並增加"
        aura_env.L["隐藏"] = "隱藏"
        aura_env.L["显示"] = "顯示"
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

    aura_env.sound1 = SOUNDKIT.GS_TITLE_OPTION_OK -- 按键音效
    aura_env.sound2 = 569593                      -- 升级音效
    aura_env.GREEN1 = "00FF00"
    aura_env.RED1 = "FF0000"

    aura_env.WIDTH = 300
    aura_env.REPEAT_TIME = 20
    aura_env.HIDEFRAME_TIME = 3
    aura_env.raidRosterInfo = {}

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
        _G.BGA.FontDis18:SetTextColor(aura_env.RGB("808080"))
        _G.BGA.FontDis18:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
        local color = "Dis15" -- BGA.FontDis15
        _G.BGA.FontDis15 = CreateFont("BGA.Font" .. color)
        _G.BGA.FontDis15:SetTextColor(aura_env.RGB("808080"))
        _G.BGA.FontDis15:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")

        local color = "Green15" -- BGA.FontGreen15
        _G.BGA.FontGreen15 = CreateFont("BGA.Font" .. color)
        _G.BGA.FontGreen15:SetTextColor(0, 1, 0)
        _G.BGA.FontGreen15:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")

        local color = "While15" -- BGA.FontWhile15
        _G.BGA.FontWhile15 = CreateFont("BGA.Font" .. color)
        _G.BGA.FontWhile15:SetTextColor(1, 1, 1)
        _G.BGA.FontWhile15:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
    end

    function aura_env.UpdateRaidRosterInfo()
        wipe(aura_env.raidRosterInfo)
        aura_env.raidLeader = nil
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
                end
            end

            C_ChatInfo.SendAddonMessage(aura_env.AddonChannel, "MyVer" .. "," .. aura_env.ver, "RAID")
        end
        for i, f in ipairs(_G.BGA.Frames) do
            if not f.IsEnd and UnitName("player") == aura_env.raidLeader then
                f.cancel:Show()
            else
                f.cancel:Hide()
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
        if self.owner.IsAlpha then
            self:SetText(aura_env.L["隐藏"])
            self.owner:SetAlpha(1)
            self.owner.IsAlpha = false
            self.owner.AlphaFrame:Hide()
        else
            self:SetText(aura_env.L["显示"])
            self.owner:SetAlpha(0.2)
            self.owner.IsAlpha = true
            self.owner.AlphaFrame:Show()
        end
        PlaySound(aura_env.sound1, "Master")
    end

    function aura_env.Cancel_OnClick(self)
        if IsAltKeyDown() then
            C_ChatInfo.SendAddonMessage(aura_env.AddonChannel, "CancelAuction" .. "," ..
                self.owner.auctionID, "RAID")
            PlaySound(aura_env.sound1, "Master")
        end
    end

    function aura_env.Cancel_OnEnter(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
        GameTooltip:AddLine(aura_env.L["Alt+点击才能生效"], 1, 0.82, 0, true)
        GameTooltip:AddLine(aura_env.L["只有团长有权限取消拍卖"], 0.5, 0.5, 0.5, true)
        GameTooltip:Show()
    end

    function aura_env.JiaJian(money, fudu, _type)
        if _type == "+" then
            return money + fudu
        elseif _type == "-" then
            if money - fudu > 0 then
                return money - fudu
            else
                return 0
            end
        end
    end

    function aura_env.Addmoney(money, _type)
        local money = tonumber(money) or 0
        local fudu = 0
        if money < 30 then
            fudu = 1 -- 1-30,1
            return aura_env.JiaJian(money, fudu, _type), fudu
        elseif money < 100 then
            fudu = 5 -- 30-100,5
            return aura_env.JiaJian(money, fudu, _type), fudu
        elseif money < 300 then
            fudu = 10 -- 100-300,10
            return aura_env.JiaJian(money, fudu, _type), fudu
        elseif money < 1000 then
            fudu = 50 -- 300-1000,50
            return aura_env.JiaJian(money, fudu, _type), fudu
        elseif money < 3000 then
            fudu = 100 -- 1000-3000,100
            return aura_env.JiaJian(money, fudu, _type), fudu
        elseif money < 10000 then
            fudu = 500 -- 3000-10000,500
            return aura_env.JiaJian(money, fudu, _type), fudu
        elseif money < 30000 then
            fudu = 1000 -- 10000-30000,1000
            return aura_env.JiaJian(money, fudu, _type), fudu
        elseif money < 100000 then
            fudu = 5000 -- 30000-100000,5000
            return aura_env.JiaJian(money, fudu, _type), fudu
        else
            fudu = 10000 -- 100000以上,10000
            return aura_env.JiaJian(money, fudu, _type), fudu
        end
    end

    function aura_env.itemOnEnter(self)
        if self:GetCenter() > UIParent:GetCenter() then
            GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
        else
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
        end
        GameTooltip:ClearLines()
        GameTooltip:SetItemByID(self.itemID)
        GameTooltip:Show()
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
                f.bar:SetStatusBarColor(1, 0, 0, 0.6)
                f.remainingTime:SetTextColor(1, 0, 0)
                f.remainingTime:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
            else
                f.bar:SetStatusBarColor(1, 1, 0, 0.6)
                f.remainingTime:SetTextColor(1, 1, 1)
                f.remainingTime:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            end
            f.remainingTime:SetText((format("%d", remaining) + 1) .. "s")
            f.remaining = remaining

            if remaining <= 0 then
                f.myMoney:Hide()
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
                t:SetPoint("TOPRIGHT", f.itemFrame, "BOTTOMRIGHT", -5, -5)
                t:SetText(aura_env.L["拍卖结束"])
                t:SetTextColor(1, 0, 0)

                if f.player and f.player ~= "" then
                    f.currentMoney:SetText(aura_env.L["|cff00FF00成交价：|r"] .. f.money)
                    if f.player == UnitName("player") then
                        f.topMoney:SetText(aura_env.L["|cff00FF00买家：|r"] .. "|cff" .. aura_env.GREEN1 .. aura_env.L[">> 你 <<"])
                    else
                        f.topMoney:SetText(aura_env.L["|cff00FF00买家：|r"] .. f.colorplayer)
                    end

                    if UnitName("player") == aura_env.raidLeader then
                        SendChatMessage(format(aura_env.L["{rt6}拍卖成功{rt6} %s %s %s"], f.link, f.player, f.money), "RAID")
                    end
                else
                    f.currentMoney:SetText(aura_env.L["|cffFF0000流拍：|r"] .. f.money)
                    f.topMoney:SetText("")

                    if UnitName("player") == aura_env.raidLeader then
                        SendChatMessage(format(aura_env.L["{rt7}流拍{rt7} %s"], f.link), "RAID")
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
            GameTooltip:AddLine(self.owner.currentMoney:GetText(), 1, 1, 1)
            GameTooltip:AddLine(aura_env.L["点击：复制当前价格并增加"] .. fudu, 1, 0.82, 0, true)
            GameTooltip:Show()
            self.IsOnter = true
        end
    end

    function aura_env.currentMoney_OnMouseDown(self)
        self.owner:GetScript("OnMouseDown")(_G.BGA.AuctionMainFrame)
    end

    function aura_env.currentMoney_OnMouseUp(self)
        if not self.owner.start and not self.owner.IsEnd and self.owner.player ~= UnitName("player") then
            self.owner.myMoney:SetText(aura_env.Addmoney(self.owner.money, "+"))
            aura_env.UpdateAllOnEnters()
            PlaySound(aura_env.sound1, "Master")
        end
        self.owner:GetScript("OnMouseUp")(_G.BGA.AuctionMainFrame)
    end

    function aura_env.myMoney_OnTextChanged(self)
        local money = tonumber(self:GetText()) or 0
        if self.owner.start then
            if money < self.owner.money then
                self.owner.ButtonSendMyMoney:Disable()
                if self.owner.player ~= UnitName("player") then
                    self.owner.ButtonSendMyMoney.disf:Show()
                end
            else
                self.owner.ButtonSendMyMoney:Enable()
                self.owner.ButtonSendMyMoney.disf:Hide()
            end
        elseif money <= self.owner.money then
            self.owner.ButtonSendMyMoney:Disable()
            if self.owner.player ~= UnitName("player") then
                self.owner.ButtonSendMyMoney.disf:Show()
            end
        else
            self.owner.ButtonSendMyMoney:Enable()
            self.owner.ButtonSendMyMoney.disf:Hide()
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
        GameTooltip:AddLine(aura_env.L["滚轮：快速调整价格"], 1, 0.82, 0, true)
        GameTooltip:Show()
        self.IsOnter = true
    end

    function aura_env.OnLeave(self)
        GameTooltip_Hide()
        self.IsOnter = false
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
        GameTooltip:AddLine(aura_env.L["根据你的出价动态改变增减幅度"], 1, 0.82, 0, true)
        GameTooltip:AddLine(aura_env.L["长按：快速调整价格"], 1, 0.82, 0, true)
        GameTooltip:Show()
        self.IsOnter = true
    end

    function aura_env.JiaJian_OnClick(self)
        self.edit:SetText(aura_env.Addmoney(self.edit:GetText(), self._type))
        aura_env.UpdateAllOnEnters()
        PlaySound(aura_env.sound1, "Master")
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
        if self.owner.ButtonSendMyMoney:IsEnabled() then
            local money = tonumber(self.owner.myMoney:GetText()) or 0
            C_ChatInfo.SendAddonMessage(aura_env.AddonChannel, "SendMyMoney" .. "," ..
                self.owner.auctionID .. "," .. money, "RAID")
            self.owner.myMoney:ClearFocus()
            PlaySound(aura_env.sound1, "Master")
        end
    end

    function aura_env.SetMoney(f, money, player)
        f.money = money
        f.currentMoney:SetText(aura_env.L["|cffFFD100当前价格：|r"] .. money)
        f.player = player
        f.colorplayer = aura_env.SetClassCFF(player)
        f.myMoney:Show()
        f.start = false
        if player == UnitName("player") then
            f.topMoney:SetText(aura_env.L["|cffFFD100出价最高者：|r"] .. "|cff" .. aura_env.GREEN1 .. aura_env.L[">> 你 <<"])
            f:SetBackdropBorderColor(0, 1, 0, 1)
        else
            if f.mod == "anonymous" then
                f.topMoney:SetText(aura_env.L["|cffFFD100出价最高者：|r"] .. aura_env.L["匿名"])
            else
                f.topMoney:SetText(aura_env.L["|cffFFD100出价最高者：|r"] .. f.colorplayer)
            end
            f:SetBackdropBorderColor(0, 0, 0, 1)
        end
        aura_env.myMoney_OnTextChanged(f.myMoney)
        aura_env.UpdateAllOnEnters()

        if f.remaining <= aura_env.REPEAT_TIME then
            aura_env.Auctioning(f, aura_env.REPEAT_TIME)
        end
    end

    function aura_env.SendMyMoney_OnEnter(self)
        GameTooltip:SetOwner(self.owner, "ANCHOR_BOTTOM", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(aura_env.L["你的出价需高于当前价格"], 1, 0, 0, true)
        GameTooltip:Show()
    end

    function aura_env.UpdateAllOnEnters()
        for i, f in ipairs(_G.BGA.Frames) do
            if f.currentMoney.IsOnter then
                aura_env.currentMoney_OnEnter(f.currentMoney)
            end
            if f.myMoney.IsOnter then
                aura_env.myMoney_OnEnter(f.myMoney)
            end
            if f.ButtonJian.IsOnter then
                aura_env.JiaJian_OnEnter(f.ButtonJian)
            end
            if f.ButtonJia.IsOnter then
                aura_env.JiaJian_OnEnter(f.ButtonJia)
            end
        end
    end

    function aura_env.UpdateAllFrames()
        for i, f in ipairs(_G.BGA.Frames) do
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

    function aura_env.CreateAuction(auctionID, itemID, money, duration, player, mod)
        for i, f in ipairs(_G.BGA.Frames) do
            if f.auctionID == auctionID then
                return
            end
        end

        local name, link, quality, level, _, _, _, _, _, Texture, _, typeID, _, bindType = GetItemInfo(itemID)
        if not link then
            C_Timer.After(0.5, function()
                aura_env.CreateAuction(auctionID, itemID, money, duration - 0.5, player, mod)
            end)
            return
        end
        local AuctionFrame, itemFrame, moneyFrame

        -- 主界面
        do
            local f = CreateFrame("Frame", nil, _G.BGA.AuctionMainFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 2,
            })
            f:SetBackdropColor(0, 0, 0, 0.6)
            f:SetBackdropBorderColor(0, 0, 0, 1)
            f:SetSize(aura_env.WIDTH, 108)
            if #_G.BGA.Frames == 0 then
                f:SetPoint("TOPLEFT", 0, 0)
            else
                f:SetPoint("TOPLEFT", _G.BGA.Frames[#_G.BGA.Frames], "BOTTOMLEFT", 0, -5)
            end
            f:EnableMouse(true)
            f.auctionID = auctionID
            f.itemID = itemID
            f.link = link
            f.mod = mod
            f.num = #_G.BGA.Frames + 1
            AuctionFrame = f
            tinsert(_G.BGA.Frames, f)
            f:SetScript("OnMouseUp", function(self)
                _G.BGA.AuctionMainFrame:StopMovingOrSizing()
                if _G.BiaoGe and _G.BiaoGe.point then
                    _G.BiaoGe.point.Auction = { _G.BGA.AuctionMainFrame:GetPoint(1) }
                end
            end)
            f:SetScript("OnMouseDown", function(self)
                _G.BGA.AuctionMainFrame:StartMoving()
            end)
        end
        -- 操作
        do
            -- Pass
            local bt = CreateFrame("Button", nil, AuctionFrame)
            bt:SetNormalFontObject(_G.BGA.FontGreen15)
            bt:SetHighlightFontObject(_G.BGA.FontWhile15)
            bt:SetPoint("TOPRIGHT", -3, -3)
            bt:SetText(aura_env.L["隐藏"])
            bt:SetSize(bt:GetFontString():GetWidth(), 20)
            bt.owner = AuctionFrame
            bt:SetScript("OnClick", aura_env.Pass_OnClick)
            AuctionFrame.hide = bt

            local f = CreateFrame("Frame", nil, AuctionFrame)
            f:SetPoint("TOPLEFT", f:GetParent(), "TOPLEFT", 0, -25)
            f:SetPoint("BOTTOMRIGHT", f:GetParent(), "BOTTOMRIGHT", 0, 0)
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
            AuctionFrame.AlphaFrame = f

            -- 取消拍卖
            local bt = CreateFrame("Button", nil, AuctionFrame)
            bt:SetNormalFontObject(_G.BGA.FontGreen15)
            bt:SetHighlightFontObject(_G.BGA.FontWhile15)
            bt:SetPoint("TOPLEFT", 3, -3)
            bt:SetText(aura_env.L["取消拍卖"])
            bt:SetSize(bt:GetFontString():GetWidth(), 20)
            bt:RegisterForClicks("AnyUp")
            bt.owner = AuctionFrame
            bt:SetScript("OnClick", aura_env.Cancel_OnClick)
            bt:SetScript("OnEnter", aura_env.Cancel_OnEnter)
            bt:SetScript("OnLeave", GameTooltip_Hide)
            AuctionFrame.cancel = bt

            if UnitName("player") == aura_env.raidLeader then
                bt:Show()
            else
                bt:Hide()
            end
        end
        -- 装备显示
        do
            local f = CreateFrame("Frame", nil, AuctionFrame, "BackdropTemplate")
            f:SetPoint("TOPLEFT", f:GetParent(), "TOPLEFT", 2, -25)
            f:SetPoint("BOTTOMRIGHT", f:GetParent(), "TOPRIGHT", -2, -53)
            f:SetFrameLevel(f:GetParent():GetFrameLevel() + 10)
            f.owner = AuctionFrame
            f.itemID = itemID
            f:SetScript("OnEnter", aura_env.itemOnEnter)
            f:SetScript("OnLeave", GameTooltip_Hide)
            f:SetScript("OnMouseUp", function(self)
                AuctionFrame:GetScript("OnMouseUp")(_G.BGA.AuctionMainFrame)
            end)
            f:SetScript("OnMouseDown", function(self)
                AuctionFrame:GetScript("OnMouseDown")(_G.BGA.AuctionMainFrame)
            end)
            itemFrame = f
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
                edgeSize = 1.5,
            })
            ftex:SetBackdropBorderColor(r, g, b, 1)
            ftex:SetPoint("TOPLEFT", 0, 0)
            ftex:SetSize(f:GetHeight(), f:GetHeight())
            ftex.tex = ftex:CreateTexture(nil, "BACKGROUND")
            ftex.tex:SetAllPoints()
            ftex.tex:SetTexture(Texture)
            ftex.tex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
            -- 装备等级
            local t = ftex:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
            t:SetPoint("BOTTOM", ftex, "BOTTOM", 0, 0)
            t:SetText(level)
            t:SetTextColor(r, g, b)
            -- 装备名称
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("LEFT", ftex, "RIGHT", 2, bindType == 2 and 5 or 0)
            t:SetWidth(f:GetWidth() - f:GetHeight() - 50)
            t:SetText(link:gsub("%[", ""):gsub("%]", ""))
            t:SetJustifyH("LEFT")
            t:SetWordWrap(false)
            -- 装绑
            if bindType == 2 then
                local t = ftex:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
                t:SetPoint("BOTTOMLEFT", ftex, "BOTTOMRIGHT", 2, 0)
                t:SetText(aura_env.L["装绑"])
                t:SetTextColor(0, 1, 0)
            end
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
            local width = 170
            local height = 25
            local f = CreateFrame("Frame", nil, AuctionFrame)
            f:SetSize(width, 20)
            f:SetPoint("TOPLEFT", itemFrame, "BOTTOMLEFT", 3, -5)
            f:SetScript("OnMouseDown", aura_env.currentMoney_OnMouseDown)
            f:SetScript("OnMouseUp", aura_env.currentMoney_OnMouseUp)
            f:SetScript("OnEnter", aura_env.currentMoney_OnEnter)
            f:SetScript("OnLeave", aura_env.OnLeave)
            f.owner = AuctionFrame
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetAllPoints()
            t:SetJustifyH("LEFT")
            if player and player ~= "" then
                t:SetText(aura_env.L["|cffFFD100当前价格：|r"] .. money)
                AuctionFrame.start = false
            else
                t:SetText(aura_env.L["|cffFFD100起拍价：|r"] .. money)
                AuctionFrame.start = true
            end
            local currentMoney = f
            AuctionFrame.currentMoney = t
            AuctionFrame.money = money

            local f = CreateFrame("Frame", nil, currentMoney)
            f:SetSize(width, height)
            f:SetPoint("TOPLEFT", currentMoney, "BOTTOMLEFT", 0, 0)
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetAllPoints()
            t:SetJustifyH("LEFT")
            if player then
                AuctionFrame.player = player
                AuctionFrame.colorplayer = aura_env.SetClassCFF(player)
            end
            if player and player ~= "" then
                if player == UnitName("player") then
                    t:SetText(aura_env.L["|cffFFD100出价最高者：|r"] .. "|cff" .. aura_env.GREEN1 .. aura_env.L[">> 你 <<"])
                    AuctionFrame:SetBackdropBorderColor(0, 1, 0, 1)
                else
                    if mod == "anonymous" then
                        t:SetText(aura_env.L["|cffFFD100出价最高者：|r"] .. aura_env.L["匿名"])
                    else
                        t:SetText(aura_env.L["|cffFFD100出价最高者：|r"] .. AuctionFrame.colorplayer)
                    end
                    AuctionFrame:SetBackdropBorderColor(0, 0, 0, 1)
                end
            elseif mod == "anonymous" then
                t:SetText(aura_env.L["|cffFFD100< 匿名模式 >|r"])
            end
            local toptMoney = f
            AuctionFrame.topMoney = t

            -- 输入框
            local edit = CreateFrame("EditBox", nil, currentMoney, "InputBoxTemplate")
            edit:SetSize(AuctionFrame:GetRight() - currentMoney:GetRight() - 3, 20)
            edit:SetPoint("TOPLEFT", currentMoney, "TOPRIGHT", 0, 0)
            edit:SetText(money)
            edit:SetAutoFocus(false)
            edit:SetNumeric(true)
            edit.owner = AuctionFrame
            edit:SetScript("OnTextChanged", aura_env.myMoney_OnTextChanged)
            edit:SetScript("OnEnterPressed", aura_env.SendMyMoney_OnClick)
            edit:SetScript("OnMouseWheel", aura_env.myMoney_OnMouseWheel)
            edit:SetScript("OnEnter", aura_env.myMoney_OnEnter)
            edit:SetScript("OnLeave", aura_env.OnLeave)
            AuctionFrame.myMoney = edit
            -- 减
            local bt = CreateFrame("Button", nil, edit, "UIPanelButtonTemplate")
            bt:SetSize(height, height)
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
            bt:SetSize(height, height)
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
            bt:SetText(aura_env.L["出价"])
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

            aura_env.myMoney_OnTextChanged(AuctionFrame.myMoney)
        end

        aura_env.Auctioning(AuctionFrame, duration)
    end

    aura_env.UpdateRaidRosterInfo()
    aura_env.GetAuctioningFromRaid()

    -- 主界面
    do
        local f = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
        f:SetSize(aura_env.WIDTH, 100)
        f:SetFrameStrata("HIGH")
        f:SetClampedToScreen(true)
        f:SetFrameLevel(100)
        f:SetToplevel(true)
        f:SetMovable(true)
        _G.BGA.AuctionMainFrame = f

        if _G.BiaoGe and _G.BiaoGe.point and _G.BiaoGe.point.Auction then
            f:SetPoint(unpack(_G.BiaoGe.point.Auction))
        else
            f:SetPoint("TOPRIGHT", -100, -200)
        end
    end

    _G.BGA.Even = CreateFrame("Frame")
    _G.BGA.Even:RegisterEvent("CHAT_MSG_ADDON")
    _G.BGA.Even:RegisterEvent("GROUP_ROSTER_UPDATE")
    _G.BGA.Even:RegisterEvent("PLAYER_ENTERING_WORLD")
    _G.BGA.Even:SetScript("OnEvent", function(self, even, ...)
        if even == "CHAT_MSG_ADDON" then
            local prefix, msg, distType, senderFullName = ...
            if prefix ~= aura_env.AddonChannel then return end
            local arg1, arg2, arg3, arg4, arg5, arg6, arg7 = strsplit(",", msg)
            -- print(senderFullName, arg1, arg2, arg3, arg4, arg5, arg6, arg7) --todo
            local sender, realm = strsplit("-", senderFullName)
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
            elseif arg1 == "StartAuction" and distType == "RAID" and sender == aura_env.raidLeader then
                local auctionID = tonumber(arg2)
                local itemID = tonumber(arg3)
                local money = tonumber(arg4)
                local duration = tonumber(arg5)
                local player = arg6
                local mod = arg7
                aura_env.CreateAuction(auctionID, itemID, money, duration, player, mod)

                if UnitName("player") == aura_env.raidLeader then
                    local tbl = {
                        normal = aura_env.L["正常模式"],
                        anonymous = aura_env.L["匿名模式"],
                    }

                    local _, link = GetItemInfo(itemID)
                    if link then
                        SendChatMessage(format(aura_env.L["{rt1}拍卖开始{rt1} %s 起拍价：%s 拍卖时长：%ss %s"],
                            link, money, duration, (tbl[mod] and "<" .. tbl[mod] .. ">" or "")), "RAID_WARNING")
                    else
                        C_Timer.After(0.5, function()
                            local _, link = GetItemInfo(itemID)
                            SendChatMessage(format(aura_env.L["{rt1}拍卖开始{rt1} %s 起拍价：%s 拍卖时长：%ss %s"],
                                link, money, duration, (tbl[mod] and "<" .. tbl[mod] .. ">" or "")), "RAID_WARNING")
                        end)
                    end
                end
            elseif arg1 == "CancelAuction" and distType == "RAID" and sender == aura_env.raidLeader then
                local auctionID = tonumber(arg2)
                for i, f in ipairs(_G.BGA.Frames) do
                    if f.auctionID == auctionID and not f.IsEnd then
                        local t = f:CreateFontString()
                        t:SetFont(STANDARD_TEXT_FONT, 30, "OUTLINE")
                        t:SetPoint("TOPRIGHT", f.itemFrame, "BOTTOMRIGHT", -5, -5)
                        t:SetText(aura_env.L["拍卖取消"])
                        t:SetTextColor(1, 0, 0)

                        f.remainingTime:Hide()
                        f.bar:Hide()
                        f.IsEnd = true
                        f.myMoney:Hide()
                        f.cancel:Hide()

                        if UnitName("player") == aura_env.raidLeader then
                            SendChatMessage(format(aura_env.L["{rt7}拍卖取消{rt7} %s"], f.link), "RAID")
                        end

                        C_Timer.After(aura_env.HIDEFRAME_TIME, function()
                            aura_env.UpdateFrame(f)
                        end)
                        return
                    end
                end
            elseif arg1 == "GetAuctioning" and distType == "RAID" and sender ~= UnitName("player") then
                for i, f in ipairs(_G.BGA.Frames) do
                    if not f.IsEnd and f.remaining >= 2 then
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
        elseif even == "GROUP_ROSTER_UPDATE" or even == "PLAYER_ENTERING_WORLD" then
            C_Timer.After(0.5, function()
                aura_env.UpdateRaidRosterInfo()
            end)
            if even == "PLAYER_ENTERING_WORLD" then
                C_Timer.After(2, function()
                    aura_env.GetAuctioningFromRaid()
                end)
            end
        end
    end)
end)

--[[
/run C_ChatInfo.SendAddonMessage("BiaoGeAuction","StartAuction,"..GetTime()..",".."50011"..",".."5000"..",".."60","RAID")
 ]]
