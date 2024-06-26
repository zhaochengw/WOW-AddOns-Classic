local addonName, addonTable = ...

-- 默认语言文本
local L = {
    ["LOCK_CAST_BAR"] = "Lock Cast Bar",
    ["CENTER"] = "Center",
    ["RESET"] = "Reset",
}

-- 根据客户端语言调整文本
local locale = GetLocale()
if locale == "zhCN" or locale == "zhTW" then
    L["LOCK_CAST_BAR"] = "锁定施法条"
    L["CENTER"] = "居中"
    L["RESET"] = "重置"
end

-- Default values
local isLocked = true

-- Create a frame for dragging
local draggableFrame = CreateFrame("Frame", "MovableCastBarFrame", UIParent)
draggableFrame:SetSize(200, 20)  -- Adjust the size as necessary
draggableFrame:SetPoint("CENTER")
draggableFrame:EnableMouse(true)
draggableFrame:SetMovable(true)
draggableFrame:RegisterForDrag("LeftButton")
draggableFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
draggableFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    -- Save position
    local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
    MovableCastBarPosition = {point, relativePoint, xOfs, yOfs}
end)

-- Create a background for better visibility (optional)
draggableFrame.bg = draggableFrame:CreateTexture(nil, "BACKGROUND")
draggableFrame.bg:SetAllPoints(true)
draggableFrame.bg:SetColorTexture(0, 0, 0, 0.5)  -- Semi-transparent black

-- Function to properly attach the CastBarFrame to the draggableFrame
local function AttachCastBarFrame()
    CastingBarFrame:SetParent(draggableFrame)
    CastingBarFrame:ClearAllPoints()
    CastingBarFrame:SetPoint("CENTER", draggableFrame, "CENTER")
end

-- Delayed attachment function using OnUpdate to ensure UI elements are fully loaded
local function DelayedAttachCastBarFrame()
    local frame = CreateFrame("Frame")
    frame:SetScript("OnUpdate", function(self, elapsed)
        if self.timer == nil then self.timer = 0 end
        self.timer = self.timer + elapsed
        if self.timer > 1 then
            AttachCastBarFrame()
            self:SetScript("OnUpdate", nil)
        end
    end)
end

-- Center the cast bar on the screen
local function CenterCastBar(horizontalOnly)
    local yOfs = 0
    if horizontalOnly then
        local top = draggableFrame:GetTop()
        local screenHeight = UIParent:GetHeight()
        yOfs = top - screenHeight / 2 - (draggableFrame:GetHeight() / 2)
    end
    draggableFrame:ClearAllPoints()
    draggableFrame:SetPoint("CENTER", UIParent, "CENTER", 0, yOfs)
    MovableCastBarPosition = {"CENTER", "CENTER", 0, yOfs}
    AttachCastBarFrame()
    print("Cast bar centered at screen center.")
end

-- Reset the cast bar to default settings
local function ResetCastBar()
    -- Reset position
    CenterCastBar(false)
    -- Reset lock state
    draggableFrame:EnableMouse(true)
    draggableFrame.bg:Show()
    isLocked = false
    MovableCastBarLocked = false
    print("Cast bar reset to default settings.")
end

-- Restore saved position on login/reload
draggableFrame:RegisterEvent("PLAYER_LOGIN")
draggableFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        if MovableCastBarPosition then
            local point, relativePoint, xOfs, yOfs = unpack(MovableCastBarPosition)
            self:SetPoint(point, UIParent, relativePoint, xOfs, yOfs)
        else
            CenterCastBar(false)  -- Center the cast bar if no saved position is found
        end
        DelayedAttachCastBarFrame()  -- Ensure CastBarFrame is attached after positioning with a delay
        if MovableCastBarLocked ~= nil then
            isLocked = MovableCastBarLocked
            if isLocked then
                draggableFrame:EnableMouse(false)
                draggableFrame.bg:Hide()
            else
                draggableFrame:EnableMouse(true)
                draggableFrame.bg:Show()
            end
        end
    end
end)

-- Slash command handler
local function SlashCmdHandler(msg, editBox)
    local command = strlower(msg)
    if command == "lock" then
        draggableFrame:EnableMouse(false)
        draggableFrame.bg:Hide()
        isLocked = true
        MovableCastBarLocked = true
        print("Cast bar position locked.")
    elseif command == "unlock" then
        draggableFrame:EnableMouse(true)
        draggableFrame.bg:Show()
        isLocked = false
        MovableCastBarLocked = false
        print("Cast bar position unlocked.")
    elseif command == "center" then
        CenterCastBar(true)
    elseif command == "reset" then
        ResetCastBar()
    else
        print("Usage: /castbar lock | unlock | center | reset")
    end
end

-- Register the slash command
SLASH_MOVABLECASTBAR1 = "/castbar"
SlashCmdList["MOVABLECASTBAR"] = SlashCmdHandler

--[[
    系统施法条美化
    摘自 https://bbs.nga.cn/read.php?tid=14573258  powered by 简繁
    提供两种样式
    基于原始的 将第一行改为 `local bOriginal=true` 需要新样式 将第一行改为 `local bOriginal=false`
]]

local bOriginal = true    -- 是否更接近原始施法条

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(self, event, ...)
    if type( self[event] ) == "function" then return self[ event ] ( self, ... ) end
end )

function frame:ADDON_LOADED()

local function CreateFontString(self)
    local parent = self:GetParent()
    if self:IsForbidden() then return end
        self.CooldownText = self:CreateFontString(nil)
        self.CooldownText:SetFont(SystemFont_Outline_Small:GetFont(), 14, "OUTLINE")	--施法时间文字大小
        self.CooldownText:SetWidth(100)
        self.CooldownText:SetJustifyH("RIGHT")
        self.CooldownText:SetPoint("TOP", self, "RIGHT", 10, 8)				        --施法条时间位置
    if parent.unit == 'target' or parent.unit == 'focus' then		                    --目标和焦点时间位置
        self.CooldownText:SetPoint("TOP", self, "RIGHT", 10, 8)				        --施法条时间位置
    end
        local fontFile, fontSize, fontFlags = self.Text:GetFont() 
        self.Text:SetFont(fontFile, fontSize- -2, fontFlags)				            --施法条法术名称大小
end

-- 自身施法条修改
if not bOriginal then
    CastingBarFrame:SetHeight(20)			                                    --施法条高度
    CastingBarFrame:SetWidth(300)			                                    --施法条宽度
    CastingBarFrame.Spark:SetHeight(60)		                                    --施法条闪光高度
    CastingBarFrame.Border:SetTexture(nil)                                      --关闭原始施法条边框

else
    CastingBarFrame.Icon:SetPoint( "RIGHT", CastingBarFrame, "LEFT", -10, 3) --施法图标位置    
end

CastingBarFrame.Flash:SetTexture(nil)
CastingBarFrame:SetFrameStrata("HIGH")	                                    --施法条框架优先级
CastingBarFrame.Icon:SetSize(25,25)		                                    --施法条图标大小
CastingBarFrame.Icon:Show()				                                    --施法条图标显示


local function ShowCastingTimer(self, elapsed)
if self:IsForbidden() then return end
if self:GetParent():GetName():find("NamePlate%d") then return end
    if (not self.CooldownText) then
        CreateFontString(self)
        self.timer = 0
       if (self:GetName() == "CastingBarFrame") then
 --         self.Border:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small")
 --         self.Flash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small")
 --         self.Border:SetPoint("TOP", 0, 26)						                        --施法条外框体位置
            if not bOriginal then self.Text:SetPoint("TOP", 0, -1) end						--施法条法术名称位置
--          self.Icon:Show()
       end
    end
    self.timer = self.timer + elapsed
    if (self.timer > 0.1) then
        self.timer = 0
        if self.casting then
            self.CooldownText:SetText(format("%.1f/%.1f", max(self.value, 0), self.maxValue))
        elseif self.channeling then
            self.CooldownText:SetText(format("%.1f", max(self.value, 0)))
        else
            self.CooldownText:SetText("")
        end
    end
end

hooksecurefunc("CastingBarFrame_OnUpdate", ShowCastingTimer)

hooksecurefunc("CastingBarFrame_OnEvent", function(self, event, ...)
if self:IsForbidden() then return end
    if (not self.hasRegisterCastingTimer) then
        self.hasRegisterCastingTimer = true
        local func = self:GetScript("OnUpdate")
        if (func ~= CastingBarFrame_OnUpdate) then
            self:SetScript("OnUpdate", CastingBarFrame_OnUpdate)
        end
    end
end)

if (CastingBarFrame) then
    CastingBarFrame:HookScript("OnUpdate", ShowCastingTimer)
end

hooksecurefunc("MirrorTimerFrame_OnUpdate", function(self, elapsed)
if (self.paused) then return end
    if (not self.CooldownText) then
        self.CooldownText = self:CreateFontString(nil)
        self.CooldownText:SetFont(SystemFont_Outline_Small:GetFont(), 8, "OUTLINE")
        self.CooldownText:SetWidth(100)
        self.CooldownText:SetJustifyH("RIGHT")
        self.CooldownText:SetPoint("RIGHT", self, "RIGHT", -100, 6)
        self.itimer = 0
    end
    self.itimer = self.itimer + elapsed
    if (self.itimer > 0.5) then
        self.itimer = 0
        self.CooldownText:SetText(floor(self.value))
    end
end)

--施法延迟
-- local lagmeter = CastingBarFrame:CreateTexture(nil,"OVERLAYER"); 
-- lagmeter:SetHeight(CastingBarFrame:GetHeight()); 
-- lagmeter:SetWidth(0); 
-- lagmeter:SetPoint("RIGHT", CastingBarFrame, "RIGHT", 0, 0); 
-- lagmeter:SetTexture("Interface\\ChatFrame\\ChatFrameBackground"); 
-- lagmeter:SetVertexColor(1,0.3,0); -- red color 

-- hooksecurefunc(CastingBarFrame, "Show", function() 
--    down, up, lag = GetNetStats(); 
--    local castingmin, castingmax = CastingBarFrame:GetMinMaxValues(); 
--    local lagvalue = ( lag / 1000 ) / ( castingmax - castingmin ); 
   
--    if ( lagvalue < 0 ) then 
--       lagvalue = 0; 
--    elseif ( lagvalue > 1 ) then 
--       lagvalue = 1; 
--    end; 
   
--    lagmeter:SetWidth(CastingBarFrame:GetWidth() * lagvalue); 
-- end);

end


local panel = CreateFrame("Frame")
panel.name = "MovableCastBar"

local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("Movable and Enhanced Cast Bar")

-- 创建锁定/解锁复选框
local lockCheckbox = CreateFrame("CheckButton", "MovableCastBarLockCheckbox", panel, "UICheckButtonTemplate")
lockCheckbox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 10, -20)  -- 调整位置，避免与标题重叠
getglobal(lockCheckbox:GetName() .. "Text"):SetText(L["LOCK_CAST_BAR"])  -- 使用本地化字符串
lockCheckbox:SetScript("OnClick", function(self)
    isLocked = self:GetChecked()
    if isLocked then
        SlashCmdHandler("lock")
    else
        SlashCmdHandler("unlock")
    end
end)

-- 插件加载时，根据 isLocked 变量设置复选框状态
lockCheckbox:SetChecked(isLocked)

-- 创建居中按钮
local centerButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
centerButton:SetPoint("TOPLEFT", lockCheckbox, "BOTTOMLEFT", 0, -10)  -- 放置在复选框下方并左对齐
centerButton:SetText(L["CENTER"])  -- 使用本地化字符串
centerButton:SetSize(80, 22)  -- 调整按钮大小适应文本长度

centerButton:SetScript("OnClick", function()
    SlashCmdHandler("center")
end)

-- 创建重置按钮
local resetButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
resetButton:SetPoint("LEFT", centerButton, "RIGHT", 10, 0)  -- 与居中按钮保持一定间隔
resetButton:SetText(L["RESET"])  -- 使用本地化字符串
resetButton:SetSize(80, 22)  -- 调整按钮大小适应文本长度

resetButton:SetScript("OnClick", function()
    SlashCmdHandler("reset")
end)

-- 注册插件加载事件，用于重新设置复选框状态
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
    if addon == addonName then
        -- 插件加载后，根据 isLocked 变量设置复选框状态
        lockCheckbox:SetChecked(isLocked)
    end
end)

InterfaceOptions_AddCategory(panel)
