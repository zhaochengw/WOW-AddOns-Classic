local tempScrollPer = nil

local function Init()
    -- 当选择宏时恢复滚动条位置
    hooksecurefunc(MacroFrame, "SelectMacro", function(self, index)
        if tempScrollPer then
            MacroFrame.MacroSelector.ScrollBox:SetScrollPercentage(tempScrollPer)
            tempScrollPer = nil  -- 重置临时存储
        end
    end)

    -- 调整宏选择框和其他界面元素的高度和位置
    MacroFrame:SetHeight(338 * 2.3) -- 外框高度
    MacroFrame:SetWidth(338 * 2) -- 外框宽度
    MacroFrame.MacroSelector:SetHeight(684) -- 宏图标范围高度

    MacroFrameSelectedMacroBackground:ClearAllPoints()
    MacroFrameSelectedMacroBackground:SetPoint("TOPLEFT", MacroFrame, "TOPLEFT", 338, -60)

    MacroFrameTextBackground:ClearAllPoints()
    MacroFrameTextBackground:SetPoint("TOPLEFT", MacroFrame, "TOPLEFT", 338, -132)
    MacroFrameTextBackground:SetHeight(600) -- 输入框高度

    MacroFrameScrollFrame:SetHeight(591) -- 滚动条高度

    MacroFrameCharLimitText:ClearAllPoints()
    MacroFrameCharLimitText:SetPoint("TOP", MacroFrameTextBackground, "BOTTOM", 0, 0)

    MacroHorizontalBarLeft:ClearAllPoints()
end

-- 创建监听事件的框架
local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, addon)
    if event == "ADDON_LOADED" then
        if addon == "Blizzard_MacroUI" then
            Init() -- 初始化宏界面
            f:UnregisterEvent("ADDON_LOADED") -- 完成后取消注册
        end
    elseif MacroFrame then
        tempScrollPer = MacroFrame.MacroSelector.ScrollBox.scrollPercentage
    end
end)

-- 监听事件
f:RegisterEvent("ADDON_LOADED") -- 监听宏插件的加载事件
f:RegisterEvent("UPDATE_MACROS") -- 监听宏界面更新事件
