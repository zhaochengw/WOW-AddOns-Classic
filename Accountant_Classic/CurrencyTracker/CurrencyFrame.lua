-- Fixed column layout to match header anchors in XML (tuned for zhCN spacing)
local COL = {
    NAME_X = 45,   NAME_W = 160, -- Currency name segment (left aligned)
    TOTL_X = 200,  TOTL_W = 80, -- TotalMax (right aligned)
    IN_X   = 320,  IN_W   = 90,  -- Income (right aligned)
    OUT_X  = 420,  OUT_W  = 90,  -- Outgoing (right aligned)
    NET_X  = 520,  NET_W  = 90,  -- Net (right aligned)
}
-- CurrencyFrame.lua
-- Minimal standalone Currency Tracker UI skeleton per design doc
-- Note: UI renders only; no changes to CLI logic or storage semantics.

local addonName, addonTable = ...

CurrencyTracker = CurrencyTracker or {}

-- Local L resolver to avoid load-order issues
local L
-- Forward declarations to satisfy early references
local GetRootFrame
local function CT_GetL()
    if L then return L end
    if LibStub then
        local ace = LibStub("AceLocale-3.0", true)
        if ace then
            local LL = ace:GetLocale("Accountant_Classic", true)
            if LL then L = LL end
        end
    end
    return L
end

-- Numeric formatting helpers
local function IsNumeric(val)
    if type(val) == "number" then return true end
    if type(val) == "string" then return tonumber(val) ~= nil end
    return false
end

local function FormatThousands(val)
    -- Keep non-numeric values as-is
    if val == nil then return "" end
    local num = val
    if type(num) ~= "number" then num = tonumber(num) end
    if not num then return tostring(val) end
    local sign = num < 0 and "-" or ""
    num = math.abs(math.floor(num + 0.5))
    local s = tostring(num)
    -- Insert commas every three digits
    local formatted = s
    while true do
        local k
        formatted, k = formatted:gsub("^(%d+)(%d%d%d)", "%1,%2")
        if k == 0 then break end
    end
    return sign .. formatted
end

-- Apply localized header labels (no hardcoded text in XML)
local deferHeaderOnce = false

local function ApplyHeaderLabels()
    local frame = GetRootFrame()
    if not frame then return end
    local prefix = frame:GetName() .. "HeaderRow"
    local headerRow  = _G[prefix]
    local nameHdr     = _G[prefix .. "NameHeader"]
    local totalMaxHdr = _G[prefix .. "TotalMaxHeader"]
    local incomeHdr   = _G[prefix .. "IncomeHeader"]
    local outgoingHdr = _G[prefix .. "OutgoingHeader"]
    local netHdr      = _G[prefix .. "NetHeader"]

    local LL = CT_GetL()
    local function Lget(key, fallback)
        if LL and LL[key] then return LL[key] end
        return fallback
    end

    -- Set localized texts
    if nameHdr     then nameHdr:SetText(Lget("CT_Header_Currency", "Currency")) end
    if totalMaxHdr then totalMaxHdr:SetText(Lget("CT_Header_TotalMax", "Cap")) end
    if incomeHdr   then incomeHdr:SetText(Lget("CT_Header_Income", "Income")) end
    if outgoingHdr then outgoingHdr:SetText(Lget("CT_Header_Outgoing", "Outgoing")) end
    if netHdr      then netHdr:SetText(Lget("CT_Header_Net", "Net")) end

    -- Force headers to use the exact same anchors/widths/justification as rows
    if nameHdr and headerRow then
        nameHdr:ClearAllPoints()
        nameHdr:SetPoint("LEFT", headerRow, "LEFT", COL.NAME_X, 0)
        nameHdr:SetWidth(COL.NAME_W)
        nameHdr:SetJustifyH("LEFT")
        nameHdr:SetDrawLayer("OVERLAY")
        nameHdr:SetAlpha(1)
        nameHdr:Show()
    end
    if totalMaxHdr and headerRow then
        totalMaxHdr:ClearAllPoints()
        totalMaxHdr:SetPoint("LEFT", headerRow, "LEFT", COL.TOTL_X, 0)
        totalMaxHdr:SetWidth(COL.TOTL_W)
        totalMaxHdr:SetJustifyH("RIGHT")
        totalMaxHdr:SetDrawLayer("OVERLAY")
        totalMaxHdr:SetAlpha(1)
        totalMaxHdr:Show()
    end
    if incomeHdr and headerRow then
        incomeHdr:ClearAllPoints()
        incomeHdr:SetPoint("LEFT", headerRow, "LEFT", COL.IN_X, 0)
        incomeHdr:SetWidth(COL.IN_W)
        incomeHdr:SetJustifyH("RIGHT")
        incomeHdr:SetDrawLayer("OVERLAY")
        incomeHdr:SetAlpha(1)
        incomeHdr:Show()
    end
    if outgoingHdr and headerRow then
        outgoingHdr:ClearAllPoints()
        outgoingHdr:SetPoint("LEFT", headerRow, "LEFT", COL.OUT_X, 0)
        outgoingHdr:SetWidth(COL.OUT_W)
        outgoingHdr:SetJustifyH("RIGHT")
        outgoingHdr:SetDrawLayer("OVERLAY")
        outgoingHdr:SetAlpha(1)
        outgoingHdr:Show()
    end
    if netHdr and headerRow then
        netHdr:ClearAllPoints()
        netHdr:SetPoint("LEFT", headerRow, "LEFT", COL.NET_X, 0)
        netHdr:SetWidth(COL.NET_W)
        netHdr:SetJustifyH("RIGHT")
        netHdr:SetDrawLayer("OVERLAY")
        netHdr:SetAlpha(1)
        netHdr:Show()
    end

    -- Ensure header row itself is above siblings
    if headerRow then
        headerRow:SetFrameStrata("HIGH")
        headerRow:SetFrameLevel((frame:GetFrameLevel() or 0) + 2)
    end

    -- Re-apply next frame once to win over any late writes
    if C_Timer and C_Timer.After and not deferHeaderOnce then
        deferHeaderOnce = true
        C_Timer.After(0, function()
            deferHeaderOnce = false
            ApplyHeaderLabels()
        end)
    end
end

-- Module table
CurrencyTracker.CurrencyFrame = CurrencyTracker.CurrencyFrame or {}
local UI = CurrencyTracker.CurrencyFrame

-- Expose for XML OnShow
UI.ApplyHeaderLabels = ApplyHeaderLabels

-- Reuse Gold's localized tab strings
local CT_Constants = addonTable and addonTable.constants
local CT_TabText = CT_Constants and CT_Constants.tabText -- array of localized strings
local CT_TabTips = CT_Constants and CT_Constants.tabTooltipText

-- Private state
local rootFrame
local initialized = false
local currentTimeframe = "Session"
local currentCurrencyId = nil -- nil for all currencies
local currencyDropdown = nil
local serverDropdown = nil
local characterDropdown = nil
local currentServer = nil
local currentCharacter = nil

-- State persistence
local function SaveUIState()
    if not CurrencyTracker or not CurrencyTracker.Storage then return end
    
    -- Create options table if it doesn't exist
    if not CurrencyTracker.Storage.currencyOptions then
        CurrencyTracker.Storage.currencyOptions = {}
    end
    
    -- Save current selections
    CurrencyTracker.Storage.currencyOptions.lastTimeframe = currentTimeframe
    CurrencyTracker.Storage.currencyOptions.lastCurrencyId = currentCurrencyId
    CurrencyTracker.Storage.currencyOptions.lastServer = currentServer
    CurrencyTracker.Storage.currencyOptions.lastCharacter = currentCharacter
end

-- Load saved state
local function LoadUIState()
    if not CurrencyTracker or not CurrencyTracker.Storage then return end
    
    -- Check if options exist
    if not CurrencyTracker.Storage.currencyOptions then return end
    
    -- Load saved selections
    if CurrencyTracker.Storage.currencyOptions.lastTimeframe then
        currentTimeframe = CurrencyTracker.Storage.currencyOptions.lastTimeframe
    end
    
    if CurrencyTracker.Storage.currencyOptions.lastCurrencyId then
        currentCurrencyId = CurrencyTracker.Storage.currencyOptions.lastCurrencyId
    end
    
    if CurrencyTracker.Storage.currencyOptions.lastServer then
        currentServer = CurrencyTracker.Storage.currencyOptions.lastServer
    end
    
    if CurrencyTracker.Storage.currencyOptions.lastCharacter then
        currentCharacter = CurrencyTracker.Storage.currencyOptions.lastCharacter
    end
end

-- Helpers
function GetRootFrame()
    if rootFrame then return rootFrame end
    rootFrame = _G["AccountantClassicCurrencyFrame"]
    if not rootFrame then
        print("CurrencyFrame: XML frame not loaded yet.")
        return nil
    end
    return rootFrame
end

-- Timeframe mapping (Gold display order by tab index)
-- Row 1: Session, Day, Week, Month, Year, Total
-- Row 2: PrvDay, PrvWeek, PrvMonth, PrvYear
local timeframeMap = {
    [1] = "Session",
    [2] = "Day",
    [3] = "Week",
    [4] = "Month",
    [5] = "Year",
    [6] = "Total",
    [7] = "PrvDay",
    [8] = "PrvWeek",
    [9] = "PrvMonth",
    [10] = "PrvYear",
}

-- Build a reverse lookup from timeframe string to tab index
local timeframeIndexByName = {}
for idx, name in pairs(timeframeMap) do
    timeframeIndexByName[name] = idx
end

-- Ensure tab visuals and sizes follow Gold Tracker conventions at runtime
-- Reusable two-row layout applied after PanelTemplates updates
local function ApplyTwoRowLayout()
    local frame = GetRootFrame()
    if not frame then return end
    local parentName = frame:GetName()
    local xStart, yStart = 15, -20
    local xGap, yRow = 5, -32

    local tab1 = _G[parentName .. "Tab1"]
    if tab1 then
        tab1:ClearAllPoints()
        tab1:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", xStart, yStart)
    end

    -- Row 1: tabs 2..6
    for i = 2, 6 do
        local tab = _G[parentName .. "Tab" .. i]
        local prev = _G[parentName .. "Tab" .. (i - 1)]
        if tab and prev then
            tab:ClearAllPoints()
            tab:SetPoint("LEFT", prev, "RIGHT", xGap, 0)
        end
    end

    -- Row 2: tabs 7..10 align under Tab2's left
    local anchorAbove = _G[parentName .. "Tab2"]
    for i = 7, 10 do
        local tab = _G[parentName .. "Tab" .. i]
        if tab and anchorAbove then
            tab:ClearAllPoints()
            if i == 7 then
                -- Use LEFT anchoring with negative Y to avoid atlas height differences
                tab:SetPoint("LEFT", anchorAbove, "LEFT", 0, yRow)
            else
                local prev = _G[parentName .. "Tab" .. (i - 1)]
                tab:SetPoint("LEFT", prev, "RIGHT", xGap, 0)
            end
        end
    end
end

local function UpdateTabVisuals(selectedIndex)
    local frame = GetRootFrame()
    if not frame then return end
    local parentName = frame:GetName()

    -- Resize each tab based on text width (fallback min width)
    for i = 1, 10 do
        local tab = _G[parentName .. "Tab" .. i]
        if tab then
            -- Set localized text same as Gold using remapped indices
            -- Gold constants.tabText order: 1:Session,2:Day,3:PrvDay,4:Week,5:PrvWeek,6:Month,7:PrvMonth,8:Year,9:PrvYear,10:Total
            -- Our tab index order:        1:Session,2:Day,3:Week,4:Month,5:Year,6:Total,7:PrvDay,8:PrvWeek,9:PrvMonth,10:PrvYear
            local remap = {1,2,4,6,8,10,3,5,7,9}
            if CT_TabText and CT_TabText[remap[i]] and tab.SetText then
                tab:SetText(CT_TabText[remap[i]])
            end
            local textFS = _G[tab:GetName() .. "Text"] or tab:GetFontString()
            -- Force layout by re-setting the existing text before measuring
            if tab.GetText and tab.SetText then
                local t = tab:GetText()
                if t then tab:SetText(t) end
            end
            local textWidth = textFS and textFS:GetStringWidth() or 0
            local minWidth = math.max((textWidth or 0) + 20, 60)
            if PanelTemplates_TabResize then
                -- Padding 25 closely matches Gold spacing on Retail
                PanelTemplates_TabResize(tab, 25)
                -- Guard: PanelTemplates_TabResize may not always expand for very short text
                if tab:GetWidth() < minWidth then
                    tab:SetWidth(minWidth)
                end
            else
                tab:SetWidth(minWidth)
            end

            -- Toggle atlas layers to emulate selected vs normal (use parentKey regions)
            local leftActive   = tab.LeftActive
            local midActive    = tab.MiddleActive
            local rightActive  = tab.RightActive
            local leftNorm     = tab.Left
            local midNorm      = tab.Middle
            local rightNorm    = tab.Right

            local selected = (i == selectedIndex)
            if leftActive and midActive and rightActive and leftNorm and midNorm and rightNorm then
                if selected then
                    leftActive:Show(); midActive:Show(); rightActive:Show()
                    leftNorm:Hide();   midNorm:Hide();   rightNorm:Hide()
                else
                    leftActive:Hide(); midActive:Hide(); rightActive:Hide()
                    leftNorm:Show();   midNorm:Show();   rightNorm:Show()
                end
            end
        end
    end

    -- Let Blizzard PanelTemplates manage selection edge cases as well
    if frame then
        -- Retail uses .numTabs while classics use SetNumTabs API; safe to set both
        frame.numTabs = 10
        if PanelTemplates_SetNumTabs then
            PanelTemplates_SetNumTabs(frame, 10)
        end
        frame.selectedTab = selectedIndex or 1
        local selectedTab = _G[parentName .. "Tab" .. (selectedIndex or 1)]
        if selectedTab and PanelTemplates_SetTab then
            PanelTemplates_SetTab(frame, selectedTab)
        end
        if PanelTemplates_UpdateTabs then
            PanelTemplates_UpdateTabs(frame)
        end
    end

    -- Apply two-row layout now and also on next frame to win any last-minute updates
    ApplyTwoRowLayout()
    if C_Timer and C_Timer.After then C_Timer.After(0, ApplyTwoRowLayout) end
end

local function SetupTabs()
    local frame = GetRootFrame()
    if not frame then return end
    -- Determine which tab should be selected based on currentTimeframe
    local selectedIndex = timeframeIndexByName[currentTimeframe] or 1
    UpdateTabVisuals(selectedIndex)
end

-- Expose setup function for XML OnShow hook
UI.SetupTabs = function()
    -- Defer by 0 to ensure widths are realized after show
    if C_Timer and C_Timer.After then
        C_Timer.After(0, SetupTabs)
    else
        SetupTabs()
    end
end

-- Data cache for current view
local currentData = {}
local MAX_ROWS = 18

-- Update the scroll frame with currency data
local function UpdateScrollFrame()
    local frame = GetRootFrame()
    if not frame then return end
    
    local scrollFrame = _G["AccountantClassicCurrencyScrollBar"]
    if not scrollFrame then return end
    
    -- Load data if needed
    if #currentData == 0 then
        -- Load data for current view
        currentData = {}
        
        -- Set context for data retrieval if we have server/character selections
        local oldServer, oldPlayer
        if currentServer and currentServer ~= GetRealmName() then
            oldServer = _G.AC_SERVER
            _G.AC_SERVER = currentServer
        end
        if currentCharacter and currentCharacter ~= UnitName("player") then
            oldPlayer = _G.AC_PLAYER
            _G.AC_PLAYER = currentCharacter
        end
        
        -- Get data based on current mode
        if currentCurrencyId then
            -- Single currency mode: get currency detail data
            if CurrencyTracker and CurrencyTracker.DataManager then
                -- Respect whitelist toggle like CLI
                local allow = true
                do
                    local wlOn = true
                    if EnsureSavedVariablesStructure and GetCurrentServerAndCharacter then
                        local server, character = GetCurrentServerAndCharacter()
                        local sv = _G.Accountant_ClassicSaveData
                        if sv and sv[server] and sv[server][character] then
                            local charData = sv[server][character]
                            local opt = charData.currencyOptions and charData.currencyOptions.whitelistFilter
                            if opt ~= nil then wlOn = opt and true or false end
                        end
                    end
                    if wlOn and CurrencyTracker.Constants and CurrencyTracker.Constants.CurrencyWhitelist then
                        local wlset = {}
                        for _, id in ipairs(CurrencyTracker.Constants.CurrencyWhitelist) do wlset[id] = true end
                        if not wlset[currentCurrencyId] then
                            allow = false
                        end
                    end
                end
                if allow then
                local data = CurrencyTracker.DataManager:GetCurrencyData(currentCurrencyId, currentTimeframe)
                if data then
                    -- Add summary row
                    table.insert(currentData, {
                        id = currentCurrencyId,
                        name = "Summary",
                        income = data.income or 0,
                        outgoing = data.outgoing or 0,
                        net = (data.income or 0) - (data.outgoing or 0),
                        tracked = true
                    })
                    
                    -- Add source rows if available
                    if data.sources then
                        for source, amount in pairs(data.sources) do
                            table.insert(currentData, {
                                id = currentCurrencyId,
                                name = source,
                                income = amount > 0 and amount or 0,
                                outgoing = amount < 0 and -amount or 0,
                                net = amount,
                                tracked = true
                            })
                        end
                    end
                end
                end
            end
        else
            -- All currencies mode: reuse CLI collection logic to stay consistent
            if CurrencyTracker and CurrencyTracker.CollectMultipleCurrencies then
                local rows = CurrencyTracker:CollectMultipleCurrencies(currentTimeframe, false)
                for _, r in ipairs(rows) do
                    -- Get icon from live API for consistency with CLI names
                    local icon = "Interface\\Icons\\INV_Misc_QuestionMark"
                    if C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
                        local ok, info = pcall(C_CurrencyInfo.GetCurrencyInfo, r.id)
                        if ok and type(info) == "table" and info.iconFileID then
                            icon = info.iconFileID
                        end
                    end
                    table.insert(currentData, {
                        id = r.id,
                        name = r.name,
                        icon = icon,
                        income = r.income or 0,
                        outgoing = r.outgoing or 0,
                        net = r.net or 0,
                        totalMax = r.totalMax or "",
                        tracked = true,
                    })
                end
            end
        end
        
        -- Restore context
        if oldServer then _G.AC_SERVER = oldServer end
        if oldPlayer then _G.AC_PLAYER = oldPlayer end
        
        -- Update dropdown selections if they exist
        if currencyDropdown then
            UIDropDownMenu_SetSelectedValue(currencyDropdown, currentCurrencyId or 0)
        end
        if serverDropdown and currentServer then
            UIDropDownMenu_SetSelectedValue(serverDropdown, currentServer)
        end
        if characterDropdown and currentCharacter then
            UIDropDownMenu_SetSelectedValue(characterDropdown, currentCharacter)
        end
    end
    
    local numRows = #currentData
    local offset = FauxScrollFrame_GetOffset(scrollFrame) or 0
    
    -- Update the scroll frame
    FauxScrollFrame_Update(scrollFrame, numRows, MAX_ROWS, 20)
    
    -- Update row visibility and data
    for i = 1, MAX_ROWS do
        local row = _G[frame:GetName() .. "Row" .. i]
        local dataIndex = i + offset
        
        if row then
            if dataIndex <= numRows and currentData[dataIndex] then
                local data = currentData[dataIndex]
                
                -- Set row data
                local text = _G[row:GetName() .. "Text"]
                local icon = _G[row:GetName() .. "Icon"]
                local income = _G[row:GetName() .. "Income"]
                local outgoing = _G[row:GetName() .. "Outgoing"]
                local net = _G[row:GetName() .. "Net"]
                local totalMax = _G[row:GetName() .. "TotalMax"]
                local track = _G[row:GetName() .. "Track"]
                
                if text then text:SetText(data.name or "") end
                if icon and data.icon then icon:SetTexture(data.icon) end
                
                -- 设置数据并右对齐数字
                -- Column layout (visual order only): Currency | TotalMax | Income | Outgoing | Net
                -- Currency name left-aligned in first segment
                if text then
                    text:SetJustifyH("LEFT")
                    text:ClearAllPoints()
                    text:SetPoint("LEFT", row, "LEFT", COL.NAME_X, 0)
                    text:SetWidth(COL.NAME_W)
                end

                -- TotalMax in first wide segment (right-aligned numbers)
                if totalMax then 
                    local tmv = data.totalMax
                    if IsNumeric(tmv) then tmv = FormatThousands(tmv) end
                    totalMax:SetText(tmv or "")
                    totalMax:SetJustifyH("RIGHT")
                    totalMax:ClearAllPoints()
                    totalMax:SetPoint("LEFT", row, "LEFT", COL.TOTL_X, 0)
                    totalMax:SetWidth(COL.TOTL_W)
                end

                -- Income (right-aligned) in second segment
                if income then 
                    local iv = data.income or 0
                    if IsNumeric(iv) then iv = FormatThousands(iv) end
                    income:SetText(iv)
                    income:SetJustifyH("RIGHT")
                    income:ClearAllPoints()
                    income:SetPoint("LEFT", row, "LEFT", COL.IN_X, 0)
                    income:SetWidth(COL.IN_W)
                end

                -- Outgoing (right-aligned) in middle
                if outgoing then 
                    local ov = data.outgoing or 0
                    if IsNumeric(ov) then ov = FormatThousands(ov) end
                    outgoing:SetText(ov)
                    outgoing:SetJustifyH("RIGHT")
                    outgoing:ClearAllPoints()
                    outgoing:SetPoint("LEFT", row, "LEFT", COL.OUT_X, 0)
                    outgoing:SetWidth(COL.OUT_W)
                end

                -- Net (right-aligned) in third segment
                if net then 
                    local nv = data.net or 0
                    if IsNumeric(nv) then nv = FormatThousands(nv) end
                    net:SetText(nv)
                    net:SetJustifyH("RIGHT")
                    net:ClearAllPoints()
                    net:SetPoint("LEFT", row, "LEFT", COL.NET_X, 0)
                    net:SetWidth(COL.NET_W)
                end
                
                -- Set tracking checkbox
                if track then
                    track.currencyId = data.id
                    track:SetChecked(data.tracked)
                end
                
                row:Show()
            else
                row:Hide()
            end
        end
    end
    
    -- Update subtitle with current timeframe
    local subtitle = _G[frame:GetName() .. "Subtitle"]
    if subtitle then
        local timeframeText = ""
        for id, tf in pairs(timeframeMap) do
            if tf == currentTimeframe then
                local tabText = _G[frame:GetName() .. "Tab" .. id]:GetText()
                timeframeText = tabText
                break
            end
        end
        
        if currentCurrencyId then
            local currencyName = ""
            for _, data in ipairs(currentData) do
                if data.id == currentCurrencyId then
                    currencyName = data.name
                    break
                end
            end
            subtitle:SetText(currencyName .. " - " .. timeframeText)
        else
            subtitle:SetText("All Currencies - " .. timeframeText)
        end
    end
end

-- Refresh data for current view
local function RefreshData()
    currentData = {}
    
    -- Set context for data retrieval if we have server/character selections
    local oldServer, oldPlayer
    if currentServer and currentServer ~= GetRealmName() then
        oldServer = _G.AC_SERVER
        _G.AC_SERVER = currentServer
    end
    if currentCharacter and currentCharacter ~= UnitName("player") then
        oldPlayer = _G.AC_PLAYER
        _G.AC_PLAYER = currentCharacter
    end
    
    -- Get data based on current mode
    if currentCurrencyId then
        -- Single currency mode: get currency detail data
        if CurrencyTracker and CurrencyTracker.DataManager then
            local data = CurrencyTracker.DataManager:GetCurrencyData(currentCurrencyId, currentTimeframe)
            if data then
                -- Add summary row
                table.insert(currentData, {
                    id = currentCurrencyId,
                    name = "Summary",
                    income = data.income or 0,
                    outgoing = data.outgoing or 0,
                    net = (data.income or 0) - (data.outgoing or 0),
                    tracked = true
                })
                
                -- Add source rows if available
                if data.sources then
                    for source, amount in pairs(data.sources) do
                        table.insert(currentData, {
                            id = currentCurrencyId,
                            name = source,
                            income = amount > 0 and amount or 0,
                            outgoing = amount < 0 and -amount or 0,
                            net = amount,
                            tracked = true
                        })
                    end
                end
            end
        end
    else
        -- All currencies mode: reuse CLI collection logic
        if CurrencyTracker and CurrencyTracker.CollectMultipleCurrencies then
            local rows = CurrencyTracker:CollectMultipleCurrencies(currentTimeframe, false)
            for _, r in ipairs(rows) do
                local icon = "Interface\\Icons\\INV_Misc_QuestionMark"
                if C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
                    local ok, info = pcall(C_CurrencyInfo.GetCurrencyInfo, r.id)
                    if ok and type(info) == "table" and info.iconFileID then
                        icon = info.iconFileID
                    end
                end
                table.insert(currentData, {
                    id = r.id,
                    name = r.name,
                    icon = icon,
                    income = r.income or 0,
                    outgoing = r.outgoing or 0,
                    net = r.net or 0,
                    totalMax = r.totalMax or "",
                    tracked = true,
                })
            end
        end
    end
    
    -- Restore context
    if oldServer then _G.AC_SERVER = oldServer end
    if oldPlayer then _G.AC_PLAYER = oldPlayer end
    
    -- Update dropdown selections if they exist
    if currencyDropdown then
        UIDropDownMenu_SetSelectedValue(currencyDropdown, currentCurrencyId or 0)
    end
    if serverDropdown and currentServer then
        UIDropDownMenu_SetSelectedValue(serverDropdown, currentServer)
    end
    if characterDropdown and currentCharacter then
        UIDropDownMenu_SetSelectedValue(characterDropdown, currentCharacter)
    end
end

-- Refresh view and update scroll frame
local function RefreshView()
    -- Clear data cache to force refresh
    currentData = {}
    
    -- Update scroll frame with new data
    UpdateScrollFrame()
    
    -- For backward compatibility, also print to chat
    if not CurrencyTracker then return end
    
    -- Set context for data retrieval if we have server/character selections
    local oldServer, oldPlayer
    if currentServer and currentServer ~= GetRealmName() then
        oldServer = _G.AC_SERVER
        _G.AC_SERVER = currentServer
    end
    if currentCharacter and currentCharacter ~= UnitName("player") then
        oldPlayer = _G.AC_PLAYER
        _G.AC_PLAYER = currentCharacter
    end
    
    -- Print data to chat for backward compatibility
    if currentCurrencyId then
        -- Single currency mode: show currency data
        if CurrencyTracker.PrintCurrencyData then
            -- Respect whitelist toggle: if hidden, skip printing
            local wlOn = true
            if EnsureSavedVariablesStructure and GetCurrentServerAndCharacter then
                local server, character = GetCurrentServerAndCharacter()
                local sv = _G.Accountant_ClassicSaveData
                if sv and sv[server] and sv[server][character] then
                    local charData = sv[server][character]
                    local opt = charData.currencyOptions and charData.currencyOptions.whitelistFilter
                    if opt ~= nil then wlOn = opt and true or false end
                end
            end
            local blocked = false
            if wlOn and CurrencyTracker.Constants and CurrencyTracker.Constants.CurrencyWhitelist then
                local wlset = {}
                for _, id in ipairs(CurrencyTracker.Constants.CurrencyWhitelist) do wlset[id] = true end
                if not wlset[currentCurrencyId] then blocked = true end
            end
            if not blocked then
                CurrencyTracker:PrintCurrencyData(currentCurrencyId, currentTimeframe)
            end
        end
    else
        -- All currencies mode: show all currencies summary
        if CurrencyTracker.PrintMultipleCurrencies then
            CurrencyTracker:PrintMultipleCurrencies(currentTimeframe, false)
        end
    end
    
    -- Restore context
    if oldServer then _G.AC_SERVER = oldServer end
    if oldPlayer then _G.AC_PLAYER = oldPlayer end
    
    -- Save UI state
    SaveUIState()
end

-- Server dropdown initialization and handlers
local function InitializeServerDropdown(dropdown)
    if not dropdown then return end
    
    local function ServerDropdown_OnClick(self, arg1, arg2, checked)
        if not arg1 then return end
        
        currentServer = arg1
        UIDropDownMenu_SetSelectedValue(dropdown, arg1)
        
        -- Update character dropdown when server changes
        if characterDropdown then
            InitializeCharacterDropdown(characterDropdown)
        end
        
        RefreshView()
        SaveUIState() -- Save state when server changes
    end
    
    local function ServerDropdown_Initialize(self, level)
        if not level then return end
        
        local info = UIDropDownMenu_CreateInfo()
        local sv = _G.Accountant_ClassicSaveData
        if not sv then return end
        
        -- Get current server if not set
        if not currentServer then
            currentServer = GetRealmName()
        end
        
        -- Add servers with data
        local servers = {}
        for server in pairs(sv) do
            table.insert(servers, server)
        end
        
        table.sort(servers)
        
        for _, server in ipairs(servers) do
            info.text = server
            info.value = server
            info.arg1 = server
            info.func = ServerDropdown_OnClick
            info.checked = (currentServer == server)
            UIDropDownMenu_AddButton(info, level)
        end
    end
    
    UIDropDownMenu_Initialize(dropdown, ServerDropdown_Initialize)
    UIDropDownMenu_SetWidth(dropdown, 160)
    UIDropDownMenu_SetButtonWidth(dropdown, 174)
    UIDropDownMenu_SetSelectedValue(dropdown, currentServer or GetRealmName())
    UIDropDownMenu_JustifyText(dropdown, "LEFT")
    
    -- Set label
    local dropdownLabel = _G[dropdown:GetName() .. "Label"]
    if dropdownLabel then
        dropdownLabel:SetText("Server")
    end
    
    dropdown:Show()
end

-- Character dropdown initialization and handlers
local function InitializeCharacterDropdown(dropdown)
    if not dropdown then return end
    
    local function CharacterDropdown_OnClick(self, arg1, arg2, checked)
        if not arg1 then return end
        
        currentCharacter = arg1
        UIDropDownMenu_SetSelectedValue(dropdown, arg1)
        RefreshView()
        SaveUIState() -- Save state when character changes
    end
    
    local function CharacterDropdown_Initialize(self, level)
        if not level then return end
        
        local info = UIDropDownMenu_CreateInfo()
        local sv = _G.Accountant_ClassicSaveData
        if not sv or not currentServer or not sv[currentServer] then return end
        
        -- Get current character if not set
        if not currentCharacter then
            currentCharacter = UnitName("player")
        end
        
        -- Add characters with data for this server
        local characters = {}
        for character in pairs(sv[currentServer]) do
            table.insert(characters, character)
        end
        
        table.sort(characters)
        
        for _, character in ipairs(characters) do
            info.text = character
            info.value = character
            info.arg1 = character
            info.func = CharacterDropdown_OnClick
            info.checked = (currentCharacter == character)
            UIDropDownMenu_AddButton(info, level)
        end
    end
    
    UIDropDownMenu_Initialize(dropdown, CharacterDropdown_Initialize)
    UIDropDownMenu_SetWidth(dropdown, 160)
    UIDropDownMenu_SetButtonWidth(dropdown, 174)
    UIDropDownMenu_SetSelectedValue(dropdown, currentCharacter or UnitName("player"))
    UIDropDownMenu_JustifyText(dropdown, "LEFT")
    
    -- Set label
    local dropdownLabel = _G[dropdown:GetName() .. "Label"]
    if dropdownLabel then
        dropdownLabel:SetText("Character")
    end
    
    dropdown:Show()
end

-- Currency dropdown initialization and handlers
local function InitializeCurrencyDropdown(dropdown)
    if not dropdown then return end
    
    local function CurrencyDropdown_OnClick(self, arg1, arg2, checked)
        if not arg1 then return end
        
        if arg1 == 0 then -- 0 means "All Currencies"
            currentCurrencyId = nil
        else
            currentCurrencyId = arg1
        end
        
        UIDropDownMenu_SetSelectedValue(dropdown, arg1)
        RefreshView()
        SaveUIState() -- Save state when currency changes
    end
    
    local function CurrencyDropdown_Initialize(self, level)
        if not level then return end
        
        local info = UIDropDownMenu_CreateInfo()
        
        -- Add "All Currencies" option
        info.text = "All Currencies"
        info.value = 0
        info.arg1 = 0
        info.func = CurrencyDropdown_OnClick
        info.checked = (currentCurrencyId == nil)
        UIDropDownMenu_AddButton(info, level)
        
        -- Add discovered currencies
        if CurrencyTracker and CurrencyTracker.Storage and CurrencyTracker.Storage.GetDiscoveredCurrencies then
            local discovered = CurrencyTracker.Storage:GetDiscoveredCurrencies() or {}
            
            -- Collect and sort currencies
            local currencies = {}
            for id, meta in pairs(discovered) do
                if meta and meta.tracked ~= false then -- Only show tracked currencies by default
                    local name = meta.name or ("Currency " .. tostring(id))
                    -- Apply localization if available
                    local L = CT_GetL()
                    if L and L[name] then name = L[name] end
                    
                    table.insert(currencies, {id = id, name = name})
                end
            end
            
            -- Sort by name
            table.sort(currencies, function(a, b) return a.name < b.name end)
            
            -- Add to dropdown
            for _, currency in ipairs(currencies) do
                info.text = currency.name
                info.value = currency.id
                info.arg1 = currency.id
                info.func = CurrencyDropdown_OnClick
                info.checked = (currentCurrencyId == currency.id)
                UIDropDownMenu_AddButton(info, level)
            end
        end
    end
    
    UIDropDownMenu_Initialize(dropdown, CurrencyDropdown_Initialize)
    UIDropDownMenu_SetWidth(dropdown, 160)
    UIDropDownMenu_SetButtonWidth(dropdown, 174)
    UIDropDownMenu_SetSelectedValue(dropdown, currentCurrencyId or 0)
    UIDropDownMenu_JustifyText(dropdown, "LEFT")
    
    -- Set label
    local dropdownLabel = _G[dropdown:GetName() .. "Label"]
    if dropdownLabel then
        dropdownLabel:SetText("Currency")
    end
    
    dropdown:Show()
end

-- Timeframe tab click handler
local function OnTimeframeTabClicked(self, button, down)
    local newTimeframe = timeframeMap[self:GetID()]
    if newTimeframe then
        currentTimeframe = newTimeframe
        -- Update tab selected visuals to mirror Gold
        UpdateTabVisuals(self:GetID())
        RefreshView()
        SaveUIState() -- Save state when timeframe changes
    end
end

-- Public API
function UI:Initialize()
    if initialized then return true end
    local f = GetRootFrame()
    if not f then return false end
    
    -- Set up frame for dragging
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetClampedToScreen(true)
    
    -- Set character portrait
    local portrait = _G[f:GetName() .. "Portrait"]
    if portrait then
        SetPortraitTexture(portrait, "player")
    end
    
    -- Set up scroll background
    local bg = f.ScrollBackground
    if bg then
        bg:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 5, right = 5, top = 5, bottom = 5 }
        })
        bg:SetBackdropColor(0, 0, 0, 0.5)
    end
    
    -- Load saved state
    LoadUIState()
    
    -- Wire timeframe tabs
    for i = 1, 10 do -- Wire all 10 timeframe tabs
        local tab = f["Tab" .. i]
        if tab then
            tab:SetScript("OnClick", OnTimeframeTabClicked)
            -- Tooltip to mirror Gold
            local remap = {1,2,4,6,8,10,3,5,7,9}
            if CT_TabTips and CT_TabTips[remap[i]] then
                tab:HookScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_TOP")
                    GameTooltip:SetText(CT_TabTips[remap[i]])
                end)
                tab:HookScript("OnLeave", function()
                    GameTooltip:Hide()
                end)
            end
        end
    end

    -- Apply runtime visual sizing/selection like Gold
    SetupTabs()

    -- Safety: re-apply layout whenever PanelTemplates updates tabs on this frame
    if hooksecurefunc then
        hooksecurefunc("PanelTemplates_UpdateTabs", function(f)
            local frame = GetRootFrame()
            if frame and f == frame then
                ApplyTwoRowLayout()
                if C_Timer and C_Timer.After then C_Timer.After(0, ApplyTwoRowLayout) end
            end
        end)
    end

    -- Also re-apply on size changes (some UIs resize after show)
    if rootFrame and not rootFrame._ct_onSizeHooked then
        rootFrame:HookScript("OnSizeChanged", function()
            ApplyTwoRowLayout()
        end)
        rootFrame._ct_onSizeHooked = true
    end
    
    -- Initialize server dropdown
    serverDropdown = f.ServerDropDown
    if serverDropdown then
        InitializeServerDropdown(serverDropdown)
    end
    
    -- Initialize character dropdown
    characterDropdown = f.CharacterDropDown
    if characterDropdown then
        InitializeCharacterDropdown(characterDropdown)
    end
    
    -- Initialize currency dropdown
    currencyDropdown = f.CurrencyDropDown
    if currencyDropdown then
        InitializeCurrencyDropdown(currencyDropdown)
    end
    
    -- Set up header row
    local headerRow = f.HeaderRow
    if headerRow then
        -- Localize header text if available
        local L = CT_GetL()
        if L then
            local nameHeader = _G[headerRow:GetName() .. "NameHeader"]
            local incomeHeader = _G[headerRow:GetName() .. "IncomeHeader"]
            local outgoingHeader = _G[headerRow:GetName() .. "OutgoingHeader"]
            local netHeader = _G[headerRow:GetName() .. "NetHeader"]
            local totalMaxHeader = _G[headerRow:GetName() .. "TotalMaxHeader"]
            
            if nameHeader and L["Currency"] then nameHeader:SetText(L["Currency"]) end
            if incomeHeader and L["Income"] then incomeHeader:SetText(L["Income"]) end
            if outgoingHeader and L["Outgoing"] then outgoingHeader:SetText(L["Outgoing"]) end
            if netHeader and L["Net"] then netHeader:SetText(L["Net"]) end
            if totalMaxHeader and L["Total Max"] then totalMaxHeader:SetText(L["Total Max"]) end
        end
    end
    
    -- Initialize data
    currentData = {}
    
    initialized = true
    return true
end

function UI:Enable()
    return true
end

function UI:Disable()
    return true
end

function UI:Show()
    if not initialized then self:Initialize() end
    if rootFrame then 
        rootFrame:Show() 
        -- Refresh view when showing the frame
        RefreshView()
        -- Immediate header pass to avoid one-frame flicker
        ApplyHeaderLabels()
        -- Apply tab visuals after frame becomes visible to ensure widths are realized
        if C_Timer and C_Timer.After then
            C_Timer.After(0, SetupTabs)
            -- Defer header labels one frame to win over any XML defaults
            C_Timer.After(0, ApplyHeaderLabels)
        else
            SetupTabs()
            -- Already applied immediately above
        end
    end
end

function UI:Toggle(state)
    if not initialized then self:Initialize() end
    if not rootFrame then return end
    if state == nil then
        if rootFrame:IsShown() then 
            rootFrame:Hide() 
        else 
            rootFrame:Show()
            -- Refresh view when showing the frame
            RefreshView()
            -- Immediate header pass
            ApplyHeaderLabels()
            if C_Timer and C_Timer.After then
                C_Timer.After(0, SetupTabs)
                C_Timer.After(0, ApplyHeaderLabels)
            else
                SetupTabs()
            end
        end
    elseif state then
        rootFrame:Show()
        -- Refresh view when showing the frame
        RefreshView()
        -- Immediate header pass
        ApplyHeaderLabels()
        if C_Timer and C_Timer.After then
            C_Timer.After(0, SetupTabs)
            C_Timer.After(0, ApplyHeaderLabels)
        else
            SetupTabs()
        end
    else
        rootFrame:Hide()
    end
end

-- Tracking checkbox handler - uses existing CLI handler for state changes
local function OnTrackingCheckboxClicked(checkbox, currencyId)
    if not checkbox or not currencyId or not CurrencyTracker then return end
    
    -- Get current state
    local checked = checkbox:GetChecked()
    local stateStr = checked and "on" or "off"
    
    -- Use existing CLI handler to toggle tracking state (no code duplication)
    if CurrencyTracker.DiscoverTrack then
        local sub = "track " .. tostring(currencyId) .. " " .. stateStr
        CurrencyTracker:DiscoverTrack(sub)
    end
    
    -- Refresh view to reflect changes
    RefreshView()
end

-- Mouse handling for dragging the frame
local function OnMouseDown(frame, button)
    if button == "LeftButton" then
        frame:StartMoving()
    end
end

local function OnMouseUp(frame, button)
    frame:StopMovingOrSizing()
end

local function OnEvent(frame, event, ...)
    -- Handle events if needed
end

-- Expose functions for XML scripts
UI.OnTimeframeTabClicked = OnTimeframeTabClicked
UI.RefreshView = RefreshView
UI.OnTrackingCheckboxClicked = OnTrackingCheckboxClicked
UI.UpdateScrollFrame = UpdateScrollFrame

-- Make mouse handling functions available globally
_G.AccountantClassicCurrency_OnMouseDown = OnMouseDown
_G.AccountantClassicCurrency_OnMouseUp = OnMouseUp
_G.AccountantClassicCurrency_OnEvent = OnEvent
