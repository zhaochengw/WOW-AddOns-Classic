local L = {
    ["Maxer les sorts"] = {
        ["enUS"] = "Max Spells",
        ["frFR"] = "Maxer les sorts",
        ["zhCN"] = "所有技能最高等级"
    },
    ["CHARGÉ"] = {
        ["enUS"] = "LOADED",
        ["frFR"] = "CHARGÉ",
        ["zhCN"] = "已加载"
    }
}

local function GetLocaleText(key)
    local locale = GetLocale()
    return L[key][locale] or L[key]["enUS"]
end

-- 将法术放置在指定的动作栏槽位
local function PlaceSpellInActionSlot(spellId, barIndex, slot)
    ClearCursor()
    PickupSpell(spellId) -- 拿起法术
    PlaceAction(slot + ((barIndex - 1) * NUM_ACTIONBAR_BUTTONS)) 
    ClearCursor()
end

-- 获取法术ID通过法术名称
local function GetSpellIDFromName(spellName)
    local spellID = nil
    for tabIndex = 1, GetNumSpellTabs() do
        local _, _, offset, numSpells = GetSpellTabInfo(tabIndex)
        for spellIndex = 1, numSpells do
            local spellBookIndex = spellIndex + offset
            local name = GetSpellBookItemName(spellBookIndex, BOOKTYPE_SPELL)
            if name and string.lower(name) == string.lower(spellName) then
                local _, _, _, _, _, _, spellID = GetSpellInfo(spellBookIndex, BOOKTYPE_SPELL)
                return spellID
            end
        end
    end
    return spellID
end

-- 更新动作栏中的所有法术为最高等级
local function CheckActionBarSpellsAll()
    for bar = 1, NUM_ACTIONBAR_PAGES do
        for slot = 1, NUM_ACTIONBAR_BUTTONS do
            local actionType, id = GetActionInfo(slot + (NUM_ACTIONBAR_BUTTONS * (bar - 1)))
            if actionType == "spell" then
                local spellName = GetSpellInfo(id)
                if spellName then
                    PlaceSpellInActionSlot(GetSpellIDFromName(spellName), bar, slot)
                end
            end
        end
    end
end

-- 处理事件
local frame = CreateFrame("Frame")
frame:RegisterEvent("LEARNED_SPELL_IN_TAB")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(self, event, arg1, arg2)
    if event == "LEARNED_SPELL_IN_TAB" then
        CheckActionBarSpellsAll()
    elseif event == "ADDON_LOADED" and arg1 == "SpellAutoMaxRank" then
        SpellbookTabButton = CreateFrame("Button", "$parentButton", SpellBookFrame, "UIPanelButtonTemplate")
        SpellbookTabButton:SetPoint("CENTER", SpellBookFrame, "TOP", 0, 0)
        SpellbookTabButton:SetText(GetLocaleText("Maxer les sorts"))
        SpellbookTabButton:SetWidth(140)
        SpellbookTabButton:SetHeight(24)
        SpellbookTabButton:SetNormalFontObject("GameFontNormal")
        SpellbookTabButton:SetHighlightFontObject("GameFontHighlight")
        SpellbookTabButton:SetScript("OnClick", function()
            CheckActionBarSpellsAll()
        end)
        SpellBookFrame_Update()
    end
end)


print(GetLocaleText("CHARGÉ"))
