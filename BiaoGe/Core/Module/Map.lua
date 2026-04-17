if BG.IsBlackListPlayer then return end
if not (BG.IsWLK or BG.IsMOP) then return end
local _, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local Maxb = ns.Maxb
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local pt = print

local channel = "BiaoGeReceive"
C_ChatInfo.RegisterAddonMessagePrefix(channel)

local _, class = UnitClass("player")
local r, g, b, cff = GetClassColor(class)

local channel = "BiaoGeAIMap"
C_ChatInfo.RegisterAddonMessagePrefix(channel)

BG.Init(function()
    BiaoGe.options.mapScale = BiaoGe.options.mapScale or .75
    BiaoGe.options.mapIconScale = BiaoGe.options.mapIconScale or 1
    BiaoGe.options.mapFrameLevel = BiaoGe.options.mapFrameLevel or "MEDIUM"

    BiaoGe.maps = BiaoGe.maps or {}
    if BiaoGe.lastMapCode then
        tinsert(BiaoGe.maps, 1, { code = BiaoGe.lastMapCode })
        BiaoGe.lastMapCode = nil
    end

    local maxDB = 10
    local mapIndex = 1

    local GetDropDownText, UpdateDropDownText

    local function UpdateMapDB()
        while #BiaoGe.maps > maxDB do
            tremove(BiaoGe.maps, #BiaoGe.maps)
        end
    end
    UpdateMapDB()

    function BG.ShowMap()
        local code = BiaoGe.maps[mapIndex] and BiaoGe.maps[mapIndex].code
        if code then
            BG.BuildMapByCode(code, true)
            UpdateDropDownText()
        else
            BG.SendSystemMessage(L["缺少站位图数据，无法显示。"])
        end
    end

    local bt = CreateFrame("Button", nil, BG.MainFrame)
    do
        bt:SetPoint("LEFT", BG.ButtonGuoQi, "RIGHT", BG.TopLeftButtonJianGe, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(L["站位图"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        BG.ButtonMap = bt
        bt:SetScript("OnClick", function(self)
            if BG.MapFrame:IsVisible() then
                BG.MapFrame:Hide()
            else
                BG.ShowMap()
            end
            BG.PlaySound(1)
        end)
        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["显示团长上次发送的站位图。"], 1, 0.82, 0, true)
            GameTooltip:AddLine(L["团长需使用BiaoGeAI插件才能发送站位图。"], 1, 0.82, 0, true)
            GameTooltip:AddLine(L["快捷命令：/bgmap 或 /aimap"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", GameTooltip_Hide)
    end

    local frameName = "BG.MapFrame"
    local f = CreateFrame("Frame", frameName, UIParent, "BackdropTemplate")
    do
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        f:SetBackdropColor(0, 0, 0, 0)
        f:SetBackdropBorderColor(0, 0, 0, 1)
        f:SetSize(450, 450)
        f:SetClampedToScreen(true)
        f:EnableMouse(true)
        f:SetMovable(true)
        f:SetFrameStrata(BiaoGe.options.mapFrameLevel)
        f:SetToplevel(true)
        f:Hide()
        f.defaultPoint = { "TOPLEFT", 0, 0 }
        f:SetScale(BiaoGe.options.mapScale)
        if BiaoGe.point[frameName] then
            BiaoGe.point[frameName][2] = nil
            f:SetPoint(unpack(BiaoGe.point[frameName]))
        else
            f:SetPoint(unpack(f.defaultPoint))
        end
        f.icons = {}
        BG.MapFrame = f

        local tex = f:CreateTexture()
        tex:SetPoint("TOPLEFT", 1, -1)
        tex:SetPoint("BOTTOMRIGHT", -1, 1)
        f.mapTex = tex

        f:SetScript("OnMouseDown", function(self)
            self:StartMoving()
        end)
        f:SetScript("OnMouseUp", function(self, enter)
            self:StopMovingOrSizing()
            if enter == "RightButton" then
                f:ClearAllPoints()
                f:SetPoint(unpack(f.defaultPoint))
            end
            BiaoGe.point[frameName] = { f:GetPoint(1) }
        end)
        f:SetScript("OnEnter", function(self)
            f.isOnEnter = true
        end)
        f:SetScript("OnLeave", function(self)
            f.isOnEnter = nil
        end)
        f.t = 0
        f:SetScript("OnUpdate", function(self, t)
            if self.isOnEnter then
                self.CloseButton:Show()
                self.t = 0
            else
                self.t = self.t + t
                if self.t >= 0.05 then
                    self.t = 0
                    if not self.isOnEnter then
                        self.CloseButton:Hide()
                    end
                end
            end
        end)

        f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
        f.CloseButton:SetPoint("TOPRIGHT", f, "TOPRIGHT", 2, 2)
        f.CloseButton:SetSize(40, 40)
        f.CloseButton:Hide()
        f.CloseButton:HookScript("OnEnter", BG.MapFrame:GetScript("OnEnter"))
        f.CloseButton:HookScript("OnLeave", BG.MapFrame:GetScript("OnLeave"))

        local bt = CreateFrame("Button", nil, f.CloseButton)
        bt:SetSize(25, 25)
        bt:SetNormalTexture([[Interface\Buttons\UI-OptionsButton]])
        bt:SetHighlightTexture([[Interface\Buttons\UI-OptionsButton]])
        bt:SetPoint("RIGHT", f.CloseButton, "LEFT", 0, 0)
        bt:RegisterForClicks("AnyUp")
        bt:SetScript("OnClick", function(self)
            ns.InterfaceOptionsFrame_OpenToCategory(BG.optionsName)
            BG.ButtonOptions_map:Click()
        end)
        bt:HookScript("OnEnter", BG.MapFrame:GetScript("OnEnter"))
        bt:HookScript("OnLeave", BG.MapFrame:GetScript("OnLeave"))
    end

    local dropDown = LibBG:Create_UIDropDownMenu(nil, f.CloseButton)
    do
        dropDown:SetPoint("TOPLEFT", f, "TOPLEFT", -14, -1)
        dropDown:SetScale(1.1)
        LibBG:UIDropDownMenu_SetWidth(dropDown, 250)
        LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "TOPLEFT", dropDown, "BOTTOMLEFT")
        BG.dropDownToggle(dropDown)
        f.dropDown = dropDown
        dropDown:HookScript("OnEnter", BG.MapFrame:GetScript("OnEnter"))
        dropDown:HookScript("OnLeave", BG.MapFrame:GetScript("OnLeave"))

        function UpdateDropDownText()
            LibBG:UIDropDownMenu_SetText(dropDown, GetDropDownText())
        end

        function GetDropDownText(index)
            index = index or mapIndex
            local v = BiaoGe.maps[index]
            if v and v.time and v.sender and v.FB and v.bossIndex then
                -- local time = date("%m-%d %H:%M:%S", v.time) or ""
                local time = date("%H:%M:%S", v.time) or ""
                local sender = v.sender
                local bossName = BG.Boss[v.FB]
                    and BG.Boss[v.FB]["boss" .. v.bossIndex]
                    and BG.Boss[v.FB]["boss" .. v.bossIndex].name2 or ""
                return L["%s %s %s"]:format(time, sender, bossName)
            else
                return L["站位图"]
            end
        end

        LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
            for i, v in ipairs(BiaoGe.maps) do
                local info = LibBG:UIDropDownMenu_CreateInfo()
                info.text = GetDropDownText(i)
                info.checked = LibBG:UIDropDownMenu_GetText(dropDown) == info.text
                info.func = function()
                    mapIndex = i
                    UpdateDropDownText()
                    local code = BiaoGe.maps[mapIndex] and BiaoGe.maps[mapIndex].code
                    if code then
                        BG.BuildMapByCode(code, true)
                    end
                end
                LibBG:UIDropDownMenu_AddButton(info)
            end
        end)

        L_DropDownList1:HookScript("OnEnter", function(self)
            if L_DropDownList1.dropdown ~= dropDown then return end
            BG.MapFrame:GetScript("OnEnter")()
        end)
        L_DropDownList1:HookScript("OnLeave", function(self)
            if L_DropDownList1.dropdown ~= dropDown then return end
            BG.MapFrame:GetScript("OnLeave")()
        end)
        for i = 1, L_UIDROPDOWNMENU_MAXBUTTONS do
            local button = _G["L_DropDownList1Button" .. i]
            button:HookScript("OnEnter", function()
                if L_DropDownList1.dropdown ~= dropDown then return end
                BG.MapFrame:GetScript("OnEnter")()
            end)
            button:HookScript("OnLeave", function()
                if L_DropDownList1.dropdown ~= dropDown then return end
                BG.MapFrame:GetScript("OnLeave")()
            end)
        end
    end

    function BG.UpdateMapIconScale()
        local value = BiaoGe.options.mapIconScale
        for i, icon in ipairs(BG.MapFrame.icons) do
            icon:SetScale(value)
            icon:SetPoint("CENTER", icon:GetParent(), "TOPLEFT",
                icon.x / value, icon.y / value)
        end
    end

    local receiveStart = {}
    local receiveCodes = {}

    local function CreateMapIcon(FB, level, x, y, width, height, iconType, iconTex, coord, broderShow, broderColor, numText, numColor, playerText, playerColor)
        local f = CreateFrame("Frame", nil, BG.MapFrame)
        local value = BiaoGe.options.mapIconScale
        f:SetSize(width, height)
        f:SetScale(value)
        f:SetFrameLevel(BG.MapFrame:GetFrameLevel() + level)
        f:SetPoint("CENTER", f:GetParent(), "TOPLEFT", x / value, y / value)
        f.x = x
        f.y = y

        local mask = f:CreateMaskTexture()
        mask:SetPoint("CENTER")
        mask:SetSize(width - 4, width - 4)
        mask:SetTexture([[Interface\CharacterFrame\TempPortraitAlphaMask]], "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")

        local icon = f:CreateTexture()
        icon:SetPoint("CENTER")
        icon:SetSize(width + 6, width + 6)
        if iconType == "boss" then
            icon:SetTexture(format("Interface\\AddOns\\BiaoGe\\Media\\icon\\%s\\%s.png", FB, iconTex))
        elseif iconType == "tex" then
            icon:SetTexture((iconTex))
        elseif iconType == "atlas" then
            icon:SetAtlas((iconTex))
        end
        if coord then
            icon:SetTexCoord(unpack(coord))
        end

        local broder = f:CreateTexture()
        broder:SetAllPoints()
        broder:SetTexture([[Interface\AddOns\BiaoGe\Media\icon\broder.png]])
        broder:SetVertexColor(unpack(broderColor))
        if broderShow == 0 then
            broder:Hide()
        else
            icon:AddMaskTexture(mask)
        end

        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("CENTER", 1, 0)
        t:SetText(numText)
        t:SetTextColor(unpack(numColor))
        f.numText = t

        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("TOP", f, "BOTTOM", 0, 0)
        t:SetText(playerText)
        t:SetTextColor(unpack(playerColor))
        if playerText ~= "" then
            f.numText:SetText("")
        end

        tinsert(BG.MapFrame.icons, f)
    end

    function BG.BuildMapByCode(code, notSave, sender)
        local str
        if not ns.IsBase64(code) then
            return
        end
        str = C_EncodingUtil.DecompressString(ns.Decode(code))
        local info, icons = BG.Split("^^", str)
        local FB, bossIndex, mapWidth, mapHeight = BG.Split("&&", info)
        bossIndex = tonumber(bossIndex)
        mapWidth = tonumber(mapWidth)
        mapHeight = tonumber(mapHeight)
        if FB and bossIndex and mapWidth and mapHeight then
            local mapTex = format("Interface\\AddOns\\BiaoGe\\Media\\icon\\%s\\m%s.png", FB, bossIndex)
            local tex = UIParent:CreateTexture()
            tex:SetPoint("CENTER")
            tex:SetSize(10, 10)
            tex:SetTexture(mapTex)
            tex:Hide()
            if not tex:GetTexture() then
                return
            end
            if not notSave then
                local codeInfo = {}
                codeInfo.time = time()
                codeInfo.sender = SetClassCFF(sender)
                codeInfo.code = code
                codeInfo.FB = FB
                codeInfo.bossIndex = bossIndex
                tinsert(BiaoGe.maps, 1, codeInfo)
                UpdateMapDB()
            end
            BG.MapFrame.mapTex:SetTexture(mapTex)
            BG.MapFrame:SetSize(mapWidth, mapHeight)
            BG.MapFrame:Show()
            for i, icon in ipairs(BG.MapFrame.icons) do
                icon:Hide()
            end
            wipe(BG.MapFrame.icons)
            for _, iconStr in ipairs({ BG.Split("&&", icons) }) do
                if iconStr and iconStr ~= "" then
                    local
                    level,
                    x,
                    y,
                    width,
                    height,
                    iconType,
                    iconTex,
                    left,
                    right,
                    top,
                    bottom,
                    broderShow,
                    broder_r,
                    broder_g,
                    broder_b,
                    numText,
                    num_r,
                    num_g,
                    num_b,
                    playerText,
                    player_r,
                    player_g,
                    player_b
                               = BG.Split("¦", iconStr)
                    level      = tonumber(level)
                    x          = tonumber(x)
                    y          = tonumber(y)
                    width      = tonumber(width)
                    height     = tonumber(height)
                    left       = tonumber(left)
                    right      = tonumber(right)
                    top        = tonumber(top)
                    bottom     = tonumber(bottom)
                    broderShow = tonumber(broderShow)
                    broder_r   = tonumber(broder_r)
                    broder_g   = tonumber(broder_g)
                    broder_b   = tonumber(broder_b)
                    num_r      = tonumber(num_r)
                    num_g      = tonumber(num_g)
                    num_b      = tonumber(num_b)
                    player_r   = tonumber(player_r)
                    player_g   = tonumber(player_g)
                    player_b   = tonumber(player_b)
                    -- pt(
                    --     x,
                    --     y,
                    --     width,
                    --     height,
                    --     iconType,
                    --     iconTex,
                    --     left,
                    --     right,
                    --     top,
                    --     bottom,
                    --     broderShow,
                    --     broder_r,
                    --     broder_g,
                    --     broder_b,
                    --     numText,
                    --     num_r,
                    --     num_g,
                    --     num_b,
                    --     playerText,
                    --     player_r,
                    --     player_g,
                    --     player_b
                    -- )
                    CreateMapIcon(
                        FB,
                        level,
                        x,
                        y,
                        width,
                        height,
                        iconType,
                        iconTex,
                        left and { left, right, top, bottom, },
                        broderShow,
                        { broder_r, broder_g, broder_b, },
                        numText,
                        { num_r, num_g, num_b, },
                        playerText,
                        { player_r, player_g, player_b }
                    )
                end
            end
            return true
        end
    end

    local function ReceiveFinish(sender)
        local code = table.concat(receiveCodes)
        code = code:match("^!AIMAP!(.+)!END!$")
        if not code then return end
        local success = BG.BuildMapByCode(code, nil, sender)
        if success then
            mapIndex = 1
            UpdateDropDownText()
        end
    end

    -- 接收数据
    BG.RegisterEvent("CHAT_MSG_ADDON", function(self, event, ...)
        local prefix, msg, distType, _, sender = ...
        if not (prefix == channel and distType == "RAID" and (UnitIsGroupLeader(sender) or UnitIsGroupAssistant(sender))) then return end
        if msg:match("^!AIMAP!") then
            receiveStart[sender] = true
            wipe(receiveCodes)
        end
        if receiveStart[sender] then
            tinsert(receiveCodes, msg)
            if msg:match("!END!$") then
                receiveStart[sender] = nil
                ReceiveFinish(sender)
            end
        end
    end)
end)
