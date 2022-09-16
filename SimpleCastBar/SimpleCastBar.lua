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
