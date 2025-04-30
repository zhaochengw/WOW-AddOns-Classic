
-- threeDimensionsCode.lua 客户端通讯
-- @Date   : 07/02/2024, 10:01:07 AM
--
---@type ns
local ns = select(2, ...)

if bit == nil and bit32 ~= nil then
    bit = bit32
end

local PAD_WIDTH = GetScreenWidth()
local PAD_HEIGHT = 10

local ThreeDimensionsCode = {}
ThreeDimensionsCode.__index = ThreeDimensionsCode

function ThreeDimensionsCode:new()
    local self = setmetatable({}, ThreeDimensionsCode)
    self.outputDataMaxlen = bit.bor(bit.lshift(255, 8), 255)
    self.padWriteIndex = 0
    self.commandID = math.random(0, 1000)
    self.createdFrames = false
    self.addonHasLoaded = false
    self.loadedAddOns = 0
    self.realScreenWidth = -1
    self.startTime = time()
    return self
end

function ThreeDimensionsCode:createFrames()
    --[[@debug@
    print("Creating frames...")
    --@end-debug@]]
    self.blackboard = CreateFrame("frame", "ThreeDimensionsCode", nil)
    self.blackboard:SetPoint("TOPLEFT", 0, 0)
    self.blackboard:SetWidth(PAD_WIDTH)
    self.blackboard:SetHeight(PAD_HEIGHT)
    self.blackboard:SetFrameStrata("TOOLTIP")
    self.blackboard:SetFrameLevel(128)
    self.blackboard:Show()

    self.blackboard.setReadScreenWidth = function(width)
        self.realScreenWidth = width
        self.blackboard:SetScale((GetScreenWidth() * UIParent:GetEffectiveScale()) / self.realScreenWidth)
        self:keepAlive()
        --[[@debug@
        print("new width:", (GetScreenWidth() * UIParent:GetEffectiveScale()), "/", self.realScreenWidth)
        --@end-debug@]]
    end

    self:createSignalFrames()
end

function ThreeDimensionsCode:createSignalFrames()
    local signals = {
        keepAlive = { 20 / 255, 14 / 255, 63 / 255, 1 },
        desireWidth = { 82 / 255, 10 / 255, 11 / 255, 1 },
        receiving = { 198 / 255, 31 / 255, 112 / 255, 1 },
    }

    local function createSignalFrame(name, pos)
        local frame = CreateFrame("frame", name, nil)
        frame:SetWidth(2)
        frame:SetHeight(2)
        frame:SetPoint(pos, 0, 0)
        frame.texture = frame:CreateTexture(nil, "BACKGROUND")
        return frame
    end

    self.frmSignalLampA = createSignalFrame("ThreeDimensionsCode_SignalLampA", "BOTTOMLEFT")
    self.frmSignalLampB = createSignalFrame("ThreeDimensionsCode_SignalLampB", "BOTTOMRIGHT")
    self.frmSignalLampA:SetFrameLevel(128)
    self.frmSignalLampB:SetFrameLevel(128)

    self.signalLamp = {
        keepAlive = function()
            if self.realScreenWidth < 0 then
                self.signalLamp.desireWidth()
            else
                self.frmSignalLampA.texture:SetColorTexture(unpack(signals.keepAlive))
                self.frmSignalLampA.texture:SetAllPoints(self.frmSignalLampA)
                self.frmSignalLampB.texture:SetColorTexture(unpack(signals.keepAlive))
                self.frmSignalLampB.texture:SetAllPoints(self.frmSignalLampB)
            end
        end,
        desireWidth = function()
            self.frmSignalLampA.texture:SetColorTexture(unpack(signals.desireWidth))
            self.frmSignalLampA.texture:SetAllPoints(self.frmSignalLampA)
            self.frmSignalLampB.texture:SetColorTexture(unpack(signals.desireWidth))
            self.frmSignalLampB.texture:SetAllPoints(self.frmSignalLampB)
        end,
        receiving = function()
            self.frmSignalLampA.texture:SetColorTexture(unpack(signals.receiving))
            self.frmSignalLampA.texture:SetAllPoints(self.frmSignalLampA)
            self.frmSignalLampB.texture:SetColorTexture(unpack(signals.receiving))
            self.frmSignalLampB.texture:SetAllPoints(self.frmSignalLampB)
        end,
        hide = function()
            self.frmSignalLampA:Hide()
            self.frmSignalLampB:Hide()
        end,
        show = function()
            self.frmSignalLampA:Show()
            self.frmSignalLampB:Show()
        end,
    }
end

function ThreeDimensionsCode:keepAlive()
    -- implement keepAlive logic here
    local signalLamp = self.signalLamp
    if signalLamp then
        signalLamp.keepAlive()
    end
end

function ThreeDimensionsCode:send(data)
    if not self.blackboard then
        --[[@debug@
        print("Error: Blackboard not created!")
        --@end-debug@]]
        return
    end

    self.padWriteIndex = 0
    data = string.sub(data, 1, self.outputDataMaxlen)
    local pixel = self:PixelPrototype()

    local len = #data
    local lowbit = bit.band(len, 255)
    local hightbit = bit.rshift(len, 8)

    pixel:pushbyte(bit.rshift(self.commandID, 8))
    pixel:pushchar("1")
    pixel:pushbyte(bit.band(self.commandID, 255))
    pixel:pushbyte(lowbit)
    pixel:pushchar("9")
    pixel:pushbyte(hightbit)

    for i = 1, #data do
        local char = string.sub(data, i, i)
        pixel:pushchar(char)
    end

    pixel:pushchar("8")
    pixel:pushchar("2")
    pixel:flush()

    self.commandID = self.commandID + 1
    if self.commandID > 65535 then
        self.commandID = 0
    end
end

function ThreeDimensionsCode:PixelPrototype()
    local pixel = {}
    pixel.__index = pixel

    function pixel:new()
        local self = setmetatable({}, pixel)
        return self
    end

    function pixel:pushchar(char)
        self:pushbyte(string.byte(char))
    end

    function pixel:pushbyte(byte)
        table.insert(self, byte)
        if #self >= 3 then
            self:flush()
        end
    end

    function pixel:flush()
        if not ns.ThreeDimensionsCode.blackboard then
            --[[@debug@
            print("Error: Blackboard not created in PixelPrototype!")
            --@end-debug@]]
            return
        end

        local p
        local ps = { ns.ThreeDimensionsCode.blackboard:GetChildren() }

        if #ps <= ns.ThreeDimensionsCode.padWriteIndex then
            p = CreateFrame("frame", "ThreeDimensionsCode_Pixel", ns.ThreeDimensionsCode.blackboard)
            p:SetWidth(1)
            p:SetHeight(1)
            local x = ns.ThreeDimensionsCode.padWriteIndex % PAD_WIDTH
            local y = math.floor(ns.ThreeDimensionsCode.padWriteIndex / PAD_WIDTH)

            p:SetPoint("TOPLEFT", x, y)
            p:Show()
            p.texture = p:CreateTexture(nil, "BACKGROUND")
        else
            p = ps[ns.ThreeDimensionsCode.padWriteIndex + 1]
        end

        p.texture:SetColorTexture(self:color(1), self:color(2), self:color(3), 1)
        p.texture:SetAllPoints(p)

        ns.ThreeDimensionsCode.padWriteIndex = ns.ThreeDimensionsCode.padWriteIndex + 1

        for k, v in pairs(self) do
            self[k] = nil
        end
    end

    function pixel:color(bit)
        if self[bit] == nil then
            return 0
        else
            return self[bit] / 255
        end
    end

    return pixel:new()
end

function ThreeDimensionsCode:sendCommand(cmd, data)
    if data == nil then data = "" end
    self:send(cmd .. ":" .. data)
end

function ThreeDimensionsCode:onEvent(event, addonName)
    if event == "ADDON_LOADED" and addonName:sub(1, 9) ~= "Blizzard_" then
        self.loadedAddOns = self.loadedAddOns + 1
        if self.loadedAddOns >= self.enabledAddOns and not self.addonHasLoaded then
            self:allAddOnsLoaded()
        end
    end
end

function ThreeDimensionsCode:onUpdate(elapsed)
    if time() - self.startTime >= 3 and not self.addonHasLoaded then
        self:allAddOnsLoaded()
    end
end

function ThreeDimensionsCode:allAddOnsLoaded()
    self.addonHasLoaded = true
    if not self.createdFrames then
        self:createFrames()
        self.createdFrames = true
        self:keepAlive()
    end
end

function ThreeDimensionsCode:initialize()
    -- 查看一共多少插件
    self.enabledAddOns = 0
    for i = 1, GetNumAddOns() do
        local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
        if enabled and not IsAddOnLoadOnDemand(i) then
            self.enabledAddOns = self.enabledAddOns + 1
        end
    end

    -- 注册事件
    local frame = CreateFrame("frame","3DCodeCmdInit",UIParent)
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(_, event, addonName)
        self:onEvent(event, addonName)
    end)

    frame:SetScript("OnUpdate", function(_, elapsed)
        self:onUpdate(elapsed)
    end)

    frame:SetFrameStrata("TOOLTIP")
    frame:SetFrameLevel(128)
    frame:EnableKeyboard(true)
    frame:SetPropagateKeyboardInput(true);
    frame.PropagateKeyboardInput = true
    C_Timer.After(2, function()
        ns.Addon.db.global.newShortcutKey =  ns.FindFirstTwoUnboundKeys()
    end)
    frame:SetScript("OnKeyDown", function(_, event, ...)
        if not ns.Addon.db.global.newShortcutKey then
            return
        end
        local key1, key2 = ns.Addon.db.global.newShortcutKey[1], ns.Addon.db.global.newShortcutKey[2]
        if not key1 or not key2 then
            return
        end
        local modifier1, key1Pressed = key1:match("^(%w+)%-(.+)$")
        if modifier1 and key1Pressed then
            if (modifier1 == "SHIFT" and IsShiftKeyDown()) or
                (modifier1 == "CTRL" and IsControlKeyDown()) or
                (modifier1 == "ALT" and IsAltKeyDown()) then
                if event == key1Pressed then
                    ThreeDimensionsCode_Savepipe_Yin()
                    return
                end
            end
        end

        local modifier2, key2Pressed = key2:match("^(%w+)%-(.+)$")
        if modifier2 and key2Pressed then
            if (modifier2 == "SHIFT" and IsShiftKeyDown()) or
                (modifier2 == "CTRL" and IsControlKeyDown()) or
                (modifier2 == "ALT" and IsAltKeyDown()) then
                if event == key2Pressed then
                    ThreeDimensionsCode_Savepipe_Yang()
                    return
                end
            end
        end
        if IsAltKeyDown() and (event == "PAGEUP" or event == "PAGEDOWN") then
            if event == "PAGEDOWN" then
                ThreeDimensionsCode_Savepipe_Yin()
            elseif event == "PAGEUP" then
                ThreeDimensionsCode_Savepipe_Yang()
            end
        end
    end)

    -- 检查是否已经加载了所有插件
    self:start()
end

function ThreeDimensionsCode:start()
    self.startTime = time()
end

-- 实例化并初始化ThreeDimensionsCode类
local threeDimensionsCode = ThreeDimensionsCode:new()
threeDimensionsCode:initialize()
ns.ThreeDimensionsCode = threeDimensionsCode
