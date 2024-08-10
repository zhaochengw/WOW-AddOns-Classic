local addonName, MIS = ...
MacroIconSearch = MIS

local OIconDataProvider = nil
local searchQuery = ""
local icons = {}

EventUtil.ContinueOnAddOnLoaded(addonName, function()
    if not IsAddOnLoaded("MacroSetup") then
        MIS:BuildIconCache()
    else
        MIS.GetIconCache = MacroSetup.GetIconCache
    end

    MacroPopupFrame:HookScript("OnShow", function(self)
        searchQuery = ""
        OIconDataProvider = self.iconDataProvider
        MacroIconSearchFrame:ClearAllPoints()
        MacroIconSearchFrame:SetParent(self)
        MacroIconSearchFrame:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 2, -5)
        MacroIconSearchFrame:Show()
        MacroIconSearchFrame.IconSearchQueryEditBox:SetFocus()
    end)
    
    MacroPopupFrame:HookScript("OnHide", function(self)
        MacroIconSearchFrame:Hide()
        MacroIconSearchFrame.IconSearchQueryEditBox:SetText("")
        wipe(icons)
    end)

-- 如果 GearManagerPopupFrame 不存在，移除或注释掉相关代码
-- GearManagerPopupFrame:HookScript("OnShow", function(self)
--     searchQuery = ""
--     OIconDataProvider = self.iconDataProvider
--     MacroIconSearchFrame:ClearAllPoints()
--     MacroIconSearchFrame:SetParent(self)
--     MacroIconSearchFrame:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 2, -5)
--     MacroIconSearchFrame:Show()
--     MacroIconSearchFrame.IconSearchQueryEditBox:SetFocus()
-- end)
-- 
-- GearManagerPopupFrame:HookScript("OnHide", function(self)
--     MacroIconSearchFrame:Hide()
--     MacroIconSearchFrame.IconSearchQueryEditBox:SetText("")
--     wipe(icons)
-- end)
end)

-- Will change it to a coroutine later
local function UpdateIcons()
    wipe(icons)
    tinsert(icons, [[INTERFACE\ICONS\INV_MISC_QUESTIONMARK]])

    local exactMatch = searchQuery:find("\"$", 1)
    for name, icon in pairs(MIS.GetIconCache()) do
        if (exactMatch and name == searchQuery:sub(1, exactMatch - 1)) or name:lower():find(searchQuery:lower(), 1, true) then
            tinsert(icons, icon)
        end
    end
end

local IconDataProvider = CreateAndInitFromMixin(IconDataProviderMixin)
function IconDataProvider:GetIconByIndex(index)
    return icons[index]
end

function IconDataProvider:GetNumIcons()
    return #icons
end

function MIS:SetCustomIcon(editBox, text)
    local iconID = tonumber(text)
    if iconID then
        local parent = MacroIconSearchFrame:GetParent()
        parent.IconSelector.selectedCallback(nil, iconID)
        parent.IconSelector:SetSelectedIndex(1)
        parent.BorderBox.IconSelectorEditBox:SetFocus()
        editBox:SetText("")
    end
end

function MIS:OnTextChanged(editBox, isThrottle)
    if isThrottle then
        local parent = MacroIconSearchFrame:GetParent()
        searchQuery = editBox:GetText()

        local update = false
        if not self.lastSearchQuery or self.lastSearchQuery ~= searchQuery then
            update = true
        end

        if searchQuery == "" then
            parent.iconDataProvider = OIconDataProvider
            parent:Update()
        else
            if parent.iconDataProvider == OIconDataProvider then
                parent.iconDataProvider = IconDataProvider
                local getSelection = GenerateClosure(IconDataProvider.GetIconByIndex, parent)
                local getNumSelections = GenerateClosure(IconDataProvider.GetNumIcons, parent)
                parent.IconSelector:SetSelectionsDataProvider(getSelection, getNumSelections)
            end

            if update then
                UpdateIcons()
                parent.IconSelector:UpdateSelections()
                self.lastSearchQuery = searchQuery
            end
        end
    else
        self.throttle = self.throttle or C_Timer.NewTimer(0.2, function()
            MIS.throttle = nil
            MIS:OnTextChanged(editBox, true)
        end)
    end
end

function MIS:OnEnterPressed()
    local parent = MacroIconSearchFrame:GetParent()
    parent.BorderBox.IconSelectorEditBox:SetFocus()
end

do 
    local iconCache = {}
    function MIS:BuildIconCache()
        -- https://github.com/WeakAuras/WeakAuras2/blob/5dbf5b2c3271a256f132d25dcc7f1d6040bbb490/WeakAuras/WeakAuras.lua#L4059
        wipe(iconCache)
        local co = coroutine.create(function()
            local id = 0
            local misses = 0
            while misses < 80000 do
                id = id + 1
                local name, _, icon = GetSpellInfo(id)

                if icon == 136243 then
                    misses = 0;
                elseif name and name ~= "" and icon then
                    iconCache[name] = icon
                    misses = 0
                else
                    misses = misses + 1
                end
                coroutine.yield()
            end
        end)


        local coFrame = CreateFrame("Frame")
        local keepRunning = true;
        coFrame:SetScript("OnUpdate", function(self, elapsed)
            -- Start timing
            local start = debugprofilestop();
            -- Resume as often as possible (Limit to 16ms per frame -> 60 FPS)
            while (debugprofilestop() - start < 10 and keepRunning) do
                if coroutine.status(co) ~= "dead" then
                    local ok, msg = coroutine.resume(co)
                    if not ok then
                        geterrorhandler()(msg .. '\n' .. debugstack(co))
                    end
                else
                    keepRunning = false
                    coFrame:SetScript("OnUpdate", nil)
                end
            end
        end);
    end

    function MIS.GetIconCache()
        return iconCache
    end
end