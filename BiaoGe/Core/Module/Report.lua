if BG.IsBlackListPlayer then return end
local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local RGB_16 = ns.RGB_16
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local GetText_T = ns.GetText_T
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local pt = print
local RealmId = GetRealmID()
local player = BG.playerName

BG.Init(function()
    BiaoGe.Report = nil
    -- 举报完成时
    BG.RegisterEvent("REPORT_PLAYER_RESULT", function(self, event)
        if BiaoGe.options["report"] ~= 1 then return end
        HideUIPanel(ReportFrame)
    end)
end)
