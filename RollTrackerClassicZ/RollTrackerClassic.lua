local TOCNAME, RTC = ...
local L = setmetatable({}, {__index = function(_, k) return RTC.L[k] end})

RollTrackerClassic_Addon = RTC
RTC.Version = GetAddOnMetadata(TOCNAME, "Version")
RTC.Title=(GetLocale() == "zhTW") and "骰子記錄" or GetAddOnMetadata(TOCNAME, "Title")

RTC.MAXRARITY = 6
RTC.IconDice = "Interface\\Buttons\\UI-GroupLoot-Dice-Up"
RTC.IconGreed = "Interface\\Buttons\\UI-GroupLoot-Coin-Up"
RTC.IconPass = "Interface\\Buttons\\UI-GroupLoot-Pass-Up"
RTC.IconLoot = "Interface\\GroupFrame\\UI-Group-MasterLooter"
RTC.TxtEscapePicture = "|T%s:0|t"
RTC.TxtEscapeIcon = "|T%s:0:0:0:0:64:64:4:60:4:60|t"

RTC.MSGPREFIX = "RTC: "
RTC.MSGPREFIX_START = "RTC.StartRoll: "
RTC.LOOTTRACKER_MAXLINES = 1000
RTC.CLASSIC_ERA = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
RTC.BCC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC

function RTC.GetPlayerList(unsort)
    local count, start
    local prefix
    local ret = {}
    local retName = {}

    if IsInRaid() then
        prefix = "raid"
        count = MAX_RAID_MEMBERS
        start = 1
    else
        prefix = "party"
        count = MAX_PARTY_MEMBERS
        start = 0
    end

    for index = start, count do
        local guildName, guildRankName
        local id
        if index > 0 then
            id = prefix .. index
        else
            id = "player"
        end
        local name = GetUnitName(id)
        local _, englishClass = UnitClass(id)

        local rank = ""
        if IsInGuild() and UnitIsInMyGuild(id) then
            rank = "<" .. GuildControlGetRankName(C_GuildInfo.GetGuildRankOrder(UnitGUID(id))) .. ">"
        else
            guildName, guildRankName = GetGuildInfo(id)
            if guildName and guildRankName then
                rank = "<" .. guildName .. " / " .. guildRankName .. ">"
            end
        end

        if name ~= nil then

            local entry = {
                ["name"] = name,
                ["rank"] = rank,
                ["class"] = englishClass
            }
            tinsert(ret, entry)
            retName[name] = entry
        end
    end

    if unsort then
        sort(ret, function(a, b)
            return
                (a.class < b.class or (a.class == b.class and a.name < b.name))
        end)
    end

    return ret, retName
end

function RTC.PopupMinimap(frame)
    if not RTC.PopupDynamic:Wipe(frame:GetName()) then return end
    RTC.PopupDynamic:AddItem(L["BtnRoll"], false, RTC.BtnRoll)
    if RTC.DB.MainAndOffSpecMode then
        RTC.PopupDynamic:AddItem(L["BtnOffSpec"], false, RTC.BtnOffSpec)
    end
    RTC.PopupDynamic:AddItem(L["BtnPass"], false, RTC.BtnPass)
    RTC.PopupDynamic:AddItem("", true)
    RTC.PopupDynamic:AddItem(L["BtnRaidRoll"], false, RTC.RaidRoll)
    RTC.PopupDynamic:AddItem("", true)

    RTC.PopupDynamic:AddItem(L["BtnOpen"], false, RTC.ShowWindow, 1)
    if RTC.DB.LootTracker.Enable then
        RTC.PopupDynamic:AddItem(L["BtnOpenLoot"], false, RTC.ShowWindow, 2)
        RTC.PopupDynamic:AddItem(L["BtnCSVExport"], false, RTC.ShowWindow, 3)
    end
    RTC.PopupDynamic:AddItem(L["BtnLootRolls"], false, RTC.LootHistoryShow)
    RTC.PopupDynamic:AddItem("", true)
    RTC.PopupDynamic:AddItem(L["BtnConfig"], false, RTC.Options.Open)
    RTC.PopupDynamic:AddItem(L["PanelAbout"], false, RTC.Options.Open, 4)

    RTC.PopupDynamic:AddItem("", true)

    RTC.PopupDynamic:AddItem(L["CboxLTEnable"], false, RTC.DB.LootTracker,
                             "Enable")

    RTC.PopupDynamic:AddItem("", true)
    RTC.PopupDynamic:AddItem(L["BtnCancel"], false)

    RTC.PopupDynamic:Show(frame, 0, 0)
end

function RTC.GetAutoChannel()
    -- Return an appropriate channel in order of preference: /raid, /p, /s
    local channel
    if IsInRaid() then
        channel = "RAID"
    elseif IsInGroup() then
        channel = "PARTY"
    else
        channel = "SAY"
    end
    return channel
end

function RTC.AddChat(msg)
    if msg ~= nil and msg ~= "" then
        if IsInGroup() or IsInRaid() then
            SendChatMessage(msg, RTC.GetAutoChannel())
        else
            DEFAULT_CHAT_FRAME:AddMessage(msg, RTC.DB.ColorChat.r,
                                          RTC.DB.ColorChat.g,
                                          RTC.DB.ColorChat.b, RTC.DB.ColorChat.a)
        end
    end
end

function RTC.AllowInInstance()
    local _, instanceType = IsInInstance()
    if instanceType == "arena" then
        instanceType = "pvp"
    elseif instanceType == "scenario" then
        instanceType = "party"
    end
    return RTC.DB["NotfiyIn" .. instanceType]
end

-- LootHistory
local function MyLootHistoryFrame_FullUpdate(self)
    local numItems = C_LootHistory.GetNumItems()
    for i = 1, numItems do
        if self.itemFrames[i] and self.itemFrames[i].rollID and
            RTC.LootHistoryCleardRollID[self.itemFrames[i].rollID] then
            self.itemFrames[i]:Hide()
        end
    end
end

function RTC.LootHistoryClear()
    if RTC.LootHistroyFrameHooked == nil then
        RTC.LootHistroyFrameHooked = true
        hooksecurefunc("LootHistoryFrame_FullUpdate", MyLootHistoryFrame_FullUpdate)
    end

    local numItems = C_LootHistory.GetNumItems()

    for i = 1, numItems do
        if LootHistoryFrame.itemFrames[i] then
            RTC.LootHistoryCleardRollID[LootHistoryFrame.itemFrames[i].rollID] =
                true
        end
    end

    LootHistoryFrame_FullUpdate(LootHistoryFrame)
end

function RTC.LootHistoryShow(rollID)
    if not LootHistoryFrame:IsShown() or rollID == nil then
        ToggleLootHistoryFrame()
    end
    if rollID then
        LootHistoryFrame.expandedRolls[rollID] = true
        LootHistoryFrame_FullUpdate(LootHistoryFrame)
    end
end

function RTC.LootHistoryHide()
    RTC.LootHistoryCountHandle = 0
    wipe(RTC.LootHistoryHandle)
    LootHistoryFrame_CollapseAll(LootHistoryFrame)
end

-- GUI

function RTC.ResetWindow()
    RollTrackerClassicMainWindow:ClearAllPoints()
    RollTrackerClassicMainWindow:SetPoint("Center", UIParent, "Center", 0, 0)
    RollTrackerClassicMainWindow:SetWidth(200)
    RollTrackerClassicMainWindow:SetHeight(200)
    RTC.SaveAnchors()
    RTC.ShowWindow(1)
end

function RTC.ToggleWindow(id)
    if RollTrackerClassicMainWindow:IsVisible() then
        RTC.HideWindow()
    else
        RTC.ShowWindow(id)
    end
end

function RTC.MenuButtonClick(self, button)
    if button == "LeftButton" then
        if IsShiftKeyDown() then
            RTC.LootHistoryShow()
        else
            RTC.ToggleWindow()
        end

    else
        if self.isMinimapButton then
            RTC.PopupMinimap(self.button)
        else
            RTC.PopupMinimap(self)
        end
    end
end

function RTC.MenuToolTip(self)
    self:AddLine(RTC.Title)
    self:AddLine(L["MsgTooltip"])
end

function RTC.ResizeButtons()
    local w = RollTrackerClassicFrameHelperButton:GetWidth()
    if RTC.DB.MainAndOffSpecMode then
        RollTrackerClassicFrameRollButton:SetWidth(w / 3)
        RollTrackerClassicFramePassButton:SetWidth(w / 3)
        RollTrackerClassicFrameOffSpecButton:Show()
    else
        RollTrackerClassicFrameRollButton:SetWidth(w / 2)
        RollTrackerClassicFramePassButton:SetWidth(w / 2)
        RollTrackerClassicFrameOffSpecButton:Hide()
    end

    if RTC.DB.ShowNotRolled then
        RollTrackerClassicFrameAnnounceButton:SetWidth(w / 3)
        RollTrackerClassicFrameClearButton:SetWidth(w / 3)
        RollTrackerClassicFrameNotRolledButton:Show()
    else
        RollTrackerClassicFrameAnnounceButton:SetWidth(w / 2)
        RollTrackerClassicFrameClearButton:SetWidth(w / 2)
        RollTrackerClassicFrameNotRolledButton:Hide()
    end
end

function RTC.BtnClose()
    RTC.HideWindow()
    if RTC.DB.ClearOnClose then RTC.ClearRolls() end
end

function RTC.BtnRoll() RandomRoll(1, 100) end

function RTC.BtnOffSpec()
    RandomRoll(1, 99)
end

function RTC.BtnPass() RTC.AddChat(L.pass) end

function RTC.BtnClearRolls()
    if #RTC.rollArray > 0 then
        RTC.ClearRolls()
        if RTC.DB.CloseOnClear then RTC.HideWindow() end
    elseif #RTC.rollUndoArray > 0 then
        RTC.UndoRolls()
    end
end

function RTC.BtnAnnounce()
    RTC.RollAnnounce()
    if RTC.DB.ClearOnAnnounce then RTC.ClearRolls() end
    if RTC.DB.CloseOnAnnounce then RTC.HideWindow() end
end

function RTC.BtnAnnounceDown(button)
    if button == "RightButton" then RTC.StartCountdown() end
end

function RTC.BtnNotRolled() RTC.NotRolled() end

function RTC.BtnSettings()
    if RTC.Tool.GetSelectedTab(RollTrackerClassicMainWindow) == 1 then
        RTC.Options.Open()
    else
        RTC.Options.Open(2)
    end
end

function RTC.BtnLootClear()
    if #RollTrackerClassicZLoot > 0 then
        RTC.ClearLoot()
    elseif #RTC.lootUndo > 0 then
        RTC.UndoLoot()
    end
end

function RTC.SaveAnchors()
    RTC.DB.X = RollTrackerClassicMainWindow:GetLeft()
    RTC.DB.Y = RollTrackerClassicMainWindow:GetTop()
    RTC.DB.Width = RollTrackerClassicMainWindow:GetWidth()
    RTC.DB.Height = RollTrackerClassicMainWindow:GetHeight()
end

function RTC.ShowWindow(id)
    -- workaround for a strange bug
    if RollTrackerClassicMainWindow.Tabs then
        for i = 1, RollTrackerClassicMainWindow.numTabs do
            local child = RollTrackerClassicMainWindow.Tabs[i].content
            child:SetParent(RollTrackerClassicMainWindow)
            child:ClearAllPoints()
            child:SetPoint("TOPLEFT", 8, -30)
            child:SetPoint("BOTTOMRIGHT", -8, 8)
        end
    end

    RollTrackerClassicMainWindow:Show()
    RTC.UpdateRollList()
    RTC.UpdateLootList()
    RTC.Tool.SelectTab(RollTrackerClassicMainWindow, id)
end

function RTC.HideWindow() RollTrackerClassicMainWindow:Hide() end

-- Options Panel
function RTC.OptionsUpdate()
    RTC.LootListInit()
    RTC.CSVListInit()
    RTC.UpdateRollList()
    RTC.UpdateLootList()
    RTC.ResizeButtons()
    RTC.MinimapButton.UpdatePosition()

    local list = RTC.Tool.Split(RTC.DB.LootTracker.WhiteList)
    RTC.whitelist = {}
    for _, value in ipairs(list) do RTC.whitelist[value] = true end

    if RTC.DB.LootTracker.Enable then
        RTC.Tool.TabShow(RollTrackerClassicMainWindow)
    else
        RTC.Tool.SelectTab(RollTrackerClassicMainWindow, 1)
        RTC.Tool.TabHide(RollTrackerClassicMainWindow)
    end
end

local function RTCO_CheckBox(Var, Init)
    RTC.Options.AddCheckBox(RTC.DB, Var, Init, L["Cbox" .. Var])
end

local function RTCO_CheckBoxLT(Var, Init)
    RTC.Options.AddCheckBox(RTC.DB.LootTracker, Var, Init, L["CboxLT" .. Var])
end

function RTC.OptionsInit()
    RTC.Options.Init(function() -- doOk
        RTC.Options.DoOk()
        RTC.OptionsUpdate()
    end, function() -- doCancel
        RTC.Options.DoCancel()
        RTC.OptionsUpdate()
    end, function() -- doDefault
        RTC.Options.DoDefault()
        RTC.DB.Minimap.position = 50
        RTC.ResetWindow()

        RTC.MinimapButton.UpdatePosition()

        RTC.OptionsUpdate()
    end)

    RTC.Options.SetScale(0.85)
    RTC.Options.AddPanel(RTC.Title, nil, true)
    RTC.Options.AddVersion('|cff00c0ff' .. RTC.Version .. "|r")

    -- RTC.Options.AddCategory( L["HeaderSettings"] )
    -- RTC.Options.Indent()

    RTC.Options.AddCheckBox(RTC.DB.Minimap, "visible", true,
                            L["Cboxshowminimapbutton"])
    RTC.Options.AddCheckBox(RTC.DB.Minimap, "lock", false,
                            L["CboxLockMinimapButton"])
    RTC.Options.AddCheckBox(RTC.DB.Minimap, "lockDistance", false,
                            L["CboxLockMinimapButtonDistance"])
    RTC.Options.AddSpace()
    RTCO_CheckBox("NotfiyInnone", true)
    RTCO_CheckBox("NotfiyInpvp", false)
    RTCO_CheckBox("NotfiyInparty", true)
    RTCO_CheckBox("NotfiyInraid", true)

    RTC.Options.AddSpace()
    RTCO_CheckBox("ClearOnClose", true)
    RTCO_CheckBox("ClearOnAnnounce", true)
    RTCO_CheckBox("CloseOnAnnounce", true)
    RTCO_CheckBox("CloseOnClear", true)
    RTC.Options.AddSpace()
    RTCO_CheckBox("IgnoreDouble", false)
    RTCO_CheckBox("RejectOutBounds", false)
    RTCO_CheckBox("AnnounceIgnoreDouble", true)
    RTCO_CheckBox("AnnounceRejectOutBounds", false)
    RTCO_CheckBox("PromoteRolls", false)
    RTCO_CheckBox("AutoCountdownWithItem", false)
    RTC.Options.AddSpace()
    RTCO_CheckBox("MainAndOffSpecMode", false)
    RTCO_CheckBox("ShowNotRolled", true)
    RTC.Options.AddSpace()
    RTCO_CheckBox("ClearOnStart", false)
    RTCO_CheckBox("OpenOnStart", false)
    RTC.Options.AddSpace()
    RTCO_CheckBox("ColorName", true)
    RTCO_CheckBox("ShowClassIcon", true)
    RTCO_CheckBox("ShowGuildRank", true)
    RTC.Options.AddSpace()
    RTCO_CheckBox("AutmaticAnnounce", false)
    RTC.Options.AddEditBox(RTC.DB, "AnnounceList", 1, L["EdtAnnounceList"], 50,
                           300, true)
    RTC.Options.AddSpace()
    RTC.Options.AddText(L["MsgStartCD"])
    RTC.Options.AddSpace(0.2)
    RTC.Options.AddEditBox(RTC.DB, "DefaultCD", 5, L["EdtDefaultCD"], 50, 300,
                           true)
    RTC.Options.AddEditBox(RTC.DB, "CDRefresh", 3, L["EdtCDRefresh"], 50, 300,
                           true)

    RTC.Options.AddSpace()
    RTC.Options.AddText(L["BtnLootRolls"])
    RTC.Options.AddSpace(0.2)
    RTCO_CheckBox("AutoLootRolls", true)
    RTCO_CheckBox("AutoCloseLootRolls", true)
    RTC.Options.AddEditBox(RTC.DB, "AutoCloseDelay", 5, L["EdtAutoCloseDelay"],
                           50, 300, true)
    RTC.Options.AddSpace()
    RTC.Options.AddColorButton(RTC.DB, "ColorNormal",
                               {a = 1, r = 1, g = 1, b = 1}, L["BtnColorNormal"])
    RTC.Options.AddColorButton(RTC.DB, "ColorCheat",
                               {a = 1, r = 1, g = .8, b = .8},
                               L["BtnColorCheat"])
    RTC.Options.AddColorButton(RTC.DB, "ColorGuild",
                               {a = 1, r = .2, g = 1, b = .2},
                               L["BtnColorGuild"])
    RTC.Options.AddColorButton(RTC.DB, "ColorInfo",
                               {a = 1, r = .6, g = .6, b = .6},
                               L["BtnColorInfo"])
    RTC.Options.AddColorButton(RTC.DB, "ColorChat",
                               {a = 1, r = 1, g = 1, b = 1}, L["BtnColorChat"])
    RTC.Options.AddColorButton(RTC.DB, "ColorScroll",
                               {a = 1, r = .8, g = .8, b = .8},
                               L["BtnColorScroll"])

    RTC.Options.AddSpace()
    RTCO_CheckBox("OnDebug", false)

    -- loot tracker
    RTC.Options.AddPanel(L["PanelLootTracker"], false, true)

    RTC.Options.AddCategory(L["HeaderSettings"])
    RTC.Options.Indent()
    RTCO_CheckBoxLT("Enable", false)
    RTC.Options.AddSpace()
    RTCO_CheckBoxLT("SmallFont", true)
    RTCO_CheckBoxLT("ShortMessage", false)
    RTCO_CheckBoxLT("ShowIcon", true)
    RTC.Options.AddSpace()
    RTCO_CheckBoxLT("TrackSolo", true)
    RTCO_CheckBoxLT("TrackGroup", true)
    RTCO_CheckBoxLT("TrackSRaid", true)
    RTCO_CheckBoxLT("TrackBRaid", true)
    RTC.Options.AddSpace()
    -- lib:AddEditBox(DB,Var,Init,TXTLeft,width,widthLeft,onlynumbers,tooltip,suggestion)
    RTC.Options.AddEditBox(RTC.DB.LootTracker, "NbLoots", 1000, L["EdtNbLoots"],
                           50, 200, true)

    RTC.Options.AddEditBox(RTC.DB.LootTracker, "WhiteList", "",
                           L["EdtWhiteList"], 400, 200)

    RTC.Options.Indent(-10)

    RTC.Options.AddCategory(L["HeaderRarity"])
    RTC.Options.Indent(10)
    for i = 0, tonumber(RTC.MAXRARITY) do
        RTC.Options.AddCheckBox(RTC.DB.LootTracker.Rarity, i, i >= 2,
                                ITEM_QUALITY_COLORS[i].hex ..
                                    _G["ITEM_QUALITY" .. i .. "_DESC"] .. "|r")
    end
    RTC.Options.Indent(-10)

    RTC.Options.AddCategory(L["HeaderItemType"])
    RTC.Options.Indent()
    RTC.Options.AddText(L["TxtItemType"])
    local NumberOfItemClasses = _G.NUM_LE_ITEM_CLASSS or 19
    for i = 0, NumberOfItemClasses - 1 do
        local txt = GetItemClassInfo(i)
        if txt ~= nil and string.find(txt, "OBSOLETE") == nil then
            RTC.Options.AddCheckBox(RTC.DB.LootTracker.ItemType, i, false, txt)
        end
    end
    RTC.Options.Indent(-10)

    RTC.Options.AddCategory(L["HeaderCSV"])
    RTC.Options.Indent(10)
    RTC.Options.AddText(L["TxtCSVJokersTitle"])
    RTC.Options.AddText(L["TxtCSVJokers"])
    RTC.Options.AddText(L["TxtCSVJokers2"])
    RTC.Options.AddSpace()
    -- lib:AddEditBox(DB,Var,Init,TXTLeft,width,widthLeft,onlynumbers,tooltip,suggestion)
    RTC.Options.AddEditBox(RTC.DB.LootTracker, "CSVexport",
                           '%yy%-%mm%-%dd%;%HH%:%MM%;%name%;%iid%;%icount%', "",
                           600)

    RTC.Options.Indent(-10)

    -- localization
    RTC.Options.SetScale(0.85)
    RTC.Options.AddPanel(L["HeaderCustomLocales"], false, true)
    RTC.Options.AddText(L["MsgLocalRestart"])
    RTC.Options.AddSpace()

    local locales = getmetatable(L).__index
    local t = {}
    for key in pairs(locales) do table.insert(t, key) end
    table.sort(t)
    for _, key in ipairs(t) do
        local col = L[key] ~= locales[key] and "|cffffffff" or "|cffff4040"
        local txt = L[key .. "_org"] ~= "[" .. key .. "_org]" and
                        L[key .. "_org"] or L[key]

        RTC.Options.AddEditBox(RTC.DB.CustomLocales, key, "",
                               col .. "[" .. key .. "]", 450, 200, false,
                               locales[key], txt)
    end

    -- About
    local function SlashText(txt) RTC.Options.AddText(txt) end

    RTC.Options.AddPanel(L["PanelAbout"])

    RTC.Options.AddCategory(
        "|cFFFF1C1C" .. GetAddOnMetadata(TOCNAME, "Title") .. " " ..
            GetAddOnMetadata(TOCNAME, "Version") .. " by " ..
            GetAddOnMetadata(TOCNAME, "Author"))
    RTC.Options.Indent(10)
    RTC.Options.AddText(GetAddOnMetadata(TOCNAME, "Notes"))
    RTC.Options.Indent(-10)

    RTC.Options.AddCategory(L["HeaderInfo"])
    RTC.Options.Indent(10)
    RTC.Options.AddText(L["AboutInfo"], -20)
    RTC.Options.Indent(-10)

    RTC.Options.AddCategory(L["HeaderUsage"])
    RTC.Options.Indent(10)
    RTC.Options.AddText(L["AboutUsage"], -20)
    RTC.Options.Indent(-10)

    RTC.Options.AddCategory(L["HeaderSlashCommand"])
    RTC.Options.Indent(10)
    RTC.Options.AddText(L["AboutSlashCommand"], -20)
    RTC.Tool.PrintSlashCommand(nil, nil, SlashText)
    RTC.Options.Indent(-10)

    RTC.Options.AddCategory(L["HeaderCredits"])
    RTC.Options.Indent(10)
    RTC.Options.AddText(L["AboutCredits"], -20)
    RTC.Options.Indent(-10)
end

-- notesystem
local function hooked_createTooltip(self)
    local name, unit = self:GetUnit()
    if (name) and (unit) and UnitIsPlayer(unit) and RTC.Notes[name] then
        self:AddLine(RTC.Notes[name])
        self:Show()
    end
end

local EditEntry
function RTC.EditNote(entry)
    StaticPopup_Hide("RollTrackerClassic_AddNote")
    if entry then
        EditEntry = entry
        StaticPopup_Show("RollTrackerClassic_AddNote", entry)
    end
end

function RTC.notes_clear()
    wipe(RTC.Notes)
    DEFAULT_CHAT_FRAME:AddMessage(RTC.MSGPREFIX .. L["MsgNotesCleared"],
                                  RTC.DB.ColorChat.r, RTC.DB.ColorChat.g,
                                  RTC.DB.ColorChat.b, RTC.DB.ColorChat.a)
end

function RTC.notes_list()
    local txt = ""
    for name, note in pairs(RTC.Notes) do
        if note and note ~= "" and name then
            txt = name .. " " .. note .. "|n" .. txt
        end
    end
    if txt ~= "" then RTC.Tool.CopyPast(txt) end
end

local function EnterHyperlink(_, link)
    local part = RTC.Tool.Split(link, ":")

    if part[1] == "player" then
        GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
        GameTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
        GameTooltip:ClearLines()

        local guid = UnitGUID(part[2])
        if guid then
            GameTooltip:SetHyperlink("|Hunit:" .. guid .. "|h[" .. part[2] ..
                                         "]|h")
        else
            GameTooltip:AddLine(part[2])
            GameTooltip:AddLine(RTC.Notes[part[2]] or "")
        end

        if RTC.DB.LootTracker.Enable then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(L.MsgPastLoots)
            local count = 0
            for i = #RollTrackerClassicZLoot, 1, -1 do
                local loot = RollTrackerClassicZLoot[i]
                if loot.name == part[2] then
                    RTC.LootList_AddItem(loot, GameTooltip)
                    count = count + 1
                    if count == 10 then break end
                end
            end
        end
        GameTooltip:Show()
    elseif part[1] == "spell" or part[1] == "unit" or part[1] == "item" or
        part[1] == "enchant" or part[1] == "player" or part[1] == "quest" or
        part[1] == "trade" then
        GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
        GameTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
        GameTooltip:ClearLines()
        GameTooltip:SetHyperlink(link)
        GameTooltip:Show()
    end
end

local function LeaveHyperlink() GameTooltip:Hide() end

local function ClickHyperlink(_, link)
    local part = RTC.Tool.Split(link, ":")
    if part[1] == "player" then RTC.EditNote(part[2]) end
end

local function initHyperlink(frame)
    frame:SetHyperlinksEnabled(true);
    frame:SetScript("OnHyperlinkEnter", EnterHyperlink)
    frame:SetScript("OnHyperlinkLeave", LeaveHyperlink)
    frame:SetScript("OnHyperlinkClick", ClickHyperlink)

    if StaticPopupDialogs["RollTrackerClassic_AddNote"] == nil then
        GameTooltip:HookScript("OnTooltipSetUnit", hooked_createTooltip)

        StaticPopupDialogs["RollTrackerClassic_AddNote"] = {
            text = L.MsgAddNote,
            button1 = ACCEPT,
            button2 = CANCEL,
            hasEditBox = 1,
            maxLetters = 48,
            countInvisibleLetters = true,
            editBoxWidth = 350,
            OnAccept = function(self)
                RTC.Notes[EditEntry] = self.editBox:GetText()
            end,
            OnShow = function(self)
                self.editBox:SetText(RTC.Notes[EditEntry] or "");
                self.editBox:SetFocus();
            end,
            OnHide = function(self)
                ChatEdit_FocusActiveWindow();
                self.editBox:SetText("");
            end,
            EditBoxOnEnterPressed = function(self)
                local parent = self:GetParent();
                RTC.Notes[EditEntry] = parent.editBox:GetText()
                parent:Hide();
            end,
            EditBoxOnEscapePressed = function(self)
                self:GetParent():Hide();
            end,
            timeout = 0,
            exclusive = 1,
            whileDead = 1,
            hideOnEscape = 1
        }
    end
end

-- Init
function RTC.Init()
    L = RTC.GetLocale()

    RTC.CSV_Transfer_Table = {}

    RTC.rollArray = {}
    RTC.rollNames = {}
    RTC.rollUndoArray = {}
    RTC.rollUndoNames = {}
    RTC.lootUndo = {}
    RTC.lastItem = nil

    RTC.LootHistoryCloseTimer = 0
    RTC.LootHistoryCountHandle = 0
    RTC.LootHistoryHandle = {}
    RTC.LootHistoryCleardRollID = {}

    -- using strings from GlobalStrings.lua
    RTC.PatternRoll = RTC.Tool.CreatePattern(RANDOM_ROLL_RESULT)
    RTC.PatternLoot = RTC.Tool.CreatePattern(LOOT_ITEM, true)
    RTC.PatternLootOwn = RTC.Tool.CreatePattern(LOOT_ITEM_SELF, true)

    -- settings
    if not RollTrackerClassicZDB then RollTrackerClassicZDB = {} end -- fresh DB
    RTC.DB = RollTrackerClassicZDB
    if not RTC.DB.Minimap then RTC.DB.Minimap = {} end
    if not RTC.DB.CustomLocales then RTC.DB.CustomLocales = {} end
    if not RollTrackerClassicZLoot then RollTrackerClassicZLoot = {} end
    if not RTC.DB.LootTracker then RTC.DB.LootTracker = {} end
    if not RTC.DB.LootTracker.Rarity then RTC.DB.LootTracker.Rarity = {} end
    if not RTC.DB.LootTracker.ItemType then RTC.DB.LootTracker.ItemType = {} end

    local Realm = GetRealmName()
    if not RTC.DB.Notes then RTC.DB.Notes = {} end
    if not RTC.DB.Notes[Realm] then RTC.DB.Notes[Realm] = {} end
    RTC.Notes = RTC.DB.Notes[Realm]

    local x, y, w, h = RTC.DB.X, RTC.DB.Y, RTC.DB.Width, RTC.DB.Height
    if not x or not y or not w or not h then
        RTC.SaveAnchors()
    else
        RollTrackerClassicMainWindow:ClearAllPoints()
        RollTrackerClassicMainWindow:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
        RollTrackerClassicMainWindow:SetWidth(w)
        RollTrackerClassicMainWindow:SetHeight(h)
    end

    -- Language
    RollTrackerClassicMainWindowTitle:SetText(string.format(
                                                  RTC.TxtEscapePicture,
                                                  RTC.IconDice) .. RTC.Title)

    RollTrackerClassicFrameRollButton:SetText(string.format(
                                                  RTC.TxtEscapePicture,
                                                  RTC.IconDice) .. L["BtnRoll"])
    RollTrackerClassicFrameOffSpecButton:SetText(string.format(
                                                   RTC.TxtEscapePicture,
                                                   RTC.IconGreed) ..
                                                   L["BtnOffSpec"])
    RollTrackerClassicFramePassButton:SetText(string.format(
                                                  RTC.TxtEscapePicture,
                                                  RTC.IconPass) .. L["BtnPass"])

    -- RollTrackerClassicFrameClearButton:SetText(L["BtnClear"])
    RollTrackerClassicFrameAnnounceButton:SetText(L["BtnAnnounce"])
    RollTrackerClassicFrameNotRolledButton:SetText(L["BtnNotRolled"])
    RollTrackerClassicFrameHelperButton:Hide()
    RTC.ResizeButtons()

    RollTrackerClassicZLootFrameClearButton:SetText(L["BtnClear"])

    RollTrackerClassicCSVFrameExportButton:SetText(L["BtnCSVExport"])

    -- slash command
    local function doDBSet(DB, var, value)
        if value == nil then
            DB[var] = not DB[var]
        elseif tContains({"true", "1", "enable"}, value) then
            DB[var] = true
        elseif tContains({"false", "0", "disable"}, value) then
            DB[var] = false
        end
        DEFAULT_CHAT_FRAME:AddMessage(
            RTC.MSGPREFIX .. "Set " .. var .. " to " .. tostring(DB[var]),
            RTC.DB.ColorChat.r, RTC.DB.ColorChat.g, RTC.DB.ColorChat.b,
            RTC.DB.ColorChat.a)
        RTC.OptionsUpdate()
    end

    RTC.Tool.SlashCommand({"/rtc", "/rolltracker", "/rolltrackerclassic"}, {
        {
            "clear", "", {
                {"rolls", L["SlashClearRolls"], RTC.ClearRolls, true},
                {"loot", L["SlashClearLoot"], RTC.ClearLoot, true},
                {"lootrolls", L["SlashClearLootRolls"], RTC.LootHistoryClear},
                {"notes", L["SlashClearNotes"], RTC.notes_clear}
            }
        }, {
            "undo", "", {
                {"rolls", L["SlashUndoRolls"], RTC.UndoRolls, true},
                {"loot", L["SlashUndoLoot"], RTC.UndoLoot, true}
            }
        }, {"announce", "", {{"%", L["SlashAnnounce"], RTC.RollAnnounce}}},
        {"notrolled", L["SlashNotRolled"], RTC.NotRolled},
        {"close", L["SlashClose"], RTC.HideWindow},
        {"reset", L["SlashReset"], RTC.ResetWindow},
        {{"config", "setup", "options"}, L["SlashConfig"], RTC.Options.Open, 1},
        {"about", L["SlashAbout"], RTC.Options.Open, 4},
        {"debug", "", {{"%", "", RTC.AddRoll}}},
        {"notes", L["SlashNotes"], RTC.notes_list},
        {"start", "", {{"%", L["SlashStart"], RTC.StartRoll}}}, {
            {"countdown", "count", "cd"}, "",
            {{"%", L["SlashCountdown"], RTC.StartCountdown}}
        }, {
            "loottracker", "",
            {{"%", L["CboxLTEnable"], doDBSet, RTC.DB.LootTracker, "Enable"}}
        }, {"export", L["BtnCSVExport"], RTC.BtnExport}, {
            "raidroll", "", {
                {"list", L["SlashRaidRollList"], RTC.RaidRollList},
                {"", L["SlashRaidRoll"], RTC.RaidRoll}
            }
        }, {"", L["SlashOpen"], RTC.ShowWindow}
    })

    -- Options
    RTC.OptionsInit()

    -- gui
    RTC.MinimapButton.Init(RTC.DB.Minimap, RTC.IconDice, RTC.MenuButtonClick,
                           RTC.Title .. "\n" .. L["MsgTooltip"])

    RTC.Tool.EnableSize(RollTrackerClassicMainWindow, 8, nil, RTC.SaveAnchors)
    RTC.Tool.EnableMoving(RollTrackerClassicMainWindow, RTC.SaveAnchors)

    RTC.Tool.AddTab(RollTrackerClassicMainWindow, L["TabRoll"],
                    RollTrackerClassicFrame)
    RTC.Tool.AddTab(RollTrackerClassicMainWindow, L["TabLoot"],
                    RollTrackerClassicZLootFrame)
    RTC.Tool.AddTab(RollTrackerClassicMainWindow, L["TabCSV"],
                    RollTrackerClassicCSVFrame)

    RTC.PopupDynamic = RTC.Tool.CreatePopup(RTC.OptionsUpdate)

    RTC.Tool.OnUpdate(RTC.Timers)

    hooksecurefunc(LootHistoryFrame, "Hide", RTC.LootHistoryHide)

    initHyperlink(RollTrackerRollText)
    initHyperlink(RollTrackerClassicZLootFrame_MessageFrame)
    RTC.OptionsUpdate()
end

local lastCountDown
function RTC.Timers()
    if RTC.LootHistoryCloseTimer > 0 and RTC.LootHistoryCloseTimer < time() and
        RTC.LootHistoryCountHandle <= 0 then
        if RTC.DB.AutoCloseLootRolls then
            LootHistoryFrame_CollapseAll(LootHistoryFrame)
            LootHistoryFrame:Hide()
        end
        RTC.LootHistoryCloseTimer = 0
        RTC.LootHistoryCountHandle = 0
    end

    if RTC.Countdown ~= nil then
        local sec = math.floor(RTC.Countdown - GetTime() + 0.999)
        if sec > 5 then sec = math.floor((sec + 9) / 10) * 10 end

        if sec ~= lastCountDown then
            lastCountDown = sec
            if sec > 0 then
                RTC.AddChat(RTC.MSGPREFIX .. sec)
            else
                RTC.RollAnnounce()
                RTC.lastItem = nil
                if RTC.DB.ClearOnAnnounce then RTC.ClearRolls() end
                if RTC.DB.CloseOnAnnounce then RTC.HideWindow() end
                RTC.Countdown = nil
                lastCountDown = nil
            end
        end
    end
end

function RTC.StartCountdown(x)
    local ti = GetTime() + (x or RTC.DB.DefaultCD)
    if RTC.Countdown == nil or RTC.Countdown < ti then RTC.Countdown = ti end
end

function RTC.StopCountdown() RTC.Countdown = nil end

-- Event handler

local function Event_ADDON_LOADED(arg1)
    if arg1 == TOCNAME then RTC.Init() end
    RTC.Tool.AddDataBrocker(RTC.IconDice, RTC.MenuButtonClick, RTC.MenuToolTip)
end

local function Event_START_LOOT_ROLL(arg1, _, arg3)
    -- START_LOOT_ROLL: rollID, rollTime, lootHandle
    if RTC.DB.AutoLootRolls then RTC.LootHistoryShow(arg1) end
    if arg3 then -- loothandle CAN be nil
        RTC.LootHistoryHandle[arg3] = true
        RTC.LootHistoryCountHandle = RTC.LootHistoryCountHandle + 1
    end
    RTC.LootHistoryCloseTimer = 0
end

local function Event_LOOT_ROLLS_COMPLETE(arg1)
    -- LOOT_ROLLS_COMPLETE: lootHandle
    if RTC.LootHistoryHandle[arg1] == true then
        RTC.LootHistoryHandle[arg1] = nil
        RTC.LootHistoryCountHandle = RTC.LootHistoryCountHandle - 1
        if RTC.LootHistoryCountHandle <= 0 then
            RTC.LootHistoryCountHandle = 0
            wipe(RTC.LootHistoryHandle)
            RTC.LootHistoryCloseTimer = time() + (RTC.DB.AutoCloseDelay or 5)
        end
    end
end

local function Event_CHAT_MSG_LOOT(arg1)
    -- %s receives loot : %s|Hitem :%d :%d :%d :%d|h[%s]|h%s.
    local name, item = string.match(arg1, RTC.PatternLoot)
    if not name or not item then
        name = GetUnitName("player")
        item = string.match(arg1, RTC.PatternLootOwn)
    end

    if name ~= nil and item ~= nil then RTC.AddLoot(name, item) end
end

local function Event_CHAT_MSG_SYSTEM(arg1)
    for name, roll, low, high in string.gmatch(arg1, RTC.PatternRoll) do
        -- print(".."..name.." "..roll.." "..low.." "..high)
        RTC.AddRoll(name, roll, low, high)
    end
end

local function Event_Generic_CHAT_MSG(msg, name)
    local dopass = false
    if RTC.PassTags[msg] then dopass = true end
    if dopass then
        name = RTC.Tool.Split(name, "-")[1]
        RTC.AddRoll(name, "0", "1", "100")
    end

    if string.sub(msg, 1, string.len(RTC.MSGPREFIX_START)) ==
        RTC.MSGPREFIX_START then
        if RTC.DB.ClearOnStart then RTC.ClearRolls() end
        if RTC.DB.OpenOnStart then RTC.ShowWindow(1) end
    end
end

local BACKDROP_TUTORIAL_16_16 = BACKDROP_TUTORIAL_16_16 or {
    bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileEdge = true,
    tileSize = 16,
    edgeSize = 16,
    insets = {left = 3, right = 5, top = 3, bottom = 5}
}
function RTC.OnLoad(self)
    -- print("rtc-onload")
    if Mixin and BackdropTemplateMixin then
        Mixin(self, BackdropTemplateMixin)
    end
    self:SetBackdrop(BACKDROP_TUTORIAL_16_16)
    if self.SetResizeBounds then
        self:SetResizeBounds(194, 170)
    else
        self:SetMinResize(194, 170)
    end

    RTC.Tool.RegisterEvent("ADDON_LOADED", Event_ADDON_LOADED)
    RTC.Tool.RegisterEvent("START_LOOT_ROLL", Event_START_LOOT_ROLL)
    RTC.Tool.RegisterEvent("LOOT_ROLLS_COMPLETE", Event_LOOT_ROLLS_COMPLETE)

    RTC.Tool.RegisterEvent("CHAT_MSG_LOOT", Event_CHAT_MSG_LOOT)
    RTC.Tool.RegisterEvent("CHAT_MSG_SYSTEM", Event_CHAT_MSG_SYSTEM)

    RTC.Tool.RegisterEvent("CHAT_MSG_PARTY", Event_Generic_CHAT_MSG)
    RTC.Tool.RegisterEvent("CHAT_MSG_PARTY_LEADER", Event_Generic_CHAT_MSG)
    RTC.Tool.RegisterEvent("CHAT_MSG_RAID", Event_Generic_CHAT_MSG)
    RTC.Tool.RegisterEvent("CHAT_MSG_RAID_LEADER", Event_Generic_CHAT_MSG)
end

-- Roll

function RTC.RaidRoll()
    RTC.IsRaidRoll = RTC.GetPlayerList(true)
    RandomRoll(1, #RTC.IsRaidRoll)
end

function RTC.RaidRollList()
    local party = RTC.GetPlayerList(true)
    for i, entry in ipairs(party) do RTC.AddChat(i .. ". " .. entry.name) end
end

function RTC.AddRoll(name, roll, low, high)
    local ok = false
    if name == "*" then
        for i = 1, 5 do
            RTC.AddRoll("rndmainSpec" .. i, tostring(random(1, 100)), "1", "100")
            RTC.AddRoll("rndoffSpec" .. i, tostring(random(1, 99)), "1", "99")
        end
        return
    end

    if RTC.IsRaidRoll and low == "1" and tonumber(high) == #RTC.IsRaidRoll and
        name == GetUnitName("player") then
        roll = tonumber(roll)
        RTC.AddChat(RTC.MSGPREFIX ..
                        string.format(L["MsgRaidRoll"],
                                      RTC.IsRaidRoll[roll].name, roll))
        RTC.IsRaidRoll = nil
        return
    end

    if not RTC.AllowInInstance() then return end

    -- check for rerolls. >1 if rolled before
    if RTC.DB.MainAndOffSpecMode then
        if (RTC.DB.IgnoreDouble == false or RTC.rollNames[name] == nil or
            RTC.rollNames[name] == 0) and
            ((low == "1" and high == "99") or (low == "1" and high == "100")) then
            ok = true
        end
    else
        if (RTC.DB.IgnoreDouble == false or RTC.rollNames[name] == nil or
            RTC.rollNames[name] == 0) and
            (RTC.DB.RejectOutBounds == false or (low == "1" and high == "100")) then
            ok = true
        end
    end

    if ok then

        if RTC.DB.PromoteRolls and tonumber(roll) == 69 then roll = "101" end

        RTC.rollNames[name] = RTC.rollNames[name] and RTC.rollNames[name] + 1 or
                                  1
        table.insert(RTC.rollArray, {
            Name = name,
            Roll = tonumber(roll),
            Low = tonumber(low),
            High = tonumber(high),
            Count = RTC.rollNames[name]
        })

        RTC.ShowWindow(1)

        if RTC.allRolled and RTC.DB.AutmaticAnnounce then
            RTC.BtnAnnounce()
        elseif RTC.Countdown then
            RTC.StartCountdown(RTC.DB.CDRefresh)
        end
    else
        DEFAULT_CHAT_FRAME:AddMessage(string.format(RTC.MSGPREFIX ..
                                                        L["MsgCheat"], name,
                                                    roll, low, high),
                                      RTC.DB.ColorChat.r, RTC.DB.ColorChat.g,
                                      RTC.DB.ColorChat.b, RTC.DB.ColorChat.a)
    end
end

function RTC.SortRolls(a, b) return a.Roll < b.Roll end

function RTC.SortRollsRev(a, b) return a.Roll > b.Roll end

function RTC.FormatRollText(roll, _, partyName)
    local colorTied = RTC.Tool.RGBtoEscape(RTC.DB.ColorNormal)
    local colorCheat =
        ((roll.Low ~= 1 or roll.High ~= 100) or (roll.Count > 1)) and
            RTC.Tool.RGBtoEscape(RTC.DB.ColorCheat) or colorTied
    local txtRange = (roll.Low ~= 1 or roll.High ~= 100) and
                         format(" (%d-%d)", roll.Low, roll.High) or ""

    local colorName
    local iconClass
    local colorRank = RTC.Tool.RGBtoEscape(RTC.DB.ColorGuild)
    local rank = ""

    if partyName[roll.Name] and partyName[roll.Name].class then
        colorName = "|c" ..
                        RAID_CLASS_COLORS[partyName[roll.Name].class].colorStr
        iconClass = RTC.Tool.IconClass[partyName[roll.Name].class]
    end
    if colorName == nil or RTC.DB.ColorName == false then
        colorName = colorCheat
    end
    if iconClass == nil or RTC.DB.ShowClassIcon == false then iconClass = "" end
    if RTC.DB.ColorName == false then colorRank = colorCheat end

    if RTC.DB.ShowGuildRank and partyName[roll.Name] and
        partyName[roll.Name].rank then
        rank = " " .. partyName[roll.Name].rank
    end

    local txtCount = roll.Count > 1 and format(" [%d]", roll.Count) or ""

    return "|Hplayer:" .. roll.Name .. "|h" .. colorTied ..
               string.format("%3d", roll.Roll) .. ": " .. iconClass .. colorName ..
               roll.Name .. colorRank .. rank .. "|r " .. colorCheat .. txtRange ..
               "|r " .. colorCheat .. txtCount .. "|h\n"
end

function RTC.UpdateRollList()
    local rollText = ""

    local party, partyName = RTC.GetPlayerList()

    table.sort(RTC.rollArray, RTC.SortRolls)

    -- format and print rolls, check for ties
    if RTC.DB.MainAndOffSpecMode then
        local rtxt = ""
        for _, roll in pairs(RTC.rollArray) do
            if roll.Roll > 0 and roll.High == 100 then
                rtxt = RTC.FormatRollText(roll, party, partyName) .. rtxt
            end
        end
        rollText = RTC.Tool.RGBtoEscape(RTC.DB.ColorInfo) .. L["TxTMainSpec"] .. "\n" .. rtxt
        rtxt = ""
        for _, roll in pairs(RTC.rollArray) do
            if roll.Roll == 0 or roll.High == 99 then
                rtxt = RTC.FormatRollText(roll, party, partyName) .. rtxt
            end
        end
        rollText = rollText .. "\n" .. RTC.Tool.RGBtoEscape(RTC.DB.ColorInfo) .. L["TxTOffSpec"] .. "\n" .. rtxt
    else
        for _, roll in pairs(RTC.rollArray) do
            rollText = RTC.FormatRollText(roll, party, partyName) .. rollText
        end
    end

    if IsInGroup() then
        rollText = rollText .. RTC.Tool.RGBtoEscape(RTC.DB.ColorInfo) ..
                       L["TxtLine"] .. "\n"
        local gtxt = RTC.Tool.RGBtoEscape(RTC.DB.ColorInfo)
        local missClasses = {}
        RTC.allRolled = true
        for _, p in ipairs(party) do
            if RTC.rollNames[p.name] == nil or RTC.rollNames[p.name] == 0 then
                local iconClass = RTC.Tool.IconClass[partyName[p.name].class]
                local rank = ""
                if iconClass == nil or RTC.DB.ShowClassIcon == false then
                    iconClass = ""
                else
                    missClasses[partyName[p.name].class] =
                        missClasses[partyName[p.name].class] and
                            missClasses[partyName[p.name].class] + 1 or 1
                end
                if RTC.DB.ShowGuildRank and partyName[p.name] and
                    partyName[p.name].rank then
                    rank = " " .. partyName[p.name].rank
                end
                gtxt = gtxt .. "|Hplayer:" .. p.name .. "|h" .. iconClass ..
                           p.name .. rank .. "|h\n"
                RTC.allRolled = false
            end
        end
        local ctxt = ""
        if RTC.CLASSIC_ERA then
            local isHorde = (UnitFactionGroup("player")) == "Horde"
            for _, class in pairs(RTC.Tool.Classes) do
                -- for class,count in pairs(missClasses) do
                if not (isHorde and class == "PALADIN") and
                    not (not isHorde and class == "SHAMAN") then
                    ctxt = ctxt .. RTC.Tool.IconClass[class] ..
                               (missClasses[class] or 0) .. " "
                end
            end
            if ctxt ~= "" then
                ctxt = ctxt .. "\n" .. L["TxtLine"] .. "\n"
            end
        end

        rollText = rollText .. ctxt .. gtxt
    end

    RollTrackerRollText:SetText(rollText)
    RollTrackerClassicFrameStatusText:SetText(
        string.format(L["MsgNbRolls"], table.getn(RTC.rollArray)))

    if #RTC.rollArray == 0 and #RTC.rollUndoArray > 0 then
        RollTrackerClassicFrameClearButton:SetText(L["BtnUndo"])
    else
        RollTrackerClassicFrameClearButton:SetText(L["BtnClear"])
    end
end

function RTC.ClearRolls(doMsg)
    if #RTC.rollArray > 0 then
        if doMsg then
            DEFAULT_CHAT_FRAME:AddMessage(RTC.MSGPREFIX .. L["MsgRollCleared"],
                                          RTC.DB.ColorChat.r,
                                          RTC.DB.ColorChat.g,
                                          RTC.DB.ColorChat.b, RTC.DB.ColorChat.a)
        end

        RTC.rollUndoArray = RTC.rollArray
        RTC.rollUndoNames = RTC.rollNames
        RTC.rollArray = {}
        RTC.rollNames = {}
    end
    RTC.UpdateRollList()
end

function RTC.UndoRolls(doMsg)
    if #RTC.rollUndoArray > 0 then
        if doMsg then
            DEFAULT_CHAT_FRAME:AddMessage(RTC.MSGPREFIX .. L["MsgUndoRoll"],
                                          RTC.DB.ColorChat.r,
                                          RTC.DB.ColorChat.g,
                                          RTC.DB.ColorChat.b, RTC.DB.ColorChat.a)
        end
        RTC.rollArray = RTC.rollUndoArray
        RTC.rollNames = RTC.rollUndoNames
        RTC.rollUndoArray = {}
        RTC.rollUndoNames = {}
        RTC.UpdateRollList()
    end
end

function RTC.NotRolled()
    if IsInGroup() or IsInRaid() then
        local party = RTC.GetPlayerList()
        local names = ""
        for _, p in ipairs(party) do
            if RTC.rollNames[p.name] == nil or RTC.rollNames[p.name] == 0 then
                names = names .. ", " .. p.name
            end
        end
        names = string.sub(names, 3)

        if names ~= "" then
            RTC.AddChat(RTC.MSGPREFIX ..
                            string.format(L["MsgNotRolled"], L["pass"]))
            RTC.AddChat(names)
        end
    end
end

function RTC.StartRoll(...)
    local msg
    local item = RTC.Tool.Combine({...})
    RTC.ShowWindow(1)
    RTC.ClearRolls()
    if RTC.DB.MainAndOffSpecMode then
        msg = L["MsgStartMainAndOffSpecMode"]
    else
        msg = L["MsgStart"]
    end
    RTC.AddChat(RTC.MSGPREFIX_START .. string.format(msg, L["pass"]))
    if item and item ~= "" and item ~= " " then
        RTC.AddChat(RTC.MSGPREFIX .. string.format(L["MsgNextItem"], item))

        if RTC.DB.AutoCountdownWithItem then
            RTC.lastItem = item
            RTC.StartCountdown()
        end
    end
    RTC.AddChat(L["MsgBar"])
end

function RTC.RollAnnounce(numbers)
    local winNum = 0
    local winName = ""
    local max = -1
    local addPrefix = ""
    local msg = ""
    local list = {}
    numbers = (tonumber(numbers) or RTC.DB.AnnounceList or 1)
    if numbers == 1 then numbers = 0 end

    table.sort(RTC.rollArray, RTC.SortRollsRev)

    if RTC.DB.MainAndOffSpecMode then -- MS/OS roll
        for _, roll in pairs(RTC.rollArray) do
            if (RTC.DB.AnnounceIgnoreDouble == false or roll.Count == 1) and
                (roll.Roll > 0 and roll.Low == 1 and roll.High == 100) then
                if roll.Roll == max then
                    winNum = winNum + 1
                    winName = winName .. ", " .. roll.Name
                elseif roll.Roll > max then
                    max = roll.Roll
                    winNum = 1
                    winName = roll.Name
                end
                if numbers > 0 then
                    numbers = numbers - 1
                    tinsert(list, roll.Roll .. " " .. roll.Name .. " (" .. roll.Low .. "-" .. roll.High .. ")")
                end
            end
        end

        if winNum == 0 then
            for _, roll in pairs(RTC.rollArray) do
                if (RTC.DB.AnnounceIgnoreDouble == false or roll.Count == 1) and
                    (roll.Roll == 0 or (roll.Low == 1 and roll.High == 99)) then

                    if roll.Roll == max then
                        winNum = winNum + 1
                        winName = winName .. ", " .. roll.Name
                    elseif roll.Roll > max then
                        max = roll.Roll
                        winNum = 1
                        winName = roll.Name
                    end
                    if numbers > 0 then
                        numbers = numbers - 1
                        tinsert(list, roll.Roll .. " " .. roll.Name .. " (" .. roll.Low .. "-" .. roll.High .. ")")
                    end
                end
            end
            addPrefix = L["TxTOffSpec"] .. "! "
        else
            addPrefix = L["TxTMainSpec"] .. "! "
        end
    else -- regular roll
        for _, roll in pairs(RTC.rollArray) do

            if (RTC.DB.AnnounceIgnoreDouble == false or roll.Count == 1) and
                (RTC.DB.AnnounceRejectOutBounds == false or
                    (roll.Low == 1 and roll.High == 100)) then

                if roll.Roll == max and roll.Roll ~= 0 then
                    winNum = winNum + 1
                    winName = winName .. ", " .. roll.Name
                elseif roll.Roll > max and roll.Roll ~= 0 then
                    max = roll.Roll
                    winNum = 1
                    winName = roll.Name
                end
                if numbers > 0 then
                    numbers = numbers - 1
                    tinsert(list, roll.Roll .. " " .. roll.Name .. " (" ..
                                roll.Low .. "-" .. roll.High .. ")")
                end
            end
        end
    end

    if winNum == 1 and RTC.lastItem == nil then
        msg = RTC.MSGPREFIX .. addPrefix ..
                  string.format(L["MsgAnnounce"], winName, max)
    elseif winNum == 1 and RTC.lastItem ~= nil then
        msg = RTC.MSGPREFIX .. addPrefix ..
                  string.format(L["MsgAnnounceItem"], winName, RTC.lastItem, max)
    elseif winNum > 1 and RTC.lastItem == nil then
        msg = RTC.MSGPREFIX .. addPrefix ..
                  string.format(L["MsgAnnounceTie"], winName, max)
    elseif winNum > 1 and RTC.lastItem ~= nil then
        msg = RTC.MSGPREFIX .. addPrefix ..
                  string.format(L["MsgAnnounceTieItem"], winName, RTC.lastItem,
                                max)
    elseif RTC.Countdown then
        msg = RTC.MSGPREFIX .. L["MsgForcedAnnounce"]
    end

    RTC.AddChat(msg)
    for _, out in ipairs(list) do RTC.AddChat(out) end

    RTC.StopCountdown()
end

-- Loot

function RTC.AddLoot(name, lootitem)
    if name == nil or lootitem == nil or not RTC.DB.LootTracker.Enable then
        return
    end

    local ok = false
    if IsInRaid() then
        local count = GetNumGroupMembers()
        if RTC.DB.LootTracker.TrackSRaid and count <= 10 then
            ok = true
        elseif RTC.DB.LootTracker.TrackBRaid and count >= 11 then
            ok = true
        end
    elseif IsInGroup() then
        if RTC.DB.LootTracker.TrackGroup then ok = true end
    elseif RTC.DB.LootTracker.TrackSolo then
        ok = true
    end

    if not ok then return end

    local _, PartyNames = RTC.GetPlayerList()
    local t = time()
    local class
    if PartyNames[name] then class = PartyNames[name].class end

    local loot = {["name"] = name, ["class"] = class, ["timestamp"] = t}
    -- RTC.DB.DEBUGHELP_ITEM=lootitem

    loot.itemName, loot.itemLink, loot.itemRarity, loot.itemLevel, _, _, _, _, _, loot.itemIcon, loot.itemSellPrice, loot.itemType =
        GetItemInfo(string.match(lootitem, "|H(.+)%["))

    loot.ItemCount = tonumber(string.match(lootitem, "|rx(%d+)") or 1)

    if RTC.DB.LootTracker.Rarity[loot.itemRarity] or
        RTC.DB.LootTracker.ItemType[loot.itemType] or
        RTC.whitelist[string.match(loot.itemLink, "item:(.-):") or 0] then

        while #RollTrackerClassicZLoot >= RTC.DB.LootTracker.NbLoots do
            tremove(RollTrackerClassicZLoot, 1)
        end

        tinsert(RollTrackerClassicZLoot, loot)
        RTC.CSVList_AddItem(loot)
        RTC.LootList_AddItem(loot)
        RTC.UpdateLootList()
    end
end

function RTC.ClearLoot(doMsg)
    if #RollTrackerClassicZLoot > 0 then
        if doMsg then
            DEFAULT_CHAT_FRAME:AddMessage(RTC.MSGPREFIX .. L["MsgLootCleared"],
                                          RTC.DB.ColorChat.r,
                                          RTC.DB.ColorChat.g,
                                          RTC.DB.ColorChat.b, RTC.DB.ColorChat.a)
        end
        RTC.lootUndo = RollTrackerClassicZLoot
        RollTrackerClassicZLoot = {}
        RTC.OptionsUpdate()
    end
end

function RTC.UndoLoot(doMsg)
    if #RTC.lootUndo > 0 then
        if doMsg then
            DEFAULT_CHAT_FRAME:AddMessage(RTC.MSGPREFIX .. L["MsgUndoLoot"],
                                          RTC.DB.ColorChat.r,
                                          RTC.DB.ColorChat.g,
                                          RTC.DB.ColorChat.b, RTC.DB.ColorChat.a)
        end
        RollTrackerClassicZLoot = RTC.lootUndo
        RTC.lootUndo = {}
        RTC.OptionsUpdate()
    end
end

function RTC.LootList_AddItem(loot, frame)
    local colorName
    local iconClass
    local icon
    if not loot.itemIcon or not RTC.DB.LootTracker.ShowIcon then
        icon = ""
    else
        icon = string.format(RTC.TxtEscapeIcon, loot.itemIcon)
    end

    if loot.class then
        colorName = "|c" .. RAID_CLASS_COLORS[loot.class].colorStr
        iconClass = RTC.Tool.IconClass[loot.class]
    end
    if colorName == nil or RTC.DB.ColorName == false then colorName = "" end
    if iconClass == nil or RTC.DB.ShowClassIcon == false then iconClass = "" end

    local stack
    if loot.ItemCount ~= nil and loot.ItemCount > 1 then
        stack = "x" .. loot.ItemCount
    else
        stack = ""
    end

    local Text

    if frame == nil then
        local name =
            "|Hplayer:" .. loot.name .. "|h" .. iconClass .. colorName ..
                loot.name .. "|r|h"

        if RTC.DB.LootTracker.ShortMessage then
            Text = name .. " " .. icon .. loot.itemLink .. stack
        else
            Text = string.format(L["MsgLootLine"],
                                 date("%y-%m-%d %H:%M", loot.timestamp), name,
                                 icon .. loot.itemLink .. stack)
        end
        RollTrackerClassicZLootFrame_MessageFrame:AddMessage(Text, RTC.DB
                                                                 .ColorScroll.r,
                                                             RTC.DB.ColorScroll
                                                                 .g, RTC.DB
                                                                 .ColorScroll.b,
                                                             RTC.DB.ColorScroll
                                                                 .a)
    else
        Text = date("%y-%m-%d %H:%M", loot.timestamp) .. " " .. icon ..
                   loot.itemLink .. stack
        frame:AddLine(Text, RTC.DB.ColorScroll.r, RTC.DB.ColorScroll.g,
                      RTC.DB.ColorScroll.b)
    end
end

function RTC.LootListInit()

    RollTrackerClassicZLootFrame_MessageFrame:SetFading(false);
    if RTC.DB.LootTracker.SmallFont then
        RollTrackerClassicZLootFrame_MessageFrame:SetFontObject(
            GameFontNormalSmall);
    else
        RollTrackerClassicZLootFrame_MessageFrame:SetFontObject(GameFontNormal);
    end
    RollTrackerClassicZLootFrame_MessageFrame:SetJustifyH("LEFT");
    RollTrackerClassicZLootFrame_MessageFrame:SetHyperlinksEnabled(true);
    RollTrackerClassicZLootFrame_MessageFrame:SetTextCopyable(true);
    RollTrackerClassicZLootFrame_MessageFrame:Clear()
    RollTrackerClassicZLootFrame_MessageFrame:SetMaxLines(RTC.DB.LootTracker
                                                              .NbLoots)

    if RTC.DB.LootTracker.Enable then
        for _, loot in ipairs(RollTrackerClassicZLoot) do
            RTC.LootList_AddItem(loot)
        end
    else
        RollTrackerClassicZLootFrame_MessageFrame:AddMessage(
            L["MsgLTnotenabled"], RTC.DB.ColorScroll.r, RTC.DB.ColorScroll.g,
            RTC.DB.ColorScroll.b, RTC.DB.ColorScroll.a)
    end
end

function RTC.UpdateLootList()

    if RTC.DB.LootTracker.Enable then
        RollTrackerClassicZLootFrameStatusText:SetText(string.format(
                                                           L["MsgNbLoots"],
                                                           #RollTrackerClassicZLoot))
    else
        RollTrackerClassicZLootFrameStatusText:SetText("")
    end

    if #RollTrackerClassicZLoot == 0 and #RTC.lootUndo > 0 then
        RollTrackerClassicZLootFrameClearButton:SetText(L["BtnUndo"])
    else
        RollTrackerClassicZLootFrameClearButton:SetText(L["BtnClear"])
    end
end

function RTC.ScrollLootList(self, delta)
    self:SetScrollOffset(self:GetScrollOffset() + delta * 5);
    self:ResetAllFadeTimes()
end

function RTC.ScrollCSVList(self, delta)
    self:SetScrollOffset(self:GetScrollOffset() + delta * 5);
    self:ResetAllFadeTimes()
end

function RTC.CSVList_AddItem(loot, hide)

    RTC.CSV_Transfer_Table["%%"] = "%"
    RTC.CSV_Transfer_Table["%name%"] = loot.name
    RTC.CSV_Transfer_Table["%class%"] = loot.class
    RTC.CSV_Transfer_Table["%timestamp%"] = loot.timestamp
    RTC.CSV_Transfer_Table["%dd%"] = date("%d", loot.timestamp)
    RTC.CSV_Transfer_Table["%mm%"] = date("%m", loot.timestamp)
    RTC.CSV_Transfer_Table["%yy%"] = date("%y", loot.timestamp)
    RTC.CSV_Transfer_Table["%HH%"] = date("%H", loot.timestamp)
    RTC.CSV_Transfer_Table["%MM%"] = date("%M", loot.timestamp)
    RTC.CSV_Transfer_Table["%SS%"] = date("%S", loot.timestamp)
    RTC.CSV_Transfer_Table["%iname%"] = loot.itemName
    RTC.CSV_Transfer_Table["%irarity%"] = loot.itemRarity
    RTC.CSV_Transfer_Table["%iraritytxt%"] =
        _G["ITEM_QUALITY" .. loot.itemRarity .. "_DESC"]
    RTC.CSV_Transfer_Table["%ilevel%"] = loot.itemLevel
    RTC.CSV_Transfer_Table["%iid%"] = string.match(loot.itemLink, "item:(.-):")
    RTC.CSV_Transfer_Table["%iprice%"] = loot.itemSellPrice
    RTC.CSV_Transfer_Table["%icount%"] = loot.ItemCount or 1
    RTC.CSV_Transfer_Table["%itype%"] = loot.itemType or 99
    RTC.CSV_Transfer_Table["%itypetxt%"] =
        GetItemClassInfo(loot.itemType or 99) or ""

    local text = string.gsub(RTC.DB.LootTracker.CSVexport, "%%%w-%%",
                             RTC.CSV_Transfer_Table)

    if hide then
        return text
    else
        RollTrackerClassicCSVFrame_MessageFrame:AddMessage(text, RTC.DB
                                                               .ColorScroll.r,
                                                           RTC.DB.ColorScroll.g,
                                                           RTC.DB.ColorScroll.b,
                                                           RTC.DB.ColorScroll.a)
    end
end

function RTC.CSVListInit()

    RollTrackerClassicCSVFrame_MessageFrame:SetFading(false);
    RollTrackerClassicCSVFrame_MessageFrame:SetFontObject(GameFontNormalSmall);
    RollTrackerClassicCSVFrame_MessageFrame:SetJustifyH("LEFT");
    RollTrackerClassicCSVFrame_MessageFrame:SetHyperlinksEnabled(true);
    RollTrackerClassicCSVFrame_MessageFrame:SetTextCopyable(true);
    RollTrackerClassicCSVFrame_MessageFrame:Clear()
    RollTrackerClassicCSVFrame_MessageFrame:SetMaxLines(RTC.DB.LootTracker
                                                            .NbLoots)

    for _, loot in ipairs(RollTrackerClassicZLoot) do
        RTC.CSVList_AddItem(loot)
    end
end

function RTC.BtnExport()
    local Text = ""
    for _, loot in ipairs(RollTrackerClassicZLoot) do
        Text = Text .. RTC.CSVList_AddItem(loot, true) .. "\n"
    end
    RTC.Tool.CopyPast(Text)
end
