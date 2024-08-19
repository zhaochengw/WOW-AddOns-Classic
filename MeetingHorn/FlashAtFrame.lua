-- FlashAtFrame.lua
-- @Date   : 07/09/2024, 3:43:12 PM
--
-- @Description :
local ns = select(2, ...)

-- 创建闪烁提醒框架
function ns.CreateFlashFrame()
    self = CreateFrame("Frame", nil, UIParent)
    self:SetSize(100, 30)  -- 默认大小，可以根据需要调整
    self:SetPoint("CENTER")  -- 默认位置，可以根据需要调整
    self:SetFrameStrata("TOOLTIP")
    self:SetFrameLevel(999)
    self:Hide()  -- 初始化时隐藏

    self.isShow = false

    -- 创建背景纹理
    local texture = self:CreateTexture(nil, "BACKGROUND")
    texture:SetTexture("INTERFACE/CHATFRAME/ChatFrameTab-NewMessage")
    texture:SetAllPoints()
    texture:SetVertexColor(1, 0.89, 0.18)  -- 设置颜色

    -- 创建动画组
    local animGroup = self:CreateAnimationGroup()
    animGroup:SetLooping("BOUNCE")

    -- 创建Alpha动画
    local alphaAnim = animGroup:CreateAnimation("Alpha")
    alphaAnim:SetFromAlpha(0.6)
    alphaAnim:SetToAlpha(0)
    alphaAnim:SetDuration(0.7)

    -- 添加OnShow和OnHide脚本
    self:SetScript("OnShow", function(self)
        animGroup:Play()
    end)
    self:SetScript("OnHide", function(self)
        animGroup:Stop()
    end)

    -- 添加OnShow和OnHide脚本
    self:SetScript("OnShow", function(self)
        animGroup:Play()
    end)
    self:SetScript("OnHide", function(self)
        animGroup:Stop()
    end)
    return self
end


function ns.BindFlashAtFrame(self, frameCement)
    -- 检查 announcement 是否为有效的框架对象
    if not frameCement or type(frameCement.GetNumPoints) ~= "function" then
        return
    end

    -- 检查是否有锚点设置，如果没有设置，使用默认锚点
    local hasPoint = frameCement:GetNumPoints() > 0

    if not hasPoint then
        -- 设置一个默认锚点
        frameCement:SetPoint("CENTER", UIParent, "CENTER")
    end

    -- 获取 Announcement 框架的位置和大小
    local point, relativeTo, relativePoint, offsetX, offsetY = frameCement:GetPoint(1)

    -- 将闪烁提醒框架移动到 Announcement 框架的中心位置，并调整偏移量
    self:ClearAllPoints()
    self:SetPoint(point, relativeTo, relativePoint, offsetX + 14, offsetY + 4)  -- 根据需要调整偏移量
    self:SetSize(frameCement:GetWidth() - 28, frameCement:GetHeight() - 10)

    -- 显示闪烁提醒框架
    ns.ShowAtFrameFlash(self)

    -- 监听按钮的显示和隐藏事件
    frameCement:HookScript("OnShow", function()
        if self.isShow then
            ns.ShowAtFrameFlash(self)
        end
    end)
    frameCement:HookScript("OnHide", function()
        ns.HideAtFrameFlash(self)
    end)
end

function ns.ShowAtFrameFlash(self)
    self.isShow = true
    self:Show()
end

-- 示例：在某个按键位置隐藏闪烁提醒
function ns.HideAtFrameFlash(self)
    self.isShow = false
    self:Hide()
end
