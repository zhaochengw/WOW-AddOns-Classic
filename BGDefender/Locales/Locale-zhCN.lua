--[[****************************************************************************
  * Locales/Locale-zhCN.lua - Localized string constants (zh-CN).              *
  ****************************************************************************]]
function BGD_init_zhCN()
    BGD_HELP    = "$base 需要帮忙需要帮忙！！！！"
    BGD_SAFE    = "$base 已经安全."
    BGD_INC     = "注意!$base 有 $num 来袭！"
    BGD_INCPLUS = "救命阿！ $base 对面开火车来！"
end

if (GetLocale() == "zhCN") then
    BGD_AV      = "奥特兰克山谷"
    BGD_AB      = "阿拉希盆地"
    BGD_WSG     = "战歌峡谷"
    BGD_WSL     = "战歌伐木场"
    BGD_SWH     = "银翼要塞"
    BGD_EOTS    = "暴风之眼"
    BGD_SOTA    = "远祖滩头"
    BGD_IOC     = "征服之岛"
    BGD_TP      = "双子峰"
    BGD_DMH     = "龙喉要塞"
    BGD_GIL     = "吉尔尼斯之战"

    BGD_WG      = "冬握湖"
    BGD_TB      = "托巴拉德"

    BGD_AWAY    = "你并没有靠近任何防卫点"
    BGD_OUT     = "你不在战场里!"

    BGD_GENERAL = "综合"
end