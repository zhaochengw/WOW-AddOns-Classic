---  黑色泥土检测功能
local BlackDirtDetector = CreateFrame("Frame", nil, UIParent)
BlackDirtDetector:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
BlackDirtDetector:RegisterEvent("PLAYER_ENTERING_WORLD")

-- 红色方块光柱池
local redBeamPool = {}

-- 检测冷却时间（避免频繁检测）
local detectionCooldown = 0

-- 初始化
function BlackDirtDetector:PLAYER_ENTERING_WORLD()
    -- 开始周期性检测
    self:StartDetection()
    print("|cFF00FF00黑色泥土检测器已启用|r")
end

-- 开始周期性检测
function BlackDirtDetector:StartDetection()
    if self.detectionTimer then return end
    if C_Timer and C_Timer.NewTicker then
        self.detectionTimer = C_Timer.NewTicker(0.1, function()
            self:DetectBlackDirt()
        end)
    else
        -- Fallback for MOP 5.5.3 classic: use frame OnUpdate
        local f = CreateFrame("Frame")
        f.elapsed = 0
        f:SetScript("OnUpdate", function(_, elapsed)
            f.elapsed = f.elapsed + elapsed
            if f.elapsed >= 0.1 then
                f.elapsed = 0
                BlackDirtDetector:DetectBlackDirt()
            end
        end)
        self.detectionTimer = f
    end
end

-- 检测黑色泥土
function BlackDirtDetector:DetectBlackDirt()
    -- 检查冷却时间
    if GetTime() < detectionCooldown then return end
    
    -- 获取鼠标悬停信息
    local name = nil
    if GameTooltip and GameTooltip:IsShown() then
        name = GameTooltipTextLeft1:GetText()
    end
    if name and name == "黑色泥土" or name and name == "玛瑙翔龙蛋" then
        -- 设置冷却时间（1秒）
        detectionCooldown = GetTime() + 1
        
        -- 在鼠标位置显示红色光柱
        self:ShowRedBeam()
        
        -- 系统黄字提醒
        print("|cFFFFFF00发现黑色泥土！|r")
    end
end

-- 显示红色光柱
function BlackDirtDetector:ShowRedBeam()
    -- 获取当前鼠标位置
    local mouseX, mouseY = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    local x = mouseX / scale
    local y = mouseY / scale
    
    -- 从池中获取或创建新的红色光柱
    local beam = table.remove(redBeamPool)
    if not beam then
        beam = CreateFrame("Frame", nil, UIParent)
        -- 在经典服中使用Texture来创建背景效果
        local texture = beam:CreateTexture(nil, "BACKGROUND")
        texture:SetAllPoints(beam)
        texture:SetColorTexture(1, 0, 0, 0.7) -- 红色半透明
        beam.texture = texture
        beam:SetSize(40, 40) -- 方块大小
        
        -- 创建光柱效果（垂直延伸）
        local beamExtend = CreateFrame("Frame", nil, UIParent)
        local textureExtend = beamExtend:CreateTexture(nil, "BACKGROUND")
        textureExtend:SetAllPoints(beamExtend)
        textureExtend:SetColorTexture(1, 0, 0, 0.3) -- 红色更透明
        beamExtend.texture = textureExtend
        beamExtend:SetSize(40, 200) -- 光柱大小
        beam.extended = beamExtend
    end
    
    -- 设置方块位置
    beam:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y)
    beam:Show()
    
    -- 设置光柱位置（在方块上方延伸）
    beam.extended:SetPoint("BOTTOM", beam, "TOP")
    beam.extended:Show()
    
    -- 3秒后隐藏光柱
    if C_Timer and C_Timer.After then
        C_Timer.After(3, function()
            beam:Hide()
            beam.extended:Hide()
            table.insert(redBeamPool, beam) -- 放回池中
        end)
    else
        -- Fallback for MOP 5.5.3 classic
        local hideFrame = CreateFrame("Frame")
        hideFrame.elapsed = 0
        hideFrame.beam = beam
        hideFrame:SetScript("OnUpdate", function(self, elapsed)
            self.elapsed = self.elapsed + elapsed
            if self.elapsed >= 3 then
                self.beam:Hide()
                self.beam.extended:Hide()
                table.insert(redBeamPool, self.beam)
                self:SetScript("OnUpdate", nil)
            end
        end)
    end
end

-- 导出检测器（可选）
_G.BlackDirtDetector = BlackDirtDetector
