-- CopyX 插件主文件 - 增强版，捕获所有文本输出
local addonName, addonTable = ...

-- 创建主框架
local CopyXFrame = CreateFrame("Frame", "CopyXFrame", UIParent)
CopyXFrame:RegisterEvent("ADDON_LOADED")
CopyXFrame:RegisterEvent("PLAYER_LOGIN")

-- 存储所有文本的变量
local allTexts = {}
local maxTextLines = 2000  -- 最大存储行数

-- 事件处理
CopyXFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...
        if name == addonName then
            self:Initialize()
        end
    elseif event == "PLAYER_LOGIN" then
        self:SetupAllHooks()
    end
end)

-- 初始化函数
function CopyXFrame:Initialize()
    self:CreateCopyButton()
    self:CreateCopyFrame()
end

-- 创建复制按钮
function CopyXFrame:CreateCopyButton()
    -- 尝试找到聊天框的合适位置放置按钮
    for i = 1, NUM_CHAT_WINDOWS do
        local chatFrame = _G["ChatFrame" .. i]
        if chatFrame and chatFrame:IsVisible() then
            local button = CreateFrame("Button", "CopyXButton" .. i, chatFrame, "UIPanelButtonTemplate")
            button:SetSize(60, 22)
            button:SetText("CopyX")
            button:SetPoint("TOPRIGHT", chatFrame, "TOPRIGHT", -5, 0)
            
            button:SetScript("OnClick", function(self)
                CopyXFrame:ShowCopyFrame()
            end)
            
            self.copyButton = button
            break
        end
    end
    
    -- 如果没找到合适的聊天框，放在默认位置
    if not self.copyButton then
        local button = CreateFrame("Button", "CopyXButton", UIParent, "UIPanelButtonTemplate")
        button:SetSize(60, 22)
        button:SetText("CopyX")
        button:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 10, 10)
        
        button:SetScript("OnClick", function(self)
            CopyXFrame:ShowCopyFrame()
        end)
        
        self.copyButton = button
    end
end

-- 创建复制框架
function CopyXFrame:CreateCopyFrame()
    local frame = CreateFrame("Frame", "CopyXMainFrame", UIParent, "BasicFrameTemplate")
    frame:SetSize(700, 500)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:Hide()
    
    -- 标题
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.title:SetPoint("TOP", frame, "TOP", 0, -5)
    frame.title:SetText("CopyX - 完整文本捕获")
    
    -- 关闭按钮
    frame.closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
    frame.closeButton:SetScript("OnClick", function()
        frame:Hide()
    end)
    
    -- 滚动框架
    local scrollFrame = CreateFrame("ScrollFrame", "CopyXScrollFrame", frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -30)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 40)
    
    -- 编辑框
    local editBox = CreateFrame("EditBox", "CopyXEditBox", scrollFrame)
    editBox:SetSize(scrollFrame:GetSize())
    editBox:SetMultiLine(true)
    editBox:SetAutoFocus(false)
    editBox:SetFontObject(GameFontNormal)
    editBox:SetTextInsets(5, 5, 5, 5)
    editBox:EnableMouse(true)
    editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    
    scrollFrame:SetScrollChild(editBox)
    
    -- 底部按钮区域
    local buttonArea = CreateFrame("Frame", nil, frame)
    buttonArea:SetSize(200, 30)
    buttonArea:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
    
    -- 添加全选按钮
    local selectAllButton = CreateFrame("Button", nil, buttonArea, "UIPanelButtonTemplate")
    selectAllButton:SetSize(80, 22)
    selectAllButton:SetPoint("LEFT", buttonArea, "LEFT")
    selectAllButton:SetText("全选")
    selectAllButton:SetScript("OnClick", function()
        editBox:SetFocus()
        editBox:HighlightText()
    end)
    
    -- 添加复制按钮
    local copyButton = CreateFrame("Button", nil, buttonArea, "UIPanelButtonTemplate")
    copyButton:SetSize(80, 22)
    copyButton:SetPoint("CENTER", buttonArea, "CENTER")
    copyButton:SetText("复制")
    copyButton:SetScript("OnClick", function()
        editBox:SetFocus()
        editBox:HighlightText()
    end)
    
    -- 添加清除按钮
    local clearButton = CreateFrame("Button", nil, buttonArea, "UIPanelButtonTemplate")
    clearButton:SetSize(80, 22)
    clearButton:SetPoint("RIGHT", buttonArea, "RIGHT")
    clearButton:SetText("清除")
    clearButton:SetScript("OnClick", function()
        table.wipe(allTexts)
        editBox:SetText("")
        CopyXFrame:AddSystemMessage("|cFF00FF00CopyX: 文本记录已清除|r")
    end)
    
    self.copyFrame = frame
    self.editBox = editBox
end

-- 显示复制框架
function CopyXFrame:ShowCopyFrame()
    local text = self:GetAllText()
    self.editBox:SetText(text)
    self.copyFrame:Show()
    self.editBox:SetFocus()
    self.editBox:SetCursorPosition(0) -- 滚动到顶部
end

-- 获取所有文本
function CopyXFrame:GetAllText()
    local result = {}
    
    -- 按时间顺序排列（从旧到新）
    for i = 1, #allTexts do
        table.insert(result, allTexts[i])
    end
    
    return table.concat(result, "\n")
end

-- 设置所有钩子
function CopyXFrame:SetupAllHooks()
    self:HookDefaultChatFrame()
    self:HookAllChatFrames()
    self:HookPrintFunction()
    self:HookUIErrorsFrame()
    self:HookBasicMessageFunctions()
    
    -- 添加系统消息
    self:AddSystemMessage("|cFF00FF00CopyX 已加载 - 开始捕获所有文本输出|r")
end

-- 钩住默认聊天框
function CopyXFrame:HookDefaultChatFrame()
    if DEFAULT_CHAT_FRAME then
        self:HookChatFrame(DEFAULT_CHAT_FRAME, "默认聊天框")
    end
end

-- 钩住所有聊天框
function CopyXFrame:HookAllChatFrames()
    for i = 1, NUM_CHAT_WINDOWS do
        local chatFrame = _G["ChatFrame" .. i]
        if chatFrame then
            self:HookChatFrame(chatFrame, "聊天框" .. i)
        end
    end
end

-- 钩住聊天框的AddMessage方法
function CopyXFrame:HookChatFrame(chatFrame, frameName)
    if not chatFrame or chatFrame.CopyXHooked then return end
    
    local originalAddMessage = chatFrame.AddMessage
    
    chatFrame.AddMessage = function(self, text, ...)
        -- 调用原始函数
        if originalAddMessage then
            originalAddMessage(self, text, ...)
        end
        
        -- 捕获文本
        if text and text ~= "" then
            local cleanText = CopyXFrame:RemoveColorCodes(text)
            local timestamp = date("%H:%M:%S")
            local formattedText = string.format("[%s][%s] %s", timestamp, frameName, cleanText)
            CopyXFrame:AddText(formattedText)
        end
    end
    
    chatFrame.CopyXHooked = true
end

-- 钩住print函数
function CopyXFrame:HookPrintFunction()
    local originalPrint = print
    
    function print(...)
        -- 调用原始print
        originalPrint(...)
        
        -- 捕获输出
        local args = {...}
        local text = table.concat(args, " ")
        if text and text ~= "" then
            local timestamp = date("%H:%M:%S")
            local formattedText = string.format("[%s][PRINT] %s", timestamp, text)
            CopyXFrame:AddText(formattedText)
        end
    end
end

-- 钩住错误信息框
function CopyXFrame:HookUIErrorsFrame()
    if UIErrorsFrame then
        local originalAddMessage = UIErrorsFrame.AddMessage
        
        UIErrorsFrame.AddMessage = function(self, text, ...)
            -- 调用原始函数
            if originalAddMessage then
                originalAddMessage(self, text, ...)
            end
            
            -- 捕获错误信息
            if text and text ~= "" then
                local timestamp = date("%H:%M:%S")
                local formattedText = string.format("[%s][错误] %s", timestamp, text)
                CopyXFrame:AddText(formattedText)
            end
        end
    end
end

-- 钩住基本消息函数
function CopyXFrame:HookBasicMessageFunctions()
    -- 钩住基本的消息显示函数
    local original_Message = message
    if original_Message then
        function message(text)
            original_Message(text)
            if text and text ~= "" then
                local timestamp = date("%H:%M:%S")
                local formattedText = string.format("[%s][MESSAGE] %s", timestamp, text)
                CopyXFrame:AddText(formattedText)
            end
        end
    end
    
    -- 钩住RaidNotice
    if RaidNotice_AddMessage then
        hooksecurefunc("RaidNotice_AddMessage", function(noticeFrame, text, colorInfo, ...)
            if text and text ~= "" then
                local timestamp = date("%H:%M:%S")
                local formattedText = string.format("[%s][团队通知] %s", timestamp, CopyXFrame:RemoveColorCodes(text))
                CopyXFrame:AddText(formattedText)
            end
        end)
    end
end

-- 移除颜色代码
function CopyXFrame:RemoveColorCodes(text)
    if not text then return "" end
    -- 移除所有格式代码
    return text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|H.-|h", ""):gsub("|h", "")
end

-- 添加文本到存储
function CopyXFrame:AddText(text)
    if not text or text == "" then return end
    
    table.insert(allTexts, text)
    
    -- 限制存储的行数
    if #allTexts > maxTextLines then
        table.remove(allTexts, 1)
    end
end

-- 添加系统消息（特殊处理，不重复记录）
function CopyXFrame:AddSystemMessage(text)
    if not text or text == "" then return end
    
    local cleanText = self:RemoveColorCodes(text)
    local timestamp = date("%H:%M:%S")
    local formattedText = string.format("[%s][系统] %s", timestamp, cleanText)
    
    table.insert(allTexts, formattedText)
    
    -- 限制存储的行数
    if #allTexts > maxTextLines then
        table.remove(allTexts, 1)
    end
end

-- 创建斜杠命令
SLASH_COPYX1 = "/copyx"
SLASH_COPYX2 = "/cx"
SlashCmdList["COPYX"] = function(msg)
    if msg == "clear" then
        table.wipe(allTexts)
        CopyXFrame:AddSystemMessage("|cFF00FF00CopyX: 文本记录已清除|r")
        print("CopyX: 文本记录已清除")
    else
        CopyXFrame:ShowCopyFrame()
    end
end

-- 打印加载信息
C_Timer.After(2, function()
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00CopyX 插件已加载|r - 使用 /copyx 或点击CopyX按钮查看捕获的文本")
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00CopyX 命令:|r /copyx 或 /cx - 打开界面, /copyx clear - 清除记录")
end)