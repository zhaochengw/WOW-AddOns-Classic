local lib, oldminor = LibStub:NewLibrary("tekKonfig-Dropdown", 4)
if not lib then return end
oldminor = oldminor or 0

local GameTooltip = GameTooltip
local function HideTooltip() GameTooltip:Hide() end
local function ShowTooltip(self)
	if self.frame.tiptext then
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
		GameTooltip:SetText(self.frame.tiptext, nil, nil, nil, nil, true)
	end
end
local function ShowTooltip2(self) ShowTooltip(self.container) end

local function OnClick(self)
    local dropDownFrame = self:GetParent()
    
    -- 在MOP 5.5.3版本中，ToggleDropDownMenu的参数格式可能有所不同
    -- 尝试使用更兼容的方式调用
    local success = pcall(ToggleDropDownMenu, 1, nil, dropDownFrame, nil, nil, nil, dropDownFrame.menuList)
    
    if not success then
        -- 如果调用失败，尝试使用更简单的参数
        pcall(ToggleDropDownMenu, 1, nil, dropDownFrame)
    end
    
    -- 播放点击音效
    if type(PlaySound) == "function" then
        pcall(PlaySound, 856) -- 856是IG_MAINMENU_OPTION_CHECKBOX_ON的soundKitID
    end
end

local function OnHide() CloseDropDownMenus() end

-- Create a dropdown.
-- All args optional, parent recommended
function lib.new(parent, label, ...)
    local container = CreateFrame("Button", nil, parent)
    container:SetWidth(149+13) container:SetHeight(32+24)
    container:SetScript("OnEnter", ShowTooltip)
    container:SetScript("OnLeave", HideTooltip)
    if select("#", ...) > 0 then container:SetPoint(...) end

    -- 为下拉菜单生成唯一名称
    local name = "tekKonfigDropdown" .. GetTime() .. math.random(1000)
    
    -- 创建下拉菜单框架，使用Blizzard的UIDropDownMenu模板
    local f = CreateFrame("Frame", name, parent, "UIDropDownMenuTemplate")
    f:SetPoint("TOPLEFT", container, -13, -24)
    f:EnableMouse(true)
    f:SetScript("OnHide", OnHide)
    container.frame = f

    -- 设置下拉菜单的基本属性
    f.level = 1
    f.which = name
    
    -- 设置菜单宽度
    UIDropDownMenu_SetWidth(f, 149)
    
    -- 设置下拉箭头按钮
    local button = _G[name .. "Button"]
    if button then
        button:SetScript("OnClick", OnClick)
        button:SetScript("OnEnter", ShowTooltip2)
        button.container = container
    end
    
    -- 设置下拉文本
    local text = _G[name .. "Text"]
    if text then
        text:SetJustifyH("RIGHT")
        text:SetPoint("RIGHT", name .. "Button", "LEFT", 0, 2)
    end
    
    -- 创建标签
    local labeltext = f:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
    labeltext:SetPoint("BOTTOMLEFT", container, "TOPLEFT", 16-13, 3-24)
    labeltext:SetText(label)

    return f, text, container, labeltext
end
