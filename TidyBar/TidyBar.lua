--[[
Tidy Bar
--]]

-- Localization
local L = GetLocale() == "zhCN" and {
	["Hide main button art?"] = "隐藏主按钮装饰?",
	["Hide experience & reputation bar?"] = "隐藏经验和声望条?",
	["Always show bags?"] = "总是显示背包?",
	["TidyBar Scale:"] = "TidyBar缩放:",
	["Hide bags and menu?"] = "隐藏背包和菜单?",
	["Custom Action Bars"] = "自定义动作条",
	["Custom Action Bar Layout"] = "动作条布局",
	["Custom Action Bar Scale:"] = "自定义动作条缩放:",
	["Keybinding Mode"] = "按键绑定",
	["Mouse over action buttons and press a key to bind it."] = "鼠标移动到动作条按钮上，按下按键进行绑定，按ESC退出。",
	["Current Button: "] = "当前按钮：",
	["None"] = "无",
	["No binding"] = "未绑定",
	["Current binding: "] = "当前绑定：",
	["Binding set: "] = "绑定已设置：",
	["replaced: "] = "替换：",
	["Binding cleared!"] = "绑定已清除！",
	["Clear Binding"] = "清除绑定",
	["Exit"] = "退出",
	["Keybinding Button"] = "按键绑定",
} or GetLocale() == "zhTW" and {
	["Hide main button art?"] = "隐藏主按鈕裝飾?",
	["Hide experience & reputation bar?"] = "隐藏經驗和聲望條?",
	["Always show bags?"] = "總是顯示背包?",
	["TidyBar Scale:"] = "TidyBar縮放:",
	["Hide bags and menu?"] = "隱藏背包和選單?",
	["Custom Action Bars"] = "自定義動作條",
	["Custom Action Bar Layout"] = "動作條佈局",
	["Custom Action Bar Scale:"] = "自定義動作條縮放:",
	["Keybinding Mode"] = "按鍵綁定",
	["Mouse over action buttons and press a key to bind it."] = "滑鼠移動到動作條按鈕上，按下按鍵進行綁定，按ESC退出。",
	["Current Button: "] = "當前按鈕：",
	["None"] = "無",
	["No binding"] = "未綁定",
	["Current binding: "] = "當前綁定：",
	["Binding set: "] = "綁定已設置：",
	["replaced: "] = "替換：",
	["Binding cleared!"] = "綁定已清除！",
	["Clear Binding"] = "清除綁定",
	["Exit"] = "退出",
	["Keybinding Button"] = "按鍵綁定",
} or {
	["Hide main button art?"] = "Hide main button art?",
	["Hide experience & reputation bar?"] = "Hide experience & reputation bar?",
	["Always show bags?"] = "Always show bags?",
	["TidyBar Scale:"] = "TidyBar Scale:",
	["Hide bags and menu?"] = "Hide bags and menu?",
	["Custom Action Bars"] = "Custom Action Bars",
	["Custom Action Bar Layout"] = "Custom Action Bar Layout",
	["Custom Action Bar Scale:"] = "Custom Action Bar Scale:",
	["Keybinding Mode"] = "Keybinding Mode",
	["Mouse over action buttons and press a key to bind it."] = "Mouse over action buttons and press a key to bind it and press ESC to quit.",
	["Current Button: "] = "Current Button: ",
	["None"] = "None",
	["No binding"] = "No binding",
	["Current binding: "] = "Current binding: ",
	["Binding set: "] = "Binding set: ",
	["replaced: "] = "replaced: ",
	["Binding cleared!"] = "Binding cleared!",
	["Clear Binding"] = "Clear Binding",
	["Exit"] = "Exit",
	["Keybinding Button"] = "Keybinding",
}

local playerKeyCache = nil
local playerKeyCacheTime = 0

local function GetPlayerKey()
    local currentTime = GetTime()
    if playerKeyCache and currentTime - playerKeyCacheTime < 60 then -- 缓存60秒
        return playerKeyCache
    end
    
    local name, realm = UnitName("player")
    -- Handle cases where realm might be nil (connected realms or login screen)
    if not realm then
        realm = GetRealmName() or "UnknownRealm"
    end
    
    playerKeyCache = realm.."-"..name
    playerKeyCacheTime = currentTime
    return playerKeyCache
end

local MenuButtonFrames = {
	CharacterMicroButton,
	SpellbookMicroButton,
	TalentMicroButton,
	AchievementMicroButton,
	QuestLogMicroButton,
	SocialsMicroButton,
	CollectionsMicroButton,
	PVPMicroButton,
	LFGMicroButton,
	GuildMicroButton,
	MainMenuMicroButton,
	HelpMicroButton,
	EJMicroButton,
	StoreMicroButton,
	--MainMenuBarPerformanceBarFrame,
}

local BagButtonFrameList = {
	MainMenuBarBackpackButton,
	CharacterBag0Slot,
	CharacterBag1Slot,
	CharacterBag2Slot,
	CharacterBag3Slot,
	KeyRingButton,
}

local CONFIG = {
	MAX_LEVEL = 90,
	BUTTON_SIZE = 36,
	BUTTON_SPACING = 5,
	LEFT_ACTIONBAR_START = 145,
	RIGHT_ACTIONBAR_START = 157,
	REFRESH_COOLDOWN = 0.1,
	DELAY_TIME = 0.5
}

local function SafeErrorHandler(err)
	local timestamp = date("%Y-%m-%d %H:%M:%S")
	local errorMsg = string.format("[TidyBar Error] %s: %s", timestamp, tostring(err))
	print(errorMsg)
	if TidyBar and TidyBar.opts and TidyBar.opts.DebugMode then
		print(debug.traceback())
	end
end

local function SafeCall(func, context, ...)
	if type(func) ~= "function" then
		return nil
	end
	
	local success, result = xpcall(function(...) 
		return func(...) 
	end, function(err)
		local errorMsg = err
		if context then
			errorMsg = string.format("[%s] %s", tostring(context), errorMsg)
		end
		SafeErrorHandler(errorMsg)
	end, ...)
	
	if not success then
		return nil
	end
	return result
end

local function CreateActionButton(parent, buttonName, actionId)
	local button = CreateFrame("CheckButton", buttonName, parent, 
		"ActionBarButtonTemplate, SecureActionButtonTemplate")

	button:SetPushedTexture("")
	button:SetCheckedTexture("")
	button:SetDisabledTexture("")

	local bg = button:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetColorTexture(0, 0, 0, 0.3)

	button:SetID(actionId)
	button.action = actionId
	button:SetAttribute("type", "action")
	button:SetAttribute("action", actionId)
	button:SetWidth(CONFIG.BUTTON_SIZE)
	button:SetHeight(CONFIG.BUTTON_SIZE)
	button:SetAttribute("showgrid", 1)

	button:RegisterForDrag("LeftButton")
	button:SetScript("OnDragStart", function(self)
		if not InCombatLockdown() then
			PickupAction(self.action)
		end
	end)

	return button
end

local function SetupActionBarStateDriver(bar, pageConditions)
	if not bar then return end
	
	-- RegisterStateDriver 负责：根据条件（如 [vehicleui]）自动切换 page 属性
	RegisterStateDriver(bar, 'page', pageConditions)
	-- SetAttribute 设置默认页码（非载具状态下使用的页面）
	-- 不得传入条件字符串，必须是数字
	local defaultPage = 1
	bar:SetAttribute('page', defaultPage)
	-- haschild 确保子按钮能正确继承状态变化
	bar:SetAttribute('haschild', true)
end

local function SetupButtonStates(button, index, actionId)
	-- 默认页面（page 1-11）：使用自定义动作条的实际 actionId
	for page = 1, 11 do
		button:SetState(page, 'action', actionId)
	end
	-- Override 页面（page 12）：映射到主动作条对应位置，由系统OverrideActionBar接管技能
	-- 当 Blizzard 覆盖动作条时，自定义按钮必须同样映射，否则按键仍触发原始技能
	button:SetState(12, 'action', index)
	-- 载具UI页面（page 13）：映射到主动作条对应位置，触发载具技能
	-- 原生UI进入载具时，主动作条按钮自动变成载具技能
	-- 自定义按钮必须同样映射，否则按键仍触发原始技能
	local vehicleBarIndex = GetVehicleBarIndex and GetVehicleBarIndex() or 13
	button:SetState(vehicleBarIndex, 'action', index)
	-- Possess 页面（page 14）：映射到主动作条对应位置，触发控制技能
	-- 原生UI possess 时也需要正确映射
	button:SetState(14, 'action', index)
	-- 页面 15-18 保持为空（预防性设置）
	for page = 15, 18 do
		button:SetState(page, 'empty')
	end
end

local ButtonGridIsShown = false
local Corner_Artwork_Texture = "Interface\\Addons\\TidyBar\\CornerArt"
local Empty_Art = "Interface\\Addons\\TidyBar\\Empty"
local MouseInSidebar, MouseInCorner = false

local TidyBar = CreateFrame("Frame", "TidyBar", WorldFrame)
local CornerMenuFrame = CreateFrame("Frame", "TidyBar_CornerMenuFrame", UIParent)
local CornerMouseoverFrame = CreateFrame("Frame", "TidyBar_CornerBarMouseoverFrame", UIParent)

-- 创建自定义动作条
-- MOP 5.5.3: 正确模板名是 SecureHandlerBaseTemplate，且无 BackdropTemplate
local TidyBarLeftActionBar = CreateFrame("Frame", "TidyBar_LeftActionBar", UIParent, "SecureHandlerBaseTemplate")
local TidyBarRightActionBar = CreateFrame("Frame", "TidyBar_RightActionBar", UIParent, "SecureHandlerBaseTemplate")
TidyBarLeftActionBar:SetFrameStrata("MEDIUM")
TidyBarRightActionBar:SetFrameStrata("MEDIUM")
TidyBarLeftActionBar:EnableMouse(true)
TidyBarRightActionBar:EnableMouse(true)
local LEFT_ACTIONBAR_START = CONFIG.LEFT_ACTIONBAR_START
local RIGHT_ACTIONBAR_START = CONFIG.RIGHT_ACTIONBAR_START

-- 设置 CornerMouseoverFrame 的基础属性
CornerMouseoverFrame:SetFrameStrata("BACKGROUND")
CornerMouseoverFrame:SetPoint("TOP", MainMenuBarBackpackButton, "TOP", 0, 10)
CornerMouseoverFrame:SetPoint("RIGHT", UIParent, "RIGHT")
CornerMouseoverFrame:SetPoint("BOTTOM", UIParent, "BOTTOM")
CornerMouseoverFrame:SetWidth(200)


TidyBar.defaults = {
	HideMainButtonArt = false,
	HideExperienceBar = false,
	AlwaysShowBagFrame = false,
	HideBagAndMenu = true,
	Scale = 1,
	CustomActionBars = false,
	CustomActionBarLayout = "3x4",
	CustomActionBarScale = 0.9
}

TidyBar.opts = {}
for k, v in pairs(TidyBar.defaults) do
	TidyBar.opts[k] = v
end

local TidyBarScale = TidyBar.opts.Scale or 1

function TidyBar:HideMainButtonArt()
	MainMenuBarLeftEndCap:Hide()
	MainMenuBarLeftEndCap:SetAlpha(0)
	MainMenuBarRightEndCap:Hide()
	MainMenuBarRightEndCap:SetAlpha(0)

	MainMenuBarTexture0:SetAlpha(0)
	MainMenuBarTexture0:Hide()
	MainMenuBarTexture1:SetAlpha(0)
	MainMenuBarTexture1:Hide()

	MainMenuBarTextureExtender:SetAlpha(0)
	MainMenuBarTextureExtender:Hide()
end

function TidyBar:ShowMainButtonArt()
	MainMenuBarLeftEndCap:Show()
	MainMenuBarLeftEndCap:SetAlpha(1)
	MainMenuBarRightEndCap:Show()
	MainMenuBarRightEndCap:SetAlpha(1)

	MainMenuBarTexture0:SetAlpha(1)
	MainMenuBarTexture0:Show()
	MainMenuBarTexture1:SetAlpha(1)
	MainMenuBarTexture1:Show()

	MainMenuBarTextureExtender:SetAlpha(1)
	MainMenuBarTextureExtender:Show()
end

function TidyBar:HideExperienceBar()
	MainMenuExpBar:Hide()
	MainMenuExpBar:SetHeight(1)
	ReputationWatchBar:Hide()
	ReputationWatchBar:SetHeight(1)
end

function TidyBar:ShowExperienceBar()
	local currentLevel = UnitLevel("player")
	local currentMaxLevel = CONFIG.MAX_LEVEL
	
	if currentLevel >= currentMaxLevel then
		MainMenuExpBar:Hide()
		MainMenuExpBar:SetHeight(0.001)
	else
		MainMenuExpBar:Show()
		MainMenuExpBar:SetHeight(11)
	end

	local watchedFaction = GetWatchedFactionInfo()
	if watchedFaction then
		ReputationWatchBar:Show()
		ReputationWatchBar:SetHeight(11)
	else
		ReputationWatchBar:Hide()
		ReputationWatchBar:SetHeight(0.001)
	end
end

local function ConfigureCornerBars()
	CharacterMicroButton:ClearAllPoints()
	local microButtonOffset = #MenuButtonFrames * 23 * -1
	CharacterMicroButton:SetPoint("BOTTOMRIGHT", microButtonOffset, 0)

	for i, name in pairs(MenuButtonFrames) do
		name:SetParent(CornerMenuFrame.MicroButtons)
	end

	-- 重新设置基础布局
	CornerMenuFrame.MicroButtons:SetPoint("BOTTOMRIGHT", 0, 1)
	CornerMenuFrame.MicroButtons:SetHeight(45)
	CornerMenuFrame.MicroButtons:SetWidth(256)
	CornerMenuFrame.BagButtonFrame:SetPoint("BOTTOMRIGHT", -5, 40)
	CornerMenuFrame.BagButtonFrame:SetHeight(45)
	CornerMenuFrame.BagButtonFrame:SetWidth(256)

	-- 根据选项控制显示
	if TidyBar.opts.HideBagAndMenu then
		-- 完全隐藏
		CornerMenuFrame:Hide()
		CornerMouseoverFrame:Hide()
		CornerMouseoverFrame:EnableMouse(false)
	else
		CornerMenuFrame:Show()
		if TidyBar.opts.AlwaysShowBagFrame then
			-- 始终显示
			CornerMenuFrame:SetAlpha(1)
			CornerMouseoverFrame:Hide()
			CornerMouseoverFrame:EnableMouse(false)
		else
			-- 鼠标悬停模式
			CornerMenuFrame:SetAlpha(0)
			CornerMouseoverFrame:Show()
			CornerMouseoverFrame:EnableMouse(true)
		end
	end

	-- 重新注册鼠标事件
	if not TidyBar.opts.HideBagAndMenu and not TidyBar.opts.AlwaysShowBagFrame then
		HookCornerFrame(CornerMouseoverFrame)
		for i, name in pairs(BagButtonFrameList) do HookCornerFrame(name) end
		for i, name in pairs(MenuButtonFrames) do HookCornerFrame(name) end
	end
end

TidyBar.hookRunCounter = 0
function TidyBar:UpdateCornerFrameVisibility()
	-- 移除现有的鼠标事件
	for i, name in pairs(BagButtonFrameList) do UnhookCornerFrame(name) end
	for i, name in pairs(MenuButtonFrames) do UnhookCornerFrame(name) end
	UnhookCornerFrame(CornerMouseoverFrame)

	-- 重新配置
	ConfigureCornerBars()
	RefreshPositions()
end

CornerMenuFrame:SetFrameStrata("LOW")
CornerMenuFrame:SetWidth(300)
CornerMenuFrame:SetHeight(128)
CornerMenuFrame:SetPoint("BOTTOMRIGHT")
CornerMenuFrame:SetScale(TidyBarScale)

CornerMenuFrame.BagButtonFrame = CreateFrame("Frame", nil, CornerMenuFrame)
CornerMenuFrame.MicroButtons = CreateFrame("Frame", nil, CornerMenuFrame)

-- Event Delay
local DelayedEventWatcher = CreateFrame("Frame")
local DelayedEvents = {}
local nextCheckTime = 0

local function CheckDelayedEvent(self, elapsed)
	local currentTime = GetTime()
	if currentTime < nextCheckTime then
		return
	end
	
	local hasPending = false
	local eventsToRemove = {}
	local nextEventTime = nil
	
	-- 收集所有需要执行的事件和计算下一次检查时间
	for functionToCall, timeToCall in pairs(DelayedEvents) do
		if currentTime > timeToCall then
			table.insert(eventsToRemove, functionToCall)
		else
			hasPending = true
			-- 更新下一次检查时间为最早的事件时间
			if not nextEventTime or timeToCall < nextEventTime then
				nextEventTime = timeToCall
			end
		end
	end
	
	-- 执行所有需要执行的事件
	for _, functionToCall in ipairs(eventsToRemove) do
		DelayedEvents[functionToCall] = nil
		SafeCall(functionToCall, "DelayedEvent")
	end
	
	-- 设置下一次检查时间
	if hasPending then
		nextCheckTime = nextEventTime or currentTime + 0.05
	else
		nextCheckTime = 0
		self:SetScript("OnUpdate", nil)
	end
end

local function DelayEvent(functionToCall, timeToCall)
	DelayedEvents[functionToCall] = timeToCall
	-- 如果当前没有检查器在运行，或者新事件的时间比下一次检查时间早，则启动或更新检查器
	local currentTime = GetTime()
	if not nextCheckTime or timeToCall < nextCheckTime then
		nextCheckTime = currentTime + 0.01 -- 立即检查
		DelayedEventWatcher:SetScript("OnUpdate", CheckDelayedEvent)
	end
end
-- Event Delay

local function ForceTransparent(frame)
	frame:Hide()
	frame:SetAlpha(0)
end

local function RefreshMainActionBars()
	local anchor = ActionButton1
	local anchorOffset = 8
	local reputationBarOffset = 16
	local initialOffset = 32
	local indentOffset = 16

	MainMenuExpBar:SetWidth(500)
	ExhaustionLevelFillBar:SetWidth(500)
	ExhaustionLevelFillBar:SetHeight(11)
	ReputationWatchBar.StatusBar:SetWidth(500)

	if TidyBar.opts.HideExperienceBar == true then
		TidyBar:HideExperienceBar()
	else
		TidyBar:ShowExperienceBar()
	end

	if TidyBar.opts.HideMainButtonArt == true then
		TidyBar:HideMainButtonArt()
	else
		TidyBar:ShowMainButtonArt()
	end

	-- 正确判断经验条是否实际占用空间：不仅要看IsShown，还要看高度是否>1
	-- MOP 满级后expBar被Hide()但是IsShown可能缓存true，导致偏移计算错误
	local expBarShown = MainMenuExpBar:IsShown() and MainMenuExpBar:GetHeight() > 1
	local repBarShown = ReputationWatchBar:IsShown() and ReputationWatchBar:GetHeight() > 1
	
	if expBarShown and repBarShown then
		anchorOffset = 16 + 9
	elseif expBarShown or repBarShown then
		anchorOffset = 16
	else
		anchorOffset = 8
	end

	reputationBarOffset = anchorOffset

	if MultiBarBottomLeft:IsShown() then
		MultiBarBottomLeft:ClearAllPoints()
		MultiBarBottomLeft:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset)
		anchor = MultiBarBottomLeft
		anchorOffset = 4
	else
		anchor = ActionButton1;
		anchorOffset = 8 + reputationBarOffset
	end

	if MultiBarBottomRight:IsShown() then
		--print("MultiBarBottomRight")
		MultiBarBottomRight:ClearAllPoints()
		MultiBarBottomRight:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset)
		anchor = MultiBarBottomRight
		anchorOffset = 4
	end

	-- PetActionBarFrame, PetActionButton1
	if PetActionBarFrame:IsShown() then
		--print("PetActionBarFrame")
		PetActionButton1:ClearAllPoints()
		PetActionButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", initialOffset, anchorOffset)
		anchor = PetActionButton1
		anchorOffset = 4
	end

	if StanceBarFrame:IsShown() then
		local xAnchorOffset = 0;
		if PetActionBarFrame:IsShown() then
			xAnchorOffset = initialOffset * -1
		end
		StanceButton1:ClearAllPoints();
		StanceButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", xAnchorOffset, anchorOffset);
		anchor = StanceButton1
		anchorOffset = 4
	end

	if MultiCastActionBarFrame:IsShown() then
		anchorOffset = 0
		MultiCastActionBarFrame:ClearAllPoints();
		MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", -4, anchorOffset);
		anchor = MultiCastActionBarFrame;
		anchorOffset = 4
	end
end

local stateDriversRegistered = false

local function RefreshCustomActionBars()
	if InCombatLockdown() then
        TidyBar.pendingUpdate = true
        return
    end

    if not TidyBar.opts.CustomActionBars then
        -- 隐藏自定义动作条
        if TidyBarLeftActionBar then TidyBarLeftActionBar:Hide() end
        if TidyBarRightActionBar then TidyBarRightActionBar:Hide() end
        return
    end

    local rows, cols
    if TidyBar.opts.CustomActionBarLayout == "3x4" then
        rows, cols = 3, 4
    elseif TidyBar.opts.CustomActionBarLayout == "4x3" then
        rows, cols = 4, 3
    elseif TidyBar.opts.CustomActionBarLayout == "2x6" then
        rows, cols = 2, 6
    elseif TidyBar.opts.CustomActionBarLayout == "6x2" then
        rows, cols = 6, 2
    elseif TidyBar.opts.CustomActionBarLayout == "1x12" then
        rows, cols = 1, 12
    else
        rows, cols = 3, 4 -- 默认布局
    end

    -- 创建并设置左侧动作条按钮
    if not TidyBarLeftActionBar.buttons then
        TidyBarLeftActionBar.buttons = {}
        for i = 1, 12 do
            TidyBarLeftActionBar.buttons[i] = CreateActionButton(
                TidyBarLeftActionBar, 
                "TidyBarLeftButton"..i, 
                LEFT_ACTIONBAR_START + i - 1
            )
            SetupButtonStates(TidyBarLeftActionBar.buttons[i], i, LEFT_ACTIONBAR_START + i - 1)
        end
    end

    -- 创建并设置右侧动作条按钮
    if not TidyBarRightActionBar.buttons then
        TidyBarRightActionBar.buttons = {}
        for i = 1, 12 do
            TidyBarRightActionBar.buttons[i] = CreateActionButton(
                TidyBarRightActionBar, 
                "TidyBarRightButton"..i, 
                RIGHT_ACTIONBAR_START + i - 1
            )
            SetupButtonStates(TidyBarRightActionBar.buttons[i], i, RIGHT_ACTIONBAR_START + i - 1)
        end
    end

    -- 根据布局设置动作条大小
    local buttonWidth = CONFIG.BUTTON_SIZE + CONFIG.BUTTON_SPACING
    TidyBarLeftActionBar:SetWidth(buttonWidth * cols)
    TidyBarLeftActionBar:SetHeight(buttonWidth * rows)
    TidyBarRightActionBar:SetWidth(buttonWidth * cols)
    TidyBarRightActionBar:SetHeight(buttonWidth * rows)

    -- 设置左侧动作条位置
    TidyBarLeftActionBar:ClearAllPoints()
    TidyBarLeftActionBar:SetPoint("BOTTOMRIGHT", MainMenuBar, "BOTTOMLEFT", -3, 2)
    TidyBarLeftActionBar:SetFrameStrata("MEDIUM")

    -- 设置右侧动作条位置
    TidyBarRightActionBar:ClearAllPoints()
    TidyBarRightActionBar:SetPoint("BOTTOMLEFT", MainMenuBar, "BOTTOMRIGHT", 3, 2)
    TidyBarRightActionBar:SetFrameStrata("MEDIUM")

    -- 更新按钮布局
    for i = 1, 12 do
        local leftButton = TidyBarLeftActionBar.buttons[i]
        local rightButton = TidyBarRightActionBar.buttons[i]
        local row = math.floor((i - 1) / cols)
        local col = (i - 1) % cols

        -- 左侧动作条按钮（向左生长）
        leftButton:ClearAllPoints()
        leftButton:SetPoint("BOTTOMRIGHT", TidyBarLeftActionBar, "BOTTOMRIGHT",
            -(col * (CONFIG.BUTTON_SIZE + CONFIG.BUTTON_SPACING)),
            row * (CONFIG.BUTTON_SIZE + CONFIG.BUTTON_SPACING))
		leftButton:Show()

        -- 右侧动作条按钮（向右生长）
        rightButton:ClearAllPoints()
        rightButton:SetPoint("BOTTOMLEFT", TidyBarRightActionBar, "BOTTOMLEFT",
            col * (CONFIG.BUTTON_SIZE + CONFIG.BUTTON_SPACING),
            row * (CONFIG.BUTTON_SIZE + CONFIG.BUTTON_SPACING))
		rightButton:Show()
    end

    -- 应用缩放
    TidyBarLeftActionBar:SetScale(TidyBar.opts.CustomActionBarScale)
    TidyBarRightActionBar:SetScale(TidyBar.opts.CustomActionBarScale)

	-- 设置与主菜单栏相同的透明度
    TidyBarLeftActionBar:SetAlpha(MainMenuBar:GetAlpha())
    TidyBarRightActionBar:SetAlpha(MainMenuBar:GetAlpha())

    -- 设置状态驱动，支持载具/override/possess 页面切换（仅注册一次）
    if not stateDriversRegistered then
        local vehicleBarIndex = GetVehicleBarIndex and GetVehicleBarIndex() or 13
        -- 条件格式: [条件] 页码; 默认页码
        -- MOP:
        --  [overridebar] -> page 12 (OverrideActionBar)
        --  [vehicleui] -> page vehicleBarIndex (usually 13) (VehicleUI)
        --  [possessbar] -> page 14 (PossessBar)
        --  otherwise -> page 1 (normal action bar)
        local pageConditions = string.format(
            "[overridebar] 12; [possessbar] 14; [vehicleui] %d; %d",
            vehicleBarIndex,
            1
        )
    
        SetupActionBarStateDriver(TidyBarLeftActionBar, pageConditions)
        SetupActionBarStateDriver(TidyBarRightActionBar, pageConditions)
        stateDriversRegistered = true
    end

    -- 显示动作条
    TidyBarLeftActionBar:Show()
    TidyBarRightActionBar:Show()
end

function ShowCornerMenuFrame()
	MouseInCorner = true
	if not TidyBar.opts.HideBagAndMenu then
		CornerMenuFrame:SetAlpha(1)
	end
end

function HideCornerMenuFrame()
	MouseInCorner = false
	if not TidyBar.opts.HideBagAndMenu and not TidyBar.opts.AlwaysShowBagFrame then
		DelayEvent(function()
			if not MouseInCorner then
				CornerMenuFrame:SetAlpha(0)
			end
		end, GetTime() + CONFIG.DELAY_TIME)
	end
end

-- 钩子计数器：跟踪每个frame上HookScript被调用的次数
-- 解决反复 hook/unhook 导致钩子丢失的问题
local hookCounts = setmetatable({}, { __index = function() return 0 end })

function HookCornerFrame(frameTarget)
    if not frameTarget then return end
    local count = hookCounts[frameTarget]
    -- 只在首次或被完全清理后才注册新钩子
    if count == 0 then
        frameTarget:HookScript("OnEnter", ShowCornerMenuFrame)
        frameTarget:HookScript("OnLeave", HideCornerMenuFrame)
    end
    hookCounts[frameTarget] = count + 1
end

function UnhookCornerFrame(frameTarget)
    if not frameTarget then return end
    local count = hookCounts[frameTarget]
    if count <= 1 then
        -- 彻底清理
        frameTarget:SetScript("OnEnter", nil)
        frameTarget:SetScript("OnLeave", nil)
        hookCounts[frameTarget] = 0
    else
        -- 还有其他引用，仅减少计数
        hookCounts[frameTarget] = count - 1
    end
end

local function RefreshExperienceBars()
	-- Hide Unwanted Art
	MainMenuBarPageNumber:Hide();
	ActionBarUpButton:Hide();
	ActionBarDownButton:Hide();
	-- Experience Bar
	MainMenuBarTexture2:SetTexture(Empty_Art)
	MainMenuBarTexture3:SetTexture(Empty_Art)
	MainMenuBarTexture2:SetAlpha(0)
	MainMenuBarTexture3:SetAlpha(0)
	for i = 0, 3 do _G["MainMenuXPBarTexture" .. i]:SetTexture(Empty_Art) end

	-- Hide Rested State
	--ExhaustionLevelFillBar:SetTexture(Empty_Art)
	ExhaustionTick:SetAlpha(0)

	-- Max-level Rep Bar
	MainMenuMaxLevelBar0:SetAlpha(0)
	MainMenuMaxLevelBar1:SetAlpha(0)
	MainMenuMaxLevelBar2:SetAlpha(0)
	MainMenuMaxLevelBar3:SetAlpha(0)

	ReputationWatchBar.StatusBar.XPBarTexture0:SetAlpha(0)
	ReputationWatchBar.StatusBar.XPBarTexture1:SetAlpha(0)
	ReputationWatchBar.StatusBar.XPBarTexture2:SetAlpha(0)
	ReputationWatchBar.StatusBar.XPBarTexture3:SetAlpha(0)


	-- Rep Bar Bubbles (For the Rep Bar)
	--ReputationWatchBarTexture0:SetAlpha(0)
	ReputationWatchBar.StatusBar.WatchBarTexture0:SetAlpha(0)
	ReputationWatchBar.StatusBar.WatchBarTexture1:SetAlpha(0)
	ReputationWatchBar.StatusBar.WatchBarTexture2:SetAlpha(0)
	ReputationWatchBar.StatusBar.WatchBarTexture3:SetAlpha(0)
	--ReputationWatchBarTexture1:SetAlpha(0)
	--ReputationWatchBarTexture2:SetAlpha(0)
	--ReputationWatchBarTexture3:SetAlpha(0)

	-- Repositions the bubbles for the Rep Watch bar
	ReputationWatchBar.StatusBar.WatchBarTexture0:ClearAllPoints()
	ReputationWatchBar.StatusBar.WatchBarTexture0:SetPoint("LEFT", ReputationWatchBar, "LEFT", 0, 2)
	ReputationWatchBar.StatusBar.WatchBarTexture3:ClearAllPoints()
	ReputationWatchBar.StatusBar.WatchBarTexture3:SetPoint("LEFT", ReputationWatchBarTexture0, "RIGHT")
end

local lastRefreshTime = 0
local eventCooldowns = {}
local MIN_EVENT_COOLDOWN = 0.1

function RefreshPositions(event)
	local currentTime = GetTime()
	if event and eventCooldowns[event] and currentTime - eventCooldowns[event] < MIN_EVENT_COOLDOWN then
		return
	end
	if currentTime - lastRefreshTime < CONFIG.REFRESH_COOLDOWN then
		return
	end
	
	lastRefreshTime = currentTime
	if event then
		eventCooldowns[event] = currentTime
	end
	
	if InCombatLockdown() then
		TidyBar.pendingUpdate = true
		return
	end

	SafeCall(function()
		-- Change the size of the central button and status bars
		if MainMenuBar then MainMenuBar:SetWidth(512) end
		if MainMenuExpBar then MainMenuExpBar:SetWidth(512) end
		if ReputationWatchBar then ReputationWatchBar:SetWidth(512) end
		if MainMenuBarMaxLevelBar then MainMenuBarMaxLevelBar:SetWidth(512) end
		if ReputationWatchBar.StatusBar then ReputationWatchBar.StatusBar:SetWidth(512) end

		-- Hide backgrounds
		if SlidingActionBarTexture0 then
			SlidingActionBarTexture0:Hide()
			SlidingActionBarTexture0:SetAlpha(0)
		end
		if SlidingActionBarTexture1 then
			SlidingActionBarTexture1:Hide()
			SlidingActionBarTexture1:SetAlpha(0)
		end

		if StanceBarLeft then
			StanceBarLeft:Hide()
			StanceBarLeft:SetAlpha(0)
		end
		if StanceBarMiddle then
			StanceBarMiddle:Hide()
			StanceBarMiddle:SetAlpha(0)
		end
		if StanceBarRight then
			StanceBarRight:Hide()
			StanceBarRight:SetAlpha(0)
		end

		SafeCall(RefreshMainActionBars, "RefreshMainActionBars")
		SafeCall(RefreshCustomActionBars, "RefreshCustomActionBars")
		SafeCall(ConfigureCornerBars, "ConfigureCornerBars")
		SafeCall(RefreshExperienceBars, "RefreshExperienceBars")

		-- Adjust ExtraActionBarFrame position to avoid being blocked by action bars
		if ExtraActionBarFrame then
			ExtraActionBarFrame:ClearAllPoints()
			ExtraActionBarFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 320)
		end
	end, "RefreshPositions")
end

TidyBar.optionRunCount = 0
function ConfigureOptions()
    -- 确保TidyBarOptions和profiles表存在
    if not TidyBarOptions then
        TidyBarOptions = { profiles = {} }
    elseif not TidyBarOptions.profiles then
        TidyBarOptions.profiles = {}
    end

    local playerKey = GetPlayerKey()

    -- 确保当前角色的配置表存在
    if not TidyBarOptions.profiles[playerKey] then
        TidyBarOptions.profiles[playerKey] = {}
        for k, v in pairs(TidyBar.defaults) do
            if k ~= "profiles" then
                TidyBarOptions.profiles[playerKey][k] = v
            end
        end
    end

    -- 更新TidyBar.opts
    for k, v in pairs(TidyBarOptions.profiles[playerKey]) do
        TidyBar.opts[k] = v
    end

	-- 更新缩放值
	TidyBarScale = TidyBar.opts.Scale or 1

	if (TidyBar.optionRunCount < 1) then
		-- Create options interface - 参照 !!iCenter/AutoInvite.lua 兼容 MOP 5.5.3
		TidyBar.panel = CreateFrame("Frame", "TidyBarPanel", InterfaceOptionsFramePanelContainer)
		TidyBar.panel.name = "TidyBar"
		TidyBar.panel:Hide()

		local cb_art = CreateCheckbox("HideMainButtonArt", L["Hide main button art?"], TidyBar.panel, RefreshPositions)
		cb_art:SetPoint("TOPLEFT", 20, -20)
		local cb_xpbar = CreateCheckbox("HideExperienceBar", L["Hide experience & reputation bar?"], TidyBar.panel,
			RefreshPositions)
		cb_xpbar:SetPoint("TOPLEFT", cb_art, 0, -30)
		local cb_mo_bags = CreateCheckbox("AlwaysShowBagFrame", L["Always show bags?"], TidyBar.panel, RefreshPositions)
		cb_mo_bags:SetPoint("TOPLEFT", cb_xpbar, 0, -30)
		local cb_hide_menu = CreateCheckbox("HideBagAndMenu", L["Hide bags and menu?"], TidyBar.panel, RefreshPositions)
		cb_hide_menu:SetPoint("TOPLEFT", cb_mo_bags, 0, -30)

		-- Add Slider for TidyBar Scale
		local Slider = CreateFrame("Slider", "TidyBarScaleSlider", TidyBar.panel, "OptionsSliderTemplate")
		Slider:SetWidth(150)
		Slider:SetHeight(20)
		Slider:SetPoint("TOPRIGHT", TidyBar.panel, "TOPRIGHT", -20, -20)
		Slider:SetMinMaxValues(0.2, 2.0)
		Slider:SetValueStep(0.1)
		Slider:SetObeyStepOnDrag(true)
		Slider:SetOrientation("HORIZONTAL")
		Slider:SetValue(TidyBarScale)

		-- Slider value text display
		local SliderText = TidyBar.panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
		SliderText:SetPoint("BOTTOM", Slider, "TOP", 0, 5)
		SliderText:SetText(string.format(L["TidyBar Scale:"] .. " %.1f", TidyBarScale))

		Slider:SetScript("OnValueChanged", function(self, value)
			local playerKey = GetPlayerKey()
			TidyBarScale = value
			TidyBarOptions.profiles[playerKey].Scale = value
			TidyBar.opts.Scale = value
			MainMenuBar:SetScale(TidyBarScale)
			MultiBarRight:SetScale(TidyBarScale)
			MultiBarLeft:SetScale(TidyBarScale)
			CornerMenuFrame:SetScale(TidyBarScale)
			SliderText:SetText(string.format(L["TidyBar Scale:"] .. " %.1f", TidyBarScale))
		end)

		-- Fix for setting slider values
		_G[Slider:GetName() .. "Low"]:SetText("0.2")
		_G[Slider:GetName() .. "High"]:SetText("2.0")
		_G[Slider:GetName() .. "Text"]:SetText("")

		-- 添加自定义动作条复选框
		local cb_custom = CreateCheckbox("CustomActionBars", L["Custom Action Bars"], TidyBar.panel, function()
			if TidyBar.opts.CustomActionBars then
				local playerKey = GetPlayerKey()
				TidyBar.opts.HideMainButtonArt = true
				TidyBarOptions.profiles[playerKey].HideMainButtonArt = true
				cb_art:SetChecked(true)
			end
			RefreshPositions()
		end)
		cb_custom:SetPoint("TOPLEFT", cb_hide_menu, 0, -30)

		-- 添加布局下拉菜单
		local layoutDropdown = CreateFrame("Frame", "TidyBarLayoutDropdown", TidyBar.panel, "UIDropDownMenuTemplate")
		layoutDropdown:SetPoint("TOPLEFT", cb_custom, "BOTTOMLEFT", -15, -10)

		local function InitializeLayoutDropdown(self, level)
			local info = UIDropDownMenu_CreateInfo()
			info.func = function(self)
				local playerKey = GetPlayerKey()
				TidyBar.opts.CustomActionBarLayout = self.value
				TidyBarOptions.profiles[playerKey].CustomActionBarLayout = self.value
				UIDropDownMenu_SetText(layoutDropdown, self.value)
				RefreshPositions()
			end

			info.text = "3x4"
			info.value = "3x4"
			info.checked = TidyBar.opts.CustomActionBarLayout == "3x4"
			UIDropDownMenu_AddButton(info)

			info.text = "4x3"
			info.value = "4x3"
			info.checked = TidyBar.opts.CustomActionBarLayout == "4x3"
			UIDropDownMenu_AddButton(info)

			info.text = "2x6"
			info.value = "2x6"
			info.checked = TidyBar.opts.CustomActionBarLayout == "2x6"
			UIDropDownMenu_AddButton(info)

			info.text = "6x2"
			info.value = "6x2"
			info.checked = TidyBar.opts.CustomActionBarLayout == "6x2"
			UIDropDownMenu_AddButton(info)

			info.text = "1x12"
			info.value = "1x12"
			info.checked = TidyBar.opts.CustomActionBarLayout == "1x12"
			UIDropDownMenu_AddButton(info)
		end

		UIDropDownMenu_Initialize(layoutDropdown, InitializeLayoutDropdown)
		UIDropDownMenu_SetText(layoutDropdown, TidyBar.opts.CustomActionBarLayout)
		local layoutLabel = TidyBar.panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		layoutLabel:SetPoint("BOTTOMLEFT", layoutDropdown, "TOPLEFT", 20, 0)
		layoutLabel:SetText(L["Custom Action Bar Layout"])

		-- 添加自定义动作条缩放滑块
		local CustomSlider = CreateFrame("Slider", "TidyBarCustomScaleSlider", TidyBar.panel, "OptionsSliderTemplate")
		CustomSlider:SetWidth(150)
		CustomSlider:SetHeight(20)
		CustomSlider:SetPoint("TOPRIGHT", Slider, "BOTTOMRIGHT", 0, -30)
		CustomSlider:SetMinMaxValues(0.2, 2.0)
		CustomSlider:SetValueStep(0.1)
		CustomSlider:SetObeyStepOnDrag(true)
		CustomSlider:SetValue(TidyBar.opts.CustomActionBarScale)

		local CustomSliderText = TidyBar.panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
		CustomSliderText:SetPoint("BOTTOM", CustomSlider, "TOP", 0, 5)
		CustomSliderText:SetText(string.format(L["Custom Action Bar Scale:"] .. " %.1f",
			TidyBar.opts.CustomActionBarScale))

			CustomSlider:SetScript("OnValueChanged", function(self, value)
				local playerKey = GetPlayerKey()
				TidyBarOptions.profiles[playerKey].CustomActionBarScale = value
				TidyBar.opts.CustomActionBarScale = value
				CustomSliderText:SetText(string.format(L["Custom Action Bar Scale:"] .. " %.1f", value))
				RefreshPositions()
			end)

		-- 修复滑块文本
		_G[CustomSlider:GetName() .. "Low"]:SetText("0.2")
		_G[CustomSlider:GetName() .. "High"]:SetText("2.0")
		_G[CustomSlider:GetName() .. "Text"]:SetText("")

		-- 更新显示状态
		local function UpdateCustomBarOptions()
			if TidyBar.opts.CustomActionBars then
				layoutDropdown:Show()
				layoutLabel:Show()
			else
				layoutDropdown:Hide()
				layoutLabel:Hide()
			end
		end

		cb_custom:HookScript("OnClick", UpdateCustomBarOptions)
		UpdateCustomBarOptions()

		-- 添加按键绑定按钮
		local keybindingButton = CreateFrame("Button", nil, TidyBar.panel, "UIPanelButtonTemplate")
		keybindingButton:SetWidth(150)
		keybindingButton:SetHeight(25)
		keybindingButton:SetPoint("TOPLEFT", layoutDropdown, "BOTTOMLEFT", 15, -15)
		keybindingButton:SetText(L["Keybinding Button"])
		keybindingButton:SetScript("OnClick", function()
			TidyBar:EnableKeybinding()
		end)

		-- 添加配置导出按钮
		local exportButton = CreateFrame("Button", nil, TidyBar.panel, "UIPanelButtonTemplate")
		exportButton:SetWidth(150)
		exportButton:SetHeight(25)
		exportButton:SetPoint("TOPLEFT", keybindingButton, "BOTTOMLEFT", 0, -15)
		exportButton:SetText("导出配置")
		exportButton:SetScript("OnClick", function()
			TidyBar:ExportConfig()
		end)

		-- 添加配置导入按钮
		local importButton = CreateFrame("Button", nil, TidyBar.panel, "UIPanelButtonTemplate")
		importButton:SetWidth(150)
		importButton:SetHeight(25)
		importButton:SetPoint("TOPLEFT", exportButton, "BOTTOMLEFT", 0, -15)
		importButton:SetText("导入配置")
		importButton:SetScript("OnClick", function()
			TidyBar:ShowImportDialog()
		end)

		-- 注册到设置界面 - 匹配 AutoInvite 模式
		if _G.InterfaceOptions_AddCategory then
			InterfaceOptions_AddCategory(TidyBar.panel)
		elseif _G.Settings and _G.Settings.RegisterCanvasLayoutCategory then
			local category = _G.Settings.RegisterCanvasLayoutCategory(TidyBar.panel, TidyBar.panel.name)
			_G.Settings.RegisterAddOnCategory(category)
		end
	end
	TidyBar.optionRunCount = TidyBar.optionRunCount + 1
end

function CreateCheckbox(savedvar, label, parent, update)
    local playerKey = GetPlayerKey()
    local cb = CreateFrame("CheckButton", "cb" .. savedvar, parent, "ChatConfigCheckButtonTemplate")
    _G["cb" .. savedvar .. "Text"]:SetText(label)
    cb.key = savedvar
    cb:SetChecked(TidyBar.opts[savedvar])
    cb:SetScript("OnClick", function(self)
        TidyBarOptions.profiles[playerKey][self.key] = not TidyBarOptions.profiles[playerKey][self.key]
        TidyBar.opts[self.key] = TidyBarOptions.profiles[playerKey][self.key]

        -- 处理互斥关系
        if self.key == "CustomActionBars" then
            if TidyBarOptions.profiles[playerKey][self.key] then
                TidyBarOptions.profiles[playerKey].HideMainButtonArt = true
                TidyBar.opts.HideMainButtonArt = true
                if _G["cbHideMainButtonArt"] then
                    _G["cbHideMainButtonArt"]:SetChecked(true)
                end
            end
        elseif self.key == "HideBagAndMenu" and TidyBarOptions.profiles[playerKey][self.key] then
            TidyBarOptions.profiles[playerKey].AlwaysShowBagFrame = false
            TidyBar.opts.AlwaysShowBagFrame = false
            if _G["cbAlwaysShowBagFrame"] then
                _G["cbAlwaysShowBagFrame"]:SetChecked(false)
            end
        elseif self.key == "AlwaysShowBagFrame" and TidyBarOptions.profiles[playerKey][self.key] then
            TidyBarOptions.profiles[playerKey].HideBagAndMenu = false
            TidyBar.opts.HideBagAndMenu = false
            if _G["cbHideBagAndMenu"] then
                _G["cbHideBagAndMenu"]:SetChecked(false)
            end
        end

        if update then update() end
        TidyBar:UpdateCornerFrameVisibility()
    end)
    return cb
end

-- Event Handlers
local events = {}

function events:ACTIONBAR_SHOWGRID() ButtonGridIsShown = true; end

function events:ACTIONBAR_HIDEGRID() ButtonGridIsShown = false; end

function events:UNIT_EXITED_VEHICLE(event)
	DelayEvent(RefreshPositions, GetTime() + 0.5)
	DelayEvent(ConfigureCornerBars, GetTime() + 1)
end

function events:UNIT_ENTERED_VEHICLE(event)
	-- 进入载具时不刷新位置（安全框架限制下无法修改属性）
	-- 仅在离开载具时刷新
	DelayEvent(ConfigureCornerBars, GetTime() + 1)
end

events.PLAYER_ENTERING_WORLD = function(event)
	RefreshPositions(event)
end
events.UPDATE_INSTANCE_INFO = function(event)
	RefreshPositions(event)
end
events.PET_BAR_UPDATE = function(event)
	RefreshPositions(event)
end
events.UPDATE_BONUS_ACTIONBAR = function(event)
	RefreshPositions(event)
end
events.PLAYER_LEVEL_UP = function(event)
	RefreshPositions(event)
end

events.QUEST_WATCH_UPDATE = function(event)
	RefreshPositions(event)
end
events.ACTIONBAR_SLOT_CHANGED = function(event)
	RefreshPositions(event)
end
events.LEARNED_SPELL_IN_TAB = function(event)
	RefreshPositions(event)
end
events.UPDATE_BINDINGS = function(event)
	RefreshPositions(event)
end
-- 检查插件冲突
local function CheckForConflicts()
	local conflictingAddons = {
		"Bartender4",
		"Dominos",
		"ElvUI",
		"LUI",
		"TukUI",
		"SUI",
	}
	
	local conflicts = {}
	for _, addon in ipairs(conflictingAddons) do
		if IsAddOnLoaded(addon) then
			table.insert(conflicts, addon)
		end
	end
	
	if #conflicts > 0 then
		print("|cffff0000TidyBar: 检测到以下可能冲突的插件:|r")
		for _, addon in ipairs(conflicts) do
			print("|cffff0000- " .. addon .. "|r")
		end
		print("|cffff0000这些插件可能会影响TidyBar的功能，请考虑禁用其中一个。|r")
	end
end

events.ADDON_LOADED = function(event, addonName)
	if addonName ~= "TidyBar" then return end
	ConfigureOptions()
	CheckForConflicts()
end
events.PLAYER_REGEN_ENABLED = function(event)
	if TidyBar.pendingUpdate then
		RefreshPositions(event)
		TidyBar.pendingUpdate = false
	end
end

local function EventHandler(frame, event)
	if events[event] then
		events[event](event)
	end
end

events.CVAR_UPDATE = function(event, varname, value)
    if varname == "alwaysShowActionBars" then
        RefreshPositions(event)
    end
end

-- Set Event Monitoring
for eventname in pairs(events) do
	TidyBar:RegisterEvent(eventname)
end


-----------------------------------------------------------------------------
-- Menu Menu and Artwork
do
	-- Call Update Function when the default UI makes changes
	hooksecurefunc("UIParent_ManageFramePositions", RefreshPositions);
	-- Required in order to move the frames around
	UIPARENT_MANAGED_FRAME_POSITIONS["MultiBarBottomRight"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["PetActionBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["ShapeshiftBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["PossessBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["MultiCastActionBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["ExtraActionBarFrame"] = nil

	-- Adjust ExtraActionBarFrame position immediately to avoid delayed positioning
	if ExtraActionBarFrame then
		ExtraActionBarFrame:ClearAllPoints()
		ExtraActionBarFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 320)
	end

	-- Scaling
	MainMenuBar:SetScale(TidyBarScale)
	MultiBarRight:SetScale(TidyBarScale)
	MultiBarLeft:SetScale(TidyBarScale)

	-- Adjust the fill and endcap artwork
	MainMenuBarTexture0:SetPoint("LEFT", MainMenuBar, "LEFT", 0, 0);
	MainMenuBarTexture1:SetPoint("RIGHT", MainMenuBar, "RIGHT", 0, 0);
	MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBar, "LEFT", 32, 0);
	MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBar, "RIGHT", -32, 0);

	-- Hide 'ring' around the stance/shapeshift buttons
	for i = 1, 10 do
		_G["StanceButton" .. i .. "NormalTexture2"]:SetTexture(Empty_Art)
	end

	RefreshExperienceBars()

	-- Set Pet Bars
	PetActionBarFrame:SetAttribute("unit", "pet")

	MainMenuBar:HookScript("OnShow", function()
		RefreshPositions()
	end)

	RefreshCustomActionBars()
end

-----------------------------------------------------------------------------
-- Corner Menu
do
	-- Keyring etc
	for i, name in pairs(BagButtonFrameList) do
		name:SetParent(CornerMenuFrame.BagButtonFrame)
		local width = name:GetWidth();
		name:SetWidth(width - 2);
		--print( name:GetWidth() )
		--name:ClearAllPoints()
		--name:SetPoint("LEFT", 0, 0)
	end

	MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("BOTTOM");
	MainMenuBarBackpackButton:SetPoint("RIGHT", 0, 0);

	-- Setup the Corner Menu Artwork
	CornerMenuFrame:SetScale(TidyBarScale)

	-- 根据 TidyBarHideBagAndMenu 的值来设置显示或隐藏
	if TidyBar.opts.HideBagAndMenu then
		-- 隐藏背包和菜单栏
		CornerMenuFrame.MicroButtons:SetHeight(0)
		CornerMenuFrame.MicroButtons:SetWidth(0)
		CornerMenuFrame.BagButtonFrame:SetHeight(0)
		CornerMenuFrame.BagButtonFrame:SetWidth(0)
	else
		-- 显示背包和菜单栏
		-- 你可以根据需要设置具体的位置和大小
		CornerMenuFrame:SetScale(TidyBarScale)
		CornerMenuFrame.MicroButtons:SetPoint("BOTTOMRIGHT", 0, 1)
		CornerMenuFrame.MicroButtons:SetHeight(45)
		CornerMenuFrame.MicroButtons:SetWidth(256)
		CornerMenuFrame.BagButtonFrame:SetPoint("BOTTOMRIGHT", -5, 40)
		CornerMenuFrame.BagButtonFrame:SetHeight(45)
		CornerMenuFrame.BagButtonFrame:SetWidth(256)
		--CornerMenuFrame.BagButtonFrame:SetScale(TidyBarScale)
		CornerMouseoverFrame:SetFrameStrata("BACKGROUND")
		CornerMouseoverFrame:SetPoint("TOP", MainMenuBarBackpackButton, "TOP", 0, 10)
		CornerMouseoverFrame:SetPoint("RIGHT", UIParent, "RIGHT")
		CornerMouseoverFrame:SetPoint("BOTTOM", UIParent, "BOTTOM")
		CornerMouseoverFrame:SetWidth(200)
	end

	-- 设置鼠标悬停效果
	CornerMouseoverFrame:SetScript("OnEnter", function()
		if not TidyBar.opts.HideBagAndMenu then
			CornerMenuFrame:SetAlpha(1)
		end
	end)
	CornerMouseoverFrame:SetScript("OnLeave", function()
		if not TidyBar.opts.HideBagAndMenu then
			CornerMenuFrame:SetAlpha(0)
		end
	end)
end

-- Start Tidy Bar
TidyBar:SetScript("OnEvent", EventHandler);
TidyBar:SetFrameStrata("TOOLTIP")
TidyBar:Show()

SLASH_TIDYBAR1 = '/tidybar'
SlashCmdList.TIDYBAR = function(msg, editBox)
	-- lazy init: 如果面板还没创建，先创建
	if not TidyBar.panel then
		ConfigureOptions()
	end
	-- 匹配 AutoInvite 模式：优先新 API
	if _G.Settings and _G.Settings.OpenToCategory then
		_G.Settings.OpenToCategory(TidyBar.panel.name)
	elseif _G.InterfaceOptionsFrame_OpenToCategory then
		InterfaceOptionsFrame_OpenToCategory(TidyBar.panel)
	end
end

-- 导出配置
function TidyBar:ExportConfig()
	local playerKey = GetPlayerKey()
	local config = TidyBarOptions.profiles[playerKey]
	if not config then
		print("|cffff0000TidyBar: 没有找到配置数据|r")
		return
	end
	
	-- 转换为JSON字符串
	local json = "{"
	local first = true
	for k, v in pairs(config) do
		if first then
			first = false
		else
			json = json .. ","
		end
		
		if type(v) == "string" then
			json = json .. string.format('"%s":"%s"', k, v)
		else
			json = json .. string.format('"%s":%s', k, tostring(v))
		end
	end
	json = json .. "}"
	
	-- 复制到剪贴板
	if ChatEdit_GetActiveWindow() then
		ChatEdit_GetActiveWindow():Insert(json)
	else
		print("|cffffff00TidyBar: 配置已导出，请按Ctrl+V粘贴到文本编辑器中保存|r")
		print("|cffffff00" .. json .. "|r")
	end
end

-- 导入配置对话框
local ImportDialog = nil

function TidyBar:ShowImportDialog()
	if not ImportDialog then
		ImportDialog = CreateFrame("Frame", "TidyBarImportDialog", UIParent)
		ImportDialog:SetFrameStrata("DIALOG")
		ImportDialog:SetWidth(450)
		ImportDialog:SetHeight(200)
		ImportDialog:SetPoint("CENTER")
		
		-- 创建背景
		local bg = ImportDialog:CreateTexture(nil, "BACKGROUND")
		bg:SetAllPoints()
		bg:SetColorTexture(0, 0, 0, 0.8)
		
		-- 创建边框
		local border = CreateFrame("Frame", nil, ImportDialog)
		border:SetAllPoints()
		-- MOP 5.5.3: SetBackdrop is a method only available with proper template
		if border.SetBackdrop then
			border:SetBackdrop({
				edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
				edgeSize = 32,
				insets = { left = 11, right = 12, top = 12, bottom = 11 },
			})
		end
		
		-- 创建标题
		local title = ImportDialog:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
		title:SetPoint("TOP", 0, -20)
		title:SetText("导入配置")
		
		-- 创建说明文本
		local text = ImportDialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		text:SetPoint("TOP", title, "BOTTOM", 0, -10)
		text:SetText("请粘贴配置字符串，然后点击导入按钮")
		
		-- 创建输入框
		local editBox = CreateFrame("EditBox", nil, ImportDialog, "InputBoxTemplate")
		editBox:SetWidth(400)
		editBox:SetHeight(80)
		editBox:SetPoint("TOP", text, "BOTTOM", 0, -10)
		editBox:SetMultiLine(true)
		editBox:SetMaxLetters(2000)
		editBox:SetAutoFocus(false)
		editBox:SetScript("OnEscapePressed", function() ImportDialog:Hide() end)
		
		-- 创建导入按钮
		local importButton = CreateFrame("Button", nil, ImportDialog, "UIPanelButtonTemplate")
		importButton:SetWidth(100)
		importButton:SetHeight(25)
		importButton:SetPoint("BOTTOM", -60, 20)
		importButton:SetText("导入")
		importButton:SetScript("OnClick", function()
			local success = TidyBar:ImportConfig(editBox:GetText())
			if success then
				ImportDialog:Hide()
				print("|cff00ff00TidyBar: 配置导入成功|r")
			end
		end)
		
		-- 创建取消按钮
		local cancelButton = CreateFrame("Button", nil, ImportDialog, "UIPanelButtonTemplate")
		cancelButton:SetWidth(100)
		cancelButton:SetHeight(25)
		cancelButton:SetPoint("BOTTOM", 60, 20)
		cancelButton:SetText("取消")
		cancelButton:SetScript("OnClick", function() ImportDialog:Hide() end)
		
		-- 添加到ESC键处理队列
		tinsert(UISpecialFrames, "TidyBarImportDialog")
	end
	
	ImportDialog:Show()
end

-- 导入配置
function TidyBar:ImportConfig(jsonStr)
	if not jsonStr or jsonStr == "" then
		print("|cffff0000TidyBar: 配置字符串为空|r")
		return false
	end
	
	local success, config = pcall(function()
		-- 简单的JSON解析
		return loadstring("return " .. jsonStr)()
	end)
	
	if not success or type(config) ~= "table" then
		print("|cffff0000TidyBar: 配置字符串格式错误|r")
		return false
	end
	
	-- 导入配置
	local playerKey = GetPlayerKey()
	TidyBarOptions.profiles[playerKey] = config
	
	-- 如果布局发生变化，需要重建自定义动作条按钮
	local oldLayout = TidyBar.opts.CustomActionBarLayout
	ConfigureOptions()
	if oldLayout ~= TidyBar.opts.CustomActionBarLayout then
		-- 清理旧按钮状态，让 RefreshCustomActionBars 重新创建
		if TidyBarLeftActionBar then
			TidyBarLeftActionBar.buttons = nil
		end
		if TidyBarRightActionBar then
			TidyBarRightActionBar.buttons = nil
		end
		-- 重置状态驱动器注册标记
		stateDriversRegistered = false
	end
	
	RefreshPositions()
	
	return true
end

-- 创建按键绑定提示框
local KeybindingFrame = CreateFrame("Frame", "TidyBarKeybindingFrame", UIParent)
KeybindingFrame:SetFrameStrata("DIALOG")
KeybindingFrame:SetWidth(450)
KeybindingFrame:SetHeight(150)
KeybindingFrame:SetPoint("CENTER")
KeybindingFrame:Hide()

-- 创建背景
local bg = KeybindingFrame:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints()
bg:SetColorTexture(0, 0, 0, 0.4)

-- 创建边框
local border = CreateFrame("Frame", nil, KeybindingFrame)
border:SetAllPoints()
-- MOP 5.5.3: SetBackdrop is a method only available with proper template
if border.SetBackdrop then
	border:SetBackdrop({
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		edgeSize = 32,
		insets = { left = 11, right = 12, top = 12, bottom = 11 },
	})
end

-- 创建标题文本
local title = KeybindingFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", 0, -20)
title:SetText(L["Keybinding Mode"])

-- 创建说明文本
local text = KeybindingFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetPoint("TOP", title, "BOTTOM", 0, -10)
text:SetText(L["Mouse over action buttons and press a key to bind it."])

-- 创建当前按钮文本
local currentButton = KeybindingFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
currentButton:SetPoint("TOP", text, "BOTTOM", 0, -10)
currentButton:SetText(L["Current Button: "] .. L["None"])

-- 创建当前绑定文本
local currentBinding = KeybindingFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
currentBinding:SetPoint("TOP", currentButton, "BOTTOM", 0, -10)
currentBinding:SetText("")

local currentBindingButton = nil

function TidyBar:DisableKeybinding()
	KeybindingFrame:Hide()
	KeybindingFrame:EnableKeyboard(false)
	KeybindingFrame:EnableMouse(false)
	KeybindingFrame:SetScript("OnKeyDown", nil)
	KeybindingFrame:SetScript("OnMouseDown", nil)
	currentBindingButton = nil
end

-- 按键绑定处理函数
local function ProcessBinding(key)
	if currentBindingButton then
		local oldBinding = ""
		for i = 1, GetNumBindings() do
			local key1, key2 = GetBinding(i)
			local bindingAction = GetBindingAction(key1)
			if bindingAction == "CLICK " .. currentBindingButton:GetName() .. ":LeftButton" then
				oldBinding = oldBinding .. key1 .. " "
			end
			if key2 then
				bindingAction = GetBindingAction(key2)
				if bindingAction == "CLICK " .. currentBindingButton:GetName() .. ":LeftButton" then
					oldBinding = oldBinding .. key2 .. " "
				end
			end
		end
		SetBinding(key, "CLICK " .. currentBindingButton:GetName() .. ":LeftButton")
		SaveBindings(GetCurrentBindingSet())
		currentBinding:SetText(L["Binding set: "] .. key .. (oldBinding ~= "" and " (" .. L["replaced: "] .. oldBinding .. ")" or ""))
	end
end

-- 按键绑定功能
function TidyBar:EnableKeybinding()
	KeybindingFrame:Show()
	-- 启用全局按键捕获
	KeybindingFrame:EnableKeyboard(true)
	KeybindingFrame:EnableMouse(true)
	KeybindingFrame:SetPropagateKeyboardInput(false)

	-- 设置键盘按键处理函数
	KeybindingFrame:SetScript("OnKeyDown", function(self, key)
		if key == "ESCAPE" then
			TidyBar:DisableKeybinding()
			return
		end
		ProcessBinding(key)
	end)

	-- 设置鼠标按键处理函数
	KeybindingFrame:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			return
		end
		local mouseButton = "BUTTON" .. button
		ProcessBinding(mouseButton)
	end)

	-- 添加到ESC键处理队列（仅插入一次）
	if not TidyBar.keybindingFrameRegistered then
		tinsert(UISpecialFrames, "TidyBarKeybindingFrame")
		TidyBar.keybindingFrameRegistered = true
	end
end

-- 创建清除绑定按钮
local clearButton = CreateFrame("Button", nil, KeybindingFrame, "UIPanelButtonTemplate")
clearButton:SetWidth(120)
clearButton:SetHeight(25)
clearButton:SetPoint("BOTTOM", -70, 15)
clearButton:SetText(L["Clear Binding"])
clearButton:SetScript("OnClick", function()
	if currentBindingButton then
		local action = currentBindingButton.action
		for i = 1, GetNumBindings() do
			local key1, key2 = GetBinding(i)
			local bindingAction = GetBindingAction(key1)
			if bindingAction == "CLICK " .. currentBindingButton:GetName() .. ":LeftButton" then
				SetBinding(key1)
			end
			if key2 then
				bindingAction = GetBindingAction(key2)
				if bindingAction == "CLICK " .. currentBindingButton:GetName() .. ":LeftButton" then
					SetBinding(key2)
				end
			end
		end
		SaveBindings(GetCurrentBindingSet())
		currentBinding:SetText(L["Binding cleared!"])
	end
end)

-- 创建退出按钮
local exitButton = CreateFrame("Button", nil, KeybindingFrame, "UIPanelButtonTemplate")
exitButton:SetWidth(120)
exitButton:SetHeight(25)
exitButton:SetPoint("BOTTOM", 70, 15)
exitButton:SetText(L["Exit"])
exitButton:SetScript("OnClick", function()
	TidyBar:DisableKeybinding()
end)

-- 添加鼠标悬停处理函数
local function OnActionButtonEnter(self)
    if KeybindingFrame:IsShown() then
        currentBindingButton = self
        currentButton:SetText(L["Current Button: "] .. self:GetName())
        local bindingText = ""
        for i = 1, GetNumBindings() do
            local key1, key2 = GetBinding(i)
            local bindingAction = GetBindingAction(key1)
            if bindingAction == "CLICK " .. self:GetName() .. ":LeftButton" then
                bindingText = bindingText .. key1 .. " "
            end
            if key2 then
                bindingAction = GetBindingAction(key2)
                if bindingAction == "CLICK " .. self:GetName() .. ":LeftButton" then
                    bindingText = bindingText .. key2 .. " "
                end
            end
        end
        if bindingText == "" then
            currentBinding:SetText(L["No binding"])
        else
            currentBinding:SetText(L["Current binding: "] .. bindingText)
        end
    end
end

local function OnActionButtonLeave(self)
    if KeybindingFrame:IsShown() then
        currentBindingButton = nil
        currentButton:SetText(L["Current Button: "] .. L["None"])
        currentBinding:SetText("")
    end
end

-- 添加斜杠命令
SLASH_KEYBIND1 = '/kb'
SlashCmdList.KEYBIND = function(msg, editBox)
	if KeybindingFrame:IsShown() then
		TidyBar:DisableKeybinding()
	else
		TidyBar:EnableKeybinding()
		-- 为所有动作条按钮添加鼠标悬停事件
		for i = 1, 12 do
			-- 主动作条
			local button = _G["ActionButton" .. i]
			if button then
				button:HookScript("OnEnter", OnActionButtonEnter)
				button:HookScript("OnLeave", OnActionButtonLeave)
			end
			-- 其他动作条
			local bars = {
				"MultiBarBottomLeftButton",
				"MultiBarBottomRightButton",
				"MultiBarRightButton",
				"MultiBarLeftButton",
				"TidyBarLeftButton",
				"TidyBarRightButton"
			}
			for _, barName in ipairs(bars) do
				button = _G[barName .. i]
				if button then
					button:HookScript("OnEnter", OnActionButtonEnter)
					button:HookScript("OnLeave", OnActionButtonLeave)
				end
			end
		end
	end
end

function TidyBar:OnDisable()
    for eventname in pairs(events) do
        TidyBar:UnregisterEvent(eventname)
    end
    -- 清理所有钩子
    for i, name in pairs(BagButtonFrameList) do UnhookCornerFrame(name) end
    for i, name in pairs(MenuButtonFrames) do UnhookCornerFrame(name) end
    UnhookCornerFrame(CornerMouseoverFrame)
end
