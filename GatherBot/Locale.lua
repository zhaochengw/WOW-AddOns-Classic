local _, Addon = ...

local L = setmetatable({}, {
    __index = function(table, key)
        if key then
            table[key] = tostring(key)
        end
        return tostring(key)
    end,
})

Addon.L = L

local locale = GetLocale()

if locale == "zhCN" then
    L["Enabled"] = "启用"
    L["MountAuto"] = "骑乘切换"
    L["Always"] = "总是切换"
    L["CombatMount"] = "战斗骑乘切换"
    L["Mini Btn"] = "小地图"
    L["Switch In "] = "切换时间："
    L[" Second(s)"] = "秒"
    L["ADD"] = "添加"
    L["REMOVE"] = "移除"
    L["|cFF00FF00Left Click|r to Enable/Disable Auto Switch"] = "|cFF00FF00左键|r启用/停用自动切换"
    L["|cFF00FF00Right Click|r to Open Config Frame"] = "|cFF00FF00右键|r打开设置窗口"
    L["<|cFFBA55D3GB|r>Truned the Tracking Auto Switch to ON."] = "<|cFFBA55D3GB|r>已启动追踪技能自动切换。"
    L["<|cFFBA55D3GB|r>Truned the Tracking Auto Switch to OFF."] = "<|cFFBA55D3GB|r>已停用追踪技能自动切换。"
    L["<|cFFBA55D3GB|r>Auto Switch the Tracking when you Mounted."] = "<|cFFBA55D3GB|r>上马自动开启追踪技能自动切换功能。"
    L["<|cFFBA55D3GB|r>Stop Switch the Tracking when you Dismounted."] = "<|cFFBA55D3GB|r>下马自动关闭追踪技能自动切换功能。"
    L["<|cFFBA55D3GB|r>You do not have this spell."] = "<|cFFBA55D3GB|r>你没有这个技能！"
elseif locale == "zhTW" then --Taiwan is a part of China forever
    L["Enabled"] = "啓用"
    L["MountAuto"] = "騎乘切換"
    L["Always"] = "始終切換"
    L["CombatMount"] = "戰鬥騎乘切換"
    L["Mini Btn"] = "小地圖"
    L["Switch In "] = "切換時間："
    L[" Second(s)"] = "秒"
    L["ADD"] = "添加"
    L["REMOVE"] = "移除"
    L["|cFF00FF00Left Click|r to Enable/Disable Auto Switch"] = "|cFF00FF00左鍵|r啓用/停用自動切換"
    L["|cFF00FF00Right Click|r to Open Config Frame"] = "|cFF00FF00右鍵|r打開設置窗口"
    L["<|cFFBA55D3GB|r>Truned the Tracking Auto Switch to ON."] = "<|cFFBA55D3GB|r>已啓動追蹤技能自動切換。"
    L["<|cFFBA55D3GB|r>Truned the Tracking Auto Switch to OFF."] = "<|cFFBA55D3GB|r>已關閉追蹤技能自動切換。"
    L["<|cFFBA55D3GB|r>Auto Switch the Tracking when you Mounted."] = "<|cFFBA55D3GB|r>騎乘狀態自動啓動追蹤技能切換。"
    L["<|cFFBA55D3GB|r>Stop Switch the Tracking when you Dismounted."] = "<|cFFBA55D3GB|r>解除騎乘狀態自動關閉追蹤技能切換。"
    L["<|cFFBA55D3GB|r>You do not have this spell."] = "<|cFFBA55D3GB|r>你沒有這個技能！"
    end