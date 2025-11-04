---@type string, AddonTable
local addonName, addonTable = ...

local ReforgeLite = addonTable.ReforgeLite

local FRAME_NAME = addonName .. "ExportImport"
local L = addonTable.L
local print = addonTable.print

local firstInitialize
local function GetDataFrame(anchor)
    if _G[FRAME_NAME] then
        _G[FRAME_NAME]:Hide()
    end
    local AceGUI = LibStub("AceGUI-3.0")
    local displayFrame = AceGUI:Create("Frame")
    displayFrame:SetLayout("Flow")
    displayFrame:SetStatusTable({ width = 525, height = 275 })
    if anchor then
        displayFrame:ClearAllPoints()
        displayFrame:SetPoint("CENTER", anchor, "CENTER")
    end
    displayFrame:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        _G[FRAME_NAME] = nil
    end)
    displayFrame:SetCallback("OnEnterStatusBar", function(widget)
        if widget.statustext:IsTruncated() then
            GameTooltip:SetOwner(widget.statustext, "ANCHOR_LEFT")
            GameTooltip:AddLine(widget.statustext:GetText(), nil, nil, nil, true)
            GameTooltip:Show()
        end
    end)
    displayFrame:SetCallback("OnLeaveStatusBar", GameTooltip_Hide)

    local editbox = AceGUI:Create("MultiLineEditBox")
    editbox:SetFullWidth(true)
    editbox:SetFullHeight(true)
    displayFrame:AddChild(editbox)

    if not firstInitialize then
        tinsert(UISpecialFrames, FRAME_NAME)
        firstInitialize = true
    end
    _G[FRAME_NAME] = displayFrame
    return displayFrame, editbox
end

function ReforgeLite:DisplayMessage(message, name, copyOnly)
    local frame, editBox = GetDataFrame(self)
    frame:SetTitle(L["Export"])
    frame:SetStatusText(name or "")
    editBox:DisableButton(true)
    editBox:SetLabel()
    editBox:SetText(message)
    if copyOnly then
        frame.status.message = message
        editBox.editBox:SetFocus()
        editBox.editBox:HighlightText()
        editBox:SetCallback("OnLeave", function(widget) widget.editBox:HighlightText() widget:SetFocus() end)
        editBox:SetCallback("OnEnter", function(widget) widget.editBox:HighlightText() widget:SetFocus() end)
        editBox:SetCallback("OnTextChanged", function(widget) widget.editBox:SetText(widget.parent.status.message) widget.editBox:HighlightText() end)
    end
end

function ReforgeLite:DebugMethod()
    self:DisplayMessage(C_EncodingUtil.SerializeJSON(addonTable.methodDebug or {nty="<3"}), C_AddOns.GetAddOnMetadata(addonName, "X-Website"), true)
end

function ReforgeLite:PrintLog()
    self:DisplayMessage(table.concat(addonTable.printLog, "\n"), "Print Log")
end

function ReforgeLite:ExportJSON(preset, name)
    self:DisplayMessage(C_EncodingUtil.SerializeJSON(preset), name, true)
end

function ReforgeLite:ImportData(anchor)
    self:Initialize()
    self:UpdateItems()
    local frame, editBox = GetDataFrame(not anchor and self)
    frame:SetTitle(L["Import"])
    if anchor then
        frame:ClearAllPoints()
        frame:SetPoint("TOP", anchor, "TOP")
    end
    editBox:SetLabel(L["Enter WoWSims JSON or Pawn string"])
    editBox.editBox:SetFocus()
    local function ParseUserInput(widget)
        local userInput = widget:GetText()
        if not userInput or userInput == "" then
            widget.parent:SetStatusText("")
            return
        end
        local validWoWSims, wowsims = self:ValidateWoWSimsString(userInput)
        if validWoWSims then
            self:ApplyWoWSimsImport(wowsims, anchor ~= nil)
            widget.parent:Hide()
            return
        elseif type(wowsims) == "table" and wowsims.slot then
            local function UpdateText(item)
                if _G[FRAME_NAME] then
                    _G[FRAME_NAME]:SetStatusText(L["%s does not match your currently equipped %s: %s. ReforgeLite only supports equipped items."]:format(
                        item or self.itemSlots[wowsims.slot],
                        _G[self.itemSlots[wowsims.slot]],
                        self.itemData[wowsims.slot].itemInfo.link or EMPTY
                    ))    
                end
            end
            if wowsims.itemId then
                local mismatchItem = Item:CreateFromItemID(wowsims.itemId)
                mismatchItem:ContinueOnItemLoad(function() UpdateText(mismatchItem:GetItemLink()) end)
            else
                UpdateText()
            end
            return
        end
        local validPawn, pawn = self:ValidatePawnString(userInput)
        if pawn then
            self:ParsePawnString(pawn)
            widget.parent:Hide()
            print(L["Pawn successfully imported."])
            return
        end
        widget.parent:SetStatusText(wowsims or ERROR_CAPS)
    end
    editBox.button:SetScript("OnClick", function(btn) ParseUserInput(btn.obj) end)
    editBox:SetCallback("OnTextChanged", ParseUserInput)
end
