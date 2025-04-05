local _, L = ...;
if GetLocale() == "zhTW" then
    L.SELL_GREY = "出售: "

    L.REPAIR_REPUT = "修理: 聲望不足"
    L.REPAIR_MONEY = "修理: 金幣不足"
    L.REPAIR_OK = "修理: "

    L.URL_TEXT = "按 Ctrl-C 來拷貝 URI"
    L.URL_BTN1 =  "完成"
    L.URL_BTN2 = "取消"

    L.REPUTATIONS = {
        "仇恨",
        "敵對",
        "冷淡",
        "中立",
        "友善",
        "尊敬",
        "崇敬",
        "崇拜",
    }

    L.AutoRepairBtn = {
        text = "自動修理",
    }

    L.UseGuildRepairBtn = {
        text = "公會修理",
    }

    L.ReputSlider = {
        text = "聲望限制",
        tooltip = "自動修理所需的最低聲望",
    }

    L.VendorGreysBtn = {
        text = "販賣垃圾"
    }

    L.NameplateColorBtn = {
        text = "Class nameplate color"
    }

    L.ClassIconPortraitBtn = {
        text = "Class portrait (need /reload)"
    }
end
