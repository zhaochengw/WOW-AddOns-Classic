
local AddonName, Addon = ...

local Config = Addon.Config
local TradeLog = Addon.TradeLog
--local Panel = Addon.Panel
--local ScrollFrame = Addon.ScrollFrame
local SetWindow = Addon.SetWindow
local L = Addon.L

-- Local API提升效率
local t_insert = table.insert
local t_remove = table.remove

-- 初始化SetWindow
function SetWindow:Initialize()
    -- 创建SetWindow框体
    local f = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
    f:SetWidth(380)
    f:SetHeight(510)
    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = {left = 8, right = 8, top = 10, bottom = 10}
    })
    f:SetBackdropColor(0, 0, 0)
    f:SetPoint(Config.SetWindowPos[1], nil, Config.SetWindowPos[3], Config.SetWindowPos[4], Config.SetWindowPos[5])
    f:SetToplevel(true)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self)
        if not InCombatLockdown() then
            f:StartMoving()
        end
    end)
    f:SetScript("OnDragStop", function(self)
        f:StopMovingOrSizing()
        Config.SetWindowPos[1], _, Config.SetWindowPos[3], Config.SetWindowPos[4], Config.SetWindowPos[5] = f:GetPoint()
    end)
    f:SetScript("OnMouseDown", clearAllFocus)
    if not UnitAffectingCombat("player") then
        f:SetPropagateKeyboardInput(false)
        f:SetScript("OnKeyDown", function(self, key)
            if key == "ESCAPE" then
                f:SetPropagateKeyboardInput(false)
                f:Hide()
            else
                f:SetPropagateKeyboardInput(true)
            end
        end)
    end
    f:Hide()
    self.background = f
    do -- 创建框体标题栏纹理
        local t = f:CreateTexture(nil, "ARTWORK")
        t:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")
        t:SetWidth(360)
        t:SetHeight(64)
        t:SetPoint("TOP", f, 0, 12)
        f.texture = t
    end
    do -- 创建框体标题
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        t:SetText(string.format("|cFFFF6633" .. AddonName .. "|r" .. " v" .. Addon.Version))
        t:SetPoint("TOP", f.texture, 0, -14)
    end
--[[do -- 創建作者信息及下載鏈接
		local t1 = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t1:SetWidth(320)
        t1:SetHeight(25)
		t1:SetText(L["|cFFFFC040By:|r |cFF9382C9Aoikaze|r-|cFFFF66FFZeroZone|r-|cFFDE2910CN|r"])
		local t2 = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t2:SetWidth(320)
        t2:SetHeight(25)
		t2:SetText(L["|cFFFF33CCFeedback & Update: |r"]..L["Feedback & Update Link"])
		t1:SetPoint("TOPLEFT", 25, -40)
		t2:SetPoint("TOP", t1, "BOTTOM", 15)
	end	]]
    do -- 创建关闭按钮
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b:SetWidth(130)
        b:SetHeight(25)
        b:SetPoint("BOTTOMLEFT", 210, 20)
        b:SetText(CLOSE)
        b:SetScript("OnClick", function() f:Hide() end)
    end
    do -- 插件開關
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t:SetText(L["Enable |cFFBA55D3MailLogger|r"])
        local c = CreateFrame("CheckButton", nil, f, "InterfaceOptionsCheckButtonTemplate")
        c:SetPoint("TOPLEFT", 40, -40)
--      c:SetPoint("TOPLEFT", 210, -75)
        t:SetPoint("LEFT", c, "RIGHT", 5, 0)
        c:SetScript("OnShow", function(self) self:SetChecked(Config.EnableML) end)
        c:SetScript("OnClick", function(self) Config.EnableML = self:GetChecked() end)
    end
    do -- 密語開關
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t:SetText(L["Enable |cFF00CD00Whisper|r"])
        local c = CreateFrame("CheckButton", nil, f, "InterfaceOptionsCheckButtonTemplate")
        c:SetPoint("TOPLEFT", 40, -75)
        t:SetPoint("LEFT", c, "RIGHT", 5, 0)
        c:SetScript("OnShow", function(self) self:SetChecked(Config.EnableWhisper) end)
        c:SetScript("OnClick", function(self) Config.EnableWhisper = self:GetChecked() end)
    end
    do -- 输出至團隊
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t:SetText(L["Send to |cFFF0F000Public|r"])
        local c = CreateFrame("CheckButton", nil, f, "InterfaceOptionsCheckButtonTemplate")
        c:SetPoint("TOPLEFT", 210, -75)
        t:SetPoint("LEFT", c, "RIGHT", 5, 0)
        c:SetScript("OnShow", function(self) self:SetChecked(Config.SendToPublic) end)
        c:SetScript("OnClick", function(self) Config.SendToPublic = self:GetChecked() end)
    end
    do -- 小地图按钮
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t:SetText(L["Show |cFF4169E1Minimap Button|r"])
        local c = CreateFrame("CheckButton", nil, f, "InterfaceOptionsCheckButtonTemplate")
        c:SetPoint("TOPLEFT", 210, -40)
        t:SetPoint("LEFT", c, "RIGHT", 5, 0)
        c:SetScript("OnShow", function(self) self:SetChecked(Config.ShowMinimapIcon) end)
        c:SetScript("OnClick", function(self)
            Config.ShowMinimapIcon = self:GetChecked()
            if Addon.LDB and Addon.LDBIcon then
                if Config.ShowMinimapIcon then
                    Addon.LDBIcon:Show("MailLogger")
                else
                    Addon.LDBIcon:Hide("MailLogger")
                end
            else
                if Config.ShowMinimapIcon and not Addon.MinimapIcon.Minimap:IsShown() then
                    Addon.MinimapIcon.Minimap:Show()
                else
                    Addon.MinimapIcon.Minimap:Hide()
                end
            end
        end)
    end
    do -- 永久記錄及保存時常設置及顯示
	-- 保存时长EditBox
        local t1 = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        t1:SetText(L["Trade Log Days"])
        local t2 = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        t2:SetText(L[" Day(s)"])

        local e = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
        e:SetWidth(32)
        e:SetHeight(25)
        e:SetAutoFocus(false)
        e:SetMaxLetters(3)
        e:SetNumeric()
        e:SetScript("OnEnterPressed", function(self)
			if Config.LogEverything then
				self:SetText("N/A")
			else
				if self:HasFocus() then
					if tonumber(self:GetText()) then
						local Days = math.floor(tonumber(self:GetText()))
						if Days > 0 and Days <= 365 then
							Config.LogDays = Days
						end
					end
				end
	            self:SetText(tostring(Config.LogDays))
            end
            self:ClearFocus()
        end)
        e:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
        e:SetScript("OnEscapePressed", function(self)
			if Config.LogEverything then
				self:SetText("N/A")
			else
            	self:SetText(tostring(Config.LogDays))
			end
            self:ClearFocus()
        end)
        e:SetScript("OnShow", function(self)
			if Config.LogEverything then
				self:SetText("N/A")
			else
				self:SetText(tostring(Config.LogDays))
			end
		end)
        t1:SetPoint("TOPLEFT", 213, -115)
        e:SetPoint("LEFT", t1, "RIGHT", 8, 0)
        t2:SetPoint("LEFT", e, "RIGHT", 2, 0)
--      self.days = e
		--永久記錄
		local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
        t:SetText(L["Log |cFFFF7F50Every Day|r"])
        local c = CreateFrame("CheckButton", nil, f, "InterfaceOptionsCheckButtonTemplate")
        c:SetPoint("TOPLEFT", 40, -110)
        t:SetPoint("LEFT", c, "RIGHT", 5, 0)
        c:SetScript("OnShow", function(self) self:SetChecked(Config.LogEverything) end)
		c:SetScript("OnClick", function(self)
			Config.LogEverything = self:GetChecked()
			if Config.LogEverything then
				e:SetText("N/A")
			else
				e:SetText(tostring(Config.LogDays))
			end
		end)
    end
	do	-- 分割符號
		local l = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        l:SetText("")
        l:SetHeight(2)
        l:SetWidth(300)
        l:Disable()
		l:SetPoint("TOPLEFT", 40, -147)
	end
	do	-- 清理小號數據下拉菜單及按鈕
		local d = CreateFrame("Frame", nil, f, "UIDropDownMenuTemplate")
		local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmallLeft")
		t:SetText(L["Alt Name"])
        t:SetNonSpaceWrap(false)
		t:SetWidth(60)
		t:SetPoint("TOPLEFT", 40, -168)

		local value = {}
		local text = {}
		local index = 1

		for k in pairs(Config.AltList) do
			t_insert(value, index)
			t_insert(text, k)
			index = index + 1
		end

		UIDropDownMenu_Initialize(d, function(self)
			local info = UIDropDownMenu_CreateInfo()
			d.text = text
			for i = 1, #text do
				info.text = text[i]
				info.value = value[i]
				info.func = function(v)
					Addon.Config.SelectName = text[v.value]
					UIDropDownMenu_SetText(d, text[v.value])
					CloseDropDownMenus()
                    Addon.Output.dropdownlist:Hide()
                    Addon.Output.dropdownlist:Show()
				end
				info.arg1, info.arg2 = d, value[i]
				UIDropDownMenu_AddButton(info)
			end
		end)
		d.SetValue = function(v) Addon.Config.SelectName = text[v] end
		d:SetScript("OnShow", function(self)
			UIDropDownMenu_SetText(self, Config.SelectName)
		end)
		UIDropDownMenu_JustifyText(d, "CENTER")
		UIDropDownMenu_SetWidth(d, 110)
		UIDropDownMenu_SetButtonWidth(d, 120)
		d:SetPoint("LEFT", t, "RIGHT", 0, 0)

		local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate") --刪除按鈕
        local by = CreateFrame("Button", nil, f, "GameMenuButtonTemplate") -- 確認按鈕
        local bn = CreateFrame("Button", nil, f, "GameMenuButtonTemplate") -- 拒絕按鈕
		b:SetWidth(80)
		b:SetHeight(25)
		b:SetPoint("LEFT", d, "RIGHT", 0, 2)
		b:SetText(L["Remove"])
		b:SetScript("OnClick", function()
			-- delete alt date
            by:Show()
            bn:Show()
            C_Timer.After(5, function()
                if by:IsShown() then
                    by:Hide()
                end
                if bn:IsShown() then
                    bn:Hide()
                end
            end)
   		end)
        by:SetWidth(35)
        by:SetHeight(25)
        by:SetPoint("TOPLEFT", 265, -200)
        by:SetText("Y")
        by:Hide()
        by:SetScript("OnClick", function()
            if #TradeLog > 0 then
                for i = #TradeLog, 1, -1 do
                    if TradeLog[i].PlayerName == Config.SelectName then
                        t_remove(TradeLog, i)
                    end
                end
            end
            print(string.format(L["<|cFFBA55D3MailLogger|r>[%s]'s Logs was deleted!"], Config.SelectName))
            if Config.AltList[Config.SelectName] then
                Config.AltList[Config.SelectName] = nil
            end
			Config.SelectName = (UnitName("player")) .. "-" ..GetRealmName()
			if Addon.Output.background:IsShown() then
				Addon.Output.background:Hide()
			end
            if Addon.SetWindow.background:IsShown() then
                Addon.SetWindow.background:Hide()
            end
            if Addon.Calendar.background:IsShown() then
                Addon.Calendar.background:Hide()
            end
            Addon.Output:Initialize()
            self:Initialize()
            by:Hide()
            bn:Hide()
        end)
        bn:SetWidth(35)
        bn:SetHeight(25)
        bn:SetPoint("LEFT", by, "RIGHT", 5, 0)
        bn:SetText("N")
        bn:Hide()
        bn:SetScript("OnClick", function()
            by:Hide()
            bn:Hide()
        end)

		self.dropdowntitle = t
		self.dropdownlist = d
		self.dropdownbutton = b
	end
	do -- 顯示記錄
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b:SetWidth(120)
        b:SetHeight(25)
        b:SetPoint("TOPLEFT", 40, -200)
        b:SetText(L["Print Logs"])
        b:SetScript("OnClick", function()
			Addon.Output.dropdowntitle:Show()
			Addon.Output.dropdownlist:Show()
			Addon.Output.dropdownbutton:Show()
			Addon:PrintTradeLog("ALL", nil)
			Addon:GetAvailableDate()
			Addon.Calendar.background:Show()
			Addon:RefreshCalendar()
		 end)
	end
	do	-- 清空數據庫按鈕
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate") -- 清空按鈕
        local by = CreateFrame("Button", nil, f, "GameMenuButtonTemplate") -- 確認按鈕
        local bn = CreateFrame("Button", nil, f, "GameMenuButtonTemplate") -- 拒絕按鈕
        b:SetWidth(80)
        b:SetHeight(25)
        b:SetPoint("TOPLEFT", 170, -200)
        b:SetText(L["Delete All"])
        b:SetScript("OnClick", function()
            by:Show()
            bn:Show()
            C_Timer.After(5, function()
                if by:IsShown() then
                    by:Hide()
                end
                if bn:IsShown() then
                    bn:Hide()
                end
            end)
		end)
        by:SetWidth(35)
        by:SetHeight(25)
        by:SetPoint("TOPLEFT", 265, -200)
        by:SetText("Y")
        by:Hide()
        by:SetScript("OnClick", function()
            for i = #TradeLog, 1, -1 do
                table.remove(TradeLog, i)
            end
            Config.AltList = {[(UnitName("player")).."-"..GetRealmName()] = true,}
            Config.SelectName = (UnitName("player").."-"..GetRealmName())
            if Addon.Output.background:IsShown() then
                Addon.Output.background:Hide()
            end
            if Addon.SetWindow.background:IsShown() then
                Addon.SetWindow.background:Hide()
            end
            if Addon.Calendar.background:IsShown() then
                Addon.Calendar.background:Hide()
            end
            Addon.Output:Initialize()
            self:Initialize()
            print(L["<|cFFBA55D3MailLogger|r>All Logs was deleted!"])
            by:Hide()
            bn:Hide()
        end)
        bn:SetWidth(35)
        bn:SetHeight(25)
        bn:SetPoint("LEFT", by, "RIGHT", 5, 0)
        bn:SetText("N")
        bn:Hide()
        bn:SetScript("OnClick", function()
            by:Hide()
            bn:Hide()
        end)
	end
	do	-- 分割符號
		local l = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        l:SetText("")
        l:SetHeight(2)
        l:SetWidth(300)
        l:Disable()
		l:SetPoint("TOPLEFT", 40, -238)
	end
	do	--todo: 忽略物品列表相關：輸入文本框*1，顯示忽略列表按鈕*1，還原忽略列表按鈕*1，添加按鈕*1，刪除按鈕*1，帶滾動條的顯示區*1
        -- 标题
        do
            local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmallLeft")
            t:SetText(L["Ignore Items List"])
            t:SetWidth(120)
            t:SetPoint("TOPLEFT", 40, -265)
        end
        do --滚动条显示框
            local t = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
            t:SetPoint("TOPLEFT", 40, -285)
            t:SetWidth(120)
            t:SetHeight(95)

            local edit = CreateFrame("EditBox", nil, t)
            edit.cursorOffset = 0
            edit:SetWidth(120)
            edit:SetHeight(115)
            edit:SetPoint("TOPLEFT", t, 15, 0)
            edit:SetAutoFocus(false)
            edit:EnableMouse(true)
            edit:SetMaxLetters(99999999)
            edit:SetMultiLine(true)
            edit:SetFontObject(GameTooltipText)
            edit:SetScript("OnTextChanged", function(self)
                ScrollingEdit_OnTextChanged(self, t)
            end)
            edit:SetScript("OnCursorChanged", ScrollingEdit_OnCursorChanged)
            edit:SetScript("OnEditFocusGained", function() edit:ClearFocus() end)
            edit:SetScript("OnEscapePressed", function() f:Hide() Addon.Calendar.background:Hide() end)
            edit:Disable()

            edit:SetScript("OnEnter", function()
                if not InCombatLockdown() then
                    edit:Enable()
                end
            end)
            edit:SetScript("OnLeave", function() edit:HighlightText(0, 0) edit:Disable() end)

            self.export = edit

            t:SetScrollChild(edit)
            t:Hide()
        end
        do
            -- 輸入框提示
            local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
            t:SetText(L["Add/Remove Item"])
            t:SetPoint("TOPLEFT", 200, -255)
            t:SetWidth(120)
            -- 忽略物品输入框
            local input = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            input:SetWidth(125)
            input:SetHeight(25)
            input:SetAutoFocus(false)
            input:SetMaxLetters(127)
            input:SetScript("OnEnterPressed", function(self)
                self:ClearFocus()
            end)
            input:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
            input:SetScript("OnEscapePressed", function(self)
                self:SetText("")
                self:ClearFocus()
            end)
            input:SetScript("OnShow", function(self)
                self:SetText("")
                self:ClearFocus()
            end)
            input:SetPoint("TOPLEFT", 215, -282)
            -- 添加、删除、还原按钮
            -- 添加
            local a = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
            a:SetWidth(60)
            a:SetHeight(25)
            a:SetPoint("TOPLEFT", 210, -320)
            a:SetText(L["Add"])
            a:SetScript("OnClick", function()
                if input:GetText() and input:GetText() ~= "" and not Addon.IgnoreItems[input:GetText()] then
                    Addon.IgnoreItems[input:GetText()] = true
                    self.export:GetParent():Show()
                    self.export:Enable()
                    local msg = ""
                    for k in pairs(Addon.IgnoreItems) do
                        msg = msg .. k .. "\n"
                    end
                    if msg == "" then
                        self.export:SetText(L["No Ignore Item"])
                    else
                        self.export:SetText(msg)
                    end
                    self.export:Disable()
                end
            end)
            -- 刪除
            local r = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
            r:SetWidth(60)
            r:SetHeight(25)
            r:SetPoint("LEFT", a, "RIGHT", 10, 0)
            r:SetText(L["Remove"])
            r:SetScript("OnClick", function()
                if input:GetText() and input:GetText() ~= "" and Addon.IgnoreItems[input:GetText()] then
                    Addon.IgnoreItems[input:GetText()] = nil
                    self.export:GetParent():Show()
                    self.export:Enable()
                    local msg = ""
                    for k in pairs(Addon.IgnoreItems) do
                        msg = msg .. k .. "\n"
                    end
                    if msg == "" then
                        self.export:SetText(L["No Ignore Item"])
                    else
                        self.export:SetText(msg)
                    end
                    self.export:Disable()
                end
            end)
            -- 還原
            local d = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
            d:SetWidth(130)
            d:SetHeight(25)
            d:SetPoint("TOPLEFT", 210, -355)
            d:SetText(L["Restore"])
            d:SetScript("OnClick", function()
                Addon.IgnoreItems = {}
                Addon:UpdateTable(Addon.IgnoreItems, Addon.DefaultIgnoreItems)
                self.export:GetParent():Show()
                self.export:Enable()
                local msg = ""
                for k in pairs(Addon.IgnoreItems) do
                    msg = msg .. k .. "\n"
                end
                if msg == "" then
                    self.export:SetText(L["No Ignore Item"])
                else
                    self.export:SetText(msg)
                end
                self.export:Disable()
            end)
        end
        -- 显示忽略列表
        self.export:GetParent():Show()
        self.export:Enable()
        local msg = ""
        for k in pairs(Addon.IgnoreItems) do
            msg = msg .. k .. "\n"
        end
        if msg == "" then
            self.export:SetText(L["No Ignore Item"])
        else
            self.export:SetText(msg)
        end
        self.export:Disable()
	end
	do	-- 分割符號
		local l = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        l:SetText("")
        l:SetHeight(2)
        l:SetWidth(300)
        l:Disable()
		l:SetPoint("TOPLEFT", 40, -392)
	end
    do  -- 更新鏈接
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmallLeft") -- 提示
        t:SetText(L["|cFFFF33CCFeedback & Update: |r"])
        t:SetWidth(300)
        t:SetPoint("TOPLEFT", 40, -405)
        local e = CreateFrame("EditBox", nil, f, "InputBoxTemplate") -- 鏈接
        e:SetWidth(295)
        e:SetHeight(25)
        e:SetAutoFocus(false)
        e:SetMaxLetters(500)
        e:SetScript("OnEnterPressed", function(self)
            self:ClearFocus()
        end)
        e:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
        e:SetScript("OnEscapePressed", function(self)
            self:SetText(L["Feedback & Update Link"])
            self:SetCursorPosition(0)
            self:ClearFocus()
        end)
        e:SetScript("OnShow", function(self)
            self:SetText(L["Feedback & Update Link"])
            self:SetCursorPosition(0)
            self:ClearFocus()
        end)
        e:SetPoint("TOPLEFT", 45, -425)
end
end

--  