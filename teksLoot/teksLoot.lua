-- teksLoot 经典版
-- 集成美化和布局

local myname, ns = ...
ns = ns or {}

-- 确保teksLootDB变量持久化
_G.teksLootDB = _G.teksLootDB or {x = nil, y = nil}

-- 本地化文本
local NEED = "需求"
local GREED = "贪婪"
local ROLL_DISENCHANT = "分解"
local PASS = "放弃"

-- 聊天识别正则（只保留中文服务器实际使用的格式）
ns.rollpairs = {
    ["(.*)自动放弃了(.+)，因为他无法拾取该物品。$"]  = "pass",
    ["(.*)放弃了：(.+)"] = "pass",
    ["(.*)选择了贪婪取向：(.+)"] = "greed",
    ["(.*)选择了需求取向：(.+)"] = "need",
    ["(.*)选择了分解取向：(.+)"] = "disenchant",
}

-- 材质路径
local blank = "Interface\\AddOns\\teksLoot\\media\\blank"
local glow = "Interface\\AddOns\\teksLoot\\media\\glow"

-- 职业颜色缓存
local classCache = {}

-- 确保frames始终被初始化
local frames = {}

-- 取消Roll事件的记录
local cancelled_rolls = {}

-- 获取玩家职业颜色的函数，替换过时的API
local function GetPlayerClass(name)
	-- 检查缓存
	if classCache[name] then return classCache[name] end

	-- 处理跨服格式
	local playerName = name:match("([^-]+)")
	if not playerName then playerName = name end
	
	-- 优先检查本地玩家
	if playerName == UnitName("player") then
		local _, playerClass = UnitClass("player")
		classCache[name] = playerClass
		return playerClass
	end
	
	-- 检查小队/团队成员
	if IsInGroup() then
		local numMembers = GetNumGroupMembers()
		local unitPrefix = IsInRaid() and "raid" or "party"
		
		for i = 1, numMembers do
			local unit = unitPrefix .. i
			if UnitExists(unit) then
				local unitName = UnitName(unit)
				local unitServer = select(2, UnitFullName(unit)) or ""
				
				if unitName == playerName or 
				   unitName == name or 
				   (unitServer ~= "" and unitName.."-"..unitServer == name) then
					local _, class = UnitClass(unit)
					classCache[name] = class
					return class
				end
			end
		end
	end
	
	-- 检查目标和鼠标悬停目标
	if UnitExists("target") and UnitName("target") == playerName then
		local _, class = UnitClass("target")
		classCache[name] = class
		return class
	end
	
	if UnitExists("mouseover") and UnitName("mouseover") == playerName then
		local _, class = UnitClass("mouseover")
		classCache[name] = class
		return class
	end
	
	classCache[name] = nil
	return nil
end

-- 美化函数
local function CreateBorder(f, r, g, b, a)
	f:SetBackdrop({
		edgeFile = blank, 
		edgeSize = 1,
		insets = { left = -1, right = -1, top = -1, bottom = -1 }
	})
	f:SetBackdropBorderColor(r or 0, g or 0, b or 0, 0) -- 将边框设为完全透明
end

local function CreateShadow(f)
	if f.shadow then return end
		
	local border = CreateFrame("Frame", nil, f, "BackdropTemplate")
	border:SetFrameLevel(1)
	border:SetPoint("TOPLEFT", -1, 1)
	border:SetPoint("TOPRIGHT", 1, 1)
	border:SetPoint("BOTTOMRIGHT", 1, -1)
	border:SetPoint("BOTTOMLEFT", -1, -1)
	border:EnableMouse(false) -- 确保边框不遮挡点击
	CreateBorder(border)
	f.border = border

	local shadow = CreateFrame("Frame", nil, border, "BackdropTemplate")
	shadow:SetFrameLevel(0)
	shadow:SetPoint("TOPLEFT", -3, 3)
	shadow:SetPoint("TOPRIGHT", 3, 3)
	shadow:SetPoint("BOTTOMRIGHT", 3, -3)
	shadow:SetPoint("BOTTOMLEFT", -3, -3)
	shadow:EnableMouse(false) -- 确保阴影不遮挡点击
	shadow:SetBackdrop( { 
		edgeFile = glow,
		bgFile = blank,
		edgeSize = 4,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	})
	shadow:SetBackdropColor(0.05, 0.05, 0.05, 0) -- 完全透明
	shadow:SetBackdropBorderColor(0, 0, 0, 0) -- 完全透明
	f.shadow = shadow
end

local backdrop = {
	bgFile = blank, tile = true, tileSize = 2,
	edgeFile = "", edgeSize = 0, -- 移除边框
	insets = {left = 0, right = 0, top = 0, bottom = 0},
}

-- 点击函数
local function ClickRoll(frame)
    RollOnLoot(frame.parent.rollid, frame.rolltype)
end

-- 提示函数
local function HideTip() GameTooltip:Hide() end
local function HideTip2() GameTooltip:Hide(); ResetCursor() end

-- 调整颜色亮度的辅助函数
local function AdjustColor(color, multiplier, alpha)
    return math.min(color.r * multiplier, 1.0),
           math.min(color.g * multiplier, 1.0),
           math.min(color.b * multiplier, 1.0),
           alpha or 1.0
end

-- Roll类型
local rolltypes = {"need", "greed", "disenchant", [0] = "pass"}

-- 反向映射，用于匹配
local reverseRolltypes = {}
for k, v in pairs(rolltypes) do
    reverseRolltypes[v] = k
end

-- 确保颜色表可用
local function EnsureClassColors()
    if not RAID_CLASS_COLORS then
        RAID_CLASS_COLORS = {
            ["WARRIOR"] = { r = 0.78, g = 0.61, b = 0.43 },
            ["MAGE"] = { r = 0.41, g = 0.8, b = 0.94 },
            ["ROGUE"] = { r = 1, g = 0.96, b = 0.41 },
            ["DRUID"] = { r = 1, g = 0.49, b = 0.04 },
            ["HUNTER"] = { r = 0.67, g = 0.83, b = 0.45 },
            ["SHAMAN"] = { r = 0, g = 0.44, b = 0.87 },
            ["PRIEST"] = { r = 1, g = 1, b = 1 },
            ["WARLOCK"] = { r = 0.58, g = 0.51, b = 0.79 },
            ["PALADIN"] = { r = 0.96, g = 0.55, b = 0.73 },
            ["DEATHKNIGHT"] = { r = 0.77, g = 0.12, b = 0.23 },
            ["MONK"] = { r = 0, g = 1, b = 0.59 },
            ["DEMONHUNTER"] = { r = 0.64, g = 0.19, b = 0.79 },
        }
    end
end

-- 添加一个清理玩家名称的函数
local function CleanPlayerName(name)
    if not name then return nil end
    
    -- 保留玩家服务器信息
    local playerName, serverName = name:match("([^-]+)-(.+)")
    if not playerName then 
        playerName = name
    end
    
    -- 移除各种前缀和垃圾字符
    playerName = playerName:gsub("|HlootHistory:%d+：", "")
                           :gsub("%[战利品%]：", "")
                           :gsub("%[.-%]%s*", "")
                           :gsub("|H.-|h", "")
                           :gsub("|h", "")
                           :gsub("^：", "")
                           :gsub("^%s*(.-)%s*$", "%1")
    
    -- 重新组合名字和服务器
    return serverName and (playerName.."-"..serverName) or playerName
end

local function SetTooltipCommon(tooltip)
    tooltip:SetFrameStrata("TOOLTIP")
    tooltip:SetFrameLevel(180)
end

local function SetTip(frame)
	GameTooltip:SetOwner(frame, "ANCHOR_TOP", 0, 10)
	SetTooltipCommon(GameTooltip)
	GameTooltip:SetText(frame.tiptext or "未知")
	
	if frame:IsEnabled() == 0 then 
		GameTooltip:AddLine("|cffff3333不能Roll点") 
	end
	
	EnsureClassColors()
	
	local rollCount = 0
	if frame.parent and frame.parent.rolls then
		for name, roll in pairs(frame.parent.rolls) do 
			local matched = false
			if roll == rolltypes[frame.rolltype] or 
               reverseRolltypes[roll] == frame.rolltype or
               tostring(roll) == tostring(frame.rolltype) then
				matched = true
			end
			
			if matched then
				local playerClass = GetPlayerClass(name)
				if playerClass and RAID_CLASS_COLORS and RAID_CLASS_COLORS[playerClass] then
					local color = RAID_CLASS_COLORS[playerClass]
					GameTooltip:AddLine(name, color.r, color.g, color.b)
				else
					GameTooltip:AddLine(name, 1, 1, 1)
				end
				rollCount = rollCount + 1
			end
        end
    end
	
	if rollCount == 0 and frame:IsEnabled() ~= 0 then
		GameTooltip:AddLine("暂无玩家选择", 0.7, 0.7, 0.7)
	end
    GameTooltip:Show()
end

-- 物品提示
local function SetItemTip(frame)
	if not frame.link then return end
	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT", 0, 0) 
	SetTooltipCommon(GameTooltip)
	GameTooltip:SetHyperlink(frame.link)
	if IsShiftKeyDown() then GameTooltip_ShowCompareItem() end
	if IsModifiedClick("DRESSUP") then ShowInspectCursor() else ResetCursor() end
end

-- 物品更新
local function ItemOnUpdate(self)
	if IsShiftKeyDown() then GameTooltip_ShowCompareItem() end
	CursorOnUpdate(self)
end

-- 物品点击
local function LootClick(frame)
	if IsControlKeyDown() then DressUpItemLink(frame.link)
	elseif IsShiftKeyDown() then ChatEdit_InsertLink(frame.link) end
end

-- 取消Roll事件
local function OnEvent(frame, event, rollid)
	cancelled_rolls[rollid] = true
	if frame.rollid ~= rollid then return end

	frame.rollid = nil
	frame.time = nil
	frame:Hide()
	
	-- 检查是否还有可见的框架
	local hasVisibleFrames = false
	for _, f in ipairs(frames) do
		if f and f:IsVisible() then
			hasVisibleFrames = true
			break
		end
	end
	
	-- 如果没有可见框架，重置所有框架的位置
	if not hasVisibleFrames then
		frames = {} -- 清空frames数组，下次将从初始位置开始
	end
end

-- 状态更新
local function StatusUpdate(frame)
	local t = GetLootRollTimeLeft(frame.parent.rollid)
	local perc = t / frame.parent.time
	frame.spark:SetPoint("CENTER", frame, "LEFT", perc * frame:GetWidth(), 0)
	frame:SetValue(t)
end

-- 创建Roll按钮
local function CreateRollButton(parent, ntex, ptex, htex, rolltype, tiptext, ...)
	local f = CreateFrame("Button", nil, parent, "BackdropTemplate")
	f:SetPoint(...)
	f:SetWidth(36)
	f:SetHeight(36)
	f:SetNormalTexture(ntex)
	if ptex then f:SetPushedTexture(ptex) end
	
	-- 移除放弃按钮的高亮纹理，其他按钮保留
	if rolltype ~= 0 then
		f:SetHighlightTexture(htex)
		f:GetHighlightTexture():SetBlendMode("ADD")
	else
		-- 为放弃按钮创建自定义高亮效果
		f.HighlightTexture = f:CreateTexture(nil, "HIGHLIGHT")
		f.HighlightTexture:SetTexture(ntex) -- 使用按钮自身纹理
		f.HighlightTexture:SetAllPoints(f)
		f.HighlightTexture:SetBlendMode("ADD")
		f.HighlightTexture:SetVertexColor(1.3, 1.3, 1.3) -- 稍微增亮
		f:SetHighlightTexture(f.HighlightTexture)
	end
	
	f.rolltype = rolltype
	f.parent = parent
	f.tiptext = tiptext
	f:SetScript("OnEnter", SetTip)
	f:SetScript("OnLeave", HideTip)
	f:SetScript("OnClick", ClickRoll)
	f:SetMotionScriptsWhileDisabled(true)
	
	-- 改进文本创建，使其更加明显
	local txt = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmallOutline")
	txt:SetPoint("CENTER", 0, rolltype == 2 and 1 or rolltype == 0 and -1.2 or 0)
	txt:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
	txt:SetShadowOffset(1, -1)
	txt:SetShadowColor(0, 0, 0, 1)
	txt:SetText("0")
	f:SetFontString(txt)
	
	return f, txt
end

-- 创建Roll框架
local function CreateRollFrame()
	local frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	frame:SetWidth(366)
	frame:SetHeight(36)
	
	-- 设置屏幕限制
	frame:SetClampedToScreen(true)
	
	frame:SetBackdrop(backdrop)
	frame:SetBackdropColor(0, 0, 0, 0) -- 完全透明
	frame:SetScript("OnEvent", OnEvent)
	frame:RegisterEvent("CANCEL_LOOT_ROLL")
	frame:Hide()

	local button = CreateFrame("Button", nil, frame, "BackdropTemplate")
	button:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
	button:SetWidth(36)
	button:SetHeight(36)
	button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2")
	-- 减弱高亮效果，使边框更加明显
	button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
	button:GetHighlightTexture():SetBlendMode("ADD")
	button:GetHighlightTexture():SetAlpha(0.3)
	button:SetScript("OnEnter", SetItemTip)
	button:SetScript("OnLeave", HideTip2)
	button:SetScript("OnUpdate", ItemOnUpdate)
	button:SetScript("OnClick", LootClick)
	CreateShadow(button)				 
	frame.button = button

	local buttonborder = CreateFrame("Frame", nil, button, "BackdropTemplate")
	buttonborder:SetWidth(38) -- 稍微大一点，让边框更明显
	buttonborder:SetHeight(38) -- 稍微大一点，让边框更明显
	buttonborder:SetPoint("CENTER", button, "CENTER")
	-- 使用有边框的背景
	buttonborder:SetBackdrop({
		bgFile = blank, 
		edgeFile = glow, 
		edgeSize = 2,
		insets = {left = 2, right = 2, top = 2, bottom = 2},
	})
	buttonborder:SetBackdropColor(0, 0, 0, 0) -- 背景透明
	buttonborder:SetBackdropBorderColor(1, 1, 1, 1) -- 默认为白色，会在设置物品时更改
	buttonborder:EnableMouse(false) -- 确保不遮挡点击
	buttonborder:SetFrameLevel(button:GetFrameLevel() - 1) -- 确保边框在图标后面
	frame.buttonborder = buttonborder

	local tfade = frame:CreateTexture(nil, "BORDER")
	tfade:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4)
	tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 4)
	tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	tfade:SetBlendMode("ADD")
	
	-- 使渐变完全透明
	tfade:SetGradient("VERTICAL", 
		CreateColor(0.1, 0.1, 0.1, 0), 
		CreateColor(0.25, 0.25, 0.25, 0)
	)

	local status = CreateFrame("StatusBar", nil, frame, "BackdropTemplate")
	status:SetWidth(326)
	status:SetHeight(12) -- 增加高度从10到12
	status:SetPoint("BOTTOMLEFT", button, "BOTTOMRIGHT", 4, 0)
	status:SetScript("OnUpdate", StatusUpdate)
	status:SetFrameLevel(status:GetFrameLevel()-1)
	status:SetStatusBarTexture("Interface\\AddOns\\teksLoot\\media\\statusbar")
	-- 使用品质色与边框颜色一致，但增加不透明度
    status:SetStatusBarColor(.8, .8, .8, 0.9) 
	status:EnableMouse(false) -- 确保不遮挡点击
	
	-- 为进度条添加边框使其更明显
	local statusBorder = CreateFrame("Frame", nil, status, "BackdropTemplate")
	statusBorder:SetPoint("TOPLEFT", status, "TOPLEFT", -1, 1)
	statusBorder:SetPoint("BOTTOMRIGHT", status, "BOTTOMRIGHT", 1, -1)
	statusBorder:SetFrameLevel(status:GetFrameLevel() - 1)
	statusBorder:SetBackdrop({
		edgeFile = blank,
		edgeSize = 1,
		insets = {left = 0, right = 0, top = 0, bottom = 0},
	})
	statusBorder:SetBackdropBorderColor(1, 1, 1, 0.4) -- 增加一点不透明度
	
	CreateShadow(status)		 
	status.parent = frame
	frame.status = status

	local spark = frame:CreateTexture(nil, "OVERLAY")
	spark:SetWidth(20) -- 增加宽度
	spark:SetHeight(32) -- 增加高度
	spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	spark:SetBlendMode("ADD")
	spark:SetVertexColor(1, 1, 1, 1) -- 保持高亮度
	status.spark = spark

	local need, needtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Dice-Up", "Interface\\Buttons\\UI-GroupLoot-Dice-Highlight", "Interface\\Buttons\\UI-GroupLoot-Dice-Down", 1, NEED, "BOTTOMLEFT", frame.status, "BOTTOMLEFT", 5, -3)
	-- 为绑定文本创建一个单独的框架，以便控制显示层级
	local bindFrame = CreateFrame("Frame", nil, button)
	bindFrame:SetFrameLevel(button:GetFrameLevel() + 5) -- 确保在按钮上层
	bindFrame:SetPoint("BOTTOM", button, "BOTTOM", 0, 4) -- 放置在图标底部中心，稍微上移更多
	bindFrame:SetWidth(36) -- 宽度适应字体
	bindFrame:SetHeight(20) -- 高度适应字体
	
	-- 不再添加半透明背景
	
	-- 在高层级框架上创建字体字符串
	local bind = bindFrame:CreateFontString(nil, "OVERLAY")
	bind:SetPoint("CENTER", bindFrame, "CENTER", 0, 0)
	bind:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE") -- 设置字体大小为14
	frame.fsbind = bind								  
	local greed, greedtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Coin-Up", "Interface\\Buttons\\UI-GroupLoot-Coin-Highlight", "Interface\\Buttons\\UI-GroupLoot-Coin-Down", 2, GREED, "LEFT", need, "RIGHT", 5, 0)
	local de, detext
	de, detext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-DE-Up", "Interface\\Buttons\\UI-GroupLoot-DE-Highlight", "Interface\\Buttons\\UI-GroupLoot-DE-Down", 3, ROLL_DISENCHANT, "LEFT", greed, "RIGHT", 0, 1)
	local pass, passtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Pass-Up", nil, "Interface\\Buttons\\UI-GroupLoot-Pass-Down", 0, PASS, "LEFT", de, "RIGHT", 175, 1.4)
	frame.needbutt, frame.greedbutt, frame.disenchantbutt, frame.passbutt = need, greed, de, pass -- 添加对pass按钮的引用
	frame.need, frame.greed, frame.pass, frame.disenchant = needtext, greedtext, passtext, detext

	-- 添加物品名称文本
	local loot = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	loot:SetFont(STANDARD_TEXT_FONT, 15, "THINOUTLINE")
	loot:SetPoint("LEFT", de, "RIGHT", 0, 0.12)
	loot:SetPoint("RIGHT", frame, "RIGHT", -5, 0)
	loot:SetHeight(10)
	loot:SetWidth(200)
	loot:SetJustifyH("LEFT")
	frame.fsloot = loot

	-- 初始化rolls表
	frame.rolls = {}

	return frame
end

-- 创建锚点
local anchor = CreateFrame("Button", nil, UIParent, "BackdropTemplate")
anchor:SetWidth(366) -- 与Roll框架相同宽度
anchor:SetHeight(36) -- 与Roll框架相同高度
anchor:SetClampedToScreen(true)

CreateShadow(anchor,"Background")

-- 添加与Roll框架相似的边框
anchor:SetBackdrop({
    bgFile = blank, tile = true, tileSize = 2,
    edgeFile = glow, edgeSize = 2,
    insets = {left = 2, right = 2, top = 2, bottom = 2},
})
anchor:SetBackdropColor(0.1, 0.1, 0.1, 0.5) -- 半透明背景
anchor:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.7) -- 与Roll框架边框颜色相似

-- 不再需要在锚点上直接创建标签，因为我们使用单独的文本框架
-- 保留一个隐藏的标签用于锚点内部结构
local label = anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
label:SetPoint("CENTER", anchor, "CENTER", 0, 0)
label:SetText("")
label:Hide()

-- 创建一个额外的文本框架，用于在锚点被覆盖时显示文本
local textFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
textFrame:SetHeight(36) -- 与锚点高度相同
textFrame:SetWidth(366) -- 与锚点宽度相同
textFrame:SetPoint("TOPLEFT", anchor, "TOPLEFT", 0, 0) -- 直接与锚点重叠
textFrame:SetFrameLevel(anchor:GetFrameLevel() + 10) -- 确保在锚点和Roll框架之上
textFrame:SetClampedToScreen(true) -- 确保文本框架也受屏幕限制

-- 创建文本标签
local textLabel = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
textLabel:SetPoint("CENTER", textFrame, "CENTER", 0, 0)
textLabel:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
textLabel:SetText("|cffff0000拖|cffff7f00动|cffffcc00调|cff00ff00整|cff0000ff位|cff4b0082置|r - |cff9400d3右|cffff0000键|cffff7f00点|cffffcc00击|cff00ff00隐|cff0000ff藏|r")
textLabel:SetJustifyH("CENTER")
textLabel:SetWidth(350)
textFrame:Hide() -- 默认隐藏

-- 确保框架在屏幕内的函数
local function EnsureFrameOnScreen()
    -- 只在插件加载时调用一次，确保初始位置有效
    local x, y = anchor:GetCenter()
    
    -- 如果位置无效，重置到默认位置
    if not x or not y then
        -- 重置到屏幕中央偏下位置
        anchor:ClearAllPoints()
        anchor:SetPoint("CENTER", UIParent, "BOTTOM", 0, 221)
        
        -- 保存新位置
        teksLootDB.x, teksLootDB.y = anchor:GetCenter()
    end
end

anchor:SetScript("OnClick", function(self, button)
    if button == "RightButton" then
        self:Hide()
        textFrame:Hide()
    end
end)

-- 确保frames始终被初始化
local frames = frames or {}

local function GetFrame()
	-- 检查是否还有可见的框架
	local hasVisibleFrames = false
	for _, f in ipairs(frames) do
		if f and f:IsVisible() then
			hasVisibleFrames = true
			break
		end
	end
	
	-- 如果没有可见框架，清空frames数组
	if not hasVisibleFrames then
		frames = {}
	end
	
	-- 先尝试重用现有框架
	for i, f in ipairs(frames) do
		if not f.rollid then 
			-- 如果是重用框架，先检查它的位置是否已经设置
			if #frames > 1 and i > 1 then
				-- 放在前一个框架上方
				f:ClearAllPoints()
				f:SetPoint("BOTTOMLEFT", frames[i-1], "TOPLEFT", 0, 5)
			else
				-- 第一个框架与锚点重叠
				f:ClearAllPoints()
				f:SetPoint("BOTTOMLEFT", anchor, "BOTTOMLEFT", 0, 0)
			end
			return f 
		end
	end

	-- 创建新框架
	local f = CreateRollFrame()
	
	-- 设置框架位置
	if #frames > 0 then
		-- 放在之前最后一个框架的上方
		f:SetPoint("BOTTOMLEFT", frames[#frames], "TOPLEFT", 0, 5)
	else
		-- 第一个框架直接与锚点重叠
		f:SetPoint("BOTTOMLEFT", anchor, "BOTTOMLEFT", 0, 0)
	end
	
	table.insert(frames, f)
	return f
end

-- 拖动设置
anchor:SetClampedToScreen(true)
anchor:SetScript("OnDragStart", anchor.StartMoving)
anchor:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	teksLootDB.x, teksLootDB.y = self:GetCenter()
end)
anchor:SetMovable(true)
anchor:EnableMouse(true)
anchor:RegisterForDrag("LeftButton")
anchor:RegisterForClicks("RightButtonUp")
anchor:Hide()

-- 开始Roll
local function START_LOOT_ROLL(rollid, time)
	if cancelled_rolls[rollid] then return end

	local f = GetFrame()
	f.rollid = rollid
	f.time = time
	f.rolls = {} -- 初始化rolls表
	
	-- 重置计数器
	f.need:SetText("0")
	f.greed:SetText("0")
	f.pass:SetText("0")
	f.disenchant:SetText("0")

	local texture, name, count, quality, bop, canNeed, canGreed, canDisenchant = GetLootRollItemInfo(rollid)
	if not name or name == "" then return end
	
	f.button:SetNormalTexture(texture)
	f.button.link = GetLootRollItemLink(rollid)

	-- 设置按钮状态
	if canNeed then GroupLootFrame_EnableLootButton(f.needbutt) else GroupLootFrame_DisableLootButton(f.needbutt) end
	if canGreed then GroupLootFrame_EnableLootButton(f.greedbutt) else GroupLootFrame_DisableLootButton(f.greedbutt) end
	if canDisenchant then GroupLootFrame_EnableLootButton(f.disenchantbutt) else GroupLootFrame_DisableLootButton(f.disenchantbutt) end

	local color = ITEM_QUALITY_COLORS[quality]
	
	-- 获取物品信息和绑定状态
	local isBoe, isBop, notBound = false, false, false
	local itemLevel = 1
	local itemId = f.button.link and f.button.link:match("item:(%d+)")
	
	if itemId and GetItemInfo then
		local _, _, _, iLevel, _, _, _, _, _, _, _, classID, subclassID = GetItemInfo(itemId)
		itemLevel = iLevel or 1
		
		-- 根据物品分类判断绑定状态
		if classID == 7 and (subclassID == 5 or subclassID == 6 or subclassID == 10) or
		   classID == 0 or classID == 1 or classID == 5 or 
		   classID == 7 or classID == 9 or classID == 16 or classID == 12 then
			notBound = true
		elseif bop then
			isBop = true
		else
			isBoe = true
		end
	else
		isBop = bop or false
		isBoe = not isBop
	end
	
	-- 设置物品绑定信息
	if isBop then
		f.fsbind:SetText(tostring(itemLevel))
		f.fsbind:SetVertexColor(color.r, color.g, color.b)
	elseif isBoe then
		f.fsbind:SetText("装绑")
		f.fsbind:SetVertexColor(0.3, 1, 0.3) -- 绿色
	elseif notBound then
		f.fsbind:SetText("不绑")
		f.fsbind:SetVertexColor(0.7, 0.7, 1) -- 淡蓝色
	end
	
	-- 设置物品名称和颜色
	f.fsloot:SetVertexColor(color.r, color.g, color.b)
	f.fsloot:SetText(name)

	-- 设置边框和进度条
	f:SetBackdropBorderColor(color.r, color.g, color.b, 0) -- 边框透明
	f.buttonborder:SetBackdropBorderColor(AdjustColor(color, 1.5)) 
	f.status:SetStatusBarColor(AdjustColor(color, 1.2, 0.9))
	f.status:SetMinMaxValues(0, time)
	f.status:SetValue(time)

	f:Show()
end

-- 修改 ParseRollChoice 函数
local function ParseRollChoice(msg)
    for pattern, rollType in pairs(ns.rollpairs) do
        local _, _, playername, itemname = string.find(msg, pattern)
        if playername and itemname and playername ~= "Everyone" then 
            -- 清理玩家名称
            playername = CleanPlayerName(playername)
            return playername, itemname, rollType 
        end
    end
    return nil, nil, nil
end

-- 修改 CHAT_MSG_LOOT 函数
local in_soviet_russia = (GetLocale() == "ruRU")
local function CHAT_MSG_LOOT(msg)
    local playername, itemname, rolltype = ParseRollChoice(msg)
    if not (playername and itemname and rolltype) then return end
    
    if in_soviet_russia and rolltype ~= "pass" then 
        itemname, playername = playername, itemname 
    end
    
    EnsureClassColors()
    
    for _, f in ipairs(frames) do
        if f and f.rollid and f.button and f.button.link and not f.rolls[playername] then
            -- 检查是否是正确的物品
            if string.find(f.button.link, itemname, 1, true) or 
               string.find(itemname, f.button.link, 1, true) then
                
                -- 记录玩家选择并更新计数
                f.rolls[playername] = rolltype
                local count = tonumber(f[rolltype]:GetText()) or 0
                f[rolltype]:SetText(count + 1)
                
                -- 更新提示（如果鼠标悬停在相应按钮上）
                if (f.needbutt and f.needbutt:IsMouseOver() and rolltype == "need") or
                   (f.greedbutt and f.greedbutt:IsMouseOver() and rolltype == "greed") or
                   (f.disenchantbutt and f.disenchantbutt:IsMouseOver() and rolltype == "disenchant") or
                   (f.passbutt and f.passbutt:IsMouseOver() and rolltype == "pass") then
                    SetTip(f[rolltype == "need" and "needbutt" or 
                            rolltype == "greed" and "greedbutt" or
                            rolltype == "disenchant" and "disenchantbutt" or "passbutt"])
                end
                return
            end
        end
    end
end

-- 隐藏暴雪自带Roll框的函数
local function HideBlizzardRollFrames()
    for i = 1, NUM_GROUP_LOOT_FRAMES or 4 do
        local f = _G["GroupLootFrame"..i]
        if f then
            f:UnregisterAllEvents()
            f:Hide()
            f.Show = function() end
        end
    end
end

-- 初始隐藏
HideBlizzardRollFrames()

-- 注册事件和命令
anchor:RegisterEvent("ADDON_LOADED")
anchor:SetScript("OnEvent", function(frame, event, ...)
	local arg1, arg2 = ...

	if event == "ADDON_LOADED" then
		if arg1 ~= "teksLoot" then return end
		
		frame:UnregisterEvent("ADDON_LOADED")
		frame:RegisterEvent("START_LOOT_ROLL")
		frame:RegisterEvent("CHAT_MSG_LOOT")
		
		HideBlizzardRollFrames()
		frame.db = teksLootDB
		
		-- 设置位置
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", UIParent, teksLootDB.x and "BOTTOMLEFT" or "BOTTOM", teksLootDB.x or 0, teksLootDB.y or 221)
		EnsureFrameOnScreen()
		
		frame:Hide()
		print("|cff00ff00teksLoot|r 已加载")
	elseif event == "START_LOOT_ROLL" then
		START_LOOT_ROLL(arg1, arg2)
	elseif event == "CHAT_MSG_LOOT" then
		CHAT_MSG_LOOT(arg1)
    end
end)

-- Slash命令
SLASH_TEKSLOOT1 = "/teksloot"
SLASH_TEKSLOOT2 = "/teks"

-- Slash命令处理函数
SlashCmdList["TEKSLOOT"] = function()
    if anchor:IsVisible() then 
        anchor:Hide()
        textFrame:Hide()
    else 
        anchor:Show()
        textFrame:Show()
    end
end