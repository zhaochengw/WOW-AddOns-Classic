--[[
    AutoInvite for MOP 5.5.3
    作者: 重构版本
    功能: 密语邀请组队和公会，支持队伍转团队
]]

-- 创建命名空间，避免全局变量冲突
local AutoInvite = {};
_G.AutoInvite = AutoInvite;

-- 默认配置
local defaultConfig = {
    enableGroupInvite = true,
    enableGuildInvite = true,
    groupKeyword = "123",
    guildKeyword = "222",
    autoConvertToRaid = true,
    convertAtMemberCount = 5,
    enableGuildInviteConfirm = true -- 公会邀请是否需要确认
};

-- 配置存储
local config;

-- 初始化配置
function AutoInvite:Initialize()
    -- 加载配置
    AutoInviteDB = AutoInviteDB or {};
    
    -- 将默认配置复制到AutoInviteDB中，确保所有配置都被保存
    for key, value in pairs(defaultConfig) do
        if AutoInviteDB[key] == nil then
            AutoInviteDB[key] = value;
        end
    end
    
    config = AutoInviteDB;
    
    -- 注册事件
    self:RegisterEvents();
    
    -- 创建设置面板
    self:CreateOptionsPanel();
    
    print("|cff00ff00AutoInvite已加载！|r 使用 /ais 打开设置面板");
end

-- 注册事件
function AutoInvite:RegisterEvents()
    local frame = CreateFrame("Frame");
    frame:RegisterEvent("CHAT_MSG_WHISPER");
    frame:SetScript("OnEvent", function(_, event, ...)
        AutoInvite:OnEvent(event, ...);
    end);
end

-- 事件处理函数
function AutoInvite:OnEvent(event, ...)
    if event == "CHAT_MSG_WHISPER" then
        local msg, playerName = ...;
        self:HandleWhisper(msg, playerName);
    end
end

-- 处理密语
function AutoInvite:HandleWhisper(msg, playerName)
    -- 获取当前玩家名称
    local currentPlayerName = UnitName("player");
    
    -- 如果发送者是自己，直接返回
    if playerName == currentPlayerName then
        return;
    end
    
    -- 处理组队邀请
    if config.enableGroupInvite and msg == config.groupKeyword then
        self:InviteToGroup(playerName);
    end
    
    -- 处理公会邀请
    if config.enableGuildInvite and msg == config.guildKeyword then
        self:InviteToGuild(playerName);
    end
end

-- 邀请加入队伍
function AutoInvite:InviteToGroup(playerName)
    -- 检查是否需要转为团队
    if config.autoConvertToRaid then
        local groupSize = GetNumGroupMembers();
        
        -- 如果已经是团队，直接邀请
        if IsInRaid() then
            InviteUnit(playerName);
            return;
        end
        
        -- 如果队伍人数达到转换阈值，先转为团队
        if groupSize >= config.convertAtMemberCount then
            ConvertToRaid();
        end
    end
    
    -- 发送邀请
    InviteUnit(playerName);
end

-- 邀请加入公会
function AutoInvite:InviteToGuild(playerName)
    -- 检查CanGuildInvite函数是否存在，如果存在且返回false，则跳过邀请
    if type(CanGuildInvite) == "function" and not CanGuildInvite() then
        return;
    end
    
    -- 只使用角色名部分（移除服务器信息）
    local pureName = strsplit("-", playerName);
    
    -- 移除可能的特殊字符
    pureName = pureName:gsub('"', '');
    
    -- 根据配置决定是否需要确认
    if not config.enableGuildInviteConfirm then
        -- 不需要确认，直接执行邀请
        -- 尝试直接调用GuildInvite
        local success, errorMsg = pcall(GuildInvite, pureName);
        
        -- 如果直接调用失败，尝试使用斜杠命令
        if not success then
            -- 尝试使用SlashCmdList直接执行
            local slashSuccess, slashError = pcall(function()
                SlashCmdList["GINVITE"](pureName);
            end);
            
            -- 如果SlashCmdList失败，尝试使用RunMacroText
            if not slashSuccess then
                local command = "/ginvite " .. pureName;
                local macroSuccess, macroError = pcall(RunMacroText, command);
                
                -- 如果所有方法都失败，使用安全按钮作为最后手段
                if not macroSuccess then
                    self:CreateGuildInviteButton(pureName);
                end
            end
        end
        
        return;
    end
    
    -- 需要确认，显示确认对话框
    -- 保存当前AutoInvite对象引用
    local selfRef = self;
    
    -- 创建公会邀请确认对话框
    local function ShowGuildInviteConfirm()
        local locale = GetLocale();
        local text1, button1, button2, successMsg;
        
        -- 根据语言设置文本
        if locale == "zhCN" then
            text1 = " " .. pureName .. " 请求加入你的公会!";
            button1 = "同意";
            button2 = "拒绝";
            successMsg = pureName .. " 已成功邀请加入公会!";
        else
            -- 默认使用英语
            text1 = " " .. pureName .. " wants to join your Guild!";
            button1 = "Yes";
            button2 = "No";
            successMsg = pureName .. " was successfully invited!";
        end
        
        -- 创建对话框配置
        StaticPopupDialogs["AUTOINVITE_GUILD_CONFIRM"] = {
            text = text1,
            button1 = button1,
            button2 = button2,
            OnAccept = function()
                -- 显示成功消息
                DEFAULT_CHAT_FRAME:AddMessage(successMsg);
                
                -- 尝试直接调用GuildInvite
                local success, errorMsg = pcall(GuildInvite, pureName);
                
                -- 如果直接调用失败，尝试使用斜杠命令
                if not success then
                    -- 尝试使用SlashCmdList直接执行
                    local slashSuccess, slashError = pcall(function()
                        SlashCmdList["GINVITE"](pureName);
                    end);
                    
                    -- 如果SlashCmdList失败，尝试使用RunMacroText
                    if not slashSuccess then
                        local command = "/ginvite " .. pureName;
                        local macroSuccess, macroError = pcall(RunMacroText, command);
                        
                        -- 如果所有方法都失败，使用安全按钮作为最后手段
                        if not macroSuccess then
                            selfRef:CreateGuildInviteButton(pureName);
                        end
                    end
                end
            end,
            timeout = 15,  -- 15秒后自动关闭
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,  -- 对话框层级
        };
        
        -- 显示对话框
        StaticPopup_Show("AUTOINVITE_GUILD_CONFIRM");
    end
    
    -- 显示确认对话框
    ShowGuildInviteConfirm();
end

-- 创建公会邀请安全按钮（作为最后手段）
function AutoInvite:CreateGuildInviteButton(playerName)
    if not self.guildInviteButton then
        self.guildInviteButton = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate");
        self.guildInviteButton:Hide();
        self.guildInviteButton:SetAttribute("type", "macro");
    end
    
    -- 设置宏命令
    local macroText = string.format("/ginvite %s", playerName);
    self.guildInviteButton:SetAttribute("macrotext", macroText);
    
    -- 执行点击
    self.guildInviteButton:Click();
end

-- 创建设置面板
function AutoInvite:CreateOptionsPanel()
    local panel = CreateFrame("Frame", "AutoInviteOptionsPanel", InterfaceOptionsFramePanelContainer);
    panel.name = "AutoInvite";
    panel:Hide();
    
    -- 标题
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    title:SetPoint("TOPLEFT", 16, -16);
    title:SetText("AutoInvite 设置");
    
    -- 说明文本
    local desc = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8);
    desc:SetText("配置自动邀请功能");
    desc:SetWidth(300);
    
    -- 组队邀请开关
    local groupInviteCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate");
    groupInviteCheck:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", -2, -16);
    groupInviteCheck.Text:SetText("启用密语组队邀请");
    groupInviteCheck:SetScript("OnClick", function(self)
        config.enableGroupInvite = self:GetChecked();
    end);
    
    -- 组队邀请关键词
    local groupKeywordLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    groupKeywordLabel:SetPoint("TOPLEFT", groupInviteCheck, "BOTTOMLEFT", 2, -12);
    groupKeywordLabel:SetText("组队邀请关键词:");
    
    local groupKeywordEdit = CreateFrame("EditBox", nil, panel, "InputBoxTemplate");
    groupKeywordEdit:SetPoint("LEFT", groupKeywordLabel, "RIGHT", 8, 0);
    groupKeywordEdit:SetWidth(100);
    groupKeywordEdit:SetHeight(20);
    groupKeywordEdit:SetMaxLetters(20);
    groupKeywordEdit:SetAutoFocus(false);
    groupKeywordEdit:SetScript("OnEnterPressed", function(self)
        config.groupKeyword = self:GetText();
        self:ClearFocus();
    end);
    groupKeywordEdit:SetScript("OnEscapePressed", function(self)
        self:SetText(config.groupKeyword);
        self:ClearFocus();
    end);
    groupKeywordEdit:SetScript("OnEditFocusLost", function(self)
        config.groupKeyword = self:GetText();
    end);
    
    -- 公会邀请开关
    local guildInviteCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate");
    guildInviteCheck:SetPoint("TOPLEFT", groupKeywordLabel, "BOTTOMLEFT", -2, -24);
    guildInviteCheck.Text:SetText("启用密语公会邀请");
    guildInviteCheck:SetScript("OnClick", function(self)
        config.enableGuildInvite = self:GetChecked();
    end);
    
    -- 公会邀请关键词
    local guildKeywordLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    guildKeywordLabel:SetPoint("TOPLEFT", guildInviteCheck, "BOTTOMLEFT", 2, -12);
    guildKeywordLabel:SetText("公会邀请关键词:");
    
    local guildKeywordEdit = CreateFrame("EditBox", nil, panel, "InputBoxTemplate");
    guildKeywordEdit:SetPoint("LEFT", guildKeywordLabel, "RIGHT", 8, 0);
    guildKeywordEdit:SetWidth(100);
    guildKeywordEdit:SetHeight(20);
    guildKeywordEdit:SetMaxLetters(20);
    guildKeywordEdit:SetAutoFocus(false);
    guildKeywordEdit:SetScript("OnEnterPressed", function(self)
        config.guildKeyword = self:GetText();
        self:ClearFocus();
    end);
    guildKeywordEdit:SetScript("OnEscapePressed", function(self)
        self:SetText(config.guildKeyword);
        self:ClearFocus();
    end);
    guildKeywordEdit:SetScript("OnEditFocusLost", function(self)
        config.guildKeyword = self:GetText();
    end);
    
    -- 公会邀请确认设置
    local guildInviteConfirmCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate");
    guildInviteConfirmCheck:SetPoint("TOPLEFT", guildKeywordLabel, "BOTTOMLEFT", -2, -16);
    guildInviteConfirmCheck.Text:SetText("公会邀请需要确认");
    guildInviteConfirmCheck:SetScript("OnClick", function(self)
        config.enableGuildInviteConfirm = self:GetChecked();
    end);
    
    -- 自动转团队设置
    local autoConvertCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate");
    autoConvertCheck:SetPoint("TOPLEFT", guildInviteConfirmCheck, "BOTTOMLEFT", 0, -24);
    autoConvertCheck.Text:SetText("自动转为团队");
    autoConvertCheck:SetScript("OnClick", function(self)
        config.autoConvertToRaid = self:GetChecked();
    end);
    
    -- 转团队人数
    local convertCountLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    convertCountLabel:SetPoint("TOPLEFT", autoConvertCheck, "BOTTOMLEFT", 2, -12);
    convertCountLabel:SetText("转团队人数阈值:");
    
    local convertCountEdit = CreateFrame("EditBox", nil, panel, "InputBoxTemplate");
    convertCountEdit:SetPoint("LEFT", convertCountLabel, "RIGHT", 8, 0);
    convertCountEdit:SetWidth(50);
    convertCountEdit:SetHeight(20);
    convertCountEdit:SetMaxLetters(2);
    convertCountEdit:SetAutoFocus(false);
    convertCountEdit:SetNumeric(true);
    convertCountEdit:SetScript("OnEnterPressed", function(self)
        local value = tonumber(self:GetText());
        if value and value >= 1 and value <= 40 then
            config.convertAtMemberCount = value;
        else
            self:SetText(config.convertAtMemberCount);
        end
        self:ClearFocus();
    end);
    convertCountEdit:SetScript("OnEscapePressed", function(self)
        self:SetText(config.convertAtMemberCount);
        self:ClearFocus();
    end);
    convertCountEdit:SetScript("OnEditFocusLost", function(self)
        local value = tonumber(self:GetText());
        if value and value >= 1 and value <= 40 then
            config.convertAtMemberCount = value;
        else
            self:SetText(config.convertAtMemberCount);
        end
    end);
    
    -- 重载配置
    panel:SetScript("OnShow", function()
        groupInviteCheck:SetChecked(config.enableGroupInvite);
        guildInviteCheck:SetChecked(config.enableGuildInvite);
        groupKeywordEdit:SetText(config.groupKeyword);
        guildKeywordEdit:SetText(config.guildKeyword);
        guildInviteConfirmCheck:SetChecked(config.enableGuildInviteConfirm);
        autoConvertCheck:SetChecked(config.autoConvertToRaid);
        convertCountEdit:SetText(config.convertAtMemberCount);
    end);
    
    -- 添加到设置面板 - 兼容性处理
    if _G.InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panel);
    elseif _G.Settings and _G.Settings.RegisterCanvasLayoutCategory then
        -- 新版API支持
        local category = _G.Settings.RegisterCanvasLayoutCategory(panel, panel.name);
        _G.Settings.RegisterAddOnCategory(category);
    end
    
    -- 保存引用
    self.optionsPanel = panel;
end

-- 打开设置面板
function AutoInvite:OpenOptionsPanel()
    -- 兼容性处理：同时支持旧版和新版设置面板API
    if _G.Settings and _G.Settings.OpenToCategory then
        -- 使用新版API
        _G.Settings.OpenToCategory(self.optionsPanel.name);
    else
        -- 使用旧版API
        InterfaceOptionsFrame_OpenToCategory(self.optionsPanel);
        InterfaceOptionsFrame_OpenToCategory(self.optionsPanel); -- 修复面板显示问题
    end
end

-- 注册命令
SLASH_AUTOINVITE1 = "/ais";
SLASH_AUTOINVITE2 = "/aisetting";
SlashCmdList["AUTOINVITE"] = function()
    AutoInvite:OpenOptionsPanel();
end

-- 为ControlPanel.lua提供兼容性支持
function AISettings_SlashHandler()
    AutoInvite:OpenOptionsPanel();
end

-- 确保函数可以被其他文件访问
_G["AISettings_SlashHandler"] = AISettings_SlashHandler;

-- 初始化插件
local frame = CreateFrame("Frame");
frame:RegisterEvent("ADDON_LOADED");
frame:SetScript("OnEvent", function(_, event, addonName)
    if event == "ADDON_LOADED" and addonName == "!!iCenter" then
        AutoInvite:Initialize();
        frame:UnregisterEvent("ADDON_LOADED");
    end
end);
