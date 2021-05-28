local _, L = ...;
if GetLocale() == "zhCN" then
    L.SELL_GREY = "出售: "

    L.REPAIR_REPUT = "修理: 声望不足"
    L.REPAIR_MONEY = "修理: 金币不足"
    L.REPAIR_OK = "修理: "

    L.URL_TEXT = "按 Ctrl-C 来拷贝 URI"
    L.URL_BTN1 =  "完成"
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
        text = "公会修理",
    }

    L.ReputSlider = {
        text = "声望限制",
        tooltip = "自动修理所需的最低声望",
    }

    L.VendorGreysBtn = {
        text = "贩卖垃圾"
    }

    L.NameplateColorBtn = {
        text = "Class nameplate color"
    }

    L.ClassIconPortraitBtn = {
        text = "Class portrait (need /reload)"
    }
end