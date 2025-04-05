local L = LibStub("AceLocale-3.0"):NewLocale("CopyAnything", "zhTW")
if not L then return end

L["copyAnything"] = "複製文字"
L["copyFrame"] = "複製視窗"
L["fastCopy"] = "快速複製"
L["fastCopyDesc"] = "按 CTRL+C 複製文字後自動隱藏複製文字視窗。"
L["fontStrings"] = "文字字串"
L["general"] = "一般"
L["invalidSearchType"] = "無效的搜尋類型 '%s'，請檢查設定選項。"
L["mouseFocus"] = "滑鼠焦點"
L["noTextFound"] = "沒有找到可供複製的文字。"
L["parentFrames"] = "上一層框架"
L["profiles"] = "設定檔"
L["searchType"] = "搜尋類型"
L["searchTypeDesc"] = "使用哪種方法在滑鼠游標指向的位置尋找文字。"
L["searchTypeDescExtended"] = [=[文字字串 (預設) : 尋找滑鼠游標底下的獨立文字字串。
上一層框架:  尋找滑鼠游標底下的最上層框架，複製它的子框架中的所有文字。
滑鼠焦點: 複製滑鼠焦點所在的框架中的文字，只有註冊過滑鼠事件的框架才有效果。]=]
L["show"] = "複製文字"
L["tooManyFontStrings"] = "找到 %d 個文字字串。為了避免遊戲卡住時間過長，已取消複製。"

