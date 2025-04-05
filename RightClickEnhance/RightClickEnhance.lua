local addonName, addon = ...
-- 在 L 本地化表中添加新的字符串
local L = {
    zhCN = {
        MENU_TITLE = "|cFF00CCFF增强功能|r",
        INVITE_TO_GUILD = "邀请入会",
        ADD_FRIEND = "添加好友",
        COPY_NAME = "复制角色名",
        IGNORE = "屏蔽玩家",
        COPY_SUCCESS = "|cFF00FF00[RightClickEnhance]|r %s 已复制到聊天输入框",
        PLAYER_INFO = "玩家信息",
        PLAYER_INFO_FORMAT = "名称: %s\n等级: %s\n职业: %s\n种族: %s\n公会: %s\n当前位置: %s",
        NO_GUILD = "|cFFFFFF00您没有加入任何公会|r",
        NO_INVITE_PERMISSION = "|cFFFFFF00您没有邀请入会权限|r",
        GUILD_INVITE_SUCCESS = "|cFFFFFF00您已邀请%s加入公会|r",
    },
    zhTW = {
        MENU_TITLE = "|cFF00CCFF增強功能|r",
        INVITE_TO_GUILD = "邀請入會",
        ADD_FRIEND = "加入好友",
        COPY_NAME = "複製角色名",
        IGNORE = "屏蔽玩家",
        COPY_SUCCESS = "|cFF00FF00[RightClickEnhance]|r %s 已複製到聊天輸入框",
        PLAYER_INFO = "玩家資訊",
        PLAYER_INFO_FORMAT = "名稱: %s\n等級: %s\n職業: %s\n種族: %s\n公會: %s\n當前位置: %s",
        NO_GUILD = "|cFFFFFF00您沒有加入任何公會|r",
        NO_INVITE_PERMISSION = "|cFFFFFF00您沒有邀請入會權限|r",
        GUILD_INVITE_SUCCESS = "|cFFFFFF00您已邀請%s加入公會|r",
    },
    -- 修复英文本地化
    enUS = {
        MENU_TITLE = "|cFF00CCFFEnhanced Features|r",
        INVITE_TO_GUILD = "Guild Invite",
        ADD_FRIEND = "Add Friend",
        COPY_NAME = "Copy Name",
        IGNORE = "Ignore Player",
        COPY_SUCCESS = "|cFF00FF00[RightClickEnhance]|r %s copied to chat input",
        PLAYER_INFO = "Player Info",
        PLAYER_INFO_FORMAT = "Name: %s\nClass: %s\nRace: %s\nGuild: %s\nLocation: %s",
        NO_GUILD = "|cFFFFFF00You are not in a guild|r",
        NO_INVITE_PERMISSION = "|cFFFFFF00You don't have permission to invite|r",
        GUILD_INVITE_SUCCESS = "|cFFFFFF00You have invited %s to join the guild|r",
    }
}

-- 根据客户端语言选择本地化
local locale = GetLocale()
L = L[locale] or L.enUS

-- 配置数据库
RightClickEnhanceDB = RightClickEnhanceDB or {
    enableGuildInvite = true,
    enableAddFriend = true,
    enableCopyName = true,
    enableIgnore = true,
}

-- 安全复制到聊天输入框
local function SafeCopyToChatInput(name, unitToken)
    if not name or name == "" then return end
    
    -- 如果是非玩家单位，直接复制名字
    if unitToken and not UnitIsPlayer(unitToken) then
        local pureName = strsplit("-", name)
        name = pureName
    else
        -- 玩家单位，确保包含服务器信息
        local playerName, playerRealm = strsplit("-", name)
        if not playerRealm then
            -- 尝试从单位获取服务器信息
            if unitToken then
                playerRealm = select(2, UnitName(unitToken))
            end
            -- 如果还是没有服务器信息，使用当前服务器
            if not playerRealm or playerRealm == "" then
                playerRealm = GetRealmName()
            end
            name = playerName.."-"..playerRealm
        end
    end
    
    local editBox = ChatEdit_ChooseBoxForSend()
    if editBox then
        ChatEdit_ActivateChat(editBox)
        editBox:SetText(name)
        editBox:HighlightText()
        print(format(L.COPY_SUCCESS, name))
    end
end

-- 添加新的玩家信息获取函数
local function GetPlayerDetailedInfo(name, unitToken)
    if not name or name == "" then return end
    
    -- 移除引号避免可能的语法错误
    local searchName = name:gsub('"', '')
    -- 只使用角色名部分
    searchName = strsplit("-", searchName)
    
    if searchName and searchName ~= "" then
        C_FriendList.SendWho('n-'..searchName, 2)
    end
end

-- 添加公会邀请处理函数
local function HandleGuildInvite(pureName)
    if not IsInGuild() then
        print(L.NO_GUILD)
        return
    end
    
    -- 使用 CanGuildInvite 检查是否有邀请权限
    if not CanGuildInvite() then
        print(L.NO_INVITE_PERMISSION)
        return
    end
    
    local playerName = strsplit("-", pureName)  -- 确保只使用角色名
    GuildInvite(playerName)
    print(format(L.GUILD_INVITE_SUCCESS, pureName))
end

-- 检查是否已经是好友（移到文件前面）
local function IsAlreadyFriend(playerName)
    if not playerName or playerName == "" then return true end
    
    local numFriends = C_FriendList.GetNumFriends()
    for i = 1, numFriends do
        local friendInfo = C_FriendList.GetFriendInfoByIndex(i)
        if friendInfo and friendInfo.name == playerName then
            return true
        end
    end
    return false
end

-- 添加聊天框菜单项（保持原有逻辑）
local function AddChatMenuItems(rootDescription, pureName)
    -- 添加分隔线
    rootDescription:CreateDivider()
    
    -- 添加标题
    rootDescription:CreateTitle(L.MENU_TITLE)
    
    -- 公会邀请
    if RightClickEnhanceDB.enableGuildInvite then
        rootDescription:CreateButton(L.INVITE_TO_GUILD, function()
            HandleGuildInvite(pureName)
        end)
    end
    
    -- 添加好友
    if RightClickEnhanceDB.enableAddFriend then
        local playerName = strsplit("-", pureName)
        if playerName and playerName ~= "" and not IsAlreadyFriend(playerName) then
            rootDescription:CreateButton(L.ADD_FRIEND, function()
                C_FriendList.AddFriend(playerName)
            end)
        end
    end
    
    -- 复制角色名
    if RightClickEnhanceDB.enableCopyName then
        rootDescription:CreateButton(L.COPY_NAME, function()
            SafeCopyToChatInput(pureName)  -- 聊天框菜单不传 unitToken
        end)
    end
    
    -- 屏蔽玩家
    if RightClickEnhanceDB.enableIgnore and not C_FriendList.IsIgnored(pureName) then
        rootDescription:CreateButton(L.IGNORE, function()
            C_FriendList.AddIgnore(pureName)
        end)
    end
    
    -- 添加玩家信息按钮
    rootDescription:CreateButton(L.PLAYER_INFO, function()
        GetPlayerDetailedInfo(pureName)
    end)
end

-- 添加目标框体菜单项（新的逻辑）
local function AddTargetMenuItems(rootDescription, pureName, unitToken)
    -- 添加分隔线
    rootDescription:CreateDivider()
    
    -- 添加标题
    rootDescription:CreateTitle(L.MENU_TITLE)

    -- 复制角色名（总是显示）
    if RightClickEnhanceDB.enableCopyName then
        rootDescription:CreateButton(L.COPY_NAME, function()
            SafeCopyToChatInput(pureName, unitToken)  -- 传入 unitToken 用于判断
        end)
    end

    -- 如果目标是玩家，显示完整菜单
    if UnitIsPlayer(unitToken) then
        -- 公会邀请（检查公会状态和权限）
        if RightClickEnhanceDB.enableGuildInvite then
            -- 检查目标是否有公会
            local guildName = GetGuildInfo(unitToken)
            if not guildName then  -- 只有目标没有公会时才显示邀请选项
                rootDescription:CreateButton(L.INVITE_TO_GUILD, function()
                    HandleGuildInvite(pureName)
                end)
            end
        end
        
        -- 添加好友
        if RightClickEnhanceDB.enableAddFriend then
            local playerName = strsplit("-", pureName)
            if playerName and playerName ~= "" and not IsAlreadyFriend(playerName) then
                rootDescription:CreateButton(L.ADD_FRIEND, function()
                    C_FriendList.AddFriend(playerName)
                end)
            end
        end
        
        -- 屏蔽玩家
        if RightClickEnhanceDB.enableIgnore and not C_FriendList.IsIgnored(pureName) then
            rootDescription:CreateButton(L.IGNORE, function()
                C_FriendList.AddIgnore(pureName)
            end)
        end
        
        -- 添加玩家信息按钮
        rootDescription:CreateButton(L.PLAYER_INFO, function()
            GetPlayerDetailedInfo(pureName, unitToken)
        end)
    end
end

-- 安全注册菜单修改
local function SafeModifyMenu(menuType, callback)
    if Menu and (Menu.ModifyMenu or Menu.HookMenu) then  -- 11.0可能使用HookMenu
        -- 尝试两种注册方式
        local success, result = pcall(Menu.ModifyMenu or Menu.HookMenu, menuType, callback)
        if not success then
            -- 备用注册方式
            pcall(Menu.HookMenu or Menu.ModifyMenu, menuType, callback)
        end
    end
end

-- 初始化菜单钩子
local function RegisterMenuHooks()
    -- 通用处理函数
    local function HandleUnitMenu(root, ctx)
        if ctx and ctx.unit then
            -- 11.0中获取单位信息的方式有所变化
            local name, server = UnitFullName(ctx.unit)  -- 替代原来的UnitName
            
            -- 特别处理团队和队伍成员
            if not server or server == "" then
                if UnitInParty(ctx.unit) or UnitInRaid(ctx.unit) then
                    -- 11.0中更可靠的获取完整名字的方式
                    local fullName = UnitNameUnmodified(ctx.unit)
                    if fullName then
                        local _, realm = strsplit("-", fullName)
                        if realm then
                            server = realm
                        end
                    end
                end
            end
            
            local fullName = server and name.."-"..server or name
            AddTargetMenuItems(root, fullName, ctx.unit)
        end
    end

    -- 好友/聊天菜单
    SafeModifyMenu("MENU_UNIT_FRIEND", function(_, root, ctx)
        if ctx and ctx.chatTarget then
            local playerName, playerRealm = strsplit("-", ctx.chatTarget)
            if not playerRealm then
                playerRealm = GetRealmName()
            end
            local fullName = playerName.."-"..playerRealm
            AddChatMenuItems(root, fullName)
        end
    end)
    
    -- 所有玩家相关的菜单类型（11.0版本更新）
    local playerMenuTypes = {
        "MENU_UNIT_PLAYER",          -- 普通玩家
        "MENU_UNIT_PARTY",           -- 队伍成员
        "MENU_UNIT_RAID",            -- 团队成员
        "MENU_UNIT_ENEMY_PLAYER",    -- 敌对玩家
        "MENU_UNIT_TARGET",          -- 目标框架
        "MENU_UNIT_RAID_PLAYER",     -- 团队玩家（11.0新增）
        "MENU_UNIT_RAID_TARGET",     -- 团队目标（11.0新增）
        "MENU_UNIT_RAID_1_8",        -- 团队1-8号位（11.0新增分组处理）
    }
    
    for _, menuType in ipairs(playerMenuTypes) do
        SafeModifyMenu(menuType, function(_, root, ctx)
            HandleUnitMenu(root, ctx)
        end)
    end
end

-- 初始化
local function Initialize()
    -- 延迟注册确保稳定性
    C_Timer.After(1, RegisterMenuHooks)
end

-- 启动插件
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, name)
    if name == addonName then
        Initialize()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)
