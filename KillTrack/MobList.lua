--[[
    * Copyright (c) 2011-2020 by Adam Hellberg.
    *
    * This file is part of KillTrack.
    *
    * KillTrack is free software: you can redistribute it and/or modify
    * it under the terms of the GNU General Public License as published by
    * the Free Software Foundation, either version 3 of the License, or
    * (at your option) any later version.
    *
    * KillTrack is distributed in the hope that it will be useful,
    * but WITHOUT ANY WARRANTY; without even the implied warranty of
    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    * GNU General Public License for more details.
    *
    * You should have received a copy of the GNU General Public License
    * along with KillTrack. If not, see <http://www.gnu.org/licenses/>.
--]]

-- Beware of some possibly messy code in this file

local _, KT = ...

KT.MobList = {}

local ML = KT.MobList
local KTT = KT.Tools

local Sort = KT.Sort.Desc
local Mobs = nil
local LastFilter = nil
local LastOffset = 0

-- Frame Constants
local FRAME_WIDTH = 600
local FRAME_HEIGHT = 534
local HEADER_HEIGHT = 24
local HEADER_LEFT = 3
local HEADER_TOP = -80
local ROW_HEIGHT = 15
local ROW_COUNT = 27
local ROW_TEXT_PADDING = 5
local ID_WIDTH = 100
local NAME_WIDTH = 300
local CHAR_WIDTH = 100
local GLOBAL_WIDTH = 100
local SCROLL_WIDTH = 27 -- Scrollbar width
local STATUS_TEXT = "Showing entries %d through %d out of %d total (%d hidden)"

local frame = nil
local created = false

-- Frame helper functions

local function CreateHeader(parent)
    local h = CreateFrame("Button", nil, parent)
    h:SetHeight(HEADER_HEIGHT)
    h:SetNormalFontObject("GameFontHighlightSmall")

    local bgl = h:CreateTexture(nil, "BACKGROUND")
    bgl:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs")
    bgl:SetWidth(5)
    bgl:SetHeight(HEADER_HEIGHT)
    bgl:SetPoint("TOPLEFT")
    bgl:SetTexCoord(0, 0.07815, 0, 0.75)

    local bgr = h:CreateTexture(nil, "BACKGROUND")
    bgr:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs")
    bgr:SetWidth(5)
    bgr:SetHeight(HEADER_HEIGHT)
    bgr:SetPoint("TOPRIGHT")
    bgr:SetTexCoord(0.90625, 0.96875, 0, 0.75)

    local bgm = h:CreateTexture(nil, "BACKGROUND")
    bgm:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs")
    bgm:SetHeight(HEADER_HEIGHT)
    bgm:SetPoint("LEFT", bgl, "RIGHT")
    bgm:SetPoint("RIGHT", bgr, "LEFT")
    bgm:SetTexCoord(0.07815, 0.90625, 0, 0.75)

    local hl = h:CreateTexture()
    h:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight", "ADD")
    hl:SetPoint("TOPLEFT", bgl, "TOPLEFT", -2, 5)
    hl:SetPoint("BOTTOMRIGHT", bgr, "BOTTOMRIGHT", 2, -7)

    return h
end

local function CreateRow(container, previous)
    local row = CreateFrame("Button", nil, container)
    row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
    row:SetHeight(ROW_HEIGHT)
    row:SetPoint("LEFT")
    row:SetPoint("RIGHT")
    row:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, 0)

    row.idField = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    row.idField:SetHeight(ROW_HEIGHT)
    row.idField:SetWidth(ID_WIDTH - ROW_TEXT_PADDING * 2)
    row.idField:SetPoint("LEFT", row, "LEFT", ROW_TEXT_PADDING, 0)
    row.idField:SetJustifyH("RIGHT")

    row.nameField = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    row.nameField:SetHeight(ROW_HEIGHT)
    row.nameField:SetWidth(NAME_WIDTH - SCROLL_WIDTH - ROW_TEXT_PADDING * 3)
    row.nameField:SetPoint("LEFT", row.idField, "RIGHT", 2 * ROW_TEXT_PADDING, 0)
    row.nameField:SetJustifyH("LEFT")

    row.charKillField = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    row.charKillField:SetHeight(ROW_HEIGHT)
    row.charKillField:SetWidth(CHAR_WIDTH - ROW_TEXT_PADDING * 2)
    row.charKillField:SetPoint("LEFT", row.nameField, "RIGHT", 2 * ROW_TEXT_PADDING, 0)
    row.charKillField:SetJustifyH("RIGHT")

    row.globalKillField = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    row.globalKillField:SetHeight(ROW_HEIGHT)
    row.globalKillField:SetWidth(GLOBAL_WIDTH - ROW_TEXT_PADDING * 2)
    row.globalKillField:SetPoint("LEFT", row.charKillField, "RIGHT", 2 * ROW_TEXT_PADDING, 0)
    row.globalKillField:SetJustifyH("RIGHT")

    row:SetScript("OnClick", function(s)
        local id = tonumber(s.idField:GetText())
        if not id then return end
        local name = s.nameField:GetText()
        KT:ShowDelete(id, name)
    end)

    row:SetScript("OnEnter", function(s)
        local id = tonumber(s.idField:GetText())
        if not id then return end
        local globalData = KT.Global.MOBS[id]
        if not globalData then return end
        local killTimestamp = globalData.LastKillAt
        if not killTimestamp then return end
        local lastKillAt = KTT:FormatDateTime(killTimestamp)
        local tpString = ("Last killed at %s"):format(lastKillAt)
        GameTooltip:SetOwner(s, "ANCHOR_NONE")
        GameTooltip:SetPoint("TOPLEFT", s, "BOTTOMLEFT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(tpString)
        GameTooltip:Show()
    end)

    row:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    return row
end

function ML:Show()
    if not created then
        ML:Create()
    end
    if frame:IsShown() then return end
    frame:Show()
end

function ML:Hide()
    if not frame or not frame:IsShown() then return end
    frame:Hide()
end

function ML:Toggle()
    if frame and frame:IsShown() then
        ML:Hide()
    else
        ML:Show()
    end
end

function ML:Create()
    if frame then return end
    frame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
    frame:Hide()
    frame:SetToplevel(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetPoint("CENTER")
    frame:SetWidth(FRAME_WIDTH)
    frame:SetHeight(FRAME_HEIGHT)

    local bd = {
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        edgeSize = 16,
        tileSize = 32,
        insets = {
            left = 2.5,
            right = 2.5,
            top = 2.5,
            bottom = 2.5
        }
    }

    frame:SetBackdrop(bd)

    frame.titleLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.titleLabel:SetWidth(250)
    frame.titleLabel:SetHeight(16)
    frame.titleLabel:SetPoint("TOP", frame, "TOP", 0, -5)
    frame.titleLabel:SetText("KillTrack Mob Database (" .. KT.Version .. ")")

    frame:SetScript("OnMouseDown", function(s) s:StartMoving() end)
    frame:SetScript("OnMouseUp", function(s) s:StopMovingOrSizing() end)
    frame:SetScript("OnShow", function() ML:UpdateMobs(Sort, LastFilter) ML:UpdateEntries(LastOffset) end)

    frame.closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
    frame.closeButton:SetScript("OnClick", function() ML:Hide() end)

    frame.purgeButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.purgeButton:SetHeight(24)
    frame.purgeButton:SetWidth(100)
    frame.purgeButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -5)
    frame.purgeButton:SetText("Purge Data")
    frame.purgeButton:SetScript("OnClick", function()
        KT:ShowPurge()
    end)

    frame.resetButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.resetButton:SetHeight(24)
    frame.resetButton:SetWidth(100)
    frame.resetButton:SetPoint("TOPLEFT", frame.purgeButton, "BOTTOMLEFT", 0, -3)
    frame.resetButton:SetText("Reset All")
    frame.resetButton:SetScript("OnClick", function()
        KT:ShowReset()
    end)

    frame.helpLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.helpLabel:SetWidth(380)
    frame.helpLabel:SetHeight(16)
    frame.helpLabel:SetPoint("TOP", frame, "TOP", 0, -28)
    frame.helpLabel:SetWordWrap(true)
    frame.helpLabel:SetMaxLines(2)
    frame.helpLabel:SetText(
        "Click on an individual entry to delete it from the database. Use the search to filter database by name.")

    frame.searchBox = CreateFrame("EditBox", "KillTrackMobListSearchBox", frame, "SearchBoxTemplate")
    frame.searchBox:SetWidth(200)
    frame.searchBox:SetHeight(16)
    frame.searchBox:SetPoint("TOPLEFT", frame.resetButton, "BOTTOMLEFT", 8, -3)
    frame.searchBox:HookScript("OnTextChanged", function(s)
        local text = s:GetText()
        if (not _G[s:GetName() .. "ClearButton"]:IsShown()) then
            text = nil
            LastFilter = nil
        end
        if not text or text == "" then
            ML:UpdateMobs(Sort)
        else
            ML:UpdateMobs(Sort, text)
        end
        ML:UpdateEntries(LastOffset)
    end)
    frame.searchBox:SetScript("OnEnterPressed", function(s) s:ClearFocus() end)
    frame.searchBox.clearButton = _G[frame.searchBox:GetName() .. "ClearButton"]
    local sBoxOldFunc = frame.searchBox.clearButton:GetScript("OnHide")
    frame.searchBox.clearButton:SetScript("OnHide", function(s)
        if sBoxOldFunc then sBoxOldFunc(s) end
        if not frame:IsShown() then return end
        ML:UpdateMobs(Sort, nil)
        ML:UpdateEntries(LastOffset)
    end)

    frame.searchTipLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.searchTipLabel:SetWidth(200)
    frame.searchTipLabel:SetHeight(16)
    frame.searchTipLabel:SetPoint("LEFT", frame.searchBox, "RIGHT", -22, 0)
    frame.searchTipLabel:SetText("(Supports Lua patterns)")

    frame.idHeader = CreateHeader(frame)
    frame.idHeader:SetPoint("TOPLEFT", frame, "TOPLEFT", HEADER_LEFT, HEADER_TOP)
    frame.idHeader:SetWidth(ID_WIDTH)
    frame.idHeader:SetText("NPC ID")
    frame.idHeader:SetScript("OnClick", function()
        local sort = KT.Sort.IdAsc
        if Sort == sort then
            sort = KT.Sort.IdDesc
        end
        ML:UpdateMobs(sort, LastFilter)
        ML:UpdateEntries(LastOffset)
    end)

    frame.nameHeader = CreateHeader(frame)
    frame.nameHeader:SetPoint("TOPLEFT", frame.idHeader, "TOPRIGHT", -2, 0)
    frame.nameHeader:SetWidth(NAME_WIDTH - SCROLL_WIDTH)
    frame.nameHeader:SetText("Name")
    frame.nameHeader:SetScript("OnClick", function()
        local sort = KT.Sort.AlphaA
        if Sort == sort then
            sort = KT.Sort.AlphaD
        end
        ML:UpdateMobs(sort, LastFilter)
        ML:UpdateEntries(LastOffset)
    end)

    frame.charKillHeader = CreateHeader(frame)
    frame.charKillHeader:SetPoint("TOPLEFT", frame.nameHeader, "TOPRIGHT", -2, 0)
    frame.charKillHeader:SetWidth(CHAR_WIDTH)
    frame.charKillHeader:SetText("Character Kills")
    frame.charKillHeader:SetScript("OnClick", function()
        local sort = KT.Sort.CharDesc
        if Sort == sort then
            sort = KT.Sort.CharAsc
        end
        ML:UpdateMobs(sort, LastFilter)
        ML:UpdateEntries(LastOffset)
    end)

    frame.globalKillHeader = CreateHeader(frame)
    frame.globalKillHeader:SetPoint("TOPLEFT", frame.charKillHeader, "TOPRIGHT", -2, 0)
    frame.globalKillHeader:SetWidth(GLOBAL_WIDTH + HEADER_LEFT)
    frame.globalKillHeader:SetText("Global Kills")
    frame.globalKillHeader:SetScript("OnClick", function()
        local sort = KT.Sort.Desc
        if Sort == sort then
            sort = KT.Sort.Asc
        end
        ML:UpdateMobs(sort, LastFilter)
        ML:UpdateEntries(LastOffset)
    end)

    frame.rows = CreateFrame("Frame", nil, frame)
    frame.rows:SetPoint("LEFT")
    frame.rows:SetPoint("RIGHT", frame, "RIGHT", -SCROLL_WIDTH, 0)
    frame.rows:SetPoint("TOP", frame.idHeader, "BOTTOM", 0, 0)
    frame.rows:SetPoint("BOTTOM", frame, "BOTTOM", 0, 0)
    frame.rows:SetPoint("TOPLEFT", frame.idHeader, "BOTTOMLEFT", 0, 30)

    local previous = frame.idHeader
    for i = 1, ROW_COUNT do
        local key = "row" .. i
        frame.rows[key] = CreateRow(frame.rows, previous)
        frame.rows[key].idField:SetText("")
        frame.rows[key].nameField:SetText("")
        frame.rows[key].charKillField:SetText("")
        frame.rows[key].globalKillField:SetText("")
        previous = frame.rows[key]
    end

    frame.rows.scroller = CreateFrame(
        "ScrollFrame",
        "KillTrackMobListScrollFrame",
        frame.rows,
        "FauxScrollFrameTemplateLight")
    frame.rows.scroller.name = frame.rows.scroller:GetName()
    frame.rows.scroller:SetWidth(frame.rows:GetWidth())
    frame.rows.scroller:SetPoint("TOPRIGHT", frame.rows, "TOPRIGHT", -1, -2)
    frame.rows.scroller:SetPoint("BOTTOMRIGHT", 0, 4)
    frame.rows.scroller:SetScript(
        "OnVerticalScroll",
        function(s, val)
            FauxScrollFrame_OnVerticalScroll(
                s, val, ROW_HEIGHT,
                function()
                    local offset = FauxScrollFrame_GetOffset(frame.rows.scroller)
                    ML:UpdateEntries(offset)
                end
            )
        end
    )

    self:UpdateMobs(Sort)

    frame.statusLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.statusLabel:SetWidth(420)
    frame.statusLabel:SetHeight(16)
    frame.statusLabel:SetPoint("BOTTOM", frame, "BOTTOM", 0, 8)
    frame.statusLabel:SetText(STATUS_TEXT:format(1, ROW_COUNT, #Mobs))

    self:UpdateEntries(LastOffset)

    created = true
end

function ML:UpdateMobs(sort, filter)
    sort = (sort or Sort) or KT.Sort.Desc
    Sort = sort
    LastFilter = filter
    Mobs = KT:GetSortedMobTable(Sort, filter and filter:lower() or nil)
    FauxScrollFrame_Update(frame.rows.scroller, #Mobs, ROW_COUNT, ROW_HEIGHT)
end

function ML:UpdateEntries(offset)
    if (#Mobs <= 0) then
        for i = 1, ROW_COUNT do
            local row = frame.rows["row" .. i]
            row.idField:SetText("")
            if i == 1 then
                row.nameField:SetText("No entries in database or none matched search!")
            else
                row.nameField:SetText("")
            end
            row.charKillField:SetText("")
            row.globalKillField:SetText("")
            row:Disable()
        end

        frame.statusLabel:SetText(STATUS_TEXT:format(0, 0, 0))

        return
    elseif #Mobs < ROW_COUNT then
        for i = 1, ROW_COUNT do
            local row = frame.rows["row" .. i]
            row.idField:SetText("")
            row.nameField:SetText("")
            row.charKillField:SetText("")
            row.globalKillField:SetText("")
            row:Disable()
        end
    end
    offset = (tonumber(offset) or LastOffset) or 0
    LastOffset = offset
    local limit = ROW_COUNT
    if limit > #Mobs then
        limit = #Mobs
    end
    for i = 1, limit do
        local row = frame.rows["row" .. i]
        local mob = Mobs[i + offset]
        row.idField:SetText(mob.Id)
        row.nameField:SetText(mob.Name)
        row.charKillField:SetText(mob.cKills)
        row.globalKillField:SetText(mob.gKills)
        row:Enable()
    end

    local mobCount = KTT:TableLength(KT.Global.MOBS)
    local hidden = mobCount - #Mobs
    frame.statusLabel:SetText(STATUS_TEXT:format(1 + offset, math.min(#Mobs, offset + ROW_COUNT), #Mobs, hidden))

    if offset == 0 then
        _G[frame.rows.scroller.name .. "ScrollBarScrollUpButton"]:Disable()
    else
        _G[frame.rows.scroller.name .. "ScrollBarScrollUpButton"]:Enable()
    end

    if offset + ROW_COUNT == #Mobs then
        _G[frame.rows.scroller.name .. "ScrollBarScrollDownButton"]:Disable()
    else
        _G[frame.rows.scroller.name .. "ScrollBarScrollDownButton"]:Enable()
    end
end
