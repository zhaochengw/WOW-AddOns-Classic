if not BG.IsWLK then return end

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
local FrameDongHua = ns.FrameDongHua
local FrameHide = ns.FrameHide
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local pt = print
local RealmId = GetRealmID()
local player = UnitName("player")
local className, classFilename, classID = UnitClass("player")

BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
    if not (isLogin or isReload) then return end
    local addonName = "AtlasLootClassic"
    if not IsAddOnLoaded(addonName) then return end

    local tbl = {
        _G["AtlasLoot-DropDown-1"],
        _G["AtlasLoot-DropDown-1-button"],
        _G["AtlasLoot-DropDown-2"],
        _G["AtlasLoot-DropDown-2-button"],
    }

    local function ClickSelectButton(id, selectFrameID, notRefresh)
        for i, SelectButton in ipairs(_G["AtlasLoot-Select-" .. (selectFrameID or 2)].obj.buttons) do
            if SelectButton.info and SelectButton.info.id == id then
                SelectButton:Click()
                if not notRefresh then
                    AtlasLoot.GUI.ItemFrame:Refresh(true)
                end
                return
            end
        end
    end
    --[[
/run for k,v in pairs(_G["AtlasLoot-Select-Button"..8].obj) do if type(k)=="string" then print(k,v) end end
 ]]
    local function SetBestChoose(self)
        -- pt(self.id)
        if BiaoGe.options["AtlasLoot_betterChoose"] ~= 1 then return end
        if AtlasLoot.db.GUI.selectedGameVersion and AtlasLoot.db.GUI.selectedGameVersion ~= 3 then return end
        if self.id == "InscriptionWrath" then
            -- 铭文
            local id
            if classFilename == "DRUID" then
                id = 3 + classID - 1
            else
                id = 3 + classID
            end
            ClickSelectButton(id)
        elseif self.id == "BlacksmithingWrath" then
            -- 锻造
            ClickSelectButton(14)
        elseif self.id == "EngineeringWrath" then
            -- 工程
            ClickSelectButton(11)
        elseif self.id == "TailoringWrath" then
            -- 裁缝
            ClickSelectButton(11)
        elseif self.id == "LeatherworkingWrath" then
            -- 制皮
            ClickSelectButton(10)
        elseif self.id == "CookingWrath" then
            -- 烹饪
            ClickSelectButton(13)
            AtlasLoot.GUI.ItemFrame:Refresh(true)
        elseif self.id == "AtlasLootClassic_DungeonsAndRaids" then
            -- 地下城和团队副本
            _G["AtlasLoot_GUI-Frame"].subCatSelect:SetSelected("Ulduar")
            ClickSelectButton(9, 1, "notRefresh")
            AtlasLoot.GUI.ItemFrame:Refresh(true)
        elseif self.id == "AtlasLootClassic_Crafting" then
            -- 专业制造
            _G["AtlasLoot_GUI-Frame"].subCatSelect:SetSelected("EnchantingWrath")
            AtlasLoot.GUI.ItemFrame:Refresh(true)
        elseif self.id == "AtlasLootClassic_Factions" then
            -- 声望
            _G["AtlasLoot_GUI-Frame"].subCatSelect:SetSelected("TheSonsofHodir")
            AtlasLoot.GUI.ItemFrame:Refresh(true)
        elseif self.id == "AtlasLootClassic_PvP" then
            -- PVP
            _G["AtlasLoot_GUI-Frame"].subCatSelect:SetSelected("ArenaS6PvP")
            AtlasLoot.GUI.ItemFrame:Refresh(true)
        elseif self.id == "AtlasLootClassic_Collections" then
            -- 藏品
            ClickSelectButton(9, nil, "notRefresh")
            ClickSelectButton(5, 1)
            AtlasLoot.GUI.ItemFrame:Refresh(true)
        end
    end
    for _, dropDownButton in ipairs(tbl) do
        dropDownButton:HookScript("OnClick", function(self)
            for i = 1, 40 do
                local Button = _G["AtlasLoot-DropDown-Button" .. i]
                if Button then
                    Button:HookScript("OnClick", function(self)
                        SetBestChoose(self)
                    end)
                end
            end
        end)
    end
end)
