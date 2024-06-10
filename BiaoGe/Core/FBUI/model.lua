local _, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local TongBao = ADDONSELF.TongBao
local XiaoFei = ADDONSELF.XiaoFei
local Classpx = ADDONSELF.Classpx
local WCLpm = ADDONSELF.WCLpm
local WCLcolor = ADDONSELF.WCLcolor
local Trade = ADDONSELF.Trade
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local BossNum = ADDONSELF.BossNum
local FrameHide = ADDONSELF.FrameHide

local pt = print

BG.bossModels = {}
local buttons = {}
local CreateAllTestButton
do
    local function OnClick(self)
        local func_get = self.func_get
        local func_set = self.func_set
        local deltaPitch

        if self._type3 then
            if self._type == "+" then
                deltaPitch = 0.5
            else
                deltaPitch = -0.5
            end

            local z, x, y = func_get(self.owner)
            if self._type3 == "z" then
                z = z + deltaPitch
            end
            if self._type3 == "x" then
                x = x + deltaPitch
            end
            if self._type3 == "y" then
                y = y + deltaPitch
            end
            func_set(self.owner, z, x, y)
            pt(self._type2 .. ": " .. z .. " " .. x .. " " .. y)
        else
            if self._type == "+" then
                deltaPitch = 0.05
            else
                deltaPitch = -0.05
            end
            local currentPitch = func_get(self.owner)
            local newPitch = currentPitch + deltaPitch
            func_set(self.owner, newPitch)
            pt(self._type2 .. ": " .. newPitch)
        end
    end
    local function OnMouseDown(self)
        local t = 0
        local t_do = 0.3
        self:SetScript("OnUpdate", function(self, elapsed)
            t = t + elapsed
            if t >= t_do then
                t = t_do - 0.1
                OnClick(self)
            end
        end)
    end
    local function OnMouseUp(self)
        self:SetScript("OnUpdate", nil)
    end
    local function OnEnter(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self._type2, 1, 1, 1, true)
        GameTooltip:Show()
    end
    local function CreateButton(model, _type2, func_get, func_set, _type3)
        local tbl = { "+", "-" }
        for i = 1, 2 do
            local bt = CreateFrame("Button", nil, BG.MainFrame, "UIPanelButtonTemplate")
            bt:SetSize(40, 25)
            if not buttons[1] then
                bt:SetPoint("BOTTOMLEFT", BG.MainFrame, "TOPLEFT", 0, 2)
            else
                if i == 2 then
                    bt:SetPoint("LEFT", buttons[#buttons], "RIGHT", 0, 0)
                else
                    bt:SetPoint("LEFT", buttons[#buttons], "RIGHT", 5, 0)
                end
            end
            bt.owner = model
            bt._type = tbl[i]
            bt._type2 = _type2
            bt.func_get = func_get
            bt.func_set = func_set
            bt._type3 = _type3
            bt:SetText(tbl[i])
            bt:SetScript("OnClick", OnClick)
            bt:SetScript("OnEnter", OnEnter)
            bt:SetScript("OnLeave", GameTooltip_Hide)
            bt:SetScript("OnMouseDown", OnMouseDown)
            bt:SetScript("OnMouseUp", OnMouseUp)
            tinsert(buttons, bt)
        end
    end
    CreateAllTestButton = function(model)
        CreateButton(model, L["水平"], model.GetFacing, model.SetFacing)
        CreateButton(model, L["仰角"], model.GetPitch, model.SetPitch)
        CreateButton(model, L["侧倾"], model.GetRoll, model.SetRoll)
        CreateButton(model, L["位置z"], model.GetPosition, model.SetPosition, "z")
        CreateButton(model, L["位置x"], model.GetPosition, model.SetPosition, "x")
        CreateButton(model, L["位置y"], model.GetPosition, model.SetPosition, "y")

        model:SetBackdrop({
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 2,
        })
        BG.lastModel = model
    end
end

local function UpdateModel(model, NPCID)
    model:SetScript("OnShow", function(self)
        model:SetCreature(NPCID)
    end)
end

-- BOSS模型
local function CreateBossModel(FB, bossnum, point_x, point_y, NPCID, scale, PortraitZoom, CamDistanceScale)
    local model = CreateFrame("PlayerModel", nil, BG["Frame" .. FB], "BackdropTemplate")
    model:SetSize(500, 500)
    model:SetPoint("CENTER", BG.Frame[FB]["boss" .. bossnum].name, "CENTER", point_x, point_y)
    model:SetFrameLevel(101)
    model:SetAlpha(0.8)
    model:SetCreature(NPCID)
    model:SetScale(scale or 1)
    model:SetPortraitZoom(PortraitZoom or 0)
    model:SetCamDistanceScale(CamDistanceScale or 1)
    model:SetScript("OnShow", function(self)
        model:SetCreature(NPCID)
    end)
    tinsert(BG.bossModels, model)
    return model
end
function BG.CreateBossModel()
    if BG.IsVanilla_60() then
        local model = CreateBossModel("MC", 10, 0, -10, 11502, 1)
        model:SetPosition(-30, 0, -7) -- Z,X,Y
        model:SetFacing(-0.3)         -- 左右
        model:SetPitch(0)             -- 上下
        model:SetRoll(0)              -- 倾斜
        local model = CreateBossModel("BWL", 8, 50, 0, 11583, 1)
        model:SetPosition(-50, 0, 60)
        model:SetFacing(-0.6)
        model:SetPitch(0.8)
        model:SetRoll(-0.5)
        local model = CreateBossModel("ZUG", 10, 0, 10, 14834, 1)
        model:SetPosition(15, -2.5, -1)
        model:SetFacing(-0.5)
        model:SetPitch(0.1)
        model:SetRoll(0)
        local model = CreateBossModel("AQL", 6, 5, 30, 15339, 1)
        model:SetPosition(-7, 0, 5)
        model:SetFacing(-0.3)
        model:SetPitch(0.5)
        model:SetRoll(-0.12)
        local model = CreateBossModel("TAQ", 9, 10, 0, 15727, 0.6) -- 底下
        model:SetPosition(-8, 0, -5)
        model:SetFacing(0)
        model:SetPitch(0)
        model:SetRoll(0)
        local model = CreateBossModel("TAQ", 9, 0, 0, 15589, 0.8) -- 眼睛
        model:SetPosition(-37, 0, -3)
        model:SetFacing(0)
        model:SetPitch(0)
        model:SetRoll(0)
        local model = CreateBossModel("NAXX", 15, -15, -130, 15990, 1.2)
        model:SetPosition(-16, 0, 9.5)
        model:SetFacing(-0.3)
        model:SetPitch(0.3)
        model:SetRoll(-0.1)
        -- CreateAllTestButton(model)
    elseif BG.IsVanilla_Sod() then
        local model = CreateBossModel("BD", 7, 80, -10, 213334, 0.5)
        model:SetPosition(0, 0, 0) -- Z,X,Y
        model:SetFacing(0)         -- 左右
        model:SetPitch(0)          -- 上下
        model:SetRoll(0)           -- 倾斜
        -- CreateAllTestButton(model)
        local model = CreateBossModel("Gno", 6, -20, -30, 7800, 0.8)
        model:SetPosition(-4, 0, 1)
        model:SetFacing(-0.4)
        model:SetPitch(0.15)
        model:SetRoll(0)
        -- CreateAllTestButton(model)
        local model = CreateBossModel("Temple", 8, 5, -65, 8443, 0.85)
        model:SetPosition(-20, 0, 2)
        model:SetFacing(-0.2)
        model:SetPitch(0.15)
        model:SetRoll(0)
        -- CreateAllTestButton(model)
    elseif BG.IsWLK() then
        local model = CreateBossModel("ICC", 12, 0, -70, 31301, 0.5)
        model:SetPosition(0, 0, 0) -- Z,X,Y
        model:SetFacing(0)         -- 左右
        model:SetPitch(0)          -- 上下
        model:SetRoll(0)           -- 倾斜
        -- CreateAllTestButton(model)

        local model = CreateBossModel("TOC", 5, 10, -20, 34564, 0.6)
        model:SetPosition(-4, 0, 0)
        model:SetFacing(0)
        model:SetPitch(0)
        model:SetRoll(0)
        -- CreateAllTestButton(model)

        local model = CreateBossModel("ULD", 14, 0, 0, 32871, 0.45)
        model:SetPosition(0, 0, 0)
        model:SetFacing(0)
        model:SetPitch(0)
        model:SetRoll(0)
        -- CreateAllTestButton(model)

        local model = CreateBossModel("NAXX", 15, 0, -170, 15990, 1.7)
        model:SetPosition(-16, 0, 9.5)
        model:SetFacing(-0)
        model:SetPitch(0.3)
        model:SetRoll(0)
        -- CreateAllTestButton(model)
    elseif BG.IsCTM() then
        local model = CreateBossModel("BOT", 5, 50, 90, 45213, 0.8)
        model:SetPosition(-2, 0, 0) -- Z,X,Y
        model:SetFacing(-0.1)       -- 左右
        model:SetPitch(0)           -- 上下
        model:SetRoll(0)            -- 倾斜
        -- CreateAllTestButton(model)
        local model = CreateBossModel("BWD", 6, 70, -30, 41376, 0.8)
        model:SetPosition(-8, 0, 0) -- Z,X,Y
        model:SetFacing(-0.4)       -- 左右
        model:SetPitch(0)           -- 上下
        model:SetRoll(0)            -- 倾斜
        -- CreateAllTestButton(model)
        local model = CreateBossModel("TOF", 2, 0, -10, 46753, 0.75)
        model:SetPosition(-20, 0, 0) -- Z,X,Y
        model:SetFacing(0)           -- 左右
        model:SetPitch(0)            -- 上下
        model:SetRoll(0)             -- 倾斜
        -- CreateAllTestButton(model)
    end
end

--[[
-- BG.After(1, function()
--     for i = 0, 200 do
--         if model:HasAnimation(i) then
--             pt(i)
--         end
--     end
-- end)
-- model:SetAnimation(1)
-- model:FreezeAnimation(1, 0, 60000)
-- BG.model = model

/run BG.model:SetAnimation(52)
/run BG.model:RefreshCamera()
 ]]


-- local model = CreateFrame("DressUpModel", nil, UIParent, "ModelWithControlsTemplate")
-- model:SetSize(300, 300)
-- model:SetPoint("CENTER")
-- model:SetCreature(15727)
