local _, L = ...; -- Let's use the private table passed to every .lua file to store our locale
if GetLocale() ~= "zhCN" then
    return;
end

if false then
    L.SELL_GREY = "售卖垃圾: "

    L.REPAIR_REPUT = "修理失败: 声望不足"
    L.REPAIR_MONEY = "修理失败: 没有足够的金币"
    L.REPAIR_OK = "修理成功，花费: "

    L.URL_TEXT = "Ctrl-C复制URI"
    L.URL_BTN1 =  "确定"
    L.URL_BTN2 = "取消"

    L.REPUTATIONS = {
        "仇恨",
        "敌对",
        "冷淡",
        "中立",
        "友善",
        "尊敬",
        "崇敬",
        "崇拜",
    }

    L.AutoRepairBtn = {
        text = "自动修理",
    }

    L.UseGuildRepairBtn = {
        text = "工会修理",
    }

    L.ReputSlider = {
        text = "自动修理的最低声望",
        tooltip = "自动修理的最低声望",
    }

    L.VendorGreysBtn = {
        text = "自动售卖灰色物品"
    }

    L.NameplateColorBtn = {
        text = "Class nameplate color"
    }

    L.ClassIconPortraitBtn = {
        text = "Class portrait (need /reload)"
    }
end

L.SELL_GREY = "|cffefef00网易有爱: |r售卖垃圾 |cff00ff00收入:|r "

L.REPAIR_REPUT = "|cffefef00网易有爱: |r|cffff0000修理失败: 声望不足|r"
L.REPAIR_MONEY = "|cffefef00网易有爱: |r|cffff0000修理失败: 没有足够的金币|r"
L.REPAIR_OK = "|cffefef00网易有爱: |r修理成功 |cffff0000花费:|r "
L.BALANCE_P = "|cffefef00网易有爱: |r|cff00ff00本次交易累计获利:|r "
L.BALANCE_N = "|cffefef00网易有爱: |r|cffff0000本次交易累计亏损:|r "

L.URL_TEXT = "Ctrl-C复制URI"
L.URL_BTN1 =  "确定"
L.URL_BTN2 = "取消"

L.REPUTATIONS = {
    "仇恨",
    "敌对",
    "冷淡",
    "中立",
    "友善",
    "尊敬",
    "崇敬",
    "崇拜",
}

L.AutoRepairBtn = {
    text = "自动修理",
}

L.UseGuildRepairBtn = {
    text = "工会修理",
}

L.ReputSlider = {
    text = "自动修理的最低声望",
    tooltip = "自动修理的最低声望",
}

L.VendorGreysBtn = {
    text = "自动售卖灰色物品"
}

L.VendorWhitesBtn = {
    text = "自动售卖白色武器、护甲"
}

L.NameplateColorBtn = {
    text = "Class nameplate color"
}

L.ClassIconPortraitBtn = {
    text = "Class portrait (need /reload)"
}