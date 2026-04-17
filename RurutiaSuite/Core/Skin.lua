-- ========================================
-- Core/Skin.lua
-- RurutiaSuite 轻量级皮肤引擎 (Skin Engine)
-- ========================================
-- 设计目标：
-- 1. 实现现代化的"黑色半透明扁平风格"
-- 2. 摆脱原生的复古外观
-- 3. 如果检测到 NDui 或 ElvUI，自动停用（避免冲突）
-- ========================================

local addonName, ns = ...
local IsAddOnLoaded = C_AddOns and C_AddOns.IsAddOnLoaded or IsAddOnLoaded

-- ========================================
-- 冲突检测：如果用户加载了 NDui 或 ElvUI，停用皮肤引擎
-- ========================================

if IsAddOnLoaded("NDui") or IsAddOnLoaded("ElvUI") then
    -- 用户已使用综合插件，交给它们处理美化
    return
end

-- ========================================
-- 获取 RurutiaSuite 插件对象（从命名空间）
-- ========================================

local RS = ns.RS

-- 安全检查：确保 RS 对象已初始化
if not RS then
    error("[RS Skin] 严重错误：RS 对象未初始化！请检查 TOC 加载顺序，确保 Init.lua 在 Skin.lua 之前加载。")
    return
end

local CFG = ns.Config.theme

-- ========================================
-- 主题兼容/兜底：避免把 nil 传给 SetBackdrop*Color
-- ========================================

local function NormalizeThemeColor(color, fallbackR, fallbackG, fallbackB, fallbackA)
    if type(color) == "table" then
        if type(color.GetRGBA) == "function" then
            local r, g, b, a = color:GetRGBA()
            if r ~= nil and g ~= nil and b ~= nil then
                return r, g, b, a
            end
        end
        local r = color.r ~= nil and color.r or color[1]
        local g = color.g ~= nil and color.g or color[2]
        local b = color.b ~= nil and color.b or color[3]
        local a = color.a ~= nil and color.a or color[4]
        if r ~= nil and g ~= nil and b ~= nil then
            return r, g, b, a
        end
    end
    return fallbackR, fallbackG, fallbackB, fallbackA
end

local function GetThemeBorderInfo()
    local border = (CFG and CFG.border) or {}
    local edgeSize = border.edgeSize or border.size or 1

    local color = border.color or border
    local r, g, b, a = NormalizeThemeColor(color, 0, 0, 0, 1)
    if a == nil then a = 1 end
    return edgeSize, r, g, b, a
end

local function GetThemeBackgroundColor()
    local bg = (CFG and CFG.background) or {}
    local r, g, b, a = NormalizeThemeColor(bg, 0, 0, 0, 0.8)
    if a == nil then a = 0.8 end
    return r, g, b, a
end

local function GetThemeButtonColors()
    local btn = (CFG and CFG.button) or nil
    if type(btn) == "table"
        and type(btn.normal) == "table"
        and type(btn.hover) == "table"
        and type(btn.pushed) == "table" then
        return btn
    end
    return {
        normal = { r = 0.12, g = 0.12, b = 0.12, a = 0.8 },
        hover  = { r = 0.18, g = 0.18, b = 0.18, a = 0.9 },
        pushed = { r = 0.10, g = 0.10, b = 0.10, a = 0.9 },
    }
end

-- ========================================
-- 核心函数：剥离原生材质
-- ========================================

local function StripTextures(frame)
    if not frame then return end
    
    -- ========================================
    -- 方法1：隐藏所有子纹理（背景、边框）
    -- ========================================
    for i = 1, frame:GetNumRegions() do
        local region = select(i, frame:GetRegions())
        if region and region:IsObjectType("Texture") then
            local texture = region:GetTexture()
            -- 关键修改：增加 type(texture) == "string" 判断
            -- GetTexture() 可能返回 FileID (Number) 或 Path (String)
            if texture and type(texture) == "string" and (
                texture:find("UI%-Panel") or 
                texture:find("UI%-DialogBox") or
                texture:find("UI%-Background") or
                texture:find("UI%-Button")  -- ✅ 新增：清理按钮纹理
            ) then
                region:Hide()
                region:SetTexture(nil)  -- ✅ 彻底清空纹理
            end
        end
    end
    
    -- ========================================
    -- 方法2：特殊处理 AceGUI 按钮和 UIPanelButtonTemplate
    -- ========================================
    -- AceGUI Button 特有属性
    if frame.Left then frame.Left:Hide() end
    if frame.Middle then frame.Middle:Hide() end
    if frame.Right then frame.Right:Hide() end
    
    -- UIPanelButtonTemplate 特有属性（红色高光的来源）
    if frame.LeftDisabled then frame.LeftDisabled:Hide() end
    if frame.MiddleDisabled then frame.MiddleDisabled:Hide() end
    if frame.RightDisabled then frame.RightDisabled:Hide() end
end

-- ========================================
-- 核心函数：创建扁平化背景
-- ========================================

local function CreateBackdrop(frame)
    if not frame then return end
    
    local edgeSize, br, bg, bb, ba = GetThemeBorderInfo()
    local r, g, b, a = GetThemeBackgroundColor()

    -- 设置 Backdrop
    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = false,
        edgeSize = edgeSize,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    
    -- 应用颜色
    frame:SetBackdropColor(r, g, b, a)
    frame:SetBackdropBorderColor(br, bg, bb, ba)
end

-- ========================================
-- 核心函数：美化框体
-- ========================================

function RS:SkinFrame(frame)
    if not frame then return end
    
    -- 确保框体支持 Backdrop
    if not frame.SetBackdrop then
        Mixin(frame, BackdropTemplateMixin)
    end
    
    -- 剥离原生材质
    StripTextures(frame)
    
    -- 创建扁平化背景
    CreateBackdrop(frame)
    
    -- ========================================
    -- 隐藏 AceGUI Frame 的原生标题栏材质
    -- ========================================
    
    -- 方法1：隐藏 frame 的子纹理（常规方法）
    if frame.TopTileStreaks then frame.TopTileStreaks:Hide() end
    if frame.TopLeftCorner then frame.TopLeftCorner:Hide() end
    if frame.TopRightCorner then frame.TopRightCorner:Hide() end
    if frame.BottomLeftCorner then frame.BottomLeftCorner:Hide() end
    if frame.BottomRightCorner then frame.BottomRightCorner:Hide() end
    if frame.TopEdge then frame.TopEdge:Hide() end
    if frame.BottomEdge then frame.BottomEdge:Hide() end
    if frame.LeftEdge then frame.LeftEdge:Hide() end
    if frame.RightEdge then frame.RightEdge:Hide() end
    if frame.TopBorder then frame.TopBorder:Hide() end
    if frame.BotBorder then frame.BotBorder:Hide() end
    
    -- 方法2：通过全局名称隐藏 DialogBoxTemplate 纹理（如果 frame 有名称）
    local name = frame:GetName()
    if name then
        local pieces = {
            "TitleBG", "TopLeftCorner", "TopRightCorner", "TopBorder",
            "BotLeftCorner", "BotRightCorner", "BotBorder",
            "LeftBorder", "RightBorder"
        }
        
        for _, piece in ipairs(pieces) do
            local tex = _G[name .. piece]
            if tex then
                if tex.SetTexture then tex:SetTexture("") end
                if tex.Hide then tex:Hide() end
                if tex.SetAlpha then tex:SetAlpha(0) end
            end
        end
    end
    
    -- 方法3：强制遍历所有子 Region，只隐藏标题栏纹理
    -- 关键：保留背景纹理，只隐藏标题栏装饰纹理
    for i = 1, frame:GetNumRegions() do
        local region = select(i, frame:GetRegions())
        if region and region:GetObjectType() == "Texture" then
            local texture = region:GetTexture()
            if texture then
                local texType = type(texture)
                
                if texType == "string" then
                    -- String 类型：纹理路径，检查是否是标题栏相关
                    if texture:find("UI%-DialogBox") or 
                       texture:find("UI%-Panel") or 
                       texture:find("Border") or 
                       texture:find("Corner") or
                       texture:find("Edge") or
                       texture:find("Title") then
                        region:SetTexture("")
                        region:Hide()
                        region:SetAlpha(0)
                    end
                    -- 注意：不隐藏 UI-Tooltip-Background（这是我们设置的背景）
                elseif texType == "number" then
                    -- Number 类型：FileID
                    -- 130871 和 130870 是标题栏纹理
                    -- 但需要排除背景纹理（通常 DrawLayer 是 BACKGROUND）
                    local drawLayer = region:GetDrawLayer()
                    
                    -- 只隐藏 BORDER 和 ARTWORK 层的纹理（标题栏装饰）
                    -- 保留 BACKGROUND 层的纹理（窗口背景）
                    if drawLayer ~= "BACKGROUND" then
                        region:SetTexture("")
                        region:Hide()
                        region:SetAlpha(0)
                    end
                end
            end
        end
    end
end

-- ========================================
-- 核心函数：美化按钮
-- ========================================

function RS:SkinButton(button)
    if not button then return end
    
    -- ========================================
    -- 防止重复处理（关键修复）
    -- ========================================
    if button._RS_Skinned then return end
    button._RS_Skinned = true
    
    -- 确保按钮支持 Backdrop
    if not button.SetBackdrop then
        Mixin(button, BackdropTemplateMixin)
    end
    
    -- ========================================
    -- 关键修复1：彻底清除 UIPanelButtonTemplate 的高光纹理（红色）
    -- ========================================
    -- UIPanelButtonTemplate 会自动添加高光纹理，必须手动清空
    -- 注意：WLK 3.4.5 不支持传入 nil，必须手动获取纹理对象并隐藏
    
    -- 获取并隐藏高光纹理（红色高光的来源）
    local highlight = button:GetHighlightTexture()
    if highlight then
        highlight:SetTexture("")  -- 清空纹理路径
        highlight:SetAlpha(0)     -- 强制透明
        highlight:Hide()          -- 隐藏
    end
    
    -- 获取并隐藏按下纹理
    local pushed = button:GetPushedTexture()
    if pushed then
        pushed:SetTexture("")
        pushed:SetAlpha(0)
        pushed:Hide()
    end
    
    -- 获取并隐藏正常纹理
    local normal = button:GetNormalTexture()
    if normal then
        normal:SetTexture("")
        normal:SetAlpha(0)
        normal:Hide()
    end
    
    -- 获取并隐藏禁用纹理
    local disabled = button:GetDisabledTexture()
    if disabled then
        disabled:SetTexture("")
        disabled:SetAlpha(0)
        disabled:Hide()
    end
    
    -- 剥离原生材质
    StripTextures(button)
    
    -- 创建扁平化背景
    local edgeSize, br, bg, bb, ba = GetThemeBorderInfo()
    local btnColors = GetThemeButtonColors()
    button:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = false,
        edgeSize = edgeSize,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    
    -- 应用正常状态颜色
    local normal = btnColors.normal
    button:SetBackdropColor(normal.r, normal.g, normal.b, normal.a)
    button:SetBackdropBorderColor(br, bg, bb, ba)
    
    -- ========================================
    -- 关键修复2：增大按钮文本字号（+2）
    -- ========================================
    -- AceGUI Button 的文本在 button:GetFontString() 中
    local fontString = button:GetFontString()
    if fontString then
        local fontPath, fontSize, fontFlags = fontString:GetFont()
        if fontPath and fontSize then
            fontString:SetFont(fontPath, fontSize + 2, fontFlags)  -- 字号 +2
        end
    end
    
    -- ========================================
    -- 交互反馈：悬停、按下效果
    -- ========================================
    
    -- 保存原始颜色
    button._skinNormalColor = normal
    button._skinHoverColor = btnColors.hover
    button._skinPushedColor = btnColors.pushed
    
    -- OnEnter: 悬停变色
    button:HookScript("OnEnter", function(self)
        local hover = self._skinHoverColor
        self:SetBackdropColor(hover.r, hover.g, hover.b, hover.a)  -- 修复：hover.h -> hover.b
        
        -- 边框变色（职业色）
        local _, class = UnitClass("player")
        if class and RAID_CLASS_COLORS and RAID_CLASS_COLORS[class] then
            local color = RAID_CLASS_COLORS[class]
            self:SetBackdropBorderColor(color.r, color.g, color.b, 1)
        else
            self:SetBackdropBorderColor(1, 1, 1, 1) -- 白色
        end
    end)
    
    -- OnLeave: 恢复正常颜色
    button:HookScript("OnLeave", function(self)
        local normal = self._skinNormalColor
        self:SetBackdropColor(normal.r, normal.g, normal.b, normal.a)
        local _, br2, bg2, bb2, ba2 = GetThemeBorderInfo()
        self:SetBackdropBorderColor(br2, bg2, bb2, ba2)
    end)
    
    -- OnMouseDown: 按下变色
    button:HookScript("OnMouseDown", function(self)
        local pushed = self._skinPushedColor
        self:SetBackdropColor(pushed.r, pushed.g, pushed.b, pushed.a)
    end)
    
    -- OnMouseUp: 恢复悬停颜色
    button:HookScript("OnMouseUp", function(self)
        if self:IsMouseOver() then
            local hover = self._skinHoverColor
            self:SetBackdropColor(hover.r, hover.g, hover.b, hover.a)
        else
            local normal = self._skinNormalColor
            self:SetBackdropColor(normal.r, normal.g, normal.b, normal.a)
        end
    end)
end

-- ========================================
-- 核心函数：美化 TabGroup（标签页组）
-- ========================================

function RS:SkinTabGroup(tabGroup)
    if not tabGroup then return end
    
    -- ========================================
    -- 1. 美化 tabs（标签按钮）- 无需延迟！
    -- ========================================
    if tabGroup.tabs then
        for i, tab in ipairs(tabGroup.tabs) do
            if tab and not tab._RS_TabSkinned then  -- 防止重复处理
                tab._RS_TabSkinned = true  -- 标记已处理
                
                -- 遍历标签按钮的所有纹理和文本
                for j = 1, tab:GetNumRegions() do
                    local region = select(j, tab:GetRegions())
                    if region and region:GetObjectType() == "Texture" then
                        -- 设置为透明黑色
                        region:SetTexture("Interface\\Buttons\\WHITE8X8")
                        region:SetVertexColor(0, 0, 0, 0)
                    elseif region and region:GetObjectType() == "FontString" then
                        -- 统一设置Tab文本字号
                        local fontPath, _, fontFlags = region:GetFont()
                        if fontPath then
                            region:SetFont(fontPath, 14, fontFlags)
                        end
                    end
                end
                
                -- 尝试直接获取文本对象（AceGUI 可能用其他方式存储）
                if tab.text and tab.text.GetFont then
                    local fontPath, _, fontFlags = tab.text:GetFont()
                    if fontPath then
                        tab.text:SetFont(fontPath, 14, fontFlags)
                    end
                end
                
                -- 美化高光纹理（关键！）
                local highlight = tab:GetHighlightTexture()
                if highlight then
                    highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
                    highlight:SetVertexColor(0, 0, 0, 0)
                end
            end
        end
    end
    
    -- ========================================
    -- 2. 美化 border（容器边框）- 无延迟！
    -- ========================================
    if tabGroup.border then
        for i = 1, tabGroup.border:GetNumRegions() do
            local region = select(i, tabGroup.border:GetRegions())
            if region and region:GetObjectType() == "Texture" then
                region:SetTexture("Interface\\Buttons\\WHITE8X8")
                region:SetVertexColor(0, 0, 0, 0)
            end
        end
    end
    
    -- ========================================
    -- 3. 美化 content（内容区域）- 无延迟！
    -- ========================================
    if tabGroup.content then
        for i = 1, tabGroup.content:GetNumRegions() do
            local region = select(i, tabGroup.content:GetRegions())
            if region and region:GetObjectType() == "Texture" then
                region:SetTexture("Interface\\Buttons\\WHITE8X8")
                region:SetVertexColor(0, 0, 0, 0)
            end
        end
    end
    
    -- 美化标签按钮
    if tabGroup.tabs then
        for _, tab in pairs(tabGroup.tabs) do
            if tab and tab.SetBackdrop then
                RS:SkinButton(tab)
                
                -- [修复] 再次强制统一字号为 14 (覆盖 SkinButton 的 +2 效果)
                -- 确保所有 Tab（无论是否选中）字号一致
                if tab.GetFontString then
                    local fs = tab:GetFontString()
                    if fs then
                        local fontPath, _, fontFlags = fs:GetFont()
                        if fontPath then
                            fs:SetFont(fontPath, 14, fontFlags)
                        end
                    end
                end
                
                -- 尝试通过 text 属性设置（AceGUI 内部结构）
                if tab.text and tab.text.SetFont then
                    local fontPath, _, fontFlags = tab.text:GetFont()
                    if fontPath then
                        tab.text:SetFont(fontPath, 14, fontFlags)
                    end
                end
            end
        end
    end
end

-- ========================================
-- 核心函数：美化 InlineGroup（内嵌组）
-- ========================================

function RS:SkinInlineGroup(inlineGroup)
    if not inlineGroup or not inlineGroup.content then return end
    
    -- ========================================
    -- 最终方案：完全移除 Backdrop（包括边框）
    -- ========================================
    
    -- 确保支持 Backdrop API
    if not inlineGroup.content.SetBackdrop then
        Mixin(inlineGroup.content, BackdropTemplateMixin)
    end
    
    -- 移除 AceGUI 原生的 Backdrop（包括灰色背景和边框）
    inlineGroup.content:SetBackdrop(nil)
end

-- ========================================
-- 核心函数：美化 MultiLineEditBox（多行编辑框）
-- ========================================

function RS:SkinEditBox(editBox)
    if not editBox or not editBox.frame then return end
    
    -- 无延迟，立即执行
    -- 1. 美化 frame（外层容器）
    if editBox.frame then
        for i = 1, editBox.frame:GetNumRegions() do
            local region = select(i, editBox.frame:GetRegions())
            if region and region:GetObjectType() == "Texture" then
                region:SetTexture("Interface\\Buttons\\WHITE8X8")
                region:SetVertexColor(0, 0, 0, 0)
            end
        end
    end
    
    -- 2. 美化 scrollFrame（滚动框架）
    if editBox.scrollFrame then
        for i = 1, editBox.scrollFrame:GetNumRegions() do
            local region = select(i, editBox.scrollFrame:GetRegions())
            if region and region:GetObjectType() == "Texture" then
                region:SetTexture("Interface\\Buttons\\WHITE8X8")
                region:SetVertexColor(0, 0, 0, 0)
            end
        end
    end
    
    -- 3. 美化 button（按钮）
    if editBox.button then
        for i = 1, editBox.button:GetNumRegions() do
            local region = select(i, editBox.button:GetRegions())
            if region and region:GetObjectType() == "Texture" then
                region:SetTexture("Interface\\Buttons\\WHITE8X8")
                region:SetVertexColor(0, 0, 0, 0)
            end
        end
    end
end

-- ========================================
-- 核心函数：美化图标
-- ========================================

function RS:SkinIcon(iconTexture, parentButton)
    if not iconTexture then return end
    
    -- 1. 切边：裁剪约15%边缘（放大效果）
    local coords = CFG.iconCoords
    iconTexture:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
    
    -- 2. 描边：给父按钮创建黑色细边框
    if parentButton then
        if not parentButton.SetBackdrop then
            Mixin(parentButton, BackdropTemplateMixin)
        end
        
        parentButton:SetBackdrop({
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            edgeSize = 1,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        parentButton:SetBackdropBorderColor(0, 0, 0, 1) -- 黑色细边框
    end
end

-- ========================================
-- 核心函数：美化 ScrollFrame（滚动框）
-- ========================================

function RS:SkinScrollFrame(scrollFrame)
    if not scrollFrame then return end
    
    -- 无延迟，立即执行
    for i = 1, scrollFrame:GetNumRegions() do
        local region = select(i, scrollFrame:GetRegions())
        if region and region:GetObjectType() == "Texture" then
            region:SetTexture("Interface\\Buttons\\WHITE8X8")
            region:SetVertexColor(0, 0, 0, 0)
        end
    end
end

-- ========================================
-- 皮肤引擎初始化完成
-- ========================================


