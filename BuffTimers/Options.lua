local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent

RegEvent("ADDON_LOADED", function()
    if not BuffTimersOptions then
        BuffTimersOptions = {}
    end
end)

local defs = {}
local function GetConfigOrDefault(key, def)
    defs[key] = def

    if BuffTimersOptions[key] == nil then
        BuffTimersOptions[key] = def
    end

    return BuffTimersOptions[key]
end

local changedcb = {}
local function RegisterKeyChangedCallback(key, cb)
    if not changedcb[key] then
        changedcb[key] = {}
    end

    table.insert(changedcb[key] , cb)
end
ADDONSELF.RegisterKeyChangedCallback = RegisterKeyChangedCallback

local function triggerCallback(key, value)
    for _, cb in pairs(changedcb[key] or {}) do
        cb(value)
    end
end

local function SetConfig(key, value)
    BuffTimersOptions[key] = value

    triggerCallback(key, value)
end


local f = CreateFrame("Frame", nil, UIParent)
f.name = L["BuffTimers"]
InterfaceOptions_AddCategory(f)

do
    local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    t:SetText(L["BuffTimers"])
    t:SetPoint("TOPLEFT", f, 15, -15)
end

local function createCheckbox(title, key, def)
    local b = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
    b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    b.text:SetPoint("LEFT", b, "RIGHT", 0, 1)
    b.text:SetText(title)
    b.text:SetTextColor(1, 1, 1)
    b:SetScript("OnClick", function()
        SetConfig(key, b:GetChecked())
    end)

    RegisterKeyChangedCallback(key, function(v)
        b:SetChecked(v)
    end)

    triggerCallback(key, GetConfigOrDefault(key, def))
    return b
end

local function createSlider(key, minValue, maxValue, valueStep, minText, maxText, title, textOnValueChanged, default)
    local s = CreateFrame("Slider", f, f, "OptionsSliderTemplate")
    s:SetOrientation("HORIZONTAL")
    s:SetHeight(14)
    s:SetWidth(160)
    s:SetMinMaxValues(minValue, maxValue)
    s:SetValueStep(valueStep)
    s.Low:SetText(minText)
    s.High:SetText(maxText)

    local l = s:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    l:SetPoint("RIGHT", s, "LEFT", -20, 1)
    l:SetText(title)
    l:SetTextColor(1, 1, 1)

    s:SetScript("OnValueChanged", function(self, value)
        s.Text:SetText(textOnValueChanged(value))
        SetConfig(key, value)
    end)

    RegisterKeyChangedCallback(key, function(v)
        s:SetValue(v)
    end)

    triggerCallback(key, GetConfigOrDefault(key, default))
    return s, l
end

RegEvent("PLAYER_LOGIN", function()
    f.default = function()
        for k, v in pairs(defs) do
            SetConfig(k, v)
        end
    end

    f.refresh = function()
    end

    local base = -15
    local nextpos = function(offset)
        if not offset then
            offset = 30
        end
        base = base - offset
        return base
    end

    do
        local key = "time_stamp"
        local options = {
            ["m"] = "minutes (119m)",
            ["hm"] = "h:mm (1:59h)",
        }
        local d = CreateFrame("Frame", f, f, "UIDropDownMenuTemplate")

        local l = d:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        l:SetPoint("RIGHT", d, "LEFT", -20, 1)
        l:SetText(L["Time Stamp Format"])
        l:SetTextColor(1, 1, 1)

        d:SetPoint("TOPLEFT", f, 40 + l:GetStringWidth(), nextpos(45))

        d.initialize = function()
            for k, option in next, options do
                local info = UIDropDownMenu_CreateInfo()
                info.text = options[k]
                info.value = k
                info.checked = k == GetConfigOrDefault(key, "m")
                info.func = function(self)
                    SetConfig(key, self.value)
                    UIDropDownMenu_SetText(d, options[self.value])
                end

                UIDropDownMenu_AddButton(info)
            end
        end
        UIDropDownMenu_SetText(d, options[GetConfigOrDefault(key, "m")])

        triggerCallback(key, GetConfigOrDefault(key, "m"))
    end

    do
        local b = createCheckbox(L["Show seconds"], "seconds", false)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local func = function (value) return SecondsToTime(value * 60) end
        local s, l = createSlider("seconds_threshold", 1, 120, 1, SecondsToTime(60), SecondsToTime(7200), L["Show seconds below this time"], func, 30)
        s:SetPoint("TOPLEFT", f, 40 + l:GetStringWidth(), nextpos(45))
    end

    do
        local b = createCheckbox(L["Show milliseconds below 5 seconds"], "milliseconds", true)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local b = createCheckbox(L["Always yellow text color"], "yellow_text", false)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local b = createCheckbox(L["Add more colors to the timer"], "colored_text", false)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local b = createCheckbox(L["Customize text"], "customize_text", false)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local s, l = createSlider("vertical_position", -100, 100, 1, "-100", "100", L["Text vertical position"], tostring, -34)
        s:SetPoint("TOPLEFT", f, 40 + l:GetStringWidth(), nextpos(45))
    end

    do
        local s, l = createSlider("font_size", 1, 100, 1, "1", "100", L["Text font size"], tostring, 14)
        s:SetPoint("TOPLEFT", f, 40 + l:GetStringWidth(), nextpos(45))
    end
end)
