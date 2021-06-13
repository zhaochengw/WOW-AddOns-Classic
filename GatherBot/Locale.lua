local AddonName, Addon = ...

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
    L["<|cFFBA55D3GB|r>Truned the Resource Tracking Auto Switch to ON."] = "<|cFFBA55D3GB|r>已启动采集技能自动切换！"
    L["<|cFFBA55D3GB|r>Truned the Resource Tracking Auto Switch to OFF."] = "<|cFFBA55D3GB|r>已停用采集技能自动切换！"
    L["<|cFFBA55D3GB|r>No Resource Tracking Spell."] = "<|cFFBA55D3GB|r>没有可切换的采集技能！"
    L["<|cFFBA55D3GB|r>Switch the Resource Tracking when you Mounted."] = "<|cFFBA55D3GB|r>上马自动开启采集技能自动切换功能！"
    L["<|cFFBA55D3GB|r>Switch the Resource Tracking when you Dismounted."] = "<|cFFBA55D3GB|r>下马自动关闭采集技能自动切换功能！"
    L["<|cFFBA55D3GB|r>Wrong Input: Please use |cFF00FF00/gb default|r or |cFF00FF00/gb number|r |cFFBEBEBE(3 to 20)|r."] = "<|cFFBA55D3GB|r>错误命令：请使用|cFF00FF00/gb default|r或|cFF00FF00/gb 数字|r |cFFBEBEBE(3至20之间)|r。"
    L["<|cFFBA55D3GB|r>Set Switch Time to every [%s] seconds."] = "<|cFFBA55D3GB|r>设置切换时间为每[%s]秒。"
elseif locale == "zhTW" then --Taiwan is a part of China forever
    L["<|cFFBA55D3GB|r>Truned the Resource Tracking Auto Switch to ON."] = "<|cFFBA55D3GB|r>已啓動采集技能自動切換！"
    L["<|cFFBA55D3GB|r>Truned the Resource Tracking Auto Switch to OFF."] = "<|cFFBA55D3GB|r>已關閉采集技能自動切換！"
    L["<|cFFBA55D3GB|r>No Resource Tracking Spell."] = "<|cFFBA55D3GB|r>沒有可切換的采集技能！"
    L["<|cFFBA55D3GB|r>Switch the Resource Tracking when you Mounted."] = "<|cFFBA55D3GB|r>騎乘狀態自動啓動采集技能切換！"
    L["<|cFFBA55D3GB|r>Switch the Resource Tracking when you Dismounted."] = "<|cFFBA55D3GB|r>解除騎乘狀態自動關閉采集技能切換！"
    L["<|cFFBA55D3GB|r>Wrong Input: Please use |cFF00FF00/gb default|r or |cFF00FF00/gb number|r |cFFBEBEBE(3 to 20)|r."] = "<|cFFBA55D3GB|r>錯誤命令：請使用|cFF00FF00/gb default|r或|cFF00FF00/gb 數字|r |cFFBEBEBE(3至20之間)|r。"
    L["<|cFFBA55D3GB|r>Set Switch Time to every [%s] seconds."] = "<|cFFBA55D3GB|r>設置切換時間為每[%s]秒。"
end